function y=nt_phase_scramble(x,allsameflag)
%y=nt_phase_scramble(x,allsameflag) - scramble time but preserve autocorrelation
%
%  y: scrambled data
%
%  x: data to scramble (time X channels, or time X channels X trials
%  allsameflag: if true, same random phasor to all channels [default: true]
%

if nargin<1; error('!'); end
if nargin<2||isempty(allsameflag); allsameflag=1; end




[nsample,nchan,ntrial]=size(x);
if rem(nsample,2)~=0 % pad to multiple of 2
    x(nsample+1,:,:)=x(nsample,:,:); 
end

for iTrial=1:ntrial
    xx=x(:,:,iTrial);
    yy=fft(xx);
    if allsameflag
         phasor=exp(-2*pi*j*rand(size(x,1)/2-1,1)); % same for all channels
	     yy=yy.*repmat([1;phasor; 1; conj(flipud(phasor))],1,nchan);
    else
        phasor=exp(-2*pi*j*rand(size(x,1)/2-1,nchan)); % channel-specific
        yy=yy.*[ones(1,nchan);phasor; ones(1,nchan); conj(flipud(phasor))];
    end
    yy=real(ifft(yy));
    y(:,:,iTrial)=yy;
end

y=y(1:nsample,:,:); % remove padding if need

