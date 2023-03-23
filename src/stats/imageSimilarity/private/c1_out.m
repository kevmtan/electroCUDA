function resp = c1_out(s1_resp)
%s1_resp(img_size, img_size, rf_sizes, orientations, imgs)
img_size = 120;
img_size_h = 0.5*120;
rf_shifts = [24 30 40]; %rf_size = 2*rf_shift
rf_start = [img_size_h-24-12 img_size_h-30 img_size_h-20];
n_tiles = [4 3 2];
pool_layers = [1 2; 3 4; 5 6];
rf_ind = 0;
n_imgs = size(s1_resp, 5);
resp = zeros(4,4,3,4,n_imgs);
%resp(img_size, img_size, scale, orientations, imgs)
level = 0;
for level = 1:3
	i_start = rf_start(level);
	rf_window = [-rf_shifts(level)+1:rf_shifts(level)];
	for tile_i=1:n_tiles(level)
		j_start = rf_start(level);
		for tile_j=1:n_tiles(level)
			% select all orientations and the correct 2 scales in this area:
			patches = s1_resp(i_start + rf_window, j_start + rf_window, pool_layers(level,:),:,:);
			patches = reshape(patches, [2*(2*rf_shifts(level))^2 4 n_imgs]); % n_layers*rf_size*rf_size
			resp(tile_i, tile_j, level, :, :) = max(patches); % max across scales
			
			j_start = j_start + rf_shifts(level);
		end % j
		i_start = i_start + rf_shifts(level);
	end % i
end % # of tiles
