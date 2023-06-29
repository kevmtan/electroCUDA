#!/bin/sh
export PATH="/usr/local/MATLAB/R2023b/sys/cuda/glnxa64/cuda/bin:/usr/local/MATLAB/R2023b/sys/cuda/glnxa64/cuda/nvvm/bin:$PATH" ; "/usr/local/MATLAB/R2023b/toolbox/shared/coder/ninja/glnxa64/ninja" -v "$@"
