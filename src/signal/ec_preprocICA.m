function [errors,n,x] = ec_preprocICA(sbj,proj,task,o,n,x,arg)
%% electroCUDA - Independent Components Analysis (ICA)
% This function performs ICA on preprocesssed data from 'ec_preproc'
% Additional denoising, detrending & high-pass filtering (HPF) can be temporarily
% applied to improve ICA decomposition. Final output data forgo these additional
% steps to avoid artifacts from denoising & filtering.
%
% For example, aggressive HPF often improves ICA decomposition but produces
% problematic filtering artifacts. Thus, HPF can be applied to temporary dataset
% used for ICA. The resulting ICA weights can be applied to pre-HPF data
% (e.g. original input data) to reconstruct IC timecourses ('x' output var).
% This avoids HPF artifacts while retaining the benefits of HPF for ICA.
%
% SEE WIKI FOR MORE INFO: github.com/kevmtan/electroCUDA/wiki
%
% INPUTS:
%    sbj = subject name
%    task = task name
%    o = struct of options & parameters (TO DO: describe all options)
%    n = preloaded 'n' info output from ec_initialize or robustPreproc (OPTIONAL)
%    x = preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
%    arg = Name-Value Arguments (see "Input validation" below)
%
% OUTPUTS:
%   errors = cell array of any errors or warnings
%   n = Struct of preprocessing info & results
%   x = Preprocessed EEG data indexed as: x(timeframe,channel)
%      NOTE: 'n' and 'x' are saved to disk by default
%
% ACKNOWLEDGEMENTS:
%    * Stanford Parvizi Lab (Pedro Pinhiero-Chagas, Amy Daitch, Su Liu, et al.)
%    * Laboratoire des Systèmes Perceptifs (NoiseTools: Alain de Cheveigné, et al.)
%    * Full acknowledgements in Wiki (github.com/kevmtan/electroCUDA/wiki)
%
% LICENSE: General Public License (GNU GPLv3)
% DISCLAIMERS:
%    Use and distribution of this software must comply with GNU GPLv3.
%    This software may be subject to University of California intellectual
%    property rights.
%    Use this code at your own risk. Users assume full responsibility for
%    any eventualities related to the content herein.
%    This code is for research purposes only and NOT INTENDED FOR CLINICAL USE.
%
%
%                 Kevin Tan, 2022 (github.io/kevmtan)

%% Input validation
arguments
    sbj string
    proj string
    task string
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    n struct = [] % preloaded 'n' info output from ec_initialize or robustPreproc (OPTIONAL)
    x {mustBeFloat} = [] % preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
    arg.blocks {istext,isnumeric} = BlockBySubj(sbj,task) % Task blocks/runs to include
    arg.dirs struct = [] % Directory paths struct
    arg.save logical = false % Save outputs to disk
    arg.test logical = false
    arg.redoN logical = true
    arg.nIn {isstruct} = []
    arg.raw logical = false
end
% x=[]; n=[]; arg.raw=false; arg.nIn=[]; arg.save=0; arg.test=1;

%% Initialize & load data
reset(gpuDevice());
errors = {};
tt = tic;

% Load EEG data
if isempty(x)
    [n,x,chNfo,dirs] = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=o.sfx_src,...
        vars=["n" "x" "chNfo"]);
end
xOg = x;

% Suffixes
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
if o.suffix=="i"; sfx1=""; else; sfx1="_"+o.suffix; end
if ~isfield(o,'dirOut'); o.dirOut=dirs.procSbj; end % Output directory
if ~isfield(o,'fnStr');  o.fnStr="s"+dirs.sbjID+"_"+task; end % Filename ending string
if ~isfolder(o.dirOut); mkdir(o.dirOut); end
sfxB = "";

%% Classify bad chans & frames
if o.doBadCh
    [chClass,chNfo.dist] = ec_classifyBadChs(x,chNfo.pialRAS,chNfo.ch); % Bad chan classifier
    ch_bad.("ai"+sfx) = chClass.bad;
    ch_bad.("xcorr"+sfx) = isoutlier(chClass.xcorr);
    ch_bad.("dev"+sfx) = isoutlier(chClass.dev);
    ch_bad.("grad"+sfx) = isoutlier(chClass.grad);
    % Hurst exponent
    idx = ~(ch_bad.empty|ch_bad.nan|chClass.bad|ch_bad.("flat"+sfx)|ch_bad.("diff"+sfx)|...
        ch_bad.("cov"+sfx)|ch_bad.("dev"+sfx)|ch_bad.("grad"+sfx));
    chHrst = abs(chClass.hurs - 0.5);
    [~,chHrst_lo,chHrst_hi] = isoutlier(chHrst(idx),"median","ThresholdFactor",o.thrHurst);
    ch_bad.("hurstL"+sfx) = chHrst < chHrst_lo;
    ch_bad.("hurstH"+sfx) = chHrst > chHrst_hi;
    % Copy
    ch_bad.("bad"+sfx) = ch_bad.empty|ch_bad.nan|ch_bad.("ai"+sfx)|...
        sum([ch_bad.("mad"+sfx),ch_bad.("diff"+sfx),ch_bad.("flat"+sfx),ch_bad.("sns"+sfx)*2,...
        ch_bad.("cov"+sfx),ch_bad.("dev"+sfx),ch_bad.("grad"+sfx),...
        ch_bad.("hurstL"+sfx),ch_bad.("hurstH"+sfx)],2)>=3;
    ch_bad(:,string(chClass.Properties.VariableNames(3:end))+"P"+sfx) = chClass(:,3:end);
    chGood = ~ch_bad.("bad"+sfx);
    disp("Bad chans CLASSIFIER:"); disp(find(ch_bad.ai)');
    disp("Bad chans ALL:"); disp(find(ch_bad.bad)');
    sfxB = sfx;
end

%% Robust detrending (temporary, aggressive for better ICA decomposition)
if nnz(o.detrendOrder)
    [x,n] = ec_detrend(x,n,order=o.detrendOrder,thr=o.detrendThr,itr=o.detrendItr,...
        win=o.detrendWin,missing=o.missingInterp,gpu=o.detrendGPU,single=o.detrendSingle,tic=tt);
    if arg.test; x_detr=x; end %#ok<*NASGU>
end

%% High-pass filtering (temporary, aggressive for better ICA decomposition)
if nnz(o.hiPassICA) % HPF within-run to avoid edge artifacts
    [x,n] = ec_HPF(x,n,o.hiPassICA,tt,missing=o.missingInterp,gpu=o.hiPassGPU,...
        steepness=o.hiPassSteep);
    if arg.test; x_hpf=x; end
end

%% Prepare for ICA
[o,n,chNfo,errors] = prepICA_lfn(x,o,n,arg,chNfo,sfxB,sfx1,errors,tt);

%% Run ICA decomposition on GPU
n = run_cudaica_lfn(x,n,o,arg,dirs,chNfo,tt);

% Initial save of 'n'
if arg.save
    fn = o.dirOut+"n"+o.suffix+"_"+o.fnStr;
    save(fn,"n"); disp("SAVED: "+fn);
end

%% Reconstruct IC activity timecourses
[x,n] = reconstructICs_lfn(xOg,o,n,tt);

%% Get correlations between ICs & EEG chans (name ICs after closest chan)
n = get_icChCorrs(x,xOg,n,tt);
if ~arg.test; clear xOg; end

%% Classify bad ICs
if o.doBadIC
    n = classifyBadICs_lfn(n,o,tt); % Classifier doesn't like robust rereferenced data
end

%% Identify bad frames per IC
if o.doBadFrames
    [n.icBad,n.xBad] = ec_findBadFrames(x,n.icBad,...
        [],sfx1,mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);
    disp("Identified bad frames per IC: "+sbj); toc(tt);
end

%% Finalize & save
sfx = o.suffix;
% n.icNfo = movevars(n.icNfo,["MNI" "dist" "sbjIC"],"After",width(n.icNfo));
n.suffix = o.suffix;
n.("o"+sfx) = o;

% Save
if arg.save
    % Save chNfo
    fn = o.dirOut+"chNfo_"+o.fnStr;
    save(fn,"chNfo","-v7"); disp("SAVED: "+fn)
    % Save n struct
    fn = o.dirOut+"n"+sfx+"_"+o.fnStr;
    save(fn,"n","-v7"); disp("SAVED: "+fn);
    % Save IC timecourses
    fn = o.dirOut+"x"+sfx+"_"+o.fnStr+".mat";
    savefast(fn,'x'); disp("SAVED: "+fn);
end
try reset(gpuDevice()); catch;end
toc(tt);




%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% Prepare for ICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [o,n,chNfo,errors] = prepICA_lfn(x,o,n,arg,chNfo,sfxB,sfx1,errors,tt)
ch_bad=chNfo.bad; nChs=height(chNfo); fin=0; chEig=[];

% Prep chans to use for ICA
if isfield(arg,"nIn") && isstruct(arg.nIn) && isfield(arg.nIn,"chICA")
    % Get pre-specified ICA chans
    chICA = arg.nIn.chICA;
    chRank = ec_rank(x(:,chICA),exact=1); % Calculate rank
    o.ica_pca = arg.nIn.ica.pca;
    disp("[ec_preprocICA] Found user-specified params: keptChans="+numel(chICA)+" | rank="+chRank);
    fin = 1;
else
    % Find channels with any redeemable data
    id = find(contains(ch_bad.Properties.VariableNames,"asr"),1,"last");
    chICA = find(~(ch_bad{:,id} | ch_bad.nan) & any(chNfo.pialRAS(:,1),2));
    chBadr = full([ch_bad.sus,ch_bad.ref,ch_bad.("ai"+sfxB),ch_bad.("mad"+sfxB),...
        ch_bad.("diff"+sfxB),ch_bad.("flat"+sfxB),ch_bad.("sns"+sfxB)*2,ch_bad.("cov"+sfxB),...
        ch_bad.("dev"+sfxB)*2,ch_bad.("grad"+sfxB),ch_bad.("hurstL"+sfxB),ch_bad.("hurstH"+sfxB),...
        ch_bad.("detrend"+sfxB)]);
    chBadr = sum(chBadr,2);
    chBad = find(chBadr>=1);
    chRank = ec_rank(x(:,chICA),exact=1);   
    disp("[ec_preprocICA] Found redeemable chans: keptChans="+numel(chICA)+" | rank="+chRank);
    if chRank >= numel(chICA)
        fin=1; disp("[ec_preprocICA] SUCCESS - all redeemable channels ok for ICA");
    end
end
chICAbad = intersect(chICA,chBad);
chICAog = chICA;
chRankOg = chRank;

%% Permutation test for rank-deficient channels (leave-one-out)

% Get permutation indices
chRm = cell(nChs,1);
for ch = 1:nChs
    chRm{ch} = chNfo.ch~=ch;
end
[~,tol] = ec_rank(x(:,chRm{1}),exact=1);

% Try running on GPU
try x = gpuArray(x); tol = gpuArray(tol);
    chRm = cellfun(@gpuArray,chRm,"UniformOutput",false);
    chEig = arrayfun(@(rm) ec_rank(x(:,rm{:}),tol,eig=true),chRm,'UniformOutput',false);
catch ME; chEig=[]; errors{end+1}=ME; getReport(ME)
end

% Run on CPU as fallback (TO DO: use parfor instead of arrayfun?)
chRm = cellfun(@gather,chRm,"UniformOutput",false);
x=gather(x); tol=gather(tol);
if isempty(chEig)
    warning("[ec_preprocICA] Running CPU fallback for rank computation");
    chEig = arrayfun(@(rm) ec_rank(x(:,rm{:}),tol,eig=true),chRm,'UniformOutput',false);
end

% Finalize permutations
chEig = gather(cellfun(@(e) min(e)-tol,chEig)); % get minimum eigenvalue
chEigN = nnz(chEig>0);
disp("[ec_preprocICA] Full-rank channel permutations: "+chEigN+"/"+nChs);

% If currently rank-deficient, try using permuted chans as ICA chans
if ~fin && chRank<numel(chICA) && o.ica_pca<=0
    if chRankOg <= chEigN
        chRank = ec_rank(x(:,chEig>0),exact=1);
        if chRank <= chEigN
            chICA = find(chEig>0);
            chICAbad = intersect(chICA,chBad);
            disp("[ec_preprocICA] SUCCESS - permuted chans ok for ICA:");
            disp("keptChans="+numel(chICA)+" | rank="+chRank+" | excluded=");
            disp(find(chEig<=0)');
            fin = 1;
        end
    end
end

% Exclude low-eigenvalue/high-correlation chans if still rank-deficient
if ~fin && chRank<numel(chICA)
    disp("[ec_preprocICA] Permuted chans still rank-deficient, performing Eig-Corr exclusions...");
    xCorrs = abs(corr(x)); xCorrs(xCorrs==1)=nan; [~,xCorrs]=max(xCorrs);

    while chRank<numel(chICA) && numel(chICAbad)>0
        % Exclude minumum eigenvalue
        [~,chRm] = min(chEig(chICAbad));
        chRm = chICAbad(chRm);
        chICA = setdiff(chICA,chRm);
        chICAbad = setdiff(chICAbad,chRm);
        chRank = ec_rank(x(:,chICA),exact=1);

        % Exclude maximum correlsation if still rank-deficient
        if chRank < numel(chICA)
            chICA = setdiff(chICA,xCorrs(chRm)); % max correlation of minimum eigenvalue
            chICAbad = setdiff(chICAbad,xCorrs(chRm));
            chRank = ec_rank(x(:,chICA),exact=1);
        end
        if chRank>=numel(chICA); fin = 1; end
        disp("[ec_preprocICA] Eig-Corr exclusion: keptChans="+numel(chICA)+" | rank="+chRank+" | excluded=");
        disp([chRm; xCorrs(chRm)]');
    end
end

%% PCA if still rank-deficient (using all redeemable chans)
if o.ica_pca>=0 && (chRank<numel(chICA) || numel(chICA)<floor(chRankOg*.95))
    chICA = chICAog;
    chRank = ec_rank(x(:,chICA),exact=1);
    o.ica_pca = chRank;
    warning("[ec_preprocICA] Using PCA as last resort for rank-deficiency: o.ica_pca="+o.ica_pca+" for "+chNfo.sbj(1));
    errors{end+1,1} = lastwarn;
else
    o.ica_pca = 0;
end
disp("[ec_preprocICA] Finalized ICA channels "+chNfo.sbj(1)+":");
disp("keptChans="+numel(chICA)+" | rank="+chRank+" | pca="+o.ica_pca);


%% Outlier frames to exclude from ICA (robust covariance)
[ol_Q,ol_idx,ol_pct] = robCov(gpuArray(x(:,chICA)),10,90);
ol_Q = gather(ol_Q)';
ol_idx = sparse(logical(gather(ol_idx)))';
ol_pct = 100-gather(ol_pct);
disp("[ec_preprocICA] "+chNfo.sbj(1)+": pctExcludedOutlierFrames="+ol_pct);


%% Copy to permanent tables
n.chMinEig = gather(chEig);
n.ICA = true;
n.chICA = gather(chICA);
n.ica = [];
n.nICs = [];
n.icNfo = [];
n.icaPCA = o.ica_pca;
n.icOLidx = ol_idx;
n.icOLpct = ol_pct;
n.icOLq = ol_Q;
n.xBad.ica = ol_idx;
chNfo.("ica"+sfx1)(:) = false;
chNfo.("ica"+sfx1)(chICA) = true;
ch_bad.("ica"+sfx1) = sparse(~chNfo.("ica"+sfx1));
chNfo.bad = ch_bad;
n.chBad = ch_bad;
disp("[ec_preprocICA] Finished prep - "+chNfo.sbj(1)+":");
disp("keptChans="+numel(chICA)+" | rank="+chRank+" | pca="+o.ica_pca+" | time="+...
    toc(tt)/60+"min");




%% Run CUDAICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function n = run_cudaica_lfn(x,n,o,arg,dirs,chNfo,tt)
sbj = n.sbj;
sfx = o.suffix+"_"+o.fnStr;
sfx = erase(sfx,".mat");
ch_bad = chNfo.bad;
chICA = n.chICA;
idxOL = full(n.icOLidx);
cd(o.dirOut); try system("rm cudaica_"+sfx+"*"); catch;end % Remove old cudaica files
reset(gpuDevice());

% Starting weights
ic_wtsIn = '';
if isfield(arg,"nIn")
    if isstruct(arg.nIn); try ic_wtsIn = arg.nIn.ica.wts; catch;end;end
end

%% Infomax ICA compiled in CUDA
ica = ec_cudaica(x(~idxOL,chICA),dirs.cudaica,ic_wtsIn,verbose=o.ica_verbose,...
    pca=o.ica_pca,dir=o.dirOut,sfx=sfx,lrate=o.ica_lrate,stop=o.ica_stop,maxsteps=o.ica_maxItr);
nICs = height(ica.wts);
disp("Finished CUDAICA: "+sbj); toc(tt);

%% Estimate channel locations (TO DO: calculate cortex vertices)
id = find(contains(ch_bad.Properties.VariableNames,"bad"),1,"last");
idx = ch_bad{chICA,id};
icWt = abs(ica.winv');
icWt(:,idx) = nan; % remove bad chans
icWt = normalize(icWt,2,'range');
MNI = nan(nICs,3);
for ic = 1:nICs
    MNIch = chNfo.MNI(chICA,:).*icWt(ic,:)' / sum(icWt(ic,:),'omitnan');
    MNI(ic,:) = sum(MNIch,1,'omitnan');
end

% Initialize icNfo table
icNfo = table;
icNfo.order = uint16(1:nICs)';
icNfo.ic(:) = uint16(0);
icNfo.chCorr(:) = uint16(0);
icNfo.chWt(:) = uint16(0);
icNfo.MNI = MNI;
icNfo.sbjIC(:) = "";

%% Copy to 'n' struct
n.ica = ica;
n.nICs = nICs;
n.icNfo = icNfo;
n.icBad = [];
n.icW = ica.w;


%% Reconstruct IC activity %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,n] = reconstructICs_lfn(xOg,o,n,tt)
if isempty(xOg)
    xOg = ec_loadSbj(n.dirs,o.sfx_src,"x");
end

% Reconstruct IC timecourses
x = (n.icW * xOg(:,n.chICA)')';
disp("Reconstructed IC timecourses: "+n.sbj); toc(tt);

% Get IC covariance
n.icCov = cov(x,'partialrows');
n.icVar = diag(n.icCov);
n.icCorr = corrcov(n.icCov);



%% Classify bad ICs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function n = classifyBadICs_lfn(n,o,tt)
icBad = n.icNfo(:,["order" "ic" "sbjIC"]);

% Load raw EEG data (classifier doesn't work with robust referenced data)
xa = load_iEEG_LBCN(n.sbj,n.task,n.blocks,n.dirs);

% Reconstruct IC timecourses
xa = (n.icW * xa(:,n.chICA)')';

% Run classifier
[icClass,n.icDist] = ec_classifyBadChs(xa,n.icNfo.MNI);
icBad.ai = icClass.bad;

% Hurst exponent
chHrst = abs(icClass.hurs - 0.5);
[~,chHrst_lo,chHrst_hi] = isoutlier(chHrst(~icClass.bad),...
    "median","ThresholdFactor",o.thrHurst);
icBad.hurstL = chHrst < chHrst_lo;
icBad.hurstH = chHrst > chHrst_hi;

% Copy
icClass.Properties.VariableNames(2:end) =...
    string(icClass.Properties.VariableNames(2:end))+"P";
icBad(:,icClass.Properties.VariableNames(2:end)) = icClass(:,2:end);
n.icBad = icBad;

disp("Bad ICs classifier: "); disp(icBad.ic(icBad.ai)'); toc(tt);



%% Get correlations between ICs & EEG chans %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function n = get_icChCorrs(x,xOg,n,tt)
chICA = n.chICA;
nChs = numel(chICA);
nICs = width(x);
icNfo = n.icNfo;

%% Weights
winv = abs(n.ica.winv');
winv_order = nan(size(winv));
winv_sort = winv_order;
for ic = 1:nICs
    [winv_sort(ic,:),winv_order(ic,:)] = sort(winv(ic,:),2,"descend");
    winv_order(ic,:) = chICA(winv_order(ic,:));
end
icNfo.chWt = winv_order(:,1);

%% Corrs
cor = abs(corr(x,xOg(:,chICA),'Rows','pairwise'));
cor_order = nan(nICs,nChs);
cor_sort = cor_order;
for ic = 1:nICs
    [cor_sort(ic,:),cor_order(ic,:)] = sort(cor(ic,:),2,"descend");
    cor_order(ic,:) = chICA(cor_order(ic,:));
end
icNfo.chCorr = cor_order(:,1); % Name ICs by its highest-correlated channel
icName = cor_order(:,1);

%% Get IC name from top correlated/weighted chans (no repeats)
[chRep,chs] = groupcounts(icName);
chRep = chs(chRep>1);
chSkip = chICA(~ismember(chICA,icName));
itr = 0;
while ~isempty(chRep)
    itr = itr+1;
    for ic = 1:numel(chRep)
        icTmp = find(icName==chRep(ic));
        [~,id] = min(cor_sort(icTmp,1));
        icTmp = icTmp(id);
        for v = 1:nICs
            if itr==1 && winv_order(icTmp,v)~=icName(icTmp)
                ch = winv_order(icTmp,v);
            elseif itr==1 && cor_order(icTmp,v)~=icName(icTmp)
                ch = cor_order(icTmp,v);
            elseif ismember(cor_order(icTmp,v),chSkip)
                ch = cor_order(icTmp,v);
            elseif ismember(winv_order(icTmp,v),chSkip)
                ch = winv_order(icTmp,v);
            end
        end
        icName(icTmp) = ch;
    end
    [chRep,chs] = groupcounts(icName);
    chRep = chs(chRep>1);
    chSkip = chICA(~ismember(chICA,icName));
end

%% Copy
icNfo.ic = uint16(icName);
icNfo.sbjIC = "s"+n.sbjID+"_ic"+icNfo.ic;
icNfo.Properties.RowNames = icNfo.sbjIC;
icNfo = movevars(icNfo,["chWt" "chCorr"],"After","ic");
n.icNfo = icNfo;
n.icCh_corr = cor; % Correlations between ICs & EEG channels
n.icCh_corrOrder = cor_order; % Chans ordered from highest-to-lowest correlation
n.icWinvOrder = winv_order;
n.icWinvSort = winv_sort;
disp("Estimated IC correlations with EEG channels: "+n.sbj); toc(tt);


%% Depreciated
% %% Classify bad EEG channels %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [chNfo,ch_bad] = classifyBadChs_lfn(x,o,chNfo,ch_bad,sfx)
% % Run classifier
% [chClass,chNfo.dist] = ec_classifyBadChs(x,chNfo.pialRAS,chNfo.ch);
% ch_bad.("ai"+sfx) = chClass.bad;
%
% % Hurst exponent
% chHrst = abs(chClass.hurs - 0.5);
% [~,chHrst_lo,chHrst_hi] = isoutlier(chHrst(~ch_bad.asr|~ch_bad.empty|~ch_bad.ai|~chClass.bad),...
%     "median","ThresholdFactor",o.thrHurst);
% ch_bad.("hurstL"+sfx) = chHrst < chHrst_lo;
% ch_bad.("hurstH"+sfx) = chHrst > chHrst_hi;
%
% % Copy
% ch_bad.("bad"+sfx) = ch_bad.ref|ch_bad.empty|chClass.bad|ch_bad.("hurstL"+sfx);
% tmp = string(chClass.Properties.VariableNames(3:end))+"P"+sfx;
% ch_bad(:,tmp) = chClass(:,3:end);
% disp("Bad chans CLASSIFIER:"); disp(find(ch_bad.ai)');
% disp("Bad chans ALL:"); disp(find(ch_bad.bad)');
% end
