% assumes higher values in RDM = more distance
RDM_s = squareform(RDM);
RDM_s(n_imgs,:) = 0; % make sure the matrix is square
correlation_back = RDM_s; % preserve data. correlation_back will be altered

%determine max value in RDM
for(i=1:n_imgs)
	for(j=1:n_imgs) % set inf to 0 so they will not alter results
		if correlation_back(i,j) == Inf
            correlation_back(i,j) = 0;
        end
	end
end
max_val = max(max(correlation_back));
% determine min value, ignoring zeros
for(i=1:n_imgs)
	for(j=1:n_imgs) % set zeros to infinity so they will not alter results
		if ~correlation_back(i,j)
            correlation_back(i,j) = Inf;
        end
	end
end
min_val = min(min(correlation_back));

diff = max_val - min_val;
% normalize so smallest value is zero and max value is 'diff'
correlation_back = correlation_back - min_val;
cd ..
file_name = sprintf('%s/results/heatmap-%s.html', img_dir, time_stamp);
cd scripts
handle = fopen(file_name, 'w');
fprintf(handle, 'Higher values indicate a greater similarity');
fprintf(handle, '<table border=0 cellspacing=0 cellpadding=0><tr cellpadding=0 cellspacing=0>');

% display table heading
for(i=1:n_imgs)
	output = sprintf('<td cellspacing=0 cellpadding=0><a href="../%s"><img border=0 src="../%s" height="%i" width="%i"></a></td>', word_map{i}, word_map{i}, disp_size, disp_size);
	fprintf(handle, output);
end
fprintf(handle, '</tr>');

% display each stimuli as a row
for(i=1:n_imgs)
	fprintf(handle, '<tr cellspacing=0 cellpadding=0>');
	for(j=(n_imgs+2-i):n_imgs) % blank space so that the heatmap has a triangular shape
		fprintf(handle, '<td> </td>');
	end
	% show thumbnail of image
	output = sprintf('<td cellspacing=0 cellpadding=0><a href="../%s"><img border=0 src="../%s" height="%i" width="%i"></a></td>', word_map{i}, word_map{i}, disp_size, disp_size);
	fprintf(handle, output);
	for(j=(i+1):n_imgs) % display each comparison (as columns)
		percent = 1 - (correlation_back(i,j) / diff);
		redness = round(255*percent); % determines color to be displayed as background
        prefix = ''; % prefixed if redness <= 0xF for html color code
        if(redness <= 16) % 16 = 0xF
            prefix = '0';
        end
		output = sprintf('<td cellspacing=0 cellpadding=0 bgcolor="#%s%X0000"><font color=white>%i</td>', prefix, redness, round(100*percent));
		fprintf(handle, output);
	end
	fprintf(handle, '</tr>');
end
fclose(handle);
fprintf('Heatmap saved: %s\n',file_name);