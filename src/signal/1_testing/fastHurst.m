function hurst = fastHurst(x)   % data set
[npoints,~] = size(x);
yvals = zeros(1,npoints);
xvals = zeros(1,npoints);
data2 = zeros(1,npoints);
index = 0;
binsize = 1;
while npoints>4
    y = std(x);
    index = index+1;
    xvals(index) = binsize;
    yvals(index) = y*binsize;
    
    npoints = fix(npoints/2);
    binsize = binsize*2;
    for ipoints = 1:npoints % average adjacent points in pairs
        data2(ipoints) = (x(2*ipoints)+x((2*ipoints)-1))*0.5;
    end
    x = data2(1:npoints);
    
end % while
xvals = xvals(1:index);
yvals = yvals(1:index);
logx = log(xvals);
logy = log(yvals);
p2 = polyfit(logx,logy,1);
hurst = p2(1); % Hurst exponent is the slope of the linear fit of log-log plot
