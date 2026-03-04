function [obs,sts] = ec_runClassifier(xs,obs,sts,o)
% ec_runClassifier - runs classifier for electroCUDA multivariate routines

% Get observation indices
idt = obs.use; % Training/testing/CV
idx = ismember(obs.cnd,o.condx); % Cross-classification 

% Add CV for hyperparameter tuning opts
oho = o.HyperparameterOptimizationOptions; % extract options
oho.CVPartition = sts.cvh{1};


%% Train & optimize
oo = namedargs2cell(o.hyper);
mdl = o.fun(xs(idt,:),obs.y(idt),oo{:},'Cost',sts.cost{1},...
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
    mdlCV = o.fun(xs(idt,:),obs.y(idt),oo{:},'Cost',sts.cost{1},...
        'CVPartition',sts.cv{1});
else
    mdlCV = mdl.crossval(CVPartition=sts.cv{1});
end

% Predict CV data
[obs.pred(idt),obs.pp(idt,:)] = mdlCV.kfoldPredict;

% Get CV performance
rocm = rocmetrics(mdlCV,alpha=o.alpha);
[sts.auc,aucL,aucU] = rocm.auc;
sts.loss = mdlCV.kfoldLoss; % (Mode="individual")'


%% Calculate classifier metrics
N = nnz(idt);
Nx = nnz(idx);

% Observations
obs.acc = obs.pred==obs.y; % accuracy
obs.pp1 = diff(obs.pp,1,2); % posterior probability difference

% CV accuracy
sts.acc = mean(obs.acc(idt),"omitmissing");
sts.acc_SE = std(obs.acc(idt),"omitmissing")/sqrt(N);
sts.acc_p = 1 - binocdf(nnz(obs.acc(idt))-1, N, 0.5);

% CV balanced accuracy (ROC AUC)
sts.auc1 = mean(sts.auc,"omitmissing");
sts.auc1_CI = [mean(aucL,"omitmissing") mean(aucU,"omitmissing")];
% figure out AUC p-value???
% **OR** USE f1-score & its p-value?? (fit to binomial dist?)

% CV posterior probability
sts.pp = mean(obs.pp(idt,:),"omitmissing");
sts.pp1 = mean(obs.pp1(idt),"omitmissing");
sts.pp1_SE = std(obs.pp1(idt),"omitmissing")/sqrt(N);
[~,sts.pp1_p] = ttest(obs.pp1(idt));

% CC posterior probability
if any(idx)
    sts.ppx = mean(obs.pp(idx,:),"omitmissing");
    sts.ppx1 = mean(obs.pp1(idx),"omitmissing");
    sts.ppx1_SE = std(obs.pp1(idx),"omitmissing")/sqrt(Nx);
    [~,sts.ppx1_p] = ttest(obs.pp1(idx));
end