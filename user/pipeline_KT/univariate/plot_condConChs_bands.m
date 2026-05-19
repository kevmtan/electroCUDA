% Initialize options
op = struct;
op.visible = false; % !!!!!!!!!!
op.save = true; % !!!!!!!!!!!
op.figDir = "figs_stimBL_mu_q05";

% Load colors
load ("cdcol_2018.mat","cdcol");


%% Options

% Measure
op.mVar = "mu"; % variable name
op.clim = [-2 2]; %[-30 30]; % measure value color limits, auto=[]

% Significance
op.sigVar = "q"; % variable name
op.sigThr = 0.05; % threshold
op.sigTimeRng = [0 inf];
op.alphaSig = 0; % transparency for nonsignificant vals

% Plot
op.res = [1440 1080];
op.arrange = [3 3]; % ([m n]|"flow"|"vertical"|"horizontal")
op.txtCol = [0 0 0]; % Text color: [R G B]
op.txtSz = 14; % text size
op.txtSzTitle = 18;
op.txtSzAx = 11;
op.limWidth = 2;

% Cortex opts
op.posVar = "pialRAS"; % position variable in chNfo table (should match surfType)
op.surfType = "pial"; % surface type (freesurfer naming convention) ["pial_avg"|"inflated_avg"]
op.pullF = 15; % Pull factor, view elecs closer to camera (default=15)
op.alpha = 0.95; % cortex opacity
op.marker = "o"; % marker type (see Matlab marker symbols)
op.nsMark = "o"; % marker type for nonsignificant chans (see Matlab marker symbols)
op.markSz = 9; % marker size for significant chans;
op.nsSz = 3; % marker size for nonsignificant chans;
op.bSz = 0; % marker border size
op.cmap = "RdBu"; % colormap (see ec_colorsFromValues)
op.markCol = [1 0 0];
op.nsCol = [0 0 0]; % marker color for nonsignificant chans: [R G B]
op.bCol = [0 0 0]; % marker border color: [R G B]
op.align = true; % align vertex centers

% Contrast opts
op.c = struct;
op.c.style= ':';
op.c.edgestyle = ':';
op.c.width = 0.5;
op.c.wSig = 2;

% Contrast colors
op.cols =...
    [0 0.75 0;
    cdcol.pastel_blue;
    cdcol.prussian_blue;
    cdcol.mauve;
    cdcol.light_cadmium_red;
    cdcol.yellow;];

% Contrasts to do
op.contrasts = ["Other" "Self" "Semantic" "Episodic" "Math" "Rest"]; % []=all



%%
try delete(gcp("nocreate")); catch;end
try ppool = parpool("Processes",22); catch;end


%% Run
op.analDir = "/01/lbcn/anal/condConCh/zf_25ms_hpf0.2_lpf10_bandsParam/";
ec_condConChs_permBandsPlot(op);

try delete(gcp("nocreate")); catch;end
