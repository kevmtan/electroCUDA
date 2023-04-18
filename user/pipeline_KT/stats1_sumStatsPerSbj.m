% Subject Names
sbjs = {'S12_38_LK','S12_42_NC',...
    'S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS','S12_39_RT',...
    'S12_40_MJ','S12_41_KS','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
    'S15_87_RL','S16_95_JOB','S16_96_LF'}';
%sbjs = {'S12_38_LK'}';

%% Options
proj = 'lbcn';
task = 'MMR';
usrStr = "Kevin_DMN";
plotType = "spec"; % "hfb-lfp"; % "spec";
doICA = false;
nameStr = "230413_";
sfx = ""; %"";

isTest = false;

% Options struct
o = struct;
o.name = nameStr;
o.save = true; %% save summary stats data %%%%
o.gpu = false;

% Timing (in seconds)
o.fsTarg = []; % Target sampling rate
o.dsTarg = [];
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

% Filtering (within blocks)
o.hiPass = 0.1; % Hi-pass cutoff in hertz (skip=0)
o.hiPassSteep = 0.5;
o.hiPassImpulse = "iir"; % GPU slower than CPU??
o.loPass = 20; % lo-pass in hz (skip=0)
o.loPassSteep = 0.5;
o.loPassImpulse = "auto";

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

%%
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/summary/summarySbj_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('statusSum','var')
    statusSum = table;
    statusSum.sbj = string(sbjs);
    statusSum.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    statusSum.stats(:,1:2) = nan;
    statusSum.plot(:,1:2) = nan;
    statusSum.time(:,1:2) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    statusSum.error = cell(numel(sbjs),2);
end


%% Run sum stats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for s = 1:height(statusSum)
    for ii = 1:2 %1 %:2
        if statusSum.stats(s,ii)~=1  % s=1; ii=1;
            if ii==1; doICA=1; sfx="i"; o.name=nameStr+"ic_"+plotType; end
            if ii==2; doICA=0; sfx=""; o.name=nameStr+"ch_"+plotType; end
            sbj = statusSum.sbj{s};
            dirs = ec_getDirs(proj,sbj,task);
            o.dirIn = dirs.procSbj; %
            o.dirFS = dirs.fsSbj; % Freesurfer subjects dir
            o.dirOut = dirs.anal+"summary/"+o.name+"/";
            o.dirOutSbj = dirs.anal+"summary/"+o.name+"/s"+statusSum.sbjID(s)+"/";

            %%
            try
                disp("STARTING SUMMARY PLOTS: "+sbj);
                ec_summaryStats_sbjCh(sbj,proj,o,dirs,stats=1,plot=0,sfx=sfx,...
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
            statusSum.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,'statusSum','-v7');
        else
            disp("SKIPPING: "+o.name);
        end
    end
end



%% Run plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try delete(gcp('nocreate')); catch;end
try parpool('Processes'); catch;end
for s = 1:height(statusSum)
    for ii = 1:2 %1 %:2
        if ii==1; doICA=1; o.name = nameStr+"ic_"+plotType; end
        if ii==2; doICA=0; o.name = nameStr+"ch_"+plotType; end
        if statusSum.plot(s,ii)~=1 %&& isempty(statusP.error{s})
            sbj = statusSum.sbj{s};
            dirs = ec_getDirs(proj,sbj,task);
            o.dirIn = dirs.procSbj; %
            o.dirFS = dirs.fsSbj; % Freesurfer subjects dir
            o.dirOut = dirs.anal+"summary/"+o.name+"/";
            o.dirOutSbj = dirs.anal+"summary/"+o.name+"/s"+statusSum.sbjID(s)+"/";

            %%
            try
                disp("STARTING SUMMARY PLOTS: "+sbj);
                ec_summaryStats_sbjCh(sbj,proj,o,dirs,stats=0,plot=1,...
                    sfx=sfx,type=plotType,ICA=doICA,test=isTest);
                statusSum.plot(s,ii) = 1;
            catch ME; getReport(ME)
                statusSum.error{s,ii} = ME;
                statusSum.plot(s,ii) = 0;
                % try parfevalOnAll(@gpuDevice,0,[]); catch;end
                %try reset(gpuDevice(1)); catch;end
                % try delete(gcp('nocreate')); catch;end
            end

            %%
            statusSum.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,'statusSum','-v7');
        else
            disp("SKIPPING PLOTS: "+o.name);
        end
    end
end