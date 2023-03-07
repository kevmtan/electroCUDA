//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecc_detrend.h
//
// Code generation for function 'ecc_detrend'
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

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void ecc_detrend(emxArray_real32_T *x, emxArray_real32_T *w, real32_T order,
                 real32_T thr, real32_T nItr, real32_T winSz);

void ecc_detrend_api(const mxArray *const prhs[6], int32_T nlhs,
                     const mxArray *plhs[2]);

void ecc_detrend_atexit();

void ecc_detrend_initialize();

void ecc_detrend_terminate();

// End of code generation (ecc_detrend.h)
