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
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_types.h"
#include "rt_nonfinite.h"

// Function Definitions
void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
                      const coder::cwtfilterbank *in3)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in3_idx_0 = in3->Scales->size[1];
  i = in1->size[0] * in1->size[1];
  if (in3_idx_0 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3_idx_0;
  }
  in1->size[1] = in2->size[1];
  emxEnsureCapacity_real_T(in1, i, &n_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3_idx_0 != 1);
  for (i = 0; i < in2->size[1]; i++) {
    int32_T b;
    if (in3_idx_0 == 1) {
      b = in2->size[0];
    } else {
      b = in3_idx_0;
    }
    for (int32_T i1{0}; i1 < b; i1++) {
      in1->data[i1 + in1->size[0] * i] =
          in2->data[i1 * stride_0_0 + in2->size[0] * i] /
          in3->Scales->data[i1 * stride_1_0];
    }
  }
}

// End of code generation (div.cu)
