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
#include "MWErrorCodeUtils.hpp"
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
void b_raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                      const char_T *errorName, const char_T *errorString);

void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T b_line);

int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);

uint64_T computeNumIters(int32_T ub, int32_T b_ub);

uint64_T computeNumIters(int32_T ub);

void cublasCheck(cublasStatus_t errCode, const char_T *file, uint32_T b_line);

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

void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                    const char_T *errorName, const char_T *errorString);

// End of code generation (ec_detr_fp_mexutil.h)
