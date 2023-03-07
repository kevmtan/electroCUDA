sbj_names = {'S12_42_NC','S12_38_LK','S13_46_JDB','S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS','S12_39_RT','S12_40_MJ',...
    'S12_41_KS','S12_45_LR','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
    'S16_95_JOB','S16_96_LF'}';
%sbj_names = {'S12_42_NC','S12_38_LK'};

conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"];
projectN = 'MMR';
doPlots = true;
doDiary = false;

o = struct;
o.fnString = 'evST_220527';
o.band = 'rHFB';
o.BLpre = [-.2 0]; %[-0.1 0]; % baseline before stim onset
o.BLend = []; %[-0.1 0]; % baseline before next stim onset
o.smWin = 0.025; % smoothing gaussian width in secs
o.rmBadCh = true;
o.decimate = false;
o.fsTarg = 1000;
o.clustSize = 0.05; % secs
o.minAnalSize = 20;
o.timeBins = 0.01; % secs
o.noiseFields = {'HFO'};%{'HFO','raw_jump','diff_jump'}; % ['HFO','raw_HF_spike']
o.outlierCenter = 'median';
o.outlierThresh = 5; %[5 5]; % Lower and upper quantiles for outlier
o.missingInterp = 'linear';
o.k = 6; % Number of clustering components across timepoints

% Preallocate
if ~exist('sbjStatus','var')
    sbjStatus = table;
    sbjStatus.sbj = sbj_names;
    sbjStatus.stats(:) = nan;
    sbjStatus.plot(:) = nan;
    sbjStatus.error = cell(numel(sbj_names),2);
    sbjStatus.errorFn = cell(numel(sbj_names),1);
    sbjStatus.complete(:) = false;
end
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/evoked/logs/'...
    o.fnString char(datetime('now','TimeZone','local','Format','_HHmm')) '_errors.mat'];

%load('evRobLME_220401_0813_errors.mat')
%sbjFinFn = '/home/kt/Gdrive/UCLA/Studies/MMR/anal/evoked/logs/evSTblc_220419_0044__errors.mat';

%% Loop
pathsDMN('lbcn')
for s = 1:height(sbjStatus) %find(complete==0|isnan(complete))
    sbj = sbjStatus.sbj{s};
    blocks = BlockBySubj(sbj,projectN);

    if sbjStatus.complete(s)
        continue
    else
        try delete(gcp('nocreate')); catch; end
    end

    % Statistical analysis
    if sbjStatus.stats(s)~=1
        try
            [sbjStatus.stats(s),sbjStatus.plot(s),errorFn] =...
                evokeST_lme(sbj,blocks,projectN,doPlots,doDiary,o);
            if any(~cellfun(@isempty,errorFn))
                sbjStatus.errorFn{s} = errorFn;
            end
        catch ME
            warning(['DID NOT COMPLETE: ' sbj]);
            sbjStatus.error{s,1} = ME;
            getReport(ME)
        end
    end

    if sbjStatus.stats(s)==1 && sbjStatus.plot(s)==1
        sbjStatus.complete(s) = true;
        disp(['::: FINISHED ' sbj ' :::']);
    end

    % Save sbj log
    save(sbjFinFn,'sbjStatus','-v7.3');
end

try delete(gcp('nocreate')); catch; end

%%
if 1
    %% Concactenate datMs across sbjs
    stm = table; 
    for s = 1:height(sbjStatus) %find(complete==0|isnan(complete))
        sbj = sbjStatus.sbj{s};
        sbjID = extractBetween(sbj,'_','_');
        sbjID = sbjID{:};
        try
            load(['/proj/lbcn/d/Results/stats/' o.fnString '/s' sbjID '/' sbj '_' o.fnString '_M.mat'],'datMs');
            stm = [stm;datMs]; %#ok<AGROW> 
        catch ME
            warning(sbj);
            getReport(ME)
        end
    end
    stm = sortrows(stm,{'sbjID','ch','trialA'},'ascend');

    %% cat chNfo
    chs = table;
    for s = 1:height(sbjStatus) %find(complete==0|isnan(complete))
        sbj = sbjStatus.sbj{s};
        try
            load(['/proj/lbcn/d/neuralData/robustData/' sbj '/MMR/' sbj '_chNfo_MMR.mat'],'chNfo');
            chs = [chs;chNfo]; %#ok<AGROW> 
        catch ME
            warning(sbj);
            getReport(ME)
        end
    end

    chs = sortrows(chs,{'sbjID','ch'},'ascend');
    chs.Properties.VariableNames{'FS_vol'} = 'DK';
    chs.Properties.VariableNames{'LvsR'} = 'LvR';
    chs.Properties.VariableNames{'sEEG_ECoG'} = 'iEEG';
    chs.Properties.VariableNames{'WMvsGM'} = 'GM';
    chs = movevars(chs, {'Yeo7s','lobe','DK','LvR','iEEG','GM','grad1s'}, 'Before', 'sbj');
    
    %% cat trialNfo
    trs = table;
    for s = 1:height(sbjStatus) %find(complete==0|isnan(complete))
        sbj = sbjStatus.sbj{s};
        try
            load(['/proj/lbcn/d/neuralData/robustData/' sbj '/MMR/' sbj '_trialNfo_MMR.mat'],'trialNfo');
            trs = [trs;trialNfo]; %#ok<AGROW> 
        catch ME
            warning(sbj);
            getReport(ME)
        end
    end
    trs = sortrows(trs,{'sbjID','trialA'},'ascend');

    %%
    chs = chs(ismember(chs.sbjCh,unique(stm.sbjCh)),:);
    idx = ismember(trs(:,["sbjID","run","trial"]),stm(:,["sbjID","run","trial"]));
    trs = trs(idx,:);
    %%
    save(['/proj/lbcn/d/Results/stats/' o.fnString '/chs_' o.fnString '.mat'],"chs","-v7.3");
    save(['/proj/lbcn/d/Results/stats/' o.fnString '/trs_' o.fnString '.mat'],"trs","-v7.3");
    save(['/proj/lbcn/d/Results/stats/' o.fnString '/stm_' o.fnString '.mat'],"stm","-v7.3");
end