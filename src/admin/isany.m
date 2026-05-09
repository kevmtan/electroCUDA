function y = isany(x,dim)
% isany: Matlab's "any" function with expanded functionality
% convenient for input validation (like 'arguments' section in functions)
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025

% Input validation
arguments
    x % Variable to check if empty
    dim (1,1) {mustBeTextOrNumeric} = "all" % Dimension to check, "all" for entire file
end

% Main checks: non-empty, non-zero, non-missing, and text ~= ""
if isempty(x)
    y = false;
elseif isnumeric(x) || islogical(x)
    y = any(x,dim);
elseif istext(x)
    y = any(x~="" & ~ismissing(x),dim);
elseif isobject(x)
    y = true;
elseif istable(x) || istimetable(x)
    y = any(varfun(@(xi) lfn(xi,dim),x,OutputFormat="uniform"),dim);
elseif isstruct(x)
    y = any(structfun(@(xi) lfn(xi,dim),x,UniformOutput=true),dim);
elseif iscell(x)
    y = any(cellfun(@(xi) lfn(xi,dim),x,UniformOutput=true),dim);
else
    error("Unsupported input type");
end


% Nested checks subfunction
function yi = lfn(xi,dim)
if isempty(xi)
    yi = false;
elseif isnumeric(xi) || islogical(xi)
    yi = any(xi,dim);
elseif istext(xi)
    yi = any(xi~="" & ~ismissing(xi),dim);
elseif isobject(xi)
    yi = true;
else
    error("Unsupported input type");
end