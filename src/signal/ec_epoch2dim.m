function [y,ob,n] = ec_epoch2dim(x,ep,n,tt,a)
% Reshapes EEG data from ec_analPrep() to have epoch as the first dimension.
% Epochs are treated as observations; timepoints with multiple frames
% (i.e., timebins) are concatenated along the first dimension per epoch.
%
% Part of the electroCUDA package (https://github.com/kevmtan/electroCUDA)

%% Input validation
arguments
    x (:,:,:){mustBeFloat}
    ep table
    n struct
    tt uint64 = tic % Timer
    a.epochVar (1,1) string = "tr" % Epoch variable in ep
    a.timeVar (1,1) string = "t" % Time variable in ep
    a.timeGrid = [] % Canonical dim2 time grid ([]=infer from n.times/ep)
    a.trialVars (1,:) string = [];
    a.strict (1,1) logical = true % Strict validation and erroring
end
% tt=tic;


%% Validate metadata fields
notes = string([]);

mustHave = [a.epochVar a.timeVar];
if ~all(ismember(mustHave,ep.Properties.VariableNames))
    miss = mustHave(~ismember(mustHave,ep.Properties.VariableNames));
    error("[ec_epoch2dim] Missing required ep variable(s): %s",strjoin(miss,", "));
end

% Ensure a usable trial id for compatibility metadata
if ~ismember("tr",string(ep.Properties.VariableNames))
    if a.strict
        error("[ec_epoch2dim] ep must include variable 'tr' (strict=true).");
    else
        ep.tr = ep.(a.epochVar);
    end
end

% Validate variables from n.trialNfo to move to 'ob'
trialVars = unique(["run" "cnd" a.trialVars],"stable");
trialVars = trialVars(ismember(trialVars,n.trialNfo.Properties.VariableNames)); % check if exist

% Validate and standardize x
nRows = height(ep);
isROI = iscell(x);
if isROI
    if ~isvector(x)
        error("[ec_epoch2dim] ROI cell input must be a vector cell array.");
    end
    roiId = find(~cellfun(@isempty,x,UniformOutput=true));
    if isempty(roiId)
        error("[ec_epoch2dim] ROI cell input has no nonempty elements.");
    end
    for r = roiId(:)'
        validateX_lfn(x{r},nRows,r);
    end
else
    validateX_lfn(x,nRows,0);
end


%% Build canonical time grid
tVal = ep.(a.timeVar);
if isempty(a.timeGrid)
    timeGrid = getTimeGrid_lfn(tVal,n,a.timeVar);
else
    timeGrid = a.timeGrid(:);
    if isdatetime(tVal) || isduration(tVal)
        timeGrid = sort(timeGrid);
    else
        timeGrid = sort(unique(timeGrid));
    end
end

% Find timeGrid indices of ep.timeVar
[epIn,timeIdx] = ismember(tVal,timeGrid);
if any(~epIn)
    % Error/warn
    msg = sprintf("%d rows in ep.%s not present in timeGrid",nnz(~epIn),a.timeVar);
    if a.strict
        error(msg); %#ok<SPERR>
    else
        notes(end+1,1) = "Removed "+msg;
        warning("[ec_epoch2dim] "+notes(end)+": "+n.sbj);
        timeIdx = timeIdx(epIn);
        ep = ep(epIn,:);
        if isROI
            for r = roiId(:)'
                x{r} = x{r}(epIn,:,:);
            end
        else
            x = x(epIn,:,:);
        end
    end
end


%% Index mapping (epoch, time, frame replicate)
[epochIdx,epochVals] = findgroups(ep.(a.epochVar));
nRows = height(ep);
nEpoch = numel(epochVals);
nTime = numel(timeGrid);

% Frame index within each (epoch,time) group (stable in row order)
%   TODO: make this clearer?
key = (epochIdx-1) * (max(nTime,1)) + timeIdx;
[~,~,kidx] = unique(key,"stable");
frameIdx = zeros(nRows,1);
kCount = zeros(max(kidx),1);
for i = 1:nRows
    kk = kidx(i);
    kCount(kk) = kCount(kk) + 1;
    frameIdx(i) = kCount(kk);
end
nObsPerEpoch = max(frameIdx);
obsRow = (epochIdx-1)*nObsPerEpoch + frameIdx;
nObs = nEpoch * nObsPerEpoch;
disp("[ec_epoch2dim] Mapped reshaping indices: "+n.sbj+" toc="+toc(tt));


%% Reshape EEG data
if isROI
    y = x;
    for r = roiId(:)'
        y{r} = reshape_lfn(x{r},obsRow,timeIdx,nObs,nTime);
    end
else
    y = reshape_lfn(x,obsRow,timeIdx,nObs,nTime);
end
disp("[ec_epoch2dim] Reshaped EEG data: "+n.sbj+" toc="+toc(tt));


%% Observations table
epochRep = accumarray(epochIdx,(1:nRows)',[nEpoch 1],@min);
trByEpoch = ep.tr(epochRep);
epochIdxObs = repelem((1:nEpoch)',nObsPerEpoch);
frameIdxObs = repmat((1:nObsPerEpoch)',nEpoch,1);

% Initialize observations table
ob = table;
ob.sbjID(1:nObs) = n.sbjID;
ob.tr = trByEpoch(epochIdxObs,:);
ob.frame = frameIdxObs;

% Find trialNfo indices of observation trials
[obIn,trId] = ismember(ob.tr,n.trialNfo.tr);
if any(~obIn)
    msg = "Removed trials in 'ep' not found in 'n.trialNfo'";
    notes(end+1,1) = msg;
    warning("[ec_epoch2dim] "+msg+": "+n.sbj);

    % Restrict to existing trials
    ob = ob(obIn,:);
    trId = trId(obIn);
    nObs = height(ob);
end

% Copy trialNfo vars to observation table
ob(:,trialVars) = n.trialNfo(trId,trialVars);

% Get number of timepoints (dim2) filled per observation
[~,iu] = unique([obsRow,timeIdx],"rows","stable");
obsUniq = obsRow(iu);
ob.nTimes = uint16(accumarray(obsUniq,1,[nObs 1],@sum,0));
disp("[ec_epoch2dim] Made observations table: "+n.sbj+" toc="+toc(tt));


%% Finalize
n.nObs = nObs;
n.nObsPerEpoch = nObsPerEpoch;
n.epoch2dim_notes = notes;




function validateX_lfn(x,nRows,r)
%%% Validate input EEG data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isnumeric(x)
    if r==0
        error("[ec_epoch2dim] x must be numeric array.");
    else
        error("[ec_epoch2dim] x{%d} must be numeric array.",r);
    end
end
if size(x,1)~=nRows
    if r==0
        error("[ec_epoch2dim] size(x,1) must equal height(ep).");
    else
        error("[ec_epoch2dim] size(x{%d},1) must equal height(ep).",r);
    end
end
if ndims(x)>3
    if r==0
        error("[ec_epoch2dim] x supports only 2D or 3D arrays.");
    else
        error("[ec_epoch2dim] x{%d} supports only 2D or 3D arrays.",r);
    end
end




function y = reshape_lfn(x,obsRow,timeIdx,nObs,nTime)
%%% Reshape EEG array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
szX = size(x);
y = nan([nObs nTime szX(2:end)],like=x); % preallocate

% Loop over rows of original EEG data
for w = 1:szX(1)
    y(obsRow(w),timeIdx(w),:,:) = x(w,:,:);
end




function timeGrid = getTimeGrid_lfn(tVal,n,timeVar)
%%% Get timeGrid %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prefer n metadata to reduce redundant recomputation and enforce consistency.
if isfield(n,"times") && ~isempty(n.times)
    nt = n.times;
    if istable(nt)
        if ismember(timeVar,nt.Properties.VariableNames)
            timeGrid = nt.(timeVar);
        elseif ismember("t",nt.Properties.VariableNames)
            timeGrid = nt.t;
        end
    else
        timeGrid = nt(:);
    end
else
    timeGrid = unique(tVal,"sorted");
end