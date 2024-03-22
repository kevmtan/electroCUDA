function [y,freqs] = ec_cwtAvg(x,fs,fLims,fVoices,ds)
%% CWT scale spectrum - CUDA binary wrapper (double-precision, FP64)
% CWT uses morse wavelets, as they account for unequal variance-covariance across freqs.
% L1-norm is applied to mitigate 1/f decay of neuronal field potentials.
% Log-transform & robust z-scoring converts absolute valued CWT outputs into normal distribution.
%
% Kevin Tan, 2022 (kevmtan.github.io)

%% Input validation
arguments
    x (:,:){mustBeFloat} % Input data
    fs (1,1) double = 1000 % Sampling rate
    fLims (1,2) double = [1 300] % Frequency limits
    fVoices (1,1) double = 10 % Voices per octave
    ds (1,2) double = [1 1] % Frequency limits
end
coder.gpu.kernelfun;
fVoices = round(fVoices);
nFrames = height(x);
nChs = width(x);
doDownsample = ds(2)>ds(1);

%% Prep CWT
fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
    SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);
freqs = centerFrequencies(fb);

% Preallocate
tmp = cell(1,nChs);
y = coder.nullcopy(tmp);
% y = coder.nullcopy(x); % Preallocate output

%% CWT average power (L1-norm & variance-norm usng weighted integrals)
for ch = 1:nChs
    xCh = scaleSpectrum(fb,x(:,ch),SpectrumType="density")';

    % Downsample
    if doDownsample
        y{ch} = resample(xCh,ds(1),ds(2)); % Downsample
    else
        y{ch} = xCh;
    end
end
