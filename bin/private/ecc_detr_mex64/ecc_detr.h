//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecc_detr.h
//
// Code generation for function 'ecc_detr'
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
void ecc_detr(emxArray_real_T *x, emxArray_real_T *w,
              const emxArray_real_T *ord, const emxArray_real_T *thr,
              const emxArray_real_T *itr, emxArray_real_T *olPct);

void ecc_detr_api(const mxArray *const prhs[5], int32_T nlhs,
                  const mxArray *plhs[3]);

void ecc_detr_atexit();

void ecc_detr_initialize();

void ecc_detr_terminate();

// End of code generation (ecc_detr.h)
