frqTicks = 3:10:numel(n.freqs);
frqDisp = string(round(n.freqs(frqTicks)));

scM = ss.ms{42,1};

idx = scM.cond=="other";

figure('Position',[0 0 640 640],'color','white','ToolBar','none');
imagesc(scM.x(idx,:)','XData',scM.latency(idx,:)');
yticks(frqTicks); yticklabels(""); xticklabels("");
set(gca,'FontSize',12,'YDir','normal','color',[1 1 1]);
colormap(flip(cbrewer2('RdBu'))); clim([-4 4]);

hold on
plot([0 0],ylim,'k-','LineWidth',2);
plot(xlim,[20 20],'k-','LineWidth',2); % Theta
plot(xlim,[30 30],'k-','LineWidth',2); % alpha
plot(xlim,[40 40],'k-','LineWidth',2); % beta
plot(xlim,[50 50],'k-','LineWidth',2); % gamma
plot(xlim,[60 60],'k-','LineWidth',2); % hfb
hold off



