//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt.h
//
// Code generation for function 'ec_filtfilt'
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
void ec_filtfilt(emxArray_real_T *x, const emxArray_real_T *coef);

void ec_filtfilt_api(const mxArray *const prhs[2], const mxArray *plhs[1]);

void ec_filtfilt_atexit();

void ec_filtfilt_initialize();

void ec_filtfilt_terminate();

// End of code generation (ec_filtfilt.h)
