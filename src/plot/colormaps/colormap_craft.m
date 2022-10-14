

    'BrBG',     'div'; ...
    'PiYG',     'div'; ...
    'PRGn',     'div'; ...
    'PuOr',     'div'; ...
    'RdBu',     'div'; ...
    'RdGy',     'div'; ...
    'RdYlBu',   'div'; ...
    'RdYlGn', 	'div'; ...
    'Spectral', 'div'; ...

cm = cbrewer2('PiYG', 300);
cm = cm(45:255,:);



for i = 1:length(cm)
     plot(i,0, 'o', 'MarkerFaceColor', cm(i,:), 'MarkerEdgeColor', 'none', 'MarkerSize', 40)
     hold on
end



colormap_parula_white = get(gcf,'Colormap');
cmgreen = get(gcf,'Colormap');

cmyellowgreen = [cmyellow(1:end-1,:); flip(cmgreen(2:end,:))]

cm = cmyellowgreen