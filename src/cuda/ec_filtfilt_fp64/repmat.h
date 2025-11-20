//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// repmat.h
//
// Code generation for function 'repmat'
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

// Function Declarations
namespace coder {
void repmat(const emxArray_real_T *a, real_T varargin_1, emxArray_real_T *b);

}

// End of code generation (repmat.h)
