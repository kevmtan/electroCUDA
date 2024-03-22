//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// wavbpfilters.cu
//
// Code generation for function 'wavbpfilters'
//

// Include files
#include "wavbpfilters.h"
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_types.h"
#include "rt_nonfinite.h"

// Function Definitions
void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2,
                        const emxArray_real_T *in3)
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
  if (in3->size[0] == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3->size[0];
  }
  if (in3->size[1] == 1) {
    in1->size[1] = in2->size[1];
  } else {
    in1->size[1] = in3->size[1];
  }
  emxEnsureCapacity_real_T(in1, i, &mc_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_0 = (in3->size[0] != 1);
  stride_1_1 = (in3->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (in3->size[1] == 1) {
    b = in2->size[1];
  } else {
    b = in3->size[1];
  }
  for (i = 0; i < b; i++) {
    int32_T c;
    if (in3->size[0] == 1) {
      c = in2->size[0];
    } else {
      c = in3->size[0];
    }
    for (int32_T i1{0}; i1 < c; i1++) {
      in1->data[i1 + in1->size[0] * i] =
          5.43656365691809 *
          in2->data[i1 * stride_0_0 + in2->size[0] * aux_0_1] *
          static_cast<real_T>(
              in3->data[i1 * stride_1_0 + in3->size[0] * aux_1_1] <
              0.99999999999999978);
    }
    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

// End of code generation (wavbpfilters.cu)
