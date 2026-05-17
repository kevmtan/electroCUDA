function [stats, chs] = ec_classifySpec_plotCortex(op, logs, o)
% Prepare ec_classifySpec outputs and plot cortical timecourses.
%
% Loads data when logs/o are omitted, prepares stats/chs, then calls
% ec_plotTimesCortex(op, [], stats, chs).
%
% Kevin Tan, 2026 (electroCUDA)

arguments
    op struct
    logs table = table.empty
    o struct = struct()
end

if isempty(logs)
    [logs,o,op] = ec_plotCortexUtil("loadAnal",op);
else
    if isempty(fieldnames(o))
        error("[ec_classifySpec_plotCortex] Analysis struct o required when logs are supplied.");
    end
end

%% Defaults
if ~isfield(op,"actVar") || ~isany(op.actVar)
    error("[ec_classifySpec_plotCortex] op.actVar required.");
end
if ~isfield(op,"sigVar") || isempty(op.sigVar)
    op.sigVar = "q";
end
if ~isfield(op,"cndLabel") || ~isany(op.cndLabel)
    op.cndLabel = "all";
end
if (~isfield(op,"timeVar") || ~isany(op.timeVar)) && isfield(o,"p") && isfield(o.p,"timeVar")
    op.timeVar = o.p.timeVar;
end

% Multi-actVar support: op.actVar may be a string array — columns are concatenated
% side-by-side into a synthetic actVar (e.g. ["ppc" "ppxc"] -> "ppc_ppxc").
actVarsIn = string(op.actVar);
if numel(actVarsIn) > 1
    op.actVar = strjoin(actVarsIn,"_"); % scalar name for fillPlotDirs etc.
end
op = ec_plotCortexUtil("fillPlotDirs",op);

actVar = string(op.actVar);
sigVarIn = string(op.sigVar);
if sigVarIn == "q"
    sigVars = actVarsIn + "_q";
else
    sigVars = repmat(sigVarIn,size(actVarsIn));
end

%% Load & concatenate st across completed subjects
id = logs.class;
if ~any(id)
    error("[ec_classifySpec_plotCortex] No completed subjects in logs (logs.class).");
end

chSelCfg = [];
if isfield(op,"chSel") && ec_plotCortexUtil("chSelIsActive",op.chSel)
    chSelCfg = op.chSel;
elseif isfield(o,"chSel") && ec_plotCortexUtil("chSelIsActive",o.chSel)
    chSelCfg = o.chSel;
end

stC = cell(nnz(id),1);
chsC = stC;
k = 0;
for s = find(id)'
    stFn = ec_plotCortexUtil("matPath",logs.st(s));
    if ~isfile(stFn)
        warning("[ec_classifySpec_plotCortex] Missing st file, skipping %s: %s",...
            logs.sbj(s),stFn);
        continue;
    end
    S = load(stFn,"st");
    n = logs.n{s};

    if ~isempty(chSelCfg)
        dirsSbj = ec_loadSbj(sbj=logs.sbj(s),proj=o.proj,task=o.task,sfx=o.p.sfx);
        chSel = ec_plotCortexUtil("resolveChSel",chSelCfg,o,dirsSbj);
        if isempty(chSel)
            warning("[ec_classifySpec_plotCortex] chSel unresolved, skipping %s",logs.sbj(s));
            continue;
        end
        chNfoSbj = ec_loadSbj(dirsSbj,vars="chNfo");
        keep = ec_selectChsBySig(chSel,n.sbjID,chNfoSbj);
        if ~any(keep)
            warning("[ec_classifySpec_plotCortex] chSel: no channels kept for %s",logs.sbj(s));
            continue;
        end
        keepCh = chNfoSbj.sbjCh(keep);
        S.st = S.st(ismember(S.st.sbjCh,keepCh),:);
        fprintf("[ec_classifySpec_plotCortex] chSel: keeping %d/%d chans for %s\n",...
            numel(keepCh),height(chNfoSbj),logs.sbj(s));
    end

    if isempty(S.st)
        warning("[ec_classifySpec_plotCortex] No st rows after chSel for %s",logs.sbj(s));
        continue;
    end

    k = k + 1;
    stC{k} = S.st;

    chNfo = n.chNfo;
    if ~isempty(chSelCfg)
        chNfo = chNfo(ismember(chNfo.sbjCh,unique(S.st.sbjCh)),:);
    end
    if isfield(n,"chBad") && ~ismember("bad",string(chNfo.Properties.VariableNames))
        [~,iNfo] = ismember(chNfo.sbjCh,n.chNfo.sbjCh);
        chNfo.bad = n.chBad(iNfo,:);
    end
    chNfo.sbjID(:) = n.sbjID;
    chsC{k} = chNfo;
end
if k == 0
    error("[ec_classifySpec_plotCortex] No st data loaded.");
end

stats = vertcat(stC{:});
chs = vertcat(chsC{:});


%% Reshape st -> stats for ec_plotTimesCortex
% Use "" when cndLabel is empty/missing — downstream title is gated on empty cnd
if ~isfield(op,"cndLabel") || isempty(op.cndLabel) || all(ismissing(op.cndLabel))
    cndLabel = "";
else
    cndLabel = string(op.cndLabel);
end
stats.cnd = repmat(categorical(cndLabel),height(stats),1);

vs = string(stats.Properties.VariableNames);
for v = 1:numel(actVarsIn)
    if ~ismember(actVarsIn(v),vs)
        error("[ec_classifySpec_plotCortex] actVar '%s' not in stats.",actVarsIn(v));
    end
    if ~ismember(sigVars(v),vs)
        error("[ec_classifySpec_plotCortex] sigVar '%s' not in stats.",sigVars(v));
    end
end

% Build per-actVar matrices and auto-resolved subplot labels
Ms = cell(1,numel(actVarsIn));
Ss = cell(1,numel(actVarsIn));
autoNames = strings(0,1);
for v = 1:numel(actVarsIn)
    Ms{v} = ec_plotCortexUtil("toMatrix",stats.(actVarsIn(v)));
    Ss{v} = ec_plotCortexUtil("toMatrix",stats.(sigVars(v)));
    lab = string(colLabels_lfn(actVarsIn(v),o,size(Ms{v},2)));
    if numel(actVarsIn) > 1
        lab = actVarsIn(v) + ":" + lab(:); % disambiguate cols across vars
    end
    autoNames = [autoNames; lab(:)];
end

if isscalar(actVarsIn)
    sigVar = sigVars;
    stats.(actVar) = Ms{1};
    stats.(sigVar) = Ss{1};
else
    sigVar = actVar + "_q";
    stats.(actVar) = cat(2,Ms{:});
    stats.(sigVar) = cat(2,Ss{:});
    if ~isfield(op,"spectNames") || isempty(op.spectNames)
        op.spectNames = autoNames; % override fallback in spect_lfn
    end
end

if sigVarIn == "q" && sigVar ~= "q"
    stats = renamevars(stats,sigVar,"q");
end

spect = spect_lfn(actVar,o,op,stats.(actVar));
stats = addprop(stats,"spect","table");
stats.Properties.CustomProperties.spect = spect;

stats = stats(~ismissing(stats.sbjCh),:);

disp("[ec_classifySpec_plotCortex] Loaded "+k+" subjects, "+height(stats)+...
    " stat rows, "+height(chs)+" channels.");

ec_plotTimesCortex(op, [], stats, chs);




function spect = spect_lfn(actVar,o,op,M)
% Build CustomProperties.spect for ec_plotTimesCortex.
%
% ClassifySpec multi-column metrics use training/CC condition names as column
% labels (shown as subplot "freq" titles in ec_plotTimesCortex):
%   ppc, pp, auc, ...  -> o.p.cond(c) per column
%   ppxc, ppx, nx      -> o.p.condx(c) per column
%   ppc1, ppxc1        -> o.p.cond(2:end) / o.p.condx(2:end) (fitlm contrasts)

nCol = size(M,2);

if isfield(op,"spectNames") && isany(op.spectNames)
    names = string(op.spectNames);
    if numel(names) ~= nCol
        warning("[ec_classifySpec_plotCortex] op.spectNames length (%d) != nCol (%d); using o.p.cond/condx.",...
            numel(names),nCol);
        names = colLabels_lfn(actVar,o,nCol);
    end
else
    names = colLabels_lfn(actVar,o,nCol);
end

spect = table;
spect.name = names(:);
if isfield(op,"spectDisp") && isany(op.spectDisp)
    spect.disp = string(op.spectDisp(:));
else
    spect.disp = spect.name;
end




function names = colLabels_lfn(actVar,o,nCol)
base = regexprep(string(actVar),"_(q|p|SE)$","");

switch base
    case {"ppc","pp","auc","n","n0","wt"}
        names = condColLabels_lfn(o,"cond",nCol);
    case {"ppxc","ppx","nx"}
        names = condColLabels_lfn(o,"condx",nCol);
    case "ppc1"
        names = contrastColLabels_lfn(o,"cond",nCol);
    case "ppxc1"
        names = contrastColLabels_lfn(o,"condx",nCol);
    otherwise
        names = defaultNames_lfn(nCol);
end




function names = condColLabels_lfn(o,condField,nCol)
if ~isfield(o,"p") || ~isfield(o.p,condField)
    names = defaultNames_lfn(nCol);
    return;
end
cond = string(o.p.(condField));
names = cond(1:min(nCol,numel(cond)));
if numel(names) < nCol
    warning("[ec_classifySpec_plotCortex] %s has %d cols but o.p.%s has %d; padding labels.",...
        condField,nCol,condField,numel(cond));
    names = [names "col"+(numel(names)+1:nCol)];
end




function names = contrastColLabels_lfn(o,condField,nCol)
if ~isfield(o,"p") || ~isfield(o.p,condField)
    names = defaultNames_lfn(nCol);
    return;
end
cond = string(o.p.(condField));
if numel(cond) >= 2 && nCol == numel(cond)-1
    names = cond(2:end);
else
    warning("[ec_classifySpec_plotCortex] contrast cols (%d) != numel(o.p.%s)-1 (%d); using generic labels.",...
        nCol,condField,max(numel(cond)-1,0));
    names = defaultNames_lfn(nCol);
end




function names = defaultNames_lfn(nCol)
if nCol == 1
    names = "all";
else
    names = "col"+(1:nCol);
end
