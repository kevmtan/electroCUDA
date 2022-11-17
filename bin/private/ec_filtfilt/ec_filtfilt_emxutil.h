//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt_emxutil.h
//
// Code generation for function 'ec_filtfilt_emxutil'
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

struct emxArray_int32_T;

struct emxArray_boolean_T;

struct emxArray_uint32_T;

struct emxArray_int8_T;

struct emxArray_struct_T;

// Function Declarations
void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T oldNumel,
                                 const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T oldNumel,
                               const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_int8_T(emxArray_int8_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
                              const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_struct_T(emxArray_struct_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation);

void emxEnsureCapacity_uint32_T(emxArray_uint32_T *emxArray, int32_T oldNumel,
                                const emlrtRTEInfo *srcLocation);

void emxFree_boolean_T(emxArray_boolean_T **pEmxArray);

void emxFree_int32_T(emxArray_int32_T **pEmxArray);

void emxFree_int8_T(emxArray_int8_T **pEmxArray);

void emxFree_real_T(emxArray_real_T **pEmxArray);

void emxFree_struct_T(emxArray_struct_T **pEmxArray);

void emxFree_uint32_T(emxArray_uint32_T **pEmxArray);

void emxInit_boolean_T(emxArray_boolean_T **pEmxArray, int32_T numDimensions,
                       const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
                     const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_int8_T(emxArray_int8_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
                    const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_struct_T(emxArray_struct_T **pEmxArray, int32_T numDimensions,
                      const emlrtRTEInfo *srcLocation, boolean_T doPush);

void emxInit_uint32_T(emxArray_uint32_T **pEmxArray, int32_T numDimensions,
                      const emlrtRTEInfo *srcLocation, boolean_T doPush);

// End of code generation (ec_filtfilt_emxutil.h)
