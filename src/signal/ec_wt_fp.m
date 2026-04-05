function y = ec_wt_fp(x,nFrqs,hz,lims,voices,tbw,doReal,doDb,doPwr,ds)
%% [electroCUDA] CWT - CUDA mex source
%   Called by function 'ec_wt' (see for details) 
%   Intended to be compiled into a CUDA mex binary
%   Kevin Tan, 2024 (github.com/kevmtan/electroCUDA)
arguments
    x (:,:){mustBeFloat}            % Input data: x(frames,channels)
    nFrqs (1,1) double              % Number of frequencies
    hz (1,1) double                 % Sampling rate
    lims (1,2) double               % Frequency limits [lower,upper]
    voices (1,1) double = 10        % Voices per octave
    tbw (1,1) double = 60           % Time Bandwidth
    doReal (1,1) logical = true     % Output as real numberes 
    doDb (1,1) logical = true       % Output as decibel
    doPwr (1,1) logical = false     % Output as power
    ds (1,1) double = 1             % Downsampling factor (see https://www.mathworks.com/help/signal/ref/downsample.html)
end
if ~(ds>1); ds=1; end

%% Prep
coder.gpu.kernelfun; % Trigger CUDA kernel creation

% Sizes
nChs = width(x);

% Preallocate output
y = coder.nullcopy(nan(ceil(height(x)/ds),nChs,nFrqs,class(x)));
% if doReal
%     y = coder.nullcopy(nan(ceil(height(x)/ds),nChs,nFrqs,class(x)));
% else
%     y = coder.nullcopy(complex(nan(ceil(height(x)/ds),nChs,nFrqs,class(x))));
% end


%% Processing loop across channels
for ch = 1:nChs
    y(:,ch,:) = cwt_lfn(x(:,ch),hz,lims,voices,tbw,doReal,doDb,doPwr,ds);
end







function yc = cwt_lfn(xc,fs,lims,voices,tbw,doReal,doDb,doPwr,ds)
%% Run CWT
yc = abs(cwt(xc,'morse',fs,FrequencyLimits=lims,VoicesPerOctave=voices,...
    TimeBandwidth=tbw))';
% yc = cwt(xc,'morse',fs,FrequencyLimits=lims,VoicesPerOctave=voices,...
%     TimeBandwidth=tbw)'; % outputs full-spectrum complex array


%% Convert to real numbers
%if doReal
% Convert to magnitude (amplitude)
%yc = abs(yc);

% Convert to decibel/power
if doDb
    % Convert to decibel
    yc = mag2db(yc);
elseif doPwr
    % Convert to power
    yc = yc.^2;
end
%end


%% Downsample
if ds
    yc = resample(yc,1,ds);
end