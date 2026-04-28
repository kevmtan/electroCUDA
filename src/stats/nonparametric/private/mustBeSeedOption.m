function mustBeSeedOption(val)
if isstring(val) && isscalar(val)
    if ~strcmpi(val,"shuffle")
        error("Seed text value must be ""shuffle"".")
    end
    return
end
if ~(isnumeric(val) && isscalar(val))
    error("Seed must be a numeric scalar or ""shuffle"".")
end