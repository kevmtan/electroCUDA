//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// wcoherence.h
//
// Code generation for function 'wcoherence'
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
void wcoherence(const emxArray_real32_T *x, const emxArray_real32_T *y,
                real_T varargin_1, const real_T varargin_3[2],
                real_T varargin_5, emxArray_real32_T *wcoh,
                emxArray_creal32_T *cpu_wcs, boolean_T *wcs_outdatedOnCpu,
                emxArray_creal32_T *gpu_wcs, boolean_T *wcs_outdatedOnGpu);

}

// End of code generation (wcoherence.h)
