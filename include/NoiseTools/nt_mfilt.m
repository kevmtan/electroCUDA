function y=nt_mfilt(x,M,B,A,expand)
%y=nt_mfilt(x,M,B,A,expand) - multichannel filter
%
%  y: filtered data 
%
%  x: data to filter (time X channel) 
%  M: multichannel impulse response (ichannel X ochannel X lag)
%  B, A: bank of filters 
%  expand: if true output 3D matrix, one band per page (else add)
%
% Output is sum of spatially and temporally filtered inputs, one for each band. 
% For each lag, the spatial filter is defined by one page of M.
%
% If B is provided, lags are replaced by FIR filter outputs (each
% column of A defines a FIR filter).  If A is provided, the
% filters are IIR.
% 
% Default filters are lags: B=eye(nbands) and A=ones(1,nbands);
%
%  Data can be 2D matrix or cell array of 2D matrices.
%
%  M is 3D matrix ( inchannels X outchannels X bands )
%
%  Examples:
%  Filter with multichannel FIR filter M:
%       y=nt_mfilt(x,M)
%
%  Same, but lags replaced by FIR filters:
%       y=nt_mfilt(x,M,B)
%
%  Same, but filters are IIR:
%       y=nt_mfilt(x,M,B,A);
%
%  Examples of filter bases:
%  Basis of lags (default): 
%       B=eye(nbands);
%  Basis of nbands cosines of duration 100 samples:
%       B=cos(2*pi*(1:100)'*(1:nbands)/100)
%  Basis of 6 dyadic filters:
%       b=zeros(32,1); B=nt_multismooth(b,[1 2 4 8 16 32],[],1);
%
% Other simple examples:
%
%  Simple matrix multiplication:
%       M=zeros(size(M0,1),size(M0,2),1); % M0 is the matrix
%       M(:,:,1)=M0;
%       y=nt_mfilt(x,M);
%
%  Apply a different FIR to each data channel:
%       M=zeros(size(x,2),size(x,2),order);
%       for k=1:size(x,2); M(k,k,:)=B(:,k); % FIRs are columns of B
%       y=nt_mfilt(x,M,B); 
%
%  Same, different approach:
%       M=zeros(size(x,2),size(x,2),size(x,2));
%       for k=1:size(x,2); M(k,k,k)=1; end
%       y=nt_mfilt(x,M,B);
%
%  Apply the same set of FIR filters B to each channel
%       M=zeros(size(x,2),size(x,2),size(B,2));
%       for k=1:size(x,2); M(k,k,:)=1;
%       expandflag=1; % output each filter on different page
%       y=nt_mfilt(x,M,B,[],expandflag); % y is 3D

if nargin<2; error('!'); end
if nargin<3; B=[]; end
if nargin<4; A=[]; end
if nargin<5; expand=0; end

% handle cell array data
if iscell(x)
    y={};
    for iCell=1:numel(x)
        y{iCell}=nt_mfilt(x{iCell},M,B,A,expand);
    end
    return;
end
if ndims(x)>2; error('2D only - pass higher dim data as cell array'); end

% sizes consistent?
[nchans_i,nchans_o,nbands]=size(M);
if size(x,2) ~= nchans_i ; error('!'); end

% default filters
if isempty(B); B=eye(nbands); end
if isempty(A); A=ones(1,nbands); end
% check sizes
if size(B,2) ~= nbands;  error('!'); end
if size(A,2) ~= nbands;  error('!'); end
    
% filter
y=zeros(size(x,1),nchans_o,nbands);
for iBand=1:nbands
    xx=filter(B(:,iBand),A(:,iBand),x);
    y(:,:,iBand)=xx*M(:,:,iBand);
end

if ~expand
    y=sum(y,3);
end

% tests/examples
if 0
    % basic tests
    x=rand(100,1); % single channel data
    M=ones(1,1,1);
    y=nt_mfilt(x,M);
    disp(size(y));
    
    B=1;
    y=nt_mfilt(x,M,B);
    disp(size(y));
    
    A=1;
    y=nt_mfilt(x,M,B,A);
    disp(size(y));
    
    M=ones(1,1,10); % 10-tap FIR
    y=nt_mfilt(x,M); 
    disp(size(y));
    
    M=ones(1,5,1); % fanout to 5 channels
    y=nt_mfilt(x,M); 
    disp(size(y));
    
    M=ones(1,5,10); % fanout to 5, 10-tap FIR 
    y=nt_mfilt(x,M); 
    disp(size(y));
    
    x=randn(100,15); % 15-channel data
    M=ones(15,5,1); % fanin to 5
    y=nt_mfilt(x,M); 
    disp(size(y));
    
    M=ones(15,5,10); % fanin to 5, 10-tap FIR
    y=nt_mfilt(x,M); 
    disp(size(y));
    
    B=eye(10); % basis is lags (default)
    y=nt_mfilt(x,M,B); 
    disp(size(y));

    B=ones(11,10); % basis is 10-channel filterbank made of FIRs of order 11
    y=nt_mfilt(x,M,B); 
    disp(size(y));

    B=ones(3,10); A=ones(2,10); % basis is 10-channel filterbank made of IIRs of order 3
    y=nt_mfilt(x,M,B,A);    
    disp(size(y));
end
    
if 0
    x=zeros(100,1); x(1)=1.1; % 
    M=zeros(1,1,6); M(1,1,6)=1; % delay by 5 samples
    figure(1); clf; plot(nt_mfilt(x,M));
    
    M=zeros(1,6,6); 
    for k=1:6;M(1,k,k)=1; end; % delay by 0:5 samples
    figure(1); clf; plot(nt_mfilt(x,M));

    B=zeros(61,6); 
    for k=1:6; B((k-1)*10+1,k)=1; end;  % basis consists of set of larger delays
    figure(1); clf; plot(nt_mfilt(x,M,B));    
    
    B=[]; A=[];
    for k=1:6;
        [B(k,:),A(k,:)]=butter(2,[k,k+1]/(2*10),'bandpass'); % basis consists of bandpass filters
    end
    B=B'; A=A';
    figure(1); clf; plot(nt_mfilt(x,M,B,A));   
    
    x=randn(100,3); % 3-channel
    M=randn(3,4,6); % fanout to 4, order-6 'FIR'
    y=nt_mfilt(x,M,B,A);  % apply using bandpass basis
    figure(1); clf; plot(y);
    % The output here is the sum of 6 4-channel signals, each produced by
    % applying a 3X4 transform matrix to input signals filtered by the
    % corresponding basis.
    
end


if 0
    % equivalent of nt_multishift
    x=zeros(100,1);
    x(1,:)=1;
    expand=true;
    y=nt_mfilt(x,ones(2,1,10),eye(10),[],expand);
    disp(size(y))
    figure(1); clf; plot(squeeze(y*1.1));
end

    
