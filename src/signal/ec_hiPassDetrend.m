function [x,n] = ec_hiPassDetrend(x,fHi,dOrder,dWin,n,tt,arg)
% Input validation
arguments
    x {isfloat}
    fHi {isnumeric,isstring,isobject} = 0
    dOrder {isnumeric} = []
    dWin {isnumeric} = []
    n struct = struct;
    tt uint64 = tic; % Output from 'tic'
    arg.fs {isnumeric} = []
    arg.runIdx {isnumeric} = []
    arg.runs string = ""
    arg.missing string = ""
    arg.gpu logical = false
    arg.itr {isnumeric} = [10 3]
    arg.thr {isnumeric} = [8 4]
    arg.sfx {isstring,ischar} = "";
end
if isempty(fHi); fHi=0; end
if isempty(dOrder); dOrder=0; end
if ~isempty(arg.fs); fs=arg.fs; else; fs=n.fs; end
if ~isempty(arg.runIdx); runIdx=arg.runIdx; else; runIdx=n.runIdxOg(:,2); end
if arg.runs~=""; runs=arg.runs; else; runs=string(n.blocks); end
if arg.gpu; try reset(gpuDevice(1)); catch;end;end
dThr = arg.thr;
dItr = arg.itr;
nRuns = numel(runs);
dWin = dWin * fs;
d3 = numel(size(x))==3;
nChs = size(x,2);
detrendWts = cell(nRuns,1);
nWorkers = gcp('nocreate').NumWorkers;

%% Prepare vars
x = double(x);
x = mat2cell(x,runIdx); % Slice EEG data by run

% Design high-pass filter to shortest run
doHPF = true;
if class(fHi)=="digitalFilter"
elseif (isstring(fHi) || ischar(fHi)) && fHi=="ASR"
    fHi = ec_designFiltASR(n.fs); % if arg.gpu; fHi = gpuArray(fHi); end
elseif (isstring(fHi) || ischar(fHi)) && fHi=="asr"
    fHi = designfilt('highpassfir',StopbandFrequency=0.25,PassbandFrequency=0.75,...
        StopbandAttenuation=80,DesignMethod="kaiserwin",SampleRate=n.fs);
elseif fHi>0
    [~,r] = min(runIdx);
    [~,fHi] = highpass(x{r}(:,1,1),fHi,fs,"ImpulseResponse","iir");
else
    doHPF = false;
end

%% Main
for r = 1:nRuns
    xr = x{r};
    %% Interpolate missing
    if doHPF || (~isempty(arg.missing) && arg.missing~="")
        if arg.missing==""; arg.missing="linear"; end
        xr = fillmissing(xr,arg.missing,1);
        disp("Interpolated missing: "+runs(r)); toc(tt);
    end

    %% Initial detrend w/ lower-order polynomial (timechunks within run)
    if numel(dOrder)>0 && dOrder(1)>0 && ~d3
       try dWinN=dWin(1); catch; dWinN=[]; end

       xr = ec_detrend(xr,dOrder(1),[],'polynomials',dThr(1),dItr(1),dWinN);
        for ii = 3:3:nWorkers
            idx = diff(1: floor(height(xr)/ii) : height(xr)); % Slice into time chunks
            idx(end) = idx(end) + (height(xr)-sum(idx));      % numChunks = number of CPU thread
            xr = mat2cell(xr,idx);
            dWts = cell(numel(xr),1);

            % Lower-order detrend
            parfor w = 1:numel(dWts)
                [xr{w},dWts{w}] = ec_detrend(xr{w},dOrder(1),[],'polynomials',...
                    dThr(1),dItr(1),dWinN); %#ok<PFBNS>
            end
            xr=vertcat(xr{:}); detrendWts{r}=vertcat(dWts{:});
            olPct = nnz(~detrendWts{r})/numel(detrendWts{r});
            disp("Robust polynomial detrended^"+dOrder(1)+" ol="+olPct+" "+runs(r)); toc(tt);
        end
    end
    x{r} = xr;
end

%% Final detrend w/ higher-order polynomial (entire run)
if numel(dOrder)>1 && dOrder(2)>0 && ~d3
    parfor r = 1:nRuns
        xr = x{r};
        wtsR = detrendWts{r};
        if isempty(wtsR) || ~nnz(wtsR); wtsR=ones(size(xr)); end
        %if arg.gpu; xr=gpuArray(xr); wtsR=gpuArray(wtsR); end
        for ii = 2:numel(dOrder)
            if dOrder(ii)>0
                try dWinN=dWin(ii); catch; dWinN=[]; end %#ok<PFBNS>
                [xr,wtsR] = ec_detrend(xr,dOrder(ii),wtsR,'polynomials',...
                    dThr(ii),dItr(ii),dWinN); %#ok<PFBNS>
                olPct = nnz(~wtsR)/numel(wtsR);
                disp("Robust polynomial detrended^"+dOrder(ii)+" ol="+olPct+" "+runs(r)); toc(tt);
            end
        end
        x{r} = xr;
        detrendWts{r} = wtsR;
    end
end

%% High-pass filter zero phase shift (entire run)
if doHPF
    for r = 1:nRuns
        xr = x{r};
        if arg.gpu && d3 && class(fHi)=="digitalFilter"
            for ch = 1:nChs
                xr(:,ch,:) = fHi.filtfilt(gpuArray(squeeze(xr(:,ch,:))));
            end
        elseif arg.gpu && ~d3 && class(fHi)=="digitalFilter"
            xr = gather(fHi.filtfilt(gpuArray(xr)));
        elseif d3 && class(fHi)=="digitalFilter"
            for ch = 1:nChs
                xr(:,ch,:) = fHi.filtfilt(gpuArray(squeeze(xr(:,ch,:))));
            end
        elseif class(fHi)=="digitalFilter"
            xr = fHi.filtfilt(xr);
        else
            parfor ch = 1:nChs
                xr(:,ch,:) = filtfilt(fHi,1,squeeze(xr(:,ch,:)));
            end
        end
        x{r} = xr;
        disp("Finished hi-pass: "+runs(r)); toc(tt);
    end
end

%%
x = vertcat(x{:});
detrendWts = logical(vertcat(detrendWts{:}));
detrendWts = sparse(~detrendWts);
if any(dOrder>0); n.("detrendW"+arg.sfx) = detrendWts; end
if arg.gpu; try reset(gpuDevice(1)); catch;end;end
end


