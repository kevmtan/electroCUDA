//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// rat.cu
//
// Code generation for function 'rat'
//

// Include files
#include "rat.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Function Definitions
//
//
namespace coder {
real_T rat(real_T x, real_T *D)
{
  real_T N;
  real_T absx;
  real_T b_x;
  int32_T exponent;
  nvtxRangePushA("#fcn#rat#" MW_AT_LOCATION);
  b_x = x;
  absx = std::abs(x);
  if (std::isinf(absx) || std::isnan(absx)) {
    absx = rtNaN;
  } else if (absx < 4.4501477170144028E-308) {
    absx = 4.94065645841247E-324;
  } else {
    std::frexp(absx, &exponent);
    absx = std::ldexp(1.0, exponent - 53);
  }
  absx = std::fmax(1.0E-12, absx);
  if (std::isinf(x) || std::isnan(x)) {
    N = !std::isnan(x);
    *D = 0.0;
  } else {
    real_T d;
    real_T dlast;
    real_T n;
    real_T nlast;
    n = 1.0;
    d = 0.0;
    nlast = 0.0;
    dlast = 1.0;
    nvtxRangePushA("#loop#rat_whileloop_0##" MW_AT_LINE);
    real_T rndx;
    int32_T exitg1;
    do {
      exitg1 = 0;
      rndx = std::round(b_x);
      if (!std::isinf(b_x)) {
        real_T tmp;
        b_x -= rndx;
        tmp = nlast;
        nlast = n;
        n = n * rndx + tmp;
        tmp = dlast;
        dlast = d;
        d = d * rndx + tmp;
      } else {
        nlast = n;
        dlast = d;
        n = b_x;
        d = 0.0;
      }
      if ((b_x == 0.0) || (std::abs(n / d - x) <= absx)) {
        exitg1 = 1;
      } else {
        b_x = 1.0 / b_x;
      }
    } while (exitg1 == 0);
    nvtxRangePop();
    if (std::isnan(d)) {
      b_x = rtNaN;
    } else if (d < 0.0) {
      b_x = -1.0;
    } else {
      b_x = (d > 0.0);
    }
    N = n / b_x;
    *D = std::abs(d);
  }
  nvtxRangePop();
  return N;
}

} // namespace coder

// End of code generation (rat.cu)
