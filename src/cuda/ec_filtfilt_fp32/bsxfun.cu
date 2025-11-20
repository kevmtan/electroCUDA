//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// bsxfun.cu
//
// Code generation for function 'bsxfun'
//

// Include files
#include "bsxfun.h"
#include "filtfilt_emxutil.h"
#include "filtfilt_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Variable Definitions
static emlrtRTEInfo yd_emlrtRTEI{
    60,                                                              // lineNo
    20,                                                              // colNo
    "bsxfun",                                                        // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/elmat/bsxfun.m" // pName
};

// Function Definitions
//
//
namespace coder {
void bsxfun(const emxArray_real32_T *a, const emxArray_real32_T *b,
            emxArray_real32_T *c)
{
  int32_T acoef;
  int32_T b_bcoef;
  int32_T bcoef;
  int32_T csz_idx_1;
  nvtxRangePushA("#fcn#bsxfun#" MW_AT_LOCATION);
  acoef = b->size[1];
  bcoef = a->size[1];
  if (acoef <= bcoef) {
    bcoef = acoef;
  }
  if (b->size[1] == 1) {
    csz_idx_1 = a->size[1];
  } else if (a->size[1] == 1) {
    csz_idx_1 = b->size[1];
  } else if (a->size[1] == b->size[1]) {
    csz_idx_1 = a->size[1];
  } else {
    csz_idx_1 = bcoef;
  }
  b_bcoef = c->size[0] * c->size[1];
  c->size[0] = b->size[0];
  acoef = b->size[1];
  bcoef = a->size[1];
  if (acoef <= bcoef) {
    bcoef = acoef;
  }
  if (b->size[1] == 1) {
    c->size[1] = a->size[1];
  } else if (a->size[1] == 1) {
    c->size[1] = b->size[1];
  } else if (a->size[1] == b->size[1]) {
    c->size[1] = a->size[1];
  } else {
    c->size[1] = bcoef;
  }
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(c, b_bcoef, &yd_emlrtRTEI);
  if ((b->size[0] != 0) && (csz_idx_1 != 0)) {
    acoef = (a->size[1] != 1);
    bcoef = (b->size[1] != 1);
    b_bcoef = (b->size[0] != 1);
    profileLoopStart("bsxfun_loop_0", __LINE__, (csz_idx_1 - 1) + 1, "");
    for (int32_T k{0}; k < csz_idx_1; k++) {
      int32_T i1;
      int32_T varargin_2;
      int32_T varargin_3;
      varargin_2 = acoef * k;
      varargin_3 = bcoef * k;
      i1 = c->size[0];
      profileLoopStart("bsxfun_loop_1", __LINE__, (i1 - 1) + 1, "");
      for (int32_T b_k{0}; b_k < i1; b_k++) {
        c->data[b_k + c->size[0] * k] =
            a->data[varargin_2] -
            b->data[b_bcoef * b_k + b->size[0] * varargin_3];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  }
  nvtxRangePop();
}

} // namespace coder

// End of code generation (bsxfun.cu)
