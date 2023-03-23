function [Fc] = CNN(net,layer,imgPass)
% function [Fc] = CNN()
% This function runs a specified CNN and computes 
% feature vectors for each passed image from its representation at
% the specified layer
% Inputs:
% net: The specified CNN.
% layer: The specified layer of the CNN
% imgPass: the image for which the net will compute a representation.

% Author: Kegan Landfair - July 16, 2015


% load and preprocess an image
im_ = single(imgPass) ; % note: 255 range
im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
im_ = im_ - net.normalization.averageImage ;

% run the CNN
res = vl_simplenn(net, im_) ;

% Obtain representation of the image at layer
Fc = res(layer).x;

% Make Fc a vector.
Fc = reshape(Fc,[],1);

end
    