% Method: Geometric blur.  geo_blur_data.m should have already been run. This script finds matches and computes the cost of matching them
window_size = 9;
alpha = 0.5; % G_(a*|x|)_ ---- used to determine extent to which the gaussian filter increases towards the edges of a keypoint


% incase it was previously reordered due to size
I_blur1 = I_blur{img}; % blured image
chosen_points1 = F{img}; % keypoints x, y

I_blur2 = I_blur{img2};
chosen_points2 = F{img2};

% find minimum and maximum number of points that were found
if size(chosen_points1, 1) > size (chosen_points2, 1)
	max_points = size(chosen_points1, 1);
	min_points = size(chosen_points2, 1);
	
	% chosen_points1 is later assumed to be smaller or equal in # points, so switching:
	I_blur_b = I_blur1;
	chosen_points_b = chosen_points1;
	I_blur1 = I_blur2;
	chosen_points1 = chosen_points2;
	I_blur2 = I_blur_b;
	chosen_points2 = chosen_points_b;
else
	max_points = size(chosen_points2, 1);
	min_points = size(chosen_points1, 1);
end

%%%%%%%%%%
%compute matches-nearest neighbor. stored in best_match. the index is the point from the smaller image
%%%%%%%%%%
for i=1:min_points
	min_dist = inf;
	for j=1:max_points
		dist = sqrt((chosen_points1(i,1) - chosen_points2(j,1))^2 + ...
							(chosen_points1(i,2) - chosen_points2(j, 2))^2);
		if dist < min_dist
			min_dist = dist;
			best_match(i) = j;
		end
	end
end

%%%%%%%%%
% replace duplicate matches with nulls. keep closest match
%%%%%%%%%
for i=1:min_points
	match = best_match(i);
	if match
		match_i = i;
		dist = sqrt((chosen_points1(i,1) - chosen_points2(match,1))^2 + ...
								(chosen_points1(i,2) - chosen_points2(match, 2))^2);
		% if other matches are greater than 'dist' then they can be removed
		for j=i+1:min_points
			if match == best_match(j) % this is a duplicate
				dist2 = sqrt((chosen_points1(i,1) - chosen_points2(j,1))^2 + ...
								(chosen_points1(i,2) - chosen_points2(j, 2))^2);
				if dist2 < dist % discard the previous found match. keep this one
					best_match(match_i) = 0;
					match_i = j;
					dist = dist2; % new minimum distance
				else
					best_match(j) = 0;
				end
			end % end match check
		end % end comparison loop
	end % end match check
end
%%%%%%%%%%
% distance/orientation. chose two points and find which other two points in the other image match best
%%%%%%%%%%
da = 0; % change in direction
dl = 0; % change in distance
h_sum = 0;
for i=1:min_points % go through all keypoints for the image with the least # of points
	if best_match(i) % if there is a match for this point
		for j=i+1:min_points
			if best_match(j)
				%length of vectors
				l_r = sqrt((chosen_points1(i,1) - chosen_points1(j,1))^2 + (chosen_points1(i,2) - chosen_points1(j,2))^2);
				l_s = sqrt((chosen_points2(best_match(i),1) - chosen_points2(best_match(j),1))^2 +  ...
								(chosen_points2(best_match(i), 2) - chosen_points2(best_match(j),2))^2);
				%angle between points
				theta1 = atan((chosen_points1(i,2) - chosen_points1(j,2)) / (chosen_points1(i,1) - chosen_points1(j,1)));
				theta2 = atan((chosen_points2(best_match(i),2) - chosen_points2(best_match(j),2)) /  ...
							(chosen_points2(best_match(i),1) - chosen_points2(best_match(j),1)));
				theta = abs(theta1 - theta2);
				if isnan(theta)
					keyboard
				end
				da = da + (alpha_d * theta)/(l_r + beta_d);
				
				% distance between points
				dl = dl + abs(l_s - l_r)/(l_r + mu_d);
				
				h_sum = h_sum + gamma*da + (1-gamma)*dl; % the geometric portion of the cost function
			end
		end
	end
end

%%%%%%%%%
% pearson correlation-based on sub-sampled values
%%%%%%%%%
sum_r = 0;
for i=1:min_points
	if best_match(i) % if this point has a match
		sub_sample1(i,:) = sub_sample_points(I_blur1, chosen_points1, i);
		sub_sample2(i,:) = sub_sample_points(I_blur2,  ...
				chosen_points2, best_match(i));
		mean1 = sum(sub_sample1(i)) / 17;
		mean2 = sum(sub_sample2(i)) / 17;
		rxy = 0;
		sx = 0;
		sy = 0;
		for j=1:17
			sx = sx +  (sub_sample1(i,j) - mean1)^2;
			sy = sy + (sub_sample2(i,j) - mean2)^2;
			rxy = rxy + (sub_sample1(i,j) - mean1)* ...
					(sub_sample2(i,j) - mean2);
		end
		sx = sx / 16;
		sy = sy / 16;
		rxy = rxy / (16*sx*sy);
		sum_r = sum_r + rxy;
	end
end

RDM(RDM_ind) = 1/abs(-w_m * sum_r + w_d * h_sum);
% dissimilarity matrix. with the given parameters, the results are always negative
% this is due to the correlation part. so the least negative is the worst matched, which is why the absolute value and inverse is taken