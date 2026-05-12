op = struct;
op.visible = false; % !!!!!!!!!!
op.figDir = "figs_mu_qa05";


%% Options
op.ROIs = ["Visual" "TPJ" "PCC" "ATL" "amPFC" "dmPFC" "vmPFC"];

% Significance
op.sigThr = 0.05;
op.sigVar = "qa";

% Measure
op.mVar = "mu";
op.clim = [-.8 .8]; % color limits; auto=[]

% Freq ticks/labels
op.freqs = [2 4 8 14 30 60 300];

% Plot
op.res = [1980 1080];
op.txtCol = [0 0 0];
op.txtSz = 14;
op.txtSzTitle = 18;
op.txtSzAx = 11;
op.alpha = 0; % transparency for nonsignificant vals
op.limWidth = 2;


%% Run
op.analDir = "/01/lbcn/anal/condConChsROI/zf_hpfLPF_spectParam/";
ec_condConChsROI_permPlot(op);
