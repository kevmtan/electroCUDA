//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// div.cu
//
// Code generation for function 'div'
//

// Include files
#include "div.h"
#include "ec_wtAvg_fp_data.h"
#include "ec_wtAvg_fp_emxutil.h"
#include "ec_wtAvg_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Definitions
void binary_expand_op_6(emxArray_real32_T *in1, const emxArray_real32_T *in2,
                        const emxArray_real32_T *in3)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  nvtxRangePushA("#fcn#binary_expand_op_6#" MW_AT_LOCATION);
  in3_idx_0 = in3->size[1];
  i = in1->size[0] * in1->size[1];
  if (in3_idx_0 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3_idx_0;
  }
  in1->size[1] = in2->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(in1, i, &gd_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3_idx_0 != 1);
  profileLoopStart("binary_expand_op_6_loop_0", __LINE__,
                   (in2->size[1] - 1) + 1, "");
  for (i = 0; i < in2->size[1]; i++) {
    int32_T b;
    if (in3_idx_0 == 1) {
      b = in2->size[0];
    } else {
      b = in3_idx_0;
    }
    profileLoopStart("binary_expand_op_6_loop_1", __LINE__, (b - 1) + 1, "");
    for (int32_T i1{0}; i1 < b; i1++) {
      in1->data[i1 + in1->size[0] * i] =
          in2->data[i1 * stride_0_0 + in2->size[0] * i] /
          in3->data[i1 * stride_1_0];
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  nvtxRangePop();
}

// End of code generation (div.cu)
