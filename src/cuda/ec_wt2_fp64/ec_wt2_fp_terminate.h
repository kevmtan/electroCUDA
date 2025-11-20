//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wt2_fp_terminate.h
//
// Code generation for function 'ec_wt2_fp_terminate'
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

// Function Declarations
void ec_wt2_fp_atexit();

void ec_wt2_fp_terminate();

// End of code generation (ec_wt2_fp_terminate.h)
