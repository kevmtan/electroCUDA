function h = ec_plotCortexSurf(h,o,a)
% Plots a freesurfer cortical surface (fsAvg or custom surface)
% See plotCortex.m for full description of input options
% Call this function using plotCortex for single or multiple views (separate figs per view)
% Call this function directly to use with subplots or tiledlayouts
%
% INPUTS:
%   o = Plotting options (see ec_plotCortex)
%   hAx = axis handle, automatic in plotCortexSurf_wrapper, manual: hAx = gca
%
% OUPUT:
%   hAx = graphics array of axis/cortex/lighting handles
%
% TO DO: gpuArray support?
%
% AUTHOR: Kevin Tan, 2022 (github.com/kevmtan/electroCUDA)
% LICENSE: GNU GPL - use at your own risk!

%% Check inputs
arguments
    h {isgraphics,isobject} = [gcf;gca]
    o struct = struct
    a.sbj {isstring,ischar} = []
    a.sbjDir {isstring,ischar} = []
    a.doGPU logical = []
    a.hem {isstring,ischar} = []
    a.cView {isstring,ischar} = []
    a.surfType {isstring,ischar}  = []
    a.opacity {isnumeric} = []
    a.insPos {isnumeric} = []
    a.cort = []
end

% Transfer name-value arguments to options struct
af = fieldnames(a);
for i = 1:numel(af)
    if ~isempty(a.(af{i})); o.(af{i})=a.(af{i}); end
end
clear a
% if ~isempty(a,'sbj'); o.sbj=string(a.sbj); end
% if ~isempty(a,'sbjDir'); o.sbjDir=string(a.sbjDir); end
% if ~isempty(a,'gpu'); o.doGPU=a.gpu; end
% if ~isempty(a,'hem'); o.hem=string(a.hem); end
% if ~isempty(a,'cView'); o.cView=a.cView; end
% if ~isempty(a,'surfType'); o.surfType=string(a.surfType); end
% if ~isempty(a,'opacity'); o.opacity=a.opacity; end
% if ~isempty(a,'insPos'); o.insPos=string(a.insPos); end
% if ~isempty(a,'cort'); o.cort=a.cort; end

% Check options struct
if ~isfield(o,'sbj'); sbj="fsaverage"; else; sbj=string(o.sbj); end
if ~isfield(o,'sbjDir'); sbjDir=string(uigetfile("freesurfer subject dir, eg: ~/freesurferInstallDir/subjects/*"));
else; sbjDir=string(o.sbjDir); end
if ~isfield(o,'doGPU'); o.doGPU=false; end
if ~isfield(o,'hem'); hem="L"; else; hem=o.hem; end
if ~isfield(o,'cView'); o.cView='lateral'; end
if ~isfield(o,'surfType'); surfType="pial_avg"; else; surfType=o.surfType; end % inflated or pial_avg
if ~isfield(o,'opacity'); o.opacity=0.9; end
if ~isfield(o,'insPos'); o.insPos=[0 0.005 0.99 0.995]; end
if ~isfield(o,'cort'); cort=[]; else; cort=o.cort; end
% if nargin<2 || ~any(isgraphics(h)); h=[gcf;gca]; end

% Check subject freesurfer dir
if ~endsWith(sbjDir,filesep); sbjDir = sbjDir+filesep; end
if endsWith(sbjDir,"subjects"+filesep,'IgnoreCase',true) || endsWith(sbjDir,"freesurfer"+filesep,'IgnoreCase',true)
    sbjDir = sbjDir+sbj+filesep; end
if ~endsWith(sbjDir,sbj+filesep)
    dirSplit = strsplit(sbjDir,filesep);
    sbjDir = strrep(sbjDir,dirSplit(end-1),sbj);
end

% View angle
if o.hem=="L"
    switch o.cView
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
elseif o.hem=="R"
    switch o.cView
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
end

% Get axis
ax = isgraphics(h,'axes');
if ~nnz(ax); h(end+1,1)=gca; ax=height(h); end


%% Get cortical surface

% Get filename
if isempty(cort)
    if hem=="R"; cort=fullfile(sbjDir,"surf","rh."+surfType);
    else; cort=fullfile(sbjDir,"surf","lh."+surfType); end
end

% Convert to triangulation object
if ~isa(cort,'triangulation'); cort = readSurfTri(cort); end

% Cortical curvature shading (distinguish sulci/gyri for inflated)
if contains(surfType,"inflated")
    if sbj=="fsaverage"
        if hem=="R"; curvFn = fullfile(sbjDir,"surf","rh.avg_curv");
        else; curvFn = fullfile(sbjDir,"surf","lh.avg_curv"); end
    else
        if hem=="R"; curvFn = fullfile(sbjDir,"surf","rh.curv");
        else; curvFn = fullfile(sbjDir,"surf","lh.curv"); end
    end
    curv = read_curv(curvFn);
    curvCol = ones(height(curv),3);
    idx = curv>=0; % Sulci
    curvCol(idx,:) = curvCol(idx,:)*0.8;
    idx = curv<0; % Gyri
    curvCol(idx,:) = curvCol(idx,:)*0.9;
else
    curvCol = ones(height(cort.Points),3)*0.9;
end
%if doGPU; curvCol = gpuArray(curvCol); end

%% Plot cortical surface
hCort = trisurf(cort,'FaceVertexCData',curvCol,'Parent',h(ax));
alpha(o.opacity); % set cortex opacity

% Axis properties
set(h(ax),'Position',o.insPos); axis tight; axis equal; axis off; 
hold on; rotate3d on;

% Optimize lighting
material dull; shading interp; lighting gouraud; 
hLight = ec_locView(theta,phi,h(ax),o);

% Return graphics array
h = [h;hCort;hLight];
