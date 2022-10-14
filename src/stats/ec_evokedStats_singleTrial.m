function [completeST,completePlot,errors] = evokedStats_singleTrial(sbj,blocks,projectN,doPlots,doDiary,o)
% diffFromBaseline - Kevin Tan (kevmtan@ucla.edu)
% DEPENDENCIES: Matlab Statistics & Machine Learning Toolbox
% UTILITY: Finds significant differences in estimated mean values in prestimulus vs. peristimulus timepoints
% INSTRUCTIONS: use after concatBlocks (continuous non-epoched timecourses)

if 0
    %% For testing
    pathsDMN('lbcn'); %#ok<UNRCH>
    isTest = true;
    disp("TESTING");
    sbj = 'S12_38_LK'; %'S12_42_NC';
    projectN = 'MMR';
    blocks = BlockBySubj(sbj,projectN);
    doPlots = true;
    doDiary = false;

    o = struct;
    o.fnString = 'evST_220527';
    o.band = 'rHFB';
    o.BLpre = [-.2 0]; %[-0.1 0]; % baseline before stim onset
    o.BLend = []; %[-0.1 0]; % baseline before next stim onset
    o.smWin = 0.025; % smoothing gaussian width in secs
    o.rmBadCh = true;
    o.decimate = false;
    o.fsTarg = 1000;
    o.clustSize = 0.05; % secs
    o.minAnalSize = 20;
    o.timeBins = 0.01; % secs
    o.noiseFields = {'HFO'};%{'HFO','raw_jump','diff_jump'}; % ['HFO','raw_HF_spike']
    o.outlierCenter = 'median';
    o.outlierThresh = 5; %[5 5]; % Lower and upper quantiles for outlier
    o.missingInterp = 'linear';
    o.k = 6; % Number of clustering components across timepoints
else; isTest = false;
end

%% Initialize & prepare for calculations
tic;
completeST = 0; completePlot = 0; errors = {};
conds = ["other" "selfinternal" "selfexternal" "autobio" "math" "rest"];

[server_root, comp_root, code_root, fsDir_local] = AddPaths('Kevin_DMN');
dirs = InitializeDirs(projectN, sbj, server_root, comp_root, code_root, fsDir_local);
dirIn = [dirs.data_root '/robustData/' sbj '/' projectN '/'];


%% Load & organize data
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

% Directories
dirSave = [dirs.result_root '/stats/' o.fnString '/s' num2str(sbjID) '/'];
try mkdir(dirSave); catch; end
if ~isTest; save([dirSave sbj '_misc_' o.fnString '.mat'], 'o','-v7.3'); % Save options
    if doDiary
        diary([dirSave sbj '_' o.fnString char(datetime('now','TimeZone','local','Format','_HHmm')) '.log']);
    end
end
disp(['Finished prep: ' sbj]);
toc;


%% Associate timepoints with trial data
datVec = taskVectors(timesS,runs,idxBlk,numTrials,trialNfo,fsample,sbj,o);
toc;


%% Make template of data to analyze (baseline + pre-ITI + stimulus + post-ITI)
[anAll,] = analysisTemplate(datVec,numTrials,trialNfo,timesS,sbj,runs,fsample,o);
anAll.RT = uint16(anAll.RT*1000);
toc;


%% Denoising & low-pass filter
[anAll,waveZ] =...
    noiseInterpLPF(wave,anAll,numChs,badIdx,idxBlk,runs,fsample,sbj,o);
toc;


%% Free up memory & start parpool
anAll.condC = categorical(anAll.cond,...
    ["rest" "other" "selfinternal" "selfexternal" "autobio" "math"],'Ordinal',true);
if ~isTest
    anAll.time = [];
    anAll.latency = [];
    anAll.idx = [];
    anAll.run = [];
    %anAll.BLend = [];
    %anAll.postRT=[];
    %anAll.BL=[];
    %anAll.stim = [];
    %anAll.RT=[];
    save([dirSave sbj '_datVec_' o.fnString '.mat'], 'o','datVec','-v7.3');
    save([dirSave sbj '_anAll_' o.fnString '.mat'], 'o','anAll','-v7.3');
    save([dirSave sbj '_misc_' o.fnString '.mat'], 'o','chNfo','trialNfo','badIdx','errors','-v7.3');
    clear datVec wave
end


%% Figure out num parfor workers given RAM use
try parpool('local2',23); catch; end
% try parpool('local2',23); catch; end
% memUse = struct2table(whos('-var','*'));
% memUse = sum(memUse.bytes);
% numWorkers = ceil(4.5e+10/memUse) %#ok<NOPRT>
% if numWorkers>23; numWorkers = 23; end
% if numWorkers<8; numWorkers = 8; end
% try
%     if isTest
%         parpool('local2',23); %#ok<UNRCH>
%     elseif numWorkers>13
%         parpool('local2',numWorkers);
%     elseif numWorkers>9
%         parpool('local3',numWorkers);
%     elseif numWorkers>7
%         parpool('local4',numWorkers);
%     else
%         parpool('local8',numWorkers);
%     end
% catch
% end


%% Statistical analysis
datSTs = cell(numChs,1);
errorChs = cell(numChs,1);
parfor ch = 1:numChs
    %%
    an = anAll;
    an.wave = waveZ(:,ch);
    sbjCh = sbjChs(ch);
    try
        [datSTs{ch},errorK] = doStatsChLocal(an,sbjCh,conds,isTest,o); %statsChLocFun(an,sbjCh,conds,isTest,o)
        if any(~cellfun(@isempty,errorK))
            errorChs{ch} = errorK(~cellfun(@isempty,errorK));
        end
        disp(sbjCh+": lme successful!");
    catch ME
        warning(sbjCh +": STATS FAILED");
        errorChs{ch} = {sbjCh,ME};
        getReport(ME)
    end
end
if any(~cellfun(@isempty,errorChs))
    errors{end+1} = errorChs(~cellfun(@isempty,errorChs));
end
if ~isTest
    clear anAll waveZ
end

% Cell to table
try datSTs = vertcat(datSTs{:});
    if ~isTest
        save([dirSave sbj '_' o.fnString '.mat'],'datSTs','-v7.3');
        disp(['Saved datSTs: ' sbj]); toc;
    end
catch ME
    warning([sbj ' ERROR: vertcat(datSTs{:})']); errors{end+1} = ME;
    getReport(ME)
    if ~isTest
        save([dirSave sbj '_' o.fnString '_misc.mat'], 'o','chNfo','trialNfo','badIdx','errors','-v7.3');
        return
    end
end


%% FDR & organize datSTs
datSTs = doFDR(datSTs, trialNfo, numTrials, sbj);
toc;


%% Slice datSTs per channel for parfor in ST metrics & plots
numChs = numel(unique(datSTs.sbjCh));
datSTcell = cell(numChs,1);
for ch = 1:numChs
    sbjCh = sbjChs(ch);
    datSTcell{ch} = datSTs(datSTs.sbjCh==sbjCh,:);
    disp("Added ch: "+sbjCh);
end
if ~isTest
    clear datSTs
end


%% Cluster correction & single-trial metrics
[datMs,datSTcell] = getSTmetrics(datSTcell,trialNfo,chNfo,numTrials,o);
save([dirSave sbj '_' o.fnString '_M.mat'], 'datMs','-v7.3');
completeST = 1;
toc;
if ~isTest; try delete(gcp('nocreate')); catch; end; end


%% Save
dirDat = [dirs.result_root '/stats/' o.fnString '/dat/'];
try mkdir(dirDat); catch; end

% Save stats
if ~isempty(datSTcell)
    for ch = 1:numChs
        sbjCh = chNfo(ch,:).sbjCh;
        chST = datSTcell{ch};
        try save(dirDat+sbjCh+"_"+o.fnString+".mat","chST","-v7.3");
            disp("SAVED: "+sbjCh);
        catch ME
            warning(sbj+" datSTs save error"); errors{end+1} = ME; %#ok<AGROW>
            getReport(ME)
            completeST = 0.5;
        end
    end
    if completeST==1
        delete([dirSave sbj '_' o.fnString '.mat']);
    end
    disp(['Saved stats: ' sbj]);
end
save([dirSave sbj '_' o.fnString '_misc.mat'], 'o','chNfo','trialNfo','badIdx','errors','-v7.3');
toc


%% Plot
if doPlots && completeST~=0
    try parpool('local4',12); catch; end
    errorPlot = cell(numChs,1);

    parfor ch = 1:numChs
        sbjCh = chNfo(ch,:).sbjCh;
        try
            plotChLocal(datSTcell{ch},conds,dirSave,isTest,o);
            disp(sbjCh+": plot successful!");
        catch ME
            warning(sbjCh +": PLOT FAILED"); errorPlot{ch} = ME;
            getReport(ME)
        end
    end
    if any(~cellfun(@isempty,errorPlot))
        errors{end+1} = vertcat(errorPlot{:});
        completePlot = 0.5;
    else
        completePlot = 1;
        disp(sbj+" plotted all channels!");
    end

    % Save errors
    save([dirSave sbj '_' o.fnString '_misc.mat'], 'o','chNfo','trialNfo','badIdx','errors','-v7.3');
    toc
end
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
        %goodChs = goodChs(1:15);
        %goodChs = goodChs(95:95+14);
        %goodChs = goodChs(end-22:end);
    end

    chNfo = chNfo(goodChs,:);
    wave = wave(:,goodChs);
    badIdx = badIdx(goodChs,:);
end
end


function datVec = taskVectors(timesS,runs,idxBlk,numTrials,trialNfo,fsample,sbj,o)
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

% Prepare datVec
datVec = table;
datVec.time = single(timesS);
datVec.run(:) = uint8(0);
datVec.trialA(:) = uint16(0);
datVec.cond(:) = "";
datVec.frame(:) = int32(0);
datVec.latency(:) = nan;
datVec.pct(:) = nan;
datVec.stim(:) = false;
datVec.RT(:) = single(nan);
datVec.postRT(:) = uint16(0);
datVec.BLpre(:) = uint16(0);
datVec.BLend(:) = uint16(0);
datVec.idx(:) = uint32(1:height(datVec));
for b = 1:length(runs)
    datVec.run(idxBlk(b,1):idxBlk(b,2)) = runs(b);
end

ITIdur = nan(numTrials,1);
for t = 1:numTrials
    % Get indices
    idxStim = trialNfo.idxStim(t);
    idxITI = trialNfo.idxITI(t) + idxITIadd;
    idxEnd = trialNfo.idxEnd(t);
    idxRT = trialNfo.idxRT(t);
    % idxEnd
    if t==numTrials || trialNfo.run(t+1)~=trialNfo.run(t)
        %idxEnd = idxEnd + floor(0.3*fsample);
        %if idxEnd > idxBlk(runs==trialNfo.run(t),2)
        %    idxEnd = idxBlk(runs==trialNfo.run(t),2);
        %end
    elseif t==1 || trialNfo.run(t-1)~=trialNfo.run(t)
        idxITI = trialNfo.idxITI(t);
    end
    % idxRT
    if trialNfo.resp(t)=="none" || isundefined(trialNfo.resp(t)) || trialNfo.RT(t)==0
        if t==numTrials || trialNfo.run(t+1)~=trialNfo.run(t)
            idxRT = idxEnd;
        else
            idxRT = trialNfo.idxITI(t+1) - idxITImin;
            datVec.postRT(idxRT+1:idxEnd) = trialNfo.trialA(t);
        end
    else
        datVec.postRT(idxRT+1:idxEnd) = trialNfo.trialA(t);
    end
    if t==numTrials || trialNfo.run(t+1)~=trialNfo.run(t)
        idxTr = idxITI:idxEnd;
    else
        idxTr = idxITI:idxRT;
    end
    ITIdur(t) = timesS(idxStim) - timesS(idxITI);

    % Fill
    datVec.trialA(idxTr) = trialNfo.trialA(t);
    datVec.cond(idxTr) = trialNfo.cond(t);
    datVec.latency(idxTr) = timesS(idxTr) - timesS(idxStim);
    datVec.stim(idxStim:idxRT) = true;
    datVec.RT(idxTr) = trialNfo.RT(t);
    %datVec.postRT(idxRT+1:idxEnd) = trialNfo.trialA(t); (done above)
    datVec.BLpre(idxStim+idxBLpre) = trialNfo.trialA(t);
    datVec.BLend(idxEnd+idxBLend) = trialNfo.trialA(t);
    datVec.frame(idxITI:idxStim-1) = -flip(1:length(idxITI:idxStim-1));
    datVec.frame(idxStim:idxTr(end)) = 0:length(idxStim:idxTr(end))-1;
    datVec.pct(idxStim:idxRT) = datVec.latency(idxStim:idxRT) ./ datVec.latency(idxRT);
    datVec.pct(idxITI:idxStim-1) = datVec.latency(idxITI:idxStim-1) ./ ITIdur(t);
    datVec.pct(idxITI:idxStim-1) = datVec.pct(idxITI:idxStim-1) ./ 20;
end
disp(['Made task wave vectors: ' sbj]);
end


function [anAll,latBins] = analysisTemplate(datVec,numTrials,trialNfo,timesS,sbj,runs,fsample,o)
%% Analysis timepoints

% Find last trials
lastTrials = nan(height(runs),1);
for r = 1:height(runs)
    lastTrials(r) = max(trialNfo.trialA(trialNfo.run==runs(r)));
end

% Add times to analyze
anAll = datVec(datVec.trialA~=0|datVec.BLpre~=0,:);
anAll(ismember(anAll.postRT,lastTrials),:) = [];
anAll.pre(:) = false;
anAll.pre(anAll.frame<0) = true;
anAll.post(:) = false;

% Post stim timepoints to analyze
anPost = datVec(datVec.postRT~=0, :);
anPost.trialA = anPost.postRT;
for t = 1:numTrials
    idxT = anPost.trialA==trialNfo.trialA(t);
    anPost.RT(idxT) = trialNfo.RT(t);
    anPost.cond(idxT) = trialNfo.condC(t);
    anPost.frame(idxT) = int32(1:nnz(idxT)) + max(anAll.frame(anAll.trialA==t & anAll.postRT==0));
    anPost.latency(idxT) = timesS(anPost.idx(idxT)) - timesS(trialNfo.idxStim(t));
    anPost.pct(idxT) = anPost.latency(idxT) - min(anPost.latency(idxT)) + 1/fsample;
    anPost.pct(idxT) = anPost.pct(idxT) ./ (nnz(idxT)/fsample);
end
anPost.pre(:) = false;
anPost.post(:) = true;
anPost.pct = anPost.pct ./ 20;
anPost.pct = anPost.pct + 1;
anAll = [anAll; anPost];

% Fix pct
anAll.pct = anAll.pct*1000;
anAll.pct = floor(anAll.pct./5)*5;
anAll.pct = int16(anAll.pct);
anAll.pct(anAll.pct>=0 & anAll.pre) = -5;
anAll.pct(anAll.pct>=1000 & ~anAll.post) = 995;

% Get latency bins
bn = o.timeBins*1000;
latMin = floor(min(anAll.frame)/5)*5 - 5;
latMax = ceil(max(anAll.frame)/5)*5 + 5;
latBins = latMin:bn:latMax; %[latMin:o.timeBins:-1/fsample, 0:o.timeBins:latMax];

% Get proper bins
anAll.bin(:) = int32(0);
for f = 2:length(latBins)
    latf = [latBins(f-1), latBins(f)];
    idx = find(anAll.frame>=latf(1) & anAll.frame<latf(2));
    anAll.bin(idx) = median(latf);
end

% Get final latency bins

anAll = sortrows(anAll,{'trialA','latency'},'ascend');
latBins = groupcounts(anAll,'bin');

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

% %% Remove outliers per bin
% % Z-score (to get better outliers, temporary)
% datVec.pct = int16(datVec.pct*100);
% wave2 = waveZ; %(datVec.idx,:); % Order/repeat by anAll
% for t = 1:length(trials)
%     idx = datVec.trialA==trials(t);
%     wave2(idx,:) = zscore(wave2(idx,:),0,1);
% end
%
% % Outlier per pct (%RT)
% for c = 1:numel(conds)
%     idxC = datVec.idx(datVec.cond==conds(c));
%     latCond = groupcounts(datVec(idxC,:),'pct');
%     for f = 1:height(latCond)
%         idx = idxC(datVec.pct(idxC)==latCond.pct(f));
%         waveTmp = wave2(idx,:);
%         idxOL = isoutlier(waveTmp,o.outlierCenter,1,'ThresholdFactor',o.outlierThresh);
%         waveTmp = waveZ(idx,:);
%         waveTmp(idxOL) = nan;
%         waveTmp = fillmissing(waveTmp,o.missingInterp,1);
%         waveZ(idx,:) = waveTmp;
%     end
% end
% clear wave2
% disp(['Found outliers: ' sbj]);

%% Interpolate bad timepoints & gaussian low-pass filter
winSize = floor(fsample * o.smWin);
gusWin = gausswin(winSize)/sum(gausswin(winSize));
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
    waveZ(idx,:) = zscore(waveZ(idx,:),0,1); % zscore
end
disp(['Z-scored trials: ' sbj]);

end


function [chStats,errorK] = doStatsChLocal(an,sbjCh,conds,isTest,o)
%% Prep
if 0
    %%
    an = anAll; %#ok<UNRCH>
    an.wave = waveZ(:,ch);
    sbjCh = sbjChs(ch); disp(sbjCh+" load an")
end
tic;
% Useful variables
numConds = numel(conds);
an.binS = string(an.bin);
an.pctS = string(an.pct);
an.bin2 = string(floor((double(an.bin)/10)/5));
an.pct2 = floor(double(an.pct)/10);
an.pct2 = floor(an.pct2/2)*2;
%an.pct2(an.pct2>104)=104; an.pct2(an.pct2<-5)=-5;
an.pct2 = string(an.pct2);
an.trialBin = string(an.trialA)+"_"+string(an.bin);
% an.RTbin = double(an.bin)-double(an.RT);
% an.RTbin = string(round(an.RTbin./10)*10);

% Get channel summary stats
chStats = grpstats(an,{'trialA','bin','binS','cond'},'mean','DataVars',{'wave','pct','RT'});
chStats.Properties.RowNames = {};
chStats.Properties.VariableNames{'GroupCount'} = 'count';
chStats.Properties.VariableNames{'bin'} = 'latency';
chStats.Properties.VariableNames{'mean_wave'} = 'wave';
chStats.Properties.VariableNames{'mean_pct'} = 'pct';
chStats.Properties.VariableNames{'mean_RT'} = 'RT';
chStats.pct = int16(chStats.pct);
chStats.RT = uint16(chStats.RT);
chStats.trialBin = string(chStats.trialA)+"_"+string(chStats.latency);

%% Robust baseline correction

% Preliminary baseline correction
idxBL = an.idxZ(an.pre);
an.wave(idxBL) = filloutliers(an.wave(idxBL),nan,"median",1,"ThresholdFactor",3);
lme = fitlme(an(idxBL,:),'wave ~ 1 + (1|trialA)','CovariancePattern','Full',...
    'DummyVarCoding','effects','FitMethod','REML','Verbose',false);
an.wave = an.wave - predict(lme,an);

% Pre-stimulus outlier removal
idxBL = an.idxZ(an.pre & ~isnan(an.wave));
lme = fitlm(an(idxBL,:),'wave ~ condC+pct2','RobustOpts','on','DummyVarCoding','effects');
idxOL = idxBL(isoutlier(lme.Residuals.Raw,'median',1,'ThresholdFactor',2.75));
an.wave(idxOL) = nan;
if isTest; disp(lme); end

% Fill in outliers
idxBL = an.idxZ(an.pre);
lme = fitlme(an(idxBL,:),'wave ~ condC + pct2 + (pct2|trialA)','CovariancePattern','Full',...
    'DummyVarCoding','effects','FitMethod','REML','Verbose',false); %'wave ~ cond+pctS + (pctS|trialA)'
idxOL = idxBL(isnan(an.wave(idxBL)));
an.wave(idxOL) = predict(lme,an(idxOL,:));

% Final baseline correction
lme = fitlme(an(idxBL,:),'wave ~ condC-1 + (1|trialA)','CovariancePattern','Full',...
    'DummyVarCoding','full','FitMethod','REML','Verbose',false);
an.wave = an.wave - predict(lme,an);

disp(sbjCh+": robust baseline corrected"); toc;
if isTest; disp(lme); end

%% Cluster latency bins

% Extract mean HFB of bins
lme = grpstats(an,{'trialA','bin','binS','cond'},'mean','DataVars','wave');
if any(lme.trialA~=chStats.trialA) || any(lme.bin~=chStats.latency)
    warning(sbjCh+": chStats ~= chStats2");
end
chStats.b = lme.mean_wave;
chStats.b(chStats.b==0) = nan;

% Interpolate any nans/zeros in chStats
trs = unique(chStats.trialA);
for t = 1:numel(trs)
    idx = chStats.trialA==trs(t);
    chStats.b(idx) = fillmissing(chStats.b(idx),'linear',1);
end

% If remaining nans/zeros
idxOL = isnan(chStats.b);
if nnz(idxOL)>0
    cOL = unique(chStats.cond(idxOL));
    for c = 1:numel(cOL)
        idx = ismember(chStats.binS(chStats.cond==cOL(c)),unique(chStats.binS(idxOL & chStats.cond==cOL(c))));
        lme = fitlme(chStats(idx,:),'b ~ binS-1 + (binS-1|trialA)','CovariancePattern','Full',...
            'DummyVarCoding','full','FitMethod','REML','Verbose',false);
        chStats.b(idxOL) = predict(lme,chStats(idxOL,:));
    end
    disp(sbjCh+": predicted remaining "+numel(idxOL)+" NaNs for clustering");
end
if any(isnan(chStats.b))
    [chStats.b,idxOL] = fillmissing(chStats.b,"linear",1);
    warning(sbjCh+" last ditch interpolation of "+nnz(idxOL)+" NaNs for clustering");
end

% Clusterize latency bins
lme = cell(o.k,1);
kBIC = nan(o.k,1);
for k = 1:o.k
    try
        lme{k} = fitgmdist(chStats.b,k,'RegularizationValue',0.001);
        kBIC(k) = lme{k}.BIC;
    catch
    end
end
[kBICmin,k] = min(kBIC);
chStats.k = uint8(cluster(lme{k},chStats.b));

% Save k to an
an.k(:) = uint8(0);
for k = uint8(1:Kopt)
    idx = ismember(an.trialBin,chStats.trialBin(chStats.k==k));
    an.k(idx) = k;
end
disp(sbjCh+" optimal clustering: k="+k+" BIC="+kBICmin);

%% Peri- & post-stimulus outliers in analysis data
pcts = [0 299; 300 599; 600 899; 900 max(an.pct)]; %[0 249; 250 499; 500 749; 750 899; 900 max(an.pct)];
nCat = 10;

for c = 1:numConds
    cond = conds(c); if isTest; disp("Outliers: "+sbjCh+" "+cond); end
    idxC = an.idxZ(an.cond==cond & ~an.pre & ~isnan(an.wave));
    %     % Per pct
    %     for f = 1:height(pcts)
    %         idxF = idxC(ismember(an.pct(idxC),pcts(f,1):pcts(f,2)));
    %         try
    %             if f==height(pcts) || cond=="rest"
    %                 lme = fitlm(an(idxF,:),'wave ~ pct2','RobustOpts','on','DummyVarCoding','reference');
    %             else
    %                 lme = fitlm(an(idxF,:),'wave ~ bin2+pct2','RobustOpts','on','DummyVarCoding','reference');
    %             end
    %         catch ME
    %             warning("ERROR outlier detection: "+sbjCh+" "+cond); getReport(ME)
    %             continue
    %         end
    %         an.wave(idxF(isoutlier(lme.Residuals.Raw,'ThresholdFactor',o.outlierThresh))) = nan;
    %     end
    %     disp("Outliers: "+sbjCh+" "+cond); toc
    
    % Per pct
    if cond~="rest"
        for f = 1:height(pcts)
            idxF = idxC(ismember(an.pct(idxC),pcts(f,1):pcts(f,2)));
            lme = fitlm(an(idxF,:),'wave ~ pct2','RobustOpts','on','DummyVarCoding','effects');
            an.wave(idxF(isoutlier(lme.Residuals.Raw,'ThresholdFactor',o.outlierThresh))) = nan;
        end
    end

    % Group latency bins
    if cond~="rest"
        idxC = an.idxZ(an.cond==cond & ~an.pre & ~an.post & ~isnan(an.wave));
    end
    bins = unique(an.bin2(idxC));
    idxB = (1:nCat:numel(bins))';
    for f = 2:nCat
        idxB(:,f) = idxB(:,1)+(f-1);
    end
    idxB(idxB>numel(bins)) = numel(bins);

    % Per latency bin
    for f = 1:height(idxB)-1
        if f==height(idxB)-1
            idxF = idxC(ismember(an.bin2(idxC),bins(idxB(f:f+1,:))));
        else
            idxF = idxC(ismember(an.bin2(idxC),bins(idxB(f,:))));
        end
        lme = fitlm(an(idxF,:),'wave ~ bin2','RobustOpts','on','DummyVarCoding','reference');
        an.wave(idxF(isoutlier(lme.Residuals.Raw,'ThresholdFactor',o.outlierThresh))) = nan;
    end
end

% Find k's with not enough obs & label as most similar k
tmp = grpstats(an,"k",["mean" "numel"],"DataVars","wave");
Knan = find(tmp.numel_wave<o.minAnalSize);
if ~isempty(Knan)
    tmp2 = grpstats(chStats,"k","mean","DataVars","b");
    for k = 1:numel(Knan)
        tmp2.diff = abs(tmp2.mean_b-tmp2.mean_b(Knan(k)));
        tmp2.diff(Knan(k)) = nan;
        [~,idx] = min(tmp2.diff); idx = uint8(idx);
        chStats.k(chStats.k==Knan(k)) = idx;
        an.k(an.k==Knan(k)) = idx;
    end
end
disp(sbjCh+": removed peri- & post-stimulus outliers"); toc;
% figure('WindowStyle','Docked'); heatmap(chStats(chStats.cond=="other",:),'latency','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
% figure('WindowStyle','Docked'); heatmap(an(an.cond=="math",:),'bin','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
% figure('WindowStyle','Docked'); heatmap(an(an.cond=="other",:),'bin','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);

%% Stats per cluster
Ks = unique(chStats.k);
chLME = cell(numel(Ks),1);
errorK = cell(numel(Ks),1);
for k = 1:numel(Ks)
    K = Ks(k);
    idxK = chStats.k==K; %uint8(k);
    idxAn = an.idxZ(ismember(an.trialBin,chStats.trialBin(idxK)));
    dispStr = sbjCh+" k="+K;
    if numel(idxAn)<o.minAnalSize; warning("minAnalSize "+dispStr); continue; end

    %% do LME
    try
        lme = fitlme(an(idxAn,:),'wave ~ -1 + (1|bin:trialA)','CovariancePattern','Full',...
            'DummyVarCoding','full','FitMethod','REML','Verbose',false); %,'Optimizer','fminunc');
    catch ME
        try
            lme = fitlme(an(idxAn,:),'wave ~ -1 + (1|bin:trialA)','CovariancePattern','Isotropic',...
                'DummyVarCoding','full','FitMethod','REML','Verbose',false);
        catch
            warning("ERROR: "+dispStr);
            errorK{k} = {dispStr,ME};
            getReport(ME)
            continue
        end
    end

    % Organize random effects output
    [~,~,lme] = randomEffects(lme); lme = dataset2table(lme);
    lme(:,["Group" "tStat" "DF" "Lower" "Upper"]) = [];
    lme.Level = string(lme.Level);
    lme.Name = extractBefore(lme.Level," ");
    lme.Level = extractAfter(lme.Level," ");
    lme.Properties.VariableNames{'Level'} = 'trialA';
    lme.Properties.VariableNames{'Name'} = 'latency';
    lme.SEPred = single(lme.SEPred);
    %     lme = fitlme(an(idxAn,:),'wave ~ -1 + (binS-1|trialA)','CovariancePattern','CompSymm',...
    %             'DummyVarCoding','full','FitMethod','REML','Verbose',false); %,'Optimizer','fminunc');
    %     [~,~,lme] = randomEffects(lme); lme = dataset2table(lme);
    %     lme(:,["Group" "tStat" "DF" "Lower" "Upper"]) = [];
    %     lme.Name = string(lme.Name);
    %     lme.Name = extractAfter(lme.Name,"_");
    %     lme.Level = string(lme.Level);
    %     lme.SEPred = single(lme.SEPred);
    %     lme.Properties.VariableNames{'Level'} = 'trialA';
    %     lme.Properties.VariableNames{'Name'} = 'latency';
    %     lme.trialBin = lme.trialA+"_"+lme.latency;
    %     lme = lme(ismember(lme.trialBin,chStats.trialBin(idxK)),:);

    % FDR
    disp(dispStr);
    [~,~,~,lme.q] = fdr_bh(lme.pValue,0.05,'dep','yes'); toc;

    % Save
    chLME{k} = lme;
end

%% Organize/save stats output
chLME = vertcat(chLME{:});
chLME.trialBin = chLME.trialA+"_"+chLME.latency;
chLME.trialA = uint16(str2double(chLME.trialA));
chLME.latency = int32(str2double(chLME.latency));
chLME = sortrows(chLME,{'trialA','latency'},"ascend");
chStats = sortrows(chStats,{'trialA','latency'},"ascend");

% Align lme & chStats
[~,ia,ib] = intersect(chStats.trialBin,chLME.trialBin,"rows","stable");

% Transfer data
chStats.b = [];
chStats.b(ia) = chLME.Estimate(ib);
chStats.SE(ia) = chLME.SEPred(ib);
chStats.p(ia) = chLME.pValue(ib);
chStats.q(ia) = chLME.q(ib);
chStats.sbjCh(:) = sbjCh;
if ~isTest
    chStats(:,["binS" "trialBin"]) = [];
    chStats.count = uint8(chStats.count);
end

% figure('WindowStyle','Docked'); heatmap(chStats(chStats.cond=="math" & chStats.q<0.05,:),'latency','RT','ColorVariable','b','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
% figure('WindowStyle','Docked'); heatmap(an(an.cond=="other",:),'frame','RT','ColorVariable','wave','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
% figure('WindowStyle','Docked'); heatmap(chStats(chStats.cond=="other",:),'latency','RT','ColorVariable','b','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);

end


function datSTs = doFDR(datSTs,trialNfo,numTrials,sbj)
%% FDR and organize trial info

datSTs.hA(:) = false; datSTs.hD(:) = false;
datSTs.q(datSTs.q>1) = 1;

[hFDR,~,~,datSTs.q] = fdr_bh(datSTs.q,0.05,'dep','yes');
datSTs.hA(datSTs.b>0) = hFDR(datSTs.b>0);
datSTs.hD(datSTs.b<0) = hFDR(datSTs.b<0);
datSTs.q = single(datSTs.q);

% Add trial info
try datSTs.RT = []; catch; end
try datSTs.cond = []; catch; end
datSTs.cond(:) = "";
datSTs.sbjID(:) = trialNfo.sbjID(1);
datSTs.run(:) = uint8(nan);
datSTs.trial(:) = uint16(nan);
datSTs.RT(:) = nan;
datSTs = movevars(datSTs, {'sbjCh','cond','latency','trialA','RT'}, 'Before', 'wave');
datSTs = movevars(datSTs,{'b','SE','p','q','hA','hD','k','count'}, 'Before', 'sbjID');
for t = 1:numTrials
    idx = datSTs.trialA==trialNfo.trialA(t);
    datSTs.cond(idx) = trialNfo.cond(t);
    datSTs.RT(idx) = trialNfo.RT(t);
    datSTs.run(idx) = trialNfo.run(t);
    datSTs.trial(idx) = trialNfo.trial(t);
end
disp(sbj+": Finished all-ch FDR");
end


function [datMs,datSTcell] = getSTmetrics(datSTcell,trialNfo,chNfo,numTrials,o)
%% Find contiguous significant clusters & get single-trial evoked response metrics
fieldsAct = ["a15" "a50" "a85" "meanA" "onsA" "onsA_b" "onsA_p" "sA" "sA_b" "sA_p" "pkA" "pkA_b" "pkA_p" "offA" "offA_b" "offA_p" "durA","aucA" "pctA"];
fieldsDea = ["d15" "d50" "d85" "meanD" "onsD" "onsD_b" "onsD_p" "sD" "sD_b" "sD_p" "pkD" "pkD_b" "pkD_p" "offD" "offD_b" "offD_p" "durD" "aucD" "pctD"];
fieldsMS = [fieldsAct([1:5 8 11 14]) fieldsDea([1:5 8 11 14])];
fieldsCh = ["sbjCh","Yeo7s","lobe","DK_ind","Destr_ind","grad1","grad1s","refCh","epiCh","emptyCh","noisyCh","goodChRR","FS_label","ch"];
fieldsTr = string(trialNfo.Properties.VariableNames);
fieldsRm = ["durITI" "durTrial"	"onsITI" "onsStim" "onsRT" "idxITI" "idxStim" "idxRT" "idxEnd"];
fieldsTr(ismember(fieldsTr,fieldsRm)) = [];

clustSz = floor(o.clustSize / o.timeBins);
numChs = height(datSTcell);

% Make template for ST metric results
Mtmp = table;
Mtmp(1:height(trialNfo),fieldsAct) = {nan};
Mtmp(:,fieldsDea) = {nan};
Mtmp(:,fieldsTr) = trialNfo(:,fieldsTr);
datMs = cell(numChs,1);
%%
parfor ch = 1:numChs
    %% Channel
    ch1Nfo = chNfo(ch,:);
    disp("Single-trial metrics: "+ch1Nfo.sbjCh);
    datCh = datSTcell{ch};
    datCh = sortrows(datCh,{'trialA','latency'},'ascend');

    Mch = Mtmp;
    Mch(:,fieldsCh) = repmat(ch1Nfo(1,fieldsCh),height(Mch),1);

    for t = 1:numTrials
        %% Trial analyses
        tIdx = find(datCh.trialA==trialNfo.trialA(t)); %#ok<*PFBNS>
        tLats = double(datCh.latency(tIdx));

        % Get significant clusters (active)
        hA = datCh.hA(tIdx);
        sigs = contiguousKT(hA,1); % figure out clusters
        sigC = find(sigs.sz > clustSz);
        % Find sig clust idx
        hA(:) = false; %fill below
        sigIdx = [];
        for s = 1:length(sigC)
            sigIdx = [sigIdx, sigs.idx(sigC(s),1):sigs.idx(sigC(s),2)];
        end
        hA(sigIdx) = true;
        datCh.hA(tIdx) = hA;

        % Get significant clusters (deactive)
        hD = datCh.hD(tIdx);
        sigs = contiguousKT(hD,1); % figure out clusters
        sigC = find(sigs.sz > clustSz);
        % Find sig clust idx
        hD(:) = false; %fill below
        sigIdx = [];
        for s = 1:length(sigC)
            sigIdx = [sigIdx, sigs.idx(sigC(s),1):sigs.idx(sigC(s),2)];
        end
        hD(sigIdx) = true;
        datCh.hD(tIdx) = hD;

        %% Activation metrics
        if nnz(hA)
            idx = tIdx(hA);
            Mch.onsA(t) = datCh.latency(idx(1));
            Mch.onsA_b(t) = datCh.b(idx(1));
            Mch.onsA_p(t) = datCh.q(idx(1));

            P = prctile(tLats(hA),[15 50 85]);
            Mch.a15(t) = P(1);
            Mch.a50(t) = P(2);
            Mch.a85(t) = P(3);
            Mch.meanA(t) = mean(tLats(hA),'omitnan');

            Mch.durA(t) = length(idx) * o.timeBins;
            Mch.aucA(t) = (sum(datCh.b(idx))) * o.timeBins;
            Mch.pctA(t) = nnz(hA) / length(hA);

            idx = tIdx(hA & tLats>0);
            if ~isempty(idx)
                Mch.sA(t) = datCh.latency(idx(1));
                Mch.sA_b(t) = datCh.b(idx(1));
                Mch.sA_p(t) = datCh.q(idx(1));

                Mch.offA(t) = datCh.latency(idx(end));
                Mch.offA_b(t) = datCh.b(idx(end));
                Mch.offA_p(t) = datCh.q(idx(end));
            end
        end
        if max(datCh.b(tIdx)) > 0
            idx = ismembertol(datCh.b(tIdx),max(datCh.b(tIdx(hA & tLats>0))));
            if ~nnz(idx); idx = ismembertol(datCh.b(tIdx),max(datCh.b(tIdx(tLats>0)))); end
            if ~nnz(idx); idx = ismembertol(datCh.b(tIdx),max(datCh.b(tIdx(hA)))); end
            if ~nnz(idx); idx = ismembertol(datCh.b(tIdx),max(datCh.b(tIdx))); end
            Mch.pkA(t) = mean(tLats(idx),'omitnan');
            Mch.pkA_b(t) = mean(datCh.b(tIdx(idx)),'omitnan');
            Mch.pkA_p(t) = mean(datCh.q(tIdx(idx)),'omitnan');
        end

        %% Deactivation metrics
        if nnz(hD)
            idx = tIdx(hD);
            Mch.onsD(t) = datCh.latency(idx(1));
            Mch.onsD_b(t) = datCh.b(idx(1));
            Mch.onsD_p(t) = datCh.q(idx(1));

            P = prctile(tLats(hD),[15 50 85]);
            Mch.d15(t) = P(1);
            Mch.d50(t) = P(2);
            Mch.d85(t) = P(3);
            Mch.meanD(t) = mean(tLats(hD),'omitnan');

            Mch.durD(t) = length(idx) * o.timeBins;
            Mch.aucD(t) = (sum(datCh.b(idx))) * o.timeBins;
            Mch.pctD(t) = nnz(hD) / length(hD);

            idx = tIdx(hD & tLats>0);
            if ~isempty(idx)
                Mch.sD(t) = datCh.latency(idx(1));
                Mch.sD_b(t) = datCh.b(idx(1));
                Mch.sD_p(t) = datCh.q(idx(1));

                Mch.offD(t) = datCh.latency(idx(end));
                Mch.offD_b(t) = datCh.b(idx(end));
                Mch.offD_p(t) = datCh.q(idx(end));
            end
        end
        if min(datCh.b(tIdx)) < 0
            idx = ismembertol(datCh.b(tIdx),min(datCh.b(tIdx(hD & tLats>0))));
            if ~nnz(idx); idx = ismembertol(datCh.b(tIdx),min(datCh.b(tIdx(tLats>0)))); end
            if ~nnz(idx); idx = ismembertol(datCh.b(tIdx),min(datCh.b(tIdx(hD)))); end
            if ~nnz(idx); idx = ismembertol(datCh.b(tIdx),min(datCh.b(tIdx))); end
            Mch.pkD(t) = mean(tLats(idx),'omitnan');
            Mch.pkD_b(t) = mean(datCh.b(tIdx(idx)),'omitnan');
            Mch.pkD_p(t) = mean(datCh.q(tIdx(idx)),'omitnan');
        end
    end
    % Save
    datSTcell{ch} = datCh;
    datMs{ch} = Mch;
end
% Save
datMs = vertcat(datMs{:});
datMs = movevars(datMs,{'sbjCh','cond','trialA','Yeo7s','lobe','RT'}, 'Before', fieldsAct(1));
datMs(:,fieldsMS) = varfun(@(x) x./1000,datMs(:,fieldsMS));
end


function plotChLocal(chST,conds,dirSave,isTest,o)
tic
sbjCh = chST.sbjCh(1);
disp("Fig: "+sbjCh);

%% Make data arrays
chST = chST(chST.latency>=-305 & chST.latency<=5005,:);
chST.RT(isnan(chST.RT)|chST.RT==0) = 100000 + chST.trialA(isnan(chST.RT)|chST.RT==0);
chST.b = single(chST.b);
chST.Act(:) = single(0);
chST.Act(chST.hA) = 1;
chST.Dea(:) = single(0);
chST.Dea(chST.hD) = 1;
chST = sortrows(chST,{'RT','latency'},'ascend');

% Organize latency for data matrices
lats = unique(chST.latency);
lats = lats(lats>=-305 & lats<=5005,:);
ds = int32(round(mean(diff(lats))));
if min(lats) > -305
    lats = [-305:ds:lats(1)-1; lats];
end
if max(lats) < 5005
    lats = [lats; lats(end)+1:ds:5005];
end

chTrials = unique(chST.trialA,'stable');
chWave = single(nan(length(chTrials),length(lats)));
chB=chWave; chAct=chWave; chDea=chWave; chCond=string;
chRT = chWave(:,1);

for t = 1:length(chTrials)
    tr = chTrials(t);
    tIdx = find(chST.trialA==tr);
    tLat = find(ismember(lats,chST.latency(tIdx)));

    chWave(t,tLat) = chST.wave(tIdx);
    chB(t,tLat) = chST.b(tIdx);
    chAct(t,tLat) = chST.Act(tIdx);
    chDea(t,tLat) = chST.Dea(tIdx);
    chCond(t,1) = chST.cond(tIdx(1));
    chRT(t,1) = chST.RT(tIdx(1));
end
chCond = chCond==conds;
chTrials = string(chTrials);
chTrials(chRT>=100000) = "x"+chTrials(chRT>=100000);

%% Figure
if ~isTest
    f = figure('Position',[0 0 1980 1080],'color','white','MenuBar','none','ToolBar','none','Visible','off');
else
    f = figure('Position',[0 0 1980 1080],'color','white','MenuBar','none','ToolBar','none','Renderer','opengl'); toc
end
tiledlayout(f,4,6,'TileSpacing','tight','Padding','none');

for c = 1:length(conds)
    %%
    cond = conds(c);
    cTr = chCond(:,c);
    cTrS = chTrials(cTr);
    cAlpha = ~isnan(chWave(cTr,:));
    cRT = single(1:length(chRT(cTr)))';

    ax1 = nexttile(c); % Raw HFB
    imagesc(ax1,lats,cRT,chWave(cTr,:),'AlphaData',cAlpha,[-4,4]);
    colormap(ax1,flip(cbrewer2('RdBu')));
    set(ax1,'color',0*[1 1 1],'FontSize',8);
    yticklabels(cTrS)
    title(ax1,sbjCh+" "+cond,'Interpreter','none');
    if c==6
        colorbar(ax1,'eastoutside')
    end

    ax2 = nexttile(c+6); % Evoked HFB
    imagesc(ax2,lats,cRT,chB(cTr,:),'AlphaData',cAlpha,[-4,4]);
    colormap(ax2,flip(cbrewer2('RdBu')));
    set(ax2,'color',0*[1 1 1],'FontSize',8);
    yticklabels(cTrS);
    if c==6
        colorbar(ax2,'eastoutside');
    end

    ax3 = nexttile(c+12); % Active
    imagesc(ax3,lats,cRT,chAct(cTr,:),'AlphaData',cAlpha);
    colormap(ax3,[.3 .3 .3; 1 0 0]);
    set(ax3,'color',0*[1 1 1],'FontSize',8);
    yticklabels(cTrS);
    if c==6
        colorbar(ax3,'eastoutside','TickLabels','');
    end

    ax4 = nexttile(c+18); % Deactive
    imagesc(ax4,lats,cRT,chDea(cTr,:),'AlphaData',cAlpha);
    colormap(ax4,[.3 .3 .3; 0 1 1]);
    set(ax4,'color',0*[1 1 1],'FontSize',8);
    yticklabels(cTrS);
    if c==6
        colorbar(ax4,'eastoutside','TickLabels','');
    end
end

% Print
imgFn = [dirSave char(sbjCh) '_',o.fnString '.jpg'];
exportgraphics(f,imgFn,'Resolution',150);
if ~isTest
    close all
end
toc
end

% %% Stats per condition
%
% chLME = cell(numConds,1);
% for c = 1:numConds
%     cond = conds(c);
%     idxC = an.idxZ(an.cond==cond);
%
%     % Find bins
%     binsC = unique(an.bin(idxC));
%     numBins = numel(binsC);
%     % Combine every n bins
%     idxB = (1:3:numBins)';
%     idxB(:,2) = idxB(:,1) + 1;
%     idxB(:,3) = idxB(:,1) + 2;
%     idxB(idxB>numBins) = nan;
%     %idxB(:,2) = circshift(idxB(:,2),4,1);
%     %idxB(:,3) = circshift(idxB(:,3),-3,1);
%     numBins = height(idxB);
%     %%
%     chLMEc = cell(numBins,1);
%     for f = 1:numBins
%         idxLat = idxB(f,:);
%         idxLat(isnan(idxLat)) = [];
%         bin = binsC(idxLat);
%         idxF = ismember(an.bin, bin);
%         dispStr = sbjCh+" "+cond+" "+bin(1)+" ms";
%
%         %%
%         if f==1; disp(dispStr); toc; end
%         if nnz(idxF) < o.minAnalSize; continue; end
%         %idxKbl = ismember(anBL.trialA, unique(an.trialA(idxF))); %[anBL(idxKbl,:); an(idxF,:)]
%
%         %% Try LME
%         try
%             lme = fitlme(an(idxF,:),'wave ~ -1 + (binS-1|trialA)','CovariancePattern','Full',...
%                 'DummyVarCoding','full','FitMethod','REML','Verbose',false);
%         catch ME
%             warning("ERROR: "+dispStr);
%             getReport(ME)
%             continue
%         end
%
%         % Organize lme random effects
%         [~,~,lme] = randomEffects(lme); lme = dataset2table(lme);
%         lme(:,["Group" "DF" "Lower" "Upper"]) = [];
%         lme.Name = string(lme.Name);
%         lme(lme.Name=="(Intercept)",:) = [];
%         lme.Name = extractAfter(lme.Name,"_");
%         lme.Level = string(lme.Level);
%         lme.SEPred = single(lme.SEPred);
%         lme.tStat = single(lme.tStat);
%         lme.pValue = single(lme.pValue);
%         lme.Properties.VariableNames{'Level'} = 'trialA';
%         lme.Properties.VariableNames{'Name'} = 'latency';
%
%         % Save
%         chLMEc{f} = lme;
%         if isTest; disp(dispStr); toc; end
%     end
%     %%
%     chLME{c} = vertcat(chLMEc{:});
% end
%
% %% Organize/save stats output
% chLME = vertcat(chLME{:});
% chLME.trialBin = chLME.trialA+"_"+chLME.latency;
% chLME.trialA = uint16(str2double(chLME.trialA));
% chLME.latency = int32(str2double(chLME.latency));
% chLME = sortrows(chLME,{'trialA','latency'},"ascend");
%
% % Align lme & chStats
% [~,ia,ib] = intersect(chStats.trialBin,chLME.trialBin,"rows","stable");
% chStats = chStats(ia,:);
% chLME = chLME(ib,:);
%
% % Transfer data
% chStats.sbjCh(:) = sbjCh;
% chStats.b = chLME.Estimate;
% chStats.SE = chLME.SEPred;
% chStats.p = chLME.pValue;
% chStats = sortrows(chStats,{'trialA','latency'},"ascend");
%
% if ~isTest
%     chStats.trialBin=[];
%     chStats.count = uint8(chStats.count);
%     %chStats.wave = single(chStats.wave);
% end
%
% % figure; heatmap(chStats(chStats.cond=="other" & chStats.b>0 & chStats.q<0.05,:),'latency','RT','ColorVariable','b','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
% % figure; heatmap(chStats(chStats.cond=="math" & chStats.b<0 &chStats.q<0.05,:),'latency','RT','ColorVariable','b','GridVisible','off','Colormap',flip(cbrewer2('RdBu')),'MissingDataColor',[0 0 0],'ColorLimits',[-4 4]);
