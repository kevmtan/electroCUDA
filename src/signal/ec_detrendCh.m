function [x,w] = ec_detrendCh(x,w,iThr,iItr,iWin,iOrd,basis)
x=squeeze(x); w=squeeze(w);
if ~nnz(w); w(:)=1; end
nFrames = height(x);

% Get regressors from basis function
if basis=="polynomials"
    r = zeros(nFrames,iOrd,'like',x);
    lin = linspace(-1,1,nFrames);
    for k = iOrd
        r(:,k) = lin.^k;
    end
elseif basis=="sinusoids"
    r = zeros(nFrames,iOrd*2,'like',x);
    lin = linspace(-1,1,nFrames);
    for k = 1:iOrd
        r(:,2*k-1) = sin(2*pi*k*lin/2);
        r(:,2*k) = cos(2*pi*k*lin/2);
    end
else
    error("ec_detrend: basis must be 'polynomials' or 'sinusoids'");
end

% Run detrend
if ~nnz(iWin)
    % Standard detrending (trend fit to entire data)
    [x,w] = detrend_lfn(x,w,r,iThr,iItr,iOrd,basis);
else
    % Overlapping window detrending
    [x,w] = detrendWin_lfn(x,w,iThr,iItr,iWin,iOrd,basis);
end



%% Standard detrending (trend fit to entire data)
function [x,w] = detrend_lfn(x,w,r,thr,nItr,order,basis)
% The data are fit to the basis using weighted least squares. The weight is
% updated by setting samples for which the residual is greater than 'thresh'
% times its std to zero, and the fit is repeated at most 'niter'-1 times.
%
% The choice of order (and basis) determines what complexity of the trend
% that can be removed.  It may be useful to first detrend with a low order
% to avoid fitting outliers, and then increase the order.
%
% The tricky bit is to ensure that weighted means are removed before
% calculating the regression (see nt_regw).

% Get regressors from basis function
if isempty(r)
    nFrames = length(x);
    if basis=="polynomials"
        r = zeros(nFrames,order,'like',x);
        lin = linspace(-1,1,nFrames);
        for k=1:order
            r(:,k) = lin.^k;
        end
    elseif basis=="sinusoids"
        r = zeros(nFrames,order*2,'like',x);
        lin = linspace(-1,1,nFrames);
        for k = 1:order
            r(:,2*k-1) = sin(2*pi*k*lin/2);
            r(:,2*k) = cos(2*pi*k*lin/2);
        end
    end
end

% Remove trends
for ii = 1:nItr
    % Weighted regression on basis
    z = regw_lfn(x,w,r);

    % Find outliers
    d = (x-z).*w;
    thrItr = thr*std(d);
    w(abs(d)>thrItr) = 0; % update weights
end
x = x-z;



%% Detrend across overlapping time windows
function [y,w] = detrendWin_lfn(x,w,thr,nItr,winSz,order,basis)
dims = size(x);
y = zeros(dims,'like',x);

% 1) divide into windows, 2) detrend each, 3) stitch together, 4) estimate w
for iIter = 1:nItr
    trend = zeros(dims,'like',x);
    a = zeros(dims(1),1,'like',x);
    offset = 0;
    while true
        start = offset+1;
        stop = min(dims(1),offset+winSz);

        % if not enough valid samples grow window:
        counter = 5;
        while any(sum(min(w(start:stop),2))) < winSz
            if counter <= 0 ; break; end
            start = max(1,start-winSz/2);
            stop = min(dims(1),stop+winSz/2);
            counter = counter-1;
        end
        if rem(stop-start+1,2)==1; stop = stop-1; end
        wsize2 = stop-start+1;

        % detrend this window
        yy = detrend_lfn(x(start:stop,:),w(start:stop,:),[],thr,1,order,basis);

        % triangular weighting
        if start==1
            b = [ones(1,wsize2/2,'like',x)*wsize2/2, wsize2/2:-1:1]';
        elseif stop==dims(1)
            b = [1:wsize2/2, ones(1,wsize2/2,'like',x)*wsize2/2]';
        else
            b = [1:wsize2/2, wsize2/2:-1:1]';
        end

        % overlap-add to output
        y(start:stop,:) = y(start:stop,:) + (yy.*b); %bsxfun(@times,yy,b);
        trend(start:stop,:) = trend(start:stop,:) + (x(start:stop,:)-yy).*b; %bsxfun(@times,x(start:stop,:)-yy,b);
        a(start:stop,1) = a(start:stop)+b;
        offset = offset+winSz/2;
        if offset > dims(1)-winSz/2; break; end
    end

    if stop<dims(1) % last sample can be missed
        y(end,:) = y(end-1,:);
        a(end,:) = a(end-1,:);
    end
    y = y.*(1./a); %bsxfun(@times,y,1./a);
    y(isnan(y)) = 0;
    trend = trend.*(1./a); %bsxfun(@times,trend,1./a);
    trend(isnan(trend)) = 0;

    % Find outliers
    d = (x-trend).*w;
    thrItr = thr*std(d);
    w(abs(d)>thrItr) = 0; % update weights
end



%% Weighted Regression
function [z,b] = regw_lfn(x,w,r)
%  b: regression matrix (apply to r to approximate x)
%  z: regression (r*b)

%thrPCA = zeros(1,1,class(x));
thrPCA = 1e-7; % discard dimensions of r with eigenvalue lower than this

% save weighted mean
mn = x - demean_lfn(x,w);

% Fit weighted regression
x = demean_lfn(x,w).* w;
r = demean_lfn(r,w); % remove channel-specific-weighted mean from regressor
rr = r.*w;
[V,D] = eig(rr'*rr);
V = real(V);
D = real(diag(D));
V = V(:,D/max(D)>thrPCA); % discard weak dims
rr = rr*V;
b = (x'*rr) / (rr'*rr);
z = r*(V*b') + mn;



%% Demean
function [x,mn] = demean_lfn(x,w)

mn = sum(x.*w,1) ./ (sum(w,1)+eps);
x = x - mn;

