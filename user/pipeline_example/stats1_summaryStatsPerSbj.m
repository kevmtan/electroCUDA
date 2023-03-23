% Subject Names
sbjs = {'s001','s002','s003'}'; 


%% Options
pathsDMN('ec');

proj = "MMR";
usrStr = "Kevin_DMN";
plotType = "hfb";
doICA = true;
nameStr = "221013_";

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

% Filtering (within runs)
o.hiPass = 0; % Hi-pass cutoff in hertz (skip=0)
o.loPass = 10; % lo-pass in hz

% Detrending (within runs)
o.detrendOrder = [0 10 0]; % polynomial order (suggested=10, skip=0)
o.detrendThr = 10;
o.detrendWin = []; % detrend window size in seconds, overlap add (default=[], entire block=[])
o.detrendItr = 10;

% Downsamplig
o.dsTarg = [];

% Bad frames
o.missingInterp = "linear";
o.badFields = []; %["hfo" "mad" "diff" "sns"]
o.outlierCenter = "median";
o.thrOL = 15; %[5 5]; % Lower and upper quantiles for outlier
o.thrOLbl = 3;

% Conditions
o.conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"]; % order
o.conds2 = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"];

% Bands
o.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb" "hfb2" "lfp"]; % Band name
o.bands2 = ["Delta (1-4hz)" "Theta (4-8hz)" "Alpha (8-13hz)" "Beta (13-30hz)"...
    "Gamma (30-60hz)" "HFB (60-180hz)" "HFB+ (180-300hz)" "LFP (ERP)"]; % Band display name
o.bandsF = [1 4; 4 8; 8 13; 13 30; 30 60; 60 180; 180 301; 0 0]; % Band limits

% Plot options
o.oP = genPlotParams('MMR','timecourse');
o.oP.visible = 0;
o.oP.save = 1;
o.oP.doGPU = 0;
o.oP.clim = [-4 4];
o.oP.alpha = 0.95;
o.oP.textcol = [.8 .8 .8];
o.oP.textsize = 12;
o.oP.o1D = struct;
o.oP.o1D.style= '-';
o.oP.o1D.width = 1;
o.oP.o1D.edgestyle = ':';
for c = 1:numel(o.conds)
    o.oP.o1D.col{c} = o.oP.col(c,:);
end

%%
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/summarySbj_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('statusSum','var')
    statusSum = table;
    statusSum.sbj = string(sbjs);
    statusSum.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    statusSum.fin(:,1:2) = nan;
    statusSum.time(:,1:2) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    statusSum.errorStats = cell(length(sbjs),2);
end



%% Run spec %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try delete(gcp('nocreate')); catch;end
try parpool('threads'); catch;end
for s = 1:height(statusSum)
    for ii = 1
        if ii==1; doICA=1; o.name = nameStr+"ic_"+plotType; end
        if ii==2; doICA=0; o.name = nameStr+"ch_"+plotType; end
        if statusSum.fin(s,ii)~=1 %&& isempty(statusP.error{s})
            sbj = statusSum.sbj{s};
            dirs = ec_getDirs(usrStr,sbj,proj);
            o.dirIn = dirs.procSbj; %
            o.dirFS = dirs.fsSbj; % Freesurfer subjects dir
            o.dirOut = dirs.anal+"summary/"+o.name+"/";
            o.dirOutSbj = dirs.anal+"summary/"+o.name+"/s"+statusSum.sbjID(s)+"/";

            %%
            try
                disp("STARTING SUMMARY PLOTS: "+sbj);
                ec_summaryStats_sbjCh(sbj,proj,o,dirs,type=plotType,ICA=doICA,stats=1,plot=1);
                statusSum.fin(s,ii) = 1;
            catch ME; getReport(ME)
                statusSum.errorStats{s,ii} = ME;
                statusSum.fin(s,ii) = 0;
            end
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end

            %%
            statusSum.time(s,ii) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(sbjFinFn,'statusSum','-v7');
        else
            disp("SKIPPING: "+statusSum.sbj{s});
        end
    end
end
