function [F,word_map,RDM] = ec_imgSim2(imgDir,imgFns,method,create_heatmap,doGPU)
% function [F, word_map, RDM, img_categories] = img_sim2(img_dir, method, create_dendrogram, compute_RDM, n_img_categories, visualize_2d, rank_similarity)
% function [F, word_map, RDM] = img_sim2(img_dir, method, create_heatmap, rank_similarity) <--- what I'd like it to be [compute_RDM would be automatic]
%
% This function computes feature vectors for images by using various
% computer vision methods. For each method, a representational
% dissimilarity matrix (RDM) is computed, and a .csv file containing the
% RDM is saved. The user has the option to also display a heatmap of the
% RDM and/or to rank the pairs of images by similarity as determined by the
% chosen method (100 most/least similar). The ranking is displayed as a
% montage of image pairs with the most similar pair coming first and the
% least similar pair coming last.
%
% If no input arguments are given, the script launches a GUI dialog
% for configuration.
%
% Images should all be the same size (preferably square).
%
% Inputs:
%
% image_dir : The directory where the images are saved. Absolute
% paths only (ie /home/user/images, not home/user/images)
% method : The method used to compute the feature vectors. Options
% are:
%       1 = pixel-based
%       2 = SIFT
%       3 = Jarrett et al. model
%       4 = Geometric Blur
%       5 = Scene Gist
%       6 = HMAX (output layer C1)
%       7 = Shock graphs
%       8 = gabor filterbank
% create_heatmap: Binary flag (0 or 1) Displays a heatmap of the RDM
% rank_similarity: Binary flag (0 or 1) Determines the 100 most/least
%   similar image pairs and displays them in a montage.
%
% Wokspace Outputs:
%
% F: A cell matrix with each entry containing the feature vector for
%   one image. (For the shock graph representation, this variable is
%   not used)
% word_map: The file name corresponding to each entry in F.
%    ex: word_map{i} is the file name of the feature vector for F{i}
% RDM: The dissimilarity matrix.
%
% Example use of this function:
% [F word_map RDM img_categories] = img_sim2('[path to this script]/example_images', 1, 1, 1)
%
% The settings for each representation are specified in this script.
% Technical details about each computer vision method are in
% readme.txt

% Written by Darren Seibert - February 4, 2012
% Modifications by Daniel Leeds - December 30, 2012
% Modifications by Kegan Landfair - May 25, 2015

if 0
    %%
    method = 3; %#ok<UNRCH>
    imgDir = "/home/kevin/Google Drive/UCLA/Studies/MMR/anal/beh/promptImgs/";
    imgFns = imgDir + prompts.fn;
    rank_similarity = 1;
    create_heatmap = 1;
end

compute_RDM = 1;


%% Jarrett
n_filters = 64; % default: 64 filters
filter_size = 9; % default: 9x9 filter size (should be odd)
%avg_down_sample = 5;
%cluster_data = 1; % default: do not cluster

if ismac && method == 7
    warning('Shapematcher (the implementation used for shock graphs) may not run on OS X. Windows and Linux are supported.');
end

%% Load images
Ic_all = cell(numel(imgFns),1);
word_map = imgFns;

for ii = 1:size(imgFns, 1)
    try
        Ic_all{ii} = rgb2gray(imread(imgFns(ii)));
    catch
        warning("imread failed: "+imgFns(ii));
        word_map(ii) = "";
    end
end

idx = word_map~="";
word_map = word_map(idx);
Ic_all = Ic_all(idx);
n_imgs = numel(word_map);

if n_imgs < 2
    if method == 7
        msg = 'For the shock graph representation, the images must be segmented and in the .PPM format. See the example_images_binary/ folder within this toolbox directory for sample inputs.';
    else
        msg = 'Could not find more than 1 image in the specificed directory';
    end
    warning(msg);
    return;
else
    disp("Loaded images");
end

%% Initial method configuration
if method==3
    name = 'Jarrett'; % used for file name of output files

    % Generate random filters
    filter = cell(n_filters,1);
    for ii = 1:n_filters
        for j=1:filter_size
            for k=1:filter_size
                filter{ii}(j,k) = round2(2*pi*rand() - pi, 1e-3); % any value can range from -pi to pi
            end
        end
    end

    % Generate gausian filter for contrast normalization
    filter_overlap = (filter_size - 1) / 2; % amount lost due to edge effects for each convolution
    g_filter_Jar = nan(filter_size,filter_size);
    for ii = 1:filter_size
        for j = 1:filter_size
            g_filter_Jar(ii,j) = round2(normpdf(ii, filter_overlap+1, 2) * ...
                normpdf(j, filter_overlap+1, 2), 1e-3);
        end
    end
    g_filter_Jar = g_filter_Jar / (n_filters * sum(sum(g_filter_Jar))); % normalize

    %uniform box filter
    box_filter = (1/25)*ones(5,5);  % *** REMOVE?
end

if doGPU
    filter = cellfun(@(a) gpuArray(single(a)), filter, 'UniformOutput',false);
    n_filters = gpuArray(single(n_filters));
    filter_size = gpuArray(single(filter_size));
    filter_overlap = gpuArray(single(filter_overlap));
    g_filter_Jar = gpuArray(single(g_filter_Jar));
    box_filter = gpuArray(single(box_filter));
    Ic_all = cellfun(@gpuArray,Ic_all,'UniformOutput',false);
end

%% Compute feature vectors for each image

F = cell(n_imgs,1);  % F will contain all feature vectors
parfor ii = 1:n_imgs
    disp("Computing feature vector for image "+ii+"/"+n_imgs);
    if method==3
        F{ii} = hier_model_KT(Ic_all{ii},filter,n_filters,filter_size,filter_overlap,g_filter_Jar,box_filter,0);
    end
end

if method == 7
    system(sm_cmd);
end

% Save
time_stamp = datestr(now,'yymmdd_HHMM');
time_stamp = [name '_' time_stamp];
folder_name = [imgDir 'results' filesep];
try
    mkdir(folder_name);
    file_name = [folder_name 'features_' time_stamp '.mat'];
    save(file_name,'F','word_map','-v7.3');
    fprintf('Feature vectors saved: %s\n', file_name);
catch ME
    getReport(ME)
end


%%
if compute_RDM
    RDM_size = nchoosek(n_imgs,2);
    RDM = zeros(1, RDM_size);
    RDM_ind = 1;

    if doGPU
        RDM = gpuArray(single(RDM));
        RDM_ind = gpuArray(RDM_ind);
    end

    if ~ismember(method,[2 7])
        for img = 1:n_imgs
            fprintf('Computing dissimilarity matrix... %i%% done\n', round(100*RDM_ind/RDM_size));
            for img2 = img+1:n_imgs
                if method==3 % jarrett model
                    % kldiv
                    for k = 1:n_filters
                        RDM(RDM_ind) = kldiv(-2:0.1:2,F{img}{k},F{img2}{k}) + kldiv(-2:0.1:2,F{img2}{k},F{img}{k});
                    end
                    RDM_ind = RDM_ind + 1;
                end
            end
        end
        RDM(RDM == Inf) = -Inf;
        RDM(RDM == -Inf) = max(RDM);
    end
end

RDM = squareform(RDM);

%% Save
if doGPU
    try F = cellfun(@gather,F); catch; end
    try RDM = gather(RDM); catch; end
end

% Write a CSV file for the Relational Dissimilarity Matrix, RDM.
try
    RDMfn = [folder_name 'RDM_' time_stamp '.xlsx'];
    writematrix(RDM,RDMfn);
catch ME
    getReport(ME)
end

% Save the features
try
    file_name = [folder_name 'features_' time_stamp '.mat'];
    save(file_name,'F','RDM','word_map','-v7.3');
    fprintf('Feature vectors saved: %s\n', file_name);
catch ME
    getReport(ME)
end

%%
if create_heatmap
    % assumes higher values in RDM = more distance
    if method~=7 % If method were 7 : RDM_s would revert to only one row
        RDM_s = squareform(RDM);
        %RDM_s(n_imgs,:) = 0; % make sure the matrix is square *** PROBLEM
        correlation_back = RDM_s; % preserve data. correlation_back will be altered
    else % method is 7, so just use RDM
        correlation_back = RDM;
    end


    %Plot the heatmap
    figure('Name','Heatmap For RDM','NumberTitle','off');
    colormap('jet');
    %imagesc(prc_mat);
    imagesc(correlation_back);
    set(gca,'xtick',[],'ytick',[]);
    colorbar
end
