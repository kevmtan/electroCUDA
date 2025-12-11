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
[x,a,s,n,tt] = prep_lfn(o);
% x = EEG data
% a = analysis template
% r = results & statistics template
% n = subject info
% tt = timer


%% Classification
[stats,obs] = classify_lfn(x,a,s,n,o,tt);
% stats = classification statistics per channel & timebin
% obs = classification of observations






%%%%%%%%%%%%%%%%%%%%%%%%%% Preprocessing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,a,r,n,tt] = prep_lfn(o)
%% Initialize
tt = tic;
if o.test; disp("[ec_classifyChSpec] TESTING: "+o.dirs.sbj); end

% Load data 
[n,x,psy,trialNfo,chNfo] = ec_loadSbj(o.dirs,sfx=o.sfx,...
    vars=["n" "x" "psy" "trialNfo" "chNfo"],compact="n");
if o.test && numel(dbstack)<2; nOg=n; xOg=x; trialNfoOg=trialNfo; end %#ok<NASGU> % Copy origs for testing
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


%% Analysis template

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


%% Organize data for classifier
u0 = cast(0,like=n.chNfo.ch); % integer type
s0 = cast(nan,o.typeProc); % float type
nCond = numel(o.cond);

% Get vars from 'ep' to include in analysis template (to save for further analysis)
psyVars = ismember(ep.Properties.VariableNames,...
    ["run" "tr" "cnd" "t" "sbjID" "ide" o.psyVars]);

% Make analysis template
a = ep(:,psyVars);
a.y = categorical(a.cnd,o.cond,Ordinal=true); % class (e.g. condition)
a.pred(:) = categorical("",o.cond,Ordinal=true); % predicted class
a.pp(:,1:numel(o.cond)) = s0; % posterior probability per class
a.pp1(:) = s0; % posterior probability difference
a.acc(:) = false; % accurate prediction?
a.ch(:) = u0;
a.sbjCh(:) = "";

% Make stats template
r = groupcounts(a,"t");
r.t = unique(a.t);
r.acc(:) = s0; % Cross-validation (CV) mean accuracy
r.acc_p(:) = s0; % p-value above chance
r.acc_q(:) = s0; % FDR-corrected sig
r.auc(:,1:numel(o.cond)) = s0; % CV ROC AUC per cond
r.auc1(:) = s0; % AUC mean
r.auc1_CI(:,1:2) = s0; % AUC confidence interval
r.pp(:,1:numel(o.cond)) = s0; % mean posterior probability (PP)
r.pp1(:) = s0; % PP difference
r.pp1_SD(:) = s0; % PP diff std dev
r.pp1_p(:) = s0; % PP not equal p-value
r.pp1_q(:) = s0; % FDR-corrected sig
if isany(o.condx)
    % Cross-classification (CC) stats
    r.ppx(:,1:numel(o.cond)) = s0; % CC PP
    r.ppx1(:) = s0; % CC PP diff
    r.ppx1_SD(:) = s0; % CC PP diff SD
    r.ppx1_p(:) = s0;
    r.ppx1_q(:) = s0;
end
r.n(:,1:numel(o.cond)) = uint16(0); % samples per class
r.wt = r.n; % class weight
r.cvLoss(:,1:o.crossval.KFold) = s0; % accuracy per fold
r.sbjCh(:) = "";
r.sbjID(:) = n.sbjID;
r.ch(:) = u0;
r = movevars(r,"sbjCh",Before=1);
r = movevars(r,["GroupCount" "Percent"],Before="aucCV");

% Weights to deal with unbalanced classes
for t = 1:height(r)
    for c = 1:nCond
        r.n(t,c) = nnz(a.t==r.t(t) & a.cnd==o.cond(c));
    end
end
r.wt = cast(r.n,o.typeProc);
r.wt = r.wt ./ min(r.wt,[],2);

% Add weights to analysis template
for t = 1:height(r)
    for c = 1:nCond
        id = a.t==r.t(t) & a.cnd==o.cond(c);
        a.wt(id) = r.wt(t,c);
    end
end

% Finalize
a = movevars(a,"sbjCh","Before",1);
a = movevars(a,["ch" "sbjID" "ide"],"After","wt");
a.Properties.RowNames = {};






%%%%%%%%%%%%%%%%%%%%%%%%%% Classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% Call classification functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [stats,obs] = classify_lfn(x,a,r,n,o,tt)
chs = n.chNfo.ch;
sbjChs = n.chNfo.sbjCh;
if numel(dbstack)<2; x1=x; r1=r; end %#ok<NASGU> % Copy unshaped for testing

% Reshape data by timebins
x = arrayfun(@(b) x(a.t==b,:,:), r.t, UniformOutput=false);
a = arrayfun(@(b) a(a.t==b,:), r.t, UniformOutput=false);

% Preallocate
stats = cell(height(r),1);
obs = stats;

%% Compute across timebins
if o.gpu
    for t = 1:height(r)
        [stats{t},obs{t}] = classifyTime_lfn(x{t},a{t},r(t,:),chs,sbjChs,o,tt);
    end
else
    parfor t = 1:height(r)
        [stats{t},obs{t}] = classifyTime_lfn(x{t},a{t},r(t,:),chs,sbjChs,o,tt);
    end
end


%% Finalize
stats = sortrows(vertcat(stats{:}),["ch" "t"],"ascend");
obs = sortrows(vertcat(obs{:}),["cnd" "ch" "t" "latency" "tr"],"ascend");

% Save
fn = o.dirOut+"s"+n.sbjID+"_classifySpec_"+o.name+".mat";
save(fn,"stats","obs","o","-v7");
disp("[ec_classifyChSpec] Saved classificiation results: "+fn+" toc="+toc(tt));






% Compute within timebin %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rs,ra] = classifyTime_lfn(xt,at,rt,chs,sbjChs,o,tt)
% t=25; xt=x{t}; at=a{t}; rt=r(t,:);
nChs = numel(chs);
rs = cell(nChs,1); ra=rs; % Preallocate

% Move to gpu
if o.gpu
    xt = gpuArray(xt); end

%% Loop across channels/ICs
for ch = cast(1:nChs,like=xt)
    [rs{ch},ra{ch}] = preClassifier_lfn(xt(:,ch,:),at,rt,o,chs(ch),sbjChs(ch));
    if ~o.gpu && ~rem(ch,20)
       disp("[ec_classifyChSpec] Ran "+o.fun+" "+sbjChs(ch)+" "+o.timeVar+"="+rt.t+" toc="+toc(tt));
    end
end

%% Finalize
rs = vertcat(rs{:});
ra = vertcat(ra{:});
if o.gpu
    rs = convertvars(rs,@isgpuarray,@gather);
    ra = convertvars(ra,@isgpuarray,@gather);
end
disp("[ec_classifyChSpec] Finished "+o.fun+" classifier: s"+o.sbjID+" "+o.timeVar+"="+rt.t+" toc="+toc(tt));






% Compute within channel/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rc,ac] = preClassifier_lfn(xc,ac,rc,o,ch,sbjCh)
% c=92; xc=xt(:,c,:); ac=at; rc=rt; ch=chs(c); sbjCh=sbjChs(c);
xc = squeeze(xc);
rc.ch=ch; rc.sbjCh=sbjCh; ac.ch(:)=ch; ac.sbjCh(:)=sbjCh;

% Outlier detection (all data)
if o.olThrAll
    xc = filloutliers(xc,o.olFill,o.ol,1,ThresholdFactor=o.olThrAll);
end

% Outlier detection (within-condition)
for c = unique(ac.cnd)'
    id = ac.cnd==c;
    xc(id,:) = filloutliers(xc(id,:),o.olFill,o.ol,1,ThresholdFactor=o.olThrCond);
end

% PCA
if o.pca
    [~,xc] = pca(xc,NumComponents=o.pca,Economy=false); end

% Standardize data
if o.std
    xc = normalize(xc,1,"zscore"); end 

%% Run classifier algorithm
[rc,ac] = runClassifier_lfn(xc,ac,rc,o);






% Run classifier (unified) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rc,ac] = runClassifier_lfn(xc,ac,rc,o)
% Get training indices
idt = ismember(ac.cnd,o.cond);
idx = ismember(ac.cnd,o.condx);

% Get classifier function handle
if o.fun=="fitcsvm"
    classifier = @fitcsvm;
elseif o.fun=="fitclinear"
    classifier = @fitclinear;
elseif o.fun=="fitcknn"
    classifier = @fitcknn;
else
    error("Unknown classifier function: "+o.fun);
end


%% Train & optimize
oo = namedargs2cell(o.hyper);
mdl = classifier(xc(idt,:),ac.y(idt),oo{:},...
    'OptimizeHyperparameters',o.bayes.OptimizeHyperparameters,...
    'HyperparameterOptimizationOptions',o.bayes.HyperparameterOptimizationOptions);


%% Cross-classify 
if any(idx)
    [ac.pred(idx),ac.pp(idx,:)] = mdl.predict(xc(idx,:));
end


%% Cross-validate
if o.fun=="fitclinear"
    % For fitclinear: extract optimized hyperparameters and use for CV
    o = extractHyperparams_lfn(mdl,o);
    oo = horzcat(namedargs2cell(o.hyper),namedargs2cell(o.crossval));
    mdlCV = classifier(xc(idt,:),ac.y(idt),oo{:});
else
    oo = namedargs2cell(o.crossval);
    mdlCV = mdl.crossval(oo{:});
end

% Predict CV data
[ac.pred(idt),ac.pp(idt,:)] = mdlCV.kfoldPredict;

% Get CV performance
[rc.auc,aucL,aucU] = auc(rocmetrics(mdlCV,alpha=o.alpha));
rc.auc1 = mean(rc.auc,"omitmissing");
rc.auc1_ci = [mean(aucL,"omitmissing") mean(aucU,"omitmissing")];
% FIGURE OUT AUC p-value???
% OR USE f1-score & its p-value??

%% Calculate classifier metrics
ac.acc = ac.pred==ac.y;
ac.pp1 = diff(ac.pp,1,2);

% CV accuracy
rc.acc = mean(ac.acc(idt),1,"omitmissing");
rc.acc_p = 1 - binocdf(nnz(ac.acc(idt))-1, nnz(idt), 0.5);

% CV posterior probability
rc.pp = mean(ac.pp(idt),1,"omitmissing");
rc.pp1 = mean(ac.pp1(idt),1,"omitmissing");
rc.pp1_SD = std(ac.pp1(idt),1,1,"omitmissing");
[~,rc.pp1_p] = ttest(ac.pp1(idt));

% CC posterior probability
if any(idx)
    rc.ppx = mean(ac.pp(idx),1,"omitmissing");
    rc.ppx1 = mean(ac.pp1(idx),1,"omitmissing");
    rc.ppx1_SD = std(ac.ppa(idx),1,1,"omitmissing");
    [~,rc.ppx1_p] = ttest(ac.pp1(idx));
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
