//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// smoothCFS.h
//
// Code generation for function 'smoothCFS'
//

#pragma once

// Include files
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

// Custom Header Code

#ifdef __CUDA_ARCH__
#undef printf
#endif

// Type Declarations
struct emxArray_real_T;

struct emxArray_creal_T;

// Function Declarations
namespace coder {
namespace wavelet {
namespace internal {
namespace cwt {
void b_smoothCFS(emxArray_creal_T *cpu_cfs, boolean_T *cfs_outdatedOnCpu,
                 emxArray_creal_T *gpu_cfs, boolean_T *cfs_outdatedOnGpu,
                 emxArray_real_T *cpu_scales, emxArray_real_T *gpu_scales,
                 boolean_T *scales_outdatedOnGpu, real_T ns);

void smoothCFS(emxArray_real_T *cpu_cfs, boolean_T *cfs_outdatedOnCpu,
               emxArray_real_T *gpu_cfs, boolean_T *cfs_outdatedOnGpu,
               emxArray_real_T *cpu_scales, emxArray_real_T *gpu_scales,
               boolean_T *scales_outdatedOnGpu, real_T ns);

} // namespace cwt
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (smoothCFS.h)
