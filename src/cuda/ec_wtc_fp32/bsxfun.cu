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
#include "ec_wtc_fp_data.h"
#include "ec_wtc_fp_emxutil.h"
#include "ec_wtc_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Definitions
//
//
namespace coder {
void bsxfun(const emxArray_creal32_T *a, const emxArray_real32_T *b,
            emxArray_creal32_T *c)
{
  int32_T bcoef;
  int32_T csz_idx_1;
  int32_T u0;
  int32_T varargin_2;
  nvtxRangePushA("#fcn#bsxfun#" MW_AT_LOCATION);
  u0 = b->size[1];
  bcoef = a->size[1];
  if (u0 <= bcoef) {
    bcoef = u0;
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
  varargin_2 = c->size[0] * c->size[1];
  c->size[0] = b->size[0];
  u0 = b->size[1];
  bcoef = a->size[1];
  if (u0 <= bcoef) {
    bcoef = u0;
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
  nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
  emxEnsureCapacity_creal32_T(c, varargin_2, &fc_emlrtRTEI);
  if ((b->size[0] != 0) && (csz_idx_1 != 0)) {
    int32_T acoef;
    int32_T b_bcoef;
    acoef = (a->size[1] != 1);
    b_bcoef = (b->size[1] != 1);
    u0 = csz_idx_1 - 1;
    bcoef = (b->size[0] != 1);
    profileLoopStart("bsxfun_loop_0", __LINE__, u0 + 1, "");
    for (int32_T k{0}; k <= u0; k++) {
      int32_T i1;
      varargin_2 = acoef * k;
      csz_idx_1 = b_bcoef * k;
      i1 = c->size[0] - 1;
      profileLoopStart("bsxfun_loop_1", __LINE__, i1 + 1, "");
      for (int32_T b_k{0}; b_k <= i1; b_k++) {
        c->data[b_k + c->size[0] * k].re =
            b->data[bcoef * b_k + b->size[0] * csz_idx_1] *
            a->data[varargin_2].re;
        c->data[b_k + c->size[0] * k].im =
            b->data[bcoef * b_k + b->size[0] * csz_idx_1] *
            a->data[varargin_2].im;
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  }
  nvtxRangePop();
}

} // namespace coder

// End of code generation (bsxfun.cu)
