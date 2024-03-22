//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtc_fp.h
//
// Code generation for function 'ec_wtc_fp'
//

#pragma once

// Include files
#include "ec_wtc_fp_types.h"
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
void ec_wtc_fp(const emxArray_real32_T *cpu_x, const emxArray_uint16_T *c,
               real_T fs, const real_T fLims[2], real_T fVoices, real_T ds[2],
               emxArray_cell_wrap_0 *xx, emxArray_cell_wrap_0 *yy);

// End of code generation (ec_wtc_fp.h)
