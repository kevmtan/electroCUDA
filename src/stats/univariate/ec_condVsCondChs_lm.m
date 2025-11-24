function [o,stats] = ec_condVsCondChs_lm(o)
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
o.nCons = numel(o.stats.contrasts);
if isempty(o.stats.cond0)
    o.stats.cond0 = cell(1,o.nCons);
elseif isscalar(o.stats.cond0)
    o.stats.cond0 = repmat(o.stats.cond0,1,o.nCons);
end

% Load
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(o.dirs,sfx=o.sfx,...
    vars=["n" "x" "psy" "trialNfo" "chNfo"],compact="n");
if o.test && isempty(dbstack); nOg=n; xOg=x; trialNfoOg=trialNfo; end %#ok<NASGU>
toc(tt);

% Channels/ICs
if ~o.ICA
    sbjChs = chNfo.sbjCh; % chan names
    chBad = find(any(n.chBad{:,o.chBadFields},2)); % chans to include in stats
else
    sbjChs = n.icNfo.sbjIC; % IC names
    chBad = find(any(n.icBad{:,o.chBadFields},2)); % ICs to include in stats
end

% Preallocate results
stats = cell(size(sbjChs)); % Trial-averaged results 


%% Analysis template

% Epoch psych/behav task data
oo = namedargs2cell(o.epoch);
[ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,oo{:}); toc(tt); %#ok<ASGLU>
ep.Properties.RowNames = {};

% Rename time variable
ep = renamevars(ep,o.stats.timeVar,"t");

% Remove excluded times
ep(ep.t<o.stats.timeRng(1) | ep.t>o.stats.timeRng(2),:) = [];
ep.ide = uint32(1:height(ep))'; % new epoch indices


%% Analysis-specific EEG preprocessing
oo = namedargs2cell(o.pre);
[x,n] = ec_epochBaseline(x,n,psy,ep,oo{:},test=o.test); toc(tt);
o.n = n;
o.spect = n.spect;


%% Run stats per channel
parfor ch = 1:n.xChs
    %%
    stats{ch} = withinCh_lfn(squeeze(x(:,ch,:)),sbjChs(ch),ep,n,o,tt);
end


%% Multiple comparisons correction (FDR-BY)
stats = vertcat(stats{:}); % concactenate results
stats.q = nan(height(stats),n.nSpect,o.stats.typeOut);

% Find rows within FDR timerange
if numel(o.stats.fdrTimeRng)==2
    id = stats.(o.stats.timeVar) >= o.stats.fdrTimeRng(1) &...
        stats.(o.stats.timeVar) <= o.stats.fdrTimeRng(2);
end
if ~exist("id","var") && ~any(id)
    id = true(height(stats),1); end

% Run FDR
stats.q(id,:) = ec_fdr(stats.p(id,:),o.stats.alpha);
stats = movevars(stats,"q",After="p"); % move
stats = convertvars(stats,"p",o.stats.typeOut); % convert to output FP precision

%% Finalize
stats.sbjID(:) = n.sbjID; % add subject number
stats.con = categorical(stats.con,o.stats.contrasts); % categorize contrasts
stats = movevars(stats,["sbjID" "sbjCh"],Before="con");

% Add properties to results table (TODO: variable units)
stats = addprop(stats,"spect","table");
stats.Properties.CustomProperties.spect = o.spect;

% Save
fn = o.dirOut+"s"+n.sbjID+"_stats.mat";
save(fn,"stats");
disp("[ec_condVsCond] Saved (time="+toc(tt)+"): "+fn);






%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%% Within-channel routines %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function statCh = withinCh_lfn(xCh,sbjCh,ep,n,o,tt)
% ch=104; xCh=squeeze(x(:,ch,:)); sbjCh=sbjChs(ch);

% Convert EEG data
xCh = cast(xCh,o.stats.typeProc); % to specified precision
if o.stats.gpu % to GPU
    xCh = gpuArray(xCh); end

statCh = cell(n.nConds,1); % Preallocate chan results

%% Loop across contrasts
for c = 1:o.nCons
    statCh{c} = contrast_lfn(xCh,ep,o,c); % Run contrast across times & freqs
end

%% Finalize
statCh = vertcat(statCh{:}); % concactenate contrasts
statCh = convertvars(statCh,@isgpuarray,@gather); % gather results from GPU
statCh = convertvars(statCh,["b" "SE" "t" "qc"],o.stats.typeOut); % convert to specified FP precision
statCh.sbjCh(:) = sbjCh; % add channel name
disp("[ec_condVsCondChs_lm] Ran: "+sbjCh+" time="+toc(tt)); 






%%% Run model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sc = contrast_lfn(xCh,ep,o,c)
% Get info
con = o.stats.contrasts(c); % contrast name
cond0 = o.stats.cond0{c};
cond1 = o.stats.cond1{c};
tVar = o.stats.timeVar;
nFrq = o.n.nSpect;

% Epochs for conditions in contrast
epc = ep(ismember(ep.cond,[cond0 cond1]),["t" "cond" "ide"]);

% Create contrast regressor
epc.con(:) = false;
epc.con(ismember(epc.cond,cond1)) = true;

% Get time info
times = groupcounts(epc,["t" "con"],IncludeEmptyGroups=isany(cond0));
timeL = unique(times.t(times.GroupCount < o.stats.minN)); % Times without enough samples
times = unique(times.t);
times(ismember(times,timeL)) = []; % exclude times with too small samples
nTimes = numel(times);

% Move to GPU
if o.stats.gpu
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
        lm = fitlm(ept,'x ~ con',RobustOpts=o.stats.robust);

        %% Extract results
        sc.b(t,f) = lm.Coefficients.Estimate(end);
        sc.SE(t,f) = lm.Coefficients.SE(end);
        sc.t(t,f) = lm.Coefficients.tStat(end);
        sc.p(t,f) = lm.Coefficients.pValue(end);
    end
end


%% Within-contrast FDR

% Find rows within FDR timerange
if numel(o.stats.fdrTimeRng)==2
    id = sc.(tVar)>=o.stats.fdrTimeRng(1) & sc.(tVar)<=o.stats.fdrTimeRng(2);
else
    id = true(height(sc),1,like=ept.con);
end

% Run FDR
sc.qc(id,:) = ec_fdr(sc.p(id,:),o.stats.alpha);