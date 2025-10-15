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
sbjs = {'S12_38_LK','S12_42_NC','S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS',...
    'S12_39_RT','S12_40_MJ','S12_41_KS','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR','S15_87_RL',...
    'S16_95_JOB','S16_96_LF'}';

proj = "lbcn";
task = "MMR"; % task name



%% Options struct (more options in the loop below)
% NOTE: see individual functions for all inputs, descriptions & defaults
o = struct;
o.gpu = "matlab"; % Run on... ["no"|"matlab"|"cuda"]
o.single = false; % Run & save as single (single much faster on GPU)
o.singleOut = true; % Run as double (accuracy) & save as single (small filesize)
o.dsTarg = []; % Downsample target in Hz (default=[]: no downsample)
o.suffix = "";

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
o.thrSNS = 3; % Threshold for low-freq spikes; Sensor-specific noise thresh (try 5)

% Interpolate missing frames (within run & channel)
o.missingInterp = "linear";

% Detrending (within-run to avoid edge artifacts)
o.detrendGPU = 0; % 0=CPU; 1=gpuArray; 2=compiled CUDA binaries (must compile: ec_compileBins)
o.detrendSingle = false;
o.detrendOL = "median"; %o.detrendInterp = "makima";
% Robust detrending (pre-referencing)
o.detrendOrder = 0; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
o.detrendThr =   2.5; %repmat(2.5,1,3); %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
o.detrendItr =   2;   %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
o.detrendWin =   0; % de% detrend timewindow in seconds {entire run=[],default=[]}
% Robust detrending (post-referencing)
o.detrendOrder2 = 0; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
o.detrendThr2 =   2.5; %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
o.detrendItr2 =   2; %[5 3 3 3 3]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
o.detrendWin2 =   0; % de
% % Robust detrending (post-ASR)
% o.detrendOrder3 = [10 15 20]; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
% o.detrendThr3 =   2.5;  %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
% o.detrendItr3 =   5; %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
% o.detrendWin3 =   0; % detrend timewindow in seconds {entire run=[],default=[]}

% HPF (within-run to avoid edge artifacts)
o.hiPass = 1; %0.625; %"ASR"; % Hi-pass cutoff in hertz (skip=0)
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
o.asr.gpu = true; % use GPU when appropriate
o.asr.maxPctDiff = 0.15;
o.asr.refBurst = 25; % BurstCriterion
o.asr.refTols = [-5.5 5.5]; %[-3.5 5.5] BurstCriterionRefTolerances
o.asr.refMaxBadChs = 0.075; % ReferenceMaxBadChannels
o.asr.refWinSz = 0.5; % Granularity at which EEG time windows are extracted for calibration purposes, in seconds. Default: 1.
o.asr.winSz = 0.5; % Length of stats window (secs), timescale of artifacts (default=0.5)
o.asr.winOverlap = 3/4; % Overlap between windows 
o.asr.blockSz = []; % Cut robust estimation by this factor (default=10)
o.asr.filtHz =  [0  4 12 16 36 50 200 500]; % default=[]
o.asr.filtMag = [2 .5 .5 1  1  2  1.5 2];   % default=[];
o.asr.dimsPCA = 3/4; % Maximum dimensionality to reconstruct (default: 2/3)

% % Time-freq decomposition
% o.wavelet = "morse"; % Wavelet type ["morse"|"amor"|"bump"], "amor" is Gabor/Morlet
% o.fName = "spec"; % Name of frequency analysis
% o.fLims = [1 300]; % frequency limits in hz; HFB=[70 200]
% o.fMean = false; % Collapse across frequency bands (for 1d vector output)
% o.fVoices = 10; % Voices per octave (default=10, HFB=18)
% o.fOut = "magnitude"; % Output coefficient type ["magnitude"|"power"|"complex"]


%%
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/preproc/asr_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('status','var')
    status = table;
    status.sbj = string(sbjs);
    status.fin(:,1) = false;
    status.msg(:,1) = "";
    status.error = cell(numel(sbjs),1);
    status.time(:,1) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
end


%% Run
for s = 1:height(status)
    if status.fin(s); continue; end
    try
        sbj = status.sbj(s);
        disp("STARTING: "+sbj);

        %%
        status.error{s} = ec_preproc_iEEG(sbj,proj,task,o,redoN=true,save=true);
        status.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
        status.fin(s) = 1;
    catch ME; getReport(ME)
        status.error{s} = ME;
        status.fin(s) = 0;
    end
    save(sbjFinFn,'status','-v7');
end
