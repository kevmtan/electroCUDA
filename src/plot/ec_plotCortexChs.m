function h = ec_plotCortexChs(h,d,o,a)
% Plots electrode channels on a freesurfer cortical surface (fsavg or custom)
% This function is meant to be called with plotCortex
% If not using plotCortex, you must call plotCortexSurf *before* this function
%
% AUTHOR: Kevin Tan, 2022 (github.com/kevmtan/electroCUDA)
% LICENSE: GNU GPL - use at your own risk!
%
% INPUTS:
%  d = table of plotting data per electrode channel (see ec_plotCortex)
%  o = plot options (see ec_plotCortex)
%  h = graphics array, output of ec_plotCortexSurf
%
% OUTPUT:
%  h = graphics array of figure/axis/cortex/lighting/marker handles

%% Check inputs
arguments
    h {isgraphics,isobject} = gca
    d {istable,isstruct} = []
    o struct = struct
    a.sbj {isstring,ischar} = []
    a.parallel logical = []
    a.doGPU logical = []
    a.figPos {isnumeric} = []
    a.insPos {isnumeric} = []
    a.hem {isstring,ischar}  = []
    a.cView {isstring,ischar} = []
    a.align logical = []
    a.visible logical = []
    a.dataTipVars {isstring,ischar}  = []
end
if nargin<1||~istable(d); error("electrode data table needed"); end

% Transfer name-value arguments to options struct
af = fieldnames(a);
for i = 1:numel(af)
    if ~isempty(a.(af{i})); o.(af{i})=a.(af{i}); end
end
clear a

% Options struct (missing fields: default vals or prompt)
if ~isfield(o,'sbj'); o.sbj="fsaverage";
elseif ~isstring(o.sbj); o.sbj=string(o.sbj); end
if ~isfield(o,'parallel'); o.parallel=false; end
if ~isfield(o,'doGPU'); o.doGPU=false; end
if ~isfield(o,'figPos'); o.figPos=[0 0 800 600]; end
if ~isfield(o,'insPos'); o.insPos=[0 0.005 0.99 0.995]; end
if ~isfield(o,'hem'); o.hem="L"; end
if ~isfield(o,'cView'); o.cView="lateral"; end
if ~isfield(o,'align'); o.align=true; end
if ~isfield(o,'visible'); o.visible=false; end
if ~isfield(o,'dataTipVars'); o.dataTipVars="label"; end
v = o.cView;
hem = o.hem;
nVars = numel(o.dataTipVars);
alignV = o.align;
dataTipVars = o.dataTipVars;

%% Electrode data table
dVars = string(d.Properties.VariableNames);
if ~ismember(dVars,"pos"); error("electrode channel coordinates needed: d.pos(ch)=[x y z]"); end
if ~ismember(dVars,"lat"); d.lat(:)="both"; end
if ~ismember(dVars,"hem"); d.hem(:)="L"; end
if ~ismember(dVars,"iEEG"); d.iEEG(:)="ECoG"; end
if ~ismember(dVars,"GM"); d.GM(:)="GM"; end
if ~ismember(dVars,"line"); d.line(:)="o"; end
if ~ismember(dVars,"col"); d.col=zeros(height(d),3); end
if ~ismember(dVars,"bCol"); d.bCol=zeros(height(d),3); end
if ~ismember(dVars,"sz"); d.sz(:)=8; end
if ~ismember(dVars,"bSz"); d.bSz(:)=nan; end
if ~ismember(dVars,"label"); d.label=string(1:height(d))'; end
% Get datatipvar sie
varSz = nan(nVars,1);
for i = 1:nVars
    varSz(i) = size(d.(o.dataTipVars(i)),2);
end
% Sort if ordered
if ismember(dVars,"order")
    d = sortrows(d,'order','ascend');
end

% % Convert to gpuArray
% if o.doGPU
%     idx = structfun(@(o) isnumeric(o)||islogical(o),o);
%     oFields = string(fieldnames(o));
%     oFields = oFields(idx);
%     for i = 1:numel(oFields)
%         o.(oFields(i)) = gpuArray(o.(oFields(i)));
%     end
%     idx = varfun(@(d) isa(d,"double"),d(1,:),"OutputFormat","uniform");
%     d = convertvars(d,idx,"single");
%     idx = varfun(@(d) isnumeric(d)||islogical(d),d(1,:),"OutputFormat","uniform");
%     d = convertvars(d,idx,"gpuArray");
%     nVars = gpuArray(nVars);
%     varSz = gpuArray(varSz);
% end

% Get datatip template
if o.visible
    row1 = repmat(matlab.graphics.datatip.DataTipTextRow,nVars,1);
else
    row1 = [];
end

% Get axis
ax = isgraphics(h,'axes');
if ~nnz(ax)
    h(end+1) = gca;
    ax = height(h);
end


%% Pull electrode coords out from the brain towards the viewer
nChs = height(d);
if nnz(o.pullF)
    if (hem=="L" && v=="lateral")||(hem=="R" && v=="medial")
        d.pos(:,1) = d.pos(:,1) - o.pullF;
    elseif (hem=="R" && v=="lateral")||(hem=="L" && v=="medial")
        d.pos(:,1) = d.pos(:,1) + o.pullF;
    elseif v=="ventral"
        d.pos(:,1) = d.pos(:,1) - o.pullF;
    else
        camPos = get(h(ax),'cameraposition');
        err = repmat(camPos,nChs,1) - d.pos;
        nrmd = err./repmat(sqrt(sum(err.^2,2)),1,3);
        d.pos = d.pos + nrmd * o.pullF;
    end
end

%% Plot electrodes
hEEG = gobjects(nChs,1);
if o.parallel && ~o.doGPU
    parfor e = 1:nChs
        hEEG(e) = plotCh_lfn(d(e,:),h(ax),row1,dataTipVars,nVars,varSz,alignV);
    end
else
    for e = 1:nChs
        hEEG(e) = plotCh_lfn(d(e,:),h(ax),row1,dataTipVars,nVars,varSz,alignV);
    end
    %d = table2struct(d);
    %hEEG = arrayfun(@(de) plotCh_lfn(de,h(ax),row1,dataTipVars,nVars,varSz,alignV),d);
end

% Return graphics array
h = [h;hEEG];
end


%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function he = plotCh_lfn(de,hAx,row1,dataTipVars,nVars,varSz,alignV)
% Plot electrode on cortex
if ~isnan(de.bSz) && de.bSz>0 && ~isnan(de.bCol(1,1)) 
    % With edge border
    he = plot3(hAx,de.pos(1),de.pos(2),de.pos(3),de.line,...
        'MarkerSize',de.sz,'MarkerFaceColor',de.col,'AlignVertexCenters',alignV,...
        'LineWidth',de.bSz,'MarkerEdgeColor',de.bCol);
else 
    % Without edge border
    he = plot3(hAx,de.pos(1),de.pos(2),de.pos(3),de.line,...
        'MarkerSize',de.sz,'MarkerFaceColor',de.col,'AlignVertexCenters',alignV);
end

% Datatips
if ~isempty(row1)
    row = row1;
    for i = 1:nVars
        varN = dataTipVars(i);
        %row(i) = dataTipTextRow(varN,[d{e,varN} d{e,varN}]); %he.UserData.(varN));
        if varSz(i)>1; row(i) = dataTipTextRow(varN,de.(varN));
        else; row(i) = dataTipTextRow(varN,[de.(varN) de.(varN)]); end   
    end
    he.DataTipTemplate.DataTipRows(end+1:end+nVars) = row;
end

% % Line parameters
% if ~isnan(de.bCol(1,1))
%     he.MarkerEdgeColor=de.bCol;
% else; he.MarkerEdgeColor="none";
% end
% if ~isnan(de.bSz) && de.bSz>0; he.LineWidth=de.bSz; end
end