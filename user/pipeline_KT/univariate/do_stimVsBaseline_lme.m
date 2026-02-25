sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";"S12_40_MJ";...
    "S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";"S13_50_LGM";...
    "S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";"S13_57_TVD";...
    "S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";"S14_74_OD";...
    "S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";"S15_83_RR";...
    "S15_87_RL";"S16_95_JOB";"S16_96_LF"];
%sbjs = ["S12_38_LK";"S12_42_NC"];
proj = "lbcn";
task = "MMR"; % task name
analFolder = "stimBL";
analName = "bandLME";

dirs = ec_getDirs(proj,task);

% Create options struct
o = struct;
o.name = ""; % Analysis name 
o.sfx = ""; % Suffix of input data

%% Options
o.test = false;
o.gpu = false;
o.plot = true;

% Stats options
o.alpha = 0.05; % Critical p-value (default=0.05)
o.timeVar = "bin"; % Time variable ["frame"|"latency"|"bin"|"binPct"|"binRT"]
o.timeRng = [-200 2000]; % Range of times to run
o.fdrTimeRng = [0 inf]; % Range of times for FDR
o.minN = 15; % minimum observations per sample
o.contrastBL = false; % Direct contrast of time vs. baseline observations (default=false)
o.singleTrial = true; % Get trial-by-trial stats
o.randomEffectsOnly = false; % only model single-trial stats
%o.covPattern = "FullCholesky"; % Covariance pattern (default="FullCholesky",see fitlme)
%o.trialPlotLats = [-.2 5];
% Task Epoching (see 'ec_epochPsy')
o.epoch.float = "single"; % task metadata floating-point precision
% Bad trial removal
o.epoch.rmTrials = []; % Trials to remove (numeric array or logical index)
o.epoch.rmTrialsFun = @(t) ~(t.RT>0.1) & t.cond~="Rest"; % Function handle for removing trials (using trialNfo vars)
o.epoch.badTrials = ""; % Bad trial removal criteria
% Epoch time limits (secs) [nan=variable, 0=none]
o.epoch.pre = nan; % Duration before stim onset [nan = pre-stim ITI]
o.epoch.post = nan; % Duration after stim offset [nan = post-stim ITI]
o.epoch.dur = nan; % Duration after stim onset, supercedes 'post' [nan = no limit]
% Epoch time bins
o.epoch.bin = 0.05; % latency bin width (secs)
o.epoch.binPct = 5; % latency percentage bin width (<=100)
% Epoch baseline period for subsequent processing
%   (none=[], all pre/post times=inf, relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
o.epoch.baselinePre = -0.2; % Pre-stimulus baseline (secs from stim onset): inf=ITI; [-.2]; [-0.2 1]
o.epoch.baselinePost = []; % Post-stimulus baseline (secs from stim offset): inf=ITI; [.2]; [0.1 0.3]
% Task condition ordering (leave blank for to leave unordered)
o.epoch.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
o.epoch.conds2 = []; % custom condition names (per above order, can repeat)
%   o.epoch.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
%   o.epoch.conds2 = ["Mz" "Mz" "Ab" "Ab" "Math" "Rest"]; % custom condition names (per above order, can repeat)

% Preprocessing (see 'ec_epochBaseline')
o.pre.gpu = false; % Run on GPU? (note: CPU appears faster)
o.pre.typeProc = "double"; % processing FP precision ("double"|"single"|""=same as input)
o.pre.typeOut = "double"; % output FP precision ("double"|"single"|""=same as input)
o.pre.hzTarget = nan; % Target sampling rate (nan=default rate)
o.pre.log = false; % Log transform
o.pre.mag2db = false; % Log-transform magnitude to decibel
o.pre.runNorm = ""; % Normalize run
o.pre.trialNorm = "zscore"; % Normalize trial ["robust"|"zscore"|""]; skip=""
o.pre.trialNormDev = "all"; % Timepoints for StdDev ["baseline"|"pre"|"post"|"on"|"off"|"all"] (default="baseline")
o.pre.trialBaseline = "mean"; % Subtract trial by mean or median of baseline period (skip=[])
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
o.pre.lpf = 0; % LPF cutoff in hz (skip=0)
o.pre.lpfSteep = 0.7; % LPF steepness
o.pre.lpfImpulse = "fir"; % LPF impulse: ["auto"|"fir"|"iir"]
% Spectral dimensionality reduction by PCA (skip=0)
o.pre.pca = 0; % Spectral components to keep per channel
% Spectral dimensionality reduction into bands (skip=[])
o.pre.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb"]; % Band name
o.pre.bands2 = ["Delta (2-4hz)" "Theta (4-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
    "Gamma (30-60hz)" "HFB (60-200hz)"]; % Band display name
o.pre.bandsF = [2 4; 4 8; 8 14; 14 30; 30 60; 60 200]; % Band limits


%% Plot options (for ec_plotTimesCortex)
op = struct;

op.save = true;

% Filename
op.statsFn = "avg"; % Subject stats filename suffix: s[sbjID]_[statsFn].mat
op.statsVar = "sAVg"; % Subject stats variable name in saved data

% Channels to exclude
op.chBadFields = "bad";

% Condition/contrast
op.condVar = "cond"; % variable for condition, contrast, or test (in stats table)
op.conds = []; % conds to do (empty=all)

% Timing
op.timeVar = "bin"; % variable for time (in stats results)
op.timeUnit = "ms"; % time unit to display in fig
op.times = [50 250 500 750 1000 2000]; % times to plot (empty=all)

% Spectral
op.frqs = []; % frequency names to plot (empty=all)

% Activation metric
op.actVar = "t"; % activity variable for electrode plot color (in stats table)
op.actUnit = "t"; % activity unit to display in fig
op.clim = [-6 6]; %[-7 7] % limits for activity colorscale

% Statistical significance
op.sigVar = "q"; % statistical significance variable (in stats table)
op.sigThr = 0.05; % significance threshold (default=0.05, none=0)

% Plotting
op.posVar = "MNI"; % position variable in chNfo table (should match surfType)
op.surfType = "pial_avg"; % surface type (freesurfer naming convention) ["pial_avg"|"inflated_avg"]
op.pullF = 25; % Pull factor, view elecs closer to camera (default=15)
op.alpha = 0.95; % cortex opacity
op.marker = "o"; % marker type (see Matlab marker symbols)
op.nsMark = "o"; % marker type for nonsignificant chans (see Matlab marker symbols)
op.markSz = 11; % marker size for significant chans;
op.nsSz = 3; % marker size for nonsignificant chans;
op.bSz = 0; % marker border size
op.cmap = "RdBu"; % colormap (see ec_colorsFromValues)
op.nsCol = [0 0 0]; % marker color for nonsignificant chans: [R G B]
op.bCol = [0 0 0]; % marker border color: [R G B]
op.txtCol = [.8 .8 .8]; % Text color: [R G B]
op.txtSz = 10; % text size
op.labelVars = ["sbjCh" op.actVar op.sigVar]; % channel label variable (for visible/interactive plots)

% Individual plots per cond/time/freq
op.indiv.do = false;
op.indiv.saveDir = "indiv";
op.indiv.res = [1980 1080];
op.indiv.title = true; % add titles?

% Condition plots showing subplots per time & freq
op.cond.do = true;
op.cond.saveDir = "con_b";
op.cond.res = [1980 1080];
op.cond.title = true; % add titles?


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
    logs.i{1}.stats(:) = nan;
    logs.i{1}.plot(:) = nan;
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


%% Run sum stats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try delete(gcp("nocreate")); catch;end
try parpool("threads"); catch;end

% Loop across subjects
for s = 1:height(logs.i{1})
    for p = 1 %1:2 % Switch EEG data: channels (1) or independent components (2)
        if logs.i{p}.stats(s)~=1 
            % Set options struct per subject
            sbj = logs.i{p}.sbj(s);
            o.name = logs.name(p);
            o.sfx = logs.sfx(p);
            o.ICA = logs.ICA(p);
            o.dirs = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=o.sfx);
            o.dirOut = logs.out(p);
            %o.dirOutSbj = o.dirOut+"s"+dirs.sbjID+filesep;

            %% Run subject
            if ~exist(logs.out(p),"dir"); mkdir(logs.out(p)); end
            try
                disp("STARTING: "+sbj);
                logs.i{p}.o{s} = ec_stimVsBaseline_lme(o);
                logs.i{p}.stats(s) = 1;
            catch ME; getReport(ME)
                logs.i{p}.error{s} = ME;
                logs.i{p}.stats(s) = 0;
            end

            %% Save logs
            logs.i{p}.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(logs.fn(p),'logs','-v7');

        else
            disp("SKIPPING: "+o.name);
        end
    end
end