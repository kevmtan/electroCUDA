function [ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,tt,o)
arguments
    psy timetable
    trialNfo table
    n struct
    tt (1,1) uint64 = tic
    % Bad trial removal
    o.rmTrials {islogical,isnumeric} = []; % Trials to remove (numeric array or logical index)
    o.rmTrialsFun = {} % Function for removing trials (using trialNfo vars)
    o.badTrials {mustBeMember(o.badTrials,["noPdio" "noRT" ""])} = ""; % Bad trial criteria to remove
    % Floating-point precision for variables [half|single|double]
    o.float (1,1){mustBeMember(o.float,["double" "single" "half"])} = "double"
    % Epoch time limits (secs) [nan=variable, 0=none]
    o.pre (1,1) double = nan  % Duration before stim onset [nan = pre-stim ITI]
    o.post (1,1) double = nan % Duration after stim offset [nan = post-stim ITI]
    o.max (1,1) double = nan  % Max duration after stim onset, supercedes 'post' [nan = no limit]
    % Epoch time bins (secs)
    o.bin (1,1) double = 1000/n.hz  % Latency bin width (secs)
    o.binPct (1,1) double = 1 % Latency percent bin width (<=100)
    % Task conditions
    o.conds string = string(unique(psy.cond)) % List of condition names (order by desired categorical order)
    o.conds2 string = ""                      % List of custom condition names (ordered like 'oe.conds')
    % Epoch baseline period for subsequent processing
    %   (none=[], all pre/post times=inf, relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
    o.baselinePre {mustBeFloat} = [] % Pre-stimulus baseline (secs from stim onset): inf=ITI; [-.2]; [-0.2 1]
    o.baselinePost {mustBeFloat} = [] % Post-stimulus baseline (secs from stim offset): inf=ITI; [.2]; [0.1 0.3]
end
% n=ns; oe=o.epoch; oe.conds=o.conds; oe.conds2=o.conds2;
o.pre=seconds(abs(o.pre)); o.post=seconds(abs(o.post));


%% Main
trs = height(trialNfo);
ep = cell(trs,1); % trial epochs

% Loop to collate frames across trials
for t = 1:trs
    % Prep
    tNfo = trialNfo(t,:);
    tr = tNfo.tr;
    cond = tNfo.cond;
    e = cell(3,1);

    % Pre-stimulus frames
    if o.pre~=0
        if ~isnan(o.pre)
            tNfo.iti = tNfo.ons - o.pre;
        elseif cond=="Rest"
            tNfo.iti = tNfo.ons - seconds(0.3);
        end
        tNfo.idxITI = psy.idx(tNfo.iti);

        % Extract pre-stim table
        e{1} = psy(timerange(tNfo.iti,tNfo.ons),:);
        e{1}.pre(:)=tr; e{1}.stim(:)=0; e{1}.post(:)=0;
        tNfo.durITI = range(e{1}.Time);
    end

    % Peri-stimulus frames
    if cond=="Rest" && t<trs
        % Extend rest peri-stimulus to include next ITI
        tNfo.idxOff = trialNfo.idxOns(t+1) - 1;
        tNfo.off = psy.Time(tNfo.idxOff);
        e{2} = psy(timerange(tNfo.ons,tNfo.off,"closed"),:);
        tNfo.durStim = range(e{2}.Time);
    else
        e{2} = psy(psy.stim==tr,:);
    end
    e{2}.pre(:)=0; e{2}.stim(:)=tr; e{2}.post(:)=0;

    % Post-stimulus frames
    if o.post~=0
        if ~isnan(o.post)
            e{3} = psy(timerange(tNfo.off,tNfo.off+o.post,"openleft"),:);
        elseif cond=="Rest"
            e{3} = psy(timerange(tNfo.off,tNfo.off+seconds(0.3),"openleft"),:);
        else
            e{3} = psy(psy.post==tr,:);
        end
        e{3}.pre(:)=0; e{3}.stim(:)=0; e{3}.post(:)=tr;
    end

    % Concactenate pre, peri & post frames
    e = timetable2table(vertcat(e{:}));
    iPre = e.pre==tr;
    iStim = e.stim==tr;
    iPost = e.post==tr;
    
    % Latency
    e.latency = seconds(e.Time - tNfo.ons); % relative to stimulus
    e.latRT = seconds(e.Time - tNfo.off); % relative to RT
    e.latency = round(e.latency*n.hz)/n.hz;
    e.latRT = round(e.latRT*n.hz)/n.hz;

    % Latency percentage
    e.pct(iPre) = normalize(e.latency(iPre),"range",[-10 0-eps]);
    e.pct(iStim) = normalize(e.latency(iStim),"range",[0 100-eps(100)]);
    e.pct(iPost) = normalize(e.latency(iPost),"range",[100 110-eps(110)]);
    
    % REMOVE frames over max latency ('max' argument)
    if ~isnan(o.max)
        e(e.latency>o.max,:) = [];
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

    % Copy to main
    ep{t} = e;
    trialNfo(t,:) = tNfo;
end


%% Remove bad trials
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
    trialNfo.removed = o.rmTrialsFun(trialNfo) | trialNfo.removed; end

% Remove if no photodiode signal
if ismember("noPdio",o.badTrials)
    trialNfo.removed = trialNfo.noPdio | trialNfo.removed; end

% Remove if no RT
if ismember("noRT",o.badTrials)
    trialNfo.removed = ~(trialNfo.RT>0) | trialNfo.removed; end

% Remove
if any(trialNfo.removed)
    rmTrials = trialNfo.tr(trialNfo.removed);
    ep(ismember(ep.tr,rmTrials),:) = [];
    disp("[ec_epochPsy] removed bad trials: "+n.sbj);
end


%% Finalize
ep = vertcat(ep{:});
ep(:,["Time" "onHz" "photodiode" "trial" "timeR" "noPdio"]) = [];

% Label pre-stimulus baseline frames
if abs(o.baselinePre)==inf
    ep.BLpre = ep.pre>0; % ITI any trial
elseif isany(o.baselinePre)
    if isscalar(o.baselinePre)
        ep.BLpre = -abs(o.baselinePre)<=ep.latency & ep.pre;
    elseif numel(o.baselinePre)==2
        ep.BLpre = o.baselinePre(1)<=ep.latency & ep.latency<o.baselinePre(2);
    end
else
    ep.BLpre(:) = false;
end

% Label post-stimulus baseline frames
if abs(o.baselinePost)==inf
    ep.BLpost = ep.post>0; % ITI any trial
elseif isany(o.baselinePost)
    if isscalar(o.baselinePost)
        ep.BLpost = o.baselinePost<=ep.latency & ep.post;
    elseif numel(o.baselinePost)==2
        ep.BLpost = o.baselinePost(1)<=ep.latency & ep.latency<o.baselinePost(2);
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
ep = convertvars(ep,["frame" "bin" "binRT"],"int16");
ep = convertvars(ep,"binPct","int8");
ep = convertvars(ep,["latency" "pct" "RT" "latRT"],o.float);

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

disp("[ec_epochPsy] Epoched psych/behav task data: "+n.sbj+" time="+toc(tt));








