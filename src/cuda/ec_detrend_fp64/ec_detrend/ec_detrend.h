//
// Prerelease License - for engineering feedback and testing purposes
// only. Not for sale.
//
// ec_detrend.h
//
// Code generation for function 'ec_detrend'
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
void ec_detrend(emxArray_real_T *cpu_x, emxArray_real_T *cpu_w, real_T order,
                real_T thr, real_T nItr, real_T winSz);

void ec_detrend_api(const mxArray *const prhs[6], int32_T nlhs,
                    const mxArray *plhs[2]);

void ec_detrend_atexit();

void ec_detrend_initialize();

void ec_detrend_terminate();

// End of code generation (ec_detrend.h)
