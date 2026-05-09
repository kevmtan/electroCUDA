op = struct;
op.visible = false; % !!!!!!!!!!
op.save = true; % !!!!!!!!!!!
op.figDir = "figs_mu_p05";


%% Options

% Significance
op.sigThr = 0.05; % threshold
op.sigVar = "p"; % variable name

% Measure
op.mVar = "mu"; % variable name
op.clim = [-0.5 0.5]; %[-30 30]; % measure value color limits, auto=[]

% Freq ticks/labels
op.freqs = [2 4 8 14 30 60 300];

% Plot
op.res = [1980 1080];
op.txtCol = [0 0 0]; % Text color: [R G B]
op.txtSz = 14; % text size
op.txtSzTitle = 18;
op.txtSzAx = 11;
op.alpha = 0; % transparency for nonsignificant vals


%% Run
op.analDir = "/01/lbcn/anal/condConROI/zf_bin5ms_hpf/";
ec_condConROI_permPlot(op);

% op.analDir = "/01/lbcn/anal/condConROI/xs_perm/";
% ec_condConROI_permPlot(op);