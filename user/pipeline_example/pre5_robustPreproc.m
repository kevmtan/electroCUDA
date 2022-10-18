%% Robust preprocessing for intracranial & scalp electrophysiology
%
% Wrapper template for calling the following electroCUDA functions:
%    * ec_initialize: aggregate subject/task/EEG info, align timings for EEG & task
%    * ec_preproc: rereferencing, detrending, denoising & outlier detection
%    * ec_preproc_ICA: GPU-based independent components analysis (written in CUDA)
%    * ec_preproc_timeFreq: robust time-frequency decomposition
%
% Full usage descriptions found in .m files for the above functions
%
% GPU ACCELERATION:
%    ec_preproc_ICA is GPU-only, ec_preproc_timeFreq has a 'doGPU' option
%    ec_preproc_ICA is written in CUDA with a Matlab wrapper (requires proficiency in compiling & CUDA)
%    ec_preproc_timeFreq can use Matlab GPU processing (see Matlab GPU requirements)
%    GPU VRAM must be greater than size of a single-channel EEG recording... YMMV
%    Enabling 'doGPU' defaults to single-precision floating point (FP32)
%    FP32 is less precise than Matlab's standard double-precision (FP64)
%    ec_preproc_ICA uses double-precision due to extreme sensitivity to rounding errors
%    You can use FP64 on GPU by disabling 'single' option
%
% CPU PARALLELIZATION:
%    Disabling 'doGPU' uses CPU parallelizaton: slower but more accurate (double FP64)
%    Thread- & process-based parallelization implemented natively in Matlab
%    This requires lots of RAM: 32gb+ is recommended, 128gb+ is ideal
%    See Matlab Parallelization Toolbox for more information
%
%
%               Kevin Tan, 2022 (http://kevmtan.github.io)
%
%
% ACKNOWLEDGMENTS:
%    Stanford Parvizi Lab (Pedro Pinhiero-Chagas, Amy Daitch, Su Liu, et al.)
%    Laboratoire des Systèmes Perceptifs (NoiseTools: Alain de Cheveigné, et al.)
% DISCLAIMER: Use this code at your own risk. Author assumes no responsibility
%    for any adverse outcomes related this code or its use. Author makes no
%    guarantees on the performance or accuracy of this code. This code is for
%    research purposes only; NOT INTENDED FOR CLINICAL OR MEDICAL USE.
% LICENSE: GNU General Public License

%% Project info
% Subject Names
sbjs = {'s001','s002','s003'}'; 

%sbjs = {'S12_38_LK'};

proj = 'MMR'; % Project name
pathFn = 'Kevin_DMN';
pathsDMN('ec'); % Get personal paths

doPsy = 0; % Align EEG-behavioral task timings
doLFP = 0; % Do preprocesing of raw EEG data
doSpec = 0; % Do time-frequency decomposition for multiple frequencies
doHFB = 0; % Do time-frequency decomposition of HFB band (average across HFB freqs)

doICA = 0; % Do independent components analysis
doICAspec = 0;
doICAhfb = 0;

doHFB_ICA = 1; % Do ICA on HFB

%if doICA||doICAspec||doICAhfb||doHFB_ICA; pathsDMN('ica'); end % add EEGLAB sigprocfun to path

%% Options struct (can be modified for each function below)
% NOTE: see individual functions for all inputs, descriptions & defaults

% Bad channel identification
o.doBadCh = true;
o.badChProp = 0.5; % criterion proportion of bad samples
o.thrHurst = 3; % Hurst threshold (median absolute deviation)
o.interpolateCh = false; % interpolate bad chans

% Interpolate missing frames (within run & channel)
o.missingInterp = "linear";

% Filtering (within blocks)
o.hiPass = 0; % Hi-pass cutoff in hertz (skip=0)

% Robust detrending [1st detrend run timechunks, 2nd detrend entire run]
o.detrendOrder = [10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
o.detrendWin = []; % detrend timewindow in seconds {entire run=[],default=[]}
o.detrendItr = [10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
o.detrendThr = [6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}

% Robust rereference
o.doRereference = true;
o.rrThr = 3; % outlier threshold for referencing (default=3)
o.rrItr = 5;

% Electric line noise removal
o.lineHz = 60; % Electricity hertz @ EEG recording site (default=50|60, skip=0)

% Bad frame detection per chan/IC
o.doBadFrames = true; % outlier/noise detection
o.thrHFO = 2; % threshold for epileptic HFO detection (default=2)
o.thrMAD = 10; % z-threshold relative to all data points to exclude timepoints (default=5)
o.thrDiff = 10; % z-threshold for amplitude difference of consecutive timepoints (default=5)
o.thrSNS = 3;

% Time-frequency decomposition
o.fName = "hfb"; % name of frequency analysis
o.fLims = [60 180]; % frequency limits in hz; HFB=[70 200]
o.fMean = true; % average across freq bands: output if TRUE=[time,ch]; FALSE=[time,ch,freq]
o.fVoices = 32; % voices per octave (default=10, HFB=20)
o.dsTarg = []; % downsample target in Hz (leave empty if no downsampling)
o.single = false; % Convert to double to single (if doGPU=true)
o.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
o.doGPUarray = true; % Use arrayfun for GPU (faster, requires more VRAM)

% ICA
o.ica_pca = 0;
o.ica_lrate = 1e-4; % starting learning rate
o.ica_stop = 1e-10; % stopping learning rate
o.ica_maxItr = 1024; % max iterations
o.detrendOrder_ICA = [10 30]; % polynomial order (suggested=10, skip=0)
o.detrendThr_ICA = [3 3];
o.detrendItr_ICA = [10 3];

%% Setup
%load('/home/kt/Gdrive/UCLA/Studies/MMR/anal/preproc/logs/robust_220701_1231_errors.mat','statusP');
if ~exist('statusPP','var')
    statusPP = table;
    statusPP.sbj = sbjs;
    statusPP.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    statusPP.psy(:) = nan;
    statusPP.LFP(:) = nan;
    statusPP.spec(:) = nan;
    statusPP.HFB(:) = nan;
    statusPP.ICA(:) = nan;
    statusPP.time(:) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    statusPP.errorPsy = cell(length(sbjs),1);
    statusPP.errorLFP = statusPP.errorPsy;
    statusPP.errorSpec = statusPP.errorPsy;
    statusPP.errorHFB = statusPP.errorPsy;
    statusPP.errorICA = statusPP.errorPsy;
end


%% Run channel-based preprocessing
if doPsy || doLFP || doSpec || doHFB
    sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/preproc_'...
        char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
    statusPP = preprocChs_lfn(pathFn,statusPP,proj,o,doPsy,doLFP,doSpec,doHFB,sbjFinFn);
end


%% Run ICA-based preprocessing
if doICA || doICAspec || doICAhfb
    sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/ICA_'...
        char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
    statusPP = preprocICA_lfn(pathFn,statusPP,proj,o,doICA,doICAspec,doICAhfb,sbjFinFn);
end


%% Run ICA decomposition on channel HFB timecourses
if doHFB_ICA
    sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/hfbICA_'...
        char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
    statusPP = preprocHFB_ICA_lfn(pathFn,statusPP,proj,o,sbjFinFn); %#ok<*UNRCH>
end


%%%%%%%%%%%%% Preprocessing wrappers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Channel-based preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function statusPP = preprocChs_lfn(pathFn,statusPP,proj,o,doPsy,doLFP,doSpec,doHFB,sbjFinFn)

for s = 1:height(statusPP) % Subject loop
    sbj=statusPP.sbj{s}; sbjID=statusPP.sbjID(s);
    dirs = ec_getDirs(pathFn,sbj,proj,sbjID);
    o.dirOut = dirs.robustSbj;
    o.fnStr = "s"+sbjID+"_"+proj;
    o.suffix = "";

    %% Initialize iEEG & task data for desired sampling rate
    %  NOTE: not necessary as this is called within the below functions
    if doPsy && statusPP.psy(s)~=1
        try [errPsy,o,n] = ec_initialize(sbj,proj,o,...
                dirs=dirs,save=1); %#ok<ASGLU>
            if nnz(~cellfun(@isempty,errPsy)); statusPP.errorPsy{s}=errPsy; end
            statusPP.psy(s)=1;
        catch ME; warning("ERROR ec_initialize: "+sbj); getReport(ME)
            statusPP.errorPsy{s} = {lastwarn,ME}; statusPP.psy(s)=0;
        end
    end

    %% LFP: robust preprocessing on raw EEG recordings (local field potentials)
    if doLFP && statusPP.LFP(s)~=1
        % Modify options
        oLFP = o;
        oLFP.suffix = "";
        oLFP.hiPass = 0.01;

        % Run
        try disp("Starting LFP: "+sbj);
            errPreproc = ec_preproc(sbj,proj,oLFP,save=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errPreproc)); statusPP.errorLFP{s}=errPreproc; end
            statusPP.LFP(s) = 1; disp("Finished LFP: "+sbj);
        catch ME; warning("ERROR LFP: "+sbj); getReport(ME)
            statusPP.errorLFP{s} = {lastwarn,ME};
            statusPP.LFP(s) = 0;
        end
    end

    %% Spec: continuous time-frequency decomposition
    if doSpec && statusPP.spec(s)~=1
        % Modify options
        oSpec = o;
        oSpec.suffix = "s";
        oSpec.fName = "spec"; % Name of frequency analysis
        oSpec.fLims = [1 300]; % frequency limits in hz; HFB=[70 200]
        oSpec.fMean = false; % Collapse across frequency bands (for 1d vector output)
        oSpec.fVoices = 10; % Voices per octave (default=10, HFB=32)
        oSpec.dsTarg = 100; % Downsample target in Hz (default=[]: no downsample)
        oSpec.single = true; % Convert to double to single (if doGPU=true)
        oSpec.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
        oSpec.doGPUarray = false; % Use arrayfun for GPU (faster, more memory)
        oSpec.doBadFrames = false;

        % Run
        try disp("Starting spec: "+sbj);
            errSpec = ec_preproc_timeFreq(sbj,proj,oSpec,save=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errSpec)); statusPP.errorSpec{s}=errSpec; end
            statusPP.spec(s) = 1; disp("Finished spec: "+sbj);
        catch ME; warning("ERROR spec: "+sbj); getReport(ME)
            statusPP.errorSpec{s} = {lastwarn,ME};
            statusPP.spec(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
    end

    %% HFB: high-frequency broadband decomposition
    if doHFB && statusPP.HFB(s)~=1
        % Modify options
        oHFB = o;
        oHFB.suffix = "h";
        oHFB.fName = "hfb"; % Name of frequency analysis
        oHFB.fLims = [60 180]; % frequency limits in hz; HFB=[70 200]
        oHFB.fMean = true; % Collapse across frequency bands (for 1d vector output)
        oHFB.fVoices = 32; % Voices per octave (default=10, HFB=18)
        oHFB.dsTarg = []; % Downsample target in Hz (default=[]: no downsample)
        oHFB.single = false; % Convert to double to single (single much faster on GPU)
        oHFB.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
        oHFB.doGPUarray = false; % Use arrayfun for GPU (faster, more memory)
        oHFB.doBadFrames = true;

        % Run
        try disp("Starting HFB: "+sbj);
            errHFB = ec_preproc_timeFreq(sbj,proj,oHFB,save=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errHFB)); statusPP.errorHFB{s}=errHFB; end
            statusPP.HFB(s) = 1; disp("Finished HFB: "+sbj);
        catch ME; warning("ERROR HFB: "+sbj); getReport(ME)
            statusPP.errorHFB{s} = {lastwarn,ME};
            statusPP.HFB(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
    end

    %% Log progress
    statusPP.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    save(sbjFinFn,'statusPP','-v7');
end
end




%% ICA-based preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function statusPP = preprocICA_lfn(pathFn,statusPP,proj,o,doICA,doICAspec,doICAhfb,sbjFinFn)
for s = 1:height(statusPP) % subject loop
    sbj=statusPP.sbj{s}; sbjID=statusPP.sbjID(s);
    dirs = ec_getDirs(pathFn,sbj,proj,sbjID);
    o.dirOut = dirs.robustSbj;
    o.fnStr = "s"+sbjID+"_"+proj+".mat";
    o.suffix = "";

    %% ICA decomposition
    if doICA && statusPP.ICA(s)~=1
        % Modify options
        oICA = o;
        oICA.suffix = "i";
        oICA.hiPassICA = 0; % Hi-pass cutoff in hertz
        oICA.hiPass = 0;
        oICA.detrendOrder_ICA = [10 30]; % polynomial order (suggested=10, skip=0)
        oICA.detrendThr_ICA = [3 3];
        oICA.detrendItr_ICA = [10 3];
        oICA.detrendOrder = [10 30];
        oICA.detrendThr = [6 3];
        oICA.detrendItr = [10 2];
        oICA.lineHz = [];
        oICA.thrHFO = [];
        oICA.thrMAD = 10; % z-threshold relative to all data points to exclude timepoints (default=5)
        oICA.thrDiff = 10; % z-threshold for amplitude difference of consecutive timepoints (default=5)
        oICA.thrSNS = 3;
        oICA.doBadCh = true;
        oICA.doBadIC = true;
        oICA.doBadFrames = true; % outlier/noise detection

        % Run
        try disp([sbj ': starting ICA']); clear n xi;
            [errICA,n,xi] = ec_preproc_ICA(sbj,proj,oICA,save=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errICA)); statusPP.errorICA{s}=errICA; end
            statusPP.ICA(s) = 1; disp([sbj ': FINISHED ICA!']);
            try reset(gpuDevice(1)); catch;end
        catch ME; warning([sbj ': ICA error']); getReport(ME)
            statusPP.errorICA{s} = {lastwarn,ME};
            statusPP.ICA(s) = 0;
            try reset(gpuDevice(1)); catch;end
            continue;
        end
    end

    %% Continuous time-frequency decomposition on IC timecourses
    if doICAspec && statusPP.spec(s)~=1
        % Modify options
        oSpec = o;
        oSpec.suffix = "is";
        oSpec.fName = "spec"; % Name of frequency analysis
        oSpec.fLims = [1 300]; % frequency limits in hz; HFB=[70 200]
        oSpec.fMean = false; % Collapse across frequency bands (for 1d vector output)
        oSpec.fVoices = 10; % Voices per octave (default=10, HFB=18)
        oSpec.dsTarg = 100; % Downsample target in Hz (default=[]: no downsample)
        oSpec.single = true; % Convert to double to single (if doGPU=true)
        oSpec.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
        oSpec.doGPUarray = false; % Use arrayfun for GPU (faster, more memory)
        oSpec.doBadFrames = false;

        % Run
        try disp("Starting spec: "+sbj);
            errSpec = ec_preproc_timeFreq(sbj,proj,oSpec,n,xi,save=1,ica=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errSpec)); statusPP.errorSpec{s}=errSpec; end
            statusPP.spec(s) = 1; disp("Finished spec: "+sbj);
            try reset(gpuDevice(1)); catch;end
        catch ME; warning("ERROR spec: "+sbj); getReport(ME)
            statusPP.errorSpec{s} = {lastwarn,ME};
            statusPP.spec(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
    end

    %% HFB decomposition on IC timecourses
    if doICAhfb && statusPP.HFB(s)~=1
        % Modify options
        oHFB = o;
        oHFB.suffix = "ih";
        oHFB.fName = "hfb"; % Name of frequency analysis
        oHFB.fLims = [60 180]; % frequency limits in hz; HFB=[70 200]
        oHFB.fMean = true; % Collapse across frequency bands (for 1d vector output)
        oHFB.fVoices = 32; % Voices per octave (default=10, HFB=18)
        oHFB.dsTarg = []; % Downsample target in Hz (default=[]: no downsample)
        oHFB.single = false; % Convert to double to single (single much faster on GPU)
        oHFB.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
        oHFB.doGPUarray = false; % Use arrayfun for GPU (faster, more memory)
        oHFB.doBadFrames = true;

        % Run
        try disp("Starting HFB: "+sbj);
            errHFB = ec_preproc_timeFreq(sbj,proj,oHFB,n,xi,save=1,ica=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errHFB)); statusPP.errorHFB{s}=errHFB; end
            statusPP.HFB(s) = 1; disp("Finished HFB: "+sbj);
        catch ME; warning("ERROR HFB: "+sbj); getReport(ME)
            statusPP.errorHFB{s} = {lastwarn,ME};
            statusPP.HFB(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
    end

    %% Log progress
    statusPP.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    save(sbjFinFn,"statusPP");
end
save(sbjFinFn,"statusPP");
end




%% ICA decomposition on channel HFB timecourses %%%%%%%%%%%%%%%%%%%%%%%%%%%
function statusPP = preprocHFB_ICA_lfn(pathFn,statusPP,proj,o,sbjFinFn) %#ok<*DEFNU>

for s = 1:height(statusPP) % Subject loop
    sbj=statusPP.sbj{s}; sbjID=statusPP.sbjID(s);
    dirs = ec_getDirs(pathFn,sbj,proj,sbjID);
    %ni = ec_loadSbj(dirs,"i","n");
    o.dirOut = dirs.robustSbj;
    o.fnStr = "s"+sbjID+"_"+proj;
    o.suffix = "hi";

    %% Rereference raw EEG data with no cleaning
    oICA = o; % Modify options
    %oLFP.suffix = "";
    oICA.detrendOrder = [10 30];
    oICA.detrendThr = [6 3];
    oICA.detrendItr = [10 3];
    oICA.hiPass = [];
    oICA.lineHz = [];
    oICA.thrHFO = [];
    oICA.doRereference = true;
    oICA.doBadCh = false;
    oICA.doBadFrames = false; 

    % Run
    try disp("Starting LFP: "+sbj);
        [errPreproc,n,x] = ec_preproc(sbj,proj,oICA,save=0,dirs=dirs);
        if nnz(~cellfun(@isempty,errPreproc)); statusPP.errorLFP{s}=errPreproc; end
        statusPP.LFP(s) = 1; disp("Finished LFP: "+sbj);
    catch ME; warning("ERROR LFP: "+sbj); getReport(ME)
        clear n x
        statusPP.errorLFP{s} = {lastwarn,ME};
        statusPP.LFP(s) = 0;
        continue;
    end

    %% HFB: high-frequency broadband decomposition
    %oHFB.suffix = "h";
    oICA.fName = "hfb"; % Name of frequency analysis
    oICA.fLims = [60 180]; % frequency limits in hz; HFB=[70 200]
    oICA.fMean = true; % Collapse across frequency bands (for 1d vector output)
    oICA.fVoices = 32; % Voices per octave (default=10, HFB=18)
    oICA.dsTarg = []; % Downsample target in Hz (default=[]: no downsample)
    oICA.single = false; % Convert to double to single (single much faster on GPU)
    oICA.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
    oICA.doGPUarray = false; % Use arrayfun for GPU (faster, more memory)
    oICA.doBadFrames = false;

    % Run
    try disp("Starting HFB: "+sbj);
        [errHFB,n,x] = ec_preproc_timeFreq(sbj,proj,oICA,n,x,save=0,dirs=dirs);
        if nnz(~cellfun(@isempty,errHFB)); statusPP.errorHFB{s}=errHFB; end
        statusPP.HFB(s) = 1; disp("Finished HFB: "+sbj);
    catch ME; warning("ERROR HFB: "+sbj); getReport(ME)
        clear n x
        statusPP.errorHFB{s} = {lastwarn,ME};
        statusPP.HFB(s) = 0;
        try parfevalOnAll(@gpuDevice,0,[]); catch;end
        try reset(gpuDevice(1)); catch;end
        try delete(gcp('nocreate')); catch;end
        continue;
    end


    %% ICA
    % Modify options
    oICA.suffix = "hi";
    oICA.ica_lrate = 1e-4; % starting learning rate
    oICA.ica_stop = 1e-10; % stopping learning rate
    oICA.ica_maxItr = 1024; % max iterations
    oICA.doRereference = 0;
    oICA.hiPassICA = 0; % Hi-pass cutoff in hertz
    oICA.hiPass = 0;
    oICA.detrendOrder_ICA = [10 30]; % polynomial order (suggested=10, skip=0)
    oICA.detrendThr_ICA = [10 5];
    oICA.detrendItr_ICA = [10 3];
    oICA.detrendOrder = [];
    oICA.detrendThr = [];
    oICA.detrendItr = [];
    oICA.lineHz = [];
    oICA.thrHFO = [];
    oICA.thrMAD = 10; % z-threshold relative to all data points to exclude timepoints (default=5)
    oICA.thrDiff = 10; % z-threshold for amplitude difference of consecutive timepoints (default=5)
    oICA.thrSNS = 3;
    oICA.doBadCh = false;
    oICA.doBadIC = true;
    oICA.doBadFrames = true; % outlier/noise detection

    % Run
    try disp([sbj ': starting ICA']);
        errICA = ec_preproc_ICA(sbj,proj,oICA,n,x,save=1,dirs=dirs);
        if nnz(~cellfun(@isempty,errICA)); statusPP.errorICA{s}=errICA; end
        disp([sbj ': FINISHED ICA!']);
        statusPP.ICA(s) = 1;
    catch ME; warning([sbj ': ICA error']); getReport(ME)
        statusPP.errorICA{s} = {lastwarn,ME};
        statusPP.ICA(s) = 0;
        try reset(gpuDevice(1)); catch;end
        try delete(gcp('nocreate')); catch;end
        continue;
    end

    %% Log progress
    %clear x n xs ns
    statusPP.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    save(sbjFinFn,'statusPP','-v7');
end
end
