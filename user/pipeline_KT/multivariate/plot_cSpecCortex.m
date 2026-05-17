% Cortical timecourse plots for ec_classifySpec channelwise classification.
% Set op fields below (proj/task/analDir match do_classifySpecCh.m).
% ppc/ppxc column labels come from o.p.cond / o.p.condx in the saved analysis o.

%% Options
op = struct;
op.proj = "lbcn";
op.task = "MMR";
op.analDir = "classifySpecCh";
op.analNames = ["zf_MathAb_LDA_Gamma" "zf_50ms_MathAb_LDA_gamma"];
% op.analNames = [...
%     "zf_50ms_MathAb_LDA_gamma",...
%     "zf_50ms_MathAb_LDA_bandsGamma",...
%     "zf_50ms_SemEpi_LDA_bandsGamma",...
%     "zf_50ms_SemEpi_LDA_gamma"];

op.save = true;
op.ICA = false;

op.chBadFields = ["ai" "empty" "nan"]; %"bad";
op.chRmFun = []; %@(c) ~c.ECoG;

op.condVar = "cnd";
op.cndLabel = [];
op.conds = [];

op.timeUnit = "ms";
op.times = [50 250 500 750 1000 2000];
op.frqs = [];

% Single var: e.g. "ppc" or "ppxc". String array → side-by-side concat:
% op.actVar = ["ppc" "ppxc"]; % auto-labels cols as "ppc:Self", "ppxc:Self", ...
op.actVar = ["ppc" "ppxc"];
%op.actVar = "acc";
op.actUnit = "pp";
op.clim = [-0.4 0.4];
%op.clim = [0.2 0.8];

op.sigVar = "q";
op.sigThr = 0.05;

% Subplot column titles (one per matrix column of op.actVar)
% [] = auto-resolve from saved analysis o.p.* per op.actVar:
%   ppc/pp/auc/n/n0/wt -> o.p.cond
%   ppxc/ppx/nx        -> o.p.condx
%   ppc1               -> o.p.cond(2:end)   (fitlm contrasts)
%   ppxc1              -> o.p.condx(2:end)
% Override per-analysis if labels are wrong/missing (e.g. col1/col2 fallback):
%   op.spectNames = ["Self" "Other"]; % must have length == nCol
%   op.spectDisp  = ["Trained Self" "Trained Other"]; % []=use spectNames
op.spectNames = [];
op.spectDisp  = [];

op.posVar = "MNI";
op.surfType = "pial_avg";
op.surfReduce = 0.5; % decimate FS surface for speed: (0,1)=fraction faces kept; []=full res
op.pullF = 25;
op.alpha = 1;
op.marker = "o";
op.markSz = 4;
op.bSz = 0;
op.cmap = "RdBu";
op.nsCol = [0 0 0];
op.bCol = [0 0 0];
op.txtCol = [.8 .8 .8];
op.txtSz = 0;
op.labelVars = ["sbjCh" op.actVar "q"];
% Axes render order — "depth" (default; sort by camera distance) or "childorder"
% (insertion order, forces largest-|actVar| electrodes on top regardless of depth)
op.sortMethod = "childorder";
% Not used, NS is removed from stats table:
% op.nsMark = "o";
% op.nsSz = 0.001;

% Save paths (auto-derived from op.proj/task/analDir/analName + actVar/sigVar/sigThr)
%   Base dir : <dirs.anal>/<analDir>/<analName>/
%   Sub-dir  : "con_<actVar>_<sigVar><sigThrSuffix>"  (e.g. con_ppc_ppxc_q05)
%   File     : "<c>_<cnd>.jpg"                        (c=cnd group idx, cnd=op.cndLabel)
% Override sub-dir name via op.cond.saveDir / op.indiv.saveDir ([]=auto):
op.indiv.do = false;
op.indiv.res = [1980 1080];
op.indiv.saveDir = []; % []=auto "indiv_<tag>"; or e.g. "indiv_ppcppxc"

op.cond.do = true;
op.cond.res = [1320*1.25 1080*1.25];
%op.cond.res = [330*1.25 1080*1.25];
op.cond.saveDir = []; % []=auto "con_<tag>";   or e.g. "con_ppcppxc"
op.cond.compose = true; % parfor-render tiles → compose RGB in memory (parallelizes per-tile, ideal for single-cnd plots)


%% CHANNEL SELECTION: ec_selectChsBySig(...,op.chSel)
% Re-filter channels at plot time by significant per-condition activation/deactivation
% (vs baseline) in a SOURCE univariate analysis. If unset, falls back to the saved
% analysis's o.chSel (if any); set op.chSel=[] to force no selection regardless.
%
% ec_classifySpec_plotCortex resolves chSelDir/chSelName → full chNfoA path
% (dirs.anal/chSelDir/chSelName/chNfoA_<chSelName>.mat) and uses o.p.cond/condx
% from the saved analysis.
%
% cond1Sample modes match per-condition <CondName>_act/_dea cols (vs-baseline tests
% from the source perm analysis — NOT pairwise contrast cols like AvsB_act):
%   cond1Sample = "any":          act/dea for ANY condition in source (least circular).
%   cond1Sample = "self":         act/dea for any o.p.cond condition only.
%   cond1Sample = "condAndCondx": act/dea in ANY o.p.cond AND act/dea in ANY o.p.condx.
%                                 (within-group OR; across-group AND)
%                                 Recommended for cross-classification — keeps only
%                                 channels responsive to BOTH condition pairs.
%   cond1Sample = "condOrCondx":  act/dea in EITHER condition group (less restrictive).
%
% PRIMARY MODE — auto column resolution via chSelDir/chSelName:
op.chSel = struct;
op.chSel.scope       = "subject";          % "subject" | "roi"
op.chSel.chSelDir    = "condConCh";        % subdir under dirs.anal (source chNfoA)
op.chSel.chSelName   = "zf_hpfLPF_bandsParam"; % analName of source chNfoA
op.chSel.cond1Sample = "condAndCondx";    % recommended for cross-classification
% op.chSel.topN      = [];               % optional cap per scope group
%
% MANUAL OVERRIDE — explicit column list (takes precedence over cond1Sample).
% Use to select by pairwise CONTRAST columns instead (more circular than vs-baseline):
% op.chSel.vars     = ["SemanticvsEpisodic_act" "SemanticvsEpisodic_dea"];
% op.chSel.combine  = "or";              % "or" | "and" across vars
op.chSel.bandIdx  = 2:6;            % restrict matrix-valued cols to band indices
% op.chSel.rankVar  = "SemanticvsEpisodic_peakA_mu"; % rank for topN (contrast-based)
%
% PERM SOURCE — threshold raw ec_condConChs_perm results inline:
% op.chSel.source   = "perm";
% op.chSel.srcDir   = "/01/lbcn/anal/condConCh/<analName>/";
% op.chSel.contrasts= "Semantic vs Episodic";
% op.chSel.sigVar   = "q"; op.chSel.sigThr = 0.05; op.chSel.sigDur = 50;
%
% op.chSel = []; % ← set to [] to disable channel selection at plot time



% Parallelize per-condition figures across workers (MATLAB can crash on
% large figures in parallel — set false to run serially).
op.parallel = false;

%% Start parfor
%try delete(gcp("nocreate")); catch;end
if op.parallel
    try parpool("local6"); catch;end
end

%% Loop across analysis runs
% Auto-cleanup: deletes any leaked figures on normal exit, error, or Ctrl+C
figCleanup = onCleanup(@() delete(findall(groot,"Type","figure"))); %#ok<NASGU>

for io = 1:numel(op.analNames)
    op.analName = op.analNames(io);
    try
        ec_classifySpec_plotCortex(op);
    catch ME
        warning("[plot_cSpecCortex] Plot failed for %s:\n%s",op.analName,getReport(ME,"extended"));
    end
end
