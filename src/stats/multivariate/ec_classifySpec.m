function [o,n,errs,st,ob] = ec_classifySpec(o)
% Performs spectral classification and cross-classification
% within-channels/ICs/ROIs, within-timepoints, and within-subjects. 
% ROI classification uses concatenated spectral timecourses from channels
% within an ROI.
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2026
%
% OUTPUTS:
%   o = options struct
%   n = recording information struct
%   st = classifier results & statistics per independent analysis
%       (chans/ICs/ROIs x timepoints) 
%   ob = classified observations

%% Input arguments
arguments
    o struct = struct % options struct (description below in "Options struct validation" section)
end
% o.test = 1;


%% Prepare analysis data
tt = tic;                           % start timer
oo = namedargs2cell(o.p);           % expand name-value arguments
[x,ep,n] = ec_analPrep(tt,oo{:});   % run data prep


%% Classifier prep & templates
[st,ob,o] = ec_classifyPrep(n,ep,tt,o);
% st = statistics
% ob = observations


%% Split data for independent model runs
oo = namedargs2cell(o.s);
[x,n,st,ob] = ec_analSplit(x,n,st,ob,tt,oo{:}); % split by chs/ICs/ROIs x timepoints


%% Classification
[st,ob,errs] = classify_lfn(x,n,st,ob,tt,o);


%% FDR
st = fdr_lfn(st,n,o,tt);


%% Finalize

% Convert to output float precision
st = convertvars(st,varfun(@isfloat,st,"OutputFormat","uniform"),o.floatOut);
ob = convertvars(ob,varfun(@isfloat,ob,"OutputFormat","uniform"),o.floatOut);

% Remove vars
id = ismember(st.Properties.VariableNames,["cost" "cv" "cvh" "cvhn"]);
st = removevars(st,id);

% Rename vars (guard against no-op or collision with existing columns)
if o.p.timeVar~="t"
    if ismember(o.p.timeVar,string(ob.Properties.VariableNames))
        error("[ec_classifySpec] Cannot rename ob.t to '%s': column already exists.",o.p.timeVar);
    end
    ob = renamevars(ob,"t",o.p.timeVar);
    if ismember("t",string(st.Properties.VariableNames))
        st = renamevars(st,"t",o.p.timeVar);
    end
end
if o.p.condVar~="cnd"
    if ismember(o.p.condVar,string(ob.Properties.VariableNames))
        error("[ec_classifySpec] Cannot rename ob.cnd to '%s': column already exists.",o.p.condVar);
    end
    ob = renamevars(ob,"cnd",o.p.condVar);
end


%% Save
o.saved.st = fullfile(o.dirOut,"s"+n.sbjID+"_st.mat");
save(o.saved.st,"st","-v7");
disp("[ec_classifySpec] Saved classification statistics: "+o.saved.st+" toc="+toc(tt));
o.saved.ob = fullfile(o.dirOut,"s"+n.sbjID+"_ob.mat");
save(o.saved.ob,"ob","-v7");
disp("[ec_classifySpec] Saved classification observations: "+o.saved.ob+" toc="+toc(tt));
if ~isempty(errs) && any(~cellfun(@isempty,errs))
    o.saved.errs = fullfile(o.dirOut,"s"+n.sbjID+"_errs.mat");
    save(o.saved.errs,"errs","-v7");
    disp("[ec_classifySpec] Saved classification errors: "+o.saved.errs+" toc="+toc(tt));
end
%o.saved.nfo = fullfile(o.dirOut,"s"+n.sbjID+".mat");
%save(o.saved.nfo,"o","n","-v7");






function [st,ob,errs] = classify_lfn(x,n,st,ob,tt,o)
%%% Main classification routine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preallocate per-split error container (empty = success)
errs = cell(n.splits,1);


%% Classify within data splits (chans/ICs/ROIs x timepoints)
if o.gpu
    % GPU loop across splits
    for s = 1:n.splits
        try
            [st(s,:),ob{s}] = ec_classify(x{s},st(s,:),ob{s},o);
        catch ME
            errs{s} = ME;
            fprintf(2,"[ec_classifySpec] Split %d failed:\n%s\n",s,getReport(ME));
        end
    end
else
    % CPU parfor loop across splits (ideally threadpool)
    parfor s = 1:n.splits
        try
            [st(s,:),ob{s}] = ec_classify(x{s},st(s,:),ob{s},o);
        catch ME
            errs{s} = ME;
            fprintf(2,"[ec_classifySpec] Split %d failed:\n%s\n",s,getReport(ME));
        end
    end
end

%% Finalize

% Handle errors
nFail = nnz(~cellfun(@isempty,errs));
if nFail>0
    warning("[ec_classifySpec] %d of %d splits failed for %s (see errs).",nFail,n.splits,n.sbj);
else
    errs = [];
end
disp("[ec_classifySpec] Ran classifiers: "+n.sbj+" toc="+toc(tt));

% Concatenate channel results
ob = vertcat(ob{:}); % sortrows(vertcat(ob{:}),["ch" "tr" "t"],"ascend");






function st = fdr_lfn(st,n,o,tt)
%%% Run FDR correction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vs = string(st.Properties.VariableNames);
vsQ = vs(endsWith(vs,"_q")); % fdr vars
vsP = replace(vsQ,"_q","_p"); % expected matching pval vars
id = st.t>=o.fdrTimeRng(1) & st.t<=o.fdrTimeRng(2); % fdr time range

% Verify every _q has a matching _p; drop (with warning) any that don't
hasP = ismember(vsP,vs);
if ~all(hasP)
    warning("[ec_classifySpec] Skipping FDR for _q vars without matching _p: %s",...
        strjoin(vsQ(~hasP),", "));
    vsQ = vsQ(hasP);
    vsP = vsP(hasP);
end

% Loop across q vars
for v = 1:numel(vsQ)
    % Loop across var columns -- KEEP THIS??
    for w = 1:width(st.(vsQ(v)))
        % do FDR
        st.(vsQ(v))(id,w) = ec_fdr(st.(vsP(v))(id,w),...
            o.alpha,o.fdrDep);
    end
end
disp("[ec_classifySpec] Ran FDR: "+n.sbj+" toc="+toc(tt));