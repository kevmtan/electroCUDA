//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// mtimes.h
//
// Code generation for function 'mtimes'
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
namespace internal {
namespace blas {
void b_mtimes(emxArray_real32_T *cpu_A, emxArray_real32_T *gpu_A,
              boolean_T *A_outdatedOnGpu, emxArray_real32_T *cpu_B,
              emxArray_real32_T *gpu_B, boolean_T *B_outdatedOnGpu,
              emxArray_real32_T *cpu_C, boolean_T *C_outdatedOnCpu,
              emxArray_real32_T *gpu_C, boolean_T *C_outdatedOnGpu);

void mtimes(emxArray_real32_T *cpu_A, emxArray_real32_T *gpu_A,
            boolean_T *A_outdatedOnGpu, emxArray_real32_T *cpu_B,
            emxArray_real32_T *gpu_B, boolean_T *B_outdatedOnGpu,
            emxArray_real32_T *cpu_C, boolean_T *C_outdatedOnCpu,
            emxArray_real32_T *gpu_C, boolean_T *C_outdatedOnGpu);

} // namespace blas
} // namespace internal
} // namespace coder

// End of code generation (mtimes.h)
