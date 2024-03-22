//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// uniformResampleKernel.h
//
// Code generation for function 'uniformResampleKernel'
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
namespace b_signal {
namespace internal {
namespace resample {
void b_uniformResampleAlongFirstDim(
    emxArray_creal_T *cpu_xIn, boolean_T *xIn_outdatedOnCpu,
    emxArray_creal_T *gpu_xIn, boolean_T *xIn_outdatedOnGpu, real_T opts_p,
    real_T opts_q, emxArray_real_T *cpu_opts_filterWithPadding,
    boolean_T *c_opts_filterWithPadding_outdat,
    emxArray_real_T *gpu_opts_filterWithPadding,
    boolean_T *d_opts_filterWithPadding_outdat, real_T opts_filterDelay);

void uniformResampleAlongFirstDim(
    emxArray_real_T *cpu_xIn, boolean_T *xIn_outdatedOnCpu,
    emxArray_real_T *gpu_xIn, boolean_T *xIn_outdatedOnGpu, real_T opts_p,
    real_T opts_q, emxArray_real_T *cpu_opts_filterWithPadding,
    boolean_T *c_opts_filterWithPadding_outdat,
    emxArray_real_T *gpu_opts_filterWithPadding,
    boolean_T *d_opts_filterWithPadding_outdat, real_T opts_filterDelay);

} // namespace resample
} // namespace internal
} // namespace b_signal
} // namespace coder

// End of code generation (uniformResampleKernel.h)
