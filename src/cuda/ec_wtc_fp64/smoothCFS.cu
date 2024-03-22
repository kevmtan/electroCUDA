//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// smoothCFS.cu
//
// Code generation for function 'smoothCFS'
//

// Include files
#include "smoothCFS.h"
#include "ec_wtc_fp_data.h"
#include "ec_wtc_fp_emxutil.h"
#include "ec_wtc_fp_mexutil.h"
#include "ec_wtc_fp_types.h"
#include "ifft.h"
#include "mtimes.h"
#include "rt_nonfinite.h"
#include "MWCUFFTPlanManager.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "cufft.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo lg_emlrtRTEI{
    15,          // lineNo
    5,           // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo mg_emlrtRTEI{
    16,          // lineNo
    5,           // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo ng_emlrtRTEI{
    18,          // lineNo
    5,           // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo og_emlrtRTEI{
    25,          // lineNo
    1,           // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo pg_emlrtRTEI{
    30,          // lineNo
    27,          // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo qg_emlrtRTEI{
    47,          // lineNo
    28,          // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo rg_emlrtRTEI{
    47,          // lineNo
    9,           // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo sg_emlrtRTEI{
    58,          // lineNo
    1,           // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo tg_emlrtRTEI{
    53,          // lineNo
    7,           // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo ug_emlrtRTEI{
    30,          // lineNo
    5,           // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo vg_emlrtRTEI{
    45,          // lineNo
    9,           // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo wg_emlrtRTEI{
    47,          // lineNo
    23,          // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

static emlrtRTEInfo xg_emlrtRTEI{
    50,          // lineNo
    23,          // colNo
    "smoothCFS", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "smoothCFS.m" // pName
};

// Function Declarations
static void binary_expand_op_8(emxArray_creal_T *in1,
                               const emxArray_real_T *in2,
                               const emxArray_creal_T *in3);

static __global__ void smoothCFS_kernel142(const real_T d,
                                           const emxArray_int32_T omega_tmp1,
                                           const int32_T b_omega_tmp1,
                                           emxArray_real_T omega_tmp2);

static __global__ void smoothCFS_kernel143(emxArray_real_T omega);

static __global__ void smoothCFS_kernel144(const emxArray_real_T omega_tmp2,
                                           const int32_T b,
                                           emxArray_real_T omega);

static __global__ void
smoothCFS_kernel145(const int32_T offsetH, const int32_T midpoint,
                    const emxArray_real_T omega_tmp2, const int32_T N,
                    emxArray_real_T omega, int32_T omega_tmp2_dim1);

static __global__ void smoothCFS_kernel146(const int32_T cfs,
                                           emxArray_creal_T cfsDFT);

static __global__ void
smoothCFS_kernel147(const emxArray_real_T scales, const emxArray_real_T omega,
                    const int32_T b_scales, const int32_T b,
                    emxArray_real_T Fmat, int32_T Fmat_dim0);

static __global__ void smoothCFS_kernel148(const emxArray_creal_T cfsDFT,
                                           const emxArray_real_T Fmat,
                                           const int32_T b_Fmat,
                                           emxArray_creal_T c_Fmat);

static __global__ void smoothCFS_kernel149(const emxArray_creal_T r,
                                           const int32_T b_r,
                                           emxArray_real_T smooth);

static __global__ void smoothCFS_kernel150(const emxArray_real_T smooth,
                                           const int32_T b, emxArray_real_T a,
                                           int32_T smooth_dim0);

static __global__ void smoothCFS_kernel151(const int32_T a, emxArray_real_T c);

static __global__ void smoothCFS_kernel152(const emxArray_real_T c,
                                           const int32_T b_c,
                                           emxArray_real_T cfs,
                                           int32_T cfs_dim0);

static __global__ void smoothCFS_kernel153(const real_T npad,
                                           const emxArray_real_T a,
                                           emxArray_real_T c);

static __global__ void smoothCFS_kernel154(const int32_T a,
                                           emxArray_real_T expanded);

static __global__ void smoothCFS_kernel155(const emxArray_int32_T y,
                                           const int32_T b_y,
                                           emxArray_int32_T iv1);

static __global__ void smoothCFS_kernel156(const emxArray_real_T a,
                                           const emxArray_int32_T iv1,
                                           const int32_T b,
                                           emxArray_real_T expanded);

static __global__ void smoothCFS_kernel157(const real_T npad,
                                           const emxArray_real_T expanded,
                                           const int32_T b, emxArray_real_T c);

static __global__ void smoothCFS_kernel158(const int32_T smooth,
                                           const int32_T b_smooth,
                                           emxArray_real_T cfs,
                                           int32_T cfs_dim0);

static __global__ void smoothCFS_kernel159(const emxArray_real_T smooth,
                                           emxArray_real_T b_smooth);

static __global__ void smoothCFS_kernel160(const real_T npad, const int32_T b,
                                           real_T a_data[1]);

static __global__ void smoothCFS_kernel161(const int32_T smooth,
                                           emxArray_real_T expanded);

static __global__ void smoothCFS_kernel162(const int32_T offsetH,
                                           const emxArray_int32_T y,
                                           const int32_T b_y,
                                           emxArray_int32_T iv);

static __global__ void smoothCFS_kernel163(const emxArray_int32_T y,
                                           const int32_T b_y,
                                           emxArray_int32_T iv2);

static __global__ void
smoothCFS_kernel164(const emxArray_real_T smooth, const int32_T b_smooth,
                    const int32_T b, emxArray_real_T c_smooth,
                    int32_T smooth_dim0, int32_T b_smooth_dim0);

static __global__ void
smoothCFS_kernel165(const emxArray_real_T smooth, const int32_T smooth_dim0,
                    const emxArray_int32_T iv2, const emxArray_int32_T iv,
                    const int32_T b_smooth, const int32_T c_smooth,
                    emxArray_real_T expanded, int32_T expanded_dim0);

static __global__ void
smoothCFS_kernel166(const real_T npad, const emxArray_real_T expanded,
                    const emxArray_int32_T rows, const real_T ns,
                    const int32_T b, const int32_T c, emxArray_real_T cfs,
                    int32_T expanded_dim0, int32_T cfs_dim0);

static __global__ void smoothCFS_kernel167(const int32_T cfs,
                                           emxArray_creal_T cfsDFT);

static __global__ void smoothCFS_kernel168(const emxArray_real_T cfs,
                                           const int32_T b, const int32_T c,
                                           emxArray_creal_T cfsDFT,
                                           int32_T cfsDFT_dim0,
                                           int32_T cfs_dim0);

static __global__ void smoothCFS_kernel169(const emxArray_real_T cfs,
                                           const int32_T b_cfs,
                                           emxArray_creal_T cfsDFT);

static __global__ void smoothCFS_kernel170(const int32_T N,
                                           const int32_T midpoint,
                                           emxArray_creal_T cfsDFT);

static __global__ void smoothCFS_kernel171(const int32_T N,
                                           const int32_T cfsDFT,
                                           const int32_T midpoint,
                                           emxArray_creal_T b_cfsDFT,
                                           int32_T cfsDFT_dim0);

static __global__ void smoothCFS_kernel172(const int32_T b,
                                           emxArray_int32_T omega_tmp1);

static __global__ void smoothCFS_kernel173(const real_T cv_im,
                                           const emxArray_int32_T omega_tmp1,
                                           const int32_T b_omega_tmp1,
                                           emxArray_real_T omega_tmp2);

static __global__ void smoothCFS_kernel174(emxArray_real_T omega);

static __global__ void smoothCFS_kernel175(const emxArray_real_T omega_tmp2,
                                           const int32_T b,
                                           emxArray_real_T omega);

static __global__ void
smoothCFS_kernel176(const int32_T offsetH, const int32_T x,
                    const emxArray_real_T omega_tmp2, const int32_T ySize_idx_1,
                    emxArray_real_T omega, int32_T omega_tmp2_dim1);

static __global__ void smoothCFS_kernel177(const int32_T cfs,
                                           emxArray_creal_T cfsDFT);

static __global__ void
smoothCFS_kernel178(const emxArray_real_T scales, const emxArray_real_T omega,
                    const int32_T b_scales, const int32_T b,
                    emxArray_real_T Fmat, int32_T Fmat_dim0);

static __global__ void smoothCFS_kernel179(const emxArray_creal_T cfsDFT,
                                           const emxArray_real_T Fmat,
                                           const int32_T b_Fmat,
                                           emxArray_creal_T c_Fmat);

static __global__ void smoothCFS_kernel180(const emxArray_creal_T smooth,
                                           const int32_T b, emxArray_creal_T a,
                                           int32_T smooth_dim0);

static __global__ void smoothCFS_kernel181(const int32_T a, emxArray_creal_T c);

static __global__ void smoothCFS_kernel182(const emxArray_creal_T c,
                                           const int32_T b_c,
                                           emxArray_creal_T cfs,
                                           int32_T cfs_dim0);

static __global__ void smoothCFS_kernel183(const emxArray_creal_T a,
                                           const real_T b_a, real_T *d,
                                           real_T *d1);

static __global__ void smoothCFS_kernel184(const real_T *d1, const real_T *d,
                                           emxArray_creal_T c);

static __global__ void smoothCFS_kernel185(const int32_T a,
                                           emxArray_creal_T expanded);

static __global__ void smoothCFS_kernel186(const emxArray_int32_T y,
                                           const int32_T b_y,
                                           emxArray_int32_T iv1);

static __global__ void smoothCFS_kernel187(const emxArray_creal_T a,
                                           const emxArray_int32_T iv1,
                                           const int32_T b,
                                           emxArray_creal_T expanded);

static __global__ void smoothCFS_kernel188(const emxArray_creal_T expanded,
                                           const real_T a, const int32_T b,
                                           emxArray_creal_T c);

static __global__ void smoothCFS_kernel189(const int32_T smooth,
                                           const int32_T b_smooth,
                                           emxArray_creal_T cfs,
                                           int32_T cfs_dim0);

static __global__ void smoothCFS_kernel190(const real_T a, const int32_T b,
                                           creal_T a_data[1]);

static __global__ void smoothCFS_kernel191(const int32_T smooth,
                                           emxArray_creal_T expanded);

static __global__ void smoothCFS_kernel192(const int32_T offsetH,
                                           const emxArray_int32_T y,
                                           const int32_T b_y,
                                           emxArray_int32_T iv);

static __global__ void smoothCFS_kernel193(const emxArray_int32_T y,
                                           const int32_T b_y,
                                           emxArray_int32_T iv2);

static __global__ void
smoothCFS_kernel194(const emxArray_creal_T smooth, const int32_T b_smooth,
                    const int32_T b, emxArray_creal_T c_smooth,
                    int32_T smooth_dim0, int32_T b_smooth_dim0);

static __global__ void
smoothCFS_kernel195(const emxArray_creal_T smooth, const int32_T smooth_dim0,
                    const emxArray_int32_T iv2, const emxArray_int32_T iv,
                    const int32_T b_smooth, const int32_T c_smooth,
                    emxArray_creal_T expanded, int32_T expanded_dim0);

static __global__ void
smoothCFS_kernel196(const int32_T offsetH, const emxArray_creal_T expanded,
                    const int32_T k, const emxArray_int32_T rows,
                    const int32_T b_rows, emxArray_creal_T newIm,
                    int32_T expanded_dim0);

static __global__ void
smoothCFS_kernel197(const real_T npad, const int32_T offsetH, const int32_T k,
                    emxArray_creal_T cfs, int32_T cfs_dim0);

static __global__ void
smoothCFS_kernel198(const real_T cv_im, const int32_T offsetH, const int32_T k,
                    emxArray_creal_T cfs, int32_T cfs_dim0);

static __global__ void smoothCFS_kernel199(const int32_T cfs,
                                           emxArray_creal_T cfsDFT);

static __global__ void smoothCFS_kernel200(const emxArray_creal_T cfs,
                                           const int32_T b, const int32_T c,
                                           emxArray_creal_T cfsDFT,
                                           int32_T cfsDFT_dim0,
                                           int32_T cfs_dim0);

static __global__ void smoothCFS_kernel201(const emxArray_creal_T cfs,
                                           const int32_T b_cfs,
                                           emxArray_creal_T cfsDFT);

static __global__ void smoothCFS_kernel202(const int32_T b,
                                           emxArray_int32_T omega_tmp1);

// Function Definitions
static void binary_expand_op_8(emxArray_creal_T *in1,
                               const emxArray_real_T *in2,
                               const emxArray_creal_T *in3)
{
  emxArray_creal_T *b_in2;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_0_1;
  int32_T stride_1_0;
  int32_T stride_1_1;
  nvtxRangePushA("#fcn#binary_expand_op_8#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&b_in2, 2, &qg_emlrtRTEI, true);
  i = b_in2->size[0] * b_in2->size[1];
  if (in3->size[0] == 1) {
    b_in2->size[0] = in2->size[0];
  } else {
    b_in2->size[0] = in3->size[0];
  }
  if (in3->size[1] == 1) {
    b_in2->size[1] = in2->size[1];
  } else {
    b_in2->size[1] = in3->size[1];
  }
  nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
  emxEnsureCapacity_creal_T(b_in2, i, &qg_emlrtRTEI);
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
  profileLoopStart("binary_expand_op_8_loop_0", __LINE__, (b - 1) + 1, "");
  for (i = 0; i < b; i++) {
    int32_T c;
    if (in3->size[0] == 1) {
      c = in2->size[0];
    } else {
      c = in3->size[0];
    }
    profileLoopStart("binary_expand_op_8_loop_1", __LINE__, (c - 1) + 1, "");
    for (int32_T i1{0}; i1 < c; i1++) {
      b_in2->data[i1 + b_in2->size[0] * i].re =
          in2->data[i1 * stride_0_0 + in2->size[0] * aux_0_1] *
          in3->data[i1 * stride_1_0 + in3->size[0] * aux_1_1].re;
      b_in2->data[i1 + b_in2->size[0] * i].im =
          in2->data[i1 * stride_0_0 + in2->size[0] * aux_0_1] *
          in3->data[i1 * stride_1_0 + in3->size[0] * aux_1_1].im;
    }
    profileLoopEnd();
    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
  profileLoopEnd();
  nvtxMarkA("#ifft#" MW_AT_LINE);
  coder::ifft(b_in2, in1);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&b_in2);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel142(
    const real_T d, const emxArray_int32_T omega_tmp1,
    const int32_T b_omega_tmp1, emxArray_real_T omega_tmp2)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_omega_tmp1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    omega_tmp2.data[j] = static_cast<real_T>(omega_tmp1.data[j]) * d;
  }
}

static __global__
    __launch_bounds__(32, 1) void smoothCFS_kernel143(emxArray_real_T omega)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    omega.data[0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel144(
    const emxArray_real_T omega_tmp2, const int32_T b, emxArray_real_T omega)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    omega.data[j + 1] = omega_tmp2.data[j];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel145(
    const int32_T offsetH, const int32_T midpoint,
    const emxArray_real_T omega_tmp2, const int32_T N, emxArray_real_T omega,
    int32_T omega_tmp2_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(N);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    omega.data[(j + omega_tmp2_dim1) + 1] =
        -omega_tmp2.data[midpoint + offsetH * j];
  }
}

static __global__
    __launch_bounds__(1024, 1) void smoothCFS_kernel146(const int32_T cfs,
                                                        emxArray_creal_T cfsDFT)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(cfs);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    cfsDFT.data[j].re = 0.0;
    cfsDFT.data[j].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel147(
    const emxArray_real_T scales, const emxArray_real_T omega,
    const int32_T b_scales, const int32_T b, emxArray_real_T Fmat,
    int32_T Fmat_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b) + 1UL) *
                (static_cast<uint64_T>(b_scales) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T b_cv;
    int32_T i;
    int32_T j;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_scales) + 1UL));
    j = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(b_scales) + 1UL));
    b_cv = omega.data[j] * scales.data[i];
    Fmat.data[i + Fmat_dim0 * j] = exp(-0.5 * (b_cv * b_cv));
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel148(
    const emxArray_creal_T cfsDFT, const emxArray_real_T Fmat,
    const int32_T b_Fmat, emxArray_creal_T c_Fmat)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_Fmat);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    c_Fmat.data[j].re = Fmat.data[j] * cfsDFT.data[j].re;
    c_Fmat.data[j].im = Fmat.data[j] * cfsDFT.data[j].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel149(
    const emxArray_creal_T r, const int32_T b_r, emxArray_real_T smooth)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_r);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    smooth.data[j] = r.data[j].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel150(
    const emxArray_real_T smooth, const int32_T b, emxArray_real_T a,
    int32_T smooth_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    a.data[j] = smooth.data[smooth_dim0 * j];
  }
}

static __global__
    __launch_bounds__(1024, 1) void smoothCFS_kernel151(const int32_T a,
                                                        emxArray_real_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    c.data[j] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel152(
    const emxArray_real_T c, const int32_T b_c, emxArray_real_T cfs,
    int32_T cfs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    cfs.data[cfs_dim0 * j] = c.data[j];
  }
}

static __global__ __launch_bounds__(32, 1) void smoothCFS_kernel153(
    const real_T npad, const emxArray_real_T a, emxArray_real_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = a.data[0] * npad;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel154(
    const int32_T a, emxArray_real_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    expanded.data[j] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel155(
    const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    iv1.data[j] = y.data[j] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel156(
    const emxArray_real_T a, const emxArray_int32_T iv1, const int32_T b,
    emxArray_real_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    expanded.data[iv1.data[j]] = a.data[j];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel157(
    const real_T npad, const emxArray_real_T expanded, const int32_T b,
    emxArray_real_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    c.data[orow] = expanded.data[orow] * npad;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel158(
    const int32_T smooth, const int32_T b_smooth, emxArray_real_T cfs,
    int32_T cfs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_smooth) + 1UL) *
                (static_cast<uint64_T>(smooth) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T j;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(smooth) + 1UL));
    j = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(smooth) + 1UL));
    cfs.data[i + cfs_dim0 * j] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void smoothCFS_kernel159(
    const emxArray_real_T smooth, emxArray_real_T b_smooth)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    b_smooth.data[0] = smooth.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel160(
    const real_T npad, const int32_T b, real_T a_data[1])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    a_data[j] = npad;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel161(
    const int32_T smooth, emxArray_real_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(smooth);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    expanded.data[j] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel162(
    const int32_T offsetH, const emxArray_int32_T y, const int32_T b_y,
    emxArray_int32_T iv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    int32_T q1;
    j = static_cast<int32_T>(idx);
    q1 = y.data[j];
    if ((offsetH < 0) && (q1 < MIN_int32_T - offsetH)) {
      q1 = MIN_int32_T;
    } else if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv.data[j] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel163(
    const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv2)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    iv2.data[j] = y.data[j] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel164(
    const emxArray_real_T smooth, const int32_T b_smooth, const int32_T b,
    emxArray_real_T c_smooth, int32_T smooth_dim0, int32_T b_smooth_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b) + 1UL) *
                (static_cast<uint64_T>(b_smooth) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T j;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_smooth) + 1UL));
    j = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(b_smooth) + 1UL));
    c_smooth.data[i + smooth_dim0 * j] = smooth.data[i + b_smooth_dim0 * j];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel165(
    const emxArray_real_T smooth, const int32_T smooth_dim0,
    const emxArray_int32_T iv2, const emxArray_int32_T iv,
    const int32_T b_smooth, const int32_T c_smooth, emxArray_real_T expanded,
    int32_T expanded_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_smooth) + 1UL) *
                (static_cast<uint64_T>(b_smooth) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T j;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_smooth) + 1UL));
    j = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(b_smooth) + 1UL));
    expanded.data[iv.data[i] + expanded_dim0 * iv2.data[j]] =
        smooth.data[i + smooth_dim0 * j];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel166(
    const real_T npad, const emxArray_real_T expanded,
    const emxArray_int32_T rows, const real_T ns, const int32_T b,
    const int32_T c, emxArray_real_T cfs, int32_T expanded_dim0,
    int32_T cfs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T b_cv;
    int32_T i;
    int32_T j;
    int32_T orow;
    orow = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
                             (static_cast<uint64_T>(b) + 1UL));
    b_cv = 0.0;
    j = static_cast<int32_T>(ns);
    for (int32_T m{0}; m < j; m++) {
      int32_T q1;
      q1 = rows.data[m];
      if (q1 > 2147483646 - orow) {
        q1 = MAX_int32_T;
      } else {
        q1 = (orow + q1) + 1;
      }
      b_cv += expanded.data[(q1 + expanded_dim0 * i) - 1] * npad;
    }
    cfs.data[orow + cfs_dim0 * i] = b_cv;
  }
}

static __global__
    __launch_bounds__(1024, 1) void smoothCFS_kernel167(const int32_T cfs,
                                                        emxArray_creal_T cfsDFT)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(cfs);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    cfsDFT.data[j].re = 0.0;
    cfsDFT.data[j].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel168(
    const emxArray_real_T cfs, const int32_T b, const int32_T c,
    emxArray_creal_T cfsDFT, int32_T cfsDFT_dim0, int32_T cfs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T j;
    j = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(j)) /
                             (static_cast<uint64_T>(b) + 1UL));
    cfsDFT.data[j + cfsDFT_dim0 * i].re = cfs.data[j + cfs_dim0 * i];
    cfsDFT.data[j + cfsDFT_dim0 * i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel169(
    const emxArray_real_T cfs, const int32_T b_cfs, emxArray_creal_T cfsDFT)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfs);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    cfsDFT.data[j].re = cfs.data[j];
    cfsDFT.data[j].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel170(
    const int32_T N, const int32_T midpoint, emxArray_creal_T cfsDFT)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(midpoint);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    cfsDFT.data[(N - i) - 1].re = cfsDFT.data[i + 1].re;
    cfsDFT.data[(N - i) - 1].im = -cfsDFT.data[i + 1].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel171(
    const int32_T N, const int32_T cfsDFT, const int32_T midpoint,
    emxArray_creal_T b_cfsDFT, int32_T cfsDFT_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(midpoint) + 1UL) *
                (static_cast<uint64_T>(cfsDFT) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T j;
    j = static_cast<int32_T>(idx % (static_cast<uint64_T>(cfsDFT) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(j)) /
                             (static_cast<uint64_T>(cfsDFT) + 1UL));
    b_cfsDFT.data[j + cfsDFT_dim0 * ((N - i) - 1)].re =
        b_cfsDFT.data[j + cfsDFT_dim0 * (i + 1)].re;
    b_cfsDFT.data[j + cfsDFT_dim0 * ((N - i) - 1)].im =
        -b_cfsDFT.data[j + cfsDFT_dim0 * (i + 1)].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel172(
    const int32_T b, emxArray_int32_T omega_tmp1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j;
    j = static_cast<int32_T>(idx);
    omega_tmp1.data[j] = j + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel173(
    const real_T cv_im, const emxArray_int32_T omega_tmp1,
    const int32_T b_omega_tmp1, emxArray_real_T omega_tmp2)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_omega_tmp1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    omega_tmp2.data[b] = static_cast<real_T>(omega_tmp1.data[b]) * cv_im;
  }
}

static __global__
    __launch_bounds__(32, 1) void smoothCFS_kernel174(emxArray_real_T omega)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    omega.data[0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel175(
    const emxArray_real_T omega_tmp2, const int32_T b, emxArray_real_T omega)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_b;
    b_b = static_cast<int32_T>(idx);
    omega.data[b_b + 1] = omega_tmp2.data[b_b];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel176(
    const int32_T offsetH, const int32_T x, const emxArray_real_T omega_tmp2,
    const int32_T ySize_idx_1, emxArray_real_T omega, int32_T omega_tmp2_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ySize_idx_1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    omega.data[(b + omega_tmp2_dim1) + 1] = -omega_tmp2.data[x + offsetH * b];
  }
}

static __global__
    __launch_bounds__(1024, 1) void smoothCFS_kernel177(const int32_T cfs,
                                                        emxArray_creal_T cfsDFT)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(cfs);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    cfsDFT.data[b].re = 0.0;
    cfsDFT.data[b].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel178(
    const emxArray_real_T scales, const emxArray_real_T omega,
    const int32_T b_scales, const int32_T b, emxArray_real_T Fmat,
    int32_T Fmat_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b) + 1UL) *
                (static_cast<uint64_T>(b_scales) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T b_a;
    int32_T a;
    int32_T b_b;
    b_b = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_scales) + 1UL));
    a = static_cast<int32_T>((idx - static_cast<uint64_T>(b_b)) /
                             (static_cast<uint64_T>(b_scales) + 1UL));
    b_a = omega.data[a] * scales.data[b_b];
    Fmat.data[b_b + Fmat_dim0 * a] = exp(-0.5 * (b_a * b_a));
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel179(
    const emxArray_creal_T cfsDFT, const emxArray_real_T Fmat,
    const int32_T b_Fmat, emxArray_creal_T c_Fmat)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_Fmat);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    c_Fmat.data[b].re = Fmat.data[b] * cfsDFT.data[b].re;
    c_Fmat.data[b].im = Fmat.data[b] * cfsDFT.data[b].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel180(
    const emxArray_creal_T smooth, const int32_T b, emxArray_creal_T a,
    int32_T smooth_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_b;
    b_b = static_cast<int32_T>(idx);
    a.data[b_b] = smooth.data[smooth_dim0 * b_b];
  }
}

static __global__
    __launch_bounds__(1024, 1) void smoothCFS_kernel181(const int32_T a,
                                                        emxArray_creal_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    c.data[b].re = 0.0;
    c.data[b].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel182(
    const emxArray_creal_T c, const int32_T b_c, emxArray_creal_T cfs,
    int32_T cfs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    cfs.data[cfs_dim0 * b] = c.data[b];
  }
}

static __global__ __launch_bounds__(32, 1) void smoothCFS_kernel183(
    const emxArray_creal_T a, const real_T b_a, real_T *d, real_T *d1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *d1 = b_a * a.data[0].re;
    *d = b_a * a.data[0].im;
  }
}

static __global__ __launch_bounds__(32, 1) void smoothCFS_kernel184(
    const real_T *d1, const real_T *d, emxArray_creal_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0].im = *d;
    c.data[0].re = *d1;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel185(
    const int32_T a, emxArray_creal_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    expanded.data[b].re = 0.0;
    expanded.data[b].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel186(
    const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    iv1.data[b] = y.data[b] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel187(
    const emxArray_creal_T a, const emxArray_int32_T iv1, const int32_T b,
    emxArray_creal_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_b;
    b_b = static_cast<int32_T>(idx);
    expanded.data[iv1.data[b_b]] = a.data[b_b];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel188(
    const emxArray_creal_T expanded, const real_T a, const int32_T b,
    emxArray_creal_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_a;
    b_a = static_cast<int32_T>(idx);
    c.data[b_a].re = a * expanded.data[b_a].re;
    c.data[b_a].im = a * expanded.data[b_a].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel189(
    const int32_T smooth, const int32_T b_smooth, emxArray_creal_T cfs,
    int32_T cfs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_smooth) + 1UL) *
                (static_cast<uint64_T>(smooth) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T a;
    int32_T b;
    a = static_cast<int32_T>(idx % (static_cast<uint64_T>(smooth) + 1UL));
    b = static_cast<int32_T>((idx - static_cast<uint64_T>(a)) /
                             (static_cast<uint64_T>(smooth) + 1UL));
    cfs.data[a + cfs_dim0 * b].re = 0.0;
    cfs.data[a + cfs_dim0 * b].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel190(
    const real_T a, const int32_T b, creal_T a_data[1])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_b;
    b_b = static_cast<int32_T>(idx);
    a_data[b_b].re = a;
    a_data[b_b].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel191(
    const int32_T smooth, emxArray_creal_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(smooth);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    expanded.data[b].re = 0.0;
    expanded.data[b].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel192(
    const int32_T offsetH, const emxArray_int32_T y, const int32_T b_y,
    emxArray_int32_T iv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T a;
    int32_T b;
    b = static_cast<int32_T>(idx);
    a = y.data[b];
    if ((offsetH < 0) && (a < MIN_int32_T - offsetH)) {
      a = MIN_int32_T;
    } else if ((offsetH > 0) && (a > MAX_int32_T - offsetH)) {
      a = MAX_int32_T;
    } else {
      a += offsetH;
    }
    iv.data[b] = a - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel193(
    const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv2)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    iv2.data[b] = y.data[b] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel194(
    const emxArray_creal_T smooth, const int32_T b_smooth, const int32_T b,
    emxArray_creal_T c_smooth, int32_T smooth_dim0, int32_T b_smooth_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b) + 1UL) *
                (static_cast<uint64_T>(b_smooth) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T a;
    int32_T b_b;
    a = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_smooth) + 1UL));
    b_b = static_cast<int32_T>((idx - static_cast<uint64_T>(a)) /
                               (static_cast<uint64_T>(b_smooth) + 1UL));
    c_smooth.data[a + smooth_dim0 * b_b] = smooth.data[a + b_smooth_dim0 * b_b];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel195(
    const emxArray_creal_T smooth, const int32_T smooth_dim0,
    const emxArray_int32_T iv2, const emxArray_int32_T iv,
    const int32_T b_smooth, const int32_T c_smooth, emxArray_creal_T expanded,
    int32_T expanded_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_smooth) + 1UL) *
                (static_cast<uint64_T>(b_smooth) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T a;
    int32_T b;
    a = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_smooth) + 1UL));
    b = static_cast<int32_T>((idx - static_cast<uint64_T>(a)) /
                             (static_cast<uint64_T>(b_smooth) + 1UL));
    expanded.data[iv.data[a] + expanded_dim0 * iv2.data[b]] =
        smooth.data[a + smooth_dim0 * b];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel196(
    const int32_T offsetH, const emxArray_creal_T expanded, const int32_T k,
    const emxArray_int32_T rows, const int32_T b_rows, emxArray_creal_T newIm,
    int32_T expanded_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_rows);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T a;
    int32_T b;
    b = static_cast<int32_T>(idx);
    a = rows.data[b];
    if (a > 2147483646 - k) {
      a = MAX_int32_T;
    } else {
      a = (k + a) + 1;
    }
    newIm.data[b] = expanded.data[(a + expanded_dim0 * offsetH) - 1];
  }
}

static __global__ __launch_bounds__(32, 1) void smoothCFS_kernel197(
    const real_T npad, const int32_T offsetH, const int32_T k,
    emxArray_creal_T cfs, int32_T cfs_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    cfs.data[k + cfs_dim0 * offsetH].re = npad;
  }
}

static __global__ __launch_bounds__(32, 1) void smoothCFS_kernel198(
    const real_T cv_im, const int32_T offsetH, const int32_T k,
    emxArray_creal_T cfs, int32_T cfs_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    cfs.data[k + cfs_dim0 * offsetH].im = cv_im;
  }
}

static __global__
    __launch_bounds__(1024, 1) void smoothCFS_kernel199(const int32_T cfs,
                                                        emxArray_creal_T cfsDFT)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(cfs);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    cfsDFT.data[b].re = 0.0;
    cfsDFT.data[b].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel200(
    const emxArray_creal_T cfs, const int32_T b, const int32_T c,
    emxArray_creal_T cfsDFT, int32_T cfsDFT_dim0, int32_T cfs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T a;
    int32_T b_b;
    b_b = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    a = static_cast<int32_T>((idx - static_cast<uint64_T>(b_b)) /
                             (static_cast<uint64_T>(b) + 1UL));
    cfsDFT.data[b_b + cfsDFT_dim0 * a] = cfs.data[b_b + cfs_dim0 * a];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel201(
    const emxArray_creal_T cfs, const int32_T b_cfs, emxArray_creal_T cfsDFT)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfs);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b;
    b = static_cast<int32_T>(idx);
    cfsDFT.data[b] = cfs.data[b];
  }
}

static __global__ __launch_bounds__(1024, 1) void smoothCFS_kernel202(
    const int32_T b, emxArray_int32_T omega_tmp1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_b;
    b_b = static_cast<int32_T>(idx);
    omega_tmp1.data[b_b] = b_b + 1;
  }
}

//
//
namespace coder {
namespace wavelet {
namespace internal {
namespace cwt {
void b_smoothCFS(emxArray_creal_T *cpu_cfs, boolean_T *cfs_outdatedOnCpu,
                 emxArray_creal_T *gpu_cfs, boolean_T *cfs_outdatedOnGpu,
                 emxArray_real_T *cpu_scales, emxArray_real_T *gpu_scales,
                 boolean_T *scales_outdatedOnGpu, real_T ns)
{
  dim3 block;
  dim3 grid;
  emxArray_creal_T b_gpu_Fmat;
  emxArray_creal_T b_gpu_expanded;
  emxArray_creal_T b_gpu_smooth;
  emxArray_creal_T gpu_a;
  emxArray_creal_T gpu_c;
  emxArray_creal_T gpu_cfsDFT;
  emxArray_creal_T gpu_expanded;
  emxArray_creal_T gpu_newIm;
  emxArray_creal_T gpu_smooth;
  emxArray_creal_T *b_cpu_Fmat;
  emxArray_creal_T *b_cpu_expanded;
  emxArray_creal_T *b_cpu_smooth;
  emxArray_creal_T *cpu_a;
  emxArray_creal_T *cpu_c;
  emxArray_creal_T *cpu_cfsDFT;
  emxArray_creal_T *cpu_expanded;
  emxArray_creal_T *cpu_newIm;
  emxArray_creal_T *cpu_smooth;
  emxArray_creal_T *smooth;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T c_gpu_y;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_iv2;
  emxArray_int32_T gpu_omega_tmp1;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *c_cpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv1;
  emxArray_int32_T *cpu_iv2;
  emxArray_int32_T *cpu_omega_tmp1;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  emxArray_real_T gpu_Fmat;
  emxArray_real_T gpu_omega;
  emxArray_real_T gpu_omega_tmp2;
  emxArray_real_T *cpu_Fmat;
  emxArray_real_T *cpu_omega;
  emxArray_real_T *cpu_omega_tmp2;
  creal_T(*gpu_a_data)[1];
  real_T a;
  real_T npad;
  real_T *gpu_d;
  real_T *gpu_d1;
  int32_T i;
  int32_T i2;
  int32_T offsetH;
  int32_T x;
  int32_T ySize_idx_1;
  boolean_T c_omega_tmp1_needsGpuEnsureCapa;
  boolean_T validLaunchParams;
  nvtxRangePushA("#fcn#b_smoothCFS#" MW_AT_LOCATION);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_d1, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_d, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_a_data, 16UL), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&b_gpu_smooth);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_newIm);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv2);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv1);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&b_gpu_expanded);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_c);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_a);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&b_gpu_Fmat);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_smooth);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_Fmat);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_cfsDFT);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_omega);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_omega_tmp2);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_omega_tmp1);
  c_omega_tmp1_needsGpuEnsureCapa = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  npad = std::frexp(static_cast<real_T>(cpu_cfs->size[1]), &ySize_idx_1);
  if (npad == 0.5) {
    ySize_idx_1--;
  }
  nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
  npad = rt_powd_snf(2.0, static_cast<real_T>(ySize_idx_1));
  ySize_idx_1 = static_cast<int32_T>(std::trunc(npad / 2.0));
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_omega_tmp1, 2, &lg_emlrtRTEI, true);
  if (ySize_idx_1 < 1) {
    cpu_omega_tmp1->size[0] = 1;
    cpu_omega_tmp1->size[1] = 0;
  } else {
    i = cpu_omega_tmp1->size[0] * cpu_omega_tmp1->size[1];
    cpu_omega_tmp1->size[0] = 1;
    cpu_omega_tmp1->size[1] = ySize_idx_1;
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_omega_tmp1, i, &lg_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(ySize_idx_1 - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_omega_tmp1, &gpu_omega_tmp1, true);
    c_omega_tmp1_needsGpuEnsureCapa = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel202#" MW_AT_LINE);
      smoothCFS_kernel202<<<grid, block>>>(ySize_idx_1 - 1, gpu_omega_tmp1);
    }
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_omega_tmp2, 2, &mg_emlrtRTEI, true);
  i = cpu_omega_tmp2->size[0] * cpu_omega_tmp2->size[1];
  cpu_omega_tmp2->size[0] = 1;
  cpu_omega_tmp2->size[1] = cpu_omega_tmp1->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_omega_tmp2, i, &mg_emlrtRTEI);
  i = cpu_omega_tmp1->size[1] - 1;
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
  if (c_omega_tmp1_needsGpuEnsureCapa) {
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_omega_tmp1, &gpu_omega_tmp1, true);
  }
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_omega_tmp2, &gpu_omega_tmp2, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#smoothCFS_kernel173#" MW_AT_LINE);
    smoothCFS_kernel173<<<grid, block>>>(6.2831853071795862 / npad,
                                         gpu_omega_tmp1, i, gpu_omega_tmp2);
  }
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_omega_tmp1);
  ySize_idx_1 = static_cast<int32_T>(std::trunc((npad - 1.0) / 2.0));
  if (ySize_idx_1 < 1) {
    x = 0;
    offsetH = 1;
    i2 = -1;
  } else {
    x = ySize_idx_1 - 1;
    offsetH = -1;
    i2 = 0;
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_omega, 2, &ng_emlrtRTEI, true);
  i = cpu_omega->size[0] * cpu_omega->size[1];
  cpu_omega->size[0] = 1;
  nvtxMarkA("#div_s32#" MW_AT_LINE);
  cpu_omega->size[1] = (cpu_omega_tmp2->size[1] + div_s32(i2 - x, offsetH)) + 2;
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_omega, i, &ng_emlrtRTEI);
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_omega, &gpu_omega, true);
  nvtxMarkA("#smoothCFS_kernel174#" MW_AT_LINE);
  smoothCFS_kernel174<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_omega);
  ySize_idx_1 = cpu_omega_tmp2->size[1];
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(ySize_idx_1 - 1), &grid, &block,
                          2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#smoothCFS_kernel175#" MW_AT_LINE);
    smoothCFS_kernel175<<<grid, block>>>(gpu_omega_tmp2, ySize_idx_1 - 1,
                                         gpu_omega);
  }
  nvtxMarkA("#div_s32#" MW_AT_LINE);
  ySize_idx_1 = div_s32(i2 - x, offsetH);
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(ySize_idx_1), &grid, &block,
                          2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#smoothCFS_kernel176#" MW_AT_LINE);
    smoothCFS_kernel176<<<grid, block>>>(offsetH, x, gpu_omega_tmp2,
                                         ySize_idx_1, gpu_omega,
                                         cpu_omega_tmp2->size[1U]);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_omega_tmp2);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_cfsDFT, 2, &og_emlrtRTEI, true);
  if ((cpu_cfs->size[0] == 0) || (cpu_cfs->size[1] == 0) ||
      (static_cast<int32_T>(npad) == 0)) {
    i = cpu_cfsDFT->size[0] * cpu_cfsDFT->size[1];
    cpu_cfsDFT->size[0] = cpu_cfs->size[0];
    cpu_cfsDFT->size[1] = static_cast<int32_T>(npad);
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_cfsDFT, i, &og_emlrtRTEI);
    i = cpu_cfs->size[0] * static_cast<int32_T>(npad) - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_cfsDFT, &gpu_cfsDFT, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel177#" MW_AT_LINE);
      smoothCFS_kernel177<<<grid, block>>>(i, gpu_cfsDFT);
    }
  } else if (cpu_cfs->size[1] != static_cast<int32_T>(npad)) {
    cufftHandle b_fftPlanHandle;
    if (cpu_cfs->size[1] < static_cast<int32_T>(npad)) {
      i = cpu_cfsDFT->size[0] * cpu_cfsDFT->size[1];
      cpu_cfsDFT->size[0] = cpu_cfs->size[0];
      cpu_cfsDFT->size[1] = static_cast<int32_T>(npad);
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_cfsDFT, i, &og_emlrtRTEI);
      i = cpu_cfs->size[0] * static_cast<int32_T>(npad) - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_cfsDFT, &gpu_cfsDFT, true);
      c_omega_tmp1_needsGpuEnsureCapa = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#smoothCFS_kernel199#" MW_AT_LINE);
        smoothCFS_kernel199<<<grid, block>>>(i, gpu_cfsDFT);
      }
    } else {
      i = cpu_cfsDFT->size[0] * cpu_cfsDFT->size[1];
      cpu_cfsDFT->size[0] = cpu_cfs->size[0];
      cpu_cfsDFT->size[1] = static_cast<int32_T>(npad);
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_cfsDFT, i, &ud_emlrtRTEI);
      c_omega_tmp1_needsGpuEnsureCapa = true;
    }
    ySize_idx_1 = cpu_cfs->size[0];
    if (cpu_cfs->size[1] > static_cast<int32_T>(npad)) {
      x = static_cast<int32_T>(npad);
    } else {
      x = cpu_cfs->size[1];
    }
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(x - 1, ySize_idx_1 - 1), &grid,
                            &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_cfs, gpu_cfs, !*cfs_outdatedOnGpu);
    if (c_omega_tmp1_needsGpuEnsureCapa) {
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_cfsDFT, &gpu_cfsDFT, true);
    }
    if (*cfs_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(gpu_cfs, cpu_cfs);
    }
    *cfs_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel200#" MW_AT_LINE);
      smoothCFS_kernel200<<<grid, block>>>(*gpu_cfs, ySize_idx_1 - 1, x - 1,
                                           gpu_cfsDFT, cpu_cfsDFT->size[0U],
                                           cpu_cfs->size[0U]);
    }
    ySize_idx_1 = cpu_cfsDFT->size[1];
    b_fftPlanHandle =
        acquireCUFFTPlan(1, &ySize_idx_1, &ySize_idx_1, cpu_cfsDFT->size[0], 1,
                         CUFFT_Z2Z, cpu_cfsDFT->size[0]);
    cufftExecZ2Z(b_fftPlanHandle, (cufftDoubleComplex *)&gpu_cfsDFT.data[0],
                 (cufftDoubleComplex *)&gpu_cfsDFT.data[0], CUFFT_FORWARD);
  } else {
    cufftHandle fftPlanHandle;
    ySize_idx_1 = cpu_cfs->size[1];
    fftPlanHandle =
        acquireCUFFTPlan(1, &ySize_idx_1, &ySize_idx_1, cpu_cfs->size[0], 1,
                         CUFFT_Z2Z, cpu_cfs->size[0]);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_cfs, gpu_cfs, !*cfs_outdatedOnGpu);
    if (*cfs_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(gpu_cfs, cpu_cfs);
    }
    cufftExecZ2Z(fftPlanHandle, (cufftDoubleComplex *)&gpu_cfs->data[0],
                 (cufftDoubleComplex *)&gpu_cfs->data[0], CUFFT_FORWARD);
    i = cpu_cfsDFT->size[0] * cpu_cfsDFT->size[1];
    cpu_cfsDFT->size[0] = cpu_cfs->size[0];
    cpu_cfsDFT->size[1] = cpu_cfs->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_cfsDFT, i, &og_emlrtRTEI);
    i = cpu_cfs->size[0] * cpu_cfs->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_cfsDFT, &gpu_cfsDFT, true);
    *cfs_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel201#" MW_AT_LINE);
      smoothCFS_kernel201<<<grid, block>>>(*gpu_cfs, i, gpu_cfsDFT);
    }
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_Fmat, 2, &ug_emlrtRTEI, true);
  i = cpu_Fmat->size[0] * cpu_Fmat->size[1];
  cpu_Fmat->size[0] = cpu_scales->size[1];
  cpu_Fmat->size[1] = cpu_omega->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_Fmat, i, &pg_emlrtRTEI);
  ySize_idx_1 = cpu_omega->size[1];
  i = cpu_scales->size[1] - 1;
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(ySize_idx_1 - 1, i), &grid, &block,
                          2147483647U);
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_scales, gpu_scales, !*scales_outdatedOnGpu);
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_Fmat, &gpu_Fmat, true);
  if (*scales_outdatedOnGpu) {
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real_T(gpu_scales, cpu_scales);
  }
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#smoothCFS_kernel178#" MW_AT_LINE);
    smoothCFS_kernel178<<<grid, block>>>(*gpu_scales, gpu_omega, i,
                                         ySize_idx_1 - 1, gpu_Fmat,
                                         cpu_Fmat->size[0U]);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_omega);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_smooth, 2, &vg_emlrtRTEI, true);
  if ((cpu_Fmat->size[0] == cpu_cfsDFT->size[0]) &&
      (cpu_Fmat->size[1] == cpu_cfsDFT->size[1])) {
    nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
    emxInit_creal_T(&b_cpu_Fmat, 2, &xg_emlrtRTEI, true);
    i = b_cpu_Fmat->size[0] * b_cpu_Fmat->size[1];
    b_cpu_Fmat->size[0] = cpu_Fmat->size[0];
    b_cpu_Fmat->size[1] = cpu_Fmat->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(b_cpu_Fmat, i, &xg_emlrtRTEI);
    i = cpu_Fmat->size[0] * cpu_Fmat->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(b_cpu_Fmat, &b_gpu_Fmat, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel179#" MW_AT_LINE);
      smoothCFS_kernel179<<<grid, block>>>(gpu_cfsDFT, gpu_Fmat, i, b_gpu_Fmat);
    }
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_creal_T(b_cpu_Fmat, &b_gpu_Fmat);
    nvtxMarkA("#ifft#" MW_AT_LINE);
    ifft(b_cpu_Fmat, cpu_smooth);
    nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
    emxFree_creal_T(&b_cpu_Fmat);
  } else {
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real_T(cpu_Fmat, &gpu_Fmat);
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_creal_T(cpu_cfsDFT, &gpu_cfsDFT);
    nvtxMarkA("#binary_expand_op_8#" MW_AT_LINE);
    binary_expand_op_8(cpu_smooth, cpu_Fmat, cpu_cfsDFT);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_Fmat);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_cfsDFT);
  i2 = cpu_cfs->size[1];
  a = 1.0 / ns;
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_a, 1, &wf_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_c, 1, &eg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_expanded, 2, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&b_cpu_expanded, 1, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_y, 2, &fg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&b_cpu_y, 2, &fg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv, 1, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv1, 1, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&c_cpu_y, 2, &fg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv2, 1, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_rows, 2, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_newIm, 1, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&smooth, 1, &ig_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&b_cpu_smooth, 2, &tg_emlrtRTEI, true);
  if ((cpu_smooth->size[0] == 1) && (static_cast<int32_T>(ns) == 1)) {
    i = cpu_a->size[0];
    cpu_a->size[0] = i2;
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_a, i, &wf_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i2 - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_smooth, &gpu_smooth, false);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_a, &gpu_a, true);
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_smooth, cpu_smooth);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel180#" MW_AT_LINE);
      smoothCFS_kernel180<<<grid, block>>>(gpu_smooth, i2 - 1, gpu_a,
                                           cpu_smooth->size[0U]);
    }
    i = cpu_c->size[0];
    cpu_c->size[0] = cpu_a->size[0];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_c, i, &ag_emlrtRTEI);
    i = cpu_a->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_c, &gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel181#" MW_AT_LINE);
      smoothCFS_kernel181<<<grid, block>>>(i, gpu_c);
    }
    if (cpu_a->size[0] != 0) {
      if (cpu_a->size[0] == 1) {
        i = cpu_c->size[0];
        cpu_c->size[0] = 1;
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(cpu_c, i, &ag_emlrtRTEI);
        nvtxMarkA("#smoothCFS_kernel183#" MW_AT_LINE);
        smoothCFS_kernel183<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            gpu_a, a, gpu_d, gpu_d1);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_c, &gpu_c, true);
        nvtxMarkA("#smoothCFS_kernel184#" MW_AT_LINE);
        smoothCFS_kernel184<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            gpu_d1, gpu_d, gpu_c);
      } else {
        int32_T OH;
        int8_T threadDims_idx_0;
        x = static_cast<int32_T>(
            std::fmin(32.0, static_cast<real_T>(cpu_a->size[0])));
        offsetH = static_cast<int32_T>(std::floor(
            (static_cast<real_T>(static_cast<uint32_T>(cpu_a->size[0]) +
                                 static_cast<uint32_T>(x)) -
             1.0) /
            static_cast<real_T>(x)));
        threadDims_idx_0 = static_cast<int8_T>(x);
        OH = cpu_a->size[0];
        if (cpu_a->size[0] > 2147483646) {
          ySize_idx_1 = MAX_int32_T;
        } else {
          ySize_idx_1 = cpu_a->size[0] + 1;
        }
        i = b_cpu_expanded->size[0];
        b_cpu_expanded->size[0] = ySize_idx_1 - 1;
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(b_cpu_expanded, i, &cg_emlrtRTEI);
        i = cpu_a->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(b_cpu_expanded, &gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel185#" MW_AT_LINE);
          smoothCFS_kernel185<<<grid, block>>>(i, gpu_expanded);
        }
        x = cpu_a->size[0];
        i = b_cpu_y->size[0] * b_cpu_y->size[1];
        b_cpu_y->size[0] = 1;
        b_cpu_y->size[1] = cpu_a->size[0];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(b_cpu_y, i, &dg_emlrtRTEI);
        b_cpu_y->data[0] = 1;
        ySize_idx_1 = 1;
        profileLoopStart("b_smoothCFS_loop_1", __LINE__, (x - 2) + 1, "");
        for (int32_T k{0}; k <= x - 2; k++) {
          ySize_idx_1++;
          b_cpu_y->data[k + 1] = ySize_idx_1;
        }
        profileLoopEnd();
        i = cpu_iv1->size[0];
        cpu_iv1->size[0] = b_cpu_y->size[1];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_iv1, i, &cg_emlrtRTEI);
        i = b_cpu_y->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(b_cpu_y, &gpu_y, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, b_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel186#" MW_AT_LINE);
          smoothCFS_kernel186<<<grid, block>>>(gpu_y, i, gpu_iv1);
        }
        ySize_idx_1 = cpu_iv1->size[0];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(ySize_idx_1 - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel187#" MW_AT_LINE);
          smoothCFS_kernel187<<<grid, block>>>(gpu_a, gpu_iv1, ySize_idx_1 - 1,
                                               gpu_expanded);
        }
        i = cpu_c->size[0];
        cpu_c->size[0] = cpu_a->size[0];
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(cpu_c, i, &cg_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwApplyLaunchParameters(
            computeNumIters(OH - 1),
            dim3(static_cast<uint32_T>(offsetH), 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid,
            &block);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_c, &gpu_c, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel188#" MW_AT_LINE);
          smoothCFS_kernel188<<<grid, block>>>(gpu_expanded, a, OH - 1, gpu_c);
        }
      }
    }
    i = cpu_cfs->size[0] * cpu_cfs->size[1];
    cpu_cfs->size[0] = 1;
    cpu_cfs->size[1] = cpu_c->size[0];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_cfs, i, &sg_emlrtRTEI);
    i = cpu_c->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_cfs, gpu_cfs, !*cfs_outdatedOnGpu);
    if (*cfs_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(gpu_cfs, cpu_cfs);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel182#" MW_AT_LINE);
      smoothCFS_kernel182<<<grid, block>>>(gpu_c, i, *gpu_cfs,
                                           cpu_cfs->size[0U]);
    }
    *cfs_outdatedOnGpu = false;
    *cfs_outdatedOnCpu = true;
  } else {
    int32_T b_smooth[2];
    b_smooth[0] = cpu_smooth->size[0];
    i = cpu_cfs->size[0] * cpu_cfs->size[1];
    cpu_cfs->size[0] = cpu_smooth->size[0];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_cfs, i, &sg_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i2 - 1, b_smooth[0] - 1), &grid,
                            &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_cfs, gpu_cfs, !*cfs_outdatedOnGpu);
    if (*cfs_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(gpu_cfs, cpu_cfs);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel189#" MW_AT_LINE);
      smoothCFS_kernel189<<<grid, block>>>(b_smooth[0] - 1, i2 - 1, *gpu_cfs,
                                           cpu_cfs->size[0U]);
    }
    *cfs_outdatedOnGpu = false;
    *cfs_outdatedOnCpu = true;
    if ((cpu_smooth->size[0] != 0) && (i2 != 0) &&
        (static_cast<int32_T>(ns) != 0)) {
      if ((cpu_smooth->size[0] == 1) && (i2 == 1) &&
          (static_cast<int32_T>(ns) == 1)) {
        creal_T cpu_a_data[1];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(ns) - 1),
                                &grid, &block, 2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel190#" MW_AT_LINE);
          smoothCFS_kernel190<<<grid, block>>>(a, static_cast<int32_T>(ns) - 1,
                                               *gpu_a_data);
        }
        i = smooth->size[0];
        smooth->size[0] = 1;
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(smooth, i, &ig_emlrtRTEI);
        nvtxMarkA("#checkCudaError#" MW_AT_LINE);
        nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
        checkCudaError(
            cudaMemcpy(cpu_a_data, *gpu_a_data, 16UL, cudaMemcpyDeviceToHost),
            __FILE__, __LINE__);
        smooth->data[0].re = cpu_smooth->data[0].re * cpu_a_data[0].re -
                             cpu_smooth->data[0].im * cpu_a_data[0].im;
        smooth->data[0].im = cpu_smooth->data[0].re * cpu_a_data[0].im +
                             cpu_smooth->data[0].im * cpu_a_data[0].re;
        i = cpu_cfs->size[0] * cpu_cfs->size[1];
        cpu_cfs->size[0] = 1;
        cpu_cfs->size[1] = 1;
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(cpu_cfs, i, &sg_emlrtRTEI);
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_creal_T(cpu_cfs, gpu_cfs);
        cpu_cfs->data[0] = smooth->data[0];
        *cfs_outdatedOnCpu = false;
        *cfs_outdatedOnGpu = true;
      } else {
        int32_T OH;
        boolean_T cfs_needsGpuEnsureCapacity;
        boolean_T rows_needsGpuEnsureCapacity;
        OH = cpu_smooth->size[0];
        if (static_cast<int32_T>(ns) > MAX_int32_T - cpu_smooth->size[0]) {
          ySize_idx_1 = MAX_int32_T;
        } else {
          ySize_idx_1 = cpu_smooth->size[0] + static_cast<int32_T>(ns);
        }
        i = cpu_expanded->size[0] * cpu_expanded->size[1];
        cpu_expanded->size[0] = ySize_idx_1 - 1;
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(cpu_expanded, i, &cg_emlrtRTEI);
        if (i2 > 2147483646) {
          ySize_idx_1 = MAX_int32_T;
        } else {
          ySize_idx_1 = i2 + 1;
        }
        i = cpu_expanded->size[0] * cpu_expanded->size[1];
        cpu_expanded->size[1] = ySize_idx_1 - 1;
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(cpu_expanded, i, &cg_emlrtRTEI);
        i = ((cpu_smooth->size[0] + static_cast<int32_T>(ns)) - 1) * i2 - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_expanded, &b_gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel191#" MW_AT_LINE);
          smoothCFS_kernel191<<<grid, block>>>(i, b_gpu_expanded);
        }
        x = cpu_smooth->size[0];
        i = cpu_y->size[0] * cpu_y->size[1];
        cpu_y->size[0] = 1;
        cpu_y->size[1] = cpu_smooth->size[0];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_y, i, &dg_emlrtRTEI);
        cpu_y->data[0] = 1;
        ySize_idx_1 = 1;
        profileLoopStart("b_smoothCFS_loop_0", __LINE__, (x - 2) + 1, "");
        for (int32_T k{0}; k <= x - 2; k++) {
          ySize_idx_1++;
          cpu_y->data[k + 1] = ySize_idx_1;
        }
        profileLoopEnd();
        i = cpu_iv->size[0];
        cpu_iv->size[0] = cpu_y->size[1];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_iv, i, &cg_emlrtRTEI);
        i = cpu_y->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_y, &b_gpu_y, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel192#" MW_AT_LINE);
          smoothCFS_kernel192<<<grid, block>>>(
              static_cast<int32_T>(std::floor(
                  (static_cast<real_T>(static_cast<int32_T>(ns)) - 1.0) / 2.0)),
              b_gpu_y, i, gpu_iv);
        }
        i = c_cpu_y->size[0] * c_cpu_y->size[1];
        c_cpu_y->size[0] = 1;
        c_cpu_y->size[1] = i2;
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(c_cpu_y, i, &dg_emlrtRTEI);
        c_cpu_y->data[0] = 1;
        ySize_idx_1 = 1;
        profileLoopStart("b_smoothCFS_loop_2", __LINE__, (i2 - 2) + 1, "");
        for (int32_T k{0}; k <= i2 - 2; k++) {
          ySize_idx_1++;
          c_cpu_y->data[k + 1] = ySize_idx_1;
        }
        profileLoopEnd();
        i = cpu_iv2->size[0];
        cpu_iv2->size[0] = c_cpu_y->size[1];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_iv2, i, &cg_emlrtRTEI);
        i = c_cpu_y->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(c_cpu_y, &c_gpu_y, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_iv2, &gpu_iv2, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_y, c_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel193#" MW_AT_LINE);
          smoothCFS_kernel193<<<grid, block>>>(c_gpu_y, i, gpu_iv2);
        }
        i = b_cpu_smooth->size[0] * b_cpu_smooth->size[1];
        b_cpu_smooth->size[0] = cpu_smooth->size[0];
        b_cpu_smooth->size[1] = i2;
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(b_cpu_smooth, i, &tg_emlrtRTEI);
        i = cpu_smooth->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i2 - 1, i), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_smooth, &gpu_smooth, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(b_cpu_smooth, &b_gpu_smooth, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_smooth, cpu_smooth);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel194#" MW_AT_LINE);
          smoothCFS_kernel194<<<grid, block>>>(
              gpu_smooth, i, i2 - 1, b_gpu_smooth, b_cpu_smooth->size[0U],
              cpu_smooth->size[0U]);
        }
        b_smooth[0] = cpu_iv->size[0];
        b_smooth[1] = cpu_iv2->size[0];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(
            computeNumIters(b_smooth[1] - 1, b_smooth[0] - 1), &grid, &block,
            2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel195#" MW_AT_LINE);
          smoothCFS_kernel195<<<grid, block>>>(
              b_gpu_smooth, b_smooth[0], gpu_iv2, gpu_iv, b_smooth[0] - 1,
              b_smooth[1] - 1, b_gpu_expanded, cpu_expanded->size[0U]);
        }
        if (static_cast<int32_T>(ns) - 1 < 0) {
          x = 0;
        } else {
          x = static_cast<int32_T>(ns);
        }
        c_omega_tmp1_needsGpuEnsureCapa = false;
        i = cpu_rows->size[0] * cpu_rows->size[1];
        cpu_rows->size[0] = 1;
        cpu_rows->size[1] = x;
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_rows, i, &dg_emlrtRTEI);
        rows_needsGpuEnsureCapacity = true;
        if (x > 0) {
          cpu_rows->data[0] = 0;
          c_omega_tmp1_needsGpuEnsureCapa = true;
          ySize_idx_1 = 0;
          profileLoopStart("b_smoothCFS_loop_3", __LINE__, (x - 2) + 1, "");
          for (int32_T k{0}; k <= x - 2; k++) {
            ySize_idx_1++;
            cpu_rows->data[k + 1] = ySize_idx_1;
          }
          profileLoopEnd();
        }
        i = cpu_cfs->size[0] * cpu_cfs->size[1];
        cpu_cfs->size[0] = cpu_smooth->size[0];
        cpu_cfs->size[1] = i2;
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(cpu_cfs, i, &cg_emlrtRTEI);
        cfs_needsGpuEnsureCapacity = true;
        ySize_idx_1 = static_cast<int32_T>(ns);
        profileLoopStart("b_smoothCFS_loop_4", __LINE__, (i2 - 1) + 1, "");
        for (offsetH = 0; offsetH < i2; offsetH++) {
          profileLoopStart("b_smoothCFS_loop_5", __LINE__, (OH - 1) + 1, "");
          for (int32_T k{0}; k < OH; k++) {
            real_T cv_im;
            boolean_T newIm_outdatedOnCpu;
            i = cpu_newIm->size[0];
            cpu_newIm->size[0] = cpu_rows->size[1];
            nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
            emxEnsureCapacity_creal_T(cpu_newIm, i, &cg_emlrtRTEI);
            i = cpu_rows->size[1] - 1;
            nvtxMarkA("#computeNumIters#" MW_AT_LINE);
            mwGetLaunchParameters1D(computeNumIters(i), &grid, &block,
                                    2147483647U);
            if (rows_needsGpuEnsureCapacity) {
              nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
              gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows,
                                           !c_omega_tmp1_needsGpuEnsureCapa);
            }
            rows_needsGpuEnsureCapacity = false;
            nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
            gpuEmxEnsureCapacity_creal_T(cpu_newIm, &gpu_newIm, true);
            if (c_omega_tmp1_needsGpuEnsureCapa) {
              nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
            }
            c_omega_tmp1_needsGpuEnsureCapa = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              nvtxMarkA("#smoothCFS_kernel196#" MW_AT_LINE);
              smoothCFS_kernel196<<<grid, block>>>(offsetH, b_gpu_expanded, k,
                                                   gpu_rows, i, gpu_newIm,
                                                   cpu_expanded->size[0U]);
            }
            newIm_outdatedOnCpu = true;
            npad = 0.0;
            cv_im = 0.0;
            profileLoopStart("b_smoothCFS_loop_6", __LINE__,
                             (ySize_idx_1 - 1) + 1, "");
            for (x = 0; x < ySize_idx_1; x++) {
              if (newIm_outdatedOnCpu) {
                nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
                gpuEmxMemcpyGpuToCpu_creal_T(cpu_newIm, &gpu_newIm);
              }
              npad += cpu_newIm->data[x].re * a;
              newIm_outdatedOnCpu = false;
              cv_im += cpu_newIm->data[x].im * a;
            }
            profileLoopEnd();
            if (cfs_needsGpuEnsureCapacity) {
              nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
              gpuEmxEnsureCapacity_creal_T(cpu_cfs, gpu_cfs, true);
            }
            nvtxMarkA("#smoothCFS_kernel197#" MW_AT_LINE);
            smoothCFS_kernel197<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                npad, offsetH, k, *gpu_cfs, cpu_cfs->size[0U]);
            cfs_needsGpuEnsureCapacity = false;
            nvtxMarkA("#smoothCFS_kernel198#" MW_AT_LINE);
            smoothCFS_kernel198<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                cv_im, offsetH, k, *gpu_cfs, cpu_cfs->size[0U]);
          }
          profileLoopEnd();
        }
        profileLoopEnd();
      }
    }
  }
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&b_cpu_smooth);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&smooth);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_newIm);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_rows);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv2);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&c_cpu_y);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv1);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&b_cpu_y);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_y);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&b_cpu_expanded);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_expanded);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_c);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_a);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_smooth);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_omega_tmp1);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_omega_tmp2);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_omega);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_cfsDFT);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_Fmat);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_smooth);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&b_gpu_Fmat);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_a);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_c);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&b_gpu_expanded);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv1);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv2);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_newIm);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&b_gpu_smooth);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(*gpu_a_data), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_d), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_d1), __FILE__, __LINE__);
  *scales_outdatedOnGpu = false;
  nvtxRangePop();
}

//
//
void smoothCFS(emxArray_real_T *cpu_cfs, boolean_T *cfs_outdatedOnCpu,
               emxArray_real_T *gpu_cfs, boolean_T *cfs_outdatedOnGpu,
               emxArray_real_T *cpu_scales, emxArray_real_T *gpu_scales,
               boolean_T *scales_outdatedOnGpu, real_T ns)
{
  dim3 block;
  dim3 grid;
  emxArray_creal_T b_gpu_Fmat;
  emxArray_creal_T gpu_cfsDFT;
  emxArray_creal_T gpu_r;
  emxArray_creal_T *b_cpu_Fmat;
  emxArray_creal_T *cpu_cfsDFT;
  emxArray_creal_T *cpu_r;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T c_gpu_y;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_iv2;
  emxArray_int32_T gpu_omega_tmp1;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *c_cpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv1;
  emxArray_int32_T *cpu_iv2;
  emxArray_int32_T *cpu_omega_tmp1;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  emxArray_real_T b_gpu_c;
  emxArray_real_T b_gpu_expanded;
  emxArray_real_T b_gpu_smooth;
  emxArray_real_T c_gpu_smooth;
  emxArray_real_T gpu_Fmat;
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_c;
  emxArray_real_T gpu_expanded;
  emxArray_real_T gpu_omega;
  emxArray_real_T gpu_omega_tmp2;
  emxArray_real_T gpu_smooth;
  emxArray_real_T *b_cpu_c;
  emxArray_real_T *b_cpu_expanded;
  emxArray_real_T *b_cpu_smooth;
  emxArray_real_T *c_cpu_smooth;
  emxArray_real_T *cpu_Fmat;
  emxArray_real_T *cpu_a;
  emxArray_real_T *cpu_c;
  emxArray_real_T *cpu_expanded;
  emxArray_real_T *cpu_omega;
  emxArray_real_T *cpu_omega_tmp2;
  emxArray_real_T *cpu_smooth;
  real_T(*gpu_a_data)[1];
  real_T npad;
  int32_T N;
  int32_T i2;
  int32_T k;
  int32_T midpoint;
  int32_T offsetH;
  boolean_T c_omega_tmp1_needsGpuEnsureCapa;
  boolean_T c_outdatedOnCpu;
  boolean_T c_outdatedOnGpu;
  boolean_T validLaunchParams;
  nvtxRangePushA("#fcn#smoothCFS#" MW_AT_LOCATION);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_a_data, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_smooth);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_smooth);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv2);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv1);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_expanded);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_c);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_c);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_a);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_smooth);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&b_gpu_Fmat);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_r);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_Fmat);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_cfsDFT);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_omega);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_omega_tmp2);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_omega_tmp1);
  c_outdatedOnCpu = false;
  c_outdatedOnGpu = false;
  c_omega_tmp1_needsGpuEnsureCapa = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  npad = std::frexp(static_cast<real_T>(cpu_cfs->size[1]), &N);
  if (npad == 0.5) {
    N--;
  }
  nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
  npad = rt_powd_snf(2.0, static_cast<real_T>(N));
  N = static_cast<int32_T>(std::trunc(npad / 2.0));
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_omega_tmp1, 2, &lg_emlrtRTEI, true);
  if (N < 1) {
    cpu_omega_tmp1->size[0] = 1;
    cpu_omega_tmp1->size[1] = 0;
  } else {
    k = cpu_omega_tmp1->size[0] * cpu_omega_tmp1->size[1];
    cpu_omega_tmp1->size[0] = 1;
    cpu_omega_tmp1->size[1] = N;
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_omega_tmp1, k, &lg_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(N - 1), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_omega_tmp1, &gpu_omega_tmp1, true);
    c_omega_tmp1_needsGpuEnsureCapa = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel172#" MW_AT_LINE);
      smoothCFS_kernel172<<<grid, block>>>(N - 1, gpu_omega_tmp1);
    }
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_omega_tmp2, 2, &mg_emlrtRTEI, true);
  k = cpu_omega_tmp2->size[0] * cpu_omega_tmp2->size[1];
  cpu_omega_tmp2->size[0] = 1;
  cpu_omega_tmp2->size[1] = cpu_omega_tmp1->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_omega_tmp2, k, &mg_emlrtRTEI);
  k = cpu_omega_tmp1->size[1] - 1;
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
  if (c_omega_tmp1_needsGpuEnsureCapa) {
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_omega_tmp1, &gpu_omega_tmp1, true);
  }
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_omega_tmp2, &gpu_omega_tmp2, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#smoothCFS_kernel142#" MW_AT_LINE);
    smoothCFS_kernel142<<<grid, block>>>(6.2831853071795862 / npad,
                                         gpu_omega_tmp1, k, gpu_omega_tmp2);
  }
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_omega_tmp1);
  N = static_cast<int32_T>(std::trunc((npad - 1.0) / 2.0));
  if (N < 1) {
    midpoint = 0;
    offsetH = 1;
    i2 = -1;
  } else {
    midpoint = N - 1;
    offsetH = -1;
    i2 = 0;
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_omega, 2, &ng_emlrtRTEI, true);
  k = cpu_omega->size[0] * cpu_omega->size[1];
  cpu_omega->size[0] = 1;
  nvtxMarkA("#div_s32#" MW_AT_LINE);
  cpu_omega->size[1] =
      (cpu_omega_tmp2->size[1] + div_s32(i2 - midpoint, offsetH)) + 2;
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_omega, k, &ng_emlrtRTEI);
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_omega, &gpu_omega, true);
  nvtxMarkA("#smoothCFS_kernel143#" MW_AT_LINE);
  smoothCFS_kernel143<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_omega);
  N = cpu_omega_tmp2->size[1];
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(N - 1), &grid, &block, 2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#smoothCFS_kernel144#" MW_AT_LINE);
    smoothCFS_kernel144<<<grid, block>>>(gpu_omega_tmp2, N - 1, gpu_omega);
  }
  nvtxMarkA("#div_s32#" MW_AT_LINE);
  N = div_s32(i2 - midpoint, offsetH);
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(N), &grid, &block, 2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#smoothCFS_kernel145#" MW_AT_LINE);
    smoothCFS_kernel145<<<grid, block>>>(offsetH, midpoint, gpu_omega_tmp2, N,
                                         gpu_omega, cpu_omega_tmp2->size[1U]);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_omega_tmp2);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_cfsDFT, 2, &og_emlrtRTEI, true);
  if ((cpu_cfs->size[0] == 0) || (cpu_cfs->size[1] == 0) ||
      (static_cast<int32_T>(npad) == 0)) {
    k = cpu_cfsDFT->size[0] * cpu_cfsDFT->size[1];
    cpu_cfsDFT->size[0] = cpu_cfs->size[0];
    cpu_cfsDFT->size[1] = static_cast<int32_T>(npad);
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_cfsDFT, k, &og_emlrtRTEI);
    k = cpu_cfs->size[0] * static_cast<int32_T>(npad) - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_cfsDFT, &gpu_cfsDFT, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel146#" MW_AT_LINE);
      smoothCFS_kernel146<<<grid, block>>>(k, gpu_cfsDFT);
    }
  } else if (cpu_cfs->size[1] != static_cast<int32_T>(npad)) {
    cufftHandle c_fftPlanHandle;
    if (cpu_cfs->size[1] < static_cast<int32_T>(npad)) {
      k = cpu_cfsDFT->size[0] * cpu_cfsDFT->size[1];
      cpu_cfsDFT->size[0] = cpu_cfs->size[0];
      cpu_cfsDFT->size[1] = static_cast<int32_T>(npad);
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_cfsDFT, k, &og_emlrtRTEI);
      k = cpu_cfs->size[0] * static_cast<int32_T>(npad) - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_cfsDFT, &gpu_cfsDFT, true);
      c_omega_tmp1_needsGpuEnsureCapa = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#smoothCFS_kernel167#" MW_AT_LINE);
        smoothCFS_kernel167<<<grid, block>>>(k, gpu_cfsDFT);
      }
    } else {
      k = cpu_cfsDFT->size[0] * cpu_cfsDFT->size[1];
      cpu_cfsDFT->size[0] = cpu_cfs->size[0];
      cpu_cfsDFT->size[1] = static_cast<int32_T>(npad);
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_cfsDFT, k, &ud_emlrtRTEI);
      c_omega_tmp1_needsGpuEnsureCapa = true;
    }
    N = cpu_cfs->size[0];
    if (cpu_cfs->size[1] > static_cast<int32_T>(npad)) {
      midpoint = static_cast<int32_T>(npad);
    } else {
      midpoint = cpu_cfs->size[1];
    }
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(midpoint - 1, N - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_cfs, gpu_cfs, !*cfs_outdatedOnGpu);
    if (c_omega_tmp1_needsGpuEnsureCapa) {
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_cfsDFT, &gpu_cfsDFT, true);
    }
    if (*cfs_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_cfs, cpu_cfs);
    }
    *cfs_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel168#" MW_AT_LINE);
      smoothCFS_kernel168<<<grid, block>>>(*gpu_cfs, N - 1, midpoint - 1,
                                           gpu_cfsDFT, cpu_cfsDFT->size[0U],
                                           cpu_cfs->size[0U]);
    }
    N = cpu_cfsDFT->size[1];
    c_fftPlanHandle = acquireCUFFTPlan(1, &N, &N, cpu_cfsDFT->size[0], 1,
                                       CUFFT_Z2Z, cpu_cfsDFT->size[0]);
    cufftExecZ2Z(c_fftPlanHandle, (cufftDoubleComplex *)&gpu_cfsDFT.data[0],
                 (cufftDoubleComplex *)&gpu_cfsDFT.data[0], CUFFT_FORWARD);
  } else {
    midpoint = cpu_cfs->size[0] * cpu_cfs->size[1];
    if (midpoint -
            (static_cast<int32_T>(static_cast<uint32_T>(midpoint) >> 1) << 1) ==
        1) {
      cufftHandle fftPlanHandle;
      k = cpu_cfsDFT->size[0] * cpu_cfsDFT->size[1];
      cpu_cfsDFT->size[0] = cpu_cfs->size[0];
      cpu_cfsDFT->size[1] = cpu_cfs->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_cfsDFT, k, &og_emlrtRTEI);
      k = cpu_cfs->size[0] * cpu_cfs->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_cfs, gpu_cfs, !*cfs_outdatedOnGpu);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_cfsDFT, &gpu_cfsDFT, true);
      if (*cfs_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real_T(gpu_cfs, cpu_cfs);
      }
      *cfs_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#smoothCFS_kernel169#" MW_AT_LINE);
        smoothCFS_kernel169<<<grid, block>>>(*gpu_cfs, k, gpu_cfsDFT);
      }
      N = cpu_cfsDFT->size[1];
      fftPlanHandle = acquireCUFFTPlan(1, &N, &N, cpu_cfsDFT->size[0], 1,
                                       CUFFT_Z2Z, cpu_cfsDFT->size[0]);
      cufftExecZ2Z(fftPlanHandle, (cufftDoubleComplex *)&gpu_cfsDFT.data[0],
                   (cufftDoubleComplex *)&gpu_cfsDFT.data[0], CUFFT_FORWARD);
    } else {
      cufftHandle b_fftPlanHandle;
      uint32_T xSize[2];
      N = cpu_cfs->size[1];
      profileLoopStart("smoothCFS_loop_0", __LINE__, 1 + 1, "");
      for (k = 0; k < 2; k++) {
        xSize[k] = static_cast<uint32_T>(cpu_cfs->size[k]);
      }
      profileLoopEnd();
      k = cpu_cfsDFT->size[0] * cpu_cfsDFT->size[1];
      cpu_cfsDFT->size[0] = static_cast<int32_T>(xSize[0]);
      cpu_cfsDFT->size[1] = static_cast<int32_T>(xSize[1]);
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_cfsDFT, k, &ud_emlrtRTEI);
      b_fftPlanHandle = acquireCUFFTPlan(1, &N, &N, cpu_cfs->size[0], 1,
                                         CUFFT_D2Z, cpu_cfs->size[0]);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_cfs, gpu_cfs, !*cfs_outdatedOnGpu);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_cfsDFT, &gpu_cfsDFT, true);
      if (*cfs_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real_T(gpu_cfs, cpu_cfs);
      }
      *cfs_outdatedOnGpu = false;
      cufftExecD2Z(b_fftPlanHandle, (cufftDoubleReal *)&gpu_cfs->data[0],
                   (cufftDoubleComplex *)&gpu_cfsDFT.data[0]);
      midpoint =
          static_cast<int32_T>(
              static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) / 2.0) -
          2;
      if ((cpu_cfsDFT->size[0] == 1) || (cpu_cfsDFT->size[1] == 1)) {
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(midpoint), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel170#" MW_AT_LINE);
          smoothCFS_kernel170<<<grid, block>>>(static_cast<int32_T>(xSize[1]),
                                               midpoint, gpu_cfsDFT);
        }
      } else {
        k = cpu_cfsDFT->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(midpoint, k), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel171#" MW_AT_LINE);
          smoothCFS_kernel171<<<grid, block>>>(static_cast<int32_T>(xSize[1]),
                                               k, midpoint, gpu_cfsDFT,
                                               cpu_cfsDFT->size[0U]);
        }
      }
    }
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_Fmat, 2, &ug_emlrtRTEI, true);
  k = cpu_Fmat->size[0] * cpu_Fmat->size[1];
  cpu_Fmat->size[0] = cpu_scales->size[1];
  cpu_Fmat->size[1] = cpu_omega->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_Fmat, k, &pg_emlrtRTEI);
  N = cpu_omega->size[1];
  k = cpu_scales->size[1] - 1;
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(N - 1, k), &grid, &block,
                          2147483647U);
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_scales, gpu_scales, !*scales_outdatedOnGpu);
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_Fmat, &gpu_Fmat, true);
  if (*scales_outdatedOnGpu) {
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real_T(gpu_scales, cpu_scales);
  }
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#smoothCFS_kernel147#" MW_AT_LINE);
    smoothCFS_kernel147<<<grid, block>>>(*gpu_scales, gpu_omega, k, N - 1,
                                         gpu_Fmat, cpu_Fmat->size[0U]);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_omega);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_r, 2, &wg_emlrtRTEI, true);
  if ((cpu_Fmat->size[0] == cpu_cfsDFT->size[0]) &&
      (cpu_Fmat->size[1] == cpu_cfsDFT->size[1])) {
    nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
    emxInit_creal_T(&b_cpu_Fmat, 2, &qg_emlrtRTEI, true);
    k = b_cpu_Fmat->size[0] * b_cpu_Fmat->size[1];
    b_cpu_Fmat->size[0] = cpu_Fmat->size[0];
    b_cpu_Fmat->size[1] = cpu_Fmat->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(b_cpu_Fmat, k, &qg_emlrtRTEI);
    k = cpu_Fmat->size[0] * cpu_Fmat->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(b_cpu_Fmat, &b_gpu_Fmat, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel148#" MW_AT_LINE);
      smoothCFS_kernel148<<<grid, block>>>(gpu_cfsDFT, gpu_Fmat, k, b_gpu_Fmat);
    }
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_creal_T(b_cpu_Fmat, &b_gpu_Fmat);
    nvtxMarkA("#ifft#" MW_AT_LINE);
    ifft(b_cpu_Fmat, cpu_r);
    nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
    emxFree_creal_T(&b_cpu_Fmat);
  } else {
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real_T(cpu_Fmat, &gpu_Fmat);
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_creal_T(cpu_cfsDFT, &gpu_cfsDFT);
    nvtxMarkA("#binary_expand_op_8#" MW_AT_LINE);
    binary_expand_op_8(cpu_r, cpu_Fmat, cpu_cfsDFT);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_Fmat);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_cfsDFT);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_smooth, 2, &vg_emlrtRTEI, true);
  k = cpu_smooth->size[0] * cpu_smooth->size[1];
  cpu_smooth->size[0] = cpu_r->size[0];
  cpu_smooth->size[1] = cpu_r->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_smooth, k, &rg_emlrtRTEI);
  k = cpu_r->size[0] * cpu_r->size[1] - 1;
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
  nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_creal_T(cpu_r, &gpu_r, false);
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_smooth, &gpu_smooth, true);
  nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_r, cpu_r);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#smoothCFS_kernel149#" MW_AT_LINE);
    smoothCFS_kernel149<<<grid, block>>>(gpu_r, k, gpu_smooth);
  }
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_r);
  i2 = cpu_cfs->size[1];
  npad = 1.0 / ns;
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_a, 1, &wf_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_c, 1, &gg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_c, 1, &eg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_expanded, 2, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_expanded, 1, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_y, 2, &fg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&b_cpu_y, 2, &fg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv, 1, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv1, 1, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&c_cpu_y, 2, &fg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv2, 1, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_rows, 2, &cg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_smooth, 2, &tg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_smooth, 2, &tg_emlrtRTEI, true);
  if ((cpu_smooth->size[0] == 1) && (static_cast<int32_T>(ns) == 1)) {
    k = cpu_a->size[0];
    cpu_a->size[0] = i2;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_a, k, &wf_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i2 - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_a, &gpu_a, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel150#" MW_AT_LINE);
      smoothCFS_kernel150<<<grid, block>>>(gpu_smooth, i2 - 1, gpu_a,
                                           cpu_smooth->size[0U]);
    }
    k = b_cpu_c->size[0];
    b_cpu_c->size[0] = cpu_a->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(b_cpu_c, k, &ag_emlrtRTEI);
    k = cpu_a->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(b_cpu_c, &gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel151#" MW_AT_LINE);
      smoothCFS_kernel151<<<grid, block>>>(k, gpu_c);
    }
    if (cpu_a->size[0] != 0) {
      if (cpu_a->size[0] == 1) {
        k = b_cpu_c->size[0];
        b_cpu_c->size[0] = 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_cpu_c, k, &ag_emlrtRTEI);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(b_cpu_c, &gpu_c, true);
        nvtxMarkA("#smoothCFS_kernel153#" MW_AT_LINE);
        smoothCFS_kernel153<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            npad, gpu_a, gpu_c);
      } else {
        int32_T OH;
        int8_T threadDims[3];
        midpoint = static_cast<int32_T>(
            std::fmin(32.0, static_cast<real_T>(cpu_a->size[0])));
        offsetH = static_cast<int32_T>(std::floor(
            (static_cast<real_T>(static_cast<uint32_T>(cpu_a->size[0]) +
                                 static_cast<uint32_T>(midpoint)) -
             1.0) /
            static_cast<real_T>(midpoint)));
        threadDims[0] = static_cast<int8_T>(midpoint);
        OH = cpu_a->size[0];
        if (cpu_a->size[0] > 2147483646) {
          N = MAX_int32_T;
        } else {
          N = cpu_a->size[0] + 1;
        }
        k = b_cpu_expanded->size[0];
        b_cpu_expanded->size[0] = N - 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_cpu_expanded, k, &cg_emlrtRTEI);
        k = cpu_a->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(b_cpu_expanded, &gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel154#" MW_AT_LINE);
          smoothCFS_kernel154<<<grid, block>>>(k, gpu_expanded);
        }
        midpoint = cpu_a->size[0];
        k = b_cpu_y->size[0] * b_cpu_y->size[1];
        b_cpu_y->size[0] = 1;
        b_cpu_y->size[1] = cpu_a->size[0];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(b_cpu_y, k, &dg_emlrtRTEI);
        b_cpu_y->data[0] = 1;
        N = 1;
        profileLoopStart("smoothCFS_loop_1", __LINE__, (midpoint - 2) + 1, "");
        for (k = 0; k <= midpoint - 2; k++) {
          N++;
          b_cpu_y->data[k + 1] = N;
        }
        profileLoopEnd();
        k = cpu_iv1->size[0];
        cpu_iv1->size[0] = b_cpu_y->size[1];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_iv1, k, &cg_emlrtRTEI);
        k = b_cpu_y->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(b_cpu_y, &gpu_y, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, b_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel155#" MW_AT_LINE);
          smoothCFS_kernel155<<<grid, block>>>(gpu_y, k, gpu_iv1);
        }
        N = cpu_iv1->size[0];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(N - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel156#" MW_AT_LINE);
          smoothCFS_kernel156<<<grid, block>>>(gpu_a, gpu_iv1, N - 1,
                                               gpu_expanded);
        }
        k = b_cpu_c->size[0];
        b_cpu_c->size[0] = cpu_a->size[0];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_cpu_c, k, &cg_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwApplyLaunchParameters(
            computeNumIters(OH - 1),
            dim3(static_cast<uint32_T>(offsetH), 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims[0]), 1U, 1U), &grid, &block);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(b_cpu_c, &gpu_c, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel157#" MW_AT_LINE);
          smoothCFS_kernel157<<<grid, block>>>(npad, gpu_expanded, OH - 1,
                                               gpu_c);
        }
      }
    }
    k = cpu_cfs->size[0] * cpu_cfs->size[1];
    cpu_cfs->size[0] = 1;
    cpu_cfs->size[1] = b_cpu_c->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_cfs, k, &sg_emlrtRTEI);
    k = b_cpu_c->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_cfs, gpu_cfs, !*cfs_outdatedOnGpu);
    if (*cfs_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_cfs, cpu_cfs);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel152#" MW_AT_LINE);
      smoothCFS_kernel152<<<grid, block>>>(gpu_c, k, *gpu_cfs,
                                           cpu_cfs->size[0U]);
    }
    *cfs_outdatedOnGpu = false;
    *cfs_outdatedOnCpu = true;
  } else {
    int32_T smooth[2];
    smooth[0] = cpu_smooth->size[0];
    k = cpu_cfs->size[0] * cpu_cfs->size[1];
    cpu_cfs->size[0] = cpu_smooth->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_cfs, k, &sg_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i2 - 1, smooth[0] - 1), &grid,
                            &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_cfs, gpu_cfs, !*cfs_outdatedOnGpu);
    if (*cfs_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_cfs, cpu_cfs);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#smoothCFS_kernel158#" MW_AT_LINE);
      smoothCFS_kernel158<<<grid, block>>>(smooth[0] - 1, i2 - 1, *gpu_cfs,
                                           cpu_cfs->size[0U]);
    }
    *cfs_outdatedOnGpu = false;
    *cfs_outdatedOnCpu = true;
    if ((cpu_smooth->size[0] != 0) && (i2 != 0) &&
        (static_cast<int32_T>(ns) != 0)) {
      if ((cpu_smooth->size[0] == 1) && (i2 == 1) &&
          (static_cast<int32_T>(ns) == 1)) {
        real_T cpu_a_data[1];
        k = b_cpu_smooth->size[0] * b_cpu_smooth->size[1];
        b_cpu_smooth->size[0] = 1;
        b_cpu_smooth->size[1] = 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_cpu_smooth, k, &tg_emlrtRTEI);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(b_cpu_smooth, &b_gpu_smooth, true);
        nvtxMarkA("#smoothCFS_kernel159#" MW_AT_LINE);
        smoothCFS_kernel159<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            gpu_smooth, b_gpu_smooth);
        c_omega_tmp1_needsGpuEnsureCapa = false;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(ns) - 1),
                                &grid, &block, 2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel160#" MW_AT_LINE);
          smoothCFS_kernel160<<<grid, block>>>(
              npad, static_cast<int32_T>(ns) - 1, *gpu_a_data);
        }
        nvtxMarkA("#checkCudaError#" MW_AT_LINE);
        nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
        checkCudaError(
            cudaMemcpy(cpu_a_data, *gpu_a_data, 8UL, cudaMemcpyDeviceToHost),
            __FILE__, __LINE__);
        nvtxMarkA("#mtimes#" MW_AT_LINE);
        ::coder::internal::blas::mtimes(
            b_cpu_smooth, &b_gpu_smooth, &c_omega_tmp1_needsGpuEnsureCapa,
            cpu_a_data, cpu_c, &c_outdatedOnCpu, &b_gpu_c, &c_outdatedOnGpu);
        k = cpu_cfs->size[0] * cpu_cfs->size[1];
        cpu_cfs->size[0] = 1;
        cpu_cfs->size[1] = 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_cfs, k, &sg_emlrtRTEI);
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_cfs, gpu_cfs);
        if (c_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_c, &b_gpu_c);
        }
        cpu_cfs->data[0] = cpu_c->data[0];
        *cfs_outdatedOnCpu = false;
        *cfs_outdatedOnGpu = true;
      } else {
        int32_T OH;
        uint32_T blockDims[3];
        int8_T threadDims[3];
        midpoint = static_cast<int32_T>(
            std::fmin(32.0, static_cast<real_T>(cpu_smooth->size[0])));
        N = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(i2)));
        blockDims[0] = static_cast<uint32_T>(std::floor(
            static_cast<real_T>((static_cast<uint32_T>(cpu_smooth->size[0]) +
                                 static_cast<uint32_T>(midpoint)) -
                                1U) /
            static_cast<real_T>(midpoint)));
        blockDims[1] = static_cast<uint32_T>(std::floor(
            static_cast<real_T>(
                (static_cast<uint32_T>(i2) + static_cast<uint32_T>(N)) - 1U) /
            static_cast<real_T>(N)));
        threadDims[0] = static_cast<int8_T>(midpoint);
        threadDims[1] = static_cast<int8_T>(N);
        OH = cpu_smooth->size[0];
        if (static_cast<int32_T>(ns) > MAX_int32_T - cpu_smooth->size[0]) {
          N = MAX_int32_T;
        } else {
          N = cpu_smooth->size[0] + static_cast<int32_T>(ns);
        }
        k = cpu_expanded->size[0] * cpu_expanded->size[1];
        cpu_expanded->size[0] = N - 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_expanded, k, &cg_emlrtRTEI);
        if (i2 > 2147483646) {
          N = MAX_int32_T;
        } else {
          N = i2 + 1;
        }
        k = cpu_expanded->size[0] * cpu_expanded->size[1];
        cpu_expanded->size[1] = N - 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_expanded, k, &cg_emlrtRTEI);
        k = ((cpu_smooth->size[0] + static_cast<int32_T>(ns)) - 1) * i2 - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_expanded, &b_gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel161#" MW_AT_LINE);
          smoothCFS_kernel161<<<grid, block>>>(k, b_gpu_expanded);
        }
        midpoint = cpu_smooth->size[0];
        k = cpu_y->size[0] * cpu_y->size[1];
        cpu_y->size[0] = 1;
        cpu_y->size[1] = cpu_smooth->size[0];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_y, k, &dg_emlrtRTEI);
        cpu_y->data[0] = 1;
        N = 1;
        profileLoopStart("smoothCFS_loop_2", __LINE__, (midpoint - 2) + 1, "");
        for (k = 0; k <= midpoint - 2; k++) {
          N++;
          cpu_y->data[k + 1] = N;
        }
        profileLoopEnd();
        k = cpu_iv->size[0];
        cpu_iv->size[0] = cpu_y->size[1];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_iv, k, &cg_emlrtRTEI);
        k = cpu_y->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_y, &b_gpu_y, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel162#" MW_AT_LINE);
          smoothCFS_kernel162<<<grid, block>>>(
              static_cast<int32_T>(std::floor(
                  (static_cast<real_T>(static_cast<int32_T>(ns)) - 1.0) / 2.0)),
              b_gpu_y, k, gpu_iv);
        }
        k = c_cpu_y->size[0] * c_cpu_y->size[1];
        c_cpu_y->size[0] = 1;
        c_cpu_y->size[1] = i2;
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(c_cpu_y, k, &dg_emlrtRTEI);
        c_cpu_y->data[0] = 1;
        N = 1;
        profileLoopStart("smoothCFS_loop_3", __LINE__, (i2 - 2) + 1, "");
        for (k = 0; k <= i2 - 2; k++) {
          N++;
          c_cpu_y->data[k + 1] = N;
        }
        profileLoopEnd();
        k = cpu_iv2->size[0];
        cpu_iv2->size[0] = c_cpu_y->size[1];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_iv2, k, &cg_emlrtRTEI);
        k = c_cpu_y->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(c_cpu_y, &c_gpu_y, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_iv2, &gpu_iv2, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_y, c_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel163#" MW_AT_LINE);
          smoothCFS_kernel163<<<grid, block>>>(c_gpu_y, k, gpu_iv2);
        }
        k = c_cpu_smooth->size[0] * c_cpu_smooth->size[1];
        c_cpu_smooth->size[0] = cpu_smooth->size[0];
        c_cpu_smooth->size[1] = i2;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(c_cpu_smooth, k, &tg_emlrtRTEI);
        k = cpu_smooth->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i2 - 1, k), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(c_cpu_smooth, &c_gpu_smooth, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel164#" MW_AT_LINE);
          smoothCFS_kernel164<<<grid, block>>>(
              gpu_smooth, k, i2 - 1, c_gpu_smooth, c_cpu_smooth->size[0U],
              cpu_smooth->size[0U]);
        }
        smooth[0] = cpu_iv->size[0];
        smooth[1] = cpu_iv2->size[0];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(smooth[1] - 1, smooth[0] - 1),
                                &grid, &block, 2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel165#" MW_AT_LINE);
          smoothCFS_kernel165<<<grid, block>>>(
              c_gpu_smooth, smooth[0], gpu_iv2, gpu_iv, smooth[0] - 1,
              smooth[1] - 1, b_gpu_expanded, cpu_expanded->size[0U]);
        }
        if (static_cast<int32_T>(ns) - 1 < 0) {
          midpoint = 0;
        } else {
          midpoint = static_cast<int32_T>(ns);
        }
        c_omega_tmp1_needsGpuEnsureCapa = false;
        k = cpu_rows->size[0] * cpu_rows->size[1];
        cpu_rows->size[0] = 1;
        cpu_rows->size[1] = midpoint;
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_rows, k, &dg_emlrtRTEI);
        if (midpoint > 0) {
          cpu_rows->data[0] = 0;
          c_omega_tmp1_needsGpuEnsureCapa = true;
          N = 0;
          profileLoopStart("smoothCFS_loop_4", __LINE__, (midpoint - 2) + 1,
                           "");
          for (k = 0; k <= midpoint - 2; k++) {
            N++;
            cpu_rows->data[k + 1] = N;
          }
          profileLoopEnd();
        }
        k = cpu_cfs->size[0] * cpu_cfs->size[1];
        cpu_cfs->size[0] = cpu_smooth->size[0];
        cpu_cfs->size[1] = i2;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_cfs, k, &cg_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwApplyLaunchParameters(computeNumIters(i2 - 1, OH - 1),
                                dim3(blockDims[0], blockDims[1], 1U),
                                dim3(static_cast<uint32_T>(threadDims[0]),
                                     static_cast<uint32_T>(threadDims[1]), 1U),
                                &grid, &block);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows,
                                     !c_omega_tmp1_needsGpuEnsureCapa);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_cfs, gpu_cfs, true);
        if (c_omega_tmp1_needsGpuEnsureCapa) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#smoothCFS_kernel166#" MW_AT_LINE);
          smoothCFS_kernel166<<<grid, block>>>(
              npad, b_gpu_expanded, gpu_rows, ns, OH - 1, i2 - 1, *gpu_cfs,
              cpu_expanded->size[0U], cpu_cfs->size[0U]);
        }
      }
    }
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_smooth);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_smooth);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_rows);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv2);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&c_cpu_y);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv1);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&b_cpu_y);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_expanded);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_expanded);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_c);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_c);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_a);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_smooth);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_omega_tmp1);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_omega_tmp2);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_omega);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_cfsDFT);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_Fmat);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_r);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&b_gpu_Fmat);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_smooth);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_a);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_c);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_c);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_expanded);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv1);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv2);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_smooth);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_smooth);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(*gpu_a_data), __FILE__, __LINE__);
  *scales_outdatedOnGpu = false;
  nvtxRangePop();
}

} // namespace cwt
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (smoothCFS.cu)
