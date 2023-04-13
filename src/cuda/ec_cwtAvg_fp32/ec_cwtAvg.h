//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_cwtAvg.h
//
// Code generation for function 'ec_cwtAvg'
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

struct emxArray_real_T;

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void ec_cwtAvg(const emxArray_real32_T *cpu_x, real_T fs, real_T cpu_fLims[2],
               real_T fOctave, emxArray_real_T *cpu_freqs);

void ec_cwtAvg_api(const mxArray *const prhs[4], int32_T nlhs,
                   const mxArray *plhs[2]);

void ec_cwtAvg_atexit();

void ec_cwtAvg_initialize();

void ec_cwtAvg_terminate();

// End of code generation (ec_cwtAvg.h)
