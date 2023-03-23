% Method: Hierarchical model

% convolve filters with images and take absolute value
%disp('The images will now be filtered (this could take some time)');
%I = image_data{i};
%I = single(mean(I,3)); % Conversion to single is recommended
I = imresize(single(Ic), [400 400]);
I = I/255;
for j=1:n_filters % run each filter
	I_filtered(j) = { abs(tanh(conv2(I, filter{j}))) }; %convolve -> tanh -> abs value
	I_g(j) = { conv2(I_filtered{j}, g_filter_Jar) }; % convolve with gaussian
end

%sum gaussian conv across filters
for k=1+filter_overlap:400-filter_overlap
	for l=1+filter_overlap:400-filter_overlap % pixel to filter
		I_g_sum(k,l) = 0;
		for j=1:n_filters
			I_g_sum(k,l) = I_g_sum(k,l) + I_g{j}(k,l);
		end
	end
end

%subtract results from I_filtered
for k=1+filter_overlap:400-filter_overlap
	for l=1+filter_overlap:400-filter_overlap % pixel to filter
		for j=1:n_filters
			I_filtered{j}(k,l) = I_filtered{j}(k,l) - I_g_sum(k,l);
		end
	end
end

%gausian conv^2
for j=1:n_filters % run each filter
	I_g(j) = { conv2((I_filtered{j}).^2, g_filter_Jar) }; % convolve with gaussian
end

%sum gaussian conv across filters--> sqrt
for k=1+filter_overlap:400-filter_overlap
	for l=1+filter_overlap:400-filter_overlap % pixel to filter
		I_g_sum(k,l) = 0;
		for j=1:n_filters
			I_g_sum(k,l) = I_g_sum(k,l) + I_g{j}(k,l);
		end
		I_g_sum(k,l) = sqrt(I_g_sum(k,l));
	end
end
I_g_avg = sum(sum(I_g_sum)) / ((400-3*(filter_size-1))^2);

%divide
for k=1+filter_overlap:400-filter_overlap
	for l=1+filter_overlap:400-filter_overlap % pixel to filter
		for j=1:n_filters
			I_filtered{j}(k,l) = I_filtered{j}(k,l)/max(I_g_avg, I_g_sum(k,l));
		end
	end
end
%average (pooling)
for j=1:n_filters
	I_filtered(j) = { conv2(I_filtered{j}, box_filter) };
	% decrease size, due to convolutions
	I_filtered(j) = { I_filtered{j}(4*filter_overlap:400-4*filter_overlap, 4*filter_overlap:400-4*filter_overlap) };
	
	%histogram
	l_form = reshape(I_filtered{j}, [], 1);
	N_t =  hist(l_form, [-2:0.1:2]);
	sumh = 0;
	for(m=1:size(N_t, 2))
		 if ~N_t(m)
			N_t(m) = eps; %avoid issues with log(0) when calling kldiv
		end
		sumh = sumh + N_t(m);
	end
	alpha = 1 / sumh;
	Fc(j) = { alpha * N_t };
end