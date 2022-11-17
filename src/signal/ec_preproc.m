function [errors,n,x] = ec_preproc(sbj,proj,o,n,x,arg)
%% electroCUDA - initial robust preprocessing steps for intracranial EEG
% See these functions for later-stage preprocessing steps:
%     - ec_preprocICA (source separation & denoising via ICA)
%     - ec_preprocTimeFreq (time-frequency decomposition via wavelets)
%
% SEE WIKI FOR MORE INFO: github.com/kevmtan/electroCUDA/wiki
%
% INPUTS:
%    sbj = subject name
%    proj = project name
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
    % Main inputs
    sbj % Subject name
    proj {mustBeText} = 'MMR' % Project name
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    n struct = [] % preloaded 'n' info output from ec_initialize or robustPreproc (OPTIONAL)
    x {isfloat} = [] % preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
    % Name-value inputs 
    arg.blocks {mustBeText} = BlockBySubj(sbj,proj) % Task blocks/runs to include
    arg.dirs struct = [] % Directory paths struct
    arg.save logical = false % Save outputs to disk
    arg.redo logical = false % Redo of previously-preprocessed subject
    arg.redoN logical = false
    arg.test logical = false
end
blocks=arg.blocks; dirs=arg.dirs;
% x=[]; n=[]; arg.save=0; arg.redo=1; arg.redoN=1; arg.test=1;

%% Options struct validation (non-exhaustive, see individual functions below)
if ~isstruct(dirs); dirs = ec_getDirs(dirs,sbj,proj); end
if ~exist('blocks','var') || isempty(blocks); blocks = BlockBySubj(sbj,proj); end
% % Filtering
% if ~isfield(o,'hiPass');        o.hiPass=0; end
% % Detrending
% if ~isfield(o,'detrendOrder');  o.detrendOrder=[]; end % Detrend polynomial order (suggested=10, skip=0)
% if ~isfield(o,'detrendWin');    o.detrendWin=[]; end   % Detrend timewindow in seconds (all timepoints=[])
% % Bad channel identification
% if ~isfield(o,'doBadCh');       o.doBadCh=true; end    % true/false
% if ~isfield(o,'badChProp');     o.badChProp=0.5; end   % Criterion proportion of bad samples [default: 0.5]
% if ~isfield(o,'thrHurst');      o.thrHurst=3; end      % Hurst threshold (median absolute deviation)
% % Rereferencing
% if ~isfield(o,'doRereference'); o.doRereference=true; end 
% if ~isfield(o,'rrThr');         o.rrThr=3; end         % Outlier threshold (default=3,skip=0)
% if ~isfield(o,'rrItr');         o.rrItr=5; end         % Number of iterations (default=5)
% % Electric line noise removal
% if ~isfield(o,'lineHz');        o.lineHz=60; end       % Electricity hertz @ EEG recording site (default=50|60, skip=0)
% % Detect epileptic high-frequency oscillations (HFO)
% if ~isfield(o,'thrHFO');        o.thrHFO=2; end        % Threshold for epileptic HFO detection (default=2)
% % Detect within-channel outlier timepoints
% if ~isfield(o,'doBadFrames');   o.doBadFrames=true; end  % true/false
% if ~isfield(o,'thrMAD');        o.thrMAD=10; end       % Z-threshold relative to all data points to exclude timepoints
% if ~isfield(o,'thrDiff');       o.thrDiff=10; end      % Z-threshold for amplitude differences of consecutive timepoints
% if ~isfield(o,'thrSNS');        o.thrSNS=3; end        % Threshold for low-freq spikes
% % % Interpolate bad channels
% % if ~isfield(o,'interpolateCh');    o.interpolateCh=false; end % true/false
% % % Detect outliers: spatiotemporal covariance (slow, often unecessary!)
% % if ~isfield(o,'doOLcov');          o.doOLcov=false; end       % true/false
% % if ~isfield(o,'OLcovThr');         o.OLcovThr=2; end          % Threshold for declaring an outlier
% % if ~isfield(o,'OLcovIter');        o.OLcovIter=2; end         % Number of iterations

%% Prep
tic;
% Load metadata
[errors,o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,o,n,dirs=dirs,save=arg.save,...
    redo=arg.redo,redoN=arg.redoN);

% Initialize variables/objects
fs = floor(n.fs);
ch_bad = chNfo.bad;
n.proj = proj;
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
try parpool('threads'); catch;end
try mkdir(o.dirOut); catch;end

%% Load EEG data
if isempty(x)
    [x,errors,chNan] = load_iEEG_LBCN(sbj,proj,blocks,dirs,errors); toc;
    ch_bad.nan(chNan) = true; 
end
if arg.test; xOg=x; end %#ok<NASGU> 
n.xChs = width(x);
n.xFrames = height(x);
n.dirs = dirs;

%% Classify bad EEG channels
if o.doBadCh
    % Find flat channels (1st order differential)
    x_diff = abs(diff(x,1,1));
    x_diff = mean(x_diff,1,"omitnan");
    ch_bad.("flat"+sfx) = isoutlier(x_diff,"quartiles","ThresholdFactor",20)';

    % Weird covariance channels
    x_cov = cov(x,'partialrows');
    x_cov(corrcov(x_cov)==1) = nan;
    x_cov = mean(x_cov,2,"omitnan");
    ch_bad.("cov"+sfx) = isoutlier(x_cov,"median",ThresholdFactor=10);

    % Classify
    [chClass,chNfo.dist] = ec_classifyBadChs(x,chNfo.pialRAS,chNfo.ch);
    ch_bad.("ai"+sfx) = chClass.bad;
    ch_bad.("xcorr"+sfx) = isoutlier(chClass.xcorr);
    ch_bad.("dev"+sfx) = isoutlier(chClass.dev);
    ch_bad.("grad"+sfx) = isoutlier(chClass.grad);

    % Hurst exponent
    idx = ~(ch_bad.empty|ch_bad.nan|chClass.bad|ch_bad.("flat"+sfx)|ch_bad.("cov"+sfx)|...
        ch_bad.("dev"+sfx)|ch_bad.("grad"+sfx));
    chHrst = abs(chClass.hurs - 0.5);
    [~,chHrst_lo,chHrst_hi] = isoutlier(chHrst(idx),"median","ThresholdFactor",o.thrHurst);
    ch_bad.("hurstL"+sfx) = chHrst < chHrst_lo;
    ch_bad.("hurstH"+sfx) = chHrst > chHrst_hi;

    % Copy
    ch_bad.("bad"+sfx) = ch_bad.empty|ch_bad.nan|ch_bad.("ai"+sfx)|...
        sum([ch_bad.("flat"+sfx),ch_bad.("cov"+sfx),ch_bad.("dev"+sfx),ch_bad.("grad"+sfx),...
        ch_bad.("hurstL"+sfx),ch_bad.("hurstH"+sfx)],2)>=3;
    ch_bad(:,string(chClass.Properties.VariableNames(3:end))+"P"+sfx) = chClass(:,3:end);
    chGood = ~ch_bad.("bad"+sfx);
    disp("Bad chans CLASSIFIER:"); disp(find(ch_bad.ai)');
    disp("Bad chans ALL:"); disp(find(ch_bad.bad)');
elseif any(ch_bad.Properties.VariableNames=="rr")
    chGood = ~ch_bad.rr;
    disp("Bad chans: ch_bad.rr "+sbj);
elseif any(ch_bad.Properties.VariableNames=="bad")
    chGood = ~ch_bad.bad;
    disp("Bad chans: ch_bad.bad "+sbj);
else
    chGood = true(n.xChs,1);
end

% Channels for ASR
if o.doBadCh
    chNoASR = ch_bad.empty|ch_bad.nan|ch_bad.("ai"+sfx)|...
        sum([ch_bad.("flat"+sfx),ch_bad.("cov"+sfx),ch_bad.("dev"+sfx),ch_bad.("grad"+sfx),...
        ch_bad.("hurstL"+sfx),ch_bad.("hurstH"+sfx)],2)>=5;
else
    chNoASR = ch_bad.empty|ch_bad.nan|ch_bad.ai|...
        sum([ch_bad.flat,ch_bad.cov,ch_bad.dev,ch_bad.grad,ch_bad.hurstL,ch_bad.hurstH],2)>=5;
end
ch_bad.("asr"+sfx) = chNoASR;
n.chNoASR = find(chNoASR);
disp("No ASR chans:"); disp(n.chNoASR');
toc;

%% Initial filter & detrend (within-run to avoid edge artifacts)
[x,n] = ec_detrendHPF(x,n,poly=o.detrendOrder,win=o.detrendWin,thr=o.detrendThr,...
    itr=o.detrendItr,missing=o.missingInterp,sfx=o.suffix);

%% Robust rereference
if o.doRereference
    [x,chGood] = ec_rereference(x,chGood',o.rrThr,o.rrItr,ch_bad.ref);
    chGood = chGood';
    ch_bad.("rr"+sfx) = ~chGood;
    n.refChs = find(chGood);
    disp("Finished robust referencing"); toc;
end

%% Final filter & detrend (within-run to avoid edge artifacts)
[x,n] = ec_detrendHPF(x,n,hpf=o.hiPass,poly=o.detrendOrder2,win=o.detrendWin2,...
    thr=o.detrendThr2,itr=o.detrendItr2,missing=o.missingInterp,sfx=o.suffix,gpu=o.hiPassGPU);

%% Power line noise removal
if o.lineHz > 0
    [x,~,n.lineNoise] = ec_zaplinePlus(x,fs,'noisefreqs',o.lineHz);
    disp([sbj ': finished power line noise removal']); toc;
end

%% Detect epileptic high-frequency oscillations (HFOs)
x_bad = table;
x_bad.sbjCh = chNfo.sbjCh;
x_bad.ch = chNfo.ch;
if o.thrHFO > 0
    [x_bad,ch_bad,n,errors] = hfo_lfn(x,x_bad,ch_bad,dirs,proj,n,o,errors); % Bipolar montage
end
chNfo.bad = ch_bad;

%% Artifact subspace reconstruction (ASR)
if o.asr.do
    disp("Starting ASR: chans="+nnz(~chNoASR)+" | rank="+ec_rank(x(:,~chNoASR)));
    o.asr.chIgnore = chNoASR;
    x = ASR_lfn(ec_exportEEGLAB(dirs,n,x,psy,trialNfo,chNfo),o.asr);
end
%vis_artifacts(ec_exportEEGLAB(dirs,n,x,psy,trialNfo,chNfo), ec_exportEEGLAB(dirs,n,xOg,psy,trialNfo,chNfo));

%% Identify bad frames per chan
if o.doBadFrames
    [ch_bad,x_bad] = ec_findBadFrames(x,ch_bad,x_bad,sfx,...
        mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS); 
    disp("Identified bad frames per chan: "+sbj);
end

%% Covariance/correlation outliers
x_cov = cov(x,'partialrows');
chCorr = corrcov(x_cov);
% Get channels with ultra-high covariance
chCovZ = abs(x_cov);
chCovZ(chCorr==1) = nan;
chCovZ = mean(chCovZ,2,"omitnan");
% Copy to permanent tables
ch_bad.("cov"+sfx) = isoutlier(chCovZ,"median","ThresholdFactor",10);
ch_bad.("covP"+sfx) = chCovZ;

%% Organize & save
sfx = erase(sfx,"_");
n.suffix = o.suffix;
n.badFrames = x_bad;
n.chCov = x_cov;
n.chVar = diag(n.chCov);
n.chCorr = chCorr;
n.("o"+sfx) = o;
chNfo.bad = ch_bad;

% Save
if arg.save
    % Save chNfo
    fn = o.dirOut+"chNfo_"+o.fnStr;
    save(fn,"chNfo","-v7"); disp("SAVED: "+fn)
    % Save n struct
    fn = o.dirOut+"n"+sfx+"_"+o.fnStr;
    save(fn,"n","-v7.3"); disp("SAVED: "+fn);
    % Save processed iEEG data
    fn = o.dirOut+"x"+sfx+"_"+o.fnStr;
    savefast(fn,'x'); disp("SAVED: "+fn);
end
toc;
end


%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Detect HFO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x_bad,ch_bad,n,errors] = hfo_lfn(x,x_bad,ch_bad,dirs,proj,n,o,errors)
sbj = n.sbj;
fs = n.fs;
nBlocks = n.nRuns;
blocks = n.blocks;
blockIdx = n.runIdx;
blockIdxOg = n.runIdxOg;

hfoIdx = cell(nBlocks,1);
hfoCh = cell(nBlocks,1);
for b = 1:length(blocks)
    % Load globalVar
    fn = sprintf('%s/orig/%s/global_%s_%s_%s.mat',dirs.data,sbj,proj,sbj,blocks{b});
    load(fn,'globalVar');
    idx = blockIdx(b,1):blockIdx(b,2);

    % Detect HFOs in bipolar iEEG montage
    hfoFin = false;
    try
        [hfoCh_b,hfoEvent] = ec_hfoDetect(x(idx,:),globalVar.channame,...
            globalVar.iEEG_rate,o.thrHFO);
        % Save to globalVar
        globalVar.pathological_event_bipolar_montage = hfoEvent;
        globalVar.badChan_specs.epileptic_hfo_spike = hfoCh_b;
        save(fn,'globalVar');
        hfoFin = true;
    catch ME; errors{end+1,1}=ME; getReport(ME) %#ok<AGROW>
    end

    % Get existing HFO info if exists
    if ~hfoFin && isfield(globalVar,'pathological_event_bipolar_montage')
        hfoEvent = globalVar.pathological_event_bipolar_montage;
        hfoCh_b = globalVar.badChan_specs.epileptic_hfo_spike;
        hfoFin = true;
    end

    % Get HFO indices
    if hfoFin
        hfoCh{b} = unique(hfoCh_b);
        [~, hfoIdx_b] = ec_hfoDetectIdx(hfoEvent.ts,hfoEvent.channel,globalVar.channame,...
            0,0,uint32(blockIdxOg(b,2)),fs);
        hfoIdx_b = vertcat(hfoIdx_b{:});
        hfoIdx{b} = hfoIdx_b(:,1:blockIdxOg(b,2));
    end
end

% Copy
try
    x_bad.hfo = horzcat(hfoIdx{:});
    ch_bad.hfo(:) = false;
    ch_bad.hfoP = sum(x_bad.hfo,2)/height(x);
    [~,~,thresh] = isoutlier(sum(x_bad.hfo,2),"quartiles","ThresholdFactor",10);
    ch_bad.hfo(ch_bad.hfoP>thresh) = true;
catch ME; errors{end+1,1}=ME; getReport(ME)
    n.hfoCh = hfoCh;
    n.hfoIdx = hfoIdx;
end
end


%% ASR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function EEG = ASR_lfn(EEG,oa)
arguments
    EEG struct
    oa struct
end
% EEG = ec_exportEEGLAB(dirs,n,x,psy,trialNfo,chNfo);

% Remove excluded channels
if oa.gpu; try reset(gpuDevice()); catch;end;end
chNoASR = oa.chIgnore;
if ~isempty(chNoASR) && any(chNoASR)
    EEGog = EEG;
    EEG = pop_select(EEG,'nochannel',cellstr(EEG.chNfo.sbjCh(chNoASR)));
    disp("Removing these chans for ASR: ");
    disp(EEG.chNfo.sbjCh(chNoASR));
end

% Run ASR
EEG = ec_ASR(EEG,oa.burst,oa.winLength,[],oa.maxDims,oa.burstMaxBadChs,oa.burstTols,...
    oa.refWinLength,oa.gpu,oa.reimann,oa.maxMem,oa.filtAmps);

% Copy cleaned channels to data matrix
if any(chNoASR)
    [~,ia,ib] = intersect({EEGog.chanlocs.labels},{EEG.chanlocs.labels},'stable');
    EEGog.data(ia,:) = EEG.data(ib,:);
    EEG = EEGog.data;
else
    EEG = EEG.data;
end
EEG = EEG';
if oa.gpu; try EEG=gather(EEG); reset(gpuDevice()); catch;end;end
end
