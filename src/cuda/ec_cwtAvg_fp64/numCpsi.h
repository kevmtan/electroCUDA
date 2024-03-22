//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// numCpsi.h
//
// Code generation for function 'numCpsi'
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
real_T numCpsi(const char_T wname[5], real_T varargin_1, real_T varargin_2);

}
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (numCpsi.h)
