//
// Prerelease License - for engineering feedback and testing purposes
// only. Not for sale.
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
struct emxArray_real32_T;

struct emxArray_real_T;

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void ec_cwt(const emxArray_real32_T *cpu_x, real_T fs, real_T cpu_fLims[2],
            real_T fOctave, real32_T ds2, emxArray_real32_T *cpu_xx,
            emxArray_real_T *cpu_freqs);

void ec_cwt_api(const mxArray *const prhs[5], int32_T nlhs,
                const mxArray *plhs[2]);

void ec_cwt_atexit();

void ec_cwt_initialize();

void ec_cwt_terminate();

// End of code generation (ec_cwt.h)
