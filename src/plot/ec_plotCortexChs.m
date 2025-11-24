function hCh = ec_plotCortexChs(hem,view,d,a,ha)
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
    hem % hemisphere
    view % cortical view
    d table % electrode data table (see ec_plotCortex)
    a struct % plot options from ec_plotCortex
    ha = gca % axis handle
end

%% Prep

% Sort if ordered
if isany(a.order)
    d = sortrows(d,order=a.order); end

% Flip all chs to single hemisphere
if a.flip
    if hem=="L"
        d.pos(:,1) = -abs(d.pos(:,1));
    elseif hem=="R"
        d.pos(:,1) = abs(d.pos(:,1));
    end
end

% Pull electrode coords out from the brain towards the viewer
if a.pullF
    if (hem=="L" && view=="lateral")||(hem=="R" && view=="medial")
        d.pos(:,1) = d.pos(:,1) - a.pullF;
    elseif (hem=="R" && view=="lateral")||(hem=="L" && view=="medial")
        d.pos(:,1) = d.pos(:,1) + a.pullF;
    elseif view=="ventral"
        d.pos(:,3) = d.pos(:,3) - a.pullF;
    else
        camPos = get(ha,"cameraposition");
        err = repmat(camPos,height(d),1) - d.pos;
        nrmd = err./repmat(sqrt(sum(err.^2,2)),1,3);
        d.pos = d.pos + nrmd * a.pullF;
    end
end

%% Plot electrodes
markers = unique(d.marker,"stable")'; % Get marker/line styles
markN = numel(markers);
hCh = gobjects(markN,1);

% Plot each marker style separately (Matlab limitation for vectorized 'scatter3')
for m = 1:markN
    % Row indices of current marker style
    r = d.marker==markers(m);

    % 3D scatterplot of electrodes (vectorized)
    hCh(m) = scatter3(ha,d.pos(r,1),d.pos(r,2),d.pos(r,3),d.sz(r),d.col(r,:),...
        markers(m),"filled");

    % Marker edge properties (same per marker style - Matlab limitation)
    if any(d.bSz(r))
        hCh(m).LineWidth = unique(d.bSz(r),"last");
        hCh(m).MarkerEdgeColor = unique(d.bCol(r,:),"last");
    end

    % Datatips
    if a.visible && isany(a.labelVars)
        for v = 1:numel(a.labelVars)
            dv = a.labelVars(v);
            if v==1
                hCh(m).DataTipTemplate.DataTipRows =...
                    dataTipTextRow(dv,d.(dv)(r));
            else
                hCh(m).DataTipTemplate.DataTipRows(end+1) =...
                    dataTipTextRow(dv,d.(dv)(r));
            end
        end
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
%     for view = 1:nVars
%         varN = dataTipVars(view);
%         %row(i) = dataTipTextRow(varN,[d{e,varN} d{e,varN}]); %he.UserData.(varN));
%         if varSz(view)>1; row(view) = dataTipTextRow(varN,de.(varN));
%         else; row(view) = dataTipTextRow(varN,[de.(varN) de.(varN)]); end
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