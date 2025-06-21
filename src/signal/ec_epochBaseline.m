function [x,trs] = ec_epochBaseline(x,n,psy,ep,tt,op)
% Input validation
arguments
    x {mustBeFloat}
    n struct
    psy timetable
    ep table
    tt uint64 = tic
    op.gpu (1,1) logical = false
    op.double (1,1) logical = true
    op.singleOut (1,1) logical = false
    op.hzTarg (1,1) double = nan
    % Within-run preprocessing
    op.log (1,1) logical = false;               % Log transform
    op.runNorm string = "zscore";               % Normalize run
    % Within-trial preprocessing (baseline correction)
    %   Epoch baseline period (none=[], relative on stim onset/onset=[latency], freeform range=[latency1,latency2]):
    op.baselinePre {mustBeFloat} = [] % Pre-stimulus baseline (secs from stim onset); -.2sec until onset = [-.2]; -.2sec to 1sec = [-0.2 1]
    op.baselinePost {mustBeFloat} = [] % Post-stimulus baseline (secs from stim offset); .2sec after offset = .2; .1sec to .2sec after offsetx=[0.1 0.3]
    op.trialNorm string = "robust";             % Normalize trial
    op.trialNormByBaseline (1,1) logical = true;       % Divide trial by baseline norm
    op.trialBaseline string = "median";         % Subtract trial by mean or median of baseline period (skip=[])
    % Bad frames/outliers
    op.interp {mustBeMember(op.interp,["nearest" "linear" "spline" "pchip" "makima"])}...
        = "linear";
    op.badFields {mustBeMember(op.badFields,["" "hfo" "mad" "diff" "sns"])} = "" % skip=""
    op.olCenter {mustBeMember(op.olCenter,["median" "mean"])} = "median"
    op.olThr (1,1) double = 5;           % Threshold for outlier
    op.olThr2 (1,1) double = 0;           % Threshold for outlier
    op.olThrBL (1,1) double = 3;
    % PCA (skip=[])
    op.pca (1,1) double = 0;             % Components to keep across channels
    op.pcaSpec (1,1) double = 0;         % Spectral components to keep per channel
    % Filtering (within-run):
    op.hpf (1,1) double = 0.1;           % Hi-pass cutoff in hertz (skip=0)
    op.hpfSteep (1,1) double = 0.5;
    op.hpfImpulse {mustBeMember(op.hpfImpulse,["auto" "fir" "iir"])} = "iir";
    op.lpf (1,1) double = 0;                         % lo-pass in hz (skip=0)
    op.lpfSteep = 0.5;
    op.lpfImpulse {mustBeMember(op.lpfImpulse,["auto" "fir" "iir"])} = "auto";
end
if op.double; x=double(x); end
op.fs2 = double(op.lpf*n.hz);
sbj = n.sbj;
% blThr = op.thrOLbl;
% runIdx = n.runIdxOg(:,2);
% if op.hzTarg; ds=op.hzTarg/fs; else; ds=[]; end
% runs = n.runs';
% nRuns = numel(runs);
% fs = n.hz;

%% Remove bad frames
if isany(op.badFields)
    for f = 1:numel(op.badFields)
        xBad = n.xBad.(op.badFields(f));
        s1=numel(size(x)); s2=numel(size(xBad));
        if s1==s2
            x(xBad) = nan;
        elseif s2==2
            x(xBad,:) = nan;
        elseif s2==1
            x(xBad,:,:) = nan;
        end
    end
    disp("Removed bad frames: "+sbj);
end

%% Prep

% Convert 'half' vars to 'single' for parallel threads
idx = varfun(@(v) isa(v,"half"),psy,OutputFormat="uniform");
psy = convertvars(psy,idx,"single");

% Get downsampling factor & anti-aliasing filter
if isany(op.hzTarg)
    [ds(1),ds(2)] = rat(op.hzTarg/n.hz);
    % Errors
    if ds(1)>ds(2); error("[ec_epochBaseline] downsampling target > sampling rate"); end
    if ds(1)~=1; error("[ec_epochBaseline] downsampling target must be wholly divisible by sampling rate"); end
    ds = ds(2);
    disp("[ec_epochBaseline] downsampling factor = "+ds);
else
    ds = 1;
end

% Trial Indices
trs = groupcounts(ep,["run" "tr"]);
trs.i = false(height(trs),height(ep));
for t = 1:height(trs)
    trs.i(t,:) = ep.tr==trs.tr(t); end

% Prepare filters
[~,idx] = min(n.runIdxOg); hpf=[]; lpf=[];
if isany(op.hpf)
    hpf = ec_designFilt(x(psy.run==n.runs(idx),1,1),n.hz,op.hpf,"highpass",...
        steepness=op.hpfSteep,impulse=op.hpfImpulse,coefOut=true);
end
if isany(op.lpf)
    lpf = ec_designFilt(x(psy.run==n.runs(idx),1,1),n.hz,op.lpf,"lowpass",...
        steepness=op.lpfSteep,impulse=op.lpfImpulse,coefOut=true);
end

% Transform to cell by channel
x = ec_dim2cell(x,2);
disp("[ec_epochBaseline] Prepared data & filters: "+n.sbj+" time="+toc(tt));

%% Main loop
parfor c = 1:numel(x) % By channel
    x{c} = withinCh_lfn(x{c},n,psy,ep,trs,hpf,lpf,ds,op);
end

%% Finalize
x = cellfun(@(y) permute(y,[1 3 2]),x,'UniformOutput',false);
x = horzcat(x{:});
if op.singleOut; x=single(x); end
if op.gpu; x=gather(x); end % parfevalOnAll(@gpuDevice,0,[]); reset(gpuDevice());
disp("[ec_epochBaseline] Finished: "+n.sbj+" time="+toc(tt));




%%%%%%%%%%%%%%%%%%%%%%%%%% subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function xc = withinCh_lfn(xc,n,psy,ep,trs,hpf,lpf,ds,op)
%% Compute within-chan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xc=x{104};

% Reshape per run
xc = mat2cell(xc,n.runIdxOg);

% Processing within-run (HPF, norm, outliers, PCA, LPF)
for r = 1:n.nRuns
    stim = psy.stim(psy.run==n.runs(r));
    xc{r} = withinRun_lfn(xc{r},stim,hpf,lpf,ds,op);
end
xc = vertcat(xc{:});

% Epoch
xc = xc(ep.idx,:); % Match epoched indices

% Robust baseline correction
if any(ep.BLpre) || any(ep.BLpost)
    xc = acrossTrials_lfn(xc,ep,trs,op);
end



function xr = withinRun_lfn(xr,stim,hpf,lpf,ds,op)
%% Compute within-run %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Log transform
if op.log
    xr = log(xr); end

% Baseline outliers
if any(op.olThrBL)
    xr(~stim,:) = filloutliers(xr(~stim,:),nan,op.olCenter,1,ThresholdFactor=op.olThrBL); end

% All outliers
if any(op.olThr)
    xr = filloutliers(xr,nan,op.olCenter,1,ThresholdFactor=op.olThr); end

% Interpolate outliers/missing (slower on GPU)
xr = fillmissing(xr,"linear",1,EndValues="nearest");

% High-pass filter
if ~isempty(hpf)
    xr = ec_filtfilt(xr,hpf); end

% All outliers2
if any(op.olThr2)
    xr = filloutliers(xr,nan,op.olCenter,1,ThresholdFactor=op.olThr2);
    xr = fillmissing(xr,"linear",1,EndValues="nearest");
end

% PCA (use ec_robustPCA??)
if op.pcaSpec
    [~,xr] = pca(xr,NumComponents=op.pcaSpec,Economy=false); end

% Low-pass filter
if ~isempty(lpf)
    xr = ec_filtfilt(xr,lpf); end

% Normalize (z-score)
if op.runNorm=="robust"
    xr = normalize(xr,1,"zscore","robust");
elseif isany(op.runNorm)
    xr = normalize(xr,1,op.runNorm);
end

% Downsample
if ds > 1
    xr = xr(1:ds:end,:); end



function x = acrossTrials_lfn(x,ep,trs,op)
%% acrossTrials_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trs = table2struct(trs);

% Reshape by trial
x = arrayfun(@(t) x(t.i,:), trs,UniformOutput=false);
idb = arrayfun(@(t) ep.BLpre(t.i)|ep.BLpost(t.i), trs,UniformOutput=false); % baseline

% Baseline correct within-trial (robust z-score)
for t = 1:numel(x)
    x{t} = withinTrial_lfn(x{t},idb{t},op);
end
x = vertcat(x{:});



function xt = withinTrial_lfn(xt,idb,op)
%% withinTrial_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get trial baseline
if op.trialBaseline=="median"
    bl = median(xt(idb,:),1,"omitnan"); % BL median
elseif op.trialBaseline=="mean"
    bl = mean(xt(idb,:),1,"omitnan"); % BL median
end

% Get trial norm
if ~op.trialNormByBaseline; idb=true(height(xt),1,like=idb); end
if op.trialNorm=="robust"
    bl0 = mad(xt(idb,:),1,1); % BL MAD median absolute deviation
elseif op.trialNorm=="zscore"
    bl0 = std(xt(idb,:),1,1,"omitnan");
end

% Do baseline correction
xt = (xt-bl)./bl0;


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