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
#include "ec_wtAvg_fp_data.h"
#include "ec_wtAvg_fp_emxutil.h"
#include "ec_wtAvg_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Definitions
//
//
namespace coder {
void bsxfun(const emxArray_real_T *a, const emxArray_real_T *b,
            emxArray_real_T *c)
{
  int32_T acoef;
  int32_T bcoef;
  int32_T csz_idx_1;
  int32_T u0;
  nvtxRangePushA("#fcn#bsxfun#" MW_AT_LOCATION);
  u0 = b->size[1];
  acoef = a->size[1];
  if (u0 <= acoef) {
    acoef = u0;
  }
  if (b->size[1] == 1) {
    csz_idx_1 = a->size[1];
  } else if (a->size[1] == 1) {
    csz_idx_1 = b->size[1];
  } else if (a->size[1] == b->size[1]) {
    csz_idx_1 = a->size[1];
  } else {
    csz_idx_1 = acoef;
  }
  bcoef = c->size[0] * c->size[1];
  c->size[0] = 1;
  u0 = b->size[1];
  acoef = a->size[1];
  if (u0 <= acoef) {
    acoef = u0;
  }
  if (b->size[1] == 1) {
    c->size[1] = a->size[1];
  } else if (a->size[1] == 1) {
    c->size[1] = b->size[1];
  } else if (a->size[1] == b->size[1]) {
    c->size[1] = a->size[1];
  } else {
    c->size[1] = acoef;
  }
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(c, bcoef, &i_emlrtRTEI);
  if (csz_idx_1 != 0) {
    acoef = (a->size[1] != 1);
    bcoef = (b->size[1] != 1);
    u0 = csz_idx_1 - 1;
    profileLoopStart("bsxfun_loop_0", __LINE__, u0 + 1, "");
    for (csz_idx_1 = 0; csz_idx_1 <= u0; csz_idx_1++) {
      c->data[csz_idx_1] =
          a->data[acoef * csz_idx_1] * b->data[bcoef * csz_idx_1];
    }
    profileLoopEnd();
  }
  nvtxRangePop();
}

} // namespace coder

// End of code generation (bsxfun.cu)
