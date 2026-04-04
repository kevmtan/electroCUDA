function [x,frqs,spsi,scales,fb] = ec_wt(x,o)
%% electroCUDA - continuous wavelet transform (CWT)
% Process function for CWT called by high-level functions
% Parallel on CPU, Matlab-GPU (fast), or CUDA-GPU (fastest, must compile! see ecu_compile.m)
%
% INPUTS: see 'input validation' below
% OUTPUTS: [coefficients, frequencies, filterbank] 
%
%   AUTHOR: Kevin Tan (2024)
%   LICENSE: GNU GPL v3
%   INFO: github.com/kevmtan/electroCUDA/wiki

%% Input validation
arguments
    x (:,:){mustBeFloat}              % Input data: x(frames,channels)
    o.hz (1,1) double = nan           % Sampling rate
    o.lims (1,2) double = nan         % Frequency limits [lower,upper]
    o.voices (1,1) double = 10        % Voices per octave
    o.bandwidth (1,1) double = 60     % Time Bandwidth
    o.avg (1,1) logical = false       % Scale-average transform?
    o.coef (1,1) string...             % Output coefficient type
        {mustBeMember(o.coef,["decibel" "magnitude" "power" "complex"])} = "decibel"
    o.wavelet (1,1) string...         % Wavelet type ["morse"|"amor"|"bump"], "amor" is Gabor/Morlet
        {mustBeMember(o.wavelet,["morse" "amor" "bump"])} = "morse"
    o.ds (1,1) double = 0             % Downsampling factor (see https://www.mathworks.com/help/signal/ref/downsample.html)
    o.mem (1,1) double = nan          % Memory to use
    o.lpfFilt {isfloat,isa(o.lpfFilt,"digitalFilter")} = [] % Anti-aliasing filter (LPF for downsampling)
    o.lpfImpulse {mustBeMember(o.lpfImpulse,["fir" "iir" "auto"])} = "auto" % Anti-aliasing impulse response
    o.lpfSteep (1,1) double = 0.85    % Anti-aliasing filter steepness
    o.single (1,1) logical = false    % Run as single-precision?
    o.singleOut (1,1) logical = false % Output single-precision?
    o.cell (1,1) logical = false      % Output as cell (matrix otherwise)
    o.gpu (1,1) string...             % Run on GPU ["no"=parfor|"matlab"=arrayfun|"cuda"=mex binary]
        {mustBeMember(o.gpu,["no" "matlab" "cuda"])} = "no"
    o.tic (1,1) uint64 = tic          % Timer
end
if ~isany(o.hz); error("[ec_wt] Must specify sampling rate (fs)"); end
if ~isany(o.lims); error("[ec_wt] Must specify frequency limits (lims)"); end
if o.ds<=1||~isany(o.ds); o.ds=0; end % Set no downsampling
if o.avg && o.coef=="magnitude"
    o.coef = "power";
    warning("[ec_wt] Scale-averaged output can't be magnitude, outputing power (or specify decibel)");
end

%% Prep

% Floating-point precision
if o.single
    x = single(x); % Convert to single if specified
else
    x = double(x); % Convert to double if not
end 

% Make logical arguments
doAvg = o.avg;
ds = o.ds;
if o.singleOut && ~o.single; singleOut=true; else; singleOut=false; end
if o.coef=="complex"; doReal=false; else; doReal=true; end
if o.coef=="power"; doPwr=true; else; doPwr=false; end
if o.coef=="decibel"; doDb=true; else; doDb=false; end
if doDb && doAvg; doPwr=true; end

% Generate wavelet
fb = cwtfilterbank(Wavelet=o.wavelet,SamplingFrequency=o.hz,SignalLength=height(x),...
    VoicesPerOctave=o.voices,FrequencyLimits=o.lims,TimeBandwidth=o.bandwidth);

% Extract wavelet properties
frqs = fb.centerFrequencies; % CWT frequencies
spsi = fb.waveletsupport(0.05); % CWT time supports
scales = fb.scales; % CWT scales
if ds; scales = scales.*ds; end % Downsample scales

% Make anti-aliasing LPF filter for downsampling (Nyquist freq)
LPF = o.lpfFilt;
if ds && o.gpu=="no" && isempty(LPF)
    LPF = ec_designFilt(x(:,1,1),o.hz,floor((o.hz/ds)/2),"lowpass",...
        steepness=op.lpfSteep,impulse="fir",coefOut=true);
    disp("[ec_epochBaseline] Created low-pass filter: "+n.sbj+" time="+toc(tt));
end

% Sizes
nChs = width(x);
% nFrqs = numel(frqs);
%
% % Memory per chan
% memIn = whos("x").bytes * .25;
% if ~o.avg; memIn = memIn*nFrqs; end
% if o.ds; memIn = memIn/o.ds; end
% if o.singleOut; memIn = memIn/2; end
% o.memIn = memIn/nChs;


%% Run CWT
if o.gpu=="cuda" && ~o.avg && ismember(o.wavelet,["morse" "amor"])
    % Run CUDA binary
    if o.single
        x = ec_wt_fp32(x,o.hz,o.lims,o.voices,ds,doReal,doDb,doPwr); % Single-precision
    else
        x = ec_wt_fp64(x,o.hz,o.lims,o.voices,ds,doReal,doDb,doPwr); % Double-precision
        if o.singleOut
            x = cellfun(@single,x,UniformOutput=false); % Output as single
        end
    end
    freeUnusedMemory(cudaMemoryManager); % Free memory
    disp("[ec_wt] Ran CWT on CUDA binary: time="+toc(o.tic));
else
    % Convert to cell by channel
    x = ec_dim2cell(x,2); 

    % Run on Matlab
    if o.gpu~="no"
        % Run on GPU: loop across chans
        for ch = 1:nChs
            % Run chan on GPU
            x{ch} = gather(cwt_lfn(fb,gpuArray(x{ch}),...
                doAvg,doReal,doDb,doPwr,ds,LPF,singleOut));
        end
        disp("[ec_wt] Ran CWT on GPU: time="+toc(o.tic));
    else
        % Run on CPU: parallel loop across chans (idealy threadpool)
        parfor ch = 1:nChs
            % Run chan on CPU
            x{ch} = cwt_lfn(fb,x{ch},doAvg,doReal,doDb,doPwr,ds,LPF,singleOut);
        end
        disp("[ec_wt] Ran CWT on CPU parfor: time="+toc(o.tic));
    end
end


%% Finalize output
if ~o.cell
    if o.avg
        x = horzcat(x{:});
    else
        x = permute(cat(3,x{:}),[1 3 2]);
    end
end







function xc = cwt_lfn(fb,xc,doAvg,doReal,doDb,doPwr,ds,LPF,singleOut)
%% Run CWT
if doAvg 
    % Scale-averaged output
    xc = fb.scaleSpectrum(xc)'; % outputs as power vector

    % Convert to decibel
    if doDb
        xc = pow2db(xc);
    end
else
    % Full-spectrum output
    xc = fb.wt(xc)'; % outputs full-spectrum complex array

    % Convert to real numbers
    if doReal
        % Convert to magnitude (amplitude)
        xc = abs(xc); 

        % Convert to decibel/power
        if doDb
            % Convert to decibel
            xc = mag2db(xc);
        elseif doPwr
            % Convert to power
            xc = xc.^2;
        end
    end
end


%% Downsample
if ds
    if isempty(LPF)
        xc = resample(xc,1,ds); % resample
    else
        xc = ec_filtfilt(xc,LPF); % apply anti-aliasing filter
        xc = xc(1:ds:end,:); % decimate
    end
end


%% Convert to single
if singleOut
    xc = single(xc);
end






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