function [errors,n,x] = ec_preprocTimeFreq(sbj,task,o,n,x,arg)
%% electroCUDA: time-frequency decomposition
% This function performs time-frequency decomposition on channel or IC timecourses
% (output of 'ec_preproc' or 'ec_preprocICA'). Decomposition is performed via
% continuous wavelet transform (CWT) using Morse wavelets, which account
% for unequal variance-covariance across frequencies (unlike other wavelets).
% L1-norm is applied to mitigate the 1/frequency decay of neuronal field potentials.
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
% ACKNOWLEDGEMENTS:
%    * Stanford Parvizi Lab (Pedro Pinhiero-Chagas, Amy Daitch, Su Liu, et al.)
%    * Laboratoire des Systèmes Perceptifs (NoiseTools: Alain de Cheveigné, et al.)
%    * Full acknowledgements in Wiki (github.com/kevmtan/electroCUDA/wiki)
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
%                 Kevin Tan, 2022 (github.io/kevmtan)

%% Input validation
arguments
    sbj {istext,isnumeric}
    task {mustBeText} = 'MMR'
    o struct = struct % options struct (see "Options struct validation" below)
    n struct = [] % preloaded 'n' struct from ec_preproc (OPTIONAL)
    x {isfloat} = [] % preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
    arg.dirs struct = [] % Directory paths struct
    arg.ica logical = false
    arg.raw logical = false
    arg.save logical = false
    arg.test logical = false
    arg.redoN logical = false
end
dirs=arg.dirs;
% n=[]; x=[]; arg.ica=0; arg.raw=0; arg.save=0; arg.test=1; arg.redoN=1;
% o=oSpec; o=oHFB;

%% Options struct validation (non-exhaustive, see individual functions below)
if ~isstruct(dirs); dirs = ec_getDirs(dirs,sbj,task); end
if ~isfield(o,'fName');       o.fName="hfb"; end       % Name of frequency analysis
if ~isfield(o,'fLims');       o.fLims=[60 180]; end    % Frequency limits in hz; HFB=[70 200]
if ~isfield(o,'fMean');       o.fMean=true; end        % Collapse across frequency bands (for 1d vector output)
if ~isfield(o,'fVoices');     o.fVoices=32; end        % Voices per octave (default=10, HFB=18)
if ~isfield(o,'dsTarg');      o.dsTarg=[]; end         % Downsample target in Hz (default=[]: no downsample)
if ~isfield(o,'single');      o.single=[]; end         % Run & save as single (single much faster on GPU)
if ~isfield(o,'singleOut');   o.singleOut=[]; end      % Run as double (accuracy) & save as single (small filesize)
if ~isfield(o,'doGPU');       o.doGPU=0; end           % Run on GPU, see MATLAB gpuArray requirements (default=false)
% if ~isfield(o,'GPUmex');      o.GPUmex=false; end
% if ~isfield(o,'norm');        o.norm=false; end         % Convert absolute values (log-normal) to normal distribution

%% Setup & initialize
tic; errors={};

% Make workspace vars
fMean=logical(o.fMean); dsTarg=o.dsTarg; singleOut=logical(o.singleOut); doGPU=o.doGPU;

% Load EEG data
if isempty(x)
    if arg.ica && o.sfx_src==""; o.sfx_src="i"; end
    [n,x,~,~,chNfo] = ec_loadSbj(dirs,o.sfx_src);
end
if arg.test; xOg = x; end %#ok<NASGU>

% Load metadata
sbjID = n.sbjID;
nChs = width(x);
nRuns = n.nRuns;
blocks = string(n.blocks);
fsOg = floor(n.fs_orig);
n.task = task;
n.suffix = o.suffix;
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
if ~isfield(o,'dirOut'); o.dirOut=dirs.procSbj; end % Output directory
if ~isfield(o,'fnStr');  o.fnStr="s"+sbjID+"_"+task+".mat"; end % Filename ending string

% Find best values for missing inputs
if isa(x,'single') && ~isempty(o.single) && ~o.single; x=double(x);
    if isempty(singleOut); singleOut=true; end;end % convert single to double
if isa(x,'single') || o.single; singleIn=true; else; singleIn=false; end
if isempty(singleOut); if ~fMean||singleIn; singleOut=true; else; singleOut=false; end;end

% Convert to single if specified
if singleIn; x = single(x); end

% Get downsampling factor & anti-aliasing filter
if ~isempty(dsTarg)
    [ds1,ds2] = rat(dsTarg/fsOg);
    if ds1>ds2; error(sbj+" downsampling target > iEEG sampling rate"); end
else
    ds1=1; ds2=1;
end

% Reset GPU & get free VRAM
if doGPU
    if ~isempty(gcp('nocreate')); parfevalOnAll(@gpuDevice,0,[]); delete(gcp('nocreate')); end
	try reset(gpuDevice()); catch; end
    memMax=gpuDevice().AvailableMemory;
else
    try parpool('threads'); catch;end
end
if doGPU==1 
    fMean=gpuArray(fMean); ds1=gpuArray(ds1); ds2=gpuArray(ds2); singleOut=gpuArray(singleOut);
end

% Reshape per run
x = mat2cell(x,n.runIdxOg(:,2));


%% Continuous Wavelet Transform with L1-norm for 1/freq decay
cwtHz = cell(nRuns,1);
for r = 1:nRuns % CWT within-run (avoid edge artifacts at run transitions)
    if arg.test; tic; end
    % Get block iEEG data
    xr=x{r}; run=blocks(r); rLength=height(xr);
    xr = arrayfun(@(ch) xr(:,ch,:), 1:nChs, UniformOutput=false); 

    % Generate wavelet filters
    fb = cwtfilterbank(SignalLength=rLength,VoicesPerOctave=o.fVoices,...
        SamplingFrequency=fsOg,FrequencyLimits=o.fLims);
    cwtHz{r} = fb.centerFrequencies';

    %% Do CWT
    if ~doGPU
        % CPU parfor loop (slower, no GPU required)
        parfor ch = 1:nChs
            xr{ch} = cwt_lfn(fb,xr{ch},fMean,ds1,ds2,false);
        end
        disp("[ec_preprocTimeFreq] CPU wavelet transformed: "+sbj+" "+run+" time="+toc);
    elseif doGPU > 0
        %% Find number of chans that fit in GPU RAM
        memIn=whos("xr").bytes/nChs; nFrqs=numel(cwtHz{r});
        if fMean; memIn=memIn*nFrqs*.25; else; memIn=memIn*nFrqs; end
        if ds2>ds1; memIn = memIn*(ds1/ds2)*(ds2/4); end
        memChs=floor(memMax/memIn); memItr=ceil(nChs/memChs); memChs=ceil(nChs/memItr);
        disp("[ec_preprocTimeFreq] gpuArrayFun start: "+sbj+" "+run+" memChs="+gather(memChs)+"/"+nChs+" time="+toc);

        % GPU arrayfun (fast, requires Nvidia GPU)
        chFin=gpuArray(false(nChs,1)); memChs=gpuArray(memChs); memItr=gpuArray(memItr);
        for v = 1:memItr
            idx = find(~chFin,memChs);
            xr(idx) = arrayfun(@(x) gpuArray(x{:}),xr(idx),UniformOutput=false);
            xr(idx) = arrayfun(@(x) cwt_lfn(fb,x{:},fMean,ds1,ds2,singleOut),...
                xr(idx),UniformOutput=false);
            xr(idx) = cellfun(@gather,xr(idx),UniformOutput=false);
            chFin(idx) = true;
        end
        xr = cellfun(@gather,xr,UniformOutput=false);
        disp("[preprocTimeFreq] gpuArrayFun finished: "+sbj+" "+run+" time="+toc);
    end

    % Reshape % concactenate
    if iscell(xr)
        if fMean; xr = horzcat(xr{:});
        else; xr = permute(cat(3,xr{:}),[1 3 2]); end
    end

    % Copy to main
    x{r} = xr; disp("[preprocTimeFreq] Finished CWT loop: "+sbj+" "+run+" time="+toc);
end
if doGPU; ds2=gather(ds2); fMean=gather(fMean); end

%% Organize & clear memory
x = vertcat(x{:});
if ~fMean
    x = flip(x,3); % Sort freqs from low to high
end
n.xFrames = size(x,1);
n.xChs = size(x,2);
n.nFreqs = size(x,3);
n.freqs = flip(cwtHz{1});
n.freqsRun = vertcat(cwtHz{:});

% Resample behavioral data
[err,o,n] = ec_initialize(sbj,task,o,n,dirs=dirs,save=arg.save,ica=arg.ica,...
    dsTarg=o.dsTarg);
if isany(err); errors{end+1}=err; end

%% Robust detrending
if nnz(o.detrendOrder)
    [x,n] = ec_detrend(x,n,order=o.detrendOrder,thr=o.detrendThr,itr=o.detrendItr,win=o.detrendWin,...
        missing=o.missingInterp,gpu=o.detrendGPU,single=o.detrendSingle,sfx=sfx);
end

%% High-pass filtering
if nnz(o.hiPass)
    [x,n] = ec_HPF(x,n,o.hiPass,tt,missing=o.missingInterp,gpu=o.hiPassGPU,...
        steepness=o.hiPassSteep);
end

%% Identify bad frames per chan
if o.doBadFrames && ~arg.ica
    % Retain HFO
    if any(n.xBad.Properties.VariableNames=="hfo")
        x_bad = n.xBad(:,"hfo");
        if ds2>1
            hfo = resample(double(full(x_bad.hfo)),ds1,ds2,'Dimension',1);
            x_bad.hfo = sparse(hfo>=0.5);
        end
    else
        x_bad = table;
    end

    % Identify
    [chNfo.bad,x_bad] = ec_findBadFrames(x,chNfo.bad,x_bad,sfx,...
        mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);
    n.xBad = x_bad;
    disp("[preprocTimeFreq] Identified bad frames per chan: "+sbj+" time="+toc);
elseif o.doBadFrames
    [n.icBad,n.xBad] = ec_findBadFrames(x,n.icBad,n.xBad,sfx,mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);
    disp("[preprocTimeFreq] Identified bad frames per IC: "+sbj+" time="+toc);
end

%% Covariance
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

%% Finalize
% Convert to single if specified
if singleOut; x = single(x); end

% Reset GPU
if doGPU
	if ~isempty(gcp('nocreate')); parfevalOnAll(@gpuDevice,0,[]); end
	try reset(gpuDevice()); catch; end
end

% Save
if arg.save
    % Save chNfo
    if o.doBadFrames && ~arg.ica
        fn = o.dirOut+"chNfo_"+o.fnStr;
        save(fn,'chNfo','-v7'); disp("SAVED: "+fn);
    end

    % Save n struct
    fn = o.dirOut+"n"+sfx+"_"+o.fnStr;
    save(fn,"n","-v7"); disp("SAVED: "+fn);

    % Save processed iEEG data
    fn = o.dirOut+"x"+sfx+"_"+o.fnStr;
    savefast(fn,'x'); disp("SAVED: "+fn+" time="+toc);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Continuous Wavelet Transform - local function
function xx = cwt_lfn(fb,xx,fMean,ds1,ds2,singleOut)
if ~fMean
    % CWT: magnitude (absolute value of each frame & freq)
    xx = abs(fb.wt(xx))'; % wt(frames,freqs)
else
    % CWT: normalized average density (weighted integral normed by variance)
    xx = fb.scaleSpectrum(xx,SpectrumType="density")'; % wt(frames,1)
end

% Downsample
if ds2 > ds1
    xx = resample(xx,ds1,ds2);
end

% Convert to single
if singleOut
    xx = single(xx);
end



%% Depreciated
% %% Normalize & downsample if not yet applied
% if ds2>ds1 && length(xr{1})>=rLength
%     if isa(xr{1},'single'); xr=cellfun(@double,xr,UniformOutput=false); end
%     xr = arrayfun(@(xx) resample(xx{:},ds1,ds2),xr,UniformOutput=false);
%     if singleIn||singleOut; xr=cellfun(@single,xr,UniformOutput=false); end
%     disp("Downsampled (CPU): "+sbj+" "+run+" time="+toc);
% end
