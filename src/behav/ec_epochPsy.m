function [ep,trialNfo] = ec_epochPsy(psy,trialNfo,n,tt,oe)
arguments
    psy timetable
    trialNfo table
    n struct
    tt (1,1) uint64 = tic
    oe.bin (1,1) double = 0.01  % Fine latency bin width (secs)
    oe.bin2 (1,1) double = 0.05 % Coarse latency bin width (secs)
    oe.pct (1,1) double = 1     % Fine latency percent width (percentile)
    oe.pct2 (1,1) double = 10   % Coarse latency percent width (percentile)
    % Epoch time limits (secs) [nan=variable, 0=none]
    oe.pre (1,1) double = nan  % Duration before stim onset [nan = pre-stim ITI]
    oe.post (1,1) double = nan % Duration after stim offset [nan = post-stim ITI]
    oe.max (1,1) double = nan  % Max duration after stim onset, supercedes 'post' [nan = no limit]
    % Task conditions
    oe.conds string = string(unique(psy.cond)) % List of condition names (order by desired categorical order)
    oe.conds2 string = ""                      % List of custom condition names (ordered like 'oe.conds')
end
% n=ns; oe=o.epoch; oe.conds=o.conds; oe.conds2=o.conds2;
oe.pre=seconds(abs(oe.pre)); oe.post=seconds(abs(oe.post)); oe.max=seconds(abs(oe.max));


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
        e{1} = timetable2table(e{1});
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
    e{2} = timetable2table(e{2});

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
        e{3} = timetable2table(e{3});
    end

    % Concactenate pre, peri & post frames
    e = vertcat(e{:});
    iPre = e.pre==tr;
    iStim = e.stim==tr;
    iPost = e.post==tr;

    % Trial metadata
    e.tr(:) = tr;
    e.cond(:) = cond;
    e.run(:) = tNfo.run;
    e.trial(:) = tNfo.trial;
    e.RT(:) = tNfo.RT;
    e.valence(:) = tNfo.valence;
    e.resp(:) = tNfo.resp;
    e.noPdio(:) = tNfo.noPdio;

    % Latency relative to stimulus
    e.latency = e.Time - tNfo.ons; % relative to stimulus
    e.frame = milliseconds(e.latency); % frame within trial

    % Latency percentage
    e.pct = e.latency ./ max(e.latency(iStim));
    e.pct(iPre) = normalize(seconds(e.latency(iPre)),"range",[-0.1 0-eps]);
    e.pct(iPost) = normalize(seconds(e.latency(iPost)),"range",[1+eps 1.1]);

    % Latency relative to behav RT
    e.latRT = e.Time - tNfo.off;
    if cond=="Rest"
        e.latRT = e.latency - max(e.latency(iStim)); end

    % Save
    ep{t} = e;
    trialNfo(t,:) = tNfo;
end




%%

disp("[ec_epochMetadata] Made analysis template: "+n.sbj+" time="+toc(tt));








