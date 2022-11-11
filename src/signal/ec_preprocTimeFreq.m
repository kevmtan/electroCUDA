function [errors,n,x] = ec_preprocTimeFreq(sbj,proj,o,n,x,arg)
% Time-frequency decomposition using continuous wave transform (CWT)
% CWT uses Morse wavelets (FUTURE: add more CWT options)
% CWT is used with L1 normalization to mitigate 1/f power decay at higher freqs
%
% TO DO: compile CWT in CUDA
arguments
    sbj
    proj {mustBeText} = 'MMR'
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    n struct = [] % preloaded 'n' info output from ec_initialize or robustPreproc (OPTIONAL)
    x {isfloat} = [] % preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
    arg.dirs struct = [] % Directory paths struct
    arg.ica logical = false
    arg.raw logical = false
    arg.save logical = false
    arg.test logical = false
    arg.redoN logical = true
end
dirs=arg.dirs;
% sbj='S12_38_LK'; proj='MMR'; n=[]; x=[];
% arg.ica=0; arg.raw=0; arg.save=0; arg.test=1;
% o=oSpec; o=oHFB;

%% Options struct validation (non-exhaustive, see individual functions below)
if ~isstruct(dirs); dirs = ec_getDirs(dirs,sbj,proj); end
if ~isfield(o,'gatherOut');   o.gatherOut=false; end
if ~isfield(o,'fName');       o.fName="hfb"; end       % Name of frequency analysis
if ~isfield(o,'fLims');       o.fLims=[60 180]; end    % Frequency limits in hz; HFB=[70 200]
if ~isfield(o,'fMean');       o.fMean=true; end        % Collapse across frequency bands (for 1d vector output)
if ~isfield(o,'fVoices');     o.fVoices=32; end        % Voices per octave (default=10, HFB=18)
if ~isfield(o,'dsTarg');      o.dsTarg=[]; end         % Downsample target in Hz (default=[]: no downsample)
if ~isfield(o,'single');      o.single=[]; end         % Convert to double to single (single much faster on GPU)
if ~isfield(o,'singleOut');   o.singleOut=[]; end      % Run as double (accuracy) & save as single for smaller HDD size
if ~isfield(o,'thrSpec');     o.thrSpec=15; end        % Threshold for averaged spectral data (e.g. HFB) (z-score threshold relative to all data points) to exclude timepoints
if ~isfield(o,'doGPU');       o.doGPU=false; end       % Run on GPU, see MATLAB gpuArray requirements (default=false)
% Make workspace vars
doGPU=o.doGPU; fMean=o.fMean; dsTarg=o.dsTarg; singleOut=o.singleOut;

%% Setup
tic;
% Load metadata
[errors,o,n,chNfo] = ec_initialize(sbj,proj,o,n,ica=arg.ica,dirs=dirs,save=0,redoN=arg.redoN);
sbjID = n.sbjID;
nRuns = n.nRuns;
runIdx = n.runIdx;
blocks = string(n.blocks);
fsOg = floor(n.fs_orig);
n.proj = proj;
n.suffix = o.suffix;
if ~arg.ica
    sbjChs=chNfo.sbjCh;
else
    sbjChs=n.icNfo.sbjIC;
end
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
if ~isfield(o,'dirOut'); o.dirOut=dirs.robustSbj; end % Output directory
if ~isfield(o,'fnStr');  o.fnStr="s"+sbjID+"_"+proj+".mat"; end % Filename ending string
if doGPU
    if ~isempty(gcp('nocreate')); parfevalOnAll(@gpuDevice, 0, []); end
    try reset(gpuDevice(1)); catch; end
end

%% Load EEG data
if isempty(x)
    if arg.ica && o.sfx_src==""; o.sfx_src="i"; end
    x = ec_loadSbj(dirs,o.sfx_src,"x");
end
nChs = size(x,2);

% Get downsampling factor & anti-aliasing filter
if ~isempty(dsTarg)
    [ds1,ds2] = rat(dsTarg/fsOg);
    if ds1>ds2; error(sbj+" downsampling target > iEEG sampling rate"); end
else; ds1=1; ds2=1;
end

% Transfer vars to GPU
if doGPU
    if ~isempty(gcp('nocreate')); parfevalOnAll(@gpuDevice, 0, []); end
    try reset(gpuDevice()); catch; end
    fMean=gpuArray(logical(fMean)); singleOut=gpuArray(logical(singleOut));
    ds1=gpuArray(ds1); ds2=gpuArray(ds2);
    memMax=gpuDevice(); memMax=memMax.AvailableMemory;
else
    try parpool('threads'); catch;end
end



%% Continuous Wavelet Transform with L1-norm for 1/freq decay
xf = cell(nRuns,1);
cwtHz = xf;
% CWT within-run (avoid edge artifacts at run transitions)
for b = 1:nRuns
    idx = runIdx(b,1):runIdx(b,2);
    bLength = length(idx);
    block = blocks(b);

    % Get block iEEG data
    xa = x(idx,:);
    if o,single; xa = single(xa); end
    xa = num2cell(xa,1);

    % Generate CWT filter
    fb = cwtfilterbank(SignalLength=bLength,VoicesPerOctave=o.fVoices,...
        SamplingFrequency=fsOg,FrequencyLimits=o.fLims);
    cwtHz{b} = fb.centerFrequencies';

    % Do CWT
    if ~doGPU
        % CPU parfor-loop (slower, no GPU required)
        disp("Starting wavelet transform (CPU): "+sbj+" "+block+"..."); toc  
        parfor ch = 1:nChs
            xa{ch} = cwt_lfn(fb,xa{ch},fMean,ds1,ds2,singleOut);
        end
    else % Use GPU (faster, requires nVidia CUDA GPU)
        disp("Starting wavelet transform (GPU): "+sbj+" "+block+"..."); toc  
        chFin = false(nChs,1);
        
        % Get number of chans that will fit in VRAM
        memIn=xa{1}; memIn=whos('memIn'); memIn=memIn.bytes; memOut=memIn; %#ok<NASGU> 
        %if o.singleOut && isdouble(xa{1}); memOut=memOut/2; end
        if ~fMean; memOut=memOut*nnz(cwtHz{b}); end
        memChs=floor(memMax/(memIn+memOut)); memChs=floor(nChs/memItr); %#ok<NASGU> 
        
        % gpuArray per number of chans in VRAM
        for v = 1:numel(memChs:memChs:nChs)
            idx=find(~chFin,memChs);
            xa(idx) = cellfun(@gpuArray,xa(idx),'UniformOutput',false);
            xa(idx) = arrayfun(@(xCh) cwt_lfn(fb,xCh{:},fMean,ds1,ds2,singleOut),...
                xa(idx),'UniformOutput',false);
            xa(idx) = cellfun(@gather,xa(idx),'UniformOutput',false);
            chFin(idx) = true;
            disp("Finished wavelet transform (GPU): "+sbj+" "+block+" "+idx(end)+"/"+nChs);
        end
        xa = cellfun(@gather,xa,'UniformOutput',false);
    end
    if ~arg.test; clear xa; end

    %% Finalize
    if fMean
        xa = horzcat(xa{:});
    else % reshape
        xa = permute(cat(3,xa{:}),[1 3 2]);
    end
    xf{b} = xa; % copy to main
    disp("Finished wavelet transform: "+sbj+" "+block); toc;
end


%% Organize & clear memory
x = vertcat(xf{:}); if ~arg.test; clear xf; end
if ~fMean
    x = flip(x,3); % Sort freqs from low to high
end
n.xFrames = size(x,1);
n.xChs = size(x,2);
n.nFreqs = size(x,3);
n.freqs = flip(cwtHz{1});
n.freqsRun = vertcat(cwtHz{:});

%% Identify bad frames per chan
if o.doBadFrames && ~arg.ica
    % Retain HFO
    if any(n.badFrames.Properties.VariableNames=="hfo")
        x_bad = n.badFrames(:,["ch" "hfo"]);
        if ds2>1
            hfo = resample(double(full(x_bad.hfo)),ds1,ds2,'Dimension',2);
            x_bad.hfo = sparse(hfo>=0.5);
        end
    else
        x_bad = n.badFrames(:,"ch");
    end

    % Identify
    [chNfo.bad,x_bad] = ec_findBadFrames(x,chNfo.bad,x_bad,sfx,...
        mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);
    n.badFrames = x_bad;
    disp("Identified bad frames per chan: "+sbj); 
elseif o.doBadFrames
    [ic_bad,x_bad] = ec_findBadFrames(x,[],n.icNfo(:,["ic" "name"]),...
        mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);
    ic_bad.Properties.VariableNames = "bad_"+ic_bad.Properties.VariableNames+sfx;
    n.icNfo(:,ic_bad.Properties.VariableNames) = ic_bad;
    n.badFrames = x_bad;
    disp("Identified bad frames per IC: "+sbj); 
end
toc;

%% Finalize
sfx = o.suffix;
n.("o"+sfx) = o;
if fMean
    if ~arg.ica
        n.chCov = cov(x,'partialrows');
        n.chVar = diag(n.chCov);
        n.chCorr = corrcov(n.chCov);
    else
        n.icCov = cov(x,'partialrows');
        n.icVar = diag(n.icCov);
        n.icCorr = corrcov(n.icCov);
    end
end

% Reset GPU
if doGPU
    if ~isempty(gcp('nocreate')); parfevalOnAll(@gpuDevice, 0, []); end
    try reset(gpuDevice(1)); catch; end
end

% Save
if arg.save
    % Save chNfo
    if o.doBadFrames && ~arg.ica
        fn = o.dirOut+"chNfo_"+o.fnStr;
        save(fn,'chNfo','-v7'); disp("SAVED: "+fn)
    end

    % Save n struct
    fn = o.dirOut+"n"+sfx+"_"+o.fnStr;
    save(fn,"n","-v7.3"); disp("SAVED: "+fn);

    % Save processed iEEG data
    fn = o.dirOut+"x"+sfx+"_"+o.fnStr;
    savefast(fn,'x'); disp("SAVED: "+fn);
end
toc;
end


%% CWT local function
function wt = cwt_lfn(fb,xch,fMean,ds1,ds2,singleOut)
if fMean
    wt = fb.scaleSpectrum(xch)'; % dims: wt(time,1)
else
    wt = abs(fb.wt(xch))'; % dims: wt(time,freq)
end
if ds2>1
    wt = resample(wt,ds1,ds2);
end
if singleOut; wt = single(wt); end
end
%wt = wt.^2; % power = magnitude squared