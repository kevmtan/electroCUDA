//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// fillIn.h
//
// Code generation for function 'fillIn'
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
void sparse_fillIn(emxArray_real_T *this_d, emxArray_int32_T *this_colidx,
                   emxArray_int32_T *this_rowidx);

}

// End of code generation (fillIn.h)
