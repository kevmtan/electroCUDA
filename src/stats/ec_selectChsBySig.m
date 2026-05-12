function keep = ec_selectChsBySig(chSel,sbjID,chNfo)
% Per-subject channel selection mask for downstream analyses.
%
% Two input sources:
%   "table" — precomputed channel-feature table (e.g. chNfoA from ec_condConChs_sigChs
%             or a separately built task-vs-baseline table with _act/_dea columns).
%   "perm"  — raw ec_condConChs_perm results on disk; thresholding done inline
%             via ec_sigChsFromPerm.
%
% Two scopes:
%   "subject" — criteria applied globally per subject (one mask).
%   "roi"     — when paired with topN, ranks/caps within each ROI separately.
%               Without topN, equivalent to "subject" (criteria are per-channel).
%
% Column resolution (mirrors chSelMask_lfn in ec_condConChsROI_perm):
%   cond1Sample = "any":         use ALL _act/_dea columns (least circular).
%   cond1Sample = "self":        columns prefixed by chSel.cond (training conditions).
%                                e.g. cond=["Semantic" "Episodic"] selects
%                                Semantic_act/dea + Episodic_act/dea.
%                                Auto-populated from o.p.cond in ec_classifySpec.
%   cond1Sample = "condAndCondx": channels with any act/dea in chSel.cond AND any
%                                act/dea in chSel.condx (cross-classification conds).
%                                Recommended for cross-classification — keeps only
%                                channels responsive to BOTH condition pairs.
%                                chSel.condx auto-populated from o.p.condx.
%   cond1Sample = "condOrCondx": same but OR — any response in either group.
%
% INPUTS:
%   chSel   struct with fields:
%             .scope       ("subject"|"roi", default "subject")
%             .source      ("table"|"perm", default "table")
%             .cond1Sample ("any"|"self", default "any") — column resolution mode
%             .cond        (string array, optional)      — training conditions;
%                                                          auto-set from o.p.cond
%             .condx       (string array, optional)      — cross-classification conds;
%                                                          auto-set from o.p.condx
%             .combine     ("or"|"and", default "or")   — across resolved columns
%             .topN        (scalar, optional)            — cap per scope group
%             .rankVar     (string, optional)            — col to rank by (table mode);
%                                                          auto-derived in perm mode
%             % source="table":
%             .chTable     (table | filepath)            — chNfoA or path to .mat
%             .chTableVar  (string, default "chNfoA")    — variable name inside .mat
%             .vars        (string array, optional)      — explicit column list;
%                                                          if absent, auto-derived via
%                                                          cond1Sample/cond logic
%             .bandIdx     (vector, optional)            — restrict matrix cols to
%                                                          these column indices first
%             % source="perm":
%             .srcDir      (string)                      — path to condConChs analysis
%             .logsVar     (string, default "logs")      — logs variable in logs_*.mat
%             .contrasts   (string array, optional)
%             .sigVar      (string, default "q")
%             .sigThr      (scalar, default 0.05)
%             .sigDur      (scalar ms, default 50)
%             .mVar        (string, default "mu")
%             .sigTimeRng  ([min max] ms, optional)
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
if ~isfield(chSel,"scope")       || ~isany(chSel.scope);       chSel.scope       = "subject"; end
if ~isfield(chSel,"source")      || ~isany(chSel.source);      chSel.source      = "table";   end
if ~isfield(chSel,"combine")     || ~isany(chSel.combine);     chSel.combine     = "or";      end
if ~isfield(chSel,"cond1Sample") || ~isany(chSel.cond1Sample); chSel.cond1Sample = "any";     end

chSel.scope       = string(chSel.scope);
chSel.source      = string(chSel.source);
chSel.combine     = string(chSel.combine);
chSel.cond1Sample = string(chSel.cond1Sample);

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

% Guard: chTable must have _act/_dea columns (added by ec_condConChs_sigChs).
% If absent, ec_condConChs_sigChs likely hasn't been run yet for this analysis.
if ~any(endsWith(string(chTable.Properties.VariableNames),"_act") | ...
        endsWith(string(chTable.Properties.VariableNames),"_dea"))
    warning("[ec_selectChsBySig] chTable has no _act/_dea columns — " + ...
        "run ec_condConChs_sigChs to augment the chNfoA before using channel selection. " + ...
        "Returning all-false (no channel selection applied) for %s.",string(sbjID));
    return;
end

% Optional band index — resolved early, needed by both single- and multi-group paths
bandIdx = [];
if isfield(chSel,"bandIdx") && ~isempty(chSel.bandIdx)
    bandIdx = chSel.bandIdx(:)';
end

% Multi-group AND/OR: each group is OR'd within, then groups are combined.
% "condAndCondx": channels responsive to BOTH training AND cross-classification conds.
% "condOrCondx":  channels responsive to EITHER condition group.
if ismember(chSel.cond1Sample, ["condAndCondx" "condOrCondx"])
    varNames  = string(chTable.Properties.VariableNames);
    adVars    = varNames(endsWith(varNames,"_act") | endsWith(varNames,"_dea"));
    rowKeep   = multiGroupMask_lfn(chTable,idx(tf),adVars,chSel,bandIdx);
    keep(tf)  = rowKeep;
    return; % rankScore not computed for multi-group mode; topN is skipped
end

% Resolve which columns to check: explicit list takes precedence; otherwise
% auto-derive from cond1Sample/cond (same logic as chSelMask_lfn).
if ~isfield(chSel,"vars") || isempty(chSel.vars)
    chSel.vars = resolveVars_lfn(chTable,chSel);
else
    chSel.vars = string(chSel.vars);
    missingVars = chSel.vars(~ismember(chSel.vars,string(chTable.Properties.VariableNames)));
    if ~isempty(missingVars)
        error("[ec_selectChsBySig] chTable missing vars: %s",strjoin(missingVars,", "));
    end
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

% Multi-group AND/OR (perm mode: operates on augmented chNfoSig from the kernel)
if ismember(chSel.cond1Sample, ["condAndCondx" "condOrCondx"])
    varNames = string(chNfoSig.Properties.VariableNames);
    adVars   = varNames(endsWith(varNames,"_act") | endsWith(varNames,"_dea"));
    bandIdx  = [];
    if isfield(chSel,"bandIdx") && ~isempty(chSel.bandIdx); bandIdx = chSel.bandIdx(:)'; end
    keep = multiGroupMask_lfn(chNfoSig,1:height(chNfoSig),adVars,chSel,bandIdx);
    return; % rankScore not computed for multi-group mode; topN is skipped
end

% Resolve which _act/_dea columns to check (same logic as chSelMask_lfn /
% resolveVars_lfn — cond1Sample "any" uses all; "self" filters by chSel.cond)
vars = resolveVars_lfn(chNfoSig,chSel);
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

% Rank score: max peak |mVar| across the same columns resolved above
mVar = "mu";
if isfield(op,"mVar"); mVar = string(op.mVar); end
% Map _act→_peakA_<mVar>, _dea→_peakD_<mVar> for each resolved var
peakVars = regexprep(vars,"_act$","_peakA_"+mVar);
peakVars = regexprep(peakVars,"_dea$","_peakD_"+mVar);
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




function mask = multiGroupMask_lfn(chTable,idxRows,actDeaVars,chSel,bandIdx)
%%% Two-group AND/OR mask (condAndCondx / condOrCondx) %%%%%%%%%%%%%%%%%%%%
cond  = [];
condx = [];
if isfield(chSel,"cond")  && ~isempty(chSel.cond);  cond  = string(chSel.cond(:)');  end
if isfield(chSel,"condx") && ~isempty(chSel.condx); condx = string(chSel.condx(:)'); end
m1 = colMask_lfn(chTable, idxRows, actDeaForConds_lfn(actDeaVars,cond),  bandIdx);
m2 = colMask_lfn(chTable, idxRows, actDeaForConds_lfn(actDeaVars,condx), bandIdx);
if chSel.cond1Sample=="condAndCondx"
    mask = m1 & m2;
else
    mask = m1 | m2;
end




function vars = actDeaForConds_lfn(actDeaVars,conds)
%%% _act/_dea vars matching sanitized condition name prefixes %%%%%%%%%%%%%
if isempty(conds); vars = strings(0,1); return; end
checkPfx = regexprep(string(conds(:)),"[^a-zA-Z0-9_]","");
colBase  = regexprep(actDeaVars,"_(act|dea)$","");
vars     = actDeaVars(ismember(colBase,checkPfx));




function mask = colMask_lfn(chTable,idxRows,vars,bandIdx)
%%% OR mask across a set of act/dea columns for specified rows %%%%%%%%%%%%
mask = false(numel(idxRows),1);
for v = 1:numel(vars)
    col = chTable.(vars(v))(idxRows,:);
    if ~isempty(bandIdx) && size(col,2)>1; col = col(:,bandIdx); end
    if size(col,2)>1; col = any(col,2); end
    mask = mask | logical(col(:));
end




function vars = resolveVars_lfn(chTable,chSel)
%%% Resolve _act/_dea columns to check (port of chSelMask_lfn) %%%%%%%%%%%%
% "any":  all _act/_dea columns present in chTable (least circular).
% "self": only columns whose base-name prefix matches sanitized chSel.cond
%         (e.g. cond=["Semantic" "Episodic"] → Semantic_act/dea, Episodic_act/dea).
varNames   = string(chTable.Properties.VariableNames);
actDeaVars = varNames(endsWith(varNames,"_act") | endsWith(varNames,"_dea"));

cond1Sample = "any";
if isfield(chSel,"cond1Sample") && isany(chSel.cond1Sample)
    cond1Sample = string(chSel.cond1Sample);
end

if cond1Sample=="self" && isfield(chSel,"cond") && ~isempty(chSel.cond)
    vars = actDeaForConds_lfn(actDeaVars, string(chSel.cond(:))');
    if isempty(vars)
        warning("[ec_selectChsBySig] No _act/_dea cols matched for cond [%s]; using all",...
            strjoin(string(chSel.cond),", "));
        vars = actDeaVars;
    end
else
    vars = actDeaVars;  % "any" — use all act/dea columns
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
