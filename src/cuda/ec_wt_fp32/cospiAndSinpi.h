//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// cospiAndSinpi.h
//
// Code generation for function 'cospiAndSinpi'
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

// Function Declarations
namespace coder {
namespace internal {
namespace scalar {
real_T cospiAndSinpi(real_T x, real_T *s);

}
} // namespace internal
} // namespace coder

// End of code generation (cospiAndSinpi.h)
