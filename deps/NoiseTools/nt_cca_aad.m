function [D,E,R]=nt_cca_aad(xA,xB,y,ssize)
%[D,E,R]=nt_cca_match_aad(xA,xB,y,ssize) - calculate metrics for match-mismatch task
%
%  D: d-prime 
%  E: error rate
%  R: correlation coefficient over entire trial
%
%  xA,xB: stimulus streams
%  y: response 
%  ssize: samples, segment size [default: all]

if nargin<3; error('!'); end
if nargin<4; ssize=[]; end

if ssize ~= round(ssize); error('!'); end

% clip all trials to same size multiple of wsize
n=size(xA{1},1); % min size?
for iTrial=1:numel(xA)
    if size(xA{iTrial}) ~= size(xB{iTrial}); error('!'); end
    if size(xA{iTrial}) ~= size(y{iTrial}); error('!'); end
    n=min(n,size(xA{iTrial},1));
end
if isempty(ssize); ssize=n; end
n=ssize*floor(n/ssize); % reduce to multiple of wsize
if n<1; error('!'); end
for iTrial=1:numel(xA)
    xA{iTrial}=nt_demean(xA{iTrial}(1:n,:)); % clip trials to new length
    xB{iTrial}=nt_demean(xB{iTrial}(1:n,:)); % clip trials to new length
    y{iTrial}=nt_demean(y{iTrial}(1:n,:));
end
nsegments=n/ssize;
ntrials=numel(xA);

% merge stimulus streams
x={};
for iTrial=1:numel(xA)
    x{iTrial}=[xA{iTrial},xB{iTrial}];
end

% CCA
shifts=[0];
[AA,BB,RR]=nt_cca_crossvalidate(xA,y,shifts);
R=mean(RR,3);

for iTrial=1:ntrials
    
    % calculate model on data excluding this trial
    others=setdiff(1:ntrials,iTrial);
    
    % CCs
    xA_CC=nt_mmat(xA(others),AA{iTrial});
    xB_CC=nt_mmat(xB(others),AA{iTrial});
    yCC=nt_mmat(y(others),BB{iTrial});
    ncomp=size(xA_CC{1},2);

    % cut into segments
    XA=zeros(ssize,ncomp,numel(others),nsegments);
    XB=zeros(ssize,ncomp,numel(others),nsegments);
    Y=zeros(ssize,ncomp,numel(others),nsegments);
    for iTrial2=1:numel(others)
        for iWindow=1:nsegments
            start=(iWindow-1)*ssize;
            XA(:,:,iTrial2,iWindow)=nt_normcol(nt_demean(xA_CC{iTrial2}(start+(1:ssize),:))); % all mean 0 norm 1
            XB(:,:,iTrial2,iWindow)=nt_normcol(nt_demean(xB_CC{iTrial2}(start+(1:ssize),:))); 
            Y(:,:,iTrial2,iWindow)=nt_normcol(nt_demean(yCC{iTrial2}(start+(1:ssize),:)));
        end
    end
    
    % Euclidean distance between EEG and envelope segments
    
%     figure(1); clf; 
%     subplot 211; 
%     plot([XA(:,1,1,1),Y(:,1,1,1)]); title(corr(XA(:,1,1,1),Y(:,1,1,1)))
%     subplot 212; 
%     plot([XB(:,1,1,1),Y(:,1,1,1)]); title(corr(XB(:,1,1,1),Y(:,1,1,1))); pause
    
    % match
    D_match=sqrt(mean((XA-Y).^2));
    sz=size(D_match); D_match=reshape(D_match,sz(2:end)); % remove initial singleton
    D_match=D_match(:,:)'; % trials X comps

    % mismatch
    D_mismatch=sqrt(mean((XB-Y).^2));
    sz=size(D_mismatch); D_mismatch=reshape(D_mismatch,sz(2:end));
    D_mismatch=D_mismatch(:,:)'; % trials X comps

%     figure(1); clf; 
%     plot([D_match(:,1),D_mismatch(:,1)]); pause
    
    c0=nt_cov(D_mismatch)/size(D_mismatch,1);
    c1=nt_cov(D_match)/size(D_match,1);
    [todss,pwr0,pwr1]=nt_dss0(c1,c0);
    if mean(D_match*todss(:,1))<0; todss=-todss; end
    
    %figure(1); clf; plot(pwr1./pwr0,'.-'); pause
    if 1
    DD_match=D_match*todss(:,1);
    DD_mismatch=D_mismatch*todss(:,1);
    else
    DD_match=D_match(:,1);
    DD_mismatch=D_mismatch(:,1);
    end

%     figure(1); clf; 
%     plot([DD_match(:,1),DD_mismatch(:,1)]); pause
    

    dprime(iTrial)=abs(mean(DD_match)-mean(DD_mismatch)) / std([DD_match-mean(DD_match); DD_mismatch-mean(DD_mismatch)]);    
%     disp(dprime(iTrial));
%     DD_match=D_match(:,1);
%     DD_mismatch=D_mismatch(:,1);
%     dprime(iTrial)=abs(mean(DD_match)-mean(DD_mismatch)) / std([DD_match-mean(DD_match); DD_mismatch-mean(DD_mismatch)]);    
%     disp(dprime(iTrial));
    
    %{
    We now have a CCA solution and a JD transform calculated
    on other trials. 
    
    We apply them to segments of this trial.
    %}
    
    % apply same CCA transform:
    xA_x=nt_mmat(xA{iTrial},AA{iTrial});
    xB_x=nt_mmat(xB{iTrial},AA{iTrial});
    y_x=nt_mmat(y{iTrial},BB{iTrial});
    
    % cut CCs into segments
    XA_x=zeros(ssize,ncomp,nsegments);
    XB_x=zeros(ssize,ncomp,nsegments);
    Y_x=zeros(ssize,ncomp,nsegments);
    for iWindow=1:nsegments
        start=(iWindow-1)*ssize;
        XA_x(:,:,iWindow)=nt_normcol(nt_demean(xA_x(start+(1:ssize),:)));
        XB_x(:,:,iWindow)=nt_normcol(nt_demean(xB_x(start+(1:ssize),:)));
        Y_x(:,:,iWindow)=nt_normcol(nt_demean(y_x(start+(1:ssize),:)));
    end
    
%     figure(1); clf
%     subplot 211;
%     plot([XA_x(:,1,iWindow), Y_x(:,1,iWindow)]);title(corr(XA_x(:,1,iWindow), Y_x(:,1,iWindow)));
%     subplot 212;
%     plot([XB_x(:,1,iWindow), Y_x(:,1,iWindow)]);title(corr(XB_x(:,1,iWindow), Y_x(:,1,iWindow)));
%     
%     figure(2); clf
%     nt_spect_plot(XA_x(:,1,iWindow), 1024,[],[],64); hold on;
%     nt_spect_plot(Y_x(:,1,iWindow), 1024,[],[],64);
%     pause
    
    % Euclidean distance for matched and mismatched segments
    D_match_x=zeros(nsegments,ncomp);
    D_mismatch_x=zeros(nsegments,ncomp);
    for iWindow=1:nsegments
        D_match_x(iWindow,:)=sqrt( mean((XA_x(:,:,iWindow)-Y_x(:,:,iWindow)).^2) );
        D_mismatch_x(iWindow,:)=sqrt( mean((XB_x(:,:,iWindow)-Y_x(:,:,iWindow)).^2) );
    end        
    
    if 1
        D_match_x=D_match_x*todss(:,1);
        D_mismatch_x=D_mismatch_x*todss(:,1);
    else
        D_match_x=D_match_x(:,1);
        D_mismatch_x=D_mismatch_x(:,1);
    end     
%       figure(2); clf;
%       plot([D_match_x,D_mismatch_x])
%      pause
    
    err(iTrial)=numel(find(D_mismatch_x<D_match_x))/nsegments;
    %disp(err(iTrial))
end

D=mean(dprime);
E=mean(err);


