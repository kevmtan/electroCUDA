% Subject Names
% sbjs = {'S12_38_LK','S12_42_NC',...
%     'S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS','S12_39_RT',...
%     'S12_40_MJ','S12_41_KS','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
%     'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
%     'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
%     'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
%     'S15_87_RL','S16_95_JOB','S16_96_LF'}';
sbjs = {'S12_38_LK','S12_42_NC'};

%% Options
pathsDMN('ec');

proj = "MMR";
usrStr = "Kevin_DMN";
plotType = "spec"; % "hfb-lfp"; % "spec";
doICA = false;
nameStr = "221031_";
sfx = ""; %"";

o = struct;
o.name = nameStr;
o.save = true; %% save summary stats data %%%%
o.BLpre = [-0.2,0]; % Pre-stimulus baseline start/end (secs from stim onset); ex=[-0.2 0]
o.BLend = []; % Post-stimulus baseline start/end (secs from next stim onset); ex=[-0.1 0]
o.epoch = [-0.2,3]; % Stimulus-locked epochs start/end (secs from stim onset); ex=[-0.2 3]
o.epoch5 = [-0.2,5];
o.epochRT = [-1.5,0.5]; % RT-locked epochs start/end (secs from RT; ex=[-1.5 .5], skip=[])
o.epochPct = [o.epoch(1) 1+o.epochRT(2)];

o.binP = 0.01; % Latency bin width for analysis (seconds)
%o.binP_max = 100; % Max number of bins
%o.timeBins = 0.05; % secs

% Filtering (within blocks)
o.hiPass = 0; % Hi-pass cutoff in hertz (skip=0)
o.loPass = 10; % lo-pass in hz

% Detrending (within blocks)
o.detrendOrder = []; % polynomial order (suggested=10, skip=0)
o.detrendThr = [];
o.detrendItr = [];
o.detrendWin = []; %[]; % detrend window size in seconds, overlap add (default=[], entire block=[])

% Downsamplig
o.dsTarg = [];

% Bad frames
o.missingInterp = "linear";
o.badFields = []; %["hfo" "mad" "diff" "sns"]
o.outlierCenter = "median";
o.thrOL = 15; %[5 5]; % Lower and upper quantiles for outlier
o.thrOLbl = 2.5;

% Conditions
o.conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"]; % order
o.conds2 = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"];

% Bands
o.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb" "hfb2" "lfp"]; % Band name
o.bands2 = ["Delta (1-4hz)" "Theta (4-8hz)" "Alpha (8-13hz)" "Beta (13-30hz)"...
    "Gamma (30-60hz)" "HFB (60-180hz)" "HFB+ (180-300hz)" "LFP (ERP)"]; % Band display name
o.bandsF = [1 4; 4 8; 8 13; 13 30; 30 60; 60 180; 180 301; 0 0]; % Band limits

% Plot options
o.oP = ecu_genPlotParams('MMR','timecourse');
o.oP.visible = 0;
o.oP.save = 1;
o.oP.doGPU = 0;
o.oP.clim = [-4 4];
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
    o.oP.textsize = 12;
end

%%
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/summarySbj_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('statusSum','var')
    statusSum = table;
    statusSum.sbj = string(sbjs);
    statusSum.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    statusSum.stats(:,1:2) = nan;
    statusSum.plot(:,1:2) = nan;
    statusSum.time(:,1:2) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    statusSum.error = cell(height(statusSum),2);
end



%% Run sum stats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try delete(gcp('nocreate')); catch;end
try parpool('threads'); catch;end
for s = 1:height(statusSum)
    %%
    for ii = 1:2
        if ii==1; doICA=1; sfx="i"; o.name=nameStr+"ic_"+plotType; end
        if ii==2; doICA=0; sfx=""; o.name=nameStr+"ch_"+plotType; end
        if statusSum.stats(s,ii)~=1 %&& isempty(statusP.error{s})
            sbj = statusSum.sbj{s};
            dirs = ec_getDirs(usrStr,sbj,proj);
            o.dirIn = dirs.procSbj; %
            o.dirFS = dirs.fsSbj; % Freesurfer subjects dir
            o.dirOut = dirs.anal+"summary/"+o.name+"/";
            o.dirOutSbj = dirs.anal+"summary/"+o.name+"/s"+statusSum.sbjID(s)+"/";

            %%
            try
                disp("STARTING SUMMARY PLOTS: "+sbj);
                ec_summaryStats_sbjCh(sbj,proj,o,dirs,stats=1,plot=0,...
                    sfx=sfx,type=plotType,ICA=doICA);
                statusSum.stats(s,ii) = 1;
            catch ME; getReport(ME)
                statusSum.error{s,ii} = ME;
                statusSum.stats(s,ii) = 0;
                try parfevalOnAll(@gpuDevice,0,[]); catch;end
                try reset(gpuDevice(1)); catch;end
                try delete(gcp('nocreate')); catch;end
            end

            %%
            statusSum.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,'statusSum','-v7');
        else
            disp("SKIPPING: "+statusSum.sbj{s});
        end
    end
end



%% Run plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try delete(gcp('nocreate')); catch;end
try parpool('local2',24); catch;end
for s = 1:height(statusSum)
    %%
    for ii = 1 %1 %:2
        if ii==1; doICA=1; o.name = nameStr+"ic_"+plotType; end
        if ii==2; doICA=0; o.name = nameStr+"ch_"+plotType; end
        if statusSum.plot(s,ii)~=1 %&& isempty(statusP.error{s})
            sbj = statusSum.sbj{s};
            dirs = ec_getDirs(usrStr,sbj,proj);
            o.dirIn = dirs.procSbj; %
            o.dirFS = dirs.fsSbj; % Freesurfer subjects dir
            o.dirOut = dirs.anal+"summary/"+o.name+"/";
            o.dirOutSbj = dirs.anal+"summary/"+o.name+"/s"+statusSum.sbjID(s)+"/";

            %%
            try
                disp("STARTING SUMMARY PLOTS: "+sbj);
                ec_summaryStats_sbjCh(sbj,proj,o,dirs,stats=0,plot=1,...
                    sfx=sfx,type=plotType,ICA=doICA,test=1);
                statusSum.plot(s,ii) = 1;
            catch ME; getReport(ME)
                statusSum.error{s,ii} = ME;
                statusSum.plot(s,ii) = 0;
                try parfevalOnAll(@gpuDevice,0,[]); catch;end
                try reset(gpuDevice(1)); catch;end
                try delete(gcp('nocreate')); catch;end
            end

            %%
            statusSum.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,'statusSum','-v7');
        else
            disp("SKIPPING: "+statusSum.sbj{s});
        end
    end
end