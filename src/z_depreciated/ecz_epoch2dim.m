function [y,ep1,n] = ec_epoch2dim(x,ep,n,a)
% ec_epoch2dim - reshape flattened epoch rows to [obs,time,channel,freq]
%
% Input x is aligned to rows of ep (typically ep.ide from ec_analPrep).
% Output dim1 indexes epoch-frame observations:
%   obsRow = (epochIdx-1)*nObsPerEpoch + frameIdx
%
% Optional ROI mode:
%   if x is a cell vector, each x{r} is reshaped with shared dim1/dim2.
%
% Part of the electroCUDA package (https://github.com/kevmtan/electroCUDA)

%% Input validation
arguments
    x % EEG data: numeric array or ROI cell vector of arrays
    ep table % Epoch metadata table aligned to rows of x
    n struct = struct % Subject info struct from ec_analPrep
    a.timeGrid = [] % Canonical dim2 time grid ([]=infer from n.times/ep)
    a.padValue (1,1) double = NaN % Fill value for missing samples
    a.epochVar (1,1) string = "tr" % Epoch variable in ep
    a.timeVar (1,1) string = "t" % Time variable in ep
    a.ep1KeepCells (1,1) logical = false % Keep time-varying ep vars as *_byTime cells
    a.strict (1,1) logical = true % Strict validation and erroring
end

% Validate metadata fields
mustHave = [a.epochVar a.timeVar];
if ~all(ismember(mustHave,string(ep.Properties.VariableNames)))
    miss = mustHave(~ismember(mustHave,string(ep.Properties.VariableNames)));
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

% Validate and standardize x
isROI = iscell(x);
if isROI
    if ~isvector(x)
        error("[ec_epoch2dim] ROI cell input must be a vector cell array.");
    end
    idf = find(~cellfun(@isempty,x,UniformOutput=true));
    if isempty(idf)
        error("[ec_epoch2dim] ROI cell input has no nonempty elements.");
    end
    for r = idf(:)'
        validateX_lfn(x{r},height(ep),r);
    end
else
    validateX_lfn(x,height(ep),0);
end


%% Align rows
notes = strings(0,1);
if ismember("ide",string(ep.Properties.VariableNames))
    if a.strict && numel(unique(ep.ide))~=height(ep)
        error("[ec_epoch2dim] ep.ide must be unique (strict=true).");
    end
    [~,ord] = sort(ep.ide,"ascend");
    if ~isequal(ord(:),(1:height(ep))')
        notes(end+1,1) = "Sorted rows by ep.ide before reshaping.";
    end
    ep = ep(ord,:);
    if isROI
        for r = idf(:)'
            x{r} = x{r}(ord,:,:);
        end
    else
        x = x(ord,:,:);
    end
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

[tfTime,timeIdx] = ismember(tVal,timeGrid);
if any(~tfTime)
    if a.strict
        error("[ec_epoch2dim] %d rows in ep.%s not present in timeGrid.",nnz(~tfTime),a.timeVar);
    else
        notes(end+1,1) = "Dropped rows with times absent from timeGrid (strict=false).";
        keep = tfTime;
        ep = ep(keep,:);
        timeIdx = timeIdx(keep);
        if isROI
            for r = idf(:)'
                x{r} = x{r}(keep,:,:);
            end
        else
            x = x(keep,:,:);
        end
    end
end


%% Index mapping (epoch, time, frame replicate)
[epochIdx,epochVals] = findgroups(ep.(a.epochVar));
nRows = height(ep);
nEpoch = numel(epochVals);
nTime = numel(timeGrid);

% Frame index within each (epoch,time) group (stable in row order)
key = uint64(epochIdx-1) * uint64(max(nTime,1)) + uint64(timeIdx);
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


%% Build reshaped output
if isROI
    y = x;
    for r = idf(:)'
        y{r} = fillArray_lfn(x{r},obsRow,timeIdx,nObs,nTime,a.padValue);
    end
    nROIs = numel(x);
    firstR = idf(1);
    outRef = y{firstR};
else
    y = fillArray_lfn(x,obsRow,timeIdx,nObs,nTime,a.padValue);
    nROIs = 1;
    outRef = y;
end

%% Build ep1 and epoch/obs tables
epochRep = accumarray(epochIdx,(1:nRows)',[nEpoch 1],@min);
trByEpoch = ep.tr(epochRep);

epochIdxObs = repelem((1:nEpoch)',nObsPerEpoch);
frameIdxObs = repmat((1:nObsPerEpoch)',nEpoch,1);

ep1 = table;
ep1.id1 = (1:nObs)';
ep1.epochIdx = epochIdxObs;
ep1.frameIdx = frameIdxObs;
ep1.tr = trByEpoch(epochIdxObs,:);

% nFilledTime / hasData from unique (obs,time) occupancy
[~,iu] = unique([obsRow,timeIdx],"rows","stable");
obsUniq = obsRow(iu);
nFilled = accumarray(obsUniq,1,[nObs 1],@sum,0);
ep1.nFilledTime = nFilled;
ep1.hasData = nFilled > 0;

% Copy metadata variables from ep to ep1 (policy-based)
[ep1,ep1Vars,notes] = addEpVars_lfn(ep1,ep,epochIdx,epochRep,epochIdxObs,a,notes);

% epoch table
epochTable = table;
epochTable.epochIdx = (1:nEpoch)';
epochTable.tr = trByEpoch;
directVars = setdiff(ep1Vars.copiedDirect,["tr" "id1" "epochIdx" "frameIdx" "hasData" "nFilledTime"]);
for v = directVars(:)'
    if ismember(v,string(ep1.Properties.VariableNames))
        epochTable.(v) = ep1.(v)(epochRepObs_lfn(epochIdxObs,nObsPerEpoch),:);
    end
end

obsTable = ep1(:,["id1","epochIdx","frameIdx","tr","hasData","nFilledTime"]);

%% Build meta (saved into n, not returned)
meta = struct;
meta.version = "ec_epoch2dim_v1";
meta.shape = shapeStruct_lfn(outRef,nObs,nTime,n);
meta.timeGrid = timeGrid;
meta.padValue = cast(a.padValue,classCast_lfn(outRef));
meta.input = struct( ...
    isROI=isROI, ...
    nROIs=nROIs, ...
    epochVar=a.epochVar, ...
    timeVar=a.timeVar);
meta.index = struct( ...
    epochIdx=epochIdx, ...
    timeIdx=timeIdx, ...
    frameIdx=frameIdx, ...
    obsRow=obsRow);
meta.epochTable = epochTable;
meta.obsTable = obsTable;
meta.ep1Vars = ep1Vars;
meta.concatReady = struct( ...
    key=concatKey_lfn(meta.shape,timeGrid), ...
    requirements=["timeGrid","channel axis","frequency axis (if present)"]);
meta.notes = notes;

% Save metadata in n struct for downstream workflows
n.epoch2dim = meta;





function validateX_lfn(x,nRows,r)
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


function y = fillArray_lfn(x,obsRow,timeIdx,nObs,nTime,padValue)
cls = classCast_lfn(x);
if ndims(x)==2
    y = cast(ones(nObs,nTime,size(x,2))*padValue,cls);
    for i = 1:size(x,1)
        y(obsRow(i),timeIdx(i),:) = x(i,:);
    end
else
    y = cast(ones(nObs,nTime,size(x,2),size(x,3))*padValue,cls);
    for i = 1:size(x,1)
        y(obsRow(i),timeIdx(i),:,:) = x(i,:,:);
    end
end


function [ep1,ep1Vars,notes] = addEpVars_lfn(ep1,ep,epochIdx,epochRep,epochIdxObs,a,notes)
vars = string(ep.Properties.VariableNames);
reserved = ["ide","tr","id1","epochIdx","frameIdx","hasData","nFilledTime"];
directCandidates = ["tr","cnd","cond","run","trial","RT","resp","valence"];
timeLike = ["t","latency","bin","frame","pct","binPct","latRT","binRT","pre","stim","post"];

ep1Vars = struct;
ep1Vars.copiedDirect = strings(0,1);
ep1Vars.copiedInvariantOnly = strings(0,1);
ep1Vars.setMissing = strings(0,1);
ep1Vars.cellPreserved = strings(0,1);

for v = vars(:)'
    if ismember(v,reserved)
        continue;
    end

    col = ep.(v);
    if ~isEpVarSupported_lfn(col)
        ep1Vars.setMissing(end+1,1) = v;
        notes(end+1,1) = "Variable '"+v+"' unsupported for ep1 copy; set to missing.";
        ep1.(v) = missingLike_lfn(col,height(ep1));
        continue;
    end

    invByEpoch = isInvariant_lfn(col,epochIdx);
    isTimeLike = ismember(v,timeLike);

    if invByEpoch && (ismember(v,directCandidates) || v==a.epochVar)
        ep1Vars.copiedDirect(end+1,1) = v;
        ep1.(v) = col(epochRep(epochIdxObs),:);
    elseif invByEpoch && ~isTimeLike
        ep1Vars.copiedInvariantOnly(end+1,1) = v;
        ep1.(v) = col(epochRep(epochIdxObs),:);
    elseif invByEpoch && isTimeLike
        ep1Vars.copiedInvariantOnly(end+1,1) = v;
        ep1.(v) = col(epochRep(epochIdxObs),:);
    else
        ep1Vars.setMissing(end+1,1) = v;
        ep1.(v) = missingLike_lfn(col,height(ep1));
        if a.ep1KeepCells
            ep1Vars.cellPreserved(end+1,1) = v;
            ep1.(v+"_byTime") = repmat({[]},height(ep1),1);
        end
    end
end


function tf = isEpVarSupported_lfn(col)
tf = true;
if iscell(col)
    tf = false;
    return;
end
if ismatrix(col) && size(col,2)>1
    tf = false;
end


function tf = isInvariant_lfn(col,grp)
nGrp = max(grp);
tf = true;
for g = 1:nGrp
    id = grp==g;
    idx = find(id,1,"first");
    if isempty(idx)
        continue;
    end
    base = col(idx,:);
    ii = find(id);
    for k = 2:numel(ii)
        if ~isequaln(base,col(ii(k),:))
            tf = false;
            return;
        end
    end
end


function out = missingLike_lfn(col,n)
if isnumeric(col)
    out = nan(n,1,class(col));
elseif islogical(col)
    out = false(n,1);
elseif isstring(col)
    out = strings(n,1);
    out(:) = missing;
elseif iscategorical(col)
    out = categorical(strings(n,1));
elseif isdatetime(col)
    out = NaT(n,1);
elseif isduration(col)
    out = duration(nan(n,1),0,0);
else
    out = repmat(missing,n,1);
end


function shape = shapeStruct_lfn(y,nObs,nTime,n)
sz = size(y);
hasFreq = ndims(y)>=4;
if isfield(n,"xChs") && ~isempty(n.xChs)
    nChan = double(n.xChs);
else
    nChan = sz(3);
end
if hasFreq
    if isfield(n,"spect") && ~isempty(n.spect)
        nFreq = height(n.spect);
    else
        nFreq = sz(4);
    end
else
    nFreq = 1;
end
shape = struct( ...
    dimNames=["obs","time","channel","frequency"], ...
    hasFreq=hasFreq, ...
    nObs=double(nObs), ...
    nTime=double(nTime), ...
    nChan=double(nChan), ...
    nFreq=double(nFreq));


function cls = classCast_lfn(x)
if isa(x,"double")
    cls = "double";
elseif isa(x,"single")
    cls = "single";
else
    cls = class(x);
end


function key = concatKey_lfn(shape,timeGrid)
if isempty(timeGrid)
    tg = "[]";
else
    if isnumeric(timeGrid)
        tg = mat2str(double(timeGrid(:))',6);
    else
        tg = string(numel(timeGrid))+"_nonNumericTimes";
    end
end
key = "ntime="+shape.nTime+";nchan="+shape.nChan+";nfreq="+shape.nFreq+";time="+tg;


function idx = epochRepObs_lfn(epochIdxObs,nObsPerEpoch)
idx = 1:nObsPerEpoch:numel(epochIdxObs);
idx = idx(:);


function timeGrid = getTimeGrid_lfn(tVal,n,timeVar)
% Prefer n metadata to reduce redundant recomputation and enforce consistency.
if isfield(n,"times") && ~isempty(n.times)
    nt = n.times;
    if istable(nt)
        if ismember(timeVar,string(nt.Properties.VariableNames))
            timeGrid = nt.(timeVar);
            return;
        elseif ismember("t",string(nt.Properties.VariableNames))
            timeGrid = nt.t;
            return;
        end
    else
        timeGrid = nt(:);
        return;
    end
end
timeGrid = unique(tVal,"sorted");
