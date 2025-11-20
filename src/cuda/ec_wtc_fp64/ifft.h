//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ifft.h
//
// Code generation for function 'ifft'
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
struct emxArray_creal_T;

// Function Declarations
namespace coder {
void ifft(const emxArray_creal_T *x, emxArray_creal_T *y);

}

// End of code generation (ifft.h)
