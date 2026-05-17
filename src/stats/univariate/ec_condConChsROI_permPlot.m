function ec_condConChsROI_permPlot(op)
arguments
    op struct
end


%% Prep
tt = tic; % start timer

% Load analysis files
load(op.analDir+"o.mat","o"); % analysis options
load(op.analDir+"st.mat","st"); % stats results

% Figure directory path
op.figPath = op.analDir+op.figDir+filesep;
if ~isfolder(op.figPath)
    mkdir(op.figPath);
end

% Get dirs
dirs = ec_getDirs(o.proj,o.task);

% Load channelwise logs to get 'n' with spectral freq info
fn = dirs.anal+o.chsDir+filesep+o.chsName+filesep+"logs_"+o.chsName;
load(fn,"logs");
disp("[ec_condConChsROI_permPlot] Loaded: "+fn+" | toc="+toc(tt));

% Load 'n' of first subject for times/freq info
load(logs.n(1),"n");
disp("[ec_condConChsROI_permPlot] Loaded 'n' of 1st sbj: "+logs.n(1)+" | toc="+toc(tt));

% Get frequency ticks
[~,op.fTicks] = min(abs(n.spect.freq - op.freqs),[],1);

% Get color limits
if ~isfield(op,"clim")
    op.clim = max(abs(st.(op.mVar)),[],"all","omitmissing");
    op.clim = [-op.clim op.clim] * 0.5;
end


%% Plot ROIs (op.ROIs sets order; falls back to o.ROIs)
if isfield(op,"ROIs") && isany(op.ROIs)
    op.ROIs = string(op.ROIs);
else
    op.ROIs = string(o.ROIs);
end

% Loop across ROIs
for r = 1:numel(op.ROIs)
    str = st(st.roi==op.ROIs(r),:);
    if isempty(str); continue; end
    plotROI_lfn(str,r,op,tt);
end




function plotROI_lfn(str,r,op,tt)
%%% Plot ROI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                         r=1; str=st(st.roi==plotROIs(r),:);
contrasts = unique(str.contrast,"stable");
roi = op.ROIs(r);


%% Initialize figure
if ~op.indiv
    h = figure(Position=[0 0 op.res],Visible=op.visible,WindowStyle="normal",...
        Theme="light",Color="w");

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
        title(ht,roi,FontSize=op.txtSzTitle,Color=op.txtCol,FontWeight="bold");
    end
end


%% Plot contrasts
for c = 1:numel(contrasts)
    % Contrast
    con = contrasts(c);
    idc = str.contrast==con; % indices

    % Significant values
    sig = str.(op.sigVar)(idc,:)<op.sigThr;

    % Limit significance to time range
    if any(op.sigTimeRng) && numel(op.sigTimeRng)==2 && op.sigThr<1
        id = str.time(idc)>=op.sigTimeRng(1) & str.time(idc)<=op.sigTimeRng(2);
        sig(~id,:) = false;
    end

    % Measure data
    m = str.(op.mVar)(idc,:);

    % Alpha transparency (significant = nontransparent)
    ma = ones(size(m)) * op.sigAlpha;
    ma(sig) = 1;
    % if op.sigAlpha
    %     ma = ones(size(m)) * op.sigAlpha;
    %     ma(sig) = 1;
    % else
    %     m(~sig) = nan;
    % end


    %% Subplot
    if ~op.indiv
        ha = nexttile(ht);
    else
        h = figure(Position=[0 0 op.res],Visible=op.visible,WindowStyle="normal",...
            Theme="light",Color="w");
        ha = gca;
    end

    % Plot measure
    imagesc(ha,m',AlphaData=ma',XData=str.time(idc));
    % if op.sigAlpha
    %     imagesc(ha,m',AlphaData=ma',XData=str.time(idc));
    % else
    %     imagesc(ha,m',XData=str.time(idc));
    % end

    % Colormap
    cmap = flip(cbrewer2('RdBu'));
    % if ~op.sigAlpha && any(~sig,"all")
    %     cmap = [1 1 1; cmap]; %#ok<AGROW>
    % end
    colormap(ha,cmap);


    % Set properties
    
    clim(ha,op.clim);
    ha.YDir = "normal";
    ha.FontSize = op.txtSzAx;

    % Frequency ticks
    yticks(ha,op.fTicks);
    yticklabels(ha,op.freqs);

    % Plot time=0
    hold on;
    plot(ha,[0 0],ylim,"k-","LineWidth",op.limWidth);
    hold off;

    % Title
    if op.txtSz
        title(ha,con,FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
    end

    if op.indiv
        fn = op.figPath+r+"_"+roi+"_"+c+"_"+con+".jpg";
        exportgraphics(ha,fn);
        %print(h,fn,"-djpeg","-r150");
        disp("SAVED: "+fn+" | toc="+toc(tt));
        delete(h);
    end
end


%% Save fig
if ~op.indiv
    fn = op.figPath+r+"_"+roi+".jpg";
    exportgraphics(ht,fn);
    %print(h,fn,"-djpeg","-r150");
    disp("SAVED: "+fn+" | toc="+toc(tt));
    delete(h);
end
