function dirs = ec_getDirs(proj,task,sbj,sbjID)
% Get directories
% You must edit 'ecu_paths' to match the directories on your system

%% Input validation
arguments
    proj (1,1) string
    task (1,1) string = ""
    sbj {mustBeTextOrNumeric} = ""
    sbjID (1,1) double = nan
end
if ~isany(proj); error("'proj' input must not be empty"); end
if istext(sbj); sbj=string(sbj); end

%% Main
dirs = ecu_paths(proj); % Get user-specified directories

% Preallocate
dirs.sbj = "";
dirs.sbjID = nan;
dirs.task = task;

% Fill common paths
dirs.src = dirs.code+"src"+filesep;
dirs.srcCUDA = dirs.src+"cuda"+filesep;
dirs.orig = dirs.data+"orig"+filesep;
dirs.psych = dirs.orig;
dirs.proc = dirs.data+"proc"+filesep;
dirs.anal = dirs.data+"anal"+filesep;
dirs.fsaverage = dirs.freesurfer+"fsaverage"+filesep;

% Get subject numeric ID
if isnan(sbjID)
    if istext(sbj) && isany(sbj)
        sbjID = dirs.getSbjID(sbj);
    elseif isnumeric(sbj) && ~isnan(sbj) && ~isempty(sbj)
        sbjID = sbj; % sbj is actually sbjID
        sbj = "";
    end
end

% Get subject text string
if isempty(sbj) || isnumeric(sbj) || istext(sbj) && ~isany(sbj)
    if ~isempty(sbjID) && isnumeric(sbjID) && ~isnan(sbjID)
        for v = ["orig" "freesurfer"]
            sbjs = struct2table(dir(dirs.(v)));
            sbjs.name = string(sbjs.name);
            sbjs.ID = arrayfun(dirs.getSbjID,sbjs.name,'UniformOutput',false);
            sbjs = sbjs(~cellfun(@isempty,sbjs.ID),:);
            sbjs.ID = cell2mat(sbjs.ID);
            sbj = sbjs.name(sbjs.ID==sbjID);
            if numel(sbj)>1; sbj = sbj(1); end
            if istext(sbj) && isany(sbj); break; end
        end
    end
end

% Finalize sbj entries
if istext(sbj) && isany(sbj)
    dirs.sbj = string(sbj);
    dirs.fsSbj = dirs.freesurfer+sbj+filesep;
    dirs.psychSbj = dirs.psych+sbj+filesep;
    dirs.origSbj = dirs.orig+sbj+filesep;
    % Finalize sbjID entries
    if ~isempty(sbjID) && isnumeric(sbjID) && ~isnan(sbjID)
        sbjID = uint16(sbjID);
        dirs.sbjID = sbjID;
        dirs.procSbj = dirs.proc+"s"+sbjID+filesep;
        if isany(task)
            dirs.procSbj = dirs.procSbj+task+filesep; end
    end
end