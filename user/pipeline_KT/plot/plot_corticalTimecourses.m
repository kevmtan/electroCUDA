if ~exist("logs","var")
    load("/01/lbcn/anal/condContrast/mzAutoMathR_ch_251123/log_251123_0806.mat"); end

%% Plot cortex options
if ~exist("op","var")
    op = struct;

    op.save = true;

    % Filename
    op.statsFn = "avg"; % Subject stats filename suffix: s[sbjID]_[statsFn].mat
    op.statsVar = "stats"; % Subject stats variable name in saved data

    % Channels to exclude
    op.chBadFields = "bad";

    % Condition/contrast
    op.condVar = "con"; % variable for condition, contrast, or test (in stats table)
    op.conds = []; % conds to do (empty=all)

    % Timing
    op.timeVar = "bin"; % variable for time (in stats results)
    op.timeUnit = "ms"; % time unit to display in fig
    op.times = [50 250 500 750 1000 2000]; % times to plot (empty=all)

    % Spectral
    op.frqs = []; % frequency names to plot (empty=all)

    % Activation metric
    op.actVar = "b"; % activity variable for electrode plot color (in stats table)
    op.actUnit = "z"; % activity unit to display in fig
    op.clim = [-1 1]; %[-7 7] % limits for activity colorscale

    % Statistical significance
    op.sigVar = "q"; % statistical significance variable (in stats table)
    op.sigThr = 0.05; % significance threshold (default=0.05, none=0)

    % Plotting
    op.posVar = "MNI"; % position variable in chNfo table (should match surfType)
    op.surfType = "pial_avg"; % surface type (freesurfer naming convention) ["pial_avg"|"inflated_avg"]
    op.pullF = 25; % Pull factor, view elecs closer to camera (default=15)
    op.alpha = 0.95; % cortex opacity
    op.marker = "o"; % marker type (see Matlab marker symbols)
    op.nsMark = "o"; % marker type for nonsignificant chans (see Matlab marker symbols)
    op.markSz = 11; % marker size for significant chans;
    op.nsSz = 3; % marker size for nonsignificant chans;
    op.bSz = 0; % marker border size
    op.cmap = "RdBu"; % colormap (see ec_colorsFromValues)
    op.nsCol = [0 0 0]; % marker color for nonsignificant chans: [R G B]
    op.bCol = [0 0 0]; % marker border color: [R G B]
    op.txtCol = [.8 .8 .8]; % Text color: [R G B]
    op.txtSz = 10; % text size
    op.labelVars = ["sbjCh" op.actVar op.sigVar]; % channel label variable (for visible/interactive plots)

    % Individual plots per cond/time/freq
    op.indiv.do = false;
    op.indiv.res = [1980 1080];
    op.indiv.saveDir = "indiv";

    % Condition plots showing subplots per time & freq
    op.cond.do = true;
    op.cond.res = [1980 1080];
    op.cond.saveDir = "con_b";
end

%% Run
for p = 1 %1:2
    %%
    ec_plotTimesCortex(logs(p,:),op);
end
