function y = ec_wt_fp(x,fs,lims,voices,ds,doReal,doPwr,wvlt)
%% [electroCUDA] CWT - CUDA mex source
%   Called by function 'ec_wt' (see for details) 
%   Intended to be compiled into a CUDA mex binary
%   Kevin Tan, 2024 (github.com/kevmtan/electroCUDA)
arguments
    x (:,:){mustBeFloat}        % Input data
    fs (1,1) double             % Sampling rate
    lims (1,2) double          % Frequency limits
    voices (1,1) double = 10   % Voices per octave
    ds (1,1) double = 0         % Downsampling factor
    doReal (1,1) logical = true % Real output? (complex otherwise)
    doPwr (1,1) logical = false % Power output? (magnitude otherwise)
    wvlt char {mustBeMember(wvlt,{'morse','amor'})} = 'morse'
end
if ds<=1; ds=0; end

%% Prep
coder.gpu.kernelfun; % Trigger CUDA kernel creation

% Sizes
nChs = width(x);

% Preallocate output
y = coder.nullcopy(cell(1,nChs));


%% Processing loop across channels
for ch = 1:nChs
    if doReal
        y{ch} = cwtR_lfn(x(:,ch),fs,lims,voices,wvlt,ds,doPwr);
    else
        y{ch} = cwt_lfn(x(:,ch),fs,lims,voices,wvlt,ds);
    end
end




%% Run CWT (complex) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function yc = cwt_lfn(xc,fs,lims,voices,wvlt,ds)

% CWT
yc = cwt(xc,wvlt,fs,FrequencyLimits=lims,VoicesPerOctave=voices)';

% Downsample
if ds
    yc = resample(yc,1,ds);
end


%% Run CWT (magnitude/power) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function yc = cwtR_lfn(xc,fs,lims,voices,wvlt,ds,doPwr)

% CWT - magnitude out
yc = abs(cwt(xc,wvlt,fs,FrequencyLimits=lims,VoicesPerOctave=voices)');

% Convert to power
if doPwr
    yc = yc.^2;
end

% Downsample
if ds
    yc = resample(yc,1,ds);
end