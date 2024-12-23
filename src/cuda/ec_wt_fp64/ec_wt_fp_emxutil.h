//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wt_fp_emxutil.h
//
// Code generation for function 'ec_wt_fp_emxutil'
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

struct cell_wrap_0;

struct emxArray_cell_wrap_0;

struct emxArray_char_T;

// Function Declarations
int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);

void emxEnsureCapacity_cell_wrap_0(emxArray_cell_wrap_0 *emxArray,
                                   int32_T oldNumel,
                                   const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_creal_T(emxArray_creal_T *emxArray, int32_T oldNumel,
                               const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation);

void emxExpand_cell_wrap_0(emxArray_cell_wrap_0 *emxArray, int32_T fromIndex,
                           int32_T toIndex, const emlrtRTEInfo *srcLocation);

void emxFreeStruct_cell_wrap_0(cell_wrap_0 *pStruct);

void emxFree_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray);

void emxFree_char_T(emxArray_char_T **pEmxArray);

void emxFree_creal_T(emxArray_creal_T **pEmxArray);

void emxFree_real_T(emxArray_real_T **pEmxArray);

void emxInitStruct_cell_wrap_0(cell_wrap_0 *pStruct,
                               const emlrtRTEInfo *srcLocation,
                               boolean_T doPush);

void emxInit_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray,
                         int32_T numDimensions, const emlrtRTEInfo *srcLocation,
                         boolean_T doPush);

void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_creal_T(emxArray_creal_T **pEmxArray, int32_T numDimensions,
                     const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxTrim_cell_wrap_0(emxArray_cell_wrap_0 *emxArray, int32_T fromIndex,
                         int32_T toIndex);

// End of code generation (ec_wt_fp_emxutil.h)
