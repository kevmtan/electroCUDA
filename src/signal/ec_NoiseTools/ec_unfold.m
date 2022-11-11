function x = ec_unfold(x)
%y=nt_fold(x) - unfold 3D to 2D 
%
%  y: 2D matrix of concatentated data (time * channel)
%
%  x: 3D matrix of (time * channel * trial)
%
% NoiseTools

if ~isempty(x) && numel(size(x))>=3
    [m,n,p] = size(x);
    if p>1
        x = reshape(permute(x,[1 3 2]),m*p,n);
    elseif p==1
        x = squeeze(x);
    end
end