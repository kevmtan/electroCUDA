function [n,x,psy,trialNfo,chNfo] = ec_loadSbj(dirs,sfx,fs,onlyVar,o)
% Input validation
arguments
    dirs {isstruct,ischar,isstring} = []
    sfx {isStringScalar,ischar} = ""
    fs {isnumeric} = []
    onlyVar {isstring,ischar,ismember(onlyVar,["x" "n" ""])} = ""
    o.sbj {isstring,ischar,isnumeric} = []
    o.proj {isstring,ischar} = []
end
if ~isstruct(dirs); dirs = ec_getDirs(dirs,o.sbj,o.proj); end
sbjID = dirs.sbjID;
proj = dirs.proj;
if isnumeric(sbjID); sbjID = "s"+sbjID; end
if ~startsWith(sbjID,"s"); sbjID = "s"+sbjID; end
if isstring(fs)||ischar(fs); onlyVar=fs; fs=[]; end

%% Load

% Metadata "n" struct
if onlyVar=="" || onlyVar=="n" || (onlyVar~="" && nargout>=2) ||...
        isempty(fs) && (nargout>=3 || ismember(onlyVar,["psy" "trialNfo"]))
    fpath = dirs.robustSbj+"n"+sfx+"_"+sbjID+"_"+proj;
    load(fpath,"n"); disp("LOADED: "+fpath);

    % Check sampling rate
    if isempty(fs); fs=n.fs; disp("CHECKING SAMPLING RATE"); end
end
if fs==1000; fs=""; else; fs=string(fs); end

% EEG data for sfx
fpath = dirs.robustSbj+"x"+sfx+"_"+sbjID+"_"+proj;
if nargout>=2
    load(fpath,"x"); disp("LOADED: "+fpath);
elseif onlyVar=="x" && nargout<=1
    n = load(fpath,"x"); disp("LOADED: "+fpath);
    n = n.x;
end

% Behavioral task data aligned to EEG recordings
fpath = dirs.robustSbj+"psy"+fs+"_"+sbjID+"_"+proj;
if nargout >=3  
    load(fpath,"psy");  disp("LOADED: "+fpath);
elseif onlyVar=="psy" && nargout<=1
    n = load(fpath,"psy");  disp("LOADED: "+fpath);
    n = n.psy;
end

% Trial information
fpath = dirs.robustSbj+"trialNfo"+fs+"_"+sbjID+"_"+proj;
if nargout >= 4
    load(fpath,"trialNfo"); disp("LOADED: "+fpath);
elseif onlyVar=="trialNfo" && nargout<=1
    n = load(fpath,"trialNfo");  disp("LOADED: "+fpath);
    n = n.trialNfo;
end

% Channel information
fpath = dirs.robustSbj+"chNfo_"+sbjID+"_"+proj;
if nargout >= 5
    load(fpath,"chNfo"); disp("LOADED: "+fpath);
elseif onlyVar=="chNfo" && nargout<=1
    n = load(fpath,"chNfo");  disp("LOADED: "+fpath);
    n = n.chNfo;
end