%% Write your own code to organize task events for your project

sbjs = {'s001','s002','s003'}'; 

status = table;
status.sbj = sbjs;
status.fin(:) = false;
status.error{:} = {};

proj = 'MMR';
pathsDMN('ec');
[dirServer,dirComp,dirCode,dirFS] = AddPaths('Kevin_DMN');

pdio_chan = 1;

load('/home/kt/Gdrive/UCLA/Studies/MMR/anal/beh/prompts_220524.mat','prompts');
%%
for s = 1:length(sbjs)
    sbj = sbjs{s};
    %sbj = 'S12_38_LK';

    dirs = ec_getDirs(proj,sbj,dirServer,dirComp,dirCode,dirFS);
    runs = BlockBySubj(sbj,proj);

    try
        % Convert berhavioral data to trialinfo
        switch proj
            case 'UCLA'
                OrganizeTrialInfoUCLA_rest(sbj, proj,runs,dirs) % FIX 1 trial missing from K.conds? INCLUDE REST!!!
            case 'MMR'
                OrganizeTrialInfoMMR_KT(sbj, proj,runs,dirs)
                %OrganizeTrialInfoMMR_rest(sbj_name, project_name, block_names, dirs) %%% FIX ISSUE WITH TABLE SIZE, weird, works when separate, loop clear variable issue
        end

        % Task event identifier
        EventIdentifier(sbj,proj,runs,dirs,pdio_chan,false);
        %EventIdentifier(sbj,proj,runs,dirs,pdio_chan,true); % new ones, photo = 1; old ones, photo = 2; china, photo = varies, depends on the clinician, normally 9, mic = 2

        %% Make trialNfo
        for b = 1:length(runs)
            run = runs{b};
            makeTrialNfo(sbj,run,dirs,prompts)
        end
        %%
        status.fin(s) = true;
    catch ME
        status.error{s} = ME;
        status.fin(s) = false;
        getReport(ME)
    end
end




