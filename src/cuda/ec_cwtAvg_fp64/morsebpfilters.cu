//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// morsebpfilters.cu
//
// Code generation for function 'morsebpfilters'
//

// Include files
#include "morsebpfilters.h"
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_types.h"
#include "rt_nonfinite.h"

// Function Definitions
void binary_expand_op_1(emxArray_real_T *in1, real_T in2,
                        const emxArray_real_T *in3, const emxArray_real_T *in4)
{
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_0_1;
  int32_T stride_1_0;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  if (in4->size[0] == 1) {
    in1->size[0] = in3->size[0];
  } else {
    in1->size[0] = in4->size[0];
  }
  if (in4->size[1] == 1) {
    in1->size[1] = in3->size[1];
  } else {
    in1->size[1] = in4->size[1];
  }
  emxEnsureCapacity_real_T(in1, i, &pb_emlrtRTEI);
  stride_0_0 = (in3->size[0] != 1);
  stride_0_1 = (in3->size[1] != 1);
  stride_1_0 = (in4->size[0] != 1);
  stride_1_1 = (in4->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (in4->size[1] == 1) {
    b = in3->size[1];
  } else {
    b = in4->size[1];
  }
  for (i = 0; i < b; i++) {
    int32_T c;
    if (in4->size[0] == 1) {
      c = in3->size[0];
    } else {
      c = in4->size[0];
    }
    for (int32_T i1{0}; i1 < c; i1++) {
      in1->data[i1 + in1->size[0] * i] =
          in2 * in3->data[i1 * stride_0_0 + in3->size[0] * aux_0_1] *
          static_cast<real_T>(
              in4->data[i1 * stride_1_0 + in4->size[0] * aux_1_1] > 0.0);
    }
    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

void binary_expand_op_2(emxArray_real_T *in1, real_T in2,
                        const emxArray_real_T *in3, const emxArray_real_T *in4)
{
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_0_1;
  int32_T stride_1_0;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  if (in4->size[0] == 1) {
    in1->size[0] = in3->size[0];
  } else {
    in1->size[0] = in4->size[0];
  }
  if (in4->size[1] == 1) {
    in1->size[1] = in3->size[1];
  } else {
    in1->size[1] = in4->size[1];
  }
  emxEnsureCapacity_real_T(in1, i, &mb_emlrtRTEI);
  stride_0_0 = (in3->size[0] != 1);
  stride_0_1 = (in3->size[1] != 1);
  stride_1_0 = (in4->size[0] != 1);
  stride_1_1 = (in4->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (in4->size[1] == 1) {
    b = in3->size[1];
  } else {
    b = in4->size[1];
  }
  for (i = 0; i < b; i++) {
    int32_T c;
    if (in4->size[0] == 1) {
      c = in3->size[0];
    } else {
      c = in4->size[0];
    }
    for (int32_T i1{0}; i1 < c; i1++) {
      in1->data[i1 + in1->size[0] * i] =
          in2 * in3->data[i1 * stride_0_0 + in3->size[0] * aux_0_1] -
          in4->data[i1 * stride_1_0 + in4->size[0] * aux_1_1];
    }
    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

// End of code generation (morsebpfilters.cu)
