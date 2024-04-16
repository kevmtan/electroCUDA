function [x,mask] = ec_rereference(x,mask,refChs,a)
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
    x (:,:){mustBeFloat}
    mask (1,:) logical = true(1,size(x,2))
    refChs {isnumeric,islogical} = 0
    a.thresh (1,1) double = 3
    a.iters (1,1) double = 1
    %o.forceRankCorrect logical = false
end
if numel(mask)~=width(x); error("Mask length must equal number of channels (width of x)"); end
if islogical(refChs) && numel(refChs)~=width(x); error("refChs (logical) length must equal number of channels (width of x)"); end
%if o.forceRankCorrect || any(refChs); rankCorrect=true; else; rankCorrect=false; end

%% Robust reference
rnk = ec_rank(x,exact=true); % get initial data rank
if any(refChs); mask(refChs)=true; end % exclude reference chans
disp("[ec_rereference] iter=0 | chs="+width(x)+" | refChs="+nnz(mask)+" | rank="+rnk); 

% Iteration loop
for t = 1:a.iters
    % Robust reference w/ rank correction
    x1 = x - (sum(x(:,mask),2,"omitnan")/(nnz(mask)+eps(0)+1)); % add 1 to denominator
    [rnk1,tol,eig1] = ec_rank(x,exact=true);
    eig1 = min(eig1) - tol;

    % Robust reference standard method
    x = x - (sum(x(:,mask),2,"omitnan")/(nnz(mask)+eps(0)));
    [rnk,tol,eig] = ec_rank(x,exact=true);
    eig = min(eig) - tol;

    % Display
    disp("[ec_rereference] iter="+t+" | chs="+width(x)+" | refChs="+nnz(mask));
    disp("[ec_rereference] iter="+t+" | rank="+rnk+" | minEig="+eig+" (standard)");
    disp("[ec_rereference] iter="+t+" | rank="+rnk1+" | minEig="+eig1+" (rank-corrected)");

    % Keep output with largest rank
    if rnk1>rnk || (rnk1==rnk && eig1>eig)
        x = x1;
        disp("[ec_rereference] iter="+t+" | used rank-corrected referencing");
    else
        disp("[ec_rereference] iter="+t+" | used standard referencing");
    end

    % Remove outlier chans from good chans
    if a.thresh > 0
        x_mad = mad(x,1) ./ mad(x(:,mask),1);
        mask(x_mad > a.thresh) = false; % remove outlier chans from good chans
    end

    
end



