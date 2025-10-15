function [errors,n,x] = ec_preproc_iEEG(sbj,proj,task,o,n,x,arg)
%% electroCUDA - initial robust preprocessing steps for intracranial EEG
% See these functions for later-stage preprocessing steps:
%     - ec_preprocICA (source separation & denoising via ICA)
%     - ec_preprocTimeFreq (time-frequency decomposition via wavelets)
%
% SEE WIKI FOR MORE INFO: github.com/kevmtan/electroCUDA/wiki
%
% INPUTS:
%    sbj = subject name
%    task = project name
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

    % Name-value inputs
    arg.blocks {istext,isnumeric} = BlockBySubj(sbj,task) % Task blocks/runs to include
    arg.dirs struct = [] % Directory paths struct
    arg.save logical = true % Save outputs to disk
    arg.redo logical = false % Redo of previously-preprocessed subject
    arg.redoN logical = false
    arg.test logical = false
end
blocks=arg.blocks; dirs=arg.dirs;
% x=[]; n=[]; arg.save=0; arg.redo=0; arg.redoN=1; arg.test=1; dirs=[]; blocks=[];


%% Options struct validation (non-exhaustive, see individual functions below)
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
% if ~isfield(o,'thrSNS');        o.thrSNS=3; end        % Threshold for low-freq spikes; Sensor-specific noise thresh (try 5)
% % % Interpolate bad channels
% % if ~isfield(o,'interpolateCh');    o.interpolateCh=false; end % true/false
% % % Detect outliers: spatiotemporal covariance (slow, often unecessary!)
% % if ~isfield(o,'doOLcov');          o.doOLcov=false; end       % true/false
% % if ~isfield(o,'OLcovThr');         o.OLcovThr=2; end          % Threshold for declaring an outlier
% % if ~isfield(o,'OLcovIter');        o.OLcovIter=2; end         % Number of iterations


%% Prep
tt = tic;
if ~isstruct(dirs)||isempty(dirs); dirs = ec_getDirs(proj,task,sbj); end
if ~isany(blocks) && ~isfield(n,"blocks"); blocks = string(BlockBySubj(sbj,task)); end

% Initialize/load metadata
[errors,o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,task,o,n,dirs=dirs,save=arg.save,...
    redo=arg.redo,redoN=arg.redoN); % Load metadata

% Initialize variables/objects
hz = n.hz;
ch_bad = chNfo.bad;
if o.suffix==""; sfx=""; else; sfx="_"+o.suffix; end
%try parpool('threads'); catch;end

% Reset GPU & get free VRAM
if ismember(o.gpu,["matlab" "cuda"])
	try reset(gpuDevice()); catch; end
    memMax = ec_ramAvail(true);
else
    try parpool('threads'); catch;end
    memMax = ec_ramAvail;
end


%% Load EEG data
if isempty(x)
    if dirs.proj=="lbcn"
        [x,errors,chNan] = load_iEEG_LBCN(sbj,task,blocks,dirs,errors);
    else
        [x,errors,chNan] = ec_loadOrig(sbj,task,blocks,dirs,errors);
    end
    ch_bad.nan(chNan) = true;
    toc(tt);
end
if arg.test; xOg=x; else; xOg=[]; end %#ok<*NASGU>
n.xChs = width(x);
n.xFrames = height(x);
n.dirs = dirs;


%% Fill missing
if isany(o.missingInterp)
    for ir = 1:n.nRuns
        rIdx = n.runIdx(ir,1):n.runIdx(ir,2); % Run indices
        if any(ismissing(x(rIdx,:)),"all")
            x(rIdx,:) = fillmissing(x(rIdx,:),"knn",25);
            disp("Interpolated missing: "+runs(ir)+" time="+toc(o.tic));
        end
    end
end


%% Classify bad EEG channels
if o.doBadCh
    [n,ch_bad] = badFrame_lfn(x,n,o,chNfo,ch_bad,sfx);
    sfx1 = sfx;
    chGood = ~ch_bad.("bad"+sfx);
elseif any(ch_bad.Properties.VariableNames=="rr")
    chGood=~ch_bad.rr; sfx1="";
    disp("Bad chans: ch_bad.rr "+sbj);
elseif any(ch_bad.Properties.VariableNames=="bad")
    chGood=~ch_bad.bad; sfx1="";
    disp("Bad chans: ch_bad.bad "+sbj);
else
    chGood = true(n.xChs,1); sfx1=[];
end
toc(tt);


%% Robust detrend (pre-reference)
if nnz(o.detrendOrder)
    [x,n] = ec_detrend(x,n,order=o.detrendOrder,thr=o.detrendThr,itr=o.detrendItr,...
        win=o.detrendWin,gpu=o.detrendGPU,single=o.detrendSingle,...
        tic=tic); %tic=tt;
    if arg.test; x_detr=x; end
else
    n.xBad.detrend = sparse(false(size(x)));
end

% Get detrend outlier chans
chDetr = sum(full(n.xBad.detrend),"omitnan");
[~,~,thr] = isoutlier(chDetr,"quartiles");
ch_bad.("detrend"+sfx) = chDetr' > thr;
ch_bad.("detrendP"+sfx) = chDetr';
% vis_artifacts(ec_exportEEGLAB(n,x_detr,psy,trialNfo,chNfo), ec_exportEEGLAB(n,xOg,psy,trialNfo,chNfo));


%% HPF
if isany(o.hiPass) % HPF within-run to avoid edge artifacts
    [x,n] = ec_HPF(x,n,o.hiPass,tt,steepness=o.hiPassSteep);
    if arg.test; x_hpf=x; end
end
% vis_artifacts(ec_exportEEGLAB(n,x_hpf,psy,trialNfo,chNfo), ec_exportEEGLAB(n,x_detr,psy,trialNfo,chNfo));


%% Power line noise removal (cleanline)
% if any(o.lineHz)
%     [x,n.cleanline] = ec_cleanline(ec_exportEEGLAB(n,x,psy,trialNfo,chNfo),...
%         'LineFrequencies',o.lineHz,'SlidingWinLength',3,'p',0.01,'iter',10,...
%         'SlidingWinStep',1.5,'Bandwidth',1,'VerboseOutput',1);
%     disp("[ec_preproc] Finished cleanline: "+sbj+" time="+toc(tt));
%     if arg.test; x_line=x; end
% end
% % vis_artifacts(ec_exportEEGLAB(n,x_line,psy,trialNfo,chNfo), ec_exportEEGLAB(n,x_hpf,psy,trialNfo,chNfo));


%% Robust rereference
if o.doRereference
    % Figure out chans to include for average reference
    if isany(o.hiPass)
        [ch_bad,n.xBad] = ec_findBadFrames(x,ch_bad,n.xBad,sfx,n.xBad.detrend,...
            mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);
    end

    % Save for robust reference chans
    if ~isempty(sfx1)
        ch_bad.("bad"+sfx) = ch_bad.empty|ch_bad.nan|ch_bad.("ai"+sfx1)|...
            sum([ch_bad.("mad"+sfx),ch_bad.("diff"+sfx),ch_bad.("flat"+sfx),ch_bad.("sns"+sfx)*2,...
            ch_bad.("cov"+sfx1),ch_bad.("dev"+sfx1)*2,ch_bad.("grad"+sfx1),...
            ch_bad.("hurstL"+sfx1),ch_bad.("hurstH"+sfx1),ch_bad.("detrend"+sfx1)],2)>=3;
        chGood = ~ch_bad.("bad"+sfx);
        disp("Bad chans ALL:"); disp(find(ch_bad.bad)');
    else
        chGood = chGood && sum([ch_bad.("mad"+sfx),ch_bad.("diff"+sfx),ch_bad.("flat"+sfx),...
            ch_bad.("sns"+sfx)*2,ch_bad.("detrend"+sfx)],2)<=3;
    end

    % Run rereference
    [x,chGood] = ec_rereference(x,chGood',ch_bad.ref,thresh=o.rrThr,iters=o.rrItr); % rank correct previous referencing
    chGood=chGood'; ch_bad.("rr"+sfx)=~chGood; n.refChs=find(chGood);
    disp("[ec_preproc] Finished robust referencing: "+sbj+" time="+toc(tt));
    if arg.test; x_rr=x; end
end
% vis_artifacts(ec_exportEEGLAB(n,x_rr,psy,trialNfo,chNfo), ec_exportEEGLAB(n,x_hpf,psy,trialNfo,chNfo));


%% Robust detrend (post-reference)
if nnz(o.detrendOrder2) % Detrend
    [x,n] = ec_detrend(x,n,order=o.detrendOrder2,thr=o.detrendThr2,itr=o.detrendItr2,...
        win=o.detrendWin2,missing=o.missingInterp,gpu=o.detrendGPU,single=o.detrendSingle,...
        tic=tic);
    if arg.test; x_detr2=x; end

    % Get detrend outlier chans
    chDetr = sum(full(n.xBad.detrend),"omitnan");
    [~,~,thr] = isoutlier(chDetr,"quartiles");
    ch_bad.("detrend"+sfx) = chDetr' > thr;
    ch_bad.("detrendP"+sfx) = chDetr';
end
% vis_artifacts(ec_exportEEGLAB(n,x_detr2,psy,trialNfo,chNfo), ec_exportEEGLAB(n,x_rr,psy,trialNfo,chNfo));


%% Power line noise removal (zapline)
if o.lineHz > 0
    % Zapline
    [x,~,n.zapline] = ec_zaplinePlus(x,hz,'noisefreqs',o.lineHz);
    %[x,~,n.zapline] = ec_zaplinePlus(x,hz,'noisefreqs',o.lineHz,'detectionWinsize',4,...
    %    'noiseCompDetectSigma',3.5,'minsigma',3);
    disp("[ec_preproc] Finished zapline power line noise removal: sbj="+...
        sbj+" time="+toc(tt));
    if arg.test; x_zap=x; end
end
% vis_artifacts(ec_exportEEGLAB(n,x_zap,psy,trialNfo,chNfo), ec_exportEEGLAB(n,x_rr,psy,trialNfo,chNfo));


%% Detect epileptic high-frequency oscillations (HFO)
if o.thrHFO > 0
    [n,ch_bad,errors] = hfo_lfn(x,n,o,dirs,task,ch_bad,errors);
end
chNfo.bad = ch_bad;


%% Save pre-ASR data
if arg.save && sfx==""
    % Save n struct
    n.suffix = "z";
    fn = o.dirOut+"nz_"+o.fnStr;
    save(fn,"n","-v7"); disp("SAVED: "+fn);
    n.suffix = sfx;
    % Save processed iEEG data
    fn = o.dirOut+"xz_"+o.fnStr+".mat";
    savefast(fn,'x'); disp("SAVED: "+fn);
end


%% Artifact Subspace Reconstruction (ASR)
if o.asr.do
    [x,n,o,ch_bad] = asr_lfn(x,n,o,psy,trialNfo,chNfo,ch_bad,sfx,sfx1,tt);
    if arg.test; x_asr=x; end
end
% vis_artifacts(ec_exportEEGLAB(n,x_asr,psy,trialNfo,chNfo), ec_exportEEGLAB(n,x_zap,psy,trialNfo,chNfo));


%% Identify bad frames per chan
if o.doBadFrames
    [ch_bad,n.xBad] = ec_findBadFrames(x,ch_bad,n.xBad,sfx,n.xBad.detrend,...
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

%% Final bad chans

% Covariance/correlation outliers
x_cov = cov(x,'partialrows');
chCorr = corrcov(x_cov);
% Get channels with ultra-high covariance
chCovZ = abs(x_cov);
chCovZ(chCorr==1) = nan;
chCovZ = mean(chCovZ,2,"omitnan");
% Copy to permanent tables
ch_bad.("cov"+sfx) = isoutlier(chCovZ,"median","ThresholdFactor",10);
ch_bad.("covP"+sfx) = chCovZ;

% Calculate bad chans
if ~isempty(sfx1)
    ch_bad.("bad"+sfx) = ch_bad.empty | ch_bad.nan | ch_bad.("ai"+sfx1) | sum([ch_bad.ref,...
        ch_bad.("mad"+sfx),ch_bad.("diff"+sfx),ch_bad.("flat"+sfx),ch_bad.("sns"+sfx)*2,...
        ch_bad.("cov"+sfx1),ch_bad.("dev"+sfx1)*2,ch_bad.("grad"+sfx1),...
        ch_bad.("hurstL"+sfx1),ch_bad.("hurstH"+sfx1),ch_bad.("detrend"+sfx)],2)>=4;
end

%% Organize & save
sfx = erase(sfx,"_");
n.suffix = o.suffix;
n.chBad = ch_bad;
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
    save(fn,"n","-v7"); disp("SAVED: "+fn);
    % Save processed iEEG data
    fn = o.dirOut+"x"+sfx+"_"+o.fnStr+".mat";
    savefast(fn,'x'); disp("SAVED: "+fn);
end
try reset(gpuDevice()); catch;end
toc(tt);

% %% Artifact subspace reconstruction (ASR) - all chans
% if o.asr.do
%     [x,n] = ec_ASR(o.asr,n,x,psy,trialNfo,chNfo);
%     disp("ASR all-chans: chans="+n.nChs+" | rank="+ec_rank(x)+" | time="+toc(tt));
%     if arg.test; x_asr=x; end
% end
% % vis_artifacts(ec_exportEEGLAB(n,x_asr,psy,trialNfo,chNfo), ec_exportEEGLAB(n,x_rr,psy,trialNfo,chNfo));




%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function [n,ch_bad] = badFrame_lfn(x,n,o,chNfo,ch_bad,sfx)
%% Find bad frames %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[ch_bad,n.xBad] = ec_findBadFrames(x,ch_bad,...
    mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);
disp("Identified bad frames per chan: "+n.sbj);

% Weird covariance channels
x_cov = cov(x,'partialrows');
x_cov(corrcov(x_cov)==1) = nan;
x_cov = mean(x_cov,2,"omitnan");
ch_bad.("cov"+sfx) = isoutlier(x_cov,"median",ThresholdFactor=10);

% Classify
[chClass,n.chDist] = ec_classifyBadChs(x,chNfo.pialRAS,chNfo.ch);
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

% Final
disp("Bad chans CLASSIFIER:"); disp(find(ch_bad.ai)');
disp("Bad chans ALL:"); disp(find(ch_bad.bad)');




function [n,ch_bad,errors] = hfo_lfn(x,n,o,dirs,task,ch_bad,errors)
%% Detect HFO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sbj = n.sbj;
hz = n.hz;
nBlocks = n.nRuns;
blocks = n.blocks;
blockIdx = n.runIdx;
blockIdxOg = n.runIdxOg;

hfoIdx = cell(nBlocks,1);
hfoCh = cell(nBlocks,1);
for b = 1:length(blocks)
    % Load globalVar
    fn = sprintf('%s/orig/%s/global_%s_%s_%s.mat',dirs.data,sbj,task,sbj,blocks{b});
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
        [~,hfoIdx_b] = ec_hfoDetectIdx(hfoEvent.ts,hfoEvent.channel,globalVar.channame,...
            0,0,uint32(blockIdxOg(b,2)),hz);
        hfoIdx_b = vertcat(hfoIdx_b{:});
        hfoIdx{b} = hfoIdx_b(:,1:blockIdxOg(b,2));
    end
end

% Copy
try
    hfoIdx = horzcat(hfoIdx{:})';
    ch_bad.hfo(:) = false;
    ch_bad.hfoP = (sum(hfoIdx)/height(x))';
    [~,~,thresh] = isoutlier(ch_bad.hfoP,"quartiles");
    ch_bad.hfo(ch_bad.hfoP>thresh) = true;
    n.xBad.hfo = sparse(hfoIdx);
catch ME; errors{end+1,1}=ME; getReport(ME)
    n.hfoCh = hfoCh;
    n.hfoIdx = hfoIdx;
end




function [x,n,o,ch_bad] = asr_lfn(x,n,o,psy,trialNfo,chNfo,ch_bad,sfx,sfx1,tt)
%% ASR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Decide chans to exclude
[ch_bad,n.xBad] = ec_findBadFrames(x,ch_bad,n.xBad,sfx,n.xBad.detrend,...
    mad=o.thrMAD,diff=o.thrDiff,sns=o.thrSNS);

chNoASR = ch_bad.empty | ch_bad.nan | sum([ch_bad.("ai"+sfx1),...
    ch_bad.("mad"+sfx),ch_bad.("diff"+sfx),ch_bad.("flat"+sfx),ch_bad.("sns"+sfx)*2,...
    ch_bad.("cov"+sfx1),ch_bad.("dev"+sfx1)*2,ch_bad.("grad"+sfx1),...
    ch_bad.("hurstL"+sfx1),ch_bad.("hurstH"+sfx1),ch_bad.("detrend"+sfx1)],2)>=6;
ch_bad.("asr"+sfx)=chNoASR; n.chNoASR=find(chNoASR); o.asr.chIgnore=chNoASR; % save to asr options struct


% Save for comparison in determining if ASR too strong
x1 = x;
asr_reps = 0;

% Run ASR
while 1
    [x,n] = ec_ASR(o.asr,n,x,psy,trialNfo,chNfo);
    pctDiff = nnz(abs(x-x1) > eps(1e10)) / numel(x);

    % Redo with more conservative params if ASR too strong
    if pctDiff > o.asr.maxPctDiff && o.asr.refBurst < 100
        x = x1;
        pctDiff1 = pctDiff - o.asr.maxPctDiff;
        if pctDiff1 < 0.1
            o.asr.refBurst = o.asr.refBurst+5;
        elseif pctDiff1 < 0.2
            o.asr.refBurst = o.asr.refBurst+15;
        elseif pctDiff1 < 0.4
            o.asr.refBurst = o.asr.refBurst+20;
        else
            o.asr.refBurst = o.asr.refBurst+25;
        end
        if o.asr.refBurst > 100
            o.asr.refBurst = 100;
        end

        asr_reps = asr_reps+1;
        disp("[ec_prepoc] ASR TOO STRONG!!! pctDiff="+pctDiff+...
            " | increasing refBurst="+o.asr.refBurst+" | time="+toc(tt));
    else
        break;
    end
end

disp("Finished ASR: chans="+nnz(~chNoASR)+" | rank="+ec_rank(x(:,~chNoASR))+...
    " | pctDiff="+pctDiff+" | time="+toc(tt));