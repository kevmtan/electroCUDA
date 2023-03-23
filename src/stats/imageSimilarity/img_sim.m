function [F word_map RDM img_categories] = img_sim(img_dir, method, create_dendrogram, compute_RDM, n_img_categories, visualize_2d)
% function [F word_map RDM img_categories] = img_sim(img_dir, method, create_dendrogram, compute_RDM, n_img_categories, visualize_2d)
%
% This function computes feature vectors for images. It can optionally 
% compute a dissimilarity matrix, categorize images (via clustering),
% create a dendrogram and heatmap representing the similarity between 
% images, and create a 2D multi-dimensional scaling to visualize the 
% similarity of images.
%
% If no input arguments are given, the script launches a GUI dialog 
% for configuration.
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
% create_dendrogram: Binary flag. 0= do not create the dengrogram
% compute_RDM: Binary flag. 0= do not compute the dissimilarity
%              matrix
% visualize_2d: Binary flag. 0= do not compute the MD scaling
%               visualization
% n_img_categories: The number of clusters to group the images.
%                   0=do not cluster.
%
% Outputs:
%
% F: A cell matrix with each entry containing the feature vector for
%   one image. (For the shock graph representation, this variable is 
%   not used)
% word_map: The file name corresponding to each entry in F. 
%    ex: word_map{i} is the file name of the feature vector for F{i}
% RDM: The dissimilarity matrix.
% img_categories: An array containing the category (cluster) each
%                 image is assigned. word_map{i} is the file name for
%                 entry img_categories(i)
%
% Example use of this function:
% [F word_map RDM img_categories] = img_sim('[path to this script]/example_images', 1, 1, 1, 1, 5)
%
% The settings for each representation are specified in this script.
% Technical details about each computer vision method are in
% readme.txt

% Written by Darren Seibert - February 4, 2012
% Modifications by Daniel Leeds - December 30, 2012

gui_mode = ~exist('img_dir','var');
full_path = mfilename('fullpath');
script_name = mfilename();
full_path = full_path(1:size(full_path,2)-size(script_name,2));
current_dir = pwd;
addpath([full_path '/scripts']);
if gui_mode
	global categorize_imgs visualize_3d create_dendrogram compute_RDM start method img_dir n_img_categories
	start = 0; %%
        compute_RDM=0;
        create_dendrogram=0;
        categorize_imgs=0;
        visualize_3d=0;
	method = 1;
	categorize_imgs = 0;
	n_img_categories = 5;

	img_dir=[full_path 'example_images/'];
else
	categorize_imgs = n_img_categories;
	visualize_3d = visualize_2d;
	start = 1;
end
RDM = 0; img_categories = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% default configuration


%%%%%%%%%%
% sift
global matched s_method
matched = 0; % default: 0=pooling
s_method = 4;
global cluster_size
cluster_size = 15;
feature_count = 0; % total number of feature_vectors

%%%%%%%%%
% jarrett
global n_filters filter_size avg_down_sample cluster_data
n_filters = 64; % default: 64 filters
filter_size = 9; % default: 9x9 filter size (should be odd)
avg_down_sample = 5;
cluster_data = 1; % default: do not cluster

%%%%%%%%
% gist
Nblocks = 4;
imageSize = 400; 
orientationsPerScale = [8 8 4];
numberBlocks = 4;
size_g = 960;
G = createGabor(orientationsPerScale, imageSize);

%%%%%%
% geoblur
global find_points w_m w_d gamma alpha_d beta_d mu_d
find_points = 30;
w_m = 1;
w_d = 1;
gamma = 0.9;
alpha_d = 1;
beta_d = 1;
mu_d = 1;

%%%%%%
% gabor filterbank
global gBank
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismac && method == 7
	warning('Shapematcher (the implementation used for shock graphs) may not run on OS X. Windows and Linux are supported.');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if gui_mode; try
	run([full_path 'scripts/dialogs/gui_disc']) %intro_new
end; end

if ~start
	clear F word_map RDM img_categories
	return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% determine images
names = dir(img_dir);
n_imgs = 0;
for i=1:size(names, 1) % loop through everything that dir returned
	strlen = size(names(i).name,2);
	
	if strlen > 3; if strcmp(names(i).name(strlen-3:strlen), '.ppm') || method ~= 7
		try % only keep entry if imread doesnt fail.
			junk = { imread([img_dir '/' names(i).name]) };
			word_map(n_imgs + 1) = { names(i).name }; % later used for outputting results (heatmap & dendrogram)
			n_imgs = n_imgs + 1;
		end
	end; end
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

[junk junk]=mkdir([img_dir '/results/']); % "[junk junk] = " supresses warnings

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initial configuration
if method == 1 % pixel sse
	name = 'SSE';
elseif method == 2 % sift
	name = 'SIFT';
	run([full_path 'scripts/vlfeat-0.9.8/toolbox/vl_setup'])
elseif method == 5 % scenegist
	name = 'SceneGist'; % used for file name
elseif method == 3
	name = 'Jarrett'; % used for file name of output files
	
	% generate random filters
	filter_overlap = (filter_size - 1) / 2; % amount lost due to edge effects for each convolution
	for i=1:n_filters
		%filter_sum = 0; % only used if the filter is normalized
	   for j = 1:filter_size
		   for k=1:filter_size
			   filter{i}(j,k) = round2(2*pi*rand() - pi, 1e-3); % any value can range from -pi to pi
			   %filter_sum = filter_sum + filter{i}(j,k);
		   end
	   end
	   %filter{i} = filter{i} / filter_sum;
	end

	% generate gausian filter for contrast normalization
	global g_filter;
        g_filter=[]
	for i= 1:filter_size
		for j= 1:filter_size
			g_filter(i,j) = round2(normpdf(i, filter_overlap+1, 2) * ...
				normpdf(j, filter_overlap+1, 2), 1e-3);
		end
	end
	g_filter = g_filter / (n_filters * sum(sum(g_filter))); % normalize
	%uniform box filter
	box_filter = (1/25)*ones(5,5);
elseif method == 6
	name = 'HMAX';
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
elseif method == 4
	name = 'Geoblur';
	global window_size alpha;
	window_size = 11; % should be odd
	h_window_size = (window_size - 1) / 2;
	alpha = 4 / (window_size - 1); % G_(a*|x|)_ ---- used to determine extent to which the gaussian filter increases towards the edges of a keypoint

	%keyboard
	%% create gausian filter for each distance involved (from the center of a window)
	global g_filter;
        g_filter=[];
	for i= 1:2*window_size
		for j= 1:2*window_size
			dist = round(sqrt((window_size - i)^2 + (window_size-j)^2));
			if ~dist
				dist = 1;
			end
			for m= 1:2*window_size+1
				for n= 1:2*window_size+1
					g_filter(dist, m,n) = round2(normpdf(m, window_size, alpha*dist+2) * ...
								normpdf(n, window_size, alpha*dist+2), 1e-4);
				end
			end
		end
	end
elseif method == 8
        name = 'Gabor';
	addpath([full_path '/scripts/wavelets/'])
	gBank=gaborBank(400,400,4);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute feature vectors for each image
I_vis = cell(1,n_imgs);
F = cell(1,n_imgs);
for img=1:n_imgs
	fprintf(['Computing feature vector for image ' int2str(img) '/' int2str(n_imgs) '\n']);
	Ic = imread([img_dir '/' word_map{img}]);	
	if visualize_3d
		I_vis(img) = {Ic};
	end
	Ic = mean(Ic,3);
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
folder_name = [img_dir '/results/'];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute RDM
if compute_RDM
	RDM_size = nchoosek(n_imgs,2);
	RDM = zeros(1, RDM_size);
	RDM_ind = 1;
	if method == 2 % sift
		for img=1:n_imgs
			for(j=1:size(F{img},2)) % append the feature vectors from this image to the global pool of them in feature_vectors
				feature_count = feature_count + 1;
				feature_vectors(:,feature_count) = double(F{img}(:,j));
			end
		end
		feature_vectors2 = transpose(feature_vectors);
		disp('Clustering vectors (this could take a while)...');
		options = statset('MaxIter', 5000);
		%keyboard
		idx = kmeans(feature_vectors2, cluster_size, 'options', options, 'emptyaction','drop');

		%% group cluster indices for each image, and create histogram of them
		feature_count_start = 1; %where an image starts copying cluster IDs
		clear N_t;
		for img = 1:n_imgs
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
			for(m=1:size(N, 2))
				if ~N(m)
					N(m) = eps; %avoid issues with log(0) when callking kldiv
				end
				sum_h = sum_h + N(m);
			end
			alpha = 1 / sum_h;
			N_t(img,:) = alpha * N; % vector of histograms for each image
		end
    end

	if method == 7 % shock graphs
		system([sm_path 'sm -matrix matrix_results.m stims.db'])
		run([img_dir '/matrix_results'])
		RDM = 1-m; % invert, so it is now a dissimilarity matrix
		for i=1:n_imgs
			RDM(i,i) = 0; % make sure diagnol is zero. some matlab functions complain if it isn't [eg squareform()]
		end
	else
		for img = 1:n_imgs
			fprintf('Computing dissimilarity matrix... %i%% done\n', round(100*RDM_ind/RDM_size));
			for img2 = img+1:n_imgs
				run([full_path 'scripts/compare_features'])
				RDM_ind = RDM_ind + 1;
			end
		end
		RDM(find(RDM == Inf)) = -Inf;
		RDM(find(RDM == -Inf)) = max(RDM);
	end
	
	if create_dendrogram
		disp_size = 15;
		run([full_path 'scripts/save_results_heatmap'])
		run([full_path 'scripts/save_results_dendrogram'])
	end
	
	if visualize_3d
		imcoords=mdscale(squareform(RDM),2);
		md_img = imScatter(I_vis,imcoords);
		file_name = [folder_name 'md_scaling_' time_stamp '.png'];
		imwrite(md_img,file_name);
		fprintf('Multi-dimensional scaling map saved: %s\n',file_name);
	end
	
	if categorize_imgs
		Z1 = linkage(RDM,'average');
		node_list1 = find_nodes(Z1,n_img_categories,n_imgs);
		objs1 = cell(n_img_categories,1);
		for i=1:n_img_categories
			%%%%%%%%%%
			% The first dendrogram: Did this cut yield a node or an object?
			%%%%%%%%%
			if node_list1(i) <= n_imgs % It's not a node but an object
				img_categories(node_list1(i)) = i; % the only entry is this object
			else
				% This is a node: we will now branch down it and find all of the
				% objects within it
				objs1 = find_items(Z1,node_list1(i),n_imgs);
				img_categories(objs1) = i;
			end
		end
		fprintf('The image category (cluster) corresponding to image word_map{i} is stored in img_categories(i)\n');
	end % categorize imgs
	RDM=squareform(RDM);
end % RDM

file_name = [folder_name 'features_' time_stamp];
save(file_name, 'F','RDM','word_map','img_categories')
fprintf('Feature vectors saved: %s\n', file_name);

cd(current_dir)
if gui_mode % so the variables don't flood the screen incase this function was called without a trailing ;
	clear F word_map RDM img_categories
end
