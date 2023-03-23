function h = ec_plotCortex(hems,views,d,o,a)
% Wrapper for ec_plotCortexSurf & ec_plotCortexChs (use this to call those functions)
% Missing inputs are filled with default values
%
% AUTHOR: Kevin Tan, 2022 (github.com/kevmtan/electroCUDA)
% LICENSE: GNU GPL - use at your own risk!
%
% MAIN INPUTS:
%  hems = Hemispheres to plot (strings): "L"|"R"|["L" "R"]
%  views = Plotting views (strings): see 'view angles' in ec_plotCortexSurf
%  o = Struct of plotting options & graphics properties
%     o.sbj = freesurfer subject name (string), "fsaverage" for standardized cortex
%     o.sbjDir = freesurfer subject dir, eg: ~/freesurferInstallDir/subjects/*
%     o.saveDir = directory to save figure images (string)
%     o.saveName = base name for image files (string)
%     o.parallel = use parallel processing (logical) -- see MATLAB parallel toolbox
%     o.doGPU = run with CUDA (logical) -- see Matlab GPU requirements
%     o.figPos = figure positon (array): [top left width height] -- see MATLAB figure properties
%     o.insPos = axis inset (array): [top left width height] -- see MATLAB axes properties
%     o.surfType = freesurfer surface type (string): "inflated"|"pial"|"pial_avg"|...
%     o.opacity = opacity of cortical surface (double) -- see FaceAlpha in MATLAB patch properties
%     o.lightStyle = lighting style (see light.Style; MATLAB lighting properties)
%     o.align = align vertices to smooth (see plot.AlignVertexCenters; MATLAB line properties)
%     o.dataTipVars = electrode variables (from 'd') to show in figure datatips (string vector of variable names in 'd')
%
% OPTIONAL INPUTS:                     eg. plotCortex(...,visible=0,save=1)
%  save = save figure to disk (logical)
%  visible = figure visibility (logical), figure saved to disk if FALSE
%  sbj = sets 'o.sbj', see above
%  sbjDir = sets 'o.sbjDir', see above
%  parallel = sets 'o.parallel', see above
%  gpu = sets 'o.doGPU', see above
%  surf = sets 'o.surfType', see above
%  pullF = Pull factor for obscured electrodes (numeric): pullF(hems(i),views(v))
%     Separate factors per hemisphere (rows) & view (columns):
%                       [leftView1 leftView2; rightView1 rightView2;...]
%     pullF is added to coordinates for standard views (lateral/medial/ventral/dorsal)
%     pullF is a coordinate transform factor for other views (see ec_plotCortexChs)
%  cort = custom cortical surfaces per hemisphere (cell array ordered by hems(i))
%     Use when cortical surface files not found here 'o.sbjDir'...
%     cort = cell vector with same indexing as 'hems' input (see description above)
%     cort{i} = fullpath/struct/triangulation cortex data for hems(i)
%  d = table of electrode plotting data (omit to plot cortex only)
%     NOTE: required if plotting electrodes on cortex, rows correspond to electrode channels
%     d.pos = position in o.surfType coordinates (numeric): [x y z] -- see FreeSurfer coordinate systems
%     d.lat = hemisphere side (string): "medial"|"lateral"|"both"
%     d.hem = brain hemisphere (string): "L"|"R"
%     d.ECoG = electrode type (logical): TRUE for subdural, FALSE for depth
%     d.GM = grey or white matter (string): "GM"|"WM"
%     d.line = marker shape/line style (string) -- see LineStyle in MATLAB line properties
%     d.col = marker face color (numeric): [R G B]  -- see MarkerFaceColor in MATLAB line properties
%     d.bCol = marker edge color (numeric): [R G B] -- see MarkerEdgeColor in MATLAB line properties)
%     d.sz = marker size (numeric) -- see MarkerSize in MATLAB line properties
%     d.bSz = marker border/line size (numeric) --- see plot.LineSize in MATLAB line properties
%     d.label = electrode label (string): eg. "sbj10 ch24"
%  h = graphics handles (only if using preexisting figure/axis, eg. subplots)
%
% OUPUT:
%  h = graphics handles (graphics array *or* struct of graphics arrays)
%     If 1 hemisphere & view: h = [figure;axis;cortex;light;electrodes]
%     If multiple hemispheres/views: h.hemisphere_view = [figure;axis;cortex;light;electrodes]

%% Input validation
arguments
    hems string = ["L","R"]
    views string = ["medial","lateral"]
    d table = []
    o struct = struct
    a.sbj string = []
    a.sbjDir string = []
    a.doGPU logical = []
    a.hem string = []
    a.cView string = []
    a.surfType string  = []
    a.opacity {isnumeric} = []
    a.figPos {isnumeric} = []
    a.insPos {isnumeric} = []
    a.align logical = []
    a.parallel logical = []
    a.visible logical = []
    a.save logical = false
    a.pullF {isnumeric} = 15
    a.flip logical = false
    a.cort = {};
    a.h {isgraphics,isobject,isstruct} = struct;
end

% Transfer name-value arguments to options struct
af = fieldnames(a);
for i = 1:numel(af)-4
    if ~isempty(a.(af{i})); o.(af{i})=a.(af{i}); end
end
pullF=a.pullF; doFlip=a.flip; cort=a.cort; h=a.h;
clear a

% Check plotting options
if isempty(doFlip)
    if numel(hems)>1 || height(d)==1; doFlip=false; else; doFlip=true; end 
end
if numel(pullF) < numel(hems)*numel(views)
    pullF = repmat(pullF(1),numel(hems),numel(views));
end

% Check options struct
if o.save && ~o.visible
    if ~isfield(o,'saveDir'); o.saveDir=string(uigetdir("Image save directory")); end
    if ~isfield(o,'saveName'); o.saveName=""; end
    if ~isstring(o.saveDir); o.saveDir = string(o.saveDir); end
    if ~isstring(o.saveName); o.saveName = string(o.saveDir); end
end
if ~isfield(o,'sbj'); o.sbj="fsaverage"; elseif ~isstring(o.sbj); o.sbj=string(o.sbj); end
if ~isfield(o,'sbjDir'); o.sbjDir=string(uigetdir("freesurfer subjects dir: ~/freesurferInstallDir/subjects/*"));
elseif ~isstring(o.sbjDir); o.fnSbj=string(o.sbjDir); end
if ~isfield(o,'doGPU'); o.doGPU=false; end
if ~isfield(o,'parallel')
   if isempty(d)||height(d)<2||o.doGPU; o.parallel=false; else; o.parallel=true; end
end
if ~isfield(o,'figPos'); o.figPos=[0 0 800 600]; end
if ~isfield(o,'insPos'); o.insPos=[0 0.005 0.99 0.995]; end
if ~isfield(o,'hem'); o.hem="L"; end
if ~isfield(o,'cView'); o.cView="lateral"; end
if ~isfield(o,'surfType'); o.surfType="pial_avg"; end
if ~isfield(o,'opacity'); o.opacity=0.9; end
if ~isfield(o,'align'); o.align=true; end
if ~isfield(o,'dataTipVars'); o.dataTipVars="label"; end

% Check subject freesurfer dir
if ~endsWith(o.sbjDir,filesep); o.sbjDir = o.sbjDir+filesep; end
if endsWith(o.sbjDir,"subjects"+filesep,'IgnoreCase',true) || endsWith(o.sbjDir,"freesurfer"+filesep,'IgnoreCase',true)
    o.sbjDir = o.sbjDir+o.sbj+filesep; end
if ~endsWith(o.sbjDir,o.sbj+filesep)
    dirSplit = strsplit(o.sbjDir,filesep);
    o.sbjDir = strrep(o.sbjDir,dirSplit(end-1),o.sbj);
end

% Check electrode data
if ~isempty(d)
    dVars = string(d.Properties.VariableNames);
    if ~ismember(dVars,"pos"); error("electrode coordinates needed: d.pos(ch)=[x y z]"); end
    if ~ismember(dVars,"hem"); d.hem(:)="L"; end
    if ~ismember(dVars,"lat"); d.lat(:)="both"; end
    if ~ismember(dVars,"ECoG"); d.ECoG(:)=true; end
    if ~ismember(dVars,"GM"); d.GM(:)="GM"; end
    if ~ismember(dVars,"line"); d.line(:)="o"; end
    if ~ismember(dVars,"col"); d.col=zeros(height(d),3); end
    if ~ismember(dVars,"bCol"); d.bCol=zeros(height(d),3); end
    if ~ismember(dVars,"sz"); d.sz(:)=8; end
    if ~ismember(dVars,"bSz"); d.bSz(:)=nan; end
    if ~ismember(dVars,"label"); d.label=string(1:height(d))'; end
    d.align(:) = o.align;

    % Flip all chs to single hemisphere 
    if doFlip
        if hems=="L"
            d.pos(d.hem=="R",1) = -d.pos(d.hem=="R",1);
        elseif hems=="R"
            d.pos(d.hem=="L",1) = -d.pos(d.hem=="L",1);
        end
    end
end

%% Plot each hemisphere & view combination
for i = 1:numel(hems)
    for v = 1:numel(views)
        tic;
        fn = hems(i)+"_"+views(v);

        % Load varying options
        o.hem = hems(i);
        o.cView = views(v);
        o.pullF = pullF(i,v);
        if ~isempty(cort)
            o.cort = cort{i};
        end

        % Initialize figure
        if isstruct(h) && isfield(h,fn)
            hi = h.(fn);
        elseif any(isgraphics(h))
            hi = h;
        elseif o.visible
            hi = figure("Position",o.figPos,"Renderer","opengl","WindowStyle","docked"); %#ok<*FGREN> 
        else
            hi = figure("Position",o.figPos,"Renderer","opengl","Visible","off");
        end

        % Plot cortex
        hi = ec_plotCortexSurf(hi,o);

        % Electrode channels
        if ~isempty(d)
            % Get channel indices
            iCh = find(~isnan(d.pos(:,1))); % Can only plot chs with coordinates
            if numel(hems)>1; iCh=iCh(d.hem(iCh)==hems(i)); end
            if ismember(o.cView,["lateral","medial"])
                iCh = iCh(ismember(d.lat(iCh),[o.cView "both" ""])); end
            if ~nnz(iCh); warning("no electrodes for "+fn); continue; end

            % Plot electrode channels
            hi = ec_plotCortexChs(hi,d(iCh,:),o);
        end

        % Save images
        if o.save
            figFn = o.saveDir+filesep+o.saveName+"_"+fn+".png";
            print(figFn,'-dpng','-image','-r300');
            %print(h.(fn)(isgraphics(h.(fn),'Figure')),figFn,'-dpng','-image','-r300');
            disp("SAVED: "+o.saveName+"_"+fn); 
        end
        

        % Collate figure handles
        if numel(hems)==1 && numel(views)==1 || isgraphics(h)
            h = hi;
        else
            h.(fn) = hi;
        end
    end
end
