function [EEG,changes] = ec_exportEEGLAB(n,x,psy,trialNfo,chNfo)
%%% Convert electroCUDA to EEGLAB format (continuous data)
arguments
    n struct = []
    x {mustBeFloat} = []
    psy timetable = []
    trialNfo table = []
    chNfo table = []
end
%if n.suffix==""; sfx1=""; else; sfx1="_"+n.suffix; end
sfx = n.suffix;

% Convert psy
psy = timetable2table(psy);
isDur = varfun(@isduration,psy,'OutputFormat','uniform');
psy = convertvars(psy,isDur,"seconds");

% Convert trialNfo
isDur = varfun(@isduration,trialNfo,'OutputFormat','uniform');
trialNfo = convertvars(trialNfo,isDur,"seconds");


%% Basic Info
EEG = struct;
EEG.subject = n.sbj;
EEG.sbjID = n.sbjID;
EEG.session = n.runs;
EEG.setname = char(n.fnStr);
EEG.filename = char("EEG"+sfx+"_"+EEG.setname+".set");
EEG.filepath = char(n.dirs.procSbj);
EEG.pnts = height(x);
EEG.nbchan = width(x);
EEG.srate = n.hz;
EEG.times = psy.Time'*1000;
EEG.idxPsy = psy.idx';
EEG.trials = 1; % 1 for continuous
EEG.history = {};
EEG.comments = 'Converted from electroCUDA';
if isfield(n,'refChs') && ~isempty(n.refChs)
    EEG.ref = 'average';
else
    EEG.ref = find(chNfo.bad.ref);
end


%% Channel info
EEG.chanlocs = table;
EEG.chanlocs.labels = cellstr(chNfo.sbjCh);
EEG.chanlocs.X = chNfo.pialRAS(:,1);
EEG.chanlocs.Y = chNfo.pialRAS(:,2);
EEG.chanlocs.Z = chNfo.pialRAS(:,3);
EEG.chanlocs.theta(:)=nan; EEG.chanlocs.radius(:)=nan;
EEG.chanlocs = table2struct(EEG.chanlocs);
EEG.chaninfo = [];
EEG.chNfo = chNfo;
EEG.splinefile = [];
EEG.urchanlocs = EEG.chanlocs;


%% Event info

% ITI
iti = ~isnan(trialNfo.iti);
ITI = table;
ITI.type(1:nnz(iti)) = "ITI";
ITI.latency = trialNfo.iti(iti);
ITI.duration = trialNfo.durITI(iti);
ITI.idxPsy = trialNfo.idxITI(iti);
ITI.cond = trialNfo.cond(iti);
ITI.run = trialNfo.run(iti);
ITI.trial = trialNfo.tr(iti);
ITI.trialRun = trialNfo.trial(iti);

% Stimulus
stim = table;
stim.type(1:height(trialNfo)) = "stim";
stim.latency = trialNfo.ons;
stim.duration = trialNfo.durStim;
stim.idxPsy = trialNfo.idxOns;
stim.cond = trialNfo.cond;
stim.run = trialNfo.run;
stim.trial = trialNfo.tr;
stim.trialRun = trialNfo.trial;

% RT
resp = trialNfo.resp=="true"; % trial with RTs
RT = table;
RT.type(1:nnz(resp)) = "RT";
RT.latency = trialNfo.off(resp);
RT.duration(:) = 0;
RT.idxPsy = trialNfo.idxOff(resp);
RT.cond = trialNfo.cond(resp);
RT.run = trialNfo.run(resp);
RT.trial = trialNfo.tr(resp);
RT.trialRun = trialNfo.trial(resp);

% Run boundaries
runs = table;
runs.type(1:n.nRuns) = "boundary";
runs.latency = seconds(n.runTimes(:,1));
runs.duration(:) = 0; % seconds(n.runTimesOg);
runs.idxPsy = n.runIdx(:,1);
runs.cond(:) = "";
runs.run = n.runs;
runs.trial(:) = 0;
runs.trialRun(:) = 0;

% Find discontinuities in psy
dt_expected = 1/n.hz; % expected time interval at sampling rate
tol = eps(max(psy.Time)); % tolerance
d = [0;diff(psy.Time)]; % successive time intervals
dID = d > (dt_expected + tol);

% Mark boundaries for discontinuities 
bdry = table;
bdry.type(1:nnz(dID)) = "boundary";
bdry.latency = psy.Time(dID);
bdry.duration(:) = d(dID);
bdry.idxPsy = psy.idx(dID);
bdry.cond(:) = "";
bdry.run = psy.run(dID);
bdry.trial = psy.tr(dID);
bdry.trialRun = psy.trial(dID);

% Concactenate & sort
EEG.event = [ITI;stim;RT;runs];
EEG.event.type = cellstr(EEG.event.type);
EEG.event = sortrows(EEG.event,"latency","ascend");
EEG.event{:,["latency" "duration"]} = round(EEG.event{:,["latency" "duration"]}*1000);
EEG.event.urevent = (1:height(EEG.event))';
EEG.event = table2struct(EEG.event);
EEG.urevent = EEG.event;

% Epoch info
EEG.xmin = psy.Time(1);
EEG.xmax = psy.Time(end);
%EEG.eventdescription = [];
%EEG.epoch = [];
%EEG.epochdescription = [];

%% EEG & ICA data
if n.ICA && isfield(n,"ica")
    EEG.data = [];
    EEG.icaweights = n.ica.wts;
    EEG.icasphere = n.ica.sph;
    EEG.icawinv = n.ica.winv;
    EEG.icaact = x';
    EEG.icachansind = n.chICA;
else
    EEG.data = x';
    EEG.icaweights = [];
    EEG.icasphere = [];
    EEG.icawinv = [];
    EEG.icaact = [];
end
EEG.specdata = [];
EEG.specicaact = [];
EEG.reject = struct;
EEG.stats = struct;
EEG.etc = struct;
EEG.saved = 'no';

%% Check dataset
try
    [EEG,changes{1}] = eeg_checkset(EEG); 
    [EEG,changes{2}] = eeg_checkset(EEG,'eventconsistency');
    [EEG,changes{3}] = eeg_checkset(EEG,'chanlocs_homogeneous');
    disp(changes);
catch ME; warning("Error in eeg_checkset, skipping..."); getReport(ME)
end
if isa(x,'double') && isa(EEG.data,'single')
    warning("ASR: x is double *but* EEG.data is single-precision"); end % ensure no converting to single







