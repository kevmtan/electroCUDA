function dirs = ec_getDirs(usrStr,sbj,proj,sbjID)
arguments
    usrStr {isstruct,ischar,isstring} = []
    sbj {isstring,ischar,isnumeric} = []
    proj {ischar,isstring} = "MMR";
    sbjID {isnumeric} = []
end

if isempty(usrStr)
    usrStr = 'Kevin_DMN';
elseif isstruct(usrStr)
    dirs = usrStr;
end
if isempty(sbjID) && ~isempty(sbj)
    if isnumeric(sbj)
        sbjID = sbj;
    else
        sbjID = str2double(extractBetween(sbj,"_","_"));
    end
end

%% Initialize directories
[dirFreesufer,dirMain,dirCode,path_cudaica] = AddPaths(usrStr);

dirs.code = string(dirCode);
dirs.comp = string(dirMain); 
dirs.data = dirs.comp; 
dirs.orig = dirs.data+"orig"+filesep;
dirs.psych = dirs.orig;
dirs.robust = dirs.data+"robust"+filesep;
dirs.anal = dirMain+"anal"+filesep;
dirs.freesurfer = string(dirFreesufer);
dirs.fsaverage = dirs.freesurfer+sbj+filesep+"fsaverage";
dirs.cudaica = path_cudaica;
if ~isempty(sbj)
    dirs.sbj = sbj;
    dirs.sbjID = sbjID;
    dirs.proj = proj;
    dirs.psychSbj = dirs.psych+sbj+filesep;
    dirs.origSbj = dirs.orig+sbj+filesep;
    dirs.robustSbj = dirs.robust+"s"+sbjID+filesep+proj+filesep;
    dirs.fsSbj = dirs.freesurfer+sbj+filesep;
end