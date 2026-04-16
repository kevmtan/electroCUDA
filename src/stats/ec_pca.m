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
    a.robust (1,1) logical = false      % Use robust PCA
    a.exact (1,1) logical = false       % Use exact rank
    a.std string {mustBeMember(a.std,["zscore" "robust" "" []])} = "robust" % Z-score
    a.double (1,1) logical = false      % Convert to double (single/half can be unstable!)
    a.gpu (1,1) logical = isgpuarray(x) % Compute on GPU
    a.gather (1,1) logical = false      % Gather outputs from GPU
end
if isgpuarray(x); a.gpu=true; end


%% Prep

% Use exact rank if GPU array & single/half (bad results otherwise)
if a.gpu && (isa(x,"single") || isa(x,"half")) && ~a.double
    a.exact = true;
end

% Convert to double
if a.double
    x = double(x);
end

% Copy to GPU
if a.gpu && ~isgpuarray(x)
    x = gpuArray(x);
end


%% Standardize predictors
if a.std=="robust"
    x = normalize(x,1,"zscore","robust"); % robust z-score
elseif isany(o.std)
    x = normalize(x,1,o.std); % standard z-score
end


%% Robust PCA (denoising)
if a.robust
    [x,xS] = ec_pcaRobust(x);
else
    xS = [];
end


%% Matrix rank
xR = ec_rank(x(all(~isnan(x),2),:),exact=a.exact);


%% Standard PCA (dimensionality reduction)
if a.nComps
    % Limit number of components to matrix rank
    if a.nComps > xR
        a.nComps = xR;
    end

    % Run standard PCA for dimensionality reduction
    [w,x] = pca(x,NumComponents=a.nComps);
else
    w = [];
end


%% Gather
if a.gpu && a.gather
    x = gather(x);
    w = gather(w);
    xS = gather(xS);
end
