function [EEG,eeg_changes] = ec_exportEEGLAB(dirs,n,x,psy,trialNfo,chNfo)
arguments
    dirs struct
    n struct = []
    x {mustBeFloat} = []
    psy table = []
    trialNfo table = []
    chNfo table = []
end
%if n.suffix==""; sfx1=""; else; sfx1="_"+n.suffix; end
sfx = n.suffix;


%% Basic Info
EEG = struct;
EEG.subject = n.sbj;
EEG.sbjID = n.sbjID;
EEG.session = n.runs;
EEG.setname = char(n.fnStr);
EEG.filename = char("EEG"+sfx+"_"+EEG.setname+".set");
EEG.filepath = char(dirs.robustSbj);
EEG.pnts = height(x);
EEG.nbchan = width(x);
EEG.srate = n.fs;
EEG.times = round(psy.time*1000);
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
stim = table;

% Stimulus
stim.type(1:height(trialNfo)) = "stim";
stim.latency = psy.time(trialNfo.idxStim);
stim.duration = trialNfo.durTrial;
stim.idxPsy = trialNfo.idxStim;
stim.cond = trialNfo.cond;
stim.run = trialNfo.run;
stim.trial = trialNfo.trialA;
stim.trialRun = trialNfo.trial;

% RT
RT = stim;
RT.type(:) = "RT";
RT.latency = psy.time(trialNfo.idxRT);
RT.duration(:) = 0;
RT.idxPsy = trialNfo.idxRT;

% Run boundaries
runs = table;
runs.type(1:n.nRuns) = "boundary";
runs.latency = psy.time(n.runIdx(:,1));
runs.duration = n.runTimesOg(:,2);
runs.idxPsy = n.runIdx(:,1);
runs.cond(:) = "";
runs.run = n.runs;
runs.trial(:) = 0;
runs.trialRun(:) = 0;

% Concactenate & sort
EEG.event = [stim;RT;runs];
EEG.event.type = cellstr(EEG.event.type);
EEG.event = sortrows(EEG.event,"latency","ascend");
EEG.event{:,["latency" "duration"]} = round(EEG.event{:,["latency" "duration"]}*1000);
EEG.event.urevent = (1:height(EEG.event))';
EEG.event = table2struct(EEG.event);
EEG.urevent = EEG.event;

% Epoch info
EEG.xmin = 0;
EEG.xmax = 0;
%EEG.eventdescription = [];
%EEG.epoch = [];
%EEG.epochdescription = [];

%% EEG & ICA data
if n.ICA
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
    [EEG,eeg_changes] = eeg_checkset(EEG);
    disp(eeg_changes);
catch ME
    getReport(ME)
    warning("Error in eeg_checkset, skipping...")
end







