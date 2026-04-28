function [x2d,featureSize] = ec_reshape2D(x,dim)
%EC_RESHAPE2D Reshape array to [observations x features].
%   [X2D,FEATURESIZE] = EC_RESHAPE2D(X,DIM) moves DIM to the first
%   dimension, flattens remaining dimensions into features, and returns
%   the original feature shape in FEATURESIZE for later restoration.

sz = size(x);
if numel(sz) < dim
    sz(end+1:dim) = 1;
    x = reshape(x,sz);
end
permOrder = [dim,1:dim-1,dim+1:ndims(x)];
xPerm = permute(x,permOrder);
featureSize = size(xPerm);
featureSize = featureSize(2:end);
x2d = reshape(xPerm,size(xPerm,1),[]);
end
