% Generate wavelet
fb = cwtfilterbank(Wavelet="Morse",SamplingFrequency=1000,SignalLength=10000,...
    VoicesPerOctave=7,FrequencyLimits=[2 300],TimeBandwidth=20);

% Wavelet timesupport
frqs = fb.waveletsupport(0.05); % time support
frqs.timeHW = frqs.TimeSupport/2;

% Power bandwidth (3db)
bw = fb.powerbw;

% Concatenate tables
frqs = [frqs,bw];

% Scales
frqs.scale = fb.scales';

% Cone of influence: energy-normalized time-domain SD for each wavelet
[psi,t] = fb.wavelets;
psi = abs(psi).^2;
psi = psi ./ sum(psi,2);                   % normalize each row to unit total energy
mu_t = sum(psi .* t, 2);               % should be ~0 since wavelets are centered
frqs.coiHW = sqrt(sum(psi .* (t - mu_t).^2, 2));

% Organize
frqs = renamevars(frqs,["CF" "LowFrequencyBorder" "HighFrequencyBorder"],...
    ["freq" "freqLo" "freqHi"]);
frqs = movevars(frqs,["freq" "freqLo" "freqHi" "timeHW" "coiHW"],Before=1);
frqs = movevars(frqs,"coiHW",After="timeHW");
frqs = removevars(frqs,"Frequencies");

% Sort freqs low to high
frqs = sortrows(frqs,"freq","ascend"); % sort freqs low to high



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