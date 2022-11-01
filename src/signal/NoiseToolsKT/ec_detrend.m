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
    y = KT_regw(x,r,w);

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