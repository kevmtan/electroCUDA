function [y,z,mask]=nt_eyeblink(x,eyechans,nremove,sr)
%[y,z,mask]=nt_eyeblink(x,eyechans,nremove) - project out eyeblinks
%
%  y: clean data
%  z: eyeblink components
%  mask: mask used to weight eyeblink intervals
%
%  x: data to clean (time X channels)
%  eyechans: ocular channel numbers, or eog signals
%  nremove: number of components to remove
%
% NoiseTools
nt_greetings;

if nargin<2; error('!'); end
if nargin<3||isempty(nremove); nremove=1; end
if nargin<4; sr=[]; end

if nargout==0
    % plot results
    [y,z,mask]=nt_eyeblink(x,eyechans,nremove,sr);
    figure(201); clf;
    subplot 211; plot(x); title('raw');
    subplot 212; plot(y); title('clean');
    figure(202); clf;
    subplot 211; plot(mask); title('mask');
    subplot 212; plot(z(:,1:3)); title('eyeblink components 1:3');
    disp(size(z)); 
    disp(size(kurtosis(z)));
    figure(203); clf;
    plot(kurtosis(z));
    drawnow
    clear y z mask
end

if size(eyechans,1) ~= size(x,1)
    % interpret as channel numbers
    eyechans=x(:,eyechans);
    if isempty(sr); error ('!'); end
end

% demean, detrend, highpass eyechans to emphasize blinks
eyechans=nt_demean(eyechans);
ORDER=1;
eyechans=nt_detrend(eyechans,ORDER);
if sr
    HPF=1;
    [b,a]=butter(2,HPF/(sr/2),'high');
    eyechans=filtfilt(b,a,eyechans);
end
eyechans=nt_normcol(eyechans);

% PCA to merge across eye channels
topcs=nt_pca0(nt_normcol(eyechans));
eyechans=eyechans*topcs(:,1);

% mask to emphasize eyeblink intervals
mask=mean(eyechans.^2,2);
quantile=.8;
tmp=sort(mask);
mask=min(mask,tmp(round(size(mask,1)*quantile))); % avoid extreme weight

% DSS to emphasize eyeblink components
topcs=nt_pca0(x);
xx=x*topcs(:,1:min(10,size(x,2)));
c0=nt_cov(xx);
c1=nt_cov(nt_demean(bsxfun(@times,xx,mask)));
[todss,pwr0,pwr1]=nt_dss0(c0,c1); 
%figure(99); clf; plot(pwr1./pwr0,'.-'); title('nt_eyeblink'); ylabel('score'); xlabel('component');
z=nt_mmat(xx,todss(:,1:nremove));

% figure(10); clf; subplot 211; plot(eyechans);
% subplot 212; plot(z);
% pause

y=nt_tsr(x,z);

% figure(11); clf; subplot 211; plot(x);
% subplot 212; plot(nt_tsr(x,y));
% pause









