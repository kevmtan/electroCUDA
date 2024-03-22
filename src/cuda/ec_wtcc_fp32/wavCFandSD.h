//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// wavCFandSD.h
//
// Code generation for function 'wavCFandSD'
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
namespace wavelet {
namespace internal {
namespace cwt {
real_T wavCFandSD(char_T wname[4], real_T varargin_1, real_T varargin_2,
                  real_T *sigmaT, real_T *cf);

}
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (wavCFandSD.h)
