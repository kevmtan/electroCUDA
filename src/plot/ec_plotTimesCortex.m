function ec_plotTimesCortex(logp,opc)
% Plot cortical timecourses from statistical results

%% Input validation
arguments
    logp table % Log output from statistical analysis
    opc struct % Plot options
end


%% Prep
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
    fn = fn+"s"+sbjs.sbjID(s)+"_"+opc.statsFn+".mat";
    stat{s} = load(fn,opc.statsVar);
    stat{s} = stat{s}.(opc.statsVar);
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
if opc.test; statOg=stat; chsOg=chs; end %#ok<NASGU>

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
for v = 1:numel(opc.chBadFields)
    idx = chs.bad.(opc.chBadFields(v));
    chs(idx,:) = [];
    stat(idx,:) = [];
end

% Concactenate stats data across chans
stat = vertcat(stat.s{:});

% Rename target vars
chs = renamevars(chs,opc.posVar,"pos"); % electrode position
stat = renamevars(stat,[opc.timeVar opc.condVar],["t" "c"]); % time & condition/contrast/test


%% Make plot data
dp = makePlotData_lfn(stat,chs,opc,o);


%% Plot individual


%% Gallery of times & freqs per condition





%%%%%%%%%%%%%%%%%%%%%%%%%% Routine subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%





%%% Make plot data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dp = makePlotData_lfn(stat,chs,opc,o)

% Get conds/contrasts/tests to plot
if isany(opc.conds)
    conds = opc.conds;
elseif iscategorical(stat.c)
    conds = string(categories(stat.c));
else
    conds = unique(stat.c,"stable");
end
% Get times to plot
if isany(opc.times); times = opc.times; else; times = unique(stat.t); end
% Get freqs to plot
if isany(opc.frqs)
    [~,idx] = ismember(opc.frqs,o.spect.name);
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

%% Main

% Loop across conds
for c = 1:condN
    cond = conds(c);

    %% Loop across times
    for t = 1:timeN 
        time = times(t);

        % Plot data template (see 'd' vars in 'ec_plotCortex')
        d0 = chs(:,["sbjCh" "pos" "hem" "lat" "gyrus" "ECoG"]);
        d0.line(:) = "."; % marker shape/line style (string) -- see LineStyle in MATLAB line properties
        d0.col(:,1:3) = 0; % marker face color (numeric): [R G B]  -- see MarkerFaceColor in MATLAB line properties
        d0.bCol(:,1:3) = nan; % marker border color (numeric): [R G B] -- see MarkerEdgeColor in MATLAB line properties)
        d0.sz(:) = opc.markSz; % marker size (numeric) -- see MarkerSize in MATLAB line properties
        d0.bSz(:) = 0; % marker border/line size (numeric) --- see plot.LineSize in MATLAB line properties
        d0.order(:) = inf;

        % Get stats data for plot
        sp = stat(stat.c==cond & stat.t==time,:);
        if height(sp)~=height(d0)
            warning("[ec_plotTimesCortex] Unequal heights for plot stats & channel tables: c="+cond+" t="+time); end
        
        % Remove
        d0(~ismember(d0.sbjCh,sp.sbjCh),:) = [];
        % Order stats data by chs
        [~,idx] = ismember(d0.sbjCh,sp.sbjCh);
        sp = sp(idx,:);

        %% Loop across freqs
        for f = 1:frqN
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

            d = d0; % Load template plot data
            p = sub2ind([timeN frqN condN],t,f,c); % Get plot number

            % Find significant chans
            if isany(opc.sigVar)
                idx = sp.(opc.sigVar+frqV) <= opc.sigThr;
            else
                idx = true(height(d),1);
            end
            

            %% Make plot data

            % Get colors from colormap
            [d.col(idx,:),d.order(idx)] = ec_colorbarFromValues(...
                sp.(opc.actVar+frqV)(idx),opc.cmap,opc.clim);
            d.line(idx) = "o"; % marker type
            d.sz(idx) = opc.markSz; % marker size

            % Save
            dp.d{p} = d;
            dp.cond(p) = cond;
            dp.time(p) = time;
            dp.frq(p) = frq;
            dp.frqD(p) = frqD;
        end
    end
end

% Finalize
dp.cond = categorical(dp.cond,conds,Ordinal=true);
dp.frq = categorical(dp.frq,frqs.name,Ordinal=true);





%%% Make individual plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotIndiv_lfn(dp,opc,o)
% Makes individual images for each plot:

% Make directory
dirOut = o.dirOut+opc.indiv.saveDir+filesep;
if ~exist(dirOut,"dir")
    mkdir(dirOut); end

%% Loop across plots
for p = 1:height(dp)
    % Title text
    txt = dp.frqD(p)+" | "+dp.cond(p)+" | "+dp.time(p)+opc.timeUnit;
    
    % Initialize figure
    h = figure(Position=[0 0 opc.indiv.res],Theme="light",Color="w",Visible=opc.test);

    % Plot cortex
    plotCortex_lfn(h,dp.d{p},opc,o.dirs.freesurfer,txt);

    %% Save
    if opc.save
        fn = dirOut+dp.cond(p)+"_"+dp.frq(p)+"_"+dp.time(p)+".png";
        exportgraphics(fn,Resolution=150);
        close all
    end

end





%%% Plot per condition showing times & freqs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function makeCond_lfn(dp,opc,o)
conds = string(categories(dp.cond));
frqs = string(categories(dp.frq));
times = unique(dp.time,"stable");


% Make directory
dirOut = o.dirOut+opc.cond.saveDir+filesep;
if ~exist(dirOut,"dir")
    mkdir(dirOut); end

%% Loop across plots
for p = 1:height(dp)
    % Title text
    txt = dp.frqD(p)+" | "+dp.cond(p)+" | "+dp.time(p)+opc.timeUnit;
    
    % Initialize figure
    h = figure(Position=[0 0 opc.indiv.res],Theme="light",Color="w",Visible=opc.test);

    % Plot cortex
    plotCortex_lfn(h,dp.d{p},opc,o.dirs.freesurfer,txt);

   

    %% Save
    if opc.save
        fn = dirOut+dp.cond(p)+"_"+dp.frq(p)+"_"+dp.time(p)+".png";
        exportgraphics(fn,Resolution=150);
        close all
    end

end










%%%%%%%%%%%%%%%%%%%%%%%%%% Plot subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%% Make individual plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotCortex_lfn(h,d,opc,dirFS,txt)

% Make tiledlayout for lateral/medial
hi = tiledlayout(h,1,2,TileSpacing="none",padding="tight");

% Lateral
ha = nexttile(hi);
ec_plotCortex("L","lateral",d,sbjDir=dirFS,surfType=opc.surfType,...
    opacity=opc.alpha,doGPU=opc.doGPU,save=0,flip=1,pullF=opc.pullF,align=1,...
    parallel=0,order="descend",visible=opc.test,h=ha);

% Medial
ha = nexttile(hi);
ec_plotCortex("L","medial",d,sbjDir=dirFS,surfType=opc.surfType,...
    opacity=opc.alpha,doGPU=opc.doGPU,save=0,flip=1,pullF=opc.pullF,align=1,...
    parallel=0,order="descend",visible=opc.test,h=ha);

if nargin>4 && isany(txt)
    title(hi,txt); end

