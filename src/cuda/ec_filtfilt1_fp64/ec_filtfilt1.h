//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt1.h
//
// Code generation for function 'ec_filtfilt1'
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
void ec_filtfilt1(const emxArray_real_T *cpu_x, const emxArray_real_T *cpu_b,
                  const emxArray_real_T *cpu_a, const emxArray_real_T *cpu_z,
                  real_T nf, real_T L, emxArray_real_T *cpu_y);

void ec_filtfilt1_api(const mxArray *const prhs[6], const mxArray *plhs[1]);

void ec_filtfilt1_atexit();

void ec_filtfilt1_initialize();

void ec_filtfilt1_terminate();

// End of code generation (ec_filtfilt1.h)
