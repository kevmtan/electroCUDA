function [EEG,n] = ec_ASR(o,n,x,psy,trialNfo,chNfo)
arguments
    o struct
    n struct
    x {mustBeFloat}
    psy table
    trialNfo table
    chNfo table
end
optFields = ["chIgnore",...
    "doGPU","maxMem","refBurst","refTols","refMaxBadChs","refWinSz",...
    "winSz","winOverlap","stepSz","blockSz","filtHz","filtMag","dimsPCA",...
    "refMaxDropout","refMinClean","truncQuant","stepSizes","shapeRange"];
for ii = 1:length(optFields)
    if ~isfield(o,optFields(ii))
        o.(optFields(ii)) = [];
    end
end

%% Convert to EEGLAB format
EEG = ec_exportEEGLAB(n,x,psy,trialNfo,chNfo);
clear x psy trialNfo chNfo
EEGog = EEG;

% Remove excluded channels
chIgnore = o.chIgnore;
if isany(chIgnore)
    EEG = eeg_checkset(pop_select(EEG,'nochannel',cellstr(EEG.chNfo.sbjCh(chIgnore))));
    disp("Removing these chans for ASR: "); disp(EEG.chNfo.sbjCh(chIgnore)');
end

%% Run ASR
[EEG,state] = asrMain_lfn(EEG,o.gpu,o.maxMem,o.refBurst,o.refTols,o.refMaxBadChs,...
    o.refWinSz,o.winSz,o.winOverlap,o.stepSz,o.blockSz,o.filtHz,o.filtMag,o.dimsPCA,...
    o.refMaxDropout,o.refMinClean,o.truncQuant,o.stepSizes,o.shapeRange);

% Fix mismatched frames
if width(EEG.data)~=width(EEGog.data)
    warning("ASR - mismatched number of frames: EEG.data & EEGog.data")
    if width(EEG.data)>EEGog.pnts; disp("ASR - matching end frames of EEG & EEGog")
        EEG.data = EEG.data(:,1:EEGog.pnts); end
end

% Copy cleaned channels to data matrix
if isany(chIgnore)
    [~,ia,ib] = intersect({EEGog.chanlocs.labels},{EEG.chanlocs.labels},'stable');
    EEGog.data(ia,:) = EEG.data(ib,:);
    EEG = EEGog.data;
else
    EEG = EEG.data;
end
EEG = EEG';

% Save ASR parameters as single
fNames = string(fieldnames(state));
for ii = 1:length(fNames)
    if isfloat(state.(fNames(ii))); state.(fNames(ii)) = single(state.(fNames(ii))); end
end
n.asr = state;




%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% Main %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [EEG,state] = asrMain_lfn(EEG,doGPU,maxMem,refBurst,refTols,refMaxBadChs,...
    refWinSz,winSz,winOverlap,stepSz,blockSz,filtHz,filtMag,dimsPCA,refMaxDropout,...
    refMinClean,truncQuant,stepSizes,shapeRange)
% Run the ASR method on some high-pass filtered recording.
% Signal = clean_asr(Signal,StandardDevCutoff,WindowLength,BlockSize,MaxDimensions,ReferenceMaxBadChannels,RefTolerances,ReferenceWindowLength,UseGPU,UseRiemannian,MaxMem)
%
% This is an automated artifact rejection function that ensures that the data contains no events
% that have abnormally strong power; the subspaces on which those events occur are reconstructed
% (interpolated) based on the rest of the EEG signal during these time periods.
%
% The basic principle is to first find a section of data that represents clean "reference" EEG and
% to compute statistics on there. Then, the function goes over the whole data in a sliding window
% and finds the subspaces in which there is activity that is more than a few standard deviations
% away from the reference EEG (this threshold is a tunable parameter). Once the function has found
% the bad subspaces it will treat them as missing data and reconstruct their content using a mixing
% matrix that was calculated on the clean data.
%
% Notes:
%   This function by default attempts to use the Statistics toolbox in order to automatically
%   extract calibration data for use by ASR from the given recording. This step is automatically
%   skipped if no Statistics toolbox is present (then the entire recording will be used for
%   calibration, which is fine for mildly contaminated data -- see ReferenceMaxBadChannels below).
%
% In:
%   Signal : continuous data set, assumed to be *zero mean*, e.g., appropriately high-passed (e.g.
%            >0.5Hz or with a 0.5Hz - 1.0Hz transition band)
%
%   Cutoff : Standard deviation cutoff for removal of bursts (via ASR). Data portions whose variance
%            is larger than this threshold relative to the calibration data are considered missing
%            data and will be removed. The most aggressive value that can be used without losing
%            much EEG is 3. For new users it is recommended to at first visually inspect the difference
%            between the original and cleaned data to get a sense of the removed content at various
%            levels. An aggressive value is 5, and conservative value is 20. Default: 5.
%
%   The following are detail parameters that usually do not have to be tuned. If you cannot get
%   the function to do what you want, you might consider adapting these better to your data.
%
%   WindowLength : Length of the statistcs window, in seconds. This should not be much longer
%                  than the time scale over which artifacts persist, but the number of samples in
%                  the window should not be smaller than 1.5x the number of channels. Default:
%                  max(0.5,1.5*Signal.nbchan/Signal.srate);
%
%   StepSize : Step size for processing. The reprojection matrix will be updated every this many
%              samples and a blended matrix is used for the in-between samples. If empty this will
%              be set the WindowLength/2 in samples. Default: []
%
%   MaxDimensions : Maximum dimensionality to reconstruct. Up to this many dimensions (or up to this
%                   fraction of dimensions) can be reconstructed for a given data segment. This is
%                   since the lower eigenvalues are usually not estimated very well. Default: 2/3.
%
%   ReferenceMaxBadChannels : If a number is passed in here, the ASR method will be calibrated based
%                             on sufficiently clean data that is extracted first from the recording
%                             that is then processed with ASR. This number is the maximum tolerated
%                             fraction of "bad" channels within a given time window of the recording
%                             that is considered acceptable for use as calibration data. Any data
%                             windows within the tolerance range are then used for calibrating the
%                             threshold statistics. Instead of a number one may also directly pass
%                             in a data set that contains calibration data (for example a minute of
%                             resting EEG) or the name of a data set in the workspace.
%
%                             If this is set to 'off', all data is used for calibration. This will
%                             work as long as the fraction of contaminated data is lower than the
%                             the breakdown point of the robust statistics in the ASR calibration
%                             (50%, where 30% of clearly recognizable artifacts is a better estimate
%                             of the practical breakdown point).
%
%                             A lower value makes this criterion more aggressive. Reasonable range:
%                             0.05 (very aggressive) to 0.3 (quite lax). If you have lots of little
%                             glitches in a few channels that don't get entirely cleaned you might
%                             want to reduce this number so that they don't go into the calibration
%                             data. Default: 0.075.
%
%   ReferenceTolerances : These are the power tolerances outside of which a channel in a
%                         given time window is considered "bad", in standard deviations relative to
%                         a robust EEG power distribution (lower and upper bound). Together with the
%                         previous parameter this determines how ASR calibration data is be
%                         extracted from a recording. Can also be specified as 'off' to achieve the
%                         same effect as in the previous parameter. Default: [-3.5 5.5].
%
%   ReferenceWindowLength : Granularity at which EEG time windows are extracted
%                           for calibration purposes, in seconds. Default: 1.
%
%   UseRiemannian : [true|false] Use Riemannian distance instead of Euclidian distance.
%              Riemannian distance used the modication in the following publication
%              Blum Sarah, Jacobsen Nadine S. J., Bleichner Martin G., Debener Stefan (2019)
%              A Riemannian Modification of Artifact Subspace Reconstruction for EEG Artifact
%              Handling, Frontiers in Human Neuroscience, 13, 141. DOI=10.3389/fnhum.2019.00141.
%
%   MaxMem : Amount of memory to use. See asr_process for more information.
%
%   UseGPU : Whether to run on the GPU. This makes sense for offline processing if you have a a card with
%            enough memory and good double-precision performance (e.g., NVIDIA GTX Titan or K20).
%            Note that for this to work you need to a) have the Parallel Computing toolbox and b) remove
%            the dummy gather.m file from the path. Default: false
%
%   WindowOverlap : Window overlap fraction. The fraction of two successive windows that overlaps.
%                   Higher overlap ensures that fewer artifact portions are going to be missed (but
%                   is slower). (default: 0.66)
%
%   Blocksize : Block size for calculating the robust data covariance and thresholds, in samples;
%               allows to reduce the memory and time requirements of the robust estimators by this
%               factor (down to Channels x Channels x Samples x 16 / Blocksize bytes). Default: 10
%
%   MaxDropoutFraction : Maximum fraction that can have dropouts. This is the maximum fraction of
%                        time windows that may have arbitrarily low amplitude (e.g., due to the
%                        sensors being unplugged). (default: 0.1)
%
%   MinCleanFraction : Minimum fraction that needs to be clean. This is the minimum fraction of time
%                      windows that need to contain essentially uncontaminated EEG. (default: 0.25)
%
%
%   The following are expert-level parameters that you should not tune unless you fully understand
%   how the method works.
%
%   TruncateQuantile : Truncated Gaussian quantile. Quantile range [upper,lower] of the truncated
%                      Gaussian distribution that shall be fit to the EEG contents. (default: [0.022 0.6])
%
%   StepSizes : Grid search stepping. Step size of the grid search, in quantiles; separately for
%               [lower,upper] edge of the truncated Gaussian. The lower edge has finer stepping
%               because the clean data density is assumed to be lower there, so small changes in
%               quantile amount to large changes in data space. (default: [0.01 0.01])
%
%   ShapeRange : Shape parameter range. Search range for the shape parameter of the generalized
%                Gaussian distribution used to fit clean EEG. (default: 1.7:0.15:3.5)
%
%
% Out:
%   Signal : data set with local peaks removed
%
% Examples:
%   % use the defaults
%   eeg = clean_asr(eeg);
%
%   % use a more aggressive threshold
%   eeg = clean_asr(eeg,2.5);
%
%   % disable subset selection of calibration data (use all data instead)
%   eeg = clean_asr(eeg,[],[],[],[],'off');
%
%   % use a custom calibration measurement (e.g., EEGLAB dataset containing a baseline recording)
%   eeg = clean_asr(eeg,[],[],[],[],mybaseline);
%
%                                Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                                2012-10-15
%% Input validation
if isempty(doGPU); doGPU = 0; end
if isempty(refBurst); refBurst = 5; end
if isempty(refMaxBadChs); refMaxBadChs = 0.075; end
if isempty(refTols); refTols = [-3.5 5.5]; end
if isempty(refWinSz); refWinSz = 1; end
if isempty(winSz); winSz = 0.5; end
winSz = max([winSz 0.5 1.5*EEG.nbchan/EEG.srate]);
if isempty(winOverlap); winOverlap=2/3; end
if isempty(stepSz); stepSz = floor(EEG.srate/3); end % floor(EEG.srate*winLength/2);
if isempty(filtHz);  filtHz  = [0  2   3   13 16 40 80 EEG.srate/2]; end
if isempty(filtMag); filtMag = [3 .75 .33 .33 1  1  3  3]; end
if isempty(dimsPCA); dimsPCA = 2/3; end
if isempty(refMaxDropout); refMaxDropout = 0.1; end
if isempty(refMinClean); refMinClean = 0.25; end
if isempty(truncQuant); truncQuant = [0.022 0.6]; end
if isempty(stepSizes); stepSizes = [0.01 0.01]; end
if isempty(shapeRange); shapeRange = 1.7:0.15:3.5; end
if isempty(maxMem)
    if doGPU
        reset(gpuDevice()); maxMem=gpuDevice();
        maxMem = maxMem.AvailableMemory/2^20;
    else
        maxMem = ec_ramAvail/2^21;
    end
end
[C,S] = size(EEG.data);
if ~isany(blockSz)
    blockSz = ceil((C*C*S*8*3*2)/(maxMem*(2^20))); %blockSz = max(blockSz,ceil((C*C*S*8*3*2)/hlp_memfree));
end
dimsPCA = round(ec_rank(EEG.data')*dimsPCA);
disp("ASR: maxMem="+maxMem+" | stepSz="+stepSz+" | blockSz="+blockSz+" | dimsPCA="+dimsPCA);


%% Find clean data for reference calibration
refDat = [];
if isnumeric(refMaxBadChs) && isnumeric(refTols) && isnumeric(refWinSz)
    disp('Finding a clean section of the data...');
    try
        refDat = cleanWindows_lfn(EEG,refMaxBadChs,refTols,refWinSz,winOverlap,...
            refMaxDropout,refMinClean,truncQuant,stepSizes,shapeRange);
    catch ME
        disp('An error occurred while trying to identify a subset of clean calibration data from the recording.');
        disp('If this is because do not have EEGLAB loaded or no Statistics toolbox, you can generally');
        disp('skip this step by passing in ''off'' as the ReferenceMaxBadChannels parameter.');
        disp('Error details: '); hlp_handleerror(ME,1); disp('Falling back to using the entire data for calibration.')
    end
elseif strcmp(refMaxBadChs,'off') || strcmp(refTols,'off') || strcmp(refWinSz,'off')
elseif ischar(refMaxBadChs) && isvarname(refMaxBadChs)
    disp('Using a user-supplied data set in the workspace.');
    refDat = evalin('base',refMaxBadChs);
elseif all(isfield(refMaxBadChs,{'data','srate','chanlocs'}))
    disp('Using a user-supplied clean section of data.');
    refDat = refMaxBadChs;
end

% Fallback using all data as reference data
if isempty(refDat)
    refDat = EEG;
    disp('Using the entire data for calibration (reference parameters set to ''off'').');
end

%% Calibrate on the reference data
disp('Estimating calibration statistics; this may take a while...');
state = ec_ASRcalibrate(refDat.data,refDat.srate,refBurst,blockSz,filtHz,filtMag,winSz,...
    winOverlap,refMaxDropout,refMinClean,maxMem,doGPU);
clear refDat;

% Extrapolate last few samples of the signal
sig = 2*EEG.data(:,end) - EEG.data(:,(end-1):-1:end-round(winSz/2*EEG.srate));
sigSz = width(sig);
sig = [EEG.data sig];
%sig = [EEG.data 2*EEG.data(:,end) - EEG.data(:,(end-1):-1:end-round(winSz/2*EEG.srate))];
% bsxfun(@minus,2*EEG.data(:,end),EEG.data(:,(end-1):-1:end-round(winSz/2*EEG.srate)))

%% Process signal with ASR
[EEG.data,state] = asr_lfn(sig,EEG.srate,state,winSz,winSz/2,stepSz,dimsPCA,maxMem,doGPU);
EEG.data(:,1:size(state.carry,2)) = []; % Shift signal content back (to compensate for processing delay)
if EEG.pnts == width(EEG.data)-sigSz
    EEG.data(:,EEG.pnts+1:end) = [];
end




%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Clean windows %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [EEG,sample_mask] = cleanWindows_lfn(EEG,refMaxBadChs,refTols,refWinSz,...
    winOverlap,refMaxDropout,refMinClean,truncQuant,stepSizes,shapeRange)
% Remove periods with abnormally high-power content from continuous data.
% [Signal,Mask] = clean_windows(Signal,MaxBadChannels,PowerTolerances,WindowLength,WindowOverlap,MaxDropoutFraction,Min)
%
% This function cuts segments from the data which contain high-power artifacts. Specifically,
% only windows are retained which have less than a certain fraction of "bad" channels, where a channel
% is bad in a window if its power is above or below a given upper/lower threshold (in standard 
% deviations from a robust estimate of the EEG power distribution in the channel).
%
% In:
%   Signal         : Continuous data set, assumed to be appropriately high-passed (e.g. >1Hz or
%                    0.5Hz - 2.0Hz transition band)
%
%   MaxBadChannels : The maximum number or fraction of bad channels that a retained window may still
%                    contain (more than this and it is removed). Reasonable range is 0.05 (very clean
%                    output) to 0.3 (very lax cleaning of only coarse artifacts). Default: 0.2.
%
%   PowerTolerances: The minimum and maximum standard deviations within which the RMS of a channel
%                    must lie (relative to a robust estimate of the clean EEG RMS distribution in 
%                    the channel) for it to be considered "not bad". Default: [-3.5 5].
%
%   The following are detail parameters that usually do not have to be tuned. If you can't get
%   the function to do what you want, you might consider adapting these to your data.
%
%   WindowLength    : Window length that is used to check the data for artifact content. This is 
%                     ideally as long as the expected time scale of the artifacts but not shorter 
%                     than half a cycle of the high-pass filter that was used. Default: 1.
%
%   WindowOverlap : Window overlap fraction. The fraction of two successive windows that overlaps.
%                   Higher overlap ensures that fewer artifact portions are going to be missed (but
%                   is slower). (default: 0.66)
% 
%   MaxDropoutFraction : Maximum fraction that can have dropouts. This is the maximum fraction of
%                        time windows that may have arbitrarily low amplitude (e.g., due to the
%                        sensors being unplugged). (default: 0.1)
%
%   MinCleanFraction : Minimum fraction that needs to be clean. This is the minimum fraction of time
%                      windows that need to contain essentially uncontaminated EEG. (default: 0.25)
%
%   
%   The following are expert-level parameters that you should not tune unless you fully understand
%   how the method works.
%
%   TruncateQuantile : Truncated Gaussian quantile. Quantile range [upper,lower] of the truncated
%                      Gaussian distribution that shall be fit to the EEG contents. (default: [0.022 0.6])
%
%   StepSizes : Grid search stepping. Step size of the grid search, in quantiles; separately for
%               [lower,upper] edge of the truncated Gaussian. The lower edge has finer stepping
%               because the clean data density is assumed to be lower there, so small changes in
%               quantile amount to large changes in data space. (default: [0.01 0.01])
%
%   ShapeRange : Shape parameter range. Search range for the shape parameter of the generalized
%                Gaussian distribution used to fit clean EEG. (default: 1.7:0.15:3.5)
%
% Out:
%   Signal : data set with bad time periods removed.
%
%   Mask   : mask of retained samples (logical array)
%
%                                Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                                2010-07-06

% Input validation
if isempty(refMaxBadChs); refMaxBadChs = 0.2; end
if isempty(refTols); refTols = [-3.5 5]; end
if isempty(refWinSz); refWinSz = 1; end
if isempty(winOverlap); winOverlap = 0.66; end
if isempty(refMaxDropout); refMaxDropout = 0.1; end
if isempty(refMinClean); refMinClean = 0.25; end
if isempty(truncQuant); truncQuant = [0.022 0.6]; end
if isempty(stepSizes); stepSizes = [0.01 0.01]; end
if isempty(shapeRange); shapeRange = 1.7:0.15:3.5; end
if ~isempty(refMaxBadChs) && refMaxBadChs > 0 && refMaxBadChs < 1 %#ok<*NODEF>
    refMaxBadChs = round(size(EEG.data,1)*refMaxBadChs); end

% Initialize
[C,S] = size(EEG.data);
N = refWinSz*EEG.srate;
wnd = 0:N-1;
offsets = round(1:N*(1-winOverlap):S-N);

% Time window rejection for each channel...
fprintf('Determining time window rejection thresholds...');
for c = C:-1:1
    % Compute RMS amplitude for each window...
    X = EEG.data(c,:).^2;
    X = sqrt(sum(X(bsxfun(@plus,offsets,wnd')))/N);

    % Robustly fit a distribution to the clean EEG part
    [mu,sig] = fit_eeg_distribution(X,refMinClean,refMaxDropout,truncQuant,stepSizes,shapeRange);

    % Calculate z scores relative to that
    wz(c,:) = (X - mu)/sig;
end
wz = sort(wz); % Sort z scores into quantiles
disp('done.');

% Determine which windows to remove
remove_mask = false(1,size(wz,2));
if max(refTols)>0
    remove_mask(wz(end-refMaxBadChs,:) > max(refTols)) = true; end
if min(refTols)<0
    remove_mask(wz(1+refMaxBadChs,:) < min(refTols)) = true; end
removed_windows = find(remove_mask);

% Find indices of samples to remove
removed_samples = repmat(offsets(removed_windows)',1,length(wnd))+repmat(wnd,length(removed_windows),1);
sample_mask = true(1,S); % mask them out
sample_mask(removed_samples(:)) = false;
fprintf('Keeping %.1f%% (%.0f seconds) of the data.\n',100*(mean(sample_mask)),nnz(sample_mask)/EEG.srate);

% Determine intervals to retain
retain_data_intervals = reshape(find(diff([false sample_mask false])),2,[])';
retain_data_intervals(:,2) = retain_data_intervals(:,2)-1;

% Apply selection
try
    EEG = pop_select(EEG,'point',retain_data_intervals);
    EEG = eeg_checkset(EEG,'eventconsistency');
catch e
    if ~exist('pop_select','file')
        disp('Apparently you do not have EEGLAB''s pop_select() on the path.');
    else
        disp('Could not select time windows using EEGLAB''s pop_select(); details: ');
        hlp_handleerror(e,1);
    end
    warning('Falling back to a basic substitute and dropping signal meta-data.');
    EEG.data = EEG.data(:,sample_mask);
    EEG.pnts = size(EEG.data,2);
    EEG.xmax = EEG.xmin + (EEG.pnts-1)/EEG.srate;    
    [EEG.event,EEG.urevent,EEG.epoch,EEG.icaact,EEG.reject,EEG.stats,EEG.specdata,EEG.specicaact] = deal(EEG.event([]),EEG.urevent([]),[],[],[],[],[],[]);
end
% if isfield(signal.etc,'clean_sample_mask')
%     signal.etc.clean_sample_mask(signal.etc.clean_sample_mask) = sample_mask;
% else
%     signal.etc.clean_sample_mask = sample_mask;
% end
if isfield(EEG.etc,'clean_sample_mask')
    oneInds = find(EEG.etc.clean_sample_mask == 1);
    if length(oneInds) == length(sample_mask)
        EEG.etc.clean_sample_mask(oneInds) = sample_mask;
    else
        disp('Warning: EEG.etc.clean_sample is present. It is overwritten.');
    end
else
    EEG.etc.clean_sample_mask = sample_mask;
end




%% Main ASR processing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [data,state] = asr_lfn(data,fs,state,winSz,lookahead,stepSz,dimsPCA,maxMem,doGPU)
% Processing function for the Artifact Subspace Reconstruction (ASR) method.
% [Data,State] = asr_process(Data,SamplingRate,State,WindowLength,LookAhead,StepSize,MaxDimensions,MaxMemory,UseGPU)
%
% This function is used to clean multi-channel signal using the ASR method. The required inputs are
% the data matrix, the sampling rate of the data, and the filter state (as initialized by
% asr_calibrate). If the data is used on successive chunks of data, the output state of the previous
% call to asr_process should be passed in.
%
% In:
%   Data : Chunk of data to process [#channels x #samples]. This is a chunk of data, assumed to be
%          a continuation of the data that was passed in during the last call to asr_process (if
%          any). The data should be *zero-mean* (e.g., high-pass filtered the same way as for
%          asr_calibrate).
%
%   SamplingRate : sampling rate of the data in Hz (e.g., 250.0)
%
%   State : initial filter state (determined by asr_calibrate or from previous call to asr_process)
%
%   WindowLength : Length of the statistcs window, in seconds (e.g., 0.5). This should not be much
%                  longer than the time scale over which artifacts persist, but the number of samples
%                  in the window should not be smaller than 1.5x the number of channels. Default: 0.5
%
%   LookAhead : Amount of look-ahead that the algorithm should use. Since the processing is causal,
%               the output signal will be delayed by this amount. This value is in seconds and should
%               be between 0 (no lookahead) and WindowLength/2 (optimal lookahead). The recommended
%               value is WindowLength/2. Default: WindowLength/2
%
%   StepSize : The statistics will be updated every this many samples. The larger this is, the faster
%              the algorithm will be. The value must not be larger than WindowLength*SamplingRate.
%              The minimum value is 1 (update for every sample) while a good value is 1/3 of a second.
%              Note that an update is always performed also on the first and last sample of the data
%              chunk. Default: 32
%
%   MaxDimensions : Maximum dimensionality of artifacts to remove. Up to this many dimensions (or up
%                   to this fraction of dimensions) can be removed for a given data segment. If the
%                   algorithm needs to tolerate extreme artifacts a higher value than the default
%                   may be used (the maximum fraction is 1.0). Default 0.66
%
%   MaxMemory : The maximum amount of memory used by the algorithm when processing a long chunk with
%               many channels, in MB. The recommended value is at least 64. To run on the GPU, use
%               the amount of memory available to your GPU here (needs the parallel computing toolbox).
%               default: min(5000,1/2 * free memory in MB). Using smaller amounts of memory leads to
%               longer running times.
%
%   UseGPU : Whether to run on the GPU. This makes sense for offline processing if you have a a card
%            with enough memory and good double-precision performance (e.g., NVIDIA GTX Titan or
%            K20). Note that for this to work you need to have the Parallel Computing toolbox.
%            Default: false
%
% Out:
%   Data : cleaned data chunk (same length as input but delayed by LookAhead samples)
%
%   State : final filter state (can be passed in for subsequent calls)
%
%
% History
% 03/20/2019 Makoto and Chiyuan. Supported 'availableRAM_GB'. GUI switched to GUIDE-made.
% 08/31/2012 Christian. Created.
%                                Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                                2012-08-31

% Input validation
if isempty(data); return; end
if isempty(winSz); winSz = 0.5; end
if isempty(lookahead); lookahead=winSz/2; end
if isempty(stepSz); stepSz = 32; end
if isempty(dimsPCA); dimsPCA = 0.66; end
if isempty(doGPU); doGPU = false; end
if dimsPCA<1; dimsPCA = round(ec_rank(data')*dimsPCA); end

%% Prep
[C,S] = size(data);
N = round(winSz*fs);
P = round(lookahead*fs);
[T,M,A,B] = deal(state.T,state.M,state.A,state.B); % T, threshold; M, mixing matrix from the calibration data (sqrt of covariance matrix), IIR filter, IIR filter 

% Initialize prior filter state by extrapolating available data into the past (if necessary)
if isempty(state.carry)
    state.carry = repmat(2*data(:,1),1,P) - data(:,1+mod(((P+1):-1:2)-1,S)); end
data = [state.carry data];
data(~isfinite(data(:))) = 0;

% Split up the total sample range into k chunks that will fit in memory
if maxMem*1024*1024 - C*C*P*8*3 < 0
    disp('Memory too low, increasing it (rejection block size now depends on available memory so it might not be 100% reproducible)...');
    maxMem = maxMem/(2^21);
    if maxMem*1024*1024 - C*C*P*8*3 < 0
    	error('Not enough memory');
    end
end
splits = ceil((C*C*S*8*8 + C*C*8*S/stepSz + C*S*8*2 + S*8*5) / (maxMem*1024*1024 - C*C*P*8*3)); % Mysterious. More memory available, less 'splits'

%% Clean data across blocks
fprintf('Now cleaning data in %i blocks',splits);
for ii = 1:splits
    range = 1+floor((ii-1)*S/splits):min(S,floor(ii*S/splits));
    if isempty(range); continue; end

    % Get spectrally shaped data X for statistics computation (range shifted by lookahead)
    [X,state.iir] = filter(B,A,data(:,range+P),state.iir,2);

    %%% GPU computations if applicable %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if doGPU && length(range)>1000; X = gpuArray(X); end

    % Compute running mean covariance (assuming a zero-mean signal)
    [Xcov,state.cov] = movingAvg_lfn(N,reshape(bsxfun(@times,reshape(X,1,C,[]),reshape(X,C,1,[])),C*C,[]),state.cov); % ch c ch x range.
    
    % Extract the subset of time points at which we intend to update
    update_at = min(stepSz:stepSz:(size(Xcov,2)+stepSz-1),size(Xcov,2));
    if isempty(state.last_R) % If there is no previous R (from the end of the last chunk), 
        update_at = [1 update_at]; % we estimate it right at the first sample
        state.last_R = eye(C);
    end
    Xcov = reshape(Xcov(:,update_at),C,C,[]);
    if isgpuarray(Xcov); Xcov=gather(Xcov); end
    %%% Back to CPU %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Do the reconstruction in intervals of length stepsize (or shorter if at the end of a chunk)
    last_n = 0;
    for j = 1:length(update_at)
        % Do a PCA to find potential artifact components
        [V,D] = eig(Xcov(:,:,j));
        [D,order] = sort(reshape(diag(D),1,C)); V = V(:,order);

        % Determine which components to keep (variance below directional threshold or not admissible for rejection)
        keep = D<sum((T*V).^2) | (1:C)<(C-dimsPCA); trivial = all(keep);

        % Update the reconstruction matrix R (reconstruct artifact components using the mixing matrix)
        if ~trivial
            R = real(M*pinv(bsxfun(@times,keep',V'*M))*V');
        else
            R = eye(C);
        end

        % Apply the reconstruction to intermediate samples (using raised-cosine blending)
        n = update_at(j);
        if ~trivial || ~state.last_trivial
            subrange = range((last_n+1):n);
            blend = (1-cos(pi*(1:(n-last_n))/(n-last_n)))/2;
            data(:,subrange) = bsxfun(@times,blend,R*data(:,subrange)) + bsxfun(@times,1-blend,state.last_R*data(:,subrange));
        end
        [last_n,state.last_R,state.last_trivial] = deal(n,R,trivial);
    end
    fprintf('.');
end
fprintf('\n');

% Carry the look-ahead portion of the data over to the state (for successive calls)
state.carry = [state.carry data(:,(end-P+1):end)];
state.carry = state.carry(:,(end-P+1):end);

% Finalize outputs (gather remaining GPU data)
fNames = string(fieldnames(state));
for ii = 1:length(fNames)
    if isgpuarray(state.(fNames(ii))); state.(fNames(ii))=gather(state.(fNames(ii))); end
end
if isgpuarray(data); data=gather(data); end



%% Moving average subfuntion
function [X,Zf] = movingAvg_lfn(N,X,Zi)
% Run a moving-average filter along the second dimension of the data.
% [X,Zf] = moving_average(N,X,Zi)
%
% In:
%   N : filter length in samples
%   X : data matrix [#Channels x #Samples]
%   Zi : initial filter conditions (default: [])
%
% Out:
%   X : the filtered data
%   Zf : final filter conditions

% Pre-pend initial state & get dimensions
if nargin <= 2 || isempty(Zi)
    Zi = zeros(size(X,1),N); end
Y = [Zi X];
M = size(Y,2);

% Calculate
I = [1:M-N; 1+N:M]; % get alternating index vector (for additions & subtractions)
S = [-ones(1,M-N); ones(1,M-N)]/N; % get sign vector (also alternating, and includes the scaling)
X = cumsum(bsxfun(@times,Y(:,I(:)),S(:)'),2); % run moving average
X = X(:,2:2:end); % read out result
if nargout > 1
    Zf = [-(X(:,end)*N-Y(:,end-N+1)) Y(:,end-N+2:end)];
end



