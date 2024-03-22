function [xx,yy] = ec_wtcc(x,c,fs,fLims,fVoices,ds)
%% Wavelet coherence & resample
arguments
    x (:,:){mustBeFloat}
    c (:,2) uint16
    fs (1,1) double
    fLims (1,2) double
    fVoices (1,1) double = 12
    ds (1,2) double = [1 1]
end

% Trigger kernel creation
coder.gpu.kernelfun;

% Make vars
nPairs = height(c); 
tmp = cell(1,nPairs); 
xx = coder.nullcopy(tmp); % Fix define array error
yy = coder.nullcopy(tmp);

if ds(1)==0 || ds(2)==0 || ~(ds(2)>ds(1))
    ds(1) = 0;
    ds(2) = 0;
end

% Loop across pairs
for p = 1:nPairs
    [xx{p},yy{p}] = wtc_lfn(x(:,c(p,1)),x(:,c(p,2)),fs,fLims,fVoices,ds);
end




%% Wavelet coherence - local function
function [xp,yp] = wtc_lfn(x1,x2,fs,fLims,fVoices,ds)

% Calculate wavelet coherence
[xp,yp] = wcoherence(x1,x2,fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);
xp=xp'; yp=yp'; % make column-major

% Downsample
if ds(2)
    xp = resample(xp,ds(1),ds(2));
    yp = resample(yp,ds(1),ds(2));
end

% Convert wavelet to phase angle
yp = angle(yp);