function [M,y,score,proportion]=nt_sca(x,ncomp)
%[M,y]=nt_sca(x,ncomp) - shared component analysis

if nargin<1; error('!'); end
if nargin<2 ||isempty(2); ncomp=size(x,2); end

if iscell(x)
    xx=[];
    for iTrial=1:numel(x)
        xx=[xx;x{iTrial}];
    end
    x=xx; clear xx;
end
x=nt_demean(x);

THRESH=10^-12;

%{
Todo: 
- allow xvalidation
- operate on covariance matrices
%}

T=eye(size(x,2)); % current transform
M=eye(size(x,2)); % result
C0=nt_cov(x); % initial covariance

score=[];
for iComp=1:ncomp
    C=T'*C0*T; % current covariance
    N=diag(1./sqrt(diag(C))); % normalizing matrix
    N(find(isnan(N)))=0;
    C=N'*C*N; % normalize current covariance
    [topcs,ev]=nt_pcarot(C); % PCA
    frompcs=pinv(topcs);
    M(:,iComp)=T*N*topcs(:,1); % keep first PC
    T=T*N*(topcs(:,2:end)*frompcs(2:end,:)); % project out first PC
    score(iComp)=ev(1);
end

if ncomp<size(x,2) 
    % fill rest of transform matrix with leftover (unprocessed) dimensions
    C=T'*C0*T; % current covariance
    N=diag(1./sqrt(diag(C))); % normalizing matrix
    N(find(isnan(N)))=0;
    C=N'*C*N; % normalize current covariance
    topcs=nt_pcarot(C); % PCA
    T=T*topcs;
    M(:,ncomp+1:end)=T(:,1:(size(x,2)-ncomp));
end

prop=diag(M'*C*M);

%figure(1); clf; plot(prop); pause

if nargout>1; y=x*M; end

% test code
if 0
    x=randn(1000,10);
    [M,y]=nt_sca(x);
end

if 0
    % data are 11 chan:
    % 10 chan share same source (sine), 
    % 1 chan is different source (noise) with higher variance
    x=randn(1000,10);
    s=sin(2*pi*(1:1000)'/1000);
    x=bsxfun(@plus,x,s); % add same to all
    x=[x,10*randn(1000,1)]; % extra channel with large variance
    %[y,M,score]=nt_sca_old(x);
    MM=nt_sca(x); y=x*MM;
    yy=nt_pca(x);
    figure(1); clf;  plot(nt_normcol(s)'*nt_normcol(y)/size(s,1)); 
    hold on; plot(nt_normcol(s)'*nt_normcol(yy)/size(s,1));    legend('sca','pca');
end


if 0
    % two shared sources
    x=randn(1000,10);
    s=sin(2*pi*(1:1000)'/1000);
    s2=sin(2*pi*2*(1:1000)'/1000);
    x=x+s*rand(1,10); % add same to all
    x=x+s2*rand(1,10); % add same to all
    x=[x,10*randn(1000,3)]; % extra channel with large variance
    %[y,M,score]=nt_sca_old(x);
    MM=nt_sca(x); yyy=x*MM;
    yy=nt_pca(x);
    figure(1); clf; 
    subplot 121; %bar(abs(nt_normcol(s)'*nt_normcol(y)/size(s,1))); 
    hold on; bar(abs(nt_normcol(s)'*nt_normcol(yyy)/size(s,1))); 
    hold on; bar(abs(nt_normcol(s)'*nt_normcol(yy)/size(s,1)));    legend('sca','pca'); title('source 1');
    subplot 122; %bar(abs(nt_normcol(s2)'*nt_normcol(y)/size(s,1))); 
    hold on;bar(abs(nt_normcol(s2)'*nt_normcol(yyy)/size(s,1))); 
    hold on; bar(abs(nt_normcol(s2)'*nt_normcol(yy)/size(s,1)));    legend('sca','pca'); title('source 2');
end
    
    