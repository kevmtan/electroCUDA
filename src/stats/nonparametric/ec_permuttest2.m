function [t,p,ci,mu,stats,dist] = ec_permuttest2(x,y,gx,gy,a)
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
%  Modified by Kevin Tan for electroCUDA (github.com/electroCUDA):
%   - Added arguments block
%   - Optimized speed & memory use:
%       - n-D support via reshape to 2D then restore
%       - Group-constrained randomization
%       - Optional CPU parfor and GPU execution path

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
    a.nPerm (1,1) double {mustBeInteger,mustBePositive} = 1e4 % number of permutations
    a.correct (1,1) logical = true % apply max-stat multiple-comparison correction
    a.rows string {mustBeMember(a.rows,["all","complete"])} = "all" % NaN row handling
    a.maxBlockEl (1,1) double {mustBeInteger,mustBePositive} = 5e6 % maximum block elements
    a.mat (1,1) logical = false % return pairwise results as square matrices
    a.parallel {mustBeMember(a.parallel,["cpu" "gpu" "none" ""])} = "" % execution backend
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
    [x,y] = ptpaircols(x);
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

% Compute degrees of freedom
a.dfX = a.nObsX-1;
a.dfY = a.nObsY-1;

% Compute sample variance using fast algo
sumX = sum(x,a.nan);
sumY = sum(y,a.nan);
varX = (sum(x.^2,a.nan)-(sumX.^2)./a.nObsX)./a.dfX;
varY = (sum(y.^2,a.nan)-(sumY.^2)./a.nObsY)./a.dfY;

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
if nargout==1
    return
end


%% Permutation setup

% Concatenate samples for label shuffling
z = [x;y];
a.nObsTot = size(z,1);

% Generate permutation blocks (saves memory by running blocks)
rng(a.seed);
a.bPerms = max(1,floor(a.maxBlockEl/a.nObsTot));
a.bPerms = min(a.bPerms,a.nPerm);
bStarts = 1:a.bPerms:a.nPerm;
nBlocks = numel(bStarts);
bSeeds = randi(intmax("uint32"),nBlocks,1,"uint32");
if a.verbose
    disp("[ec_permuttest2] Number of permutation blocks: "+nBlocks); end

% Check parallelization
if a.parallel=="cpu"
    if nBlocks < 5
        disp("[ec_permuttest2] Less than 5 blocks; implicit parallelization may be faster.")
    end
elseif a.parallel=="gpu"
    if a.useGroups
        warning("[ec_permuttest2] Group-constrained permutations are run on CPU.")
        a.parallel = "";
    else
        z = gpuArray(z);
    end
end

% Preallocate distances from mean (per block)
dist = cell(nBlocks,1);


%% Permutation stats
if a.parallel=="cpu"
    parfor b = 1:nBlocks
        dist{b} = runBlock_lfn(z,bStarts(b),bSeeds(b),a,df);
    end
else
    for b = 1:nBlocks
        dist{b} = runBlock_lfn(z,bStarts(b),bSeeds(b),a,df);
    end
end
dist = vertcat(dist{:});


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
        if size(sd,1)==2
            sd = reshape(sd,[2 featureSize]);
        else
            sd = reshape(sd,outSize);
        end
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





function bDist = runBlock_lfn(z,bStart,seed,a,df)
%%% Permutation block %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bEnd = min(bStart+a.bPerms-1,a.nPerm);
nbPerms = bEnd-bStart+1;
bDist = zeros(nbPerms,a.nVar,"like",z);

if a.parallel=="gpu"
    rng(double(seed));
    [~,idx] = sort(rand(a.nObsTot,nbPerms,"like",z),1);
elseif a.useGroups
    rs = RandStream("mt19937ar","Seed",double(seed));
    idx = zeros(a.nObsTot,nbPerms);
    for k = 1:nbPerms
        xFill = zeros(a.nObsXMax,1);
        yFill = zeros(a.nObsYMax,1);
        cx = 0;
        cy = 0;
        for gi = 1:a.nExchGroups
            rows = a.groupRows{gi};
            ng = numel(rows);
            nXg = a.nXPerGroup(gi);
            pg = rows(randperm(rs,ng));
            xFill(cx+1:cx+nXg) = pg(1:nXg);
            yFill(cy+1:cy+ng-nXg) = pg(nXg+1:end);
            cx = cx+nXg;
            cy = cy+ng-nXg;
        end
        idx(:,k) = [xFill;yFill];
    end
else
    rs = RandStream("mt19937ar","Seed",double(seed)); % seed for parfor
    [~,idx] = sort(rand(rs,a.nObsTot,nbPerms,"like",z),1);
end

% Loop across permutations
for k = 1:nbPerms
    x1 = z(idx(1:a.nObsXMax,k),:);
    x2 = z(idx(a.nObsXMax+1:end,k),:);
    sum1 = sum(x1,a.nan);
    sum2 = sum(x2,a.nan);
    var1 = (sum(x1.^2,a.nan)-(sum1.^2)./a.nObsX)./a.dfX;
    var2 = (sum(x2.^2,a.nan)-(sum2.^2)./a.nObsY)./a.dfY;

    switch a.vartype
        case "equal"
            se = sqrt((a.dfX.*var1+a.dfY.*var2)./df).*...
                sqrt((a.nObsX+a.nObsY)./(a.nObsX.*a.nObsY));
        case "unequal"
            se = sqrt(var1./a.nObsX+var2./a.nObsY);
    end
    bDist(k,:) = (sum1./a.nObsX-sum2./a.nObsY)./se;
end

% Gather from GPU
if a.parallel=="gpu"
    bDist = gather(bDist);
end

