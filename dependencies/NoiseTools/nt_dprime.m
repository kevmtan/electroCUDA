function [d,e]=nt_dprime(x,y,jd_flag)
%[d,e]=nt_dprime(x,y,jd_flag) - calculate d' (discriminability) of two distributions
%
%  d: discriminablity index
%  e: error rate for linear discrimination
%
%  x, y: data (observtions X features) - if cell arrays do xvalidation
%  jd_flag: apply JD first
% 
% See nt_dprime_old for earlier implementation (deprecated).
% 
% NoiseTools

if nargin<3; jd_flag=[]; end
if nargin<2; error('!'); end

if ~iscell(x); x={x,x}; end % no crossvalidation but will use same code 
if ~iscell(y); y={y,y}; end

for iCell=1:numel(x)
    if size(x{iCell},2) ~= size(y{iCell},2); error('!'); end
    xx=x{iCell}; yy=y{iCell};
    others=setdiff(1:numel(x),iCell);
    xxx=x(others); xxx=cat(1,xxx{:});
    yyy=y(others); yyy=cat(1,yyy{:});
    if jd_flag; 
        c0=nt_cov(nt_demean(xxx))+nt_cov(nt_demean(yyy));
        c1=nt_cov(mean(xxx)-mean(yyy));
        todss=nt_dss0(c0,c1);
        xxx=nt_mmat(xxx,todss); % others
        yyy=nt_mmat(yyy,todss);
        xx=nt_mmat(xx,todss); % this cell
        yy=nt_mmat(yy,todss);
    end

    % d-prime on left-out data
    d(iCell,:)=abs(mean(xx)-mean(yy)) ./ sqrt((var(xx)+var(yy))/2);

    % error rate on left-out data
    for iChan=1:size(xx,2);
        dxx=(xx(:,iChan)-mean(xxx(:,iChan))).^2;
        dxy=(xx(:,iChan)-mean(yyy(:,iChan))).^2;
        dyx=(yy(:,iChan)-mean(xxx(:,iChan))).^2;
        dyy=(yy(:,iChan)-mean(yyy(:,iChan))).^2;
        nMissX=numel(xx(find(dxx>dxy),iChan));
        nMissY=numel(yy(find(dyy>dyx),iChan));
        ex(iCell,iChan)=nMissX/numel(xx(:,iChan)); % xs misclassified as ys
        ey(iCell,iChan)=nMissY/numel(yy(:,iChan)); % ys misclassified as xs
    end
end

d=mean(d); 
ex=mean(ex);
ey=mean(ey);
e=(ex+ey)/2;



% test code
if 0
    x=randn(10000,1);
    y=1+randn(10000,1);
    figure(1); clf
    t=-3:0.1:6;
    plot(t,hist(x,t));
    hold on;
    plot(t,hist(y,t), 'r');
    [d,e]=nt_dprime(x,y);
    disp(['d'': ', num2str(d)]);
    disp(['error: ', num2str(e)]);
end
if 0
    x={randn(10000,1),randn(10000,1)};
    y={1+randn(10000,1),1+randn(10000,1)};
    [d,e]=nt_dprime(x,y);
    disp(['d'': ', num2str(d)]);
    disp(['error: ', num2str(e)]);
end
