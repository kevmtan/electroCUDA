function [EEG,removed_channels] = ec_ASR(EEG,o)
% All-in-one function for artifact removal, including ASR.
% [EEG,HP,BUR] = clean_artifacts(EEG, Options...)
%
% This function removes flatline channels, low-frequency drifts, noisy channels, short-time bursts
% and incompletely repaird segments from the data. Tip: Any of the core parameters can also be
% passed in as [] to use the respective default of the underlying functions, or as 'off' to disable
% it entirely.
%
% Hopefully parameter tuning should be the exception when using this function -- however, there are
% 3 parameters governing how aggressively bad channels, bursts, and irrecoverable time windows are
% being removed, plus several detail parameters that only need tuning under special circumstances.
%
% Notes:
%  * This function uses the Signal Processing toolbox for pre- and post-processing of the data
%    (removing drifts, channels and time windows); the core ASR method (clean_asr) does not require
%    this toolbox but you will need high-pass filtered data if you use it directly.
%  * By default this function will identify subsets of clean data from the given recording to
%    enhance the robustness of the ASR calibration phase to strongly contaminated data; this uses
%    the Statistics toolbox, but can be skipped/bypassed if needed (see documentation).
%
% In:
%   EEG : Raw continuous EEG recording to clean up (as EEGLAB dataset structure).
%
%
%   NOTE: The following parameters are the core parameters of the cleaning procedure; they should be
%   passed in as Name-Value Pairs. If the method removes too many (or too few) channels, time
%   windows, or general high-amplitude ("burst") artifacts, you will want to tune these values.
%   Hopefully you only need to do this in rare cases.
%
%   ChannelCriterion : Minimum channel correlation. If a channel is correlated at less than this
%                      value to an estimate based on other channels, it is considered abnormal in
%                      the given time window. This method requires that channel locations are
%                      available and roughly correct; otherwise a fallback criterion will be used.
%                      (default: 0.85)
%
%   LineNoiseCriterion : If a channel has more line noise relative to its signal than this value, in
%                        standard deviations based on the total channel population, it is considered
%                        abnormal. (default: 4)
%
%   BurstCriterion : Standard deviation cutoff for removal of bursts (via ASR). Data portions whose
%                    variance is larger than this threshold relative to the calibration data are
%                    considered missing data and will be removed. The most aggressive value that can
%                    be used without losing much EEG is 3. For new users it is recommended to at
%                    first visually inspect the difference between the original and cleaned data to
%                    get a sense of the removed content at various levels. An agressive value is 5
%                    and a quite conservative value is 20. Default: 5 (from the GUI, default is 20).
%
%   WindowCriterion : Criterion for removing time windows that were not repaired completely. This may
%                     happen if the artifact in a window was composed of too many simultaneous
%                     uncorrelated sources (for example, extreme movements such as jumps). This is
%                     the maximum fraction of contaminated channels that are tolerated in the final
%                     output data for each considered window. Generally a lower value makes the
%                     criterion more aggressive. Default: 0.25. Reasonable range: 0.05 (very
%                     aggressive) to 0.3 (very lax).
%
%   Highpass : Transition band for the initial high-pass filter in Hz. This is formatted as
%              [transition-start, transition-end]. Default: [0.25 0.75].
%
%   NOTE: The following are detail parameters that may be tuned if one of the criteria does
%   not seem to be doing the right thing. These basically amount to side assumptions about the
%   data that usually do not change much across recordings, but sometimes do.
%
%   ChannelCriterionMaxBadTime : This is the maximum tolerated fraction of the recording duration
%                                during which a channel may be flagged as "bad" without being
%                                removed altogether. Generally a lower (shorter) value makes the
%                                criterion more aggresive. Reasonable range: 0.15 (very aggressive)
%                                to 0.6 (very lax). Default: 0.5.
%
%   BurstCriterionRefMaxBadChns: If a number is passed in here, the ASR method will be calibrated based
%                                on sufficiently clean data that is extracted first from the
%                                recording that is then processed with ASR. This number is the
%                                maximum tolerated fraction of "bad" channels within a given time
%                                window of the recording that is considered acceptable for use as
%                                calibration data. Any data windows within the tolerance range are
%                                then used for calibrating the threshold statistics. Instead of a
%                                number one may also directly pass in a data set that contains
%                                calibration data (for example a minute of resting EEG).
%
%                                If this is set to 'off', all data is used for calibration. This will
%                                work as long as the fraction of contaminated data is lower than the
%                                the breakdown point of the robust statistics in the ASR
%                                calibration (50%, where 30% of clearly recognizable artifacts is a
%                                better estimate of the practical breakdown point).
%
%                                A lower value makes this criterion more aggressive. Reasonable
%                                range: 0.05 (very aggressive) to 0.3 (quite lax). If you have lots
%                                of little glitches in a few channels that don't get entirely
%                                cleaned you might want to reduce this number so that they don't go
%                                into the calibration data. Default: 0.075.
%
%   BurstCriterionRefTolerances : These are the power tolerances outside of which a channel in a
%                                 given time window is considered "bad", in standard deviations
%                                 relative to a robust EEG power distribution (lower and upper
%                                 bound). Together with the previous parameter this determines how
%                                 ASR calibration data is be extracted from a recording. Can also be
%                                 specified as 'off' to achieve the same effect as in the previous
%                                 parameter. Default: [-Inf 5.5].
%
%   BurstRejection : 'on' or 'off'. If 'on' reject portions of data containing burst instead of
%                    correcting them using ASR. Default is 'off'.
%
%   WindowCriterionTolerances : These are the power tolerances outside of which a channel in the final
%                               output data is considered "bad", in standard deviations relative
%                               to a robust EEG power distribution (lower and upper bound). Any time
%                               window in the final (repaired) output which has more than the
%                               tolerated fraction (set by the WindowCriterion parameter) of channel
%                               with a power outside of this range will be considered incompletely
%                               repaired and will be removed from the output. This last stage can be
%                               skipped either by setting the WindowCriterion to 'off' or by taking
%                               the third output of this processing function (which does not include
%                               the last stage). Default: [-Inf 7].
%
%   FlatlineCriterion : Maximum tolerated flatline duration. In seconds. If a channel has a longer
%                       flatline than this, it will be considered abnormal. Default: 5
%
%   NoLocsChannelCriterion : Criterion for removing bad channels when no channel locations are
%                            present. This is a minimum correlation value that a given channel must
%                            have w.r.t. a fraction of other channels. A higher value makes the
%                            criterion more aggressive. Reasonable range: 0.4 (very lax) - 0.6
%                            (quite aggressive). Default: 0.45.
%
%   NoLocsChannelCriterionExcluded : The fraction of channels that must be sufficiently correlated with
%                                    a given channel for it to be considered "good" in a given time
%                                    window. Applies only to the NoLocsChannelCriterion. This adds
%                                    robustness against pairs of channels that are shorted or other
%                                    that are disconnected but record the same noise process.
%                                    Reasonable range: 0.1 (fairly lax) to 0.3 (very aggressive);
%                                    note that increasing this value requires the ChannelCriterion
%                                    to be relaxed in order to maintain the same overall amount of
%                                    removed channels. Default: 0.1.
%
%   MaxMem : The maximum amount of memory in MB used by the algorithm when processing.
%            See function asr_process for more information. Default is 64.
%
% Out:
%   EEG : Final cleaned EEG recording.
%
%   HP : Optionally just the high-pass filtered data.
%
%   BUR : Optionally the data without final removal of "irrecoverable" windows.
%
% Examples:
%   % Load a recording, clean it, and visualize the difference (using the defaults)
%   raw = pop_loadset(...);
%   clean = clean_artifacts(raw);
%   vis_artifacts(clean,raw);
%
%   % Use a more aggressive threshold (passing the parameters in by position)
%   raw = pop_loadset(...);
%   clean = clean_artifacts(raw,[],2.5);
%   vis_artifacts(clean,raw);
%
%   % Passing some parameter by name (here making the WindowCriterion setting less picky)
%   raw = pop_loadset(...);
%   clean = clean_artifacts(raw,'WindowCriterion',0.25);
%
%   % Disabling the WindowCriterion and ChannelCriterion altogether
%   raw = pop_loadset(...);
%   clean = clean_artifacts(raw,'WindowCriterion','off','ChannelCriterion','off');
%
%
%                                Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                                2012-09-04
% Copyright (C) Christian Kothe, SCCN, 2012, ckothe@ucsd.edu
%
% This program is free software; you can redistribute it and/or modify it under the terms of the GNU
% General Public License as published by the Free Software Foundation; either version 2 of the
% License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
% even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License along with this program; if not,
% write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
% USA
% hlp_varargin2struct(varargin,...
%     {'o.chCorr','ChannelCorrelationCriterion','ChannelCriterion'}, 0.8, ...
%     {'o.line','LineNoiseCriterion'}, 4, ...
%     {'o.burst','BurstCriterion'}, 5, ...
%     {'fusechanrej','Fusechanrej'}, [], ... % unused in this function
%     {'channels','Channels'}, [], ...
%     {'o.chIgnore','Channels_ignore'}, [], ...
%     {'o.win','WindowCriterion'}, 0.25, ...
%     {'o.numSamples','NumSamples'}, 50, ...
%     {'o.hiPass','Highpass'}, [0.25 0.75], ...
%     {'o.chMaxBadTime','ChannelCriterionMaxBadTime'}, 0.5, ...
%     {'o.burstMaxBadChs','BurstCriterionRefMaxBadChns'}, 0.075, ...
%     {'o.burstTols','BurstCriterionRefTolerances'}, [-inf 5.5], ...
%     {'o.dist','Distance'}, 'euclidian', ...
%     {'o.winTols','WindowCriterionTolerances'},[-inf 7], ...
%     {'o.burstRej','BurstRejection'},'off', ...
%     {'o.noLocs','NoLocsChannelCriterion'}, 0.45, ...
%     {'o.noLocsExcluded','NoLocsChannelCriterionExcluded'}, 0.1, ...
%     {'o.maxMem','MaxMem'}, 64, ...
%     {'o.ramGB','o.ramGB'}, NaN, ...
%     {'o.flat','FlatlineCriterion'}, 5);
arguments
    EEG struct
    o.hiPass = [0.25 0.75]
    o.flat = 5 % Flatline criterion
    o.chCorr = 0.8 % Channel (correlation) criterion
    o.chMaxBadTime = 0.5
    o.noLocs = 0.45 % NoLocsChannelCriterion 
    o.noLocsExcluded  % NoLocsChannelCriterionExcluded
    o.line  = 4 % LineNoiseCriterion
    o.burst = 5 % BurstCriterion
    o.burstRej {mustBeMember(o.burstRej,["on" "off"])} = 'off'
    o.burstMaxBadChs = 0.075
    o.burstTols = [-inf 5.5]
    o.win = 0.25 % Window criterion
    o.winTols = [-inf 7]
    o.dist {mustBeMember(o.dist,["riemannian" "euclidian"])} = 'euclidian'
    o.maxMem = [] %ec_ramAvail;
    o.chInclude = []
    o.chIgnore = []
    o.numSamples = 50
    o.gpu = false
end
if o.gpu; try reset(gpuDevice(1)); catch;end;end

% ignore some channels
if ~isempty(o.chInclude)
    if ~isempty(o.chIgnore)
        error('Can include or ignore channel but not both at the same time')
    end
    if ~iscell(o.chInclude)
        error('Cannot exclude channels without channel labels')
    end
    %EEGog = EEG;
    EEG = pop_select(EEG, 'channel', o.chInclude);
    %EEG.event = []; % will be added back later
end
if ~isempty(o.chIgnore)
    if ~iscell(o.chIgnore)
        error('Cannot exclude channels without channel labels')
    end
    %EEGog = EEG;
    EEG = pop_select(EEG, 'nochannel', o.chIgnore);
    %EEG.event = []; % will be added back later
end


% high-pass filter the data
if ~strcmp(o.hiPass,'off')
    disp('Applying highpass filter...')
    EEG = clean_drifts(EEG,o.hiPass);
end
% if nargout > 1
%     HP = EEG;
% end

% remove flat-line channels
if ~strcmp(o.flat,'off')
    disp('Detecting flat line...')
    EEG = clean_flatlines(EEG,o.flat);
end


% remove noisy channels by correlation and line-noise thresholds
if ~strcmp(o.chCorr,'off') || ~strcmp(o.line,'off') 
    if strcmp(o.chCorr,'off')
        o.chCorr = 0; end
    if strcmp(o.line,'off')
        o.line = 100; end
    try
        [EEG,removed_channels] = clean_channels(EEG,o.chCorr,o.line,[],o.chMaxBadTime, o.numSamples);
    catch ME; getReport(ME)
        %         if strcmp(e.identifier,'clean_channels:bad_chanlocs')
        disp('Your dataset appears to lack correct channel locations; using a location-free channel cleaning method.');
        [EEG,removed_channels] = clean_channels_nolocs(EEG,o.noLocs,o.noLocsExcluded,[],o.chMaxBadTime);
        %         else
        %             rethrow(e);
        %         end
    end
end

% repair bursts by ASR
if ~strcmp(o.burst,'off')
    if ~strcmpi(o.dist, 'euclidian')
        BUR = clean_asr(EEG,o.burst,[],[],[],o.burstMaxBadChs,o.burstTols,[], o.gpu, true, o.maxMem);
    else
        BUR = clean_asr(EEG,o.burst,[],[],[],o.burstMaxBadChs,o.burstTols,[], o.gpu, false, o.maxMem);
    end

    if strcmp(o.burstRej,'on')
        % portion of data which have changed
        sample_mask = sum(abs(EEG.data-BUR.data),1) < 1e-10;

        % find latency of regions
        retain_data_intervals = reshape(find(diff([false sample_mask false])),2,[])';
        retain_data_intervals(:,2) = retain_data_intervals(:,2)-1;

        % reject regions
        EEG = pop_select(EEG, 'point', retain_data_intervals);
        EEG.etc.clean_sample_mask = sample_mask;
    else
        EEG = BUR;
    end
end
% if nargout > 2
%     BUR = EEG;
% end

% remove irrecoverable time windows based on power
if ~strcmp(o.win,'off') && ~strcmp(o.winTols,'off')
    disp('Now doing final post-cleanup of the output.');
    EEG = clean_windows(EEG,o.win,o.winTols);
end
disp('Use vis_artifacts to compare the cleaned data to the original.');

% add back original channels
if 0 %~isempty(o.chInclude) || ~isempty(o.chIgnore)
    % Apply same transformation to the data before removal of channels and data
    EEG = eeg_checkset(EEG, 'eventconsistency'); %#ok<UNRCH> 
    if ~isempty(EEG.event) && isfield(EEG.event, 'type') && ischar(EEG.event(1).type)
        disp('Adding back removed channels');
        eventTypes = string(extractfield(EEG.event,'type'))';
        boundaryEvents = find(eventTypes=="boundary");

        % remove again data portions
        if ~isempty(boundaryEvents)
            boundloc = [ EEG.event(boundaryEvents).latency ];
            dur      = [ EEG.event(boundaryEvents).duration ];
            cumdur   = cumsum(dur);
            boundloc = boundloc + [0 cumdur(1:end-1) ];
            boundloc = [ boundloc; boundloc+dur-1]';
            EEGog = eeg_eegrej(EEGog, ceil(boundloc));
        end

        % copy clean data to oriEEG (in case data was corrected
        [~,chanInds1, chanInds2] = intersect({ EEGog.chanlocs.labels }, { EEG.chanlocs.labels });
        if size(EEGog.data,2) ~= size(EEG.data,2)
            error('Issue with adding back removed channels. Remove channels, then remove bad portions of data.');
        end
        EEGog.data(chanInds1,:) = EEG.data(chanInds2,:);
        EEGog.pnts = EEG.pnts;

        EEG = EEGog;
    end
end

if o.gpu; try reset(gpuDevice(1)); catch;end;end
end




%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% Find flat channels
function signal = findFlatlines_lfn(signal,max_flatline_duration,max_allowed_jitter)
% Remove (near-) flat-lined channels.
% Signal = clean_flatlines(Signal,MaxFlatlineDuration,MaxAllowedJitter)
%
% This is an automated artifact rejection function which ensures that
% the data contains no flat-lined channels.
%
% In:
%   Signal : continuous data set, assumed to be appropriately high-passed (e.g. >0.5Hz or
%            with a 0.5Hz - 2.0Hz transition band)
%
%   MaxFlatlineDuration : Maximum tolerated flatline duration. In seconds. If a channel has a longer
%                         flatline than this, it will be considered abnormal. Default: 5
%
%   MaxAllowedJitter : Maximum tolerated jitter during flatlines. As a multiple of epsilon.
%                      Default: 20
%
% Out:
%   Signal : data set with flat channels removed
%
% Examples:
%   % use with defaults
%   eeg = clean_flatlines(eeg);
%
%                                Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                                2012-08-30

% Copyright (C) Christian Kothe, SCCN, 2012, ckothe@ucsd.edu
%
% This program is free software; you can redistribute it and/or modify it under the terms of the GNU
% General Public License as published by the Free Software Foundation; either version 2 of the
% License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
% even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License along with this program; if not,
% write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
% USA

if ~exist('max_flatline_duration','var') || isempty(max_flatline_duration); max_flatline_duration = 5; end
if ~exist('max_allowed_jitter','var') || isempty(max_allowed_jitter); max_allowed_jitter = 20; end

% flag channels
removed_channels = false(1,signal.nbchan);
for c=1:signal.nbchan
    zero_intervals = reshape(find(diff([false abs(diff(signal.data(c,:)))<(max_allowed_jitter*eps) false])),2,[])';
    if max(zero_intervals(:,2) - zero_intervals(:,1)) > max_flatline_duration*signal.srate
        removed_channels(c) = true; end
end

% Marking
if all(removed_channels)
    disp('Warning: all channels have a flat-line portion');
elseif any(removed_channels)
    disp('Marking flat-line channels...');
    if isfield(signal.etc,'clean_channel_mask')
        signal.etc.clean_channel_mask(signal.etc.clean_channel_mask) = ~removed_channels;
    else
        signal.etc.clean_channel_mask = ~removed_channels;
    end
    signal.chNfo.bad.flat = removed_channels';
end
end


%%
function signal = hpf_lfn(signal,transition,attenuation)
% Removes drifts from the data using a forward-backward high-pass filter.
% Signal = clean_drifts(Signal,Transition)
%
% This removes drifts from the data using a forward-backward (non-causal) filter.
% NOTE: If you are doing directed information flow analysis, do no use this filter but some other one.
%
% In:
%   Signal : the continuous data to filter
%
%   Transition : the transition band in Hz, i.e. lower and upper edge of the transition
%                (default: [0.5 1])
%
%   Attenuation : stop-band attenuation, in db (default: 80)
%
% Out:
%   Signal : the filtered signal
%
% Notes:
%   This function requires the Signal Processing toolbox.
%
%                                Christian Kothe, Swartz Center for Computational Neuroscience, UCSD
%                                2012-09-01

% Copyright (C) Christian Kothe, SCCN, 2012, ckothe@ucsd.edu
%
% This program is free software; you can redistribute it and/or modify it under the terms of the GNU
% General Public License as published by the Free Software Foundation; either version 2 of the
% License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
% even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License along with this program; if not,
% write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
% USA

if ~exist('transition','var') || isempty(transition); transition = [0.5 1]; end
if ~exist('attenuation','var') || isempty(attenuation); attenuation = 80; end
signal.data = double(signal.data);

% design highpass FIR filter
transition = 2*transition/signal.srate;
wnd = design_kaiser(transition(1),transition(2),attenuation,true);
B = design_fir(length(wnd)-1,[0 transition 1],[0 0 1 1],[],wnd);

% apply it, channel by channel to save memory
signal.data = signal.data';
for c=1:signal.nbchan
    signal.data(:,c) = filtfilt_fast(B,1,signal.data(:,c)); end
signal.data = signal.data';
signal.etc.clean_drifts_kernel = B;
end
