//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecu_cwt64_avg.h
//
// Code generation for function 'ecu_cwt64_avg'
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

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void ecu_cwt64_avg(const emxArray_real_T *x, real_T fs, const real_T fLims[2],
                   real_T fOctave, emxArray_real_T *xx, emxArray_real_T *freqs);

void ecu_cwt64_avg_api(const mxArray *const prhs[4], int32_T nlhs,
                       const mxArray *plhs[2]);

void ecu_cwt64_avg_atexit();

void ecu_cwt64_avg_initialize();

void ecu_cwt64_avg_terminate();

// End of code generation (ecu_cwt64_avg.h)
