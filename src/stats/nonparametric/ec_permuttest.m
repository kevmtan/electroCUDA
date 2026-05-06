function [t,p,ci,mu,df,sd,dist] = ec_permuttest(x,m,g,a)
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
%  Modified by Kevin Tan for electroCUDA (github.com/kevmtan/electroCUDA):
%   - Replaced name-value parsing with an arguments block and typed validation.
%   - Added n-D support by reshaping to [observations x features] and restoring output shape.
%   - Added exchangeability groups ('g') for group-constrained sign permutations.
%   - Added blockwise permutation engine for memory scaling (blockElMax, blockMemFrac).
%   - Added optional auto block sizing from available RAM/VRAM with upstream override (ramAvail).
%   - Added backend controls for CPU/GPU execution and GPU gather strategy.
%   - Switched GPU randomization to parallel.gpu.rng with block-wise deterministic seeds.
%   - Refactored block computation into mode-specialized local kernels (CPU/GPU, grouped/ungrouped).
%   - Vectorized block statistics via matrix multiplication (x' * signBlock).
%   - Added precision controls (floatType) and class-consistent random sign generation.
%   - Preserved pairwise-column mode with matrix-form output handling.

%% Arguments validation
arguments
    x {mustBeFloat} % sample data (observations x features)
    m {mustBeFloat} = [] % comparator (scalar/null mean or paired sample)
    g = [] % optional exchangeability group labels per observation
    a.alpha (1,1) double {mustBeGreaterThan(a.alpha,0),mustBeLessThan(a.alpha,1)} = 0.05 % significance level
    a.dim (1,1) double {mustBeInteger,mustBePositive} = 1 % observation dimension in input arrays
    a.tail string {mustBeMember(a.tail,["left","both","right"])} = "both" % hypothesis tail
    a.compare string {mustBeMember(a.compare,["zero","pairwise"])} = "zero" % one-sample comparison mode
    a.nPerm (1,1) double {mustBeInteger,mustBePositive} = 1e4 % number of permutations
    a.correct (1,1) logical = true % apply max-stat multiple-comparison correction
    a.rows string {mustBeMember(a.rows,["all","complete"])} = "all" % NaN row handling
    a.blockElMax (1,1) double {mustBeInteger,mustBeNonnegative} = 0 % maximum block elements (0=auto from available memory)
    a.nBlocks (1,1) double {mustBeInteger,mustBeNonnegative} = 0 % explicit number of permutation blocks (0=derive from blockElMax)
    a.blockMemFrac (1,1) double {mustBeGreaterThan(a.blockMemFrac,0),mustBeLessThan(a.blockMemFrac,1)} = 0.2 % Fraction of available memory to use within permute blocks (for auto blockElMax)
    a.parallel {mustBeMember(a.parallel,["none" "gpu" "cpu" ""])} = "none" % execution backend (CPU not worth it)
    a.ramAvail (1,1) double = 0 % available RAM/VRAM bytes (override upstream if needed)
    a.mat (1,1) logical = false % return pairwise results as square matrices
    a.gather string {mustBeMember(a.gather,["block","final"])} = "block" % GPU gather strategy
    a.idxType string {mustBeMember(a.idxType,["double","uint32"])} = "double" % grouped index-buffer type
    a.floatType {mustBeMember(a.floatType,["double" "single" "half"])} = class(x)
    a.verbose (1,1) logical = true % print status messages
    a.seed {mustBeSeedOption(a.seed)} = "shuffle" % RNG seed or "shuffle"
end
% No parfor if running on GPU
if isgpuarray(x); a.parallel="gpu"; end
% Make sure alpha is above 
if a.alpha < 1/a.nPerm
    a.nPerm = ceil(1/a.alpha);
    warning("[ec_permuttest] Specified number of permutations too low for alpha, "+...
        "running "+a.nPerm+" permutations.");
end
% Get available RAM/VRAM if not specified
if isnan(a.ramAvail) || a.ramAvail<=0 
    a.ramAvail = ec_ramAvail(a.parallel=="gpu");
end


%% Prep

% Reshape data to [observations x features] for n-D safety
xInputDims = ndims(x);
if a.dim~=1 || xInputDims>2
    [x,featureSize] = ec_reshape2D(x,a.dim);
end
g = ec_groupIndex(g,size(x,1),"g");

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
            [x,m] = ec_ptpaircols(x);
            a.tail = "both";
            a.mat = true;
    end
else
    switch a.compare
        case "pairwise"
            error("The PAIRWISE option can only be used with one sample.")
    end

    if ~isscalar(m) && ~iscolumn(m)
        [m,yFeatureSize] = ec_reshape2D(m,a.dim);
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
    if ~isempty(g)
        g = g(id);
    end
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
if isempty(g)
    a.useGroups = false;
else
    a.useGroups = true;
    switch a.idxType
        case "double"
            a.groupIdx = g;
        case "uint32"
            a.groupIdx = uint32(g);
    end
    a.nExchGroups = max(g);
end

% Prep for permutation stats
if nargout > 1
    % Generate random permutations
    rng(a.seed);

    if a.nBlocks>0
        a.bPerms = max(1,ceil(a.nPerm/a.nBlocks));
        if a.verbose
            fprintf("[ec_permuttest] Using explicit nBlocks=%d (bPerms=%d)\n",...
                a.nBlocks,a.bPerms);
        end
    else
        % Auto-size block elements from available memory if requested.
        if a.blockElMax==0
            switch a.floatType
                case "double"
                    bytesPerEl = 8;
                case "single"
                    bytesPerEl = 4;
                case "half"
                    bytesPerEl = 2;
            end
            a.blockElMax = max(1,floor((double(a.ramAvail)*a.blockMemFrac)/bytesPerEl));
            if a.verbose
                fprintf("[ec_permuttest] Auto blockElMax=%d (%.0f%% memory fraction)\n",...
                    a.blockElMax,100*a.blockMemFrac);
            end
        end
        % Generate permutation groups (saves memory by running blocks)
        a.bPerms = max(1,floor(a.blockElMax/a.nObsMax));
        a.bPerms = min(a.bPerms,a.nPerm);
    end
    bStarts = 1:a.bPerms:a.nPerm;
    nBlocks = numel(bStarts);
    bEnds = min(bStarts+a.bPerms-1,a.nPerm);
    bSeeds = randi(intmax("uint32"),nBlocks,1,"uint32");
    if a.verbose
        disp("[ec_permuttest] Number of permutation blocks: "+nBlocks); end

    % Check parallelization
    if a.parallel=="cpu"
        nCores = feature("numcores");
        if nBlocks < nCores
            warning("[ec_permuttest] Less permutation blocks than cores, avoiding parfor, "+...
            "implicit BLAS/LAPACK multithreading likely faster");
            a.parallel = "none";
        end
    end

    % Preallocate distances from mean (per block)
    if a.parallel=="cpu"
        dist = cell(nBlocks,1);
    else
        if a.parallel=="gpu" && a.gather=="final"
            dist = [];
        else
            dist = zeros(a.nPerm,a.nVar,like=x);
        end
    end
end

% Convert to float type
x = cast(x,a.floatType);
m = cast(m,a.floatType);


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

% Return if only t-value desired
if nargout==1; return; end

% Estimate sampling distribution (sum(x.^2) is invariant to sign flips)
sx2 = sum(x.^2,a.nan);
sqrtn = sqrt(a.nObs.*df);

% Replace NaNs with 0s for vectorization across permutations
if a.nan=="omitmissing"
    x(isnan(x)) = 0;
end


%% Permutation stats
if a.parallel=="cpu"
    % CPU parallel loop across blocks
    parfor b = 1:nBlocks
        dist{b} = runBlock_lfn(x,sx2,sqrtn,bStarts(b),bEnds(b),bSeeds(b),a);
    end
    dist = vertcat(dist{:});
else
    % Copy to GPU
    if a.parallel=="gpu"
        x     = gpuArray(x);
        sx2   = gpuArray(sx2);
        sqrtn = gpuArray(sqrtn);
        if a.gather=="final"
            dist = zeros(a.nPerm,a.nVar,like=x);
        end
    end

    % Loop across blocks (CPU or GPU)
    for b = 1:nBlocks
        dist(bStarts(b):bEnds(b),:) = runBlock_lfn(x,sx2,sqrtn,bStarts(b),bEnds(b),bSeeds(b),a);
    end
    if a.parallel=="gpu" && a.gather=="final"
        dist = gather(dist);
    end
end


%% Final stats

% Apply max correction if specified
if a.correct
    dist = max(abs(dist),[],2);
end

if a.verbose
    fprintf("Effective number of permutations: %d\n",a.nPerm)
end

% Compute p-value & CI
if a.verbose
    if a.correct
        fprintf("[ec_permuttest] Computing max-corrected p-values (serial threshold counting)...\n");
    else
        fprintf("[ec_permuttest] Computing uncorrected p-values/CI from full permutation distribution...\n");
    end
end
switch a.tail
    case "both"
        if a.correct
            p = (countGE_lfn(dist,abs(t))+1)/(a.nPerm+1);
        else
            tAbs = abs(t);
            p = (sum((dist>=tAbs) | (dist<=-tAbs))+1)/(a.nPerm+1);
        end
        if nargout > 2
            if a.correct
                crit = prctile(dist,100*(1-a.alpha/2)).*se;
            else
                crit = prctile(abs(dist),100*(1-a.alpha/2)).*se;
            end
            ci = [mu-crit;mu+crit];
        end
    case "right"
        if a.correct
            p = (countGE_lfn(dist,t)+1)/(a.nPerm+1);
        else
            p = (sum(dist>=t)+1)/(a.nPerm+1);
        end
        if nargout > 2
            crit = prctile(dist,100*(1-a.alpha)).*se;
            ci = [mu-crit;Inf(1,a.nVar)];
        end
    case "left"
        if a.correct
            p = (countGE_lfn(dist,-t)+1)/(a.nPerm+1);
        else
            p = (sum(dist<=t)+1)/(a.nPerm+1);
        end
        if nargout > 2
            if a.correct
                crit = prctile(dist,100*(1-a.alpha)).*se;
                ci = [-Inf(1,a.nVar);mu+crit];
            else
                crit = prctile(dist,100*a.alpha).*se;
                ci = [-Inf(1,a.nVar);mu-crit];
            end
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
    end
    if nargout > 5
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
    end
    if nargout > 5
        sd = reshape(sd,outSize);
    end
    if nargout > 6 && ~a.correct
        dist = reshape(dist,[a.nPerm featureSize]);
    end
end

% % Store statistics in a structure
% if nargout > 4
%     stats.df = df;
%     stats.sd = sd;
%     stats.mu = mu;
% end






function bDist = runBlock_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a)
%%% Permutation block dispatcher %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if a.parallel=="gpu"
    if a.useGroups
        bDist = runBlock_gpu_grouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a);
    else
        bDist = runBlock_gpu_ungrouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a);
    end
else
    if a.useGroups
        bDist = runBlock_cpu_grouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a);
    else
        bDist = runBlock_cpu_ungrouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a);
    end
end


function bDist = runBlock_gpu_grouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a)
parallel.gpu.rng(double(seed),"Philox4x32-10");
nbPerms = bEnd-bStart+1;
signBlock = 2*cast(rand(a.nExchGroups,nbPerms,like=x)>0.5,like=x)-1;
signBlock = signBlock(a.groupIdx,:);
bDist = blockDist_fromSigns_lfn(x,sx2,sqrtn,signBlock,a);
if a.gather=="block"
    bDist = gather(bDist);
end


function bDist = runBlock_gpu_ungrouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a)
parallel.gpu.rng(double(seed),"Philox4x32-10");
nbPerms = bEnd-bStart+1;
signBlock = 2*cast(rand(a.nObsMax,nbPerms,like=x)>0.5,like=x)-1;
bDist = blockDist_fromSigns_lfn(x,sx2,sqrtn,signBlock,a);
if a.gather=="block"
    bDist = gather(bDist);
end


function bDist = runBlock_cpu_grouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a)
rs = RandStream("mt19937ar","Seed",double(seed));
nbPerms = bEnd-bStart+1;
signBlock = 2*cast(rand(rs,a.nExchGroups,nbPerms)>0.5,like=x)-1;
signBlock = signBlock(a.groupIdx,:);
bDist = blockDist_fromSigns_lfn(x,sx2,sqrtn,signBlock,a);


function bDist = runBlock_cpu_ungrouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a)
rs = RandStream("mt19937ar","Seed",double(seed));
nbPerms = bEnd-bStart+1;
signBlock = 2*cast(rand(rs,a.nObsMax,nbPerms)>0.5,like=x)-1;
bDist = blockDist_fromSigns_lfn(x,sx2,sqrtn,signBlock,a);


function bDist = blockDist_fromSigns_lfn(x,sx2,sqrtn,signBlock,a)
smx = x.'*signBlock; % [nVar x nbPerms]
smx = smx.'; % [nbPerms x nVar]
bDist = smx./a.nObs./(sqrt(sx2-(smx.^2)./a.nObs)./sqrtn);


function c = countGE_lfn(nullDist,vals)
d = sort(nullDist(:));
n = numel(d);
v = vals(:);
[vSort,ord] = sort(v);
cSort = zeros(size(vSort));
i = 1;
for j = 1:numel(vSort)
    while i<=n && d(i)<vSort(j)
        i = i+1;
    end
    cSort(j) = n-i+1;
end
c = zeros(size(v));
c(ord) = cSort;
c = reshape(c,size(vals));





