function [I_blur, chosen_points] = compute_points(I)
global window_size find_points alpha;
%keyboard
%I = image_data{file_index};
I = single(mean(I,3)); % Conversion to single is recommended
I = imresize(I, [400 400]);

%%%%%%%
% SIFT locations
%%%%%%%
%F = round(vl_sift(I));
%F2 = round(transpose(F(1:2,:)));
%F2_b = F2;
%% remove duplicates
%for i=1:size(F2, 1)
%	if i > size(F2,1)
%		break;
%	end
%	
%	% boundary
%	hit = 1;
%	while hit
%		x = F2(i, 1);
%		y = F2(i, 2);
%		if (x-2*window_size) < 1 || (x+2*window_size) > 400 || ...
%						(y-2*window_size) < 1 || (y+2*window_size) > 400
%			F2a = F2(1:i-1,:);
%			F2b = F2(i+1:size(F2,1),:);
%			F2 = [F2a; F2b];
%			fprintf('%i %i %i\n', x, y, i);
%		else
%			hit = 0;
%		end
%	end
%	for j=i+1:size(F2,1)
%		if j > size(F2,1)
%			break;
%		end
%		if (x == F2(j, 1) && y == F2(j, 2)) || ((x-2*window_size) < 1 || (x+2*window_size) > 400 || ...
%					(y-2*window_size) < 1 || (y+2*window_size) > 400)
%			F2a = F2(1:j-1,:);
%			F2b = F2(j+1:size(F2,1),:);
%			F2 = [F2a; F2b];
%		end
%	end
%end
%chosen_points = F2;
%%%%%%%%
% edge locations
%%%%%%%%
I_edge = single(edge(I, 'canny'));
n_points = sum(sum(I_edge));
% select points 10x10 sz
for i=1:find_points
	too_close = 1; % ensure not too close to already selected points
	too_close_sum = 0;
	while too_close && too_close_sum < 50
		points_passed = 0;
		selected_point = round(1 + rand()*(n_points-2));
		found = 0;
		for j=1:400
			for k=1:400
				if(I_edge(j,k))
					points_passed = points_passed + 1;
					if points_passed == selected_point
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
		if (x-4*window_size) < 1 || (x+4*window_size) > 400 || ...
					(y-4*window_size) < 1 || (y+4*window_size) > 400
			too_close = 1;
			too_close_sum = too_close_sum + 1;
		end
		for l=1:(i-1)
			if 	sqrt((x - chosen_points(l,1))^2 + (y- chosen_points(l,2))^2) < (window_size + 1)
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

h_window_size = (window_size - 1) / 2;
global g_filter;
% blur feature points
I_blur = single(I_edge);
for i=1:size(chosen_points,1)%n_points
	x = chosen_points(i,1);
	y = chosen_points(i,2);
	%%%%%%% debug
	%if ~mod(i, 10)
	%	fprintf('compute_points: blur: %i %s \n', i, file_name);
	%end
	%%%%%
	for(j=(x-h_window_size):(x+h_window_size))
		%j
		for(k=(y-h_window_size):(y+h_window_size))
			new_val = 0;
			pdf_sum = 0;
			dist = round(sqrt((x - j)^2 + (y-k)^2));
			if ~dist
				dist = 1;
            end
            m = j-2*h_window_size:j+2*h_window_size;
            n = k-2*h_window_size:k+2*h_window_size;
            blurred = conv2(I_edge(m,n), g_filter{dist});
            I_blur(j,k) = blurred(2*h_window_size+1, 2*h_window_size+1);
            %keyboard
			%for m=j-h_window_size:j+h_window_size
			%	for n=k-h_window_size:k+h_window_size
					%pdf_sum = pdf_sum + ...
					%		normpdf(m, j, alpha*dist+0.1) * normpdf(n, k, alpha*dist+0.1);
					%new_val = new_val + I(m, n) * ...
					%		normpdf(m, j, alpha*dist+0.1) * normpdf(n, k, alpha*dist+0.1);
					%keyboard
					%pdf_sum = pdf_sum +  g_filter{dist}(1+m-(j-h_window_size), 1+n-(k-h_window_size));
			%		if m > 400 || m < 1 || n < 1 || n > 400
			%			keyboard
			%		end
			%		new_val = new_val + g_filter{dist}(1+m-(j-h_window_size), 1+n-(k-h_window_size))*I_edge(m,n);
			%	end
			%end % end conv loops
			%I_blur(j,k) = new_val;
			%I_blur(j,k) = new_val;
			%keyboard
		end
	end % end loop of window pixels
end
