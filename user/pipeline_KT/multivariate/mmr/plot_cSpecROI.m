% Colors
load("cdcol_2018.mat","cdcol");


%% Options
op.visible = false; % !!!!!!!!!!
op.save = true; % !!!!!!!!!!!

% Load/save
op.figDir = "fig_lpf4-20hz_vd1vd2Cond_e";
op.statFn = "stat_lpf4-20hz_vd1vd2Cond_e";

% Significance
op.sigThr = 0.05; % significance threshold
op.sigVar = "q";

% Individual plots?
op.indiv = false; 

% Plot
op.res = [1280 720];
%op.res = [640 640];
op.txtCol = [0 0 0]; % Text color: [R G B]
op.txtSz = 10; % text size
op.txtSzTitle = 12;
op.txtSzAx = 8;
% Plot
% op.res = [640 640];
% op.txtCol = [0 0 0]; % Text color: [R G B]
% op.txtSz = 0; % text size
% op.txtSzTitle = 0;
% op.txtSzAx = 16;

% Accuracy
op.a = struct;
op.a.style= ':';
op.a.edgestyle = ':';
op.a.width = 0.5;
op.a.wSig = 3;
% op.a.width = 1;
% op.a.wSig = 6;
op.a.col = cdcol.phthalocyanine_green;
op.a.col = ec_dim2cell(op.a.col,1);

% PP per cond
op.c = op.a;
op.c.col = [cdcol.carmine; cdcol.prussian_blue; cdcol.pastel_blue; 0 0.75 0]; % Math/Ab/Self/Other
%op.c.col = [cdcol.prussian_blue; cdcol.mauve; cdcol.pastel_blue; 0 0.75 0]; % Sem/Epi/Self/Other
op.c.col = ec_dim2cell(op.c.col,1);

% PP cond difference
op.d = op.c;
op.d.col = [cdcol.purple_violet; cdcol.greenish_blue; 0.85 0.33 0.10]; % Epi-Sem / Other-Self / Mental-Autobio
%op.d.col = [cdcol.violet; cdcol.greenish_blue; 0.85 0.33 0.10];
op.d.col = ec_dim2cell(op.d.col,1);

% PP RT/RC/valence
op.r = op.c;
op.r.col = [cdcol.empire_green; cdcol.french_grey; cdcol.orange];
op.r.col = ec_dim2cell(op.r.col,1);


%% Run
op.analDir = "/01/lbcn/anal/classifySpecROI/zf_MathAb_LDA_nestedGammaDelta";
mmr_cSpecPlot_ROI(op);


% op.analDir = "/01/lbcn/anal/classifySpecROI/zf_bands_50ms_SemEpi_LDA_nestedDeltaGamma";
% mmr_cSpecPlot_ROI(op);
