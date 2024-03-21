function [thetaM,R,sigma,CI,kappa]=ec_angleMean(theta,alpha)
%% Mean of angles
% Inputs:
%   see arguments below
% Outputs:
%   thetaM = mean of angles in radians
%   R = angle strength, much like inverse variance. [varies between 0 and one]
%   sigma: circular standard deviation
%   confangle: confidence of mean angle (alpha=confidence, default alpha=95%)
%   kappa: an estimate of kappa in the Von Mises distribution
%
% Aslak Grinsted 2002-2014, modified by Kevin Tan (2024)
%
% http://www.glaciology.net/wavelet-coherence
% Check: http://www.cosy.sbg.ac.at/~reini/huber_dutra_freitas_igarss_01.pdf

%% Input validation
arguments
    theta {mustBeFloat} %  Phase angle in radians
    alpha {mustBeFloat} = 0.95 % Confidence level
end

%% Algorithm
theta = mod(theta(:),2*pi);
S = sum(sin(theta));
C = sum(cos(theta));

% Mean
thetaM = atan2(S,C);
if nargout<2; return; end

% Angle strength
n = length(theta);
Rsum = sqrt(S^2+C^2);
R = Rsum/n;

% Kappa
if (R<.53)
    kappa=2*R+R^3+5*R^5/6;
elseif (R<.85)
    kappa=-0.4+1.39*R+0.43/(1-R);
else
    kappa=1/(R^3-4*R^2+3*R);
end

% Standard deviation
sigma = sqrt(-2*log(R));
if nargout<4; return; end

% Confidence angle
chi2 = chi2inv(alpha,1);
if ((R<.9) && (R>sqrt(chi2/(2*n))))
    CI = acos(sqrt(2*n*(2*Rsum^2-n*chi2)/(4*n-chi2))/Rsum);
elseif (R>.9)
    CI = acos(sqrt(n^2-(n^2-Rsum^2)*exp(chi2/n))/Rsum);
else % R is really really small ...
    CI = pi/2;
    warning('Confidence angle not well determined.')
    %this is not good, but not important because the confidence is so low anyway...
end

%conflim=.95;
%this is true if the
%chi2=3.841; % = chi2inv(.95,1)
