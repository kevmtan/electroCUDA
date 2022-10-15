function [C,tw,m]=nt_cov_lags(x,y,shifts,demeanflag)
%[C,tw,m]=nt_cov_lags(x,y,shifts,nodemeanflag) - covariance of [x,y] with lags
%
%  C: covariance matrix (3D if length(lags)>1)
%  tw: total weight
%  m: number of columns in x
%  
%  x,y: data matrices
%  shifts: positive shift means y is delayed relative to x
%  demeanflag: if true remove means [default: 1]
%
%  x and y can be time X channels or time X channels X trials.  They can
%  also be cell arrays of time X channels matrices.
%
% See also nt_relshift.
%
%  NoiseTools

if nargin<2; error('!'); end
if nargin<3 || isempty(shifts); shifts=[0]; end
if nargin<4 || isempty(demeanflag); demeanflag=1; end

if isnumeric(x)
    
    % x and y are matrices
    if size(y,1)~=size(x,1); error('!'); end
    if size(y,3)~=size(x,3); error('!'); end
    n=size(x,2)+size(y,2);
    C=zeros(n,n,length(shifts));
    for iPage=1:size(x,3)
        for iLag=1:length(shifts)
            [xx,yy]=nt_relshift(x(:,:,iPage),y(:,:,iPage),shifts(iLag));
            if ~numel(xx); error('xx empty after shifting'); end
            if ~numel(yy); error('yy empty after shifting'); end
            if demeanflag
                xx=nt_demean(xx); yy=nt_demean(yy);
            end
            C(:,:,iLag)=C(:,:,iLag) +[xx,yy]'*[xx,yy];
        end
    end    
    m=size(x,2);
    tw=size(x,1)*size(x,3);
    
else
    
    if isnumeric(y); error('!'); end
    
    % x and y are cell arrays
    n=size(x{1},2)+size(y{1},2);
    C=zeros(n,n,length(shifts));
    tw=0;
    for iCell=1:length(x);
         %disp(iCell)
         C=C+nt_cov_lags(x{iCell},y{iCell},shifts);
         tw=tw+size(x{iCell},1);
    end
    m=size(x{1},2);
end

