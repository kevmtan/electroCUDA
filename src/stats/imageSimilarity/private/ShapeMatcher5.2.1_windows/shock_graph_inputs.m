% This file converts png images to binary silohuetes. The resulting
% images are fed to the shape matching program and an RDM is computed.
% This script requires ImageMagick's convert and 'sm', the
% shape matching program. The paths of 'convert' and 'sm' can be specified
% below.

% While Matlab can output .ppm files (the input format the shape matching
% program uses), the shape matching program does not seem to accept Matlab's output,
% hence the need for the 'convert' utility.

% the path names should have trailing slashes /pathname/, not /pathname
img_path = 'stim_final/'; % path where the images
% are loaded from.
sm_path = ''; % location of shape matching program (on Windows, there might be problems
% loading the .dlls if this is in another location besides your current directory)
convert_path =''; % for imagemagick

n_imgs = 60; % number of images to load. assumed names are [1.png 2.png ... n_imgs.png]

bg_color = 137; % the shade the background of the images. it should be monotone.
%bg_color = 128;

%%%%%%%%%%%%%%%%%%%
% delete files from prior runs of this script (ppm files and stims.db)
%%%%%%%%%%%%%%%%%
if exist('stims.db','file')
	delete('stims.db');
end

%%%%%%%%%%%%%%%%%%%%%
% create gaussian filter
%%%%%%%%%%%%%%%%%%%%%
clear g_filter
%filter_size = 3;
%edge_effect = 4;
filter_size = 5;
edge_effect = 8;
filter_overlap = (filter_size - 1) / 2; % center
for i= 1:filter_size
	for j= 1:filter_size
		g_filter(i,j) = round2(normpdf(i, filter_overlap+1, 2) * ...
			normpdf(j, filter_overlap+1, 2), 1e-3);
	end
end
g_filter = g_filter /  sum(sum(g_filter)); % normalize

%%%%%%%%%%%%%%%%%%%
% file name indices:
% the shape matching program treats files whose names are
% differentiated by only numbers differently than files whose
% names are differentiated by alphabetical characters.
% ex 1.ppm isn't treated distinctly from 2.ppm, where as a.ppm
% and b.ppm are. these indices are used to replace 1 with 'a', 2 with 'b'
% 3 with 'c' etc. so file 41.ppm will be: da.ppm
indices='abcdefghij';

db_gen = [sm_path 'sm -c stims.db']; % the file names will be appended
% to this string, it will later be executed to generate the database.
for i=1:n_imgs % for all the files
	I = imread([ img_path int2str(i) '.png' ]);

	I = mean(I,3); % convert to grayscale
	Ib = bg_color*ones(size(I,1)+edge_effect*2, size(I,2)+edge_effect*2); % make image larger
	% so that convolution doesn't crop off the edges
	Ib(edge_effect:edge_effect+size(I,1)-1,edge_effect:edge_effect+size(I,2)-1) = I;
	I = Ib;
	I = conv2(I,g_filter); % blur
	I = abs(I - bg_color) >= 2; % binary/bw
	I = conv2(double(I),g_filter); % blur again
	I = abs(I) >= 0.1; % binary /bw
	I = 1-I; % invert
	% each convolution has edge effects, remove them:
	I(1:edge_effect,:)=1;
	I(:,1:edge_effect)=1;
	I(size(I,1)-edge_effect:size(I,1),:)=1;
	I(:,size(I,2)-edge_effect:size(I,2))=1;
	% create alphabetical file name
	file_name = int2str(i);
	for j=1:size(file_name,2)
		file_name(j) = indices(str2num(file_name(j)) + (~str2num(file_name(j)))*10);
	end
	imwrite(I, [ file_name '.png' ]); % write png
	pause(0.5);
	cmds = [convert_path 'convert ' file_name '.png ' file_name '.ppm'];
	system(cmds);
	fprintf('%s\n',cmds);
	db_gen = [ db_gen ' ' file_name '.ppm']; % append image to db creation command
	
	%imtool(I,'displayrange',[]); % debug
	%break;
end
fprintf('%s\n',db_gen);
system(db_gen)
fprintf('%s\n',[sm_path 'sm -matrix matrix_results.m stims.db']); % create similarity matrix
system([sm_path 'sm -matrix matrix_results.m stims.db'])
matrix_results % load 'm', the similarity matrix that was created
score_list = 1-m; % invert, so it is now a dissimilarity matrix
for i=1:n_imgs
	score_list(i,i) = 0; % make sure diagnol is zero. some matlab functions complain if it isn't [eg squareform()]
end
save shock_graph_rdm score_list
