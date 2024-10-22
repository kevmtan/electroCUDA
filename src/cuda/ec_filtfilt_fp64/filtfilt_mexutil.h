//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// filtfilt_mexutil.h
//
// Code generation for function 'filtfilt_mexutil'
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
void checkCudaError(cudaError_t errorCode, const char_T *file, int32_T b_line);

int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);

void gpuEmxFree_real_T(emxArray_real_T *gpu);

void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T *gpu);

void gpuEmxReset_real_T(emxArray_real_T *gpu);

void gpuThrowError(uint32_T errorCode, const char_T *errorName,
                   const char_T *errorString, const char_T *file,
                   int32_T b_line);

// End of code generation (filtfilt_mexutil.h)
