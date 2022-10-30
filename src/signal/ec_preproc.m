function [errors,n,x] = ec_preproc(sbj,proj,o,n,x,arg)
%% Robust preprocessing for intracranial/scalp electrophysiology
%  This function is part of electroCUDA (github.com/kevmtan/electroCUDA)
%  Call this function using its wrapper:
%                             ~/electroCUDA/1/pipeline/pre5_robustPreproc.m
%
% MAIN INPUTS:
%    sbj = subject name
%    proj = project name
%    o = struct of options & parameters (described below in "Options struct validation")
%    n = preloaded 'n' info output from ec_initialize or robustPreproc (OPTIONAL)
%    x = preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
%
% NAME-VALUE INPUTS:
%    see below sections: "Main input validation" & "Options struct validation"
%
% OUTPUTS:
%   x = Preprocessed EEG data indexed as: x(timeframe,channel)
%   n = Struct of preprocessing info & results
%
% ALGORITHM SEQUENCE:
%    power line denoise, detrend, detect bad channels, interpolate bad channels,
%    detect spatiotemporal outliers (channel covariance), robust rereferencing,
%    detect epileptic HFOs, detect noisy timepoints (within-channel)
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

arguments
    sbj % Subject name
    proj {mustBeText} = 'MMR' % Project name
    o struct = struct % preprocessing options struct (description below in "Options struct validation" ection)
    n struct = [] % preloaded 'n' info output from ec_initialize or robustPreproc (OPTIONAL)
    x {isfloat} = [] % preloaded EEG recordings: rows=frames, columns=channels (OPTIONAL)
    arg.blocks {mustBeText} = BlockBySubj(sbj,proj) % Task blocks/runs to include
    arg.dirs struct = [] % Directory paths struct
    arg.save logical = false % Save outputs to disk
    arg.redo logical = false % Redo of previously-preprocessed subject
    arg.redoN logical = false
    arg.test logical = false
end
blocks=arg.blocks; dirs=arg.dirs;
% x=[]; n=[]; arg.save=1; arg.redo=1; arg.redoN=1; arg.test=1;

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
[errors,o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,o,n,dirs=dirs,save=arg.save,redoN=arg.redoN);

% Initialize variables/objects
%sbjID = n.sbjID;
%nRuns = n.nRuns;
%runIdx = n.runIdx;
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
n.xChs = width(x);
n.xFrames = height(x);
n.dirs = dirs;

%% Classify bad EEG channels
chNoASR = [];
if o.doBadCh
    % Find flat channels
    x_diff = abs(diff(x,1,1));
    x_diff = mean(x_diff,1,"omitnan");
    ch_bad.("flat"+sfx) = isoutlier(x_diff,"quartiles","ThresholdFactor",100)';

    % Classify
    [chClass,chNfo.dist] = ec_classifyBadChs(x,chNfo.pialRAS,chNfo.ch);
    ch_bad.("ai"+sfx) = chClass.bad;

    % Hurst exponent
    chHrst = abs(chClass.hurs - 0.5);
    [~,chHrst_lo,~] = isoutlier(chHrst(~ch_bad.ref|~ch_bad.empty|~chClass.bad|...
        ~ch_bad.("flat"+sfx)),"median","ThresholdFactor",o.thrHurst);
    [~,~,chHrst_hi] = isoutlier(chHrst(~ch_bad.ref|~ch_bad.empty|~chClass.bad|...
        ~ch_bad.("flat"+sfx)),"median","ThresholdFactor",o.thrHurst+2);
    ch_bad.("hurstL"+sfx) = chHrst < chHrst_lo;
    ch_bad.("hurstH"+sfx) = chHrst > chHrst_hi;

    % Copy
    ch_bad.("bad"+sfx) = ch_bad.ref|ch_bad.empty|chClass.bad|ch_bad.("hurstL"+sfx)|...
        ch_bad.("hurstH"+sfx)|ch_bad.("flat"+sfx);
    chClass.Properties.VariableNames(3:end) =...
        string(chClass.Properties.VariableNames(3:end))+"P"+sfx;
    ch_bad(:,chClass.Properties.VariableNames(3:end)) = chClass(:,3:end);
    disp("Bad chans CLASSIFIER:"); disp(find(ch_bad.ai)');
    disp("Bad chans ALL:"); disp(find(ch_bad.bad)');

    % Channels for later
    chNoASR = ch_bad.empty|ch_bad.("ai"+sfx);
    chGood = ~ch_bad.("bad"+sfx);
elseif any(ch_bad.Properties.VariableNames=="rr")
    chGood = ~ch_bad.rr;
    disp("Bad chans: ch_bad.rr "+sbj);
elseif any(ch_bad.Properties.VariableNames=="bad")
    chGood = ~ch_bad.bad;
    disp("Bad chans: ch_bad.bad "+sbj);
else
    chGood = true(n.xChs,1);
end
% Make sure no ASR chans
if isempty(chNoASR)
    chNoASR = ch_bad.empty|ch_bad.ai;
end
toc;

%% Filter & detrend (within-run to avoid edge artifacts)
[x,n] = ec_hiPassDetrend(x,o.hiPass,o.detrendOrder,o.detrendWin,n,...
    thr=o.detrendThr,itr=o.detrendItr,missing=o.missingInterp,sfx=sfx,gpu=1);

%% Robust rereference
if o.doRereference
    [x,chGood] = ec_rereference(x,chGood',o.rrThr,o.rrItr,ch_bad.ref);
    chGood = chGood';
    ch_bad.("rr"+sfx) = ~chGood;
    n.refChs = find(chGood);
    disp("Finished robust referencing"); toc;
end

%% Power line noise removal
if o.lineHz > 0
    [x,~,n.lineNoise] = KT_zapline_plus(x,fs,'noisefreqs',o.lineHz);
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

%% Find flat channels
idx = find(contains(ch_bad.Properties.VariableNames,"hurstL"),1,"last");
x_diff = abs(diff(x,1,1));
x_diff = mean(x_diff,1,"omitnan");
ch_bad.("flat"+sfx) = isoutlier(x_diff,"median","ThresholdFactor",3)';
chNoASR = chNoASR |...
    sum(full([chNoASR,ch_bad.ref,ch_bad.hurstH,ch_bad{:,idx},ch_bad.("flat"+sfx)]),2)>2;

%% Artifact subspace reconstruction (ASR)
if o.asr.do
    o.asr.chIgnore = chNoASR;
    x = ASR_lfn(ec_exportEEGLAB(dirs,n,x,psy,trialNfo,chNfo),o.asr);
    %burst=20,chCorr='off',line='off',win='off',flat='off',hiPass='off',...
    ch_bad.("asr"+sfx) = chNoASR;
end

%% Identify bad frames per chan
if o.doBadFrames
    [ch_bad,x_bad] = ec_findBadFrames(x,ch_bad,x_bad,sfx,...
        mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS); 
    disp("Identified bad frames per chan: "+sbj);
end

%% Covariance/correlation outliers

% Get covariance/correlation of EEG channels
chCov = cov(x,'partialrows');
chCorr = corrcov(chCov);

% Get channels with ultra-high covariance
chCovZ = abs(chCov);
chCovZ(chCorr==1) = nan;
chCovZ = mean(chCovZ,2,"omitnan");
chCovOL = isoutlier(chCovZ,"median","ThresholdFactor",10);

% Copy to permanent tables
ch_bad.("cov"+sfx) = chCovOL;
ch_bad.("covP"+sfx) = chCovZ;
ch_bad = movevars(ch_bad,["cov" "covP"],"After","nan");

%% Organize & save
sfx = erase(sfx,"_");
n.suffix = o.suffix;
n.badFrames = x_bad;
n.chCov = cov(x,'partialrows');
n.chVar = diag(n.chCov);
n.chCorr = corrcov(n.chCov);
n.("o"+sfx) = o;
chNfo.bad = ch_bad;

% Save
if arg.save
    % Save n struct
    fn = o.dirOut+"n"+sfx+"_"+o.fnStr;
    save(fn,"n"); disp("SAVED: "+fn);
    % Save chNfo
    fn = o.dirOut+"chNfo_"+o.fnStr;
    save(fn,"chNfo","-v7"); disp("SAVED: "+fn)
    % Save processed iEEG data
    fn = o.dirOut+"x"+sfx+"_"+o.fnStr;
    save(fn,"x","-v7.3","-nocompression"); disp("SAVED: "+fn);
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
if oa.gpu; try reset(gpuDevice(1)); catch;end;end
chNoASR = oa.chIgnore;
if ~isempty(chNoASR) && any(chNoASR)
    EEGog = EEG;
    EEG = pop_select(EEG,'nochannel',cellstr(EEG.chNfo.sbjCh(chNoASR)));
    disp("Removing these chans for ASR: ");
    disp(EEG.chNfo.sbjCh(chNoASR));
end

% Run ASR
EEG = ec_ASRclean(EEG,oa.burst,[],[],[],oa.burstMaxBadChs,oa.burstTols,[],...
    oa.gpu,false,oa.maxMem);

% Copy cleaned channels to data matrix
if any(chNoASR)
    [~,ia,ib] = intersect({EEGog.chanlocs.labels},{EEG.chanlocs.labels},'stable');
    EEGog.data(ia,:) = EEG.data(ib,:);
    EEG = EEGog.data;
else
    EEG = EEG.data;
end
EEG = EEG';
if oa.gpu; try EEG=gather(EEG); reset(gpuDevice(1)); catch;end;end
end
