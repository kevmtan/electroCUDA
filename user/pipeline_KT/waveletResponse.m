fb = cwtfilterbank(Wavelet="Morse",SamplingFrequency=1000,SignalLength=10000,...
    VoicesPerOctave=5,FrequencyLimits=[2 300],TimeBandwidth=20);
frqs = fb.centerFrequencies; % CWT frequencies
scales = fb.scales; % CWT scales
spsi = waveletsupport(fb);

%%
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

%%

% freq=[13 300], tbw=60
% freq=[7.6 13], tbw=30
% freq=[5.38 7.6], tbw=20
% freq=[2 5.38], tbw=15