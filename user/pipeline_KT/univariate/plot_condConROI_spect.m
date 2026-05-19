op = struct;
op.visible = false; % !!!!!!!!!!
op.figDir = "figs_noThresh";


%% Options
op.ROIs = ["Visual" "TPJ" "PCC" "ATL" "amPFC" "dmPFC" "vmPFC"];

% Significance
op.sigVar = "p";
op.sigThr = 1;
op.sigTimeRng = [0 inf];
op.sigAlpha = 0; % transparency for nonsignificant vals

% Measure
op.mVar = "mu";
op.clim = [-0.5 0.5]; % color limits; auto=[]

% Freq ticks/labels
op.freqs = [2 4 8 14 30 60 300];

% Plot
op.res = [1980 1080];
op.indiv = false;
op.arrange = "flow"; % ([m n]|"flow"|"vertical"|"horizontal")
op.txtCol = [0 0 0]; % Text color: [R G B]
op.txtSz = 14; % text size
op.txtSzTitle = 18;
op.txtSzAx = 11;
op.limWidth = 2;

% op.res = [480 480];
% op.indiv = false;
% op.arrange = "flow"; % ([m n]|"flow"|"vertical"|"horizontal")
% op.txtCol = [0 0 0];
% op.txtSz = 18;
% op.txtSzTitle = 18;
% op.txtSzAx = 14;
% op.limWidth = 2;


%% Run
op.analDir = "/01/lbcn/anal/condConROI/zf_bin5ms_hpf/";
ec_condConROI_permPlot(op);

% op.analDir = "/01/lbcn/anal/condConROI/xs_perm/";
% ec_condConROI_permPlot(op);