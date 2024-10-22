//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// sparse.cu
//
// Code generation for function 'sparse'
//

// Include files
#include "sparse.h"
#include "fillIn.h"
#include "filtfilt_data.h"
#include "filtfilt_emxutil.h"
#include "filtfilt_mexutil.h"
#include "filtfilt_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cstring>

// Variable Definitions
static emlrtRTEInfo qd_emlrtRTEI{
    395,      // lineNo
    13,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo rd_emlrtRTEI{
    219,      // lineNo
    20,       // colNo
    "sparse", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/sparse.m" // pName
};

static emlrtRTEInfo sd_emlrtRTEI{
    32,             // lineNo
    1,              // colNo
    "locTranspose", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/+coder/+internal/"
    "@sparse/locTranspose.m" // pName
};

// Function Definitions
//
//
namespace coder {
void sparse_ctranspose(const emxArray_real_T *this_d,
                       const emxArray_int32_T *this_colidx,
                       const emxArray_int32_T *this_rowidx, int32_T this_m,
                       int32_T this_n, emxArray_real_T *y_d,
                       emxArray_int32_T *y_colidx, emxArray_int32_T *y_rowidx,
                       int32_T *y_m, int32_T *y_n)
{
  emxArray_int32_T *counts;
  int32_T numalloc;
  int32_T outridx;
  nvtxRangePushA("#fcn#sparse_ctranspose#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if (this_colidx->data[this_colidx->size[0] - 1] - 1 >= 1) {
    numalloc = this_colidx->data[this_colidx->size[0] - 1] - 2;
  } else {
    numalloc = 0;
  }
  outridx = y_colidx->size[0];
  y_colidx->size[0] = this_m + 1;
  nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
  emxEnsureCapacity_int32_T(y_colidx, outridx, &qd_emlrtRTEI);
  if (this_m >= 0) {
    std::memset(&y_colidx->data[0], 0,
                static_cast<uint32_T>(this_m + 1) * sizeof(int32_T));
  }
  y_colidx->data[0] = 1;
  profileLoopStart("sparse_ctranspose_loop_0", __LINE__, (this_m - 1) + 1, "");
  for (int32_T c{0}; c < this_m; c++) {
    y_colidx->data[c + 1] = 1;
  }
  profileLoopEnd();
  outridx = y_d->size[0];
  y_d->size[0] = numalloc + 1;
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(y_d, outridx, &rd_emlrtRTEI);
  outridx = y_rowidx->size[0];
  y_rowidx->size[0] = numalloc + 1;
  nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
  emxEnsureCapacity_int32_T(y_rowidx, outridx, &rd_emlrtRTEI);
  if (numalloc >= 0) {
    std::memset(&y_d->data[0], 0,
                static_cast<uint32_T>(numalloc + 1) * sizeof(real_T));
    std::memset(&y_rowidx->data[0], 0,
                static_cast<uint32_T>(numalloc + 1) * sizeof(int32_T));
  }
  nvtxMarkA("#sparse_fillIn#" MW_AT_LINE);
  sparse_fillIn(y_d, y_colidx, y_rowidx);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&counts, 1, &sd_emlrtRTEI, true);
  if ((this_m != 0) && (this_n != 0)) {
    numalloc = y_colidx->size[0];
    outridx = y_colidx->size[0];
    y_colidx->size[0] = numalloc;
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(y_colidx, outridx, &qd_emlrtRTEI);
    if (numalloc - 1 >= 0) {
      std::memset(&y_colidx->data[0], 0,
                  static_cast<uint32_T>(numalloc) * sizeof(int32_T));
    }
    numalloc = this_colidx->data[this_colidx->size[0] - 1];
    profileLoopStart("sparse_ctranspose_loop_1", __LINE__, (numalloc - 2) + 1,
                     "");
    for (outridx = 0; outridx <= numalloc - 2; outridx++) {
      y_colidx->data[this_rowidx->data[outridx]]++;
    }
    profileLoopEnd();
    y_colidx->data[0] = 1;
    outridx = counts->size[0];
    counts->size[0] = this_m;
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(counts, outridx, &sd_emlrtRTEI);
    profileLoopStart("sparse_ctranspose_loop_2", __LINE__, (this_m - 1) + 1,
                     "");
    for (outridx = 0; outridx < this_m; outridx++) {
      y_colidx->data[outridx + 1] += y_colidx->data[outridx];
      counts->data[outridx] = 0;
    }
    profileLoopEnd();
    profileLoopStart("sparse_ctranspose_loop_3", __LINE__, (this_n - 1) + 1,
                     "");
    for (int32_T c{0}; c < this_n; c++) {
      int64_T b;
      numalloc = this_colidx->data[c];
      outridx = this_colidx->data[c + 1];
      nvtxMarkA("#computeEndIdx#" MW_AT_LINE);
      b = computeEndIdx(static_cast<int64_T>(numalloc),
                        static_cast<int64_T>(outridx - 1), 1L);
      profileLoopStart("sparse_ctranspose_loop_4", __LINE__, b + 1L, "");
      for (int64_T idx{0L}; idx <= b; idx++) {
        outridx =
            (counts->data[this_rowidx
                              ->data[static_cast<int32_T>(numalloc + idx) - 1] -
                          1] +
             y_colidx->data
                 [this_rowidx->data[static_cast<int32_T>(numalloc + idx) - 1] -
                  1]) -
            1;
        y_d->data[outridx] =
            this_d->data[static_cast<int32_T>(numalloc + idx) - 1];
        y_rowidx->data[outridx] = c + 1;
        counts
            ->data[this_rowidx->data[static_cast<int32_T>(numalloc + idx) - 1] -
                   1]++;
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&counts);
  *y_m = this_n;
  *y_n = this_m;
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

} // namespace coder

// End of code generation (sparse.cu)
