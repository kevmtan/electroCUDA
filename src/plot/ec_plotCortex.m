function h = ec_plotCortex(hems,views,d,h,a)
% Plot electrodes on cortical surfaces
%   Wrapper for ec_plotCortexSurf & ec_plotCortexChs (use this to call those functions)
%
% AUTHOR: Kevin Tan, 2025 (github.com/kevmtan/electroCUDA)
% LICENSE: GNU GPL - use at your own risk!
%
% MAIN INPUTS:
%  hems = Hemispheres to plot (strings): "L"|"R"|["L" "R"]
%  views = Plotting views (strings): see 'view angles' in ec_plotCortexSurf
%  d = table of electrode plotting data (omit to plot cortex only)
%     NOTE: required if plotting electrodes on cortex, rows correspond to electrode channels
%     d.pos = position in a.surfType coordinates (numeric): [x y z] -- see FreeSurfer coordinate systems
%     d.hem = brain hemisphere (string): "L"|"R"
%     d.lat = hemisphere side (string): "medial"|"lateral"|"both"
%     d.gyrus = on gyrus? (logical)
%     d.ECoG = electrode type (logical): TRUE for subdural, FALSE for depth
%     d.GM = grey or white matter (logical)
%     d.marker = marker symbol (string): see Matlab scatter chart properties
%     d.col = MarkerFaceColor [R G B]: see Matlab scatter chart properties
%     d.bCol = MarkerEdgeColor [R G B]: only one color per marker symbol
%     d.sz = marker size: see Matlab scatter chart properties
%     d.bSz = marker edge size: see Matlab scatter chart properties
%     d.label = electrode label (string): eg. "sbj10 ch24"
%
% NAME-VALUE INPUTS: see 'arguments' section below
%
% OUPUT:
%  h = graphics handles (graphics array *or* struct of graphics arrays)
%     If 1 hemisphere & view: h = [figure;axis;cortex;light;electrodes]
%     If multiple hemispheres/views:  h.tiledLayout = TiledLayOutChart
%                                     h.hemisphere_view = [axis;cortex;light;electrodes]
%                                    
%       

%% Input arguments
arguments
    hems (1,:) string = ["L","R"] % cortical hemispheres to plot: ["L"|"R"]
    views (1,:) string = ["lateral","medial"] % cortical views to plot (see ec_plotCortexSurf for views)
    d table = []
    h = [] % Figure or TiledLayout handle
    a.sbj string = "fsaverage" % freesurfer subject name (string), "fsaverage" for standardized cortex
    a.sbjDir string = "" % freesurfer subject dir, eg: ~/freesurferInstallDir/subjects/*
    a.surfType string  = "pial_avg" % freesurfer surface type: "inflated"|"pial"|"pial_avg"|...
    a.opacity double = 0.9 % Cortex alpha opacity 
    a.pullF double = 15 % Pull factor for obscured electrodes (more info below)
    a.flip logical = false % flip all elecs to viewed hemisphere
    a.labelVars (1,:) string = "sbjCh" % chan variables for datatips (interactive plots only) 
    a.order (1,1){mustBeMember(a.order,["ascend" "descend" ""])} = "ascend";
    a.figPos (1,:) double = [0 0 800 600] % figure positon: [top left width height]: see MATLAB figure properties
    a.insPos (1,:) double = [0 0 1 1] % axis inset: [top left width height]: see MATLAB axes properties [0 0.005 0.99 0.995] 
    a.rmHidden logical = true % don't plot electrodes hidden from view
    a.lightColor = "w"
    a.lightStyle = "infinite"
    a.align (1,1) logical = false % align vertex centers
    a.title string = "" % figure title
    a.titleSz (1,1) double = 8 % title text size
    a.visible logical = false % visible/interactive plot
    a.save logical = false % save figure
    a.saveDir string = "" % directory to save figure images 
    a.saveName string = "" % base name for image files (string)
    a.cort cell = []; % custom cortical surfaces per hemisphere (more info below)
    a.tile (1,1) double = nan % Tile number if placed within tiledchart
    a.tilespan (1,2) double = [1 1] % Tile span if placed within tiledlayout
    a.image (1,1) logical = false  % Convert graphics objects to RGB image data
end
% MORE INFO:
%  pullF = Pull factor for obscured electrodes (numeric): pullF(hems,views)
%     Separate factors per hemisphere (rows) & view (columns):
%                       [leftView1 leftView2; rightView1 rightView2;...]
%     pullF is added to coordinates for standard views (lateral/medial/ventral/dorsal)
%     pullF is a coordinate transform factor for other views (see ec_plotCortexChs)
%  cort = custom cortical surfaces per hemisphere (cell array ordered by hems)
%     Use when cortical surface files not found here 'a.sbjDir'...
%     cort = cell vector with same indexing as 'hems' input (see description above)
%     cort{i} = fullpath/struct/triangulation cortex data for hems

%% Input validation
hemN=numel(hems); viewN=numel(views); cort=a.cort;

% Check dirs
if a.save && ~a.visible
    if ~isany(a.saveDir); a.saveDir=string(uigetdir("Image save directory")); end
    if ~isany(a.saveName); a.saveName=""; end
end
if ~isany(a.sbjDir); a.sbjDir=string(uigetdir("freesurfer subjects dir: ~/freesurferInstallDir/subjects/*")); end

% Pull factor
pullF = a.pullF;
if numel(pullF) < hemN*viewN
    pullF = repmat(pullF(1),hemN,viewN);
end

% Check subject freesurfer dir
if ~endsWith(a.sbjDir,filesep); a.sbjDir = a.sbjDir+filesep; end
if endsWith(a.sbjDir,"subjects"+filesep,'IgnoreCase',true) || endsWith(a.sbjDir,"freesurfer"+filesep,'IgnoreCase',true)
    a.sbjDir = a.sbjDir+a.sbj+filesep; end
if ~endsWith(a.sbjDir,a.sbj+filesep)
    dirSplit = strsplit(a.sbjDir,filesep);
    a.sbjDir = strrep(a.sbjDir,dirSplit(end-1),a.sbj);
end

% Check electrode data
if ~isempty(d)
    dVars = string(d.Properties.VariableNames);
    if ~ismember("sbjCh",dVars); d.label=string(1:height(d))'; end
    if ~ismember("pos",dVars); error("electrode coordinates needed: d.pos(ch)=[x y z]"); end
    if ~ismember("hem",dVars); d.hem(:)="L"; end
    if ~ismember("lat",dVars); d.lat(:)="both"; end
    if ~ismember("gyrus",dVars); d.gyrus(:)=true; end
    if ~ismember("ECoG",dVars); d.ECoG(:)=true; end
    %if ~ismember("GM",dVars); d.GM(:)="GM"; end
    if ~ismember("marker",dVars); d.marker(:)="o"; end
    if ~ismember("col",dVars); d.col=zeros(height(d),3); end
    if ~ismember("bCol",dVars); d.bCol=zeros(height(d),3); end
    if ~ismember("sz",dVars); d.sz(:)=8; end
    if ~ismember("bSz",dVars); d.bSz(:)=nan; end 
    if ~ismember("order",dVars); d.order(:)=1; end 

    % Remove elecs without positions
    d(isnan(d.pos(:,1)),:) = [];

    % Remove "_" from sbjCh for datatips
    if a.visible && ismember("sbjCh",a.labelVars)
        d.sbjCh = erase(d.sbjCh,"_"); end
end


%% Initialize figure
if a.image || ~any(isgraphics(h))
    % Copy input graphics handle
    if any(isgraphics(h,"axes"))
        hin = h(isgraphics(h,"axes")); end

    % Initialize figure if no input graphics handle
    h = figure(Position=a.figPos,Visible=a.visible,WindowStyle="docked",...
            Theme="light",Color="w",AutoResizeChildren="on");
elseif any(isgraphics(h,"TiledLayout"))
    % Isolate tiledlayout handle if exist
    h = h(isgraphics(h,"TiledLayout"));
else 
    % Get current figure if input is graphics
    h = gcf;
end

% Create tiled layout if multiple hems/views
if hemN>1 || viewN>1
    ht = tiledlayout(h,hemN,viewN,TileSpacing="none",padding="tight");
    if isgraphics(h,"TiledLayout") && any(a.tile)
        ht.Layout.Tile = a.tile;
        ht.Layout.TileSpan = a.tilespan;
    end
end
p = 0; % initialize plot index

%% Plot each hemisphere & view combination

% Loop across hemispheres
for l = 1:hemN
    hem = hems(l);
    if ~isempty(cort); a.cort = cort{l}; end % Custom cortex

    %% Loop across views    
    for v = 1:viewN
        view = views(v); % current view name
        p = p+1; % plot index
        a.pullF = pullF(l,v); % load pull factor

        % Axis
        if hemN>1 || viewN>1
            ha = nexttile(ht,p);
        else
            ha = gca;
            ha.Position = a.insPos; % inset position
        end
        axis tight; axis equal; axis off;
        hold on;

        % Plot cortex
        ec_plotCortexSurf(hem,view,a,ha);

        % Electrode channels
        if ~isempty(d)
            iCh = true(height(d),1);

            % Remove chs hidden from view/hemisphere
            if a.rmHidden
                % Select hemisphere
                if ~a.flip
                    iCh = ismember(d.hem,[hem "both" ""]); end
                % Select medial/lateral
                if ismember(view,["lateral","medial"])
                    iCh(iCh) = ismember(d.lat(iCh),[view "both" ""]); end
                % Skip elec plots if no elecs left
                if ~any(iCh); warning("no electrodes for: "+hem+" "+view);
                    continue;
                end
            end

            % Plot electrode channels
            ec_plotCortexChs(hem,view,d(iCh,:),a,ha);
        end
        hold off;
    end
end

% Title
if any(a.titleSz) && isany(a.title)
    if p > 1
        title(ht,a.title,FontSize=a.titleSz);
    else
        title(ha,a.title,FontSize=a.titleSz);
    end
end


%% Convert to image
if a.image
    rgb = print(h,"-RGBImage","-r150"); % convert figure to RGB triplet
    delete(h); % delete figure objects

    if exist("hin","var") % If axes is input
        % Show image
        h = imshow(rgb,Parent=hin,Border="tight",InitialMagnification="fit");
    elseif a.visible || (nargout==0 && ~a.save)
        % Initialize image figure
        figure(Position=a.figPos,Visible=a.visible,WindowStyle="docked",...
                Theme="light",Color="w",AutoResizeChildren="on");

        % Show image
        h = imshow(rgb,Parent=gca,Border="tight",InitialMagnification="fit");
    end

    % Output RGB triplet if image not shown
    if ~exist("h","var")
        h = rgb;
    end
end


%% Save/export
if a.save && ~a.image
    figFn = a.saveDir+filesep+a.saveName+".png";
    exportgraphics(h,figFn);
    disp("SAVED: "+figFn);
    if nargout==0 && ~a.visible; delete(h); end
elseif a.save && a.image
    figFn = a.saveDir+filesep+a.saveName+".mat";
    save(figFn,"rgb");
    disp("SAVED: "+figFn);
end
        
