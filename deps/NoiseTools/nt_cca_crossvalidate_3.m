function [AA,BB,RR,iBest]=nt_cca_crossvalidate(xx,yy,shifts,ncomp,A0,B0,K)
%[AA,BB,RR,iBest]=nt_cca_crossvalidate(xx,yy,shifts,ncomp,A0,B0) - CCA with cross-validation
%
%  AA, BB: cell arrays of transform matrices
%  RR: r scores (3D) for all components, shifts and trials
%  iBest: index of best shift
%
%  xx,yy: cell arrays of column matrices
%  shifts: array of shifts to apply to y relative to x (can be negative)
%  ncomp: number of components to consider for iBest [default: all]
%  A0,B0: if present, use these CCA transform matrices 
%
%  Plot correlation re shifts for matching trials
%    plot(shifts, mean(RR,3)');
%  Plot mean correlation re shifts for mismatched trials
%    plot(shifts, mean(mean(RR,4),3)');

if nargin<6; K=3; end
if nargin<5
    A0=[]; B0=[]; 
end
if nargin<4; ncomp=[]; end
if nargin<3 || isempty (shifts); shifts=[0]; end
if nargin<2; error('!'); end
if ~iscell(xx) || ~iscell(yy); error('!'); end
if length(xx) ~= length (yy); error('!'); end
%if size(xx{1},1) ~= size(yy{1},1); error('!'); end
if size(xx{1},1) ~= size(yy{1},1); 
    for iTrial=1:numel(xx);
        tmp=min(size(xx{iTrial},1),size(yy{iTrial},1));
        xx{iTrial}=xx{iTrial}(1:tmp,:);
        yy{iTrial}=yy{iTrial}(1:tmp,:);
    end
end

nTrials=length(xx);

if isempty(A0)
    % calculate covariance matrices
    n=size(xx{1},2)+size(yy{1},2);
    C=zeros(n,n,length(shifts),nTrials);
    disp('Calculate all covariances...'); tic;
    nt_whoss;
    for iTrial=1:nTrials
        C(:,:,:,iTrial)=nt_cov_lags(xx{iTrial}, yy{iTrial},shifts);
    end

    % calculate leave-one-out CCAs
    disp('Calculate CCAs...'); tic;
    for iTrial=1:nTrials
        others=setdiff(1:nTrials,iTrial);
        others=others(1:K);
        CC=sum(C(:,:,:,others),4); % covariance of all trials except iOut
        [A,B,R]=nt_cca([],[],[],CC,size(xx{1},2));  % CCA to apply to that trial (trained on others)
        AA{iTrial}=A;
        BB{iTrial}=B;
    end
    clear C CC
    toc;
else
    % set to given values
    for iTrial=1:nTrials
        AA{iTrial}=A0;
        BB{iTrial}=B0;
    end
end

%%
% calculate leave-one-out correlation coefficients
disp('Calculate cross-correlations...'); tic;
for iShift=1:length(shifts)
    xxx={}; yyy={};
    % shift, trim to same length, convert to CCs, normalize
    for iTrial=1:nTrials
        [xxx{iTrial},yyy{iTrial}]=nt_relshift(xx{iTrial},yy{iTrial},shifts(iShift));
        xxx{iTrial}=nt_normcol( nt_demean( nt_mmat(xxx{iTrial},AA{iTrial}(:,:,iShift)) ) );
        yyy{iTrial}=nt_normcol( nt_demean( nt_mmat(yyy{iTrial},BB{iTrial}(:,:,iShift)) ) );
    end
    for iTrial=1:nTrials
        x=xxx{iTrial};
        y=yyy{iTrial};
        RR(:,iShift,iTrial)=diag(x'*y) / size(x,1);
    end
end
toc;

if isempty(ncomp); ncomp=size(RR,1); end
[~,iBest]=max(mean(mean(RR(1:ncomp,:,:),3),1)'); 

disp('done');

