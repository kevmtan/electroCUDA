//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wt2_fp.h
//
// Code generation for function 'ec_wt2_fp'
//

#pragma once

// Include files
#include "ec_wt2_fp_types.h"
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
void ec_wt2_fp(const emxArray_real32_T *cpu_x, real_T fs, const real_T lims[2],
               real_T voices, real_T ds, boolean_T doReal, boolean_T doPwr,
               emxArray_cell_wrap_0 *y, emxArray_real_T *frqs);

// End of code generation (ec_wt2_fp.h)
