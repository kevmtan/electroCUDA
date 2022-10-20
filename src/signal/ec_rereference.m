function [x,mask,mn] = ec_rereference(x,mask,thresh,nItr,~)
% Noisetools function modified by Kevin Tan (2022)
%      Modifications: compute efficiency & reduce rank reduction
%
% [y,mn]=nt_rereference2(x,mask,thresh,factor) 
%
%   y: rereferenced data
%   mn: subtracted reference
%   mask: channel mask
%
%   x: data to rereference (time X channels)
%   mask: channel mask
%   thresh: std threshold to discard channel [default: 3]
%   factor: apply to mean before subtracting [default: 1]
%   
% See also: nt_rereference, nt_detrend, nt_outliers

%% Input validation
if nargin<1; error('!'); end
if nargin<2||isempty(mask); mask=ones(1,size(x,2)); end
if nargin<3||isempty(thresh); thresh=3; end
if nargin<4||isempty(nItr); nItr=5; end
%if nargin<5||factor~=1; factor=1; end
if size(mask,1)~=1; error('!'); end
if size(mask,2) ~= size(x,2); error('!'); end

%% Robust reference
rnk = ec_rank(x); % get initial data rank

% Loop across iterations
for t = 1:nItr
    % Add 1 to denomenator of mean to avoid losing data rank
    if t==1 && floor(rnk)<nnz(mask); d=1; else; d=0; end
    %rnk = nnz(mask); % Compare num chans/rank with next iteration

    % Robust reference to good chans
    mn = sum(x(:,mask),2) / sum(mask)+d; % mean timecourse of good chans
    x = x-mn; % reference all chans to good chans
    xx = x(:,mask); % good chan timecourses
    mask(std(x,"omitnan")/std(xx(:),"omitnan") > thresh) = 0; % remove outlier chans from good chans
end
disp(['proportion channels used for mean: ', num2str(mean(mask))])



