function idx = ec_groupIndex(group,nObs,argName)
%EC_GROUPINDEX Convert group labels to contiguous integer indices.
%   IDX = EC_GROUPINDEX(GROUP,NOBS,ARGNAME) validates GROUP as a vector of
%   length NOBS and converts labels to contiguous integer indices starting
%   at 1 while preserving stable label order.

if nargin < 3 || isempty(argName)
    argName = "group";
end
if isempty(group)
    idx = [];
    return
end
if ~isvector(group)
    error(argName+" must be a vector.")
end
if numel(group) ~= nObs
    error(argName+" must have one entry per observation along DIM.")
end

group = group(:);
[~,~,idx] = unique(group,"stable");
