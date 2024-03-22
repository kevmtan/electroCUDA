//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt1_emxutil.h
//
// Code generation for function 'ec_filtfilt1_emxutil'
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
void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T oldNumel,
                               const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation);

void emxFree_int32_T(emxArray_int32_T **pEmxArray);

void emxFree_real32_T(emxArray_real32_T **pEmxArray);

void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
                     const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T numDimensions,
                      const emlrtRTEInfo *srcLocation, boolean_T doPush);

// End of code generation (ec_filtfilt1_emxutil.h)
