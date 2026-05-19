op = struct;
op.visible = false; % !!!!!!!!!!
op.figDir = "fig1_mu_tfce15";


%% Options
op.ROIs = ["Visual" "TPJ" "PCC" "ATL" "amPFC" "dmPFC" "vmPFC"];

% Significance
op.sigVar = "p";
op.sigThr = 0.15;
op.sigTimeRng = [0 inf];
op.sigAlpha = 0; % transparency for nonsignificant vals

% Measure
op.mVar = "mu";
op.clim = [-0.5 0.5]; % color limits; auto=[]

% Freq ticks/labels
op.freqs = [2 4 8 14 30 60 300];

% Plot
op.res = [480 480];
op.indiv = true;
op.arrange = "flow"; % ([m n]|"flow"|"vertical"|"horizontal")
op.txtCol = [0 0 0];
op.txtSz = 18;
op.txtSzTitle = 18;
op.txtSzAx = 14;
op.limWidth = 2;


%% Run
op.analDir = "/01/lbcn/anal/condConChsROI/zf_hpfLPF_spectTFCE/";
ec_condConChsROI_permPlot(op);
