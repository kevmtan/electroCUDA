function ec_plotTimesCortex(op,logp,stats,chs)
% Plot cortical timecourses from statistical results per channel.

%% Input validation
arguments
    op struct % Plot options
    logp table = table % Log output from statistical analysis (to load stats results)
    stats table = table % Stats results (leave empty to load from logp)
    chs table = table % Channel info (leave empty to load in function)
end


%% Load data

% Function call or running from editor?
if numel(dbstack)<2; op.test=true; else; op.test=false; end

% Force hardware-accelerated renderer to avoid auto-detect overhead per figure
if string(get(groot,"DefaultFigureRenderer")) ~= "opengl"
    set(groot,"DefaultFigureRenderer","opengl");
end

% Default sort method passed to ec_plotCortex (axes.SortMethod):
%   ""           -> leave axes default (MATLAB picks "depth" for 3D)
%   "depth"      -> render by camera distance (electrodes can be hidden behind ridges)
%   "childorder" -> render in insertion order (forces value-sorted electrodes on top
%                   of overlapping ones; cortex still added first so it stays below)
if ~isfield(op,"sortMethod"); op.sortMethod = ""; end

if isfield(op,"proj") && isfield(op,"task")
    op = ec_plotCortexUtil("fillPlotDirs",op);
end

% Stats results
if (~exist("stats","var") || isempty(stats)) && ~isempty(logp)
    % Load
    [stats,sbjs] = loadStats_lfn(logp,op);
elseif ~isempty(stats)
    % Get subjects from stats
    sbjs = table(unique(stats.sbjID,"stable"),VariableNames="sbjID");
elseif isempty(logp)
    error("[ec_plotTimesCortex] Must input stats log or stats results")
end

% Load channel info
if ~exist("chs","var") || isempty(chs)
    chs = loadChs_lfn(sbjs,op);
end
% Save originals if testing
if op.test; statsOg=stats; chsOg=chs; end %#ok<NASGU>


%% Prep stats & channel info

% Order channel info
if ~isempty(logp) && any(logp.ICA)
    chs = sortrows(chs,["sbjID" "ic"]);
else
    chs = sortrows(chs,["sbjID" "ch"]);
end
% % Order stats results
% [~,idx] = ismember(chs.sbjCh,stats.sbjCh);
% stats = stats(idx,:);

% Rename electrode position var
if ~any(chs.Properties.VariableNames=="pos")
    chs = renamevars(chs,op.posVar,"pos"); end
% Rename stats time var
if ~any(stats.Properties.VariableNames=="time")
    stats = renamevars(stats,op.timeVar,"time"); end
% Rename stats condition/contrast var
if ~any(stats.Properties.VariableNames=="cnd")
    stats = renamevars(stats,op.condVar,"cnd"); end

% Remove channels not in stats data
chs(~ismember(chs.sbjCh,stats.sbjCh),:) = [];

% Remove chans with no position coords
id = isnan(chs.pos(:,1));
stats(ismember(stats.sbjCh,chs.sbjCh(id)),:) = [];
chs(id,:) = [];

% Remove chans with specified function on 'chs' fields
if ~isempty(op.chRmFun)
    id = op.chRmFun(chs);
    stats(ismember(stats.sbjCh,chs.sbjCh(id)),:) = [];
    chs(id,:) = [];
end

% Remove bad chans
if isany(op.chBadFields)
    id = any(chs.bad{:,op.chBadFields},2);
    stats(ismember(stats.sbjCh,chs.sbjCh(id)),:) = [];
    chs(id,:) = [];
end


%% Make plot data
dp = makePlotData_lfn(stats,chs,op);

% Pre-load FS surface once and broadcast via op.cort — avoids ec_plotCortexSurf
% reloading the surface for every tile / view (huge win for 6×6 × 2 views grids).
if ~isfield(op,"cort") || isempty(op.cort)
    op.cort = preloadCort_lfn(op);
end


%% Plot individual
if op.indiv.do
    indiv_lfn(dp,op);
end


%% Plot gallery of times & freqs (separate per cond)
if op.cond.do
    if isfield(op.cond,"compose") && op.cond.compose
        condsCompose_lfn(dp,op);   % parfor-render tiles → compose serially
    else
        conds_lfn(dp,op);          % serial build of full tiledlayout per cnd
    end
end






%%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%% Load stats results %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
function dp = makePlotData_lfn(stats,chs,op)
% Get spectral info
spect = stats.Properties.CustomProperties.spect;

% Get conds/contrasts/tests to plot
if isany(op.conds)
    conds = op.conds;
elseif iscategorical(stats.cnd)
    conds = string(categories(stats.cnd));
else
    conds = unique(stats.cnd,"stable");
end

% Get times to plot
if isany(op.times)
    times = op.times;
else
    times = unique(stats.time);
end

% Get freqs to plot
if isany(op.frqs)
    [~,idx] = ismember(op.frqs,spect.name);
    frqs = spect(idx,:);
else
    frqs = spect;
end

% Get counts
condN = numel(conds);
timeN = numel(times);
frqN = height(frqs);
plotN = condN * timeN * frqN;

% Preallocate plot info
dp = table;
dp.cnd(1:plotN) = "";
dp.time(:) = nan;
dp.frq(:) = "";
dp.frqD(:) = "";
dp.d = cell(plotN,1);


%% Main: loop across conds/times/freqs
for c = 1:condN % conds loop
    for t = 1:timeN % times loop
        % Plot data table template (see 'd' vars in 'ec_plotCortex')
        d0 = chs(:,["sbjCh" "pos" "hem" "lat" "gyrus" "ECoG"]);
        d0.marker(:) = op.nsMark(:); % marker shape/line style (string) -- see LineStyle in MATLAB line properties
        d0.col = repmat(op.nsCol,height(d0),1); % marker face color (numeric): [R G B]  -- see MarkerFaceColor in MATLAB line properties
        d0.bCol = repmat(op.bCol,height(d0),1); % marker border color (numeric): [R G B] -- see MarkerEdgeColor in MATLAB line properties)
        d0.sz(:) = op.nsSz; % marker size (numeric) -- see MarkerSize in MATLAB line properties
        d0.bSz(:) = op.bSz; % marker border/line size (numeric) --- see plot.LineSize in MATLAB line properties
        d0.order(:) = -inf;

        % Get stats data for plot
        sp = stats(stats.cnd==conds(c) & stats.time==times(t),:);
        if height(sp)~=height(d0)
            warning("[ec_plotTimesCortex] Unequal heights for plot stats & channel tables: "+...
            "c="+conds(c)+" t="+times(t));
        end
        
        % Remove missing stats chans from plot table
        d0(~ismember(d0.sbjCh,sp.sbjCh),:) = [];
        % Order stats data by chs
        [~,idx] = ismember(d0.sbjCh,sp.sbjCh);
        sp = sp(idx,:);

        %% Loop across freqs
        for f = 1:frqN
            % Get plot number
            p = sub2ind([timeN frqN condN],t,f,c);

            % Get freq info
            frq = frqs.name(f); % freq name
            if ismember("disp",frqs.Properties.VariableNames)
                frqD = frqs.disp(f); % freq display name
            else
                frqD = frq;
            end

            % Find significant chans
            if isany(op.sigVar) && isany(op.sigThr)
                idx = sp.(op.sigVar)(:,f) <= op.sigThr;
            else
                idx = true(height(d0),1);
            end
            
            %% Make plot data
            d = d0;

            % Get colors from colormap (sig chans)
            [d.col(idx,:),d.order(idx)] = ec_colorsFromValues(...
                sp.(op.actVar)(idx,f),op.cmap,op.clim);

            % Abs-magnitude sort key (so largest |actVar| renders on top of others)
            d.absVal = zeros(height(d),1);
            d.absVal(idx) = abs(sp.(op.actVar)(idx,f));

            % Other properties (sig chans)
            d.marker(idx) = op.marker; % marker type
            d.sz(idx) = op.markSz; % marker size

            % Add activation & significance
            if op.test
                d.(op.actVar) = sp.(op.actVar)(:,f);
                d.(op.sigVar) = sp.(op.sigVar)(:,f);
            end

            % Save
            dp.d{p} = d;
            dp.cnd(p) = conds(c);
            dp.time(p) = times(t);
            dp.frq(p) = frq;
            dp.frqD(p) = frqD;
        end
    end
end

% Finalize
dp.cnd = categorical(dp.cnd,conds,Ordinal=true);
dp.frq = categorical(dp.frq,frqs.name,Ordinal=true);






%%% Run individual images per plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function indiv_lfn(dp,op)
% Make directory
dirOut = op.dirOut+op.indiv.saveDir+filesep;
if ~exist(dirOut,"dir")
    mkdir(dirOut); end
conds = categories(dp.cnd);

%% Loop across plots
nWorkers = inf;
if isfield(op,"parallel") && ~op.parallel
    nWorkers = 0; % serialize (MATLAB can crash on large figs in parallel workers)
end
parfor (p = 1:height(dp), nWorkers)
    plotIndiv_lfn(dp(p,:),op,conds,dirOut);
end






%%% Plot individual image %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotIndiv_lfn(dpp,op,conds,dirOut)
% Title text (omit cnd segment when empty/missing)
if isany(dpp.frq); txt = dpp.frqD+" | "; else; txt = ""; end
if ~ismissing(dpp.cnd) && string(dpp.cnd)~=""
    txt = txt + string(dpp.cnd)+" | "; end
txt = txt + dpp.time+op.timeUnit;

% Initialize figure (docked forces visible; use normal+invisible for headless save)
if op.test; ws = "docked"; else; ws = "normal"; end
h = figure(Position=[0 0 op.indiv.res],Visible=op.test,WindowStyle=ws,...
    Theme="light",Color="w");

% Plot cortex (dpp.d is a 1×1 cell column — extract the inner table; also drop non-sig rows)
d = dpp.d{1};
d(d.order==-inf,:) = [];
ec_plotCortex("L",["lateral","medial"],d,h,sbj=op.fsSbj,sbjDir=op.fsDir,...
    cort=op.cort,surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.test,...
    title=txt,titleSz=op.txtSz,labelVars=op.labelVars,flip=true,order="ascend",...
    sortMethod=op.sortMethod);

%% Save
if op.save && ~op.test
    c = find(conds==dpp.cnd);
    fn = dirOut+c+"_"+string(dpp.cnd)+"_"+string(dpp.frq)+"_"+dpp.time+".jpg";
    drawnow; % force render before capture (hidden figs aren't auto-rendered)
    % exportgraphics is generally faster but not safe inside parfor workers
    if isfield(op,"parallel") && ~op.parallel
        exportgraphics(h,fn,Resolution=150);
    else
        print(h,fn,"-djpeg","-r150");
    end
    disp("[ec_PlotTimesCortex] saved: "+fn);
    delete(h);
end






%%% Plot per condition showing times & freqs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function conds_lfn(dp,op)
% Make directory
dirOut = op.dirOut+op.cond.saveDir+filesep;
if ~exist(dirOut,"dir")
    mkdir(dirOut); end

% Split plot data by cond for parfor
dp = splitapply(@(ci){dp(ci,:)},(1:height(dp))',findgroups(dp.cnd));

%% Loop across plots
nWorkers = inf;
if isfield(op,"parallel") && ~op.parallel
    nWorkers = 0; % serialize (MATLAB can crash on large figs in parallel workers)
end
parfor (c = 1:numel(dp), nWorkers)
    %%
    plotCond_lfn(dp{c},c,dirOut,op);
end






%%% Plot condition (subplots of times & freqs) %%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotCond_lfn(dc,c,dirOut,op)
% dc = dp(dp.cnd=="Other",:);
times = unique(dc.time);
frqs = string(categories(dc.frq));
timesN=numel(times); frqN=numel(frqs);

% Order by tiledorder
dc = sortrows(dc,["time" "frq"],"ascend");
dc.cnd = string(dc.cnd);
dc.frq = string(dc.frq);

% Initialize figure (docked forces visible; use normal+invisible for headless save)
if op.test; ws = "docked"; else; ws = "normal"; end
h = figure(Position=[0 0 op.cond.res],Visible=op.test,WindowStyle=ws,...
        Theme="light",Color="w");

% Initialize tiledlayout
ht = tiledlayout(h,timesN,frqN,TileSpacing="compact",padding="tight"); % tiledlayout

% Title (skip when cndLabel is empty/missing)
if any(op.txtSz) && ~ismissing(dc.cnd(1)) && string(dc.cnd(1))~=""
    title(ht,dc.cnd(1),FontSize=op.txtSz*1.5,FontWeight="bold"); end


%% Loop across subplots
for p = 1:height(dc)
    %%
    if frqN>1; txt = dc.frqD(p)+" | "; else; txt = ""; end
    txt = txt + dc.time(p)+op.timeUnit; % Title text

    % Sig elecs only
    d = dc.d{p};
    d(d.order==-inf,:) = [];

    % Plot cortex
    ec_plotCortex("L",["lateral","medial"],d,ht,sbj=op.fsSbj,sbjDir=op.fsDir,...
        cort=op.cort,surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.test,...
        title=txt,titleSz=op.txtSz,labelVars=op.labelVars,flip=true,order="ascend",...
        sortMethod=op.sortMethod,tile=p);
end

%% Save
if op.save && ~op.test
    fn = dirOut+c+"_"+dc.cnd(1)+".jpg";
    drawnow; % force render before capture (hidden figs aren't auto-rendered)
    % exportgraphics is generally faster but not safe inside parfor workers
    if isfield(op,"parallel") && ~op.parallel
        exportgraphics(h,fn,Resolution=150);
    else
        print(h,fn,"-djpeg","-r150");
    end
    disp("[ec_PlotTimesCortex] saved: "+fn);
    delete(ht); delete(h);
end




%%% Compose mode: parfor-render tiles → cache RGB → compose serially %%%%%
function condsCompose_lfn(dp,op)
% Renders each (cnd, time, freq) tile in parallel as a small lateral+medial
% figure, captures RGB into memory, then composes into a tiledlayout per cnd
% by imshow-ing the cached arrays. Lets parfor reach full worker count even
% when there's only one contrast.

dirOut = op.dirOut+op.cond.saveDir+filesep;
if ~exist(dirOut,"dir"); mkdir(dirOut); end

% Stable order for composition: by cnd, then time, then freq
dp = sortrows(dp,["cnd" "time" "frq"],"ascend");

conds = unique(dp.cnd,"stable");
times = unique(dp.time);
frqs  = string(unique(dp.frq,"stable"));
nT = numel(times); nF = numel(frqs);

% Optimal per-tile resolution. Account for vertical space consumed by titles:
%   - master title (overarching cnd at top): ~op.txtSz*1.5 font + leading + padding
%   - per-tile title (freq | time): ~op.txtSz font + leading + padding
% Rough estimate (px): font_pt * 1.33 (pt→px at 96dpi) * 1.5 (line height + pad)
ovrTitleH = 0; tileTitleH = 0;
if any(op.txtSz)
    ovrTitleH  = round(op.txtSz * 1.5 * 1.33 * 1.5); % e.g. txtSz=10 → ~30px
    tileTitleH = round(op.txtSz * 1.33 * 1.5);       % e.g. txtSz=10 → ~20px
end
availW = op.cond.res(1);
availH = op.cond.res(2) - ovrTitleH;
tileW  = max(64, round(availW / nF));
tileH  = max(64, round(availH / nT) - tileTitleH);
tileRes = [tileW, tileH];
fprintf("[ec_PlotTimesCortex:compose] grid=%dx%d, op.cond.res=[%d %d], titles=[ovr=%d tile=%d], tileRes=[%d %d]\n",...
    nT, nF, op.cond.res(1), op.cond.res(2), ovrTitleH, tileTitleH, tileRes(1), tileRes(2));

% PHASE 1 — parfor render each tile to RGB
nWorkers = inf;
if isfield(op,"parallel") && ~op.parallel
    nWorkers = 0; % serialize
end
rgbs = cell(height(dp),1);
parfor (p = 1:height(dp), nWorkers)
    rgbs{p} = renderTileRGB_lfn(dp(p,:),op,tileRes); %#ok<PFBNS>
end

% PHASE 2 — compose each cnd's tiledlayout serially
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
                if nF>1
                    ttxt = frqs(f)+" | "+times(t)+op.timeUnit;
                else
                    ttxt = times(t)+op.timeUnit;
                end
                title(ax,ttxt,FontSize=op.txtSz);
            end
        end
    end
    if op.save && ~op.test
        fn = dirOut+c+"_"+cnd+".jpg";
        drawnow;
        % -r0 uses screen DPI → output JPG matches figure Position exactly (op.cond.res)
        print(h,fn,"-djpeg","-r0");
        disp("[ec_PlotTimesCortex] saved (compose): "+fn);
        delete(h);
    end
end




%%% Render one tile (lateral+medial) and return RGB %%%%%%%%%%%%%%%%%%%%%%%
function rgb = renderTileRGB_lfn(dpp,op,tileRes)
% Build a small lateral+medial figure for one (cnd, time, freq) tile,
% capture as RGB, delete. Runs inside parfor.
d = dpp.d{1};
d(d.order==-inf,:) = [];

h = figure(Position=[0 0 tileRes],Visible="off",WindowStyle="normal",...
    Theme="light",Color="w");
try
    ec_plotCortex("L",["lateral","medial"],d,h,sbj=op.fsSbj,sbjDir=op.fsDir,...
        cort=op.cort,surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=false,...
        title="",titleSz=0,labelVars=op.labelVars,flip=true,order="ascend",...
        sortMethod=op.sortMethod);
    drawnow;
    % -r0 = screen DPI → captured RGB matches Position exactly (tileRes pixels)
    rgb = print(h,"-RGBImage","-r0");
catch ME
    delete(h);
    rethrow(ME);
end
delete(h);




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