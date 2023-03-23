function OrganizeTrialInfoMMR_KT(sbj, proj, runs, dirs)

for i1 = 1:length(runs)
    bn = runs{i1};
    
    %% Load globalVar
    load(sprintf('%s/orig/%s/global_%s_%s_%s.mat',dirs.data,sbj,proj,sbj,bn));
    
    % Load behavioral file
    soda_name = dir(fullfile(globalVar.psych, 'sodata*.mat'));
    K = load([globalVar.psych '/' soda_name.name]); % block 55 %% FIND FILE IN THE FOLDER AUTO
    
    
    for ii = 1:length(K.theData)
        if size(K.theData(ii).kinfo,2) ~= 1
            K.theData(ii).RT = NaN;
            K.theData(ii).keys = NaN;
            if ~isstruct(K.theData(ii).flip)
                K.theData(ii).flip = {};
                K.theData(ii).flip.StimulusOnsetTime = NaN;
                %                 fprintf('Making it struct: %d\n',i)
            end
            K.theData(ii).flip.StimulusOnsetTime = NaN;
        else
        end
    end
    
    % start trialinfo
    trialinfo = table;
    for i = 1:length(K.theData)
        trialinfo.wlist = reshape(K.wlist,length(K.wlist),1);
    end
    for i = 1:length(K.theData)
        % Find if multiple responses in keys
        if iscell(K.theData(i).keys)
            temp_key = K.theData(i).keys;
            for ti = 1:length(temp_key)
                temp_key{ti} = num2str(temp_key{ti});
            end
            idxKey = find(ismember(temp_key,{'1','2','DownArrow','End','1!','2@'}));
            if ~isempty(idxKey)
                temp_key = temp_key{idxKey};
            else
                temp_key = 'NaN';
            end
        else
            temp_key = num2str(K.theData(i).keys);
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
        end
        trialinfo.keys{i} = temp_key;
    end
    
    
    for i=1:length(K.theData)
        RTa=K.theData(i).RT;
        RTb(i,1)=RTa(1);
    end
    
    trialinfo.RT = RTb;
    clear RTb
    % trialinfo.RT = vertcat(K.theData(:).RT);%RTb;%
    
    condNames= {'self-internal','other','self-external','autobio','math','rest','fact'};
    conds_math_memory = {'memory','memory','memory','memory','math','rest','memory'};
    
    % Add calculation info
    for i = 1:size(trialinfo,1)
        % Calculation info
        [C,matches] = strsplit(trialinfo.wlist{i},{'+','-','=', 'and', 'is'},'CollapseDelimiters',true);
        if sum(isstrprop(C{1}, 'digit')) > 0
            isCalc = 1;
            Operand1 = str2num((C{1}));
            Operand2 = str2num((C{2}));
            if strmatch(matches{1}, '-') == 1
                Operator = -1;
            else
                Operator = 1;
            end
            CorrectResult = Operand1 + Operand2*Operator;
            PresResult = str2num((C{3}(1:3))); % this is because sometimes there is a wrong character after the last digit
            Deviant = CorrectResult - PresResult;
            AbsDeviant = abs(Deviant);
            if (Deviant == 0 && strcmp(trialinfo.keys{i}, '1') == 1) || (Deviant ~= 0 && strcmp(trialinfo.keys{i}, '2') == 1)
                trialinfo.Accuracy(i,1) = 1;
            else
                trialinfo.Accuracy(i,1) = 0;
            end
            
        elseif strmatch(trialinfo.wlist{i}, '+') == 1
            isCalc = 0;
            Operand1 = nan;
            Operand2 = nan;
            Operator = nan;
            CorrectResult = nan;
            PresResult = nan;
            Deviant = nan;
            AbsDeviant = nan;
        else
            isCalc = 0;
            Operand1 = nan;
            Operand2 = nan;
            Operator = nan;
            CorrectResult = nan;
            PresResult = nan;
            Deviant = nan;
            AbsDeviant = nan;
        end
        trialinfo.condNames{i,1} = condNames{K.conds(i)};
        trialinfo.conds_math_memory{i,1} = conds_math_memory{K.conds(i)};
        trialinfo.isCalc(i,1) = isCalc;
        trialinfo.Operand1(i,1) = Operand1;
        trialinfo.Operand2(i,1) = Operand2;
        trialinfo.OperandMin(i,1) = min(Operand1,Operand2);
        trialinfo.OperandMax(i,1) = max(Operand1,Operand2);
        trialinfo.Operator(i,1) = Operator;
        trialinfo.CorrectResult(i,1) = CorrectResult;
        trialinfo.PresResult(i,1) = PresResult;
        trialinfo.Deviant(i,1) = Deviant;
        trialinfo.AbsDeviant(i,1) = AbsDeviant;
        trialinfo.StimulusOnsetTime(i,1) = K.theData(i).flip.StimulusOnsetTime;
    end
    
    ITIs = nan(1,size(trialinfo,1)-1);
    for t = 2:size(trialinfo,1)
        ITIs(t-1)=trialinfo.StimulusOnsetTime(t,1)-(trialinfo.StimulusOnsetTime(t-1,1)+trialinfo.RT(t-1));
    end
    
    
    ITIreal = mean(ITIs(ITIs<1));
    
    restInds = find((ITIs > 4 & ITIs < 6) | (ITIs > 9 & ITIs < 11));
    restOnsets = nan(1,length(restInds));
    
    for ri = 1:length(restInds)
        restOnsets(ri)=trialinfo.StimulusOnsetTime(restInds(ri),1)+trialinfo.RT(restInds(ri))+ITIreal;
    end
    
    rest_inds = restInds;
    rest_inds = rest_inds + (1:length(rest_inds));
    ntrials_total = size(trialinfo,1) + length(rest_inds);
    trialinfoNew = table;
    trialinfoNew(setdiff(1:ntrials_total,rest_inds),:)=trialinfo;
    trialinfoNew.condNames(rest_inds)={'rest'};
    trialinfoNew.conds_math_memory(rest_inds)={'rest'};
    trialinfoNew.wlist(rest_inds)={'+'};
    trialinfoNew.RT(rest_inds)=NaN;
    trialinfoNew.allonsets(rest_inds)= NaN;
    trialinfoNew.StimulusOnsetTime(rest_inds) = restOnsets;
    trialinfo = trialinfoNew;
    
    %% Exceptions
    if strcmp(sbj, 'S12_32_JTb') && strcmp(proj, 'MMR') && strcmp(bn, 'JT0112-45')
        trialinfo = trialinfo(2:end,:);
    else
    end
    
    % Save
    save([globalVar.psych '/trialinfo_', bn '.mat'], 'trialinfo');
end

end



%     for t = 1:size(trialinfo,1)
%         onset = trialinfo.StimulusOnsetTime(t,1);
%         resp = trialinfo.StimulusOnsetTime(t,1)+trialinfo.RT(t);
%         plot([onset onset],[0 1],'b-')
%         hold on
%         plot([resp resp],[0 1],'r-')
%     end
%
%     for ri = 1:length(restInds)
%         plot([restOnsets(ri) restOnsets(ri)],[0 1],'g-')
%     end
%


%% Correct for rest trials
%     rest_inds = sort(K.rest_inds);
%     rest_inds = rest_inds + (1:length(rest_inds));
%     ntrials_total = size(trialinfo,1) + length(rest_inds);
%     trialinfoNew = table;
%     trialinfoNew(setdiff(1:ntrials_total,rest_inds),:)=trialinfo;
%     trialinfoNew.condNames(rest_inds)={'rest'};
%     trialinfoNew.conds_math_memory(rest_inds)={'rest'};
%     trialinfoNew.wlist(rest_inds)={'+'};
%     trialinfoNew.RT(rest_inds)=NaN;
%     trialinfoNew.allonsets(rest_inds)=NaN;
%
%     trialinfo = trialinfoNew;