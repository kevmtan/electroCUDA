//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wt_fp_mexutil.h
//
// Code generation for function 'ec_wt_fp_mexutil'
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

struct emxArray_creal_T;

// Function Declarations
void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T b_line);

uint64_T computeNumIters(int32_T ub, int32_T b_ub);

uint64_T computeNumIters(int32_T ub);

real_T d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId);

real_T emlrt_marshallIn(const mxArray *a__output_of_length_,
                        const char_T *identifier);

real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId);

void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
                                  emxArray_creal_T *gpu, boolean_T needsCopy);

void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
                                 emxArray_real_T *gpu, boolean_T needsCopy);

void gpuEmxFree_creal_T(emxArray_creal_T *gpu);

void gpuEmxFree_real_T(emxArray_real_T *gpu);

void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu,
                                 const emxArray_real_T *cpu);

void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T *gpu);

void gpuEmxReset_creal_T(emxArray_creal_T *gpu);

void gpuEmxReset_real_T(emxArray_real_T *gpu);

void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                    const char_T *errorName, const char_T *errorString);

// End of code generation (ec_wt_fp_mexutil.h)
