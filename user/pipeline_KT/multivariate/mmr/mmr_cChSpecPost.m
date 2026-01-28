function stats = mmr_cChSpecPost(o)
% Further analysis on results from classifyChSpec
arguments
    o struct
end

%% Initialize
tic;
s0 = cast(nan,o.typeProc);

% Load
fnStats = o.dirOut+"s"+o.n.sbjID+"_stats.mat";
load(fnStats,"stats");
fnObs = o.dirOut+"s"+o.n.sbjID+"_obs.mat";
load(fnObs,"obs");

% Rename table vars to standard names
stats = renamevars(stats,o.timeVar,"t");
obs = renamevars(obs,[o.timeVar o.condVar],["t" "cnd"]);
svars = string(stats.Properties.VariableNames);


%% Preallocate additional stats vars

% Posterior probability (PP) per cond
if ~ismember("ppc",svars)
    stats.ppc(:,1:numel(o.cond)) = s0;
    stats.ppc_SE = stats.ppc;
    stats.ppc_p = stats.ppc;
    stats.ppc_q = stats.ppc;
end

% PP per cross-classification (CC) cond
if isany(o.condx) && ~ismember("ppcx",svars)
    stats.ppcx(:,1:numel(o.condx)) = s0;
    stats.ppcx_SE = stats.ppcx;
    stats.ppcx_p = stats.ppcx;
    stats.ppcx_q = stats.ppcx;
end

% Regression on CC PP
if isany(o.condx) && ~ismember("ppr_cx",svars)
    % Difference between conds/classes
    stats.ppr_cx(:,1:numel(o.condx)-1) = s0;
    stats.ppr_cx_SE(:) = stats.ppr_cx;
    stats.ppr_cx_p(:) = stats.ppr_cx;
    stats.ppr_cx_q(:) = stats.ppr_cx;
    % Behav response time
    stats.ppr_RT(:) = s0;
    stats.ppr_RT_SE(:) = s0;
    stats.ppr_RT_p(:) = s0;
    stats.ppr_RT_q(:) = s0;
    % Affective valence
    stats.ppr_val(:) = s0;
    stats.ppr_val_SE(:) = s0;
    stats.ppr_val_p(:) = s0;
    stats.ppr_val_q(:) = s0;

    % Add CC cond var to obs
    obs.cx = categorical(string(obs.cnd),o.condx,Ordinal=true);
end

% Move added vars
stAddVars = setdiff(stats.Properties.VariableNames,svars,"stable");
stats = movevars(stats,stAddVars,"Before","n");

% Split obs by chan & timept (output from unique models) for parfor
obs = splitapply(@(ct){obs(ct,:)},(1:height(obs))',findgroups(obs.ch,obs.t));
disp("[mmr_cChSpecPost] Finished prep: "+o.n.sbj+" toc="+toc);


%% Run analyses per model (parfor across chan & timept)
parfor ct = 1:height(stats)
    stats(ct,:) = furtherAnalysis_lfn(stats(ct,:),obs{ct},o);
end
disp("[mmr_cChSpecPost] Finished analyses: "+o.n.sbj+" toc="+toc);


%% FDR
varsP = stAddVars(contains(stAddVars,"_p")); % new pval vars
varsQ = stAddVars(contains(stAddVars,"_q")); % new fdr vars
idFDR = stats.t>=o.fdrTimeRng(1) & stats.t<=o.fdrTimeRng(2);

% Loop across q vars
for v = 1:numel(varsQ)
    % Loop across var columns -- KEEP THIS??
    for w = 1:width(stats.(varsQ(v)))
        % do FDR
        stats.(varsQ(v))(idFDR,w) = ec_fdr(stats.(varsP(v))(idFDR,w),...
            o.alpha,o.fdrDep);
    end
end


%% Finalize & Save
stats = renamevars(stats,"t",o.timeVar); % rename to original names
save(fnStats,"stats");
disp("[mmr_cChSpecPost] Saved (toc="+toc+"): "+fnStats);





function st = furtherAnalysis_lfn(st,ob,o)
%% Further analyses on single-model outputs (within-chan/timept) %%%%%%%%%%
% ct=4120; st=stats(ct,:); ob=obs{ct};


%% Mean posterior probability per cond

% Main conds
for c = 1:numel(o.cond)
    id = ob.cnd == o.cond(c);
    N = nnz(id);

    st.ppc(1,c) = mean(ob.pp1(id),"omitmissing");
    st.ppc_SE(1,c) = std(ob.pp1(id),"omitmissing") / sqrt(N);
    [~,st.ppc_p(1,c)] = ttest(ob.pp1(id));
end

% Cross-classification conds
for c = 1:numel(o.condx)
    id = ob.cnd == o.condx(c);
    N = nnz(id);

    st.ppcx(1,c) = mean(ob.pp1(id),"omitmissing");
    st.ppcx_SE(1,c) = std(ob.pp1(id),"omitmissing") / sqrt(N);
    [~,st.ppcx_p(1,c)] = ttest(ob.pp1(id));
end


%% Regression on cross-classification posterior probability
if isany(o.condx) && any(isnan(st.ppr_cx),"all")
    id = ismember(ob.cnd,o.condx);

    % Cond/class differences
    lm = fitlm(ob(id,:),"pp1 ~ cx");
    st.ppr_cx(1,:) = lm.Coefficients.Estimate(2:end)';
    st.ppr_cx_SE(1,:) = lm.Coefficients.SE(2:end)';
    st.ppr_cx_p(1,:) = lm.Coefficients.pValue(2:end)';

    % Behavioral response time
    lm = fitlm(ob(id,:),"pp1 ~ RT");
    st.ppr_RT = lm.Coefficients.Estimate(2);
    st.ppr_RT_SE = lm.Coefficients.SE(2);
    st.ppr_RT_p = lm.Coefficients.pValue(2);

    % Affective valence
    lm = fitlm(ob(id,:),"pp1 ~ valence");
    st.ppr_val = lm.Coefficients.Estimate(2);
    st.ppr_val_SE = lm.Coefficients.SE(2);
    st.ppr_val_p = lm.Coefficients.pValue(2);
end





