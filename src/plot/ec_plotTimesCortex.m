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
if logp.ICA
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


%% Plot individual
if op.indiv.do
    indiv_lfn(dp,op);
end


%% Plot gallery of times & freqs (separate per cond)
if op.cond.do
    conds_lfn(dp,op);
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
parfor p = 1:height(dp)
    plotIndiv_lfn(dp(p,:),op,conds,dirOut);
end






%%% Plot individual image %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotIndiv_lfn(dpp,op,conds,dirOut)
% Title text
if isany(dpp.frq); txt = dpp.frqD+" | "; else; txt = ""; end
txt = txt + string(dpp.cnd)+" | "+dpp.time+op.timeUnit;

% Initialize figure
h = figure(Position=[0 0 op.cond.res],Visible=op.test,WindowStyle="docked",...
    Theme="light",Color="w");

% Plot cortex
ec_plotCortex("L",["lateral","medial"],dpp.d,h,sbj=op.fsSbj,sbjDir=op.fsDir,...
    surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.test,...
    title=txt,titleSz=op.txtSz,labelVars=op.labelVars,flip=true,order="ascend");

%% Save
if op.save && ~op.test
    c = find(conds==dpp.cnd);
    fn = dirOut+c+"_"+string(dpp.cnd)+"_"+string(dpp.frq)+"_"+dpp.time+".jpg";
    print(h,fn,"-djpeg","-r150");
    % exportgraphics(h,fn,Resolution=150);
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
parfor c = 1:numel(dp)
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

% Initialize figure
h = figure(Position=[0 0 op.cond.res],Visible=op.test,WindowStyle="docked",...
        Theme="light",Color="w");

% Initialize tiledlayout
ht = tiledlayout(h,timesN,frqN,TileSpacing="compact",padding="tight"); % tiledlayout

% Title
if any(op.txtSz)
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
    ec_plotCortex("L",["lateral","medial"],d,ht,sbj=op.fsSbj,sbjDir=op.fsDir,......
        surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.test,...
        title=txt,titleSz=op.txtSz,labelVars=op.labelVars,flip=true,order="ascend",...
        tile=p);
end

%% Save
if op.save && ~op.test
    fn = dirOut+c+"_"+dc.cnd(1)+".jpg";
    print(h,fn,"-djpeg","-r150");
    % exportgraphics(h,fn,Resolution=150);
    disp("[ec_PlotTimesCortex] saved: "+fn);
    delete(ht); delete(h);
end





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