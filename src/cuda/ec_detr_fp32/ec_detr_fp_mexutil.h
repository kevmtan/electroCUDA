//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr_fp_mexutil.h
//
// Code generation for function 'ec_detr_fp_mexutil'
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

struct emxArray_int32_T;

// Function Declarations
void checkCudaError(cudaError_t errorCode, const char_T *file, int32_T b_line);

int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);

uint64_T computeNumIters(int32_T ub, int32_T b_ub);

uint64_T computeNumIters(int32_T ub);

void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
                                  emxArray_int32_T *gpu, boolean_T needsCopy);

void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
                                   emxArray_real32_T *gpu, boolean_T needsCopy);

void gpuEmxFree_int32_T(emxArray_int32_T *gpu);

void gpuEmxFree_real32_T(emxArray_real32_T *gpu);

void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu,
                                  const emxArray_int32_T *cpu);

void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                   const emxArray_real32_T *cpu);

void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                   emxArray_real32_T *gpu);

void gpuEmxReset_int32_T(emxArray_int32_T *gpu);

void gpuEmxReset_real32_T(emxArray_real32_T *gpu);

void gpuThrowError(const char_T *file, int32_T b_line);

void gpuThrowError(uint32_T errorCode, const char_T *errorName,
                   const char_T *errorString, const char_T *file,
                   int32_T b_line);

// End of code generation (ec_detr_fp_mexutil.h)
