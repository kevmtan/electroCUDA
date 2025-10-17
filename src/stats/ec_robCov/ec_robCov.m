function [Q,outliers,pct] = ec_robCov(w,nIter,minPct,pct)
% robCov is a robust covariance matrix estimation of data. Useful if data may contain outliers.
% It uses only an 'inner' percentage of the data (i.e. data lying inside a certain
% ellipsoid) to estimate the covariance matrix. If data comes from a
% multinormal distribution, this estimation is unbiased. There is no
% guarantee for data coming from other distributions (e.g. heavier tailed ones).
% Data is assumed to be 0-mean.
% The procedure is as follows:
% 1) Estimate the covariances with the classical MLE estimator.
% 2) Use the classical estimator to find the X% of inner-most samples (i.e.
% samples within the 90-th percentile ellipsoid). The other (100-X)% is
% presumed to contain all the outliers.
% 3) Estimate the covariance of the reduced samples.
% 4) Expand estimate to account for the fact that only the samples closes to
% the origin where used, under the assumption of multivariate normal data.
% INPUT:
% w: MxN matrix, consisting of N-samples of M-dimensional data.
% prc: (optional, default =90%) Percentage of data used for estimation.
% OUTPUT:
% Q: MxM covariance estimate
% See also: robustCov, estimateParams
%
% To do:
% 1) is it worth it to iterate the procedure to converge on the outlier samples?
% 2) Instead of hard-coding the % of samples to discard, do auto-setting:
% compute the z^2 scores percentiles, and set the cut-off whenever the
% empirical percentiles are outside some window of the expected percentiles
% (e.g. if the sample datapoint at the 95% percentile is given a percentile score of more than 96% or less than 94%, cut off there)
arguments
    w (:,:){mustBeFloat}
    nIter (1,1){isnumeric} = 10 % Num iterations
    minPct (1,1){isnumeric} = 90 % Minimum non-outlier percentage
    pct {isnumeric} = [] % Predefined outlier percentage (0=auto)
end
if height(w)>width(w); w=w'; end
w = normalize(w,2,"center","mean");

[nD,M]=size(w);
if pct
    if pct<1 %Assuming percentile was given in [0,1] range
        pct=round(100*pct);
    end
    M2=round(M*pct/100);
    k=getScale(pct,nD,M2);
end

%%
% Init:
Q=norm(w,'fro').^2/(M*nD)*eye(nD); %MLE spherical estimate
%Q=(w*w')/M; %Standard estimate, to init
m=[]; %Presuming zero-mean data.


for ii=1:nIter
    %Q
    if ~isempty(pct) %prc level is given
        y=z2score(w,Q,m); %if w~N(m,Q) this is distributed as t^2 ~ Hotelling's T^2 = nD*(M-1)/(M-nD) F_{nD,M-nD}, see https://en.wikipedia.org/wiki/Hotelling%27s_T-squared_distribution
        yPRC=prctile(y,pct);
    else %Auto-choose prc:
        [p,y]=z2prctile(w,Q,m,[],M); %Computing z-scores and associated percentiles given the underlying distribution, should be done with M2 if those are the samples used for estimating Q
        pEmp=(1:length(p))/length(p);
        aux=(sort(p)-pEmp); %Divergence between empirical (ranking) percentiles, and expected percentiles given the latest covariance estimate
        prcOut1=max(aux); %Peak
        prcOut2=1-find(aux==prcOut1,1,'last')/M; %Where the peak ocurrs
        prcOut=min(prcOut1,prcOut2)*.25; %Taking minimum estimate, and adding safety margin
        if isempty(prcOut) || prcOut<0 
            prcOut=.001; %Defaults to .1% outliers if nothing was found
        end
        prcAuto=max(100*(1-prcOut),minPct); % No more than 100-minPct outliers
        %plot([1:M]/M,aux); plot(1-prcOut1,0,'kx'); plot(1-prcOut2,0,'ko'); plot(prcAuto/100,0,'rd'); drawnow;
        yPRC=prctile(y,prcAuto);
        M2=round(M*prcAuto/100);
        k=getScale(prcAuto,nD,M2);
    end
    idx=y<yPRC; %Non-rejection criteria
    wRob=w(:,idx);
    Q=(wRob*wRob')/(k*M); %Should I use ACTUAL DoF instead of expected DoF?
    %if prcAuto>=minPct; break; end
end

outliers = ~idx;
if isempty(pct)
    pct=prcAuto;
end
end



function k=getScale(prc,nD,M,fc)
%First moment of F_{nD,M-nD} = (M-nD)/(M-nD-2)  (~1 if M-nD>>2)
%(approx) Partial first moment to th prcth-percentile:
if prc>99.9 %prc is essentially 100%
    k=fstat(nD,M-nD); %This needs hardcoding to avoid sampling fpdf in too many points
else
    if nargin<4 %Compute everything
        X1=finv(prc/100,nD,M-nD);
        dx=1e-3;
        x=((dx/2):dx:X1);
        fp=fpdf(x,nD,M-nD);
        k=dx*sum(x.*fp);
    else %fc was precomputed
        X1=finv(prc/100,nD,M-nD);
        Xidx=round(1e3*X1); %Round to 1e-3
        k=fc(Xidx);
    end
end
end