function dirs = ec_getDirs(proj,task,sbj,sbjID)
% You must edit 'ecu_paths' to match the directorieson your system
%% Input validation
arguments
    proj string = ""
    task string = ""
    sbj {istext,isnumeric} = []
    sbjID uint16 = []
end

if isempty(sbjID) && ~isempty(sbj)
    if isnumeric(sbj)
        sbjID = sbj;
    elseif proj=="lbcn"
        sbjID = str2double(extractBetween(sbj,"_","_"));
    end
end

%% Organize dirs

% Project-specific
dirs = ecu_paths(proj);
dirs.src = dirs.code+"src"+filesep;
dirs.srcCUDA = dirs.src+"cuda"+filesep;
dirs.orig = dirs.data+"orig"+filesep;
dirs.psych = dirs.orig;
dirs.proc = dirs.data+"proc"+filesep;
dirs.anal = dirs.data+"anal"+filesep;
dirs.fsaverage = dirs.freesurfer+"fsaverage"+filesep;

% Subject-specific
if ~isany(sbj); return; end
dirs.sbj = string(sbj);
dirs.sbjID = sbjID;
dirs.task = task;
dirs.psychSbj = dirs.psych+sbj+filesep;
dirs.origSbj = dirs.orig+sbj+filesep;
dirs.procSbj = dirs.proc+"s"+sbjID+filesep+task+filesep;
dirs.fsSbj = dirs.freesurfer+sbj+filesep;
