function [x,frqs,scales,fb] = ec_wt(x,a)
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
    a.fs (1,1) double = nan           % Sampling rate
    a.lims (1,2) double = nan         % Frequency limits [lower,upper]
    a.voices (1,1) double = 10        % Voices per octave
    a.avg (1,1) logical = false       % Scale-average transform?
    a.out (1,1) string...             % Output coefficient type
        {mustBeMember(a.out,["magnitude" "power" "complex"])} = "magnitude"
    a.wavelet (1,1) string...         % Wavelet type ["morse"|"amor"|"bump"], "amor" is Gabor/Morlet
        {mustBeMember(a.wavelet,["morse" "amor" "bump"])} = "morse"
    a.ds (1,1) double = 0             % Downsampling factor (see https://www.mathworks.com/help/signal/ref/downsample.html)
    a.mem (1,1) double = nan          % Memory to use
    a.single (1,1) logical = false    % Run as single-precision?
    a.singleOut (1,1) logical = false % Output single-precision?
    a.cell (1,1) logical = false      % Output as cell (matrix otherwise)
    a.gpu (1,1) string...             % Run on GPU ["no"=parfor|"matlab"=arrayfun|"cuda"=mex binary]
        {mustBeMember(a.gpu,["no" "matlab" "cuda"])} = "no"
    a.tic (1,1) uint64 = tic          % Timer
end
if ~isany(a.fs); error("[ec_wt] Must specify sampling rate (fs)"); end
if ~isany(a.lims); error("[ec_wt] Must specify frequency limits (lims)"); end
if a.ds<=1||~isany(a.ds); a.ds=0; end % Set no downsampling

%% Prep

% Floating-point precision
if isa(x,"single"); a.single = true; % Input data type is single
elseif a.single; x = single(x); % Convert to single if specified
elseif ~isa(x,"double"); x = double(x); % Convert to double if not
end 
if a.single; a.singleOut=false; end % Remove redundancy

% Make logical arguments
if a.out=="complex"; a.real=false; else; a.real=true; end
if a.out=="power"; a.pwr=true; else; a.pwr=false; end

% Generate wavelet filter
fb = cwtfilterbank(Wavelet=a.wavelet,SamplingFrequency=a.fs,SignalLength=height(x),...
    VoicesPerOctave=a.voices,FrequencyLimits=a.lims);
frqs = fb.centerFrequencies; % CWT frequencies
scales = fb.scales; % CWT scales
if a.ds; scales = scales.*a.ds; end % Downsample scales 

% Sizes
nFrqs = numel(frqs);
nChs = width(x);

% Memory per chan
memIn = whos("x").bytes * .25;
if ~a.avg; memIn = memIn*nFrqs; end
if a.ds; memIn = memIn/a.ds; end
if a.singleOut; memIn = memIn/2; end
a.memIn = memIn/nChs;

% Get wavelet scales

%% Run CWT
if a.gpu=="cuda" && ~a.avg && ismember(a.wavelet,["morse" "amor"])
    % GPU CUDA mex
    if a.single
        x = ec_wt_fp32(x,a.fs,a.lims,a.voices,a.ds,a.real,a.pwr); % Single-precision
    else
        x = ec_wt_fp64(x,a.fs,a.lims,a.voices,a.ds,a.real,a.pwr); % Double-precision
        if o.singleOut
            x = cellfun(@single,x,UniformOutput=false); % Output as single
        end
    end
    freeUnusedMemory(cudaMemoryManager); % Free memory
    disp("[ec_wt] Finished on CUDA binary: time="+toc(a.tic));
else
    % Matlab CPU or GPU
    x = arrayfun(@(ch) x(:,ch), 1:nChs, UniformOutput=false); % Convert to cell

    % Call
    if a.gpu=="no"
        x = cpu_lfn(fb,x,a); % CPU parfor
    else
        x = gpu_lfn(fb,x,a); % GPU arrayfun
    end
end

%% Finalize output
if ~a.cell
    if a.avg
        x = horzcat(x{:});
    else
        x = permute(cat(3,x{:}),[1 3 2]);
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function x = gpu_lfn(fb,x,a)
%% Run on GPU arrayfun
nChs = numel(x);
if ~isany(a.mem); a.mem=ec_ramAvail(true); end % Get memory

% Find number of chans that fit in GPU RAM
memChs = floor(a.mem/a.memIn);
memItr = ceil(nChs/memChs);
memChs = ceil(nChs/memItr);
chFin = false(nChs,1);
disp("[ec_wt] Start GPU arrayFun: memChs="+memChs+"/"+nChs+" time="+toc(a.tic));

% Copy to GPU
fAvg=gpuArray(a.avg); fReal=gpuArray(a.real); fPwr=gpuArray(a.pwr); 
ds=gpuArray(a.ds); sOut=gpuArray(a.singleOut);

% Loop gpuArrayFun iterations (simultaneous chans that fit in VRAM)
for v = 1:memItr
    % Prep
    idx = find(~chFin,memChs); % Find iteration chans
    x(idx) = cellfun(@gpuArray,x(idx),UniformOutput=false); % Copy data to GPU

    % Run CWT
    x(idx) = arrayfun(@(x) cwt_lfn(fb,x{:},fAvg,fReal,fPwr,ds,sOut),...
        x(idx),UniformOutput=false);

    % Move data to CPU
    x(idx) = cellfun(@gather,x(idx),UniformOutput=false);
    chFin(idx) = true;
end
x = cellfun(@gather,x,UniformOutput=false);
disp("[ec_wt] Finished GPU arrayfun: time="+toc(a.tic));




function x = cpu_lfn(fb,x,a)
%% Run on CPU
nChs=numel(x); fAvg=a.avg; fReal=a.real; fPwr=a.pwr; ds=a.ds; sOut=a.singleOut;

% Parallel loop across chans
parfor ch = 1:nChs
    x{ch} = cwt_lfn(fb,x{ch},fAvg,fReal,fPwr,ds,sOut);
end
disp("[ec_wt] Finished CPU parfor: time="+toc(a.tic));





function xc = cwt_lfn(fb,xc,fAvg,fReal,fPwr,ds,sOut)
%% Continuous wavelet transform
if fAvg
    % Scale-averaged output
    if fPwr
        xc = fb.scaleSpectrum(xc)'; % Power
    else
        xc = fb.scaleSpectrum(xc,SpectrumType="density")'; % Magnitude
    end
else
    % Continuous output
    xc = fb.wt(xc)'; % complex
    if fReal
        xc = abs(xc); % Magnitude
        if fPwr
            xc = xc.^2; % Power
        end
    end
end

% Downsample
if ds
    xc = resample(xc,1,ds);
end

% Convert to single
if sOut
    xc = single(xc);
end