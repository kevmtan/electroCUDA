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
struct emxArray_creal32_T;

struct emxArray_real32_T;

// Function Declarations
namespace coder {
namespace b_signal {
namespace internal {
namespace resample {
void uniformResampleAlongFirstDim(
    emxArray_creal32_T *cpu_xIn, boolean_T *xIn_outdatedOnCpu,
    emxArray_creal32_T *gpu_xIn, boolean_T *xIn_outdatedOnGpu, real_T opts_p,
    real_T opts_q, const emxArray_real32_T *cpu_opts_filterWithPadding,
    real_T opts_filterDelay);

}
} // namespace internal
} // namespace b_signal
} // namespace coder

// End of code generation (uniformResampleKernel.h)
