% Analysis options
oa = struct;
oa.statFn = "stat_lpf4-20hz_vd1vd2Cond"; %"statBin_lpf4-20hz_vd1vd2";

% Time variable
oa.timeVar = "bin";
oa.bin2 = 0; % bin2 width in secs

% Nuisance variables
oa.nv = ["VD1" "VD2"]; % "VD" ["VD1" "VD2"] ["VD" "K_pca1"]

% LPF smoothing passband (skip=0)
oa.lpf = 4; % posterior probability
oa.lpfAcc = 20; % accuracy

% Outliers
oa.olThr = 5;
oa.olMethod = "median";
oa.olFill = "clip";


%% Run
oa.analDir = "/01/lbcn/anal/classifySpecROI/zf_MathAb_LDA_nestedGammaDelta";
stat = mmr_cSpecAnal_ROI(oa);
 
% oa.analDir = "/01/lbcn/anal/classifySpecROI/zf_hpf_SemEpi_LDA_nestedGammaDelta";
% mmr_cSpecAnal_ROI(oa);