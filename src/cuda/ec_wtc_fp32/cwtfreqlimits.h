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
real_T cwtfreqlimits(real_T N, real_T cutoff, real_T varargin_1,
                     real_T varargin_3, real_T *maxperiod, real_T *maxscale,
                     real_T *minscale, real_T *maxfreq, real_T *minperiod);

real_T getFreqFromCutoffAmor(real_T cutoff, real_T cf);

real_T getFreqFromCutoffBump(real_T cutoff, real_T cf);

real_T getFreqFromCutoffMorse(real_T cutoff, real_T cf, real_T ga, real_T be);

} // namespace cwt
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (cwtfreqlimits.h)
