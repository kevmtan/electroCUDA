%% Robust preprocessing for intracranial or scalp electrophysiology
%
% Wrapper template for calling the following electroCUDA functions:
%    * ec_initialize: aggregate subject/task/EEG info, align timings for EEG & task
%    * ec_preproc: rereferencing, detrending, denoising & outlier detection
%    * ec_preprocICA: GPU-based independent components analysis (written in CUDA)
%    * ec_preprocTimeFreq: robust time-frequency decomposition
%    * robustSumStats: robust summary statistics & plots per electrode channel
%
% Full usage descriptions found in .m files for the above functions
%
% GPU ACCELERATION:
%    ec_preprocICA is GPU-only, ec_preprocTimeFreq has a 'doGPU' option
%    ec_preprocICA is written in CUDA with a Matlab wrapper (requires proficiency in compiling & CUDA)
%    ec_preprocTimeFreq can use Matlab GPU processing (see Matlab GPU requirements)
%    GPU VRAM must be greater than size of a single-channel EEG recording... YMMV
%    Enabling 'doGPU' defaults to single-precision floating point (FP32)
%    FP32 is less precise than Matlab's standard double-precision (FP64)
%    ec_preprocICA uses double-precision due to extreme sensitivity to rounding errors
%    You can use FP64 on GPU by disabling 'single' option
%
% CPU PARALLELIZATION:
%    Disabling 'doGPU' uses CPU parallelizaton: slower but more accurate (double FP64)
%    Thread- & process-based parallelization implemented natively in Matlab
%    This requires lots of RAM: 32gb+ is recommended, 128gb+ is ideal
%    See Matlab Parallelization Toolbox for more information
%
%
%               Kevin Tan, 2022 (http://kevmtan.github.io)
%
%
% ACKNOWLEDGMENTS:
%    Stanford Parvizi Lab (Pedro Pinhiero-Chagas, Amy Daitch, Su Liu, et al.)
%    Laboratoire des Systèmes Perceptifs (NoiseTools: Alain de Cheveigné, et al.)
% DISCLAIMER: Use this code at your own risk. Author assumes no responsibility
%    for any adverse outcomes related this code or its use. Author makes no
%    guarantees on the performance or accuracy of this code. This code is for
%    research purposes only; NOT INTENDED FOR CLINICAL OR MEDICAL USE.
% LICENSE: GNU General Public License

%% Project info
% Subject Names
 sbjs = {'S12_38_LK','S12_42_NC',...
     'S12_33_DA','S12_34_TC','S12_35_LM','S12_36_SrS','S12_39_RT',...
     'S12_40_MJ','S12_41_KS','S12_45_LR','S13_46_JDB','S13_47_JT2','S13_50_LGM',...
     'S13_51_MTL','S13_52_FVV','S13_53_KS2','S13_54_KDH','S13_56_THS','S13_57_TVD',...
     'S13_59_SRR','S13_60_DY','S14_62_JW','S14_66_CZ','S14_67_RH','S14_74_OD',...
     'S14_75_TB','S14_76_AA','S14_78_RS','S15_81_RM','S15_82_JB','S15_83_RR',...
     'S15_87_RL','S16_95_JOB','S16_96_LF'}';
 % sbjs = {'S12_38_LK'};

proj = 'MMR'; % Project name
pathFn = 'Kevin_DMN';
pathsDMN('ec'); % Get personal paths
pathsDMN('eeg');

doSpec = 1; % Do time-frequency decomposition for multiple frequencies
doHFB = 1; % Do time-frequency decomposition of HFB band (average across HFB freqs)
doICAspec = 1;
doICAhfb = 1;

doHFB_ICA = 0; % Do ICA on HFB

%if doICA||doICAspec||doICAhfb||doHFB_ICA; pathsDMN('ica'); end % add EEGLAB sigprocfun to path

%% Options struct (can be modified for each function below)
% NOTE: see individual functions for all inputs, descriptions & defaults

o = struct;

% Interpolate missing frames (within run & channel)
o.missingInterp = "linear";

% Bad frame detection per chan/IC
o.doBadFrames = true; % outlier/noise detection
o.thrHFO = 2; % threshold for epileptic HFO detection (default=2)
o.thrMAD = 10; % z-threshold relative to all data points to exclude timepoints (default=5)
o.thrDiff = 10; % z-threshold for amplitude difference of consecutive timepoints (default=5)
o.thrSNS = 3;

% Time-frequency decomposition
o.fName = "hfb"; % name of frequency analysis
o.fLims = [60 180]; % frequency limits in hz; HFB=[70 200]
o.fMean = true; % average across freq bands: output if TRUE=[time,ch]; FALSE=[time,ch,freq]
o.fVoices = 32; % voices per octave (default=10, HFB=20)
o.dsTarg = []; % downsample target in Hz (leave empty if no downsampling)
o.single = false; % Convert to double to single (if doGPU=true)
o.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
o.doGPUarray = true; % Use arrayfun for GPU (faster, requires more VRAM)

%% Setup

% add existinge file if exist
fn = "/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/preproc_221028_0653_errors.mat";
load(fn,'statusPP');

if ~exist('statusPP','var')
    statusPP = table;
    statusPP.sbj = sbjs;
    statusPP.sbjID = uint16(str2double(extractBetween(sbjs,"_","_")));
    statusPP.spec(:) = nan;
    statusPP.HFB(:) = nan;
    statusPP.speci(:) = nan;
    statusPP.HFBi(:) = nan;
    statusPP.time(:) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    statusPP.errorSpec = statusPP.errorPsy;
    statusPP.errorHFB = statusPP.errorPsy;
    statusPP.errorSpeci = statusPP.errorPsy;
    statusPP.errorHFBi = statusPP.errorPsy;
end

% filename of log
sbjFinFn = ['/home/kt/Gdrive/UCLA/Studies/MMR/anal/logs/preproc_'...
    char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm')) '_errors.mat'];


%% ASR-ICA
for s = 1:height(statusPP) % Subject loop
    sbj=statusPP.sbj{s}; sbjID=statusPP.sbjID(s);
    dirs = ec_getDirs(pathFn,sbj,proj,sbjID);
    o.dirOut = dirs.procSbj;
    o.fnStr = "s"+sbjID+"_"+proj;
    o.suffix = "";

    %% Spec
    if doSpec && statusPP.spec(s)~=1
        % Modify options
        oSpec = o;
        oSpec.suffix = "s";
        oSpec.sfx_src = "";
        oSpec.fName = "spec"; % Name of frequency analysis
        oSpec.fLims = [1 300]; % frequency limits in hz; HFB=[70 200]
        oSpec.fMean = false; % Collapse across frequency bands (for 1d vector output)
        oSpec.fVoices = 10; % Voices per octave (default=10, HFB=32)
        oSpec.dsTarg = 100; % Downsample target in Hz (default=[]: no downsample)
        oSpec.single = true; % Convert to double to single (if doGPU=true)
        oSpec.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
        oSpec.doGPUarray = false; % Use arrayfun for GPU (faster, more memory)
        oSpec.doBadFrames = false;

        % Run
        try disp("Starting spec: "+sbj);
            errSpec = ec_preprocTimeFreq(sbj,proj,oSpec,save=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errSpec)); statusPP.errorSpec{s}=errSpec; end
            statusPP.spec(s) = 1; disp("Finished spec: "+sbj);
        catch ME; warning("ERROR spec: "+sbj); getReport(ME)
            statusPP.errorSpec{s} = {lastwarn,ME};
            statusPP.spec(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
    end

    %% Spec on IC timecourses
    if doICAspec && statusPP.speci(s)~=1
        % Modify options
        oSpec = o;
        oSpec.suffix = "is";
        oSpec.sfx_src = "i";
        oSpec.fName = "spec"; % Name of frequency analysis
        oSpec.fLims = [1 300]; % frequency limits in hz; HFB=[70 200]
        oSpec.fMean = false; % Collapse across frequency bands (for 1d vector output)
        oSpec.fVoices = 10; % Voices per octave (default=10, HFB=18)
        oSpec.dsTarg = 100; % Downsample target in Hz (default=[]: no downsample)
        oSpec.single = true; % Convert to double to single (if doGPU=true)
        oSpec.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
        oSpec.doGPUarray = false; % Use arrayfun for GPU (faster, more memory)
        oSpec.doBadFrames = false;

        % Run
        try disp("Starting spec: "+sbj);
            errSpec = ec_preprocTimeFreq(sbj,proj,oSpec,save=1,ica=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errSpec)); statusPP.errorSpeci{s}=errSpec; end
            statusPP.speci(s) = 1; disp("Finished spec: "+sbj);
            try reset(gpuDevice(1)); catch;end
        catch ME; warning("ERROR spec: "+sbj); getReport(ME)
            statusPP.errorSpeci{s} = {lastwarn,ME};
            statusPP.speci(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
    end

    %% HFB: high-frequency broadband decomposition
    if doHFB && statusPP.HFB(s)~=1
        % Modify options
        oHFB = o;
        oHFB.suffix = "h";
        oHFB.sfx_src = "";
        oHFB.fName = "hfb"; % Name of frequency analysis
        oHFB.fLims = [60 180]; % frequency limits in hz; HFB=[70 200]
        oHFB.fMean = true; % Collapse across frequency bands (for 1d vector output)
        oHFB.fVoices = 32; % Voices per octave (default=10, HFB=18)
        oHFB.dsTarg = []; % Downsample target in Hz (default=[]: no downsample)
        oHFB.single = false; % Convert to double to single (single much faster on GPU)
        oHFB.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
        oHFB.doGPUarray = false; % Use arrayfun for GPU (faster, more memory)
        oHFB.doBadFrames = true;

        % Run
        try disp("Starting HFB: "+sbj);
            errHFB = ec_preprocTimeFreq(sbj,proj,oHFB,save=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errHFB)); statusPP.errorHFB{s}=errHFB; end
            statusPP.HFB(s) = 1; disp("Finished HFB: "+sbj);
        catch ME; warning("ERROR HFB: "+sbj); getReport(ME)
            statusPP.errorHFB{s} = {lastwarn,ME};
            statusPP.HFB(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
    end


    %% HFB decomposition on IC timecourses
    if doICAhfb && statusPP.HFBi(s)~=1
        % Modify options
        oHFB = o;
        oHFB.suffix = "ih";
        oHFB.sfx_src = "i";
        oHFB.fName = "hfb"; % Name of frequency analysis
        oHFB.fLims = [60 180]; % frequency limits in hz; HFB=[70 200]
        oHFB.fMean = true; % Collapse across frequency bands (for 1d vector output)
        oHFB.fVoices = 32; % Voices per octave (default=10, HFB=18)
        oHFB.dsTarg = []; % Downsample target in Hz (default=[]: no downsample)
        oHFB.single = false; % Convert to double to single (single much faster on GPU)
        oHFB.doGPU = false; % Run on GPU, see MATLAB gpuArray requirements (default=false)
        oHFB.doGPUarray = false; % Use arrayfun for GPU (faster, more memory)
        oHFB.doBadFrames = true;

        % Run
        try disp("Starting HFB: "+sbj);
            errHFB = ec_preprocTimeFreq(sbj,proj,oHFB,save=1,ica=1,dirs=dirs);
            if nnz(~cellfun(@isempty,errHFB)); statusPP.errorHFBi{s}=errHFB; end
            statusPP.HFBi(s) = 1; disp("Finished HFB: "+sbj);
        catch ME; warning("ERROR HFB: "+sbj); getReport(ME)
            statusPP.errorHFBi{s} = {lastwarn,ME};
            statusPP.HFBi(s) = 0;
            try parfevalOnAll(@gpuDevice,0,[]); catch;end
            try reset(gpuDevice(1)); catch;end
            try delete(gcp('nocreate')); catch;end
        end
    end

    %% Log progress
    statusPP.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
    save(sbjFinFn,"statusPP");
end

save
