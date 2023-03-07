function [errors,n,x] = ec_preprocICA(sbj,task,o,n,x,arg)
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
    sbj % Subject name
    task {mustBeText} = 'MMR' % task name
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    n struct = [] % preloaded 'n' info output from ec_initialize or robustPreproc (OPTIONAL)
    x {isfloat} = [] % preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
    arg.blocks {istext,isnumeric} = BlockBySubj(sbj,task) % Task blocks/runs to include
    arg.dirs struct = [] % Directory paths struct
    arg.save logical = false % Save outputs to disk
    arg.test logical = false
    arg.redoN logical = true
    arg.nIn {isstruct} = []
    arg.raw logical = false
end
blocks=arg.blocks; dirs=arg.dirs;
% x=[]; n=[]; o=oICA; arg.raw=false; arg.nIn=[]; arg.save=0; arg.test=1; arg.redoN=1;

%% Initialize & load data
if ~exist('dirs','var') || ~isstruct(dirs); dirs = ec_getDirs(dirs,sbj,task); end
if ~exist('blocks','var') || isempty(blocks); blocks = BlockBySubj(sbj,task); end
try parpool('threads'); catch;end
tt = tic;

% Load metadata
[errors,o,n,chNfo,~,~] = ec_initialize(sbj,task,o,n,dirs=dirs,save=arg.save,...
    redoN=arg.redoN); % Load metadata
cd(o.dirOut); % set working directory to subject dir

% Load EEG data
if isempty(x) && arg.raw
    [x,errors,chNan] = load_iEEG_LBCN(sbj,task,blocks,dirs,errors); toc(tt);
    chNfo.bad.nan(chNan) = true;
elseif isempty(x)
    x = ec_loadSbj(dirs,o.sfx_src,"x");
end
if ~isempty(x)
    xOg = x; % Save input data for later
end

% Suffixes
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
if o.suffix=="i"; sfx1=""; else; sfx1="_"+o.suffix; end

%% Classify bad chans & frames
sfxB = "";
% if o.doBadCh
%     [chNfo] = classifyBadChs_lfn(x,o,chNfo,sfx); % Bad chan classifier
%     chGood = ~chNfo.bad.("bad"+sfx);
%     sfxB = sfx;
% elseif contains(o.suffix,"i") && any(chNfo.bad.Properties.VariableNames=="bad_i")
%     chGood = ~chNfo.bad.rr_i;            disp("Bad chans: ch_bad.bad_i "+sbj);
% elseif any(chNfo.bad.Properties.VariableNames=="rr")
%     chGood = ~chNfo.bad.rr;              disp("Bad chans: ch_bad.rr "+sbj);
% elseif any(chNfo.bad.Properties.VariableNames=="bad")
%     chGood = ~chNfo.bad.bad;             disp("Bad chans: ch_bad.bad "+sbj);
% else
%     chGood = true(nChs,1);
% end
% toc(tt);

%% Robust detrending (temporary, aggressive for better ICA decomposition)
if nnz(o.detrendOrder)
    [n,x] = ec_detrend(n,x,order=o.detrendOrder,thr=o.detrendThr,itr=o.detrendItr,...
        win=o.detrendWin,missing=o.missingInterp,gpu=o.detrendGPU,single=o.detrendSingle,tic=tt);
    if arg.test; x_detr=x; end %#ok<*NASGU> 
end

%% High-pass filtering (temporary, aggressive for better ICA decomposition)
if nnz(o.hiPassICA) % HPF within-run to avoid edge artifacts
    [n,x] = ec_HPF(n,x,tt,hpf=o.hiPassICA,missing=o.missingInterp,gpu=o.hiPassGPU,sfx=sfx);
    if arg.test; x_hpf=x; end 
end

%% Prepare for ICA
[o,chNfo,chICA,errors] = prepICA_lfn(x,o,arg,chNfo,sfxB,sfx1,errors,tt);

%% Run ICA decomposition on GPU
n = run_cudaica_lfn(x,n,o,arg,dirs,chNfo,chICA,tt);

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
n.icNfo = movevars(n.icNfo,["MNI" "dist" "sbjIC"],"After",width(n.icNfo));
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
    fn = o.dirOut+"x"+sfx+"_"+o.fnStr;
    savefast(fn,'x'); disp("SAVED: "+fn);
end
toc(tt);
end



%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Classify bad EEG channels %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [chNfo,ch_bad] = classifyBadChs_lfn(x,o,chNfo,ch_bad,sfx)
% Run classifier
[chClass,chNfo.dist] = ec_classifyBadChs(x,chNfo.pialRAS,chNfo.ch);
ch_bad.("ai"+sfx) = chClass.bad;

% Hurst exponent
chHrst = abs(chClass.hurs - 0.5);
[~,chHrst_lo,chHrst_hi] = isoutlier(chHrst(~ch_bad.asr|~ch_bad.empty|~ch_bad.ai|~chClass.bad),...
    "median","ThresholdFactor",o.thrHurst);
ch_bad.("hurstL"+sfx) = chHrst < chHrst_lo;
ch_bad.("hurstH"+sfx) = chHrst > chHrst_hi;

% Copy
ch_bad.("bad"+sfx) = ch_bad.ref|ch_bad.empty|chClass.bad|ch_bad.("hurstL"+sfx);
tmp = string(chClass.Properties.VariableNames(3:end))+"P"+sfx;
ch_bad(:,tmp) = chClass(:,3:end);
disp("Bad chans CLASSIFIER:"); disp(find(ch_bad.ai)');
disp("Bad chans ALL:"); disp(find(ch_bad.bad)');
end



%% Prepare for ICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [o,chNfo,chICA,errors] = prepICA_lfn(x,o,arg,chNfo,sfxB,sfx1,errors,tt)
if ~exist('tt','var'); tt = tic; end
xCh = x;
ch_bad = chNfo.bad;

% Find channels to use for ICA
if isfield(arg,"nIn") && isstruct(arg.nIn) && isfield(arg.nIn,"chICA")
    chICA = arg.nIn.chICA;
    chRank = ec_rank(xCh(:,chICA)); % Calculate rank
    o.ica_pca = arg.nIn.ica.pca;
    disp("Using previous ICA params: num_chICA="+numel(chICA)+" | rank="+chRank);
else
    % Find all redeemable cahns
    id = find(contains(ch_bad.Properties.VariableNames,"asr"),1,"last");
    chICA = find(~(ch_bad{:,id} | ch_bad.nan) & any(chNfo.pialRAS(:,1),2)); 
    id = find(contains(ch_bad.Properties.VariableNames,"rr"),1,"last");
    chBadr = full([ch_bad{:,id},ch_bad.sus,ch_bad.ref,ch_bad.("ai"+sfxB),ch_bad.("mad"+sfxB),...
        ch_bad.("diff"+sfxB),ch_bad.("flat"+sfxB),ch_bad.("sns"+sfxB)*2,ch_bad.("cov"+sfxB),...
        ch_bad.("dev"+sfxB)*2,ch_bad.("grad"+sfxB),ch_bad.("hurstL"+sfxB),ch_bad.("hurstH"+sfxB)]);
    chBadr = sum(chBadr,2);
    chBad = find(chBadr>=1);
    chICAbad = intersect(chICA,chBad);
    chHrst = abs(ch_bad.("hursP"+sfxB) - 0.5);
    chICAog = chICA;

    % Find rank using conservative tolerance
    tol = min([1 prctile(ec_rank(xCh(:,chICA),eig=1),5)]);
    chRank = ec_rank(xCh(:,chICA),tol=tol); % Calculate rank
    chRankOg=chRank; doGPU=0;
    disp("ICA_chans="+numel(chICA)+" | rank="+chRank);

    % If rank-deficient, try channel exclusions
    if chRank<numel(chICA) && o.ica_pca<=0 && numel(chICAbad)>0
        % Setup leave-one-out
        chs=chNfo.ch; chRm=cell(numel(chICAbad),1); chEigs=nan(numel(chs),1);
        try xCh=gpuArray(xCh); doGPU=arrayfun(@isnumeric,xCh(1,1)); catch;end
        for v = 1:numel(chICAbad)
            ch = chICAbad(v);
            chRm{v} = ismember(chs,chICA) & chs~=ch;
            if doGPU; chRm{v} = gpuArray(chRm{v}); end
        end
 
        % Calculate channel deficiency contribution via leave-one-out perms
        chEigs(chICAbad) = arrayfun(@(rm) min(ec_rank(xCh(:,rm{:}),eig=true)),...
            chRm,'UniformOutput',true);

        % Remove channels w greatest deficiency contribution until rank-sufficient
        while chRank<numel(chICA) && floor(chRankOg*.95)<numel(chICA) && numel(chICAbad)>0
            [~,chRm] = min(chEigs(chICAbad)); % ultra-conservative rank
            chRm = chICAbad(gather(chRm));
            if numel(chRm)>1
                [~,id] = max(chBadr(chRm));
                chRm = chRm(id);
                if numel(chRm)>1
                    [~,id] = min(chHrst(chRm));
                    chRm = chRm(id); chRm=chRm(1);
                end
            end
            chICA(chICA==chRm) = [];
            chICAbad = intersect(chICA,chBad);
            chRank = gather(ec_rank(xCh(:,chICA),tol=tol));
            disp("ICA_chans="+numel(chICA)+" | rank="+chRank+" | excluded="+chRm);
        end
    end

    % Do PCA if still rank-deficient (using all redeemable chans)
    if chRank<numel(chICA) && o.ica_pca>=0
        chICA = chICAog;
        chRank = gather(ec_rank(xCh(:,chICA),tol=tol));
        o.ica_pca = chRank;
        warning("setting o.ica_pca="+o.ica_pca+" for "+chNfo.sbj(1));
        errors{end+1,1} = lastwarn;
    else
        o.ica_pca = 0;
    end

    chNfo.bad = ch_bad;
    disp("ICA_chans="+numel(chICA)+" | rank="+chRank+" | pca="+o.ica_pca);
end

% Copy to permanent tables
chNfo.("ica"+sfx1)(:) = false;
chNfo.("ica"+sfx1)(chICA) = true; % indicate ICA channels
ch_bad.("ica"+sfx1) = chNfo.("ica"+sfx1);
disp("Finished ICA prep: "+chNfo.sbj(1)); toc(tt);
end



%% Run CUDAICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function n = run_cudaica_lfn(x,n,o,arg,dirs,chNfo,chICA,tt)
sbj = n.sbj;
sfx = o.suffix+"_"+o.fnStr;
sfx = erase(sfx,".mat");
ch_bad = chNfo.bad;
idxICA = full(n.xBad.detrend);
idxICA = sum(idxICA,2);
[~,~,thr] = isoutlier(idxICA,"median",1,"ThresholdFactor",6);
idxICA = idxICA>thr;
cd(o.dirOut); try system("rm cudaica_"+sfx+"*"); catch;end % Remove old cudaica files
try reset(gpuDevice()); catch;end

% Starting weights
ic_wtsIn = '';
if isfield(arg,"nIn")
    if isstruct(arg.nIn); try ic_wtsIn = arg.nIn.ica.wts; catch;end; end
end

%% Infomax ICA compiled in CUDA
ica = ec_cudaica(x(~idxICA,chICA),dirs.cudaica,ic_wtsIn,verbose="off",...
    pca=o.ica_pca,dir=o.dirOut,sfx=sfx,lrate=o.ica_lrate,stop=o.ica_stop,maxsteps=o.ica_maxItr);
nICs = height(ica.wts);
disp("Finished CUDAICA: "+sbj); toc(tt);

%% Estimate channel locations (TO DO: calculate cortex vertices)
id = find(contains(ch_bad.Properties.VariableNames,"rr"),1,"last");
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
n.ICA = true;
n.ica = ica;
n.chICA = chICA;
n.nICs = nICs;
n.icNfo = icNfo;
n.icBad = [];
n.icW = ica.w;
n.badFramesICA = sparse(idxICA);
%n.icPCA = pcaArg;
end



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
end



%% Classify bad ICs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function n = classifyBadICs_lfn(n,o,tt)
icBad = n.icNfo(:,["order" "ic" "sbjIC"]);

% Load raw EEG data (classifier doesn't work with robust referenced data)
xa = load_iEEG_LBCN(n.sbj,n.task,n.blocks,n.dirs);

% Reconstruct IC timecourses
xa = (n.icW * xa(:,n.chICA)')';

% Run classifier
[chClass,n.icNfo.dist] = ec_classifyBadChs(xa,n.icNfo.MNI);
icBad.ai = chClass.bad;

% Hurst exponent
chHrst = abs(chClass.hurs - 0.5);
[~,chHrst_lo,chHrst_hi] = isoutlier(chHrst(~chClass.bad),...
    "median","ThresholdFactor",o.thrHurst);
icBad.hurstL = chHrst < chHrst_lo;
icBad.hurstH = chHrst > chHrst_hi;

% Copy
chClass.Properties.VariableNames(2:end) =...
    string(chClass.Properties.VariableNames(2:end))+"P";
icBad(:,chClass.Properties.VariableNames(2:end)) = chClass(:,2:end);
n.icBad = icBad;

disp("Bad ICs classifier: "); disp(find(icBad.ai)'); toc(tt);
end



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
end
