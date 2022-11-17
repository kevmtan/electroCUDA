function resp = h_func(p1,p2,theta)
sigmax = 2*pi/3;
sigmay = 2*pi/1.8;
rho = 2.1;
x = p1*cos(theta) + p2*sin(theta);
y = -p1*sin(theta) + p2*cos(theta);
resp = exp(-(x^2)/(2*(sigmax^2)) - (y^2)/(2*(sigmay^2)))...
	* cos(2*x*pi/rho);