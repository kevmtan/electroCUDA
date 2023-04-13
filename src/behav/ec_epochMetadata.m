function ep = ec_epochMetadata(psy,trialNfo,n,o,tt)
arguments
    psy table
    trialNfo table
    n struct
    o struct
    tt (1,1) uint64 = tic
end
fs = n.fs;
BLpre=o.BLpre*fs; BLend=o.BLend*fs; epoch=o.epoch*fs; epochRT=o.epochRT*fs;
if ~isempty(epoch)
    sz = numel(epoch(1):epoch(2));
    if ~isempty(epochRT) && epochRT(end)<=0
        epochRT(2)=abs(epoch(1));
        szRT = numel(1:epochRT(2));
    end
end

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

    if any(epoch)
        % Add missing time for target duration after RT
        szTr = numel(iTr);
        if szTr < szRT
            iTr = iTr(1) : iTr(1)+szRT; %-1;
        end

        if any(epochRT)
            % Add missing time for target trial duration
            szTr = numel(trialNfo.idxITI(t) : iTr(end));
            if szTr < sz
                iTr = iTr(1) : iTr(end)+(sz-szTr);
            end
        end

        iTr(~ismember(iTr,psy.idx(psy.run==run))) = [];
    end

    % Fill out
    et = psy(iTr,:);
    et.run(:) = run;
    et.trialA(:) = tr;
    et.cond(:) = trialNfo.cond(t);
    et.RT(:) = trialNfo.RT(t);
    et.postRT(:) = tr;
    et.latency = et.time - psy.time(trialNfo.idxStim(t));
    et.frame = int16(et.latency*fs);
    et.pct(:) = 0;
    idx = ismember(et.idx,iTrOg);
    et.pct(idx) = normalize(et.latency(idx),"range",[100 110-eps(110)]);
    et.pct(~idx) = normalize(et.latency(~idx),"range",[110 120-eps(120)]);
    if any(BLend)
        idx = find(et.stim,1)-1;
        idx = idx+floor(BLend(1)*fs) : idx+floor(BLend(2)*fs);
        et.BLend(idx) = tr;
    else
        et.BLend(:) = 0;
    end

    % Copy to cell
    ep_post{t} = et;
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

%% Edits
ep.latency = round(ep.latency*1000); %int32(round(anT.latency*1000));
ep.RT = round(ep.RT*1000);
ep.condC = categorical(ep.cond,o.conds,'Ordinal',true);

% Optimize pcts
ep.pct = floor(ep.pct);
ep.pct2 = floor(ep.pct/o.pct2)*o.pct2; % pct2

% Latency-RT
for t = 1:height(trialNfo)
    tr = trialNfo.trialA(t);
    iTr = ep.trialA==tr;
    RThz = round(psy.latency(trialNfo.idxRT(t))*1000);
    ep.latRT(iTr) = ep.latency(iTr) - RThz;
end

% Bin & binRT
bin = floor(1000*o.bin);
ep.bin = floor(ep.latency/bin)*bin;
ep.binRT = floor(ep.latRT/bin)*bin;
bin2 = floor(1000*o.bin2);
ep.bin2 = floor(ep.latency/bin2)*bin2;

% Convert
ep.latency = int32(ep.latency);
ep.latRT = int32(ep.latRT);
ep.bin = int16(ep.bin);
ep.binRT = int16(ep.binRT);
ep.pct = int16(ep.pct);
ep.pct2 = int16(ep.pct2);
%anT.RT = uint16(anT.RT);
ep = movevars(ep, ["latRT" "bin" "binRT" "pct" "pct2" "RT"], "After","latency");

disp("[ec_epochMetadata] Made analysis template: "+n.sbj+" time="+toc(tt));