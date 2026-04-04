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
    blockSz = ceil((C*C*S*8*3*2)/maxMem);
    %blockSz = max(blockSz,ceil((C*C*S*8*3*2)/(maxMem*(2^21))); %blockSz = max(blockSz,ceil((C*C*S*8*3*2)/hlp_memfree));
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
    try
        y = geometricMedian_lfn(gpuArray(X),gpuArray(tol),gpuArray(maxIter)) / blockSz;
        y = gather(y);
        fin = 1;
    catch ME; getReport(ME)
        disp("ec_ASRcalibrate/geometricMedian_lfn: GPU error, switching to CPU...");
    end
end

% Run on CPU (fallback for GPU error)
if ~fin
    y = geometricMedian_lfn(X,tol,maxIter) / blockSz;
end






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






% function [mu,sig,alpha,beta] = fit_eeg_distribution(X,min_clean_fraction,max_dropout_fraction,quants,step_sizes,beta)
% % Estimate the mean and standard deviation of clean EEG from contaminated data.
% % [Mu,Sigma,Alpha,Beta] = fit_eeg_distribution(X,MinCleanFraction,MaxDropoutFraction,FitQuantiles,StepSizes,ShapeRange)
% %
% % This function estimates the mean and standard deviation of clean EEG from a sample of amplitude
% % values (that have preferably been computed over short windows) that may include a large fraction
% % of contaminated samples. The clean EEG is assumed to represent a generalized Gaussian component in
% % a mixture with near-arbitrary artifact components. By default, at least 25% (MinCleanFraction) of
% % the data must be clean EEG, and the rest can be contaminated. No more than 10%
% % (MaxDropoutFraction) of the data is allowed to come from contaminations that cause lower-than-EEG
% % amplitudes (e.g., sensor unplugged). There are no restrictions on artifacts causing
% % larger-than-EEG amplitudes, i.e., virtually anything is handled (with the exception of a very
% % unlikely type of distribution that combines with the clean EEG samples into a larger symmetric
% % generalized Gaussian peak and thereby "fools" the estimator). The default parameters should be
% % fine for a wide range of settings but may be adapted to accomodate special circumstances.
% %
% % The method works by fitting a truncated generalized Gaussian whose parameters are constrained by
% % MinCleanFraction, MaxDropoutFraction, FitQuantiles, and ShapeRange. The alpha and beta parameters
% % of the gen. Gaussian are also returned. The fit is performed by a grid search that always finds a
% % close-to-optimal solution if the above assumptions are fulfilled.
% %
% % In:
% %   X : vector of amplitude values of EEG, possible containing artifacts
% %       (coming from single samples or windowed averages)
% %
% %   MinCleanFraction : Minimum fraction of values in X that needs to be clean
% %                      (default: 0.25)
% %
% %   MaxDropoutFraction : Maximum fraction of values in X that can be subject to
% %                        signal dropouts (e.g., sensor unplugged) (default: 0.1)
% %
% %   FitQuantiles : Quantile range [lower,upper] of the truncated generalized Gaussian distribution
% %                  that shall be fit to the EEG contents (default: [0.022 0.6])
% %
% %   StepSizes : Step size of the grid search; the first value is the stepping of the lower bound
% %               (which essentially steps over any dropout samples), and the second value
% %               is the stepping over possible scales (i.e., clean-data quantiles)
% %               (default: [0.01 0.01])
% %
% %   ShapeRange : Range that the clean EEG distribution's shape parameter beta may take (default:
% %                1.7:0.15:3.5)
% %
% % Out:
% %   Mu : estimated mean of the clean EEG distribution
% %
% %   Sigma : estimated standard deviation of the clean EEG distribution
% %
% %   Alpha : estimated scale parameter of the generalized Gaussian clean EEG distribution (optional)
% %
% %   Beta : estimated shape parameter of the generalized Gaussian clean EEG distribution (optional)
% 
% % assign defaults
% if ~exist('min_clean_fraction','var') || isempty(min_clean_fraction)
%     min_clean_fraction = 0.25; end
% if ~exist('max_dropout_fraction','var') || isempty(max_dropout_fraction)
%     max_dropout_fraction = 0.1; end
% if ~exist('quants','var') || isempty(quants)
%     quants = [0.022 0.6]; end
% if ~exist('step_sizes','var') || isempty(step_sizes)
%     step_sizes = [0.01 0.01]; end
% if ~exist('beta','var') || isempty(beta)
%     beta = 1.7:0.15:3.5; end
% 
% % sanity checks
% if ~isvector(quants) || numel(quants) > 2
%     error('Fit quantiles needs to be a 2-element vector (support for matrices deprecated).'); end
% if any(quants(:)<0) || any(quants(:)>1)
%     error('Unreasonable fit quantiles.'); end
% if any(step_sizes<0.0001) || any(step_sizes>0.1)
%     error('Unreasonable step sizes.'); end
% if any(beta>=7) || any(beta<=1)
%     error('Unreasonable shape range.'); end
% 
% % sort data so we can access quantiles directly
% X = double(sort(X(:)));
% n = length(X);
% 
% % calc z bounds for the truncated standard generalized Gaussian pdf and pdf rescaler
% for b=1:length(beta)    
%     zbounds{b} = sign(quants-1/2).*gammaincinv(sign(quants-1/2).*(2*quants-1),1/beta(b)).^(1/beta(b)); %#ok<*AGROW>
%     rescale(b) = beta(b)/(2*gamma(1/beta(b)));
% end
% 
% % determine the quantile-dependent limits for the grid search
% lower_min = min(quants);                    % we can generally skip the tail below the lower quantile
% max_width = diff(quants);                   % maximum width is the fit interval if all data is clean
% min_width = min_clean_fraction*max_width;   % minimum width of the fit interval, as fraction of data
% 
% % get matrix of shifted data ranges
% X = X(bsxfun(@plus,(1:round(n*max_width))',round(n*(lower_min:step_sizes(1):lower_min+max_dropout_fraction))));
% X1 = X(1,:); X = bsxfun(@minus,X,X1);
% 
% opt_val = Inf;
% % for each interval width...
% for m = round(n*(max_width:-step_sizes(2):min_width))
%     % scale and bin the data in the intervals
%     nbins = round(3*log2(1+m/2));
%     H = bsxfun(@times,X(1:m,:),nbins./X(m,:));
%     logq = log(histc(H,[0:nbins-1,Inf]) + 0.01);
%     if size(logq,1) == 1, logq = logq'; end
% 
%     % for each shape value...
%     for b=1:length(beta)
%         bounds = zbounds{b};
%         % evaluate truncated generalized Gaussian pdf at bin centers
%         x = bounds(1)+(0.5:(nbins-0.5))/nbins*diff(bounds);
%         p = exp(-abs(x).^beta(b))*rescale(b); p=p'/sum(p);
% 
%         % calc KL divergences
%         kl = sum(bsxfun(@times,p,bsxfun(@minus,log(p),logq(1:end-1,:)))) + log(m);
% 
%         % update optimal parameters
%         [min_val,idx] = min(kl);
%         if min_val < opt_val
%             opt_val = min_val;
%             opt_beta = beta(b);
%             opt_bounds = bounds;
%             opt_lu = [X1(idx) X1(idx)+X(m,idx)];
%         end
%     end
% end
% 
% % recover distribution parameters at optimum
% alpha = (opt_lu(2)-opt_lu(1))/diff(opt_bounds);
% mu = opt_lu(1)-opt_bounds(1)*alpha;
% beta = opt_beta;
% 
% % calculate the distribution's standard deviation from alpha and beta
% sig = sqrt((alpha^2)*gamma(3/beta)/gamma(1/beta));