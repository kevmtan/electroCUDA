%% Initialize (run this every compile)
dirs = ec_getDirs;
cd(dirs.code+"bin");
addpath(genpath('src_mex'));

%% Setup GPU with GUI (first compile)
% sudo update-alternatives --set gcc /usr/bin/gcc-10
%gpucoderSetup

%% Compile ec_filtfilt: zero-phase filtering
clear all; close all; %#ok<*CLALL> 
dirs = ec_getDirs;
cd(dirs.code+"bin");
try reset(gpuDevice()); catch;end
try rmdir([pwd filesep 'private' filesep 'ec_filtfilt']);
catch; system(['rm -rf ' pwd filesep 'private' filesep 'ec_filtfilt']); end % Remove precompiled
gpuNfo = gpuDevice();
% sudo update-alternatives --set gcc /usr/bin/gcc-10

% Config
cfg = coder.gpuConfig( "mex" );
cfg.DeepLearningConfig = coder.DeepLearningConfigBase.empty();
cfg.TargetLang = "C++";
cfg.DynamicMemoryAllocation = "AllVariableSizeArrays";
cfg.FilePartitionMethod = "SingleFile";
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.HighlightLoopControlIssues = true;
cfg.GenerateReport = true;
cfg.PreserveVariableNames = "UserNames";
cfg.ReportInfoVarName = "coder_report";
cfg.GpuConfig.CompilerFlags = '--use_fast_math --extra-device-vectorization';
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
%cfg.GpuConfig.SafeBuild = true;
cfg.GpuConfig.ComputeCapability = gpuNfo.ComputeCapability;

% Input arguments
arg1 = coder.newtype('double',[134217728 999],[1 1]); %#ok<*NASGU> 
arg2 = coder.newtype('double',[1 134217728],[0 1]);

% Generate CUDA code & compile
codegen -v -config cfg ec_filtfilt -args {arg1,arg2}

% Move to signal dir
movefile([pwd filesep 'codegen' filesep 'mex' filesep 'ec_filtfilt'],...
    [pwd filesep 'private'],"f");
try system('rm -rf codegen');catch;end

%% Continuous wavelet transform (single-precision)
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
try reset(gpuDevice()); catch;end
try rmdir([pwd filesep 'private' filesep 'ec_CWTsingle']);
catch; system(['rm -rf ' pwd filesep 'private' filesep 'ec_CWTsingle']); end % Remove precompiled
gpuNfo = gpuDevice();
% sudo update-alternatives --set gcc /usr/bin/gcc-10

cfg = coder.gpuConfig("mex");
cfg.DeepLearningConfig = coder.DeepLearningConfigBase.empty();
cfg.TargetLang = "C++";
cfg.DynamicMemoryAllocation = "AllVariableSizeArrays";
cfg.FilePartitionMethod = "SingleFile";
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.HighlightLoopControlIssues = true;
cfg.GenerateReport = true;
cfg.PreserveVariableNames = "UserNames";
cfg.ReportInfoVarName = "coder_report";
cfg.GpuConfig.CompilerFlags = '--fmad=false --extra-device-vectorization';
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
%cfg.GpuConfig.SafeBuild = true;
cfg.GpuConfig.ComputeCapability = gpuNfo.ComputeCapability;

% [x,freqs,coi] = ec_CWTsingle(x,fs,freqLims,doAbs,doAvg,freqsPerOctave)
arg1 = coder.typeof(single(0),[134217728 1],[1 0]); % data
arg2 = coder.typeof(1000,[1 1],[0 0]); % sampling rate
arg3 = coder.typeof([1 300],[1 2],[0 0]); % frequency limits
%arg4 = coder.typeof(true,[1 1],[0 0]); % get real-numbered magnitude
arg4 = coder.typeof(false,[1 1],[0 0]); % get scale-averaged magnitude
arg5 = coder.typeof(10,[1 1],[0 0]); % voices per octave

codegen ec_CWTsingle -config cfg -args {arg1,arg2,arg3,arg4,arg5}

% Move to signal dir
movefile([pwd filesep 'codegen' filesep 'mex' filesep 'ec_CWTsingle'],...
    [pwd filesep 'private'],"f");
try system('rm -rf codegen');catch;end

%% Continuous wavelet transform (double-precision)
clear all; close all;
dirs = ec_getDirs;
try reset(gpuDevice()); catch;end
try rmdir([pwd filesep 'private' filesep 'ec_CWTdouble']);
catch; system(['rm -rf ' pwd filesep 'private' filesep 'ec_CWTdouble']); end % Remove precompiled
gpuNfo = gpuDevice();
% sudo update-alternatives --set gcc /usr/bin/gcc-10

cfg = coder.gpuConfig("mex");
cfg.DeepLearningConfig = coder.DeepLearningConfigBase.empty();
cfg.TargetLang = "C++";
cfg.DynamicMemoryAllocation = "AllVariableSizeArrays";
cfg.FilePartitionMethod = "SingleFile";
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.HighlightLoopControlIssues = true;
cfg.GenerateReport = true;
cfg.PreserveVariableNames = "UserNames";
cfg.ReportInfoVarName = "coder_report";
cfg.GpuConfig.CompilerFlags = '--use_fast_math --extra-device-vectorization';
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
%cfg.GpuConfig.SafeBuild = true;
cfg.GpuConfig.ComputeCapability = gpuNfo.ComputeCapability;

% [x,freqs,coi] = ec_CWTdouble(x,fs,freqLims,doAbs,doAvg,freqsPerOctave)
arg1 = coder.typeof(0,[134217728 1],[1 0]); % data
arg2 = coder.typeof(1000,[1 1],[0 0]); % sampling rate
arg3 = coder.typeof([1 300],[1 2],[0 0]); % frequency limits
%arg4 = coder.typeof(true,[1 1],[0 0]); % get real-numbered magnitude
arg4 = coder.typeof(false,[1 1],[0 0]); % get scale-averaged magnitude
arg5 = coder.typeof(10,[1 1],[0 0]); % voices per octave

codegen ec_CWTdouble -config cfg -args {arg1,arg2,arg3,arg4,arg5}

% Move to signal dir
movefile([pwd filesep 'codegen' filesep 'mex' filesep 'ec_CWTdouble'],...
    [pwd filesep 'private'],"f");
try system('rm -rf codegen');catch;end
