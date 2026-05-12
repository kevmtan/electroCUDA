function ec_condConChs_permSpectPlot(op)
arguments
    op struct
end


%% Prep
tt = tic; % start timer

% Locate & load analysis options ('o_<analName>.mat')
d = dir(op.analDir+"o_*.mat");
if isempty(d)
    error("[ec_condConChs_permSpectPlot] No options file found in: "+op.analDir);
end
fn = op.analDir+string(d(1).name);
load(fn,"o");
disp("[ec_condConChs_permSpectPlot] Loaded: "+fn+" | toc="+toc(tt));

% Figure directory path
op.figPath = op.analDir+op.figDir+filesep;
if ~isfolder(op.figPath); mkdir(op.figPath); end

% Load logs
fn = op.analDir+"logs_"+o.analName+".mat";
load(fn,"logs");
disp("[ec_condConChs_permSpectPlot] Loaded: "+fn+" | toc="+toc(tt));


%% Loop subjects
parfor s = 1:height(logs)
    plotSbj_lfn(logs(s,:),op,tt);
end




function plotSbj_lfn(sLog,op,tt)
%%% Plot subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                       s=5; sLog=logs(s,:);

% Load stats & metadata
load(sLog.st,"st");
load(sLog.n,"n");
disp("[ec_condConChs_permSpectPlot] Loaded sbj: "+sLog.sbj+" | toc="+toc(tt));

% Get contrasts
if ~isfield(op,"contrasts") || ~isany(op.contrasts)
    op.contrasts = unique(st.contrast,"stable");
end

% Frequency ticks
[~,op.fTicks] = min(abs(n.spect.freq - op.freqs),[],1);

% Auto color limits if not specified
if ~isfield(op,"clim") || isempty(op.clim)
    op.clim = max(abs(st.(op.mVar)),[],"all","omitmissing");
    op.clim = [-op.clim op.clim] * 0.5;
end

% Get channels
chs = unique(st.sbjCh,"stable");

% Plot data table template (see 'd' vars in 'ec_plotCortex')
chNfo = renamevars(n.chNfo,op.posVar,"pos"); % rename position var
d0 = chNfo(:,["sbjCh" "ch" "pos" "hem" "lat" "gyrus" "ECoG"]);
d0.marker(:) = op.nsMark(:); % marker shape/line style (string) -- see LineStyle in MATLAB line properties
d0.col = repmat(op.nsCol,height(d0),1); % marker face color (numeric): [R G B]  -- see MarkerFaceColor in MATLAB line properties
d0.bCol = repmat(op.bCol,height(d0),1); % marker border color (numeric): [R G B] -- see MarkerEdgeColor in MATLAB line properties)
d0.sz(:) = op.nsSz; % marker size (numeric) -- see MarkerSize in MATLAB line properties
d0.bSz(:) = op.bSz; % marker border/line size (numeric) --- see plot.LineSize in MATLAB line properties
d0.order(:) = -inf;

% Subject figure directory
op.sbjFigDir = op.figPath+"s"+sLog.sbjID+filesep;
if ~isfolder(op.sbjFigDir)
    mkdir(op.sbjFigDir);
end


%% Loop channels
for ch = 1:numel(chs)
    plotCh_lfn(st(st.sbjCh==chs(ch),:),d0,n,op,tt);
end




function plotCh_lfn(stc,d,n,op,tt)
%%% Plot channel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 ch=92; stc=st(st.sbjCh==chs(ch),:); d=d0;                                     

% Channel 
sbjCh = stc.sbjCh(1);
ch = d.sbjCh==sbjCh; % chan index
hem = d.hem(ch);
if ~ismember(hem,["L" "R"])
    hem = ["L" "R"]; end %unique(d.hem(~isnan(d.pos(:,1)))); end

% Mark channel
d.marker(ch) = op.marker;
d.col(ch,:) = op.markCol;
d.sz(ch) = op.markSz;


%% Initialize figure
h = figure(Position=[0 0 op.res],Visible=op.visible,Theme="light",Color="w");

% Initialize tiledlayout
if isnumeric(op.arrange) && numel(op.arrange)==2
    ht = tiledlayout(h,op.arrange(1),op.arrange(2),TileSpacing="compact",padding="tight");
elseif ismember(op.arrange,["flow" "vertical" "horizontal"])
    ht = tiledlayout(h,op.arrange,TileSpacing="compact",padding="tight");
else
    ht = tiledlayout(h,"flow",TileSpacing="compact",padding="tight");
end

% Title
if op.txtSzTitle
    title(ht,replace(sbjCh,"_"," "),FontSize=op.txtSzTitle,Color=op.txtCol,...
        FontWeight="bold");
end


%% Plot cortex
ha = nexttile(ht,[1 2]);
ec_plotCortex(hem,["lateral","medial"],d,ht,sbj=n.sbj,sbjDir=n.dirs.fsSbj,......
    surfType=op.surfType,opacity=op.alpha,pullF=op.pullF,visible=op.visible,...
    flip=false,order="ascend",align=op.align,tile=tilenum(ha),tilespan=[1 2]);
ha.Visible="off";
%axis(ha,"tight"); axis(ha,"equal");


%% Plot contrasts
for c = 1:numel(op.contrasts)
    % Prep
    con = op.contrasts(c);
    idc = stc.contrast==con; % contrast indices

    % Significant tests
    sig = stc.(op.sigVar)(idc,:)<op.sigThr;

    % Limit to sig time range
    if any(op.sigTimeRng) && numel(op.sigTimeRng)==2
       id = n.times>=op.sigTimeRng(1) & n.times<=o.sigTimeRng(2);
       sig(~id,:) = false;
    end

    % Contrast measure
    m = stc.(op.mVar)(idc,:);

    % Alpha transparency (significant = nontransparent)
    ma = ones(size(m)) * op.alphaSig;
    ma(sig) = 1;


    %% Subplot

    % Initialize subplot
    ha = nexttile(ht);

    % Title
    if op.txtSz
        title(ha,con,FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
    end

    % Plot measure
    imagesc(ha,m',AlphaData=ma',XData=stc.time(idc));

    % Set properties
    colormap(ha,flip(cbrewer2('RdBu'))); %"turbo" %flip(cbrewer2('RdBu'))
    clim(ha,op.clim*.5);
    ha.YDir = "normal";
    ha.FontSize = op.txtSzAx;

    % Frequency ticks
    yticks(ha,op.fTicks);
    yticklabels(ha,op.freqs);

    % Plot time=0
    hold on;
    plot(ha,[0 0],ylim,"k-","LineWidth",op.limWidth);
    hold off;    
end


%% Save fig
fn = op.sbjFigDir+sbjCh+".jpg";
print(h,fn,"-djpeg","-r150");
disp("SAVED: "+fn+" | toc="+toc(tt));
delete(h);
