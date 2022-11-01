function [xRank,xEig,xRank1] = ec_rank(x,flag,o)
arguments
    x {mustBeFloat}
    flag (1,1) {islogical} = false
    o.tol (1,1) {isfloat} = 1e-7
    o.gpu (1,1) {islogical} = false
end
if isempty(o.tol); o.tol = 1e-7; end
if isgpuarray(x); o.gpu = true; end
if o.gpu && ~isgpuarray(x); x = gpuArray(x);end
if o.gpu && ~isgpuarray(o.tol); o.tol = gpuArray(o.tol); end

%% Altertative rank computation by Sven Hoffman
xEig = cov(x,1,'partialrows');
xEig = eig(xEig);
xRank = sum(xEig>o.tol);

%% Default rank computation in Matlab
if nargout>=3 || flag
    xRank1 = rank(x);
    if xRank ~= xRank1
        if ~o.gpu; warning("Rank computation inconsistency: Hoffman="+xRank+" Matlab="+xRank1); end
        if nargout<=2 && flag
            xRank = min(xRank,xRank1); %max(xRank,xRank1);
        end
    end
end
