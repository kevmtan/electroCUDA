//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr_fp.h
//
// Code generation for function 'ec_detr_fp'
//

#pragma once

// Include files
#include "ec_detr_fp_types.h"
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
void ec_detr_fp(emxArray_real_T *cpu_x, emxArray_real_T *cpu_w,
                const real_T ord_data[], const int32_T ord_size[2],
                const real_T thr_data[], const int32_T thr_size[2],
                const real_T itr_data[], const int32_T itr_size[2],
                real_T olPct_data[], int32_T olPct_size[2]);

// End of code generation (ec_detr_fp.h)
