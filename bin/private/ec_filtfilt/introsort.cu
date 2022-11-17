//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// introsort.cu
//
// Code generation for function 'introsort'
//

// Include files
#include "introsort.h"
#include "ec_filtfilt_data.h"
#include "ec_filtfilt_emxutil.h"
#include "ec_filtfilt_types.h"
#include "heapsort.h"
#include "insertionsort.h"
#include "rt_nonfinite.h"

// Variable Definitions
static emlrtRTEInfo fe_emlrtRTEI{
    41,          // lineNo
    1,           // colNo
    "introsort", // fName
    "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "introsort.m" // pName
};

// Function Definitions
namespace coder {
namespace internal {
void introsort(emxArray_int32_T *x, int32_T xend,
               const emxArray_int32_T *cmp_workspace_a,
               const emxArray_int32_T *cmp_workspace_b)
{
  emxArray_struct_T *st_d;
  struct_T frame;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_struct_T(&st_d, 1, &fe_emlrtRTEI, true);
  if (xend > 1) {
    if (xend <= 32) {
      insertionsort(x, 1, xend, cmp_workspace_a, cmp_workspace_b);
    } else {
      int32_T MAXDEPTH;
      int32_T pivot;
      int32_T pmax;
      int32_T pmin;
      int32_T pow2p;
      boolean_T exitg1;
      pmax = 31;
      pmin = 0;
      exitg1 = false;
      while ((!exitg1) && (pmax - pmin > 1)) {
        pivot = (pmin + pmax) >> 1;
        pow2p = 1 << pivot;
        if (pow2p == xend) {
          pmax = pivot;
          exitg1 = true;
        } else if (pow2p > xend) {
          pmax = pivot;
        } else {
          pmin = pivot;
        }
      }
      MAXDEPTH = (pmax - 1) << 1;
      frame.xstart = 1;
      frame.xend = xend;
      frame.depth = 0;
      pmax = MAXDEPTH << 1;
      pmin = st_d->size[0];
      st_d->size[0] = pmax;
      emxEnsureCapacity_struct_T(st_d, pmin, &fe_emlrtRTEI);
      for (pmin = 0; pmin < pmax; pmin++) {
        st_d->data[pmin] = frame;
      }
      st_d->data[0] = frame;
      pow2p = 1;
      while (pow2p > 0) {
        frame = st_d->data[pow2p - 1];
        pmax = st_d->data[pow2p - 1].xstart - 1;
        xend = st_d->data[pow2p - 1].xend;
        pow2p--;
        if ((frame.xend - frame.xstart) + 1 <= 32) {
          insertionsort(x, frame.xstart, frame.xend, cmp_workspace_a,
                        cmp_workspace_b);
        } else if (frame.depth == MAXDEPTH) {
          b_heapsort(x, frame.xstart, frame.xend, cmp_workspace_a,
                     cmp_workspace_b);
        } else {
          int32_T t;
          boolean_T varargout_1;
          pmin = (frame.xstart + (frame.xend - frame.xstart) / 2) - 1;
          if (cmp_workspace_a->data[x->data[pmin] - 1] <
              cmp_workspace_a->data[x->data[frame.xstart - 1] - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[pmin] - 1] ==
                     cmp_workspace_a->data[x->data[frame.xstart - 1] - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[pmin] - 1] <
                           cmp_workspace_b->data[x->data[pmax] - 1]);
          } else {
            varargout_1 = false;
          }
          if (varargout_1) {
            t = x->data[frame.xstart - 1];
            x->data[frame.xstart - 1] = x->data[pmin];
            x->data[pmin] = t;
          }
          if (cmp_workspace_a->data[x->data[frame.xend - 1] - 1] <
              cmp_workspace_a->data[x->data[frame.xstart - 1] - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[frame.xend - 1] - 1] ==
                     cmp_workspace_a->data[x->data[frame.xstart - 1] - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[xend - 1] - 1] <
                           cmp_workspace_b->data[x->data[pmax] - 1]);
          } else {
            varargout_1 = false;
          }
          if (varargout_1) {
            t = x->data[frame.xstart - 1];
            x->data[frame.xstart - 1] = x->data[frame.xend - 1];
            x->data[frame.xend - 1] = t;
          }
          if (cmp_workspace_a->data[x->data[frame.xend - 1] - 1] <
              cmp_workspace_a->data[x->data[pmin] - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[frame.xend - 1] - 1] ==
                     cmp_workspace_a->data[x->data[pmin] - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[xend - 1] - 1] <
                           cmp_workspace_b->data[x->data[pmin] - 1]);
          } else {
            varargout_1 = false;
          }
          if (varargout_1) {
            t = x->data[pmin];
            x->data[pmin] = x->data[frame.xend - 1];
            x->data[frame.xend - 1] = t;
          }
          pivot = x->data[pmin] - 1;
          x->data[pmin] = x->data[frame.xend - 2];
          x->data[frame.xend - 2] = pivot + 1;
          pmax = frame.xstart - 1;
          pmin = frame.xend - 2;
          int32_T exitg2;
          do {
            int32_T exitg3;
            exitg2 = 0;
            pmax++;
            do {
              exitg3 = 0;
              if (cmp_workspace_a->data[x->data[pmax] - 1] <
                  cmp_workspace_a->data[pivot]) {
                varargout_1 = true;
              } else if (cmp_workspace_a->data[x->data[pmax] - 1] ==
                         cmp_workspace_a->data[pivot]) {
                varargout_1 = (cmp_workspace_b->data[x->data[pmax] - 1] <
                               cmp_workspace_b->data[pivot]);
              } else {
                varargout_1 = false;
              }
              if (varargout_1) {
                pmax++;
              } else {
                exitg3 = 1;
              }
            } while (exitg3 == 0);
            pmin--;
            do {
              exitg3 = 0;
              if (cmp_workspace_a->data[pivot] <
                  cmp_workspace_a->data[x->data[pmin] - 1]) {
                varargout_1 = true;
              } else if (cmp_workspace_a->data[pivot] ==
                         cmp_workspace_a->data[x->data[pmin] - 1]) {
                varargout_1 = (cmp_workspace_b->data[pivot] <
                               cmp_workspace_b->data[x->data[pmin] - 1]);
              } else {
                varargout_1 = false;
              }
              if (varargout_1) {
                pmin--;
              } else {
                exitg3 = 1;
              }
            } while (exitg3 == 0);
            if (pmax + 1 >= pmin + 1) {
              exitg2 = 1;
            } else {
              t = x->data[pmax];
              x->data[pmax] = x->data[pmin];
              x->data[pmin] = t;
            }
          } while (exitg2 == 0);
          x->data[frame.xend - 2] = x->data[pmax];
          x->data[pmax] = pivot + 1;
          if (pmax + 2 < frame.xend) {
            st_d->data[pow2p].xstart = pmax + 2;
            st_d->data[pow2p].xend = frame.xend;
            st_d->data[pow2p].depth = frame.depth + 1;
            pow2p++;
          }
          if (frame.xstart < pmax + 1) {
            st_d->data[pow2p].xstart = frame.xstart;
            st_d->data[pow2p].xend = pmax + 1;
            st_d->data[pow2p].depth = frame.depth + 1;
            pow2p++;
          }
        }
      }
    }
  }
  emxFree_struct_T(&st_d);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

} // namespace internal
} // namespace coder

// End of code generation (introsort.cu)
