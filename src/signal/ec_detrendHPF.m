function [x,n] = ec_detrendHPF(x,fHi,dOrder,dWin,n,tt,arg)
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
    arg.gpu logical = true
    arg.itr {isnumeric} = [10 3]
    arg.thr {isnumeric} = [8 4]
    arg.sfx {isstring,ischar} = "";
    arg.sfxOg {isstring,ischar} = '';
end
if isempty(fHi); fHi=0; end
if isempty(dOrder)||~any(dOrder); dOrder=0; else
    dOrder=dOrder(dOrder>0); dOrder=dOrder(:); end
if ~isempty(arg.fs); fs=arg.fs; else; fs=n.fs; end
if ~isempty(arg.runIdx); runIdx=arg.runIdx; else; runIdx=n.runIdxOg(:,2); end
if arg.runs~=""; runs=arg.runs; else; runs=string(n.blocks); end
if ~isempty(arg.sfxOg) && nnz(fieldnames(n)=="detrendW"+arg.sfxOg)
    detrendWts = ~full(n.("detrendW"+arg.sfxOg));
else
    detrendWts = true(size(x));
end
dThr = arg.thr;
dItr = arg.itr;
nRuns = numel(runs);
dWin = dWin * fs;
d3 = numel(size(x))==3;
nChs = size(x,2);
%nWorkers = gcp('nocreate').NumWorkers;

%% Prepare vars
x = double(x);
x = mat2cell(x,runIdx); % Slice EEG data by run
detrendWts = mat2cell(detrendWts,runIdx);

% Design high-pass filter to shortest run
doHPF = true;
if class(fHi)=="digitalFilter"
elseif (isstring(fHi) || ischar(fHi)) && fHi=="ASR"
    fHi = ec_designFiltASR(fs);
elseif (isstring(fHi) || ischar(fHi)) && fHi=="asr"
    fHi = designfilt('highpassfir',StopbandFrequency=0.25,PassbandFrequency=0.75,...
        StopbandAttenuation=80,DesignMethod="kaiserwin",SampleRate=fs);
elseif isnumeric(fHi) && nnz(fHi)==2
    fHi = designfilt('highpassfir',StopbandFrequency=fHi(1),PassbandFrequency=fHi(2),...
        StopbandAttenuation=80,DesignMethod="kaiserwin",SampleRate=fs);
elseif fHi>0
    [~,r] = min(runIdx);
    [~,fHi] = highpass(x{r}(:,1,1),fHi,fs,ImpulseResponse="iir",StopbandAttenuation=80);
else
    doHPF = false;
end
if doHPF
    if class(fHi)=="digitalFilter" && fHi.ImpulseResponse=="fir"; arg.gpu=false; end
    if class(fHi)~="digitalFilter"; arg.gpu=false; end
    %if arg.gpu; try reset(gpuDevice(1)); catch;end;end
end

%% Within-run processing (loop across runs)
for r = 1:nRuns
    xr = x{r};
    dr = detrendWts{r};
    if isempty(dr) || ~nnz(dr); dr=ones(size(xr)); end

    %% Interpolate missing
    if doHPF || (~isempty(arg.missing) && arg.missing~="")
        if arg.missing==""; arg.missing="linear"; end
        xr = fillmissing(xr,arg.missing,1);
        disp("Interpolated missing: "+runs(r)); toc(tt);
    end

    %% Robust polynomial detrend
    if nnz(dOrder)
        disp("Starting detrend... "+runs(r)); toc(tt);
        olPct = zeros(numel(dOrder),nChs);

        % Parallel across channels
        parfor ch = 1:nChs
            olPctCh = squeeze(olPct(:,ch));
            % Loop across specified polynomial orders
            for ii = 1:numel(dOrder)
                [xr(:,ch,:),dr(:,ch,:)] = ec_detrend(squeeze(xr(:,ch,:)),...
                    dOrder(ii),squeeze(dr(:,ch,:)),'polynomials',dThr(ii),dItr(ii),dWin(ii)*fs); %#ok<PFBNS>
                olPctCh(ii) = nnz(~dr(:,ch,:));
            end
            olPct(:,ch) = olPctCh;
        end

        % Display outliers per order
        for ii = 1:numel(dOrder)
            olPct1 = sum(olPct(ii,:),"all")/numel(dr);
            disp("Robust polynomial detrended^"+dOrder(ii)+" ol="+olPct1+" "+runs(r));
        end
        toc(tt);
    end

    %% Zero-phase high-pass filtering (HPF)
    if doHPF
        if arg.gpu && d3 && class(fHi)=="digitalFilter"
            for ch = 1:nChs
                xr(:,ch,:) = fHi.filtfilt(gpuArray(squeeze(xr(:,ch,:))));
            end
        elseif arg.gpu && class(fHi)=="digitalFilter"
            xr = gather(fHi.filtfilt(gpuArray(xr)));
        elseif d3 && class(fHi)=="digitalFilter"
            for ch = 1:nChs
                xr(:,ch,:) = fHi.filtfilt(squeeze(xr(:,ch,:)));
            end
        elseif class(fHi)=="digitalFilter"
            xr = fHi.filtfilt(xr);
        elseif d3
            parfor ch = 1:nChs
                xr(:,ch,:) = filtfilt(fHi,1,squeeze(xr(:,ch,:)));
            end
        else
            xr = filtfilt(fHi,1,xr);
        end
        x{r} = xr;
        disp("Finished hi-pass: "+runs(r)); toc(tt);
    end

    %% Copy to main
    x{r} = xr;
    detrendWts{r} = dr;
end

% Finalize
x = vertcat(x{:});
detrendWts = logical(vertcat(detrendWts{:}));
detrendWts = sparse(~detrendWts);
if any(dOrder); n.("detrendW"+arg.sfx) = detrendWts; end
if arg.gpu && doHPF; try reset(gpuDevice(1)); catch;end;end
end

%% Depreciated
% %% Initial detrend w/ lower-order polynomial (timechunks within run)
% if numel(dOrder)>=1 && dOrder(1)>0 && ~d3
%     try dWinN=dWin(1); catch; dWinN=[]; end
%     xr = ec_detrend(xr,dOrder(1),dr,'polynomials',dThr(1),dItr(1),dWinN);
%     for ii = 3:3:nWorkers
%         idx = diff(1: floor(height(xr)/ii) : height(xr)); % Slice into time chunks
%         idx(end) = idx(end) + (height(xr)-sum(idx));      % numChunks = number of CPU thread
%         xr = mat2cell(xr,idx);
%         dr = mat2cell(dr,idx);
%
%         % Lower-order detrend
%         parfor w = 1:numel(dr)
%             [xr{w},dr{w}] = ec_detrend(xr{w},dOrder(1),dr{w},'polynomials',...
%                 dThr(1),dItr(1),dWinN*fs); %#ok<PFBNS>
%         end
%         xr = vertcat(xr{:});
%         dr = vertcat(dr{:}); olPct = nnz(~dr)/numel(dr);
%         disp("Robust polynomial detrended^"+dOrder(1)+" ol="+olPct+" "+runs(r)); toc(tt);
%     end
% end