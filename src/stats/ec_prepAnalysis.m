function [x,ep,n,o,trialNfo] = ec_prepAnalysis(o,tt)
% ec_prepAnalysis: prep subject data for further analyses in electroCUDA

%% Load data 
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(o.dirs,sfx=o.sfx,...
    vars=["n" "x" "psy" "trialNfo" "chNfo"],compact="n");
if numel(dbstack)<2; nOg=n; xOg=x; trialNfoOg=trialNfo; end %#ok<NASGU> % Copy origs for testing
disp("[ec_classifyChSpec] Loaded data: "+o.dirs.sbj+" | toc="+toc(tt));

%% Channels

% Channel/IC info
if o.ICA
    n.chNfo = n.icNfo;
    n.chNfo = renamevars(n.chNfo,["ic" "sbjIC"],["ch" "sbjCh"]);
    chBad = any(n.icBad{:,o.chBadFields},2); % ICs to include in stats
else
    n.chNfo = chNfo;
    chBad = any(n.chBad{:,o.chBadFields},2); % chans to include in stats
end

% Remove bad chans/ICs
x(:,chBad,:) = [];
n.chNfo(chBad,:) = [];

% Remove specified chans
chRm = ismember(o.chRm,n.chNfo.ch);
x(:,chRm,:) = [];
n.chNfo(chRm,:) = [];


%% Behavioral / recording metadata

% Epoch psych/behav task data
oo = namedargs2cell(o.epoch);
[ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,tt,oo{:});

% Rename target time & condition variables
ep = renamevars(ep,[o.timeVar o.condVar],["t" "cnd"]);

% Remove excluded times
if numel(o.timeRng)==2
    ep(ep.t<o.timeRng(1) | ep.t>o.timeRng(2),:) = []; end

% Remove excluded conditions
if isfield(o,"cond1")
    ep(~ismember(ep.cnd,[o.cond1 o.cond0]),:) = [];
elseif isfield(o,"cond")
    ep(~ismember(ep.cnd,[o.cond o.condx]),:) = [];
elseif isfield(o,"conds")
    ep(~ismember(ep.cnd,o.conds),:) = [];
end
ep.ide = cast(1:height(ep),like=ep.ide)'; % update epoch indices


%% Analysis-specific EEG preprocessing
oo = namedargs2cell(o.pre);
[x,n] = ec_epochBaseline(x,n,psy,ep,tt,oo{:},test=o.test);
o.n = n;
o.spect = n.spect;