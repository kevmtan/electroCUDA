function st = ec_condConROI_perm(o)
%% Input validation
arguments
    o struct
end

% Errors
if isempty(o.cond1) || (isstring(o.cond1) && ~isany(o.cond1,"all")) ||...
     (iscell(o.cond1) && ~any(cellfun(@isany,o.cond1)))
    error("[ec_condConROI_perm] Must have at least one comparison condition");
end
if iscell(o.cond1) && numel(o.cond1)~=numel(o.contrasts)
    error("[ec_condConROI_perm] o.contrasts and o.cond1 must be same length");
end


%% Prep
tt = tic; % start timer
nROIs = numel(o.ROIs);
nCons = numel(o.contrasts);

% Get directories
dirs = ec_getDirs(o.proj,o.task);

% Load sbjROI
fn = dirs.anal+o.roiDir+filesep+o.roiName+filesep+"sbjROIs_"+o.roiName;
load(fn,"sbjROIs");
disp("[ec_condConROI_perm] Loaded: "+fn+" toc="+toc(tt));

% Load logs
fn = dirs.anal+o.roiDir+filesep+o.roiName+filesep+"logs_"+o.roiName;
load(fn,"logs");
disp("[ec_condConROI_perm] Loaded: "+fn+" toc="+toc(tt));

% Load 'n' of first subject to get times/other info
load(logs.n(1),"n");
disp("[ec_condConROI_perm] Loaded 'n' of 1st subject: "+logs.n(1)+" toc="+toc(tt));

% Make analysis output directory
outDir = dirs.anal+o.analDir+filesep+o.analName+filesep;
if ~isfolder(outDir); mkdir(outDir); end

% Save options
fn = outDir+"o.mat";
save(fn,"o","-v7");
disp("[ec_condConROI_perm] Saved: "+fn+" | toc="+toc(tt));


%% Contrast conditions

% Convert o.condx cells to nContrasts-by-maxWidth string array (pad with missing)
if iscell(o.cond1)
    cond = repmat(string(missing),nCons,max(cellfun(@numel,o.cond1)));
    for c = 1:nCons
        cnd = string(o.cond1{c});
        cond(c,1:numel(cnd)) = cnd;
    end
    o.cond1 = cond;
end
if ~isempty(o.cond0) && iscell(o.cond0)
    cond = repmat(string(missing),nCons,max(cellfun(@numel,o.cond0)));
    for c = 1:nCons
        cnd = string(o.cond0{c});
        cond(c,1:numel(cnd)) = cnd;
    end
    o.cond0 = cond;
end

% Preallocate stats table
st = cell(nROIs,1);


%% Run ROIs
for r = 1:nROIs
    idr = sbjROIs.roi==o.ROIs(r);
    st{r} = runROI_lfn(sbjROIs(idr,:),n,o,tt);
end

% Concatenate across ROIs
st = vertcat(st{:});


%% FDR across all tests (skipped when max-stat or TFCE correction is in use)
if o.correct=="none"
    % Loop across contrasts
    for c = 1:nCons
        % Indices for contrast
        id = st.contrast==o.contrasts(c);
        if numel(o.fdrTimeRng)==2
            % Indices within FDR time range
            id = id & st.time>=o.fdrTimeRng(1) & st.time<=o.fdrTimeRng(2);
        end

        % Run FDR for contrast across ROIs, timepoints & frequencies
        st.qa = nan(size(st.p),o.floatOut);
        st.qa(id,:) = ec_fdr(st.p(id,:),o.alpha,o.fdrDep);
    end
end


%% Save
fn = outDir+"st.mat";
save(fn,"st","-v7");
disp("[ec_condConROI_perm] Saved: "+fn+" | toc="+toc(tt));





function str = runROI_lfn(ROI,n,o,tt)
%%% Run stats for ROI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                       ROI=sbjROIs(idr,:);
roi = string(ROI.roi(1));
nSbjs = height(ROI);
nCons = numel(o.contrasts);

% Preallocate
x = cell(nSbjs,1); % ROI EEG data
ob = cell(nSbjs,1); % ROI observations
str = cell(nCons,1); % Statistical contrasts


%% Load subject data
[x,ob] = loadSbjData_lfn(x,ob,ROI,o,tt);


%% Average across observations
if isany(o.avgVars)
    [x,ob] = avgObs_lfn(x,ob,roi,o,tt);
end

%% Pooled baseline correction (across trials)
if isany(o.baseline)
    x = baselineCorr_lfn(x,ob,n,roi,o,tt);
end


%% Run contrasts
for c = 1:nCons
    str{c} = ec_contrast_perm(x,ob,n,o,c,tt);
end


%% Finalize
str = vertcat(str{:}); % concatenate across contrasts
str.roi(:) = ROI.roi(1); % add ROI name
str = movevars(str,"roi",Before=1); % move to first column
disp("[ec_condConROI_perm] Finished contrasts for: "+roi+" | toc="+toc(tt));





function [x,ob] = loadSbjData_lfn(x,ob,ROI,o,tt)
%%% Load subject ROI data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
roi = string(ROI.roi(1));
nSbjs = height(ROI);


%% Load across subjects
for s = 1:nSbjs
    % Load EEG
    load(ROI.xr(s),"xr");
    x{s} = xr;

    % Load observations
    load(ROI.obr(s),"obr");
    ob{s} = obr;
end
disp("[ec_condConROI_perm] Loaded data for: "+roi+" | toc="+toc(tt));


%% Concatenate across subjects
x = cell2mat(x);
ob = cell2mat(ob);
if height(x)~=height(ob)
    error("[ec_condConROI_perm] Height of ROI EEG data & observations table don't match");
end

% Standardize condition variable name
ob.cnd = ob.(o.condVar);
disp("[ec_condConROI_perm] Concatenated subject data for: "+roi+" | toc="+toc(tt));





function [x,ob] = avgObs_lfn(x,ob,roi,o,tt)
%%% Average across observations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Validate avgVars exist in ob
grpByVars = unique([string(o.avgVars(:))', "cnd"], 'stable');
idVars = ismember(grpByVars, string(ob.Properties.VariableNames));
if ~all(idVars)
    warning("[ec_condConROI_perm] o.avgVars not found in ob: "+join(grpByVars(~idVars),", "))
end

% Group by avgVars + condition (condition must be preserved for contrasts)
grpByVars = grpByVars(idVars);
[~, ia, grpIdx] = unique(ob(:, grpByVars), 'rows', 'stable');
nGrps = numel(ia);

% Preallocate (accumulate in double to avoid single-precision roundoff)
sz = size(x);
xFlat = cast(reshape(x, sz(1), []),o.floatAnal);
xAvg = zeros(nGrps, size(xFlat,2),o.floatAnal);

% Reshape 2D x(obs,:), average within groups
for g = 1:nGrps
    idg = grpIdx == g;
    switch o.avgType
        case "mean";   xAvg(g,:) = mean(xFlat(idg,:),1,"omitmissing");
        case "median"; xAvg(g,:) = median(xFlat(idg,:),1,"omitmissing");
    end
end

% Restore original shape and cast back to input precision
x = reshape(xAvg, [nGrps, sz(2:end)]);
ob = ob(ia,:); % first row per group — preserves all metadata columns (sbjID etc.)
disp("[ec_condConROI_perm] Averaged by: "+join(grpByVars,",")+...
    " | nObs: "+sz(1)+"->"+nGrps+" | roi: "+roi+" | toc="+toc(tt));





function x = baselineCorr_lfn(x,ob,n,roi,o,tt)
%%% Pooled baseline correction across trials within condition %%%%%%%%%%%%%

% Baseline time range
if isscalar(o.baseline)
    blRng = [o.baseline, 0];
else
    blRng = o.baseline(1:2);
end

% Baseline time indices (dim 2 of x)
idBL = n.times >= blRng(1) & n.times <= blRng(2);
if ~any(idBL)
    warning("[ec_condConROI_perm] No timepoints in baseline range ["+blRng(1)+", "+blRng(2)+"]");
    return
end

% Pooling groups: [sbjROI, sbjCh, cnd] — pool across trials within each
% channel × condition to remove condition-specific pre-stimulus offsets
sdGrpVars = ["sbjROI","sbjCh","cnd"];
sdGrpVars = sdGrpVars(ismember(sdGrpVars, string(ob.Properties.VariableNames)));

if isempty(sdGrpVars)
    sdGrpIdx = ones(height(ob),1);
else
    [~,~,sdGrpIdx] = unique(ob(:,sdGrpVars),'rows','stable');
end
nSdGrps = max(sdGrpIdx);

% Reshape to obs × times × rest so trailing dims stay independent
sz = size(x);
xFlat = cast(reshape(x, sz(1), sz(2), []),o.floatAnal);
nRest = size(xFlat,3);

for g = 1:nSdGrps
    idg = sdGrpIdx == g;

    % Pool all baseline samples across trials for this channel group:
    % (nInGrp*nBL) × 1 × nRest — stable estimate from many more samples
    poolBL = reshape(xFlat(idg,idBL,:), [], 1, nRest);

    % Pooled baseline central tendency → 1 × 1 × nRest
    switch o.baselineType
        case "mean";   blMean = mean(poolBL, 1, "omitmissing");
        case "median"; blMean = median(poolBL, 1, "omitmissing");
    end

    % Pooled baseline variability → 1 × 1 × nRest
    if isany(o.baselineNorm)
        if o.baselineNorm=="robust"
            blSd = mad(poolBL, 1, 1);  c = 0.6745;
        elseif o.baselineNorm=="zscore"
            blSd = std(poolBL, 1, 1, "omitmissing");  c = 1;
        end
        % Zero variance: skip normalization for those elements
        if any(blSd==0,"all")
            warning("[ec_condConROI_perm] blSd=0 for "+nnz(blSd==0)+...
                " element(s) in channel group "+g+", skipping normalization for those");
            blSd(blSd==0) = 1;
        end
        xFlat(idg,:,:) = c .* (xFlat(idg,:,:) - blMean) ./ blSd;
    else
        xFlat(idg,:,:) = xFlat(idg,:,:) - blMean;
    end
end

x = reshape(xFlat, sz);
disp("[ec_condConROI_perm] Baseline ["+blRng(1)+","+blRng(2)+"]"+...
    " | roi: "+roi+" | toc="+toc(tt));