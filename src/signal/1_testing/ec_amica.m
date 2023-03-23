function [A,c,LL,Lt,gm,alpha,mu,beta,rho] = ec_amica(x,M,m,o)
% function [A,c,LL,gm,alpha,mu,beta,rho] = amica_ex(x,[M,m,maxiter,update_rho,mindll,iterwin,do_newton,As,cs])
%
% Performs AMICA algorithm for adaptive mixutre ICA on input data x (of dimension n x N), using M models,
% with adaptive source densities unsing a mixture of m Generalized Gaussians, with fixed or adaptive shape.
%
% Stopping condition is when avg log likelihood increase is less than mindll (averaged over iterwin iterations)
% and when norm of updates is smaller than minndw.
%
% Inputs:
%
%       x           --  data, channels (n) by time points (N)
%       M           --  number of ICA mixture models (default is 1)
%       m           --  number of source density mixtures (default is 3)
%       maxiter     --  maximum number of iterations to perform (default is 500)
%       update_rho  --  1 = update the generalized gaussian shape parameters (default)
%                       0 = set all density shapes to 2 (Gaussian), do not update shape
%                       -rho0 = set density shapes to rho0, do not update shape
%       mindll      --  stop when avg log likelihood changing less than this (default is 1e-8)
%       iterwin     --  window over which to do moving avg of log likelihood (default is 50)
%       do_newton   --  1 = use Newton update for upmixing matrices
%                       0 = use natural gradient updates
%       remove_mean --  make the data zero mean (default is 1 == yes)
%       As          --  (optional) true generating basis for plotting purposes
%       cs          --  (optional) true model centers
%
% Outputs:
%
%       A           --  learned mixing matrix with normalized columns, pinv(A) is unmixing matrix ( n x n x M )
%       c           --  learned model centers  ( n x M )
%       LL          --  history of likelihood over iterations ( 1 x min(iter,maxiter) )
%       Lt          --  log likelihood of time point for each model ( M x N )
%       gm          --  learned ica model mixture proportions ( 1 x M )
%       alpha       --  learned source density mixture proportions ( m x n x M )
%       mu          --  learned source density location parameter ( m x n x M )
%       beta        --  learned source density inverse scale parameter ( m x n x M )
%       rho         --  learned source density shape paramters ( m x n x M )
%
%
% Author: Jason Palmer (jason@sccn.ucsd.edu), Swartz Center for Computational Neuroscience, 2008.
% Modified: Kevin Tan - implement in GPU/CUDA (kevmtan.github.io)
%
% Publication: J. A. Palmer, S. Makeig, K. Kreutz-Delgado, and B. D. Rao, Newton Method for the ICA Mixture Model,
%              in Proceedings of the 33rd IEEE International Conference on Acoustics and Signal Processing (ICASSP 2008),
%              Las Vegas, NV, pp. 1805-1808, 2008.

%% Input validation
arguments
    x {mustBeFloat}
    M (1,1){isnumeric} = 1
    m (1,1){isnumeric} = 3
    o.maxiter (1,1){isnumeric} = 500
    o.update_rho (1,1){isnumeric} = 1
    o.mindll (1,1){isfloat} = 1e-8
    o.iterwin (1,1){isnumeric} = 50
    o.do_newton (1,1) logical = true
    o.remove_mean (1,1) logical = true
    o.lrate (1,1){isfloat} = 0.1
    o.showLL (1,1) logical = true % display the log likelihood at each iteration
    %o.As {isnumeric} = []
    %o.cs {isnumeric} = []
end
update_rho = o.update_rho;
rholrate = 0.1;
rhomin = 1.0;
rhomax = 2;
if isempty(update_rho)
    update_rho = 1;
    rho0 = 1.5;
else
    if update_rho < 0
        update_rho = 0;
        rho0 = -update_rho;
    elseif update_rho == 0
        update_rho = 0;
        rho0 = 2;
    elseif update_rho == 1
        update_rho = 1;
        rho0 = 1.5;
    else
        rho0 = min(rhomax,update_rho);
        rho0 = max(rhomin,rho0);
        update_rho = 1;
    end
end

lrate = o.lrate; %lrate0 = 0.1;
lratemax = 1.0;
lnatrate = 0.1;
lnatratemax = 0.1;
newt_start_iter = 25;
lratefact = 0.5;

maxdec = 3;
numdec = 0;
maxdec2 = 20;
numdec2 = 0;

[nChs,nFrames] = size(x);

% Plotting vars
% if nargin >= 10
%     plothist = 1;
%     nbins = 50;
% end
% if M > 1
%     dispinterval = 10;
% else
%     dispinterval = 1;
% end
% if nargin >= 10
%     plotfig = 1; % we are given the solution bases and centers
% else
%     plotfig = 0;  % can also set this to 1 to plot anyway (without the solution)
% end
% Mx = max(max(abs(x)));
% if isempty(o.cs)
%     cs = zeros(n,M);
% else
%     cs = o.cs;
% end

%% Initialize AMICA
tic;

% Initialize parameters
A = zeros(nChs,nChs,M);
c = nan(nChs,M);
for h = 1:M
    A(:,:,h) = eye(nChs) + 0.1*randn(nChs,nChs);
    for ch = 1:nChs
        A(:,ch,h) = A(:,ch,h) / norm(A(:,ch,h));
    end
    c(:,h) = zeros(nChs,1);
end
gm = (1/M) * ones(M,1);
alpha = (1/m) * ones(m,nChs,M);
if m > 1
    mu = 0.1 * randn(m,nChs,M);
else
    mu = zeros(m,nChs,M);
end
beta = ones(m,nChs,M) + 0.1 * randn(m,nChs,M);
rho = rho0 * ones(m,nChs,M);
%rho(1,:,:) = rho0_sub * ones(1,n,M);
%rho(2:m,:,:) = rho0_sup * ones(m-1,n,M);
%rho = 2*rand(size(mu)) + 1;

% Intialize variables
b = zeros(nChs,nFrames,M);
B = zeros(nChs,nFrames);

y = zeros(nChs,nFrames,m,M);
%fp = zeros(m,nFrames);
%zfp = zeros(m,nFrames);
Q = zeros(m,nFrames);

Lt = zeros(M,nFrames);
v = ones(M,nFrames);
vsum = zeros(M,1);
z = ones(nChs,nFrames,m,M)/nFrames;

ldet = zeros(M,1);
LL = zeros(o.maxiter);
dLL = zeros(o.maxiter);

% g = zeros(n,N);
% r = zeros(n,N,m,M);
% lambda = zeros(n,1);
% kappa = zeros(n,1);
% sigma2 = zeros(n,1);

%% Demean
mn = zeros(nChs,1);
if o.remove_mean
    for ch = 1:nChs
        mn(ch,1) = mean(x(ch,:));
        x(ch,:) = x(ch,:) - mn(ch,1);
    end
end
disp("Demeaned"); toc;
% if max(size(cs)) > 1
%     for h = 1:M
%         cs(:,h) = cs(:,h) - mn;
%     end
% end

%% Iteratively optimize parameters using EM
for ii = 1:o.maxiter
    % get y, Q, Lt, u (u is named z since z overwrites it later)
    for h = 1:M
        A_h = A(:,:,h);
        c_h = c(:,h);
        ldet(h) = -log(abs(det(A_h)));
        Lt_h = log(gm(h)) + ldet(h); %Lt(h,:) = log(gm(h)) + ldet(h);

        if M == 1
            b = pinv(A) * x;
        end
        b_h = b(:,:,h);
        for ch = 1:nChs
            if M > 1
                Wh = pinv(A_h);
                b_ch = Wh(ch,:) * x - Wh(ch,:)*c_h; %b(ch,:,h) = Wh(ch,:) * x - Wh(ch,:)*c_h;
            else
                b_ch = b_h(ch,:);
            end

            parfor j = 1:m
                y(ch,:,j,h) = sqrt(beta(j,ch,h)) * (b_ch - mu(j,ch,h) );
                Q(j,:) = log(alpha(j,ch,h)) + 0.5*log(beta(j,ch,h)) + logpfun(y(ch,:,j,h),rho(j,ch,h));
            end
            if m > 1
                Qmax = ones(m,1)*max(Q,[],1);
                Lt_h = Lt_h + Qmax(1,:) + log(sum(exp(Q - Qmax),1));
                for j = 1:m
                    Qj = ones(m,1)*Q(j,:);
                    z(ch,:,j,h) = 1 ./ sum(exp(Q-Qj),1);   % this is really u, but we use z to save space
                end
            else
                Lt_h = Lt_h + Q(1,:);
            end
            b_h(ch,:) = b_ch;
        end
        Lt(h,:) = Lt_h;
        A(:,:,h) = A_h;
        c(:,h) = c_h;
        b(:,:,h) = b_h;
    end
    disp("got y, Q, Lt, u: "+ii+" "+toc);
    if M > 1
        Ltmax = ones(M,1) * max(Lt,[],1);
        P = sum(exp(Lt-Ltmax),1);
        LL(ii) = sum(Ltmax(1,:) + log(P)) / (nChs*nFrames);
    else
        LL(ii) = sum(Lt) / (nChs*nFrames);
    end

    if ii > 1
        dLL(ii) = LL(ii) - LL(ii-1);
    end

    if o.showLL
        disp("iter="+ii+"  lrate="+lrate+" LL="+LL(ii)+" "+toc);
    end

    if ii > o.iterwin + 1
        sdll = sum(dLL(ii-o.iterwin:ii))/o.iterwin;
        if (sdll > 0) && (sdll < o.mindll)
            break;
        end
        if sdll < 0
            lrate = lrate * lratefact;
            numdec = numdec + 1;
            if numdec > maxdec
                disp("Likelihood decreasing! Reducing lrate="+lrate+" "+toc);
                lratemax = lratemax * lratefact;
                lnatratemax = lnatratemax * lratefact;
                rholrate = rholrate * lratefact;
                numdec2 = numdec2 + 1;
                if numdec2 > maxdec2
                    break;
                end
                numdec = 0;
            else
                disp("Likelihood decreasing! Same lrate="+lrate+" "+toc);
            end
        else
            if ii > newt_start_iter && o.do_newton
                lrate = min(lratemax,lrate + min(0.1,lrate));
            else
                lrate = min(lnatratemax,lrate + min(0.1,lrate));
            end
            disp("Likelihood NOT decreasing! lrate="+lrate+" "+toc);
        end
    end

    % get v, z, gm, and alpha
    for h = 1:M
        if M > 1
            Lh = ones(M,1)*Lt(h,:);
            v(h,:) = 1 ./ sum(exp(Lt-Lh),1);
            vsum(h) = sum(v(h,:));
            gm(h) = vsum(h) / nFrames;

            if gm(h) == 0
                continue;
            end
        end
        g = zeros(nChs,nFrames);
        kappa = zeros(nChs,1);
        lambda = zeros(nChs,1);
        %eta = zeros(n,1);
        %sigma2 = zeros(n,1);

        parfor ch = 1:nChs
            z_ch = z(ch,:,:,:);
            for j = 1:m
                if M > 1
                    if m > 1
                        z_ch(1,:,j,h) = v(h,:) .* z_ch(1,:,j,h); %#ok<PFBNS>
                        sumz = sum(z_ch(1,:,j,h));
                        alpha(j,ch,h) = sumz / vsum(h); %#ok<PFBNS>
                    else
                        z_ch(1,:,j,h) = v(h,:);
                        sumz = sum(z_ch(1,:,j,h));
                    end
                else
                    if m > 1
                        sumz = sum(z_ch(1,:,j,h));
                        alpha(j,ch,h) = sumz / nFrames;
                    else
                        sumz = nFrames;
                    end
                end

                if sumz > 0
                    if M > 1 || m > 1
                        z_ch(1,:,j,h) = z_ch(1,:,j,h) / sumz;
                    end
                else
                    continue;
                end
                fp_j = ffun(y(ch,:,j,h),rho(j,ch,h));
                zfp_j = z_ch(1,:,j,h) .* fp_j;

                g(ch,:) = g(ch,:) + alpha(j,ch,h) * sqrt(beta(j,ch,h)) * zfp_j;

                kp = beta(j,ch,h) * sum(zfp_j.*fp_j);
                kappa(ch) = kappa(ch) + alpha(j,ch,h) * kp;

                lambda(ch) = lambda(ch) + alpha(j,ch,h) * (sum(z_ch(1,:,j,h).*(fp_j.*y(ch,:,j,h)-1).^2) + mu(j,ch,h)^2 * kp);

                if rho(j,ch,h) <= 2
                    if m > 1 || M > 1
                        dm = sum(zfp_j./y(ch,:,j,h));
                        if dm > 0
                            mu(j,ch,h) = mu(j,ch,h) + (1/sqrt(beta(j,ch,h))) * sum(zfp_j) / dm;
                        end
                    end
                    db = sum(zfp_j.*y(ch,:,j,h));
                    if db > 0
                        beta(j,ch,h) = beta(j,ch,h) / db;
                    end
                else
                    if m > 1 || M > 1
                        if kp > 0
                            mu(j,ch,h) = mu(j,ch,h) + sqrt(beta(j,ch,h)) * sum(zfp_j) / kp;
                        end
                    end
                    db = ( rho(j,ch,h) * sum(z_ch(1,:,j,h).*abs(y(ch,:,j,h)).^rho(j,ch,h)) )^(-2 / rho(j,ch,h));
                    beta(j,ch,h) = beta(j,ch,h) * db;
                end

                if update_rho
                    ytmp = abs(y(ch,:,j,h)).^rho(j,ch,h);
                    dr = sum(z_ch(1,:,j,h).*log(ytmp).*ytmp);
                    if rho(j,ch,h) > 2
                        dr2 = psi(1+1/rho(j,ch,h)) / rho(j,ch,h) - dr;
                        if ~isnan(dr2)
                            rho(j,ch,h) = rho(j,ch,h) + 0.5 * dr2;
                        end
                    else
                        dr2 = 1 - rho(j,ch,h) * dr / psi(1+1/rho(j,ch,h));
                        if ~isnan(dr2)
                            rho(j,ch,h) = rho(j,ch,h) + rholrate * dr2;
                        end
                    end
                    rho(j,ch,h) = min(rhomax,rho(j,ch,h));
                    rho(j,ch,h) = max(rhomin,rho(j,ch,h));
                end
            end
            z(ch,:,:,:) = z_ch;
        end

        if M > 1
            sigma2 = b(:,:,h).^2 * v(h,:)'/vsum(h);
        else
            sigma2 = sum(b.^2,2) / nFrames;
        end

        dA = eye(nChs) - g * b(:,:,h)';

        bflag = zeros(nChs,1);
        parfor ch = 1:nChs
            B_ch = B(ch,:);
            for k = 1:nChs
                if ch == k
                    B_ch(1,ch) = dA(ch,ch) / (-0*dA(ch,ch) + lambda(ch));
                else
                    denom = kappa(ch)*kappa(k)*sigma2(ch)*sigma2(k) - 1;
                    if denom > 0
                        B_ch(1,k) = (-kappa(k) * sigma2(ch) * dA(ch,k) + dA(k,ch)) / denom;
                    else
                        bflag(ch) = 1;
                    end
                end
            end
            B(ch,:) = B_ch;
        end
        if all(~bflag) && o.do_newton && ii > newt_start_iter
            A(:,:,h) = A(:,:,h) + lrate * A(:,:,h) * B;
        else
            A(:,:,h) = A(:,:,h) - lnatrate * A(:,:,h) * dA;
        end
    end
    disp("got v, z, gm, alpha: "+ii); toc;

    % reparameterize
    for h = 1:M
        if gm(h) == 0
            continue
        end
        A_h = A(:,:,h);
        c_h = c(:,h);
        parfor ch = 1:nChs
            tau = norm(A_h(:,ch));
            A_h(:,ch) = A_h(:,ch) / tau;
            mu(:,ch,h) = mu(:,ch,h) * tau;
            beta(:,ch,h) = beta(:,ch,h) / tau^2;
        end

        if M > 1
            % make posterior mean zero
            cnew = x * v(h,:)'/(sum(v(h,:)));
            parfor ch = 1:nChs
                Wh = pinv(A_h);
                mu(:,ch,h) = mu(:,ch,h) - Wh(ch,:)*(cnew-c_h);
            end
            c_h = cnew;
        end
        A(:,:,h) = A_h;
        c(:,h) = c_h;
    end
    disp("reparametrized: "+ii); toc;
end

for h = 1:M
    if M > 1
        c(:,h) = c(:,h) + mn;  % add mean back to model centers
    end
end
disp('Done!');


function f = logpfun(x,rho)
f = -abs(x).^rho - log(2) - gammaln(1+1/rho);

function f = ffun(x,rho)
f = rho * sign(x).*abs(x).^(rho-1);

%% Depreciated
% function f = pfun(x,rho) %#ok<DEFNU>
% f = (1 / (2*GAMMA(1+1/rho))) * exp( - abs(x).^rho );
%
%
%     if plotfig && mod(ii,dispinterval) == 0
%         if M < 2
%             figure(1), clf;
%             subplot(2,2,1); set(gca,'fontsize',14); hold on; axis(Mx*[-1 1 -1 1]);
%             xlabel('\itx_{\rm1}'); ylabel('\itx_{\rm2}');
%             plot(x(1,:),x(2,:),'g.');
%
%             for h = 1:M
%                 for i = 1:n
%                     if nargin >= 10
%                         plot([cs(1,h) cs(1,h)+As(1,i,h)],[cs(2,h) cs(2,h)+As(2,i,h)],'r','LineWidth',2);
%                     end
%                     %cc(1) = c(1,h) + A(1,i,h)*sum(alpha(:,1,h).*mu(:,1,h));
%                     %cc(2) = c(2,h) + A(2,i,h)*sum(alpha(:,2,h).*mu(:,2,h));
%                     %plot([cc(1) cc(1)+A(1,i,h)],[cc(2) cc(2)+A(2,i,h)],'b','LineWidth',2);
%                     plot([c(1,h) c(1,h)+A(1,i,h)],[c(2,h) c(2,h)+A(2,i,h)],'b','LineWidth',2);
%                 end
%             end
%             %pause(0.5);
%
%             [mval,mind] = max(Lt,[],1); %#ok<ASGLU>
%             for h = 1:1
%                 inds = mind == h;
%
%                 for i = 1:2
%                     [hst,bn] = hist(b(i,inds,h),nbins); %#ok<HIST>
%
%                     dbn = abs(bn(2)-bn(1));
%                     hst = hst / (sum(hst)*dbn);
%
%                     ph = zeros(1,length(bn));
%
%                     subplot(2,2,1+i); set(gca,'fontsize',14); hold on;
%                     xlabel(['\its_{\rm' int2str(i) '}']); ylabel('norm. histogram');
%
%                     bmax = max(abs(bn(1)),abs(bn(end)));
%                     axis([-bmax-2*dbn bmax+2*dbn 0 max(hst)+0.1]); hold on;
%                     for j = 1:m
%                         dh = alpha(j,i,h) * sqrt(beta(j,i,h)) * exp(-abs(sqrt(beta(j,i,h))*(bn-mu(j,i,h))).^rho(j,i,h)) / (2*gamma(1+1/rho(j,i,h)));
%                         plot(bn,dh,'g');
%                         ph = ph + dh;
%                     end
%                     plot(bn,hst,'r');
%                     plot(bn,ph);
%                     axis([-Mx Mx 0 max(max(ph,1))])
%                 end
%             end
%             subplot(2,2,4); set(gca,'fontsize',14); plot(LL); xlim([1 o.maxiter]);
%             xlabel('iteration'); ylabel('Log Likelihood');
%         else
%             figure(1), clf;
%             subplot(1,2,1); set(gca,'fontsize',14); hold on; axis(Mx*[-1 1 -1 1]);
%             xlabel('\itx_{\rm1}'); ylabel('\itx_{\rm2}');
%             plot(x(1,:),x(2,:),'g.');
%
%             for h = 1:M
%                 for i = 1:n
%                     if nargin >= 10
%                         plot([cs(1,h) cs(1,h)+As(1,i,h)],[cs(2,h) cs(2,h)+As(2,i,h)],'r','LineWidth',2);
%                     end
%                     %cc(1) = c(1,h) + A(1,i,h)*sum(alpha(:,1,h).*mu(:,1,h));
%                     %cc(2) = c(2,h) + A(2,i,h)*sum(alpha(:,2,h).*mu(:,2,h));
%                     %plot([cc(1) cc(1)+A(1,i,h)],[cc(2) cc(2)+A(2,i,h)],'b','LineWidth',2);
%                     plot([c(1,h) c(1,h)+A(1,i,h)],[c(2,h) c(2,h)+A(2,i,h)],'b','LineWidth',2);
%                 end
%             end
%             subplot(1,2,2); set(gca,'fontsize',14); plot(LL); xlim([1 o.maxiter]);
%             xlabel('iteration'); ylabel('Log Likelihood');
%
%         end
%     end
% end