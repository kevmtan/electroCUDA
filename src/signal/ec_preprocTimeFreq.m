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
    arg.redoN logical = true
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
if ~isfield(o,'doGPU');       o.doGPU=false; end       % Run on GPU, see MATLAB gpuArray requirements (default=false)
if ~isfield(o,'GPUmex');      o.GPUmex=false; end
if ~isfield(o,'norm');        o.norm=true; end         % Convert absolute values (log-normal) to normal distribution
% Make workspace vars
fMean=logical(o.fMean); dsTarg=o.dsTarg; singleOut=logical(o.singleOut); doNorm=logical(o.norm);
doGPU=logical(o.doGPU); GPUmex=logical(o.GPUmex);

%% Setup & initialize
tic;
% Load metadata
[errors,o,n,chNfo] = ec_initialize(sbj,task,o,n,ica=arg.ica,dirs=dirs,save=0,redoN=arg.redoN);
sbjID = n.sbjID;
nRuns = n.nRuns;
runIdx = n.runIdx;
blocks = string(n.blocks);
fsOg = floor(n.fs_orig);
n.task = task;
n.suffix = o.suffix;
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
if ~isfield(o,'dirOut'); o.dirOut=dirs.procSbj; end % Output directory
if ~isfield(o,'fnStr');  o.fnStr="s"+sbjID+"_"+task+".mat"; end % Filename ending string

% Load EEG data
if isempty(x)
    if arg.ica && o.sfx_src==""; o.sfx_src="i"; end
    x = ec_loadSbj(dirs,o.sfx_src,"x");
end

% Find best values for missing inputs
if isa(x,'single') && ~isempty(o.single) && ~o.single; x=double(x);
    if isempty(singleOut); singleOut=true; end;end % convert single to double
if isa(x,'single') || o.single; singleIn=true; else; singleIn=false; end
if isempty(singleOut); if ~fMean||singleIn; singleOut=true; else; singleOut=false; end;end
nChs = size(x,2);

% Get downsampling factor & anti-aliasing filter
if ~isempty(dsTarg)
    [ds1,ds2] = rat(dsTarg/fsOg);
    if ds1>ds2; error(sbj+" downsampling target > iEEG sampling rate"); end
else
    ds1=1; ds2=1;
end

% Reset GPU & get free VRAM
if doGPU && ~GPUmex
    if ~isempty(gcp('nocreate')); parfevalOnAll(@gpuDevice,0,[]); delete(gcp('nocreate')); end
    try reset(gpuDevice()); catch;end; memMax=gpuDevice(); memMax=memMax.AvailableMemory;
elseif ~doGPU
    try parpool('threads'); catch;end
end

%% Continuous Wavelet Transform with L1-norm for 1/freq decay
xa = cell(nRuns,1);
cwtHz = xa;
for r = 1:nRuns % CWT within-run (avoid edge artifacts at run transitions)
    if arg.test; tic; end
    % Get block iEEG data
    idx = runIdx(r,1):runIdx(r,2);
    rLength = length(idx);
    run = blocks(r);
    xr = x(idx,:);
    if o.single; xr = single(xr); end
    xr = num2cell(xr,1);

    % Generate wavelet filters
    fb = cwtfilterbank(SignalLength=rLength,VoicesPerOctave=o.fVoices,...
        SamplingFrequency=fsOg,FrequencyLimits=o.fLims);
    cwtHz{r} = fb.centerFrequencies';

    %% Do CWT
    if ~doGPU
        % CPU parfor loop (slower, no GPU required)
        parfor ch = 1:nChs
            xr{ch} = cwt_lfn(fb,xr{ch},fMean,doNorm,1,1,singleIn,false);
        end
        disp("Wavelet transformed (CPU): "+sbj+" "+run+" time="+toc);
    else
        % CWT using GPUarray (fasteer, requires nVidia CUDA GPU)
        memIn=xr{1}; memIn=whos('memIn'); memIn=memIn.bytes; nFrqs=numel(cwtHz{r}); %#ok<NASGU>
        if fMean; memIn=.25*memIn*nFrqs; else; memIn=2*memIn*nFrqs; end
        if ~singleIn && ds2>ds1; memIn=memIn*(ds1/ds2*2); end
        if ~singleIn && singleOut; memIn=memIn*.6; end % numChans that fit in VRAM
        memChs=floor(memMax/memIn); memItr=ceil(nChs/memChs); memChs=ceil(nChs/memItr);
        fMean=arrayfun(@(f) f==1,gpuArray(fMean)); doNorm=gpuArray(doNorm);
        singleIn = gpuArray(singleIn); singleOut=gpuArray(singleOut);
        ds1=gpuArray(ds1); ds2=gpuArray(ds2); chFin=false(nChs,1);

        % gpuArray iterations with numChans that fit in VRAM
        disp("Starting wavelet transform (GPUarray): "+sbj+" "+run+" memChs="+memChs+"/"+nChs+" time="+toc);
        for v = 1:memItr
            idx=find(~chFin,memChs);
            xr(idx) = cellfun(@gpuArray,xr(idx),UniformOutput=false);
            xr(idx) = arrayfun(@(xx) cwt_lfn(fb,xx{:},fMean,doNorm,...
                ds1,ds2,singleIn,singleOut),xr(idx),UniformOutput=false);
            xr(idx) = cellfun(@gather,xr(idx),UniformOutput=false);
            chFin(idx) = true;
            disp("Wavelet transformed (GPU): "+sbj+" "+run+" "+idx(end)+"/"+nChs+" time="+toc);
        end
        xr=cellfun(@gather,xr,UniformOutput=false);
        ds1=gather(ds1); ds2=gather(ds2); singleIn=gather(singleIn); singleOut=gather(singleOut);
        doNorm=gather(doNorm); fMean=gather(fMean);
    end

    %% Normalize & downsample if not yet applied
    if ds2>ds1 && length(xr{1})>=rLength
        if isa(xr{1},'single'); xr=cellfun(@double,xr,UniformOutput=false); end
        xr = arrayfun(@(xx) resample(xx{:},ds1,ds2),xr,UniformOutput=false);
        if singleIn||singleOut; xr=cellfun(@single,xr,UniformOutput=false); end
        disp("Downsampled (CPU): "+sbj+" "+run+" time="+toc);
    end

    % Reshape & concactenate
    if fMean
        xr = horzcat(xr{:});
    else
        xr = permute(cat(3,xr{:}),[1 3 2]);
    end

    % Copy to main
    xa{r} = xr;
    if ~arg.test; clear xr; end
    disp("Finished wavelet transform: "+sbj+" "+run+" time="+toc);
end

%% Organize & clear memory
x = vertcat(xa{:}); if ~arg.test; clear xa; end
if ~fMean
    x = flip(x,3); % Sort freqs from low to high
end
n.xFrames = size(x,1);
n.xChs = size(x,2);
n.nFreqs = size(x,3);
n.freqs = flip(cwtHz{1});
n.freqsRun = vertcat(cwtHz{:});

% Resample n indices
[err,o,n] = ec_initialize(sbj,task,o,n,dirs=dirs,save=arg.save,ica=arg.ica,...
    dsTarg=o.dsTarg);
if isany(err); errors{end+1}=err; end

%% Robust detrending
if nnz(o.detrendOrder)
    [n,x] = ec_detrend(n,x,order=o.detrendOrder,thr=o.detrendThr,itr=o.detrendItr,win=o.detrendWin,...
        missing=o.missingInterp,gpu=o.detrendGPU,single=o.detrendSingle,sfx=sfx);
end

%% High-pass filtering
if nnz(o.hiPass) 
    [n,x] = ec_HPF(n,x,tt,hpf=o.hiPass,missing=o.missingInterp,gpu=o.hiPassGPU,sfx=sfx);
end

%% Identify bad frames per chan
if o.doBadFrames && ~arg.ica
    % Retain HFO
    if any(n.xBad.Properties.VariableNames=="hfo")
        x_bad = n.xBad(:,"hfo");
        if ds2>1
            hfo = resample(double(full(x_bad.hfo)),ds1,ds2,'Dimension',2);
            x_bad.hfo = sparse(hfo>=0.5);
        end
    else
        x_bad = table;
    end

    % Identify
    [chNfo.bad,x_bad] = ec_findBadFrames(x,chNfo.bad,x_bad,sfx,...
        mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);
    n.xBad = x_bad;
    disp("Identified bad frames per chan: "+sbj+" time="+toc);
elseif o.doBadFrames
    [n.icBad,n.xBad] = ec_findBadFrames(x,n.icBad,n.xBad,sfx,mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);
    disp("Identified bad frames per IC: "+sbj+" time="+toc);
end

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
function xx = cwt_lfn(fb,xx,fMean,doNorm,ds1,ds2,singleIn,singleOut)
% Do CWT
if ~fMean
    % Real-valued power (magnitude absolute value squared)
    xx = abs(fb.wt(xx)).^2'; % wt(frames,freqs)
else
    % Normalized average density (weighted integral normed by variance)
    xx = fb.scaleSpectrum(xx,SpectrumType="density")'; % wt(frames,1)
end

% Downsample
if ds2>ds1 && ~singleIn
    xx = resample(xx,ds1,ds2); % doesn't work in parfor loop
end

% Absolute values (log-norm) to normal distribution
if doNorm
    xx = ec_abs2norm(xx,scale="robust");
end

% Convert to single
if singleOut && ~singleIn
    xx = single(xx);
end

%% Depreciated
% if ~arg.ica
%     sbjChs=chNfo.sbjCh;
% else
%     sbjChs=n.icNfo.sbjIC;
% end