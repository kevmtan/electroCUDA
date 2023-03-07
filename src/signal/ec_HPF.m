function [n,x] = ec_HPF(n,x,tt,arg)
%% Robust detrend & high-pass filter

% Input validation
arguments
    n struct                        % EEG metadata
    x {isfloat}                     % EEG data: x(frames,channels)
    tt uint64 = tic                 % Output from 'tic'
    arg.missing {istext} = "linear" % Interpolation method for missing
    arg.hpf {isnumeric,istext,isobject} = 0 % High-pass filter in Hz: cutoff Hz | [bandpass stopband] | digitalFilter object
    arg.gpu (1,1) logical = false     % Run on GPU (needs CUDA gpu)
    arg.single {isempty,islogical}=[] % Run in single-precision if on GPU
    arg.sfx {istext} = ""
    arg.sfxOg {istext} = ''
end
fs = n.fs;
nChs = size(x,2);
d3 = numel(size(x))==3;
runs = n.runs;
nRuns = numel(n.runs);


%% Prepare high-pass filter
doHPF = true;
if ~isany(arg.hpf); hpf=0; else; hpf=arg.hpf; end
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

% Slice data by run
x = mat2cell(x,n.runIdxOg(:,2));

%% HPF within-run to avoid edge artifacts
for r = 1:nRuns
    xr = x{r};

    % Interpolate missing
    if nnz(ismissing(xr))
        xr = fillmissing(xr,arg.missing,1);
        disp("Interpolated missing: "+runs(r)+" time="+toc(tt));
    end

    % Zero-phase high-pass filter (HPF)
    if doHPF
        xr = double(xr);
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

    % Copy to main
    x{r} = xr;
end

%% Finalize
x = vertcat(x{:});
if doHPF && arg.gpu; try reset(gpuDevice(1)); catch;end;end
end