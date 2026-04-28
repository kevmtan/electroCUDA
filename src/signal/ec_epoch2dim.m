function [y,ob,n] = ec_epoch2dim(x,ep,n,tt,a)
% Reshapes EEG data from ec_analPrep() to have epoch as the first dimension.
% Epochs are treated as observations; timepoints with multiple frames
% (i.e., timebins) are concatenated along the first dimension per epoch.
%
% Part of the electroCUDA package (https://github.com/kevmtan/electroCUDA)

%% Input validation
arguments
    x                               % EEG data
    ep table                        % Epoched psychobehavioral metadata
    n struct                        % Subject/recording metadata
    tt uint64 = tic                 % Timer
    a.epochVar (1,1) string = "tr"  % Epoch variable in ep
    a.timeVar (1,1) string = "t"    % Time variable in ep
    a.times (:,1) = []              % Canonical time values ([]=infer from n.times/ep)
    a.trialVars (1,:) string = [];  % n.trialNfo variables to copy to observations table
    a.strict (1,1) logical = false  % Strict validation and erroring
    a.test (1,1) logical = false    % Assert unobserved times remain NaN after reshape
end
% tt=tic;


%% Validate metadata fields
notes = string([]);

% Check if epochVar and timeVar exist
mustHave = [a.epochVar a.timeVar];
if ~all(ismember(mustHave,ep.Properties.VariableNames))
    miss = mustHave(~ismember(mustHave,ep.Properties.VariableNames));
    error("[ec_epoch2dim] Missing required ep variable(s): %s",strjoin(miss,", "));
end
ep.t = ep.(a.timeVar);

% Ensure a usable trial id for compatibility metadata
if ~ismember("tr",ep.Properties.VariableNames)
    if a.strict
        error("[ec_epoch2dim] Trial variable 'ep.tr' not found (strict=true)");
    else
        warning("[ec_epoch2dim] Trial variable 'ep.tr' not found, substituting with epochVar")
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

% Check if trials in 'ep' exist in n.trialNfo
trIn = ismember(ep.tr,n.trialNfo.tr);
if any(~trIn)
    msg = "Removed rows in ep with trials not found in n.trialNfo.tr";
    notes(end+1,1) = msg;
    warning("[ec_epoch2dim] "+msg+": "+n.sbj);
    ep = ep(trIn,:);
    if isROI
        for r = roiId(:)'
            x{r} = x{r}(trIn,:,:);
        end
    else
        x = x(trIn,:,:);
    end
end

% Canonical ordering for deterministic mapping (only if not already sorted)
[x,ep] = sortInputRows_lfn(x,ep,isROI,a);


%% Build canonical time grid
if isempty(a.times)
    times = getTimes_lfn(ep,n);
else
    times = unique(a.times,"sorted");
end

% Find time indices of ep.timeVar
[epIn,timeIdx] = ismember(ep.t,times);
if any(~epIn)
    % Error/warn
    msg = sprintf("%d rows in ep.%s not present in times",nnz(~epIn),a.timeVar);
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
[epochIdx,epochs] = findgroups(ep.(a.epochVar));
nRows = height(ep);
nEpochs = numel(epochs);
nTimes = numel(times);

% Frame index within each (epoch,time) group (stable in row order)
kidx = findgroups(epochIdx,timeIdx);
frameIdx = zeros(nRows,1);
kCount = zeros(max(kidx),1);
for i = 1:nRows
    kk = kidx(i);
    kCount(kk) = kCount(kk) + 1;
    frameIdx(i) = kCount(kk); % frame replicate index within (epoch,time)
end

% Number of observations (dynamic per epoch)
nObsPerEpoch = accumarray(epochIdx,frameIdx,[nEpochs 1],@max,0);
epochObsStart = [0; cumsum(nObsPerEpoch(1:end-1))];
obsRow = epochObsStart(epochIdx) + frameIdx;
nObs = sum(nObsPerEpoch);
disp("[ec_epoch2dim] Mapped reshaping indices: "+n.sbj+" toc="+toc(tt));


%% Observations table
epochRep = accumarray(epochIdx,(1:nRows)',[nEpochs 1],@min);
trByEpoch = ep.tr(epochRep);
epochIdxObs = repelem((1:nEpochs)',nObsPerEpoch);
frameIdxObs = arrayfun(@(k) (1:k)',nObsPerEpoch,UniformOutput=false);
frameIdxObs = vertcat(frameIdxObs{:});

% Initialize observations table
ob = table;
ob.sbjID(1:nObs) = n.sbjID;
ob.tr = trByEpoch(epochIdxObs,:);
ob.frame = frameIdxObs;

% Find trialNfo indices of observation trials
[obIn,trId] = ismember(ob.tr,n.trialNfo.tr);
if any(~obIn)
    error("[ec_epoch2dim] Internal mismatch: ob.tr contains trials missing from n.trialNfo.tr after ep prefilter.");
end

% Copy trialNfo vars to observation table
ob(:,trialVars) = n.trialNfo(trId,trialVars);

% Number of filled timepoints (dim2) per observation
[~,iu] = unique([obsRow,timeIdx],"rows","stable");
obsUniq = obsRow(iu);
ob.nTimes = uint16(accumarray(obsUniq,1,[height(ob) 1],@sum,0));
disp("[ec_epoch2dim] Made observations table: "+n.sbj+" toc="+toc(tt));


%% Reshape EEG data (using finalized observation mapping)
if isROI
    y = x;
    for r = roiId(:)'
        y{r} = reshape_lfn(x{r},obsRow,timeIdx,nObs,nTimes,a.test,r);
    end
else
    y = reshape_lfn(x,obsRow,timeIdx,nObs,nTimes,a.test,0);
end
disp("[ec_epoch2dim] Reshaped EEG data: "+n.sbj+" toc="+toc(tt));

% Test mapping integrity between y & obs
if a.test
    assertMappingIntegrity_lfn(y,ob,obsRow,timeIdx,isROI);
end


%% Finalize
n.nEpochs = nEpochs;
n.nObs = nObs;
n.nObsPerEpoch = nObsPerEpoch;
if a.epochVar=="tr"
    [~,id] = ismember(epochs,n.trialNfo.tr);
    n.trialNfo.nObs = nObsPerEpoch(id);
end
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




function [x,ep] = sortInputRows_lfn(x,ep,isROI,a)
%%% Sort ep/x only if needed %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~issortedrows(ep,[a.epochVar "t"])
    % Sort metadata
    [ep,ord] = sortrows(ep,[a.epochVar "t"]);

    % Sort EEG data
    if isROI
        roiId = find(~cellfun(@isempty,x,UniformOutput=true));
        for r = roiId(:)'
            x{r} = x{r}(ord,:,:);
        end
    else
        x = x(ord,:,:);
    end
end




function assertMappingIntegrity_lfn(y,ob,obsRow,timeIdx,isROI)
%%% Invariant checks for x/ep -> y/ob mapping %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isROI
    firstR = find(~cellfun(@isempty,y),1);
    nObsY = size(y{firstR},1);
else
    nObsY = size(y,1);
end
assert(height(ob)==nObsY,...
    "[ec_epoch2dim] Invariant failed: height(ob) must equal size(y,1).");
assert(all(obsRow>=1) && all(obsRow<=height(ob)),...
    "[ec_epoch2dim] Invariant failed: obsRow out of bounds.");
assert(all(timeIdx>=1),...
    "[ec_epoch2dim] Invariant failed: timeIdx must be positive.");
obsCounts = accumarray(obsRow,1,[height(ob) 1],@sum,0);
assert(isequal(uint16(obsCounts),ob.nTimes),...
    "[ec_epoch2dim] Invariant failed: ob.nTimes does not match mapped rows.");




function times = getTimes_lfn(ep,n)
%%% Get times %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isfield(n,"times") && ~isempty(n.times)
    % Use n.times metadata to reduce redundant recomputation and enforce consistency.
    if ~isnumeric(n.times)
        % Validate n.times
        error("[ec_epoch2dim] n.times must be numeric.");
    end
    times = unique(n.times(:),"sorted");
else
    times = unique(ep.t,"sorted");
end




function y = reshape_lfn(x,obsRow,timeIdx,nObs,nTime,test,roiIdx)
%%% Reshape EEG array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
szX = size(x);
y = nan([nObs nTime szX(2:end)],like=x); % preallocate

% Loop over rows of original EEG data
for w = 1:szX(1)
    y(obsRow(w),timeIdx(w),:,:) = x(w,:,:);
end
if test
    assertMissingTimes_lfn(y,obsRow,timeIdx,nObs,nTime,roiIdx);
end




function assertMissingTimes_lfn(y,obsRow,timeIdx,nObs,nTimes,roiIdx)
%%% Assert unobserved obs-time slots remain NaN %%%%%%%%%%%%%%%%%%%%%%%%%%%
present = false(nObs,nTimes);
present(sub2ind([nObs nTimes],obsRow,timeIdx)) = true;
missing = ~present;

% Collapse feature dims to check whether any non-NaN exists at missing slots
y2 = reshape(y,nObs,nTimes,[]);
bad = any(~isnan(y2),3) & missing;
if any(bad,"all")
    nBad = nnz(bad);
    if roiIdx>0
        error("[ec_epoch2dim] Found %d non-NaN values in missing obs-time slots (ROI=%d).",nBad,roiIdx);
    else
        error("[ec_epoch2dim] Found %d non-NaN values in missing obs-time slots.",nBad);
    end
end