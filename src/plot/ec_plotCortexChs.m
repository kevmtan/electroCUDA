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
    d table % electrode data table (see ec_plotCortex)
    a struct % plot options from ec_plotCortex
    h {isgraphics,isobject} = gca
end

% Expand align vertex argument for plot3
alignV = repmat(a.align,height(d),1);

%% Prep

% Sort if ordered
if isany(a.order)
    d = sortrows(d,'order',a.order); end

% Get axis
ax = isgraphics(h,'axes');
if ~nnz(ax)
    h(end+1) = gca;
    ax = height(h);
end

% Pull electrode coords out from the brain towards the viewer
nChs = height(d);
if nnz(a.pullF)
    if (a.hem=="L" && a.cView=="lateral")||(a.hem=="R" && a.cView=="medial")
        d.pos(:,1) = d.pos(:,1) - a.pullF;
    elseif (a.hem=="R" && a.cView=="lateral")||(a.hem=="L" && a.cView=="medial")
        d.pos(:,1) = d.pos(:,1) + a.pullF;
    elseif a.cView=="ventral"
        d.pos(:,3) = d.pos(:,3) - a.pullF;
    else
        camPos = get(h(ax),'cameraposition');
        err = repmat(camPos,nChs,1) - d.pos;
        nrmd = err./repmat(sqrt(sum(err.^2,2)),1,3);
        d.pos = d.pos + nrmd * a.pullF;
    end
end

%% Plot
markers = unique(d.marker,"stable")'; % Get marker/line styles

% Plot elecs of each marker style
for m = markers
    % Row indices of current marker style
    r = d.marker==m;

    % Plot electrodes
    he = scatter3(h(ax),d.pos(r,1),d.pos(r,2),d.pos(r,3),d.sz(r),d.col(r),"filled");

    % Marker edge color (only one color per marker style)
    if any(~isnan(d.bCol(r,1)))
        he.MarkerEdgeColor = unique(d.bCol(r,:),"first");
    end

    % Datatips
    if a.visible && isany(a.dataTipVars)
        for v = 1:numel(a.dataTipVars)
            dv = a.dataTipVars(v);
            if v==1
                he.DataTipTemplate.DataTipRows =...
                    dataTipTextRow(dv,d.(dv)(r));
            else
                he.DataTipTemplate.DataTipRows(end+1) =...
                    dataTipTextRow(dv,d.(dv)(r));
            end
        end
    end

    % Return graphics array
    h = [h;he];
end


% Plot electrodes
he = scatter3(h(ax),d.pos(:,1),d.pos(:,2),d.pos(:,3),d.sz,d.col,"filled");


he.Marker = d.marker;



if isany(d.bSz)
    % With edge border
    he = scatter3(h(ax),d.pos(:,1),d.pos(:,2),d.pos(:,3),d.marker,...
        MarkerSize=d.sz,MarkerFaceColor=d.col,AlignVertexCenters=alignV,...
        LineWidth=d.bSz,MarkerEdgeColor=d.bCol);
else
    % Without edge border
    he = scatter3(h(ax),d.pos(:,1),d.pos(:,2),d.pos(:,3),d.marker,...
        MarkerSize=d.sz,MarkerFaceColor=d.col,AlignVertexCenters=alignV,...
        MarkerEdgeColor=d.col);
end


end


% %% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function he = plotCh_lfn(de,hAx,row1,dataTipVars,nVars,varSz,a.align)
% % Plot electrode on cortex
% if ~isnan(de.bSz) && de.bSz>0 && ~isnan(de.bCol(1,1))
%     % With edge border
%     he = plot3(hAx,de.pos(1),de.pos(2),de.pos(3),de.marker,...
%         MarkerSize=de.sz,MarkerFaceColor=de.col,AlignVertexCenters=a.align,...
%         LineWidth=de.bSz,MarkerEdgeColor=de.bCol);
% else
%     % Without edge border
%     he = plot3(hAx,de.pos(1),de.pos(2),de.pos(3),de.marker,...
%         MarkerSize=de.sz,MarkerFaceColor=de.col,AlignVertexCenters=a.align,...
%         MarkerEdgeColor=de.col);
% end
% 
% % Datatips
% if ~isempty(row1)
%     row = row1;
%     for a.cView = 1:nVars
%         varN = dataTipVars(a.cView);
%         %row(i) = dataTipTextRow(varN,[d{e,varN} d{e,varN}]); %he.UserData.(varN));
%         if varSz(a.cView)>1; row(a.cView) = dataTipTextRow(varN,de.(varN));
%         else; row(a.cView) = dataTipTextRow(varN,[de.(varN) de.(varN)]); end
%     end
%     he.DataTipTemplate.DataTipRows(end+1:end+nVars) = row;
% end
% 
% % Line parameters
% if ~isnan(de.bCol(1,1))
%     he.MarkerEdgeColor=de.bCol;
% else; he.MarkerEdgeColor="none";
% end
% if ~isnan(de.bSz) && de.bSz>0; he.LineWidth=de.bSz; end
% end