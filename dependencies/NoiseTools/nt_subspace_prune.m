function [Y,scores]=nt_subspace_prune(X,npass,thresh)
%[Y]=nt_subspace_prune(X,npass,thresh) - local cleaning matrices
%
%  Y: denoised data
%  
%  X: data to denoise (nsamples X nchans X ntrials)
%  npass: number of passes [default: 1]
%  thresh: threshold power ratio between segment & all [default: 10]

if nargin<2||isempty(npass); npass=1; end
if nargin<3||isempty(thresh); thresh=1; end

if isnumeric(X)
    if ndims(X)<3; error('!'); end
    tmp={};
    for iTrial=1:size(X,3); 
        tmp{iTrial}=X(:,:,iTrial); 
    end
    X=tmp;
    [Y,scores]=nt_subspace_prune(X,npass,thresh);
    tmp=zeros(size(Y{1},1),size(Y{2},2),numel(Y));
    for iTrial=1:numel(X); 
        tmp(:,:,iTrial)=Y{iTrial}; 
    end
    Y=tmp;
    return
end

ntrials=numel(X);
nchans=size(X{1},2);

scores=zeros(ntrials,1,npass);
original_power=nt_wpwr(X);
for iPass=1:npass
    
    X=nt_demean2(X);
    
    % covariance matrices
    [C0,tw]=nt_cov(X); 
    C0=C0/tw;
    CC1=zeros(nchans,nchans,ntrials);
    for iTrial=1:numel(X)
        a=X{iTrial};
        %disp(size(a))
        CC1(:,:,iTrial)=nt_cov(a)/size(a,1);
    end
    
    % denoising matrices
    nochange=1; % to abort when no effect`
    MM=zeros(nchans,nchans,ntrials);
    for iTrial=1:ntrials
        C1=CC1(:,:,iTrial);
        [todss,pwr0,pwr1]=nt_dss0(C0,C1,[],0);
        fromdss=pinv(todss);
        
        if 0
            figure(9); plot(pwr1./pwr0, '.-'); drawnow; pause(1)
        end
        
        if pwr1(1)./pwr0(1) < thresh
            MM(:,:,iTrial)=eye(nchans);
        else
            nochange=0;
            MM(:,:,iTrial)=todss(:,2:end)*fromdss(2:end,:);
        end
        scores(iTrial,1,iPass)=pwr1(1)./pwr0(1);
    end
    if nochange; break; end

    %figure(10); clf; plot(scores(:,:)); pause
    
    % denoise
    Y=X;
    for iTrial=1:ntrials
        tmp=X{iTrial};
        X{iTrial}=X{iTrial}*MM(:,:,iTrial);
        
        if 0
            figure(10); clf
            subplot 121; plot(tmp)
            subplot 122; plot(X{iTrial});
        end
    end

    %disp(nt_wpwr(X)/original_power);
end
    
Y=X;