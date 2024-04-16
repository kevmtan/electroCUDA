%% Testing robCov() for unbiasedness under multinormal assumption
%this script compares the performance of the robCov() estimator vs. the
%standard MLE estimator of covariance of a sample with known mean (assumed
%mean =0), for data drawn from a randomly chosen multinormal distribution,
%for different values of the parameters (dimension size, sample size,
%contamination with outlier samples).
%TODO: add measure of dispersion/worst case performance
%%
addpath(genpath('../'))
%%
clearvars
fh=figure;
cut=90;
    M=2;
    Nsamp=1e2;
    Nreps=1e2;
    rmax=30;

%% Test with outliers: single axis normal noise
for k=1:4
    at=nan(rmax,1);
    ae=nan(rmax,1);
    ae2=nan(rmax,1);
    ae3=nan(rmax,1);
    aeA=nan(rmax,1);
    for r=1:3:rmax %Percent outliers
        Qsqrt=randn(M,M);
        Q=Qsqrt*Qsqrt';
        
        % Estimate:
        Qest=nan(M,M,Nreps);
        Qest2=nan(M,M,Nreps);
        Qest3=nan(M,M,Nreps);
        Qtrue=nan(M,M,Nreps);
        QestA=nan(M,M,Nreps);
        for i=1:Nreps
            % Generate data:
            X=Qsqrt*randn(size(Q,2),Nsamp);
            noiseIdx=(rand(1,Nsamp)>(1-r/100)); %Add r% outliers, to observe the robustness.
            Nn=sum(noiseIdx);
            switch k 
                case 1 %aditive single axis normal noise
                    noise=6*repmat((randn(1,Nn)),size(Q,2),1);
                    nameNoise='single axis normal';
                    %Outliers are drawn from
                    %an univariate normal with var=100, mean=0, and aligned along the x1=x2=...=xM
                    %direction
                case 2 %Ring noise
                    aux=randn(M,Nn);
                    noise=10*aux./sqrt(sum(aux.^2,1));  
                    nameNoise='ring';
                case 3 %Cluster noise
                    noise=randn(M,Nn)+4;
                    nameNoise='cluster';
                case 4
                    noise=randn(M,Nn);
                    noise=noise+4*(noise(1,:)>0) +[0;3].*(noise(1,:)<0);
                    nameNoise='double cluster';
            end
            X(:,noiseIdx)=noise; 
            % Estimate:
            [Qest(:,:,i),idx1]=robCov(X,cut); %My robust estimate
            [Qest2(:,:,i),idx2]=robCov(X,100-2*(100-cut)); %My robust estimate
            [Qest3(:,:,i),idx3]=robCov(X,100-.5*(100-cut)); %My robust estimate
            Qtrue(:,:,i)=X*X'/size(X,2); %Standard, MLE, estimate given a known mean
            [QestA(:,:,i),idxA]=robCov(X); %My robust estimate, auto
        end

        % Visualize
        at(r)=mean(sqrt(sum(sum((Q-Qtrue).^2,1),2)),3)/norm(Q,'fro');
        ae(r)=mean(sqrt(sum(sum((Q-Qest).^2,1),2)),3)/norm(Q,'fro');
        ae2(r)=mean(sqrt(sum(sum((Q-Qest2).^2,1),2)),3)/norm(Q,'fro');
        ae3(r)=mean(sqrt(sum(sum((Q-Qest3).^2,1),2)),3)/norm(Q,'fro');
        aeA(r)=mean(sqrt(sum(sum((Q-QestA).^2,1),2)),3)/norm(Q,'fro');
    end
    subplot(4,2,2*k-1)
    p1=scatter(1:length(at),at,'filled','DisplayName','MLE');
    hold on
    p3=scatter(1:length(ae),ae2,'filled','DisplayName',['Robust, reject=' num2str(2*(100-cut)) '%']);
    p2=scatter(1:length(ae),ae,'filled','DisplayName',['Robust, reject=' num2str(100-cut) '%']);
    p4=scatter(1:length(ae),ae3,'filled','DisplayName',['Robust, reject=' num2str(.5*(100-cut)) '%']);
    p5=scatter(1:length(ae),aeA,'filled','DisplayName',['Robust, reject= AUTO']);
    title([num2str(M) ' x ' num2str(M) ' matrix, Nreps=' num2str(Nreps) ', Nsamples=' num2str(Nsamp) ', ' nameNoise ' noise'])
    xlabel('% outliers')
    ylabel('|\hat{Q}-Q|_F / |Q|_F')
    legend
    set(gca,'YScale','log')
    if M==2
        %TODO: For M>2, project everything onto first 2PCs and plot that
        subplot(4,2,2*k)
        scatter(X(1,:),X(2,:),20,'filled')
        hold on
        scatter(noise(1,:),noise(2,:),20,'filled')
        eh=drawEllipse2D(pinv(5*Qest(:,:,end)));
        eh.Color=p2.CData;
        eh.LineWidth=2;
        eh=drawEllipse2D(pinv(5*Qest2(:,:,end)));
        eh.Color=p3.CData;
        eh.LineWidth=2;
        eh=drawEllipse2D(pinv(5*Qest3(:,:,end)));
        eh.Color=p4.CData;
        eh.LineWidth=2;
        eh=drawEllipse2D(pinv(5*Qtrue(:,:,end)));
        eh.Color=p1.CData;
        eh.LineWidth=2;
        eh=drawEllipse2D(pinv(5*Q));
        eh.Color=[0 0 0];
        eh.LineWidth=2;
        scatter(X(1,idxA),X(2,idxA),8,'g','filled')
        scatter(X(1,idx1),X(2,idx1),3,'m','filled')
    end
end
