//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// filter.cu
//
// Code generation for function 'filter'
//

// Include files
#include "filter.h"
#include "ec_filtfilt_fp_data.h"
#include "ec_filtfilt_fp_emxutil.h"
#include "ec_filtfilt_fp_mexutil.h"
#include "ec_filtfilt_fp_types.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo l_emlrtRTEI{
    1,               // lineNo
    1,               // colNo
    "gpufilterImpl", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/"
    "gpufilterImpl.p" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "stencil_codegen", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "stencil_codegen.p" // pName
};

static emlrtRTEInfo n_emlrtRTEI{
    172,                                                          // lineNo
    20,                                                           // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    164,                                                               // lineNo
    9,                                                                 // colNo
    "filter",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/filter.m" // pName
};

// Function Declarations
static __global__ void filter_kernel20(const emxArray_real32_T a, real32_T *a1);

static __global__ void filter_kernel21(const real32_T *a1, const int32_T b,
                                       emxArray_real32_T b_b);

static __global__ void filter_kernel22(const real32_T *a1, const int32_T b,
                                       emxArray_real32_T a);

static __global__ void filter_kernel23(emxArray_real32_T a);

static __global__ void filter_kernel24(const int32_T k, const int32_T b,
                                       emxArray_real32_T b_b);

static __global__ void filter_kernel25(const int32_T b,
                                       emxArray_real32_T expanded);

static __global__ void filter_kernel26(const int32_T offsetH,
                                       const emxArray_int32_T y,
                                       const int32_T b_y, emxArray_int32_T iv);

static __global__ void filter_kernel27(const emxArray_real32_T x,
                                       const emxArray_int32_T iv,
                                       const int32_T b,
                                       emxArray_real32_T expanded);

static __global__ void
filter_kernel28(const emxArray_real32_T expanded, const emxArray_int32_T rows,
                const emxArray_real32_T b, const int32_T c,
                emxArray_real32_T convOut, int32_T b_dim0);

static __global__ void filter_kernel29(const emxArray_real32_T convOut,
                                       const int32_T na, const int32_T b,
                                       emxArray_real32_T zf);

static __global__ void filter_kernel30(const emxArray_real32_T convOut,
                                       const emxArray_real32_T a,
                                       const int32_T b, emxArray_real32_T zf,
                                       int32_T a_dim0, int32_T x_dim0);

static __global__ void filter_kernel31(const emxArray_real32_T convOut,
                                       const int32_T x, emxArray_real32_T y);

static __global__ void filter_kernel32(const emxArray_real32_T zi,
                                       const int32_T b,
                                       emxArray_real32_T convOut);

static __global__ void filter_kernel33(const emxArray_real32_T a, real32_T *a1);

static __global__ void filter_kernel34(const real32_T *a1, const int32_T b,
                                       emxArray_real32_T b_b);

static __global__ void filter_kernel35(const real32_T *a1, const int32_T b,
                                       emxArray_real32_T a);

static __global__ void filter_kernel36(emxArray_real32_T a);

static __global__ void filter_kernel37(const int32_T k, const int32_T b,
                                       emxArray_real32_T b_b);

static __global__ void filter_kernel38(const int32_T b,
                                       emxArray_real32_T expanded);

static __global__ void filter_kernel39(const int32_T offsetH,
                                       const emxArray_int32_T y,
                                       const int32_T b_y, emxArray_int32_T iv);

static __global__ void filter_kernel40(const emxArray_real32_T x,
                                       const emxArray_int32_T iv,
                                       const int32_T b,
                                       emxArray_real32_T expanded);

static __global__ void
filter_kernel41(const emxArray_real32_T expanded, const emxArray_int32_T rows,
                const emxArray_real32_T b, const int32_T c,
                emxArray_real32_T convOut, int32_T b_dim0);

static __global__ void filter_kernel42(const emxArray_real32_T convOut,
                                       const int32_T x, emxArray_real32_T y);

static __global__ void filter_kernel43(const emxArray_real32_T zi,
                                       const int32_T b,
                                       emxArray_real32_T convOut);

static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
                                         emxArray_int32_T *gpu,
                                         boolean_T needsCopy);

static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);

static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu,
                                         const emxArray_int32_T *cpu);

static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);

// Function Definitions
static __global__
    __launch_bounds__(32, 1) void filter_kernel20(const emxArray_real32_T a,
                                                  real32_T *a1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *a1 = a.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel21(
    const real32_T *a1, const int32_T b, emxArray_real32_T b_b)
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
    b_b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void filter_kernel22(const real32_T *a1,
                                                            const int32_T b,
                                                            emxArray_real32_T a)
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
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32,
                                    1) void filter_kernel23(emxArray_real32_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel24(
    const int32_T k, const int32_T b, emxArray_real32_T b_b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_k;
    b_k = static_cast<int32_T>(idx);
    b_b.data[b_k + k] = 0.0F;
  }
}

static __global__
    __launch_bounds__(1024, 1) void filter_kernel25(const int32_T b,
                                                    emxArray_real32_T expanded)
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
    expanded.data[k] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel26(
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
    int32_T k;
    k = static_cast<int32_T>(idx);
    j = y.data[k];
    if ((offsetH < 0) && (j < MIN_int32_T - offsetH)) {
      j = MIN_int32_T;
    } else if ((offsetH > 0) && (j > MAX_int32_T - offsetH)) {
      j = MAX_int32_T;
    } else {
      j += offsetH;
    }
    iv.data[k] = j - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel27(
    const emxArray_real32_T x, const emxArray_int32_T iv, const int32_T b,
    emxArray_real32_T expanded)
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
    expanded.data[iv.data[k]] = x.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel28(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_real32_T b, const int32_T c, emxArray_real32_T convOut,
    int32_T b_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    real32_T cv;
    k = static_cast<int32_T>(idx);
    cv = 0.0F;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T j;
      j = rows.data[m];
      if (j > 2147483646 - k) {
        j = MAX_int32_T;
      } else {
        j = (k + j) + 1;
      }
      cv += expanded.data[j - 1] * b.data[(b_dim0 - m) - 1];
    }
    convOut.data[k] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel29(
    const emxArray_real32_T convOut, const int32_T na, const int32_T b,
    emxArray_real32_T zf)
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
    zf.data[k] = convOut.data[na + k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel30(
    const emxArray_real32_T convOut, const emxArray_real32_T a, const int32_T b,
    emxArray_real32_T zf, int32_T a_dim0, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T k;
    i = static_cast<int32_T>(idx);
    k = static_cast<int32_T>(
        fmin(static_cast<real_T>(i) + 2.0, static_cast<real_T>(a_dim0)));
    for (int32_T j{0}; j <= k - 2; j++) {
      zf.data[i + 1] += convOut.data[(x_dim0 + i) - j] * a.data[j + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel31(
    const emxArray_real32_T convOut, const int32_T x, emxArray_real32_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = convOut.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel32(
    const emxArray_real32_T zi, const int32_T b, emxArray_real32_T convOut)
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
    convOut.data[i] += zi.data[i];
  }
}

static __global__
    __launch_bounds__(32, 1) void filter_kernel33(const emxArray_real32_T a,
                                                  real32_T *a1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *a1 = a.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel34(
    const real32_T *a1, const int32_T b, emxArray_real32_T b_b)
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
    b_b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void filter_kernel35(const real32_T *a1,
                                                            const int32_T b,
                                                            emxArray_real32_T a)
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
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32,
                                    1) void filter_kernel36(emxArray_real32_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel37(
    const int32_T k, const int32_T b, emxArray_real32_T b_b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_k;
    b_k = static_cast<int32_T>(idx);
    b_b.data[b_k + k] = 0.0F;
  }
}

static __global__
    __launch_bounds__(1024, 1) void filter_kernel38(const int32_T b,
                                                    emxArray_real32_T expanded)
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
    expanded.data[k] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel39(
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
    int32_T k;
    int32_T q1;
    k = static_cast<int32_T>(idx);
    q1 = y.data[k];
    if ((offsetH < 0) && (q1 < MIN_int32_T - offsetH)) {
      q1 = MIN_int32_T;
    } else if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv.data[k] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel40(
    const emxArray_real32_T x, const emxArray_int32_T iv, const int32_T b,
    emxArray_real32_T expanded)
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
    expanded.data[iv.data[k]] = x.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel41(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_real32_T b, const int32_T c, emxArray_real32_T convOut,
    int32_T b_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    real32_T cv;
    k = static_cast<int32_T>(idx);
    cv = 0.0F;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T q1;
      q1 = rows.data[m];
      if (q1 > 2147483646 - k) {
        q1 = MAX_int32_T;
      } else {
        q1 = (k + q1) + 1;
      }
      cv += expanded.data[q1 - 1] * b.data[(b_dim0 - m) - 1];
    }
    convOut.data[k] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel42(
    const emxArray_real32_T convOut, const int32_T x, emxArray_real32_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = convOut.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel43(
    const emxArray_real32_T zi, const int32_T b, emxArray_real32_T convOut)
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
    convOut.data[k] += zi.data[k];
  }
}

static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
                                         emxArray_int32_T *gpu,
                                         boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  int32_T *newData;
  nvtxRangePushA("#fcn#gpuEmxEnsureCapacity_int32_T#" MW_AT_LOCATION);
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxEnsureCapacity_int32_T_whileloop_0##" MW_AT_LINE);
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
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(int32_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(int32_T),
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

static void gpuEmxFree_int32_T(emxArray_int32_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxFree_int32_T#" MW_AT_LOCATION);
  if (gpu->data != (void *)4207599121UL) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
  nvtxRangePop();
}

static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu,
                                         const emxArray_int32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxMemcpyCpuToGpu_int32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
  checkCudaError(cudaMemcpy(gpu->data, cpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(int32_T),
                            cudaMemcpyHostToDevice),
                 __FILE__, __LINE__);
  nvtxRangePop();
}

static void gpuEmxReset_int32_T(emxArray_int32_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxReset_int32_T#" MW_AT_LOCATION);
  std::memset(gpu, 0, sizeof(emxArray_int32_T));
  nvtxRangePop();
}

//
//
namespace coder {
void b_filter(emxArray_real32_T *cpu_b, boolean_T *b_outdatedOnCpu,
              emxArray_real32_T *gpu_b, boolean_T *b_outdatedOnGpu,
              emxArray_real32_T *cpu_a, boolean_T *a_outdatedOnCpu,
              emxArray_real32_T *gpu_a, boolean_T *a_outdatedOnGpu,
              emxArray_real32_T *cpu_x, emxArray_real32_T *gpu_x,
              boolean_T *x_outdatedOnGpu, emxArray_real32_T *cpu_zi,
              boolean_T *zi_outdatedOnCpu, emxArray_real32_T *gpu_zi,
              boolean_T *zi_outdatedOnGpu, emxArray_real32_T *cpu_y,
              boolean_T *y_outdatedOnCpu, emxArray_real32_T *gpu_y,
              boolean_T *y_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_rows;
  emxArray_real32_T gpu_convOut;
  emxArray_real32_T gpu_expanded;
  emxArray_real32_T *cpu_convOut;
  emxArray_real32_T *cpu_expanded;
  int32_T k;
  int32_T na;
  int32_T nb;
  real32_T *gpu_a1;
  boolean_T b_needsGpuEnsureCapacity;
  boolean_T validLaunchParams;
  nvtxRangePushA("#fcn#b_filter#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_convOut);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_expanded);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_a1, 4UL), __FILE__, __LINE__);
  b_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  na = cpu_a->size[0];
  nb = cpu_b->size[0];
  nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real32_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
  if (*a_outdatedOnGpu) {
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real32_T(gpu_a, cpu_a);
  }
  nvtxMarkA("#filter_kernel33#" MW_AT_LINE);
  filter_kernel33<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a, gpu_a1);
  if (*a_outdatedOnCpu) {
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_a, gpu_a);
  }
  *a_outdatedOnCpu = false;
  if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
      (!(cpu_a->data[0] == 0.0F)) && (cpu_a->data[0] != 1.0F)) {
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    b_needsGpuEnsureCapacity = false;
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel34#" MW_AT_LINE);
      filter_kernel34<<<grid, block>>>(gpu_a1, nb - 1, *gpu_b);
    }
    *b_outdatedOnGpu = false;
    *b_outdatedOnCpu = true;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 2), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_a, gpu_a, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel35#" MW_AT_LINE);
      filter_kernel35<<<grid, block>>>(gpu_a1, na - 2, *gpu_a);
    }
    nvtxMarkA("#filter_kernel36#" MW_AT_LINE);
    filter_kernel36<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a);
    *a_outdatedOnCpu = true;
  }
  if (cpu_a->size[0] > cpu_b->size[0]) {
    nb = cpu_a->size[0] - cpu_b->size[0];
    k = cpu_b->size[0];
    na = cpu_b->size[0];
    cpu_b->size[0] += nb;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_b, na, &l_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    b_needsGpuEnsureCapacity = false;
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel37#" MW_AT_LINE);
      filter_kernel37<<<grid, block>>>(k, nb - 1, *gpu_b);
    }
    *b_outdatedOnGpu = false;
    *b_outdatedOnCpu = true;
  }
  if (cpu_x->size[0] == 0) {
    *y_outdatedOnCpu = false;
    cpu_y->size[0] = 0;
  } else {
    real_T blockDims_idx_0;
    int32_T KH;
    int32_T offsetH;
    uint32_T OH;
    uint32_T window_idx_0;
    int8_T threadDims_idx_0;
    boolean_T convOut_outdatedOnCpu;
    boolean_T convOut_outdatedOnGpu;
    window_idx_0 = static_cast<uint32_T>(cpu_b->size[0]);
    OH = (static_cast<uint32_T>(cpu_x->size[0]) +
          static_cast<uint32_T>(cpu_b->size[0])) -
         1U;
    na = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
    blockDims_idx_0 =
        std::floor((static_cast<real_T>(OH) + (static_cast<real_T>(na) - 1.0)) /
                   static_cast<real_T>(na));
    threadDims_idx_0 = static_cast<int8_T>(na);
    if (OH > 2147483647U) {
      OH = 2147483647U;
    }
    KH = cpu_b->size[0];
    offsetH = static_cast<int32_T>(
                  std::floor(static_cast<real_T>(cpu_b->size[0]) / 2.0)) +
              static_cast<int32_T>(std::floor(
                  (static_cast<real_T>(cpu_b->size[0]) - 1.0) / 2.0));
    nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
    emxInit_real32_T(&cpu_expanded, 1, &m_emlrtRTEI, true);
    if ((static_cast<int32_T>(OH) > 0) &&
        (cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(OH))) {
      na = MAX_int32_T;
    } else {
      na = static_cast<int32_T>(OH) + cpu_b->size[0];
    }
    k = cpu_expanded->size[0];
    cpu_expanded->size[0] = na - 1;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_expanded, k, &m_emlrtRTEI);
    na = (static_cast<int32_T>(OH) + static_cast<int32_T>(window_idx_0)) - 2;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_expanded, &gpu_expanded, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel38#" MW_AT_LINE);
      filter_kernel38<<<grid, block>>>(na, gpu_expanded);
    }
    nb = cpu_x->size[0];
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&b_cpu_y, 2, &m_emlrtRTEI, true);
    k = b_cpu_y->size[0] * b_cpu_y->size[1];
    b_cpu_y->size[0] = 1;
    b_cpu_y->size[1] = cpu_x->size[0];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(b_cpu_y, k, &n_emlrtRTEI);
    b_cpu_y->data[0] = 1;
    na = 1;
    profileLoopStart("b_filter_loop_0", __LINE__, (nb - 2) + 1, "");
    for (k = 0; k <= nb - 2; k++) {
      na++;
      b_cpu_y->data[k + 1] = na;
    }
    profileLoopEnd();
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&cpu_iv, 1, &m_emlrtRTEI, true);
    k = cpu_iv->size[0];
    cpu_iv->size[0] = b_cpu_y->size[1];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_iv, k, &m_emlrtRTEI);
    na = b_cpu_y->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(b_cpu_y, &b_gpu_y, false);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, b_cpu_y);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel39#" MW_AT_LINE);
      filter_kernel39<<<grid, block>>>(offsetH, b_gpu_y, na, gpu_iv);
    }
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&b_cpu_y);
    nb = cpu_iv->size[0];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    if (*x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_x, cpu_x);
    }
    *x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel40#" MW_AT_LINE);
      filter_kernel40<<<grid, block>>>(*gpu_x, gpu_iv, nb - 1, gpu_expanded);
    }
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&cpu_iv);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&cpu_rows, 2, &m_emlrtRTEI, true);
    k = cpu_rows->size[0] * cpu_rows->size[1];
    cpu_rows->size[0] = 1;
    cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_rows, k, &n_emlrtRTEI);
    cpu_rows->data[0] = 0;
    na = 0;
    profileLoopStart("b_filter_loop_1", __LINE__, (KH - 2) + 1, "");
    for (k = 0; k <= KH - 2; k++) {
      na++;
      cpu_rows->data[k + 1] = na;
    }
    profileLoopEnd();
    nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
    emxInit_real32_T(&cpu_convOut, 1, &l_emlrtRTEI, true);
    k = cpu_convOut->size[0];
    cpu_convOut->size[0] = static_cast<int32_T>(OH);
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_convOut, k, &m_emlrtRTEI);
    if (blockDims_idx_0 < 4.294967296E+9) {
      if (blockDims_idx_0 >= 0.0) {
        window_idx_0 = static_cast<uint32_T>(blockDims_idx_0);
      } else {
        window_idx_0 = 0U;
      }
    } else if (blockDims_idx_0 >= 4.294967296E+9) {
      window_idx_0 = MAX_uint32_T;
    } else {
      window_idx_0 = 0U;
    }
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwApplyLaunchParameters(
        computeNumIters(static_cast<int32_T>(OH) - 1),
        dim3(window_idx_0, 1U, 1U),
        dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid, &block);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows, false);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_convOut, &gpu_convOut, true);
    b_needsGpuEnsureCapacity = false;
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
    }
    *b_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel41#" MW_AT_LINE);
      filter_kernel41<<<grid, block>>>(gpu_expanded, gpu_rows, *gpu_b,
                                       static_cast<int32_T>(OH) - 1,
                                       gpu_convOut, cpu_b->size[0U]);
    }
    convOut_outdatedOnGpu = false;
    convOut_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&cpu_rows);
    nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
    emxFree_real32_T(&cpu_expanded);
    if (cpu_zi->size[0] != 0) {
      if (cpu_zi->size[0] == 1) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_convOut, &gpu_convOut);
        if (*zi_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_zi, gpu_zi);
        }
        *zi_outdatedOnCpu = false;
        cpu_convOut->data[0] += cpu_zi->data[0];
        convOut_outdatedOnCpu = false;
        convOut_outdatedOnGpu = true;
        b_needsGpuEnsureCapacity = true;
      } else {
        na = cpu_zi->size[0];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_zi, gpu_zi, !*zi_outdatedOnGpu);
        if (*zi_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real32_T(gpu_zi, cpu_zi);
        }
        *zi_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel43#" MW_AT_LINE);
          filter_kernel43<<<grid, block>>>(*gpu_zi, na - 1, gpu_convOut);
        }
      }
    }
    na = cpu_x->size[0] + cpu_a->size[0];
    profileLoopStart("b_filter_loop_2", __LINE__, (na - 2) + 1, "");
    for (k = 0; k <= na - 2; k++) {
      nb = static_cast<int32_T>(std::fmin(static_cast<real_T>(k) + 1.0,
                                          static_cast<real_T>(cpu_a->size[0])));
      profileLoopStart("b_filter_loop_3", __LINE__, (nb - 2) + 1, "");
      for (offsetH = 0; offsetH <= nb - 2; offsetH++) {
        if (convOut_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_convOut, &gpu_convOut);
        }
        if (*a_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_a, gpu_a);
        }
        *a_outdatedOnCpu = false;
        cpu_convOut->data[k] -=
            cpu_convOut->data[(k - offsetH) - 1] * cpu_a->data[offsetH + 1];
        convOut_outdatedOnCpu = false;
        convOut_outdatedOnGpu = true;
        b_needsGpuEnsureCapacity = true;
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    k = cpu_y->size[0];
    cpu_y->size[0] = cpu_x->size[0];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_y, k, &o_emlrtRTEI);
    na = cpu_x->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_convOut, &gpu_convOut,
                                    !convOut_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_y, gpu_y, true);
    if (convOut_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_convOut, cpu_convOut);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel42#" MW_AT_LINE);
      filter_kernel42<<<grid, block>>>(gpu_convOut, na, *gpu_y);
    }
    *y_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
    emxFree_real32_T(&cpu_convOut);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_a1), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_convOut);
  *a_outdatedOnGpu = false;
  *y_outdatedOnGpu = false;
  nvtxRangePop();
}

//
//
void filter(emxArray_real32_T *cpu_b, boolean_T *b_outdatedOnCpu,
            emxArray_real32_T *gpu_b, boolean_T *b_outdatedOnGpu,
            emxArray_real32_T *cpu_a, boolean_T *a_outdatedOnCpu,
            emxArray_real32_T *gpu_a, boolean_T *a_outdatedOnGpu,
            emxArray_real32_T *cpu_x, emxArray_real32_T *gpu_x,
            boolean_T *x_outdatedOnGpu, emxArray_real32_T *cpu_zi,
            boolean_T *zi_outdatedOnCpu, emxArray_real32_T *gpu_zi,
            boolean_T *zi_outdatedOnGpu, emxArray_real32_T *cpu_y,
            boolean_T *y_outdatedOnCpu, emxArray_real32_T *gpu_y,
            boolean_T *y_outdatedOnGpu, emxArray_real32_T *cpu_zf,
            boolean_T *zf_outdatedOnCpu, emxArray_real32_T *gpu_zf,
            boolean_T *zf_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_rows;
  emxArray_real32_T gpu_convOut;
  emxArray_real32_T gpu_expanded;
  emxArray_real32_T *cpu_convOut;
  emxArray_real32_T *cpu_expanded;
  int32_T k;
  int32_T na;
  int32_T nb;
  int32_T zfSize_idx_0;
  real32_T *gpu_a1;
  boolean_T a_needsGpuEnsureCapacity;
  boolean_T b_needsGpuEnsureCapacity;
  boolean_T validLaunchParams;
  nvtxRangePushA("#fcn#filter#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_convOut);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_expanded);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_a1, 4UL), __FILE__, __LINE__);
  b_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  na = cpu_a->size[0];
  nb = cpu_b->size[0];
  nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real32_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
  if (*a_outdatedOnGpu) {
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real32_T(gpu_a, cpu_a);
  }
  nvtxMarkA("#filter_kernel20#" MW_AT_LINE);
  filter_kernel20<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a, gpu_a1);
  if (*a_outdatedOnCpu) {
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_a, gpu_a);
  }
  *a_outdatedOnCpu = false;
  if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0]))) {
    if (!(cpu_a->data[0] == 0.0F)) {
      if (cpu_a->data[0] != 1.0F) {
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
        b_needsGpuEnsureCapacity = false;
        if (*b_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel21#" MW_AT_LINE);
          filter_kernel21<<<grid, block>>>(gpu_a1, nb - 1, *gpu_b);
        }
        *b_outdatedOnGpu = false;
        *b_outdatedOnCpu = true;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(na - 2), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_a, gpu_a, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel22#" MW_AT_LINE);
          filter_kernel22<<<grid, block>>>(gpu_a1, na - 2, *gpu_a);
        }
        a_needsGpuEnsureCapacity = false;
        nvtxMarkA("#filter_kernel23#" MW_AT_LINE);
        filter_kernel23<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a);
        *a_outdatedOnCpu = true;
      } else {
        a_needsGpuEnsureCapacity = true;
      }
    } else {
      a_needsGpuEnsureCapacity = true;
    }
  } else {
    a_needsGpuEnsureCapacity = true;
  }
  if (cpu_a->size[0] > cpu_b->size[0]) {
    nb = cpu_a->size[0] - cpu_b->size[0];
    k = cpu_b->size[0];
    na = cpu_b->size[0];
    cpu_b->size[0] += nb;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_b, na, &l_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    b_needsGpuEnsureCapacity = false;
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel24#" MW_AT_LINE);
      filter_kernel24<<<grid, block>>>(k, nb - 1, *gpu_b);
    }
    *b_outdatedOnGpu = false;
    *b_outdatedOnCpu = true;
  }
  zfSize_idx_0 = cpu_b->size[0] - 1;
  if (cpu_x->size[0] == 0) {
    *y_outdatedOnCpu = false;
    cpu_y->size[0] = 0;
    *zf_outdatedOnCpu = false;
    k = cpu_zf->size[0];
    cpu_zf->size[0] = cpu_b->size[0] - 1;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_zf, k, &l_emlrtRTEI);
  } else {
    real_T blockDims_idx_0;
    int32_T KH;
    int32_T offsetH;
    uint32_T OH;
    uint32_T window_idx_0;
    int8_T threadDims_idx_0;
    boolean_T convOut_outdatedOnCpu;
    boolean_T convOut_outdatedOnGpu;
    window_idx_0 = static_cast<uint32_T>(cpu_b->size[0]);
    OH = (static_cast<uint32_T>(cpu_x->size[0]) +
          static_cast<uint32_T>(cpu_b->size[0])) -
         1U;
    na = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
    blockDims_idx_0 =
        std::floor((static_cast<real_T>(OH) + (static_cast<real_T>(na) - 1.0)) /
                   static_cast<real_T>(na));
    threadDims_idx_0 = static_cast<int8_T>(na);
    if (OH > 2147483647U) {
      OH = 2147483647U;
    }
    KH = cpu_b->size[0];
    offsetH = static_cast<int32_T>(
                  std::floor(static_cast<real_T>(cpu_b->size[0]) / 2.0)) +
              static_cast<int32_T>(std::floor(
                  (static_cast<real_T>(cpu_b->size[0]) - 1.0) / 2.0));
    nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
    emxInit_real32_T(&cpu_expanded, 1, &m_emlrtRTEI, true);
    if ((static_cast<int32_T>(OH) > 0) &&
        (cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(OH))) {
      na = MAX_int32_T;
    } else {
      na = static_cast<int32_T>(OH) + cpu_b->size[0];
    }
    k = cpu_expanded->size[0];
    cpu_expanded->size[0] = na - 1;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_expanded, k, &m_emlrtRTEI);
    nb = (static_cast<int32_T>(OH) + static_cast<int32_T>(window_idx_0)) - 2;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_expanded, &gpu_expanded, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel25#" MW_AT_LINE);
      filter_kernel25<<<grid, block>>>(nb, gpu_expanded);
    }
    nb = cpu_x->size[0];
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&b_cpu_y, 2, &m_emlrtRTEI, true);
    k = b_cpu_y->size[0] * b_cpu_y->size[1];
    b_cpu_y->size[0] = 1;
    b_cpu_y->size[1] = cpu_x->size[0];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(b_cpu_y, k, &n_emlrtRTEI);
    b_cpu_y->data[0] = 1;
    na = 1;
    profileLoopStart("filter_loop_0", __LINE__, (nb - 2) + 1, "");
    for (k = 0; k <= nb - 2; k++) {
      na++;
      b_cpu_y->data[k + 1] = na;
    }
    profileLoopEnd();
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&cpu_iv, 1, &m_emlrtRTEI, true);
    k = cpu_iv->size[0];
    cpu_iv->size[0] = b_cpu_y->size[1];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_iv, k, &m_emlrtRTEI);
    nb = b_cpu_y->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(b_cpu_y, &b_gpu_y, false);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, b_cpu_y);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel26#" MW_AT_LINE);
      filter_kernel26<<<grid, block>>>(offsetH, b_gpu_y, nb, gpu_iv);
    }
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&b_cpu_y);
    nb = cpu_iv->size[0];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    if (*x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel27#" MW_AT_LINE);
      filter_kernel27<<<grid, block>>>(*gpu_x, gpu_iv, nb - 1, gpu_expanded);
    }
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&cpu_iv);
    nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
    emxInit_int32_T(&cpu_rows, 2, &m_emlrtRTEI, true);
    k = cpu_rows->size[0] * cpu_rows->size[1];
    cpu_rows->size[0] = 1;
    cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_rows, k, &n_emlrtRTEI);
    cpu_rows->data[0] = 0;
    na = 0;
    profileLoopStart("filter_loop_1", __LINE__, (KH - 2) + 1, "");
    for (k = 0; k <= KH - 2; k++) {
      na++;
      cpu_rows->data[k + 1] = na;
    }
    profileLoopEnd();
    nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
    emxInit_real32_T(&cpu_convOut, 1, &l_emlrtRTEI, true);
    k = cpu_convOut->size[0];
    cpu_convOut->size[0] = static_cast<int32_T>(OH);
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_convOut, k, &m_emlrtRTEI);
    if (blockDims_idx_0 < 4.294967296E+9) {
      if (blockDims_idx_0 >= 0.0) {
        window_idx_0 = static_cast<uint32_T>(blockDims_idx_0);
      } else {
        window_idx_0 = 0U;
      }
    } else if (blockDims_idx_0 >= 4.294967296E+9) {
      window_idx_0 = MAX_uint32_T;
    } else {
      window_idx_0 = 0U;
    }
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwApplyLaunchParameters(
        computeNumIters(static_cast<int32_T>(OH) - 1),
        dim3(window_idx_0, 1U, 1U),
        dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid, &block);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows, false);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_convOut, &gpu_convOut, true);
    b_needsGpuEnsureCapacity = false;
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
    }
    *b_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel28#" MW_AT_LINE);
      filter_kernel28<<<grid, block>>>(gpu_expanded, gpu_rows, *gpu_b,
                                       static_cast<int32_T>(OH) - 1,
                                       gpu_convOut, cpu_b->size[0U]);
    }
    convOut_outdatedOnGpu = false;
    convOut_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
    emxFree_int32_T(&cpu_rows);
    nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
    emxFree_real32_T(&cpu_expanded);
    if (cpu_zi->size[0] != 0) {
      if (cpu_zi->size[0] == 1) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_convOut, &gpu_convOut);
        if (*zi_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_zi, gpu_zi);
        }
        *zi_outdatedOnCpu = false;
        cpu_convOut->data[0] += cpu_zi->data[0];
        convOut_outdatedOnCpu = false;
        convOut_outdatedOnGpu = true;
        b_needsGpuEnsureCapacity = true;
      } else {
        na = cpu_zi->size[0];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_zi, gpu_zi, !*zi_outdatedOnGpu);
        if (*zi_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real32_T(gpu_zi, cpu_zi);
        }
        *zi_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel32#" MW_AT_LINE);
          filter_kernel32<<<grid, block>>>(*gpu_zi, na - 1, gpu_convOut);
        }
      }
    }
    na = cpu_x->size[0] + cpu_a->size[0];
    profileLoopStart("filter_loop_2", __LINE__, (na - 2) + 1, "");
    for (k = 0; k <= na - 2; k++) {
      nb = static_cast<int32_T>(std::fmin(static_cast<real_T>(k) + 1.0,
                                          static_cast<real_T>(cpu_a->size[0])));
      profileLoopStart("filter_loop_3", __LINE__, (nb - 2) + 1, "");
      for (offsetH = 0; offsetH <= nb - 2; offsetH++) {
        if (convOut_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_convOut, &gpu_convOut);
        }
        if (*a_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_a, gpu_a);
        }
        *a_outdatedOnCpu = false;
        cpu_convOut->data[k] -=
            cpu_convOut->data[(k - offsetH) - 1] * cpu_a->data[offsetH + 1];
        convOut_outdatedOnCpu = false;
        convOut_outdatedOnGpu = true;
        a_needsGpuEnsureCapacity = true;
        b_needsGpuEnsureCapacity = true;
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    if (static_cast<uint32_T>(cpu_x->size[0]) + 1U >
        static_cast<uint32_T>(cpu_convOut->size[0])) {
      na = 0;
      nb = 0;
    } else {
      na = cpu_x->size[0];
      nb = cpu_convOut->size[0];
    }
    k = cpu_zf->size[0];
    cpu_zf->size[0] = nb - na;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_zf, k, &l_emlrtRTEI);
    nb = (nb - na) - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb), &grid, &block, 2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_convOut, &gpu_convOut,
                                    !convOut_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_zf, gpu_zf, true);
    if (convOut_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_convOut, cpu_convOut);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel29#" MW_AT_LINE);
      filter_kernel29<<<grid, block>>>(gpu_convOut, na, nb, *gpu_zf);
    }
    na = cpu_a->size[0];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 3), &grid, &block,
                            2147483647U);
    if (a_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_a, gpu_a, true);
    }
    *x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel30#" MW_AT_LINE);
      filter_kernel30<<<grid, block>>>(gpu_convOut, *gpu_a, na - 3, *gpu_zf,
                                       cpu_a->size[0U], cpu_x->size[0U]);
    }
    *zf_outdatedOnCpu = true;
    k = cpu_zf->size[0];
    cpu_zf->size[0] = zfSize_idx_0;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_zf, k, &l_emlrtRTEI);
    k = cpu_y->size[0];
    cpu_y->size[0] = cpu_x->size[0];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_y, k, &l_emlrtRTEI);
    nb = cpu_x->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_y, gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel31#" MW_AT_LINE);
      filter_kernel31<<<grid, block>>>(gpu_convOut, nb, *gpu_y);
    }
    *y_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
    emxFree_real32_T(&cpu_convOut);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_a1), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_convOut);
  *a_outdatedOnGpu = false;
  *y_outdatedOnGpu = false;
  *zf_outdatedOnGpu = false;
  nvtxRangePop();
}

} // namespace coder

// End of code generation (filter.cu)
