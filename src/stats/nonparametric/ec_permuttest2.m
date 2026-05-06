function [t,p,ci,mu,df,sd,dist] = ec_permuttest2(x,y,gx,gy,a)
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
%   - Added blockwise permutation engine for memory scaling (blockElMax, blockMemFrac).
%   - Added optional auto block sizing from available RAM/VRAM with upstream override (ramAvail).
%   - Added backend controls for CPU/GPU execution and GPU gather strategy.
%   - Added core-count heuristic to avoid inefficient parfor for too few blocks.
%   - Refactored block computation into mode-specialized local kernels (GPU, CPU grouped, CPU ungrouped).
%   - Reduced per-permutation data movement by reusing pooled sums/sumsq for fast moments.
%   - Added optional numerically stable variance path (stableVar) with separate fast/stable kernels.
%   - Added precision controls (floatType) and reduced grouped-index allocation churn.

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
    a.correct (1,1) logical = true % apply max-stat multiple-comparison correction
    a.rows string {mustBeMember(a.rows,["all","complete"])} = "all" % NaN row handling
    a.blockElMax (1,1) double {mustBeInteger,mustBeNonnegative} = 0 % maximum block elements (0=auto from available memory)
    a.nBlocks (1,1) double {mustBeInteger,mustBeNonnegative} = 0 % explicit number of permutation blocks (0=derive from blockElMax)
    a.blockMemFrac (1,1) double {mustBeGreaterThan(a.blockMemFrac,0),mustBeLessThan(a.blockMemFrac,1)} = 0.2 % Fraction of available memory to use within permute blocks (for auto blockElMax)
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
end
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
    a.groupRows = cell(a.nExchGroups,1);
    a.nXPerGroup = zeros(a.nExchGroups,1);
    for gi = 1:a.nExchGroups
        idxg = find(gAll==gi);
        a.groupRows{gi} = idxg;
        a.nXPerGroup(gi) = sum(idxg<=a.nObsXMax);
    end
    if a.verbose && any(a.nXPerGroup==0 | a.nXPerGroup==cellfun(@numel,a.groupRows))
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
        sd = sqrt((a.dfX.*varX+a.dfY.*varY)./df);
        se = sd.*sqrt(nObs./(a.nObsX.*a.nObsY));
    case "unequal"
        se2X = varX./a.nObsX;
        se2Y = varY./a.nObsY;
        df = (se2X+se2Y).^2./(se2X.^2./a.dfX+se2Y.^2./a.dfY);
        sd = sqrt([varX;varY]);
        se = sqrt(se2X+se2Y);
end

% Compute mean difference and test statistic
mu = sumX./a.nObsX - sumY./a.nObsY;
t = mu./se;

% Return if only t-value desired
if nargout==1; return; end


%% Permutation setup

% Concatenate samples for label shuffling
z = [x;y];
a.nObsTot = size(z,1);
if a.stableVar
    % Stable-variance kernels compute moments directly per permutation.
    sumZ = [];
    sumZ2 = [];
else
    % Fast kernels reuse pooled first/second moments.
    sumZ = sum(z,a.nan);
    sumZ2 = sum(z.^2,a.nan);
end

% Generate permutation blocks (saves memory by running blocks)
rng(a.seed);
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
bSeeds = randi(intmax("uint32"),nBlocks,1,"uint32");
if a.verbose
    disp("[ec_permuttest2] Number of permutation blocks: "+nBlocks); end

% Check parallelization
if a.parallel=="cpu"
    nCores = feature("numcores");
    if nBlocks < ceil(nCores/2)
        disp("[ec_permuttest2] Less permutation blocks than cores, avoiding parfor, "+...
            "implicit BLAS/LAPACK multithreading likely faster");
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

needCI = nargout > 2;
needDist = nargout > 6;
useStreaming = a.stream && ~needDist && (~needCI || a.ciMode=="approx");

% Preallocate distances from mean (per block)
if useStreaming
    % Stream per-block statistics instead of storing full permutation dist.
    dist = [];
    switch a.tail
        case "both"
            countExt = zeros(1,a.nVar);
        case "right"
            countExt = zeros(1,a.nVar);
        case "left"
            countExt = zeros(1,a.nVar);
    end
    if needCI && a.ciMode=="approx"
        if a.correct
            nullSum = 0;
            nullSumSq = 0;
        else
            nullSum = zeros(1,a.nVar);
            nullSumSq = zeros(1,a.nVar);
        end
    end
    nSeen = 0;
else
    if a.parallel=="cpu"
        dist = cell(nBlocks,1);
    else
        if a.parallel=="gpu" && a.gather=="final"
            dist = [];
        else
            dist = zeros(a.nPerm,a.nVar,"like",x);
        end
    end
end


%% Permutation stats
if useStreaming
    if a.parallel=="cpu"
        blkCount = cell(nBlocks,1);
        blkN    = zeros(nBlocks,1);
        blkSum   = cell(nBlocks,1);
        blkSumSq = cell(nBlocks,1);
        parfor b = 1:nBlocks
            bDist = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a,df);
            blkN(b) = size(bDist,1);
            [blkCount{b},blkSum{b},blkSumSq{b}] = streamBlockReduce_lfn(bDist,t,a,needCI);
        end
        nSeen    = nSeen    + sum(blkN);
        countExt = countExt + sum(vertcat(blkCount{:}),1);
        if needCI && a.ciMode=="approx"
            nullSum   = nullSum   + sum(vertcat(blkSum{:}),1);
            nullSumSq = nullSumSq + sum(vertcat(blkSumSq{:}),1);
        end
    else
        for b = 1:nBlocks
            bDist = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a,df);
            nSeen = nSeen + size(bDist,1);
            [cnt,s,ssq] = streamBlockReduce_lfn(bDist,t,a,needCI);
            countExt = countExt + cnt;
            if needCI && a.ciMode=="approx"
                nullSum   = nullSum   + s;
                nullSumSq = nullSumSq + ssq;
            end
        end
    end
else
    if a.parallel=="cpu"
        % CPU parallel loop over permute blocks
        parfor b = 1:nBlocks
            dist{b} = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a,df);
        end
        dist = vertcat(dist{:});
    else
        % Preallocate distances in GPU
        if a.parallel=="gpu" && a.gather=="final"
            dist = zeros(a.nPerm,a.nVar,"like",z);end

        % CPU/GPU normal loop over permute blocks
        for b = 1:nBlocks
            dist(bStarts(b):bEnds(b),:) = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a,df);
        end

        % Gather distances from GPU
        if a.parallel=="gpu" && a.gather=="final"
            dist = gather(dist); end
    end
end


%% Final stats
if useStreaming
    if a.verbose
        fprintf("[ec_permuttest2] Streaming reductions complete over %d permutations.\n",nSeen);
    end
    p = (countExt + 1) / (nSeen + 1);
    if needCI && a.ciMode=="approx"
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
    elseif needCI
        error("[ec_permuttest2] Exact CI requested in streaming mode. Use ciMode='approx' or disable streaming.");
    end
else
    % Apply max correction if specified
    if a.correct
        [~,idx] = max(abs(dist),[],2);
        csvar = [0;cumsum(ones(a.nPerm-1,1)*a.nVar)];
        dist = dist';
        dist = dist(idx+csvar);
    end
    if a.verbose
        fprintf("Number of effective permutations: %d\n",a.nPerm)
    end

    % Compute p-value & CI
    if a.verbose
        if a.correct
            fprintf("[ec_permuttest2] Computing max-corrected p-values (serial threshold counting)...\n");
        else
            fprintf("[ec_permuttest2] Computing uncorrected p-values/CI from full permutation distribution...\n");
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
                critLo = prctile(dist,100*(a.alpha/2));
                critHi = prctile(dist,100*(1-a.alpha/2));
                ci = [mu-critHi.*se;mu-critLo.*se];
            end
        case "right"
            if a.correct
                p = (countGE_lfn(dist,t)+1)/(a.nPerm+1);
            else
                p = (sum(t<=dist)+1)/(a.nPerm+1);
            end
            if nargout > 2
                crit = prctile(dist,100*(1-a.alpha)).*se;
                ci = [mu-crit;Inf(1,a.nVar)];
            end
        case "left"
            if a.correct
                p = (countLE_lfn(dist,t)+1)/(a.nPerm+1);
            else
                p = (sum(t>=dist)+1)/(a.nPerm+1);
            end
            if nargout > 2
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
        if size(sd,1)==2
            sd1 = ptvec2mat(sd(1,:));
            sd2 = ptvec2mat(sd(2,:));
            sd = cat(3,sd1,sd2);
            sd = permute(sd,[3,1,2]);
        else
            sd = ptvec2mat(sd);
        end
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
        if size(sd,1)==2
            sd = reshape(sd,[2 featureSize]);
        else
            sd = reshape(sd,outSize);
        end
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





function bDist = runBlock_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a,df)
%%% Permutation block %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if a.parallel=="gpu"
    bDist = runBlock_gpu_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a,df);
elseif a.useGroups
    bDist = runBlock_cpu_grouped_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a,df);
else
    bDist = runBlock_cpu_ungrouped_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a,df);
end


function bDist = runBlock_gpu_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a,df)
nbPerms = bEnd-bStart+1;
parallel.gpu.rng(double(seed),"Philox4x32-10");
[~,idx] = sort(rand(a.nObsTot,nbPerms,like=z),1);
bDist = blockDist_fromIdx_lfn(z,idx,sumZ,sumZ2,a,df);
if a.gather=="block"
    bDist = gather(bDist);
end


function bDist = runBlock_cpu_ungrouped_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a,df)
nbPerms = bEnd-bStart+1;
rs = RandStream("mt19937ar","Seed",double(seed));
[~,idx] = sort(rand(rs,a.nObsTot,nbPerms,like=z),1);
bDist = blockDist_fromIdx_lfn(z,idx,sumZ,sumZ2,a,df);


function bDist = runBlock_cpu_grouped_lfn(z,sumZ,sumZ2,bStart,bEnd,seed,a,df)
% Grouped permutation on CPU
nbPerms = bEnd-bStart+1;
rs = RandStream("mt19937ar","Seed",double(seed));
idx = zeros(a.nObsTot,nbPerms,a.idxType);

% Cumulative offsets so each group can fill its slice of idx without a k-loop.
nYPerGroup = cellfun(@numel,a.groupRows,"UniformOutput",true) - a.nXPerGroup;
xOffsets = [0; cumsum(a.nXPerGroup(1:end-1))];
yOffsets = [0; cumsum(nYPerGroup(1:end-1))];

% Loop over groups (nExchGroups << nbPerms): generate [ng x nbPerms] rand,
% sort each column for a uniform permutation, then fill idx in one shot.
for gi = 1:a.nExchGroups
    rows = a.groupRows{gi};          % [ng x 1] absolute row indices into z
    ng   = numel(rows);
    nXg  = a.nXPerGroup(gi);
    nYg  = ng - nXg;
    [~,perm] = sort(rand(rs,ng,nbPerms),1);  % [ng x nbPerms] permutation indices
    pg = rows(perm);                          % [ng x nbPerms] absolute row indices
    xR = xOffsets(gi)          + (1:nXg);
    yR = a.nObsXMax+yOffsets(gi) + (1:nYg);
    idx(xR,:) = pg(1:nXg,:);
    idx(yR,:) = pg(nXg+1:end,:);
end
bDist = blockDist_fromIdx_lfn(z,idx,sumZ,sumZ2,a,df);


function bDist = blockDist_fromIdx_lfn(z,idx,sumZ,sumZ2,a,df)
%nbPerms = size(idx,2);
if a.stableVar
    if a.vartype=="equal"
        bDist = blockDist_equal_stable_lfn(z,idx,a);
    else
        bDist = blockDist_unequal_stable_lfn(z,idx,a);
    end
else
    if a.vartype=="equal"
        bDist = blockDist_equal_fast_lfn(z,idx,sumZ,sumZ2,a,df);
    else
        bDist = blockDist_unequal_fast_lfn(z,idx,sumZ,sumZ2,a);
    end
end


function bDist = blockDist_equal_fast_lfn(z,idx,sumZ,sumZ2,a,df)
[sum1,sum2,var1,var2] = blockMoments_fast_batch_lfn(z,idx,sumZ,sumZ2,a);
se = sqrt((a.dfX.*var1+a.dfY.*var2)./df).*...
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
nbPerms = size(idx,2);
idx1 = idx(1:a.nObsXMax,:);
idx2 = idx(a.nObsXMax+1:end,:);
x1 = reshape(z(idx1(:),:), a.nObsXMax, nbPerms, a.nVar);       % [nObsXMax x nbPerms x nVar]
x2 = reshape(z(idx2(:),:), a.nObsYMax, nbPerms, a.nVar);       % [nObsYMax x nbPerms x nVar]
sum1 = reshape(sum(x1, 1, a.nan), nbPerms, a.nVar);             % [nbPerms x nVar]
sum2 = reshape(sum(x2, 1, a.nan), nbPerms, a.nVar);
if a.nan=="omitmissing"
    n1 = reshape(sum(~isnan(x1), 1), nbPerms, a.nVar);
    n2 = reshape(sum(~isnan(x2), 1), nbPerms, a.nVar);
else
    n1 = repmat(a.nObsXMax, nbPerms, a.nVar);
    n2 = repmat(a.nObsYMax, nbPerms, a.nVar);
end
mu1 = reshape(sum1./n1, 1, nbPerms, a.nVar);                    % [1 x nbPerms x nVar] for broadcast
mu2 = reshape(sum2./n2, 1, nbPerms, a.nVar);
var1 = reshape(sum((x1-mu1).^2, 1, a.nan), nbPerms, a.nVar) ./ max(n1-1,1);
var2 = reshape(sum((x2-mu2).^2, 1, a.nan), nbPerms, a.nVar) ./ max(n2-1,1);
var1(n1<=1) = NaN;
var2(n2<=1) = NaN;


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
d = sort(nullDist(:));
n = numel(d);
v = vals(:);
[vSort,ord] = sort(v);
cSort = zeros(size(vSort));
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
c = zeros(size(v));
c(ord) = cSort;
c = reshape(c,size(vals));


function [cnt,blkSum,blkSumSq] = streamBlockReduce_lfn(bDist,t,a,needCI)
% Per-block streaming reduction shared by the parfor and for loops.
% When a.correct, computes d1=max(|bDist|,[],2) once and reuses it for
% both the extremal count and the optional approx-CI running moments.
if a.correct
    d1 = max(abs(bDist),[],2);
    switch a.tail
        case "both";  cnt = countGE_lfn(d1,abs(t));
        case "right"; cnt = countGE_lfn(d1,t);
        case "left";  cnt = countLE_lfn(d1,t);
    end
    if needCI && a.ciMode=="approx"
        blkSum   = sum(d1,1);
        blkSumSq = sum(d1.^2,1);
    else
        blkSum = []; blkSumSq = [];
    end
else
    switch a.tail
        case "both";  cnt = sum((bDist>=abs(t)) | (bDist<=-abs(t)),1);
        case "right"; cnt = sum(bDist>=t,1);
        case "left";  cnt = sum(bDist<=t,1);
    end
    if needCI && a.ciMode=="approx"
        blkSum   = sum(bDist,1);
        blkSumSq = sum(bDist.^2,1);
    else
        blkSum = []; blkSumSq = [];
    end
end


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
    case "uint32"
        bytesIdx = 4;
end

budgetBytes = max(0,double(a.ramAvail)*double(a.blockMemFrac));

% Fixed memory retained during permutation stage.
fixedBytes = 0;
% Full dist is retained in current non-streaming design.
fixedBytes = fixedBytes + double(a.nPerm)*double(a.nVar)*bytesFloat;
% Concatenated sample matrix.
fixedBytes = fixedBytes + double(a.nObsTot)*double(a.nVar)*bytesFloat;

% Per-permutation variable memory.
perPermBytes = 0;
% Index matrix (grouped/ungrouped).
perPermBytes = perPermBytes + double(a.nObsTot)*bytesIdx;
% Block output rows.
perPermBytes = perPermBytes + double(a.nVar)*bytesFloat;
% Ungrouped paths build dense random-key matrices before sort.
if ~a.useGroups
    perPermBytes = perPermBytes + double(a.nObsTot)*bytesFloat;
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

