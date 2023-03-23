function [I_blur, chosen_points] = compute_points(I,find_points,g_filter_Geo,window_size)
%global window_size alpha;
I = single(mean(I,3)); % Conversion to single is recommended
I = imresize(I, [400 400]);
%keyboard
%%%%%%%%
% edge locations
%%%%%%%%
I_edge = edge(I, 'canny');
n_points = sum(sum(I_edge)); % number of edge pixels
% select keypoints randomly along the edges
for i=1:find_points
	too_close = 1; % ensure not too close to already selected points. assume that it is
	too_close_sum = 0; % if after 50 times of randomly chosing points and it is still too close to another point, skip it and move on
	while too_close && too_close_sum < 50
		selected_point = round(1 + rand()*(n_points-2)); % which point are we looking for out of 'n_points' possible points?
		points_passed = 0;  % how many points have we passed?
		found = 0; % used to break loop
		for j=1:400
			for k=1:400 % go through all points
				if(I_edge(j,k)) % this is an edge
					points_passed = points_passed + 1;
					if points_passed == selected_point % the point we are looking for
						chosen_points(i, 1) = j;
						chosen_points(i, 2) = k;
						found = 1;
						break;
					end % found correct point
				end % end found edge
			end % loop through coordinates
			if found
				break;
			end
		end % loop through coordinates
		%check if too close to other chosen coordinates
		too_close = 0;
		x = chosen_points(i,1);
		y = chosen_points(i,2);
		% make sure it is not too close to the edge of the image itself
		if (x-2*window_size) < 1 || (x+2*window_size) > 400 || ...
					(y-2*window_size) < 1 || (y+2*window_size) > 400
			too_close = 1;
			too_close_sum = too_close_sum + 1;
		end
		for l=1:(i-1) % is it too close to other points?
			if 	sqrt((x - chosen_points(l,1))^2 + (y- chosen_points(l,2))^2) < (2*window_size + 1) || ...
                    (x-2*window_size) < 1 || (x+2*window_size) > 400 || ...
					(y-2*window_size) < 1 || (y+2*window_size) > 400
				too_close = 1;
				too_close_sum = too_close_sum + 1;
				break;
			end % end distance check
		end % end check loop
	end % too close loop
	if too_close_sum >= 50
		disp('couldnt find all points');
		break;
	end
end % end loop through points
%keyboard
% double-check that the last point is not too close to an edge
if 	sqrt((x - chosen_points(l,1))^2 + (y- chosen_points(l,2))^2) < (2*window_size + 1) || ...
                    (x-2*window_size) < 1 || (x+2*window_size) > 400 || ...
					(y-2*window_size) < 1 || (y+2*window_size) > 400
   chosen_points = chosen_points(1:size(chosen_points,1)-1,:);             
end
h_window_size = (window_size - 1) / 2;
%global g_filter;
%% blur feature points %%
I_blur = single(I_edge);
for i=1:size(chosen_points,1)%n_points
	x = chosen_points(i,1);
	y = chosen_points(i,2);

	for(j=(x-h_window_size):(x+h_window_size)) % blur all points in the window
		for(k=(y-h_window_size):(y+h_window_size))
			new_val = 0; % new pixel value
			pdf_sum = 0; % for normalization
			dist = round(sqrt((x - j)^2 + (y-k)^2)); % distance from center
			if ~dist
				dist = 1;
			end
			for m=j-h_window_size:j+h_window_size % convolve the current point
				for n=k-h_window_size:k+h_window_size

					pdf_sum = pdf_sum +  g_filter_Geo(dist, 1+m-(j-h_window_size), 1+n-(k-h_window_size));
					if m > 400 || m < 1 || n < 1 || n > 400
						keyboard
					end
					new_val = new_val + g_filter_Geo(dist, 1+m-(j-h_window_size), 1+n-(k-h_window_size))*I(m,n);
				end
			end % end conv loops
			I_blur(j,k) = (1/pdf_sum)*new_val; % set the pixel to the new value
		end
	end % end loop of window pixels
end
