function stat = mmr_cSpecAnal_ROI(logs)
% load("/01/lbcn/anal/classifySpecROI/MzAb_SVM_260414_0745/log_260414_0745.mat");
% stat = mmr_cSpecAnal_ROI(logs);

%% Prep
tt = tic; % start timer
nSbj = height(logs);
o = logs.o{1};

% Preallocate
oba = cell(nSbj,1); % observations from all sbjs

% Load data
for s = 1:height(logs)
    % Observations
    load(logs.o{s}.saved.ob,"ob");
    oba{s} = ob;
end

% Concatenate
oba = vertcat(oba{:});

% Make ROIs ordinal categoricals in tables (ROIs in 'ch' var)
oba.ch = categorical(oba.ch,o.p.ROIs,Ordinal=true);

% Rename timevar/condvar for simplicity
oba = renamevars(oba,[o.p.timeVar o.p.condVar],["t" "cnd"]);

% Split observations table
oba = splitapply(@(id) {oba(id,:)},(1:height(oba))',findgroups(oba.ch,oba.t));
splits = height(oba);

% Preallocate stats table
stat = cell(splits,1);
disp("Finished prep: toc="+toc(tt));


%% Analyze within splits
parfor s = 1:splits
    stat{s} = analyze_lfn(oba{s},o);
end
disp("Ran analyses across splits: toc="+toc(tt));

% Concatenate
stat = vertcat(stat{:});


%% FDR
vs = string(stat.Properties.VariableNames);
vsP = vs(endsWith(vs,"_p")); % pval vars
vsQ = vs(endsWith(vs,"_q")); % fdr vars
id = stat.t>=o.fdrTimeRng(1) & stat.t<=o.fdrTimeRng(2); % fdr time range

% Loop across q vars
for v = 1:numel(vsQ)
    % Loop across var columns -- KEEP THIS??
    for w = 1:width(stat.(vsQ(v)))
        % do FDR
        stat.(vsQ(v))(id,w) = ec_fdr(stat.(vsP(v))(id,w),...
            o.alpha,o.fdrDep);
    end
end
disp("Ran FDR: toc="+toc(tt));


%% Save
fn = o.dirOut+"stat.mat";
save(fn,"stat","-v7");
disp("Saved classificiation statistics: "+fn+" toc="+toc(tt));







function sts = analyze_lfn(obs,o)
%%% Within-split analyses %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% obs = oba{514};

% Convert to double-precision
obs = convertvars(obs,varfun(@isfloat,obs,"OutputFormat","uniform"),"double");

% Initialize stats table
sts = table;
sts.roi = obs.ch(1);
sts.t = obs.t(1);


%% Model performance

% Accuracy stats (exact binomial test)
[sts.acc,sts.acc_p,sts.acc_SE] = ec_binomTest(obs.acc(obs.use));
sts.acc_q = nan;

% Accuracy: Logistic mixed-effects
lme = fitglme(obs(obs.use,["acc" "sbjID" "tr"]),'acc ~ 1 + (1|sbjID) + (1|sbjID:tr)',...
    Distribution="Binomial",Link="logit",FitMethod="REMPL");
sts.accl = lme.Coefficients.Estimate;
sts.accl_SE = lme.Coefficients.SE;
sts.accl_p = lme.Coefficients.pValue;
sts.accl_q = nan;

% % ROC
% rocm = rocmetrics(obs.y(obs.use),obs.pp(obs.use,:),o.p.cond);
% 
% % Precision-recall AUC
% sts.auc = rocm.auc("pr");  
% sts.auc1 = mean(sts.auc,"omitmissing");


%% Posterior probability

% PP of main conds (training set)
for c = 1:numel(o.p.cond)
    id = obs.cnd == o.p.cond(c);
    [sts.ppc(1,c),sts.ppc_p(1,c),sts.ppc_SE(1,c)] = ec_ttest(obs.pp1(id));
    sts.ppc_q(1,c) = nan;
end

% PP of cross-classification conds
for c = 1:numel(o.p.condx)
    id = obs.cnd == o.p.condx(c);
    [sts.ppxc(1,c),sts.ppxc_p(1,c),sts.ppxc_SE(1,c)] = ec_ttest(obs.pp1(id));
    sts.ppxc_q(1,c) = nan;
end

% PP diff of main conds
lme = fitlme(obs(obs.use,:),"pp1 ~ y + (1|sbjID)",FitMethod="REML");
sts.ppc1 = lme.Coefficients.Estimate(2);
sts.ppc1_SE = lme.Coefficients.SE(2);
sts.ppc1_p = lme.Coefficients.pValue(2);
sts.ppc1_q = nan;

% PP diff of CC conds
if o.doCC
    lme = fitlme(obs(obs.cc,:),"pp1 ~ cx + (1|sbjID)",FitMethod="REML");
    sts.ppxc1 = lme.Coefficients.Estimate(2);
    sts.ppxc1_SE = lme.Coefficients.SE(2);
    sts.ppxc1_p = lme.Coefficients.pValue(2);
    sts.ppxc1_q = nan;
end


%% Regression on PP

% Behavioral response time
lme = fitlme(obs(obs.use,:),"pp1 ~ RT + (RT|sbjID:tr)",FitMethod="REML");
sts.ppr_RT = lme.Coefficients.Estimate(2);
sts.ppr_RT_SE = lme.Coefficients.SE(2);
sts.ppr_RT_p = lme.Coefficients.pValue(2);
sts.ppr_RT_q = nan;

% Behavioral response choice
lme = fitlme(obs(obs.use,:),"pp1 ~ resp + (resp|sbjID:tr)",FitMethod="REML");
sts.ppr_RC = lme.Coefficients.Estimate(2);
sts.ppr_RC_SE = lme.Coefficients.SE(2);
sts.ppr_RC_p = lme.Coefficients.pValue(2);
sts.ppr_RC_q = nan;


%% Regression on CC PP
if o.doCC
    % Behavioral response time
    lme = fitlme(obs(obs.cc,:),"pp1 ~ RT + (RT|sbjID:tr)",FitMethod="REML");
    sts.ppxr_RT = lme.Coefficients.Estimate(2);
    sts.ppxr_RT_SE = lme.Coefficients.SE(2);
    sts.ppxr_RT_p = lme.Coefficients.pValue(2);
    sts.ppxr_RT_q = nan;

    % Behavioral response choice
    lme = fitlme(obs(obs.cc,:),"pp1 ~ resp + (resp|sbjID:tr)",FitMethod="REML");
    sts.ppxr_RC = lme.Coefficients.Estimate(2);
    sts.ppxr_RC_SE = lme.Coefficients.SE(2);
    sts.ppxr_RC_p = lme.Coefficients.pValue(2);
    sts.ppxr_RC_q = nan;

    % Affective valence
    lme = fitlme(obs(obs.cc,:),"pp1 ~ valence + (valence|sbjID:tr)",FitMethod="REML");
    sts.ppxr_val = lme.Coefficients.Estimate(2);
    sts.ppxr_val_SE = lme.Coefficients.SE(2);
    sts.ppxr_val_p = lme.Coefficients.pValue(2);
    sts.ppxr_val_q = nan;
end

