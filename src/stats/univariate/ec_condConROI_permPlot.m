function ec_condConROI_permPlot(op)
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

% Load logs
fn = dirs.anal+o.roiDir+filesep+o.roiName+filesep+"logs_"+o.roiName;
load(fn,"logs");
disp("[ec_condConROI_permPlot] Loaded: "+fn+" | toc="+toc(tt));

% Load 'n' of first subject to get times/other info
load(logs.n(1),"n");
disp("[ec_condConROI_permPlot] Loaded 'n' of 1st subject: "+logs.n(1)+" | toc="+toc(tt));

% Get frequency ticks
[~,op.fTicks] = min(abs(n.spect.freq - op.freqs),[],1);

% Get color limits
if ~isfield(op,"clim")
    op.clim = max(abs(st.(op.mVar)),[],"all","omitmissing");
    op.clim = [-op.clim op.clim] * 0.5;
end


%%
for r = 1:numel(o.ROIs)
    plotROI_lfn(st(st.roi==o.ROIs(r),:),r,o,op,tt);
end






function plotROI_lfn(str,r,o,op,tt)
%%% Plot ROI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                         r=1; str=st(st.roi==o.ROIs(r),:);

% Prep
roi = o.ROIs(r); % current ROI
contrasts = unique(str.contrast,"stable"); % get contrasts


%% Initialize figure
h = figure(Position=[0 0 op.res],Visible=op.visible,WindowStyle="normal",...
    Theme="light",Color="w");

% Initialize tiledlayout
ht = tiledlayout(h,"flow",TileSpacing="compact",padding="tight"); % tiledlayout

% Title
if op.txtSzTitle
    title(ht,roi,FontSize=op.txtSzTitle,Color=op.txtCol,FontWeight="bold");
end


%% Plot contrasts
for c = 1:numel(contrasts)
    % Prep
    con = contrasts(c);
    
    % Indices
    idc = str.contrast==con; % contrast
    sig = str.(op.sigVar)(idc,:)<op.sigThr; % significant elements

    % Measure data
    m = str.(op.mVar)(idc,:);

    % Alpha transparency (significant = nontransparent)
    ma = ones(size(m)) * op.alpha;
    ma(sig) = 1;


    %% Subplot

    % Initialize subplot
    ha = nexttile(ht);

    % Plot measure
    imagesc(ha,m',AlphaData=ma',XData=str.time(idc));

    % Set properties
    colormap(ha,flip(cbrewer2('RdBu'))); %"turbo" %flip(cbrewer2('RdBu'))
    clim(ha,op.clim*.5);
    ha.YDir = "normal";
    ha.FontSize=op.txtSzAx;

    % Frequency ticks
    yticks(ha,op.fTicks);
    yticklabels(ha,op.freqs)

    % Title
    if op.txtSz
        title(ha,con,FontSize=op.txtSz,Color=op.txtCol,FontWeight="normal");
    end


end


%% Save fig
fn = op.figPath+r+"_"+roi+".jpg";
print(h,fn,"-djpeg","-r150");
disp("SAVED: "+fn+" | toc="+toc(tt));
delete(h);