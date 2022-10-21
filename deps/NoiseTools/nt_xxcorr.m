function [C,idx]=nt_xxcorr(A,B,centerflag)
%[C,idx]=nt_xxcorr(A,B,centerflag) - true normalized unbiased cross-correlation function
%
%  C: normalized unbiased cross-correlation function
%  idx: index of largest extremum.
%  
%  A: first column vector
%  B: second column vector (nsamples < A)
%  centerflag: if true pad B on both sides [default: false]
%
% NoiseTools

if nargin<2; error('!'); end
if nargin<3||isempty(centerflag); centerflag=0; end
if size(A,1)==size(B,1); warning('same nrows, output=1'); end
if size(A,1)<size(B,1); error('should be nrows(A)>nrows(B)'); end


if size(A,2)==1 && size(B,2)==1; 
    
    % single channels
    nA=size(A,1);
    nB=size(B,1);
    tmp=nA-nB;
    if ~centerflag
        B=[zeros(tmp,1);B];
    else
        B=[zeros(floor(tmp/2),1);B;zeros(tmp-floor(tmp/2),1)];
    end
    C=xcorr(A,B);
    C=C(nB-1+(1:tmp));
    N=cumsum(A.^2);
    N(nB+1:end) = N(nB+1:end) - N(1:end-nB);
    N=N*sum(B.^2); 
    N=N(nB+1:end);
    C=C./sqrt(N);
    C(find(isnan(C)))=0;
    [~,idx]=max(C);
    
    if nargout==0;
        if ~centerflag; 
            abscissa=0:size(C,1)-1;
        else
            abscissa=(0:size(C,1)-1) - ceil(size(C,1)/2);
        end
        plot(abscissa,C); hold on
        plot(abscissa(idx),C(idx),'.k'); hold off
        axis tight; xlabel('lag (samples)');
        C=[];
    end
    
else
    
    % multiple channels
    C=zeros(size(A,1)-size(B,1),size(A,2),size(B,2));
    idx=zeros(size(A,2),size(B,2));
    for k=1:size(A,2)        
        for j=1:size(B,2)
            [a,b]=nt_xxcorr(A(:,k),B(:,j),centerflag);
            C(:,k,j)=a;
            idx(k,j)=b;
        end
    end
    
    if nargout==0
       imagescc(idx-MAXLAG-1);
       colorbar
       C=[]; idx=[];
    end
    
end

% tests
if 0
    x=ones(1000,1);
    nt_xxcorr(x,x);
end

if 0 
    x=ones(1000,1);
    y=ones(500,1);
    nt_xxcorr(x,y);
end  

if 0 
    x=randn(1000,1);
    y=x(1:500);
    x=x.*(1:1000)'.^2;
    nt_xxcorr(x,y);
end  