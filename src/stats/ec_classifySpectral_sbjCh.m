function ec_classifySpectral_sbjCh(sbj,proj,o,dirs,a)
arguments
    sbj {istext,isnumeric}
    proj {istext} = "MMR"
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    dirs struct = []
    a.type string = "spec"
    a.ICA logical = false
    a.sfx string = ""
    a.stats logical = false
    a.plot logical = false
    a.test logical = false
end




%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% Make analysis template %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function anT = analysisTemplate_lfn(psy,trialNfo,n,o)
epoch=o.epoch5*n.fs; epochRT=o.epochRT*n.fs;
if epochRT(end)<=0; epochRT(2)=abs(epoch(1)); end
sz = numel(epoch(1):epoch(2));
szRT = numel(1:epochRT(2));

% Find last trials
lastTrials = nan(numel(n.runs),1);
for r = 1:numel(n.runs)
    lastTrials(r) = max(trialNfo.trialA(trialNfo.run==n.runs(r)));
end

% Pre-stimulus & peri-stimulus analysis frames
anT = psy(psy.trialA~=0|psy.latency<0,:);
anT(ismember(anT.postRT,lastTrials),:) = [];
anT.pre(anT.frame<0) = true;
anT.post(:) = false;

% Post-stimulus analysis frames
anPost = cell(height(trialNfo),1);
for t = 1:height(trialNfo)
    tr = trialNfo.trialA(t);
    run = trialNfo.run(t);
    iTr = psy.idx(psy.postRT==tr);
    iTrPost = numel(iTr);

    % Add missing time for target duration after RT
    szTr = numel(iTr);
    if szTr < szRT
        iTr = iTr(1) : iTr(1)+szRT; %-1;
    end

    % Add missing time for target trial duration
    szTr = numel(trialNfo.idxITI(t) : iTr(end));
    if szTr < sz
        iTr = iTr(1) : iTr(end)+(sz-szTr);
    end
    iTr(~ismember(iTr,psy.idx(psy.run==run))) = [];

    % Fill out
    anP = psy(iTr,:);
    anP.run(:) = run;
    anP.trialA(:) = tr;
    anP.cond(:) = trialNfo.cond(t);
    anP.RT(:) = trialNfo.RT(t);
    anP.postRT(:) = tr;
    anP.latency = anP.time - psy.time(trialNfo.idxStim(t));
    anP.frame = int16(anP.latency*n.fs);
    anP.pct = anP.latency - anP.latency(1) + 1/n.fs;
    anP.pct = anP.pct / anP.pct(iTrPost);
    % Copy to cell
    anPost{t} = anP;
end
% Concactenate trials
anPost = vertcat(anPost{:});
anPost.pre(:) = false;
anPost.post(:) = true;
anPost.BLpre(:) = 0;
anPost.pct = anPost.pct/2;
anPost.pct = anPost.pct+1;

%% Combine analysis timepoints
anT = [anT; anPost];

% Sort & make indices
anT = sortrows(anT,{'trialA','latency'},'ascend');
anT.iPsy = anT.idx;
anT.idx = uint32(1:height(anT))';

%% Edits
anT.latency = round(anT.latency*1000); %int32(round(anT.latency*1000));
anT.RT = round(anT.RT*1000);
anT.condC = categorical(anT.cond,o.conds,'Ordinal',true);

% Optimize pcts
anT.pct = ceil(anT.pct*100);
anT.pct2 = ceil(anT.pct/2)*2; % pct2

% Latency-RT
for t = 1:height(trialNfo)
    tr = trialNfo.trialA(t);
    iTr = anT.trialA==tr;
    RThz = round(psy.latency(trialNfo.idxRT(t))*1000);
    anT.latRT(iTr) = anT.latency(iTr) - RThz;
end

% Bin & binRT
binP = floor(1000*o.binP);
anT.bin = floor(anT.latency/binP)*binP;
anT.binRT = floor(anT.latRT/binP)*binP;

% Convert
anT.latency = int32(anT.latency);
anT.latRT = int32(anT.latRT);
anT.bin = int16(anT.bin);
anT.binRT = int16(anT.binRT);
anT.pct = int16(anT.pct);
anT.pct2 = int16(anT.pct2);
%anT.RT = uint16(anT.RT);
anT = movevars(anT, ["latRT" "bin" "binRT" "pct" "pct2" "RT"], "After","latency");

disp(['Made analysis template: ' n.sbj]);
% % Get latency bins
% bn = floor(o.timeBins*n.fs);
% anT.bin = floor(anT.latency/bn)*bn;
% latBins = groupcounts(anT,["cond" "bin"]);
%
% % binP
% b2 = o.binP;
% binP = anT.bin(anT.post);
% binP = floor(binP./b2)*b2;
% while numel(unique(binP)) > o.binP_max
%     b2 = b2 + 50;
%     binP = floor(binP./b2)*b2;
% end
% anT.binP = floor(anT.bin/b2)*b2;
% anT.binP = int16(anT.binP);
% anT.bin = int16(anT.bin);
end


% Baseline correct/denoise/lowpass/downsample %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xa,na] = blcFiltClean_lfn(xa,na,psy,anT,trialNfo,o)
sbj = na.sbj;
blocks = string(na.blocks);
runs = na.runs;
nRuns = numel(runs);
nChs = size(xa,2);
fs = na.fs;
fsTarg = o.fsTarg;
ds = floor(fs/fsTarg);
badFields = o.badFields;
missingInterp = o.missingInterp;
%thrOL = o.thrOL;
thrOLbl = o.thrOLbl;
conds = o.conds;
runIdx = na.runIdxOg(:,2);
% runIdx = grpstats(psy,"run",["min" "max"],"DataVars","idx"); % Get run indices
% runIdx = sortrows(runIdx,["min_idx" "max_idx"],"ascend");
%nWorkers = gcp('nocreate').NumWorkers;
%nTrs = na.nTrials;
%trialA = trialNfo.trialA;
%trialAT = anT.trialA;
%pre = anT.pre;
%condT = anT.cond;
%stim = anT.stim;
% detrendOrder = o.detrendOrder;
% detrendItr = o.detrendItr;
% detrendThr = o.detrendThr;

% Separate non-trial frames at start vs. end of each run
psy.trialR = int32(psy.trialA);
for r = 1:nRuns
    run = runs(r);
    thr = min(trialNfo.idxITI(trialNfo.run==run));
    idx = psy.run==run & psy.trialR==0 & psy.idx<=thr;
    psy.trialR(idx) = -1;

    thr = max(trialNfo.idxITI(trialNfo.run==run));
    idx = psy.run==run & psy.trialR==0 & psy.idx>=thr;
    psy.trialR(idx) = Inf;
end
trIdx = grpstats(psy,["run" "trialR"],["min" "max"],"DataVars","idx"); % trial indices
trIdx = sortrows(trIdx,["min_idx" "max_idx"],"ascend");
if any(diff(trIdx.min_idx)<1) || any(diff(trIdx.max_idx)<1)
    warning("psy.trialR frame idx NOT sequentially increasing: "+sbj);
end

% [~,r] = min(runIdx.GroupCount);
% idx = psy.run==runIdx.run(r) & ~isnan(xa(:,1,1));
% % Remove frames excluded from ICA decomposition
% if na.ICA
%     if numel(na.chICA_badFrames)~=height(xa)
%         [ds1,ds2] = rat(fs/na.fs_orig);
%         na.chICA_badFrames = double(full(na.chICA_badFrames));
%         na.chICA_badFrames = resample(na.chICA_badFrames,ds1,ds2) > 0.5;
%     end
%     xa(na.chICA_badFrames,:,:) = nan;
%     disp("Removed excluded ICA frames: "+sbj);
% end

% Remove bad frames
if ~isempty(badFields)
    for f = 1:numel(badFields)
        x_bad = na.xBad.(badFields(f));
        parfor ch = 1:nChs
            xCh = squeeze(xa(:,ch,:)); % load chan data
            badIdxCh = squeeze(x_bad(:,ch,:));
            xCh(badIdxCh) = nan;
            xa(:,ch,:) = xCh; % Copy back processed data
        end
    end
    disp("Removed bad frames: "+sbj);
end


%% Outliers, HPF, normalize, LPF & downsampling (within-run)

% Prepare filters
[ds1,ds2] = rat(fsTarg/fs); % downsampling factors
loPassHz = o.loPass;
if any(loPassHz)
    gusSz = floor(fs/loPassHz);
    gusWin = gausswin(gusSz)/sum(gausswin(gusSz));
end

hiPassHz = o.hiPass;
if any(hiPassHz)
    hpf = designfilt('highpassfir',StopbandFrequency=hiPassHz*.75,PassbandFrequency=hiPassHz,...
        StopbandAttenuation=80,DesignMethod="kaiserwin",SampleRate=fs);
else
    hpf = [];
end

% Prepare normalization
logSpec=[]; doNorm=[];
if o.logSpec && contains(na.suffix,"s"|"d"|"t"|"a"|"b"|"g"|"h")
    logSpec = o.normalizeSpec;
elseif isany(o.normalizeSpec) && contains(na.suffix,"s"|"d"|"t"|"a"|"b"|"g"|"h")
    doNorm = o.normalizeSpec;
elseif isany(o.normalizeLFP) && ~contains(na.suffix,"s"|"d"|"t"|"a"|"b"|"g"|"h")
    doNorm = o.normalizeLFP;
end

xa = mat2cell(xa,runIdx);
for r = 1:nRuns
    xr = xa{r};
    parfor ch = 1:nChs
        xCh = squeeze(xr(:,ch,:));     
        % % Outliers per cond
        % if thrOL>0
        %    idr = psy.idx(psy.run==runs(r)); %#ok<PFBNS>
        %    for c = 1:numel(conds)
        %        idx = psy.cond(idr)==conds(c) & ~psy.stim(idr);
        %        xCh(idx,:) = filloutliers(xCh(idx,:),"clip","median",1,ThresholdFactor=thrOLbl);
        %        bl = mean(xCh(idx,:),1,"omitnan");
        %        idx = psy.cond(idr)==conds(c);
        %        xCh(idx,:) = filloutliers(xCh(idx,:),"clip","median",1,ThresholdFactor=thrOL);
        %        xCh(idx,:) = xCh(idx,:) - bl; % Center at avg condition baseline
        %    end
        % end

        % Fill missing
        xCh = fillmissing(xCh,missingInterp,1); % Linear interpolation

        % High-pass filter
        if any(hiPassHz)
            xCh = filtfilt(hpf,double(xCh));
        end

        % Normalize
        if ~isempty(logSpec)
            xCh = ec_log2norm(double(xCh),1,scale=logSpec); % Log-normal to normal dist
        elseif ~isempty(doNorm) && doNorm=="robust"
            xCh = normalize(double(xCh),1,"zscore","robust"); % Robust z-score
        elseif ~isempty(doNorm)
            xCh = normalize(double(xCh),1,doNorm); % Other normalize
        end

        % Low-pass filter
        if any(loPassHz)
            xCh = convn(double(xCh),gusWin,'same'); % convolve gaussian
            %xCh = lowpass(double(xCh),loPassHz,fs,ImpulseResponse="fir");
        end
        xr(:,ch,:) = single(xCh);
    end
    disp("Normalized & filtered Low-passed: "+blocks(r));

    % Downsample
    if ds>1
        if ~loPassHz
            xr = single(resample(double(xr),ds1,ds2)); % Antialiased downampling if LPF>nyquist or LPF==0
        else
            xr = xr(1:ds:end,:); % Decimate if LPF <= nyquist freq
        end
        disp("Downsampled: "+blocks(r));
    end
    xa{r} = xr;
end

%% Robust baseline correction
trIdx = grpstats(anT,["run" "trialA"],["min" "max"],"DataVars","idx"); % trial indices
trIdx = sortrows(trIdx,["min_idx" "max_idx"],"ascend");
if any(diff(trIdx.min_idx)<1) || any(diff(trIdx.max_idx)<1)
    warning("psy.trialR frame idx NOT sequentially increasing: "+sbj);
end

% Slice by trial
xa=vertcat(xa{:}); xa=xa(anT.iPsy,:,:); % Match xs & anT indices
xa = mat2cell(xa,trIdx.GroupCount);
anT = mat2cell(anT,trIdx.GroupCount);
% try detrendWts = full(~na.detrendWts); catch; detrendWts=true(size(xa,[1 2])); end
% if numel(detrendOrder)>=2 && detrendOrder(2)>0
%     detrendWts=detrendWts(anT.iPsy,:,:);
%     detrendWts = mat2cell(detrendWts,trIdx.GroupCount);
% else
%     detrendWts = cell(height(trIdx),1);
% end

% Baseline correct within-trial (robust z-score) 
parfor t = 1:height(trIdx)
    xt = fillmissing(xa{t},missingInterp,1); % Interpolate missing
    
    % Trial baseline correction (robust z-score from prestimulus baseline)
    bl = median(xt(anT{t}.pre,:,:),1,"omitnan"); % BL median
    bl0 = mad(xt(anT{t}.pre,:,:),1,1) % BL MAD median absolute deviation
    xa{t} = (xt-bl)./bl0; % Subtract median(BL) from trial then divide by mad(BL)
end
xa=vertcat(xa{:}); anT=vertcat(anT{:});
disp("FINISHED baseline correction: "+sbj);

% Interpolate baseline outliers & center at baseline mean (within-condition)
for c = 1:numel(conds)
    idx = anT.cond==conds(c) & anT.pre;
    if any(thrOLbl)
        xa(idx,:) = filloutliers(xa(idx,:),"clip","median",1,ThresholdFactor=thrOLbl); % Baseline outliers
    end
    bl = mean(xa(idx,:),1,"omitnan"); % Cleaned baseline mean
    idx = anT.cond==conds(c);
    xa(idx,:) = xa(idx,:) - bl; % Subtract by baseline mean
end
if thrOLbl>0; disp("Interpolated outliers per condition: "+blocks(r)); end
end