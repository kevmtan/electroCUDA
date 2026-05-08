% Initialize options struct
o = struct;
o.test = false; % TEST?
o.save = true; % SAVE?
o.gpu = false; % analysis on GPU
o.floatAnal = "double"; % Analysis at floating-point precision ["double"|"single"|"half"]
o.floatOut = "single"; % Save results at floating-point precision ["double"|"single"|"half"]

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
o.analDir = "classifySpecROI"; % directory name within dirs.anal
o.analName = "zf_hpfBands_50ms_SemEpi_LDA_gamma"; % directory name within o.analDir


%% ANALYSIS PREP: ec_analPrep(...,o.p)

% Input data suffix
o.p.sfx = "zf";

% Conditions for classification
o.p.condVar = "cond";
o.p.cond = ["Semantic" "Episodic"]; % Conditions to classify, ORDER MATTERS 
o.p.condx = ["Self" "Other"];       % Conditions to cross-classify (predict)

% Channel Options
o.p.chRm = []; % channels to remove (array of chan numbers)
o.p.chBadVars = ["ai" "empty" "nan"]; % Vars in n.chBad/icBad to use for bad chan removal
o.p.ROIs = ["Visual" "TPJ" "PCC" "ATL" "amPFC" "dmPFC" "vmPFC"]; % remove chs outside these ROIs
o.p.roiVar = "roi"; % ROI variable in chNfo
o.p.chConcat = "roi"; % Concatenate channels by ["roi"|"all"|""], default="" (none)

% Timing for analysis
o.p.timeVar = "bin"; % Timepoint variable from 'psy'/'ep' ["frame"|"latency"|"bin"|"binPct"|"binRT"]
o.p.timeRng = [-200 2000]; % Range of times to run including baseline ([]=epochPsy output)

% Copy trialNfo vars to 'ep'
o.p.trialVars = ["VD" "VD1" "VD2" "K_pca1" "K_pca2" "K_pca3" "K_pca4"];

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
o.p.epoch.bin = 0.05; % latency bin width (secs)
o.p.epoch.binPct = 1; % latency percentage bin width (<=100)
% Epoch baseline period for subsequent processing
%   (none=[], all pre/post times=inf, relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
o.p.epoch.baselinePre = []; %-0.2; % Pre-stimulus baseline (secs from stim onset): inf=ITI; [-.2]; [-0.2 1]
o.p.epoch.baselinePost = []; % Post-stimulus baseline (secs from stim offset): inf=ITI; [.2]; [0.1 0.3]
% Task condition ordering: all conds in data (leave blank for to leave unordered)
o.p.epoch.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
o.p.epoch.conds2 = []; % custom condition names (per above order, can repeat)
%   o.epoch.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
%   o.epoch.conds2 = ["Mz" "Mz" "Ab" "Ab" "Math" "Rest"]; % custom condition names (per above order, can repeat)

% Preprocessing (see 'ec_epochPreproc')
o.p.pre.gpu = false; % Run on GPU? (note: CPU appears faster)
o.p.pre.floatProc = "double"; % processing FP precision ("double"|"single"|""=same as input)
o.p.pre.floatOut = "double"; % output FP precision ("double"|"single"|""=same as input)
o.p.pre.hzTarget = 0; % Target sampling rate (0=default rate)
% Transform
o.p.pre.log = false; % Log transform
o.p.pre.mag2db = false; % Log-transform magnitude to decibel
% Normalize/standardize
o.p.pre.runNorm = "robust"; % Normalize run ["robust"|"zscore"|""]; skip=""
o.p.pre.trialBaseline = ""; % Subtract trial by mean or median of baseline period (skip=[])
o.p.pre.trialNorm = ""; % Normalize trial ["robust"|"zscore"|""]; skip=""
o.p.pre.trialNormDev = "all"; % Timepoints for StdDev ["baseline"|"pre"|"post"|"on"|"off"|"all"] (default="baseline")
% Bad frames/outliers
o.p.pre.interp = "linear"; % interpolation method
o.p.pre.badFrameVars = ["hfo" "flatA"]; % Bad frame removal vars (n.xBad) to use ["hfo"|"flatA"|"mad"|"diff"|"sns"|...]
o.p.pre.olCenter = "median";
o.p.pre.olThr = 0; % Outlier threshold (pre-HPF)
o.p.pre.olThr2 = 0; % Outlier threshold (post-HPF,pre-BL)
o.p.pre.olThrBL = 2; % Outlier threshold for baseline period (for baseline correction)
o.p.pre.olThrTime = 0; % Outlier threshold within timepoints across epochs
o.p.pre.olThrCond = 2.5; % Outlier threshold for conditions within timepts
o.p.pre.olFillTime = "clip"; % Outlier fill method for timepts/conds
% Filtering (within-run):
o.p.pre.hpf = 0.1; % HPF cutoff in hertz (skip=0)
o.p.pre.hpfSteep = 0.75; % HPF steepness
o.p.pre.hpfImpulse = "iir"; % HPF impulse: ["auto"|"fir"|"iir"]
o.p.pre.lpf = 0; % LPF cutoff in hz (skip=0)
o.p.pre.lpfSteep = 0.8; % LPF steepness
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
o.p.pre.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb"]; % Band name
o.p.pre.bands2 = ["Delta (2-4hz)" "Theta (4-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
    "Gamma (30-60hz)" "HFB (60-200hz)"]; % Band display name
o.p.pre.bandsF = [2 4; 4 8; 8 14; 14 30; 30 60; 60 180]; % Band limits

% o.p.pre.bands = ["theta" "alpha" "beta" "gamma" "hfb"]; % Band name
% o.p.pre.bands2 = ["Theta (5-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
%     "Gamma (30-60hz)" "HFB (60-200hz)"]; % Band display name
% o.p.pre.bandsF = [5 8; 8 14; 14 30; 30 60; 60 180]; % Band limits



%% ANALYSIS DATA SPLIT: ec_analSplit(...,o.s)

% Analysis floating-point precision ("double"|"single"|"half")
o.s.floatAnal = o.floatAnal; % copy from o.floatAnal above

% Normalize/standardize
o.s.std = "robust"; % normalize data within-split ["zscore"|"robust"|""=skip] % don't standardize to keep baseline at 0

% PCA
o.s.rank = false; % calculate data rank if no PCA
o.s.pca = ""; % Run rank calculation & PCA by ["ch"|"roi"|"split"|""=skip]
o.s.pcaComps = 0; % Number of components (0=skip, inf=matrix rank)
o.s.pcaVarThr = 0; % Variance threshold for number of components (0=skip; supersedes o.s.pcaComps)
o.s.pcaCompLims = [5 Inf]; % Bounds on number of components [lower upper]
o.s.pcaRobust = false; % Run robust PCA for denoising (can do without dim reduction)
o.s.pcaGPU = true; % GPU for rank calculation & PCA
o.s.pcaSaveWts = false; % Save PCA weights



%%%%%%%%%%%%%%%%%%%%%%%%% ANALYSIS OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Save options
o.psyVars = ["frame" "latency" "pct" "RT" "resp" "valence" "VD" "VD1" "VD2"...
    "K_pca1" "K_pca2" "K_pca3" "K_pca4"]; % psy vars to include in observations output

% Stats options
o.alpha = 0.05; % Critical p-value (default=0.05)
o.fdrDep = "corr+"; % Dependence structure for FDR ["unknown"|"corr+"|"corr-"|"indep"]
o.fdrTimeRng = [0 inf]; % Range of times for FDR

% Observations per timepoint (o.p.timeVar)
o.nMin = 100; % minimum observations per class within timepoint
o.balanceConds = true; % balance sample size per class within timepoint

% Function handles to inject into classifier routines
o.prepFun = @mmr_cSpecPrep; % inject at end of ec_classifyPrep
o.metricFun = @mmr_cSpecMetrics; % inject at end of ec_classify

% Cross-validation (CV) parameters (mathworks.com/help/stats/crossval.html)
o.doCV = true; % Do CV?
o.doNestedCV = true; % Nested CV for hyperparemeter optimization?
o.cv.KFold = 10; % Num folds for CV
o.cvh.KFold = 5; % Num folds for hyperparameter tuning CV
o.cvhn.KFold = 3; % Num folds for nested hyperparameter tuning CV (inner loop)
o.cvMinTrialsPerFold = 2; % Min trials per class in each fold

% Classification basic options
o.fun = @fitcdiscr; % Classifier function handle [@fitcsvm|@fitclinear|@fitcdiscr|...]
o.permutations = 0; % Num permutations for performance testing (0 = parametric test)
o.perfVar = "acc"; % Performance test statistic variable ("acc"=accuracy|"auc1"=PR-AUC)
o.jeffreys = false; % Jeffreys prior penalization for Platt scaling

% Classifier hyperparameters
o.hyper = struct;
o.hyper.Prior = "uniform";
if isequal(o.fun,@fitclinear)
    % Linear classifier (mathworks.com/help/stats/fitclinear.html)
    o.hyper.Learner = "logistic"; % "svm"
    o.hyper.Lambda = "auto";
    o.hyper.Regularization = "ridge";
    %o.hyper.Solver = "dual"; % "bfgs" for chs / "dual" for ROIs
    o.hyper.FitBias = true;
    o.hyper.PostFitBias = false;
    o.hyper.OptimizeLearnRate = true;
    o.hyper.Verbose = 0;
elseif isequal(o.fun,@fitcdiscr)
    % Linear discriminant analysis
    o.hyper.DiscrimType = "pseudolinear"; % "linear" "pseudolinear" "diaglinear"
    o.hyper.FillCoeffs = "on"; % "off" makes CV unreliable
elseif isequal(o.fun,@fitcsvm)
    % SVM hyperparameters (mathworks.com/help/stats/fitcsvm.html)
    o.hyper.KernelFunction = "linear";
    o.hyper.BoxConstraint = 1;
    o.hyper.KernelScale = "auto";
    o.hyper.Standardize = false;
    o.hyper.Solver = "SMO";
    o.hyper.CacheSize = "maximal";
    o.hyper.Verbose = 0;
elseif isequal(o.fun,@fitcknn)
    % KNN hyperparameters (mathworks.com/help/stats/fitcknn.html)
    o.hyper.Distance = "euclidean";
    o.hyper.NumNeighbors = 25;
    o.hyper.DistanceWeight = "inverse";
    o.hyper.std = true;
    % o.hyper.ScoreTransform = "invlogit";
end

% Optimize hyperparameters (mathworks.com/help/stats/bayesopt.html)
if isequal(o.fun,@fitcsvm)
    o.OptimizeHyperparameters = "BoxConstraint"; % "BoxConstraint" "KernelScale"
elseif isequal(o.fun,@fitclinear)
    o.OptimizeHyperparameters = "Lambda"; % "Lambda" "Learner"
elseif isequal(o.fun,@fitcdiscr)
    o.OptimizeHyperparameters = "Gamma"; % "Gamma" "Delta"
elseif isequal(o.fun,@fitcknn)
    o.OptimizeHyperparameters = ["Distance" "NumNeighbors"];
end
% Repartition must be false when ec_classify passes a custom CVPartition (trial-grouped cvh)
o.HyperparameterOptimizationOptions = struct(ShowPlots=false,Verbose=0,...
    Optimizer="gridsearch",NumGridDivisions=15,Repartition=false,UseParallel=false);


%% Run
 logs = ec_classifySpec(o);
