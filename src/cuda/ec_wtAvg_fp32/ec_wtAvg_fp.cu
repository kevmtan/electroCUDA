//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtAvg_fp.cu
//
// Code generation for function 'ec_wtAvg_fp'
//

// Include files
#include "ec_wtAvg_fp.h"
#include "cwtfilterbank.h"
#include "ec_wtAvg_fp_data.h"
#include "ec_wtAvg_fp_emxutil.h"
#include "ec_wtAvg_fp_mexutil.h"
#include "ec_wtAvg_fp_types.h"
#include "rt_nonfinite.h"
#include "scaleSpectrum.h"
#include "wt.h"
#include "MWCudaDimUtility.hpp"
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
    29,                                                        // lineNo
    1,                                                         // colNo
    "ec_wtAvg_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wtAvg_fp.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    37,                                                        // lineNo
    20,                                                        // colNo
    "ec_wtAvg_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wtAvg_fp.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    42,                                                        // lineNo
    26,                                                        // colNo
    "ec_wtAvg_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wtAvg_fp.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    42,                                                        // lineNo
    15,                                                        // colNo
    "ec_wtAvg_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wtAvg_fp.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    75,                                                           // lineNo
    13,                                                           // colNo
    "downsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/downsample.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    287,             // lineNo
    33,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    181,                     // lineNo
    24,                      // colNo
    "combineVectorElements", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/"
    "combineVectorElements.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    287,             // lineNo
    25,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    27,                                                        // lineNo
    1,                                                         // colNo
    "ec_wtAvg_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wtAvg_fp.m" // pName
};

static emlrtRTEInfo n_emlrtRTEI{
    42,                                                        // lineNo
    5,                                                         // colNo
    "ec_wtAvg_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wtAvg_fp.m" // pName
};

static emlrtRTEInfo p_emlrtRTEI{
    267,             // lineNo
    36,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo q_emlrtRTEI{
    282,             // lineNo
    9,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo r_emlrtRTEI{
    287,             // lineNo
    29,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo s_emlrtRTEI{
    55,                                                        // lineNo
    10,                                                        // colNo
    "ec_wtAvg_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wtAvg_fp.m" // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId, char_T ret[23]);

static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
                                emlrtMCInfo *location);

static uint64_T computeNumIters(int32_T ub, int32_T b_ub);

static __global__ void
ec_wtAvg_fp_kernel1(const int32_T ch, const emxArray_real32_T x,
                    const int32_T b_x, emxArray_real32_T xc, int32_T x_dim0);

static __global__ void ec_wtAvg_fp_kernel10(const emxArray_real32_T fv,
                                            const real_T ds, const int32_T b,
                                            emxArray_real32_T b_fv);

static __global__ void ec_wtAvg_fp_kernel11(const emxArray_real32_T fv,
                                            const int32_T b_fv,
                                            emxArray_real32_T c_fv);

static __global__ void ec_wtAvg_fp_kernel12(const emxArray_real32_T fv,
                                            const int32_T ch, const int32_T b,
                                            emxArray_real32_T y,
                                            int32_T y_dim0);

static __global__ void
ec_wtAvg_fp_kernel13(const int32_T vlen, const emxArray_real32_T x,
                     const int32_T b, emxArray_real32_T b_b, int32_T x_dim0);

static __global__ void ec_wtAvg_fp_kernel14(const emxArray_real32_T r,
                                            const int32_T b_r,
                                            emxArray_real32_T fv);

static __global__ void ec_wtAvg_fp_kernel2(const emxArray_creal32_T cfs,
                                           const int32_T b,
                                           emxArray_real32_T y);

static __global__ void ec_wtAvg_fp_kernel3(const emxArray_real32_T y,
                                           const int32_T b,
                                           emxArray_real32_T x);

static __global__ void
ec_wtAvg_fp_kernel4(const real32_T b, const emxArray_creal32_T cfs,
                    const int32_T nx, const int32_T cfsnorm, const int32_T vlen,
                    emxArray_creal32_T b_cfsnorm, int32_T cfs_dim0,
                    int32_T cfsnorm_dim0);

static __global__ void ec_wtAvg_fp_kernel5(const emxArray_creal32_T cfsnorm,
                                           const int32_T b,
                                           const int32_T b_cfsnorm,
                                           emxArray_creal32_T x, int32_T x_dim0,
                                           int32_T cfsnorm_dim0);

static __global__ void ec_wtAvg_fp_kernel6(const emxArray_creal32_T x,
                                           const int32_T b,
                                           emxArray_real32_T y);

static __global__ void ec_wtAvg_fp_kernel7(const emxArray_real32_T y,
                                           const int32_T b,
                                           emxArray_real32_T x);

static __global__ void ec_wtAvg_fp_kernel8(const int32_T sz,
                                           emxArray_real32_T b);

static __global__ void ec_wtAvg_fp_kernel9(const emxArray_real32_T b,
                                           const real_T nFrames,
                                           const int32_T b_b,
                                           emxArray_real32_T fv);

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

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel1(
    const int32_T ch, const emxArray_real32_T x, const int32_T b_x,
    emxArray_real32_T xc, int32_T x_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel10(
    const emxArray_real32_T fv, const real_T ds, const int32_T b,
    emxArray_real32_T b_fv)
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
    b_fv.data[xpageoffset] = fv.data[static_cast<int32_T>(ds) * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel11(
    const emxArray_real32_T fv, const int32_T b_fv, emxArray_real32_T c_fv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    c_fv.data[xpageoffset] = fv.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel12(
    const emxArray_real32_T fv, const int32_T ch, const int32_T b,
    emxArray_real32_T y, int32_T y_dim0)
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
    y.data[xpageoffset + y_dim0 * ch] = fv.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel13(
    const int32_T vlen, const emxArray_real32_T x, const int32_T b,
    emxArray_real32_T b_b, int32_T x_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel14(
    const emxArray_real32_T r, const int32_T b_r, emxArray_real32_T fv)
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
    fv.data[xpageoffset] = r.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel2(
    const emxArray_creal32_T cfs, const int32_T b, emxArray_real32_T y)
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
    y.data[k] = hypotf(cfs.data[k].re, cfs.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel3(
    const emxArray_real32_T y, const int32_T b, emxArray_real32_T x)
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

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel4(
    const real32_T b, const emxArray_creal32_T cfs, const int32_T nx,
    const int32_T cfsnorm, const int32_T vlen, emxArray_creal32_T b_cfsnorm,
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
        b * cfs.data[bcoef * b_k + cfs_dim0 * (xpageoffset - 1)].re;
    b_cfsnorm.data[b_k + cfsnorm_dim0 * k].im =
        b * cfs.data[bcoef * b_k + cfs_dim0 * (xpageoffset - 1)].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel5(
    const emxArray_creal32_T cfsnorm, const int32_T b, const int32_T b_cfsnorm,
    emxArray_creal32_T x, int32_T x_dim0, int32_T cfsnorm_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel6(
    const emxArray_creal32_T x, const int32_T b, emxArray_real32_T y)
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
    y.data[k] = hypotf(x.data[k].re, x.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel7(
    const emxArray_real32_T y, const int32_T b, emxArray_real32_T x)
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

static __global__
    __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel8(const int32_T sz,
                                                        emxArray_real32_T b)
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
    b.data[xpageoffset] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtAvg_fp_kernel9(
    const emxArray_real32_T b, const real_T nFrames, const int32_T b_b,
    emxArray_real32_T fv)
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
    fv.data[xpageoffset] = static_cast<real32_T>(nFrames) * b.data[xpageoffset];
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
// function [y,freqs] = ec_wtAvg_fp(x,fs,fLims,fVoices,ds,doPwr)
void ec_wtAvg_fp(const emxArray_real32_T *cpu_x, real_T fs,
                 const real_T fLims[2], real_T fVoices, real_T ds,
                 boolean_T doPwr, emxArray_real32_T *cpu_y,
                 emxArray_real_T *freqs)
{
  static const int32_T iv[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  coder::cwtfilterbank fb;
  dim3 block;
  dim3 grid;
  emxArray_creal32_T c_gpu_x;
  emxArray_creal32_T gpu_cfs;
  emxArray_creal32_T gpu_cfsnorm;
  emxArray_creal32_T *c_cpu_x;
  emxArray_creal32_T *cpu_cfs;
  emxArray_creal32_T *cpu_cfsnorm;
  emxArray_real32_T b_gpu_fv;
  emxArray_real32_T b_gpu_x;
  emxArray_real32_T b_gpu_y;
  emxArray_real32_T c_gpu_y;
  emxArray_real32_T d_gpu_x;
  emxArray_real32_T gpu_b;
  emxArray_real32_T gpu_fv;
  emxArray_real32_T gpu_r;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_xc;
  emxArray_real32_T gpu_y;
  emxArray_real32_T *Scales;
  emxArray_real32_T *b_cpu_fv;
  emxArray_real32_T *b_cpu_x;
  emxArray_real32_T *b_cpu_y;
  emxArray_real32_T *c_cpu_y;
  emxArray_real32_T *cpu_b;
  emxArray_real32_T *cpu_fv;
  emxArray_real32_T *cpu_r;
  emxArray_real32_T *cpu_xc;
  emxArray_real32_T *d_cpu_x;
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *y;
  real_T nFrames;
  int32_T i;
  int32_T xpageoffset;
  char_T unusedExpr[23];
  boolean_T r_outdatedOnCpu;
  boolean_T r_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  nvtxMarkA("#entryPointStart#");
  nvtxRangePushA("#entryPointFcn#ec_wtAvg_fp#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_fv);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_r);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_b);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&d_gpu_x);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&c_gpu_x);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_cfsnorm);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_x);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_cfs);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_fv);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_xc);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_x);
  r_outdatedOnGpu = false;
  x_outdatedOnGpu = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInitStruct_cwtfilterbank#" MW_AT_LINE);
  emxInitStruct_cwtfilterbank(&fb, &m_emlrtRTEI, true);
  //  electroCUDA - Scale-avergaged Wavelet Transform
  //    Intended to be compiled into a CUDA mex binary
  //    Kevin Tan, 2024 (github.com/kevmtan/electroCUDA)
  //
  //  OUTPUTS:
  //    y = transformed data
  //    freqs = CWT frequencies
  // 'ec_wtAvg_fp:10' x (:,:){mustBeFloat}
  //  Input data
  // 'ec_wtAvg_fp:11' fs (1,1) double
  //  Sampling rate
  // 'ec_wtAvg_fp:12' fLims (1,2) double
  //  Frequency limits
  // 'ec_wtAvg_fp:13' fVoices (1,1) double = 10
  //  Voices per octave
  // 'ec_wtAvg_fp:14' ds (1,1) double = 0
  //  Downsampling factor
  // 'ec_wtAvg_fp:15' doPwr (1,1) logical = false
  //  Output [0=magnitude|1=output]
  // 'ec_wtAvg_fp:17' if ds<=1
  if (ds <= 1.0) {
    // 'ec_wtAvg_fp:17' ;
    // 'ec_wtAvg_fp:17' ds=0;
    ds = 0.0;
  }
  //  Prep
  // 'ec_wtAvg_fp:20' coder.gpu.kernelfun;
  //  Trigger CUDA kernel creation
  //  Sizes
  // 'ec_wtAvg_fp:23' nFrames = height(x);
  nFrames = cpu_x->size[0];
  // 'ec_wtAvg_fp:24' nChs = width(x);
  //  Make CWT filter
  // 'ec_wtAvg_fp:27' fb =
  // cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,... 'ec_wtAvg_fp:28'
  // SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);
  nvtxMarkA("#cwtfilterbank_cwtfilterbank#" MW_AT_LINE);
  coder::cwtfilterbank_cwtfilterbank(&fb, static_cast<real_T>(cpu_x->size[0]),
                                     fs, fLims, fVoices);
  // 'ec_wtAvg_fp:29' freqs = centerFrequencies(fb);
  xpageoffset = freqs->size[0];
  freqs->size[0] = fb.WaveletCenterFrequencies->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(freqs, xpageoffset, &emlrtRTEI);
  profileLoopStart("ec_wtAvg_fp_loop_0", __LINE__,
                   (fb.WaveletCenterFrequencies->size[0] - 1) + 1, "");
  for (xpageoffset = 0; xpageoffset < fb.WaveletCenterFrequencies->size[0];
       xpageoffset++) {
    freqs->data[xpageoffset] = fb.WaveletCenterFrequencies->data[xpageoffset];
  }
  profileLoopEnd();
  //  Find output frames
  // 'ec_wtAvg_fp:32' if ds
  if (ds != 0.0) {
    // 'ec_wtAvg_fp:33' nFrames = floor(nFrames/ds);
    nFrames = std::floor(static_cast<real_T>(cpu_x->size[0]) / ds);
  }
  //  Preallocate output
  // 'ec_wtAvg_fp:37' y = coder.nullcopy(nan(nFrames,nChs,like=x));
  r_outdatedOnCpu = false;
  xpageoffset = cpu_y->size[0] * cpu_y->size[1];
  cpu_y->size[0] = static_cast<int32_T>(nFrames);
  cpu_y->size[1] = cpu_x->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(cpu_y, xpageoffset, &b_emlrtRTEI);
  y_needsGpuEnsureCapacity = true;
  //  Processing loop across channels
  // 'ec_wtAvg_fp:41' for ch = 1:nChs
  i = cpu_x->size[1];
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_xc, 1, &c_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_fv, 1, &n_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&Scales, 2, &e_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_cfs, 2, &o_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_y, 2, &p_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_x, 2, &p_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_cfsnorm, 2, &q_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&c_cpu_x, 2, &j_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_cpu_y, 2, &r_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&d_cpu_x, 2, &r_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_b, 2, &l_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_r, 2, &s_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_fv, 1, &g_emlrtRTEI, true);
  profileLoopStart("ec_wtAvg_fp_loop_1", __LINE__, (i - 1) + 1, "");
  for (int32_T ch{0}; ch < i; ch++) {
    int32_T nx;
    boolean_T validLaunchParams;
    // 'ec_wtAvg_fp:42' y(:,ch) = awt_lfn(fb,x(:,ch),ds,doPwr);
    xpageoffset = cpu_xc->size[0];
    cpu_xc->size[0] = cpu_x->size[0];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_xc, xpageoffset, &c_emlrtRTEI);
    xpageoffset = cpu_x->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                            2147483647U);
    if (x_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
    }
    x_needsGpuEnsureCapacity = false;
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_xc, &gpu_xc, true);
    if (x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
    }
    x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#ec_wtAvg_fp_kernel1#" MW_AT_LINE);
      ec_wtAvg_fp_kernel1<<<grid, block>>>(ch, gpu_x, xpageoffset, gpu_xc,
                                           cpu_x->size[0U]);
    }
    //  Run transform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    //  Run transform
    // 'ec_wtAvg_fp:52' if doPwr
    if (doPwr) {
      int32_T vlen;
      real32_T b;
      real32_T x;
      uint32_T sz[2];
      uint32_T defaultSL_idx_1;
      // 'ec_wtAvg_fp:53' yc = scaleSpectrum(fb,xc)';
      defaultSL_idx_1 = static_cast<uint32_T>(fb.Scales->size[1]);
      xpageoffset = Scales->size[0] * Scales->size[1];
      Scales->size[0] = 1;
      Scales->size[1] = fb.Scales->size[1];
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(Scales, xpageoffset, &e_emlrtRTEI);
      profileLoopStart("ec_wtAvg_fp_loop_2", __LINE__,
                       (fb.Scales->size[1] - 1) + 1, "");
      for (xpageoffset = 0; xpageoffset < fb.Scales->size[1]; xpageoffset++) {
        Scales->data[xpageoffset] =
            static_cast<real32_T>(fb.Scales->data[xpageoffset]);
      }
      profileLoopEnd();
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real32_T(cpu_xc, &gpu_xc);
      nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
      coder::cwtfilterbank_wt(&fb, cpu_xc, cpu_cfs);
      nx = cpu_cfs->size[0] * cpu_cfs->size[1];
      profileLoopStart("ec_wtAvg_fp_loop_3", __LINE__, 1 + 1, "");
      for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
        sz[xpageoffset] = static_cast<uint32_T>(cpu_cfs->size[xpageoffset]);
      }
      profileLoopEnd();
      xpageoffset = b_cpu_y->size[0] * b_cpu_y->size[1];
      b_cpu_y->size[0] = static_cast<int32_T>(sz[0]);
      b_cpu_y->size[1] = static_cast<int32_T>(sz[1]);
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(b_cpu_y, xpageoffset, &f_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(cpu_cfs, &gpu_cfs, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(b_cpu_y, &gpu_y, true);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_cfs, cpu_cfs);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wtAvg_fp_kernel2#" MW_AT_LINE);
        ec_wtAvg_fp_kernel2<<<grid, block>>>(gpu_cfs, nx - 1, gpu_y);
      }
      profileLoopStart("ec_wtAvg_fp_loop_4", __LINE__, 1 + 1, "");
      for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
        sz[xpageoffset] = static_cast<uint32_T>(b_cpu_y->size[xpageoffset]);
      }
      profileLoopEnd();
      xpageoffset = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = static_cast<int32_T>(sz[0]);
      b_cpu_x->size[1] = static_cast<int32_T>(sz[1]);
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(b_cpu_x, xpageoffset, &h_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(
          computeNumIters(
              static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1),
          &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(b_cpu_x, &b_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wtAvg_fp_kernel3#" MW_AT_LINE);
        ec_wtAvg_fp_kernel3<<<grid, block>>>(
            gpu_y,
            static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1,
            b_gpu_x);
      }
      vlen = b_cpu_x->size[0] * b_cpu_x->size[1];
      if (b_cpu_x->size[0] * b_cpu_x->size[1] == 0) {
        b = 0.0F;
      } else {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_x, &b_gpu_x);
        b = b_cpu_x->data[0];
        profileLoopStart("ec_wtAvg_fp_loop_5", __LINE__, (vlen - 2) + 1, "");
        for (nx = 0; nx <= vlen - 2; nx++) {
          b += b_cpu_x->data[nx + 1];
        }
        profileLoopEnd();
      }
      x = fb.sigvar;
      b = std::sqrt(x / (static_cast<real32_T>(
                             1.0 / static_cast<real_T>(Scales->size[1])) *
                         b));
      xpageoffset = cpu_cfsnorm->size[0] * cpu_cfsnorm->size[1];
      cpu_cfsnorm->size[0] = cpu_cfs->size[0];
      cpu_cfsnorm->size[1] = cpu_cfs->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(cpu_cfsnorm, xpageoffset, &i_emlrtRTEI);
      r_outdatedOnCpu = true;
      if ((cpu_cfs->size[0] != 0) && (cpu_cfs->size[1] != 0)) {
        nx = (cpu_cfs->size[1] != 1);
        vlen = cpu_cfs->size[1] - 1;
        xpageoffset = cpu_cfsnorm->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(vlen, xpageoffset), &grid,
                                &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(cpu_cfsnorm, &gpu_cfsnorm, true);
        r_outdatedOnCpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wtAvg_fp_kernel4#" MW_AT_LINE);
          ec_wtAvg_fp_kernel4<<<grid, block>>>(
              b, gpu_cfs, nx, xpageoffset, vlen, gpu_cfsnorm, cpu_cfs->size[0U],
              cpu_cfsnorm->size[0U]);
        }
      }
      nFrames = 1.0 / static_cast<real_T>(Scales->size[1]);
      xpageoffset = c_cpu_x->size[0] * c_cpu_x->size[1];
      c_cpu_x->size[0] = static_cast<int32_T>(defaultSL_idx_1);
      c_cpu_x->size[1] = cpu_cfsnorm->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(c_cpu_x, xpageoffset, &j_emlrtRTEI);
      xpageoffset = cpu_cfsnorm->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(
          computeNumIters(xpageoffset,
                          static_cast<int32_T>(defaultSL_idx_1) - 1),
          &grid, &block, 2147483647U);
      if (r_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(cpu_cfsnorm, &gpu_cfsnorm, true);
      }
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(c_cpu_x, &c_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wtAvg_fp_kernel5#" MW_AT_LINE);
        ec_wtAvg_fp_kernel5<<<grid, block>>>(
            gpu_cfsnorm, static_cast<int32_T>(defaultSL_idx_1) - 1, xpageoffset,
            c_gpu_x, c_cpu_x->size[0U], cpu_cfsnorm->size[0U]);
      }
      nx = static_cast<int32_T>(defaultSL_idx_1) * cpu_cfsnorm->size[1];
      xpageoffset = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = static_cast<int32_T>(defaultSL_idx_1);
      c_cpu_y->size[1] = cpu_cfsnorm->size[1];
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(c_cpu_y, xpageoffset, &f_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(c_cpu_y, &b_gpu_y, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wtAvg_fp_kernel6#" MW_AT_LINE);
        ec_wtAvg_fp_kernel6<<<grid, block>>>(c_gpu_x, nx - 1, b_gpu_y);
      }
      profileLoopStart("ec_wtAvg_fp_loop_6", __LINE__, 1 + 1, "");
      for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
        sz[xpageoffset] = static_cast<uint32_T>(c_cpu_y->size[xpageoffset]);
      }
      profileLoopEnd();
      xpageoffset = d_cpu_x->size[0] * d_cpu_x->size[1];
      d_cpu_x->size[0] = static_cast<int32_T>(sz[0]);
      d_cpu_x->size[1] = static_cast<int32_T>(sz[1]);
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(d_cpu_x, xpageoffset, &h_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(
          computeNumIters(
              static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1),
          &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(d_cpu_x, &d_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wtAvg_fp_kernel7#" MW_AT_LINE);
        ec_wtAvg_fp_kernel7<<<grid, block>>>(
            b_gpu_y,
            static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1,
            d_gpu_x);
      }
      vlen = d_cpu_x->size[0];
      if ((d_cpu_x->size[0] == 0) || (d_cpu_x->size[1] == 0)) {
        profileLoopStart("ec_wtAvg_fp_loop_7", __LINE__, 1 + 1, "");
        for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
          sz[xpageoffset] = static_cast<uint32_T>(d_cpu_x->size[xpageoffset]);
        }
        profileLoopEnd();
        xpageoffset = cpu_b->size[0] * cpu_b->size[1];
        cpu_b->size[0] = 1;
        cpu_b->size[1] = static_cast<int32_T>(sz[1]);
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(cpu_b, xpageoffset, &l_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(
            computeNumIters(static_cast<int32_T>(sz[1]) - 1), &grid, &block,
            2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wtAvg_fp_kernel8#" MW_AT_LINE);
          ec_wtAvg_fp_kernel8<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
                                               gpu_b);
        }
      } else {
        nx = d_cpu_x->size[1];
        xpageoffset = cpu_b->size[0] * cpu_b->size[1];
        cpu_b->size[0] = 1;
        cpu_b->size[1] = d_cpu_x->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(cpu_b, xpageoffset, &k_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wtAvg_fp_kernel13#" MW_AT_LINE);
          ec_wtAvg_fp_kernel13<<<grid, block>>>(vlen, d_gpu_x, nx - 1, gpu_b,
                                                d_cpu_x->size[0U]);
        }
      }
      xpageoffset = cpu_fv->size[0];
      cpu_fv->size[0] = cpu_b->size[1];
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(cpu_fv, xpageoffset, &d_emlrtRTEI);
      xpageoffset = cpu_b->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wtAvg_fp_kernel9#" MW_AT_LINE);
        ec_wtAvg_fp_kernel9<<<grid, block>>>(gpu_b, nFrames, xpageoffset,
                                             gpu_fv);
      }
      //  Power
    } else {
      // 'ec_wtAvg_fp:54' else
      // 'ec_wtAvg_fp:55' yc = scaleSpectrum(fb,xc,SpectrumType="density")';
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real32_T(cpu_xc, &gpu_xc);
      nvtxMarkA("#cwtfilterbank_scaleSpectrum#" MW_AT_LINE);
      coder::cwtfilterbank_scaleSpectrum(&fb, cpu_xc, cpu_r, &r_outdatedOnCpu,
                                         &gpu_r, &r_outdatedOnGpu);
      xpageoffset = cpu_fv->size[0];
      cpu_fv->size[0] = cpu_r->size[1];
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(cpu_fv, xpageoffset, &d_emlrtRTEI);
      xpageoffset = cpu_r->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_r, &gpu_r, !r_outdatedOnGpu);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
      if (r_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_r, cpu_r);
      }
      r_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wtAvg_fp_kernel14#" MW_AT_LINE);
        ec_wtAvg_fp_kernel14<<<grid, block>>>(gpu_r, xpageoffset, gpu_fv);
      }
      //  Magnitude
    }
    //  Downsample
    // 'ec_wtAvg_fp:59' if ds
    if (ds != 0.0) {
      // 'ec_wtAvg_fp:60' yc = downsample(yc,ds);
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
        emlrt_marshallIn(b_sprintf(y, b_y, &c_emlrtMCI), "<output of sprintf>",
                         unusedExpr);
      }
      nx = cpu_fv->size[0] - 1;
      xpageoffset = b_cpu_fv->size[0];
      nvtxMarkA("#div_s32#" MW_AT_LINE);
      b_cpu_fv->size[0] =
          div_s32(cpu_fv->size[0] - 1, static_cast<int32_T>(ds)) + 1;
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(b_cpu_fv, xpageoffset, &g_emlrtRTEI);
      xpageoffset = nx / static_cast<int32_T>(ds);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(b_cpu_fv, &b_gpu_fv, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wtAvg_fp_kernel10#" MW_AT_LINE);
        ec_wtAvg_fp_kernel10<<<grid, block>>>(gpu_fv, ds, xpageoffset,
                                              b_gpu_fv);
      }
      xpageoffset = cpu_fv->size[0];
      cpu_fv->size[0] = b_cpu_fv->size[0];
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(cpu_fv, xpageoffset, &d_emlrtRTEI);
      xpageoffset = b_cpu_fv->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wtAvg_fp_kernel11#" MW_AT_LINE);
        ec_wtAvg_fp_kernel11<<<grid, block>>>(b_gpu_fv, xpageoffset, gpu_fv);
      }
    }
    nx = cpu_y->size[0];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                            2147483647U);
    if (y_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_y, &c_gpu_y, true);
    }
    y_needsGpuEnsureCapacity = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#ec_wtAvg_fp_kernel12#" MW_AT_LINE);
      ec_wtAvg_fp_kernel12<<<grid, block>>>(gpu_fv, ch, nx - 1, c_gpu_y,
                                            cpu_y->size[0U]);
    }
    r_outdatedOnCpu = true;
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_fv);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_r);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_b);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&d_cpu_x);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_cpu_y);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&c_cpu_x);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_cfsnorm);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_x);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_y);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_cfs);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&Scales);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_fv);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_xc);
  nvtxMarkA("#emxFreeStruct_cwtfilterbank#" MW_AT_LINE);
  emxFreeStruct_cwtfilterbank(&fb);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (r_outdatedOnCpu) {
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_y, &c_gpu_y);
  }
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_x);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_xc);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_fv);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_cfs);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_x);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_cfsnorm);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&c_gpu_x);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&d_gpu_x);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_b);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_r);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_fv);
  nvtxRangePop();
  nvtxMarkA("#entryPointEnd#");
}

// End of code generation (ec_wtAvg_fp.cu)
