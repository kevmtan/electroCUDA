% sbjs = {'S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS','S12_38_LK','S12_39_RT','S12_40_MJ',...
%     'S12_41_KS','S12_42_NC','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
%     'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
%     'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
%     'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
%     'S15_87_RL','S16_95_JOB','S16_96_LF'}'; 
sbjs = {'S15_87_RL'};

% S10_18_JBXa (block 1 refCh=24, block2+ refCh=120)

projN = 'MMR';
center = 'Stanford';
dirFSloc = '/proj/lbcn/d/freesurfer/';
markChTableFn = '/home/kt/Gdrive/UCLA/Studies/MMR/anal/preproc/subject_info_chan_fs_220627.xlsx';
sbjBlockTableFn = '/home/kt/Gdrive/UCLA/Studies/MMR/anal/preproc/sbjBlockBehFn.xlsx';


tMarkCh = readtable(markChTableFn);
tSbjBlock = readtable(sbjBlockTableFn);

tSbjBlock.iEEG = strrep(tSbjBlock.iEEG,'/media/kevin/KT_MMRraw/',dirServer);
tSbjBlock.Beh = strrep(tSbjBlock.Beh,'/media/kevin/KT_MMRraw/',dirServer);

%DO BASH AFTER COMPLETE: rename 's/-/_/' /data/MMR/d/neuralData/originalData/*/*/*

%% Copy iEEG & task data
for s = 1:numel(sbjs) %1:length(sbj_names)
    %sbj = 'S12_38_LK';
    sbj = sbjs{s};
    
    %% Get & save filepaths
    [fs_iEEG,fs_Pdio,data_format] = GetFSdataFormat(sbj,center);
    dirs = ec_getDirs(projN,sbj,dirServer,dirComp,dirCode,dirFSserv);
    block_names = BlockBySubj(sbj,projN);

    %% Copy and convert data from server to local
    CreateFolders_KT2(sbj, projN, block_names, center, dirs, data_format,tSbjBlock);

    for i = 1:length(block_names)
        CopyFilesServer_KT2(sbj,projN,block_names{i},data_format,dirs);
    end
    
    % Get bad channels from postclinical eval to exclude from CAR and add to globalVar
    [refChan,badChan,epiChan,emptyChan,noisyChan,altBadChan] = GetMarkedChans_KT(sbj,tMarkCh);
    
    %% Convert to local
    if strcmp(data_format, 'edf')
        SaveDataNihonKohden_KT(sbj, projN, block_names, dirs, refChan, epiChan, emptyChan, badChan, noisyChan, altBadChan);
        %SaveDataNihonKohden(sbj_name, project_name, block_names, dirs, refChan, epiChan, emptyChan, badChan) %
    elseif strcmp(data_format, 'TDT')
        SaveDataDecimate_KT(sbj, projN, block_names, fs_iEEG, fs_Pdio, dirs, refChan, epiChan, emptyChan, badChan, noisyChan, altBadChan);
        %SaveDataDecimate(sbj_name, project_name, block_names, fs_iEEG, fs_Pdio, dirs, refChan, epiChan, emptyChan, badChan) %% DZa 3051.76
    else
        error('Data format has to be either edf or TDT format')
    end
end

%% Copy freesurfer data
for s = 1:numel(sbjs) %1:length(sbj_names)
    %sbj = 'S12_38_LK'; sbj = 'S13_52_FVV'
    sbj = sbjs{s};

    %% Get & save filepaths
    [fs_iEEG,fs_Pdio,data_format] = GetFSdataFormat(sbj,center);
    dirs = ec_getDirs(projN,sbj,dirServer,dirComp,dirCode,dirFSserv);

    if strcmp(sbj,'S15_87_RL'); dirs.freesurfer='/mnt/KT_MMRraw/SHICEP_S15_87_RL/freesurfer/SHICEP_S15_87_RL/'; end

    %% Copy freesurfer folder
    dirFS = struct2table(dir([dirs.freesurfer filesep '*']));
    dirFS(~dirFS.isdir,:) = [];
    dirFS(ismember(dirFS.name,["." ".."]),:) = [];
    dirFS(contains(dirFS.name,'DS'),:) = [];
    if height(dirFS)<1
        warning(['No freesurfer folder found:' sbj]);
    elseif height(dirFS)>1
        warning('Multiple freesurfer folders found'); disp(dirFS);
    else
        sbjFS = dirFS.name{end};
        dirFS = [dirFS.folder{end} filesep dirFS.name{end} filesep];
        mkdir([dirFSloc filesep sbj]);
        status = copyfile([dirFS '*'],[dirFSloc filesep sbj]);
        if status
            dirs.freesurfer = [dirFSloc sbj filesep];
            disp(['Copied freesurfer dir: ' dirs.freesurfer]);
        else
            warning(['Copy error: ' dirFS]); continue;
        end
        if ~strcmp(sbjFS,sbj)
            dirRecon = struct2table(dir([dirs.freesurfer 'elec_recon']));
            dirRecon(~contains(dirRecon.name,sbjFS)|dirRecon.isdir,:) = [];
            dirRecon.name2 = strrep(dirRecon.name,sbjFS,sbj);

            for i = 1:height(dirRecon)
                copyfile([dirRecon.folder{i} filesep dirRecon.name{i}],... 
                    [dirRecon.folder{i} filesep dirRecon.name2{i}]);
                delete([dirRecon.folder{i} filesep dirRecon.name{i}]);
            end
            disp(['Renamed elec_recon files: ' sbjFS ' to ' sbj]);
        end
    end
end
