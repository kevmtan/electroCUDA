%% create time stamp %%
t = now;
c = datevec ( t );
time_stamp = sprintf('%s-%s', name, datestr ( c, 30 )); % appended to each file name


save_results_heatmap
save_results_dendrogram
% save workspace %%
file_name = sprintf('%s/results/variables-%s.mat', folder_name,time_stamp);
save(file_name)