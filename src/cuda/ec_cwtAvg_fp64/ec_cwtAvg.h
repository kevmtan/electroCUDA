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
struct ec_cwtAvgStackData;

struct emxArray_real_T;

struct cell_wrap_0;

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void b_ec_cwtAvg_api(ec_cwtAvgStackData *SD, const mxArray *const prhs[5],
                     int32_T nlhs, const mxArray *plhs[2]);

void ec_cwtAvg(ec_cwtAvgStackData *SD, const emxArray_real_T *cpu_x, real_T fs,
               const real_T fLims[2], real_T fOctave, const real_T ds[2],
               cell_wrap_0 y_data[], int32_T y_size[2],
               emxArray_real_T *cpu_freqs);

void ec_cwtAvg_atexit();

void ec_cwtAvg_initialize();

void ec_cwtAvg_terminate();

// End of code generation (ec_cwtAvg.h)
