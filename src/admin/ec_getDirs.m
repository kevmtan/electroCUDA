function dirs = ec_getDirs(proj,sbj,task,sbjID)
% You must edit 'ec_paths' to match the directorieson your system
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
    [dirFreesufer,dirMain,dirCode,path_cudaica] = ec_paths(proj);
    dirs.proj = proj;
    dirs.code = string(dirCode);
    dirs.data = string(dirMain);
    dirs.orig = dirs.data+"orig"+filesep;
    dirs.psych = dirs.orig;
    dirs.proc = dirs.data+"proc"+filesep;
    dirs.anal = dirMain+"anal"+filesep;
    dirs.freesurfer = string(dirFreesufer);
    dirs.fsaverage = dirs.freesurfer+"fsaverage"+filesep;
    dirs.cudaica = path_cudaica;
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