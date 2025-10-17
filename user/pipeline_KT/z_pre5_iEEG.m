%% Robust preprocessing for intracranial or scalp electrophysiology
%
% Wrapper template for calling the following electroCUDA functions:
%    * ec_initialize: aggregate subject/task/EEG info, align timings for EEG & task
%    * ec_preproc: rereferencing, detrending, denoising & outlier detection
%    * ec_preprocICA: GPU-based independent components analysis (written in CUDA)
%    * ec_preprocTimeFreq: robust time-frequency decomposition
%    * robustSumStats: robust summary statistics & plots per electrode channel
%
% Full usage descriptions found in .m files for the above functions
%
% GPU ACCELERATION:
%    ec_preprocICA is GPU-only, ec_preprocTimeFreq has a 'doGPU' option
%    ec_preprocICA is written in CUDA with a Matlab wrapper (requires proficiency in compiling & CUDA)
%    ec_preprocTimeFreq can use Matlab GPU processing (see Matlab GPU requirements)
%    GPU VRAM must be greater than size of a single-channel EEG recording... YMMV
%    Enabling 'doGPU' defaults to single-precision floating point (FP32)
%    FP32 is less precise than Matlab's standard double-precision (FP64)
%    ec_preprocICA uses double-precision due to extreme sensitivity to rounding errors
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

%% Task info

% Subject Names
% sbjs = ["S12_38_LK","S12_42_NC",...
%     "S12_33_DA","S12_34_TC","S12_35_LM","S12_36_SrS","S12_39_RT",...
%     "S12_40_MJ","S12_41_KS","S12_45_LR","S13_46_JDB","S13_47_JT2","S13_50_LGM",...
%     "S13_51_MTL","S13_52_FVV","S13_53_KS2","S13_54_KDH","S13_56_THS","S13_57_TVD",...
%     "S13_59_SRR","S13_60_DY","S14_62_JW","S14_66_CZ","S14_67_RH","S14_74_OD",...
%     "S14_75_TB","S14_76_AA","S14_78_RS","S15_81_RM","S15_82_JB","S15_83_RR",...
%     "S15_87_RL","S16_95_JOB","S16_96_LF"];
sbjs = ["S12_39_RT","S13_57_TVD","S14_76_AA","S15_87_RL"]; 

proj = "lbcn";
task = "MMR"; % task name

doLFP = 1; % Do preprocesing of raw EEG data
doICA = 0; % Do independent components analysis
doSpec = 0; % Do time-frequency decomposition for multiple frequencies
doHFB = 0; % Do time-frequency decomposition of HFB band (average across HFB freqs)
doICAspec = 0;
doICAhfb = 0;

isTest=0;

%% Options struct (more options in the loop below)
% NOTE: see individual functions for all inputs, descriptions & defaults
o = struct;
o.gpu = "matlab"; % Run on... ["no"|"matlab"|"cuda"]
o.single = false; % Run & save as single (single much faster on GPU)
o.singleOut = true; % Run as double (accuracy) & save as single (small filesize)
o.hzTarget = []; % Downsample target in Hz (default=[]: no downsample)

% Bad channel identification
o.doBadCh = true;
o.badChProp = 0.5; % criterion proportion of bad samples
o.thrHurst = 3; % Hurst threshold (median absolute deviation)
o.interpolateCh = false; % interpolate bad chans

% Bad frame detection per chan/IC
o.doBadFrames = true; % outlier/noise detection
o.thrHFO = 2; % threshold for epileptic HFO detection (default=2)
o.thrMAD = 20; % z-threshold relative to all data points to exclude timepoints (default=5)
o.thrDiff = 20; % z-threshold for amplitude difference of consecutive timepoints (default=5)
o.thrSNS = 3;

% Interpolate missing frames (within run & channel)
o.missingInterp = "linear";

% Detrending (within-run to avoid edge artifacts)
o.detrendGPU = 0; % 0=CPU; 1=gpuArray; 2=compiled CUDA binaries (must compile: ec_compileBins)
o.detrendSingle = false;
o.detrendOL = "median"; %o.detrendInterp = "makima";
% Robust detrending (pre-referencing)
o.detrendOrder = 5; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
o.detrendThr =   2.5; %repmat(2.5,1,3); %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
o.detrendItr =   3;   %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
o.detrendWin =   0; % de% detrend timewindow in seconds {entire run=[],default=[]}
% Robust detrending (post-referencing)
o.detrendOrder2 = 10; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
o.detrendThr2 =   2.5; %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
o.detrendItr2 =   2; %[5 3 3 3 3]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
o.detrendWin2 =   0; % de
% % Robust detrending (post-ASR)
% o.detrendOrder3 = [10 15 20]; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
% o.detrendThr3 =   2.5;  %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
% o.detrendItr3 =   5; %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
% o.detrendWin3 =   0; % detrend timewindow in seconds {entire run=[],default=[]}

% HPF (within-run to avoid edge artifacts)
o.hiPassGPU = 0; % GPU slower than CPU??
o.hiPass = 0.625; %"ASR"; % Hi-pass cutoff in hertz (skip=0)
o.hiPassSteep = 0.5;

% Robust rereference
o.doRereference = true;
o.rrThr = 0; % outlier threshold for referencing (default=3)
o.rrItr = 1;

% Electric line noise removal
o.cleanlineHz = [60 120]; 
o.lineHz = 60; % Electricity hertz @ EEG recording site (default=50|60, skip=0)

% ASR
o.asr.do = true;
o.asr.maxPctDiff = 0.15;
o.asr.doGPU = false; % use GPU when appropriate
o.asr.refBurst = 25; % BurstCriterion
o.asr.refTols = [-5.5 5.5]; %[-3.5 5.5] BurstCriterionRefTolerances
o.asr.refMaxBadChs = 0.07; % ReferenceMaxBadChannels
o.asr.refWinSz = 0.5; % Granularity at which EEG time windows are extracted for calibration purposes, in seconds. Default: 1.
o.asr.winSz = 0.5; % Length of stats window (secs), timescale of artifacts (default=0.5)
o.asr.winOverlap = 3/4; % Overlap between windows 
o.asr.blockSz = []; % Cut robust estimation by this factor (default=10)
o.asr.filtHz =  [0  4 12 16 36 50 200 500]; % default=[]
o.asr.filtMag = [2 .5 .5 1  1  2  1.5 2];   % default=[];
o.asr.dimsPCA = 3/4; % Maximum dimensionality to reconstruct (default: 2/3)

% Time-freq decomposition
o.wavelet = "morse"; % Wavelet type ["morse"|"amor"|"bump"], "amor" is Gabor/Morlet
o.fName = "spec"; % Name of frequency analysis
o.fLims = [1 300]; % frequency limits in hz; HFB=[70 200]
o.fMean = false; % Collapse across frequency bands (for 1d vector output)
o.fVoices = 10; % Voices per octave (default=10, HFB=18)
o.fOut = "magnitude"; % Output coefficient type ["magnitude"|"power"|"complex"]

% % log2norm CWT output
% o.norm = false;

%% Setup
% % add existinge file if exist
% fn = "/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/preproc_221028_0653_errors.mat";
% load(fn,'statusPP');
if ~exist('statusPP','var')
    statusPP = table;
    statusPP.sbj = sbjs';
    statusPP.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")))';
    statusPP.psy(:) = nan;
    statusPP.LFP(:) = nan;
    statusPP.spec(:) = nan;
    statusPP.HFB(:) = nan;
    statusPP.ICA(:) = nan;
    statusPP.speci(:) = nan;
    statusPP.HFBi(:) = nan;
    statusPP.time(:) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    statusPP.errorPsy = cell(length(sbjs),1);
    statusPP.errorLFP = cell(length(sbjs),1);
    statusPP.errorSpec = cell(length(sbjs),1);
    statusPP.errorHFB = cell(length(sbjs),1);
    statusPP.errorICA = cell(length(sbjs),1);
    statusPP.errorHFBi = cell(length(sbjs),1);
    statusPP.errorSpeci = cell(length(sbjs),1);
end
if ~doLFP; statusPP.LFP(:)=1; end
if ~doICA; statusPP.ICA(:)=1; end

% filename of log
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/preproc/preproc_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];


%% ASR-ICA
for s = 1:height(statusPP) % Subject loop %s=1;
    sbj = statusPP.sbj{s};
    sbjID = statusPP.sbjID(s);
    dirs = ec_getDirs(proj,sbj,task,sbjID);
    o.dirOut = dirs.procSbj;
    o.fnStr = "s"+sbjID+"_"+task+".mat";
    o.suffix = "";

    %% LFP: robust preprocessing on raw EEG recordings (ASR) -- check redo setting!
    if doLFP && statusPP.LFP(s)~=1
        % Modify options
        oLFP = o;
        oLFP.suffix = "";

        % Run
        try disp("Starting LFP: "+sbj);
            errPreproc = ec_preproc_iEEG(sbj,task,oLFP,save=1,redo=1,redoN=1,test=isTest,dirs=dirs);
            if nnz(~cellfun(@isempty,errPreproc)); statusPP.errorLFP{s}=errPreproc; end
            statusPP.LFP(s) = 1; disp("Finished LFP: "+sbj);
        catch ME; warning("ERROR LFP: "+sbj); getReport(ME)
            statusPP.errorLFP{s} = {lastwarn,ME};
            statusPP.LFP(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice()); catch;end
            try delete(gcp('nocreate')); catch;end
            continue;
        end
        if ~isTest
            statusPP.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,"statusPP");
        end
    end

    %% ICA: Independent components analysis
    if doICA && statusPP.ICA(s)~=1
        % Modify options
        oICA = o;
        oICA.suffix = "i";
        oICA.sfx_src = "";
        oICA.ica_pca = 0;
        oICA.ica_lrate = 1e-4; % starting learning rate
        oICA.ica_stop = 1e-10; % stopping learning rate
        oICA.ica_maxItr = 1024; % max iterations
        oICA.ica_verbose = "off";
        oICA.doRereference = false;
        oICA.hiPassICA = []; %[0.75 1.25]; % temporary - only used for ICA input
        oICA.detrendOrder = []; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
        oICA.detrendThr =   []; %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
        oICA.detrendItr =   []; %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
        oICA.detrendWin =   []; % detrend timewindow in seconds {entire run=[],default=[]}
        oICA.lineHz = [];
        oICA.thrHFO = [];
        oICA.thrMAD = 20; % z-threshold relative to all data points to exclude timepoints (default=5)
        oICA.thrDiff = 20; % z-threshold for amplitude difference of consecutive timepoints (default=5)
        oICA.thrSNS = 3;
        oICA.doBadCh = false;
        oICA.doBadIC = true;
        oICA.doBadFrames = true; % outlier/noise detection

        % Run
        try disp([sbj ': starting ICA']);
            errICA = ec_preprocICA(sbj,task,oICA,save=1,redoN=1,test=isTest,dirs=dirs);
            if nnz(~cellfun(@isempty,errICA)); statusPP.errorICA{s}=errICA; end
            statusPP.ICA(s) = 1; disp([sbj ': FINISHED ICA!']);
        catch ME; warning([sbj ': ICA error']); getReport(ME)
            statusPP.errorICA{s} = {lastwarn,ME};
            statusPP.ICA(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
        if ~isTest
            statusPP.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,"statusPP");
        end
    end

    %% Spec on IC timecourses
    if doICAspec && statusPP.speci(s)~=1 && statusPP.ICA(s)==1
        % Modify options
        oSpec = o;
        oSpec.suffix = "is";
        oSpec.sfx_src = "i";
        oSpec.fName = "spec"; % Name of frequency analysis
        oSpec.fLims = [1 300]; % frequency limits in hz; HFB=[70 200]
        oSpec.fMean = false; % Collapse across frequency bands (for 1d vector output)
        oSpec.fVoices = 10; % Voices per octave (default=10, HFB=18)
        oSpec.doBadFrames = false;
        oSpec.detrendOrder = []; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
        oSpec.detrendThr =   []; %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
        oSpec.detrendItr =   []; %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
        oSpec.detrendWin =   []; % detrend timewindow in seconds {entire run=[],default=[]}
        oSpec.hiPass = []; %"asr"; %"ASR"; % Hi-pass cutoff in hertz (skip=0)
        oSpec.hiPassGPU = false; % GPU slower than CPU??
        oSpec.hzTarget = 100; % Downsample target in Hz (default=[]: no downsample)
        oSpec.single = false; % Run & save as single (single much faster on GPU)
        oSpec.singleOut = true; % Run as double (accuracy) & save as single (small filesize)
        oSpec.doCUDA = true; % Run on CUDA GPU binary - must be compiled 1st! (ecu_compileThese)
        oSpec.doGPU = false; % Run on MATLAB gpuArray (superseded by CUDA)

        % Run
        try disp("Starting spec: "+sbj);
            errSpec = ec_preprocTimeFreq(sbj,task,oSpec,save=1,ica=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errSpec)); statusPP.errorSpeci{s}=errSpec; end
            statusPP.speci(s) = 1; disp("Finished spec: "+sbj);
        catch ME; warning("ERROR spec: "+sbj); getReport(ME)
            statusPP.errorSpeci{s} = {lastwarn,ME};
            statusPP.speci(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
        if ~isTest
            statusPP.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,"statusPP");
        end
    end

    %% Spec
    if doSpec && statusPP.spec(s)~=1 && statusPP.LFP(s)==1
        % Modify options
        oSpec = o;
        oSpec.suffix = "s";
        oSpec.sfx_src = "";
        oSpec.fName = "spec"; % Name of frequency analysis
        oSpec.fLims = [1 300]; % frequency limits in hz; HFB=[70 200]
        oSpec.fMean = false; % Collapse across frequency bands (for 1d vector output)
        oSpec.fVoices = 10; % Voices per octave (default=10, HFB=18)
        oSpec.doBadFrames = false;
        oSpec.detrendOrder = []; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
        oSpec.detrendThr =   []; %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
        oSpec.detrendItr =   []; %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
        oSpec.detrendWin =   []; % detrend timewindow in seconds {entire run=[],default=[]}
        oSpec.hiPass = []; %"asr"; %"ASR"; % Hi-pass cutoff in hertz (skip=0)
        oSpec.hiPassGPU = false; % GPU slower than CPU??
        oSpec.hzTarget = 100; % Downsample target in Hz (default=[]: no downsample)
        oSpec.single = false; % Run & save as single (single much faster on GPU)
        oSpec.singleOut = true; % Run as double (accuracy) & save as single (small filesize)
        oSpec.doCUDA = true; % Run on CUDA GPU binary - must be compiled 1st! (ecu_compileThese)
        oSpec.doGPU = false; % Run on MATLAB gpuArray (superseded by CUDA)

        % Run
        try disp("Starting spec: "+sbj);
            errSpec = ec_preprocTimeFreq(sbj,task,oSpec,save=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errSpec)); statusPP.errorSpec{s}=errSpec; end
            statusPP.spec(s) = 1; disp("Finished spec: "+sbj);
        catch ME; warning("ERROR spec: "+sbj); getReport(ME)
            statusPP.errorSpec{s} = {lastwarn,ME};
            statusPP.spec(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice()); catch;end
            try delete(gcp('nocreate')); catch;end
        end
        if ~isTest
            statusPP.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,"statusPP");
        end
    end

    %% HFB: high-frequency broadband decomposition
    if doHFB && statusPP.HFB(s)~=1 && statusPP.LFP(s)==1
        % Modify options
        oHFB = o;
        oHFB.suffix = "h";
        oHFB.sfx_src = "";
        oHFB.fName = "hfb"; % Name of frequency analysis
        oHFB.fLims = [60 200]; % frequency limits in hz; HFB=[70 200]
        oHFB.fMean = true; % Collapse across frequency bands (for 1d vector output)
        oHFB.fVoices = 32; % Voices per octave (default=10, HFB=18)
        oHFB.doBadFrames = true;
        oHFB.detrendOrder = []; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
        oHFB.detrendThr =   []; %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
        oHFB.detrendItr =   []; %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
        oHFB.detrendWin =   []; % detrend timewindow in seconds {entire run=[],default=[]}
        oHFB.hiPass = []; %"asr"; %"ASR"; % Hi-pass cutoff in hertz (skip=0)
        oHFB.hiPassGPU = false; % GPU slower than CPU??
        oHFB.hzTarget = []; % Downsample target in Hz (default=[]: no downsample)
        oHFB.single = false; % Run & save as single (single much faster on GPU)
        oHFB.singleOut = false; % Run as double (accuracy) & save as single (small filesize)
        oHFB.doCUDA = true; % Run on CUDA GPU binary - must be compiled 1st! (ecu_compileThese)
        oHFB.doGPU = false; % Run on MATLAB gpuArray (superseded by CUDA)

        % Run
        try disp("Starting HFB: "+sbj);
            errHFB = ec_preprocTimeFreq(sbj,task,oHFB,save=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errHFB)); statusPP.errorHFB{s}=errHFB; end
            statusPP.HFB(s) = 1; disp("Finished HFB: "+sbj);
        catch ME; warning("ERROR HFB: "+sbj); getReport(ME)
            statusPP.errorHFB{s} = {lastwarn,ME};
            statusPP.HFB(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice()); catch;end
            try delete(gcp('nocreate')); catch;end
        end
        if ~isTest
            statusPP.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,"statusPP");
        end
    end


    %% HFB decomposition on IC timecourses
    if doICAhfb && statusPP.HFBi(s)~=1 && statusPP.ICA(s)==1
        % Modify options
        oHFB = o;
        oHFB.suffix = "ih";
        oHFB.sfx_src = "i";
        oHFB.fName = "hfb"; % Name of frequency analysis
        oHFB.fLims = [60 200]; % frequency limits in hz; HFB=[70 200]
        oHFB.fMean = true; % Collapse across frequency bands (for 1d vector output)
        oHFB.fVoices = 32; % Voices per octave (default=10, HFB=18)
        oHFB.doBadFrames = true;
        oHFB.detrendOrder = []; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
        oHFB.detrendThr =   []; %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
        oHFB.detrendItr =   []; %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
        oHFB.detrendWin =   []; % detrend timewindow in seconds {entire run=[],default=[]}
        oHFB.hiPass = []; %"asr"; %"ASR"; % Hi-pass cutoff in hertz (skip=0)
        oHFB.hiPassGPU = false; % GPU slower than CPU??
        oHFB.hzTarget = []; % Downsample target in Hz (default=[]: no downsample)
        oHFB.single = false; % Run & save as single (single much faster on GPU)
        oHFB.singleOut = false; % Run as double (accuracy) & save as single (small filesize)
        oHFB.doCUDA = true; % Run on CUDA GPU binary - must be compiled 1st! (ecu_compileThese)
        oHFB.doGPU = false; % Run on MATLAB gpuArray (superseded by CUDA)

        % Run
        try disp("Starting HFB: "+sbj);
            errHFB = ec_preprocTimeFreq(sbj,task,oHFB,save=1,ica=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errHFB)); statusPP.errorHFBi{s}=errHFB; end
            statusPP.HFBi(s) = 1; disp("Finished HFB: "+sbj);
        catch ME; warning("ERROR HFB: "+sbj); getReport(ME)
            statusPP.errorHFBi{s} = {lastwarn,ME};
            statusPP.HFBi(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
        if ~isTest
            statusPP.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,"statusPP");
        end
    end
end

% %% Initialize iEEG & task data for desired sampling rate
%  NOTE: not necessary as this is called within the below functions
%  if doPsy && statusPP.psy(s)~=1
%    try [errPsy,o,n] = ec_initialize(sbj,task,o,dirs=dirs,save=1);
%        if nnz(~cellfun(@isempty,errPsy)); statusPP.errorPsy{s}=errPsy; end
%        statusPP.psy(s)=1;
%    catch ME; warning("ERROR ec_initialize: "+sbj); getReport(ME)
%        statusPP.errorPsy{s} = {lastwarn,ME}; statusPP.psy(s)=0;
%    end
% end
