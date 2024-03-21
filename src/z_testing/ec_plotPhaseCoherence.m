frqticks = 1:10:99;

y = psy;
y.wcoh(:,1:99) = nan;
y.wcs(:,1:99) = nan;

for r = [5 6]
    idx = y.idx(y.run==r);
    [wcoh,wcs,f] = wcoherence(x(idx,74),x(idx,61),fsOg,FrequencyLimits=fLims,...
        VoicesPerOctave=fVoices);
    y.wcoh(idx,:) = wcoh';
    y.wcs(idx,:) = angle(wcs)';
end

y = y(y.trialA~=0 & y.frame>=-200 & y.frame<=3000,:);

z = grpstats(y,["cond" "frame"],"mean",DataVars="wcoh");
z = renamevars(z,"mean_wcoh","wcoh");
tmp = grpstats(y,["cond" "frame"],@(x) ec_angleMean(x),DataVars="wcs");
z.wcs = tmp.Fun1_wcs;

tmp = z(z.cond=="autobio",:);

figure;
imagesc(tmp.wcoh',XData=tmp.frame');
clim([0 1]);
yticks(frqticks); yticklabels(string(round(f(frqticks))));

%%
idx = psy.idx(psy.trialA==66);
wcoherence(xr(idx,74),xr(idx,61),fsOg,FrequencyLimits=fLims,...
        VoicesPerOctave=fVoices)


%%
function plotcoherenceperiod(wcoh,wcs,period,t,coitmp,nVoices,mc,plotstring)

minPeriod = min(period);
maxPeriod = max(period);

switch plotstring
    case 'years'
        Yticks = 2.^(round(log2(minPeriod)):round(log2(maxPeriod)));
        logYticks = log2(Yticks(:));
        YtickLabels = num2str(sprintf('%g\n',Yticks));
    case 'days'
        Yticks = 2.^(round(log2(minPeriod)):round(log2(maxPeriod)));
        logYticks = log2(Yticks(:));
        YtickLabels = num2str(sprintf('%g\n',Yticks));
    case 'hours'
        Yticks = 2.^(round(log2(minPeriod)):round(log2(maxPeriod)));
        logYticks = log2(Yticks(:));
        YtickLabels = num2str(sprintf('%g\n',Yticks));
    case 'minutes'
        Yticks = 2.^(round(log2(minPeriod),1):round(log2(maxPeriod),1));
        logYticks = log2(Yticks(:));
        YtickLabels = num2str(sprintf('%g\n',Yticks));
    case 'seconds'
        Yticks = 2.^(round(log2(minPeriod),2):round(log2(maxPeriod),2));
        logYticks = log2(Yticks(:));
        YtickLabels = num2str(sprintf('%g\n',Yticks));
end
%
AX = newplot;
f = ancestor(AX,'figure');
setappdata(AX,'evstruct',[]);
cla(AX,'reset');
imagesc(t,log2(period),wcoh);

AX.CLim = [0 1];
AX.YLim = log2([minPeriod, maxPeriod]);
AX.YTick = logYticks;
AX.YDir = 'normal';
set(AX,'YLim',log2([minPeriod,maxPeriod]), ...
    'layer','top', ...
    'YTick',logYticks, ...
    'YTickLabel',YtickLabels, ...
    'layer','top');
ylabel([getString(message('Wavelet:wcoherence:Period')) ' (' plotstring ') ']);
xlabel([getString(message('Wavelet:wcoherence:Time'))  ' (' plotstring ')']);
title(getString(message('Wavelet:wcoherence:CoherenceTitle')));
hold(AX,'on');
hcol = colorbar;
hcol.Label.String = 'Magnitude-Squared Coherence';

plot(AX,t,log2(coitmp),'w--','linewidth',2);
theta = angle(wcs);
theta(wcoh< mc) = NaN;
if all(isnan(theta))
    return;
end

% Create mesh grid for phase plot
tspace = ceil(size(theta,2)/40);
pspace = round(2^log2(size(theta,1)/nVoices/2));
tax = t(1:tspace:size(theta,2));
pax = period(1:pspace:size(theta,1));
plotPhaseVectors(AX,theta,tax,pax,tspace,pspace);
hzoom = zoom(f);
cbzoom = @(~,evd)zoomArrows(evd,theta,tax,pax,tspace,pspace);
cbfig = @(hobject,evd)ResizeFig(hobject,evd,theta,tax,pax,tspace,pspace);
evstruct.sclistener = event.listener(f,'SizeChanged',cbfig);
evstruct.ylimlistener = event.proplistener(AX,AX.findprop('YLim'),...
    'PostSet',cbfig);
evstruct.xlimlistener = event.proplistener(AX,AX.findprop('XLim'),...
    'PostSet',cbfig);
setappdata(AX,'evstruct',evstruct);
set(hzoom,'ActionPostCallback',cbzoom);
% Set NextPlot property to 'replace'
f.NextPlot = 'replace';
end


%%
function plotPhaseVectors(axhandle,theta,tax,pax,tspace,pspace)
if ~isempty(findobj(axhandle,'type','patch'))
    delete(findobj(axhandle, 'type', 'patch'));
end

[tgrid,pgrid]=meshgrid(tax,log2(pax));
theta = theta(1:pspace:size(theta,1),1:tspace:size(theta,2));

idx = find(~any(isnan([tgrid(:) pgrid(:) theta(:)]),2));

tgrid = tgrid(idx);
pgrid = pgrid(idx);
theta = theta(idx);

% Determine extent of phase arrows in plot
[dx,dy] = determinearrowextent(axhandle);
%

% Create the arrow patch object for plotting the phase
arrowpatch = [-1 0 0 1 0 0 -1; 0.1 0.1 0.5 0 -0.5 -0.1 -0.1]';

for ii=numel(tgrid):-1:1
    % Multiply each arrow by the rotation matrix for the given theta
    rotarrow = arrowpatch*[cos(theta(ii)) sin(theta(ii));...
        -sin(theta(ii)) cos(theta(ii))];
    patch(tgrid(ii)+rotarrow(:,1)*dx,pgrid(ii)+rotarrow(:,2)*dy,[0 0 0],...
        'edgecolor','none' ,'Parent',axhandle);
end
end
%--------------------------------------------------------------------------

function [dx,dy] = determinearrowextent(axhandle)
% Get the data aspect ratio of the y and x axis
dataaspectratio = get(axhandle,'DataAspectRatio');
axesposition = get(axhandle,'position');
widthheight = axesposition(3:4);
ar = widthheight./dataaspectratio(1:2);

ar(2)=ar(1)/ar(2);
ar(1)=1;

xlim = axhandle.XLim;
dxlim = xlim(2)-xlim(1);

dx=ar(1).*0.02*dxlim;
dy=ar(2).*0.02*dxlim;
end