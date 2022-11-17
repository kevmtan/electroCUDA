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
#include "ec_filtfilt_types.h"
#include "rt_nonfinite.h"

// Function Definitions
namespace coder {
namespace internal {
void b_heapsort(emxArray_int32_T *x, int32_T xstart, int32_T xend,
                const emxArray_int32_T *cmp_workspace_a,
                const emxArray_int32_T *cmp_workspace_b)
{
  int32_T cmpIdx;
  int32_T extremum;
  int32_T extremumIdx;
  int32_T leftIdx;
  int32_T n;
  int32_T xcmp;
  boolean_T changed;
  boolean_T exitg1;
  boolean_T varargout_1;
  n = xend - xstart;
  for (int32_T idx{0}; idx <= n; idx++) {
    leftIdx = (n - idx) - 1;
    changed = true;
    extremumIdx = leftIdx + xstart;
    leftIdx = (((leftIdx + 2) << 1) + xstart) - 2;
    exitg1 = false;
    while ((!exitg1) && (leftIdx + 1 < xend)) {
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
  }
  for (int32_T idx{0}; idx < n; idx++) {
    leftIdx = x->data[(xend - idx) - 1];
    x->data[(xend - idx) - 1] = x->data[xstart - 1];
    x->data[xstart - 1] = leftIdx;
    changed = true;
    extremumIdx = xstart - 1;
    leftIdx = xstart;
    exitg1 = false;
    while ((!exitg1) && (leftIdx + 1 < (xend - idx) - 1)) {
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
    if (changed && (leftIdx + 1 <= (xend - idx) - 1)) {
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
  }
}

} // namespace internal
} // namespace coder

// End of code generation (heapsort.cu)
