#!/bin/sh
export PATH="/usr/local/MATLAB/R2024b/sys/cuda/glnxa64/cuda/bin:/usr/local/MATLAB/R2024b/sys/cuda/glnxa64/cuda/nvvm/bin:$PATH" ; "/usr/local/MATLAB/R2024b/toolbox/shared/coder/ninja/glnxa64/ninja" -v "$@"
