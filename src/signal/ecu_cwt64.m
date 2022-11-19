function [xx,freqs] = ecu_cwt64(x,fs,fLims,fOctave)
%% Continuous wavelet transform - CUDA binary wrapper (double-precision, FP64)
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
        mustBeLessThan(fLims,fs)} = [1 300] % Frequency limits
    fOctave (1,1){mustBeGreaterThanOrEqual(fOctave,1),...
        mustBeLessThanOrEqual(fOctave,48)} = 10 % Voices per octave
end

%% Initialize
coder.gpu.kernelfun; % Trigger CUDA kernel generation
nFrames = size(x,1);
nChs = size(x,2);
fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,SamplingFrequency=fs,...
    VoicesPerOctave=fOctave,FrequencyLimits=fLims);
freqs = fb.centerFrequencies';
nFreqs = numel(freqs);

%% Do CWT (L1-normed & variance-normed)
xx = coder.nullcopy(zeros([nFrames nChs nFreqs],'like',x)); % Preallocate output
ii = 1:nFrames;
is = 1:nFreqs;

for ch = 1:nChs
    xx(ii,ch,is) = permute(abs(wt(fb,x(ii,ch))).^2, [2 3 1]);
end

