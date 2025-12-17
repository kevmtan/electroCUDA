function [o,stats,obs] = ec_classifyChSpec(o)
% Performs classification & cross-classification within channels/sources
% across time using spectral activity as features.
%
% This function is part of the electroCUDA package:
% https://kevmtan.github.io/electroCUDA
%
% Kevin Tan, 2025

%% Input arguments
arguments
    o struct = struct % options struct (description below in "Options struct validation" section)
end
% o.test = 1;


%% Preprocessing
tt = tic; % start timer
[x,ep,n,o] = preproc_lfn(o,tt); % analysis-specific preprocessing


%% Make classifier templates
[a,r] = makeTemplates_lfn(n,ep,o,tt);
% a = analysis template
% r = results & statistics template


%% Classification
[obs,stats] = classify_lfn(x,a,r,n,o,tt);
% obs = classification of observations
% stats = classification statistics per channel & timebin

%% Save
fn = o.dirOut+"s"+n.sbjID+"_stats.mat";
save(fn,"stats","-v7");
fn = o.dirOut+"s"+n.sbjID+"_obs.mat";
save(fn,"obs","-v7");
disp("[ec_classifyChSpec] Saved classificiation results: "+fn+" toc="+toc(tt));






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prep %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% Preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,ep,n,o] = preproc_lfn(o,tt)

% Load data 
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(o.dirs,sfx=o.sfx,...
    vars=["n" "x" "psy" "trialNfo" "chNfo"],compact="n");
if numel(dbstack)<2; nOg=n; xOg=x; trialNfoOg=trialNfo; end %#ok<NASGU> % Copy origs for testing
disp("[ec_classifyChSpec] Loaded data: "+o.dirs.sbj+" | toc="+toc(tt));

% Channel/IC info
if o.ICA
    n.chNfo = n.icNfo;
    n.chNfo = renamevars(n.chNfo,["ic" "sbjIC"],["ch" "sbjCh"]);
    chBad = find(any(n.icBad{:,o.chBadFields},2)); % ICs to include in stats
else
    n.chNfo = chNfo;
    chBad = find(any(n.chBad{:,o.chBadFields},2)); % chans to include in stats
end

% Remove bad chans/ICs
x(:,chBad,:) = [];
n.chNfo(chBad,:) = [];


%% Behavioral / recording metadata

% Epoch psych/behav task data
oo = namedargs2cell(o.epoch);
[ep,trialNfo,n] = ec_epochPsy(psy,trialNfo,n,tt,oo{:}); %#ok<ASGLU>

% Rename target time & condition variables
ep = renamevars(ep,[o.timeVar o.condVar],["t" "cnd"]);

% Remove excluded times
if numel(o.timeRng)==2
    ep(ep.t<o.timeRng(1) | ep.t>o.timeRng(2),:) = []; end

% Remove excluded conditions
ep(~ismember(ep.cnd,[o.cond o.condx]),:) = [];
ep.ide = cast(1:height(ep),like=ep.ide)'; % update epoch indices


%% Analysis-specific EEG preprocessing
oo = namedargs2cell(o.pre);
[x,n] = ec_epochBaseline(x,n,psy,ep,tt,oo{:},test=o.test);
o.n = n;
o.spect = n.spect;






% Make templates for classifier %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [a,r] = makeTemplates_lfn(n,ep,o,tt)
% Prep
u0 = cast(0,like=n.chNfo.ch); % integer type
s0 = cast(nan,o.typeProc); % float type
nCond = numel(o.cond);
nCondx = numel(o.condx);

% Get vars from 'ep' to include in analysis template (to save for further analysis)
psyVars = ismember(ep.Properties.VariableNames,...
    ["run" "tr" "cnd" "t" "sbjID" "ide" o.psyVars]);


%% Make analysis template
a = ep(:,psyVars);
a.y = categorical(a.cnd,o.cond,Ordinal=true); % class (e.g. condition)
a.pred(:) = categorical("",o.cond,Ordinal=true); % predicted class
a.pp(:,1:numel(o.cond)) = s0; % posterior probability per class
a.pp1(:) = s0; % posterior probability difference
a.acc(:) = false; % accurate prediction?
a.ch(:) = u0;
a.sbjCh(:) = "";
% Organize analysis template
a = movevars(a,"sbjCh","Before",1);
a = movevars(a,["ch" "sbjID" "ide"],"After","acc");
a.Properties.RowNames = {};


%% Make stats template
r = table;
r.t = unique(a.t,"stable");
r.acc(:) = s0; % Cross-validation (CV) mean accuracy
r.acc_p(:) = s0; % p-value above chance
r.acc_q(:) = s0; % FDR-corrected sig
r.accBal(:) = s0; % Balanced accuracy (handles class imbalance)
r.auc(:,1:nCond) = s0; % CV ROC AUC per cond
r.auc1(:) = s0; % AUC mean
r.auc1_CI(:,1:2) = s0; % AUC confidence interval
r.pp(:,1:nCond) = s0; % mean posterior probability (PP)
r.pp1(:) = s0; % PP difference
r.pp1_SD(:) = s0; % PP diff std dev
r.pp1_p(:) = s0; % PP not equal p-value
r.pp1_q(:) = s0; % FDR-corrected sig
if any(nCondx)
    % Cross-classification (CC) stats
    r.ppx(:,1:nCondx) = s0; % CC PP
    r.ppx1(:) = s0; % CC PP diff
    r.ppx1_SD(:) = s0; % CC PP diff SD
    r.ppx1_p(:) = s0;
    r.ppx1_q(:) = s0;
end
r.n(:,1:nCond) = double(nan); % samples per training cond
r.wt(:,1:nCond) = s0; % class weight
if isany(nCondx)
    r.nx(:,1:nCondx) = uint32(0); end % samples per cross-classification cond
r.cost = cell(height(r),1);
r.loss(:) = s0; % average loss per fold CV
r.sbjCh(:) = "";
r.sbjID(:) = n.sbjID;
r.ch(:) = u0;
r = movevars(r,"sbjCh",Before=1);


%% Deal with unbalanced classes

% Find sample counts per training & CC cond
for t = 1:height(r)
    for c = 1:nCond
        r.n(t,c) = nnz(a.t==r.t(t) & a.cnd==o.cond(c)); end
    if any(nCondx)
        for c = 1:nCondx
            r.nx(t,c) = nnz(a.t==r.t(t) & a.cnd==o.condx(c)); end
    end
end

% Cost matrix weights: minority class gets higher weight
r.wt = max(r.n,[],2) ./ r.n;  % inverse frequency weighting: max_count / class_count
r.wt = cast(r.wt,o.typeProc);
r.n = uint32(r.n);

% Create cost matrix for unbalanced classes
for t = 1:height(r)
    costMat = zeros(nCond,nCond);
    for i = 1:nCond
        for j = 1:nCond
            if i ~= j
                costMat(i,j) = r.wt(t,j);  % Penalty for predicting i when true is j
            end
        end
    end
    r.cost{t} = costMat;
end

%a = arrayfun(@(b) a(a.t==b,:), r.t, UniformOutput=false);
disp("[ec_classifyChSpec] Made classifier templates: "+o.dirs.sbj+" | toc="+toc(tt));






%%%%%%%%%%%%%%%%%%%%%%%%%% Classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% Initialize classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [stats,obs] = classify_lfn(x,a,r,n,o,tt)
chNfo = n.chNfo(:,["ch" "sbjCh"]);
chsN = height(chNfo);

% Get classifier function handle
if o.fun=="fitcsvm"
    classif = @fitcsvm;
elseif o.fun=="fitclinear"
    classif = @fitclinear;
elseif o.fun=="fitcdiscr"
    classif = @fitcdiscr;
elseif o.fun=="fitcknn"
    classif = @fitcknn;
else
    error("Unknown classifier function: "+o.fun);
end

% Preallocate
stats = cell(chsN,1);
obs = stats;


%% Compute across timebins
if o.gpu
    for c = 1:chsN
        [obs{c},stats{c}] = classifyCh_lfn(x(:,c,:),a,r,o,classif,chNfo(c,:),tt);
    end
else
    parfor c = 1:chsN
        [obs{c},stats{c}] = classifyCh_lfn(x(:,c,:),a,r,o,classif,chNfo(c,:),tt);
    end
end


%% Concactenate channel results
obs = sortrows(vertcat(obs{:}),["ch" "tr" "t"],"ascend");
stats = sortrows(vertcat(stats{:}),["ch" "t"],"ascend");


%% FDR
stats.acc_q = ec_fdr(stats.acc_p,o.alpha,o.fdrDep);
stats.pp1_q = ec_fdr(stats.pp1_p,o.alpha,o.fdrDep);
stats.ppx1_q = ec_fdr(stats.ppx1_p,o.alpha,o.fdrDep);


%% Finalize
% TO DO: convert float vars to output type
% Remove vars
stats.cost = [];
% Rename vars
obs = renamevars(obs,["t" "cnd"],[o.timeVar o.condVar]);
stats = renamevars(stats,"t",o.timeVar);






% Compute within channel/IC/source %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ac,rc] = classifyCh_lfn(xc,ac,rc,o,classif,cNfo,tt)
% c=92; xc=x(:,c,:); ac=a; rc=r; cNfo=chNfo(c,:);
xc = squeeze(xc); % xc = xc(:,5:6);
ac.ch(:)=cNfo.ch; rc.ch(:)=cNfo.ch;
ac.sbjCh(:)=cNfo.sbjCh; rc.sbjCh(:)=cNfo.sbjCh;

% Move to gpu
if o.gpu
    xc = gpuArray(xc); end

%% Loop across channels/ICs
for t = 1:height(rc)
    % Indices for timepoint
    id = ac.t==rc.t(t);

    % Compute within timepoint
    [ac(id,:),rc(t,:)] = classifyTime_lfn(xc(id,:),ac(id,:),rc(t,:),classif,o);
end

%% Finalize
if o.gpu
    rc = convertvars(rc,@isgpuarray,@gather);
    ac = convertvars(ac,@isgpuarray,@gather);
end
disp("[ec_classifyChSpec] Finished "+o.fun+": "+cNfo.sbjCh+" toc="+toc(tt));






% Compute within channel/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [act,rct] = classifyTime_lfn(xct,act,rct,classif,o)
% t=35; id=ac.t==rc.t(t); xct=xc(id,:); act=ac(id,:); rct=rc(t,:);

% Outlier detection (all data)
if o.olThrAll
    xct = filloutliers(xct,o.olFill,o.ol,1,ThresholdFactor=o.olThrAll);
end

% Outlier detection (within-condition)
for c = unique(act.cnd)'
    id = act.cnd==c;
    xct(id,:) = filloutliers(xct(id,:),o.olFill,o.ol,1,ThresholdFactor=o.olThrCond);
    %disp("Outliers "+string(c)+": "+nnz(TF)/numel(TF));
end

% PCA
if o.pca
    [~,xct] = pca(xct,NumComponents=o.pca,Economy=false); end


%% Run classifier algorithm
[act,rct] = runClassifier_lfn(xct,act,rct,classif,o);






% Run classifier (unified) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [act,rct] = runClassifier_lfn(xct,act,rct,classif,o)
% Get training indices
idt = ismember(act.cnd,o.cond);
idx = ismember(act.cnd,o.condx);

% Main cross-validation (stratified for balanced folds)
oo = namedargs2cell(o.crossval);
cv = cvpartition(act.y(idt),oo{:},Stratify=true); % GroupingVariable=at.tr(idt)

% Hyperparameter tuning CV
oho = o.HyperparameterOptimizationOptions; % extract options
oho.CVPartition = cvpartition(act.y(idt),KFold=o.hyperOptKFold,Stratify=true);


%% Train & optimize
oo = namedargs2cell(o.hyper);
mdl = classif(xct(idt,:),act.y(idt),oo{:},'Cost',rct.cost{1},...
    'OptimizeHyperparameters',o.OptimizeHyperparameters,...
    'HyperparameterOptimizationOptions',oho);


%% Cross-classify 
if any(idx)
    [act.pred(idx),act.pp(idx,:)] = mdl.predict(xct(idx,:));
end


%% Cross-validate (stratified CV to handle unbalanced classes)
if o.fun=="fitclinear"
    % fitclinear must be run again for CV 
    oo = extractHyperparams_lfn(mdl,o); % extract optimized hyperparameters from main model
    oo = namedargs2cell(oo);
    % Run fitclinear with CV
    mdlCV = classif(xct(idt,:),act.y(idt),oo{:},'Cost',rct.cost{1},'CVPartition',cv);
else
    mdlCV = mdl.crossval(CVPartition=cv);
end

% Predict CV data
[act.pred(idt),act.pp(idt,:)] = mdlCV.kfoldPredict;

% Get CV performance
[rct.auc,aucL,aucU] = auc(rocmetrics(mdlCV,alpha=o.alpha));
rct.loss = mdlCV.kfoldLoss; % (Mode="individual")'


%% Calculate classifier metrics
act.acc = act.pred==act.y;
act.pp1 = diff(act.pp,1,2);

% CV accuracy
rct.acc = mean(act.acc(idt),1,"omitmissing");
rct.acc_p = 1 - binocdf(nnz(act.acc(idt))-1, nnz(idt), 0.5);

% CV balanced accuracy (ROC AUC)
rct.auc1 = mean(rct.auc,"omitmissing");
rct.auc1_CI = [mean(aucL,"omitmissing") mean(aucU,"omitmissing")];
% figure out AUC p-value???
% **OR** USE f1-score & its p-value?? (fit to binomial dist?)

% CV posterior probability
rct.pp = mean(act.pp(idt,:),1,"omitmissing");
rct.pp1 = mean(act.pp1(idt),1,"omitmissing");
rct.pp1_SD = std(act.pp1(idt),1,1,"omitmissing");
[~,rct.pp1_p] = ttest(act.pp1(idt));

% CC posterior probability
if any(idx)
    rct.ppx = mean(act.pp(idx,:),1,"omitmissing");
    rct.ppx1 = mean(act.pp1(idx),1,"omitmissing");
    rct.ppx1_SD = std(act.pp1(idx),1,1,"omitmissing");
    [~,rct.ppx1_p] = ttest(act.pp1(idx));
end






% Extract optimized hyperparameters from model %%%%%%%%%%%%%%%%%%%%%%%%%%%%
function oh = extractHyperparams_lfn(mdl,o)
oh = o.hyper;

% Loop across hyperparameters
for p = 1:numel(o.OptimizeHyperparameters)
    param = o.OptimizeHyperparameters(p); % parameter name
    oh.(param) = mdl.(param); % extract parameter   
    if param=="Regularization" % handle special case for Regularization
        oh.(param) = extractBefore(oh.(param)," "); end
end
