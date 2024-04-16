addpath(genpath('../'))
%%
fh=figure;
%% Test as function of matrix size
subplot(3,1,1)
clearvars
cut=90;
Nsamp=1e3;
Nreps=1e2;
estim=cell(3,1);
cuts=[90,80];
Mmax=5;
for i=1:length(estim)
    estim{i}=nan(Nreps,Mmax);
end
for M=1:Mmax %data log-size
    for i=1:Nreps
        Qsqrt=randn(M,M);
        Q=Qsqrt*Qsqrt';
        % Generate data:
        X=Qsqrt*randn(size(Q,2),Nsamp);
        % Error:
        estim{1}(i,M)=covError(Q,X*X'/size(X,2));
        for j=2:length(estim)
            estim{j}(i,M)=covError(Q,robCov(X,cuts(j-1)));
        end
    end
end

p1=scatter(1:Mmax,mean(estim{1}),'filled','DisplayName','MLE');
hold on
for i=2:length(estim)
    p3=scatter(1:Mmax,mean(estim{i}),'filled','DisplayName',['Robust, cut=' num2str(cuts(i-1))]);
end
title(['Nreps=' num2str(Nreps) ', Nsamples=' num2str(Nsamp) ', no outliers, reject=' num2str(100-cut) '%'])
xlabel('Covariance size (dimension) (M)')
ylabel('Mean |\hat{Q}-Q|_F / |Q|_F')
legend
%% Test as function of data size
subplot(3,1,2)
clearvars
M=6;
Nreps=1e2;
estim=cell(3,1);
cuts=[90,80];
Mmax=5;
for i=1:length(estim)
    estim{i}=nan(Nreps,Mmax);
end
for l=1:Mmax %data log-size
    for i=1:Nreps
        Qsqrt=randn(M,M);
        Q=Qsqrt*Qsqrt';
        % Generate data:
        X=Qsqrt*randn(size(Q,2),10^l);
        % Error:
        estim{1}(i,l)=covError(Q,X*X'/size(X,2));
        for j=2:length(estim)
            estim{j}(i,l)=covError(Q,robCov(X,cuts(j-1)));
        end
    end
end

p1=scatter(1:Mmax,mean(estim{1}),'filled','DisplayName','MLE');
hold on
for i=2:length(estim)
    p3=scatter(1:Mmax,mean(estim{i}),'filled','DisplayName',['Robust, cut=' num2str(cuts(i-1))]);
end
title([num2str(M) ' x ' num2str(M) ' matrix, Nreps=' num2str(Nreps) ', no outliers'])
xlabel('Log_{10}(sample size)')
ylabel('|\hat{Q}-Q|_F / |Q|_F')
legend
set(gca,'YScale','log')

%% Test with outliers: different iteration number (to show Niter=2 is suff)
subplot(3,1,3)
clearvars
cut=90;
M=6;
Nsamp=1e2;
rmax=13;
Nreps=1e2;
estim=cell(4,1);
Niter=[1,2,10];
for i=1:length(estim)
    estim{i}=nan(Nreps,rmax);
end
for l=1:3:rmax %Percent outliers
    for i=1:Nreps
        Qsqrt=randn(M,M);
        Q=Qsqrt*Qsqrt';
        % Generate data:
        X=Qsqrt*randn(size(Q,2),Nsamp);
        X=X+1e1*repmat((rand(1,Nsamp)>(1-l/100)).*(randn(1,Nsamp)),size(Q,2),1); 
        %Add r% outliers
        % Error:
        estim{1}(i,l)=covError(Q,X*X'/size(X,2));
        for j=2:length(estim)
            estim{j}(i,l)=covError(Q,robCov(X,cut,Niter(j-1)));
        end
    end
end


p1=scatter(1:rmax,mean(estim{1}),'filled','DisplayName','MLE');
hold on
for i=2:length(estim)
    p3=scatter(1:rmax,mean(estim{i}),'filled','DisplayName',['Robust, Niter=' num2str(Niter(i-1))]);
end
title([num2str(M) ' x ' num2str(M) ' matrix, Nreps=' num2str(Nreps) ', Nsamples=' num2str(Nsamp) ', reject=' num2str(100-cut) '%, single axis noise'])
xlabel('% outliers')
ylabel('|\hat{Q}-Q|_F / |Q|_F')
legend
set(gca,'YScale','log')

%%
%savefig(gcf,'testParams.fig')