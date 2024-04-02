//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wt2_fp.cu
//
// Code generation for function 'ec_wt2_fp'
//

// Include files
#include "ec_wt2_fp.h"
#include "circshift.h"
#include "cwtfilterbank.h"
#include "ec_wt2_fp_data.h"
#include "ec_wt2_fp_emxutil.h"
#include "ec_wt2_fp_mexutil.h"
#include "ec_wt2_fp_types.h"
#include "rt_nonfinite.h"
#include "wt.h"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Variable Definitions
static emlrtMCInfo c_emlrtMCI{
    53,        // lineNo
    19,        // colNo
    "flt2str", // fName
    "/usr/local/MATLAB/R2024a/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "flt2str.m" // pName
};

static emlrtRTEInfo emlrtRTEI{
    23,                                                      // lineNo
    1,                                                       // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    27,                                                      // lineNo
    27,                                                      // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    35,                                                      // lineNo
    28,                                                      // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    33,                                                      // lineNo
    29,                                                      // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    46,                                                      // lineNo
    1,                                                       // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    58,                                                      // lineNo
    10,                                                      // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    35,                                                      // lineNo
    9,                                                       // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    66,                          // lineNo
    30,                          // colNo
    "applyBinaryScalarFunction", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "applyBinaryScalarFunction.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    33,                                                      // lineNo
    9,                                                       // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    91,                                                           // lineNo
    14,                                                           // colNo
    "downsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/downsample.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    50,                                                      // lineNo
    5,                                                       // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo n_emlrtRTEI{
    67,                                                      // lineNo
    5,                                                       // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    21,                                                      // lineNo
    1,                                                       // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo p_emlrtRTEI{
    33,                                                      // lineNo
    17,                                                      // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo q_emlrtRTEI{
    35,                                                      // lineNo
    17,                                                      // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

static emlrtRTEInfo r_emlrtRTEI{
    46,                                                      // lineNo
    6,                                                       // colNo
    "ec_wt2_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt2_fp.m" // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId, char_T ret[23]);

static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
                                emlrtMCInfo *location);

static uint64_T computeNumIters(int32_T ub, int32_T b_ub);

static
#ifdef __CUDACC__
    __device__
#endif
        int32_T
        div_s32_device(int32_T numerator, int32_T denominator);

static __global__ void ec_wt2_fp_kernel1(const int32_T k,
                                         const emxArray_real_T x,
                                         const int32_T b_x, emxArray_real_T c_x,
                                         int32_T x_dim0);

static __global__ void ec_wt2_fp_kernel10(const emxArray_creal_T r,
                                          const int32_T b_r, const int32_T c_r,
                                          emxArray_creal_T yc, int32_T yc_dim0,
                                          int32_T r_dim0);

static __global__ void ec_wt2_fp_kernel11(const int32_T i1, const int32_T nx,
                                          const int32_T dim, int32_T sizeX[2]);

static __global__ void
ec_wt2_fp_kernel12(const emxArray_creal_T yc, const int32_T lshift_dim0,
                   const int32_T i1, const int32_T b, const int32_T c,
                   emxArray_creal_T b_yc, int32_T yc_dim0);

static __global__ void ec_wt2_fp_kernel13(const emxArray_creal_T yc,
                                          const int32_T lshift,
                                          emxArray_creal_T b_yc);

static __global__ void ec_wt2_fp_kernel2(const emxArray_creal_T r1,
                                         const int32_T b_r1, const int32_T c_r1,
                                         emxArray_creal_T x, int32_T x_dim0,
                                         int32_T r1_dim0);

static __global__ void ec_wt2_fp_kernel3(const emxArray_creal_T x,
                                         const int32_T b, emxArray_real_T yc);

static __global__ void ec_wt2_fp_kernel4(const emxArray_real_T yc,
                                         const int32_T b_yc, emxArray_real_T x);

static __global__ void ec_wt2_fp_kernel5(const emxArray_real_T x,
                                         const int32_T b, emxArray_real_T yc);

static __global__ void ec_wt2_fp_kernel6(const int32_T i1, const int32_T nx,
                                         const int32_T dim, int32_T sizeX[2]);

static __global__ void ec_wt2_fp_kernel7(const emxArray_real_T yc,
                                         const int32_T lshift_dim0,
                                         const int32_T i1, const int32_T b,
                                         const int32_T c, emxArray_real_T b_yc,
                                         int32_T yc_dim0);

static __global__ void ec_wt2_fp_kernel8(const emxArray_real_T yc,
                                         const int32_T lshift,
                                         emxArray_real_T b_yc);

static __global__ void ec_wt2_fp_kernel9(const int32_T k,
                                         const emxArray_real_T x,
                                         const int32_T b_x, emxArray_real_T c_x,
                                         int32_T x_dim0);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId, char_T y[23]);

static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_,
                             const char_T *identifier, char_T y[23]);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId, char_T ret[23])
{
  static const int32_T dims[2]{1, 23};
  nvtxRangePushA("#fcn#b_emlrt_marshallIn#" MW_AT_LOCATION);
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U,
                          (const void *)&dims[0]);
  emlrtImportCharArrayR2015b(emlrtRootTLSGlobal, src, &ret[0], 23);
  emlrtDestroyArray(&src);
  nvtxRangePop();
}

static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
                                emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m;
  const mxArray *m3;
  nvtxRangePushA("#fcn#b_sprintf#" MW_AT_LOCATION);
  pArrays[0] = m1;
  pArrays[1] = m2;
  m3 = emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 2, &pArrays[0],
                             "sprintf", true, location);
  nvtxRangePop();
  return m3;
}

static uint64_T computeNumIters(int32_T ub, int32_T b_ub)
{
  uint64_T n;
  uint64_T numIters;
  nvtxRangePushA("#fcn#computeNumIters#" MW_AT_LOCATION);
  n = 0UL;
  if (ub >= 0) {
    n = static_cast<uint64_T>(ub + 1);
  }
  numIters = n;
  n = 0UL;
  if (b_ub >= 0) {
    n = static_cast<uint64_T>(b_ub + 1);
  }
  numIters *= n;
  nvtxRangePop();
  return numIters;
}

static __device__ int32_T div_s32_device(int32_T numerator, int32_T denominator)
{
  int32_T quotient;
  if (denominator == 0) {
    if (numerator >= 0) {
      quotient = MAX_int32_T;
    } else {
      quotient = MIN_int32_T;
    }
  } else {
    uint32_T b;
    uint32_T tempAbsQuotient;
    if (numerator < 0) {
      tempAbsQuotient = ~static_cast<uint32_T>(numerator) + 1U;
    } else {
      tempAbsQuotient = static_cast<uint32_T>(numerator);
    }
    if (denominator < 0) {
      b = ~static_cast<uint32_T>(denominator) + 1U;
    } else {
      b = static_cast<uint32_T>(denominator);
    }
    tempAbsQuotient /= b;
    if (static_cast<int32_T>(numerator < 0) !=
        static_cast<int32_T>(denominator < 0)) {
      quotient = -static_cast<int32_T>(tempAbsQuotient);
    } else {
      quotient = static_cast<int32_T>(tempAbsQuotient);
    }
  }
  return quotient;
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel1(
    const int32_T k, const emxArray_real_T x, const int32_T b_x,
    emxArray_real_T c_x, int32_T x_dim0)
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
    c_x.data[i] = x.data[i + x_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel10(
    const emxArray_creal_T r, const int32_T b_r, const int32_T c_r,
    emxArray_creal_T yc, int32_T yc_dim0, int32_T r_dim0)
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
    yc.data[k + yc_dim0 * i].re = r.data[i + r_dim0 * k].re;
    yc.data[k + yc_dim0 * i].im = -r.data[i + r_dim0 * k].im;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_wt2_fp_kernel11(
    const int32_T i1, const int32_T nx, const int32_T dim, int32_T sizeX[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    sizeX[dim] = div_s32_device(nx, i1) + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel12(
    const emxArray_creal_T yc, const int32_T lshift_dim0, const int32_T i1,
    const int32_T b, const int32_T c, emxArray_creal_T b_yc, int32_T yc_dim0)
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                             (static_cast<uint64_T>(b) + 1UL));
    b_yc.data[k + yc_dim0 * i] = yc.data[i1 * k + lshift_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel13(
    const emxArray_creal_T yc, const int32_T lshift, emxArray_creal_T b_yc)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lshift);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_yc.data[i] = yc.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel2(
    const emxArray_creal_T r1, const int32_T b_r1, const int32_T c_r1,
    emxArray_creal_T x, int32_T x_dim0, int32_T r1_dim0)
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
    x.data[k + x_dim0 * i].re = r1.data[i + r1_dim0 * k].re;
    x.data[k + x_dim0 * i].im = -r1.data[i + r1_dim0 * k].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel3(
    const emxArray_creal_T x, const int32_T b, emxArray_real_T yc)
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
    yc.data[k] = hypot(x.data[k].re, x.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel4(
    const emxArray_real_T yc, const int32_T b_yc, emxArray_real_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_yc);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = yc.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel5(
    const emxArray_real_T x, const int32_T b, emxArray_real_T yc)
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
    yc.data[k] = x.data[k] * x.data[k];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_wt2_fp_kernel6(
    const int32_T i1, const int32_T nx, const int32_T dim, int32_T sizeX[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    sizeX[dim] = div_s32_device(nx, i1) + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel7(
    const emxArray_real_T yc, const int32_T lshift_dim0, const int32_T i1,
    const int32_T b, const int32_T c, emxArray_real_T b_yc, int32_T yc_dim0)
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                             (static_cast<uint64_T>(b) + 1UL));
    b_yc.data[k + yc_dim0 * i] = yc.data[i1 * k + lshift_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel8(
    const emxArray_real_T yc, const int32_T lshift, emxArray_real_T b_yc)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lshift);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_yc.data[i] = yc.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt2_fp_kernel9(
    const int32_T k, const emxArray_real_T x, const int32_T b_x,
    emxArray_real_T c_x, int32_T x_dim0)
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
    c_x.data[i] = x.data[i + x_dim0 * k];
  }
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId, char_T y[23])
{
  nvtxRangePushA("#fcn#emlrt_marshallIn#" MW_AT_LOCATION);
  nvtxMarkA("#b_emlrt_marshallIn#" MW_AT_LINE);
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
  nvtxRangePop();
}

static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_,
                             const char_T *identifier, char_T y[23])
{
  emlrtMsgIdentifier thisId;
  nvtxRangePushA("#fcn#emlrt_marshallIn#" MW_AT_LOCATION);
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
  emlrt_marshallIn(emlrtAlias(a__output_of_sprintf_), &thisId, y);
  emlrtDestroyArray(&a__output_of_sprintf_);
  nvtxRangePop();
}

//
// function [y,frqs] = ec_wt2_fp(x,fs,lims,voices,ds,doReal,doPwr)
void ec_wt2_fp(const emxArray_real_T *cpu_x, real_T fs, const real_T lims[2],
               real_T voices, real_T ds, boolean_T doReal, boolean_T doPwr,
               emxArray_cell_wrap_0 *y, emxArray_real_T *frqs)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  coder::cwtfilterbank fb;
  dim3 block;
  dim3 grid;
  emxArray_creal_T c_gpu_x;
  emxArray_creal_T c_gpu_yc;
  emxArray_creal_T d_gpu_yc;
  emxArray_creal_T gpu_r;
  emxArray_creal_T gpu_r1;
  emxArray_creal_T *b_cpu_x;
  emxArray_creal_T *b_cpu_yc;
  emxArray_creal_T *c_cpu_yc;
  emxArray_creal_T *cpu_r;
  emxArray_creal_T *cpu_r1;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_yc;
  emxArray_real_T d_gpu_x;
  emxArray_real_T e_gpu_x;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_yc;
  emxArray_real_T *c_cpu_x;
  emxArray_real_T *cpu_yc;
  emxArray_real_T *d_cpu_x;
  emxArray_real_T *d_cpu_yc;
  emxArray_real_T *e_cpu_x;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  int32_T(*gpu_lshift)[2];
  int32_T(*gpu_sizeX)[2];
  int32_T dim;
  int32_T i;
  int32_T i1;
  int32_T nx;
  int32_T vstride;
  char_T unusedExpr[23];
  boolean_T lshift_outdatedOnCpu;
  boolean_T lshift_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  nvtxMarkA("#entryPointStart#");
  nvtxRangePushA("#entryPointFcn#ec_wt2_fp#" MW_AT_LOCATION);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_lshift, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_sizeX, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_yc);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&d_gpu_yc);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_x);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&e_gpu_x);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_r1);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_r);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&d_gpu_x);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&c_gpu_x);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&c_gpu_yc);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_yc);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_x);
  x_outdatedOnGpu = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInitStruct_cwtfilterbank#" MW_AT_LINE);
  emxInitStruct_cwtfilterbank(&fb, &o_emlrtRTEI, true);
  //  [electroCUDA] CWT - CUDA mex source
  //    Called by function 'ec_wt' (see for details)
  //    Intended to be compiled into a CUDA mex binary
  //    Kevin Tan, 2024 (github.com/kevmtan/electroCUDA)
  // 'ec_wt2_fp:7' x (:,:){mustBeFloat}
  //  Input data
  // 'ec_wt2_fp:8' fs (1,1) double
  //  Sampling rate
  // 'ec_wt2_fp:9' lims (1,2) double
  //  Frequency limits
  // 'ec_wt2_fp:10' voices (1,1) double = 10
  //  Voices per octave
  // 'ec_wt2_fp:11' ds (1,1) double = 0
  //  Downsampling factor
  // 'ec_wt2_fp:12' doReal (1,1) logical = true
  //  Real output? (complex otherwise)
  // 'ec_wt2_fp:13' doPwr (1,1) logical = false
  //  Power output? (magnitude otherwise)
  // 'ec_wt2_fp:15' if ds<=1
  if (ds <= 1.0) {
    // 'ec_wt2_fp:15' ;
    // 'ec_wt2_fp:15' ds=0;
    ds = 0.0;
  }
  //  Prep
  // 'ec_wt2_fp:18' nChs = width(x);
  //  Generate CWT filter
  // 'ec_wt2_fp:21' fb =
  // cwtfilterbank(Wavelet="Morse",SignalLength=height(x),SamplingFrequency=fs,...
  // 'ec_wt2_fp:22'     FrequencyLimits=lims,VoicesPerOctave=voices);
  nvtxMarkA("#cwtfilterbank_cwtfilterbank#" MW_AT_LINE);
  coder::cwtfilterbank_cwtfilterbank(&fb, static_cast<real_T>(cpu_x->size[0]),
                                     fs, lims, voices);
  // 'ec_wt2_fp:23' frqs = flip(fb.centerFrequencies);
  vstride = frqs->size[0];
  frqs->size[0] = fb.WaveletCenterFrequencies->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(frqs, vstride, &emlrtRTEI);
  profileLoopStart("ec_wt2_fp_loop_0", __LINE__,
                   (fb.WaveletCenterFrequencies->size[0] - 1) + 1, "");
  for (vstride = 0; vstride < fb.WaveletCenterFrequencies->size[0]; vstride++) {
    frqs->data[vstride] = fb.WaveletCenterFrequencies->data[vstride];
  }
  profileLoopEnd();
  dim = 2;
  if (fb.WaveletCenterFrequencies->size[0] != 1) {
    dim = 1;
  }
  if (fb.WaveletCenterFrequencies->size[0] != 0) {
    if (dim <= 1) {
      nx = fb.WaveletCenterFrequencies->size[0];
    } else {
      nx = 1;
    }
    if (nx > 1) {
      vstride = 1;
      profileLoopStart("ec_wt2_fp_loop_1", __LINE__, (dim - 2) + 1, "");
      for (int32_T k{0}; k <= dim - 2; k++) {
        vstride *= fb.WaveletCenterFrequencies->size[0];
      }
      profileLoopEnd();
      if (dim <= 1) {
        nx = fb.WaveletCenterFrequencies->size[0];
      } else {
        nx = 1;
      }
      dim = nx >> 1;
      i1 = vstride - 1;
      profileLoopStart("ec_wt2_fp_loop_2", __LINE__, i1 + 1, "");
      for (i = 0; i <= i1; i++) {
        profileLoopStart("ec_wt2_fp_loop_3", __LINE__, (dim - 1) + 1, "");
        for (int32_T k{0}; k < dim; k++) {
          real_T tmp;
          tmp = frqs->data[i + k * vstride];
          frqs->data[i + k * vstride] =
              frqs->data[i + ((nx - k) - 1) * vstride];
          frqs->data[i + ((nx - k) - 1) * vstride] = tmp;
        }
        profileLoopEnd();
      }
      profileLoopEnd();
    }
  }
  //  Preallocate output
  // 'ec_wt2_fp:26' coder.gpu.kernelfun;
  //  Trigger CUDA kernel creation
  // 'ec_wt2_fp:27' y = coder.nullcopy(cell(1,nChs));
  vstride = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = cpu_x->size[1];
  nvtxMarkA("#emxEnsureCapacity_cell_wrap_0#" MW_AT_LINE);
  emxEnsureCapacity_cell_wrap_0(y, vstride, &b_emlrtRTEI);
  //  Processing loop across channels
  // 'ec_wt2_fp:31' for ch = 1:nChs
  i = cpu_x->size[1];
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_yc, 2, &p_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&b_cpu_yc, 2, &q_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&b_cpu_x, 2, &f_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_x, 2, &i_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_r, 2, &r_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_r1, 2, &f_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_x, 1, &c_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&e_cpu_x, 1, &d_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&c_cpu_yc, 2, &k_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_yc, 2, &k_emlrtRTEI, true);
  profileLoopStart("ec_wt2_fp_loop_4", __LINE__, (i - 1) + 1, "");
  for (int32_T k{0}; k < i; k++) {
    // 'ec_wt2_fp:32' if doReal
    if (doReal) {
      uint32_T b_dv[2];
      boolean_T validLaunchParams;
      boolean_T yc_outdatedOnCpu;
      // 'ec_wt2_fp:33' y{ch} = cwtR_lfn(fb,x(:,ch),ds,doPwr);
      //  Run CWT (magnitude/power)
      //  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CWT - magnitude out
      // 'ec_wt2_fp:58' yc = abs(wt(fb,xc)');
      vstride = e_cpu_x->size[0];
      e_cpu_x->size[0] = cpu_x->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(e_cpu_x, vstride, &d_emlrtRTEI);
      dim = cpu_x->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(dim), &grid, &block, 2147483647U);
      if (x_needsGpuEnsureCapacity) {
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
      }
      x_needsGpuEnsureCapacity = false;
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(e_cpu_x, &b_gpu_x, true);
      if (x_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
      }
      x_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt2_fp_kernel1#" MW_AT_LINE);
        ec_wt2_fp_kernel1<<<grid, block>>>(k, gpu_x, dim, b_gpu_x,
                                           cpu_x->size[0U]);
      }
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real_T(e_cpu_x, &b_gpu_x);
      nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
      coder::cwtfilterbank_wt(&fb, e_cpu_x, cpu_r1);
      vstride = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = cpu_r1->size[1];
      b_cpu_x->size[1] = cpu_r1->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(b_cpu_x, vstride, &f_emlrtRTEI);
      dim = cpu_r1->size[0] - 1;
      nx = cpu_r1->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(dim, nx), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_r1, &gpu_r1, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(b_cpu_x, &c_gpu_x, true);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_r1, cpu_r1);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt2_fp_kernel2#" MW_AT_LINE);
        ec_wt2_fp_kernel2<<<grid, block>>>(gpu_r1, nx, dim, c_gpu_x,
                                           b_cpu_x->size[0U], cpu_r1->size[0U]);
      }
      nx = b_cpu_x->size[0] * b_cpu_x->size[1];
      profileLoopStart("ec_wt2_fp_loop_5", __LINE__, 1 + 1, "");
      for (i1 = 0; i1 < 2; i1++) {
        b_dv[i1] = static_cast<uint32_T>(b_cpu_x->size[i1]);
      }
      profileLoopEnd();
      vstride = cpu_yc->size[0] * cpu_yc->size[1];
      cpu_yc->size[0] = static_cast<int32_T>(b_dv[0]);
      cpu_yc->size[1] = static_cast<int32_T>(b_dv[1]);
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_yc, vstride, &h_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_yc, &gpu_yc, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt2_fp_kernel3#" MW_AT_LINE);
        ec_wt2_fp_kernel3<<<grid, block>>>(c_gpu_x, nx - 1, gpu_yc);
      }
      yc_outdatedOnCpu = true;
      //  Convert to power
      // 'ec_wt2_fp:61' if doPwr
      if (doPwr) {
        // 'ec_wt2_fp:62' yc = yc.^2;
        vstride = c_cpu_x->size[0] * c_cpu_x->size[1];
        c_cpu_x->size[0] = cpu_yc->size[0];
        c_cpu_x->size[1] = cpu_yc->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(c_cpu_x, vstride, &i_emlrtRTEI);
        dim = cpu_yc->size[0] * cpu_yc->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(dim), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(c_cpu_x, &d_gpu_x, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt2_fp_kernel4#" MW_AT_LINE);
          ec_wt2_fp_kernel4<<<grid, block>>>(gpu_yc, dim, d_gpu_x);
        }
        profileLoopStart("ec_wt2_fp_loop_9", __LINE__, 1 + 1, "");
        for (i1 = 0; i1 < 2; i1++) {
          b_dv[i1] = static_cast<uint32_T>(cpu_yc->size[i1]);
        }
        profileLoopEnd();
        vstride = cpu_yc->size[0] * cpu_yc->size[1];
        cpu_yc->size[0] = static_cast<int32_T>(b_dv[0]);
        cpu_yc->size[1] = static_cast<int32_T>(b_dv[1]);
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_yc, vstride, &l_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(
            computeNumIters(static_cast<int32_T>(b_dv[0]) *
                                static_cast<int32_T>(b_dv[1]) -
                            1),
            &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_yc, &gpu_yc, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt2_fp_kernel5#" MW_AT_LINE);
          ec_wt2_fp_kernel5<<<grid, block>>>(
              d_gpu_x,
              static_cast<int32_T>(b_dv[0]) * static_cast<int32_T>(b_dv[1]) - 1,
              gpu_yc);
        }
      }
      //  Downsample
      // 'ec_wt2_fp:66' if ds
      if (ds != 0.0) {
        int32_T cpu_lshift[2];
        int32_T cpu_sizeX[2];
        boolean_T sizeX_outdatedOnGpu;
        // 'ec_wt2_fp:67' yc = downsample(yc,ds);
        if (!(ds - 1.0 >= 0.0)) {
          d_y = nullptr;
          m2 = emlrtCreateCharArray(2, &iv1[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m2, &rfmt[0]);
          emlrtAssign(&d_y, m2);
          e_y = nullptr;
          m3 = emlrtCreateDoubleScalar(ds - 1.0);
          emlrtAssign(&e_y, m3);
          nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
          nvtxMarkA("#b_sprintf#" MW_AT_LINE);
          emlrt_marshallIn(b_sprintf(d_y, e_y, &c_emlrtMCI),
                           "<output of sprintf>", unusedExpr);
        }
        dim = 1;
        if (cpu_yc->size[0] != 1) {
          dim = 0;
        }
        sizeX_outdatedOnGpu = false;
        lshift_outdatedOnCpu = false;
        lshift_outdatedOnGpu = false;
        profileLoopStart("ec_wt2_fp_loop_10", __LINE__, 1 + 1, "");
        for (i1 = 0; i1 < 2; i1++) {
          cpu_sizeX[i1] = cpu_yc->size[i1];
          sizeX_outdatedOnGpu = true;
          cpu_lshift[i1] = cpu_yc->size[i1];
          lshift_outdatedOnGpu = true;
        }
        profileLoopEnd();
        nvtxMarkA("#circshift#" MW_AT_LINE);
        coder::circshift(cpu_lshift, &lshift_outdatedOnCpu, *gpu_lshift,
                         &lshift_outdatedOnGpu, -dim);
        if (lshift_outdatedOnCpu) {
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(
              cudaMemcpy(cpu_lshift, *gpu_lshift, 8UL, cudaMemcpyDeviceToHost),
              __FILE__, __LINE__);
        }
        if ((ds > 0.0) && (cpu_lshift[0] < 1)) {
          i1 = 1;
          nx = -1;
        } else {
          i1 = static_cast<int32_T>(ds);
          nx = cpu_lshift[0] - 1;
        }
        if (sizeX_outdatedOnGpu) {
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(
              cudaMemcpy(*gpu_sizeX, cpu_sizeX, 8UL, cudaMemcpyHostToDevice),
              __FILE__, __LINE__);
        }
        nvtxMarkA("#ec_wt2_fp_kernel6#" MW_AT_LINE);
        ec_wt2_fp_kernel6<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i1, nx, dim,
                                                                   *gpu_sizeX);
        dim = d_cpu_yc->size[0] * d_cpu_yc->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        d_cpu_yc->size[0] = div_s32(nx, i1) + 1;
        d_cpu_yc->size[1] = cpu_lshift[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(d_cpu_yc, dim, &k_emlrtRTEI);
        dim = nx / i1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(cpu_lshift[1] - 1, dim), &grid,
                                &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(d_cpu_yc, &b_gpu_yc, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt2_fp_kernel7#" MW_AT_LINE);
          ec_wt2_fp_kernel7<<<grid, block>>>(gpu_yc, cpu_lshift[0], i1, dim,
                                             cpu_lshift[1] - 1, b_gpu_yc,
                                             d_cpu_yc->size[0U]);
        }
        nvtxMarkA("#checkCudaError#" MW_AT_LINE);
        nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
        checkCudaError(
            cudaMemcpy(cpu_sizeX, *gpu_sizeX, 8UL, cudaMemcpyDeviceToHost),
            __FILE__, __LINE__);
        vstride = cpu_yc->size[0] * cpu_yc->size[1];
        cpu_yc->size[0] = cpu_sizeX[0];
        cpu_yc->size[1] = cpu_sizeX[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_yc, vstride, &n_emlrtRTEI);
        dim = cpu_sizeX[0] * cpu_sizeX[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(dim), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_yc, &gpu_yc, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt2_fp_kernel8#" MW_AT_LINE);
          ec_wt2_fp_kernel8<<<grid, block>>>(b_gpu_yc, dim, gpu_yc);
        }
      }
      vstride = y->data[k].f1->size[0] * y->data[k].f1->size[1];
      y->data[k].f1->size[0] = cpu_yc->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(y->data[k].f1, vstride, &j_emlrtRTEI);
      vstride = y->data[k].f1->size[0] * y->data[k].f1->size[1];
      y->data[k].f1->size[1] = cpu_yc->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(y->data[k].f1, vstride, &j_emlrtRTEI);
      profileLoopStart("ec_wt2_fp_loop_8", __LINE__,
                       (cpu_yc->size[0] * cpu_yc->size[1] - 1) + 1, "");
      for (vstride = 0; vstride < cpu_yc->size[0] * cpu_yc->size[1];
           vstride++) {
        if (yc_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_yc, &gpu_yc);
        }
        yc_outdatedOnCpu = false;
        y->data[k].f1->data[vstride].re = cpu_yc->data[vstride];
        y->data[k].f1->data[vstride].im = 0.0;
      }
      profileLoopEnd();
    } else {
      boolean_T validLaunchParams;
      boolean_T yc_outdatedOnCpu;
      // 'ec_wt2_fp:34' else
      // 'ec_wt2_fp:35' y{ch} = cwt_lfn(fb,x(:,ch),ds);
      //  Run CWT (complex)
      //  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CWT
      // 'ec_wt2_fp:46' yc = wt(fb,xc)';
      vstride = d_cpu_x->size[0];
      d_cpu_x->size[0] = cpu_x->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(d_cpu_x, vstride, &c_emlrtRTEI);
      dim = cpu_x->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(dim), &grid, &block, 2147483647U);
      if (x_needsGpuEnsureCapacity) {
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
      }
      x_needsGpuEnsureCapacity = false;
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(d_cpu_x, &e_gpu_x, true);
      if (x_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
      }
      x_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt2_fp_kernel9#" MW_AT_LINE);
        ec_wt2_fp_kernel9<<<grid, block>>>(k, gpu_x, dim, e_gpu_x,
                                           cpu_x->size[0U]);
      }
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &e_gpu_x);
      nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
      coder::cwtfilterbank_wt(&fb, d_cpu_x, cpu_r);
      vstride = b_cpu_yc->size[0] * b_cpu_yc->size[1];
      b_cpu_yc->size[0] = cpu_r->size[1];
      b_cpu_yc->size[1] = cpu_r->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(b_cpu_yc, vstride, &e_emlrtRTEI);
      dim = cpu_r->size[0] - 1;
      nx = cpu_r->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(dim, nx), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_r, &gpu_r, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(b_cpu_yc, &c_gpu_yc, true);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_r, cpu_r);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt2_fp_kernel10#" MW_AT_LINE);
        ec_wt2_fp_kernel10<<<grid, block>>>(
            gpu_r, nx, dim, c_gpu_yc, b_cpu_yc->size[0U], cpu_r->size[0U]);
      }
      yc_outdatedOnCpu = true;
      //  Downsample
      // 'ec_wt2_fp:49' if ds
      if (ds != 0.0) {
        int32_T cpu_lshift[2];
        int32_T cpu_sizeX[2];
        boolean_T sizeX_outdatedOnGpu;
        // 'ec_wt2_fp:50' yc = downsample(yc,ds);
        if (!(ds - 1.0 >= 0.0)) {
          b_y = nullptr;
          m = emlrtCreateCharArray(2, &iv[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
          emlrtAssign(&b_y, m);
          c_y = nullptr;
          m1 = emlrtCreateDoubleScalar(ds - 1.0);
          emlrtAssign(&c_y, m1);
          nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
          nvtxMarkA("#b_sprintf#" MW_AT_LINE);
          emlrt_marshallIn(b_sprintf(b_y, c_y, &c_emlrtMCI),
                           "<output of sprintf>", unusedExpr);
        }
        dim = 1;
        if (b_cpu_yc->size[0] != 1) {
          dim = 0;
        }
        sizeX_outdatedOnGpu = false;
        lshift_outdatedOnCpu = false;
        lshift_outdatedOnGpu = false;
        profileLoopStart("ec_wt2_fp_loop_7", __LINE__, 1 + 1, "");
        for (i1 = 0; i1 < 2; i1++) {
          cpu_sizeX[i1] = b_cpu_yc->size[i1];
          sizeX_outdatedOnGpu = true;
          cpu_lshift[i1] = b_cpu_yc->size[i1];
          lshift_outdatedOnGpu = true;
        }
        profileLoopEnd();
        nvtxMarkA("#circshift#" MW_AT_LINE);
        coder::circshift(cpu_lshift, &lshift_outdatedOnCpu, *gpu_lshift,
                         &lshift_outdatedOnGpu, -dim);
        if (lshift_outdatedOnCpu) {
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(
              cudaMemcpy(cpu_lshift, *gpu_lshift, 8UL, cudaMemcpyDeviceToHost),
              __FILE__, __LINE__);
        }
        if ((ds > 0.0) && (cpu_lshift[0] < 1)) {
          i1 = 1;
          nx = -1;
        } else {
          i1 = static_cast<int32_T>(ds);
          nx = cpu_lshift[0] - 1;
        }
        if (sizeX_outdatedOnGpu) {
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(
              cudaMemcpy(*gpu_sizeX, cpu_sizeX, 8UL, cudaMemcpyHostToDevice),
              __FILE__, __LINE__);
        }
        nvtxMarkA("#ec_wt2_fp_kernel11#" MW_AT_LINE);
        ec_wt2_fp_kernel11<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i1, nx, dim,
                                                                    *gpu_sizeX);
        dim = c_cpu_yc->size[0] * c_cpu_yc->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        c_cpu_yc->size[0] = div_s32(nx, i1) + 1;
        c_cpu_yc->size[1] = cpu_lshift[1];
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(c_cpu_yc, dim, &k_emlrtRTEI);
        dim = nx / i1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(cpu_lshift[1] - 1, dim), &grid,
                                &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(c_cpu_yc, &d_gpu_yc, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt2_fp_kernel12#" MW_AT_LINE);
          ec_wt2_fp_kernel12<<<grid, block>>>(c_gpu_yc, cpu_lshift[0], i1, dim,
                                              cpu_lshift[1] - 1, d_gpu_yc,
                                              c_cpu_yc->size[0U]);
        }
        nvtxMarkA("#checkCudaError#" MW_AT_LINE);
        nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
        checkCudaError(
            cudaMemcpy(cpu_sizeX, *gpu_sizeX, 8UL, cudaMemcpyDeviceToHost),
            __FILE__, __LINE__);
        vstride = b_cpu_yc->size[0] * b_cpu_yc->size[1];
        b_cpu_yc->size[0] = cpu_sizeX[0];
        b_cpu_yc->size[1] = cpu_sizeX[1];
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(b_cpu_yc, vstride, &m_emlrtRTEI);
        dim = cpu_sizeX[0] * cpu_sizeX[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(dim), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(b_cpu_yc, &c_gpu_yc, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt2_fp_kernel13#" MW_AT_LINE);
          ec_wt2_fp_kernel13<<<grid, block>>>(d_gpu_yc, dim, c_gpu_yc);
        }
      }
      vstride = y->data[k].f1->size[0] * y->data[k].f1->size[1];
      y->data[k].f1->size[0] = b_cpu_yc->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(y->data[k].f1, vstride, &g_emlrtRTEI);
      vstride = y->data[k].f1->size[0] * y->data[k].f1->size[1];
      y->data[k].f1->size[1] = b_cpu_yc->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(y->data[k].f1, vstride, &g_emlrtRTEI);
      profileLoopStart("ec_wt2_fp_loop_6", __LINE__,
                       (b_cpu_yc->size[0] * b_cpu_yc->size[1] - 1) + 1, "");
      for (vstride = 0; vstride < b_cpu_yc->size[0] * b_cpu_yc->size[1];
           vstride++) {
        if (yc_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_creal_T(b_cpu_yc, &c_gpu_yc);
        }
        yc_outdatedOnCpu = false;
        y->data[k].f1->data[vstride] = b_cpu_yc->data[vstride];
      }
      profileLoopEnd();
    }
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_yc);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&c_cpu_yc);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&e_cpu_x);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_x);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_r1);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_r);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_x);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&b_cpu_x);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&b_cpu_yc);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_yc);
  nvtxMarkA("#emxFreeStruct_cwtfilterbank#" MW_AT_LINE);
  emxFreeStruct_cwtfilterbank(&fb);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_x);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_yc);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&c_gpu_yc);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&c_gpu_x);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&d_gpu_x);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_r);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_r1);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&e_gpu_x);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_x);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&d_gpu_yc);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_yc);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(*gpu_sizeX), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(*gpu_lshift), __FILE__, __LINE__);
  nvtxRangePop();
  nvtxMarkA("#entryPointEnd#");
}

// End of code generation (ec_wt2_fp.cu)
