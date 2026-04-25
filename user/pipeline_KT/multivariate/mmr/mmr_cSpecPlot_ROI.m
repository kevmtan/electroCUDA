function mmr_cSpecPlot_ROI(analDir,op)
% analDir = "/01/lbcn/anal/classifySpecROI/MzAb_LDA_band_260421_1255/"

% Analysis Directory
op.analDir = analDir; % "/" at end!

% Fig directory
op.figDir = op.analDir+"figs/";


%% Create parallel pool (must be processes, can't be threadpool)
%try delete(gcp("nocreate")); catch;end
%try ppool = parpool("local12"); catch;end


%% Prep
load(op.analDir+"stat.mat","stat"); % load stat
ROIs = unique(stat.roi); % list ROIs
try mkdir(op.figDir); catch; end % make figure dir


%% Make ROI figs
for roi = ROIs'
    id = stat.roi==roi;
    plotROI_lfn(stat(id,:),op);
end






%% Plot function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotROI_lfn(stc,op)
% str = stat(stat.roi=="PCC",:);
roi = string(stc.roi(1));


%% Initialize figure
h = figure(Position=[0 0 op.res],Visible=op.visible,WindowStyle="normal",...
    Theme="light",Color="w");

% Initialize tiledlayout
ht = tiledlayout(h,2,3,TileSpacing="compact",padding="tight"); % tiledlayout

% Title
if op.txtSzTitle
    title(ht,roi,FontSize=op.txtSzTitle,Color=op.txtCol,FontWeight="bold");
end


%% Accuracy (binomial exact)
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


%% Accuracy (logistic mixed-effects)
y = stc.accl;
ySE = stc.accl_SE;
ySig = y;
ySig(~(stc.accl_q<op.sigThr)) = nan;

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
if op.txtSz
    title(ha,"Accuracy (nested)",...
        FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
end

% Timecourses & error
mseb(stc.t',y',ySE',op.a,1);
hold on; axis tight;

% Sig timepoints
plot(stc.t,ySig,".-",Color=op.a.col{1},MarkerFaceColor=op.a.col{1},LineWidth=op.a.wSig);
plot(xlim,[0.5 0.5],"k-","LineWidth",op.a.wSig);
plot([0 0],ylim,"k-","LineWidth",op.a.wSig);


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


%% Save fig
fn = op.figDir+roi+".jpg";
print(h,fn,"-djpeg","-r150");
disp("SAVED: "+fn);
delete(h);