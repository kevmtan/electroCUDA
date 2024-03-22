//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr.cu
//
// Code generation for function 'ec_detr'
//

// Include files
#include "ec_detr.h"
#include "ec_detr_data.h"
#include "ec_detr_emxutil.h"
#include "ec_detr_mexutil.h"
#include "ec_detr_types.h"
#include "eig.h"
#include "mrdivide_helper.h"
#include "mtimes.h"
#include "rt_nonfinite.h"
#include "sum.h"
#include "MWCUBLASUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "math_constants.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo ub_emlrtRTEI{
    32,                                                  // lineNo
    24,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo vb_emlrtRTEI{
    58,                                                  // lineNo
    23,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo wb_emlrtRTEI{
    49,                                                                // lineNo
    20,                                                                // colNo
    "linspace",                                                        // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/linspace.m" // pName
};

static emlrtRTEInfo xb_emlrtRTEI{
    41,                                                  // lineNo
    41,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo yb_emlrtRTEI{
    41,                                                  // lineNo
    49,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo ac_emlrtRTEI{
    80,                                                  // lineNo
    20,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo bc_emlrtRTEI{
    42,                                                  // lineNo
    28,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo cc_emlrtRTEI{
    124,                                                 // lineNo
    10,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo dc_emlrtRTEI{
    109,                                                 // lineNo
    1,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo ec_emlrtRTEI{
    110,                                                 // lineNo
    1,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo
    fc_emlrtRTEI{
        44,       // lineNo
        36,       // colNo
        "mtimes", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/"
        "mtimes.m" // pName
    };

static emlrtRTEInfo gc_emlrtRTEI{
    112,                                                 // lineNo
    1,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo hc_emlrtRTEI{
    109,                                                           // lineNo
    24,                                                            // colNo
    "diag",                                                        // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/diag.m" // pName
};

static emlrtRTEInfo ic_emlrtRTEI{
    100,                                                           // lineNo
    5,                                                             // colNo
    "diag",                                                        // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/diag.m" // pName
};

static emlrtRTEInfo jc_emlrtRTEI{
    1,                                                   // lineNo
    24,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo kc_emlrtRTEI{
    114,                                                 // lineNo
    5,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo lc_emlrtRTEI{
    114,                                                 // lineNo
    1,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo mc_emlrtRTEI{
    115,                                                 // lineNo
    6,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo nc_emlrtRTEI{
    108,                                                 // lineNo
    5,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo
    oc_emlrtRTEI{
        94,                  // lineNo
        5,                   // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

static emlrtRTEInfo
    pc_emlrtRTEI{
        44,       // lineNo
        48,       // colNo
        "mtimes", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/"
        "mtimes.m" // pName
    };

static emlrtRTEInfo qc_emlrtRTEI{
    83,                                                  // lineNo
    5,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo rc_emlrtRTEI{
    86,                                                  // lineNo
    5,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo
    sc_emlrtRTEI{
        126,       // lineNo
        34,        // colNo
        "vvarstd", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/"
        "vvarstd.m" // pName
    };

static emlrtRTEInfo tc_emlrtRTEI{
    30,                    // lineNo
    21,                    // colNo
    "applyScalarFunction", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "applyScalarFunction.m" // pName
};

static emlrtRTEInfo uc_emlrtRTEI{
    1,                                                   // lineNo
    15,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo vc_emlrtRTEI{
    37,                                                  // lineNo
    5,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo wc_emlrtRTEI{
    59,                                                  // lineNo
    1,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo xc_emlrtRTEI{
    80,                                                  // lineNo
    1,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo yc_emlrtRTEI{
    83,                                                  // lineNo
    22,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo ad_emlrtRTEI{
    111,                                                 // lineNo
    13,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo bd_emlrtRTEI{
    111,                                                 // lineNo
    2,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo cd_emlrtRTEI{
    113,                                                 // lineNo
    10,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo dd_emlrtRTEI{
    114,                                                 // lineNo
    9,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo ed_emlrtRTEI{
    116,                                                 // lineNo
    6,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo fd_emlrtRTEI{
    116,                                                 // lineNo
    16,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo gd_emlrtRTEI{
    117,                                                 // lineNo
    8,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo hd_emlrtRTEI{
    117,                                                 // lineNo
    5,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo id_emlrtRTEI{
    88,                                                  // lineNo
    7,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo
    jd_emlrtRTEI{
        126,       // lineNo
        9,         // colNo
        "vvarstd", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/"
        "vvarstd.m" // pName
    };

static emlrtRTEInfo kd_emlrtRTEI{
    124,                                                 // lineNo
    6,                                                   // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

static emlrtRTEInfo
    ld_emlrtRTEI{
        94,                  // lineNo
        9,                   // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

static emlrtRTEInfo de_emlrtRTEI{
    41,                                                  // lineNo
    10,                                                  // colNo
    "ec_detr",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m" // pName
};

// Function Declarations
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
                             const emxArray_real_T *in3,
                             const emxArray_real_T *in4);

static void binary_expand_op_1(emxArray_real_T *in1, const emxArray_real_T *in2,
                               const emxArray_real_T *in3, real_T in4);

static void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2,
                               real_T in3, const emxArray_real_T *in4);

static void binary_expand_op_3(emxArray_real_T *in1, const emxArray_real_T *in2,
                               const emxArray_real_T *in3);

static void binary_expand_op_4(emxArray_real_T *in1, const emxArray_real_T *in2,
                               const emxArray_real_T *in3);

static void binary_expand_op_5(emxArray_real_T *in1, int32_T in2,
                               const emxArray_real_T *in3);

static __global__ void ec_detr_kernel1(const int32_T nFrames,
                                       emxArray_real_T lin);

static __global__ void ec_detr_kernel10(const emxArray_real_T dv1,
                                        const emxArray_real_T regs,
                                        const int32_T b_regs,
                                        const int32_T c_regs,
                                        emxArray_real_T d_regs,
                                        int32_T regs_dim0, int32_T b_regs_dim0);

static __global__ void ec_detr_kernel11(const real_T y, const emxArray_real_T r,
                                        const emxArray_real_T regs,
                                        const int32_T b_regs,
                                        const int32_T c_regs,
                                        emxArray_real_T b_r, int32_T r_dim0,
                                        int32_T regs_dim0);

static __global__ void ec_detr_kernel12(const emxArray_real_T dv1,
                                        const emxArray_real_T r,
                                        const int32_T b_r, const int32_T c_r,
                                        emxArray_real_T r1, int32_T r1_dim0,
                                        int32_T r_dim0);

static __global__ void ec_detr_kernel13(const emxArray_real_T r1,
                                        const int32_T b_r1, const int32_T c_r1,
                                        emxArray_real_T r2, int32_T r2_dim0,
                                        int32_T r1_dim0);

static __global__ void ec_detr_kernel14(const emxArray_creal_T V,
                                        const int32_T b_V, emxArray_real_T c_V);

static __global__ void ec_detr_kernel15(const emxArray_int32_T iv,
                                        const emxArray_real_T V,
                                        const int32_T b, const int32_T b_iv,
                                        emxArray_real_T b_V, int32_T V_dim0,
                                        int32_T b_V_dim0);

static __global__ void ec_detr_kernel16(const emxArray_real_T V,
                                        const int32_T b_V, emxArray_real_T c_V);

static __global__ void ec_detr_kernel17(const emxArray_real_T dv1,
                                        const real_T mn,
                                        const emxArray_real_T dv,
                                        const int32_T b_dv, emxArray_real_T A);

static __global__ void ec_detr_kernel18(const int32_T b, emxArray_real_T y);

static __global__ void ec_detr_kernel19(const emxArray_real_T r1,
                                        const int32_T b_r1, const int32_T c_r1,
                                        emxArray_real_T r3, int32_T r3_dim0,
                                        int32_T r1_dim0);

static __global__ void ec_detr_kernel2(emxArray_real_T lin);

static __global__ void ec_detr_kernel20(const emxArray_real_T y,
                                        const int32_T b_y, emxArray_real_T c_y);

static __global__ void ec_detr_kernel21(const real_T mn,
                                        const emxArray_real_T dv,
                                        const emxArray_real_T dv2,
                                        const int32_T b_dv2, emxArray_real_T z);

static __global__ void ec_detr_kernel22(const emxArray_real_T dv1,
                                        const emxArray_real_T z,
                                        const emxArray_real_T dv,
                                        const int32_T b_dv, emxArray_real_T d);

static __global__ void ec_detr_kernel23(const emxArray_real_T d,
                                        const int32_T b, emxArray_real_T y);

static __global__ void ec_detr_kernel24(const real_T d2scaled,
                                        const emxArray_real_T y,
                                        const int32_T k, emxArray_real_T dv1);

static __global__ void ec_detr_kernel25(const emxArray_real_T d, real_T *y);

static __global__ void ec_detr_kernel26(const real_T d2scaled,
                                        const emxArray_real_T d,
                                        const int32_T nx,
                                        emxArray_real_T absdiff);

static __global__ void ec_detr_kernel27(const emxArray_creal_T D,
                                        const int32_T nz, emxArray_creal_T d,
                                        int32_T D_dim0);

static __global__ void ec_detr_kernel28(const emxArray_real_T z,
                                        const int32_T ch, const int32_T b,
                                        emxArray_real_T x, int32_T x_dim0);

static __global__ void ec_detr_kernel29(const emxArray_real_T dv1,
                                        const int32_T ch, const int32_T b,
                                        emxArray_real_T w, int32_T w_dim0);

static __global__ void ec_detr_kernel3(const real_T d2scaled, const int32_T b,
                                       emxArray_real_T lin, int32_T lin_dim1);

static __global__ void ec_detr_kernel30(const int32_T ch,
                                        const emxArray_real_T w,
                                        const int32_T b_w, emxArray_boolean_T x,
                                        int32_T w_dim0);

static __global__ void ec_detr_kernel4(emxArray_real_T lin, int32_T lin_dim1);

static __global__ void ec_detr_kernel5(const emxArray_real_T lin,
                                       const int32_T k, const int32_T b,
                                       emxArray_real_T regs, int32_T regs_dim0);

static __global__ void ec_detr_kernel6(const int32_T ch,
                                       const emxArray_real_T x,
                                       const int32_T b_x, emxArray_real_T dv,
                                       int32_T x_dim0);

static __global__ void ec_detr_kernel7(const int32_T ch,
                                       const emxArray_real_T w,
                                       const int32_T b_w, emxArray_real_T dv1,
                                       int32_T w_dim0);

static __global__ void ec_detr_kernel8(const emxArray_real_T dv1,
                                       const emxArray_real_T dv,
                                       const int32_T b_dv, emxArray_real_T x);

static __global__ void ec_detr_kernel9(const emxArray_real_T dv1,
                                       const emxArray_real_T dv,
                                       const int32_T b_dv, emxArray_real_T x);

static void gpuEmxEnsureCapacity_boolean_T(const emxArray_boolean_T *cpu,
                                           emxArray_boolean_T *gpu,
                                           boolean_T needsCopy);

static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
                                         emxArray_creal_T *gpu,
                                         boolean_T needsCopy);

static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu);

static void gpuEmxFree_creal_T(emxArray_creal_T *gpu);

static void gpuEmxMemcpyCpuToGpu_creal_T(emxArray_creal_T *gpu,
                                         const emxArray_creal_T *cpu);

static void gpuEmxMemcpyGpuToCpu_boolean_T(emxArray_boolean_T *cpu,
                                           emxArray_boolean_T *gpu);

static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu,
                                         emxArray_creal_T *gpu);

static void gpuEmxReset_boolean_T(emxArray_boolean_T *gpu);

static void gpuEmxReset_creal_T(emxArray_creal_T *gpu);

static void times(emxArray_real_T *in1, const emxArray_real_T *in2,
                  const emxArray_real_T *in3);

// Function Definitions
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
                             const emxArray_real_T *in3,
                             const emxArray_real_T *in4)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  i = in1->size[0];
  if (in4->size[0] == 1) {
    if (in3->size[0] == 1) {
      in1->size[0] = in2->size[0];
    } else {
      in1->size[0] = in3->size[0];
    }
  } else {
    in1->size[0] = in4->size[0];
  }
  emxEnsureCapacity_real_T(in1, i, &rc_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  stride_2_0 = (in4->size[0] != 1);
  if (in4->size[0] == 1) {
    if (in3->size[0] == 1) {
      b = in2->size[0];
    } else {
      b = in3->size[0];
    }
  } else {
    b = in4->size[0];
  }
  for (i = 0; i < b; i++) {
    in1->data[i] = (in2->data[i * stride_0_0] - in3->data[i * stride_1_0]) *
                   in4->data[i * stride_2_0];
  }
}

static void binary_expand_op_1(emxArray_real_T *in1, const emxArray_real_T *in2,
                               const emxArray_real_T *in3, real_T in4)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in3->size[0] == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3->size[0];
  }
  emxEnsureCapacity_real_T(in1, i, &qc_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in3->size[0];
  }
  for (i = 0; i < b; i++) {
    in1->data[i] =
        in2->data[i * stride_0_0] +
        (in3->data[i * stride_1_0] - (in3->data[i * stride_1_0] - in4));
  }
}

static void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2,
                               real_T in3, const emxArray_real_T *in4)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  if (in4->size[0] == 1) {
    in1->size[1] = in2->size[0];
  } else {
    in1->size[1] = in4->size[0];
  }
  emxEnsureCapacity_real_T(in1, i, &nc_emlrtRTEI);
  stride_0_1 = (in2->size[0] != 1);
  stride_1_1 = (in4->size[0] != 1);
  if (in4->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in4->size[0];
  }
  for (i = 0; i < b; i++) {
    in1->data[i] =
        (in2->data[i * stride_0_1] - in3) * in4->data[i * stride_1_1];
  }
}

static void binary_expand_op_3(emxArray_real_T *in1, const emxArray_real_T *in2,
                               const emxArray_real_T *in3)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in3_idx_0 = in3->size[0];
  i = in1->size[0] * in1->size[1];
  if (in3_idx_0 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3_idx_0;
  }
  in1->size[1] = in2->size[1];
  emxEnsureCapacity_real_T(in1, i, &ec_emlrtRTEI);
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
          in2->data[i1 * stride_0_0 + in2->size[0] * i] *
          in3->data[i1 * stride_1_0];
    }
  }
}

static void binary_expand_op_4(emxArray_real_T *in1, const emxArray_real_T *in2,
                               const emxArray_real_T *in3)
{
  emxArray_real_T *b_in2;
  int32_T i;
  int32_T in3_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  in3_idx_0 = in3->size[0];
  emxInit_real_T(&b_in2, 2, &cc_emlrtRTEI, true);
  i = b_in2->size[0] * b_in2->size[1];
  if (in3_idx_0 == 1) {
    b_in2->size[0] = in2->size[0];
  } else {
    b_in2->size[0] = in3_idx_0;
  }
  b_in2->size[1] = in2->size[1];
  emxEnsureCapacity_real_T(b_in2, i, &cc_emlrtRTEI);
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
      b_in2->data[i1 + b_in2->size[0] * i] =
          in2->data[i1 * stride_0_0 + in2->size[0] * i] *
          in3->data[i1 * stride_1_0];
    }
  }
  coder::sum(b_in2, in1);
  emxFree_real_T(&b_in2);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op_5(emxArray_real_T *in1, int32_T in2,
                               const emxArray_real_T *in3)
{
  emxArray_real_T *b_in1;
  int32_T i;
  int32_T in1_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  in1_idx_0 = in1->size[0];
  emxInit_real_T(&b_in1, 1, &de_emlrtRTEI, true);
  i = b_in1->size[0];
  b_in1->size[0] = in1_idx_0;
  emxEnsureCapacity_real_T(b_in1, i, &de_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  for (i = 0; i < in1_idx_0; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0 + in1->size[0] * in2] -
                     in3->data[i * stride_1_0];
  }
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i + in1->size[0] * in2] = b_in1->data[i];
  }
  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static __global__
    __launch_bounds__(32, 1) void ec_detr_kernel1(const int32_T nFrames,
                                                  emxArray_real_T lin)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    lin.data[nFrames - 1] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel10(
    const emxArray_real_T dv1, const emxArray_real_T regs, const int32_T b_regs,
    const int32_T c_regs, emxArray_real_T d_regs, int32_T regs_dim0,
    int32_T b_regs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_regs) + 1UL) *
                (static_cast<uint64_T>(b_regs) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_regs) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                             (static_cast<uint64_T>(b_regs) + 1UL));
    d_regs.data[k + regs_dim0 * i] =
        regs.data[k + b_regs_dim0 * i] * dv1.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel11(
    const real_T y, const emxArray_real_T r, const emxArray_real_T regs,
    const int32_T b_regs, const int32_T c_regs, emxArray_real_T b_r,
    int32_T r_dim0, int32_T regs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_regs) + 1UL) *
                (static_cast<uint64_T>(b_regs) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_regs) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                             (static_cast<uint64_T>(b_regs) + 1UL));
    b_r.data[k + r_dim0 * i] = regs.data[k + regs_dim0 * i] - r.data[i] / y;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel12(
    const emxArray_real_T dv1, const emxArray_real_T r, const int32_T b_r,
    const int32_T c_r, emxArray_real_T r1, int32_T r1_dim0, int32_T r_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c_r) + 1UL) * (static_cast<uint64_T>(b_r) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                             (static_cast<uint64_T>(b_r) + 1UL));
    r1.data[k + r1_dim0 * i] = r.data[k + r_dim0 * i] * dv1.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel13(
    const emxArray_real_T r1, const int32_T b_r1, const int32_T c_r1,
    emxArray_real_T r2, int32_T r2_dim0, int32_T r1_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_r1) + 1UL) *
                (static_cast<uint64_T>(b_r1) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r1) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                             (static_cast<uint64_T>(b_r1) + 1UL));
    r2.data[k + r2_dim0 * i] = r1.data[i + r1_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel14(
    const emxArray_creal_T V, const int32_T b_V, emxArray_real_T c_V)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_V);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_V.data[i] = V.data[i].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel15(
    const emxArray_int32_T iv, const emxArray_real_T V, const int32_T b,
    const int32_T b_iv, emxArray_real_T b_V, int32_T V_dim0, int32_T b_V_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(b_iv) + 1UL) * (static_cast<uint64_T>(b) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                             (static_cast<uint64_T>(b) + 1UL));
    b_V.data[k + V_dim0 * i] = V.data[k + b_V_dim0 * iv.data[i]];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel16(
    const emxArray_real_T V, const int32_T b_V, emxArray_real_T c_V)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_V);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_V.data[i] = V.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel17(
    const emxArray_real_T dv1, const real_T mn, const emxArray_real_T dv,
    const int32_T b_dv, emxArray_real_T A)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = (dv.data[i] - mn) * dv1.data[i];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void ec_detr_kernel18(const int32_T b,
                                                             emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel19(
    const emxArray_real_T r1, const int32_T b_r1, const int32_T c_r1,
    emxArray_real_T r3, int32_T r3_dim0, int32_T r1_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_r1) + 1UL) *
                (static_cast<uint64_T>(b_r1) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r1) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                             (static_cast<uint64_T>(b_r1) + 1UL));
    r3.data[k + r3_dim0 * i] = r1.data[i + r1_dim0 * k];
  }
}

static __global__ __launch_bounds__(32,
                                    1) void ec_detr_kernel2(emxArray_real_T lin)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    lin.data[0] = -1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel20(
    const emxArray_real_T y, const int32_T b_y, emxArray_real_T c_y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_y.data[i] = y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel21(
    const real_T mn, const emxArray_real_T dv, const emxArray_real_T dv2,
    const int32_T b_dv2, emxArray_real_T z)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    z.data[i] = dv2.data[i] + (dv.data[i] - (dv.data[i] - mn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel22(
    const emxArray_real_T dv1, const emxArray_real_T z,
    const emxArray_real_T dv, const int32_T b_dv, emxArray_real_T d)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = (dv.data[i] - z.data[i]) * dv1.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel23(
    const emxArray_real_T d, const int32_T b, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = fabs(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel24(
    const real_T d2scaled, const emxArray_real_T y, const int32_T k,
    emxArray_real_T dv1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(k);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_k;
    b_k = static_cast<int32_T>(idx);
    if (y.data[b_k] > d2scaled) {
      dv1.data[b_k] = 0.0;
    }
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_detr_kernel25(const emxArray_real_T d,
                                                   real_T *y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    if ((static_cast<boolean_T>(!static_cast<int32_T>(isinf(d.data[0])))) &&
        (static_cast<boolean_T>(!static_cast<int32_T>(isnan(d.data[0]))))) {
      *y = 0.0;
    } else {
      *y = CUDART_NAN;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel26(
    const real_T d2scaled, const emxArray_real_T d, const int32_T nx,
    emxArray_real_T absdiff)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabs(d.data[k] - d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel27(
    const emxArray_creal_T D, const int32_T nz, emxArray_creal_T d,
    int32_T D_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nz);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    d.data[k] = D.data[k + D_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel28(
    const emxArray_real_T z, const int32_T ch, const int32_T b,
    emxArray_real_T x, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i + x_dim0 * ch] -= z.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel29(
    const emxArray_real_T dv1, const int32_T ch, const int32_T b,
    emxArray_real_T w, int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    w.data[i + w_dim0 * ch] = dv1.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel3(
    const real_T d2scaled, const int32_T b, emxArray_real_T lin,
    int32_T lin_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] =
        static_cast<real_T>((((k + 2) << 1) - lin_dim1) - 1) * d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel30(
    const int32_T ch, const emxArray_real_T w, const int32_T b_w,
    emxArray_boolean_T x, int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_w);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = static_cast<boolean_T>(
        !static_cast<int32_T>(w.data[i + w_dim0 * ch] != 0.0));
  }
}

static __global__ __launch_bounds__(32,
                                    1) void ec_detr_kernel4(emxArray_real_T lin,
                                                            int32_T lin_dim1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    lin.data[lin_dim1 >> 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel5(
    const emxArray_real_T lin, const int32_T k, const int32_T b,
    emxArray_real_T regs, int32_T regs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_k;
    b_k = static_cast<int32_T>(idx);
    regs.data[b_k + regs_dim0 * k] =
        pow(lin.data[b_k], static_cast<real_T>(k) + 1.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel6(
    const int32_T ch, const emxArray_real_T x, const int32_T b_x,
    emxArray_real_T dv, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv.data[i] = x.data[i + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel7(
    const int32_T ch, const emxArray_real_T w, const int32_T b_w,
    emxArray_real_T dv1, int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_w);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv1.data[i] = w.data[i + w_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel8(
    const emxArray_real_T dv1, const emxArray_real_T dv, const int32_T b_dv,
    emxArray_real_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = dv.data[i] * dv1.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel9(
    const emxArray_real_T dv1, const emxArray_real_T dv, const int32_T b_dv,
    emxArray_real_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = dv.data[i] * dv1.data[i];
  }
}

static void gpuEmxEnsureCapacity_boolean_T(const emxArray_boolean_T *cpu,
                                           emxArray_boolean_T *gpu,
                                           boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  boolean_T *newData;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < totalSizeCpu) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(boolean_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(boolean_T),
                     cudaMemcpyDeviceToDevice),
          __FILE__, __LINE__);
    }
    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }
    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
                                         emxArray_creal_T *gpu,
                                         boolean_T needsCopy)
{
  creal_T *newData;
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < totalSizeCpu) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(creal_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(creal_T),
                     cudaMemcpyDeviceToDevice),
          __FILE__, __LINE__);
    }
    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }
    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxFree_creal_T(emxArray_creal_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxMemcpyCpuToGpu_creal_T(emxArray_creal_T *gpu,
                                         const emxArray_creal_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(cudaMemcpy(gpu->data, cpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(creal_T),
                            cudaMemcpyHostToDevice),
                 __FILE__, __LINE__);
}

static void gpuEmxMemcpyGpuToCpu_boolean_T(emxArray_boolean_T *cpu,
                                           emxArray_boolean_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(
      cudaMemcpy(cpu->data, gpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(boolean_T),
                 cudaMemcpyDeviceToHost),
      __FILE__, __LINE__);
}

static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu,
                                         emxArray_creal_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(cudaMemcpy(cpu->data, gpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(creal_T),
                            cudaMemcpyDeviceToHost),
                 __FILE__, __LINE__);
}

static void gpuEmxReset_boolean_T(emxArray_boolean_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_boolean_T));
}

static void gpuEmxReset_creal_T(emxArray_creal_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_creal_T));
}

static void times(emxArray_real_T *in1, const emxArray_real_T *in2,
                  const emxArray_real_T *in3)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in3->size[0] == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3->size[0];
  }
  emxEnsureCapacity_real_T(in1, i, &cc_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in3->size[0];
  }
  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[i * stride_0_0] * in3->data[i * stride_1_0];
  }
}

//
// function [x,w,olPct] = ec_detr(x,w,ord,thr,itr)
void ec_detr(emxArray_real_T *cpu_x, emxArray_real_T *cpu_w,
             const real_T ord_data[], const int32_T ord_size[2],
             const real_T thr_data[], const int32_T[2], const real_T itr_data[],
             const int32_T[2], real_T olPct_data[], int32_T olPct_size[2])
{
  dim3 block;
  dim3 grid;
  emxArray_boolean_T d_gpu_x;
  emxArray_boolean_T *b_cpu_x;
  emxArray_creal_T b_gpu_d;
  emxArray_creal_T gpu_D;
  emxArray_creal_T gpu_V;
  emxArray_creal_T *cpu_D;
  emxArray_creal_T *cpu_V;
  emxArray_creal_T *cpu_d;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T *cpu_iv;
  emxArray_real_T b_gpu_V;
  emxArray_real_T b_gpu_r;
  emxArray_real_T b_gpu_regs;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_V;
  emxArray_real_T c_gpu_x;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_y;
  emxArray_real_T e_gpu_y;
  emxArray_real_T f_gpu_y;
  emxArray_real_T gpu_A;
  emxArray_real_T gpu_absdiff;
  emxArray_real_T gpu_d;
  emxArray_real_T gpu_dv;
  emxArray_real_T gpu_dv1;
  emxArray_real_T gpu_dv2;
  emxArray_real_T gpu_lin;
  emxArray_real_T gpu_r;
  emxArray_real_T gpu_r1;
  emxArray_real_T gpu_r2;
  emxArray_real_T gpu_r3;
  emxArray_real_T gpu_r4;
  emxArray_real_T gpu_regs;
  emxArray_real_T gpu_w;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_z;
  emxArray_real_T *b_cpu_V;
  emxArray_real_T *b_cpu_d;
  emxArray_real_T *b_cpu_r;
  emxArray_real_T *b_cpu_regs;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_V;
  emxArray_real_T *c_cpu_x;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_A;
  emxArray_real_T *cpu_absdiff;
  emxArray_real_T *cpu_dv;
  emxArray_real_T *cpu_dv1;
  emxArray_real_T *cpu_dv2;
  emxArray_real_T *cpu_lin;
  emxArray_real_T *cpu_r;
  emxArray_real_T *cpu_r1;
  emxArray_real_T *cpu_r2;
  emxArray_real_T *cpu_r3;
  emxArray_real_T *cpu_r4;
  emxArray_real_T *cpu_regs;
  emxArray_real_T *cpu_y;
  emxArray_real_T *cpu_z;
  emxArray_real_T *d_cpu_x;
  emxArray_real_T *d_cpu_y;
  emxArray_real_T *e_cpu_y;
  emxArray_real_T *f_cpu_y;
  emxArray_real_T *olPct;
  real_T g_cpu_y;
  real_T *g_gpu_y;
  int32_T b_i;
  int32_T i;
  int32_T i5;
  int32_T nFrames;
  boolean_T A_outdatedOnCpu;
  boolean_T b_x_outdatedOnCpu;
  boolean_T c_x_outdatedOnCpu;
  boolean_T d_outdatedOnCpu;
  boolean_T dv2_outdatedOnCpu;
  boolean_T dv2_outdatedOnGpu;
  boolean_T iv_outdatedOnGpu;
  boolean_T r1_outdatedOnCpu;
  boolean_T r1_outdatedOnGpu;
  boolean_T r_outdatedOnGpu;
  boolean_T w_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnCpu;
  boolean_T x_outdatedOnGpu;
  boolean_T y_outdatedOnCpu;
  boolean_T y_outdatedOnGpu;
  checkCudaError(mwCudaMalloc(&g_gpu_y, 8UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_r4);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_real_T(&gpu_r3);
  gpuEmxReset_real_T(&c_gpu_V);
  gpuEmxReset_real_T(&gpu_r2);
  gpuEmxReset_real_T(&b_gpu_regs);
  gpuEmxReset_real_T(&gpu_r1);
  gpuEmxReset_real_T(&gpu_r);
  gpuEmxReset_real_T(&gpu_absdiff);
  gpuEmxReset_real_T(&f_gpu_y);
  gpuEmxReset_real_T(&gpu_d);
  gpuEmxReset_real_T(&gpu_dv2);
  gpuEmxReset_real_T(&e_gpu_y);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_real_T(&gpu_A);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_creal_T(&b_gpu_d);
  gpuEmxReset_real_T(&b_gpu_V);
  gpuEmxReset_creal_T(&gpu_D);
  gpuEmxReset_creal_T(&gpu_V);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&b_gpu_r);
  gpuEmxReset_real_T(&c_gpu_x);
  gpuEmxReset_real_T(&b_gpu_x);
  gpuEmxReset_boolean_T(&d_gpu_x);
  gpuEmxReset_real_T(&gpu_z);
  gpuEmxReset_real_T(&gpu_dv1);
  gpuEmxReset_real_T(&gpu_dv);
  gpuEmxReset_real_T(&gpu_lin);
  gpuEmxReset_real_T(&gpu_regs);
  gpuEmxReset_real_T(&gpu_w);
  gpuEmxReset_real_T(&gpu_x);
  r1_outdatedOnCpu = false;
  d_outdatedOnCpu = false;
  A_outdatedOnCpu = false;
  iv_outdatedOnGpu = false;
  y_outdatedOnGpu = false;
  c_x_outdatedOnCpu = false;
  b_x_outdatedOnCpu = false;
  dv2_outdatedOnCpu = false;
  w_outdatedOnGpu = true;
  x_outdatedOnCpu = false;
  x_outdatedOnGpu = true;
  y_outdatedOnCpu = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  //  Robust detrending - wrapper for GPU processing (CUDA source code)
  //
  //  INPUTS:
  //     see 'input validation' section below
  //  OUTPUTS:
  //     y = detrended data
  //     w = updated weights
  //     r = basis matrix used
  //
  //  This code was adapted from NoiseTools (audition.ens.fr/adc/NoiseTools)
  //
  //  Modified by: Kevin Tan, 2022 (kevmtan.github.io)
  //     - Added GPU support
  //     - Replaced bsxfun with implicit expansion operators (much faster)
  //     - Miscellaneous compute & readability enhancements
  //  Input validation
  // 'ec_detr:20' x (:,:){mustBeFloat}
  // 'ec_detr:21' w (:,:){mustBeFloat}
  // 'ec_detr:22' ord (1,:){mustBeFloat}
  // 'ec_detr:23' thr (1,:){mustBeFloat}
  // 'ec_detr:24' itr (1,:){mustBeFloat}
  //  Main
  // 'ec_detr:28' coder.gpu.kernelfun;
  //  trigger CUDA kernel generation
  // 'ec_detr:29' nFrames = size(x,1);
  nFrames = cpu_x->size[0];
  // 'ec_detr:30' nChs = size(x,2);
  // 'ec_detr:31' reps = numel(ord);
  // 'ec_detr:32' olPct = coder.nullcopy(nan(nChs,reps));
  emxInit_real_T(&olPct, 2, &uc_emlrtRTEI, true);
  i = olPct->size[0] * olPct->size[1];
  olPct->size[0] = cpu_x->size[1];
  olPct->size[1] = ord_size[1];
  emxEnsureCapacity_real_T(olPct, i, &ub_emlrtRTEI);
  //  Detrend by polynomial order
  // 'ec_detr:35' for ii = 1:reps
  b_i = ord_size[1];
  emxInit_real_T(&cpu_regs, 2, &vc_emlrtRTEI, true);
  emxInit_real_T(&cpu_lin, 2, &wc_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv, 1, &jc_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv1, 1, &jc_emlrtRTEI, true);
  emxInit_real_T(&cpu_z, 1, &xc_emlrtRTEI, true);
  emxInit_boolean_T(&b_cpu_x, 1, &bc_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_x, 1, &cc_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_x, 1, &cc_emlrtRTEI, true);
  emxInit_real_T(&cpu_r, 2, &yc_emlrtRTEI, true);
  emxInit_real_T(&cpu_y, 2, &ad_emlrtRTEI, true);
  emxInit_creal_T(&cpu_V, 2, &jc_emlrtRTEI, true);
  emxInit_creal_T(&cpu_D, 2, &jc_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_V, 2, &bd_emlrtRTEI, true);
  emxInit_creal_T(&cpu_d, 1, &cd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &dd_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_y, 2, &ed_emlrtRTEI, true);
  emxInit_real_T(&cpu_A, 2, &nc_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_y, 2, &fd_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_y, 1, &gd_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv2, 1, &hd_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_d, 1, &rc_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_y, 1, &id_emlrtRTEI, true);
  emxInit_real_T(&cpu_absdiff, 1, &jd_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_r, 2, &kd_emlrtRTEI, true);
  emxInit_real_T(&cpu_r1, 2, &ld_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_regs, 2, &cc_emlrtRTEI, true);
  emxInit_real_T(&cpu_r2, 2, &fc_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_V, 2, &kc_emlrtRTEI, true);
  emxInit_real_T(&cpu_r3, 2, &fc_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_y, 1, &pc_emlrtRTEI, true);
  emxInit_real_T(&cpu_r4, 2, &mc_emlrtRTEI, true);
  for (int32_T ii{0}; ii < b_i; ii++) {
    real_T d2scaled;
    int32_T i4;
    int32_T k;
    int32_T nx;
    int32_T nz;
    boolean_T regs_needsGpuEnsureCapacity;
    boolean_T regs_outdatedOnCpu;
    boolean_T validLaunchParams;
    // 'ec_detr:36' iOrd=ord(ii);
    // 'ec_detr:36' iThr=thr(ii);
    // 'ec_detr:36' iItr=itr(ii);
    //  copy
    // 'ec_detr:37' regs = regsFromBasis_lfn(nFrames,iOrd);
    // %%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS
    // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    //  Get regressors from polynomial function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    // 'ec_detr:58' regs = coder.nullcopy(zeros(nFrames,iOrd,'like',iOrd));
    regs_outdatedOnCpu = false;
    i = cpu_regs->size[0] * cpu_regs->size[1];
    cpu_regs->size[0] = nFrames;
    cpu_regs->size[1] = static_cast<int32_T>(ord_data[ii]);
    emxEnsureCapacity_real_T(cpu_regs, i, &vb_emlrtRTEI);
    regs_needsGpuEnsureCapacity = true;
    // 'ec_detr:59' lin = linspace(-1,1,nFrames);
    i = cpu_lin->size[0] * cpu_lin->size[1];
    cpu_lin->size[0] = 1;
    cpu_lin->size[1] = nFrames;
    emxEnsureCapacity_real_T(cpu_lin, i, &wb_emlrtRTEI);
    dv2_outdatedOnGpu = true;
    if (nFrames >= 1) {
      gpuEmxEnsureCapacity_real_T(cpu_lin, &gpu_lin, true);
      dv2_outdatedOnGpu = false;
      ec_detr_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nFrames,
                                                               gpu_lin);
      if (cpu_lin->size[1] >= 2) {
        ec_detr_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_lin);
        if (cpu_lin->size[1] >= 3) {
          d2scaled = 1.0 / (static_cast<real_T>(cpu_lin->size[1]) - 1.0);
          nz = cpu_lin->size[1];
          mwGetLaunchParameters1D(computeNumIters(nz - 3), &grid, &block,
                                  2147483647U);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel3<<<grid, block>>>(d2scaled, nz - 3, gpu_lin,
                                             cpu_lin->size[1U]);
          }
          if ((cpu_lin->size[1] & 1) == 1) {
            ec_detr_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                gpu_lin, cpu_lin->size[1U]);
          }
        }
      }
    }
    // 'ec_detr:60' for k = 1:iOrd
    nz = static_cast<int32_T>(ord_data[ii]);
    for (k = 0; k < nz; k++) {
      // 'ec_detr:61' regs(:,k) = lin.^k;
      nx = cpu_lin->size[1];
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                              2147483647U);
      if (dv2_outdatedOnGpu) {
        gpuEmxEnsureCapacity_real_T(cpu_lin, &gpu_lin, true);
      }
      dv2_outdatedOnGpu = false;
      if (regs_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real_T(cpu_regs, &gpu_regs, true);
      }
      regs_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_detr_kernel5<<<grid, block>>>(gpu_lin, k, nx - 1, gpu_regs,
                                         cpu_regs->size[0U]);
      }
      regs_outdatedOnCpu = true;
    }
    //  Get regressors from basis function
    //  Detrend per chan
    // 'ec_detr:40' for ch = 1:nChs
    i4 = cpu_x->size[1];
    if (i4 - 1 >= 0) {
      i5 = static_cast<int32_T>(itr_data[ii]);
    }
    for (int32_T ch{0}; ch < i4; ch++) {
      boolean_T dv1_needsGpuEnsureCapacity;
      boolean_T dv1_outdatedOnCpu;
      boolean_T dv_needsGpuEnsureCapacity;
      boolean_T dv_outdatedOnCpu;
      boolean_T z_outdatedOnCpu;
      // 'ec_detr:41' [x(:,ch),w(:,ch)] =
      // detrend_lfn(x(:,ch),w(:,ch),regs,iThr,iItr);
      i = cpu_dv->size[0];
      cpu_dv->size[0] = cpu_x->size[0];
      emxEnsureCapacity_real_T(cpu_dv, i, &xb_emlrtRTEI);
      nx = cpu_x->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
      if (x_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
      dv_needsGpuEnsureCapacity = false;
      if (x_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_detr_kernel6<<<grid, block>>>(ch, gpu_x, nx, gpu_dv,
                                         cpu_x->size[0U]);
      }
      dv_outdatedOnCpu = true;
      i = cpu_dv1->size[0];
      cpu_dv1->size[0] = cpu_w->size[0];
      emxEnsureCapacity_real_T(cpu_dv1, i, &yb_emlrtRTEI);
      nx = cpu_w->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
      if (y_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real_T(cpu_w, &gpu_w, !w_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1, true);
      dv1_needsGpuEnsureCapacity = false;
      if (w_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, cpu_w);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_detr_kernel7<<<grid, block>>>(ch, gpu_w, nx, gpu_dv1,
                                         cpu_w->size[0U]);
      }
      dv1_outdatedOnCpu = true;
      //  Standard detrending (trend fit to entire data)
      //  %%%%%%%%%%%%%%%%%%%%%%%%% The data are fit to the basis using weighted
      //  least squares. The weight is updated by setting samples for which the
      //  residual is greater than 'thresh' times its std to zero, and the fit
      //  is repeated at most 'niter'-1 times.
      //
      //  The choice of order (and basis) determines what complexity of the
      //  trend that can be removed.  It may be useful to first detrend with a
      //  low order to avoid fitting outliers, and then increase the order.
      //
      //  The tricky bit is to ensure that weighted means are removed before
      //  calculating the regression (see nt_regw)
      //  Detrend per polynomial order
      // 'ec_detr:80' z = coder.nullcopy(x);
      z_outdatedOnCpu = false;
      x_outdatedOnGpu = false;
      i = cpu_z->size[0];
      cpu_z->size[0] = cpu_x->size[0];
      emxEnsureCapacity_real_T(cpu_z, i, &ac_emlrtRTEI);
      x_needsGpuEnsureCapacity = true;
      // 'ec_detr:81' for ii = 1:iItr
      for (int32_T b_ii{0}; b_ii < i5; b_ii++) {
        real_T b_mn;
        real_T mn;
        //  Weighted regression
        // 'ec_detr:83' z = regw_lfn(x,w,r);
        //  Weighted Regression
        //  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //   b: regression matrix (apply to r to approximate x)
        //   z: regression (r*b)
        //  Discard dimensions of r with eigenvalue lower than this
        // 'ec_detr:102' thrPCA = 1e-7;
        // zeros(1,1,class(x));
        //  Save weighted mean
        // 'ec_detr:105' mn = x - demean_lfn(x,w);
        //  Demean
        //  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ec_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_dv->size[0] == cpu_dv1->size[0]) {
          i = c_cpu_x->size[0];
          c_cpu_x->size[0] = cpu_dv->size[0];
          emxEnsureCapacity_real_T(c_cpu_x, i, &cc_emlrtRTEI);
          nx = cpu_dv->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                                  2147483647U);
          if (dv_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
          }
          dv_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real_T(c_cpu_x, &b_gpu_x, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel8<<<grid, block>>>(gpu_dv1, gpu_dv, nx, b_gpu_x);
          }
          b_x_outdatedOnCpu = true;
        } else {
          if (b_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_cpu_x, &b_gpu_x);
          }
          if (dv_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv, &gpu_dv);
          }
          dv_outdatedOnCpu = false;
          gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          dv1_outdatedOnCpu = false;
          times(c_cpu_x, cpu_dv, cpu_dv1);
          b_x_outdatedOnCpu = false;
          dv1_needsGpuEnsureCapacity = true;
          dv_needsGpuEnsureCapacity = true;
        }
        nx = c_cpu_x->size[0];
        if (c_cpu_x->size[0] == 0) {
          g_cpu_y = 0.0;
        } else {
          if (b_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_cpu_x, &b_gpu_x);
          }
          b_x_outdatedOnCpu = false;
          g_cpu_y = c_cpu_x->data[0];
          for (k = 0; k <= nx - 2; k++) {
            g_cpu_y += c_cpu_x->data[k + 1];
          }
        }
        nx = cpu_dv1->size[0];
        if (cpu_dv1->size[0] == 0) {
          d2scaled = 0.0;
        } else {
          if (dv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }
          dv1_outdatedOnCpu = false;
          d2scaled = cpu_dv1->data[0];
          dv1_needsGpuEnsureCapacity = true;
          for (k = 0; k <= nx - 2; k++) {
            d2scaled += cpu_dv1->data[k + 1];
          }
        }
        mn = g_cpu_y / (d2scaled + 2.2204460492503131E-16);
        // 'ec_detr:125' x = x - mn;
        //  Fit weighted regression
        // 'ec_detr:108' x = demean_lfn(x,w).* w;
        //  Demean
        //  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ec_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_dv->size[0] == cpu_dv1->size[0]) {
          i = d_cpu_x->size[0];
          d_cpu_x->size[0] = cpu_dv->size[0];
          emxEnsureCapacity_real_T(d_cpu_x, i, &cc_emlrtRTEI);
          nx = cpu_dv->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                                  2147483647U);
          if (dv1_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1, true);
          }
          dv1_needsGpuEnsureCapacity = false;
          if (dv_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
          }
          dv_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real_T(d_cpu_x, &c_gpu_x, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel9<<<grid, block>>>(gpu_dv1, gpu_dv, nx, c_gpu_x);
          }
          c_x_outdatedOnCpu = true;
        } else {
          if (c_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &c_gpu_x);
          }
          if (dv_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv, &gpu_dv);
          }
          dv_outdatedOnCpu = false;
          if (dv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }
          dv1_outdatedOnCpu = false;
          times(d_cpu_x, cpu_dv, cpu_dv1);
          c_x_outdatedOnCpu = false;
          dv1_needsGpuEnsureCapacity = true;
          dv_needsGpuEnsureCapacity = true;
        }
        nx = d_cpu_x->size[0];
        if (d_cpu_x->size[0] == 0) {
          g_cpu_y = 0.0;
        } else {
          if (c_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &c_gpu_x);
          }
          c_x_outdatedOnCpu = false;
          g_cpu_y = d_cpu_x->data[0];
          for (k = 0; k <= nx - 2; k++) {
            g_cpu_y += d_cpu_x->data[k + 1];
          }
        }
        nx = cpu_dv1->size[0];
        if (cpu_dv1->size[0] == 0) {
          d2scaled = 0.0;
        } else {
          if (dv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }
          dv1_outdatedOnCpu = false;
          d2scaled = cpu_dv1->data[0];
          dv1_needsGpuEnsureCapacity = true;
          for (k = 0; k <= nx - 2; k++) {
            d2scaled += cpu_dv1->data[k + 1];
          }
        }
        b_mn = g_cpu_y / (d2scaled + 2.2204460492503131E-16);
        // 'ec_detr:125' x = x - mn;
        // 'ec_detr:109' r = demean_lfn(r,w);
        //  Demean
        //  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ec_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        nx = cpu_dv1->size[0];
        if (cpu_dv1->size[0] == 0) {
          g_cpu_y = 0.0;
        } else {
          if (dv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }
          dv1_outdatedOnCpu = false;
          g_cpu_y = cpu_dv1->data[0];
          dv1_needsGpuEnsureCapacity = true;
          for (k = 0; k <= nx - 2; k++) {
            g_cpu_y += cpu_dv1->data[k + 1];
          }
        }
        // 'ec_detr:125' x = x - mn;
        if (cpu_regs->size[0] == cpu_dv1->size[0]) {
          i = b_cpu_regs->size[0] * b_cpu_regs->size[1];
          b_cpu_regs->size[0] = cpu_regs->size[0];
          b_cpu_regs->size[1] = cpu_regs->size[1];
          emxEnsureCapacity_real_T(b_cpu_regs, i, &cc_emlrtRTEI);
          nx = cpu_regs->size[1] - 1;
          nz = cpu_regs->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx, nz), &grid, &block,
                                  2147483647U);
          if (dv1_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1, true);
          }
          dv1_needsGpuEnsureCapacity = false;
          if (regs_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_regs, &gpu_regs, true);
          }
          regs_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real_T(b_cpu_regs, &b_gpu_regs, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel10<<<grid, block>>>(gpu_dv1, gpu_regs, nz, nx,
                                              b_gpu_regs, b_cpu_regs->size[0U],
                                              cpu_regs->size[0U]);
          }
          gpuEmxMemcpyGpuToCpu_real_T(b_cpu_regs, &b_gpu_regs);
          coder::sum(b_cpu_regs, b_cpu_r);
        } else {
          if (regs_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_regs, &gpu_regs);
          }
          regs_outdatedOnCpu = false;
          if (dv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }
          dv1_outdatedOnCpu = false;
          binary_expand_op_4(b_cpu_r, cpu_regs, cpu_dv1);
          dv1_needsGpuEnsureCapacity = true;
          regs_needsGpuEnsureCapacity = true;
        }
        g_cpu_y += 2.2204460492503131E-16;
        i = cpu_r->size[0] * cpu_r->size[1];
        cpu_r->size[0] = cpu_regs->size[0];
        cpu_r->size[1] = cpu_regs->size[1];
        emxEnsureCapacity_real_T(cpu_r, i, &dc_emlrtRTEI);
        nx = cpu_regs->size[1] - 1;
        nz = cpu_regs->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx, nz), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_real_T(b_cpu_r, &gpu_r, false);
        if (regs_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real_T(cpu_regs, &gpu_regs, true);
        }
        regs_needsGpuEnsureCapacity = false;
        gpuEmxEnsureCapacity_real_T(cpu_r, &b_gpu_r, true);
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, b_cpu_r);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel11<<<grid, block>>>(g_cpu_y, gpu_r, gpu_regs, nz, nx,
                                            b_gpu_r, cpu_r->size[0U],
                                            cpu_regs->size[0U]);
        }
        r_outdatedOnGpu = false;
        //  remove channel-specific-weighted mean from regressor
        // 'ec_detr:110' rr = r.*w;
        if (cpu_r->size[0] == cpu_dv1->size[0]) {
          i = cpu_r1->size[0] * cpu_r1->size[1];
          cpu_r1->size[0] = cpu_r->size[0];
          cpu_r1->size[1] = cpu_r->size[1];
          emxEnsureCapacity_real_T(cpu_r1, i, &ec_emlrtRTEI);
          nx = cpu_r->size[1] - 1;
          nz = cpu_r->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx, nz), &grid, &block,
                                  2147483647U);
          if (dv1_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1, true);
          }
          dv1_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real_T(cpu_r1, &gpu_r1, true);
          y_outdatedOnCpu = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel12<<<grid, block>>>(gpu_dv1, b_gpu_r, nz, nx, gpu_r1,
                                              cpu_r1->size[0U],
                                              cpu_r->size[0U]);
          }
          r1_outdatedOnGpu = false;
          r1_outdatedOnCpu = true;
        } else {
          if (r1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_r1, &gpu_r1);
          }
          gpuEmxMemcpyGpuToCpu_real_T(cpu_r, &b_gpu_r);
          if (dv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }
          dv1_outdatedOnCpu = false;
          binary_expand_op_3(cpu_r1, cpu_r, cpu_dv1);
          r1_outdatedOnCpu = false;
          r1_outdatedOnGpu = true;
          dv1_needsGpuEnsureCapacity = true;
          y_outdatedOnCpu = true;
        }
        // 'ec_detr:111' [V,D] = eig(rr'*rr);
        i = cpu_r2->size[0] * cpu_r2->size[1];
        cpu_r2->size[0] = cpu_r1->size[1];
        cpu_r2->size[1] = cpu_r1->size[0];
        emxEnsureCapacity_real_T(cpu_r2, i, &fc_emlrtRTEI);
        nx = cpu_r1->size[0] - 1;
        nz = cpu_r1->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx, nz), &grid, &block,
                                2147483647U);
        if (y_outdatedOnCpu) {
          gpuEmxEnsureCapacity_real_T(cpu_r1, &gpu_r1, !r1_outdatedOnGpu);
        }
        gpuEmxEnsureCapacity_real_T(cpu_r2, &gpu_r2, true);
        if (r1_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_r1, cpu_r1);
        }
        r1_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel13<<<grid, block>>>(gpu_r1, nz, nx, gpu_r2,
                                            cpu_r2->size[0U], cpu_r1->size[0U]);
        }
        x_outdatedOnGpu = false;
        coder::internal::blas::mtimes(cpu_r2, &gpu_r2, &x_outdatedOnGpu, cpu_r1,
                                      &gpu_r1, &r1_outdatedOnGpu, cpu_y,
                                      &y_outdatedOnCpu, &gpu_y,
                                      &y_outdatedOnGpu);
        if (y_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_y, &gpu_y);
        }
        coder::eig(cpu_y, cpu_V, cpu_D);
        // 'ec_detr:112' V = real(V);
        i = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = cpu_V->size[0];
        b_cpu_V->size[1] = cpu_V->size[1];
        emxEnsureCapacity_real_T(b_cpu_V, i, &gc_emlrtRTEI);
        nx = cpu_V->size[0] * cpu_V->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_creal_T(cpu_V, &gpu_V, false);
        gpuEmxEnsureCapacity_real_T(b_cpu_V, &b_gpu_V, true);
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, cpu_V);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel14<<<grid, block>>>(gpu_V, nx, b_gpu_V);
        }
        // 'ec_detr:113' D = real(diag(D));
        if ((cpu_D->size[0] == 1) && (cpu_D->size[1] == 1)) {
          i = cpu_d->size[0];
          cpu_d->size[0] = 1;
          emxEnsureCapacity_creal_T(cpu_d, i, &ic_emlrtRTEI);
          cpu_d->data[0] = cpu_D->data[0];
          dv2_outdatedOnCpu = false;
        } else {
          nz = cpu_D->size[0];
          nx = cpu_D->size[1];
          if (nz <= nx) {
            nx = nz;
          }
          if (cpu_D->size[1] > 0) {
            nz = nx;
          } else {
            nz = 0;
          }
          i = cpu_d->size[0];
          cpu_d->size[0] = nz;
          emxEnsureCapacity_creal_T(cpu_d, i, &hc_emlrtRTEI);
          nz--;
          mwGetLaunchParameters1D(computeNumIters(nz), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_creal_T(cpu_D, &gpu_D, false);
          gpuEmxEnsureCapacity_creal_T(cpu_d, &b_gpu_d, true);
          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, cpu_D);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel27<<<grid, block>>>(gpu_D, nz, b_gpu_d,
                                              cpu_D->size[0U]);
          }
          dv2_outdatedOnCpu = true;
        }
        // 'ec_detr:114' V = V(:,D/max(D)>thrPCA);
        nx = cpu_d->size[0];
        if (dv2_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_creal_T(cpu_d, &b_gpu_d);
        }
        d2scaled = cpu_d->data[0].re;
        for (i = 0; i <= nx - 2; i++) {
          if (std::isnan(cpu_d->data[i + 1].re)) {
            dv2_outdatedOnCpu = false;
          } else if (std::isnan(d2scaled)) {
            dv2_outdatedOnCpu = true;
          } else {
            dv2_outdatedOnCpu = (d2scaled < cpu_d->data[i + 1].re);
          }
          if (dv2_outdatedOnCpu) {
            d2scaled = cpu_d->data[i + 1].re;
          }
        }
        k = cpu_d->size[0] - 1;
        nz = 0;
        for (i = 0; i <= k; i++) {
          if (cpu_d->data[i].re / d2scaled > 1.0E-7) {
            nz++;
          }
        }
        i = cpu_iv->size[0];
        cpu_iv->size[0] = nz;
        emxEnsureCapacity_int32_T(cpu_iv, i, &jc_emlrtRTEI);
        nx = 0;
        for (i = 0; i <= k; i++) {
          if (cpu_d->data[i].re / d2scaled > 1.0E-7) {
            cpu_iv->data[nx] = i;
            iv_outdatedOnGpu = true;
            nx++;
          }
        }
        nz = b_cpu_V->size[0];
        i = c_cpu_V->size[0] * c_cpu_V->size[1];
        c_cpu_V->size[0] = b_cpu_V->size[0];
        c_cpu_V->size[1] = cpu_iv->size[0];
        emxEnsureCapacity_real_T(c_cpu_V, i, &kc_emlrtRTEI);
        nx = cpu_iv->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx, nz - 1), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, !iv_outdatedOnGpu);
        gpuEmxEnsureCapacity_real_T(c_cpu_V, &c_gpu_V, true);
        if (iv_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv, cpu_iv);
        }
        iv_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel15<<<grid, block>>>(gpu_iv, b_gpu_V, nz - 1, nx,
                                            c_gpu_V, c_cpu_V->size[0U],
                                            b_cpu_V->size[0U]);
        }
        i = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = c_cpu_V->size[0];
        b_cpu_V->size[1] = c_cpu_V->size[1];
        emxEnsureCapacity_real_T(b_cpu_V, i, &lc_emlrtRTEI);
        nx = c_cpu_V->size[0] * c_cpu_V->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_real_T(b_cpu_V, &b_gpu_V, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel16<<<grid, block>>>(c_gpu_V, nx, b_gpu_V);
        }
        dv2_outdatedOnGpu = false;
        //  discard weak dims
        // 'ec_detr:115' rr = rr*V;
        x_needsGpuEnsureCapacity = false;
        i = cpu_r4->size[0] * cpu_r4->size[1];
        cpu_r4->size[0] = cpu_r1->size[0];
        cpu_r4->size[1] = cpu_r1->size[1];
        emxEnsureCapacity_real_T(cpu_r4, i, &mc_emlrtRTEI);
        nz = cpu_r1->size[0] * cpu_r1->size[1] - 1;
        for (i = 0; i <= nz; i++) {
          if (r1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_r1, &gpu_r1);
          }
          r1_outdatedOnCpu = false;
          cpu_r4->data[i] = cpu_r1->data[i];
          x_needsGpuEnsureCapacity = true;
        }
        coder::internal::blas::mtimes(
            cpu_r4, &gpu_r4, &x_needsGpuEnsureCapacity, b_cpu_V, &b_gpu_V,
            &dv2_outdatedOnGpu, cpu_r1, &r1_outdatedOnCpu, &gpu_r1,
            &r1_outdatedOnGpu);
        y_outdatedOnCpu = true;
        // 'ec_detr:116' b = (x'*rr) / (rr'*rr);
        if (cpu_dv->size[0] == cpu_dv1->size[0]) {
          i = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = 1;
          cpu_A->size[1] = cpu_dv->size[0];
          emxEnsureCapacity_real_T(cpu_A, i, &nc_emlrtRTEI);
          nx = cpu_dv->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                                  2147483647U);
          if (dv1_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1, true);
          }
          dv1_needsGpuEnsureCapacity = false;
          if (dv_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
          }
          dv_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real_T(cpu_A, &gpu_A, true);
          x_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel17<<<grid, block>>>(gpu_dv1, b_mn, gpu_dv, nx, gpu_A);
          }
          x_outdatedOnGpu = false;
          A_outdatedOnCpu = true;
        } else {
          if (A_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &gpu_A);
          }
          if (dv_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv, &gpu_dv);
          }
          dv_outdatedOnCpu = false;
          if (dv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }
          dv1_outdatedOnCpu = false;
          binary_expand_op_2(cpu_A, cpu_dv, b_mn, cpu_dv1);
          A_outdatedOnCpu = false;
          x_outdatedOnGpu = true;
          dv1_needsGpuEnsureCapacity = true;
          dv_needsGpuEnsureCapacity = true;
          x_needsGpuEnsureCapacity = true;
        }
        if ((cpu_A->size[1] == 0) || (cpu_r1->size[0] == 0) ||
            (cpu_r1->size[1] == 0)) {
          i = b_cpu_y->size[0] * b_cpu_y->size[1];
          b_cpu_y->size[0] = 1;
          b_cpu_y->size[1] = cpu_r1->size[1];
          emxEnsureCapacity_real_T(b_cpu_y, i, &oc_emlrtRTEI);
          nz = cpu_r1->size[1];
          mwGetLaunchParameters1D(computeNumIters(nz - 1), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel18<<<grid, block>>>(nz - 1, b_gpu_y);
          }
          w_outdatedOnGpu = false;
          dv2_outdatedOnCpu = true;
        } else {
          i = b_cpu_y->size[0] * b_cpu_y->size[1];
          b_cpu_y->size[0] = 1;
          b_cpu_y->size[1] = cpu_r1->size[1];
          emxEnsureCapacity_real_T(b_cpu_y, i, &c_emlrtRTEI);
          d2scaled = 1.0;
          g_cpu_y = 0.0;
          if (x_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_A, &gpu_A, !x_outdatedOnGpu);
          }
          gpuEmxEnsureCapacity_real_T(cpu_r1, &gpu_r1, !r1_outdatedOnGpu);
          y_outdatedOnCpu = false;
          gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
          if (x_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_A, cpu_A);
          }
          if (r1_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_r1, cpu_r1);
          }
          r1_outdatedOnGpu = false;
          cublasCheck(
              cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                          cpu_r1->size[1], cpu_A->size[1], (double *)&d2scaled,
                          (double *)&gpu_A.data[0], 1,
                          (double *)&gpu_r1.data[0], cpu_A->size[1],
                          (double *)&g_cpu_y, (double *)&b_gpu_y.data[0], 1),
              __FILE__, __LINE__);
          w_outdatedOnGpu = false;
          dv2_outdatedOnCpu = true;
        }
        i = cpu_r3->size[0] * cpu_r3->size[1];
        cpu_r3->size[0] = cpu_r1->size[1];
        cpu_r3->size[1] = cpu_r1->size[0];
        emxEnsureCapacity_real_T(cpu_r3, i, &fc_emlrtRTEI);
        nx = cpu_r1->size[0] - 1;
        nz = cpu_r1->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx, nz), &grid, &block,
                                2147483647U);
        if (y_outdatedOnCpu) {
          gpuEmxEnsureCapacity_real_T(cpu_r1, &gpu_r1, !r1_outdatedOnGpu);
        }
        gpuEmxEnsureCapacity_real_T(cpu_r3, &gpu_r3, true);
        if (r1_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_r1, cpu_r1);
        }
        r1_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel19<<<grid, block>>>(gpu_r1, nz, nx, gpu_r3,
                                            cpu_r3->size[0U], cpu_r1->size[0U]);
        }
        x_outdatedOnGpu = false;
        coder::internal::blas::mtimes(cpu_r3, &gpu_r3, &x_outdatedOnGpu, cpu_r1,
                                      &gpu_r1, &r1_outdatedOnGpu, c_cpu_y,
                                      &y_outdatedOnCpu, &c_gpu_y,
                                      &y_outdatedOnGpu);
        if (y_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(c_cpu_y, &c_gpu_y);
        }
        y_outdatedOnCpu = false;
        coder::internal::mrdiv(b_cpu_y, &dv2_outdatedOnCpu, &b_gpu_y,
                               &w_outdatedOnGpu, c_cpu_y);
        // 'ec_detr:117' z = r*(V*b') + mn;
        i = f_cpu_y->size[0];
        f_cpu_y->size[0] = b_cpu_y->size[1];
        emxEnsureCapacity_real_T(f_cpu_y, i, &pc_emlrtRTEI);
        nx = b_cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, !w_outdatedOnGpu);
        gpuEmxEnsureCapacity_real_T(f_cpu_y, &d_gpu_y, true);
        if (w_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_y, b_cpu_y);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel20<<<grid, block>>>(b_gpu_y, nx, d_gpu_y);
        }
        w_outdatedOnGpu = false;
        dv2_outdatedOnCpu = true;
        coder::internal::blas::b_mtimes(b_cpu_V, &b_gpu_V, &dv2_outdatedOnGpu,
                                        f_cpu_y, &d_gpu_y, &w_outdatedOnGpu,
                                        d_cpu_y, &y_outdatedOnCpu, &e_gpu_y,
                                        &y_outdatedOnGpu);
        coder::internal::blas::b_mtimes(cpu_r, &b_gpu_r, &r_outdatedOnGpu,
                                        d_cpu_y, &e_gpu_y, &y_outdatedOnGpu,
                                        cpu_dv2, &dv2_outdatedOnCpu, &gpu_dv2,
                                        &dv2_outdatedOnGpu);
        if (cpu_dv2->size[0] == cpu_dv->size[0]) {
          i = cpu_z->size[0];
          cpu_z->size[0] = cpu_dv2->size[0];
          emxEnsureCapacity_real_T(cpu_z, i, &qc_emlrtRTEI);
          nx = cpu_dv2->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                                  2147483647U);
          if (dv_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
          }
          dv_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real_T(cpu_dv2, &gpu_dv2, !dv2_outdatedOnGpu);
          gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z, true);
          x_needsGpuEnsureCapacity = false;
          if (dv2_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv2, cpu_dv2);
          }
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel21<<<grid, block>>>(mn, gpu_dv, gpu_dv2, nx, gpu_z);
          }
          x_outdatedOnGpu = false;
          z_outdatedOnCpu = true;
        } else {
          if (z_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_z, &gpu_z);
          }
          if (dv2_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv2, &gpu_dv2);
          }
          if (dv_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv, &gpu_dv);
          }
          dv_outdatedOnCpu = false;
          binary_expand_op_1(cpu_z, cpu_dv2, cpu_dv, mn);
          z_outdatedOnCpu = false;
          x_outdatedOnGpu = true;
          dv_needsGpuEnsureCapacity = true;
          x_needsGpuEnsureCapacity = true;
        }
        //  Find outliers
        // 'ec_detr:86' d = (x-z).*w;
        if (cpu_dv->size[0] == 1) {
          nx = cpu_z->size[0];
        } else {
          nx = cpu_dv->size[0];
        }
        if ((cpu_dv->size[0] == cpu_z->size[0]) && (nx == cpu_dv1->size[0])) {
          i = b_cpu_d->size[0];
          b_cpu_d->size[0] = cpu_dv->size[0];
          emxEnsureCapacity_real_T(b_cpu_d, i, &rc_emlrtRTEI);
          nx = cpu_dv->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                                  2147483647U);
          if (dv1_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1, true);
          }
          dv1_needsGpuEnsureCapacity = false;
          if (x_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z, !x_outdatedOnGpu);
          }
          x_needsGpuEnsureCapacity = false;
          if (dv_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
          }
          dv_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real_T(b_cpu_d, &gpu_d, true);
          dv2_outdatedOnGpu = false;
          if (x_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, cpu_z);
          }
          x_outdatedOnGpu = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel22<<<grid, block>>>(gpu_dv1, gpu_z, gpu_dv, nx,
                                              gpu_d);
          }
          dv2_outdatedOnCpu = false;
          d_outdatedOnCpu = true;
        } else {
          if (d_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_d, &gpu_d);
          }
          if (dv_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv, &gpu_dv);
          }
          dv_outdatedOnCpu = false;
          if (z_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_z, &gpu_z);
          }
          z_outdatedOnCpu = false;
          if (dv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }
          binary_expand_op(b_cpu_d, cpu_dv, cpu_z, cpu_dv1);
          d_outdatedOnCpu = false;
          dv2_outdatedOnCpu = true;
          dv1_needsGpuEnsureCapacity = true;
          x_needsGpuEnsureCapacity = true;
          dv_needsGpuEnsureCapacity = true;
          dv2_outdatedOnGpu = true;
        }
        // 'ec_detr:87' thrItr = iThr*std(d);
        nx = b_cpu_d->size[0] - 1;
        if (b_cpu_d->size[0] == 0) {
          g_cpu_y = rtNaN;
        } else if (b_cpu_d->size[0] == 1) {
          if (dv2_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(b_cpu_d, &gpu_d, !dv2_outdatedOnCpu);
          }
          dv2_outdatedOnGpu = false;
          if (dv2_outdatedOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, b_cpu_d);
          }
          dv2_outdatedOnCpu = false;
          ec_detr_kernel25<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_d,
                                                                    g_gpu_y);
          checkCudaError(
              cudaMemcpy(&g_cpu_y, g_gpu_y, 8UL, cudaMemcpyDeviceToHost),
              __FILE__, __LINE__);
        } else {
          if (d_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_d, &gpu_d);
          }
          d_outdatedOnCpu = false;
          d2scaled = b_cpu_d->data[0];
          for (k = 0; k < nx; k++) {
            d2scaled += b_cpu_d->data[k + 1];
          }
          d2scaled /= static_cast<real_T>(b_cpu_d->size[0]);
          i = cpu_absdiff->size[0];
          cpu_absdiff->size[0] = b_cpu_d->size[0];
          emxEnsureCapacity_real_T(cpu_absdiff, i, &sc_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real_T(b_cpu_d, &gpu_d, !dv2_outdatedOnCpu);
          dv2_outdatedOnGpu = false;
          gpuEmxEnsureCapacity_real_T(cpu_absdiff, &gpu_absdiff, true);
          if (dv2_outdatedOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, b_cpu_d);
          }
          dv2_outdatedOnCpu = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel26<<<grid, block>>>(d2scaled, gpu_d, nx, gpu_absdiff);
          }
          cublasCheck(cublasDnrm2(getCublasGlobalHandle(), b_cpu_d->size[0],
                                  (double *)&gpu_absdiff.data[0], 1,
                                  (double *)&g_cpu_y),
                      __FILE__, __LINE__);
          g_cpu_y /= std::sqrt(static_cast<real_T>(b_cpu_d->size[0]) - 1.0);
        }
        // 'ec_detr:88' w(abs(d)>thrItr) = 0;
        nx = b_cpu_d->size[0];
        i = e_cpu_y->size[0];
        e_cpu_y->size[0] = b_cpu_d->size[0];
        emxEnsureCapacity_real_T(e_cpu_y, i, &tc_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                                2147483647U);
        if (dv2_outdatedOnGpu) {
          gpuEmxEnsureCapacity_real_T(b_cpu_d, &gpu_d, !dv2_outdatedOnCpu);
        }
        gpuEmxEnsureCapacity_real_T(e_cpu_y, &f_gpu_y, true);
        if (dv2_outdatedOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, b_cpu_d);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel23<<<grid, block>>>(gpu_d, nx - 1, f_gpu_y);
        }
        k = e_cpu_y->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        if (dv1_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1, true);
        }
        dv1_needsGpuEnsureCapacity = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel24<<<grid, block>>>(thr_data[ii] * g_cpu_y, f_gpu_y, k,
                                            gpu_dv1);
        }
        dv1_outdatedOnCpu = true;
        //  update weights
      }
      //  Remove trends
      // 'ec_detr:92' x = x-z;
      nz = cpu_x->size[0];
      if (nz == cpu_z->size[0]) {
        mwGetLaunchParameters1D(computeNumIters(nz - 1), &grid, &block,
                                2147483647U);
        if (x_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z, !x_outdatedOnGpu);
        }
        x_needsGpuEnsureCapacity = false;
        if (x_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, cpu_z);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel28<<<grid, block>>>(gpu_z, ch, nz - 1, gpu_x,
                                            cpu_x->size[0U]);
        }
        x_outdatedOnGpu = false;
        x_outdatedOnCpu = true;
      } else {
        if (x_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_x, &gpu_x);
        }
        if (z_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_z, &gpu_z);
        }
        binary_expand_op_5(cpu_x, ch, cpu_z);
        x_outdatedOnCpu = false;
        x_outdatedOnGpu = true;
        x_needsGpuEnsureCapacity = true;
      }
      nz = cpu_w->size[0];
      mwGetLaunchParameters1D(computeNumIters(nz - 1), &grid, &block,
                              2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_detr_kernel29<<<grid, block>>>(gpu_dv1, ch, nz - 1, gpu_w,
                                          cpu_w->size[0U]);
      }
      dv2_outdatedOnCpu = true;
      //  Detrend
      // 'ec_detr:42' olPct(ch,ii) = sum(~w(:,ch));
      i = b_cpu_x->size[0];
      b_cpu_x->size[0] = cpu_w->size[0];
      emxEnsureCapacity_boolean_T(b_cpu_x, i, &bc_emlrtRTEI);
      nx = cpu_w->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
      y_outdatedOnCpu = false;
      gpuEmxEnsureCapacity_boolean_T(b_cpu_x, &d_gpu_x, true);
      w_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_detr_kernel30<<<grid, block>>>(ch, gpu_w, nx, d_gpu_x,
                                          cpu_w->size[0U]);
      }
      nx = b_cpu_x->size[0];
      if (b_cpu_x->size[0] == 0) {
        nz = 0;
      } else {
        gpuEmxMemcpyGpuToCpu_boolean_T(b_cpu_x, &d_gpu_x);
        nz = b_cpu_x->data[0];
        for (k = 0; k <= nx - 2; k++) {
          nz += b_cpu_x->data[k + 1];
        }
      }
      olPct->data[ch + olPct->size[0] * ii] = nz;
      //  Outlier percentages
    }
  }
  emxFree_real_T(&cpu_r4);
  emxFree_real_T(&f_cpu_y);
  emxFree_real_T(&cpu_r3);
  emxFree_real_T(&c_cpu_V);
  emxFree_real_T(&cpu_r2);
  emxFree_real_T(&b_cpu_regs);
  emxFree_real_T(&cpu_r1);
  emxFree_real_T(&b_cpu_r);
  emxFree_real_T(&cpu_absdiff);
  emxFree_real_T(&e_cpu_y);
  emxFree_real_T(&b_cpu_d);
  emxFree_real_T(&cpu_dv2);
  emxFree_real_T(&d_cpu_y);
  emxFree_real_T(&c_cpu_y);
  emxFree_real_T(&cpu_A);
  emxFree_real_T(&b_cpu_y);
  emxFree_int32_T(&cpu_iv);
  emxFree_creal_T(&cpu_d);
  emxFree_real_T(&b_cpu_V);
  emxFree_creal_T(&cpu_D);
  emxFree_creal_T(&cpu_V);
  emxFree_real_T(&cpu_y);
  emxFree_real_T(&cpu_r);
  emxFree_real_T(&d_cpu_x);
  emxFree_real_T(&c_cpu_x);
  emxFree_boolean_T(&b_cpu_x);
  emxFree_real_T(&cpu_z);
  emxFree_real_T(&cpu_dv1);
  emxFree_real_T(&cpu_dv);
  emxFree_real_T(&cpu_lin);
  emxFree_real_T(&cpu_regs);
  //  Sum outliers across chans
  // 'ec_detr:47' olPct = sum(olPct,1,"omitnan");
  coder::sum(olPct, olPct_data, olPct_size);
  emxFree_real_T(&olPct);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_outdatedOnCpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_x, &gpu_x);
  }
  if (dv2_outdatedOnCpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_w, &gpu_w);
  }
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_w);
  gpuEmxFree_real_T(&gpu_regs);
  gpuEmxFree_real_T(&gpu_lin);
  gpuEmxFree_real_T(&gpu_dv);
  gpuEmxFree_real_T(&gpu_dv1);
  gpuEmxFree_real_T(&gpu_z);
  gpuEmxFree_boolean_T(&d_gpu_x);
  gpuEmxFree_real_T(&b_gpu_x);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_real_T(&b_gpu_r);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_creal_T(&gpu_V);
  gpuEmxFree_creal_T(&gpu_D);
  gpuEmxFree_real_T(&b_gpu_V);
  gpuEmxFree_creal_T(&b_gpu_d);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&gpu_A);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&e_gpu_y);
  gpuEmxFree_real_T(&gpu_dv2);
  gpuEmxFree_real_T(&gpu_d);
  gpuEmxFree_real_T(&f_gpu_y);
  gpuEmxFree_real_T(&gpu_absdiff);
  gpuEmxFree_real_T(&gpu_r);
  gpuEmxFree_real_T(&gpu_r1);
  gpuEmxFree_real_T(&b_gpu_regs);
  gpuEmxFree_real_T(&gpu_r2);
  gpuEmxFree_real_T(&c_gpu_V);
  gpuEmxFree_real_T(&gpu_r3);
  gpuEmxFree_real_T(&d_gpu_y);
  gpuEmxFree_real_T(&gpu_r4);
  checkCudaError(mwCudaFree(g_gpu_y), __FILE__, __LINE__);
}

// End of code generation (ec_detr.cu)
