%% Task info
sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";"S12_40_MJ";...
    "S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";"S13_50_LGM";...
    "S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";"S13_57_TVD";...
    "S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";"S14_74_OD";...
    "S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";"S15_83_RR";...
    "S15_87_RL";"S16_95_JOB";"S16_96_LF"];
% s=1; sbjs="S12_38_LK"; sbjs="S12_42_NC"; sbjs=["S12_38_LK";"S12_42_NC"];

proj = "lbcn";
task = "MMR"; % task name
analFolder = "classifySpec";
analName = "ccHMM";

dirs = ec_getDirs(proj,task);
o = struct;

%% Options
o.name = ""; % fill later
o.sfx = "s";
o.test = false;
o.gpu = false;
o.plot = true;

% All Conditions
o.conds = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % order
o.condsClassify = ["Episodic" "Semantic"];
o.condsCross = ["Other" "Self"];

% Epoching (see 'ec_epochPsy')
o.epoch.float = "single";
% Epoch time limits (secs) [nan=variable, 0=none]
o.epoch.pre = nan; % Duration before stim onset [nan = pre-stim ITI]
o.epoch.post = 0.5; % Duration after stim offset [nan = post-stim ITI]
o.epoch.max = nan; % Max duration after stim onset, supercedes 'post' [nan = no limit]
% Epoch time bins (secs)
o.epoch.bin = 0.01; % Fine latency bin width (secs)
o.epoch.bin2 = 0.05; % Coarse latency bin width (secs)
o.epoch.pct2 = 10; % Coarse latency percent width (percentile)
% Epoch baseline period for subsequent processing
%   (none=[], all pre/post times=inf, relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
o.epoch.baselinePre = -0.2; % Pre-stimulus baseline (secs from stim onset); -.2sec until onset = [-.2]; -.2sec to 1sec = [-0.2 1]
o.epoch.baselinePost = []; % Post-stimulus baseline (secs from stim offset); .2sec after offset = .2; .1sec to .2sec after offsetx=[0.1 0.3]

% Frequency bands
o.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb" "hfb2"]; % Band name
o.bands2 = ["Delta (2-4hz)" "Theta (4-8hz)" "Alpha (8-14hz)" "Beta (14-30hz)"...
    "Gamma (30-60hz)" "HFB (60-180hz)" "HFB+ (180-300hz)"]; % Band display name
o.bandsF = [2 4; 4 8; 8 14; 14 30; 30 60; 60 180; 180 301]; % Band limits

% Preprocessing (see 'ec_epochBaseline')
o.pre.gpu = false; % Run on GPU? (note: CPU appears faster)
o.pre.typeProc = "double"; % processing FP precision ("double"|"single"|""=same as input)
o.pre.typeOut = "single"; % output FP precision ("double"|"single"|""=same as input)
o.pre.hzTarg = 100; % Target sampling rate
o.pre.log = false; % Log transform
o.pre.runNorm = "robust"; % Normalize run
o.pre.trialNorm = "robust"; % Normalize trial
o.pre.trialNormByBaseline = true; % Divide trial by baseline norm (false = divide my all-trial norm)
o.pre.trialBaseline = "median"; % Subtract trial by mean or median of baseline period (skip=[])
% Bad frames/outliers
o.pre.interp = "linear";
o.pre.badFields = ""; % ["hfo" "mad" "diff" "sns"]
o.pre.olCenter = "median";
o.pre.olThr = 5; % Threshold for outlier (skip=0)
o.pre.olThr2 = 0; % Threshold for 2nd outlier after HPF (skip=0)
o.pre.olThrBL = 3; % Threshold for baseline outlier (skip=0)
% PCA (skip=[])
o.pre.pca = 0; % Components to keep across channels
o.pre.pcaSpec = 0; % Spectral components to keep per channel
% Filtering (within-run):
o.pre.hpf = 0; % HPF cutoff in hertz (skip=0)
o.pre.hpfSteep = 0.5; % HPF steepness
o.pre.hpfImpulse = "fir"; % HPF impulse: ["auto"|"fir"|"iir"]
o.pre.lpf = 0; % LPF cutoff in hz (skip=0)
o.pre.lpfSteep = 0.5; % LPF steepness
o.pre.lpfImpulse = "fir"; % LPF impulse: ["auto"|"fir"|"iir"]

% Stats
o.stats.epoch = [-.2 3]; % latency range for stats
o.stats.epochRT = [-1.5 .5]; % latency range for stats (relative to RT)
o.stats.epochPct = [-10 110]; % latency percentages for stats
o.stats.trialPlotLats = [-.2 5];

% Plot options
o.oP = ecu_genPlotParams("ERSP","MMR");
o.oP.visible = 0;
o.oP.save = true;
o.oP.doGPU = false;
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


%% Logs
if ~exist('logs','var')
    date = string(datetime('now','TimeZone','local','Format','yyMMdd'));
    startTime = string(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));

    logs = table;
    logs.name(1) = date+"_ch_"+analName;
    logs.name(2) = date+"_ic_"+analName;
    logs.ICA = [false;true];
    logs.out(1) = dirs.anal+analFolder+filesep+logs.name(1)+filesep;
    logs.out(2) = dirs.anal+analFolder+filesep+logs.name(2)+filesep;

    logs.i{1} = table;
    logs.i{1}.sbj = string(sbjs);
    logs.i{1}.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    logs.i{1}.stats(:) = nan;
    logs.i{1}.plot(:) = nan;
    logs.i{1}.o = cell(numel(sbjs),1);
    logs.i{1}.time(:) = startTime;
    logs.i{1}.error = cell(numel(sbjs),1);

    logs.i{2} = logs.i{1};
end


%% Run sum stats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for s = 1:height(logs.i{1})
    for ii = 1:2 %:2 %1 %:2
        if logs.i{ii}.stats(s)~=1  % s=1; ii=1;
            % Set options struct per subject
            o.name = logs.name(ii);  
            o.ICA = logs.ICA(ii);
            if o.ICA; o.sfx = "i"+o.sfx; end

            sbj = logs.i{ii}.sbj(s);
            dirs = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=o.sfx);
            o.dirs = dirs;
            o.dirIn = dirs.procSbj; %
            o.dirFS = dirs.fsSbj; % Freesurfer subjects dir
            o.dirOut = logs.out(ii);
            o.dirOutSbj = o.dirOut+filesep+"s"+dirs.sbjID+filesep;    
            logsFn = logs.out(ii)+"log_"+startTime+".mat";

            %% Run
            try
                disp("STARTING "+logs.name(ii)+": "+sbj);
                logs.i{ii}.o{s} = ec_classifyChSpec_HMM(sbj,proj,task,o);
                logs.i{ii}.stats(s) = 1;
            catch ME; getReport(ME)
                logs.i{ii}.error{s} = ME;
                logs.i{ii}.stats(s) = 0;
            end

            %% Save
            logs.i{ii}.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(logsFn,'logs','logsFn','-v7');
        else
            disp("SKIPPING: "+o.name);
        end
    end
end



%% Run plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try delete(gcp('nocreate')); catch;end
try parpool('local12'); catch;end
for s = 1:height(logs.i{1})
    for ii = 1:2 %1 %:2
        %%
        if logs.i{ii}.plot(s)~=1 %&& isempty(statusP.error{s})
            %%
            try
                disp("STARTING SUMMARY PLOTS: "+logs.i{ii}.sbj(s));
                ec_summaryCh_specPlot(logs.i{ii}.o{s});
                logs.i{ii}.plot(s) = 1;
            catch ME; getReport(ME)
                logs.i{ii}.error{s} = ME;
                logs.i{ii}.plot(s) = 0;
            end

            %%
            logs.i{ii}.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(logsFn,'logs','logsFn','-v7');
        else
            disp("SKIPPING PLOTS: "+o.name);
        end
    end
end