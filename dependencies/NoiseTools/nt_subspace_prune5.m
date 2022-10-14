function [Y,scores]=nt_subspace_prune5(X,npass,thresh)
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
    [Y,scores]=nt_subspace_prune5(X,npass,thresh);
    tmp=zeros(size(Y{1},1),size(Y{2},2),numel(Y));
    for iTrial=1:numel(X) 
        tmp(:,:,iTrial)=Y{iTrial}; 
    end
    Y=tmp;
    return
end

ntrials=numel(X);
nchans=size(X{1},2);

original_power=nt_wpwr(X);
scores=[]; D=[];
for iPass=1:npass
    
    X=nt_demean2(X);
    
    % covariance of full data
    [C0,tw]=nt_cov(X); 
    C0=C0/tw;
    
    iBest=0; best_score=0; 
    CC1=zeros(nchans,nchans,ntrials);
    for iTrial=1:numel(X)
        a=X{iTrial};
        
        % covariance of this trial
        C1=nt_cov(a)/size(a,1);
        
        % contrast this trial with rest
        [todss,pwr0,pwr1]=nt_dss0(C0,C1,[],0);
        fromdss=pinv(todss);
        
        % denoising matrix for this trial
        D{iTrial}=todss(:,2:end)*fromdss(2:end,:);
        
        % is this trial the most excentric?
        if pwr1(1)/pwr0(1)>best_score
            iBest=iTrial;
            best_score=pwr1(1)/pwr0(1);
        end
        scores(iPass,iTrial)=pwr1(1)/pwr0(1);
    end
    
    % remove most excentric component of most excentric trials
    if best_score>thresh
        X{iBest}=nt_mmat(X{iBest},D{iBest});
    else
        break;
    end

    figure(10); clf; nt_imagescc(scores); colorbar;
    %disp(nt_wpwr(X)/original_power);
end
    
Y=X;