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
    x (:,:) {isfloat} = [] % preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
    arg.dirs struct = [] % Directory paths struct
    arg.ica (1,1) logical = false
    arg.raw (1,1) logical = false
    arg.save (1,1) logical = false
    arg.test (1,1) logical = false
    arg.redoN (1,1) logical = false
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
if ~isfield(o,'single');      o.single=true; end      % Run & save as single (single much faster on GPU)
if ~isfield(o,'singleOut');   o.halfOut=true; end     % Save as half-precision float (16-bit) to save memory
if ~isfield(o,'doCUDA');      o.doCUDA=false; end     % Run on CUDA GPU binary - must be compiled 1st! (ecu_compileThese)
if ~isfield(o,'doGPU');       o.doGPU=false; end      % Run on MATLAB gpuArray (superseded by CUDA)
% if ~isfield(o,'norm');        o.norm=false; end         % Convert absolute values (log-normal) to normal distribution
if o.doCUDA; o.doGPU=false; end % CUDA supersedes gpuArray

%% Setup & initialize
tic; errors={};

% Make workspace vars
fMean=logical(o.fMean); dsTarg=o.dsTarg;

% Load EEG data
if isempty(x)
    if arg.ica && o.sfx_src==""; o.sfx_src="i"; end
    [n,x,~,~,chNfo] = ec_loadSbj(dirs,o.sfx_src);
end
if arg.test; xOg = x; end %#ok<NASGU>
if o.single; x = single; end

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

% Get downsampling factor & anti-aliasing filter
ds = [1 1];
if ~isempty(dsTarg)
    [ds(1),ds(2)] = rat(dsTarg/fsOg);
    if ds(1)>ds(2); error(sbj+" downsampling target > iEEG sampling rate"); end
end

% Reset GPU & get free VRAM
if o.doGPU || o.doCUDA
    if ~isempty(gcp('nocreate')); parfevalOnAll(@gpuDevice,0,[]); delete(gcp('nocreate')); end
	try reset(gpuDevice()); catch; end
    memMax = ec_ramAvail(true);
else
    try parpool('threads'); catch;end
    memMax = ec_ramAvail;
end

% Reshape per run
x = mat2cell(x,n.runIdxOg(:,2));


%% Continuous Wavelet Transform with L1-norm for 1/freq decay
cwtHz = cell(nRuns,1);
for r = 1:nRuns
    % CWT within-run (avoid edge artifacts at run transitions)
    run = blocks(r);
    [x{r},cwtHz{r}] = withinRun_lfn(x{r},n,o,ds,run,memMax);
    disp("[preprocTimeFreq] Finished CWT loop: "+sbj+" "+run+" time="+toc);
end

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
        if ds(2)>1
            hfo = resample(double(full(x_bad.hfo)),ds(1),ds(2),'Dimension',1);
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
if o.singleOut; x = single(x); end

% Reset GPU
if o.doGPU
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




%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%% CWT within-run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,frqs] = withinRun_lfn(xr,n,o,ds,run,memMax)

% Get vars
nChs=width(xr); sbj=n.sbj; fMean=o.fMean; singleOut=o.singleOut;

% Single
if o.single
    xr = single(xr);
else
    xr = double(xr);
end

%% CWT per channel
if o.doCUDA
    % CUDA GPU binary (fastest)
    if fMean
        if o.single
            [xr,frqs] = ec_cwtAvg_fp32(xr,fs,o.fLims,o.fVoices,ds);
        else
            [xr,frqs] = ec_cwtAvg_fp64(xr,fs,o.fLims,o.fVoices,ds);
        end
    else
        if o.single
            [xr,frqs] = ec_cwt_fp32(xr,fs,o.fLims,o.fVoices,ds);
        else
            [xr,frqs] = ec_cwt_fp64(xr,fs,o.fLims,o.fVoices,ds);
        end
    end

    if singleOut
        xr = cellfun(@single,xr,UniformOutput=false);
    end
else
    % Generate wavelet filters
    fb = cwtfilterbank(SignalLength=height(xr),VoicesPerOctave=o.fVoices,...
        SamplingFrequency=n.fs_orig,FrequencyLimits=o.fLims);
    frqs = fb.centerFrequencies';
    nFrqs = numel(frqs);

    % Convert to cell per chan
    xr = arrayfun(@(ch) xr(:,ch), 1:nChs, UniformOutput=false);

    if o.doGPU
        % Matlab gpuArrays (fast)
        xr = gpuArrayFun_lfn(xr,fb,n,o,ds,run,nFrqs,memMax);
    else
        % CPU parfor loop (slower, no GPU required)
        tic;
        parfor ch = 1:nChs
            xr{ch} = cwt_lfn(fb,xr{ch},fMean,ds,singleOut);
        end
        disp("[ec_preprocTimeFreq] CPU wavelet transformed: "+sbj+" "+run+" time="+toc);
    end
end

%% Finalize

% Reshape & concactenate
if iscell(xr)
    if fMean; xr = horzcat(xr{:});
    else; xr = permute(cat(3,xr{:}),[1 3 2]); end
end

if singleOut
    xr = single(xr);
end



%%% Run CWT on gpuArrayFun %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xr = gpuArrayFun_lfn(xr,fb,n,o,ds,run,nFrqs,memMax)
tic;
% Get vars
nChs=numel(xr); sbj=n.sbj;

% Find number of chans that fit in GPU RAM
memIn = whos("xr").bytes/nChs; 
if o.fMean; memIn=memIn*nFrqs*.25; else; memIn=memIn*nFrqs; end
if ds(2)>ds(1); memIn = memIn*(ds(1)/ds(2))*(ds(2)/4); end
memChs=floor(memMax/memIn); memItr=ceil(nChs/memChs); memChs=ceil(nChs/memItr);
disp("[ec_preprocTimeFreq] gpuArrayFun start: "+sbj+" "+run+" memChs="+gather(memChs)+"/"+nChs+" time="+toc);

% Move to GPU
ds=gpuArray(ds); fMean=gpuArray(o.fMean); singleOut=gpuArray(o.singleOut);
chFin=gpuArray(false(nChs,1)); memChs=gpuArray(memChs); memItr=gpuArray(memItr);

% CWT gpuArrayFun across channels
for v = 1:memItr
    % Find chans to do 
    idx = find(~chFin,memChs);

    % Move ch data to GPU
    xr(idx) = arrayfun(@(x) gpuArray(x{:}),xr(idx),UniformOutput=false);

    % Run CWT
    xr(idx) = arrayfun(@(x) cwt_lfn(fb,x{:},fMean,ds,singleOut),...
        xr(idx),UniformOutput=false);

    % Move to CPU
    xr(idx) = cellfun(@gather,xr(idx),UniformOutput=false);
    chFin(idx) = true;
end
xr = cellfun(@gather,xr,UniformOutput=false);
disp("[preprocTimeFreq] gpuArrayFun finished: "+sbj+" "+run+" time="+toc);



%%% Continuous Wavelet Transform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xx = cwt_lfn(fb,xx,fMean,ds,singleOut)
if ~fMean
    % CWT: magnitude (absolute value of each frame & freq)
    xx = abs(fb.wt(xx))'; % wt(frames,freqs)
else
    % CWT: normalized average density (weighted integral normed by variance)
    xx = fb.scaleSpectrum(xx,SpectrumType="density")'; % wt(frames,1)
end

% Downsample
if ds(2) > ds(1)
    xx = resample(xx,ds(1),ds(2));
end

% Convert to single
if singleOut
    xx = single(xx);
end



%% Depreciated
% %% Normalize & downsample if not yet applied
% if ds(2)>ds(1) && length(xr{1})>=rLength
%     if isa(xr{1},'single'); xr=cellfun(@double,xr,UniformOutput=false); end
%     xr = arrayfun(@(xx) resample(xx{:},ds(1),ds(2)),xr,UniformOutput=false);
%     if singleIn||singleOut; xr=cellfun(@single,xr,UniformOutput=false); end
%     disp("Downsampled (CPU): "+sbj+" "+run+" time="+toc);
% end
