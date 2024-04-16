% sbjs = {'S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS','S12_38_LK','S12_39_RT','S12_40_MJ',...
%     'S12_41_KS','S12_42_NC','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
%     'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
%     'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
%     'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
%     'S15_87_RL','S16_95_JOB','S16_96_LF'}';
% ISSUES: s54, s87

sbjs = {'S15_87_RL'};

proj = 'lbcn';
task = 'MMR';

status = table;
status.sbj = sbjs;
status.fin(:) = false;
status.error{:} = {};

load('/home/kt/Gdrive/UCLA/Studies/MMR/anal/beh/prompts_220524.mat','prompts');
%%
for s = 1:length(sbjs)
    sbj = sbjs{s};
    %sbj = 'S12_38_LK';

    dirs = ec_getDirs(proj,task,sbj);
    runs = BlockBySubj(sbj,task);

    %%
    try
        if ismember(sbj,{'S16_95_JOB','S16_96_LF'})
            pdio_chan = 1;
        else
            pdio_chan = 2;
        end

        % Convert berhavioral data to trialinfo
        switch task
            case 'UCLA'
                OrganizeTrialInfoUCLA_rest(sbj,task,runs,dirs) % FIX 1 trial missing from K.conds? INCLUDE REST!!!
            case 'MMR'
                OrganizeTrialInfoMMR_KT(sbj,task,runs,dirs);
                %OrganizeTrialInfoMMR_rest(sbj_name, project_name, block_names, dirs) %%% FIX ISSUE WITH TABLE SIZE, weird, works when separate, loop clear variable issue
        end

        %% Task event identifier
        EventIdentifier(sbj,task,runs,dirs,pdio_chan,true);
        %EventIdentifier(sbj,proj,runs,dirs,pdio_chan,true); % new ones, photo = 1; old ones, photo = 2; china, photo = varies, depends on the clinician, normally 9, mic = 2

        %% Make trialNfo
        for b = 1:length(runs)
            run = runs{b};
            ec_makeTrialNfo(sbj,run,dirs,prompts)
        end
        %%
        status.fin(s) = true;
    catch ME
        status.error{s} = ME;
        status.fin(s) = false;
        getReport(ME)
    end
end




