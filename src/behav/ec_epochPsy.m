function [ep,trialNfo] = ec_epochPsy(psy,trialNfo,n,tt,oe)
arguments
    psy timetable
    trialNfo table
    n struct
    tt (1,1) uint64 = tic
    oe.float (1,1) string = "double" % Floating-point precision [half|single|double]
    % Epoch time limits (secs) [nan=variable, 0=none]
    oe.pre (1,1) double = nan  % Duration before stim onset [nan = pre-stim ITI]
    oe.post (1,1) double = nan % Duration after stim offset [nan = post-stim ITI]
    oe.max (1,1) double = nan  % Max duration after stim onset, supercedes 'post' [nan = no limit]
    % Epoch time bins (secs)
    oe.bin (1,1) double = 0.01  % Fine latency bin width (secs)
    oe.bin2 (1,1) double = 0.05 % Coarse latency bin width (secs)
    oe.pct (1,1) double = 1     % Fine latency percent width (percentile)
    oe.pct2 (1,1) double = 10   % Coarse latency percent width (percentile)
    % Task conditions
    oe.conds string = string(unique(psy.cond)) % List of condition names (order by desired categorical order)
    oe.conds2 string = ""                      % List of custom condition names (ordered like 'oe.conds')
end
% n=ns; oe=o.epoch; oe.conds=o.conds; oe.conds2=o.conds2;
oe.pre=seconds(abs(oe.pre)); oe.post=seconds(abs(oe.post));


%% Prep
trs = height(trialNfo);
ep = cell(trs,1); % trial epochs


%% Collate frames per trial
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
        tNfo.idxITI = find(psy.Time==tNfo.iti);

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

    % Latency percentage
    e.pct(iPre) = normalize(e.latency(iPre),"range",[-10 0-eps]);
    e.pct(iStim) = normalize(e.latency(iStim),"range",[0 100-eps(100)]);
    e.pct(iPost) = normalize(e.latency(iPost),"range",[100 110-eps(110)]);
    
    % REMOVE frames over max latency ('max' argument)
    if ~isnan(oe.max)
        e(e.latency>oe.max,:) = [];
        tNfo.off = e.Time(end);
        tNfo.idxOff = e.idx(end);
        tNfo.durStim = seconds(e.latency(end));
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
    %e.noPdio(:) = tNfo.noPdio;

    % Copy to main
    ep{t} = e;
    trialNfo(t,:) = tNfo;
end


%% Finalize
ep = vertcat(ep{:});
ep(:,["Time" "onHz" "photodiode" "trial" "timeR"]) = [];

% Task condition categorical order
if ~isany(oe.conds2)
    ep.cond = categorical(ep.cond,oe.conds);
else % Custom condition names
    [~,ci] = max(ep.cond==oe.conds,[],2);
    ep.cond = oe.conds2(ci)';
    ep.cond = categorical(ep.cond,oe.conds2);
end

% Bin timings
ep.frame = round(ep.latency*n.hz); % frame within trial
ep.bin = floor(ep.latency/oe.bin) * oe.bin * 1000;
ep.bin2 = floor(ep.latency/oe.bin2) * oe.bin2 * 1000;
ep.pct = floor(ep.pct);
ep.pct2 = floor(ep.pct/oe.pct2) * oe.pct2;
ep.binRT = floor(ep.latRT/oe.bin) * oe.bin * 1000;
ep.binRT2 = floor(ep.latRT/oe.bin2) * oe.bin2 * 1000;

% Convert vars
ep = convertvars(ep,["frame" "bin" "bin2" "binRT" "binRT2"],"int16");
ep = convertvars(ep,["pct" "pct2"],"int8");
%ep = convertvars(ep,["latency" "pct" "RT" "latRT"],oe.float);

% Reorder vars
ep = movevars(ep,["frame" "latency" "bin" "bin2" "pct" "pct2" "latRT" "binRT" "binRT2"],...
    "After","cond");

ep.Properties.RowNames = string(ep.frame)+"_tr"+ep.tr+"_"+string(ep.cond);



disp("[ec_epochMetadata] Made analysis template: "+n.sbj+" time="+toc(tt));








