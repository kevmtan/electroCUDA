%% Collate subject metadata (channel info, cortical meshes, demographics, etc)

sbjs = {'s001','s002','s003'}'; 


%%
projectN = 'MMR';
center = 'Stanford';
isRedo = 0;
correction_factor = 5;
plotChs = 0;

pathsDMN('lbcn')
[dirServer,dirComp,dirCode,dirFS] = AddPaths('Kevin_DMN');

%%
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/preproc/logs/sbjVar_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('statusSV','var')
    statusSV = table;
    statusSV.sbj = sbjs;
    statusSV.error = cell(height(statusSV),1);
    statusSV.errorCh = cell(height(statusSV),1);
    statusSV.errorPlot = cell(height(statusSV),1);
    statusSV.sv(:) = nan; % = nan(length(sbjs),2);
    statusSV.ch(:) = nan;
end
statusT = cell(height(statusSV),1);
for s = 1:height(statusSV)
    statusT{s} = statusSV(s,:);
end

load("marguilesGradients_fsaverage.mat","gradVerts");

chNfoA = cell(height(statusSV),1);
% global globalFsDir; %#ok<GVMIS>
% globalFsDir = dirFS;

try parpool('local2',ceil(length(sbjs)/2)); catch; end
%try parpool('local4',12); catch; end

%% Subject loop
%for s = 14
parfor s = 1:length(sbjs)
    % sbj = 'S12_38_LK';
    sbj = sbjs{s};
    sbjID = uint16(str2double(extractBetween(sbj,"_","_")));
    dirs = ec_getDirs(projectN,sbj,dirServer,dirComp,dirCode,dirFS);
    datFormat = GetFSdataFormat(sbj,center);
    block_names = BlockBySubj(sbj,projectN);
    saveDir = [dirs.origDat filesep sbj filesep];
    statusS = statusT{s};

    %% Create SubjVar
    if statusS.sv~=1; disp(['SKIPPING: ' sbj]); continue; end
    try
        [subjVar,statusS.sv] = ec_mkSubjVar(sbj,datFormat,dirs,isRedo);
        if subjVar.nChs~=subjVar.nchan
            warning(['subjVar.nChs~=subjVar.nchan for: ' sbj]);
            statusS.error = {'subjVar.nChs~=subjVar.nchan'};
        end
    catch ME; warning(['subjVar error for: ' sbj]); getReport(ME)
        statusS.sv = 0;
        statusS.error = ME; continue;
    end

    %% Create chNfo
    try
        chNfo = ec_mkChNfo(subjVar,saveDir,sbj,sbjID,gradVerts);
        chNfoA{s} = chNfo;
        statusS.ch = 1;
    catch ME; warning(['subjVar error for: ' sbj]); getReport(ME)
        statusS.ch = 0;
        statusS.errorCh = ME;
    end

    %% Plot electrodes
    if plotChs
        try PlotCoverageElect_KT(subjVar,correction_factor,1,dirs.anal); %#ok<UNRCH> 
        catch ME; warning(['subjVar plot error for: ' sbj]); getReport(ME)
            warning(['subjVar plot error for: ' sbj])
            statusS.errorPlot = ME;
        end
    end

    %% Copy status
    statusT{s} = statusS;
end

%% Save status
statusSV = vertcat(statusT{:});
save(sbjFinFn,'statusSV','-v7');

%%
chNfoA = vertcat(chNfoA{:});
