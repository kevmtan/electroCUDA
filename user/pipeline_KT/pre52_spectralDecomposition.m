%% Task info

% Subject Names
sbjs = {'S12_38_LK','S12_42_NC','S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS',...
    'S12_39_RT','S12_40_MJ','S12_41_KS','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
    'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
    'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
    'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR','S15_87_RL',...
    'S16_95_JOB','S16_96_LF'}';

proj = "lbcn";
task = "MMR"; % task name


%% Options struct (more options in the loop below)
% NOTE: see individual functions for all inputs, descriptions & defaults
o = struct;
o.suffix = "s";
o.sfx_src = "";
o.dsTarg = 100; % Downsample target in Hz (default=[]: no downsample)
o.single = false; % Run & save as single (single much faster on GPU)
o.singleOut = true; % Run as double (accuracy) & save as single (small filesize)
o.gpu = "matlab"; % Run on... ["no"|"matlab"|"cuda"]

% Wavelet coherence
o.wavelet = "morse"; % Wavelet ["morse"|"amor"|"bump"], "amor" is Gabor/Morlet
o.fName = "spec"; % Name of frequency analysis
o.fLims = [1 300]; % frequency limits in hz; HFB=[70 200]
o.fMean = false; % Collapse across frequency bands (for 1d vector output)
o.fVoices = 10; % Voices per octave (default=10, HFB=18)
o.fOut = "magnitude";

% Frequency bands
o.freqIdx = []; %[1 14 20:4:83];
o.bands = ["delta" "theta" "alpha" "beta" "gamma" "hfb" "hfb2" "lfp"]; % Band name
o.bands2 = ["Delta (1-4hz)" "Theta (4-8hz)" "Alpha (8-13hz)" "Beta (13-30hz)"...
    "Gamma (30-60hz)" "HFB (60-180hz)" "HFB+ (180-300hz)" "LFP (ERP)"]; % Band display name
o.bandsF = [1 4; 4 8; 8 13; 13 30; 30 60; 60 180; 180 301; 0 0]; % Band limits

% Other
o.doBadFrames = false;
o.detrendOrder = []; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
o.detrendThr =   []; %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
o.detrendItr =   []; %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
o.detrendWin =   []; % detrend timewindow in seconds {entire run=[],default=[]}
o.hiPass = []; %"asr"; %"ASR"; % Hi-pass cutoff in hertz (skip=0)
o.hiPassGPU = false; % GPU slower than CPU??

%% Log
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/preproc/spec_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];
if ~exist('status','var')
    status = table;
    status.sbj = string(sbjs);
    status.fin(:,1) = false;
    status.msg(:,1) = "";
    status.error = cell(numel(sbjs),1);
    status.time(:,1) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
end


%% Run
for s = 1:height(status)
    if status.fin(s); continue; end
    try
        sbj = status.sbj(s);
        disp("STARTING: "+sbj);
        %%
        status.error{s} = ec_preprocTimeFreq(sbj,proj,task,o,save=true);
        status.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
        status.fin(s) = 1;
    catch ME; getReport(ME)
        status.error{s} = ME;
        status.fin(s) = 0;
    end
    save(sbjFinFn,'status','-v7');
end