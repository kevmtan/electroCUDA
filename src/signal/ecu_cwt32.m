function [xx,freqs] = ecu_cwt32(x,fs,fLims,fOctave)
%% Continuous wavelet transform - CUDA binary wrapper (single-precision, FP32)
% CWT uses morse wavelets, as they account for unequal variance-covariance across freqs.
% L1-norm is applied to mitigate 1/f decay of neuronal field potentials.
% Log-transform & robust z-scoring converts absolute valued CWT outputs into normal distribution.
%
% Kevin Tan, 2022 (kevmtan.github.io)

%% Input validation
arguments
    x single % Input data
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

%%
%fAvg (1,1) logical = false % Get average power across frequencies (weighted integrals)
%absNorm (1,1) logical = true % Absolute value to normal distribution (log-norm to normal)

%xx(:,ch) = scaleSpectrum(fb,x(:,ch),FrequencyLimits=fLims,...
%    SpectrumType="density")'

% Absolute value (log-norm) to normal distribution
%if absNorm
%    xx(:,ch,:) = ec_abs2norm(xx(:,ch,:),scale="robust");
%end

% [wt,freqs,coi] = cwt(x,'morse',fs,VoicesPerOctave=freqsPerOctave,FrequencyLimits=freqLims);
% wt = abs(wt)';
% if doAvg
%     wt = mean(wt,2);
% end

%%
% function xx = cwt_lfn(fb,xx,fMean,doNorm,ds1,ds2,singleIn,singleOut)
% % Do CWT
% if fMean
%     % Normalized average density (weighted integral normed by variance)
%     xx = fb.scaleSpectrum(xx,SpectrumType="density")'; % wt(frames,1)
% else % Real-valued power (magnitude absolute value squared)
%     xx = abs(fb.wt(xx)).^2'; % wt(frames,freqs)
% end
%
% % Downsample
% if ds2>ds1 && ~singleIn
%    xx = resample(xx,ds1,ds2); % doesn't work in parfor loop
% end
%
% % Absolute values (log-norm) to normal distribution
% if doNorm
%     xx = ec_abs2norm(xx,scale="robust");
% end
%
% % Convert to single
% if singleOut && ~singleIn
%     xx = single(xx);
% end