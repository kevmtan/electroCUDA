function [y,w,r] = ec_detrend(x,order,w,basis,thresh,niter,wsize)
%[y,w,r]=nt_detrend(x,order,w,basis,thresh,niter,wsize) - robustly remove trend
%
%  y: detrended data
%  w: updated weights
%  r: basis matrix used
%
%  x: raw data
%  order: order of polynomial or number of sin/cosine pairs
%  w0: weights
%  basis: 'polynomials' [default] or 'sinusoids', or user-provided matrix
%  thresh: threshold for outliers [default: 3 sd]
%  niter: number of iterations [default: 3]
%  wsize: window size for local detrending [default: all]
%
% This NEW (circa Oct 2019) version of detrend allows detrending to be
% applied to smaller overlapping windows, which are then stitched together
% using overlap-add. This is not described in the paper.

%% arguments
if nargin<2; error('!'); end
if nargin<3; w=[]; end
if nargin<4||isempty(basis); basis='polynomials'; end
if nargin<5||isempty(thresh); thresh=3; end
if nargin<6||isempty(niter); niter=3; end
if nargin<7; wsize=[]; end

if iscell(x)
    if ~isempty(w); error('not implemented'); end
    y=cell(numel(x),1); w=y; r=y;
    for iTrial=1:numel(x)
        [y{iTrial},w{iTrial},r{iTrial}] = ec_detrend(x{iTrial},order,w,basis,thresh,niter,wsize);
    end
    return
end

dims = size(x);
% w = w;
% if ~isempty(w)
%     w = w(:);
%     if numel(w)<dims(1)
%         % assume that w contains indices, set them to 1
%         idx=w;
%         w = zeros(dims(1),1);
%         w(idx) = 1;
%     end
% end

if isempty(wsize) || ~any(wsize)
    % standard detrending (trend fit to entire data)
    [y,w,r] = ec_detrendHelper(x,order,w,basis,thresh,niter);
else
    wsize = 2*floor(wsize/2);

    % do some sanity checks because many parameters
    if numel(order)>1; error('!'); end
    if ~isempty(w) && ~(size(w,1)==dims(1)) ; disp(size(w)); error('!'); end
    if ~(isempty(basis) || isstring(basis) || ~(isnumeric(basis)&&size(basis,1)==dims(1))); error('!'); end
    if thresh==0; error('thresh=0 is not what you want...'); end % common mistake
    if numel(thresh)>1; error('!'); end
    if numel(niter)>1; error('!'); end
    if numel(dims)>=3
        x = x(:,:); % concatenates dims >= 2
        w = w(:,:);
        dims = size(x);
    end
    if isempty(w); w = ones(size(x)); end
    if size(w,2)==1; w = repmat(w,1,dims(2)); end

    % 1) divide into windows, 2) detrend each, 3) stitch together, 4) estimate w
    for iIter = 1:niter
        y = zeros(size(x));
        trend = zeros(size(x));
        a = zeros(dims(1),1);
        offset = 0;
        while true
            start = offset+1;
            stop = min(dims(1),offset+wsize);

            % if not enough valid samples grow window:
            counter = 5;
            while any(sum(min(w(start:stop),2))) < wsize
                if counter <= 0 ; break; end
                start = max(1,start-wsize/2);
                stop = min(dims(1),stop+wsize/2);
                counter = counter-1;
            end
            if rem(stop-start+1,2)==1; stop = stop-1; end
            wsize2 = stop-start+1;

            % detrend this window
            NITER = 1;
            yy = ec_detrendHelper(x(start:stop,:),order,w(start:stop,:),basis,thresh,NITER);

            % triangular weighting
            if start==1
                b = [ones(1,wsize2/2)*wsize2/2, wsize2/2:-1:1]';
            elseif stop==dims(1)
                b = [1:wsize2/2, ones(1,wsize2/2)*wsize2/2]';
            else
                b = [1:wsize2/2, wsize2/2:-1:1]';
            end

            % overlap-add to output
            y(start:stop,:) = y(start:stop,:) + (yy.*b); %bsxfun(@times,yy,b);
            trend(start:stop,:) = trend(start:stop,:) + (x(start:stop,:)-yy).*b;
            %bsxfun(@times,x(start:stop,:)-yy,b);

            a(start:stop,1) = a(start:stop)+b;

            offset = offset+wsize/2;
            if offset > dims(1)-wsize/2; break; end
        end

        if stop<dims(1) % last sample can be missed
            y(end,:) = y(end-1,:);
            a(end,:) = a(end-1,:);
        end
        y = bsxfun(@times,y,1./a);
        y(isnan(y)) = 0;
        trend = trend.*(1./a); %bsxfun(@times,trend,1./a);
        trend(isnan(trend)) = 0;

        % find outliers
        d = x-trend;
        if ~isempty(w); d = d.*w; end %bsxfun(@times,d,w); end
        ww = ones(size(x));
        ww(abs(d) > thresh*repmat(std(d),dims(1),1)) = 0;

        % update weights
        if isempty(w)
            w = ww;
        else
            w = min(w,ww);
        end
    end % for iIter...
    %w=[];r=[]; % not informative

end % if isempty(wsize)...

if ~nargout
    % don't return, just plot
    subplot 411; plot(x); title('raw'); xlim([1,dims(1)])
    subplot 412; plot(y); title('detrended'); xlim([1,dims(1)])
    subplot 413; plot(x-y); title('trend'); xlim([1,dims(1)])
    subplot 414; nt_imagescc(w'); title('weight');
    clear y w r
end
end

%% Original version of detrend (no windows) is called by new version (windows)
function [y,w,r] = ec_detrendHelper(x,order,w,basis,thresh,niter)
%[y,w,r]=nt_detrend(x,order,w,basis,thresh,niter) - robustly remove trend
%
%  y: detrended data
%  w: updated weights
%  r: basis matrix used
%
%  x: raw data
%  order: order of polynomial or number of sin/cosine pairs
%  w: weights
%  basis: 'polynomials' [default] or 'sinusoids', or user-provided matrix
%  thresh: threshold for outliers [default: 3 sd]
%  niter: number of iterations [default: 3]
%
% Noise tools
% See nt_regw().
%
% The data are fit to the basis using weighted least squares. The weight is
% updated by setting samples for which the residual is greater than 'thresh'
% times its std to zero, and the fit is repeated at most 'niter'-1 times.
%
% The choice of order (and basis) determines what complexity of the trend
% that can be removed.  It may be useful to first detrend with a low order
% to avoid fitting outliers, and then increase the order.
%
% Examples:
% Fit linear trend, ignoring samples > 3*sd from it, and remove:
%   y=nt_detrend(x,1);
% Fit/remove polynomial order=5 with initial weighting w, threshold = 4*sd:
%   y=nt_detrend(x,5,w,[],4);
% Fit/remove linear then 3rd order polynomial:
%   [y,w]=nt_detrend(x,1);
%   [yy,ww]=nt_detrend(y,3);
%

% arguments
if nargin<2; error('!'); end
if nargin<3; w=[]; end
if nargin<4||isempty(basis); basis='polynomials'; end
if nargin<5||isempty(thresh); thresh=3; end
if nargin<6||isempty(niter); niter=3; end

if thresh==0; error('thresh=0 is not what you want...'); end % common mistake

dimsOg = size(x);
if numel(dimsOg)>=3
    x = x(:,:); % concatenates dims >= 2
    w = w(:,:);
end
dims = size(x);

if size(w,2)==1; w = repmat(w,1,dims(2)); end

%% regressors
if isnumeric(basis)
    r=basis;
else
    switch basis
        case 'polynomials'
            r=zeros(dims(1),numel(order));
            lin=linspace(-1,1,dims(1));
            for k=1:order
                r(:,k)=lin.^k;
            end
        case 'sinusoids'
            r=zeros(dims(1),numel(order)*2);
            lin=linspace(-1,1,dims(1));
            for k=1:order
                r(:,2*k-1)=sin(2*pi*k*lin/2);
                r(:,2*k)=cos(2*pi*k*lin/2);
            end
        otherwise
            error('!');
    end
end

%% Remove trends
% The tricky bit is to ensure that weighted means are removed before
% calculating the regression (see nt_regw).
for iIter=1:niter
    % weighted regression on basis
    y = regw_lfn(x,r,w);

    % find outliers
    d = x-y;
    if ~isempty(w); d = d.*w; end
    ww = ones(dims);
    ww(abs(d) > thresh * repmat(std(d),dims(1),1)) = 0;

    % update weights
    if isempty(w)
        w = ww;
    else
        w = min(w,ww);
    end
end
y = x-y;
y = reshape(y,dimsOg);
w = reshape(w,dimsOg);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% regw
function [z,b] = regw_lfn(y,x,w)
%[b,z]=nt_regw(y,x,w) - weighted regression
%
%  b: regression matrix (apply to x to approximate y)
%  z: regression (x*b)
%
%  y: data
%  x: regressor
%  w: weight to apply to y
%
%  w is either a matrix of same size as y, or a column vector to be applied
%  to each column of y
%
% NoiseTools

thr_PCA = 0.0000001; % discard dimensions of x with eigenvalue lower than this

if nargin<3; w = []; end
if nargin<2; error('!'); end

%% check/fix sizes
m = size(y,1);
x = unfold_lfn(x);
y = unfold_lfn(y);
if size(x,1) ~= size(y,1)
    disp(size(x)); disp(size(y)); error('!');
end

%% save weighted mean
mn = y - demean_lfn(y,w);


%% Fit basis function
if isempty(w)
    % simple regression
    xx = demean_lfn(x);
    yy = demean_lfn(y);
    [V,D] = eig(xx'*xx);
    V = real(V);
    D = real(D);
    topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
    xxx = xx*topcs;
    b = ((yy'*xxx) / (xxx'*xxx))';
    z = demean_lfn(x,w)*topcs*b;
    z = z + mn;
else
    % weighted regression
    if size(w,1)~=size(x,1); error('!'); end
    if size(w,2)==1
        % same weight for all channels
        if sum(w(:))==0
            error('weights all zero');
        end
        yy = demean_lfn(y,w).*repmat(w,1,size(y,2));
        xx = demean_lfn(x,w).*repmat(w,1,size(x,2));
        [V,D] = eig(xx'*xx);
        V = real(V);
        D = real(D);
        D = diag(D);
        topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
        xxx = xx*topcs;
        b = ((yy'*xxx) / (xxx'*xxx))';
        z = demean_lfn(x,w)*topcs*b;
        z = z + mn;
    else
        % each channel has own weight
        if size(w,2) ~= size(y,2); error('!'); end
        z = zeros(size(y));
        b = zeros(flip(size(y)));
        for ch = 1:size(y,2)
            if sum(w(:,ch))==0; warning("All weights zero: ch"+ch); continue; end
            yy = demean_lfn(y(:,ch),w(:,ch)) .* w(:,ch);
            x = demean_lfn(x,w(:,ch)); % remove channel-specific-weighted mean from regressor
            xx = x .* repmat(w(:,ch),1,size(x,2));
            [V,D] = eig(xx'*xx);
            V = real(V);
            D = real(diag(D));
            topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
            xxx = xx*topcs;
            b(ch,1:size(topcs,2)) = (yy'*xxx) / (xxx'*xxx);
            z(:,ch) = x*(topcs*b(ch,1:size(topcs,2))') + mn(:,ch);
        end

    end
end

z = fold_lfn(z,m);
end

%% demean
function [x,mn] = demean_lfn(x,w)
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
        [x{iCell},mn{iCell}] = demean_lfn(x{iCell}); % ! behaves like nt_demean2
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

if p>1; x = unfold_lfn(x); end

if isempty(w)
    mn = mean(double(x),1);
    x = x - mn; %vecadd_lfn(x,-mn);
else
    if p>1; w = unfold_lfn(w); end
    if size(w,1)~=size(x,1); error('X and W should have same nrows'); end
    if size(w,2)==1
        mn = sum(double(x).*w,1) ./ (sum(w,1)+eps); %sum(vecmult_lfn(double(x),w),1) ./ (sum(w,1)+eps);
    elseif size(w,2)==n
        mn = sum(x.*w) ./ (sum(w,1)+eps);
    else
        error('W should have same ncols as X, or else 1');
    end
    x = x - mn; %x = vecadd_lfn(x,-mn);
end

if p>1; x = fold_lfn(x,m); end
end

%% Fold
function x = fold_lfn(x,N)
%y=fold(x,epochsize) - fold 2D to 3D
%
%  y: 3D matrix of (time * channel * trial)
%
%  x: 2D matrix of concatentated data (time * channel)
%  epochsize: number of samples in each trial
%
% NoiseTools

x = unfold_lfn(x); % in case it was already folded
if ~isempty(x)
    nepochs = size(x,1)/N;
    if nepochs~=round(nepochs)
        warning('nsamples not multiple of epoch size, truncating...');
        nepochs = floor(nepochs);
        x = x(1:N*nepochs,:);
    end
    if nepochs>1
        x = permute(reshape(x,[N, size(x,1)/N, size(x,2)]), [1 3 2]);
    end
end
end

%% Unfold
function x = unfold_lfn(x)
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
end

%% Vector Add
% function x = vecadd_lfn(x,v)
% %y=nt_vecadd(x,v) - add vector to all rows or columns of matrix
% %
% % See vecmult, bsxfun
% %
% % NoiseTools
% 
% [m,~,~]=size(x);
% x=unfold_lfn(x);
% v=unfold_lfn(v);
% 
% [mm,nn]=size(x);
% if numel(v)==1;
%     x=x+v;
% elseif size(v,1)==1
%     if size(v,2)~=nn; error('V should have same number of columns as X'); end
%     if bsxfun_exists;
%         x=bsxfun(@plus,x,v);
%         %        vecop_core(x, v, 2, 1);  % 1 is the opcode of addition in vecop_core
%     else
%         x=x + repmat(v,mm,1);
%     end
% elseif size(v,2)==1
%     if size(v,1)~=mm; error('V should have same number of rows as X'); end
%     if bsxfun_exists;
%         x=bsxfun(@plus,x,v);
%         %       y=vecop_core(x, v, 1, 1);  % 1 is the opcode of addition in vecop_core
%     else
%         x=x + repmat(v,1,nn);
%     end
% end
% x=nt_fold(x,m);
% end

%% Vector multiplication
% function x = vecmult_lfn(x,v)
% %y=nt_vecmult(x,v) - multiply all rows or columns of matrix by vector
% %
% % See vecadd, bsxfun
% %
% % NoiseTools
% 
% % check once and for all to save time
% persistent bsxfun_exists;
% if isempty(bsxfun_exists); bsxfun_exists=(exist('bsxfun')==5); end
% 
% [m,n,o]=size(x);
% x=nt_unfold(x);
% v=nt_unfold(v);
% 
% [mm,nn]=size(x);
% [mv,nv]=size(v);
% if mv==mm
%     % same number of rows, v should be column vector (or same size as x)
%     if nv==nn
%         x=x.*v;
%     elseif nv==1
%         if bsxfun_exists;
%             x=bsxfun(@times,x,v);
%             %y=vecop_core(x, v, 1, 2);  % 2 is the opcode of multiplication in vecop_core
%         else
%             x=x .* repmat(v,1,nn);
%         end
%     else
%         error('V should be row vector');
%     end
% 
% elseif nv==nn
%     % same number of columns, v should be row vector (or same size as x)
%     if mv==mm
%         x=x.*v;
%     elseif mv==1
%         if bsxfun_exists;
%             x=bsxfun(@times,x,v);
%             %y=vecop_core(x, v, 2, 2);  % 2 is the opcode of multiplication in vecop_core
%         else
%             x=x .* repmat(v,mm,1);
%         end
%     else
%         error('V should be column vector');
%     end
% 
% else
%     error('V and X should have same number of rows or columns');
% end
% x=nt_fold(x,m);
% end