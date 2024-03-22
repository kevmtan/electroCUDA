//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// upfirdn.h
//
// Code generation for function 'upfirdn'
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
void upfirdn(emxArray_real_T *cpu_x, emxArray_real_T *gpu_x,
             boolean_T *x_outdatedOnGpu, emxArray_real_T *cpu_h,
             boolean_T *h_outdatedOnCpu, emxArray_real_T *gpu_h,
             boolean_T *h_outdatedOnGpu, real_T varargin_1, real_T varargin_2,
             emxArray_real_T *cpu_y_out, boolean_T *y_out_outdatedOnCpu,
             emxArray_real_T *gpu_y_out, boolean_T *y_out_outdatedOnGpu);

}

// End of code generation (upfirdn.h)
