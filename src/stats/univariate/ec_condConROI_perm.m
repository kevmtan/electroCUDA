function st = ec_condConROI_perm(o)
%% Input validation
arguments
    o struct
end

% Errors
if isempty(o.cond1) || (isstring(o.cond1) && ~isany(o.cond1,"all")) ||...
     (iscell(o.cond1) && ~any(cellfun(@isany,o.cond1)))
    error("[ec_condConROI_perm] Must have at least one comparison condition");
end
if iscell(o.cond1) && numel(o.cond1)~=numel(o.contrasts)
    error("[ec_condConROI_perm] o.contrasts and o.cond1 must be same length");
end


%% Prep
tt = tic; % start timer
nROIs = numel(o.ROIs);
nCons = numel(o.contrasts);

% Get directories
dirs = ec_getDirs(o.proj,o.task);

% Load sbjROI
fn = dirs.anal+o.roiDir+filesep+o.roiName+filesep+"sbjROIs_"+o.roiName;
load(fn,"sbjROIs");
disp("[ec_condConROI_perm] Loaded: "+fn+" toc="+toc(tt));

% Load logs
fn = dirs.anal+o.roiDir+filesep+o.roiName+filesep+"logs_"+o.roiName;
load(fn,"logs");
disp("[ec_condConROI_perm] Loaded: "+fn+" toc="+toc(tt));

% Load 'n' of first subject to get times/other info
load(logs.n(1),"n");
disp("[ec_condConROI_perm] Loaded 'n' of 1st subject: "+logs.n(1)+" toc="+toc(tt));

% Make analysis output directory
outDir = dirs.anal+o.analDir+filesep+o.analName+filesep;
if ~isfolder(outDir); mkdir(outDir); end

% Save options
fn = outDir+"o.mat";
save(fn,"o","-v7");
disp("[ec_condConROI_perm] Saved: "+fn+" | toc="+toc(tt));


%%

% Convert o.condx cells to nContrasts-by-maxWidth string array (pad with missing)
if iscell(o.cond1)
    cond = repmat(string(missing),nCons,max(cellfun(@numel,o.cond1)));
    for c = 1:nCons
        cnd = string(o.cond1{c});
        cond(c,1:numel(cnd)) = cnd;
    end
    o.cond1 = cond;
end
if ~isempty(o.cond0) && iscell(o.cond0)
    cond = repmat(string(missing),nCons,max(cellfun(@numel,o.cond0)));
    for c = 1:nCons
        cnd = string(o.cond0{c});
        cond(c,1:numel(cnd)) = cnd;
    end
    o.cond0 = cond;
end

% Preallocate stats table
st = cell(nROIs,1);


%% Run ROIs
for r = 1:nROIs
    idr = sbjROIs.roi==o.ROIs(r);
    st{r} = runROI_lfn(sbjROIs(idr,:),n,o,tt);
end


%% FDR
st = vertcat(st{:}); % concatenate across ROIs

% Loop across contrasts
for c = 1:nCons
    % Indices for contrast
    id = st.contrast==o.contrasts(c);
    if numel(o.fdrTimeRng)==2
        % Indices within FDR time range
        id = id & st.time>=o.fdrTimeRng(1) & st.time<=o.fdrTimeRng(2);
    end

    % Run FDR for contrast across ROIs, timepoints & frequencies
    st.qa(id,:,:,:) = ec_fdr(st.p(id,:,:,:),o.alpha,o.fdrDep);
end


%% Save
fn = outDir+"st.mat";
save(fn,"st","-v7");
disp("[ec_condConROI_perm] Saved: "+fn+" | toc="+toc(tt));





function str = runROI_lfn(ROI,n,o,tt)
%%% Run stats for ROI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                       ROI=sbjROIs(idr,:);
roi = string(ROI.roi(1));
nSbjs = height(ROI);
nCons = numel(o.contrasts);

% Preallocate
x = cell(nSbjs,1); % ROI EEG data
ob = cell(nSbjs,1); % ROI observations
str = cell(nCons,1); % Statistical contrasts


%% Load subject data
for s = 1:nSbjs
    % Load EEG
    load(ROI.xr(s),"xr");
    x{s} = xr;

    % Load observations
    load(ROI.obr(s),"obr");
    ob{s} = obr;
end
disp("[ec_condConROI_perm] Loaded data for: "+roi+" | toc="+toc(tt));


%% Concatenate across subjects
x = vertcat(x{:});
ob = vertcat(ob{:});
if height(x)~=height(ob)
    error("[ec_condConROI_perm] Height of ROI EEG data & observations table don't match");
end

% Standardize condition variable name
ob.cnd = ob.(o.condVar);
disp("[ec_condConROI_perm] Concatenated subject data for: "+roi+" | toc="+toc(tt));


%% Run contrasts
for c = 1:nCons
    str{c} = ec_contrast_perm(x,ob,n,o,c,tt);
end


%% Finalize
str = vertcat(str{:}); % concatenate across contrasts
str.roi(:) = ROI.roi(1); % add ROI name
str = movevars(str,"roi",Before=1); % move to first column
disp("[ec_condConROI_perm] Finished contrasts for: "+roi+" | toc="+toc(tt));







% function sc = contrast_lfn(x,ob,n,o,c,tt)
% %%% Run contrast %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% con = o.contrasts(c); % contrast name 

% % Comparison condition index
% id1 = ismember(ob.cnd,o.cond1(c,~ismissing(o.cond1(c,:))));
% if ~nnz(id1); error("No observations match comparison condition(s): "+o.cond1(c,:)); end
% % Reference condition(s) index
% if ~isempty(o.cond0) && isany(o.cond0(c,:))
%     id0 = ismember(ob.cnd,o.cond0(c,~ismissing(o.cond0(c,:))));
%     if ~nnz(id0); error("No observations match reference condition(s): "+o.cond0(c,:)); end
% else
%     id0 = false;
% end


% %% Contrast
% if ~any(id0,"all")
%     if o.nPerm
%         % 1-sample permutation test of comparison condition(s)
%         [t,p,ci,mu,df] = ec_permuttest(x(id1,:,:,:),0,ob(id1,o.grpVars),alpha=o.alpha,...
%             tail=o.tail,nPerm=o.nPerm,blockElMax=o.blockElMax,blockMemFrac=o.blockMemFrac,...
%             nBlocks=o.nBlocks,correct=o.maxCorrect,parallel=o.parallel,ramAvail=o.ramAvail,...
%             gather=o.gather,floatType=o.floatAnal,idxType=o.idxType,verbose=o.verbose);
%     else
%         % 1-sample parametric test
%         [t,p,se,mu,df] = ec_ttest(cast(x(id1,:,:,:),o.floatAnal),0,...
%             dim=1,alpha=o.alpha,tail=o.tail);
%     end
% else
%     if o.nPerm
%         % 2-sample permutation test of comparison & reference conditions
%         [t,p,ci,mu,df] = ec_permuttest2(x(id1,:,:,:),x(id0,:,:,:),...
%             ob(id1,o.grpVars2),ob(id0,o.grpVars2),alpha=o.alpha,tail=o.tail,...
%             varType=o.varType,stableVar=o.stableVar,correct=o.maxCorrect,...
%             nPerm=o.nPerm,blockElMax=o.blockElMax2,blockMemFrac=o.blockMemFrac2,...
%             nBlocks=o.nBlocks2,parallel=o.parallel2,ramAvail=o.ramAvail2,gather=o.gather,...
%             stream=o.stream,ciMode=o.ciMode,floatType=o.floatAnal,idxType=o.idxType2,verbose=o.verbose);
%     else
%         % 2-sample parametric test 
%         [t,p,se,mu,df] = ec_ttest2(cast(x(id1,:,:,:),o.floatAnal),...
%             cast(x(id0,:,:,:),o.floatAnal),dim=1,alpha=o.alpha,tail=o.tail,...
%             vartype=o.varType);
%     end
% end
% disp("[ec_condConROI_perm] Finished contrast: "+con+" | toc="+toc(tt));

% %% Stats results table
% sc = table;
% sc.contrast(1:n.nTimes) = con;
% if isany(o.cond0)
%     sc.cond0 = repmat(o.cond0(c,:),n.nTimes,1);
% end
% sc.cond1 = repmat(o.cond1(c,:),n.nTimes,1);
% sc.time = n.times;
% sc.t = squeeze(cast(t,o.floatOut));
% sc.p = squeeze(p);
% sc.q = nan(size(sc.p),o.floatOut);
% sc.qa = nan(size(sc.p),o.floatOut);
% sc.mu = squeeze(cast(mu,o.floatOut));
% if o.nPerm
%     sc.ciL = squeeze(cast(ci(1,:,:,:),o.floatOut));
%     sc.ciH = squeeze(cast(ci(2,:,:,:),o.floatOut));
% else
%     sc.se = squeeze(cast(se,o.floatOut));
% end
% if ~isequal(size(df),size(p))
%     sc.df = nan(size(sc.p),o.floatOut);
%     sc.df(size(sc.p)) = squeeze(cast(df,o.floatOut));
% else
%     sc.df = squeeze(cast(df,o.floatOut));
% end


% %% FDR (across timepoints & sites, within-ch/IC/ROI per contrast)

% % Indices within FDR time range
% if numel(o.fdrTimeRng)==2
%     id = sc.time>=o.fdrTimeRng(1) & sc.time<=o.fdrTimeRng(2);
% else
%     id = true(height(sc),1);
% end

% % Run FDR
% sc.q(id,:,:,:) = ec_fdr(sc.p(id,:,:,:),o.alpha,o.fdrDep);
% disp("[ec_condConROI_perm] Ran FDR: "+con+" | toc="+toc(tt));