function [t,p,ci,mu,stats,dist] = ec_permuttest(x,m,a)
% ec_permuttest: modified from PERMUTOOLS for electroCUDA (see
%   modifications below)
%
%PERMUTTEST  One-sample and paired-sample permutation-based t-test.
%   T = PERMUTTEST(X) performs a one-sample permutation test based on the
%   t-statistic of the hypothesis that the data in X come from a
%   distribution with mean zero, and returns the test statistic. If X is a
%   matrix, separate permutation tests are performed along each column of
%   X, and a vector of results is returned. If the 'compare' parameter is
%   set to 'pairwise', two-tailed permutation tests between every pair of
%   columns in X are performed, and a matrix of results is returned.
%
%   PERMUTTEST treats NaNs as missing values, and ignores them.
%
%   T = PERMUTTEST(X,M) returns the results of a one-sample permutation
%   test of the hypothesis that the data in X come from a distribution with
%   mean M. M must be a scalar.
%
%   T = PERMUTTEST(X,Y) returns the results of a paired-sample permutation
%   test between dependent samples X and Y of the hypothesis that the data
%   in X and Y come from distributions with equal means. X and Y must have
%   the same length. If X and Y are matrices, separate permutation tests
%   are performed between each corresponding pair of columns in X and Y,
%   and a vector of results is returned.
%
%   [T,P] = PERMUTTEST(...) returns the probability (i.e. p-value) of
%   observing the given result by chance if the null hypothesis is true. As
%   the null distribution is generated empirically by permuting the data,
%   no assumption is made about the shape of the distribution that the data
%   come from. P-values are automatically adjusted for multiple comparisons
%   using the max correction method.
%
%   [T,P,CI] = PERMUTTEST(...) returns a 100*(1-ALPHA)% confidence interval
%   (CI) for the true mean of X, or of X-Y for a paired test. CIs are also
%   adjusted for multiple comparisons using the max correction method.
%
%   [T,P,CI,STATS] = PERMUTTEST(...) returns a structure with the following
%   fields:
%       'df'        -- the degrees of freedom of each test
%       'sd'        -- the estimated population standard deviation of X, or
%                      of X-Y for a paired test
%       'mu'        -- the estimated population mean of X, or of X-Y for a
%                      paired test
%
%   [T,P,CI,STATS,DIST] = PERMUTTEST(...) returns the permuted sampling
%   distribution of the test statistic.
%
%   [...] = PERMUTTEST(...,'PARAM1',VAL1,'PARAM2',VAL2,...) specifies
%   additional parameters and their values. Valid parameters are the
%   following:
%
%       Parameter   Value
%       'alpha'     A scalar between 0 and 1 specifying the significance
%                   level as 100*ALPHA% (default=0.05).
%       'dim'       A positive integer scalar specifying the dimension to
%                   work along (default=1). Applies to both X and Y.
%       'tail'      A string specifying the alternative hypothesis:
%                       'both'      mean is not M (two-tailed, default)
%                       'right'     mean is greater than M (right-tailed)
%                       'left'      mean is less than M (left-tailed)
%       'compare'   A string specifying what to compare each variable to
%                   when only X is entered:
%                       'zero'      compare each column of X to zero and
%                                   return a vector of results (default)
%                       'pairwise'  compare every pair of columns in X to
%                                   each other using two-tailed tests and
%                                   return a matrix of results
%       'nperm'     An integer scalar specifying the number of permutations
%                   (default=10,000).
%       'correct'   A numeric scalar (0,1) or logical indicating whether
%                   to control FWER using max correction (default=true).
%       'rows'      A string specifying the rows to use in the case of any
%                   missing values (NaNs):
%                       'all'       use all rows, even with NaNs (default)
%                       'complete'  use only rows with no NaNs
%       'seed'      An integer scalar specifying the seed value used to
%                   initialise the permutation generator. By default, the
%                   generator is initialised based on the current time,
%                   resulting in a different permutation on each call.
%       'verbose'   A numeric or logical specifying whether to execute in
%                   verbose mode: pass in 1 for verbose mode (default), or
%                   0 for non-verbose mode.
%       'parfor'    A logical specifying whether to parallelize permutation
%                   blocks using PARFOR (default=false).
%
%   See also TTEST PERMUTTEST2 BOOTEFFECTSIZE.
%
%   PERMUTOOLS https://github.com/mickcrosse/PERMUTOOLS
%
%   References:
%       [1] Crosse MJ, Foxe JJ, Molholm S (2024) PERMUTOOLS: A MATLAB
%           Package for Multivariate Permutation Testing. arXiv 2401.09401.
%       [2] Blair RC, Higgins JJ, Karniski W, Kromrey JD (1994) A Study of
%           Multivariate Permutation Tests Which May Replace Hotelling's T2
%           Test in Prescribed Circumstances. Multivariate Behav Res,
%           29(2):141-163.
%       [3] Gondan M (2010) A permutation test for the race model
%           inequality. Behav Res Methods, 42(1):23-28.
%       [4] Groppe DM, Urbach TP, Kutas M (2011) Mass univariate analysis
%           of event-related brain potentials/fields I: A critical tutorial
%           review. Psychophysiology, 48(12):1711-1725.
%
%   © 2018-2024 Mick Crosse <crossemj@tcd.ie>
%   CNL, Albert Einstein College of Medicine, NY.
%   TCBE, Trinity College Dublin, Ireland.
%
%  Modified by Kevin Tan for electroCUDA (github.com/electroCUDA):
%   - Added arguments block
%   - Optimized speed & memory use:
%       - Implicit expansion when possible
%       - Blockwise randomization (sign generation, etc)
%       - Explicit parallelization (CPU parfor, GPU vectorization)

%% Arguments validation
arguments
    x {mustBeFloat}
    m {mustBeFloat} = []
    a.alpha (1,1) double {mustBeGreaterThan(a.alpha,0),mustBeLessThan(a.alpha,1)} = 0.05
    a.dim (1,1) double {mustBeInteger,mustBePositive} = 1
    a.tail string {mustBeMember(a.tail,["left","both","right"])} = "both"
    a.compare string {mustBeMember(a.compare,["zero","pairwise"])} = "zero"
    a.nPerm (1,1) double {mustBeInteger,mustBePositive} = 1e4
    a.correct (1,1) logical = true
    a.rows string {mustBeMember(a.rows,["all","complete"])} = "all"
    a.maxBlockEl (1,1) {mustBeInteger} = 5e6; % maximum block elements
    a.mat (1,1) logical = false
    a.parallel {mustBeMember(a.parallel,["cpu" "gpu" "" []])} = "cpu"
    a.verbose (1,1) logical = true
    a.seed {mustBeSeedOption(a.seed)} = "shuffle"
end
% No parfor if running on GPU
if isgpuarray(x); a.parallel="gpu"; end
% Make sure alpha 
if a.alpha < 1/a.nPerm
    a.nPerm = ceil(1/a.alpha);
    warning("[ec_permuttest] Specified number of permutations too low for alpha, "+...
        "running "+a.nPerm+" permutations.");
end


%% Prep

% Reshape data to [observations x features] for n-D safety
xInputDims = ndims(x);
if a.dim~=1 || xInputDims>2
    [x,featureSize] = reshape2D_lfn(x,a.dim);
end

% Set up comparison
if isempty(m)
    switch a.compare
        case "zero"
            m = 0;
        case "pairwise"
            if xInputDims > 2
                error("The PAIRWISE option currently supports 2-D X only.")
            end
            warning("Comparing all columns of X using two-tailed test...")
            [x,m] = ptpaircols(x);
            a.tail = "both";
            a.mat = true;
    end
else
    switch a.compare
        case "pairwise"
            error("The PAIRWISE option can only be used with one sample.")
    end

    if ~isscalar(m) && ~iscolumn(m)
        [m,yFeatureSize] = reshape2D_lfn(m,a.dim);
        if ~isequal(size(x),size(m))
            error("X and Y must be the same size.")
        end
        if ~isequal(featureSize,yFeatureSize)
            error("X and Y feature dimensions must match.")
        end
    end
end

% Use only rows with no NaN values if specified
if a.rows == "complete"
    id = ~any(isnan(x),2);
    x = x(id,:);
    if ~isscalar(m)
        m = m(id,:);
    end
end

% For efficiency, only omit NaNs if necessary
if any(isnan(x),"all")
    a.nan = "omitmissing";
else
    a.nan = "includemissing";
end

% Get data dimensions, ignoring NaNs
[a.nObsMax,a.nVar] = size(x);
a.nObs = sum(~isnan(x)); % ~isnan per column

% Prep for permutation stats
if nargout > 1
    % Generate random permutations
    rng("shuffle");

    % Generate permutation blocks (saves memory by running blocks)
    a.bPerms = max(1,floor(a.maxBlockEl/a.nObsMax));
    a.bPerms = min(a.bPerms,a.nPerm);
    bStarts = 1:a.bPerms:a.nPerm;
    nBlocks = numel(bStarts);
    bSeeds = randi(intmax("uint32"),nBlocks,1,"uint32");

    % Check parallelization
    if a.parallel=="cpu"
        if nBlocks < 5 % feature('numcores')
            disp("[ec_permuttest] Less than 5 blocks, avoiding parfor, "+...
                "implicit parallelization likely faster");
        end
    elseif a.parallel=="gpu"
        x = gpuArray(x);
    end
end


%% Initial stats

% Compute difference between samples
x = x-m;

% Compute degrees of freedom
df = a.nObs - 1;

% Compute standard deviation
sd = std(x,a.nan);

% Compute mean difference
mu = sum(x,a.nan)./a.nObs;

% Compute test statistic
se = sd./sqrt(a.nObs);
t = mu./se;
if nargout==1; return; end % return if only p-value desired

% Estimate sampling distribution (sum(x.^2) is invariant to sign flips)
sx2 = sum(x.^2,a.nan);
sqrtn = sqrt(a.nObs.*df);

% Preallocate distances from mean (per block)
dist = cell(nBlocks,1);


%% Permutation stats
if a.parallel=="cpu"
    % CPU parallel loop across blocks
    parfor b = 1:nBlocks
        dist{b} = runBlock_lfn(x,sx2,sqrtn,bStarts(b),bSeeds(b),a);
    end
else
    % Loop across blocks (CPU or GPU)
    for b = 1:nBlocks
        dist{b} = runBlock_lfn(x,sx2,sqrtn,bStarts(b),bSeeds(b),a);
    end
end
dist = vertcat(dist{:});


%% Final stats

% Apply max correction if specified
if a.correct
    dist = max(abs(dist),[],2);
end

% Add negative values
dist(a.nPerm+1:2*a.nPerm,:) = -dist;
a.nPerm = 2*a.nPerm;
if a.verbose
    fprintf("Adding negative of values to permutation distribution.\n")
    fprintf("Number of effective permutations: %d\n",a.nPerm)
end

% Compute p-value & CI
switch a.tail
    case "both"
        p = 2*(sum(abs(t)<=dist)+1)/(a.nPerm+1);
        if nargout > 2
            crit = prctile(dist,100*(1-a.alpha/2)).*se;
            ci = [mu-crit;mu+crit];
        end
    case "right"
        p = (sum(t<=dist)+1)/(a.nPerm+1);
        if nargout > 2
            crit = prctile(dist,100*(1-a.alpha)).*se;
            ci = [mu-crit;Inf(1,a.nVar)];
        end
    case "left"
        p = (sum(t>=dist)+1)/(a.nPerm+1);
        if nargout > 2
            crit = prctile(dist,100*(1-a.alpha)).*se;
            ci = [-Inf(1,a.nVar);mu+crit];
        end
end


%% Organize outputs
if a.mat
    % Arrange results in a matrix if specified
    t = ptvec2mat(t);
    if nargout > 1
        p = ptvec2mat(p);
    end
    if nargout > 2
        ciLwr = ptvec2mat(ci(1,:));
        ciUpr = ptvec2mat(ci(2,:));
        ci = cat(3,ciLwr,ciUpr);
        ci = permute(ci,[3,1,2]);
    end
    if nargout > 3
        mu = ptvec2mat(mu);
    end
    if nargout > 4
        df = ptvec2mat(df);
        sd = ptvec2mat(sd);
    end
elseif a.dim~=1 || xInputDims>2
    % Restore original feature shape for non-pairwise outputs
    outSize = [1 featureSize];
    t = reshape(t,outSize);
    if nargout > 1
        p = reshape(p,outSize);
    end
    if nargout > 2
        ci = reshape(ci,[2 featureSize]);
    end
    if nargout > 3
        mu = reshape(mu,outSize);
    end
    if nargout > 4
        df = reshape(df,outSize);
        sd = reshape(sd,outSize);
    end
    if nargout > 5 && ~a.correct
        dist = reshape(dist,[a.nPerm featureSize]);
    end
end

% Store statistics in a structure
if nargout > 4
    stats.df = df;
    stats.sd = sd;
    stats.mu = mu;
end






function bDist = runBlock_lfn(x,sx2,sqrtn,bStart,seed,a)
%%% Permutation block %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rs = RandStream("mt19937ar","Seed",double(seed)); % seed for parfor

% Block indices
bEnd = min(bStart+a.bPerms-1,a.nPerm);
nbPerms = bEnd-bStart+1;

% Generate random signs
signBlock = 2*cast(rand(rs,a.nObsMax,nbPerms)>0.5,like=x)-1;

% Preallocate block distances
bDist = zeros(nbPerms,a.nVar,like=x);

% Loop across permutations
for k = 1:nbPerms
    xp = x.*signBlock(:,k); % implicit expansion
    smx = sum(xp,a.nan);
    bDist(k,:) = smx./a.nObs./(sqrt(sx2-(smx.^2)./a.nObs)./sqrtn);
end






function [x2d,featureSize] = reshape2D_lfn(x,dim)
sz = size(x);
if numel(sz) < dim
    sz(end+1:dim) = 1;
    x = reshape(x,sz);
end
permOrder = [dim,1:dim-1,dim+1:ndims(x)];
xPerm = permute(x,permOrder);
featureSize = size(xPerm);
featureSize = featureSize(2:end);
x2d = reshape(xPerm,size(xPerm,1),[]);


