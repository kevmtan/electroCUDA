function logs = ec_classifySpec(o,logs)
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
%   logs = per-subject table (sbj, sbjID, class, error, splitErrs, n, st, ob, out, time, ...)
%
%   logs.class(s) = true after runSbj_lfn finished (including when some splits failed).
%   logs.splitErrs is a cell column preallocated upstream; runSbj_lfn writes row s via
%   [st,ob,sLog.splitErrs{1}] = classify_lfn(...) (errs cell vector, or [] if no split failures).
%   logs.error{s}  = top-level MException if runSbj_lfn threw before completion.

%% Input arguments
arguments
    o struct % options struct (description below in "Options struct validation" section)
    logs table = table
end
% Ensure subject list is string array when building logs from o.sbjs
if isempty(logs)
    o.sbjs = string(o.sbjs);
end
% o.test = 1;

%% Prep

% Main analysis output root: dirs.anal+o.analDir+o.analName (per-subject dirs are o.analOut+"s"+n.sbjID+filesep)
dirs = ec_getDirs(o.proj,o.task);
o.analOut = dirs.anal+o.analDir+filesep+o.analName+filesep;

% Make analysis output dir
if o.save && ~exist(o.analOut,"dir")
    mkdir(o.analOut);
end

% Save options struct
if o.save
    save(o.analOut+"o_"+o.analName+".mat","o");
end

% Make log table (nonempty logs supersedes o.sbjs, e.g. continuing an interrupted run)
if isempty(logs)
    nSbjs = numel(o.sbjs);
    logs = table;
    logs.sbj = string(o.sbjs);
    logs.sbjID(:) = uint16(0);
    logs.class(:) = false;
    logs.post(:) = false;
    logs.plot(:) = false;    
    logs.error = cell(nSbjs,1);
    logs.splitErrs = cell(nSbjs,1); % default [] per row (same as cell(height(logs),1))
    logs.n = cell(nSbjs,1);
    logs.st(:) = string(missing);
    logs.ob(:) = string(missing);
    logs.out(:) = string(missing);
    logs.time(:) = string(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));
end
if ~ismember("splitErrs",string(logs.Properties.VariableNames))
    logs.splitErrs = cell(height(logs),1);
end
% sLog=logs(5,:); %sbj38
% sLog=logs(9,:); %sbj42
% sLog=logs(21,:); %sbj60


%% Run subjects
for s = 1:height(logs)
    if ~logs.class(s)
        %% Run subject
        try
            %%
            sLog = runSbj_lfn(o,logs(s,:));
            logs(s,:) = sLog;
            logs.class(s) = true;
        catch ME
            warning("%s",getReport(ME,"extended"));
            logs.error{s} = ME;
            logs.class(s) = false;
        end

        %% Save logs
        logs.time(s) = datetime("now",TimeZone="local",Format="yyMMdd_HHmm");

        % Select .mat version (v7 has ~2 GB per-variable limit; v7.3/HDF5 for larger)
        matVer = "-v7";
        if whos("logs").bytes>2^31; matVer="-v7.3"; end

        % Save
        save(o.analOut+"logs_"+o.analName,"logs",matVer);

    else
        disp("SKIPPING: "+logs.sbj(s));
    end
end







function sLog = runSbj_lfn(o,sLog)
%%% Run subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("STARTING: "+sLog.sbj);
tt = tic;

% Subject directories/info
dirs = ec_loadSbj(sbj=sLog.sbj,proj=o.proj,task=o.task,sfx=o.p.sfx);
sLog.sbjID = dirs.sbjID;


%% Channel selection (optional)
% Pre-filter channels via ec_selectChsBySig BEFORE ec_analPrep — the resulting
% removal list is plumbed through o.p.chRm into ec_analPrep's existing chPrep_lfn.
% Mirrors the chSelection_lfn approach of ec_condConChsROI_perm.
if isfield(o,"chSel") && ~isempty(o.chSel)
    chSel = o.chSel;

    % Resolve chSelDir/chSelName → full chTable path (mirrors chSelection_lfn).
    % Only applied when chTable is not already set and source is not "perm".
    noTable = ~isfield(chSel,"chTable") || isempty(chSel.chTable);
    notPerm = ~isfield(chSel,"source")  || string(chSel.source)~="perm";
    if noTable && notPerm
        if isfield(chSel,"chSelName") && isany(chSel.chSelName)
            selDir = "condConCh"; % default source subdir
            if isfield(chSel,"chSelDir") && isany(chSel.chSelDir)
                selDir = string(chSel.chSelDir);
            end
            selPath = dirs.anal+selDir+filesep+string(chSel.chSelName)+filesep;
            chSel.chTable = selPath+"chNfoA_"+string(chSel.chSelName)+".mat";
            chSel.source  = "table";
            disp("[ec_classifySpec] chSel table: "+chSel.chTable);
        else
            warning("[ec_classifySpec] chSel set but no chTable, chSelName, or srcDir; skipping.");
            chSel = [];
        end
    end

    if ~isempty(chSel)
        % Auto-propagate o.p.cond/condx → chSel for "self"/"condAndCondx" modes.
        if (~isfield(chSel,"cond")  || isempty(chSel.cond))  && isfield(o.p,"cond")
            chSel.cond  = o.p.cond;
        end
        if (~isfield(chSel,"condx") || isempty(chSel.condx)) && isfield(o.p,"condx")
            chSel.condx = o.p.condx;
        end

        chNfoSbj = ec_loadSbj(dirs,sfx=o.p.sfx,vars="chNfo");
        keep = ec_selectChsBySig(chSel,sLog.sbjID,chNfoSbj);
        o.p.chRm = chNfoSbj.ch(~keep);
        fprintf("[ec_classifySpec] chSel: keeping %d/%d chans for %s\n",...
            nnz(keep),numel(keep),sLog.sbj);
    end

    if ~any(keep)
        error("No channels remaining after selection: "+sLog.sbj);
    end
end


%% Prepare analysis data
oo = namedargs2cell(o.p);                % expand name-value arguments
[x,ep,n] = ec_analPrep(dirs,tt,oo{:});   % run data prep

% Per-subject output dir: dirs.anal+o.analDir+o.analName+filesep+"s"+n.sbjID+filesep (= o.analOut+"s"+n.sbjID+filesep)
sLog.out = o.analOut+"s"+n.sbjID+filesep;

% Make subject output dir
if o.save && ~exist(sLog.out,"dir")
    mkdir(sLog.out);
end


%% Classifier prep & templates
[st,ob,o] = ec_classifyPrep(n,ep,tt,o);
% st = statistics
% ob = observations


%% Split data for independent model runs
oo = namedargs2cell(o.s);
[x,n,st,ob] = ec_analSplit(x,n,st,ob,tt,oo{:}); % split by chs/ICs/ROIs x timepoints


%% Classification (third output into preallocated logs.splitErrs cell for this row)
[st,ob,sLog.splitErrs{1}] = classify_lfn(x,n,st,ob,tt,o);


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
if o.p.timeVar~="time"
    if ismember(o.p.timeVar,string(ob.Properties.VariableNames))
        error("[ec_classifySpec] Cannot rename ob.time to '%s': column already exists.",o.p.timeVar);
    end
    ob = renamevars(ob,"time",o.p.timeVar);
    if ismember("time",string(st.Properties.VariableNames))
        st = renamevars(st,"time",o.p.timeVar);
    end
end
if o.p.condVar~="cnd"
    if ismember(o.p.condVar,string(ob.Properties.VariableNames))
        error("[ec_classifySpec] Cannot rename ob.cnd to '%s': column already exists.",o.p.condVar);
    end
    ob = renamevars(ob,"cnd",o.p.condVar);
end


%% Save

% Save subject/recording info to log
sLog.n{1} = n;

% Select .mat version (v7 has ~2 GB per-variable limit; v7.3/HDF5 for larger)
stVer = "-v7";
if whos("st").bytes > 2^31
    stVer = "-v7.3";
end
obVer = "-v7";
if whos("ob").bytes > 2^31
    obVer = "-v7.3";
end

% Save
sLog.st = fullfile(sLog.out,"s"+n.sbjID+"_st.mat");
save(sLog.st,"st",stVer);
disp("[ec_classifySpec] Saved classification statistics: "+sLog.st+" ("+stVer+") toc="+toc(tt));
sLog.ob = fullfile(sLog.out,"s"+n.sbjID+"_ob.mat");
save(sLog.ob,"ob",obVer);
disp("[ec_classifySpec] Saved classification observations: "+sLog.ob+" ("+obVer+") toc="+toc(tt));




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
    errs = []; % no split failures (empty double, same spirit as cell(...,1) prealloc)
end
disp("[ec_classifySpec] Ran classifiers: "+n.sbj+" toc="+toc(tt));

% Concatenate channel results
ob = vertcat(ob{:}); % sortrows(vertcat(ob{:}),["ch" "tr" "time"],"ascend");






function st = fdr_lfn(st,n,o,tt)
%%% Run FDR correction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vs = string(st.Properties.VariableNames);
vsQ = vs(endsWith(vs,"_q")); % fdr vars
vsP = replace(vsQ,"_q","_p"); % expected matching pval vars
id = st.time>=o.fdrTimeRng(1) & st.time<=o.fdrTimeRng(2); % fdr time range

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