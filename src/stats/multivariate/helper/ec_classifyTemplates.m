function [a,r] = ec_classifyTemplates(n,ep,o,tt)
% Prep
u0 = cast(0,like=n.chNfo.ch); % integer type
f0 = cast(nan,o.typeProc); % float type
s0 = string(missing);
nCond = numel(o.cond);
nCondx = numel(o.condx);

% Get vars from 'ep' to include in analysis template (to save for further analysis)
psyVars = ismember(ep.Properties.VariableNames,...
    ["run" "tr" "cnd" "t" "sbjID" o.psyVars]);


%% Make analysis template
a = ep(:,psyVars);
a.y = categorical(a.cnd,o.cond,Ordinal=true); % class (e.g. condition)
a.pred(:) = categorical("",o.cond,Ordinal=true); % predicted class
a.pp(:,1:numel(o.cond)) = f0; % posterior probability per class
a.pp1(:) = f0; % posterior probability difference
a.acc(:) = false; % accurate prediction?
a.use(ismember(a.cnd,o.cond)) = true; % use if one of the main conds (train/test)
if isany(o.concatChs)
    % ROI info
    a.roi(:) = s0;
    a.sbjROI(:) = s0;
    a = movevars(a,"sbjROI","Before",1);
else
    % Channel/IC info
    a.ch(:) = u0;
    a.sbjCh(:) = s0;
    a = movevars(a,"sbjCh","Before",1);
end
a.sbjID(:) = n.sbjID;
a.Properties.RowNames = {};



%% Make stats template
r = table;
r.t = unique(a.t,"stable");
r.acc(:) = f0; % Cross-validation (CV) mean accuracy
r.acc_SE(:) = f0;
r.acc_p(:) = f0; % p-value above chance
r.acc_q(:) = f0; % FDR-corrected sig
r.auc(:,1:nCond) = f0; % CV ROC AUC per cond
r.auc1(:) = f0; % AUC mean
r.auc1_CI(:,1:2) = f0; % AUC confidence interval
r.pp(:,1:nCond) = f0; % mean posterior probability (PP)
r.pp1(:) = f0; % PP difference
r.pp1_SE(:) = f0; % PP diff std dev
r.pp1_p(:) = f0; % PP not equal p-value
r.pp1_q(:) = f0; % FDR-corrected sig
if any(nCondx)
    % Cross-classification (CC) stats
    r.ppx(:,1:nCondx) = f0; % CC PP
    r.ppx1(:) = f0; % CC PP diff
    r.ppx1_SE(:) = f0; % CC PP diff SD
    r.ppx1_p(:) = f0;
    r.ppx1_q(:) = f0;
end
r.n(:,1:nCond) = double(nan); % samples per training cond
r.wt(:,1:nCond) = f0; % class weight
if isany(nCondx)
    r.nx(:,1:nCondx) = uint32(0); end % samples per cross-classification cond
r.cost = cell(height(r),1);
r.cv = r.cost;
r.cvh = r.cost;
r.loss(:) = f0; % average loss per fold CV
if isany(o.concatChs)
    % ROI info
    r.roi(:) = s0;
    r.sbjROI(:) = s0;
    r = movevars(r,"sbjROI","Before",1);
else
    % Channel/IC info
    r.ch(:) = u0;
    r.sbjCh(:) = s0;
    r = movevars(r,"sbjCh","Before",1);
end
r.sbjID(:) = n.sbjID;


%% Check for insufficient sample sizes & unbalanced classes per timepoint
for t = 1:height(r)
    % Indices of main conditions (classes to train/test)
    idt = a.t==r.t(t) & ismember(a.cnd,o.cond);

    % Find smallest observation count across classes
    nPerClass = zeros(1,nCond);
    for c = 1:nCond
        nPerClass(c) = nnz(idt & a.cnd==o.cond(c));
    end
    nMin = min(nPerClass); % smallest # obs

    % Check if timepoint is good, needs balancing, or should be discarded
    if nMin < o.nMin
        % Not enough obs per class, discard timepoint in analyses
        a.use(idt) = false;
        continue;
    elseif all(nPerClass==nMin) || ~o.balanceConds
        % Timepoint already balanced or balancing disabled
        continue; 
    end

    %% Balance classes by maximizing number of unique trials in kept obs
    for c = 1:nCond
        % Skip balancing if class already has smallest # obs
        if nPerClass(c)==nMin; continue; end 

        % Initialize
        idtc = idt & a.cnd==o.cond(c); % class obs within timepoint
        trs = unique(a.tr(idtc)); % get unique trials
        trOrder = randperm(numel(trs));
        trObsKept = cell(numel(trs),1); % kept obs per trial
        nKept = 0; % counter for kept obs

        % Mark all class obs as unused 
        a.use(idtc) = false;

        % Select 1 observation per trial until 'nMin' are kept
        while nKept < nMin
            % Randomized loop across trials
            for trId = trOrder
                % Find unused observations
                trObs = find(idtc & a.tr==trs(trId)); % get trial obs
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
        a.use(vertcat(trObsKept{:})) = true;
    end
end


%% Find sample counts per training & CC cond (after balancing)
for t = 1:height(r)
    for c = 1:nCond
        r.n(t,c) = nnz(a.t==r.t(t) & a.cnd==o.cond(c) & a.use); end
    if any(nCondx)
        for c = 1:nCondx
            r.nx(t,c) = nnz(a.t==r.t(t) & a.cnd==o.condx(c)); end
    end
end


%% Cost matrix weights: minority class gets higher weight
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


%% Make cross-validation objects
oo = namedargs2cell(o.crossval);

% Loop across timepoint
for t = 1:height(r)
    idt = a.t==r.t(t) & a.use;
    % Ungrouped, stratified
    r.cv{t} = cvpartition(a.y(idt),oo{:});
    r.cvh{t} = cvpartition(a.y(idt),KFold=o.hyperKFold);
    % if o.balanceConds
    %     % Grouped by trial, unstratified
    %     r.cv{t} = cvpartition(a.y(idt),oo{:},GroupingVariable=a.tr(idt),Stratify=false);
    %     r.cvh{t} = cvpartition(a.y(idt),KFold=o.hyperOptKFold,Stratify=false,...
    %         GroupingVariable=a.tr(idt));
    % else
    %     % Ungrouped, stratified
    %     r.cv{t} = cvpartition(a.y(idt),oo{:});
    %     r.cvh{t} = cvpartition(a.y(idt),KFold=o.hyperOptKFold);
    % end
end

%a = arrayfun(@(b) a(a.t==b,:), r.t, UniformOutput=false);
disp("[ec_classifyChSpec] Made classifier templates: "+o.dirs.sbj+" | toc="+toc(tt));