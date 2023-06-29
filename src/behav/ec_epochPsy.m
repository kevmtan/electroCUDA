function [ep,psy,trialNfo] = ec_epochPsy(psy,trialNfo,n,tt,oe)
arguments
    psy table
    trialNfo table
    n struct
    tt (1,1) uint64 = tic
    oe.bin (1,1) double = 0.02;                  % Fine latency bin width (secs)
    oe.bin2 (1,1) double = 0.1;                  % Coarse latency bin width (secs)
    oe.pct (1,1) double = 1;                     % Fine latency percent width (percentile)
    oe.pct2 (1,1) double = 10;                   % Coarse latency percent width (percentile)
    % Epoch baseline period (none=[]):
    oe.baselinePre (1,2) double = [0 0];         % Pre-stimulus baseline start/end (secs from stim onset); ex=[-0.2 0]
    oe.baselineEnd (1,2) double = [0 0];         % Post-stimulus baseline start/end (secs from next stim onset); ex=[-0.1 0]
    % Epoch time limits (variable limits=[]):
    oe.lims (1,2) double = [0 0];                % Epoch start & end from stim onset (secs); ex=[-0.2 3]
    oe.limsRT (1,2) double = [0 0];              % Epoch start & end from behavioral RT (secs); ex=[-1.5 .5]
    oe.limtsPct (1,2) double = [0 0];            % Epoch start & end from latency percentile; ex=[-10 120]
    % Task conditions
    oe.conds string = string(unique(psy.cond));  % List of condition names (order by desired categorical order)
    oe.conds2 string = "";                       % List of custom condition names (ordered like 'oe.conds')
end
fs = n.fs;
BLpre=oe.baselinePre*fs; BLend=oe.baselineEnd*fs; lims=oe.lims*fs; limsRT=oe.limsRT*fs;
if ~isempty(lims)
    sz = numel(lims(1):lims(2));
    if ~isempty(limsRT)
        if limsRT(end)<=0
            limsRT(2)=abs(lims(1)); end
        szRT = numel(1:limsRT(2));
    end
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
    ee.frame = int16(ee.latency*fs);
    ee.pct(:) = 0;
    idx = ismember(ee.idx,iTrOg);
    ee.pct(idx) = normalize(ee.latency(idx),"range",[100 110-eps(110)]);
    ee.pct(~idx) = normalize(ee.latency(~idx),"range",[110 120-eps(120)]);
    if any(BLend)
        idx = find(ee.stim,1)-1;
        idx = idx+floor(BLend(1)*fs) : idx+floor(BLend(2)*fs);
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
ep.latRT = ep.latency - ep.RT;

% Bin & binRT
bin = floor(1000*oe.bin);
ep.bin = floor(ep.latency/bin)*bin;
ep.binRT = floor(ep.latRT/bin)*bin;
bin2 = floor(1000*oe.bin2);
ep.bin2 = floor(ep.latency/bin2)*bin2;

% Pcts
ep.pct = floor(ep.pct);
ep.pct2 = floor(ep.pct/oe.pct2)*oe.pct2; % pct2

% Convert data type
ep.latency = int32(ep.latency);
ep.latRT = int32(ep.latRT);
ep.bin = int16(ep.bin);
ep.binRT = int16(ep.binRT);
ep.pct = int16(ep.pct);
ep.pct2 = int16(ep.pct2);
ep.RT = uint16(ep.RT);
ep = movevars(ep, ["bin" "bin2" "pct" "pct2" "RT" "RTog" "latRT" "binRT" ], "After","latency");

disp("[ec_epochMetadata] Made analysis template: "+n.sbj+" time="+toc(tt));