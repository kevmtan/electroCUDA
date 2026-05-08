function mmr_cSpecPlot_ch(n,o,op)
arguments
    n struct
    o struct
    op struct
end


%% Initialize
tic;

% Load
fnStats = o.dirOut+"s"+n.sbjID+"_st.mat";
load(fnStats,"st");

% Save dir
if ~isfield(o,"dirOutSbj")
    o.dirOutSbj = o.dirOut+"s"+n.sbjID+filesep; end
if ~exist(o.dirOutSbj,"dir")
    mkdir(o.dirOutSbj); end

% Rename table vars to standard names
st = renamevars(st,o.p.timeVar,"t");
chNfo = renamevars(n.chNfo,op.posVar,"pos"); 

% Plot data table template (see 'd' vars in 'ec_plotCortex')
d0 = chNfo(:,["sbjCh" "ch" "pos" "hem" "lat" "gyrus" "ECoG"]);
d0.marker(:) = op.nsMark(:); % marker shape/line style (string) -- see LineStyle in MATLAB line properties
d0.col = repmat(op.nsCol,height(d0),1); % marker face color (numeric): [R G B]  -- see MarkerFaceColor in MATLAB line properties
d0.bCol = repmat(op.bCol,height(d0),1); % marker border color (numeric): [R G B] -- see MarkerEdgeColor in MATLAB line properties)
d0.sz(:) = op.nsSz; % marker size (numeric) -- see MarkerSize in MATLAB line properties
d0.bSz(:) = op.bSz; % marker border/line size (numeric) --- see plot.LineSize in MATLAB line properties
d0.order(:) = -inf;

% Split stats by chan for parfor
st = splitapply(@(ch){st(ch,:)},(1:height(st))',findgroups(st.ch));
disp("[mmr_cChSpecPlot] Finished prep: "+n.sbj+" toc="+toc);


%% Loop across chans
parfor ch = 1:height(st)
    plotCh_lfn(st{ch},d0,n,o,op)
end





function plotCh_lfn(stc,d,n,o,op)
%% Plot channel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ch=71; stc=st{ch}; d=d0;

% Channel 
sbjCh = stc.sbjCh(1);
c = d.sbjCh==sbjCh; % chan index
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
ht = tiledlayout(h,2,4,TileSpacing="compact",padding="tight"); % tiledlayout

% Title
if op.txtSzTitle
    title(ht,replace(sbjCh,"_"," "),FontSize=op.txtSzTitle,Color=op.txtCol,FontWeight="bold");
end



%% Plot cortex
ha = nexttile(ht,[1 2]);
ec_plotCortex(hem,["lateral","medial"],d,ht,sbj=n.sbj,sbjDir=n.dirs.fsSbj,......
    surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.visible,...
    flip=false,order="ascend",align=op.align,tile=tilenum(ha),tilespan=[1 2]);
ha.Visible="off";
%axis(ha,"tight"); axis(ha,"equal");


%% PP per cond
y = [stc.ppc stc.ppxc];
ySE = [stc.ppc_SE stc.ppxc_SE];
ySig = y;
ySig(~(stc.ppc_q(:,1)<op.sigThr),1) = nan; % semantic
ySig(~(stc.ppc_q(:,2)<op.sigThr),2) = nan; % episodic
ySig(~(stc.ppxc_q(:,1)<op.sigThr),3) = nan; % self
ySig(~(stc.ppxc_q(:,2)<op.sigThr),4) = nan; % other

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
if op.txtSz
    title(ha,"Posterior Probability (PP)",...
        FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
end

% Timecourses & error
mseb(stc.t',y',ySE',op.c,1);
hold on; axis tight;

% Plot sig timepoints
plot(stc.t,ySig(:,1),".-",Color=op.c.col{1},MarkerFaceColor=op.c.col{1},LineWidth=op.c.wSig);
plot(stc.t,ySig(:,2),".-",Color=op.c.col{2},MarkerFaceColor=op.c.col{2},LineWidth=op.c.wSig);
plot(stc.t,ySig(:,3),".-",Color=op.c.col{3},MarkerFaceColor=op.c.col{3},LineWidth=op.c.wSig);
plot(stc.t,ySig(:,4),".-",Color=op.c.col{4},MarkerFaceColor=op.c.col{4},LineWidth=op.c.wSig);
plot(xlim,[0 0],"k-","LineWidth",op.c.wSig);
plot([0 0],ylim,"k-","LineWidth",op.c.wSig);


%% PP cond difference
y = [stc.ppc1 stc.ppxc1];
ySE = [stc.ppc1_SE stc.ppxc1_SE];
ySig = y;
ySig(~(stc.ppc1_q<op.sigThr),1) = nan; % Episodic-Semantic
ySig(~(stc.ppxc1_q<op.sigThr),2) = nan; % Other-Self

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
if op.txtSz
    title(ha,"PP Cond Diff",...
        FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
end

% Timecourses & error
mseb(stc.t',y',ySE',op.d,1);
hold on; axis tight;

% Plot sig timepoints
plot(stc.t,ySig(:,1),".-",Color=op.d.col{1},MarkerFaceColor=op.d.col{1},LineWidth=op.d.wSig);
plot(stc.t,ySig(:,2),".-",Color=op.d.col{2},MarkerFaceColor=op.d.col{2},LineWidth=op.d.wSig);
plot(xlim,[0 0],"k-","LineWidth",op.d.wSig);
plot([0 0],ylim,"k-","LineWidth",op.d.wSig);


%% Autobio PP regression: RT & RC
y = [stc.ppr_RT,stc.ppr_RC];
ySE = [stc.ppr_RT_SE,stc.ppr_RC_SE];
ySig = y;
ySig(~(stc.ppr_RT_q<op.sigThr),1) = nan;
ySig(~(stc.ppr_RC_q<op.sigThr),2) = nan;

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
if op.txtSz
    title(ha,"Autobio PP Regression",...
        FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
end

% Timecourses & error
mseb(stc.t',y',ySE',op.r,1);
hold on; axis tight;

% Plot sig timepoints
plot(stc.t,ySig(:,1),".-",Color=op.r.col{1},MarkerFaceColor=op.r.col{1},LineWidth=op.r.wSig);
plot(stc.t,ySig(:,2),".-",Color=op.r.col{2},MarkerFaceColor=op.r.col{2},LineWidth=op.r.wSig);
plot(xlim,[0 0],"k-","LineWidth",op.r.wSig);
plot([0 0],ylim,"k-","LineWidth",op.r.wSig);


%% Mentalizing (CC) PP regression: RT, RC & valence
y = [stc.ppxr_RT,stc.ppxr_RC,stc.ppxr_val];
ySE = [stc.ppxr_RT_SE,stc.ppxr_RC_SE,stc.ppxr_val_SE];
ySig = y;
ySig(~(stc.ppxr_RT_q<op.sigThr),1) = nan;
ySig(~(stc.ppxr_RC_q<op.sigThr),2) = nan;
ySig(~(stc.ppxr_val_q<op.sigThr),3) = nan;

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
if op.txtSz
    title(ha,"Mentalizing PP Regression",...
        FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
end

% Timecourses & error
mseb(stc.t',y',ySE',op.r,1);
hold on; axis tight;

% Plot sig timepoints
plot(stc.t,ySig(:,1),".-",Color=op.r.col{1},MarkerFaceColor=op.r.col{1},LineWidth=op.r.wSig);
plot(stc.t,ySig(:,2),".-",Color=op.r.col{2},MarkerFaceColor=op.r.col{2},LineWidth=op.r.wSig);
plot(stc.t,ySig(:,3),".-",Color=op.r.col{3},MarkerFaceColor=op.r.col{3},LineWidth=op.r.wSig);
plot(xlim,[0 0],"k-","LineWidth",op.r.wSig);
plot([0 0],ylim,"k-","LineWidth",op.r.wSig);


%% Accuracy
y = stc.acc;
ySE = stc.acc_SE;
ySig = y;
ySig(~(stc.acc_q<op.sigThr)) = nan;

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
if op.txtSz
    title(ha,"Accuracy",...
        FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
end

% Timecourses & error
mseb(stc.t',y',ySE',op.a,1);
hold on; axis tight;

% Sig timepoints
plot(stc.t,ySig,".-",Color=op.a.col{1},MarkerFaceColor=op.a.col{1},LineWidth=op.a.wSig);
plot(xlim,[0.5 0.5],"k-","LineWidth",op.a.wSig);
plot([0 0],ylim,"k-","LineWidth",op.a.wSig);


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