//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// wt.h
//
// Code generation for function 'wt'
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
namespace coder {
struct cwtfilterbank;

}
struct emxArray_real_T;

struct emxArray_creal_T;

// Function Declarations
namespace coder {
void cwtfilterbank_wt(const cwtfilterbank *self, const emxArray_real_T *x,
                      emxArray_creal_T *varargout_1);

}

// End of code generation (wt.h)
