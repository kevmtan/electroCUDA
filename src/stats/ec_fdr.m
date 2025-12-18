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
n = numel(p); % number of tests

% Reshape to vector
p = reshape(p,n,1);

% Parameters
switch dep
    case "indep";   c = 1;
    case "corr+";   c = 1;
    case "corr-";   c = log(n)+1/(2*n)+eulergamma;
    case "unknown"; c = sum(1./(1:n));
end

% Compute the adjusted p-values
k = (1:1:n)';
[pSort, idx] = sort(p,'ascend');
pAdj(idx,1) = cummin(pSort.*(c.*n./k), 'reverse');
pAdj = reshape(pAdj,sz); % reshape to original shape

% Compute the corrected significance levels
aAdj(idx,1) = a.*k./(n.*c);

% Rejected H0
h = p < aAdj;

% Reshape to original shape
aAdj = reshape(aAdj,sz);
h = reshape(h,sz);