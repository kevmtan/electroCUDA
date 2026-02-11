%% Task info
sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";"S12_40_MJ";...
    "S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";"S13_50_LGM";...
    "S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";"S13_57_TVD";...
    "S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";"S14_74_OD";...
    "S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";"S15_83_RR";...
    "S15_87_RL";"S16_95_JOB";"S16_96_LF"];
% s=1; sbjs="S12_38_LK"; sbjs="S12_42_NC"; sbjs=["S12_38_LK";"S12_42_NC"];

proj = "lbcn";
task = "MMR"; % task name


%% Options struct (more options in the loop below)
% NOTE: see individual functions for all inputs, descriptions & defaults
o = struct;
o.suffix = "s";
o.sfx_src = "";

o.gpu = "matlab"; % Run on... ["no"|"matlab"|"cuda"]
o.hzTarget = 200; % Downsample target in Hz (default=[]: no downsample)
o.single = false; % Run & save as single (single much faster on GPU)
o.singleOut = true; % Run as double (accuracy) & save as single (small filesize)
o.lpfSteep = 0.85;

% Wavelet coherence
o.wavelet = "morse"; % Wavelet ["morse"|"amor"|"bump"], "amor" is Gabor/Morlet
o.avg = false; % Full-spectrum (false) of scale-spectrum (true)
o.fName = "spec"; % Name of frequency analysis
o.fLims = [2 300]; % frequency limits in hz; HFB=[70 200]
o.fMean = false; % Collapse across frequency bands (for 1d vector output)
o.fVoices = 10; % Voices per octave (default=10, HFB=18)
o.fOut = "decibel";

% Other
o.doBadFrames = false;
o.detrendOrder = []; %[10 30]; % polynomial order [orderChunkedRun orderEntireRun] {default=[10 30]}
o.detrendThr =   []; %[6 3]; % outlier threshold [threshChunkedRun threshEntireRun] {default=[6 3]}
o.detrendItr =   []; %[10 2]; % number of iterations [iterChunkedRun iterEntireRun] {default=[10 2]}
o.detrendWin =   []; % detrend timewindow in seconds {entire run=[],default=[]}


%% Log
sbjFinFn = ['/01/lbcn/logs/preproc/spec_'...
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