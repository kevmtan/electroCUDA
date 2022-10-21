function [x,n] = ec_hiPassDetrend(x,fHi,dOrder,dWin,n,tt,arg)
% Input validation
arguments
    x {isfloat}
    fHi {isnumeric,isobject} = 0
    dOrder {isnumeric} = []
    dWin {isnumeric} = []
    n struct = struct;
    tt uint64 = tic; % Output from 'tic'
    arg.fs {isnumeric} = []
    arg.runIdx {isnumeric} = []
    arg.runs string = ""
    arg.missing string = ""
    arg.gpu logical = true
    arg.itr {isnumeric} = [10 3]
    arg.thr {isnumeric} = [8 4]
    arg.sfx {isstring,ischar} = "";
end
if isempty(fHi); fHi=0; end
if isempty(dOrder); dOrder=0; end
if ~isempty(arg.fs); fs=arg.fs; else; fs=n.fs; end
if ~isempty(arg.runIdx); runIdx=arg.runIdx; else; runIdx=n.runIdxOg(:,2); end
if arg.runs~=""; runs=arg.runs; else; runs=string(n.blocks); end
doGPU = arg.gpu;
doMissing = arg.missing;
nRuns = numel(runs);
dWin = dWin * fs;
d3 = numel(size(x))==3;
nChs = size(x,2);
detrendWts = cell(nRuns,1);
dThr = arg.thr;
dItr = arg.itr;
nWorkers = gcp('nocreate').NumWorkers;

%% Prepare vars 

% Slice EEG data by run
x = mat2cell(x,runIdx);

% Design high-pass filter to shortest run
doHPF = true;
if class(fHi)~="digitalFilter" && fHi>0
    [~,r] = min(runIdx);
    [~,fHi] = highpass(x{r}(:,1,1),fHi,fs);
elseif class(fHi)~="digitalFilter"
    doHPF = false;
end

%% Main

% Interpolate missing frames (filter can't handle NaNs)
if ~isempty(doMissing) && doMissing~=""
    parfor r = 1:nRuns
        xr = x{r};
        xr = fillmissing(xr,doMissing,1);
        disp("Interpolated missing: "+runs(r)); toc(tt);
        x{r} = xr;
    end
end


for r = 1:nRuns
    xr = x{r};
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
    if numel(dOrder)>0 && dOrder(1)>0
        for ii = nWorkers:-3:1
            idx = diff(1: floor(height(xr)/ii) : height(xr)); % Slice into time chunks
            idx(end) = idx(end) + (height(xr)-sum(idx));            % numChunks = number of CPU thread
            xr = mat2cell(xr,idx);
            dWts = cell(numel(xr),1);

            % Lower-order detrend
            parfor w = 1:ii
                [xr{w},dWts{w}] = KT_detrend(xr{w},dOrder(1),[],'polynomials',...
                    dThr(1),dItr(1),dWin); %#ok<PFBNS>
            end
            xr=vertcat(xr{:}); detrendWts{r}=vertcat(dWts{:});
            olPct = nnz(~detrendWts{r})/numel(detrendWts{r});
            disp("Robust polynomial detrended^"+dOrder(1)+" ol="+olPct+" "+runs(r)); toc(tt);
        end
    end
    x{r} = xr;
end

%% Final detrend w/ higher-order polynomial (entire run)
if numel(dOrder)>1 && dOrder(2)>0
    parfor r = 1:nRuns
        xr = x{r};
        wtsR = detrendWts{r};
        %if doGPU; xr=gpuArray(xr); wtsR=gpuArray(wtsR); end
        for ii = 2:numel(dOrder)
            if dOrder(ii)>0
                [xr,wtsR] = KT_detrend(xr,dOrder(ii),wtsR,'polynomials',...
                    dThr(ii),dItr(ii),dWin); %#ok<PFBNS>
                olPct = nnz(~wtsR)/numel(wtsR);
                disp("Robust polynomial detrended^"+dOrder(ii)+" ol="+olPct+" "+runs(r)); toc(tt);
            end
        end
        x{r} = xr;
        detrendWts{r} = wtsR;
        %x{r} = gather(xr); detrendWts{r} = gather(wtsR);
    end
end
x = vertcat(x{:});
detrendWts = logical(vertcat(detrendWts{:}));
detrendWts = sparse(~detrendWts);
if any(dOrder>0); n.("detrendW"+arg.sfx) = detrendWts; end
end