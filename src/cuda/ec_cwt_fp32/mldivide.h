//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// mldivide.h
//
// Code generation for function 'mldivide'
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
void mldivide(const emxArray_real_T *A, const emxArray_real_T *B,
              emxArray_real_T *cpu_Y, boolean_T *Y_outdatedOnCpu,
              emxArray_real_T *gpu_Y, boolean_T *Y_outdatedOnGpu);

}

// End of code generation (mldivide.h)
