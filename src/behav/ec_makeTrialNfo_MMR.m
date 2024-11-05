function ec_makeTrialNfo_MMR(sbj,task,proj,prompts,a)
arguments
    sbj {istext}
    task {istext}
    proj {istext}
    prompts table
    a.iti {isnumeric} = 0.3;
end
% sbj = "S12_38_LK";
% task="MMR"; proj="lbcn"; a.iti=0.3; r=1;
% load('/home/kt/Gdrive/UCLA/Studies/MMR/anal/beh/prompts_220524.mat','prompts');
% 

%%
dirs = ec_getDirs(proj,task,sbj);
blocks = BlockBySubj(sbj,task);

%% loop across runs
for r = 1:length(blocks)
    block = blocks{r};
    makeTrialNfo_run(sbj,block,dirs,prompts);
end


function makeTrialNfo_run(sbj,block,dirs,prompts)
% Load trialinfo, get event timing locks
load(fullfile(dirs.origSbj,block,['trialinfo_' block '.mat']),'trialinfo');
nTrials = height(trialinfo);
sbjRun = "s"+trialinfo.sbjID(1)+"r"+trialinfo.run(1);

% Load psy
load(fullfile(dirs.origSbj,block,['psy_' block '.mat']),'psy');
hz = psy.Properties.SampleRate;
hzStep = psy.Properties.TimeStep;

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

%% Trial timings & info: trialNfo & psy
trialNfo.lockStim = ceil(trialNfo.lockStim*hz) / hz; % Convert to sampling rate
trialNfo.lockITI = trialNfo.lockStim - trialNfo.itiBeh; % ITI onset
trialNfo.lockITI = ceil(trialNfo.lockITI*hz) / hz; % Convert to sampling rate
trialNfo.lockOff = trialNfo.lockStim + trialNfo.durBeh; % Stim offset
trialNfo.lockOff = ceil(trialNfo.lockOff*hz) / hz; % Convert to sampling rate
%trialNfo.lockITI(2:end) = trialNfo.lockOff(1:end-1) + seconds(hzStep); % Add timestep after prev trial
trialNfo = movevars(trialNfo,"lockITI","Before","lockStim");

% Time format for timetable indexing
trialNfo.onsITI(:) = seconds(nan);
trialNfo.onsStim = seconds(trialNfo.lockStim);
trialNfo.offStim(:) = seconds(trialNfo.lockOff);
trialNfo.durITI(:) = seconds(nan);
trialNfo.durStim(:) = seconds(nan);
trialNfo.durTrial(:) = seconds(nan);
trialNfo.idxITI = cell(height(trialNfo),1);
trialNfo.idxStim = cell(height(trialNfo),1);
trialNfo.idxTrial = cell(height(trialNfo),1);

% Psy
psy.run(:) = trialNfo.run(1);
psy.trial(:) = uint16(0);
psy.cond(:) = "";
psy.frame(:) = int32(0);
psy.latency(:) = seconds(nan);
psy.pct(:) = nan;
psy.stim(:) = false;
psy.RT(:) = nan;
psy.BLpre(:) = sparse(0);
psy.BLend(:) = sparse(0);
psy.sbjID(:) = trialNfo.sbjID(1);
psy.sbjRun(:) = sbjRun;
psy.noPdio(:) = sparse(false);
psy.idx(:) = uint32(1:height(psy));
psy = movevars(psy,["pdio" "pdioRaw"],"After","noPdio");

% Trial loop
for t = 1:nTrials
    tr = trialNfo.trial(t);

    % ITI onset
    if t==1 || ~(trialNfo.offStim(t-1) > 0)
        idxITI = timerange(seconds(trialNfo.lockITI(t)),trialNfo.onsStim(t),'openright');
        trialNfo.onsITI(t) = min(psy.Time(idxITI));
    else
        trialNfo.onsITI(t) = trialNfo.offStim(t-1) + hzStep;
    end


    idxTr = timerange(trialNfo.onsITI(t),trialNfo.offStim(t));
    idxStim = timerange(trialNfo.onsStim(t),trialNfo.offStim(t));
    idxITI = timerange(seconds(trialNfo.lockITI(t)),trialNfo.onsStim(t)-hzStep);

    psy.trial(idxTr) = tr;
    psy.cond(idxTr) = trialNfo.cond(t);
    psy.RT(idxTr) = trialNfo.RT(t);

    psy.stim(idxStim) = true;
    psy.preITI(idxITI) = tr;
    if t > 1
        psy.postITI(idxITI) = trialNfo.trial(t-1);
    else
        psy.postITI(timerange(trialNfo.offStim(t)+hzStep,trialNfo.offStim(t)+seconds(a.iti))) = tr;
    end
    
    psy.latency(idxTr) = psy.Time(idxTr) - trialNfo.onsStim(t);
    psy.pct(idxTr) = psy.latency(idxTr) ./ max(psy.latency(idxStim));
    psy.pct(idxITI) = psy.latency(idxITI) ./ (trialNfo.onsStim(t)-trialNfo.onsITI(t));
    psy.pct(idxITI) = psy.pct(idxITI) ./ 10;
end

psy.frame = int16(seconds(psy.latency)*hz);

% No Pdio timelock (trials with estimated times)
psy.noLock(ismember(psy.trial,trialNfo.trial(~trialNfo.pdio))) = sparse(true);

    %     % Fill
    % psy.trialA(idxTr) = trialNfo.trialA(t);
    % psy.cond(idxTr) = trialNfo.cond(t);
    % psy.latency(idxTr) = times(idxTr) - times(idxStim);
    % psy.stim(idxStim:idxRT) = true;
    % psy.RTog(idxTr) = trialNfo.RT(t);
    % psy.postRT(idxRT+1:idxEnd) = trialNfo.trialA(t);
    % psy.BLpre(idxStim+idxBLpre) = trialNfo.trialA(t);
    % psy.BLend(idxEnd+idxBLend) = trialNfo.trialA(t);
    % psy.pct(idxStim:idxRT) = psy.latency(idxStim:idxRT) ./ psy.latency(idxRT);
    % psy.pct(idxITI:idxStim-1) = psy.latency(idxITI:idxStim-1) ./ trialNfo.durITI(t);
    % psy.pct(idxITI:idxStim-1) = psy.pct(idxITI:idxStim-1) ./ 10;



%% Save
save(dirs.origSbj+block+filesep+"trialNfo_"+sbj+"_"+block+".mat", "trialNfo");
disp(['Saved trialNfo: ' sbj ' ' block]);

%%
% % Valence/Adjective/trait/answer length (GET RID BELOW for lbcnversion)
% trialNfo.valence(:) = single(nan);
% trialNfo.valenceC(:) = "";
% trialNfo.trait(:) = "";
% idx = contains(trialNfo.prompt,"=");
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx),"= ");
% idx = contains(trialNfo.prompt,"I am");
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx),"I am ");
% idx = contains(trialNfo.prompt,"neighbor");
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx),"neighbor is ");
% idx = contains(trialNfo.prompt,"Soy");
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx),"Soy ");
% idx = contains(trialNfo.prompt,"soy");
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx),"soy ");
% idx = contains(trialNfo.prompt,"Estoy");
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx),"Estoy ");
% idx = contains(trialNfo.prompt,"estoy");
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx),"estoy ");
% idx = contains(trialNfo.prompt,"est ");
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx),"est ");
% idx = contains(trialNfo.prompt,"es ");
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx),"es ");
% idx = contains(trialNfo.prompt,"se ");
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx),"se ");
% idx = trialNfo.trait=="";
% trialNfo.trait(idx) = extractAfter(trialNfo.prompt(idx)," ");
%
% % Fill in from trait list
% trialNfo.traitL = strlength(trialNfo.trait);
% trialNfo.word(:) = "";
% trialNfo.wordL(:) = nan;
% trialNfo.engWord(:) = "";
% trialNfo.english(:) = false;
% for t = 1:height(prompts)
%     idx = trialNfo.trait==prompts.trait(t);
%     if any(prompts.traitL(t)~=trialNfo.traitL(idx))
%         warning("Mismatched traitL for: "+prompts.trait(t));
%     end
%     trialNfo.word(idx) = prompts.word(t);
%     trialNfo.wordL(idx) = prompts.wordL(t);
%     trialNfo.engWord(idx) = prompts.engWord(t);
%     trialNfo.valence(idx) = prompts.valence(t);
%     trialNfo.english(idx) = prompts.english(t);
% end
% trialNfo.valenceC(trialNfo.valence==-1) = "negative";
% trialNfo.valenceC(trialNfo.valence==0) = "neutral";
% trialNfo.valenceC(trialNfo.valence==1) = "positive";
% trialNfo.valenceC = categorical(trialNfo.valenceC,["negative","neutral","positive"],'Ordinal',true);
%
% % Load prompt info (image similarity MDS)
% trialNfo.jarrett(:) = nan;
% trialNfo.jarrett1(:) = nan;
% trialNfo.jarrett2(:) = nan;
% for t = 1:height(prompts)
%     idx = trialNfo.prompt==prompts.prompt(t);
%     trialNfo.imgFn(idx) = prompts.fn(t);
%     trialNfo.jarrett(idx) = prompts.jarrett(t);
%     trialNfo.jarrett1(idx) = prompts.jarrett1(t);
%     trialNfo.jarrett2(idx) = prompts.jarrett2(t);
% end


% % Keys
% keys(1:nTrials) = "";
% for t = 1:nTrials
%     % Find if multiple responses in keys
%     if iscell(trialinfo.keys{t})
%         temp_key = trialinfo.keys{t};
%         idxKey = find(ismember(temp_key,{'1','2','DownArrow','End','1!','2@'}));
%         if ~isempty(idxKey)
%             temp_key = temp_key{idxKey};
%         else
%             temp_key = 'noanswer';
%         end
%     else
%         temp_key = trialinfo.keys{t};
%     end
% 
%     if strcmp(temp_key,'DownArrow')
%         temp_key = '2';
%     elseif strcmp(temp_key,'End')
%         temp_key = '1';
%     elseif strcmp(temp_key,'NaN')
%         temp_key = 'noanswer';
%     elseif strcmp(temp_key,'2@')
%         temp_key = '2';
%     elseif strcmp(temp_key,'1!')
%         temp_key = '1';
%     elseif isempty(temp_key)
%         temp_key = 'noanswer';
%     end
%     keys(t) = string(temp_key);
% end
% trialNfo.key = keys';


% % Rest of original trialinfo
% ogFields = ["Operand1","Operand2","OperandMin","OperandMax","Operator","CorrectResult","PresResult","Deviant","AbsDeviant","Accuracy","flipVBL","beh_ons","all_ons","all_off"]; %"nstim"
% trialNfo.block(:) = string(block);
% trialNfo = horzcat(trialNfo,trialinfo(:,ogFields));
% trialNfo.Properties.VariableNames{'allonsets'} = 'lockStim';
% trialNfo.Properties.VariableNames{'RT_lock'} = 'lockRT';