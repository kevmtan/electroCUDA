function [x,n,trs] = ec_epochBaseline(x,n,psy,ep,tt,o)
% Analysis-specific preprocessing, epoching & baseline correction
%   Kevin Tan (2025) | github.com/kevmtan/electroCUDA
%
% Inputs: see next section
%
% Outputs:
%   x = preprocessed neuronal data, 2D/3D matrix = [time,channel,freq]
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
    % processing FP precision ("double"|"single"|"half"|default=same as input)
    o.typeProc (1,1){mustBeMember(o.typeProc,["double" "single" "half"])} = class(x)
    % output FP precision ("double"|"single"|"half"|default=same as input)
    o.typeOut (1,1){mustBeMember(o.typeOut,["double" "single" "half"])} = class(x)          
    o.hzTarget (1,1) double = nan              % Target sampling rate
    % Within-run preprocessing
    o.runNorm string {mustBeMember(o.runNorm,["robust" "zscore" ""])} = "robust"; % Normalize run
    o.log (1,1) logical = false;               % Log transform
    o.mag2db (1,1) logical = false;            % Spectral magnitude to decibel
    % Within-trial preprocessing (baseline correction)
    %   Epoch baseline period (none=[], relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
    o.baselinePre {mustBeFloat} = []            % Pre-stimulus baseline (secs from stim onset); -.2sec until onset = [-.2]; -.2sec to 1sec = [-0.2 1]
    o.baselinePost {mustBeFloat} = []           % Post-stimulus baseline (secs from stim offset); .2sec after offset = .2; .1sec to .2sec after offsetx=[0.1 0.3]
    o.trialNorm string {mustBeMember(o.trialNorm,["robust" "zscore" ""])} = "robust"; % Normalize trial (skip="")
    o.trialNormDev string {mustBeMember(o.trialNormDev,["baseline" "pre" "post" "on" "off" "all"])}...
        = "baseline"; % Timepoints for StdDev relative to stim ["baseline"|"pre"|"post"|"on"|"off"|"all"] (default="baseline")
    o.trialBaseline string {mustBeMember(o.trialBaseline,["median" "mean" ""])} = "median"; % Subtract trial by mean or median of baseline period (skip="")
    % Bad frames/outliers
    o.interp string {mustBeMember(o.interp,["nearest" "linear" "spline" "pchip" "makima"])}...
        = "linear";
    o.badFields string {mustBeMember(o.badFields,["" "hfo" "mad" "diff" "sns"])} = "" % skip=""
    o.olCenter string {mustBeMember(o.olCenter,["median" "mean"])} = "median"
    o.olThr (1,1) double = 5;                   % Threshold for outlier
    o.olThr2 (1,1) double = 0;                  % Threshold for outlier
    o.olThrBL (1,1) double = 3;                 % Threshold for in baseline period
    % Remove spectral frequencies (indices for dim3)
    o.rmFreqs {islogical,isnumeric} = [];
    % Spectral dimensionality reduction by PCA (skip=0)
    o.pcaSpec (1,1) double = 0;                 % Spectral components to keep per channel
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

% Peristimulus indices 
stim = psy.stim;
stim = mat2cell(stim,n.runIdxOg); % split per run

% Epoch indices
epIdx = ep.idx;

% Get trials
trs = groupcounts(ep,["run" "tr"]);
n.nTrials = height(trs);

% Trial indices
trs.i = cell(n.nTrials,1);
for t = 1:n.nTrials
    trs.i{t} = sparse(ep.tr==trs.tr(t)); end

% Trial baseline indices
trs.baseline = cell(height(trs),1);
for t = 1:n.nTrials
    trs.baseline{t} = sparse(ep.BLpre(trs.i{t})|ep.BLpost(trs.i{t})); end

% Trial stimulus indices
trs.pre = cellfun(@(t) sparse(logical(ep.pre(t,:))), trs.i,UniformOutput=false); % Reshape by epoch
trs.post = cellfun(@(t) sparse(logical(ep.post(t,:))), trs.i,UniformOutput=false); 
trs.stim = cellfun(@(t) sparse(logical(ep.stim(t,:))), trs.i,UniformOutput=false); 

% Convert 'half' vars to 'single' for parallel threads
if isa(x,"half")
    x = single(x); end
idx = varfun(@(v) isa(v,"half"),psy,OutputFormat="uniform");
psy = convertvars(psy,idx,"single");

% Get downsampling factor & anti-aliasing filter
if o.hzTarget < n.hz
    [o.ds(1),o.ds(2)] = rat(o.hzTarget/n.hz);
    % Errors
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
else
    o.ds = false;
end

% Filter prep
if o.hpf || o.lpf
    % Get single-channel/freq timeseries from longest run
    [~,idx] = min(n.runIdxOg);
    xTmp = x(psy.run==n.runs(idx),1,1);
    xTmp = cast(xTmp,o.typeProc);
    if o.gpu; xTmp = gpuArray(xTmp); end

    % Make filter(s)
    if o.hpf
        o.HPF = {};
        [o.HPF{1},o.HPF{2}] = ec_designFilt(xTmp,n.hz,o.hpf,"highpass",...
            steepness=o.hpfSteep,impulse=o.hpfImpulse,coefOut=true);
        disp("[ec_epochBaseline] Created high-pass filter: "+n.sbj+" time="+toc(tt));
    end
    if o.lpf
        o.LPF = {};
        [o.LPF{1},o.LPF{2}] = ec_designFilt(xTmp,n.hz,o.lpf,"lowpass",...
            steepness=o.lpfSteep,impulse=o.lpfImpulse,coefOut=true);
        disp("[ec_epochBaseline] Created low-pass filter: "+n.sbj+" time="+toc(tt));
    end
end

% Remove spectral indices (frequencies)
if isany(o.rmFreqs)
    n.freqsOg = n.freqs;
    if islogical(o.rmFreqs)
        n.keptFreqIdx = ~o.rmFreqs;
    else
        n.keptFreqIdx = ~ismember((1:n.nFreqs)',o.rmFreqs);
    end
    n.freqs = n.freqs(n.keptFreqIdx);

    % Remove from EEG data
    x = x(:,:,n.keptFreqIdx);
end

% Spectral Band indices
if isany(o.bands)
    n.bands = table;
    n.bands.name = o.bands';
    n.bands.disp = o.bands2';
    n.bands.freqs(:) = {[]};
    for b = 1:numel(o.bands)
        n.bands.id(b,:) = (n.freqs>o.bandsF(b,1) & n.freqs<=o.bandsF(b,2))';
        n.bands.freqs{b} = n.freqs(n.bands.id(b,:));
    end
    n.bands.Properties.RowNames = n.bands.name;
    disp("[ec_epochBaseline] Gathered spectral band indices: "+n.sbj+" time="+toc(tt));
end

% Preallocate PCA weights
if o.pcaSpec
    pcaWts = cell(1,n.xChs); end


%% All-chan processing

% Remove bad frames
if isany(o.badFields)
    for f = 1:numel(o.badFields)
        % Get bad timepoints for specific metric
        try
            xBad = n.xBad.(o.badFields(f));
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
        end
    end
    disp("[ec_epochBaseline] Removed bad frames: "+n.sbj+" time="+toc(tt));
end

% Log-transform
if o.log || o.mag2db
    idNeg = x < eps(cast(0,like=x));
    if any(idNeg,"all")
        warning("[ec_preprocBaseline] Log-transform: negative values found in 'x' ("+...
            (nnz(idNeg)/numel(x))*100+"%), converting to eps(0)");
    end
end

% Transform to cell by channel
x = ec_dim2cell(x,2);


%% Main processing (loop across channels)
if o.gpu
    % Run on GPU (devs: gpuArray table fields?)
    for c = 1:numel(x)
        [x{c},pcaWts{c}] = withinCh_lfn(x{c},n,stim,epIdx,trs,o);
    end
else
    % Run on CPU parallel loop (ideally threadpool, initialize before running)
    parfor c = 1:numel(x)
        [x{c},pcaWts{c}] = withinCh_lfn(x{c},n,stim,epIdx,trs,o);
    end
end


%% Finalize

% Reformat EEG data as matrix
x = cellfun(@(y) permute(y,[1 3 2]),x,'UniformOutput',false);
x = horzcat(x{:});

% Save PCA weights
if o.pcaSpec
    n.pcaWts = pcaWts; end

% Save spectral info
n.nSpect = size(x,3);
n.spect = table;
if o.pcaSpec
    n.spect.name = "pc"+(1:n.nSpect)';
    n.spect.disp = "Spectral PC "+(1:n.nSpect)';
elseif isany(o.bands)
    n = renameStructField(n,"bands","spect");
elseif n.nSpect > 1
    n.spect.name = "f"+(1:n.nSpect)';
    n.spect.disp = round(n.freqs,2) + " hz";
    n.spect.freq = n.freqs;
else
    n.spect.name = "";
    n.spect.disp = "";
end

% remove bad frames indices to save memory
if ~o.test
    n.xBad = []; end 
disp("[ec_epochBaseline] Finished: "+n.sbj+" time="+toc(tt));






%%%%%%%%%%%%%%%%%%%%%%%%%% subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






function [xc,chWts] = withinCh_lfn(xc,n,stim,epIdx,trs,o)
%% Compute within-chan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xc=x{104};

% Process at specified float precision
xc = cast(xc,o.typeProc);

% Move to GPU
if o.gpu
    xc = gpuArray(xc); end

% Log-transform
if o.log || o.mag2db
    % Find negative numbers & convert to nan
    idNeg = xc < eps(cast(0,like=xc));
    xc(idNeg) = eps(cast(0,like=xc));

    if o.mag2db
        xc = mag2db(xc); % Magnitude to decible 
    elseif o.log
        xc = log(xc); % Natural log
    end
end

% Reshape per run
xc = mat2cell(xc,n.runIdxOg);

% Processing within-run (z-score, outliers, spectral processing, etc)
for r = 1:n.nRuns
    xc{r} = withinRun_lfn(xc{r},stim{r},n,o);
end
xc = vertcat(xc{:});

% Spectral PCA (use ec_robustPCA??)
if o.pcaSpec
    [chWts,xc] = pca(xc,NumComponents=o.pcaSpec,Economy=false);
else
    chWts = [];
end

% Epoch EEG
xc = xc(epIdx,:); % Match epoched indices
xc = cellfun(@(tr) xc(tr,:), trs.i,UniformOutput=false); % Reshape by epoch

% Baseline correct & zscore within-trial
for t = 1:numel(xc)
    xc{t} = withinTrial_lfn(xc{t},trs(t,:),o);
end
xc = vertcat(xc{:});

% Get from GPU
if o.gpu
    xc = gather(xc);
    if o.pcaSpec; chWts = gather(chWts); end
end

% Output at specified float precision
xc = cast(xc,o.typeOut);






function xr = withinRun_lfn(xr,stimR,n,o)
%% Compute within-run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% All outliers
if any(o.olThr)
    xr = filloutliers(xr,nan,o.olCenter,1,ThresholdFactor=o.olThr); end

% Interpolate outliers/missing (slower on GPU)
xr = fillmissing(xr,o.interp,1,EndValues="nearest");

% High-pass filter
if o.hpf
    xr = ec_filtfilt(xr,o.HPF{1},o.HPF{2}); end

% All outliers (2nd round)
if any(o.olThr2)
    xr = filloutliers(xr,nan,o.olCenter,1,ThresholdFactor=o.olThr2); end

% Baseline outliers
if any(o.olThrBL)
    xr(~stimR,:) = filloutliers(xr(~stimR,:),nan,o.olCenter,1,ThresholdFactor=o.olThrBL); end

% Interpolate outliers/missing (slower on GPU)
xr = fillmissing(xr,o.interp,1,EndValues="nearest");

% Low-pass filter
if o.lpf
    xr = ec_filtfilt(xr,o.LPF{1},o.LPF{2}); end

% Spectral bands
if isany(o.bands)
    xrb = nan([size(xr,1) height(n.bands)],class(xr)); % Preallocate

    % Get band timecourse from mean of freq range
    for b = 1:height(n.bands)
        xrb(:,b) = mean(xr(:,n.bands.id(b,:)),2,"omitmissing");
    end
    xr = xrb; % Save
end

% Downsample
if o.ds
    xr = xr(1:o.ds:end,:); end

% Z-score
if o.runNorm=="robust"
    xr = normalize(xr,1,"zscore","robust");
elseif isany(o.runNorm)
    xr = normalize(xr,1,o.runNorm);
end






function xt = withinTrial_lfn(xt,tr,op)
%% withinTrial_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Timepoints for std deviation calculation
if op.trialNormDev=="baseline" && any(tr.baseline{1})
    iSD = tr.baseline{1};
elseif op.trialNormDev == "pre"
    iSD = tr.pre{1};
elseif op.trialNormDev == "post"
    iSD = tr.post{1};
elseif op.trialNormDev == "on"
    iSD = tr.stim{1};
elseif op.trialNormDev == "off"
    iSD = ~tr.stim{1};
elseif op.trialNormDev == "all"
    iSD = true(height(xt),1);
else
    iSD = logical(tr.pre);
end

% Timepoints for baseline subtraction
if any(tr.baseline{1})
    iBL = tr.baseline{1};
else
    iBL = iSD;
end

% Get trial baseline
if op.trialBaseline=="median"
    bl = median(xt(iBL,:),1,"omitnan"); % BL median
elseif op.trialBaseline=="mean"
    bl = mean(xt(iBL,:),1,"omitnan"); % BL median
else
    bl = 0;
end

% Get trial std deviation
if op.trialNorm=="robust"
    sd = mad(xt(iSD,:),1,1); % BL MAD median absolute deviation
    c = 0.6745;
elseif op.trialNorm=="zscore"
    sd = std(xt(iSD,:),1,1,"omitnan");
    c = 1;
else
    sd = 1;
    c = 1;
end

% Do baseline correction
xt = c*(xt-bl)./sd;