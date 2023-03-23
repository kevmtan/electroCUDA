function resp = s1_out(img,img_size)
orientations = (pi/180)*[0 45 90 135];
rf_sizes = [32 36 40 46 54 60];
rf_ind = 0;
resp = zeros(img_size, img_size, size(rf_sizes,2), size(orientations,2));

distn=zeros(img_size);
for rf_size = rf_sizes
	rf_ind = rf_ind + 1; orientation_ind = 0;
	%for i = 1+rf_size/2 : (img_size - rf_size/2)-1
	%	for j = 1+rf_size/2 : (img_size - rf_size/2)-1
	%		distn(i,j) = sqrt(sum(sum(img(i-rf_size/2:i+rf_size/2-1, j-rf_size/2:j+rf_size/2-1).^2)));
	%	end %j
	%end %i
	%keyboard
	for orientation = orientations
		orientation_ind = orientation_ind + 1;
		% generate gabors
		ii=0;
		gabor = zeros(rf_size);
		for i = linspace(-pi,pi, rf_size)
			ii = ii + 1; jj = 0;
			for j = linspace(-pi,pi, rf_size);
				jj = jj + 1;
				gabor(ii,jj) = h_func(i, j, orientation);
			end
		end
		gabor = gabor / sqrt(sum(sum(gabor.^2))); % normalize
		%imtool(gabor,'displayrange',[]);
		
		% dot product
		%for i = 1+rf_size/2 : (img_size - rf_size/2)-1
		%	for j = 1+rf_size/2 : (img_size - rf_size/2)-1
		%		resp(i,j, rf_ind, orientation_ind) = abs(sum(sum((...
		%			img(i-rf_size/2:i+rf_size/2-1, j-rf_size/2:j+rf_size/2-1) /distn(i,j)) .* gabor)));
		%	end %j
		%end %i
		%keyboard
		tempi = abs(conv2(img,gabor));
		resp(:,:,rf_ind,orientation_ind) = tempi(rf_size/2:img_size+rf_size/2-1,rf_size/2:img_size+rf_size/2-1);%./distn;
		
	end % orientation
end % rf_size
%keyboard
crop = 1+30:img_size-30;
resp = resp(crop, crop,:,:);
rf_ind = 0;
%for rf_size = rf_sizes
	rf_ind = rf_ind + 1; orientation_ind = 0;
	for orientation = orientations
		orientation_ind = orientation_ind + 1;
		%imtool(resp(:,:,rf_ind,orientation_ind),'displayrange',[]);
	end
%end
