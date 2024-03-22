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
struct emxArray_creal_T;

struct emxArray_real_T;

// Function Declarations
namespace coder {
void b_conv2(const emxArray_creal_T *cpu_a, const emxArray_real_T *cpu_b,
             emxArray_creal_T *cpu_c, boolean_T *c_outdatedOnCpu,
             emxArray_creal_T *gpu_c, boolean_T *c_outdatedOnGpu);

void conv2(const emxArray_creal_T *cpu_a, emxArray_real_T *cpu_b,
           boolean_T *b_outdatedOnCpu, emxArray_real_T *gpu_b,
           boolean_T *b_outdatedOnGpu, emxArray_creal_T *cpu_c,
           boolean_T *c_outdatedOnCpu, emxArray_creal_T *gpu_c,
           boolean_T *c_outdatedOnGpu);

} // namespace coder

// End of code generation (conv2.h)
