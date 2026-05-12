function keep = ec_selectChsBySig(chSel,sbjID,chNfo)
% Per-subject channel selection mask for downstream analyses.
%
% Two input sources:
%   "table" — precomputed channel-feature table with logical columns (e.g. output
%             of ec_condConChs_sigChs, or a separately built task-vs-baseline table).
%   "perm"  — raw ec_condConChs_perm results on disk; thresholding done inline
%             via ec_sigChsFromPerm.
%
% Two scopes:
%   "subject" — criteria applied globally per subject (one mask).
%   "roi"     — when paired with topN, ranks/caps within each ROI separately.
%               Without topN, equivalent to "subject" (criteria are per-channel).
%
% INPUTS:
%   chSel   struct with fields:
%             .scope      ("subject"|"roi", default "subject")
%             .source     ("table"|"perm", default "table")
%             .combine    ("or"|"and", default "or") — across .vars (table mode)
%             .topN       (scalar, optional)        — cap per scope group
%             .rankVar    (string, optional)        — column to rank by (table mode);
%                                                     auto-derived in perm mode.
%             % source="table":
%             .chTable    (table | filepath)        — chNfoA or path to .mat
%             .chTableVar (string, default "chNfoA") — variable name inside .mat
%             .vars       (string array)            — logical columns to consume.
%                                                     Matrix-valued columns are
%                                                     collapsed via any(...,2).
%             .bandIdx    (vector, optional)        — restrict matrix columns to
%                                                     these column indices first.
%             % source="perm":
%             .srcDir     (string)                  — dirs.anal/<analDir>/<analName>/
%             .logsVar    (string, default "logs")  — logs variable in logs_*.mat
%             .contrasts  (string array, optional)
%             .sigVar     (string, default "q")
%             .sigThr     (scalar, default 0.05)
%             .sigDur     (scalar ms, default 50)
%             .mVar       (string, default "mu")
%             .sigTimeRng ([min max] ms, optional)
%             .direction  ("act"|"dea"|"any", default "any") — which event(s) qualify
%   sbjID   subject ID (numeric or string; used to find this subject's rows/files)
%   chNfo   subject's channel info table (must have sbjCh; needs roi for scope="roi")
%
% OUTPUT:
%   keep    logical column vector of height(chNfo).

arguments
    chSel  struct
    sbjID
    chNfo  table
end

% Defaults
if ~isfield(chSel,"scope")   || ~isany(chSel.scope);   chSel.scope   = "subject"; end
if ~isfield(chSel,"source")  || ~isany(chSel.source);  chSel.source  = "table"; end
if ~isfield(chSel,"combine") || ~isany(chSel.combine); chSel.combine = "or"; end

chSel.scope   = string(chSel.scope);
chSel.source  = string(chSel.source);
chSel.combine = string(chSel.combine);

% Validate channel info has the columns we need
if ~ismember("sbjCh",string(chNfo.Properties.VariableNames))
    error("[ec_selectChsBySig] chNfo must have a 'sbjCh' column.");
end
if chSel.scope=="roi" && ~ismember("roi",string(chNfo.Properties.VariableNames))
    error("[ec_selectChsBySig] scope='roi' requires chNfo.roi.");
end


%% Resolve per-channel mask & optional rank score
switch chSel.source
    case "table"
        [keep,rankScore] = fromTable_lfn(chSel,sbjID,chNfo);
    case "perm"
        [keep,rankScore] = fromPerm_lfn(chSel,sbjID,chNfo);
    otherwise
        error("[ec_selectChsBySig] chSel.source must be 'table' or 'perm', got '%s'.",chSel.source);
end


%% Optional topN cap, applied within scope group
if isfield(chSel,"topN") && ~isempty(chSel.topN) && isfinite(chSel.topN) && chSel.topN>0
    if isempty(rankScore)
        warning("[ec_selectChsBySig] topN requested but no rank score available; ignoring.");
    else
        if chSel.scope=="roi"
            grp = chNfo.roi;
        else
            grp = ones(height(chNfo),1);
        end
        keep = topNPerGroup_lfn(keep,rankScore,chSel.topN,grp);
    end
end

% Ensure column logical
keep = keep(:);
keep = logical(keep);




function [keep,rankScore] = fromTable_lfn(chSel,sbjID,chNfo)
%%% Build mask from a precomputed channel-feature table %%%%%%%%%%%%%%%%%%%
keep = false(height(chNfo),1);
rankScore = [];

% Resolve chTable (filepath or table directly)
chTable = chSel.chTable;
if ~istable(chTable)
    if isstring(chTable) || ischar(chTable)
        if ~isfield(chSel,"chTableVar") || ~isany(chSel.chTableVar)
            chSel.chTableVar = "chNfoA";
        end
        S = load(chTable);
        if isfield(S,chSel.chTableVar)
            chTable = S.(chSel.chTableVar);
        else
            % Fall back to first table in file
            fn = fieldnames(S);
            tabFlds = fn(structfun(@istable,S));
            if isempty(tabFlds)
                error("[ec_selectChsBySig] No table variable '%s' or any table in file: %s",...
                    chSel.chTableVar,chTable);
            end
            chTable = S.(tabFlds{1});
        end
    else
        error("[ec_selectChsBySig] chSel.chTable must be a table or filepath.");
    end
end

% Restrict chTable to this subject's rows by sbjCh match
[tf,idx] = ismember(chNfo.sbjCh,chTable.sbjCh);
if ~any(tf)
    warning("[ec_selectChsBySig] sbjID %s: no chTable rows matched chNfo.sbjCh; returning all-false.",...
        string(sbjID));
    return;
end

% Validate vars
if ~isfield(chSel,"vars") || isempty(chSel.vars)
    error("[ec_selectChsBySig] source='table' requires chSel.vars (column names to combine).");
end
chSel.vars = string(chSel.vars);
missingVars = chSel.vars(~ismember(chSel.vars,string(chTable.Properties.VariableNames)));
if ~isempty(missingVars)
    error("[ec_selectChsBySig] chTable missing vars: %s",strjoin(missingVars,", "));
end

% Optional band index for matrix-valued columns
bandIdx = [];
if isfield(chSel,"bandIdx") && ~isempty(chSel.bandIdx)
    bandIdx = chSel.bandIdx(:)';
end

% Evaluate each var to a per-row logical for the rows we matched
nVars = numel(chSel.vars);
nRows = nnz(tf);
M = false(nRows,nVars);
for v = 1:nVars
    col = chTable.(chSel.vars(v));
    col = col(idx(tf),:);             % subset to matched rows
    if ~isempty(bandIdx) && size(col,2)>1
        col = col(:,bandIdx);
    end
    if size(col,2)>1
        col = any(col,2);              % collapse freq/band dim
    end
    M(:,v) = logical(col);
end

% Combine across vars
if chSel.combine=="and"
    rowKeep = all(M,2);
else
    rowKeep = any(M,2);
end

% Write back into the full keep vector
keep(tf) = rowKeep;

% Rank score (if rankVar provided)
if isfield(chSel,"rankVar") && ~isempty(chSel.rankVar) && isany(chSel.rankVar)
    rankVar = string(chSel.rankVar);
    if ismember(rankVar,string(chTable.Properties.VariableNames))
        rs = chTable.(rankVar);
        rs = rs(idx(tf),:);
        if ~isempty(bandIdx) && size(rs,2)>1
            rs = rs(:,bandIdx);
        end
        if size(rs,2)>1
            rs = max(abs(rs),[],2,"omitnan");
        else
            rs = abs(rs);
        end
        rankScore = nan(height(chNfo),1);
        rankScore(tf) = rs;
    else
        warning("[ec_selectChsBySig] rankVar '%s' not in chTable; ignoring.",rankVar);
    end
end




function [keep,rankScore] = fromPerm_lfn(chSel,sbjID,chNfo)
%%% Build mask by thresholding raw ec_condConChs_perm results %%%%%%%%%%%%%
keep = false(height(chNfo),1);
rankScore = [];

% Locate the analysis options file & the logs for this analysis
if ~isfield(chSel,"srcDir") || ~isany(chSel.srcDir)
    error("[ec_selectChsBySig] source='perm' requires chSel.srcDir.");
end
srcDir = string(chSel.srcDir);
if ~endsWith(srcDir,filesep); srcDir = srcDir+filesep; end

d = dir(srcDir+"o_*.mat");
if isempty(d)
    error("[ec_selectChsBySig] No options file (o_*.mat) found in: %s",srcDir);
end
S = load(srcDir+string(d(1).name),"o");
oPerm = S.o;

% Load logs to find this subject's st/n paths
if ~isfield(chSel,"logsVar") || ~isany(chSel.logsVar); chSel.logsVar = "logs"; end
fn = srcDir+"logs_"+oPerm.analName+".mat";
S = load(fn);
if ~isfield(S,chSel.logsVar)
    error("[ec_selectChsBySig] No '%s' variable in %s",chSel.logsVar,fn);
end
logs = S.(chSel.logsVar);

% Find this subject's row
sRow = find(logs.sbjID==sbjID,1);
if isempty(sRow)
    warning("[ec_selectChsBySig] sbjID %s not in logs; returning all-false.",string(sbjID));
    return;
end
if ~logs.fin(sRow)
    warning("[ec_selectChsBySig] sbjID %s not marked finished in logs; returning all-false.",string(sbjID));
    return;
end

% Load this subject's perm stats table
stPath = string(logs.st(sRow));
T = load(stPath,"st");
st = T.st;

% Build kernel options from chSel (with defaults & fallbacks to oPerm)
op = struct;
if isfield(chSel,"contrasts") && isany(chSel.contrasts)
    op.contrasts = string(chSel.contrasts);
elseif isfield(oPerm,"contrasts")
    op.contrasts = string(oPerm.contrasts);
end
if isfield(chSel,"sigVar") && isany(chSel.sigVar);     op.sigVar = chSel.sigVar; end
if isfield(chSel,"sigThr") && ~isempty(chSel.sigThr);  op.sigThr = chSel.sigThr; end
if isfield(chSel,"sigDur") && ~isempty(chSel.sigDur);  op.sigDur = chSel.sigDur; end
if isfield(chSel,"mVar")   && isany(chSel.mVar);       op.mVar   = chSel.mVar;   end
if isfield(chSel,"sigTimeRng") && ~isempty(chSel.sigTimeRng); op.sigTimeRng = chSel.sigTimeRng; end

% Run kernel to get augmented chNfo (with _act/_dea/peak<mVar> columns)
chNfoSig = ec_sigChsFromPerm(st,chNfo,op);

% Resolve which contrasts/conNames are in the augmented table
contrasts = string(op.contrasts);
conNames  = regexprep(contrasts,"[^a-zA-Z0-9_]","");

% Direction selector
direction = "any";
if isfield(chSel,"direction") && isany(chSel.direction)
    direction = string(chSel.direction);
end

% Build var list across contrasts
vars = strings(0,1);
switch direction
    case "act"
        for c = 1:numel(conNames); vars(end+1,1) = conNames(c)+"_act"; end %#ok<AGROW>
    case "dea"
        for c = 1:numel(conNames); vars(end+1,1) = conNames(c)+"_dea"; end %#ok<AGROW>
    otherwise
        for c = 1:numel(conNames)
            vars(end+1,1) = conNames(c)+"_act"; %#ok<AGROW>
            vars(end+1,1) = conNames(c)+"_dea"; %#ok<AGROW>
        end
end

% Drop vars not present (shouldn't happen if kernel ran, but defensive)
vars = vars(ismember(vars,string(chNfoSig.Properties.VariableNames)));
if isempty(vars)
    warning("[ec_selectChsBySig] No matching _act/_dea columns after kernel run; returning all-false.");
    return;
end

% Optional band restriction
bandIdx = [];
if isfield(chSel,"bandIdx") && ~isempty(chSel.bandIdx)
    bandIdx = chSel.bandIdx(:)';
end

% Combine across vars (default OR — any contrast/direction qualifies)
combine = chSel.combine;
M = false(height(chNfoSig),numel(vars));
for v = 1:numel(vars)
    col = chNfoSig.(vars(v));
    if ~isempty(bandIdx) && size(col,2)>1
        col = col(:,bandIdx);
    end
    if size(col,2)>1
        col = any(col,2);
    end
    M(:,v) = logical(col);
end
if combine=="and"
    keep = all(M,2);
else
    keep = any(M,2);
end

% Rank score: peak |mVar| across qualifying directions/contrasts
mVar = "mu";
if isfield(op,"mVar"); mVar = string(op.mVar); end
peakVars = strings(0,1);
switch direction
    case "act"
        for c = 1:numel(conNames); peakVars(end+1,1) = conNames(c)+"_peakA_"+mVar; end %#ok<AGROW>
    case "dea"
        for c = 1:numel(conNames); peakVars(end+1,1) = conNames(c)+"_peakD_"+mVar; end %#ok<AGROW>
    otherwise
        for c = 1:numel(conNames)
            peakVars(end+1,1) = conNames(c)+"_peakA_"+mVar; %#ok<AGROW>
            peakVars(end+1,1) = conNames(c)+"_peakD_"+mVar; %#ok<AGROW>
        end
end
peakVars = peakVars(ismember(peakVars,string(chNfoSig.Properties.VariableNames)));
if ~isempty(peakVars)
    rankScore = nan(height(chNfoSig),numel(peakVars));
    for v = 1:numel(peakVars)
        col = chNfoSig.(peakVars(v));
        if ~isempty(bandIdx) && size(col,2)>1
            col = col(:,bandIdx);
        end
        if size(col,2)>1
            col = max(abs(col),[],2,"omitnan");
        else
            col = abs(col);
        end
        rankScore(:,v) = col;
    end
    rankScore = max(rankScore,[],2,"omitnan");
end




function keep = topNPerGroup_lfn(keep,rankScore,topN,grp)
%%% Within each group, keep only top-N channels by rankScore (among current keeps) %%%
topN = double(topN);
grpU = unique(grp);
keepOut = false(size(keep));
for g = 1:numel(grpU)
    gMask = grp==grpU(g) & keep;
    if ~any(gMask); continue; end
    rs = rankScore;
    rs(~gMask) = -inf;
    [~,ord] = sort(rs,"descend","MissingPlacement","last");
    nKeep = min(topN,nnz(gMask));
    keepOut(ord(1:nKeep)) = true;
end
keep = keepOut;
