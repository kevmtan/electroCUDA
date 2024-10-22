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
#include "filtfilt_types.h"
#include "heapsort.h"
#include "insertionsort.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Type Definitions
struct struct_T {
  int32_T xstart;
  int32_T xend;
  int32_T depth;
};

// Function Definitions
//
//
namespace coder {
namespace internal {
void introsort(emxArray_int32_T *x, int32_T xend,
               const emxArray_int32_T *cmp_workspace_a,
               const emxArray_int32_T *cmp_workspace_b)
{
  nvtxRangePushA("#fcn#introsort#" MW_AT_LOCATION);
  if (xend > 1) {
    if (xend <= 32) {
      nvtxMarkA("#insertionsort#" MW_AT_LINE);
      insertionsort(x, 1, xend, cmp_workspace_a, cmp_workspace_b);
    } else {
      struct_T st_d_data[120];
      int32_T pivot;
      int32_T pmax;
      int32_T pmin;
      int32_T pow2p;
      int32_T st_n;
      boolean_T exitg1;
      pmax = 31;
      pmin = 0;
      exitg1 = false;
      nvtxRangePushA("#loop#introsort_whileloop_4##" MW_AT_LINE);
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
      nvtxRangePop();
      pow2p = (pmax - 1) << 1;
      st_d_data[0].xstart = 1;
      st_d_data[0].xend = xend;
      st_d_data[0].depth = 0;
      st_n = 1;
      nvtxRangePushA("#loop#introsort_whileloop_0##" MW_AT_LINE);
      while (st_n > 0) {
        struct_T expl_temp;
        expl_temp = st_d_data[st_n - 1];
        pmax = st_d_data[st_n - 1].xstart - 1;
        xend = st_d_data[st_n - 1].xend;
        st_n--;
        if ((expl_temp.xend - expl_temp.xstart) + 1 <= 32) {
          nvtxMarkA("#insertionsort#" MW_AT_LINE);
          insertionsort(x, expl_temp.xstart, expl_temp.xend, cmp_workspace_a,
                        cmp_workspace_b);
        } else if (expl_temp.depth == pow2p) {
          nvtxMarkA("#b_heapsort#" MW_AT_LINE);
          b_heapsort(x, expl_temp.xstart, expl_temp.xend, cmp_workspace_a,
                     cmp_workspace_b);
        } else {
          int32_T t;
          boolean_T varargout_1;
          pmin =
              (expl_temp.xstart + (expl_temp.xend - expl_temp.xstart) / 2) - 1;
          if (cmp_workspace_a->data[x->data[pmin] - 1] <
              cmp_workspace_a->data[x->data[expl_temp.xstart - 1] - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[pmin] - 1] ==
                     cmp_workspace_a->data[x->data[expl_temp.xstart - 1] - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[pmin] - 1] <
                           cmp_workspace_b->data[x->data[pmax] - 1]);
          } else {
            varargout_1 = false;
          }
          if (varargout_1) {
            t = x->data[expl_temp.xstart - 1];
            x->data[expl_temp.xstart - 1] = x->data[pmin];
            x->data[pmin] = t;
          }
          if (cmp_workspace_a->data[x->data[expl_temp.xend - 1] - 1] <
              cmp_workspace_a->data[x->data[expl_temp.xstart - 1] - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[expl_temp.xend - 1] - 1] ==
                     cmp_workspace_a->data[x->data[expl_temp.xstart - 1] - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[xend - 1] - 1] <
                           cmp_workspace_b->data[x->data[pmax] - 1]);
          } else {
            varargout_1 = false;
          }
          if (varargout_1) {
            t = x->data[expl_temp.xstart - 1];
            x->data[expl_temp.xstart - 1] = x->data[expl_temp.xend - 1];
            x->data[expl_temp.xend - 1] = t;
          }
          if (cmp_workspace_a->data[x->data[expl_temp.xend - 1] - 1] <
              cmp_workspace_a->data[x->data[pmin] - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[expl_temp.xend - 1] - 1] ==
                     cmp_workspace_a->data[x->data[pmin] - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[xend - 1] - 1] <
                           cmp_workspace_b->data[x->data[pmin] - 1]);
          } else {
            varargout_1 = false;
          }
          if (varargout_1) {
            t = x->data[pmin];
            x->data[pmin] = x->data[expl_temp.xend - 1];
            x->data[expl_temp.xend - 1] = t;
          }
          pivot = x->data[pmin] - 1;
          x->data[pmin] = x->data[expl_temp.xend - 2];
          x->data[expl_temp.xend - 2] = pivot + 1;
          pmax = expl_temp.xstart - 1;
          pmin = expl_temp.xend - 2;
          nvtxRangePushA("#loop#introsort_whileloop_1##" MW_AT_LINE);
          int32_T exitg2;
          do {
            int32_T exitg3;
            exitg2 = 0;
            pmax++;
            nvtxRangePushA("#loop#introsort_whileloop_3##" MW_AT_LINE);
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
            nvtxRangePop();
            pmin--;
            nvtxRangePushA("#loop#introsort_whileloop_2##" MW_AT_LINE);
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
            nvtxRangePop();
            if (pmax + 1 >= pmin + 1) {
              exitg2 = 1;
            } else {
              t = x->data[pmax];
              x->data[pmax] = x->data[pmin];
              x->data[pmin] = t;
            }
          } while (exitg2 == 0);
          nvtxRangePop();
          x->data[expl_temp.xend - 2] = x->data[pmax];
          x->data[pmax] = pivot + 1;
          if (pmax + 2 < expl_temp.xend) {
            st_d_data[st_n].xstart = pmax + 2;
            st_d_data[st_n].xend = expl_temp.xend;
            st_d_data[st_n].depth = expl_temp.depth + 1;
            st_n++;
          }
          if (expl_temp.xstart < pmax + 1) {
            st_d_data[st_n].xstart = expl_temp.xstart;
            st_d_data[st_n].xend = pmax + 1;
            st_d_data[st_n].depth = expl_temp.depth + 1;
            st_n++;
          }
        }
      }
      nvtxRangePop();
    }
  }
  nvtxRangePop();
}

} // namespace internal
} // namespace coder

// End of code generation (introsort.cu)
