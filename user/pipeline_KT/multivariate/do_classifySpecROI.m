sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";...
    "S12_40_MJ";"S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";...
    "S13_50_LGM";"S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";...
    "S13_57_TVD";"S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";...
    "S14_74_OD";"S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";...
    "S15_83_RR";"S15_87_RL";"S16_95_JOB";"S16_96_LF"];
%sbjs = ["S12_38_LK";"S12_42_NC"];
proj = "lbcn";
task = "MMR"; % task name
analFolder = "classifySpecROI";
analName = "MzAb_SVM";

dirs = ec_getDirs(proj,task);

% Initialize options struct
o = struct;
o.name = ""; % Analysis name (filled in subject loop)


%% Options
o.test = false;
o.save = true;

% Input data
o.p.sfx = "f";
o.p.ICA = false; % Run on ICs?
o.p.nRmFields = "of"; % Fields to remove from 'n' to save memory

% Channel Options
o.p.chRm = []; % channels to remove (array of chan numbers)
o.p.chBadVars = "bad"; % Vars in n.chBad/icBad to use for bad chan removal
o.p.ROIs = ["Visual" "TPJ" "PCC" "ATL" "amPFC" "dmPFC" "vmPFC"]; % remove chs outside these ROIs
o.p.roiVar = "roi"; % ROI variable in chNfo
o.p.chConcat = "roi"; % Concactenate channels by ["roi"|"all"|""], default="" (none)

% Timing for classification
o.p.timeVar = "bin"; % Timepoint variable from 'psy'/'ep' ["frame"|"latency"|"bin"|"binPct"|"binRT"]
o.p.timeRng = [-200 2000]; % Range of times to run including baseline ([]=epochPsy output)

% Conditions for classification
o.p.condVar = "cond";
o.p.cond = ["Semantic" "Episodic"]; % Conditions to classify (train & test)
o.p.condx = ["Self" "Other"];       % Conditions to cross-classify (predict)

% Rank calculation & PCA
o.pca = ""; % Run rank calculation & PCA by ["ch"|"roi"|"split"|""=skip]
o.pcaComps = 0; % Number of components (0=skip, inf=data rank)
o.pcaRankLim = true; % Limit PCA components to data rank
o.pcaRobust = false; % Run robust PCA for denoising (can do without dim reduction)
o.pcaGPU = false; % GPU for rank calculation & PCA

% Processing options
o.gpu = false; % do GPU
o.typeAnal = "single"; % processing floating-point precision ("double"|"single")
o.typeOut = "single"; % output floating-point precision ("double"|"single")
o.psyVars = ["frame" "latency" "pct" "RT" "resp" "valence"]; % psy vars to include in results output

% Stats options
o.alpha = 0.05; % Critical p-value (default=0.05)
o.fdrTimeRng = [0 inf]; % Range of times for FDR
o.fdrDep = "corr+"; % Dependence structure for FDR ["unknown"|"corr+"|"corr-"|"indep"]

% Classifier basic options
o.fun = @fitclinear; % Classifier function handle [@fitcsvm|@fitclinear|@fitcdiscr|...]
o.nMin = 15; % minimum observations per class within timepoint
o.balanceConds = true; % balance sample size per class within timepoint 
o.std = "robust"; % Standardize predictors ["zscore"|"robust"|""=skip] % don't standardize to keep baseline at 0

% Cross-validation parameters (mathworks.com/help/stats/crossval.html)
o.cv.KFold = 10; % o.cv.Leaveout = "on";
% Cross-validation for hyperparameter optimization
o.cvh.KFold = 5;
o.cvMinTrialsPerFold = 3; % minimum trials per class in each fold

% Classifier hyperparameters
o.hyper = struct;
o.hyper.Prior = "uniform";
if isequal(o.fun,@fitcsvm)
    % SVM hyperparameters (mathworks.com/help/stats/fitcsvm.html)
    o.hyper.KernelFunction = "linear";
    o.hyper.BoxConstraint = 1;
    o.hyper.KernelScale = "auto";
    o.hyper.Standardize = false;
    o.hyper.Solver = "SMO";
    o.hyper.CacheSize = "maximal";
    o.hyper.Verbose = 0;
elseif isequal(o.fun,@fitclinear)
    % Linear SVM hyperparameters (mathworks.com/help/stats/fitclinear.html)
    o.hyper.Learner = "svm";
    o.hyper.Lambda = "auto";
    o.hyper.Regularization = "ridge";
    o.hyper.Solver = "dual";
    o.hyper.FitBias = true;
    o.hyper.PostFitBias = true;
    o.hyper.OptimizeLearnRate = true;
    o.hyper.Verbose = 0;
elseif isequal(o.fun,@fitcdiscr)
    o.hyper.DiscrimType = "linear";
    o.hyper.FillCoeffs = "on"; % "off" makes CV unreliable
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
    o.OptimizeHyperparameters = "none"; % "Lambda" "Learner"
elseif isequal(o.fun,@fitcdiscr)
    o.OptimizeHyperparameters = "Gamma"; % "Gamma" "Delta"
elseif isequal(o.fun,@fitcknn)
    o.OptimizeHyperparameters = ["Distance" "NumNeighbors"];
end
o.HyperparameterOptimizationOptions =...
    struct(ShowPlots=false,Verbose=0,Optimizer="bayesopt",Repartition=false,...
    AcquisitionFunctionName="expected-improvement-plus",MaxObjectiveEvaluations=30);
%struct(ShowPlots=false,Verbose=0,Optimizer="bayesopt",Kfold=5,Repartition=true,...
%AcquisitionFunctionName="expected-improvement-plus",MaxObjectiveEvaluations=30);

% Task Epoching (see 'ec_epochPsy')
o.p.epoch.float = "single"; % task metadata output floating-point precision
o.p.epoch.hzTarget = 0; % Target sampling rate (0=default rate)
o.p.epoch.rmVars = ["Time" "onHz" "photodiode" "trial" "timeR" "noPdio"]; % Vars to remove from epoch table
% Bad trial removal
o.p.epoch.rmTrials = []; % Trials to remove (numeric array)
o.p.epoch.rmTrialsFun = @(t) (~(t.RT>0.1) & t.cond~="Rest"); % Function for removing trials
o.p.epoch.badTrialVars = "noPdio"; % Bad trial removal criteria
% Epoch time limits (secs) [nan=variable, 0=none]
o.p.epoch.pre = nan; % Duration before stim onset [nan = pre-stim ITI]
o.p.epoch.post = nan; % Duration after stim offset [nan = post-stim ITI]
o.p.epoch.dur = 2.025; % Duration after stim onset, supercedes 'post' [nan = no limit]
% Epoch time bins
o.p.epoch.bin = 0.025; % latency bin width (secs)
o.p.epoch.binPct = 5; % latency percentage bin width (<=100)
% Epoch baseline period for subsequent processing
%   (none=[], all pre/post times=inf, relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
o.p.epoch.baselinePre = [-0.15 -0.05]; %-0.2; % Pre-stimulus baseline (secs from stim onset): inf=ITI; [-.2]; [-0.2 1]
o.p.epoch.baselinePost = []; % Post-stimulus baseline (secs from stim offset): inf=ITI; [.2]; [0.1 0.3]
% Task condition ordering - all conds in data (leave blank for to leave unordered)
o.p.epoch.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
o.p.epoch.conds2 = []; % custom condition names (per above order, can repeat)
%   o.epoch.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
%   o.epoch.conds2 = ["Mz" "Mz" "Ab" "Ab" "Math" "Rest"]; % custom condition names (per above order, can repeat)

% Preprocessing (see 'ec_epochPreproc')
o.p.pre.gpu = false; % Run on GPU? (note: CPU appears faster)
o.p.pre.typeProc = "double"; % processing FP precision ("double"|"single"|""=same as input)
o.p.pre.typeOut = "double"; % output FP precision ("double"|"single"|""=same as input)
o.p.pre.hzTarget = 0; % Target sampling rate (0=default rate)
% Normalization/transform
o.p.pre.log = false; % Log transform
o.p.pre.mag2db = false; % Log-transform magnitude to decibel
o.p.pre.runNorm = "robust"; % Normalize run ["robust"|"zscore"|""]; skip=""
o.p.pre.trialNorm = ""; % Normalize trial ["robust"|"zscore"|""]; skip=""
o.p.pre.trialNormDev = "baseline"; % Timepoints for StdDev ["baseline"|"pre"|"post"|"on"|"off"|"all"] (default="baseline")
o.p.pre.trialBaseline = "median"; % Subtract trial by mean or median of baseline period (skip=[])
% Bad frames/outliers
o.p.pre.interp = "linear"; % interpolation method
o.p.pre.badFrameVars = "hfo"; % Bad frame removal vars (n.xBad) to use ["hfo"|"mad"|"diff"|"sns"|...]
o.p.pre.olCenter = "median";
o.p.pre.olThr = 0; % Outlier threshold (pre-HPF)
o.p.pre.olThr2 = 0; % Outlier threshold (post-HPF,pre-BL)
o.p.pre.olThrBL = 2.5; % Outlier threshold for baseline period (for baseline correction)
o.p.pre.olThrTime = 0; % Outlier threshold within timepoints across epochs
o.p.pre.olThrCond = 3; % Outlier threshold for conditions within timepts
o.p.pre.olFillTime = "clip"; % Outlier fill method for timepts/conds
% Filtering (within-run):
o.p.pre.hpf = 0; % HPF cutoff in hertz (skip=0)
o.p.pre.hpfSteep = 0.7; % HPF steepness
o.p.pre.hpfImpulse = "fir"; % HPF impulse: ["auto"|"fir"|"iir"]
o.p.pre.lpf = 20; % LPF cutoff in hz (skip=0)
o.p.pre.lpfSteep = 0.5; % LPF steepness
o.p.pre.lpfImpulse = "fir"; % LPF impulse: ["auto"|"fir"|"iir"]
% Spectral frequencies to keep, range per row: [minFreq1 maxFreq2; minFreq1 maxFreq2; ...])
o.p.pre.freqs = [5 300];
% PCA within-chan or within-concactenated chans (e.g., make spectral components)
o.p.pre.pca = 0; % Spectral components to keep per channel/ROI/whole-brain (skip=0)
o.p.pre.pcaRobust = false;
o.p.pre.pcaStd = ""; % don't standardize to keep baseline at 0
o.p.pre.pcaGPU = false;
% % Spectral dimensionality reduction into bands (skip=[])
% o.pre.bands = ["theta" "alpha" "beta" "gamma" "hfb"]; % Band name
% o.pre.bands2 = ["Theta (5-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
%     "Gamma (30-60hz)" "HFB (60-200hz)"]; % Band display name
% o.pre.bandsF = [5 8; 8 14; 14 30; 30 60; 60 200]; % Band limits

% o.pre.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb"]; % Band name
% o.pre.bands2 = ["Delta (2-4hz)" "Theta (4-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
%     "Gamma (30-60hz)" "HFB (60-200hz)"]; % Band display name
% o.pre.bandsF = [2 4; 4 8; 8 14; 14 30; 30 60; 60 200]; % Band limits



%% Logs
if ~exist('logs','var')
    %%
    date = string(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));
    o.name = analName+"_"+date;

    logs = table;
    logs.sbj = string(sbjs);
    logs.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    logs.name(:) = analName+"_"+date;
    logs.class(:) = false;
    logs.post(:) = false;
    logs.plot(:) = false;
    logs.o = cell(numel(sbjs),1);
    logs.n = cell(numel(sbjs),1);
    logs.time(:) = date;
    logs.error = cell(numel(sbjs),1);
    logs.out(:) = dirs.anal+analFolder+filesep+logs.name(1)+filesep;
    logs.fn(:) = logs.out(1)+"log_"+date+".mat";
end



%% Initialize threadpool
try reset(gpuDevice); catch;end
try delete(gcp("nocreate")); catch;end
try ppool = parpool("threads"); catch;end
% s=5; %sbj38
% s=9; %sbj42
% s=21; %sbj60


%% Loop across subjects
for s = 1:height(logs)
    if ~logs.class(s)
        % Set options struct per subject
        sbj = logs.sbj(s);
        sbjID = logs.sbjID(s);
        o.dirs = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=o.p.sfx);
        o.p.dirs = o.dirs;
        o.dirOut = logs.out(s);
        o.dirOutSbj = o.dirOut+"s"+sbjID+filesep;
        disp("STARTING: "+sbj);

        %% Run subject
        if ~exist(logs.out(s),"dir"); mkdir(logs.out(s)); end
        try
            [logs.o{s},logs.n{s}] = ec_classifySpec(o);
            logs.class(s) = true;
        catch ME; getReport(ME)
            logs.error{s} = ME;
            logs.class(s) = false;
        end

        %% Save logs
        logs.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
        save(logs.fn(s),'logs','-v7');

    else
        disp("SKIPPING: "+o.name);
    end
end
