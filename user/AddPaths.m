function [server_root, comp_root, code_root, fsAverage_local] = AddPaths(user)

if strcmp(user,'Kevin_UCLA')
    comp_root = '/data/MMR/d/';
    code_root = '/home/kevin/Google Drive/Git/lbcnPP/';
    server_root = '/media/kevin/KT_MMRraw/';
    fsAverage_local = '/usr/local/freesurfer/subjects/fsaverage/';
    addpath(genpath('/home/kevin/Google Drive/MATLAB/iELVis-master'))
elseif strcmp(user,'Kevin_DMN')
    comp_root = '/proj/lbcn/d/';
    code_root = '/home/kevin/Gdrive/Git/lbcnKT/';
    server_root = '/proj/lbcn/d/freesurfer/';
    fsAverage_local = '/proj/lbcn/d/freesurfer/fsaverage';
    %fsDir_local = '/usr/local/freesurfer/7.2.0/subjects/fsaverage';
elseif strcmp(user,'Kevin_DMNpp')
    comp_root = '/proj/lbcn/d';
    code_root = '/home/kevin/Gdrive/Git/lbcnKT';
    server_root = '/mnt/KT_MMRraw/';
    %fsAverage_local = '/usr/local/freesurfer/7.2.0/subjects/fsaverage';
elseif strcmp(user, 'Pedro_iMAC')
    %     addpath(genpath('/Users/pinheirochagas/Pedro/Stanford/code/iELVis/'))
    comp_root = '/Volumes/LBCN8T/Stanford/data';
    code_root = '/Users/pinheirochagas/Pedro/Stanford/code/lbcn_preproc/';
elseif strcmp(user,'Pedro_NeuroSpin4T')
    comp_root = '/Volumes/NeuroSpin4T/Stanford/data'; % location of analysis_ECOG folder
    code_root = '/Users/pinheirochagas/Pedro/Stanford/code/lbcn_preproc/';
elseif strcmp(user,'Amy_iMAC')
    comp_root = sprintf('/Users/amydaitch/Dropbox/Code/MATLAB/lbcn_preproc');
    addpath(genpath('/Users/amydaitch/Dropbox/Code/MATLAB/iELVis/'))
    addpath(genpath('/Applications/MATLAB_R2016b.app/toolbox/images/'))
elseif strcmp(user,'Ying_iMAC')
    comp_root = sprintf('/Users/yingfang/Documents/toolbox/lbcn_preproc/'); % location of analysis_ECOG folder
elseif strcmp(user,'Clara_iMAC')
    comp_root = sprintf('/Users/csava/Documents/code/lbcn_preproc/'); % location of analysis_ECOG folder
    addpath(genpath('/Users/csava/Documents/code/iELVis/'))
end

%server_root = '/Volumes/neurology_jparvizi$/';

end

