function [ep,trialNfo,n,psy] = ec_epochPsy(psy,trialNfo,n,tt,o)
% ec_epochPsy - Generate epochs of a recording from psychobehavioral metadata
arguments
    psy timetable % Psychobehavioral table
    trialNfo table % Trial table
    n struct % Recording info struct
    tt (1,1) uint64 = tic % Timer
    % Target sampling rate (0=skip)
    o.hzTarget (1,1) double = 0
    % Floating-point precision for epoch/trialNfo variables [half|single|double]
    o.float (1,1){mustBeMember(o.float,["double" "single" "half" []])} = []
    % Variables to remove from epoch table
    o.rmVars = ["Time" "onHz" "photodiode" "trial" "timeR" "noPdio"];
    % Bad trial removal
    o.rmTrials {isNumOrLogical} = []; % Trials to remove (numeric array or logical index)
    o.rmTrialsFun = {} % Function handle for removing trials (using trialNfo vars)
    o.badTrialVars (1,:) string = ""; % Bad trial variables in trialNfo
    % Epoch time limits (secs) [nan=variable, 0=none]
    o.pre (1,1) double = nan  % Duration before stim onset [nan = pre-stim ITI]
    o.post (1,1) double = nan % Duration after stim offset [nan = post-stim ITI]
    o.dur (1,1) double = nan  % Duration after stim onset, supercedes 'post' [nan = no limit]
    % Epoch baseline period for subsequent processing
    %   (none=[], all pre/post times=inf, relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
    o.baselinePre {mustBeFloat} = [] % Pre-stimulus baseline (secs from stim onset): inf=ITI; [-.2]; [-0.2 1]
    o.baselinePost {mustBeFloat} = [] % Post-stimulus baseline (secs from stim offset): inf=ITI; [.2]; [0.1 0.3]
    % Epoch time bins (secs)
    o.bin (1,1) double = 1/n.hz  % Latency bin width (secs)
    o.binPct (1,1) double = 1 % Latency percent bin width (<=100)
    % Task conditions
    o.conds string = string(unique(psy.cond)) % List of condition names (order by desired categorical order)
    o.conds2 string = ""                      % List of custom condition names (ordered like 'oe.conds')   
end


%% Prep

% Convert timing arguments to seconds (duration class)
o.pre=seconds(abs(o.pre)); o.post=seconds(abs(o.post)); o.dur=seconds(abs(o.dur));

% Only use badTrialVars present in trialNfo
o.badTrialVars = o.badTrialVars(ismember(o.badTrialVars,... % bad trial vars
    trialNfo.Properties.VariableNames));

% Confirm vars to remove from epoch table exist in psy
o.rmVars = o.rmVars(ismember(o.rmVars,psy.Properties.VariableNames));

% Resample to target sampling rate
n.hz0 = n.hz; % save for ec_epochPreproc
if any(o.hzTarget) && o.hzTarget~=n.hz0
    [psy,trialNfo,n] = ec_loadSbj(n.dirs,hz=o.hzTarget,vars=["psy" "trialNfo" "n"]);
    disp("[ec_epochPsy] Resampled psychobehavioral data: "+o.hzTarget+"hz");
end

% Convert float vars from half to single for threadpool
psy = convertvars(psy,varfun(@class,psy,OutputFormat="cell")=="half","single");
trialNfo = convertvars(trialNfo,...
    varfun(@class,trialNfo,OutputFormat="cell")=="half","single");


%% Generate epochs
trs = height(trialNfo);
idxOns = trialNfo.idxOns;

% Preallocate epoch cell (proto-table)
ep = cell(trs,1);

% Generate epochs (parfor across trials)
parfor t = 1:trs
    [ep{t},trialNfo(t,:)] = makeEpoch_lfn(trialNfo(t,:),psy,trs,idxOns,t,n,o);
end

% Concactenate epochs
ep = vertcat(ep{:});


%% Bad trials
trialNfo.removed(:) = false;

% Specified trials numbers to remove
if isany(o.rmTrials)
    if islogical(o.rmTrials) % Logical index
        if length(o.rmTrials)==trs
            trialNfo.removed(o.rmTrials) = true;
        else
            error("[ec_epochPsy] rmTrials input must match height of trialNfo: "+n.sbj);
        end
    elseif isnumeric(o.rmTrials) % Array of trial numbers
        trialNfo.removed = ismember(trialNfo.tr,o.rmTrials);
    end
end

% Remove trials by user-defined function handle
if ~isempty(o.rmTrialsFun)
    trialNfo.removed = o.rmTrialsFun(trialNfo) | trialNfo.removed;
end

% User-selected badTrialVars
for v = o.badTrialVars
    trialNfo.removed = trialNfo.(v) | trialNfo.removed; 
end

% Remove bad trials from epoch table
if any(trialNfo.removed)
    rmTrials = trialNfo.tr(trialNfo.removed);
    ep = ep(~ismember(ep.tr,rmTrials),:);
end
n.nTrs = nnz(~trialNfo.removed); % number of remaining trials
disp("[ec_epochPsy] kept "+n.nTrs+"/"+n.nTrials+" trials: "+n.sbj);


%% Finalize

% Label pre-stimulus baseline frames
if abs(o.baselinePre) == inf
    % Baseline = pre-stimulus period
    ep.BLpre = ep.pre > 0;
elseif isany(o.baselinePre)
    if isscalar(o.baselinePre)
        % User-defined baseline period duration (within pre-stimulus period)
        ep.BLpre = ep.latency>=-abs(o.baselinePre) & ep.pre;
    elseif numel(o.baselinePre) == 2
        % User-defined baseline period range (can include entire epoch)
        ep.BLpre = ep.latency>=o.baselinePre(1) & ep.latency<=o.baselinePre(2);
    end
else
    ep.BLpre(:) = false;
end

% Label post-stimulus baseline frames
if o.baselinePost == inf
    ep.BLpost = ep.post > 0; % ITI any trial
elseif isany(o.baselinePost)
    if isscalar(o.baselinePost)
        ep.BLpost = ep.latRT<=o.baselinePost & ep.post;
    elseif numel(o.baselinePost) == 2
        ep.BLpost = ep.latRT>=o.baselinePost(1) & ep.latRT<=o.baselinePost(2);
    end
else
    ep.BLpost(:) = false;
end

% Task condition categorical order
ep.cond = categorical(ep.cond,o.conds);
trialNfo.cond = categorical(trialNfo.cond,o.conds);
if isany(o.conds2)
    ep.cond = renamecats(ep.cond,o.conds,o.conds2);
    trialNfo.cond = renamecats(trialNfo.cond,o.conds,o.conds2);
end

% Bin timings
ep.frame = round(ep.latency*n.hz); % frame within trial
ep.bin = ep.latency/o.bin;
ep.bin = round(ep.bin+eps(ep.bin)) * o.bin * 1000;
ep.binRT = ep.latRT/o.bin;
ep.binRT = round(ep.binRT+eps(ep.binRT)) * o.bin * 1000;
ep.binPct = ep.pct/o.binPct;
ep.binPct = round(ep.binPct+eps(ep.binPct)) * o.binPct;

% Convert vars
if isany(o.float)
    ep = convertvars(ep,varfun(@isfloat,ep,"OutputFormat","uniform"),o.float);
    trialNfo = convertvars(trialNfo,varfun(@isfloat,trialNfo,"OutputFormat","uniform"),o.float);
end
ep = convertvars(ep,"frame","int32");

% Remove vars
ep(:,["Time" "onHz" "photodiode" "trial" "timeR" "noPdio"]) = [];

% Reorder vars
ep = movevars(ep,["frame" "latency" "bin" "pct" "binPct" "latRT" "binRT"],...
    "After","cond");
ep = movevars(ep,["BLpre" "BLpost"],"After","post");

% New indices
ep.ide = uint32(1:height(ep))';

% Row names
ep.Properties.RowNames = string(ep.frame)+"_tr"+ep.tr+"_"+string(ep.cond);

% Save conditions
n.conds = string(categories(trialNfo.cond));
n.nConds = numel(n.conds);
disp("[ec_epochPsy] Epoched psychobehavioral metadata: "+n.sbj+" time="+toc(tt));








function [e,tNfo] = makeEpoch_lfn(tNfo,psy,trs,idxOns,t,n,o)
%%% Generate epoch %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t=5; tNfo=trialNfo(t,:);

%% Prep
tr = tNfo.tr;
cond = tNfo.cond;


%% Pre-stimulus period (ITI or user-defined)
if o.pre~=0
    % Calculate onset time of pre-stimulus period
    if ~isnan(o.pre)
        % User-defined pre-stimulus period subtracted from stim onset
        tNfo.iti = tNfo.ons - o.pre;
    elseif n.task=="MMR" && cond=="Rest"
        tNfo.iti = tNfo.ons - seconds(0.3);
    end

    % Extract pre-stim frames (ITI oset to stimulus onset)
    pre = psy(timerange(tNfo.iti,tNfo.ons),:);

    % Fill metadata
    pre.pre(:)=tr; pre.stim(:)=0; pre.post(:)=0;
    tNfo.durITI = range(pre.Time);
    tNfo.idxITI = pre.idx(1);
else
    pre = []; % no pre-stimulus period
end


%% Peri-stimulus period
if n.task=="MMR" && cond=="Rest" && t<trs
    % MMR rest peri-stimulus period extended to include ITI of next trial
    tNfo.idxOff = idxOns(t+1) - 1;
    tNfo.off = psy.Time(tNfo.idxOff);
    % Extract frames
    peri = psy(timerange(tNfo.ons,tNfo.off,"closed"),:);
    tNfo.durStim = range(peri.Time); % save peri-stimulus duration to trialNfo
else
    % Peri-timulus period as defined by makeTrialNfo (e.g., stimulus is active)
    peri = psy(psy.stim==tr,:);
end

% Fill metadata
peri.pre(:)=0; peri.stim(:)=tr; peri.post(:)=0;


%% Post-stimulus frames
if o.post~=0 || tNfo.durStim<o.dur
    % Extract post-stimulus frames
    if tNfo.durStim < o.dur
        % Peri-stimulus duration under user-specified duration
        addDur = o.dur - tNfo.durStim; % time to add after stimulus onset
        post = psy(timerange(tNfo.off,tNfo.off+addDur,"openleft"),:);
    elseif o.post > 0
        % User-specified post-stimulus period added after stim offset
        post = psy(timerange(tNfo.off,tNfo.off+o.post,"openleft"),:);
    elseif n.task=="MMR" && cond=="Rest"
        % MMR rest post-stimulus includes stim of next tiral
        post = psy(timerange(tNfo.off,tNfo.off+seconds(0.3),"openleft"),:);
    else
        % Post-stimulus period as defined by makeTrialNfo
        post = psy(psy.post==tr,:);
    end

    % Fill metadata
    post.pre(:)=0; post.stim(:)=0; post.post(:)=tr;
else
    post = []; % no post-stimulus period
end


%% Finalize

% Concatenate pre, peri & post frames
e = timetable2table([pre;peri;post]);
iPre = e.pre==tr;
iStim = e.stim==tr;
iPost = e.post==tr;

% Latency
e.latency = seconds(e.Time - tNfo.ons); % relative to stimulus
e.latRT = seconds(e.Time - tNfo.off); % relative to RT
e.latency = round(e.latency*n.hz)/n.hz;
e.latRT = round(e.latRT*n.hz)/n.hz;

% Latency percentage
e.pct(iPre) = normalize(e.latency(iPre),"range",[-10 0-eps(0)]);
e.pct(iStim) = normalize(e.latency(iStim),"range",[0 100]);
e.pct(iPost) = normalize(e.latency(iPost),"range",[100+eps(100) 110]);

% REMOVE frames over max latency ('max' argument)
if ~isnan(o.dur)
    e = e(e.latency <= seconds(o.dur),:);
    iStim = e.stim==tr;
    tNfo.off = max(e.Time(iStim));
    tNfo.idxOff = max(e.idx(iStim));
    tNfo.durStim = range(e.Time(iStim));
end
tNfo.durTrial = range(e.Time);

% Trial metadata
e.tr(:) = tr;
e.cond(:) = cond;
e.run(:) = tNfo.run;
e.trial(:) = tNfo.trial;
e.RT(:) = tNfo.RT;
e.valence(:) = tNfo.valence;
e.resp(:) = tNfo.resp;
e.noPdio(:) = tNfo.noPdio;

