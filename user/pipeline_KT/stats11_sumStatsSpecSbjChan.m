%% Task info

% Subject Names
sbjs = {'S12_38_LK','S12_42_NC','S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS',...
    'S12_39_RT','S12_40_MJ','S12_41_KS','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR','S15_87_RL',...
    'S16_95_JOB','S16_96_LF'}';
% sbjs = {'S12_38_LK'};

proj = "lbcn";
task = "MMR"; % task name
dirs = ec_getDirs(proj,task);

saveStats = true; % save summary stats data


%% Options

% Options struct
o = struct;
o.sfx = "";
o.gpu = false;

% Epoching (see 'ec_epochPsy')
o.epoch.bin = 0.02; % Fine latency bin width (secs)
o.epoch.bin2 = 0.02; % Coarse latency bin width (secs)
o.epoch.pct = 1; % Fine latency percent width (percentile)
o.epoch.pct2 = 10; % Coarse latency percent width (percentile)
% Epoch baseline period (none=[0 0]):
o.epoch.baselinePre = [-0.3 0]; % Pre-stimulus baseline start/end (secs from stim onset); ex=[-0.2 0]
o.epoch.baselineEnd = [0 0]; % Post-stimulus baseline start/end (secs from next stim onset); ex=[-0.1 0]
% Epoch time limits (variable limits=[0 0]):
o.epoch.lims = [0 0]; % Epoch start & end from stim onset (secs); ex=[-0.2 3]
o.epoch.limsRT = [0 0]; % Epoch start & end from behavioral RT (secs); ex=[-1.5 .5]
o.epoch.limtsPct = [0 0]; % Epoch start & end from latency percentile; ex=[-10 120]

% Preprocessing (see 'ec_epochBaseline')
o.pre.double = true;
o.pre.singleOut = true;
o.pre.gpu = false; % CPU appears faster
o.pre.hzTarg = nan; % Target sampling rate
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
o.pre.olThrBL = 3; %3; % Threshold for baseline outlier
% PCA (skip=[])
o.pre.pca = 0; % Components to keep across channels
o.pre.pcaSpec = 0; % Spectral components to keep per channel
% Filtering (within-run):
o.pre.hpf = 0; % Hi-pass cutoff in hertz (skip=0)
o.pre.hpfSteep = 0.75; % default 0.5
o.pre.hpfImpulse = "fir"; %"iir";
o.pre.lpf = 20; % lo-pass in hz (skip=0)
o.pre.lpfSteep = 0.5;
o.pre.lpfImpulse = "fir";

% Stats
o.stats.epoch = [-.2 3];
o.stats.epochRT = [-1.5 .2];
o.stats.epochPct = [-.1 1.1];

% Frequency bands
o.freqIdx = []; %[1 14 20:4:83];
o.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb" "hfb2" "lfp"]; % Band name
o.bands2 = ["Delta (1-4hz)" "Theta (4-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
    "Gamma (30-60hz)" "HFB (60-180hz)" "HFB+ (180-300hz)" "LFP (ERP)"]; % Band display name
o.bandsF = [1 4; 4 8; 8 14; 14 30; 30 60; 60 180; 180 301; 0 0]; % Band limits

% All Conditions
o.conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"]; % order
o.conds2 = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % custom condition names

o.logSpec = false; %
o.normalizeSpec = [];
o.normalizeLFP = "robust";

% Detrending (within-run to avoid edge artifacts)
o.detrendGPU = 1; % 0=CPU; 1=gpuArray; 2=compiled CUDA binaries (must compile: ec_compileBins)
o.detrendSingle = true;
% Robust detrending (pre-referencing)
o.detrendOrder = []; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
o.detrendThr =   2.5; %repmat(2.5,1,3); %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
o.detrendItr =   5;  %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
o.detrendWin =   0; % detrend timewindow in seconds {entire run=[],default=[]}

% Bad frames
o.missingInterp = "linear";
o.badFields = []; %["hfo" "mad" "diff" "sns"]
o.outlierCenter = "median";
o.thrOL = 5; %[5 5]; % Lower and upper quantiles for outlier
o.thrOLbl = 2.5;

% PCA
o.pca = 0;
o.pcaOl = "quartiles";
o.pcaOlThr = 3;

% Plot options
o.oP = ecu_genPlotParams("ERSP","MMR");
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
o.oP.textsize = 8;


%%
if ~exist('logs','var')
    date = string(datetime('now','TimeZone','local','Format','yyMMdd'));

    logs = table;
    logs.name(1) = date+"_ch_spec";
    logs.name(2) = date+"_ic_spec";
    logs.ICA = [false;true];
    logs.out(1) = dirs.anal+"summary/"+logs.name(1)+"/";
    logs.out(2) = dirs.anal+"summary/"+logs.name(2)+"/";

    logs.i{1} = table;
    logs.i{1}.sbj = string(sbjs);
    logs.i{1}.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    logs.i{1}.stats(:) = nan;
    logs.i{1}.plot(:) = nan;
    logs.i{1}.o = cell(numel(sbjs),1);
    logs.i{1}.time(:) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    logs.i{1}.error = cell(numel(sbjs),1);

    logs.i{2} = logs.i{1};
end

statusFn = dirs.anal+"summary/logs/"+date+"_"+...
    string(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'))+"_log.mat";


%% Run sum stats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for s = 1:height(status)
    for ii = 1:2 %:2 %1 %:2
        if logs.i{ii}.stats(s,ii)~=1  % s=1; ii=1;
            sbj = logs.i{ii}.sbj(s);
            o.name = logs.name(ii);
            o.ICA = logs.ICA(ii);
            
            %%
            try
                disp("STARTING SUMMARY PLOTS: "+sbj);
                logs.i{ii}.o{s} = ec_sumStatsSpec_sbjCh(sbj,proj,task,o,plot=0);
                logs.i{ii}.stats(s) = 1;
            catch ME; getReport(ME)
                logs.i{ii}.error{s} = ME;
                logs.i{ii}.stats(s) = 0;
            end

            %%
            logs.i{ii}.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(statusFn,'status','date','-v7');
        else
            disp("SKIPPING: "+o.name);
        end
    end
end



%% Run plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try delete(gcp('nocreate')); catch;end
try parpool('Processes'); catch;end
for s = 1:height(status)
    for ii = 1:2 %1 %:2
        if ii==1; doICA=1; sfx="i"; name=name+"ic_"+plotType; end
        if ii==2; doICA=0; sfx=""; name=name+"ch_"+plotType; end
        sbj = logs.i{ii}.sbj(s);

        %%
        if logs.i{ii}.plot(s,ii)~=1 %&& isempty(statusP.error{s})
            %%
            try
                disp("STARTING SUMMARY PLOTS: "+sbj);
                ec_summaryStats_sbjCh(sbj,proj,task,o,stats=0,plot=1,...
                    sfx=sfx,type=plotType,ICA=doICA,test=isTest);
                logs.i{ii}.plot(s) = 1;
            catch ME; getReport(ME)
                logs.i{ii}.error{s} = ME;
                logs.i{ii}.plot(s) = 0;
            end

            %%
            logs.i{ii}.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(statusFn,'status','date','-v7');
        else
            disp("SKIPPING PLOTS: "+o.name);
        end
    end
end