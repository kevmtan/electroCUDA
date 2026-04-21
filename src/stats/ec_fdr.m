% ----------------------------------------------------------------------- %
%                     M U L T I P L E    T E S T I N G                    %
% ----------------------------------------------------------------------- %
% Function 'fdr_BY' computes the Benjamini-Yekutieli correction of the    %
% False Discovery Rate for multiple comparisons. The adjusted p-values of %
% Gordon Smyth are also provided.                                         %
%                                                                         %
%   Input parameters:                                                     %
%       - pvalues:      List of p-values to correct.                      %
%       - alpha:        Significance level (commonly, alpha=0.05).        %
%       - correction:   (Optional) Correction for data dependence:        %
%           * 'ind':    For independent tests (c=1)                       %
%           * 'corr+':  For positive correlated tests (c=1)               %
%           * 'corr-':  For negative correlated tests (c = ln(m)+gamma    %
%                       +1/(2m), where gamma is the Euler-Mascheroni cnst)%
%           * 'unknown':(Default) For arbitrary dependence (c = harm(m),  %
%                       where harm() is the harmonic sum).                %
%       - plotting:     (Optional, default=false) Plotting boolean.       %
%                                                                         %
%   Output variables:                                                     %
%       - c_pvalues:    Corrected p-values (that should be compared with  %
%                       the given alpha value to test the hypotheses).    %
%       - c_alpha:      Corrected significance levels (that should be     %
%                       compared with the given pvalues to test the       %
%                       hypotheses).                                      %
%       - h:            Hypothesis rejection. If h=1, H0 is rejected; if  %
%                       h=0, H0 is accepted.                              %
%       - extra:        Struct that contains additional information.      %
% ----------------------------------------------------------------------- %
%   Example of use:                                                       %
%       [c_pvalues, c_alpha, h] = fdr_BY(rand(5,1), 0.05, 'unknown',true);%
% ----------------------------------------------------------------------- %
%   Script information:                                                   %
%       - Version:      1.0.                                              %
%       - Author:       V. Martínez-Cagigal                               %
%       - Date:         13/03/2019                                        %
% ----------------------------------------------------------------------- %
%   References:                                                           %
%       [1] Benjamini, Y., & Yekutieli, D. (2001). The control of the false
%           discovery rate in multiple testing under dependency. The annals
%           of statistics, 29(4), 1165-1188.                              %
% ----------------------------------------------------------------------- %
%
%
% Modified by Kevin Tan:
%   - reshape for multidimensional pvalues (FDR on all pvalues concurrently)
%   - arguments validation
%   - performance & readability
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025 

function [pAdj,aAdj,h] = ec_fdr(p,a,dep)
arguments
    p {mustBeFloat} % p-value array
    a (1,1){mustBeFloat} = 0.05 % significance threshold (alpha)
    dep (1,1) string {mustBeMember(dep,["indep" "corr+" "corr-" "unknown"])}...
        = "unknown" % Data dependence structure, determines correction factor,
                    % "indep" & "corr+" perform standard FDR (Benjamini-Hochberg)
end

% P-value info
sz = size(p);
nAll = numel(p); % total number of entries

% Reshape to column vector
p = reshape(p,nAll,1);

% Preallocate outputs (NaN for missing/uncorrectable entries)
pAdj = nan(nAll,1,"like",p);
aAdj = nan(nAll,1,"like",p);

% Trivial case: single test, no correction needed
if nAll==1
    pAdj(:) = p;
    aAdj(:) = a;
    pAdj = reshape(pAdj,sz);
    aAdj = reshape(aAdj,sz);
    h = reshape(p < aAdj, sz);
    return;
end

% Filter NaN p-values: FDR runs only on finite entries, NaN stays NaN
idGood = ~isnan(p);
nGood = nnz(idGood);

% If 0 or 1 good p-values, identity correction (no multiple comparisons)
if nGood<=1
    pAdj(idGood) = p(idGood);
    aAdj(idGood) = a;
    pAdj = reshape(pAdj,sz);
    aAdj = reshape(aAdj,sz);
    h = reshape(p < aAdj, sz); % NaN<x -> false, so h=false for NaN entries
    return;
end

% FDR on non-NaN p-values only
pGood = p(idGood);

% Correction factor for dependence structure
switch dep
    case "indep";   c = 1;
    case "corr+";   c = 1;
    case "corr-";   c = log(nGood)+1/(2*nGood)+eulergamma;
    case "unknown"; c = sum(1./(1:nGood));
end

% Compute the adjusted p-values (over good entries)
k = (1:nGood)';
[pSort, idx] = sort(pGood,'ascend');
pAdjGood = nan(nGood,1,"like",p);
aAdjGood = nan(nGood,1,"like",p);
pAdjGood(idx,1) = cummin(pSort.*(c.*nGood./k), 'reverse');
aAdjGood(idx,1) = a.*k./(nGood.*c);

% Scatter back into full-size vectors (NaN entries remain NaN)
pAdj(idGood) = pAdjGood;
aAdj(idGood) = aAdjGood;

% Reshape to original shape
pAdj = reshape(pAdj,sz);
aAdj = reshape(aAdj,sz);

% Rejected H0 (NaN<x is false, so NaN entries are not rejected)
h = reshape(p < aAdj, sz);