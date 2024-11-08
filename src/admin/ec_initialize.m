function [errors,o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,task,o,n,a)
% Check inputs
arguments
    sbj string
    proj string
    task string
    o struct = struct
    n struct = []
    a.dsTarg double = [] % Downsampling target freq
    a.ica logical = false 
    a.save logical = false
    a.redo logical = false
    a.redoN logical = false
    a.redoCh logical = false
    a.redoTr logical = false
    a.redoPsy logical = false
    a.dirs struct = []
    a.blocks string = BlockBySubj(sbj,task)
end
dirs=a.dirs; blocks=a.blocks; dsTarg=a.dsTarg;
if ~isstruct(dirs)||isempty(dirs); dirs = ec_getDirs(proj,task,sbj); end
if isempty(blocks); blocks=BlockBySubj(sbj,task); end
if ~isfield(o,'dirOut'); o.dirOut=dirs.procSbj; end % Output directory
if ~isfield(o,'fnStr');  o.fnStr="s"+dirs.sbjID+"_"+task; end % Filename ending string
if ~isfolder(o.dirOut); mkdir(o.dirOut); end
blocks = string(blocks);
errors={};
% arg.save=0; arg.redoCh=0; arg.redoTr=0; arg.redoPsy=1;

%% Initialize info struct
fn = o.dirOut+"n"+o.suffix+"_"+o.fnStr;
if ~a.ica || o.suffix=="i"
    fn_base = o.dirOut+"n_"+o.fnStr;
elseif a.ica || startsWith(o.suffix,"i")
    fn_base = o.dirOut+"ni_"+o.fnStr;
end
if isempty(n) || a.redo || a.redoN
    if isfile(fn) && ~a.redo && ~a.redoN
        load(fn,"n");
    elseif isfile(fn_base) && ~a.redo
        load(fn_base,"n");
    elseif ~isfile(fn_base) || a.redo
        % Load sbjNfo
        fn = dirs.origSbj+"sbjNfo_s"+dirs.sbjID+"_"+task+".mat";
        load(fn,"sbjNfo"); disp("LOADED: "+fn)

        n = struct; 
        n.sbj = sbj;
        n.sbjID = dirs.sbjID;
        n.proj = proj;
        n.task = task;
        n.suffix = o.suffix;
        n.fnStr = o.fnStr;
        n.ICA = a.ica;
        n.nChs = sbjNfo.nCh;
        n.nBlocks = numel(blocks);
        n.blocks = blocks;
        n.hz = sbjNfo.hz;
        n.hz_og = sbjNfo.hz;
        n.hz_Pdio = sbjNfo.hz_Pdio;
        n.nChPPT = sbjNfo.nChPPT;
        n.nChFS = sbjNfo.nChFS;
        n.fsNfo = sbjNfo.fsNfo;
        n.sbjNfo = sbjNfo.demographics;
        n.dirs = dirs;
    end
end

% Make sure ICA status
if a.ica || contains(o.suffix,"i")
    n.ICA = true;
else
    n.ICA = false;
end

% Add file strings
n.fnStr = o.fnStr;
n.suffix = o.suffix;
hz = n.hz;

% Figure out downsampling factor
if dsTarg>0; ds=floor(n.hz_og/dsTarg); else; ds=1; end
if ds~=1; hz=dsTarg; disp(sbj+": downsampling task events...");
else; dsTarg=0; disp(sbj+": dsT <= 1, not downsampling..."); end
if hz==n.hz_og; hz_s=""; else; hz_s=num2str(hz); end

%% chNfo
fn = o.dirOut+"chNfo_"+o.fnStr;
if ~isfile(fn) || a.redoCh || a.redo
    % Load chNfo
    fn = dirs.origSbj+"chNfo_s"+dirs.sbjID+"_"+task+".mat";
    load(fn,"chNfo"); disp("LOADED: "+fn)

    % Load marked chans
    tMarkCh = '/home/kt/Gdrive/UCLA/Studies/MMR/anal/preproc/subject_info_chan_fs_220627.xlsx';
    tMarkCh = readtable(tMarkCh);
    [refChan,badChan,epiChan,emptyChan,noisyChan,altBadChan] = GetMarkedChans_KT(sbj,tMarkCh);

    % Make ch_bad
    chBad = chNfo(:,["sbjCh" "sbjID" "ch"]);
    chBad.bad(:) = false;
    chBad.gv(abs(badChan)) = true;
    chBad.ref(abs(refChan)) = true;
    chBad.empty(abs(emptyChan)) = true;
    chBad.empty(contains(chNfo.fs,"empty","IgnoreCase",true)) = true;
    chBad.sus(abs(altBadChan)) = true;
    chBad.epi(abs(epiChan)) = true;
    chBad.noisy(abs(noisyChan)) = true;
    chNfo.bad = chBad(chNfo.ch,:);
elseif nargout > 3
    load(o.dirOut+"chNfo_"+o.fnStr, "chNfo");
end

%% Get task events
fn = o.dirOut+"trialNfo"+hz_s+"_"+o.fnStr;
if ~isfile(fn) || dsTarg>0 || a.redoTr || a.redoPsy || a.redo
    % Run
    [trialNfo,n,errorsEvent] = ec_getEventIdx(sbj,n,dsTarg);
    if nnz(~cellfun(@isempty,errorsEvent)); errors{end+1,1} = errorsEvent; end
elseif nargout > 4
    load(fn,"trialNfo");
end

%% Align task events & neural data
fn = o.dirOut+"psy"+hz_s+"_"+o.fnStr;
if ~isfile(fn) || a.redoPsy || a.redoTr || a.redo
    try
        times = (1:n.nFrames)'/hz;
        [psy,trialNfo] = ec_alignNeuroBehav(trialNfo,sbj,n.runs,n.runIdx,times,hz,o);
    catch ME; warning("psy ERROR: "+sbj); getReport(ME)
        errors{end+1,1} = ME;
        psy = [];
    end
elseif nargout > 5
    load(fn,"psy");
end

%% Finalize
n.hz = hz; % changed if downsampled
n.errorPsy = errors;
n.dirs = dirs;

% Save to disk
if a.save
    fn = o.dirOut+"chNfo_"+o.fnStr;
    if ~isfile(fn) || a.redoCh || a.redo
        save(fn,"chNfo","-v7"); disp("SAVED: "+fn)
    end

    fn = o.dirOut+"trialNfo"+hz_s+"_"+o.fnStr;
    if ~isfile(fn) || a.redoTr || a.redo
        save(fn,"trialNfo","-v7"); disp("SAVED: "+fn)
    end

    fn = o.dirOut+"psy"+hz_s+"_"+o.fnStr;
    if ~isfile(fn) || a.redoPsy || a.redo
        save(fn,"psy","-v7"); disp("SAVED: "+fn)
    end

    fn = o.dirOut+"n"+o.suffix+"_"+o.fnStr;
    if ~isfile(fn) || a.redoN || a.redo
        save(fn,"n","-v7"); disp("SAVED: "+fn)
    end
end
disp([sbj ': finished trialNfo & psy']);