function [y,w] = ec_sensorNoise(x,w,nNeighbors,skip,tooBig)
% y=nt_sns(x,nneigbors,skip,w) - sensor noise suppression
%
%   y: denoised matrix
%
%   x: matrix  to denoise
%   nneighbors: number of channels to use in projection
%   skip: number of closest neighbors to skip (default: 0)
%   w : weights (default: all ones)
%
% If w=='auto', the weights are calculated automatically.
%
%  Mean of data is NOT removed.
%
% Cite: 
% de Cheveign\'e, A. and Simon, J. Z. (2007). "Sensor Noise Suppression." 
% Journal of Neuroscience Methods, 168: 195-202.
%
% NoiseTools
% Copyright 2007, 2008 Alain de Cheveigne

% The basic idea is to project each channel of X on a basis formed by the
% orthogonalized set of other channels. Supposing (a) that sensor noise is
% uncorrelated across sensors, and (b) genuine signal is correlated, sensor
% noise is removed and genuine signal preserved. 
% 
% Implementation issues:
% - Data are often available as an array of epochs. This implementation
% caters for 3D data (time * channnels * trials);
% - It is important to deemphasize high amplitude artifacts and glitches
% so that they do not dominate the solution.  This implementation uses
% weighted covariance and means.
% - Processing assumes zero-means data. Means are calculated with weights.
% - The implementation tries to be efficent and minimize memory requirements
% so as to handle large data sets.
%
% Larger data sets (disk based) could be handled by performing mean and
% covariance calculations block-by-block, in several passes.
arguments
    x (:,:){isfloat}
    w {istext,isnumeric} = []
    nNeighbors (1,1){isnumeric} = round(width(x)*.5)
    skip (1,1){isnumeric} = 0
    tooBig (1,1){isnumeric} = 10
end
if ~isempty(w) && ~isany(w); w=ones(size(x)); warning("ec_sensorNoise: w all outliers, resetting...");  end
if any(isnan(x),"all"); warning("ec_sensorNoise: x contains NANs"); end
if numel(nNeighbors)>1 || numel(skip)>1; error('nneighbors & skip should be scalars');  end
if nNeighbors>0 && nNeighbors<=1; nNeighbors=round(width(x)*nNeighbors); end
if nNeighbors>1; nNeighbors=round(nNeighbors); end

%%
[m,~,~] = size(x);
x = ec_unfold(x);

%[x,mn0]=demean(x);  % remove mean
[c,~]=ec_weightedCov(x);    % raw covariance

if istext(w) && w=="auto"
    y = ec_sensorNoise(ec_demean(x),nNeighbors,skip);
    d = (y-x).^2;
    d = nt_vecmult(ec_unfold(d), 1./mean( [mean(ec_unfold(x.^2)); mean(ec_unfold(y.^2))] ));
    w = d<tooBig;
    w = min(w,[],2);
    w(isnan(w))=0;
end

% sns matrix
if ~isempty(w)
    w = ec_unfold(w);
    [wc,~] = ec_weightedCov(ec_demean(x,w),[],w); % weighted covariance
    r = sns_lfn(c,nNeighbors,skip,wc);
else
    r = sns_lfn(c,nNeighbors,skip,c);
    if nargout>1; w=true(size(x)); end
end

% apply to data
y = x*r;
y = nt_fold(y,m);
if nargout>1; w = ~w; end


%mn=mn0;%+mn1;


%%
function r = sns_lfn(c,nNeighbors,skip,wc)
% r=nt_sns0(c,nneigbors,skip,wc) - sensor noise suppression
%
%   r: denoising matrix
%
%   c: full covariance of data to denoise
%   nneighbors: number of channels to use in projection 
%   skip: number of neighbors to skip [default: 0]
%   wc: weighted covariance
%
% 


n=size(c,1);

if nargin<2 || isempty(nNeighbors); error('need to specify nneighbors'); end
if nargin<3 || isempty(skip); skip=0; end
if nargin<4 || isempty(wc); wc=c; end

nNeighbors=min(nNeighbors,n-skip-1);

r=zeros(size(c));

% normalize
d=sqrt(1./(diag(c)+eps));
c=nt_vecmult(nt_vecmult(c,d),d');

for iChan=1:n
 
    c1=c(:,iChan);                      % correlation of channel with all other channels
    [~,idx]=sort(c1.^2,1,'descend');   % sort by correlation
    idx=idx(skip+2:skip+1+nNeighbors);  % keep best

    % pca neighbors to orthogonalize them
    c2=wc(idx,idx);
    [topcs,eigenvalues]=nt_pcarot(c2);
    topcs=topcs*diag(1./sqrt(eigenvalues));
    topcs(isinf(topcs)|isnan(topcs))=0;
    
    % augment rotation matrix to include this channel
    topcs = [1,zeros(1,nNeighbors);zeros(nNeighbors,1),topcs];
    
    % correlation matrix for rotated data
    c3=topcs'*wc([iChan;idx],[iChan;idx])*topcs;
    
    % first row defines projection to clean component iChan
    c4=c3(1,2:end)*topcs(2:end,2:end)';

    % insert new column into denoising matrix
    r(idx,iChan)=c4;

end
