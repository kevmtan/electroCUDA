function [o,logs,sts,obs] = mmr_cSpecLoad(oa)
arguments
    oa struct
end
% [o,logs,sts,obs] = mmr_cSpecLoad(oa);

%% Load

% Load o struct from oa.analDir/o_<analName>.mat
[~, analName] = fileparts(oa.analDir);
load(string(oa.analDir)+filesep+"o_"+analName, "o");

% Load logs
load(o.analOut+"logs_"+o.analName,"logs");
if any(~logs.class)
    warning("Skipping unfinished subjects: "+join(logs.sbj(~logs.class),", "));
end

% Limit to finished subjects
logs = logs(logs.class,:);
nSbj = height(logs);

% Preallocate
obs = cell(nSbj,1); % observations from all sbjs
sts = cell(nSbj,1); % original stats table from ec_classifySpec

% Load observations across subjects
parfor s = 1:nSbj
    [obs{s},sts{s}] = loadSbj_lfn(logs(s,:),oa,o);
end

% Concatenate subjects
sts = vertcat(sts{:});
obs = vertcat(obs{:});



function [ob,st] = loadSbj_lfn(logS,oa,o)
%%% Load subject data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(logS.ob,"ob");
load(logS.st,"st");

% Rename timevar/condvar for simplicity
ob = renamevars(ob,[oa.timeVar o.p.condVar],["time" "cnd"]);
st = renamevars(st,[oa.timeVar],"time");

% Make ROIs ordinal categoricals in tables (ROIs in 'ch' var)
ob.ch = categorical(ob.ch,o.p.ROIs,Ordinal=true);
st.ch = categorical(st.ch,o.p.ROIs,Ordinal=true);