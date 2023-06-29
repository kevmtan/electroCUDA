function [x,trs] = ec_epochBaseline(x,n,psy,ep,tt,op)
% Input validation
arguments
    x {mustBeFloat}
    n struct
    psy table
    ep table
    tt uint64 = tic
    op.gpu (1,1) logical = false
    op.double (1,1) logical = true
    op.singleOut (1,1) logical = false
    op.log (1,1) logical = false;                      % Log transform
    op.runNorm string = "zscore";               % Normalize run
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
sbj = n.sbj; 
% blThr = op.thrOLbl;
% runIdx = n.runIdxOg(:,2);
% if op.fsTarg; ds=op.fsTarg/fs; else; ds=[]; end
% runs = n.runs';
% nRuns = numel(runs);
% fs = n.fs;


%% Trial Indices
trs = groupcounts(ep,["run" "trialA"]);
trs.i = false(height(trs),height(ep));
for t = 1:height(trs)
    trs.i(t,:) = ep.trialA==trs.trialA(t); end


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


%% Processing within-chan (HPF, norm, outliers, PCA, LPF)
x = acrossRunsChs_lfn(x,psy,n,op,tt);


%% Epoch
x = x(ep.iPsy,:,:); % Match epoched indices
disp("[ec_baselineTrials] Epoched EEG data: "+sbj+" time="+toc(tt));


%% Robust baseline correction
if any(ep.BLpre) || any(ep.BLend)
    x = acrossTrials_lfn(x,ep,trs,op);
    disp("[ec_baselineTrials] Baseline corrected: "+sbj+" time="+toc(tt));
end

%% Finalize
if op.singleOut; x=single(x); end
if op.gpu; x=gather(x); end % parfevalOnAll(@gpuDevice,0,[]); reset(gpuDevice());




%%%%%%%%%%%%%%%%%%%%%%%%%% Chan subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function xx = acrossRunsChs_lfn(x,psy,n,op,tt)
%% Compute across chans/ICs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run indices
rr = uint8(1:n.nRuns);
idr = false(height(psy),n.nRuns);
for r = rr
    idr(:,r) = psy.run==n.runs(r); end

% Prepare filters
[~,minIdx] = min(n.runIdxOg(:,2)); hpf=[]; lpf=[];
if any(op.hpf)
    hpf = ec_designFilt(x(idr(:,minIdx),1,1),n.fs,op.hpf,"highpass",...
        steepness=op.hpfSteep,impulse=op.hpfImpulse);
end
if any(op.lpf)
    lpf = ec_designFilt(x(idr(:,minIdx),1,1),n.fs,op.lpf,"lowpass",...
        steepness=op.lpfSteep,impulse=op.lpfImpulse);
end

% Prepare data
fs2=cast(0.2*n.fs,like=x); ff=cast(1:size(x,3),like=x); stim=psy.stim;
if op.gpu; fs2=gpuArray(fs2); ff=gpuArray(ff); rr=gpuArray(rr); stim=gpuArray(stim);...
        idr=gpuArray(idr); hpf=gpuArray(hpf); lpf=gpuArray(lpf); end
chs=uint16(1:size(x,2));
disp("[ec_baselineTrials] Prepared data & filters: "+n.sbj+" time="+toc(tt));

%% Parfor across chans/ICs
if op.gpu
    xx = gpuArray(x); clear x
    xx = arrayfun(@(c) withinCh_lfn(xx(:,c,:),ff,rr,idr,stim,fs2,hpf,lpf,op),...
        chs, UniformOutput=false);
    xx = horzcat(xx{:});
else
    if op.pcaSpec; xx=x(:,:,1:op.pcaSpec); else; xx=x; end
    parfor c = chs
        xx(:,c,:) = withinCh_lfn(x(:,c,:),ff,rr,idr,stim,fs2,hpf,lpf,op); end
end
disp("[ec_baselineTrials] Log-normed, denoised, HPF & PCA z-scored: "+n.sbj+" time="+toc(tt));



function xc = withinCh_lfn(xc,ff,rr,idr,stim,fs2,hpf,lpf,op)
%% Compute within chan/IC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xc = squeeze(xc); 

% Log transform
if op.log
    xc = arrayfun(@log,xc); end

% Outliers, HPF, z-score (within-run)
for r = rr
    id = idr(:,r);
    xc(id,:) = withinChRun_lfn(xc(id,:),ff,~stim(id),fs2,hpf,op);
end

% PCA
if op.pcaSpec
    [~,xc] = pca(xc,NumComponents=op.pcaSpec,Economy=false); end

% LPF (within-run)
if ~isempty(lpf)
    for r = rr
        xc(idr(:,r),:) = filtfilt(lpf,ones(1,like=xc),xc(idr(:,r),:)); end
end

% Finalize
xc = permute(xc,[1 3 2]);



function xr = withinChRun_lfn(xr,ff,idb,fs2,hpf,op)
%% Compute within run per chan/IC  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Baseline outliers
if any(op.olThrBL)
    xr(idb,:) = filloutliers(xr(idb,:),nan(1,like=xr),op.olCenter,1,ThresholdFactor=op.olThrBL); end
% Peri-stimulus outliers
if any(op.olThr)
    xr = filloutliers(xr,nan(1,like=xr),op.olCenter,1,ThresholdFactor=op.olThr); end
% Interpolate outliers/missing (slower on GPU)
for f = ff
    xr(:,f) = fillmissing_lfn(xr(:,f),fs2); end

% High-pass filter
if ~isempty(hpf)
    xr = filtfilt(hpf,ones(1,like=xr),xr); end

% Peri-stimulus outliers
if any(op.olThr)
    xr = filloutliers(xr,nan(1,like=xr),op.olCenter,1,ThresholdFactor=op.olThr);
    for f = ff
        xr(:,f) = fillmissing_lfn(xr(:,f),fs2); end % Interpolate outliers/missing (slower on GPU)
end

% Normalize (z-score)
if op.runNorm=="robust"
    xr = normalize(xr,1,"zscore","robust");
elseif isany(op.runNorm)
    xr = normalize(xr,1,op.runNorm);
end



function xf = fillmissing_lfn(xf,fs2)
%% fillmissing_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if any(isnan(xf))
    xf = fillmissing(xf,"movmedian",fs2); end
if any(isnan(xf))
    xf = fillmissing(xf,"linear"); end





%%%%%%%%%%%%%%%%%%%%%%%%%% Trial subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function x = acrossTrials_lfn(x,ep,trs,op)
%% acrossTrials_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trs = table2struct(trs);

% Reshape by trial
x = arrayfun(@(t) x(t.i,:,:), trs,UniformOutput=false);
idb = arrayfun(@(t) ep.BLpre(t.i)|ep.BLend(t.i), trs,UniformOutput=false);

% Baseline correct within-trial (robust z-score)
if op.gpu
    idb = cellfun(@gpuArray,idb,UniformOutput=false);
    x = cellfun(@gpuArray,x,UniformOutput=false);
    x = arrayfun(@(xt,it) withinTrial_lfn(xt{:},it{:},op), x,idb,UniformOutput=false);
    x = cellfun(@gather,x,UniformOutput=false);
else
    parfor t = 1:numel(x)
        x{t} = withinTrial_lfn(x{t},idb{t},op); end
end
x = vertcat(x{:});



function xt = withinTrial_lfn(xt,idb,op)
%% withinTrial_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get trial baseline
if op.trialBaseline=="median"
    bl = median(xt(idb,:,:),1,"omitnan"); % BL median
elseif op.trialBaseline=="mean"
    bl = mean(xt(idb,:,:),1,"omitnan"); % BL median
end

% Get trial norm
if ~op.trialNormByBaseline; idb=true(height(xt),1,like=idb); end
if op.trialNorm=="robust"
    bl0 = mad(xt(idb,:,:),1,1); % BL MAD median absolute deviation
elseif op.trialNorm=="zscore"
    bl0 = std(xt(idb,:,:),1,1,"omitnan");
end

% Do baseline correction
xt = (xt-bl)./bl0;
