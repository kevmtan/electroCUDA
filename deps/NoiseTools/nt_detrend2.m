function [y,w,r]=nt_detrend2(x,varargin)
%[y,w,r]=nt_detrend2(x,varargin) - robustly remove trend, 
% 
% Same as nt_detrend, but for 3D data (samples X channels X trials) the same
% trend is removed from all trials. 
%


if iscell(x)
    error('not implemented'); 
end
if nargout>1;
    error('single output only');
end

xx=mean(x,3);
yy=nt_detrend(xx,varargin{:});
trend=xx-yy;
y=bsxfun(@plus,x,-trend);

