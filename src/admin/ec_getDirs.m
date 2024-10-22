function dirs = ec_getDirs(proj,task,sbj,sbjID)
% You must edit 'ecu_paths' to match the directorieson your system
%% Input validation
arguments
    proj (1,1) string = ""
    task (1,1) string = ""
    sbj (1,1) string = 0
    sbjID (1,1) uint16 = 0
end

if ~sbjID && isany(sbj)
    if proj=="lbcn"
        sbjID = str2double(extractBetween(sbj,"_","_"));
    else
        sbjID = str2double(sbj);
    end
end
sbjID = uint16(sbjID);

%% Organize dirs
dirs = ecu_paths(proj);
dirs.src = dirs.code+"src"+filesep;
dirs.srcCUDA = dirs.src+"cuda"+filesep;

% Project-specific
if ~isany(proj); return; end
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
