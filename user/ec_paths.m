function [dirFreesurfer,dirMain,dirCode,path_cudaica] = ec_paths(proj)
arguments
    proj {mustBeText} % Project name
end

% Paths on your machine
dirCode = '/home/kt/Gdrive/Git/electroCUDA/'; % path of git repo
path_cudaica = '/home/kt/bin/cudaica-master/cudaica'; % path of cudaica binary
% .../electroCUDA/bin/cudaica_linux_x64
% .../electroCUDA/bin/cudaica_win_x64_oneapi.exe
% .../electroCUDA/bin/cudaica_win_x64_mkl2020

% Project-specific paths
if strcmp(proj,'lbcn')
    dirMain = '/01/lbcn/'; % project root directory
    dirFreesurfer = '/01/lbcn/freesurfer/'; % freesurfer directory
elseif strcmp(proj,'ov')
    dirMain = '/01/ov/'; % project root directory
    dirFreesurfer = '/01/ov/freesurfer/'; % freesurfer directory
end


% if strcmp(proj,'Kevin_DMN')
%     dirMain = '/01/lbcn/d/';
%     dirCode = '/home/kt/Gdrive/Git/electroCUDA/';
%     dirFreesurfer = '/01/lbcn/d/freesurfer/';
%     path_cudaica = '/home/kt/bin/cudaica-master/cudaica';
% elseif strcmp(proj,'Kevin_DMNpp')
%     dirMain = '/proj/lbcn/d/';
%     dirCode = '/home/kt/Gdrive/Git/electroCUDA/';
%     dirFreesurfer = '/mnt/KT_MMRraw/';
%     path_cudaica = '/home/kt/Documents/MATLAB/cudaica-master/cudaica';
% elseif strcmp(proj,'Kevin_UCLA')
%     dirMain = '/data/MMR/d/';
%     dirCode = '/home/kevin/Google Drive/Git/lbcnPP/';
%     dirFreesurfer = '/media/kevin/KT_MMRraw/';
%     path_cudaica = '/home/kevin/Documents/MATLAB/cudaica-master/cudaica';
% end

% elseif strcmp(user, 'Pedro_iMAC')
%     %     addpath(genpath('/Users/pinheirochagas/Pedro/Stanford/code/iELVis/'))
%     comp_root = '/Volumes/LBCN8T/Stanford/data';
%     code_root = '/Users/pinheirochagas/Pedro/Stanford/code/lbcn_preproc/';
% elseif strcmp(user,'Pedro_NeuroSpin4T')
%     comp_root = '/Volumes/NeuroSpin4T/Stanford/data'; % location of analysis_ECOG folder
%     code_root = '/Users/pinheirochagas/Pedro/Stanford/code/lbcn_preproc/';
% elseif strcmp(user,'Amy_iMAC')
%     comp_root = sprintf('/Users/amydaitch/Dropbox/Code/MATLAB/lbcn_preproc');
%     addpath(genpath('/Users/amydaitch/Dropbox/Code/MATLAB/iELVis/'))
%     addpath(genpath('/Applications/MATLAB_R2016b.app/toolbox/images/'))
% elseif strcmp(user,'Ying_iMAC')
%     comp_root = sprintf('/Users/yingfang/Documents/toolbox/lbcn_preproc/'); % location of analysis_ECOG folder
% elseif strcmp(user,'Clara_iMAC')
%     comp_root = sprintf('/Users/csava/Documents/code/lbcn_preproc/'); % location of analysis_ECOG folder
%     addpath(genpath('/Users/csava/Documents/code/iELVis/'))
% end
%server_root = '/Volumes/neurology_jparvizi$/';

