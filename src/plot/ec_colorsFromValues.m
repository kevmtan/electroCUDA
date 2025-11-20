function [rgb,id,cmap,x] = ec_colorsFromValues(x,name,clim,a)
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
    x double % Vector of numeric values
    name char = 'RdBu' % Name of colormap
    clim (1,2) double = [nan nan] % Raw/z-score value limits to clip: [lowerLimit,upperLimit]
    a.center (1,1) double = nan % Center raw/zscored values at this number
    a.zscore (1,:) double = false % do z-transform (true|false), zscore limits [lowerZ,upperZ]
end

%% Get colormap

% Get number of colors
n = numel(x);
if n<256
    n = 256; end

% Generate colormap with n colors
switch name
    case 'parula'
        cmap = parula(n);
    case 'viridis'
        cmap = viridis(n);
    case 'jet'
        cmap = jet(n);
    case 'turbo'
        cmap = turbo(n);
    case 'hot'
        cmap = hot(n);
    case 'RedBlue'
        cmap = cmRedBlue(n);
        cmap = flip(cmap);
    case 'VioletGreen'
        cmap = cmVioletGreen(n);
    case 'PinkGreen'
        cmap = cmPinkGreen(n);
    case 'YellowGreen'
        cmap = cmYellowGreen(n);
    case 'RedsWhite'
        cmap = cmRedsWhite(n);
    case 'BluesWhite'
        cmap = cmBluesWhite(n);
    otherwise
        cmap = cbrewer2(name,n);
        cmap = flip(cmap);
end


%% Scale values

% Set value limits
if all(~isnan(clim))
    x(x<clim(1)) = clim(1);
    x(x>clim(2)) = clim(2);
end

% Z-score values
if any(a.zscore)
    if ~isnan(a.center)
        x = normalize(x,center=a.center,scale="std");
    else
        x = normalize(x,"zscore");
    end

    % Clip z-scores at limits
    if numel(a.zscore)==2
        clim = a.zscore;
        x(x<clim(1)) = clim(1);
        x(x>clim(2)) = clim(2);
    end 
elseif ~isnan(a.center) % Center colorbar
    x = normalize(x,"center",a.center);
    clim = [min(x) max(x)];
    clim = [-max(abs(clim(1)),abs(clim(2))) max(abs(clim(1)),abs(clim(2)))];
end

% Use range if no specified clim
if all(isnan(clim))
    clim = [min(x) max(x)];
end

% Get color index
id = fix((x-clim(1))./(clim(2)-clim(1)) * (n-1)) + 1;

% Get colors of each value
rgb = ind2rgb(id,cmap);
rgb = squeeze(rgb);

% NaN colors for NaN values
q = isnan(id);
rgb(q,:) = nan;
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
