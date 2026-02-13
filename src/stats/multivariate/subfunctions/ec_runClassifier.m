function [act,rct] = ec_runClassifier(xct,act,rct,o)
% ec_runClassifier - runs classifier for electroCUDA multivariate routines

% Get observation indices
idt = act.use; % Training/testing/CV
idx = ismember(act.cnd,o.condx); % Cross-classification 

% Add CV for hyperparameter tuning opts
oho = o.HyperparameterOptimizationOptions; % extract options
oho.CVPartition = rct.cvh{1};


%% Train & optimize
oo = namedargs2cell(o.hyper);
mdl = o.fun(xct(idt,:),act.y(idt),oo{:},'Cost',rct.cost{1},...
    'OptimizeHyperparameters',o.OptimizeHyperparameters,...
    'HyperparameterOptimizationOptions',oho);


%% Cross-classify 
if any(idx)
    [act.pred(idx),act.pp(idx,:)] = mdl.predict(xct(idx,:));
end


%% Cross-validate (stratified CV to handle unbalanced classes)
if isequal(o.fun,@fitclinear)
    % fitclinear must be run again for CV 
    oo = ec_extractHyperparams(mdl,o); % extract optimized hyperparameters from main model
    oo = namedargs2cell(oo);
    % Run fitclinear with CV
    mdlCV = o.fun(xct(idt,:),act.y(idt),oo{:},'Cost',rct.cost{1},...
        'CVPartition',rct.cv{1});
else
    mdlCV = mdl.crossval(CVPartition=rct.cv{1});
end

% Predict CV data
[act.pred(idt),act.pp(idt,:)] = mdlCV.kfoldPredict;

% Get CV performance
rocm = rocmetrics(mdlCV,alpha=o.alpha);
[rct.auc,aucL,aucU] = rocm.auc;
rct.loss = mdlCV.kfoldLoss; % (Mode="individual")'


%% Calculate classifier metrics
N = nnz(idt);
Nx = nnz(idx);

% Observations
act.acc = act.pred==act.y; % accuracy
act.pp1 = diff(act.pp,1,2); % posterior probability difference

% CV accuracy
rct.acc = mean(act.acc(idt),"omitmissing");
rct.acc_SE = std(act.acc(idt),"omitmissing")/sqrt(N);
rct.acc_p = 1 - binocdf(nnz(act.acc(idt))-1, N, 0.5);

% CV balanced accuracy (ROC AUC)
rct.auc1 = mean(rct.auc,"omitmissing");
rct.auc1_CI = [mean(aucL,"omitmissing") mean(aucU,"omitmissing")];
% figure out AUC p-value???
% **OR** USE f1-score & its p-value?? (fit to binomial dist?)

% CV posterior probability
rct.pp = mean(act.pp(idt,:),"omitmissing");
rct.pp1 = mean(act.pp1(idt),"omitmissing");
rct.pp1_SE = std(act.pp1(idt),"omitmissing")/sqrt(N);
[~,rct.pp1_p] = ttest(act.pp1(idt));

% CC posterior probability
if any(idx)
    rct.ppx = mean(act.pp(idx,:),"omitmissing");
    rct.ppx1 = mean(act.pp1(idx),"omitmissing");
    rct.ppx1_SE = std(act.pp1(idx),"omitmissing")/sqrt(Nx);
    [~,rct.ppx1_p] = ttest(act.pp1(idx));
end