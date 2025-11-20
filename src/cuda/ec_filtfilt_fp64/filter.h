//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// filter.h
//
// Code generation for function 'filter'
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
void b_filter(emxArray_real_T *cpu_b, boolean_T *b_outdatedOnCpu,
              emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
              emxArray_real_T *cpu_a, boolean_T *a_outdatedOnCpu,
              emxArray_real_T *gpu_a, boolean_T *a_outdatedOnGpu,
              emxArray_real_T *cpu_x, emxArray_real_T *gpu_x,
              boolean_T *x_outdatedOnGpu, emxArray_real_T *cpu_zi,
              boolean_T *zi_outdatedOnCpu, emxArray_real_T *gpu_zi,
              boolean_T *zi_outdatedOnGpu, emxArray_real_T *cpu_y,
              boolean_T *y_outdatedOnCpu, emxArray_real_T *gpu_y,
              boolean_T *y_outdatedOnGpu, emxArray_real_T *cpu_zf,
              boolean_T *zf_outdatedOnCpu, emxArray_real_T *gpu_zf,
              boolean_T *zf_outdatedOnGpu);

void c_filter(emxArray_real_T *cpu_b, boolean_T *b_outdatedOnCpu,
              emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
              emxArray_real_T *cpu_a, boolean_T *a_outdatedOnCpu,
              emxArray_real_T *gpu_a, boolean_T *a_outdatedOnGpu,
              emxArray_real_T *cpu_x, emxArray_real_T *gpu_x,
              boolean_T *x_outdatedOnGpu, emxArray_real_T *cpu_zi,
              boolean_T *zi_outdatedOnCpu, emxArray_real_T *gpu_zi,
              boolean_T *zi_outdatedOnGpu, emxArray_real_T *cpu_y,
              boolean_T *y_outdatedOnCpu, emxArray_real_T *gpu_y,
              boolean_T *y_outdatedOnGpu, emxArray_real_T *cpu_zf,
              boolean_T *zf_outdatedOnCpu, emxArray_real_T *gpu_zf,
              boolean_T *zf_outdatedOnGpu);

void d_filter(emxArray_real_T *cpu_b, boolean_T *b_outdatedOnCpu,
              emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
              emxArray_real_T *cpu_a, boolean_T *a_outdatedOnCpu,
              emxArray_real_T *gpu_a, boolean_T *a_outdatedOnGpu,
              emxArray_real_T *cpu_x, emxArray_real_T *gpu_x,
              boolean_T *x_outdatedOnGpu, emxArray_real_T *cpu_zi,
              boolean_T *zi_outdatedOnCpu, emxArray_real_T *gpu_zi,
              boolean_T *zi_outdatedOnGpu, emxArray_real_T *cpu_y,
              boolean_T *y_outdatedOnCpu, emxArray_real_T *gpu_y,
              boolean_T *y_outdatedOnGpu);

void filter(emxArray_real_T *cpu_b, boolean_T *b_outdatedOnCpu,
            emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
            emxArray_real_T *cpu_a, boolean_T *a_outdatedOnCpu,
            emxArray_real_T *gpu_a, boolean_T *a_outdatedOnGpu,
            emxArray_real_T *cpu_x, emxArray_real_T *gpu_x,
            boolean_T *x_outdatedOnGpu, emxArray_real_T *cpu_zi,
            boolean_T *zi_outdatedOnCpu, emxArray_real_T *gpu_zi,
            boolean_T *zi_outdatedOnGpu, emxArray_real_T *cpu_y,
            boolean_T *y_outdatedOnCpu, emxArray_real_T *gpu_y,
            boolean_T *y_outdatedOnGpu);

} // namespace coder

// End of code generation (filter.h)
