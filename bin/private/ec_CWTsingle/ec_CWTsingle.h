//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTsingle.h
//
// Code generation for function 'ec_CWTsingle'
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
void ec_CWTsingle(const emxArray_real32_T *x, real_T fs, real_T freqLims[2],
                  boolean_T doAvg, real_T freqsPerOctave, emxArray_real32_T *wt,
                  emxArray_real32_T *freqs, emxArray_real32_T *coi);

void ec_CWTsingle_api(const mxArray *const prhs[5], int32_T nlhs,
                      const mxArray *plhs[3]);

void ec_CWTsingle_atexit();

void ec_CWTsingle_initialize();

void ec_CWTsingle_terminate();

// End of code generation (ec_CWTsingle.h)
