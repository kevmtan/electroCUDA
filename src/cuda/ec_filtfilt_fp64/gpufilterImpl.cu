//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// gpufilterImpl.cu
//
// Code generation for function 'gpufilterImpl'
//

// Include files
#include "gpufilterImpl.h"
#include "filtfilt_data.h"
#include "filtfilt_emxutil.h"
#include "filtfilt_types.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Definitions
void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2)
{
  emxArray_real_T *b_in1;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  nvtxRangePushA("#fcn#binary_expand_op_2#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_in1, 2, &sd_emlrtRTEI, true);
  i = b_in1->size[0] * b_in1->size[1];
  b_in1->size[0] = in2->size[0];
  if (in2->size[1] == 1) {
    b_in1->size[1] = in1->size[1];
  } else {
    b_in1->size[1] = in2->size[1];
  }
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(b_in1, i, &sd_emlrtRTEI);
  stride_0_1 = (in1->size[1] != 1);
  stride_1_1 = (in2->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (in2->size[1] == 1) {
    b = in1->size[1];
  } else {
    b = in2->size[1];
  }
  profileLoopStart("binary_expand_op_2_loop_0", __LINE__, (b - 1) + 1, "");
  for (i = 0; i < b; i++) {
    profileLoopStart("binary_expand_op_2_loop_1", __LINE__,
                     (in2->size[0] - 1) + 1, "");
    for (int32_T i1{0}; i1 < in2->size[0]; i1++) {
      b_in1->data[i1 + b_in1->size[0] * i] =
          in1->data[i1 + in1->size[0] * aux_0_1] +
          in2->data[i1 + in2->size[0] * aux_1_1];
    }
    profileLoopEnd();
    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
  profileLoopEnd();
  stride_0_1 = in2->size[0];
  stride_1_1 = in1->size[1];
  profileLoopStart("binary_expand_op_2_loop_2", __LINE__, (stride_1_1 - 1) + 1,
                   "");
  for (i = 0; i < stride_1_1; i++) {
    profileLoopStart("binary_expand_op_2_loop_3", __LINE__,
                     (stride_0_1 - 1) + 1, "");
    for (int32_T i1{0}; i1 < stride_0_1; i1++) {
      in1->data[i1 + in1->size[0] * i] = b_in1->data[i1 + stride_0_1 * i];
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

// End of code generation (gpufilterImpl.cu)
