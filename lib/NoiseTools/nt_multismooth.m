function z=nt_multismooth(x,smooth,alignment,diff_flag)
%z=nt_multismooth(x,smooth,alignment,diff_flag) - apply multiple smoothing kernels
%
%   y: result (time * channels * nsmooth)
%
%   x: matrix to smooth
%   smooth: vector of smoothing kernel sizes
%   alignment: 0: left [default], 1: center
%   diff_flag: if true, return 1sr colum & between-column differences
% 
% X is smoothed column by column (all smoothed versions of 1st column, then all
% of second column, etc).
% 
% X may be 1D, 2D or 3D. See also nt_multishift.
%
% NoiseTools
nt_greetings;

if nargin<4 || isempty(diff_flag); diff_flag=0; end
if nargin<3 || isempty(alignment); alignment=0; end
if nargin<2; error('!'); end
if min(smooth)<1; error('smooth must be positive'); end

if iscell(x)
    for iCell=1:length(x);
        z{iCell}=nt_multismooth(x{iCell},smooth,alignment);
    end
    return
end

if size(x,1)<max(smooth); error('smoothing kernel size should be no larger than nrows'); end
if min(smooth)<0; error('smoothing kernel size should be nonnegative'); end
smooth=smooth(:)';
nsmooth=numel(smooth);

% array of shift indices
[m,n,o]=size(x);
z=zeros(m,n*nsmooth,o);

for iPage=1:o
    zz=zeros(m,n,nsmooth);
    for iSmooth=1:nsmooth
        if alignment==0; nodelayflag=0; elseif alignment==1; nodelayflag=1; else; error('!!'); end
        zz(:,:,iSmooth)=nt_smooth(x(:,:,iPage),smooth(iSmooth),[],nodelayflag);
    end
    if diff_flag
        zz=cat(3,zz(:,:,1),diff(zz,[],3));
    end
    zz=permute(zz,[1,3,2]); 
    zz=reshape(zz,m,n*nsmooth);
    z(:,:,iPage)=zz;
end

if alignment==1;
    warning(['padding (samples): ',num2str(round(max(smooth)/2))]);
    z=z(1:end-round(max(smooth)/2),:,:);
    z=[zeros(round(max(smooth)/4),size(z,2)); z ; zeros(round(max(smooth)/2)-round(max(smooth)/4),size(z,2))];
end
    

