function [F, word_map, RDM] = img_sim2(img_dir, method, create_heatmap, rank_similarity)
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

gui_mode = ~exist('img_dir','var');
full_path = mfilename('fullpath');
script_name = mfilename();
full_path = full_path(1:size(full_path,2)-size(script_name,2));
current_dir = pwd;
addpath([full_path filesep 'scripts']);
if gui_mode   % Initialize gui arguments
	%global categorize_imgs visualize_3d create_dendrogram compute_RDM start method img_dir n_img_categories %possibly comment out
	start = 0; %%
    method = 1;
    create_heatmap = 0;
    rank_similarity = 0;
	img_dir_g = [full_path 'example_images/'];
else
	start = 1;
end
RDM = 0;
compute_RDM = 1;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% default configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------------------------------------------------
% sift
global matched s_method
matched = 0; % default: 0=pooling
s_method = 4;
global cluster_size
cluster_size = 15;
feature_count = 0; % total number of feature_vectors

%---------------------------------------------------
% jarrett
global n_filters filter_size avg_down_sample cluster_data
n_filters = 64; % default: 64 filters
filter_size = 9; % default: 9x9 filter size (should be odd)
avg_down_sample = 5;
cluster_data = 1; % default: do not cluster

%---------------------------------------------------
% scene gist
global numberBlocks G ;
%Nblocks = 4; % ***Redundant and poorly named REMOVE***
imageSize = 400; 
orientationsPerScale = [8 8 4];
numberBlocks = 4;
%size_g = 960; % *** REMOVE?
G = createGabor(orientationsPerScale, imageSize);

%---------------------------------------------------
% geoblur
global find_points w_m w_d gamma alpha_d beta_d mu_d
find_points = 30;
w_m = 1;
w_d = 1;
gamma = 0.9;
alpha_d = 1;
beta_d = 1;
mu_d = 1;

%---------------------------------------------------
% gabor filterbank
global gBank
    
%---------------------------------------------------
if ismac && method == 7
	warning('Shapematcher (the implementation used for shock graphs) may not run on OS X. Windows and Linux are supported.');
end
%---------------------------------------------------
% Launch GUI mode
if gui_mode 
    try
	%run([full_path 'scripts/dialogs/gui_disc']) %intro_new
    [img_dir,method,create_heatmap,rank_similarity,start] = img_sim2_gui(img_dir_g); 
    %(img_dir, method, create_heatmap, rank_similarity, start);
    catch
        warning('Problem using GUI mode.');
    end 
end

if ~start
	clear F word_map RDM img_categories
	return
end

%---------------------------------------------------
% determine images
names = dir(img_dir);
n_imgs = 0;
for i=1:size(names, 1) % loop through everything that dir returned
	strlen = size(names(i).name,2);
	
    if strlen > 3 
        if strcmp(names(i).name(strlen-3:strlen), '.ppm') || method ~= 7
            try % only keep entry if imread doesnt fail.
                junk = { imread([img_dir filesep '' names(i).name]) };
                word_map(n_imgs + 1) = { names(i).name }; % later used for outputting results (heatmap & dendrogram)
                n_imgs = n_imgs + 1;
            catch
                warning('imread failed.')
            end
        end
    end
end

if n_imgs < 2
	if method == 7
		msg = 'For the shock graph representation, the images must be segmented and in the .PPM format. See the example_images_binary/ folder within this toolbox directory for sample inputs.';
   else
		msg = 'Could not find more than 1 image in the specificed directory'; 
	end
	
	warning(msg); errordlg(msg);
	clear F word_map RDM img_categories
	return;
end

[junk junk] = mkdir([img_dir filesep 'results/']); % "[junk junk] = " supresses warnings

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% initial method configuration
%%%%%%%%%%%%%%%%%%%%%%%%%%

%---------------------------------------------------
if method == 1 % pixel
	name = 'Pixel';
%---------------------------------------------------
elseif method == 2 % sift
	name = 'SIFT';
	run([full_path 'scripts/vlfeat-0.9.20/toolbox/vl_setup'])
%---------------------------------------------------
elseif method == 3
	name = 'Jarrett'; % used for file name of output files
	
	% generate random filters
	filter_overlap = (filter_size - 1) / 2; % amount lost due to edge effects for each convolution
	for i=1:n_filters
		%filter_sum = 0; % only used if the filter is normalized
	   for j=1:filter_size
		   for k=1:filter_size
			   filter{i}(j,k) = round2(2*pi*rand() - pi, 1e-3); % any value can range from -pi to pi
			   %filter_sum = filter_sum + filter{i}(j,k);
		   end
	   end
	   %filter{i} = filter{i} / filter_sum;
	end

	% generate gausian filter for contrast normalization
	global g_filter_Jar box_filter;
        g_filter_Jar = [];
	for i=1:filter_size
		for j=1:filter_size
			g_filter_Jar(i,j) = round2(normpdf(i, filter_overlap+1, 2) * ...
				normpdf(j, filter_overlap+1, 2), 1e-3);
		end
	end
	g_filter_Jar = g_filter_Jar / (n_filters * sum(sum(g_filter_Jar))); % normalize
	%uniform box filter
	box_filter = (1/25)*ones(5,5);  % *** REMOVE?
%---------------------------------------------------
elseif method == 4
	name = 'Geoblur';
	%global window_size; *** REMOVE? not needing any of these globals
	window_size = 11; % should be odd
	%h_window_size = (window_size - 1) / 2; *** REMOVE
	alpha = 4 / (window_size - 1); % G_(a*|x|)_ ---- used to determine extent to which the gaussian filter increases towards the edges of a keypoint

	%keyboard
	%% create gausian filter for each distance involved (from the center of a window)
	%global g_filter_Geo; %possibly remove (was already declared above as global)
        g_filter_Geo=[];
	for i=1:2*window_size
		for j=1:2*window_size
			dist = round(sqrt((window_size - i)^2 + (window_size-j)^2));
			if ~dist
				dist = 1;
			end
			for m=1:2*window_size+1
				for n=1:2*window_size+1
					g_filter_Geo(dist, m,n) = round2(normpdf(m, window_size, alpha*dist+2) * ...
								normpdf(n, window_size, alpha*dist+2), 1e-4);
				end
			end
        end
    end
%---------------------------------------------------    
elseif method == 5 % scenegist
	name = 'SceneGist'; % used for file name
%---------------------------------------------------
elseif method == 6
	name = 'HMAX';
%---------------------------------------------------
elseif method == 7
	name = 'Shock_graphs';
	if ismac || isunix
		sm_path = [full_path 'scripts/ShapeMatcher5.2.1_unix/'];
	else
		sm_path = [full_path 'scripts/ShapeMatcher5.2.1_windows/'];
	end
	sm_cmd = [sm_path 'sm -c stims.db '];
	cd(img_dir);
	delete('stims.db');
%---------------------------------------------------
elseif method == 8
        name = 'Gabor';
	addpath([full_path filesep 'scripts/wavelets/'])
	gBank=gaborBank(400,400,4);
%---------------------------------------------------    
elseif method == 9 || method == 10 || method == 11 %CNN1 is imagenet-vgg-f
    % setup MatConvNet
    run  scripts/matconvnet-1.0-beta12/matlab/vl_setupnn;
    % load the pre-trained CNN
    net = load('imagenet-vgg-f.mat');
    
    if method == 9 % low layer
        name = 'CNN1(low)';
        layer=5; %conv2
    elseif method == 10 % mid layer
        name = 'CNN1(mid)';
        layer=13; 
    elseif method == 11 % high layer
        name = 'CNN1(high)';
        layer=20; 
    end
%---------------------------------------------------    
elseif method == 12 || method == 13 || method == 14 %CNN2 is imagenet-vgg-m
    % setup MatConvNet
    run  scripts/matconvnet-1.0-beta12/matlab/vl_setupnn; 
    % load the pre-trained CNN
    net = load('imagenet-vgg-m.mat');
    
    if method == 12 % low layer
        name = 'CNN2(low)';            
        layer=5; %conv2
    elseif method == 13 % mid layer
        name = 'CNN2(mid)';
        layer=13; 
    elseif method == 14 % high layer
        name = 'CNN2(high)';
        layer=20; 
    end
%---------------------------------------------------    
elseif method == 15 || method == 16 || method == 17 %CNN3 is imagenet-vgg-s
    % setup MatConvNet
    run  scripts/matconvnet-1.0-beta12/matlab/vl_setupnn; 
    % load the pre-trained CNN
    net = load('imagenet-vgg-s.mat');
    
    if method == 15 % low layer
        name = 'CNN3(low)';            
        layer=5; 
    elseif method == 16 % mid layer
        name = 'CNN3(mid)';
        layer=12; 
    elseif method == 17 % high layer
        name = 'CNN3(high)';
        layer=19; 
    end
%---------------------------------------------------    
elseif method == 18 || method == 19 || method == 20 %CNN4 is imagenet-vgg-verydeep-16
    % setup MatConvNet
    run  scripts/matconvnet-1.0-beta12/matlab/vl_setupnn; 
    % load the pre-trained CNN
    net = load('imagenet-vgg-verydeep-16.mat');    
    
    if method == 18 % low layer
        name = 'CNN4(low)';            
        layer=8; 
    elseif method == 19 % mid layer
        name = 'CNN4(mid)';
        layer=20; 
    elseif method == 20 % high layer
        name = 'CNN4(high)';
        layer=36; 
    end        
%---------------------------------------------------    
elseif method == 21 || method == 22 || method == 23 %CNN5 is imagenet-vgg-verydeep-19
    % setup MatConvNet
    run  scripts/matconvnet-1.0-beta12/matlab/vl_setupnn; 
    % load the pre-trained CNN
    net = load('imagenet-vgg-verydeep-19.mat');
    
    if method == 21 % low layer
        name = 'CNN5(low)';            
        layer=8; 
    elseif method == 22 % mid layer
        name = 'CNN5(mid)';
        layer=31; 
    elseif method == 23 % high layer
        name = 'CNN5(high)';
        layer=42; 
    end      
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute feature vectors for each image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%I_vis = cell(1,n_imgs); *** don't need REMOVE (see line284)
F = cell(1,n_imgs);  % F will contain all feature vectors
global Ic;
for img=1:n_imgs
	fprintf(['Computing feature vector for image ' int2str(img) filesep '' int2str(n_imgs) '\n']);
	Ic = imread([img_dir filesep '' word_map{img}]);
    imgPass = Ic;
% 	if visualize_3d % *** Probably won't need ***
% 		I_vis(img) = {Ic};
% 	end
	Ic = mean(Ic,3); % do we need this?
	run([full_path 'scripts/compute_features']); % for Ic
	if method ~= 7
		F(img) = {Fc};
	end
end % img1 loop

if method == 7
	system(sm_cmd);
end

time_stamp = datestr(now,'HHMM_yyyy-mmm-dd');
time_stamp = [name '_' time_stamp];
folder_name = [img_dir 'results' filesep];
% Save the features
try
    file_name = [folder_name 'features_' time_stamp '.mat'];
    save(file_name,'F','word_map','-v7.3');
    fprintf('Feature vectors saved: %s\n', file_name);
catch ME
    getReport(ME)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute RDM
%%%%%%%%%%%%%%%%

if compute_RDM
	RDM_size = nchoosek(n_imgs,2);
	RDM = zeros(1, RDM_size);
	RDM_ind = 1;
    %--------------------------------------------------------------------------
	if method == 2 % sift
		for img=1:n_imgs
			for j=1:size(F{img},2) % append the feature vectors from this image to the global pool of them in feature_vectors
				feature_count = feature_count + 1;
				feature_vectors(:,feature_count) = double(F{img}(:,j));
			end
		end
		feature_vectors2 = transpose(feature_vectors);
		disp('Clustering vectors (this could take a while)...');
		options = statset('MaxIter', 5000);
		%keyboard
		idx = kmeans(feature_vectors2, cluster_size, 'Options', options, 'EmptyAction','drop');

		%% group cluster indices for each image, and create histogram of them
		feature_count_start = 1; %where an image starts copying cluster IDs
		clear N_t;
		for img=1:n_imgs
			%%%%%% output status
		   fprintf('Grouping cluster IDs for image %i\n', img);
			%%%%%%%
			feature_count_end = feature_count_start + size(F{img},2) - 1; % determine how many feature vector IDs to copy for this image
			
			%%%%%%%%%%%%%
			clusters = idx(feature_count_start:feature_count_end); % copy feature vectors
			%%%%%%%%%%%%%
			
			feature_count_start = feature_count_end + 1; % where the next image starts copying IDs
			N = hist(clusters, [1:cluster_size]);
			% normalize histogram so that it sums to 1 (needed for kldiv)
			sum_h = 0;
			for m=1:size(N, 2)
				if ~N(m)
					N(m) = eps; %avoid issues with log(0) when calling kldiv
				end
				sum_h = sum_h + N(m);
			end
			alpha = 1 / sum_h;
			N_t(img,:) = alpha * N; % vector of histograms for each image
		end
    end
    %--------------------------------------------------------------------------
	if method == 7 % shock graphs
		system([sm_path 'sm -matrix matrix_results.m stims.db'])
		run([img_dir filesep 'matrix_results'])
		RDM = 1-m; % invert, so it is now a dissimilarity matrix
		for i=1:n_imgs
			RDM(i,i) = 0; % make sure diagonal is zero. some matlab functions complain if it isn't [eg squareform()]
        end
        %----------------------------------------------------------------------
    else % This happens for all methods other than shock graphs.
		for img=1:n_imgs
			fprintf('Computing dissimilarity matrix... %i%% done\n', round(100*RDM_ind/RDM_size));
			for img2=img+1:n_imgs
				run([full_path 'scripts/compare_features']) % compare_features.m is where the real computation happens
				RDM_ind = RDM_ind + 1;
			end
		end
		RDM(find(RDM == Inf)) = -Inf;
		RDM(find(RDM == -Inf)) = max(RDM);
    end
    
%% *** No longer using dendrograms ***
%% *** Will change to just a heatmap, will use different heatmap ***
% 	if create_dendrogram
% 		disp_size = 15;  %Is this needed?
% 		run([full_path 'scripts/save_results_heatmap'])
% 		run([full_path 'scripts/save_results_dendrogram'])
%    end
    
    if create_heatmap
        % assumes higher values in RDM = more distance
        if ~(method == 7) % If method were 7 : RDM_s would revert to only one row
            RDM_s = squareform(RDM);
            %RDM_s(n_imgs,:) = 0; % make sure the matrix is square *** PROBLEM
            correlation_back = RDM_s; % preserve data. correlation_back will be altered
        else % method is 7, so just use RDM
            correlation_back = RDM;
        end
        
%         %determine max value in RDM
%         tmp_mat = correlation_back; % NEW VERSION TO DETERMINE MAX
%         tmp_mat(tmp_mat==Inf) = 0;
%         max_val = max(max(tmp_mat));
%           
%         % determine min value, ignoring zeros
%         tmp_mat(tmp_mat==0) = Inf;  % NEW VERSION TO DETERMINE MIN
%         min_val = min(min(tmp_mat));
% 
%         diff = max_val - min_val;
%         % normalize so smallest value is zero and max value is 'diff'
%         correlation_back = correlation_back - min_val;
%         prc_mat = correlation_back;
%         for i=1:n_imgs
%             for j=1:n_imgs
%                 percent = (correlation_back(i,j) / diff);
%                 prc_mat(i,j) = percent;
%             end
%         end
        %Plot the heatmap
        figure('Name','Heatmap For RDM','NumberTitle','off');
        colormap('jet');
        %imagesc(prc_mat);
        imagesc(correlation_back);
        set(gca,'xtick',[],'ytick',[]);
        colorbar
    end    
    
%% *** Probably not going to need this at all ***
% 	if visualize_3d
%         fprintf('Probably not going to visualize_3d anymore.\n');
% 		imcoords=mdscale(squareform(RDM),2);
% 		md_img = imScatter(I_vis,imcoords);
% 		file_name = [folder_name 'md_scaling_' time_stamp '.png'];
% 		imwrite(md_img,file_name);
% 		fprintf('Multi-dimensional scaling map saved: %s\n',file_name);
%   end
    
%% *** Probably not going to need this at all ***	
%  	if categorize_imgs
%         fprintf('Probably not going to categorize_imgs anymore.\n');
% 		Z1 = linkage(RDM,'average');
% 		node_list1 = find_nodes(Z1,n_img_categories,n_imgs);
% 		objs1 = cell(n_img_categories,1);
% 		for i=1:n_img_categories
% 			%%%%%%%%%%
% 			% The first dendrogram: Did this cut yield a node or an object?
% 			%%%%%%%%%
% 			if node_list1(i) <= n_imgs % It's not a node but an object
% 				img_categories(node_list1(i)) = i; % the only entry is this object
% 			else
% 				% This is a node: we will now branch down it and find all of the
% 				% objects within it
% 				objs1 = find_items(Z1,node_list1(i),n_imgs);
% 				img_categories(objs1) = i;
% 			end
% 		end
% 		fprintf('The image category (cluster) corresponding to image word_map{i} is stored in img_categories(i)\n');
%  	end % categorize imgs
    
    if ~(method == 7)
        RDM=squareform(RDM);
    end
end % RDM

if rank_similarity % Rank the 100 most/least similar image pairs
    clearvars -except F word_map RDM img_categories rank_similarity folder_name time_stamp file_name current_dir img_dir gui_mode;
    RDM_ranking = triu(RDM,1);  % copy the upper triangular part of RDM into RDM_ranking
                                % The diagonal and below will just be zeros.  
    mostSim_i = zeros(100,1);  % -|
    mostSim_j = mostSim_i;     % -| <-- To record the indices of 
    leastSim_i = mostSim_i;    % -|     each image pair
    leastSim_j = mostSim_i;    % -|
    % Find the 100 most similar image pairs (minimum dissimilarity)
    RDM_ranking(RDM_ranking==0) = Inf; % So zeros don't alter results 
    for z=1:100
        [row,col] = find(RDM_ranking==min(RDM_ranking(:))); % obtain indices      
        mostSim_i(z) = row(1);
        mostSim_j(z) = col(1);                
        RDM_ranking(row(1),col(1)) = Inf; % set the found min to Inf;
    end
    % Find the 100 least similar image pairs (maximum dissimilarity)
    RDM_ranking(RDM_ranking==Inf) = 0; % So values of Inf don't alter results
    for z=1:100
        [row,col] = find(RDM_ranking==max(RDM_ranking(:))); % obtain indices      
        leastSim_i(z) = row(1);
        leastSim_j(z) = col(1);                
        RDM_ranking(row(1),col(1)) = 0; % set the found max to 0;
    end
    
    % Display thumbnails of ranked pairs
    cd(img_dir);
    thumbset = cell(200,1);
    i = 1;
    j = 2;
    
    for z=1:100
        thumbset{i} = word_map{mostSim_i(z)};
        thumbset{j} = word_map{mostSim_j(z)};
        i = i+2;
        j = j+2;
    end
    figure('Name','100 Most Similar Image Pairs','NumberTitle','off');
    montage(thumbset, 'size' ,[10 NaN]);
    i = 1;
    j = 2;
    for z=1:100
        thumbset{i} = word_map{leastSim_i(z)};
        thumbset{j} = word_map{leastSim_j(z)};
        i = i+2;
        j = j+2;
    end
    figure('Name','100 Least Similar Image Pairs','NumberTitle','off');
    montage(thumbset, 'size' ,[10 NaN]);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% save

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


% cd(current_dir)
% if gui_mode % so the variables don't flood the screen incase this function was called without a trailing ;
% 	clear F word_map RDM img_categories
% end
