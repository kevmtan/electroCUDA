function state = ec_ASRcalibrate(X,fs,refBurst,blockSz,filtHz,filtMag,winSz,...
    winOverlap,refMaxDropout,refMinClean,maxMem,doGPU)
% Calibration function for the Artifact Subspace Reconstruction (ASR) method.
% State = asr_calibrate(Data,SamplingRate,Cutoff,BlockSize,FilterB,FilterA,WindowLength,WindowOverlap,MaxDropoutFraction,MinCleanFraction,MaxMemory)
%
% The input to this data is a multi-channel time series of calibration data. In typical uses the
% calibration data is clean resting EEG data of ca. 1 minute duration (can also be longer). One can
% also use on-task data if the fraction of artifact content is below the breakdown point of the
% robust statistics used for estimation (50% theoretical, ~30% practical). If the data has a
% proportion of more than 30-50% artifacts then bad time windows should be removed beforehand. This
% data is used to estimate the thresholds that are used by the ASR processing function to identify
% and remove artifact components.
%
% The calibration data must have been recorded for the same cap design from which data for cleanup
% will be recorded, and ideally should be from the same session and same subject, but it is possible
% to reuse the calibration data from a previous session and montage to the extent that the cap is
% placed in the same location (where loss in accuracy is more or less proportional to the mismatch
% in cap placement).
%
% The calibration data should have been high-pass filtered (for example at 0.5Hz or 1Hz using a
% Butterworth IIR filter).
%
% In:
%   Data : Calibration data [#channels x #samples]; *zero-mean* (e.g., high-pass filtered) and
%          reasonably clean EEG of not much less than 30 seconds length (this method is typically
%          used with 1 minute or more).
%
%   SamplingRate : Sampling rate of the data, in Hz.
%
%
%   The following are optional parameters (the key parameter of the method is the RejectionCutoff):
%
%   RejectionCutoff: Standard deviation cutoff for rejection. Data portions whose variance is larger
%                    than this threshold relative to the calibration data are considered missing
%                    data and will be removed. The most aggressive value that can be used without
%                    losing too much EEG is 5. Default: 5.
%
%   Blocksize : Block size for calculating the robust data covariance and thresholds, in samples;
%               allows to reduce the memory and time requirements of the robust estimators by this 
%               factor (down to Channels x Channels x Samples x 16 / Blocksize bytes). Default: 10
%
%   FilterB, FilterA : Coefficients of an IIR filter that is used to shape the spectrum of the signal
%                      when calculating artifact statistics. The output signal does not go through
%                      this filter. This is an optional way to tune the sensitivity of the algorithm
%                      to each frequency component of the signal. The default filter is less
%                      sensitive at alpha and beta frequencies and more sensitive at delta (blinks)
%                      and gamma (muscle) frequencies. Default: 
%                      [b,a] = yulewalk(8,[[0 2 3 13 16 40 min(80,srate/2-1)]*2/srate 1],[3 0.75 0.33 0.33 1 1 3 3]);
%
%   WindowLength : Window length that is used to check the data for artifact content. This is 
%                  ideally as long as the expected time scale of the artifacts but short enough to 
%				   allow for several 1000 windows to compute statistics over. Default: 0.5.
%
%   WindowOverlap : Window overlap fraction. The fraction of two successive windows that overlaps.
%                   Higher overlap ensures that fewer artifact portions are going to be missed (but
%                   is slower). Default: 0.66
%
%   MaxDropoutFraction : Maximum fraction of windows that can be subject to signal dropouts 
%                        (e.g., sensor unplugged), used for threshold estimation. Default: 0.1
%
%   MinCleanFraction : Minimum fraction of windows that need to be clean, used for threshold
%                      estimation. Default: 0.25
% 
%   MaxMemory : The maximum amount of memory used by the algorithm when processing a long chunk with
%               many channels, in MB. The recommended value is 64 Mb. To run on the GPU, use
%               the amount of memory available to your GPU here (needs the parallel computing toolbox).
%               default: min(5000,1/2 * free memory in MB). Using smaller amounts of memory leads to
%               longer running times.
%
% Out:
%   State : initial state struct for asr_process
%
% Notes:
%   This can run on a GPU with large memory and good double-precision performance for faster processing 
%   (e.g., on an NVIDIA GTX Titan or K20), but requires that the Parallel Computing toolbox is
%   installed.
%
%                                Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                                2012-08-31
% asr_calibrate_version<1.03> -- for the cache

% Input validation
arguments
    X {mustBeFloat}
    fs (1,1){isnumeric}
    refBurst (1,1){isnumeric} = 5
    blockSz {isnumeric} = [] % Block size of calculations in samples
    filtHz (1,:) double =  [0  2   3   13 16 40 80 fs/2] % Filter frequencies
    filtMag (1,:) double = [3 .75 .33 .33 1  1  3  3]    % Filter magnitude
    winSz (1,1){isnumeric} = 1 % Window length (secs) of artifact detection
    winOverlap (1,1){isnumeric} = 2/3 % fraction of two successive windows that overlaps
    refMaxDropout (1,1){isnumeric} = 0.1 % Max pct of wins with signal dropouts
    refMinClean (1,1){isnumeric} = 0.25 % Min pct of wins that need to be clean for thresh estimates
    maxMem {isnumeric} = []
    doGPU (1,1) logical = false
end

%% Prep
X(~isfinite(X(:))) = 0;
[C,S] = size(X);
if isempty(blockSz)
    blockSz = max(blockSz,ceil((C*C*S*8*3*2)/(maxMem*(2^20)))); %blockSz = max(blockSz,ceil((C*C*S*8*3*2)/hlp_memfree));
end
% Yulewalk to design the filter (Signal Processing toolbox required)
filtHz = filtHz / round(fs/2); % scale by nyquist
filtHz(filtHz>1)=[]; filtMag(filtHz>1)=[]; filtHz(filtHz<0)=[]; filtMag(filtHz<0)=[];
if filtHz(1)~=0; filtHz=[0 filtHz]; filtMag=[3 filtMag]; end %filtHz = [[0 2 3 13 16 40 min(80,fs/2-1)]*2/fs 1];
if filtHz(end)~=1; filtHz=[filtHz 1]; filtMag=[filtMag 1]; end %amps = [3 0.75 0.33 0.33 1 1 3 3];
[B,A] = yulewalk(8,filtHz,filtMag);
disp(["filtHz: ",filtHz]); disp(["filtMag: ",filtMag]);
% % Yulewalk to design the filter (Signal Processing toolbox required)
% X(~isfinite(X(:))) = 0;
% filtHz = [0 2 3 13 16 40 min(80,fs/2-1)] * 2/fs;
% filtMag = [3 0.75 0.33 0.33 1 1 3 3];
% if fs < 80
%     filtHz(end-2) = [];
%     filtMag(end) = []; % we do not want to attenuate min(80,srate/2-1) since it is below 40 Hz
% end

% Apply the signal shaping filter and initialize the IIR filter state
[X,iirstate] = filter(B,A,double(X),[],2); X=X';
if any(~isfinite(X(:))); error('The IIR filter diverged on your data. Please try using either a more conservative filter or removing some bad sections/channels from the calibration data.'); end

% Calculate the sample covariance matrices U (averaged in blocks of blocksize successive samples)
U = zeros(length(1:blockSz:S),C*C);
for k = 1:blockSz
    range = min(S,k:blockSz:(S+k-1));
    U = U + reshape(bsxfun(@times,reshape(X(range,:),[],1,C),reshape(X(range,:),[],C,1)),size(U));
end

% Get the mixing matrix M
med = geometricMedianBlock_lfn(U/blockSz,1,doGPU);
if isnan(med(1)) && size(U,2)==1, med=median(U); end
M = sqrtm(real(reshape(med,C,C)));

% Window length for calculating thresholds
N = round(winSz*fs);
if S<N; error('No enough reference data, call the function from the command line and try changing the ''BurstCriterionRefTolerances'' parameters (to -10 to 10 for example)'); end

% Get the threshold matrix T
fprintf('Determining per-component thresholds...');
[V,~] = eig(M);
X = abs(X*V);
for c = C:-1:1
    % Compute RMS amplitude for each window...
    rms = X(:,c).^2;
    rms = sqrt(sum(rms(bsxfun(@plus,round(1:N*(1-winOverlap):S-N),(0:N-1)')))/N);
    % Fit a distribution to the clean part
    [mu(c),sig(c)] = fit_eeg_distribution(rms,refMinClean,refMaxDropout);
end
T = diag(mu + refBurst*sig)*V';
disp('done.');

% Initialize the remaining filter state
state = struct('M',M,'T',T,'B',B,'A',A,'cov',[],'carry',[],'iir',iirstate,'last_R',[],'last_trivial',true);



%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Block Geometric Median %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = geometricMedianBlock_lfn(X,blockSz,doGPU)
% Calculate a blockwise geometric median (faster and less memory-intensive 
% than the regular geom_median function).
%
% This statistic is not robust to artifacts that persist over a duration that
% is significantly shorter than the blocksize.
%
% In:
%   X : the data (#observations x #variables)
%   blocksize : the number of successive samples over which a regular mean 
%               should be taken
%   tol : tolerance (default: 1.e-5)
%   y : initial value (default: median(X))
%   max_iter : max number of iterations (default: 500)
%
% Out:
%   g : geometric median over X
%
% Notes:
%   This function is noticably faster if the length of the data is divisible by the block size.
%   Uses the GPU if available.

if isempty(blockSz); blockSz = 1; end
tol = 1e-5;
maxIter = 500;

if blockSz > 1
    [o,v] = size(X);       % #observations & #variables
    r = mod(o,blockSz);  % #rest in last block
    b = (o-r)/blockSz;   % #blocks
    if r > 0
        X = [reshape(sum(reshape(X(1:(o-r),:),blockSz,b*v)),b,v); sum(X((o-r+1):end,:))*(blockSz/r)];
    else
        X = reshape(sum(reshape(X,blockSz,b*v)),b,v);
    end
end

% Try running on GPU
fin = 0;
if doGPU
%     try
%         y = gather(geometricMedian_lfn(gpuArray(X),tol,maxIter)) / blockSz;
%         fin = 1;
%     catch ME; getReport(ME)
%         disp("ec_ASRcalibrate/geometricMedian_lfn: GPU error, switching to CPU...");
%     end
end

% Run on CPU (fallback for GPU error)
if ~fin
    y = geometricMedian_lfn(X,tol,maxIter) / blockSz;
end



%% Geometric Median %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = geometricMedian_lfn(X,tol,max_iter)
% Calculate the geometric median for a set of observations (mean under a Laplacian noise distribution)
% This is using Weiszfeld's algorithm.
%
% In:
%   X : the data, as in mean
%   tol : tolerance (default: 1.e-5)
%   y : initial value (default: median(X))
%   max_iter : max number of iterations (default: 500)
%
% Out:
%   g : geometric median over X

y = median(X,"omitnan");

for ii = 1:max_iter
    invnorms = 1./sqrt(sum(bsxfun(@minus,X,y).^2,2));
    [y,oldy] = deal(sum(bsxfun(@times,X,invnorms)) / sum(invnorms),y);
    if norm(y-oldy)/norm(y)<tol; break; end
end


