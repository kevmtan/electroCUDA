function [xRank,tol,xEig,xRank1] = ec_rank(x,tol,o)
%% ec_rank - get linear rank of 2D array
%   xRank = number of eigenvalues greater than 'tol'
%   More consistent than built-in Matlab rank() function
%   Solves rank computation issues on on Linux 64-bit
%   Supports gpuArrays

%% Input validation
arguments
    x (:,:){mustBeFloat}            % Input data: x(observations,variables)
    tol (1,1) double = 0            % Rank tolerance (min eigenvalue)[0=auto]
    o.eig (1,1) logical = false     % Eigenvector as 1st output
    o.compare (1,1) logical = false % Compare with Matlab's rank() function
    o.exact (1,1) logical = false   % Determine exact rank tol (slower)
    o.gpu (1,1) logical = false     % Use GPU
    o.double (1,1) logical = false  % Double-precision compute (FP64)
end

%% Prep
if o.gpu; x = gpuArray(x); end % move to GPU
if o.double; x = double(x); end % convert to double

% Calculate rank tolerance if not specified
if ~tol
    if o.exact
        tol = max(size(x) * eps(norm(x)));
    else
        tol = max(size(x) * eps(normest(x)));
    end
end


%% Calculate data rank from covariance eigenvectors (Sven Hoffman)
xEig = eig(cov(x,1,"partialrows"));
xRank = nnz(xEig > tol);


%% Compare with built-in Matlab function: rank() 
if o.compare
    xRank1 = rank(x);
    if xRank ~= xRank1
        warning("Rank computation inconsistency: Hoffman="+xRank+" Matlab="+xRank1);
        if nargout<=4
            xRank = min(xRank,xRank1); % max(xRank,xRank1);
        end
    end
end


%% Output eigenvectors first (useful for arrayfun/cellfun/pagefun/etc)
if o.eig
    xRank = xEig;
    xRank1 = xRank;
    xEig = xRank1;
end
