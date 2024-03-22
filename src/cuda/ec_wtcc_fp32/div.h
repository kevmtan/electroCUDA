//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// div.h
//
// Code generation for function 'div'
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
struct emxArray_real32_T;

// Function Declarations
void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T *in2,
                      const emxArray_real32_T *in3,
                      const emxArray_real32_T *in4);

// End of code generation (div.h)
