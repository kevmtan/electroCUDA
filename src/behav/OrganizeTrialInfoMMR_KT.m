function OrganizeTrialInfoMMR_KT(sbj,task,proj)
arguments
    sbj (1,1) string
    task (1,1) string
    proj (1,1) string
end
% sbj="S13_54_KDH"; task="MMR"; proj="lbcn";

%% Prep
dirs = ec_getDirs(proj,task,sbj);
blocks = string(BlockBySubj(sbj,task));

%% Loop across blocks/runs
for r = 1:length(blocks)
    block = blocks(r);
    withinRun_lfn(block,dirs);
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





function withinRun_lfn(block,dirs)
arguments
    block (1,1) string
    dirs (1,1) struct
end

%%
conds = ["Self","Other","Semantic","Episodic","Math","Rest","Fact"];
condNames = ["self-internal","other","self-external","autobio","math","rest","fact"];
conds_math_memory = ["memory","memory","memory","memory","math","rest","memory"];

% Get run number
if contains(block,'_')
    run = extractAfter(block,asManyOfPattern(wildcardPattern + "_"));
elseif contains(block,'-')
    run = extractAfter(block,asManyOfPattern(wildcardPattern + "-"));
end
run = uint8(str2double(run));
sbjRun = "s"+compose("%03d",dirs.sbjID)+"_r"+compose("%02d",run);

% load behavioral data
fn = dir(fullfile(dirs.origSbj,block,"sodata*.mat"));
K = load(fullfile(fn.folder,fn.name)); % block 55 %% FIND FILE IN THE FOLDER AUTO
dat = struct2table(K.theData);
dat.wlist = string(K.wlist);

% Remove trial if no flip
if iscell(dat.flip)
    idx = cellfun(@isstruct,dat.flip);
    if isany(idx)
        disp("["+sbjRun+"] Removing trials without stimulus render flip:");
        disp(find(~idx)');
        dat = struct2table(K.theData(idx));
        dat.wlist = string(K.wlist(idx));
    end
end
dat = [dat struct2table(dat.flip)];


%% Make trialinfo for stimulus trials
trialinfo = table;
trialinfo.wlist = dat.wlist;

% Keys & RT
for t = 1:height(dat)
    tmpRT = K.theData(t).RT;
    tmpKey = string(K.theData(t).keys);

    nResp = numel(tmpKey);
    if nResp > 1 % more than one response
        idx = find(ismember(tmpKey,["1" "2" "DownArrow" "End" "1!" "2@"]));
        if isempty(idx)
            tmpRT = tmpRT(1);
            tmpKey = tmpKey(1);
        else
            tmpRT = tmpRT(idx(1));
            tmpKey = tmpKey(idx(1));
        end
    elseif ~(tmpRT>0) || tmpKey=="noanswer"
        nResp = 0;
    end

    % Correct keys
    if tmpKey=="DownArrow"
        tmpKey = "2";
    elseif tmpKey=="End"
        tmpKey = "1";
    elseif tmpKey=="2@"
        tmpKey = "2";
    elseif tmpKey=="1!"
        tmpKey = "1";
    end

    trialinfo.RT(t) = tmpRT;
    trialinfo.key(t) = tmpKey;
    trialinfo.nResp(t) = uint8(nResp);
end

% Warn if multiple beh responses in some trials
maxResp = max(trialinfo.nResp);
if maxResp > 1
    disp("["+sbjRun+"] Multiple behavioral responses in these trials (max="+maxResp+"), selecting best response:");
    disp(find(trialinfo.nResp>1)');
end

% Add calculation info
for t = 1:height(trialinfo)
    [C,matches] = strsplit(trialinfo.wlist(t),["+" "-" "=" "and" "is"],CollapseDelimiters=true);
    if sum(isstrprop(C{1}, 'digit')) > 0
        isCalc = true;
        Operand1 = str2double((C{1}));
        Operand2 = str2double((C{2}));
        if matches(1)=="-"
            Operator = -1;
        else
            Operator = 1;
        end
        CorrectResult = Operand1 + Operand2*Operator;
        PresResult = str2double((C{3}(1:3))); % this is because sometimes there is a wrong character after the last digit
        Deviant = CorrectResult - PresResult;
        AbsDeviant = abs(Deviant);
        if (Deviant==0 && trialinfo.key(t)=="1") || (Deviant~=0 && trialinfo.key(t)=="2")
            acc = true;
        else
            acc = false;
        end
    else
        isCalc = false;
        Operand1 = nan;
        Operand2 = nan;
        Operator = nan;
        CorrectResult = nan;
        PresResult = nan;
        Deviant = nan;
        AbsDeviant = nan;
        acc = false;
    end
    trialinfo.cond(t) = conds(K.conds(t));
    trialinfo.condNames(t) = condNames(K.conds(t));
    trialinfo.conds_math_memory(t) = conds_math_memory(K.conds(t));
    trialinfo.isCalc(t) = isCalc;
    trialinfo.Accuracy(t) = acc;
    trialinfo.Operand1(t) = Operand1;
    trialinfo.Operand2(t) = Operand2;
    trialinfo.OperandMin(t) = min(Operand1,Operand2);
    trialinfo.OperandMax(t) = max(Operand1,Operand2);
    trialinfo.Operator(t) = Operator;
    trialinfo.CorrectResult(t) = CorrectResult;
    trialinfo.PresResult(t) = PresResult;
    trialinfo.Deviant(t) = Deviant;
    trialinfo.AbsDeviant(t) = AbsDeviant;
    trialinfo.RT_og{t} = K.theData(t).RT;
    trialinfo.key_og{t} = K.theData(t).keys;
end

% Copy from psychtoolbox output
trialinfo.StimulusOnsetTime = dat.StimulusOnsetTime;
trialinfo.flip = dat.FlipTimestamp;
trialinfo.flipVBL = dat.VBLTimestamp;
trialinfo.flipMiss = dat.Missed;
trialinfo.flipDiff = trialinfo.flip - trialinfo.flipVBL;
trialinfo.itiBeh(:) = nan;
trialinfo.onsBeh = trialinfo.StimulusOnsetTime;
trialinfo.durBeh = trialinfo.RT;

% No response trials
for t = find(~trialinfo.nResp)'
    if t+1 <= height(trialinfo)
        onsDf = trialinfo.onsBeh(t+1) - trialinfo.onsBeh(t);
    else
        onsDf = K.stimdur;
    end
    if onsDf >= K.ITI + K.stimdur
        trialinfo.durBeh(t) = K.stimdur;
    else
        trialinfo.durBeh(t) = onsDf - K.ITI;
    end
end


%% Add rest trials to trialinfo
restIdx = K.ind(K.ind <= K.fixmat)' - 1; % Insert rest trials after these stim trials
restDur = K.FixTime(1:height(restIdx))'; % Duration of rest trial

% Ensure ITI > restDur
t = 2:height(trialinfo);
itis = trialinfo.onsBeh(t) - trialinfo.onsBeh(t-1) - trialinfo.durBeh(t-1);
restIdx = restIdx(itis(restIdx) >= restDur);

% Rest onsets/duration
restOns = trialinfo.onsBeh(restIdx) + trialinfo.durBeh(restIdx);
restDur = K.FixTime(1:numel(restIdx))'; % Duration of rest trial

% Redo indices to make new table
restIdx = restIdx + (1:height(restIdx))';
nTrs = height(trialinfo) + height(restIdx);

% New trialinfo with rest trials
trialinfo2 = table;
trialinfo2(setdiff(1:nTrs,restIdx),:) = trialinfo;
trialinfo2.cond(restIdx) = "Rest";
trialinfo2.condNames(restIdx) = "rest";
trialinfo2.conds_math_memory(restIdx) = "rest";
trialinfo2.wlist(restIdx) = "+";
trialinfo2.RT(restIdx) = NaN;
trialinfo2.onsBeh(restIdx) = restOns;
trialinfo2.durBeh(restIdx) = restDur;


%% Finalize trialinfo
trialinfo = trialinfo2; % Replace old trialinfo

% Calculate ITI
t = 2:height(trialinfo);
trialinfo.itiBeh(t) = trialinfo.onsBeh(t) - trialinfo.onsBeh(t-1) - trialinfo.durBeh(t-1);
trialinfo.itiBeh(1) = 0.3; %min([0.5 max(trialinfo.itiBeh)]); %K.ITI;

% Add Basic info
trialinfo.sbj(:) = dirs.sbj;
trialinfo.sbjID(:) = dirs.sbjID;
trialinfo.sbjRun(:) = sbjRun;
trialinfo.block(:) = string(block);
trialinfo.run(:) = run;
trialinfo.trial(:) = uint16(1:height(trialinfo));
trialinfo.task(:) = dirs.task;
trialinfo = movevars(trialinfo,["sbjID" "run" "trial"],"Before",1);
trialinfo = movevars(trialinfo,["sbj" "sbjRun" "block" "task"],"Before","StimulusOnsetTime");


%% Save
save(fullfile(dirs.origSbj,block,"trialinfo_"+block+".mat"), "trialinfo");
%disp("["+sbjRun+"] Saved initial trialinfo table!");