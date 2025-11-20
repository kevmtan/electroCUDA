//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// heapsort.cu
//
// Code generation for function 'heapsort'
//

// Include files
#include "heapsort.h"
#include "filtfilt_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Declarations
namespace coder {
namespace internal {
static void heapify(emxArray_int32_T *x, int32_T idx, int32_T xstart,
                    int32_T xend, const emxArray_int32_T *cmp_workspace_a,
                    const emxArray_int32_T *cmp_workspace_b);

}
} // namespace coder

// Function Definitions
//
//
namespace coder {
namespace internal {
static void heapify(emxArray_int32_T *x, int32_T idx, int32_T xstart,
                    int32_T xend, const emxArray_int32_T *cmp_workspace_a,
                    const emxArray_int32_T *cmp_workspace_b)
{
  int32_T extremum;
  int32_T extremumIdx;
  int32_T leftIdx;
  boolean_T changed;
  boolean_T exitg1;
  boolean_T varargout_1;
  nvtxRangePushA("#fcn#heapify#" MW_AT_LOCATION);
  changed = true;
  extremumIdx = (idx + xstart) - 2;
  leftIdx = ((idx << 1) + xstart) - 2;
  exitg1 = false;
  nvtxRangePushA("#loop#heapify_whileloop_0##" MW_AT_LINE);
  while ((!exitg1) && (leftIdx + 1 < xend)) {
    int32_T cmpIdx;
    int32_T xcmp;
    changed = false;
    extremum = x->data[extremumIdx];
    cmpIdx = leftIdx;
    xcmp = x->data[leftIdx];
    if (cmp_workspace_a->data[x->data[leftIdx] - 1] <
        cmp_workspace_a->data[x->data[leftIdx + 1] - 1]) {
      varargout_1 = true;
    } else if (cmp_workspace_a->data[x->data[leftIdx] - 1] ==
               cmp_workspace_a->data[x->data[leftIdx + 1] - 1]) {
      varargout_1 = (cmp_workspace_b->data[x->data[leftIdx] - 1] <
                     cmp_workspace_b->data[x->data[leftIdx + 1] - 1]);
    } else {
      varargout_1 = false;
    }
    if (varargout_1) {
      cmpIdx = leftIdx + 1;
      xcmp = x->data[leftIdx + 1];
    }
    if (cmp_workspace_a->data[x->data[extremumIdx] - 1] <
        cmp_workspace_a->data[xcmp - 1]) {
      varargout_1 = true;
    } else if (cmp_workspace_a->data[x->data[extremumIdx] - 1] ==
               cmp_workspace_a->data[xcmp - 1]) {
      varargout_1 = (cmp_workspace_b->data[x->data[extremumIdx] - 1] <
                     cmp_workspace_b->data[xcmp - 1]);
    } else {
      varargout_1 = false;
    }
    if (varargout_1) {
      x->data[extremumIdx] = xcmp;
      x->data[cmpIdx] = extremum;
      extremumIdx = cmpIdx;
      leftIdx = ((((cmpIdx - xstart) + 2) << 1) + xstart) - 2;
      changed = true;
    } else {
      exitg1 = true;
    }
  }
  nvtxRangePop();
  if (changed && (leftIdx + 1 <= xend)) {
    extremum = x->data[extremumIdx];
    if (cmp_workspace_a->data[x->data[extremumIdx] - 1] <
        cmp_workspace_a->data[x->data[leftIdx] - 1]) {
      varargout_1 = true;
    } else if (cmp_workspace_a->data[x->data[extremumIdx] - 1] ==
               cmp_workspace_a->data[x->data[leftIdx] - 1]) {
      varargout_1 = (cmp_workspace_b->data[x->data[extremumIdx] - 1] <
                     cmp_workspace_b->data[x->data[leftIdx] - 1]);
    } else {
      varargout_1 = false;
    }
    if (varargout_1) {
      x->data[extremumIdx] = x->data[leftIdx];
      x->data[leftIdx] = extremum;
    }
  }
  nvtxRangePop();
}

//
//
void b_heapsort(emxArray_int32_T *x, int32_T xstart, int32_T xend,
                const emxArray_int32_T *cmp_workspace_a,
                const emxArray_int32_T *cmp_workspace_b)
{
  int32_T n;
  int32_T t;
  nvtxRangePushA("#fcn#b_heapsort#" MW_AT_LOCATION);
  n = xend - xstart;
  profileLoopStart("b_heapsort_loop_0", __LINE__, n + 1, "");
  for (t = 0; t <= n; t++) {
    nvtxMarkA("#heapify#" MW_AT_LINE);
    heapify(x, (n - t) + 1, xstart, xend, cmp_workspace_a, cmp_workspace_b);
  }
  profileLoopEnd();
  profileLoopStart("b_heapsort_loop_1", __LINE__, (n - 1) + 1, "");
  for (int32_T k{0}; k < n; k++) {
    t = x->data[(xend - k) - 1];
    x->data[(xend - k) - 1] = x->data[xstart - 1];
    x->data[xstart - 1] = t;
    nvtxMarkA("#heapify#" MW_AT_LINE);
    heapify(x, 1, xstart, (xend - k) - 1, cmp_workspace_a, cmp_workspace_b);
  }
  profileLoopEnd();
  nvtxRangePop();
}

} // namespace internal
} // namespace coder

// End of code generation (heapsort.cu)
