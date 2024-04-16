sbjs = {'S12_38_LK','S12_42_NC','S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS',...
    'S12_39_RT','S12_40_MJ','S12_41_KS','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR','S15_87_RL',...
    'S16_95_JOB','S16_96_LF'}';

proj = "lbcn";
task = "MMR";

redoFlg = false;
saveFlg = true;

%%
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/preproc/chNfo_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('status','var')
    status = table;
    status.sbj = string(sbjs);
    status.fin(:,1) = false;
    status.msg(:,1) = "";
    status.error = cell(numel(sbjs),1);
    status.time(:,1) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
end
chNfoA=cell(height(status),1); sbjVar=chNfoA;

%% Run
try ppool = parpool('Processes'); catch ppool; end
parfor s = 1:height(status)
    stat = status(s,:);
    sbj = stat.sbj;
    if stat.fin; disp("ALREADY FINISHED: "+sbj); continue; end
    disp("STARTING: "+sbj);
    try    
        [sbjVar{s},chNfoA{s},stat.msg] = ec_mkChNfo_lbcn(sbj,proj,task,...
            redo=redoFlg,save=saveFlg);
        stat.time = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
        stat.fin = 1;
    catch ME; getReport(ME)
        stat.error = ME;
        stat.fin = false;
    end
    status(s,:) = stat;
end

save(sbjFinFn,'status','-v7');
