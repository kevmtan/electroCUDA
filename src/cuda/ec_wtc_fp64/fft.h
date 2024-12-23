//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// fft.h
//
// Code generation for function 'fft'
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
void fft(emxArray_real_T *cpu_x, boolean_T *x_outdatedOnCpu,
         emxArray_real_T *gpu_x, boolean_T *x_outdatedOnGpu,
         emxArray_creal_T *cpu_y, boolean_T *y_outdatedOnCpu,
         emxArray_creal_T *gpu_y, boolean_T *y_outdatedOnGpu);

}

// End of code generation (fft.h)
