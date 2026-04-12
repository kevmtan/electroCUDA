function [pval,se,mu] = ec_binomTest(dataOrK,N,p0,tail)
% binomExactTest  Exact binomial test p-value and SE of observed proportion.
%
% Usage:
%   [pval,se,pObs] = binomExactTest(x, p0)         % x: logical/0-1 vector
%   [pval,se,pObs] = binomExactTest(k, N, p0)      % k: number of positives
%   [pval,se,pObs] = binomExactTest(..., tail)     % tail: 'greater' (default), 'less', or 'two-sided'
%
% Outputs:
%   pval  - p-value for the exact binomial test (according to tail)
%   se    - standard error of the observed proportion: sqrt(pObs*(1-pObs)/N)
%   mu    - observed proportion = k/N
%
% Notes:
%   - For 'greater': H0: p = p0 vs H1: p > p0  (pval = P(X >= k | p0))
%   - For 'less'   : H0: p = p0 vs H1: p < p0  (pval = P(X <= k | p0))
%   - For 'two-sided': sum probabilities of outcomes with prob <= prob(k) under H0
%   - Uses built-in binopdf and binocdf for exact computation.

arguments
    dataOrK {mustBeNumericOrLogical} % either a vector of 0/1 or logicals, or a scalar count k
    N {mustBePositive,mustBeScalarOrEmpty} = [] % N: total count when calling with (k,N,...). Leave empty when passing a vector.
    p0 double {mustBeScalar,mustBePositive,mustBeLessThanOrEqual(p0,1)} = 0.5 % null hypothesis proportion in [0,1]
    tail (1,:) char {mustBeMember(tail,{'greater','less','two-sided'})} = 'greater'
end

% --- downstream: normalize inputs to k and N, then compute pval,se,pObs ---
if isvector(dataOrK) && (islogical(dataOrK) || all(ismember(dataOrK(:),[0 1])))
    x = dataOrK(:);
    k = sum(x);
    if ~isempty(N)
        error('When passing a binary vector as first argument, N must be empty.');
    end
    N = numel(x);
else
    % Expect scalar integer count k and scalar N
    if ~isscalar(dataOrK) || ~isscalar(N)
        error('When passing counts, dataOrK and N must be scalars.');
    end
    k = dataOrK;
    % validate integer and range
    mustBeInteger(k);
    mustBeNonnegative(k);
    mustBeNonnegative(N);
    if k > N
        error('k cannot be greater than N.');
    end
end

% Observed proportion and SE
mu = k / N;
se = sqrt(mu .* (1 - mu) ./ N);

% Exact p-value calculation
switch tail
    case 'greater'
        % P(X >= k)
        if k == 0
            pval = 1 - binocdf(-1, N, p0); % equals 1
        else
            pval = 1 - binocdf(k-1, N, p0);
        end
    case 'less'
        % P(X <= k)
        pval = binocdf(k, N, p0);
    case 'two-sided'
        % Two-sided: sum probabilities of outcomes with prob <= prob(k)
        % Compute pmf under H0
        xVals = 0:N;
        pmf = binopdf(xVals, N, p0);
        pk = binopdf(k, N, p0);
        % include all outcomes with probability <= pk (standard two-sided exact)
        extremeMask = pmf <= pk + eps(pk); % eps tolerance
        pval = sum(pmf(extremeMask));
        % Numerical safety: cap at 1
        pval = min(1, pval);
    otherwise
        error('Unknown tail option.');
end
