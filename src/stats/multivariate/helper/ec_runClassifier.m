function [sts,obs] = ec_runClassifier(xs,sts,obs,o)
% ec_runClassifier - runs classifier for electroCUDA multivariate routines
% s=16; xs=x{s}; sts=st(s,:); obs=ob{s};

% Add CV for hyperparameter tuning opts
oho = o.HyperparameterOptimizationOptions; % extract options
oho.CVPartition = sts.cvh{1};


%% Train & optimize
oo = namedargs2cell(o.hyper);
mdl = o.fun(xs(obs.use,:),obs.y(obs.use),oo{:},'Cost',sts.cost{1},...
    'OptimizeHyperparameters',o.OptimizeHyperparameters,...
    'HyperparameterOptimizationOptions',oho);


%% Cross-classify 
if any(obs.cc)
    [obs.pred(obs.cc),obs.pp(obs.cc,:)] = mdl.predict(xs(obs.cc,:));
end


%% Cross-validate (stratified CV to handle unbalanced classes)
if isequal(o.fun,@fitclinear)
    % fitclinear must be run again for CV 
    oo = ec_extractHyperparams(mdl,o); % extract optimized hyperparameters from main model
    oo = namedargs2cell(oo);
    % Run fitclinear with CV
    mdlCV = o.fun(xs(obs.use,:),obs.y(obs.use),oo{:},'Cost',sts.cost{1},...
        'CVPartition',sts.cv{1});
else
    mdlCV = mdl.crossval(CVPartition=sts.cv{1});
end

% Predict CV data
[obs.pred(obs.use),obs.pp(obs.use,:)] = mdlCV.kfoldPredict;

% Get CV performance
rocm = rocmetrics(mdlCV,alpha=o.alpha);
[sts.auc,aucL,aucU] = rocm.auc;
sts.loss = mdlCV.kfoldLoss; % (Mode="individual")'


%% Calculate classifier metrics
N = nnz(obs.use);
Nx = nnz(obs.cc);

% Observations
obs.acc = obs.pred==obs.y; % accuracy
obs.pp1 = diff(obs.pp,1,2); % posterior probability difference

% CV accuracy
sts.acc = mean(obs.acc(obs.use),"omitmissing");
sts.acc_SE = std(obs.acc(obs.use),"omitmissing")/sqrt(N);
sts.acc_p = 1 - binocdf(nnz(obs.acc(obs.use))-1, N, 0.5);

% CV balanced accuracy (ROC AUC)
sts.auc1 = mean(sts.auc,"omitmissing");
sts.auc1_CI = [mean(aucL,"omitmissing") mean(aucU,"omitmissing")];
% figure out AUC p-value???
% **OR** USE f1-score & its p-value?? (fit to binomial dist?)

% CV posterior probability
sts.pp = mean(obs.pp(obs.use,:),"omitmissing");
sts.pp1 = mean(obs.pp1(obs.use),"omitmissing");
sts.pp1_SE = std(obs.pp1(obs.use),"omitmissing")/sqrt(N);
[~,sts.pp1_p] = ttest(obs.pp1(obs.use));

% CC posterior probability
if any(obs.cc)
    sts.ppx = mean(obs.pp(obs.cc,:),"omitmissing");
    sts.ppx1 = mean(obs.pp1(obs.cc),"omitmissing");
    sts.ppx1_SE = std(obs.pp1(obs.cc),"omitmissing")/sqrt(Nx);
    [~,sts.ppx1_p] = ttest(obs.pp1(obs.cc));
end