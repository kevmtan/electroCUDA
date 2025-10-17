function o = ec_classifyChSpec_HMM(sbj,proj,task,o,a)
arguments
    sbj string
    proj string
    task string
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    a.plot logical = false
end
if o.test
    disp("TESTING sumStats: "+sbj);
    dbstop if error
end
% a.plot=0; o.test=1;
%% Load
tic;
[n,x,psy,trialNfo,chNfo,dirs] =...
    ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=o.sfx,vars=["n" "x" "psy" "trialNfo" "chNfo" "dirs"]);
x = single(x);
if o.test; x1=x; trialNfoOg=trialNfo; x_bad=n.xBad; end %#ok<NASGU>
toc;

%% Initialize
sbj = n.sbj;
sbjID = n.sbjID;
conds = o.conds;
sbjChs = chNfo.sbjCh;
nChs = n.xChs;
nTrs = n.nTrials;
nBands = numel(o.bands);
if o.ICA
    nChs = n.nICs;
    icNfo = n.icNfo;
    sbjChs = icNfo.sbjIC;
end

% Target sampling rate
if ~isany(o.pre.hzTarget) || n.hz<o.pre.hzTarget
    o.pre.hzTarget = n.hz;
end

% Band indices
B = table;
B.name = o.bands';
B.disp = o.bands2';
B.freqs(:) = {[]};
for i = 1:nBands
    B.id(i,:) = (n.freqs>o.bandsF(i,1) & n.freqs<=o.bandsF(i,2))';
    B.freqs{i} = n.freqs(B.id(i,:));
end
B.Properties.RowNames = B.name;

%% Get mean evoked magnitude per freq & cond
fAvg = nan(numel(conds),nChs,numel(n.freqs),"like",x);
for c = 1:numel(conds)
    id = psy.stim & psy.cond==conds(c);
    fAvg(c,:,:) = mean(x(id,:,:),1,"omitnan");
end
disp("Calculated mean evoked magnitude per freq & cond: "+sbj); toc;

%% Analysis template
oo = namedargs2cell(o.epoch);
[ep,trialNfo] = ec_epochPsy(psy,trialNfo,n,oo{:},conds=o.conds,conds2=o.conds2); toc

%% Preprocessing: baseline correction, filtering, downsampling
oo = namedargs2cell(o.pre);
x = ec_epochBaseline(x,n,psy,ep,oo{:}); toc % ADD DOWNSAMPLING

