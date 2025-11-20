//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// cwtfreqlimits.h
//
// Code generation for function 'cwtfreqlimits'
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
real_T getFreqFromCutoffMorse(real_T cutoff, real_T cf, real_T ga, real_T be);

}
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (cwtfreqlimits.h)
