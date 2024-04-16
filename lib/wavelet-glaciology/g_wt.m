function varargout=g_wt(d,varargin)
%% Continous Wavelet Transform
% Creates a figure of wavelet power in units of
% normalized variance.
%
% USAGE: [wave,period,scale,coi,sig95]=wt(d[,params])
%
% d: a time series
% wave: the wavelet transform of d
% period: a vector of "Fourier" periods associated with wave
% scale: a vector of wavelet scales associated with wave
% coi: the cone of influence
%
% Settings: Pad: pad the time series with zeros?
% .         Dj: Octaves per scale (default: '1/12')
% .         S0: Minimum scale
% .         J1: Total number of scales
% .         Mother: Mother wavelet (default 'morlet')
% .         MaxScale: An easier way of specifying J1
% .         MakeFigure: Make a figure or simply return the output.
% .         BlackandWhite: Create black and white figures
% .         AR1: the ar1 coefficient of the series
% .              (default='auto' using a naive ar1 estimator. See ar1nv.m)
%
% Settings can also be specified using abbreviations. e.g. ms=MaxScale.
% For detailed help on some parameters type help wavelet.
%
%
% Example:
%      wt([0:200;sin(0:200)],'dj',1/20,'bw','maxscale',32)
%
% (C) Aslak Grinsted 2002-2014
%
% http://www.glaciology.net/wavelet-coherence

% -------------------------------------------------------------------------
%The MIT License (MIT)
%
%Copyright (c) 2014 Aslak Grinsted
%
%Permission is hereby granted, free of charge, to any person obtaining a copy
%of this software and associated documentation files (the "Software"), to deal
%in the Software without restriction, including without limitation the rights
%to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%copies of the Software, and to permit persons to whom the Software is
%furnished to do so, subject to the following conditions:
%
%The above copyright notice and this permission notice shall be included in
%all copies or substantial portions of the Software.
%
%THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
%THE SOFTWARE.
%---------------------------------------------------------------------------


% ------validate and reformat timeseries.
[d,dt]=formatts(d);

n=size(d,1);
sigma2=var(d(:,2));

%----------default arguments for the wavelet transform-----------
Args=struct('Pad',1,...      % pad the time series with zeroes (recommended)
    'Dj',1/12, ...    % this will do 12 sub-octaves per octave
    'S0',2*dt,...    % this says start at a scale of 2 years
    'J1',[],...
    'Mother','Morlet', ...
    'MaxScale',[],...   %a more simple way to specify J1
    'MakeFigure',(nargout==0),...
    'AR1','auto');
Args=parseArgs(varargin,Args,{'BlackandWhite'});
if isempty(Args.J1)
    if isempty(Args.MaxScale)
        Args.MaxScale=(n*.17)*2*dt; %automaxscale
    end
    Args.J1=round(log2(Args.MaxScale/Args.S0)/Args.Dj);
end

if strcmpi(Args.AR1,'auto')
    Args.AR1=ar1nv(d(:,2));

    if any(isnan(Args.AR1))
        error('Automatic AR1 estimation failed. Specify it manually (use arcov or arburg).')
    end
end



%----------------::::::::---------- Analyze: ---------:::::::::::::-----------------


[wave,period,scale,coi] = wavelet(d(:,2),dt,Args.Pad,Args.Dj,Args.S0,Args.J1,Args.Mother);

t=d(:,1);
power = (abs(wave)).^2 ;        % compute wavelet power spectrum
signif = wave_signif(1.0,dt,scale,0,Args.AR1,-1,-1,Args.Mother);
sig95 = (signif')*(ones(1,n));  % expand signif --> (J+1)x(N) array
sig95 = power ./ (sigma2*sig95);
Yticks = 2.^(fix(log2(min(period))):fix(log2(max(period))));

if Args.MakeFigure
    H=imagesc(t,log2(period),log2(abs(power/sigma2)));%#ok,log2(levels));  %*** or use 'contourfill'
    %logpow=log2(abs(power/sigma2));
    %[c,H]=contourf(t,log2(period),logpow,[min(logpow(:)):.25:max(logpow(:))]);
    %set(H,'linestyle','none')

    clim=get(gca,'clim'); %center color limits around log2(1)=0
    clim=[-1 1]*max(clim(2),3);
    set(gca,'clim',clim)

    HCB=colorbar;
    set(HCB,'ytick',-7:7);
    barylbls=rats(2.^(get(HCB,'ytick')'));
    barylbls([1 end],:)=' ';
    barylbls(:,all(barylbls==' ',1))=[];
    set(HCB,'yticklabel',barylbls);


    set(gca,'YLim',log2([min(period),max(period)]), ...
        'YDir','reverse', ...
        'YTick',log2(Yticks(:)), ...
        'YTickLabel',num2str(Yticks'), ...
        'layer','top')
    %xlabel('Time')
    ylabel('Period')
    hold on



    [c,h] = contour(t,log2(period),sig95,[1 1],'k'); %#ok
    set(h,'linewidth',2)
    %plot(t,log2(coi),'k','linewidth',3)
    tt=[t([1 1])-dt*.5;t;t([end end])+dt*.5];
    hcoi=fill(tt,log2([period([end 1]) coi period([1 end])]),'w');
    set(hcoi,'alphadatamapping','direct','facealpha',.5)

    hold off
    set(gca,'box','on','layer','top');
end
varargout={wave,period,scale,coi,sig95};
varargout=varargout(1:nargout);
