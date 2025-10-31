function [ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,tt,oe)
arguments
    psy timetable
    trialNfo table
    n struct
    tt (1,1) uint64 = tic
    % Bad trial removal
    oe.rmTrials {islogical,isnumeric} = []; % Trials to remove (numeric array or logical index)
    oe.badTrials {mustBeMember(oe.badTrials,["noPdio" "noRT" ""])} = ""; % Bad trial criteria to remove
    % Floating-point precision for variables [half|single|double]
    oe.float (1,1){mustBeMember(oe.float,["double" "single" "half"])} = "double"
    % Epoch time limits (secs) [nan=variable, 0=none]
    oe.pre (1,1) double = nan  % Duration before stim onset [nan = pre-stim ITI]
    oe.post (1,1) double = nan % Duration after stim offset [nan = post-stim ITI]
    oe.max (1,1) double = nan  % Max duration after stim onset, supercedes 'post' [nan = no limit]
    % Epoch time bins (secs)
    oe.bin (1,1) double = 1000/n.hz  % Latency bin width (secs)
    oe.binPct (1,1) double = 1 % Latency percent bin width (<=100)
    % Task conditions
    oe.conds string = string(unique(psy.cond)) % List of condition names (order by desired categorical order)
    oe.conds2 string = ""                      % List of custom condition names (ordered like 'oe.conds')
    % Epoch baseline period for subsequent processing
    %   (none=[], all pre/post times=inf, relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
    oe.baselinePre {mustBeFloat} = [] % Pre-stimulus baseline (secs from stim onset): inf=ITI; [-.2]; [-0.2 1]
    oe.baselinePost {mustBeFloat} = [] % Post-stimulus baseline (secs from stim offset): inf=ITI; [.2]; [0.1 0.3]
end
% n=ns; oe=o.epoch; oe.conds=o.conds; oe.conds2=o.conds2;
oe.pre=seconds(abs(oe.pre)); oe.post=seconds(abs(oe.post));


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
    if oe.pre~=0
        if ~isnan(oe.pre)
            tNfo.iti = tNfo.ons - oe.pre;
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
    if oe.post~=0
        if ~isnan(oe.post)
            e{3} = psy(timerange(tNfo.off,tNfo.off+oe.post,"openleft"),:);
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
    if ~isnan(oe.max)
        e(e.latency>oe.max,:) = [];
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

% Specified trials to remove
if isany(oe.rmTrials)
    if islogical(oe.rmTrials) % Logical index
        if length(oe.rmTrials)==trs
            trialNfo.removed(oe.rmTrials) = true;
        else
            error("[ec_epochPsy] rmTrials input must match height of trialNfo: "+n.sbj);
        end
    elseif isnumeric(oe.rmTrials) % Array of trial numbers
        trialNfo.removed = ismember(trialNfo.tr,oe.rmTrials);
    end
end

% Remove if no photodiode signal
if ismember("noPdio",oe.badTrials)
    trialNfo.removed = trialNfo.noPdio | trialNfo.removed; end

% Remove if no RT
if ismember("noRT",oe.badTrials)
    trialNfo.removed = ~(trialNfo.RT>0) | trialNfo.removed; end

% Remove
if any(trialNfo.removed)
ep{trialNfo.removed} = []; end


%% Finalize
ep = vertcat(ep{:});
ep(:,["Time" "onHz" "photodiode" "trial" "timeR" "noPdio"]) = [];

% Label pre-stimulus baseline frames
if abs(oe.baselinePre)==inf
    ep.BLpre = ep.pre>0; % ITI any trial
elseif isany(oe.baselinePre)
    if isscalar(oe.baselinePre)
        ep.BLpre = -abs(oe.baselinePre)<=ep.latency & ep.pre;
    elseif numel(oe.baselinePre)==2
        ep.BLpre = oe.baselinePre(1)<=ep.latency & ep.latency<oe.baselinePre(2);
    end
else
    ep.BLpre(:) = false;
end

% Label post-stimulus baseline frames
if abs(oe.baselinePost)==inf
    ep.BLpost = ep.post>0; % ITI any trial
elseif isany(oe.baselinePost)
    if isscalar(oe.baselinePost)
        ep.BLpost = oe.baselinePost<=ep.latency & ep.post;
    elseif numel(oe.baselinePost)==2
        ep.BLpost = oe.baselinePost(1)<=ep.latency & ep.latency<oe.baselinePost(2);
    end
else
    ep.BLpost(:) = false;
end

% Task condition categorical order
ep.cond = categorical(ep.cond,oe.conds);
trialNfo.cond = categorical(trialNfo.cond,oe.conds);
if isany(oe.conds2)
    ep.cond = renamecats(ep.cond,oe.conds,oe.conds2);
    trialNfo.cond = renamecats(trialNfo.cond,oe.conds,oe.conds2);
end

% Bin timings
ep.frame = round(ep.latency*n.hz); % frame within trial
ep.bin = ep.latency/oe.bin;
ep.bin = floor(ep.bin+eps(ep.bin)) * oe.bin * 1000;
ep.binRT = ep.latRT/oe.bin;
ep.binRT = floor(ep.binRT+eps(ep.binRT)) * oe.bin * 1000;
ep.binPct = floor(ep.pct)/oe.binPct;
ep.binPct = floor(ep.binPct+eps(ep.binPct)) * oe.binPct;

% Convert vars
ep = convertvars(ep,["frame" "bin" "binRT"],"int16");
ep = convertvars(ep,"binPct","int8");
ep = convertvars(ep,["latency" "pct" "RT" "latRT"],oe.float);

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








