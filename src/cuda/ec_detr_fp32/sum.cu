//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// sum.cu
//
// Code generation for function 'sum'
//

// Include files
#include "sum.h"
#include "ec_detr_fp_emxutil.h"
#include "ec_detr_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cstring>

// Variable Definitions
static emlrtRTEInfo emlrtRTEI{
    181,                     // lineNo
    24,                      // colNo
    "combineVectorElements", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/datafun/private/"
    "combineVectorElements.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    20,                                                             // lineNo
    1,                                                              // colNo
    "sum",                                                          // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/datafun/sum.m" // pName
};

// Function Definitions
//
//
namespace coder {
void sum(const emxArray_real32_T *x, emxArray_real32_T *y)
{
  int32_T vlen;
  nvtxRangePushA("#fcn#sum#" MW_AT_LOCATION);
  vlen = x->size[0];
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    int32_T xpageoffset;
    uint32_T sz_idx_1;
    sz_idx_1 = static_cast<uint32_T>(x->size[1]);
    xpageoffset = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = x->size[1];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(y, xpageoffset, &b_emlrtRTEI);
    if (static_cast<int32_T>(sz_idx_1) - 1 >= 0) {
      std::memset(&y->data[0], 0, sz_idx_1 * sizeof(real32_T));
    }
  } else {
    int32_T npages;
    int32_T xpageoffset;
    npages = x->size[1];
    xpageoffset = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = x->size[1];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(y, xpageoffset, &emlrtRTEI);
    profileLoopStart("sum_loop_0", __LINE__, (npages - 1) + 1, "");
    for (int32_T i{0}; i < npages; i++) {
      xpageoffset = i * x->size[0];
      y->data[i] = x->data[xpageoffset];
      profileLoopStart("sum_loop_1", __LINE__, (vlen - 2) + 1, "");
      for (int32_T k{0}; k <= vlen - 2; k++) {
        y->data[i] += x->data[(xpageoffset + k) + 1];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  }
  nvtxRangePop();
}

//
//
void sum(const emxArray_real_T *x, real_T y_data[], int32_T y_size[2])
{
  int32_T vlen;
  nvtxRangePushA("#fcn#sum#" MW_AT_LOCATION);
  vlen = x->size[0];
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    uint16_T sz_idx_1;
    sz_idx_1 = static_cast<uint16_T>(x->size[1]);
    y_size[0] = 1;
    y_size[1] = static_cast<uint16_T>(x->size[1]);
    profileLoopStart("sum_loop_1", __LINE__, (sz_idx_1 - 1) + 1, "");
    for (vlen = 0; vlen < sz_idx_1; vlen++) {
      y_data[vlen] = 0.0;
    }
    profileLoopEnd();
  } else {
    int32_T npages;
    npages = x->size[1];
    y_size[0] = 1;
    y_size[1] = x->size[1];
    profileLoopStart("sum_loop_0", __LINE__, (npages - 1) + 1, "");
    for (int32_T i{0}; i < npages; i++) {
      int32_T xpageoffset;
      xpageoffset = i * x->size[0];
      y_data[i] = x->data[xpageoffset];
      profileLoopStart("sum_loop_2", __LINE__, (vlen - 2) + 1, "");
      for (int32_T k{0}; k <= vlen - 2; k++) {
        y_data[i] += x->data[(xpageoffset + k) + 1];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  }
  nvtxRangePop();
}

} // namespace coder

// End of code generation (sum.cu)
