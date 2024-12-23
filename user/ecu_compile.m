d = ec_getDirs;
cd(d.srcCUDA);
system('rm -rf codegen');

%% Train imaGIN

% imaGIN classifier save dir
saveDirClassifier = "/home/kt/matlab/";

% Load the training features
trainBase = load('ImaGIN_trainBaseFeatures_ec.mat');

% Train the classifier
[mdl,validationAccuracy,validationPredictions,validationScores]...
    = ec_trainClassifier_ImaGIN(trainBase.predictors,trainBase.response);

% Save results
v = matlabRelease;
save(saveDirClassifier+"ec_trainedClassifier_ImaGIN_"+v.Release+".mat",'mdl','-v7');


%% VLFeat (use Matlab package manager: Add-Ons)
% reset(gpuDevice());
% clear all; close all; %#ok<*CLALL>
% vl_setup('verbose');
% 
% 
%% MatConvNet (use Matlab package manager: Add-Ons)
% % change paths for 'cudaRoot' and 'cudnnRoot' for your machine
% clear all; close all;
% d = ec_getDirs;
% cd(d.code+"bin");
% reset(gpuDevice());
% %gpuNfo = gpuDevice();
% 
% % CUDA root dir
% cudaRoot = '/usr/local/cuda/';
% 
% % cuDNN root dir (CUDA deep learning)
% cudnnRoot = '/usr/local/cuda-12.0/targets/x86_64-linux/';
% 
% ec_vl_compilenn('enableGpu',true,'enableDouble',true,'verbose',true,...
%     'cudaMethod','nvcc','enableCudnn',true,...
%     'cudaRoot',cudaRoot,'cudnnRoot',cudnnRoot);


%% ec_wtc_fp: wavelet coherence (single- & double-precision)

% Config
clear all; close all;
[cfg,d] = getCoderConfigs_lfn; 

% Paths & names
fn = d.code+"bin"+filesep;
fnc = d.srcCUDA+"codegen"+filesep+"mex"+filesep;
funs = "ec_wtc_fp";
funz = ["ec_wtc_fp32","ec_wtc_fp64"];

arg2 = coder.newtype('uint16',[65535-1 2],[1 0]); % c (list of chan pairs)
arg3 = coder.newtype('double',[1 1],[0 0]); % fs
arg4 = coder.newtype('double',[1 2],[0 0]); % fLims
arg5 = coder.newtype('double',[1 1],[0 0]); % fVoices
arg6 = coder.newtype('double',[1 2],[0 0]); % ds

% Compile loop
for v = 1:2
    system("rm -rf "+fn+funz(v)+".mexa64");
    system("rm -rf "+d.srcCUDA+funz(v));
    system("rm -rf "+fnc+funs);

    if v==1
        arg1 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % x
    else
        arg1 = coder.newtype('double',[2147483647-1 65535-1],[1 1]); % x
    end
    argz = {arg1,arg2,arg3,arg4,arg5,arg6};

    codegen(funs,"-o",funz(v),"-config",cfg,"-args",argz,"-gpuprofile");

    movefile(fnc+funs,d.srcCUDA+funz(v),"f");
    movefile(funz(v)+".mexa64",fn+funz(v)+".mexa64");
    delete(d.srcCUDA+funz(v)+filesep+funz(v)+".mexa64");
    system('rm -rf codegen');
end


%% ec_wt_fp: wavelet transform (single- & double-precision)

% Config
clear all; close all;
[cfg,d] = getCoderConfigs_lfn; 

% Paths & names
fn = d.code+"bin"+filesep; 
fnc = d.srcCUDA+"codegen"+filesep+"mex"+filesep;
funs = "ec_wt_fp";
funz = ["ec_wt_fp32","ec_wt_fp64"];

% args
arg2 = coder.newtype('double',[1 1],[0 0]); % fs
arg3 = coder.newtype('double',[1 2],[0 0]); % fLim
arg4 = coder.newtype('double',[1 1],[0 0]); % fVoices
arg5 = coder.newtype('double',[1 1],[0 0]); % ds
arg6 = coder.newtype('logical',[1 1],[0 0]); % doReal
arg7 = coder.newtype('logical',[1 1],[0 0]); % doPwr

% Compile loop
for v = 1:2
    system("rm -rf "+fn+funz(v)+".mexa64");
    system("rm -rf "+d.srcCUDA+funz(v));
    system("rm -rf "+fnc+funs);

    if v==1
        arg1 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % x
    else
        arg1 = coder.newtype('double',[2147483647-1 65535-1],[1 1]);
    end
    argz = {arg1,arg2,arg3,arg4,arg5,arg6,arg7};

    codegen(funs,"-o",funz(v),"-config",cfg,"-args",argz,"-gpuprofile");

    movefile(fnc+funs,d.srcCUDA+funz(v),"f");
    movefile(funz(v)+".mexa64",fn+funz(v)+".mexa64");
    delete(d.srcCUDA+funz(v)+filesep+funz(v)+".mexa64");
    system('rm -rf codegen');
end

%% ec_filtfilt_fp: zero-phase filtering

% Config
clear all; close all;
[cfg,d] = getCoderConfigs_lfn; 

% Paths & names
fn = d.code+"bin"+filesep;
fnc = d.srcCUDA+"codegen"+filesep+"mex"+filesep;
funs = "filtfilt";
funz = ["ec_filtfilt_fp32","ec_filtfilt_fp64"];

% Compile loop
for v = 1:2
    system("rm -rf "+fn+funz(v)+".mexa64");
    system("rm -rf "+d.srcCUDA+funz(v));
    system("rm -rf "+fnc+funs);

    if v==1
        arg1 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % b/sos
        arg2 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % a/g
        arg3 = coder.newtype('single',[2147483647-1 65535-1 65535-1],[1 1 1]); % x
    elseif v==2
        arg1 = coder.newtype('double',[2147483647-1 65535-1],[1 1]); % b/sos
        arg2 = coder.newtype('double',[2147483647-1 65535-1],[1 1]); % a/g
        arg3 = coder.newtype('double',[2147483647-1 65535-1 65535-1],[1 1 1]); % x
    end
    argz = {arg1,arg2,arg3};

    codegen(funs,"-o",funz(v),"-config",cfg,"-args",argz,"-gpuprofile");

    movefile(fnc+funs,d.srcCUDA+funz(v),"f");
    movefile(funz(v)+".mexa64",fn+funz(v)+".mexa64");
    delete(d.srcCUDA+funz(v)+filesep+funz(v)+".mexa64");
    system('rm -rf codegen');
end


% %% ec_filtfilt_fp: zero-phase filtering
% 
% % Config
% clear all; close all;
% [cfg,d] = getCoderConfigs_lfn; 
% 
% % Paths & names
% fn = d.code+"bin"+filesep;
% fnc = d.srcCUDA+"codegen"+filesep+"mex"+filesep;
% funs = "ec_filtfilt_fp";
% funz = ["ec_filtfilt_fp32","ec_filtfilt_fp64"];
% 
% % Compile loop
% for v = 1:2
%     system("rm -rf "+fn+funz(v)+".mexa64");
%     system("rm -rf "+d.srcCUDA+funz(v));
%     system("rm -rf "+fnc+funs);
% 
%     if v==1
%         arg1 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % x
%         arg2 = coder.newtype('single',[2147483647-1 1],[1 0]); % b
%         arg3 = coder.newtype('single',[2147483647-1 1],[1 0]); % a
%         arg4 = coder.newtype('single',[2147483647-1 1],[1 0]); % z
%         arg5 = coder.newtype('single',[1 1],[0 0]); % nf
%         arg6 = coder.newtype('single',[1 1],[0 0]); % L
%     elseif v==2
%         arg1 = coder.newtype('double',[2147483647-1 65535-1],[1 1]); % x
%         arg2 = coder.newtype('double',[2147483647-1 1],[1 0]); % b
%         arg3 = coder.newtype('double',[2147483647-1 1],[1 0]); % a
%         arg4 = coder.newtype('double',[2147483647-1 1],[1 0]); % z
%         arg5 = coder.newtype('double',[1 1],[0 0]); % nf
%         arg6 = coder.newtype('double',[1 1],[0 0]); % L
%     end
%     argz = {arg1,arg2,arg3,arg4,arg5,arg6};
% 
%     codegen(funs,"-o",funz(v),"-config",cfg,"-args",argz,"-gpuprofile");
% 
%     movefile(fnc+funs,d.srcCUDA+funz(v),"f");
%     movefile(funz(v)+".mexa64",fn+funz(v)+".mexa64");
%     delete(d.srcCUDA+funz(v)+filesep+funz(v)+".mexa64");
%     system('rm -rf codegen');
% end



%% ec_detr_fp: robust detrending (double & single)

% Config
clear all; close all;
[cfg,d] = getCoderConfigs_lfn; 

% Paths & names
fn = d.code+filesep+"bin"+filesep;
fnc = d.srcCUDA+"codegen"+filesep+"mex"+filesep;
funs = "ec_detr_fp";
funz = ["ec_detr_fp32","ec_detr_fp64"];

% Compile loop
system('rm -rf codegen')
for v = 1:2
    fnv = fn+funz(v);
    system("rm -rf "+fn+funz(v)+".mexa64");
    system("rm -rf "+d.srcCUDA+funz(v));
    system("rm -rf "+fnc+funs);

    if v==1
        arg1 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % x (input data)
        arg2 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % w (input weights)
        arg3 = coder.newtype('single',[1 99],[0 1]); % order (polynomial)
        arg4 = coder.newtype('single',[1 99],[0 1]); % thresh (outlier SD thresh)
        arg5 = coder.newtype('single',[1 99],[0 1]); % niter (number of iterations)
    else
        arg1 = coder.newtype('double',[2147483647-1 65535-1],[1 1]); % x (input data)
        arg2 = coder.newtype('double',[2147483647-1 65535-1],[1 1]); % w (input weights)
        arg3 = coder.newtype('double',[1 99],[0 1]); % order (polynomial)
        arg4 = coder.newtype('double',[1 99],[0 1]); % thresh (outlier SD thresh)
        arg5 = coder.newtype('double',[1 99],[0 1]); % niter (number of iterations)
    end
    %arg2.Sparse = true;
    argz = {arg1,arg2,arg3,arg4,arg5};

    codegen(funs,"-o",funz(v),"-config",cfg,"-args",argz,"-gpuprofile");

    movefile(fnc+funs,d.srcCUDA+funz(v),"f");
    movefile(funz(v)+".mexa64",fn+funz(v)+".mexa64");
    delete(d.srcCUDA+funz(v)+filesep+funz(v)+".mexa64");
    system('rm -rf codegen');
end



%% CONFIGS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [cfg,d] = getCoderConfigs_lfn

cfg = coder.gpuConfig("mex");
cfg.EnableAutoParallelization = true;
cfg.DeepLearningConfig = coder.DeepLearningConfig("tensorrt");
cfg.TargetLang = "C++";
cfg.DynamicMemoryAllocationThreshold = 65535;
%cfg.FilePartitionMethod = "SingleFile";
cfg.GenerateReport = true;
%cfg.GlobalDataSyncMethod = "SyncAlways"; %= "SyncAtEntryAndExits";
%cfg.ExtrinsicCalls = true;
%cfg.EnableJIT = true;
cfg.InlineBetweenUserFunctions = "Speed";
cfg.InlineBetweenUserAndMathWorksFunctions = "Speed";
cfg.InlineBetweenMathWorksFunctions = "Speed";
cfg.MATLABSourceComments = true;
%cfg.NumberOfCpuThreads = maxNumCompThreads;
cfg.OptimizeReductions = true;
cfg.SIMDAcceleration = "Full";
% cfg.StackUsageMax = floor(gpu.TotalMemory*.95);
cfg.Verbosity = "Verbose";
cfg.GpuConfig.CompilerFlags =...
    "--fmad=true -O3 --extra-device-vectorization -ccbin g++-12"; % --fmad=false --optimize=3
cfg.GpuConfig.ComputeCapability = gpuDevice().ComputeCapability;
cfg.GpuConfig.EnableMemoryManager = true;
%cfg.GpuConfig.CustomComputeCapability = "sm_86";
%cfg.GpuConfig.FreeMode = "AfterAllocate";
%cfg.GpuConfig.MaximumBlocksPerKernel = 3584;
%cfg.GpuConfig.MaxPoolSize = 8192;
%cfg.GpuConfig.StackLimitPerThread = floor((gpu.TotalMemory*.95)/3584);

% Dirs
d = ec_getDirs;
cd(d.srcCUDA); system('rm -rf codegen');
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
%     system("rm -rf "+fnc+funs);
%
%     arg1 = coder.newtype('single',[2147483647-1 65535-1],[1 1]); % xc
%     arg2 = coder.newtype('single',[2147483647-1 1],[1 0]); % Y
%     arg3 = coder.newtype('logical',[2147483647-1 1],[1 0]); % in
%     arg4 = coder.newtype('logical',[2147483647-1 65535-1],[1 1]); % idl
%     arg5 = coder.newtype('int16',[65535-1 1],[1 0]); % bins
%     argz = {arg1,arg2,arg3,arg4,arg5};
%
%     codegen(funs,"-o",funz(v),"-config","cfg","-args",argz);
%
%     movefile(fnc+funs,fn+funz(v),"f");
%     system('rm -rf codegen');
% end
