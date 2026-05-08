% Colors
load("cdcol_2018.mat","cdcol");


%% Options
op.visible = false; % !!!!!!!!!!
op.save = true; % !!!!!!!!!!!
op.sigThr = 0.05; % significance threshold

% Plot
op.res = [1280 720];
op.txtCol = [0 0 0]; % Text color: [R G B]
op.txtSz = 10; % text size
op.txtSzTitle = 12;
op.txtSzAx = 8;

% Accuracy
op.a = struct;
op.a.style= ':';
op.a.edgestyle = ':';
op.a.width = 0.5;
op.a.wSig = 2;
op.a.col = cdcol.spruce_green;
op.a.col = ec_dim2cell(op.a.col,1);

% PP per cond
op.c = op.a;
op.c.col = [cdcol.prussian_blue; cdcol.mauve; cdcol.pastel_blue; 0 0.75 0];
op.c.col = ec_dim2cell(op.c.col,1);

% PP cond difference
op.d = op.c;
op.d.col = [cdcol.violet; cdcol.greenish_blue];
op.d.col = ec_dim2cell(op.d.col,1);

% PP RT/RC/valence
op.r = op.c;
op.r.col = [cdcol.indian_red; cdcol.orange; cdcol.peacock_green];
op.r.col = ec_dim2cell(op.r.col,1);


%% Run

analDir = "/01/lbcn/anal/classifySpecROI/MathAb_LDA_260425_1348/";
mmr_cSpecPlot_ROI(analDir,op);

analDir = "/01/lbcn/anal/classifySpecROI/MathAb_LDA_gamma_260425_1432/";
mmr_cSpecPlot_ROI(analDir,op);

analDir = "/01/lbcn/anal/classifySpecROI/MathAb_LDA_pca_260425_1932/";
mmr_cSpecPlot_ROI(analDir,op);

analDir = "/01/lbcn/anal/classifySpecROI/MathAb_LDA_pcaGamma_260425_1959/";
mmr_cSpecPlot_ROI(analDir,op);

analDir = "/01/lbcn/anal/classifySpecROI/MathAb_LR_lambda_260426_1348/";
mmr_cSpecPlot_ROI(analDir,op);