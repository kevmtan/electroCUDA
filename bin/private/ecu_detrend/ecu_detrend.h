//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecu_detrend.h
//
// Code generation for function 'ecu_detrend'
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

struct emxArray_boolean_T;

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void ecu_detrend(emxArray_real_T *x, real_T order, real_T thresh, real_T niter,
                 real_T wsize, emxArray_boolean_T *w);

void ecu_detrend_api(const mxArray *const prhs[6], int32_T nlhs,
                     const mxArray *plhs[2]);

void ecu_detrend_atexit();

void ecu_detrend_initialize();

void ecu_detrend_terminate();

// End of code generation (ecu_detrend.h)
