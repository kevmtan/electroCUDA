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
#include "ec_cwt_types.h"
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
void ec_cwt(const emxArray_real32_T *cpu_x, real_T fs, const real_T fLims[2],
            real_T fVoices, const real_T ds[2], emxArray_cell_wrap_0 *y,
            emxArray_real_T *freqs);

// End of code generation (ec_cwt.h)
