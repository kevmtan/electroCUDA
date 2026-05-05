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
    a.blockMemFrac (1,1) double {mustBeGreaterThan(a.blockMemFrac,0),mustBeLessThan(a.blockMemFrac,1)} = 0.2 % Fraction of available memory to use within permute blocks (for auto blockElMax)
    a.parallel {mustBeMember(a.parallel,["none" "gpu" "cpu" ""])} = "none" % execution backend (CPU not worth it)
    a.ramAvail (1,1) double = nan % available RAM/VRAM bytes (override upstream if needed)
    a.mat (1,1) logical = false % return pairwise results as square matrices
    a.gather string {mustBeMember(a.gather,["block","final"])} = "block" % GPU gather strategy
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
sumZ = sum(z,a.nan);
sumZ2 = sum(z.^2,a.nan);

% Generate permutation blocks (saves memory by running blocks)
rng(a.seed);
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
a.bPerms = max(1,floor(a.blockElMax/a.nObsTot));
a.bPerms = min(a.bPerms,a.nPerm);
bStarts = 1:a.bPerms:a.nPerm;
nBlocks = numel(bStarts);
bEnds = min(bStarts+a.bPerms-1,a.nPerm);
bSeeds = randi(intmax("uint32"),nBlocks,1,"uint32");
if a.verbose
    disp("[ec_permuttest2] Number of permutation blocks: "+nBlocks); end

% Check parallelization
if a.parallel=="cpu"
    nCores = feature("numcores");
    if nBlocks < nCores
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

% Preallocate distances from mean (per block)
if a.parallel=="cpu"
    dist = cell(nBlocks,1);
else
    if a.parallel=="gpu" && a.gather=="final"
        dist = [];
    else
        dist = zeros(a.nPerm,a.nVar,"like",x);
    end
end


%% Permutation stats
if a.parallel=="cpu"
    parfor b = 1:nBlocks
        dist{b} = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a,df);
    end
    dist = vertcat(dist{:});
else
    if a.parallel=="gpu" && a.gather=="final"
        dist = zeros(a.nPerm,a.nVar,"like",z);
    end
    for b = 1:nBlocks
        dist(bStarts(b):bEnds(b),:) = runBlock_lfn(z,sumZ,sumZ2,bStarts(b),bEnds(b),bSeeds(b),a,df);
    end
    if a.parallel=="gpu" && a.gather=="final"
        dist = gather(dist);
    end
end


%% Final stats
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
switch a.tail
    case "both"
        pdabs = abs(dist);
        p = (sum(abs(t)<=pdabs)+1)/(a.nPerm+1);
        if nargout > 2
            critLo = prctile(dist,100*(a.alpha/2));
            critHi = prctile(dist,100*(1-a.alpha/2));
            ci = [mu-critHi.*se;mu-critLo.*se];
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
            crit = prctile(dist,100*a.alpha).*se;
            ci = [-Inf(1,a.nVar);mu-crit];
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
nbPerms = bEnd-bStart+1;
rs = RandStream("mt19937ar","Seed",double(seed));
idx = zeros(a.nObsTot,nbPerms,"uint32");
xFill = zeros(a.nObsXMax,1,"uint32");
yFill = zeros(a.nObsYMax,1,"uint32");
groupRows = cell(a.nExchGroups,1);
for gi = 1:a.nExchGroups
    groupRows{gi} = uint32(a.groupRows{gi});
end
for k = 1:nbPerms
    cx = 0;
    cy = 0;
    for gi = 1:a.nExchGroups
        rows = groupRows{gi};
        ng = numel(rows);
        nXg = a.nXPerGroup(gi);
        pg = rows(randperm(rs,ng));
        xFill(cx+1:cx+nXg) = pg(1:nXg);
        yFill(cy+1:cy+ng-nXg) = pg(nXg+1:end);
        cx = cx+nXg;
        cy = cy+ng-nXg;
    end
    idx(1:a.nObsXMax,k) = xFill;
    idx(a.nObsXMax+1:end,k) = yFill;
end
bDist = blockDist_fromIdx_lfn(z,idx,sumZ,sumZ2,a,df);


function bDist = blockDist_fromIdx_lfn(z,idx,sumZ,sumZ2,a,df)
nbPerms = size(idx,2);
bDist = zeros(nbPerms,a.nVar,"like",z);
if a.stableVar
    if a.vartype=="equal"
        bDist = blockDist_equal_stable_lfn(z,idx,a,df,bDist);
    else
        bDist = blockDist_unequal_stable_lfn(z,idx,a,bDist);
    end
else
    if a.vartype=="equal"
        bDist = blockDist_equal_fast_lfn(z,idx,sumZ,sumZ2,a,df,bDist);
    else
        bDist = blockDist_unequal_fast_lfn(z,idx,sumZ,sumZ2,a,bDist);
    end
end


function bDist = blockDist_equal_fast_lfn(z,idx,sumZ,sumZ2,a,df,bDist)
for k = 1:size(idx,2)
    [sum1,sum2,var1,var2] = blockMoments_fast_lfn(z,idx(:,k),sumZ,sumZ2,a);
    se = sqrt((a.dfX.*var1+a.dfY.*var2)./df).*...
        sqrt((a.nObsX+a.nObsY)./(a.nObsX.*a.nObsY));
    bDist(k,:) = (sum1./a.nObsX-sum2./a.nObsY)./se;
end


function bDist = blockDist_unequal_fast_lfn(z,idx,sumZ,sumZ2,a,bDist)
for k = 1:size(idx,2)
    [sum1,sum2,var1,var2] = blockMoments_fast_lfn(z,idx(:,k),sumZ,sumZ2,a);
    se = sqrt(var1./a.nObsX+var2./a.nObsY);
    bDist(k,:) = (sum1./a.nObsX-sum2./a.nObsY)./se;
end


function bDist = blockDist_equal_stable_lfn(z,idx,a,df,bDist)
for k = 1:size(idx,2)
    [sum1,sum2,var1,var2,n1,n2] = blockMoments_stable_lfn(z,idx(:,k),a);
    dfp = n1+n2-2;
    se = sqrt(((n1-1).*var1+(n2-1).*var2)./dfp).*...
        sqrt((n1+n2)./(n1.*n2));
    bDist(k,:) = (sum1./n1-sum2./n2)./se;
end


function bDist = blockDist_unequal_stable_lfn(z,idx,a,bDist)
for k = 1:size(idx,2)
    [sum1,sum2,var1,var2,n1,n2] = blockMoments_stable_lfn(z,idx(:,k),a);
    se = sqrt(var1./n1+var2./n2);
    bDist(k,:) = (sum1./n1-sum2./n2)./se;
end


function [sum1,sum2,var1,var2] = blockMoments_fast_lfn(z,idxCol,sumZ,sumZ2,a)
x1 = z(idxCol(1:a.nObsXMax),:);
sum1 = sum(x1,a.nan);
sum2 = sumZ-sum1;
sumsq1 = sum(x1.^2,a.nan);
sumsq2 = sumZ2-sumsq1;
var1 = (sumsq1-(sum1.^2)./a.nObsX)./a.dfX;
var2 = (sumsq2-(sum2.^2)./a.nObsY)./a.dfY;


function [sum1,sum2,var1,var2,n1,n2] = blockMoments_stable_lfn(z,idxCol,a)
x1 = z(idxCol(1:a.nObsXMax),:);
x2 = z(idxCol(a.nObsXMax+1:end),:);
sum1 = sum(x1,a.nan);
sum2 = sum(x2,a.nan);
if a.nan=="omitmissing"
    n1 = sum(~isnan(x1),1);
    n2 = sum(~isnan(x2),1);
else
    n1 = repmat(a.nObsXMax,1,a.nVar);
    n2 = repmat(a.nObsYMax,1,a.nVar);
end
mu1 = sum1./n1;
mu2 = sum2./n2;
var1 = sum((x1-mu1).^2,a.nan)./max(n1-1,1);
var2 = sum((x2-mu2).^2,a.nan)./max(n2-1,1);
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

