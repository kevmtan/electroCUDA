% this file generates a dendrogram and saves it as a png. Thumbnails of the images are put along the bottom of the dendrogram by creating an html page.

Y = RDM;
Z = linkage(Y,'average');

%h=warndlg('Please do not close the window containing the dendrogram. The script will not be able to save the dendrogram if its window is closed.');
%uiwait(h);

[H,T, perm] = dendrogram(Z,0, 'orientation','left'); %create dendrogram
set(figure(1), 'Visible', 'off');
set(H,'LineWidth',2);
set(figure(1), 'Visible', 'off');
H = figure(1);
set(figure(1), 'Visible', 'off');
set(H, 'Position', [0 0 1000 1000]);
set(figure(1), 'Visible', 'off');
file_name = sprintf('%s/dendrogram-%s.png', folder_name, time_stamp);
print(H, file_name, '-dpng'); % save dendrogram as png
set(figure(1), 'Visible', 'off');
%% Read then crop the dendrogram
I = imread(file_name);
I = imrotate(I, 270);
I_size = size(I);
%crop image. first find the edges which will be blue.
%comming from left
l_edge = 0;
for j=1:I_size(2)
    for i=1:I_size(1)
      if I(i,j,1) < 50 && I(i,j,2) < 50 && I(i,j,3) > 150
          l_edge = j;
          break;
      end
   end
   if l_edge
       break;
   end
end

%comming from right
r_edge = 0;
for j=0:I_size(2)+1
    for i=1:I_size(1)
      if I(i,I_size(2)-j,1) < 50 && I(i,I_size(2)-j,2) < 50 && I(i,I_size(2)-j,3) > 150
          r_edge = I_size(2)-j;
          break;
      end
   end
   if r_edge
       break;
   end
end

%comming from bottom
b_edge = 0;
for i=0:I_size(1)+1
    for j=1:I_size(2)
      if I(I_size(1)-i,j,1) < 50 && I(I_size(1)-i,j,2) < 50 && I(I_size(1)-i,j,3) > 150
          b_edge = I_size(1)-i;
          break;
      end
   end
   if b_edge
       break;
   end
end
h_size = r_edge - l_edge; % new horizantal size. one fourth the width of a thumbnail is added to each side so that
% the lines of the dendrogram are more towards the center of the thumbnails

I = I(1:b_edge, (l_edge - floor(0.25*h_size/n_imgs)):(r_edge + floor(0.25*h_size/n_imgs)), :);
imwrite(I, file_name);

%% Create html file %%
width = disp_size * n_imgs; % width the dendrogram should be shown
file_name = sprintf('%s/dendrogram-%s.html', folder_name, time_stamp);
handle = fopen(file_name, 'w');
% show dendrogram
fprintf(handle, '<img src="dendrogram-%s.png" width="%i"><br><table border=0 cellspacing=0 cellpadding=0><tr cellpadding=0 cellspacing=0>', time_stamp, width);
for(i=1:n_imgs) % show the thumbnails. based on their IDs in 'perm', returned by dendrogram()
	output = sprintf('<td cellpadding=0 cellspacing=0><a href="../%s"><img border=0 src="../%s" height="%i" width="%i"></a></td>', ...
				word_map{perm(i)}, word_map{perm(i)}, disp_size, disp_size);
	fprintf(handle, output);
end
fclose(handle);
fprintf('Dendrogram saved: %s\n',file_name);
%close(figure(1)); % close the dendrogram