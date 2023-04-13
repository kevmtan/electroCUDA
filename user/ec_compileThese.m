%% Initialize (run this every compile)
%pathsDMN("ec");
dirs = ec_getDirs;
cd(dirs.code+"src"+filesep+"cuda");
system('rm -rf codegen');
%addpath(genpath('src_mex'));

%% Setup GPU with GUI (first compile)
%sudo update-alternatives --set gcc /usr/bin/gcc-10
%gpucoderSetup

%% Train imaGIN
clear all; close all;

saveDir = "/home/kt/matlab/";

% Load the training features
trainBase = load('ImaGIN_trainBaseFeatures_ec.mat');

% Train the classifier
[mdl,validationAccuracy,validationPredictions,validationScores]...
    = ec_trainClassifier_ImaGIN(trainBase.predictors,trainBase.response);

% Save results
save(saveDir+"ec_trainedClassifier_ImaGIN.mat",'mdl','-v7');

%% VLFeat
clear all; close all; %#ok<*CLALL> 
vl_setup('verbose');


%% MatConvNet
% change paths for 'cudaRoot' and 'cudnnRoot' for your machine
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
reset(gpuDevice()); 
%gpuNfo = gpuDevice();

ec_vl_compilenn('enableGpu',true,'enableDouble',true,'verbose',true,...
    'cudaMethod','nvcc','enableCudnn',false,...
    'cudaRoot','/usr/local/cuda/','cudnnRoot','/usr/local/cuda-12.0/');

%% ec_cwt... - multiple wavelet functions (single- & double-precision)
reset(gpuDevice());
clear all; close all;
dirs = ec_getDirs;
dirsCuda = dirs.code+"src"+filesep+"cuda"+filesep;
cd(dirsCuda);
gpu = gpuDevice();

% Config
cfg = coder.gpuConfig( "mex" );
cfg.DeepLearningConfig = coder.DeepLearningConfig( 'tensorrt' );
cfg.TargetLang = "C++";
cfg.DynamicMemoryAllocationThreshold = 65535;
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.ExtrinsicCalls = false;
%cfg.EnableJIT = true;
cfg.MATLABSourceComments = true;
cfg.NumberOfCpuThreads = maxNumCompThreads;
cfg.SIMDAcceleration = "Full";
% cfg.StackUsageMax = floor(gpu.TotalMemory*.95);
cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization"; 
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AfterAllocate";
%cfg.GpuConfig.MaximumBlocksPerKernel = 3584;
%cfg.GpuConfig.MaxPoolSize = 8192;
%cfg.GpuConfig.StackLimitPerThread = floor((gpu.TotalMemory*.95)/3584);
cfg.GpuConfig.ComputeCapability = string(gpu.ComputeCapability);
%cfg.GpuConfig.CustomComputeCapability = "sm_86";
cfg.Verbosity = "Verbose";

% Paths & names
fn = dirs.code+filesep+"bin"+filesep;
fnc = dirsCuda+"codegen"+filesep+"mex"+filesep;
funs = ["ec_cwt","ec_cwt","ec_cwtAvg","ec_cwtAvg"];
funz = ["ec_cwt_fp32","ec_cwt_fp64","ec_cwtAvg_fp32","ec_cwtAvg_fp64"];

% args
arg2 = coder.newtype('double',[1 1],[0 0]);
arg3 = coder.newtype('double',[1 2],[0 0]);
arg4 = coder.newtype('double',[1 1],[0 0]);

% Compile loop
for v = 1:4
    system("rm -rf "+fn+funz(v));
    system("rm -rf "+fnc+funs(v));

    if v==1 || v==3
        arg1 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % x
        arg5 = coder.newtype('single',[1 1],[0 0]); % ds2
    else
        arg1 = coder.newtype('double',[2147483647-1 65535-1],[1 1]);
        arg5 = coder.newtype('double',[1 1],[0 0]); % ds2
    end
    if v <= 2
        argz = {arg1,arg2,arg3,arg4,arg5};
    else
        argz = {arg1,arg2,arg3,arg4};
    end

    codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);

    movefile(fnc+funs(v),dirsCuda+funz(v),"f");
    movefile(funz(v)+".mexa64",fn+funz(v)+".mexa64");
    system('rm -rf codegen');
end


%% ec_filtfilt1: zero-phase filtering
reset(gpuDevice());
clear all; close all;
dirs = ec_getDirs;
dirsCuda = dirs.code+"src"+filesep+"cuda"+filesep;
cd(dirsCuda);
gpu = gpuDevice();

% Config
cfg = coder.gpuConfig( "mex" );
cfg.DeepLearningConfig = coder.DeepLearningConfig( 'tensorrt' );
cfg.TargetLang = "C++";
cfg.DynamicMemoryAllocationThreshold = 65535;
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.ExtrinsicCalls = false;
%cfg.EnableJIT = true;
cfg.MATLABSourceComments = true;
cfg.NumberOfCpuThreads = maxNumCompThreads;
cfg.SIMDAcceleration = "Full";
% cfg.StackUsageMax = floor(gpu.TotalMemory*.95);
cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization"; 
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AfterAllocate";
%cfg.GpuConfig.MaximumBlocksPerKernel = 3584;
%cfg.GpuConfig.MaxPoolSize = 8192;
%cfg.GpuConfig.StackLimitPerThread = floor((gpu.TotalMemory*.95)/3584);
cfg.GpuConfig.ComputeCapability = string(gpu.ComputeCapability);
%cfg.GpuConfig.CustomComputeCapability = "sm_86";
cfg.Verbosity = "Verbose";

% Paths & names
fn = dirs.code+filesep+"bin"+filesep;
fnc = dirsCuda+"codegen"+filesep+"mex"+filesep;
funs = ["ec_filtfilt1","ec_filtfilt1"];
funz = ["ec_filtfilt1_fp32","ec_filtfilt1_fp64"];

% Compile loop
for v = 1:2
    system("rm -rf "+fn+funz(v));
    system("rm -rf "+fnc+funs(v));

    if v==1
        arg1 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % x
        arg2 = coder.newtype('single',[2147483647-1 1],[1 0]); % b
        arg3 = coder.newtype('single',[2147483647-1 1],[1 0]); % a
        arg4 = coder.newtype('single',[2147483647-1 1],[1 0]); % z
        arg5 = coder.newtype('single',[1 1],[0 0]); % nf
        arg6 = coder.newtype('single',[1 1],[0 0]); % L
    elseif v==2
        arg1 = coder.newtype('double',[2147483647-1 65535-1],[1 1]); % x
        arg2 = coder.newtype('double',[2147483647-1 1],[1 0]); % b
        arg3 = coder.newtype('double',[2147483647-1 1],[1 0]); % a
        arg4 = coder.newtype('double',[2147483647-1 1],[1 0]); % z
        arg5 = coder.newtype('double',[1 1],[0 0]); % nf
        arg6 = coder.newtype('double',[1 1],[0 0]); % L
    end
    argz = {arg1,arg2,arg3,arg4,arg5,arg6};

    codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);

    movefile(fnc+funs(v),dirsCuda+funz(v),"f");
    movefile(funz(v)+".mexa64",fn+funz(v)+".mexa64");
    system('rm -rf codegen');
end



%% ec_detr: robust detrending (double & single)
reset(gpuDevice());
clear all; close all;
dirs = ec_getDirs;
dirsCuda = dirs.code+"src"+filesep+"cuda"+filesep;
cd(dirsCuda);
gpu = gpuDevice();

% Config
cfg = coder.gpuConfig( "mex" );
cfg.DeepLearningConfig = coder.DeepLearningConfig( 'tensorrt' );
cfg.TargetLang = "C++";
cfg.DynamicMemoryAllocationThreshold = 65535;
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.ExtrinsicCalls = false;
%cfg.EnableJIT = true;
cfg.MATLABSourceComments = true;
cfg.NumberOfCpuThreads = maxNumCompThreads;
cfg.SIMDAcceleration = "Full";
% cfg.StackUsageMax = floor(gpu.TotalMemory*.95);
cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization"; 
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AfterAllocate";
%cfg.GpuConfig.MaximumBlocksPerKernel = 3584;
%cfg.GpuConfig.MaxPoolSize = 8192;
%cfg.GpuConfig.StackLimitPerThread = floor((gpu.TotalMemory*.95)/3584);
cfg.GpuConfig.ComputeCapability = string(gpu.ComputeCapability);
%cfg.GpuConfig.CustomComputeCapability = "sm_86";
cfg.Verbosity = "Verbose";

% Paths & names
fn = dirs.code+filesep+"bin"+filesep;
fnc = dirsCuda+"codegen"+filesep+"mex"+filesep;
funs = ["ec_detr","ec_detr"];
funz = ["ec_detr_fp64","ec_detr_fp32"];

% Compile loop
for v = 1:2
    fnv = fn+funz(v);
    system("rm -rf "+fnv);
    system('rm -rf codegen');

    if v==1
        arg1 = coder.newtype('double',[2147483647 999],[1 1]); % x (input data)
        arg2 = coder.newtype('double',[2147483647 999],[1 1]); % w (input weights)
        arg3 = coder.newtype('double',[1 99],[1 1]); % order (polynomial)
        arg4 = coder.newtype('double',[1 99],[1 1]); % thresh (outlier SD thresh)
        arg5 = coder.newtype('double',[1 99],[1 1]); % niter (number of iterations)
        argz = {arg1,arg2,arg3,arg4,arg5};
        codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);
    else
        arg1 = coder.newtype('single',[2147483647 999],[1 1]); % x (input data)
        arg2 = coder.newtype('single',[2147483647 999],[1 1]); % w (input weights)
        arg3 = coder.newtype('single',[1 99],[1 1]); % order (polynomial)
        arg4 = coder.newtype('single',[1 99],[1 1]); % thresh (outlier SD thresh)
        arg5 = coder.newtype('single',[1 99],[1 1]); % niter (number of iterations)
        argz = {arg1,arg2,arg3,arg4,arg5};
        codegen(funs(v),"-o",funz(v),"-config","cfg","-singleC","-args",argz);
    end

    movefile(fnc+funs(v),dirsCuda+funz(v),"f");
    movefile(funz(v)+".mexa64",fn+funz(v)+".mexa64");
    system('rm -rf codegen')
end


%% ec_detrend: robust detrending (double & single)
reset(gpuDevice());
clear all; close all;
dirs = ec_getDirs;
dirsCuda = dirs.code+"src"+filesep+"cuda"+filesep;
cd(dirsCuda);
gpu = gpuDevice();

% Config
cfg = coder.gpuConfig( "mex" );
cfg.DeepLearningConfig = coder.DeepLearningConfig( 'tensorrt' );
cfg.TargetLang = "C++";
cfg.DynamicMemoryAllocationThreshold = 65535;
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.ExtrinsicCalls = false;
%cfg.EnableJIT = true;
cfg.MATLABSourceComments = true;
cfg.NumberOfCpuThreads = maxNumCompThreads;
cfg.SIMDAcceleration = "Full";
% cfg.StackUsageMax = floor(gpu.TotalMemory*.95);
cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization"; 
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AfterAllocate";
%cfg.GpuConfig.MaximumBlocksPerKernel = 3584;
%cfg.GpuConfig.MaxPoolSize = 8192;
%cfg.GpuConfig.StackLimitPerThread = floor((gpu.TotalMemory*.95)/3584);
cfg.GpuConfig.ComputeCapability = string(gpu.ComputeCapability);
%cfg.GpuConfig.CustomComputeCapability = "sm_86";
cfg.Verbosity = "Verbose";

% Paths & names
fn = dirs.code+filesep+"bin"+filesep;
fnc = dirsCuda+"codegen"+filesep+"mex"+filesep;
funs = ["ec_detrend","ec_detrend"];
funz = ["ec_detrend_fp64","ec_detrend_fp32"];

% Compile loop
for v = 1:2
    fnv = fn+funz(v);
    system("rm -rf "+fnv);
    system('rm -rf codegen');

    if v==1
        arg1 = coder.newtype('double',[2147483647 999],[1 1]); % x (input data)
        arg2 = coder.newtype('double',[2147483647 999],[1 1]); % w (input weights)
        arg3 = coder.newtype('double',[1 1],[0 0]); % order (polynomial)
        arg4 = coder.newtype('double',[1 1],[0 0]); % thresh (outlier SD thresh)
        arg5 = coder.newtype('double',[1 1],[0 0]); % niter (number of iterations)
        arg6 = coder.newtype('double',[1 1],[0 0]); % wsize (overlapping window size in secs)
        argz = {arg1,arg2,arg3,arg4,arg5,arg6};
        codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);
    else
        arg1 = coder.newtype('single',[2147483647 999],[1 1]); % x (input data)
        arg2 = coder.newtype('single',[2147483647 999],[1 1]); % w (input weights)
        arg3 = coder.newtype('single',[1 1],[0 0]); % order (polynomial)
        arg4 = coder.newtype('single',[1 1],[0 0]); % thresh (outlier SD thresh)
        arg5 = coder.newtype('single',[1 1],[0 0]); % niter (number of iterations)
        arg6 = coder.newtype('single',[1 1],[0 0]); % wsize (overlapping window size in secs)
        argz = {arg1,arg2,arg3,arg4,arg5,arg6};
        codegen(funs(v),"-o",funz(v),"-config","cfg","-singleC","-args",argz);
    end

    movefile(fnc+funs(v),dirsCuda+funz(v),"f");
    movefile(funz(v)+".mexa64",fn+funz(v)+".mexa64");
    system('rm -rf codegen')
end



%%
% %% ec_svmSpectral_chLat
% reset(gpuDevice());
% clear all; close all;
% dirs = ec_getDirs;
% cd(dirs.code+"bin");
% gpu = gpuDevice();
% 
% % Config
% cfg = coder.gpuConfig( "mex" );
% cfg.DeepLearningConfig = coder.DeepLearningConfig( 'tensorrt' );
% cfg.TargetLang = "C++";
% cfg.DynamicMemoryAllocationThreshold = 65535;
% cfg.FilePartitionMethod = "SingleFile";
% cfg.GenerateReport = true;
% cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
% cfg.ExtrinsicCalls = false;
% %cfg.EnableJIT = true;
% cfg.MATLABSourceComments = true;
% cfg.NumberOfCpuThreads = maxNumCompThreads;
% cfg.SIMDAcceleration = "Full";
% % cfg.StackUsageMax = floor(gpu.TotalMemory*.95);
% cfg.GpuConfig.CompilerFlags = "--extra-device-vectorization"; 
% cfg.GpuConfig.EnableMemoryManager = true;
% cfg.GpuConfig.FreeMode = "AfterAllocate";
% %cfg.GpuConfig.MaximumBlocksPerKernel = 3584;
% %cfg.GpuConfig.MaxPoolSize = 8192;
% %cfg.GpuConfig.StackLimitPerThread = floor((gpu.TotalMemory*.95)/3584);
% cfg.GpuConfig.ComputeCapability = string(gpu.ComputeCapability);
% cfg.GpuConfig.CustomComputeCapability = "sm_86";
% cfg.Verbosity = "Verbose";
% 
% % Paths & names
% fn = string([pwd filesep 'private' filesep]);
% fnc = string([pwd filesep 'codegen' filesep 'mex' filesep]);
% funs = "ec_svmSpectral_chTime";
% funz = "ec_svmSpectral_chTime_FP32";
% 
% 
% for v = 1
%     system("rm -rf "+fn+funz(v));
%     system("rm -rf "+fnc+funs(v));
% 
%     arg1 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % xc
%     arg2 = coder.newtype('single',[2147483647-1 1],[1 0]); % Y
%     arg3 = coder.newtype('logical',[2147483647-1 1],[1 0]); % in
%     arg4 = coder.newtype('logical',[2147483647-1 65535-1],[1 1]); % idl
%     arg5 = coder.newtype('int16',[65535-1 1],[1 0]); % bins
%     argz = {arg1,arg2,arg3,arg4,arg5};
% 
%     codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);
% 
%     movefile(fnc+funs(v),fn+funz(v),"f");
%     system('rm -rf codegen');
% end
