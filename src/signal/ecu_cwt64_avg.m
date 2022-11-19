function [xx,freqs] = ecu_cwt64_avg(x,fs,fLims,fOctave)
%% CWT scale spectrum - CUDA binary wrapper (double-precision, FP64)
% CWT uses morse wavelets, as they account for unequal variance-covariance across freqs.
% L1-norm is applied to mitigate 1/f decay of neuronal field potentials.
% Log-transform & robust z-scoring converts absolute valued CWT outputs into normal distribution.
%
% Kevin Tan, 2022 (kevmtan.github.io)

%% Input validation
arguments
    x double % Input data
    fs (1,1){mustBeGreaterThan(fs,1)} = 1000 % Sampling rate
    fLims (1,2){mustBeGreaterThanOrEqual(fLims,1),...
        mustBeLessThan(fLims,fs)} = [60 180] % Frequency limits
    fOctave (1,1){mustBeGreaterThanOrEqual(fOctave,1),...
        mustBeLessThanOrEqual(fOctave,48)} = 32 % Voices per octave
end

%% Initialize
coder.gpu.kernelfun; % Trigger CUDA kernel generation
nFrames = size(x,1);
nChs = size(x,2);
fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,SamplingFrequency=fs,...
    VoicesPerOctave=fOctave,FrequencyLimits=fLims);
freqs = fb.centerFrequencies';

%% CWT average power (L1-norm & variance-norm usng weighted integrals)
xx = coder.nullcopy(zeros(size(x),'like',x)); % Preallocate output
ii = 1:nFrames;

for ch = 1:nChs
    xx(ii,ch) = scaleSpectrum(fb,x(ii,ch),SpectrumType="density");
end