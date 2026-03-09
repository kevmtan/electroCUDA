function [x,w,xR,xS] = ec_pca(x,a)
% Denoise with robust PCA, dimensionality reduction with standard PCA.
% Reduces dimensionality to matrix rank if width(x) or a.nComps exceeds
% rank
%
% OUPUTS:
%   x = Input matrix after PCA transform
%   w = PCA weights (standard PCA)
%   xR = matrix rank of input data (after robust PCA if performed)
%   xS = sparse noise matrix extracted by robust PCA
%
% Part of the electroCUDA package: https://github.com/kevmtan/electroCUDA

%% Input validation
arguments
    x (:,:){mustBeFloat}                % Input matrix: x(observations,features)
    a.nComps (1,1) double = 0           % Number of components [0=skip|Inf=rank]
    a.rankLim (1,1) logical = false     % Limit num components to matrix rank
    a.robust (1,1) logical = false      % Use robust PCA
    a.exact (1,1) logical = false       % Use exact rank
    a.double (1,1) logical = true       % Convert to double (single/half can be unstable!)
    a.gpu (1,1) logical = isgpuarray(x) % Compute on GPU
end


%% Prep
w = []; % initialize PCA weights

% Convert to double
if a.double
    x = double(x);
end

% Copy to GPU
if a.gpu && ~isgpuarray(x)
    x = gpuArray(x);
end

% Use exact rank if GPU array & single/half (bad results otherwise)
if a.gpu && (isa(x,"single") || isa(x,"half"))
    a.exact = true;
end


%% Robust PCA (denoising)
if a.robust
    [x,xS] = ec_pcaRobust(x);
else
    xS = [];
end


%% Matrix rank
xR = ec_rank(x,exact=a.exact);


%% Standard PCA (dimensionality reduction)
if a.nComps
    % Limit number of components to matrix rank
    if a.rankLim && a.nComps>xR
        a.nComps = xR;
    end

    % Run standard PCA for dimensionality reduction
    if a.nComps < width(x)
        [w,x] = pca(x,NumComponents=a.nComps);
        if o.gpu; w = gather(x); end
    end
end
