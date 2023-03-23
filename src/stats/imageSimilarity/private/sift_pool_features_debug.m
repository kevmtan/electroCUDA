feature_count = 0; % total number of feature_vectors
% load feature vectors
for i = 1:n_imgs
    %%%%%% output status
   fprintf('Loading feature vectors for image %i\n', i);
    %%%%%%%
	
	% load image data and feature vectors
	I = image_data{i};
	I = single(mean(I,3)); % Conversion to single is recommended
	I = imresize(I, [400 400]);
	[F1 D1] = vl_sift(I);
    for(j=1:size(D1,2)) % append the feature vectors from this image to the global pool of them in feature_vectors
       feature_count = feature_count + 1;
       feature_vectors(:,feature_count) = double(D1(:,j));
    end
end
feature_vectors2 = transpose(feature_vectors);
%% cluster
disp('Clustering vectors (this could take a while)...');
options = statset('MaxIter', 5000);
%keyboard
idx = kmeans(feature_vectors2, cluster_size, 'options', options, 'emptyaction','drop');


%% group cluster indices for each image, and create histogram of them
feature_count_start = 1; %where an image starts copying cluster IDs
clear N_t;
for i = 1:n_imgs
	%%%%%% output status
   fprintf('Grouping cluster IDs for image %i\n', i);
    %%%%%%%
	I = image_data{i};
	I = single(mean(I,3)); % Conversion to single is recommended
	I = imresize(I, [400 400]);
	[F1 D1] = vl_sift(I);
    feature_count_end = feature_count_start + size(D1,2) - 1; % determine how many feature vector IDs to copy for this image
    
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
    N_t(i,:) = alpha * N; % vector of histograms for each image
end
keyboard
%% find kl div for each image
disp('Finding KL divergence for each image pair...');
for i = 1:n_imgs
	for(j=i:n_imgs)
       score_list(i,j) = kldiv([1:cluster_size], N_t(i,:), N_t(j,:)) + ...
           kldiv([1:cluster_size], N_t(j,:), N_t(i,:)); % sum of comparision of A to B and of B to A
    end
end