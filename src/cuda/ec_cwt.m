function [xx,freqs] = ec_cwt(x,fs,fLims,fOctave,ds2)
%% Continuous wavelet transform - CUDA binary wrapper (double-precision, FP64)
% CWT uses morse wavelets, as they account for unequal variance-covariance across freqs.
% L1-norm is applied to mitigate 1/f decay of neuronal field potentials.
% Log-transform & robust z-scoring converts absolute valued CWT outputs into normal distribution.
%
% Kevin Tan, 2022 (kevmtan.github.io)

%% Input validation
% arguments
%     x (:,:){mustBeFloat} % Input data
%     fs (1,1) double = 1000 % Sampling rate
%     fLims (1,2) double = [1 300] % Frequency limits
%     fOctave (1,1) double = 10 % Voices per octave
% end
coder.gpu.kernelfun;
if fs<10; fs=10; end
if fLims(1)<1e-3; fLims(1)=1e-3; end
if fLims(2)>fs/2; fLims(2)=fs/2; end
if fOctave<1; fOctave=1; elseif fOctave>48; fOctave=48; end
ds2 = floor(ds2);
fOctave = round(fOctave);
nFrames = height(x);
nChs = uint32(width(x));

%% Prep CWT
%coder.extrinsic("cwtfilterbank","centerFrequencies");
fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
    SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fOctave);
freqs = centerFrequencies(fb);
nFreqs = uint32(numel(freqs));
nFrames = uint32(numel(1:ds2:nFrames));

% Preallocate
xx = coder.nullcopy(zeros([nFrames nChs nFreqs],like=x)); % Preallocate output
% xx = cell(1,nChs);

%% CWT per channel
coder.gpu.kernel(nChs,-1)
for ch = 1:nChs
    coder.gpu.constantMemory(xx);  
     xCh = abs(wt(fb,x(:,ch)))'; % CWT
     if ds2>1
         xCh = xCh(1:ds2:end,:); % Downsample
     end 
     xx(:,ch,:) = xCh; % Copy to output matrix
end
