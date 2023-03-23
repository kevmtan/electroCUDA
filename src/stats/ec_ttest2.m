function [h,p,ci,difference,se,tstat,stdDev,degFree,nx,ny] = ttest2_KT(x,y,varargin)
%TTEST2 Two-sample t-test with pooled or unpooled variance estimate.
%   H = TTEST2(X,Y) performs a t-test of the hypothesis that two
%   independent samples, in the vectors X and Y, come from distributions
%   with equal means, and returns the result of the test in H.  H=0
%   indicates that the null hypothesis ("means are equal") cannot be
%   rejected at the 5% significance level.  H=1 indicates that the null
%   hypothesis can be rejected at the 5% level.  The data are assumed to
%   come from normal distributions with unknown, but equal, variances.  X
%   and Y can have different lengths.
%
%   This function performs an unpaired two-sample t-test. For a paired
%   test, use the TTEST function.
%
%   X and Y can also be matrices or N-D arrays.  For matrices, TTEST2
%   performs separate t-tests along each column, and returns a vector of
%   results.  X and Y must have the same number of columns.  For N-D
%   arrays, TTEST2 works along the first non-singleton dimension.  X and Y
%   must have the same size along all the remaining dimensions.
%
%   TTEST2 treats NaNs as missing values, and ignores them.
%
%   [H,P] = TTEST2(...) returns the p-value, i.e., the probability of
%   observing the given result, or one more extreme, by chance if the null
%   hypothesis is true.  Small values of P cast doubt on the validity of
%   the null hypothesis.
%
%   [H,P,CI] = TTEST2(...) returns a 100*(1-ALPHA)% confidence interval for
%   the true difference of population means.
%
%   [H,P,CI,STATS] = TTEST2(...) returns a structure with the following fields:
%      'tstat' -- the value of the test statistic
%      'df'    -- the degrees of freedom of the test
%      'sd'    -- the pooled estimate of the population standard deviation
%                 (for the equal variance case) or a vector containing the
%                 unpooled estimates of the population standard deviations
%                 (for the unequal variance case)
%
%   [...] = TTEST2(X,Y,'PARAM1',val1,'PARAM2',val2,...) specifies one or
%   more of the following name/value pairs:
%
%       Parameter       Value
%       'alpha'         A value ALPHA between 0 and 1 specifying the
%                       significance level as (100*ALPHA)%. Default is
%                       0.05 for 5% significance.
%       'dim'           Dimension DIM to work along. For example, specifying
%                       'dim' as 1 tests the column means. Default is the
%                       first non-singleton dimension.
%       'tail'          A string specifying the alternative hypothesis:
%           'both'  "means are not equal" (two-tailed test)
%           'right' "mean of X is greater than mean of Y" (right-tailed test)
%           'left'  "mean of X is less than mean of Y" (left-tailed test)
%       'vartype'       'equal' to perform the default test assuming equal
%                       variances, or 'unequal', to perform the test
%                       assuming that the two samples come from normal
%                       distributions with unknown and unequal variances.
%                       This is known as the Behrens-Fisher problem. TTEST2
%                       uses Satterthwaite's approximation for the
%                       effective degrees of freedom.
%
%   See also TTEST, RANKSUM, VARTEST2, ANSARIBRADLEY.

%   References:
%      [1] E. Kreyszig, "Introductory Mathematical Statistics",
%      John Wiley, 1970, section 13.4. (Table 13.4.1 on page 210)

%   Copyright 1993-2017 The MathWorks, Inc.


if nargin > 2
    [varargin{:}] = convertStringsToChars(varargin{:});
end

if nargin < 2
    error(message('stats:ttest2:TooFewInputs'));
end

% Process remaining arguments
alpha = 0.05;
tail = 0;    % code for two-sided;
vartype = '';
dim = '';

if nargin>=3
    if isnumeric(varargin{1})
        % Old syntax
        %    TTEST2(X,Y,ALPHA,TAIL,VARTYPE,DIM)
        alpha = varargin{1};
        if nargin>=4
            tail = varargin{2};
              if nargin>=5
                  vartype =  varargin{3};
                  if nargin>=6
                      dim = varargin{4};
                  end
             end
        end
        
    elseif nargin==3
            error(message('stats:ttest2:BadAlpha'));
    
    else
        % Calling sequence with named arguments
        okargs =   {'alpha' 'tail' 'vartype' 'dim'};
        defaults = {0.05    'both'    ''      ''};
        [alpha, tail, vartype, dim] = ...
                         internal.stats.parseArgs(okargs,defaults,varargin{:});
    end
end

if isempty(alpha)
    alpha = 0.05;
elseif ~isscalar(alpha) || alpha <= 0 || alpha >= 1
    error(message('stats:ttest2:BadAlpha'));
end

if isempty(tail)
    tail = 0;
elseif isnumeric(tail) && isscalar(tail) && ismember(tail,[-1 0 1])
    % OK, grandfathered
else
    [~,tail] = internal.stats.getParamVal(tail,{'left','both','right'},'''tail''');
    tail = tail - 2;
end

if isempty(vartype)
    vartype = 1;
elseif isnumeric(vartype) && isscalar(vartype) && ismember(vartype,[1 2])
    % OK, grandfathered
else
    [~,vartype] = internal.stats.getParamVal(vartype,{'equal','unequal'},'''vartype''');
end

if isempty(dim)
    % Figure out which dimension mean will work along by looking at x.  y
    % will have be compatible. If x is a scalar, look at y.
    dim = find(size(x) ~= 1, 1);
    if isempty(dim), dim = find(size(y) ~= 1, 1); end
    if isempty(dim), dim = 1; end
    
    % If we haven't been given an explicit dimension, and we have two
    % vectors, then make y the same orientation as x.
    if isvector(x) && isvector(y)
        if dim == 2
            y = y(:)';
        else % dim == 1
            y = y(:);
        end
    end
end

% Make sure all of x's and y's non-working dimensions are identical.
sizex = size(x); sizex(dim) = 1;
sizey = size(y); sizey(dim) = 1;
if ~isequal(sizex,sizey)
    error(message('stats:ttest2:InputSizeMismatch'));
end

xnans = isnan(x);
if any(xnans(:))
    nx = sum(~xnans,dim);
else
    nx = size(x,dim); % a scalar, => a scalar call to tinv
end
ynans = isnan(y);
if any(ynans(:))
    ny = sum(~ynans,dim);
else
    ny = size(y,dim); % a scalar, => a scalar call to tinv
end


s2x = nanvar(x,[],dim);
s2y = nanvar(y,[],dim);
xmean = nanmean(x,dim);
ymean = nanmean(y,dim);
difference = xmean - ymean;

% Check for rounding issues causing spurious differences                                                                                  -
sqrtn = sqrt(nx)+sqrt(ny);
fix = (difference~=0) & ...                                     % non-zero
    (abs(difference) < sqrtn.*100.*max(eps(xmean),eps(ymean))); % but small                                                                                 -
if any(fix(:))
    % Fix any columns that are constant, even if computed difference is
    % non-zero but small
    constvalue = min(x,[],dim);
    fix = fix & all(x==constvalue | isnan(x),dim) ...
              & all(y==constvalue | isnan(y),dim);
    difference(fix) = 0;
end

if vartype == 1 % equal variances
    dfe = nx + ny - 2;
    sPooled = sqrt(((nx-1) .* s2x + (ny-1) .* s2y) ./ dfe);
    sPooled(fix) = 0;
    
    se = sPooled .* sqrt(1./nx + 1./ny);
    ratio = difference ./ se;

    if (nargout>3)
        stats = struct('tstat', ratio, 'df', cast(dfe,'like',ratio), ...
                       'sd', sPooled);
        if isscalar(dfe) && ~isscalar(ratio)
            stats.df = repmat(stats.df,size(ratio));
        end       
    end
elseif vartype == 2 % unequal variances
    s2xbar = s2x ./ nx;
    s2ybar = s2y ./ ny;
    dfe = (s2xbar + s2ybar) .^2 ./ (s2xbar.^2 ./ (nx-1) + s2ybar.^2 ./ (ny-1));
    se = sqrt(s2xbar + s2ybar);
    se(fix) = 0;
    ratio = difference ./ se;

    if (nargout>3)
        stats = struct('tstat', ratio, 'df', cast(dfe,'like',ratio), ...
                       'sd', sqrt(cat(dim, s2x, s2y)));
        if isscalar(dfe) && ~isscalar(ratio)
            stats.df = repmat(stats.df,size(ratio));
        end
    end    
    
    % Satterthwaite's approximation breaks down when both samples have zero
    % variance, so we may have gotten a NaN dfe.  But if the difference in
    % means is non-zero, the hypothesis test can still reasonable results,
    % that don't depend on the dfe, so give dfe a dummy value.  If difference
    % in means is zero, the hypothesis test returns NaN.  The CI can be
    % computed ok in either case.
    if all(se(:) == 0), dfe = 1; end
end

% Compute the correct p-value for the test, and confidence intervals
% if requested.
if tail == 0 % two-tailed test
    p = 2 * tcdf(-abs(ratio),dfe);
    if nargout > 2
        spread = tinv(1 - alpha ./ 2, dfe) .* se;
        ci = cat(dim, difference-spread, difference+spread);
    end
elseif tail == 1 % right one-tailed test
    p = tcdf(-ratio,dfe);
    if nargout > 2
        spread = tinv(1 - alpha, dfe) .* se;
        ci = cat(dim, difference-spread, Inf(size(p)));
    end
elseif tail == -1 % left one-tailed test
    p = tcdf(ratio,dfe);
    if nargout > 2
        spread = tinv(1 - alpha, dfe) .* se;
        ci = cat(dim, -Inf(size(p)), difference+spread);
    end
end

% Determine if the actual significance exceeds the desired significance
h = cast(p <= alpha, 'like', p);
h(isnan(p)) = false; % p==NaN => neither <= alpha nor > alpha

tstat = ratio;
stdDev = stats.sd;
degFree = stats.df;
end
