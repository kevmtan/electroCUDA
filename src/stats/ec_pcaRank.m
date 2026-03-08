function [xRank,x,w] = ec_pcaRank(x,a)
% Denoise with robust PCA, dimensionality reduction with standard PCA.
% Reduces dimensionality to matrix rank if width(x) or a.nComps exceeds
% rank
%
% Part of the electroCUDA package: https://github.com/kevmtan/electroCUDA

%% Input validation
arguments
    x (:,:){mustBeFloat}            % Input matrix: x(observations,features)
    a.nComps (1,1) double = 0       % Number of components [0=skip]
    a.robust (1,1) logical = false  % Use robust PCA
    a.double (1,1) logical = false  % Convert to double
    a.exact (1,1) logical = false   % Use exact rank
end


%% Prep

% Convert to double
if a.double
    x = double(x);
end

% Use exact rank if GPU array & single/half (bad results otherwise)
if isgpuarray(x) && (isa(x,"single") || isa(x,"half"))
    a.exact = true;
end


%% Robust PCA (denoising)
if a.robust
    x = ec_pcaRobust(x);
end


%% Matrix rank
xRank = ec_rank(x,exact=a.exact);


%% Standard PCA (dimensionality reduction)
if a.nComps
    % Number of components not above data rank
    if a.nComps > xRank
        a.nComps = xRank;
    end

    % Run standard PCA for dimensionality reduction
    if a.nComps < width(x)
        [w,x] = pca(x,NumComponents=a.nComps);
    end
end
