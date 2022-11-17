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
#include "ec_filtfilt_types.h"
#include "rt_nonfinite.h"

// Function Definitions
namespace coder {
namespace internal {
void insertionsort(emxArray_int32_T *x, int32_T xstart, int32_T xend,
                   const emxArray_int32_T *cmp_workspace_a,
                   const emxArray_int32_T *cmp_workspace_b)
{
  int32_T i;
  i = xstart + 1;
  for (int32_T k{0}; k <= xend - i; k++) {
    int32_T idx;
    int32_T xc;
    boolean_T exitg1;
    idx = xstart + k;
    xc = x->data[idx] - 1;
    exitg1 = false;
    while ((!exitg1) && (idx >= xstart)) {
      boolean_T varargout_1;
      if (cmp_workspace_a->data[xc] <
          cmp_workspace_a->data[x->data[idx - 1] - 1]) {
        varargout_1 = true;
      } else if (cmp_workspace_a->data[xc] ==
                 cmp_workspace_a->data[x->data[idx - 1] - 1]) {
        varargout_1 = (cmp_workspace_b->data[xc] <
                       cmp_workspace_b->data[x->data[idx - 1] - 1]);
      } else {
        varargout_1 = false;
      }
      if (varargout_1) {
        x->data[idx] = x->data[idx - 1];
        idx--;
      } else {
        exitg1 = true;
      }
    }
    x->data[idx] = xc + 1;
  }
}

} // namespace internal
} // namespace coder

// End of code generation (insertionsort.cu)
