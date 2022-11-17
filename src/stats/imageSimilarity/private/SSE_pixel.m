% Method: SSE

score_list = zeros(n_imgs); % will contain the dissimilarity matrix
x_size = size(image_data{1},1);
y_size = size(image_data{1},2);

for i=1:n_imgs
	I = image_data{i};
	image_data(i) = { single(mean(I,3)) };
    if binary_s % broken. don't use
        I = make_binary(I); % convert to binary outline
    end
end

score_index = 0;
for i = 1:n_imgs
	%%%%%% output status
   fprintf('Comparing image %i with all remaining.\n', i);
    %%%%%%%
	I = image_data{i};
    for j = (i+1):n_imgs % compare each image with the remaining
		% store previously saved image
        J = image_data{j};
		% shift the image.
        trial = 0; % index into score_list_t, which stores the SSE for each shift.
		score_list_t = zeros( size(1:shift:floor(x_size/3), 2) * size(1:shift:floor(y_size/3),2), 1);
        for x_shift=1:shift:floor(x_size/3)
            for y_shift=1:shift:floor(y_size/3) %shift image
                trial = trial + 1; % increase index
                score_list_t(trial) = sum(sum((I - J).^2));
                 if score_list_t(trial) == 0 % invalid.
                     score_list_t(trial) = Inf;
                 end
            end
        end % end shifting
		score_index = score_index + 1;
        score_list(i,j) = min(score_list_t); % record the smallest score
		score_list(j,i) = score_list(i,j); %parfor doesn't like this here
    end
end
% make symmetrical
%for i=1:n_imgs; for j = (i+1):n_imgs
%	score_list(j,i) = score_list(i,j);
%end;end