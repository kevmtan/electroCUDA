function [t,p,ci,mu,df,se,dist] = ec_permuttest2(x,y,gx,gy,a)
% ec_permuttest2: modified from PERMUTOOLS for electroCUDA (see
%   modifications below)
%
%PERMUTTEST2  Unpaired two-sample permutation-based t-test.
%   T = PERMUTTEST2(X,Y) performs a two-sample permutation test based on
%   the t-statistic of the hypothesis that the data in X and Y come from
%   distributions with equal means, and returns the test statistic. If X
%   and Y are matrices, separate permutation tests are performed between
%   each corresponding pair of columns in X and Y, and a vector of results
%   is returned. If Y is empty, two-tailed permutation tests between every
%   pair of columns in X are performed, and a matrix of results is
%   returned. X and Y can have different lengths.
%
%   For samples of unequal size or variance, Welch's t-statistic may be
%   used by setting the 'vartype' parameter to 'unequal' as it is less
%   sensitive to differences in variance (but also less sensitive to
%   differences in means).
%
%   PERMUTTEST2 treats NaNs as missing values, and ignores them.
%
%   [T,P] = PERMUTTEST2(...) returns the probability (i.e. p-value) of
%   observing the given result by chance if the null hypothesis is true.
%
%   [T,P,CI] = PERMUTTEST2(...) returns a 100*(1-ALPHA)% confidence
%   interval (CI) for the true difference of population means.
%
%   [T,P,CI,MU,STATS,DIST] = PERMUTTEST2(...) returns mean differences,
%   statistics, and the permuted sampling distribution.
%
%   [...] = PERMUTTEST2(...,'PARAM1',VAL1,'PARAM2',VAL2,...) specifies
%   additional parameters and their values.
%
%  Modified by Kevin Tan for electroCUDA (github.com/kevmtan/electroCUDA):
%   - Replaced name-value parsing with an arguments block and typed validation.
%   - Added n-D support by reshaping to [observations x features] and restoring output shape.
%   - Added grouped exchangeability support via gx/gy-constrained label shuffling.
%   - Added blockwise permutation engine with explicit nBlocks and stream-aware memory sizing.
%   - Added auto block sizing from available RAM/VRAM with upstream override (ramAvail, blockMemFrac).
%   - Added backend controls for CPU/GPU execution and GPU gather strategy.
%   - Added core-count heuristic to avoid inefficient parfor for too few blocks.
%   - Refactored block computation into mode-specialized local kernels (GPU, CPU grouped, CPU ungrouped).
%   - Reduced per-permutation data movement by reusing pooled sums/sumsq in fast kernels.
%   - Added optional numerically stable variance path (stableVar) with separate fast/stable kernels.
%   - Added precision/index controls (floatType, idxType) and cached grouped metadata/offsets.
%   - Added full streaming p-value path with nargout-aware fallback and exact/approx CI modes.
%   - Added one-sort corrected counting helpers (tail-aware max/min/abs handling).
%   - Reduced grouped CPU peak memory by tiling permutation columns within each block.
%   - Replaced streaming parfor cell accumulators with numeric sliced arrays to reduce overhead.
%   - 'correct' is a string enum {"none","max","tfce"} validated in the arguments block.
%   - Added TFCE (threshold-free cluster enhancement; Smith & Nichols 2009) cluster correction
%     via shared helper helper/ec_tfce.m with separate +/- enhancement and 1-/2-/N-D spatial
%     neighborhoods (a.tfceE, a.tfceH, a.tfceDh, a.tfceConn, a.tfceDims).
%   - Under correct="tfce", the 1st output 't' is OVERWRITTEN with the TFCE-enhanced
%     observed map (signed, same shape as raw t). The raw pre-TFCE t-statistic is no
%     longer separately returned. Rationale: the inference statistic under TFCE IS the
%     TFCE map (it is what gets compared to the null max-TFCE distribution to produce p),
%     so the primary output should be it. Returning it as an extra 8th output forced
%     nargout>=8 to retrieve it, which forced needDist=true and disabled streaming —
%     making "give me the inference statistic" implicitly costly. Recompute raw t
%     externally if needed (mu./se from outputs 4+6 or unaffected by correct).
%   - Streaming-aware TFCE: per-block reduction returns max-TFCE so dist stays [nPerm x 1];
%     when needCI requested with TFCE, also accumulates per-feature null moments for an
%     uncorrected normal-approximation CI (CI semantics differ from p-values under TFCE).
%   - GPU+TFCE auto-falls back to parallel="none" with warning (bwconncomp is CPU-only).
%   - Errors out if correct="tfce" combined with pairwise comparison (spatial structure undefined).
%   - Widened the selection-matmul fast path to grouped permutations (drops the ~useGroups gate);
%     after building idx, dispatches to blockDist_matmul_lfn using the X-arm slice idx(1:nObsXMax,:)
%     instead of the [nObsXMax x bPerms x nVar] gather kernel.
%   - Exposed the matmul threshold as option a.matmulThresh (default 0 = always use matmul
%     when ~stableVar; Inf = always use gather). Was hard-coded 5e6 before this session.
%     Setting 0 is safe: BLAS auto-falls to single-thread for tiny matrices, so there is
%     no thread-overhead risk at small problem sizes.
%   - Cached z.^2 once per call (a.z2) instead of recomputing inside every block; the cache
%     lives on the same device as z (CPU or GPU) so the matmul kernel reuses it directly.
%   - Updated the per-block memory estimator to account for the cached z.^2 fixed cost,
%     the smaller idx footprint of ungrouped+matmul (idx1 only), and the matmul A matrix.
%   - TFCE default connectivity is rook adjacency (conndef(max(2,K),"minimal")):
%     4-conn in 2-D and 6-conn in 3-D — diagonal time/freq/channel neighbors carry weaker
%     physical meaning in iEEG so we exclude them by default.
%   - Renamed a.tfceSpatialDims → a.tfceDims (less confusing: indexing is into featureSize,
%     not into the input data array; obs dim is already stripped at that point).
%   - Added warnings for likely-foot-gun TFCE configurations: (1) default tfceDims
%     with multi-dim featureSize (recommends explicit setting for the iEEG layout
%     [obs x time x channel(x freq)] where channels are independent observations);
%     (2) TFCE+grouped runs CPU-only; (3) TFCE without streaming holds full [nPerm x nVar]
%     in memory.
%   - Added a.tfceVoxelWeights (forwarded as tfceOpts.voxelWeights) for non-uniform spatial
%     sampling: extent = sum(weights(idx)) instead of numel(idx). Not needed for the standard
%     iEEG TF layout (uniform log-freq + uniform linear time has pixel count proportional to
%     octaves x seconds already); intended for mixed linear/log axes or irregular binning.
%   - 6th output 'sd' replaced with 'se' (the standard error of the mean difference used
%     internally for the t-statistic and CI formulas). The Welch (vartype="unequal") path
%     no longer materializes the per-arm [sd_X; sd_Y] array, and the 2-row reshape special
%     case in the output organization block is removed. CALLER-FACING NUMERIC CHANGE: the
%     6th output is now 'se' = sqrt(varX/nX + varY/nY) for Welch or
%     sqrt((dfX*varX+dfY*varY)/df) * sqrt((nX+nY)/(nX*nY)) for equal-variance — different
%     from the previous 'sd' value, and per-arm SDs are no longer recoverable from this
%     output.

%% Arguments validation
arguments
    x {mustBeFloat} % first sample (observations x features)
    y {mustBeFloat} = [] % second sample (empty => pairwise columns of x)
    gx = [] % optional group labels for observations in x
    gy = [] % optional group labels for observations in y
    a.alpha (1,1) double {mustBeGreaterThan(a.alpha,0),mustBeLessThan(a.alpha,1)} = 0.05 % significance level
    a.dim (1,1) double {mustBeInteger,mustBePositive} = 1 % observation dimension in input arrays
    a.tail string {mustBeMember(a.tail,["left","both","right"])} = "both" % hypothesis tail
    a.vartype string {mustBeMember(a.vartype,["equal","unequal"])} = "equal" % equal-variance or Welch t-statistic
    a.stableVar (1,1) logical = false % use centered variance (more stable, slower)
    a.nPerm (1,1) double {mustBeInteger,mustBePositive} = 1e4 % number of permutations
    a.correct string {mustBeMember(a.correct,["none","max","tfce"])} = "none" % multiple-comparison correction: "none" | "max" | "tfce"
    a.tfceE (1,1) double {mustBePositive} = 0.5 % TFCE extent exponent (Smith & Nichols 2009)
    a.tfceH (1,1) double {mustBePositive} = 2 % TFCE height exponent (Smith & Nichols 2009)
    a.tfceDh (1,1) double {mustBeNonnegative} = 0 % TFCE step size (0=auto: max(|stat|)/100 per column)
    a.tfceConn = [] % TFCE bwconncomp connectivity (default conndef(max(2,K),"minimal") = rook: 4-conn 2-D, 6-conn 3-D, chain 1-D)
    a.tfceDims double {mustBeInteger,mustBeNonnegative} = [] % feature dims forming TFCE neighborhood (default=all)
    a.tfceVoxelWeights {mustBeNumeric} = [] % per-voxel extent weights matching featureSize(spatialDims); default [] => uniform pixel count
    a.rows string {mustBeMember(a.rows,["all","complete"])} = "all" % NaN row handling
    a.blockElMax (1,1) double {mustBeInteger,mustBeNonnegative} = 0 % maximum block elements (0=auto from available memory)
    a.nBlocks (1,1) double {mustBeInteger,mustBeNonnegative} = 0 % explicit number of permutation blocks (0=derive from blockElMax)
    a.blockMemFrac (1,1) double {mustBeNonnegative,mustBeLessThan(a.blockMemFrac,1)} = 0.2 % Fraction of available memory for auto block sizing; 0 = skip auto-sizing, use nBlocks directly
    a.matmulThresh (1,1) double {mustBeNonnegative} = 0 % min nObsXMax*nVar to use selection-matmul kernel (0=always; Inf=never)
    a.parallel {mustBeMember(a.parallel,["none" "gpu" "cpu" ""])} = "none" % execution backend (CPU not worth it)
    a.ramAvail (1,1) double = nan % available RAM/VRAM bytes (override upstream if needed)
    a.mat (1,1) logical = false % return pairwise results as square matrices
    a.gather string {mustBeMember(a.gather,["block","final"])} = "block" % GPU gather strategy
    a.stream (1,1) logical = true % stream block reductions when exact dist is not required
    a.ciMode string {mustBeMember(a.ciMode,["exact","approx"])} = "exact" % CI mode when streaming
    a.idxType string {mustBeMember(a.idxType,["double","single","uint32","uint16"])} = "double" % grouped CPU index-buffer type
    a.floatType {mustBeMember(a.floatType,["double" "single" "half"])} = class(x)
    a.verbose (1,1) logical = true % print status messages
    a.seed {mustBeSeedOption(a.seed)} = "shuffle" % RNG seed or "shuffle"
end
if isgpuarray(x) || isgpuarray(y)
    a.parallel = "gpu";
end
if a.alpha < 1/a.nPerm
    a.nPerm = ceil(1/a.alpha);
    warning("[ec_permuttest2] Specified permutations too low for alpha; running "+a.nPerm+".")
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
else
    featureSize = size(x,2);   % single feature dim (2D input on dim=1)
end
a.featureSize = featureSize;
gx = ec_groupIndex(gx,size(x,1),"gx");

% Set up comparison
if isempty(y)
    if xInputDims > 2
        error("PAIRWISE option currently supports 2-D X only.");
    end
    warning("[ec_permuttest2] Comparing all columns of X using two-tailed test...");
    [x,y] = ec_ptpaircols(x);
    if ~isempty(gx)
        gy = gx;
    end
    a.tail = "both";
    a.mat = true;
else
    if a.dim~=1 || ~ismatrix(y)
        [y,yFeatureSize] = ec_reshape2D(y,a.dim);
        if size(x,2)~=size(y,2)
            error("X and Y must have the same number of variables.");
        end
        if exist("featureSize","var") && ~isequal(featureSize,yFeatureSize)
            error("X and Y feature dimensions must match.");
        end
    elseif size(x,2)~=size(y,2)
        error("X and Y must have the same number of variables.");
    end
    gy = ec_groupIndex(gy,size(y,1),"gy");
    if xor(isempty(gx),isempty(gy))
        error("Provide both gx and gy, or neither.");
    end
end

% Use only rows with no NaNs if specified
if a.rows=="complete"
    idX = ~any(isnan(x),2);
    idY = ~any(isnan(y),2);
    x = x(idX,:);
    y = y(idY,:);
    if ~isempty(gx)
        gx = gx(idX);
        gy = gy(idY);
    end
end

% For efficiency, only omit NaNs if necessary
if any(isnan(x),"all") || any(isnan(y),"all")
    a.nan = "omitmissing";
else
    a.nan = "includemissing";
end

% Get data dimensions, ignoring NaNs
[a.nObsXMax,a.nVar] = size(x);
a.nObsYMax = size(y,1);
a.nObsX = sum(~isnan(x));
a.nObsY = sum(~isnan(y));
if isempty(gx)
    a.useGroups = false;
else
    a.useGroups = true;
    gAll = [gx;gy];
    [~,~,gAll] = unique(gAll,"stable");
    a.nExchGroups = max(gAll);

    % Group rows in O(nObsTot) via sort + counts (instead of repeated find).
    [gSorted,sortIdx] = sort(gAll);
    counts = accumarray(gSorted,1);
    a.groupRows = mat2cell(sortIdx,counts,1);

    % Per-group X/Y counts via accumarray on the (X-arm) indicator.
    isXArm = (1:(a.nObsXMax+a.nObsYMax)).' <= a.nObsXMax;
    a.nXPerGroup = accumarray(gAll,double(isXArm));
    a.nYPerGroup = counts - a.nXPerGroup;

    % Cumulative offsets used by grouped permutation kernels (cache once).
    a.xOffsets = [0; cumsum(a.nXPerGroup(1:end-1))];
    a.yOffsets = [0; cumsum(a.nYPerGroup(1:end-1))];

    if a.verbose && any(a.nXPerGroup==0 | a.nXPerGroup==counts)
        warning("[ec_permuttest2] Some groups contain only one sample label; those labels are fixed.")
    end
end

% Convert to float type
x = cast(x,a.floatType);
y = cast(y,a.floatType);


%% Initial stats

% Compute degrees of freedom
a.dfX = a.nObsX-1;
a.dfY = a.nObsY-1;

% Compute sample variance
sumX = sum(x,a.nan);
sumY = sum(y,a.nan);
if a.stableVar
    [varX,varY] = observedVar_stable_lfn(x,y,sumX,sumY,a);
else
    [varX,varY] = observedVar_fast_lfn(x,y,sumX,sumY,a);
end

% Compute standard error
switch a.vartype
    case "equal"
        nObs = a.nObsX+a.nObsY;
        df = nObs-2;
        sdPooled = sqrt((a.dfX.*varX+a.dfY.*varY)./df);
        se = sdPooled.*sqrt(nObs./(a.nObsX.*a.nObsY));
    case "unequal"
        se2X = varX./a.nObsX;
        se2Y = varY./a.nObsY;
        df = (se2X+se2Y).^2./(se2X.^2./a.dfX+se2Y.^2./a.dfY);
        se = sqrt(se2X+se2Y);
end
a.df = df;

% Compute mean difference and test statistic
mu = sumX./a.nObsX - sumY./a.nObsY;
t = mu./se;

% Return if only t-value desired (under correct="tfce", t is the TFCE-enhanced map).
if nargout==1
    if a.correct=="tfce"
        spDims = a.tfceDims;
        if isempty(spDims), spDims = 1:numel(a.featureSize); end
        opts = struct("E",a.tfceE,"H",a.tfceH,"dh",a.tfceDh,...
            "conn",a.tfceConn,"spatialDims",spDims,...
            "voxelWeights",a.tfceVoxelWeights);
        t = ec_tfce(t(:),a.featureSize,E=opts.E,H=opts.H,dh=opts.dh,conn=opts.conn,spatialDims=opts.spatialDims,voxelWeights=opts.voxelWeights).';
        if a.dim~=1 || xInputDims>2
            t = reshape(t,[1 featureSize]);
        end
    end
    return
end


%% Permutation setup

% Concatenate samples for label shuffling
z = [x;y];
a.nObsTot = size(z,1);
clear x y  % all stats extracted into locals/a.*; free ~|z| of memory
if a.stableVar
    % Stable-variance kernels compute moments directly per permutation.
    sumZ = [];
    sumZ2 = [];
else
    % Fast kernels reuse pooled first/second moments.
    sumZ = sum(z,a.nan);
    sumZ2 = sum(z.^2,a.nan);
end

% Output requirements also determine whether streaming can be used.
a.needCI = nargout > 2;
a.needDist = nargout > 6;
a.needApproxCI = a.needCI && a.ciMode=="approx";
a.stream = a.stream && ~a.needDist && (~a.needCI || a.needApproxCI);

% TFCE setup (validate spatial dims, force CPU since bwconncomp is CPU-only).
if a.correct=="tfce"
    if a.mat
        error("[ec_permuttest2] correct=""tfce"" is incompatible with pairwise comparison.")
    end
    spatialDimsWasDefault = isempty(a.tfceDims);
    if spatialDimsWasDefault
        a.tfceDims = 1:numel(a.featureSize);
    elseif any(a.tfceDims>numel(a.featureSize)) || ~isequal(a.tfceDims,unique(a.tfceDims))
        error("[ec_permuttest2] a.tfceDims must be a unique subset of 1:%d.",numel(a.featureSize))
    end
    if a.parallel=="gpu"
        warning("[ec_permuttest2] TFCE requires CPU bwconncomp; falling back to parallel=""none"".")
        a.parallel = "none";
    end
    if a.useGroups
        warning("[ec_permuttest2] TFCE+grouped runs CPU-only (bwconncomp is CPU-only and grouped permutations don't use GPU).")
    end
    if spatialDimsWasDefault && numel(a.featureSize)>=2
        warning("[ec_permuttest2] TFCE spatial neighborhood defaulted to all featureSize dims [%s]. " + ...
            "For the standard iEEG layout [obs x time x channel] or [obs x time x channel x freq], " + ...
            "channels are typically independent observations (no implicit grid adjacency); " + ...
            "set a.tfceDims=[1] (time only) or [1 3] (time+freq, channel as panels) explicitly.", ...
            num2str(a.featureSize))
    end
    if ~a.stream
        warning("[ec_permuttest2] TFCE without streaming holds the full [nPerm x nVar] t-stat block in memory; consider stream=true.")
    end
    a.tfceOpts = struct("E",a.tfceE,"H",a.tfceH,"dh",a.tfceDh,...
        "conn",a.tfceConn,"spatialDims",a.tfceDims,...
        "voxelWeights",a.tfceVoxelWeights);
end

% Selection-matmul path avoids the [nObsXMax x bPerms x nVar] gather intermediate.
% NaNs are handled by zeroing them in z after sumZ/sumZ2 are computed, so A*z
% gives the same result as sum(x1,1,"omitmissing"). Now applies to grouped
% path too (the kernel is selection-matrix-based so it works for any idx1).
a.useMatmul = ~a.stableVar && double(a.nObsXMax)*double(a.nVar) > a.matmulThresh;
if a.useMatmul && a.nan=="omitmissing"
    z(isnan(z)) = 0;
end

% Generate permutation blocks (saves memory by running blocks)
rng(a.seed);
if a.blockMemFrac==0 && a.nBlocks<=0
    error("[ec_permuttest2] blockMemFrac=0 disables auto block sizing; set nBlocks>0 explicitly.")
end
if a.nBlocks>0
    a.bPerms = max(1,ceil(a.nPerm/a.nBlocks));
    if a.verbose
        fprintf("[ec_permuttest2] Using explicit nBlocks=%d (bPerms=%d)\n",...
            a.nBlocks,a.bPerms);
    end
else
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
            fprintf("[ec_permuttest2] Auto blockElMax=%d (%.0f%% memory fraction)\n",...
                a.blockElMax,100*a.blockMemFrac);
        end
    end
    bPermsByBlockEl = max(1,floor(a.blockElMax/a.nObsTot));
    bPermsByMem = estimateBlockPermCap_lfn(a);
    a.bPerms = min([bPermsByBlockEl,bPermsByMem,a.nPerm]);
    if a.verbose
        fprintf("[ec_permuttest2] bPerms caps -> blockEl:%d, memory:%d, final:%d\n",...
            bPermsByBlockEl,bPermsByMem,a.bPerms);
    end
end
bStarts = 1:a.bPerms:a.nPerm;
nBlocks = numel(bStarts);
bEnds = min(bStarts+a.bPerms-1,a.nPerm);
bSeeds = double(randi(intmax("uint32"),nBlocks,1,"uint32"));
if a.verbose
    fprintf("[ec_permuttest2] Number of permutation blocks: %d\n",nBlocks);
end

% Check parallelization
if a.parallel=="cpu"
    nCores = feature("numcores");
    if nBlocks < ceil(nCores/2)
        fprintf("[ec_permuttest2] Less permutation blocks than cores, avoiding parfor; implicit BLAS/LAPACK multithreading likely faster\n");
        a.parallel = "none";
    end
elseif a.parallel=="gpu"
    if a.useGroups
        warning("[ec_permuttest2] Group-constrained permutations are run on CPU.");
        a.parallel = "none";
    else
        z = gpuArray(z);
    end
end

% Cache z.^2 once per call for the matmul kernel (after possible GPU move so
% it lives on the same device as z). Avoids recomputing per block.
if a.useMatmul
    a.z2 = z.^2;
else
    a.z2 = [];
end

% Preallocate distances from mean (per block)
if a.stream
    % Stream per-block statistics instead of storing full permutation dist.
    dist = [];
    nSeen = 0;
    if a.correct=="max"
        % Keep one tail-extremal null value per permutation; sort once later.
        dist = zeros(a.nPerm,1,a.floatType);
    elseif a.correct=="tfce"
        % Same shape as max: one max-TFCE value per permutation.
        dist = zeros(a.nPerm,1,a.floatType);
        if a.needApproxCI
            % TFCE uses uncorrected per-feature CI; collect null moments too.
            nullSum = zeros(1,a.nVar,a.floatType);
            nullSumSq = zeros(1,a.nVar,a.floatType);
        end
    else
        countExt = zeros(1,a.nVar,a.floatType);
        if a.needApproxCI
            nullSum = zeros(1,a.nVar,a.floatType);
            nullSumSq = zeros(1,a.nVar,a.floatType);
        end
    end
else
    if a.parallel=="cpu"
        dist = cell(nBlocks,1);
    else
        if a.parallel=="gpu" && a.gather=="final"
            dist = [];
        else
            dist = zeros(a.nPerm,a.nVar,a.floatType);
        end
    end
end


%% Permutation stats
if a.stream
    if a.correct=="max"
        if a.parallel=="cpu"
            blkDist = cell(nBlocks,1);
            blkN = zeros(nBlocks,1);
            parfor b = 1:nBlocks
                bDist = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a);
                blkDist{b} = blockTailExtreme_lfn(bDist,a);
                blkN(b) = numel(blkDist{b});
            end
            dist = cell2mat(blkDist);
            nSeen = sum(blkN);
        else
            for b = 1:nBlocks
                bDist = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a);
                d1 = blockTailExtreme_lfn(bDist,a);
                if isa(d1,"gpuArray")
                    d1 = gather(d1);
                end
                dist(bStarts(b):bEnds(b)) = d1;
                nSeen = nSeen + numel(d1);
            end
        end
    elseif a.correct=="tfce"
        % Per permutation: signed TFCE map -> tail-aware extremum (one column);
        % optionally accumulate per-feature null moments for approx (uncorrected) CI.
        if a.parallel=="cpu"
            blkDist = cell(nBlocks,1);
            blkN = zeros(nBlocks,1);
            blkSum = []; blkSumSq = [];
            if a.needApproxCI
                blkSum   = zeros(nBlocks,a.nVar,a.floatType);
                blkSumSq = zeros(nBlocks,a.nVar,a.floatType);
            end
            parfor b = 1:nBlocks
                bDist = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a);
                blkDist{b} = blockTfceMax_lfn(bDist,a);
                blkN(b) = size(bDist,1);
                if a.needApproxCI
                    blkSum(b,:)   = sum(bDist,1);
                    blkSumSq(b,:) = sum(bDist.^2,1);
                end
            end
            dist = cell2mat(blkDist);
            nSeen = sum(blkN);
            if a.needApproxCI
                nullSum   = sum(blkSum,1);
                nullSumSq = sum(blkSumSq,1);
            end
        else
            for b = 1:nBlocks
                bDist = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a);
                d1 = blockTfceMax_lfn(bDist,a);
                dist(bStarts(b):bEnds(b)) = d1;
                nSeen = nSeen + numel(d1);
                if a.needApproxCI
                    nullSum   = nullSum   + sum(bDist,1);
                    nullSumSq = nullSumSq + sum(bDist.^2,1);
                end
            end
        end
    else
        if a.parallel=="cpu"
            blkCount = zeros(nBlocks,a.nVar,a.floatType);
            blkN = zeros(nBlocks,1);
            blkSum = [];
            blkSumSq = [];
            if a.needApproxCI
                blkSum = zeros(nBlocks,a.nVar,a.floatType);
                blkSumSq = zeros(nBlocks,a.nVar,a.floatType);
            end
            parfor b = 1:nBlocks
                bDist = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a);
                [cnt,s,ssq] = streamBlockReduce_lfn(bDist,t,a);
                blkCount(b,:) = cnt;
                blkN(b) = size(bDist,1);
                if a.needApproxCI
                    blkSum(b,:) = s;
                    blkSumSq(b,:) = ssq;
                end
            end
            countExt = sum(blkCount,1);
            nSeen = sum(blkN);
            if a.needApproxCI
                nullSum = sum(blkSum,1);
                nullSumSq = sum(blkSumSq,1);
            end
        else
            for b = 1:nBlocks
                bDist = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a);
                nSeen = nSeen + size(bDist,1);
                [cnt,s,ssq] = streamBlockReduce_lfn(bDist,t,a);
                if isa(cnt,"gpuArray")
                    cnt = gather(cnt);
                    if a.needApproxCI
                        s = gather(s);
                        ssq = gather(ssq);
                    end
                end
                countExt = countExt + cnt;
                if a.needApproxCI
                    nullSum   = nullSum   + s;
                    nullSumSq = nullSumSq + ssq;
                end
            end
        end
    end
else
    if a.parallel=="cpu"
        % CPU parallel loop over permute blocks
        parfor b = 1:nBlocks
            dist{b} = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a);
        end
        dist = cell2mat(dist);
    else
        % Preallocate distances in GPU
        if a.parallel=="gpu" && a.gather=="final"
            dist = zeros(a.nPerm,a.nVar,"like",z);end

        % CPU/GPU normal loop over permute blocks
        for b = 1:nBlocks
            dist(bStarts(b):bEnds(b),:) = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a);
        end

        % Gather distances from GPU
        if a.parallel=="gpu" && a.gather=="final"
            dist = gather(dist); end
    end
end


%% Final stats
if a.stream
    if a.verbose
        fprintf("[ec_permuttest2] Streaming reductions complete over %d permutations.\n",nSeen);
    end
    switch a.correct
        case "max"
            d = sort(dist(~isnan(dist)));
            switch a.tail
                case "both"
                    countExt = countGE_lfn_sorted(d,abs(t));
                case "right"
                    countExt = countGE_lfn_sorted(d,t);
                case "left"
                    countExt = countLE_lfn_sorted(d,t);
            end
            p = (countExt + 1) / (nSeen + 1);
            if a.needApproxCI
                switch a.tail
                    case "both"
                        critLo = prctile(d,100*(a.alpha/2));
                        critHi = prctile(d,100*(1-a.alpha/2));
                        ci = [mu-critHi.*se;mu-critLo.*se];
                    case "right"
                        crit = prctile(d,100*(1-a.alpha)).*se;
                        ci = [mu-crit;Inf(1,a.nVar)];
                    case "left"
                        crit = prctile(d,100*a.alpha).*se;
                        ci = [-Inf(1,a.nVar);mu-crit];
                end
            elseif a.needCI
                error("[ec_permuttest2] Exact CI requested in streaming mode. Use ciMode='approx' or disable streaming.");
            end
        case "tfce"
            % Null distribution is [nPerm x 1] of max-TFCE; comparator is the
            % TFCE-enhanced observed t-map (signed). The raw t output is
            % overwritten with this so the 1st output IS the inference
            % statistic (avoids forcing nargout>=8 to retrieve it, which
            % would disable streaming). CI under TFCE is uncorrected
            % (normal approx from per-feature null moments).
            t = ec_tfce(t(:),a.featureSize,E=a.tfceOpts.E,H=a.tfceOpts.H,dh=a.tfceOpts.dh,conn=a.tfceOpts.conn,spatialDims=a.tfceOpts.spatialDims,voxelWeights=a.tfceOpts.voxelWeights).';   % [1 x nVar] (overwrites raw t)
            d = sort(dist(~isnan(dist)));
            switch a.tail
                case "both"
                    countExt = countGE_lfn_sorted(d,abs(t));
                case "right"
                    countExt = countGE_lfn_sorted(d,t);
                case "left"
                    countExt = countLE_lfn_sorted(d,t);
            end
            p = (countExt + 1) / (nSeen + 1);
            if a.needApproxCI
                nullMu = nullSum ./ nSeen;
                nullVar = max(0, nullSumSq ./ nSeen - nullMu.^2);
                nullSd = sqrt(nullVar);
                switch a.tail
                    case "both"
                        qLo = normInv_lfn(a.alpha/2, nullMu, nullSd);
                        qHi = normInv_lfn(1-a.alpha/2, nullMu, nullSd);
                        ci = [mu-qHi.*se; mu-qLo.*se];
                    case "right"
                        q = normInv_lfn(1-a.alpha, nullMu, nullSd);
                        ci = [mu-q.*se; Inf(1,a.nVar)];
                    case "left"
                        q = normInv_lfn(a.alpha, nullMu, nullSd);
                        ci = [-Inf(1,a.nVar); mu-q.*se];
                end
            elseif a.needCI
                error("[ec_permuttest2] Exact CI requested in streaming mode. Use ciMode='approx' or disable streaming.");
            end
        case "none"
            p = (countExt + 1) / (nSeen + 1);
            if a.needApproxCI
                nullMu = nullSum ./ nSeen;
                nullVar = max(0, nullSumSq ./ nSeen - nullMu.^2);
                nullSd = sqrt(nullVar);
                switch a.tail
                    case "both"
                        qLo = normInv_lfn(a.alpha/2, nullMu, nullSd);
                        qHi = normInv_lfn(1-a.alpha/2, nullMu, nullSd);
                        ci = [mu-qHi.*se; mu-qLo.*se];
                    case "right"
                        q = normInv_lfn(1-a.alpha, nullMu, nullSd);
                        ci = [mu-q.*se; Inf(1,a.nVar)];
                    case "left"
                        q = normInv_lfn(a.alpha, nullMu, nullSd);
                        ci = [-Inf(1,a.nVar); mu-q.*se];
                end
            elseif a.needCI
                error("[ec_permuttest2] Exact CI requested in streaming mode. Use ciMode='approx' or disable streaming.");
            end
    end
else
    % Non-streaming: dist is the full [nPerm x nVar] t-stat distribution.
    % Preserve it for TFCE's uncorrected CI before tail-collapse.
    distOrig = [];
    if a.correct=="tfce" && a.needCI
        distOrig = dist;
    end
    % Apply tail-aware extremal collapse (max-stat or TFCE).
    if a.correct=="max"
        switch a.tail
            case "both"
                [~,idx] = max(abs(dist),[],2);
                csvar = [0;cumsum(ones(a.nPerm-1,1)*a.nVar)];
                dist = dist';
                dist = dist(idx+csvar);
            case "right"
                dist = max(dist,[],2);
            case "left"
                dist = min(dist,[],2);
        end
    elseif a.correct=="tfce"
        tfceCols = ec_tfce(dist.',a.featureSize,E=a.tfceOpts.E,H=a.tfceOpts.H,dh=a.tfceOpts.dh,conn=a.tfceOpts.conn,spatialDims=a.tfceOpts.spatialDims,voxelWeights=a.tfceOpts.voxelWeights);   % [nVar x nPerm] signed
        switch a.tail
            case "both";  dist = max(abs(tfceCols),[],1).';
            case "right"; dist = max(tfceCols,[],1).';
            case "left";  dist = min(tfceCols,[],1).';
        end
        % Overwrite raw t with observed TFCE map; this becomes the inference statistic.
        t = ec_tfce(t(:),a.featureSize,E=a.tfceOpts.E,H=a.tfceOpts.H,dh=a.tfceOpts.dh,conn=a.tfceOpts.conn,spatialDims=a.tfceOpts.spatialDims,voxelWeights=a.tfceOpts.voxelWeights).';   % [1 x nVar] observed
    end
    if a.verbose
        fprintf("[ec_permuttest2] Number of effective permutations: %d\n",a.nPerm)
    end

    % Compute p-value & CI
    if a.verbose
        switch a.correct
            case "max";  fprintf("[ec_permuttest2] Computing max-corrected p-values (serial threshold counting)...\n");
            case "tfce"; fprintf("[ec_permuttest2] Computing TFCE-corrected p-values...\n");
            case "none"; fprintf("[ec_permuttest2] Computing uncorrected p-values/CI from full permutation distribution...\n");
        end
    end
    switch a.tail
        case "both"
            switch a.correct
                case "max";  p = (countGE_lfn(dist,abs(t))+1)/(a.nPerm+1);
                case "tfce"; p = (countGE_lfn(dist,abs(t))+1)/(a.nPerm+1);  % t is overwritten with TFCE map
                case "none"
                    tAbs = abs(t);
                    p = (sum((dist>=tAbs) | (dist<=-tAbs))+1)/(a.nPerm+1);
            end
            if nargout > 2
                if a.correct=="tfce"
                    critLo = prctile(distOrig,100*(a.alpha/2));
                    critHi = prctile(distOrig,100*(1-a.alpha/2));
                else
                    critLo = prctile(dist,100*(a.alpha/2));
                    critHi = prctile(dist,100*(1-a.alpha/2));
                end
                ci = [mu-critHi.*se;mu-critLo.*se];
            end
        case "right"
            switch a.correct
                case "max";  p = (countGE_lfn(dist,t)+1)/(a.nPerm+1);
                case "tfce"; p = (countGE_lfn(dist,t)+1)/(a.nPerm+1);  % t is overwritten with TFCE map
                case "none"; p = (sum(t<=dist)+1)/(a.nPerm+1);
            end
            if nargout > 2
                if a.correct=="tfce"
                    crit = prctile(distOrig,100*(1-a.alpha)).*se;
                else
                    crit = prctile(dist,100*(1-a.alpha)).*se;
                end
                ci = [mu-crit;Inf(1,a.nVar)];
            end
        case "left"
            switch a.correct
                case "max";  p = (countLE_lfn(dist,t)+1)/(a.nPerm+1);
                case "tfce"; p = (countLE_lfn(dist,t)+1)/(a.nPerm+1);  % t is overwritten with TFCE map
                case "none"; p = (sum(t>=dist)+1)/(a.nPerm+1);
            end
            if nargout > 2
                if a.correct=="tfce"
                    crit = prctile(distOrig,100*a.alpha).*se;
                else
                    crit = prctile(dist,100*a.alpha).*se;
                end
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
        se = ptvec2mat(se);
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
        se = reshape(se,outSize);
    end
    if a.needDist && a.correct=="none"
        dist = reshape(dist,[a.nPerm featureSize]);
    end
end



function bDist = runBlock_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a)
%%% Permutation block %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if a.parallel=="gpu"
    bDist = runBlock_gpu_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a);
elseif a.useGroups
    bDist = runBlock_cpu_grouped_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a);
else
    bDist = runBlock_cpu_ungrouped_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a);
end


function bDist = runBlock_gpu_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a)
nbPerms = bEnd-bStart+1;
parallel.gpu.rng(seed,"Philox4x32-10");
if a.useMatmul
    [~,idx1] = mink(rand(a.nObsTot,nbPerms,like=z),a.nObsXMax,1);
    idx1 = cast(idx1,a.idxType);
    bDist = blockDist_matmul_lfn(z,idx1,sumZ,sumZ2,a);
else
    [~,idx] = sort(rand(a.nObsTot,nbPerms,like=z),1);
    idx = cast(idx,a.idxType);
    bDist = blockDist_fromIdx_lfn(z,idx,sumZ,sumZ2,a);
end
if a.gather=="block"
    bDist = gather(bDist);
end


function bDist = runBlock_cpu_ungrouped_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a)
nbPerms = bEnd-bStart+1;
rs = RandStream("mt19937ar","Seed",seed);
if a.useMatmul
    [~,idx1] = mink(rand(rs,a.nObsTot,nbPerms,like=z),a.nObsXMax,1);
    idx1 = cast(idx1,a.idxType);
    bDist = blockDist_matmul_lfn(z,idx1,sumZ,sumZ2,a);
else
    [~,idx] = sort(rand(rs,a.nObsTot,nbPerms,like=z),1);
    idx = cast(idx,a.idxType);
    bDist = blockDist_fromIdx_lfn(z,idx,sumZ,sumZ2,a);
end


function bDist = runBlock_cpu_grouped_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a)
% Grouped permutation on CPU. Uses pre-cached a.xOffsets/a.yOffsets/a.nXPerGroup.
% When a.useMatmul, dispatches to the selection-matmul kernel (only the X-arm
% slice of idx is needed); otherwise uses the 3D-gather kernel.
nbPerms = bEnd-bStart+1;
rs = RandStream("mt19937ar","Seed",seed);
bDist = zeros(nbPerms,a.nVar,"like",z);

% Tile permutation columns to reduce grouped-path peak memory in parfor.
tilePerms = max(1,ceil(nbPerms/4));
for tpStart = 1:tilePerms:nbPerms
    tpEnd = min(tpStart+tilePerms-1,nbPerms);
    nt = tpEnd-tpStart+1;
    idx = zeros(a.nObsXMax+a.nObsYMax,nt,a.idxType);
    % Loop over groups (nExchGroups << nt): generate [ng x nt] rand,
    % sort each column for a uniform permutation, then fill idx.
    for gi = 1:a.nExchGroups
        rows = a.groupRows{gi};          % [ng x 1] absolute row indices into z
        ng   = numel(rows);
        nXg  = a.nXPerGroup(gi);
        [~,perm] = sort(rand(rs,ng,nt),1);  % [ng x nt] permutation indices
        pg = rows(perm);                    % [ng x nt] absolute row indices
        xR = a.xOffsets(gi)              + (1:nXg);
        yR = a.nObsXMax + a.yOffsets(gi) + (1:(ng-nXg));
        idx(xR,:) = pg(1:nXg,:);
        idx(yR,:) = pg(nXg+1:end,:);
    end
    if a.useMatmul
        bDist(tpStart:tpEnd,:) = blockDist_matmul_lfn(z,idx(1:a.nObsXMax,:),sumZ,sumZ2,a);
    else
        bDist(tpStart:tpEnd,:) = blockDist_fromIdx_lfn(z,idx,sumZ,sumZ2,a);
    end
end


function bDist = blockDist_matmul_lfn(z,idx1,sumZ,sumZ2,a)
% Selection-matmul path: idx1 is [nObsXMax x nbPerms] of X-arm row indices.
% Builds a [nbPerms x nObsTot] binary selection matrix and uses A*z (and
% A*a.z2) instead of a 3D gather, avoiding the [nObsXMax x nbPerms x nVar]
% intermediate. Works for both ungrouped (idx1 from mink) and grouped (idx1
% from group-constrained idx) permutation generation.
nbPerms = size(idx1,2);
A = zeros(nbPerms, a.nObsTot, like=z);
linIdx = (1:nbPerms) + (double(idx1)-1)*nbPerms;        % [nObsXMax x nbPerms], broadcast
A(linIdx(:)) = 1;                                       % [nbPerms x nObsTot]
sum1   = A * z;                                         % [nbPerms x nVar]
sumsq1 = A * a.z2;                                       % a.z2 cached once per call
sum2   = sumZ   - sum1;
sumsq2 = sumZ2  - sumsq1;
var1 = (sumsq1-(sum1.^2)./a.nObsX)./a.dfX;
var2 = (sumsq2-(sum2.^2)./a.nObsY)./a.dfY;
if a.vartype=="equal"
    se = sqrt((a.dfX.*var1+a.dfY.*var2)./a.df).*sqrt((a.nObsX+a.nObsY)./(a.nObsX.*a.nObsY));
else
    se = sqrt(var1./a.nObsX+var2./a.nObsY);
end
bDist = (sum1./a.nObsX-sum2./a.nObsY)./se;


function bDist = blockDist_fromIdx_lfn(z,idx,sumZ,sumZ2,a)
if a.stableVar
    if a.vartype=="equal"
        bDist = blockDist_equal_stable_lfn(z,idx,a);
    else
        bDist = blockDist_unequal_stable_lfn(z,idx,a);
    end
else
    if a.vartype=="equal"
        bDist = blockDist_equal_fast_lfn(z,idx,sumZ,sumZ2,a);
    else
        bDist = blockDist_unequal_fast_lfn(z,idx,sumZ,sumZ2,a);
    end
end


function bDist = blockDist_equal_fast_lfn(z,idx,sumZ,sumZ2,a)
[sum1,sum2,var1,var2] = blockMoments_fast_batch_lfn(z,idx,sumZ,sumZ2,a);
se = sqrt((a.dfX.*var1+a.dfY.*var2)./a.df).*...
    sqrt((a.nObsX+a.nObsY)./(a.nObsX.*a.nObsY));
bDist = (sum1./a.nObsX-sum2./a.nObsY)./se;


function bDist = blockDist_unequal_fast_lfn(z,idx,sumZ,sumZ2,a)
[sum1,sum2,var1,var2] = blockMoments_fast_batch_lfn(z,idx,sumZ,sumZ2,a);
se = sqrt(var1./a.nObsX+var2./a.nObsY);
bDist = (sum1./a.nObsX-sum2./a.nObsY)./se;


function bDist = blockDist_equal_stable_lfn(z,idx,a)
[sum1,sum2,var1,var2,n1,n2] = blockMoments_stable_batch_lfn(z,idx,a);
dfp = n1+n2-2;
se = sqrt(((n1-1).*var1+(n2-1).*var2)./dfp).*sqrt((n1+n2)./(n1.*n2));
bDist = (sum1./n1-sum2./n2)./se;


function bDist = blockDist_unequal_stable_lfn(z,idx,a)
[sum1,sum2,var1,var2,n1,n2] = blockMoments_stable_batch_lfn(z,idx,a);
se = sqrt(var1./n1+var2./n2);
bDist = (sum1./n1-sum2./n2)./se;


function [sum1,sum2,var1,var2] = blockMoments_fast_batch_lfn(z,idx,sumZ,sumZ2,a)
% Batch gather: x1 = z[idx(1:nObsXMax,:), :] -> [nObsXMax x nbPerms x nVar]
% All permutations processed together so BLAS sees large contiguous operations.
nbPerms = size(idx,2);
idx1 = idx(1:a.nObsXMax,:);                                    % [nObsXMax x nbPerms]
x1 = reshape(z(idx1(:),:), a.nObsXMax, nbPerms, a.nVar);       % [nObsXMax x nbPerms x nVar]
sum1   = reshape(sum(x1,    1, a.nan), nbPerms, a.nVar);        % [nbPerms x nVar]
sumsq1 = reshape(sum(x1.^2, 1, a.nan), nbPerms, a.nVar);
sum2   = sumZ   - sum1;                                         % broadcast [1 x nVar]
sumsq2 = sumZ2  - sumsq1;
var1 = (sumsq1-(sum1.^2)./a.nObsX)./a.dfX;
var2 = (sumsq2-(sum2.^2)./a.nObsY)./a.dfY;


function [sum1,sum2,var1,var2,n1,n2] = blockMoments_stable_batch_lfn(z,idx,a)
% Reshape to [nObs(X|Y)Max x nbPerms x nVar] for batched moment reductions.
nbPerms = size(idx,2);
idx1 = idx(1:a.nObsXMax,:);
idx2 = idx(a.nObsXMax+1:end,:);
x1 = reshape(z(idx1(:),:), a.nObsXMax, nbPerms, a.nVar);
x2 = reshape(z(idx2(:),:), a.nObsYMax, nbPerms, a.nVar);
sum1 = reshape(sum(x1, 1, a.nan), nbPerms, a.nVar);
sum2 = reshape(sum(x2, 1, a.nan), nbPerms, a.nVar);
if a.nan=="omitmissing"
    n1 = reshape(sum(~isnan(x1), 1), nbPerms, a.nVar);
    n2 = reshape(sum(~isnan(x2), 1), nbPerms, a.nVar);
    mu1 = reshape(sum1./n1, 1, nbPerms, a.nVar);
    mu2 = reshape(sum2./n2, 1, nbPerms, a.nVar);
    var1 = reshape(sum((x1-mu1).^2, 1, a.nan), nbPerms, a.nVar) ./ max(n1-1,1);
    var2 = reshape(sum((x2-mu2).^2, 1, a.nan), nbPerms, a.nVar) ./ max(n2-1,1);
    var1(n1<=1) = NaN;
    var2(n2<=1) = NaN;
else
    % Fixed counts: keep as scalars; downstream broadcasts naturally.
    n1 = a.nObsXMax;
    n2 = a.nObsYMax;
    mu1 = reshape(sum1./n1, 1, nbPerms, a.nVar);
    mu2 = reshape(sum2./n2, 1, nbPerms, a.nVar);
    var1 = reshape(sum((x1-mu1).^2, 1), nbPerms, a.nVar) ./ max(n1-1,1);
    var2 = reshape(sum((x2-mu2).^2, 1), nbPerms, a.nVar) ./ max(n2-1,1);
end


function [varX,varY] = observedVar_fast_lfn(x,y,sumX,sumY,a)
varX = (sum(x.^2,a.nan)-(sumX.^2)./a.nObsX)./a.dfX;
varY = (sum(y.^2,a.nan)-(sumY.^2)./a.nObsY)./a.dfY;


function [varX,varY] = observedVar_stable_lfn(x,y,sumX,sumY,a)
muX = sumX./a.nObsX;
muY = sumY./a.nObsY;
varX = sum((x-muX).^2,a.nan)./a.dfX;
varY = sum((y-muY).^2,a.nan)./a.dfY;


function c = countGE_lfn(nullDist,vals)
c = countCmp_lfn(nullDist,vals,true);


function c = countLE_lfn(nullDist,vals)
c = countCmp_lfn(nullDist,vals,false);


function c = countCmp_lfn(nullDist,vals,isGE)
d = nullDist(:);
d = sort(d(~isnan(d)));
n = numel(d);
v = vals(:);
ok = ~isnan(v);
[vSort,ord] = sort(v(ok));
okIdx = find(ok);
cSort = zeros(size(vSort),like=vals);
if isGE
    i = 1;
    for j = 1:numel(vSort)
        while i<=n && d(i)<vSort(j)
            i = i+1;
        end
        cSort(j) = n-i+1;
    end
else
    i = n;
    for j = numel(vSort):-1:1
        while i>=1 && d(i)>vSort(j)
            i = i-1;
        end
        cSort(j) = i;
    end
end
c = nan(size(v),like=vals);
c(okIdx(ord)) = cSort;
c = reshape(c,size(vals));


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


function d1 = blockTailExtreme_lfn(bDist,a)
switch a.tail
    case "both";  d1 = max(abs(bDist),[],2);
    case "right"; d1 = max(bDist,[],2);
    case "left";  d1 = min(bDist,[],2);
end


function d1 = blockTfceMax_lfn(bDist,a)
% Per-permutation: signed TFCE map -> tail-aware extremum -> [nbPerms x 1].
% bDist is [nbPerms x nVar]; transpose so each column is one permutation's
% flattened stat map for ec_tfce, then collapse spatially.
tfceCols = ec_tfce(bDist.',a.featureSize,E=a.tfceOpts.E,H=a.tfceOpts.H,dh=a.tfceOpts.dh,conn=a.tfceOpts.conn,spatialDims=a.tfceOpts.spatialDims,voxelWeights=a.tfceOpts.voxelWeights);   % [nVar x nbPerms] signed
switch a.tail
    case "both";  d1 = max(abs(tfceCols),[],1).';
    case "right"; d1 = max(tfceCols,[],1).';
    case "left";  d1 = min(tfceCols,[],1).';
end


function c = countGE_lfn_sorted(d,vals)
n = numel(d);
v = vals(:);
ok = ~isnan(v);
[vSort,ord] = sort(v(ok));
okIdx = find(ok);
cSort = zeros(size(vSort),like=vals);
i = 1;
for j = 1:numel(vSort)
    while i<=n && d(i)<vSort(j)
        i = i+1;
    end
    cSort(j) = n-i+1;
end
c = nan(size(v),like=vals);
c(okIdx(ord)) = cSort;
c = reshape(c,size(vals));


function c = countLE_lfn_sorted(d,vals)
n = numel(d);
v = vals(:);
ok = ~isnan(v);
[vSort,ord] = sort(v(ok));
okIdx = find(ok);
cSort = zeros(size(vSort),like=vals);
i = n;
for j = numel(vSort):-1:1
    while i>=1 && d(i)>vSort(j)
        i = i-1;
    end
    cSort(j) = i;
end
c = nan(size(v),like=vals);
c(okIdx(ord)) = cSort;
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
switch a.idxType
    case "double"
        bytesIdx = 8;
    case {"single","uint32"}
        bytesIdx = 4;
    case "uint16"
        bytesIdx = 2;
end

budgetBytes = max(0,double(a.ramAvail)*double(a.blockMemFrac));

% Fixed memory retained during permutation stage.
fixedBytes = 0;
% Full dist is retained only on the non-streaming path.
if ~a.stream
    fixedBytes = fixedBytes + double(a.nPerm)*double(a.nVar)*bytesFloat;
elseif a.correct~="none"
    % Streaming+corrected (max or tfce) retains one extremal value per permutation.
    fixedBytes = fixedBytes + double(a.nPerm)*bytesFloat;
end
% Concatenated sample matrix.
fixedBytes = fixedBytes + double(a.nObsTot)*double(a.nVar)*bytesFloat;
% Cached z.^2 (matmul path only).
if a.useMatmul
    fixedBytes = fixedBytes + double(a.nObsTot)*double(a.nVar)*bytesFloat;
end

% Per-permutation variable memory.
perPermBytes = 0;
% Index matrix (grouped builds full idx; ungrouped+matmul only builds idx1).
if a.useMatmul && ~a.useGroups
    perPermBytes = perPermBytes + double(a.nObsXMax)*bytesIdx;
else
    perPermBytes = perPermBytes + double(a.nObsTot)*bytesIdx;
end
% Block output rows.
perPermBytes = perPermBytes + double(a.nVar)*bytesFloat;
% Ungrouped paths build dense random-key matrices before sort/mink.
if ~a.useGroups
    perPermBytes = perPermBytes + double(a.nObsTot)*bytesFloat;
end

if a.useMatmul
    % Matmul path: A [nbPerms x nObsTot] selection matrix.
    perPermBytes = perPermBytes + double(a.nObsTot)*bytesFloat;
else
    % Gather intermediate [nObsXMax x bPerms x nVar] + element-wise temporary.
    if a.stableVar
        perPermBytes = perPermBytes + 2*double(a.nObsTot)*double(a.nVar)*bytesFloat;
    else
        perPermBytes = perPermBytes + 2*double(a.nObsXMax)*double(a.nVar)*bytesFloat;
    end
end

% Headroom for temporary workspaces/allocator effects.
safetyFactor = 1.5;
perPermBytes = perPermBytes * safetyFactor;

availForBlock = max(0,budgetBytes-fixedBytes);
if perPermBytes<=0
    bPerms = 1;
else
    bPerms = max(1,floor(availForBlock/perPermBytes));
end

