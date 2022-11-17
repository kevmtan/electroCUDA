//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTsingle_data.h
//
// Code generation for function 'ec_CWTsingle_data'
//

#pragma once

// Include files
#include "ec_CWTsingle_types.h"
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

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emxArray_real32_T *psidft;
extern boolean_T psidft_not_empty;
extern emxArray_real32_T *cf;
extern emlrtContext emlrtContextGlobal;

// End of code generation (ec_CWTsingle_data.h)
