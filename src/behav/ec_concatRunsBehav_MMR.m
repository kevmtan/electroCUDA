function [psy,trialNfo] = ec_concatRunsBehav_MMR(sbj,task,proj,a)
arguments
    sbj (1,1) string
    task (1,1) string
    proj (1,1) string
    a.hzTarget (1,1) double = 0
end
% sbj="S12_38_LK"; sbj="S15_87_RL";
% task="MMR"; proj="lbcn"; a.hzTarget=100;


%% Prep
dirs = ec_getDirs(proj,task,sbj);
blocks = string(BlockBySubj(sbj,task));
runs = extractAfter(blocks,asManyOfPattern(wildcardPattern + "_"));
runs = extractAfter(runs,asManyOfPattern(wildcardPattern + "-"));
runs = uint8(str2double(runs));


%% Loop across runs
for r = 1:numel(runs)
    run = runs(r);
    sbjRun = "s"+compose("%03d",dirs.sbjID)+"_r"+compose("%02d",run);

    % Load
    load(fullfile(dirs.origSbj,"trialNfo_"+sbjRun+".mat"), "trialNfo");
    load(fullfile(dirs.origSbj,"psy_"+sbjRun+".mat"), "psy");

    % Resample if needed
    if isany(a.hzTarget) && a.hzTarget~=psy.Properties.SampleRate
        [psy,trialNfo] = resampleRun_lfn(psy,trialNfo,a);
    end
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function [psy,trialNfo] = resampleRun_lfn(psy,trialNfo,a)
nTrials = height(trialNfo);
varNames = string(psy.Properties.VariableNames);
[ds1,ds2] = rat(a.hzTarget/psy.Properties.SampleRate);

% Resample stimulus on & photodiode signals
psy = psy(:,["onHz" "photodiode"]);
psy = convertvars(psy,["onHz" "photodiode"],"double");
psy = resample(psy,ds1,ds2);
hz = psy.Properties.SampleRate;
hzStep = psy.Properties.TimeStep;

% Convert signals back to logical
psy.on = psy.onHz>=0.5;
psy.onDf = [0; diff(psy.on)];
psy.pdio = psy.photodiode>=0.5;

% Convert signals to half-precision
psy = convertvars(psy,["onHz" "photodiode"],"half");
psy.onHz(psy.onHz <= eps("half")) = 0;
psy.onHz(psy.onHz >= 1-eps("half")) = 1;
psy.photodiode(psy.photodiode <= eps("half")) = 0;
psy.photodiode(psy.photodiode >= 1-eps("half")) = 1;


%% Clear timing variables

% Clear trialNfo event timings
trialNfo.onsITI(:) = seconds(nan);
trialNfo.onsStim(:) = seconds(nan);
trialNfo.offStim(:) = seconds(nan);
trialNfo.durITI(:) = seconds(nan);
trialNfo.durStim(:) = seconds(nan);
trialNfo.durTrial(:) = seconds(nan);
trialNfo.idxITI = cell(nTrials,1);
trialNfo.idxStim = cell(nTrials,1);
trialNfo.idxTrial = cell(nTrials,1);

% Preallocate psy
psy.run(:) = trialNfo.run(1);
psy.trial(:) = uint16(0);
psy.cnd(:) = "";
psy.latency(:) = seconds(nan);
psy.frame(:) = int32(0);
psy.pct(:) = nan;
psy.RT(:) = nan;
psy.latRT(:) = seconds(nan);
psy.stim(:) = uint16(0);
psy.BLpre(:) = sparse(0);
psy.BLend(:) = sparse(0);
psy.noPdio(:) = sparse(false);
psy.cond(:) = "";
psy.valence(:) = int8(0);
psy.resp(:) = categorical("none",["true","false","none"],Ordinal=true);
psy.sbjID(:) = trialNfo.sbjID(1);
psy.sbjRun(:) = trialNfo.sbjRun(1);
psy.idx(:) = uint32(1:height(psy));

% Psy var order
psy = movevars(psy,varNames,"After",0);


%% Calculate resampled event times

% Stim trials
t = trialNfo.cond~="rest";
trialNfo.onsStim(t) = psy.Time(psy.onDf==1);
trialNfo.offStim(t) = psy.Time(find(psy.onDf==-1)-1);

for t = 1:nTrials
    % Get trial stimulus onset
    tr = trialNfo.trial(t);

    % Find ITI onset
    if t==1
        trialNfo.onsITI(t) = psy.Time(floor(trialNfo.lockITI(t)*hz));
    elseif trialNfo.itiBeh(t) > 0
        trialNfo.onsITI(t) = psy.Time(psy.idx(trialNfo.offStim(t-1))+1); % Frame after end of prev trial
    end

    % Fill ITI
    if trialNfo.itiBeh(t) > 0
        idxITI = timerange(trialNfo.onsITI(t),trialNfo.onsStim(t));
        trialNfo.durITI(t) = range(psy.Time(idxITI));
    else
        idxITI = timerange(seconds(0),seconds(0));
        trialNfo.durITI(t) = seconds(0);
    end
    if t > 1
        psy.BLend(idxITI) = trialNfo.trial(t-1); end
    psy.BLpre(idxITI) = tr;
    trialNfo.idxITI{t} = idxITI;

    % Stimulus offset
    idxOff = ceil(trialNfo.durBeh(t)*hz);
    idxOff = psy.idx(trialNfo.onsStim(t)) + idxOff;
    trialNfo.offStim(t) = psy.Time(idxOff);

    % Stimulus duration
    idxStim = timerange(trialNfo.onsStim(t),trialNfo.offStim(t),'closed');
    if trialNfo.cond(t)~="rest"
        psy.on(idxStim) = true; end
    psy.stim(idxStim) = tr;
    trialNfo.durStim(t) = range(psy.Time(idxStim));
    trialNfo.idxStim{t} = idxStim;

    % Trial metadata
    idxTr = timerange(trialNfo.onsITI(t),trialNfo.offStim(t),'closed');
    if isnan(trialNfo.onsITI(t)); idxTr=idxStim; end
    psy.trial(idxTr) = tr;
    psy.RT(idxTr) = trialNfo.RT(t);
    psy.cnd(idxTr) = trialNfo.cnd(t);
    psy.cond(idxTr) = trialNfo.cond(t);
    psy.valence(idxTr) = trialNfo.valence(t);
    psy.resp(idxTr) = trialNfo.resp(t);
    psy.noPdio(idxTr) = trialNfo.noPdio(t);
    trialNfo.durTrial(t) = range(psy.Time(idxTr));
    trialNfo.idxTrial{t} = idxTr;

    % Latency
    psy.latency(idxTr) = psy.Time(idxTr) - trialNfo.onsStim(t);
    psy.pct(idxTr) = psy.latency(idxTr) ./ max(psy.latency(idxStim));
    psy.pct(idxITI) = psy.latency(idxITI) ./ (trialNfo.onsStim(t)-trialNfo.onsITI(t));
    psy.pct(idxITI) = psy.pct(idxITI) ./ 10;
    psy.latRT(idxStim) = psy.Time(idxStim) - trialNfo.offStim(t);
    if t > 1
        psy.latRT(idxITI) = psy.Time(idxITI) - trialNfo.offStim(t-1); end
end
psy.frame = int32(seconds(psy.latency)*hz);
psy.onHz = psy.on;





% % Rest trials
% t = find(trialNfo.cond=="rest");
% trialNfo.onsStim(t) = trialNfo.offStim(t-1) + hzStep;
% trialNfo.offStim(t) = trialNfo.onsStim(t) + seconds(trialNfo.durBeh(t));
% trialNfo.offStim(t) = ceil(trialNfo.offStim(t)*hz)/hz;
% 
% trialNfo.durStim = trialNfo.offStim - trialNfo.onStim; % stim duartion
% 
% % ITI
% t = find(trialNfo.cond~="rest"); t=t(t>1);
% trialNfo.onsITI(t) = trialNfo.offStim(t-1) + hzStep;
% trialNfo.onsITI(1) = trialNfo.onsStim(1) - trialNfo.itiBeh(1);
% trialNfo.onsITI = floor(trialNfo.onsITI*hz)/hz; 








