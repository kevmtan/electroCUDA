//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// cwt.h
//
// Code generation for function 'cwt'
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
struct emxArray_real32_T;

struct emxArray_creal32_T;

// Function Declarations
namespace coder {
void cwt(emxArray_real32_T *cpu_x, emxArray_real32_T *gpu_x,
         boolean_T *x_outdatedOnGpu, real_T fs, const real_T varargin_2[2],
         real_T varargin_4, emxArray_creal32_T *cpu_cfs,
         boolean_T *cfs_outdatedOnCpu, emxArray_creal32_T *gpu_cfs,
         boolean_T *cfs_outdatedOnGpu);

}
void cwt_emx_free();

void cwt_emx_init();

void cwt_init();

// End of code generation (cwt.h)
