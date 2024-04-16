function EventIdentifier(sbj,task,runs,dirs,pdioCh,saveFig)
if nargin<6
    saveFig=false;
end
%% Globar Variable elements

%% loop across blocks
for i = 1:length(runs)
    bn = runs{i};

    switch task
        case 'MMR'
            n_stim_per_trial = 1;
        case 'UCLA'
            n_stim_per_trial = 1;
        case {'Memoria', 'Calculia_verification_digit', 'Memoria_stim'}
            n_stim_per_trial = 5;
        case 'Calculia'
            n_stim_per_trial = 5;
        case {'Calculia_production', 'Calculia_production_stim', 'Calculia_production_addsubmult', 'Calculia_production_audio'}
            n_stim_per_trial = 3;
        case 'Calculia_China'
            n_stim_per_trial = 5;
        case 'Number_comparison'
            n_stim_per_trial = 2;
        case 'Context'
            n_stim_per_trial = 5;
        case 'Scrambled'
            n_stim_per_trial = 1;
        case 'AllCateg'
            n_stim_per_trial = 1;
        case 'VTCLoc'
            n_stim_per_trial = 1;
        case 'SevenHeaven'
            n_stim_per_trial = 1;
        case 'GradCPT'
            n_stim_per_trial = 1;
        case 'ReadNumWord'
            n_stim_per_trial = 1;
        case 'MFA'
            n_stim_per_trial = 1;
    end

    %% Load globalVar
    load(fullfile(dirs.origSbj,['global_' task '_' sbj '_' bn '.mat']),'globalVar');
    if strcmp(task, {'Calculia_production', 'Calculia_production_addsubmult'})
        iEEG_rate = 10000;
        globalVar.Pdio_rate = 10000;
    else
        iEEG_rate=globalVar.iEEG_rate;
    end

    %% reading analog channel from neuralData directory
    load(sprintf('%s/%s/Pdio%s_%.2d.mat',dirs.origSbj,bn,bn,pdioCh),'anlg'); % going to be present in the globalVar
    %     anlg = abs(anlg);

    %% varout is anlg (single precision)
    pdio = anlg/max(double(anlg));
    if strcmp(task, {'Calculia_production'}) || strcmp(task, {'Calculia_production_audio'}) || strcmp(task, 'Calculia_production_stim') || strcmp(task, {'Calculia_production_addsubmult'})

        if strcmp(sbj, 'S18_124_JR2')
            n_initpulse_onset = 0;
            n_initpulse_offset = 0;
        else
            n_initpulse_onset = 12;
            n_initpulse_offset = 12;
        end

    elseif strcmp(task, {'Memoria'}) &&  strcmp(bn, 'E21-465_0004')
        n_initpulse_onset = 4;
        n_initpulse_offset = 4;
    elseif strcmp(task, {'SevenHeaven'})
        n_initpulse_onset = 12;
        n_initpulse_offset = 12;

    else

        [n_initpulse_onset, n_initpulse_offset] = find_skip_lfn(anlg, 0.001, globalVar.Pdio_rate);
    end




    clear anlg

    %% Add exceptions
    [n_initpulse_onset, n_initpulse_offset] = EventIdentifierExceptions(sbj, task, bn, n_initpulse_onset, n_initpulse_offset);


    %% Thresholding the signal
    if strcmp(task, {'Calculia_production', 'Calculia_production_addsubmult', 'Calculia_production_audio'})
        ind_above= pdio < -3;
    elseif strcmp(sbj, 'S16_102_MDO') && strcmp(bn, 'E16-993_0007')
        pdio = abs(pdio);
        ind_above= pdio > 2;

    elseif strcmp(task, 'Calculia_production_stim')
        ind_above= pdio > 2.2;

    elseif strcmp(sbj,'S19_137_AF') &&  (strcmp(bn, 'E19-380_0078') || strcmp(bn, 'E19-380_0079'))
        ind_above= pdio > 2.7;

    elseif strcmp(sbj,'S19_137_AF') &&  (strcmp(bn, 'E19-380_0081') || strcmp(bn, 'E19-380_0083'))
        ind_above= pdio > 2;

    else
        ind_above= pdio > 0.5;
    end

    if  strcmp(sbj,'S21_160_PC') && (strcmp(bn, 'E21-179_0014'))
        ind_above= pdio < -0.3;
    else
        ind_above= pdio < -3;
    end

    ind_above= pdio > 0.5;


    if strcmp(sbj,'S20_152_HT')
        globalVar.Pdio_rate = 10000;
        if strcmp(bn, 'E20-580_0010')
            ind_above = pdio < -0.3;
        else
        end
    else

    end




    ind_df= diff(ind_above);
    clear ind_above
    onset= find(ind_df==1);
    offset= find(ind_df==-1);
    clear ind_df

    if strcmp(sbj,'S16_97_CHM') && strcmp(bn,'E16-517_0014')
        onset= onset(1:252);
    elseif strcmp(sbj,'S15_87_RL') && strcmp(bn,'E15-282_0018')
        onset= onset(1:20);
        offset = offset(1:20);
    else
    end
    pdio_onset= onset/globalVar.Pdio_rate;
    pdio_offset= offset/globalVar.Pdio_rate;
    if length(pdio_onset) < length(pdio_offset)
        pdio_onset = [0 pdio_onset];
        warning('Adding additional onset as 0, since recording started in the middle of the photodiode signal')
    else
    end


    % %remove onset flash
    pdio_onset(1:n_initpulse_onset)=[]; % Add in calculia production the finisef to experiment to have 12 pulses
    pdio_offset(1:n_initpulse_offset)=[]; %
    clear n_initpulse_onset; clear n_initpulse_offset;


    if strcmp(sbj,'S19_137_AF') && strcmp(task,'EglyDriver_stim')
        pdio_onset= pdio_onset(1:216);
    else
    end

    %get osnets from diode
    pdio_dur= pdio_offset - pdio_onset;
    IpdioI= [pdio_onset(2:end)-pdio_offset(1:end-1) 0];
    if strcmp(sbj, 'S16_96_LF') && strcmp(bn, 'E16-429_0015')
        isi_ind = 1:length(IpdioI);
        clear stim_offset stim_onset
        stim_offset= [pdio_offset(isi_ind)];
        stim_onset= [pdio_onset(isi_ind)];
    else
        isi_ind = find(IpdioI > 0.1);
        clear stim_offset stim_onset
        stim_offset= [pdio_offset(isi_ind) pdio_offset(end)];
        stim_onset= [pdio_onset(isi_ind) pdio_onset(end)];

    end
    stim_dur= stim_offset - stim_onset;

    %% Load trialinfo
    % ---------------------------------------------
    % Create specific subfunctions to extract the relevant info for each
    % project_name
    load(fullfile(dirs.origSbj,bn,['trialinfo_' bn '.mat']), 'trialinfo');

    % Add the all_stim_onset

    event_trials = find(~strcmp(trialinfo.condNames, 'rest'));
    rest_trials = find(strcmp(trialinfo.condNames, 'rest'));

    StimulusOnsetTime = trialinfo.StimulusOnsetTime(event_trials,1); % **

    %% match the trigger onset with behaviral data
    beh_sot_all=trialinfo.StimulusOnsetTime(event_trials,:);
    beh_sot_all=beh_sot_all(~isnan(beh_sot_all));
    beh_sot=sort(reshape(beh_sot_all,1,numel(beh_sot_all)));
    beh_sot=beh_sot-beh_sot(1)+stim_onset(1);

    if length(stim_onset)<length(beh_sot)
        disp('Warning: Missing trigger in Pdio.');
        stim_onset(1,length(stim_onset)+1:length(beh_sot))=nan;
        for i=1:length(beh_sot)
            if stim_onset(i)-beh_sot(i)>1
                stim_onset(1,i+1:end+1)=stim_onset(1,i:end);
                stim_onset(i)=beh_sot(i);
                disp('Complementing')
            end
        end
        stim_onset=stim_onset(~isnan(stim_onset));
        disp('Notice:  Trigger has been Complemented.')
        figure
        plot(beh_sot,'o','MarkerSize',8,'LineWidth',3) % psychtoolbox
        hold on
        plot(stim_onset,'r*') % photodiode/trigger

    end

    %% Get trials, insturuction onsets
    colnames = trialinfo.Properties.VariableNames;
    ntrials = size(trialinfo,1);

    if strcmp(task, 'Calculia') || strcmp(task, 'Context') || strcmp(task, 'Scrambled') || strcmp(task, 'MMR') || strcmp(task, 'UCLA') || strcmp(task, 'MFA')
        % Add other kind of exceptions for when there is more triggers in the end - Calculia
        [stim_onset,stim_offset] = StimOnsetExceptions(sbj,bn,stim_onset,stim_offset);
        all_stim_onset = EventIdentifierExceptions_moreTriggers(stim_onset, stim_offset, sbj, task, bn);
        stim_onset = all_stim_onset;
        all_stim_onset = reshape(stim_onset,n_stim_per_trial,length(stim_onset)/n_stim_per_trial)';
        %% modified for Memoria
    elseif strcmp(task, 'Memoria') || strcmp(task, 'Memoria_stim')
        if ismember('nstim',colnames) % for cases where each trial has diff # of stim
            all_stim_onset = nan(ntrials,max(trialinfo.nstim));

            counter = 1;
            for ti = 1:ntrials
                inds = counter:(counter+trialinfo.nstim(ti)-1);
                all_stim_onset(ti,1:trialinfo.nstim(ti))=stim_onset(inds);
                counter = counter+trialinfo.nstim(ti);
            end
        end
    else
        all_stim_onset = reshape(stim_onset,n_stim_per_trial,length(stim_onset)/n_stim_per_trial)';
    end


    %%
    % Plot photodiode segmented data
    figureDim = [0 0 1 1];
    if saveFig
        hf = figure('units','normalized','outerposition',figureDim,'Visible','off');
    else
        hf = figure('units','normalized','outerposition',figureDim);
    end

    subplot(2,3,1:3)
    hold on
    plot(pdio)
    title(bn, 'interpreter', 'none')

    % Event onset
    plot(stim_onset*globalVar.Pdio_rate,0.9*ones(length(stim_onset),1),'r*');

    plot(all_stim_onset*globalVar.Pdio_rate,0.9*ones(length(all_stim_onset),1),'r*');

    %% Comparing photodiod with behavioral data
    % Add another exception for subjects who have 1 trialinfo less
    all_stim_onset = EventIdentifierExceptions_oneTrialLess(all_stim_onset,sbj, task, bn);
    %StimulusOnsetTime = EventIdentifierExceptions_TrialLessStimOnsetTime(StimulusOnsetTime, sbj_name,project_name, bn);

    % Add another exception for subjects who have additional photo/trigger trials in the middle
    % and visual inspection shows good correspondence between photo/trigger and psychtoolbox output
    all_stim_onset = EventIdentifierExceptions_extraTrialsMiddle(all_stim_onset, StimulusOnsetTime, sbj, task, bn);


    %% Plot comparison photo/trigger
    df_SOT= diff(StimulusOnsetTime)';
    df_stim_onset = diff(all_stim_onset(:,1))';

    %plot overlay
    subplot(2,3,4)
    plot(df_SOT,'o','MarkerSize',8,'LineWidth',3) % psychtoolbox
    hold on
    plot(df_stim_onset,'r*') % photodiode/trigger
    df= df_SOT - df_stim_onset;

    %% Plot diffs, across experiment and histogram
    subplot(2,3,5)
    plot(df);
    title('Diff. behavior diode (exp)');
    xlabel('Trial number');
    ylabel('Time (ms)');
    subplot(2,3,6)
    hist(df)
    title('Diff. behavior diode (hist)');
    xlabel('Time (ms)');
    ylabel('Count');

    %flag large difference
    if ~all(abs(df)<.1)
        warning('behavioral data and photodiod mismatch')
        %     prompt = ['behavioral data and photodiod mismatch. Accept it? (y or n):'] ;
        %     ID = input(prompt,'s');
        %     if strcmp(ID, 'y')
        %     else
        %        error('Mismatch not accepted.')
        %     end
    end

    %flag large difference in timing
    if all(mean(df)>1)
        warning('delay between photodiode & psychtoolbox is greater than 1 ms!!')
        prompt = ['There is a problematic delay! Accept it? (y or n):'] ;
        ID = input(prompt,'s');
        if strcmp(ID, 'y')
        else
            error('Mismatch not accepted.')
        end
    end

    %% Updating the events with onsets
    if ismember('nstim',colnames)
        nstim = trialinfo.nstim;
    else
        if exist('n_stim_per_trial')
            trialinfo.nstim = repmat(n_stim_per_trial, size(trialinfo,1), 1);
        else
            trialinfo.nstim = repmat(size(trialinfo.allonsets,2),size(trialinfo.allonsets,1),1);
        end
    end

    trialinfo.allonsets(event_trials,:) = all_stim_onset;
    trialinfo.RT_lock = nan(ntrials,1);
    for ti = 1:size(trialinfo,1)
        trialinfo.RT_lock(ti) = trialinfo.RT(ti) + trialinfo.allonsets(ti,trialinfo.nstim(ti));
    end
    trialinfo.allonsets(rest_trials,:) = (trialinfo.StimulusOnsetTime(rest_trials,:)-trialinfo.StimulusOnsetTime(rest_trials-1,:))+trialinfo.allonsets(rest_trials-1,:);


    %% Exception for when only the first onset is detected in calculia.
    % if strcmp(bn,
    %
    % else
    % end

    %% Account for when recording started in the middle of photodiode signal
    if trialinfo.allonsets(1) == 0
        warning('First trial excluded, since recording started in the middle of the photidiode signal')
    else
    end
    trialinfo = trialinfo(trialinfo.allonsets(:,1) ~= 0,:);


    %% Update trialinfo
    disp('updating trialinfo')
    save(fullfile(dirs.origSbj,bn,['trialinfo_' bn '.mat']), 'trialinfo');

    if saveFig
        fn = fullfile(dirs.origSbj,bn,[sbj '_' bn '.png']);
        exportgraphics(hf,fn);
        close all; clear hf;
    end
end


%%
function [skip_onset, skip_offset] = find_skip_lfn(diod, thresh_dur, samp_rate)
%   If the default skip pulses are incorrect, find the right number.
%   -----------------------------------------
%   =^._.^=     Su Liu
%
%   suliu@standord.edu
%   -----------------------------------------


diod = diod/max(diod);
tmp = zeros(length(diod),1);
tmp(diod>0.3) = 1;

xx = diff(tmp);
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