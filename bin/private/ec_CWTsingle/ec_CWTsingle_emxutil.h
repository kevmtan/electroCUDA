//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTsingle_emxutil.h
//
// Code generation for function 'ec_CWTsingle_emxutil'
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

struct emxArray_creal32_T;

struct emxArray_real_T;

struct emxArray_char_T;

// Function Declarations
void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_creal32_T(emxArray_creal32_T *emxArray, int32_T oldNumel,
                                 const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation);

void emxFree_char_T(emxArray_char_T **pEmxArray);

void emxFree_creal32_T(emxArray_creal32_T **pEmxArray);

void emxFree_real32_T(emxArray_real32_T **pEmxArray);

void emxFree_real_T(emxArray_real_T **pEmxArray);

void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_creal32_T(emxArray_creal32_T **pEmxArray, int32_T numDimensions,
                       const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T numDimensions,
                      const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush);

// End of code generation (ec_CWTsingle_emxutil.h)
