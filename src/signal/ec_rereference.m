function [x,mask,mn] = ec_rereference(x,mask,thresh,nItr,refChs)
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
arguments
    x {mustBeFloat}
    mask (1,:) logical = true(1,size(x,2))
    thresh (1,1) {isnumeric} = 3
    nItr (1,1) {isnumeric} = 5
    refChs {isnumeric} = []
end
if size(mask,2) ~= size(x,2); error("Mask length must equal number of channels (width of x)"); end

%% Robust reference
rnk = ec_rank(x); % get initial data rank
if rnk==width(x) && ~isempty(refChs) && any(refChs)
    rnk = rnk-1;
end

% Loop across iterations
for t = 1:nItr
    % Add 1 to denomenator of mean to avoid losing data rank
    if floor(rnk)<nnz(mask); d=1; else; d=0; end
    rnk = nnz(mask); % Compare num chans/rank with next iteration

    % Robust reference to good chans
    mn = sum(x(:,mask),2,"omitnan") / sum(mask,"om")+d; % mean timecourse of good chans
    x = x-mn; % reference all chans to good chans
    xx = x(:,mask); % good chan timecourses
    mask(std(x,"omitnan")/std(xx(:),"omitnan") > thresh) = 0; % remove outlier chans from good chans
end
disp(['proportion channels used for mean: ', num2str(mean(mask))])



