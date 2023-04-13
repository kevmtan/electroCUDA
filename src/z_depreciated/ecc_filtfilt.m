function x = ec_filtfilt(x,b)
% Input validation
a = cast(1,like=b);
validateattributes(b,{'double','single'},{'2d','finite','nonempty'},'filtfilt');
validateattributes(a,{'double','single'},{'2d','finite','vector','nonempty'},'filtfilt');
validateattributes(x,{'double','single'},{'finite','nonempty'},'filtfilt');

%% Main
coder.gpu.kernelfun; % Add kernelfun pragma to trigger kernel creation
[nFrames,nChs] = cast(size(x),like=b);


[b1,a1,zi,nfact,L] = getInit_lfn(b,a,nFrames);

% filtfilt
coder.gpu.kernel(nChs,-1)
for ch = 1:nChs
    x(:,ch) = ec_filtfilt1(x(:,ch),);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% filtfilt_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = ec_filtfilt1(x,b,a)
%FILTFILT Zero-phase forward and reverse digital IIR filtering.
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
%#codegen
%
% For filtfilt(D,X), the inputs passed to the function are B,A,X thanks
% to the method of D.

if coder.target('MATLAB')
    y = efiltfilt_lfn(b,a,x);
else
    allConst = coder.internal.isConst(b) && ...
        coder.internal.isConst(a) && coder.internal.isConst(x);
    if allConst && coder.internal.isCompiled
        % Constant Inputs
        y = coder.const(@feval,'ec_filtfilt1',b,a,x);
    else
        % Variable Inputs
        y = efiltfilt_lfn(b,a,x);
    end
end



%% efiltfilt_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = efiltfilt_lfn(b,a,x)



[Npts,Nchans] = size(x);

% Parse SOS matrix or coefficients vectors and determine initial
% conditions
[b2,a2,zi,nfact,L] = getInit_lfn(b,a,Npts);

% output data type
% this ensures that data type and complexity is handled in code
% generation.
odt = zeros('like',a2) + zeros('like',b2) + zeros('like',x);

% Filter the data
if Nchans==1
    if Npts<10000
        yCol = ffOneChanCat(b2,a2,x,zi,nfact,L,odt);
    else
        yCol = ffOneChan(b2,a2,x,zi,nfact,L,odt);
    end
else
    yCol = ffMultiChan(b2,a2,x,zi,nfact,L,odt);
end

% convert back to row if necessary
if xIsRow
    % to avoid transposing N-dim array in code generation
    y = reshape(yCol,1,size(yCol,1));
else
    y = yCol;
end



%% getInit_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [b1,a1,zi,nfact,L] = getInit_lfn(b,a,Npts)
[L, ncols] = size(b);
na = numel(a);

% Rules for the first two inputs to represent an SOS filter: b is an
% Lx6 matrix with L>1 or, b is a 1x6 vector, its 4th element is equal
% to 1 and a has less than 2 elements.
if ncols==6 && L==1 && na<=2
    if b(4)==1
        coder.internal.warning('signal:filtfilt:ParseSOS', 'SOS', 'G');
    else
        coder.internal.warning('signal:filtfilt:ParseB', 'a01', 'SOS');
    end
end
issos = ncols==6 && (L>1 || (b(4)==1 && na<=2));

cdt = zeros('like',b)+zeros('like',a);
zi = coder.nullcopy(zeros(2,L,'like',cdt));
coder.varsize('b1','a1');

if issos 
    % b is an SOS matrix, a is a vector of scale values
    g = a(:);
    ng = na;

    coder.internal.assert(ng <= L+1,'signal:filtfilt:InvalidDimensionsScaleValues', L + 1)

    sosMat = cast(b,'like',cdt);

    if ng == L+1
        % Include last scale value in the numerator part of the SOS
        % Matrix
        sosMat(L,1:3) = g(L+1)*b(L,1:3);
        ng = ng-1;
    end

    for ii=1:ng
        % Include scale values in the numerator part of the SOS Matrix
        sosMat(ii,1:3) = g(ii)*b(ii,1:3);
    end
    ord = filtord(sosMat);

    % Get second order section coefficients. Ensure a0 for each filter
    % is normalized to 1
    coder.internal.errorIf(any(sosMat(:,4) == 0),'signal:filtfilt:ZeroA0CoeffsSOS');

    a0 = sosMat(:,4:6).';
    b0 = sosMat(:,1:3).';
    s = a0([1 1 1],:);
    a1 = a0./s;
    b1 = b0./s;

    % length of edge transients
    nfact = max(1,3*ord);

    % input data too short
    coder.internal.errorIf(Npts <= nfact(1,1),'signal:filtfilt:InvalidDimensionsDataShortForFiltOrder', nfact(1,1));

    % Compute initial conditions to remove DC offset at beginning and
    % end of filtered sequence.  Use sparse matrix to solve linear
    % system for initial conditions zi, which is the vector of states
    % for the filter b(z)/a(z) in the state-space formulation of the
    % filter.
    for ii=1:L
        rhs  = (b1(2:3,ii) - b1(1,ii)*a1(2:3,ii));
        zi(:,ii) = ( eye(2,'like',cdt) - [-a1(2:3,ii),[1;0]] ) \ rhs;
    end
else
    %------------------------------------------------------------------
    % b & a are vectors that define the transfer function of the filter
    %------------------------------------------------------------------

    coder.internal.errorIf((~isvector(a) || ~isvector(b)),'signal:filtfilt:InputNotSupported');
    L = 1;
    % Check coefficients - ensure a0 is 1
    coder.internal.errorIf(a(1) == 0,'signal:filtfilt:ZeroA0Coeffs');

    nb = numel(b);
    nfilt = max(nb,na);
    nfact = max(1,3*(nfilt-1));  % length of edge transients

    % input data too short
    coder.internal.errorIf(Npts <= nfact(1,1),'signal:filtfilt:InvalidDimensionsDataShortForFiltOrder', nfact(1,1));

    if coder.target('MATLAB')
        b1 = b(:)/a(1,1);
        a1 = a(:)/a(1,1);

        % Zero pad shorter coefficient vector as needed
        if nb < nfilt
            b1 = [b1; zeros(nfilt-nb,1)];
        elseif na < nfilt
            a1 = [a1; zeros(nfilt-na,1)];
        end
    else

        b1 = zeros(nfilt, 1, 'like', cdt);
        a1 = zeros(nfilt, 1, 'like', cdt);

        for k = 1:coder.internal.indexInt(numel(b))
            b1(k) = b(k)/a(1,1);
        end

        for k = 1:coder.internal.indexInt(numel(a))
            a1(k) = a(k)/a(1,1);
        end
    end

    % Compute initial conditions to remove DC offset at beginning and
    % end of filtered sequence.  Use sparse matrix to solve linear
    % system for initial conditions zi, which is the vector of states
    % for the filter b(z)/a(z) in the state-space formulation of the
    % filter.
    if nfilt>1
        useSparse = coder.target('MATLAB') || ~coder.internal.isCompiled || ...
            strcmp(eml_option('UseMalloc'),'VariableSizeArrays');
        if useSparse
            % The sparse solution makes use of dynamic memory
            % allocation during code generation
            rows = [1:nfilt-1, 2:nfilt-1, 1:nfilt-2];
            cols = [ones(1,nfilt-1), 2:nfilt-1, 2:nfilt-1];
            vals = [1+a1(2,1), a1(3:nfilt,1).', ones(1,nfilt-2), -ones(1,nfilt-2)];
            rhs  = b1(2:nfilt,1) - b1(1,1)*a1(2:nfilt,1);
            % sparse function does not support single precision hence
            % casting to double
            zi = sparse(rows,cols,double(vals)) \ double(rhs);
            zi = cast(zi,'like',cdt);
        else
            % The non-sparse solution to zi may be computed using:
            zi = ( eye(nfilt-1,'like',cdt) - [-a1(2:nfilt,1), [eye(nfilt-2,'like',cdt); ...
                zeros(1,nfilt-2,'like',cdt)]] ) \ ( b1(2:nfilt,1) - b1(1,1)*a1(2:nfilt,1) );
        end
    else
        zi = zeros(0,1,'like',cdt);
    end
end


%--------------------------------------------------------------------------
function yout = ffOneChanCat(b,a,xc,zi,nfact,L,odt)
n = size(xc,1);
yout = coder.nullcopy(zeros(n,1,'like',odt));
ytemp = coder.nullcopy(zeros(n+2*nfact,1,'like',odt));
yout(:) = xc;
for ii=1:L
    % Single channel, data explicitly concatenated into one vector
    ytemp(:) = [2*yout(1)-yout(nfact+1:-1:2); yout; 2*yout(end)-yout(end-1:-1:end-nfact)];

    % filter, reverse data, filter again, and reverse data again
    ytemp = filter(b(:,ii),a(:,ii),ytemp,zi(:,ii)*ytemp(1),1);
    ytemp = ytemp(end:-1:1);
    ytemp = filter(b(:,ii),a(:,ii),ytemp,zi(:,ii)*ytemp(1),1);

    % retain reversed central section of y
    yout(:) = ytemp(end-nfact(1,1):-1:nfact(1,1)+1);
end


%--------------------------------------------------------------------------
function y = ffOneChan(b,a,xc,zi,nfact,L,odt)
% Perform filtering of input data with no phase distortion
%
% xc: one column of input data
% yc: one column of output, same dimensions as xc
% a,b: IIR coefficients, both of same order/length
% zi: initial states
% nfact: scalar
% L: scalar
% odt: output data type

% Extrapolate beginning and end of data sequence using reflection.
% Slopes of original and extrapolated sequences match at end points,
% reducing transients.
%
% yc is length numel(x)+2*nfact
%
% We wish to filter the appended sequence:
% yc = [2*xc(1)-xc(nfact+1:-1:2); xc; 2*xc(end)-xc(end-1:-1:end-nfact)];
%
% We would use the following code:
% Filter the input forwards then again in the backwards direction
%   yc = filter(b,a,yc,zi*yc(1));
%   yc = yc(length(yc):-1:1); % reverse the sequence
%
% Instead of reallocating and copying, just do filtering in pieces
% Filter the first part, then xc, then the last part
% Retain each piece, feeding final states as next initial states
% Output is yc = [yc1 yc2 yc3]
%
% yc2 can be long (matching user input length)
% yc3 is short (nfilt samples)
%
xc1 = cast(xc,'like',odt);
for ii=1:L

    xt = -xc1(nfact(1,1)+1:-1:2,1) + 2*xc1(1,1);
    [~,zo] = filter(b(:,ii),a(:,ii), xt(:,1), zi(:,ii)*xt(1),1); % yc1 not needed
    [yc2,zo] = filter(b(:,ii),a(:,ii), xc1(:,1), zo,1);
    xt = -xc1(end-1:-1:end-nfact(1,1),1) + 2*xc1(end,1);
    yc3 = filter(b(:,ii),a(:,ii), xt(:,1), zo,1);

    % Reverse the sequence
    %   yc = [flipud(yc3) flipud(yc2) flipud(yc1)]
    % which we can do as
    %   yc = [yc3(end:-1:1); yc2(end:-1:1); yc1(end:-1:1)];
    %
    % But we don't do that explicitly.  Instead, we wish to filter this
    % reversed result as in:
    %   yc = filter(b,a,yc,zi*yc(1));
    % where yc(1) is now the last sample of the (unreversed) yc3
    %
    % Once again, we do this in pieces:
    [~,zo] = filter(b(:,ii),a(:,ii),yc3(end:-1:1,1),zi(:,ii)*yc3(end,1),1);
    yc5 = filter(b(:,ii),a(:,ii),yc2(end:-1:1,1),zo,1);

    % Conceptually restore the sequence by reversing the last pieces
    %    yc = yc(length(yc):-1:1); % restore the sequence
    % which is done by
    %    yc = [yc6(end:-1:1); yc5(end:-1:1); yc4(end:-1:1)];
    %
    % However, we only need to retain the reversed central samples of filtered
    % output for the final result:
    %    y = yc(nfact+1:end-nfact);
    %
    % which is the reversed yc5 piece only.
    %
    % This means we don't need yc4 or yc6.  We need to compute yc4 only because
    % the final states are needed for yc5 computation.  However, we can omit
    % yc6 entirely in the above filtering step.
    xc1 = yc5(end:-1:1,1);
end
y = xc1;


%--------------------------------------------------------------------------
function y = ffMultiChan(b,a,xc,zi,nfact,L,odt)
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

xc1 = cast(xc,'like',odt);
sz = size(xc1);
xc1 = reshape(xc1,sz(1),[]);%converting N-D matrix to 2-D.

for ii=1:L
    xt = bsxfun(@minus, 2*xc1(1,:),xc1(nfact(1,1)+1:-1:2,:));
    [~,zo] = filter(b(:,ii),a(:,ii),xt,zi(:,ii)*xt(1,:),1); % outer product
    [yc2,zo] = filter(b(:,ii),a(:,ii),xc1,zo,1);
    xt = bsxfun(@minus, 2*xc1(end,:),xc1(end-1:-1:end-nfact(1,1),:));
    yc3 = filter(b(:,ii),a(:,ii),xt,zo,1);

    [~,zo] = filter(b(:,ii),a(:,ii),yc3(end:-1:1,:),zi(:,ii)*yc3(end,:),1); % outer product
    yc5 = filter(b(:,ii),a(:,ii),yc2(end:-1:1,:),zo,1);

    xc1 = yc5(end:-1:1,:);

end
y = xc1;
y = reshape(y,sz);% To match the input size.


% LocalWords:  Lx th zi nfilt xc yc IIR nfact xt unreversed nullcopy Npts nb na yout
% LocalWords:  Nchans filtord designfilt noisysignals highpassiir Sanjit Mitra
% LocalWords:  nd Graw Fredrik Gustafsson
