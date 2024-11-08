function errors = ec_connWC(sbj,task,o,n,x,a)
%% [electroCUDA] wavelet coherence
%
%
% SEE WIKI FOR MORE INFO: github.com/kevmtan/electroCUDA/wiki
%
% INPUTS:
%    sbj = subject name
%    task = task name
%    o = struct of options & parameters (TO DO: describe all options)
%    n = preloaded 'n' info output from ec_initialize or robustPreproc (OPTIONAL)
%    x = preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
%    arg = Name-Value Arguments (see "Input validation" below)
%
% OUTPUTS:
%   errors = cell array of any errors or warnings
%   n = Struct of preprocessing info & results
%   x = Preprocessed EEG data indexed as: x(timeframe,channel)
%      NOTE: 'n' and 'x' are saved to disk by default
%
% LICENSE: General Public License (GNU GPLv3)
% DISCLAIMERS:
%    Use and distribution of this software must comply with GNU GPLv3.
%    This software may be subject to University of California intellectual
%    property rights.
%    Use this code at your own risk. Users assume full responsibility for
%    any eventualities related to the content herein.
%    This code is for research purposes only and NOT INTENDED FOR CLINICAL USE.
%
%
%                 Kevin Tan, 2024 (github.io/kevmtan)

%% Input validation
arguments
    sbj {istext,isnumeric} = ""
    task {mustBeText} = ""
    o struct = struct % options struct (see "Options struct validation" below)
    n struct = [] % preloaded 'n' struct from ec_preproc (OPTIONAL)
    x {isfloat} = [] % preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
    a.dirs struct = [] % Directory paths struct
    a.ica logical = false % Input data from ICA?
    a.save logical = false
    a.test logical = false
    a.redoN logical = false
end
dirs = a.dirs;
% n=[]; x=[]; a.ica=0; a.save=0; a.test=1;


%% Options validation
if ~isfield(o,'wavelet');     o.wavelet="Morse"; end  % Name of frequency analysis
if ~isfield(o,'fName');       o.fName="spec"; end     % Name of frequency analysis
if ~isfield(o,'fLims');       o.fLims=[1 300]; end    % Frequency limits in hz; HFB=[70 200]
if ~isfield(o,'fVoices');     o.fVoices=12; end       % Voices per octave (default=10, HFB=18)
if ~isfield(o,'dsTarg');      o.dsTarg=[]; end        % Downsample target in Hz (default=[]: no downsample)
if ~isfield(o,'single');      o.single=false; end     % Run & save as single (single much faster on GPU)
if ~isfield(o,'singleOut');   o.singleOut=true; end   % Save as half-precision float (16-bit) to save memory
if ~isfield(o,'gpu');         o.gpu="no"; end         % Run on... ["no"|"matlab"|"cuda"]

% Consistency
if o.single; o.singleOut = false; end
if a.ica && o.suffix==""; o.suffix="i"; end


%% Setup & initialize
tt=tic; errors={};

% Load EEG data
if isempty(x) || a.test
    [n,x,chNfo,dirs] = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=o.suffix,...
        vars=["n" "x" "chNfo"]);
end
% if a.test; xOg=x; chNfoOg=chNfo; end %#ok<NASGU>

% Convert floating-point precision
if o.single; x=single(x); else; x=double(x); end

% Load metadata
sbjID = n.sbjID;
nRuns = n.nRuns;
fsOg = n.fs;
n.task = task;
n.suffix = o.suffix;
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
if ~isfield(o,'dirOut'); o.dirOut=dirs.anal+"connectivity/"+os.name+"/"; end % Output directory
if ~isfield(o,'dirOutSbj'); o.dirOutSbj=o.dirOut+"s"+statusSum.sbjID(s)+"/"; end
if ~isfield(o,'fnStr');  o.fnStr="s"+sbjID+"_"+task+".mat"; end % Filename ending string

% Get downsampling factor & anti-aliasing filter
ds = 0;
if isany(o.dsTarg)
    [ds(1),ds(2)] = rat(o.dsTarg/n.fs);
    % Errors
    if ds(1) > ds(2) 
        errors{end+1} = "[ec_connWC] "+sbj+" downsampling target > sampling rate";
        error(errors{end});
    elseif ds(1) ~= 1
        errors{end+1} = "[ec_connWC] "+sbj+" downsampling target must be wholly divisible by sampling rate";
        error(errors{end});
    end
    ds = ds(2);
end

% Only keep good channels (ICA chans rn)
idx = chNfo.ica;
x = x(:,idx);
chNfo = chNfo(idx,:);
nChs = nnz(idx);

% Calculate channel pairs
cc = uint16(1:nChs);
cc = combinations(cc,cc);
cc = renamevars(cc,[1 2],["i1" "i2"]);
cc = cc(cc.i1~=cc.i2,:); % Remove same-channel pairs
% Keep unique channel pairs only
for p = 1:nChs
    idx = cc.i1>p & cc.i2==p;
    cc = cc(~idx,:);
end
cc.ch1 = chNfo.ch(cc.i1);
cc.ch2 = chNfo.ch(cc.i2);
nPairs = height(cc);

% Reset GPU, move vars to GPU, get free VRAM
if o.gpu~="no"
    try reset(gpuDevice()); catch; end
    memMax = ec_ramAvail(true); % see available vram
else
    memMax = ec_ramAvail;
end
% try ppool = parpool; catch;end %#ok<NASGU>

% Reshape per run
x = mat2cell(x,n.runIdxOg(:,2));
y=cell(nRuns,1); z=y;
cwtHz = cell(nRuns,1);
disp("[ec_wtc] Starting WTC: s"+n.sbjID+" time="+toc(tt));


%% Wavelet coherence (within-run to avoid edge artifacts)
for r = 1:nRuns
    [y{r},z{r},cwtHz{r}] = wcRun_lfn(o,x{r},cc,fsOg,ds,rn,memMax,tt);
    if ~a.test; x{r} = []; end % delete input data
end


%% Organize & clear memory
x = vertcat(x{:});
if ~fMean
    x = flip(x,3); % Sort freqs from low to high
end
n.xFrames = size(x,1);
n.xChs = nChs;
n.nFreqs = size(x,3);
n.freqs = flip(cwtHz{1});
n.freqsRun = vertcat(cwtHz{:});


%% Finalize

% Reset GPU
if doGPU
    if ~isempty(gcp('nocreate')); parfevalOnAll(@gpuDevice,0,[]); end
    try reset(gpuDevice()); catch; end
end

% Save
if a.save
    % Save chNfo
    if o.doBadFrames && ~a.ica
        fn = o.dirOut+"chNfo_"+o.fnStr;
        save(fn,'chNfo','-v7'); disp("SAVED: "+fn);
    end

    % Save n struct
    fn = o.dirOut+"n"+sfx+"_"+o.fnStr;
    save(fn,"n","-v7"); disp("SAVED: "+fn);

    % Save processed iEEG data
    fn = o.dirOut+"x"+sfx+"_"+o.fnStr;
    savefast(fn,'x'); disp("SAVED: "+fn+" time="+toc(tt));
end




%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function [xr,xs,frqs] = wcRun_lfn(o,xr,cc,fsOg,ds,rn,memMax,tt)
%% Wavelet coherence (within-run) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Continuous wavelet transform
[xr,frqs,scales] = ec_wt(xr,fs=fsOg,lims=o.fLims,voices=o.fVoices,out="complex",...
    wavelet=o.wavelet,ds=ds,single=o.single,singleOut=o.singleOut,mem=memMax,...
    cell=true,gpu=o.gpu,tic=tt);
xr = cellfun(@rot90,xr,UniformOutput=false)'; % Make row-major
nSmooth = min(floor(numel(scales)/2),o.fVoices); % find num scales to smooth
disp("[ec_connWC] Finished CWT: s"+o.sbjID+"_run"+rn+" time="+toc(tt));

%% Smooth all CWT coefficients
xs = smoothAll_lfn(xr,scales,nSmooth,o.singleOut);
disp("[ec_connWC] Finished smoothing: s"+o.sbjID+"_run"+rn+" time="+toc(tt));

%% Pairwise coherence
[xr,xs] = pairwiseWC_lfn(xr,xs,cc,scales,nSmooth,memMax,o);
disp("[ec_connWC] Finished wavelet coherence: s"+o.sbjID+"_run"+rn+" time="+toc(tt));



function xs = smoothAll_lfn(xs,scales,nSmooth,sOut)
%% Smooth wavelets - all chans %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ch = 1:numel(xs)
    cfs = xs{ch};
    if sOut; cfs = double(cfs); end
    cfs = ec_wtSmooth(abs(cfs).^2,scales,nSmooth);
    if sOut; cfs = single(cfs); end
    xs{ch} = cfs;
end



function [yr,zr] = pairwiseWC_lfn(xr,xs,cc,scales,nSmooth,memMax,o)
%% Pairwise wavelet coherence %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sOut = o.singleOut;
nPairs = height(cc);
nChs = numel(xs);
pp = 1:nPairs;
% nFrames = width(xs{1});
% nFrqs = numel(scales);
% yr = nan(nFrames,nPairs,nFrqs,like=xs{1}); zr=yr; % preallocate output

if o.gpu~="no"
    % Preallocate output
    yr = cell(1,nPairs); zr=yr;

    % Find how many will fit in memory simultaneously
    memIn = (whos("xs").bytes*6)/nChs;
    memPairs = floor(memMax/memIn);
    memItr = ceil(nPairs/memPairs);
    memPairs = ceil(nPairs/memItr);
    pFin = false(nPairs,1);
    disp("[ec_connWC] Start wavelet coherence gpuArrayFun: memChs="+memPairs+"/"+nPairs);

    % Move vars to GPU
    scales=gpuArray(scales); nSmooth=gpuArray(nSmooth); sOut=gpuArray(sOut);

    % Loop across iterations of simultaneous pairwise processing
    for v = 1:memItr
        idx = find(~pFin,memPairs); % Find iteration pairs
        chs = unique(cc{idx,1:2}); % Find iteration chans

        % Copy chans to GPU
        xr(chs) = cellfun(@gpuArray,xr(chs),UniformOutput=false);
        xs(chs) = cellfun(@gpuArray,xs(chs),UniformOutput=false);

        % Compute wavelet coherence for iteration pairs
        [yr(idx),zr(idx)] = arrayfun(@(p)...
            wc_lfn(xr{cc.i1(p)},xr{cc.i2(p)},xs{cc.i1(p)},xs{cc.i2(p)},...
            scales,nSmooth,sOut), pp(idx), UniformOutput=false);
        pFin(idx) = true;

        % Empty finished channels
        chsF = ~ismember(1:nChs, unique(cc{~pFin,1:2}));
        if isany(chsF)
            xr(chsF) = cellfun(@(x) [],xr(chsF),UniformOutput=false);
            xs(chsF) = cellfun(@(x) [],xs(chsF),UniformOutput=false);
        end

        % Move data to CPU
        yr(idx) = cellfun(@gather,yr(idx),UniformOutput=false);
        zr(idx) = cellfun(@gather,zr(idx),UniformOutput=false);
        xr(chs) = cellfun(@gather,xr(chs),UniformOutput=false);
        xs(chs) = cellfun(@gather,xs(chs),UniformOutput=false);
    end
    % Double-check moving to CPU
    yr = cellfun(@gather,yr,UniformOutput=false);
    zr = cellfun(@gather,zr,UniformOutput=false);
else
    % Compute pairwise wavelet coherence on CPU (arrayfun faster than loop)
    [yr,zr] = arrayfun(@(p)...
        wc_lfn(xr{cc.i1(p)},xr{cc.i2(p)},xs{cc.i1(1)},xs{cc.i2(p)},...
        scales,nSmooth,sOut), pp, UniformOutput=false);
end

% Finalize output
yr = permute(cat(3,yr{:}),[1 3 2]);
zr = permute(cat(3,zr{:}),[1 3 2]);





function [yp,zp] = wc_lfn(x1,x2,s1,s2,scales,nSmooth,sOut)
%% Wavelet coherence %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Process as double, output as single
if sOut; x1=double(x1); x2=double(x2); s1=double(s1); s2=double(s2); end

% Compute
zp = x1.*conj(x2); % cross coefs
zp = ec_wtSmooth(zp,scales,nSmooth); % smooth
yp = abs(zp).^2./(s1.*s2); % convert to power
yp = min(yp,1,'includenan');
zp = angle(zp); % get phase-coherence angle
yp=yp'; zp=zp'; % rotate

% Output as single
if sOut; yp=single(yp); zp=single(zp); end
