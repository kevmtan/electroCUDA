//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wt_fp.cu
//
// Code generation for function 'ec_wt_fp'
//

// Include files
#include "ec_wt_fp.h"
#include "circshift.h"
#include "cwt.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "rt_nonfinite.h"
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

static emlrtRTEInfo c_emlrtRTEI{
    24,                                                     // lineNo
    27,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    32,                                                     // lineNo
    25,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    30,                                                     // lineNo
    26,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    43,                                                     // lineNo
    1,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    55,                                                     // lineNo
    10,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    32,                                                     // lineNo
    9,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    30,                    // lineNo
    21,                    // colNo
    "applyScalarFunction", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "applyScalarFunction.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    30,                                                     // lineNo
    9,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    91,                                                           // lineNo
    14,                                                           // colNo
    "downsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/downsample.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    129,                         // lineNo
    6,                           // colNo
    "applyBinaryScalarFunction", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "applyBinaryScalarFunction.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    59,                                                     // lineNo
    5,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo n_emlrtRTEI{
    47,                                                     // lineNo
    5,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    64,                                                     // lineNo
    5,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo p_emlrtRTEI{
    30,                                                     // lineNo
    17,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo q_emlrtRTEI{
    32,                                                     // lineNo
    17,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo r_emlrtRTEI{
    59,                                                     // lineNo
    10,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo s_emlrtRTEI{
    43,                                                     // lineNo
    6,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId, char_T ret[23]);

static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
                                emlrtMCInfo *location);

static int32_T div_s32(int32_T numerator, int32_T denominator);

static
#ifdef __CUDACC__
    __device__
#endif
        int32_T
        div_s32_device(int32_T numerator, int32_T denominator);

static __global__ void ec_wt_fp_kernel1(const int32_T ch,
                                        const emxArray_real32_T x,
                                        const int32_T b_x,
                                        emxArray_real32_T c_x, int32_T x_dim0);

static __global__ void ec_wt_fp_kernel10(const emxArray_creal32_T r,
                                         const int32_T b_r, const int32_T c_r,
                                         emxArray_creal32_T yc, int32_T yc_dim0,
                                         int32_T r_dim0);

static __global__ void ec_wt_fp_kernel11(const int32_T i1, const int32_T i2,
                                         const int32_T nx, int32_T sizeX[2]);

static __global__ void
ec_wt_fp_kernel12(const emxArray_creal32_T yc, const int32_T lshift_dim0,
                  const int32_T i1, const int32_T b, const int32_T c,
                  emxArray_creal32_T b_yc, int32_T yc_dim0);

static __global__ void ec_wt_fp_kernel13(const emxArray_creal32_T yc,
                                         const int32_T lshift,
                                         emxArray_creal32_T b_yc);

static __global__ void ec_wt_fp_kernel2(const emxArray_creal32_T r1,
                                        const int32_T b_r1, const int32_T c_r1,
                                        emxArray_creal32_T x, int32_T x_dim0,
                                        int32_T r1_dim0);

static __global__ void ec_wt_fp_kernel3(const emxArray_creal32_T x,
                                        const int32_T b, emxArray_real32_T yc);

static __global__ void ec_wt_fp_kernel4(const emxArray_real32_T yc,
                                        const int32_T b, emxArray_real32_T y);

static __global__ void ec_wt_fp_kernel5(const emxArray_real32_T y,
                                        const int32_T b_y,
                                        emxArray_real32_T yc);

static __global__ void ec_wt_fp_kernel6(const int32_T i1, const int32_T i2,
                                        const int32_T nx, int32_T sizeX[2]);

static __global__ void ec_wt_fp_kernel7(const emxArray_real32_T yc,
                                        const int32_T lshift_dim0,
                                        const int32_T i1, const int32_T b,
                                        const int32_T c, emxArray_real32_T b_yc,
                                        int32_T yc_dim0);

static __global__ void ec_wt_fp_kernel8(const emxArray_real32_T yc,
                                        const int32_T lshift,
                                        emxArray_real32_T b_yc);

static __global__ void ec_wt_fp_kernel9(const int32_T ch,
                                        const emxArray_real32_T x,
                                        const int32_T b_x,
                                        emxArray_real32_T c_x, int32_T x_dim0);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId, char_T y[23]);

static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_,
                             const char_T *identifier, char_T y[23]);

static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu,
                                           const emxArray_creal32_T *cpu);

static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu);

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

static int32_T div_s32(int32_T numerator, int32_T denominator)
{
  int32_T quotient;
  nvtxRangePushA("#fcn#div_s32#" MW_AT_LOCATION);
  if (denominator == 0) {
    emlrtDivisionByZeroErrorR2012b(nullptr, emlrtRootTLSGlobal);
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
    if ((numerator < 0) != (denominator < 0)) {
      quotient = -static_cast<int32_T>(tempAbsQuotient);
    } else {
      quotient = static_cast<int32_T>(tempAbsQuotient);
    }
  }
  nvtxRangePop();
  return quotient;
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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel1(
    const int32_T ch, const emxArray_real32_T x, const int32_T b_x,
    emxArray_real32_T c_x, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c_x.data[i1] = x.data[i1 + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel10(
    const emxArray_creal32_T r, const int32_T b_r, const int32_T c_r,
    emxArray_creal32_T yc, int32_T yc_dim0, int32_T r_dim0)
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
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_r) + 1UL));
    yc.data[k + yc_dim0 * i1].re = r.data[i1 + r_dim0 * k].re;
    yc.data[k + yc_dim0 * i1].im = -r.data[i1 + r_dim0 * k].im;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_wt_fp_kernel11(
    const int32_T i1, const int32_T i2, const int32_T nx, int32_T sizeX[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    sizeX[nx] = div_s32_device(i2, i1) + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel12(
    const emxArray_creal32_T yc, const int32_T lshift_dim0, const int32_T i1,
    const int32_T b, const int32_T c, emxArray_creal32_T b_yc, int32_T yc_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    b_i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                                (static_cast<uint64_T>(b) + 1UL));
    b_yc.data[k + yc_dim0 * b_i1] = yc.data[i1 * k + lshift_dim0 * b_i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel13(
    const emxArray_creal32_T yc, const int32_T lshift, emxArray_creal32_T b_yc)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lshift);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    b_yc.data[i1] = yc.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel2(
    const emxArray_creal32_T r1, const int32_T b_r1, const int32_T c_r1,
    emxArray_creal32_T x, int32_T x_dim0, int32_T r1_dim0)
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
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r1) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_r1) + 1UL));
    x.data[k + x_dim0 * i1].re = r1.data[i1 + r1_dim0 * k].re;
    x.data[k + x_dim0 * i1].im = -r1.data[i1 + r1_dim0 * k].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel3(
    const emxArray_creal32_T x, const int32_T b, emxArray_real32_T yc)
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
    yc.data[k] = hypotf(x.data[k].re, x.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel4(
    const emxArray_real32_T yc, const int32_T b, emxArray_real32_T y)
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
    y.data[k] = yc.data[k] * yc.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel5(
    const emxArray_real32_T y, const int32_T b_y, emxArray_real32_T yc)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    yc.data[i1] = y.data[i1];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_wt_fp_kernel6(
    const int32_T i1, const int32_T i2, const int32_T nx, int32_T sizeX[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    sizeX[nx] = div_s32_device(i2, i1) + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel7(
    const emxArray_real32_T yc, const int32_T lshift_dim0, const int32_T i1,
    const int32_T b, const int32_T c, emxArray_real32_T b_yc, int32_T yc_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    b_i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                                (static_cast<uint64_T>(b) + 1UL));
    b_yc.data[k + yc_dim0 * b_i1] = yc.data[i1 * k + lshift_dim0 * b_i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel8(
    const emxArray_real32_T yc, const int32_T lshift, emxArray_real32_T b_yc)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lshift);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    b_yc.data[i1] = yc.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel9(
    const int32_T ch, const emxArray_real32_T x, const int32_T b_x,
    emxArray_real32_T c_x, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c_x.data[i1] = x.data[i1 + x_dim0 * ch];
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

static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu,
                                           const emxArray_creal32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA(
      "#loop#gpuEmxMemcpyCpuToGpu_creal32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
  checkCudaError(
      cudaMemcpy(gpu->data, cpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(creal32_T),
                 cudaMemcpyHostToDevice),
      __FILE__, __LINE__);
  nvtxRangePop();
}

static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyGpuToCpu_creal32_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA(
      "#loop#gpuEmxMemcpyGpuToCpu_creal32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
  checkCudaError(
      cudaMemcpy(cpu->data, gpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(creal32_T),
                 cudaMemcpyDeviceToHost),
      __FILE__, __LINE__);
  nvtxRangePop();
}

//
// function y = ec_wt_fp(x,fs,lims,voices,ds,doReal,doPwr)
void ec_wt_fp(const emxArray_real32_T *cpu_x, real_T fs, const real_T lims[2],
              real_T voices, real_T ds, boolean_T doReal, boolean_T doPwr,
              emxArray_cell_wrap_0 *y)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  dim3 block;
  dim3 grid;
  emxArray_creal32_T c_gpu_x;
  emxArray_creal32_T c_gpu_yc;
  emxArray_creal32_T d_gpu_yc;
  emxArray_creal32_T gpu_r;
  emxArray_creal32_T gpu_r1;
  emxArray_creal32_T *b_cpu_x;
  emxArray_creal32_T *b_cpu_yc;
  emxArray_creal32_T *c_cpu_yc;
  emxArray_creal32_T *cpu_r;
  emxArray_creal32_T *cpu_r1;
  emxArray_real32_T b_gpu_x;
  emxArray_real32_T b_gpu_yc;
  emxArray_real32_T d_gpu_x;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_y;
  emxArray_real32_T gpu_yc;
  emxArray_real32_T *c_cpu_x;
  emxArray_real32_T *cpu_y;
  emxArray_real32_T *cpu_yc;
  emxArray_real32_T *d_cpu_x;
  emxArray_real32_T *d_cpu_yc;
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
  int32_T b_i;
  int32_T i;
  char_T unusedExpr[23];
  boolean_T b_x_outdatedOnGpu;
  boolean_T r1_outdatedOnCpu;
  boolean_T r1_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnCpu;
  boolean_T x_outdatedOnGpu;
  nvtxMarkA("#entryPointStart#");
  nvtxRangePushA("#entryPointFcn#ec_wt_fp#" MW_AT_LOCATION);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_lshift, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_sizeX, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_yc);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&d_gpu_yc);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_x);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&d_gpu_x);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_r1);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_r);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&c_gpu_x);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&c_gpu_yc);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_yc);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_x);
  r1_outdatedOnCpu = false;
  r1_outdatedOnGpu = false;
  x_outdatedOnGpu = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  //  [electroCUDA] CWT - CUDA mex source
  //    Called by function 'ec_wt' (see for details)
  //    Intended to be compiled into a CUDA mex binary
  //    Kevin Tan, 2024 (github.com/kevmtan/electroCUDA)
  // 'ec_wt_fp:7' x (:,:){mustBeFloat}
  //  Input data
  // 'ec_wt_fp:8' fs (1,1) double
  //  Sampling rate
  // 'ec_wt_fp:9' lims (1,2) double
  //  Frequency limits
  // 'ec_wt_fp:10' voices (1,1) double = 10
  //  Voices per octave
  // 'ec_wt_fp:11' ds (1,1) double = 0
  //  Downsampling factor
  // 'ec_wt_fp:12' doReal (1,1) logical = true
  //  Real output? (complex otherwise)
  // 'ec_wt_fp:13' doPwr (1,1) logical = false
  //  Power output? (magnitude otherwise)
  // 'ec_wt_fp:15' if ds<=1
  if (ds <= 1.0) {
    // 'ec_wt_fp:15' ;
    // 'ec_wt_fp:15' ds=0;
    ds = 0.0;
  }
  //  Prep
  // 'ec_wt_fp:18' coder.gpu.kernelfun;
  //  Trigger CUDA kernel creation
  //  Sizes
  // 'ec_wt_fp:21' nChs = width(x);
  //  Preallocate output
  // 'ec_wt_fp:24' y = coder.nullcopy(cell(1,nChs));
  i = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = cpu_x->size[1];
  nvtxMarkA("#emxEnsureCapacity_cell_wrap_0#" MW_AT_LINE);
  emxEnsureCapacity_cell_wrap_0(y, i, &c_emlrtRTEI);
  //  Processing loop across channels
  // 'ec_wt_fp:28' for ch = 1:nChs
  b_i = cpu_x->size[1];
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_yc, 2, &p_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&b_cpu_yc, 2, &q_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&b_cpu_x, 2, &g_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_y, 2, &r_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_r, 2, &s_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_r1, 2, &g_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_cpu_x, 1, &d_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&d_cpu_x, 1, &e_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&c_cpu_yc, 2, &k_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&d_cpu_yc, 2, &k_emlrtRTEI, true);
  profileLoopStart("ec_wt_fp_loop_0", __LINE__, (b_i - 1) + 1, "");
  for (int32_T ch{0}; ch < b_i; ch++) {
    // 'ec_wt_fp:29' if doReal
    if (doReal) {
      int32_T i1;
      int32_T nx;
      uint32_T dv[2];
      boolean_T validLaunchParams;
      // 'ec_wt_fp:30' y{ch} = cwtR_lfn(x(:,ch),fs,lims,voices,ds,doPwr);
      //  Run CWT (magnitude/power)
      //  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CWT - magnitude out
      // 'ec_wt_fp:55' yc =
      // abs(cwt(xc,"morse",fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices)');
      i = d_cpu_x->size[0];
      d_cpu_x->size[0] = cpu_x->size[0];
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(d_cpu_x, i, &e_emlrtRTEI);
      i = cpu_x->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      if (x_needsGpuEnsureCapacity) {
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
      }
      x_needsGpuEnsureCapacity = false;
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(d_cpu_x, &b_gpu_x, true);
      if (x_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
      }
      x_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel1#" MW_AT_LINE);
        ec_wt_fp_kernel1<<<grid, block>>>(ch, gpu_x, i, b_gpu_x,
                                          cpu_x->size[0U]);
      }
      b_x_outdatedOnGpu = false;
      nvtxMarkA("#cwt#" MW_AT_LINE);
      coder::cwt(d_cpu_x, &b_gpu_x, &b_x_outdatedOnGpu, fs, lims, voices,
                 cpu_r1, &r1_outdatedOnCpu, &gpu_r1, &r1_outdatedOnGpu);
      i = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = cpu_r1->size[1];
      b_cpu_x->size[1] = cpu_r1->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(b_cpu_x, i, &g_emlrtRTEI);
      i = cpu_r1->size[0] - 1;
      nx = cpu_r1->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i, nx), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(cpu_r1, &gpu_r1, !r1_outdatedOnGpu);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(b_cpu_x, &c_gpu_x, true);
      if (r1_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_r1, cpu_r1);
      }
      r1_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel2#" MW_AT_LINE);
        ec_wt_fp_kernel2<<<grid, block>>>(gpu_r1, nx, i, c_gpu_x,
                                          b_cpu_x->size[0U], cpu_r1->size[0U]);
      }
      nx = b_cpu_x->size[0] * b_cpu_x->size[1];
      profileLoopStart("ec_wt_fp_loop_1", __LINE__, 1 + 1, "");
      for (i1 = 0; i1 < 2; i1++) {
        dv[i1] = static_cast<uint32_T>(b_cpu_x->size[i1]);
      }
      profileLoopEnd();
      i = cpu_yc->size[0] * cpu_yc->size[1];
      cpu_yc->size[0] = static_cast<int32_T>(dv[0]);
      cpu_yc->size[1] = static_cast<int32_T>(dv[1]);
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(cpu_yc, i, &i_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_yc, &gpu_yc, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel3#" MW_AT_LINE);
        ec_wt_fp_kernel3<<<grid, block>>>(c_gpu_x, nx - 1, gpu_yc);
      }
      r1_outdatedOnCpu = true;
      //  Convert to power
      // 'ec_wt_fp:58' if doPwr
      if (doPwr) {
        uint32_T yc[2];
        // 'ec_wt_fp:59' yc = yc.^2;
        yc[0] = static_cast<uint32_T>(cpu_yc->size[0]);
        yc[1] = static_cast<uint32_T>(cpu_yc->size[1]);
        profileLoopStart("ec_wt_fp_loop_4", __LINE__, 1 + 1, "");
        for (i1 = 0; i1 < 2; i1++) {
          dv[i1] = yc[i1];
        }
        profileLoopEnd();
        i = cpu_y->size[0] * cpu_y->size[1];
        cpu_y->size[0] = static_cast<int32_T>(dv[0]);
        cpu_y->size[1] = static_cast<int32_T>(dv[1]);
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(cpu_y, i, &l_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(
            computeNumIters(
                static_cast<int32_T>(dv[0]) * static_cast<int32_T>(dv[1]) - 1),
            &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_y, &gpu_y, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel4#" MW_AT_LINE);
          ec_wt_fp_kernel4<<<grid, block>>>(
              gpu_yc,
              static_cast<int32_T>(dv[0]) * static_cast<int32_T>(dv[1]) - 1,
              gpu_y);
        }
        i = cpu_yc->size[0] * cpu_yc->size[1];
        cpu_yc->size[0] = cpu_y->size[0];
        cpu_yc->size[1] = cpu_y->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(cpu_yc, i, &m_emlrtRTEI);
        i = cpu_y->size[0] * cpu_y->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_yc, &gpu_yc, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel5#" MW_AT_LINE);
          ec_wt_fp_kernel5<<<grid, block>>>(gpu_y, i, gpu_yc);
        }
      }
      //  Downsample
      // 'ec_wt_fp:63' if ds
      if (ds != 0.0) {
        int32_T cpu_lshift[2];
        int32_T cpu_sizeX[2];
        // 'ec_wt_fp:64' yc = downsample(yc,ds);
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
        nx = 1;
        if (cpu_yc->size[0] != 1) {
          nx = 0;
        }
        r1_outdatedOnGpu = false;
        b_x_outdatedOnGpu = false;
        x_outdatedOnCpu = false;
        profileLoopStart("ec_wt_fp_loop_6", __LINE__, 1 + 1, "");
        for (i1 = 0; i1 < 2; i1++) {
          cpu_sizeX[i1] = cpu_yc->size[i1];
          r1_outdatedOnGpu = true;
          cpu_lshift[i1] = cpu_yc->size[i1];
          x_outdatedOnCpu = true;
        }
        profileLoopEnd();
        nvtxMarkA("#circshift#" MW_AT_LINE);
        coder::circshift(cpu_lshift, &b_x_outdatedOnGpu, *gpu_lshift,
                         &x_outdatedOnCpu, -nx);
        if (b_x_outdatedOnGpu) {
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(
              cudaMemcpy(cpu_lshift, *gpu_lshift, 8UL, cudaMemcpyDeviceToHost),
              __FILE__, __LINE__);
        }
        if ((ds > 0.0) && (cpu_lshift[0] < 1)) {
          i1 = 1;
          i = -1;
        } else {
          i1 = static_cast<int32_T>(ds);
          i = cpu_lshift[0] - 1;
        }
        if (r1_outdatedOnGpu) {
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(
              cudaMemcpy(*gpu_sizeX, cpu_sizeX, 8UL, cudaMemcpyHostToDevice),
              __FILE__, __LINE__);
        }
        nvtxMarkA("#ec_wt_fp_kernel6#" MW_AT_LINE);
        ec_wt_fp_kernel6<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i1, i, nx,
                                                                  *gpu_sizeX);
        nx = d_cpu_yc->size[0] * d_cpu_yc->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        d_cpu_yc->size[0] = div_s32(i, i1) + 1;
        d_cpu_yc->size[1] = cpu_lshift[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(d_cpu_yc, nx, &k_emlrtRTEI);
        i /= i1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(cpu_lshift[1] - 1, i), &grid,
                                &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(d_cpu_yc, &b_gpu_yc, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel7#" MW_AT_LINE);
          ec_wt_fp_kernel7<<<grid, block>>>(gpu_yc, cpu_lshift[0], i1, i,
                                            cpu_lshift[1] - 1, b_gpu_yc,
                                            d_cpu_yc->size[0U]);
        }
        nvtxMarkA("#checkCudaError#" MW_AT_LINE);
        nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
        checkCudaError(
            cudaMemcpy(cpu_sizeX, *gpu_sizeX, 8UL, cudaMemcpyDeviceToHost),
            __FILE__, __LINE__);
        i = cpu_yc->size[0] * cpu_yc->size[1];
        cpu_yc->size[0] = cpu_sizeX[0];
        cpu_yc->size[1] = cpu_sizeX[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(cpu_yc, i, &o_emlrtRTEI);
        i = cpu_sizeX[0] * cpu_sizeX[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_yc, &gpu_yc, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel8#" MW_AT_LINE);
          ec_wt_fp_kernel8<<<grid, block>>>(b_gpu_yc, i, gpu_yc);
        }
      }
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[0] = cpu_yc->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(y->data[ch].f1, i, &j_emlrtRTEI);
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[1] = cpu_yc->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(y->data[ch].f1, i, &j_emlrtRTEI);
      profileLoopStart("ec_wt_fp_loop_5", __LINE__,
                       (cpu_yc->size[0] * cpu_yc->size[1] - 1) + 1, "");
      for (i = 0; i < cpu_yc->size[0] * cpu_yc->size[1]; i++) {
        if (r1_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_yc, &gpu_yc);
        }
        r1_outdatedOnCpu = false;
        y->data[ch].f1->data[i].re = cpu_yc->data[i];
        y->data[ch].f1->data[i].im = 0.0F;
      }
      profileLoopEnd();
    } else {
      int32_T nx;
      boolean_T validLaunchParams;
      // 'ec_wt_fp:31' else
      // 'ec_wt_fp:32' y{ch} = cwt_lfn(x(:,ch),fs,lims,voices,ds);
      //  Run CWT (complex)
      //  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CWT
      // 'ec_wt_fp:43' yc =
      // cwt(xc,"morse",fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices)';
      i = c_cpu_x->size[0];
      c_cpu_x->size[0] = cpu_x->size[0];
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(c_cpu_x, i, &d_emlrtRTEI);
      i = cpu_x->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      if (x_needsGpuEnsureCapacity) {
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
      }
      x_needsGpuEnsureCapacity = false;
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(c_cpu_x, &d_gpu_x, true);
      if (x_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
      }
      x_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel9#" MW_AT_LINE);
        ec_wt_fp_kernel9<<<grid, block>>>(ch, gpu_x, i, d_gpu_x,
                                          cpu_x->size[0U]);
      }
      b_x_outdatedOnGpu = false;
      nvtxMarkA("#cwt#" MW_AT_LINE);
      coder::cwt(c_cpu_x, &d_gpu_x, &b_x_outdatedOnGpu, fs, lims, voices, cpu_r,
                 &r1_outdatedOnCpu, &gpu_r, &r1_outdatedOnGpu);
      i = b_cpu_yc->size[0] * b_cpu_yc->size[1];
      b_cpu_yc->size[0] = cpu_r->size[1];
      b_cpu_yc->size[1] = cpu_r->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(b_cpu_yc, i, &f_emlrtRTEI);
      i = cpu_r->size[0] - 1;
      nx = cpu_r->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i, nx), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(cpu_r, &gpu_r, !r1_outdatedOnGpu);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(b_cpu_yc, &c_gpu_yc, true);
      if (r1_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_r, cpu_r);
      }
      r1_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel10#" MW_AT_LINE);
        ec_wt_fp_kernel10<<<grid, block>>>(gpu_r, nx, i, c_gpu_yc,
                                           b_cpu_yc->size[0U], cpu_r->size[0U]);
      }
      r1_outdatedOnCpu = true;
      //  Downsample
      // 'ec_wt_fp:46' if ds
      if (ds != 0.0) {
        int32_T cpu_lshift[2];
        int32_T cpu_sizeX[2];
        int32_T i1;
        // 'ec_wt_fp:47' yc = downsample(yc,ds);
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
        nx = 1;
        if (b_cpu_yc->size[0] != 1) {
          nx = 0;
        }
        r1_outdatedOnGpu = false;
        b_x_outdatedOnGpu = false;
        x_outdatedOnCpu = false;
        profileLoopStart("ec_wt_fp_loop_3", __LINE__, 1 + 1, "");
        for (i1 = 0; i1 < 2; i1++) {
          cpu_sizeX[i1] = b_cpu_yc->size[i1];
          r1_outdatedOnGpu = true;
          cpu_lshift[i1] = b_cpu_yc->size[i1];
          x_outdatedOnCpu = true;
        }
        profileLoopEnd();
        nvtxMarkA("#circshift#" MW_AT_LINE);
        coder::circshift(cpu_lshift, &b_x_outdatedOnGpu, *gpu_lshift,
                         &x_outdatedOnCpu, -nx);
        if (b_x_outdatedOnGpu) {
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(
              cudaMemcpy(cpu_lshift, *gpu_lshift, 8UL, cudaMemcpyDeviceToHost),
              __FILE__, __LINE__);
        }
        if ((ds > 0.0) && (cpu_lshift[0] < 1)) {
          i1 = 1;
          i = -1;
        } else {
          i1 = static_cast<int32_T>(ds);
          i = cpu_lshift[0] - 1;
        }
        if (r1_outdatedOnGpu) {
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(
              cudaMemcpy(*gpu_sizeX, cpu_sizeX, 8UL, cudaMemcpyHostToDevice),
              __FILE__, __LINE__);
        }
        nvtxMarkA("#ec_wt_fp_kernel11#" MW_AT_LINE);
        ec_wt_fp_kernel11<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i1, i, nx,
                                                                   *gpu_sizeX);
        nx = c_cpu_yc->size[0] * c_cpu_yc->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        c_cpu_yc->size[0] = div_s32(i, i1) + 1;
        c_cpu_yc->size[1] = cpu_lshift[1];
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(c_cpu_yc, nx, &k_emlrtRTEI);
        i /= i1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(cpu_lshift[1] - 1, i), &grid,
                                &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(c_cpu_yc, &d_gpu_yc, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel12#" MW_AT_LINE);
          ec_wt_fp_kernel12<<<grid, block>>>(c_gpu_yc, cpu_lshift[0], i1, i,
                                             cpu_lshift[1] - 1, d_gpu_yc,
                                             c_cpu_yc->size[0U]);
        }
        nvtxMarkA("#checkCudaError#" MW_AT_LINE);
        nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
        checkCudaError(
            cudaMemcpy(cpu_sizeX, *gpu_sizeX, 8UL, cudaMemcpyDeviceToHost),
            __FILE__, __LINE__);
        i = b_cpu_yc->size[0] * b_cpu_yc->size[1];
        b_cpu_yc->size[0] = cpu_sizeX[0];
        b_cpu_yc->size[1] = cpu_sizeX[1];
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(b_cpu_yc, i, &n_emlrtRTEI);
        i = cpu_sizeX[0] * cpu_sizeX[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(b_cpu_yc, &c_gpu_yc, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel13#" MW_AT_LINE);
          ec_wt_fp_kernel13<<<grid, block>>>(d_gpu_yc, i, c_gpu_yc);
        }
      }
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[0] = b_cpu_yc->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(y->data[ch].f1, i, &h_emlrtRTEI);
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[1] = b_cpu_yc->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(y->data[ch].f1, i, &h_emlrtRTEI);
      profileLoopStart("ec_wt_fp_loop_2", __LINE__,
                       (b_cpu_yc->size[0] * b_cpu_yc->size[1] - 1) + 1, "");
      for (i = 0; i < b_cpu_yc->size[0] * b_cpu_yc->size[1]; i++) {
        if (r1_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_creal32_T(b_cpu_yc, &c_gpu_yc);
        }
        r1_outdatedOnCpu = false;
        y->data[ch].f1->data[i] = b_cpu_yc->data[i];
      }
      profileLoopEnd();
    }
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&d_cpu_yc);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&c_cpu_yc);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&d_cpu_x);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_cpu_x);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_r1);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_r);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_y);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&b_cpu_x);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&b_cpu_yc);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_yc);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_x);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_yc);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&c_gpu_yc);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&c_gpu_x);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_r);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_r1);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&d_gpu_x);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_x);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&d_gpu_yc);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_yc);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(*gpu_sizeX), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(*gpu_lshift), __FILE__, __LINE__);
  nvtxRangePop();
  nvtxMarkA("#entryPointEnd#");
}

// End of code generation (ec_wt_fp.cu)
