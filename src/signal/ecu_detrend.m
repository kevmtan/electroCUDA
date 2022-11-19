function [x,w] = ecu_detrend(x,order,thresh,niter,wsize,w)
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

%% Input validation
arguments
    x double                       % Raw data
    order double = 10              % Polynomial order (default=10)
    thresh double = 3              % Outlier threshold (default=3)
    niter double = 3               % Number of iterations (default=3)
    wsize double = 0               % Overlapping window size (default=0, fit to entire timecourse)
    w logical = false              % Pre-calculated weights
    %basis {istext} = 'polynomials' % Basis function
    %doubleIn logical = false       % Compute in double-precision
    %singleOut logical = true       % Output in single-precision
end
% feature('SetPrecision', 24); % default to single precision in future

% Generate CUDA kernel
coder.gpu.kernelfun;

% Preallocate
nChs = size(x,2);
if ~isany(w)
    w = coder.nullcopy(true(size(x)));
elseif size(w)~=size(x)
    error("ecu_detrend: input weights 'w' must be same size as input data 'x' (GPU preallocation issues)");
end

%% Call computational functions - parfor loop across channels
for ch = 1:nChs
    [x(:,ch),w(:,ch)] = ec_detrendCompute(x(:,ch),order,thresh,niter,wsize,w(:,ch)); %,doubleIn,singleOut);
end