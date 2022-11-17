% This script is created from gpucoderSetup on 17-Nov-2022 03:37:25 
 

% Selecting Gpu 
gpuDevice(1);

% CUDA Installation Path 
setenv('LD_LIBRARY_PATH', ['/usr/local/cuda/lib64' pathsep getenv('LD_LIBRARY_PATH')]);
setenv('PATH', ['/usr/local/cuda/bin' pathsep getenv('PATH')]);

% cuDNN Installation Path 
setenv('NVIDIA_CUDNN','/usr/local/cuda');

% NVTX Library Path 
setenv('LD_LIBRARY_PATH', ['/usr/local/cuda/lib64' pathsep getenv('LD_LIBRARY_PATH')]);