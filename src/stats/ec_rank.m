function [xRank,xRank1,xCov] = ec_rank(x,flag,tol)
arguments
    x {mustBeFloat}
    flag (1,1) logical = false
    tol (1,1) {isfloat} = 1e-7
end

%% Altertative rank computation by Sven Hoffman
xCov = cov(x,1,'partialrows');
[~,D] = eig(xCov);
xRank = sum(diag(D)>tol);

%% Default rank computation in Matlab
if nargout>1 || flag
    xRank1 = rank(x);
    if xRank ~= xRank1
        warning("Rank computation inconsistency: Hoffman="+xRank+" Matlab="+xRank1);
        if nargout<=1 && flag
            xRank = min(xRank,xRank1); %max(xRank,xRank1);
        end
    end
end
