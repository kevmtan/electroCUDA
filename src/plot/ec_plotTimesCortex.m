function ec_plotTimesCortex(op,logp,stats,chs)
% Plot cortical timecourses from per-channel statistical results.
%
% PIPELINE
%   1. loadStats_lfn / loadChs_lfn   — pull stats + channel info (or use args)
%   2. Filter chs                    — drop no-position / chRmFun / chBadFields
%   3. makePlotData_lfn              — build dp table: one row per
%                                       (cnd × time × freq) tile, with d.{col,
%                                       marker, sz, absVal, ...} per channel
%   4. preloadCort_lfn               — load lh.<surfType> once into op.cort
%                                       (decimated if op.surfReduce in (0,1))
%   5. Dispatch by mode:
%        op.indiv.do        → indiv_lfn:        N parfor figs (one per tile)
%        op.cond.do && !compose → conds_lfn:    N parfor figs (one per cnd grid)
%        op.cond.do && compose  → condsCompose_lfn: parfor tile RGBs → compose
%
% KEY op FIELDS
%   Data lookup : proj, task, posVar, timeVar, condVar, actVar, sigVar, sigThr
%   Filtering   : chRmFun, chBadFields, conds, times, frqs ([]=all)
%   Mesh        : surfType, surfReduce, cort, opacity (alpha), pullF
%   Markers     : marker, markSz, bSz, bCol, nsMark, nsSz, nsCol, cmap, clim
%   Layout      : cond.res, indiv.res, cond.saveDir, indiv.saveDir
%   Modes       : indiv.do, cond.do, cond.compose, parallel, save
%   Style       : txtSz, txtCol, labelVars, sortMethod, cndLabel
%
% Kevin Tan (electroCUDA)

%% Input validation
arguments
    op struct % Plot options
    logp table = table % Log output from statistical analysis (to load stats results)
    stats table = table % Stats results (leave empty to load from logp)
    chs table = table % Channel info (leave empty to load in function)
end


%% Setup

% Running interactively (from editor with no caller) vs. from script
if numel(dbstack)<2; op.test=true; else; op.test=false; end

% Force OpenGL renderer globally — skips per-figure auto-detect overhead
if string(get(groot,"DefaultFigureRenderer")) ~= "opengl"
    set(groot,"DefaultFigureRenderer","opengl");
end

% Sort method for axes (passed through to ec_plotCortex → axes.SortMethod):
%   ""           default — MATLAB picks "depth" for 3D scenes
%   "depth"      camera-distance order (electrodes can be hidden by gyri)
%   "childorder" insertion order — forces value-sorted electrodes on top
%                regardless of depth (cortex is added first so it stays below)
if ~isfield(op,"sortMethod"); op.sortMethod = ""; end

% Resolve & make output directories from proj/task/analDir/analName
if isfield(op,"proj") && isfield(op,"task")
    op = ec_plotCortexUtil("fillPlotDirs",op);
end

%% Load stats & channel info

% Stats: use input if provided, else load via logp
if (~exist("stats","var") || isempty(stats)) && ~isempty(logp)
    [stats,sbjs] = loadStats_lfn(logp,op);
elseif ~isempty(stats)
    sbjs = table(unique(stats.sbjID,"stable"),VariableNames="sbjID");
elseif isempty(logp)
    error("[ec_plotTimesCortex] Must input stats log or stats results")
end

% Channel info: use input if provided, else load per subject
if ~exist("chs","var") || isempty(chs)
    chs = loadChs_lfn(sbjs,op);
end
if op.test; statsOg=stats; chsOg=chs; end %#ok<NASGU> % keep originals for editor debug


%% Normalize column names + filter channels

% Sort chs deterministically (parallel-safe ordering for downstream joins)
if ~isempty(logp) && any(logp.ICA)
    chs = sortrows(chs,["sbjID" "ic"]);
else
    chs = sortrows(chs,["sbjID" "ch"]);
end

% Rename user-named cols to canonical names used by downstream code
if ~any(chs.Properties.VariableNames=="pos")
    chs = renamevars(chs,op.posVar,"pos"); end
if ~any(stats.Properties.VariableNames=="time")
    stats = renamevars(stats,op.timeVar,"time"); end
if ~any(stats.Properties.VariableNames=="cnd")
    stats = renamevars(stats,op.condVar,"cnd"); end

% Drop channels missing from stats, drop channels without 3D positions
chs(~ismember(chs.sbjCh,stats.sbjCh),:) = [];
id = isnan(chs.pos(:,1));
stats(ismember(stats.sbjCh,chs.sbjCh(id)),:) = [];
chs(id,:) = [];

% User-supplied channel filter (e.g. @(c) ~c.ECoG to drop ECoG)
if ~isempty(op.chRmFun)
    id = op.chRmFun(chs);
    stats(ismember(stats.sbjCh,chs.sbjCh(id)),:) = [];
    chs(id,:) = [];
end

% Bad-channel removal via boolean cols in chs.bad table (e.g. "ai","nan",...)
if isany(op.chBadFields)
    id = any(chs.bad{:,op.chBadFields},2);
    stats(ismember(stats.sbjCh,chs.sbjCh(id)),:) = [];
    chs(id,:) = [];
end


%% Build plot data + cache cortex surface

% dp = table with one row per (cnd, time, freq) tile; each .d cell holds
% the per-channel plot table (positions, marker, color, size, absVal, ...)
dp = makePlotData_lfn(stats,chs,op);

% Pre-load FS triangulation once into op.cort (cell with 1 triangulation).
% Workers receive a copy via parfor broadcast — avoids per-tile disk reads.
if ~isfield(op,"cort") || isempty(op.cort)
    op.cort = preloadCort_lfn(op);
end


%% Render

% Individual mode: one figure per (cnd, time, freq) tile
if op.indiv.do
    indiv_lfn(dp,op);
end

% Gallery mode: one figure per cnd (full times × freqs grid)
if op.cond.do
    if isfield(op.cond,"compose") && op.cond.compose
        condsCompose_lfn(dp,op);   % parfor tile RGBs → serial compose (single-cnd wins)
    else
        conds_lfn(dp,op);          % parfor over cnds, serial tile build per cnd
    end
end






%%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%% Load stats results %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Walks each subject's analysis output dir, loads `op.statsVar` from
% `s<sbjID>_<op.statsFn>.mat`, vertcat into one big stats table.
function [stats,sbjs] = loadStats_lfn(logp,op)
% Prep
sbjs = logp.i{:}; % get subjects from analysis
sbjN = height(sbjs); % number of subjects
stats = cell(sbjN,1); % preallocate stats data

% Loop across sbjs
for s = 1:sbjN
    % Get directory of subject stats data
    if isfield(sbjs.o{s},"dirOutSbj") && exist(sbjs.o{s}.dirOutSbj,"dir")
        fn = sbjs.o{s}.dirOutSbj;
    elseif isfield(sbjs.o{s},"dirOut") && exist(sbjs.o{s}.dirOut,"dir")
        fn = sbjs.o{s}.dirOut;
    else
        warning("NO STATS OUTPUT: s"+sbjs.sbjID(s));
        continue
    end

    % Load stats data
    fn = fn+"s"+sbjs.sbjID(s)+"_"+op.statsFn+".mat";
    stats{s} = load(fn,op.statsVar);
    stats{s} = stats{s}.(op.statsVar);
    disp("Loaded: "+fn);
end
stats = vertcat(stats{:}); % concactenate across sbjs






%%% Load channel info %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loads chNfo (or icNfo when op.ICA) for each subject and vertcats into one
% chs table — provides positions, hem/lat, ECoG flag, bad-chan info, etc.
function chs = loadChs_lfn(sbjs,op)
% Prep
sbjN = height(sbjs);
chs = cell(sbjN,1); % Preallocate

% Loop across sbjs
for s = 1:sbjN
    if op.ICA
        n = ec_loadSbj(sbj=sbjs.sbjID(s),proj=op.proj,task=op.task,...
            vars="n",compact="n");
        chs{s} = n.icNfo;
        chs{s}.bad = n.icBad;
        chs{s}.sbjID(:) = n.sbjID;
        % TODO: concactenate fsNfo
    else
        chs{s} = ec_loadSbj(sbj=sbjs.sbjID(s),proj=op.proj,task=op.task,...
            vars="chNfo");
    end
end
chs = vertcat(chs{:}); % concactenate across sbjs






%%% Make plot data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build dp: one row per (cnd, time, freq) tile. Each .d cell holds a per-chan
% table with positions + marker/color/size + a sort key (absVal). Channels
% failing the significance test keep d0 defaults (marker = op.nsMark, etc.)
% and are tagged with order = -inf so they're easy to filter out downstream.
function dp = makePlotData_lfn(stats,chs,op)

% Spectral info (subplot labels, optional display names) was attached as a
% custom property by the per-analysis prep step.
spect = stats.Properties.CustomProperties.spect;

% Resolve cnd/time/freq subsets ([] in op = use everything present)
if isany(op.conds);     conds = op.conds;
elseif iscategorical(stats.cnd); conds = string(categories(stats.cnd));
else;                   conds = unique(stats.cnd,"stable");
end
if isany(op.times);     times = op.times;
else;                   times = unique(stats.time);
end
if isany(op.frqs)
    [~,idx] = ismember(op.frqs,spect.name); frqs = spect(idx,:);
else;                   frqs = spect;
end

condN = numel(conds); timeN = numel(times); frqN = height(frqs);
plotN = condN * timeN * frqN;

% Preallocate dp
dp = table;
dp.cnd(1:plotN) = "";
dp.time(:) = nan;
dp.frq(:) = "";
dp.frqD(:) = "";
dp.d = cell(plotN,1);


%% Build per-tile channel data
for c = 1:condN
    for t = 1:timeN
        % d0 = template with NON-SIG defaults for every channel.
        % Sig channels later overwrite col/order/marker/sz; non-sig keep d0
        % values and order=-inf (used as a "drop me" marker before plotting).
        d0 = chs(:,["sbjCh" "pos" "hem" "lat" "gyrus" "ECoG"]);
        d0.marker(:) = op.nsMark(:);
        d0.col       = repmat(op.nsCol,height(d0),1);
        d0.bCol      = repmat(op.bCol,height(d0),1);
        d0.sz(:)     = op.nsSz;
        d0.bSz(:)    = op.bSz;
        d0.order(:)  = -inf; % filtered out before render

        % Stats for this (cnd, time): align rows to d0's channel order
        sp = stats(stats.cnd==conds(c) & stats.time==times(t),:);
        if height(sp)~=height(d0)
            warning("[ec_plotTimesCortex] Unequal heights for plot stats & channel tables: "+...
                "c="+conds(c)+" t="+times(t));
        end
        d0(~ismember(d0.sbjCh,sp.sbjCh),:) = [];
        [~,idx] = ismember(d0.sbjCh,sp.sbjCh); sp = sp(idx,:);

        % Per-freq slice
        for f = 1:frqN
            p = sub2ind([timeN frqN condN],t,f,c);
            frq = frqs.name(f);
            if ismember("disp",frqs.Properties.VariableNames)
                frqD = frqs.disp(f);
            else
                frqD = frq;
            end

            % Significance mask (idx = sig chans for this tile)
            if isany(op.sigVar) && isany(op.sigThr)
                idx = sp.(op.sigVar)(:,f) <= op.sigThr;
            else
                idx = true(height(d0),1);
            end

            % Apply sig-channel overrides over d0
            d = d0;
            [d.col(idx,:), d.order(idx)] = ec_colorsFromValues(...
                sp.(op.actVar)(idx,f), op.cmap, op.clim);
            d.marker(idx) = op.marker;
            d.sz(idx)     = op.markSz;

            % absVal = sort key — largest |actVar| ends up rendered on top
            d.absVal = zeros(height(d),1);
            d.absVal(idx) = abs(sp.(op.actVar)(idx,f));

            % Attach raw act/sig values for interactive datatips (test mode only)
            if op.test
                d.(op.actVar) = sp.(op.actVar)(:,f);
                d.(op.sigVar) = sp.(op.sigVar)(:,f);
            end

            dp.d{p}   = d;
            dp.cnd(p) = conds(c);
            dp.time(p)= times(t);
            dp.frq(p) = frq;
            dp.frqD(p)= frqD;
        end
    end
end

% Categorical for stable group order downstream
dp.cnd = categorical(dp.cnd,conds,Ordinal=true);
dp.frq = categorical(dp.frq,frqs.name,Ordinal=true);






%%% Indiv mode dispatch %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parfor over every (cnd, time, freq) row in dp — one figure per tile.
function indiv_lfn(dp,op)
dirOut = op.dirOut+op.indiv.saveDir+filesep;
if ~exist(dirOut,"dir"); mkdir(dirOut); end
conds = categories(dp.cnd);

nWorkers = workerCount_lfn(op);
parfor (p = 1:height(dp), nWorkers)
    plotIndiv_lfn(dp(p,:),op,conds,dirOut);
end






%%% Plot one tile as a standalone figure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Builds a small lateral+medial figure for a single (cnd, time, freq) tile
% and saves a JPG. Runs inside parfor in indiv_lfn.
function plotIndiv_lfn(dpp,op,conds,dirOut)
% Title: "<frq> | <cnd> | <time>ms" — segments omitted when empty
if isany(dpp.frq); txt = dpp.frqD+" | "; else; txt = ""; end
if ~ismissing(dpp.cnd) && string(dpp.cnd)~=""
    txt = txt + string(dpp.cnd)+" | "; end
txt = txt + dpp.time+op.timeUnit;

% Figure: docked when visible (so MATLAB lays it out), normal+invisible for batch
if op.test; ws = "docked"; else; ws = "normal"; end
h = figure(Position=[0 0 op.indiv.res],Visible=op.test,WindowStyle=ws,...
    Theme="light",Color="w");

% Unwrap dp's cell column; drop non-sig channels (order=-inf marker)
d = dpp.d{1};
d(d.order==-inf,:) = [];

ec_plotCortex("L",["lateral","medial"],d,h,sbj=op.fsSbj,sbjDir=op.fsDir,...
    cort=op.cort,surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.test,...
    title=txt,titleSz=op.txtSz,labelVars=op.labelVars,flip=true,order="ascend",...
    sortMethod=op.sortMethod);

if op.save && ~op.test
    c = find(conds==dpp.cnd);
    fn = dirOut+c+"_"+string(dpp.cnd)+"_"+string(dpp.frq)+"_"+dpp.time+".jpg";
    saveFig_lfn(h,fn,op);
    delete(h);
end






%%% Cond mode dispatch %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parfor over contrasts — each worker builds a full times × freqs tiledlayout
% as one big figure. Parallelism is N=numel(cnds), so this only fills the
% pool when you have multiple contrasts (use compose mode for single-cnd).
function conds_lfn(dp,op)
dirOut = op.dirOut+op.cond.saveDir+filesep;
if ~exist(dirOut,"dir"); mkdir(dirOut); end

% Group dp rows by cnd → cell array, one element per cnd
dp = splitapply(@(ci){dp(ci,:)},(1:height(dp))',findgroups(dp.cnd));

nWorkers = workerCount_lfn(op);
parfor (c = 1:numel(dp), nWorkers)
    plotCond_lfn(dp{c},c,dirOut,op);
end






%%% Build one cnd's full times × freqs grid (serial tiles inside one figure)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Each outer tile holds a nested 1×2 (lateral, medial) layout built by
% ec_plotCortex(...,tile=p). This is the "everything in one big scene"
% path — heavy for large grids; condsCompose_lfn is the parallelizable
% alternative.
function plotCond_lfn(dc,c,dirOut,op)
times = unique(dc.time);
frqs = string(categories(dc.frq));
timesN=numel(times); frqN=numel(frqs);

% Force string-typed cols for tile lookup + sort by (time, freq) for tile order
dc = sortrows(dc,["time" "frq"],"ascend");
dc.cnd = string(dc.cnd);
dc.frq = string(dc.frq);

% Figure + outer tiledlayout (times × freqs)
if op.test; ws = "docked"; else; ws = "normal"; end
h = figure(Position=[0 0 op.cond.res],Visible=op.test,WindowStyle=ws,...
        Theme="light",Color="w");
ht = tiledlayout(h,timesN,frqN,TileSpacing="compact",padding="tight");

% Overarching cnd title (skipped if cndLabel is empty/missing)
if any(op.txtSz) && ~ismissing(dc.cnd(1)) && string(dc.cnd(1))~=""
    title(ht,dc.cnd(1),FontSize=op.txtSz*1.5,FontWeight="bold");
end

% Build each tile via ec_plotCortex with tile=p (nested 1×2 lateral/medial)
for p = 1:height(dc)
    if frqN>1; txt = dc.frqD(p)+" | "; else; txt = ""; end
    txt = txt + dc.time(p)+op.timeUnit;

    d = dc.d{p};
    d(d.order==-inf,:) = []; % drop non-sig before render

    ec_plotCortex("L",["lateral","medial"],d,ht,sbj=op.fsSbj,sbjDir=op.fsDir,...
        cort=op.cort,surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.test,...
        title=txt,titleSz=op.txtSz,labelVars=op.labelVars,flip=true,order="ascend",...
        sortMethod=op.sortMethod,tile=p);
end

if op.save && ~op.test
    fn = dirOut+c+"_"+dc.cnd(1)+".jpg";
    saveFig_lfn(h,fn,op);
    delete(ht); delete(h);
end




%%% Compose mode: parfor tile RGBs → serial compose %%%%%%%%%%%%%%%%%%%%%%%
% Two phases:
%   1. parfor: render each (cnd, time, freq) tile as a small standalone
%      figure, capture RGB at exact tile pixel size, delete figure.
%   2. serial: build the composite per cnd by imshow-ing cached RGBs into a
%      tiledlayout. The composite figure has zero 3D content, so print is
%      trivial and parallelism in phase 1 reaches full worker count even
%      when there is only one contrast.
function condsCompose_lfn(dp,op)
dirOut = op.dirOut+op.cond.saveDir+filesep;
if ~exist(dirOut,"dir"); mkdir(dirOut); end

% Stable iteration order for predictable parfor index → row mapping
dp = sortrows(dp,["cnd" "time" "frq"],"ascend");

conds = unique(dp.cnd,"stable");
times = unique(dp.time);
frqs  = string(unique(dp.frq,"stable"));
nT = numel(times); nF = numel(frqs);

% Per-tile resolution = op.cond.res ÷ grid, minus title space.
% Title-height estimate (px): font_pt × 1.33 (pt→px @ 96 DPI) × 1.5 (line height + pad)
ovrTitleH = 0; tileTitleH = 0;
if any(op.txtSz)
    ovrTitleH  = round(op.txtSz * 1.5 * 1.33 * 1.5); % overarching cnd title (top)
    tileTitleH = round(op.txtSz * 1.33 * 1.5);       % per-tile "freq | time"
end
tileW = max(64, round(op.cond.res(1) / nF));
tileH = max(64, round((op.cond.res(2) - ovrTitleH) / nT) - tileTitleH);
tileRes = [tileW, tileH];
fprintf("[ec_PlotTimesCortex:compose] grid=%dx%d, op.cond.res=[%d %d], titles=[ovr=%d tile=%d], tileRes=[%d %d]\n",...
    nT, nF, op.cond.res(1), op.cond.res(2), ovrTitleH, tileTitleH, tileRes(1), tileRes(2));

% PHASE 1 — parfor: render each tile to RGB
nWorkers = workerCount_lfn(op);
rgbs = cell(height(dp),1);
parfor (p = 1:height(dp), nWorkers)
    rgbs{p} = renderTileRGB_lfn(dp(p,:),op,tileRes);
end

% PHASE 2 — serial: compose RGBs into per-cnd tiledlayout
for c = 1:numel(conds)
    cnd = string(conds(c));
    h = figure(Position=[0 0 op.cond.res],Visible=op.test,WindowStyle="normal",...
        Theme="light",Color="w");
    ht = tiledlayout(h,nT,nF,TileSpacing="none",Padding="tight");
    if any(op.txtSz) && ~ismissing(cnd) && cnd~=""
        title(ht,char(cnd),FontSize=op.txtSz*1.5,FontWeight="bold");
    end
    for t = 1:nT
        for f = 1:nF
            id = find(dp.cnd==conds(c) & dp.time==times(t) & string(dp.frq)==frqs(f),1);
            ax = nexttile(ht);
            if ~isempty(id) && ~isempty(rgbs{id})
                imshow(rgbs{id},Parent=ax,Border="tight");
            end
            if any(op.txtSz)
                if nF>1; ttxt = frqs(f)+" | "+times(t)+op.timeUnit;
                else;    ttxt = times(t)+op.timeUnit; end
                title(ax,ttxt,FontSize=op.txtSz);
            end
        end
    end
    if op.save && ~op.test
        fn = dirOut+c+"_"+cnd+".jpg";
        drawnow;
        % -r0 = screen DPI → output JPG matches figure Position exactly
        print(h,fn,"-djpeg","-r0");
        disp("[ec_PlotTimesCortex] saved (compose): "+fn);
        delete(h);
    end
end




%%% Compose-mode tile renderer %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Builds a small lateral+medial figure at exact tileRes pixels, captures
% the rasterized RGB, deletes the figure. Title is left empty (compose adds
% titles in the assembly step instead). Runs inside parfor.
function rgb = renderTileRGB_lfn(dpp,op,tileRes)
d = dpp.d{1};
d(d.order==-inf,:) = []; % drop non-sig

h = figure(Position=[0 0 tileRes],Visible="off",WindowStyle="normal",...
    Theme="light",Color="w");
try
    ec_plotCortex("L",["lateral","medial"],d,h,sbj=op.fsSbj,sbjDir=op.fsDir,...
        cort=op.cort,surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=false,...
        title="",titleSz=0,labelVars=op.labelVars,flip=true,order="ascend",...
        sortMethod=op.sortMethod);
    drawnow; % commit hidden-figure scene graph before capture
    % -r0 = screen DPI → captured RGB matches Position exactly (tileRes pixels)
    rgb = print(h,"-RGBImage","-r0");
catch ME
    delete(h);
    rethrow(ME);
end
delete(h);




%%% Shared helpers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Save figure as JPG at 150 DPI. Uses exportgraphics in serial (slightly
% better quality/cropping) and print in parallel (safer in parfor workers).
function saveFig_lfn(h,fn,op)
drawnow; % flush scene graph for hidden figures
if isfield(op,"parallel") && ~op.parallel
    exportgraphics(h,fn,Resolution=150);
else
    print(h,fn,"-djpeg","-r150");
end
disp("[ec_PlotTimesCortex] saved: "+fn);

% Worker count for parfor: inf = use full pool, 0 = run serial in client
function n = workerCount_lfn(op)
n = inf;
if isfield(op,"parallel") && ~op.parallel; n = 0; end




%%% Pre-load freesurfer surface once for all tiles %%%%%%%%%%%%%%%%%%%%%%%%
function cort = preloadCort_lfn(op)
% Only "L" is used by the indiv/cond plotting calls; load lh.<surfType> as a
% triangulation and pass through op.cort (cell array, indexed by hem in ec_plotCortex).
% Optionally decimate via reducepatch when op.surfReduce in (0,1) — keeps that
% fraction of faces (e.g. 0.5 = halve). 1 or unset = full resolution.
sbjDir = string(op.fsDir);
if endsWith(sbjDir,"subjects"+filesep,'IgnoreCase',true) || ...
        endsWith(sbjDir,"freesurfer"+filesep,'IgnoreCase',true)
    sbjDir = fullfile(sbjDir, string(op.fsSbj));
end
surfFn = fullfile(sbjDir, "surf", "lh."+string(op.surfType));
tri = ec_readSurfTri(surfFn);
if isfield(op,"surfReduce") && ~isempty(op.surfReduce) ...
        && op.surfReduce > 0 && op.surfReduce < 1
    fv.faces    = tri.ConnectivityList;
    fv.vertices = tri.Points;
    fv = reducepatch(fv, op.surfReduce);
    tri = triangulation(double(fv.faces), fv.vertices);
    fprintf("[ec_plotTimesCortex] surf decimated %.1f%% (%d faces)\n",...
        100*op.surfReduce, size(fv.faces,1));
end
cort = {tri};





% %%% Plot electrodes on cortex %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function plotCortex_lfn(h,d,op,dirFS,txt,p)
% 
% % Make tiledlayout for lateral/medial
% hi = tiledlayout(h,1,2,TileSpacing="none",padding="tight");
% if nargin>5
%     hi.Layout.Tile = p;
%     hi.Layout.TileSpan = [1 1];
% end
% 
% % Lateral
% ha = nexttile(hi);
% ec_plotCortex("L","lateral",d,ha,sbjDir=dirFS,surfType=op.surfType,...
%     opacity=op.alpha,flip=true,pullF=op.pullF,visible=op.test,order="ascend");
% 
% % Medial
% ha = nexttile(hi);
% ec_plotCortex("L","medial",d,ha,sbjDir=dirFS,surfType=op.surfType,...
%     opacity=op.alpha,flip=true,pullF=op.pullF,visible=op.test,order="ascend");
% 
% if nargin>4 && isany(txt)
%     title(hi,txt); end
% 