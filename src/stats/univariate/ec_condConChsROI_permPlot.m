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
    plotROIs = string(op.ROIs);
else
    plotROIs = string(o.ROIs);
end
for r = 1:numel(plotROIs)
    str = st(st.roi==plotROIs(r),:);
    if isempty(str); continue; end
    plotROI_lfn(str,r,plotROIs(r),op,tt);
end




function plotROI_lfn(str,r,roi,op,tt)
%%% Plot ROI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                         r=1; str=st(st.roi==plotROIs(r),:);
contrasts = unique(str.contrast,"stable");


%% Initialize figure
h = figure(Position=[0 0 op.res],Visible=op.visible,WindowStyle="normal",...
    Theme="light",Color="w");

% Initialize tiledlayout
ht = tiledlayout(h,"flow",TileSpacing="compact",padding="tight");

% Title
if op.txtSzTitle
    title(ht,roi,FontSize=op.txtSzTitle,Color=op.txtCol,FontWeight="bold");
end


%% Plot contrasts
for c = 1:numel(contrasts)
    con = contrasts(c);

    % Indices
    idc = str.contrast==con;
    sig = str.(op.sigVar)(idc,:)<op.sigThr;

    % Measure data
    m = str.(op.mVar)(idc,:);

    % Alpha transparency (significant = nontransparent)
    ma = ones(size(m)) * op.alpha;
    ma(sig) = 1;


    %% Subplot
    ha = nexttile(ht);

    % Title
    if op.txtSz
        title(ha,con,FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
    end

    % Plot measure
    imagesc(ha,m',AlphaData=ma',XData=str.time(idc));

    % Set properties
    colormap(ha,flip(cbrewer2('RdBu')));
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
fn = op.figPath+r+"_"+roi+".jpg";
print(h,fn,"-djpeg","-r150");
disp("SAVED: "+fn+" | toc="+toc(tt));
delete(h);
