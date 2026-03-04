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
    a.compact string...
        {mustBeMember(a.compact,["n" "x" "psy" "trialNfo" "chNfo" "" []])} = ""
end


%% Prep
nOut = nargout;
varargout = cell(1,nOut);

% Directories
if isempty(dirs); dirs = ec_getDirs(a.proj,a.task,a.sbj); end
sbjID = dirs.sbjID;
task = dirs.task;
if isnumeric(sbjID); sbjID = "s"+sbjID; end
if ~startsWith(sbjID,"s"); sbjID = "s"+sbjID; end

% Preload metadata "n" struct
if any(ismember(a.vars,["n" "psy" "trialNfo"]))
    % Load
    fn = dirs.procSbj+"n"+a.sfx+"_"+sbjID+"_"+task+".mat";
    load(fn,"n");

    % Check sampling rate
    if ~a.hz
        a.hz = n.hz;
        disp("[ec_loadSbj] Verified sampling rate: "+a.hz+"hz");
    end

    % Original sampling rate not appended on filenames
    if a.hz==n.hz_og
        a.hz="";
    end

    % Check if psy/trialNfo needs to be resampled
    if any(ismember(a.vars,["psy" "trialNfo"]))
        fn = dirs.procSbj+"psy"+a.hz+"_"+sbjID+"_"+task+".mat";
        if ~exist(fn,"file")
            % Resample 'psy'
            [~,~,n,~,trialNfo,psy] =...
                ec_initialize(dirs.sbj,dirs.proj,dirs.task,a,n,...
                hz=a.hz,saveN=false);
        end
    end
end


%% Load variables
for v = 1:numel(a.vars)
    vv = a.vars(v); % Variable name

    % Metadata "n" struct
    if vv=="n" && v<=nOut
        fn = dirs.procSbj+"n"+a.sfx+"_"+sbjID+"_"+task+".mat";
        disp("[ec_loadSbj] Loaded: "+fn); % Display preloaded n

        if ismember("n",a.compact)
            n = rmfield(n,["asr" "zapline" "chDist" "fsNfo" "chCov" "chVar"...
                "chCorr" "freqsRun"]);
            n.o.asr = rmfield(n.o.asr,"chIgnore");
            disp("[ec_loadSbj] Compacted: "+fn); % Load
        end
        varargout{v} = n;
    end

    % EEG data for a.sfx
    if vv=="x" && v<=nOut
        fn = dirs.procSbj+"x"+a.sfx+"_"+sbjID+"_"+task+".mat";
        load(fn,"x"); disp("[ec_loadSbj] Loaded: "+fn);

        if ismember("x",a.compact) && isdouble(x)
            x = single(x);
            disp("[ec_loadSbj] Compacted to single-precision: "+fn); % Load
        end
        varargout{v} = x;
    end

    % Psychobehavioral data (EEG recording metadata)
    if vv=="psy" && v<=nOut
        fn = dirs.procSbj+"psy"+a.hz+"_"+sbjID+"_"+task+".mat";
        if ~exist("psy","var")
            load(fn,"psy");
        end
        disp("[ec_loadSbj] Loaded: "+fn);
        varargout{v} = psy;
    end

    % Trial information
    if vv=="trialNfo" && v<=nOut
        fn = dirs.procSbj+"trialNfo"+a.hz+"_"+sbjID+"_"+task+".mat";
        if ~exist("trialNfo","var")
            load(fn,"trialNfo"); disp("[ec_loadSbj] Loaded: "+fn);
        end
        varargout{v} = trialNfo;
    end

    % Channel information
    if vv=="chNfo" && v<=nOut
        fn = dirs.procSbj+"chNfo_"+sbjID+"_"+task+".mat";
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