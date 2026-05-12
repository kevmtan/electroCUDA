function chNfo = ec_sigChsFromPerm(st,chNfo,op)
% Augments a channel info table with per-channel × per-frequency event metrics
% derived from ec_condConChs_perm results: activation/deactivation flags,
% onset/peak/offset latencies, duration, and peak measure value, for each
% requested contrast.
%
% INPUTS:
%   st     — stats table from ec_condConChs_perm (rows: channel × time × contrast).
%            Required columns: sbjCh, contrast, time, and the columns named by
%            op.sigVar (e.g. "q") and op.mVar (e.g. "mu"). Significance/measure
%            columns are (nTimes × nFreq) when freq/band is a third dim.
%   chNfo  — channel info table (must contain sbjCh column).
%   op     — options struct:
%              .contrasts   (string array)         contrasts to evaluate.
%                                                  Defaults to unique(st.contrast).
%              .conNames    (string array, opt)    sanitized field-name versions
%                                                  of contrasts; derived if absent.
%              .sigVar      (string, default "q")  significance variable in st.
%              .sigThr      (scalar, default 0.05) threshold (sig if value < thr).
%              .sigDur      (scalar ms, def 50)    min contiguous run of sig samples.
%              .mVar        (string, default "mu") direction/measure variable in st.
%              .sigTimeRng  ([min max] ms, opt)    restrict check to time window.
%
% OUTPUT:
%   chNfo  — input chNfo with the following per-contrast columns added (nFreq cols each):
%              <conName>_act, <conName>_onsA, <conName>_peakA, <conName>_offA,
%              <conName>_durA, <conName>_peakA_<mVar>
%              <conName>_dea, <conName>_onsD, <conName>_peakD, <conName>_offD,
%              <conName>_durD, <conName>_peakD_<mVar>
%
% Shared kernel between ec_condConChs_sigChs (batch driver) and ec_selectChsBySig
% (classifier-side selection).

arguments
    st table
    chNfo table
    op struct
end

% Defaults
if ~isfield(op,"sigVar") || ~isany(op.sigVar); op.sigVar = "q"; end
if ~isfield(op,"sigThr") || isempty(op.sigThr); op.sigThr = 0.05; end
if ~isfield(op,"sigDur") || isempty(op.sigDur); op.sigDur = 50; end
if ~isfield(op,"mVar")   || ~isany(op.mVar);   op.mVar   = "mu"; end

if ~isfield(op,"contrasts") || ~isany(op.contrasts)
    op.contrasts = unique(st.contrast,"stable");
end
op.contrasts = string(op.contrasts);

if ~isfield(op,"conNames") || isempty(op.conNames)
    op.conNames = regexprep(op.contrasts,"[^a-zA-Z0-9_]","");
end

% Channels present in stats table
chs = unique(st.sbjCh,"stable");

% Number of frequency bands (columns of the measure column)
nFreq = size(st.(op.mVar),2);

% Preallocate per-contrast columns (rows=channels, cols=freq bands)
nCons = numel(op.contrasts);
hh = height(chNfo);
for c = 1:nCons
    cn = op.conNames(c);
    % Activation event: flag, onset/peak/offset latencies, duration, peak mVar value
    chNfo.(cn+"_act")            = false(hh,nFreq);
    chNfo.(cn+"_onsA")           = nan(hh,nFreq);
    chNfo.(cn+"_peakA")          = nan(hh,nFreq);
    chNfo.(cn+"_offA")           = nan(hh,nFreq);
    chNfo.(cn+"_durA")           = nan(hh,nFreq);
    chNfo.(cn+"_peakA_"+op.mVar) = nan(hh,nFreq);
    % Deactivation event
    chNfo.(cn+"_dea")            = false(hh,nFreq);
    chNfo.(cn+"_onsD")           = nan(hh,nFreq);
    chNfo.(cn+"_peakD")          = nan(hh,nFreq);
    chNfo.(cn+"_offD")           = nan(hh,nFreq);
    chNfo.(cn+"_durD")           = nan(hh,nFreq);
    chNfo.(cn+"_peakD_"+op.mVar) = nan(hh,nFreq);
end


%% Loop channels × contrasts
for k = 1:numel(chs)
    sbjCh = chs(k);
    idChn = chNfo.sbjCh==sbjCh;
    if ~any(idChn); continue; end

    % This channel's stats rows
    stc = st(st.sbjCh==sbjCh,:);

    for c = 1:nCons
        con = op.contrasts(c);
        idc = stc.contrast==con;
        if ~any(idc); continue; end

        % Time in ms (convert if needed)
        times_ms = toMs_lfn(stc.time(idc));

        % Measure & significance (rows=nTimes, cols=nFreq)
        mu = stc.(op.mVar)(idc,:);
        q  = stc.(op.sigVar)(idc,:);

        % Directional significance masks
        sig    = q < op.sigThr;
        sigAct = sig & (mu>0);
        sigDea = sig & (mu<0);

        % Restrict to sig time range
        if isfield(op,"sigTimeRng") && numel(op.sigTimeRng)==2
            idT = times_ms>=op.sigTimeRng(1) & times_ms<=op.sigTimeRng(2);
            sigAct(~idT,:) = false;
            sigDea(~idT,:) = false;
        end

        % Per-freq event metrics
        cn = op.conNames(c);
        times = stc.time(idc);
        onsA=nan(1,nFreq); pkA=nan(1,nFreq); offA=nan(1,nFreq); durA=nan(1,nFreq); pkAv=nan(1,nFreq);
        onsD=nan(1,nFreq); pkD=nan(1,nFreq); offD=nan(1,nFreq); durD=nan(1,nFreq); pkDv=nan(1,nFreq);
        for f = 1:nFreq
            [onsA(f),pkA(f),offA(f),durA(f),pkAv(f)] = ...
                sigMetrics_lfn(sigAct(:,f),mu(:,f),times,times_ms,op.sigDur,"act");
            [onsD(f),pkD(f),offD(f),durD(f),pkDv(f)] = ...
                sigMetrics_lfn(sigDea(:,f),mu(:,f),times,times_ms,op.sigDur,"dea");
        end

        chNfo.(cn+"_act")(idChn,:)            = ~isnan(onsA);
        chNfo.(cn+"_onsA")(idChn,:)           = onsA;
        chNfo.(cn+"_peakA")(idChn,:)          = pkA;
        chNfo.(cn+"_offA")(idChn,:)           = offA;
        chNfo.(cn+"_durA")(idChn,:)           = durA;
        chNfo.(cn+"_peakA_"+op.mVar)(idChn,:) = pkAv;

        chNfo.(cn+"_dea")(idChn,:)            = ~isnan(onsD);
        chNfo.(cn+"_onsD")(idChn,:)           = onsD;
        chNfo.(cn+"_peakD")(idChn,:)          = pkD;
        chNfo.(cn+"_offD")(idChn,:)           = offD;
        chNfo.(cn+"_durD")(idChn,:)           = durD;
        chNfo.(cn+"_peakD_"+op.mVar)(idChn,:) = pkDv;
    end
end




function [ons,pk,off,dur,pkVal] = sigMetrics_lfn(sig,mu,times,times_ms,minDur,direction)
%%% Event metrics for ONE frequency band %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sig & mu: 1D vectors over time (directional sig already applied).
% Find contiguous-true runs >= minDur ms; return NaN if none qualify.
% Latencies/duration in native `times` units; pkVal in `mu` units.
[ons,pk,off,dur,pkVal] = deal(nan);
sig = sig(:);
if ~any(sig); return; end

% Time-domain runs
d = diff([false; sig; false]);
rs = find(d==1);
re = find(d==-1)-1;

% Sample period in ms (for sigDur thresholding)
dt_ms = median(diff(times_ms),"omitmissing");
if ~isfinite(dt_ms) || dt_ms<=0; dt_ms = 0; end

% Filter runs by duration >= minDur (ms)
durs_ms = times_ms(re) - times_ms(rs) + dt_ms;
ok = durs_ms >= minDur;
rs = rs(ok); re = re(ok);
if isempty(rs); return; end

% Onset / offset in native time units
ons = times(rs(1));
off = times(re(end));

% Duration: total span across qualifying runs (native time units)
dt_nat = median(diff(times),"omitmissing");
if ~isfinite(dt_nat) || dt_nat<=0; dt_nat = 0; end
dur = sum(times(re) - times(rs)) + dt_nat*numel(rs);

% Peak: extremum of mu over qualifying-run sig timepoints
maskT = false(size(sig));
for r = 1:numel(rs)
    maskT(rs(r):re(r)) = true;
end
muM = mu(:);
muM(~(maskT & sig)) = nan;
if all(isnan(muM)); return; end

if direction=="act"
    [pkVal,ix] = max(muM,[],"omitmissing");
else
    [pkVal,ix] = min(muM,[],"omitmissing");
end
pk = times(ix);




function times_ms = toMs_lfn(times)
%%% Convert times to ms if not already %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Heuristic: EEG epoch times in seconds rarely exceed ~100 in magnitude,
% while millisecond-scale times typically span hundreds to thousands.
if max(abs(times),[],"omitmissing") < 100
    times_ms = times * 1000;
else
    times_ms = times;
end
