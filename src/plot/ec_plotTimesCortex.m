function ec_plotTimesCortex(logp,op)
% Plot cortical timecourses from statistical results

%% Input validation
arguments
    logp table % Log output from statistical analysis
    op struct % Plot options
end


%% Prep

% Determine if running within a function
stack = dbstack;
if numel(stack) <= 1
    op.test = true; end

sbjs = logp.i{:}; % get subjects from analysis
sbjN = height(sbjs); % number of subjects
o = sbjs.o{1}; % options from stats

% Preallocate
stat = cell(sbjN,1); % stats data
chs = cell(sbjN,1); % channel info

% Load subject data
for s = 1:sbjN
    % Get directory of subject stats data
    if isany(sbjs.o{s}.dirOutSbj)
        fn = sbjs.o{s}.dirOutSbj;
    elseif isany(sbjs.o{s}.dirOut)
        fn = sbjs.o{s}.dirOut;
    else
        error("No stats output directory: s"+sbjs.sbjID(s));
    end

    % Load stats data
    fn = fn+"s"+sbjs.sbjID(s)+"_"+op.statsFn+".mat";
    stat{s} = load(fn,op.statsVar);
    stat{s} = stat{s}.(op.statsVar);
    disp("Loaded: "+fn);

    % Load channel info
    if sbjs.o{s}.ICA
        n = ec_loadSbj(sbjs.o{s}.dirs,vars="n",compact="n");
        chs{s} = n.icNfo;
        chs{s}.bad = n.icBad;
        chs{s}.sbjID(:) = n.sbjID;
        % TODO: concactenate fsNfo
    else
        chs{s} = ec_loadSbj(sbjs.o{s}.dirs,vars="chNfo");
    end
end

% Concactenate sbj data
stat = vertcat(stat{:}); % stats data
chs = vertcat(chs{:}); % channel info
if op.test; statOg=stat; chsOg=chs; end %#ok<NASGU>

% Remove channels not in stats data
chs(~ismember(chs.sbjCh,stat.sbjCh),:) = [];

% Order channels
if logp.ICA
    chs = sortrows(chs,["sbjID" "ic"]);
else
    chs = sortrows(chs,["sbjID" "ch"]);
end
% Order dat by chs
[~,idx] = ismember(chs.sbjCh,stat.sbjCh);
stat = stat(idx,:);

% Remove chans with no MNI coords
idx = isnan(chs.MNI(:,1));
chs(idx,:) = [];
stat(idx,:) = [];

% Remove bad chans
for v = 1:numel(op.chBadFields)
    idx = chs.bad.(op.chBadFields(v));
    chs(idx,:) = [];
    stat(idx,:) = [];
end

% Concactenate stats data across chans
stat = vertcat(stat.s{:});

% Rename target vars
chs = renamevars(chs,op.posVar,"pos"); % electrode position
stat = renamevars(stat,[op.timeVar op.condVar],["t" "c"]); % time & condition/contrast/test


%% Make plot data
dp = makePlotData_lfn(stat,chs,op,o);


%% Plot individual
if op.indiv.do
    indiv_lfn(dp,op,o);
end


%% Plot gallery of times & freqs (separate per cond)
if op.cond.do
    conds_lfn(dp,op,o);
end






%%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%% Make plot data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dp = makePlotData_lfn(stat,chs,op,o)

% Get conds/contrasts/tests to plot
if isany(op.conds)
    conds = op.conds;
elseif iscategorical(stat.c)
    conds = string(categories(stat.c));
else
    conds = unique(stat.c,"stable");
end

% Get times to plot
if isany(op.times)
    times = op.times;
else
    times = unique(stat.t);
end

% Get freqs to plot
if isany(op.frqs)
    [~,idx] = ismember(op.frqs,o.spect.name);
    frqs = o.spect(idx,:);
else
    frqs = o.spect;
end

% Get counts
condN = numel(conds);
timeN = numel(times);
frqN = height(frqs);
plotN = condN * timeN * frqN;

% Preallocate plot info
dp = table;
dp.cond(1:plotN) = "";
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
        d0.bSz(:) = 0; % marker border/line size (numeric) --- see plot.LineSize in MATLAB line properties
        d0.order(:) = -inf;

        % Get stats data for plot
        sp = stat(stat.c==conds(c) & stat.t==times(t),:);
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
            if frqN > 1
                frqV = "_"+frq; % freq var
            else
                frq = "";
                frqV = "";
            end
            if ismember("disp",frqs.Properties.VariableNames)
                frqD = frqs.disp(f); % freq display name
            else
                frqD = frq;
            end

            % Find significant chans
            if isany(op.sigVar) && isany(op.sigThr)
                idx = sp.(op.sigVar+frqV) <= op.sigThr;
            else
                idx = true(height(d0),1);
            end
            
            %% Make plot data
            d = d0;

            % Get colors from colormap (sig chans)
            [d.col(idx,:),d.order(idx)] = ec_colorsFromValues(...
                sp.(op.actVar+frqV)(idx),op.cmap,op.clim);

            % Other properties (sig chans)
            d.marker(idx) = op.marker; % marker type
            d.sz(idx) = op.markSz; % marker size

            % Add activation & significance
            if op.test
                d.(op.actVar) = sp.(op.actVar+frqV);
                d.(op.sigVar) = sp.(op.sigVar+frqV);
            end

            % Save
            dp.d{p} = d;
            dp.cond(p) = conds(c);
            dp.time(p) = times(t);
            dp.frq(p) = frq;
            dp.frqD(p) = frqD;
        end
    end
end

% Finalize
dp.cond = categorical(dp.cond,conds,Ordinal=true);
dp.frq = categorical(dp.frq,frqs.name,Ordinal=true);






%%% Make individual images per plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function indiv_lfn(dp,op,o)
% Make directory
dirOut = o.dirOut+op.indiv.saveDir+filesep;
if ~exist(dirOut,"dir")
    mkdir(dirOut); end
conds = string(categories(dp.cond));

%% Loop across plots
for p = 1:height(dp)
    % Title text
    if isany(dp.frq); txt = dp.frqD(p)+" | "; else; txt = ""; end
    txt = txt + string(dp.cond(p))+" | "+dp.time(p)+op.timeUnit;

    % Initialize figure
    if op.test
        h = figure(Position=[0 0 op.cond.res],Visible=op.test,WindowStyle="docked",...
            Theme="light",Color="w",AutoResizeChildren="on");
    else
        h = figure(Position=[0 0 op.cond.res],Visible=op.test,WindowState="normal",...
            Theme="light",Color="w",DockControls="off");
    end
    
    % Plot cortex
    ec_plotCortex("L",["lateral","medial"],dp.d{p},h,sbjDir=o.dirs.freesurfer,...
        surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.test,...
        title=txt,titleSz=op.txtSz,labelVars=op.labelVars,flip=true,order="ascend");

    %% Save
    if op.save
        c = find(conds==dp.cond(p));
        fn = dirOut+c+"_"+string(dp.cond(p))+"_"+string(dp.frq(p))+"_"+dp.time(p)+".png";
        exportgraphics(h,fn,Resolution=150);
        disp("[ec_PlotTimesCortex] saved: "+fn);
        delete(h);
    end

end






%%% Plot per condition showing times & freqs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function conds_lfn(dp,op,o)
% Make directory
dirOut = o.dirOut+op.cond.saveDir+filesep;
if ~exist(dirOut,"dir")
    mkdir(dirOut); end

conds = string(categories(dp.cond));

%% Loop across plots
for c = 1:numel(conds)
    plotCond_lfn(dp(dp.cond==conds(c),:),op,o,c,dirOut);
end






%%% Plot condition (subplots of times & freqs) %%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotCond_lfn(dc,op,o,c,dirOut)
% dc = dp(dp.cond=="Other",:);
times = unique(dc.time);
frqs = string(categories(dc.frq));
timesN=numel(times); frqN=numel(frqs);

% Order by tiledorder
dc = sortrows(dc,["time" "frq"],"ascend");
dc.cond = string(dc.cond);
dc.frq = string(dc.frq);

% Initialize figure
if op.test
    h = figure(Position=[0 0 op.cond.res],Visible=op.test,WindowStyle="docked",...
        Theme="light",Color="w",AutoResizeChildren="on");
else
    h = figure(Position=[0 0 op.cond.res],Visible=op.test,WindowState="normal",...
        Theme="light",Color="w",DockControls="off");
end

% Initialize tiledlayout
ht = tiledlayout(h,timesN,frqN,TileSpacing="compact",padding="tight"); % tiledlayout

% Title
if any(op.txtSz)
    title(ht,dc.cond(1),FontSize=op.txtSz*1.5,FontWeight="bold"); end


%% Loop across subplots
for p = 1:height(dc)
    %%
    if frqN>1; txt = dc.frqD(p)+" | "; else; txt = ""; end
    txt = txt + dc.time(p)+op.timeUnit; % Title text

    % Sig elecs only
    d = dc.d{p};
    d(d.order==-inf,:) = [];
    
    % Plot cortex
    ec_plotCortex("L",["lateral","medial"],d,ht,tile=p,sbjDir=o.dirs.freesurfer,...
        surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.test,...
        title=txt,titleSz=op.txtSz,labelVars=op.labelVars,flip=true,order="ascend");
end

%% Save
if op.save
    fn = dirOut+c+"_"+dc.cond(1)+".png";
    exportgraphics(h,fn,Resolution=150);
    disp("[ec_PlotTimesCortex] saved: "+fn);
    delete(h);
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
