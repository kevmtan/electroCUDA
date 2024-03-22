//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// conv2.h
//
// Code generation for function 'conv2'
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

// Function Declarations
namespace coder {
void conv2NonSeparable(const emxArray_real32_T *cpu_a, emxArray_real32_T *cpu_b,
                       emxArray_real32_T *gpu_b, boolean_T *b_outdatedOnGpu,
                       emxArray_real32_T *cpu_c, boolean_T *c_outdatedOnCpu,
                       emxArray_real32_T *gpu_c, boolean_T *c_outdatedOnGpu);

}

// End of code generation (conv2.h)
