%% Initialize (run this every compile)
dirs = ec_getDirs;
cd(dirs.code+"bin");
addpath(genpath('src_mex'));

%% Setup GPU with GUI (first compile)
% sudo update-alternatives --config gcc
gpucoderSetup

%% Compile ec_filtfilt: zero-phase filtering
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
cfg.LaunchReport = true;
cfg.PreserveVariableNames = "UserNames";
cfg.ReportInfoVarName = "coder_report";
cfg.GpuConfig.CompilerFlags = '--use_fast_math'; %--extra-device-vectorization';
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
%cfg.GpuConfig.SafeBuild = true;
cfg.GpuConfig.ComputeCapability = gpuNfo.ComputeCapability;

% Input arguments
arg1 = coder.newtype('double',[134217728 999],[1 1]);
arg2 = coder.newtype('double',[1 134217728],[0 1]);

% Generate CUDA code & compile
codegen -v -config cfg ec_filtfilt -args {arg1,arg2}

% Move to signal dir
movefile([pwd filesep 'codegen' filesep 'mex' filesep 'ec_filtfilt'],...
    [pwd filesep 'private'],"f");
system('rm -rf codegen');
%%
