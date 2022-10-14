function [xRank,xCov] = ec_rank(x,tol,flag)
arguments
    x {isfloat}
    tol (1,1){isfloat} = 1e-7;
    flag (1,1){logical} = 0
end

%% Alternate computation of the rank by Sven Hoffman
xCov = cov(x,1,'partialrows');
[~,D] = eig(xCov);
xRank = sum(diag(D)>tol);

%% Matlab standard
if flag
    xRank1 = rank(x);
    if xRank ~= xRank1
        fprintf('Warning: fixing rank computation inconsistency (%d vs %d) most likely because running under Linux 64-bit Matlab\n', xRank, xRank1);
        xRank = min(xRank,xRank1); %max(xRank,xRank1);
    end
end
