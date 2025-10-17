function y = isany(x,dim)
% isany: Matlab's "any" function with expanded functionality
%   convenient for input validation (like 'arguments' section in functions)

%% Input validation
arguments
    x % Variable to check if empty
    dim (1,1) {isnumeric,isstring} = "all" % Dimension to check, "all" for entire file
end

% Return if empty
if isempty(x)
    y = false;
    return
end

%% Main

% Convert to cell
if istable(x)
    x = table2cell(x);
elseif isstruct(x)
    x = struct2cell(x);
end

% Find non-empty, non-zero numeric vals, or text~=""
if isnumeric(x) || islogical(x)
    if any(x,dim)
        y = true; 
    else
        y = false;
    end
elseif istext(x)
    if any(x~="" & ~ismissing(x),dim) 
        y = true;
    else
        y = false;
    end
elseif any(isobject(x),dim)
    y = true;
elseif iscell(x)
    if any(cellfun(@nnz,x(cellfun(@isnumeric,x))),dim) ||...
            any(cellfun(@(xx) xx~="" & ~ismissing(xx), x(cellfun(@istext,x))),dim) ||...
            any(cellfun(@isobject,x),dim)
        y = true;
    else
        y = false;
    end
end