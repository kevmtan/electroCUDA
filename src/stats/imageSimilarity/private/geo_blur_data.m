% Method: geometric blur. computes and blurs keypoints
%global find_points w_m w_d gamma alpha_d beta_d mu_d


%% compute and blur keypoints for each image
for i=1:n_imgs
	%keyboard
	fprintf('Generating and blurring keypoints for image %i\n', i);
	[I_blur1, chosen_points1] = compute_points(image_data{i},find_points);
	
	I_blur(i) = { I_blur1 }; % blurred images
	chosen_points(i) = { chosen_points1 }; % the blurred keypoints
end