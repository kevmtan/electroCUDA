function ptd = ec_getPtdIndex(fs_subj,fs_dir,offset)
% function PTD_idx = getPtdIndex(fs_subj)
%
% Compute Proximal Tissue Density (PTD) for each electrode as described in
% Mercier et al., Neuroimage 2017
%
% PTD is an index reflecting the density of neocortical gray and white matter surrounding
% a stereotactic electrode that has its centroid either in the neocortical gray or in the
% white matter. It is: 
%
% PTD=(nGray-nWhite)/(nGray+nWhite)
% Where nGray is the # of neocortical gray matter voxels and nWhite is the
% number of white matter voxels in the 3x3 voxel cube centered on the contact. 
%
% If the contact centroid is not in white or neocortical gray matter, PTD =
% NaN.
%
% Be careful when a contact is in the vicinity of subcortical structures
% PTD is computed exclusively by taking into account surrounding neocortical
% gray and white matter voxels; no other tissue will be taken into account (e.g.
% Hippocampus, Amygdala...). Voxel labels are taken from the FreeSurfer
% aparc+aseg.mgz file.
%
% Please note that this function belongs to the iELVis toolbox
% and is therefore subjected to the same regulations
% (contacts: david.m.groppe@gmail.com ; manuel.mercier@a3.epfl.ch)
%
% input: fs_subj - name of the patient's FreeSurfer subject folder
%
% output: PTD_idx structure containing 
%           >> elec: {nx1 cell}
%           >> location: {nx1 cell}
%           >> offset: 2
%           >> nb_Gpix [nx1 double]
%           >> nb_Wpix [nx1 double]
%           >> PTD_idx.PTD [nx1 double]
%
% with:
% - elec: electrodes names
% - location: brain region where the centroid of each electrode is localized based on freesurfer parcellation
% - Offset: max # of voxels from contact centroid to include in PTD computation. 2 produces a 3x3 cube around
%   each contact's center voxel. correspond to the size of the cube around each electrode used to approximate 
%   the PTD (default = 2)
% - nb_Gpix and nb_Wpix correspond to the number of neocortical gray or white matter voxels within a cube centered around the electrode centroid
%   (default size = 3x3 ;centroid plus offset)
% - PTD proximal tissue density of white and neocortical gray matter around the electrode
%
% In addition the following files are created in the elec_recon subfolder
% of the patient's FreeSurfer directory:
%   -GreyWhite_classifications.mat
%   -GreyWhite_classifications.txt
%
% Function dependency:
% - MRIread from freesurfer (https://surfer.nmr.mgh.harvard.edu/)
%
% Files needed:
% - MRI from elec_recon (aparc+aseg.mgz)
% - electrodes coordinates (*.LEPTOVOX)
% - electrodes names (*.electrodeNames)
% - parcellation code table (FreeSurferColorLUT.txt)
%
%
% Reference:
% Mercier, M. R., Bickel, S., Megevand, P., Groppe, D. M., Schroeder, C. E.,
% Mehta, A. D., & Lado, F. A. (2017). Evaluation of cortical local field
% potential diffusion in stereotactic electro-encephalography recordings:
% A glimpse on white matter signal. NeuroImage, 147, 219-232.

% Change Log:
% 08-2017: a few other minor changes for iELVis by DG. In particular,
% 			instead of using wmparc.mgz, we now use aparc+aseg.mgz.
% 08-2017: adapted for iElvis by MrM;
% 02-2016: created by MrM;
% 09-2022: adapted for electroCUDA, fix sEEG issues, code optimizations for speed
%			--Kevin Tan

arguments
    fs_subj char
    fs_dir char
    offset double = 2
end

%% Load
recon_folder = fullfile(fs_dir,fs_subj,'elec_recon');
parc_file = fullfile(fs_dir,fs_subj,'mri','aparc+aseg.mgz');
mri = MRIread(parc_file);

% load electrodes name
files = dir(fullfile(recon_folder,'*.electrodeNames'));
n = size(files,1);
if n==1
    label_file=fullfile(recon_folder,files.name);
elseif n==0
    disp('No electrodeNames file found. Please do it manualy.');
    [temp_file,elec_dir]=uigetfile(fullfile(recon_folder,'*.electrodeNames'),'select electrode names file');
    label_file=fullfile(elec_dir,temp_file);
    clear elec_dir temp_file files n
elseif n>1
    disp('More than one electrodeNames file found. Please do it manualy.');
    [temp_file,elec_dir]=uigetfile(fullfile(recon_folder,'*.electrodeNames'),'select electrode names file');
    label_file=fullfile(elec_dir,temp_file);
    clear elec_dir temp_file files n
end
label = string(csv2Cell(label_file,' ',2));
label = label(:,1)+"_"+label(:,2)+"_"+label(:,3);
nElec = height(label);

% load electrodes coordinate
files = dir(fullfile(recon_folder,'*.LEPTOVOX'));
n = size(files,1);
if n==1
    elec_file=fullfile(recon_folder,files.name);
elseif n==0
    disp('No *.LEPTOVOX file found. Please do it manualy');
    [temp_file,elec_dir]=uigetfile(fullfile(recon_folder,'*.LEPTOVOX'),'select electrode coordinate file');
    elec_file=fullfile(elec_dir,temp_file);
    clear elec_dir temp_file files n
elseif n>1
    disp('More than one *.LEPTOVOX file found. Please choose it manualy');
    [temp_file,elec_dir]=uigetfile(fullfile(recon_folder,'*.LEPTOVOX'),'select electrode coordinate file');
    elec_file=fullfile(elec_dir,temp_file);
    clear elec_dir temp_file files n
end
elec = str2double(csv2Cell(elec_file,' ',2));
elec = elec+1; % Voxel indexing starts at 0 but MATLAB indexing starts with 1

%% Load look-up table for the FreeSurfer MRI atlases
FS_color_file = which('FreeSurferColorLUTnoFormat.txt');
if isempty(FS_color_file)
    disp('The freesurfer color code file, FreeSurferColorLUTnoFormat.txt, was not found. Please select it manualy.');
    [temp_file,elec_dir]=uigetfile(fullfile(recon_folder,'*.txt'),'Select freesurfer color code file');
    FS_color_file=fullfile(elec_dir,temp_file);
    clear elec_dir temp_file
else
    fprintf('Loading file %s\n',FS_color_file);
end

fid=fopen(FS_color_file);
C=textscan(fid,'%d %s %d %d %d %d');
fclose(fid);

region_lookup = lower(string(C{:,2}));
region_codes = C{:,1};
%clear fid C p

%% find the proportion of neocortical grey and white matter surrounding the electrodes
offsetThr = power(offset+1,3);
ROI = repmat("",nElec,1);
nGM = nan(nElec,1);
nWM = nan(nElec,1);

disp(['Finding amount of surrounding grey and white matter for channel ' fs_subj]);
parfor e = 1:nElec
    %%
    x = round(elec(e,2)); % switches x and y axes to match FreeSurfer
    y = round(elec(e,1)); % switches x and y axes to match FreeSurfer
    z = round(mri.volsize(3)-elec(e,3)); %need to flip direction of last coordinate
    
    % original labelling from parcellation
    ROI(e) = region_lookup(region_codes==mri.vol(x,y,z));
        
    % Euclidian distance between each electrode & voxel (could be sped up!)
    distances = nan(mri.volsize);
    for i = 1:mri.volsize(1)
       for j = 1:mri.volsize(2)
           for k = 1:mri.volsize(3)
               distances(i,j,k) = sqrt((i-x)^2+(j-y)^2+(k-z)^2); % norm is SLOWER!
           end
       end
    end

    % Find regions of voxels within offset
    tmp = mri.vol(distances<offset);
    tmp_region = repmat("",length(tmp),1);
    for i = 1:length(tmp)
        tmp_region(i) = region_lookup(region_codes==tmp(i));
    end

    % Find number of grey/white matter voxels within offset vicinity
    nGM(e) = nnz(contains(tmp_region,"gray")) + nnz(contains(tmp_region,"ctx"))...
        + nnz(contains(tmp_region,"cortex"));
    nWM(e) = nnz(contains(tmp_region,"white")) + nnz(contains(tmp_region,"wm"));
end

%% Finalize
ptd = table;
ptd.elec = label;
ptd.location = ROI;
ptd.GMvox = nGM;
ptd.WMvox = nWM;
ptd.PTD = (nGM - nWM)./(nGM + nWM);
ptd.offset(:) = offset;
ptd.totalVox(:) = offsetThr;

idx = nGM+nWM ~= offsetThr;
if nnz(idx)>1
     warning("Using less strict PTD for unlabeled GM/WM voxels in "+nnz(idx)+" chans: "+fs_subj);
     ptd.PTD(idx) = (nGM(idx)-nWM(idx)) / offsetThr; 
end

%% Save PTD info as mat file
outfile_mat=fullfile(recon_folder,'GreyWhite_classifications.mat');
fprintf('Writing PTD values to %s\n',outfile_mat);
save(outfile_mat,'ptd','-v7');

% % Raw output in txt
% outfile=fullfile(recon_folder,'GreyWhite_classifications.txt');
% fprintf('Writing PTD values to %s\n',outfile);
% fid=fopen(outfile,'w');
% fprintf(fid,'%s\t %s\t %s\t %s\r\n','Electrode','location','% Grey with offset=2','% White with offset=2');
% for i=1:size(ROI,1)
%     fprintf(fid,'%s\t %s\t %d\t %d\t \r\n',label{i},ROI{i,:});
% end
% fclose(fid);
end
