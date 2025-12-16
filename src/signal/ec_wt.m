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
    a.hz (1,1) double = nan           % Sampling rate
    a.lims (1,2) double = nan         % Frequency limits [lower,upper]
    a.voices (1,1) double = 10        % Voices per octave
    a.avg (1,1) logical = false       % Scale-average transform?
    a.out (1,1) string...             % Output coefficient type
        {mustBeMember(a.out,["decibel" "magnitude" "power" "complex"])} = "decibel"
    a.wavelet (1,1) string...         % Wavelet type ["morse"|"amor"|"bump"], "amor" is Gabor/Morlet
        {mustBeMember(a.wavelet,["morse" "amor" "bump"])} = "morse"
    a.ds (1,1) double = 0             % Downsampling factor (see https://www.mathworks.com/help/signal/ref/downsample.html)
    a.mem (1,1) double = nan          % Memory to use
    a.lpfFilt {isfloat,isa(a.lpfFilt,"digitalFilter")} = [] % Anti-aliasing filter (LPF for downsampling)
    a.lpfImpulse {mustBeMember(a.lpfImpulse,["fir" "iir" "auto"])} = "auto" % Anti-aliasing impulse response
    a.lpfSteep (1,1) double = 0.85    % Anti-aliasing filter steepness
    a.single (1,1) logical = false    % Run as single-precision?
    a.singleOut (1,1) logical = false % Output single-precision?
    a.cell (1,1) logical = false      % Output as cell (matrix otherwise)
    a.gpu (1,1) string...             % Run on GPU ["no"=parfor|"matlab"=arrayfun|"cuda"=mex binary]
        {mustBeMember(a.gpu,["no" "matlab" "cuda"])} = "no"
    a.tic (1,1) uint64 = tic          % Timer
end
if ~isany(a.hz); error("[ec_wt] Must specify sampling rate (fs)"); end
if ~isany(a.lims); error("[ec_wt] Must specify frequency limits (lims)"); end
if a.ds<=1||~isany(a.ds); a.ds=0; end % Set no downsampling

%% Prep

% Floating-point precision
if isa(x,"single"); a.single = true; % Input data type is single
elseif a.single; x = single(x); % Convert to single if specified
elseif ~isa(x,"double"); x = double(x); % Convert to double if not
end 

% Make logical arguments
if a.out=="complex"; a.real=false; else; a.real=true; end
if a.out=="decibel"; a.db=true; else; a.db=false; end
if a.out=="power"; a.pwr=true; else; a.pwr=false; end

% Generate wavelet
fb = cwtfilterbank(Wavelet=a.wavelet,SamplingFrequency=a.hz,SignalLength=height(x),...
    VoicesPerOctave=a.voices,FrequencyLimits=a.lims);
frqs = fb.centerFrequencies; % CWT frequencies
scales = fb.scales; % CWT scales
if a.ds; scales = scales.*a.ds; end % Downsample scales

% Make anti-aliasing LPF filter for downsampling (Nyquist freq)
if a.ds && a.gpu~="cuda" && isempty(a.lpfFilt)
    a.lpfFilt = ec_designFilt(x,a.hz,floor((a.hz/ds)/2),"lowpass",...
        steepness=op.lpfSteep,impulse="fir",coefOut=true);
    disp("[ec_epochBaseline] Created low-pass filter: "+n.sbj+" time="+toc(tt));
end

% Sizes
nFrqs = numel(frqs);
nChs = width(x);

% Memory per chan
memIn = whos("x").bytes * .25;
if ~a.avg; memIn = memIn*nFrqs; end
if a.ds; memIn = memIn/a.ds; end
if a.singleOut; memIn = memIn/2; end
a.memIn = memIn/nChs;


%% Run CWT
if a.gpu=="cuda" && ~a.avg && ismember(a.wavelet,["morse" "amor"])
    % GPU CUDA mex
    if a.single
        x = ec_wt_fp32(x,a.hz,a.lims,a.voices,a.ds,a.real,a.pwr); % Single-precision
    else
        x = ec_wt_fp64(x,a.hz,a.lims,a.voices,a.ds,a.real,a.pwr); % Double-precision
        if o.singleOut
            x = cellfun(@single,x,UniformOutput=false); % Output as single
        end
    end
    freeUnusedMemory(cudaMemoryManager); % Free memory
    disp("[ec_wt] Finished on CUDA binary: time="+toc(a.tic));
else
    % Matlab CPU or GPU
    x = ec_dim2cell(x,2); % convert to cell

    % Call
    if a.gpu=="matlab"
        x = gpu_lfn(fb,x,a); % GPU arrayfun
    else
        x = cpu_lfn(fb,x,a); % CPU parfor
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




% Run on GPU arrayfun %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function x = gpu_lfn(fb,x,a)
nChs = numel(x);
if ~isany(a.mem); a.mem=ec_ramAvail(true); end % Get memory

% Find number of chans that fit in GPU RAM
memChs = floor(a.mem/a.memIn);
memItr = ceil(nChs/memChs);
memChs = ceil(nChs/memItr);
chFin = false(nChs,1);
disp("[ec_wt] Start GPU arrayFun: memChs="+memChs+"/"+nChs+" time="+toc(a.tic));

% Copy to GPU
fAvg=gpuArray(a.avg); fReal=gpuArray(a.real); fPwr=gpuArray(a.pwr); fDb=gpuArray(a.db);
ds=gpuArray(a.ds); lpf=gpuArray(a.lpfFilt); sOut=gpuArray(a.singleOut);

%% Loop gpuArrayFun iterations (simultaneous chans that fit in VRAM)
for v = 1:memItr
    % Prep
    idx = find(~chFin,memChs); % Find iteration chans
    x(idx) = cellfun(@gpuArray,x(idx),UniformOutput=false); % Copy data to GPU

    % Run CWT
    x(idx) = cellfun(@(xi) cwt_lfn(fb,xi,fAvg,fReal,fDb,fPwr,ds,lpf,sOut),...
        x(idx),UniformOutput=false);

    % Move data to CPU
    x(idx) = cellfun(@gather,x(idx),UniformOutput=false);
    chFin(idx) = true;
end
x = cellfun(@gather,x,UniformOutput=false);
disp("[ec_wt] Finished GPU arrayfun: time="+toc(a.tic));




% Run on CPU %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function x = cpu_lfn(fb,x,a)
% Extract struct fields
fAvg=a.avg; fReal=a.real; fPwr=a.pwr; fDb=a.db; ds=a.ds; lpf=a.lpfFilt; sOut=a.singleOut;
nChs = numel(x); % Num chans

% Parallel loop across chans
parfor ch = 1:nChs
    %% Run CWT for chan
    x{ch} = cwt_lfn(fb,x{ch},fAvg,fReal,fDb,fPwr,ds,lpf,sOut);
end
disp("[ec_wt] Finished CPU parfor: time="+toc(a.tic));




% Continuous wavelet transform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xc = cwt_lfn(fb,xc,fAvg,fReal,fDb,fPwr,ds,lpf,sOut)
if fAvg % Scale-averaged output
    if fPwr
        xc = fb.scaleSpectrum(xc)'; % Power
    else
        xc = fb.scaleSpectrum(xc,SpectrumType="density")'; % Magnitude
    end
else    % Full-spectrum output
    xc = fb.wt(xc)';
end


%% Convert
if ~fAvg && fReal
    xc = abs(xc); % magnitude (amplitude)
    if fPwr
        xc = xc.^2; end % power
end
if fDb
    xc = mag2db(xc);
end

%% Downsample
if ds
    xc = ec_filtfilt(xc,lpf); % apply anti-aliasing filter
    xc = xc(1:ds:end,:); % decimate
end

% Convert to single
if sOut
    xc = single(xc); end