//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// fillIn.cu
//
// Code generation for function 'fillIn'
//

// Include files
#include "fillIn.h"
#include "filtfilt_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Definitions
//
//
namespace coder {
void sparse_fillIn(emxArray_real_T *this_d, emxArray_int32_T *this_colidx,
                   emxArray_int32_T *this_rowidx)
{
  int32_T i;
  int32_T idx;
  nvtxRangePushA("#fcn#sparse_fillIn#" MW_AT_LOCATION);
  idx = 1;
  i = this_colidx->size[0];
  profileLoopStart("sparse_fillIn_loop_0", __LINE__, (i - 2) + 1, "");
  for (int32_T c{0}; c <= i - 2; c++) {
    int32_T ridx;
    ridx = this_colidx->data[c];
    this_colidx->data[c] = idx;
    nvtxRangePushA("#loop#sparse_fillIn_whileloop_0##" MW_AT_LINE);
    while (ridx < this_colidx->data[c + 1]) {
      real_T val;
      int32_T currRowIdx;
      val = 0.0;
      currRowIdx = this_rowidx->data[ridx - 1];
      nvtxRangePushA("#loop#sparse_fillIn_whileloop_1##" MW_AT_LINE);
      while ((ridx < this_colidx->data[c + 1]) &&
             (this_rowidx->data[ridx - 1] == currRowIdx)) {
        val += this_d->data[ridx - 1];
        ridx++;
      }
      nvtxRangePop();
      if (val != 0.0) {
        this_d->data[idx - 1] = val;
        this_rowidx->data[idx - 1] = currRowIdx;
        idx++;
      }
    }
    nvtxRangePop();
  }
  profileLoopEnd();
  this_colidx->data[this_colidx->size[0] - 1] = idx;
  nvtxRangePop();
}

} // namespace coder

// End of code generation (fillIn.cu)
