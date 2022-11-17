function [wt,freqs,coi] = ec_CWTsingle(x,fs,freqLims,doAvg,freqsPerOctave)
% Input validation
if ~fs || fs<1; fs=1000; end
if freqLims(1)<=0; freqLims(1)=1; end
if freqLims(2)>fs/2; freqLims(2)=fs/2; end

% Initialize
coder.gpu.kernelfun; % Add kernelfun pragma to trigger kernel creation
[wt,freqs,coi] = cwt(x,'morse',fs,VoicesPerOctave=freqsPerOctave,FrequencyLimits=freqLims);
wt = abs(wt)';
if doAvg
    wt = mean(wt,2);
end

% % Get number of freqs
% nFrames = size(x,1);
% freqs = cwtfilterbank(SignalLength=nFrames,SamplingFrequency=fs,...
%     VoicesPerOctave=freqsPerOctave,FrequencyLimits=freqLims);
% freqs = freqs.centerFrequencies';
% 
% % Initialize
% coder.gpu.kernelfun; % Add kernelfun pragma to trigger kernel creation
% nChs = size(x,2);
% nFreqs = numel(freqs);
% if ~doAvg
%     wt = coder.nullcopy(zeros(nFrames,nChs,nFreqs));
% else
%     wt = coder.nullcopy(zeros(nFrames,nChs));
% end
% 
% % Do CWT
% coder.gpu.kernel();
% if ~doAvg
%     for ch = 1:nChs
%         wt(:,ch,:) = abs(cwt(x(:,ch),'morse',fs,...
%             VoicesPerOctave=freqsPerOctave,FrequencyLimits=freqLims))';
%     end
% else
%     for ch = 1:nChs
%         wt(:,ch) = mean(abs(cwt(x(:,ch),'morse',fs,...
%             VoicesPerOctave=freqsPerOctave,FrequencyLimits=freqLims)),1)';
%     end
% end