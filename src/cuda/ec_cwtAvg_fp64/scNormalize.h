//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// scNormalize.h
//
// Code generation for function 'scNormalize'
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

struct emxArray_real_T;

// Function Declarations
namespace coder {
namespace wavelet {
namespace internal {
namespace cwt {
void scNormalize(emxArray_creal_T *cfs, real_T cpsi,
                 const emxArray_real_T *scales, real_T normfac);

}
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (scNormalize.h)
