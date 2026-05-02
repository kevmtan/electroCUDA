function [x,cwtNfo,fb] = ec_wt(x,a)
% Process function for wavelet transforms called by high-level functions
% Parallel on CPU, Matlab-GPU (fast), or CUDA-GPU (fastest, must compile! see ecu_compile.m)
%
% INPUTS: see 'input validation' below
% OUTPUTS: [coefficients, frequencies, timeSupport, filterbank] 
%
%   Part of the electroCUDA package: github.com/kevmtan/electroCUDA
%   AUTHOR: Kevin Tan (2024)
%   LICENSE: GNU GPL v3

%% Input validation
arguments
    x (:,:){mustBeFloat}                    % EEG data: x(frames,channels)
    a.hz (1,1) double = nan                 % Sampling rate
    a.lims (1,2) double = nan               % Frequency limits [lower,upper]
    a.voices (1,1) double = 10              % Voices per octave
    a.bandwidth (1,1) double = 60           % Time Bandwidth
    a.avg (1,1) logical = false             % Scale-average transform?
    a.coef (1,1) string...                  % Output coefficient type
        {mustBeMember(a.coef,["decibel" "magnitude" "power" "complex"])} = "decibel"
    a.wavelet (1,1) string...               % Wavelet type ["morse"|"amor"|"bump"], "amor" is Gabor/Morlet
        {mustBeMember(a.wavelet,["morse" "amor" "bump"])} = "morse"
    a.ds (1,1) double {mustBeInteger} = 0   % Downsampling factor (see https://www.mathworks.com/help/signal/ref/downsample.html)
    a.mem (1,1) double = nan                % Memory to use
    a.lpfFilt {isfloat,isa(a.lpfFilt,"digitalFilter")} = [] % Anti-aliasing filter (LPF for downsampling)
    a.lpfImpulse {mustBeMember(a.lpfImpulse,["fir" "iir" "auto"])} = "auto" % Anti-aliasing impulse response
    a.lpfSteep (1,1) double = 0.85          % Anti-aliasing filter steepness
    a.single (1,1) logical = false          % Run as single-precision?
    a.singleOut (1,1) logical = false       % Output single-precision?
    a.cell (1,1) logical = false            % Output as cell instead of matrix
    a.gpu (1,1) string...                   % Run on GPU ["no"=parfor|"matlab"=arrayfun|"cuda"=mex binary]
        {mustBeMember(a.gpu,["no" "matlab" "cuda"])} = "no"
    a.tic (1,1) uint64 = tic                % Timer
end
if ~isany(a.hz); error("Must specify sampling rate (hz)"); end
if ~isany(a.lims); error("Must specify frequency limits (lims)"); end
if ~(a.ds>1); a.ds=1; end % Set no downsampling
if a.avg && a.coef=="magnitude"
    a.coef = "decibel";
    warning("Scale-averaged output can't be magnitude, outputing decibel (or specify power)");
end
if a.ds>1 && ismember(a.coef,["magnitude" "power"])
    warning("Downsampling magnitude or power outputs results in negative numbers, decibel or complex output is recommended");
end


%% Prep

% Make logical arguments
if a.singleOut; a.outClass="single"; else; a.outClass="double"; end
if a.coef=="complex"; a.real=false; else; a.real=true; end
if a.coef=="power"; a.pwr=true; else; a.pwr=false; end
if a.coef=="decibel"; a.db=true; else; a.db=false; end
if a.db && a.avg; a.pwr=true; end
if a.gpu=="matlab"; a.gpuArray=true; else; a.gpuArray=false; end

% Convert EEG to specified precision
if a.single
    x = single(x); % Convert to single if specified
else
    x = double(x); % Convert to double if not
end 

% Make anti-aliasing LPF filter for downsampling (Nyquist freq)
if a.ds>1 && a.gpu=="no" && isempty(a.lpfFilt)
    a.lpfFilt = ec_designFilt(x(:,1,1),a.hz,floor(a.hz/a.ds)/2,"lowpass",...
        steepness=op.lpfSteep,impulse="fir",coefOut=true);
    disp("[ec_epochBaseline] Created low-pass filter: "+n.sbj+" time="+toc(a.tic));
end

% Generate wavelet
fb = cwtfilterbank(Wavelet=a.wavelet,SamplingFrequency=a.hz,SignalLength=height(x),...
    VoicesPerOctave=a.voices,FrequencyLimits=a.lims,TimeBandwidth=a.bandwidth);

% CWT wavelet info
cwtNfo = waveletNfo_lfn(fb,a);
nFrqs = height(cwtNfo);


%% Run wavelet transform
if a.gpu=="cuda" && ~a.avg && a.wavelet=="morse"
    % Run CUDA binary
    if a.single
        % Single-precision
        x = ec_wt_fp32(x,nFrqs,a.hz,a.lims,a.voices,a.bandwidth,a.real,a.db,...
            a.pwr,a.ds);
    else
        % Double-precision
        x = ec_wt_fp64(x,nFrqs,a.hz,a.lims,a.voices,a.bandwidth,a.real,a.db,...
            a.pwr,a.ds);
        % Output as single
        if a.singleOut
            x = single(x);
        end
    end
    disp("[ec_wt] Ran CWT on CUDA binary: time="+toc(a.tic));
else
    % Run 
    x = runOnMatlab_lfn(fb,x,a);
end


%% Organize
if ~a.avg
    x = flip(x,3); % sort freqs from low to high
end






function y = runOnMatlab_lfn(fb,x,a)
%%% Wavelet transform on Matlab %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of channels
nChs = width(x);

% Preallocate output
if a.avg
    y = nan(ceil(height(x)/a.ds),nChs,a.outClass);
else
    y = nan(ceil(height(x)/a.ds),nChs,numel(fb.centerFrequencies),a.outClass);
end


%% Wavelet transform across chans
if a.gpu~="no"
    % Run on GPU
    for ch = 1:nChs
        y(:,ch,:) = wt_lfn(fb,gpuArray(x(:,ch)),a);
    end
    disp("[ec_wt] Ran CWT on GPU: time="+toc(a.tic));
else
    % Run on CPU prfor (idealy threadpool)
    parfor ch = 1:nChs
        y(:,ch,:) = wt_lfn(fb,x(:,ch),a);
    end
    disp("[ec_wt] Ran CWT on CPU parfor: time="+toc(a.tic));
end






function xc = wt_lfn(fb,xc,a)
%% Run wavelet transform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if a.avg 
    % Scale-averaged wavelet transform
    xc = fb.scaleSpectrum(xc)'; % outputs power vector

    % Convert to decibel
    if a.db
        xc = pow2db(xc);
    end
else
    % Continuous wavelet transform
    xc = fb.wt(xc)'; % outputs full-spectrum complex array

    % Convert to real numbers
    if a.real
        % Convert to magnitude (amplitude)
        xc = abs(xc); 

        % Log or exponential transform
        if a.db
            % Convert to decibel (log-transform)
            xc = mag2db(xc);
        elseif a.pwr
            % Convert to power (magnitude squared)
            xc = xc.^2;
        end
    end
end


%% Downsample
if a.ds > 1
    if a.gpuArray
        xc = resample(xc,1,a.ds); % resample
    else
        xc = ec_filtfilt(xc,a.lpfFilt); % apply anti-aliasing filter
        xc = xc(1:a.ds:end,:); % decimate
    end
end






function cwtNfo = waveletNfo_lfn(fb,a)
%%% Wavelet information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Scales (from actual FB)
scales = fb.scales';

% FB for calculations (10 sec SignalLength to save compute)
fb = cwtfilterbank(Wavelet=a.wavelet,SamplingFrequency=a.hz,SignalLength=a.hz*10,...
    VoicesPerOctave=a.voices,FrequencyLimits=a.lims,TimeBandwidth=a.bandwidth);

% Wavelet TimeSupport
cwtNfo = fb.waveletsupport(0.05); % time support
cwtNfo.timeHW = cwtNfo.TimeSupport/2;

% Power bandwidth (3db)
bw = fb.powerbw;

% Concatenate tables
cwtNfo = [cwtNfo,bw];

% Cone of influence: energy-normalized time-domain SD for each wavelet
[psi,t] = fb.wavelets;
psi = abs(psi).^2;
psi = psi ./ sum(psi,2);               % normalize each row to unit total energy
mu_t = sum(psi .* t, 2);               % should be ~0 since wavelets are centered

% Cone of influence half-width
cwtNfo.coiHW = sqrt(sum(psi .* (t - mu_t).^2, 2));

% Organize
cwtNfo.scales = scales; % add scales to table
cwtNfo = renamevars(cwtNfo,["CF" "LowFrequencyBorder" "HighFrequencyBorder"],...
    ["freq" "freqLo" "freqHi"]);
cwtNfo = movevars(cwtNfo,["freq" "freqLo" "freqHi" "timeHW" "coiHW"],Before=1);
cwtNfo = movevars(cwtNfo,"coiHW",After="timeHW");
cwtNfo = removevars(cwtNfo,"Frequencies");
cwtNfo = sortrows(cwtNfo,"freq","ascend"); % sort freqs low to high






%% Depreciated
% Sizes
% nChs = width(x);
% nFrqs = numel(frqs);
%
% % Memory per chan
% memIn = whos("x").bytes * .25;
% if ~o.avg; memIn = memIn*nFrqs; end
% if o.ds; memIn = memIn/o.ds; end
% if o.singleOut; memIn = memIn/2; end
% o.memIn = memIn/nChs;
%
%
% function x = gpu_lfn(fb,x,o)
% %%% Run on GPU arrayfun %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nChs = numel(x);
% if ~isany(o.mem); o.mem=ec_ramAvail(true); end % Get memory
% 
% % Find number of chans that fit in GPU RAM
% memChs = floor(o.mem/o.memIn);
% memItr = ceil(nChs/memChs);
% memChs = ceil(nChs/memItr);
% chFin = false(nChs,1);
% disp("[ec_wt] Start GPU arrayFun: memChs="+memChs+"/"+nChs+" time="+toc(o.tic));
% 
% % Copy to GPU
% vars = ["avg" "real" "pwr" "db" "ds" "lpfFilt" "singleOut"];
% for v = vars
%     o.(v) = gpuArray(o.(v)); end
% 
% 
% %% Loop gpuArrayFun iterations (simultaneous chans that fit in VRAM)
% for v = 1:memItr
%     % Prep
%     idx = find(~chFin,memChs); % Find iteration chans
%     x(idx) = cellfun(@gpuArray,x(idx),UniformOutput=false); % Copy data to GPU
% 
%     % Run CWT
%     x(idx) = cellfun(@(xi) cwt_lfn(fb,xi,o),x(idx),UniformOutput=false);
% 
%     % Move data to CPU
%     x(idx) = cellfun(@gather,x(idx),UniformOutput=false);
%     chFin(idx) = true;
% end
% x = cellfun(@gather,x,UniformOutput=false);
% disp("[ec_wt] Finished GPU arrayfun: time="+toc(o.tic));