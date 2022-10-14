function dirs = InitializeDirs(project_name, sbj_name, server_root, comp_root, code_root, fsDir_local)
%% Initialize directories


% % Get generic name without lower case to match the server 
% if isstrprop(sbj_name(end),'lower')
%     sbj_name_generic = sbj_name(1:end-1);
%     %sbj_name_generic = sbj_name;
% else
%     sbj_name_generic = sbj_name;
% end
sbj_name_generic = sbj_name;

% % Define local folders
% comp = computer();
% if contains(comp, 'MACI64') % General for MAC
%     comp_root = '/Volumes/LBCN8T/Stanford/data';
%     server_root = '/Volumes/neurology_jparvizi$/';
%     code_root = '/Users/pinheirochagas/Pedro/Stanford/code/lbcn_preproc/';
%     dirs.fsDir_local = '/Applications/freesurfer/subjects/fsaverage';
% else % If not MAC, user should choose the folder
%     dirs.fsDir_local = uigetdir();
% end


dirs.server_root = server_root; 
dirs.comp_root = comp_root;
dirs.code_root = code_root;
dirs.data_root = sprintf('%s/neuralData',dirs.comp_root);
dirs.result_root = sprintf('%s/Results',dirs.comp_root);
dirs.psych_root = sprintf('%s/psychData',dirs.comp_root);
dirs.project = sprintf('%s/Results/%s',dirs.comp_root,project_name);
dirs.elec = sprintf('%s/ECoG Patient Info/Electrodes/Native_elecs',dirs.comp_root);
dirs.mni_elec = sprintf('%s/ECoG Patient Info/Electrodes/MNI_elecs',dirs.comp_root);
dirs.mni_cortex = sprintf('%s/ECoG Patient Info/Cortex/ColinCortex',dirs.comp_root);
dirs.cortex = sprintf('%s/ECoG Patient Info/Cortex/Native_cortex',dirs.comp_root);
dirs.ROI = sprintf('%s/ECoG Patient Info/ROIs',dirs.comp_root);
dirs.original_data = [dirs.data_root '/originalData'];
dirs.MVPAData = [dirs.comp_root,'/MVPAData'];
dirs.fsDir_local = fsDir_local;

% Paper
% dirs.paper_results = '/Users/pinheirochagas/Pedro/Stanford/papers/paper_math_network/results/';
% dirs.paper_tables = '/Users/pinheirochagas/Pedro/Stanford/papers/paper_math_network/tables/';
% dirs.paper_figures = '/Users/pinheirochagas/Pedro/Stanford/papers/paper_math_network/figures/';



%Set freesurfer folder
all_folders = dir(fullfile(server_root));
if isempty(all_folders)
    warning('You are not connected to the server, therefore no Fressurfer folder will be specified.')
else
    for i = 1:length(all_folders)
        tpm(i) = contains(all_folders(i).name, sbj_name_generic);
    end
    sbj_folder_name = all_folders(tpm).name;

    all_folders_sbj = dir(fullfile([server_root sbj_folder_name]));
    for i = 1:length(all_folders_sbj)
        tpm_2(i) = contains(all_folders_sbj(i).name, 'surfer');
    end
    if sum(tpm_2) == 0
        warning('There is no Freesurfer folder')
        dirs.freesurfer = [];
    else
        dirs.freesurfer = [server_root sbj_folder_name '/' all_folders_sbj(tpm_2).name '/'];
    end
end

end