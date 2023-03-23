function [n,x] = ec_HPF(n,x,tt,arg)
%% Zero-phase high-pass filter
arguments
    n struct                        % EEG metadata
    x double                        % EEG data: x(frames,channels)
    tt uint64 = tic                 % Output from 'tic'
    arg.missing {istext} = ""       % Interpolation method for missing
    arg.hpf {isnumeric,istext,isobject} = 0 % High-pass filter in Hz: cutoff Hz | [bandpass stopband] | digitalFilter object
    arg.gpu (1,1) logical = false     % Run on GPU (needs CUDA gpu)
    arg.steepness double = 0.75
end
fs = n.fs;
%nChs = size(x,2);
%d3 = numel(size(x))==3;
runs = n.runs;
nRuns = numel(n.runs);
hpf = arg.hpf;

% Slice data by run
x = mat2cell(x,n.runIdxOg(:,2));


%% Prepare high-pass filter
if class(hpf)=="digitalFilter" || isfloat(hpf) && nnz(hpf)>3
elseif (isstring(hpf) || ischar(hpf)) && hpf=="ASR"
    hpf = ec_designFiltASR(fs);
elseif istext(hpf) && hpf=="asr"
    hpf = designfilt('highpassfir',StopbandFrequency=0.25,PassbandFrequency=0.75,...
        PassbandRipple=0.1,StopbandAttenuation=80,DesignMethod="kaiserwin",SampleRate=fs);
elseif isnumeric(hpf) && nnz(hpf)==2
    hpf = designfilt('highpassfir',StopbandFrequency=hpf(1),PassbandFrequency=hpf(2),...
        PassbandRipple=0.1,DesignMethod="kaiserwin",SampleRate=fs);
elseif isnumeric(hpf) && nnz(hpf)==1
    hpf = designfilt('highpassfir',StopbandFrequency=hpf*arg.steepness,PassbandFrequency=hpf,...
        PassbandRipple=0.1,DesignMethod="kaiserwin",SampleRate=fs);
else
    arg.gpu = false;
end
if arg.gpu
    try reset(gpuDevice()); catch;end
    if class(hpf)=="digitalFilter"; hpf=hpf.Coefficients; end
end



%% HPF within-run to avoid edge artifacts
for r = 1:nRuns
    xr = x{r};

    % Interpolate missing
    if isany(arg.missing) && nnz(ismissing(xr))
        xr = fillmissing(xr,arg.missing,1);
        disp("Interpolated missing: "+runs(r)+" time="+toc(tt));
    end

    % Zero-phase high-pass filter (HPF)
    xr = double(xr);
    if class(hpf)=="digitalFilter"
        xr = hpf.filtfilt(xr);
    elseif arg.gpu
        xr = ecc_filtfilt_mex64(xr,hpf);
    else
        xr = filtfilt(hpf,1,xr);
    end
    disp("Finished hi-pass: "+runs(r)+" time="+toc(tt));


    % Copy to main
    x{r} = xr;
end

%% Finalize
x = vertcat(x{:});
if arg.gpu; try reset(gpuDevice(1)); catch;end;end
end