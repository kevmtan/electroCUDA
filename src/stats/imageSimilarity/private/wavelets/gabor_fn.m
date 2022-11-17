function gb=gabor_fn(rangeX,rangeY,sigmaIn,theta,freq,shift)
%

% Sigma_x and Sigma_y must be integers
% For fingerprint enhancement, sigma_x and sigma_y should be the half of the wave length
% (1/(2*Freq)
%sz_x=6*sigma_x+1;
%sz_y=6*sigma_y+1;

if length(shift)==2, shift(3)=0; end;

[x y]=meshgrid(rangeX,rangeY);

% Rotation 
x_theta=(x-shift(1))*cos(theta)+(y-shift(2))*sin(theta);
y_theta=-(x-shift(1))*sin(theta)+(y-shift(2))*cos(theta);

gb=exp(-.5*(x_theta.^2/sigmaIn^2+y_theta.^2/sigmaIn^2)).*cos(2*pi*freq*x_theta-shift(3));
