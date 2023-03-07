//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecc_cwt.h
//
// Code generation for function 'ecc_cwt'
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
void ecc_cwt(const emxArray_real_T *x, real_T fs, real_T fLims[2],
             real_T fOctave, emxArray_real_T *xx, emxArray_real_T *freqs);

void ecc_cwt_api(const mxArray *const prhs[4], int32_T nlhs,
                 const mxArray *plhs[2]);

void ecc_cwt_atexit();

void ecc_cwt_initialize();

void ecc_cwt_terminate();

// End of code generation (ecc_cwt.h)
