% if method == 1 % pixel sse
% 	[x1 y1] = size(F{img});
% 	[x2 y2] = size(F{img2});
%     % xi_inds, yi_inds are vectors to be used for each image.
%     % They contain indexes for each pixel at each pass.
% 	if x1 >= x2
% 		x1_inds = [1+(x1*.5 - x2*.5) : (x1*.5 + y2*.5)];
% 		x2_inds = [1:x2];
% 	else
% 		x2_inds = [1+(x2*.5 - x1*.5) : (x2*.5 + x1*.5)];
% 		x1_inds = [1:x1];
% 	end
%
% 	if y1 >= x2
% 		y1_inds = [1+(y1*.5 - y2*.5) : (y1*.5 + y2*.5)];
% 		y2_inds = [1:y2];
% 	else
% 		y2_inds = [1+(y2*.5 - y1*.5) : (y2*.5 + y1*.5)];
% 		y1_inds = [1:y1];
% 	end
% 	% compute sse
% 	RDM(RDM_ind) = sum(sum((F{img}(x1_inds, y1_inds) - F{img2}(x2_inds, y2_inds)).^2)) / (min(x1,x2) * min(y1,y2));
% elseif method == 2 % sift
% 	RDM(RDM_ind) = kldiv([1:cluster_size], N_t(img,:), N_t(img2,:)) + ...
%            kldiv([1:cluster_size], N_t(img2,:), N_t(img,:)); % sum of comparision of A to B and of B to A
% elseif method == 3 % jarrett model
% 	%%%%%%%%
% 	% kldiv
% 	%%%%%%%%
% 	for k=1:n_filters
% 		RDM(RDM_ind) = kldiv([-2:0.1:2],F{img}{k},F{img2}{k}) + kldiv([-2:0.1:2],F{img2}{k},F{img}{k});
%     end
% elseif method == 4 % geoblur
% 	geo_blur
% elseif method == 5 % gist
% 	RDM(RDM_ind) = kldiv([1:size(F{img},1)]', F{img}, F{img2}) + kldiv([1:size(F{img},1)]', F{img2}, F{img});
% elseif method == 6 % hmax
% 	%keyboard
% 	RDM(RDM_ind) = corr(F{img}',F{img2}');%,'type','Spearman');
% elseif method == 8 % gabor filterbank
%         RDM(RDM_ind)=sqrt(sum((F{img}-F{img2}).^2));  % Euclidean distance
% end


%+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
%              NEW VERSION WITH ONLY 1 - PEARSON CORRELATION
%+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=

if method == 1 % pixel
    [x1 y1] = size(F{img});
    [x2 y2] = size(F{img2});
    % xi_inds, yi_inds are vectors to be used for each image.
    % They contain indexes for each pixel at each pass.
    if x1 >= x2
        x1_inds = [1+(x1*.5 - x2*.5) : (x1*.5 + y2*.5)];
        x2_inds = [1:x2];
    else
        x2_inds = [1+(x2*.5 - x1*.5) : (x2*.5 + x1*.5)];
        x1_inds = [1:x1];
    end

    if y1 >= x2
        y1_inds = [1+(y1*.5 - y2*.5) : (y1*.5 + y2*.5)];
        y2_inds = [1:y2];
    else
        y2_inds = [1+(y2*.5 - y1*.5) : (y2*.5 + y1*.5)];
        y1_inds = [1:y1];
    end
    % compute 1- Spearman correlation
    Fv1 = reshape(F{img},[],1);
    Fv2 = reshape(F{img2},[],1);
    RDM(RDM_ind)= 1 - abs(corr(Fv1,Fv2,'Type','Spearman'));
elseif method == 2 % sift
    RDM(RDM_ind) = kldiv([1:cluster_size], N_t(img,:), N_t(img2,:)) + ...
        kldiv([1:cluster_size], N_t(img2,:), N_t(img,:)); % sum of comparision of A to B and of B to A
elseif method == 3 % jarrett model
    %%%%%%%%
    % kldiv
    %%%%%%%%
    for k=1:n_filters
        RDM(RDM_ind) = kldiv([-2:0.1:2],F{img}{k},F{img2}{k}) + kldiv([-2:0.1:2],F{img2}{k},F{img}{k});
    end
elseif method == 4 % geoblur
    geo_blur
elseif method == 5 % gist
    RDM(RDM_ind)= 1 - abs(corr(F{img},F{img2},'Type','Spearman'));
elseif method == 6 % hmax
    RDM(RDM_ind)= 1 - abs(corr(F{img}',F{img2}','Type','Spearman'));
elseif method == 8 % gabor filterbank
    RDM(RDM_ind)= 1 - abs(corr(F{img}',F{img2}','Type','Spearman'));
elseif method >= 9 % CNN(low,mid,high)
    RDM(RDM_ind)= 1 - abs(corr(F{img},F{img2},'Type','Spearman'));
end