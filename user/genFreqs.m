function freqs = genFreqs(freqName)

switch freqName
    case 'HFB'
        freqs = 2.^(6.15:0.05:7.4);   
    case 'Spec'
        freqs = 2.^([0:0.5:2,2.3:0.3:5,5.2:0.2:7.4]);
    case 'SpecDenseLF'
        freqs = 2.^([0:0.3:6,6.15:0.15:8]);        
    case 'SpecDense'
        freqs = 2.^([0:0.25:2,2.15:0.15:5,5.1:0.1:8]);
    case 'Delta'
        freqs = 2.^(-1:0.4:1.8);
    case 'Theta'
        freqs = 2.^(2:0.2:2.8);
    case 'Alpha'
        freqs = 2.^(3:0.2:4) - 0.9;
    case 'Beta'
        freqs = 2.^(4:0.2:5) - 0.1;
    case 'Gamma'
        freqs = 2.^(5:0.2:5.9);
end