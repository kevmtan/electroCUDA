function varargout = ec_loadSbj(dirs,a)
%% Load electroCUDA subject data
% Output variables follow the same order as user input in "vars" argument

%% Input validation
arguments
    dirs {isempty,isstruct} = []
    a.sbj {istext,isnumeric} = []
    a.proj (1,1) string = ""
    a.task (1,1) string = ""
    a.sfx (1,1) string = ""
    a.hz (1,1) double = 0
    a.vars string...
        {mustBeMember(a.vars,["n" "x" "psy" "trialNfo" "chNfo" "dirs"])} = "dirs"
end

% Directories
if ~isstruct(dirs); dirs = ec_getDirs(a.proj,a.task,a.sbj); end
sbjID = dirs.sbjID;
task = dirs.task;
if isnumeric(sbjID); sbjID = "s"+sbjID; end
if ~startsWith(sbjID,"s"); sbjID = "s"+sbjID; end

%% Load
nOut = nargout;
varargout = cell(1,nOut);

% Check sampling rate
if ~a.hz && any(ismember(a.vars,["n" "psy" "trialNfo"]))
    fpath = dirs.procSbj+"n"+a.sfx+"_"+sbjID+"_"+task;
    load(fpath,"n"); disp("[ec_loadSbj] Check sampling rate: "+fpath); % Load
    if ~a.hz; a.hz=n.hz; end
end
if a.hz==1000; a.hz=""; else; a.hz=string(a.hz); end % Default sampling rate not appended


% Loop through requested vars
for v = 1:numel(a.vars)
    vv = a.vars(v); % Variable name

    % Metadata "n" struct
    if vv=="n" && v<nOut
        fpath = dirs.procSbj+"n"+a.sfx+"_"+sbjID+"_"+task;
        disp("[ec_loadSbj] Loaded: "+fpath); % Load
        varargout{v} = n;
    end

    % EEG data for a.sfx
    if vv=="x" && v<nOut
        fpath = dirs.procSbj+"x"+a.sfx+"_"+sbjID+"_"+task;
        load(fpath,"x"); disp("[ec_loadSbj] Loaded: "+fpath);
        varargout{v} = x;
    end

    % Behavioral task data aligned to EEG recordings
    if vv=="psy" && v<nOut
        fpath = dirs.procSbj+"psy"+a.hz+"_"+sbjID+"_"+task;
        load(fpath,"psy");  disp("[ec_loadSbj] Loaded: "+fpath);
        varargout{v} = psy;
    end

    % Trial information
    if vv=="trialNfo" && v<nOut
        fpath = dirs.procSbj+"trialNfo"+a.hz+"_"+sbjID+"_"+task;
        load(fpath,"trialNfo"); disp("[ec_loadSbj] Loaded: "+fpath);
        varargout{v} = trialNfo;
    end

    % Channel information
    if vv=="chNfo" && v<nOut
        fpath = dirs.procSbj+"chNfo_"+sbjID+"_"+task;
        load(fpath,"chNfo"); disp("[ec_loadSbj] Loaded: "+fpath);
        varargout{v} = chNfo;
    end

    % Dirs
    if vv=="dirs" && v<nOut
        varargout{v} = dirs;
    end
end

% Dirs if extra output
if v<nOut
    v = v+1;
    varargout{v} = dirs;
end