function [x,n,hpf] = ec_HPF(x,n,hpf,tt,a)
%% Zero-phase high-pass filter
arguments
    x {isfloat}                     % EEG data: x(frames,channels)
    n {isstruct,isnumeric}          % EEG metadata or sampling rate (Hz)
    hpf {isnumeric,istext,isobject} % High-pass filter in Hz: cutoff Hz | [bandpass stopband] | digitalFilter object
    tt uint64 = tic                 % Output from 'tic'
    a.gpu (1,1) logical = false   % Run on GPU (needs CUDA gpu)
    a.steepness {mustBeLessThanOrEqual(a.steepness,1)} = 0.85 % Passband to stopband multiplier
    a.impulse {mustBeMember(a.impulse,["fir" "iir" "auto"])} = "fir" % Impulse response
    a.missing {istext} = ""       % Interpolation method for missing
    a.single logical = logical([])
end
minIdx = false(height(x),1); 
singleOut = a.single;
if isempty(singleOut)
    if isa(x,"single"); singleOut=true; else; singleOut=false; end
end
if singleOut; x=single(x); else; x=double(x); end
if isnumeric(n)
    minIdx(:) = true;
    fs=n;
else
    fs=n.fs; [~,id]=min(n.runIdxOg(:,2));
    minIdx(n.runIdx(id,1):n.runIdx(id,2)) = true;
end

%% Prepare high-pass filter
if isnumeric(hpf) && numel(hpf)==1
    hpf = ec_designFilt(x(minIdx,1,1),fs,hpf,impulse=a.impulse,steepness=a.steepness);
elseif isnumeric(hpf) && numel(hpf)==2
    hpf = designfilt("highpassfir",StopbandFrequency=hpf(1),PassbandFrequency=hpf(2),...
        PassbandRipple=0.1,StopbandAttenuation=80,DesignMethod=hpfDesign,SampleRate=fs);
elseif istext(hpf) && hpf=="asr"
    hpf = designfilt("highpassfir",StopbandFrequency=0.25,PassbandFrequency=0.75,...
        PassbandRipple=0.1,StopbandAttenuation=80,DesignMethod=hpfDesign,SampleRate=fs);
elseif istext(hpf) && hpf=="ASR"
    hpf = ec_designFiltASR(fs);
elseif class(hpf)~="digitalFilter" && ~(isfloat(hpf) && nnz(hpf)>3)
    error("[ec_hpf] Invalid 'hpf' input")
end
if class(hpf)=="digitalFilter"
    disp("[ec_HPF] Filter object: "); disp(hpf);
end

% % Just get coefficients for gpu
% if a.gpu && class(hpf)=="digitalFilter" && ~isgpuarray(x)
%     hpf = hpf.Coefficients; end

%% Zero-phase high-pass filter (HPF)

if isnumeric(n) % HPF all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Interpolate missing
    if isany(a.missing) && nnz(ismissing(x))
        x = fillmissing(x,a.missing,1);
        disp("[ec_HPF] Interpolated missing: time="+toc(tt));
    end

    % HPF
    x = ec_filtfilt(x,hpf,gpu=a.gpu,single=singleOut);
    if singleOut; x=single(x); end
    disp("[ec_HPF] Finished: time="+toc(tt));

else % HPF within-run to avoid edge artifacts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x = mat2cell(x,n.runIdxOg(:,2));
    for r = 1:n.nRuns
        % Interpolate missing
        if isany(a.missing) && nnz(ismissing(xr))
            xr = fillmissing(xr,a.missing,1);
            disp("[ec_HPF] Interpolated missing: "+n.runs(r)+" time="+toc(tt));
        end

        % HPF
        xr = ec_filtfilt(xr,hpf,gpu=a.gpu,single=singleOut);
        disp("[ec_HPF] Finished: "+n.sbj+" run="+n.runs(r)+" time="+toc(tt));

        % Copy to main
        if singleOut; xr=single(xr); end
        x{r} = xr;
    end
    x = vertcat(x{:});
end