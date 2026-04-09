function [o,n,st,ob] = ec_classifySpec(o)
% Performs classification & cross-classification within channels/ICs/ROIs
% across time using spectral activity as features. ROI classificaiton
% concatenates timecourses from within-ROI channels. 
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2026
%
% OUTPUTS:
%   ob = classified observations
%   stat = classifier results & statistics per independent analysis
%       (chans/ICs/ROIs x timepoints) 

%% Input arguments
arguments
    o struct = struct % options struct (description below in "Options struct validation" section)
end
% o.test = 1;


%% Prepare analysis data
tt = tic; % start timer
oo = namedargs2cell(o.p);
[x,ep,n] = ec_prepAnalysis(tt,oo{:}); % analysis-specific preprocessing



%% Make classifier templates
[st,ob] = ec_classifyTemplates(n,ep,tt,o);
% st = statistics
% ob = observations


%% Split variables so splits directly go into ec_runClassifier
[x,n,st,ob] = ec_splitAnalData(x,n,st,ob,tt,o);


%% Classification
[st,ob] = classify_lfn(x,n,st,ob,tt,o);


%% Save
o.saved.st = o.dirOut+"s"+n.sbjID+"_st.mat";
save(o.saved.st,"st","-v7");
disp("[ec_classifyChSpec] Saved classificiation statistics: "+o.saved.st+" toc="+toc(tt));
o.saved.ob = o.dirOut+"s"+n.sbjID+"_ob.mat";
save(o.saved.ob,"ob","-v7");
disp("[ec_classifyChSpec] Saved classificiation observations: "+o.saved.ob+" toc="+toc(tt));
%o.saved.nfo = o.dirOut+"s"+n.sbjID+".mat";
%save(o.saved.nfo,"o","n","-v7");






%%%%%%%%%%%%%%%%%%%%%%%%%% Classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






function [st,ob] = classify_lfn(x,n,st,ob,tt,o)
%%% Initialize classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute across data splits (chans/ICs/ROIs x timepoints)
if o.gpu
    for s = 1:n.splits
        [st(s,:),ob{s}] = ec_runClassifier(x{s},st(s,:),ob{s},o);
    end
else
    parfor s = 1:n.splits
        [st(s,:),ob{s}] = ec_runClassifier(x{s},st(s,:),ob{s},o);
    end
end
disp("[ec_classifyChSpec] Ran classifiers: "+n.sbj+" toc="+toc(tt));


%% Concactenate channel results
ob = vertcat(ob{:}); % sortrows(vertcat(ob{:}),["ch" "tr" "t"],"ascend");


%% FDR
vs = string(st.Properties.VariableNames);
vsP = vs(contains(vs,"_p")); % pval vars
vsQ = vs(contains(vs,"_q")); % fdr vars
id = st.t>=o.fdrTimeRng(1) & st.t<=o.fdrTimeRng(2); % fdr time range

% Loop across q vars
for v = 1:numel(vsQ)
    % Loop across var columns -- KEEP THIS??
    for w = 1:width(st.(vsQ(v)))
        % do FDR
        st.(vsQ(v))(id,w) = ec_fdr(st.(vsP(v))(id,w),...
            o.alpha,o.fdrDep);
    end
end
disp("[ec_classifyChSpec] Ran FDR: "+n.sbj+" toc="+toc(tt));


%% Finalize
% TO DO: convert float vars to output type

% Remove vars
st = removevars(st,["cost" "cv" "cvh"]);

% Rename vars
ob = renamevars(ob,["t" "cnd"],[o.timeVar o.condVar]);
st = renamevars(st,"t",o.timeVar);