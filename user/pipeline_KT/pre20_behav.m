sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";"S12_40_MJ";...
    "S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";"S13_50_LGM";...
    "S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";"S13_57_TVD";...
    "S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";"S14_74_OD";...
    "S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";"S15_83_RR";...
    "S15_87_RL";"S16_95_JOB";"S16_96_LF"];
% ISSUES: s54

proj = "lbcn";
task = "MMR";
test = false;

statusDate = string(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));
statusFn = "/01/lbcn/logs/preproc/pre20_behav/"+statusDate;

status = table;
status.sbj = sbjs;
status.organize(:) = false;
status.event(:) = false;
status.nfo(:) = false;
status.error = cell(height(status),1);

load('/home/kt/Gdrive/UCLA/Studies/MMR/anal/beh/prompts_220524.mat','prompts');

try parpool('Processes'); catch; end


%% Subject loop
if ~test; diary(statusFn+".log"); diary on; end
parfor s = 1:height(status)
    % Slice status table
    stat = status(s,:);
    sbj = stat.sbj;

    % Run subject
    try
        % Organize trial info
        if ~stat.organize
            if task=="MMR"
                OrganizeTrialInfoMMR_KT(sbj,task,proj);
            elseif task=="UCLA"
                OrganizeTrialInfoUCLA_rest(sbj,task,dirs) % FIX 1 trial missing from K.conds? INCLUDE REST!!!
            end
            stat.organize = true;
        end

        % Event identifier
        if stat.organize && ~stat.event
            ec_eventIdentifier_lbcn(sbj,task,proj,targetHz=1000,save=true,date=statusDate);
            stat.event = true;
        end

        % Finalize trialNfo & psy
        if stat.event && ~stat.nfo
            ec_makeTrialNfo_MMR(sbj,task,proj,prompts);
            stat.nfo = true;
        end
    catch ME
        stat.error{1} = ME;
        getReport(ME);
    end
    status(s,:) = stat;
end
if ~test; save(statusFn+".mat","status"); diary off; end

%%
% %% Organize Trial Info
% for s = find(~status.organize)'
%     try
%         if task=="MMR"
%             OrganizeTrialInfoMMR_KT(sbjs(s),task,proj);
%         elseif task=="UCLA"
%             OrganizeTrialInfoUCLA_rest(sbjs(s),task,dirs) % FIX 1 trial missing from K.conds? INCLUDE REST!!!
%         end
%         status.organize(s) = true;
%     catch ME
%         status.error{s} = ME;
%         getReport(ME);
%     end
% end
% 
% 
% %% Event Identifier
% for s = find(status.organize & ~status.event)'
%     stat = status(s,:);
%     try
%         ec_eventIdentifier_lbcn(sbjs(s),task,proj,targetHz=1000,save=true,date=statusDate);
%         stat.event(1) = true;
%     catch ME
%         stat.error{1} = ME;
%         getReport(ME);
%     end
%     status(s,:) = stat;
% end
% 
% 
% %% Make trialNfo & psy
% for s = find(status.event & ~status.nfo)'
%     stat = status(s,:);
%     try
%         ec_makeTrialNfo_MMR(sbjs(s),task,proj,prompts,date=statusDate);
%         stat.nfo(1) = true;
%     catch ME
%         stat.error{1} = ME;
%         getReport(ME);
%     end
%     status(s,:) = stat;
% end


%%
%     if ~status.fin(s)
%         try
%             % Convert berhavioral data to trialinfo
%             switch task
%                 case 'UCLA'
%                     OrganizeTrialInfoUCLA_rest(sbj,task,dirs) % FIX 1 trial missing from K.conds? INCLUDE REST!!!
%                 case 'MMR'
%                     OrganizeTrialInfoMMR_KT(sbj,task,proj);
%             end
% 
%             %% Task event identifier
%             ec_eventIdentifier_lbcn(sbj,task,proj,targetHz=1000,save=true,runDate=statusDate);
% 
%             %% Make trialNfo
%             % for b = 1:length(runs)
%             %     run = runs{b};
%             %     ec_makeTrialNfo_MMR(sbj,run,dirs,prompts)
%             % end
% 
%             %%
%             status.fin(s) = true;
%         catch ME
%             status.error{s} = ME;
%             status.fin(s) = false;
%             getReport(ME)
%         end
%     end
% end




