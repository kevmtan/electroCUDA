//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// sparse.h
//
// Code generation for function 'sparse'
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

// Type Declarations
struct emxArray_real_T;

struct emxArray_int32_T;

// Function Declarations
namespace coder {
void sparse_ctranspose(const emxArray_real_T *this_d,
                       const emxArray_int32_T *this_colidx,
                       const emxArray_int32_T *this_rowidx, int32_T this_m,
                       int32_T this_n, emxArray_real_T *y_d,
                       emxArray_int32_T *y_colidx, emxArray_int32_T *y_rowidx,
                       int32_T *y_m, int32_T *y_n);

}

// End of code generation (sparse.h)
