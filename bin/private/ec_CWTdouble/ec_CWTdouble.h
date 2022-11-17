//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTdouble.h
//
// Code generation for function 'ec_CWTdouble'
//

#pragma once

// Include files
#include "ec_CWTdouble_types.h"
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

// Function Declarations
void ec_CWTdouble(const emxArray_real_T *x, real_T fs, real_T freqLims[2],
                  boolean_T doAvg, real_T freqsPerOctave, emxArray_real_T *wt,
                  emxArray_real_T *freqs, emxArray_real_T *coi);

// End of code generation (ec_CWTdouble.h)
