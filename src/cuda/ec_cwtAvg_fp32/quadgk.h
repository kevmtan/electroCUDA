//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// quadgk.h
//
// Code generation for function 'quadgk'
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
void binary_expand_op_4(emxArray_real_T *in1, const emxArray_real_T *in2,
                        const emxArray_real_T *in3, const emxArray_real_T *in4);

void binary_expand_op_7(emxArray_real_T *in1, const emxArray_real_T *in2,
                        const emxArray_real_T *in3, const emxArray_real_T *in4);

namespace coder {
real_T quadgk(real_T fun_workspace_be, real_T fun_workspace_ga);

int32_T split(real_T x[650], int32_T nx, real_T *pathlen);

} // namespace coder

// End of code generation (quadgk.h)
