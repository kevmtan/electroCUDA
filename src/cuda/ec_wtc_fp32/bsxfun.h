//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// bsxfun.h
//
// Code generation for function 'bsxfun'
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
struct emxArray_creal32_T;

struct emxArray_real32_T;

// Function Declarations
namespace coder {
void bsxfun(const emxArray_creal32_T *a, const emxArray_real32_T *b,
            emxArray_creal32_T *c);

}

// End of code generation (bsxfun.h)
