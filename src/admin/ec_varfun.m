function t = ec_varfun(fun,t)

if istable(t)
    t = ec_varfun_lfn(fun,t);
elseif iscell(t)
    t = cellfun(@(t) ec_varfun_lfn(fun,t),t,UniformOutput=false);
end

function t = ec_varfun_lfn(fun,t)
for v = 1:width(t)
    t.(v) = fun(t.(v));
end