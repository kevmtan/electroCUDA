//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// insertionsort.cu
//
// Code generation for function 'insertionsort'
//

// Include files
#include "insertionsort.h"
#include "filtfilt_mexutil.h"
#include "filtfilt_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Definitions
//
//
namespace coder {
namespace internal {
void insertionsort(emxArray_int32_T *x, int32_T xstart, int32_T xend,
                   const emxArray_int32_T *cmp_workspace_a,
                   const emxArray_int32_T *cmp_workspace_b)
{
  int64_T b;
  nvtxRangePushA("#fcn#insertionsort#" MW_AT_LOCATION);
  nvtxMarkA("#computeEndIdx#" MW_AT_LINE);
  b = computeEndIdx(static_cast<int64_T>(xstart + 1),
                    static_cast<int64_T>(xend), 1L);
  profileLoopStart("insertionsort_loop_0", __LINE__, b + 1L, "");
  for (int64_T k{0L}; k <= b; k++) {
    int32_T idx;
    int32_T xc;
    boolean_T exitg1;
    xc = x->data[static_cast<int32_T>((xstart + 1) + k) - 1] - 1;
    idx = static_cast<int32_T>((xstart + 1) + k) - 2;
    exitg1 = false;
    nvtxRangePushA("#loop#insertionsort_whileloop_0##" MW_AT_LINE);
    while ((!exitg1) && (idx + 1 >= xstart)) {
      boolean_T varargout_1;
      if (cmp_workspace_a->data[xc] < cmp_workspace_a->data[x->data[idx] - 1]) {
        varargout_1 = true;
      } else if (cmp_workspace_a->data[xc] ==
                 cmp_workspace_a->data[x->data[idx] - 1]) {
        varargout_1 = (cmp_workspace_b->data[xc] <
                       cmp_workspace_b->data[x->data[idx] - 1]);
      } else {
        varargout_1 = false;
      }
      if (varargout_1) {
        x->data[idx + 1] = x->data[idx];
        idx--;
      } else {
        exitg1 = true;
      }
    }
    nvtxRangePop();
    x->data[idx + 1] = xc + 1;
  }
  profileLoopEnd();
  nvtxRangePop();
}

} // namespace internal
} // namespace coder

// End of code generation (insertionsort.cu)
