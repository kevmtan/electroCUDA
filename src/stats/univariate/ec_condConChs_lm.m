function [o,stats] = ec_condConChs_lm(o)
% Performs timeseries statistics contrasting two task conditions within
% channels
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025

%% Input arguments
arguments
    o struct = struct % options struct (description below in "Options struct validation" section)
end
% o.test=1;


%% Prep
tt = tic;
if o.test; disp("[ec_condVsCondChs_lm] TESTING: "+o.dirs.sbj); end

% Options validation
o.nCons = numel(o.contrasts);
if isempty(o.cond0)
    o.cond0 = cell(1,o.nCons);
elseif isscalar(o.cond0)
    o.cond0 = repmat(o.cond0,1,o.nCons);
end

% Load
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(o.dirs,sfx=o.sfx,...
    vars=["n" "x" "psy" "trialNfo" "chNfo"],compact="n");
if o.test && numel(dbstack)<2; nOg=n; xOg=x; trialNfoOg=trialNfo; end %#ok<NASGU>

% Channels/ICs
if ~o.ICA
    sbjChs = chNfo.sbjCh; % chan names
    o.chBad = find(any(n.chBad{:,o.chBadFields},2)); % chans to include in stats
else
    sbjChs = n.icNfo.sbjIC; % IC names
    o.chBad = find(any(n.icBad{:,o.chBadFields},2)); % ICs to include in stats
end

% Remove bad chans/ICs
x(:,o.chBad,:) = [];
sbjChs(o.chBad,:) = [];


%% Analysis template

% Epoch psych/behav task data
oo = namedargs2cell(o.epoch);
[ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,tt,oo{:}); %#ok<ASGLU>
ep.Properties.RowNames = {};

% Rename time variable
ep = renamevars(ep,o.timeVar,"t");

% Remove excluded times
ep(ep.t<o.timeRng(1) | ep.t>o.timeRng(2),:) = [];
ep.ide = cast(1:height(ep),like=ep.ide)'; % new epoch indices


%% Analysis-specific EEG preprocessing
oo = namedargs2cell(o.pre);
[x,n] = ec_epochBaseline(x,n,psy,ep,tt,oo{:},test=o.test);
o.n = n;
o.spect = n.spect;


%% Run stats
stats = cell(size(sbjChs)); % preallocate results

% Parfor across chans
parfor ch = 1:width(x)
    %% run ch
    stats{ch} = withinCh_lfn(squeeze(x(:,ch,:)),sbjChs(ch),ep,n,o,tt);
end

% Organize
stats = vertcat(stats{:}); % concactenate results
stats.sbjID(:) = n.sbjID; % add subject number
stats.con = categorical(stats.con,o.contrasts); % categorize contrasts
stats = movevars(stats,["sbjID" "sbjCh"],Before="con");

% Add properties to results table (TODO: variable units)
stats = addprop(stats,"spect","table");
stats.Properties.CustomProperties.spect = o.spect;


%% Multiple comparisons correction (FDR)
stats.q = nan(height(stats),n.nSpect,o.typeOut); % preallocate

% Find rows within FDR timerange
if numel(o.fdrTimeRng)==2
    id = stats.(o.timeVar) >= o.fdrTimeRng(1) &...
        stats.(o.timeVar) <= o.fdrTimeRng(2);
end
if ~exist("id","var") || ~any(id)
    id = true(height(stats),1); end

% Run FDR per contrast
for con = o.contrasts(:)'
    idc = id & stats.con==con; % find rows for contrast
    stats.q(idc,:) = ec_fdr(stats.p(idc,:),o.alpha,o.fdrDep);
end

% Run FDR
stats = movevars(stats,"q",After="p"); % move
stats = convertvars(stats,"p",o.typeOut); % convert to output FP precision


%% Save
fn = o.dirOut+"s"+n.sbjID+"_stats.mat"; % filename
save(fn,"stats");
disp("[ec_condVsCond] Saved (time="+toc(tt)+"): "+fn);






%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%% Within-channel routines %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function statCh = withinCh_lfn(xCh,sbjCh,ep,n,o,tt)
% ch=104; xCh=squeeze(x(:,ch,:)); sbjCh=sbjChs(ch);

% Convert EEG data
xCh = cast(xCh,o.typeProc); % to specified precision
if o.gpu % to GPU
    xCh = gpuArray(xCh); end

statCh = cell(n.nConds,1); % Preallocate chan results

%% Loop across contrasts
for c = 1:o.nCons
    statCh{c} = contrast_lfn(xCh,ep,o,c); % Run contrast across times & freqs
end

%% Finalize
statCh = vertcat(statCh{:}); % concactenate contrasts
statCh = convertvars(statCh,@isgpuarray,@gather); % gather results from GPU
statCh = convertvars(statCh,["b" "SE" "t" "qc"],o.typeOut); % convert to specified FP precision
statCh.sbjCh(:) = sbjCh; % add channel name
disp("[ec_condVsCondChs_lm] Ran: "+sbjCh+" time="+toc(tt)); 






%%% Run model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sc = contrast_lfn(xCh,ep,o,c)
% Get info
con = o.contrasts(c); % contrast name
cond0 = o.cond0{c};
cond1 = o.cond1{c};
tVar = o.timeVar;
nFrq = o.n.nSpect;

% Epochs for conditions in contrast
epc = ep(ismember(ep.cond,[cond0 cond1]),["t" "cond" "ide"]);

% Create contrast regressor
epc.con(:) = false;
epc.con(ismember(epc.cond,cond1)) = true;

% Get time info
times = groupcounts(epc,["t" "con"],IncludeEmptyGroups=isany(cond0));
timeL = unique(times.t(times.GroupCount < o.minN)); % Times without enough samples
times = unique(times.t);
times(ismember(times,timeL)) = []; % exclude times with too small samples
nTimes = numel(times);

% Move to GPU
if o.gpu
    epc = convertvars(epc,@isNumOrLogical,@gpuArray);
    times=gpuArray(times); nTimes=gpuArray(nTimes); nFrq=nFrq(nFrq);
end

% Preallocate cond results
sc = table;
sc.con(1:nTimes) = con;
sc.(tVar) = times;
sc.b = nan(nTimes,nFrq,like=xCh);
sc.SE = nan(nTimes,nFrq,like=xCh);
sc.t = nan(nTimes,nFrq,like=xCh);
sc.p = nan(nTimes,nFrq,like=xCh);
sc.qc = nan(nTimes,nFrq,like=xCh);


%% Loop across times
for t = 1:nTimes
    time = times(t);
    ept = epc(epc.t==time,["ide" "con"]);

    %% Loop across spectral columns (freqs/bands/PCs)
    for f = 1:nFrq
        % Add EEG data to epoch table
        ept.x = xCh(ept.ide,f);

        % Run model
        lm = fitlm(ept,'x ~ con',RobustOpts=o.robust);

        %% Extract results
        sc.b(t,f) = lm.Coefficients.Estimate(end);
        sc.SE(t,f) = lm.Coefficients.SE(end);
        sc.t(t,f) = lm.Coefficients.tStat(end);
        sc.p(t,f) = lm.Coefficients.pValue(end);
    end
end


%% Within-channel FDR

% Find rows within FDR timerange
if numel(o.fdrTimeRng)==2
    id = sc.(tVar) >= o.fdrTimeRng(1) &...
        sc.(tVar) <= o.fdrTimeRng(2);
end
if ~exist("id","var") || ~any(id)
    id = true(height(sc),1); end

% Run FDR
sc.qc(id,:) = ec_fdr(sc.p(id,:),o.alpha,o.fdrDep);