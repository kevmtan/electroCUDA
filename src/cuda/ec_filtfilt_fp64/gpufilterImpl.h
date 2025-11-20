//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// gpufilterImpl.h
//
// Code generation for function 'gpufilterImpl'
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
void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2);

// End of code generation (gpufilterImpl.h)
