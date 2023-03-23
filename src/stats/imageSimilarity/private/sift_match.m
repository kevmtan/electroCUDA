[matches score] = vl_ubcmatch(F{img},F{img2}, 1.5);  % match A to B
[matches2 score2] = vl_ubcmatch(F{img2},F{img}, 1.5);  % match B to A
% record results
num_match = size(matches,2);
score_sum = sum(score);
num_match2 = size(matches2,2);
score_sum2 = sum(score2);

%% Score results based off chosen metric
invert = 0; % invert results so that a higher value means a greater distance between images
if s_method == 5
	%Ratio of percent matched to average Euclidean distance
	RDM(RDM_ind) = (num_match(i,j) ^ 2) / (score_sum(i, j) * num_match(i,i)) + ... 
						(num_match2(i,j) ^ 2) / (score_sum2(i, j) * num_match2(j,j));
	invert = 1;
elseif s_method == 3
	%Number of matches over the sum of the Euclidean distances
	score_list(i,j) = (num_match(i,j)) / (score_sum(i, j)) + ... 
						(num_match2(i,j)) / (score_sum2(i, j));
	invert = 1;
elseif s_method == 4
	%Percent of keypoints matched
	score_list(i,j) = ((num_match(i,j) ) / (num_match(i,i) )) + ...
			((num_match2(i,j) ) / (num_match2(j,j)));
	invert = 1;
	%keyboard
elseif s_method == 2
	%Number of matches
	score_list(i,j) = num_match(i,j) + num_match2(i,j);
	invert = 1;
elseif s_method == 0
	%Summing the Euclidean distances between matches
	score_list(i,j) = score_sum(i,j) + score_sum2(i,j);
elseif s_method == 1
	%Average Euclidean distance
	score_list(i,j) = score_sum(i,j)/num_match(i,i) + score_sum2(i,j)/num_match2(i,i);
end

if invert
    score_list = 1./score_list;
end

