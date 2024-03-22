//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// mod.cu
//
// Code generation for function 'mod'
//

// Include files
#include "mod.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Function Definitions
//
//
namespace coder {
real_T b_mod(real_T x, real_T y)
{
  real_T r;
  nvtxRangePushA("#fcn#b_mod#" MW_AT_LOCATION);
  r = x;
  if (y == 0.0) {
    if (x == 0.0) {
      r = 0.0;
    }
  } else if (std::isnan(x) || std::isnan(y) || std::isinf(x)) {
    r = rtNaN;
  } else if (x == 0.0) {
    r = 0.0 / y;
  } else if (std::isinf(y)) {
    if (x < 0.0) {
      r = y;
    }
  } else {
    r = std::fmod(x, y);
    if (r == 0.0) {
      r = y * 0.0;
    } else if (x < 0.0) {
      r += y;
    }
  }
  nvtxRangePop();
  return r;
}

} // namespace coder

// End of code generation (mod.cu)
