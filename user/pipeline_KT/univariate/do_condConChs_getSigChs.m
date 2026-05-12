% Initialize options
oa = struct;
oa.save = true; % !!!!!!!!!!!

% Channelwise analysis directory (must match the analDir+analName used in ec_condConChs_perm)
oa.analDir = "/01/lbcn/anal/condConCh/zf_hpfLPF_bandsParam/";


%% Options

% Contrasts to do (empty = all contrasts found in the analysis)
oa.contrasts = []; %["Other" "Self" "Semantic" "Episodic" "Math" "Rest"];

% Measure variable
oa.mVar = "mu";

% Significance
oa.sigVar = "q";
oa.sigThr = 0.05;
oa.sigTimeRng = [0 inf];  % time range to look for significance (ms)
oa.sigDur = 100;          % minimum contiguous duration of significance (ms)


%%
chNfoA = ec_condConChs_sigChs(oa);
