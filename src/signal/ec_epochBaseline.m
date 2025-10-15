function [x,trs] = ec_epochBaseline(x,n,psy,ep,tt,op)
% electroCUDA function for preprocessing, epoching & baseline correction
%   Kevin Tan (2025) | github.com/kevmtan/electroCUDA
%
% Inputs: see next section
%
% Outputs:
%   x = preprocessed neuronal data, 2D/3D matrix = [time,channel,freq]
%   trs = trial/epoch metadata per timepoint

%% Input validation
arguments
    x {mustBeFloat}                             % Neuronal data, 2D/3D matrix = [time,channel,freq]
    n struct                                    % Info struct
    psy timetable                               % Task metadata per timepoint
    ep table                                    % Epoch metadata per timepoint
    tt uint64 = tic                             % Timer
    op.gpu (1,1) logical = false                % Run on GPU? (note: CPU appears faster)
    op.typeProc (1,1) string = "double"         % processing FP precision ("double"|"single"|""=same as input)
    op.typeOut (1,1) string = class(x)          % output FP precision ("double"|"single"|""=same as input)
    op.hzTarg (1,1) double = nan                % Target sampling rate
    % Within-run preprocessing
    op.log (1,1) logical = false;               % Log transform
    op.runNorm string = "zscore";               % Normalize run
    % Within-trial preprocessing (baseline correction)
    %   Epoch baseline period (none=[], relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
    op.baselinePre {mustBeFloat} = []            % Pre-stimulus baseline (secs from stim onset); -.2sec until onset = [-.2]; -.2sec to 1sec = [-0.2 1]
    op.baselinePost {mustBeFloat} = []           % Post-stimulus baseline (secs from stim offset); .2sec after offset = .2; .1sec to .2sec after offsetx=[0.1 0.3]
    op.trialNorm {mustBeMember(op.trialNorm,["zscore" "robust"])} = "robust"; % Normalize trial
    op.trialNormDev {mustBeMember(op.trialNormDev,["baseline" "pre" "post" "on" "off" "all"])}...
        = "baseline"; % Timepoints for StdDev ["baseline"|"pre"|"post"|"on"|"off"|"all"] (default="baseline")
    op.trialBaseline {mustBeMember(op.trialBaseline,["mean" "median"])} = "median"; % Subtract trial by mean or median of baseline period (skip=[])
    % Bad frames/outliers
    op.interp {mustBeMember(op.interp,["nearest" "linear" "spline" "pchip" "makima"])}...
        = "linear";
    op.badFields {mustBeMember(op.badFields,["" "hfo" "mad" "diff" "sns"])} = "" % skip=""
    op.olCenter {mustBeMember(op.olCenter,["median" "mean"])} = "median"
    op.olThr (1,1) double = 5;                   % Threshold for outlier
    op.olThr2 (1,1) double = 0;                  % Threshold for outlier
    op.olThrBL (1,1) double = 3;                 % Threshold for in baseline period
    % PCA (skip=[])
    op.pca (1,1) double = 0;                     % Components to keep across channels
    op.pcaSpec (1,1) double = 0;                 % Spectral components to keep per channel
    % Filtering (within-run):
    op.hpf (1,1) double = 0;                     % HPF cutoff in hertz (skip=0)
    op.hpfSteep (1,1) double = 0.75;              % HPF steepness
    op.hpfImpulse {mustBeMember(op.hpfImpulse,["auto" "fir" "iir"])} = "iir"; % HPF impulse: ["auto"|"fir"|"iir"]
    op.lpf (1,1) double = 0;                     % LPF cutoff in hz (skip=0)
    op.lpfSteep = 0.75;                           % LPF steepness
    op.lpfImpulse {mustBeMember(op.lpfImpulse,["auto" "fir" "iir"])} = "auto"; % LPF impulse: ["auto"|"fir"|"iir"]
end

% Conditional validation
if ~isany(op.typeProc); op.typeProc = class(x); end
if ~isany(op.typeOut); op.typeOut = class(x); end
op.fs2 = double(op.lpf*n.hz);
sbj = n.sbj;


%% Prep
epIdx = ep.idx; % Epoch indices

% Peristimulus indices 
stim = psy.stim;
stim = mat2cell(stim,n.runIdxOg); % split per run

% Trial Indices
trs = groupcounts(ep,["run" "tr"]);
trs.i = cell(n.nTrials,1);
for t = 1:n.nTrials
    trs.i{t} = sparse(ep.tr==trs.tr(t)); end

% Trial baseline indices
trs.baseline = cell(height(trs),1);
for t = 1:n.nTrials
    trs.baseline{t} = sparse(ep.BLpre(trs.i{t})|ep.BLpost(trs.i{t})); end

% Trial stimulus indices
trs.pre = cellfun(@(t) sparse(logical(ep.pre(t,:))), trs.i,UniformOutput=false); % Reshape by epoch
trs.post = cellfun(@(t) sparse(logical(ep.post(t,:))), trs.i,UniformOutput=false); 
trs.stim = cellfun(@(t) sparse(logical(ep.stim(t,:))), trs.i,UniformOutput=false); 

% Convert 'half' vars to 'single' for parallel threads
if isa(x,"half")
    x = single(x); end
idx = varfun(@(v) isa(v,"half"),psy,OutputFormat="uniform");
psy = convertvars(psy,idx,"single");

% Get downsampling factor & anti-aliasing filter
if isany(op.hzTarg)
    [ds(1),ds(2)] = rat(op.hzTarg/n.hz);
    % Errors
    if ds(1) > ds(2)
        error("[ec_epochBaseline] downsampling target > sampling rate"); end
    if ds(1) ~= 1
        error("[ec_epochBaseline] downsampling target must be wholly divisible by sampling rate"); end
    ds = ds(2);
    disp("[ec_epochBaseline] downsampling factor = "+ds);
else
    ds = 1;
end

% Filter prep
if isany(op.hpf) || isany(op.lpf)
    % Get single-channel/freq timeseries from longest run
    [~,idx] = min(n.runIdxOg);
    xTmp = x(psy.run==n.runs(idx),1,1);
    xTmp = cast(xTmp,op.typeProc);
    if op.gpu; xTmp = gpuArray(xTmp); end

    % Make filter(s)
    if isany(op.hpf)
        hpf = ec_designFilt(xTmp,n.hz,op.hpf,"highpass",...
            steepness=op.hpfSteep,impulse=op.hpfImpulse,coefOut=true);
    end
    if isany(op.lpf)
        lpf = ec_designFilt(xTmp,n.hz,op.lpf,"lowpass",...
            steepness=op.lpfSteep,impulse=op.lpfImpulse,coefOut=true);
    end
    clear xTmp
else
    hpf=[]; lpf=[];
end

% Remove bad frames
if isany(op.badFields)
    for f = 1:numel(op.badFields)
        % Get bad timepoints for specific metric
        try
            xBad = n.xBad.(op.badFields(f));
        catch
            continue
        end

        s1=numel(size(x)); s2=numel(size(xBad));
        if s1==s2
            x(xBad) = nan;
        elseif s2==2
            xBad = repmat(full(xBad),[1 1 size(x,3)]);
            x(xBad) = nan;
        elseif s2==1
            xBad = repmat(full(xBad),[1 size(x,2) size(x,3)]);
            x(xBad) = nan;
        end
    end
    disp("Removed bad frames: "+sbj);
end

% Transform to cell by channel
x = ec_dim2cell(x,2);
disp("[ec_epochBaseline] Prepared data & filters: "+n.sbj+" time="+toc(tt));


%% Main processing (loop across channels)
if op.gpu
    % Run on GPU (devs: gpuArray table fields?)
    for c = 1:numel(x)
        x{c} = withinCh_lfn(x{c},n,stim,epIdx,trs,hpf,lpf,ds,op);
    end
else
    % Run on CPU parallel loop (ideally threadpool, initialize before running)
    parfor c = 1:numel(x)
        x{c} = withinCh_lfn(x{c},n,stim,epIdx,trs,hpf,lpf,ds,op);
    end
end


%% Finalize
x = cellfun(@(y) permute(y,[1 3 2]),x,'UniformOutput',false);
x = horzcat(x{:});
disp("[ec_epochBaseline] Finished: "+n.sbj+" time="+toc(tt));




%%%%%%%%%%%%%%%%%%%%%%%%%% subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function xc = withinCh_lfn(xc,n,stim,epIdx,trs,hpf,lpf,ds,op)
%% Compute within-chan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xc=x{104};

% Process at specified float precision
xc = cast(xc,op.typeProc);

% Move to GPU
if op.gpu
    xc = gpuArray(xc); end

% Reshape per run
xc = mat2cell(xc,n.runIdxOg);

% Processing within-run (HPF, norm, outliers, PCA, LPF)
for r = 1:n.nRuns
    xc{r} = withinRun_lfn(xc{r},stim{r},hpf,lpf,ds,op);
end
xc = vertcat(xc{:});

% Epoch EEG
xc = xc(epIdx,:); % Match epoched indices
xc = cellfun(@(tr) xc(tr,:), trs.i,UniformOutput=false); % Reshape by epoch

% Baseline correct within-trial (robust z-score)
for t = 1:numel(xc)
    xc{t} = withinTrial_lfn(xc{t},trs(t,:),op);
end
xc = vertcat(xc{:});

% Get from GPU
if op.gpu
    xc = gather(xc); end

% Output at specified float precision
xc = cast(xc,op.typeOut);



function xr = withinRun_lfn(xr,stimR,hpf,lpf,ds,op)
%% Compute within-run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Log transform
if op.log
    xr = log(xr); end

% All outliers
if any(op.olThr)
    xr = filloutliers(xr,nan,op.olCenter,1,ThresholdFactor=op.olThr); end

% Interpolate outliers/missing (slower on GPU)
xr = fillmissing(xr,"linear",1,EndValues="nearest");

% High-pass filter
if ~isempty(hpf)
    xr = ec_filtfilt(xr,hpf); end

% All outliers (2nd round)
if any(op.olThr2)
    xr = filloutliers(xr,nan,op.olCenter,1,ThresholdFactor=op.olThr2); end

% Baseline outliers
if any(op.olThrBL)
    xr(~stimR,:) = filloutliers(xr(~stimR,:),nan,op.olCenter,1,ThresholdFactor=op.olThrBL); end

% Interpolate outliers/missing (slower on GPU)
xr = fillmissing(xr,"linear",1,EndValues="nearest");

% Low-pass filter
if ~isempty(lpf)
    xr = ec_filtfilt(xr,lpf); end

% PCA (use ec_robustPCA??)
if op.pcaSpec
    [~,xr] = pca(xr,NumComponents=op.pcaSpec,Economy=false); end

% Normalize (z-score)
if op.runNorm=="robust"
    xr = normalize(xr,1,"zscore","robust");
elseif isany(op.runNorm)
    xr = normalize(xr,1,op.runNorm);
end

% Downsample
if ds > 1
    xr = xr(1:ds:end,:); end



function xt = withinTrial_lfn(xt,tr,op)
%% withinTrial_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Timepoints for std deviation calculation
if op.trialNormDev=="baseline" && any(tr.baseline{1})
    iSD = tr.baseline{1};
elseif op.trialNormDev == "pre"
    iSD = tr.pre{1};
elseif op.trialNormDev == "post"
    iSD = tr.post{1};
elseif op.trialNormDev == "on"
    iSD = tr.stim{1};
elseif op.trialNormDev == "off"
    iSD = ~tr.stim{1};
elseif op.trialNormDev == "all"
    iSD = true(height(xt),1);
else
    iSD = logical(tr.pre);
end

% Timepoints for baseline subtraction
if any(tr.baseline{1})
    iBL = tr.baseline{1};
else
    iBL = iSD;
end

% Get trial baseline
if op.trialBaseline=="median"
    bl = median(xt(iBL,:),1,"omitnan"); % BL median
elseif op.trialBaseline=="mean"
    bl = mean(xt(iBL,:),1,"omitnan"); % BL median
end

% Get trial std deviation
if op.trialNorm=="robust"
    sd = mad(xt(iSD,:),1,1); % BL MAD median absolute deviation
elseif op.trialNorm=="zscore"
    sd = std(xt(iSD,:),1,1,"omitnan");
end

% Do baseline correction
xt = (xt-bl)./sd;



% function xc = acrossTrials_lfn(xc,trs,op)
% %% acrossTrials_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Reshape by trial
% xc = arrayfun(@(tr) xc(tr.i,:), trs,UniformOutput=false);
% 
% % Baseline correct within-trial (robust z-score)
% for t = 1:numel(xc)
%     if any(trs(t).baseline)
%         xc{t} = withinTrial_lfn(xc{t},trs(t).baseline,op); end
% end
% xc = vertcat(xc{:});
% 
% 
% 
% function xc = withinCh_lfn(xc,rr,idr,stim,fs2,hpf,lpf,op)
% %% Compute within chan/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xc = squeeze(xc);
%
% % Log transform
% if op.log
%     xc = arrayfun(@log,xc); end
%
% % Outliers, HPF, z-score (within-run)
% for r = rr
%     id = idr(:,r);
%     xc(id,:) = withinChRun_lfn(xc(id,:),~stim(id),fs2,hpf,op);
% end
%
% % PCA (use ec_robustPCA??)
% if op.pcaSpec
%     [~,xc] = pca(xc,NumComponents=op.pcaSpec,Economy=false); end
%
% % LPF (within-run) [after PCA]
% if ~isempty(lpf)
%     for r = rr
%         xc(idr(:,r),:) = ec_filtfilt(xc(idr(:,r),:),lpf); end
% end
%
% % Finalize
% xc = permute(xc,[1 3 2]);
%
%
%
% function xr = withinChRun_lfn(xr,idb,fs2,hpf,op)
% %% Compute within run per chan/IC  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% % Baseline outliers
% if any(op.olThrBL)
%     xr(idb,:) = filloutliers(xr(idb,:),nan(1,like=xr),op.olCenter,1,ThresholdFactor=op.olThrBL); end
%
% % Peri-stimulus outliers
% if any(op.olThr)
%     xr = filloutliers(xr,nan(1,like=xr),op.olCenter,1,ThresholdFactor=op.olThr); end
%
% % Interpolate outliers/missing (slower on GPU)
% xr = fillmissing_lfn(xr,fs2);
%
% % High-pass filter
% if ~isempty(hpf)
%     xr = ec_filtfilt(xr,hpf); end
%
% % Redo outliers
% if any(op.olThr2)
%     xr = filloutliers(xr,nan,op.olCenter,1,ThresholdFactor=op.olThr2);
%     xr = fillmissing_lfn(xr,fs2);
% end
%
% % Normalize (z-score)
% if op.runNorm=="robust"
%     xr = normalize(xr,1,"zscore","robust");
% elseif isany(op.runNorm)
%     xr = normalize(xr,1,op.runNorm);
% end