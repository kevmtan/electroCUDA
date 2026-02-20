function [x,n,o] = ec_epochBaseline(x,n,psy,ep,tt,o)
% Analysis-specific preprocessing: epoching & baseline correction
%   Kevin Tan (2025) | github.com/kevmtan/electroCUDA
%
% Inputs: see next section
%
% Outputs:
%   x = pre-preprocessed EEG data, 2D/3D matrix = [time,channel,spectral]
%   n = recording information
%   trs = trial/epoch metadata per timepoint


%% Input validation
arguments
    x {mustBeFloat}                             % Ephysio data, 2D/3D matrix = [time,channel,freq]
    n struct                                    % Info struct
    psy timetable                               % Task metadata per timepoint
    ep table                                    % Epoch metadata per timepoint
    tt uint64 = tic                             % Timer
    o.test (1,1) logical = false               % Running a test? (keeps removed fields)
    o.gpu (1,1) logical = false                % Run on GPU? (note: CPU appears faster)
    o.hzTarget (1,1) double = nan              % Target sampling rate
    % processing FP precision ("double"|"single"|default=same as input)
    o.typeProc (1,1){mustBeMember(o.typeProc,["double" "single"])} = class(x)
    % output FP precision ("double"|"single"|"half"|default=same as input)
    o.typeOut (1,1){mustBeMember(o.typeOut,["double" "single" "half"])} = class(x)          
    % Trasnform/normalization
    o.log (1,1) logical = false;               % Log transform
    o.mag2db (1,1) logical = false;            % Spectral magnitude to decibel
    o.runNorm string {mustBeMember(o.runNorm,["robust" "zscore" "" []])} = "robust"; % Normalize run
    % Within-trial normalization (baseline correction)
    %   Epoch baseline period (none=[], relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
    o.baselinePre {mustBeFloat} = []            % Pre-stimulus baseline (secs from stim onset); -.2sec until onset = [-.2]; -.2sec to 1sec = [-0.2 1]
    o.baselinePost {mustBeFloat} = []           % Post-stimulus baseline (secs from stim offset); .2sec after offset = .2; .1sec to .2sec after offsetx=[0.1 0.3]
    o.trialNorm string {mustBeMember(o.trialNorm,["robust" "zscore" "" []])} = "robust"; % Normalize trial (skip="")
    o.trialNormDev string {mustBeMember(o.trialNormDev,["baseline" "pre" "post" "on" "off" "all"])}...
        = "baseline"; % Timepoints for StdDev relative to stim ["baseline"|"pre"|"post"|"on"|"off"|"all"] (default="baseline")
    o.trialBaseline string {mustBeMember(o.trialBaseline,["median" "mean" "" []])} = "median"; % Subtract trial by mean or median of baseline period (skip="")
    % Bad frames/outliers
    o.interp string {mustBeMember(o.interp,["nearest" "linear" "spline" "pchip" "makima"])}...
        = "linear";
    o.badFields string {mustBeMember(o.badFields,["hfo" "mad" "diff" "sns" "" []])} = "" % skip=""
    o.olCenter string {mustBeMember(o.olCenter,["median" "mean"])} = "median"
    o.olThr (1,1) double = 5;                   % Threshold for outlier
    o.olThr2 (1,1) double = 0;                  % Threshold for outlier
    o.olThrBL (1,1) double = 3;                 % Threshold for in baseline period
    % Spectral frequencies to keep, range per row: [minFreq1 maxFreq2; minFreq1 maxFreq2; ...])
    o.freqs {islogical,isnumeric} = [];
    % PCA within-chan or within-concactenated chans (e.g., make spectral components)
    o.pca = 0; % Spectral components to keep per channel/ROI/whole-brain (skip=0)
    % Spectral dimensionality reduction into bands (skip=[])
    o.bands string = "";                        % Band name
    o.bands2 string = "";                       % Band display name
    o.bandsF = [];                              % Band freq limits
    % Filtering (within-run):
    o.hpf (1,1) double = 0;                     % HPF cutoff in hertz (skip=0)
    o.hpfSteep (1,1) double = 0.7;              % HPF steepness
    o.hpfImpulse {mustBeMember(o.hpfImpulse,["auto" "fir" "iir"])} = "iir"; % HPF impulse: ["auto"|"fir"|"iir"]
    o.lpf (1,1) double = 0;                     % LPF cutoff in hz (skip=0)
    o.lpfSteep = 0.7;                           % LPF steepness
    o.lpfImpulse {mustBeMember(o.lpfImpulse,["auto" "fir" "iir"])} = "auto"; % LPF impulse: ["auto"|"fir"|"iir"]
end

% Additional validation
if ~isany(o.hpf); o.hpf=false; end
if ~isany(o.lpf); o.lpf=false; end


%% Prep

% Convert EEG to specified float type for processing
x = cast(x,o.typeProc);

% Move EEG to GPU
if o.gpu
    x = gpuArray(x); end

% Make temporal filters
if o.hpf || o.lpf
    o = makeFilters_lfn(x,n,o,tt);
end

% Downsampling
if o.hzTarget < n.hz
    o = downsamplingPrep_ln(n,o); % downsampling factors & anti-aliasing
else
    o.ds = false;
end

% Spectral
if isany(o.bands)
    % Find spectral band frequencies in EEG
    n = bandFreqs_lfn(n,o,tt);
elseif isany(o.freqs)
    % Keep only specified spectral frequencies
    [x,n] = keepFreqs_lfn(x,n,o,tt);
end

% Run indices
ri = false(height(psy),n.nRuns);
for r = 1:n.nRuns
    ri(:,r) = psy.run==n.runs(r);
end

% Peristimulus indices
stim = psy.stim;


%% All-data processing

% Remove bad frames
if isany(o.badFields)
    x = rmBadFrames_lfn(x,n,o,tt);
end

% Log-transform
if o.log || o.mag2db
    x = logTransform_lfn(x,o,n,tt);
end


%% Within-run processing

% Parfor within-channel for speed
parfor ch = 1:n.xChs
    x(:,ch,:) = withinCh_lfn(x(:,ch,:),stim,ri,n,o);
end
disp("[ec_epochBaseline] Completed within-run routines: "+n.sbj+" time="+toc(tt));


%% Downsampling
if o.ds
    % Split data by epoch
    trs = findgroups(ep.tr);
    x = splitapply(@(e){x(e,:,:)},ep.ide,trs);

    % Downsample within-run
    for r = 1:n.nRuns
        x{r} = downsample_lfn(x{r},o);
    end
    x = vertcat(x{:});
end
disp("[ec_epochBaseline] Downsampled: "+n.sbj+" time="+toc(tt));


%% Within-epoch processing

% Epoch EEG data
x = x(ep.idx,:); % match epoched indices

if isany(o.trialNorm) || isany(o.trialBaseline)
    % Split data by epoch
    trs = findgroups(ep.tr);
    x = splitapply(@(e){x(e,:,:)},ep.ide,trs);
    ep = splitapply(@(e){ep(e,:)},ep.ide,trs);

    % Loop across epochs
    for e = 1:n.nTrs
        x{e} = withinEpoch_lfn(x{e},ep{e},o); % within-trial processing
    end

    % Concactenate epochs
    x = vertcat(x{:});
end
disp("[ec_epochBaseline] Baseline corrected: "+n.sbj+" time="+toc(tt));


%% Spectral processing

% Spectral bands
if isany(o.bands)
    x = constructBands_lfn(x,n);
end

% Spectral PCA
if o.pca
    [x,n] = pca_lfn(x,n,o);
end


%% Finalize

% Move EEG from GPU to CPU
if o.gpu
    x = gather(x); end

% Output EEG as specified float type
x = cast(x,o.typeOut);

% Delete bad frame indices to save memory
if ~o.test
    n.xBad = []; end 
disp("[ec_epochBaseline] Finished: "+n.sbj+" time="+toc(tt));






%%%%%%%%%%%%%%%%% High-level preprocessing routines %%%%%%%%%%%%%%%%%%%%%%%






%%% Process runs within-chan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xc = withinCh_lfn(xc,stim,ri,n,o)

% Ensure 2D EEG
xc = squeeze(xc);

% Within-run preprocessing (outliers, filter, z-score)
for r = 1:n.nRuns
    id = ri(:,r);
    xc(id,:) = withinRun_lfn(xc(id,:),stim(id),o);
end






%%% Within-run preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xcr = withinRun_lfn(xcr,stimR,o)

% All outliers
if any(o.olThr)
    xcr = filloutliers(xcr,nan,o.olCenter,1,ThresholdFactor=o.olThr); end

% Interpolate outliers/missing (slower on GPU)
xcr = fillmissing(xcr,o.interp,1,EndValues="nearest");

% High-pass filter
if o.hpf
    xcr = ec_filtfilt(xcr,o.HPF{1},o.HPF{2}); end

% All outliers (2nd round)
if any(o.olThr2)
    xcr = filloutliers(xcr,nan,o.olCenter,1,ThresholdFactor=o.olThr2); end

% Baseline outliers
if any(o.olThrBL)
    xcr(~stimR,:) = filloutliers(xcr(~stimR,:),nan,o.olCenter,1,ThresholdFactor=o.olThrBL); end

% Interpolate outliers/missing (slower on GPU)
xcr = fillmissing(xcr,o.interp,1,EndValues="nearest");

% Low-pass filter / anti-aliasing
if o.lpf
    xcr = ec_filtfilt(xcr,o.LPF{1},o.LPF{2}); end

% Z-score
if ~o.ds
    if o.runNorm=="robust"
        xcr = normalize(xcr,1,"zscore","robust"); % robust z-score
    elseif isany(o.runNorm)
        xcr = normalize(xcr,1,o.runNorm); % standard z-score
    end
    % Skip if downsampling (z-score after downsampling)
end





%%% Within-epoch preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xe = withinEpoch_lfn(xe,epe,o)

% Frames for baseline subtraction
iBL = epe.BLpre | epe.BLpost;

% Frames for std deviation calculation
if o.trialNormDev=="baseline" && any(iBL)
    iSD = epe.BLpre | epe.BLpost;
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

% Get trial baseline
if o.trialBaseline=="median"
    bl = median(xe(iBL,:),1,"omitnan"); % BL median
elseif o.trialBaseline=="mean"
    bl = mean(xe(iBL,:),1,"omitnan"); % BL median
else
    bl = cast(0,like=xe);
end

% Get trial std deviation
if o.trialNorm=="robust"
    sd = mad(xe(iSD,:),1,1); % BL MAD median absolute deviation
    c = 0.6745;
elseif o.trialNorm=="zscore"
    sd = std(xe(iSD,:),1,1,"omitnan");
    c = 1;
else
    sd = cast(1,like=xe);
    c = 1;
end
c = cast(c,like=xe);

% Do baseline correction
xe = c*(xe-bl)./sd;

% Errors
if ~any(iBL) && isany(o.trialBaseline)
    error("No epoch frames marked as baseline (ep.BLpre|ep.BLpost)"); end
if ~any(iSD) && isany(o.trialNorm)
    error("No epoch frames marked as specified in 'o.trialNormDev'"); end





 
%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%% Downsampling preparation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function o = downsamplingPrep_ln(n,o)

% Downsampling factors
[o.ds(1),o.ds(2)] = rat(o.hzTarget/n.hz); % get factors
if o.ds(1) > o.ds(2)
    error("[ec_epochBaseline] downsampling target > sampling rate"); end
if o.ds(1) ~= 1
    error("[ec_epochBaseline] downsampling target must be wholly divisible by sampling rate"); end
o.ds = o.ds(2);
disp("[ec_epochBaseline] downsampling factor = "+o.ds);

% Ensure anti-aliasing LPF
hzNyquist = o.hzTarget/2;
if ~o.lpf || o.lpf<hzNyquist
    o.lpf = hzNyquist;
    disp("[ec_epochBaseline] adding downsampling anti-aliasing LPF: "+...
        o.lpf+"hz");
end






%%% Split EEG frequencies into spectral bands %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function n = bandFreqs_lfn(n,o,tt)

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
    n.spect.id(b,:) = isbetween(n.spect0,o.bandsF(b,1),o.bandsF(b,2),"openright");
    n.spect.freqs{b} = n.spect0.freq(n.spect.id(b,:));
    n.spect0.band(n.spect.id(b,:)) = n.spect.name(b);
end
n.spect.Properties.RowNames = n.spect.name;
n.nSpect = height(n.spect);
disp("[ec_epochBaseline] Found frequencies within spectral bands: "+n.sbj+" time="+toc(tt));






%%% Remove spectral frequencies (keep only specified freqs) %%%%%%%%%%%%%%%
function [x,n] = keepFreqs_lfn(x,n,o,tt)

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
disp("[ec_epochBaseline] Kept "+n.nSpect+"/"+n.nFreqs+" freqs: "+n.sbj+" time="+toc(tt));






%%% Make temporal filters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function o = makeFilters_lfn(x,n,o,tt)

% Extract EEG timeseries vector from shortest run
[~,idx] = min(n.runIdxOg);
xTmp = x(n.runIdx(idx,1):n.runIdx(idx,2),1,1);

% High-pass filter
if o.hpf
    o.HPF = {};
    [o.HPF{1},o.HPF{2}] = ec_designFilt(xTmp,n.hz,o.hpf,"highpass",...
        steepness=o.hpfSteep,impulse=o.hpfImpulse,coefOut=true);
    disp("[ec_epochBaseline] Created high-pass filter: "+n.sbj+" time="+toc(tt));
end

% Low-pass filter
if o.lpf
    o.LPF = {};
    [o.LPF{1},o.LPF{2}] = ec_designFilt(xTmp,n.hz,o.lpf,"lowpass",...
        steepness=o.lpfSteep,impulse=o.lpfImpulse,coefOut=true);
    disp("[ec_epochBaseline] Created low-pass filter: "+n.sbj+" time="+toc(tt));
end






%%% Remove bad frames %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function x = rmBadFrames_lfn(x,n,o,tt)

% Check bad frame table variables
vars = o.badFields;
id = ismember(vars,n.xBad.Properties.VariableNames);
vars = vars(id);


% Loop across bad frame vars
for v = 1:numel(vars)
    % Get bad timepoints for specific metric
    try
        xBad = n.xBad.(vars(v));
    catch
        continue
    end

    s1=numel(size(x)); s2=numel(size(xBad));
    if s1==s2
        x(xBad) = nan;
    elseif s2==2
        xBad = repmat(full(xBad),[1 1 size(x,3)]);
        x(xBad) = nan;
    elseif s2==1
        xBad = repmat(full(xBad),[1 size(x,2) size(x,3)]);
        x(xBad) = nan;
    else
        Error("n.xBad."+vars(v)+" incompatible size with EEG data: "+n.sbj+" time="+toc(tt));
    end
end
disp("[ec_epochBaseline] Removed bad frames: "+n.sbj+" time="+toc(tt));






%%% Log-transform (decibel or natural log) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function x = logTransform_lfn(x,n,o,tt)

% Find negative values & convert to eps(0)
idNeg = x < eps(cast(0,like=x));
x(idNeg) = eps(cast(0,like=x));
if any(idNeg,"all")
    warning("[ec_preprocBaseline] Log-transform: negative values found in 'x' ("+...
        (nnz(idNeg)/numel(x))*100+"%), converting to eps(0)");
end

% Transform
if o.mag2db
    % Magnitude to decibel
    if n.spectOpts.fOut=="magnitude"
        x = mag2db(x);
    elseif n.spectOpts.fOut=="decibel"
        warning("[ec_epochBaseline] No decibel transform, EEG data already in decibels: "+...
            n.sbj+" time="+toc(tt));
    else
        error("No decibel transform, EEG data not in magnitude: "+...
            n.sbj+" time="+toc(tt));
    end
elseif o.log
    % Natural log
    x = log(x);
    if n.spectOpts.fOut=="decibel"
        warning("[ec_epochBaseline] EEG data already in decibels, log-transforming anyways: "+...
            n.sbj+" time="+toc(tt));
    end
end






%%% Construct spectral bands %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xb = constructBands_lfn(x,n)

% Preallocate
xb = nan([size(x,1) height(n.spect)],class(x));

% Get band timecourse from mean of freq range
for b = 1:height(n.spect)
    xb(:,b) = mean(x(:,n.spect.id(b,:)),2,"omitmissing");
end
disp("[ec_epochBaseline] Constructed spectral bands: "+n.sbj+" time="+toc(tt));
% TODO: use splitapply to improve performance?






%%% Spectral PCA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y,n] = pca_lfn(x,n,o)

% Preallocate PCA weights
y = cell(n.xChs,1);
wts = y;

% Run PCA per chan
if o.gpu
    % GPU loop across chans
    for ch = gpuArray(1:n.xChs)
        [wts{ch},y{ch}] = pca(squeeze(x(:,ch,:)),NumComponents=o.pca);
    end
else
    % Parfor loop across chans
    parfor ch = 1:n.xChs
        [wts{ch},y{ch}] = pca(squeeze(x(:,ch,:)),NumComponents=o.pca); %#ok<PFBNS>
    end
end

% Reformat EEG data as array
y = cellfun(@(yc) permute(yc,[1 3 2]), y, UniformOutput=false);
y = horzcat(y{:});

% Save PCA weights to nfo struct
n.spectPCA = n.chNfo(:,["sbjID" "ch" "sbjCh"]);
n.spectPCA.wts = gather(vertcat(wts{:}));

% Copy previous spectral info struct
if isfield(n,"spect0")
    n.spect1 = n.spect;
else
    n.spect0 = n.spect;
end

% New spectral info struct
n.nSpect = o.pca;
n.spect = table;
n.spect.name = "pc"+(1:n.nSpect)';
n.spect.disp = "Spectral Component "+(1:n.nSpect)';






%%% Downsample (within-run) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xr = downsample_lfn(xr,o)

% Downsample
xr = xr(1:o.ds:end,:);

% Z-score
if o.runNorm=="robust"
    xr = normalize(xr,1,"zscore","robust"); % robust z-score
elseif isany(o.runNorm)
    xr = normalize(xr,1,o.runNorm); % standard z-score
end
