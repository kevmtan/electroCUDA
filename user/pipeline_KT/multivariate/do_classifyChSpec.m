sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";...
    "S12_40_MJ";"S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";...
    "S13_50_LGM";"S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";...
    "S13_57_TVD";"S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";...
    "S14_74_OD";"S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";...
    "S15_83_RR";"S16_95_JOB";"S16_96_LF"];
%sbjs = "S12_38_LK"; %["S12_38_LK";"S12_42_NC"];
proj = "lbcn";
task = "MMR"; % task name
analFolder = "classifyChSpec";
analName = "MzAb_regLDA";

dirs = ec_getDirs(proj,task);

% Initialize options struct
o = struct;
o.name = ""; % Analysis name (filled in subject loop)
o.sfx = ""; % Suffix of input data (filled in subject loop)

%% Options
o.test = false;
o.save = true;
o.chBadFields = "bad"; % fields from n.chBad/icBad that exclude chans from analysis

% Processing options
o.gpu = false; % do GPU
o.typeProc = "single"; % processing floating-point precision ("double"|"single")
o.typeOut = "single"; % output floating-point precision ("double"|"single")

% Timing for classification
o.timeVar = "bin"; % Timepoint variable from 'psy'/'ep' ["frame"|"latency"|"bin"|"binPct"|"binRT"]
o.timeRng = [-200 2000]; % Range of times to run (indlude baseline)
o.psyVars = ["frame" "latency" "pct" "RT" "resp" "valence"]; % psy vars to include in results output

% Conditions for classification
o.condVar = "cond";
o.cond = ["Semantic" "Episodic"]; % Conditions to classify (train & test)
o.condx = ["Self" "Other"];       % Conditions to cross-classify (predict)

% Outliers within timepoint
o.ol = "median"; % Outlier detection method (mathworks.com/help/stats/filloutlier.html)
o.olFill = "clip"; % Outlier fill method
o.olThrAll = 7.5; % Outlier threshold (all observations)
o.olThrCond = 3; % Outlier threshold (within-condition)

% Stats options
o.alpha = 0.05; % Critical p-value (default=0.05)
o.fdrTimeRng = [0 inf]; % Range of times for FDR
o.fdrDep = "unknown"; % Dependence structure for FDR ["unknown"|"corr+"|"corr-"|"indep"]

% Classifier basic options
o.fun = "fitcdiscr"; % Classifier function ("fitcknn", "fitclinear", or "fitcsvm")
o.nMin = 30; % minimum observations per class within timepoint
o.balanceConds = true; % balance sample size per class within timepoint 
o.pca = 0; % Spectral PCA within timepoint (0 = no PCA)
o.std = ""; % Standardize predictors (z-score)

% Cross-validation parameters (mathworks.com/help/stats/crossval.html)
o.crossval.KFold = 10; % o.crossval.Leaveout = "on";
% Cross-validation for hyperparameter optimization
o.hyperOptKFold = 5;

% Classifier hyperparameters
o.hyper = struct;
o.hyper.Prior = "uniform";
if o.fun == "fitcsvm"
    % SVM hyperparameters (mathworks.com/help/stats/fitcsvm.html)
    o.hyper.KernelFunction = "linear";
    o.hyper.BoxConstraint = 1;
    o.hyper.KernelScale = "auto";
    o.hyper.Standardize = false;
    o.hyper.Solver = "SMO";
    o.hyper.CacheSize = "maximal";
    o.hyper.Verbose = 0;
elseif o.fun == "fitclinear"
    % Linear SVM hyperparameters (mathworks.com/help/stats/fitclinear.html)
    o.hyper.Learner = "svm";
    o.hyper.Lambda = "auto";
    o.hyper.Regularization = "ridge";
    o.hyper.Solver = "lbfgs";
    o.hyper.FitBias = true;
    o.hyper.PostFitBias = false;
    o.hyper.OptimizeLearnRate = true;
    o.hyper.Verbose = 0;
elseif o.fun == "fitcdiscr"
    o.hyper.DiscrimType = "linear";
elseif o.fun == "fitcknn"
    % KNN hyperparameters (mathworks.com/help/stats/fitcknn.html)
    o.hyper.Distance = "euclidean";
    o.hyper.NumNeighbors = 25;
    o.hyper.DistanceWeight = "inverse";
    o.hyper.std = true;
    % o.hyper.ScoreTransform = "invlogit";
end

% Optimize hyperparameters (mathworks.com/help/stats/bayesopt.html)
if o.fun == "fitcsvm"
    o.OptimizeHyperparameters = "BoxConstraint"; % "BoxConstraint" "KernelScale"
elseif o.fun == "fitclinear"
    o.OptimizeHyperparameters = "Lambda"; % "Lambda" "Learner"
elseif o.fun == "fitcdiscr"
    o.OptimizeHyperparameters = ["Gamma" "Delta"]; % "Gamma" "Delta"
elseif o.fun == "fitcknn"
    o.OptimizeHyperparameters = ["Distance" "NumNeighbors"];
end
o.HyperparameterOptimizationOptions =...
    struct(ShowPlots=false,Verbose=0,Optimizer="bayesopt",Repartition=false,...
    AcquisitionFunctionName="expected-improvement-plus",MaxObjectiveEvaluations=30);
%struct(ShowPlots=false,Verbose=0,Optimizer="bayesopt",Kfold=5,Repartition=true,...
%AcquisitionFunctionName="expected-improvement-plus",MaxObjectiveEvaluations=30);

% Task Epoching (see 'ec_epochPsy')
o.epoch.float = "single"; % task metadata output floating-point precision
% Bad trial removal
o.epoch.rmTrials = []; % Trials to remove (numeric array or logical index)
o.epoch.rmTrialsFun = @(t) ~(t.RT>0.1) & t.cond~="Rest"; % Function for removing trials
o.epoch.badTrials = ""; % Bad trial removal criteria
% Epoch time limits (secs) [nan=variable, 0=none]
o.epoch.pre = nan; % Duration before stim onset [nan = pre-stim ITI]
o.epoch.post = nan; % Duration after stim offset [nan = post-stim ITI]
o.epoch.max = nan; % Max duration after stim onset, supercedes 'post' [nan = no limit]
% Epoch time bins
o.epoch.bin = 0.05; % latency bin width (secs)
o.epoch.binPct = 5; % latency percentage bin width (<=100)
% Epoch baseline period for subsequent processing
%   (none=[], all pre/post times=inf, relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
o.epoch.baselinePre = -0.2; % Pre-stimulus baseline (secs from stim onset): inf=ITI; [-.2]; [-0.2 1]
o.epoch.baselinePost = []; % Post-stimulus baseline (secs from stim offset): inf=ITI; [.2]; [0.1 0.3]
% Task condition ordering - all conds in data (leave blank for to leave unordered)
o.epoch.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
o.epoch.conds2 = []; % custom condition names (per above order, can repeat)
%   o.epoch.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
%   o.epoch.conds2 = ["Mz" "Mz" "Ab" "Ab" "Math" "Rest"]; % custom condition names (per above order, can repeat)

% Preprocessing (see 'ec_epochBaseline')
o.pre.gpu = false; % Run on GPU? (note: CPU appears faster)
o.pre.typeProc = "double"; % processing FP precision ("double"|"single"|""=same as input)
o.pre.typeOut = "single"; % output FP precision ("double"|"single"|""=same as input)
o.pre.hzTarget = nan; % Target sampling rate (nan=default rate)
o.pre.log = false; % Log transform
o.pre.mag2db = true; % Log-transform magnitude to decibel
o.pre.runNorm = "robust"; % Normalize run
o.pre.trialNorm = ""; % Normalize trial ["robust"|"zscore"|""]; skip=""
o.pre.trialNormDev = "all"; % Timepoints for StdDev ["baseline"|"pre"|"post"|"on"|"off"|"all"] (default="baseline")
o.pre.trialBaseline = "median"; % Subtract trial by mean or median of baseline period (skip=[])
% Bad frames/outliers
o.pre.interp = "linear";
o.pre.badFields = "hfo"; % ["hfo" "mad" "diff" "sns"]
o.pre.olCenter = "median";
o.pre.olThr = 5; % Threshold for outlier (skip=0)
o.pre.olThr2 = 0; % Threshold for 2nd outlier after HPF (skip=0)
o.pre.olThrBL = 2; % Threshold for baseline outlier (skip=0)
% Filtering (within-run):
o.pre.hpf = 0; % HPF cutoff in hertz (skip=0)
o.pre.hpfSteep = 0.7; % HPF steepness
o.pre.hpfImpulse = "fir"; % HPF impulse: ["auto"|"fir"|"iir"]
o.pre.lpf = 20; % LPF cutoff in hz (skip=0)
o.pre.lpfSteep = 0.5; % LPF steepness
o.pre.lpfImpulse = "fir"; % LPF impulse: ["auto"|"fir"|"iir"]
% Spectral dimensionality reduction by PCA (skip=0)
o.pre.pca = 0; % Spectral components to keep per channel
% Spectral dimensionality reduction into bands (skip=[])
o.pre.bands = ["theta" "alpha" "beta" "gamma" "hfb"]; % Band name
o.pre.bands2 = ["Theta (5-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
    "Gamma (30-60hz)" "HFB (60-200hz)"]; % Band display name
o.pre.bandsF = [5 8; 8 14; 14 30; 30 60; 60 200]; % Band limits

% o.pre.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb"]; % Band name
% o.pre.bands2 = ["Delta (2-4hz)" "Theta (4-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
%     "Gamma (30-60hz)" "HFB (60-200hz)"]; % Band display name
% o.pre.bandsF = [2 4; 4 8; 8 14; 14 30; 30 60; 60 200]; % Band limits



%% Logs
if ~exist('logs','var')
    date = string(datetime('now','TimeZone','local','Format','yyMMdd'));
    startTime = string(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));

    logs = table;
    logs.name(1) = analName+"_ch_"+date;
    logs.name(2) = analName+"_ic_"+date;
    logs.ICA = [false;true];
    logs.sfx = ["s";"is"];

    logs.i{1} = table;
    logs.i{1}.sbj = string(sbjs);
    logs.i{1}.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    logs.i{1}.class(:) = false;
    logs.i{1}.plot(:) = false;
    logs.i{1}.o = cell(numel(sbjs),1);
    logs.i{1}.time(:) = startTime;
    logs.i{1}.error = cell(numel(sbjs),1);

    logs.i{2} = logs.i{1};

    for p = 1:2
        logs.out(p) = dirs.anal+analFolder+filesep+logs.name(p)+filesep;
        logs.out(p) = dirs.anal+analFolder+filesep+logs.name(p)+filesep;
        logs.fn(p) = logs.out(p)+"log_"+startTime+".mat";
    end
end



%% Do classification per sbj %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try delete(gcp("nocreate")); catch;end
try parpool("threads"); catch;end

% Loop across subjects
for s = 1:height(logs.i{1})
    for p = 1 %1:2 % Switch EEG data: channels (1) or independent components (2)
        if ~logs.i{p}.class(s)
            % Set options struct per subject
            sbj = logs.i{p}.sbj(s);
            o.name = logs.name(p);
            o.sfx = logs.sfx(p);
            o.ICA = logs.ICA(p);
            o.dirs = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=o.sfx);
            o.dirOut = logs.out(p);
            sbjID = logs.i{p}.sbjID(s);
            %o.dirOutSbj = o.dirOut+"s"+sbjID+filesep;

            %% Run subject
            if ~exist(logs.out(p),"dir"); mkdir(logs.out(p)); end
            try
                disp("STARTING: "+sbj);
                logs.i{p}.o{s} = ec_classifyChSpec(o);
                logs.i{p}.class(s) = true;
            catch ME; getReport(ME)
                logs.i{p}.error{s} = ME;
                logs.i{p}.class(s) = false;
            end

            %% Save logs
            logs.i{p}.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(logs.fn(p),'logs','-v7');

        else
            disp("SKIPPING: "+o.name);
        end
    end
end
