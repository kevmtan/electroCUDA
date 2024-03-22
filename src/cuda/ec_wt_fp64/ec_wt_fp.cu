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
#include "resample.h"
#include "rt_nonfinite.h"
#include "scaleSpectrum.h"
#include "wt.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Variable Definitions
static emlrtMCInfo emlrtMCI{
    27,                                                            // lineNo
    5,                                                             // colNo
    "error",                                                       // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/lang/error.m" // pName
};

static emlrtRTEInfo emlrtRTEI{
    28,                                                     // lineNo
    27,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    36,                                                     // lineNo
    1,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    48,                                                     // lineNo
    23,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    69,                                                     // lineNo
    10,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    230,             // lineNo
    1,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    81,                                                     // lineNo
    5,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    75,                                                     // lineNo
    14,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    69,                                                     // lineNo
    5,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    78,                                                     // lineNo
    14,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    48,                                                     // lineNo
    5,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    86,                                                     // lineNo
    19,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo n_emlrtRTEI{
    78,                                                     // lineNo
    5,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    75,                                                     // lineNo
    5,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo q_emlrtRTEI{
    287,             // lineNo
    33,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo r_emlrtRTEI{
    181,                     // lineNo
    24,                      // colNo
    "combineVectorElements", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/"
    "combineVectorElements.m" // pName
};

static emlrtRTEInfo s_emlrtRTEI{
    287,             // lineNo
    25,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo t_emlrtRTEI{
    72,                                                     // lineNo
    10,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    72,                                                     // lineNo
    5,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo v_emlrtRTEI{
    34,                                                     // lineNo
    1,                                                      // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo w_emlrtRTEI{
    48,                                                     // lineNo
    13,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo x_emlrtRTEI{
    75,                                                     // lineNo
    10,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo y_emlrtRTEI{
    78,                                                     // lineNo
    10,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

static emlrtRTEInfo bb_emlrtRTEI{
    267,             // lineNo
    36,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo cb_emlrtRTEI{
    282,             // lineNo
    9,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo db_emlrtRTEI{
    287,             // lineNo
    29,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo eb_emlrtRTEI{
    81,                                                     // lineNo
    10,                                                     // colNo
    "ec_wt_fp",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_wt_fp.m" // pName
};

// Function Declarations
static void b_error(const mxArray *m, emlrtMCInfo *location);

static __global__ void ec_wt_fp_kernel1(const int32_T ch,
                                        const emxArray_real_T x,
                                        const int32_T b_x, emxArray_real_T xc,
                                        int32_T x_dim0);

static __global__ void ec_wt_fp_kernel10(const int32_T sz, emxArray_real_T b);

static __global__ void ec_wt_fp_kernel11(const emxArray_real_T b,
                                         const real_T y, const int32_T b_b,
                                         emxArray_real_T dv8);

static __global__ void ec_wt_fp_kernel12(const emxArray_real_T dv8,
                                         const int32_T b_dv8,
                                         emxArray_creal_T yc);

static __global__ void ec_wt_fp_kernel13(const int32_T vlen,
                                         const emxArray_real_T x,
                                         const int32_T b, emxArray_real_T b_b,
                                         int32_T x_dim0);

static __global__ void ec_wt_fp_kernel14(const emxArray_creal_T r2,
                                         const int32_T b_r2, const int32_T c_r2,
                                         emxArray_creal_T x, int32_T x_dim0,
                                         int32_T r2_dim0);

static __global__ void ec_wt_fp_kernel15(const emxArray_creal_T x,
                                         const int32_T b, emxArray_real_T y);

static __global__ void ec_wt_fp_kernel16(const emxArray_real_T y,
                                         const int32_T b, emxArray_real_T b_y);

static __global__ void ec_wt_fp_kernel17(const emxArray_real_T y,
                                         const int32_T b_y,
                                         emxArray_creal_T yc);

static __global__ void ec_wt_fp_kernel18(const emxArray_creal_T r3,
                                         const int32_T b_r3, const int32_T c_r3,
                                         emxArray_creal_T x, int32_T x_dim0,
                                         int32_T r3_dim0);

static __global__ void ec_wt_fp_kernel19(const emxArray_creal_T x,
                                         const int32_T b, emxArray_real_T y);

static __global__ void ec_wt_fp_kernel2(const emxArray_real_T r,
                                        const int32_T b_r,
                                        emxArray_real_T b_dv);

static __global__ void ec_wt_fp_kernel20(const emxArray_real_T y,
                                         const int32_T b_y,
                                         emxArray_creal_T yc);

static __global__ void ec_wt_fp_kernel21(const emxArray_creal_T r1,
                                         const int32_T b_r1, const int32_T c_r1,
                                         emxArray_creal_T yc, int32_T yc_dim0,
                                         int32_T r1_dim0);

static __global__ void ec_wt_fp_kernel3(const emxArray_real_T b_dv,
                                        const int32_T c_dv,
                                        emxArray_creal_T yc);

static __global__ void ec_wt_fp_kernel4(const emxArray_creal_T cfs,
                                        const int32_T b, emxArray_real_T y);

static __global__ void ec_wt_fp_kernel5(const emxArray_real_T y,
                                        const int32_T b, emxArray_real_T x);

static __global__ void ec_wt_fp_kernel6(const real_T y,
                                        const emxArray_creal_T cfs,
                                        const int32_T nx, const int32_T cfsnorm,
                                        const int32_T vlen,
                                        emxArray_creal_T b_cfsnorm,
                                        int32_T cfs_dim0, int32_T cfsnorm_dim0);

static __global__ void ec_wt_fp_kernel7(const emxArray_creal_T cfsnorm,
                                        const int32_T b,
                                        const int32_T b_cfsnorm,
                                        emxArray_creal_T x, int32_T x_dim0,
                                        int32_T cfsnorm_dim0);

static __global__ void ec_wt_fp_kernel8(const emxArray_creal_T x,
                                        const int32_T b, emxArray_real_T y);

static __global__ void ec_wt_fp_kernel9(const emxArray_real_T y,
                                        const int32_T b, emxArray_real_T x);

// Function Definitions
static void b_error(const mxArray *m, emlrtMCInfo *location)
{
  const mxArray *pArray;
  nvtxRangePushA("#fcn#b_error#" MW_AT_LOCATION);
  pArray = m;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, nullptr, 1, &pArray, "error",
                        true, location);
  nvtxRangePop();
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

static __global__ __launch_bounds__(1024,
                                    1) void ec_wt_fp_kernel10(const int32_T sz,
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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel11(
    const emxArray_real_T b, const real_T y, const int32_T b_b,
    emxArray_real_T dv8)
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
    dv8.data[xpageoffset] = y * b.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel12(
    const emxArray_real_T dv8, const int32_T b_dv8, emxArray_creal_T yc)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv8);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    yc.data[xpageoffset].re = dv8.data[xpageoffset];
    yc.data[xpageoffset].im = 0.0;
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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel15(
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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel16(
    const emxArray_real_T y, const int32_T b, emxArray_real_T b_y)
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
    b_y.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel17(
    const emxArray_real_T y, const int32_T b_y, emxArray_creal_T yc)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    yc.data[xpageoffset].re = y.data[xpageoffset];
    yc.data[xpageoffset].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel18(
    const emxArray_creal_T r3, const int32_T b_r3, const int32_T c_r3,
    emxArray_creal_T x, int32_T x_dim0, int32_T r3_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_r3) + 1UL) *
                (static_cast<uint64_T>(b_r3) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T xpageoffset;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r3) + 1UL));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) /
                                       (static_cast<uint64_T>(b_r3) + 1UL));
    x.data[bcoef + x_dim0 * xpageoffset].re =
        r3.data[xpageoffset + r3_dim0 * bcoef].re;
    x.data[bcoef + x_dim0 * xpageoffset].im =
        -r3.data[xpageoffset + r3_dim0 * bcoef].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel19(
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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel2(
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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel20(
    const emxArray_real_T y, const int32_T b_y, emxArray_creal_T yc)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    yc.data[xpageoffset].re = y.data[xpageoffset];
    yc.data[xpageoffset].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel21(
    const emxArray_creal_T r1, const int32_T b_r1, const int32_T c_r1,
    emxArray_creal_T yc, int32_T yc_dim0, int32_T r1_dim0)
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
    yc.data[bcoef + yc_dim0 * xpageoffset].re =
        r1.data[xpageoffset + r1_dim0 * bcoef].re;
    yc.data[bcoef + yc_dim0 * xpageoffset].im =
        -r1.data[xpageoffset + r1_dim0 * bcoef].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel3(
    const emxArray_real_T b_dv, const int32_T c_dv, emxArray_creal_T yc)
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
    yc.data[xpageoffset].re = b_dv.data[xpageoffset];
    yc.data[xpageoffset].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel4(
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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel5(
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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel6(
    const real_T y, const emxArray_creal_T cfs, const int32_T nx,
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
        y * cfs.data[bcoef * b_k + cfs_dim0 * (xpageoffset - 1)].re;
    b_cfsnorm.data[b_k + cfsnorm_dim0 * k].im =
        y * cfs.data[bcoef * b_k + cfs_dim0 * (xpageoffset - 1)].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel7(
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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel8(
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

static __global__ __launch_bounds__(1024, 1) void ec_wt_fp_kernel9(
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

//
// function [y,freqs] = ec_wt_fp(x,fs,fLims,fVoices,ds,yType)
void ec_wt_fp(const emxArray_real_T *cpu_x, real_T fs, const real_T fLims[2],
              real_T fVoices, real_T ds[2], uint8_T yType,
              emxArray_cell_wrap_0 *y, emxArray_real_T *freqs)
{
  static const int32_T iv[2]{1, 48};
  static const char_T varargin_1[48]{
      '[', 'e', 'c', '_', 'w', 't', '_', 'f', 'p', ']', ' ', 'y',
      'T', 'y', 'p', 'e', ' ', 'm', 'u', 's', 't', ' ', 'b', 'e',
      ' ', 'i', 'n', 't', 'e', 'g', 'e', 'r', ' ', 'b', 'e', 't',
      'w', 'e', 'e', 'n', ' ', '0', ' ', 'a', 'n', 'd', ' ', '4'};
  coder::cwtfilterbank fb;
  dim3 block;
  dim3 grid;
  emxArray_creal_T b_gpu_yc;
  emxArray_creal_T c_gpu_x;
  emxArray_creal_T e_gpu_x;
  emxArray_creal_T f_gpu_x;
  emxArray_creal_T gpu_cfs;
  emxArray_creal_T gpu_cfsnorm;
  emxArray_creal_T gpu_r1;
  emxArray_creal_T gpu_r2;
  emxArray_creal_T gpu_r3;
  emxArray_creal_T gpu_yc;
  emxArray_creal_T *b_cpu_x;
  emxArray_creal_T *b_cpu_yc;
  emxArray_creal_T *c_cpu_x;
  emxArray_creal_T *cpu_cfs;
  emxArray_creal_T *cpu_cfsnorm;
  emxArray_creal_T *cpu_r1;
  emxArray_creal_T *cpu_r2;
  emxArray_creal_T *cpu_r3;
  emxArray_creal_T *cpu_yc;
  emxArray_creal_T *e_cpu_x;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_x;
  emxArray_real_T d_gpu_y;
  emxArray_real_T e_gpu_y;
  emxArray_real_T gpu_b;
  emxArray_real_T gpu_dv;
  emxArray_real_T gpu_dv8;
  emxArray_real_T gpu_r;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xc;
  emxArray_real_T gpu_y;
  emxArray_real_T *Scales;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_b;
  emxArray_real_T *cpu_dv;
  emxArray_real_T *cpu_dv8;
  emxArray_real_T *cpu_r;
  emxArray_real_T *cpu_xc;
  emxArray_real_T *cpu_y;
  emxArray_real_T *d_cpu_x;
  emxArray_real_T *d_cpu_y;
  emxArray_real_T *e_cpu_y;
  emxArray_real_T *f_cpu_x;
  const mxArray *b_y;
  const mxArray *m;
  int32_T i;
  int32_T xpageoffset;
  boolean_T r_outdatedOnCpu;
  boolean_T r_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  boolean_T yc_outdatedOnGpu;
  nvtxMarkA("#entryPointStart#");
  nvtxRangePushA("#entryPointFcn#ec_wt_fp#" MW_AT_LOCATION "#M100,100");
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&b_gpu_yc);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_r3);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_r2);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_r1);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_r);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_dv8);
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
  gpuEmxReset_real_T(&d_gpu_y);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&f_gpu_x);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_cfs);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&e_gpu_x);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&e_gpu_y);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_dv);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_xc);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_yc);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_x);
  r_outdatedOnCpu = false;
  r_outdatedOnGpu = false;
  x_outdatedOnGpu = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInitStruct_cwtfilterbank#" MW_AT_LINE);
  emxInitStruct_cwtfilterbank(&fb, &v_emlrtRTEI, true);
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
  // 'ec_wt_fp:14' ds (1,2) double = [0 0]
  //  Frequency limits
  //  Output data type [0=complex|1=magnitude|2=power|3=avgPower|4=avgDensity]
  // 'ec_wt_fp:16' yType (1,1) uint8 = uint8(0)
  // 'ec_wt_fp:18' if isempty(yType) || yType>4
  if (yType > 4) {
    // 'ec_wt_fp:19' error('[ec_wt_fp] yType must be integer between 0 and 4');
    b_y = nullptr;
    m = emlrtCreateCharArray(2, &iv[0]);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 48, m, &varargin_1[0]);
    emlrtAssign(&b_y, m);
    nvtxMarkA("#b_error#" MW_AT_LINE);
    b_error(b_y, &emlrtMCI);
  }
  //  Prep
  // 'ec_wt_fp:23' coder.gpu.kernelfun;
  //  Trigger CUDA kernel creation
  //  Make vars
  // 'ec_wt_fp:26' nFrames = height(x);
  // 'ec_wt_fp:27' nChs = width(x);
  // 'ec_wt_fp:28' y = coder.nullcopy(cell(1,nChs));
  xpageoffset = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = cpu_x->size[1];
  nvtxMarkA("#emxEnsureCapacity_cell_wrap_0#" MW_AT_LINE);
  emxEnsureCapacity_cell_wrap_0(y, xpageoffset, &emlrtRTEI);
  //  Preallocate output
  // 'ec_wt_fp:29' if ds(1)<=0 || ds(2)<=1 || ~(ds(2)>ds(1))
  if ((ds[0] <= 0.0) || (ds[1] <= 1.0) || (!(ds[1] > ds[0]))) {
    // 'ec_wt_fp:30' ds = [0 0];
    profileLoopStart("ec_wt_fp_loop_0", __LINE__, 1 + 1, "");
    for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
      ds[xpageoffset] = 0.0;
    }
    profileLoopEnd();
  }
  //  Make CWT filter
  // 'ec_wt_fp:34' fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
  // 'ec_wt_fp:35'
  // SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);
  nvtxMarkA("#cwtfilterbank_cwtfilterbank#" MW_AT_LINE);
  coder::cwtfilterbank_cwtfilterbank(&fb, static_cast<real_T>(cpu_x->size[0]),
                                     fs, fLims, fVoices);
  // 'ec_wt_fp:36' freqs = centerFrequencies(fb);
  xpageoffset = freqs->size[0];
  freqs->size[0] = fb.WaveletCenterFrequencies->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(freqs, xpageoffset, &b_emlrtRTEI);
  profileLoopStart("ec_wt_fp_loop_1", __LINE__,
                   (fb.WaveletCenterFrequencies->size[0] - 1) + 1, "");
  for (xpageoffset = 0; xpageoffset < fb.WaveletCenterFrequencies->size[0];
       xpageoffset++) {
    freqs->data[xpageoffset] = fb.WaveletCenterFrequencies->data[xpageoffset];
  }
  profileLoopEnd();
  //  Find initial CWT output size per channel
  // 'ec_wt_fp:39' if yType==4 || yType==3
  //  Processing loop across channels
  // 'ec_wt_fp:47' for ch = 1:nChs
  i = cpu_x->size[1];
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_yc, 2, &w_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_xc, 1, &c_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_dv, 1, &h_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_y, 2, &x_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&Scales, 2, &e_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_y, 2, &y_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&b_cpu_x, 2, &g_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_cfs, 2, &ab_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&c_cpu_x, 2, &i_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_y, 2, &bb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_y, 2, &x_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_cpu_x, 2, &bb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_cfsnorm, 2, &cb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&e_cpu_x, 2, &q_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&e_cpu_y, 2, &db_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&f_cpu_x, 2, &db_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_b, 2, &s_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_dv8, 1, &u_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_r, 2, &d_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_r1, 2, &eb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_r2, 2, &g_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_r3, 2, &i_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&b_cpu_yc, 2, &l_emlrtRTEI, true);
  profileLoopStart("ec_wt_fp_loop_2", __LINE__, (i - 1) + 1, "");
  for (int32_T ch{0}; ch < i; ch++) {
    int32_T nx;
    boolean_T validLaunchParams;
    // 'ec_wt_fp:48' y{ch} = wt_lfn(fb,x(:,ch),yType,ds,ycSz);
    xpageoffset = cpu_xc->size[0];
    cpu_xc->size[0] = cpu_x->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_xc, xpageoffset, &c_emlrtRTEI);
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
    //  Within-channel function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    //  Preallocate channel output
    // 'ec_wt_fp:58' if yType==4 || yType==3
    //  Run WT
    // 'ec_wt_fp:67' if yType==4
    if (yType == 4) {
      //  Scale-averaged density
      // 'ec_wt_fp:69' yc = scaleSpectrum(fb,xc,SpectrumType="density")';
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real_T(cpu_xc, &gpu_xc);
      nvtxMarkA("#cwtfilterbank_scaleSpectrum#" MW_AT_LINE);
      coder::cwtfilterbank_scaleSpectrum(&fb, cpu_xc, cpu_r, &r_outdatedOnCpu,
                                         &gpu_r, &r_outdatedOnGpu);
      xpageoffset = cpu_dv->size[0];
      cpu_dv->size[0] = cpu_r->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_dv, xpageoffset, &d_emlrtRTEI);
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
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel2#" MW_AT_LINE);
        ec_wt_fp_kernel2<<<grid, block>>>(gpu_r, xpageoffset, gpu_dv);
      }
      xpageoffset = cpu_yc->size[0] * cpu_yc->size[1];
      cpu_yc->size[0] = cpu_dv->size[0];
      cpu_yc->size[1] = 1;
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_yc, xpageoffset, &h_emlrtRTEI);
      xpageoffset = cpu_dv->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_yc, &gpu_yc, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel3#" MW_AT_LINE);
        ec_wt_fp_kernel3<<<grid, block>>>(gpu_dv, xpageoffset, gpu_yc);
      }
      r_outdatedOnCpu = false;
      r_outdatedOnGpu = true;
    } else if (yType == 3) {
      real_T c_y;
      real_T numfac;
      int32_T vlen;
      uint32_T sz[2];
      uint32_T defaultSL_idx_1;
      // 'ec_wt_fp:70' elseif yType==3
      //  Scale-averaged power
      // 'ec_wt_fp:72' yc = scaleSpectrum(fb,xc)';
      defaultSL_idx_1 = static_cast<uint32_T>(fb.Scales->size[1]);
      xpageoffset = Scales->size[0] * Scales->size[1];
      Scales->size[0] = 1;
      Scales->size[1] = fb.Scales->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(Scales, xpageoffset, &e_emlrtRTEI);
      profileLoopStart("ec_wt_fp_loop_3", __LINE__,
                       (fb.Scales->size[1] - 1) + 1, "");
      for (xpageoffset = 0; xpageoffset < fb.Scales->size[1]; xpageoffset++) {
        Scales->data[xpageoffset] = fb.Scales->data[xpageoffset];
      }
      profileLoopEnd();
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real_T(cpu_xc, &gpu_xc);
      nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
      coder::cwtfilterbank_wt(&fb, cpu_xc, cpu_cfs);
      nx = cpu_cfs->size[0] * cpu_cfs->size[1];
      profileLoopStart("ec_wt_fp_loop_4", __LINE__, 1 + 1, "");
      for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
        sz[xpageoffset] = static_cast<uint32_T>(cpu_cfs->size[xpageoffset]);
      }
      profileLoopEnd();
      xpageoffset = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = static_cast<int32_T>(sz[0]);
      c_cpu_y->size[1] = static_cast<int32_T>(sz[1]);
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(c_cpu_y, xpageoffset, &j_emlrtRTEI);
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
        nvtxMarkA("#ec_wt_fp_kernel4#" MW_AT_LINE);
        ec_wt_fp_kernel4<<<grid, block>>>(gpu_cfs, nx - 1, gpu_y);
      }
      profileLoopStart("ec_wt_fp_loop_7", __LINE__, 1 + 1, "");
      for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
        sz[xpageoffset] = static_cast<uint32_T>(c_cpu_y->size[xpageoffset]);
      }
      profileLoopEnd();
      xpageoffset = d_cpu_x->size[0] * d_cpu_x->size[1];
      d_cpu_x->size[0] = static_cast<int32_T>(sz[0]);
      d_cpu_x->size[1] = static_cast<int32_T>(sz[1]);
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(d_cpu_x, xpageoffset, &m_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(
          computeNumIters(
              static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1),
          &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(d_cpu_x, &b_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel5#" MW_AT_LINE);
        ec_wt_fp_kernel5<<<grid, block>>>(
            gpu_y,
            static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1,
            b_gpu_x);
      }
      vlen = d_cpu_x->size[0] * d_cpu_x->size[1];
      if (d_cpu_x->size[0] * d_cpu_x->size[1] == 0) {
        c_y = 0.0;
      } else {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &b_gpu_x);
        c_y = d_cpu_x->data[0];
        profileLoopStart("ec_wt_fp_loop_11", __LINE__, (vlen - 2) + 1, "");
        for (nx = 0; nx <= vlen - 2; nx++) {
          c_y += d_cpu_x->data[nx + 1];
        }
        profileLoopEnd();
      }
      numfac = fb.sigvar;
      c_y = std::sqrt(numfac /
                      (1.0 / static_cast<real_T>(Scales->size[1]) * c_y));
      xpageoffset = cpu_cfsnorm->size[0] * cpu_cfsnorm->size[1];
      cpu_cfsnorm->size[0] = cpu_cfs->size[0];
      cpu_cfsnorm->size[1] = cpu_cfs->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_cfsnorm, xpageoffset, &p_emlrtRTEI);
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
          nvtxMarkA("#ec_wt_fp_kernel6#" MW_AT_LINE);
          ec_wt_fp_kernel6<<<grid, block>>>(c_y, gpu_cfs, nx, xpageoffset, vlen,
                                            gpu_cfsnorm, cpu_cfs->size[0U],
                                            cpu_cfsnorm->size[0U]);
        }
      }
      c_y = 1.0 / static_cast<real_T>(Scales->size[1]);
      xpageoffset = e_cpu_x->size[0] * e_cpu_x->size[1];
      e_cpu_x->size[0] = static_cast<int32_T>(defaultSL_idx_1);
      e_cpu_x->size[1] = cpu_cfsnorm->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(e_cpu_x, xpageoffset, &q_emlrtRTEI);
      xpageoffset = cpu_cfsnorm->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(
          computeNumIters(xpageoffset,
                          static_cast<int32_T>(defaultSL_idx_1) - 1),
          &grid, &block, 2147483647U);
      if (r_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_cfsnorm, &gpu_cfsnorm, true);
      }
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(e_cpu_x, &c_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel7#" MW_AT_LINE);
        ec_wt_fp_kernel7<<<grid, block>>>(
            gpu_cfsnorm, static_cast<int32_T>(defaultSL_idx_1) - 1, xpageoffset,
            c_gpu_x, e_cpu_x->size[0U], cpu_cfsnorm->size[0U]);
      }
      nx = static_cast<int32_T>(defaultSL_idx_1) * cpu_cfsnorm->size[1];
      xpageoffset = e_cpu_y->size[0] * e_cpu_y->size[1];
      e_cpu_y->size[0] = static_cast<int32_T>(defaultSL_idx_1);
      e_cpu_y->size[1] = cpu_cfsnorm->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(e_cpu_y, xpageoffset, &j_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(e_cpu_y, &b_gpu_y, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel8#" MW_AT_LINE);
        ec_wt_fp_kernel8<<<grid, block>>>(c_gpu_x, nx - 1, b_gpu_y);
      }
      profileLoopStart("ec_wt_fp_loop_12", __LINE__, 1 + 1, "");
      for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
        sz[xpageoffset] = static_cast<uint32_T>(e_cpu_y->size[xpageoffset]);
      }
      profileLoopEnd();
      xpageoffset = f_cpu_x->size[0] * f_cpu_x->size[1];
      f_cpu_x->size[0] = static_cast<int32_T>(sz[0]);
      f_cpu_x->size[1] = static_cast<int32_T>(sz[1]);
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(f_cpu_x, xpageoffset, &m_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(
          computeNumIters(
              static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1),
          &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(f_cpu_x, &d_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel9#" MW_AT_LINE);
        ec_wt_fp_kernel9<<<grid, block>>>(
            b_gpu_y,
            static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1,
            d_gpu_x);
      }
      vlen = f_cpu_x->size[0];
      if ((f_cpu_x->size[0] == 0) || (f_cpu_x->size[1] == 0)) {
        profileLoopStart("ec_wt_fp_loop_13", __LINE__, 1 + 1, "");
        for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
          sz[xpageoffset] = static_cast<uint32_T>(f_cpu_x->size[xpageoffset]);
        }
        profileLoopEnd();
        xpageoffset = cpu_b->size[0] * cpu_b->size[1];
        cpu_b->size[0] = 1;
        cpu_b->size[1] = static_cast<int32_T>(sz[1]);
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_b, xpageoffset, &s_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(
            computeNumIters(static_cast<int32_T>(sz[1]) - 1), &grid, &block,
            2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#ec_wt_fp_kernel10#" MW_AT_LINE);
          ec_wt_fp_kernel10<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
                                             gpu_b);
        }
      } else {
        nx = f_cpu_x->size[1];
        xpageoffset = cpu_b->size[0] * cpu_b->size[1];
        cpu_b->size[0] = 1;
        cpu_b->size[1] = f_cpu_x->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_b, xpageoffset, &r_emlrtRTEI);
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
      xpageoffset = cpu_dv8->size[0];
      cpu_dv8->size[0] = cpu_b->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_dv8, xpageoffset, &t_emlrtRTEI);
      xpageoffset = cpu_b->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_dv8, &gpu_dv8, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel11#" MW_AT_LINE);
        ec_wt_fp_kernel11<<<grid, block>>>(gpu_b, c_y, xpageoffset, gpu_dv8);
      }
      xpageoffset = cpu_yc->size[0] * cpu_yc->size[1];
      cpu_yc->size[0] = cpu_dv8->size[0];
      cpu_yc->size[1] = 1;
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_yc, xpageoffset, &u_emlrtRTEI);
      xpageoffset = cpu_dv8->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_yc, &gpu_yc, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel12#" MW_AT_LINE);
        ec_wt_fp_kernel12<<<grid, block>>>(gpu_dv8, xpageoffset, gpu_yc);
      }
      r_outdatedOnCpu = false;
      r_outdatedOnGpu = true;
    } else if (yType == 2) {
      int32_T vlen;
      uint32_T sz[2];
      // 'ec_wt_fp:73' elseif yType==2
      //  CWT power
      // 'ec_wt_fp:75' yc = abs(wt(fb,xc)').^2;
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real_T(cpu_xc, &gpu_xc);
      nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
      coder::cwtfilterbank_wt(&fb, cpu_xc, cpu_r2);
      xpageoffset = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = cpu_r2->size[1];
      b_cpu_x->size[1] = cpu_r2->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(b_cpu_x, xpageoffset, &g_emlrtRTEI);
      xpageoffset = cpu_r2->size[0] - 1;
      vlen = cpu_r2->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset, vlen), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_r2, &gpu_r2, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(b_cpu_x, &e_gpu_x, true);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_r2, cpu_r2);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel14#" MW_AT_LINE);
        ec_wt_fp_kernel14<<<grid, block>>>(gpu_r2, vlen, xpageoffset, e_gpu_x,
                                           b_cpu_x->size[0U], cpu_r2->size[0U]);
      }
      nx = b_cpu_x->size[0] * b_cpu_x->size[1];
      profileLoopStart("ec_wt_fp_loop_5", __LINE__, 1 + 1, "");
      for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
        sz[xpageoffset] = static_cast<uint32_T>(b_cpu_x->size[xpageoffset]);
      }
      profileLoopEnd();
      xpageoffset = cpu_y->size[0] * cpu_y->size[1];
      cpu_y->size[0] = static_cast<int32_T>(sz[0]);
      cpu_y->size[1] = static_cast<int32_T>(sz[1]);
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_y, xpageoffset, &j_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_y, &c_gpu_y, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel15#" MW_AT_LINE);
        ec_wt_fp_kernel15<<<grid, block>>>(e_gpu_x, nx - 1, c_gpu_y);
      }
      profileLoopStart("ec_wt_fp_loop_8", __LINE__, 1 + 1, "");
      for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
        sz[xpageoffset] = static_cast<uint32_T>(cpu_y->size[xpageoffset]);
      }
      profileLoopEnd();
      xpageoffset = d_cpu_y->size[0] * d_cpu_y->size[1];
      d_cpu_y->size[0] = static_cast<int32_T>(sz[0]);
      d_cpu_y->size[1] = static_cast<int32_T>(sz[1]);
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(d_cpu_y, xpageoffset, &m_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(
          computeNumIters(
              static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1),
          &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(d_cpu_y, &d_gpu_y, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel16#" MW_AT_LINE);
        ec_wt_fp_kernel16<<<grid, block>>>(
            c_gpu_y,
            static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) - 1,
            d_gpu_y);
      }
      xpageoffset = cpu_yc->size[0] * cpu_yc->size[1];
      cpu_yc->size[0] = d_cpu_y->size[0];
      cpu_yc->size[1] = d_cpu_y->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_yc, xpageoffset, &o_emlrtRTEI);
      xpageoffset = d_cpu_y->size[0] * d_cpu_y->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_yc, &gpu_yc, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel17#" MW_AT_LINE);
        ec_wt_fp_kernel17<<<grid, block>>>(d_gpu_y, xpageoffset, gpu_yc);
      }
      r_outdatedOnCpu = false;
      r_outdatedOnGpu = true;
    } else if (yType == 1) {
      int32_T vlen;
      uint32_T sz[2];
      // 'ec_wt_fp:76' elseif yType==1
      //  CWT magnitude
      // 'ec_wt_fp:78' yc = abs(wt(fb,xc)');
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real_T(cpu_xc, &gpu_xc);
      nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
      coder::cwtfilterbank_wt(&fb, cpu_xc, cpu_r3);
      xpageoffset = c_cpu_x->size[0] * c_cpu_x->size[1];
      c_cpu_x->size[0] = cpu_r3->size[1];
      c_cpu_x->size[1] = cpu_r3->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(c_cpu_x, xpageoffset, &i_emlrtRTEI);
      xpageoffset = cpu_r3->size[0] - 1;
      vlen = cpu_r3->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset, vlen), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_r3, &gpu_r3, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(c_cpu_x, &f_gpu_x, true);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_r3, cpu_r3);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel18#" MW_AT_LINE);
        ec_wt_fp_kernel18<<<grid, block>>>(gpu_r3, vlen, xpageoffset, f_gpu_x,
                                           c_cpu_x->size[0U], cpu_r3->size[0U]);
      }
      nx = c_cpu_x->size[0] * c_cpu_x->size[1];
      profileLoopStart("ec_wt_fp_loop_6", __LINE__, 1 + 1, "");
      for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
        sz[xpageoffset] = static_cast<uint32_T>(c_cpu_x->size[xpageoffset]);
      }
      profileLoopEnd();
      xpageoffset = b_cpu_y->size[0] * b_cpu_y->size[1];
      b_cpu_y->size[0] = static_cast<int32_T>(sz[0]);
      b_cpu_y->size[1] = static_cast<int32_T>(sz[1]);
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b_cpu_y, xpageoffset, &j_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(b_cpu_y, &e_gpu_y, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel19#" MW_AT_LINE);
        ec_wt_fp_kernel19<<<grid, block>>>(f_gpu_x, nx - 1, e_gpu_y);
      }
      xpageoffset = cpu_yc->size[0] * cpu_yc->size[1];
      cpu_yc->size[0] = b_cpu_y->size[0];
      cpu_yc->size[1] = b_cpu_y->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_yc, xpageoffset, &n_emlrtRTEI);
      xpageoffset = b_cpu_y->size[0] * b_cpu_y->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_yc, &gpu_yc, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel20#" MW_AT_LINE);
        ec_wt_fp_kernel20<<<grid, block>>>(e_gpu_y, xpageoffset, gpu_yc);
      }
      r_outdatedOnCpu = false;
      r_outdatedOnGpu = true;
    } else {
      int32_T vlen;
      // 'ec_wt_fp:79' elseif yType==0
      //  CWT coefficients (complex-valued)
      // 'ec_wt_fp:81' yc = wt(fb,xc)';
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real_T(cpu_xc, &gpu_xc);
      nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
      coder::cwtfilterbank_wt(&fb, cpu_xc, cpu_r1);
      xpageoffset = cpu_yc->size[0] * cpu_yc->size[1];
      cpu_yc->size[0] = cpu_r1->size[1];
      cpu_yc->size[1] = cpu_r1->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_yc, xpageoffset, &f_emlrtRTEI);
      xpageoffset = cpu_r1->size[0] - 1;
      vlen = cpu_r1->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(xpageoffset, vlen), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_r1, &gpu_r1, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_yc, &gpu_yc, true);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_r1, cpu_r1);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#ec_wt_fp_kernel21#" MW_AT_LINE);
        ec_wt_fp_kernel21<<<grid, block>>>(gpu_r1, vlen, xpageoffset, gpu_yc,
                                           cpu_yc->size[0U], cpu_r1->size[0U]);
      }
      r_outdatedOnCpu = false;
      r_outdatedOnGpu = true;
    }
    //  Downsample
    // 'ec_wt_fp:85' if ds(2)
    if (ds[1] != 0.0) {
      // 'ec_wt_fp:86' yc = resample(yc,ds(1),ds(2));
      yc_outdatedOnGpu = false;
      xpageoffset = b_cpu_yc->size[0] * b_cpu_yc->size[1];
      b_cpu_yc->size[0] = cpu_yc->size[0];
      b_cpu_yc->size[1] = cpu_yc->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(b_cpu_yc, xpageoffset, &l_emlrtRTEI);
      nx = cpu_yc->size[0] * cpu_yc->size[1] - 1;
      profileLoopStart("ec_wt_fp_loop_10", __LINE__, nx + 1, "");
      for (xpageoffset = 0; xpageoffset <= nx; xpageoffset++) {
        if (r_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_creal_T(cpu_yc, &gpu_yc);
        }
        r_outdatedOnGpu = false;
        b_cpu_yc->data[xpageoffset] = cpu_yc->data[xpageoffset];
        yc_outdatedOnGpu = true;
      }
      profileLoopEnd();
      nvtxMarkA("#resample#" MW_AT_LINE);
      coder::resample(b_cpu_yc, &b_gpu_yc, &yc_outdatedOnGpu, ds[0], ds[1],
                      cpu_yc, &r_outdatedOnGpu, &gpu_yc, &r_outdatedOnCpu);
    }
    xpageoffset = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
    y->data[ch].f1->size[0] = cpu_yc->size[0];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(y->data[ch].f1, xpageoffset, &k_emlrtRTEI);
    xpageoffset = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
    y->data[ch].f1->size[1] = cpu_yc->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(y->data[ch].f1, xpageoffset, &k_emlrtRTEI);
    profileLoopStart("ec_wt_fp_loop_9", __LINE__,
                     (cpu_yc->size[0] * cpu_yc->size[1] - 1) + 1, "");
    for (xpageoffset = 0; xpageoffset < cpu_yc->size[0] * cpu_yc->size[1];
         xpageoffset++) {
      if (r_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_creal_T(cpu_yc, &gpu_yc);
      }
      r_outdatedOnGpu = false;
      y->data[ch].f1->data[xpageoffset] = cpu_yc->data[xpageoffset];
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&b_cpu_yc);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_r3);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_r2);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_r1);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_r);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_dv8);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_b);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&f_cpu_x);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&e_cpu_y);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&e_cpu_x);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_cfsnorm);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_x);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_cpu_y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_y);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&c_cpu_x);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_cfs);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&b_cpu_x);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&Scales);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_dv);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_xc);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_yc);
  nvtxMarkA("#emxFreeStruct_cwtfilterbank#" MW_AT_LINE);
  emxFreeStruct_cwtfilterbank(&fb);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_x);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_yc);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_xc);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_dv);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&e_gpu_y);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&e_gpu_x);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_cfs);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&f_gpu_x);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&d_gpu_y);
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
  gpuEmxFree_real_T(&gpu_dv8);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_r);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_r1);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_r2);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_r3);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&b_gpu_yc);
  nvtxRangePop();
  nvtxMarkA("#entryPointEnd#");
}

// End of code generation (ec_wt_fp.cu)
