%% Initialize (run this every compile)
pathsDMN("ec");
dirs = ec_getDirs;
cd(dirs.code+"bin");
system('rm -rf codegen');
%addpath(genpath('src_mex'));

%% Setup GPU with GUI (first compile)
% sudo update-alternatives --set gcc /usr/bin/gcc-10
%gpucoderSetup

%% ecu_cwt... - multiple wavelet functions (single- & double-precision)
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
try reset(gpuDevice()); catch;end
gpuNfo = gpuDevice();

% Config
cfg = coder.gpuConfig("mex");
cfg.DeepLearningConfig = coder.DeepLearningConfigBase.empty();
cfg.TargetLang = "C++";
cfg.EchoExpressions = false;
cfg.DynamicMemoryAllocation = "AllVariableSizeArrays";
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.HighlightLoopControlIssues = true;
cfg.MATLABSourceComments = true;
cfg.PreserveVariableNames = "UserNames";
cfg.ReportInfoVarName = "coder_report";
cfg.StackUsageMax = 2e9;
cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization";
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
cfg.GpuConfig.MaxPoolSize = 8192;
%cfg.GpuConfig.SafeBuild = true;
cfg.GpuConfig.ComputeCapability = gpuNfo.ComputeCapability;
cfg.Verbosity = "Verbose";

% Args
arg1s = coder.newtype('single',[134217728 999],[1 1]); % x (input data)
arg1d = coder.newtype('double',[134217728 999],[1 1]);
arg2 = coder.newtype('double',[1 1],[0 0]); % fs (sampling rate)
arg3 = coder.newtype('double',[1 2],[0 0]); % fLims
arg4 = coder.newtype('double',[1 1],[0 0]); % fOctave (voices per octave)

% Paths & names
fn = string([pwd filesep 'private' filesep]);
fnc = string([pwd filesep 'codegen' filesep 'mex' filesep]);
funs = ["ecu_cwt32","ecu_cwt32_avg","ecu_cwt64","ecu_cwt64_avg"];

% Compile loop
for v = 1:4
    fnv = fn+funs(v);
    system("rm -rf "+fnv);

    if v<=2; argz = {arg1s,arg2,arg3,arg4}; end
    if v>=3; argz = {arg1d,arg2,arg3,arg4}; 
    cfg.GpuConfig.CompilerFlags = "--use_fast_math --extra-device-vectorization";
    end

    codegen(funs(v),"-config","cfg","-args",argz);

    movefile(fnc+funs(v),fn,"f");
    system('rm -rf codegen');
end

% system(['rm -rf ' pwd filesep 'private' filesep 'ecu_CWTsingle']);
% codegen ecu_CWTsingle -config cfg -args {arg1,arg2,arg3,arg4,arg5}
% movefile([pwd filesep 'codegen' filesep 'mex' filesep 'ecu_CWTsingle'],[pwd filesep 'private'],"f");
% system('rm -rf codegen')

%% ecu_detrend: robust detrending (double-precision)
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
try reset(gpuDevice()); catch;end
gpuNfo = gpuDevice();

% Config
cfg = coder.gpuConfig("mex");
cfg.DeepLearningConfig = coder.DeepLearningConfigBase.empty();
cfg.TargetLang = "C++";
cfg.EchoExpressions = false;
cfg.DynamicMemoryAllocation = "AllVariableSizeArrays";
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.HighlightLoopControlIssues = true;
cfg.MATLABSourceComments = true;
cfg.PreserveVariableNames = "UserNames";
cfg.ReportInfoVarName = "coder_report";
cfg.StackUsageMax = 2e9;
cfg.GpuConfig.CompilerFlags = "--use_fast_math --extra-device-vectorization";
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
cfg.GpuConfig.MaxPoolSize = 8192;
%cfg.GpuConfig.SafeBuild = true;
cfg.GpuConfig.ComputeCapability = gpuNfo.ComputeCapability;
cfg.Verbosity = "Verbose";


% Input arguments: ecu_detrend(x,order,thresh,niter,wsize,w,doubleIn=true,singleOut=true)
arg1 = coder.newtype('double',[134217728 999],[1 1]); % x (input data)
arg2 = coder.newtype('double',[1 1],[0 0]); % order (polynomial)
arg3 = coder.newtype('double',[1 1],[0 0]); % thresh (outlier SD thresh)
arg4 = coder.newtype('double',[1 1],[0 0]); % niter (number of iterations)
arg5 = coder.newtype('double',[1 1],[0 0]); % wsize (overlapping window size in secs)
arg6 = coder.newtype('logical',[134217728 999],[1 1]); % w (input weights)
% arg7 = coder.newtype('logical',[1 1],[0 0]); % doubleIn (compute in double-precision)
% arg8 = coder.newtype('logical',[1 1],[0 0]); % singleOut (output in single-precision)

% Generate CUDA code & compile
codegen ecu_detrend -config cfg -args {arg1,arg2,arg3,arg4,arg5,arg6}

% Move to signal dir
movefile([pwd filesep 'codegen' filesep 'mex' filesep 'ecu_detrend'],...
    [pwd filesep 'private'],"f");
try system('rm -rf codegen');catch;end

%% ecu_filtfilt: zero-phase filtering
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
try reset(gpuDevice()); catch;end
gpuNfo = gpuDevice();

% Config
cfg = coder.gpuConfig("mex");
cfg.DeepLearningConfig = coder.DeepLearningConfigBase.empty();
cfg.TargetLang = "C++";
cfg.EchoExpressions = false;
cfg.DynamicMemoryAllocation = "AllVariableSizeArrays";
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.HighlightLoopControlIssues = true;
cfg.MATLABSourceComments = true;
cfg.PreserveVariableNames = "UserNames";
cfg.ReportInfoVarName = "coder_report";
cfg.StackUsageMax = 2e9;
cfg.GpuConfig.CompilerFlags = "--use_fast_math --extra-device-vectorization";
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
cfg.GpuConfig.MaxPoolSize = 8192;
%cfg.GpuConfig.SafeBuild = true;
cfg.GpuConfig.ComputeCapability = gpuNfo.ComputeCapability;
cfg.Verbosity = "Verbose";

% Input arguments
arg1 = coder.newtype('double',[134217728 999],[1 1]); %#ok<*NASGU> 
arg2 = coder.newtype('double',[1 13421772],[0 1]);

% Generate CUDA code & compile
codegen -v -config cfg ecu_filtfilt -args {arg1,arg2}

% Move to signal dir
movefile([pwd filesep 'codegen' filesep 'mex' filesep 'ecu_filtfilt'],[pwd filesep 'private'],"f");
system('rm -rf codegen');


%% VLFeat
clear all; close all; %#ok<*CLALL> 
dirs = ec_getDirs;
run(dirs.code+"deps"+filesep+"vlfeat-0.9.21"+filesep+"toolbox"+filesep+"vl_setup")


%% MatConvNet
% change paths for 'cudaRoot' and 'cudnnRoot' for your machine
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
try reset(gpuDevice()); catch;end
gpuNfo = gpuDevice();

ec_vl_compilenn('enableGpu',true,'CudaMethod','nvcc','EnableDouble',true,...
    'cudaRoot','/usr/local/cuda');