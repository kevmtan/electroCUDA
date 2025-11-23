sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";...
    "S12_40_MJ";"S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";...
    "S13_50_LGM";"S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";...
    "S13_57_TVD";"S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";...
    "S14_74_OD";"S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";...
    "S15_83_RR";"S16_95_JOB";"S16_96_LF"];
%sbjs = "S12_38_LK"; %["S12_38_LK";"S12_42_NC"];
proj = "lbcn";
task = "MMR"; % task name
analFolder = "condContrast";
analName = "mzAutoMath";

dirs = ec_getDirs(proj,task);

% Create options struct
o = struct;
o.name = ""; % Analysis name 
o.sfx = ""; % Suffix of input data

%% Options
o.test = false;

% Task Epoching (see 'ec_epochPsy')
o.epoch.float = "single"; % task metadata floating-point precision
% Bad trial removal
o.epoch.rmTrials = []; % Trials to remove (numeric array or logical index)
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
o.pre.runNorm = "robust"; % Normalize run
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
o.pre.hpfSteep = 0.5; % HPF steepness
o.pre.hpfImpulse = "fir"; % HPF impulse: ["auto"|"fir"|"iir"]
o.pre.lpf = 20; % LPF cutoff in hz (skip=0)
o.pre.lpfSteep = 0.85; % LPF steepness
o.pre.lpfImpulse = "fir"; % LPF impulse: ["auto"|"fir"|"iir"]
% Spectral dimensionality reduction by PCA (skip=0)
o.pre.pca = 0; % Spectral components to keep per channel
% Spectral dimensionality reduction into bands (skip=[])
o.pre.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb"]; % Band name
o.pre.bands2 = ["Delta (2-4hz)" "Theta (4-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
    "Gamma (30-60hz)" "HFB (60-200hz)"]; % Band display name
o.pre.bandsF = [2 4; 4 8; 8 14; 14 30; 30 60; 60 200]; % Band limits

% Stats contrast names
o.stats.contrasts = [...
    "Other-Self"...
    "Episodic-Semantic"...
    "Mz-Autobio"...
    "Mz-Math"...
    "Autobio-Math"]; % 
% Reference conditions (coded as 0)
o.stats.cond0 = {...
    "Other",...
    "Episodic",...
    ["Self" "Other"],....
    ["Self" "Other"],...
    ["Episodic" "Semantic"]};
% Comparison conditions (coded as 1)
o.stats.cond1 = {...
    "Self",...
    "Semantic",...
    ["Semantic" "Episodic"],...
    "Math",...
    "Math"}; 

% Stats options
o.stats.alpha = 0.05; % Critical p-value (default=0.05)
o.stats.binVar = "bin"; % Timebin variable ["bin"|"binPct"|"binRT"]
o.stats.binRng = [-200 2000]; % Range of timebins to run
o.stats.fdrBinRng = [0 inf]; % Range of timebins for FDR
% Stats processing options
o.stats.gpu = false;
o.stats.typeProc = "double"; % processing floating-point precision ("double"|"single"|""=same as input)
o.stats.typeOut = "single"; % output floating-point precision ("double"|"single"|""=same as input)



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
            sbjID = logs.i{p}.sbjID(s);
            o.dirOutSbj = o.dirOut+"s"+sbjID+filesep;

            %% Run subject
            if ~exist(logs.out(p),"dir"); mkdir(logs.out(p)); end
            try
                disp("STARTING: "+sbj);
                logs.i{p}.o{s} = ec_condVsCondChs_lm(o);
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