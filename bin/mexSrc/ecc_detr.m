function [x,w,olPct] = ecc_detr(x,w,ord,thr,itr)
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

% Input validation
arguments
    x (:,:){mustBeFloat}
    w (:,:){mustBeFloat}
    ord (1,:){mustBeFloat}
    thr (1,:){mustBeFloat}
    itr (1,:){mustBeFloat}
end

%% Main
coder.gpu.kernelfun; % trigger CUDA kernel generation
nFrames = size(x,1);
nChs = size(x,2);
reps = numel(ord);
olPct = coder.nullcopy(nan(nChs,reps));

% Detrend by polynomial order
for ii = 1:reps
    iOrd=ord(ii); iThr=thr(ii); iItr=itr(ii); % copy
    regs = regsFromBasis_lfn(nFrames,iOrd); % Get regressors from basis function

    % Detrend per chan
    for ch = 1:nChs
        [x(:,ch),w(:,ch)] = detrend_lfn(x(:,ch),w(:,ch),regs,iThr,iItr); % Detrend
        olPct(ch,ii) = sum(~w(:,ch)); % Outlier percentages
    end
end

% Sum outliers across chans
olPct = sum(olPct,1,"omitnan");




%%%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Get regressors from polynomial function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function regs = regsFromBasis_lfn(nFrames,iOrd)
regs = coder.nullcopy(zeros(nFrames,iOrd,'like',iOrd));
lin = linspace(-1,1,nFrames);
for k = 1:iOrd
    regs(:,k) = lin.^k;
end



%% Standard detrending (trend fit to entire data) %%%%%%%%%%%%%%%%%%%%%%%%%
function [x,w] = detrend_lfn(x,w,r,iThr,iItr)
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

% Detrend per polynomial order
z = coder.nullcopy(x);
for ii = 1:iItr
    % Weighted regression
    z = regw_lfn(x,w,r); 

    % Find outliers 
    d = (x-z).*w;
    thrItr = iThr*std(d);
    w(abs(d)>thrItr) = 0; % update weights
end

% Remove trends
x = x-z;



%% Weighted Regression %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z = regw_lfn(x,w,r)
%  b: regression matrix (apply to r to approximate x)
%  z: regression (r*b)

% Discard dimensions of r with eigenvalue lower than this
thrPCA = 1e-7; %zeros(1,1,class(x)); 

% Save weighted mean
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



%% Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,mn] = demean_lfn(x,w)

mn = sum(x.*w,1) ./ (sum(w,1)+eps);
x = x - mn;
