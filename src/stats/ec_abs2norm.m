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
    x {mustBeFloat}                     % Input data (vector/matrix) - REQUIRED INPUT
    dim {isnumeric} = 1                 % Dimension of 'x' to transform (default=largest dimension)
    o.square (1,1) logical = false      % Square the values of 'x'
    o.pre (1,2){isnumeric} = [1 100]    % Pre-transform rescaling to this range (preserves z-score/variance)
    o.log (1,1) logical = true          % Do log-transform (default=TRUE, skip=FALSE). Skip if data not log-normal
    o.scale {istext,isempty} = "zscore" % Scaling ("std"|"mad"|"iqr"|"first"|"zscore"|"robust"|"norm"|"center"|"scale"|"range"|"medianiqr")
    o.center {istext,isnumeric} = []    % Center point, ignore to skip ("mean"|"median"|numeric scalar)
    %o.symRange {isnumeric} = []        % Symmetric range relative to zero, ignore to skip
end	                                    %     symRange rescales pos & neg values to have symmetric range from 0
if numel(x)<2; error("Input data 'x' must contain multiple numeric values"); end
if isempty(dim) || dim<1 || size(x,dim)<2; dim=find(max(size(x))); disp("ec_abs2norm: set dim="+dim); end
if isempty(o.scale); o.scale=''; end
if ~o.log && isempty(o.center); o.center="median"; end

%% Pre-transform rescaling
if any(o.square)
    x = x.^2; % square values
end
if any(o.pre)
    x = normalize(x,dim,range=o.pre); % normalize to range (preserves z-score/variance)
end

%% Log-transform (natural log)
if o.log
    x = log(abs(x)); % disable if input data isn't log-normal
end

%% Final rescaling
if istext(o.scale) && ismember(o.scale,["zscore" "robust" "norm" "center" "scale" "range" "medianiqr"])
    if o.scale=="robust"
        x = normalize(x,dim,"zscore","robust");
    else
        x = normalize(x,dim,o.scale);
    end
elseif ~isempty(o.center) || ~isempty(o.scale)
    x = normalize(x,dim,center=o.center,scale=o.scale); % possible values include: "mean"|"median"|numeric scalar
end

%% (DEPRECIATED) Rescale positive & negative values to have symmetric range
% if any(o.symRange) && numel(unique(x>=0)) > 1 
%     idx = x>=0;
%     % Independent rescaling of positive & negative values for true symmetry
%     o.symRange = abs(o.symRange);
% 
%     % Positive vals
%     xx = x;
%     xx(~idx) = nan;
%     xx = normalize(xx,dim,"range",[0 o.symRange]);
%     x(idx) = xx(idx);
% 
%     % Negative vals
%     xx = x;
%     xx(idx) = nan;
%     xx = normalize(xx,dim,"range",[-o.symRange 0]); % max(xx) instead of 0?
%     x(~idx) = xx(~idx);
%     
% elseif any(o.symRange) && numel(unique(x>=0)) == 1
%     % Data are unsigned/uncentered, won't result in true symmetry
%     x = normalize(x,dim,"range",[-o.symRange o.symRange]);
% end
