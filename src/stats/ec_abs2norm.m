function x = ec_abs2norm(x,dim,o)
%% Transform absolute value data into an approximate normal distribution
% This function reconstructs a normal distribution from absolute value data,
% which is often often log-normal (e.g. complex wavelet transform outputs)
% Natural log is used to attain the underlying normal distribution of log-normal data
% Along with other normalization steps 
%
%       Kevin Tan, 2022 (github.com/kevmtan/electroCUDA)

%% Input aguments ('o' fields are name-value arguments):
arguments
    x {mustBeNumeric}                           % Input data (vector/matrix) - REQUIRED INPUT
    dim (1,1) {mustBeGreaterThan(dim,0)} = 1    % Dimension of 'x' to transform (default = 1st non-singleton dim)
    o.pre {isnumeric} = [1 100]                 % Pre-transform rescale to this range
    o.log (1,1) logical = true                  % Apply log-transform? (default=TRUE, skip=FALSE). Skip if data not log-normal
    o.center {isstring,ischar,isempty} = "mean" % Desired zero-point for centering, ignore to skip (see Matlab's "normalize" function)
    o.scale {isstring,ischar,isempty} = "std"   % Desired scaling ("std"|"mad"|"iqr")
    o.symRange {isnumeric} = []                 % Desired symmetric range relative to zero, ignore to skip
end	                                            %     symRange rescales pos & neg values to have symmetric range from 0
if numel(x)<2; error("Input data 'x' must contain multiple numeric values"); end
if size(x,dim)<2; dim=find(size(x)>1,1); end
if ~o.log && isempty(o.center) && isempty(o.symRange); o.center="median"; o.symRange=1; end

%% Pre-transform rescale
if any(o.pre)
    x = normalize(x,dim,"range",o.pre);
end

%% Apply log-transform (natural log)
if o.log
    x = log(abs(x)); % Applied by default, disable if input data isn't log-normal
end

%% Center data to desired zero-point
if ~isempty(o.center) || ~isempty(o.scale)
    x = normalize(x,dim,"center",o.center,"scale",o.scale); % possible values include: "mean" | "median" | numeric scalar
end

%% Rescale positive & negative values to have symmetric range
idx = x>=0;
if any(o.symRange) && numel(unique(idx)) > 1 
    % Independent rescaling of positive & negative values for true symmetry
    o.symRange = abs(o.symRange);

    % Positive vals
    xx = x;
    xx(~idx) = nan;
    xx = normalize(xx,dim,"range",[0 o.symRange]);
    x(idx) = xx(idx);

    % Negative vals
    xx = x;
    xx(idx) = nan;
    xx = normalize(xx,dim,"range",[-o.symRange 0]); % max(xx) instead of 0?
    x(~idx) = xx(~idx);
    
elseif any(o.symRange) && numel(unique(idx)) == 1
    % Data are unsigned/uncentered, won't result in true symmetry
    x = normalize(x,dim,"range",[-o.symRange o.symRange]);
end
