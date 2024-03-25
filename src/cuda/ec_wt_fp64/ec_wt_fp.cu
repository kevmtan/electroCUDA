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
#include "cwtfilterbank.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "rt_nonfinite.h"
#include "scaleSpectrum.h"
#include "wt.h"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Variable Definitions
static emlrtMCInfo c_emlrtMCI{
    53,        // lineNo
    19,        // colNo
    "flt2str", // fName
    "/usr/local/MATLAB/R2024a/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "flt2str.m" // pName
};

static emlrtRTEInfo emlrtRTEI{
    30,                                                     // lineNo
    1,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    39,                                                     // lineNo
    24,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    41,                                                     // lineNo
    24,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    47,                                                     // lineNo
    30,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    49,                                                     // lineNo
    32,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    47,                                                     // lineNo
    19,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    63,                                                     // lineNo
    14,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    61,                                                     // lineNo
    14,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    75,                                                           // lineNo
    13,                                                           // colNo
    "downsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/downsample.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    287,             // lineNo
    33,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo n_emlrtRTEI{
    91,                                                           // lineNo
    14,                                                           // colNo
    "downsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/downsample.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    181,                     // lineNo
    24,                      // colNo
    "combineVectorElements", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/"
    "combineVectorElements.m" // pName
};

static emlrtRTEInfo p_emlrtRTEI{
    49,                                                     // lineNo
    21,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo q_emlrtRTEI{
    287,             // lineNo
    25,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo r_emlrtRTEI{
    28,                                                     // lineNo
    1,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo t_emlrtRTEI{
    61,                                                     // lineNo
    10,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    47,                                                     // lineNo
    9,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo v_emlrtRTEI{
    267,             // lineNo
    36,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo w_emlrtRTEI{
    49,                                                     // lineNo
    9,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo x_emlrtRTEI{
    282,             // lineNo
    9,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo y_emlrtRTEI{
    287,             // lineNo
    29,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo ab_emlrtRTEI{
    78,                                                     // lineNo
    10,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
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

static __global__ void ec_wt_fp_kernel1(const int32_T ch,
                                        const emxArray_real_T x,
                                        const int32_T b_x, emxArray_real_T xc,
                                        int32_T x_dim0);

static __global__ void ec_wt_fp_kernel10(const emxArray_real_T b_dv,
                                         const real_T ds, const int32_T b,
                                         emxArray_real_T c_dv);

static __global__ void ec_wt_fp_kernel11(const emxArray_real_T b_dv,
                                         const int32_T c_dv,
                                         emxArray_real_T d_dv);

static __global__ void ec_wt_fp_kernel12(const emxArray_real_T b_dv,
                                         const int32_T ch,
                                         const int32_T lshift_dim0,
                                         const int32_T b, emxArray_real_T y);

static __global__ void ec_wt_fp_kernel13(const int32_T vlen,
                                         const emxArray_real_T x,
                                         const int32_T b, emxArray_real_T b_b,
                                         int32_T x_dim0);

static __global__ void ec_wt_fp_kernel14(const emxArray_real_T r,
                                         const int32_T b_r,
                                         emxArray_real_T b_dv);

static __global__ void ec_wt_fp_kernel15(const int32_T ch,
                                         const emxArray_real_T x,
                                         const int32_T b_x, emxArray_real_T xc,
                                         int32_T x_dim0);

static __global__ void ec_wt_fp_kernel16(const emxArray_creal_T r2,
                                         const int32_T b_r2, const int32_T c_r2,
                                         emxArray_creal_T x, int32_T x_dim0,
                                         int32_T r2_dim0);

static __global__ void ec_wt_fp_kernel17(const emxArray_creal_T x,
                                         const int32_T b, emxArray_real_T y);

static __global__ void ec_wt_fp_kernel18(const emxArray_real_T y,
                                         const int32_T b, emxArray_real_T dv4);

static __global__ void ec_wt_fp_kernel19(const int32_T shiftLen,
                                         const int32_T b, int32_T lshift[2]);

static __global__ void ec_wt_fp_kernel2(const emxArray_creal_T cfs,
                                        const int32_T b, emxArray_real_T y);

static __global__ void ec_wt_fp_kernel20(const int32_T vlen,
                                         const int32_T shiftLen,
                                         const int32_T dim, int32_T sizeX[2]);

static __global__ void ec_wt_fp_kernel21(const emxArray_real_T dv4,
                                         const int32_T lshift_dim0,
                                         const int32_T vlen, const int32_T b,
                                         const int32_T c, emxArray_real_T b_dv4,
                                         int32_T dv4_dim0);

static __global__ void ec_wt_fp_kernel22(const emxArray_real_T dv4,
                                         const int32_T lshift,
                                         emxArray_real_T b_dv4);

static __global__ void ec_wt_fp_kernel23(const emxArray_real_T dv4,
                                         const int32_T y_dim0, const int32_T ch,
                                         const int32_T y, const int32_T b_y,
                                         emxArray_real_T c_y, int32_T b_y_dim0,
                                         int32_T y_dim1);

static __global__ void ec_wt_fp_kernel24(const emxArray_creal_T r1,
                                         const int32_T b_r1, const int32_T c_r1,
                                         emxArray_creal_T x, int32_T x_dim0,
                                         int32_T r1_dim0);

static __global__ void ec_wt_fp_kernel25(const emxArray_creal_T x,
                                         const int32_T b, emxArray_real_T dv4);

static __global__ void ec_wt_fp_kernel3(const emxArray_real_T y,
                                        const int32_T b, emxArray_real_T x);

static __global__ void ec_wt_fp_kernel4(const real_T nFrames,
                                        const emxArray_creal_T cfs,
                                        const int32_T nx, const int32_T cfsnorm,
                                        const int32_T vlen,
                                        emxArray_creal_T b_cfsnorm,
                                        int32_T cfs_dim0, int32_T cfsnorm_dim0);

static __global__ void ec_wt_fp_kernel5(const emxArray_creal_T cfsnorm,
                                        const int32_T b,
                                        const int32_T b_cfsnorm,
                                        emxArray_creal_T x, int32_T x_dim0,
                                        int32_T cfsnorm_dim0);

static __global__ void ec_wt_fp_kernel6(const emxArray_creal_T x,
                                        const int32_T b, emxArray_real_T y);

static __global__ void ec_wt_fp_kernel7(const emxArray_real_T y,
                                        const int32_T b, emxArray_real_T x);

static __global__ void ec_wt_fp_kernel8(const int32_T sz, emxArray_real_T b);

static __global__ void ec_wt_fp_kernel9(const emxArray_real_T b,
                                        const real_T nFrames, const int32_T b_b,
                                        emxArray_real_T b_dv);

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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel1(
    const int32_T ch, const emxArray_real_T x, const int32_T b_x,
    emxArray_real_T xc, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    xc.data[xpageoffset] = x.data[xpageoffset + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel10(
    const emxArray_real_T b_dv, const real_T ds, const int32_T b,
    emxArray_real_T c_dv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    c_dv.data[xpageoffset] = b_dv.data[static_cast<int32_T>(ds) * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel11(
    const emxArray_real_T b_dv, const int32_T c_dv, emxArray_real_T d_dv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_dv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    d_dv.data[xpageoffset] = b_dv.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel12(
    const emxArray_real_T b_dv, const int32_T ch, const int32_T lshift_dim0,
    const int32_T b, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    y.data[xpageoffset + lshift_dim0 * ch] = b_dv.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel13(
    const int32_T vlen, const emxArray_real_T x, const int32_T b,
    emxArray_real_T b_b, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T xpageoffset;
    bcoef = static_cast<int32_T>(idx);
    xpageoffset = bcoef * x_dim0;
    b_b.data[bcoef] = x.data[xpageoffset];
    for (int32_T k{0}; k <= vlen - 2; k++) {
      b_b.data[bcoef] += x.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel14(
    const emxArray_real_T r, const int32_T b_r, emxArray_real_T b_dv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_r);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    b_dv.data[xpageoffset] = r.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel15(
    const int32_T ch, const emxArray_real_T x, const int32_T b_x,
    emxArray_real_T xc, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    xc.data[xpageoffset] = x.data[xpageoffset + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel16(
    const emxArray_creal_T r2, const int32_T b_r2, const int32_T c_r2,
    emxArray_creal_T x, int32_T x_dim0, int32_T r2_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_r2) + 1UL) *
                (static_cast<uint64_T>(b_r2) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T xpageoffset;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r2) + 1UL));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) /
                                       (static_cast<uint64_T>(b_r2) + 1UL));
    x.data[bcoef + x_dim0 * xpageoffset].re =
        r2.data[xpageoffset + r2_dim0 * bcoef].re;
    x.data[bcoef + x_dim0 * xpageoffset].im =
        -r2.data[xpageoffset + r2_dim0 * bcoef].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel17(
    const emxArray_creal_T x, const int32_T b, emxArray_real_T y)
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
    y.data[k] = hypot(x.data[k].re, x.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel18(
    const emxArray_real_T y, const int32_T b, emxArray_real_T dv4)
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
    dv4.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel19(
    const int32_T shiftLen, const int32_T b, int32_T lshift[2])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = lshift[0];
    lshift[0] = lshift[1 - shiftLen];
    lshift[1 - shiftLen] = bcoef;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel2(
    const emxArray_creal_T cfs, const int32_T b, emxArray_real_T y)
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
    y.data[k] = hypot(cfs.data[k].re, cfs.data[k].im);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_wt_fp_kernel20(
    const int32_T vlen, const int32_T shiftLen, const int32_T dim,
    int32_T sizeX[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    sizeX[dim - 1] = div_s32_device(shiftLen, vlen) + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel21(
    const emxArray_real_T dv4, const int32_T lshift_dim0, const int32_T vlen,
    const int32_T b, const int32_T c, emxArray_real_T b_dv4, int32_T dv4_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T xpageoffset;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) /
                                       (static_cast<uint64_T>(b) + 1UL));
    b_dv4.data[bcoef + dv4_dim0 * xpageoffset] =
        dv4.data[vlen * bcoef + lshift_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel22(
    const emxArray_real_T dv4, const int32_T lshift, emxArray_real_T b_dv4)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lshift);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    b_dv4.data[xpageoffset] = dv4.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel23(
    const emxArray_real_T dv4, const int32_T y_dim0, const int32_T ch,
    const int32_T y, const int32_T b_y, emxArray_real_T c_y, int32_T b_y_dim0,
    int32_T y_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>(y) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T xpageoffset;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(y) + 1UL));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) /
                                       (static_cast<uint64_T>(y) + 1UL));
    c_y.data[(bcoef + b_y_dim0 * ch) + b_y_dim0 * y_dim1 * xpageoffset] =
        dv4.data[bcoef + y_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel24(
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
    int32_T bcoef;
    int32_T xpageoffset;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r1) + 1UL));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) /
                                       (static_cast<uint64_T>(b_r1) + 1UL));
    x.data[bcoef + x_dim0 * xpageoffset].re =
        r1.data[xpageoffset + r1_dim0 * bcoef].re;
    x.data[bcoef + x_dim0 * xpageoffset].im =
        -r1.data[xpageoffset + r1_dim0 * bcoef].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel25(
    const emxArray_creal_T x, const int32_T b, emxArray_real_T dv4)
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
    dv4.data[k] = hypot(x.data[k].re, x.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel3(
    const emxArray_real_T y, const int32_T b, emxArray_real_T x)
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
    x.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel4(
    const real_T nFrames, const emxArray_creal_T cfs, const int32_T nx,
    const int32_T cfsnorm, const int32_T vlen, emxArray_creal_T b_cfsnorm,
    int32_T cfs_dim0, int32_T cfsnorm_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(vlen) + 1UL) *
                (static_cast<uint64_T>(cfsnorm) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_k;
    int32_T bcoef;
    int32_T k;
    int32_T xpageoffset;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(cfsnorm) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) /
                             (static_cast<uint64_T>(cfsnorm) + 1UL));
    xpageoffset = nx * k + 1;
    bcoef = static_cast<int32_T>(cfs_dim0 != 1);
    b_cfsnorm.data[b_k + cfsnorm_dim0 * k].re =
        nFrames * cfs.data[bcoef * b_k + cfs_dim0 * (xpageoffset - 1)].re;
    b_cfsnorm.data[b_k + cfsnorm_dim0 * k].im =
        nFrames * cfs.data[bcoef * b_k + cfs_dim0 * (xpageoffset - 1)].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel5(
    const emxArray_creal_T cfsnorm, const int32_T b, const int32_T b_cfsnorm,
    emxArray_creal_T x, int32_T x_dim0, int32_T cfsnorm_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_cfsnorm) + 1UL) *
                (static_cast<uint64_T>(b) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T xpageoffset;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) /
                                       (static_cast<uint64_T>(b) + 1UL));
    x.data[bcoef + x_dim0 * xpageoffset] =
        cfsnorm.data[bcoef + cfsnorm_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel6(
    const emxArray_creal_T x, const int32_T b, emxArray_real_T y)
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
    y.data[k] = hypot(x.data[k].re, x.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel7(
    const emxArray_real_T y, const int32_T b, emxArray_real_T x)
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
    x.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void ec_wt_fp_kernel8(const int32_T sz,
                                                             emxArray_real_T b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    b.data[xpageoffset] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel9(
    const emxArray_real_T b, const real_T nFrames, const int32_T b_b,
    emxArray_real_T b_dv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    b_dv.data[xpageoffset] = nFrames * b.data[xpageoffset];
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
// function [y,freqs] = ec_wt_fp(x,fs,fLims,fVoices,ds,doAvg,doPwr)
void ec_wt_fp(const emxArray_real_T *cpu_x, real_T fs, const real_T fLims[2],
              real_T fVoices, real_T ds, boolean_T doAvg, boolean_T doPwr,
              emxArray_real_T *cpu_y, emxArray_real_T *freqs)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  coder::cwtfilterbank fb;
  dim3 block;
  dim3 grid;
  emxArray_creal_T c_gpu_x;
  emxArray_creal_T e_gpu_x;
  emxArray_creal_T f_gpu_x;
  emxArray_creal_T gpu_cfs;
  emxArray_creal_T gpu_cfsnorm;
  emxArray_creal_T gpu_r1;
  emxArray_creal_T gpu_r2;
  emxArray_creal_T *b_cpu_x;
  emxArray_creal_T *c_cpu_x;
  emxArray_creal_T *cpu_cfs;
  emxArray_creal_T *cpu_cfsnorm;
  emxArray_creal_T *cpu_r1;
  emxArray_creal_T *cpu_r2;
  emxArray_creal_T *e_cpu_x;
  emxArray_real_T b_gpu_dv;
  emxArray_real_T b_gpu_dv4;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_xc;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_x;
  emxArray_real_T d_gpu_y;
  emxArray_real_T gpu_b;
  emxArray_real_T gpu_dv;
  emxArray_real_T gpu_dv4;
  emxArray_real_T gpu_r;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xc;
  emxArray_real_T gpu_y;
  emxArray_real_T *b_cpu_dv;
  emxArray_real_T *b_cpu_dv4;
  emxArray_real_T *b_cpu_xc;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_b;
  emxArray_real_T *cpu_dv;
  emxArray_real_T *cpu_dv4;
  emxArray_real_T *cpu_r;
  emxArray_real_T *cpu_xc;
  emxArray_real_T *d_cpu_x;
  emxArray_real_T *d_cpu_y;
  emxArray_real_T *f_cpu_x;
  const mxArray *b_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *y;
  real_T nFrames;
  int32_T(*gpu_lshift)[2];
  int32_T(*gpu_sizeX)[2];
  int32_T dim;
  int32_T i;
  char_T unusedExpr[23];
  boolean_T r_outdatedOnCpu;
  boolean_T r_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  nvtxMarkA("#entryPointStart#");
  nvtxRangePushA("#entryPointFcn#ec_wt_fp#" MW_AT_LOCATION);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_lshift, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_sizeX, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_dv4);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_dv);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_r2);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_r1);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_r);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_b);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&d_gpu_x);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&c_gpu_x);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_cfsnorm);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_x);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_dv4);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&e_gpu_x);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&f_gpu_x);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_dv);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&d_gpu_y);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_cfs);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_xc);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_xc);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_x);
  r_outdatedOnGpu = false;
  x_outdatedOnGpu = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInitStruct_cwtfilterbank#" MW_AT_LINE);
  emxInitStruct_cwtfilterbank(&fb, &r_emlrtRTEI, true);
  //  electroCUDA - run Continuous WAvelet Transform
  //    Intended to be compiled into a CUDA mex binary
  //    Kevin Tan, 2024 (github.com/kevmtan/electroCUDA)
  //
  //  OUTPUTS:
  //    y = transformed data
  //    freqs = CWT frequencies
  // 'ec_wt_fp:10' x (:,:){mustBeFloat}
  //  Input data
  // 'ec_wt_fp:11' fs (1,1) double
  //  Sampling rate
  // 'ec_wt_fp:12' fLims (1,2) double
  //  Frequency limits
  // 'ec_wt_fp:13' fVoices (1,1) double = 10
  //  Voices per octave
  // 'ec_wt_fp:14' ds (1,1) double = 0
  //  Downsampling factor
  // 'ec_wt_fp:15' doAvg (1,1) logical = false
  //  Transform [0=continuous|1=averaged]
  // 'ec_wt_fp:16' doPwr (1,1) logical = false
  //  Output [0=magnitude|1=output]
  // 'ec_wt_fp:18' if ds<=1
  if (ds <= 1.0) {
    // 'ec_wt_fp:18' ;
    // 'ec_wt_fp:18' ds=0;
    ds = 0.0;
  }
  //  Prep
  // 'ec_wt_fp:21' coder.gpu.kernelfun;
  //  Trigger CUDA kernel creation
  //  Sizes
  // 'ec_wt_fp:24' nFrames = height(x);
  nFrames = cpu_x->size[0];
  // 'ec_wt_fp:25' nChs = width(x);
  //  Make CWT filter
  // 'ec_wt_fp:28' fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
  // 'ec_wt_fp:29'
  // SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);
  nvtxMarkA("#cwtfilterbank_cwtfilterbank#" MW_AT_LINE);
  coder::cwtfilterbank_cwtfilterbank(&fb, static_cast<real_T>(cpu_x->size[0]),
                                     fs, fLims, fVoices);
  // 'ec_wt_fp:30' freqs = centerFrequencies(fb);
  dim = freqs->size[0];
  freqs->size[0] = fb.WaveletCenterFrequencies->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(freqs, dim, &emlrtRTEI);
  profileLoopStart("ec_wt_fp_loop_0", __LINE__,
                   (fb.WaveletCenterFrequencies->size[0] - 1) + 1, "");
  for (dim = 0; dim < fb.WaveletCenterFrequencies->size[0]; dim++) {
    freqs->data[dim] = fb.WaveletCenterFrequencies->data[dim];
  }
  profileLoopEnd();
  //  Find output frames
  // 'ec_wt_fp:33' if ds
  if (ds != 0.0) {
    // 'ec_wt_fp:34' nFrames = floor(nFrames/ds);
    nFrames = std::floor(static_cast<real_T>(cpu_x->size[0]) / ds);
  }
  //  Preallocate output
  // 'ec_wt_fp:38' if doAvg
  if (doAvg) {
    // 'ec_wt_fp:39' y = coder.nullcopy(nan(nFrames,nChs,like=x));
    r_outdatedOnCpu = false;
    dim = cpu_y->size[0] * cpu_y->size[1] * cpu_y->size[2];
    cpu_y->size[0] = static_cast<int32_T>(nFrames);
    cpu_y->size[1] = cpu_x->size[1];
    cpu_y->size[2] = 1;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_y, dim, &b_emlrtRTEI);
    y_needsGpuEnsureCapacity = true;
  } else {
    // 'ec_wt_fp:40' else
    // 'ec_wt_fp:41' y = coder.nullcopy(nan(nFrames,nChs,numel(freqs),like=x));
    r_outdatedOnCpu = false;
    dim = cpu_y->size[0] * cpu_y->size[1] * cpu_y->size[2];
    cpu_y->size[0] = static_cast<int32_T>(nFrames);
    cpu_y->size[1] = cpu_x->size[1];
    cpu_y->size[2] = freqs->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_y, dim, &c_emlrtRTEI);
    y_needsGpuEnsureCapacity = true;
  }
  //  Processing loop across channels
  // 'ec_wt_fp:45' for ch = 1:nChs
  i = cpu_x->size[1];
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_xc, 1, &d_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_xc, 1, &e_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_cfs, 2, &s_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_y, 2, &t_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_dv, 1, &u_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&b_cpu_x, 2, &g_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&c_cpu_x, 2, &h_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_y, 2, &v_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_dv4, 2, &w_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_x, 2, &v_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_cfsnorm, 2, &x_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&e_cpu_x, 2, &m_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_y, 2, &y_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&f_cpu_x, 2, &y_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_b, 2, &q_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_r, 2, &ab_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_r1, 2, &g_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_r2, 2, &h_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_dv, 1, &k_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_dv4, 2, &n_emlrtRTEI, true);
  profileLoopStart("ec_wt_fp_loop_1", __LINE__, (i - 1) + 1, "");
  for (int32_T ch{0}; ch < i; ch++) {
    // 'ec_wt_fp:46' if doAvg
    if (doAvg) {
      int32_T lshift[2];
      int32_T nx;
      int32_T xpageoffset;
      boolean_T validLaunchParams;
      // 'ec_wt_fp:47' y(:,ch) = awt_lfn(fb,x(:,ch),ds,doPwr);
      dim = cpu_xc->size[0];
      cpu_xc->size[0] = cpu_x->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_xc, dim, &d_emlrtRTEI);
      xpageoffset = cpu_x->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      if (x_needsGpuEnsureCapacity) {
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
      }
      x_needsGpuEnsureCapacity = false;
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_xc, &gpu_xc, true);
      if (x_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
      }
      x_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel1#" MW_AT_LINE);
        ec_wt_fp_kernel1<<<grid, block>>>(ch, gpu_x, xpageoffset, gpu_xc,
                                          cpu_x->size[0U]);
      }
      //  Scale-averaged wavelet transform
      //  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Run transform
      // 'ec_wt_fp:75' if doPwr
      if (doPwr) {
        int32_T vlen;
        uint32_T sz[2];
        // 'ec_wt_fp:76' yc = scaleSpectrum(fb,xc)';
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_xc, &gpu_xc);
        nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
        coder::cwtfilterbank_wt(&fb, cpu_xc, cpu_cfs);
        nx = cpu_cfs->size[0] * cpu_cfs->size[1];
        profileLoopStart("ec_wt_fp_loop_2", __LINE__, 1 + 1, "");
        for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
          sz[xpageoffset] = static_cast<uint32_T>(cpu_cfs->size[xpageoffset]);
        }
        profileLoopEnd();
        dim = c_cpu_y->size[0] * c_cpu_y->size[1];
        c_cpu_y->size[0] = static_cast<int32_T>(sz[0]);
        c_cpu_y->size[1] = static_cast<int32_T>(sz[1]);
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(c_cpu_y, dim, &i_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_cfs, &gpu_cfs, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(c_cpu_y, &gpu_y, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_cfs, cpu_cfs);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel2#" MW_AT_LINE);
          ec_wt_fp_kernel2<<<grid, block>>>(gpu_cfs, nx - 1, gpu_y);
        }
        profileLoopStart("ec_wt_fp_loop_5", __LINE__, 1 + 1, "");
        for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
          sz[xpageoffset] = static_cast<uint32_T>(c_cpu_y->size[xpageoffset]);
        }
        profileLoopEnd();
        dim = d_cpu_x->size[0] * d_cpu_x->size[1];
        d_cpu_x->size[0] = static_cast<int32_T>(sz[0]);
        d_cpu_x->size[1] = static_cast<int32_T>(sz[1]);
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(d_cpu_x, dim, &j_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(
            computeNumIters(
                static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1),
            &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(d_cpu_x, &b_gpu_x, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel3#" MW_AT_LINE);
          ec_wt_fp_kernel3<<<grid, block>>>(
              gpu_y,
              static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1,
              b_gpu_x);
        }
        vlen = d_cpu_x->size[0] * d_cpu_x->size[1];
        if (d_cpu_x->size[0] * d_cpu_x->size[1] == 0) {
          nFrames = 0.0;
        } else {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &b_gpu_x);
          nFrames = d_cpu_x->data[0];
          profileLoopStart("ec_wt_fp_loop_7", __LINE__, (vlen - 2) + 1, "");
          for (nx = 0; nx <= vlen - 2; nx++) {
            nFrames += d_cpu_x->data[nx + 1];
          }
          profileLoopEnd();
        }
        nFrames = std::sqrt(
            fb.sigvar /
            (1.0 / static_cast<real_T>(fb.Scales->size[1]) * nFrames));
        dim = cpu_cfsnorm->size[0] * cpu_cfsnorm->size[1];
        cpu_cfsnorm->size[0] = cpu_cfs->size[0];
        cpu_cfsnorm->size[1] = cpu_cfs->size[1];
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(cpu_cfsnorm, dim, &l_emlrtRTEI);
        r_outdatedOnCpu = true;
        if ((cpu_cfs->size[0] != 0) && (cpu_cfs->size[1] != 0)) {
          nx = (cpu_cfs->size[1] != 1);
          vlen = cpu_cfs->size[1] - 1;
          xpageoffset = cpu_cfsnorm->size[0] - 1;
          nvtxMarkA("#computeNumIters#" MW_AT_LINE);
          mwGetLaunchParameters1D(computeNumIters(vlen, xpageoffset), &grid,
                                  &block, 2147483647U);
          nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_creal_T(cpu_cfsnorm, &gpu_cfsnorm, true);
          r_outdatedOnCpu = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            nvtxMarkA("#ec_wt_fp_kernel4#" MW_AT_LINE);
            ec_wt_fp_kernel4<<<grid, block>>>(
                nFrames, gpu_cfs, nx, xpageoffset, vlen, gpu_cfsnorm,
                cpu_cfs->size[0U], cpu_cfsnorm->size[0U]);
          }
        }
        vlen = fb.Scales->size[1];
        nFrames = 1.0 / static_cast<real_T>(fb.Scales->size[1]);
        dim = e_cpu_x->size[0] * e_cpu_x->size[1];
        e_cpu_x->size[0] = vlen;
        e_cpu_x->size[1] = cpu_cfsnorm->size[1];
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(e_cpu_x, dim, &m_emlrtRTEI);
        xpageoffset = cpu_cfsnorm->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(xpageoffset, vlen - 1), &grid,
                                &block, 2147483647U);
        if (r_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_creal_T(cpu_cfsnorm, &gpu_cfsnorm, true);
        }
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(e_cpu_x, &c_gpu_x, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel5#" MW_AT_LINE);
          ec_wt_fp_kernel5<<<grid, block>>>(gpu_cfsnorm, vlen - 1, xpageoffset,
                                            c_gpu_x, e_cpu_x->size[0U],
                                            cpu_cfsnorm->size[0U]);
        }
        nx = vlen * cpu_cfsnorm->size[1];
        dim = d_cpu_y->size[0] * d_cpu_y->size[1];
        d_cpu_y->size[0] = vlen;
        d_cpu_y->size[1] = cpu_cfsnorm->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(d_cpu_y, dim, &i_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(d_cpu_y, &b_gpu_y, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel6#" MW_AT_LINE);
          ec_wt_fp_kernel6<<<grid, block>>>(c_gpu_x, nx - 1, b_gpu_y);
        }
        profileLoopStart("ec_wt_fp_loop_9", __LINE__, 1 + 1, "");
        for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
          sz[xpageoffset] = static_cast<uint32_T>(d_cpu_y->size[xpageoffset]);
        }
        profileLoopEnd();
        dim = f_cpu_x->size[0] * f_cpu_x->size[1];
        f_cpu_x->size[0] = static_cast<int32_T>(sz[0]);
        f_cpu_x->size[1] = static_cast<int32_T>(sz[1]);
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(f_cpu_x, dim, &j_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(
            computeNumIters(
                static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1),
            &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(f_cpu_x, &d_gpu_x, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel7#" MW_AT_LINE);
          ec_wt_fp_kernel7<<<grid, block>>>(
              b_gpu_y,
              static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1,
              d_gpu_x);
        }
        vlen = f_cpu_x->size[0];
        if ((f_cpu_x->size[0] == 0) || (f_cpu_x->size[1] == 0)) {
          profileLoopStart("ec_wt_fp_loop_10", __LINE__, 1 + 1, "");
          for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
            sz[xpageoffset] = static_cast<uint32_T>(f_cpu_x->size[xpageoffset]);
          }
          profileLoopEnd();
          dim = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = static_cast<int32_T>(sz[1]);
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(cpu_b, dim, &q_emlrtRTEI);
          nvtxMarkA("#computeNumIters#" MW_AT_LINE);
          mwGetLaunchParameters1D(
              computeNumIters(static_cast<int32_T>(sz[1]) - 1), &grid, &block,
              2147483647U);
          nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            nvtxMarkA("#ec_wt_fp_kernel8#" MW_AT_LINE);
            ec_wt_fp_kernel8<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
                                              gpu_b);
          }
        } else {
          nx = f_cpu_x->size[1];
          dim = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = f_cpu_x->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(cpu_b, dim, &o_emlrtRTEI);
          nvtxMarkA("#computeNumIters#" MW_AT_LINE);
          mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                                  2147483647U);
          nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            nvtxMarkA("#ec_wt_fp_kernel13#" MW_AT_LINE);
            ec_wt_fp_kernel13<<<grid, block>>>(vlen, d_gpu_x, nx - 1, gpu_b,
                                               f_cpu_x->size[0U]);
          }
        }
        dim = cpu_dv->size[0];
        cpu_dv->size[0] = cpu_b->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_dv, dim, &f_emlrtRTEI);
        xpageoffset = cpu_b->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel9#" MW_AT_LINE);
          ec_wt_fp_kernel9<<<grid, block>>>(gpu_b, nFrames, xpageoffset,
                                            gpu_dv);
        }
        //  Power
      } else {
        // 'ec_wt_fp:77' else
        // 'ec_wt_fp:78' yc = scaleSpectrum(fb,xc,SpectrumType="density")';
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_xc, &gpu_xc);
        nvtxMarkA("#cwtfilterbank_scaleSpectrum#" MW_AT_LINE);
        coder::cwtfilterbank_scaleSpectrum(&fb, cpu_xc, cpu_r, &r_outdatedOnCpu,
                                           &gpu_r, &r_outdatedOnGpu);
        dim = cpu_dv->size[0];
        cpu_dv->size[0] = cpu_r->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_dv, dim, &f_emlrtRTEI);
        xpageoffset = cpu_r->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_r, &gpu_r, !r_outdatedOnGpu);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
        if (r_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, cpu_r);
        }
        r_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel14#" MW_AT_LINE);
          ec_wt_fp_kernel14<<<grid, block>>>(gpu_r, xpageoffset, gpu_dv);
        }
        //  Magnitude
      }
      //  Downsample
      // 'ec_wt_fp:82' if ds
      if (ds != 0.0) {
        // 'ec_wt_fp:83' yc = downsample(yc,ds);
        if (!(ds - 1.0 >= 0.0)) {
          y = nullptr;
          m = emlrtCreateCharArray(2, &iv[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
          emlrtAssign(&y, m);
          b_y = nullptr;
          m1 = emlrtCreateDoubleScalar(ds - 1.0);
          emlrtAssign(&b_y, m1);
          nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
          nvtxMarkA("#b_sprintf#" MW_AT_LINE);
          emlrt_marshallIn(b_sprintf(y, b_y, &c_emlrtMCI),
                           "<output of sprintf>", unusedExpr);
        }
        nx = cpu_dv->size[0] - 1;
        dim = b_cpu_dv->size[0];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        b_cpu_dv->size[0] =
            div_s32(cpu_dv->size[0] - 1, static_cast<int32_T>(ds)) + 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_cpu_dv, dim, &k_emlrtRTEI);
        xpageoffset = nx / static_cast<int32_T>(ds);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(b_cpu_dv, &b_gpu_dv, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel10#" MW_AT_LINE);
          ec_wt_fp_kernel10<<<grid, block>>>(gpu_dv, ds, xpageoffset, b_gpu_dv);
        }
        dim = cpu_dv->size[0];
        cpu_dv->size[0] = b_cpu_dv->size[0];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_dv, dim, &f_emlrtRTEI);
        xpageoffset = b_cpu_dv->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel11#" MW_AT_LINE);
          ec_wt_fp_kernel11<<<grid, block>>>(b_gpu_dv, xpageoffset, gpu_dv);
        }
      }
      nx = cpu_y->size[0];
      lshift[0] = cpu_y->size[0];
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                              2147483647U);
      if (y_needsGpuEnsureCapacity) {
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_y, &c_gpu_y, true);
      }
      y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel12#" MW_AT_LINE);
        ec_wt_fp_kernel12<<<grid, block>>>(gpu_dv, ch, lshift[0], nx - 1,
                                           c_gpu_y);
      }
      r_outdatedOnCpu = true;
    } else {
      int32_T c_y[3];
      int32_T nx;
      int32_T vlen;
      int32_T xpageoffset;
      boolean_T validLaunchParams;
      // 'ec_wt_fp:48' else
      // 'ec_wt_fp:49' y(:,ch,:) = cwt_lfn(fb,x(:,ch),ds,doPwr);
      dim = b_cpu_xc->size[0];
      b_cpu_xc->size[0] = cpu_x->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b_cpu_xc, dim, &e_emlrtRTEI);
      xpageoffset = cpu_x->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      if (x_needsGpuEnsureCapacity) {
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
      }
      x_needsGpuEnsureCapacity = false;
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(b_cpu_xc, &b_gpu_xc, true);
      if (x_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
      }
      x_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel15#" MW_AT_LINE);
        ec_wt_fp_kernel15<<<grid, block>>>(ch, gpu_x, xpageoffset, b_gpu_xc,
                                           cpu_x->size[0U]);
      }
      //  Continuous wavelet transform
      //  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Run transform
      // 'ec_wt_fp:60' if doPwr
      if (doPwr) {
        uint32_T sz[2];
        // 'ec_wt_fp:61' yc = abs(wt(fb,xc)').^2;
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(b_cpu_xc, &b_gpu_xc);
        nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
        coder::cwtfilterbank_wt(&fb, b_cpu_xc, cpu_r2);
        dim = c_cpu_x->size[0] * c_cpu_x->size[1];
        c_cpu_x->size[0] = cpu_r2->size[1];
        c_cpu_x->size[1] = cpu_r2->size[0];
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(c_cpu_x, dim, &h_emlrtRTEI);
        xpageoffset = cpu_r2->size[0] - 1;
        vlen = cpu_r2->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(xpageoffset, vlen), &grid,
                                &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_r2, &gpu_r2, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(c_cpu_x, &e_gpu_x, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_r2, cpu_r2);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel16#" MW_AT_LINE);
          ec_wt_fp_kernel16<<<grid, block>>>(gpu_r2, vlen, xpageoffset, e_gpu_x,
                                             c_cpu_x->size[0U],
                                             cpu_r2->size[0U]);
        }
        nx = c_cpu_x->size[0] * c_cpu_x->size[1];
        profileLoopStart("ec_wt_fp_loop_3", __LINE__, 1 + 1, "");
        for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
          sz[xpageoffset] = static_cast<uint32_T>(c_cpu_x->size[xpageoffset]);
        }
        profileLoopEnd();
        dim = b_cpu_y->size[0] * b_cpu_y->size[1];
        b_cpu_y->size[0] = static_cast<int32_T>(sz[0]);
        b_cpu_y->size[1] = static_cast<int32_T>(sz[1]);
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_cpu_y, dim, &i_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(b_cpu_y, &d_gpu_y, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel17#" MW_AT_LINE);
          ec_wt_fp_kernel17<<<grid, block>>>(e_gpu_x, nx - 1, d_gpu_y);
        }
        profileLoopStart("ec_wt_fp_loop_6", __LINE__, 1 + 1, "");
        for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
          sz[xpageoffset] = static_cast<uint32_T>(b_cpu_y->size[xpageoffset]);
        }
        profileLoopEnd();
        dim = cpu_dv4->size[0] * cpu_dv4->size[1];
        cpu_dv4->size[0] = static_cast<int32_T>(sz[0]);
        cpu_dv4->size[1] = static_cast<int32_T>(sz[1]);
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_dv4, dim, &j_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(
            computeNumIters(
                static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1),
            &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_dv4, &gpu_dv4, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel18#" MW_AT_LINE);
          ec_wt_fp_kernel18<<<grid, block>>>(
              d_gpu_y,
              static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1,
              gpu_dv4);
        }
        //  Power
      } else {
        uint32_T sz[2];
        // 'ec_wt_fp:62' else
        // 'ec_wt_fp:63' yc = abs(wt(fb,xc)');
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(b_cpu_xc, &b_gpu_xc);
        nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
        coder::cwtfilterbank_wt(&fb, b_cpu_xc, cpu_r1);
        dim = b_cpu_x->size[0] * b_cpu_x->size[1];
        b_cpu_x->size[0] = cpu_r1->size[1];
        b_cpu_x->size[1] = cpu_r1->size[0];
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(b_cpu_x, dim, &g_emlrtRTEI);
        xpageoffset = cpu_r1->size[0] - 1;
        vlen = cpu_r1->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(xpageoffset, vlen), &grid,
                                &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_r1, &gpu_r1, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(b_cpu_x, &f_gpu_x, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_r1, cpu_r1);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel24#" MW_AT_LINE);
          ec_wt_fp_kernel24<<<grid, block>>>(gpu_r1, vlen, xpageoffset, f_gpu_x,
                                             b_cpu_x->size[0U],
                                             cpu_r1->size[0U]);
        }
        nx = b_cpu_x->size[0] * b_cpu_x->size[1];
        profileLoopStart("ec_wt_fp_loop_4", __LINE__, 1 + 1, "");
        for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
          sz[xpageoffset] = static_cast<uint32_T>(b_cpu_x->size[xpageoffset]);
        }
        profileLoopEnd();
        dim = cpu_dv4->size[0] * cpu_dv4->size[1];
        cpu_dv4->size[0] = static_cast<int32_T>(sz[0]);
        cpu_dv4->size[1] = static_cast<int32_T>(sz[1]);
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_dv4, dim, &i_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_dv4, &gpu_dv4, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel25#" MW_AT_LINE);
          ec_wt_fp_kernel25<<<grid, block>>>(f_gpu_x, nx - 1, gpu_dv4);
        }
        //  Magnitude
      }
      //  Downsample
      // 'ec_wt_fp:67' if ds
      if (ds != 0.0) {
        int32_T cpu_lshift[2];
        int32_T cpu_sizeX[2];
        // 'ec_wt_fp:68' yc = downsample(yc,ds);
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
        dim = 2;
        if (cpu_dv4->size[0] != 1) {
          dim = 1;
        }
        r_outdatedOnCpu = false;
        r_outdatedOnGpu = false;
        profileLoopStart("ec_wt_fp_loop_8", __LINE__, 1 + 1, "");
        for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
          cpu_sizeX[xpageoffset] = cpu_dv4->size[xpageoffset];
          r_outdatedOnGpu = true;
          cpu_lshift[xpageoffset] = cpu_dv4->size[xpageoffset];
          r_outdatedOnCpu = true;
        }
        profileLoopEnd();
        if (1 - dim >= 0) {
          nvtxMarkA("#computeNumIters#" MW_AT_LINE);
          mwGetLaunchParameters1D(
              computeNumIters(
                  static_cast<int32_T>(
                      (2.0 - (1.0 - static_cast<real_T>(dim))) / 2.0) -
                  1),
              &grid, &block, 2147483647U);
          if (r_outdatedOnCpu) {
            nvtxMarkA("#checkCudaError#" MW_AT_LINE);
            nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
            checkCudaError(cudaMemcpy(*gpu_lshift, cpu_lshift, 8UL,
                                      cudaMemcpyHostToDevice),
                           __FILE__, __LINE__);
          }
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            nvtxMarkA("#ec_wt_fp_kernel19#" MW_AT_LINE);
            ec_wt_fp_kernel19<<<grid, block>>>(
                1 - dim,
                static_cast<int32_T>((2.0 - (1.0 - static_cast<real_T>(dim))) /
                                     2.0) -
                    1,
                *gpu_lshift);
          }
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(
              cudaMemcpy(cpu_lshift, *gpu_lshift, 8UL, cudaMemcpyDeviceToHost),
              __FILE__, __LINE__);
        }
        nx = cpu_lshift[0];
        cpu_lshift[0] = cpu_lshift[1];
        if ((ds > 0.0) && (cpu_lshift[0] < 1)) {
          vlen = 1;
          xpageoffset = -1;
        } else {
          vlen = static_cast<int32_T>(ds);
          xpageoffset = cpu_lshift[0] - 1;
        }
        if (r_outdatedOnGpu) {
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(
              cudaMemcpy(*gpu_sizeX, cpu_sizeX, 8UL, cudaMemcpyHostToDevice),
              __FILE__, __LINE__);
        }
        nvtxMarkA("#ec_wt_fp_kernel20#" MW_AT_LINE);
        ec_wt_fp_kernel20<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            vlen, xpageoffset, dim, *gpu_sizeX);
        dim = b_cpu_dv4->size[0] * b_cpu_dv4->size[1];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        b_cpu_dv4->size[0] = div_s32(xpageoffset, vlen) + 1;
        b_cpu_dv4->size[1] = nx;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_cpu_dv4, dim, &n_emlrtRTEI);
        xpageoffset /= vlen;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(nx - 1, xpageoffset), &grid,
                                &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(b_cpu_dv4, &b_gpu_dv4, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel21#" MW_AT_LINE);
          ec_wt_fp_kernel21<<<grid, block>>>(gpu_dv4, cpu_lshift[0], vlen,
                                             xpageoffset, nx - 1, b_gpu_dv4,
                                             b_cpu_dv4->size[0U]);
        }
        nvtxMarkA("#checkCudaError#" MW_AT_LINE);
        nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
        checkCudaError(
            cudaMemcpy(cpu_sizeX, *gpu_sizeX, 8UL, cudaMemcpyDeviceToHost),
            __FILE__, __LINE__);
        dim = cpu_dv4->size[0] * cpu_dv4->size[1];
        cpu_dv4->size[0] = cpu_sizeX[0];
        cpu_dv4->size[1] = cpu_sizeX[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_dv4, dim, &p_emlrtRTEI);
        xpageoffset = cpu_sizeX[0] * cpu_sizeX[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_dv4, &gpu_dv4, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel22#" MW_AT_LINE);
          ec_wt_fp_kernel22<<<grid, block>>>(b_gpu_dv4, xpageoffset, gpu_dv4);
        }
      }
      c_y[0] = cpu_y->size[0];
      c_y[2] = cpu_y->size[2];
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(c_y[2] - 1, c_y[0] - 1), &grid,
                              &block, 2147483647U);
      if (y_needsGpuEnsureCapacity) {
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_y, &c_gpu_y, true);
      }
      y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel23#" MW_AT_LINE);
        ec_wt_fp_kernel23<<<grid, block>>>(gpu_dv4, c_y[0], ch, c_y[0] - 1,
                                           c_y[2] - 1, c_gpu_y, cpu_y->size[0U],
                                           cpu_y->size[1U]);
      }
      r_outdatedOnCpu = true;
    }
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_dv4);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_dv);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_r2);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_r1);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_r);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_b);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&f_cpu_x);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_y);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&e_cpu_x);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_cfsnorm);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_x);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_dv4);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_y);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&c_cpu_x);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&b_cpu_x);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_dv);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_y);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_cfs);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_xc);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_xc);
  nvtxMarkA("#emxFreeStruct_cwtfilterbank#" MW_AT_LINE);
  emxFreeStruct_cwtfilterbank(&fb);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (r_outdatedOnCpu) {
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real_T(cpu_y, &c_gpu_y);
  }
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_x);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_xc);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_xc);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_cfs);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&d_gpu_y);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_dv);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&f_gpu_x);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&e_gpu_x);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_dv4);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_x);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_cfsnorm);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&c_gpu_x);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&d_gpu_x);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_b);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_r);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_r1);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_r2);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_dv);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_dv4);
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
