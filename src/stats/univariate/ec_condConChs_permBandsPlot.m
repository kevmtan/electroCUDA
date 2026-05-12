function ec_condConChs_permBandsPlot(op)
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

% Figure out error bar type
stVars = string(st.Properties.VariableNames);
if any(ismember(stVars,["ciL" "ciH"]))
    op.errType = "ci";
elseif any(ismember(stVars,"se"))
    op.errType = "se";
else
    op.errType = "";
    warning("Unknown error bar type (CI/SE");
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


%% Legend
ha = nexttile(ht);
% Plot contrast colors
for c = 1:numel(op.contrasts)
    plot(ha,0,0,'o',Color=op.cols(c,:),MarkerFaceColor=op.cols(c,:));
    hold on
end
% Legend
lgd = legend(ha,op.contrasts,"FontSize",op.txtSz,"Location","west","AutoUpdate","off");
plot(ha,0,0,'o',MarkerSize=op.markSz,Color=[1 1 1],MarkerFaceColor=[1 1 1]); % remove cols
title(lgd,"Contrast"); axis off; hold off;


%% Plot Bands
for b = 1:height(n.spect)
    % Initialize subplot
    ha = nexttile(ht);

    % Band subplot title
    if op.txtSz
        title(ha,n.spect.disp(b),FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
    end

    %% Loop across contrasts
    for c = 1:numel(op.contrasts)
        % Prep MSEB opts
        opc = op.c;
        opc.col{1} = op.cols(c,:);

        % Contrast index
        idc = stc.contrast==op.contrasts(c);

        % Mean
        m = stc.mu(idc,b);

        % Error
        if op.errType=="se"
            err = stc.se(idc,b); % standard error
        elseif op.errType=="ci"
            err = [stc.ciL(idc,b) stc.ciH(idc,b)]; % Confidence interval
        else
            err = zeros(height(m,1)); % none
        end

        % Find significant timepoints
        iSig = stc.(op.sigVar)(idc,b)<op.sigThr;

        % Limit to sig time range
        if any(op.sigTimeRng) && numel(op.sigTimeRng)==2
            id = stc.time(idc)>=op.sigTimeRng(1) & stc.time(idc)<=op.sigTimeRng(2);
            iSig(~id) = false;
        end

        % Make significant timecourse
        sig = m;
        sig(~iSig) = nan;

        
        %% Plot

        % Plot contrast timecourse & error
        ec_mseb(stc.time(idc)',m',err',opc,1);
        hold on; axis tight;

        % Plot significant timepoints
        plot(ha,stc.time(idc),sig',".-",Color=op.cols(c,:),...
            MarkerFaceColor=op.cols(c,:),LineWidth=op.c.wSig);

        % Plot time/mean=0
        plot(ha,xlim,[0 0],"k-","LineWidth",op.limWidth);
        plot(ha,[0 0],ylim,"k-","LineWidth",op.limWidth);
    end

    % Set axis properties
    ha.FontSize = op.txtSzAx;
    hold off;
end


%% Save fig
fn = op.sbjFigDir+sbjCh+".jpg";
print(h,fn,"-djpeg","-r150");
disp("SAVED: "+fn+" | toc="+toc(tt));
delete(h);
