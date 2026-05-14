% Analysis options
oa = struct;
oa.statFn = "statBin25_lpf4hz_vd1vd2";

% Time variable
oa.timeVar = "bin2";
oa.bin2 = 0.025; % bin2 width in secs

% Smoothing (LPF)
oa.lpf = 4; % LPF in hertz

% Nuisance variables
oa.nv = ["VD1" "VD2"]; % "VD" ["VD1" "VD2"] ["VD" "K_pca1"]


%% Run
oa.analDir = "/01/lbcn/anal/classifySpecROI/zf_bands_50ms_SemEpi_LDA_nestedDeltaGamma";
mmr_cSpecAnal_ROI(oa);

oa.analDir = "/01/lbcn/anal/classifySpecROI/zf_bands_50ms_MathAb_LDA_gammaDelta";
mmr_cSpecAnal_ROI(oa);