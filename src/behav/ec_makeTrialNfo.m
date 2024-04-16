function ec_makeTrialNfo(sbj,bn,dirs,prompts)
% if 0
%     %%
%     sbj = 'S12_38_LK'; %#ok<UNRCH>
%     pathsDMN('lbcn');
%     [dirServer, dirComp, dirCode, dirFS] = AddPaths('Kevin_DMN');
%     dirs = ec_getDirs('MMR',sbj,dirServer,dirComp,dirCode,dirFS);
%     bn = BlockBySubj(sbj,'MMR'); bn = bn{1};
%     load('/home/kt/Gdrive/UCLA/Studies/MMR/anal/beh/prompts_220524.mat','prompts');
% end

% Load trialinfo, get event timing locks
load(dirs.psychSbj+bn+filesep+"trialinfo_"+bn+".mat", "trialinfo");
nTrials = height(trialinfo);

% Get sbjID and block name
sbjID = uint16(str2double(extractBetween(sbj,'_','_')));
if contains(bn,'_')
    run = extractAfter(bn,asManyOfPattern(wildcardPattern + "_"));
elseif contains(bn,'-')
    run = extractAfter(bn,asManyOfPattern(wildcardPattern + "-"));
end
run = uint8(str2double(run));
% Prompt variables
vPrompts = string(prompts.Properties.VariableNames);

%% Make trialNfo

% Begin trialInfo
trialNfo = table;
trialNfo.sbjID(1:nTrials) = sbjID;
trialNfo.run(:) = run;
trialNfo.trial(:) = uint16(1:nTrials);
trialNfo.cond = string(trialinfo.condNames);
trialNfo.cond = erase(trialNfo.cond,"-");
trialNfo.prompt = string(trialinfo.wlist);
trialNfo.RT = trialinfo.RT;

% Keys
keys(1:nTrials) = "";
for t = 1:nTrials
    % Find if multiple responses in keys
    if iscell(trialinfo.keys{t})
        temp_key = trialinfo.keys{t};
        idxKey = find(ismember(temp_key,{'1','2','DownArrow','End','1!','2@'}));
        if ~isempty(idxKey)
            temp_key = temp_key{idxKey};
        else
            temp_key = 'noanswer';
        end
    else
        temp_key = trialinfo.keys{t};
    end

    if strcmp(temp_key,'DownArrow')
        temp_key = '2';
    elseif strcmp(temp_key,'End')
        temp_key = '1';
    elseif strcmp(temp_key,'NaN')
        temp_key = 'noanswer';
    elseif strcmp(temp_key,'2@')
        temp_key = '2';
    elseif strcmp(temp_key,'1!')
        temp_key = '1';
    elseif isempty(temp_key)
        temp_key = 'noanswer';
    end
    keys(t) = string(temp_key);
end
trialNfo.key = keys';

% Response
trialNfo.resp(:) = "none";
trialNfo.resp(keys=="1") = "true";
trialNfo.resp(keys=="1!") = "true";
trialNfo.resp(keys=="2") = "false";
trialNfo.resp(keys=="2@") = "false";
trialNfo.resp = categorical(trialNfo.resp,["true","false","none"],'Ordinal',true);
trialNfo.trueKey = trialNfo.resp=="true";
%trialNfo.trueKeyD = single(trialNfo.trueKey);
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
    if ~nnz(idx); warning(['Prompt not found: ' sbj '_' bn ' tr' t]); continue; end
    for i = 1:numel(vPrompts)
        trialNfo.(vPrompts(i))(t) = prompts.(vPrompts(i))(idx);
    end
end

% Rest of original trialinfo
ogFields = ["Operand1","Operand2","OperandMin","OperandMax","Operator","CorrectResult","PresResult","Deviant","AbsDeviant","StimulusOnsetTime","Accuracy","allonsets","RT_lock"]; %"nstim"
trialNfo.block(:) = string(bn);
trialNfo = horzcat(trialNfo,trialinfo(:,ogFields));
trialNfo.Properties.VariableNames{'allonsets'} = 'lockStim';
trialNfo.Properties.VariableNames{'RT_lock'} = 'lockRT';
disp(['Made trialNfo: ' sbj ' ' bn]);

%% Save
save(dirs.psychSbj+bn+filesep+"trialNfo_"+sbj+"_"+bn+".mat", "trialNfo");
disp(['Saved trialNfo: ' sbj ' ' bn]);
end

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