function [psy,trialNfo,n] = ec_concatRunsBehav_MMR(n,a)
%% Input validation
arguments
    n struct
    a.hzTarget (1,1) double = 0
    a.test (1,1) logical = false;
end
% a.test=1; a.hzTarget=100; r=1;


%% Prep
runs = extractAfter(n.blocks,asManyOfPattern(wildcardPattern + "_"));
runs = extractAfter(runs,asManyOfPattern(wildcardPattern + "-"));
runs = uint8(str2double(runs));


%% Concactenate behavioral data cross runs
for r = 1:numel(runs)
    run = runs(r);
    sbjRun = "s"+compose("%03d",n.sbjID)+"_r"+compose("%02d",run);
    load(fullfile(n.dirs.origSbj,"trialNfo_"+sbjRun+".mat"), "trialNfo");
    load(fullfile(n.dirs.origSbj,"psy_"+sbjRun+".mat"), "psy");
    trialNfo(:,["conds_math_memory" "isCalc" "Operand1" "Operand2"...
        "OperandMin" "OperandMax" "Operator" "CorrectResult" "PresResult"...
        "Deviant" "AbsDeviant" "RT_og" "key_og" "StimulusOnsetTime"]) = [];
    if a.test; trialNfo0=trialNfo; psy0=psy; end %#ok<NASGU>

    %% Resample if needed
    if isany(a.hzTarget) && a.hzTarget~=psy.Properties.SampleRate
        [psy,trialNfo] = resampleRun_lfn(psy,trialNfo,a);
    end

    %% Concactenate across runs: trialNfo & psy
    psy.timeR = psy.Time; % save within-run time
    psy.idr = psy.idx; % save within-run index
    psy.pre = uint16(full(psy.pre));
    psy.post = uint16(full(psy.post));

    if r==1 %%% First run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % All-run trials
        psy.tr = psy.trial;
        trialNfo.tr = trialNfo.trial;
        
        % Initialize tables to concactenate
        trialNfo2 = trialNfo;
        psy2 = psy;
        hzStep = psy.Properties.TimeStep;

    else %%% Additional runs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % All-run indices
        idx2 = psy2.idx(end);
        psy.idx = psy.idx + idx2;
        trialNfo.idxOns = trialNfo.idxOns + idx2;
        trialNfo.idxOff = trialNfo.idxOff + idx2;
        t = trialNfo.idxITI > 0;
        trialNfo.idxITI(t) = trialNfo.idxITI(t) + idx2;

        % All-run time
        psy.Time = psy.Time + psy2.Time(end) + hzStep;
        trialNfo.ons = psy.Time(ismember(psy.idx,trialNfo.idxOns));
        trialNfo.off = psy.Time(ismember(psy.idx,trialNfo.idxOff));
        trialNfo.iti(t) = psy.Time(ismember(psy.idx,trialNfo.idxITI(t)));
        
        % All-run trials
        tr2 = trialNfo2.tr(end);
        trialNfo.tr = trialNfo.trial + tr2;
        t = psy.trial > 0;
        psy.tr(t) = psy.trial(t) + tr2;
        t = psy.stim > 0;
        psy.stim(t) = psy.stim(t) + tr2;
        t = psy.pre > 0;
        psy.pre(t) = psy.pre(t) + tr2;
        t = psy.post > 0;
        psy.post(t) = psy.post(t) + tr2;

        % Concactenate
        psy2 = [psy2;psy]; %#ok<AGROW>
        trialNfo2 = [trialNfo2;trialNfo]; %#ok<AGROW>
    end
end



%% Finalize
psy = psy2;
psy = movevars(psy,"tr","After","run");
psy = movevars(psy,"trial","Before","timeR");
psy = movevars(psy,"idx","After",width(psy));

trialNfo = trialNfo2;
trialNfo = movevars(trialNfo,"tr","Before","trial");
trialNfo.Properties.RowNames = "r"+trialNfo.run+"_t"+trialNfo.tr+"_"+trialNfo.cond;

% Save info to n
n.nFrames = height(psy);
n.nRuns = numel(unique(trialNfo.run));
n.nTrials = height(trialNfo);
n.runs = unique(trialNfo.run);
n.runIdx = nan(n.nRuns,2);
n.runIdxOg = nan(n.nRuns,1);
n.runTimes = seconds(nan(n.nRuns,2));
n.runTimesOg = seconds(nan(n.nRuns,1));
for r = 1:n.nRuns
    run = n.runs(r);
    idx = psy.idx(psy.run==run);
    n.runIdx(r,:) = [min(idx) max(idx)];
    n.runIdxOg(r) = psy.idr(max(idx));
    n.runTimes(r,:) = [psy.Time(min(idx)) psy.Time(max(idx))];
    n.runTimesOg(r) = psy.timeR(max(idx));
end
n.conds = unique(trialNfo.cond);
n.nConds = numel(n.conds);
disp(n.sbj+": updated 'n"+n.suffix+"' with info from 'trialNfo' & 'psy'");






%%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%% Resample within-run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [psy,trialNfo] = resampleRun_lfn(psy,trialNfo,a)
nTrials = height(trialNfo);
varNames = string(psy.Properties.VariableNames);
[ds1,ds2] = rat(a.hzTarget/psy.Properties.SampleRate);

% Resample stimulus on & photodiode signals
psy = psy(:,["onHz" "photodiode"]);
psy = convertvars(psy,["onHz" "photodiode"],"double");
psy = resample(psy,ds1,ds2,max([ds1 ds2 10]));
hz = psy.Properties.SampleRate;

% Convert signals back to logical
psy.on = psy.onHz>=0.5;
psy.onDf = [0; diff(psy.on)]; % Indicate stimulus onset & offset
psy.pdio = psy.photodiode>=0.5;

% Convert signals to half-precision
psy = convertvars(psy,["onHz" "photodiode"],"half");


%% Clear timing variables

% trialNfo
trialNfo.iti(:) = seconds(nan);
trialNfo.ons(:) = seconds(nan);
trialNfo.off(:) = seconds(nan);
trialNfo.durITI(:) = seconds(nan);
trialNfo.durStim(:) = seconds(nan);
trialNfo.durTrial(:) = seconds(nan);
trialNfo.idxITI(:) = uint32(0);
trialNfo.idxOns(:) = uint32(0);
trialNfo.idxOff(:) = uint32(0);

% psy
psy.run(:) = trialNfo.run(1);
psy.trial(:) = uint16(0);
psy.cond(:) = "";
psy.latency(:) = seconds(nan);
psy.frame(:) = int32(0);
psy.pct(:) = nan;
psy.RT(:) = nan;
psy.latRT(:) = seconds(nan);
psy.stim(:) = uint16(0);
psy.pre(:) = sparse(0);
psy.post(:) = sparse(0);
psy.noPdio(:) = sparse(false);
psy.valence(:) = int8(0);
psy.resp(:) = categorical("none",["true","false","none"],Ordinal=true);
psy.sbjID(:) = trialNfo.sbjID(1);
psy.idx(:) = uint32(1:height(psy));
% Psy var order
psy = movevars(psy,varNames,"After",0);


%% Calculate resampled event times

% Stim trials
t = trialNfo.cond~="Rest";
trialNfo.idxOns(t) = psy.idx(psy.onDf==1);
trialNfo.idxOff(t) = psy.idx(find(psy.onDf==-1)-1);
trialNfo = convertvars(trialNfo,["idxOns" "idxOff" "idxITI"],"uint32");

% Rest onsets: frame after offset of previous trial
t = find(trialNfo.cond=="Rest");
trialNfo.idxOns(t) = trialNfo.idxOff(t-1) + 1;
trialNfo.idxOff(t) = trialNfo.idxOns(t) + uint32(ceil(trialNfo.durBeh(t)*hz));

% Psy indices of ITI timing
t = 2:nTrials;
trialNfo.idxITI(t) = trialNfo.idxOff(t-1) + 1;
trialNfo.idxITI(1) = trialNfo.idxOns(1) - ceil(trialNfo.itiBeh(1)*hz); % First trial
trialNfo.idxITI(trialNfo.cond=="Rest") = nan;

% Get psy times from indices
trialNfo.ons = psy.Time(trialNfo.idxOns);
trialNfo.off = psy.Time(trialNfo.idxOff);
t = trialNfo.cond~="Rest";
trialNfo.iti(t) = psy.Time(trialNfo.idxITI(t));

% Loop across trials
for t = 1:nTrials
    % Psy indices
    idxStim = trialNfo.idxOns(t):trialNfo.idxOff(t);
    if trialNfo.cond(t)~="Rest"
        idxITI = trialNfo.idxITI(t):trialNfo.idxOns(t)-1;
        idxTr = trialNfo.idxITI(t):trialNfo.idxOff(t);

        trialNfo.durITI(t) = range(psy.Time(idxITI)); % ITI duration

        % ITI pre-/post-stimulus trial
        psy.pre(idxITI) = t;
        if t > 1
            psy.post(idxITI) = t-1; end
    else
        idxITI = 0;
        idxTr = idxStim;
        trialNfo.durITI(t) = seconds(0);
    end

    % Stimulus metadata
    psy.stim(idxStim) = t;
    trialNfo.durStim(t) = range(psy.Time(idxStim));

    % Trial metadata
    psy.trial(idxTr) = t;
    psy.RT(idxTr) = trialNfo.RT(t);
    psy.cond(idxTr) = trialNfo.cond(t);
    psy.valence(idxTr) = trialNfo.valence(t);
    psy.resp(idxTr) = trialNfo.resp(t);
    psy.noPdio(idxTr) = trialNfo.noPdio(t);
    trialNfo.durTrial(t) = range(psy.Time(idxTr));

    % Latency relative to stimulus
    psy.latency(idxTr) = psy.Time(idxTr) - trialNfo.ons(t);

    % Latency percentage
    psy.pct(idxTr) = psy.latency(idxTr) ./ max(psy.latency(idxStim));
    if any(idxITI)
        psy.pct(idxITI) = psy.latency(idxITI) ./ (trialNfo.ons(t)-trialNfo.iti(t));
        psy.pct(idxITI) = psy.pct(idxITI) ./ 10;
    end

    % Latency relative to behav RT
    psy.latRT(idxStim) = psy.Time(idxStim) - trialNfo.off(t);
    if t>1 && any(idxITI)
        psy.latRT(idxITI) = psy.Time(idxITI) - trialNfo.off(t-1); end
end

% Finalize
psy.frame = int32(seconds(psy.latency)*hz); % frame within trial
psy.onDf = [];