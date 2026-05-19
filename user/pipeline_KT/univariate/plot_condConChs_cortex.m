% Cortical timecourse plots for ec_condConChs_perm channelwise contrasts.
% Set op fields below (proj/task/analDir/analName match do_condConChs_bandsParam.m).

%% Options
op = struct;
op.proj = "lbcn";
op.task = "MMR";
op.analDir = "condConCh";
op.analName = "zf_25ms_hpf0.2_lpf10_bandsParam";

op.save = true;
op.ICA = false;

op.chBadFields = ["ai" "empty" "nan"]; %"bad";
op.chRmFun = []; %[]; %@(c) ~c.ECoG;

op.condVar = "contrast";
op.conds = []; % []=do all contrasts
% op.conds = [...
%     "Other","Self","Semantic","Episodic","Math","Rest",...
%     "Mz","Autobio",...
%     "Other-Self","Episodic-Semantic","Mz-Autobio","Mz-Math","Autobio-Math"];

op.timeVar = "time";
op.timeUnit = "ms";
op.times = [100 250 500 750 1000 2000];
op.frqs = [];

op.actVar = "t";
op.actUnit = "t";
op.clim = [-8 8];

op.sigVar = "q";
op.sigThr = 0.001;

% Subplot column titles (one per matrix column of op.actVar)
% [] = auto-resolve from saved n.spect (frequency bands), falling back to o.p.pre.bands.
% Override per-analysis (must have length == nCol):
%   op.spectNames = ["theta" "alpha" "beta" "gamma" "hfb"];
%   op.spectDisp  = ["Theta (5-8hz)" "Alpha (8-14hz)" ...]; % []=use spectNames
op.spectNames = [];
op.spectDisp  = [];

op.posVar = "MNI";
op.surfType = "pial_avg";
op.surfReduce = 0.5; % decimate FS surface for speed: (0,1)=fraction faces kept; []=full res
op.pullF = 15;
op.alpha = 1;
op.marker = "o";
op.markSz = 5;
op.bSz = 0;
op.cmap = "RdBu";
op.nsCol = [0 0 0];
op.bCol = [0 0 0];
op.txtCol = [.8 .8 .8];
op.txtSz = 12;
op.labelVars = ["sbjCh" op.actVar "q"];
% Axes render order — "depth" (default; sort by camera distance) or "childorder"
% (insertion order, forces largest-|actVar| electrodes on top regardless of depth)
op.sortMethod = "depth";
% Not used, NS is removed from stats table:
op.nsMark = "o";
op.nsSz = 0;

% Save paths (auto-derived from op.proj/task/analDir/analName + actVar/sigVar/sigThr)
%   Base dir : <dirs.anal>/<analDir>/<analName>/
%   Sub-dir  : "con_<actVar>_<sigVar><sigThrSuffix>"  (e.g. con_mu_q05)
%   File     : "<c>_<cnd>.jpg"                        (c=contrast group idx, cnd=contrast)
% Override sub-dir name via op.cond.saveDir / op.indiv.saveDir ([]=auto):
op.indiv.do = false;
op.indiv.res = [660 360];
op.indiv.saveDir = []; % []=auto "indiv_<tag>"

op.cond.do = true;
op.cond.res = [1980*1.25 1080*1.25];
op.cond.saveDir = []; % []=auto "con_<tag>"
op.cond.compose = true; % parfor-render tiles → compose RGB in memory (parallelizes per-tile, ideal for single-cnd plots)

% Parallelize per-contrast figures across workers (MATLAB can crash on
% large figures in parallel — set false to run serially).
op.parallel = true;

%% Start parfor
%try delete(gcp("nocreate")); catch;end
if op.parallel
    try parpool("Processes",22); catch;end
end

%% Run
ec_condConChs_plotCortex(op);
