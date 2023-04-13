function [x,trs] = ec_baselineTrials(x,n,psy,ep,o,tt)
% Input validation
arguments
    x {mustBeFloat}
    n struct
    psy table
    ep table
    o struct
    tt uint64 = tic
end
sbj = n.sbj;
runs = n.runs';
nRuns = numel(runs);
fs = n.fs;
badFields = o.badFields;
if isa(x,"single"); singleOut=true; else; singleOut=false; end
x = double(x);
% blThr = o.thrOLbl;
% runIdx = n.runIdxOg(:,2);
% if o.fsTarg; ds=o.fsTarg/fs; else; ds=[]; end

%% Prep

% Run indices
idr = cell(nRuns,1);
for r = 1:nRuns
    idr{r} = sparse(psy.run==runs(r)); end

% Trial Indices
trs = groupcounts(ep,["run" "trialA"]);
trs.i = cell(height(trs),1);
for t = 1:height(trs)
    trs.i{t} = sparse(ep.trialA==trs.trialA(t)); end

% Figure out norming
doLog=[]; doNorm=[];
if o.logSpec && contains(n.suffix,"s"|"d"|"t"|"a"|"b"|"g"|"h")
    doLog = o.normalizeSpec; end
if isany(o.normalizeSpec) && contains(n.suffix,"s"|"d"|"t"|"a"|"b"|"g"|"h")
    doNorm = o.normalizeSpec;
elseif isany(o.normalizeLFP) && ~contains(n.suffix,"s"|"d"|"t"|"a"|"b"|"g"|"h")
    doNorm = o.normalizeLFP;
end

% Prepare filters
[~,minIdx] = min(n.runIdxOg(:,2)); 
hpf=[]; lpf=[]; r=x(psy.run==runs(minIdx),1,1);
if any(o.hiPass)
    hpf = ec_designFilt(r,fs,o.hiPass,"highpass",...
        steepness=o.hiPassSteep,impulse=o.hiPassImpulse);
    % disp("<strong> [ec_baselineTrials] HPF object: t= </strong>"+toc(tt)); disp(hpf);
    hpf = hpf.Coefficients;
end
if any(o.loPass)
    lpf = ec_designFilt(r,fs,o.loPass,"lowpass",...
        steepness=o.loPassSteep,impulse=o.loPassImpulse);
    % disp("<strong>[ec_baselineTrials] LPF object: t= </strong>"+toc(tt)); disp(lpf);
    lpf = lpf.Coefficients;
end


%% Remove bad frames
if ~isempty(badFields)
    for f = 1:numel(badFields)
        xBad = n.xBad.(badFields(f));
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
x = acrossChs_lfn(x,psy,n,hpf,lpf,idr,doLog,doNorm,o);
disp("[ec_baselineTrials] HPF, norm, outliers, PCA, LPF (if selected): "+sbj+" t="+toc(tt));
% x = arrayfun(@(x,n) withinRun_lfn(x{:},n{:},hpf,ds,doLog,doNorm,tt),...
%     x,n.blocks',UniformOutput=false);
% x = reshape(x,sz);


%% Robust baseline correction
x = x(ep.iPsy,:,:); % Match epoched indices

if any(o.BLpre) || any(o.BLend)
    x = acrossTrials_lfn(x,ep,trs);
    disp("[ec_baselineTrials] Baseline corrected: "+sbj+" time="+toc(tt));
end

% Finalize
if singleOut; x=single(x); end



%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function x = acrossChs_lfn(x,psy,n,hpf,lpf,idr,doLog,doNorm,o)
%% acrossChs_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = arrayfun(@(ch) x(:,ch,:), 1:n.xChs, UniformOutput=false); % x = num2cell(x,[1 3]);
parfor ch = 1:numel(x)
    x{ch} = withinCh_lfn(x{ch},psy,n,hpf,lpf,idr,doLog,doNorm,o)
end
x = horzcat(x{:});



function xc = withinCh_lfn(xc,psy,n,hpf,lpf,idr,doLog,doNorm,o) 
%% withinCh_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xc = squeeze(xc);

% Within-run
for r = 1:n.nRuns
    xr = xc(idr{r},:);

    % Fill missing
    xr = fillmissing(xr,"linear");

    % Log to normal distribution
    if ~isempty(doLog)
        xr = log(xr);
    end

    % High-pass filter
    if ~isempty(hpf)
        xr = filtfilt(hpf,1,xr);
    end

    % Normalize (z-score)
    if ~isempty(doNorm)
        if doNorm=="robust"
            xr = normalize(xr,1,"zscore","robust");
        else
            xr = normalize(xr,1,doNorm);
        end
    end
    xc(idr{r},:) = xr;
end

% Find outliers
idx = ~psy.stim; % baseline outliers
xc(idx,:) = filloutliers(xc(idx,:),nan,o.outlierCenter,1,ThresholdFactor=o.thrOLbl);
xc = filloutliers(xc,nan,o.outlierCenter,1,ThresholdFactor=o.thrOL); % peri-stim outliers
xc = fillmissing(xc,"movmedian",floor(.2*n.fs));
xc = fillmissing(xc,"linear");
        
% PCA
if o.pca > 1
    [~,xc] = pca(xc,NumComponents=o.pca,Economy=false); 
end

% LPF
if ~isempty(lpf)
    for r = n.nRuns
        xc(idr{r},:) = filtfilt(lpf,1,xc(idr{r},:)); end
end

% Reshape
xc = permute(xc,[1 3 2]);



function x = acrossTrials_lfn(x,ep,trs)
%% acrossTrials_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reshape by trial
x = cellfun(@(i) x(i,:,:), trs.i,UniformOutput=false);
ep = cellfun(@(i) ep(i,:), trs.i,UniformOutput=false);

% Baseline correct within-trial (robust z-score)
parfor t = 1:height(trs)
    x{t} = withinTrial_lfn(x{t},ep{t});
end
x = vertcat(x{:});



function xt = withinTrial_lfn(xt,meta)
%% withinTrial_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xt = fillmissing(xt,"linear",1); % Interpolate missing
idx = meta.BLpre | meta.BLend;

% Trial baseline correction (robust z-score from prestimulus baseline)
bl = median(xt(idx,:,:),1,"omitnan"); % BL median
bl0 = mad(xt(idx,:,:),1,1); % BL MAD median absolute deviation
xt = (xt-bl)./bl0; % Subtract median(BL) from trial then divide by mad(BL)


% function xr = withinRun_lfn(xr,hpf,doLog,doNorm)
% %% withinRun_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Fill missing
% xr = fillmissing(xr,"linear");
% 
% % Log to normal distribution
% if ~isempty(doLog)
%     xr = log(xr);
% end
% 
% % High-pass filter
% if ~isempty(hpf)
%     xr = filtfilt(hpf,1,xr);
% end
% 
% % Normalize (z-score)
% if ~isempty(doNorm)
%     if doNorm=="robust"
%         xr = normalize(xr,1,"zscore","robust");
%     else
%         xr = normalize(xr,1,doNorm);
%     end
% end
% % Downsample
% if ds>1
%     [ds1,ds2] = rat(ds);
%     [xr,ii] = resample(xr,ds1,ds2); % Antialiased downampling if LPF>nyquist or LPF==0
%     pr = pr(ii,:);
%     disp("[ec_baselineTrials] Downsampled: run="+r+" time="+toc(tt));
% end
%xr = reshape(xr,dims); if gpu; xr=gather(xr); end