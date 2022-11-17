//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTsingle.h
//
// Code generation for function 'ec_CWTsingle'
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

// Function Declarations
void ec_CWTsingle(const emxArray_real32_T *x, real_T fs, real_T freqLims[2],
                  boolean_T doAvg, real_T freqsPerOctave, emxArray_real32_T *wt,
                  emxArray_real32_T *freqs, emxArray_real32_T *coi);

// End of code generation (ec_CWTsingle.h)
