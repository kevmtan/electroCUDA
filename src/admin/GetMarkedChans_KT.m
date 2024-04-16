function [refChan, badChan, epiChan, emptyChan, noisyChan, altBadChan] =...
    GetMarkedChans_KT(sbj_name, T)

% Convert string to numbers
markChans = {'Pathological','Noisy','Reference','Empty','Other'};
for i = 1:length(markChans)
    T.(markChans{i}) = cellfun(@str2num ,T.(markChans{i}),'UniformOutput',false);
end

% Select the subject rows
T = T(strcmp(T.sbj_name, sbj_name),:);

if height(T) < 1
    refChan = [];
    badChan = [];
    epiChan = [];
    emptyChan = [];
    noisyChan = [];
    altBadChan = [];
    warning([sbj_name ' not found in marked chan table']);
else
    refChan = T.Reference{:};
    badChan = [T.Noisy{:} T.Other{:}];
    epiChan = T.Pathological{:};
    emptyChan = T.Empty{:};
    noisyChan = T.Noisy{:};
    altBadChan = T.Other{:};
end
end