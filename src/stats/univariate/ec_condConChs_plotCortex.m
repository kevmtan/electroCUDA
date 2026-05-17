function [stats, chs] = ec_condConChs_plotCortex(op, logs, o)
% Prepare ec_condConChs_perm outputs and plot cortical timecourses.
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
        error("[ec_condConChs_plotCortex] Analysis struct o required when logs are supplied.");
    end
end

%% Defaults
if ~isfield(op,"actVar") || ~isany(op.actVar)
    op.actVar = "mu";
end
if ~isfield(op,"sigVar") || isempty(op.sigVar)
    op.sigVar = "q";
end
if ~isfield(op,"condVar") || ~isany(op.condVar)
    op.condVar = "contrast";
end
if ~isfield(op,"timeVar") || ~isany(op.timeVar)
    op.timeVar = "time";
end
op = ec_plotCortexUtil("fillPlotDirs",op);

actVar = string(op.actVar);
sigVar = string(op.sigVar);

%% Load & concatenate st across finished subjects
if ~ismember("fin",string(logs.Properties.VariableNames))
    error("[ec_condConChs_plotCortex] logs table missing 'fin' column.");
end
id = logs.fin;
if ~any(id)
    error("[ec_condConChs_plotCortex] No finished subjects in logs (logs.fin).");
end

chSelCfg = [];
if isfield(op,"chSel") && ec_plotCortexUtil("chSelIsActive",op.chSel)
    chSelCfg = op.chSel;
elseif isfield(o,"chSel") && ec_plotCortexUtil("chSelIsActive",o.chSel)
    chSelCfg = o.chSel;
end

stC = cell(nnz(id),1);
chsC = stC;
spect = [];
k = 0;
for s = find(id)'
    stFn = ec_plotCortexUtil("matPath",logs.st(s));
    nFn = ec_plotCortexUtil("matPath",logs.n(s));
    if ~isfile(stFn)
        warning("[ec_condConChs_plotCortex] Missing st file, skipping %s: %s",...
            logs.sbj(s),stFn);
        continue;
    end
    if ~isfile(nFn)
        warning("[ec_condConChs_plotCortex] Missing n file, skipping %s: %s",...
            logs.sbj(s),nFn);
        continue;
    end
    S = load(stFn,"st");
    N = load(nFn,"n");
    n = N.n;

    if ~isempty(chSelCfg)
        dirsSbj = ec_loadSbj(sbj=logs.sbj(s),proj=o.proj,task=o.task,sfx=o.p.sfx);
        chSel = ec_plotCortexUtil("resolveChSel",chSelCfg,o,dirsSbj);
        if isempty(chSel)
            warning("[ec_condConChs_plotCortex] chSel unresolved, skipping %s",logs.sbj(s));
            continue;
        end
        chNfoSbj = ec_loadSbj(dirsSbj,vars="chNfo");
        keep = ec_selectChsBySig(chSel,n.sbjID,chNfoSbj);
        if ~any(keep)
            warning("[ec_condConChs_plotCortex] chSel: no channels kept for %s",logs.sbj(s));
            continue;
        end
        keepCh = chNfoSbj.sbjCh(keep);
        S.st = S.st(ismember(S.st.sbjCh,keepCh),:);
        fprintf("[ec_condConChs_plotCortex] chSel: keeping %d/%d chans for %s\n",...
            numel(keepCh),height(chNfoSbj),logs.sbj(s));
    end

    if isempty(S.st)
        warning("[ec_condConChs_plotCortex] No st rows after chSel for %s",logs.sbj(s));
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

    if isempty(spect) && isfield(n,"spect")
        spect = n.spect;
    end
end
if k == 0
    error("[ec_condConChs_plotCortex] No st data loaded.");
end

stats = vertcat(stC{:});
chs = vertcat(chsC{:});


%% Validate & prep for ec_plotTimesCortex
vs = string(stats.Properties.VariableNames);
if ~ismember(actVar,vs)
    error("[ec_condConChs_plotCortex] actVar '%s' not in stats.",actVar);
end
if ~ismember(sigVar,vs)
    if sigVar=="q" && ismember("p",vs)
        warning("[ec_condConChs_plotCortex] sigVar 'q' missing (e.g. TFCE run); using 'p'.");
        sigVar = "p";
        op.sigVar = "p";
    else
        error("[ec_condConChs_plotCortex] sigVar '%s' not in stats.",sigVar);
    end
end
if ~ismember(string(op.condVar),vs)
    error("[ec_condConChs_plotCortex] condVar '%s' not in stats.",op.condVar);
end
if ~ismember(string(op.timeVar),vs)
    error("[ec_condConChs_plotCortex] timeVar '%s' not in stats.",op.timeVar);
end

stats.(actVar) = ec_plotCortexUtil("toMatrix",stats.(actVar));
stats.(sigVar) = ec_plotCortexUtil("toMatrix",stats.(sigVar));

if isempty(spect)
    spect = spectFromO_lfn(o,size(stats.(actVar),2));
end

% Apply op.spectNames / op.spectDisp overrides (length must match nCol)
nCol = size(stats.(actVar),2);
if isfield(op,"spectNames") && isany(op.spectNames)
    sn = string(op.spectNames);
    if numel(sn) == nCol
        spect.name = sn(:);
    else
        warning("[ec_condConChs_plotCortex] op.spectNames length (%d) != nCol (%d); ignored.",...
            numel(sn),nCol);
    end
end
if isfield(op,"spectDisp") && isany(op.spectDisp)
    sd = string(op.spectDisp);
    if numel(sd) == nCol
        spect.disp = sd(:);
    else
        warning("[ec_condConChs_plotCortex] op.spectDisp length (%d) != nCol (%d); ignored.",...
            numel(sd),nCol);
    end
end

stats = addprop(stats,"spect","table");
stats.Properties.CustomProperties.spect = spect;

stats = stats(~ismissing(stats.sbjCh),:);

disp("[ec_condConChs_plotCortex] Loaded "+k+" subjects, "+height(stats)+...
    " stat rows, "+height(chs)+" channels.");

ec_plotTimesCortex(op, [], stats, chs);




function spect = spectFromO_lfn(o,nCol)
spect = table;
if isfield(o,"p") && isfield(o.p,"pre") && isfield(o.p.pre,"bands")
    names = string(o.p.pre.bands);
    spect.name = names(1:min(nCol,numel(names)))';
    if isfield(o.p.pre,"bands2") && numel(o.p.pre.bands2) >= numel(spect.name)
        spect.disp = string(o.p.pre.bands2(1:height(spect)))';
    else
        spect.disp = spect.name;
    end
    if height(spect) < nCol
        extra = "col"+(height(spect)+1:nCol);
        spect.name = [spect.name; extra'];
        spect.disp = [spect.disp; extra'];
    end
else
    spect.name = "col"+(1:nCol)';
    spect.disp = spect.name;
end
