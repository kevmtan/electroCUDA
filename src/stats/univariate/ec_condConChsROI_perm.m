function st = ec_condConChsROI_perm(o)
% Second-level ROI permutation test on subject-level contrast estimates
% from ec_condConChs_perm. Each channel ('sbjCh') is one observation by
% default; o.avgVars (e.g., "sbjID") collapses observations beforehand.
% Only 1-sample tests against 0 are supported; o.cond0 is always [].

%% Input validation
arguments
    o struct
end

if isfield(o,"cond0") && ~isempty(o.cond0)
    warning("[ec_condConChsROI_perm] o.cond0 ignored — 1-sample meta-analytic test only");
end
o.cond0 = [];



%% Prep
tt = tic; % start timer

% Get directories
dirs = ec_getDirs(o.proj,o.task);

% Source channelwise analysis directory ('ec_condConChs_perm' outputs)
chsDir = dirs.anal+o.chsDir+filesep+o.chsName+filesep;

% Load logs
fn = chsDir+"logs_"+o.chsName+".mat";
load(fn,"logs");
disp("[ec_condConChsROI_perm] Loaded: "+fn+" | toc="+toc(tt));

% Load chNfoA
fn = chsDir+"chNfoA_"+o.chsName+".mat";
load(fn,"chNfoA");
disp("[ec_condConChsROI_perm] Loaded: "+fn+" | toc="+toc(tt));

if ~ismember("roi",chNfoA.Properties.VariableNames)
    error("[ec_condConChsROI_perm] chNfoA missing 'roi' column; assign ROIs first");
end

% Default ROIs: all named ROIs in chNfoA (exclude unassigned "" / missing)
if ~isany(o.ROIs)
    rois = unique(string(chNfoA.roi),"stable");
    o.ROIs = rois(rois~="" & ~ismissing(rois));
end
nROIs = numel(o.ROIs);

% Load 'n' of first subject for times/metadata
load(logs.n(1),"n");
disp("[ec_condConChsROI_perm] Loaded 'n' of 1st sbj: "+logs.n(1)+" | toc="+toc(tt));

% Output directory
outDir = dirs.anal+o.analDir+filesep+o.analName+filesep;
if ~isfolder(outDir); mkdir(outDir); end


%% Load per-subject 'st' (with 'roi' attached) & concatenate
[stA,o] = prepSbj_lfn(logs,o,tt);
nCons = numel(o.contrasts);


%% Channel selection setup
[chNfoSel,oCh,o] = chSelection_lfn(o,dirs,chsDir,tt);

% Save options (after contrasts and channel-selection opts are resolved)
fn = outDir+"o.mat";
save(fn,"o","-v7");
disp("[ec_condConChsROI_perm] Saved: "+fn+" | toc="+toc(tt));


%% Run ROIs
st = cell(nROIs,1);
for r = 1:nROIs
    idr = stA.roi==string(o.ROIs(r));
    if ~any(idr)
        warning("[ec_condConChsROI_perm] No channels in ROI: "+string(o.ROIs(r)));
        continue;
    end
    st{r} = runROI_lfn(stA(idr,:),o.ROIs(r),n,o,chNfoSel,oCh,tt);
end
st = st(~cellfun(@isempty,st));
st = vertcat(st{:});


%% All-ROI FDR per contrast (qa)
if o.correct == "none"
    st.qa = nan(size(st.p),o.floatOut);
    for c = 1:nCons
        id = st.contrast==o.contrasts(c);
        if numel(o.fdrTimeRng)==2
            id = id & st.time>=o.fdrTimeRng(1) & st.time<=o.fdrTimeRng(2);
        end
        % FDR for this contrast across ROIs × timepoints × frequencies
        st.qa(id,:) = ec_fdr(st.p(id,:),o.alpha,o.fdrDep);
    end
end


%% Save
fn = outDir+"st.mat";
save(fn,"st","-v7");
disp("[ec_condConChsROI_perm] Saved: "+fn+" | toc="+toc(tt));




function [stA,o] = prepSbj_lfn(logs,o,tt)
%%% Load subject channelwise data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stA = cell(height(logs),1);
parfor s = 1:height(logs)
    stA{s} = loadSbj_lfn(logs(s,:),tt);
end
stA = vertcat(stA{:});

% Restrict to requested ROIs
stA = stA(ismember(stA.roi,string(o.ROIs)),:);


%% Contrasts

% Default contrasts: all unique contrasts in the loaded data
if ~isany(o.contrasts)
    o.contrasts = unique(stA.contrast,"stable");
    disp("[ec_condConChsROI_perm] Defaulted contrasts from data: "+join(string(o.contrasts),", "));
end

% Cond1: each contrast tests itself against 0 (cnd in ob = st.contrast)
if isempty(o.cond1)
    o.cond1 = string(o.contrasts(:));
end
% Pad cell-of-strings to nContrasts-by-maxWidth string array
if iscell(o.cond1)
    nCons = numel(o.contrasts);
    cond = repmat(string(missing),nCons,max(cellfun(@numel,o.cond1)));
    for c = 1:nCons
        cnd = string(o.cond1{c});
        cond(c,1:numel(cnd)) = cnd;
    end
    o.cond1 = cond;
end





function st = loadSbj_lfn(sLog,tt)
st = [];
if ~sLog.fin; return; end

% Load
load(sLog.st,"st");
load(sLog.n,"n");

% ROI variable
if ~ismember("roi",n.chNfo.Properties.VariableNames)
    warning("[ec_condConChsROI_perm] sbj "+sLog.sbj+" chNfo missing 'roi'; skipping");
    st = []; return;
end

% Map sbjCh -> roi via n.chNfo; drop channels with no ROI assignment
[tf,idx] = ismember(st.sbjCh,n.chNfo.sbjCh);
st.roi(:) = string(missing);
st.roi(tf) = string(n.chNfo.roi(idx(tf)));
st = st(st.roi~="" & ~ismissing(st.roi),:);
disp("[ec_condConChsROI_perm] Loaded sbj "+sLog.sbj+" | toc="+toc(tt));




function [chNfoA,oCh,o] = chSelection_lfn(o,dirs,chsDir,tt)
%%% Channel selection for inclusion in ROI analyses %%%%%%%%%%%%%%%%%%%%%%%
chNfoA = []; oCh = [];
if isfield(o,"chSel") && o.chSel
    % Resolve chSel source path
    if isfield(o,"chSelName") && isany(o.chSelName)
        selName = string(o.chSelName);
        if isfield(o,"chSelDir") && isany(o.chSelDir)
            selPath = dirs.anal+o.chSelDir+filesep+selName+filesep;
        else
            selPath = dirs.anal+o.chsDir+filesep+selName+filesep;
        end
    else
        selName = o.chsName;
        selPath = chsDir;
    end

    % Load chNfoA from the channel selection source
    fn = selPath+"chNfoA_"+selName+".mat";
    if isfile(fn)
        load(fn,"chNfoA"); % Load
        disp("[ec_condConChsROI_perm] Loaded chNfoSel: "+fn+" | toc="+toc(tt));
        d = dir(selPath+"o_*.mat");
        if ~isempty(d)
            Soch = load(selPath+string(d(1).name),"o"); oCh = Soch.o;
            disp("[ec_condConChsROI_perm] Loaded oCh from: "+selPath+string(d(1).name)+" | toc="+toc(tt));

            % Normalize cond1/cond0 to padded string matrix (same conversion
            % as ec_condConChs_perm.runSbj_lfn; the saved o predates it)
            nChCons = numel(oCh.contrasts);
            for fld = ["cond1" "cond0"]
                if isfield(oCh,fld) && iscell(oCh.(fld))
                    cv = oCh.(fld);
                    w  = max(cellfun(@numel,cv));
                    sm = repmat(string(missing),nChCons,w);
                    for cc = 1:nChCons
                        v = string(cv{cc}); if isempty(v); continue; end
                        sm(cc,1:numel(v)) = v;
                    end
                    oCh.(fld) = sm;
                end
            end
        end
    else
        warning("[ec_condConChsROI_perm] chNfoSel not found: "+fn+"; skipping channel selection");
    end
end

% Store normalized source cond1/cond0 in o for saved reference
if ~isempty(oCh)
    if isfield(oCh,"cond1")
        o.chsCond1 = oCh.cond1; end
    if isfield(oCh,"cond0")
        o.chsCond0 = oCh.cond0; end
end





function str = runROI_lfn(stRoi,roi,n,o,chNfoSel,oCh,tt)
%%% Run stats for one ROI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
roi = string(roi);
nCons = numel(o.contrasts);

% obsKey determines the observation unit (sbjCh, or collapsed avgVars)
if isfield(o,"avgVars") && isany(o.avgVars)
    obsKey = string(o.avgVars(:))';
else
    obsKey = "sbjCh";
end

% Per-contrast: channel selection → averaging → baseline → test.
% Selection happens first so excluded channels don't affect the
% grand-pool baseline estimate or subject-level averaging.
str = cell(nCons,1);
for c = 1:nCons
    cond1c = o.cond1(c, ~ismissing(o.cond1(c,:)));

    %% Channel selection (on raw long-format rows, before averaging/baseline)
    stC = stRoi(ismember(stRoi.contrast, cond1c), :);
    if ~isempty(chNfoSel) && ~isempty(stC)
        selMask = chSelMask_lfn(chNfoSel,oCh,o,c);
        selChs  = string(chNfoSel.sbjCh(selMask));
        stC = stC(ismember(string(stC.sbjCh), selChs), :);
        if isempty(stC)
            warning("[ec_condConChsROI_perm] No channels after selection: "+o.contrasts(c)+" roi="+roi);
            continue;
        end
        disp("[ec_condConChsROI_perm] "+numel(unique(stC.sbjCh))+" ch selected | "+o.contrasts(c)+" roi="+roi);
    end

    %% Optional pre-averaging across obsKey vars (e.g., subject-level)
    if isfield(o,"avgVars") && isany(o.avgVars)
        stC = avgObs_lfn(stC,o,roi,tt);
    end

    %% Build obsId, reshape long → wide (nObs × nTimes × nFreq)
    if isscalar(obsKey)
        stC.obsId = string(stC.(obsKey));
    else
        parts = strings(height(stC),numel(obsKey));
        for k = 1:numel(obsKey)
            parts(:,k) = string(stC.(obsKey(k)));
        end
        stC.obsId = join(parts,"_",2);
    end
    stC = sortrows(stC,["obsId","time"]);
    [~,ia] = unique(stC.obsId,"stable");
    nObs = numel(ia);
    if mod(height(stC),nObs)~=0
        error("[ec_condConChsROI_perm] Non-uniform timepoints per obs in ROI: "+roi+" contrast: "+o.contrasts(c));
    end
    nTimes = height(stC)/nObs;
    mu   = stC.(o.mVar);
    nFreq = size(mu,2);
    xC   = permute(reshape(mu,nTimes,nObs,nFreq),[2 1 3]);
    obC  = stC(ia,:);
    obC.cnd = obC.contrast;

    %% Optional pooled baseline correction (only selected channels pooled)
    if isfield(o,"baseline") && isany(o.baseline)
        xC = baselineCorr_lfn(xC,obC,n,roi,o,tt);
    end

    %% Run contrast
    str{c} = ec_contrast_perm(xC, obC, n, o, c, tt);

    % Replace cond1/cond0 with channelwise values from first obs
    for sv = ["cond1" "cond0"]
        if ismember(sv, obC.Properties.VariableNames)
            str{c}.(sv) = repmat(obC.(sv)(1,:), height(str{c}), 1);
        end
    end
end

% Finalize
str = vertcat(str{:});
if ismember("cond0",str.Properties.VariableNames)
    str = movevars(str,"cond0",Before="cond1");
end
str.roi(:) = roi;
str = movevars(str,"roi",Before=1);
disp("[ec_condConChsROI_perm] Finished contrasts for: "+roi+" | toc="+toc(tt));




function stRoi = avgObs_lfn(stRoi,o,roi,tt)
%%% Average mVar across observations grouped by avgVars × contrast × time %%
grpByVars = unique([string(o.avgVars(:))', "contrast","time"],"stable");
idVars = ismember(grpByVars,string(stRoi.Properties.VariableNames));
if ~all(idVars)
    warning("[ec_condConChsROI_perm] o.avgVars not in stRoi: "+...
        join(grpByVars(~idVars),", "));
end
grpByVars = grpByVars(idVars);

[~,ia,grpIdx] = unique(stRoi(:,grpByVars),"rows","stable");
nGrps = numel(ia);

% Average the test variable (accumulate in floatAnal precision)
mu = stRoi.(o.mVar);
muAvg = zeros(nGrps,size(mu,2),o.floatAnal);
for g = 1:nGrps
    idg = grpIdx==g;
    switch o.avgType
        case "mean";   muAvg(g,:) = mean(mu(idg,:),1,"omitmissing");
        case "median"; muAvg(g,:) = median(mu(idg,:),1,"omitmissing");
    end
end

% Keep first row per group for metadata, replace mVar with averaged values
stRoi = stRoi(ia,:);
stRoi.(o.mVar) = muAvg;
disp("[ec_condConChsROI_perm] Averaged by: "+join(grpByVars,",")+...
    " | nObs: "+numel(grpIdx)+"->"+nGrps+" | roi: "+roi+" | toc="+toc(tt));




function selMask = chSelMask_lfn(chNfoSel,oCh,o,c)
%%% Logical row mask over chNfoSel rows for contrast c %%%%%%%%%%%%%%%%%%%%
%
% 2-sample contrasts: channels where cond1 OR cond0 had any act/dea
% 1-sample "any":     channels with any act/dea across all contrasts
% 1-sample "self":    channels where the same contrast's cond1 had act/dea
%                     (more circular — use knowingly)
con      = string(o.contrasts(c));
varNames = string(chNfoSel.Properties.VariableNames);
actDeaVars = varNames(endsWith(varNames,"_act") | endsWith(varNames,"_dea"));

% Look up cond1 / cond0 for this contrast in the channelwise opts
% (oCh was already normalized to padded string matrix at load time)
cond1ch = string([]); cond0ch = string([]);
if ~isempty(oCh) && isfield(oCh,"contrasts")
    [tf,idx] = ismember(con, string(oCh.contrasts));
    if tf
        cond1ch = string(oCh.cond1(idx, ~ismissing(oCh.cond1(idx,:))));
        if isfield(oCh,"cond0") && ~isempty(oCh.cond0)
            row0 = string(oCh.cond0(idx, ~ismissing(oCh.cond0(idx,:))));
            cond0ch = row0(isany(row0));
        end
    end
end

is2sample = ~isempty(cond0ch) && isany(cond0ch);

% Determine which column prefixes to OR over
if is2sample
    checkPfx = regexprep(string([cond1ch(:)' cond0ch(:)']),"[^a-zA-Z0-9_]","");
elseif ~isfield(o,"chSel1Sample") || o.chSel1Sample=="any"
    checkPfx = string([]);  % empty = use all act/dea cols
else
    % "self": same-contrast conditions
    if ~isempty(cond1ch)
        checkPfx = regexprep(string(cond1ch(:)'),"[^a-zA-Z0-9_]","");
    else
        checkPfx = regexprep(con,"[^a-zA-Z0-9_]",""); % fall back to contrast name
    end
end

% Resolve to actual column names
if isempty(checkPfx)
    checkVars = actDeaVars;
else
    colBase   = regexprep(actDeaVars,"_(act|dea)$","");
    checkVars = actDeaVars(ismember(colBase, checkPfx));
    if isempty(checkVars)
        warning("[ec_condConChsROI_perm] No act/dea cols matched for %s; using all",con);
        checkVars = actDeaVars;
    end
end

% Row mask: true if any checked column has any true entry (any freq band)
selMask = false(height(chNfoSel),1);
for v = checkVars
    dat = chNfoSel.(v);
    if islogical(dat) || isnumeric(dat)
        selMask = selMask | any(dat,2);
    end
end




function x = baselineCorr_lfn(x,ob,n,roi,o,tt)
%%% Pooled baseline correction across sbjCh within contrast %%%%%%%%%%%%%%
% Mirrors ec_condConROI_perm.baselineCorr_lfn but applied to reshaped
% x (nObs × nTimes × nFreq). Each obs is one sbjCh-contrast pair, so
% pooling within [sbjCh, cnd] groups is trivially per-obs.

% Baseline time range
if isscalar(o.baseline)
    blRng = [o.baseline, 0];
else
    blRng = o.baseline(1:2);
end

% Baseline time indices (dim 2 of x)
idBL = n.times >= blRng(1) & n.times <= blRng(2);
if ~any(idBL)
    warning("[ec_condConChsROI_perm] No timepoints in baseline range ["+blRng(1)+", "+blRng(2)+"]");
    return
end

% Pooling groups: controlled by o.blGrpVars (default "cnd" = all obs within
% a condition, giving nChannels×nBL samples for a stable grand estimate)
if isfield(o,"blGrpVars") && isany(o.blGrpVars)
    sdGrpVars = string(o.blGrpVars(:))';
else
    sdGrpVars = "cnd";
end
sdGrpVars = sdGrpVars(ismember(sdGrpVars, string(ob.Properties.VariableNames)));

if isempty(sdGrpVars)
    sdGrpIdx = ones(height(ob),1);
else
    [~,~,sdGrpIdx] = unique(ob(:,sdGrpVars),'rows','stable');
end
nSdGrps = max(sdGrpIdx);

% Reshape to obs × times × rest
sz = size(x);
xFlat = cast(reshape(x, sz(1), sz(2), []),o.floatAnal);
nRest = size(xFlat,3);

for g = 1:nSdGrps
    idg = sdGrpIdx == g;

    % Pool baseline samples: (nInGrp*nBL) × 1 × nRest
    poolBL = reshape(xFlat(idg,idBL,:), [], 1, nRest);

    % Baseline central tendency → 1 × 1 × nRest
    switch o.baselineType
        case "mean";   blMean = mean(poolBL, 1, "omitmissing");
        case "median"; blMean = median(poolBL, 1, "omitmissing");
    end

    % Optional normalization by baseline variability
    if isfield(o,"baselineNorm") && isany(o.baselineNorm)
        if o.baselineNorm=="robust"
            blSd = mad(poolBL, 1, 1);  c = 0.6745;
        elseif o.baselineNorm=="zscore"
            blSd = std(poolBL, 1, 1, "omitmissing");  c = 1;
        end
        if any(blSd==0,"all")
            warning("[ec_condConChsROI_perm] blSd=0 for "+nnz(blSd==0)+...
                " element(s) in group "+g+", skipping normalization for those");
            blSd(blSd==0) = 1;
        end
        xFlat(idg,:,:) = c .* (xFlat(idg,:,:) - blMean) ./ blSd;
    else
        xFlat(idg,:,:) = xFlat(idg,:,:) - blMean;
    end
end

x = reshape(xFlat, sz);
disp("[ec_condConChsROI_perm] Baseline ["+blRng(1)+","+blRng(2)+"]"+...
    " | roi: "+roi+" | toc="+toc(tt));