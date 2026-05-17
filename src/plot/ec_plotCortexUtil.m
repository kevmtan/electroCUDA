function varargout = ec_plotCortexUtil(action,varargin)
% Shared helpers for ec_*_plotCortex prep functions.
%
%   tf = ec_plotCortexUtil("chSelIsActive", chSel)
%   chSel = ec_plotCortexUtil("resolveChSel", chSel, o, dirs)
%   outDir = ec_plotCortexUtil("analOut", op)
%   op = ec_plotCortexUtil("fillPlotDirs", op)
%   [logs,o,op] = ec_plotCortexUtil("loadAnal", op)
%   fn = ec_plotCortexUtil("matPath", path)
%   M  = ec_plotCortexUtil("toMatrix", v)

switch string(action)
    case "chSelIsActive"
        varargout{1} = chSelIsActive_lfn(varargin{1});
    case "resolveChSel"
        varargout{1} = resolveChSel_lfn(varargin{1},varargin{2},varargin{3});
    case "analOut"
        varargout{1} = analOut_lfn(varargin{1});
    case "fillPlotDirs"
        varargout{1} = fillPlotDirs_lfn(varargin{1});
    case "loadAnal"
        [varargout{1},varargout{2},varargout{3}] = loadAnal_lfn(varargin{1});
    case "matPath"
        varargout{1} = matPath_lfn(varargin{1});
    case "toMatrix"
        varargout{1} = toMatrix_lfn(varargin{1});
    otherwise
        error("[ec_plotCortexUtil] Unknown action: %s",action);
end




function tf = chSelIsActive_lfn(chSel)
% True when chSel has enough config to run ec_selectChsBySig.
if isempty(chSel) || ~isstruct(chSel)
    tf = false;
    return;
end
if isfield(chSel,"chTable") && ~isempty(chSel.chTable)
    tf = true;
    return;
end
if isfield(chSel,"source") && string(chSel.source)=="perm"
    tf = isfield(chSel,"srcDir") && isany(chSel.srcDir);
    return;
end
tf = isfield(chSel,"chSelName") && isany(chSel.chSelName);




function chSel = resolveChSel_lfn(chSel,o,dirs)
% Resolve chSel paths and condition lists for plot-time channel selection.
noTable = ~isfield(chSel,"chTable") || isempty(chSel.chTable);
notPerm = ~isfield(chSel,"source") || string(chSel.source)~="perm";
if noTable && notPerm
    if isfield(chSel,"chSelName") && isany(chSel.chSelName)
        selDir = "condConCh";
        if isfield(chSel,"chSelDir") && isany(chSel.chSelDir)
            selDir = string(chSel.chSelDir);
        end
        selPath = dirs.anal+selDir+filesep+string(chSel.chSelName)+filesep;
        chSel.chTable = selPath+"chNfoA_"+string(chSel.chSelName)+".mat";
        chSel.source = "table";
    else
        chSel = [];
        return;
    end
end
if isfield(chSel,"source") && string(chSel.source)=="perm"
    if (~isfield(chSel,"srcDir") || ~isany(chSel.srcDir))
        if isfield(o,"outDir") && isany(o.outDir)
            chSel.srcDir = o.outDir;
        elseif isfield(o,"analOut") && isany(o.analOut)
            chSel.srcDir = o.analOut;
        end
    end
end
if (~isfield(chSel,"cond") || isempty(chSel.cond)) && isfield(o,"p")
    if isfield(o.p,"conds") && isany(o.p.conds)
        chSel.cond = o.p.conds;
    elseif isfield(o.p,"cond") && isany(o.p.cond)
        chSel.cond = o.p.cond;
    end
end
if (~isfield(chSel,"condx") || isempty(chSel.condx)) && isfield(o,"p") && isfield(o.p,"condx")
    chSel.condx = o.p.condx;
end




function fn = matPath_lfn(p)
fn = string(p);
if ~endsWith(fn,".mat")
    fn = fn+".mat";
end




function M = toMatrix_lfn(v)
if istable(v)
    v = v{:,:};
end
if isvector(v)
    M = v(:);
else
    M = v;
end




function outDir = analOut_lfn(op)
if ~isfield(op,"proj") || ~isfield(op,"task") || ~isfield(op,"analDir") || ~isfield(op,"analName")
    error("[ec_plotCortexUtil] op.proj, op.task, op.analDir, op.analName required.");
end
dirs = ec_getDirs(op.proj,op.task);
outDir = dirs.anal+string(op.analDir)+filesep+string(op.analName)+filesep;




function op = fillPlotDirs_lfn(op)
dirs = ec_getDirs(op.proj,op.task);
if isfield(op,"analDir") && isfield(op,"analName")
    op.dirOut = analOut_lfn(op);
elseif ~isfield(op,"dirOut") || ~isany(op.dirOut)
    op.dirOut = analOut_lfn(op);
end
if ~isfield(op,"fsDir") || ~isany(op.fsDir)
    op.fsDir = dirs.freesurfer;
end
if ~isfield(op,"fsSbj") || ~isany(op.fsSbj)
    op.fsSbj = "fsaverage";
end
tag = plotTag_lfn(op);
if isfield(op,"indiv") && isfield(op.indiv,"do") && op.indiv.do
    if ~isfield(op.indiv,"saveDir") || ~isany(op.indiv.saveDir)
        op.indiv.saveDir = "indiv_"+tag;
    end
end
if isfield(op,"cond") && isfield(op.cond,"do") && op.cond.do
    if ~isfield(op.cond,"saveDir") || ~isany(op.cond.saveDir)
        op.cond.saveDir = "con_"+tag;
    end
end




function [logs,o,op] = loadAnal_lfn(op)
outDir = analOut_lfn(op);
op.dirOut = outDir;
oFn = outDir+"o_"+string(op.analName)+".mat";
logsFn = outDir+"logs_"+string(op.analName)+".mat";
if ~isfile(oFn)
    error("[ec_plotCortexUtil] Missing options file: %s",oFn);
end
if ~isfile(logsFn)
    error("[ec_plotCortexUtil] Missing logs file: %s",logsFn);
end
load(oFn,"o");
load(logsFn,"logs");
if ~isfield(o,"outDir") || ~isany(o.outDir)
    o.outDir = outDir;
end
if ~isfield(o,"analOut") || ~isany(o.analOut)
    o.analOut = outDir;
end




function tag = plotTag_lfn(op)
% Output tag for save dirs, e.g. mu_p05 (actVar=p, sigThr=0.05).
act = string(op.actVar);
sig = string(op.sigVar);
if ~isfield(op,"sigThr") || isempty(op.sigThr)
    tag = act+"_"+sig;
    return;
end
tag = act+"_"+sig+sigThrSuffix_lfn(op.sigThr);




function suffix = sigThrSuffix_lfn(thr)
% Map threshold to a compact string without decimal: 0.05 -> "05", 0.0001 -> "0001".
s = string(thr);
if contains(s,".")
  parts = split(s,".");
  suffix = parts(2);
  suffix = regexprep(suffix,"0+$","");
  if suffix == ""
    suffix = "0";
  end
else
  suffix = s;
end
