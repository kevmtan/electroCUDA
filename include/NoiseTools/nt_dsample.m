function [y,yy,yyy]=nt_dsample(x,dsr,method)
%[y,yy,yyy]=nt_dsample(x,dsr,method) - downsample by averaging neighboring samples
%
%  y: downsampled data
%  yy: instantaneous power of residual
%  yyy: original minus downsampled
% 
%  x: data to downsample (2 or 3D)
%  dsr: downsampling ratio (must be integer)
%  method: 'smooth' or 'resample' [default: 'smooth']
%
% Downsampling is performed along columns.  If size(x,1) is not multiple of
% factor, it is truncated.
% 
% If method=smooth, data are lowpass filtered by convolution with a square window.
% This ensures minimal temporal distortion of the waveform. However it does not
% strongly attenuate frequency components beyond the Nyquist frequency, so
% it is not optimal from a frequency-domain point of view. 
% 
% If method=resample, downsampling is performed with a version of
% resample() modified so that the lowpass corner is 0.8 times Nyquist.
% 
% If output is not assigned, plot downsampled signal and residual power.
%
% NoiseTools

if nargin<3||isempty(method); method='smooth'; end
if nargin<2; error('!'); end
if dsr==1; 
    y=x;
    yy=zeros(size(x));
    yyy=x;
    return; 
end
if dsr ~= round(dsr); error('factor must be integer'); end

if iscell(x)
    switch nargout
        case 0
            for iTrial=1:numel(x)
                nt_dsample(x{iTrial},dsr,method);
                pause
            end
        case 1
           y={};
           for iTrial=1:size(x)
               y{iTrial}=nt_dsample(x{iTrial}.factor,method);
           end
        case 2
           y={};yy={};
           for iTrial=1:size(x)
               [y{iTrial},yy{iTrial}]=nt_dsample(x{iTrial}.factor,method);
           end
        case 3
           y={};yy={};
           for iTrial=1:size(x)
               [y{iTrial},yy{iTrial},yyy{iTrial}]=nt_dsample(x{iTrial}.factor,method);
           end
        otherwise
            error('!');
    end
    return
end

if ndims(x)>2
    d=size(x);
    switch nargout
        case 0
            for iTrial=1:size(x(:,:,:),3)
                nt_dsample(x(:,:,iTrial),dsr,method);
                pause
            end
        case 1
            x=x(:,:);
            y=nt_dsample(x,dsr);
            y=reshape(y,[size(y,1),d(2:end)]);
        case 2
            x=x(:,:);
            [y,yy]=nt_dsample(x,dsr);
            y=reshape(y,[size(y,1),d(2:end)]);
            yy=reshape(yy,[size(yy,1),d(2:end)]);
        case 3
            x=x(:,:);
            [y,yy,yyy]=nt_dsample(x,dsr);
            y=reshape(y,[size(y,1),d(2:end)]);
            yy=reshape(yy,[size(yy,1),d(2:end)]);
            yyy=reshape(yyy,[size(yyy,1),d(2:end)]);
        otherwise
            error('!'); 
    end
    return
end

if nargout==0
    [y,yy]=nt_dsample(x,dsr,method);
    figure(100); clf
    subplot 211; 
    plot(y);  xlabel('sample'); title('downsampled');
    subplot 212;
    plot(yy ./ (yy+y.^2)); xlabel('sample'); title(['proportion power lost (overall: ',num2str(mean(yy(:)/(mean(yy(:))+mean(y(:).^2)))), ')']); 
    ylim([0 1.1]);
    if size(x,2)>1;
        hold on; plot(mean(yy ./ (yy+y.^2),2), ':k','linewidth', 2);
        figure(101); clf;
        plot(mean(yy(:,:)./(mean(yy(:,:))+mean(y(:,:).^2))), '.-k')
        xlabel('channel'); title('proportion power lost per channel');
    end
    return
end


[m,n]=size(x);
a=floor(m/dsr);
x=x(1:a*dsr,:);
x=reshape(x,[dsr,a,n]);
y=mean(x,1);

if nargout>=2
    yy=mean(bsxfun(@minus,x,y).^2,1);
    yy=shiftdim(yy,1);
end
if nargout==3
    yyy=reshape(bsxfun(@minus,x,y),[m,n]);
end
    
y=shiftdim(y,1);


