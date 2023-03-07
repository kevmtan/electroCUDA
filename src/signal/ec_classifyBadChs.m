function [chF,chDist] = ec_classifyBadChs(x,pos,chNames,mdl,arg)
arguments
    x {mustBeFloat}
    pos {mustBeNumeric}
    chNames {isnumeric,isstring,ischar,iscellstr} = [];
    mdl struct = []
    arg.nn {isnumeric} = floor(width(x)*.25)
end
logScale = 1;

%% Prep
nChs = min(size(x));
nn = min(arg.nn,nChs);
pos(isnan(pos)) = 0;

if isempty(mdl)
    load('ec_trainedClassifier_ImaGIN.mat','mdl');
end

%% Classify bad channels
[chF,chDist] = computeFeatures_lfn(x,pos,nChs,nn,logScale); % compute features

% Classify features using pre-trained ImaGIN model
chPred = mdl.predictFcn(chF);
chF.bad = chPred=="Bad";

%% Finalize
chF.Properties.VariableNames = erase(chF.Properties.VariableNames,'ch_');
chF = movevars(chF,"bad","Before",1);

if ~isempty(chNames)
    chF.ch = chNames;
    chF = movevars(chF,"ch","Before",1);
    chDist.ch = chNames;
    chDist = movevars(chDist,"ch","Before",1);
end

end


%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%


%% Compute features
function [chF,chDist] = computeFeatures_lfn(x,pos,nChs,nn,logScale)

% Correlation of all chans
if size(x,2)>size(x,1); x = x'; end
x_corrs = corr(x,'rows','pairwise');
if size(x,1)>size(x,2); x = x'; end % ImaGIN/SPM wants channels in 1st dim

% Easy features
ch_mean = mean(x,2,"omitnan");
ch_dev  = ch_mean - mean(ch_mean,"omitnan"); % Deviation from mean
ch_var  = var(x,[],2,"omitnan"); % Raw data variance
ch_ampl = range(x,2);
ch_grad = mean(diff(x,1,2),2,"omitnan"); % channel median gradient
ch_kurt = kurtosis(x,1,2); % kurtosis

% Preallocate
chDist = struct;
ch_xcorr = zeros(nChs,1);
ch_hurs = zeros(nChs,1);
m_var  = zeros(nChs,1);

%% Computationally-intensive features
parfor ch = 1:nChs
    % Euclidean distance between channels
    d = eucDist_lfn(pos,pos(ch,:));
    [~,sortIdx] = sort(d,'ascend');
    idx = sortIdx(2:nn);

    % Correlation
    corrTmp = x_corrs(ch,:);
    ch_xcorr(ch) = sum(abs(corrTmp(idx)),"omitnan") / length(idx);

    % Median variance
    m_var(ch) = median(ch_var(sortIdx(1:nn))); %#ok<PFBNS> 

    % Computer hurst exponent of time series
    ch_hurs(ch) = ec_generalizedHurst(x(ch,:)); %hurst_lfn(x(ch,:)); %fastHurst(x(ch,:));

    % Copy
    chDist(ch).d=d'; chDist(ch).closest=sortIdx';
end
chDist = struct2table(chDist);

%% Finalize
m_var(m_var<1e-3) = median(m_var);

% Normalize based on local values
ch_var = ch_var./m_var;
if logScale
    ch_var = 10*log10(ch_var);
end

chF = table(ch_xcorr,ch_var,ch_dev,ch_ampl,ch_grad,ch_kurt,ch_hurs); % table of features
end



%% Filter %%
function x = filter_lfn(x) %#ok<DEFNU> 

if size(x,2)>size(x,1)
    x = x';
end

d1 = designfilt('lowpassiir','FilterOrder',4,'HalfPowerFrequency',0.05,'DesignMethod','butter');
x = filtfilt(d1,x);
end


%% Hurst exponent %%
function h = hurst_lfn(x) %#ok<DEFNU> 
%      Estimate Hurst exponent on a timeseries.
%
%      The estimation is based on the second order discrete derivative.
%
%      Parameters
%      ----------
%      x : 1D array
%          The timeseries to estimate the Hurst exponent for.
%
%      Returns
%      -------
%      h : float
%          The estimation of the Hurst exponent for the given timeseries.

y = cumsum(diff(x,1));

b1 = [1, -2, 1];
b2 = [1,  0, -2, 0, 1];

% Second order derivative
y1 = filter(b1, 1, y);
% First values contain filter artifacts
y1 = y1(length(b1)+1:end-1);
% Wider second order derivative
y2 = filter(b2, 1, y);
% First values contain filter artifacts
y2 = y2(length(b2)+1:end-1);
s1 = mean(y1 .^2);
s2 = mean(y2 .^2);

h = 0.5*log2(s2/s1); % Hurst exponent index
end


%% Euclidian distance %%
function y = eucDist_lfn(a,b)
% EUCLIDEAN_DIST - Euclidean distance between two points
%
%   EUCLIDEANDIST(A,B) where A and B give the three cartesian coordinates
%   of two points in the space returns the Euclidean distance between those
%   two points.
%
%   EUCLIDEANDIST(A,B) where A and B are two matrices of dimensions Kx3
%   returns a vector of dimensions Kx1 with the Euclidean distance between
%   the rows of A and the rows of B.
%
%   EUCLIDEANDIST(A,B) where A (or B) is a vector and the other input
%   is a Kx3 matrix returns the Euclidean distance between the single point
%   in the space given by A (or B) and the multiple points given by the
%   other input parameter.

if nargin < 2
    ME = MException('euclideanDistance:needMoreInputs','Some input parameters are missing');
    throw(ME);
end

if size(a,1) ~= size(b,1) && size(a,1)>1 && size(b,1) > 1
    ME = MException('euclideanDist:invalidDim','Invalid dimensions in input parameter.');
    throw(ME);
end

if size(a,1) > size(b,1)
    tmp = a;
    a = b;
    b = tmp;
    clear tmp;
elseif size(a,1)>1 && size(a,1) == size(b,1)
    y = nan(size(a,1),1);
    for i = 1:size(a,1)
        y(i) = eucDist_lfn(a(i,:), b(i,:));
    end
    return;
end

a = repmat(a,size(b,1),1);
y = sqrt(sum((a-b).^2,2));
end

