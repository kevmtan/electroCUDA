function [EEG,lineNoise] = ec_cleanline(varargin)

% Mandatory             Information
% --------------------------------------------------------------------------------------------------
% EEG                   EEGLAB data structure
% --------------------------------------------------------------------------------------------------
%
% Optional              Information
% --------------------------------------------------------------------------------------------------
% LineFrequencies:      Line noise frequencies to remove
%                       Input Range  : Unrestricted
%                       Default value: 60
%                       Input Data Type: real number (double)
%
% ScanForLines:         Scan for line noise
%                       This will scan for the exact line frequency in a narrow range around the specified LineFrequencies
%                       Input Range  : Unrestricted
%                       Default value: 1
%                       Input Data Type: boolean
%
% LineAlpha:            p-value for detection of significant sinusoid
%                       Input Range  : [0  1]
%                       Default value: 0.01
%                       Input Data Type: real number (double)
%
% Bandwidth:            Bandwidth (Hz)
%                       This is the width of a spectral peak for a sinusoid at fixed frequency. As such, this defines the
%                       multi-taper frequency resolution.
%                       Input Range  : Unrestricted
%                       Default value: 1
%                       Input Data Type: real number (double)
%
% SignalType:          Type of signal to clean
%                       Cleaned ICA components will be backprojected to channels. If channels are cleaned, ICA activations
%                       are reconstructed based on clean channels.
%                       Possible values: 'Components','Channels'
%                       Default value  : 'Components'
%                       Input Data Type: string
%
% ChanCompIndices:      IDs of Chans/Comps to clean
%                       Input Range  : Unrestricted
%                       Default value: 1:152
%                       Input Data Type: any evaluable Matlab expression.
%
% SlidingWinLength:     Sliding window length (sec)
%                       Default is the epoch length.
%                       Input Range  : [0  4]
%                       Default value: 4
%                       Input Data Type: real number (double)
%
% SlidingWinStep:       Sliding window step size (sec)
%                       This determines the amount of overlap between sliding windows. Default is window length (no
%                       overlap).
%                       Input Range  : [0  4]
%                       Default value: 4
%                       Input Data Type: real number (double)
%
% SmoothingFactor:      Window overlap smoothing factor
%                       A value of 1 means (nearly) linear smoothing between adjacent sliding windows. A value of Inf means
%                       no smoothing. Intermediate values produce sigmoidal smoothing between adjacent windows.
%                       Input Range  : [1  Inf]
%                       Default value: 100
%                       Input Data Type: real number (double)
%
% PaddingFactor:        FFT padding factor
%                       Signal will be zero-padded to the desired power of two greater than the sliding window length. The
%                       formula is NFFT = 2^nextpow2(SlidingWinLen*(PadFactor+1)). e.g. For SlidingWinLen = 500, if PadFactor = -1, we
%                       do not pad; if PadFactor = 0, we pad the FFT to 512 points, if PadFactor=1, we pad to 1024 points etc.
%                       Input Range  : [-1  Inf]
%                       Default value: 2
%                       Input Data Type: real number (double)
%
% ComputeSpectralPower: Visualize Original and Cleaned Spectra
%                       Original and clean spectral power will be computed and visualized at end
%                       Input Range  : Unrestricted
%                       Default value: true
%                       Input Data Type: boolean
%
% NormalizeSpectrum:    Normalize log spectrum by detrending (not generally recommended)
%                       Input Range  : Unrestricted
%                       Default value: 0
%                       Input Data Type: boolean
%
% VerboseOutput:        Produce verbose output
%                       Input Range  : [true false]
%                       Default value: true
%                       Input Data Type: boolean
%
% PlotFigures:          Plot Individual Figures
%                       This will generate figures of F-statistic, spectrum, etc for each channel/comp while processing
%                       Input Range  : Unrestricted
%                       Default value: 0
%                       Input Data Type: boolean
%
% --------------------------------------------------------------------------------------------------
% Output                Information
% --------------------------------------------------------------------------------------------------
% EEG                   Cleaned EEG dataset
% Sorig                 Original multitaper spectrum for each component/channel
% Sclean                Cleaned multitaper spectrum for each component/channel
% f                     Frequencies at which spectrum is estimated in Sorig, Sclean
% amps                  Complex amplitudes of sinusoidal lines for each
%                       window (line time-series for window i can be
%                       reconstructed by creating a sinudoid with frequency f{i} and complex
%                       amplitude amps{i})
% freqs                 Exact frequencies at which lines were removed for
%                       each window (cell array)
% g                     Parameter structure. Function call can be
%                       replicated exactly by calling >> cleanline(EEG,g);
%
% Usage Example:
% EEG = pop_cleanline(EEG, 'Bandwidth',2,'ChanCompIndices',[1:EEG.nbchan],                  ...
%                          'SignalType','Channels','ComputeSpectralPower',true,             ...
%                          'LineFrequencies',[60 120] ,'NormalizeSpectrum',false,           ...
%                          'LineAlpha',0.01,'PaddingFactor',2,'PlotFigures',false,          ...
%                          'ScanForLines',true,'SmoothingFactor',100,'VerboseOutput',1,    ...
%                          'SlidingWinLength',EEG.pnts/EEG.srate,'SlidingWinStep',EEG.pnts/EEG.srate);
%
% See Also:
% pop_cleanline()

% Author: Tim Mullen, SCCN/INC/UCSD Copyright (C) 2011
% Date:   Nov 20, 2011
%
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.c
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
tic;
doGPU = false;

EEG = arg_extract(varargin,'EEG',[],[]);

if isempty(EEG)
    EEG = eeg_emptyset;
end

if ~isempty(EEG.icawinv)
    defSigType = {'Components','Channels'};
else
    defSigType = {'Channels'};
end

g = arg_define([0 1], varargin, ...
    arg_norep('EEG',mandatory), ...
    arg({'linefreqs','LineFrequencies'}, 60, [],'Line noise frequencies to remove.'),...
    arg({'scanforlines','ScanForLines'},false,[],'Scan for line noise. This will scan for the exact line frequency in a narrow range around the specified LineFrequencies'),...
    arg({'p','LineAlpha','alpha'},0.01,[0 1],'p-value for detection of significant sinusoid'), ...
    arg({'bandwidth','Bandwidth'},2,[],'Bandwidth (Hz). This is the width of a spectral peak for a sinusoid at fixed frequency. As such, this defines the multi-taper frequency resolution.'), ...
    arg({'sigtype','SignalType','chantype'},defSigType{1},defSigType,'Type of signal to clean. Cleaned ICA components will be backprojected to channels. If channels are cleaned, ICA activations are reconstructed based on clean channels.'), ...
    arg({'chanlist','ChanCompIndices','ChanComps'},sprintf('1:%d',EEG.nbchan),[1 EEG.nbchan],'Indices of Channels/Components to clean.','type','expression'),...
    arg({'taperbandwidth','TaperBandWidth'},2,[0 Inf],'Taper bandwidth'), ...
    arg({'winsize','SlidingWinLength'},fastif(EEG.trials==1,4,EEG.pnts/EEG.srate),[0 EEG.pnts/EEG.srate],'Sliding window length (sec). Default for epoched data is the epoch length. Default for continuous data is 4 seconds'), ...
    arg({'winstep','SlidingWinStep'},fastif(EEG.trials==1,1,EEG.pnts/EEG.srate),[0 EEG.pnts/EEG.srate],'Sliding window step size (sec). This determines the amount of overlap between sliding windows. Default for epoched data is window length (no overlap). Default for continuous data is 1 second.'), ...
    arg({'tau','SmoothingFactor'},100,[1 Inf],'Window overlap smoothing factor. A value of 1 means (nearly) linear smoothing between adjacent sliding windows. A value of Inf means no smoothing. Intermediate values produce sigmoidal smoothing between adjacent windows.'), ...
    arg({'pad','PaddingFactor'},2,[-1 Inf],'FFT padding factor. Signal will be zero-padded to the desired power of two greater than the sliding window length. The formula is NFFT = 2^nextpow2(SlidingWinLen*(PadFactor+1)). e.g. For N = 500, if PadFactor = -1, we do not pad; if PadFactor = 0, we pad the FFT to 512 points, if PadFactor=1, we pad to 1024 points etc.'), ...
    arg({'computepower','ComputeSpectralPower'},true,[],'Visualize Original and Cleaned Spectra. Original and clean spectral power will be computed and visualized at end'),  ...
    arg({'normSpectrum','NormalizeSpectrum'},false,[],'Normalize log spectrum by detrending. Not generally recommended.'), ...
    arg({'verb','VerboseOutput','VerbosityLevel'},true,[],'Produce verbose output.'), ...
    arg({'plotfigures','PlotFigures'},false,[],'Plot Individual Figures. This will generate figures of F-statistic, spectrum, etc for each channel/comp while processing'), ...
    arg({'newversion','Newversion'},false,[],'Use new implementation (send us feedback)'),...
    arg({'iter'},10,[]));

if any(g.chanlist > fastif(strcmpi(g.sigtype,'channels'),EEG.nbchan,size(EEG.icawinv,1)))
    error('''ChanCompIndices'' contains indices of channels or components that are not present in the dataset!');
end

arg_toworkspace(g);

% if ~g.newversion
%     disp('Warning: staper bandwidth option not relevant for legacy original version');
% else
%     % Fix proposed by Kay

% Warning
if g.normSpectrum
    disp('Warning: spectrum normalization ignored; use legacy original version for this option');
end
if g.plotfigures
    disp('Warning: plotting option ignored; use legacy original version for this option');
end
if g.scanforlines
    disp('Warning: scan for lines option ignored; use legacy original version for this option');
end

% default line noise fields
lineNoise = struct('lineNoiseMethod', 'clean', ...
    'lineNoiseChannels', g.chanlist,...
    'Fs', EEG.srate, ...
    'lineFrequencies', g.linefreqs,...
    'p', g.p, ...
    'fScanBandWidth', g.bandwidth, ...
    'taperBandWidth', g.taperbandwidth, ...
    'taperWindowSize', g.winsize, ...
    'taperWindowStep', g.winstep, ...
    'tau', g.tau, ...
    'pad', g.pad, ...
    'fPassBand', [0 EEG.srate/2], ...
    'maximumIterations', g.iter);

% change default based on g
if isfield(g, 'sigtype') && strcmpi(g.sigtype, 'Components')
    error('Cannot use components - check the box to use the legacy original version to use components');
end

% Set default values if field not already set
if length(lineNoise.lineFrequencies) == 1
    lf = lineNoise.lineFrequencies;
    lineNoise.lineFrequencies = [lf 2*lf 3*lf 4*lf 5*lf];
end
rmFreq = find(lineNoise.lineFrequencies > EEG.srate/2);
lineNoise.lineFrequencies(rmFreq) = [];

% clean data
disp("Running cleanLineNoise (new version of cleanline)...");
[EEG,lineNoise] = cleanLineNoise_lfn(EEG,lineNoise,doGPU);
disp("[cleanline] Finished in "+toc/60+"min");





%% Cleanline across chans %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [signal, lineNoise] = cleanLineNoise_lfn(signal,lineNoise,doGPU)
% Remove sharp spectral peaks from signal using Sleppian filters
%
% Usage:
% signal = cleanLineNoise(signal)
% [signal, lineNoiseOut] = hcleanLineNoise(signal, lineNoiseIn)
%
% Parameters:
%    signal          Structure with .data and .srate fields
%    lineNoiseIn     Input structure with fields described below
%
% Structure parameters (lineNoiseIn):
%    fPassBand       Frequency band used (default [0, Fs/2] = entire band)
%    Fs 	            Sampling frequency
%    fScanBandWidth  +/- bandwidth centered on each f0 to scan for significant
%                       lines (TM)
%    lineFrequencies Line frequencies to be removed (default
%                       [60, 120, 180, 240, 300])
%    lineNoiseChannels  Channels to remove line noise from (default
%                       size(data, 1))
%    maximumIterations   Maximum times to iterate removal (default = 10)
%    p               Significance level cutoff (default = 0.01)
%    pad             FFT padding factor ( -1 corresponds to no padding,
%                       0 corresponds to padding to next highest power of 2
%                       etc.) (default is 0)
%    pnts
%    tapers          Precomputed tapers from dpss
%    taperBandWidth  Taper bandwidth (default 2 Hz)
%    taperWindowSize Taper sliding window length (default 4 sec)
%    taperWindowStep Sliding window step size (default 4 sec = no overlap)
%    tau             Window overlap smoothing factor (default 100)
%
% This function is based on code originally written by Tim Mullen in a
% package called tmullen-cleanline which is based on the chronux_2
% libraries.
%

%% Remove line frequencies that are greater than Nyquist frequencies
tooLarge = lineNoise.lineFrequencies >= lineNoise.Fs/2;
if any(tooLarge)
    warning('cleanLineNoise:LineFrequenciesTooLarge', ...
        'Eliminating frequencies greater than half the sampling rate');
    lineNoise.lineFrequencies(tooLarge) = [];
    lineNoise.lineFrequencies = squeeze(lineNoise.lineFrequencies);
end

%% Set up multi-taper parameters
hbw = lineNoise.taperBandWidth/2;   % half-bandwidthc
lineNoise.taperTemplate = [hbw, lineNoise.taperWindowSize, 1];
Nwin = round(lineNoise.Fs*lineNoise.taperWindowSize); % number of samples in window
lineNoise.tapers = checkTapers(lineNoise.taperTemplate, Nwin, lineNoise.Fs);

%% Perform the calculation for each channel separately
signal = double(signal.data)';
if doGPU
    reset(gpuDevice());
    signal = num2cell(signal,1);
    signal = arrayfun(@(x) gpuArray(x{:}),signal,UniformOutput=false);
    signal = arrayfun(@(x) rmLinesMovingWin_lfn(x{:},lineNoise),signal,UniformOutput=false);
    signal = gather(horzcat(signal{:}));
else
    parfor ch = 1:size(signal,2)
        signal(:,ch) = rmLinesMovingWin_lfn(signal(:,ch),lineNoise);
    end
end




%% Cleanline on single chan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function data = rmLinesMovingWin_lfn(data,lineNoise)
% Removes significant sine waves from (continuous) data using overlapping windows.
%
% Usage:
%    data = removeLinesMovingWindow(data, lineNoise)
%
% Parameters
%       data        data in [N,1] (a single time column vector)
%       lineNoise   structure with various parameters set
%
% The lineNoise structure has the following fields set:
%       fPassBand       Frequency band used
%       Fs 	            Sampling frequency
%       fScanBandWidth  +/- bandwidth centered on each f0 to scan for significant
%                       lines (TM)
%       lineFrequencies Line frequencies to be removed
%       maximumIterations   Maximum times to iterate removal
%       p               Significance level cutoff
%       pad             FFT padding factor
%       tapers          Precomputed tapers from dpss
%       taperWindowSize Taper sliding window length (seconds)
%       taperWindowStep Sliding window step size (seconds)
%       tau             Window overlap smoothing factor
%
% Output:
%       data           Cleaned up data
%

Fs = getStructureParameters(lineNoise, 'Fs');
tau = getStructureParameters(lineNoise, 'tau');

% Window,overlap and frequency information
N = size(data, 1);
Nwin = round(Fs*lineNoise.taperWindowSize); % number of samples in window
Nstep = round(lineNoise.taperWindowStep*Fs); % number of samples to step through
Noverlap = Nwin - Nstep; % number of points in overlap
x = (1:Noverlap)';
smooth = 1./(1+exp(-tau.*(x - Noverlap/2)/Noverlap)); % sigmoidal function
winstart = 1:Nstep:(N - Nwin + 1);
nw = length(winstart);
datafit = zeros(winstart(nw) + Nwin - 1,1);

fidx = zeros(length(lineNoise.lineFrequencies),1);
f0 = lineNoise.lineFrequencies;
[initialSpectrum, f] = calculateSegmentSpectrum(data, lineNoise);
initialSpectrum = 10*log10(initialSpectrum);
for fk = 1:length(lineNoise.lineFrequencies)
    [~, fidx(fk)] = min(abs(f - lineNoise.lineFrequencies(fk)));
end

for iteration = 1:lineNoise.maximumIterations
    f0Mask = false(1, length(f0));
    for n = 1:nw
        idx = winstart(n):(winstart(n) + Nwin - 1);
        datawin = data(idx);
        [datawin, f0Sig] = ...
            fitSignificantFrequencies(datawin, f0, lineNoise);

        f0Mask = f0Mask | f0Sig;
        % datafitwin0 = datafitwin; incorrectly placed
        if n > 1
            datawin(1:Noverlap)= smooth.*datawin(1:Noverlap) + ...
                (1 - smooth).*datafitwin0((Nwin - Noverlap + 1):Nwin);
        end
        datafit(idx, :) = datawin;
        datafitwin0 = datawin; % Moved from above the if statement
    end

    data(1:size(datafit,1)) = data(1:size(datafit, 1)) - datafit;
    if sum(f0Mask) > 0
        % Now find the line frequencies that have converged
        cleanedSpectrum = calculateSegmentSpectrum(data, lineNoise);
        cleanedSpectrum = 10*log10(cleanedSpectrum);
        dBReduction = initialSpectrum - cleanedSpectrum;
        tIndex = (dBReduction(fidx) < 0)';
        f0(tIndex | ~f0Mask) = [];
        fidx(tIndex | ~f0Mask) = [];
        initialSpectrum = cleanedSpectrum;
    end
    if isempty(f0)
        break;
    end
end