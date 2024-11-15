function [errors,o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,task,o,n,a)
% Check inputs
arguments
    sbj string
    proj string
    task string
    o struct = struct
    n struct = []
    a.hzTarget double = [] % Downsampling target freq
    a.ica logical = false 
    a.save logical = false
    a.saveN logical = false
    a.redo logical = false
    a.redoN logical = false
    a.redoCh logical = false
    a.redoBeh logical = false
    a.dirs struct = []
    a.blocks string = BlockBySubj(sbj,task)
end
dirs=a.dirs; blocks=a.blocks; hzTarget=a.hzTarget;
if ~isstruct(dirs)||isempty(dirs); dirs = ec_getDirs(proj,task,sbj); end
if isempty(blocks); blocks=BlockBySubj(sbj,task); end
if ~isfield(o,'suffix'); o.suffix=""; end
if ~isfield(o,'dirOut'); o.dirOut=dirs.procSbj; end % Output directory
if ~isfield(o,'fnStr');  o.fnStr="s"+dirs.sbjID+"_"+task; end % Filename ending string
if ~isfolder(o.dirOut); mkdir(o.dirOut); end
blocks = string(blocks);
errors={};
% arg.save=0; arg.redoCh=0; arg.redoTr=0; arg.redoPsy=1;

%% Initialize info struct
fn = o.dirOut+"n"+o.suffix+"_"+o.fnStr+".mat";
if ~a.ica || o.suffix=="i"
    fn_base = o.dirOut+"n_"+o.fnStr+".mat";
elseif a.ica || startsWith(o.suffix,"i")
    fn_base = o.dirOut+"ni_"+o.fnStr+".mat";
end
if isempty(n) || a.redo || a.redoN
    if isfile(fn) && ~a.redo && ~a.redoN
        load(fn,"n"); disp("LOADED: "+fn);
    elseif isfile(fn_base) && ~a.redo
        load(fn_base,"n"); disp("LOADED: "+fn);
    elseif ~isfile(fn_base) || a.redo
        % Load sbjNfo
        fn = dirs.origSbj+"sbjNfo_s"+dirs.sbjID+"_"+task+".mat";
        load(fn,"sbjNfo"); disp("LOADED: "+fn);

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
if hzTarget>0; ds=floor(n.hz_og/hzTarget); else; ds=1; end
if ds~=1; hz=hzTarget; disp(sbj+": resampling task events @ "+hzTarget+"hz");
else; hzTarget=0; disp(sbj+": keeping task events @ "+n.hz_og+"hz"); end
if hz==n.hz_og; hz_s=""; else; hz_s=num2str(hz); end

%% EEG channel info
fn = o.dirOut+"chNfo_"+o.fnStr+".mat";
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
    load(fn,"chNfo"); disp("LOADED: "+fn)
end


%% Get behavioral data & align with neural data (trialNfo & psy)
fn = o.dirOut+"trialNfo"+hz_s+"_"+o.fnStr+".mat";
fn2 = o.dirOut+"psy"+hz_s+"_"+o.fnStr+".mat";
psy=[]; trialNfo=[];

% Do trialNfo & psy
if ~isfile(fn) || ~isfile(fn2) || hzTarget>0 || a.redoBeh || a.redo
    % Make trialNfo & psy
    [psy,trialNfo] = ec_concatRunsBehav_MMR(sbj,task,proj,hzTarget=hzTarget);
    disp(sbj+": made trialNfo & psy");
else
    % Load trialNfo & psy
    if nargout>4; load(fn,"trialNfo"); load(fn2,"psy");
        disp("LOADED: "+fn); disp("LOADED: "+fn2); end
end

% Save info to n
if ~isempty(psy) && ~isempty(trialNfo)
    n.nFrames = height(psy);
    n.nRuns = numel(unique(trialNfo.run));
    n.nTrials = height(trialNfo);
    n.runs = unique(trialNfo.run);
    n.runIdx = nan(n.nRuns,2);
    n.runIdxOg = nan(n.nRuns,1);
    n.runTimes = seconds(nan(n.nRuns,2));
    n.runTimesOg = seconds(nan(n.nRuns,1));
    for r = 1:n.nRuns
        run = n.runs(r);
        idx = psy.idx(psy.run==run);
        n.runIdx(r,:) = [min(idx) max(idx)];
        n.runIdxOg(r) = psy.idr(max(idx));
        n.runTimes(r,:) = [psy.Time(min(idx)) psy.Time(max(idx))];
        n.runTimesOg(r) = psy.timeR(max(idx));
    end
    n.conds = unique(trialNfo.cond);
    disp(sbj+": updated 'n"+o.suffix+"' with info from 'trialNfo' & 'psy'");
end


%% Finalize
n.hz = hz; % changed if downsampled
n.errorPsy = errors;
n.dirs = dirs;

% Save to disk
if a.save || a.saveN
    fn = o.dirOut+"chNfo_"+o.fnStr+".mat";
    if ~isfile(fn) || a.redoCh || a.redo
        save(fn,"chNfo","-v7"); disp("SAVED: "+fn)
    end

    fn = o.dirOut+"trialNfo"+hz_s+"_"+o.fnStr+".mat";
    if ~isfile(fn) || a.redoBeh || a.redo
        save(fn,"trialNfo","-v7"); disp("SAVED: "+fn)
    end

    fn = o.dirOut+"psy"+hz_s+"_"+o.fnStr+".mat";
    if ~isfile(fn) || a.redoBeh || a.redo
        save(fn,"psy","-v7"); disp("SAVED: "+fn)
    end

    fn = o.dirOut+"n"+o.suffix+"_"+o.fnStr+".mat";
    if ~isfile(fn) || a.redoN || a.redo || a.saveN
        save(fn,"n","-v7"); disp("SAVED: "+fn)
    end
end