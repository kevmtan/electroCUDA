function [x,mn] = KT_demean(x,w)
%[y,mn]=nt_demean(x,w) - remove weighted mean over cols
% 
%  w is optional
%
%  if w is a vector with fewer samples than size(x,1), it is interpreted as
%  a vector of indices to be set to 1, the others being set to 0.
%
% NoiseTools

if nargin<2; w=[]; end
if nargin<1; error('!');end
[m,n,p] = size(x);

if iscell(x)
    mn = cell(size(x));
    if ~isempty(w); error('!'); end % not implemented
    for iCell=1:numel(x)
        [x{iCell},mn{iCell}] = KT_demean(x{iCell}); % ! behaves like nt_demean2
    end
    return;
end

if ~isempty(w) && numel(w)<m
    w=w(:);
    % interpret w as array of indices to set to 1
    if min(w)<1 || max(w)>m
        error('w interpreted as indices but values are out of range');
    end
    ww = zeros(m,1);
    ww(w) = 1;
    w = ww;
end

if size(w,3)~=p
    if size(w,3)==1 && p~=1
        w = repmat(w,[1,1,p]);
    else
        error('W should have same npages as X, or else 1');
    end
end

if p>1; x = KT_unfold(x); end

if isempty(w)
    mn = mean(double(x),1);
    x = nt_vecadd(x,-mn);
else
    if p>1; w = KT_unfold(w); end
    if size(w,1)~=size(x,1); error('X and W should have same nrows'); end    
    if size(w,2)==1
        mn = sum(nt_vecmult(double(x),w),1) ./ (sum(w,1)+eps);
    elseif size(w,2)==n
        mn = sum(x.*w) ./ (sum(w,1)+eps);
    else
        error('W should have same ncols as X, or else 1');
    end
    %y=bsxfun(@minus,x,mn);
    x = nt_vecadd(x,-mn);    
end

if p>1; x = KT_fold(x,m); end

