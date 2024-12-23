//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtAvg_fp.h
//
// Code generation for function 'ec_wtAvg_fp'
//

#pragma once

// Include files
#include "ec_wtAvg_fp_types.h"
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
void ec_wtAvg_fp(const emxArray_real_T *cpu_x, real_T fs, const real_T fLims[2],
                 real_T fVoices, real_T ds, boolean_T doPwr,
                 emxArray_real_T *cpu_y, emxArray_real_T *freqs);

// End of code generation (ec_wtAvg_fp.h)
