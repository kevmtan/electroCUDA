function [x,w] = ec_detrend(x,w,order,thr,nItr,winSz)
%% Robust detrending - wrapper for GPU processing (CUDA source code)
%
% INPUTS:
%    see 'input validation' section below
% OUTPUTS:
%    y = detrended data
%    w = updated weights
%    r = basis matrix used
%
% This code was adapted from NoiseTools (audition.ens.fr/adc/NoiseTools)
%
% Modified by: Kevin Tan, 2022 (kevmtan.github.io)
%    - Added GPU support
%    - Replaced bsxfun with implicit expansion operators (much faster)
%    - Miscellaneous compute & readability enhancements

%% Main
coder.gpu.kernelfun; % trigger CUDA kernel generation
if order<1; order=ones(1,"like",order); end
if thr<1; thr=ones(1,"like",thr); end
if nItr<1; nItr=ones(1,"like",nItr); end

% Detrend per channel
nChs = size(x,2);
for ch = 1:nChs
    [x(:,ch),w(:,ch)] = detrendCh_lfn(x(:,ch),w(:,ch),order,thr,nItr,winSz);
end

% % Run detrend
% if ~nnz(winSz)
%     % Standard detrending (trend fit to entire data)
%     [x,w] = detrend_lfn(x,w,order,thr,nItr);
% else
%     % Overlapping window detrending
%     [x,w] = detrendWin_lfn(x,w,order,thr,nItr,winSz);
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [x,w] = detrendCh_lfn(x,w,order,thr,nItr,winSz)
x=squeeze(x); w=squeeze(w);
if ~nnz(w); w(:)=1; end

% Run detrend
if ~nnz(winSz)
    % Standard detrending (trend fit to entire data)
    [x,w] = detrend_lfn(x,w,order,thr,nItr);
else
    % Overlapping window detrending
    [x,w] = detrendWin_lfn(x,w,order,thr,nItr,winSz);
end



%% Standard detrending (trend fit to entire data)
function [x,w] = detrend_lfn(x,w,order,thr,nItr)
% The data are fit to the basis using weighted least squares. The weight is
% updated by setting samples for which the residual is greater than 'thresh'
% times its std to zero, and the fit is repeated at most 'niter'-1 times.
%
% The choice of order (and basis) determines what complexity of the trend
% that can be removed.  It may be useful to first detrend with a low order
% to avoid fitting outliers, and then increase the order.
%
% The tricky bit is to ensure that weighted means are removed before
% calculating the regression (see nt_regw)

% Get regressors from basis function
nFrames = height(x);
r = coder.nullcopy(zeros(nFrames,order,'like',x));
lin = linspace(-1,1,nFrames);
for k=1:order
    r(:,k) = lin.^k;
end

% Remove trends
z = coder.nullcopy(zeros(size(x),'like',x));
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
function [y,w] = detrendWin_lfn(x,w,order,thr,nItr,winSz)
dims = size(x);
y = coder.nullcopy(zeros(size(x),'like',x));

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
        yy = detrend_lfn(x(start:stop,:),w(start:stop,:),order,thr,1);

        % triangular weighting
        if start==1
            b = [ones(1,wsize2/2,'like',yy)*wsize2/2, wsize2/2:-1:1]';
        elseif stop==dims(1)
            b = [1:wsize2/2, ones(1,wsize2/2,'like',yy)*wsize2/2]';
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

% discard dimensions of r with eigenvalue lower than this
thrPCA = 1e-7; %zeros(1,1,class(x)); 

% save weighted mean
mn = x - demean_lfn(x,w);

% Fit weighted regression
x = demean_lfn(x,w).* w;
r = demean_lfn(r,w); % remove channel-specific-weighted mean from regressor
rr = r.*w;
[V,D] = eig(rr'*rr);
V = real(V);
D = diag(real(D));
V = V(:,D/max(D)>thrPCA); % discard weak dims
rr = rr*V;
b = (x'*rr) / (rr'*rr);
z = r*(V*b') + mn;



%% Demean
function [x,mn] = demean_lfn(x,w)

mn = sum(x.*w,1) ./ (sum(w,1)+eps);
x = x - mn;
