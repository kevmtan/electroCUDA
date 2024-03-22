function dirs = ec_getDirs(proj,sbj,task,sbjID)
% You must edit 'ecu_paths' to match the directorieson your system
%% Input validation
arguments
    proj string = "lbcn"
    sbj {istext,isnumeric} = []
    task string = "MMR";
    sbjID uint16 = []
end

if isempty(sbjID) && ~isempty(sbj)
    if isnumeric(sbj)
        sbjID = sbj;
    else
        sbjID = str2double(extractBetween(sbj,"_","_"));
    end
end

%% Organize dirs

% Project-specific
if isstruct(proj)
    dirs = proj;
else
    dirs = ecu_paths(proj);
    dirs.src = dirs.code+"src"+filesep;
    dirs.srcCUDA = dirs.src+"cuda"+filesep;
    dirs.orig = dirs.data+"orig"+filesep;
    dirs.psych = dirs.orig;
    dirs.proc = dirs.data+"proc"+filesep;
    dirs.anal = dirs.data+"anal"+filesep;
    dirs.fsaverage = dirs.freesurfer+"fsaverage"+filesep;
end

% Subject-specific
if ~isempty(sbj)
    dirs.sbj = sbj;
    dirs.sbjID = sbjID;
    dirs.task = task;
    dirs.psychSbj = dirs.psych+sbj+filesep;
    dirs.origSbj = dirs.orig+sbj+filesep;
    dirs.procSbj = dirs.proc+"s"+sbjID+filesep+task+filesep;
    dirs.fsSbj = dirs.freesurfer+sbj+filesep;
end