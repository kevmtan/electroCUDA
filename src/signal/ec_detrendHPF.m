function [x,n] = ec_detrendHPF(x,n,tt,arg)
%% Robust detrend & high-pass filter

% Input validation
arguments
    x {isfloat} % EEG data: x(frames,channels)
    n struct = struct; % EEG metadata
    tt uint64 = tic; % Output from 'tic'
    arg.hpf {isnumeric,istext,isobject} = 0 % High-pass filter in Hz: cutoff Hz | [bandpass stopband] | digitalFilter object
    arg.poly {isnumeric} = [] % Detrend polynomial order
    arg.thr {isnumeric} = [8 4] % Detrend thresholds
    arg.itr {isnumeric} = [10 3] % Detrend iterations
    arg.win {isnumeric} = [] % Detrend overlapping window width (seconds)
    arg.fs {isnumeric} = [] % Sampling rate
    arg.runs string = "" % Runs
    arg.runIdx {isnumeric} = [] % Run indices
    arg.missing {istext} = "linear" % Interpolation method for missing
    arg.gpu {islogical} = false % Use GPU
    arg.sfx {istext} = ""
    arg.sfxOg {istext} = ''
end
hpf=arg.hpf; dPoly=arg.poly; dThr=arg.thr; dItr=arg.itr;
if ~isany(hpf); hpf=0; end
if ~isany(dPoly); dPoly=0; else
    dPoly=dPoly(dPoly>0); dPoly=dPoly(:); end
if isany(arg.fs); fs=arg.fs; else;try fs=n.fs; catch; fs=1000; end;end
if isany(arg.runIdx); runIdx=arg.runIdx; else
    try runIdx=n.runIdxOg(:,2); catch; runIdx=height(x); end;end
if isany(arg.runs); runs=arg.runs; else;try runs=string(n.blocks); catch; runs=""; end;end
if isany(arg.sfxOg) && isany(fieldnames(n)=="detrendW"+arg.sfxOg)
    detrendWts = ~full(n.("detrendW"+arg.sfxOg));
else
    detrendWts = true(size(x));
end
nRuns = numel(runs);
dWin = arg.win * fs;
d3 = numel(size(x))==3;
nChs = size(x,2);

%% Prepare high-pass filter
doHPF = true;
if class(hpf)=="digitalFilter" || isfloat(hpf) && nnz(hpf)>3
elseif (isstring(hpf) || ischar(hpf)) && hpf=="ASR"
    hpf = ec_designFiltASR(fs);
elseif istext(hpf) && hpf=="asr"
    hpf = designfilt('highpassfir',StopbandFrequency=0.25,PassbandFrequency=0.75,...
        StopbandAttenuation=80,DesignMethod="kaiserwin",SampleRate=fs);
elseif isnumeric(hpf) && nnz(hpf)==2
    hpf = designfilt('highpassfir',StopbandFrequency=hpf(1),PassbandFrequency=hpf(2),...
        StopbandAttenuation=80,DesignMethod="kaiserwin",SampleRate=fs);
elseif isnumeric(hpf) && nnz(hpf)==1
    hpf = designfilt('highpassfir',StopbandFrequency=hpf*.75,PassbandFrequency=hpf,...
        StopbandAttenuation=80,DesignMethod="kaiserwin",SampleRate=fs);
else
    doHPF = false;
    arg.gpu = false;
end
if doHPF && arg.gpu
    try reset(gpuDevice()); catch;end
    if class(hpf)=="digitalFilter"; hpf=hpf.Coefficients; end
end
if doHPF; x = double(x); end

%% Slice data by run
x = mat2cell(x,runIdx);
detrendWts = mat2cell(detrendWts,runIdx);

%% Within-run processing (loop across runs)
for r = 1:nRuns
    xr = x{r};
    dr = detrendWts{r};
    if ~isany(dr); dr=true(size(xr)); end

    %% Interpolate missing
    if nnz(ismissing(xr))
        xr = fillmissing(xr,arg.missing,1);
        disp("Interpolated missing: "+runs(r)+" time="+toc(tt));
    end

    %% Robust polynomial detrend
    if nnz(dPoly)
        disp("Starting detrend... "+runs(r)+" time="+toc(tt));
        olPct = zeros(numel(dPoly),nChs);

        % Parallel across channels
        parfor ch = 1:nChs
            olPctCh = squeeze(olPct(:,ch));
            % Loop across specified polynomial orders
            for ii = 1:numel(dPoly)
                [xr(:,ch,:),dr(:,ch,:)] = ec_detrend(xr(:,ch,:),...
                    dPoly(ii),dr(:,ch,:),'polynomials',dThr(ii),dItr(ii),dWin(ii)*fs); %#ok<PFBNS>
                olPctCh(ii) = nnz(~dr(:,ch,:));
            end
            olPct(:,ch) = olPctCh;
        end

        % Display outliers per order
        for ii = 1:numel(dPoly)
            olPct1 = sum(olPct(ii,:),"all")/numel(dr);
            disp("Robust polynomial detrended^"+dPoly(ii)+" ol="+olPct1+" "+runs(r)+" time="+toc(tt));
        end
    end

    %% Zero-phase high-pass filter (HPF)
    if doHPF
        if d3 && (arg.gpu || class(hpf)=="digitalFilter")
            xr = num2cell(xr,[1 3]);
            xr = cellfun(@(xCh) squeeze(xCh),xr,UniformOutput=false);
            if arg.gpu
                xr = arrayfun(@(xCh) ec_filtfilt_mex(xCh{:},hpf),xr,UniformOutput=false);
            else
                xr = arrayfun(@(xCh) hpf.filtfilt(xCh{:}),xr,UniformOutput=false);
            end
            xr = permute(cat(3,xr{:}),[1 3 2]);
        elseif arg.gpu
            xr = ec_filtfilt_mex(xr,hpf);
        elseif class(hpf)=="digitalFilter"
            xr = hpf.filtfilt(xr);
        elseif d3
            parfor ch = 1:nChs
                xr(:,ch,:) = filtfilt(hpf,1,squeeze(xr(:,ch,:)));
            end
        else
            xr = filtfilt(hpf,1,xr);
        end
        disp("Finished hi-pass: "+runs(r)+" time="+toc(tt));
    end

    %% Copy to main
    x{r} = xr;
    detrendWts{r} = dr;
end

%% Finalize
x = vertcat(x{:});
if isany(dPoly)
    detrendWts = logical(vertcat(detrendWts{:}));
    if ~d3
        detrendWts = sparse(~detrendWts);
    else
        detrendWts = num2cell(detrendWts,[1 3]);
        detrendWts = cellfun(@squeeze,detrendWts,UniformOutput=false);
        detrendWts = cellfun(@(v) sparse(~v),detrendWts,UniformOutput=false);
    end
    n.("detrendW"+arg.sfx) = detrendWts;
end
if doHPF && arg.gpu; try reset(gpuDevice(1)); catch;end;end
end