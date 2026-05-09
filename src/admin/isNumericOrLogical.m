function y = isNumericOrLogical(x)
% Is numeric or logical?
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025

if istable(x) || istimetable(x)
    y = varfun(@lfn,x,OutputFormat="uniform");
elseif isstruct(x)
    y = structfun(@lfn,x);
elseif iscell(x)
    y = cellfun(@lfn,x,UniformOutput=true);
else
    y = lfn(x);
end


% Check if numeric or logical
function y = lfn(x)
if isnumeric(x) || islogical(x)
    y = true;
else
    y = false;
end
