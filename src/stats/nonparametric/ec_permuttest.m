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
%   - Added blockwise permutation engine with explicit nBlocks and stream-aware memory sizing.
%   - Added auto block sizing from available RAM/VRAM with upstream override (ramAvail, blockMemFrac).
%   - Added backend controls for CPU/GPU execution and GPU gather strategy.
%   - Switched GPU randomization to parallel.gpu.rng with deterministic per-block seeds.
%   - Refactored block computation into mode-specialized local kernels (CPU/GPU, grouped/ungrouped).
%   - Vectorized block statistics via matrix multiplication and grouped-sum kernels.
%   - Added precision/index controls (floatType, idxType) with class-consistent allocations.
%   - Added streaming p-value path (including corrected max-stat streaming) with nargout-aware fallback.
%   - Added exact/approx CI split for streaming mode (ciMode) and one-sort corrected counting helpers.
%   - Improved NaN handling for paired complete-row filtering and per-block reductions.
%   - Reduced memory traffic via numeric parfor accumulators, GPU-side reductions, and fewer temporaries.
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
    a.stream (1,1) logical = true % stream p-value reductions when exact dist/CI is not required
    a.ciMode string {mustBeMember(a.ciMode,["exact","approx"])} = "exact" % CI mode when streaming
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

% Get group indices
a.groupIdx = cast(ec_groupIndex(g,size(x,1),"g"),a.idxType);

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
        if exist("featureSize","var") && ~isequal(featureSize,yFeatureSize)
            error("X and Y feature dimensions must match.")
        end
    end
end

% Use only rows with no NaN values if specified
if a.rows == "complete"
    if isscalar(m)
        id = ~any(isnan(x),2);
    else
        id = ~any(isnan(x) | isnan(m),2);
    end
    x = x(id,:);
    if ~isempty(a.groupIdx)
        a.groupIdx = a.groupIdx(id);
    end
    if ~isscalar(m)
        m = m(id,:);
    end
end

% Convert to target precision before allocating permutation buffers.
x = cast(x,a.floatType);
m = cast(m,a.floatType);

% Work with the one-sample/paired difference from this point onward.
% Skip the subtraction when m is exactly the scalar zero null.
if ~(isscalar(m) && m==0)
    x = x-m;
end

% For efficiency, only omit NaNs if necessary. Paired-sample NaNs are now
% represented in the difference matrix, so counts/statistics stay aligned.
if any(isnan(x),"all")
    a.nan = "omitmissing";
else
    a.nan = "includemissing";
end

% Get data dimensions, ignoring NaNs
[a.nObsMax,a.nVar] = size(x);
a.nObs = sum(~isnan(x)); % ~isnan per column
if isempty(a.groupIdx)
    a.useGroups = false;
else
    a.useGroups = true;
    a.nExchGroups = max(a.groupIdx);
end


%% Initial stats

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

%% Permutation setup

a.needCI = nargout > 2;
a.needDist = nargout > 6;
a.needApproxCI = a.needCI && a.ciMode=="approx";
a.stream = a.stream && ~a.needDist && (~a.needCI || a.needApproxCI);

% Estimate sampling distribution (sum(x.^2) is invariant to sign flips)
sx2 = sum(x.^2,a.nan);
sqrtn = sqrt(a.nObs.*df);

% Replace NaNs with 0s for vectorization across permutations
if a.nan=="omitmissing"
    x(isnan(x)) = 0;
end

% Grouped sign-flips only need one summed row per exchangeability group.
groupSums = [];
if a.useGroups
    groupSums = groupSums_lfn(x,a);
end

% Generate random permutations
rng(a.seed);

if a.nBlocks>0
    a.bPerms = max(1,ceil(a.nPerm/a.nBlocks));
    if a.verbose
        fprintf("[ec_permuttest] Using explicit nBlocks=%d (bPerms=%d)\n",...
            a.nBlocks,a.bPerms);
    end
else
    if a.blockElMax==0
        a.bPerms = estimateBlockPermCap_lfn(a);
        if a.verbose
            fprintf("[ec_permuttest] Auto bPerms=%d (%.0f%% memory fraction)\n",...
                a.bPerms,100*a.blockMemFrac);
        end
    else
        signRows = a.nObsMax;
        if a.useGroups
            signRows = a.nExchGroups;
        end
        a.bPerms = max(1,floor(a.blockElMax/(signRows+a.nVar)));
        a.bPerms = min(a.bPerms,a.nPerm);
    end
end
bStarts = 1:a.bPerms:a.nPerm;
nBlocks = numel(bStarts);
bEnds = min(bStarts+a.bPerms-1,a.nPerm);
bSeeds = double(randi(intmax("uint32"),nBlocks,1,"uint32"));
if a.verbose
    fprintf("[ec_permuttest] Number of permutation blocks: %d\n",nBlocks);
end

% Check parallelization
if a.parallel=="cpu"
    nCores = feature("numcores");
    if nBlocks < nCores
        warning("[ec_permuttest] Less permutation blocks than cores, avoiding parfor, "+...
        "implicit BLAS/LAPACK multithreading likely faster");
        a.parallel = "none";
    end
end

% Move data to GPU once if requested (used by both streaming and full paths).
if a.parallel=="gpu"
    sx2   = gpuArray(sx2);
    sqrtn = gpuArray(sqrtn);
    if a.useGroups
        groupSums = gpuArray(groupSums);
    else
        x = gpuArray(x);
    end
end

if a.stream
    nSeen = 0;
    if a.correct
        % Materialize one column: max-/min-statistic per permutation (tail-aware).
        if a.parallel=="cpu"
            blkD1 = cell(nBlocks,1);
            blkN  = zeros(nBlocks,1);
            parfor b = 1:nBlocks
                bDist = runBlock_lfn(x,groupSums,sx2,sqrtn,bStarts(b),bEnds(b),bSeeds(b),a);
                blkD1{b} = blockMaxStat_lfn(bDist,a);
                blkN(b)  = numel(blkD1{b});
            end
            dist  = cell2mat(blkD1);
            nSeen = sum(blkN);
        else
            dist = zeros(a.nPerm,1,like=x);
            for b = 1:nBlocks
                bDist = runBlock_lfn(x,groupSums,sx2,sqrtn,bStarts(b),bEnds(b),bSeeds(b),a);
                d1 = blockMaxStat_lfn(bDist,a);
                if a.parallel=="gpu" && isa(d1,"gpuArray")
                    d1 = gather(d1);
                end
                dist(bStarts(b):bEnds(b)) = d1;
                nSeen = nSeen + numel(d1);
            end
        end
    else
        % Uncorrected: per-feature streaming counts (and approx-CI moments).
        dist = [];
        countExt = zeros(1,a.nVar,like=x);
        if a.needApproxCI
            nullSum   = zeros(1,a.nVar,like=x);
            nullSumSq = zeros(1,a.nVar,like=x);
        end
        if a.parallel=="cpu"
            blkCount = zeros(nBlocks,a.nVar,like=x);
            blkN     = zeros(nBlocks,1);
            blkSum = []; blkSumSq = [];
            if a.needApproxCI
                blkSum   = zeros(nBlocks,a.nVar,like=x);
                blkSumSq = zeros(nBlocks,a.nVar,like=x);
            end
            parfor b = 1:nBlocks
                bDist = runBlock_lfn(x,groupSums,sx2,sqrtn,bStarts(b),bEnds(b),bSeeds(b),a);
                [cnt,s,ssq] = streamBlockReduce_lfn(bDist,t,a);
                blkCount(b,:) = cnt;
                blkN(b)       = size(bDist,1);
                if a.needApproxCI
                    blkSum(b,:)   = s;
                    blkSumSq(b,:) = ssq;
                end
            end
            countExt = sum(blkCount,1);
            nSeen    = sum(blkN);
            if a.needApproxCI
                nullSum   = sum(blkSum,1);
                nullSumSq = sum(blkSumSq,1);
            end
        else
            for b = 1:nBlocks
                bDist = runBlock_lfn(x,groupSums,sx2,sqrtn,bStarts(b),bEnds(b),bSeeds(b),a);
                [cnt,s,ssq] = streamBlockReduce_lfn(bDist,t,a);
                if a.parallel=="gpu"
                    cnt = gather(cnt);
                    if a.needApproxCI
                        s   = gather(s);
                        ssq = gather(ssq);
                    end
                end
                countExt = countExt + cnt;
                nSeen    = nSeen    + size(bDist,1);
                if a.needApproxCI
                    nullSum   = nullSum   + s;
                    nullSumSq = nullSumSq + ssq;
                end
            end
        end
    end
elseif a.parallel=="cpu"
    % CPU parallel loop across blocks (full distribution path)
    dist = cell(nBlocks,1);
    parfor b = 1:nBlocks
        dist{b} = runBlock_lfn(x,groupSums,sx2,sqrtn,bStarts(b),bEnds(b),bSeeds(b),a);
    end
    dist = cell2mat(dist);
else
    % Preallocate full distribution and run blocks serially (or on GPU)
    if a.parallel=="gpu" && a.gather=="final"
        if a.useGroups
            dist = zeros(a.nPerm,a.nVar,like=groupSums);
        else
            dist = zeros(a.nPerm,a.nVar,like=x);
        end
    else
        dist = zeros(a.nPerm,a.nVar,like=x);
    end
    for b = 1:nBlocks
        dist(bStarts(b):bEnds(b),:) = runBlock_lfn(x,groupSums,sx2,sqrtn,bStarts(b),bEnds(b),bSeeds(b),a);
    end
    if a.parallel=="gpu" && a.gather=="final"
        dist = gather(dist);
    end
end


%% Final stats

if a.stream
    if a.verbose
        fprintf("[ec_permuttest] Streaming reductions complete over %d permutations.\n",nSeen);
    end
    if a.correct
        % nullDist is the tail-aware extremal distribution; sort once.
        d = sort(dist(~isnan(dist)));
        switch a.tail
            case "both";  countExt = countGE_lfn_sorted(d,abs(t));
            case "right"; countExt = countGE_lfn_sorted(d,t);
            case "left";  countExt = countLE_lfn_sorted(d,t);
        end
        p = (countExt + 1) / (nSeen + 1);
        if a.needApproxCI
            switch a.tail
                case "both"
                    crit = prctile(d,100*(1-a.alpha/2)).*se;
                    ci = [mu-crit;mu+crit];
                case "right"
                    crit = prctile(d,100*(1-a.alpha)).*se;
                    ci = [mu-crit;Inf(1,a.nVar)];
                case "left"
                    crit = prctile(d,100*a.alpha).*se;
                    ci = [-Inf(1,a.nVar);mu-crit];
            end
        end
    else
        p = (countExt + 1) / (nSeen + 1);
        if a.needApproxCI
            nullMu = nullSum ./ nSeen;
            nullVar = max(0, nullSumSq ./ nSeen - nullMu.^2);
            nullSd = sqrt(nullVar);
            switch a.tail
                case "both"
                    crit = normInv_lfn(1-a.alpha/2,nullMu,nullSd).*se;
                    ci = [mu-crit;mu+crit];
                case "right"
                    crit = normInv_lfn(1-a.alpha,nullMu,nullSd).*se;
                    ci = [mu-crit;Inf(1,a.nVar)];
                case "left"
                    crit = normInv_lfn(a.alpha,nullMu,nullSd).*se;
                    ci = [-Inf(1,a.nVar);mu-crit];
            end
        end
    end
else
    % Apply tail-aware max-correction if specified.
    if a.correct
        switch a.tail
            case "both";  dist = max(abs(dist),[],2);
            case "right"; dist = max(dist,[],2);
            case "left";  dist = min(dist,[],2);
        end
    end

    if a.verbose
        fprintf("Effective number of permutations: %d\n",a.nPerm)
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
            if a.needCI
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
            if a.needCI
                crit = prctile(dist,100*(1-a.alpha)).*se;
                ci = [mu-crit;Inf(1,a.nVar)];
            end
        case "left"
            if a.correct
                p = (countLE_lfn(dist,t)+1)/(a.nPerm+1);
            else
                p = (sum(dist<=t)+1)/(a.nPerm+1);
            end
            if a.needCI
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
    if a.needDist && ~a.correct
        dist = reshape(dist,[a.nPerm featureSize]);
    end
end




function bDist = runBlock_lfn(x,groupSums,sx2,sqrtn,bStart,bEnd,seed,a)
%%% Permutation block dispatcher %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if a.parallel=="gpu"
    if a.useGroups
        bDist = runBlock_gpu_grouped_lfn(groupSums,sx2,sqrtn,bStart,bEnd,seed,a);
    else
        bDist = runBlock_gpu_ungrouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a);
    end
else
    if a.useGroups
        bDist = runBlock_cpu_grouped_lfn(groupSums,sx2,sqrtn,bStart,bEnd,seed,a);
    else
        bDist = runBlock_cpu_ungrouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a);
    end
end


function bDist = runBlock_gpu_grouped_lfn(groupSums,sx2,sqrtn,bStart,bEnd,seed,a)
parallel.gpu.rng(seed,"Philox4x32-10");
nbPerms = bEnd-bStart+1;
signBlock = 2*cast(rand(a.nExchGroups,nbPerms,like=groupSums)>0.5,like=groupSums)-1;
bDist = blockDist_fromGroupSigns_lfn(groupSums,sx2,sqrtn,signBlock,a);


function bDist = runBlock_gpu_ungrouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a)
parallel.gpu.rng(seed,"Philox4x32-10");
nbPerms = bEnd-bStart+1;
signBlock = 2*cast(rand(a.nObsMax,nbPerms,like=x)>0.5,like=x)-1;
bDist = blockDist_fromSigns_lfn(x,sx2,sqrtn,signBlock,a);


function bDist = runBlock_cpu_grouped_lfn(groupSums,sx2,sqrtn,bStart,bEnd,seed,a)
rs = RandStream("mt19937ar","Seed",seed);
nbPerms = bEnd-bStart+1;
signBlock = 2*cast(rand(rs,a.nExchGroups,nbPerms)>0.5,like=groupSums)-1;
bDist = blockDist_fromGroupSigns_lfn(groupSums,sx2,sqrtn,signBlock,a);


function bDist = runBlock_cpu_ungrouped_lfn(x,sx2,sqrtn,bStart,bEnd,seed,a)
rs = RandStream("mt19937ar","Seed",seed);
nbPerms = bEnd-bStart+1;
signBlock = 2*cast(rand(rs,a.nObsMax,nbPerms)>0.5,like=x)-1;
bDist = blockDist_fromSigns_lfn(x,sx2,sqrtn,signBlock,a);


function bDist = blockDist_fromSigns_lfn(x,sx2,sqrtn,signBlock,a)
smx = signBlock.'*x; % [nbPerms x nVar]
bDist = smx./a.nObs./(sqrt(sx2-(smx.^2)./a.nObs)./sqrtn);


function bDist = blockDist_fromGroupSigns_lfn(groupSums,sx2,sqrtn,signBlock,a)
smx = signBlock.'*groupSums; % [nbPerms x nVar]
bDist = smx./a.nObs./(sqrt(sx2-(smx.^2)./a.nObs)./sqrtn);


function groupSums = groupSums_lfn(x,a)
groupMat = sparse(double(a.groupIdx),1:a.nObsMax,1,a.nExchGroups,a.nObsMax);
groupSums = cast(groupMat*x,like=x);


function d1 = blockMaxStat_lfn(bDist,a)
% Tail-aware extremal statistic per permutation row of a block.
switch a.tail
    case "both";  d1 = max(abs(bDist),[],2);
    case "right"; d1 = max(bDist,[],2);
    case "left";  d1 = min(bDist,[],2);
end


function [cnt,blkSum,blkSumSq] = streamBlockReduce_lfn(bDist,t,a)
% Per-block uncorrected streaming reduction (per-feature counts + optional
% running first/second moments for approx-CI).
switch a.tail
    case "both";  cnt = sum((bDist>=abs(t)) | (bDist<=-abs(t)),1);
    case "right"; cnt = sum(bDist>=t,1);
    case "left";  cnt = sum(bDist<=t,1);
end
if a.needApproxCI
    blkSum   = sum(bDist,1);
    blkSumSq = sum(bDist.^2,1);
else
    blkSum = []; blkSumSq = [];
end


function c = countGE_lfn(nullDist,vals)
d = nullDist(:);
d = sort(d(~isnan(d)));
c = countGE_lfn_sorted(d,vals);


function c = countLE_lfn(nullDist,vals)
d = nullDist(:);
d = sort(d(~isnan(d)));
c = countLE_lfn_sorted(d,vals);


function c = countGE_lfn_sorted(d,vals)
% Two-pointer scan: how many d(i) >= vals(j); d must be sorted ascending NaN-free.
n = numel(d);
v = vals(:);
ok = ~isnan(v);
[vSort,ord] = sort(v(ok));
okIdx = find(ok);
c = nan(size(v),like=vals);
i = 1;
for j = 1:numel(vSort)
    while i<=n && d(i)<vSort(j)
        i = i+1;
    end
    c(okIdx(ord(j))) = n-i+1;
end
c = reshape(c,size(vals));


function c = countLE_lfn_sorted(d,vals)
% Two-pointer scan: how many d(i) <= vals(j); d must be sorted ascending NaN-free.
n = numel(d);
v = vals(:);
ok = ~isnan(v);
[vSort,ord] = sort(v(ok));
okIdx = find(ok);
c = nan(size(v),like=vals);
i = n;
for j = numel(vSort):-1:1
    while i>=1 && d(i)>vSort(j)
        i = i-1;
    end
    c(okIdx(ord(j))) = i;
end
c = reshape(c,size(vals));


function x = normInv_lfn(p,mu,sigma)
x = norminv(p,mu,sigma);


function bPerms = estimateBlockPermCap_lfn(a)
% Conservative per-block cap from fixed + variable memory terms.
switch a.floatType
    case "double"
        bytesFloat = 8;
    case "single"
        bytesFloat = 4;
    case "half"
        bytesFloat = 2;
end

budgetBytes = max(0,double(a.ramAvail)*double(a.blockMemFrac));

fixedBytes = double(a.nObsMax)*double(a.nVar)*bytesFloat; % difference data
fixedBytes = fixedBytes + double(a.nVar)*bytesFloat*5;    % sx2, se, stats
if a.useGroups
    fixedBytes = fixedBytes + double(a.nExchGroups)*double(a.nVar)*bytesFloat;
end
if ~a.stream
    fixedBytes = fixedBytes + double(a.nPerm)*double(a.nVar)*bytesFloat;
end

signRows = a.nObsMax;
if a.useGroups
    signRows = a.nExchGroups;
end
perPermBytes = double(signRows)*bytesFloat;       % signBlock
perPermBytes = perPermBytes + double(a.nVar)*bytesFloat; % bDist row
perPermBytes = perPermBytes * 1.5;                % temporary headroom

availForBlock = max(0,budgetBytes-fixedBytes);
if perPermBytes<=0
    bPerms = 1;
else
    bPerms = max(1,floor(availForBlock/perPermBytes));
end
bPerms = min(bPerms,a.nPerm);




