//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// circshift.h
//
// Code generation for function 'circshift'
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

// Function Declarations
namespace coder {
void circshift(int32_T cpu_a[2], boolean_T *a_outdatedOnCpu, int32_T gpu_a[2],
               boolean_T *a_outdatedOnGpu, int32_T p);

}

// End of code generation (circshift.h)
