function sc = ec_contrast_perm(x,ob,n,o,c,tt)
% Run permutation contrast - called by high-level electroCUDA permutation
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
        [t,p,se,mu,df] = ec_ttest(cast(x(id1,:,:,:),o.floatAnal),0,...
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
        [t,p,se,mu,df] = ec_ttest2(cast(x(id1,:,:,:),o.floatAnal),...
            cast(x(id0,:,:,:),o.floatAnal),dim=1,alpha=o.alpha,tail=o.tail,...
            vartype=o.varType);
    end
end
disp("[ec_contrast_perm] Finished contrast: "+con+" | toc="+toc(tt));

%% Stats results table
sc = table;
sc.contrast(1:n.nTimes) = con;
if isany(o.cond0)
    sc.cond0 = repmat(o.cond0(c,:),n.nTimes,1);
end
sc.cond1 = repmat(o.cond1(c,:),n.nTimes,1);
sc.time = n.times;
sc.t = squeeze(cast(t,o.floatOut));
sc.p = squeeze(p);
sc.q = nan(size(sc.p),o.floatOut);
sc.qa = nan(size(sc.p),o.floatOut);
sc.mu = squeeze(cast(mu,o.floatOut));
if o.nPerm
    sc.ciL = squeeze(cast(ci(1,:,:,:),o.floatOut));
    sc.ciH = squeeze(cast(ci(2,:,:,:),o.floatOut));
else
    sc.se = squeeze(cast(se,o.floatOut));
end

% Save degrees of freedom
if ~isfield(o,"saveDF") || o.saveDF
    if ~isequal(size(df),size(p))
        sc.df = nan(size(sc.p),o.floatOut);
        sc.df(size(sc.p)) = squeeze(cast(df,o.floatOut));
    else
        sc.df = squeeze(cast(df,o.floatOut));
    end
end


%% FDR (across timepoints & sites, within-ch/IC/ROI per contrast)

% Indices within FDR time range
if numel(o.fdrTimeRng)==2
    id = sc.time>=o.fdrTimeRng(1) & sc.time<=o.fdrTimeRng(2);
else
    id = true(height(sc),1);
end

% Run FDR
sc.q(id,:,:,:) = ec_fdr(sc.p(id,:,:,:),o.alpha,o.fdrDep);
disp("[ec_contrast_perm] Ran FDR: "+con+" | toc="+toc(tt));