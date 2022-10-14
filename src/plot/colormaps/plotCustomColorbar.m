function plotCustomColorbar(color_map, direction)

%% Directories
% initialize_dirs

%% Load template brain (only right hemisphere)
% cortex_TemplateRight = load([data_root 'cortex/Colin_cortex_right.mat']);
% cortex_TemplateLeft = load([data_root 'cortex/Colin_cortex_left.mat']);
% GrouPresultsDir = [data_root 'figures/MMR/group/'];

%% Get colors
bar_range = -1:.05:1;
bar_range = linspace(-1,1,40)
bar_range = 1:20

% bar_range = [bar_range(1:18) bar_range(end-17:end)]

% bar_range(bar_range == 0) = [];
bar_range(bar_range>-0.4 & bar_range<0.4) = [];


[col_idx,cols] = colorbarFromValues(bar_range, color_map, [],false);
cols = flip(cols);

%% Determine colorbar direction
if strcmp(direction, 'horizontal')
    X = bar_range; Y = zeros(length(bar_range),1);
%     textX1 = bar_range(1)*1.3; textX2 = 1.15; textX3 = -0.05;
%     textY1 = 0; textY2 = 0; textY3 = 0;
    XLim = [-1.5 1.5]; YLim = [-.2 .2];
elseif strcmp(direction, 'vertical')
    X = zeros(length(bar_range),1) ; Y = bar_range;
%     textX1 = -0.01; textX2 = -0.005; textX3 = -0.005;
%     textY1 = -1.3; textY2 = 1.25; textY3 = -0.05;
    XLim = [-.2 .2]; YLim = [-2 2];    
else
    error('Error: you can only speficy direction horizontal or vertical')
end

%% Plot 
for i = 1:length(X);
    hold on
%      plot(i, Y(i), '.', 'MarkerSize', 84*abs(bar_range(i)), 'Color', [0 0 0]);
%      plot(i, Y(i), '.', 'MarkerSize', 80*abs(bar_range(i)), 'Color', cols(col_idx(i),:));
    plot(X(i), Y(i), '.', 'MarkerSize', 60, 'Color', cols(col_idx(i),:));
end
% text(textX1, textY1, '-1', 'FontSize',20)
% text(textX2, textY2, '1', 'FontSize',20)
% text(textX3, textY3,'\beta', 'FontWeight', 'bold', 'FontSize',20)
% xlim([XLim])
% ylim([YLim])
set(gca,'visible','off');

%% Save
savePNG(gcf,200, [GrouPresultsDir 'colorbar_' color_map '_' direction '.png'])

end


