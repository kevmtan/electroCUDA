function o = ec_stimVsBaseline_lme(n,o)
arguments
    n struct
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
end
if o.test
    disp("TESTING sumStats: "+sbj);
    dbstop if error
end
if o.ICA; o.sfx = "i"+o.sfx; end
% a.plot=0; o.test=1;


%% Load
tic;
[x,psy,trialNfo,chNfo] = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=o.sfx,...
    vars=["x" "psy" "trialNfo" "chNfo"]);
xs = single(xs);
if o.test; xs1=xs; trialNfoOg=trialNfo; x_bad=ns.xBad; end %#ok<NASGU>
toc;


%% Initialize
sbj = ns.sbj;
sbjID = ns.sbjID;
conds = o.conds;
sbjChs = chNfo.sbjCh;
nChs = ns.xChs;
nTrs = ns.nTrials;
nBands = numel(o.bands);
if o.ICA
    nChs = ns.nICs;
    icNfo = ns.icNfo;
    sbjChs = icNfo.sbjIC;
end
% Target sampling rate
if ~isany(o.pre.hzTarget) || ns.hz<o.pre.hzTarget
    o.pre.hzTarget = ns.hz;
end

% Band indices
B = table;
B.name = o.bands';
B.disp = o.bands2';
B.freqs(:) = {[]};
for i = 1:nBands
    B.id(i,:) = (ns.freqs>o.bandsF(i,1) & ns.freqs<=o.bandsF(i,2))';
    B.freqs{i} = ns.freqs(B.id(i,:));
end
B.Properties.RowNames = B.name;


%% Get mean evoked magnitude per freq & cond
fAvg = nan(numel(conds),nChs,numel(ns.freqs),"like",xs);
for c = 1:numel(conds)
    id = psy.stim & psy.cond==conds(c);
    fAvg(c,:,:) = mean(xs(id,:,:),1,"omitnan");
end
disp("Calculated mean evoked magnitude per freq & cond: "+sbj); toc;

%% Analysis template
oo = namedargs2cell(o.epoch);
[ep,trialNfo] = ec_epochPsy(psy,trialNfo,ns,oo{:},conds=o.conds,conds2=o.conds2); toc

%% Preprocessing: baseline correction, filtering, downsampling
oo = namedargs2cell(o.pre);
xs = ec_epochBaseline(xs,ns,psy,ep,oo{:}); toc % ADD DOWNSAMPLING