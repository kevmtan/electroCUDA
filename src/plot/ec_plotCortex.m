function h = ec_plotCortex(hems,views,d,a)
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
%     d.line = marker shape/line style (string) -- see LineStyle in MATLAB line properties
%     d.col = marker face color (numeric): [R G B]  -- see MarkerFaceColor in MATLAB line properties
%     d.bCol = marker border color (numeric): [R G B] -- see MarkerEdgeColor in MATLAB line properties)
%     d.sz = marker size (numeric) -- see MarkerSize in MATLAB line properties
%     d.bSz = marker border/line size (numeric) --- see plot.LineSize in MATLAB line properties
%     d.label = electrode label (string): eg. "sbj10 ch24"
%
% NAME-VALUE INPUTS: see 'arguments' section below
%
% OUPUT:
%  h = graphics handles (graphics array *or* struct of graphics arrays)
%     If 1 hemisphere & view: h = [figure;axis;cortex;light;electrodes]
%     If multiple hemispheres/views: h.hemisphere_view = [figure;axis;cortex;light;electrodes]

%% Arguments
arguments
    hems string = ["L","R"]
    views string = ["medial","lateral"]
    d table = []
    a.sbj string = "fsaverage" % freesurfer subject name (string), "fsaverage" for standardized cortex
    a.sbjDir string = "" % freesurfer subject dir, eg: ~/freesurferInstallDir/subjects/*
    a.surfType string  = "pial_avg" % freesurfer surface type: "inflated"|"pial"|"pial_avg"|...
    a.opacity double = 0.9 % Cortex alpha opacity 
    a.pullF double = 15 % Pull factor for obscured electrodes (more info below)
    a.flip logical = false % flip all elecs to viewed hemisphere
    a.align logical = true % align vertices to smooth (see plot.AlignVertexCenters; MATLAB line properties)
    a.dataTipVars string = "sbjCh" % chan variables for datatips (interactive plots only) 
    a.figPos double = [0 0 800 600] % figure positon: [top left width height] -- see MATLAB figure properties
    a.insPos double = [0 0.005 0.99 0.995] % axis inset: [top left width height] -- see MATLAB axes properties
    a.doGPU logical = false % use GPU processing (BROKEN)
    a.parallel logical = false % use parallel processing
    a.visible logical = false % visible/interactive plot
    a.save logical = false % save figure
    a.saveDir string = "" % directory to save figure images 
    a.saveName string = "" % base name for image files (string)
    a.cort = {}; % custom cortical surfaces per hemisphere (more info below)
    a.h {isgraphics,isobject,isstruct} = struct;
end
% MORE INFO:
%  pullF = Pull factor for obscured electrodes (numeric): pullF(hems(i),views(v))
%     Separate factors per hemisphere (rows) & view (columns):
%                       [leftView1 leftView2; rightView1 rightView2;...]
%     pullF is added to coordinates for standard views (lateral/medial/ventral/dorsal)
%     pullF is a coordinate transform factor for other views (see ec_plotCortexChs)
%  cort = custom cortical surfaces per hemisphere (cell array ordered by hems(i))
%     Use when cortical surface files not found here 'a.sbjDir'...
%     cort = cell vector with same indexing as 'hems' input (see description above)
%     cort{i} = fullpath/struct/triangulation cortex data for hems(i)

%% Input validation

% Check dirs
if a.save && ~a.visible
    if ~isany(a.saveDir); a.saveDir=string(uigetdir("Image save directory")); end
    if ~isany(a.saveName); a.saveName=""; end
end
if ~isany(a.sbjDir); a.sbjDir=string(uigetdir("freesurfer subjects dir: ~/freesurferInstallDir/subjects/*")); end

% Check plotting options
pullF=a.pullF; doFlip=a.flip; cort=a.cort; h=a.h;
if isempty(doFlip)
    if numel(hems)>1 || height(d)==1; doFlip=false; else; doFlip=true; end 
end
if numel(pullF) < numel(hems)*numel(views)
    pullF = repmat(pullF(1),numel(hems),numel(views));
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
    if ~ismember(dVars,"sbjCh"); d.label=string(1:height(d))'; end
    if ~ismember(dVars,"pos"); error("electrode coordinates needed: d.pos(ch)=[x y z]"); end
    if ~ismember(dVars,"hem"); d.hem(:)="L"; end
    if ~ismember(dVars,"lat"); d.lat(:)="both"; end
    if ~ismember(dVars,"gyrus"); d.gyrus(:)=true; end
    if ~ismember(dVars,"ECoG"); d.ECoG(:)=true; end
    %if ~ismember(dVars,"GM"); d.GM(:)="GM"; end
    if ~ismember(dVars,"line"); d.line(:)="o"; end
    if ~ismember(dVars,"col"); d.col=zeros(height(d),3); end
    if ~ismember(dVars,"bCol"); d.bCol=zeros(height(d),3); end
    if ~ismember(dVars,"sz"); d.sz(:)=8; end
    if ~ismember(dVars,"bSz"); d.bSz(:)=nan; end 
    %d.align(:) = a.align;

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
        a.hem = hems(i);
        a.cView = views(v);
        a.pullF = pullF(i,v);
        if ~isempty(cort)
            a.cort = cort{i};
        end

        % Initialize figure
        if isstruct(h) && isfield(h,fn)
            hi = h.(fn);
        elseif any(isgraphics(h))
            hi = h;
        elseif a.visible
            hi = figure("Position",a.figPos,"WindowStyle","docked");
        else
            hi = figure("Position",a.figPos,"Visible","off");
        end

        % Plot cortex
        hi = ec_plotCortexSurf(a,hi);

        % Electrode channels
        if ~isempty(d)
            % Get channel indices
            iCh = find(~isnan(d.pos(:,1))); % Can only plot chs with coordinates
            % Select hemisphere if multiple
            if numel(hems)>1 
                iCh = iCh(d.hem(iCh)==hems(i)); end
            % Select medial/lateral
            if ismember(a.cView,["lateral","medial"])
                iCh = iCh(ismember(d.lat(iCh),[a.cView "both" ""])); end
            if ~nnz(iCh); warning("no electrodes for "+fn); continue; end

            % Plot electrode channels
            hi = ec_plotCortexChs(d(iCh,:),a,hi);
        end

        % Save images
        if a.save
            figFn = a.saveDir+filesep+a.saveName+"_"+fn+".png";
            print(figFn,'-dpng','-image','-r300');
            %print(h.(fn)(isgraphics(h.(fn),'Figure')),figFn,'-dpng','-image','-r300');
            disp("SAVED: "+a.saveName+"_"+fn); 
        end
        

        % Collate figure handles
        if isscalar(hems) && isscalar(views) || isgraphics(h)
            h = hi;
        else
            h.(fn) = hi;
        end
    end
end
