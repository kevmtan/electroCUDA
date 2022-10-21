function [A,B,RR]=nt_cca_crossvalidate2(xx,yy,shifts)
%[A,B,RR]=nt_cca_crossvalidate2(xx,yy,shifts) - CCA with cross-validation
%
%  A,B: transform matrices calculated on first half of trials
%  RR: r scores (3D) for second half of trials
%
%  xx,yy: cell arrays of column matrices
%  shifts: array of shifts to apply to y relative to x (can be negative)

if nargin<3 || isempty (shifts); shifts=[0]; end
if nargin<2; error('!'); end
if ~iscell(xx) || ~iscell(yy); error('!'); end
if length(xx) ~= length (yy); error('!'); end
if size(xx{1},1) ~= size(yy{1},1); error('!'); end

iFirstHalf=1:round(numel(xx)/2);
iSecondHalf=round(numel(xx)/2)+1:numel(xx);

nTrials=length(xx);
n=size(xx{1},2)+size(yy{1},2);

% calculate covariance matrix on first half
C=zeros(n,n,length(shifts));
disp('Calculate all covariances...'); tic;
nt_whoss;
for iTrial=iFirstHalf
    C=C+nt_cov_lags(xx{iTrial}, yy{iTrial},shifts);
end
toc;

% calculate CCA on first half
[A,B,R]=nt_cca([],[],[],C,size(xx{1},2));  % CCA to apply to that trial (trained on others)clear C CC
toc;

%%
% calculate correlation coefficients on second half
disp('Calculate cross-correlations...'); tic;
for iShift=1:length(shifts)
    xxx={}; yyy={};
    % shift, trim to same length, convert to CCs, normalize
    for iTrial=1:nTrials
        [xxx{iTrial},yyy{iTrial}]=nt_relshift(xx{iTrial},yy{iTrial},shifts(iShift));
        xxx{iTrial}=nt_normcol( nt_demean( nt_mmat(xxx{iTrial},A(:,:,iShift)) ) );
        yyy{iTrial}=nt_normcol( nt_demean( nt_mmat(yyy{iTrial},B(:,:,iShift)) ) );
    end
    for iTrial=1:numel(iSecondHalf)
        x=xxx{iSecondHalf(iTrial)};
        y=yyy{iSecondHalf(iTrial)};
        RR(:,iShift,iTrial)=diag(x'*y) / size(x,1);
    end
end
toc;

disp('done');

