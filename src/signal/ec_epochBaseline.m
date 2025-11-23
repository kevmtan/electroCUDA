function [x,n,trs] = ec_epochBaseline(x,n,psy,ep,tt,op)
% electroCUDA function for preprocessing, epoching & baseline correction
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
    op.test (1,1) logical = false               % Running a test? (keeps removed fields)
    op.gpu (1,1) logical = false                % Run on GPU? (note: CPU appears faster)
    op.typeProc (1,1) string = "double"         % processing FP precision ("double"|"single"|""=same as input)
    op.typeOut (1,1) string = class(x)          % output FP precision ("double"|"single"|""=same as input)
    op.hzTarget (1,1) double = nan              % Target sampling rate
    % Within-run preprocessing
    op.log (1,1) logical = false;               % Log transform
    op.runNorm string = "zscore";               % Normalize run
    % Within-trial preprocessing (baseline correction)
    %   Epoch baseline period (none=[], relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
    op.baselinePre {mustBeFloat} = []            % Pre-stimulus baseline (secs from stim onset); -.2sec until onset = [-.2]; -.2sec to 1sec = [-0.2 1]
    op.baselinePost {mustBeFloat} = []           % Post-stimulus baseline (secs from stim offset); .2sec after offset = .2; .1sec to .2sec after offsetx=[0.1 0.3]
    op.trialNorm string {mustBeMember(op.trialNorm,["robust" "zscore" ""])} = "robust"; % Normalize trial (skip="")
    op.trialNormDev string {mustBeMember(op.trialNormDev,["baseline" "pre" "post" "on" "off" "all"])}...
        = "baseline"; % Timepoints for StdDev relative to stim ["baseline"|"pre"|"post"|"on"|"off"|"all"] (default="baseline")
    op.trialBaseline string {mustBeMember(op.trialBaseline,["median" "mean" ""])} = "median"; % Subtract trial by mean or median of baseline period (skip="")
    % Bad frames/outliers
    op.interp string {mustBeMember(op.interp,["nearest" "linear" "spline" "pchip" "makima"])}...
        = "linear";
    op.badFields string {mustBeMember(op.badFields,["" "hfo" "mad" "diff" "sns"])} = "" % skip=""
    op.olCenter string {mustBeMember(op.olCenter,["median" "mean"])} = "median"
    op.olThr (1,1) double = 5;                   % Threshold for outlier
    op.olThr2 (1,1) double = 0;                  % Threshold for outlier
    op.olThrBL (1,1) double = 3;                 % Threshold for in baseline period
    % Remove spectral frequencies (indices for dim3)
    op.rmFreqs {islogical,isnumeric} = [];
    % Spectral dimensionality reduction by PCA (skip=0)
    op.pcaSpec (1,1) double = 0;                 % Spectral components to keep per channel
    % Spectral dimensionality reduction into bands (skip=[])
    op.bands string = "";                        % Band name
    op.bands2 string = "";                       % Band display name
    op.bandsF = [];                              % Band freq limits
    % Filtering (within-run):
    op.hpf (1,1) double = 0;                     % HPF cutoff in hertz (skip=0)
    op.hpfSteep (1,1) double = 0.75;              % HPF steepness
    op.hpfImpulse {mustBeMember(op.hpfImpulse,["auto" "fir" "iir"])} = "iir"; % HPF impulse: ["auto"|"fir"|"iir"]
    op.lpf (1,1) double = 0;                     % LPF cutoff in hz (skip=0)
    op.lpfSteep = 0.75;                           % LPF steepness
    op.lpfImpulse {mustBeMember(op.lpfImpulse,["auto" "fir" "iir"])} = "auto"; % LPF impulse: ["auto"|"fir"|"iir"]
end

% Conditional validation
if ~isany(op.typeProc); op.typeProc = class(x); end
if ~isany(op.typeOut); op.typeOut = class(x); end
op.fs2 = double(op.lpf*n.hz);


%% Prep

% Peristimulus indices 
stim = psy.stim;
stim = mat2cell(stim,n.runIdxOg); % split per run

% Epoch indices
epIdx = ep.idx;

% Trial Indices
trs = groupcounts(ep,["run" "tr"]);
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
if isany(op.hzTarget)
    [ds(1),ds(2)] = rat(op.hzTarget/n.hz);
    % Errors
    if ds(1) > ds(2)
        error("[ec_epochBaseline] downsampling target > sampling rate"); end
    if ds(1) ~= 1
        error("[ec_epochBaseline] downsampling target must be wholly divisible by sampling rate"); end
    ds = ds(2);
    disp("[ec_epochBaseline] downsampling factor = "+ds);
else
    ds = 1;
end

% Remove spectral indices (frequencies)
if isany(op.rmFreqs)
    n.freqsOg = n.freqs;
    if islogical(op.rmFreqs)
        n.keptFreqIdx = ~op.rmFreqs;
    else
        n.keptFreqIdx = ~ismember((1:n.nFreqs)',op.rmFreqs);
    end
    n.freqs = n.freqs(n.keptFreqIdx);

    % Remove from EEG data
    x = x(:,:,n.keptFreqIdx);
end

% Spectral Band indices
if isany(op.bands)
    n.bands = table;
    n.bands.name = op.bands';
    n.bands.disp = op.bands2';
    n.bands.freqs(:) = {[]};
    for b = 1:numel(op.bands)
        n.bands.id(b,:) = (n.freqs>op.bandsF(b,1) & n.freqs<=op.bandsF(b,2))';
        n.bands.freqs{b} = n.freqs(n.bands.id(b,:));
    end
    n.bands.Properties.RowNames = n.bands.name;
    disp("[ec_epochBaseline] Gathered spectral band indices: "+n.sbj+" time="+toc(tt));
end

% Preallocate PCA weights
if op.pcaSpec
    pcaWts = cell(1,n.xChs); end

% Filter prep
hpf=[]; lpf=[];
if isany(op.hpf) || isany(op.lpf)
    % Get single-channel/freq timeseries from longest run
    [~,idx] = min(n.runIdxOg);
    xTmp = x(psy.run==n.runs(idx),1,1);
    xTmp = cast(xTmp,op.typeProc);
    if op.gpu; xTmp = gpuArray(xTmp); end

    % Make filter(s)
    if isany(op.hpf)
        hpf = ec_designFilt(xTmp,n.hz,op.hpf,"highpass",...
            steepness=op.hpfSteep,impulse=op.hpfImpulse,coefOut=true);
        disp("[ec_epochBaseline] Created high-pass filter: "+n.sbj+" time="+toc(tt));
    end
    if isany(op.lpf)
        lpf = ec_designFilt(xTmp,n.hz,op.lpf,"lowpass",...
            steepness=op.lpfSteep,impulse=op.lpfImpulse,coefOut=true);
        disp("[ec_epochBaseline] Created low-pass filter: "+n.sbj+" time="+toc(tt));
    end
    clear xTmp
end

% Remove bad frames
if isany(op.badFields)
    for f = 1:numel(op.badFields)
        % Get bad timepoints for specific metric
        try
            xBad = n.xBad.(op.badFields(f));
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

% Transform to cell by channel
x = ec_dim2cell(x,2);


%% Main processing (loop across channels)
if op.gpu
    % Run on GPU (devs: gpuArray table fields?)
    for c = 1:numel(x)
        [x{c},pcaWts{c}] = withinCh_lfn(x{c},n,stim,epIdx,trs,hpf,lpf,ds,op);
    end
else
    % Run on CPU parallel loop (ideally threadpool, initialize before running)
    parfor c = 1:numel(x)
        [x{c},pcaWts{c}] = withinCh_lfn(x{c},n,stim,epIdx,trs,hpf,lpf,ds,op);
    end
end


%% Finalize

% Reformat EEG data as matrix
x = cellfun(@(y) permute(y,[1 3 2]),x,'UniformOutput',false);
x = horzcat(x{:});

% Save PCA weights
if op.pcaSpec
    n.pcaWts = pcaWts; end

% Save spectral info
n.nSpect = size(x,3);
n.spect = table;
if op.pcaSpec
    n.spect.name = "pc"+(1:n.nSpect)';
    n.spect.disp = "Spectral PC "+(1:n.nSpect)';
elseif isany(op.bands)
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
if ~op.test
    n.xBad = []; end 
disp("[ec_epochBaseline] Finished: "+n.sbj+" time="+toc(tt));




%%%%%%%%%%%%%%%%%%%%%%%%%% subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function [xc,chWts] = withinCh_lfn(xc,n,stim,epIdx,trs,hpf,lpf,ds,op)
%% Compute within-chan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xc=x{104};

% Process at specified float precision
xc = cast(xc,op.typeProc);

% Move to GPU
if op.gpu
    xc = gpuArray(xc); end

% Reshape per run
xc = mat2cell(xc,n.runIdxOg);

% Processing within-run (HPF, norm, outliers, PCA, LPF)
for r = 1:n.nRuns
    xc{r} = withinRun_lfn(xc{r},stim{r},hpf,lpf,ds,n,op);
end
xc = vertcat(xc{:});

% Spectral PCA (use ec_robustPCA??)
if op.pcaSpec
    [chWts,xc] = pca(xc,NumComponents=op.pcaSpec,Economy=false);
else
    chWts = [];
end

% Epoch EEG
xc = xc(epIdx,:); % Match epoched indices
xc = cellfun(@(tr) xc(tr,:), trs.i,UniformOutput=false); % Reshape by epoch

% Baseline correct & zscore within-trial
for t = 1:numel(xc)
    xc{t} = withinTrial_lfn(xc{t},trs(t,:),op);
end
xc = vertcat(xc{:});

% Get from GPU
if op.gpu
    xc = gather(xc);
    if op.pcaSpec; chWts = gather(chWts); end
end

% Output at specified float precision
xc = cast(xc,op.typeOut);



function xr = withinRun_lfn(xr,stimR,hpf,lpf,ds,n,op)
%% Compute within-run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Log transform
if op.log
    xr = log(xr); end

% Z-score
if op.runNorm=="robust"
    xr = normalize(xr,1,"zscore","robust");
elseif isany(op.runNorm)
    xr = normalize(xr,1,op.runNorm);
end

% All outliers
if any(op.olThr)
    xr = filloutliers(xr,nan,op.olCenter,1,ThresholdFactor=op.olThr); end

% Interpolate outliers/missing (slower on GPU)
xr = fillmissing(xr,op.interp,1,EndValues="nearest");

% High-pass filter
if ~isempty(hpf)
    xr = ec_filtfilt(xr,hpf); end

% Spectral bands
if isany(op.bands)
    xrb = nan([size(xr,1) height(n.bands)],class(xr)); % Preallocate

    % Get band timecourse from mean of freq range
    for b = 1:height(n.bands)
        xrb(:,b) = mean(xr(:,n.bands.id(b,:)),2,"omitmissing");
    end
    xr = xrb; % Save
end

% All outliers (2nd round)
if any(op.olThr2)
    xr = filloutliers(xr,nan,op.olCenter,1,ThresholdFactor=op.olThr2); end

% Baseline outliers
if any(op.olThrBL)
    xr(~stimR,:) = filloutliers(xr(~stimR,:),nan,op.olCenter,1,ThresholdFactor=op.olThrBL); end

% Interpolate outliers/missing (slower on GPU)
xr = fillmissing(xr,op.interp,1,EndValues="nearest");

% Low-pass filter
if ~isempty(lpf)
    xr = ec_filtfilt(xr,lpf); end

% Z-score round 2
if op.runNorm=="robust"
    xr = normalize(xr,1,"zscore","robust");
elseif isany(op.runNorm)
    xr = normalize(xr,1,op.runNorm);
end

% Downsample
if ds > 1
    xr = xr(1:ds:end,:); end




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


% % Get downsampling factor & anti-aliasing filter
% if isany(op.hzTarget)
%     [ds(1),ds(2)] = rat(op.hzTarget/n.hz);
%     % Errors
%     if ds(1) > ds(2)
%         error("[ec_epochBaseline] downsampling target > sampling rate"); end
%     if ds(1) ~= 1
%         error("[ec_epochBaseline] downsampling target must be wholly divisible by sampling rate"); end
%     ds = ds(2);
%     disp("[ec_epochBaseline] downsampling factor = "+ds);
% else
%     ds = 1;
% end
%
% function xc = acrossTrials_lfn(xc,trs,op)
% %% acrossTrials_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Reshape by trial
% xc = arrayfun(@(tr) xc(tr.i,:), trs,UniformOutput=false);
% 
% % Baseline correct within-trial (robust z-score)
% for t = 1:numel(xc)
%     if any(trs(t).baseline)
%         xc{t} = withinTrial_lfn(xc{t},trs(t).baseline,op); end
% end
% xc = vertcat(xc{:});
% 
% 
% 
% function xc = withinCh_lfn(xc,rr,idr,stim,fs2,hpf,lpf,op)
% %% Compute within chan/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xc = squeeze(xc);
%
% % Log transform
% if op.log
%     xc = arrayfun(@log,xc); end
%
% % Outliers, HPF, z-score (within-run)
% for r = rr
%     id = idr(:,r);
%     xc(id,:) = withinChRun_lfn(xc(id,:),~stim(id),fs2,hpf,op);
% end
%
% % PCA (use ec_robustPCA??)
% if op.pcaSpec
%     [~,xc] = pca(xc,NumComponents=op.pcaSpec,Economy=false); end
%
% % LPF (within-run) [after PCA]
% if ~isempty(lpf)
%     for r = rr
%         xc(idr(:,r),:) = ec_filtfilt(xc(idr(:,r),:),lpf); end
% end
%
% % Finalize
% xc = permute(xc,[1 3 2]);
%
%
%
% function xr = withinChRun_lfn(xr,idb,fs2,hpf,op)
% %% Compute within run per chan/IC  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% % Baseline outliers
% if any(op.olThrBL)
%     xr(idb,:) = filloutliers(xr(idb,:),nan(1,like=xr),op.olCenter,1,ThresholdFactor=op.olThrBL); end
%
% % Peri-stimulus outliers
% if any(op.olThr)
%     xr = filloutliers(xr,nan(1,like=xr),op.olCenter,1,ThresholdFactor=op.olThr); end
%
% % Interpolate outliers/missing (slower on GPU)
% xr = fillmissing_lfn(xr,fs2);
%
% % High-pass filter
% if ~isempty(hpf)
%     xr = ec_filtfilt(xr,hpf); end
%
% % Redo outliers
% if any(op.olThr2)
%     xr = filloutliers(xr,nan,op.olCenter,1,ThresholdFactor=op.olThr2);
%     xr = fillmissing_lfn(xr,fs2);
% end
%
% % Normalize (z-score)
% if op.runNorm=="robust"
%     xr = normalize(xr,1,"zscore","robust");
% elseif isany(op.runNorm)
%     xr = normalize(xr,1,op.runNorm);
% end