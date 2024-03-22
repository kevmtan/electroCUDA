function [wave,wave_out] = ec_wtGabor(data,fsample,fs_targ,freqs,span,norm,avgfreq)
%% DEPRECIATED!
% INPUTS
% data: EEG signal (1 x time)
% freqs (optional): vector containing frequencies at which wavelet is
%                   computed (in Hz), or string
% span (optional): span of wavelet (i.e. width of gaussian that forms
%                  wavelet, in units of cycles- specific to each
%                  frequency)
% fs_targ (optional): target sampling rate of wavelet output
% norm (optional): normalize amplitude of timecourse within each frequency
%                  band (to eliminate 1/f power drop with frequency)
% avgfreq (optional): average across frequency dimension to yield single timecourse 
%                     (e.g. for computing HFB timecourse). If set to true,
%                     only amplitude information will remain (not phase, since 
%                     cannot average phase across frequencies)

if isempty(avgfreq)
    if strcmp(freqs,'HFB')
        avgfreq = true;
    else
        avgfreq = false;
    end
end

% if using standard frequency band, e.g. 'HFB', find actual frequencies
if ischar(freqs)
    freqs = genFreqs(freqs);
end

if isempty(span)
    span = 1;
end
if isempty(norm)
    norm = true;
end

if strcmp(freqs,'HFB')
    spans = ones(numel(freqs),1)*span;  %% if HFB  use the same value
else
    spans = linspace(0.3,1.2,numel(freqs))*span; %% if spec  use linspace
end
%%

ds = round(fsample/fs_targ); % factor by which to downsample
time = (1:height(data))/fsample;
siglength_ds = length(time(1:ds:end));
wave = zeros(numel(freqs),siglength_ds);
if ~avgfreq
    wave_out.phase = zeros(numel(freqs),siglength_ds);
end
wave_out.spectrum = zeros(1,numel(freqs)); % power spectrum (before normalizing)
% Spectral data, frequencies saved separately 

%% Wavelet transform
for f = 1:numel(freqs)
    sigma = spans(f)/freqs(f);
    t = -4*sigma:1/fsample:4*sigma;
    wavelet = exp(-(t.^2)/(2*sigma^2)).*exp(1i*2*pi*freq*t);    % generate Gabor wavelet
    wave_tmp = conv(data,conj(wavelet),'same');                 % convolve signal with wavelet
    wave(f,:) = abs(wave_tmp(:,1:ds:end)).^2;                   % downsammple & calculate power
    wave_out.spectrum(f) = mean(wave(f,:));
    if ~avgfreq
        wave_out.phase(f,:) = angle(wave_tmp(:,1:ds:end)); 
    end
end


if norm
    wave = zscore(wave,[],2); % normalize across time-dimension
end
    
% HFB or another frequency band (averaging across frequencies)
if avgfreq
    wave = mean(wave,1,'omitnan');
end

wave_out.freqs = freqs;
wave_out.wavelet_span = span;
wave_out.time = time(1:ds:end);
wave_out.fsample = round(fsample/ds);

