function [n,x,psy,trialNfo,chNfo] = ec_loadSbj(dirs,sfx,onlyVar,fs)
% Input validation
arguments
    dirs struct
    sfx string = ""   
    onlyVar {mustBeMember(onlyVar,["n" "x" "psy" "trialNfo" "chNfo" "all"])} = "all"
    fs double = []
end
if ~isstruct(dirs); dirs = ec_getDirs(dirs,o.sbj,o.proj); end
sbjID = dirs.sbjID;
task = dirs.task;
if isnumeric(sbjID); sbjID = "s"+sbjID; end
if ~startsWith(sbjID,"s"); sbjID = "s"+sbjID; end

%% Load

% Metadata "n" struct
fpath = dirs.procSbj+"n"+sfx+"_"+sbjID+"_"+task;
if onlyVar=="all" || onlyVar=="n" || isempty(fs) && ismember(onlyVar,["psy" "trialNfo"])
    load(fpath,"n"); disp("[ec_loadSbj] Loaded: "+fpath); % Load
    if onlyVar=="n" && nargout<=1; return; end
    if isempty(fs); fs=n.fs; end % Check sampling rate
end
if fs==1000; fs=""; else; fs=string(fs); end % Default sampling rate not appended in filename

% EEG data for sfx
if nargout>=2 || onlyVar=="x"
    fpath = dirs.procSbj+"x"+sfx+"_"+sbjID+"_"+task;
    load(fpath,"x"); disp("[ec_loadSbj] Loaded: "+fpath);
    if onlyVar=="x" && nargout<=1
        n = x; return
    end
end

% Behavioral task data aligned to EEG recordings
if nargout>=3 || onlyVar=="psy"
    fpath = dirs.procSbj+"psy"+fs+"_"+sbjID+"_"+task;
    load(fpath,"psy");  disp("[ec_loadSbj] Loaded: "+fpath);
    if onlyVar=="psy" && nargout<=1
        n = psy; return
    end
end

% Trial information
if nargout>=4 || onlyVar=="trialNfo"
    fpath = dirs.procSbj+"trialNfo"+fs+"_"+sbjID+"_"+task;
    load(fpath,"trialNfo"); disp("[ec_loadSbj] Loaded: "+fpath);
    if onlyVar=="trialNfo" && nargout<=1
        n = trialNfo; return
    end
end

% Channel information
if nargout>=5 || onlyVar=="chNfo"
    fpath = dirs.procSbj+"chNfo_"+sbjID+"_"+task;
    load(fpath,"chNfo"); disp("[ec_loadSbj] Loaded: "+fpath);
    if onlyVar=="chNfo" && nargout<=1
        n = chNfo; return
    end
end