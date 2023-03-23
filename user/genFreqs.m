function [freqs,voicesPerOctave] = genFreqs(freqName)
% Generate frequencies in hertz per band

voicesPerOctave = 32;
switch freqName
    case "spec" % continuous spectrum
        freqs = [1 300];
        voicesPerOctave = 10;
    case "delta"
        freqs = [1 4];
    case "theta"
        freqs = [4 8];
    case "alpha"
        freqs = [8 13];
    case "beta"
        freqs = [13 30];
    case "gamma"
        freqs = [30 60];
    case "hfb"
        freqs = [60 180];
    case "uhfb"
        freqs = [180 300];
    case "hfw"
        freqs = [60 300];
end
