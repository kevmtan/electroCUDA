% Subject Names
sbjs = {'S12_38_LK','S12_42_NC',...
    'S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS','S12_39_RT',...
    'S12_40_MJ','S12_41_KS','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
    'S15_87_RL','S16_95_JOB','S16_96_LF'}';
% sbjs = {'S12_38_LK','S12_42_NC'}';

% Basic info
proj = 'lbcn';
task = 'MMR';
usrStr = "Kevin_DMN";
plotType = "spec"; % "hfb-lfp"; % "spec";
doICA = false;
nameStr = string(datetime('now','Format','yyMMdd'));
sfx = ""; %"";

isTest = false;

% Options struct
o = struct;
o.name = nameStr;
o.save = true; %% save summary stats data %%%%
o.gpu = false;

% Timing (in seconds)
o.fsTarg = []; % Target sampling rate
o.BLpre = [-0.3 0]; % Pre-stimulus baseline start/end (secs from stim onset); ex=[-0.2 0]
o.BLend = []; % Post-stimulus baseline start/end (secs from next stim onset); ex=[-0.1 0]
o.bin = 0.02; % Latency bin width (seconds)
o.bin2 = 0.1; % Latency bin2 width (seconds)
o.pct2 = 10; % 'Downsampled version' Percent RT width (percentile)

% Ensure trial epochs contain these times (skip=[])
o.epoch = []; %[-0.2 3]; % Stimulus-locked epochs start/end (secs from stim onset); ex=[-0.2 3]
o.epochRT = []; %o.BLpre; % RT-locked epochs start/end (secs from RT; ex=[-1.5 .5])
o.epochPct = []; %[o.epoch(1) 1+o.epochRT(2)];

% Frequency bands
o.freqIdx = []; %[1 14 20:4:83];
o.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb" "hfb2" "lfp"]; % Band name
o.bands2 = ["Delta (1-4hz)" "Theta (4-8hz)" "Alpha (8-13hz)" "Beta (13-30hz)"...
    "Gamma (30-60hz)" "HFB (60-180hz)" "HFB+ (180-300hz)" "LFP (ERP)"]; % Band display name
o.bandsF = [1 4; 4 8; 8 13; 13 30; 30 60; 60 180; 180 301; 0 0]; % Band limits

% All Conditions
o.conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"]; % order
o.conds2 = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % custom condition names

% SVM classifier options
o.t = "pct2";                          % Time variable to classify by
o.tO = "pct2";                        % Time variable to optimize by
o.svm_cond = ["Semantic" "Episodic"]; % Conds for binary SVM classificaiton
o.svm_condx = ["Self" "Other"];       % Conds for cross-classification
o.svm_kFold = 10;                     % Cross-validation folds
o.svm_std = true;                    % Z-score predictors
o.svm_rmData = 1;                 % Remove libsvm-formatted data from disk after completion
o.svm_par = {'Processes',20};

% SVM hyperparameters (defined here: github.com/cjlin1/libsvm)
%   use default value = 0
o.svm.type = 0;     % SVM type (-s)
o.svm.kernel = 0;   % kernel type (-t)
o.svm.degree = 0;   % Polynomial degree (-d)
o.svm.gamma = 0;    % Gamma of kernel function (-g)
o.svm.cost = 0;     % Cost/boxconstraint (-c)
o.svm.nu = 0;       % Nu for nu-SVC/SVR (-n)
o.svm.epsilon = 0;  % Epsilon for epsilon-SVR (-p)
o.svm.wi(1:numel(o.svm_cond)) = 0;  % Weights per condition (-wi)
o.svm.tol = 0;      % Termination tolerance (-e)
o.svm.prob = 1;     % Do posterior probabilities (-b)
o.svm.gpu = 0;      % Which GPU (-u)
o.svm.custom = "";  % Custom thundersvm-train arguments
o.svm.mem = floor(gpuDevice(o.svm.gpu+1).AvailableMemory/1e6);
% o.svm.mem = floor((gpuDevice(o.svm.gpu+1).AvailableMemory/o.svm_par{2})/1e6);
o.svm.ys = 0:numel(o.svm_cond)-1;     % Class labels (must be integers)
o.svm.binary = ec_paths().thundersvm; % Directory for ThunderSVM binaries


% SVM hyperparameter Bayesian optimization (mathworks.com/help/stats/bayesopt.html)
o.bayesopt_do = false;
o.bayesopt = o.svm;
o.bayesopt.vars = "cost";                  % hyperparameters to optimize (just 2)
o.bayesopt.varsRng = [1e-3 1e3];           % value range
o.bayesopt.varsInit = [.01 .1 1 10]; %[.01 .1 1 10; .05 .05 .05 .05]; % initial values
o.bayesopt.deterministic = true;                     % Deterministic or stochastic objective?
o.bayesopt.acFun = "expected-improvement-plus";      % Acquisition function
o.bayesopt.maxEvals = 20;                            % Maximum evaluations (iterations)
o.bayesopt.verbose = 1;                              % Command window output
o.bayesopt.plot = [];                                % Plot handles (no plots = [])
o.bayesopt.parallel = false;                         % Do parallel (disable: already parallel)
o.bayesopt.kfold = 5;                               % Cross-validation folds (-v)
o.bayesopt.prob = 0;                                 % Do posterior probabilities (-b)
o.bayesopt.rmData = true;

% Preproc
o.logSpec = false; %
o.normalizeSpec = "robust";

% % Detrending (within-run to avoid edge artifacts)
% o.detrendGPU = 1; % 0=CPU; 1=gpuArray; 2=compiled CUDA binaries (must compile: ec_compileBins)
% o.detrendSingle = true;
% % Robust detrending (pre-referencing)
% o.detrendOrder = []; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
% o.detrendThr =   2.5; %repmat(2.5,1,3); %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
% o.detrendItr =   5;  %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
% o.detrendWin =   0; % detrend timewindow in seconds {entire run=[],default=[]}

% Filtering (within blocks)
o.hiPass = 0.1; % Hi-pass cutoff in hertz (skip=0)
o.hiPassSteep = 0.5;
o.hiPassImpulse = "iir"; % GPU slower than CPU??
o.loPass = 0; % lo-pass in hz (skip=0)
o.loPassSteep = 0.5;
o.loPassImpulse = "auto";

% Downsampling
o.dsTarg = [];

% Bad frames
o.missingInterp = "linear";
o.badFields = []; %["hfo" "mad" "diff" "sns"]
o.outlierCenter = "median";
o.thrOL = 5; %[5 5]; % Lower and upper quantiles for outlier
o.thrOLbl = 2.5;

% PCA
o.pca = 30;
o.pcaOl = "quartiles";
o.pcaOlThr = 3;

% Plot options
o.oP = genPlotParams('MMR','timecourse');
o.oP.visible = 0;
o.oP.save = 1;
o.oP.doGPU = 0;
o.oP.clim = [-4 4];
o.oP.climICA = [];
o.oP.climICA_z = [-6 6];
o.oP.alpha = 0.95;
o.oP.o1D = struct;
o.oP.o1D.style= '-';
o.oP.o1D.width = 1;
o.oP.o1D.edgestyle = ':';
for c = 1:numel(o.conds)
    o.oP.o1D.col{c} = o.oP.col(c,:);
end
o.oP.textcol = [.8 .8 .8];
if plotType=="hfb"
    o.oP.textsize = 14;
elseif plotType=="hfb-lfp"
    o.oP.textsize = 14;
else
    o.oP.textsize = 8;
end

% o.fitcsvm =...
%     {'KernelFunction','linear','Solver','SMO','Standardize',1,'CacheSize','maximal'};
% o.t = "pct";
% 
% % SVM optimization options
% o.svmOpt = horzcat(o.fitcsvm,...
%     {'OptimizeHyperparameters',{'BoxConstraint','KernelScale'} ,...
%     'HyperparameterOptimizationOptions',...
%     struct(Optimizer='bayesopt',ShowPlots=0,Verbose=0,Repartition=1,KFold=5,... % UseParallel=1,...
%     AcquisitionFunctionName='expected-improvement-plus',MaxObjectiveEvaluations=30)});
% o.tO = "pct2";


%%
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/svmSpec/svmSpec_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('statusSum','var')
    statusEC = table;
    statusEC.sbj = string(sbjs);
    statusEC.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    statusEC.prep(:,1:2) = nan;
    statusEC.svm(:,1:2) = nan;
    statusEC.stats(:,1:2) = nan;
    statusEC.plot(:,1:2) = nan;
    statusEC.time(:,1:2) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    statusEC.error = cell(numel(sbjs),2);
end
% try delete(gcp("nocreate")); catch;end
% ppool = parpool(o.svm_par{1},o.svm_par{2});


%% Run prep %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try delete(gcp("nocreate")); catch;end
try ppool = parpool(o.svm_par{1},o.svm_par{2}); catch;end

for s = 1:height(statusEC)
    for ii = 1 %1:2 %1 %:2
        if statusEC.prep(s,ii)~=1 %&& isempty(statusP.error{s})
            % s=1; ii=1;
            if ii==1; doICA=1; sfx="is"; o.name=nameStr+"_ic"; end
            if ii==2; doICA=0; sfx="s"; o.name=nameStr+"_ch"; end
            sbj = statusEC.sbj{s};
            dirs = ec_getDirs(proj,sbj,task);
            o.sbj=dirs.sbj; o.sbjID=dirs.sbjID;
            o.dirIn = dirs.procSbj; %
            o.dirFS = dirs.fsSbj; % Freesurfer subjects dir
            o.dirOut = dirs.anal+"svmSpectral/"+o.name+"/";
            o.dirOutSbj = dirs.anal+"svmSpectral/"+o.name+"/s"+statusEC.sbjID(s)+"/";

            %%
            try
                disp("[ec_svmSpectral] STARTING SVM: "+sbj);
                ec_classifySpec_thundersvm(dirs,o,prep=1,svm=1,stats=0,plot=0,...
                    sfx=sfx,ICA=doICA,test=isTest);
                statusEC.prep(s,ii) = 1;
                statusEC.svm(s,ii) = 1;
            catch ME; getReport(ME)
                statusEC.error{s,ii} = ME;
                statusEC.prep(s,ii) = 0;
                statusEC.svm(s,ii) = 0;
                % try parfevalOnAll(@gpuDevice,0,[]); catch;end
                % try reset(gpuDevice()); catch;end
                % try delete(gcp('nocreate')); catch;end
            end

            %%
            statusEC.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,'statusEC','-v7');
        else
            disp("SKIPPING: "+o.name);
        end
    end
end


% %% Run SVM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try delete(gcp("nocreate")); catch;end
% try ppool = parpool(o.svm_par{1},o.svm_par{2}); catch;end
% for s = 1:height(statusEC)
%     for ii = 1 %1:2 %1 %:2
%         if statusEC.svm(s,ii)==1 && statusEC.stats(s,ii)~=1 
%             % s=1; ii=1;
%             if ii==1; doICA=1; sfx="is"; o.name=nameStr+"_ic"; end
%             if ii==2; doICA=0; sfx="s"; o.name=nameStr+"_ch"; end
%             sbj = statusEC.sbj{s};
%             dirs = ec_getDirs(proj,sbj,task);
%             o.sbj=dirs.sbj; o.sbjID=dirs.sbjID;
%             o.dirIn = dirs.procSbj; %
%             o.dirFS = dirs.fsSbj; % Freesurfer subjects dir
%             o.dirOut = dirs.anal+"svmSpectral/"+o.name+"/";
%             o.dirOutSbj = dirs.anal+"svmSpectral/"+o.name+"/s"+statusEC.sbjID(s)+"/";
% 
%             %%
%             try
%                 disp("[ec_svmSpectral] STARTING STATS: "+sbj);
%                 ec_svmSpectral(dirs,o,prep=0,svm=0,stats=1,plot=1,...
%                     sfx=sfx,ICA=doICA,test=isTest);
%                 statusEC.stats(s,ii) = 1;
%             catch ME; getReport(ME)
%                 statusEC.error{s,ii} = ME;
%                 statusEC.stats(s,ii) = 0;
%             end
% 
%             %%
%             statusEC.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
%             save(sbjFinFn,'statusEC','-v7');
%         else
%             disp("SKIPPING: "+o.name);
%         end
%     end
% end



