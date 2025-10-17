function [errors,n,x] = ec_connWTC(sbj,task,o,n,x,arg)
%% electroCUDA: wavelet coherence analysis (DEPRECIATED!)
%   succeeded by 'ec_connWC'
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
    arg.dirs struct = [] % Directory paths struct
    arg.ica logical = false % Input data from ICA?
    arg.save logical = false
    arg.test logical = false
    arg.redoN logical = false
end
dirs = arg.dirs;
% n=[]; x=[]; o=os; arg.ica=0; arg.save=0; arg.test=1;


%% Options validation
if sbj==""; sbj = o.sbj; end
if task==""; task = o.task; end
if ~isstruct(dirs); dirs = ec_getDirs(dirs,sbj,task); end

% Options struct
if ~isfield(o,'fName');       o.fName="spec"; end     % Name of frequency analysis
if ~isfield(o,'fLims');       o.fLims=[1 300]; end    % Frequency limits in hz; HFB=[70 200]
if ~isfield(o,'fVoices');     o.fVoices=12; end       % Voices per octave (default=10, HFB=18)
if ~isfield(o,'hzTarget');      o.hzTarget=[]; end        % Downsample target in Hz (default=[]: no downsample)
if ~isfield(o,'single');      o.single=true; end      % Run & save as single (single much faster on GPU)
if ~isfield(o,'singleOut');   o.halfOut=true; end     % Save as half-precision float (16-bit) to save memory
if ~isfield(o,'doCUDA');      o.doCUDA=false; end     % Run on CUDA GPU binary - must be compiled 1st! (ecu_compileThese)
if ~isfield(o,'doGPU');       o.doGPU=false; end      % Run on MATLAB gpuArray (superseded by CUDA)
% if ~isfield(o,'norm');        o.norm=false; end         % Convert absolute values (log-normal) to normal distribution
if o.doCUDA; o.doGPU=false; end % CUDA supersedes gpuArray

%% Setup & initialize
tic; errors={};

% Load EEG data
if isempty(x) || arg.test
    if arg.ica && o.suffix==""; o.suffix="i"; end
    [n,x,~,~,chNfo] = ec_loadSbj(dirs,o.suffix);
end
if arg.test; xOg=x; chNfoOg=chNfo; end %#ok<NASGU>

% Convert to single-precision
if o.single; x=single(x); end

% Load metadata
sbjID = n.sbjID;
nRuns = n.nRuns;
n.task = task;
n.suffix = o.suffix;
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
if ~isfield(o,'dirOut'); o.dirOut=dirs.procSbj; end % Output directory
if ~isfield(o,'fnStr');  o.fnStr="s"+sbjID+"_"+task+".mat"; end % Filename ending string

% Get downsampling factor & anti-aliasing filter
ds = [1 1];
if ~isempty(o.hzTarget)
    [ds(1),ds(2)] = rat(o.hzTarget/n.fs);
    if ds(1)>ds(2); error(sbj+" downsampling target > iEEG sampling rate"); end
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
if o.doGPU
    if ~isempty(gcp('nocreate')); parfevalOnAll(@gpuDevice,0,[]); delete(gcp('nocreate')); end
    try reset(gpuDevice()); catch; end
    memMax = gpuDevice().AvailableMemory; % see available vram
else
    try ppool = parpool('process'); catch;end %#ok<NASGU>
    memMax = ec_ramAvail;
end

% Reshape per run
x = mat2cell(x,n.runIdxOg);
y = cell(nRuns,1);
cwtHz = cell(nRuns,1);
disp("[ec_wtc] Starting WTC: s"+n.sbjID+" time="+toc);


%% Wavelet coherence (within-run to avoid edge artifacts)
for r = 1:nRuns
    % Get frequencies
    cwtHz{r} = cwtfilterbank(SignalLength=height(x{r}),VoicesPerOctave=o.fVoices,...
        SamplingFrequency=n.fs,FrequencyLimits=o.fLims,Wavelet="amor");
    cwtHz{r} = cwtHz{r}.centerFrequencies';
    nFrqs = numel(cwtHz{r});

    % Do wavelet coherence
    [x{r},y{r}] = withinRun_lfn(x{r},cc,n,o,ds,nFrqs,r,memMax);
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




%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%% Wavelet coherence within-run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xr,yr] = withinRun_lfn(xr,cc,n,o,ds,nFrqs,r,memMax)
tic;
run=n.runs(r); sbj=n.sbjID;
if o.doCUDA
    % CUDA GPU binaries (fastest)
    disp("[ec_wtc] CUDA GPU binary start: s"+sbj+"_r"+run+" time="+toc);
    if o.single
        [xr,yr] = ec_wtcc_fp32(xr,cc{:,1:2},n.fs,o.fLims,o.fVoices,ds); % Single-precision
    else 
        [xr,yr] = ec_wtcc_fp64(xr,cc{:,1:2},n.fs,o.fLims,o.fVoices,ds); % Double-precision
    end
    disp("[ec_wtc] CUDA GPU binary finished: s"+sbj+"_r"+run+" time="+toc);
elseif o.doGPU
    % gpuArrays (fast)
    [xr,yr] = gpuArrayWT_lfn(xr,cc,n,o,ds,nFrqs,run,memMax);
else
    % CPU parfor loop (slower)
    [xr,yr] = cpuParforWT_lfn(xr,cc,ds,n.fs,o.fLims,o.fVoices,n.sbjID,run);
end

%% Reshape & concactenate
xr = permute(cat(3,xr{:}),[1 3 2]);
yr = permute(cat(3,yr{:}),[1 3 2]);
disp("[ec_wtc] Finished WTC: s"+n.sbjID+"_r"+run+" time="+toc);



%%% gpuArrayFun WT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xx,yy] = gpuArrayWT_lfn(xr,cc,n,o,ds,nFrqs,run,memMax)
tic;
% Get vars
nPairs=height(cc); c1=cc.i1; c2=cc.i2; xx=cell(1,nPairs); yy=xx;

% Calculate simultaneous iterations that fit in VRAM
mIn = whos("xr").bytes/width(xr);
mIn = mIn*nFrqs*2;
if ds(2)>ds(1); mIn = mIn*(ds(1)/ds(2))*(ds(2)/4); end
mItr = ceil(nPairs/floor(memMax/mIn));
mPairs = ceil(nPairs/mItr);

% Load to GPU
xr=gpuArray(xr); pFin=gpuArray(false(nPairs,1)); mItr=gpuArray(mItr);
disp("[ec_wtc] gpu_lfn start: s"+n.sbjID+"_r"+run+" pairs="+mPairs+"/"+nPairs+" time="+toc);

%% Loop across gpuArrayFun iterations
for v = 1:mItr
    % Find unfinished pairs to do simultaneously
    idx = find(~pFin,mPairs);

    % Run wavelet coherence - vectorized (arrayfun)
    [xx(idx),yy(idx)] = arrayfun(@(i1,i2) wtc_lfn(xr(:,i1),xr(:,i2),n.fs,...
        o.fLims,o.fVoices,ds(1),ds(2)), c1(idx),c2(idx),UniformOutput=false);

    % Move to CPU
    xx(idx) = cellfun(@gather,xx(idx),UniformOutput=false);
    yy(idx) = cellfun(@gather,yy(idx),UniformOutput=false);
    pFin(idx) = true;
end

% Make sure moved to CPU
xx = cellfun(@gather,xx(idx),UniformOutput=false);
yy = cellfun(@gather,yy(idx),UniformOutput=false);
disp("[ec_wtc] gpu_lfn end: s"+n.sbjID+"_r"+run+" time="+toc);



%%% CPU parallel loop WT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xx,yy] = cpuParforWT_lfn(xr,cc,ds,fs,fLims,fVoices,sbj,run)
tic;
nPairs=height(cc); c1=cc.i1; c2=cc.i2; xx=cell(1,nPairs); yy=xx;

% Run wavelet coherence - parallel loop
disp("[ec_wtc] CPU parfor start: s"+sbj+"_r"+run+" time="+toc);
parfor p = 1:nPairs
    [xx{p},yy{p}] = wtc_lfn(xr(:,c1(p)),xr(:,c2(p)),fs,fLims,...
        fVoices,ds); %#ok<PFBNS>
end
disp("[ec_wtc] CPU parfor end: s"+sbj+"_r"+run+" time="+toc);



%%% Wavelet coherence - local function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,y] = wtc_lfn(x,y,fs,fLims,fVoices,ds)
% Calculate wavelet coherence
[x,y] = wcoherence(x,y,fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);

% Downsample
if ds(2) > ds(1)
    x = resample(x,ds(1),ds(2),Dimension=2);
    y = resample(y,ds(1),ds(2),Dimension=2);
end

% Convert wavelet to phase angle
y = angle(y);