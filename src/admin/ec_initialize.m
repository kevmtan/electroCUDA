function [errors,o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,o,n,arg)
% Check inputs
arguments
    sbj
    proj {mustBeText} = 'MMR'
    o struct = struct
    n struct = []
    arg.dsTarg {isnumeric} = [] % Downsampling target freq
    arg.ica logical = false 
    arg.save logical = false
    arg.redo logical = false
    arg.redoN logical = false
    arg.redoCh logical = false
    arg.redoTr logical = false
    arg.redoPsy logical = false
    arg.dirs struct = []
    arg.blocks {mustBeText} = BlockBySubj(sbj,proj)
end
dirs=arg.dirs; blocks=arg.blocks; dsTarg=arg.dsTarg;
if ~isstruct(dirs)||isempty(dirs); dirs = ec_getDirs(dirs,sbj,proj); end
if isempty(blocks); blocks = BlockBySubj(sbj,proj); end
if ~isfield(o,'dirOut'); o.dirOut=dirs.robustSbj; end % Output directory
if ~isfield(o,'fnStr');  o.fnStr="s"+dirs.sbjID+"_"+proj; end % Filename ending string
if ~isfolder(o.dirOut); mkdir(o.dirOut); end
errors={};
% arg.save=0; arg.redoCh=0; arg.redoTr=0; arg.redoPsy=1;

%% Initialize info struct
fn = o.dirOut+"n"+o.suffix+"_"+o.fnStr;
if ~arg.ica || o.suffix=="i"
    fn_base = o.dirOut+"n_"+o.fnStr;
elseif arg.ica || startsWith(o.suffix,"i")
    fn_base = o.dirOut+"ni_"+o.fnStr;
end
if isempty(n) || arg.redo || arg.redoN
    if isfile(fn) && ~arg.redo && ~arg.redoN
        load(fn,"n");
    elseif isfile(fn_base) && ~arg.redo
        load(fn_base,"n");
    elseif ~isfile(fn_base) || arg.redo
        load(dirs.origSbj+"subjVar_"+sbj+".mat","subjVar");
        fs = floor(subjVar.iEEG_rate);

        n = struct; 
        n.sbj = sbj;
        n.sbjID = uint16(str2double(extractBetween(sbj,"_","_")));
        n.proj = proj;
        n.suffix = o.suffix;
        n.fnStr = o.fnStr;
        n.ICA = arg.ica;
        n.fs = fs;
        n.fs_orig = fs;
        n.fs_Pdio = subjVar.Pdio_rate;
        n.nChs = subjVar.nchan;
    end
end

% Make sure ICA status
if arg.ica || contains(o.suffix,"i")
    n.ICA = true;
else
    n.ICA = false;
end

% Add file strings
n.fnStr = o.fnStr;
n.suffix = o.suffix;
fs = n.fs;

% Figure out downsampling factor
if dsTarg>0; ds=floor(n.fs_orig/dsTarg); else; ds=1; end
if ds~=1; fs=dsTarg; disp(sbj+": downsampling task events...");
else; dsTarg=0; disp(sbj+": dsT <= 1, not downsampling..."); end
if fs==n.fs_orig; fs_s=""; else; fs_s=num2str(fs); end

%% chNfo
fn = o.dirOut+"chNfo_"+o.fnStr;
if ~isfile(fn) || arg.redoCh || arg.redo
    load(dirs.origSbj+"chNfo_"+sbj+".mat","chNfo");
    load(dirs.origSbj+"subjVar_"+sbj+".mat","subjVar");
    ch_bad = chNfo(:,1:2);
    ch_bad.bad(:) = false;
    ch_bad.gv(abs(subjVar.badChan)) = true;
    ch_bad.ref(abs(subjVar.refChan)) = true;
    ch_bad.empty(abs(subjVar.emptyChan)) = true;
    ch_bad.empty(contains(chNfo.fsLabel,"empty","IgnoreCase",true)) = true;
    ch_bad.sus(abs(subjVar.susChan)) = true;
    ch_bad.epi(abs(subjVar.epiChan)) = true;
    ch_bad.noisy(abs(subjVar.noisyChan)) = true;
    chNfo.bad = ch_bad(chNfo.ch,:);
elseif nargout > 3
    load(o.dirOut+"chNfo_"+o.fnStr, "chNfo");
end

%% Get task events
fn = o.dirOut+"trialNfo"+fs_s+"_"+o.fnStr;
if ~isfile(fn) || dsTarg>0 || arg.redoTr || arg.redoPsy || arg.redo
    [trialNfo,runIdx,runIdxOg,runTimes,runTimesOg,errorsEvent] =...
        ec_getEventIdx(sbj,proj,blocks,dirs,dsTarg=dsTarg);
    if nnz(~cellfun(@isempty,errorsEvent)); errors{end+1,1} = errorsEvent; end

    n.nFrames = runIdx(end,2);
    n.nRuns = length(unique(trialNfo.run));
    n.nTrials = height(trialNfo);
    n.runs = unique(trialNfo.run);
    n.runIdx = runIdx;
    n.runIdxOg = runIdxOg;
    n.runTimes = runTimes;
    n.runTimesOg = runTimesOg;
    n.blocks = blocks;
    times = (1:n.nFrames)'/fs;
elseif nargout > 4
    load(fn,"trialNfo");
end

%% Align task events & neural data
fn = o.dirOut+"psy"+fs_s+"_"+ o.fnStr;
if ~isfile(fn) || arg.redoPsy || arg.redoTr || arg.redo
    try
        [psy,trialNfo] = ec_alignNeuroBehav(trialNfo,sbj,n.runs,runIdx,times,fs,o);
    catch ME; warning(['psy ERROR: ' sbj]); getReport(ME)
        errors{end+1,1} = {lastwarn,ME};
        psy = [];
    end
elseif nargout > 5
    load(fn,"psy");
end

%% Finalize
n.fs = fs; % changed if downsampled
n.errorPsy = errors;

% Save to disk
if arg.save
    fn = o.dirOut+"chNfo_"+o.fnStr;
    if ~isfile(fn) || arg.redoCh || arg.redo
        save(fn,"chNfo","-v7"); disp("SAVED: "+fn)
    end

    fn = o.dirOut+"trialNfo"+fs_s+"_"+o.fnStr;
    if ~isfile(fn) || arg.redoTr || arg.redo
        save(fn,"trialNfo","-v7"); disp("SAVED: "+fn)
    end

    fn = o.dirOut+"psy"+fs_s+"_"+ o.fnStr;
    if ~isfile(fn) || arg.redoPsy || arg.redo
        save(fn,"psy","-v7.3"); disp("SAVED: "+fn)
    end

    fn = o.dirOut+"n"+o.suffix+"_"+o.fnStr;
    if ~isfile(fn) || arg.redoN || arg.redo
        save(fn,"n","-v7.3"); disp("SAVED: "+fn)
    end
end
disp([sbj ': finished trialNfo & psy']);