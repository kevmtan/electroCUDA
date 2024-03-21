//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_cwt.h
//
// Code generation for function 'ec_cwt'
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
struct ec_cwtStackData;

struct emxArray_real32_T;

struct cell_wrap_0;

struct emxArray_real_T;

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void b_ec_cwt_api(ec_cwtStackData *SD, const mxArray *const prhs[5],
                  int32_T nlhs, const mxArray *plhs[2]);

void ec_cwt(ec_cwtStackData *SD, const emxArray_real32_T *cpu_x, real_T fs,
            const real_T fLims[2], real_T fOctave, const real32_T ds[2],
            cell_wrap_0 y_data[], int32_T y_size[2],
            emxArray_real_T *cpu_freqs);

void ec_cwt_atexit();

void ec_cwt_initialize();

void ec_cwt_terminate();

// End of code generation (ec_cwt.h)
