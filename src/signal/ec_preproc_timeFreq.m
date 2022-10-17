function [errors,n,x] = ec_preproc_timeFreq(sbj,proj,o,n,x,arg)
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
end
dirs=arg.dirs;
% sbj='S12_38_LK'; proj='MMR'; n=[]; x=[];
% arg.ica=0; arg.raw=0; arg.save=0; arg.test=1;
% o=oSpec; o=oHFB;

%% Options struct validation (non-exhaustive, see individual functions below)
if ~isstruct(dirs); dirs = ec_getDirs(dirs,sbj,proj); end

% Options
if ~isfield(o,'fName');       o.fName="hfb"; end       % Name of frequency analysis
if ~isfield(o,'fLims');       o.fLims=[60 180]; end    % Frequency limits in hz; HFB=[70 200]
if ~isfield(o,'fMean');       o.fMean=true; end        % Collapse across frequency bands (for 1d vector output)
if ~isfield(o,'fVoices');     o.fVoices=32; end        % Voices per octave (default=10, HFB=18)
if ~isfield(o,'dsTarg');      o.dsTarg=[]; end         % Downsample target in Hz (default=[]: no downsample)
if ~isfield(o,'single');      o.single=[]; end         % Convert to double to single (single much faster on GPU)
if ~isfield(o,'thrSpec');     o.thrSpec=15; end        % Threshold for averaged spectral data (e.g. HFB) (z-score threshold relative to all data points) to exclude timepoints
if ~isfield(o,'doGPU');       o.doGPU=false; end       % Run on GPU, see MATLAB gpuArray requirements (default=false)
if ~isfield(o,'doGPUarray');  o.doGPUarray=true; end   % Use arrayfun for GPU (faster, more memory)
if ~isfield(o,'gatherOut');   o.gatherOut=false; end
if isempty(o.single); if o.doGPU; o.single=true; else; o.single=false; end; end
% Make workspace vars
doGPU=o.doGPU; fMean=o.fMean; dsTarg=o.dsTarg; doSingle=o.single; doGPUarray=o.doGPUarray;
gatherOut=o.gatherOut;

%% Setup
tic;
% Load metadata
[errors,o,n,chNfo] = ec_initialize(sbj,proj,o,n,ica=arg.ica,dirs=dirs,save=0,redoN=1);
sbjID = n.sbjID;
nRuns = n.nRuns;
runIdx = n.runIdx;
blocks = string(n.blocks);
fsOg = floor(n.fs_orig);
n.proj = proj;
if ~arg.ica
    sbjChs=chNfo.sbjCh;
else
    sbjChs=n.icNfo.sbjIC;
end
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
if ~isfield(o,'dirOut'); o.dirOut=dirs.data+"/robust/s"+sbjID+"/"+proj+"/"; end % Output directory
if ~isfield(o,'fnStr');  o.fnStr="s"+sbjID+"_"+proj+".mat"; end % Filename ending string
if ~doGPU; try parpool('threads'); catch;end;end

%% Load EEG data
if isempty(x)
    if arg.ica; fn=o.dirOut+"xi_"+o.fnStr; else; fn=o.dirOut+"x_"+o.fnStr; end
    if isfile(fn) && ~arg.raw
        load(fn,"x"); disp("LOADED: "+fn);
    else
        [errPreproc,n,x] = robust_preproc(sbj,proj,o,save=0,dirs=dirs);
        if nnz(~cellfun(@isempty,errPreproc)); errors{end+1}=errPreproc; end 
    end
end
nChs = size(x,2);

% Get downsampling factor & anti-aliasing filter
if ~isempty(dsTarg)
    [ds1,ds2] = rat(dsTarg/fsOg);
    if ds1>ds2; error(sbj+" downsampling target > iEEG sampling rate"); end
else; ds1=1; ds2=1;
end

% Transfer vars to GPU
if doGPU; fMean=gpuArray(logical(fMean)); gatherOut=gpuArray(logical(gatherOut)); end
if ~doGPU; try parpool('threads'); catch;end;end


%% Continuous Wavelet Transform (L1 normalization for 1/f decay)
xf = cell(nRuns,1);
cwtHz = xf;
for b = 1:nRuns % CWT within blocks (avoid artifacts at block transitions)
    idx = runIdx(b,1):runIdx(b,2);
    bLength = length(idx);
    block = blocks(b);

    % Get block iEEG data
    xa = x(idx,:);
    xb = cell(1,nChs);
    %if doSingle; xa = single(xa); end

    % Get CWT filter
    fb = cwtfilterbank(SignalLength=bLength,VoicesPerOctave=o.fVoices,...
        SamplingFrequency=fsOg,FrequencyLimits=o.fLims);
    cwtHz{b} = fb.centerFrequencies';

    % Do CWT
    if ~doGPU
        % CPU parfor-loop (slower, no GPU required)
        parfor ch = 1:nChs
            xb{ch} = cwt_lfn(fb,xa(:,ch),fMean,false);
            disp(sbjChs(ch)+" "+block+": wavelet transform (CPU)");
        end
    else % Use GPU
        bFin = false;
        if doSingle; xa = single(xa); end
        % GPU arrayfun (fastest, requires more VRAM)
        if doGPUarray
            xa = num2cell(xa,1);
            xa = cellfun(@gpuArray,xa,'UniformOutput',false);
            try disp("Starting wavelet transform (GPU arrayfun): "+block);
                xb = arrayfun(@(xCh) cwt_lfn(fb,xCh{:},fMean,gatherOut),...
                    xa,'UniformOutput',false);
                bFin = true;
            catch ME; getReport(ME)
                warning(sbj+" "+block+": wavelet arrayfun error, switching GPU for-loop");
                xb = cell(1,nChs);
                if doSingle; xa=single(x(idx,:)); else; xa=x(idx,:); end
                bFin = false; gatherOut = gpuArray(true);
            end
        end

        % GPU for-loop (faster, requires less VRAM)
        if ~bFin
            for ch = 1:nChs
                xb{ch} = cwt_lfn(fb,xa(:,ch),fMean,gatherOut);
                disp(sbjChs(ch)+" "+block+": wavelet transform (GPU)");
            end 
        end
        xb = cellfun(@gather,xb,'UniformOutput',false);
    end
    if ~arg.test; clear xa; end

    %% Downsample & reshape
    if ds2>1 % downsample
        xb = arrayfun(@(xCh) resample(xCh{:},ds1,ds2),xb,'UniformOutput',false);
    end
    if doSingle; xb = cellfun(@single,xb,'UniformOutput',false); end % convert to single
    if fMean % reshape
        xb = horzcat(xb{:});
    else
        xb = permute(cat(3,xb{:}),[1 3 2]);
    end
    xf{b} = xb; % copy to main
    if ~arg.test; clear xb; end
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

%% Downsample event indices (if needed)
[errPsy,o,n] = ec_initialize(sbj,proj,o,n,dirs=dirs,dsTarg=dsTarg,save=arg.save);
if nnz(~cellfun(@isempty,errPsy)); errors{end+1}=errPsy; end
% Downsample bad chICA frames
if any(fieldnames(n)=="chICA_badFrames") && numel(n.chICA_badFrames)~=height(x)
    n.chICA_badFrames = double(full(n.chICA_badFrames));
    n.chICA_badFrames = resample(n.chICA_badFrames,ds1,ds2) > 0.5;
end

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
    if arg.save % Save
        fn = o.dirOut+"chNfo_"+o.fnStr;
        save(fn,"chNfo","-v7"); disp("SAVED: "+fn);
    end
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
sfx = erase(sfx,"_");
n.suffix = o.suffix;
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

if doGPU
    if ~isempty(gcp('nocreate')); parfevalOnAll(@gpuDevice, 0, []); end
    try reset(gpuDevice(1)); catch; end
end

% Save
if arg.save
    % Save n struct
    fn = o.dirOut+"n"+sfx+"_"+o.fnStr;
    save(fn,"n"); disp("SAVED: "+fn);
    
    % Save processed iEEG data
    fn = o.dirOut+"x"+sfx+"_"+o.fnStr;
    save(fn,"x","-v7.3","-nocompression"); disp("SAVED: "+fn);
end
toc;
end



%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%



%% CWT local function
function wt = cwt_lfn(fb,xch,fMean,gatherOut)
if fMean
    wt = fb.scaleSpectrum(xch)'; % dims: wt(time,1)
else
    wt = abs(fb.wt(xch))'; % dims: wt(time,freq)
end
if gatherOut; wt = gather(wt); end
end
%wt = wt.^2; % power = magnitude squared


%% DEPRECIATED
% chG = gpuArray(1);
% for ch = 1:gpuArray(nChs)
%     try
%         xb{ch} = cwt_lfn(fb,xa{ch},fMean,gatherOut);
%         xa{ch} = [];
%         disp(sbjChs(ch)+" "+block+": Wavelet decomposition (GPU)");
%     catch ME
%         if ~strcmp(ME.identifier,'parallel:gpu:array:OOM'); error(ME); end
%         % Gather finished data & delete from GPU
%         disp(sbjChs(ch)+" "+block+": gathering from GPU...");
%         xb(chG:ch-1) = cellfun(@gather,xb(chG:ch-1),'UniformOutput',false); %xa(chG:ch-1) = cellfun(@(ch) true,xa(chG:ch-1),'UniformOutput',false);
%         chG = ch-1;
%         % Finish channel
%         xb{ch} = cwt_lfn(fb,xa{ch},fMean,gatherOut);
%         xa{ch} = [];
%         disp(sbjChs(ch)+" "+block+": Wavelet decomposition (GPU)");
%     end
% end