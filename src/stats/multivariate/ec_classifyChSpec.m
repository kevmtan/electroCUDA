function [stats,obs] = ec_classifyChSpec(o)
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
[stats,obs] = classify_lfn(x,a,r,n,o,tt);
% stats = classification statistics per channel & timebin
% obs = classification of observations






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
r.cvLoss(:,1:o.crossval.KFold) = s0; % accuracy per fold
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

% Weights for unbalanced classes: minority class gets higher weight
r.wt = max(r.n,[],2) ./ r.n;  % Inverse frequency weighting: max_count / class_count
r.wt = cast(r.wt,o.typeProc);
r.n = uint32(r.n);

disp("[ec_classifyChSpec] Made classifier templates: "+o.dirs.sbj+" | toc="+toc(tt));






%%%%%%%%%%%%%%%%%%%%%%%%%% Classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% Initialize classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [stats,obs] = classify_lfn(x,a,r,n,o,tt)
chs = n.chNfo.ch;
sbjChs = n.chNfo.sbjCh;
chsN = numel(chs);
%a = arrayfun(@(b) a(a.t==b,:), r.t, UniformOutput=false);

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
        [stats{c},obs{c}] = classifyCh_lfn(x(:,c,:),a,r,o,classif,chs(c),sbjChs(c),tt);
    end
else
    parfor c = 1:chsN
        [stats{c},obs{c}] = classifyCh_lfn(x(:,c,:),a,r,o,classif,chs(c),sbjChs(c),tt);
    end
end


%% Finalize
stats = sortrows(vertcat(stats{:}),["ch" "t"],"ascend");
obs = sortrows(vertcat(obs{:}),["cnd" "ch" "t" "latency" "tr"],"ascend");

% Save
fn = o.dirOut+"s"+n.sbjID+"_classifySpec_"+o.name+".mat";
save(fn,"stats","obs","o","-v7");
disp("[ec_classifyChSpec] Saved classificiation results: "+fn+" toc="+toc(tt));






% Compute within channel/IC/source %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rc,ac] = classifyCh_lfn(xc,ac,rc,o,classif,ch,sbjCh,tt)
% c=92; xc=x(:,c,:); ac=a; rc=r; ch=chs(c); sbjCh=sbjChs(c);
xc = squeeze(xc);
ac.ch(:)=ch; rc.ch(:)=ch;
ac.sbjCh(:)=sbjCh; rc.sbjCh(:)=sbjCh;

% Move to gpu
if o.gpu
    xc = gpuArray(xc); end

%% Loop across channels/ICs
for t = 1:height(rc)
    % Indices for timepoint
    id = ac.t==rc.t(t);

    % Compute within timepoint
    [rc(t,:),ac(id,:)] = classifyTime_lfn(xc(id,:),ac(id,:),rc(t,:),classif,o);
end

%% Finalize
if o.gpu
    rc = convertvars(rc,@isgpuarray,@gather);
    ac = convertvars(ac,@isgpuarray,@gather);
end
disp("[ec_classifyChSpec] Finished "+o.fun+": "+sbjCh+" toc="+toc(tt));






% Compute within channel/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rct,act] = classifyTime_lfn(xct,act,rct,classif,o)
% t=29; id=ac.t==rc.t(t); xct=xc(id,:); act=ac(id,:); rct=rc(t,:);

% Outlier detection (all data)
if o.olThrAll
    xct = filloutliers(xct,o.olFill,o.ol,1,ThresholdFactor=o.olThrAll);
end

% Outlier detection (within-condition)
for c = unique(act.cnd)'
    id = act.cnd==c;
    xct(id,:) = filloutliers(xct(id,:),o.olFill,o.ol,1,ThresholdFactor=o.olThrCond);
end

% PCA
if o.pca
    [~,xct] = pca(xct,NumComponents=o.pca,Economy=false); end


%% Run classifier algorithm
[rct,act] = runClassifier_lfn(xct,act,rct,classif,o);






% Run classifier (unified) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rct,act] = runClassifier_lfn(xct,act,rct,classif,o)
% Get training indices
idt = ismember(act.cnd,o.cond);
idx = ismember(act.cnd,o.condx);
nCond = numel(o.cond);

% Create cost matrix for unbalanced classes
costMat = zeros(nCond,nCond);
for i = 1:nCond
    for j = 1:nCond
        if i ~= j
            costMat(i,j) = rct.wt(j);  % Penalty for predicting i when true is j
        end
    end
end

% Create stratified partition to ensure balanced folds
cvp = cvpartition(act.y(idt),KFold=o.crossval.KFold,Stratify=true); % GroupingVariable=at.tr(idt)
o.bayes.HyperparameterOptimizationOptions.CVPartition = cvp;


%% Train & optimize
oo = namedargs2cell(o.hyper);
mdl = classif(xct(idt,:),act.y(idt),oo{:},'Cost',costMat,...
    'OptimizeHyperparameters',o.bayes.OptimizeHyperparameters,...
    'HyperparameterOptimizationOptions',o.bayes.HyperparameterOptimizationOptions);


%% Cross-classify 
if any(idx)
    [act.pred(idx),act.pp(idx,:)] = mdl.predict(xct(idx,:));
end


%% Cross-validate (with stratified CV to handle unbalanced classes)
if o.fun=="fitclinear"
    % For fitclinear: extract optimized hyperparameters and use for CV
    o = extractHyperparams_lfn(mdl,o);
    oo = horzcat(namedargs2cell(o.hyper));
    % Add cost matrix if available
    if ~isempty(costMat)
        oo = [oo {'Cost', costMat}];
    end
    oo = [oo {'CVPartition', cvp}];
    mdlCV = classif(xct(idt,:),act.y(idt),oo{:});
else
    mdlCV = mdl.crossval(CVPartition=cvp);
end

% Predict CV data
[act.pred(idt),act.pp(idt,:)] = mdlCV.kfoldPredict;

% Get CV performance
[rct.auc,aucL,aucU] = auc(rocmetrics(mdlCV,alpha=o.alpha));


%% Calculate classifier metrics
act.acc = act.pred==act.y;
act.pp1 = diff(act.pp,1,2);

% CV accuracy
rct.acc = mean(act.acc(idt),1,"omitmissing");
rct.acc_p = 1 - binocdf(nnz(act.acc(idt))-1, nnz(idt), 0.5);

% CV balanced accuracy (ROC AUC)
rct.auc1 = mean(rct.auc,"omitmissing");
rct.auc1_ci = [mean(aucL,"omitmissing") mean(aucU,"omitmissing")];
% figure out AUC p-value???
% **OR** USE f1-score & its p-value?? (fit to binomial dist?)

% CV posterior probability
rct.pp = mean(act.pp(idt),1,"omitmissing");
rct.pp1 = mean(act.pp1(idt),1,"omitmissing");
rct.pp1_SD = std(act.pp1(idt),1,1,"omitmissing");
[~,rct.pp1_p] = ttest(act.pp1(idt));

% CC posterior probability
if any(idx)
    rct.ppx = mean(act.pp(idx),1,"omitmissing");
    rct.ppx1 = mean(act.pp1(idx),1,"omitmissing");
    rct.ppx1_SD = std(act.ppa(idx),1,1,"omitmissing");
    [~,rct.ppx1_p] = ttest(act.pp1(idx));
end






% Extract optimized hyperparameters from model %%%%%%%%%%%%%%%%%%%%%%%%%%%%
function o = extractHyperparams_lfn(mdl,o)
% Loop across hyperparameters
for p = 1:numel(o.bayes.OptimizeHyperparameters)
    paramName = o.bayes.OptimizeHyperparameters(p);
    % Handle special case for Regularization in fitclinear
    if paramName == "Regularization" && o.fun == "fitclinear"
        o.hyper.Regularization = extractBefore(mdl.(paramName)," ");
    else
        o.hyper.(paramName) = mdl.(paramName);
    end
end
