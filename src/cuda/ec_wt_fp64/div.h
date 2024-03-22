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
struct emxArray_real_T;

namespace coder {
struct cwtfilterbank;

}

// Function Declarations
void binary_expand_op_6(emxArray_real_T *in1, const emxArray_real_T *in2,
                        const coder::cwtfilterbank *in3);

// End of code generation (div.h)
