function x=fold(x,N)
%y=fold(x,epochsize) - fold 2D to 3D 
%
%  y: 3D matrix of (time * channel * trial)
%
%  x: 2D matrix of concatentated data (time * channel)
%  epochsize: number of samples in each trial
%
% NoiseTools

nt_greetings;

x=nt_unfold(x); % in case it was already folded

if ~isempty(x)
    nepochs=size(x,1)/N;
    if nepochs~=round(nepochs)
        warning('nsamples not multiple of epoch size, truncating...');
        nepochs=floor(nepochs);
        x=x(1:N*nepochs,:);
    end
    if nepochs>1
        x=permute(reshape(x,[N, size(x,1)/N, size(x,2)]), [1 3 2]);
    else
        x=x;
    end
end