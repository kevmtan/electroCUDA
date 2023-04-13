//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr.h
//
// Code generation for function 'ec_detr'
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
void ec_detr(emxArray_real32_T *cpu_x, emxArray_real32_T *cpu_w,
             const real32_T cpu_ord_data[], const int32_T ord_size[2],
             const real32_T cpu_thr_data[], const int32_T thr_size[2],
             const real32_T cpu_itr_data[], const int32_T itr_size[2],
             real32_T cpu_olPct_data[], int32_T olPct_size[2]);

void ec_detr_api(const mxArray *const prhs[5], int32_T nlhs,
                 const mxArray *plhs[3]);

void ec_detr_atexit();

void ec_detr_initialize();

void ec_detr_terminate();

// End of code generation (ec_detr.h)
