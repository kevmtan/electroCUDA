function [x,frqs,spsi,scales,fb] = ec_wt(x,o)
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
    o.hz (1,1) double = nan                 % Sampling rate
    o.lims (1,2) double = nan               % Frequency limits [lower,upper]
    o.voices (1,1) double = 10              % Voices per octave
    o.bandwidth (1,1) double = 60           % Time Bandwidth
    o.avg (1,1) logical = false             % Scale-average transform?
    o.coef (1,1) string...                  % Output coefficient type
        {mustBeMember(o.coef,["decibel" "magnitude" "power" "complex"])} = "decibel"
    o.wavelet (1,1) string...               % Wavelet type ["morse"|"amor"|"bump"], "amor" is Gabor/Morlet
        {mustBeMember(o.wavelet,["morse" "amor" "bump"])} = "morse"
    o.ds (1,1) double {mustBeInteger} = 0   % Downsampling factor (see https://www.mathworks.com/help/signal/ref/downsample.html)
    o.mem (1,1) double = nan                % Memory to use
    o.lpfFilt {isfloat,isa(o.lpfFilt,"digitalFilter")} = [] % Anti-aliasing filter (LPF for downsampling)
    o.lpfImpulse {mustBeMember(o.lpfImpulse,["fir" "iir" "auto"])} = "auto" % Anti-aliasing impulse response
    o.lpfSteep (1,1) double = 0.85          % Anti-aliasing filter steepness
    o.single (1,1) logical = false          % Run as single-precision?
    o.singleOut (1,1) logical = false       % Output single-precision?
    o.cell (1,1) logical = false            % Output as cell instead of matrix
    o.gpu (1,1) string...                   % Run on GPU ["no"=parfor|"matlab"=arrayfun|"cuda"=mex binary]
        {mustBeMember(o.gpu,["no" "matlab" "cuda"])} = "no"
    o.tic (1,1) uint64 = tic                % Timer
end
if ~isany(o.hz); error("Must specify sampling rate (hz)"); end
if ~isany(o.lims); error("Must specify frequency limits (lims)"); end
if ~(o.ds>1); o.ds=1; end % Set no downsampling
if o.avg && o.coef=="magnitude"
    o.coef = "decibel";
    warning("Scale-averaged output can't be magnitude, outputing decibel (or specify power)");
end
if o.ds>1 && ismember(o.coef,["magnitude" "power"])
    warning("Downsampling magnitude or power outputs results in negative numbers, decibel or complex output is recommended");
end


%% Prep

% Make logical arguments
if o.singleOut; o.outClass="single"; else; o.outClass="double"; end
if o.coef=="complex"; o.real=false; else; o.real=true; end
if o.coef=="power"; o.pwr=true; else; o.pwr=false; end
if o.coef=="decibel"; o.db=true; else; o.db=false; end
if o.db && o.avg; o.pwr=true; end

% Convert EEG to specified precision
if o.single
    x = single(x); % Convert to single if specified
else
    x = double(x); % Convert to double if not
end 

% Make anti-aliasing LPF filter for downsampling (Nyquist freq)
if o.ds>1 && o.gpu=="no" && isempty(o.lpfFilt)
    o.lpfFilt = ec_designFilt(x(:,1,1),o.hz,floor(o.hz/o.ds)/2,"lowpass",...
        steepness=op.lpfSteep,impulse="fir",coefOut=true);
    disp("[ec_epochBaseline] Created low-pass filter: "+n.sbj+" time="+toc(o.tic));
end

% Generate wavelet
fb = cwtfilterbank(Wavelet=o.wavelet,SamplingFrequency=o.hz,SignalLength=height(x),...
    VoicesPerOctave=o.voices,FrequencyLimits=o.lims,TimeBandwidth=o.bandwidth);

% Extract wavelet properties
frqs = fb.centerFrequencies; % CWT frequencies
nFrqs = numel(frqs);
scales = fb.scales; % CWT scales

% CWT time supports
spsi = timeSupports_lfn(fb);


%% Run wavelet transform
if o.gpu=="cuda" && ~o.avg && o.wavelet=="morse"
    % Run CUDA binary
    if o.single
        % Single-precision
        x = ec_wt_fp32(x,nFrqs,o.hz,o.lims,o.voices,o.bandwidth,o.real,o.db,...
            o.pwr,o.ds);
    else
        % Double-precision
        x = ec_wt_fp64(x,nFrqs,o.hz,o.lims,o.voices,o.bandwidth,o.real,o.db,...
            o.pwr,o.ds);
        % Output as single
        if o.singleOut
            x = single(x);
        end
    end
    disp("[ec_wt] Ran CWT on CUDA binary: time="+toc(o.tic));
else
    % Run 
    x = runOnMatlab_lfn(fb,x,o);
end






function y = runOnMatlab_lfn(fb,x,o)
%%% Wavelet transform on Matlab %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make local variables
doAvg=o.avg; doReal=o.real; doDb=o.db; doPwr=o.pwr; ds=o.ds; LPF=o.lpfFilt;
nChs = width(x);

% Preallocate output
if doAvg
    y = nan(ceil(height(x)/ds),nChs,o.outClass);
else
    y = nan(ceil(height(x)/ds),nChs,numel(fb.centerFrequencies),o.outClass);
end


%% Wavelet transform across chans
if o.gpu~="no"
    % Run on GPU
    for ch = 1:nChs
        y(:,ch,:) = wt_lfn(fb,gpuArray(x(:,ch)),doAvg,doReal,doDb,doPwr,ds,[]);
    end
    disp("[ec_wt] Ran CWT on GPU: time="+toc(o.tic));
else
    % Run on CPU prfor (idealy threadpool)
    parfor ch = 1:nChs
        y(:,ch,:) = wt_lfn(fb,x(:,ch),doAvg,doReal,doDb,doPwr,ds,LPF);
    end
    disp("[ec_wt] Ran CWT on CPU parfor: time="+toc(o.tic));
end






function xc = wt_lfn(fb,xc,doAvg,doReal,doDb,doPwr,ds,LPF)
%% Run wavelet transform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if doAvg 
    % Scale-averaged wavelet transform
    xc = fb.scaleSpectrum(xc)'; % outputs power vector

    % Convert to decibel
    if doDb
        xc = pow2db(xc);
    end
else
    % Continuous wavelet transform
    xc = fb.wt(xc)'; % outputs full-spectrum complex array

    % Convert to real numbers
    if doReal
        % Convert to magnitude (amplitude)
        xc = abs(xc); 

        % Log or exponential transform
        if doDb
            % Convert to decibel (log-transform)
            xc = mag2db(xc);
        elseif doPwr
            % Convert to power (magnitude squared)
            xc = xc.^2;
        end
    end
end


%% Downsample
if ds > 1
    if isempty(LPF)
        xc = resample(xc,1,ds); % resample
    else
        xc = ec_filtfilt(xc,LPF); % apply anti-aliasing filter
        xc = xc(1:ds:end,:); % decimate
    end
end






function spsi = timeSupports_lfn(fb)
%%% Wavelet time supports %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Time supports per freq
spsi = fb.waveletsupport(0.05); 

% Energy-normalized time-domain SD for each wavelet
[psi,t] = fb.wavelets;
psi = abs(psi).^2;
psi = psi ./ sum(psi,2);               % normalize each row to unit total energy
mu_t = sum(psi .* t, 2);               % should be ~0 since wavelets are centered

% Cone of influence half-width
spsi.coiHW = sqrt(sum(psi .* (t - mu_t).^2, 2));

% Wavelet scales
spsi.scale = fb.scales'; % scales






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