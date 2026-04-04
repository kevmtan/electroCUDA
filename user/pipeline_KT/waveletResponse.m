fb = cwtfilterbank(Wavelet="Morse",SamplingFrequency=1000,SignalLength=1000000,...
    VoicesPerOctave=10,FrequencyLimits=[2 300],TimeBandwidth=15);
frqs = fb.centerFrequencies; % CWT frequencies
scales = fb.scales; % CWT scales

[psi,t] = wavelets(fb);  
[fr,f] = freqz(fb);

% pick the scale closest to 4 Hz
[~,idx] = min(abs(frqs-6));
w = psi(idx,:);
env = abs(w);
env = env./max(env);

% FWHM of amplitude envelope
mask = env >= 0.5;
fwhm_sec = t(find(mask,1,'last')) - t(find(mask,1,'first'));
disp(fwhm_sec)

% Plot time resp
figure; 
plot(t,abs(w))
grid on
hold on
plot(t,real(w))
plot(t,imag(w))

% Plot freq resp
figure;
plot(f,real(fr(idx,:)))