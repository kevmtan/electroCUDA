function [stat,p,ci,mu,stats,dist] = ec_nonparametricTest1(x,m,g,a)
%EC_NONPARAMETRICTEST1 Non-parametric one-sample test of average/location.
%   [STAT,P,CI,MU,STATS,DIST] = EC_NONPARAMETRICTEST1(X,M,A) performs a
%   non-parametric one-sample test on X against null value M0.
%
%   Methods:
%     - "sign"      : exact sign test (tests median difference)
%     - "wilcoxon"  : Wilcoxon signed-rank test (assumes symmetric diffs)
%     - "bootstrap" : one-sample recentered bootstrap means test
%     - "auto"      : chooses "sign" for target="median", otherwise
%                     "bootstrap"
%
%   Note: This function intentionally does not implement an exact binomial
%   branch; use EC_BINOMTEST for binary/proportion hypotheses.

%% Arguments validation
arguments
    x {mustBeNumericOrLogical} % one-sample data (observations x features)
    m (1,1) double = 0 % null/reference value
    g = [] % optional exchangeability group labels per observation
    a.alpha (1,1) double {mustBeGreaterThan(a.alpha,0),mustBeLessThan(a.alpha,1)} = 0.05 % significance level
    a.dim (1,1) double {mustBeInteger,mustBePositive} = 1 % observation dimension in input arrays
    a.tail string {mustBeMember(a.tail,["left","both","right"])} = "both" % hypothesis tail
    a.method string {mustBeMember(a.method,["auto","sign","wilcoxon","bootstrap"])} = "auto" % test method
    a.target string {mustBeMember(a.target,["mean","median"])} = "mean" % summary/estimand for grouped resampling
    a.rows string {mustBeMember(a.rows,["all","complete"])} = "all" % NaN row handling
    a.groupWeights string {mustBeMember(a.groupWeights,["equal","size"])} = "equal" % group weighting mode
    a.nBoot (1,1) double {mustBeInteger,mustBePositive} = 1e4 % bootstrap/permutation iterations
    a.parallel {mustBeMember(a.parallel,["cpu","gpu","",[]])} = "" % execution backend (bootstrap only)
    a.floatType {mustBeMember(a.floatType,["double" "single" "half"])} = class(x)
    a.seed {mustBeSeedOption(a.seed)} = "shuffle" % RNG seed or "shuffle"
    a.verbose (1,1) logical = true % print status/warning messages
end
if isgpuarray(x)
    a.parallel = "gpu";
end

% Resolve method
if a.method=="auto"
    if a.target=="median"
        a.method = "sign";
    else
        a.method = "bootstrap";
    end
end

% Suggest exact binomial test for binary proportion use cases
if a.verbose && (islogical(x) || all(isnan(x) | x==0 | x==1,"all"))
    warning("[ec_nonparametricTest1] Binary data detected. For exact one-sample "+...
        "proportion testing against chance (e.g., p0=0.5), consider ec_binomTest.")
end

% Warnings
if a.verbose && (a.method=="sign" || a.method=="wilcoxon")
    warning("[ec_nonparametricTest1] CI is not implemented for "+a.method+...
        "; returning NaNs in CI.")
end
if a.verbose && (a.method=="sign" || a.method=="wilcoxon") && a.parallel~=""
    warning("[ec_nonparametricTest1] a.parallel is only used for method='bootstrap'.")
end

%% Prep

% Reshape to [observations x features] for n-D safety
xInputDims = ndims(x);
if a.dim~=1 || xInputDims>2
    [x,featureSize] = ec_reshape2D(x,a.dim);
end
g = ec_groupIndex(g,size(x,1),"g");

% Row filtering
if a.rows=="complete"
    id = ~any(isnan(x),2);
    x = x(id,:);
    if ~isempty(g)
        g = g(id);
    end
end

% Determine NaN handling mode
if any(isnan(x),"all")
    nanflag = "omitmissing";
else
    nanflag = "includemissing";
end

% Get data dimensions
[~,nVar] = size(x);

% Convert to float type
x = cast(x,a.floatType);

% Initialize outputs
stat = nan(1,nVar,like=x);
p = nan(1,nVar,like=x);
mu = nan(1,nVar,like=x);
ci = nan(2,nVar,like=x);
dist = nan(a.nBoot,nVar,like=x);


%% Run selected testing method
switch a.method
    case "sign"
        [stat,p,mu,stats] = signTest_ln(x,m,g,a);
    case "wilcoxon"
        [stat,p,mu,stats] = wilcoxson_lfn(x,m,g,a);
    case "bootstrap"
        [stat,p,ci,mu,stats,dist] = bootstrap_lfn(x,m,g,a,nanflag);
end


%% Finalize

% Restore original feature shape
if a.dim~=1 || xInputDims>2
    outSize = [1 featureSize];
    stat = reshape(stat,outSize);
    p = reshape(p,outSize);
    mu = reshape(mu,outSize);
    ci = reshape(ci,[2 featureSize]);
    if ~isempty(dist)
        dist = reshape(dist,[a.nBoot featureSize]);
    end
end




%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function [stat,p,mu,stats] = signTest_ln(x,m,g,a)
% Exact sign-test branch (with optional group summarization).
[~,nVar] = size(x);
stat = nan(1,nVar);
p = nan(1,nVar);
mu = nan(1,nVar);
nEff = zeros(1,nVar);
nPos = zeros(1,nVar);
nGroupsEff = zeros(1,nVar);
for v = 1:nVar
    d = x(:,v)-m;
    if ~isempty(g)
        [d,nGroupsEff(v)] = summarizeByGroup_lfn(d,g,a.target,a.groupWeights);
    else
        d = d(~isnan(d));
    end
    d = d(d~=0); % drop ties
    n = numel(d);
    nEff(v) = n;
    if n==0
        continue
    end
    k = sum(d>0);
    nPos(v) = k;
    nNeg = n-k;
    stat(v) = (k-nNeg)/n;
    mu(v) = median(d);
    switch a.tail
        case "right"
            p(v) = 1-binocdf(k-1,n,0.5);
        case "left"
            p(v) = binocdf(k,n,0.5);
        case "both"
            pLeft = binocdf(k,n,0.5);
            pRight = 1-binocdf(k-1,n,0.5);
            p(v) = min(1,2*min(pLeft,pRight));
    end
end
stats.nEff = nEff;
stats.nPos = nPos;
stats.method = "sign";
if ~isempty(g)
    stats.nGroups = nGroupsEff;
    stats.useGroups = true;
    stats.groupSummary = a.target;
    stats.groupWeights = a.groupWeights;
else
    stats.useGroups = false;
end




function [stat,p,mu,stats] = wilcoxson_lfn(x,m,g,a)
% Wilcoxon signed-rank branch (with optional group summarization).
[~,nVar] = size(x);
stat = nan(1,nVar);
p = nan(1,nVar);
mu = nan(1,nVar);
nEff = zeros(1,nVar);
signedRank = nan(1,nVar);
nGroupsEff = zeros(1,nVar);
for v = 1:nVar
    d = x(:,v)-m;
    if ~isempty(g)
        [d,nGroupsEff(v)] = summarizeByGroup_lfn(d,g,a.target,a.groupWeights);
    else
        d = d(~isnan(d));
    end
    d = d(d~=0); % drop ties
    nEff(v) = numel(d);
    if nEff(v)==0
        continue
    end
    [p(v),~,sr] = signrank(d,0,"tail",char(a.tail));
    signedRank(v) = sr.signedrank;
    stat(v) = sr.signedrank;
    mu(v) = median(d);
end
stats.nEff = nEff;
stats.signedRank = signedRank;
stats.method = "wilcoxon";
if ~isempty(g)
    stats.nGroups = nGroupsEff;
    stats.useGroups = true;
    stats.groupSummary = a.target;
    stats.groupWeights = a.groupWeights;
else
    stats.useGroups = false;
end




function [stat,p,ci,mu,stats,dist] = bootstrap_lfn(x,m,g,a,nanflag)
% Recentered one-sample bootstrap branch.
[~,nVar] = size(x);
stat = nan(1,nVar);
p = nan(1,nVar);
mu = nan(1,nVar);
ci = nan(2,nVar);
dist = nan(a.nBoot,nVar);
rng(a.seed);
featSeeds = randi(intmax("uint32"),nVar,1,"uint32");

if a.parallel=="gpu" && ~isempty(g)
    if a.verbose
        warning("[ec_nonparametricTest1] Grouped bootstrap is run on CPU.")
    end
    a.parallel = "";
end

if a.parallel=="cpu"
    parfor v = 1:nVar
        [stat(v),p(v),ci(:,v),mu(v),dist(:,v)] = ...
            bootstrapFeature_lfn(x(:,v),m,g,a,nanflag,featSeeds(v));
    end
else
    for v = 1:nVar
        [stat(v),p(v),ci(:,v),mu(v),dist(:,v)] = ...
            bootstrapFeature_lfn(x(:,v),m,g,a,nanflag,featSeeds(v));
    end
end

stats.nObs = sum(~isnan(x),1);
stats.target = a.target;
stats.method = "bootstrap";
stats.useGroups = ~isempty(g);
stats.groupWeights = a.groupWeights;




function [statv,pv,civ,muv,distv] = bootstrapFeature_lfn(xv,m,g,a,nanflag,seed)
% Per-feature bootstrap worker.
statv = nan;
pv = nan;
civ = [nan;nan];
muv = nan;
distv = nan(a.nBoot,1);

d = xv-m;
d = d(~isnan(d));
n = numel(d);
if n==0
    return
end

switch a.target
    case "mean"
        thetaHat = mean(d,nanflag);
    case "median"
        thetaHat = median(d,nanflag);
end
muv = thetaHat;
statv = thetaHat;
d0 = d-thetaHat;

if a.parallel=="gpu"
    dg = gpuArray(d);
    dg0 = gpuArray(d0);
    idx = randi(n,n,a.nBoot,"gpuArray");
    xb = reshape(dg(idx),n,a.nBoot);
    xbNull = reshape(dg0(idx),n,a.nBoot);
    switch a.target
        case "mean"
            thetaBoot = gather(mean(xb,1))';
            nullBoot = gather(mean(xbNull,1))';
        case "median"
            thetaBoot = gather(median(xb,1))';
            nullBoot = gather(median(xbNull,1))';
    end
else
    rs = RandStream("mt19937ar","Seed",double(seed));
    nullBoot = zeros(a.nBoot,1);
    thetaBoot = zeros(a.nBoot,1);
    if isempty(g)
        for b = 1:a.nBoot
            idx = randi(rs,n,n,1);
            xbNull = d0(idx);
            xb = d(idx);
            switch a.target
                case "mean"
                    nullBoot(b) = mean(xbNull);
                    thetaBoot(b) = mean(xb);
                case "median"
                    nullBoot(b) = median(xbNull);
                    thetaBoot(b) = median(xb);
            end
        end
    else
        dAll = xv-m;
        ok = ~isnan(dAll);
        dAll = dAll(ok);
        gAll = g(ok);
        [~,~,gV] = unique(gAll,"stable");
        nGrp = max(gV);
        groupRows = cell(nGrp,1);
        groupSize = zeros(nGrp,1);
        for gi = 1:nGrp
            groupRows{gi} = find(gV==gi);
            groupSize(gi) = numel(groupRows{gi});
        end
        d0All = dAll-thetaHat;
        for b = 1:a.nBoot
            switch a.groupWeights
                case "equal"
                    sel = randi(rs,nGrp,nGrp,1);
                case "size"
                    sel = randsample(rs,nGrp,nGrp,true,groupSize);
            end
            idx = vertcat(groupRows{sel});
            xbNull = d0All(idx);
            xb = dAll(idx);
            switch a.target
                case "mean"
                    nullBoot(b) = mean(xbNull);
                    thetaBoot(b) = mean(xb);
                case "median"
                    nullBoot(b) = median(xbNull);
                    thetaBoot(b) = median(xb);
            end
        end
    end
end

distv = nullBoot;
switch a.tail
    case "right"
        pv = (sum(nullBoot>=thetaHat)+1)/(a.nBoot+1);
        civ(1) = prctile(thetaBoot,100*a.alpha);
        civ(2) = Inf;
    case "left"
        pv = (sum(nullBoot<=thetaHat)+1)/(a.nBoot+1);
        civ(1) = -Inf;
        civ(2) = prctile(thetaBoot,100*(1-a.alpha));
    case "both"
        pv = (sum(abs(nullBoot)>=abs(thetaHat))+1)/(a.nBoot+1);
        civ(1) = prctile(thetaBoot,100*(a.alpha/2));
        civ(2) = prctile(thetaBoot,100*(1-a.alpha/2));
end




function [dOut,nGroups] = summarizeByGroup_lfn(d,g,target,groupWeights)
% Summarize to one value per group and optionally size-weight groups.
ok = ~isnan(d);
d = d(ok);
gV = g(ok);
if isempty(d)
    dOut = [];
    nGroups = 0;
    return
end
[~,~,gV] = unique(gV,"stable");
nGroups = max(gV);
dGrp = nan(nGroups,1);
wGrp = zeros(nGroups,1);
for gi = 1:nGroups
    dg = d(gV==gi);
    switch target
        case "mean"
            dGrp(gi) = mean(dg);
        case "median"
            dGrp(gi) = median(dg);
    end
    wGrp(gi) = numel(dg);
end
switch groupWeights
    case "equal"
        dOut = dGrp;
    case "size"
        dOut = repelem(dGrp,max(1,round(wGrp)));
end