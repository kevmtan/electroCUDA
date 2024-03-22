//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt_fp.h
//
// Code generation for function 'ec_filtfilt_fp'
//

#pragma once

// Include files
#include "ec_filtfilt_fp_types.h"
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
void ec_filtfilt_fp(const emxArray_real32_T *cpu_x,
                    const emxArray_real32_T *cpu_b,
                    const emxArray_real32_T *cpu_a,
                    const emxArray_real32_T *cpu_z, real32_T nf, real32_T L,
                    emxArray_real32_T *cpu_y);

// End of code generation (ec_filtfilt_fp.h)
