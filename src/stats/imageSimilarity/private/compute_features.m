if method == 1 %% pixel 
	Fc = Ic;
elseif method == 2 % sift
	[junk,Fc] = vl_sift(single(Ic)); % get keypoints for image
elseif method == 3 % jarrett model
	clear Fc
	run([full_path '/scripts/hier_model'])  
elseif method == 4 % geometric blur
	[I_blur1, Fc] = compute_points(Ic,find_points,g_filter_Geo,window_size);
	I_blur(img) = { I_blur1 }; % blurred images
elseif method == 5 % scene gist
	imgr = imresize(Ic, [imageSize imageSize]);
    
    % Computing gist requires 1) prefilter image, 2) filter image and collect
    % output energies
    output = prefilt(double(imgr), 4);
    Fc = gistGabor(output, numberBlocks, G);
    %normalize Fc
    Fc = Fc ./ sum(Fc);
elseif method == 6 % HMAX
	img_size = 240;
	Ic = imresize(Ic(50:350,50:350,:),[img_size img_size]);
	resp = s1_out(Ic,img_size);

	resp = resp - min(reshape(resp,[1 prod(size(resp))]));
	resp = resp./max(reshape(resp,[1 prod(size(resp))]));
	resp_c1(1,:,:,:,:,:) =  c1_out(resp(1:120,1:120,:,:,:)) ;
	resp_c1(2,:,:,:,:,:) =  c1_out(resp(1:120,30+[1:120],:,:,:)) ;
	resp_c1(3,:,:,:,:,:) =  c1_out(resp(1:120,60+[1:120],:,:,:)) ;
	resp_c1(4,:,:,:,:,:) =  c1_out(resp(30+[1:120],1:120,:,:,:)) ;
	resp_c1(5,:,:,:,:,:) =  c1_out(resp(30+[1:120],30+[1:120],:,:,:)) ;
	resp_c1(6,:,:,:,:,:) =  c1_out(resp(30+[1:120],60+[1:120],:,:,:)) ;
	resp_c1(7,:,:,:,:,:) =  c1_out(resp(60+[1:120],1:120,:,:,:)) ;
	resp_c1(8,:,:,:,:,:) =  c1_out(resp(60+[1:120],30+[1:120],:,:,:)) ;
	resp_c1(9,:,:,:,:,:) =  c1_out(resp(60+[1:120],60+[1:120],:,:,:)) ;
	Fc = reshape(resp_c1,[1 prod(size(resp_c1))]);
elseif method == 7 % shock graphs
	sm_cmd = [sm_cmd word_map{img} ' '];
elseif method == 8 % gabor filter bank
        Ic=imresize(imSquare(Ic),[400 400]);
        Fc=gaborProject(gBank,double(squeeze(sum(Ic,3))));
elseif method >= 9 % One of the CNNs
    Fc = CNN(net,layer,imgPass);
end
