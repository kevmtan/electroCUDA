function y = isNumOrLogical(x)
% Is numeric or logical?
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025

if istable(x) || istimetable(x)
    x = table2cell(x(1,:));
elseif isstruct(x)
    x = struct2cell(x);
end

if iscell(x)
    y = cellfun(@lfn,x,UniformOutput=true);
else
    y = lfn(x);
end

%%
function y = lfn(x)
if isnumeric(x) || islogical(x)
    y = true;
else
    y = false;
end
