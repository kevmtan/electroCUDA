function hCh = ec_plotCortexChs(hem,view,d,a,ha)
% Plots electrode channels on a freesurfer cortical surface (fsavg or custom)
% Meant to be called from ec_plotCortex (or after ec_plotCortexSurf).
%
% RENDERING STRATEGY
%   1. Sort d by |actVar| ascending → largest magnitudes are last in array,
%      so they render ON TOP of overlapping smaller-magnitude markers
%      (scatter3 draws in array order; sortMethod="childorder" on the axes
%      forces this ordering even when camera-depth would say otherwise).
%   2. Mirror chs to viewed hemisphere if a.flip, then pull them outward
%      from the cortex via a.pullF so they sit above the surface.
%   3. scatter3 in one call per (marker, bSz, bCol) group. In the common
%      case where all sig chans share the same marker style and edge
%      attrs, that's ONE scatter3 with N points instead of N plot3 calls.
%      Vectorizes face color (n×3) and size (n×1); marker shape + edge
%      width + edge color must be uniform per scatter3 call so we group.
%
% INPUTS
%   hem, view : hemisphere ("L"|"R") and view ("lateral"|"medial"|...)
%   d         : per-channel plot table (pos, marker, col, bCol, sz, bSz,
%               order, absVal, ...) — built by ec_plotTimesCortex.makePlotData_lfn
%   a         : plot options struct from ec_plotCortex (order, flip, pullF,
%               align, visible, labelVars, ...)
%   ha        : target axes handle (defaults to gca)
%
% OUTPUT
%   hCh : gobjects array of scatter handles (one per group)
%
% AUTHOR: Kevin Tan, 2025 (github.com/kevmtan/electroCUDA)
% LICENSE: GNU GPL - use at your own risk!

%% Check inputs
arguments
    hem % hemisphere
    view % cortical view
    d table % electrode data table (see ec_plotCortex)
    a struct % plot options from ec_plotCortex
    ha = gca % axis handle
end

%% Prep
% Sort so that channels with the largest |actVar| are drawn LAST (rendered on top).
% Prefer d.absVal (true magnitude); fall back to d.order (colormap index) for legacy.
if isany(a.order)
    sortVar = "order"; % legacy: colormap index (not magnitude with diverging maps)
    if ismember("absVal",string(d.Properties.VariableNames))
        sortVar = "absVal";
    end
    d = sortrows(d,sortVar,a.order);
end

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

%% Plot electrodes — vectorize via scatter3, group by (marker, bSz, bCol)
% scatter3 lets us pass per-point face color (n×3) and size (n×1) but Marker,
% LineWidth, and MarkerEdgeColor are scalar-per-call. So we group rows sharing
% those three attributes and emit one scatter3 per group (typically 1 in practice).

% Treat "no edge" rows (NaN/zero bSz) as a single bucket regardless of bCol
hasEdge = ~isnan(d.bSz) & d.bSz>0 & ~isnan(d.bCol(:,1));
bSzKey  = d.bSz;       bSzKey(~hasEdge)    = NaN;
bColKey = d.bCol;      bColKey(~hasEdge,:) = NaN;

% Group key per row
keys = string(d.marker) + "|" + string(bSzKey) + "|" + ...
    string(bColKey(:,1)) + "|" + string(bColKey(:,2)) + "|" + string(bColKey(:,3));
[uKeys,~,grp] = unique(keys,"stable");

hCh = gobjects(numel(uKeys),1);
for m = 1:numel(uKeys)
    r = grp==m;
    rep = find(r,1); % representative row for scalar attrs

    % scatter3 size is in points² (area), plot3 was in points (diameter).
    % d.sz was authored in plot3 units — square it to preserve visual size.
    szArea = d.sz(r).^2;

    if hasEdge(rep)
        hCh(m) = scatter3(ha,d.pos(r,1),d.pos(r,2),d.pos(r,3),...
            szArea,d.col(r,:),d.marker(rep),"filled",...
            LineWidth=d.bSz(rep),MarkerEdgeColor=d.bCol(rep,:),...
            AlignVertexCenters=a.align);
    else
        % edge color = face color (per point) — equivalent to old MarkerEdgeColor=de.col
        hCh(m) = scatter3(ha,d.pos(r,1),d.pos(r,2),d.pos(r,3),...
            szArea,d.col(r,:),d.marker(rep),"filled",...
            MarkerEdgeColor="flat",AlignVertexCenters=a.align);
    end

    % Datatips
    if a.visible && isany(a.labelVars)
        for v = 1:numel(a.labelVars)
            dv = a.labelVars(v);
            if v==1
                hCh(m).DataTipTemplate.DataTipRows = dataTipTextRow(dv,d.(dv)(r,:));
            else
                hCh(m).DataTipTemplate.DataTipRows(end+1) = dataTipTextRow(dv,d.(dv)(r,:));
            end
        end
    end
end


% %% Plot electrodes
% markers = unique(d.marker,"stable")'; % Get marker/line styles
% markN = numel(markers);
% hCh = gobjects(markN,1);
% % Plot each marker style separately (Matlab limitation for vectorized 'scatter3')
% for m = 1:markN
%     % Row indices of current marker style
%     r = d.marker==markers(m);
% 
%     % 3D scatterplot of electrodes (vectorized)
%     hCh(m) = scatter3(ha,d.pos(r,1),d.pos(r,2),d.pos(r,3),d.sz(r),d.col(r,:),...
%         markers(m),"filled");
% 
%     % Marker edge properties (same per marker style - Matlab limitation)
%     if any(d.bSz(r))
%         hCh(m).LineWidth = unique(d.bSz(r),"last");
%         hCh(m).MarkerEdgeColor = unique(d.bCol(r,:),"last");
%     end
% 
%     % Datatips
%     if a.visible && isany(a.labelVars)
%         for v = 1:numel(a.labelVars)
%             dv = a.labelVars(v);
%             if v==1
%                 hCh(m).DataTipTemplate.DataTipRows =...
%                     dataTipTextRow(dv,d.(dv)(r));
%             else
%                 hCh(m).DataTipTemplate.DataTipRows(end+1) =...
%                     dataTipTextRow(dv,d.(dv)(r));
%             end
%         end
%     end
% end