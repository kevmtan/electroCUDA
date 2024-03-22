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

static emlrtRTEInfo
    c_emlrtRTEI{
        105,      // lineNo
        20,       // colNo
        "varstd", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/"
        "varstd.m" // pName
    };

static emlrtRTEInfo d_emlrtRTEI{
    135,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    143,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "cuFFTNDCallback", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "cuFFTNDCallback.p" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    138,  // lineNo
    19,   // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    138,  // lineNo
    6,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    236,             // lineNo
    5,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    35,                                                    // lineNo
    28,                                                    // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    298,             // lineNo
    18,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo p_emlrtRTEI{
    297,             // lineNo
    5,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo s_emlrtRTEI{
    35,                                                    // lineNo
    5,                                                     // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo t_emlrtRTEI{
    41,                                                    // lineNo
    9,                                                     // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    39,                                                    // lineNo
    9,                                                     // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo v_emlrtRTEI{
    24,                                                    // lineNo
    1,                                                     // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

static emlrtRTEInfo w_emlrtRTEI{
    287,             // lineNo
    5,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo x_emlrtRTEI{
    151,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo y_emlrtRTEI{
    293,             // lineNo
    14,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo ab_emlrtRTEI{
    39,                                                    // lineNo
    17,                                                    // colNo
    "ec_cwtAvg",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m" // pName
};

// Function Declarations
static __global__ void ec_cwtAvg_kernel1(const int32_T ch,
                                         const emxArray_real_T x,
                                         const int32_T b, emxArray_real_T xv,
                                         emxArray_real_T b_x, int32_T x_dim0);

static __global__ void ec_cwtAvg_kernel10(const real_T cpsi,
                                          emxArray_real_T savgpTMP);

static __global__ void ec_cwtAvg_kernel11(const emxArray_real_T savgpTMP,
                                          const int32_T b_savgpTMP,
                                          emxArray_real_T xCh);

static __global__ void ec_cwtAvg_kernel12(const int32_T abswt2S,
                                          emxArray_real_T savgpTMP);

static __global__ void ec_cwtAvg_kernel13(const int32_T abswt2S,
                                          emxArray_real_T savgpTMP);

static __global__ void ec_cwtAvg_kernel14(const real_T cpsi, emxArray_real_T c);

static __global__ void ec_cwtAvg_kernel15(const real_T cpsi, const int32_T i2,
                                          emxArray_real_T c);

static __global__ void ec_cwtAvg_kernel16(const real_T cfsposdft_re,
                                          const emxArray_creal_T cfsposdft,
                                          const int32_T b_cfsposdft,
                                          emxArray_creal_T cfs);

static __global__ void ec_cwtAvg_kernel17(const emxArray_real_T xv,
                                          const int32_T b_xv,
                                          emxArray_creal_T xposdft);

static __global__ void ec_cwtAvg_kernel18(const int32_T b,
                                          emxArray_creal_T xposdft,
                                          uint32_T xSize_dim1);

static __global__ void ec_cwtAvg_kernel2(const int32_T ch,
                                         const emxArray_real_T x,
                                         const int32_T b, emxArray_real_T b_x,
                                         int32_T x_dim0);

static __global__ void ec_cwtAvg_kernel3(const int32_T i2, const int32_T b,
                                         emxArray_real_T x);

static __global__ void ec_cwtAvg_kernel4(const emxArray_real_T x,
                                         const int32_T b, emxArray_real_T xv);

static __global__ void ec_cwtAvg_kernel5(const int32_T xSize,
                                         emxArray_creal_T cfs);

static __global__ void ec_cwtAvg_kernel6(const int32_T ch,
                                         const emxArray_real_T x,
                                         const int32_T b_x, emxArray_real_T c_x,
                                         int32_T x_dim0);

static __global__ void ec_cwtAvg_kernel7(const emxArray_creal_T cfs,
                                         const int32_T b, emxArray_real_T y);

static __global__ void ec_cwtAvg_kernel8(const emxArray_real_T y,
                                         const int32_T b, emxArray_real_T b_y);

static __global__ void ec_cwtAvg_kernel9(const emxArray_real_T abswt2S,
                                         const int32_T b,
                                         const int32_T b_abswt2S,
                                         emxArray_real_T y, int32_T y_dim0,
                                         int32_T abswt2S_dim0);

static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
                                         emxArray_creal_T *gpu,
                                         boolean_T needsCopy);

static void gpuEmxFree_creal_T(emxArray_creal_T *gpu);

static void gpuEmxMemcpyCpuToGpu_creal_T(emxArray_creal_T *gpu,
                                         const emxArray_creal_T *cpu);

static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu,
                                         emxArray_creal_T *gpu);

static void gpuEmxReset_creal_T(emxArray_creal_T *gpu);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel1(
    const int32_T ch, const emxArray_real_T x, const int32_T b,
    emxArray_real_T xv, emxArray_real_T b_x, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T xtmp;
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    xtmp = x.data[j2 + x_dim0 * ch];
    b_x.data[j2] = xtmp;
    xv.data[j2] = xtmp;
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_cwtAvg_kernel10(const real_T cpsi,
                                                     emxArray_real_T savgpTMP)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    savgpTMP.data[0] = cpsi;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel11(
    const emxArray_real_T savgpTMP, const int32_T b_savgpTMP,
    emxArray_real_T xCh)
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

static __global__
    __launch_bounds__(1024, 1) void ec_cwtAvg_kernel12(const int32_T abswt2S,
                                                       emxArray_real_T savgpTMP)
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
    savgpTMP.data[j2] = 0.0;
  }
}

static __global__
    __launch_bounds__(1024, 1) void ec_cwtAvg_kernel13(const int32_T abswt2S,
                                                       emxArray_real_T savgpTMP)
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
    savgpTMP.data[j2] = CUDART_NAN;
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_cwtAvg_kernel14(const real_T cpsi,
                                                     emxArray_real_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = cpsi;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel15(
    const real_T cpsi, const int32_T i2, emxArray_real_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[i2 - 1] = cpsi;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel16(
    const real_T cfsposdft_re, const emxArray_creal_T cfsposdft,
    const int32_T b_cfsposdft, emxArray_creal_T cfs)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfsposdft);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T ai;
    real_T xtmp;
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    xtmp = cfsposdft.data[j2].re;
    ai = cfsposdft.data[j2].im;
    if (ai == 0.0) {
      cfs.data[j2].re = xtmp / cfsposdft_re;
      cfs.data[j2].im = 0.0;
    } else if (xtmp == 0.0) {
      cfs.data[j2].re = 0.0;
      cfs.data[j2].im = ai / cfsposdft_re;
    } else {
      cfs.data[j2].re = xtmp / cfsposdft_re;
      cfs.data[j2].im = ai / cfsposdft_re;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel17(
    const emxArray_real_T xv, const int32_T b_xv, emxArray_creal_T xposdft)
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
    xposdft.data[j2].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel18(
    const int32_T b, emxArray_creal_T xposdft, uint32_T xSize_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_j1;
    b_j1 = static_cast<int32_T>(idx);
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - b_j1) - 1].re =
        xposdft.data[b_j1 + 1].re;
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - b_j1) - 1].im =
        -xposdft.data[b_j1 + 1].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel2(
    const int32_T ch, const emxArray_real_T x, const int32_T b,
    emxArray_real_T b_x, int32_T x_dim0)
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

static __global__ __launch_bounds__(1024,
                                    1) void ec_cwtAvg_kernel3(const int32_T i2,
                                                              const int32_T b,
                                                              emxArray_real_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T xtmp;
    int32_T b_j1;
    int32_T j2;
    b_j1 = static_cast<int32_T>(idx);
    j2 = i2 - b_j1;
    xtmp = x.data[b_j1];
    x.data[b_j1] = x.data[j2 - 1];
    x.data[j2 - 1] = xtmp;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel4(
    const emxArray_real_T x, const int32_T b, emxArray_real_T xv)
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

static __global__
    __launch_bounds__(1024, 1) void ec_cwtAvg_kernel5(const int32_T xSize,
                                                      emxArray_creal_T cfs)
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
    cfs.data[j2].re = 0.0;
    cfs.data[j2].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel6(
    const int32_T ch, const emxArray_real_T x, const int32_T b_x,
    emxArray_real_T c_x, int32_T x_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel7(
    const emxArray_creal_T cfs, const int32_T b, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_j1;
    b_j1 = static_cast<int32_T>(idx);
    y.data[b_j1] = hypot(cfs.data[b_j1].re, cfs.data[b_j1].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel8(
    const emxArray_real_T y, const int32_T b, emxArray_real_T b_y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_j1;
    b_j1 = static_cast<int32_T>(idx);
    b_y.data[b_j1] = y.data[b_j1] * y.data[b_j1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel9(
    const emxArray_real_T abswt2S, const int32_T b, const int32_T b_abswt2S,
    emxArray_real_T y, int32_T y_dim0, int32_T abswt2S_dim0)
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
    int32_T b_j1;
    int32_T j2;
    b_j1 = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    j2 = static_cast<int32_T>((idx - static_cast<uint64_T>(b_j1)) /
                              (static_cast<uint64_T>(b) + 1UL));
    y.data[b_j1 + y_dim0 * j2] = abswt2S.data[b_j1 + abswt2S_dim0 * j2];
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

static void gpuEmxReset_creal_T(emxArray_creal_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_creal_T));
}

//
// function [y,freqs] = ec_cwtAvg(x,fs,fLims,fVoices,ds)
void ec_cwtAvg(const emxArray_real_T *cpu_x, real_T fs, const real_T fLims[2],
               real_T fVoices, const real_T ds[2], emxArray_cell_wrap_0 *y,
               emxArray_real_T *freqs)
{
  coder::cwtfilterbank fb;
  dim3 block;
  dim3 grid;
  emxArray_creal_T gpu_cfs;
  emxArray_creal_T gpu_cfsposdft;
  emxArray_creal_T gpu_xposdft;
  emxArray_creal_T *cpu_cfs;
  emxArray_creal_T *cpu_cfsposdft;
  emxArray_creal_T *cpu_xposdft;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_x;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_x;
  emxArray_real_T gpu_abswt2S;
  emxArray_real_T gpu_c;
  emxArray_real_T gpu_r;
  emxArray_real_T gpu_savgpTMP;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xCh;
  emxArray_real_T gpu_xv;
  emxArray_real_T gpu_y;
  emxArray_real_T *b_cpu_x;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_x;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_abswt2S;
  emxArray_real_T *cpu_c;
  emxArray_real_T *cpu_r;
  emxArray_real_T *cpu_savgpTMP;
  emxArray_real_T *cpu_xCh;
  emxArray_real_T *cpu_xv;
  emxArray_real_T *cpu_y;
  emxArray_real_T *d_cpu_x;
  int32_T bcoef;
  int32_T i1;
  boolean_T doDownsample;
  boolean_T r_outdatedOnCpu;
  boolean_T r_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  boolean_T xv_outdatedOnCpu;
  gpuEmxReset_real_T(&d_gpu_x);
  gpuEmxReset_real_T(&b_gpu_x);
  gpuEmxReset_real_T(&gpu_r);
  gpuEmxReset_real_T(&gpu_xCh);
  gpuEmxReset_real_T(&gpu_c);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_real_T(&gpu_abswt2S);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_creal_T(&gpu_cfs);
  gpuEmxReset_real_T(&c_gpu_x);
  gpuEmxReset_creal_T(&gpu_cfsposdft);
  gpuEmxReset_creal_T(&gpu_xposdft);
  gpuEmxReset_real_T(&gpu_xv);
  gpuEmxReset_real_T(&gpu_savgpTMP);
  gpuEmxReset_real_T(&gpu_x);
  x_outdatedOnGpu = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInitStruct_cwtfilterbank(&fb, &v_emlrtRTEI, true);
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
  bcoef = freqs->size[0];
  freqs->size[0] = fb.WaveletCenterFrequencies->size[0];
  emxEnsureCapacity_real_T(freqs, bcoef, &emlrtRTEI);
  for (bcoef = 0; bcoef < fb.WaveletCenterFrequencies->size[0]; bcoef++) {
    freqs->data[bcoef] = fb.WaveletCenterFrequencies->data[bcoef];
  }
  //  Preallocate
  // 'ec_cwtAvg:29' tmp = cell(1,nChs);
  bcoef = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = cpu_x->size[1];
  emxEnsureCapacity_cell_wrap_0(y, bcoef, &b_emlrtRTEI);
  // 'ec_cwtAvg:30' y = coder.nullcopy(tmp);
  //  y = coder.nullcopy(x); % Preallocate output
  //  CWT average power (L1-norm & variance-norm usng weighted integrals)
  // 'ec_cwtAvg:34' for ch = 1:nChs
  i1 = cpu_x->size[1];
  emxInit_real_T(&cpu_savgpTMP, 2, &w_emlrtRTEI, true);
  emxInit_real_T(&cpu_xv, 2, &d_emlrtRTEI, true);
  emxInit_creal_T(&cpu_xposdft, 2, &e_emlrtRTEI, true);
  emxInit_creal_T(&cpu_cfsposdft, 2, &x_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_x, 2, &g_emlrtRTEI, true);
  emxInit_creal_T(&cpu_cfs, 2, &j_emlrtRTEI, true);
  emxInit_real_T(&cpu_y, 2, &y_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_y, 2, &y_emlrtRTEI, true);
  emxInit_real_T(&cpu_abswt2S, 2, &n_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_y, 2, &o_emlrtRTEI, true);
  emxInit_real_T(&cpu_c, 1, &r_emlrtRTEI, true);
  emxInit_real_T(&cpu_xCh, 1, &s_emlrtRTEI, true);
  emxInit_real_T(&cpu_r, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_x, 1, &c_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_x, 1, &k_emlrtRTEI, true);
  for (int32_T ch{0}; ch < i1; ch++) {
    real_T alpha1;
    real_T cpsi;
    int32_T acoef;
    int32_T b_bcoef;
    int32_T i2;
    int32_T i5;
    int32_T j2;
    int32_T nd2;
    uint32_T xSize[2];
    uint32_T defaultSL_idx_1;
    boolean_T validLaunchParams;
    boolean_T xCh_outdatedOnCpu;
    // 'ec_cwtAvg:35' xCh = scaleSpectrum(fb,x(:,ch),SpectrumType="density")';
    defaultSL_idx_1 = static_cast<uint32_T>(fb.Scales->size[1]);
    nd2 = cpu_x->size[0];
    bcoef = c_cpu_x->size[0];
    c_cpu_x->size[0] = cpu_x->size[0];
    emxEnsureCapacity_real_T(c_cpu_x, bcoef, &c_emlrtRTEI);
    bcoef = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    cpu_xv->size[1] = cpu_x->size[0];
    emxEnsureCapacity_real_T(cpu_xv, bcoef, &d_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(nd2 - 1), &grid, &block,
                            2147483647U);
    if (x_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
    }
    x_needsGpuEnsureCapacity = false;
    gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv, true);
    r_outdatedOnCpu = false;
    gpuEmxEnsureCapacity_real_T(c_cpu_x, &b_gpu_x, true);
    if (x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
    }
    x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel1<<<grid, block>>>(ch, gpu_x, nd2 - 1, gpu_xv, b_gpu_x,
                                         cpu_x->size[0U]);
    }
    r_outdatedOnGpu = false;
    gpuEmxMemcpyGpuToCpu_real_T(c_cpu_x, &b_gpu_x);
    fb.sigvar = coder::vvarstd(c_cpu_x, cpu_x->size[0]);
    if (fb.SignalPad > 0.0) {
      cpsi = fb.SignalPad;
      if (cpsi < 1.0) {
        i2 = 0;
      } else {
        i2 = static_cast<int32_T>(cpsi);
      }
      cpsi = (static_cast<real_T>(cpu_x->size[0]) - fb.SignalPad) + 1.0;
      if (cpsi > cpu_x->size[0]) {
        j2 = 0;
        b_bcoef = 1;
        i5 = -1;
      } else {
        j2 = cpu_x->size[0] - 1;
        b_bcoef = -1;
        i5 = static_cast<int32_T>(cpsi) - 1;
      }
      bcoef = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = 1;
      b_cpu_x->size[1] = i2;
      emxEnsureCapacity_real_T(b_cpu_x, bcoef, &g_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(i2 - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_x, &c_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel2<<<grid, block>>>(ch, gpu_x, i2 - 1, c_gpu_x,
                                           cpu_x->size[0U]);
      }
      mwGetLaunchParameters1D(computeNumIters((i2 >> 1) - 1), &grid, &block,
                              2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel3<<<grid, block>>>(i2, (i2 >> 1) - 1, c_gpu_x);
      }
      bcoef = cpu_xv->size[0] * cpu_xv->size[1];
      cpu_xv->size[0] = 1;
      cpu_xv->size[1] =
          ((cpu_x->size[0] + b_cpu_x->size[1]) + div_s32(i5 - j2, b_bcoef)) + 1;
      emxEnsureCapacity_real_T(cpu_xv, bcoef, &i_emlrtRTEI);
      acoef = b_cpu_x->size[1];
      mwGetLaunchParameters1D(computeNumIters(acoef - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel4<<<grid, block>>>(c_gpu_x, acoef - 1, gpu_xv);
      }
      xv_outdatedOnCpu = true;
      acoef = cpu_x->size[0];
      for (bcoef = 0; bcoef < acoef; bcoef++) {
        if (xv_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xv, &gpu_xv);
        }
        cpu_xv->data[bcoef + b_cpu_x->size[1]] =
            cpu_x->data[bcoef + cpu_x->size[0] * ch];
        xv_outdatedOnCpu = false;
        r_outdatedOnGpu = true;
        x_needsGpuEnsureCapacity = true;
        r_outdatedOnCpu = true;
      }
      acoef = div_s32(i5 - j2, b_bcoef);
      for (bcoef = 0; bcoef <= acoef; bcoef++) {
        if (xv_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xv, &gpu_xv);
        }
        cpu_xv->data[(bcoef + cpu_x->size[0]) + b_cpu_x->size[1]] =
            cpu_x->data[(j2 + b_bcoef * bcoef) + cpu_x->size[0] * ch];
        xv_outdatedOnCpu = false;
        r_outdatedOnGpu = true;
        x_needsGpuEnsureCapacity = true;
        r_outdatedOnCpu = true;
      }
    }
    if (cpu_xv->size[1] == 0) {
      r_outdatedOnCpu = false;
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = 0;
    } else if (cpu_xv->size[1] -
                   (static_cast<int32_T>(
                        static_cast<uint32_T>(cpu_xv->size[1]) >> 1)
                    << 1) ==
               1) {
      cufftHandle fftPlanHandle;
      bcoef = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = cpu_xv->size[1];
      emxEnsureCapacity_creal_T(cpu_xposdft, bcoef, &e_emlrtRTEI);
      j2 = cpu_xv->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      if (r_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv, !r_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_creal_T(cpu_xposdft, &gpu_xposdft, true);
      if (r_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, cpu_xv);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel17<<<grid, block>>>(gpu_xv, j2, gpu_xposdft);
      }
      nd2 = cpu_xposdft->size[1];
      fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, 1, 1, CUFFT_Z2Z, 1);
      cufftExecZ2Z(fftPlanHandle, (cufftDoubleComplex *)&gpu_xposdft.data[0],
                   (cufftDoubleComplex *)&gpu_xposdft.data[0], CUFFT_FORWARD);
      r_outdatedOnCpu = true;
    } else {
      cufftHandle b_fftPlanHandle;
      nd2 = cpu_xv->size[1];
      for (j2 = 0; j2 < 2; j2++) {
        xSize[j2] = static_cast<uint32_T>(cpu_xv->size[j2]);
      }
      bcoef = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = static_cast<int32_T>(xSize[1]);
      emxEnsureCapacity_creal_T(cpu_xposdft, bcoef, &f_emlrtRTEI);
      b_fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, 1, 1, CUFFT_D2Z, 1);
      if (r_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv, !r_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_creal_T(cpu_xposdft, &gpu_xposdft, true);
      if (r_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, cpu_xv);
      }
      cufftExecD2Z(b_fftPlanHandle, (cufftDoubleReal *)&gpu_xv.data[0],
                   (cufftDoubleComplex *)&gpu_xposdft.data[0]);
      mwGetLaunchParameters1D(
          computeNumIters(
              static_cast<int32_T>(
                  static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) /
                  2.0) -
              2),
          &grid, &block, 2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel18<<<grid, block>>>(
            static_cast<int32_T>(
                static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) / 2.0) -
                2,
            gpu_xposdft, xSize[1]);
      }
      r_outdatedOnCpu = true;
    }
    bcoef = fb.PsiDFT->size[0];
    nd2 = fb.PsiDFT->size[1];
    i2 = cpu_xposdft->size[1];
    if (nd2 <= i2) {
      i2 = nd2;
    }
    if (fb.PsiDFT->size[1] == 1) {
      b_bcoef = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == 1) {
      b_bcoef = fb.PsiDFT->size[1];
    } else if (cpu_xposdft->size[1] == fb.PsiDFT->size[1]) {
      b_bcoef = cpu_xposdft->size[1];
    } else {
      b_bcoef = i2;
    }
    r_outdatedOnGpu = false;
    nd2 = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
    cpu_cfsposdft->size[0] = bcoef;
    cpu_cfsposdft->size[1] = b_bcoef;
    emxEnsureCapacity_creal_T(cpu_cfsposdft, nd2, &h_emlrtRTEI);
    if ((bcoef != 0) && (b_bcoef != 0)) {
      acoef = (cpu_xposdft->size[1] != 1);
      bcoef = (fb.PsiDFT->size[1] != 1);
      j2 = b_bcoef - 1;
      for (int32_T k{0}; k <= j2; k++) {
        nd2 = acoef * k;
        i2 = bcoef * k;
        b_bcoef = (fb.PsiDFT->size[0] != 1);
        i5 = cpu_cfsposdft->size[0] - 1;
        for (int32_T b_k{0}; b_k <= i5; b_k++) {
          if (r_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_creal_T(cpu_xposdft, &gpu_xposdft);
          }
          cpu_cfsposdft->data[b_k + cpu_cfsposdft->size[0] * k].re =
              fb.PsiDFT->data[b_bcoef * b_k + fb.PsiDFT->size[0] * i2] *
              cpu_xposdft->data[nd2].re;
          r_outdatedOnCpu = false;
          cpu_cfsposdft->data[b_k + cpu_cfsposdft->size[0] * k].im =
              fb.PsiDFT->data[b_bcoef * b_k + fb.PsiDFT->size[0] * i2] *
              cpu_xposdft->data[nd2].im;
          r_outdatedOnGpu = true;
        }
      }
    }
    if ((cpu_cfsposdft->size[0] == 0) || (cpu_cfsposdft->size[1] == 0)) {
      for (j2 = 0; j2 < 2; j2++) {
        xSize[j2] = static_cast<uint32_T>(cpu_cfsposdft->size[j2]);
      }
      xSize[1] = static_cast<uint32_T>(cpu_cfsposdft->size[1]);
      bcoef = cpu_cfs->size[0] * cpu_cfs->size[1];
      cpu_cfs->size[0] = static_cast<int32_T>(xSize[0]);
      cpu_cfs->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal_T(cpu_cfs, bcoef, &j_emlrtRTEI);
      j2 = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal_T(cpu_cfs, &gpu_cfs, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel5<<<grid, block>>>(j2, gpu_cfs);
      }
      r_outdatedOnCpu = true;
    } else {
      cufftHandle c_fftPlanHandle;
      nd2 = cpu_cfsposdft->size[1];
      c_fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, cpu_cfsposdft->size[0],
                                         1, CUFFT_Z2Z, cpu_cfsposdft->size[0]);
      gpuEmxEnsureCapacity_creal_T(cpu_cfsposdft, &gpu_cfsposdft,
                                   !r_outdatedOnGpu);
      if (r_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_cfsposdft, cpu_cfsposdft);
      }
      cufftExecZ2Z(c_fftPlanHandle,
                   (cufftDoubleComplex *)&gpu_cfsposdft.data[0],
                   (cufftDoubleComplex *)&gpu_cfsposdft.data[0], CUFFT_INVERSE);
      bcoef = cpu_cfs->size[0] * cpu_cfs->size[1];
      cpu_cfs->size[0] = cpu_cfsposdft->size[0];
      cpu_cfs->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal_T(cpu_cfs, bcoef, &j_emlrtRTEI);
      j2 = cpu_cfsposdft->size[1];
      i5 = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(i5), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal_T(cpu_cfs, &gpu_cfs, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel16<<<grid, block>>>(static_cast<real_T>(j2),
                                            gpu_cfsposdft, i5, gpu_cfs);
      }
      r_outdatedOnCpu = true;
    }
    if (fb.SignalPad > 0.0) {
      cpsi = fb.SignalPad + 1.0;
      alpha1 = fb.SignalPad + fb.SignalLength;
      if (cpsi > alpha1) {
        nd2 = 0;
        i2 = 0;
      } else {
        nd2 = static_cast<int32_T>(cpsi) - 1;
        i2 = static_cast<int32_T>(alpha1);
      }
      j2 = cpu_cfs->size[0];
      acoef = i2 - nd2;
      for (bcoef = 0; bcoef < acoef; bcoef++) {
        for (b_bcoef = 0; b_bcoef < j2; b_bcoef++) {
          if (r_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_creal_T(cpu_cfs, &gpu_cfs);
          }
          cpu_cfs->data[b_bcoef + j2 * bcoef] =
              cpu_cfs->data[b_bcoef + cpu_cfs->size[0] * (nd2 + bcoef)];
          r_outdatedOnCpu = false;
        }
      }
      bcoef = cpu_cfs->size[0] * cpu_cfs->size[1];
      cpu_cfs->size[1] = i2 - nd2;
      emxEnsureCapacity_creal_T(cpu_cfs, bcoef, &j_emlrtRTEI);
    }
    cpsi =
        coder::wavelet::internal::cwt::numCpsi(fb.Wavelet, fb.Gamma, fb.Beta);
    bcoef = d_cpu_x->size[0];
    d_cpu_x->size[0] = cpu_x->size[0];
    emxEnsureCapacity_real_T(d_cpu_x, bcoef, &k_emlrtRTEI);
    j2 = cpu_x->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    if (x_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, true);
    }
    x_needsGpuEnsureCapacity = false;
    gpuEmxEnsureCapacity_real_T(d_cpu_x, &d_gpu_x, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel6<<<grid, block>>>(ch, gpu_x, j2, d_gpu_x,
                                         cpu_x->size[0U]);
    }
    if (r_outdatedOnCpu) {
      gpuEmxMemcpyGpuToCpu_creal_T(cpu_cfs, &gpu_cfs);
    }
    gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &d_gpu_x);
    coder::wavelet::internal::cwt::scNormalize(
        cpu_cfs, cpsi, fb.Scales, coder::vvarstd(d_cpu_x, cpu_x->size[0]));
    nd2 = cpu_cfs->size[0] * cpu_cfs->size[1];
    for (j2 = 0; j2 < 2; j2++) {
      xSize[j2] = static_cast<uint32_T>(cpu_cfs->size[j2]);
    }
    bcoef = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(cpu_y, bcoef, &l_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(nd2 - 1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_creal_T(cpu_cfs, &gpu_cfs, false);
    gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_cfs, cpu_cfs);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel7<<<grid, block>>>(gpu_cfs, nd2 - 1, gpu_y);
    }
    for (j2 = 0; j2 < 2; j2++) {
      xSize[j2] = static_cast<uint32_T>(cpu_y->size[j2]);
    }
    bcoef = b_cpu_y->size[0] * b_cpu_y->size[1];
    b_cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    b_cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(b_cpu_y, bcoef, &m_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(xSize[0]) *
                                                static_cast<int32_T>(xSize[1]) -
                                            1),
                            &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel8<<<grid, block>>>(
          gpu_y,
          static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1,
          b_gpu_y);
    }
    r_outdatedOnCpu = true;
    bcoef = fb.Scales->size[1];
    if (b_cpu_y->size[0] == bcoef) {
      r_outdatedOnGpu = false;
      bcoef = cpu_abswt2S->size[0] * cpu_abswt2S->size[1];
      cpu_abswt2S->size[0] = b_cpu_y->size[0];
      cpu_abswt2S->size[1] = b_cpu_y->size[1];
      emxEnsureCapacity_real_T(cpu_abswt2S, bcoef, &n_emlrtRTEI);
      for (bcoef = 0; bcoef < b_cpu_y->size[1]; bcoef++) {
        for (b_bcoef = 0; b_bcoef < b_cpu_y->size[0]; b_bcoef++) {
          if (r_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_y, &b_gpu_y);
          }
          r_outdatedOnCpu = false;
          cpu_abswt2S->data[b_bcoef + cpu_abswt2S->size[0] * bcoef] =
              b_cpu_y->data[b_bcoef + b_cpu_y->size[0] * bcoef] /
              fb.Scales->data[b_bcoef];
          r_outdatedOnGpu = true;
        }
      }
    } else {
      gpuEmxMemcpyGpuToCpu_real_T(b_cpu_y, &b_gpu_y);
      binary_expand_op(cpu_abswt2S, b_cpu_y, &fb);
      r_outdatedOnGpu = true;
    }
    i2 = static_cast<int32_T>(defaultSL_idx_1);
    bcoef = c_cpu_y->size[0] * c_cpu_y->size[1];
    c_cpu_y->size[0] = static_cast<int32_T>(defaultSL_idx_1);
    c_cpu_y->size[1] = cpu_abswt2S->size[1];
    emxEnsureCapacity_real_T(c_cpu_y, bcoef, &o_emlrtRTEI);
    j2 = cpu_abswt2S->size[1] - 1;
    mwGetLaunchParameters1D(
        computeNumIters(j2, static_cast<int32_T>(defaultSL_idx_1) - 1), &grid,
        &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_abswt2S, &gpu_abswt2S, !r_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(c_cpu_y, &c_gpu_y, true);
    if (r_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_abswt2S, cpu_abswt2S);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel9<<<grid, block>>>(
          gpu_abswt2S, static_cast<int32_T>(defaultSL_idx_1) - 1, j2, c_gpu_y,
          c_cpu_y->size[0U], cpu_abswt2S->size[0U]);
    }
    if ((static_cast<int32_T>(defaultSL_idx_1) == 0) &&
        (cpu_abswt2S->size[1] == 0)) {
      if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
        cpsi = fb.Scales->data[0] * 0.0;
      } else {
        cpsi = 0.0;
      }
      bcoef = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
      cpu_savgpTMP->size[0] = 1;
      cpu_savgpTMP->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_savgpTMP, bcoef, &p_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_savgpTMP, &gpu_savgpTMP, true);
      ec_cwtAvg_kernel10<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(cpsi,
                                                                  gpu_savgpTMP);
    } else {
      bcoef = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
      cpu_savgpTMP->size[0] = 1;
      cpu_savgpTMP->size[1] = cpu_abswt2S->size[1];
      emxEnsureCapacity_real_T(cpu_savgpTMP, bcoef, &p_emlrtRTEI);
      j2 = cpu_abswt2S->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_savgpTMP, &gpu_savgpTMP, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel12<<<grid, block>>>(j2, gpu_savgpTMP);
      }
      if (static_cast<int32_T>(defaultSL_idx_1) <= 1) {
        if ((static_cast<int32_T>(defaultSL_idx_1) == 1) &&
            (std::isinf(fb.Scales->data[0]) ||
             std::isnan(fb.Scales->data[0]))) {
          bcoef = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
          cpu_savgpTMP->size[0] = 1;
          cpu_savgpTMP->size[1] = cpu_abswt2S->size[1];
          emxEnsureCapacity_real_T(cpu_savgpTMP, bcoef, &p_emlrtRTEI);
          j2 = cpu_abswt2S->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real_T(cpu_savgpTMP, &gpu_savgpTMP, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel13<<<grid, block>>>(j2, gpu_savgpTMP);
          }
        }
      } else {
        if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
          r_outdatedOnCpu = false;
          bcoef = cpu_c->size[0];
          cpu_c->size[0] = static_cast<int32_T>(defaultSL_idx_1);
          emxEnsureCapacity_real_T(cpu_c, bcoef, &r_emlrtRTEI);
          for (bcoef = 0; bcoef < i2; bcoef++) {
            cpu_c->data[bcoef] = fb.Scales->data[0];
            r_outdatedOnCpu = true;
          }
          cpsi = 0.5 * fb.Scales->data[0];
          gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c, !r_outdatedOnCpu);
          if (r_outdatedOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_c, cpu_c);
          }
          ec_cwtAvg_kernel14<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(cpsi,
                                                                      gpu_c);
          r_outdatedOnGpu = false;
          ec_cwtAvg_kernel15<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
              cpsi, static_cast<int32_T>(defaultSL_idx_1), gpu_c);
          r_outdatedOnCpu = false;
        } else {
          bcoef = cpu_c->size[0];
          cpu_c->size[0] = static_cast<int32_T>(defaultSL_idx_1);
          emxEnsureCapacity_real_T(cpu_c, bcoef, &q_emlrtRTEI);
          cpu_c->data[0] = 0.5 * (fb.Scales->data[1] - fb.Scales->data[0]);
          for (int32_T k{0}; k <= i2 - 3; k++) {
            cpu_c->data[k + 1] =
                0.5 * (fb.Scales->data[k + 2] - fb.Scales->data[k]);
          }
          cpu_c->data[static_cast<int32_T>(defaultSL_idx_1) - 1] =
              0.5 *
              (fb.Scales->data[static_cast<int32_T>(defaultSL_idx_1) - 1] -
               fb.Scales->data[static_cast<int32_T>(defaultSL_idx_1) - 2]);
          r_outdatedOnCpu = true;
          r_outdatedOnGpu = true;
        }
        if (cpu_abswt2S->size[1] >= 1) {
          cpsi = 0.0;
          alpha1 = 1.0;
          if (r_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c, !r_outdatedOnCpu);
          }
          if (r_outdatedOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_c, cpu_c);
          }
          cublasCheck(cublasDgemv(getCublasGlobalHandle(), CUBLAS_OP_T,
                                  static_cast<int32_T>(defaultSL_idx_1),
                                  cpu_abswt2S->size[1], (double *)&alpha1,
                                  (double *)&c_gpu_y.data[0],
                                  static_cast<int32_T>(defaultSL_idx_1),
                                  (double *)&gpu_c.data[0], 1, (double *)&cpsi,
                                  (double *)&gpu_savgpTMP.data[0], 1),
                      __FILE__, __LINE__);
        }
      }
    }
    bcoef = cpu_xCh->size[0];
    cpu_xCh->size[0] = cpu_savgpTMP->size[1];
    emxEnsureCapacity_real_T(cpu_xCh, bcoef, &s_emlrtRTEI);
    j2 = cpu_savgpTMP->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_xCh, &gpu_xCh, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel11<<<grid, block>>>(gpu_savgpTMP, j2, gpu_xCh);
    }
    xv_outdatedOnCpu = false;
    xCh_outdatedOnCpu = true;
    //  Downsample
    // 'ec_cwtAvg:38' if doDownsample
    if (doDownsample) {
      // 'ec_cwtAvg:39' y{ch} = resample(xCh,ds(1),ds(2));
      coder::resample(cpu_xCh, &gpu_xCh, &xv_outdatedOnCpu, ds[0], ds[1], cpu_r,
                      &r_outdatedOnCpu, &gpu_r, &r_outdatedOnGpu);
      bcoef = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[0] = cpu_r->size[0];
      emxEnsureCapacity_real_T(y->data[ch].f1, bcoef, &u_emlrtRTEI);
      bcoef = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[1] = 1;
      emxEnsureCapacity_real_T(y->data[ch].f1, bcoef, &u_emlrtRTEI);
      for (bcoef = 0; bcoef < cpu_r->size[0]; bcoef++) {
        if (r_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_r, &gpu_r);
        }
        r_outdatedOnCpu = false;
        y->data[ch].f1->data[bcoef] = cpu_r->data[bcoef];
      }
      //  Downsample
    } else {
      // 'ec_cwtAvg:40' else
      // 'ec_cwtAvg:41' y{ch} = xCh;
      bcoef = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[0] = cpu_xCh->size[0];
      emxEnsureCapacity_real_T(y->data[ch].f1, bcoef, &t_emlrtRTEI);
      bcoef = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[1] = 1;
      emxEnsureCapacity_real_T(y->data[ch].f1, bcoef, &t_emlrtRTEI);
      for (bcoef = 0; bcoef < cpu_xCh->size[0]; bcoef++) {
        if (xCh_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xCh, &gpu_xCh);
        }
        xCh_outdatedOnCpu = false;
        y->data[ch].f1->data[bcoef] = cpu_xCh->data[bcoef];
      }
    }
  }
  emxFree_real_T(&d_cpu_x);
  emxFree_real_T(&c_cpu_x);
  emxFree_real_T(&cpu_r);
  emxFree_real_T(&cpu_xCh);
  emxFree_real_T(&cpu_c);
  emxFree_real_T(&c_cpu_y);
  emxFree_real_T(&cpu_abswt2S);
  emxFree_real_T(&b_cpu_y);
  emxFree_real_T(&cpu_y);
  emxFree_creal_T(&cpu_cfs);
  emxFree_real_T(&b_cpu_x);
  emxFree_creal_T(&cpu_cfsposdft);
  emxFree_creal_T(&cpu_xposdft);
  emxFree_real_T(&cpu_xv);
  emxFree_real_T(&cpu_savgpTMP);
  emxFreeStruct_cwtfilterbank(&fb);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_savgpTMP);
  gpuEmxFree_real_T(&gpu_xv);
  gpuEmxFree_creal_T(&gpu_xposdft);
  gpuEmxFree_creal_T(&gpu_cfsposdft);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_creal_T(&gpu_cfs);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&gpu_abswt2S);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&gpu_c);
  gpuEmxFree_real_T(&gpu_xCh);
  gpuEmxFree_real_T(&gpu_r);
  gpuEmxFree_real_T(&b_gpu_x);
  gpuEmxFree_real_T(&d_gpu_x);
}

// End of code generation (ec_cwtAvg.cu)
