//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// morseproperties.cu
//
// Code generation for function 'morseproperties'
//

// Include files
#include "morseproperties.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Definitions
void binary_expand_op_5(emxArray_real_T *in1, real_T in2,
                        const emxArray_real_T *in3, real_T in4,
                        const emxArray_real_T *in5)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  nvtxRangePushA("#fcn#binary_expand_op_5#" MW_AT_LOCATION);
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  if (in5->size[1] == 1) {
    in1->size[1] = in3->size[1];
  } else {
    in1->size[1] = in5->size[1];
  }
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(in1, i, &xc_emlrtRTEI);
  stride_0_1 = (in3->size[1] != 1);
  stride_1_1 = (in5->size[1] != 1);
  if (in5->size[1] == 1) {
    b = in3->size[1];
  } else {
    b = in5->size[1];
  }
  profileLoopStart("binary_expand_op_5_loop_0", __LINE__, (b - 1) + 1, "");
  for (i = 0; i < b; i++) {
    in1->data[i] =
        in2 * in3->data[i * stride_0_1] - in4 * in5->data[i * stride_1_1];
  }
  profileLoopEnd();
  nvtxRangePop();
}

// End of code generation (morseproperties.cu)
