%%
addpath(genpath('../'))
%% Compare performance and runtime to robustCov()
fh=figure;
clear ae at ae2 ae3 rcTime rc2Time time
M=6;
Nsamp=1e2;
rmax=5;
at=nan(rmax,1);
ae=nan(rmax,1);
ae2=nan(rmax,1);
ae3=nan(rmax,1);
rt=nan(rmax,1);
re=nan(rmax,1);
re2=nan(rmax,1);
re3=nan(rmax,1);
Nreps=1e2;
cut=90;
for r=1:rmax %Percent outliers
Qsqrt=randn(M,M);
Q=Qsqrt*Qsqrt';

% Estimate:

Qest=nan(M,M,Nreps);
Qest2=nan(M,M,Nreps);
Qest3=nan(M,M,Nreps);
Qtrue=nan(M,M,Nreps);
rcTime=nan(Nreps,1);
rc3Time=nan(Nreps,1);
rc2Time=nan(Nreps,1);
time=nan(Nreps,1);
for i=1:Nreps
% Generate data:
X=Qsqrt*randn(size(Q,2),Nsamp);
X=X+1e1*repmat((rand(1,Nsamp)>(1-2*r/100)).*(randn(1,Nsamp)),size(Q,2),1); 
%Add r% outliers
% Estimate:
tic
Qest(:,:,i)=robCov(X); %My robust estimate, self-estimate of %
rcTime(i)=toc;
tic
Qest3(:,:,i)=robCov(X,cut); %My robust estimate, self-estimate of %
rc3Time(i)=toc;
tic
Qest2(:,:,i)=robustcov(X'); %MAtlab built-in
rc2Time(i)=toc;
tic
Qtrue(:,:,i)=X*X'/size(X,2); %Standard, MLE, estimate given a known mean
time(i)=toc;
end

% Visualize
at(r)=mean(sqrt((sum(sum((Q-Qtrue).^2,1),2))),3)/norm(Q,'fro');
ae(r)=mean(sqrt((sum(sum((Q-Qest).^2,1),2))),3)/norm(Q,'fro');
ae2(r)=mean(sqrt((sum(sum((Q-Qest2).^2,1),2))),3)/norm(Q,'fro');
ae3(r)=mean(sqrt((sum(sum((Q-Qest3).^2,1),2))),3)/norm(Q,'fro');
rt(r)=mean(time);
re(r)=mean(rcTime);
re2(r)=mean(rc2Time);
re3(r)=mean(rc3Time);
end
subplot(2,1,1)
p1=scatter([1:length(at)]*2,at,'filled','DisplayName','MLE');
hold on
p3=scatter([1:length(at)]*2,ae,'filled','DisplayName',['robCov(AUTO)']);
p2=scatter([1:length(at)]*2,ae2,'filled','DisplayName',['robustcov()']);
p4=scatter([1:length(at)]*2,ae3,'filled','DisplayName',['robcov(90%)']);
title(['Performance comparison to robustcov() [same conds as above]'])
xlabel('% outliers')
ylabel('|\hat{Q}-Q|_F / |Q|_F')
legend
set(gca,'YScale','log')
subplot(2,1,2)
p1=scatter([1:length(at)]*2,rt,'filled','DisplayName','MLE');
hold on
p3=scatter([1:length(at)]*2,re,'filled','DisplayName',['robCov(AUTO)']);
p2=scatter([1:length(at)]*2,re2,'filled','DisplayName',['robustCov()']);
p4=scatter([1:length(at)]*2,re3,'filled','DisplayName',['robCov(90%)']);
xlabel('% outliers')
ylabel('Avg. run time (s)')
legend
set(gca,'YScale','log')
title('Run time comparison to robustcov()')
%%
savefig(gcf,'testCompare.fig')