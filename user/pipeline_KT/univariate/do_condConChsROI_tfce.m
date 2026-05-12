% Initialize options
o = struct;
o.save = true;


%% Project & I/O paths
o.proj = "lbcn";
o.task = "MMR";

% Source channelwise analysis ('ec_condConChs_perm' outputs) — relative to dirs.anal
o.chsDir  = "condConCh";
o.chsName = "zf_hpfLPF_spectParam";

% This analysis's output — relative to dirs.anal
o.analDir  = "condConChsROI";
o.analName = "zf_hpfLPF_spectTFCE";


%% ROIs & measure
o.ROIs = ["Visual" "TPJ" "PCC" "ATL" "amPFC" "dmPFC" "vmPFC"]; % empty = all unique ROIs in chNfoA
o.mVar = "mu";      % column in 'st' to test against 0


%% Contrasts
o.contrasts = []; %["Other" "Self" "Semantic" "Episodic" "Math" "Rest"];
o.cond1     = [];   % empty = each contrast tests itself; padded string array or cell to override
o.cond0     = [];   % always [] — 2-sample mode not supported


%% Channel selection (requires chNfoA built by ec_condConChs_sigChs)
% Set chSelName to a different analName to cross-select (e.g., use bandsParam
% chNfoA to select channels for a full-spectrum/ERSP ROI contrast — less circular).
% 2-sample contrasts: select if cond1 OR cond0 had any act/dea cluster.
% 1-sample contrasts: "any" = any act/dea in chNfoSel (less circular);
%                     "self" = same contrast's act/dea (more circular).
o.chSel        = true;
o.chSel1Sample = "self";           % "any" | "self"
o.chSelDir     = "condConCh";      % chNfoSel source dir  (empty = o.chsDir)
o.chSelName    = "zf_hpfLPF_bandsParam"; % chNfoSel analName (empty = o.chsName)


%% Optional pre-averaging across observations
% Default obs unit = each 'sbjCh'. Set avgVars to collapse, e.g., ["sbjID"]
% for subject-level averaging (breaks within-subject channel correlations).
o.avgVars = [];
o.avgType = "mean";   % "mean" | "median"


%% Baseline correction on reshaped mu (applied per obs before contrast)
o.baseline     = [];   % ms; empty = skip
o.baselineType = "mean";     % "mean" | "median"
o.baselineNorm = "robust";   % "" = subtract only | "zscore" | "robust"
o.blGrpVars    = "cnd";      % "cnd" = grand pool within condition; add "sbjCh" for per-channel


%% Permutation test / stats parameters (ec_contrast_perm)
o.nPerm        = 10000;
o.alpha        = 0.05;
o.tail         = "both";     % "both" | "right" | "left"
o.grpVars      = []; %"sbjID";    % stratification var(s) for permutation
o.correct      = "tfce";     % "none" | "max" | "tfce"
o.matmulThresh = 0;
o.tfceE        = 0.5;
o.tfceH        = 2;
o.tfceDh       = 0;
o.tfceConn     = [];
o.tfceDims     = ["time" "spect"];
o.tfceVoxelWeights = [];

% Compute options
o.parallel     = "cpu";
o.ramAvail     = ec_ramAvail(o.parallel=="gpu");
o.blockElMax   = 0;
o.blockMemFrac = 0.5;
o.nBlocks      = 96;
o.gather       = "block";
o.stream       = true;
o.ciMode       = "approx";
o.idxType      = "double";
o.verbose      = true;
o.saveDF       = false;


%% FDR (used when o.correct == "none")
o.fdrTimeRng = [0 inf];
o.fdrDep     = "corr+";


%% Data precision
o.floatAnal = "double";
o.floatOut  = "single";


%% Run
st = ec_condConChsROI_perm(o);
