function [wt,freqs,coi] = ec_CWTdouble(x,fs,freqLims,doAvg,freqsPerOctave)
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

