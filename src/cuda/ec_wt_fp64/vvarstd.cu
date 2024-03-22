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
#include "ec_wt_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Function Definitions
//
//
namespace coder {
real_T vvarstd(const emxArray_real_T *v, int32_T n)
{
  real_T s;
  nvtxRangePushA("#fcn#vvarstd#" MW_AT_LOCATION);
  if (n == 0) {
    s = rtNaN;
  } else if (n == 1) {
    if ((!std::isinf(v->data[0])) && (!std::isnan(v->data[0]))) {
      s = 0.0;
    } else {
      s = rtNaN;
    }
  } else {
    real_T xbar;
    if (v->size[0] == 0) {
      xbar = 0.0;
    } else {
      xbar = v->data[0];
      profileLoopStart("vvarstd_loop_0", __LINE__, (n - 2) + 1, "");
      for (int32_T k{0}; k <= n - 2; k++) {
        xbar += v->data[k + 1];
      }
      profileLoopEnd();
    }
    xbar /= static_cast<real_T>(n);
    s = 0.0;
    profileLoopStart("vvarstd_loop_1", __LINE__, (n - 1) + 1, "");
    for (int32_T k{0}; k < n; k++) {
      real_T t;
      t = v->data[k] - xbar;
      s += t * t;
    }
    profileLoopEnd();
    s /= static_cast<real_T>(n);
  }
  nvtxRangePop();
  return s;
}

} // namespace coder

// End of code generation (vvarstd.cu)
