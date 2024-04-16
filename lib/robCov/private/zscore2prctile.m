function prc=zscore2prctile(z,nD,M)
  if nargin<3 || isempty(M) %Degrees of Freedom of covariance matrix not given, assuming it is the exact covariance.
      prc=chi2cdf(z,nD); %~central chi-square distribution with nD degrees of freedom
  else
      prc=fcdf(z*(M-nD)/(nD*(M-1)),nD,M-nD); %~ Hotelling's T^2 = nD*(M-1)/(M-nD) F_{nD,M-nD}
  end
end
