function idx = ec_groupIndex(group,nObs,argName)
%EC_GROUPINDEX Convert group labels to contiguous integer indices.
%   IDX = EC_GROUPINDEX(GROUP,NOBS,ARGNAME) validates GROUP and converts
%   labels to contiguous integer indices starting at 1 while preserving
%   stable label order.
%
%   GROUP can be:
%     - Vector: one group label per observation.
%     - 2D array with one dimension equal to NOBS: each observation can
%       have multiple label types (one per non-observation dimension).
%       In this case IDX is based on unique label combinations.

%% Input validation
arguments
    group (:,:) % group labels
    nObs (1,1) double {mustBeInteger,mustBePositive} % number of observations
    argName (1,1) string = "group" % group variable name
end

% Check if group is empty
if isempty(group)
    idx = [];
    return
end

% Check size/orientation of group
if isvector(group)
    if numel(group) ~= nObs
        error(argName+" must have one entry per observation along DIM.")
    end
    group = group(:);
else
    if ~ismatrix(group)
        error(argName+" must be a vector or 2D array.")
    end

    gSz = size(group);
    if ~any(gSz == nObs)
        error(argName+" must have one dimension equal to number of observations.")
    end

    if size(group,2) == nObs
        group = group';
    end
end

%% Convert group labels to contiguous integer indices
if isvector(group)
    [~,~,idx] = unique(group,"stable");
else
    [~,~,idx] = unique(group,"rows","stable");
end
