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
saveDir = "/home/kt/matlab";

% Load the training features
trainBase = load('ImaGIN_trainBaseFeatures_ec.mat');

% Train the classifier
[mdl,validationAccuracy,validationPredictions,validationScores]...
    = ec_trainClassifier_ImaGIN(trainBase.predictors,trainBase.response);

% Save results
save(saveDir+"ec_trainedClassifier_ImaGIN.mat",'mdl','-v7');

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

%% ecc_detr: robust detrending (double & single)
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
try reset(gpuDevice()); catch;end
gpuNfo = gpuDevice();

% Config
cfg = coder.gpuConfig( "mex" );
cfg.DeepLearningConfig = coder.DeepLearningConfigBase.empty();
cfg.TargetLang = "C++";
cfg.EchoExpressions = false;
cfg.DynamicMemoryAllocation = "AllVariableSizeArrays";
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.HighlightLoopControlIssues = true;
cfg.MATLABSourceComments = true;
cfg.NumberOfCpuThreads = feature('numcores')*2;
cfg.ReportInfoVarName = "coder_report";
cfg.StackUsageMax = 2e9;
cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization";
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
cfg.GpuConfig.MaxPoolSize = 8192;
cfg.GpuConfig.ComputeCapability = gpuNfo.ComputeCapability;
cfg.Verbosity = "Verbose";

% Paths & names
fn = string([pwd filesep 'private' filesep]);
fnc = string([pwd filesep 'codegen' filesep 'mex' filesep]);
funs = ["ecc_detr","ecc_detr"];
funz = ["ecc_detr_mex64","ecc_detr_mex32"];

% Compile loop
for v = 1:2
    fnv = fn+funz(v);
    system("rm -rf "+fnv);
    system('rm -rf codegen');

    if v==1
        arg1 = coder.newtype('double',[134217728 999],[1 1]); % x (input data)
        arg2 = coder.newtype('double',[134217728 999],[1 1]); % w (input weights)
        arg3 = coder.newtype('double',[1 99],[1 1]); % order (polynomial)
        arg4 = coder.newtype('double',[1 99],[1 1]); % thresh (outlier SD thresh)
        arg5 = coder.newtype('double',[1 99],[1 1]); % niter (number of iterations)
        argz = {arg1,arg2,arg3,arg4,arg5};
        codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);
    else
        arg1 = coder.newtype('single',[134217728 999],[1 1]); % x (input data)
        arg2 = coder.newtype('single',[134217728 999],[1 1]); % w (input weights)
        arg3 = coder.newtype('single',[1 99],[1 1]); % order (polynomial)
        arg4 = coder.newtype('single',[1 99],[1 1]); % thresh (outlier SD thresh)
        arg5 = coder.newtype('single',[1 99],[1 1]); % niter (number of iterations)
        argz = {arg1,arg2,arg3,arg4,arg5};
        codegen(funs(v),"-o",funz(v),"-config","cfg","-singleC","-args",argz);
    end
    
    movefile(fnc+funs(v),fn+funz(v),"f");
    system('rm -rf codegen');
end


%% ecc_detrend: robust detrending (double & single)
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
try reset(gpuDevice()); catch;end
gpuNfo = gpuDevice();

% Config
cfg = coder.gpuConfig( "mex" );
cfg.DeepLearningConfig = coder.DeepLearningConfigBase.empty();
cfg.TargetLang = "C++";
cfg.EchoExpressions = false;
cfg.DynamicMemoryAllocation = "AllVariableSizeArrays";
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.HighlightLoopControlIssues = true;
cfg.MATLABSourceComments = true;
cfg.NumberOfCpuThreads = feature('numcores')*2;
cfg.ReportInfoVarName = "coder_report";
cfg.StackUsageMax = 2e9;
cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization";
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
cfg.GpuConfig.MaxPoolSize = 8192;
cfg.GpuConfig.ComputeCapability = gpuNfo.ComputeCapability;
cfg.Verbosity = "Verbose";

% Paths & names
fn = string([pwd filesep 'private' filesep]);
fnc = string([pwd filesep 'codegen' filesep 'mex' filesep]);
funs = ["ecc_detrend","ecc_detrend"];
funz = ["ecc_detrend_mex64","ecc_detrend_mex32"];

% Compile loop
for v = 1:2
    fnv = fn+funz(v);
    system("rm -rf "+fnv);
    system('rm -rf codegen');

    if v==1
        arg1 = coder.newtype('double',[134217728 999],[1 1]); % x (input data)
        arg2 = coder.newtype('double',[134217728 999],[1 1]); % w (input weights)
        arg3 = coder.newtype('double',[1 1],[0 0]); % order (polynomial)
        arg4 = coder.newtype('double',[1 1],[0 0]); % thresh (outlier SD thresh)
        arg5 = coder.newtype('double',[1 1],[0 0]); % niter (number of iterations)
        arg6 = coder.newtype('double',[1 1],[0 0]); % wsize (overlapping window size in secs)
        argz = {arg1,arg2,arg3,arg4,arg5,arg6};
        codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);
    else
        arg1 = coder.newtype('single',[134217728 999],[1 1]); % x (input data)
        arg2 = coder.newtype('single',[134217728 999],[1 1]); % w (input weights)
        arg3 = coder.newtype('single',[1 1],[0 0]); % order (polynomial)
        arg4 = coder.newtype('single',[1 1],[0 0]); % thresh (outlier SD thresh)
        arg5 = coder.newtype('single',[1 1],[0 0]); % niter (number of iterations)
        arg6 = coder.newtype('single',[1 1],[0 0]); % wsize (overlapping window size in secs)
        argz = {arg1,arg2,arg3,arg4,arg5,arg6};
        codegen(funs(v),"-o",funz(v),"-config","cfg","-singleC","-args",argz);
    end
    
    movefile(fnc+funs(v),fn+funz(v),"f");
    system('rm -rf codegen');
end

%% ecc_cwt... - multiple wavelet functions (single- & double-precision)
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
try reset(gpuDevice()); catch;end
gpuNfo = gpuDevice();

% Config
cfg = coder.gpuConfig( "mex" );
cfg.DeepLearningConfig = coder.DeepLearningConfigBase.empty();
cfg.TargetLang = "C++";
cfg.EchoExpressions = false;
cfg.DynamicMemoryAllocation = "AllVariableSizeArrays";
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.HighlightLoopControlIssues = true;
cfg.MATLABSourceComments = true;
cfg.NumberOfCpuThreads = feature('numcores')*2;
cfg.ReportInfoVarName = "coder_report";
cfg.StackUsageMax = 2e9;
cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization";
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
cfg.GpuConfig.MaxPoolSize = 8192;
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
funs = ["ecc_cwt","ecc_cwtAvg","ecc_cwt","ecc_cwtAvg"];
funz = ["ecc_cwt_mex32","ecc_cwtAvg_mex32","ecc_cwt_mex64","ecc_cwtAvg_mex64"];

% Compile loop
for v = 1:4
    fnv = fn+funz(v);
    system("rm -rf "+fnv);

    if v<=2; argz = {arg1s,arg2,arg3,arg4}; end
    if v>=3; argz = {arg1d,arg2,arg3,arg4}; end
    codegen(funs(v),"-o",funz(v),"-config","cfg","-args",argz);

    movefile(fnc+funs(v),fn+funz(v),"f");
    system('rm -rf codegen');
end


%% ecc_filtfilt: zero-phase filtering
clear all; close all;
dirs = ec_getDirs;
cd(dirs.code+"bin");
try reset(gpuDevice()); catch;end
gpuNfo = gpuDevice();

% Config
cfg = coder.gpuConfig( "mex" );
cfg.DeepLearningConfig = coder.DeepLearningConfigBase.empty();
cfg.TargetLang = "C++";
cfg.EchoExpressions = false;
cfg.DynamicMemoryAllocation = "AllVariableSizeArrays";
cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
cfg.GlobalDataSyncMethod = "SyncAtEntryAndExits";
cfg.HighlightLoopControlIssues = true;
cfg.MATLABSourceComments = true;
cfg.NumberOfCpuThreads = feature('numcores')*2;
cfg.ReportInfoVarName = "coder_report";
cfg.StackUsageMax = 2e9;
cfg.GpuConfig.CompilerFlags = "--fmad=false --extra-device-vectorization";
cfg.GpuConfig.EnableMemoryManager = true;
cfg.GpuConfig.FreeMode = "AtTerminate";
cfg.GpuConfig.MaxPoolSize = 8192;
cfg.GpuConfig.ComputeCapability = gpuNfo.ComputeCapability;
cfg.Verbosity = "Verbose";

% Input arguments
arg1 = coder.newtype('double',[134217728 999],[1 1]); %#ok<*NASGU> 
arg2 = coder.newtype('double',[1 13421772],[0 1]);

% Generate CUDA code & compile
codegen ecc_filtfilt -o ecc_filtfilt_mex64 -v -config cfg -args {arg1,arg2}

% Move to signal dir
movefile([pwd filesep 'codegen' filesep 'mex' filesep 'ecc_filtfilt'],...
    [pwd filesep 'private' filesep 'ecc_filtfilt_mex64'],"f");
system('rm -rf codegen');