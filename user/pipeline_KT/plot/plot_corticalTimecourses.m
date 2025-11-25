%% Load stats processing log
if ~exist("logs","var")
    load("/01/lbcn/anal/stimBL/bandLM_ch_251124/log_251124_0940.mat"); end

%% Plot cortex options
proj = "lbcn";
task = "MMR"; % task name
dirs = ec_getDirs(proj,task);

% Options struct
if ~exist("op","var")
    %% Options
    op = struct;
    op.proj = proj;
    op.task = task;

    op.save = true;
    op.ICA = false; % loading ICA data? (filled below)

    % Files & directories
    op.statsFn = "stats"; % Subject stats filename suffix: s[sbjID]_[statsFn].mat
    op.statsVar = "stats"; % Subject stats variable name in saved data
    op.dirOut = logs.out(1); % blank to fill later

    % Freesurfer
    op.fsDir = dirs.freesurfer;
    op.fsSbj = "fsaverage";

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
    op.indiv.saveDir = "indiv";
    op.indiv.res = [1980 1080];
    op.indiv.title = true; % add titles?

    % Condition plots showing subplots per time & freq
    op.cond.do = true;
    op.cond.saveDir = "cond_b_q05";
    op.cond.res = [1980 1080];
    op.cond.title = true; % add titles? 
end


%% Loop across channel vs IC data
for p = 1 %1:2
    % Analysis info
    op.dirOut = logs.out(p);
    op.ICA = logs.ICA(p);

    %% Run plot function
    ec_plotTimesCortex(op,logs(p,:));
end


%%
if 0
    ec_plotTimesCortex(op,[],stats,chs) %#ok<UNRCH>
end
