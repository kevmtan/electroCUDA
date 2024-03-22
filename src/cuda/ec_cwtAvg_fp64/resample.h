//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// resample.h
//
// Code generation for function 'resample'
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
void resample(emxArray_real_T *cpu_varargin_1, emxArray_real_T *gpu_varargin_1,
              boolean_T *varargin_1_outdatedOnGpu, real_T varargin_2,
              real_T varargin_3, emxArray_real_T *cpu_varargout_1,
              boolean_T *varargout_1_outdatedOnCpu,
              emxArray_real_T *gpu_varargout_1,
              boolean_T *varargout_1_outdatedOnGpu);

}

// End of code generation (resample.h)
