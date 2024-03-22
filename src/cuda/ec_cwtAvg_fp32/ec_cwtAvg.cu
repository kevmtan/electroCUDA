//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_cwtAvg.cu
//
// Code generation for function 'ec_cwtAvg'
//

// Include files
#include "ec_cwtAvg.h"
#include "cwtfilterbank.h"
#include "div.h"
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_mexutil.h"
#include "ec_cwtAvg_types.h"
#include "numCpsi.h"
#include "resample.h"
#include "rt_nonfinite.h"
#include "scNormalize.h"
#include "vvarstd.h"
#include "MWCUBLASUtils.hpp"
#include "MWCUFFTPlanManager.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "cufft.h"
#include "math_constants.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo emlrtRTEI{
    26,                                                    // lineNo
    1,                                                     // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    1,                                                     // lineNo
    22,                                                    // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    230,             // lineNo
    1,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    102,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo
    e_emlrtRTEI{
        105,      // lineNo
        20,       // colNo
        "varstd", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/"
        "varstd.m" // pName
    };

static emlrtRTEInfo f_emlrtRTEI{
    135,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    143,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "cuFFTNDCallback", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "cuFFTNDCallback.p" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    138,  // lineNo
    19,   // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    138,  // lineNo
    6,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    236,             // lineNo
    5,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    35,                                                    // lineNo
    28,                                                    // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo q_emlrtRTEI{
    298,             // lineNo
    18,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo r_emlrtRTEI{
    297,             // lineNo
    5,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    35,                                                    // lineNo
    5,                                                     // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo v_emlrtRTEI{
    41,                                                    // lineNo
    9,                                                     // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo w_emlrtRTEI{
    39,                                                    // lineNo
    9,                                                     // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo x_emlrtRTEI{
    24,                                                    // lineNo
    1,                                                     // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo y_emlrtRTEI{
    287,             // lineNo
    5,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo ab_emlrtRTEI{
    151,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo bb_emlrtRTEI{
    293,             // lineNo
    14,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo cb_emlrtRTEI{
    39,                                                    // lineNo
    17,                                                    // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

// Function Declarations
static __global__ void ec_cwtAvg_kernel1(const int32_T ch,
                                         const emxArray_real32_T x,
                                         const int32_T b, emxArray_real32_T xv,
                                         emxArray_real32_T b_x, int32_T x_dim0);

static __global__ void ec_cwtAvg_kernel10(const emxArray_real32_T Scales,
                                          const emxArray_real32_T y,
                                          const int32_T b_y, const int32_T c_y,
                                          emxArray_real32_T abswt2S,
                                          int32_T abswt2S_dim0, int32_T y_dim0);

static __global__ void ec_cwtAvg_kernel11(const emxArray_real32_T abswt2S,
                                          const int32_T b,
                                          const int32_T b_abswt2S,
                                          emxArray_real32_T y, int32_T y_dim0,
                                          int32_T abswt2S_dim0);

static __global__ void ec_cwtAvg_kernel12(const real32_T c1,
                                          emxArray_real32_T savgpTMP);

static __global__ void ec_cwtAvg_kernel13(const emxArray_real32_T savgpTMP,
                                          const int32_T b_savgpTMP,
                                          emxArray_real32_T xCh);

static __global__ void ec_cwtAvg_kernel14(const int32_T abswt2S,
                                          emxArray_real32_T savgpTMP);

static __global__ void ec_cwtAvg_kernel15(const int32_T abswt2S,
                                          emxArray_real32_T savgpTMP);

static __global__ void ec_cwtAvg_kernel16(const emxArray_real32_T Scales,
                                          const int32_T b, emxArray_real32_T c);

static __global__ void
ec_cwtAvg_kernel17(const int32_T acoef, const real32_T c1, emxArray_real32_T c);

static __global__ void ec_cwtAvg_kernel18(const emxArray_real32_T Scales,
                                          emxArray_real32_T c);

static __global__ void ec_cwtAvg_kernel19(const emxArray_real32_T Scales,
                                          const int32_T b, emxArray_real32_T c);

static __global__ void ec_cwtAvg_kernel2(const int32_T ch,
                                         const emxArray_real32_T x,
                                         const int32_T b, emxArray_real32_T b_x,
                                         int32_T x_dim0);

static __global__ void ec_cwtAvg_kernel20(const emxArray_real32_T Scales,
                                          const int32_T acoef,
                                          emxArray_real32_T c);

static __global__ void ec_cwtAvg_kernel21(const real32_T cfsposdft_re,
                                          const emxArray_creal32_T cfsposdft,
                                          const int32_T b_cfsposdft,
                                          emxArray_creal32_T cfs);

static __global__ void ec_cwtAvg_kernel22(const emxArray_real32_T xv,
                                          const int32_T b_xv,
                                          emxArray_creal32_T xposdft);

static __global__ void ec_cwtAvg_kernel23(const int32_T b,
                                          emxArray_creal32_T xposdft,
                                          uint32_T xSize_dim1);

static __global__ void ec_cwtAvg_kernel3(const int32_T acoef, const int32_T b,
                                         emxArray_real32_T x);

static __global__ void ec_cwtAvg_kernel4(const emxArray_real32_T x,
                                         const int32_T b, emxArray_real32_T xv);

static __global__ void
ec_cwtAvg_kernel5(const emxArray_creal32_T xposdft,
                  const emxArray_real32_T psihat, const int32_T nd2,
                  const int32_T acoef, const int32_T cfsposdft,
                  const int32_T i3, emxArray_creal32_T b_cfsposdft,
                  int32_T psihat_dim0, int32_T cfsposdft_dim0);

static __global__ void ec_cwtAvg_kernel6(const int32_T xSize,
                                         emxArray_creal32_T cfs);

static __global__ void ec_cwtAvg_kernel7(const int32_T ch,
                                         const emxArray_real32_T x,
                                         const int32_T b_x,
                                         emxArray_real32_T c_x, int32_T x_dim0);

static __global__ void ec_cwtAvg_kernel8(const emxArray_creal32_T cfs,
                                         const int32_T b, emxArray_real32_T y);

static __global__ void ec_cwtAvg_kernel9(const emxArray_real32_T y,
                                         const int32_T b,
                                         emxArray_real32_T b_y);

static void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu,
                                           boolean_T needsCopy);

static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu);

static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu,
                                           const emxArray_creal32_T *cpu);

static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu);

static void gpuEmxReset_creal32_T(emxArray_creal32_T *gpu);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel1(
    const int32_T ch, const emxArray_real32_T x, const int32_T b,
    emxArray_real32_T xv, emxArray_real32_T b_x, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    real32_T xtmp;
    j2 = static_cast<int32_T>(idx);
    xtmp = x.data[j2 + x_dim0 * ch];
    b_x.data[j2] = xtmp;
    xv.data[j2] = xtmp;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel10(
    const emxArray_real32_T Scales, const emxArray_real32_T y,
    const int32_T b_y, const int32_T c_y, emxArray_real32_T abswt2S,
    int32_T abswt2S_dim0, int32_T y_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c_y) + 1UL) * (static_cast<uint64_T>(b_y) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T j2;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    j2 = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) /
                              (static_cast<uint64_T>(b_y) + 1UL));
    abswt2S.data[bcoef + abswt2S_dim0 * j2] =
        y.data[bcoef + y_dim0 * j2] / Scales.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel11(
    const emxArray_real32_T abswt2S, const int32_T b, const int32_T b_abswt2S,
    emxArray_real32_T y, int32_T y_dim0, int32_T abswt2S_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_abswt2S) + 1UL) *
                (static_cast<uint64_T>(b) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T j2;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    j2 = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) /
                              (static_cast<uint64_T>(b) + 1UL));
    y.data[bcoef + y_dim0 * j2] = abswt2S.data[bcoef + abswt2S_dim0 * j2];
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_cwtAvg_kernel12(const real32_T c1,
                                                     emxArray_real32_T savgpTMP)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    savgpTMP.data[0] = c1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel13(
    const emxArray_real32_T savgpTMP, const int32_T b_savgpTMP,
    emxArray_real32_T xCh)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_savgpTMP);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    xCh.data[j2] = savgpTMP.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel14(
    const int32_T abswt2S, emxArray_real32_T savgpTMP)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abswt2S);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    savgpTMP.data[j2] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel15(
    const int32_T abswt2S, emxArray_real32_T savgpTMP)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abswt2S);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    savgpTMP.data[j2] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel16(
    const emxArray_real32_T Scales, const int32_T b, emxArray_real32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    c.data[j2] = Scales.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel17(
    const int32_T acoef, const real32_T c1, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = c1;
    c.data[acoef - 1] = c1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel18(
    const emxArray_real32_T Scales, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = 0.5F * (Scales.data[1] - Scales.data[0]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel19(
    const emxArray_real32_T Scales, const int32_T b, emxArray_real32_T c)
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
    c.data[k + 1] = 0.5F * (Scales.data[k + 2] - Scales.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel2(
    const int32_T ch, const emxArray_real32_T x, const int32_T b,
    emxArray_real32_T b_x, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    b_x.data[j2] = x.data[j2 + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel20(
    const emxArray_real32_T Scales, const int32_T acoef, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[acoef - 1] =
        0.5F * (Scales.data[acoef - 1] - Scales.data[acoef - 2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel21(
    const real32_T cfsposdft_re, const emxArray_creal32_T cfsposdft,
    const int32_T b_cfsposdft, emxArray_creal32_T cfs)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfsposdft);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    real32_T ai;
    real32_T xtmp;
    j2 = static_cast<int32_T>(idx);
    xtmp = cfsposdft.data[j2].re;
    ai = cfsposdft.data[j2].im;
    if (ai == 0.0F) {
      cfs.data[j2].re = xtmp / cfsposdft_re;
      cfs.data[j2].im = 0.0F;
    } else if (xtmp == 0.0F) {
      cfs.data[j2].re = 0.0F;
      cfs.data[j2].im = ai / cfsposdft_re;
    } else {
      cfs.data[j2].re = xtmp / cfsposdft_re;
      cfs.data[j2].im = ai / cfsposdft_re;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel22(
    const emxArray_real32_T xv, const int32_T b_xv, emxArray_creal32_T xposdft)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    xposdft.data[j2].re = xv.data[j2];
    xposdft.data[j2].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel23(
    const int32_T b, emxArray_creal32_T xposdft, uint32_T xSize_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - bcoef) - 1].re =
        xposdft.data[bcoef + 1].re;
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - bcoef) - 1].im =
        -xposdft.data[bcoef + 1].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel3(
    const int32_T acoef, const int32_T b, emxArray_real32_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T j2;
    real32_T xtmp;
    bcoef = static_cast<int32_T>(idx);
    j2 = acoef - bcoef;
    xtmp = x.data[bcoef];
    x.data[bcoef] = x.data[j2 - 1];
    x.data[j2 - 1] = xtmp;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel4(
    const emxArray_real32_T x, const int32_T b, emxArray_real32_T xv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    xv.data[j2] = x.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel5(
    const emxArray_creal32_T xposdft, const emxArray_real32_T psihat,
    const int32_T nd2, const int32_T acoef, const int32_T cfsposdft,
    const int32_T i3, emxArray_creal32_T b_cfsposdft, int32_T psihat_dim0,
    int32_T cfsposdft_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(i3) + 1UL) *
                (static_cast<uint64_T>(cfsposdft) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_k;
    int32_T bcoef;
    int32_T j2;
    int32_T k;
    int32_T varargin_2;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(cfsposdft) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) /
                             (static_cast<uint64_T>(cfsposdft) + 1UL));
    varargin_2 = acoef * k + 1;
    j2 = nd2 * k + 1;
    bcoef = static_cast<int32_T>(psihat_dim0 != 1);
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].re =
        psihat.data[bcoef * b_k + psihat_dim0 * (j2 - 1)] *
        xposdft.data[varargin_2 - 1].re;
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].im =
        psihat.data[bcoef * b_k + psihat_dim0 * (j2 - 1)] *
        xposdft.data[varargin_2 - 1].im;
  }
}

static __global__
    __launch_bounds__(1024, 1) void ec_cwtAvg_kernel6(const int32_T xSize,
                                                      emxArray_creal32_T cfs)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xSize);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    cfs.data[j2].re = 0.0F;
    cfs.data[j2].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel7(
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
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    c_x.data[j2] = x.data[j2 + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel8(
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel9(
    const emxArray_real32_T y, const int32_T b, emxArray_real32_T b_y)
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

static void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu,
                                           boolean_T needsCopy)
{
  creal32_T *newData;
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
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(creal32_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(creal32_T),
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

static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu,
                                           const emxArray_creal32_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(
      cudaMemcpy(gpu->data, cpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(creal32_T),
                 cudaMemcpyHostToDevice),
      __FILE__, __LINE__);
}

static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(
      cudaMemcpy(cpu->data, gpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(creal32_T),
                 cudaMemcpyDeviceToHost),
      __FILE__, __LINE__);
}

static void gpuEmxReset_creal32_T(emxArray_creal32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_creal32_T));
}

//
// function [y,freqs] = ec_cwtAvg(x,fs,fLims,fVoices,ds)
void ec_cwtAvg(const emxArray_real32_T *cpu_x, real_T fs, const real_T fLims[2],
               real_T fVoices, const real_T ds[2], emxArray_cell_wrap_0 *y,
               emxArray_real_T *freqs)
{
  coder::cwtfilterbank fb;
  dim3 block;
  dim3 grid;
  emxArray_creal32_T gpu_cfs;
  emxArray_creal32_T gpu_cfsposdft;
  emxArray_creal32_T gpu_xposdft;
  emxArray_creal32_T *cpu_cfs;
  emxArray_creal32_T *cpu_cfsposdft;
  emxArray_creal32_T *cpu_xposdft;
  emxArray_real32_T b_gpu_x;
  emxArray_real32_T b_gpu_y;
  emxArray_real32_T c_gpu_x;
  emxArray_real32_T c_gpu_y;
  emxArray_real32_T d_gpu_x;
  emxArray_real32_T gpu_Scales;
  emxArray_real32_T gpu_abswt2S;
  emxArray_real32_T gpu_c;
  emxArray_real32_T gpu_psihat;
  emxArray_real32_T gpu_r;
  emxArray_real32_T gpu_savgpTMP;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_xCh;
  emxArray_real32_T gpu_xv;
  emxArray_real32_T gpu_y;
  emxArray_real32_T *b_cpu_x;
  emxArray_real32_T *b_cpu_y;
  emxArray_real32_T *c_cpu_x;
  emxArray_real32_T *c_cpu_y;
  emxArray_real32_T *cpu_Scales;
  emxArray_real32_T *cpu_abswt2S;
  emxArray_real32_T *cpu_c;
  emxArray_real32_T *cpu_psihat;
  emxArray_real32_T *cpu_r;
  emxArray_real32_T *cpu_savgpTMP;
  emxArray_real32_T *cpu_xCh;
  emxArray_real32_T *cpu_xv;
  emxArray_real32_T *cpu_y;
  emxArray_real32_T *d_cpu_x;
  int32_T i;
  int32_T i1;
  boolean_T abswt2S_outdatedOnCpu;
  boolean_T doDownsample;
  boolean_T r_outdatedOnCpu;
  boolean_T r_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  boolean_T xposdft_needsGpuEnsureCapacity;
  boolean_T xv_outdatedOnCpu;
  gpuEmxReset_real32_T(&d_gpu_x);
  gpuEmxReset_real32_T(&b_gpu_x);
  gpuEmxReset_real32_T(&gpu_r);
  gpuEmxReset_real32_T(&gpu_xCh);
  gpuEmxReset_real32_T(&gpu_c);
  gpuEmxReset_real32_T(&c_gpu_y);
  gpuEmxReset_real32_T(&gpu_abswt2S);
  gpuEmxReset_real32_T(&b_gpu_y);
  gpuEmxReset_real32_T(&gpu_y);
  gpuEmxReset_creal32_T(&gpu_cfs);
  gpuEmxReset_real32_T(&c_gpu_x);
  gpuEmxReset_creal32_T(&gpu_cfsposdft);
  gpuEmxReset_creal32_T(&gpu_xposdft);
  gpuEmxReset_real32_T(&gpu_xv);
  gpuEmxReset_real32_T(&gpu_psihat);
  gpuEmxReset_real32_T(&gpu_Scales);
  gpuEmxReset_real32_T(&gpu_savgpTMP);
  gpuEmxReset_real32_T(&gpu_x);
  abswt2S_outdatedOnCpu = false;
  x_outdatedOnGpu = true;
  xposdft_needsGpuEnsureCapacity = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInitStruct_cwtfilterbank(&fb, &x_emlrtRTEI, true);
  //  CWT scale spectrum - CUDA binary wrapper (double-precision, FP64)
  //  CWT uses morse wavelets, as they account for unequal variance-covariance
  //  across freqs. L1-norm is applied to mitigate 1/f decay of neuronal field
  //  potentials. Log-transform & robust z-scoring converts absolute valued CWT
  //  outputs into normal distribution.
  //
  //  Kevin Tan, 2022 (kevmtan.github.io)
  //  Input validation
  // 'ec_cwtAvg:11' x (:,:){mustBeFloat}
  //  Input data
  // 'ec_cwtAvg:12' fs (1,1) double = 1000
  //  Sampling rate
  // 'ec_cwtAvg:13' fLims (1,2) double = [1 300]
  //  Frequency limits
  // 'ec_cwtAvg:14' fVoices (1,1) double = 10
  //  Voices per octave
  // 'ec_cwtAvg:15' ds (1,2) double = [1 1]
  //  Frequency limits
  // 'ec_cwtAvg:17' coder.gpu.kernelfun;
  // 'ec_cwtAvg:18' fVoices = round(fVoices);
  fVoices = std::round(fVoices);
  // 'ec_cwtAvg:19' nFrames = height(x);
  // 'ec_cwtAvg:20' nChs = width(x);
  // 'ec_cwtAvg:21' doDownsample = ds(2)>ds(1);
  doDownsample = (ds[1] > ds[0]);
  //  Prep CWT
  // 'ec_cwtAvg:24' fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
  // 'ec_cwtAvg:25'
  // SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);
  coder::cwtfilterbank_cwtfilterbank(&fb, static_cast<real_T>(cpu_x->size[0]),
                                     fs, fLims, fVoices);
  // 'ec_cwtAvg:26' freqs = centerFrequencies(fb);
  i = freqs->size[0];
  freqs->size[0] = fb.WaveletCenterFrequencies->size[0];
  emxEnsureCapacity_real_T(freqs, i, &emlrtRTEI);
  for (i = 0; i < fb.WaveletCenterFrequencies->size[0]; i++) {
    freqs->data[i] = fb.WaveletCenterFrequencies->data[i];
  }
  //  Preallocate
  // 'ec_cwtAvg:29' tmp = cell(1,nChs);
  i = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = cpu_x->size[1];
  emxEnsureCapacity_cell_wrap_0(y, i, &b_emlrtRTEI);
  // 'ec_cwtAvg:30' y = coder.nullcopy(tmp);
  //  y = coder.nullcopy(x); % Preallocate output
  //  CWT average power (L1-norm & variance-norm usng weighted integrals)
  // 'ec_cwtAvg:34' for ch = 1:nChs
  i1 = cpu_x->size[1];
  emxInit_real32_T(&cpu_savgpTMP, 2, &y_emlrtRTEI, true);
  emxInit_real32_T(&cpu_Scales, 2, &c_emlrtRTEI, true);
  emxInit_real32_T(&cpu_psihat, 2, &d_emlrtRTEI, true);
  emxInit_real32_T(&cpu_xv, 2, &f_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_xposdft, 2, &g_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_cfsposdft, 2, &ab_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_x, 2, &j_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_cfs, 2, &l_emlrtRTEI, true);
  emxInit_real32_T(&cpu_y, 2, &bb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_y, 2, &bb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_abswt2S, 2, &p_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_y, 2, &q_emlrtRTEI, true);
  emxInit_real32_T(&cpu_c, 1, &t_emlrtRTEI, true);
  emxInit_real32_T(&cpu_xCh, 1, &u_emlrtRTEI, true);
  emxInit_real32_T(&cpu_r, 2, &cb_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_x, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_x, 1, &m_emlrtRTEI, true);
  for (int32_T ch{0}; ch < i1; ch++) {
    real_T cpsi;
    int32_T acoef;
    int32_T i3;
    int32_T i4;
    int32_T j2;
    int32_T loop_ub;
    int32_T nd2;
    real32_T c1;
    uint32_T xSize[2];
    uint32_T defaultSL_idx_1;
    boolean_T Scales_outdatedOnGpu;
    boolean_T psihat_outdatedOnGpu;
    boolean_T validLaunchParams;
    // 'ec_cwtAvg:35' xCh = scaleSpectrum(fb,x(:,ch),SpectrumType="density")';
    defaultSL_idx_1 = static_cast<uint32_T>(fb.Scales->size[1]);
    Scales_outdatedOnGpu = false;
    i = cpu_Scales->size[0] * cpu_Scales->size[1];
    cpu_Scales->size[0] = 1;
    cpu_Scales->size[1] = fb.Scales->size[1];
    emxEnsureCapacity_real32_T(cpu_Scales, i, &c_emlrtRTEI);
    for (i = 0; i < fb.Scales->size[1]; i++) {
      cpu_Scales->data[i] = static_cast<real32_T>(fb.Scales->data[i]);
      Scales_outdatedOnGpu = true;
    }
    psihat_outdatedOnGpu = false;
    i = cpu_psihat->size[0] * cpu_psihat->size[1];
    cpu_psihat->size[0] = fb.PsiDFT->size[0];
    cpu_psihat->size[1] = fb.PsiDFT->size[1];
    emxEnsureCapacity_real32_T(cpu_psihat, i, &d_emlrtRTEI);
    for (i = 0; i < fb.PsiDFT->size[0] * fb.PsiDFT->size[1]; i++) {
      cpu_psihat->data[i] = static_cast<real32_T>(fb.PsiDFT->data[i]);
      psihat_outdatedOnGpu = true;
    }
    nd2 = cpu_x->size[0];
    i = c_cpu_x->size[0];
    c_cpu_x->size[0] = cpu_x->size[0];
    emxEnsureCapacity_real32_T(c_cpu_x, i, &e_emlrtRTEI);
    i = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    cpu_xv->size[1] = cpu_x->size[0];
    emxEnsureCapacity_real32_T(cpu_xv, i, &f_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(nd2 - 1), &grid, &block,
                            2147483647U);
    if (x_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real32_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
    }
    x_needsGpuEnsureCapacity = false;
    gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, true);
    r_outdatedOnCpu = false;
    gpuEmxEnsureCapacity_real32_T(c_cpu_x, &b_gpu_x, true);
    if (x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
    }
    x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel1<<<grid, block>>>(ch, gpu_x, nd2 - 1, gpu_xv, b_gpu_x,
                                         cpu_x->size[0U]);
    }
    r_outdatedOnGpu = false;
    gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_x, &b_gpu_x);
    fb.sigvar = coder::vvarstd(c_cpu_x, cpu_x->size[0]);
    if (fb.SignalPad > 0.0) {
      cpsi = fb.SignalPad;
      if (cpsi < 1.0) {
        acoef = 0;
      } else {
        acoef = static_cast<int32_T>(cpsi);
      }
      cpsi = (static_cast<real_T>(cpu_x->size[0]) - fb.SignalPad) + 1.0;
      if (cpsi > cpu_x->size[0]) {
        i3 = 0;
        i4 = 1;
        j2 = -1;
      } else {
        i3 = cpu_x->size[0] - 1;
        i4 = -1;
        j2 = static_cast<int32_T>(cpsi) - 1;
      }
      i = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = 1;
      b_cpu_x->size[1] = acoef;
      emxEnsureCapacity_real32_T(b_cpu_x, i, &j_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(acoef - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real32_T(b_cpu_x, &c_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel2<<<grid, block>>>(ch, gpu_x, acoef - 1, c_gpu_x,
                                           cpu_x->size[0U]);
      }
      mwGetLaunchParameters1D(computeNumIters((acoef >> 1) - 1), &grid, &block,
                              2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel3<<<grid, block>>>(acoef, (acoef >> 1) - 1, c_gpu_x);
      }
      i = cpu_xv->size[0] * cpu_xv->size[1];
      cpu_xv->size[0] = 1;
      cpu_xv->size[1] =
          ((cpu_x->size[0] + b_cpu_x->size[1]) + div_s32(j2 - i3, i4)) + 1;
      emxEnsureCapacity_real32_T(cpu_xv, i, &k_emlrtRTEI);
      loop_ub = b_cpu_x->size[1];
      mwGetLaunchParameters1D(computeNumIters(loop_ub - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel4<<<grid, block>>>(c_gpu_x, loop_ub - 1, gpu_xv);
      }
      xv_outdatedOnCpu = true;
      loop_ub = cpu_x->size[0];
      for (i = 0; i < loop_ub; i++) {
        if (xv_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xv, &gpu_xv);
        }
        cpu_xv->data[i + b_cpu_x->size[1]] =
            cpu_x->data[i + cpu_x->size[0] * ch];
        xv_outdatedOnCpu = false;
        r_outdatedOnGpu = true;
        x_needsGpuEnsureCapacity = true;
        r_outdatedOnCpu = true;
      }
      loop_ub = div_s32(j2 - i3, i4);
      for (i = 0; i <= loop_ub; i++) {
        if (xv_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xv, &gpu_xv);
        }
        cpu_xv->data[(i + cpu_x->size[0]) + b_cpu_x->size[1]] =
            cpu_x->data[(i3 + i4 * i) + cpu_x->size[0] * ch];
        xv_outdatedOnCpu = false;
        r_outdatedOnGpu = true;
        x_needsGpuEnsureCapacity = true;
        r_outdatedOnCpu = true;
      }
    }
    if (cpu_xv->size[1] == 0) {
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = 0;
    } else if (cpu_xv->size[1] -
                   (static_cast<int32_T>(
                        static_cast<uint32_T>(cpu_xv->size[1]) >> 1)
                    << 1) ==
               1) {
      cufftHandle fftPlanHandle;
      i = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = cpu_xv->size[1];
      emxEnsureCapacity_creal32_T(cpu_xposdft, i, &g_emlrtRTEI);
      j2 = cpu_xv->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      if (r_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, !r_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft, true);
      if (r_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel22<<<grid, block>>>(gpu_xv, j2, gpu_xposdft);
      }
      nd2 = cpu_xposdft->size[1];
      fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, 1, 1, CUFFT_C2C, 1);
      xposdft_needsGpuEnsureCapacity = false;
      cufftExecC2C(fftPlanHandle, (cufftComplex *)&gpu_xposdft.data[0],
                   (cufftComplex *)&gpu_xposdft.data[0], CUFFT_FORWARD);
    } else {
      cufftHandle b_fftPlanHandle;
      nd2 = cpu_xv->size[1];
      for (j2 = 0; j2 < 2; j2++) {
        xSize[j2] = static_cast<uint32_T>(cpu_xv->size[j2]);
      }
      i = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = static_cast<int32_T>(xSize[1]);
      emxEnsureCapacity_creal32_T(cpu_xposdft, i, &h_emlrtRTEI);
      b_fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, 1, 1, CUFFT_R2C, 1);
      if (r_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, !r_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft, true);
      if (r_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
      }
      cufftExecR2C(b_fftPlanHandle, (cufftReal *)&gpu_xv.data[0],
                   (cufftComplex *)&gpu_xposdft.data[0]);
      mwGetLaunchParameters1D(
          computeNumIters(
              static_cast<int32_T>(
                  static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) /
                  2.0) -
              2),
          &grid, &block, 2147483647U);
      xposdft_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel23<<<grid, block>>>(
            static_cast<int32_T>(
                static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) / 2.0) -
                2,
            gpu_xposdft, xSize[1]);
      }
    }
    nd2 = cpu_psihat->size[1];
    acoef = cpu_xposdft->size[1];
    if (nd2 <= acoef) {
      acoef = nd2;
    }
    if (cpu_psihat->size[1] == 1) {
      i = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == 1) {
      i = cpu_psihat->size[1];
    } else if (cpu_xposdft->size[1] == cpu_psihat->size[1]) {
      i = cpu_xposdft->size[1];
    } else {
      i = acoef;
    }
    i4 = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
    cpu_cfsposdft->size[0] = cpu_psihat->size[0];
    nd2 = cpu_psihat->size[1];
    acoef = cpu_xposdft->size[1];
    if (nd2 <= acoef) {
      acoef = nd2;
    }
    if (cpu_psihat->size[1] == 1) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == 1) {
      cpu_cfsposdft->size[1] = cpu_psihat->size[1];
    } else if (cpu_xposdft->size[1] == cpu_psihat->size[1]) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else {
      cpu_cfsposdft->size[1] = acoef;
    }
    emxEnsureCapacity_creal32_T(cpu_cfsposdft, i4, &i_emlrtRTEI);
    r_outdatedOnCpu = true;
    if ((cpu_psihat->size[0] != 0) && (i != 0)) {
      acoef = (cpu_xposdft->size[1] != 1);
      nd2 = (cpu_psihat->size[1] != 1);
      j2 = cpu_cfsposdft->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i - 1, j2), &grid, &block,
                              2147483647U);
      if (xposdft_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft, true);
      }
      xposdft_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_real32_T(cpu_psihat, &gpu_psihat,
                                    !psihat_outdatedOnGpu);
      gpuEmxEnsureCapacity_creal32_T(cpu_cfsposdft, &gpu_cfsposdft, true);
      r_outdatedOnCpu = false;
      if (psihat_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_psihat, cpu_psihat);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel5<<<grid, block>>>(
            gpu_xposdft, gpu_psihat, nd2, acoef, j2, i - 1, gpu_cfsposdft,
            cpu_psihat->size[0U], cpu_cfsposdft->size[0U]);
      }
    }
    if ((cpu_cfsposdft->size[0] == 0) || (cpu_cfsposdft->size[1] == 0)) {
      for (j2 = 0; j2 < 2; j2++) {
        xSize[j2] = static_cast<uint32_T>(cpu_cfsposdft->size[j2]);
      }
      xSize[1] = static_cast<uint32_T>(cpu_cfsposdft->size[1]);
      i = cpu_cfs->size[0] * cpu_cfs->size[1];
      cpu_cfs->size[0] = static_cast<int32_T>(xSize[0]);
      cpu_cfs->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal32_T(cpu_cfs, i, &l_emlrtRTEI);
      j2 = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_cfs, &gpu_cfs, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel6<<<grid, block>>>(j2, gpu_cfs);
      }
      r_outdatedOnCpu = true;
    } else {
      cufftHandle c_fftPlanHandle;
      nd2 = cpu_cfsposdft->size[1];
      c_fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, cpu_cfsposdft->size[0],
                                         1, CUFFT_C2C, cpu_cfsposdft->size[0]);
      if (r_outdatedOnCpu) {
        gpuEmxEnsureCapacity_creal32_T(cpu_cfsposdft, &gpu_cfsposdft, true);
      }
      cufftExecC2C(c_fftPlanHandle, (cufftComplex *)&gpu_cfsposdft.data[0],
                   (cufftComplex *)&gpu_cfsposdft.data[0], CUFFT_INVERSE);
      i = cpu_cfs->size[0] * cpu_cfs->size[1];
      cpu_cfs->size[0] = cpu_cfsposdft->size[0];
      cpu_cfs->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal32_T(cpu_cfs, i, &l_emlrtRTEI);
      c1 = static_cast<real32_T>(cpu_cfsposdft->size[1]);
      j2 = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_cfs, &gpu_cfs, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel21<<<grid, block>>>(c1, gpu_cfsposdft, j2, gpu_cfs);
      }
      r_outdatedOnCpu = true;
    }
    if (fb.SignalPad > 0.0) {
      real_T d3;
      cpsi = fb.SignalPad + 1.0;
      d3 = fb.SignalPad + fb.SignalLength;
      if (cpsi > d3) {
        nd2 = 0;
        acoef = 0;
      } else {
        nd2 = static_cast<int32_T>(cpsi) - 1;
        acoef = static_cast<int32_T>(d3);
      }
      i3 = cpu_cfs->size[0];
      loop_ub = acoef - nd2;
      for (i = 0; i < loop_ub; i++) {
        for (i4 = 0; i4 < i3; i4++) {
          if (r_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_cfs, &gpu_cfs);
          }
          cpu_cfs->data[i4 + i3 * i] =
              cpu_cfs->data[i4 + cpu_cfs->size[0] * (nd2 + i)];
          r_outdatedOnCpu = false;
        }
      }
      i = cpu_cfs->size[0] * cpu_cfs->size[1];
      cpu_cfs->size[1] = acoef - nd2;
      emxEnsureCapacity_creal32_T(cpu_cfs, i, &l_emlrtRTEI);
    }
    cpsi =
        coder::wavelet::internal::cwt::numCpsi(fb.Wavelet, fb.Gamma, fb.Beta);
    i = d_cpu_x->size[0];
    d_cpu_x->size[0] = cpu_x->size[0];
    emxEnsureCapacity_real32_T(d_cpu_x, i, &m_emlrtRTEI);
    j2 = cpu_x->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    if (x_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real32_T(cpu_x, &gpu_x, true);
    }
    x_needsGpuEnsureCapacity = false;
    gpuEmxEnsureCapacity_real32_T(d_cpu_x, &d_gpu_x, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel7<<<grid, block>>>(ch, gpu_x, j2, d_gpu_x,
                                         cpu_x->size[0U]);
    }
    if (r_outdatedOnCpu) {
      gpuEmxMemcpyGpuToCpu_creal32_T(cpu_cfs, &gpu_cfs);
    }
    gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_x, &d_gpu_x);
    coder::wavelet::internal::cwt::scNormalize(
        cpu_cfs, cpsi, cpu_Scales, coder::vvarstd(d_cpu_x, cpu_x->size[0]));
    nd2 = cpu_cfs->size[0] * cpu_cfs->size[1];
    for (j2 = 0; j2 < 2; j2++) {
      xSize[j2] = static_cast<uint32_T>(cpu_cfs->size[j2]);
    }
    i = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(cpu_y, i, &n_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(nd2 - 1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_cfs, &gpu_cfs, false);
    gpuEmxEnsureCapacity_real32_T(cpu_y, &gpu_y, true);
    gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_cfs, cpu_cfs);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel8<<<grid, block>>>(gpu_cfs, nd2 - 1, gpu_y);
    }
    for (j2 = 0; j2 < 2; j2++) {
      xSize[j2] = static_cast<uint32_T>(cpu_y->size[j2]);
    }
    i = b_cpu_y->size[0] * b_cpu_y->size[1];
    b_cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    b_cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(b_cpu_y, i, &o_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(xSize[0]) *
                                                static_cast<int32_T>(xSize[1]) -
                                            1),
                            &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(b_cpu_y, &b_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel9<<<grid, block>>>(
          gpu_y,
          static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1,
          b_gpu_y);
    }
    if (b_cpu_y->size[0] == cpu_Scales->size[1]) {
      i = cpu_abswt2S->size[0] * cpu_abswt2S->size[1];
      cpu_abswt2S->size[0] = b_cpu_y->size[0];
      cpu_abswt2S->size[1] = b_cpu_y->size[1];
      emxEnsureCapacity_real32_T(cpu_abswt2S, i, &p_emlrtRTEI);
      j2 = b_cpu_y->size[1] - 1;
      i3 = b_cpu_y->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2, i3), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_Scales, &gpu_Scales,
                                    !Scales_outdatedOnGpu);
      r_outdatedOnGpu = false;
      gpuEmxEnsureCapacity_real32_T(cpu_abswt2S, &gpu_abswt2S, true);
      xv_outdatedOnCpu = false;
      if (Scales_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_Scales, cpu_Scales);
      }
      Scales_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel10<<<grid, block>>>(gpu_Scales, b_gpu_y, i3, j2,
                                            gpu_abswt2S, cpu_abswt2S->size[0U],
                                            b_cpu_y->size[0U]);
      }
      r_outdatedOnCpu = false;
      abswt2S_outdatedOnCpu = true;
    } else {
      if (abswt2S_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_abswt2S, &gpu_abswt2S);
      }
      gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_y, &b_gpu_y);
      binary_expand_op(cpu_abswt2S, b_cpu_y, cpu_Scales);
      abswt2S_outdatedOnCpu = false;
      r_outdatedOnCpu = true;
      r_outdatedOnGpu = true;
      xv_outdatedOnCpu = true;
    }
    i = c_cpu_y->size[0] * c_cpu_y->size[1];
    c_cpu_y->size[0] = static_cast<int32_T>(defaultSL_idx_1);
    c_cpu_y->size[1] = cpu_abswt2S->size[1];
    emxEnsureCapacity_real32_T(c_cpu_y, i, &q_emlrtRTEI);
    j2 = cpu_abswt2S->size[1] - 1;
    mwGetLaunchParameters1D(
        computeNumIters(j2, static_cast<int32_T>(defaultSL_idx_1) - 1), &grid,
        &block, 2147483647U);
    if (xv_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real32_T(cpu_abswt2S, &gpu_abswt2S,
                                    !r_outdatedOnCpu);
    }
    gpuEmxEnsureCapacity_real32_T(c_cpu_y, &c_gpu_y, true);
    if (r_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_abswt2S, cpu_abswt2S);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel11<<<grid, block>>>(
          gpu_abswt2S, static_cast<int32_T>(defaultSL_idx_1) - 1, j2, c_gpu_y,
          c_cpu_y->size[0U], cpu_abswt2S->size[0U]);
    }
    if ((static_cast<int32_T>(defaultSL_idx_1) == 0) &&
        (cpu_abswt2S->size[1] == 0)) {
      if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
        c1 = cpu_Scales->data[0] * 0.0F;
      } else {
        c1 = 0.0F;
      }
      i = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
      cpu_savgpTMP->size[0] = 1;
      cpu_savgpTMP->size[1] = 1;
      emxEnsureCapacity_real32_T(cpu_savgpTMP, i, &r_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_savgpTMP, &gpu_savgpTMP, true);
      ec_cwtAvg_kernel12<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(c1,
                                                                  gpu_savgpTMP);
    } else {
      i = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
      cpu_savgpTMP->size[0] = 1;
      cpu_savgpTMP->size[1] = cpu_abswt2S->size[1];
      emxEnsureCapacity_real32_T(cpu_savgpTMP, i, &r_emlrtRTEI);
      j2 = cpu_abswt2S->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_savgpTMP, &gpu_savgpTMP, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel14<<<grid, block>>>(j2, gpu_savgpTMP);
      }
      if (static_cast<int32_T>(defaultSL_idx_1) <= 1) {
        if ((static_cast<int32_T>(defaultSL_idx_1) == 1) &&
            (std::isinf(cpu_Scales->data[0]) ||
             std::isnan(cpu_Scales->data[0]))) {
          i = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
          cpu_savgpTMP->size[0] = 1;
          cpu_savgpTMP->size[1] = cpu_abswt2S->size[1];
          emxEnsureCapacity_real32_T(cpu_savgpTMP, i, &r_emlrtRTEI);
          j2 = cpu_abswt2S->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_savgpTMP, &gpu_savgpTMP, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel15<<<grid, block>>>(j2, gpu_savgpTMP);
          }
        }
      } else {
        if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
          i = cpu_c->size[0];
          cpu_c->size[0] = static_cast<int32_T>(defaultSL_idx_1);
          emxEnsureCapacity_real32_T(cpu_c, i, &t_emlrtRTEI);
          mwGetLaunchParameters1D(
              computeNumIters(static_cast<int32_T>(defaultSL_idx_1) - 1), &grid,
              &block, 2147483647U);
          if (r_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_Scales, &gpu_Scales,
                                          !Scales_outdatedOnGpu);
          }
          gpuEmxEnsureCapacity_real32_T(cpu_c, &gpu_c, true);
          if (Scales_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_Scales, cpu_Scales);
          }
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel16<<<grid, block>>>(
                gpu_Scales, static_cast<int32_T>(defaultSL_idx_1) - 1, gpu_c);
          }
          c1 = 0.5F * cpu_Scales->data[0];
          ec_cwtAvg_kernel17<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
              static_cast<int32_T>(defaultSL_idx_1), c1, gpu_c);
        } else {
          i = cpu_c->size[0];
          cpu_c->size[0] = static_cast<int32_T>(defaultSL_idx_1);
          emxEnsureCapacity_real32_T(cpu_c, i, &s_emlrtRTEI);
          if (r_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_Scales, &gpu_Scales,
                                          !Scales_outdatedOnGpu);
          }
          gpuEmxEnsureCapacity_real32_T(cpu_c, &gpu_c, true);
          if (Scales_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_Scales, cpu_Scales);
          }
          ec_cwtAvg_kernel18<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
              gpu_Scales, gpu_c);
          mwGetLaunchParameters1D(
              computeNumIters(static_cast<int32_T>(defaultSL_idx_1) - 3), &grid,
              &block, 2147483647U);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel19<<<grid, block>>>(
                gpu_Scales, static_cast<int32_T>(defaultSL_idx_1) - 3, gpu_c);
          }
          ec_cwtAvg_kernel20<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
              gpu_Scales, static_cast<int32_T>(defaultSL_idx_1), gpu_c);
        }
        if (cpu_abswt2S->size[1] >= 1) {
          real32_T alpha1;
          c1 = 0.0F;
          alpha1 = 1.0F;
          cublasCheck(cublasSgemv(getCublasGlobalHandle(), CUBLAS_OP_T,
                                  static_cast<int32_T>(defaultSL_idx_1),
                                  cpu_abswt2S->size[1], (float *)&alpha1,
                                  (float *)&c_gpu_y.data[0],
                                  static_cast<int32_T>(defaultSL_idx_1),
                                  (float *)&gpu_c.data[0], 1, (float *)&c1,
                                  (float *)&gpu_savgpTMP.data[0], 1),
                      __FILE__, __LINE__);
        }
      }
    }
    i = cpu_xCh->size[0];
    cpu_xCh->size[0] = cpu_savgpTMP->size[1];
    emxEnsureCapacity_real32_T(cpu_xCh, i, &u_emlrtRTEI);
    j2 = cpu_savgpTMP->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_xCh, &gpu_xCh, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel13<<<grid, block>>>(gpu_savgpTMP, j2, gpu_xCh);
    }
    xv_outdatedOnCpu = false;
    psihat_outdatedOnGpu = true;
    //  Downsample
    // 'ec_cwtAvg:38' if doDownsample
    if (doDownsample) {
      // 'ec_cwtAvg:39' y{ch} = resample(xCh,ds(1),ds(2));
      coder::resample(cpu_xCh, &gpu_xCh, &xv_outdatedOnCpu, ds[0], ds[1], cpu_r,
                      &r_outdatedOnCpu, &gpu_r, &r_outdatedOnGpu);
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[0] = cpu_r->size[0];
      emxEnsureCapacity_real32_T(y->data[ch].f1, i, &w_emlrtRTEI);
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[1] = 1;
      emxEnsureCapacity_real32_T(y->data[ch].f1, i, &w_emlrtRTEI);
      for (i = 0; i < cpu_r->size[0]; i++) {
        if (r_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_r, &gpu_r);
        }
        r_outdatedOnCpu = false;
        y->data[ch].f1->data[i] = cpu_r->data[i];
      }
      //  Downsample
    } else {
      // 'ec_cwtAvg:40' else
      // 'ec_cwtAvg:41' y{ch} = xCh;
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[0] = cpu_xCh->size[0];
      emxEnsureCapacity_real32_T(y->data[ch].f1, i, &v_emlrtRTEI);
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[1] = 1;
      emxEnsureCapacity_real32_T(y->data[ch].f1, i, &v_emlrtRTEI);
      for (i = 0; i < cpu_xCh->size[0]; i++) {
        if (psihat_outdatedOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xCh, &gpu_xCh);
        }
        psihat_outdatedOnGpu = false;
        y->data[ch].f1->data[i] = cpu_xCh->data[i];
      }
    }
  }
  emxFree_real32_T(&d_cpu_x);
  emxFree_real32_T(&c_cpu_x);
  emxFree_real32_T(&cpu_r);
  emxFree_real32_T(&cpu_xCh);
  emxFree_real32_T(&cpu_c);
  emxFree_real32_T(&c_cpu_y);
  emxFree_real32_T(&cpu_abswt2S);
  emxFree_real32_T(&b_cpu_y);
  emxFree_real32_T(&cpu_y);
  emxFree_creal32_T(&cpu_cfs);
  emxFree_real32_T(&b_cpu_x);
  emxFree_creal32_T(&cpu_cfsposdft);
  emxFree_creal32_T(&cpu_xposdft);
  emxFree_real32_T(&cpu_xv);
  emxFree_real32_T(&cpu_psihat);
  emxFree_real32_T(&cpu_Scales);
  emxFree_real32_T(&cpu_savgpTMP);
  emxFreeStruct_cwtfilterbank(&fb);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real32_T(&gpu_x);
  gpuEmxFree_real32_T(&gpu_savgpTMP);
  gpuEmxFree_real32_T(&gpu_Scales);
  gpuEmxFree_real32_T(&gpu_psihat);
  gpuEmxFree_real32_T(&gpu_xv);
  gpuEmxFree_creal32_T(&gpu_xposdft);
  gpuEmxFree_creal32_T(&gpu_cfsposdft);
  gpuEmxFree_real32_T(&c_gpu_x);
  gpuEmxFree_creal32_T(&gpu_cfs);
  gpuEmxFree_real32_T(&gpu_y);
  gpuEmxFree_real32_T(&b_gpu_y);
  gpuEmxFree_real32_T(&gpu_abswt2S);
  gpuEmxFree_real32_T(&c_gpu_y);
  gpuEmxFree_real32_T(&gpu_c);
  gpuEmxFree_real32_T(&gpu_xCh);
  gpuEmxFree_real32_T(&gpu_r);
  gpuEmxFree_real32_T(&b_gpu_x);
  gpuEmxFree_real32_T(&d_gpu_x);
}

// End of code generation (ec_cwtAvg.cu)
