function varargout = ec_loadSbj(dirs,a)
%% Load electroCUDA subject data
% Output variables follow the same order as user input in "vars" argument


%% Input validation
arguments
    dirs struct = []
    a.sbj {mustBeTextOrNumeric} = ""
    a.proj (1,1) string = ""
    a.task (1,1) string = ""
    a.sfx (1,1) string = ""
    a.hz (1,1) double = 0
    a.vars string...
        {mustBeMember(a.vars,["n" "x" "psy" "trialNfo" "chNfo" "dirs"])} = "dirs"
end


%% Main
nOut = nargout;
varargout = cell(1,nOut);

% Directories
if isempty(dirs); dirs = ec_getDirs(a.proj,a.task,a.sbj); end
sbjID = dirs.sbjID;
task = dirs.task;
if isnumeric(sbjID); sbjID = "s"+sbjID; end
if ~startsWith(sbjID,"s"); sbjID = "s"+sbjID; end

% Preload metadata "n" struct
fn = dirs.procSbj+"n"+a.sfx+"_"+sbjID+"_"+task;
load(fn,"n");

% Check sampling rate
if ~a.hz && any(ismember(a.vars,["n" "psy" "trialNfo"]))
    a.hz = n.hz;
    disp("[ec_loadSbj] Verified sampling rate: "+a.hz+"hz"); % Load
end

% Original sampling rate not appended on filenames
if a.hz==n.hz_og
    a.hz=""; end 

% Loop through requested vars
for v = 1:numel(a.vars)
    vv = a.vars(v); % Variable name

    % Metadata "n" struct
    if vv=="n" && v<=nOut
        fn = dirs.procSbj+"n"+a.sfx+"_"+sbjID+"_"+task;
        disp("[ec_loadSbj] Loaded: "+fn); % Load
        varargout{v} = n;
    end

    % EEG data for a.sfx
    if vv=="x" && v<=nOut
        fn = dirs.procSbj+"x"+a.sfx+"_"+sbjID+"_"+task;
        load(fn,"x"); disp("[ec_loadSbj] Loaded: "+fn);
        varargout{v} = x;
    end

    % Behavioral task data aligned to EEG recordings
    if vv=="psy" && v<=nOut
        fn = dirs.procSbj+"psy"+a.hz+"_"+sbjID+"_"+task;
        load(fn,"psy");  disp("[ec_loadSbj] Loaded: "+fn);
        varargout{v} = psy;
    end

    % Trial information
    if vv=="trialNfo" && v<=nOut
        fn = dirs.procSbj+"trialNfo"+a.hz+"_"+sbjID+"_"+task;
        load(fn,"trialNfo"); disp("[ec_loadSbj] Loaded: "+fn);
        varargout{v} = trialNfo;
    end

    % Channel information
    if vv=="chNfo" && v<=nOut
        fn = dirs.procSbj+"chNfo_"+sbjID+"_"+task;
        load(fn,"chNfo"); disp("[ec_loadSbj] Loaded: "+fn);
        varargout{v} = chNfo;
    end

    % Dirs
    if vv=="dirs" && v<=nOut
        varargout{v} = dirs;
    end
end

% Dirs if extra output
if v<nOut
    v = v+1;
    varargout{v} = dirs;
end