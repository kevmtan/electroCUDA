function [Y,excentricity,removed,cov1,cov2]=nt_LSP(X,npass,thresh,tol,guard)
%[Y,scores,removed]=nt_LSP(X,npass,thresh,tol,guard) - local subspace pruning
%
%  Y: denoised data
%  scores: record of excentricity scores for each trial and each pass
%  removed: components removed
%  
%  X: data to denoise (nsamples X nchans X ntrials matrix or array of 2D matrices)
%  npass: number of passes [default: 10]
%  thresh: threshold excentricity score [default: 10]
%  tol: tolerance factor to speed up calculation [default: 0.5]
%  guard: don't modify channels with correlation below this limit [default: 0.1]
%
% For each trial, JD is used to contrast it with all other trials.  If the
% power ratio ('score') of the first component is above threshold, that
% component is discarded from that trial.
%
% NoiseTools.

if nargin<2||isempty(npass); npass=10; end
if nargin<3||isempty(thresh); thresh=10; end
if nargin<4||isempty(tol); tol=0.5; end
if nargin<5||isempty(guard); guard=0.1; end

if isnumeric(X)
    % transfer 3D matrix to array of 2D
    if ndims(X)<3; error('!'); end
    tmp={};
    for iTrial=1:size(X,3); 
        tmp{iTrial}=X(:,:,iTrial); 
    end
    X=tmp;
    
    % process
    [Y,excentricity,removed,cov1,cov2]=nt_lsp(X,npass,thresh,tol);
    
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

% create matrix array to save removed component/trials
removed={};
for iTrial=1:ntrials
    removed{iTrial}=zeros(size(X{iTrial},1),npass);
end

excentricity=[]; D=[]; score_fig=figure(10);
cov1=zeros(size(X{1},2),size(X{1},2),npass+1);
cov2=zeros(size(X{1},2),size(X{1},2),npass+1);
cov1(:,:,1)=nt_cov(X); 
%disp(size(X{1}));
%disp(size(nt_trial2mat(X)));
cov2(:,:,1)=nt_cov(mean(nt_trial2mat(X),3));
for iPass=1:npass
    
    X=nt_demean2(X);
    
%     for k=1:ntrials
%         X{k}=X{k}/sqrt(mean(X{k}(:).^2));
%     end
    
    % covariance of full data
    [C0,tw]=nt_cov(X); 
    %[C0,tw]=nt_cov_smr(X); 
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
        excentricity(iPass,iTrial)=pwr1(1)/pwr0(1);
%         if pwr1(1)<pwr0(1)
%             figure(1); clf; plot([pwr1', pwr0']); title([pwr0(1), pwr1(1)]); drawnow; pause
%         end
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
        iRemove=find(p/max(p)>tol & p>thresh);
        if isempty(iRemove); break; end
        
        disp(numel(iRemove))
        
        % update DSS to fit all trials to be removed
        a=X(iRemove);
        C1=nt_cov(a)/(size(a,1)*size(a,3));
        [todss,pwr0,pwr1]=nt_dss0(C0,C1,[],0);
        fromdss=pinv(todss);

        
        D=todss(:,2:end)*fromdss(2:end,:); % denoising matrix
        X0=X;
        X(iRemove)=nt_mmat(X(iRemove),D);
        
        if 0
            a=nt_unfold(nt_cell2mat(X(iRemove)));
            b=nt_unfold(nt_cell2mat(X0(iRemove)));
            r=diag(corr(b,a-b));
            thresh_r=guard; % don't modify channels with correlation below this
            mask=abs(r)<thresh_r;

            for k=iRemove
                X{k}(:,mask)=X0{k}(:,mask); % revert masked channels
            end

            for k=iRemove
                removed{k}(:,iPass)=nt_mmat(X{k},todss(:,1));
            end
        end
    else
        break;
    end

    if ~isreal(excentricity); return; end
    
    if nt_verbose 
        set(0,'currentfigure',score_fig); clf; 
        imagesc(excentricity); 
        h=colorbar; set(get(h,'label'),'string','excentricity score');
        xlabel('trial'); ylabel('pass'); drawnow
    end
    cov1(:,:,iPass+1)=nt_cov(nt_cell2mat(X));
    cov2(:,:,iPass+1)=nt_cov(mean(nt_cell2mat(X),3));
end

for iTrial=1:ntrials
    removed{iTrial}=removed{iTrial}(:,1:iPass);
end
    
Y=X;