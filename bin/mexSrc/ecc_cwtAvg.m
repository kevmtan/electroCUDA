function [xx,freqs] = ecc_cwtAvg(x,fs,fLims,fOctave)
%% CWT scale spectrum - CUDA binary wrapper (double-precision, FP64)
% CWT uses morse wavelets, as they account for unequal variance-covariance across freqs.
% L1-norm is applied to mitigate 1/f decay of neuronal field potentials.
% Log-transform & robust z-scoring converts absolute valued CWT outputs into normal distribution.
%
% Kevin Tan, 2022 (kevmtan.github.io)

%% Input validation
arguments
    x (:,:){mustBeFloat} % Input data
    fs (1,1){mustBeFloat} = 1000 % Sampling rate
    fLims (1,2){mustBeFloat} = [1 300] % Frequency limits
    fOctave (1,1){mustBeFloat} = 10 % Voices per octave
end
if fs<10; fs=10; end
if fLims(1)<1e-3; fLims(1)=1e-3; end
if fLims(2)>fs/2; fLims(2)=fs/2; end
if fLims(1)>fLims(2)*.8; fLims(1)=fLims(2)*.8; end
if fOctave<1; fOctave=1; elseif fOctave>48; fOctave=48; end

%% Initialize
nFrames = height(x);
nChs = width(x);
fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,SamplingFrequency=fs,...
    VoicesPerOctave=fOctave,FrequencyLimits=fLims);
freqs = fb.centerFrequencies';

% Trigger CUDA kernel generation
coder.gpu.kernelfun; 

% Preallocate
ii = 1:nFrames;
xx = coder.nullcopy(zeros(size(x),'like',x)); % Preallocate output


%% CWT average power (L1-norm & variance-norm usng weighted integrals)
for ch = 1:nChs
    xx(ii,ch) = scaleSpectrum(fb,x(ii,ch),SpectrumType="density");
end