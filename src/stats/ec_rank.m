function [xRank,xEig,xRank1] = ec_rank(x,flag,o)
%% Better rank computation using covariance eigenvectors
% OUTPUTS: [rank, eigenvectors, matlab-calculated rank]
arguments
    x {mustBeFloat}                 % Input data: x(observations,variables)
    flag (1,1) {islogical} = false  % Compare rank with Matlab default
    o.tol (1,1) {isfloat} = 1e-7    % Minimum eigenvector for rank contribution
    o.gpu (1,1) {islogical} = false % Use GPU
    o.eig (1,1) {islogical} = false % Covariance eigenvector as 1st output
end
if isempty(o.tol); o.tol = 1e-7; end
if isgpuarray(x); o.gpu = true; end
if o.gpu && ~isgpuarray(x); x = gpuArray(x);end
if o.gpu && ~isgpuarray(o.tol); o.tol = gpuArray(o.tol); end

%% Better rank computation using covariance eigenvectors (Sven Hoffman)
xEig = eig(cov(x,1,'partialrows'));
xRank = sum(xEig>o.tol);

%% Matlab default rank computation 
if nargout>=3 || flag
    xRank1 = rank(x);
    if xRank ~= xRank1
        if ~o.gpu; warning("Rank computation inconsistency: Hoffman="+xRank+" Matlab="+xRank1); end
        if nargout<=2 && flag
            xRank = min(xRank,xRank1); %max(xRank,xRank1);
        end
    end
end

%% Output eigenvectors first (useful for arrayfun/cellfun/pagefun/etc)
if o.eig
    xRank1 = xRank;
    xRank = xEig;
    xEig = xRank1;
end
