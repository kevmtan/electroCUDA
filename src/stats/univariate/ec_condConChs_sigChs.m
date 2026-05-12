function chNfoA = ec_condConChs_sigChs(oa)
arguments
    oa struct
end


%% Prep
tt = tic; % start timer

% Locate & load analysis options ('o_<analName>.mat')
d = dir(oa.analDir+"o_*.mat");
if isempty(d)
    error("[ec_condConChs_sigChs] No options file found in: "+oa.analDir);
end
fn = oa.analDir+string(d(1).name);
load(fn,"o");
disp("[ec_condConChs_sigChs] Loaded: "+fn+" | toc="+toc(tt));

% Default contrasts list to the analysis's contrasts
if ~isfield(oa,"contrasts") || ~isany(oa.contrasts)
    oa.contrasts = string(o.contrasts);
else
    oa.contrasts = string(oa.contrasts);
end

% Sanitized field-name versions of contrasts (drop non-identifier chars)
oa.conNames = regexprep(oa.contrasts,"[^a-zA-Z0-9_]","");

% Load logs
fn = oa.analDir+"logs_"+o.analName+".mat";
load(fn,"logs");
disp("[ec_condConChs_sigChs] Loaded: "+fn+" | toc="+toc(tt));


%% Loop subjects
chNfoA = cell(height(logs),1);
parfor s = 1:height(logs)
    if ~logs.fin(s); continue; end
    try
        chNfoA{s} = runSbj_lfn(logs(s,:),oa,tt);
    catch ME
        warning("[ec_condConChs_sigChs] Failed sbj "+logs.sbj(s)+": "+getReport(ME));
    end
end


%% Concatenate & save
chNfoA = vertcat(chNfoA{:});

if isfield(oa,"save") && oa.save
    fn = oa.analDir+"chNfoA_"+o.analName+".mat";
    save(fn,"chNfoA","-v7");
    disp("[ec_condConChs_sigChs] Saved: "+fn+" | toc="+toc(tt));
end




function chNfo = runSbj_lfn(sLog,op,tt)
%%% Run subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                       s=5; sLog=logs(s,:);

% Load stats & metadata
load(sLog.st,"st")
load(sLog.n,"n");
disp("[ec_condConChs_sigChs] Loaded sbj: "+sLog.sbj+" | toc="+toc(tt));

% Per-subject sig-channels augmentation (shared kernel)
chNfo = ec_sigChsFromPerm(st,n.chNfo,op);
disp("[ec_condConChs_sigChs] Sbj done: "+sLog.sbj+" | toc="+toc(tt));
