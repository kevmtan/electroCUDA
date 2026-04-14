function st = mmr_cSpecPost(o)
% Further analysis on results from classifyChSpec
arguments
    o struct
end

%% Initialize
tic;
s0 = cast(nan,o.typeProc);

% Load
fnSt = o.dirOut+"s"+o.n.sbjID+"_st.mat";
load(fnSt,"st");
fnOb = o.dirOut+"s"+o.n.sbjID+"_ob.mat";
load(fnOb,"ob");

% Rename table vars to standard names
st = renamevars(st,o.timeVar,"t");
ob = renamevars(ob,[o.timeVar o.condVar],["t" "cnd"]);
svars = string(st.Properties.VariableNames);


%% Preallocate additional stats vars

% Posterior probability (PP) per cond
if ~ismember("ppc",svars)
    st.ppc(:,1:numel(o.cond)) = s0;
    st.ppc_SE = st.ppc;
    st.ppc_p = st.ppc;
    st.ppc_q = st.ppc;
end

% PP per cross-classification (CC) cond
if isany(o.condx) && ~ismember("ppcx",svars)
    st.ppcx(:,1:numel(o.condx)) = s0;
    st.ppcx_SE = st.ppcx;
    st.ppcx_p = st.ppcx;
    st.ppcx_q = st.ppcx;
end

% Regression on CC PP
if isany(o.condx) && ~ismember("ppr_cx",svars)
    % Difference between conds/classes
    st.ppr_cx(:,1:numel(o.condx)-1) = s0;
    st.ppr_cx_SE(:) = st.ppr_cx;
    st.ppr_cx_p(:) = st.ppr_cx;
    st.ppr_cx_q(:) = st.ppr_cx;
    % Behav response time
    st.ppr_RT(:) = s0;
    st.ppr_RT_SE(:) = s0;
    st.ppr_RT_p(:) = s0;
    st.ppr_RT_q(:) = s0;
    % Affective valence
    st.ppr_val(:) = s0;
    st.ppr_val_SE(:) = s0;
    st.ppr_val_p(:) = s0;
    st.ppr_val_q(:) = s0;

    % Add CC cond var to obs
    ob.cx = categorical(string(ob.cnd),o.condx,Ordinal=true);
end

% Move added vars
stAddVars = setdiff(st.Properties.VariableNames,svars,"stable");
st = movevars(st,stAddVars,"Before","n");

% Split obs by chan & timept (output from unique models) for parfor
ob = splitapply(@(ct){ob(ct,:)},(1:height(ob))',findgroups(ob.ch,ob.t));
disp("[mmr_cChSpecPost] Finished prep: "+o.n.sbj+" toc="+toc);


%% Run analyses per model (parfor across chan & timept)
parfor s = 1:height(st)
    st(s,:) = furtherAnalysis_lfn(st(s,:),ob{s},o);
end
disp("[mmr_cChSpecPost] Finished analyses: "+o.n.sbj+" toc="+toc);


%% FDR
varsP = stAddVars(contains(stAddVars,"_p")); % new pval vars
varsQ = stAddVars(contains(stAddVars,"_q")); % new fdr vars
idFDR = st.t>=o.fdrTimeRng(1) & st.t<=o.fdrTimeRng(2);

% Loop across q vars
for v = 1:numel(varsQ)
    % Loop across var columns -- KEEP THIS??
    for w = 1:width(st.(varsQ(v)))
        % do FDR
        st.(varsQ(v))(idFDR,w) = ec_fdr(st.(varsP(v))(idFDR,w),...
            o.alpha,o.fdrDep);
    end
end


%% Finalize & Save
st = renamevars(st,"t",o.timeVar); % rename to original names
save(fnSt,"st");
disp("[mmr_cChSpecPost] Saved (toc="+toc+"): "+fnSt);





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





