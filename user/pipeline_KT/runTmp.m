% Subject Names
% sbjs = ["S12_38_LK" "S12_42_NC"...
%     "S12_33_DA" "S12_34_TC" "S12_35_LM" "S12_36_SrS" "S12_39_RT",...
%     "S12_40_MJ" "S12_41_KS" "S12_45_LR" "S13_46_JDB" "S13_47_JT2" "S13_50_LGM",...
%     "S13_51_MTL" "S13_52_FVV" "S13_53_KS2" "S13_54_KDH" "S13_56_THS" "S13_57_TVD",...
%     "S13_59_SRR" "S13_60_DY" "S14_62_JW" "S14_66_CZ" "S14_67_RH" "S14_74_OD",...
%     "S14_75_TB" "S14_76_AA" "S14_78_RS" "S15_81_RM" "S15_82_JB" "S15_83_RR",...
%     "S15_87_RL" "S16_95_JOB" "S16_96_LF"]';
sbjs = ["S12_38_LK" "S12_42_NC" "S13_60_DY" "S14_78_RS"]';
if ~exist('splitSbj','var'); splitSbj = 0; end
nameFn = string(datetime('now','Format','yyMMdd'));

% Basic info
o = struct;
o.sbj = "";
o.sbjID = [];
o.proj = "lbcn";
o.task = "MMR";
o.test = false;
o.savePrep = true;
o.save = true; % save summary stats data
o.gpu = false;
o.dsTarg = []; % Downsampling target

% Frequency bands
o.freqIdx = []; %28:83; % Indices of frequencies to keep: x(:,:,freqIdx)
o.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb" "hfb2" "lfp"]; % Band name
o.bands2 = ["Delta (1-4hz)" "Theta (4-8hz)" "Alpha (8-13hz)" "Beta (13-30hz)"...
    "Gamma (30-60hz)" "HFB (60-180hz)" "HFB+ (180-300hz)" "LFP (ERP)"]; % Band display name
o.bandLims = [1 4; 4 8; 8 13; 13 30; 30 60; 60 180; 180 301; 0 0]; % Band limits

% Task conditions (list by nominal order)
o.conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"];
o.conds2 = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % must match order of 'o.conds'

% Epoching (see 'ec_epochPsy')
o.epoch.bin = 0.02; % Fine latency bin width (secs)
o.epoch.bin2 = 0.1; % Coarse latency bin width (secs)
o.epoch.pct = 1; % Fine latency percent width (percentile)
o.epoch.pct2 = 5; % Coarse latency percent width (percentile)
% Epoch baseline period (none=[0 0]):
o.epoch.baselinePre = [-0.3 0]; % Pre-stimulus baseline start/end (secs from stim onset); ex=[-0.2 0]
o.epoch.baselineEnd = [0 0]; % Post-stimulus baseline start/end (secs from next stim onset); ex=[-0.1 0]
% Epoch time limits (variable limits=[0 0]):
o.epoch.lims = [0 0]; % Epoch start & end from stim onset (secs); ex=[-0.2 3]
o.epoch.limsRT = [0 0]; % Epoch start & end from behavioral RT (secs); ex=[-1.5 .5]
o.epoch.limtsPct = [0 0]; % Epoch start & end from latency percentile; ex=[-10 120]

% Classifier temporal binning variable (classify within timebin per channel/IC)
o.t = "pct2"; % "latency" "bin" "bin2" "pct" "pct2"

% Classifier basic options
o.class.fun = "fitclinear";             % Classifier function ("fitcknn", "fitclinear", or "fitcsvm")
o.class.cond = ["Semantic" "Episodic"]; % Conditions to classify (train & test)
o.class.condx = ["Self" "Other"];       % Coditions to cross-classify (test only)
o.class.ol = "median";                  % Outlier detection method (mathworks.com/help/stats/filloutlier.html)
o.class.olFill = "clip";                % Outlier fill method
o.class.olThrAll = 7.5;                 % Outlier threshold (all observations)
o.class.olThrCond = 5;                  % Outlier threshold (within-condition)
o.class.pca = 0;                        % Number of spectral PCA components (0 = no PCA)
o.class.std = true;                     % Standardize predictors (z-score)

% Classifier hyperparameters
if o.class.fun == "fitcknn"
    % KNN hyperparameters (mathworks.com/help/stats/fitcknn.html)
    o.hyper.Distance = "euclidean";
    o.hyper.NumNeighbors = 25;
    o.hyper.DistanceWeight = "inverse";
    o.hyper.Prior = "empirical";
    o.hyper.std = true;
    % o.hyper.ScoreTransform = "invlogit";

elseif o.class.fun == "fitclinear"
    % SVM hyperparameters (mathworks.com/help/stats/fitclinear.html)
    o.hyper.Learner = "svm";
    o.hyper.Lambda = "auto";
    o.hyper.Regularization = "ridge";
    o.hyper.Solver = "dual";
    o.hyper.Prior = "empirical";
    o.hyper.FitBias = true;
    o.hyper.PostFitBias = false;
    o.hyper.OptimizeLearnRate = true;
    o.hyper.Verbose = 0;
end

% Cross-validation parameters (mathworks.com/help/stats/crossval.html)
o.crossval.KFold = 10;
% o.crossval.Leaveout = "on";

% Optimize hyperparameters (mathworks.com/help/stats/bayesopt.html)
o.bayes.OptimizeHyperparameters = "Lambda"; % "none","Lambda"
o.bayes.HyperparameterOptimizationOptions =...
    struct(ShowPlots=false,Verbose=0,Optimizer="bayesopt",Kfold=5,Repartition=true,...
    AcquisitionFunctionName="expected-improvement-plus",MaxObjectiveEvaluations=30);

% Preprocessing (see 'ec_epochBaseline')
o.pre.double = true;
o.pre.singleOut = true;
o.pre.gpu = false; % CPU appears faster
o.pre.log = false; % Log transform
o.pre.runNorm = "robust"; % Normalize run
o.pre.trialNorm = "robust"; % Normalize trial
o.pre.trialNormByBaseline = false; % Divide trial by baseline norm
o.pre.trialBaseline = "median"; % Subtract trial by mean or median of baseline period (skip=[])
% Bad frames/outliers
o.pre.interp = "linear";
o.pre.badFields = ""; % skip=""
o.pre.olCenter = "median";
o.pre.olThr = 5; %5; % Threshold for outlier
o.pre.olThr2 = 5; %0; % Threshold for outlier
o.pre.olThrBL = 5; %3; % Threshold for baseline outlier
% PCA (skip=[])
o.pre.pca = 0; % Components to keep across channels
o.pre.pcaSpec = 0; % Spectral components to keep per channel
% Filtering (within-run):
o.pre.hpf = 0.1; % Hi-pass cutoff in hertz (skip=0)
o.pre.hpfSteep = 0.5;
o.pre.hpfImpulse = "iir"; %"iir";
o.pre.lpf = 0; % lo-pass in hz (skip=0)
o.pre.lpfSteep = 0.85;
o.pre.lpfImpulse = "auto";

% % Plot options
% o.plotType = "ERFP";
% o.plot = ecu_genPlotParams(o.plotType,o.task);
% o.plot.visible = 0;
% o.plot.save = 1;
% o.plot.doGPU = 0;
% o.plot.legend = true;
% o.plot.trialwise = true;
% o.plot.clim = [-4 4];
% o.plot.climICA = [];
% o.plot.climICA_z = [-6 6];
% o.plot.alpha = 0.95;
% o.plot.textcol = [.8 .8 .8];
% o.plot.o1D = struct;
% o.plot.o1D.style= '-';
% o.plot.o1D.width = 1;
% o.plot.o1D.edgestyle = ':';
% for c = 1:numel(o.conds)
%     o.plot.o1D.col{c} = o.plot.col(c,:);
% end
%
% % Cache
% if o.gpu
%     o.cache = floor((gpuDevice().AvailableMemory/1e6) * .95); % fitcsvm shares cache among all workers?
%     % o.cache = floor((gpuDevice().AvailableMemory/o.svm_par{2})/1e6);
% else
%     o.cache = 'maximal';
% end
%
% % Detrending (within-run to avoid edge artifacts)
% o.detrendGPU = 1; % 0=CPU; 1=gpuArray; 2=compiled CUDA binaries (must compile: ec_compileBins)
% o.detrendSingle = true;
% % Robust detrending (pre-referencing)
% o.detrendOrder = []; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
% o.detrendThr =   2.5; %repmat(2.5,1,3); %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
% o.detrendItr =   5;  %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
% o.detrendWin =   0; % detrend timewindow in seconds {entire run=[],default=[]}


%%
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/classify/classifySpec_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('statusSum','var')
    statusEC = table;
    statusEC.sbj = sbjs;
    statusEC.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    statusEC.prep(:,1:2) = nan;
    statusEC.classify(:,1:2) = nan;
    statusEC.stats(:,1:2) = nan;
    statusEC.plot(:,1:2) = nan;
    statusEC.time(:,1:2) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    statusEC.error = cell(numel(sbjs),2);
end
wo = warning('off','MATLAB:MKDIR:DirectoryExists');
try ppool = parpool("Threads"); catch;end
%try delete(gcp("nocreate")); catch;end
%try ppool = parpool("Processes",24); catch;end


%% Run prep %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for s = 1:height(statusEC)
    if splitSbj==1
        if ~any(rem(s,2)); continue; end
    elseif splitSbj==2
        if any(rem(s,2)); continue; end
    end
    for ii = 1 %1:2 %1 %:2
        if statusEC.prep(s,ii)~=1 %&& isempty(statusP.error{s})
            % s=1; ii=1;   
            if ii==1; o.ICA=1; o.sfx="is"; o.name=nameFn+"_ic"; end
            if ii==2; o.ICA=0; o.sfx="s"; o.name=nameFn+"_ch"; end
            o.dirs = ec_getDirs(o.proj,statusEC.sbj(s),o.task);
            o.sbj=o.dirs.sbj; o.sbjID=o.dirs.sbjID;
            
            %%
            try 
                disp("[ec_classifySpec] STARTING: "+o.sbj);
                oo = namedargs2cell(o);
                ec_classifySpec(oo{:},prep=1,classify=1,stats=0,figures=0);
                statusEC.prep(s,ii) = 1;
                statusEC.classify(s,ii) = 1;
            catch ME; getReport(ME)
                statusEC.error{s,ii} = ME;
                statusEC.prep(s,ii) = 0;
                statusEC.classify(s,ii) = 0;
                if o.gpu || o.pre.gpu
                    try parfevalOnAll(@gpuDevice,0,[]); catch;end
                    try reset(gpuDevice()); catch;end
                    try delete(gcp('nocreate')); catch;end
                end
            end

            %%
            statusEC.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,'statusEC','-v7');
        else
            if ii==1; disp("SKIPPING: "+statusEC.sbj(s)+" ICA");
            else; disp("SKIPPING: "+statusEC.sbj(s)+" chan");
            end
        end
    end
end
try warning(wo);catch;end


