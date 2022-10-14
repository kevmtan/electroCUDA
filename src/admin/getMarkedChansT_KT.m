function chsBad = getMarkedChansT_KT(sbj,T)

% Convert string to numbers
markChans = {'Pathological','Noisy','Reference','Empty','Other'};
for i = 1:length(markChans)
    T.(markChans{i}) = cellfun(@str2num ,T.(markChans{i}),'UniformOutput',false);
end

% Select the subject rows
chsBad = T(strcmp(T.sbj_name, sbj),:);
end