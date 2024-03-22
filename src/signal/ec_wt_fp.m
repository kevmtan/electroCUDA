function [y,freqs] = ec_wt_fp(x,fs,fLims,fVoices,ds,yType)
%% electroCUDA - run Continuous WAvelet Transform
%   Intended to be compiled into a CUDA mex binary
%   Kevin Tan, 2024 (github.com/kevmtan/electroCUDA)
%
% OUTPUTS:
%   y = transformed data
%   freqs = CWT frequencies
arguments
    x (:,:){mustBeFloat}        % Input data
    fs (1,1) double             % Sampling rate
    fLims (1,2) double          % Frequency limits
    fVoices (1,1) double = 10   % Voices per octave
    ds (1,2) double = [0 0]     % Frequency limits
    % Output data type [0=complex|1=magnitude|2=power|3=avgPower|4=avgDensity]
    yType (1,1) uint8 = uint8(0)
end
if isempty(yType) || yType>4
    error('[ec_wt_fp] yType must be integer between 0 and 4');
end

%% Prep
coder.gpu.kernelfun; % Trigger CUDA kernel creation

% Make vars
nFrames = height(x);
nChs = width(x);
y = coder.nullcopy(cell(1,nChs)); % Preallocate output
if ds(1)<=0 || ds(2)<=1 || ~(ds(2)>ds(1))
    ds = [0 0];
end

% Make CWT filter
fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
    SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);
freqs = centerFrequencies(fb);

% Find initial CWT output size per channel
if yType==4 || yType==3
    ycSz = [nFrames 1];
else
    ycSz = [nFrames numel(freqs)];
end


%% Processing loop across channels
for ch = 1:nChs
    y{ch} = wt_lfn(fb,x(:,ch),yType,ds,ycSz);
end




%% Within-channel function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function yc = wt_lfn(fb,xc,yType,ds,ycSz)

% Preallocate channel output
if yType==4 || yType==3
    yc = coder.nullcopy(nan(ycSz,like=xc)); % 1D per chan
elseif yType==0
    yc = coder.nullcopy(complex(nan(ycSz,like=xc))); % 2D complex per chan
else
    yc = coder.nullcopy(nan(ycSz,like=xc)); % 2D per chan
end

% Run WT
if yType==4
    % Scale-averaged density
    yc = scaleSpectrum(fb,xc,SpectrumType="density")';
elseif yType==3
    % Scale-averaged power
    yc = scaleSpectrum(fb,xc)';
elseif yType==2
    % CWT power
    yc = abs(wt(fb,xc)').^2;
elseif yType==1
    % CWT magnitude
    yc = abs(wt(fb,xc)');
elseif yType==0
    % CWT coefficients (complex-valued)
    yc = wt(fb,xc)';
end

% Downsample
if ds(2)
    yc = resample(yc,ds(1),ds(2));
end