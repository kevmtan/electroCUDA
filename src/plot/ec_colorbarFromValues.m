function [cols,cIdx,cMap,vals] = ec_colorbarFromValues(vals,cMapName,cLim,a)
% Get a colormap from a set of values. Enter range for z-score to distinguish
% raw value & z-score operations
%
% OUTPUTS: [RGB color triplets, colormap index, full colormap, values scaled from -1 to 1]
%
% Limit raw values between [-3 3] & center colorbar at value=0
%    [cols,cIdx,cMap,cOrder] = colorbarFromValues_KT(vals,"viridis",[-3 3],center=0)
%
% Z-transform & limit scale to z-score=[-3 3] with center at z=0
%    [cols,cIdx,cMap,cOrder] = colorbarFromValues_KT(vals,"viridis",[-3 3],center=0,zscore=1)
%
% Limit raw values between [-8 10], center at value=0, scale to standard deviation between [-3 3]:
%    [cols,cIdx,cMap,cOrder] = colorbarFromValues_KT(vals,"viridis",[-8 10],center=0,zscore=[-3 3])

%% Inputs
arguments
    vals {isnumeric} % Vector of numeric values
    cMapName {ischar,isstring} = "RdBu" % Name of colormap
    cLim {isnumeric} = [] % Raw/z-score value limits to clip: [lowerLimit,upperLimit]
    a.center {isnumeric,istext} = [] % Center raw/zscored values at this number
    a.zscore {isnumeric,islogical} = false % do z-transform (true|false), zscore limits [lowerZ,upperZ]
end

%% Scale values

% Get number of colors
nCols = length(vals);
if nCols<256
    nCols = 256;
end

% Set value limits
if numel(cLim)==2
    vals(vals<cLim(1)) = cLim(1);
    vals(vals>cLim(2)) = cLim(2);
end

% Z-score values
if any(a.zscore)
    if any(a.center)
        vals = normalize(vals,center=a.center,scale="std");
    else
        vals = normalize(vals,"zscore");
    end

    % Clip z-scores at limits
    if numel(a.zscore)==2
        cLim = a.zscore;
        vals(vals<cLim(1)) = cLim(1);
        vals(vals>cLim(2)) = cLim(2);
    end 
elseif ~isempty(a.center) % Center colorbar
    vals = normalize(vals,"center",a.center);
    cLim = [min(vals) max(vals)];
    cLim = [-max(abs(cLim(1)),abs(cLim(2))) max(abs(cLim(1)),abs(cLim(2)))];
end

% Use range if no specified clim
if numel(cLim)<2
    cLim = [min(vals) max(vals)];
end

% Get value order & indices 
vals = (vals-cLim(1))./(cLim(2)-cLim(1));
cIdx = round(vals.*(nCols-1))+1;
cIdx(cIdx<1) = 1;
cIdx(cIdx>nCols) = nCols;
in = ~isnan(cIdx);

%% Colormap the values
switch cMapName
    case 'parula'
        cMap = parula(nCols);
    case 'viridis'
        cMap = viridis(nCols);
    case 'jet'
        cMap = jet(nCols);
    case 'turbo'
        cMap = turbo(nCols);
    case 'hot'
        cMap = hot(nCols);
    case 'RedBlue'
        cMap = cmRedBlue(nCols);
        cMap = flip(cMap);
    case 'VioletGreen'
        cMap = cmVioletGreen(nCols);
    case 'PinkGreen'
        cMap = cmPinkGreen(nCols);
    case 'YellowGreen'
        cMap = cmYellowGreen(nCols);
    case 'RedsWhite'
        cMap = cmRedsWhite(nCols);
    case 'BluesWhite'
        cMap = cmBluesWhite(nCols);
    otherwise
        cMap = cbrewer2(cMapName, nCols);
        cMap = flip(cMap);
end

% Get colors of each value
cols = nan(length(vals),3);
cols(in,:) = cMap(cIdx(in),:);

if nargout>3
    vals(~in) = -Inf;
end
end

%% Depreciated
% if centerAtZero 
%     cLim = [-max(abs(cLim(1)),abs(cLim(2))) max(abs(cLim(1)),abs(cLim(2)))];
% end
% if isempty(clim) % if no limits specified, set colorscale limits based on range of data
%     if center_zero % i.e. if value of 0 set to center of colormap
%         min_value_symetric = -(nanmax([nanmax(vals) abs(nanmin(vals))]));
%         colIdx = floor((vals-min_value_symetric)/(-2*min_value_symetric) * 100) + 1;
%     else % adjust colormap to whole range of values
%         colIdx=floor((vals-nanmin(vals))/range(vals) * ncols) + 1;
%     end
% else 
%     vals(vals<clim(1))=clim(1);
%     vals(vals>clim(2))=clim(2);
% %     values(values>clim(2))=values(values>clim(2))/max(values(values>clim(2))) * clim(2); 
%     if center_zero % colorbar centered at zero
%         clim = [-max(abs(clim(1)),abs(clim(2))) max(abs(clim(1)),abs(clim(2)))];
%     end
%     colIdx = floor((vals-clim(1))/(clim(2)-clim(1)) * ncols) + 1;
% end
% colIdx(colIdx<1) = 1;
% colIdx(colIdx>ncols) = ncols;
% 
% 
% 
% if strcmp(color_map, 'parula') == 1
%     cols = parula(range(col_idx)+1);
% elseif strcmp(color_map, 'RedBlue') == 1
%     cols = cmRedBlue(range(col_idx)+1);
% elseif strcmp(color_map, 'VioletGreen') == 1
%     cols = cmVioletGreen(range(col_idx)+1);
% elseif strcmp(color_map, 'PinkGreen') == 1
%     cols = cmPinkGreen(range(col_idx)+1);
% elseif strcmp(color_map, 'YellowGreen') == 1
%     cols = cmYellowGreen(range(col_idx)+1);
% else
%     cols = cbrewer2(color_map, range(col_idx)+1);
% end
