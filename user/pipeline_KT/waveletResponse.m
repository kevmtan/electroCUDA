% Generate wavelet
fb = cwtfilterbank(Wavelet="Morse",SamplingFrequency=1000,SignalLength=10000,...
    VoicesPerOctave=10,FrequencyLimits=[2 300],TimeBandwidth=20);

% Freq info
frqs = fb.waveletsupport(0.05); % time support
frqs.timeHW = frqs.TimeSupport/2;

% Energy-normalized time-domain SD for each wavelet
[psi,t] = fb.wavelets;
psi = abs(psi).^2;
psi = psi ./ sum(psi,2);                   % normalize each row to unit total energy
mu_t = sum(psi .* t, 2);               % should be ~0 since wavelets are centered
frqs.coiHW = sqrt(sum(psi .* (t - mu_t).^2, 2));

frqs.scales = fb.scales'; % scales



%%
[psi,t] = wavelets(fb);  
[fr,f] = freqz(fb);

% pick the scale closest to 4 Hz
[~,idx] = min(abs(frqs-6));
psi = psi(idx,:);
env = abs(psi);
env = env./max(env);

% FWHM of amplitude envelope
mask = env >= 0.5;
fwhm_sec = t(find(mask,1,'last')) - t(find(mask,1,'first'));
disp(fwhm_sec)

% Plot time resp
figure; 
plot(t,abs(psi))
grid on
hold on
plot(t,real(psi))
plot(t,imag(psi))

% Plot freq resp
figure;
plot(f,real(fr(idx,:)))

%%

% freq=[13 300], tbw=60
% freq=[7.6 13], tbw=30
% freq=[5.38 7.6], tbw=20
% freq=[2 5.38], tbw=15