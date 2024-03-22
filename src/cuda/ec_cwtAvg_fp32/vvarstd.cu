//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// vvarstd.cu
//
// Code generation for function 'vvarstd'
//

// Include files
#include "vvarstd.h"
#include "ec_cwtAvg_types.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
//
//
namespace coder {
real32_T vvarstd(const emxArray_real32_T *v, int32_T n)
{
  real32_T s;
  if (n == 0) {
    s = rtNaNF;
  } else if (n == 1) {
    if ((!std::isinf(v->data[0])) && (!std::isnan(v->data[0]))) {
      s = 0.0F;
    } else {
      s = rtNaNF;
    }
  } else {
    real32_T xbar;
    if (v->size[0] == 0) {
      xbar = 0.0F;
    } else {
      xbar = v->data[0];
      for (int32_T k{0}; k <= n - 2; k++) {
        xbar += v->data[k + 1];
      }
    }
    xbar /= static_cast<real32_T>(n);
    s = 0.0F;
    for (int32_T k{0}; k < n; k++) {
      real32_T t;
      t = v->data[k] - xbar;
      s += t * t;
    }
    s /= static_cast<real32_T>(n);
  }
  return s;
}

} // namespace coder

// End of code generation (vvarstd.cu)
