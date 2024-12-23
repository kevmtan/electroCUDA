function [ep,psy,trialNfo] = ec_epochPsy(psy,trialNfo,n,tt,oe)
arguments
    psy table
    trialNfo table
    n struct
    tt (1,1) uint64 = tic
    oe.bin (1,1) double = 0.02                  % Fine latency bin width (secs)
    oe.bin2 (1,1) double = 0.1                  % Coarse latency bin width (secs)
    oe.pct (1,1) double = 1                     % Fine latency percent width (percentile)
    oe.pct2 (1,1) double = 10                   % Coarse latency percent width (percentile)
    % Epoch time limits (secs) [nan=variable, 0=none]
    oe.pre (1,1) double = nan                   % Pre-stimulus duration [nan=ITI]
    oe.peri (1,1) double = nan                  % Peri-stimulus duration [nan=all]
    oe.post (1,1) double = nan                  % Post-stimulus duration [nan=ITI]
    % Task conditions
    oe.conds string = string(unique(psy.cond))  % List of condition names (order by desired categorical order)
    oe.conds2 string = ""                       % List of custom condition names (ordered like 'oe.conds')
    % Epoch baseline period (none=[]):
    %oe.baselinePre (1,2) double = [0 0];         % Pre-stimulus baseline start/end (secs from stim onset); ex=[-0.2 0]
    %oe.baselineEnd (1,2) double = [0 0];         % Post-stimulus baseline start/end (secs from next stim onset); ex=[-0.1 0]
end
hz = n.hz;
BLpre=oe.baselinePre*hz; BLend=oe.baselineEnd*hz; lims=oe.lims*hz; limsRT=oe.limsRT*hz;
if nnz(lims)
    sz = numel(lims(1):lims(2));
else
    sz = 0;
end
if ~isempty(limsRT)
    szRT = numel(1:limsRT(2));
end

%% Align RT wtih sampling rate
psy.RTog(:) = nan;
psy = movevars(psy,"RTog",After="RT");
trialNfo.durRT(:) = nan;
trialNfo = movevars(trialNfo,"durRT",After="durTrial");

% Loop across trials
for t = 1:height(trialNfo)
    tr = trialNfo.trialA(t);
    iTr = psy.trialA==tr;

    % Find & fill
    durRT = psy.latency(trialNfo.idxRT(t));
    trialNfo.durRT(t) = durRT;
    psy.RT(iTr) = durRT;
    psy.RTog(iTr) = trialNfo.RT(t);
end

if ~any(double(trialNfo.durTrial)~=double(trialNfo.durRT),"all")
    warning("[ec_epochPsy] trialNfo.durTrial~=trialNfo.durRT: "+n.sbj); end

%% Epoch subject metadata
ep = psy(psy.trialA~=0|~isnan(psy.latency),:);

% Find last trials
lastTrials = nan(numel(n.runs),1);
for r = 1:numel(n.runs)
    lastTrials(r) = max(trialNfo.trialA(trialNfo.run==n.runs(r)));
end

% Pre-stimulus & peri-stimulus analysis frames
ep(ismember(ep.postRT,lastTrials),:) = [];
ep.pre(ep.latency<0) = true;
ep.post(:) = false;
ep_post = cell(height(trialNfo),1);


% Loop across trials
for t = 1:height(trialNfo)
    tr = trialNfo.trialA(t);
    run = trialNfo.run(t);

    %% Pre-stimulus frames
    iTr = ep.trialA==tr & ep.pre;
    ep.pct(iTr) = normalize(ep.latency(iTr),"range",[-10 0-eps]);
    if any(BLpre)
        iTr = iTr & ep.latency>=BLpre(1) & ep.latency<BLpre(2);
        ep.BLpre(iTr) = tr;
    end

    %% Peri-stimulus frames
    iTr = ep.trialA==tr & ep.stim & ~ep.pre;
    ep.pct(iTr) = normalize(ep.latency(iTr),"range",[0 100-eps(100)]);

    
    %% Post-stimulus analysis frames
    iTr = psy.idx(psy.postRT==tr);
    iTrOg = iTr;

    if any(lims)
        % Add missing time for target duration after RT
        szTr = numel(iTr);
        if szTr < szRT
            iTr = iTr(1) : iTr(1)+szRT; %-1;
        end

        if any(limsRT)
            % Add missing time for target trial duration
            szTr = numel(trialNfo.idxITI(t) : iTr(end));
            if szTr < sz
                iTr = iTr(1) : iTr(end)+(sz-szTr);
            end
        end
        iTr(~ismember(iTr,psy.idx(psy.run==run))) = [];
    end

    % Fill out
    ee = psy(iTr,:);
    ee.run(:) = run;
    ee.trialA(:) = tr;
    ee.cond(:) = trialNfo.cond(t);
    ee.RT(:) = trialNfo.durRT(t);
    ee.RTog(:) = trialNfo.RT(t);
    ee.postRT(:) = tr;
    ee.latency = ee.time - psy.time(trialNfo.idxStim(t));
    ee.frame = int16(ee.latency*hz);
    ee.pct(:) = 0;
    idx = ismember(ee.idx,iTrOg);
    ee.pct(idx) = normalize(ee.latency(idx),"range",[100 110-eps(110)]);
    ee.pct(~idx) = normalize(ee.latency(~idx),"range",[110 120-eps(120)]);
    if any(BLend)
        idx = find(ee.stim,1)-1;
        idx = idx+floor(BLend(1)*hz) : idx+floor(BLend(2)*hz);
        ee.BLend(idx) = tr;
    else
        ee.BLend(:) = 0;
    end

    % Copy to cell
    ep_post{t} = ee;
end

% Concactenate trials
ep_post = vertcat(ep_post{:});
ep_post.pre(:) = false;
ep_post.post(:) = true;
ep_post.BLpre(:) = 0;

%% Combine analysis timepoints
ep = [ep; ep_post];

% Sort & make indices
ep = sortrows(ep,{'trialA','latency'},'ascend');
ep.iPsy = ep.idx;
ep.idx = uint32(1:height(ep))';

%% Task condition categorical order
if ~isany(oe.conds2)
    ep.condC = categorical(ep.cond,oe.conds);
else
    % Custom condition names
    [~,ci] = max(ep.cond==oe.conds,[],2);
    ep.cond = oe.conds2(ci)';
    ep.condC = categorical(ep.cond,oe.conds2);
end

%% Optimize timing metrics

% Latency & RT
ep.latency = floor(ep.latency*1000); %int32(round(anT.latency*1000));
ep.RT = floor(ep.RT*1000);
ep.latRT = floor(ep.latency - ep.RT);

% Bin & binRT
bin = floor(1000*oe.bin);
bin2 = floor(1000*oe.bin2);
ep.bin = ceil(ep.latency/bin)*bin;
ep.binRT = ceil(ep.latRT/bin)*bin;
ep.bin2 = ceil(ep.latency/bin2)*bin2;

% Pcts
ep.pct = floor(ep.pct);
ep.pct2 = ceil(ep.pct/oe.pct2)*oe.pct2; % pct2

% Convert data type
ep.latency = int32(ep.latency);
ep.latRT = int32(ep.latRT);
ep.bin = int16(ep.bin);
ep.bin2 = int16(ep.bin2);
ep.binRT = int16(ep.binRT);
ep.pct = int16(ep.pct);
ep.pct2 = int16(ep.pct2);
ep.RT = uint16(ep.RT);
ep = movevars(ep, ["bin" "bin2" "pct" "pct2" "RT" "RTog" "latRT" "binRT" ], "After","latency");

disp("[ec_epochMetadata] Made analysis template: "+n.sbj+" time="+toc(tt));