% Cortical timecourse plots for ec_classifySpec channelwise classification.
% Set op fields below (proj/task/analDir match do_classifySpecCh.m).
% ppc/ppxc column labels come from o.p.cond / o.p.condx in the saved analysis o.

%% Options
op = struct;
op.proj = "lbcn";
op.task = "MMR";
op.analDir = "classifySpecCh";
op.analNames = [...
    "zf_50ms_SemEpi_LDA_bandsGamma",...
    "zf_50ms_SemEpi_LDA_pcaGamma",...
    "zf_50ms_MathAb_LDA_bandsGamma",...
    "zf_50ms_MathAb_LDA_pcaGamma"];

op.save = true;
op.ICA = false;

op.chBadFields = "bad";
op.chRmFun = @(c) ~c.ECoG;

op.condVar = "cnd";
op.cndLabel = "all";
op.conds = [];

op.timeUnit = "ms";
op.times = [50 250 500 750 1000 2000];
op.frqs = [];

op.actVar = "ppc";
op.actUnit = "pp";
op.clim = [-0.5 0.5];

op.sigVar = "q";
op.sigThr = 0.05;

op.posVar = "MNI";
op.surfType = "pial_avg";
op.pullF = 25;
op.alpha = 0.95;
op.marker = "o";
op.nsMark = "o";
op.markSz = 5;
op.nsSz = 3;
op.bSz = 0;
op.cmap = "RdBu";
op.nsCol = [0 0 0];
op.bCol = [0 0 0];
op.txtCol = [.8 .8 .8];
op.txtSz = 10;
op.labelVars = ["sbjCh" op.actVar "q"];

op.indiv.do = false;
op.indiv.res = [1980 1080];

op.cond.do = true;
op.cond.res = [1980 1080];

%% Start parfor
try delete(gcp("nocreate")); catch;end
try parpool("local6"); catch;end

%% Loop across analysis runs
for io = 1:numel(op.analNames)
    op.analName = op.analNames(io);
    try
        ec_classifySpec_plotCortex(op);
    catch ME
        warning("[plot_cSpecCortex] Plot failed for %s:\n%s",op.analName,getReport(ME,"extended"));
    end
end
