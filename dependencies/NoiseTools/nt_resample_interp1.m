function  y=nt_resample_interp1(x,p,q,method)
%y=resample_interp1(x,p,q,method) - Resample using interp1 (no antialiasing)
%
%  y: resampled signal
%
%  x: data to resample
%  p,q: resample to p/q original sampling rate (p,q can be non-integer)
%  method: interpolation method [default: 'spline']
% 
% From interp1:
%       'linear'   - linear interpolation
%       'nearest'  - nearest neighbor interpolation
%       'next'     - next neighbor interpolation
%       'previous' - previous neighbor interpolation
%       'spline'   - piecewise cubic spline interpolation (SPLINE)
%       'pchip'    - shape-preserving piecewise cubic interpolation
%       'cubic'    - same as 'pchip'
%       'v5cubic'  - the cubic interpolation from MATLAB 5, which does not
%                    extrapolate and uses 'spline' if X is not equally
%                    spaced.
%       'makima'   - modified Akima cubic interpolation
%
% NoiseTools
nt_greetings;

if nargin < 4|| isempty(method); method='spline';   end
if nargin<3; error('!'); end

nsamples=size(x,1);
querypoints=1+(0:q/p:nsamples-1);
y=interp1((1:nsamples)',x,querypoints(:),method);


% tests
if 0
    % regular --> regular, different sampling rate
    N=45;
    t=(0:N)'/N;
    x=sin(2*pi*t);
    y=nt_resample_interp1(x,10,9,'spline');
    figure(1); clf; 
    plot(t,x, '.-'); 
    hold on
    plot(linspace(0,1,size(y,1)),y, '.-'); 
end

