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
[dirServer,dirComp,dirCode,dirFS] = AddPaths(usrStr);

dirs.code = string(dirCode);
dirs.comp = string(dirComp); 
dirs.data = dirs.comp; 
dirs.orig = dirs.data+"orig"+filesep;
dirs.psych = dirs.orig;
dirs.robust = dirs.data+"robust"+filesep;
dirs.anal = dirComp+"anal"+filesep;
dirs.freesurfer = string(dirServer);
dirs.fsaverage = string(dirFS);
if ~isempty(sbj)
    dirs.sbj = sbj;
    dirs.sbjID = sbjID;
    dirs.proj = proj;
    dirs.psychSbj = dirs.psych+sbj+filesep;
    dirs.origSbj = dirs.orig+sbj+filesep;
    dirs.robustSbj = dirs.robust+"s"+sbjID+filesep+proj+filesep;
    dirs.fsSbj = dirs.freesurfer+sbj+filesep;
end