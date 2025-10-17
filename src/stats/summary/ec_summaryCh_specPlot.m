% Run spec plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ec_summaryCh_specPlot(o,ss,xe,xhe,fAvg,B,trialNfo)
% o.oP.visible=1; o.oP.save=0; o.oP.doGPU=0;

% Load
[ns,chNfo] = ec_loadSbj(o.dirs,sfx=o.sfx+"s",vars=["n" "chNfo"]);
sbjID = ns.sbjID;

% Load summary stats
if ~exist("ss","var")
    fn = o.dirOut+"s"+sbjID+"_"+o.name+".mat";
    load(fn,"ss"); disp("LOADED: "+fn);
end

% Load plot data
if ~exist("xe","var")
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    load(fn,"xe","xhe","fAvg","B","trialNfo"); disp("LOADED: "+fn);
end
try mkdir(o.dirOutSbj); catch;end

%% Get plot options & electrode plotting data
[o,d,xNfo,nChs,icWts] = mk_oP_chDat(o,ns,chNfo,trialNfo);

%% Parfor loop across channels/ICs
try parpool('Processes'); catch; end
parfor ch = 1:nChs
    % Load channel/IC info
    dCh = d;
    if o.ICA; dCh.wts(dCh.ica) = icWts(ch,:); end 

    % Load EEG stats/recordings
    xN = xNfo(ch,:);
    sc = ss(ch,:);
    fCh = squeeze(fAvg(:,ch,:));
    vars = string(sc.Properties.VariableNames);
    if any(vars=="ms"); sc.ms{1}.latency = sc.ms{1}.bin2; end
    if any(vars=="RT"); sc.RT{1}.latency = sc.RT{1}.binRT2; end
    if any(vars=="pct"); sc.pct{1}.latency = sc.pct{1}.pct2; end
    xCh = squeeze(xe(:,ch,:));
    xhCh = squeeze(xhe(:,ch,:));

    %% Plot function
    spec_plotChan(o,sc,xCh,xhCh,dCh,fCh,trialNfo,B,xN);
end

%% Delete plot data
if ~o.test
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    delete(fn(:)); disp("DELETED: "+fn);
end
end



%% Main within-ch plot subfunction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function spec_plotChan(o,sc,xCh,xhCh,dCh,fCh,trialNfo,B,xN)
%warning('off','MATLAB:handle_graphics:Layout:NoPositionSetInTiledChartLayout');

% Channel plot data
[dCh,hemN,ch,sbjCh] = getElecPlotData_lfn(o,dCh,xN);

%
conds = o.conds;
nConds = numel(conds);
oP = o.oP;

%% Initialize figure
h = figure('Position',[0 0 1920 1080],'Theme','light','color','white','MenuBar','none','ToolBar','none');
%h = figure('Position',[0 0 1920 1080],'Theme','light','color','white','Visible','off');
hl = tiledlayout(h,5,8,'TileSpacing','tight','Padding','tight');

%% Legends
nexttile;
if o.ICA % Chan name
    text(1,1,sbjCh+" ("+xN.order+")",Interpreter='none',Units='normalized',FontSize=20,...
        HorizontalAlignment='right',VerticalAlignment='top');
else
    text(1,1,sbjCh,Interpreter='none',Units='normalized',FontSize=20,...
        HorizontalAlignment='right',VerticalAlignment='top');
end

% Conditions
hold on
for c = 1:nConds
    plot(0,0,'o','Color',oP.col(c,:),'LineWidth',8);
end
lgd = legend(conds,"FontSize",oP.textsize+4,"Location","southeast","AutoUpdate","off");
title(lgd,"Condition"); axis off; hold off;

% Z-score colorbar
colormap(oP.cmap); clim(oP.clim);
lgd = colorbar(gca,"west","FontSize",oP.textsize+2); lgd.Label.String = "z-score";

%% Total average spectral magnitude
frqTicks = 3:10:numel(o.freqs);
frqDisp = string(round(o.freqs(frqTicks)));
nexttile; hold on
for c = 1:nConds
    plot(squeeze(fCh(c,:)),'LineWidth',2,'Color',oP.col(c,:));
end
hold off
xticks(frqTicks); xticklabels(frqDisp); xlim([1 numel(o.freqs)])
set(gca,'Fontsize',oP.textsize); ylabel("Magnitude");
title("Spectrum (1-300Hz)","FontSize",oP.textsize+2);

%% LFP single-trial
for c = 1:nConds
    nexttile;
    plotSingleTrials_lfn(xCh(:,trialNfo.cond==conds(c))',o.lats5,oP.textsize);
    clim(oP.clim);
    title(conds(c)+" trials: LFP","FontSize",oP.textsize+2)
    if c==1; xlabel("Latency (ms)"); ylabel("Trials by RT"); end
end

%% Plot lateral electrodes on native cortex
plotElecs_lfn(o,hl,hemN,dCh,ch,"lateral")

%% HFB single-trial
for c = 1:nConds
    nexttile;
    plotSingleTrials_lfn(xhCh(:,trialNfo.cond==conds(c))',o.lats5,oP.textsize);
    clim(oP.clim);
    title(conds(c)+" trials: "+B.disp(B.name=="hfb"),"FontSize",oP.textsize+2);
    if c==1; xlabel("Latency (ms)"); ylabel("Trials by RT"); end
end

%% Plot medial electrodes on native cortex
plotElecs_lfn(o,hl,hemN,dCh,ch,"medial")

%% ERSP
scM = sc.ms{:};
for c = 1:nConds
    nexttile
    idx = ismember(scM.cond,conds(c)); % & sc.latency>=-200 & sc.latency<=5000;
    imagesc(scM.x(idx,:)','XData',scM.latency(idx,:)');
    yticks(frqTicks); yticklabels(frqDisp);
    set(gca,'FontSize',oP.textsize,'YDir','normal','color',[1 1 1]);
    colormap(flip(cbrewer2('RdBu'))); clim(oP.clim);
    title(conds(c)+": ERSP","FontSize",oP.textsize+2);
    if c==1; xlabel("Latency (ms)"); ylabel("Frequency (Hz)"); end
end

%% Stim-locked avg
for c = 1:height(B)
    nexttile;
    plotFrameAvg_lfn(sc.ms{1},B.name(c),conds,oP);
    set(gca,'FontSize',oP.textsize);
    title("Stim latency:  "+B.disp(c),'FontSize',oP.textsize+2);
    if c==1; xlabel("Latency (ms)"); ylabel("z-score"); end
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off
end

%% RT-locked avg
for c = 1:height(B)
    nexttile;
    plotFrameAvg_lfn(sc.RT{1},B.name(c),conds,oP);
    set(gca,'FontSize',oP.textsize);
    title("RT latency:  "+B.disp(c),'FontSize',oP.textsize+2);
    if c==1; xlabel("RT - Latency (ms)"); ylabel("z-score"); end
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off
end

%% Save fig
fn = o.dirOutSbj+sbjCh+"_spec.jpg";
%exportgraphics(hl,fn,"Resolution",150);
print(h,fn,"-djpeg","-r150");
disp("SAVED: "+fn);
close all; % IMPORTANT I guess
end



%% Plot Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make plot options & channel plotting data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [o,d,xNfo,nChs,icWts] = mk_oP_chDat(o,n,chNfo,trialNfo)

o.conds = string(unique(trialNfo.cond));
o.freqs = n.freqs;

% Add to plot options
if nnz(chNfo.ECoG)/height(chNfo) > 0.75
    o.oP.alpha = 0.95;
else
    o.oP.alpha = 0.25;
end
% o.oP.lats = int16(floor(1000*(o.stats.epoch(1):o.epoch.bin2:o.stats.epoch(2))))';
% o.oP.lats5 = int16(floor(1000*(o.stats.epoch(1):o.epoch.bin2:5)))';
% o.oP.latsRT = int16(floor(1000*(o.stats.epochRT(1):o.epoch.bin2:o.stats.epochRT(2))))';
% o.oP.dirOutSbj = o.dirOutSbj;
% o.oP.dirFS = o.dirFS;

% Make ch plotting data table
d = table;
d.label = chNfo.sbjCh;
d = [d,chNfo(:,1:12)];
d.line(:) = "o";
d.line(~d.ECoG) = "s";
d.sz(:) = 2;
d.bSz(:) = 1;
d.col(:,1:3) = 0;
d.bCol(:,1:3) = 0;
% d.MNI = chNfo.MNI;
% d.pialRAS = chNfo.pialRAS;
d.pos = chNfo.pialRAS;
d.order(:) = nan;
if o.ICA
    if o.sfx=="i"; sfx1=""; else; sfx1="_"+o.sfx; end
    d.ica = chNfo.("ica"+sfx1);
    d.wts(:) = nan;
    d.sz(~d.ica) = 2;
    d.sz(d.ica) = 10;
end

% Get IC/chan info
nChs = n.xChs;
if o.ICA
    nChs = n.nICs;
    xNfo = n.icNfo;
    icWts = zscore(n.ica.winv',1,'all');
else
    xNfo = chNfo;
    icWts = zeros(nChs,1);
end
end


% Get electrode plot data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dCh,hemN,ch,sbjCh] = getElecPlotData_lfn(o,dCh,xN)
if o.ICA
    % Color by ICA weights
    %dCh.wts = normalize(dCh.wts,"range",oP.climICA);
    [dCh.col,~,~,dCh.order] =...
        ec_colorbarFromValues(dCh.wts,'RdBu',o.oP.climICA,zscore=o.oP.climICA_z);
    ch = xN.ic;
    sbjCh = xN.sbjIC;
    dCh.sz(ch)=13; dCh.bSz(ch)=2; dCh.bCol(ch,:)=[0 .8 0];
    dCh.col(dCh.order==-Inf,1:3) = 0;
    hemN = [nnz(dCh.hem=="L") nnz(dCh.hem=="R")];
    dCh.order = abs(dCh.order-0.5);
    dCh.order(dCh.order==Inf) = -Inf;
else
    ch = xN.ch;
    sbjCh = xN.sbjCh;
    dCh.sz(ch) = 12;
    dCh.col(ch,1:3) = [1,0,0];
    hemN = [nnz(xN.hem=="L") nnz(xN.hem=="R")];
    dCh.order = dCh.ch;
    dCh.order(ch) = Inf;
end
dCh(ismember(dCh.pos(:,1),[0 nan]),:) = [];
dCh = sortrows(dCh,'order','ascend');
end


% Plot electrodes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotElecs_lfn(o,hl,hemN,dCh,ch,medial) 
%if a.type=="hfb"; span=5; else; span=[1 2]; end
span = [1 2];

% Hemisphere
hem = dCh.hem(dCh.ch==ch);
if ~ismember(hem,["L" "R"]) % If no hemisphere
    hem = [dCh.hem=="L" dCh.hem=="R"];
    if hem(2)>hem(1)
        hem = "R";
    else
        hem = "L";
    end
end

%% Plot lateral electrodes on native cortex
if ismember(medial,["lateral" ""])
    if nnz(hemN)>1
        % Left
        plotCortex_lfn(nexttile(hl),dCh(ismember(dCh.lat,["lateral" "both"]) &...
            dCh.hem~="R",:),"latero-anterior","pial",o,hem);

        % Right
        plotCortex_lfn(nexttile(hl),dCh(ismember(dCh.lat,["lateral" "both"]) &...
            dCh.hem~="L",:),"latero-anterior","pial",o,hem);
    else
        plotCortex_lfn(nexttile(hl,span),dCh(ismember(dCh.lat,["lateral" "both"]),:),...
            "lateral","pial",o,hem);
    end
end

%% Plot medial electrodes on native cortex
%if a.type=="hfb"; span=9; end
if ismember(medial,["medial" ""])
    if nnz(hemN)>1
        % Left
        plotCortex_lfn(nexttile(hl),dCh(ismember(dCh.lat,["medial" "both"]) &...
            dCh.hem~="R",:),"medio-posterior","pial",o,hem);

        % Right
        plotCortex_lfn(nexttile(hl),dCh(ismember(dCh.lat,["medial" "both"]) &...
            dCh.hem~="L",:),"medio-posterior","pial",o,hem);
    else
        plotCortex_lfn(nexttile(hl,span),dCh(ismember(dCh.lat,["medial" "both"]),:),...
            "medial","pial",o,hem);
    end
end
end


% Plot cortex %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotCortex_lfn(h,dCh,lat,surf,o,hem)
ec_plotCortex(hem,lat,dCh,sbj=o.dirs.sbj,sbjDir=o.dirFS,surfType=surf,...
    visible=o.oP.visible,opacity=o.oP.alpha,doGPU=o.oP.doGPU,h=h,...
    save=0,flip=0,pullF=15,parallel=0);
end


% Plot timecourses per trial %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotSingleTrials_lfn(dat,lats5,fontSz)
imagesc(dat,'XData',lats5,'AlphaData',~isnan(dat));
set(gca,'YTick',(1:width(dat))-0.5,'YTickLabel','','FontSize',fontSz,...
    'YTickLabelRotation',90,'TickDir','out','Color',[0 0 0]);
colormap(flip(cbrewer2('RdBu')));
end


% Plot averaged timecourses %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotFrameAvg_lfn(dat,band,conds,oP)
nConds = numel(conds);
lats = unique(dat.latency)';
lats = repmat(lats,nConds,1);
y = nan(nConds,length(lats));
ySE = y;
%ySig = y;
for c = 1:nConds
    cond = conds(c);
    idxP = ismember(dat.latency,lats(c,:)) & dat.cond==cond;
    idx = ismember(lats(c,:),dat.latency(idxP));
    y(c,idx) = dat.(band)(idxP)';
    ySE(c,idx) = dat.("SE_"+band)(idxP)';
end
mseb(lats,y,ySE,oP.o1D,1); axis tight
set(gca,'fontsize',oP.textsize);
end


% % Plot averaged timecourses per condition %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function plotCondAvg_lfn(B,sc,oP)
% for c = 1:height(B)
%     % Stim-locked
%     nexttile;
%     plotFrameAvg_lfn(sc.ms{1},B.name(c),oP);
%     set(gca,'FontSize',oP.textsize);
%     title("Stim latency:  "+B.disp(c),'FontSize',oP.textsize);
%     xlabel("Latency (ms)",'FontSize',oP.textsize);
%     if c==1; ylabel("Magnitude (z)",'FontSize',oP.textsize);  end
%     hold on
%     plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
%     plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
%     hold off
% 
%     % RT-locked
%     nexttile;
%     plotFrameAvg_lfn(sc.RT{1},B.name(c),oP);
%     set(gca,'FontSize',oP.textsize);
%     title("RT latency:  "+B.disp(c),'FontSize',oP.textsize);
%     xlabel("RT - Latency (ms)",'FontSize',oP.textsize);
%     hold on
%     plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
%     plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
%     hold off
% 
%     % Percent RT
%     nexttile;
%     plotFrameAvg_lfn(sc.pct{1},B.name(c),oP);
%     set(gca,'FontSize',oP.textsize);
%     title("RT percent:  "+B.disp(c),'FontSize',oP.textsize);
%     xlabel("Latency/RT (%)",'FontSize',oP.textsize);
%     hold on
%     plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
%     plot([100 100],ylim,'k-','LineWidth',oP.o1D.width);
%     plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
%     hold off
% end
% end