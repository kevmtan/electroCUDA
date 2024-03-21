% Subject Names
sbjs = {'S12_38_LK','S12_42_NC',...
    'S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS','S12_39_RT',...
    'S12_40_MJ','S12_41_KS','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
    'S15_87_RL','S16_95_JOB','S16_96_LF'}';
%sbjs = {'S12_42_NC'}';

%% Options
proj = 'lbcn';
task = 'MMR';
usrStr = "Kevin_DMN";
plotType = "spec"; % "hfb-lfp"; % "spec";
nameStr = "chCoherence";
isTest = false;

% Prep options struct (don't edit)
o = struct;
o.sbj = "";
o.sbjID = nan;
o.task = task;
o.name = string(datetime("now","TimeZone","local","Format","yyMMdd"))+"_"+nameStr;

% Basic options
o.suffix = ""; % Input data suffix (default = "")
o.save = true; % save summary stats data
o.doCUDA = true; % Run on CUDA GPU binary - must be compiled 1st! (ecu_compileThese)
o.doGPU = true; % Run on MATLAB gpuArray (superseded by CUDA)
o.single = true; % Run & save as single (single much faster on GPU)
o.halfOut = true; % Run as double (accuracy) & save as single (small filesize)

% Timing (in seconds)
o.dsTarg = 100; % Downsample target in Hz (default=[]: no downsample)
o.BLpre = [-0.2 0]; % Pre-stimulus baseline start/end (secs from stim onset); ex=[-0.2 0]
o.BLend = []; % Post-stimulus baseline start/end (secs from next stim onset); ex=[-0.1 0]
o.bin = 0.02; % Latency bin width (seconds)
o.bin2 = 0.1; % Latency bin2 width (seconds)
o.pct2 = 10; % 'Downsampled version' Percent RT width (percentile)

% Ensure trial epochs contain these times (skip=[])
o.epoch = []; %[-0.2 3]; % Stimulus-locked epochs start/end (secs from stim onset); ex=[-0.2 3]
o.epochRT = []; %o.BLpre; % RT-locked epochs start/end (secs from RT; ex=[-1.5 .5])
o.epochPct = []; %[o.epoch(1) 1+o.epochRT(2)];

% All Conditions
o.conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"]; % order
o.conds2 = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % custom condition names

o.logSpec = false; %
o.normalizeSpec = [];
o.normalizeLFP = "robust";

% Bad frames
o.doBadFrames = false;
o.missingInterp = "linear";
o.badFields = []; %["hfo" "mad" "diff" "sns"]
o.outlierCenter = "median";
o.thrOL = 5; %[5 5]; % Lower and upper quantiles for outlier
o.thrOLbl = 2.5;

% Wavelet coherence
o.fName = "spec"; % Name of frequency analysis
o.fLims = [4 200]; % frequency limits in hz; HFB=[70 200]
o.fVoices = 10; % Voices per octave (default=12)

% Frequency bands
o.freqIdx = []; %[1 14 20:4:83];
o.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb" "hfb2" "lfp"]; % Band name
o.bands2 = ["Delta (1-4hz)" "Theta (4-8hz)" "Alpha (8-13hz)" "Beta (13-30hz)"...
    "Gamma (30-60hz)" "HFB (60-180hz)" "HFB+ (180-300hz)" "LFP (ERP)"]; % Band display name
o.bandsF = [1 4; 4 8; 8 13; 13 30; 30 60; 60 180; 180 301; 0 0]; % Band limits

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
if plotType=="hfb"
    o.oP.textsize = 14;
elseif plotType=="hfb-lfp"
    o.oP.textsize = 14;
else
    o.oP.textsize = 8;
end

%%
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/summary/summarySbj_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('statusSum','var')
    statusSum = table;
    statusSum.sbj = string(sbjs);
    statusSum.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    statusSum.stats(:,1) = nan;
    statusSum.plot(:,1) = nan;
    statusSum.time(:,1) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    statusSum.error = cell(numel(sbjs),1);
end

%% Run sum stats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for s = 1:height(statusSum)
    if statusSum.stats(s)~=1  % s=2;
        sbj = statusSum.sbj(s);
        dirs = ec_getDirs(proj,sbj,task);
        os = o;
        os.sbj = sbj;
        os.task = task;
        os.dirIn = dirs.procSbj; %
        os.dirFS = dirs.fsSbj; % Freesurfer subjects dir
        os.dirOut = dirs.anal+"connectivity/"+os.name+"/";
        os.dirOutSbj = dirs.anal+"connectivity/"+os.name+"/s"+statusSum.sbjID(s)+"/";

        %%
        try
            disp("STARTING SUMMARY PLOTS: "+sbj);
            ec_summaryStats_sbjCh(sbj,proj,os,dirs,stats=1,plot=0,sfx=sfx,...
                type=plotType,ICA=doICA,test=isTest);
            statusSum.stats(s,ii) = 1;
        catch ME; getReport(ME)
            statusSum.error{s,ii} = ME;
            statusSum.stats(s,ii) = 0;
            % try parfevalOnAll(@gpuDevice,0,[]); catch;end
            % try reset(gpuDevice(1)); catch;end
            % try delete(gcp('nocreate')); catch;end
        end

        %%
        statusSum.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
        save(sbjFinFn,'statusSum','-v7');
    else
        disp("SKIPPING: "+o.name);
    end
end