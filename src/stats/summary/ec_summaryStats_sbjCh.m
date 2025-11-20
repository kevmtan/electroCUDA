function ec_summaryStats_sbjCh(sbj,proj,task,o,a)
arguments
    sbj string
    proj string
    task string
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    a.type string = "spec"
    a.ICA logical = false
    a.sfx string = ""
    a.stats logical = false
    a.plot logical = false
    a.test logical = false
    a.dbstop logical = false
end
if a.test
    disp("TESTING sumStats: "+sbj);
    dbstop if error
end

%%
% a.type="spec"; a.ICA=1; a.test=1; a.stats=1; a.plot=0; a.sfx="i";
if contains(a.sfx,"i"); a.ICA = true; end
if a.ICA && ~contains(a.sfx,"i"); a.sfx = a.sfx + "i"; end
dirs = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=a.sfx);
o.dirIn = dirs.procSbj; %
o.dirFS = dirs.fsSbj; % Freesurfer subjects dir
o.dirOut = dirs.anal+"summary/"+o.name+"/";
o.dirOutSbj = dirs.anal+"summary/"+o.name+"/s"+dirs.sbjID+"/";

%% Calculate summary stats
if a.stats
    % try parpool('Threads'); catch; end
    if a.type=="spec"
        spec_runStats(a,o,dirs);
    elseif a.type=="hfb-lfp"
        hfbL_runStats(a,o,dirs);
    elseif a.type=="hfb"
        hfb_runStats(a,o,dirs);
    end
end

%% Make plots
if ~a.stats && a.plot
    try parpool('Processes'); catch; end
    if a.type=="spec"
        spec_runPlots(a,o,dirs);
    elseif a.type=="hfb-lfp"
        hfbL_runPlots(a,o,dirs);
    elseif a.type=="hfb"
        hfb_runPlots(a,o,dirs);
    end
end
end




%% Main functions for spec (spectrum & LFP) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run spec stats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function spec_runStats(a,o,dirs)
% Load
tic;
[ns,xs,psy,trialNfo,chNfo] =...
    ec_loadSbj(dirs,sfx=a.sfx+"s",vars=["n" "x" "psy" "trialNfo" "chNfo"]);
if a.test; xs1=xs; trialNfoOg=trialNfo; x_bad=ns.xBad; end %#ok<NASGU>
toc;

%% Initialize
sbj = ns.sbj;
sbjID = ns.sbjID;
conds = o.conds;
sbjChs = chNfo.sbjCh;
nChs = ns.xChs;
nTrs = ns.nTrials;
nBands = numel(o.bands);
trialNfo.condC = categorical(trialNfo.cond,conds);
if a.ICA
    nChs = ns.nICs;
    icNfo = ns.icNfo;
    sbjChs = icNfo.sbjIC;
end
% Target sampling rate
if ~isany(o.pre.hzTarget) || ns.hz<o.pre.hzTarget
    o.pre.hzTarget = ns.hz;
end

% Band indices
B = table;
B.name = o.bands';
B.disp = o.bands2';
B.freqs(:) = {[]};
for i = 1:nBands
    B.id(i,:) = (ns.freqs>o.bandsF(i,1) & ns.freqs<=o.bandsF(i,2))';
    B.freqs{i} = ns.freqs(B.id(i,:));
end
B.Properties.RowNames = B.name;

%% Get mean evoked magnitude per freq & cond
fAvg = nan(numel(conds),nChs,numel(ns.freqs),"like",xs);
for c = 1:numel(conds)
    idx = psy.stim & psy.cond==conds(c);
    fAvg(c,:,:) = mean(xs(idx,:,:),1,"omitnan");
end
disp("Calculated mean evoked magnitude per freq & cond: "+sbj); toc;

%% Analysis template
oo = namedargs2cell(o.epoch);
[ep,trialNfo] = ec_epochPsy(psy,trialNfo,ns,oo{:},conds=o.conds,conds2=o.conds2); toc
if ~a.test; ep.time=[]; end

%% Baseline correction, filtering, downsampling
oo = namedargs2cell(o.pre);
xs = ec_epochBaseline(xs,ns,psy,ep,oo{:}); toc % ADD DOWNSAMPLING

%% Spec: summary stats
ss = statsSpec_lfn(xs,ns,sbjChs,ep,B,o); toc

%% LFP: load & initialize
[n,x,psy1] = ec_loadSbj(dirs,sfx=a.sfx,vars=["n" "x" "psy"]);
if a.test; x1=x; end %#ok<NASGU>
x = single(x);
n.suffix = a.sfx;

%% LFP: denoise, downsample & baseline correction
oo = namedargs2cell(o.pre);
x = ec_epochBaseline(x,n,psy1,ep,oo{:}); toc
if ~a.test; clear n; clear psy1; clear trialNfo1; end

%% LFP: summary stats
ss = statsBand_lfn(x,ns,sbjChs,ep,"lfp",o,ss); toc;

%% Organize data for plotting
lats5 = int16(1000 * (o.stats.epoch(1):o.epoch.bin2:5))';
nLats = numel(lats5);
trialNfo.RT1 = int32(trialNfo.RT*1000);

% Slice full timecourses for plotting
xe = nan(nLats,nChs,nTrs,"like",x);
xhe = nan(nLats,nChs,nTrs,"like",x);
for t = 1:nTrs
    idx = ep.idx(ep.trialA==trialNfo.trialA(t));
    idx = idx(ismember(ep.bin2(idx),lats5));
    idx = idx(ep.iPsy(idx)<=trialNfo.idxEnd(t));
    [~,ia,ib] = intersect(lats5,ep.bin2(idx),'stable');
    xe(ia,:,t) = x(idx(ib),:);
    xhe(ia,:,t) = mean(xs(idx(ib),:,B.id("hfb",:)),3,'omitnan');
end
trialNfo.RT1(~trialNfo.RT1) = trialNfo.trialA(~trialNfo.RT1);

[trialNfo,idx] = sortrows(trialNfo,["condC" "RT1" "trialA"]);
xe = xe(:,:,idx);
xhe = xhe(:,:,idx);
disp("Finished plotting prep: "+sbj);

%% Save summary stats
if ~a.test; clear x xh nh ep; end
if ~isfolder(o.dirOut); mkdir(o.dirOut); end
if ~isfolder(o.dirOutSbj); mkdir(o.dirOutSbj); end
try parfevalOnAll(@gpuDevice,0,[]); catch;end
try reset(gpuDevice(1)); catch;end

if o.save
    if a.ICA; fn=o.dirOut+"s"+sbjID+"_icSumStats_"+o.name+".mat";
    else; fn=o.dirOut+"s"+sbjID+"_chSumStats_"+o.name+".mat"; end
    save(fn,'ss','-v7');
    disp("SAVED: "+fn);
end

%% Initialize plotting
if ~a.plot
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    savefast(fn,'xe','xhe','fAvg','B','trialNfo');
    disp("SAVED: "+fn);
else
    %%
    spec_runPlots(a,o,dirs,ss,xe,xhe,fAvg,B,trialNfo);
end
end



% Run spec plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function spec_runPlots(a,o,dirs,ss,xe,xhe,fAvg,B,trialNfo)
% Load
[ns,chNfo] = ec_loadSbj(dirs,sfx=a.sfx+"s",vars=["n" "chNfo"]);
sbjID = ns.sbjID;
if nargin<=3
    if a.ICA; fn=o.dirOut+"s"+sbjID+"_icSumStats_"+o.name+".mat";
    else; fn=o.dirOut+"s"+sbjID+"_chSumStats_"+o.name+".mat"; end
    load(fn,"ss"); disp("LOADED: "+fn);

    fn = o.dirOut+"plot_s"+sbjID+".mat";
    load(fn,"xe","xhe","fAvg","B","trialNfo"); disp("LOADED: "+fn);
end

%% Prep
doICA = a.ICA;
sbj = ns.sbj;

% Get plot options & electrode plotting data
[d,oP,xNfo,nChs,icWts] = mk_oP_chDat(a,o,ns,B,chNfo,doICA);
oP.freqs = ns.freqs;
% oP.visible=1; oP.save=0; oP.doGPU=0;

%% Parfor loop across channels/ICs
try parpool('Processes'); catch; end
parfor ch = 1:nChs
    % Load channel/IC info
    dCh = d;
    if doICA; dCh.wts(dCh.ica) = icWts(ch,:); end

    % Load EEG stats/recordings
    xN = xNfo(ch,:);
    sc = ss(ch,:);
    fCh = squeeze(fAvg(:,ch,:));
    vars = string(sc.Properties.VariableNames);
    if any(vars=="ms"); sc.ms{1}.latency = sc.ms{1}.bin2; end
    if any(vars=="RT"); sc.RT{1}.latency = sc.RT{1}.binRT; end
    if any(vars=="pct"); sc.pct{1}.latency = sc.pct{1}.pct2; end
    xCh = squeeze(xe(:,ch,:));
    xhCh = squeeze(xhe(:,ch,:));

    %% Plot function
    spec_plotChan(a,sc,xCh,xhCh,dCh,fCh,trialNfo,B,oP,sbj,xN);
end

%% Delete plot data
if ~a.test
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    delete(fn(:)); disp("DELETED: "+fn);
end
end



% Plot spec chans/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function spec_plotChan(a,sc,xCh,xhCh,dCh,fCh,trialNfo,B,oP,sbj,xN)
warning('off','MATLAB:handle_graphics:Layout:NoPositionSetInTiledChartLayout');
nConds = numel(oP.conds);
conds = oP.conds;
conds2 = oP.conds2;
%lats = oP.lats;
lats5 = oP.lats5;

% Channel plot data
[dCh,sbjCh,hemN,a] = getElecPlotData_lfn(a,dCh,oP,xN);

%% Initialize figure
if ~oP.save
    h = figure('Position',[0 0 1920 1080],'color','white','MenuBar','none','ToolBar','none');
else
    h = figure('Position',[0 0 1920 1080],'color','white','MenuBar','none','ToolBar','none','Visible','off');
end
hl = tiledlayout(h,5,8,'TileSpacing','tight','Padding','tight');

%% Legends
nexttile;
if a.ICA % Chan name
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
lgd = legend(conds2,"FontSize",oP.textsize+4,"Location","southeast","AutoUpdate","off");
title(lgd,"Condition"); axis off; hold off;

% Z-score colorbar
colormap(oP.cmap); clim(oP.clim);
lgd = colorbar(gca,"west","FontSize",oP.textsize+2); lgd.Label.String = "z-score";

%% Total average spectral magnitude
frqTicks = 3:10:numel(oP.freqs);
frqDisp = string(round(oP.freqs(frqTicks)));
nexttile; hold on
for c = 1:nConds
    plot(squeeze(fCh(c,:)),'LineWidth',2,'Color',oP.col(c,:));
end
hold off
xticks(frqTicks); xticklabels(frqDisp); xlim([1 numel(oP.freqs)])
set(gca,'Fontsize',oP.textsize); ylabel("Magnitude");
title("Spectrum (1-300Hz)","FontSize",oP.textsize+2);

%% LFP single-trial
for c = 1:nConds
    nexttile;
    plotSingleTrials_lfn(xCh(:,trialNfo.cond==conds(c))',lats5, oP.textsize);
    clim(oP.clim);
    title(conds2(c)+" trials: LFP","FontSize",oP.textsize+2)
    if c==1; xlabel("Latency (ms)"); ylabel("Trials by RT"); end
end

%% Plot lateral electrodes on native cortex
plotElecs_lfn(a,hl,hemN,dCh,sbj,oP,"lateral")

%% HFB single-trial
for c = 1:nConds
    nexttile;
    plotSingleTrials_lfn(xhCh(:,trialNfo.cond==conds(c))',lats5, oP.textsize);
    clim(oP.clim);
    title(conds2(c)+" trials: "+B.disp(B.name=="hfb"),"FontSize",oP.textsize+2);
    if c==1; xlabel("Latency (ms)"); ylabel("Trials by RT"); end
end

%% Plot medial electrodes on native cortex
plotElecs_lfn(a,hl,hemN,dCh,sbj,oP,"medial")

%% ERSP
scM = sc.ms{:};
for c = 1:nConds
    nexttile
    idx = ismember(scM.cond,conds2(c)); % & sc.latency>=-200 & sc.latency<=5000;
    imagesc(scM.x(idx,:)','XData',scM.latency(idx,:)');
    yticks(frqTicks); yticklabels(frqDisp);
    set(gca,'FontSize',oP.textsize,'YDir','normal','color',[1 1 1]);
    colormap(flip(cbrewer2('RdBu'))); clim(oP.clim);
    title(conds2(c)+": ERSP","FontSize",oP.textsize+2);
    if c==1; xlabel("Latency (ms)"); ylabel("Frequency (Hz)"); end
end

%% Stim-locked avg
for c = 1:height(B)
    nexttile;
    plotFrameAvg_lfn(sc.ms{1},B.name(c),oP);
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
    plotFrameAvg_lfn(sc.RT{1},B.name(c),oP);
    set(gca,'FontSize',oP.textsize);
    title("RT latency:  "+B.disp(c),'FontSize',oP.textsize+2);
    if c==1; xlabel("RT - Latency (ms)"); ylabel("z-score"); end
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off
end

%% Save fig
if oP.save
    fn = oP.dirOutSbj+sbjCh+"_spec.jpg";
    exportgraphics(hl,fn,"Resolution",150);
    disp("SAVED: "+fn);
    close all
end
end




%% Main functions for for HFB-LFP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run HFB-LFP stats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function hfbL_runStats(a,o,dirs)
% Load
tic; if ~contains(a.sfx,"h"); sfx_h=a.sfx+"h"; else; sfx_h=a.sfx; end
[nh,xh,psy,trialNfo,chNfo] = ec_loadSbj(dirs,sfx_h); toc;
nh.suffix = sfx_h;
if a.ICA; nh.ICA=1; else; nh.ICA=0; end
if a.test; xh1=xh; trialNfoOg=trialNfo; x_bad=nh.badFrames; end %#ok<NASGU>

%% Initialize
sbj = nh.sbj;
sbjID = nh.sbjID;
conds = o.conds;
sbjChs = chNfo.sbjCh;
nChs = nh.xChs;
nTrs = nh.nTrials;

fs = nh.hz;
trialNfo.condC = categorical(trialNfo.cond,conds);
if a.ICA
    nChs = nh.nICs;
    icNfo = nh.icNfo;
    sbjChs = icNfo.sbjIC;
end
% Add sampling rate info to 'o' struct
if o.hzTarget>0; o.hzTarget=o.hzTarget; else; o.hzTarget=fs; end

% Band indices
B = table;
B.name = o.bands';
B.disp = o.bands2';
B.Properties.RowNames = B.name;
B = B(["hfb" "lfp"],:);

% % Get mean evoked magnitude per freq & cond
% fAvg = nan(numel(conds),nChs,numel(nh.freqs));
% for c = 1:numel(conds)
%     idx = psy.stim & psy.cond==conds(c);
%     fAvg(c,:,:) = squeeze(mean(xh(idx,:,:),1,'omitnan'));
%     %fAvg(c,:,:) = normalize(fAvg(c,:,:),3,'zscore','robust');
% end
% disp("Calculated mean evoked magnitude per freq & cond: "+sbj); toc;

%% Analysis template
oo = namedargs2cell(o.epoch);
[ep,trialNfo] = ec_epochPsy(psy,trialNfo,ns,oo{:},conds=o.conds,conds2=o.conds2); toc
if ~a.test; ep.time=[]; end

%% HFB: denoise & baseline correction
[xh,nh] = ec_baselineTrials(xh,nh,psy,anT,trialNfo,o); toc;
xh = single(xh);

%% HFB: summary stats
ss = statsBand_lfn(xh,nh,sbjChs,anT,"hfb",o); toc;

%% LFP: load & initialize
[n,x,psy1,trialNfo1] = ec_loadSbj(dirs,a.sfx);
n.suffix = a.sfx;
if a.ICA; n.ICA=1; else; n.ICA=0; end
if a.test; x1=x; end %#ok<NASGU>

%% LFP: denoise, downsample & baseline correction
x = ec_baselineTrials(x,n,psy1,anT,trialNfo1,o);
x = single(x);
if ~a.test; clear n; clear psy1; clear trialNfo1; end

%% LFP: summary stats
ss = statsBand_lfn(x,nh,sbjChs,anT,"lfp",o,ss); toc;

%% Organize data for plotting
lats5 = int16(1000 * (o.epoch(1):o.bin2:5))';
nLats = numel(lats5);
trialNfo.RT1 = int32(trialNfo.RT*1000);

% Slice full timecourses for plotting
xe = nan(nLats,nChs,nTrs,"like",x);
xhe = nan(nLats,nChs,nTrs,"like",x);
for t = 1:nTrs
    idx = anT.idx(anT.trialA==trialNfo.trialA(t));
    idx = idx(ismember(anT.bin2(idx),lats5));
    idx = idx(anT.iPsy(idx)<=trialNfo.idxEnd(t));
    [~,ia,ib] = intersect(lats5,anT.bin2(idx),'stable');
    xe(ia,:,t) = x(idx(ib),:);
    xhe(ia,:,t) = xh(idx(ib),:);
end
trialNfo.RT1(~trialNfo.RT1) = trialNfo.trialA(~trialNfo.RT1);

[trialNfo,idx] = sortrows(trialNfo,["condC" "RT1" "trialA"]);
xe = xe(:,:,idx);
xhe = xhe(:,:,idx);
disp("Finished plotting prep: "+sbj);

%% Save summary stats
if ~a.test; clear x xh nh anT; end
if ~isfolder(o.dirOut); mkdir(o.dirOut); end
if ~isfolder(o.dirOutSbj); mkdir(o.dirOutSbj); end
try parfevalOnAll(@gpuDevice,0,[]); catch;end
try reset(gpuDevice(1)); catch;end

if o.save
    if a.ICA; fn=o.dirOut+"s"+sbjID+"_icSumStats_"+o.name+".mat";
    else; fn=o.dirOut+"s"+sbjID+"_chSumStats_"+o.name+".mat"; end
    save(fn,'ss','-v7');
    disp("SAVED: "+fn);
end

%% Initialize plotting
if ~a.plot
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    savefast(fn,'xe','xhe','B','trialNfo');
    disp("SAVED: "+fn);
else
    try delete(gcp('nocreate')); catch; end
    hfbL_runPlots(a,o,dirs,ss,xe,xhe,B,trialNfo);
    try delete(gcp('nocreate')); catch; end
end
end


% Run HFB plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function hfbL_runPlots(a,o,dirs,ss,xe,xhe,B,trialNfo)
% Load
n = ec_loadSbj(dirs,a.sfx,"n");
sbjID = n.sbjID;
%fs = ns.hz; if o.hzTarget>0; fs=o.hzTarget; end
chNfo = ec_loadSbj(dirs,a.sfx,"chNfo");
if nargin<=3
    if a.ICA; fn=o.dirOut+"s"+sbjID+"_icSumStats_"+o.name+".mat";
    else; fn=o.dirOut+"s"+sbjID+"_chSumStats_"+o.name+".mat"; end
    load(fn,"ss"); disp("LOADED: "+fn);

    fn = o.dirOut+"plot_s"+sbjID+".mat";
    load(fn,"xe","xhe","B","trialNfo"); disp("LOADED: "+fn);
end

%% Prep
doICA = a.ICA;
sbj = n.sbj;

% Get plot options & electrode plotting data
[d,oP,xNfo,nChs,icWts] = mk_oP_chDat(a,o,n,B,chNfo,doICA);
% oP.visible=1; oP.save=0; oP.doGPU=0;

%% Parfor loop across channels/ICs
try parpool('Processes'); catch; end
parfor ch = 1:nChs
    % Load channel/IC info
    dCh = d;
    if doICA; dCh.wts(dCh.ica) = icWts(ch,:); end

    % Load EEG stats/recordings
    xN = xNfo(ch,:);
    sc = ss(ch,:);
    vars = string(sc.Properties.VariableNames);
    if any(vars=="ms"); sc.ms{1}.latency = sc.ms{1}.bin2; end
    if any(vars=="RT"); sc.RT{1}.latency = sc.RT{1}.binRT; end
    if any(vars=="pct"); sc.pct{1}.latency = sc.pct{1}.pct2; end
    xCh = squeeze(xe(:,ch,:));
    xhCh = squeeze(xhe(:,ch,:));

    %% Plot function
    hfbL_plotChan(a,sc,xCh,xhCh,dCh,trialNfo,oP,sbj,xN);
end

if ~a.test
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    delete(fn(:)); disp("DELETED: "+fn);
end
end


% Plot HFB chans/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function hfbL_plotChan(a,sc,xCh,xhCh,dCh,trialNfo,oP,sbj,xN)
warning('off','MATLAB:handle_graphics:Layout:NoPositionSetInTiledChartLayout');
nConds = numel(oP.conds);
conds = oP.conds;
conds2 = oP.conds2;
lats5 = oP.lats5;
B = oP.B;

% Channel plot data
[dCh,sbjCh,hemN,a] = getElecPlotData_lfn(a,dCh,oP,xN);

%% Initialize figure
if ~oP.save
    h = figure('Position',[0 0 1920 1080],'color','white','MenuBar','none','ToolBar','none');
else
    h = figure('Position',[0 0 1920 1080],'color','white','MenuBar','none','ToolBar','none','Visible','off');
end
hl = tiledlayout(h,4,6,'TileSpacing','compact','Padding','tight');

%% Channel name
nexttile;
if a.ICA
    text(.5,.5,sbjCh+" ("+xN.order+")",Interpreter='none',FontSize=20,Units='normalized',...
        HorizontalAlignment='center',VerticalAlignment='middle');
else
    text(.5,.5,sbjCh,Interpreter='none',FontSize=20,Units='normalized',...
        HorizontalAlignment='center',VerticalAlignment='middle');
end; axis off;

%% Legends
nexttile;
% Z-score colorbar
colormap(flip(cbrewer2('RdBu'))); clim(oP.clim); hold on
lgd = colorbar(gca,"east","FontSize",oP.textsize+4); lgd.Label.String = "Z-score";

% Conditions
for c = 1:nConds
    plot(0,0,'o','Color',oP.col(c,:),'LineWidth',8);
end
lgd = legend(conds2,"FontSize",oP.textsize+4,"Location","west","AutoUpdate","off");
title(lgd,"Condition"); xlim([-1 0.2]); axis off; hold off;

%% Plot electrodes
plotElecs_lfn(a,hl,hemN,dCh,sbj,oP);

%% Avg timecourses
plotCondAvg_lfn(B,sc,oP);

%% HFB single-trial
for c = 1:nConds
    nexttile;
    plotSingleTrials_lfn(xhCh(:,trialNfo.cond==conds(c))',lats5,oP.textsize);
    clim(oP.clim);
    title(conds2(c)+" trials:  HFB",'FontSize',oP.textsize);
    if c==1; ylabel("Trials by RT",'FontSize',oP.textsize); end
end

%% LFP single-trial
for c = 1:nConds
    nexttile;
    plotSingleTrials_lfn(xCh(:,trialNfo.cond==conds(c))',lats5,oP.textsize);
    clim(oP.clim);
    title(conds2(c)+" trials:  LFP",'FontSize',oP.textsize);
    if c==1; ylabel("Trials by RT",'FontSize',oP.textsize); end
    xlabel("Latency (ms)");
end

%% Save fig
if oP.save
    fn = oP.dirOutSbj+sbjCh+"_"+a.type+".jpg";
    exportgraphics(hl,fn,"Resolution",150);
    disp("SAVED: "+fn);
    close all
end

%% Total average spectral magnitude
% frqTicks = 3:10:numel(oP.freqs);
% frqDisp = string(round(oP.freqs(frqTicks)));
% nexttile; hold on
% for c = 1:nConds
%     plot(squeeze(fCh(c,:)),'LineWidth',2,'Color',oP.col(c,:));
% end
% hold off
% xticks(frqTicks); xticklabels(frqDisp); xlim([1 numel(oP.freqs)])
% title("Spectrum (1-300Hz)"); set(gca,'Fontsize',oP.textsize);
% ylabel("Magnitude");
end




%% Main functions for for HFB %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function hfb_runStats(a,o,dirs)
% Run HFB stats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load
tic;
if ~contains(a.sfx,"h"); sfx_h=a.sfx+"h"; else; sfx_h=a.sfx; end
[nh,xh,psy,trialNfo,chNfo] = ec_loadSbj(dirs,sfx_h); toc;
nh.suffix = sfx_h;
if a.ICA; nh.ICA=1; else; nh.ICA=0; end
if a.test; xh1=xh; trialNfoOg=trialNfo; x_bad=nh.badFrames; end %#ok<NASGU>

%% Initialize
sbj = nh.sbj;
sbjID = nh.sbjID;
conds = o.conds;
sbjChs = chNfo.sbjCh;
nChs = nh.xChs;
nTrs = nh.nTrials;

fs = nh.hz;
trialNfo.condC = categorical(trialNfo.cond,conds);
if a.ICA
    nChs = nh.nICs;
    icNfo = nh.icNfo;
    sbjChs = icNfo.sbjIC;
end
% Add sampling rate info to 'o' struct
if o.hzTarget>0; o.hzTarget=o.hzTarget; else; o.hzTarget=fs; end

% Band indices
B = table;
B.name = o.bands';
B.disp = o.bands2';
B.Properties.RowNames = B.name;
B = B("hfb",:);

%% Analysis template
oo = namedargs2cell(o.epoch);
[ep,trialNfo] = ec_epochPsy(psy,trialNfo,ns,oo{:},conds=o.conds,conds2=o.conds2); toc
if ~a.test; ep.time=[]; end

%% HFB: denoise & baseline correction
[xh,nh] = ec_baselineTrials(xh,nh,psy,anT,trialNfo,o); toc;
xh = single(xh);

%% HFB: summary stats
ss = statsBand_lfn(xh,nh,sbjChs,anT,"hfb",o); toc;

%% Organize data for plotting
lats5 = int16(1000 * (o.epoch(1):o.bin2:5))';
nLats = numel(lats5);
trialNfo.RT1 = int32(trialNfo.RT*1000);

% Slice full timecourses for plotting
xhe = nan(nLats,nChs,nTrs);
for t = 1:nTrs
    idx = anT.idx(anT.trialA==trialNfo.trialA(t));
    idx = idx(ismember(anT.bin2(idx),lats5));
    idx = idx(anT.iPsy(idx)<=trialNfo.idxEnd(t));
    [~,ia,ib] = intersect(lats5,anT.bin2(idx),'stable');
    xhe(ia,:,t) = xh(idx(ib),:);
end
trialNfo.RT1(~trialNfo.RT1) = trialNfo.trialA(~trialNfo.RT1);

[trialNfo,idx] = sortrows(trialNfo,["condC" "RT1" "trialA"]);
xhe = xhe(:,:,idx);
disp("Finished plotting prep: "+sbj);

%% Save summary stats
if ~a.test; clear xh nh anT; end
if ~isfolder(o.dirOut); mkdir(o.dirOut); end
if ~isfolder(o.dirOutSbj); mkdir(o.dirOutSbj); end
try parfevalOnAll(@gpuDevice,0,[]); catch;end
try reset(gpuDevice(1)); catch;end

if o.save
    if a.ICA; fn=o.dirOut+"s"+sbjID+"_icSumStats_"+o.name+".mat";
    else; fn=o.dirOut+"s"+sbjID+"_chSumStats_"+o.name+".mat"; end
    save(fn,'ss','-v7');
    disp("SAVED: "+fn);
end

%% Initialize plotting
if ~a.plot
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    savefast(fn,'xhe','B','trialNfo');
    disp("SAVED: "+fn);
else
    try delete(gcp('nocreate')); catch; end
    hfb_runPlots(a,o,dirs,ss,xhe,B,trialNfo);
    try delete(gcp('nocreate')); catch; end
end
end



function hfb_runPlots(a,o,dirs,ss,xhe,B,trialNfo)
% Run HFB plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load
n = ec_loadSbj(dirs,a.sfx,"n");
sbjID = n.sbjID;
chNfo = ec_loadSbj(dirs,a.sfx,"chNfo");
if nargin<=3
    if a.ICA; fn=o.dirOut+"s"+sbjID+"_icSumStats_"+o.name+".mat";
    else; fn=o.dirOut+"s"+sbjID+"_chSumStats_"+o.name+".mat"; end
    load(fn,"ss"); disp("LOADED: "+fn);

    fn = o.dirOut+"plot_s"+sbjID+".mat";
    load(fn,"xhe","B","trialNfo"); disp("LOADED: "+fn);
end

%% Prep
doICA = a.ICA;
sbj = n.sbj;

% Get plot options & electrode plotting data
[d,oP,xNfo,nChs,icWts] = mk_oP_chDat(a,o,n,B,chNfo,doICA);
% oP.visible=1; oP.save=0; oP.doGPU=0;

%% Parfor loop across channels/ICs
try parpool('Processes'); catch; end
parfor ch = 1:nChs
    % Load channel/IC info
    dCh = d;
    if doICA; dCh.wts(dCh.ica) = icWts(ch,:); end

    % Load EEG stats/recordings
    xN = xNfo(ch,:);
    sc = ss(ch,:);
    vars = string(sc.Properties.VariableNames);
    if any(vars=="ms"); sc.ms{1}.latency = sc.ms{1}.bin2; end
    if any(vars=="RT"); sc.RT{1}.latency = sc.RT{1}.binRT; end
    if any(vars=="pct"); sc.pct{1}.latency = sc.pct{1}.pct2; end
    xhCh = squeeze(xhe(:,ch,:));

    %% Plot function
    hfb_plotChan(a,sc,xhCh,dCh,trialNfo,oP,sbj,xN);
end
if ~a.test
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    delete(fn(:)); disp("DELETED: "+fn);
end
end



function hfb_plotChan(a,sc,xhCh,dCh,trialNfo,oP,sbj,xN)
% Plot HFB chans/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning('off','MATLAB:handle_graphics:Layout:NoPositionSetInTiledChartLayout');
nConds = numel(oP.conds);
conds = oP.conds;
conds2 = oP.conds2;
lats5 = oP.lats5;
B = oP.B;

% Channel plot data
[dCh,sbjCh,hemN,a] = getElecPlotData_lfn(a,dCh,oP,xN);

%% Initialize figure
if ~oP.save
    h = figure('Position',[0 0 1920 1080],'color','white','MenuBar','none','ToolBar','none');
else
    h = figure('Position',[0 0 1920 1080],'color','white','MenuBar','none','ToolBar','none','Visible','off');
end
hl = tiledlayout(h,3,5,'TileSpacing','compact','Padding','tight');

%% Channel/IC name
nexttile;
if a.ICA
    text(1,0.5,sbjCh+" ("+xN.order+")",Interpreter='none',FontSize=20,Units='normalized',...
        HorizontalAlignment='center',VerticalAlignment='middle');
else
    text(1,0.5,sbjCh,Interpreter='none',FontSize=20,Units='normalized',...
        HorizontalAlignment='center',VerticalAlignment='middle');
end; axis off

%% Legends
nexttile;
% Z-score colorbar
colormap(flip(cbrewer2('RdBu'))); clim(oP.clim);
lgd = colorbar(gca,"west","FontSize",oP.textsize+4); lgd.Label.String = "Z-score"; hold on

% Conditions
for c = 1:nConds
    plot(0,0,'o','Color',oP.col(c,:),'LineWidth',8);
end
lgd = legend(conds2,"FontSize",oP.textsize+4,"Location","east","AutoUpdate","off");
title(lgd,"Condition"); xlim([-1 0.2]); axis off; hold off;

%% Avg timecourses
plotCondAvg_lfn(B,sc,oP);


%% Plot electrodes (lateral)
plotElecs_lfn(a,hl,hemN,dCh,sbj,oP,"lateral");


%% HFB single-trial
for c = 1:nConds
    % Plot electrodes (medial)
    if c==4; plotElecs_lfn(a,hl,hemN,dCh,sbj,oP,"medial"); end

    % Single-trials per cond
    nexttile;
    plotSingleTrials_lfn(xhCh(:,trialNfo.cond==conds(c))',lats5,oP.textsize);
    clim(oP.clim);
    title(conds2(c)+" trials:  HFB",'FontSize',oP.textsize);
    if c==1; ylabel("Trials by RT",'FontSize',oP.textsize); end
    xlabel("Latency (ms)",'FontSize',oP.textsize+2);
end

%% Save fig
if oP.save
    fn = oP.dirOutSbj+sbjCh+"_"+a.type+".jpg";
    exportgraphics(hl,fn,"Resolution",150);
    disp("SAVED: "+fn);
    close all
end
end



%% Stats Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Summary stats for multiple freqs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ss = statsSpec_lfn(xs,ns,sbjChs,anT,B,o)
sbj = ns.sbj;
sbjID = ns.sbjID;
nChs = size(xs,2);
B(cellfun(@isempty,B.freqs),:) = [];
doICA = ns.ICA;
if doICA; chNames = ns.icNfo.ic; else; chNames=[1:nChs,1]; end
epoch = int16(floor(o.stats.epoch*1000));
epochRT = int16(floor(o.stats.epochRT*1000));
epochPct = int16(floor(o.stats.epochPct*100));

%% Calculate stats
ss = cell(nChs,1);
parfor ch = 1:nChs
    ssCh = table;
    ssCh.ch(1) = ch;
    if doICA; ssCh.name(1) = chNames(ch); end
    ssCh.sbjID(1) = sbjID;
    anCh = anT;
    anCh.x = squeeze(xs(:,ch,:));
    anCh.latency = double(anCh.latency);

    %% Stim-locked stats (latency)
    if ~isempty(epoch)
        idx = anCh.bin2>=epoch(1) & anCh.bin2<=epoch(2);

        % All frequencies
        sl = grpstats(anCh(idx,:),["condC" "bin2"],"mean","DataVars",["latency" "x"]);
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"mean_","");
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"GroupCount","N");
        sl.Properties.VariableNames("condC")="cond"; sl.cond=string(sl.cond);
        sl.latency = single(sl.latency);
        sl.N = uint16(sl.N);
        sl.sbjCh(:) = sbjChs(ch);
        sl.Properties.RowNames = sl.sbjCh+"_"+sl.cond+"_"+sl.bin2;
        sl = movevars(sl,"sbjCh","Before","cond");

        % Reconstruct frequency band timecourses
        for b = 1:height(B)
            band = B.name(b);
            idb = B.id(b,:);
            anCh.(band)(idx) = mean(anCh.x(idx,idb),2,'omitnan');
        end
        anCh.x = [];

        % Frequency bands
        sl2 = grpstats(anCh(idx,:),["condC" "bin2"],["mean" "sem"],"DataVars",B.name);
        sl2.Properties.VariableNames = strrep(sl2.Properties.VariableNames,"mean_","");
        sl2.Properties.VariableNames = strrep(sl2.Properties.VariableNames,"sem_","SE_");
        sl2.condC=[]; sl2.bin2=[]; sl2.GroupCount=[]; sl2.Properties.RowNames={};
        sl = [sl,sl2]; % Concactenate & copy
        sl = movevars(sl,sl2.Properties.VariableNames,"Before","x");
        ssCh.ms{1} = sl;
    end

    %% RT-locked stats (RT - latency)
    if ~isempty(epochRT)
        idx = anCh.binRT>=epochRT(1) & anCh.binRT<=epochRT(2);
        % Frequency bands
        sr = grpstats(anCh(idx,:),["condC" "binRT"],["mean" "sem"],"DataVars",B.name);
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"mean_","");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"sem_","SE_");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"GroupCount","N");
        sr.Properties.VariableNames("condC")="cond"; sr.cond=string(sr.cond);
        sr.N = uint16(sr.N);
        sr.sbjCh(:) = sbjChs(ch);
        sr = movevars(sr,"sbjCh","Before","cond");
        sr.Properties.RowNames = sr.sbjCh+"_"+sr.cond+"_"+sr.binRT;
        ssCh.RT{1} = sr;
    end

    %% Percent RT stats (latency/RT)
    if ~isempty(epochPct)
        idx = anCh.pct2>=epochPct(1) & anCh.pct2<=epochPct(2);
        % Frequency bands
        sp = grpstats(anCh(idx,:),["condC" "pct2"],["mean" "sem"],"DataVars",B.name);
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"mean_","");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"sem_","SE_");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"GroupCount","N");
        sp.Properties.VariableNames("condC")="cond"; sp.cond=string(sp.cond);
        sp.N = uint16(sp.N);
        sp.sbjCh(:) = sbjChs(ch);
        sp = movevars(sp,"sbjCh","Before","cond");
        sp.Properties.RowNames = sp.sbjCh+"_"+sp.cond+"_"+sp.pct2;
        ssCh.pct{1} = sp;
    end

    %% Copy
    ss{ch} = ssCh;
end

% Finalize
ss = vertcat(ss{:});
ss.sbjCh = sbjChs;
ss.Properties.RowNames = sbjChs;
disp("SPEC summary stats: "+sbj);
end


% Summary stats for single freq/timecourse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ss = statsBand_lfn(xa,na,sbjChs,anT,band,o,ss)
sbj = na.sbj;
sbjID = na.sbjID;
nChs = size(xa,2);
epoch = int16(floor(o.stats.epoch*1000));
epochRT = int16(floor(o.stats.epochRT*1000));
epochPct = int16(floor(o.stats.epochPct*100));
if nargin<7
    ss = table;
    ss.ch = (1:nChs)';
    if na.ICA; ss.name = na.icNfo.name; end
    ss.sbjID(:) = sbjID;
end

%% Calculate stats
ss = table2struct(ss);
ss = mat2cell(ss,ones(height(ss),1));
parfor ch = 1:nChs
    ssCh = ss{ch};
    anCh = anT;
    anCh.x = xa(:,ch); % Channel data
    anCh.latency = double(anCh.latency);

    %% Stim-locked stats
    if ~isempty(epoch)
        idx = anCh.bin2>=epoch(1) & anCh.bin2<=epoch(2);

        % All frequencies
        sl = grpstats(anCh(idx,:),["condC" "bin2"],["mean" "sem"],"DataVars",["latency" "x"]);
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"_x","_"+band);
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"mean_","");
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"sem_","SE_");
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"GroupCount","N");
        sl.Properties.VariableNames("condC")="cond"; sl.cond=string(sl.cond);
        sl.latency = single(sl.latency);
        sl.N = uint16(sl.N);
        sl.sbjCh(:) = sbjChs(ch);
        sl.Properties.RowNames = sl.sbjCh+"_"+sl.cond+"_"+sl.bin2;
        sl = movevars(sl,"sbjCh","Before","cond");
        sl.SE_latency = [];
        % Copy to permanent table
        if any(fieldnames(ssCh)=="ms")
            ssCh.ms.(band) = sl.(band);
            ssCh.ms.("SE_"+band) = sl.("SE_"+band);
        else
            ssCh.ms = sl;
        end
    end

    %% RT-locked stats
    if ~isempty(epochRT)
        idx = anCh.binRT>=epochRT(1) & anCh.binRT<=epochRT(2);
        sr = grpstats(anCh(idx,:),["condC" "binRT"],["mean" "sem"],"DataVars","x");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"_x","_"+band);
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"mean_","");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"sem_","SE_");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"GroupCount","N");
        sr.Properties.VariableNames("condC")="cond"; sr.cond=string(sr.cond);
        sr.N = uint16(sr.N);
        sr.sbjCh(:) = sbjChs(ch);
        sr.Properties.RowNames = sr.sbjCh+"_"+sr.cond+"_"+sr.binRT;
        sr = movevars(sr,"sbjCh","Before","cond");
        % Copy to permanent table
        if any(fieldnames(ssCh)=="RT")
            ssCh.RT.(band) = sr.(band);
            ssCh.RT.("SE_"+band) = sr.("SE_"+band);
        else
            ssCh.RT = sr; % Copy
        end
    end

    %% Percent RT stats
    if ~isempty(epochPct)
        idx = anCh.pct2>=epochPct(1) & anCh.pct2<=epochPct(2);
        sp = grpstats(anCh(idx,:),["condC" "pct2"],["mean" "sem"],"DataVars","x");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"_x","_"+band);
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"mean_","");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"sem_","SE_");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"GroupCount","N");
        sp.Properties.VariableNames("condC")="cond"; sp.cond=string(sp.cond);
        sp.N = uint16(sp.N);
        sp.sbjCh(:) = sbjChs(ch);
        sp.Properties.RowNames = sp.sbjCh+"_"+sp.cond+"_"+sp.pct2;
        sp = movevars(sp,"sbjCh","Before","cond");
        % Copy to permanent table
        if any(fieldnames(ssCh)=="pct")
            [~,iA,iB] = intersect(ssCh.pct.Properties.RowNames,sp.Properties.RowNames,"stable");
            ssCh.pct.(band)(iA) = sp.(band)(iB);
            ssCh.pct.("SE_"+band)(iA) = sp.("SE_"+band)(iB);
        else
            ssCh.pct = sp; % Copy
        end
    end

    %% Copy
    ss{ch} = ssCh;
end

% Finalize
ss = struct2table(vertcat(ss{:}));
ss.sbjCh = sbjChs;
ss.Properties.RowNames = sbjChs;
disp(band+" summary stats: "+sbj);
end




%% Plot Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make plot options & channel plotting data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [d,oP,xNfo,nChs,icWts] = mk_oP_chDat(a,o,n,B,chNfo,doICA)

% Add to plot options
oP = o.oP;
oP.lats = int16(floor(1000*(o.stats.epoch(1):o.epoch.bin2:o.stats.epoch(2))))';
oP.lats5 = int16(floor(1000*(o.stats.epoch(1):o.epoch.bin2:5)))';
oP.latsRT = int16(floor(1000*(o.stats.epochRT(1):o.epoch.bin2:o.stats.epochRT(2))))';
oP.conds = o.conds;
oP.conds2 = o.conds2;
oP.B = B;
oP.dirOutSbj = o.dirOutSbj;
oP.dirFS = o.dirFS;
if nnz(chNfo.ECoG)/height(chNfo) > 0.75
    oP.alpha = 0.95;
else
    oP.alpha = 0.25;
end

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
d.MNI = chNfo.MNI;
d.pialRAS = chNfo.pialRAS;
d.order(:) = nan;
if a.ICA
    if a.sfx=="i"; sfx1=""; else; sfx1="_"+a.sfx; end
    d.ica = chNfo.("ica"+sfx1);
    d.wts(:) = nan;
    d.sz(~d.ica) = 2;
    d.sz(d.ica) = 10;
end

% Get IC/chan info
nChs = n.xChs;
if doICA
    nChs = n.nICs;
    xNfo = n.icNfo;
    icWts = zscore(n.ica.winv',1,'all');
else
    xNfo = chNfo;
    icWts = zeros(nChs,1);
end
end


% Get electrode plot data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dCh,sbjCh,hemN,a] = getElecPlotData_lfn(a,dCh,oP,xN)
if a.ICA
    % Color by ICA weights
    %dCh.wts = normalize(dCh.wts,"range",oP.climICA);
    [dCh.col,~,~,dCh.order] =...
        ec_colorsFromValues(dCh.wts,'RdBu',oP.climICA,zscore=oP.climICA_z);
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
a.ch = ch;
a.sbjCh = sbjCh;
dCh(ismember(dCh.pialRAS(:,1),[0 nan]),:) = [];
dCh = sortrows(dCh,'order','ascend');
end


% Plot electrodes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotElecs_lfn(a,hl,hemN,dCh,sbj,oP,medial) 
if nargin<7; medial=""; end
%if a.type=="hfb"; span=5; else; span=[1 2]; end
span = [1 2];
dCh.pos = dCh.pialRAS;

% Hemisphere
hem = dCh.hem(dCh.ch==a.ch);
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
            dCh.hem~="R",:),"latero-anterior","pial",sbj,oP,hem);

        % Right
        plotCortex_lfn(nexttile(hl),dCh(ismember(dCh.lat,["lateral" "both"]) &...
            dCh.hem~="L",:),"latero-anterior","pial",sbj,oP,hem);
    else
        plotCortex_lfn(nexttile(hl,span),dCh(ismember(dCh.lat,["lateral" "both"]),:),...
            "lateral","pial",sbj,oP,hem);
    end
end

%% Plot medial electrodes on native cortex
%if a.type=="hfb"; span=9; end
if ismember(medial,["medial" ""])
    if nnz(hemN)>1
        % Left
        plotCortex_lfn(nexttile(hl),dCh(ismember(dCh.lat,["medial" "both"]) &...
            dCh.hem~="R",:),"medio-posterior","pial",sbj,oP,hem);

        % Right
        plotCortex_lfn(nexttile(hl),dCh(ismember(dCh.lat,["medial" "both"]) &...
            dCh.hem~="L",:),"medio-posterior","pial",sbj,oP,hem);
    else
        plotCortex_lfn(nexttile(hl,span),dCh(ismember(dCh.lat,["medial" "both"]),:),...
            "medial","pial",sbj,oP,hem);
    end
end
end


% Plot cortex %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotCortex_lfn(h,dCh,lat,surf,sbj,oP,hem)
ec_plotCortex(hem,lat,dCh,sbj=sbj,sbjDir=oP.dirFS,surfType=surf,...
    visible=oP.visible,opacity=oP.alpha,doGPU=oP.doGPU,h=h,...
    save=0,flip=0,pullF=15,parallel=0);
end


% Plot timecourses per trial %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotSingleTrials_lfn(dat,lats5,fontSz)
imagesc(dat,'XData',lats5,'AlphaData',~isnan(dat));
set(gca,'YTick',(1:width(dat))-0.5,'YTickLabel','','FontSize',fontSz,...
    'YTickLabelRotation',90,'TickDir','out','Color',[0 0 0]);
colormap(flip(cbrewer2('RdBu')));
end


% Plot averaged timecourses per condition %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotCondAvg_lfn(B,sc,oP)
for c = 1:height(B)
    % Stim-locked
    nexttile;
    plotFrameAvg_lfn(sc.ms{1},B.name(c),oP);
    set(gca,'FontSize',oP.textsize);
    title("Stim latency:  "+B.disp(c),'FontSize',oP.textsize);
    xlabel("Latency (ms)",'FontSize',oP.textsize);
    if c==1; ylabel("Magnitude (z)",'FontSize',oP.textsize);  end
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off

    % RT-locked
    nexttile;
    plotFrameAvg_lfn(sc.RT{1},B.name(c),oP);
    set(gca,'FontSize',oP.textsize);
    title("RT latency:  "+B.disp(c),'FontSize',oP.textsize);
    xlabel("RT - Latency (ms)",'FontSize',oP.textsize);
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off

    % Percent RT
    nexttile;
    plotFrameAvg_lfn(sc.pct{1},B.name(c),oP);
    set(gca,'FontSize',oP.textsize);
    title("RT percent:  "+B.disp(c),'FontSize',oP.textsize);
    xlabel("Latency/RT (%)",'FontSize',oP.textsize);
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot([100 100],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off
end
end


% Plot averaged timecourses %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotFrameAvg_lfn(dat,band,oP)
warning('off','MATLAB:Figure:UnableToSetRendererToOpenGL');
nConds = numel(oP.conds2);

lats = unique(dat.latency)';
lats = repmat(lats,nConds,1);
y = nan(nConds,length(lats));
ySE = y;
%ySig = y;
for c = 1:nConds
    cond = oP.conds2(c);
    idxP = ismember(dat.latency,lats(c,:)) & dat.cond==cond;
    idx = ismember(lats(c,:),dat.latency(idxP));
    y(c,idx) = dat.(band)(idxP)';
    ySE(c,idx) = dat.("SE_"+band)(idxP)';
end
mseb(lats,y,ySE,oP.o1D,1); axis tight
set(gca,'fontsize',oP.textsize);
end
