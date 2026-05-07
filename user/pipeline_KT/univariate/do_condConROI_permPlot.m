op = struct;
op.visible = false; % !!!!!!!!!!
op.save = true; % !!!!!!!!!!!
op.figDir = "figs_t";


%% Options

% Significance
op.sigThr = 0.05; % threshold
op.sigVar = "qa"; % variable name

% Measure
op.mVar = "t"; % variable name
op.clim = [-30 30]; % measure value color limits

% Freq ticks/labels
op.freqs = [2 4 8 14 30 60 300];

% Plot
op.res = [1980 1080];
op.txtCol = [0 0 0]; % Text color: [R G B]
op.txtSz = 12; % text size
op.txtSzTitle = 16;
op.txtSzAx = 10;
op.alpha = 0; % transparency for nonsignificant vals


%% Run
op.analDir = "/01/lbcn/anal/condConROI/zf_hpf/";
ec_condConROI_permPlot(op);

op.analDir = "/01/lbcn/anal/condConROI/xs_perm/";
ec_condConROI_permPlot(op);