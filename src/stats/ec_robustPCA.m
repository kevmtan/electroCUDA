function [L,S] = ec_robustPCA(x,lambda,mu,tol,maxIter)
%% Robust principal components analysis (PCA)
% PCA algorithm: alternating direction method of multipliers (ADMM)
%
% Inputs: see "input validation" below
% Outputs:
%   L = low-rank matrix (clean)
%   S = sparse matrix (noise)
%
% Included in: https://github.com/kevmtan/electroCUDA
% Modified form: https://github.com/dlaptev/RobustPCA

%% Input validation
arguments
    x {mustBeFloat}                     % data matrix (size NxM) to be decomposed, nan values = unobserved
    lambda (1,1){mustBeFloat} = 0       % regularization parameter, default = 1/sqrt(max(N,M))
    mu (1,1){mustBeFloat} = 0           % augmented lagrangian parameter, default = 10*lambda
    tol (1,1){mustBeFloat} = 1e-6       % reconstruction error tolerance, default = 1e-6
    maxIter (1,1){mustBeFloat} = 1000   % max iterations to do
end

%% Prep
gpu = isgpuarray(x);
[M,N] = size(x);
unobserved = isnan(x);

% Fill defaults if empty
if ~lambda
    lambda = 1 / sqrt(max(M,N));
end
if ~mu
    mu = 10*lambda;
end

% Convert to gpuArray
if gpu
    lambda = gpuArray(lambda);
    mu = gpuArray(mu);
    tol = gpuArray(tol);
    maxIter = gpuArray(maxIter);
end

%% Main
x(unobserved) = 0;


% Norm of input data
normX = norm(x, 'fro');

% initial solution
L = zeros(M,N,like=x);
S = zeros(M,N,like=x);
Y = zeros(M,N,like=x);

for iter = 1:maxIter
    % ADMM step: update L and S
    L = Do(1/mu, x - S + (1/mu)*Y);
    S = So(lambda/mu, x - L + (1/mu)*Y);
    % and augmented lagrangian multiplier
    Z = x - L - S;
    Z(unobserved) = 0; % skip missing values
    Y = Y + mu*Z;

    err = norm(Z,'fro') / normX;
    if err<tol; break; end
end
% disp("[ec_robustPCA] finished: iter="+iter+" err="+err+" rank(L)="+ec_rank(L)+" card(S)="+nnz(S(~unobserved)));







%% Subfunctions
function r = So(tau, X)
% shrinkage operator
r = sign(X) .* max(abs(X)-tau, 0);


function r = Do(tau, X)
% shrinkage operator for singular values
[U, S, V] = svd(X, 'econ');
r = U*So(tau, S)*V';