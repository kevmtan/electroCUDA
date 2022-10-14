function [x,n] = ec_hiPassDetrend(x,fHi,polyOrder,winLength,n,tt,arg)
% Input validation
arguments
    x {isfloat}
    fHi {isnumeric,isobject} = 0.01
    polyOrder {isnumeric} = 10
    winLength {isnumeric} = []
    n struct = struct;
    tt uint64 = tic; % Output from 'tic'
    arg.fs {isnumeric} = []
    arg.runIdx {isnumeric} = []
    arg.runs string = ""
    arg.missing string = ""
    arg.gpu logical = true
    arg.itr {isnumeric} = 3
    arg.thr {isnumeric} = 3
    arg.sfx {isstring,ischar} = "";
end
if isempty(polyOrder); polyOrder=0; end
if ~isempty(arg.fs); fs=arg.fs; else; fs=n.fs; end
if ~isempty(arg.runIdx); runIdx=arg.runIdx; else; runIdx=n.runIdxOg(:,2); end
if arg.runs~=""; runs=arg.runs; else; runs=string(n.blocks); end
doGPU = arg.gpu;
doMissing = arg.missing;
nRuns = numel(runs);
winLength = winLength * fs;
d3 = numel(size(x))==3;
nChs = size(x,2);
detrendWts = cell(nRuns,1);
detrendThr = arg.thr;
detrendItr = arg.itr;
nWorkers = gcp('nocreate').NumWorkers;

%% Prepare vars 

% Slice EEG data by run
x = mat2cell(x,runIdx);

% Design high-pass filter to shortest run
doHPF = true;
if class(fHi)~="digitalFilter" && fHi>0
    [~,r] = min(runIdx);
    [~,fHi] = highpass(x{r},fHi,fs);
elseif class(fHi)~="digitalFilter"
    doHPF = false;
end

%% High-pass & detrend (within-run to avoid edge artifacts)
for r = 1:nRuns
    xr = x{r};
    % Interpolate missing frames (filter can't handle NaNs)
    if ~isempty(doMissing) && doMissing~=""
        xr = fillmissing(xr,doMissing,1);
        disp("Interpolated missing: "+runs(r)); toc(tt);
    end

    %% High-pass filter w/ zero-phase IIR (entire run)
    if doHPF
        if doGPU && d3
            for ch = 1:nChs
                xr(:,ch,:) = fHi.filtfilt(double(gpuArray(xr(:,ch,:))));
            end
        elseif doGPU && ~d3
            xr = fHi.filtfilt(double(gpuArray(xr)));
        else
            xr = fHi.filtfilt(double(xr));
        end
        disp("Finished hi-pass: "+runs(r)); toc(tt);
    end

    %% Initial detrend w/ lower-order polynomial (timechunks within run)
    if any(polyOrder>0) && polyOrder(1)>0
        idx = diff(1: floor(height(xr)/nWorkers) : height(xr)); % Slice into time chunks
        idx(end) = idx(end) + (height(xr)-sum(idx));            % numChunks = number of CPU thread
        xr = mat2cell(xr,idx);
        dWts = cell(numel(xr),1);

        % Lower-order detrend
        parfor w = 1:nWorkers
            [xr{w},dWts{w}] = KT_detrend(xr{w},polyOrder(1),[],'polynomials',...
                detrendThr(1),detrendItr(1),winLength); %#ok<PFBNS> 
        end
        xr=vertcat(xr{:}); detrendWts{r}=vertcat(dWts{:});
        disp("Robust polynomial detrended^"+polyOrder(1)+": "+runs(r)); toc(tt);
    end
    x{r} = xr;
end

%% Final detrend w/ higher-order polynomial (entire run)
parfor r = 1:nRuns
    if numel(polyOrder)>1 && polyOrder(2)>0
        [x{r},detrendWts{r}] = KT_detrend(x{r},polyOrder(2),detrendWts{r},'polynomials',...
                detrendThr(end),detrendItr(end),winLength); %#ok<PFBNS> 
        disp("Robust polynomial detrended^"+polyOrder(2)+": "+runs(r)); toc(tt);
    end
end
x = vertcat(x{:});
if any(polyOrder>0); n.("detrendW"+arg.sfx) = detrendWts; end
end