//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtAvg_fp_emxutil.h
//
// Code generation for function 'ec_wtAvg_fp_emxutil'
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

namespace coder {
struct cwtfilterbank;

}
struct emxArray_char_T;

struct emxArray_uint32_T;

// Function Declarations
void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_creal_T(emxArray_creal_T *emxArray, int32_T oldNumel,
                               const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_uint32_T(emxArray_uint32_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation);

void emxFreeStruct_cwtfilterbank(coder::cwtfilterbank *pStruct);

void emxFree_char_T(emxArray_char_T **pEmxArray);

void emxFree_creal_T(emxArray_creal_T **pEmxArray);

void emxFree_real_T(emxArray_real_T **pEmxArray);

void emxFree_uint32_T(emxArray_uint32_T **pEmxArray);

void emxInitStruct_cwtfilterbank(coder::cwtfilterbank *pStruct,
                                 const emlrtRTEInfo *srcLocation,
                                 boolean_T doPush);

void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_creal_T(emxArray_creal_T **pEmxArray, int32_T numDimensions,
                     const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_uint32_T(emxArray_uint32_T **pEmxArray, int32_T numDimensions,
                      const emlrtRTEInfo *srcLocation, boolean_T doPush);

// End of code generation (ec_wtAvg_fp_emxutil.h)
