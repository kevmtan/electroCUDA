function [x,w,r] = ec_detrend(x,order,thresh,niter,wsize,w,basis)
%% Robust detrending - wrapper for CPU processing
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

%% Input validation
arguments
    x {mustBeFloat}                % Raw data
    order {isnumeric} = 10         % Polynomial order (default=10)
    thresh {isnumeric} = 3         % Outlier threshold (default=3)
    niter {isnumeric} = 3          % Number of iterations (default=3)
    wsize {isnumeric} = []         % Overlapping window size (default=[])
    w logical = []                 % Pre-calculated weights
    basis {istext} = 'polynomials' % Basis function
end
x = squeeze(x);
dimsOg = size(x);
if isany(w); w = squeeze(w); else; w = true(dimsOg); end

% Concatenate into 2D if data has 3 or more dims
if numel(dimsOg)>=3
    x = x(:,:); 
    w = w(:,:);
end

% Column-major array layout has best performance (columns = frames or timepoints)
if length(x)<width(x); x = x'; end
if length(w)<width(w); w = w'; end
dims = size(x);
nChs = dims(2);
r = cell(nChs,1);

% Expand pre-computed weights if only 1D
if size(w,2)==1; w = repmat(w,1,dims(2)); end
try parpool('threads'); catch;end

%% Call computational functions - parfor loop across channels 
parfor ch = 1:nChs
    [x(:,ch),w(:,ch),r{ch}] = ec_detrendCompute(x(:,ch),order,thresh,niter,wsize,w(:,ch),basis);
end

% Revert to original dimensions if 3 or more dims
if numel(dimsOg)>=3
    x = reshape(x,dimsOg);
    w = reshape(w,dimsOg);
end

