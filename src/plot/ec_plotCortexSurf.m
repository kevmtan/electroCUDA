function [hCort,hLight] = ec_plotCortexSurf(hem,view,a,ha)
% Plots a freesurfer cortical surface (fsAvg or custom surface)
% See plotCortex.m for full description of input options
% Call this function using plotCortex for single or multiple views (separate figs per view)
% Call this function directly to use with subplots or tiledlayouts
%
% INPUTS:
%   a = Plotting options (see ec_plotCortex)
%   hAx = axis handle, automatic in plotCortexSurf_wrapper, manual: hAx = gca
%
% OUPUT:
%   hAx = graphics array of axis/cortex/lighting handles
%
% TO DO: gpuArray support?
%
% AUTHOR: Kevin Tan, 2025 (github.com/kevmtan/electroCUDA)
% LICENSE: GNU GPL - use at your own risk!

%% Check inputs
arguments
    hem % hemisphere
    view % cortical view
    a struct % options struct from plotCortex
    ha {isgraphics(ha,"axes")} = gca % axis handle
end

%% Prep

% View angle
if hem=="L"
    switch view
        case 'medial'; theta=90; phi=0;
        case 'lateral'; theta=270; phi=0;
        case 'anterior'; theta=180; phi=0;
        case 'posterior'; theta=0; phi=0;
        case 'ventral'; theta=180; phi=270;
        case 'temporal'; theta=270; phi=-80;
        case 'dorsal'; theta=0; phi=90;
        case 'latero-dorsal'; theta=270; phi=45;
        case 'latero-ventral'; theta=270; phi=-45;
        case 'latero-posterior'; theta=270+45; phi=0;
        case 'latero-anterior'; theta=270-45; phi=0;
        case 'medio-dorsal'; theta=90; phi=45;
        case 'medio-ventral'; theta=90; phi=-45;
        case 'medio-posterior'; theta=90-45; phi=0;
        case 'medio-anterior'; theta=90+45; phi=0;
        case 'frontal'; theta=-120; phi=10;
        case 'parietal'; theta=-70; phi=10;
    end
elseif hem=="R"
    switch view
        case 'medial'; theta=270; phi=0;
        case 'lateral'; theta=90; phi=0;
        case 'anterior'; theta=180; phi=0;
        case 'posterior'; theta=0; phi=0;
        case 'dorsal'; theta=0; phi=90;
        case 'ventral'; theta=180; phi=270;
        case 'temporal'; theta=90; phi=-80;
        case 'latero-dorsal'; theta=90; phi=45;
        case 'latero-ventral'; theta=90; phi=-45;
        case 'latero-posterior'; theta=90-45; phi=0;
        case 'latero-anterior'; theta=90+45; phi=0;
        case 'medio-dorsal'; theta=270; phi=45;
        case 'medio-ventral'; theta=270; phi=-45;
        case 'medio-posterior'; theta=270+45; phi=0;
        case 'medio-anterior'; theta=270-45; phi=0;
        case 'frontal'; theta=120; phi=10;
        case 'parietal'; theta=70; phi=10;
    end
else
    error("[ec_plotCortexSurf] hemisphere must be 'L' or 'R' (hem)");
end


%% Get cortical surface

% Get filename
if isempty(a.cort)
    if hem=="R"; a.cort=fullfile(a.sbjDir,"surf","rh."+a.surfType);
    else; a.cort=fullfile(a.sbjDir,"surf","lh."+a.surfType); end
end

% Convert to triangulation object
if ~isa(a.cort,'triangulation'); a.cort = ec_readSurfTri(a.cort); end

% Cortical curvature shading (distinguish sulci/gyri for inflated)
if contains(a.surfType,"inflated")
    if contains(a.surfType,"avg")
        if hem=="R"; curvFn = fullfile(a.sbjDir,"surf","rh.avg_curv");
        else; curvFn = fullfile(a.sbjDir,"surf","lh.avg_curv"); end
    else
        if hem=="R"; curvFn = fullfile(a.sbjDir,"surf","rh.curv");
        else; curvFn = fullfile(a.sbjDir,"surf","lh.curv"); end
    end
    curv = read_curv(curvFn);
    curvCol = ones(height(curv),3);
    idx = curv>=0; % Sulci
    curvCol(idx,:) = curvCol(idx,:)*0.8;
    idx = curv<0; % Gyri
    curvCol(idx,:) = curvCol(idx,:)*0.9;
else
    curvCol = ones(height(a.cort.Points),3)*0.9;
end

%% Plot cortical surface
hCort = trisurf(a.cort,'FaceVertexCData',curvCol,'Parent',ha);
hCort.FaceAlpha = a.opacity; % cortex opacity
shading(ha,"interp"); % cortex shading

% Optimize lighting
hLight = ec_locView(theta,phi,ha,color=a.lightColor,style=a.lightStyle);
lighting(ha,"gouraud"); % axis lighting
material(hCort,"dull"); % cortex material




%% Deprec
% arguments
%     h {isgraphics,isobject} = [gcf;gca]
%     o struct = struct
%     a.sbj {isstring,ischar} = []
%     a.sbjDir {isstring,ischar} = []
%     a.doGPU logical = []
%     hem {isstring,ischar} = []
%     view {isstring,ischar} = []
%     a.surfType {isstring,ischar}  = []
%     a.opacity {isnumeric} = []
%     a.insPos {isnumeric} = []
%     a.cort = []
% end
% 
% % Transfer name-value arguments to options struct
% af = fieldnames(a);
% for i = 1:numel(af)
%     if ~isempty(a.(af{i})); o.(af{i})=a.(af{i}); end
% end
% clear a
% 
% % Check options struct
% if ~isfield(o,'sbj'); sbj="fsaverage"; else; sbj=string(o.sbj); end
% if ~isfield(o,'sbjDir'); sbjDir=string(uigetfile("freesurfer subject dir, eg: ~/freesurferInstallDir/subjects/*"));
% else; sbjDir=string(o.sbjDir); end
% if ~isfield(o,'doGPU'); o.doGPU=false; end
% if ~isfield(o,'hem'); hem="L"; else; hem=o.hem; end
% if ~isfield(o,'cView'); o.cView='lateral'; end
% if ~isfield(o,'surfType'); surfType="pial_avg"; else; surfType=o.surfType; end % inflated or pial_avg
% if ~isfield(o,'opacity'); o.opacity=0.9; end
% if ~isfield(o,'insPos'); o.insPos=[0 0.005 0.99 0.995]; end
% if ~isfield(o,'cort'); cort=[]; else; cort=o.cort; end
% % if nargin<2 || ~any(isgraphics(h)); h=[gcf;gca]; end
% 
% % Check subject freesurfer dir
% if ~endsWith(sbjDir,filesep); sbjDir = sbjDir+filesep; end
% if endsWith(sbjDir,"subjects"+filesep,'IgnoreCase',true) || endsWith(sbjDir,"freesurfer"+filesep,'IgnoreCase',true)
%     sbjDir = sbjDir+sbj+filesep; end
% if ~endsWith(sbjDir,sbj+filesep)
%     dirSplit = strsplit(sbjDir,filesep);
%     sbjDir = strrep(sbjDir,dirSplit(end-1),sbj);
% end