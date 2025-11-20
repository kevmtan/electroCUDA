function [y,freqs] = ec_wtAvg_fp(x,fs,fLims,fVoices,ds,doPwr)
%% electroCUDA - Scale-avergaged Wavelet Transform
%   Intended to be compiled into a CUDA mex binary
%   Kevin Tan, 2024 (github.com/kevmtan/electroCUDA)
%
% OUTPUTS:
%   y = transformed data
%   freqs = CWT frequencies
arguments
    x (:,:){mustBeFloat}        % Input data
    fs (1,1) double             % Sampling rate
    fLims (1,2) double          % Frequency limits
    fVoices (1,1) double = 10   % Voices per octave
    ds (1,1) double = 0         % Downsampling factor
    doPwr (1,1) logical = false % Output [0=magnitude|1=output]
end
if ds<=1; ds=0; end

%% Prep
coder.gpu.kernelfun; % Trigger CUDA kernel creation

% Sizes
nFrames = height(x);
nChs = width(x);

% Make CWT filter
fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
    SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);
freqs = centerFrequencies(fb);

% Find output frames
if ds
    nFrames = floor(nFrames/ds);
end

% Preallocate output
y = coder.nullcopy(nan(nFrames,nChs,like=x));


%% Processing loop across channels
coder.gpu.kernel; % parallel loop kernels
for ch = 1:nChs
    y(:,ch) = awt_lfn(fb,x(:,ch),ds,doPwr);
end




%% Run transform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function yc = awt_lfn(fb,xc,ds,doPwr)

% Run transform
if doPwr
    yc = scaleSpectrum(fb,xc)'; % Power
else
    yc = scaleSpectrum(fb,xc,SpectrumType="density")'; % Magnitude
end

% Downsample
if ds
    yc = downsample(yc,ds);
end