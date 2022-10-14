function [chCov,outliers,chOrder,chCovNfo] = ec_cov(x,chBad,varargin)
% Get robust covariance of a multichannel timeseries  (wrapper for 'robustcov')
%
% 	Required inputs:
%		x(frames,chans) = data matrix {double|single}
%
%	Optional inputs:
%		chBad(chans) = bad channels to exclude {numeric vector|logical vector}
%		Name-value arguments for robustcov: robust_chCov(x,chBad,'Method','olivehawkins','OutlierFraction',0.25,...)
%			See name-value arguments: mathworks.com/help/stats/robustcov.html?s_tid=doc_ta#namevaluepairs
%
%	Outputs:
%		chCov(chans,chans) = robust covariance across channels (NaNs for bad chans) {double|single}
%		outliers(frames) = outlier frames relative to robust covariance estimate {logical vector}
%		chOrder(channels,channels-1) = channel indices sorted by covariance with each channel {numeric matrix}
%		chCovNfo = additional info about covariance estimate
%
%	Kevin Tan, 2022 (kevmtan.github.io)

% Input validation & prellocation
if nargin<2; chBad=[]; elseif islogical(chBad); chBad=find(chBad); end
if nargin<3; varargin = {'Method','fmcd'}; end
nChs = size(x,2);
chGood = ~ismember(1:nChs,chBad);
chCov = nan(nChs);

% Estimate robust covariance
[chCov(chGood,chGood),mu,mah,outlierFrames,chCovNfo] = robustcov(x(:,chGood),varargin);
if nargout<3; return; end

% Order channels by covariance with each channel
chOrder = nan(nChs,nChs-1);
for ch = 1:nChs
    [~,idx] = sort(chCov(ch,:),'descend');
    idx = idx(~ismember(idx,[ch chBad]));
    chOrder(ch,1:numel(idx))) = idx;
end

% Organize estimate information
chCovNfo.mean = mu; % Robust means across chans
chCovNfo.mah = mah; % Robust mahalanobis distances across frames
