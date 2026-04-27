function [sts,obs] = ec_classify(xs,sts,obs,o)
% Run classifier for electroCUDA multivariate routines
%
% TO DO: deal with NaNs?
%
%   s=217; xs=x{s}; sts=st(s,:); obs=ob{s};


%% Early bail: no usable training observations for this split
if ~any(obs.use)
    return;
end


%% Main classification routine
[sts,obs] = main_lfn(xs,sts,obs,o,false);


%% Permutation test for accuracy/performance significance
if o.permutations
    sts = permute_lfn(xs,sts,obs,o);
end


%% Classifier metrics

% Platt scaling: classificaton scores to posterior probability (PP)
if o.doPlatt                    
    obs = platt_lfn(obs,sts,o); % needed for fitclinear SVM, etc
end

% PP difference across class scores
obs.pp1 = diff(obs.pp,1,2);

% PP of training set classification
sts.pp = mean(obs.pp(obs.use,:),"omitmissing"); % PP mean
[sts.pp1,sts.pp1_p,sts.pp1_SE] = ec_ttest(obs.pp1(obs.use)); % PP difference test

% PP of cross-classification
if o.doCC
    sts.ppx = mean(obs.pp(obs.cc,:),"omitmissing"); % PP mean
    [sts.ppx1,sts.ppx1_p,sts.ppx1_SE] = ec_ttest(obs.pp1(obs.cc)); % PP difference test
end

% PP of main conds (training set)
for c = 1:numel(o.p.cond)
    id = obs.cnd == o.p.cond(c);
    [sts.ppc(1,c),sts.ppc_p(1,c),sts.ppc_SE(1,c)] = ec_ttest(obs.pp1(id));
end

% PP of cross-classification conds
for c = 1:numel(o.p.condx)
    id = obs.cnd == o.p.condx(c);
    [sts.ppxc(1,c),sts.ppxc_p(1,c),sts.ppxc_SE(1,c)] = ec_ttest(obs.pp1(id));
end

% PP diff of main conds
lm = fitlm(obs(obs.use,:),"pp1 ~ y");
sts.ppc1(1,:) = lm.Coefficients.Estimate(2:end)';
sts.ppc1_SE(1,:) = lm.Coefficients.SE(2:end)';
sts.ppc1_p(1,:) = lm.Coefficients.pValue(2:end)';

% PP diff of CC conds
if o.doCC
    lm = fitlm(obs(obs.cc,:),"pp1 ~ cx");
    sts.ppxc1(1,:) = lm.Coefficients.Estimate(2:end)';
    sts.ppxc1_SE(1,:) = lm.Coefficients.SE(2:end)';
    sts.ppxc1_p(1,:) = lm.Coefficients.pValue(2:end)';
end


%% Custom classifier metrics
if ~isempty(o.metricFun)
    [sts,obs] = o.metricFun(sts,obs,o);
end






function [sts,obs] = main_lfn(xs,sts,obs,o,isTest)
%%% Main classification routine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% isTest = currently being performed for permutation testing
%
% Performs classification & cross-classification
% Necessary parts of routine are repeated for permutation testing of
% classifier performance significance

% TEST - make this more elegant
%if sts.t<0; o.doTuning=false; end

% Bail if no training observations (defensive; ec_classify also checks)
if ~any(obs.use); return; end

% Error if the training matrix is entirely NaN (unfittable)
if all(isnan(xs(obs.use,:)),"all")
    error("[ec_classify] Training data is all NaN for %s t=%g (split has %d 'use' obs).",...
        sts.sbjCh,sts.t,nnz(obs.use));
end


%% Train & optimize (full training set)
if ~o.doCV || (o.doCV && ~o.doNestedCV && o.doTuning) || (o.doCC && ~isTest)
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
    if isequal(o.fun,@fitcsvm)
        mdl = mdl.fitPosterior; end

    % Save tuned hyperparameters
    if o.doTuning && ~any(o.OptimizeHyperparameters=="auto")
        sts = saveHyperparams_lfn(sts,mdl,o); end
else
    mdl_exist = false;
end


%% Cross-classify 
if o.doCC && ~isTest
    [obs.pred(obs.cc),obs.pp(obs.cc,:)] = mdl.predict(xs(obs.cc,:));
end


%% Cross-validate
if o.doCV
    if o.doNestedCV
        [obs,sts] = nestedCV_lfn(xs,obs,sts,o);
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

    if ~o.doNestedCV
        % Fit SVM score to posterior probability transform
        if isequal(o.fun,@fitcsvm)
            mdlCV = fitSVMPosterior(mdlCV); end

        % CV predict
        [obs.pred(obs.use),obs.pp(obs.use,:)] = mdlCV.kfoldPredict;

        % CV loss
        sts.loss = mdlCV.kfoldLoss; % (Mode="individual")'
    end
else
    % No CV - predict training obs with full model
    [obs.pred(obs.use),obs.pp(obs.use,:)] = mdl.predict(xs(obs.use,:));
end

%% Performance

% Accurately-classified observations
obs.acc = obs.pred==obs.y;

% Accuracy stats (parametric)
[sts.acc,sts.acc_p,sts.acc_SE] = ec_binomTest(obs.acc(obs.use));

% ROC
if o.doCV && ~o.doNestedCV
    % Calculate ROC for flat CV using mdlCV object
    rocm = rocmetrics(mdlCV,ConfidenceIntervalType="none");
else
    % Calculate ROC for nested CV & no CV using observation-level scores
    rocm = rocmetrics(obs.y(obs.use),obs.pp(obs.use,:),categories(obs.y(obs.use)));
end

% Precision-recall AUC
sts.auc = rocm.auc("pr");  
sts.auc1 = mean(sts.auc,"omitmissing");






function [obs,sts] = nestedCV_lfn(xs,obs,sts,o)
%%% Explicit nested CV outer-loop classification %%%%%%%%%%%%%%%%%%%%%%%%%%%
cvOuter = sts.cv{1};
cvInner = sts.cvhn{1};
nOuter = cvOuter.NumTestSets;
idUse = find(obs.use);

% Preallocate CV outputs at "use" level then write back to obs.
predUse = repmat(categorical(missing,categories(obs.y),Ordinal=true),numel(idUse),1);
ppUse = nan(numel(idUse),numel(categories(obs.y)),like=obs.pp);
foldLoss = nan(nOuter,1,like=sts.loss);

for k = 1:nOuter
    idOuterTrainLocal = training(cvOuter,k);
    idOuterTestLocal = test(cvOuter,k);

    % Build per-fold inner CV on outer-train observations
    oo = namedargs2cell(o.hyper);
    oho = o.HyperparameterOptimizationOptions;
    oho.CVPartition = cvInner{k};

    mdlFold = o.fun(xs(idUse(idOuterTrainLocal),:),obs.y(idUse(idOuterTrainLocal)),oo{:},'Cost',sts.cost{1},...
        'OptimizeHyperparameters',o.OptimizeHyperparameters,...
        'HyperparameterOptimizationOptions',oho);

    % Fit SVM score-to-posterior transform for this fold model
    if isequal(o.fun,@fitcsvm)
        mdlFold = mdlFold.fitPosterior;
    end

    % Predict on this outer test fold
    [predUse(idOuterTestLocal),ppUse(idOuterTestLocal,:)] = ...
        mdlFold.predict(xs(idUse(idOuterTestLocal),:));

    % Zero-one fold loss on held-out outer fold
    foldLoss(k) = mean(predUse(idOuterTestLocal) ~= obs.y(idUse(idOuterTestLocal)));
end

% Save nested CV predictions and loss
obs.pred(obs.use) = predUse;
obs.pp(obs.use,:) = ppUse;
sts.loss = mean(foldLoss,"omitmissing");






function sts = permute_lfn(xs,sts,obs,o)
%%% Permutation testing for classifier performance significance %%%%%%%%%%%
%
% TO DO:  figure out threshold for mean PR-AUC (o.perfVar=="auc1")

% Only do permutation test for above-chance acurracy, otherwise the
% parametric test result is kept to save compute)
if o.perfVar=="acc" && sts.acc < 1/numel(o.p.cond)
    return; end

% Stats info
stat = sts.(o.perfVar); % actual perfomance statistic value
yObsOg = obs.y(obs.use); % original labels (observation-level)
trObs = obs.tr(obs.use); % trial IDs for training observations
[trials,~,trIdx] = unique(trObs,"stable");
nTrials = numel(trials);

% One label per trial for grouped shuffling
yTrialOg = yObsOg(accumarray(trIdx,(1:numel(trIdx))',[],@(ii) ii(1)));

% Safety check: all observations within each trial should share one label
if any(yObsOg ~= yTrialOg(trIdx))
    error("[ec_classify] Training observations within a trial have inconsistent labels; cannot run trial-grouped permutation test.");
end

% Preallocate permuted performance distribution
statPerm = nan(o.permutations,1,like=sts.(o.perfVar));

% Loop across permutations
for p = 1:o.permutations
    % Shuffle labels at trial level (all obs from a trial share one label)
    yTrialPerm = yTrialOg(randperm(nTrials));
    obs.y(obs.use) = yTrialPerm(trIdx); % broadcast trial label to all trial observations

    % Run classification routine on shuffled labels
    sts1 = main_lfn(xs,sts,obs,o,true);

    % Save performance testing statistic
    statPerm(p) = sts1.(o.perfVar);
end

% Calculate p-value
sts.(o.perfVar+"_p") = (nnz(statPerm>=stat) + 1) / (o.permutations + 1);






function obs = platt_lfn(obs,sts,o)
%%% Platt scaling: top-level routine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    % TO DO: handle nested CV inner fold separation

    % Fit scaling coefficients on full training set
    [b,ok] = plattFit_lfn(y,scores,o);

    % Apply scaling on scores from full model (no CV) on training set
    if ~o.doCV && ok
        obs.pp(obs.use,:) = plattApply_lfn(b,scores);
    end

    % Apply scaling on cross-classification scores
    if o.doCC && ok
        obs.pp(obs.cc,:) = plattApply_lfn(b,obs.pp(obs.cc,end));
    end
    if ~ok; warning("[ec_classify] Platt scaling not applied for CC/noCV scores: "+sts.sbjCh+" t="+sts.t); end
end


%% Platt scaling for CV classification (fold-safe using assignments in sts.cv)
if o.doCV
    [obs.pp(obs.use,:),ok] = plattCV_lfn(y,scores,sts.cv{1},obs.pp(obs.use,:),o);
end
if ~ok; warning("[ec_classify] Platt scaling not applied for CV scores: "+sts.sbjCh+" t="+sts.t); end






function [pp,okAll] = plattCV_lfn(y,scores,cv,pp,o)
%%% Platt scaling on CV folds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
okAll = false(cv.NumTestSets,1);

% Loop across test sets
for k = 1:cv.NumTestSets
    idTest = test(cv,k);
    idTrain = training(cv,k);

    % Fit scaling on fold-train scores only
    [b,ok] = plattFit_lfn(y(idTrain),scores(idTrain),o);
    okAll(k) = ok;
    if ~ok; continue; end

    % Apply to fold-test raw out-of-fold scores
    pp(idTest,:) = plattApply_lfn(b,scores(idTest));
end
okAll = all(okAll);






function [b,ok] = plattFit_lfn(y,scores,o)
%%% Fit Platt scaling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Index of useable scores
id = isfinite(scores) & ~isnan(scores);

% Fit logistic regression (if more than 3 good obs)
if nnz(id) > 3
    if o.jeffreys
        b = glmfit(scores(id),y,"binomial",LikelihoodPenalty="jeffreys-prior");
    else
        b = glmfit(scores(id),y,"binomial");
    end
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

% Loop across tuned hyperparameters
for p = 1:numel(o.OptimizeHyperparameters)
    param = o.OptimizeHyperparameters(p); % parameter name
    % Extract parameter
    if param=="Regularization" % handle special case for Regularization
        oh.(param) = extractBefore(mdl.(param)," ");
    else
        oh.(param) = mdl.(param); 
    end
end






function sts = saveHyperparams_lfn(sts,mdl,o)
%%% Save tuned hyperparameters from classifier model %%%%%%%%%%%%%%%%%%%%%%

% Loop across tuned hyperparameters
for p = 1:numel(o.OptimizeHyperparameters)
    param = o.OptimizeHyperparameters(p); % parameter name
    % Extract parameter
    if param=="Regularization" % handle special case for Regularization
        sts.(param) = extractBefore(mdl.(param)," ");
    else
        sts.(param) = mdl.(param); 
    end
end

