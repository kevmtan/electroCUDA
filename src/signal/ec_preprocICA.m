function [errors,n,x] = ec_preprocICA(sbj,proj,o,n,x,arg)
%% CUDA-based ICA for intracranial/scalp electrophysiology
%  This function is part of electroCUDA (github.com/kevmtan/electroCUDA)
%  ICA weights are calculated from hipassed/detrended EEG data to mitigate
%  non-stationarity. IC timecourses are extracted by appling ICA weights to
%  non-hipassed/detrended EEG data to avoid artifacts.
%
%  Call this function using its wrapper:
%                             ~/electroCUDA/1/pipeline/pre5_robustPreproc.m
%
% MAIN INPUTS:
%    sbj = subject name
%    proj = project name
%    o = struct of options & parameters (described below in "Options struct validation")
%    n = preloaded 'n' info output from ec_initialize or robustPreproc (OPTIONAL)
%    x = raw EEG recordings: rows=frames, columns=channels (OPTIONAL)
%
% NAME-VALUE INPUTS:
%    see below sections: "Main input validation" & "Options struct validation"
%
% OUTPUTS:
%   xi = Preprocessed EEG data indexed as: x(timeframe,channel)
%   ni = Struct of preprocessing info with ICA weights
%
% ALGORITHM SEQUENCE:
%    power line denoise, detrend, detect bad channels, detect spatiotemporal outliers (channel covariance),
%    robust rereferencing, detect epileptic HFOs, calculate ICA weights,
%    apply ICA to non-hipassed EEG data, detect noisy timepoints (within-IC)
%
% ALGORITHM OPTIONS: see below section "Options struct validation"
%
% HARDWARE ACCELERATION: threaded CPU parallelization (see MATLAB ThreadPool)
%
%
%               Kevin Tan, 2022 (http://github.com/kevmtan/electroCUDA)
%
%
% ACKNOWLEDGEMENTS:
%    * Stanford Parvizi Lab (Pedro Pinhiero-Chagas, Amy Daitch, Su Liu, et al.)
%    * Laboratoire des Systèmes Perceptifs (NoiseTools: Alain de Cheveigné, et al.)
% LICENSE: GNU General Public License
% DISCLAIMER: Use this code at your own risk. Author assumes no responsibility
%    for any adverse outcomes related this code or its use. Author makes no
%    guarantees on the performance or accuracy of this code. This code is for
%    research purposes only. NOT INTENDED FOR MEDICAL USE.

%% Main input validation
arguments
    sbj % Subject name
    proj {mustBeText} = 'MMR' % Project name
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    n struct = [] % preloaded 'n' info output from ec_initialize or robustPreproc (OPTIONAL)
    x {isfloat} = [] % preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
    arg.blocks {mustBeText} = BlockBySubj(sbj,proj) % Task blocks/runs to include
    arg.dirs struct = [] % Directory paths struct
    arg.save logical = false % Save outputs to disk
    arg.test logical = false
    arg.redoN logical = true
    arg.nIn {isstruct} = []
    arg.raw logical = false
end
blocks=arg.blocks; dirs=arg.dirs;
% x=[]; n=[]; o=oICA; arg.raw=false; arg.nIn=[]; arg.save=1; arg.test=1; arg.redoN=0;

%% Options struct validation (non-exhaustive, see individual functions below)
if ~exist('dirs','var') || ~isstruct(dirs); dirs = ec_getDirs(dirs,sbj,proj); end
if ~exist('blocks','var') || isempty(blocks); blocks = BlockBySubj(sbj,proj); end
% % Filtering
% if ~isfield(o,'hiPassICA');       o.hiPass=1; end
% if ~isfield(o,'hiPass');          o.hiPass=0.01; end
% % Detrending
% if ~isfield(o,'detrendOrder_ICA'); o.detrendOrder_ICA=[10 30]; end  % For ICA decomp: detrend polynomial order for ICA  (suggested=10, skip=0)
% if ~isfield(o,'detrendOrder');    o.detrendOrder=10; end     % For final output: detrend polynomial order (default=0, skip=0)
% if ~isfield(o,'detrendWin');      o.detrendWin=[]; end       % Detrend timewindow in seconds (all timepoints=[])
% % Bad channel/IC identification
% if ~isfield(o,'doBadCh');         o.doBadCh=false; end       % true/false
% if ~isfield(o,'doBadIC');         o.doBadCh=true; end        % true/false
% if ~isfield(o,'badChProp');       o.badChProp=0.5; end       % Criterion proportion of bad samples [default: 0.5]
% if ~isfield(o,'thrHurst');        o.thrHurst=3; end          % Hurst threshold (median absolute deviation)
% % Rereferencing
% if ~isfield(o,'doRereference');   o.doRereference=true; end
% if ~isfield(o,'rrThr');           o.rrThr=3; end             % Outlier threshold (default=3,skip=0)
% if ~isfield(o,'rrItr');           o.rrItr=5; end             % Number of iterations (default=5)
% % Electric line noise removal
% if ~isfield(o,'lineHz');          o.lineHz=0; end            % Electricity hertz @ EEG recording site (default=0, skip=0)
% % Detect epileptic high-frequency oscillations (HFO)
% if ~isfield(o,'thrHFO');          o.thrHFO=2; end            % Threshold for epileptic HFO detection (default=2)
% % Detect within-channel outlier timepoints
% if ~isfield(o,'doBadFrames');     o.doBadFrames=true; end    % true/false
% if ~isfield(o,'thrMAD');          o.thrMAD=10; end           % Z-threshold relative to all data points to exclude timepoints
% if ~isfield(o,'thrDiff');         o.thrDiff=10; end          % Z-threshold for amplitude differences of consecutive timepoints
% if ~isfield(o,'thrSNS');          o.thrSNS=3; end            % Threshold for low-freq spikes
try parpool('threads'); catch;end

%% Load & initialize
tt = tic;
% Load metadata
[errors,o,n,chNfo] = ec_initialize(sbj,proj,o,n,redoN=arg.redoN,dirs=dirs,save=arg.save);

% Initialize variables/objects
ch_bad = chNfo.bad;
n.proj = proj;
% runIdx = grpstats(psy,"run",["min" "max"],"DataVars","idx"); % Get run indices
% runIdx = sortrows(runIdx,["min_idx" "max_idx"],"ascend");
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
if o.suffix=="i"; sfx1=""; else; sfx1="_"+o.suffix; end
cd(o.dirOut);

% Load EEG data
xOg=[];
if isempty(x) && arg.raw
    [x,errors,chNan] = load_iEEG_LBCN(sbj,proj,blocks,dirs,errors); toc(tt);
    ch_bad.nan(chNan) = true;
elseif isempty(x)
    x = ec_loadSbj(dirs,"","x");
else
    xOg = x; % Save input data for later
end

n.dirs = dirs;

%% Robust detrending for better ICA decomposition (aggressive)
[x,n] = ec_hiPassDetrend(x,o.hiPassICA,o.detrendOrder_ICA,o.detrendWin,n,tt,...
    itr=o.detrendItr_ICA,thr=o.detrendThr_ICA,missing=o.missingInterp,sfx=sfx1,gpu=0);

%% Classify bad chans & frames
if o.doBadCh
    [chNfo,ch_bad] = classifyBadChs_lfn(x,o,chNfo,ch_bad,sfx); % Bad chan classifier
    chGood = ~ch_bad.("bad"+sfx);
elseif contains(o.suffix,"i") && any(ch_bad.Properties.VariableNames=="bad_i")
    chGood = ~ch_bad.rr_i;            disp("Bad chans: ch_bad.bad_i "+sbj);
elseif any(ch_bad.Properties.VariableNames=="rr")
    chGood = ~ch_bad.rr;              disp("Bad chans: ch_bad.rr "+sbj);
elseif any(ch_bad.Properties.VariableNames=="bad")
    chGood = ~ch_bad.bad;             disp("Bad chans: ch_bad.bad "+sbj);
else
    chGood = true(nChs,1);
end
toc(tt);

%% Robust rereference
if o.doRereference
    [x,chGood] = ec_rereference(x,chGood',o.rrThr,o.rrItr);
    chGood = chGood';
    ch_bad.("rr"+sfx) = ~chGood;
    disp("Finished robust referencing"); toc(tt);
end

%% Prepare for ICA
[o,ch_bad,chNfo,chICA,errors] = prepICA_lfn(x,o,arg,ch_bad,chNfo,sfx1,errors,tt);
chNfo.bad = ch_bad;

%% Run ICA decomposition on GPU
[n,icNfo] = run_cudaica_lfn(x,n,o,arg,dirs,chNfo,chICA,tt);

% Initial save of 'n'
if arg.save
    fn = o.dirOut+"n"+o.suffix+"_"+o.fnStr;
    save(fn,"n"); disp("SAVED: "+fn);
end

%% Classify bad ICs
if o.doBadIC
    icNfo = classifyBadICs_lfn(icNfo,n,o,tt); % Classifier doesn't like robust rereferenced data
end

%% Reconstruct IC activity timecourses
[x,xOg,n] = reconstructICs_lfn(xOg,o,n,chGood,chICA,tt);

%% Get correlations between ICs & EEG chans
[icName,icCh_corr,icCh_corrOrder] = get_icChCorrs(x,xOg);

%% Copy to permanent vars
icNfo.name = uint16(icName); % Name ICs by its highest-correlated channel
icNfo.sbjIC = "s"+n.sbjID+"_ic"+icNfo.name;
icNfo.Properties.RowNames = icNfo.sbjIC;
n.icCh_corr = icCh_corr; % Correlations between ICs & EEG channels
n.icCh_corrOrder = icCh_corrOrder; % Chans ordered from highest-to-lowest correlation
disp("Estimated IC correlations with EEG channels: "+sbj); toc(tt);
if ~arg.test; clear xOg; end

%% Identify bad frames per IC
if o.doBadFrames
    [ic_bad,x_bad] = ec_findBadFrames(x,[],icNfo(:,["ic" "name"]),mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);
    ic_bad.Properties.VariableNames = "bad_"+ic_bad.Properties.VariableNames;
    icNfo(:,ic_bad.Properties.VariableNames) = ic_bad;
    n.badFrames = x_bad;
    disp("Identified bad frames per IC: "+sbj);
end

%% Finalize & save
sfx = o.suffix;

% Finalize
n.suffix = o.suffix;
icNfo = movevars(icNfo,["MNI" "sbjIC"],"After",width(icNfo));
if o.doBadIC; icNfo = movevars(icNfo,"dist","Before","sbjIC"); end
n.icNfo = icNfo;
n.("o"+sfx) = o;

% Save
if arg.save
    % Save n struct
    fn = o.dirOut+"n"+sfx+"_"+o.fnStr;
    save(fn,"n"); disp("SAVED: "+fn);
    % Save chNfo
    fn = o.dirOut+"chNfo_"+o.fnStr;
    save(fn,"chNfo","-v7"); disp("SAVED: "+fn)
    % Save IC timecourses
    fn = o.dirOut+"x"+sfx+"_"+o.fnStr;
    save(fn,"x","-v7.3","-nocompression"); disp("SAVED: "+fn);
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
[~,chHrst_lo,chHrst_hi] = isoutlier(chHrst(~ch_bad.ref|~ch_bad.empty|~chClass.bad),...
    "median","ThresholdFactor",o.thrHurst);
ch_bad.("hurstL"+sfx) = chHrst < chHrst_lo;
ch_bad.("hurstH"+sfx) = chHrst > chHrst_hi;

% Copy
ch_bad.("bad"+sfx) = ch_bad.ref|ch_bad.empty|chClass.bad|ch_bad.("hurstL"+sfx);
tmp = string(chClass.Properties.VariableNames(3:end))+"P"+sfx;
chClass.Properties.VariableNames(3:end) = tmp;
ch_bad(:,tmp) = chClass(:,3:end);
disp("Bad chans CLASSIFIER:"); disp(find(ch_bad.ai)');
disp("Bad chans ALL:"); disp(find(ch_bad.bad)');
end



%% Prepare for ICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [o,ch_bad,chNfo,chICA,errors] = prepICA_lfn(x,o,arg,ch_bad,chNfo,sfx1,errors,tt)
if ~exist('tt','var'); tt = tic; end

% Find channels to use for ICA
if isfield(arg,"nIn") && isstruct(arg.nIn) && isfield(arg.nIn,"chICA")
    chICA = arg.nIn.chICA;
    chRank = ec_rank(x(:,chICA)); % Calculate rank
    o.ica_pca = 0;
    disp("Using previous ICA params: num_chICA="+numel(chICA)+" | rank="+chRank);
else
    id = find(contains(ch_bad.Properties.VariableNames,"asr"),1,"last");
    chICA = find(~(ch_bad{:,id}) | ismember(chNfo.pialRAS(:,1),[0 nan]));
    chBad = find(sum(full([ch_bad.rr,ch_bad.ref,ch_bad.sns,ch_bad.hurstL,ch_bad.hurstH,...
        ch_bad.flat,ch_bad.cov]),2)>=2);
    chRank = ec_rank(x(:,chICA),true); % Calculate rank
    disp("ICA_chans="+numel(chICA)+" | rank="+chRank);

    % If rank-deficient by 1; permute to find which chans to exclude
    rankSufficient = 0;
    if chRank < numel(chICA)
        
        chRankz = nan(numel(chICA),1); chRanks=chRankz;
        parfor v = 1:numel(chICA) % See which exclusions result in highest rank
            xCh = x;
            ch = chICA(v);
            id = chICA~=ch; %#ok<PFBNS>
            chRankz(v) = ec_rank(xCh(:,chICA(id)),false,100); % ultra-coservative rank
            chRanks(v) = ec_rank(xCh(:,chICA(id))); % normal rank
        end

        % Find channel(s) w greatest rank deficiency contribution
        [~,idx] = max(chRankz); % ultra-conservative rank
        chRank = chRanks(idx); % normal rank
        chRm = chICA(idx);
        chRm(~ismember(chRm,chBad)) = [];
        % If too many chans
        while numel(chRm) > numel(chICA)-chRank
            [~,id] = min(chRankz(ismember(chICA,chRm)));
            try chRm(id)=[]; catch;end
        end

        % Remove chan only if it fixes rank-deficiency
        chRankRm = ec_rank(x(:,chICA(chICA~=chRm)),true);
        if chRankRm >= numel(chICA) - numel(chRm)
            chICA(chICA==chRm) = [];
            disp("ICA_chans="+numel(chICA)+" | rank="+chRankRm+" | excluded="+chRm);
            rankSufficient = 1;
        end
    else; rankSufficient = 1;
    end

    % If rank deficient by more than 1, do PCA
    chRank = ec_rank(x(:,chICA),true); % Calculate rank
    if ~rankSufficient && chRank < numel(chICA)
        o.ica_pca = ec_rank(x(:,chICA),false,50);
        warning("setting o.ica_pca="+o.ica_pca+" for "+chNfo.sbj(1));
        errors{end+1,1} = lastwarn;
    else
        o.ica_pca = 0;
    end
    disp("ICA_chans="+numel(chICA)+" | rank="+chRank+" | pca="+o.ica_pca);
end

% Copy to permanent tables
chNfo.("ica"+sfx1)(:) = false;
chNfo.("ica"+sfx1)(chICA) = true; % indicate ICA channels
ch_bad.("ica"+sfx1) = chNfo.("ica"+sfx1);
toc(tt);

%% Find outlier frames common to all EEG chans for ICA
% chGMM = fitgmdist(x(:,chICA),2,'RegularizationValue',0.01,... % Fit gaussian mixture model (GMM)
%     'Options',statset('Display','final','UseParallel',true));
%
% % Get outliers from GMM log-likelihood
% [~,~,~,chICA_badIdx] = cluster(chGMM,x(:,chICA));
% chICA_badIdx = isoutlier(chICA_badIdx,"median","ThresholdFactor",4);
% disp("Found outlier frames in ICA chans (gaussian mixture): "+sbj); toc(tt);
% varCh = varfun(@islogical,ch_bad(1,:),"OutputFormat","uniform");
% while chRank<numel(chICA) && chPct>0.9
%     chBad = intersect(chICA,find(~chGood|chCovOL|ch_bad.sus|ch_bad.rr));
%     [maxCorr,~] = max(chCorr(chICA,chICA),[],'all');
%
%     % Determine ICA channels to look at
%     if (chPct>=1 || maxCorr>=0.95) && ~isempty(chBad); chB = chBad;
%     else; chB = chICA; end
%     [~,idx] = max(chCovZ(chB,chB),[],'all');
%     [ch1,ch2] = ind2sub([numel(chB) numel(chB)],idx);
%     ch1 = chB(ch1);
%     ch2 = chB(ch2);
%     chx = [ch1 ch2];
%
%     % Sum bad metrics per channel
%     ch1b = chCovZ(ch1)*10 + nnz(ch_bad{ch1,varCh}); % ~chGood(ch1)*5
%     ch2b = chCovZ(ch2)*10 + nnz(ch_bad{ch2,varCh}); % ~chGood(ch2)*5
%
%     % Remove chan
%     if ch1b ~= ch2b % Prioritize worse chans
%         [~,idx] = max([ch1b ch2b]);
%     else % If equal, remove highest variance chan (faster rank normalization)
%         [~,idx] = max(chVar(chx));
%     end
%     chICA(chICA==chx(idx)) = [];
%     chPct = numel(chICA)/chRankOg;
%     chRank = ec_rank(x(:,chICA)); % Calculate rank
%     disp("ICA_chans="+numel(chICA)+" | rank="+chRank+" | maxCorr="+maxCorr+" | chPct="+chPct);
% end
% % Do PCA if still rank-deficient
% if chRank < numel(chICA)
%     chICA = find(~(ch_bad.bad|ch_bad.nan|ismember(chNfo.pialRAS(:,1),[0 nan])));
%     pcaArg = ec_rank(x(:,chICA));
%     warning("setting pcaArg="+pcaArg+" for "+sbj);
%     errors{end+1,1} = lastwarn;
% else
%     pcaArg = 0;
% end

end



%% Run CUDAICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [n,icNfo] = run_cudaica_lfn(x,n,o,arg,dirs,chNfo,chICA,tt) %#ok<INUSD>
sbj = n.sbj;
sfx = o.suffix+"_"+o.fnStr;
sfx = erase(sfx,".mat");
cd(o.dirOut); system("rm cudaica_"+sfx+"*"); % Remove old cudaica files
ch_bad = chNfo.bad;

% Starting weights
ic_wtsIn = '';
% if isfield(arg,"nIn") && isstruct(arg.nIn)
%     try ic_wtsIn = arg.nIn.ica.wts;
%     catch
%         ic_wtsIn = arg.nIn.icWeights;
%     end
% end

%% Infomax ICA compiled in CUDA
try reset(gpuDevice(1)); catch; end
ica = ec_cudaica(x(:,chICA),dirs.cudaica,ic_wtsIn,pca=o.ica_pca,dir=o.dirOut,sfx=sfx,...
    lrate=o.ica_lrate,stop=o.ica_stop,maxsteps=o.ica_maxItr);
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
icNfo.ic = uint16(1:nICs)';
icNfo.name(:) = uint16(0);
icNfo.MNI = MNI;

% Copy to 'n' struct
n.ICA = true;
n.ica = ica;
n.chICA = chICA;
%n.chICA_badFrames = sparse(chICA_badIdx);
n.nICs = nICs;
n.icNfo = icNfo;
n.icW = ica.w;
n.icWinvZ = normalize(ica.winv',2,'zscore');
%n.icPCA = pcaArg;

end



%% Reconstruct IC activity %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,xOg,n] = reconstructICs_lfn(xOg,o,n,chGood,chICA,tt)
if isempty(xOg)
   xOg = ec_loadSbj(n.dirs,"","x");
end

% Hi-pass & detrend
[xOg,n] = ec_hiPassDetrend(xOg,o.hiPass,o.detrendOrder,o.detrendWin,n,tt,...
    itr=o.detrendItr,thr=o.detrendThr,sfx=n.suffix);

% Rereference
if o.doRereference
    xOg = ec_rereference(xOg,chGood',o.rrThr);
    disp("Finished robust referencing (final): "+n.sbj); toc(tt);
end

% Reconstruct IC timecourses
x = (n.icW * xOg(:,chICA)')';
disp("Reconstructed IC timecourses: "+n.sbj); toc(tt);

% Get IC covariance
n.icCov = cov(x,'partialrows');
n.icVar = diag(n.icCov);
n.icCorr = corrcov(n.icCov);
end



%% Classify bad ICs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function icNfo = classifyBadICs_lfn(icNfo,n,o,tt)

% Load raw EEG data (classifier doesn't work with robust referenced data)
xa = load_iEEG_LBCN(n.sbj,n.proj,n.blocks,n.dirs);

% Reconstruct IC timecourses
xa = (n.icW * xa(:,n.chICA)')';

% Run classifier
[chClass,icNfo.dist] = ec_classifyBadChs(xa,icNfo.MNI);
icNfo.bad_ai = chClass.bad;

% Hurst exponent
chHrst = abs(chClass.hurs - 0.5);
[~,chHrst_lo,chHrst_hi] = isoutlier(chHrst(~chClass.bad),...
    "median","ThresholdFactor",o.thrHurst);
icNfo.bad_hurstL = chHrst < chHrst_lo;
icNfo.bad_hurstH = chHrst > chHrst_hi;

% Copy
chClass.Properties.VariableNames(2:end) =...
    "bad_"+string(chClass.Properties.VariableNames(2:end))+"P";
icNfo(:,chClass.Properties.VariableNames(2:end)) = chClass(:,2:end);
disp("Bad ICs classifier: "); disp(find(icNfo.bad_ai)'); toc(tt);
end



%% Get correlations between ICs & EEG chans %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [icName,icCh_corr,icCh_corrOrder] = get_icChCorrs(x,xCh)
nChs = width(xCh);
nICs = width(x);

icCh_corr = corr(x,xCh,'Rows','pairwise');
icCh_corrOrder = nan(nICs,nChs);
icCh_corrSort = icCh_corrOrder;
for ic = 1:nICs
    [icCh_corrSort(ic,:),icCh_corrOrder(ic,:)] = sort(icCh_corr(ic,:),2,"descend");
end

icName = icCh_corrOrder(:,1);
chRep = find(hist(icName,1:nChs)>1); %#ok<HIST>
chSkip = find(hist(icName,1:nChs)<1); %#ok<HIST>
while ~isempty(chRep)
    for ic = 1:numel(chRep)
        icTmp = find(icName==chRep(ic));
        [~,idx] = min(icCh_corrSort(icTmp,1));
        icTmp = icTmp(idx);
        [~,idx] = max(icCh_corr(icTmp,chSkip));
        ch = chSkip(idx);
        icName(icTmp) = ch;
    end
    chRep = find(hist(icName,1:nChs)>1); %#ok<HIST>
    chSkip = find(hist(icName,1:nChs)<1); %#ok<HIST>
end
end
