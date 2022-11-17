//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTdouble.h
//
// Code generation for function 'ec_CWTdouble'
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
void ec_CWTdouble(const emxArray_real_T *x, real_T fs, real_T freqLims[2],
                  boolean_T doAvg, real_T freqsPerOctave, emxArray_real_T *wt,
                  emxArray_real_T *freqs, emxArray_real_T *coi);

void ec_CWTdouble_api(const mxArray *const prhs[5], int32_T nlhs,
                      const mxArray *plhs[3]);

void ec_CWTdouble_atexit();

void ec_CWTdouble_initialize();

void ec_CWTdouble_terminate();

// End of code generation (ec_CWTdouble.h)
