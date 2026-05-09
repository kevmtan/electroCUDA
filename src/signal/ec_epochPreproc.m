function [y,n,o] = ec_epochPreproc(x,n,psy,ep,tt,o)
% Epoch-based preprocessing routines for analysis-specific preprocessing
%   Kevin Tan (2025) | github.com/kevmtan/electroCUDA
%
% Inputs: see next section
%
% Outputs:
%   x = preprocessed epoched EEG data, 2D/3D matrix:
%       x(timeframe,channel/IC,freq/band/component)
%   n = recording information
%   trs = trial/epoch metadata per timepoint
%
% TODO: make downsampling not necessarily divisible by srate, resample()
% doesn't work in parfor threadpool (maybe works for 2026a+?)

%% Input validation
arguments
    x (:,:,:){mustBeFloat}                    % EEG data, 2D/3D matrix: x(timeframe,channel/IC,frequency)
    n struct                                  % Info struct
    psy timetable                             % Task metadata per timepoint
    ep table                                  % Epoch metadata per timepoint
    tt uint64 = tic                           % Timer
    o.test (1,1) logical = false              % Running a test? (keeps removed fields)
    o.gpu (1,1) logical = false               % Run on GPU? (note: CPU appears faster)
    o.hzTarget (1,1) double = 0               % Target sampling rate (0=skip)
    % processing FP precision ("double"|"single"|default=same as input)
    o.floatProc (1,1){mustBeMember(o.floatProc,["double" "single"])} = class(x)
    % output FP precision ("double"|"single"|"half"|default=same as input)
    o.floatOut (1,1){mustBeMember(o.floatOut,["double" "single" "half"])} = class(x)          
    % Trasnform/normalization
    o.log (1,1) logical = false;              % Log transform
    o.mag2db (1,1) logical = false;           % Spectral magnitude to decibel (skip=false)
    o.runNorm (1,1) string = "robust";        % Normalize run (skip="")
    % Within-trial normalization (baseline correction)
    o.trialNorm (1,1) string {mustBeMember(o.trialNorm,["robust" "zscore" ""])} = "robust"; % Normalize trial (skip="")
    o.trialNormDev (1,1) string {mustBeMember(o.trialNormDev,["baseline" "pre" "post" "on" "off" "all"])}...
        = "baseline"; % Timepoints for StdDev relative to stim ["baseline"|"pre"|"post"|"on"|"off"|"all"] (default="baseline")
    o.trialBaseline (1,1) string {mustBeMember(o.trialBaseline,["median" "mean" ""])} = "median"; % Subtract trial by mean or median of baseline period (skip="")
    % Bad frames/outliers
    o.interp (1,1) string {mustBeMember(o.interp,["nearest" "linear" "spline" "pchip" "makima"])}...
        = "linear";
    o.badFrameVars (1,:) string = "" % Bad frame removal vars (n.xBad) to use ["hfo"|"mad"|"diff"|"sns"|...]
    o.olCenter (1,1) string {mustBeMember(o.olCenter,["median" "mean"])} = "median"
    o.olThr (1,1) double = 5                  % Outlier threshold (pre-HPF)
    o.olThr2 (1,1) double = 0                 % Outlier threshold (post-HPF,pre-BL)
    o.olThrBL (1,1) double = 3                % Outlier threshold for baseline period (for baseline correction)
    o.olThrTime (1,1) double = 5              % Outlier threshold within timepoints across epochs
    o.olThrCond (1,1) double = 3              % Outlier threshold for conditions within timepts
    o.olFillTime (1,1) string = "clip"        % Outlier fill method for timepts/conds
    % Spectral frequencies to keep, range per row: [minFreq1 maxFreq2; minFreq1 maxFreq2; ...])
    o.freqs {mustBeNumericOrLogical} = [];
    % PCA within-chan or within-concactenated chans (e.g., make spectral components)
    o.pca (1,1) double = 0; % Spectral components to keep per channel/ROI/whole-brain (skip=0)
    o.pcaVarThr (1,1) double = 0; % Variance threshold for kept PCA comps (0=skip)
    o.pcaCompLims (1,2) double = [0 Inf]; % Bounds on kept PCA comps: [lower upper]
    o.pcaStd (1,1) string {mustBeMember(o.pcaStd,["robust" "zscore" ""])} = ""; % don't standardize to keep baseline at 0
    o.pcaRobust (1,1) logical = false; % Use robust PCA
    o.pcaGPU (1,1) logical = false; % Use GPU for PCA (recommended for robustPCA)
    % Spectral dimensionality reduction into bands (skip=[])
    o.bands (1,1) string = "";                % Band name
    o.bands2 (1,1) string = "";               % Band display name
    o.bandsF double = [];                     % Band freq limits
    % Filtering (within-run):
    o.hpf (1,1) double = 0;                   % HPF cutoff in hertz (skip=0)
    o.hpfSteep (1,1) double = 0.8;            % HPF steepness
    o.hpfImpulse (1,1) string {mustBeMember(o.hpfImpulse,["auto" "fir" "iir"])} = "auto"; % HPF impulse: ["auto"|"fir"|"iir"]
    o.lpf (1,1) double = 0;                   % LPF cutoff in hz (skip=0)
    o.lpfSteep (1,1) double = 0.8;            % LPF steepness
    %o.lpfImpulse {mustBeMember(o.lpfImpulse,["auto" "fir" "iir"])} = "auto"; % LPF impulse: ["auto"|"fir"|"iir"]
end

% Additional validation
if ~isfield(n,"hz0"); error("Must run 'ec_epochPsy' first with same downsampling (if any)"); end
if ~isany(o.hpf); o.hpf=false; end
if ~isany(o.lpf); o.lpf=false; end

% Check bad frame table variables
o.badFrameVars = o.badFrameVars(ismember(o.badFrameVars,n.xBad.Properties.VariableNames));


%% Prep

% Run indexing
if any(o.hzTarget) && o.hzTarget~=n.hz0
    % Downsampling: group indexing for splitapply() due to variable-length outputs
    [psy.runG,runs] = findgroups(psy.run);
    if ~isequal(runs(:),n.runs(:))
        error("Mismatch between psy.run and n.runs");
    end
else
    % Logical run indexing (frames x runs)
    psy.runG = false(height(psy),n.nRuns);
    for r = 1:n.nRuns
        psy.runG(:,r) = psy.run==n.runs(r);
        if ~nnz(psy.runG(:,r))
            error("No observations found for run "+n.runs(r));
        end
    end
end

% Epoch/trial indexing
trG = findgroups(ep.tr); % groups
n.trId = splitapply(@(e){e},ep.ide,trG); % indices

% Timepoint indexing — n.timesG/n.times typically come from ec_analPrep;
% recompute only if missing or stale (height mismatch with ep)
if ~isfield(n,"timesG") || numel(n.timesG)~=height(ep)
    [n.timesG,n.times] = findgroups(ep.time);
end
n.nTimes = height(n.times);
n.timesId = splitapply(@(e){e},ep.ide,n.timesG); % timepoint indices

% Spectral
if isany(o.bands)
    % Band frequency indexing
    n = findBandFreqs_lfn(n,o,tt);
elseif isany(o.freqs)
    % Remove unspecified frequencies from data
    [x,n] = keepFreqs_lfn(x,n,o,tt);
end

% Downsampling
if any(o.hzTarget) && o.hzTarget~=n.hz0
    o = downsamplingPrep_ln(n,o); % downsampling factors & anti-aliasing
else
    o.ds = false;
end

% Make high-pass filter
if o.hpf
    o = makeFilters_lfn(x,n,o,tt);
end


%% All-data preproc

% Remove bad frames (drops n.xBad afterward so parfor doesn't broadcast it)
if isany(o.badFrameVars)
    [x,n] = badFrames_lfn(x,n,o,tt);
elseif ~o.test
    n = rmfield(n,"xBad");
end

% Log-transform
if o.log || o.mag2db
    x = logTransform_lfn(x,n,o,tt); % TODO: move to within-chan (parfor/GPU speedup)
end


%% Main preproc
% The main within-channel routine calls within-run & within-epoch routines

% Reformat/preallocate
y = cell(n.xChs,1);
wts = cell(n.xChs,1); % preallocate channel PCA weights
ranks = nan(n.xChs,1);

% Loop across channels
if o.gpu
    % GPU loop
    for ch = 1:n.xChs
        [y{ch},wts{ch},ranks(ch)] = withinCh_lfn(x(:,ch,:),psy,ep,n,o);
    end
else
    % CPU parallel loop (ideally threadpool)
    parfor ch = 1:n.xChs
        [y{ch},wts{ch},ranks(ch)] = withinCh_lfn(x(:,ch,:),psy,ep,n,o);
    end
end
disp("[ec_epochPreproc] Completed main preproc: "+n.sbj+" time="+toc(tt));


%% Finalize

% Reformat EEG data as matrix
y = ec_cell2dim(y,2);

% PCA info table
if o.pca || o.pcaVarThr || o.pcaRobust
    % Save PCA weights to nfo struct
    n.pca = n.chNfo(:,["sbjID" "ch" "sbjCh"]);
    n.pca.wts = wts;
    n.pca.rank = ranks;

    % Copy previous spectral info struct
    if isfield(n,"spect0")
        n.spect1 = n.spect;
    else
        n.spect0 = n.spect;
    end

    % New spectral info struct
    n.nSpect = size(y,3);
    n.spect = table;
    n.spect.name = "pc"+(1:n.nSpect)';
    n.spect.disp = "Spectral Component "+(1:n.nSpect)';
end

% Remove redundant fields
n = rmfield(n,"trId");
n = rmfield(n,"timesId");
disp("[ec_epochPreproc] Finished: "+n.sbj+" time="+toc(tt));






%%%%%%%%%%%%%%%%% High-level preprocessing routines %%%%%%%%%%%%%%%%%%%%%%%






function [xc,wc,xcRank] = withinCh_lfn(xc,psy,ep,n,o)
%%% Within-channel preprocessing routine (top-level) %%%%%%%%%%%%%%%%%%%%%%
% ch=1; xc=x(:,ch,:);

% Convert EEG format
xc = squeeze(xc); % squeeze
xc = cast(xc,o.floatProc); % convert to specified float type for processing

% Move EEG to GPU
if o.gpu
    xc = gpuArray(xc);
end

%% Within-run preproc
if o.ds
    % Downsampling: variable-length output requires grouped/cell output
    xc = splitapply(@(xcr,stimr,runr) {withinRun_lfn(xcr,stimr,n,o,runr(1))},...
        xc,psy.stim,psy.runG,psy.runG);
    xc = cell2mat(xc); % concatenate downsampled runs
else
    % No downsampling: process each run in place by logical indexing
    for r = 1:n.nRuns
        id = psy.runG(:,r);
        xc(id,:) = withinRun_lfn(xc(id,:),psy.stim(id),n,o,r);
    end
end


%% Within-epoch preproc

% Epoch EEG data
xc = xc(ep.idx,:); % match 'ep' indices

% Baseline correction & normalization
if isany(o.trialNorm) || isany(o.trialBaseline)
    % Loop across epochs
    for e = 1:n.nTrs
        id = n.trId{e};
        xc(id,:) = withinEpoch_lfn(xc(id,:),ep(id,:),o); % call within-trial routine
    end
end


%% Outliers: timepoint & condition
if o.olThrTime || o.olThrCond
    % Call outlier detection per timepoint
    for t = 1:n.nTimes
        id = n.timesId{t};
        xc(id,:) = outliersTime_lfn(xc(id,:),ep.cnd(id),n,o);
    end
end


%% Spectral processing

% Spectral bands
if isany(o.bands)
    xc = constructBands_lfn(xc,n);
end

% Spectral PCA
if o.pca || o.pcaVarThr || o.pcaRobust
    [xc,wc,xcRank] = ec_pca(xc,nComps=o.pca,varThr=o.pcaVarThr,...
        nCompLims=o.pcaCompLims,robust=o.pcaRobust,std=o.pcaStd,...
        gpu=o.pcaGPU||o.gpu);
else
    wc=[]; xcRank=nan;
end


%% Finalize

% Copy from GPU
if o.gpu || o.pcaGPU
    xc = gather(xc);
    wc = gather(wc);
end

% Convert to output float precision
xc = cast(xc,o.floatOut);






function xcr = withinRun_lfn(xcr,stimr,n,o,runId)
%%% Within-run preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% All outliers
if any(o.olThr)
    xcr = filloutliers(xcr,nan,o.olCenter,1,ThresholdFactor=o.olThr);
end

% Interpolate outliers/missing (slower on GPU)
xcr = fillmissing(xcr,o.interp,1,EndValues="nearest");

% High-pass filter
if o.hpf
    xcr = ec_filtfilt(xcr,o.HPF{1},o.HPF{2});
end

% All outliers (2nd round)
if any(o.olThr2)
    xcr = filloutliers(xcr,nan,o.olCenter,1,ThresholdFactor=o.olThr2);
end

% Baseline outliers
if any(o.olThrBL)
    xcr(~stimr,:) = filloutliers(xcr(~stimr,:),nan,o.olCenter,1,ThresholdFactor=o.olThrBL);
end

% Interpolate outliers/missing (slower on GPU)
xcr = fillmissing(xcr,o.interp,1,EndValues="nearest");

% Low-pass filter / anti-aliasing
if o.lpf
    if isfield(o,"lpfMasks") && ~isempty(o.lpfMasks)
        mask = o.lpfMasks{o.lpfRunMaskIdx(runId)};
    else
        mask = [];
    end
    xcr = ec_fft_lowpass(xcr,n,o.lpf,o.lpfSteep,mask);
end

% Downsample
if o.ds
    xcr = xcr(1:o.ds:end,:);
end

% Z-score
if o.runNorm=="robust"
    xcr = normalize(xcr,1,"zscore","robust"); % robust z-score
elseif isany(o.runNorm)
    xcr = normalize(xcr,1,o.runNorm); % standard z-score
end






function xce = withinEpoch_lfn(xce,epe,o)
%%% Within-epoch preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Frames for baseline subtraction
iBL = epe.BLpre | epe.BLpost;

% Frames for std deviation calculation
if o.trialNormDev == "baseline"
    iSD = iBL;
elseif o.trialNormDev == "pre"
    iSD = logical(epe.pre);
elseif o.trialNormDev == "post"
    iSD = logical(epe.post);
elseif o.trialNormDev == "on"
    iSD = logical(epe.stim);
elseif o.trialNormDev == "off"
    iSD = ~epe.stim;
elseif o.trialNormDev == "all"
    iSD = true(height(epe),1);
end

% Errors (check before mutating xce so failures don't leave NaN-poisoned data)
if ~any(iBL) && isany(o.trialBaseline)
    error("No epoch frames marked as baseline (ep.BLpre|ep.BLpost)"); end
if ~any(iSD) && isany(o.trialNorm)
    error("No epoch frames marked as specified in 'o.trialNormDev'"); end

% Get trial baseline
if o.trialBaseline=="median"
    bl = median(xce(iBL,:,:),1,"omitnan"); % BL median
elseif o.trialBaseline=="mean"
    bl = mean(xce(iBL,:,:),1,"omitnan"); % BL mean
else
    bl = 0;
end

% Get trial std deviation
if o.trialNorm=="robust"
    sd = mad(xce(iSD,:,:),1,1); % BL MAD median absolute deviation
    c = 0.6745;
elseif o.trialNorm=="zscore"
    sd = std(xce(iSD,:,:),1,1,"omitnan");
    c = 1;
else
    sd = 1;
    c = 1;
end

% Do baseline correction
xce = c*(xce-bl)./sd;





 
%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






function n = findBandFreqs_lfn(n,o,tt)
%%% Split EEG frequencies into spectral bands %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Copy original frequency info
n.spect0 = n.spect; 
n.spect0.band(:) = string(missing);

% New spectral struct with band info
n.spect = table;
n.spect.name = o.bands';
n.spect.disp = o.bands2';
n.spect.freqs(:) = {[]};

% Find frequencies within bands
for b = 1:numel(o.bands)
    n.spect.id(b,:) = isbetween(n.spect0.freq,o.bandsF(b,1),o.bandsF(b,2),"openright")';
    n.spect.freqs{b} = n.spect0.freq(n.spect.id(b,:));
    n.spect0.band(n.spect.id(b,:)) = n.spect.name(b);
end
n.spect.Properties.RowNames = n.spect.name;
n.nSpect = height(n.spect);
disp("[ec_epochPreproc] Found frequencies within spectral bands: "+n.sbj+" time="+toc(tt));






function [x,n] = keepFreqs_lfn(x,n,o,tt)
%%% Remove spectral frequencies (keep only specified freqs) %%%%%%%%%%%%%%%

% Copy original frequency info
n.spect0 = n.spect;

% Find frequency indices to keep
if islogical(o.freqs)
    n.freqKeep = o.freqs;
else 
    % Frequency ranges
    nRng = size(o.freqs,1); % number of ranges
    n.freqKeep = false(n.nFreqs,nRng); % preallocate

    % Find frequencies per range
    for b = 1:nRng
        n.freqKeep(:,b) = isbetween(n.spect.freq,o.freqs(b,1),o.freqs(b,2));
    end
    n.freqKeep = any(n.freqKeep,2);
end

% Keep specified freqs in EEG data
x = x(:,:,n.freqKeep);
n.spect = n.spect(n.freqKeep,:);
n.nSpect = height(n.spect);
disp("[ec_epochPreproc] Kept "+n.nSpect+"/"+n.nFreqs+" freqs: "+n.sbj+" time="+toc(tt));






function o = downsamplingPrep_ln(n,o)
%%% Downsampling preparation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Downsampling factors
[o.ds(1),o.ds(2)] = rat(o.hzTarget/n.hz0); % get factors
if o.ds(1) > o.ds(2)
    error("[ec_epochPreproc] downsampling target > sampling rate"); end
if o.ds(1) ~= 1
    error("[ec_epochPreproc] downsampling target must be wholly divisible by sampling rate"); end
o.ds = o.ds(2);
disp("[ec_epochPreproc] downsampling factor = "+o.ds);

% Ensure anti-aliasing LPF
hzNyquist = o.hzTarget/2;
if ~o.lpf || o.lpf>hzNyquist
    o.lpf = hzNyquist;
    disp("[ec_epochPreproc] adding downsampling anti-aliasing LPF: "+...
        o.lpf+"hz");
end






function o = makeFilters_lfn(x,n,o,tt)
%%% Make temporal filters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extract EEG timeseries vector from shortest run
[~,id] = min(n.runIdxOg);
xTmp = x(n.runIdx(id,1):n.runIdx(id,2),1,1);
xTmp = cast(xTmp,o.floatProc);
if o.gpu
    xTmp = gpuArray(xTmp); % move to GPU if specified
end

% High-pass filter
if o.hpf
    o.HPF = {};
    [o.HPF{1},o.HPF{2}] = ec_designFilt(xTmp,n.hz0,o.hpf,"highpass",...
        steepness=o.hpfSteep,impulse=o.hpfImpulse,coefOut=true);
    disp("[ec_epochPreproc] Created high-pass filter: "+n.sbj+" time="+toc(tt));
end

% FFT low-pass masks (precompute per unique run length)
if o.lpf
    runLens = n.runIdx(:,2)-n.runIdx(:,1)+1; % samples per run
    [uLens,~,runMaskIdx] = unique(runLens,"stable");
    o.lpfLens = uLens;
    o.lpfRunMaskIdx = runMaskIdx;
    o.lpfMasks = cell(numel(uLens),1);

    % Sampling rate follows current analysis data
    if isfield(n,"hz0")
        fs = n.hz0;
    else
        fs = n.hz;
    end

    % Build one FFT mask per unique run length
    for i = 1:numel(uLens)
        xFrames = uLens(i);
        fNyquist = fs/2;
        fTrans = (0.99 - 0.98*o.lpfSteep) * (fNyquist - o.lpf);
        freqs = (0:floor(xFrames/2)) * (fs/xFrames);

        mask = ones(length(freqs),1,o.floatProc);
        inTrans = freqs>=o.lpf & freqs<=o.lpf+fTrans;
        if fTrans > 0
            mask(inTrans) = 0.5 * (1 + cos(pi * (freqs(inTrans) - o.lpf) / fTrans));
            mask(freqs>o.lpf+fTrans) = 0;
        else
            mask(freqs>=o.lpf) = 0;
        end

        maskFull = [mask; flipud(mask(2:end-1))];
        o.lpfMasks{i} = maskFull(1:xFrames);
    end
    disp("[ec_epochPreproc] Created FFT low-pass masks ("+numel(uLens)+...
        " unique run lengths): "+n.sbj+" time="+toc(tt));
else
    o.lpfMasks = {};
    o.lpfRunMaskIdx = [];
    o.lpfLens = [];
end






function [x,n] = badFrames_lfn(x,n,o,tt)
%%% Remove bad frames %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Size of x
szX = size(x);
ndX = nnz(szX > 1); % nonsingleton dims

% Defer 2D-xBad / 3D-x vars so all of them share a single reshape pair
nVars = numel(o.badFrameVars);
isTwoD = false(1,nVars);

% Pass 1: cases that work natively in x's shape
for k = 1:nVars
    v = o.badFrameVars(k);
    xBad = n.xBad.(v);
    szB = size(xBad);
    ndB = nnz(szB > 1);

    if isequal(szX,szB)
        x(xBad) = nan;
    elseif ndB < ndX && all(szB(1:ndB)==szX(1:ndB))
        if ndB==1
            x(xBad,:,:) = nan;
        else
            isTwoD(k) = true;
        end
    else
        error("n.xBad."+v+" incompatible size with EEG data: "+n.sbj+" time="+toc(tt));
    end
end

% Pass 2: 2D xBad (frames x chans) on 3D x (frames x chans x freqs).
%   find() reads sparse masks in O(nnz) — avoids full() on a matrix the
%   size of x's first two dims. One reshape + one row-indexed assignment
%   broadcasts NaN across all freq slices for every deferred var at once.
if any(isTwoD)
    twoDvars = o.badFrameVars(isTwoD);
    li = cell(numel(twoDvars),1);
    for k = 1:numel(twoDvars)
        li{k} = find(n.xBad.(twoDvars(k)));
    end
    li = vertcat(li{:});
    x = reshape(x,[],szX(3));
    x(li,:) = nan;
    x = reshape(x,szX);
end

% Drop xBad so it isn't broadcast into the downstream parfor
if ~o.test
    n = rmfield(n,"xBad");
end
disp("[ec_epochPreproc] Removed bad frames: "+n.sbj+" time="+toc(tt));






function x = logTransform_lfn(x,n,o,tt)
%%% Log-transform (decibel or natural log) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert EEG to specified float type for processing
x = cast(x,o.floatProc);

% Find negative values & convert to eps(0)
idNeg = x < eps(cast(0,like=x));
x(idNeg) = eps(cast(0,like=x));
if any(idNeg,"all")
    warning("[ec_epochPreproc] Log-transform: negative values found in 'x' ("+...
        (nnz(idNeg)/numel(x))*100+"%), converting to eps(0)");
end

% Transform
if o.mag2db
    % Magnitude to decibel
    if n.spectOpts.fOut=="magnitude"
        x = mag2db(x);
    elseif n.spectOpts.fOut=="decibel"
        warning("[ec_epochPreproc] No decibel transform, EEG data already in decibels: "+...
            n.sbj+" time="+toc(tt));
    else
        error("No decibel transform, EEG data not in magnitude: "+...
            n.sbj+" time="+toc(tt));
    end
elseif o.log
    % Natural log
    x = log(x);
    if n.spectOpts.fOut=="decibel"
        warning("[ec_epochPreproc] EEG data already in decibels, log-transforming anyways: "+...
            n.sbj+" time="+toc(tt));
    end
end






function xct = outliersTime_lfn(xct,cnd,n,o)
%%% Outliers within timepoint %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              t=50; id=n.timesId{t}; xct=xc(id,:); cnd=ep.cnd(id);

% Outliers: all-data
if o.olThrTime
    xct = filloutliers(xct,o.olFillTime,o.olCenter,1,ThresholdFactor=o.olThrTime);
end

% Outliers: within-condition
if o.olThrCond
    for c = n.cnds(:)'
        id = cnd==c;
        xct(id,:) = filloutliers(xct(id,:),o.olFillTime,o.olCenter,1,ThresholdFactor=o.olThrCond);
        %disp("Outliers "+string(c)+": "+nnz(TF)/numel(TF));
    end
end






function y = constructBands_lfn(xc,n)
%%% Construct spectral bands %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preallocate
y = nan([height(xc) height(n.spect)],like=xc);

% Get band timecourse from mean of freq range
for b = 1:height(n.spect)
    y(:,b) = mean(xc(:,n.spect.id(b,:)),2,"omitmissing");
end