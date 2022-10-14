function ec_summaryStats_sbjCh(sbj,proj,o,dirs,a)
arguments
    sbj {ischar,isstring}
    proj {ischar,isstring} = "MMR"
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    dirs struct = []
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
if ~isstruct(dirs); dirs = ec_getDirs(dirs,sbj,proj); end
if contains(a.sfx,"i"); a.ICA = true; end
if a.ICA && ~contains(a.sfx,"i"); a.sfx = a.sfx + "i"; end
% a.type="hfb"; a.ICA=1; a.sfx="i"; a.test=1; a.stats=1; a.plot=1;

%% Calculate summary stats
if a.stats
    if a.type=="spec"
        spec_runStats(a,o,dirs);
    elseif a.type=="hfb"
        hfb_runStats(a,o,dirs);
    end
end

%% Make plots
if ~a.stats && a.plot
    if a.type=="spec"
        spec_runPlots(a,o,dirs);
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
[ns,xs,psy,trialNfo,chNfo] = ec_loadSbj(dirs,a.sfx+"s"); toc;
ns.suffix = a.sfx+"s";
if a.ICA; ns.ICA=1; else; ns.ICA=0; end
if a.test; xs1=xs; trialNfoOg=trialNfo; x_bad=ns.badFrames; end %#ok<NASGU>

%% Initialize
sbj = ns.sbj;
sbjID = ns.sbjID;
conds = o.conds;
sbjChs = chNfo.sbjCh;
nChs = ns.xChs;
nTrs = ns.nTrials;
nBands = numel(o.bands);
fs = ns.fs;
trialNfo.condC = categorical(trialNfo.cond,conds);
if a.ICA
    nChs = ns.nICs;
    icNfo = ns.icNfo;
    sbjChs = icNfo.sbjIC;
end
% Add sampling rate info to 'o' struct
if o.dsTarg>0; o.fsTarg=o.dsTarg; else; o.fsTarg=fs; end

% Band indices
B = table;
B.name = o.bands';
B.disp = o.bands2';
B.freqs(:) = {[]};
for i = 1:nBands
    B.id(i,:) = ns.freqs>o.bandsF(i,1) & ns.freqs<=o.bandsF(i,2);
    B.freqs{i} = ns.freqs(B.id(i,:));
end
B.Properties.RowNames = B.name;

% Get mean evoked magnitude per freq & cond
ssFrq = nan(numel(conds),nChs,numel(ns.freqs));
for c = 1:numel(conds)
    idx = psy.stim & psy.cond==conds(c);
    ssFrq(c,:,:) = squeeze(mean(xs(idx,:,:),1,'omitnan'));
    %ssFrq(c,:,:) = normalize(ssFrq(c,:,:),3,'zscore','robust');
end
disp("Calculated mean evoked magnitude per freq & cond: "+sbj); toc;
try parpool('threads'); catch;end

%% Analysis template
anT = analysisTemplate_lfn(psy,trialNfo,ns,o); toc;
if ~a.test; anT.time=[]; end

%% Spec: denoise & baseline correction
[xs,ns] = blcFiltClean_lfn(xs,ns,psy,anT,trialNfo,o); toc;

%% Spec: summary stats
[ss,ssR] = statsSpec_lfn(xs,ns,sbjChs,anT,B,o); toc;

%% LFP: load & initialize
[n,x,psy1,trialNfo1] = ec_loadSbj(dirs,a.sfx);
n.suffix = a.sfx;
if a.ICA; n.ICA=1; else; n.ICA=0; end
if a.test; x1=x; end %#ok<NASGU>

%% LFP: denoise, downsample & baseline correction
x = blcFiltClean_lfn(x,n,psy1,anT,trialNfo1,o);
if ~a.test; clear n; clear psy1; clear trialNfo1; end
%x2 = x1(1:ds:end,:);

%% LFP: summary stats
[sl,slR] = statsBand_lfn(x,ns,sbjChs,anT,o); toc;
if ~a.test; x=single(x); end % convert to single for later plots

% Add to main summary stats structs
for ch = 1:nChs
    ss{ch}.lfp = single(sl{ch}.x);
    ss{ch}.SE_lfp = single(sl{ch}.SE);
    ss{ch} = movevars(ss{ch},["N" "lfp" "SE_lfp"],"After","latency");

    ssR{ch}.lfp = single(slR{ch}.x);
    ssR{ch}.SE_lfp = single(slR{ch}.SE);
    ssR{ch} = movevars(ssR{ch},["N" "lfp" "SE_lfp"],"After","binRT");
end
if ~a.test; clear sl slR; end

%% Organize data for plotting
lats5 = int16(1000 * (o.epoch(1):o.binP:5))';
nLats = numel(lats5);
trialNfo.RT1 = int32(trialNfo.RT*1000);

% Slice full timecourses for plotting
xe = nan(nLats,nChs,nTrs);
xhe = nan(nLats,nChs,nTrs);
for t = 1:nTrs
    idx = anT.idx(anT.trialA==trialNfo.trialA(t));
    idx = idx(ismember(anT.bin(idx),lats5));
    idx = idx(anT.iPsy(idx)<=trialNfo.idxEnd(t));
    [~,ia,ib] = intersect(lats5,anT.bin(idx),'stable');
    xe(ia,:,t) = x(idx(ib),:);
    xhe(ia,:,t) = mean(xs(idx(ib),:,B.id("hfb",:)),3,'omitnan');
end
trialNfo.RT1(~trialNfo.RT1) = trialNfo.trialA(~trialNfo.RT1);

[trialNfo,idx] = sortrows(trialNfo,["condC" "RT1" "trialA"]);
xe = xe(:,:,idx);
xhe = xhe(:,:,idx);
disp("Finished plotting prep: "+sbj);

%% Initialize plotting
if ~a.test; clear x xs ns anT; end
if ~isfolder(o.dirOut); mkdir(o.dirOut); end
if ~isfolder(o.dirOutSbj); mkdir(o.dirOutSbj); end
try parfevalOnAll(@gpuDevice,0,[]); catch;end
try reset(gpuDevice(1)); catch;end

if ~a.plot
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    save(fn,"ss","ssR","xe","xhe","ssFrq","B","trialNfo","-v7.3","-nocompression");
    disp("SAVED: "+fn);
else
    try delete(gcp('nocreate')); catch; end
    spec_runPlots(a,o,dirs,ss,ssR,xe,xhe,ssFrq,B,trialNfo);
    try delete(gcp('nocreate')); catch; end
end

%% Save summary stats
if o.save
    ss = vertcat(ss{:});
    ssR = vertcat(ssR{:});

    if a.ICA; fn=o.dirOut+"s"+sbjID+"_icSumStats_"+o.name+".mat";
    else; fn=o.dirOut+"s"+sbjID+"_chSumStats_"+o.name+".mat"; end
    save(fn,"ss","ssR","ssFrq","-v7.3");
    disp("SAVED: "+fn);
end
end



% Run spec plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function spec_runPlots(a,o,dirs,ss,ssR,xe,xhe,ssFrq,B,trialNfo)
% Load
ns = ec_loadSbj(dirs,a.sfx+"s","n");
sbjID = ns.sbjID;
%fs = ns.fs; if o.dsTarg>0; fs=o.dsTarg; end
chNfo = ec_loadSbj(dirs,a.sfx+"s","chNfo");
if nargin<=3
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    load(fn,"ss","ssR","xe","xhe","ssFrq","B","trialNfo"); disp("LOADED: "+fn);
end

%% Prep
doICA = a.ICA;
sbj = ns.sbj;

% Add to plot options
oP = o.oP;
oP.freqs = ns.freqs;
oP.lats = int16(1000 * (o.epoch(1):o.binP:o.epoch(2)))';
oP.lats5 = int16(1000 * (o.epoch(1):o.binP:5))';
oP.latsRT = int16(1000 * (o.epochRT(1):o.binP:o.epochRT(2)))';
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
d = [d,chNfo(:,2:12)];
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
nChs = ns.xChs;
if doICA
    nChs = ns.nICs;
    icWts = ns.icWinv;
    xNfo = ns.icNfo;
else
    xNfo = chNfo;
    icWts = zeros(nChs,1);
end
% oP.visible=1; oP.save=0; oP.doGPU=0;

%% Parfor loop across channels/ICs
try parpool('local2',24); catch; end
parfor ch = 1:nChs
    % Load channel data
    dCh = d;
    if doICA
        dCh.wts(dCh.ica) = icWts(ch,:);
    end

    % Load Ch/IC data
    xN = xNfo(ch,:);
    sc = ss{ch};
    sc.latency = sc.bin;
    scR = ssR{ch};
    scR.latency = scR.binRT;
    xCh = squeeze(xe(:,ch,:));
    xhCh = squeeze(xhe(:,ch,:));
    fCh = squeeze(ssFrq(:,ch,:));

    %% Plot function
    spec_plotChan(a,sc,scR,xCh,xhCh,dCh,fCh,trialNfo,B,oP,sbj,xN);
end
end



% Plot spec chans/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function spec_plotChan(a,sc,scR,xCh,xhCh,dCh,fCh,trialNfo,B,oP,sbj,xN)
warning('off','MATLAB:handle_graphics:Layout:NoPositionSetInTiledChartLayout');
nConds = numel(oP.conds);
conds = oP.conds;
conds2 = oP.conds2;
%lats = oP.lats;
lats5 = oP.lats5;

% IC weights color
if a.ICA
    sbjCh = xN.sbjIC;
    [dCh.col,~,~,dCh.order] = colorbarFromValues_KT(dCh.wts,'RdBu',oP.clim,center=0,zscore=1);
    dCh.order = abs(dCh.order-0.5);
    dCh.col(dCh.order==Inf,1:3) = 0;
    dCh.order(dCh.order==Inf) = -Inf;
    dCh = sortrows(dCh,'order','ascend');
    hemN = [nnz(dCh.hem=="L") nnz(dCh.hem=="R")];
else
    ch = xN.ch;
    sbjCh = xN.sbjCh;
    dCh.sz(ch) = 12;
    dCh.col(ch,1:3) = [0.753,0.004,0.133];
    dCh.order = dCh.ch;
    dCh.order(ch) = Inf;
    dCh = sortrows(dCh,'order','ascend');
    hemN = [nnz(xN.hem=="L") nnz(xN.hem=="R")];
end

% Prep chan info
dCh(ismember(dCh.pialRAS(:,1),[0 nan]),:) = [];


%% Initialize figure
if ~oP.save
    h = figure('Position',[0 0 1920 1080],'color','white','MenuBar','none','ToolBar','none');
else
    h = figure('Position',[0 0 1920 1080],'color','white','MenuBar','none','ToolBar','none','Visible','off');
end
hl = tiledlayout(h,5,8,'TileSpacing','tight','Padding','none');

%% Plot lateral electrodes on native cortex
if nnz(hemN)>1
    plotCortex_lfn(nexttile,dCh(ismember(dCh.lat,["lateral" "both"]) & dCh.hem=="L",:),...
        "latero-anterior","pialRAS","pial",sbj,oP);

    plotCortex_lfn(nexttile,dCh(ismember(dCh.lat,["lateral" "both"]) & dCh.hem=="R",:),...
        "latero-anterior","pialRAS","pial",sbj,oP);
else
    plotCortex_lfn(nexttile([1 2]),dCh(ismember(dCh.lat,["lateral" "both"]),:),...
        "lateral","pialRAS","pial",sbj,oP);
end
if a.ICA
    title(sbjCh+" ("+xN.ic+")",'Interpreter','none');
else
    title(sbjCh,'Interpreter','none');
end

%% LFP single-trial
for c = 1:nConds
    nexttile;
    plotSingleTrials_lfn(xCh(:,trialNfo.cond==conds(c))',lats5, oP.textsize);
    clim(oP.clim);
    title(conds2(c)+" trials: LFP");
    if c==1; xlabel("Latency (ms)"); ylabel("Trials by RT"); end
end

%% Plot medial electrodes on native cortex
if nnz(hemN)>1
    plotCortex_lfn(nexttile,dCh(ismember(dCh.lat,["medial" "both"]) & dCh.hem=="L",:),...
        "medio-posterior","pialRAS","pial",sbj,oP);

    plotCortex_lfn(nexttile,dCh(ismember(dCh.lat,["medial" "both"]) & dCh.hem=="R",:), ...
        "medio-posterior","pialRAS","pial",sbj,oP);
else
    plotCortex_lfn(nexttile([1 2]),dCh(ismember(dCh.lat,["medial" "both"]),:),...
        "medial","pialRAS","pial",sbj,oP);
end

%% HFB single-trial
for c = 1:nConds
    nexttile;
    plotSingleTrials_lfn(xhCh(:,trialNfo.cond==conds(c))',lats5, oP.textsize);
    clim(oP.clim);
    title(conds2(c)+" trials: "+B.disp(B.name=="hfb"));
    if c==1; xlabel("Latency (ms)"); ylabel("Trials by RT"); end
end

%% Total average spectral magnitude
frqTicks = 3:10:numel(oP.freqs);
frqDisp = string(round(oP.freqs(frqTicks)));
nexttile; hold on
for c = 1:nConds
    plot(squeeze(fCh(c,:)),'LineWidth',2,'Color',oP.col(c,:));
end
hold off
xticks(frqTicks); xticklabels(frqDisp); xlim([1 numel(oP.freqs)])
title("Spectrum (1-300Hz)"); set(gca,'Fontsize',oP.textsize);
ylabel("Magnitude");

%% Legends
nexttile; hold on
for c = 1:nConds
    plot(0,0,'o','Color',oP.col(c,:),'LineWidth',8);
end
lgd = legend(conds2,'FontSize',oP.textsize+2,'Location','southwest');
lgd.AutoUpdate = 'off';
colormap(flip(cbrewer2('RdBu'))); clim(oP.clim); colorbar(gca,"east");
hold off; axis off;

%% ERSP
for c = 1:nConds
    nexttile
    idx = ismember(sc.cond,conds(c)); % & sc.latency>=-200 & sc.latency<=5000;
    imagesc(sc.x(idx,:)','XData',sc.latency(idx,:)');
    yticks(frqTicks); yticklabels(frqDisp);
    set(gca,'FontSize',oP.textsize,'YDir','normal','color',[1 1 1]);
    colormap(flip(cbrewer2('RdBu'))); clim(oP.clim);
    title(conds2(c)+": ERSP")
    if c==1; xlabel("Latency (ms)"); ylabel("Frequency (Hz)"); end
end

%% Stim-locked avg timecourses
for c = 1:height(B)
    nexttile;
    plotTrialAvg_lfn(sc,B.name(c),oP);
    title(B.disp(c) +"  stim avg");
    if c==1; xlabel("Latency (ms)"); ylabel("Magnitude (z)"); end
    set(gca,'FontSize',oP.textsize);
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off
end


%% RT-locked avg timecourses
for c = 1:height(B)
    nexttile;
    plotTrialAvg_lfn(scR,B.name(c),oP);
    title(B.disp(c) +"  RT avg");
    if c==1; xlabel("RT - Latency (ms)"); ylabel("Magnitude (z)"); end
    set(gca,'FontSize',oP.textsize);
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off
end

%% Save fig
if oP.save
    fn = oP.dirOutSbj+sbjCh+"_spec.jpg";
    exportgraphics(hl,fn,"Resolution",100);
    disp("SAVED: "+fn);
    close all
end
end





%% Main functions for HFB (HFB & LFP) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run HFB stats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function hfb_runStats(a,o,dirs)
% Load
tic;
[nh,xh,psy,trialNfo,chNfo] = ec_loadSbj(dirs,a.sfx+"h"); toc;
nh.suffix = a.sfx+"h";
if a.ICA; nh.ICA=1; else; nh.ICA=0; end
if a.test; xh1=xh; trialNfoOg=trialNfo; x_bad=nh.badFrames; end %#ok<NASGU>

%% Initialize
sbj = nh.sbj;
sbjID = nh.sbjID;
conds = o.conds;
sbjChs = chNfo.sbjCh;
nChs = nh.xChs;
nTrs = nh.nTrials;

fs = nh.fs;
trialNfo.condC = categorical(trialNfo.cond,conds);
if a.ICA
    nChs = nh.nICs;
    icNfo = nh.icNfo;
    sbjChs = icNfo.sbjIC;
end
% Add sampling rate info to 'o' struct
if o.dsTarg>0; o.fsTarg=o.dsTarg; else; o.fsTarg=fs; end

% Band indices
B = table;
B.name = o.bands';
B.disp = o.bands2';
B.Properties.RowNames = B.name;
B = B(["hfb" "lfp"],:);

% % Get mean evoked magnitude per freq & cond
% ssFrq = nan(numel(conds),nChs,numel(nh.freqs));
% for c = 1:numel(conds)
%     idx = psy.stim & psy.cond==conds(c);
%     ssFrq(c,:,:) = squeeze(mean(xh(idx,:,:),1,'omitnan'));
%     %ssFrq(c,:,:) = normalize(ssFrq(c,:,:),3,'zscore','robust');
% end
% disp("Calculated mean evoked magnitude per freq & cond: "+sbj); toc;
try parpool('threads'); catch;end

%% Analysis template
anT = analysisTemplate_lfn(psy,trialNfo,nh,o); toc;
if ~a.test; anT.time=[]; end

%% HFB: denoise & baseline correction
[xh,nh] = blcFiltClean_lfn(xh,nh,psy,anT,trialNfo,o); toc;
xh = single(xh);

%% HFB: summary stats
ss = statsBand_lfn(xh,nh,sbjChs,anT,"hfb",o); toc;

%% LFP: load & initialize
[n,x,psy1,trialNfo1] = ec_loadSbj(dirs,a.sfx);
n.suffix = a.sfx;
if a.ICA; n.ICA=1; else; n.ICA=0; end
if a.test; x1=x; end %#ok<NASGU>

%% LFP: denoise, downsample & baseline correction
x = blcFiltClean_lfn(x,n,psy1,anT,trialNfo1,o);
x = single(x);
if ~a.test; clear n; clear psy1; clear trialNfo1; end

%% LFP: summary stats
ss = statsBand_lfn(x,nh,sbjChs,anT,"lfp",o,ss); toc;

%% Organize data for plotting
lats5 = int16(1000 * (o.epoch(1):o.binP:5))';
nLats = numel(lats5);
trialNfo.RT1 = int32(trialNfo.RT*1000);

% Slice full timecourses for plotting
xe = nan(nLats,nChs,nTrs);
xhe = nan(nLats,nChs,nTrs);
for t = 1:nTrs
    idx = anT.idx(anT.trialA==trialNfo.trialA(t));
    idx = idx(ismember(anT.bin(idx),lats5));
    idx = idx(anT.iPsy(idx)<=trialNfo.idxEnd(t));
    [~,ia,ib] = intersect(lats5,anT.bin(idx),'stable');
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
    save(fn,"ss","-v7.3");
    disp("SAVED: "+fn);
end

%% Initialize plotting
if ~a.plot
    fn = o.dirOut+"plot_s"+sbjID+".mat";
    save(fn,"xe","xhe","B","trialNfo","-v7.3","-nocompression");
    disp("SAVED: "+fn);
else
    try delete(gcp('nocreate')); catch; end
    hfb_runPlots(a,o,dirs,ss,xe,xhe,B,trialNfo);
    try delete(gcp('nocreate')); catch; end
end
end



% Run HFB plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function hfb_runPlots(a,o,dirs,ss,xe,xhe,B,trialNfo)
% Load
n = ec_loadSbj(dirs,a.sfx,"n");
sbjID = n.sbjID;
%fs = ns.fs; if o.dsTarg>0; fs=o.dsTarg; end
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

% Add to plot options
oP = o.oP;
oP.lats = int16(1000 * (o.epoch(1):o.binP:o.epoch(2)))';
oP.lats5 = int16(1000 * (o.epoch(1):o.binP:5))';
oP.latsRT = int16(1000 * (o.epochRT(1):o.binP:o.epochRT(2)))';
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
d = [d,chNfo(:,2:12)];
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
    icWts = n.icWinv;
    xNfo = n.icNfo;
else
    xNfo = chNfo;
    icWts = zeros(nChs,1);
end
% oP.visible=1; oP.save=0; oP.doGPU=0;

%% Parfor loop across channels/ICs
try parpool('local2',24); catch; end
parfor ch = 1:nChs
    % Load channel/IC info
    dCh = d;
    if doICA; dCh.wts(dCh.ica) = icWts(ch,:); end

    % Load EEG stats/recordings
    xN = xNfo(ch,:);
    sc = ss(ch,:);
    vars = string(sc.Properties.VariableNames);
    if any(vars=="ms"); sc.ms{1}.latency = sc.ms{1}.bin; end
    if any(vars=="RT"); sc.RT{1}.latency = sc.RT{1}.binRT; end
    if any(vars=="pct"); sc.pct{1}.latency = sc.pct{1}.pct2; end
    xCh = squeeze(xe(:,ch,:));
    xhCh = squeeze(xhe(:,ch,:));

    %% Plot function
    hfb_plotChan(a,sc,xCh,xhCh,dCh,trialNfo,oP,sbj,xN);
end
end



% Plot HFB chans/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function hfb_plotChan(a,sc,xCh,xhCh,dCh,trialNfo,oP,sbj,xN)
warning('off','MATLAB:handle_graphics:Layout:NoPositionSetInTiledChartLayout');
nConds = numel(oP.conds);
conds = oP.conds;
conds2 = oP.conds2;
lats5 = oP.lats5;
B = oP.B;

% Prep channel plotting data
if a.ICA
    % Color by ICA weights
    [dCh.col,~,~,dCh.order] = colorbarFromValues_KT(dCh.wts,'RdBu',oP.clim,center=0,zscore=1);
    ch = xN.name;
    sbjCh = xN.sbjIC;
    dCh.sz(ch)=13; dCh.bSz(ch)=2; dCh.bCol(ch,:)=[0 1 0];
    dCh.col(dCh.order==-Inf,1:3) = 0;
    hemN = [nnz(dCh.hem=="L") nnz(dCh.hem=="R")];
    %dCh.order = abs(dCh.order-0.5);
    %dCh.order(dCh.order==Inf) = -Inf;
    %dCh = sortrows(dCh,'order','ascend');
else
    ch = xN.ch;
    sbjCh = xN.sbjCh;
    dCh.sz(ch) = 12;
    dCh.col(ch,1:3) = [0.753,0.004,0.133];
    hemN = [nnz(xN.hem=="L") nnz(xN.hem=="R")];
    %dCh.order = dCh.ch;
    %dCh.order(ch) = Inf;
    %dCh = sortrows(dCh,'order','ascend');
end
dCh(ismember(dCh.pialRAS(:,1),[0 nan]),:) = [];

%% Initialize figure
if ~oP.save
    h = figure('Position',[0 0 1920 1080],'color','white','MenuBar','none','ToolBar','none');
else
    h = figure('Position',[0 0 1920 1080],'color','white','MenuBar','none','ToolBar','none','Visible','off');
end
hl = tiledlayout(h,4,6,'TileSpacing','compact','Padding','tight');

%% Plot lateral electrodes on native cortex
if nnz(hemN)>1
    plotCortex_lfn(nexttile,dCh(ismember(dCh.lat,["lateral" "both"]) & dCh.hem=="L",:),...
        "latero-anterior","pialRAS","pial",sbj,oP);

    plotCortex_lfn(nexttile,dCh(ismember(dCh.lat,["lateral" "both"]) & dCh.hem=="R",:),...
        "latero-anterior","pialRAS","pial",sbj,oP);
else
    plotCortex_lfn(nexttile([1 2]),dCh(ismember(dCh.lat,["lateral" "both"]),:),...
        "lateral","pialRAS","pial",sbj,oP);
end

%% Plot medial electrodes on native cortex
if nnz(hemN)>1
    plotCortex_lfn(nexttile,dCh(ismember(dCh.lat,["medial" "both"]) & dCh.hem=="L",:),...
        "medio-posterior","pialRAS","pial",sbj,oP);

    plotCortex_lfn(nexttile,dCh(ismember(dCh.lat,["medial" "both"]) & dCh.hem=="R",:), ...
        "medio-posterior","pialRAS","pial",sbj,oP);
else
    plotCortex_lfn(nexttile([1 2]),dCh(ismember(dCh.lat,["medial" "both"]),:),...
        "medial","pialRAS","pial",sbj,oP);
end

%% Legends

% Z-score colorbar
nexttile;
colormap(flip(cbrewer2('RdBu'))); clim(oP.clim);
lgd = colorbar(gca,"west","FontSize",oP.textsize+4); lgd.Label.String = "Z-score"; hold on
% Conditions
for c = 1:nConds
    plot(0,0,'o','Color',oP.col(c,:),'LineWidth',8);
end
lgd = legend(conds2,"FontSize",oP.textsize+4,"Location","east");
lgd.AutoUpdate='off'; title(lgd,"Condition"); axis off; hold off;


nexttile;
if a.ICA
    text(.5,.5,sbjCh+" ("+xN.ic+")",Interpreter='none',FontSize=20,Units='normalized',...
        HorizontalAlignment='center');
else
    text(.5,.5,sbjCh,Interpreter='none',FontSize=20,Units='normalized',...
        HorizontalAlignment='center');
end
axis off;

%% Avg timecourses
for c = 1:height(B)
    % Stim-locked
    nexttile;
    plotTrialAvg_lfn(sc.ms{1},B.name(c),oP);
    set(gca,'FontSize',oP.textsize);
    title("Stim latency:  "+B.disp(c),'FontSize',oP.textsize+2);
    xlabel("Latency (ms)",'FontSize',oP.textsize+2);
    if c==1; ylabel("Magnitude (z-score)",'FontSize',oP.textsize);  end
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off

    % RT-locked
    nexttile;
    plotTrialAvg_lfn(sc.RT{1},B.name(c),oP);
    set(gca,'FontSize',oP.textsize);
    title("RT latency:  "+B.disp(c),'FontSize',oP.textsize+2);
    xlabel("RT - Latency (ms)",'FontSize',oP.textsize+2);
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off

    % Percent RT
    nexttile;
    plotTrialAvg_lfn(sc.pct{1},B.name(c),oP);
    set(gca,'FontSize',oP.textsize);
    title("RT percent:  "+B.disp(c),'FontSize',oP.textsize+2);
    xlabel("Latency/RT (%)",'FontSize',oP.textsize+2);
    hold on
    plot([0 0],ylim,'k-','LineWidth',oP.o1D.width);
    plot([100 100],ylim,'k-','LineWidth',oP.o1D.width);
    plot(xlim,[0 0],'k-','LineWidth',oP.o1D.width);
    hold off
end

%% HFB single-trial
for c = 1:nConds
    nexttile;
    plotSingleTrials_lfn(xhCh(:,trialNfo.cond==conds(c))',lats5,oP.textsize);
    clim(oP.clim);
    title(conds2(c)+" trials:  HFB",'FontSize',oP.textsize+2);
    if c==1; ylabel("Trials sorted by RT",'FontSize',oP.textsize+2); end
end

%% LFP single-trial
for c = 1:nConds
    nexttile;
    plotSingleTrials_lfn(xCh(:,trialNfo.cond==conds(c))',lats5,oP.textsize);
    clim(oP.clim);
    title(conds2(c)+" trials:  LFP",'FontSize',oP.textsize+2);
    if c==1; ylabel("Trials sorted by RT",'FontSize',oP.textsize+2); end
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





%% Stats Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make analysis template %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function anT = analysisTemplate_lfn(psy,trialNfo,n,o)
epoch=o.epoch5*n.fs; epochRT=o.epochRT*n.fs;
if epochRT(end)<=0; epochRT(2)=abs(epoch(1)); end
sz = numel(epoch(1):epoch(2));
szRT = numel(1:epochRT(2));

% Find last trials
lastTrials = nan(numel(n.runs),1);
for r = 1:numel(n.runs)
    lastTrials(r) = max(trialNfo.trialA(trialNfo.run==n.runs(r)));
end

% Pre-stimulus & peri-stimulus analysis frames
anT = psy(psy.trialA~=0|psy.latency<0,:);
anT(ismember(anT.postRT,lastTrials),:) = [];
anT.pre(anT.frame<0) = true;
anT.post(:) = false;

% Post-stimulus analysis frames
anPost = cell(height(trialNfo),1);
for t = 1:height(trialNfo)
    tr = trialNfo.trialA(t);
    run = trialNfo.run(t);
    iTr = psy.idx(psy.postRT==tr);
    iTrPost = numel(iTr);

    % Add missing time for target duration after RT
    szTr = numel(iTr);
    if szTr < szRT
        iTr = iTr(1) : iTr(1)+szRT; %-1;
    end

    % Add missing time for target trial duration
    szTr = numel(trialNfo.idxITI(t) : iTr(end));
    if szTr < sz
        iTr = iTr(1) : iTr(end)+(sz-szTr);
    end
    iTr(~ismember(iTr,psy.idx(psy.run==run))) = [];

    % Fill out
    anP = psy(iTr,:);
    anP.run(:) = run;
    anP.trialA(:) = tr;
    anP.cond(:) = trialNfo.cond(t);
    anP.RT(:) = trialNfo.RT(t);
    anP.postRT(:) = tr;
    anP.latency = anP.time - psy.time(trialNfo.idxStim(t));
    anP.frame = int16(anP.latency*n.fs);
    anP.pct = anP.latency - anP.latency(1) + 1/n.fs;
    anP.pct = anP.pct / anP.pct(iTrPost);
    % Copy to cell
    anPost{t} = anP;
end
% Concactenate trials
anPost = vertcat(anPost{:});
anPost.pre(:) = false;
anPost.post(:) = true;
anPost.BLpre(:) = 0;
anPost.pct = anPost.pct/2;
anPost.pct = anPost.pct+1;

%% Combine analysis timepoints
anT = [anT; anPost];

% Sort & make indices
anT = sortrows(anT,{'trialA','latency'},'ascend');
anT.iPsy = anT.idx;
anT.idx = uint32(1:height(anT))';

%% Edits
anT.latency = round(anT.latency*1000); %int32(round(anT.latency*1000));
anT.RT = round(anT.RT*1000);
anT.condC = categorical(anT.cond,o.conds,'Ordinal',true);

% Optimize pcts
anT.pct = ceil(anT.pct*100);
anT.pct2 = ceil(anT.pct/2)*2; % pct2

% Latency-RT
for t = 1:height(trialNfo)
    tr = trialNfo.trialA(t);
    iTr = anT.trialA==tr;
    RThz = round(psy.latency(trialNfo.idxRT(t))*1000);
    anT.latRT(iTr) = anT.latency(iTr) - RThz;
end

% Bin & binRT
binP = floor(1000*o.binP);
anT.bin = floor(anT.latency/binP)*binP;
anT.binRT = floor(anT.latRT/binP)*binP;

% Convert
anT.latency = int32(anT.latency);
anT.latRT = int32(anT.latRT);
anT.bin = int16(anT.bin);
anT.binRT = int16(anT.binRT);
anT.pct = int16(anT.pct);
anT.pct2 = int16(anT.pct2);
%anT.RT = uint16(anT.RT);
anT = movevars(anT, ["latRT" "bin" "binRT" "pct" "pct2" "RT"], "After","latency");

disp(['Made analysis template: ' n.sbj]);
% % Get latency bins
% bn = floor(o.timeBins*n.fs);
% anT.bin = floor(anT.latency/bn)*bn;
% latBins = groupcounts(anT,["cond" "bin"]);
%
% % binP
% b2 = o.binP;
% binP = anT.bin(anT.post);
% binP = floor(binP./b2)*b2;
% while numel(unique(binP)) > o.binP_max
%     b2 = b2 + 50;
%     binP = floor(binP./b2)*b2;
% end
% anT.binP = floor(anT.bin/b2)*b2;
% anT.binP = int16(anT.binP);
% anT.bin = int16(anT.bin);
end



% Baseline correct/denoise/lowpass/downsample %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xa,na] = blcFiltClean_lfn(xa,na,psy,anT,trialNfo,o)
sbj = na.sbj;
blocks = string(na.blocks);
runs = na.runs;
nRuns = numel(runs);
nChs = size(xa,2);
fs = na.fs;
fsTarg = o.fsTarg;
ds = floor(fs/fsTarg);
badFields = o.badFields;
missingInterp = o.missingInterp;
thrOL = o.thrOL;
thrOLbl = o.thrOLbl;
conds = o.conds;
detrendOrder = o.detrendOrder;
detrendWin = o.detrendWin * fs;
detrendItr = o.detrendItr;
detrendThr = o.detrendThr;
d3 = numel(size(xa))==3;
runIdx = grpstats(psy,"run",["min" "max"],"DataVars","idx"); % Get run indices
runIdx = sortrows(runIdx,["min_idx" "max_idx"],"ascend");
nWorkers = gcp('nocreate').NumWorkers;
%nTrs = na.nTrials;
%trialA = trialNfo.trialA;
%trialAT = anT.trialA;
%pre = anT.pre;
%condT = anT.cond;
%stim = anT.stim;

% Separate non-trial frames at start vs. end of each run
psy.trialR = int32(psy.trialA);
for r = 1:nRuns
    run = runs(r);
    thr = min(trialNfo.idxITI(trialNfo.run==run));
    idx = psy.run==run & psy.trialR==0 & psy.idx<=thr;
    psy.trialR(idx) = -1;

    thr = max(trialNfo.idxITI(trialNfo.run==run));
    idx = psy.run==run & psy.trialR==0 & psy.idx>=thr;
    psy.trialR(idx) = Inf;
end
trIdx = grpstats(psy,["run" "trialR"],["min" "max"],"DataVars","idx"); % trial indices
trIdx = sortrows(trIdx,["min_idx" "max_idx"],"ascend");
if any(diff(trIdx.min_idx)<1) || any(diff(trIdx.max_idx)<1)
    warning("psy.trialR frame idx NOT sequentially increasing: "+sbj);
end

% Prepare filters
hiPassHz=0; loPassHz=0; %fHi=[]; fLo=[];
if o.hiPass>0 %&& contains(na.suffix,"s"|"h")
    hiPassHz = o.hiPass;
end
if o.loPass>0 && ~(ds>1 && o.loPass>fsTarg/2) % Antialias if LPF over nyquist frequency
    loPassHz = o.loPass;
    gusSz = floor(fs/loPassHz);
    gusWin = gausswin(gusSz)/sum(gausswin(gusSz));
end
% [~,r] = min(runIdx.GroupCount);
% idx = psy.run==runIdx.run(r) & ~isnan(xa(:,1,1));
% % Remove frames excluded from ICA decomposition
% if na.ICA
%     if numel(na.chICA_badFrames)~=height(xa)
%         [ds1,ds2] = rat(fs/na.fs_orig);
%         na.chICA_badFrames = double(full(na.chICA_badFrames));
%         na.chICA_badFrames = resample(na.chICA_badFrames,ds1,ds2) > 0.5;
%     end
%     xa(na.chICA_badFrames,:,:) = nan;
%     disp("Removed excluded ICA frames: "+sbj);
% end

% Remove bad frames
if ~isempty(badFields)
    x_bad = na.badFrames;
    parfor ch = 1:nChs
        xCh = squeeze(xa(:,ch,:)); % load chan data
        badIdxCh = x_bad(ch,:);
        badIdxCh = badIdxCh(1,badFields);
        badIdxCh = varfun(@rot90,badIdxCh);
        badIdxCh = any(badIdxCh{:,:},2);
        xCh(badIdxCh,:) = nan;
        xa(:,ch,:) = xCh; % Copy back processed data
    end
    disp("Removed bad frames: "+sbj);
end


%% High-pass filtering
[ds1,ds2] = rat(fsTarg/fs); % downsampling factors
xa = mat2cell(xa,runIdx.GroupCount); % Slice by run
for r = 1:nRuns
    % Interpolate missing frames
    xa{r} = fillmissing(double(xa{r}),missingInterp,1);
    disp("Interpolated missing frames: "+blocks(r));

    % Initial z-score
    xa{r} = normalize(xa{r},1,"zscore","robust");

    % HPF (within-run to avoid edge artifacts) -- robust detrending is better alternative
    if hiPassHz>0 && ~(any(detrendOrder>0) && ~d3)
        [~,fHi] = highpass(xa{r}(:,1,1),hiPassHz,fs);
        if d3
            for ch = 1:nChs
                xa{r}(:,ch,:) = fHi.filtfilt(gpuArray(squeeze(xa{r}(:,ch,:))));
            end
        else
            xa{r} = gather(fHi.filtfilt(gpuArray(xa{r})));
        end
        disp("High-passed: "+blocks(r));
    end
end
xa = vertcat(xa{:});

%% Robust polynomial detrending

% First robust detrend (within-trial)
if any(detrendOrder>0) && detrendOrder(1)>0 && ~d3 && contains(na.suffix,"s"|"h")
    detrendWts=cell(height(trIdx),1);
    xa = mat2cell(xa,trIdx.GroupCount); % Slice by trial
    parfor t = 1:height(xa)
        [xa{t},detrendWts{t}] = KT_detrend(xa{t},detrendOrder(1),[],'polynomials',...
            detrendThr,detrendItr,detrendWin); %#ok<PFBNS>
    end
    detrendWts=vertcat(detrendWts{:});
    disp("Robust polynomial detrended^"+detrendOrder(1)+" (trialwise): "+sbj);
else
    detrendWts = ones(size(xa));
end

% Second robust detrend (within-run chunks)
xa = mat2cell(xa,runIdx.GroupCount);
detrendWts = mat2cell(detrendWts,runIdx.GroupCount);
if numel(detrendOrder)>1 && detrendOrder(2)>0 && ~d3 && contains(na.suffix,"s"|"h")
    for r = 1:nRuns
        xr = xa{r};
        % Slice into number of threadpool workers
        idx = diff(1: floor(height(xr)/nWorkers) : height(xr)); % Slice
        idx(end) = idx(end) + (height(xr)-sum(idx));
        xr = mat2cell(xr,idx);
        dWts = mat2cell(detrendWts{r},idx);

        % Detrend across numWorkers slices
        parfor c = 1:nWorkers
            [xr{c},dWts{c}] = KT_detrend(xr{c},detrendOrder(2),dWts{c},'polynomials',...
                detrendThr,detrendItr,detrendWin); %#ok<PFBNS>
        end
        xa{r} = vertcat(xr{:}); detrendWts{r} = vertcat(dWts{:});
        disp("Robust polynomial detrended^"+detrendOrder(2)+": "+blocks(r));
    end
end

%% Outliers, low-pass filter & downsampling (within-run)
parfor r = 1:nRuns
    xr = xa{r};
    % Outliers per cond
    if thrOL>0
        idr = psy.idx(psy.run==runs(r)); %#ok<PFBNS>
        for c = 1:numel(conds)
            idx = psy.cond(idr)==conds(c) & ~psy.stim(idr);
            xr(idx,:,:) = filloutliers(xr(idx,:,:),"clip","median",1,ThresholdFactor=thrOLbl);
            bl = median(xr(idx,:,:),1,"omitnan");
            idx = psy.cond(idr)==conds(c);
            xr(idx,:,:) = filloutliers(xr(idx,:,:),nan,"median",1,ThresholdFactor=thrOL);
            xr = fillmissing(xr,missingInterp,1); % Linear interpolation
            xr(idx,:,:) = xr(idx,:,:) - bl; % Center at avg condition baseline
        end
        disp("Interpolated outliers per condition: "+blocks(r));
    end

    % Low-pass filter
    if loPassHz>0
        %[~,fLo] = lowpass(xr(:,1,1),loPassHz,fs); xr = fLo.filtfilt(xr);
        xr = convn(xr,gusWin,'same'); % convolve gaussian
        disp("Low-passed: "+blocks(r));
    end

    % Downsample
    if ds>1
        if ~loPassHz
            xr = resample(xr,ds1,ds2); % Antialiased downampling if LPF>nyquist or LPF==0
        else
            xr = xr(1:ds:end,:); % Decimate if LPF <= nyquist freq
        end
        disp("Downsampled: "+blocks(r));
    end
    xa{r} = xr;
end

%% Robust baseline correction
trIdx = grpstats(anT,["run" "trialA"],["min" "max"],"DataVars","idx"); % trial indices
trIdx = sortrows(trIdx,["min_idx" "max_idx"],"ascend");
if any(diff(trIdx.min_idx)<1) || any(diff(trIdx.max_idx)<1)
    warning("psy.trialR frame idx NOT sequentially increasing: "+sbj);
end

% Slice by trial
if numel(detrendOrder)>=2 && detrendOrder(2)>0
    detrendWts=vertcat(detrendWts{:}); detrendWts=detrendWts(anT.iPsy,:,:);
    detrendWts = mat2cell(detrendWts,trIdx.GroupCount);
else
    detrendWts = cell(height(trIdx),1);
end
xa=vertcat(xa{:}); xa=xa(anT.iPsy,:,:); % Match xs & anT indices
xa = mat2cell(xa,trIdx.GroupCount);
anT = mat2cell(anT,trIdx.GroupCount);

% Parfor across trials
parfor t = 1:height(trIdx)
    xt = xa{t};
    % Robust z-score (within-trial)
    xt = fillmissing(xt,missingInterp,1); % Interpolate missing
    xt = normalize(xt,1,"zscore","robust"); % Median Absolute Deviation

    % Final detrend (within-trial)
    if numel(detrendOrder)>=3 && detrendOrder(3)>0
        [xt,detrendWts{t}] = KT_detrend(xt,detrendOrder(3),detrendWts{t},...
            'polynomials',detrendThr,detrendItr,detrendWin);
    end

    % Baseline correction (within-trial)
    bl = median(xt(anT{t}.pre,:,:),1,"omitnan"); % Trial baseline (median so outlier-resistant)
    xt = xt - bl; % Subtract trial frames by baseline
    xa{t} = xt;
end
disp("Robust z-scored (trialwise): "+sbj);
if numel(detrendOrder)>=3 && detrendOrder(3)>0; disp("Final polynomial detrended^"+detrendOrder(3)+" (trialwise): "+sbj); end

% Interpolate baseline outliers & center at baseline mean (within-condition)
xa=vertcat(xa{:}); anT=vertcat(anT{:}); detrendWts=vertcat(detrendWts{:});
na.detrendWts = sparse(detrendWts);
for c = 1:numel(conds)
    idx = anT.cond==conds(c) & anT.pre;
    %xa(idx,:) = filloutliers(xa(idx,:),"clip","median",1,...
    %    ThresholdFactor=thrOLbl); % Baseline outliers
    bl = mean(xa(idx,:),1,"omitnan"); % Cleaned baseline mean
    idx = anT.cond==conds(c);
    xa(idx,:) = xa(idx,:) - bl; % Subtract by baseline mean
end
disp("FINISHED baseline correction: "+sbj);
end



% Summary stats for multiple freqs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ss = statsSpec_lfn(xs,ns,sbjChs,anT,B,o)
sbj = ns.sbj;
sbjID = ns.sbjID;
nChs = size(xs,2);
%fs = ns.fs;
%conds = o.conds;
B(cellfun(@isempty,B.freqs),:) = [];
doICA = ns.ICA;
if doICA; chNames = ns.icNfo.name; else; chNames=[]; end
if isfield(o,'epoch'); epoch=round(o.epoch*1000); else; epoch=[]; end
if isfield(o,'epochRT'); epochRT=round(o.epochRT*1000); else; epochRT=[]; end
if isfield(o,'epochPct'); epochPct=round(o.epochPct*100); else; epochPct=[]; end

% Calculate stats
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
        idx = anCh.bin>=epoch(1) & anCh.bin<=epoch(2);

        % All frequencies
        sl = grpstats(anCh(idx,:),["condC" "bin"],"mean","DataVars",["latency" "x"]);
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"mean_","");
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"GroupCount","N");
        sl.Properties.VariableNames("condC")="cond"; sl.cond=string(sl.cond);
        sl.latency = int32(sl.latency);
        sl.N = uint16(sl.N);
        sl.sbjCh(:) = sbjChs(ch);
        sl.Properties.RowNames = sl.sbjCh+"_"+sl.cond+"_"+sl.bin;
        sl = movevars(sl,"sbjCh","Before","cond");

        % Reconstruct frequency band timecourses
        for b = 1:height(B)
            band = B.name(b);
            idb = B.id(b,:);
            anCh.(band)(idx) = mean(anCh.x(idx,idb),2,'omitnan');
        end
        anCh.x = [];

        % Frequency bands
        sl2 = grpstats(anCh(idx,:),["condC" "bin"],["mean" "sem"],"DataVars",B.name);
        sl2.Properties.VariableNames = strrep(sl2.Properties.VariableNames,"mean_","");
        sl2.Properties.VariableNames = strrep(sl2.Properties.VariableNames,"sem_","SE_");
        sl2.condC=[]; sl2.bin=[]; sl2.GroupCount=[]; sl2.Properties.RowNames={};
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
        idx = anCh.pct2>=epochPct(1) & anCh.binRT<=epochPct(2);
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



% Summary stats for single freq/timecourse %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ss = statsBand_lfn(xa,na,sbjChs,anT,band,o,ss)
sbj = na.sbj;
sbjID = na.sbjID;
nChs = size(xa,2);
if isfield(o,'epoch'); epoch=round(o.epoch*1000); else; epoch=[]; end
if isfield(o,'epochRT'); epochRT=round(o.epochRT*1000); else; epochRT=[]; end
if isfield(o,'epochPct'); epochPct=round(o.epochPct*100); else; epochPct=[]; end
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
        sl = grpstats(anCh,["condC" "bin"],["mean" "sem"],"DataVars",["latency" "x"]);
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"_x","_"+band);
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"mean_","");
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"sem_","SE_");
        sl.Properties.VariableNames = strrep(sl.Properties.VariableNames,"GroupCount","N");
        sl.Properties.VariableNames("condC")="cond"; sl.cond=string(sl.cond);
        sl.latency = int32(sl.latency);
        sl.N = uint16(sl.N);
        sl.sbjCh(:) = sbjChs(ch);
        sl.Properties.RowNames = sl.sbjCh+"_"+sl.cond+"_"+sl.bin;
        sl = movevars(sl,"sbjCh","Before","cond");
        sl.SE_latency = [];
        % Remove frames outside of epoch
        sl(sl.bin<epoch(1) | sl.bin>epoch(2),:) = [];
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
        sr = grpstats(anCh,["condC" "binRT"],["mean" "sem"],"DataVars","x");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"_x","_"+band);
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"mean_","");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"sem_","SE_");
        sr.Properties.VariableNames = strrep(sr.Properties.VariableNames,"GroupCount","N");
        sr.Properties.VariableNames("condC")="cond"; sr.cond=string(sr.cond);
        sr.N = uint16(sr.N);
        sr.sbjCh(:) = sbjChs(ch);
        sr.Properties.RowNames = sr.sbjCh+"_"+sr.cond+"_"+sr.binRT;
        sr = movevars(sr,"sbjCh","Before","cond");
        % Remove frames outside of epoch
        sr(sr.binRT<epochRT(1) | sr.binRT>epochRT(2),:) = [];
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
        sp = grpstats(anCh,["condC" "pct2"],["mean" "sem"],"DataVars","x");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"_x","_"+band);
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"mean_","");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"sem_","SE_");
        sp.Properties.VariableNames = strrep(sp.Properties.VariableNames,"GroupCount","N");
        sp.Properties.VariableNames("condC")="cond"; sp.cond=string(sp.cond);
        sp.N = uint16(sp.N);
        sp.sbjCh(:) = sbjChs(ch);
        sp.Properties.RowNames = sp.sbjCh+"_"+sp.cond+"_"+sp.pct2;
        sp = movevars(sp,"sbjCh","Before","cond");
        % Remove frames outside of epoch
        sp(sp.pct2<epochPct(1) | sp.pct2>epochPct(2),:) = [];
        % Copy to permanent table
        if any(fieldnames(ssCh)=="pct")
            ssCh.pct.(band) = sp.(band);
            ssCh.pct.("SE_"+band) = sp.("SE_"+band);
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

% Plot cortex %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotCortex_lfn(h,dCh,lat,coord,surf,sbj,oP)
dCh.pos = dCh.(coord);
ec_plotCortex(unique(dCh.hem),lat,dCh,sbj=sbj,sbjDir=oP.dirFS,surfType=surf,...
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
function plotTrialAvg_lfn(dat,band,oP)
warning('off','MATLAB:Figure:UnableToSetRendererToOpenGL');
nConds = numel(oP.conds);

lats = unique(dat.latency)';
lats = repmat(lats,nConds,1);
y = nan(nConds,length(lats));
ySE = y;
%ySig = y;
for c = 1:nConds
    cond = oP.conds(c);
    idxP = ismember(dat.latency,lats(c,:)) & dat.cond==cond;
    idx = ismember(lats(c,:),dat.latency(idxP));
    y(c,idx) = dat.(band)(idxP)';
    ySE(c,idx) = dat.("SE_"+band)(idxP)';
end
mseb(lats,y,ySE,oP.o1D,1); axis tight
set(gca,'fontsize',oP.textsize);
end

