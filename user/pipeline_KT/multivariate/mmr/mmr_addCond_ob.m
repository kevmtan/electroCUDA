function mmr_addCond_ob(analDir,condCol)
%MMR_ADDCOND_OB Backfill 'Cond' (original behavioral condition) into per-
% subject observation tables by matching trial numbers against trialNfo.
%
% mmr_addCond_ob(analDir)         uses 'Cond' as the trialNfo source column
% mmr_addCond_ob(analDir,condCol) uses a custom column name in trialNfo
%
% Loads o + logs from analDir, loops finished subjects, joins each subject's
% obs table to logs.n{s}.trialNfo on trial number, appends a 'Cond' column,
% and saves the updated table back to its original .mat file via -append.

arguments
    analDir (1,1) string
    condCol (1,1) string = "Cond"
end

tt = tic;

analDir = strip(analDir,"right",filesep) + filesep;

% Load analysis context
[~,analName] = fileparts(strip(analDir,"right",filesep));
load(analDir+"o_"+analName,"o");
load(o.analOut+"logs_"+o.analName,"logs");

% Limit to finished subjects
logs = logs(logs.class,:);
nSbj = height(logs);

for s = 1:nSbj
    sbj = string(logs.sbj(s));
    obFn = string(logs.ob(s));

    % Load per-subject obs
    load(obFn,"ob");

    % Trial info table
    nfo = logs.n{s}.trialNfo;
    nfoVars = string(nfo.Properties.VariableNames);

    % Verify required columns exist in trialNfo
    reqd = ["sbjID" "tr" condCol];
    missingVars = reqd(~ismember(reqd,nfoVars));
    if ~isempty(missingVars)
        warning("[%d/%d] %s: trialNfo missing %s, skipping",...
            s,nSbj,sbj,strjoin(missingVars,", "));
        continue
    end

    % Match (sbjID, tr) in ob to (sbjID, tr) in trialNfo
    obKey  = string(ob.sbjID)  + "::" + string(ob.tr);
    nfoKey = string(nfo.sbjID) + "::" + string(nfo.tr);
    [tf,loc] = ismember(obKey, nfoKey);

    ob.Cond = strings(height(ob),1);
    ob.Cond(tf) = string(nfo.(condCol)(loc(tf)));
    ob.Cond(~tf) = missing;

    if any(~tf)
        warning("[%d/%d] %s: %d/%d obs rows not in trialNfo (left as <missing>)",...
            s,nSbj,sum(~tf),numel(tf),sbj);
    end

    % Save back in place (preserves other vars in the file)
    save(obFn,"ob","-append");
    fprintf("[%d/%d] %s: Cond added (%d/%d matched) | toc=%.1fs\n",...
        s,nSbj,sbj,sum(tf),numel(tf),toc(tt));
end

fprintf("[mmr_addCond_ob] Done | toc=%.1fs\n",toc(tt));
