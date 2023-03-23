function z=z2score(y,Q,m,icQ)
%Squared z-scoring for multivariate normal distributed data. Equivalent to
%Mahalanobis distance. If y~N(m,Q) (iid), this is distributed as 
%t^2 ~ Hotelling's T^2 = nD*(M-1)/(M-nD) F_{nD,M-nD}
%see https://en.wikipedia.org/wiki/Hotelling%27s_T-squared_distribution
%INPUTS:
%y: matrix or vector of data
%Q: covariance of data, such that y~N(0,Q);
%m: optional, mean of data, such that y~N(m,Q). If not given, defaults to m=0
%iQ: optional, inverse of Q. If given, it is used instead of Q to save a
%matrix inversion computation.
%OUTPUT:
%z: z-score of data

if nargin<3 || isempty(m)
    m=zeros(size(y,1),1,"like",y);
end
if nargin<4 || isempty(icQ)
    ch_Q=cholcov(Q);
    w=ch_Q'\(y-m);
else %Cholesky decomp of inverse of Q is given directly, no need to invert Q
    %icQ=cholcov(iQ);
    w=icQ*(y-m);
end
    z=sum(w.*w,1,"omitnan"); %if Q,y~N(m,Q), this is distributed as t^2 ~ Hotelling's T^2 = nD*(M-1)/(M-nD) F_{nD,M-nD}, see https://en.wikipedia.org/wiki/Hotelling%27s_T-squared_distribution
    %z=sum(y.*(Q\y),1);
end