//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// cwt.cu
//
// Code generation for function 'cwt'
//

// Include files
#include "cwt.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "log2.h"
#include "rt_nonfinite.h"
#include "MWCUFFTPlanManager.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "cufft.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emxArray_real32_T *psidft;

static boolean_T psidft_not_empty;

static emxArray_real32_T *cf;

static boolean_T cf_not_empty;

static emlrtMCInfo emlrtMCI{
    53,                                                                // lineNo
    14,                                                                // colNo
    "nonConstPrint",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/strfun/sprintf.m" // pName
};

static emlrtMCInfo b_emlrtMCI{
    55,                                                                // lineNo
    15,                                                                // colNo
    "nonConstPrint",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/strfun/sprintf.m" // pName
};

static emlrtRTEInfo emlrtRTEI{
    32,                                                  // lineNo
    12,                                                  // colNo
    "cwt",                                               // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/eml/cwt.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    33,                                                  // lineNo
    12,                                                  // colNo
    "cwt",                                               // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/eml/cwt.m" // pName
};

static emlrtRTEInfo t_emlrtRTEI{
    1,    // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "wt.p" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    1,        // lineNo
    1,        // colNo
    "realWT", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "realWT.p" // pName
};

static emlrtRTEInfo v_emlrtRTEI{
    1,             // lineNo
    1,             // colNo
    "cwtFreqGrid", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "cwtFreqGrid.p" // pName
};

static emlrtRTEInfo w_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "cuFFTNDCallback", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "cuFFTNDCallback.p" // pName
};

static emlrtRTEInfo x_emlrtRTEI{
    1,           // lineNo
    1,           // colNo
    "cwtScales", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "cwtScales.p" // pName
};

static emlrtRTEInfo y_emlrtRTEI{
    1,              // lineNo
    1,              // colNo
    "freqToScales", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "freqToScales.p" // pName
};

static emlrtRTEInfo ab_emlrtRTEI{
    1,                // lineNo
    1,                // colNo
    "morseBPFilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "morseBPFilters.p" // pName
};

static emlrtRTEInfo bb_emlrtRTEI{
    104,                                                 // lineNo
    5,                                                   // colNo
    "cwt",                                               // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/eml/cwt.m" // pName
};

static emlrtRTEInfo cb_emlrtRTEI{
    107,                                                 // lineNo
    9,                                                   // colNo
    "cwt",                                               // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/eml/cwt.m" // pName
};

static emlrtRTEInfo db_emlrtRTEI{
    1,                                                   // lineNo
    24,                                                  // colNo
    "cwt",                                               // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/eml/cwt.m" // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_char_T *ret);

static
#ifdef __CUDACC__
    __device__
#endif
        int64_T
        computeEndIdx_device(int64_T start, int64_T end, int64_T stride);

static __global__ void cwt_kernel14(boolean_T b[2], real_T FreqLimits[2],
                                    real_T varargin_2_dim0,
                                    real_T varargin_2_dim1);

static __global__ void cwt_kernel15(const real_T maxscale,
                                    real_T FreqLimits[2]);

static __global__ void cwt_kernel16(const real_T fs, real_T FreqLimits[2]);

static __global__ void cwt_kernel17(const int32_T N, const real_T maxscale,
                                    const int32_T M, emxArray_real_T omega);

static __global__ void cwt_kernel18(const real_T a0, const real_T s0,
                                    const int32_T b, emxArray_real_T scales);

static __global__ void
cwt_kernel19(const real_T fs, const emxArray_real_T omega,
             const emxArray_real_T scales, const int32_T M, const int32_T b,
             const int32_T c, emxArray_real32_T b_cf,
             emxArray_real32_T b_psidft, int32_T psidft_dim0);

static __global__ void cwt_kernel20(const emxArray_real32_T x, const int32_T M,
                                    const int32_T Npad, const int32_T b,
                                    emxArray_real32_T xv);

static __global__ void cwt_kernel21(const emxArray_creal32_T xdft,
                                    const int32_T b, const int32_T c,
                                    emxArray_real32_T b_psidft,
                                    emxArray_creal32_T cfsdft,
                                    int32_T cfsdft_dim0, int32_T psidft_dim0);

static __global__ void cwt_kernel22(const int32_T xSize,
                                    emxArray_creal32_T cfstmp);

static __global__ void cwt_kernel23(const emxArray_creal32_T cfstmp,
                                    const int32_T Npad, const int32_T M,
                                    const int32_T Ns, emxArray_creal32_T cfs,
                                    int32_T cfs_dim0, int32_T cfstmp_dim0);

static __global__ void cwt_kernel24(const emxArray_creal32_T cfstmp,
                                    const int32_T b, const int32_T Ns,
                                    emxArray_creal32_T cfs, int32_T cfs_dim0,
                                    int32_T cfstmp_dim0);

static __global__ void cwt_kernel25(const real32_T cfsdft_re,
                                    const emxArray_creal32_T cfsdft,
                                    const int32_T b_cfsdft,
                                    emxArray_creal32_T cfstmp);

static __global__ void cwt_kernel26(const emxArray_real32_T xv,
                                    const int32_T b_xv,
                                    emxArray_creal32_T xdft);

static __global__ void cwt_kernel27(const int32_T b, emxArray_creal32_T xdft,
                                    uint32_T xSize_dim1);

static __global__ void cwt_kernel28(const emxArray_real32_T x, const int32_T b,
                                    emxArray_real32_T xv);

static __global__ void cwt_kernel29(const real_T a0, const int32_T b,
                                    emxArray_real_T scales);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_char_T *y);

static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
                             emxArray_char_T *y);

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            const mxArray *m3, emlrtMCInfo *location);

static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
                                        emxArray_real_T *gpu,
                                        boolean_T needsCopy);

static void gpuEmxFree_real_T(emxArray_real_T *gpu);

static void gpuEmxReset_real_T(emxArray_real_T *gpu);

static const mxArray *length(const mxArray *m1, emlrtMCInfo *location);

static real_T rt_powd_snf(real_T u0, real_T u1);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_char_T *ret)
{
  static const int32_T dims[2]{1, -1};
  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{false, true};
  nvtxRangePushA("#fcn#b_emlrt_marshallIn#" MW_AT_LOCATION);
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  nvtxMarkA("#emxEnsureCapacity_char_T#" MW_AT_LINE);
  emxEnsureCapacity_char_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, &ret->data[0], 1, false);
  emlrtDestroyArray(&src);
  nvtxRangePop();
}

static __device__ int64_T computeEndIdx_device(int64_T start, int64_T end,
                                               int64_T stride)
{
  int64_T newEnd;
  newEnd = -1L;
  if ((stride > 0L) && (start <= end)) {
    newEnd = (end - start) / stride;
  } else if ((stride < 0L) && (end <= start)) {
    newEnd = (start - end) / -stride;
  }
  return newEnd;
}

static __global__ __launch_bounds__(32,
                                    1) void cwt_kernel14(boolean_T b[2],
                                                         real_T FreqLimits[2],
                                                         real_T varargin_2_dim0,
                                                         real_T varargin_2_dim1)
{
  __shared__ real_T varargin_2_shared[2];
  int32_T jj;
  if (mwGetThreadIndexWithinBlock() == 0U) {
    varargin_2_shared[0] = varargin_2_dim0;
    varargin_2_shared[1] = varargin_2_dim1;
  }
  __syncthreads();
  jj = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (jj < 2) {
    FreqLimits[jj] = varargin_2_shared[jj];
    b[jj] = isnan(varargin_2_shared[jj]);
  }
}

static __global__ __launch_bounds__(32,
                                    1) void cwt_kernel15(const real_T maxscale,
                                                         real_T FreqLimits[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    FreqLimits[0] = maxscale;
  }
}

static __global__ __launch_bounds__(32,
                                    1) void cwt_kernel16(const real_T fs,
                                                         real_T FreqLimits[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    FreqLimits[1] = fs / 2.0;
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void cwt_kernel17(const int32_T N,
                                                         const real_T maxscale,
                                                         const int32_T M,
                                                         emxArray_real_T omega)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(M);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    omega.data[kk] = static_cast<real_T>(kk) * maxscale;
    i = kk + M;
    if (i > 2147483645) {
      i = MAX_int32_T;
    } else {
      i += 2;
    }
    if (i <= N) {
      i = kk + M;
      if (i > 2147483645) {
        i = MAX_int32_T;
      } else {
        i += 2;
      }
      omega.data[i - 1] = 0.0;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void cwt_kernel18(
    const real_T a0, const real_T s0, const int32_T b, emxArray_real_T scales)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    scales.data[kk] = s0 * pow(a0, (static_cast<real_T>(kk) + 1.0) - 1.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void cwt_kernel19(
    const real_T fs, const emxArray_real_T omega, const emxArray_real_T scales,
    const int32_T M, const int32_T b, const int32_T c, emxArray_real32_T b_cf,
    emxArray_real32_T b_psidft, int32_T psidft_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T jj;
    int32_T kk;
    jj = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    kk = static_cast<int32_T>((idx - static_cast<uint64_T>(jj)) /
                              (static_cast<uint64_T>(b) + 1UL));
    if (jj + 1 > M) {
      b_psidft.data[kk + psidft_dim0 * jj] = 0.0F;
    } else {
      real_T d;
      real_T d1;
      d = scales.data[kk];
      d1 = omega.data[jj];
      b_psidft.data[kk + psidft_dim0 * jj] = static_cast<real32_T>(
          0.0050536085896138571 * exp(20.0 * log(d * d1) - pow(d * d1, 3.0)));
    }
    if (jj + 1 == 1) {
      b_cf.data[kk] = static_cast<real32_T>(
          1.8820720577620569 / scales.data[kk] / 6.2831853071795862 * fs);
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void cwt_kernel20(
    const emxArray_real32_T x, const int32_T M, const int32_T Npad,
    const int32_T b, emxArray_real32_T xv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    if (kk < Npad) {
      xv.data[kk] = x.data[(Npad - kk) - 1];
    } else {
      int32_T qY;
      boolean_T guard1;
      guard1 = false;
      if (kk + 1 > Npad) {
        if (M > MAX_int32_T - Npad) {
          qY = MAX_int32_T;
        } else {
          qY = Npad + M;
        }
        if (kk + 1 <= qY) {
          qY = (Npad - kk) - 1;
          if (qY < 0) {
            qY = -qY;
          }
          xv.data[kk] = x.data[qY - 1];
        } else {
          guard1 = true;
        }
      } else {
        guard1 = true;
      }
      if (guard1) {
        if ((M > 0) && (Npad > MAX_int32_T - M)) {
          qY = MAX_int32_T;
        } else {
          qY = M + Npad;
        }
        if (kk + 1 > qY) {
          if (M > 1073741823) {
            qY = MAX_int32_T;
          } else {
            qY = M << 1;
          }
          qY = (qY - kk) - 1;
          if ((qY < 0) && (Npad < MIN_int32_T - qY)) {
            qY = MIN_int32_T;
          } else if ((qY > 0) && (Npad > MAX_int32_T - qY)) {
            qY = MAX_int32_T;
          } else {
            qY += Npad;
          }
          if (qY <= 2147483646) {
            qY++;
          }
          xv.data[kk] = x.data[qY - 1];
        }
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void cwt_kernel21(
    const emxArray_creal32_T xdft, const int32_T b, const int32_T c,
    emxArray_real32_T b_psidft, emxArray_creal32_T cfsdft, int32_T cfsdft_dim0,
    int32_T psidft_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T jj;
    int32_T kk;
    jj = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    kk = static_cast<int32_T>((idx - static_cast<uint64_T>(jj)) /
                              (static_cast<uint64_T>(b) + 1UL));
    cfsdft.data[kk + cfsdft_dim0 * jj].re =
        b_psidft.data[kk + psidft_dim0 * jj] * xdft.data[jj].re;
    cfsdft.data[kk + cfsdft_dim0 * jj].im =
        b_psidft.data[kk + psidft_dim0 * jj] * xdft.data[jj].im;
  }
}

static __global__
    __launch_bounds__(1024, 1) void cwt_kernel22(const int32_T xSize,
                                                 emxArray_creal32_T cfstmp)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xSize);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T jj;
    jj = static_cast<int32_T>(idx);
    cfstmp.data[jj].re = 0.0F;
    cfstmp.data[jj].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void cwt_kernel23(
    const emxArray_creal32_T cfstmp, const int32_T Npad, const int32_T M,
    const int32_T Ns, emxArray_creal32_T cfs, int32_T cfs_dim0,
    int32_T cfstmp_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(Ns);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T jj;
    int32_T qY;
    i = static_cast<int32_T>(idx);
    if (M > MAX_int32_T - Npad) {
      qY = MAX_int32_T;
    } else {
      qY = Npad + M;
    }
    jj = Npad + 1;
    for (int64_T b_jj{0L};
         b_jj <= computeEndIdx_device(static_cast<int64_T>(jj),
                                      static_cast<int64_T>(qY), 1L);
         b_jj++) {
      cfs.data[i + cfs_dim0 * ((static_cast<int32_T>(
                                    static_cast<int64_T>(Npad + 1) + b_jj) -
                                Npad) -
                               1)] =
          cfstmp.data[i + cfstmp_dim0 *
                              (static_cast<int32_T>(
                                   static_cast<int64_T>(Npad + 1) + b_jj) -
                               1)];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void cwt_kernel24(
    const emxArray_creal32_T cfstmp, const int32_T b, const int32_T Ns,
    emxArray_creal32_T cfs, int32_T cfs_dim0, int32_T cfstmp_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(Ns) + 1UL) * (static_cast<uint64_T>(b) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T jj;
    jj = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(jj)) /
                             (static_cast<uint64_T>(b) + 1UL));
    cfs.data[i + cfs_dim0 * jj] = cfstmp.data[i + cfstmp_dim0 * jj];
  }
}

static __global__ __launch_bounds__(1024, 1) void cwt_kernel25(
    const real32_T cfsdft_re, const emxArray_creal32_T cfsdft,
    const int32_T b_cfsdft, emxArray_creal32_T cfstmp)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfsdft);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T jj;
    real32_T ai;
    real32_T ar;
    jj = static_cast<int32_T>(idx);
    ar = cfsdft.data[jj].re;
    ai = cfsdft.data[jj].im;
    if (ai == 0.0F) {
      cfstmp.data[jj].re = ar / cfsdft_re;
      cfstmp.data[jj].im = 0.0F;
    } else if (ar == 0.0F) {
      cfstmp.data[jj].re = 0.0F;
      cfstmp.data[jj].im = ai / cfsdft_re;
    } else {
      cfstmp.data[jj].re = ar / cfsdft_re;
      cfstmp.data[jj].im = ai / cfsdft_re;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void cwt_kernel26(
    const emxArray_real32_T xv, const int32_T b_xv, emxArray_creal32_T xdft)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T jj;
    jj = static_cast<int32_T>(idx);
    xdft.data[jj].re = xv.data[jj];
    xdft.data[jj].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void cwt_kernel27(
    const int32_T b, emxArray_creal32_T xdft, uint32_T xSize_dim1)
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
    xdft.data[(static_cast<int32_T>(xSize_dim1) - i) - 1].re =
        xdft.data[i + 1].re;
    xdft.data[(static_cast<int32_T>(xSize_dim1) - i) - 1].im =
        -xdft.data[i + 1].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void cwt_kernel28(
    const emxArray_real32_T x, const int32_T b, emxArray_real32_T xv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    xv.data[kk] = x.data[kk];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void cwt_kernel29(const real_T a0,
                                                         const int32_T b,
                                                         emxArray_real_T scales)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    scales.data[kk] =
        0.68998891650046823 * pow(a0, (static_cast<real_T>(kk) + 1.0) - 1.0);
  }
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_char_T *y)
{
  nvtxRangePushA("#fcn#emlrt_marshallIn#" MW_AT_LOCATION);
  nvtxMarkA("#b_emlrt_marshallIn#" MW_AT_LINE);
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
  nvtxRangePop();
}

static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
                             emxArray_char_T *y)
{
  emlrtMsgIdentifier thisId;
  nvtxRangePushA("#fcn#emlrt_marshallIn#" MW_AT_LOCATION);
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
  emlrt_marshallIn(emlrtAlias(tmpStr), &thisId, y);
  emlrtDestroyArray(&tmpStr);
  nvtxRangePop();
}

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            const mxArray *m3, emlrtMCInfo *location)
{
  const mxArray *pArrays[3];
  const mxArray *m;
  const mxArray *m4;
  nvtxRangePushA("#fcn#feval#" MW_AT_LOCATION);
  pArrays[0] = m1;
  pArrays[1] = m2;
  pArrays[2] = m3;
  m4 = emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 3, &pArrays[0], "feval",
                             true, location);
  nvtxRangePop();
  return m4;
}

static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
                                        emxArray_real_T *gpu,
                                        boolean_T needsCopy)
{
  real_T *newData;
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  nvtxRangePushA("#fcn#gpuEmxEnsureCapacity_real_T#" MW_AT_LOCATION);
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxEnsureCapacity_real_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (gpu->allocatedSize < totalSizeCpu) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(real_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(real_T),
                     cudaMemcpyDeviceToDevice),
          __FILE__, __LINE__);
    }
    if (gpu->canFreeData) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }
    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
  nvtxRangePop();
}

static void gpuEmxFree_real_T(emxArray_real_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxFree_real_T#" MW_AT_LOCATION);
  if (gpu->data != (void *)4207599121UL) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
  nvtxRangePop();
}

static void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxReset_real_T#" MW_AT_LOCATION);
  std::memset(gpu, 0, sizeof(emxArray_real_T));
  nvtxRangePop();
}

static const mxArray *length(const mxArray *m1, emlrtMCInfo *location)
{
  const mxArray *m;
  const mxArray *m2;
  const mxArray *pArray;
  nvtxRangePushA("#fcn#length#" MW_AT_LOCATION);
  pArray = m1;
  m2 = emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 1, &pArray, "length",
                             true, location);
  nvtxRangePop();
  return m2;
}

static real_T rt_powd_snf(real_T u0, real_T u1)
{
  real_T y;
  nvtxRangePushA("#fcn#rt_powd_snf#" MW_AT_LOCATION);
  if (std::isnan(u0) || std::isnan(u1)) {
    y = rtNaN;
  } else {
    real_T b;
    real_T c;
    b = std::abs(u0);
    c = std::abs(u1);
    if (std::isinf(u1)) {
      if (b == 1.0) {
        y = 1.0;
      } else if (b > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (c == 0.0) {
      y = 1.0;
    } else if (c == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = std::sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > std::floor(u1))) {
      y = rtNaN;
    } else {
      y = std::pow(u0, u1);
    }
  }
  nvtxRangePop();
  return y;
}

//
//
namespace coder {
void cwt(emxArray_real32_T *cpu_x, emxArray_real32_T *gpu_x,
         boolean_T *x_outdatedOnGpu, real_T fs, const real_T varargin_2[2],
         real_T varargin_4, emxArray_creal32_T *cpu_cfs,
         boolean_T *cfs_outdatedOnCpu, emxArray_creal32_T *gpu_cfs,
         boolean_T *cfs_outdatedOnGpu)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 5};
  static const char_T u[7]{'s', 'p', 'r', 'i', 'n', 't', 'f'};
  static const char_T formatSpec[5]{'%', '2', '.', '2', 'f'};
  dim3 block;
  dim3 grid;
  emxArray_char_T *b_tmpStr;
  emxArray_creal32_T gpu_cfsdft;
  emxArray_creal32_T gpu_cfstmp;
  emxArray_creal32_T gpu_xdft;
  emxArray_creal32_T *cpu_cfsdft;
  emxArray_creal32_T *cpu_cfstmp;
  emxArray_creal32_T *cpu_xdft;
  emxArray_real32_T gpu_cf;
  emxArray_real32_T gpu_psidft;
  emxArray_real32_T gpu_xv;
  emxArray_real32_T *cpu_xv;
  emxArray_real_T gpu_omega;
  emxArray_real_T gpu_scales;
  emxArray_real_T *cpu_omega;
  emxArray_real_T *cpu_scales;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *tmpStr;
  real_T(*gpu_FreqLimits)[2];
  int32_T M;
  int32_T N;
  int32_T Nomega;
  int32_T Npad;
  int32_T Ns;
  int32_T i;
  uint32_T xSize[2];
  boolean_T(*gpu_b)[2];
  boolean_T validLaunchParams;
  boolean_T xdft_needsGpuEnsureCapacity;
  nvtxRangePushA("#fcn#cwt#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_cf);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_psidft);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_scales);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_cfsdft);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_omega);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_xdft);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_cfstmp);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_xv);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_b, 2UL), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_FreqLimits, 16UL), __FILE__, __LINE__);
  xdft_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if (!psidft_not_empty) {
    real_T cpu_FreqLimits[2];
    real_T maxscale;
    boolean_T cpu_b[2];
    boolean_T FreqLimits_outdatedOnCpu;
    boolean_T b_outdatedOnCpu;
    boolean_T exitg1;
    boolean_T y;
    N = static_cast<int32_T>(
        std::trunc(static_cast<real_T>(cpu_x->size[0]) / 2.0));
    nvtxMarkA("#cwt_kernel14#" MW_AT_LINE);
    cwt_kernel14<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
        *gpu_b, *gpu_FreqLimits, varargin_2[0], varargin_2[1]);
    FreqLimits_outdatedOnCpu = true;
    b_outdatedOnCpu = true;
    y = true;
    Nomega = 0;
    exitg1 = false;
    nvtxRangePushA("#loop#cwt_whileloop_1##" MW_AT_LINE);
    while ((!exitg1) && (Nomega < 2)) {
      if (b_outdatedOnCpu) {
        nvtxMarkA("#checkCudaError#" MW_AT_LINE);
        nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
        checkCudaError(cudaMemcpy(cpu_b, *gpu_b, 2UL, cudaMemcpyDeviceToHost),
                       __FILE__, __LINE__);
      }
      b_outdatedOnCpu = false;
      if (!cpu_b[Nomega]) {
        y = false;
        exitg1 = true;
      } else {
        Nomega++;
      }
    }
    nvtxRangePop();
    if (!y) {
      maxscale = static_cast<real_T>(cpu_x->size[0]) / 11.001547073884861;
      nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
      if (maxscale < 0.68998891650046823 * rt_powd_snf(2.0, 1.0 / varargin_4)) {
        nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
        maxscale = 0.68998891650046823 * rt_powd_snf(2.0, 1.0 / varargin_4);
      }
      maxscale = 1.0 / (maxscale * 3.3384403542183319) * fs;
      if (varargin_2[0] < maxscale) {
        nvtxMarkA("#cwt_kernel15#" MW_AT_LINE);
        cwt_kernel15<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(maxscale,
                                                              *gpu_FreqLimits);
      }
      if (varargin_2[1] > fs / 2.0) {
        nvtxMarkA("#cwt_kernel16#" MW_AT_LINE);
        cwt_kernel16<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs,
                                                              *gpu_FreqLimits);
      }
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
      checkCudaError(cudaMemcpy(cpu_FreqLimits, *gpu_FreqLimits, 16UL,
                                cudaMemcpyDeviceToHost),
                     __FILE__, __LINE__);
      FreqLimits_outdatedOnCpu = false;
      nvtxMarkA("#b_log2#" MW_AT_LINE);
      nvtxMarkA("#b_log2#" MW_AT_LINE);
      if (!(b_log2(cpu_FreqLimits[1]) - b_log2(cpu_FreqLimits[0]) >=
            1.0 / varargin_4)) {
        tmpStr = nullptr;
        b_y = nullptr;
        m = emlrtCreateCharArray(2, &iv[0]);
        emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
        emlrtAssign(&b_y, m);
        c_y = nullptr;
        m1 = emlrtCreateCharArray(2, &iv1[0]);
        emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 5, m1, &formatSpec[0]);
        emlrtAssign(&c_y, m1);
        d_y = nullptr;
        m2 = emlrtCreateDoubleScalar(1.0 / varargin_4);
        emlrtAssign(&d_y, m2);
        nvtxMarkA("#feval#" MW_AT_LINE);
        emlrtAssign(&tmpStr, feval(b_y, c_y, d_y, &emlrtMCI));
        nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
        nvtxMarkA("#length#" MW_AT_LINE);
        emlrt_marshallIn(length(emlrtAlias(tmpStr), &b_emlrtMCI),
                         "<output of length>");
        nvtxMarkA("#emxInit_char_T#" MW_AT_LINE);
        emxInit_char_T(&b_tmpStr, 2, &db_emlrtRTEI, true);
        nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
        emlrt_marshallIn(emlrtAlias(tmpStr), "tmpStr", b_tmpStr);
        nvtxMarkA("#emxFree_char_T#" MW_AT_LINE);
        emxFree_char_T(&b_tmpStr);
        emlrtDestroyArray(&tmpStr);
      }
    }
    if (cpu_x->size[0] > 100000) {
      nvtxMarkA("#b_log2#" MW_AT_LINE);
      maxscale = std::ceil(b_log2(static_cast<real_T>(cpu_x->size[0])));
      if (maxscale < 2.147483648E+9) {
        if (maxscale >= -2.147483648E+9) {
          N = static_cast<int32_T>(maxscale);
        } else {
          N = MIN_int32_T;
        }
      } else if (maxscale >= 2.147483648E+9) {
        N = MAX_int32_T;
      } else {
        N = 0;
      }
    }
    if (N > 1073741823) {
      Nomega = MAX_int32_T;
    } else if (N <= -1073741824) {
      Nomega = MIN_int32_T;
    } else {
      Nomega = N << 1;
    }
    if ((cpu_x->size[0] > 0) && (Nomega > MAX_int32_T - cpu_x->size[0])) {
      N = MAX_int32_T;
    } else {
      N = cpu_x->size[0] + Nomega;
    }
    M = static_cast<int32_T>(std::trunc(static_cast<real_T>(N) / 2.0));
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_omega, 2, &bb_emlrtRTEI, true);
    i = cpu_omega->size[0] * cpu_omega->size[1];
    cpu_omega->size[0] = 1;
    cpu_omega->size[1] = N;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_omega, i, &v_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(M), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_omega, &gpu_omega, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwt_kernel17#" MW_AT_LINE);
      cwt_kernel17<<<grid, block>>>(
          N, 6.2831853071795862 / static_cast<real_T>(N), M, gpu_omega);
    }
    profileLoopStart("cwt_loop_1", __LINE__, 1 + 1, "");
    for (Nomega = 0; Nomega < 2; Nomega++) {
      if (FreqLimits_outdatedOnCpu) {
        nvtxMarkA("#checkCudaError#" MW_AT_LINE);
        nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
        checkCudaError(cudaMemcpy(cpu_FreqLimits, *gpu_FreqLimits, 16UL,
                                  cudaMemcpyDeviceToHost),
                       __FILE__, __LINE__);
      }
      FreqLimits_outdatedOnCpu = false;
      cpu_b[Nomega] = std::isnan(cpu_FreqLimits[Nomega]);
    }
    profileLoopEnd();
    y = true;
    Nomega = 0;
    exitg1 = false;
    nvtxRangePushA("#loop#cwt_whileloop_0##" MW_AT_LINE);
    while ((!exitg1) && (Nomega < 2)) {
      if (!cpu_b[Nomega]) {
        y = false;
        exitg1 = true;
      } else {
        Nomega++;
      }
    }
    nvtxRangePop();
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_scales, 2, &cb_emlrtRTEI, true);
    if (!y) {
      real_T s0;
      profileLoopStart("cwt_loop_2", __LINE__, 1 + 1, "");
      for (Nomega = 0; Nomega < 2; Nomega++) {
        if (FreqLimits_outdatedOnCpu) {
          nvtxMarkA("#checkCudaError#" MW_AT_LINE);
          nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
          checkCudaError(cudaMemcpy(cpu_FreqLimits, *gpu_FreqLimits, 16UL,
                                    cudaMemcpyDeviceToHost),
                         __FILE__, __LINE__);
        }
        cpu_FreqLimits[Nomega] =
            cpu_FreqLimits[Nomega] / fs * 2.0 * 3.1415926535897931;
        FreqLimits_outdatedOnCpu = false;
      }
      profileLoopEnd();
      if (FreqLimits_outdatedOnCpu) {
        nvtxMarkA("#checkCudaError#" MW_AT_LINE);
        nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
        checkCudaError(cudaMemcpy(cpu_FreqLimits, *gpu_FreqLimits, 16UL,
                                  cudaMemcpyDeviceToHost),
                       __FILE__, __LINE__);
      }
      s0 = 1.8820720577620569 / cpu_FreqLimits[1];
      nvtxMarkA("#b_log2#" MW_AT_LINE);
      maxscale = std::floor(
          varargin_4 * b_log2(1.8820720577620569 / cpu_FreqLimits[0] / s0));
      if (maxscale < 2.147483648E+9) {
        if (maxscale >= -2.147483648E+9) {
          Nomega = static_cast<int32_T>(maxscale);
        } else {
          Nomega = MIN_int32_T;
        }
      } else if (maxscale >= 2.147483648E+9) {
        Nomega = MAX_int32_T;
      } else {
        Nomega = 0;
      }
      if (Nomega > 2147483646) {
        Ns = MAX_int32_T;
      } else {
        Ns = Nomega + 1;
      }
      i = cpu_scales->size[0] * cpu_scales->size[1];
      cpu_scales->size[0] = 1;
      cpu_scales->size[1] = Ns;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_scales, i, &y_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(Ns - 1), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_scales, &gpu_scales, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#cwt_kernel18#" MW_AT_LINE);
        nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
        cwt_kernel18<<<grid, block>>>(rt_powd_snf(2.0, 1.0 / varargin_4), s0,
                                      Ns - 1, gpu_scales);
      }
    } else {
      maxscale = static_cast<real_T>(cpu_x->size[0]) / 11.001547073884861;
      nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
      if (maxscale < 0.68998891650046823 * rt_powd_snf(2.0, 1.0 / varargin_4)) {
        nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
        maxscale = 0.68998891650046823 * rt_powd_snf(2.0, 1.0 / varargin_4);
      }
      nvtxMarkA("#b_log2#" MW_AT_LINE);
      maxscale = std::floor(
          std::fmax(b_log2(maxscale / 0.68998891650046823), 1.0 / varargin_4) *
          varargin_4);
      if (maxscale < 2.147483648E+9) {
        if (maxscale >= -2.147483648E+9) {
          Nomega = static_cast<int32_T>(maxscale);
        } else {
          Nomega = MIN_int32_T;
        }
      } else if (maxscale >= 2.147483648E+9) {
        Nomega = MAX_int32_T;
      } else {
        Nomega = 0;
      }
      if (Nomega > 2147483646) {
        Ns = MAX_int32_T;
      } else {
        Ns = Nomega + 1;
      }
      i = cpu_scales->size[0] * cpu_scales->size[1];
      cpu_scales->size[0] = 1;
      cpu_scales->size[1] = Ns;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_scales, i, &x_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(Ns - 1), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_scales, &gpu_scales, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#cwt_kernel29#" MW_AT_LINE);
        nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
        cwt_kernel29<<<grid, block>>>(rt_powd_snf(2.0, 1.0 / varargin_4),
                                      Ns - 1, gpu_scales);
      }
    }
    Ns = cpu_scales->size[1];
    Nomega = cpu_omega->size[1];
    i = psidft->size[0] * psidft->size[1];
    psidft->size[0] = cpu_scales->size[1];
    psidft->size[1] = cpu_omega->size[1];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(psidft, i, &ab_emlrtRTEI);
    i = cf->size[0];
    cf->size[0] = cpu_scales->size[1];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cf, i, &ab_emlrtRTEI);
    M = static_cast<int32_T>(
            std::trunc(static_cast<real_T>(cpu_omega->size[1]) / 2.0)) +
        1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(Ns - 1, Nomega - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cf, &gpu_cf, false);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(psidft, &gpu_psidft, false);
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_cf, cf);
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_psidft, psidft);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwt_kernel19#" MW_AT_LINE);
      cwt_kernel19<<<grid, block>>>(fs, gpu_omega, gpu_scales, M, Nomega - 1,
                                    Ns - 1, gpu_cf, gpu_psidft,
                                    psidft->size[0U]);
    }
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real32_T(psidft, &gpu_psidft);
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real32_T(cf, &gpu_cf);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_scales);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_omega);
    psidft_not_empty = ((psidft->size[0] != 0) && (psidft->size[1] != 0));
    cf_not_empty = (cf->size[0] != 0);
  }
  M = cpu_x->size[0];
  Npad = static_cast<int32_T>(
      std::trunc(static_cast<real_T>(psidft->size[1] - cpu_x->size[0]) / 2.0));
  Ns = psidft->size[0] - 1;
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_xv, 2, &t_emlrtRTEI, true);
  i = cpu_xv->size[0] * cpu_xv->size[1];
  cpu_xv->size[0] = 1;
  cpu_xv->size[1] = psidft->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(cpu_xv, i, &t_emlrtRTEI);
  i = cpu_cfs->size[0] * cpu_cfs->size[1];
  cpu_cfs->size[0] = psidft->size[0];
  cpu_cfs->size[1] = cpu_x->size[0];
  nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
  emxEnsureCapacity_creal32_T(cpu_cfs, i, &t_emlrtRTEI);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_cfstmp, 2, &t_emlrtRTEI, true);
  N = psidft->size[1];
  if (Npad > 0) {
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(N - 1), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, true);
    if (*x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwt_kernel20#" MW_AT_LINE);
      cwt_kernel20<<<grid, block>>>(*gpu_x, M, Npad, N - 1, gpu_xv);
    }
  } else {
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(M - 1), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, true);
    if (*x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwt_kernel28#" MW_AT_LINE);
      cwt_kernel28<<<grid, block>>>(*gpu_x, M - 1, gpu_xv);
    }
  }
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_xdft, 2, &u_emlrtRTEI, true);
  if (cpu_xv->size[1] == 0) {
    cpu_xdft->size[0] = 1;
    cpu_xdft->size[1] = 0;
  } else if (cpu_xv->size[1] - (static_cast<int32_T>(
                                    static_cast<uint32_T>(cpu_xv->size[1]) >> 1)
                                << 1) ==
             1) {
    cufftHandle fftPlanHandle;
    i = cpu_xdft->size[0] * cpu_xdft->size[1];
    cpu_xdft->size[0] = 1;
    cpu_xdft->size[1] = cpu_xv->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_xdft, i, &u_emlrtRTEI);
    Nomega = cpu_xv->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(Nomega), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_xdft, &gpu_xdft, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwt_kernel26#" MW_AT_LINE);
      cwt_kernel26<<<grid, block>>>(gpu_xv, Nomega, gpu_xdft);
    }
    N = cpu_xdft->size[1];
    fftPlanHandle = acquireCUFFTPlan(1, &N, &N, 1, 1, CUFFT_C2C, 1);
    xdft_needsGpuEnsureCapacity = false;
    cufftExecC2C(fftPlanHandle, (cufftComplex *)&gpu_xdft.data[0],
                 (cufftComplex *)&gpu_xdft.data[0], CUFFT_FORWARD);
  } else {
    N = cpu_xv->size[1];
    profileLoopStart("cwt_loop_0", __LINE__, 1 + 1, "");
    for (Nomega = 0; Nomega < 2; Nomega++) {
      xSize[Nomega] = static_cast<uint32_T>(cpu_xv->size[Nomega]);
    }
    cufftHandle b_fftPlanHandle;
    profileLoopEnd();
    i = cpu_xdft->size[0] * cpu_xdft->size[1];
    cpu_xdft->size[0] = 1;
    cpu_xdft->size[1] = static_cast<int32_T>(xSize[1]);
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_xdft, i, &w_emlrtRTEI);
    b_fftPlanHandle = acquireCUFFTPlan(1, &N, &N, 1, 1, CUFFT_R2C, 1);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_xdft, &gpu_xdft, true);
    cufftExecR2C(b_fftPlanHandle, (cufftReal *)&gpu_xv.data[0],
                 (cufftComplex *)&gpu_xdft.data[0]);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(
        computeNumIters(
            static_cast<int32_T>(
                static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) / 2.0) -
            2),
        &grid, &block, 2147483647U);
    xdft_needsGpuEnsureCapacity = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwt_kernel27#" MW_AT_LINE);
      cwt_kernel27<<<grid, block>>>(
          static_cast<int32_T>(
              static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) / 2.0) -
              2,
          gpu_xdft, xSize[1]);
    }
  }
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_xv);
  N = psidft->size[0];
  Nomega = psidft->size[1];
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_cfsdft, 2, &u_emlrtRTEI, true);
  i = cpu_cfsdft->size[0] * cpu_cfsdft->size[1];
  cpu_cfsdft->size[0] = psidft->size[0];
  cpu_cfsdft->size[1] = psidft->size[1];
  nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
  emxEnsureCapacity_creal32_T(cpu_cfsdft, i, &u_emlrtRTEI);
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(N - 1, Nomega - 1), &grid, &block,
                          2147483647U);
  if (xdft_needsGpuEnsureCapacity) {
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_xdft, &gpu_xdft, true);
  }
  nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real32_T(psidft, &gpu_psidft, false);
  nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_creal32_T(cpu_cfsdft, &gpu_cfsdft, true);
  nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_psidft, psidft);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#cwt_kernel21#" MW_AT_LINE);
    cwt_kernel21<<<grid, block>>>(gpu_xdft, Nomega - 1, N - 1, gpu_psidft,
                                  gpu_cfsdft, cpu_cfsdft->size[0U],
                                  psidft->size[0U]);
  }
  nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
  gpuEmxMemcpyGpuToCpu_real32_T(psidft, &gpu_psidft);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_xdft);
  if ((cpu_cfsdft->size[0] == 0) || (cpu_cfsdft->size[1] == 0)) {
    profileLoopStart("cwt_loop_3", __LINE__, 1 + 1, "");
    for (Nomega = 0; Nomega < 2; Nomega++) {
      xSize[Nomega] = static_cast<uint32_T>(cpu_cfsdft->size[Nomega]);
    }
    profileLoopEnd();
    xSize[1] = static_cast<uint32_T>(cpu_cfsdft->size[1]);
    i = cpu_cfstmp->size[0] * cpu_cfstmp->size[1];
    cpu_cfstmp->size[0] = static_cast<int32_T>(xSize[0]);
    cpu_cfstmp->size[1] = cpu_cfsdft->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_cfstmp, i, &t_emlrtRTEI);
    Nomega =
        static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(Nomega), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_cfstmp, &gpu_cfstmp, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwt_kernel22#" MW_AT_LINE);
      cwt_kernel22<<<grid, block>>>(Nomega, gpu_cfstmp);
    }
  } else {
    cufftHandle c_fftPlanHandle;
    real32_T cfsdft_re;
    N = cpu_cfsdft->size[1];
    c_fftPlanHandle = acquireCUFFTPlan(1, &N, &N, cpu_cfsdft->size[0], 1,
                                       CUFFT_C2C, cpu_cfsdft->size[0]);
    cufftExecC2C(c_fftPlanHandle, (cufftComplex *)&gpu_cfsdft.data[0],
                 (cufftComplex *)&gpu_cfsdft.data[0], CUFFT_INVERSE);
    i = cpu_cfstmp->size[0] * cpu_cfstmp->size[1];
    cpu_cfstmp->size[0] = cpu_cfsdft->size[0];
    cpu_cfstmp->size[1] = cpu_cfsdft->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_cfstmp, i, &t_emlrtRTEI);
    cfsdft_re = static_cast<real32_T>(cpu_cfsdft->size[1]);
    Nomega = cpu_cfsdft->size[0] * cpu_cfsdft->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(Nomega), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_cfstmp, &gpu_cfstmp, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwt_kernel25#" MW_AT_LINE);
      cwt_kernel25<<<grid, block>>>(cfsdft_re, gpu_cfsdft, Nomega, gpu_cfstmp);
    }
  }
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_cfsdft);
  if (Npad > 0) {
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(Ns), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_cfs, gpu_cfs, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwt_kernel23#" MW_AT_LINE);
      cwt_kernel23<<<grid, block>>>(gpu_cfstmp, Npad, M, Ns, *gpu_cfs,
                                    cpu_cfs->size[0U], cpu_cfstmp->size[0U]);
    }
  } else {
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(Ns, M - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_cfs, gpu_cfs, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwt_kernel24#" MW_AT_LINE);
      cwt_kernel24<<<grid, block>>>(gpu_cfstmp, M - 1, Ns, *gpu_cfs,
                                    cpu_cfs->size[0U], cpu_cfstmp->size[0U]);
    }
  }
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_cfstmp);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(*gpu_FreqLimits), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(*gpu_b), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_xv);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_cfstmp);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_xdft);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_omega);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_cfsdft);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_scales);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_psidft);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_cf);
  *x_outdatedOnGpu = false;
  *cfs_outdatedOnCpu = true;
  *cfs_outdatedOnGpu = false;
  nvtxRangePop();
}

} // namespace coder
void cwt_emx_free()
{
  nvtxRangePushA("#fcn#cwt_emx_free#" MW_AT_LOCATION);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&psidft);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cf);
  nvtxRangePop();
}

void cwt_emx_init()
{
  nvtxRangePushA("#fcn#cwt_emx_init#" MW_AT_LOCATION);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&psidft, 2, &emlrtRTEI, false);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cf, 1, &b_emlrtRTEI, false);
  nvtxRangePop();
}

void cwt_init()
{
  nvtxRangePushA("#fcn#cwt_init#" MW_AT_LOCATION);
  cf_not_empty = false;
  psidft_not_empty = false;
  nvtxRangePop();
}

// End of code generation (cwt.cu)
