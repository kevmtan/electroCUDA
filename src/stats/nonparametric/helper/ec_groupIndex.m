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

if nargin < 3 || isempty(argName)
    argName = "group";
end
if isempty(group)
    idx = [];
    return
end

if isvector(group)
    if numel(group) ~= nObs
        error(argName+" must have one entry per observation along DIM.")
    end
    groupObs = group(:);
else
    if ~ismatrix(group)
        error(argName+" must be a vector or 2D array.")
    end
    if size(group,1) == nObs
        groupObs = group;
    elseif size(group,2) == nObs
        groupObs = group';
    else
        error(argName+" must have one dimension equal to number of observations.")
    end
end

if isvector(groupObs)
    [~,~,idx] = unique(groupObs,"stable");
else
    [~,~,idx] = unique(groupObs,"rows","stable");
end
