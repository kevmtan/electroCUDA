function [sts,obs] = ec_classify(xs,sts,obs,o)
% Run classifier for electroCUDA multivariate routines
%
% TO DO: custom CV loop, custom nested CV partitioning, deal with NaNs?
%
%   s=207; xs=x{s}; sts=st(s,:); obs=ob{s};


%% Train & optimize (full training set)
if o.doCC || ~o.doCV || (o.doTuning && o.doCV && ~o.doNestedCV)
    % Extract options
    oo = namedargs2cell(o.hyper);
    oho = o.HyperparameterOptimizationOptions; % hyperparameter tuning opts
    if o.doTuning; oho.CVPartition = sts.cvh{1}; end % hyperparameter tuning CV partition

    % Fit classifier
    mdl = o.fun(xs(obs.use,:),obs.y(obs.use),oo{:},'Cost',sts.cost{1},...
        'OptimizeHyperparameters',o.OptimizeHyperparameters,...
        'HyperparameterOptimizationOptions',oho);
    mdl_exist = true;

    % Fit SVM score to posterior probability transform
    if isequal(o.fun,@fitcsvm); mdl = mdl.fitPosterior; end
else
    mdl_exist = false;
end


%% Cross-classify 
if o.doCC
    [obs.pred(obs.cc),obs.pp(obs.cc,:)] = mdl.predict(xs(obs.cc,:));
end


%% Cross-validate
if o.doCV
    if o.doNestedCV
        % Nested CV options
        oo = namedargs2cell(o.hyper);
        oho = o.HyperparameterOptimizationOptions; % hyperparameter tuning opts
        % NOT YET IMPLEMENTED: oho.CVPartition = sts.cvhn{1}; %% inner CV partition

        % Fit nested CV classifier
        mdlCV = o.fun(xs(obs.use,:),obs.y(obs.use),oo{:},'Cost',sts.cost{1},...
            'CV',sts.cv{1},'OptimizeHyperparameters',o.OptimizeHyperparameters,...
            'HyperparameterOptimizationOptions',oho);
    else
        % Flat CV
        if ~mdl_exist || isequal(o.fun,@fitclinear) % fitclinear must be called again for CV
            % Extract options
            if mdl_exist && o.doTuning
                oo = extractHyperparams_lfn(mdl,o); % Tuned hyperparams from full model
            else
                oo = o.hyper;
            end
            oo = namedargs2cell(oo);

            % Fit CV classifier
            mdlCV = o.fun(xs(obs.use,:),obs.y(obs.use),oo{:},'Cost',sts.cost{1},...
                'CVPartition',sts.cv{1});
        else
            % CV on full model
            mdlCV = mdl.crossval('CVPartition',sts.cv{1});
        end
    end

    % Fit SVM score to posterior probability transform
    if isequal(o.fun,@fitcsvm); mdlCV = fitSVMPosterior(mdlCV); end

    % CV predict
    [obs.pred(obs.use),obs.pp(obs.use,:)] = mdlCV.kfoldPredict;

    % CV loss
    sts.loss = mdlCV.kfoldLoss; % (Mode="individual")'

    % ROC
    rocm = rocmetrics(mdlCV,ConfidenceIntervalType="none");
else
    % No CV - predict training obs with full model
    [obs.pred(obs.use),obs.pp(obs.use,:)] = mdl.predict(xs(obs.use,:));

    % ROC
    rocm = rocmetrics(obs.y(obs.use),obs.pp(obs.use,:),mdl.ClassNames,...
        ConfidenceIntervalType="none");
end


%% Calculate classifier metrics
N = nnz(obs.use);
Nx = nnz(obs.cc);

% Platt scaling: classificaton scores to posterior probability
if o.doPlatt                    
    obs = platt_lfn(obs,sts,o); % needed for fitclinear SVM, etc
end

% Observation-level metrics
obs.acc = obs.pred==obs.y; % accuracy
obs.pp1 = diff(obs.pp,1,2); % posterior probability difference


% CV accuracy
sts.acc = mean(obs.acc(obs.use),"omitmissing");
sts.acc_SE = std(obs.acc(obs.use),"omitmissing")/sqrt(N);
sts.acc_p = 1 - binocdf(nnz(obs.acc(obs.use))-1, N, 0.5);

% Precision-recall AUC
sts.auc = rocm.auc("pr");  
sts.auc1 = mean(sts.auc,"omitmissing");
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






function obs = platt_lfn(obs,sts,o)
%%% Platt scaling: classificaton scores to posterior probability %%%%%%%%%%
if width(obs.pp)~=2
    warning("Platt scaling only implemented for binary classification. "+...
        "Unbounded classification scores not converted to posterior probability.")
    return
end

% Positive class
class1 = categories(obs.y,OutputType="categorical");
class1 = class1(end);

% Training set labels & scores (convert to double for glmfit)
y = double(obs.y(obs.use)==class1); % labels
scores = double(obs.pp(obs.use,end)); % scores


%% Platt scaling for unpartitioned- or cross-classification scores
if ~o.doCV || o.doCC
    % If CV was performed, fitting uses scores from CV model (ideal)
    % If CV wasn't performed, fitting uses scores from full model (unstable)

    % Fit scaling coefficients on full training set
    [b,ok] = plattFit_lfn(y,scores);

    % Apply scaling on unpartitioned-classification scores
    if ~o.doCV && ok
        obs.pp(obs.use,:) = plattApply_lfn(b,scores);
    end

    % Apply scaling on cross-classification scores
    if o.doCC && ok
        obs.pp(obs.cc,:) = plattApply_lfn(b,obs.pp(obs.cc,end));
    end
    if ~ok; warning("[ec_classify] Platt scaling not applied for CC/noCV scores: "+sts.sbjCh+" t="+sts.t); end
end


%% Platt scaling for CV classification  (fold-safe using assignments in sts.cv)
if o.doCV
    [obs.pp(obs.use,:),ok] = plattCV_lfn(y,scores,sts.cv{1},obs.pp(obs.use,:));
end
if ~ok; warning("[ec_classify] Platt scaling not applied for CV scores: "+sts.sbjCh+" t="+sts.t); end






function [pp,okAll] = plattCV_lfn(y,scores,cv,pp)
%%% Platt scaling on CV folds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
okAll = false(cv.NumTestSets,1);

% Loop across test sets
for k = 1:cv.NumTestSets
    idTest = test(cv,k);
    idTrain = training(cv,k);

    % Fit scaling on fold-train scores only
    [b,ok] = plattFit_lfn(y(idTrain),scores(idTrain));
    okAll(k) = ok;
    if ~ok; continue; end

    % Apply to fold-test raw out-of-fold scores
    pp(idTest,:) = plattApply_lfn(b,scores(idTest));
end
okAll = all(okAll);





function [b,ok] = plattFit_lfn(y,scores)
%%% Fit Platt scaling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Index of useable scores
id = isfinite(scores) & ~isnan(scores);

% Fit logistic regression (if more than 3 good obs)
if nnz(id) > 3
    b = glmfit(scores(id),y,"binomial",LikelihoodPenalty="jeffreys-prior");
    ok = true;
else
    ok = false;
    b = [];
    warning("[ec_classify] Not enough useable scores for Platt scaling fitting");
end





function pp = plattApply_lfn(b,scores)
%%% Apply Platt scaling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p2 = glmval(b,scores,"logit");
p2 = min(max(p2,eps(like=scores)),1-eps(like=scores));
pp = [1-p2 p2];






function oh = extractHyperparams_lfn(mdl,o)
%%% Extract hyperparameters from classifier model %%%%%%%%%%%%%%%%%%%%%%%%%
oh = o.hyper;

% Loop across hyperparameters
for p = 1:numel(o.OptimizeHyperparameters)
    param = o.OptimizeHyperparameters(p); % parameter name
    oh.(param) = mdl.(param); % extract parameter
    if param=="Regularization" % handle special case for Regularization
        oh.(param) = extractBefore(oh.(param)," "); end
end
