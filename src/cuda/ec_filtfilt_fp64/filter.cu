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
#include "filtfilt_data.h"
#include "filtfilt_emxutil.h"
#include "filtfilt_mexutil.h"
#include "filtfilt_types.h"
#include "gpufilterImpl.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <algorithm>
#include <cmath>

// Variable Definitions
static emlrtRTEInfo td_emlrtRTEI{
    172,                                                               // lineNo
    13,                                                                // colNo
    "filter",                                                          // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/datafun/filter.m" // pName
};

static emlrtRTEInfo ud_emlrtRTEI{
    1,               // lineNo
    1,               // colNo
    "forGpuCodegen", // fName
    "/usr/local/MATLAB/R2024b/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "+stencil/forGpuCodegen.p" // pName
};

static emlrtRTEInfo vd_emlrtRTEI{
    172,                                                               // lineNo
    9,                                                                 // colNo
    "filter",                                                          // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/datafun/filter.m" // pName
};

static emlrtRTEInfo wd_emlrtRTEI{
    170,                                                               // lineNo
    9,                                                                 // colNo
    "filter",                                                          // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/datafun/filter.m" // pName
};

// Function Declarations
static uint64_T computeNumIters(int32_T ub, int32_T b_ub);

static uint64_T computeNumIters(int32_T ub);

static void cpuEmxAllocateOrResize_real_T(emxArray_real_T *cpu,
                                          boolean_T needsCopy);

static
#ifdef __CUDACC__
    __device__
#endif
        int32_T
        div_s32_device(int32_T numerator, int32_T denominator);

static __global__ void filter_kernel1(const emxArray_real_T a, real_T *a1);

static __global__ void filter_kernel10(const emxArray_real_T b,
                                       const int32_T b_b,
                                       emxArray_real_T kernel1D);

static __global__ void filter_kernel11(const emxArray_real_T a, real_T *a1);

static __global__ void filter_kernel12(const real_T *a1, const int32_T b,
                                       emxArray_real_T b_b);

static __global__ void filter_kernel13(const real_T *a1, const int32_T b,
                                       emxArray_real_T a);

static __global__ void filter_kernel14(emxArray_real_T a);

static __global__ void filter_kernel15(const emxArray_real_T b, const int32_T c,
                                       emxArray_real_T kernel1D);

static __global__ void
filter_kernel16(const int32_T b, emxArray_real_T kernel1D, int32_T b_dim1);

static __global__ void filter_kernel17(const emxArray_real_T x,
                                       const int32_T b_x,
                                       emxArray_real_T input);

static __global__ void filter_kernel18(const emxArray_real_T convOut,
                                       const int32_T nb, const int32_T b,
                                       emxArray_real_T zf);

static __global__ void filter_kernel19(const emxArray_real_T convOut,
                                       const emxArray_real_T a, const int32_T b,
                                       emxArray_real_T zf, int32_T a_dim1,
                                       int32_T x_dim0);

static __global__ void filter_kernel2(const real_T *a1, const int32_T b,
                                      emxArray_real_T b_b);

static __global__ void filter_kernel20(const emxArray_real_T convOut,
                                       const int32_T b, emxArray_real_T y);

static __global__ void filter_kernel21(const emxArray_real_T zi,
                                       const int32_T b,
                                       emxArray_real_T convOut);

static __global__ void filter_kernel22(const emxArray_real_T b,
                                       const int32_T b_b,
                                       emxArray_real_T kernel1D);

static __global__ void filter_kernel23(const emxArray_real_T a, real_T *a1);

static __global__ void filter_kernel24(const real_T *a1, const int32_T b,
                                       emxArray_real_T b_b);

static __global__ void filter_kernel25(const real_T *a1, const int32_T b,
                                       emxArray_real_T a);

static __global__ void filter_kernel26(emxArray_real_T a);

static __global__ void filter_kernel27(const emxArray_real_T b, const int32_T c,
                                       emxArray_real_T kernel1D);

static __global__ void
filter_kernel28(const int32_T b, emxArray_real_T kernel1D, int32_T b_dim1);

static __global__ void filter_kernel29(const emxArray_real_T x,
                                       const int32_T b_x, const int32_T c_x,
                                       emxArray_real_T input,
                                       int32_T input_dim0, int32_T x_dim0);

static __global__ void filter_kernel3(const real_T *a1, const int32_T b,
                                      emxArray_real_T a);

static __global__ void filter_kernel30(const emxArray_real_T zi,
                                       const int32_T b_zi, const int32_T b,
                                       emxArray_real_T convOut,
                                       int32_T convOut_dim0, int32_T zi_dim0);

static __global__ void filter_kernel31(const emxArray_real_T a, const int32_T b,
                                       emxArray_real_T convOut, int32_T x_dim0,
                                       int32_T a_dim1, int32_T convOut_dim0);

static __global__ void
filter_kernel32(const emxArray_real_T convOut, const int32_T nb,
                const int32_T b, const int32_T b_convOut, emxArray_real_T zfIIR,
                int32_T zfIIR_dim0, int32_T convOut_dim0);

static __global__ void filter_kernel33(const emxArray_real_T convOut,
                                       const emxArray_real_T a,
                                       const int32_T b_a, const int32_T b,
                                       emxArray_real_T zfIIR, int32_T a_dim1,
                                       int32_T zfIIR_dim0, int32_T x_dim0,
                                       int32_T convOut_dim0);

static __global__ void filter_kernel34(const emxArray_real_T zfIIR,
                                       const int32_T zfSize_idx_0,
                                       emxArray_real_T zf);

static __global__ void filter_kernel35(const emxArray_real_T convOut,
                                       const int32_T x, const int32_T b_convOut,
                                       emxArray_real_T c_convOut,
                                       int32_T convOut_dim0,
                                       int32_T b_convOut_dim0);

static __global__ void filter_kernel36(const emxArray_real_T convOut,
                                       const int32_T zi, emxArray_real_T y);

static __global__ void filter_kernel37(const emxArray_real_T zi,
                                       const int32_T b_zi, const int32_T b,
                                       emxArray_real_T convOut,
                                       int32_T convOut_dim0);

static __global__ void
filter_kernel38(const emxArray_real_T zi, const emxArray_real_T convOut,
                const int32_T b_zi, const int32_T b_convOut,
                emxArray_real_T c_convOut, int32_T convOut_dim0,
                int32_T b_convOut_dim0, int32_T zi_dim0);

static __global__ void filter_kernel39(const emxArray_real_T convOut,
                                       const int32_T zi_dim0, const int32_T zi,
                                       const int32_T b_zi,
                                       emxArray_real_T b_convOut,
                                       int32_T convOut_dim0);

static __global__ void filter_kernel4(emxArray_real_T a);

static __global__ void filter_kernel40(const emxArray_real_T b,
                                       const int32_T b_b,
                                       emxArray_real_T kernel1D);

static __global__ void filter_kernel41(const emxArray_real_T a, real_T *a1);

static __global__ void filter_kernel42(const real_T *a1, const int32_T b,
                                       emxArray_real_T b_b);

static __global__ void filter_kernel43(const real_T *a1, const int32_T b,
                                       emxArray_real_T a);

static __global__ void filter_kernel44(emxArray_real_T a);

static __global__ void filter_kernel45(const emxArray_real_T b, const int32_T c,
                                       emxArray_real_T kernel1D);

static __global__ void
filter_kernel46(const int32_T b, emxArray_real_T kernel1D, int32_T b_dim1);

static __global__ void filter_kernel47(const emxArray_real_T x,
                                       const int32_T b_x, const int32_T c_x,
                                       emxArray_real_T input,
                                       int32_T input_dim0, int32_T x_dim0);

static __global__ void filter_kernel48(const emxArray_real_T zi,
                                       const int32_T b_zi, const int32_T b,
                                       emxArray_real_T convOut,
                                       int32_T convOut_dim0, int32_T zi_dim0);

static __global__ void filter_kernel49(const emxArray_real_T a, const int32_T b,
                                       emxArray_real_T convOut, int32_T x_dim0,
                                       int32_T a_dim1, int32_T convOut_dim0);

static __global__ void filter_kernel5(const emxArray_real_T b, const int32_T c,
                                      emxArray_real_T kernel1D);

static __global__ void filter_kernel50(const emxArray_real_T convOut,
                                       const int32_T x, const int32_T b_convOut,
                                       emxArray_real_T c_convOut,
                                       int32_T convOut_dim0,
                                       int32_T b_convOut_dim0);

static __global__ void filter_kernel51(const emxArray_real_T convOut,
                                       const int32_T zi, emxArray_real_T y);

static __global__ void filter_kernel52(const emxArray_real_T zi,
                                       const int32_T b_zi, const int32_T b,
                                       emxArray_real_T convOut,
                                       int32_T convOut_dim0);

static __global__ void
filter_kernel53(const emxArray_real_T zi, const emxArray_real_T convOut,
                const int32_T b_zi, const int32_T b_convOut,
                emxArray_real_T c_convOut, int32_T convOut_dim0,
                int32_T b_convOut_dim0, int32_T zi_dim0);

static __global__ void filter_kernel54(const emxArray_real_T convOut,
                                       const int32_T zi_dim0, const int32_T zi,
                                       const int32_T b_zi,
                                       emxArray_real_T b_convOut,
                                       int32_T convOut_dim0);

static __global__ void filter_kernel55(const emxArray_real_T b,
                                       const int32_T b_b,
                                       emxArray_real_T kernel1D);

static __global__ void filter_kernel6(const int32_T b, emxArray_real_T kernel1D,
                                      int32_T b_dim1);

static __global__ void filter_kernel7(const emxArray_real_T x,
                                      const int32_T b_x, emxArray_real_T input);

static __global__ void filter_kernel8(const emxArray_real_T convOut,
                                      const int32_T b, emxArray_real_T y);

static __global__ void filter_kernel9(const emxArray_real_T zi, const int32_T b,
                                      emxArray_real_T convOut);

static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
                                        emxArray_real_T *gpu,
                                        boolean_T needsCopy);

static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu,
                                        const emxArray_real_T *cpu);

static void gpuThrowError(const char_T *file, int32_T b_line);

static
#ifdef __CUDACC__
    __device__
#endif
        real_T
        paddedArrayElem_device(const emxArray_real_T *array, int32_T idx,
                               int32_T b_idx, real_T paddingValue,
                               int32_T array_dim0);

static
#ifdef __CUDACC__
    __device__
#endif
        real_T
        paddedArrayElem_device(const emxArray_real_T *array, int32_T idx,
                               real_T paddingValue, int32_T array_dim0);

static __global__ void stencilfunKernel(
    const emxArray_real_T input, int32_T negPad, real_T paddingValue,
    const emxArray_real_T stencilCapture_workspace_t1, emxArray_real_T output,
    int32_T output_dim0, int32_T output_dim1,
    int32_T c_stencilCapture_workspace_t1_d, int32_T input_dim0);

static __global__ void
stencilfunKernel(const emxArray_real_T input, int32_T negPad,
                 real_T paddingValue,
                 const emxArray_real_T stencilCapture_workspace_t1,
                 emxArray_real_T output, int32_T output_dim0,
                 int32_T c_stencilCapture_workspace_t1_d, int32_T input_dim0);

// Function Definitions
static uint64_T computeNumIters(int32_T ub, int32_T b_ub)
{
  uint64_T n;
  uint64_T numIters;
  boolean_T overflow;
  nvtxRangePushA("#fcn#computeNumIters#" MW_AT_LOCATION);
  overflow = false;
  n = 0UL;
  if (ub >= 0) {
    n = static_cast<uint64_T>(ub + 1);
  }
  numIters = n;
  n = 0UL;
  if (b_ub >= 0) {
    n = static_cast<uint64_T>(b_ub + 1);
    overflow = (numIters > MAX_uint64_T / static_cast<uint64_T>(b_ub + 1));
  }
  numIters *= n;
  if (overflow) {
    nvtxMarkA("#gpuThrowError#" MW_AT_LINE);
    gpuThrowError(__FILE__, __LINE__);
  }
  nvtxRangePop();
  return numIters;
}

static uint64_T computeNumIters(int32_T ub)
{
  uint64_T numIters;
  nvtxRangePushA("#fcn#computeNumIters#" MW_AT_LOCATION);
  numIters = 0UL;
  if (ub >= 0) {
    numIters = static_cast<uint64_T>(ub + 1);
  }
  nvtxRangePop();
  return numIters;
}

static void cpuEmxAllocateOrResize_real_T(emxArray_real_T *cpu,
                                          boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  void *newData;
  nvtxRangePushA("#fcn#cpuEmxAllocateOrResize_real_T#" MW_AT_LOCATION);
  totalSizeCpu = 1;
  i = 0;
  nvtxRangePushA(
      "#loop#cpuEmxAllocateOrResize_real_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    totalSizeCpu *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (cpu->allocatedSize < totalSizeCpu) {
    newData =
        emlrtCallocMex(static_cast<uint32_T>(totalSizeCpu), sizeof(real_T));
    needsCopy = (needsCopy && (totalSizeCpu > 0));
    if (needsCopy) {
      std::copy(cpu->data, cpu->data + static_cast<uint32_T>(totalSizeCpu),
                static_cast<real_T *>(newData));
    }
    if (cpu->canFreeData) {
      emlrtFreeMex(cpu->data);
    }
    cpu->data = static_cast<real_T *>(newData);
    cpu->allocatedSize = totalSizeCpu;
    cpu->canFreeData = true;
  }
  nvtxRangePop();
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

static __global__
    __launch_bounds__(32, 1) void filter_kernel1(const emxArray_real_T a,
                                                 real_T *a1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *a1 = a.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel10(
    const emxArray_real_T b, const int32_T b_b, emxArray_real_T kernel1D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    kernel1D.data[k] = b.data[k];
  }
}

static __global__
    __launch_bounds__(32, 1) void filter_kernel11(const emxArray_real_T a,
                                                  real_T *a1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *a1 = a.data[0];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void filter_kernel12(const real_T *a1,
                                                            const int32_T b,
                                                            emxArray_real_T b_b)
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
                                    1) void filter_kernel13(const real_T *a1,
                                                            const int32_T b,
                                                            emxArray_real_T a)
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
                                    1) void filter_kernel14(emxArray_real_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel15(
    const emxArray_real_T b, const int32_T c, emxArray_real_T kernel1D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    kernel1D.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel16(
    const int32_T b, emxArray_real_T kernel1D, int32_T b_dim1)
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
    kernel1D.data[k + b_dim1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel17(
    const emxArray_real_T x, const int32_T b_x, emxArray_real_T input)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    input.data[k] = x.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel18(
    const emxArray_real_T convOut, const int32_T nb, const int32_T b,
    emxArray_real_T zf)
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
    zf.data[k] = convOut.data[nb + k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel19(
    const emxArray_real_T convOut, const emxArray_real_T a, const int32_T b,
    emxArray_real_T zf, int32_T a_dim1, int32_T x_dim0)
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
        fmin(static_cast<real_T>(i) + 2.0, static_cast<real_T>(a_dim1)));
    for (int32_T j{0}; j <= k - 2; j++) {
      zf.data[i + 1] += convOut.data[(x_dim0 + i) - j] * a.data[j + 1];
    }
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void filter_kernel2(const real_T *a1,
                                                           const int32_T b,
                                                           emxArray_real_T b_b)
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

static __global__ __launch_bounds__(1024, 1) void filter_kernel20(
    const emxArray_real_T convOut, const int32_T b, emxArray_real_T y)
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
    y.data[k] = convOut.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel21(
    const emxArray_real_T zi, const int32_T b, emxArray_real_T convOut)
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

static __global__ __launch_bounds__(1024, 1) void filter_kernel22(
    const emxArray_real_T b, const int32_T b_b, emxArray_real_T kernel1D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    kernel1D.data[k] = b.data[k];
  }
}

static __global__
    __launch_bounds__(32, 1) void filter_kernel23(const emxArray_real_T a,
                                                  real_T *a1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *a1 = a.data[0];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void filter_kernel24(const real_T *a1,
                                                            const int32_T b,
                                                            emxArray_real_T b_b)
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
                                    1) void filter_kernel25(const real_T *a1,
                                                            const int32_T b,
                                                            emxArray_real_T a)
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
                                    1) void filter_kernel26(emxArray_real_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel27(
    const emxArray_real_T b, const int32_T c, emxArray_real_T kernel1D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    kernel1D.data[i1] = b.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel28(
    const int32_T b, emxArray_real_T kernel1D, int32_T b_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    kernel1D.data[i1 + b_dim1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel29(
    const emxArray_real_T x, const int32_T b_x, const int32_T c_x,
    emxArray_real_T input, int32_T input_dim0, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c_x) + 1UL) * (static_cast<uint64_T>(b_x) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_x) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_x) + 1UL));
    input.data[k + input_dim0 * i1] = x.data[k + x_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void filter_kernel3(const real_T *a1,
                                                           const int32_T b,
                                                           emxArray_real_T a)
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

static __global__ __launch_bounds__(1024, 1) void filter_kernel30(
    const emxArray_real_T zi, const int32_T b_zi, const int32_T b,
    emxArray_real_T convOut, int32_T convOut_dim0, int32_T zi_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(b) + 1UL) * (static_cast<uint64_T>(b_zi) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(b_zi) + 1UL));
    convOut.data[i + convOut_dim0 * m] += zi.data[zi_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel31(
    const emxArray_real_T a, const int32_T b, emxArray_real_T convOut,
    int32_T x_dim0, int32_T a_dim1, int32_T convOut_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T m;
    m = static_cast<int32_T>(idx);
    i1 = (x_dim0 + a_dim1) - 1;
    for (int32_T i{0}; i < i1; i++) {
      int32_T k;
      k = static_cast<int32_T>(
              fmin(static_cast<real_T>(i) + 1.0, static_cast<real_T>(a_dim1))) -
          1;
      for (int32_T j{0}; j < k; j++) {
        convOut.data[i + convOut_dim0 * m] -=
            convOut.data[((i - j) + convOut_dim0 * m) - 1] * a.data[j + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel32(
    const emxArray_real_T convOut, const int32_T nb, const int32_T b,
    const int32_T b_convOut, emxArray_real_T zfIIR, int32_T zfIIR_dim0,
    int32_T convOut_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_convOut) + 1UL) *
                (static_cast<uint64_T>(b) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b) + 1UL));
    zfIIR.data[k + zfIIR_dim0 * i1] =
        convOut.data[(nb + k) + convOut_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel33(
    const emxArray_real_T convOut, const emxArray_real_T a, const int32_T b_a,
    const int32_T b, emxArray_real_T zfIIR, int32_T a_dim1, int32_T zfIIR_dim0,
    int32_T x_dim0, int32_T convOut_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(b) + 1UL) * (static_cast<uint64_T>(b_a) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T k;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_a) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(b_a) + 1UL));
    k = static_cast<int32_T>(
            fmin(static_cast<real_T>(i) + 2.0, static_cast<real_T>(a_dim1))) -
        1;
    for (int32_T j{0}; j < k; j++) {
      zfIIR.data[(i + zfIIR_dim0 * m) + 1] +=
          convOut.data[((x_dim0 + i) - j) + convOut_dim0 * m] * a.data[j + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel34(
    const emxArray_real_T zfIIR, const int32_T zfSize_idx_0, emxArray_real_T zf)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zfSize_idx_0);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    zf.data[i1] = zfIIR.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel35(
    const emxArray_real_T convOut, const int32_T x, const int32_T b_convOut,
    emxArray_real_T c_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_convOut) + 1UL) *
                (static_cast<uint64_T>(x) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(x) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(x) + 1UL));
    c_convOut.data[k + convOut_dim0 * i1] =
        convOut.data[k + b_convOut_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel36(
    const emxArray_real_T convOut, const int32_T zi, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zi);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    y.data[i1] = convOut.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel37(
    const emxArray_real_T zi, const int32_T b_zi, const int32_T b,
    emxArray_real_T convOut, int32_T convOut_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(b) + 1UL) * (static_cast<uint64_T>(b_zi) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(b_zi) + 1UL));
    convOut.data[i + convOut_dim0 * m] += zi.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel38(
    const emxArray_real_T zi, const emxArray_real_T convOut, const int32_T b_zi,
    const int32_T b_convOut, emxArray_real_T c_convOut, int32_T convOut_dim0,
    int32_T b_convOut_dim0, int32_T zi_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_convOut) + 1UL) *
                (static_cast<uint64_T>(b_zi) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_zi) + 1UL));
    c_convOut.data[k + convOut_dim0 * i1] =
        convOut.data[k + b_convOut_dim0 * i1] + zi.data[k + zi_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel39(
    const emxArray_real_T convOut, const int32_T zi_dim0, const int32_T zi,
    const int32_T b_zi, emxArray_real_T b_convOut, int32_T convOut_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(b_zi) + 1UL) * (static_cast<uint64_T>(zi) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(zi) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(zi) + 1UL));
    b_convOut.data[k + convOut_dim0 * i1] = convOut.data[k + zi_dim0 * i1];
  }
}

static __global__ __launch_bounds__(32,
                                    1) void filter_kernel4(emxArray_real_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel40(
    const emxArray_real_T b, const int32_T b_b, emxArray_real_T kernel1D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    kernel1D.data[i1] = b.data[i1];
  }
}

static __global__
    __launch_bounds__(32, 1) void filter_kernel41(const emxArray_real_T a,
                                                  real_T *a1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *a1 = a.data[0];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void filter_kernel42(const real_T *a1,
                                                            const int32_T b,
                                                            emxArray_real_T b_b)
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
                                    1) void filter_kernel43(const real_T *a1,
                                                            const int32_T b,
                                                            emxArray_real_T a)
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
                                    1) void filter_kernel44(emxArray_real_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel45(
    const emxArray_real_T b, const int32_T c, emxArray_real_T kernel1D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    kernel1D.data[i1] = b.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel46(
    const int32_T b, emxArray_real_T kernel1D, int32_T b_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    kernel1D.data[i1 + b_dim1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel47(
    const emxArray_real_T x, const int32_T b_x, const int32_T c_x,
    emxArray_real_T input, int32_T input_dim0, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c_x) + 1UL) * (static_cast<uint64_T>(b_x) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_x) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_x) + 1UL));
    input.data[k + input_dim0 * i1] = x.data[k + x_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel48(
    const emxArray_real_T zi, const int32_T b_zi, const int32_T b,
    emxArray_real_T convOut, int32_T convOut_dim0, int32_T zi_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(b) + 1UL) * (static_cast<uint64_T>(b_zi) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(b_zi) + 1UL));
    convOut.data[i + convOut_dim0 * m] += zi.data[zi_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel49(
    const emxArray_real_T a, const int32_T b, emxArray_real_T convOut,
    int32_T x_dim0, int32_T a_dim1, int32_T convOut_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T m;
    m = static_cast<int32_T>(idx);
    i1 = (x_dim0 + a_dim1) - 1;
    for (int32_T i{0}; i < i1; i++) {
      int32_T k;
      k = static_cast<int32_T>(
              fmin(static_cast<real_T>(i) + 1.0, static_cast<real_T>(a_dim1))) -
          1;
      for (int32_T j{0}; j < k; j++) {
        convOut.data[i + convOut_dim0 * m] -=
            convOut.data[((i - j) + convOut_dim0 * m) - 1] * a.data[j + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel5(
    const emxArray_real_T b, const int32_T c, emxArray_real_T kernel1D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    kernel1D.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel50(
    const emxArray_real_T convOut, const int32_T x, const int32_T b_convOut,
    emxArray_real_T c_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_convOut) + 1UL) *
                (static_cast<uint64_T>(x) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(x) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(x) + 1UL));
    c_convOut.data[k + convOut_dim0 * i1] =
        convOut.data[k + b_convOut_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel51(
    const emxArray_real_T convOut, const int32_T zi, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zi);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    y.data[i1] = convOut.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel52(
    const emxArray_real_T zi, const int32_T b_zi, const int32_T b,
    emxArray_real_T convOut, int32_T convOut_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(b) + 1UL) * (static_cast<uint64_T>(b_zi) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(b_zi) + 1UL));
    convOut.data[i + convOut_dim0 * m] += zi.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel53(
    const emxArray_real_T zi, const emxArray_real_T convOut, const int32_T b_zi,
    const int32_T b_convOut, emxArray_real_T c_convOut, int32_T convOut_dim0,
    int32_T b_convOut_dim0, int32_T zi_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_convOut) + 1UL) *
                (static_cast<uint64_T>(b_zi) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_zi) + 1UL));
    c_convOut.data[k + convOut_dim0 * i1] =
        convOut.data[k + b_convOut_dim0 * i1] + zi.data[k + zi_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel54(
    const emxArray_real_T convOut, const int32_T zi_dim0, const int32_T zi,
    const int32_T b_zi, emxArray_real_T b_convOut, int32_T convOut_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(b_zi) + 1UL) * (static_cast<uint64_T>(zi) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(zi) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(zi) + 1UL));
    b_convOut.data[k + convOut_dim0 * i1] = convOut.data[k + zi_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel55(
    const emxArray_real_T b, const int32_T b_b, emxArray_real_T kernel1D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    kernel1D.data[i1] = b.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel6(
    const int32_T b, emxArray_real_T kernel1D, int32_T b_dim1)
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
    kernel1D.data[k + b_dim1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel7(
    const emxArray_real_T x, const int32_T b_x, emxArray_real_T input)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    input.data[k] = x.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel8(
    const emxArray_real_T convOut, const int32_T b, emxArray_real_T y)
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
    y.data[k] = convOut.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void filter_kernel9(
    const emxArray_real_T zi, const int32_T b, emxArray_real_T convOut)
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
  if (((totalSizeCpu == 0) && (cpu->allocatedSize > 0)) ||
      (gpu->allocatedSize < totalSizeCpu)) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(real_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && (totalSizeGpu > 0));
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

static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu,
                                        const emxArray_real_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxMemcpyCpuToGpu_real_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (cpu->data) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(
        cudaMemcpy(gpu->data, cpu->data,
                   static_cast<uint32_T>(actualSize) * sizeof(real_T),
                   cudaMemcpyHostToDevice),
        __FILE__, __LINE__);
  }
  nvtxRangePop();
}

static void gpuThrowError(const char_T *file, int32_T b_line)
{
  emlrtRTEInfo rtInfo;
  nvtxRangePushA("#fcn#gpuThrowError#" MW_AT_LOCATION);
  rtInfo.lineNo = b_line;
  rtInfo.colNo = 0;
  rtInfo.fName = "";
  rtInfo.pName = file;
  emlrtCUDAError(
      0U, (char_T *)"_",
      (char_T
           *)"Unable to launch kernel. Loop nest contains too many iterations.",
      &rtInfo, emlrtRootTLSGlobal);
  nvtxRangePop();
}

static __device__ real_T paddedArrayElem_device(const emxArray_real_T *array,
                                                int32_T idx, int32_T b_idx,
                                                real_T paddingValue,
                                                int32_T array_dim0)
{
  real_T output;
  if ((idx >= 0) && (idx < array_dim0)) {
    output = array->data[idx + array_dim0 * b_idx];
  } else {
    output = paddingValue;
  }
  return output;
}

static __device__ real_T paddedArrayElem_device(const emxArray_real_T *array,
                                                int32_T idx,
                                                real_T paddingValue,
                                                int32_T array_dim0)
{
  real_T output;
  if ((idx >= 0) && (idx < array_dim0)) {
    output = array->data[idx];
  } else {
    output = paddingValue;
  }
  return output;
}

static __global__ __launch_bounds__(1024, 1) void stencilfunKernel(
    const emxArray_real_T input, int32_T negPad, real_T paddingValue,
    const emxArray_real_T stencilCapture_workspace_t1, emxArray_real_T output,
    int32_T output_dim0, int32_T output_dim1,
    int32_T c_stencilCapture_workspace_t1_d, int32_T input_dim0)
{
  int32_T workItemLocalIdTmp;
  int32_T workItemLocalOutputElemDimIdx;
  workItemLocalIdTmp = static_cast<int32_T>(mwGetThreadIndexWithinBlock());
  workItemLocalOutputElemDimIdx = workItemLocalIdTmp % 32;
  workItemLocalIdTmp /= 32;
  for (int32_T quasiWorkGroupId{static_cast<int32_T>(mwGetBlockIndex())};
       quasiWorkGroupId <
       static_cast<int32_T>(
           (static_cast<uint32_T>(output_dim0) >> 5) +
           static_cast<uint32_T>(static_cast<int32_T>(
               (static_cast<uint32_T>(output_dim0) & 31U) != 0U))) *
           static_cast<int32_T>(
               (static_cast<uint32_T>(output_dim1) >> 5) +
               static_cast<uint32_T>(static_cast<int32_T>(
                   (static_cast<uint32_T>(output_dim1) & 31U) != 0U)));
       quasiWorkGroupId += static_cast<int32_T>(mwGetBlocksPerGrid())) {
    int32_T numQuasiWorkGroupsAlongDim;
    int32_T workItemGlobalOutputElemDimIdx;
    numQuasiWorkGroupsAlongDim = static_cast<int32_T>(
        (static_cast<uint32_T>(output_dim0) >> 5) +
        static_cast<uint32_T>(static_cast<int32_T>(
            (static_cast<uint32_T>(output_dim0) & 31U) != 0U)));
    workItemGlobalOutputElemDimIdx =
        workItemLocalOutputElemDimIdx +
        ((quasiWorkGroupId % numQuasiWorkGroupsAlongDim) << 5);
    numQuasiWorkGroupsAlongDim =
        workItemLocalIdTmp +
        (div_s32_device(quasiWorkGroupId, numQuasiWorkGroupsAlongDim) << 5);
    if ((workItemGlobalOutputElemDimIdx < output_dim0) &&
        (numQuasiWorkGroupsAlongDim < output_dim1)) {
      real_T varargout_1;
      varargout_1 = 0.0;
      for (int32_T m{0}; m < c_stencilCapture_workspace_t1_d; m++) {
        real_T varargin_1;
        varargin_1 = paddedArrayElem_device(
            &input, (workItemGlobalOutputElemDimIdx + m) - negPad,
            numQuasiWorkGroupsAlongDim, paddingValue, input_dim0);
        varargout_1 +=
            varargin_1 * stencilCapture_workspace_t1
                             .data[(c_stencilCapture_workspace_t1_d - m) - 1];
      }
      output.data[workItemGlobalOutputElemDimIdx +
                  output_dim0 * numQuasiWorkGroupsAlongDim] = varargout_1;
    }
  }
}

static __global__ __launch_bounds__(32, 1) void stencilfunKernel(
    const emxArray_real_T input, int32_T negPad, real_T paddingValue,
    const emxArray_real_T stencilCapture_workspace_t1, emxArray_real_T output,
    int32_T output_dim0, int32_T c_stencilCapture_workspace_t1_d,
    int32_T input_dim0)
{
  int32_T workItemLocalIdTmp;
  workItemLocalIdTmp = static_cast<int32_T>(mwGetThreadIndexWithinBlock());
  for (int32_T quasiWorkGroupId{static_cast<int32_T>(mwGetBlockIndex())};
       quasiWorkGroupId <
       static_cast<int32_T>(
           (static_cast<uint32_T>(output_dim0) >> 5) +
           static_cast<uint32_T>(static_cast<int32_T>(
               (static_cast<uint32_T>(output_dim0) & 31U) != 0U)));
       quasiWorkGroupId += static_cast<int32_T>(mwGetBlocksPerGrid())) {
    int32_T workItemGlobalOutputElemDimIdx;
    workItemGlobalOutputElemDimIdx =
        workItemLocalIdTmp + (quasiWorkGroupId << 5);
    if (workItemGlobalOutputElemDimIdx < output_dim0) {
      real_T varargout_1;
      varargout_1 = 0.0;
      for (int32_T m{0}; m < c_stencilCapture_workspace_t1_d; m++) {
        real_T varargin_1;
        varargin_1 = paddedArrayElem_device(
            &input, (workItemGlobalOutputElemDimIdx + m) - negPad, paddingValue,
            input_dim0);
        varargout_1 +=
            varargin_1 * stencilCapture_workspace_t1
                             .data[(c_stencilCapture_workspace_t1_d - m) - 1];
      }
      output.data[workItemGlobalOutputElemDimIdx] = varargout_1;
    }
  }
}

//
//
namespace coder {
void b_filter(emxArray_real_T *cpu_b, boolean_T *b_outdatedOnCpu,
              emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
              emxArray_real_T *cpu_a, boolean_T *a_outdatedOnCpu,
              emxArray_real_T *gpu_a, boolean_T *a_outdatedOnGpu,
              emxArray_real_T *cpu_x, emxArray_real_T *gpu_x,
              boolean_T *x_outdatedOnGpu, emxArray_real_T *cpu_zi,
              boolean_T *zi_outdatedOnCpu, emxArray_real_T *gpu_zi,
              boolean_T *zi_outdatedOnGpu, emxArray_real_T *cpu_y,
              boolean_T *y_outdatedOnCpu, emxArray_real_T *gpu_y,
              boolean_T *y_outdatedOnGpu, emxArray_real_T *cpu_zf,
              boolean_T *zf_outdatedOnCpu, emxArray_real_T *gpu_zf,
              boolean_T *zf_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_real_T gpu_convOut;
  emxArray_real_T gpu_input;
  emxArray_real_T gpu_kernel1D;
  emxArray_real_T *cpu_convOut;
  emxArray_real_T *cpu_input;
  emxArray_real_T *cpu_kernel1D;
  real_T *gpu_a1;
  int32_T na;
  int32_T nb;
  int32_T zfSize_idx_0;
  boolean_T b_needsGpuEnsureCapacity;
  boolean_T validLaunchParams;
  nvtxRangePushA("#fcn#b_filter#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_convOut);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_input);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_kernel1D);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_a1, 8UL), __FILE__, __LINE__);
  b_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  na = cpu_a->size[1];
  nb = cpu_b->size[1];
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
  if (*a_outdatedOnGpu) {
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real_T(gpu_a, cpu_a);
  }
  nvtxMarkA("#filter_kernel11#" MW_AT_LINE);
  filter_kernel11<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a, gpu_a1);
  nvtxMarkA("#cpuEmxAllocateOrResize_real_T#" MW_AT_LINE);
  cpuEmxAllocateOrResize_real_T(cpu_a, !*a_outdatedOnCpu);
  if (*a_outdatedOnCpu) {
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real_T(cpu_a, gpu_a);
  }
  *a_outdatedOnCpu = false;
  if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
      (!(cpu_a->data[0] == 0.0)) && (cpu_a->data[0] != 1.0)) {
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    b_needsGpuEnsureCapacity = false;
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel12#" MW_AT_LINE);
      filter_kernel12<<<grid, block>>>(gpu_a1, nb - 1, *gpu_b);
    }
    *b_outdatedOnGpu = false;
    *b_outdatedOnCpu = true;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 2), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel13#" MW_AT_LINE);
      filter_kernel13<<<grid, block>>>(gpu_a1, na - 2, *gpu_a);
    }
    nvtxMarkA("#filter_kernel14#" MW_AT_LINE);
    filter_kernel14<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a);
    *a_outdatedOnCpu = true;
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_kernel1D, 1, &sd_emlrtRTEI, true);
  if (cpu_a->size[1] > cpu_b->size[1]) {
    cpu_kernel1D->size[0] = cpu_a->size[1];
    na = cpu_b->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_kernel1D, &gpu_kernel1D, true);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel15#" MW_AT_LINE);
      filter_kernel15<<<grid, block>>>(*gpu_b, na - 1, gpu_kernel1D);
    }
    na = cpu_a->size[1] - cpu_b->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel16#" MW_AT_LINE);
      filter_kernel16<<<grid, block>>>(na - 1, gpu_kernel1D, cpu_b->size[1U]);
    }
  } else {
    cpu_kernel1D->size[0] = cpu_b->size[1];
    na = cpu_b->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_kernel1D, &gpu_kernel1D, true);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel22#" MW_AT_LINE);
      filter_kernel22<<<grid, block>>>(*gpu_b, na, gpu_kernel1D);
    }
  }
  zfSize_idx_0 = cpu_kernel1D->size[0] - 1;
  if (cpu_x->size[0] == 0) {
    *y_outdatedOnCpu = false;
    cpu_y->size[0] = 0;
    *zf_outdatedOnCpu = false;
    na = cpu_zf->size[0];
    cpu_zf->size[0] = cpu_kernel1D->size[0] - 1;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_zf, na, &sd_emlrtRTEI);
  } else {
    dim3 b_grid;
    int32_T i;
    uint32_T varargin_3_idx_0;
    boolean_T convOut_outdatedOnCpu;
    boolean_T convOut_outdatedOnGpu;
    varargin_3_idx_0 = static_cast<uint32_T>(cpu_kernel1D->size[0]);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_input, 1, &wd_emlrtRTEI, true);
    cpu_input->size[0] = cpu_x->size[0];
    na = cpu_x->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_input, &gpu_input, true);
    if (*x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel17#" MW_AT_LINE);
      filter_kernel17<<<grid, block>>>(*gpu_x, na, gpu_input);
    }
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_convOut, 1, &sd_emlrtRTEI, true);
    na = cpu_convOut->size[0];
    cpu_convOut->size[0] = (cpu_x->size[0] + cpu_kernel1D->size[0]) - 1;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_convOut, na, &ud_emlrtRTEI);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_convOut, &gpu_convOut, true);
    b_needsGpuEnsureCapacity = false;
    b_grid =
        dim3((static_cast<uint32_T>(cpu_convOut->size[0]) >> 5) +
                 ((static_cast<uint32_T>(cpu_convOut->size[0]) & 31U) != 0U),
             1U, 1U);
    validLaunchParams = mwValidateLaunchParameters(b_grid, dim3(32U, 1U, 1U));
    if (validLaunchParams) {
      nvtxMarkA("#stencilfunKernel#" MW_AT_LINE);
      stencilfunKernel<<<b_grid, dim3(32U, 1U, 1U)>>>(
          gpu_input, static_cast<int32_T>(varargin_3_idx_0) - 1, 0.0,
          gpu_kernel1D, gpu_convOut, cpu_convOut->size[0U],
          cpu_kernel1D->size[0U], cpu_input->size[0U]);
    }
    convOut_outdatedOnGpu = false;
    convOut_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_input);
    if (cpu_zi->size[0] != 0) {
      if (cpu_zi->size[0] == 1) {
        nvtxMarkA("#cpuEmxAllocateOrResize_real_T#" MW_AT_LINE);
        cpuEmxAllocateOrResize_real_T(cpu_zi, !*zi_outdatedOnCpu);
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_convOut, &gpu_convOut);
        if (*zi_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_zi, gpu_zi);
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
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_zi, gpu_zi, !*zi_outdatedOnGpu);
        if (*zi_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(gpu_zi, cpu_zi);
        }
        *zi_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel21#" MW_AT_LINE);
          filter_kernel21<<<grid, block>>>(*gpu_zi, na - 1, gpu_convOut);
        }
      }
    }
    na = cpu_x->size[0] + cpu_a->size[1];
    profileLoopStart("b_filter_loop_0", __LINE__, (na - 2) + 1, "");
    for (i = 0; i <= na - 2; i++) {
      nb = static_cast<int32_T>(std::fmin(static_cast<real_T>(i) + 1.0,
                                          static_cast<real_T>(cpu_a->size[1])));
      profileLoopStart("b_filter_loop_1", __LINE__, (nb - 2) + 1, "");
      for (int32_T j{0}; j <= nb - 2; j++) {
        if (convOut_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_convOut, &gpu_convOut);
        }
        if (*a_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_a, gpu_a);
        }
        *a_outdatedOnCpu = false;
        cpu_convOut->data[i] -=
            cpu_convOut->data[(i - j) - 1] * cpu_a->data[j + 1];
        convOut_outdatedOnCpu = false;
        convOut_outdatedOnGpu = true;
        b_needsGpuEnsureCapacity = true;
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    if (static_cast<uint32_T>(cpu_x->size[0]) + 1U >
        static_cast<uint32_T>(cpu_convOut->size[0])) {
      nb = 0;
      i = 0;
    } else {
      nb = cpu_x->size[0];
      i = cpu_convOut->size[0];
    }
    na = cpu_zf->size[0];
    cpu_zf->size[0] = i - nb;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_zf, na, &sd_emlrtRTEI);
    na = (i - nb) - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_convOut, &gpu_convOut,
                                  !convOut_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_zf, gpu_zf, true);
    if (convOut_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_convOut, cpu_convOut);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel18#" MW_AT_LINE);
      filter_kernel18<<<grid, block>>>(gpu_convOut, nb, na, *gpu_zf);
    }
    na = cpu_a->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 3), &grid, &block,
                            2147483647U);
    *x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel19#" MW_AT_LINE);
      filter_kernel19<<<grid, block>>>(gpu_convOut, *gpu_a, na - 3, *gpu_zf,
                                       cpu_a->size[1U], cpu_x->size[0U]);
    }
    *zf_outdatedOnCpu = true;
    na = cpu_zf->size[0];
    cpu_zf->size[0] = zfSize_idx_0;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_zf, na, &sd_emlrtRTEI);
    na = cpu_y->size[0];
    cpu_y->size[0] = cpu_x->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_y, na, &sd_emlrtRTEI);
    na = cpu_x->size[0];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_y, gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel20#" MW_AT_LINE);
      filter_kernel20<<<grid, block>>>(gpu_convOut, na - 1, *gpu_y);
    }
    *y_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_convOut);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_kernel1D);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_a1), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_kernel1D);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_input);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_convOut);
  *b_outdatedOnGpu = false;
  *a_outdatedOnGpu = false;
  *y_outdatedOnGpu = false;
  *zf_outdatedOnGpu = false;
  nvtxRangePop();
}

//
//
void c_filter(emxArray_real_T *cpu_b, boolean_T *b_outdatedOnCpu,
              emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
              emxArray_real_T *cpu_a, boolean_T *a_outdatedOnCpu,
              emxArray_real_T *gpu_a, boolean_T *a_outdatedOnGpu,
              emxArray_real_T *cpu_x, emxArray_real_T *gpu_x,
              boolean_T *x_outdatedOnGpu, emxArray_real_T *cpu_zi,
              boolean_T *zi_outdatedOnCpu, emxArray_real_T *gpu_zi,
              boolean_T *zi_outdatedOnGpu, emxArray_real_T *cpu_y,
              boolean_T *y_outdatedOnCpu, emxArray_real_T *gpu_y,
              boolean_T *y_outdatedOnGpu, emxArray_real_T *cpu_zf,
              boolean_T *zf_outdatedOnCpu, emxArray_real_T *gpu_zf,
              boolean_T *zf_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_real_T b_gpu_convOut;
  emxArray_real_T c_gpu_convOut;
  emxArray_real_T gpu_convOut;
  emxArray_real_T gpu_input;
  emxArray_real_T gpu_kernel1D;
  emxArray_real_T gpu_zfIIR;
  emxArray_real_T *b_cpu_convOut;
  emxArray_real_T *c_cpu_convOut;
  emxArray_real_T *cpu_convOut;
  emxArray_real_T *cpu_input;
  emxArray_real_T *cpu_kernel1D;
  emxArray_real_T *cpu_zfIIR;
  real_T *gpu_a1;
  int32_T b;
  int32_T na;
  int32_T nb;
  int32_T zfSize_idx_0;
  boolean_T b_needsGpuEnsureCapacity;
  boolean_T validLaunchParams;
  nvtxRangePushA("#fcn#c_filter#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_convOut);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_zfIIR);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_convOut);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_convOut);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_input);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_kernel1D);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_a1, 8UL), __FILE__, __LINE__);
  b_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  na = cpu_a->size[1];
  nb = cpu_b->size[1];
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
  if (*a_outdatedOnGpu) {
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real_T(gpu_a, cpu_a);
  }
  nvtxMarkA("#filter_kernel23#" MW_AT_LINE);
  filter_kernel23<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a, gpu_a1);
  nvtxMarkA("#cpuEmxAllocateOrResize_real_T#" MW_AT_LINE);
  cpuEmxAllocateOrResize_real_T(cpu_a, !*a_outdatedOnCpu);
  if (*a_outdatedOnCpu) {
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real_T(cpu_a, gpu_a);
  }
  *a_outdatedOnCpu = false;
  if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
      (!(cpu_a->data[0] == 0.0)) && (cpu_a->data[0] != 1.0)) {
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    b_needsGpuEnsureCapacity = false;
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel24#" MW_AT_LINE);
      filter_kernel24<<<grid, block>>>(gpu_a1, nb - 1, *gpu_b);
    }
    *b_outdatedOnGpu = false;
    *b_outdatedOnCpu = true;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 2), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel25#" MW_AT_LINE);
      filter_kernel25<<<grid, block>>>(gpu_a1, na - 2, *gpu_a);
    }
    nvtxMarkA("#filter_kernel26#" MW_AT_LINE);
    filter_kernel26<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a);
    *a_outdatedOnCpu = true;
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_kernel1D, 1, &sd_emlrtRTEI, true);
  if (cpu_a->size[1] > cpu_b->size[1]) {
    cpu_kernel1D->size[0] = cpu_a->size[1];
    na = cpu_b->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_kernel1D, &gpu_kernel1D, true);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel27#" MW_AT_LINE);
      filter_kernel27<<<grid, block>>>(*gpu_b, na - 1, gpu_kernel1D);
    }
    na = cpu_a->size[1] - cpu_b->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel28#" MW_AT_LINE);
      filter_kernel28<<<grid, block>>>(na - 1, gpu_kernel1D, cpu_b->size[1U]);
    }
  } else {
    cpu_kernel1D->size[0] = cpu_b->size[1];
    b = cpu_b->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(b), &grid, &block, 2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_kernel1D, &gpu_kernel1D, true);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel40#" MW_AT_LINE);
      filter_kernel40<<<grid, block>>>(*gpu_b, b, gpu_kernel1D);
    }
  }
  zfSize_idx_0 = cpu_kernel1D->size[0] - 1;
  if ((cpu_x->size[0] == 0) || (cpu_x->size[1] == 0)) {
    uint32_T varargin_3[2];
    profileLoopStart("c_filter_loop_0", __LINE__, 1 + 1, "");
    for (b = 0; b < 2; b++) {
      varargin_3[b] = static_cast<uint32_T>(cpu_x->size[b]);
    }
    profileLoopEnd();
    *y_outdatedOnCpu = false;
    na = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = static_cast<int32_T>(varargin_3[0]);
    cpu_y->size[1] = static_cast<int32_T>(varargin_3[1]);
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_y, na, &sd_emlrtRTEI);
    *zf_outdatedOnCpu = false;
    na = cpu_zf->size[0] * cpu_zf->size[1];
    cpu_zf->size[0] = zfSize_idx_0;
    cpu_zf->size[1] = cpu_x->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_zf, na, &sd_emlrtRTEI);
  } else {
    dim3 b_grid;
    uint64_T numIters;
    int32_T zi[2];
    int32_T convOut;
    uint32_T varargin_3[2];
    boolean_T convOut_outdatedOnGpu;
    varargin_3[0] = static_cast<uint32_T>(cpu_kernel1D->size[0]);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_input, 2, &sd_emlrtRTEI, true);
    cpu_input->size[0] = cpu_x->size[0];
    cpu_input->size[1] = cpu_x->size[1];
    na = cpu_x->size[1] - 1;
    b = cpu_x->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    numIters = computeNumIters(na, b);
    mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_input, &gpu_input, true);
    if (*x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel29#" MW_AT_LINE);
      filter_kernel29<<<grid, block>>>(*gpu_x, b, na, gpu_input,
                                       cpu_input->size[0U], cpu_x->size[0U]);
    }
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_convOut, 2, &sd_emlrtRTEI, true);
    na = cpu_convOut->size[0] * cpu_convOut->size[1];
    cpu_convOut->size[0] = (cpu_x->size[0] + cpu_kernel1D->size[0]) - 1;
    cpu_convOut->size[1] = cpu_x->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_convOut, na, &ud_emlrtRTEI);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_convOut, &gpu_convOut, true);
    b_needsGpuEnsureCapacity = false;
    b_grid = dim3(
        static_cast<uint32_T>(
            static_cast<int32_T>(
                (static_cast<uint32_T>(cpu_convOut->size[0]) >> 5) +
                ((static_cast<uint32_T>(cpu_convOut->size[0]) & 31U) != 0U)) *
            static_cast<int32_T>(
                (static_cast<uint32_T>(cpu_convOut->size[1]) >> 5) +
                ((static_cast<uint32_T>(cpu_convOut->size[1]) & 31U) != 0U))),
        1U, 1U);
    validLaunchParams = mwValidateLaunchParameters(b_grid, dim3(1024U, 1U, 1U));
    if (validLaunchParams) {
      nvtxMarkA("#stencilfunKernel#" MW_AT_LINE);
      stencilfunKernel<<<b_grid, dim3(1024U, 1U, 1U)>>>(
          gpu_input, static_cast<int32_T>(varargin_3[0]) - 1, 0.0, gpu_kernel1D,
          gpu_convOut, cpu_convOut->size[0U], cpu_convOut->size[1U],
          cpu_kernel1D->size[0U], cpu_input->size[0U]);
    }
    convOut_outdatedOnGpu = false;
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_input);
    if ((cpu_zi->size[0] != 0) && (cpu_zi->size[1] != 0)) {
      if (cpu_zi->size[0] == 1) {
        na = cpu_convOut->size[1];
        b = cpu_zi->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        numIters = computeNumIters(na - 1, b);
        mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_zi, gpu_zi, !*zi_outdatedOnGpu);
        if (*zi_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(gpu_zi, cpu_zi);
        }
        *zi_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel30#" MW_AT_LINE);
          filter_kernel30<<<grid, block>>>(*gpu_zi, b, na - 1, gpu_convOut,
                                           cpu_convOut->size[0U],
                                           cpu_zi->size[0U]);
        }
      } else if (cpu_zi->size[1] == 1) {
        na = cpu_convOut->size[1];
        b = cpu_zi->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        numIters = computeNumIters(na - 1, b);
        mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_zi, gpu_zi, !*zi_outdatedOnGpu);
        if (*zi_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(gpu_zi, cpu_zi);
        }
        *zi_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel37#" MW_AT_LINE);
          filter_kernel37<<<grid, block>>>(*gpu_zi, b, na - 1, gpu_convOut,
                                           cpu_convOut->size[0U]);
        }
      } else if (cpu_convOut->size[1] == cpu_zi->size[1]) {
        nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
        emxInit_real_T(&b_cpu_convOut, 2, &sd_emlrtRTEI, true);
        b_cpu_convOut->size[0] = cpu_zi->size[0];
        b_cpu_convOut->size[1] = cpu_convOut->size[1];
        convOut = cpu_convOut->size[1] - 1;
        b = cpu_zi->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        numIters = computeNumIters(convOut, b);
        mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_zi, gpu_zi, !*zi_outdatedOnGpu);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(b_cpu_convOut, &c_gpu_convOut, true);
        if (*zi_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(gpu_zi, cpu_zi);
        }
        *zi_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel38#" MW_AT_LINE);
          filter_kernel38<<<grid, block>>>(
              *gpu_zi, gpu_convOut, b, convOut, c_gpu_convOut,
              b_cpu_convOut->size[0U], cpu_convOut->size[0U], cpu_zi->size[0U]);
        }
        zi[0] = cpu_zi->size[0];
        zi[1] = cpu_convOut->size[1];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        numIters = computeNumIters(zi[1] - 1, zi[0] - 1);
        mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel39#" MW_AT_LINE);
          filter_kernel39<<<grid, block>>>(c_gpu_convOut, zi[0], zi[0] - 1,
                                           zi[1] - 1, gpu_convOut,
                                           cpu_convOut->size[0U]);
        }
        nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
        emxFree_real_T(&b_cpu_convOut);
      } else {
        nvtxMarkA("#cpuEmxAllocateOrResize_real_T#" MW_AT_LINE);
        cpuEmxAllocateOrResize_real_T(cpu_zi, !*zi_outdatedOnCpu);
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_convOut, &gpu_convOut);
        if (*zi_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_zi, gpu_zi);
        }
        *zi_outdatedOnCpu = false;
        nvtxMarkA("#binary_expand_op_2#" MW_AT_LINE);
        binary_expand_op_2(cpu_convOut, cpu_zi);
        convOut_outdatedOnGpu = true;
        b_needsGpuEnsureCapacity = true;
      }
    }
    na = cpu_convOut->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_convOut, &gpu_convOut,
                                  !convOut_outdatedOnGpu);
    }
    if (convOut_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_convOut, cpu_convOut);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel31#" MW_AT_LINE);
      filter_kernel31<<<grid, block>>>(*gpu_a, na - 1, gpu_convOut,
                                       cpu_x->size[0U], cpu_a->size[1U],
                                       cpu_convOut->size[0U]);
    }
    if (static_cast<uint32_T>(cpu_x->size[0]) + 1U >
        static_cast<uint32_T>(cpu_convOut->size[0])) {
      nb = 0;
      b = 0;
    } else {
      nb = cpu_x->size[0];
      b = cpu_convOut->size[0];
    }
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_zfIIR, 2, &sd_emlrtRTEI, true);
    cpu_zfIIR->size[0] = b - nb;
    cpu_zfIIR->size[1] = cpu_convOut->size[1];
    convOut = cpu_convOut->size[1] - 1;
    b = (b - nb) - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    numIters = computeNumIters(convOut, b);
    mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_zfIIR, &gpu_zfIIR, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel32#" MW_AT_LINE);
      filter_kernel32<<<grid, block>>>(gpu_convOut, nb, b, convOut, gpu_zfIIR,
                                       cpu_zfIIR->size[0U],
                                       cpu_convOut->size[0U]);
    }
    na = cpu_convOut->size[1];
    b = cpu_a->size[1] - 3;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    numIters = computeNumIters(na - 1, b);
    mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
    *x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel33#" MW_AT_LINE);
      filter_kernel33<<<grid, block>>>(
          gpu_convOut, *gpu_a, b, na - 1, gpu_zfIIR, cpu_a->size[1U],
          cpu_zfIIR->size[0U], cpu_x->size[0U], cpu_convOut->size[0U]);
    }
    na = cpu_zf->size[0] * cpu_zf->size[1];
    cpu_zf->size[0] = zfSize_idx_0;
    cpu_zf->size[1] = cpu_x->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_zf, na, &sd_emlrtRTEI);
    zfSize_idx_0 = zfSize_idx_0 * cpu_x->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(zfSize_idx_0), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_zf, gpu_zf, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel34#" MW_AT_LINE);
      filter_kernel34<<<grid, block>>>(gpu_zfIIR, zfSize_idx_0, *gpu_zf);
    }
    *zf_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_zfIIR);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&c_cpu_convOut, 2, &sd_emlrtRTEI, true);
    c_cpu_convOut->size[0] = cpu_x->size[0];
    c_cpu_convOut->size[1] = cpu_convOut->size[1];
    convOut = cpu_convOut->size[1] - 1;
    na = cpu_x->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    numIters = computeNumIters(convOut, na);
    mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(c_cpu_convOut, &b_gpu_convOut, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel35#" MW_AT_LINE);
      filter_kernel35<<<grid, block>>>(gpu_convOut, na, convOut, b_gpu_convOut,
                                       c_cpu_convOut->size[0U],
                                       cpu_convOut->size[0U]);
    }
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_convOut);
    zi[0] = cpu_x->size[0];
    zi[1] = cpu_x->size[1];
    na = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = cpu_x->size[0];
    cpu_y->size[1] = cpu_x->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_y, na, &sd_emlrtRTEI);
    b = zi[0] * zi[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(b), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_y, gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel36#" MW_AT_LINE);
      filter_kernel36<<<grid, block>>>(b_gpu_convOut, b, *gpu_y);
    }
    *y_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&c_cpu_convOut);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_kernel1D);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_a1), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_kernel1D);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_input);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_convOut);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_convOut);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_zfIIR);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_convOut);
  *b_outdatedOnGpu = false;
  *a_outdatedOnGpu = false;
  *y_outdatedOnGpu = false;
  *zf_outdatedOnGpu = false;
  nvtxRangePop();
}

//
//
void d_filter(emxArray_real_T *cpu_b, boolean_T *b_outdatedOnCpu,
              emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
              emxArray_real_T *cpu_a, boolean_T *a_outdatedOnCpu,
              emxArray_real_T *gpu_a, boolean_T *a_outdatedOnGpu,
              emxArray_real_T *cpu_x, emxArray_real_T *gpu_x,
              boolean_T *x_outdatedOnGpu, emxArray_real_T *cpu_zi,
              boolean_T *zi_outdatedOnCpu, emxArray_real_T *gpu_zi,
              boolean_T *zi_outdatedOnGpu, emxArray_real_T *cpu_y,
              boolean_T *y_outdatedOnCpu, emxArray_real_T *gpu_y,
              boolean_T *y_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_real_T b_gpu_convOut;
  emxArray_real_T c_gpu_convOut;
  emxArray_real_T gpu_convOut;
  emxArray_real_T gpu_input;
  emxArray_real_T gpu_kernel1D;
  emxArray_real_T *b_cpu_convOut;
  emxArray_real_T *c_cpu_convOut;
  emxArray_real_T *cpu_convOut;
  emxArray_real_T *cpu_input;
  emxArray_real_T *cpu_kernel1D;
  real_T *gpu_a1;
  int32_T na;
  int32_T nb;
  boolean_T b_needsGpuEnsureCapacity;
  boolean_T validLaunchParams;
  nvtxRangePushA("#fcn#d_filter#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_convOut);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_convOut);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_convOut);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_input);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_kernel1D);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_a1, 8UL), __FILE__, __LINE__);
  b_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  na = cpu_a->size[1];
  nb = cpu_b->size[1];
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
  if (*a_outdatedOnGpu) {
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real_T(gpu_a, cpu_a);
  }
  nvtxMarkA("#filter_kernel41#" MW_AT_LINE);
  filter_kernel41<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a, gpu_a1);
  nvtxMarkA("#cpuEmxAllocateOrResize_real_T#" MW_AT_LINE);
  cpuEmxAllocateOrResize_real_T(cpu_a, !*a_outdatedOnCpu);
  if (*a_outdatedOnCpu) {
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real_T(cpu_a, gpu_a);
  }
  *a_outdatedOnCpu = false;
  if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
      (!(cpu_a->data[0] == 0.0)) && (cpu_a->data[0] != 1.0)) {
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    b_needsGpuEnsureCapacity = false;
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel42#" MW_AT_LINE);
      filter_kernel42<<<grid, block>>>(gpu_a1, nb - 1, *gpu_b);
    }
    *b_outdatedOnGpu = false;
    *b_outdatedOnCpu = true;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 2), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel43#" MW_AT_LINE);
      filter_kernel43<<<grid, block>>>(gpu_a1, na - 2, *gpu_a);
    }
    nvtxMarkA("#filter_kernel44#" MW_AT_LINE);
    filter_kernel44<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a);
    *a_outdatedOnCpu = true;
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_kernel1D, 1, &sd_emlrtRTEI, true);
  if (cpu_a->size[1] > cpu_b->size[1]) {
    cpu_kernel1D->size[0] = cpu_a->size[1];
    na = cpu_b->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_kernel1D, &gpu_kernel1D, true);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel45#" MW_AT_LINE);
      filter_kernel45<<<grid, block>>>(*gpu_b, na - 1, gpu_kernel1D);
    }
    na = cpu_a->size[1] - cpu_b->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel46#" MW_AT_LINE);
      filter_kernel46<<<grid, block>>>(na - 1, gpu_kernel1D, cpu_b->size[1U]);
    }
  } else {
    cpu_kernel1D->size[0] = cpu_b->size[1];
    nb = cpu_b->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb), &grid, &block, 2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_kernel1D, &gpu_kernel1D, true);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel55#" MW_AT_LINE);
      filter_kernel55<<<grid, block>>>(*gpu_b, nb, gpu_kernel1D);
    }
  }
  if ((cpu_x->size[0] == 0) || (cpu_x->size[1] == 0)) {
    uint32_T varargin_3[2];
    profileLoopStart("d_filter_loop_0", __LINE__, 1 + 1, "");
    for (nb = 0; nb < 2; nb++) {
      varargin_3[nb] = static_cast<uint32_T>(cpu_x->size[nb]);
    }
    profileLoopEnd();
    *y_outdatedOnCpu = false;
    na = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = static_cast<int32_T>(varargin_3[0]);
    cpu_y->size[1] = static_cast<int32_T>(varargin_3[1]);
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_y, na, &sd_emlrtRTEI);
  } else {
    dim3 b_grid;
    uint64_T numIters;
    int32_T zi[2];
    int32_T b_zi;
    uint32_T varargin_3[2];
    boolean_T convOut_outdatedOnGpu;
    varargin_3[0] = static_cast<uint32_T>(cpu_kernel1D->size[0]);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_input, 2, &sd_emlrtRTEI, true);
    cpu_input->size[0] = cpu_x->size[0];
    cpu_input->size[1] = cpu_x->size[1];
    na = cpu_x->size[1] - 1;
    nb = cpu_x->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    numIters = computeNumIters(na, nb);
    mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_input, &gpu_input, true);
    if (*x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel47#" MW_AT_LINE);
      filter_kernel47<<<grid, block>>>(*gpu_x, nb, na, gpu_input,
                                       cpu_input->size[0U], cpu_x->size[0U]);
    }
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_convOut, 2, &sd_emlrtRTEI, true);
    na = cpu_convOut->size[0] * cpu_convOut->size[1];
    cpu_convOut->size[0] = (cpu_x->size[0] + cpu_kernel1D->size[0]) - 1;
    cpu_convOut->size[1] = cpu_x->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_convOut, na, &ud_emlrtRTEI);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_convOut, &gpu_convOut, true);
    b_needsGpuEnsureCapacity = false;
    b_grid = dim3(
        static_cast<uint32_T>(
            static_cast<int32_T>(
                (static_cast<uint32_T>(cpu_convOut->size[0]) >> 5) +
                ((static_cast<uint32_T>(cpu_convOut->size[0]) & 31U) != 0U)) *
            static_cast<int32_T>(
                (static_cast<uint32_T>(cpu_convOut->size[1]) >> 5) +
                ((static_cast<uint32_T>(cpu_convOut->size[1]) & 31U) != 0U))),
        1U, 1U);
    validLaunchParams = mwValidateLaunchParameters(b_grid, dim3(1024U, 1U, 1U));
    if (validLaunchParams) {
      nvtxMarkA("#stencilfunKernel#" MW_AT_LINE);
      stencilfunKernel<<<b_grid, dim3(1024U, 1U, 1U)>>>(
          gpu_input, static_cast<int32_T>(varargin_3[0]) - 1, 0.0, gpu_kernel1D,
          gpu_convOut, cpu_convOut->size[0U], cpu_convOut->size[1U],
          cpu_kernel1D->size[0U], cpu_input->size[0U]);
    }
    convOut_outdatedOnGpu = false;
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_input);
    if ((cpu_zi->size[0] != 0) && (cpu_zi->size[1] != 0)) {
      if (cpu_zi->size[0] == 1) {
        na = cpu_convOut->size[1];
        b_zi = cpu_zi->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        numIters = computeNumIters(na - 1, b_zi);
        mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_zi, gpu_zi, !*zi_outdatedOnGpu);
        if (*zi_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(gpu_zi, cpu_zi);
        }
        *zi_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel48#" MW_AT_LINE);
          filter_kernel48<<<grid, block>>>(*gpu_zi, b_zi, na - 1, gpu_convOut,
                                           cpu_convOut->size[0U],
                                           cpu_zi->size[0U]);
        }
      } else if (cpu_zi->size[1] == 1) {
        na = cpu_convOut->size[1];
        b_zi = cpu_zi->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        numIters = computeNumIters(na - 1, b_zi);
        mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_zi, gpu_zi, !*zi_outdatedOnGpu);
        if (*zi_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(gpu_zi, cpu_zi);
        }
        *zi_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel52#" MW_AT_LINE);
          filter_kernel52<<<grid, block>>>(*gpu_zi, b_zi, na - 1, gpu_convOut,
                                           cpu_convOut->size[0U]);
        }
      } else if (cpu_convOut->size[1] == cpu_zi->size[1]) {
        nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
        emxInit_real_T(&b_cpu_convOut, 2, &sd_emlrtRTEI, true);
        b_cpu_convOut->size[0] = cpu_zi->size[0];
        b_cpu_convOut->size[1] = cpu_convOut->size[1];
        nb = cpu_convOut->size[1] - 1;
        b_zi = cpu_zi->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        numIters = computeNumIters(nb, b_zi);
        mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_zi, gpu_zi, !*zi_outdatedOnGpu);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(b_cpu_convOut, &c_gpu_convOut, true);
        if (*zi_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(gpu_zi, cpu_zi);
        }
        *zi_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel53#" MW_AT_LINE);
          filter_kernel53<<<grid, block>>>(
              *gpu_zi, gpu_convOut, b_zi, nb, c_gpu_convOut,
              b_cpu_convOut->size[0U], cpu_convOut->size[0U], cpu_zi->size[0U]);
        }
        zi[0] = cpu_zi->size[0];
        zi[1] = cpu_convOut->size[1];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        numIters = computeNumIters(zi[1] - 1, zi[0] - 1);
        mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel54#" MW_AT_LINE);
          filter_kernel54<<<grid, block>>>(c_gpu_convOut, zi[0], zi[0] - 1,
                                           zi[1] - 1, gpu_convOut,
                                           cpu_convOut->size[0U]);
        }
        nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
        emxFree_real_T(&b_cpu_convOut);
      } else {
        nvtxMarkA("#cpuEmxAllocateOrResize_real_T#" MW_AT_LINE);
        cpuEmxAllocateOrResize_real_T(cpu_zi, !*zi_outdatedOnCpu);
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_convOut, &gpu_convOut);
        if (*zi_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_zi, gpu_zi);
        }
        *zi_outdatedOnCpu = false;
        nvtxMarkA("#binary_expand_op_2#" MW_AT_LINE);
        binary_expand_op_2(cpu_convOut, cpu_zi);
        convOut_outdatedOnGpu = true;
        b_needsGpuEnsureCapacity = true;
      }
    }
    na = cpu_convOut->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_convOut, &gpu_convOut,
                                  !convOut_outdatedOnGpu);
    }
    *x_outdatedOnGpu = false;
    if (convOut_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_convOut, cpu_convOut);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel49#" MW_AT_LINE);
      filter_kernel49<<<grid, block>>>(*gpu_a, na - 1, gpu_convOut,
                                       cpu_x->size[0U], cpu_a->size[1U],
                                       cpu_convOut->size[0U]);
    }
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&c_cpu_convOut, 2, &sd_emlrtRTEI, true);
    c_cpu_convOut->size[0] = cpu_x->size[0];
    c_cpu_convOut->size[1] = cpu_convOut->size[1];
    nb = cpu_convOut->size[1] - 1;
    na = cpu_x->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    numIters = computeNumIters(nb, na);
    mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(c_cpu_convOut, &b_gpu_convOut, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel50#" MW_AT_LINE);
      filter_kernel50<<<grid, block>>>(gpu_convOut, na, nb, b_gpu_convOut,
                                       c_cpu_convOut->size[0U],
                                       cpu_convOut->size[0U]);
    }
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_convOut);
    zi[0] = cpu_x->size[0];
    zi[1] = cpu_x->size[1];
    na = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = cpu_x->size[0];
    cpu_y->size[1] = cpu_x->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_y, na, &vd_emlrtRTEI);
    b_zi = zi[0] * zi[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(b_zi), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_y, gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel51#" MW_AT_LINE);
      filter_kernel51<<<grid, block>>>(b_gpu_convOut, b_zi, *gpu_y);
    }
    *y_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&c_cpu_convOut);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_kernel1D);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_a1), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_kernel1D);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_input);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_convOut);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_convOut);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_convOut);
  *b_outdatedOnGpu = false;
  *a_outdatedOnGpu = false;
  *y_outdatedOnGpu = false;
  nvtxRangePop();
}

//
//
void filter(emxArray_real_T *cpu_b, boolean_T *b_outdatedOnCpu,
            emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
            emxArray_real_T *cpu_a, boolean_T *a_outdatedOnCpu,
            emxArray_real_T *gpu_a, boolean_T *a_outdatedOnGpu,
            emxArray_real_T *cpu_x, emxArray_real_T *gpu_x,
            boolean_T *x_outdatedOnGpu, emxArray_real_T *cpu_zi,
            boolean_T *zi_outdatedOnCpu, emxArray_real_T *gpu_zi,
            boolean_T *zi_outdatedOnGpu, emxArray_real_T *cpu_y,
            boolean_T *y_outdatedOnCpu, emxArray_real_T *gpu_y,
            boolean_T *y_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_real_T gpu_convOut;
  emxArray_real_T gpu_input;
  emxArray_real_T gpu_kernel1D;
  emxArray_real_T *cpu_convOut;
  emxArray_real_T *cpu_input;
  emxArray_real_T *cpu_kernel1D;
  real_T *gpu_a1;
  int32_T na;
  int32_T nb;
  boolean_T b_needsGpuEnsureCapacity;
  boolean_T validLaunchParams;
  nvtxRangePushA("#fcn#filter#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_convOut);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_input);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_kernel1D);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_a1, 8UL), __FILE__, __LINE__);
  b_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  na = cpu_a->size[1];
  nb = cpu_b->size[1];
  nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_real_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
  if (*a_outdatedOnGpu) {
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real_T(gpu_a, cpu_a);
  }
  nvtxMarkA("#filter_kernel1#" MW_AT_LINE);
  filter_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a, gpu_a1);
  nvtxMarkA("#cpuEmxAllocateOrResize_real_T#" MW_AT_LINE);
  cpuEmxAllocateOrResize_real_T(cpu_a, !*a_outdatedOnCpu);
  if (*a_outdatedOnCpu) {
    nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyGpuToCpu_real_T(cpu_a, gpu_a);
  }
  *a_outdatedOnCpu = false;
  if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
      (!(cpu_a->data[0] == 0.0)) && (cpu_a->data[0] != 1.0)) {
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    b_needsGpuEnsureCapacity = false;
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel2#" MW_AT_LINE);
      filter_kernel2<<<grid, block>>>(gpu_a1, nb - 1, *gpu_b);
    }
    *b_outdatedOnGpu = false;
    *b_outdatedOnCpu = true;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 2), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel3#" MW_AT_LINE);
      filter_kernel3<<<grid, block>>>(gpu_a1, na - 2, *gpu_a);
    }
    nvtxMarkA("#filter_kernel4#" MW_AT_LINE);
    filter_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_a);
    *a_outdatedOnCpu = true;
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_kernel1D, 1, &sd_emlrtRTEI, true);
  if (cpu_a->size[1] > cpu_b->size[1]) {
    cpu_kernel1D->size[0] = cpu_a->size[1];
    na = cpu_b->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_kernel1D, &gpu_kernel1D, true);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel5#" MW_AT_LINE);
      filter_kernel5<<<grid, block>>>(*gpu_b, na - 1, gpu_kernel1D);
    }
    na = cpu_a->size[1] - cpu_b->size[1];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel6#" MW_AT_LINE);
      filter_kernel6<<<grid, block>>>(na - 1, gpu_kernel1D, cpu_b->size[1U]);
    }
  } else {
    cpu_kernel1D->size[0] = cpu_b->size[1];
    na = cpu_b->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_kernel1D, &gpu_kernel1D, true);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel10#" MW_AT_LINE);
      filter_kernel10<<<grid, block>>>(*gpu_b, na, gpu_kernel1D);
    }
  }
  if (cpu_x->size[0] == 0) {
    *y_outdatedOnCpu = false;
    cpu_y->size[0] = 0;
  } else {
    dim3 b_grid;
    uint32_T varargin_3_idx_0;
    boolean_T convOut_outdatedOnCpu;
    boolean_T convOut_outdatedOnGpu;
    varargin_3_idx_0 = static_cast<uint32_T>(cpu_kernel1D->size[0]);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_input, 1, &td_emlrtRTEI, true);
    cpu_input->size[0] = cpu_x->size[0];
    na = cpu_x->size[0] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_input, &gpu_input, true);
    if (*x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_x, cpu_x);
    }
    *x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel7#" MW_AT_LINE);
      filter_kernel7<<<grid, block>>>(*gpu_x, na, gpu_input);
    }
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_convOut, 1, &sd_emlrtRTEI, true);
    na = cpu_convOut->size[0];
    cpu_convOut->size[0] = (cpu_x->size[0] + cpu_kernel1D->size[0]) - 1;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_convOut, na, &ud_emlrtRTEI);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_convOut, &gpu_convOut, true);
    b_needsGpuEnsureCapacity = false;
    b_grid =
        dim3((static_cast<uint32_T>(cpu_convOut->size[0]) >> 5) +
                 ((static_cast<uint32_T>(cpu_convOut->size[0]) & 31U) != 0U),
             1U, 1U);
    validLaunchParams = mwValidateLaunchParameters(b_grid, dim3(32U, 1U, 1U));
    if (validLaunchParams) {
      nvtxMarkA("#stencilfunKernel#" MW_AT_LINE);
      stencilfunKernel<<<b_grid, dim3(32U, 1U, 1U)>>>(
          gpu_input, static_cast<int32_T>(varargin_3_idx_0) - 1, 0.0,
          gpu_kernel1D, gpu_convOut, cpu_convOut->size[0U],
          cpu_kernel1D->size[0U], cpu_input->size[0U]);
    }
    convOut_outdatedOnGpu = false;
    convOut_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_input);
    if (cpu_zi->size[0] != 0) {
      if (cpu_zi->size[0] == 1) {
        nvtxMarkA("#cpuEmxAllocateOrResize_real_T#" MW_AT_LINE);
        cpuEmxAllocateOrResize_real_T(cpu_zi, !*zi_outdatedOnCpu);
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_convOut, &gpu_convOut);
        if (*zi_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_zi, gpu_zi);
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
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_zi, gpu_zi, !*zi_outdatedOnGpu);
        if (*zi_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(gpu_zi, cpu_zi);
        }
        *zi_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#filter_kernel9#" MW_AT_LINE);
          filter_kernel9<<<grid, block>>>(*gpu_zi, na - 1, gpu_convOut);
        }
      }
    }
    na = cpu_x->size[0] + cpu_a->size[1];
    profileLoopStart("filter_loop_0", __LINE__, (na - 2) + 1, "");
    for (int32_T i{0}; i <= na - 2; i++) {
      nb = static_cast<int32_T>(std::fmin(static_cast<real_T>(i) + 1.0,
                                          static_cast<real_T>(cpu_a->size[1])));
      profileLoopStart("filter_loop_1", __LINE__, (nb - 2) + 1, "");
      for (int32_T j{0}; j <= nb - 2; j++) {
        if (convOut_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_convOut, &gpu_convOut);
        }
        if (*a_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_a, gpu_a);
        }
        *a_outdatedOnCpu = false;
        cpu_convOut->data[i] -=
            cpu_convOut->data[(i - j) - 1] * cpu_a->data[j + 1];
        convOut_outdatedOnCpu = false;
        convOut_outdatedOnGpu = true;
        b_needsGpuEnsureCapacity = true;
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    na = cpu_y->size[0];
    cpu_y->size[0] = cpu_x->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_y, na, &vd_emlrtRTEI);
    na = cpu_x->size[0];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na - 1), &grid, &block,
                            2147483647U);
    if (b_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_convOut, &gpu_convOut,
                                  !convOut_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_y, gpu_y, true);
    if (convOut_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_convOut, cpu_convOut);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#filter_kernel8#" MW_AT_LINE);
      filter_kernel8<<<grid, block>>>(gpu_convOut, na - 1, *gpu_y);
    }
    *y_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_convOut);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_kernel1D);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_a1), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_kernel1D);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_input);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_convOut);
  *b_outdatedOnGpu = false;
  *a_outdatedOnGpu = false;
  *y_outdatedOnGpu = false;
  nvtxRangePop();
}

} // namespace coder

// End of code generation (filter.cu)
