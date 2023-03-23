function [fHi,wnd] = ec_designFiltASR(fs,transition,attenuation)
arguments
    fs (1,1) double = 1000
    transition (1,2) double = [0.25 0.75]
    attenuation (1,1) double = 80
end
% Design highpass FIR filter
transition = 2*transition/fs;
wnd = design_kaiser(transition(1),transition(2),attenuation,true);
fHi = design_fir(length(wnd)-1,[0 transition 1],[0 0 1 1],[],wnd);
end

%%
function W = design_kaiser(lo,hi,atten,odd)
% Design a Kaiser window for a low-pass FIR filter
%
% In:
%   Lo : normalized lower frequency of transition band
%   Hi : normalized upper frequency of transition band
%   Attenuation : stop-band attenuation in dB (-20log10(ratio))
%   OddLength : whether the length shall be odd
%
% Out:
%   W : Designed window
%
% Copyright (C) Christian Kothe, SCCN, 2013, ckothe@ucsd.edu

% determine beta of the kaiser window
if atten < 21
    beta = 0;
elseif atten <= 50
    beta = 0.5842*(atten-21).^0.4 + 0.07886*(atten-21);
else
    beta = 0.1102*(atten-8.7);
end

% determine the number of points
N = round((atten-7.95)/(2*pi*2.285*(hi-lo)))+1;
if odd && ~mod(N,2)
    N = N+1; end

% design the window
W = window_func('kaiser',N,beta);
end

%%
function B = design_fir(N,F,A,nfft,W)
% Design an FIR filter using the frequency-sampling method.
% The frequency response is interpolated cubically between the specified
% frequency points.
%
% In:
%   N : order of the filter
%
%   F : vector of frequencies at which amplitudes shall be defined
%       (starts with 0 and goes up to 1; try to avoid too
%        sharp transitions)
%
%   A : vector of amplitudes, one value per specified frequency
%
%   nFFT : optionally number of FFT bins to use
%
%   W : optionally the window function to use (default: Hamming)
%
% Out:
%   B : designed filter kernel
%
% Copyright (C) Christian Kothe, SCCN, 2013, ckothe@ucsd.edu

if nargin < 4 || isempty(nfft)
    nfft = max(512,2^ceil(log(N)/log(2))); end
if nargin < 5
    W = 0.54 - 0.46*cos(2*pi*(0:N)/N); end

% calculate interpolated frequency response
F = interp1(round(F*nfft),A,(0:nfft),'pchip');

% set phase & transform into time domain
F = F .* exp(-(0.5*N)*sqrt(-1)*pi*(0:nfft)./nfft);
B = real(ifft([F conj(F(end-1:-1:2))]));

% apply window to kernel
B = B(1:N+1).*W(:)';
end

%%
function w = window_func(name,m,param)
% Design a window for a given window function
%
% In:
%   Name : name of the window, can be any of the following:
%          'bartlett' : Bartlett window
%          'barthann' : Bartlett-Hann window
%          'blackman' : Blackman window
%          'blackmanharris' : Blackman-Harris window
%          'flattop'  : Flat-top window
%          'gauss'    : Gaussian window with parameter alpha (default: 2.5)
%          'hamming'  : Hamming window
%          'hann'     : Hann window
%          'kaiser'   : Kaiser window with parameter beta (default: 0.5)
%          'lanczos'  : Lanczos window
%          'nuttall'  : Blackman-Nuttall window
%          'rect'     : Rectangular window
%          'triang'   : Triangular window
%
%   N : number of points in the window
%
%   Param : window parameter (if any)
%
% Out:
%   W : designed window (column vector)
%
% Copyright (C) Christian Kothe, SCCN, 2011, ckothe@ucsd.edu

p = (0:(m-1))/(m-1);
switch name
    case 'bartlett'
        w = 1 - abs(((0:(m-1)) - (m-1)/2)/((m-1)/2));
    case {'barthann','barthannwin'}
        w = 0.62 - 0.48*abs(p-0.5) - 0.38*cos(2*pi*p);
    case 'blackman'
        w = 0.42-0.5*cos(2*pi*p) + 0.08*cos(4*pi*p);
    case 'blackmanharris'
        w = 0.35875 - 0.48829*cos(2*pi*p) + 0.14128*cos(4*pi*p) - 0.01168*cos(6*pi*p);
    case {'bohman','bohmanwin'}
        w = (1-abs(p*2-1)).*cos(pi*abs(p*2-1)) + (1/pi)*sin(pi*abs(p*2-1));
    case {'flattop','flattopwin'}
        w = 0.2157 - 0.4163*cos(2*pi*p) + 0.2783*cos(4*pi*p) - 0.0837*cos(6*pi*p) + 0.0060*cos(8*pi*p);
    case {'gauss','gausswin'}
        if nargin < 3
            param = 2.5; end
        w = exp(-0.5*(param*2*(p-0.5)).^2);
    case 'hamming'
        w = 0.54-0.46*cos(2*pi*p);
    case 'hann'
        w = 0.5-0.5*cos(2*pi*p);
    case 'kaiser'
        if nargin < 3
            param = 0.5; end
        w = besseli(0,param*sqrt(1-(2*p-1).^2))/besseli(0,param);
    case 'lanczos'
        w = sin(pi*(2*p-1))./(pi*(2*p-1)); w(isnan(w)) = 1;
    case {'nuttall','nuttallwin'}
        w = 0.3635819 - 0.4891775*cos(2*pi*p) + 0.1365995*cos(4*pi*p) - 0.0106411*cos(6*pi*p);
    case {'rect','rectwin'}
        w = ones(1,m);
    case 'triang'
        w = 1 - abs(((0:(m-1)) - (m-1)/2)/((m+1)/2));
    otherwise
        % fall back to the Signal Processing toolbox for unknown windows
        if nargin < 3
            w = window(name,m);
        else
            w = window(name,m,param);
        end
end

w = w(:);
end