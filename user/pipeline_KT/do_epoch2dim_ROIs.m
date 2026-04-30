% Initialize options struct
o = struct;
o.test = false; % TEST?
o.save = true; % SAVE?

% Subjects
o.sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";...
    "S12_40_MJ";"S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";...
    "S13_50_LGM";"S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";...
    "S13_57_TVD";"S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";...
    "S14_74_OD";"S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";...
    "S15_83_RR";"S15_87_RL";"S16_95_JOB";"S16_96_LF"];
%sbjs = ["S12_38_LK";"S12_42_NC"]; %["S12_38_LK";"S12_42_NC"];

% Load/save options
o.proj = "lbcn"; % analysis project
o.task = "MMR"; % analysis task
o.analDir = "ROIs"; % directory name within dirs.anal
o.analName = "ep_xs"; % directory name within o.analDir
o.floatAnal = "double"; % Analysis at floating-point precision ["double"|"single"|"half"]
o.floatOut = "single"; % Save results at floating-point precision ["double"|"single"|"half"]

% Variables in trialNfo to copy to epoch/observations table 'ob'
o.trialVars = ["run" "cnd" "category" "RT" "resp" "acu" "valence"...
    "word" "eng" "VD" "VD1" "VD2" "K_pca1" "K_pca2" "K_pca3" "K_pca4"...
    "durITI" "durStim" "noPdio"];


%% ANALYSIS PREP OPTIONS: ec_analPrep(...,o.p) 

% Input data suffix
o.p.sfx = "s";

% Conditions for classification
o.p.condVar = "cond";
o.p.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"];

% Channel Options
o.p.chRm = []; % channels to remove (array of chan numbers)
o.p.chBadVars = "bad"; % Vars in n.chBad/icBad to use for bad chan removal
o.p.ROIs = ["Visual" "TPJ" "PCC" "ATL" "amPFC" "dmPFC" "vmPFC"]; % remove chs outside these ROIs
o.p.roiVar = "roi"; % ROI variable in chNfo
o.p.chConcat = ""; % Concatenate channels by ["roi"|"all"|""], default="" (none)

% Timing for analysis
o.p.timeVar = "bin"; % Timepoint variable from 'psy'/'ep' ["frame"|"latency"|"bin"|"binPct"|"binRT"]
o.p.timeRng = [-200 2000]; % Range of times to run including baseline ([]=epochPsy output)

% Task Epoching (see 'ec_epochPsy')
o.p.epoch.float = o.floatAnal; % task metadata output floating-point precision
o.p.epoch.hzTarget = 0; % Target sampling rate (0=default rate)
o.p.epoch.rmVars = ["Time" "onHz" "photodiode" "trial" "timeR" "noPdio"]; % Vars to remove from epoch table
% Bad trial removal
o.p.epoch.rmTrials = []; % Trials to remove (numeric array)
o.p.epoch.rmTrialsFun = @(t) (~(t.RT>0.1) & t.cond~="Rest"); % Function for removing trials
o.p.epoch.badTrialVars = "noPdio"; % Bad trial removal criteria
% Epoch time limits (secs) [nan=variable, 0=none]
o.p.epoch.pre = nan; % Duration before stim onset [nan = pre-stim ITI]
o.p.epoch.post = nan; % Duration after stim offset [nan = post-stim ITI]
o.p.epoch.dur = nan; % Duration after stim onset, supersedes 'post' [nan = no limit]
% Epoch time bins
o.p.epoch.bin = 0.025; % latency bin width (secs)
o.p.epoch.binPct = 5; % latency percentage bin width (<=100)
% Epoch baseline period for subsequent processing
%   (none=[], all pre/post times=inf, relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
o.p.epoch.baselinePre = -0.2; %[-0.15 -0.05]; %-0.2; % Pre-stimulus baseline (secs from stim onset): inf=ITI; [-.2]; [-0.2 1]
o.p.epoch.baselinePost = []; % Post-stimulus baseline (secs from stim offset): inf=ITI; [.2]; [0.1 0.3]
% Task condition ordering: all conds in data (leave blank for to leave unordered)
o.p.epoch.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
o.p.epoch.conds2 = []; % custom condition names (per above order, can repeat)
%   o.epoch.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
%   o.epoch.conds2 = ["Mz" "Mz" "Ab" "Ab" "Math" "Rest"]; % custom condition names (per above order, can repeat)

% Preprocessing (see 'ec_epochPreproc')
o.p.pre.gpu = false; % Run on GPU? (note: CPU appears faster)
o.p.pre.floatProc = o.floatAnal; % processing FP precision ("double"|"single"|""=same as input)
o.p.pre.floatOut = o.floatOut; % output FP precision ("double"|"single"|""=same as input)
o.p.pre.hzTarget = 0; % Target sampling rate (0=default rate)
% Transform
o.p.pre.log = false; % Log transform
o.p.pre.mag2db = false; % Log-transform magnitude to decibel
% Normalization/standardization
o.p.pre.runNorm = "robust"; % Normalize run ["robust"|"zscore"|""]; skip=""
o.p.pre.trialBaseline = "mean"; % Subtract trial by mean or median of baseline period (skip=[])
o.p.pre.trialNorm = ""; % Normalize trial ["robust"|"zscore"|""]; skip=""
o.p.pre.trialNormDev = "baseline"; % Timepoints for StdDev ["baseline"|"pre"|"post"|"on"|"off"|"all"] (default="baseline")
% Bad frames/outliers
o.p.pre.interp = "linear"; % interpolation method
o.p.pre.badFrameVars = "hfo"; % Bad frame removal vars (n.xBad) to use ["hfo"|"flatA"|"mad"|"diff"|"sns"|...]
o.p.pre.olCenter = "median";
o.p.pre.olThr = 0; % Outlier threshold (pre-HPF)
o.p.pre.olThr2 = 0; % Outlier threshold (post-HPF,pre-BL)
o.p.pre.olThrBL = 2; % Outlier threshold for baseline period (for baseline correction)
o.p.pre.olThrTime = 0; % Outlier threshold within timepoints across epochs
o.p.pre.olThrCond = 3; % Outlier threshold for conditions within timepts
o.p.pre.olFillTime = "clip"; % Outlier fill method for timepts/conds
% Filtering (within-run):
o.p.pre.hpf = 0; % HPF cutoff in hertz (skip=0)
o.p.pre.hpfSteep = 0.7; % HPF steepness
o.p.pre.hpfImpulse = "fir"; % HPF impulse: ["auto"|"fir"|"iir"]
o.p.pre.lpf = 0; % LPF cutoff in hz (skip=0)
o.p.pre.lpfSteep = 0.75; % LPF steepness
o.p.pre.lpfImpulse = "fir"; % LPF impulse: ["auto"|"fir"|"iir"]
% Spectral frequencies to keep, range per row: [minFreq1 maxFreq2; minFreq1 maxFreq2; ...])
o.p.pre.freqs = []; %[5 300];
% Spectral PCA (within-channel/IC)
o.p.pre.pca = 0; % Spectral components to keep per channel/ROI/whole-brain (skip=0)
o.p.pre.pcaVarThr = 0; % Variance threshold for kept PCA comps (0=skip; supersedes o.p.pre.pca)
o.p.pre.pcaCompLims = [0 inf]; % Bounds on kept PCA comps [lower upper]
o.p.pre.pcaRobust = false;
o.p.pre.pcaStd = ""; % don't standardize to keep baseline at 0
o.p.pre.pcaGPU = false;
% Spectral dimensionality reduction into bands (skip=[])
% o.p.pre.bands = ["theta" "alpha" "beta" "gamma" "hfb"]; % Band name
% o.p.pre.bands2 = ["Theta (5-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
%     "Gamma (30-60hz)" "HFB (60-200hz)"]; % Band display name
% o.p.pre.bandsF = [5 8; 8 14; 14 30; 30 60; 60 200]; % Band limits

% o.p.pre.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb"]; % Band name
% o.p.pre.bands2 = ["Delta (2-4hz)" "Theta (4-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
%     "Gamma (30-60hz)" "HFB (60-200hz)"]; % Band display name
% o.p.pre.bandsF = [2 4; 4 8; 8 14; 14 30; 30 60; 60 200]; % Band limits


%% Initialize threadpool
try ppool = parpool("threads"); catch;end


%% Run 
ec_epoch2dim_ROIs(o);