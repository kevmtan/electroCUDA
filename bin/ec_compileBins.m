%% Initialize (run this every compile)
%pathsDMN("ec");
dirs = ec_getDirs;
cd(dirs.code+"bin");
system('rm -rf codegen');
%addpath(genpath('src_mex'));

%% Setup GPU with GUI (first compile)
%sudo update-alternatives --set gcc /usr/bin/gcc-10
%gpucoderSetup

%% Train imaGIN
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

%% ecc_cwt... - multiple wavelet functions (single- & double-precision)
reset(gpuDevice());
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
gpu = gpuDevice();

% Config
cfg = coder.gpuConfig( "mex" );
cfg.TargetLang = "C++";
cfg.DynamicMemoryAllocationThreshold = 65535;
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.MATLABSourceComments = true;
cfg.NumberOfCpuThreads = maxNumCompThreads;
cfg.SIMDAcceleration = "Full";
% cfg.StackUsageMax = floor(gpu.TotalMemory*.95);
cfg.GpuConfig.CompilerFlags = "-fmad=false -extra-device-vectorization";
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
cfg.GpuConfig.MaximumBlocksPerKernel = 3584;
cfg.GpuConfig.MaxPoolSize = 8192;
%cfg.GpuConfig.StackLimitPerThread = floor((gpu.TotalMemory*.95)/3584);
cfg.GpuConfig.ComputeCapability = string(gpu.ComputeCapability);
cfg.Verbosity = "Verbose";

% Paths & names
fn = string([pwd filesep 'private' filesep]);
fnc = string([pwd filesep 'codegen' filesep 'mex' filesep]);
funs = ["ecc_cwt","ecc_cwt","ecc_cwtAvg","ecc_cwtAvg"];
funz = ["ecc_cwt_mex32","ecc_cwt_mex64","ecc_cwtAvg_mex32","ecc_cwtAvg_mex64"];

% args
arg2 = coder.newtype('double',[1 1],[0 0]);
arg3 = coder.newtype('double',[1 2],[0 0]);
arg4 = coder.newtype('double',[1 1],[0 0]);

% Compile loop
for v = 1:4
    system("rm -rf "+fn+funz(v));
    system("rm -rf "+fnc+funs(v));

    if v==1 || v==3
        arg1 = coder.newtype('single',[2147483647 1024],[1 1]); % x
        arg5 = coder.newtype('single',[1 1],[0 0]); % ds2
    else
        arg1 = coder.newtype('double',[2147483647 1024],[1 1]);
        arg5 = coder.newtype('double',[1 1],[0 0]); % ds2
    end
    if v <= 2
        argz = {arg1,arg2,arg3,arg4,arg5};
    else
        argz = {arg1,arg2,arg3,arg4};
    end

    codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);

    movefile(fnc+funs(v),fn+funz(v),"f");
    system('rm -rf codegen');
end


%% ecc_filtfilt: zero-phase filtering
reset(gpuDevice());
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
gpu = gpuDevice();

% Config
cfg = coder.gpuConfig( "mex" );
cfg.TargetLang = "C++";
cfg.DynamicMemoryAllocationThreshold = 65535;
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.MATLABSourceComments = true;
cfg.NumberOfCpuThreads = maxNumCompThreads;
cfg.SIMDAcceleration = "Full";
% cfg.StackUsageMax = floor(gpu.TotalMemory*.95);
cfg.GpuConfig.CompilerFlags = "-fmad=false -extra-device-vectorization";
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
cfg.GpuConfig.MaximumBlocksPerKernel = 3584;
cfg.GpuConfig.MaxPoolSize = 8192;
%cfg.GpuConfig.StackLimitPerThread = floor((gpu.TotalMemory*.95)/3584);
cfg.GpuConfig.ComputeCapability = string(gpu.ComputeCapability);
cfg.Verbosity = "Verbose";

% Paths & names
fn = string([pwd filesep 'private' filesep]);
fnc = string([pwd filesep 'codegen' filesep 'mex' filesep]);
funs = ["ecc_filtfilt","ecc_filtfilt"];
funz = ["ecc_filtfilt_mex64","ecc_filtfilt1_mex64"];

% args
arg2 = coder.newtype('double',[1 1e9],[0 1]);

% Compile loop
for v = 1:2
    system("rm -rf "+fn+funz(v));
    system("rm -rf "+fnc+funs(v));

    if v==1
        arg1 = coder.newtype('double',[2147483647 65535],[1 1]);
    elseif v==2
        arg1 = coder.newtype('double',[2147483647 1],[1 0]);
    end
    argz = {arg1,arg2};

    codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);

    movefile(fnc+funs(v),fn+funz(v),"f");
    system('rm -rf codegen');
end


%% ecc_detr: robust detrending (double & single)
% clear all; close all;
% dirs = ec_getDirs;
% cd(dirs.code+"bin");
% reset(gpuDevice());
% 
% % Config
% cfg = coder.gpuConfig( "mex" );
% cfg.TargetLang = "C++";
% cfg.FilePartitionMethod = "SingleFile";
% cfg.GenerateReport = true;
% cfg.MATLABSourceComments = true;
% cfg.SIMDAcceleration = "Full";
% cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization";
% cfg.GpuConfig.EnableMemoryManager = true;
% cfg.GpuConfig.FreeMode = "AfterAllocate";
% cfg.GpuConfig.ComputeCapability = string(gpuDevice().ComputeCapability);
% cfg.Verbosity = "Verbose";
%
% % Paths & names
% fn = string([pwd filesep 'private' filesep]);
% fnc = string([pwd filesep 'codegen' filesep 'mex' filesep]);
% funs = ["ecc_detr","ecc_detr"];
% funz = ["ecc_detr_mex64","ecc_detr_mex32"];
% 
% % Compile loop
% for v = 1:2
%     fnv = fn+funz(v);
%     system("rm -rf "+fnv);
%     system('rm -rf codegen');
% 
%     if v==1
%         arg1 = coder.newtype('double',[2147483647 999],[1 1]); % x (input data)
%         arg2 = coder.newtype('double',[2147483647 999],[1 1]); % w (input weights)
%         arg3 = coder.newtype('double',[1 99],[1 1]); % order (polynomial)
%         arg4 = coder.newtype('double',[1 99],[1 1]); % thresh (outlier SD thresh)
%         arg5 = coder.newtype('double',[1 99],[1 1]); % niter (number of iterations)
%         argz = {arg1,arg2,arg3,arg4,arg5};
%         codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);
%     else
%         arg1 = coder.newtype('single',[2147483647 999],[1 1]); % x (input data)
%         arg2 = coder.newtype('single',[2147483647 999],[1 1]); % w (input weights)
%         arg3 = coder.newtype('single',[1 99],[1 1]); % order (polynomial)
%         arg4 = coder.newtype('single',[1 99],[1 1]); % thresh (outlier SD thresh)
%         arg5 = coder.newtype('single',[1 99],[1 1]); % niter (number of iterations)
%         argz = {arg1,arg2,arg3,arg4,arg5};
%         codegen(funs(v),"-o",funz(v),"-config","cfg","-singleC","-args",argz);
%     end
% 
%     movefile(fnc+funs(v),fn+funz(v),"f");
%     system('rm -rf codegen');
% end


%% ecc_detrend: robust detrending (double & single)
% clear all; close all;
% dirs = ec_getDirs;
% cd(dirs.code+"bin");
% reset(gpuDevice());
% 
% % Config
% cfg = coder.gpuConfig( "mex" );
% cfg.TargetLang = "C++";
% cfg.FilePartitionMethod = "SingleFile";
% cfg.GenerateReport = true;
% cfg.MATLABSourceComments = true;
% cfg.SIMDAcceleration = "Full";
% cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization";
% cfg.GpuConfig.EnableMemoryManager = true;
% cfg.GpuConfig.FreeMode = "AfterAllocate";
% cfg.GpuConfig.ComputeCapability = string(gpuDevice().ComputeCapability);
% cfg.Verbosity = "Verbose";
%
% % Paths & names
% fn = string([pwd filesep 'private' filesep]);
% fnc = string([pwd filesep 'codegen' filesep 'mex' filesep]);
% funs = ["ecc_detrend","ecc_detrend"];
% funz = ["ecc_detrend_mex64","ecc_detrend_mex32"];
% 
% % Compile loop
% for v = 1:2
%     fnv = fn+funz(v);
%     system("rm -rf "+fnv);
%     system('rm -rf codegen');
% 
%     if v==1
%         arg1 = coder.newtype('double',[2147483647 999],[1 1]); % x (input data)
%         arg2 = coder.newtype('double',[2147483647 999],[1 1]); % w (input weights)
%         arg3 = coder.newtype('double',[1 1],[0 0]); % order (polynomial)
%         arg4 = coder.newtype('double',[1 1],[0 0]); % thresh (outlier SD thresh)
%         arg5 = coder.newtype('double',[1 1],[0 0]); % niter (number of iterations)
%         arg6 = coder.newtype('double',[1 1],[0 0]); % wsize (overlapping window size in secs)
%         argz = {arg1,arg2,arg3,arg4,arg5,arg6};
%         codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);
%     else
%         arg1 = coder.newtype('single',[2147483647 999],[1 1]); % x (input data)
%         arg2 = coder.newtype('single',[2147483647 999],[1 1]); % w (input weights)
%         arg3 = coder.newtype('single',[1 1],[0 0]); % order (polynomial)
%         arg4 = coder.newtype('single',[1 1],[0 0]); % thresh (outlier SD thresh)
%         arg5 = coder.newtype('single',[1 1],[0 0]); % niter (number of iterations)
%         arg6 = coder.newtype('single',[1 1],[0 0]); % wsize (overlapping window size in secs)
%         argz = {arg1,arg2,arg3,arg4,arg5,arg6};
%         codegen(funs(v),"-o",funz(v),"-config","cfg","-singleC","-args",argz);
%     end
% 
%     movefile(fnc+funs(v),fn+funz(v),"f");
%     system('rm -rf codegen');
% end
