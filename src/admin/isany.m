function y = isany(x)

% Return if empty
if isempty(x)
    y = false;
    return
end

% Convert to cell
if istable(x)
    x = table2cell(x);
elseif isstruct(x)
    x = struct2cell(x);
end

% Find non-empty, non-zero numeric vals, or text~=""
if isnumeric(x) || islogical(x)
    if any(x,"all")
        y = true; 
    else
        y = false;
    end
elseif istext(x)
    if any(x~="","all")
        y = true;
    else
        y = false;
    end
elseif any(isobject(x),"all")
    y = true;
elseif iscell(x)
    if any(cellfun(@nnz,x(cellfun(@isnumeric,x))),"all") ||...
            any(cellfun(@(xx) xx~="",x(cellfun(@istext,x))),"all") ||...
            any(cellfun(@isobject,x),"all")
        y = true;
    else
        y = false;
    end
end