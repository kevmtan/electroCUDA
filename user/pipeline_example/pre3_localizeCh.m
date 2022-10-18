%% Localize iEEG electrodes
%% Write your own code to organize task events for your project

sbjs = {'s001','s002','s003'}'; 


pathsDMN('ec') % Add electroCUDA paths for your machine
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

