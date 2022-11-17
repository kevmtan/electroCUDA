
load('cdcol.mat')

for i = 1:length(colors)
    hold on
    plot(i,0, '.', 'Color',cdcol.(colors{i}), 'MarkerSize', 50) 
    text(i,0+0.05, colors{i}, 'rotation', 90, 'Color',cdcol.(colors{i}))
end
set(gca,'visible','off');
savePNG(gcf,200, 'caran_dache_colors.png')
    
    