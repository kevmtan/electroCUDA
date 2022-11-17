//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt.h
//
// Code generation for function 'ec_filtfilt'
//

#pragma once

// Include files
#include "ec_filtfilt_types.h"
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
void ec_filtfilt(const emxArray_real_T *x, const emxArray_real_T *coef,
                 emxArray_real_T *xx);

// End of code generation (ec_filtfilt.h)
