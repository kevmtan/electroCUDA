% Method: SSE
score_list = zeros(n_imgs, n_imgs); % will contain the dissimilarity matrix
x_size = 400;
y_size = 400;
for i = 1:n_imgs
	%%%%%% output status
   fprintf('Comparing image %i with all remaining. (%i%% done)\n', i, round(100*(compared/compare)));
    %%%%%%%
	I = image_data{i}; % image previously loaded in imgsim.m
	I = single(mean(I,3)); % Conversion to single is recommended
    I_size = size(I);
	% resize image if not correct size
    if ~(I_size(2) == y_size && I_size(1) == x_size)
        I = imresize(I, [x_size y_size]);
    end
    if binary_s
        I = make_binary(I); % convert to binary outline
    end

    for j = (i+1):n_imgs % compare each image with the remaining
        compared = compared + 1; % output purposes only
		% store previously saved image
        J = image_data{j};
        J = single(mean(J,3));
        J_size = size(J);
		% resize
        if ~(J_size(2) == y_size && J_size(1) == x_size)
            J = imresize(J, [x_size y_size]);
        end
        if binary_s
            J = make_binary(J); % convert to binary outline
        end
		% shift the image.
        trial = 0; % index into score_list_t, which stores the SSE for each shift.
        for x_shift=1:shift:floor(x_size/3)
            for y_shift=1:shift:floor(y_size/3) %shift image
                trial = trial + 1; % increase index
                score_list_t(trial) = 0;
                 for m=1:x_size-x_shift % compare all pixels
                    for n=1:y_size-y_shift
                        score_list_t(trial) = score_list_t(trial) + (I(m,n) - J(m,n)).^2;
                    end
                 end
                 if score_list_t(trial) == 0 % invalid.
                     score_list_t(trial) = Inf;
                 end
            end
        end % end shifting

        score_list(i,j) = min(score_list_t); % record the smallest shift
    end
end