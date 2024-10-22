//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// filtfilt.h
//
// Code generation for function 'filtfilt'
//

#pragma once

// Include files
#include "filtfilt_types.h"
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

// Function Declarations
namespace coder {
void filtfilt(const emxArray_real32_T *ctf, const emxArray_real32_T *varargin_1,
              const emxArray_real32_T *varargin_2, emxArray_real32_T *y);

}

// End of code generation (filtfilt.h)
