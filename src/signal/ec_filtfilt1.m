function y = ec_filtfilt1(x,b,a,z,nf,L)
%% [ec_filtfilt1] helper function for ec_filtfilt()
% FILTFILT Zero-phase forward and reverse digital IIR filtering.
%   Y = FILTFILT(B,A,X) filters the data in vector, matrix, or N-D
%   array, X, with the filter described by vectors A and B to create
%   the filtered data Y. The filter is described by the difference
%   equation:
%
%     a(1)*y(n) = b(1)*x(n) + b(2)*x(n-1) + ... + b(nb+1)*x(n-nb)
%                           - a(2)*y(n-1) - ... - a(na+1)*y(n-na)
%
%   filtfilt operates along the first dimension of X except when X is a
%   row vector in which case it operates along the second dimension.
%   The length of the input channels must be more than three times the
%   filter order, defined as max(length(B)-1,length(A)-1).
%
%   Y = FILTFILT(SOS,G,X) filters the data in vector, matrix, or N-D
%   array, X, with the second-order section (SOS) filter described by
%   the matrix SOS and the vector G. The coefficients of the SOS matrix
%   must be expressed using an Lx6 matrix where L is the number of
%   second-order sections. The scale values of the filter must be
%   expressed using the vector G. The length of G must be between 1 and
%   L+1, and the length of input channels in X must be more than three
%   times the filter order (input channel length must be greater than
%   one when the order is zero). You can use filtord(SOS) to get the
%   order of the filter. The SOS matrix should have the following form:
%
%   SOS = [ b01 b11 b21 a01 a11 a21
%           b02 b12 b22 a02 a12 a22
%           ...
%           b0L b1L b2L a0L a1L a2L ]
%
%   Y = FILTFILT(D,X) filters the data in vector, matrix, or N-D
%   array, X, with the digital filter D. You design a digital filter,
%   D, by calling the <a href="matlab:help designfilt">designfilt</a>
%   function. The length of the input channels in X must be more than
%   three times the filter order. You can use filtord(D) to get the
%   order of the digital filter D.
%
%   After filtering in the forward direction, the filtered data is
%   reversed and run back through the filter; Y is the time reverse of
%   the output of the second filtering operation. The result has
%   precisely zero phase distortion, and magnitude modified by the
%   square of the filter's magnitude response. Startup and ending
%   transients are minimized by matching initial conditions.
%
%   Note that FILTFILT should not be used when the intent of a filter
%   is to modify signal phase, such as differentiators and Hilbert
%   filters.
%
%   % Example 1:
%   %   Zero-phase filter a noisy ECG waveform using an IIR filter.
%
%   load noisysignals x;                    % noisy waveform
%   [b,a] = butter(12,0.2,'low');           % IIR filter design
%   y = filtfilt(b,a,x);                    % zero-phase filtering
%   y2 = filter(b,a,x);                     % conventional filtering
%   plot(x,'k-.'); grid on ; hold on
%   plot([y y2],'LineWidth',1.5);
%   legend('Noisy ECG','Zero-phase Filtering','Conventional Filtering');
%
%   % Example 2:
%   %   Use the designfilt function to design a highpass IIR digital
%   %   filter with order 4, passband frequency of 75 KHz, and a passband
%   %   ripple of 0.2 dB. Sample rate is 200 KHz. Apply zero-phase
%   %   filtering to a vector of data.
%
%   D = designfilt('highpassiir', 'FilterOrder', 4, ...
%            'PassbandFrequency', 75e3, 'PassbandRipple', 0.2,...
%            'SampleRate', 200e3);
%
%   x = rand(1000,1);
%   y = filtfilt(D,x);
%
%   See also FILTER, SOSFILT.
%   References:
%     [1] Sanjit K. Mitra, Digital Signal Processing, 2nd ed.,
%         McGraw-Hill, 2001
%     [2] Fredrik Gustafsson, Determining the initial states in forward-
%         backward filtering, IEEE Transactions on Signal Processing,
%         pp. 988-992, April 1996, Volume 44, Issue 4
%   Copyright 1988-2022 The MathWorks, Inc.
%
% For filtfilt(D,X), the inputs passed to the function are B,A,X thanks
% to the method of D.
%#codegen

%% Input validation
lfn = coder.target('MATLAB');
if ~lfn
    validateattributes(b,{'double','single'},{'2d','finite','nonempty'},'filtfilt');
    validateattributes(a,{'double','single'},{'2d','finite','vector','nonempty'},'filtfilt');
    validateattributes(x,{'double','single'},{'2d','finite','nonempty'},'filtfilt');
end
coder.gpu.kernelfun; % Add kernelfun pragma to trigger kernel creation

%% Run
nChs = cast(width(x),"uint16");
y = coder.nullcopy(x);

% Loop across chans
coder.gpu.kernel(nChs,-1); % Add kernelfun pragma to trigger kernel creation
for ch = 1:nChs
    coder.gpu.constantMemory(x);  
    coder.gpu.constantMemory(y);  
    y(:,ch) = filtfilt_lfn(x(:,ch),b,a,z,nf,L);
end



%% oneCh_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function x = filtfilt_lfn(x,b,a,z,nf,L)
% Perform filtering of input data with no phase distortion
%
% xc: matrix of input data
% yc: matrix of output data, same dimensions as xc
% a,b: IIR coefficients, both of same order/length
% zi: initial states
% nfact: scalar
% L: scalar
% odt: output data type
%
% Same comments as in ffOneChan, except here we need to use bsxfun.
% Instead of doing scalar subtraction with a vector, we are doing
% vector addition with a matrix.  bsxfun replicates the vector
% for us.
%
% We also take care to preserve column dimensions

%coder.gpu.nokernel(); % No kernel due to dependencies across loops
%coder.gpu.kernelfun; % Add kernelfun pragma to trigger kernel creation

% Loop by L
for ii = 1:L
    coder.gpu.constantMemory(x);
    coder.gpu.constantMemory(b);
    coder.gpu.constantMemory(a);
    coder.gpu.constantMemory(z);
    xt = bsxfun(@minus, 2*x(1,:),x(nf(1,1)+1:-1:2,:));
    [~,zo] = filter(b(:,ii),a(:,ii),xt,z(:,ii)*xt(1,:),1); % outer product
    [yc2,zo] = filter(b(:,ii),a(:,ii),x,zo,1);
    xt = bsxfun(@minus, 2*x(end,:),x(end-1:-1:end-nf(1,1),:));
    yc3 = filter(b(:,ii),a(:,ii),xt,zo,1);

    [~,zo] = filter(b(:,ii),a(:,ii),yc3(end:-1:1,:),z(:,ii)*yc3(end,:),1); % outer product
    yc5 = filter(b(:,ii),a(:,ii),yc2(end:-1:1,:),zo,1);

    x = yc5(end:-1:1,:);
end


% LocalWords:  x b a nf L
% LocalWords:  Lx th zi nfilt xc yc IIR nfact xt unreversed nullcopy Npts nb na yout
% LocalWords:  Nchans filtord designfilt noisysignals highpassiir Sanjit Mitra
% LocalWords:  nd Graw Fredrik Gustafsson
