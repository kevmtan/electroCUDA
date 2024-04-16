nD=3; %Dimension
M=1e6; %Samples
m=randn(nD,1); %Mean
a=randn(nD);
Q=a*a'; %Covariance
y=m+a*randn(nD,M);

%%
[p,z]=z2prctile(y,Q,m);
figure;
subplot(1,2,1)
histogram(p,'BinEdges',0:.01:1,'Normalization','probability'); %Should be uniformly distributed
subplot(1,2,2)
plot(sort(z),'.')