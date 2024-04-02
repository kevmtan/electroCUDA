//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// log2.cu
//
// Code generation for function 'log2'
//

// Include files
#include "log2.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Function Definitions
//
//
namespace coder {
real_T b_log2(real_T x)
{
  real_T f;
  int32_T eint;
  nvtxRangePushA("#fcn#b_log2#" MW_AT_LOCATION);
  if (x == 0.0) {
    f = rtMinusInf;
  } else if (x < 0.0) {
    f = rtNaN;
  } else if ((!std::isinf(x)) && (!std::isnan(x))) {
    real_T t;
    t = std::frexp(x, &eint);
    if (t == 0.5) {
      f = static_cast<real_T>(eint) - 1.0;
    } else if ((eint == 1) && (t < 0.75)) {
      f = std::log(2.0 * t) / 0.69314718055994529;
    } else {
      f = std::log(t) / 0.69314718055994529 + static_cast<real_T>(eint);
    }
  } else {
    f = x;
  }
  nvtxRangePop();
  return f;
}

} // namespace coder

// End of code generation (log2.cu)
