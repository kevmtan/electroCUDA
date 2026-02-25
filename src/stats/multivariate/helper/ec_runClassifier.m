function [obs,stats] = ec_runClassifier(xs,obs,stats,o)
% ec_runClassifier - runs classifier for electroCUDA multivariate routines

% Get observation indices
idt = obs.use; % Training/testing/CV
idx = ismember(obs.cnd,o.condx); % Cross-classification 

% Add CV for hyperparameter tuning opts
oho = o.HyperparameterOptimizationOptions; % extract options
oho.CVPartition = stats.cvh{1};


%% Train & optimize
oo = namedargs2cell(o.hyper);
mdl = o.fun(xs(idt,:),obs.y(idt),oo{:},'Cost',stats.cost{1},...
    'OptimizeHyperparameters',o.OptimizeHyperparameters,...
    'HyperparameterOptimizationOptions',oho);


%% Cross-classify 
if any(idx)
    [obs.pred(idx),obs.pp(idx,:)] = mdl.predict(xs(idx,:));
end


%% Cross-validate (stratified CV to handle unbalanced classes)
if isequal(o.fun,@fitclinear)
    % fitclinear must be run again for CV 
    oo = ec_extractHyperparams(mdl,o); % extract optimized hyperparameters from main model
    oo = namedargs2cell(oo);
    % Run fitclinear with CV
    mdlCV = o.fun(xs(idt,:),obs.y(idt),oo{:},'Cost',stats.cost{1},...
        'CVPartition',stats.cv{1});
else
    mdlCV = mdl.crossval(CVPartition=stats.cv{1});
end

% Predict CV data
[obs.pred(idt),obs.pp(idt,:)] = mdlCV.kfoldPredict;

% Get CV performance
rocm = rocmetrics(mdlCV,alpha=o.alpha);
[stats.auc,aucL,aucU] = rocm.auc;
stats.loss = mdlCV.kfoldLoss; % (Mode="individual")'


%% Calculate classifier metrics
N = nnz(idt);
Nx = nnz(idx);

% Observations
obs.acc = obs.pred==obs.y; % accuracy
obs.pp1 = diff(obs.pp,1,2); % posterior probability difference

% CV accuracy
stats.acc = mean(obs.acc(idt),"omitmissing");
stats.acc_SE = std(obs.acc(idt),"omitmissing")/sqrt(N);
stats.acc_p = 1 - binocdf(nnz(obs.acc(idt))-1, N, 0.5);

% CV balanced accuracy (ROC AUC)
stats.auc1 = mean(stats.auc,"omitmissing");
stats.auc1_CI = [mean(aucL,"omitmissing") mean(aucU,"omitmissing")];
% figure out AUC p-value???
% **OR** USE f1-score & its p-value?? (fit to binomial dist?)

% CV posterior probability
stats.pp = mean(obs.pp(idt,:),"omitmissing");
stats.pp1 = mean(obs.pp1(idt),"omitmissing");
stats.pp1_SE = std(obs.pp1(idt),"omitmissing")/sqrt(N);
[~,stats.pp1_p] = ttest(obs.pp1(idt));

% CC posterior probability
if any(idx)
    stats.ppx = mean(obs.pp(idx,:),"omitmissing");
    stats.ppx1 = mean(obs.pp1(idx),"omitmissing");
    stats.ppx1_SE = std(obs.pp1(idx),"omitmissing")/sqrt(Nx);
    [~,stats.ppx1_p] = ttest(obs.pp1(idx));
end