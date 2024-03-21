function [xx,yy] = ec_wtcc(x,c,fs,fLims,fVoices,ds)
%% Wavelet coherence & resample
arguments
    x (:,:){mustBeFloat}
    c (:,2){uint16}
    fs (1,1){mustBeFloat}
    fLims (1,2){mustBeFloat}
    fVoices (1,1){mustBeFloat} = 12
    ds (1,2){mustBeFloat} = [1,1]
end

% Trigger kernel creation
coder.gpu.kernelfun;

% Make vars
nPairs = height(c); 
tmp = cell(1,nPairs); 
xx = coder.nullcopy(tmp); % Fix define array error
yy = coder.nullcopy(tmp);

% Loop across pairs
for p = 1:nPairs
    [xx{p},yy{p}] = wtc_lfn(x(:,c(p,1)),x(:,c(p,2)),fs,fLims,fVoices,ds);
end




%% Wavelet coherence - local function
function [x,y] = wtc_lfn(x,y,fs,fLims,fVoices,ds)

% Calculate wavelet coherence
[x,y] = wcoherence(x,y,fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);

% Downsample
x = resample(x,ds(1),ds(2),Dimension=2);
y = resample(y,ds(1),ds(2),Dimension=2);

% Convert wavelet to phase angle
y = angle(y);