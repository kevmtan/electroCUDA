function mmr_cChSpecPlot(o,op)
arguments
    o struct
    op struct
end

%% Initialize
tic;

% Load
fnStats = o.dirOut+"s"+o.n.sbjID+"_stats.mat";
load(fnStats,"stats");

% Save dir
if ~isfield(o,"dirOutSbj")
    o.dirOutSbj = o.dirOut+"s"+o.n.sbjID+filesep; end
if ~exist(o.dirOutSbj,"dir")
    mkdir(o.dirOutSbj); end

% Rename table vars to standard names
stats = renamevars(stats,o.timeVar,"t");
chNfo = renamevars(o.n.chNfo,op.posVar,"pos"); 

% Plot data table template (see 'd' vars in 'ec_plotCortex')
d0 = chNfo(:,["sbjCh" "ch" "pos" "hem" "lat" "gyrus" "ECoG"]);
d0.marker(:) = op.nsMark(:); % marker shape/line style (string) -- see LineStyle in MATLAB line properties
d0.col = repmat(op.nsCol,height(d0),1); % marker face color (numeric): [R G B]  -- see MarkerFaceColor in MATLAB line properties
d0.bCol = repmat(op.bCol,height(d0),1); % marker border color (numeric): [R G B] -- see MarkerEdgeColor in MATLAB line properties)
d0.sz(:) = op.nsSz; % marker size (numeric) -- see MarkerSize in MATLAB line properties
d0.bSz(:) = op.bSz; % marker border/line size (numeric) --- see plot.LineSize in MATLAB line properties
d0.order(:) = -inf;

% Split obs by chan & timept (output from unique models) for parfor
stats = splitapply(@(ct){stats(ct,:)},(1:height(stats))',findgroups(stats.ch));
disp("[mmr_cChSpecPlot] Finished prep: "+o.n.sbj+" toc="+toc);


%% Loop across chans
parfor ch = 1:height(stats)
    plotCh_lfn(stats{ch},d0,o,op)
end





function plotCh_lfn(st,d,o,op)
%% Plot channel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ch=71; st=stats{ch}; d=d0;
od = op.od;
odc = op.odc;
odc1 = op.odc1;
odr = op.odr;

% Channel 
sbjCh = st.sbjCh(1);
c = d.sbjCh==sbjCh;
hem = d.hem(c);
if ~ismember(hem,["L" "R"])
    hem = ["L" "R"]; end %unique(d.hem(~isnan(d.pos(:,1)))); end

% Mark channel
d.marker(c) = op.marker;
d.col(c,:) = op.markCol;
d.sz(c) = op.markSz;


%% Initialize figure
h = figure(Position=[0 0 op.res],Visible=op.visible,WindowStyle="normal",...
        Theme="light",Color="w");

% Initialize tiledlayout
ht = tiledlayout(h,3,2,TileSpacing="compact",padding="tight"); % tiledlayout

% Title
if any(op.txtSz)
    title(ht,replace(sbjCh,"_"," "),FontSize=op.txtSz,FontWeight="bold"); end


%% Plot cortex
ha = nexttile(ht,[1 2]);
ec_plotCortex(hem,["lateral","medial"],d,ht,sbj=o.n.sbj,sbjDir=o.dirs.fsSbj,......
    surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.visible,...
    flip=false,order="ascend",align=op.align,tile=tilenum(ha),tilespan=[1 2]);
ha.Visible="off";
%axis(ha,"tight"); axis(ha,"equal");


%% Accuracy
y = st.acc;
ySig = y;
ySig(~(st.acc_q<o.alpha) | st.t<0) = nan;

ha = nexttile(ht);
title(ha,"Accuracy",FontSize=op.txtSz);
ha.XLim = o.timeRng;
mseb(st.t',y',st.acc_SE',od,1);
hold on; axis tight;
plot(st.t,ySig,"-","Color",od.col{1},"LineWidth",od.wSig);
plot(xlim,[0.5 0.5],"k-","LineWidth",od.wSig);
plot([0 0],ylim,"k-","LineWidth",od.wSig);


%% PP per cond
y = [st.ppc,st.ppcx];
ySE = [st.ppc_SE,st.ppcx_SE];
ySig = y;
ySig(~(st.ppc_q(:,1)<o.alpha) | st.t<0,1) = nan; % semantic
ySig(~(st.ppc_q(:,2)<o.alpha) | st.t<0,2) = nan; % episodic
ySig(~(st.ppcx_q(:,1)<o.alpha) | st.t<0,3) = nan; % self
ySig(~(st.ppcx_q(:,2)<o.alpha) | st.t<0,4) = nan; % other

ha = nexttile(ht);
title(ha,"Posterior Probability",FontSize=op.txtSz);
ha.XLim = o.timeRng;
mseb(st.t',y',ySE',odc,1);
hold on; axis tight;
plot(st.t,ySig(:,1),"-","Color",odc.col{1},"LineWidth",odc.wSig);
plot(st.t,ySig(:,2),"-","Color",odc.col{2},"LineWidth",odc.wSig);
plot(st.t,ySig(:,3),"-","Color",odc.col{3},"LineWidth",odc.wSig);
plot(st.t,ySig(:,4),"-","Color",odc.col{4},"LineWidth",odc.wSig);
plot(xlim,[0 0],"k-","LineWidth",odc.wSig);
plot([0 0],ylim,"k-","LineWidth",odc.wSig);


%% RT/valence
y = [st.ppr_RT,st.ppr_val];
ySE = [st.ppr_RT_SE,st.ppr_val_SE];
ySig = y;
ySig(~(st.ppr_RT_q<o.alpha) | st.t<0,1) = nan;
ySig(~(st.ppr_val_q<o.alpha) | st.t<0,2) = nan;

ha = nexttile(ht);
title(ha,"Posterior Probability Regression",FontSize=op.txtSz);
ha.XLim = o.timeRng;
mseb(st.t',y',ySE',odr,1);
hold on; axis tight;
plot(st.t,ySig(:,1),"-","Color",odr.col{1},"LineWidth",odr.wSig);
plot(st.t,ySig(:,2),"-","Color",odr.col{2},"LineWidth",odr.wSig);
plot(xlim,[0 0],"k-","LineWidth",odr.wSig);
plot([0 0],ylim,"k-","LineWidth",odr.wSig);


%% PP cond difference
y = st.ppr_cx;
ySig = y;
ySig(~(st.ppr_cx_q<o.alpha) | st.t<0) = nan;

ha = nexttile(ht);
title(ha,"Posterior Probability (Other-Self)",FontSize=op.txtSz);
ha.XLim = o.timeRng;
mseb(st.t',y',st.ppr_cx_SE',odc1,1);
hold on; axis tight;
plot(st.t,ySig,"-","Color",odc1.col{1},"LineWidth",odc1.wSig);
plot(xlim,[0 0],"k-","LineWidth",odc1.wSig);
plot([0 0],ylim,"k-","LineWidth",odc1.wSig);


%% Save
fn = o.dirOutSbj+sbjCh+".jpg";
print(h,fn,"-djpeg","-r150");
disp("SAVED: "+fn);
delete(h);
%exportgraphics(h,fn,"Resolution",150);





% % Plot averaged timecourses %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function plotFrameAvg_lfn(dat,band,conds,oP)
% nConds = numel(conds);
% lats = unique(dat.latency)';
% lats = repmat(lats,nConds,1);
% y = nan(nConds,length(lats));
% ySE = y;
% %ySig = y;
% for c = 1:nConds
%     cond = conds(c);
%     idxP = ismember(dat.latency,lats(c,:)) & dat.cond==cond;
%     idx = ismember(lats(c,:),dat.latency(idxP));
%     y(c,idx) = dat.(band)(idxP)';
%     ySE(c,idx) = dat.("SE_"+band)(idxP)';
% end
% mseb(lats,y,ySE,od,1); axis tight
% set(gca,'fontsize',oP.textsize);


% sbjCh = "s42_ch61";
% 
% figure;
% plot(stats(stats.sbjCh==sbjCh,:),"bin",["acc" "auc1"]); legend(location="best");
% figure;
% plot(stats(stats.sbjCh==sbjCh,:),"bin",["pp1" "ppx1"]); legend(location="best");