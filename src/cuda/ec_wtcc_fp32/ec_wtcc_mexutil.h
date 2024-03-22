//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtcc_mexutil.h
//
// Code generation for function 'ec_wtcc_mexutil'
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
struct emxArray_creal32_T;

struct emxArray_real_T;

struct emxArray_real32_T;

struct emxArray_int32_T;

struct emxArray_uint32_T;

// Function Declarations
void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId,
                        char_T ret[23]);

void b_raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                      const char_T *errorName, const char_T *errorString);

const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
                         emlrtMCInfo *location);

real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId);

void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T b_line);

int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);

uint64_T computeNumIters(int32_T ub);

uint64_T computeNumIters(int32_T ub, int32_T b_ub);

int32_T div_s32(int32_T numerator, int32_T denominator);

real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId);

void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId,
                      char_T y[23]);

void emlrt_marshallIn(const mxArray *a__output_of_sprintf_,
                      const char_T *identifier, char_T y[23]);

real_T emlrt_marshallIn(const mxArray *a__output_of_length_,
                        const char_T *identifier);

void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
                                    emxArray_creal32_T *gpu,
                                    boolean_T needsCopy);

void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
                                  emxArray_int32_T *gpu, boolean_T needsCopy);

void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
                                   emxArray_real32_T *gpu, boolean_T needsCopy);

void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
                                 emxArray_real_T *gpu, boolean_T needsCopy);

void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
                                   emxArray_uint32_T *gpu, boolean_T needsCopy);

void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu);

void gpuEmxFree_int32_T(emxArray_int32_T *gpu);

void gpuEmxFree_real32_T(emxArray_real32_T *gpu);

void gpuEmxFree_real_T(emxArray_real_T *gpu);

void gpuEmxFree_uint32_T(emxArray_uint32_T *gpu);

void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu,
                                    const emxArray_creal32_T *cpu);

void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu,
                                  const emxArray_int32_T *cpu);

void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                   const emxArray_real32_T *cpu);

void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu,
                                 const emxArray_real_T *cpu);

void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
                                    emxArray_creal32_T *gpu);

void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                   emxArray_real32_T *gpu);

void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T *gpu);

void gpuEmxReset_creal32_T(emxArray_creal32_T *gpu);

void gpuEmxReset_int32_T(emxArray_int32_T *gpu);

void gpuEmxReset_real32_T(emxArray_real32_T *gpu);

void gpuEmxReset_real_T(emxArray_real_T *gpu);

void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu);

void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                    const char_T *errorName, const char_T *errorString);

real_T rt_hypotd_snf(real_T u0, real_T u1);

real_T rt_powd_snf(real_T u0, real_T u1);

// End of code generation (ec_wtcc_mexutil.h)
