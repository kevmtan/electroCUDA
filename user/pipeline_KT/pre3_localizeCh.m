sbjs = {'S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS','S12_38_LK','S12_39_RT','S12_40_MJ',...
    'S12_41_KS','S12_42_NC','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
    'S15_87_RL','S16_95_JOB','S16_96_LF'}';

%sbjs = {'S16_95_JOB'};

pathsDMN('ec')
[dirServer,dirComp,dirCode,dirFS] = AddPaths('Kevin_DMN');

%%
%load('/home/kt/Gdrive/UCLA/Studies/MMR/anal/preproc/logs/chLoc_220720_0442_errors.mat','statusChLoc');
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/preproc/logs/chLoc_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];

if ~exist('statusChLoc','var')
    statusChLoc = table;
    statusChLoc.sbj = sbjs;
    statusChLoc.dykstra(:) = nan;
    statusChLoc.error = cell(height(statusChLoc),1);
end

%%
try parpool('threads'); catch; end
global globalFsDir; %#ok<GVMIS>
globalFsDir = dirFS;

for s = 1:length(sbjs)
    %sbj = 'S12_38_LK';
    sbj = sbjs{s};
    %%
    if statusChLoc.dykstra(s)~=1
        try
            ec_dykstraElecPjct(sbj);
            statusChLoc.dykstra(s) = 1;
        catch ME; warning([sbj ' ERROR:']); getReport(ME)
            statusChLoc.error{s} = ME;
            statusChLoc.dykstra(s) = 0;
        end
        close all
        save(sbjFinFn,'statusChLoc','-v7');
    end
end

%%
statusChLoc.og(:) = false;
save(sbjFinFn,'statusChLoc','-v7');

