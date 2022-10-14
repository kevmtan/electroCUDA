function [todss,pwr0,pwr1,todssX,dX,d]=nt_dss1(x,w,keep1,keep2)
%[todss,pwr0,pwr1]=nt_dss1(x,w,keep1,keep2) - evoked-biased DSS denoising
%
%  todss: denoising matrix
%  pwr0: power per component (raw)
%  pwr1: power per component (averaged)
%  todssX: denoising matrix - crossvalidated
%  dX: distance of each trial from mean of others - crossvalidated
%
%  x: data to denoise (time * channels * trials)
%  w: weight
%  keep1: (in DSS0) number of PCs to retain (default: all)
%  keep2: (in DSS0) ignore PCs smaller than keep2 (default: 10.^-12)
%
%  The data mean is NOT removed prior to processing.
%
% NoiseTools

if nargin<4; keep2=10.^-12; end
if nargin<3; keep1=[]; end
if nargin<2; w=[]; end
if nargin<1; error('!'); end

if ndims(x)<3; error('x should be 3D'); end
if ~isa(x,'double'); warning('x is not double precision'); end

x=x(:,:,:); % collapse higher dims

[m,n,o]=size(x);

if isempty(w)   % average over trials (--> bias function for DSS)
    [c0,nc0]=nt_cov(x);
    c0=c0/nc0;
    [c1,nc1]=nt_cov(mean(x,3)); 
    c1=c1/nc1;
else
    % weighted average over trials (--> bias function for DSS)
    xx=nt_wmean(x,w,3);
    ww=min(w,[],2);
    % covariance of raw and biased data
    [c0,nc0]=nt_cov(x,[],w);
    c0=c0/nc0;
    [c1,nc1]=nt_cov(xx,[],ww); 
    c1=c1/nc1;
end

% derive DSS matrix
[todss,pwr0,pwr1]=nt_dss0(c0,c1,keep1,keep2);

% crossvalidated
if nargout>3
    if nargin>1; error('!'); end % not implemented with weights
    [nsamples,nchans,ntrials]=size(x);
    % covariance per trial
    CC=zeros(nchans,nchans,ntrials);
    for iTrial=1:ntrials
        CC(:,:,iTrial)=nt_cov(x(:,:,iTrial));
    end
    % leave-one-out DSS
    todssX=zeros(nchans,nchans,ntrials);
    dX=zeros(nchans,ntrials);
    for iTrial=1:ntrials
        others=setdiff(1:ntrials,iTrial);
        C0=sum(CC(:,:,others),3)/nsamples/(ntrials-1);
        C1=nt_cov(mean(x(:,:,others),3))/nsamples;
        todssX(:,:,iTrial)=nt_dss0(C0,C1);
        z=nt_mmat(x,todssX(:,:,iTrial));
        tmp=mean(z(:,:,others),3);
        dX(:,iTrial)=mean( (nt_normcol(z(:,:,iTrial))-nt_normcol(tmp)).^2 );
    end
    d=zeros(nchans,ntrials);
    z=nt_mmat(x,todss);
    d=squeeze(mean(bsxfun(@minus,nt_normcol(z),nt_normcol(mean(z,3))).^2));
end

% if no output arguments, just plot
if nargout==0
    figure(100); clf; 
    subplot 221; 
    plot(pwr1./pwr0,'.-');
    xlabel('component'); ylabel('score');
    z=nt_mmat(x,todss(:,1:3));
    for iComp=1:3
        subplot(2,2,iComp+1);
        nt_bsplot(z(:,iComp,:));
        title(iComp);
        xlabel('sample');
    end
    
    clear todss pwr0 pwr1
end

