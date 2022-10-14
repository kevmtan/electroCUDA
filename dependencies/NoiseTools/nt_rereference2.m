function [y,mn,mask]=nt_rereference2(x,mask,thresh,factor)
%[y,mn]=nt_rereference2(x,mask,thresh,factor) - robust rereferencing
%
%   y: rereferenced data
%   mn: subtracted reference
%   mask: channel mask
%
%   x: data to rereference (time X channels)
%   mask: channel mask
%   thresh: std threshold to discard channel [default: 3]
%   factor: apply to mean before subtracting [default: 1]
%   
% See also: nt_rereference, nt_detrend, nt_outliers
%
% NoiseTools

if nargin<1; error('!'); end
if nargin<2||isempty(mask); mask=ones(1,size(x,2)); end
if nargin<3||isempty(thresh); thresh=3; end
if nargin<4||isempty(factor); factor=1; end

if size(mask,1)~=1; error('!'); end
if size(mask,2) ~= size(x,2); error('!'); end

y=x;
NITER=5;
for iRepeat=1:NITER
    if ~sum(mask); error('!'); end
    mn=sum(y(:,find(mask)),2)./sum(mask);
    y=bsxfun(@minus,y,mn*factor);
    yy=y(:,find(mask));
    idxBad=std(y)/std(yy(:))>thresh;
    mask(idxBad)=0;
    %disp(mean(mask))
    %figure(1); clf; plot(std(y)/std(yy(:))); pause   
end
disp(['proportion channels used for mean: ', num2str(mean(mask))])



