function [Y,scores,removed]=nt_subspace_prune6(X,npass,thresh,tol)
%[Y]=nt_subspace_prune6(X,npass,thresh) - local cleaning matrices
%
%  Y: denoised data
%  
%  X: data to denoise (nsamples X nchans X ntrials matrix or array of 2D matrices)
%  npass: number of passes [default: 10]
%  thresh: threshold power ratio between segment & all [default: 10]
%  tol: tolerance factor to speed up calculation [default: 0.5]

if nargin<2||isempty(npass); npass=10; end
if nargin<3||isempty(thresh); thresh=10; end
if nargin<4||isempty(tol); tol=0.5; end

if isnumeric(X)
    % transfer 3D matrix to array of 2D
    if ndims(X)<3; error('!'); end
    tmp={};
    for iTrial=1:size(X,3); 
        tmp{iTrial}=X(:,:,iTrial); 
    end
    X=tmp;
    
    % process
    [Y,scores,removed]=nt_subspace_prune6(X,npass,thresh,tol);
        disp(nt_wpwr(Y)/nt_wpwr(X));
    
    % transfer back to 3D matrix
    tmp=zeros(size(Y{1},1),size(Y{1},2),numel(Y));
    tmp2=zeros(size(Y{1},1),size(removed{1},2),numel(Y));
    for iTrial=1:numel(X) 
        tmp(:,:,iTrial)=Y{iTrial}; 
        tmp2(:,:,iTrial)=removed{iTrial}; 
    end
    Y=tmp;
    removed=tmp2;
    return
end

ntrials=numel(X);
nchans=size(X{1},2);
[C00,tw]=nt_cov(X);
C00=C00/tw;

% matrix array to save removed component/trials
removed={};
for iTrial=1:ntrials
    removed{iTrial}=zeros(size(X{iTrial},1),npass);
end

original_power=nt_wpwr(X);
scores=[]; D=[];
for iPass=1:npass
    
    X=nt_demean2(X);
    
%     for k=1:ntrials
%         X{k}=X{k}/sqrt(mean(X{k}(:).^2));
%     end
    
    % covariance of full data
    [C0,tw]=nt_cov(X); 
    C0=C0/tw;
    
    % mix with original estimate
    alpha=0.01;
    C0=alpha*C00+(1-alpha)*C0;
    
    % find most excentric trial
    iBest=0; best_score=0; 
    CC1=zeros(nchans,nchans,ntrials);
    for iTrial=1:numel(X)
        a=X{iTrial};
        % covariance of this trial
        C1=nt_cov(a)/size(a,1);       
        % contrast this trial with rest
        [todss,pwr0,pwr1]=nt_dss0(C0,C1,[],0);
        % is this trial the most excentric?
        if pwr1(1)/pwr0(1)>best_score
            iBest=iTrial;
            best_score=pwr1(1)/pwr0(1);
        end
        scores(iPass,iTrial)=pwr1(1)/pwr0(1);
        if pwr1(1)<pwr0(1);
            figure(1); clf; plot([pwr1', pwr0']); pause
        end
    end
    
    % remove most excentric component of most excentric trials
    if best_score>thresh
        
        % find other trials for which this component is large
        a=X(iBest);
        C1=nt_cov(a)/(size(a,1)*size(a,3));
        [todss,pwr0,pwr1]=nt_dss0(C0,C1,[],0);
        z=nt_mmat(X,todss(:,1));
        for k=1:ntrials
            p(k)=mean(z{k}.^2);
        end
        p=p/mean(p);
        iRemove=find(p>1/tol);
        
        %disp(numel(iRemove))
        
        % update DSS to fit all trials to be removed
        a=X(iRemove);
        C1=nt_cov(a)/(size(a,1)*size(a,3));
        [todss,pwr0,pwr1]=nt_dss0(C0,C1,[],0);
        fromdss=pinv(todss);
        
        D=todss(:,2:end)*fromdss(2:end,:);
        X0=X;
        X(iRemove)=nt_mmat(X(iRemove),D);
                
        for k=iRemove
            removed{k}(:,iPass)=nt_mmat(X{k},todss(:,1));
        end
    else
        break;
    end

    if ~isreal(scores); return; end
    
    figure(10); clf; nt_imagescc(scores); colorbar;
    %disp(nt_wpwr(X)/original_power);
end

for iTrial=1:ntrials
    removed{iTrial}=removed{iTrial}(:,1:iPass);
end
    
Y=X;