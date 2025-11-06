function h = ec_plotCortexChs(d,a,h)
% Plots electrode channels on a freesurfer cortical surface (fsavg or custom)
% This function is meant to be called with plotCortex
% If not using plotCortex, you must call plotCortexSurf *before* this function
%
% AUTHOR: Kevin Tan, 2025 (github.com/kevmtan/electroCUDA)
% LICENSE: GNU GPL - use at your own risk!
%
% INPUTS:
%  d = table of plotting data per electrode channel (see ec_plotCortex)
%  a = plot options (see ec_plotCortex)
%  h = graphics array, output of ec_plotCortexSurf
%
% OUTPUT:
%  h = graphics array of figure/axis/cortex/lighting/marker handles

%% Check inputs
arguments
    d table
    a struct
    h {isgraphics,isobject} = gca
end
if nargin<1||~istable(d); error("electrode data table needed"); end

v = a.cView;
hem = a.hem;
nVars = numel(a.dataTipVars);
alignV = a.align;
dataTipVars = a.dataTipVars;
dVars = string(d.Properties.VariableNames);

%% Electrode data table

% Get datatip var size
varSz = nan(nVars,1);
for i = 1:nVars
    varSz(i) = size(d.(a.dataTipVars(i)),2);
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
if a.visible
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
if nnz(a.pullF)
    if (hem=="L" && v=="lateral")||(hem=="R" && v=="medial")
        d.pos(:,1) = d.pos(:,1) - a.pullF;
    elseif (hem=="R" && v=="lateral")||(hem=="L" && v=="medial")
        d.pos(:,1) = d.pos(:,1) + a.pullF;
    elseif v=="ventral"
        d.pos(:,3) = d.pos(:,3) - a.pullF;
    else
        camPos = get(h(ax),'cameraposition');
        err = repmat(camPos,nChs,1) - d.pos;
        nrmd = err./repmat(sqrt(sum(err.^2,2)),1,3);
        d.pos = d.pos + nrmd * a.pullF;
    end
end

%% Plot electrodes
hEEG = gobjects(nChs,1);
if a.parallel && ~a.doGPU
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
    for v = 1:nVars
        varN = dataTipVars(v);
        %row(i) = dataTipTextRow(varN,[d{e,varN} d{e,varN}]); %he.UserData.(varN));
        if varSz(v)>1; row(v) = dataTipTextRow(varN,de.(varN));
        else; row(v) = dataTipTextRow(varN,[de.(varN) de.(varN)]); end   
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