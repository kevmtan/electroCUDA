function [st,ob,o] = ec_classifyPrep(n,ep,tt,o)
% Prep for electroCUDA classification routines: templates, options, etc.

%% Prep
o.OptimizeHyperparameters = string(o.OptimizeHyperparameters);
o.doCC = isany(o.p.condx); % Check if cross-classification enabled

% Convert classification scores to posterior probability via Platt scaling
% if needed (e.g., fitclinear SVM)
o.doPlatt = isequal(o.fun,@fitclinear) && o.hyper.Learner=="svm";

% Check if hyperparameter tuning enabled
o.doTuning = isany(o.OptimizeHyperparameters) && ~any(o.OptimizeHyperparameters=="none");

% Do nested CV only if hyperparameter tuning enabled
o.doNestedCV = o.doNestedCV && o.doTuning;

% Do CV if doing nested CV
if o.doNestedCV; o.doCV = true; end

% Vars from 'ep' to include in analysis template (to save for further analysis)
psyVars = ismember(ep.Properties.VariableNames,...
    ["run" "tr" "cnd" "t" "sbjID" o.psyVars]);

% Convenient variables
nCond = numel(o.p.cond); % number of train/test classes 
nCondx = numel(o.p.condx); % number of cross-classification classes
nPpc1 = max(nCond-1,1);
nPpxc1 = max(nCondx-1,1);
f0 = cast(nan,o.floatAnal); % float precision
u0 = uint16(0); % unsigned integer
s0 = string(missing);
if isany(o.p.chConcat)
    c0 = s0; % missing string for ROI
else
    c0 = cast(0,like=n.chNfo.ch); % Chan/IC integer type
end


%% Make analysis observations template
ob = ep(:,psyVars);
ob.y = categorical(ob.cnd,o.p.cond,Ordinal=true); % class (e.g. condition)
ob.pred(:) = categorical(s0,o.p.cond,Ordinal=true); % predicted class
ob.pp(:,1:numel(o.p.cond)) = f0; % posterior probability per class
ob.pp1(:) = f0; % posterior probability difference
ob.acc(:) = false; % accurate prediction?
ob.fold(:) = u0; % main CV test fold index (0 = not assigned)
ob.use(ismember(ob.cnd,o.p.cond)) = true; % use if one of the main conds (train/test)
if o.doCC
    ob.cc(ismember(ob.cnd,o.p.condx)) = true; % cross-classification conds
    ob.cx = categorical(string(ob.cnd),o.p.condx,Ordinal=true); % Add CC cond var to obs
end
% Channel/IC/ROI info
ob.ch(:) = c0;
ob.sbjCh(:) = s0;
ob.sbjID(:) = n.sbjID;
ob = movevars(ob,"sbjCh","Before",1);
ob = movevars(ob,"sbjID","After",width(ob));
ob.Properties.RowNames = {};


%% Make stats template
st = table;
st.t = unique(ob.t,"stable");
st.acc(:) = f0; % Cross-validation (CV) mean accuracy
st.acc_SE(:) = f0;
st.acc_p(:) = f0; % p-value above chance
st.acc_q(:) = f0; % FDR-corrected sig
st.auc(:,1:nCond) = f0; % CV precision-recall AUC per cond
st.auc1(:) = f0; % AUC mean
st.pp(:,1:nCond) = f0; % mean posterior probability (PP)
% PP difference
st.pp1(:) = f0;
st.pp1_SE(:) = f0; % PP diff st
st.pp1_p(:) = f0; % PP not equal p-value
st.pp1_q(:) = f0; % FDR-corrected sig
% PP per cond
st.ppc(:,1:nCond) = f0; 
st.ppc_SE(:,1:nCond) = f0; 
st.ppc_p(:,1:nCond) = f0;
st.ppc_q(:,1:nCond) = f0;
% PP cond diff (fitlm returns nCond-1 coefs relative to reference level)
st.ppc1(:,1:nPpc1) = f0;
st.ppc1_SE(:,1:nPpc1) = f0;
st.ppc1_p(:,1:nPpc1) = f0;
st.ppc1_q(:,1:nPpc1) = f0;
if o.doCC
    % Cross-classification (CC) stats
    st.ppx(:,1:nCondx) = f0; % CC PP
    st.ppx1(:) = f0; % CC PP diff
    st.ppx1_SE(:) = f0; % CC PP diff SE
    st.ppx1_p(:) = f0;
    st.ppx1_q(:) = f0;
    % PP per CC cond
    st.ppxc(:,1:nCondx) = f0;
    st.ppxc_SE(:,1:nCondx) = f0;
    st.ppxc_p(:,1:nCondx) = f0;
    st.ppxc_q(:,1:nCondx) = f0;
    % PP cond diff (fitlm returns nCondx-1 coefs relative to reference level)
    st.ppxc1(:,1:nPpxc1) = f0;
    st.ppxc1_SE(:,1:nPpxc1) = f0;
    st.ppxc1_p(:,1:nPpxc1) = f0;
    st.ppxc1_q(:,1:nPpxc1) = f0;
end
st.n0(:,1:nCond) = u0; % original obs per training cond
st.n(:,1:nCond) = f0; % obs per training cond (converted to uint later)
if o.doCC
    st.nx(:,1:nCondx) = u0; end % obs per cross-classification cond
st.wt(:,1:nCond) = f0; % class weight
st.cost = cell(height(st),1); % cost matrix
if o.doCV
    st.cv = st.cost; end % cross-validation object
if o.doTuning && (o.doCC || ~o.doCV || (o.doCV && ~o.doNestedCV))
    st.cvh = st.cost; end % cross-validation object for hyperparameter tuning
if o.doNestedCV
    st.cvhn = st.cost; end % cross-validation object for nested hyperparameter tuning
st.loss(:) = f0; % average loss per fold CV
% Feature info
if o.p.chConcat=="roi"
    st.width(:) = u0; end % ROI width (chans x freqs)
if o.s.rank||isany(o.s.pca)
    st.rank(:) = u0; end % Matrix rank
if isany(o.s.pca)
    st.features(:) = u0; end % Number of features
% Tuned hyperparameters
if o.doTuning && ~any(o.OptimizeHyperparameters=="auto") &&...
        (~o.doCV || (o.doCV && ~o.doNestedCV) || o.doCC)
    for p = 1:numel(o.OptimizeHyperparameters)
        param = o.OptimizeHyperparameters(p); % parameter name
        if ismember(param,["Regularization" "Learner"])
            st.(param)(:) = s0; % string param (FIGURE OUT STRING PARAMS)
        else
            st.(param)(:) = f0; % float param
        end
    end
end

% Channel/IC/ROI info
st.ch(:) = c0;
st.sbjCh(:) = s0;
st.sbjID(:) = uint16(n.sbjID);
st = movevars(st,"sbjCh","Before",1);
st = movevars(st,"sbjID","After",width(st));


%% Check for insufficient sample sizes & unbalanced classes per timepoint
for t = 1:height(st)
    % Indices of main conditions (classes to train/test) at this timepoint
    idt = ob.t==st.t(t) & ismember(ob.cnd,o.p.cond);
    ob.use(idt) = balanceClasses_lfn(ob(idt,:),nCond,o);
end


%% Find sample counts per training & CC cond (after balancing)
for t = 1:height(st)
    idt = find(ob.t==st.t(t));

    % Main conds
    for c = 1:nCond
        idc = ob.cnd(idt)==o.p.cond(c);
        st.n0(t,c) = nnz(idc);
        st.n(t,c) = nnz(ob.use(idt(idc)));
    end

    % Cross-classify conds
    if o.doCC
        for c = 1:nCondx
            st.nx(t,c) = nnz(ob.cnd(idt)==o.p.condx(c));
        end
    end
end


%% Cost matrix weights: minority class gets higher weight
st.wt = max(st.n,[],2) ./ st.n;  % inverse frequency weighting: max_count / class_count
st.n = cast(st.n,like=st.n0);

% Create cost matrix for unbalanced classes
for t = 1:height(st)
    costMat = zeros(nCond,nCond);
    for i = 1:nCond
        for j = 1:nCond
            if i ~= j
                costMat(i,j) = st.wt(t,j);  % Penalty for predicting i when true is j
            end
        end
    end
    st.cost{t} = costMat;
end


%% Make cross-validation objects per timepoint
for t = 1:height(st)
    % Get train/test indices per timepoint
    idt = ob.t==st.t(t) & ob.use;
    if ~any(idt); continue; end % skip
    obt = ob(idt,:);

    % Main CV partition
    if o.doCV
        st.cv{t} = cvPartition_lfn(obt,nCond,o.cv,o.cvMinTrialsPerFold);
        if isempty(st.cv{t})
            ob.use(idt) = false; % mark timepoint as unusable
            st.cv{t} = [];
            continue;
        end

        % Mark which test fold each observation belongs to (main CV)
        foldLocal = repmat(u0,height(obt),1);
        for k = 1:st.cv{t}.NumTestSets
            foldLocal(test(st.cv{t},k)) = cast(k,"like",u0);
        end
        ob.fold(idt) = foldLocal;
    end

    % Hyperparameter tuning CV partition (full training set)
    if o.doTuning && (o.doCC || ~o.doCV || (o.doCV && ~o.doNestedCV))
        st.cvh{t} = cvPartition_lfn(obt,nCond,o.cvh,o.cvMinTrialsPerFold);
        if isempty(st.cvh{t})
            ob.use(idt) = false;
            st.cvh{t} = [];
        end
    end

    % Nested hyperparameter tuning CV partition (inside main CV partitions)
    if o.doNestedCV
        % Requires outer CV partition to exist for this timepoint
        if ~o.doCV || isempty(st.cv{t})
            ob.use(idt) = false;
            st.cv{t} = [];
            st.cvhn{t} = [];
            continue;
        end

        % Build one inner CV partition per outer fold, each fit only on the
        % outer-train observations (true nested CV hierarchy).
        cvOuter = st.cv{t};
        cvInner = cell(cvOuter.NumTestSets,1);
        doSkip = false;
        for k = 1:cvOuter.NumTestSets
            idOuterTrain = training(cvOuter,k);
            obtOuterTrain = obt(idOuterTrain,:);

            cvInner{k} = cvPartition_lfn(obtOuterTrain,nCond,o.cvh,o.cvMinTrialsPerFold);
            if isempty(cvInner{k})
                doSkip = true;
                break;
            end
        end

        if doSkip
            ob.use(idt) = false;
            st.cv{t} = [];
            st.cvhn{t} = [];
            continue;
        end

        st.cvhn{t} = cvInner;
    end
end

%% Finalize

% Custom prep function
if ~isempty(o.prepFun)
    [st,ob] = o.prepFun(st,ob,o);
end
disp("[ec_classifyPrep] Made classifier templates: "+n.sbj+" | toc="+toc(tt));







function use = balanceClasses_lfn(obt,nCond,o)
%%% Balance classes within timepoint %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Checks sample sizes and balances classes for a single timepoint.
% Returns 'use' logical vector indicating which observations to use.
% Balances by selecting equal observations per class while maximizing trial diversity.

% Initialize use vector
use = obt.use;

% Find smallest observation count across classes
nPerClass = zeros(1,nCond);
for c = 1:nCond
    nPerClass(c) = nnz(obt.cnd==o.p.cond(c));
end
nMin = min(nPerClass); % smallest # obs

% Check if timepoint is good, needs balancing, or should be discarded
if nMin < o.nMin
    % Not enough obs per class, discard timepoint in analyses
    use(:) = false;
    return;
elseif all(nPerClass==nMin) || ~o.balanceConds
    % Timepoint already balanced or balancing disabled
    return; 
end

% Balance classes by maximizing number of unique trials in kept obs
for c = 1:nCond
    % Skip balancing if class already has smallest # obs
    if nPerClass(c)==nMin; continue; end 

    % Initialize
    idc = obt.cnd==o.p.cond(c); % class obs indices
    trs = unique(obt.tr(idc)); % get unique trials
    trOrder = randperm(numel(trs));
    trObsKept = cell(numel(trs),1); % kept obs per trial
    nKept = 0; % counter for kept obs

    % Mark all class obs as unused 
    use(idc) = false;

    % Select 1 observation per trial until 'nMin' are kept
    while nKept < nMin
        % Randomized loop across trials
        for trId = trOrder
            % Find unused observations
            trObs = find(idc & obt.tr==trs(trId)); % get trial obs
            obsUnused = setdiff(trObs,trObsKept{trId}); % obs not yet selected

            % Randomly select 1 unused obs from trial
            if nKept<nMin && ~isempty(obsUnused)
                obsAdd = obsUnused(randperm(numel(obsUnused),1)); % keep 1
                trObsKept{trId} = [trObsKept{trId}; obsAdd];
                nKept = nKept + 1;
            end
        end
    end

    % Mark selected observations to be used
    use(vertcat(trObsKept{:})) = true;
end






function cv = cvPartition_lfn(obt,nCond,cvArgs,minTrialsPerFold)
%%% Make CV partition %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creates a grouped CV partition where each fold has approximately equal
% class counts. Trials are grouped (all obs from a trial go to same fold),
% and trials are distributed to balance classes across folds.
% Reduces number of folds if necessary to ensure minTrialsPerFold per class per fold.
timepoint = obt.t(1);

% Parse cvArgs for KFold
if isfield(cvArgs,'KFold')
    nFolds = cvArgs.KFold;
elseif isfield(cvArgs,'Leaveout') && cvArgs.Leaveout
    nFolds = numel(unique(obt.tr));
else
    nFolds = 10; % default
end

% Get unique trials and their class labels
[trials,ia] = unique(obt.tr,'stable');
trialClass = obt.y(ia); % class label per trial
classes = categories(obt.y);

% Count trials per class
trialsPerClass = zeros(nCond,1);
for c = 1:nCond
    trialsPerClass(c) = nnz(trialClass == classes{c});
end

% Reduce folds to ensure >=minTrialsPerFold trials per class per fold
minClassTrials = min(trialsPerClass);
maxFolds = floor(minClassTrials / minTrialsPerFold);

% Check if minimum requirement can be met (need at least 2 folds)
if maxFolds < 2
    warning("[ec_classifyPrep] Not enough trials per class for CV: " + ...
        "min=%d, need %d for 2-fold CV. Skipping timepoint t=%g.", ...
        minClassTrials, minTrialsPerFold * 2, timepoint);
    cv = [];
    return;
end

if nFolds > maxFolds
    nFolds = maxFolds;
end

% Count observations per trial (for weighting)
nTrials = numel(trials);
trialCounts = zeros(nTrials,1);
for i = 1:nTrials
    trialCounts(i) = nnz(obt.tr == trials(i));
end

% Initialize fold assignments and class counts per fold
foldAssign = zeros(nTrials,1);
foldClassCounts = zeros(nFolds,nCond); % rows=folds, cols=classes

% Separate trials by class, then shuffle within each class
trialsByClass = cell(nCond,1);
for c = 1:nCond
    classTrialIdx = find(trialClass == classes{c});
    trialsByClass{c} = classTrialIdx(randperm(numel(classTrialIdx)));
end

% Distribute trials to folds in round-robin fashion per class
% This ensures each fold gets ~equal trials from each class
for c = 1:nCond
    classTrials = trialsByClass{c};
    nClassTrials = numel(classTrials);
    
    % Assign trials to folds, cycling through folds
    for i = 1:nClassTrials
        trialIdx = classTrials(i);

        % Find fold(s) with fewest observations of this class; break ties randomly
        minCount = min(foldClassCounts(:,c));
        tiedFolds = find(foldClassCounts(:,c) == minCount);
        if isscalar(tiedFolds)
            targetFold = tiedFolds;
        else
            targetFold = tiedFolds(randi(numel(tiedFolds)));
        end

        foldAssign(trialIdx) = targetFold;
        foldClassCounts(targetFold,c) = foldClassCounts(targetFold,c) + trialCounts(trialIdx);
    end
end

% Build test indices for each fold
nObs = height(obt);
testIdxCell = cell(nFolds,1);
for k = 1:nFolds
    foldTrials = trials(foldAssign == k);
    testIdxCell{k} = find(ismember(obt.tr, foldTrials));
end

% Create custom cvpartition using the 'CustomPartition' option
foldVector = zeros(nObs,1);
for k = 1:nFolds
    foldVector(testIdxCell{k}) = k;
end
cv = cvpartition('CustomPartition',foldVector);