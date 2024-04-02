function varargout = ec_loadSbj(dirs,a)
% Input validation
arguments
    dirs {isempty,isstruct} = []
    a.sfx string = ""   
    a.vars {mustBeMember(a.vars,["n" "x" "psy" "trialNfo" "chNfo"])} = ["n" "x" "psy" "trialNfo" "chNfo"]
    a.fs (1,1) double = 0
    a.sbj {istext,isnumeric} = []
    a.proj string = ""
    a.task string = ""
end
if ~isstruct(dirs); dirs = ec_getDirs(a.proj,a.sbj,a.task); end
sbjID = dirs.sbjID;
task = dirs.task;
if isnumeric(sbjID); sbjID = "s"+sbjID; end
if ~startsWith(sbjID,"s"); sbjID = "s"+sbjID; end

%% Load
ii = 0;
nOut = nargout;

% Metadata "n" struct
fpath = dirs.procSbj+"n"+a.sfx+"_"+sbjID+"_"+task;
if any(a.vars=="n") || ~a.fs && any(ismember(a.vars,["psy" "trialNfo"]))
    load(fpath,"n"); disp("[ec_loadSbj] Loaded: "+fpath); % Load
    if ~a.fs; a.fs=n.fs; end % Check sampling rate
    if any(a.vars=="n")
        ii = ii+1;
        varargout{ii} = n;
    end
end
if a.fs==1000; a.fs=""; else; a.fs=string(a.fs); end % Default sampling rate not appended in filename

% EEG data for a.sfx
if any(a.vars=="x") && ii<nOut
    fpath = dirs.procSbj+"x"+a.sfx+"_"+sbjID+"_"+task;
    load(fpath,"x"); disp("[ec_loadSbj] Loaded: "+fpath);
    ii = ii+1;
    varargout{ii} = x;
end

% Behavioral task data aligned to EEG recordings
if any(a.vars=="psy") && ii<nOut
    fpath = dirs.procSbj+"psy"+a.fs+"_"+sbjID+"_"+task;
    load(fpath,"psy");  disp("[ec_loadSbj] Loaded: "+fpath);
    ii = ii+1;
    varargout{ii} = psy;
end

% Trial information
if any(a.vars=="trialNfo") && ii<nOut
    fpath = dirs.procSbj+"trialNfo"+a.fs+"_"+sbjID+"_"+task;
    load(fpath,"trialNfo"); disp("[ec_loadSbj] Loaded: "+fpath);
    ii = ii+1;
    varargout{ii} = trialNfo;
end

% Channel information
if any(a.vars=="chNfo") && ii<nOut
    fpath = dirs.procSbj+"chNfo_"+sbjID+"_"+task;
    load(fpath,"chNfo"); disp("[ec_loadSbj] Loaded: "+fpath);
    ii = ii+1;
    varargout{ii} = chNfo;
end

% Dirs
if ii < nOut
    ii = ii+1;
    varargout{ii} = dirs;
end