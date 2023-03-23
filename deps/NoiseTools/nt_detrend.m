function [y,w,r]=nt_detrend(x,order,w0,basis,thresh,niter,wsize) 
%[y,w,r]=nt_detrend(x,order,w,basis,thresh,niter,wsize) - robustly remove trend
% 
%  y: detrended data
%  w: updated weights
%  r: basis matrix used
%
%  x: raw data
%  order: order of polynomial or number of sin/cosine pairs
%  w0: weights
%  basis: 'polynomials' [default] or 'sinusoids', or user-provided matrix
%  thresh: threshold for outliers [default: 3 sd]
%  niter: number of iterations [default: 3]
%  wsize: window size for local detrending [default: all]
%
% This NEW (circa Oct 2019) version of detrend allows detrending to be
% applied to smaller overlapping windows, which are then stitched together
% using overlap-add. This is not described in the paper.

nt_greetings;

%% arguments
if nargin<2; error('!'); end
if nargin<3; w0=[]; end
if nargin<4||isempty(basis); basis='polynomials'; end
if nargin<5||isempty(thresh); thresh=3; end
if nargin<6||isempty(niter); niter=3; end
if nargin<7; wsize=[]; end

if iscell(x)
    if ~isempty(w0); error('not implemented'); end
    y={}; w={}; r={};
    for iTrial=1:numel(x);
        [y{iTrial},w{iTrial},r{iTrial}]=nt_detrend(x{iTrial},order,w0,basis,thresh,niter,wsize);
    end
    return
end

w=w0;
if ~isempty(w)
    w=w(:);
    if numel(w)<size(x,1)
        % assume that w contains indices, set them to 1
        idx=w;
        w=zeros(size(x,1),1);
        w(idx)=1;
    end
end

if isempty(wsize) || ~wsize
    % standard detrending (trend fit to entire data)
    [y,w,r]=nt_detrend_helper(x,order,w,basis,thresh,niter);
else
    wsize=2*floor(wsize/2);
    
    % do some sanity checks because many parameters
    if numel(order)>1; error('!'); end
    if ~isempty(w) && ~(size(w,1)==size(x,1)) ; disp(size(w)); error('!'); end
    if ~(isempty(basis) || isstring(basis) || ~(isnumeric(basis)&&size(basis,1)==size(x,1))); error('!'); end
    if thresh==0; error('thresh=0 is not what you want...'); end % common mistake
    if numel(thresh)>1; error('!'); end
    if numel(niter)>1; error('!'); end

    dims=size(x); nchans=dims(2);
    x=x(:,:); % concatenates dims >= 2
    w=w(:,:);
    if isempty(w); w=ones(size(x)); end
    if size(w,2)==1; w=repmat(w,1,size(x,2)); end


    % (1) divide into windows, (2) detrend each, (3) stitch together, (4)
    % estimate w

    for iIter=1:niter

        y=zeros(size(x));
        trend=zeros(size(x));
        a=zeros(size(x,1),1);

    %     figure(1); clf

        offset=0;
        while true
            start=offset+1;
            stop=min(size(x,1),offset+wsize);

            % if not enough valid samples grow window:
            counter=5;
            while any (sum(min(w(start:stop),2))) <wsize
                if counter <= 0 ; break; end 
                start=max(1,start-wsize/2);
                stop=min(size(x,1),stop+wsize/2);
                counter=counter-1;
            end
            if rem(stop-start+1,2)==1; stop=stop-1; end
            wsize2=stop-start+1;

            % detrend this window
            NITER=1;
            yy=nt_detrend_helper(x(start:stop,:),order,w(start:stop,:),basis,thresh,NITER);

            % triangular weighting
            if start==1
                b=[ones(1,wsize2/2)*wsize2/2, wsize2/2:-1:1]';
            elseif stop==size(x,1)
                b=[1:wsize2/2, ones(1,wsize2/2)*wsize2/2]';
            else
                b=[1:wsize2/2, wsize2/2:-1:1]';
            end

            % overlap-add to output
            y(start:stop,:)=y(start:stop,:)+bsxfun(@times,yy,b);
            trend(start:stop,:)=trend(start:stop,:)+bsxfun(@times,x(start:stop,:)-yy,b);

            a(start:stop,1)=a(start:stop)+b;

            offset=offset+wsize/2;
            if offset>size(x,1)-wsize/2; break; end
        end
        
        if stop<size(x,1); y(end,:)=y(end-1,:); a(end,:)=a(end-1,:); end; % last sample can be missed
        
        y=bsxfun(@times,y,1./a); y(find(isnan(y)))=0;
        trend=bsxfun(@times,trend,1./a);  trend(find(isnan(trend)))=0;

        % find outliers
        d=x-trend; 


        if ~isempty(w); d=bsxfun(@times,d,w); end
        ww=ones(size(x));
        ww(find(abs(d)>thresh*repmat(std(d),size(x,1),1))) = 0;
        clear d

        % update weights
        if isempty(w); 
            w=ww;
        else
            w=min(w,ww);
        end
        clear ww;

    end % for iIter...
    
    w=[];r=[]; % not informative
    
end % if isempty(wsize)...

if ~nargout
    % don't return, just plot
    subplot 411; plot(x); title('raw'); xlim([1,size(x,1)])
    subplot 412; plot(y); title('detrended'); xlim([1,size(x,1)])
    subplot 413; plot(x-y); title('trend'); xlim([1,size(x,1)])
    subplot 414; nt_imagescc(w'); title('weight');
    clear y w r
end
end

%% Original version of detrend (no windows) is called by new version (windows)
function [y,w,r]=nt_detrend_helper(x,order,w,basis,thresh,niter)
%[y,w,r]=nt_detrend(x,order,w,basis,thresh,niter) - robustly remove trend
% 
%  y: detrended data
%  w: updated weights
%  r: basis matrix used
%
%  x: raw data
%  order: order of polynomial or number of sin/cosine pairs
%  w: weights
%  basis: 'polynomials' [default] or 'sinusoids', or user-provided matrix
%  thresh: threshold for outliers [default: 3 sd]
%  niter: number of iterations [default: 3]
%
% Noise tools
% See nt_regw().
%
% The data are fit to the basis using weighted least squares. The weight is
% updated by setting samples for which the residual is greater than 'thresh' 
% times its std to zero, and the fit is repeated at most 'niter'-1 times.
%
% The choice of order (and basis) determines what complexity of the trend
% that can be removed.  It may be useful to first detrend with a low order
% to avoid fitting outliers, and then increase the order.
%
% Examples:
% Fit linear trend, ignoring samples > 3*sd from it, and remove:
%   y=nt_detrend(x,1); 
% Fit/remove polynomial order=5 with initial weighting w, threshold = 4*sd:
%   y=nt_detrend(x,5,w,[],4);
% Fit/remove linear then 3rd order polynomial:
%   [y,w]=nt_detrend(x,1);
%   [yy,ww]=nt_detrend(y,3);
%
nt_greetings;

% arguments
if nargin<2; error('!'); end
if nargin<3; w=[]; end
if nargin<4||isempty(basis); basis='polynomials'; end
if nargin<5||isempty(thresh); thresh=3; end
if nargin<6||isempty(niter); niter=3; end

if thresh==0; error('thresh=0 is not what you want...'); end % common mistake

dims=size(x);
x=x(:,:); % concatenates dims >= 2
w=w(:,:);

if size(w,2)==1; w=repmat(w,1,size(x,2)); end

%% regressors
if isnumeric(basis)
    r=basis;
else
    switch basis
        case 'polynomials'
            r=zeros(size(x,1),numel(order));
            lin=linspace(-1,1,size(x,1));
            for k=1:order
                r(:,k)=lin.^k;
            end
        case 'sinusoids'
            r=zeros(size(x,1),numel(order)*2);
            lin=linspace(-1,1,size(x,1));
            for k=1:order
                r(:,2*k-1)=sin(2*pi*k*lin/2);
                r(:,2*k)=cos(2*pi*k*lin/2);
            end
        otherwise
            error('!');
    end
end


% remove trends
% The tricky bit is to ensure that weighted means are removed before
% calculating the regression (see nt_regw).

for iIter=1:niter
    
    % weighted regression on basis
    [~,y]=nt_regw(x,r,w);
    
    % find outliers
    d=x-y; 
    if ~isempty(w); d=bsxfun(@times,d,w); end
    ww=ones(size(x));
    ww(find(abs(d)>thresh*repmat(std(d),size(x,1),1))) = 0;
     
    % update weights
    if isempty(w); 
        w=ww;
    else
        w=min(w,ww);
    end
    clear ww;    
end
y=x-y;
y=reshape(y,dims);
w=reshape(w,dims);

end

%% test code
function test_me
if 0
    % basic
    x=(1:100)'; x=x+ randn(size(x));
    WSIZE=30;
    y=nt_detrend2(x,1,[],[],[],[],WSIZE);
    figure(1); clf; plot([x,y]);
end
if 0
    % basic
    x=(1:100)'; x=x+ randn(size(x));
    x(40:50)=0;
    WSIZE=30;
    [yy,ww]=nt_detrend2(x,1,[],[],2,[],WSIZE);
    [y,w]=nt_detrend(x,1);
    figure(1); clf; subplot 211; 
    plot([x,y,yy]);
    subplot 212; plot([w,ww],'.-');
end
if 0
    % detrend biased random walk
    x=cumsum(randn(1000,1)+0.1);
    WSIZE=200;
    [y1,w1]=nt_detrend(x,1,[]);
    [y2,w2]=nt_detrend2(x,1,[],[],[],[],WSIZE);
    figure(1); clf; 
    plot([x,y1,y2]); legend('before', 'after');
end
if 0
    % weights
    x=linspace(0,100,1000)';
    x=x+3*randn(size(x));
    x(1:100,:)=100;
    w=ones(size(x)); w(1:100,:)=0;
    y=nt_detrend2(x,3,[],[],[],[],WSIZE);
    yy=nt_detrend2(x,3,w,[],[],[],WSIZE);
    figure(1); clf; plot([x,y,yy]); legend('before', 'unweighted','weighted');
end
if 0
    [p,x]=nt_read_data('/data/meg/theoldmanandthesea/eeg/mc/MC_aespa_speech_43.mat'); x=x'; x=x(:,1:128); %x=x(1:10000,:);
    %[p,x]=nt_read_data('/data/meg/arzounian/ADC_DA_140521_p20/ADC_DA_140521_p20_01_calib'); x=x'; x=x(1:10000,:);
    
    x=nt_demean(x);
    figure(1);
    nt_detrend(x,3);
    figure(2);
    WSIZE=1000;
    nt_detrend2(x(:,:),3,[],[],[],[],WSIZE);
end
end


