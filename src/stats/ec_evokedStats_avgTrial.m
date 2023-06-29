function [completeStats,completePlot,errors] = evokedStats_avgTrial(sbj,blocks,projectN,o)
% diffFromBaseline - Kevin Tan (kevmtan@ucla.edu)
% DEPENDENCIES: Matlab Statistics & Machine Learning Toolbox
% UTILITY: Finds significant differences in estimated mean values in prestimulus vs. peristimulus timepoints
% INSTRUCTIONS: use after concatBlocks (continuous non-epoched timecourses)

if 0
    %% For testing
    pathsDMN('lbcn');
    isTest = true;
    disp("TESTING");
    sbj = 'S12_38_LK'; %'S13_60_DY'; %'S12_38_LK'; %'S13_60_DY'; %'S12_42_NC';
    projectN = 'MMR';
    blocks = BlockBySubj(sbj,projectN);

    o = struct;
    o.fnString = 'evAvg_220613';
    o.band = 'rHFB';
    o.BLpre = [-.2 0]; %[-0.1 0]; % baseline before stim onset
    o.BLend = []; %[-0.1 0]; % baseline before next stim onset
    o.trL = 3.009;
    o.smWin = 0.05; % smoothing gaussian width in secs
    o.rmBadCh = true;
    o.decimate = false;
    o.fsTarg = 1000;
    o.clustSize = 0.05; % secs
    o.minAnalSize = 20;
    o.timeBins = 0.01; % secs
    o.noiseFields = {'HFO'};%{'HFO','raw_jump','diff_jump'}; % ['HFO','raw_HF_spike']
    o.outlierCenter = 'median';
    o.OLthr = 3; %[5 5]; % Lower and upper quantiles for outlier
    o.missingInterp = 'linear';
    o.k = 12; % Max Number of clustering components across timepoints
    o.bin2 = 75; % an.bin2 (reduced unique bins) must be divisible by this variable
    o.binP_max = 100;
else; isTest = false;
end

%% Initialize & load data
tic;
completeStats=0; completePlot=0; errors={};
conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"];
[server_root, comp_root, code_root, fsDir_local] = AddPaths('Kevin_DMN');
dirs = InitializeDirs(projectN, sbj, server_root, comp_root, code_root, fsDir_local);
dirIn = [dirs.data_root '/robustData/' sbj '/' projectN '/'];

% Load data
[idxBlk,wave,timesS,fsample,chNfo,trialNfo,badIdx,errorLoad] =...
    loadNeuralData(blocks,dirIn,sbj,projectN,dirs,isTest,o);
if ~isempty(errorLoad); errors{end+1} = errorLoad; end
trialNfo.condC = categorical(trialNfo.cond,conds,'Ordinal',true);

% Get number of things
sbjID = chNfo.sbjID(1);
sbjChs = chNfo.sbjCh;
numChs = size(wave,2);
numTrials = height(trialNfo);
runs = unique(trialNfo.run);

% Setup directories
dirSave = [dirs.result_root '/stats/' o.fnString '/s' num2str(sbjID) '/'];
try mkdir(dirSave); catch; end
if ~isTest; save([dirSave sbj '_misc_' o.fnString '.mat'], 'o'); end
dirDat = [dirs.result_root '/stats/' o.fnString '/dat/'];
try mkdir(dirDat); catch; end
disp(['Finished prep: ' sbj]); toc;

%% Associate timepoints with trial data
[tVec,trialNfo] = taskVectors(timesS,runs,idxBlk,numTrials,trialNfo,fsample,sbj,o);
toc;

%% Make template of data to analyze (pre-stim ITI + stimulus + post-stim ITI)
[anAll,latBins] = analysisTemplate(tVec,numTrials,trialNfo,timesS,sbj,runs,fsample,o);
toc;

%% Denoising & low-pass filter
[anAll,waveZ] =...
    noiseInterpLPF(wave,anAll,numChs,badIdx,idxBlk,runs,fsample,sbj,o);
toc;

%% Group trials with each group having 1 trial/cond
[trialNfo,anAll,r2trs,r2bin] = getRun2s(trialNfo,anAll,runs,conds,o); %#ok<ASGLU>
latTmp=table; latTmp.latency=unique(anAll.bin); latTmp.sbjID(:)=sbjID; latTmp.sbjCh(:)="";
latTmp = movevars(latTmp,["sbjID" "sbjCh"],"Before","latency");
disp([sbj ': grouped trials (1 cond/group)']); toc;

%% Free up memory & start parpool
if ~isTest
    anAll.time = [];
    anAll.latency = [];
    anAll.idx = [];
    %anAll.RTbin = [];
    %anAll.run = [];
    %anAll.BLend = [];
    %anAll.postRT=[];
    %anAll.BL=[];
    anAll.stim = [];
    %anAll.RT=[];
    save([dirSave sbj '_tVec_' o.fnString '.mat'], 'o','tVec');
    save([dirSave sbj '_anAll_' o.fnString '.mat'], 'o','anAll');
    save([dirSave sbj '_misc_' o.fnString '.mat'], 'o','chNfo','trialNfo','badIdx','errors','latBins');
    clear tVec wave
end
try parpool('local2',23); catch; end
%try parpool('local3',16); catch; end
%try parpool('local6',8); catch; end

%% Stats latency bins
latS = cell(numChs,1);
errorChBin = cell(numChs,1);
parfor ch = 1:numChs
    sbjCh = sbjChs(ch);
    an = anAll;
    an.wave = waveZ(:,ch); if ~isTest; an.idxZ=[]; end
    an = an(an.bin>=-200 & an.bin<=3000 & (an.cond=="rest"|an.RT>400),:);
    try
        an = chBinOL(an,sbjCh,conds,true,o);
        [latS{ch},errorCh] = doStatsChBin(an,sbjCh,conds,latTmp,isTest,o);
        if any(~cellfun(@isempty,errorCh))
            errorChBin{ch} = errorCh(~cellfun(@isempty,errorCh));
        end
        disp(sbjCh+": latency stats successful!"); toc;
    catch ME
        warning(sbjCh +": latency stats FAILED"); toc;
        errorChBin{ch} = {sbjCh,ME}; getReport(ME)
    end
end
if any(~cellfun(@isempty,errorChBin)); errors{end+1} = errorChBin; end

%% Percent RT
pctS = cell(numChs,1);
errorChPct = errorChBin;
parfor ch = 1:numChs
    sbjCh = sbjChs(ch);
    an = anAll;
    an.wave = waveZ(:,ch); if ~isTest; an.idxZ=[]; end
    an = an(an.cond=="rest"|an.RT>400,:);
    try
        [pctS{ch},errorCh] = doStatsChPct(an,sbjID,sbjCh,conds,isTest,o); %statsChLocFun(an,sbjCh,conds,isTest,o)
        if any(~cellfun(@isempty,errorCh))
            errorChPct{ch} = errorCh(~cellfun(@isempty,errorCh));
        end
        disp(sbjCh+": pctRT stats successful!"); toc;
    catch ME
        warning(sbjCh +": pctRT stats FAILED"); toc;
        errorChPct{ch} = {sbjCh,ME}; getReport(ME)
    end
end
if any(~cellfun(@isempty,errorChPct)); errors{end+1} = errorChPct; end
if ~isTest % cleanup
    clear anAll waveZ
end

%% Cell to table
try latS = vertcat(latS{:});
    if ~isTest; save(string(dirDat)+sbjID+"_latency_"+o.fnString+".mat","latS","-v7.3");
        disp(['Saved latS pre-FDR: ' sbj]); toc;
    end
catch ME; warning([sbj ' ERROR: vertcat(latS{:})']); errors{end+1}=ME; getReport(ME)
    completeStats = -1;
end
try pctS = vertcat(pctS{:});
    if ~isTest; save(string(dirDat)+sbjID+"_pctRT_"+o.fnString+".mat","pctS","-v7.3");
        disp(['Saved pctS pre-FDR: ' sbj]); toc;
    end
catch ME; warning([sbj ' ERROR: vertcat(pctS{:})']); errors{end+1}=ME; getReport(ME)
    completeStats = -1;
end
if ~isTest && completeStats==-1
    save([dirSave sbj '_misc_' o.fnString '_mat'], 'o','chNfo','trialNfo','badIdx','errors');
    return
end

%% FDR & organize datSTs
latS = doFDR(latS,conds,sbjID,false);
pctS = doFDR(pctS,conds,sbjID,true);
toc;

%% Slice datSTs per channel for parfor in ST metrics & plots
numChs = numel(unique(latS.sbjCh));
latC = cell(numChs,1);
pctC = latC;
for ch = 1:numChs
    sbjCh = sbjChs(ch);
    latC{ch} = latS(latS.sbjCh==sbjCh,:);
    pctC{ch} = pctS(pctS.sbjCh==sbjCh,:);
    disp("Added ch: "+sbjCh); toc;
end
if ~isTest
    clear latS pctS
end

%% Cluster correction
parfor ch = 1:numChs
    latC{ch} = clustCorrectLocal(latC{ch},conds,o);
end
completeStats = 1;
disp(['Finished cluster correction: ' sbj]); toc;

%% Plot
plotO = ecu_genPlotParams('MMR','timecourse');
plotO.textsize = 14;
if completeStats
    parfor ch = 1:numChs
        plotChLocal(latC{ch},pctC{ch},conds,dirSave,plotO,o);
    end
    completePlot = 1;
end

%% Save
latS = vertcat(latC{:});
pctS = vertcat(pctC{:});
try
    save(string(dirDat)+sbjID+"_latency_"+o.fnString+".mat","latS","-v7.3");
    save(string(dirDat)+sbjID+"_pctRT_"+o.fnString+".mat","pctS","-v7.3");
    disp(['Saved stats: ' sbj]);
catch ME
    warning(sbj+" datSTs save error")
    getReport(ME)
    errors{end+1} = ME;
    completeStats = 0.5;
end

% Save options
save([dirSave sbj '_misc_' o.fnString '_mat'], 'o','chNfo','trialNfo','badIdx','errors');
toc;
end


%% Subfunctions

function [idxBlk,wave,timesS,fsample,chNfo,trialNfo,badIdx,errorLoad] =...% loadNeuralData
    loadNeuralData(blocks,dirIn,sbj,projectN,dirs,isTest,o)
%% Load neural data

% Prep
errorLoad = {};
idxBlk = nan(length(blocks),2);

% Load
load([dirs.data_root '/originalData/' sbj '/subjVar_' sbj '.mat'], 'subjVar');
load([dirIn sbj '_trialNfo_' projectN '.mat'], 'trialNfo');
load([dirIn o.band '_' sbj '_' projectN '.mat'], 'rHFB');

% Organize
wave = rHFB.wave;
timesS = rHFB.time;
fsample = rHFB.fs_iEEG;
chNfo = rHFB.chNfo;
%trialNfo = rHFB.trialNfo;
badIdx = rHFB.badIdx;
for b = 1:length(blocks)
    if b==1
        idxBlk(b,1) = 1;
        idxBlk(b,2) = rHFB.blockEndIdx2(b);
    else
        idxBlk(b,1) = 1 + rHFB.blockEndIdx2(b-1);
        idxBlk(b,2) = rHFB.blockEndIdx2(b);
    end
end
disp([sbj ': loaded data']);

%% Warnings
if size(wave,2) ~= height(chNfo)
    errorLoad{end+1} = warning([sbj ': size(wave) ~= height(chNfo)']); end
if size(wave,2) ~= height(subjVar.labels)
    errorLoad{end+1} = warning([sbj ': size(wave) ~= height(labels)']); end
if size(wave,2) ~= height(subjVar.elinfo)
    errorLoad{end+1} = warning([sbj ': size(wave) ~= height(elinfo)']); end
if ~all(subjVar.elinfo.chan_num==chNfo.ch)
    errorLoad{end+1} = warning([sbj ': ch# mismatch chNfo vs. subjVar']);
    chNfo = chNfo(ismember(chNfo.ch,subjVar.elinfo.chan_num),:);
end
if ~all(strcmp(subjVar.labels,chNfo.FS_label))
    errorLoad{end+1} = warning([sbj ': ch label mismatch chNfo vs. subjVar']);
    chNfo = chNfo(strcmp(chNfo.FS_label,subjVar.labels), :); % Align chans
end
if size(wave,2) ~= height(chNfo)
    errorLoad{end+1} = warning([sbj ': size(wave) ~= height(chNfo) after alignment, fixing...']);
    wave = wave(:,chNfo.ch);
end

%% Get rid of bad chs
if o.rmBadCh
    disp(sbj+": removing "+nnz(~chNfo.goodChRR)+" badChs identified in preproc");
    goodChs = chNfo.ch(chNfo.goodChRR); % good channels in robust rereferencing

    if isTest
        if chNfo.sbjID(1)==60; goodChs = goodChs(96:96+22); end
        if chNfo.sbjID(1)==38; goodChs = goodChs(end-22:end); end
        if chNfo.sbjID(1)==42; goodChs = goodChs(95:95+14); end
    end

    chNfo = chNfo(goodChs,:);
    wave = wave(:,goodChs);
    badIdx = badIdx(goodChs,:);
end
end


function [tVec,trialNfo] = taskVectors(timesS,runs,idxBlk,numTrials,trialNfo,fsample,sbj,o)
%%
idx = find(~isnan(trialNfo.idxRT)); idx = idx(idx<height(trialNfo));
if nnz(trialNfo.idxRT(idx)==trialNfo.idxITI(idx+1))/height(idx) > 0.25
    idxITIadd = 1; idxITImin = 0; disp(sbj+": idxRT(t) = idxITI(t+1)");
else
    idxITIadd = 0; idxITImin = 1; disp(sbj+" NOT EQUAL: idxRT(t) & idxITI(t+1)");
end

% Convert BL time to points
idxBLpre = floor(o.BLpre * fsample);
idxBLpre = idxBLpre(1):idxBLpre(2)-1;
if ~isempty(o.BLend)
    idxBLend = floor(o.BLend * fsample);
else
    idxBLend = floor([-0.1 0] * fsample);
end
idxBLend = idxBLend(1):idxBLend(2);

% Prepare tVec
tVec = table;
tVec.time = timesS;
tVec.run(:) = uint8(0);
tVec.trialA(:) = uint16(0);
tVec.cond(:) = "";
tVec.frame(:) = int32(0);
tVec.latency(:) = nan;
tVec.pct(:) = nan;
tVec.stim(:) = false;
tVec.RT(:) = single(nan);
tVec.postRT(:) = uint16(0);
tVec.BLpre(:) = uint16(0);
tVec.BLend(:) = uint16(0);
tVec.idx(:) = uint32(1:height(tVec));
for b = 1:length(runs)
    tVec.run(idxBlk(b,1):idxBlk(b,2)) = runs(b);
end

for t = 1:numTrials
    idxStim = trialNfo.idxStim(t);
    % idxITI/
    if t==1 || trialNfo.run(t-1)~=trialNfo.run(t)
        idxITI = trialNfo.idxITI(t);
    else; idxITI = trialNfo.idxITI(t) + idxITIadd;
    end
    % IdxEnd
    if t==numTrials || trialNfo.run(t+1)~=trialNfo.run(t)
        if trialNfo.resp(t)=="none" || isundefined(trialNfo.resp(t)) || trialNfo.RT(t)==0
            idxEnd = idxStim + 15.3*fsample;
        else; idxEnd = trialNfo.idxRT(t) + 0.3*fsample;
        end
    else; idxEnd = trialNfo.idxStim(t+1)-1;
    end
    if idxEnd>idxBlk(runs==trialNfo.run(t),2); idxEnd=idxBlk(runs==trialNfo.run(t),2); end
    % idxRT
    if trialNfo.resp(t)=="none" || isundefined(trialNfo.resp(t)) || trialNfo.RT(t)==0
        if t==numTrials || trialNfo.run(t+1)~=trialNfo.run(t)
            idxRT = idxEnd;
        else; idxRT = trialNfo.idxITI(t+1) - idxITImin;
        end
    else; idxRT = trialNfo.idxRT(t);
    end
    if idxRT>idxBlk(runs==trialNfo.run(t),2); idxRT=idxBlk(runs==trialNfo.run(t),2); end
    % idxTr
    if t==numTrials || trialNfo.run(t+1)~=trialNfo.run(t)
        idxTr = idxITI:idxEnd;
    else; idxTr = idxITI:idxRT;
    end
    trialNfo.durITI(t) = timesS(idxStim) - timesS(idxITI);
    trialNfo.durTrial(t) = timesS(idxTr(end)) - timesS(idxStim);
    trialNfo.idxITI(t) = idxITI;
    trialNfo.idxRT(t) = idxRT;
    trialNfo.idxEnd(t) = idxEnd;

    % Fill
    tVec.trialA(idxTr) = trialNfo.trialA(t);
    tVec.cond(idxTr) = trialNfo.cond(t);
    tVec.latency(idxTr) = timesS(idxTr) - timesS(idxStim);
    tVec.stim(idxStim:idxRT) = true;
    tVec.RT(idxTr) = trialNfo.RT(t);
    tVec.postRT(idxRT+1:idxEnd) = trialNfo.trialA(t);
    tVec.BLpre(idxStim+idxBLpre) = trialNfo.trialA(t);
    tVec.BLend(idxEnd+idxBLend) = trialNfo.trialA(t);
    tVec.pct(idxStim:idxRT) = tVec.latency(idxStim:idxRT) ./ tVec.latency(idxRT);
    tVec.pct(idxITI:idxStim-1) = tVec.latency(idxITI:idxStim-1) ./ trialNfo.durITI(t);
    tVec.pct(idxITI:idxStim-1) = tVec.pct(idxITI:idxStim-1) ./ 10;
end
tVec.frame = int32(tVec.latency*1000);
disp(['Made task wave vectors: ' sbj]);
end


function [anAll,latBins] = analysisTemplate(tVec,numTrials,trialNfo,timesS,sbj,runs,fsample,o)
%% Analysis timepoints

% Find last trials
lastTrials = nan(height(runs),1);
for r = 1:height(runs)
    lastTrials(r) = max(trialNfo.trialA(trialNfo.run==runs(r)));
end

% Prestimulus & peristimulus analysis obs
anAll = tVec(tVec.trialA~=0|tVec.BLpre~=0,:);
anAll(ismember(anAll.postRT,lastTrials),:) = [];
anAll.pre(:) = false;
anAll.pre(anAll.frame<0) = true;
anAll.post(:) = false;

% Poststimulus analysis obs
anPost = table;
for t = 1:numTrials
    % Get indices
    if nnz(o.trL)
        tr = trialNfo.trialA(t);
        idxTrA = (trialNfo.idxStim(t) : trialNfo.idxStim(t)+(o.trL*fsample))';
        idxTrA(ismember(idxTrA, tVec.idx(tVec.trialA==tr))) = [];
        idxTrA(idxTrA>tVec.idx(end)) = [];
        idxTrA = unique([idxTrA; tVec.idx(tVec.postRT==tr)]);
    else
        idxTrA = tVec.idx(tVec.postRT==tr);
    end

    % Fill out
    anP = tVec(idxTrA,:);
    anP.trialA(:) = tr;
    anP.latency = anP.time - timesS(trialNfo.idxStim(t));
    anP.frame = int32(anP.latency*1000);
    anP.pct = anP.latency - min(anP.latency) + 1/fsample;
    anP.pct = anP.pct ./ timesS(trialNfo.idxEnd(t));
    anP.cond(:) = trialNfo.cond(t);
    anP.RT(:) = trialNfo.RT(t);
    anP.postRT(:) = tr;

    % Concactenate
    if isempty(anPost); anPost = anP;
    else; anPost = [anPost; anP]; %#ok<AGROW> 
    end
end
anPost.pre(:) = false;
anPost.post(:) = true;
anPost.pct = (anPost.pct./10)+1;
anPost.BLpre(:) = 0;

% Combine analysis timepoints
anAll = [anAll; anPost];

%% Edits
anAll.RT = uint16(anAll.RT*1000);
anAll.condC = categorical(anAll.cond,...
    ["rest" "other" "selfinternal" "selfexternal" "autobio" "math"],'Ordinal',true);

% Optimize pcts
anAll.pct = anAll.pct*1000;
anAll.pct = floor(anAll.pct./5)*5;
anAll.pct = int16(anAll.pct);
anAll.pct(anAll.pct>=0 & anAll.pre) = -5;
anAll.pct(anAll.pct>=1000 & ~anAll.post) = 995;
anAll.pct(anAll.pct<-100) = -100;
anAll.pct(anAll.pct>1095 & anAll.BLend~=0) = 1095;

% Get latency bins
bn = o.timeBins*1000;
anAll.bin = floor(double(anAll.frame)./bn)*bn;
latBins = groupcounts(anAll,["cond" "bin"]);

% Sort
anAll = sortrows(anAll,{'trialA','latency'},'ascend');
disp(['Made analysis template: ' sbj]);
end


function [anAll,waveZ] = noiseInterpLPF(waveZ,anAll,numChs,badIdx,idxBlk,runs,fsample,sbj,o)
% Bad/noise indices from preproc
if ~isempty(o.noiseFields)
    for ch = 1:numChs
        idxBadCh = badIdx{ch,o.noiseFields};
        idxBadCh = unique(vertcat(idxBadCh{:}));
        waveZ(idxBadCh,ch) = nan;
    end
end
disp(['Removed bad timepoints from preproc: ' sbj]);

% Interpolate bad timepoints & gaussian low-pass filter
gusSz = floor(fsample * o.smWin);
gusWin = gausswin(gusSz)/sum(gausswin(gusSz));
for b = 1:length(runs)
    waveZ(idxBlk(b,1):idxBlk(b,2),:) = fillmissing(waveZ(idxBlk(b,1):idxBlk(b,2),:),o.missingInterp,1); % Fill missing
    waveZ(idxBlk(b,1):idxBlk(b,2),:) = convn(waveZ(idxBlk(b,1):idxBlk(b,2),:),gusWin,'same'); % LPF
end
disp(['Interpolated bad timepoints & low-pass filtered: ' sbj]);

%% Z-score per trial
trials = unique(anAll.trialA);
waveZ = waveZ(anAll.idx,:); % order/repeat by anAll
anAll.idxZ = uint32(1:height(anAll))';
for t = 1:length(trials)
    idx = anAll.trialA==trials(t);
    waveZ(idx,:) = fillmissing(waveZ(idx,:),"linear");
    waveZ(idx,:) = zscore(waveZ(idx,:),1,1); % zscore
end
disp(['Z-scored trials: ' sbj]);

end


function [trialNfo,anAll,r2trs,r2bin] = getRun2s(trialNfo,anAll,runs,conds,o)
%% Group trials (r2) where each r2 has >1 trial/cond
r2trs = table;
for b = 1:numel(runs)
    run = runs(b);
    idx = trialNfo.run==run;

    trs = cell(6,1);
    for c = 1:numel(conds)
        idx2 = idx & trialNfo.cond==conds(c);
        %if conds(c)~="rest"
        %    idx2 = idx & trialNfo.cond==conds(c) & trialNfo.RT>0.4;
        %end
        trs{c} = trialNfo.trialA(idx2);
    end

    numRun2s = max(cellfun(@numel,trs));
    %numRun2l = min(cellfun(@numel,trs));
    r2tmp = table;
    r2tmp.r2(1:numRun2s) = uint16(0);
    r2tmp.run(:) = runs(b);
    for c = 1:numel(conds)
        cond = conds(c);
        r2tmp.(cond)(:) = uint16(0);
        for r = 1:numRun2s
            if r>numel(trs{c}); continue; end
            r2tmp.(cond)(r) = trs{c}(r);
        end
    end

    r2tmp(all(r2tmp{:,conds}==0,2),:) = [];

    if b==1
        r2trs = r2tmp;
    else
        r2trs = [r2trs; r2tmp]; %#ok<AGROW>
    end
end
r2trs.r2 = uint16(1:height(r2trs))';

trialNfo.r2(:) = uint16(0);
anAll.r2(:) = uint16(0);
for r = 1:height(r2trs)
    run2 = r2trs.r2(r);
    trialA = unique(r2trs{r,conds});
    trialNfo.r2(ismember(trialNfo.trialA,trialA)) = deal(run2);
    anAll.r2(ismember(anAll.trialA,trialA)) = run2;
end
%anAll.crb = anAll.cond+"_"+anAll.r2+"_"+anAll.bin;
anAll.ctb = anAll.cond+"_"+anAll.trialA+"_"+anAll.bin;

%% r2binA
r2binA = groupcounts(anAll,["trialA" "cond" "bin"],"IncludeMissingGroups",true,"IncludeEmptyGroups",true);
r2binA.Properties.VariableNames{'GroupCount'} = 'count';
r2binA.r2(:)=uint16(0); r2binA.RT(:)=uint16(0);
for t = 1:height(trialNfo)
    idx = r2binA.trialA==trialNfo.trialA(t) & r2binA.cond==trialNfo.cond(t);
    r2binA.r2(idx) = trialNfo.r2(t);
    r2binA.RT(idx) = trialNfo.RT(t)*1000;
end
r2binA(r2binA.r2==0,:) = [];
r2binA.crb = r2binA.cond+"_"+r2binA.r2+"_"+r2binA.bin;
r2binA.ctb = r2binA.cond+"_"+r2binA.trialA+"_"+r2binA.bin;
r2binA.condC = categorical(r2binA.cond,conds);
r2binA = sortrows(r2binA,["condC" "trialA" "bin"]);
r2binA(:,["Percent" "condC"]) = [];

%% binP & r2bin

% binP
b3 = 50; %o.bin2;
anP = anAll(anAll.post,:);
anP.binP = floor(double(anP.bin)./b3)*b3;
while numel(unique(anP.binP)) > o.binP_max
    b3 = b3 + 50;
    anP.binP = floor(anP.bin./b3)*b3;
end
anAll.binP = string(floor(double(anAll.bin)./b3)*b3);

% Prep avg
r2bin = r2binA;
r2bin = r2bin(r2bin.bin>=-200 & r2bin.bin<=3000,:); % & (avg.cond=="rest"|avg.RT>400),:);
if ~isempty(r2bin)
    r2bin.binP = string(floor(double(r2bin.bin)/b3)*b3);
    r2bin.wave(:) = nan;
end
end


function an = chBinOL(an,sbjCh,conds,doInterp,o)
if 0
    %%
    isTest = true;
    an = anAll; an.wave = waveZ(:,ch);
    an = an(an.bin>=-200 & an.bin<=3000 & (an.cond=="rest"|an.RT>400),:);
    sbjCh=sbjChs(ch); disp(sbjCh+" load an");
end
warning('off','MATLAB:table:RowsAddedExistingVars')
tic;
an.binS = string(an.bin); an.pctS = string(an.pct);

%% Outliers
idxPre = find(an.pre);
idxBL = an.BLpre~=0 & ~an.post;

% 1st baseline correction (baseline correct to find real outliers)
an.wave(idxPre) = filloutliers(an.wave(idxPre),"clip","median",1,"ThresholdFactor",5); % Preliminary pre-stim outlier removal
lme = fitlme(an(idxBL,:),'wave ~ -1 + (1|trialA)','CovariancePattern','Full',...
    'DummyVarCoding','full','FitMethod','REML','Verbose',false);
an.wave = an.wave - predict(lme,an);

% 2nd baseline correction
an.wave(idxBL) = filloutliers(an.wave(idxBL),"clip","median",1,"ThresholdFactor",3);
lme = fitlme(an(idxBL,:),'wave ~ -1 + (1|trialA)','CovariancePattern','Full',...
    'DummyVarCoding','full','FitMethod','REML','Verbose',false);
an.wave = an.wave - predict(lme,an);

% Peri- & post-stimulus outliers per task condition
for c = 1:numel(conds)
    cond = conds(c);
    idxC = find(an.cond==cond);

    % Sliding window across peristimulus latency bins
    bins = unique(an.bin(idxC));
    for f = 1:numel(bins)
        winRadius = o.smWin*o.fsTarg/2;
        binsF = bins(f)-winRadius:bins(f)+winRadius;
        idxF = idxC(ismember(an.bin(idxC),binsF));
        while nnz(~isnan(an.wave(idxF)))<50 && winRadius<=200
            winRadius = winRadius+10; % Increase window radius if not enough obs
            binsF = bins(f)-winRadius:bins(f)+winRadius;
            idxF = idxC(ismember(an.bin(idxC),binsF));
        end
        an.wave(idxF) = filloutliers(an.wave(idxF),nan,"median",1,"ThresholdFactor",o.OLthr);
    end
    olPct = nnz(isnan(an.wave(idxC)))/numel(idxC);

    % Interpolate peristimulus outliers
    if doInterp
        trials = unique(an.trialA(idxC));
        for t = 1:length(trials)
            idxF = idxC(an.trialA(idxC)==trials(t));
            an.wave(idxF) = fillmissing(an.wave(idxF),"linear");
        end
    end
    disp(sbjCh+"_"+cond+" total outliers: "+olPct+"%"); toc;
end
if 0
    %% Show heatmap of HFB
    figure('WindowStyle','Docked'); heatmap(an(an.cond=="math",:),'bin','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
    figure('WindowStyle','Docked'); heatmap(an(an.cond=="other",:),'bin','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
    figure('WindowStyle','Docked'); heatmap(an(an.cond=="autobio",:),'bin','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
    figure('WindowStyle','Docked'); heatmap(an(an.cond=="rest",:),'bin','trialA','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
end

%% Z-score per trial (remove baseline correction, lme will take care)
if doInterp
    trials = unique(an.trialA);
    for t = 1:length(trials)
        idx = an.trialA==trials(t);
        an.wave(idx) = fillmissing(an.wave(idx),"linear");
        an.wave(idx) = zscore(an.wave(idx),1,1);
    end
    disp(sbjCh+": final z-scoring of HFB per trial, starting lme...");
end
end


function [chLat,errorK] = doStatsChBin(an,sbjCh,conds,chLat,isTest,o) %#ok<INUSD> 
if 0
    isTest = true;
    an = anAll; an.wave = waveZ(:,ch);
    an = an(an.bin>=-200 & an.bin<=3000 & (an.cond=="rest"|an.RT>400),:);   
    chLat=latTmp; sbjCh=sbjChs(ch); disp(sbjCh+" load an");
    an = chBinOL(an,sbjCh,conds,true,o);
    %% Show heatmap of HFB
    figure('WindowStyle','Docked'); heatmap(an(an.cond=="math",:),'bin','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
    figure('WindowStyle','Docked'); heatmap(an(an.cond=="other",:),'bin','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
    %figure('WindowStyle','Docked'); heatmap(an(an.cond=="autobio",:),'bin','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
    %figure('WindowStyle','Docked'); heatmap(an(an.cond=="rest",:),'bin','trialA','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
end
warning('off','MATLAB:table:RowsAddedExistingVars')
tic;

%% Statistics per bin
chLME = cell(numel(conds),1);
errorK = chLME;
nCat = 3;
bins = unique(an.bin); %bins = (-205:10:3005)';
idxB = (1:nCat:numel(bins))';
for f = 2:nCat
    idxB(:,f) = idxB(:,1)+(f-1);
end
idxB(idxB>numel(bins)) = numel(bins);

% Stats loop
for c = 1:numel(conds)
    cond = conds(c); if isTest; tic; end
    idxC = find(an.cond==cond);

    % Get baseline
    anBL = an(an.cond==cond & an.BLpre~=0 & ~an.post,:);
    anBL.trialA=anBL.BLpre; anBL.binS(:)="BL";

    %% LME per latency bin
    fLME = cell(height(idxB),1);
    for f = 1:height(idxB)
        idxF = idxC(ismember(an.bin(idxC),bins(idxB(f,:))));
        dispStr = sbjCh+"_"+cond+": "+bins(idxB(f,1))+":"+bins(idxB(f,end))+" ms";
        if ~isTest; if isempty(idxF); continue; end; end
        try
            lme = fitlme([anBL; an(idxF,:)],...
                'wave ~ binS + (binS|trialA)','DummyVarCoding','reference',...
                'CovariancePattern','CompSymm','FitMethod','REML','Verbose',false,...
                'Optimizer','fminunc');
        catch
            try
                lme = fitlme([anBL; an(idxF,:)],...
                    'wave ~ binS + (binS|trialA)','DummyVarCoding','reference',...
                    'CovariancePattern','Isotropic','FitMethod','REML','Verbose',false);
            catch ME
                warning("ERROR: "+dispStr); getReport(ME)
                errorK{c} = {dispStr,ME}; continue;
            end
        end
        lme = dataset2table(lme.Coefficients);
        lme = lme(~strcmp(lme.Name,'(Intercept)'),:);
        lme.cond(:) = cond;
        fLME{f} = lme;
        if isTest; disp(dispStr+" LME"); toc; end
    end
    fLME = vertcat(fLME{:});
    fLME.q(:) = nan;
    fLME.Name = int32(str2double(extractAfter(fLME.Name,"_")));
    fLME.Properties.VariableNames{'Name'} = 'latency';

    % FDR
    disp(sbjCh+" "+cond+" latency bin FDR:"); toc;
    binMax = max(an.bin(an.cond==cond & ~an.post));
    idxAD = fLME.Estimate>0 & fLME.latency>=0 & fLME.latency<binMax;
    [~,~,~,fLME.q(idxAD)] = fdr_bh(fLME.pValue(idxAD),0.05,'dep','yes');
    idxAD = fLME.Estimate<0 & fLME.latency>=0 & fLME.latency<binMax;
    [~,~,~,fLME.q(idxAD)] = fdr_bh(fLME.pValue(idxAD),0.05,'dep','yes');
    idxAD = fLME.latency<0 | fLME.latency>=binMax;
    [~,~,~,fLME.q(idxAD)] = fdr_bh(fLME.pValue(idxAD),0.05,'dep','yes');

    chLME{c} = fLME;
end

%% Organize/save
chLME = vertcat(chLME{:});
chLME.condC = categorical(chLME.cond,conds,'Ordinal',true);
chLME = sortrows(chLME,["condC" "latency"]);

chLat(chLat.latency<-205|chLat.latency>3005,:) = [];
chLat.sbjCh(:) = sbjCh;
chLat = sortrows(chLat,'latency','ascend');

for c = 1:numel(conds)
    cond = conds(c);
    chLat.(cond+"_b")(:)=nan; chLat.(cond+"_SE")(:)=nan; chLat.(cond+"_p")(:)=nan; chLat.(cond+"_q")(:)=nan;

    idxC = find(chLME.cond==cond);
    [~,ia,ib] = intersect(chLat.latency,chLME.latency(idxC));
    ib = idxC(ib);
    chLat.(cond+"_b")(ia) = chLME.Estimate(ib);
    chLat.(cond+"_SE")(ia) = chLME.SE(ib);
    chLat.(cond+"_p")(ia) = chLME.pValue(ib);
    chLat.(cond+"_q")(ia) = chLME.q(ib);
    if c==numel(conds)
        chLat.DF(ia) = chLME.DF(ib);
    end
end

if 0
    %%
    %chLat{:,4:end}(chLat{:,4:end}==0) = nan;
    for c = 1:numel(conds); cond = conds(c); %#ok<*UNRCH>
        if c==1; figure('WindowStyle','Docked'); plot(chLat.latency,chLat.(cond+"_b")); hold on
        else; plot(chLat.latency,chLat.(cond+"_b")); end
    end
end
end


function [chPct,errorK] = doStatsChPct(an,sbjID,sbjCh,conds,isTest,o)
if 0
    %%
    isTest = true;
    an = anAll; an.wave = waveZ(:,ch);
    an = an(an.cond=="rest"|an.RT>400,:);
    sbjCh=sbjChs(ch); disp(sbjCh+" load an");
end
%try an.binS=[]; an.bin2=[]; an.pct2=[]; catch; end
warning('off','MATLAB:table:RowsAddedExistingVars')
tic;
an.binS = string(an.bin);
an.pctS = string(an.pct);
% an.pct2 = double(an.pct)/10;
% an.pct2 = string(floor(an.pct2/2)*2);

%% Outliers
idxPre = find(an.pre);
idxBL = an.BLpre~=0 & ~an.post;

% 1st baseline correction (baseline correct to find real outliers)
an.wave(idxPre) = filloutliers(an.wave(idxPre),"clip","median",1,"ThresholdFactor",5); % Preliminary pre-stim outlier removal
lme = fitlme(an(idxBL,:),'wave ~ -1 + (1|trialA)','CovariancePattern','Full',...
    'DummyVarCoding','full','FitMethod','REML','Verbose',false);
an.wave = an.wave - predict(lme,an);

% 2nd baseline correction
an.wave(idxBL) = filloutliers(an.wave(idxBL),"clip","median",1,"ThresholdFactor",3);
lme = fitlme(an(idxBL,:),'wave ~ -1 + (1|trialA)','CovariancePattern','Full',...
    'DummyVarCoding','full','FitMethod','REML','Verbose',false);
an.wave = an.wave - predict(lme,an);

% Find outliers sliding window across pcts
for c = 1:numel(conds)
    cond = conds(c);
    idxC = find(an.cond==cond & ~isnan(an.wave));

    % Sliding window across pct rt
    pcts = unique(an.pct(idxC));
    for f = 1:height(pcts)
        winRadius = 25;
        pctF = pcts(f)-winRadius:pcts(f)+winRadius;
        idxF = idxC(ismember(an.pct(idxC),pctF));
        an.wave(idxF) = filloutliers(an.wave(idxF),nan,"median",1,"ThresholdFactor",o.OLthr);
        %if isTest; disp(sbjCh+"_"+cond+" outliers: "+pcts(f)+"+/-"+winRadius+" %RT"); end
    end
    olPct = nnz(isnan(an.wave(idxC)))/numel(idxC);
    disp(sbjCh+"_"+cond+" outliers: "+olPct+"%"); toc;
end

if 0
    %% Show heatmap of HFB
    figure('WindowStyle','Docked'); heatmap(an(an.cond=="math",:),'pct','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
    figure('WindowStyle','Docked'); heatmap(an(an.cond=="other",:),'pct','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
    figure('WindowStyle','Docked'); heatmap(an(an.cond=="autobio",:),'pct','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
end

%% Z-score per trial
trials = unique(an.trialA);
for t = 1:length(trials)
    idx = an.trialA==trials(t); % & ~isnan(an.wave);
    an.wave(idx) = fillmissing(an.wave(idx),"linear");
    an.wave(idx) = zscore(an.wave(idx),1,1);
end
disp(sbjCh+": z-scored trials, starting lme %RT..."); toc;

%% Statistics per pctRT
chLME = cell(numel(conds),1); %a = groupcounts(an,["cond" "k"]);
errorK = chLME;
nCat = 2;
pcts = unique(an.pct); %(-100:5:1050)';
idxB = (1:nCat:numel(pcts))';
for f = 2:nCat
   idxB(:,f) = idxB(:,1)+(f-1);
end
idxB(idxB>numel(pcts)) = numel(pcts); %pcts2 = pcts(idxB);
%PAT = diag(true(nCat+1,1));

% Stats loop
for c = 1:numel(conds)
    cond = conds(c);
    idxC = find(an.cond==cond);

    % Get BL
    anBL = an(an.cond==cond & an.BLpre~=0 & ~an.post,:);
    anBL.trialA=anBL.BLpre; anBL.pctS(:)="BL";

    % LME per latency pct
    fLME = cell(height(idxB),1);
    for f = 1:height(idxB)
        %idxF = idxC(an.pct(idxC)==pcts(f));
        %dispStr = sbjCh+"_"+cond+": "+pcts(f)+" %RT";
        %if f==height(idxB)-1; idxF = idxC(ismember(an.pct(idxC),pcts(idxB(f:f+1,:)))); end
        idxF = idxC(ismember(an.pct(idxC),pcts(idxB(f,:))));
        dispStr = sbjCh+"_"+cond+": "+pcts(idxB(f,1))+":"+pcts(idxB(f,end))+" %RT";
        if ~isTest; if isempty(idxF); continue; end; end      
        try
            lme = fitlme([anBL; an(idxF,:)],...
                'wave ~ pctS + (pctS|trialA)','DummyVarCoding','reference',...
                'CovariancePattern','CompSymm','FitMethod','REML','Verbose',false,...
                'Optimizer','fminunc');
        catch
            try
                lme = fitlme([anBL; an(idxF,:)],...
                    'wave ~ pctS + (pctS|trialA)','DummyVarCoding','reference',...
                    'CovariancePattern','Isotropic','FitMethod','REML','Verbose',false);
            catch ME
                warning("ERROR: "+dispStr); getReport(ME)
                errorK{c} = {dispStr,ME}; continue;
            end
        end
        lme = dataset2table(lme.Coefficients);
        lme = lme(~strcmp(lme.Name,'(Intercept)'),:);
        lme.cond(:) = cond;
        fLME{f} = lme;
        if isTest; disp(dispStr); toc; end
    end
    fLME = vertcat(fLME{:});
    fLME.q = fLME.pValue;
    fLME.Name = int16(str2double(extractAfter(fLME.Name,"_")));
    fLME.Properties.VariableNames{'Name'} = 'pct';
    
    % FDR
    disp(sbjCh+" "+cond+" FDR pctRT:"); toc;
    idxAD = fLME.Estimate>0 & fLME.pct>=0 & fLME.pct<1000;
    [~,~,~,fLME.q(idxAD)] = fdr_bh(fLME.pValue(idxAD),0.05,'pdep','yes');
    idxAD = fLME.Estimate<0 & fLME.pct>=0 & fLME.pct<1000;
    [~,~,~,fLME.q(idxAD)] = fdr_bh(fLME.pValue(idxAD),0.05,'pdep','yes');
    idxAD = fLME.pct<0 | fLME.pct>=1000;
    [~,~,~,fLME.q(idxAD)] = fdr_bh(fLME.pValue(idxAD),0.05,'pdep','yes');
    chLME{c} = fLME;
end

%% Organize/save
chLME = vertcat(chLME{:});
chLME = sortrows(chLME,'pct','ascend');
chPct = table;
chPct.pct = unique(chLME.pct);
chPct.sbjID(:) = sbjID;
chPct.sbjCh(:) = sbjCh;
chPct = movevars(chPct,"pct","After","sbjCh");
chPct = sortrows(chPct,'pct','ascend');
for c = 1:numel(conds)
    cond = conds(c);
    chPct.(cond+"_b")(:)=nan; chPct.(cond+"_SE")(:)=nan; chPct.(cond+"_p")(:)=nan; chPct.(cond+"_q")(:)=nan;

    idxC = find(chLME.cond==cond);
    [~,ia,ib] = intersect(chPct.pct,chLME.pct(idxC));
    ib = idxC(ib);
    chPct.(cond+"_b")(ia) = chLME.Estimate(ib);
    chPct.(cond+"_SE")(ia) = chLME.SE(ib);
    chPct.(cond+"_p")(ia) = chLME.pValue(ib);
    chPct.(cond+"_q")(ia) = chLME.q(ib);
    if c==numel(conds)
        chPct.DF(ia) = chLME.DF(ib);
    end
end
end


function dat = doFDR(dat,conds,sbjID,isFDR)
%% FDR and organize trial info

dat.sbjID(:) = sbjID;
for c = 1:length(conds)
    cond = conds(c);
    disp(sbjID+" "+cond+": FDR");
    dat.(cond+"_hA")(:) = false;
    dat.(cond+"_hD")(:) = false;
    %dat.(cond+"_q") = dat.(cond+"_p");
    try
        dat.(cond+"_q")(dat.(cond+"_q")>1) = 1;
    catch
        %dat.(cond+"_q") = dat.(cond+"_p");
    end
    if isFDR
        [hFDR,~,~,dat.(cond+"_q")] = fdr_bh(dat.(cond+"_q"),0.05,'pdep','yes');
    else
        hFDR = dat.(cond+"_q")<0.05;
    end
    dat.(cond+"_hA")(dat.(cond+"_b")>0) = hFDR(dat.(cond+"_b")>0);
    dat.(cond+"_hD")(dat.(cond+"_b")<0) = hFDR(dat.(cond+"_b")<0);
    dat.(cond+"_q") = single(dat.(cond+"_q"));
end
end


function chLat = clustCorrectLocal(chLat,conds,o)
%% Find contiguous clusters of significance

numConds = numel(conds);
clustSz = floor(o.clustSize / o.timeBins);

for c = 1:numConds
    cond = conds(c);

    % Active
    sigs = contiguousKT(chLat.(cond+"_hA"),true);
    sigIdx = [];
    for s = 1:height(sigs)
        if sigs.sz(s)<clustSz; continue; end
        sigIdx = [sigIdx, sigs.idx(s,1):sigs.idx(s,2)]; %#ok<AGROW>
    end
    h = false(height(chLat),1);
    if ~isempty(sigIdx)
        h(sigIdx) = true;
    end
    chLat.(cond+"_hA") = h;

    % Deactive
    sigs = contiguousKT(chLat.(cond+"_hD"),true);
    sigIdx = [];
    for s = 1:height(sigs)
        if sigs.sz(s)<clustSz; continue; end
        sigIdx = [sigIdx, sigs.idx(s,1):sigs.idx(s,2)]; %#ok<AGROW>
    end
    h = false(height(chLat),1);
    if ~isempty(sigIdx)
        h(sigIdx) = true;
    end
    chLat.(cond+"_hD") = h;
end
end


function plotChLocal(chLat,chPct,conds,dirSave,plotO,o)
%%
if 0
    %%
    chLat = latC{ch};
    chPct = pctC{ch};
end
warning('off','MATLAB:Figure:UnableToSetRendererToOpenGL');
tic;

sbjCh = chLat.sbjCh(1);
numConds = numel(conds);
lineprops = struct;
lineprops.style= ':';
lineprops.width = 2;
lineprops.edgestyle = ':';

disp("FIGURE: "+sbjCh);
fig = figure('Position',[0 0 1280 1280],'MenuBar','none','ToolBar','none','visible','off');
tiledlayout(fig,2,1,'TileSpacing','compact','Padding','compact');
for ii = 1:2
    nexttile
    if ii==1
        dat = chLat;
    else
        dat = chPct;
        dat.latency = dat.pct;
    end
    lats = unique(dat.latency)';
    lats = repmat(lats,numel(conds),1);
    y = nan(numel(conds),length(lats));
    ySE = y;
    ySig = y;
    for c = 1:numConds
        cond = conds(c);
        lineprops.col{c} = plotO.col(c,:);
        idxP = find(ismember(lats(c,:),dat.latency));
        idxSig = dat.(cond+"_hA") | dat.(cond+"_hD");
        y(c,idxP) = dat.(cond+"_b");
        ySig(c,idxP) = dat.(cond+"_b");
        ySig(c,idxP(~idxSig)) = nan;
        ySE(c,idxP) = dat.(cond+"_SE");
        %mseb(pcts,y(c,:),ySE(c,:),lineprops, 1);
        %hold on
    end
    mseb(lats,y,ySE,lineprops,1);
    hold on
    axis tight
    lgd = legend(conds);
    lgd.AutoUpdate = 'off';

    for c = 1:length(conds)
        plot(lats(c,:), ySig(c,:),'LineWidth',4,'color',plotO.col(c,:));
    end
    plot([0 0],ylim,'k-','LineWidth',3)
    plot(xlim,[0 0],'k-','LineWidth',3)
    if ii==1
        title(sbjCh,'Interpreter','none');
        xlabel('Latency (ms)')
    else
        xlabel('Latency/RT (%)')
    end
    ylabel('HFB power coefficient (beta)')
    set(gca,'fontsize',plotO.textsize)
end

imgFn = dirSave+sbjCh+"_"+o.fnString+".jpg";
exportgraphics(fig,imgFn)
toc

end
