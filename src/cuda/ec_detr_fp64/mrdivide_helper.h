//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// mrdivide_helper.h
//
// Code generation for function 'mrdivide_helper'
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

// Function Declarations
namespace coder {
namespace internal {
void mrdiv(emxArray_real_T *cpu_A, boolean_T *A_outdatedOnCpu,
           emxArray_real_T *gpu_A, boolean_T *A_outdatedOnGpu,
           const emxArray_real_T *B);

}
} // namespace coder

// End of code generation (mrdivide_helper.h)
