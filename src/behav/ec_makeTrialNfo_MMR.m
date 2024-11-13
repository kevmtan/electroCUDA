function ec_makeTrialNfo_MMR(sbj,task,proj,prompts)
arguments
    sbj (1,1) string
    task (1,1) string
    proj (1,1) string
    prompts table
end
% sbj="S12_38_LK"; sbj="S15_87_RL";
% task="MMR"; proj="lbcn"; r=1;
% load('/home/kt/Gdrive/UCLA/Studies/MMR/anal/beh/prompts_220524.mat','prompts');

%%
dirs = ec_getDirs(proj,task,sbj);
blocks = string(BlockBySubj(sbj,task));

%% loop across runs
for r = 1:length(blocks)
    block = blocks(r);
    makeTrialNfo_run(sbj,block,dirs,prompts);
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





function makeTrialNfo_run(sbj,block,dirs,prompts)

% Load trialinfo, get event timing locks
load(fullfile(dirs.origSbj,block,"trialinfo_"+block+".mat"), "trialinfo");
nTrials = height(trialinfo);
sbjRun = trialinfo.sbjRun(1);

% Load psy
load(fullfile(dirs.origSbj,"psy_"+sbjRun+".mat"), "psy");
hz = psy.Properties.SampleRate;
% Prompt variables
prompts = movevars(prompts,["word" "eng"],"After","valence");
vPrompts = string(prompts.Properties.VariableNames);


%% Make trialNfo

% Begin trialInfo
trialNfo = renamevars(trialinfo,"wlist","prompt");
trialNfo.sbjRun(:) = sbjRun;

% Response
trialNfo.resp(:) = "none";
trialNfo.resp(trialNfo.key=="1") = "true";
trialNfo.resp(trialNfo.key=="2") = "false";
trialNfo.resp = categorical(trialNfo.resp,["true","false","none"],'Ordinal',true);
trialNfo.trueKey = trialNfo.resp=="true";
trialNfo.eqAcu = trialinfo.Accuracy==1;

% Prompt edits
trialNfo.prompt(trialNfo.prompt=="10  + 1 = 11") = "10 + 1 = 11";
trialNfo.prompt(trialNfo.prompt=="11 + 2= 16") = "11 + 2 = 16";
trialNfo.prompt(trialNfo.prompt=="24 + 2= 19") = "24 + 2 = 19";
trialNfo.prompt(trialNfo.prompt=="26 + 7 = 34 ") = "26 + 7 = 34";
trialNfo.prompt(trialNfo.prompt=="28 + 6 = 34Ê") = "28 + 6 = 34";
trialNfo.prompt(trialNfo.prompt=="24 + 7= 31") = "24 + 7 = 31";
trialNfo.prompt(trialNfo.prompt=="45 + 9 = 54 ") = "45 + 9 = 54";
trialNfo.prompt(trialNfo.prompt=="47 + 9= 56") = "47 + 9 = 56";
trialNfo.prompt(trialNfo.prompt=="5 + 63 = 68 ") = "5 + 63 = 68";
trialNfo.prompt(trialNfo.prompt=="59 + 7 = 65 ") = "59 + 7 = 65";
trialNfo.prompt(trialNfo.prompt=="59 + 7 = 66 ") = "59 + 7 = 66";
trialNfo.prompt(trialNfo.prompt=="6 + 22 = 28 ") = "6 + 22 = 28";
trialNfo.prompt(trialNfo.prompt=="6 + 22 = 33 ") = "6 + 22 = 33";
trialNfo.prompt(trialNfo.prompt=="8 + 65 = 73 ") = "8 + 65 = 73";
trialNfo.prompt(trialNfo.prompt=="9 + 86 = 95 ") = "9 + 86 = 95";
trialNfo.prompt(trialNfo.prompt=="9 + 86 = 96 ") = "9 + 86 = 96";

% Get prompt info
for t = 1:nTrials
    idx = prompts.prompt==trialNfo.prompt(t);
    if ~nnz(idx); warning(['Prompt not found: ' sbj '_' block ' tr' t]); continue; end
    for i = 1:numel(vPrompts)
        trialNfo.(vPrompts(i))(t) = prompts.(vPrompts(i))(idx);
    end
end

% Move vars
trialNfo = movevars(trialNfo,"sbjRun","Before","sbj");
trialNfo = movevars(trialNfo,"cnd","After","trial");
trialNfo = movevars(trialNfo,["resp" "trueKey" "eqAcu"],"After","RT");
trialNfo = movevars(trialNfo,vPrompts,"After","eqAcu");


%% Preallocate trialNfo & psy

% Time format for timetable indexing
trialNfo.iti(:) = seconds(nan);
trialNfo.ons(:) = seconds(nan);
trialNfo.off(:) = seconds(nan);
trialNfo.durITI(:) = seconds(nan);
trialNfo.durStim(:) = seconds(nan);
trialNfo.durTrial(:) = seconds(nan);
trialNfo.idxITI(:) = uint32(0);
trialNfo.idxOns(:) = uint32(0);
trialNfo.idxOff(:) = uint32(0);

% Psy
psy.run(:) = trialNfo.run(1);
psy.trial(:) = uint16(0);
psy.cnd(:) = "";
psy.latency(:) = seconds(nan);
psy.frame(:) = int32(0);
psy.pct(:) = nan;
psy.RT(:) = nan;
psy.latRT(:) = seconds(nan);
psy.stim(:) = uint16(0);
psy.pre(:) = sparse(0);
psy.post(:) = sparse(0);
psy.on(:) = false;
psy.onHz(:) = false;
psy.noPdio(:) = sparse(false);
psy.cond(:) = "";
psy.valence(:) = int8(0);
psy.resp(:) = categorical("none",["true","false","none"],Ordinal=true);
psy.sbjID(:) = trialNfo.sbjID(1);
psy.sbjRun(:) = sbjRun;
psy.idx(:) = uint32(1:height(psy));
psy = movevars(psy,["pdio" "photodiode" "noPdio"],"After","onHz");


%% Fill trialNfo & psy

% Psy indices of stim timing (add 1 since psy starts at 0 sec)
trialNfo.idxOns = round(trialNfo.lockStim*hz) + 1;
trialNfo.idxOff = ceil(trialNfo.lockOff*hz) + 1;
trialNfo = convertvars(trialNfo,["idxOns" "idxOff"],"uint32");

% Rest onsets: ensure frame after offset of previous trial
t = find(trialNfo.cond=="rest");
trialNfo.idxOns(t) = trialNfo.idxOff(t-1) + 1;

% Psy indices of ITI timing
t = 2:nTrials;
trialNfo.idxITI(t) = trialNfo.idxOff(t-1) + 1;
trialNfo.idxITI(1) = trialNfo.idxOns(1) - ceil(trialNfo.itiBeh(1)*hz); % First trial
trialNfo.idxITI(trialNfo.cond=="rest") = nan;

% Get psy times from indices
trialNfo.ons = psy.Time(trialNfo.idxOns);
trialNfo.off = psy.Time(trialNfo.idxOff);
t = trialNfo.cond~="rest";
trialNfo.iti(t) = psy.Time(trialNfo.idxITI(t));

% Loop across trials
for t = 1:nTrials
    % Psy indices
    idxStim = trialNfo.idxOns(t):trialNfo.idxOff(t);
    if trialNfo.cond(t)~="rest"
        idxITI = trialNfo.idxITI(t):trialNfo.idxOns(t)-1;
        idxTr = trialNfo.idxITI(t):trialNfo.idxOff(t);

        trialNfo.durITI(t) = range(psy.Time(idxITI)); % ITI duration
        psy.on(idxStim) = true; % Stimulus on logical

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
    if trialNfo.cond(t)~="rest"
        psy.on(idxStim) = true; end
    psy.stim(idxStim) = t;
    trialNfo.durStim(t) = range(psy.Time(idxStim));

    % Trial metadata
    psy.trial(idxTr) = t;
    psy.RT(idxTr) = trialNfo.RT(t);
    psy.cnd(idxTr) = trialNfo.cnd(t);
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
psy.onHz = psy.on; % copy stimulus on logical for resampling


%% Save
save(fullfile(dirs.origSbj,"trialNfo_"+sbjRun+".mat"), "trialNfo");
save(fullfile(dirs.origSbj,"psy_"+sbjRun+".mat"), "psy");
%disp("["+sbjRun+"] Saved trialNfo and updated psy!");
