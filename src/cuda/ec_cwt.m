function [y,freqs] = ec_cwt(x,fs,fLims,fOctave,ds)
%% Continuous wavelet transform - CUDA binary wrapper (double-precision, FP64)
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
    ds (1,2){mustBeFloat} = [1 1] % Frequency limits
end
coder.gpu.kernelfun;
nFrames = height(x);
nChs = width(x);
doDownsample = ds(2)>ds(1);

%% Prep CWT
fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
    SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fOctave);
freqs = centerFrequencies(fb);
% nFreqs = uint32(numel(freqs));
% nFrames = uint32(numel(1:ds:nFrames));

% Preallocate
tmp = cell(1,nChs);
y = coder.nullcopy(tmp);
% y = coder.nullcopy(zeros([nFrames nChs nFreqs],like=x)); % Preallocate output

%% Channel loop
for ch = 1:nChs
    % CWT
    xCh = abs(wt(fb,x(:,ch)))'; % CWT

    % Downsample
    if doDownsample
        y{ch} = resample(xCh,ds(1),ds(2)); % Downsample
    else
        y{ch} = xCh;
    end
end
