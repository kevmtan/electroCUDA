op = struct;

% Analysis Directory
op.analDir = "/01/lbcn/anal/classifySpecROI/MzAb_SVM_260414_0745/";

% Fig directory
op.figDir = op.analDir+"figs/";

% Colors
load("cdcol_2018.mat","cdcol");


%% Options
op.visible = true; % !!!!!!!!!!
op.save = true; % !!!!!!!!!!!
op.sigThr = 0.05; % significance threshold

% Plot
op.res = [1280 720];
op.txtCol = [1 1 1]; % Text color: [R G B]
op.txtSz = 14; % text size
op.txtSzTitle = 16;
op.txtSzAx = 10;

% PP per cond
op.c = ecu_genPlotParams("ERP","MMR");
op.c.style= ':';
op.c.width = 0.5;
op.c.wSig = 2;
op.c.edgestyle = ':';
op.c.col = [cdcol.prussian_blue; cdcol.mauve; cdcol.pastel_blue; 0 0.75 0];
op.c.col = ec_dim2cell(op.c.col,1);

% Accuracy
op.a = op.c;
op.a.col = cdcol.spruce_green;
op.a.col = ec_dim2cell(op.a.col,1);

% PP cond difference
op.d = op.c;
op.d.col = [cdcol.blue,cdcol.peacock_green];
op.d.col = ec_dim2cell(op.d.col,1);

% PP RT/RC/valence
op.r = op.c;
op.r.col = [cdcol.blue; cdcol.empire_green; cdcol.indian_red];
op.r.col = ec_dim2cell(op.r.col,1);


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
function plotROI_lfn(str,op)
% str = stat(stat.roi=="PCC",:);
roi = str.roi(1);


%% Initialize figure
h = figure(Position=[0 0 op.res],Visible=op.visible,WindowStyle="normal",...
        Theme="light",Color="w");

% Initialize tiledlayout
ht = tiledlayout(h,2,3,TileSpacing="compact",padding="tight"); % tiledlayout

% Title
title(ht,roi,FontSize=op.txtSzTitle,FontWeight="bold");


%% Accuracy
y = str.acc;
ySig = y;
ySig(~(str.acc_q<op.sigThr)) = nan;

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
title(ha,"Accuracy",FontSize=op.txtSz);

% Timecourses & error
mseb(str.t',y',str.acc_SE',op.a,1);
hold on; axis tight;

% Sig timepoints
plot(str.t,ySig,"-","Color",op.a.col{1},"LineWidth",op.a.wSig);
plot(xlim,[0.5 0.5],"k-","LineWidth",op.a.wSig);
plot([0 0],ylim,"k-","LineWidth",op.a.wSig);


%% PP per cond
y = [str.ppc,str.ppxc];
ySE = [str.ppc_SE,str.ppxc_SE];
ySig = y;
ySig(~(str.ppc_q(:,1)<op.sigThr),1) = nan; % semantic
ySig(~(str.ppc_q(:,2)<op.sigThr),2) = nan; % episodic
ySig(~(str.ppxc_q(:,1)<op.sigThr),3) = nan; % self
ySig(~(str.ppxc_q(:,2)<op.sigThr),4) = nan; % other

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
title(ha,"Posterior Probability",FontSize=op.txtSz);

% Timecourses & error
mseb(str.t',y',ySE',op.c,1);
hold on; axis tight;

% Plot sig timepoints
plot(str.t,ySig(:,1),"-","Color",op.c.col{1},"LineWidth",op.c.wSig);
plot(str.t,ySig(:,2),"-","Color",op.c.col{2},"LineWidth",op.c.wSig);
plot(str.t,ySig(:,3),"-","Color",op.c.col{3},"LineWidth",op.c.wSig);
plot(str.t,ySig(:,4),"-","Color",op.c.col{4},"LineWidth",op.c.wSig);
plot(xlim,[0 0],"k-","LineWidth",op.c.wSig);
plot([0 0],ylim,"k-","LineWidth",op.c.wSig);


%% PP cond difference
y = str.ppr_cx;
ySig = y;
ySig(~(str.ppr_cx_q<op.sigThr)) = nan;

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
title(ha,"Posterior Probability (Other-Self)",FontSize=op.txtSz);

% Timecourses & error
mseb(str.t',y',str.ppr_cx_SE',odc1,1);
hold on; axis tight;

% Plot sig timepoints
plot(str.t,ySig,"-","Color",odc1.col{1},"LineWidth",odc1.wSig);
plot(xlim,[0 0],"k-","LineWidth",odc1.wSig);
plot([0 0],ylim,"k-","LineWidth",odc1.wSig);


%% Autobio PP regression: RT & RC
y = [str.ppr_RT,str.ppr_RC];
ySE = [str.ppr_RT_SE,str.ppr_RC_SE];
ySig = y;
ySig(~(str.ppr_RT_q<op.sigThr),1) = nan;
ySig(~(str.ppr_RC_q<op.sigThr),2) = nan;

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
title(ha,"Mentalizing PP Regression",FontSize=op.txtSz);

% Timecourses & error
mseb(str.t',y',ySE',odr,1);
hold on; axis tight;

% Plot sig timepoints
plot(str.t,ySig(:,1),"-","Color",odr.col{1},"LineWidth",odr.wSig);
plot(str.t,ySig(:,2),"-","Color",odr.col{2},"LineWidth",odr.wSig);
plot(xlim,[0 0],"k-","LineWidth",odr.wSig);
plot([0 0],ylim,"k-","LineWidth",odr.wSig);


%% Mentalizing (CC) PP regression: RT, RC & valence
y = [str.ppxr_RT,str.ppxr_RC,str.ppxr_val];
ySE = [str.ppxr_RT_SE,str.ppxr_RC_SE,str.ppxr_val_SE];
ySig = y;
ySig(~(str.ppxr_RT_q<op.sigThr),1) = nan;
ySig(~(str.ppxr_RC_q<op.sigThr),2) = nan;
ySig(~(str.ppxr_val_q<op.sigThr),2) = nan;

% Initialize subplot
ha = nexttile(ht);
ha.FontSize=op.txtSzAx;
title(ha,"Mentalizing PP Regression",FontSize=op.txtSz);

% Timecourses & error
mseb(str.t',y',ySE',odr,1);
hold on; axis tight;

% Plot sig timepoints
plot(str.t,ySig(:,1),"-","Color",odr.col{1},"LineWidth",odr.wSig);
plot(str.t,ySig(:,2),"-","Color",odr.col{2},"LineWidth",odr.wSig);
plot(str.t,ySig(:,3),"-","Color",odr.col{3},"LineWidth",odr.wSig);
plot(xlim,[0 0],"k-","LineWidth",odr.wSig);
plot([0 0],ylim,"k-","LineWidth",odr.wSig);


%% Save fig
fn = op.dirOutSbj+sbjCh+".jpg";
print(h,fn,"-djpeg","-r150");
disp("SAVED: "+fn);
delete(h);
end