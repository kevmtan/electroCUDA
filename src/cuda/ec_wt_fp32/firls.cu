//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// firls.cu
//
// Code generation for function 'firls'
//

// Include files
#include "firls.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "mldivide.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cfloat>
#include <cmath>

// Variable Definitions
static emlrtRTEInfo df_emlrtRTEI{
    245,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo ef_emlrtRTEI{
    243,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo ff_emlrtRTEI{
    247,                                                     // lineNo
    5,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo gf_emlrtRTEI{
    258,                                                     // lineNo
    13,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo hf_emlrtRTEI{
    274,                                                     // lineNo
    33,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo if_emlrtRTEI{
    275,                                                     // lineNo
    33,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo jf_emlrtRTEI{
    276,                                                     // lineNo
    33,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo kf_emlrtRTEI{
    277,                                                     // lineNo
    33,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo lf_emlrtRTEI{
    286,                                                     // lineNo
    5,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo mf_emlrtRTEI{
    281,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo nf_emlrtRTEI{
    341,                                                     // lineNo
    13,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo of_emlrtRTEI{
    347,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo
    pf_emlrtRTEI{
        76,                  // lineNo
        9,                   // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

static emlrtRTEInfo qf_emlrtRTEI{
    1,                                                               // lineNo
    21,                                                              // colNo
    "flipud",                                                        // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/flipud.m" // pName
};

static emlrtRTEInfo rf_emlrtRTEI{
    341,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo sf_emlrtRTEI{
    353,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo tf_emlrtRTEI{
    355,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo uf_emlrtRTEI{
    253,                                                     // lineNo
    20,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo vf_emlrtRTEI{
    274,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo wf_emlrtRTEI{
    275,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo xf_emlrtRTEI{
    276,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo yf_emlrtRTEI{
    277,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo ag_emlrtRTEI{
    1,                                                       // lineNo
    16,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo bg_emlrtRTEI{
    295,                                                     // lineNo
    33,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo cg_emlrtRTEI{
    355,                                                     // lineNo
    17,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo dg_emlrtRTEI{
    297,                                                     // lineNo
    46,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo eg_emlrtRTEI{
    298,                                                     // lineNo
    39,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo rh_emlrtRTEI{
    297,                                                     // lineNo
    13,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo sh_emlrtRTEI{
    297,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo th_emlrtRTEI{
    295,                                                     // lineNo
    13,                                                      // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

static emlrtRTEInfo uh_emlrtRTEI{
    295,                                                     // lineNo
    9,                                                       // colNo
    "firls",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m" // pName
};

// Function Declarations
static void binary_expand_op_8(emxArray_real_T *in1, real_T in2,
                               const emxArray_real_T *in3, real_T in4,
                               const emxArray_real_T *in5);

static void binary_expand_op_9(emxArray_real_T *in1, real_T in2,
                               const emxArray_real_T *in3,
                               const emxArray_real_T *in4,
                               const emxArray_real_T *in5);

static real_T rt_remd_snf(real_T u0, real_T u1);

// Function Definitions
static void binary_expand_op_8(emxArray_real_T *in1, real_T in2,
                               const emxArray_real_T *in3, real_T in4,
                               const emxArray_real_T *in5)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  nvtxRangePushA("#fcn#binary_expand_op_8#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_in1, 1, &rh_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in3->size[0] == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in3->size[0];
  }
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(b_in1, i, &rh_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in1->size[0];
  } else {
    b = in3->size[0];
  }
  profileLoopStart("binary_expand_op_8_loop_0", __LINE__, (b - 1) + 1, "");
  for (i = 0; i < b; i++) {
    b_in1->data[i] =
        in1->data[i * stride_0_0] +
        (in2 * in3->data[i * stride_1_0] - in4 * in5->data[i * stride_1_0]);
  }
  profileLoopEnd();
  i = in1->size[0];
  in1->size[0] = b_in1->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(in1, i, &sh_emlrtRTEI);
  profileLoopStart("binary_expand_op_8_loop_1", __LINE__,
                   (b_in1->size[0] - 1) + 1, "");
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

static void binary_expand_op_9(emxArray_real_T *in1, real_T in2,
                               const emxArray_real_T *in3,
                               const emxArray_real_T *in4,
                               const emxArray_real_T *in5)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  nvtxRangePushA("#fcn#binary_expand_op_9#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_in1, 1, &th_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in5->size[0] == 1) {
    b = in3->size[0];
  } else {
    b = in5->size[0];
  }
  if (b == 1) {
    b_in1->size[0] = in1->size[0];
  } else if (in5->size[0] == 1) {
    b_in1->size[0] = in3->size[0];
  } else {
    b_in1->size[0] = in5->size[0];
  }
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(b_in1, i, &th_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  stride_2_0 = (in5->size[0] != 1);
  if (in5->size[0] == 1) {
    b = in3->size[0];
  } else {
    b = in5->size[0];
  }
  if (b == 1) {
    b = in1->size[0];
  } else if (in5->size[0] == 1) {
    b = in3->size[0];
  } else {
    b = in5->size[0];
  }
  profileLoopStart("binary_expand_op_9_loop_0", __LINE__, (b - 1) + 1, "");
  for (i = 0; i < b; i++) {
    b_in1->data[i] =
        in1->data[i * stride_0_0] +
        in2 * (in3->data[i * stride_1_0] - in4->data[i * stride_1_0]) /
            (in5->data[i * stride_2_0] * in5->data[i * stride_2_0]);
  }
  profileLoopEnd();
  i = in1->size[0];
  in1->size[0] = b_in1->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(in1, i, &uh_emlrtRTEI);
  profileLoopStart("binary_expand_op_9_loop_1", __LINE__,
                   (b_in1->size[0] - 1) + 1, "");
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

static real_T rt_remd_snf(real_T u0, real_T u1)
{
  real_T y;
  nvtxRangePushA("#fcn#rt_remd_snf#" MW_AT_LOCATION);
  if (std::isnan(u0) || std::isnan(u1) || std::isinf(u0)) {
    y = rtNaN;
  } else if (std::isinf(u1)) {
    y = u0;
  } else if ((u1 != 0.0) && (u1 != std::trunc(u1))) {
    real_T q;
    q = std::abs(u0 / u1);
    if (!(std::abs(q - std::floor(q + 0.5)) > DBL_EPSILON * q)) {
      y = 0.0 * u0;
    } else {
      y = std::fmod(u0, u1);
    }
  } else {
    y = std::fmod(u0, u1);
  }
  nvtxRangePop();
  return y;
}

//
//
namespace coder {
void firls(real_T varargin_1, const real_T varargin_2[4], emxArray_real_T *h)
{
  static const int8_T A[4]{1, 1, 0, 0};
  emxArray_real_T gpu_a;
  emxArray_real_T *G;
  emxArray_real_T *b;
  emxArray_real_T *b0;
  emxArray_real_T *b_dv;
  emxArray_real_T *b_dv1;
  emxArray_real_T *b_y;
  emxArray_real_T *cpu_a;
  emxArray_real_T *k;
  emxArray_real_T *m;
  emxArray_real_T *sinc1A;
  emxArray_real_T *sinc2A;
  emxArray_real_T *sinc3A;
  emxArray_real_T *sinc4A;
  emxArray_real_T *x;
  emxArray_real_T *y;
  real_T f1;
  real_T max_freq;
  real_T min_freq;
  int32_T i;
  boolean_T Nodd;
  boolean_T a_outdatedOnCpu;
  boolean_T a_outdatedOnGpu;
  nvtxRangePushA("#fcn#firls#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_a);
  a_outdatedOnCpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  max_freq = 0.0;
  min_freq = 0.0;
  profileLoopStart("firls_loop_0", __LINE__, 2 + 1, "");
  for (i = 0; i < 3; i++) {
    f1 = varargin_2[i + 1];
    if (std::isnan(f1)) {
      Nodd = false;
    } else if (std::isnan(max_freq)) {
      Nodd = true;
    } else {
      Nodd = (max_freq < f1);
    }
    if (Nodd) {
      max_freq = f1;
    }
    if (std::isnan(f1)) {
      Nodd = false;
    } else if (std::isnan(min_freq)) {
      Nodd = true;
    } else {
      Nodd = (min_freq > f1);
    }
    if (Nodd) {
      min_freq = f1;
    }
  }
  profileLoopEnd();
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&m, 2, &ef_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&k, 1, &ff_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&G, 2, &uf_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&sinc1A, 2, &vf_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&sinc2A, 2, &wf_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&sinc3A, 2, &xf_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&sinc4A, 2, &yf_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b, 1, &lf_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_a, 1, &ag_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_dv, 1, &bg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&x, 1, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_dv1, 1, &bg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&y, 1, &dg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_y, 1, &eg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b0, 1, &nf_emlrtRTEI, true);
  if ((!(max_freq > 1.0)) && (!(min_freq < 0.0))) {
    real_T F[4];
    real_T L;
    real_T b_b0;
    real_T tmpStorageLen;
    int32_T b_i;
    int32_T i1Start;
    int32_T loop_ub;
    int32_T md2;
    int32_T nG;
    int32_T nx;
    F[0] = varargin_2[0] / 2.0;
    F[1] = varargin_2[1] / 2.0;
    F[2] = varargin_2[2] / 2.0;
    F[3] = varargin_2[3] / 2.0;
    L = ((varargin_1 + 1.0) - 1.0) / 2.0;
    nvtxMarkA("#rt_remd_snf#" MW_AT_LINE);
    Nodd = (rt_remd_snf(varargin_1 + 1.0, 2.0) == 1.0);
    b_b0 = 0.0;
    if (!Nodd) {
      b_i = m->size[0] * m->size[1];
      m->size[0] = 1;
      m->size[1] = static_cast<int32_T>(L) + 1;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(m, b_i, &ef_emlrtRTEI);
      profileLoopStart("firls_loop_2", __LINE__, static_cast<int32_T>(L) + 1,
                       "");
      for (b_i = 0; b_i <= static_cast<int32_T>(L); b_i++) {
        m->data[b_i] = static_cast<real_T>(b_i) + 0.5;
      }
      profileLoopEnd();
    } else {
      b_i = m->size[0] * m->size[1];
      m->size[0] = 1;
      m->size[1] = static_cast<int32_T>(L) + 1;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(m, b_i, &df_emlrtRTEI);
      profileLoopStart("firls_loop_1", __LINE__, static_cast<int32_T>(L) + 1,
                       "");
      for (b_i = 0; b_i <= static_cast<int32_T>(L); b_i++) {
        m->data[b_i] = b_i;
      }
      profileLoopEnd();
    }
    b_i = k->size[0];
    k->size[0] = m->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(k, b_i, &ff_emlrtRTEI);
    profileLoopStart("firls_loop_3", __LINE__, (m->size[1] - 1) + 1, "");
    for (b_i = 0; b_i < m->size[1]; b_i++) {
      k->data[b_i] = m->data[b_i];
    }
    profileLoopEnd();
    a_outdatedOnGpu = (F[2] - F[1] != 0.0);
    nG = k->size[0];
    if (a_outdatedOnGpu) {
      b_i = G->size[0] * G->size[1];
      G->size[0] = k->size[0];
      G->size[1] = k->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(G, b_i, &gf_emlrtRTEI);
      profileLoopStart("firls_loop_4", __LINE__,
                       (k->size[0] * k->size[0] - 1) + 1, "");
      for (b_i = 0; b_i < k->size[0] * k->size[0]; b_i++) {
        G->data[b_i] = 0.0;
      }
      profileLoopEnd();
      tmpStorageLen = 2.0 * static_cast<real_T>(k->size[0]) - 1.0;
    } else {
      G->size[0] = 0;
      G->size[1] = 0;
      tmpStorageLen = 0.0;
    }
    b_i = sinc1A->size[0] * sinc1A->size[1];
    sinc1A->size[0] = 1;
    sinc1A->size[1] = static_cast<int32_T>(tmpStorageLen);
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(sinc1A, b_i, &hf_emlrtRTEI);
    b_i = sinc2A->size[0] * sinc2A->size[1];
    sinc2A->size[0] = 1;
    sinc2A->size[1] = static_cast<int32_T>(tmpStorageLen);
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(sinc2A, b_i, &if_emlrtRTEI);
    b_i = sinc3A->size[0] * sinc3A->size[1];
    sinc3A->size[0] = 1;
    sinc3A->size[1] = static_cast<int32_T>(tmpStorageLen);
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(sinc3A, b_i, &jf_emlrtRTEI);
    b_i = sinc4A->size[0] * sinc4A->size[1];
    sinc4A->size[0] = 1;
    sinc4A->size[1] = static_cast<int32_T>(tmpStorageLen);
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(sinc4A, b_i, &kf_emlrtRTEI);
    if (Nodd) {
      i1Start = -1;
      if (k->size[0] < 2) {
        i = 0;
        nx = 0;
      } else {
        i = 1;
        nx = k->size[0];
      }
      loop_ub = nx - i;
      profileLoopStart("firls_loop_6", __LINE__, (loop_ub - 1) + 1, "");
      for (b_i = 0; b_i < loop_ub; b_i++) {
        k->data[b_i] = k->data[i + b_i];
      }
      profileLoopEnd();
      b_i = k->size[0];
      k->size[0] = nx - i;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(k, b_i, &mf_emlrtRTEI);
    } else {
      i1Start = 0;
    }
    b_i = b->size[0];
    b->size[0] = k->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(b, b_i, &lf_emlrtRTEI);
    profileLoopStart("firls_loop_5", __LINE__, (k->size[0] - 1) + 1, "");
    for (b_i = 0; b_i < k->size[0]; b_i++) {
      b->data[b_i] = 0.0;
    }
    profileLoopEnd();
    profileLoopStart("firls_loop_7", __LINE__, 1 + 1, "");
    for (int32_T s{0}; s < 2; s++) {
      real_T a;
      real_T b1;
      int8_T i1;
      i = s << 1;
      i1 = A[i];
      f1 = F[i + 1];
      max_freq = F[i];
      min_freq = static_cast<real_T>(A[i + 1] - i1) / (f1 - max_freq);
      b1 = static_cast<real_T>(i1) - min_freq * max_freq;
      if (Nodd) {
        b_b0 += b1 * (f1 - max_freq) +
                min_freq / 2.0 * (f1 * f1 - max_freq * max_freq);
      }
      b_i = b_dv->size[0];
      b_dv->size[0] = k->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b_dv, b_i, &pf_emlrtRTEI);
      profileLoopStart("firls_loop_11", __LINE__, (k->size[0] - 1) + 1, "");
      for (b_i = 0; b_i < k->size[0]; b_i++) {
        b_dv->data[b_i] = 6.2831853071795862 * k->data[b_i] * F[i + 1];
      }
      profileLoopEnd();
      nx = b_dv->size[0];
      b_i = b_dv1->size[0];
      b_dv1->size[0] = k->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b_dv1, b_i, &pf_emlrtRTEI);
      profileLoopStart("firls_loop_14", __LINE__, (nx - 1) + 1, "");
      for (loop_ub = 0; loop_ub < nx; loop_ub++) {
        b_dv->data[loop_ub] = std::cos(b_dv->data[loop_ub]);
        b_dv1->data[loop_ub] = 6.2831853071795862 * k->data[loop_ub] * F[i];
      }
      profileLoopEnd();
      nx = b_dv1->size[0];
      profileLoopStart("firls_loop_16", __LINE__, (nx - 1) + 1, "");
      for (loop_ub = 0; loop_ub < nx; loop_ub++) {
        b_dv1->data[loop_ub] = std::cos(b_dv1->data[loop_ub]);
      }
      profileLoopEnd();
      a = min_freq / 39.478417604357432;
      if (b_dv->size[0] == 1) {
        b_i = k->size[0];
      } else {
        b_i = b_dv->size[0];
      }
      if ((b_dv->size[0] == k->size[0]) && (b->size[0] == b_i)) {
        profileLoopStart("firls_loop_20", __LINE__, (b->size[0] - 1) + 1, "");
        for (b_i = 0; b_i < b->size[0]; b_i++) {
          b->data[b_i] += a * (b_dv->data[b_i] - b_dv1->data[b_i]) /
                          (k->data[b_i] * k->data[b_i]);
        }
        profileLoopEnd();
      } else {
        nvtxMarkA("#binary_expand_op_9#" MW_AT_LINE);
        binary_expand_op_9(b, a, b_dv, b_dv1, k);
      }
      b_i = y->size[0];
      y->size[0] = k->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(y, b_i, &pf_emlrtRTEI);
      profileLoopStart("firls_loop_21", __LINE__, (k->size[0] - 1) + 1, "");
      for (b_i = 0; b_i < k->size[0]; b_i++) {
        y->data[b_i] = 2.0 * k->data[b_i] * F[i + 1];
      }
      profileLoopEnd();
      f1 = F[i + 1];
      a = f1 * (min_freq * f1 + b1);
      md2 = y->size[0];
      b_i = b_y->size[0];
      b_y->size[0] = k->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b_y, b_i, &pf_emlrtRTEI);
      profileLoopStart("firls_loop_22", __LINE__, (md2 - 1) + 1, "");
      for (loop_ub = 0; loop_ub < md2; loop_ub++) {
        if (std::abs(y->data[loop_ub]) < 1.0020841800044864E-292) {
          y->data[loop_ub] = 1.0;
        } else {
          f1 = 3.1415926535897931 * y->data[loop_ub];
          f1 = std::sin(f1) / f1;
          y->data[loop_ub] = f1;
        }
        b_y->data[loop_ub] = 2.0 * k->data[loop_ub] * F[i];
      }
      profileLoopEnd();
      f1 = F[i];
      max_freq = f1 * (min_freq * f1 + b1);
      nx = b_y->size[0];
      profileLoopStart("firls_loop_23", __LINE__, (nx - 1) + 1, "");
      for (loop_ub = 0; loop_ub < nx; loop_ub++) {
        if (std::abs(b_y->data[loop_ub]) < 1.0020841800044864E-292) {
          b_y->data[loop_ub] = 1.0;
        } else {
          f1 = 3.1415926535897931 * b_y->data[loop_ub];
          f1 = std::sin(f1) / f1;
          b_y->data[loop_ub] = f1;
        }
      }
      profileLoopEnd();
      if (b->size[0] == y->size[0]) {
        profileLoopStart("firls_loop_24", __LINE__, (b->size[0] - 1) + 1, "");
        for (b_i = 0; b_i < b->size[0]; b_i++) {
          b->data[b_i] += a * y->data[b_i] - max_freq * b_y->data[b_i];
        }
        profileLoopEnd();
      } else {
        nvtxMarkA("#binary_expand_op_8#" MW_AT_LINE);
        binary_expand_op_8(b, a, y, max_freq, b_y);
      }
      if (a_outdatedOnGpu) {
        real_T f2;
        uint32_T b_i1;
        f1 = 2.0 * F[i + 1];
        f2 = 2.0 * F[i];
        nx = static_cast<int32_T>(tmpStorageLen);
        profileLoopStart("firls_loop_25", __LINE__, (nx - 1) + 1, "");
        for (md2 = 0; md2 < nx; md2++) {
          b_i1 = (static_cast<uint32_T>(md2) + static_cast<uint32_T>(i1Start)) +
                 1U;
          max_freq = (static_cast<real_T>(md2) + 1.0) - static_cast<real_T>(nG);
          min_freq = f1 * static_cast<real_T>(b_i1);
          b1 = f2 * static_cast<real_T>(b_i1);
          a = f1 * max_freq;
          max_freq *= f2;
          if (std::abs(min_freq) < 1.0020841800044864E-292) {
            sinc1A->data[md2] = 1.0;
          } else {
            min_freq *= 3.1415926535897931;
            sinc1A->data[md2] = std::sin(min_freq) / min_freq;
          }
          if (std::abs(b1) < 1.0020841800044864E-292) {
            sinc2A->data[md2] = 1.0;
          } else {
            b1 *= 3.1415926535897931;
            sinc2A->data[md2] = std::sin(b1) / b1;
          }
          if (std::abs(a) < 1.0020841800044864E-292) {
            sinc3A->data[md2] = 1.0;
          } else {
            a *= 3.1415926535897931;
            sinc3A->data[md2] = std::sin(a) / a;
          }
          if (std::abs(max_freq) < 1.0020841800044864E-292) {
            sinc4A->data[md2] = 1.0;
          } else {
            max_freq *= 3.1415926535897931;
            sinc4A->data[md2] = std::sin(max_freq) / max_freq;
          }
        }
        profileLoopEnd();
        profileLoopStart("firls_loop_26", __LINE__, (nG - 1) + 1, "");
        for (md2 = 0; md2 < nG; md2++) {
          profileLoopStart("firls_loop_27", __LINE__, (nG - 1) + 1, "");
          for (nx = 0; nx < nG; nx++) {
            b_i1 =
                (static_cast<uint32_T>(nx) + static_cast<uint32_T>(md2)) + 1U;
            max_freq = static_cast<real_T>(nx - md2) + static_cast<real_T>(nG);
            G->data[nx + G->size[0] * md2] +=
                0.25 *
                (f1 * (sinc1A->data[static_cast<int32_T>(b_i1) - 1] +
                       sinc3A->data[static_cast<int32_T>(max_freq) - 1]) -
                 f2 * (sinc2A->data[static_cast<int32_T>(b_i1) - 1] +
                       sinc4A->data[static_cast<int32_T>(max_freq) - 1]));
          }
          profileLoopEnd();
        }
        profileLoopEnd();
      }
    }
    profileLoopEnd();
    if (Nodd) {
      b_i = b0->size[0];
      b0->size[0] = b->size[0] + 1;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b0, b_i, &nf_emlrtRTEI);
      b0->data[0] = b_b0;
      loop_ub = b->size[0];
      profileLoopStart("firls_loop_9", __LINE__, (loop_ub - 1) + 1, "");
      for (b_i = 0; b_i < loop_ub; b_i++) {
        b0->data[b_i + 1] = b->data[b_i];
      }
      profileLoopEnd();
      b_i = b->size[0];
      b->size[0] = b0->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b, b_i, &rf_emlrtRTEI);
      profileLoopStart("firls_loop_12", __LINE__, (b0->size[0] - 1) + 1, "");
      for (b_i = 0; b_i < b0->size[0]; b_i++) {
        b->data[b_i] = b0->data[b_i];
      }
      profileLoopEnd();
    }
    if (a_outdatedOnGpu) {
      nvtxMarkA("#mldivide#" MW_AT_LINE);
      mldivide(G, b, cpu_a, &a_outdatedOnCpu, &gpu_a, &a_outdatedOnGpu);
    } else {
      b_i = cpu_a->size[0];
      cpu_a->size[0] = b->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_a, b_i, &of_emlrtRTEI);
      profileLoopStart("firls_loop_8", __LINE__, (b->size[0] - 1) + 1, "");
      for (b_i = 0; b_i < b->size[0]; b_i++) {
        cpu_a->data[b_i] = 4.0 * b->data[b_i];
      }
      profileLoopEnd();
      if (Nodd) {
        cpu_a->data[0] /= 2.0;
      }
    }
    if (Nodd) {
      if (L + 1.0 < 2.0) {
        md2 = 0;
        nx = 1;
        i = -1;
        nG = 0;
        i1Start = 0;
      } else {
        md2 = static_cast<int32_T>(L + 1.0) - 1;
        nx = -1;
        i = 1;
        nG = 1;
        i1Start = static_cast<int32_T>(L + 1.0);
      }
      b_i = h->size[0] * h->size[1];
      h->size[0] = 1;
      nvtxMarkA("#div_s32#" MW_AT_LINE);
      h->size[1] = ((div_s32(i - md2, nx) + i1Start) - nG) + 2;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(h, b_i, &sf_emlrtRTEI);
      nvtxMarkA("#div_s32#" MW_AT_LINE);
      loop_ub = div_s32(i - md2, nx);
      profileLoopStart("firls_loop_15", __LINE__, loop_ub + 1, "");
      for (b_i = 0; b_i <= loop_ub; b_i++) {
        if (a_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_a, &gpu_a);
        }
        a_outdatedOnCpu = false;
        h->data[b_i] = cpu_a->data[md2 + nx * b_i] / 2.0;
      }
      profileLoopEnd();
      if (a_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_a, &gpu_a);
      }
      nvtxMarkA("#div_s32#" MW_AT_LINE);
      h->data[div_s32(i - md2, nx) + 1] = cpu_a->data[0];
      loop_ub = i1Start - nG;
      profileLoopStart("firls_loop_18", __LINE__, (loop_ub - 1) + 1, "");
      for (b_i = 0; b_i < loop_ub; b_i++) {
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        h->data[(b_i + div_s32(i - md2, nx)) + 2] = cpu_a->data[nG + b_i] / 2.0;
      }
      profileLoopEnd();
    } else {
      b_i = x->size[0];
      x->size[0] = cpu_a->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(x, b_i, &qf_emlrtRTEI);
      profileLoopStart("firls_loop_10", __LINE__, (cpu_a->size[0] - 1) + 1, "");
      for (b_i = 0; b_i < cpu_a->size[0]; b_i++) {
        if (a_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_a, &gpu_a);
        }
        a_outdatedOnCpu = false;
        x->data[b_i] = cpu_a->data[b_i];
      }
      profileLoopEnd();
      nx = cpu_a->size[0] - 1;
      md2 = cpu_a->size[0] >> 1;
      profileLoopStart("firls_loop_13", __LINE__, (md2 - 1) + 1, "");
      for (i = 0; i < md2; i++) {
        max_freq = x->data[i];
        x->data[i] = x->data[nx - i];
        x->data[nx - i] = max_freq;
      }
      profileLoopEnd();
      b_i = h->size[0] * h->size[1];
      h->size[0] = 1;
      h->size[1] = x->size[0] + cpu_a->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(h, b_i, &tf_emlrtRTEI);
      loop_ub = x->size[0];
      profileLoopStart("firls_loop_17", __LINE__, (loop_ub - 1) + 1, "");
      for (b_i = 0; b_i < loop_ub; b_i++) {
        h->data[b_i] = 0.5 * x->data[b_i];
      }
      profileLoopEnd();
      loop_ub = cpu_a->size[0];
      profileLoopStart("firls_loop_19", __LINE__, (loop_ub - 1) + 1, "");
      for (b_i = 0; b_i < loop_ub; b_i++) {
        if (a_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_a, &gpu_a);
        }
        a_outdatedOnCpu = false;
        h->data[b_i + x->size[0]] = 0.5 * cpu_a->data[b_i];
      }
      profileLoopEnd();
    }
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b0);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_dv1);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&x);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_dv);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_a);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&sinc4A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&sinc3A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&sinc2A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&sinc1A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&G);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&k);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&m);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_a);
  nvtxRangePop();
}

} // namespace coder

// End of code generation (firls.cu)
