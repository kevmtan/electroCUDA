function [o,stats,obs] = ec_classifyROIspec(o)
% Performs classification & cross-classification within ROIs across time
% using spectral activity concactenated across ROI channels as features.
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


%% Prepare subject data
tt = tic; % start timer
[x,ep,n,o] = ec_prepAnalysis(o,tt); % analysis-specific preprocessing


%% Make classifier templates
[a,r] = ec_classifyTemplates(n,ep,o,tt);
% a = analysis template
% r = results & statistics template


%% Split variables so splits directly go into ec_runClassifier
[x,a,r,n] = ec_splitClassifyData(x,a,r,n,o,tt);


%% Classification
[obs,stats] = classify_lfn(x,a,r,n,o,tt);
% obs = classification of observations
% stats = classification statistics per channel & timebin

%% Save
o.saved.stats = o.dirOut+"s"+n.sbjID+"_stats.mat";
save(o.saved.stats,"stats","-v7");
o.saved.obs = o.dirOut+"s"+n.sbjID+"_obs.mat";
save(o.saved.obs,"obs","-v7");
disp("[ec_classifyChSpec] Saved classificiation results: "+o.saved.stats+" toc="+toc(tt));






%%%%%%%%%%%%%%%%%%%%%%%%%% Classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% Initialize classification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [obs,stats] = classify_lfn(x,a,r,n,o,tt)
chNfo = n.chNfo(:,["ch" "sbjCh"]);
chsN = height(chNfo);

% Preallocate
obs = cell(chsN,1);
stats = cell(chsN,1);


%% Compute across channels/ICs
if o.gpu
    for c = 1:chsN
        [obs{c},stats{c}] = classifyCh_lfn(x(:,c,:),a,r,o,chNfo(c,:),tt);
    end
else
    parfor c = 1:chsN
        [obs{c},stats{c}] = classifyCh_lfn(x(:,c,:),a,r,o,chNfo(c,:),tt);
    end
end


%% Concactenate channel results
obs = sortrows(vertcat(obs{:}),["ch" "tr" "t"],"ascend");
stats = sortrows(vertcat(stats{:}),["ch" "t"],"ascend");


%% FDR
vs = string(stats.Properties.VariableNames);
vsP = vs(contains(vs,"_p")); % pval vars
vsQ = vs(contains(vs,"_q")); % fdr vars
id = stats.t>=o.fdrTimeRng(1) & stats.t<=o.fdrTimeRng(2); % fdr time range


% Loop across q vars
for v = 1:numel(vsQ)
    % Loop across var columns -- KEEP THIS??
    for w = 1:width(stats.(vsQ(v)))
        % do FDR
        stats.(vsQ(v))(id,w) = ec_fdr(stats.(vsP(v))(id,w),...
            o.alpha,o.fdrDep);
    end
end


%% Finalize
% TO DO: convert float vars to output type

% Remove vars
stats = removevars(stats,["cost" "cv" "cvh"]);

% Rename vars
obs = renamevars(obs,["t" "cnd"],[o.timeVar o.condVar]);
stats = renamevars(stats,"t",o.timeVar);






% Compute within channel/IC/source %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ac,rc] = classifyCh_lfn(xc,ac,rc,o,cNfo,tt)
% c=92; xc=x(:,c,:); ac=a; rc=r; cNfo=chNfo(c,:);
xc = squeeze(xc); % xc = xc(:,5:6);
ac.ch(:)=cNfo.ch; rc.ch(:)=cNfo.ch;
ac.sbjCh(:)=cNfo.sbjCh; rc.sbjCh(:)=cNfo.sbjCh;

% Move to gpu
if o.gpu
    xc = gpuArray(xc); end

%% Loop across time
for t = 1:height(rc)
    % Indices for timepoint
    id = ac.t==rc.t(t);
    if ~any(ac.use(id)); continue; end % skip if insufficient obs

    % Compute within timepoint
    [ac(id,:),rc(t,:)] = classifyTime_lfn(xc(id,:),ac(id,:),rc(t,:),o);
end

%% Finalize
if o.gpu
    ac = convertvars(ac,@isgpuarray,@gather);
    rc = convertvars(rc,@isgpuarray,@gather);
end
disp("[ec_classifyChSpec] Finished "+o.fun+": "+cNfo.sbjCh+" toc="+toc(tt));






% Compute within channel/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [act,rct] = classifyTime_lfn(xct,act,rct,o)
% t=43; id=ac.t==rc.t(t); xct=xc(id,:); act=ac(id,:); rct=rc(t,:);

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
[act,rct] = ec_runClassifier(xct,act,rct,o);