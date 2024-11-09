function ec_eventIdentifier_lbcn(sbj,task,proj,a)
arguments
    sbj (1,1) string
    task (1,1) string
    proj (1,1) string
    a.save (1,1) logical = true
    a.targetHz (1,1) double = nan
    a.date (1,1) string = string(datetime('now','TimeZone','local','Format','yyMMdd'))
end
% sbj="S15_87_RL"; sbj="S13_54_KDH"; sbj="S14_74_OD";
% task="MMR"; proj="lbcn"; a.save=0; a.targetHz=1000; r=1;
% OrganizeTrialInfoMMR_KT(sbj,task,proj);

%% Prep
dirs = ec_getDirs(proj,task,sbj);
blocks = string(BlockBySubj(sbj,task));

%% Loop across blocks/runs
for r = 1:length(blocks)
    block = blocks(r);
    withinRun_lfn(sbj,task,block,dirs,a)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function withinRun_lfn(sbj,task,block,dirs,a)

% Load trialinfo
load(fullfile(dirs.origSbj,block,"trialinfo_"+block+".mat"),"trialinfo");
trialinfo.pdio(:) = false;
if ismember("nstim",trialinfo.Properties.VariableNames)
    trialinfo.nStim = trialinfo.nstim;
else
    trialinfo.nStim(:) = numStimPerTrial_lfn(task);
end

% Basic info
nTrials = height(trialinfo);
sbjRun = trialinfo.sbjRun(1);

% Photodiode channel
if dirs.sbjID>=87
    pd_ch = 1;
else % new ones, photo = 1; old ones, photo = 2; china, photo = varies, depends on the clinician, normally 9, mic = 2
    pd_ch = 2;
end

% Load globalVar
load(dirs.origSbj+"global_"+task+"_"+sbj+"_"+block+".mat","globalVar");
hz = globalVar.Pdio_rate;
if strcmp(task, {'Calculia_production', 'Calculia_production_addsubmult'})
    hz = 10000;
end

% Load photodiode
load(sprintf('%s/%s/Pdio%s_%.2d.mat',dirs.origSbj,block,block,pd_ch), "anlg"); % going to be present in the globalVar
anlg = double(anlg)';
anlg = anlg/max(anlg);

% Resample photodiode
if a.targetHz && a.targetHz~=round(hz)
    [P,Q] = rat(a.targetHz/hz);
    anlg = resample(anlg,P,Q);
    hz = a.targetHz;
end
anlg = half(anlg); % convert to fp16 to more easily find mode

% Rescale to stable upper/lower thresholds
anlg = anlg/max(anlg);
U = mode(anlg(anlg>0.5));
L = mode(anlg(anlg<0.5));
anlg(anlg>U) = U;
anlg(anlg<L) = L;
anlg = anlg/max(anlg);
anlg(anlg<eps("half")) = eps("half");


%% Extract photodiode triggers

% Make psychophysics table
psy = timetable(anlg,SampleRate=hz,StartTime=seconds(1/hz));
psy = renamevars(psy,"anlg","photodiode");
hzStep = seconds(psy.Properties.TimeStep);

% Photodiode activity & timing
psy.pdio = psy.photodiode>=0.5; % pdio active (above threshold)
psy.pdDF = [0;diff(psy.pdio)]; % pdio status change
onsPdio = seconds(psy.Time(psy.pdDF==1)); % pdio onset
offPdio = seconds(psy.Time(psy.pdDF==-1)); % pdio offset
psy.pdDF = [];

% Add onset/offset if pdio on at start/end of recording
if psy.pdio(1)
    onsPdio = [seconds(psy.Time(1)); onsPdio]; end
if psy.pdio(end)
    offPdio = [offPdio, seconds(psy.Time(end))]; end

% Determine number of trigger flashes at start of task
[initOnsN,initOffN] = find_skip_lfn(psy.pdio);
[initOnsN,initOffN] = ... % Add exceptions
    EventIdentifierExceptions(sbj,task,block,initOnsN,initOffN);

% Trial onsets/offsets
onsPd = onsPdio(1+initOnsN:end); % Add in calculia production the finisef to experiment to have 12 pulses
offPd = offPdio(1+initOffN:end);

% Get trials, insturuction onsets
if ismember(task,["Memoria" "Memoria_stim"]) && ismember("nstim",trialinfo.Properties.VariableNames)
    % Modified for Memoria for cases where each trial has diff # of stim
    onsStim = nan(nTrials,max(trialinfo.nstim));
    counter = 1;
    for ti = 1:nTrials
        inds = counter:(counter+trialinfo.nstim(ti)-1);
        onsStim(ti,1:trialinfo.nstim(ti)) = onsPd(inds);
        counter = counter+trialinfo.nstim(ti);
    end
else
    if ~ismember(task,["MMR" "UCLA"])
        % Add other kind of exceptions for when there is more triggers in the end - Calculia
        [onsPd,offPd] = StimOnsetExceptions(sbj,block,onsPd,offPd);
        onsPd = EventIdentifierExceptions_moreTriggers(onsPd,offPd,sbj,task,block);
    end
    onsStim = onsPd;
end


%% Match photodiode and behavioral task timings
tStim = find(trialinfo.condNames~="rest");
tRest = find(trialinfo.condNames=="rest");
tFirst = find(tStim==firstPdioTrial(sbj,task,block)); % First trial with pdio

% Behavioral task stimulus onsets
onsBeh = trialinfo.StimulusOnsetTime(tStim,:);
onsBeh = onsBeh - onsBeh(tFirst) + onsStim(1); % align to pdio timing

% Make stimulus onset table
sot = table;
sot.trial = tStim;
sot.beh = onsBeh;
sot.ntrp(:)=nan; sot.pd(:)=nan; sot.lm(:)=nan; sot.fin(:)=nan;
sot.ntrp(tFirst) = onsStim(1);
sot.pd(tFirst) = onsStim(1);

% Match behavioral & photodiode onsets
for t = tFirst+1:height(sot)
    if ~isnan(sot.pd(t)); continue; end
    tPrev = find(sot.pd>0 & sot.trial<=sot.trial(t),1,'last'); % Previous filled pdio onset
    sot.ntrp(t) = sot.beh(t) - sot.beh(tPrev) + sot.pd(tPrev);

    % Find closest pdio onset
    [df,idx] = min(abs(onsStim - sot.ntrp(t))); % Compare with interpolated
    if df < 0.04
        sot.pd(t) = onsStim(idx); end % Only use if within 40ms
end

% Robust regression (correct behav-pdio drift)
lm = fitlm(sot,'pd~beh',RobustOpts=1);
sot.lm = predict(lm,sot);

% Do any remaining missing
if nnz(isnan(sot.pd))
    for t = find(isnan(sot.pd))'
        [df,idx] = min(abs(onsStim - sot.lm(t))); % Compare with linear estimate
        if df < 0.1
            sot.pd(t) = onsStim(idx); % Only use if within 100ms
            lm = fitlm(sot,'pd~beh',RobustOpts=1); % Robust regression (correct behav-pdio drift)
            sot.lm = predict(lm,sot);
        end
    end
end

% Error if duplicate sot.pd value
sotN = groupcounts(sot,'pd');
if max(sotN.GroupCount(~isnan(sotN.pd))) > 1
    disp(sotN); error(sbjRun+": duplicate pdio onsets (sot.pd)"); end

% Photodiode timings as final
sot.fin = sot.pd;

% Use regression estimates for missing photodiode timings
interpIdx = isnan(sot.pd);
if nnz(interpIdx)
    sot.fin(interpIdx) = sot.lm(interpIdx);
    disp("["+sbjRun+"] Trials w/o photodiode, using regression timings:");
    disp(sot.trial(interpIdx)');
end

% Exceptions (Typically mid-trial trigger)
sot = eventIdExceptions_SOT(sot,sbjRun,task);


%% Diagnostics

% Comparing photodiod with behavioral data
sot.BehPd = sot.beh - sot.pd; % behav vs. pdio
sot.NtrpPd = sot.ntrp - sot.pd; % interpolated vs. pdio
sot.LmPd = sot.lm - sot.pd; % drift corrected vs. pdio
sot.BehFin = sot.beh - sot.fin; 

% Onset diff
sod = table;
sod.trial = tStim(2:end);
sod.beh = diff(sot.beh);
sod.pd = diff(sot.pd);
sod.fin = diff(sot.fin);
sod.BehFin = (sod.beh-sod.fin)*1000;

% Start diagnostic plot
if a.save
    hf = figure(Units="points",Position=[0 0 1440 810],color="w",Visible="off");
else
    hf = figure(Units="points",Position=[0 0 1440 810],color="w");
end
tiledlayout(hf,2,4,TileSpacing="tight",Padding="tight");

% Photodiode signal vs. onsets
nexttile([1 4]);
hold on
plot(psy.Time,psy.photodiode,Color=[.7 .7 .7],DisplayName="Pdiode");
plot(onsStim,repmat(0.5,height(onsStim),1),"*",Color=[1 0 0],DisplayName="Pdio");
plot(sot.ntrp,repmat(0.6,height(sot),1),"*",Color="#FF8C00",DisplayName="Intrp");
plot(sot.lm,repmat(0.7,height(sot),1),"*",Color=[1 0 1],DisplayName="LM");
plot(sot.lm,repmat(0.8,height(sot),1),"*",Color=[0 .6 0],DisplayName="Final");
hold off
title(sbjRun+" "+block,interpreter="none");
legend(Location="southeast");

% Onset compare
nexttile;
hold on
plot(sot.trial,sot.BehFin,Color=[0 .6 0],DisplayName="Behav-Final");
plot(sot.trial,sot.BehPd,Color=[0 0 1],DisplayName="Behav-Pdio");
plot(sot.trial,sot.NtrpPd,Color="#FF8C00",DisplayName="Intrp-Pdio");
plot(sot.trial,sot.LmPd,Color=[1 0 1],DisplayName="LM-Pdio");
hold off
title("Onset Comparison (sec)");
xlabel("Trial #");
legend(Location="southwest");

% Inter-stimulus interval (ISI)
nexttile;
hold on
plot(sod.beh,"o",MarkerSize=8,LineWidth=3,DisplayName="Behav");
plot(sod.fin,".",Color=[0 .6 0],MarkerSize=10,DisplayName="Final");
plot(sod.pd,"*",Color=[1 0 0],Markersize=8,DisplayName="Pdio");
hold off
title("InterStimulusInterval (sec):  behav[o]  pdio[*]  final[.]");
xlabel("Stim #");

% ISI compare
nexttile;
plot(sod.BehFin);
title("ISI (ms):  behav - final");
xlabel("Stim #");

% ISI histogram
nexttile;
histogram(sod.BehFin);
title("ISI (histogram):  behav - final");
xlabel("Milliseconds");


%% Updating trialinfo & psy
psy = movevars(psy,"pdio","Before","photodiode");
trialinfo.noPdio(sot.trial(isnan(sot.pd))) = true; % no pdio signal (interpolated times)

% Stim onset from behav data
trialinfo.onsBeh(sot.trial) = sot.beh;
trialinfo.onsBeh(tRest) = trialinfo.onsBeh(tRest-1) + trialinfo.durBeh(tRest-1);

% Preallocate
trialinfo.lockErr(:) = nan;
trialinfo.lockITI(:) = nan;
trialinfo.lockStim(:) = nan;
trialinfo.lockOff(:) = nan;

% Pdio-Behav alignment error (interstimulus interval: Behav-Final)
trialinfo.lockErr(tFirst) = 0;
trialinfo.lockErr(sod.trial) = sod.BehFin/1000;

% Stim timings from pdio-behav data (round by sampling rate)
trialinfo.lockStim(sot.trial) = round(sot.fin*hz)/hz;
trialinfo.lockOff(sot.trial) = trialinfo.lockStim(sot.trial) + trialinfo.durBeh(sot.trial);
trialinfo.lockOff(sot.trial) = ceil(trialinfo.lockOff(sot.trial)*hz)/hz;

% Rest trial timings from pdio-behav data (round by sampling rate)
trialinfo.lockStim(tRest) = trialinfo.lockOff(tRest-1) + hzStep; % frame after prev stim offset
trialinfo.lockStim(tRest) = floor(trialinfo.lockStim(tRest)*hz)/hz;
trialinfo.lockOff(tRest) = trialinfo.lockStim(tRest) + trialinfo.durBeh(tRest);
trialinfo.lockOff(tRest) = ceil(trialinfo.lockOff(tRest)*hz)/hz;

% ITI timings from pdio-behav data (round by sampling rate)
trialinfo.lockITI(1) = trialinfo.lockStim(1) - trialinfo.itiBeh(1);
trialinfo.lockITI(2:end) = trialinfo.lockOff(1:end-1) + hzStep; % frame after prev stim offset
trialinfo.lockITI(trialinfo.lockITI<0) = 0;
trialinfo.lockITI = floor(trialinfo.lockITI*hz)/hz;


%% Save
if a.save
    % Tables
    save(fullfile(dirs.origSbj,block,"trialinfo_"+block+".mat"), "trialinfo");
    save(fullfile(dirs.origSbj,"psy_"+sbjRun+".mat"), "psy");

    % Diagnostic figure
    fn = fullfile(dirs.anal,"sanity","pdio",a.date);
    mkdir(fn);
    exportgraphics(hf,fullfile(fn,sbjRun+"_pdio.png"));

    %disp("["+sbjRun+"] Saved photodiode-aligned trialinfo, psy & diagnostic figs!");
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [skip_onset, skip_offset] = find_skip_lfn(pdio)
%   If the default skip pulses are incorrect, find the right number.
%   -----------------------------------------
%   =^._.^=     Su Liu
%
%   suliu@standord.edu
%   -----------------------------------------

xx = diff(pdio);
onsets = find(xx==1); %onsets, no filtering
offsets = find(xx==-1);

onn_offsets = diff(offsets);
onn_onsets = diff(onsets);

n_initpulse_offset = find(onn_offsets<0.5*median(onn_offsets));
n_initpulse_offset = n_initpulse_offset(find(diff(n_initpulse_offset)<3)+1);

n_initpulse_onset = find(onn_onsets<0.5*median(onn_onsets));
n_initpulse_onset =  n_initpulse_onset(find(diff(n_initpulse_onset)<3)+1);

try
    skip_offset = n_initpulse_offset(end)+1;
    skip_onset = n_initpulse_onset(end)+1;
    if skip_offset >20 || skip_onset >20
        skip_offset = 0;
        skip_onset = 0;
    end
catch
    skip_offset = 0;
    skip_onset = 0;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function nStim = numStimPerTrial_lfn(task)
switch task
    case 'MMR'
        nStim = 1;
    case 'UCLA'
        nStim = 1;
    case {'Memoria', 'Calculia_verification_digit', 'Memoria_stim'}
        nStim = 5;
    case 'Calculia'
        nStim = 5;
    case {'Calculia_production', 'Calculia_production_stim', 'Calculia_production_addsubmult', 'Calculia_production_audio'}
        nStim = 3;
    case 'Calculia_China'
        nStim = 5;
    case 'Number_comparison'
        nStim = 2;
    case 'Context'
        nStim = 5;
    case 'Scrambled'
        nStim = 1;
    case 'AllCateg'
        nStim = 1;
    case 'VTCLoc'
        nStim = 1;
    case 'SevenHeaven'
        nStim = 1;
    case 'GradCPT'
        nStim = 1;
    case 'ReadNumWord'
        nStim = 1;
    case 'MFA'
        nStim = 1;
end