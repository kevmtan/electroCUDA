function [sc,t,p,mu,ci,q,df] = ec_contrast_perm(x,ob,n,o,c,tt)
% ec_contarast_perm - dispatcher for running permutation contrasts
% This function is called by high-level electroCUDA permutation
% functions. Not intended to be called independently.

%% Input validation
arguments
    x {mustBeFloat}
    ob table
    n struct
    o struct
    c (1,1) double = 1
    tt (1,1) uint64 = tic
end

con = o.contrasts(c); % contrast name 

% Comparison condition index
id1 = ismember(ob.cnd,o.cond1(c,~ismissing(o.cond1(c,:))));
if ~nnz(id1); error("No observations match comparison condition(s): "+o.cond1(c,:)); end
% Reference condition(s) index
if ~isempty(o.cond0) && isany(o.cond0(c,:))
    id0 = ismember(ob.cnd,o.cond0(c,~ismissing(o.cond0(c,:))));
    if ~nnz(id0); error("No observations match reference condition(s): "+o.cond0(c,:)); end
else
    id0 = false;
end


%% Contrast
if ~any(id0,"all")
    if o.nPerm
        % 1-sample permutation test of comparison condition(s)
        [t,p,ci,mu,df] = ec_permuttest(x(id1,:,:,:),0,ob(id1,o.grpVars),alpha=o.alpha,...
            tail=o.tail,nPerm=o.nPerm,blockElMax=o.blockElMax,blockMemFrac=o.blockMemFrac,...
            nBlocks=o.nBlocks,correct=o.maxCorrect,parallel=o.parallel,ramAvail=o.ramAvail,...
            gather=o.gather,stream=o.stream,ciMode=o.ciMode,floatType=o.floatAnal,...
            idxType=o.idxType,verbose=o.verbose);
    else
        % 1-sample parametric test
        [t,p,ci,mu,df] = ec_ttest(cast(x(id1,:,:,:),o.floatAnal),0,...
            dim=1,alpha=o.alpha,tail=o.tail);
    end
else
    if o.nPerm
        % 2-sample permutation test of comparison & reference conditions
        [t,p,ci,mu,df] = ec_permuttest2(x(id1,:,:,:),x(id0,:,:,:),...
            ob(id1,o.grpVars2),ob(id0,o.grpVars2),alpha=o.alpha,tail=o.tail,...
            varType=o.varType,stableVar=o.stableVar,correct=o.maxCorrect,...
            nPerm=o.nPerm,blockElMax=o.blockElMax2,blockMemFrac=o.blockMemFrac2,...
            nBlocks=o.nBlocks2,parallel=o.parallel2,ramAvail=o.ramAvail2,gather=o.gather,...
            stream=o.stream,ciMode=o.ciMode,floatType=o.floatAnal,idxType=o.idxType2,verbose=o.verbose);
    else
        % 2-sample parametric test 
        [t,p,ci,mu,df] = ec_ttest2(cast(x(id1,:,:,:),o.floatAnal),...
            cast(x(id0,:,:,:),o.floatAnal),dim=1,alpha=o.alpha,tail=o.tail,...
            vartype=o.varType);
    end
end

% Organize results
t = squeeze(cast(t,o.floatOut));
p = squeeze(p);
mu = squeeze(cast(mu,o.floatOut));
ci = squeeze(cast(ci,o.floatOut));
% Degrees of freedom: honor o.saveDF for all nargout (multi-output callers
% e.g. ec_condConChs_perm attach df to sc themselves).
if isfield(o,"saveDF") && ~o.saveDF
    df = [];
else
    df = squeeze(cast(df,o.floatOut));
end
disp("[ec_contrast_perm] Finished contrast: "+con+" | toc="+toc(tt));


%% FDR if no max correction
if ~o.maxCorrect
    % Preallocate FDR-adjusted p-values
    q = nan(size(p));

    % Indices within FDR time range
    if numel(o.fdrTimeRng)==2
        id = n.times>=o.fdrTimeRng(1) & n.times<=o.fdrTimeRng(2);
    else
        id = true(height(n.times),1);
    end

    % Run FDR
    q(id,:,:) = ec_fdr(p(id,:,:),o.alpha,o.fdrDep);
    q = cast(q,o.floatOut);
    disp("[ec_contrast_perm] Ran FDR: "+con+" | toc="+toc(tt));
else
    q = [];
end


%% Stats results table
sc = table;
sc.time = n.times;
sc.contrast(1:n.nTimes) = con;
if isany(o.cond0)
    sc.cond0 = repmat(o.cond0(c,:),n.nTimes,1);
end
sc.cond1 = repmat(o.cond1(c,:),n.nTimes,1);

% Save stats to results table (if stats table is the only output)
if nargout == 1
    sc.t = t;
    sc.p = p;
    sc.mu = mu;

    % Confidence intervals / standard errors
    if o.nPerm
        % Permutation CIs
        sc.ciL = ci(1,:,:);
        sc.ciH = ci(2,:,:);
    else
        % Parametric SEs
        sc.se = ci;
    end

    % Save degrees of freedom (df already [] when ~o.saveDF)
    if ~isempty(df)
        if isscalar(df)
            sc.df(size(p)) = df; % scalar DF, expand to number of tests
        elseif isequal(size(df),size(p))
            sc.df = df;
        else
            warning("[ec_contrast_perm] degrees-of-freedom size incompatibility, not saving,,,")
        end
    end

    % Copy FDR p-values
    if ~o.maxCorrect
        sc.q = q;
        sc = movevars(sc,"q",After="p");
    end
end