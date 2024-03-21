//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtcc.h
//
// Code generation for function 'ec_wtcc'
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
struct ec_wtccStackData;

struct emxArray_real32_T;

struct cell_wrap_0;

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void b_ec_wtcc_api(ec_wtccStackData *SD, const mxArray *const prhs[6],
                   int32_T nlhs, const mxArray *plhs[2]);

void ec_wtcc(ec_wtccStackData *SD, const emxArray_real32_T *cpu_x,
             const uint16_T c_data[], const int32_T c_size[2], real32_T fs,
             const real32_T fLims[2], real32_T fVoices, const real32_T ds[2],
             cell_wrap_0 xx_data[], int32_T xx_size[2], cell_wrap_0 yy_data[],
             int32_T yy_size[2]);

void ec_wtcc_atexit();

void ec_wtcc_initialize();

void ec_wtcc_terminate();

// End of code generation (ec_wtcc.h)
