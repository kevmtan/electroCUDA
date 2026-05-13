op = struct;
op.visible = false; % !!!!!!!!!!
op.figDir = "figs_mu_tfce05";


%% Options
op.ROIs = ["Visual" "TPJ" "PCC" "ATL" "amPFC" "dmPFC" "vmPFC"];

% Significance
op.sigVar = "p";
op.sigThr = 0.05;
op.sigTimeRng = [0 inf];
op.sigAlpha = 0; % transparency for nonsignificant vals

% Measure
op.mVar = "mu";
op.clim = [-0.5 0.5]; % color limits; auto=[]

% Freq ticks/labels
op.freqs = [2 4 8 14 30 60 300];

% Plot
op.res = [1980 1080];
op.arrange = "flow"; % ([m n]|"flow"|"vertical"|"horizontal")
op.txtCol = [0 0 0];
op.txtSz = 14;
op.txtSzTitle = 18;
op.txtSzAx = 11;
op.limWidth = 2;


%% Run
op.analDir = "/01/lbcn/anal/condConChsROI/zf_hpfLPF_spectTFCE/";
ec_condConChsROI_permPlot(op);
