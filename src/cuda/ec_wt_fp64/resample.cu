//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// resample.cu
//
// Code generation for function 'resample'
//

// Include files
#include "resample.h"
#include "ResampleParser.h"
#include "conv2.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "rt_nonfinite.h"
#include "uniformResampleKernel.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "math_constants.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo ge_emlrtRTEI{
    154,                                                        // lineNo
    1,                                                          // colNo
    "resample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/resample.m" // pName
};

static emlrtRTEInfo he_emlrtRTEI{
    38,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo ie_emlrtRTEI{
    161,                                                        // lineNo
    9,                                                          // colNo
    "resample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/resample.m" // pName
};

static emlrtRTEInfo je_emlrtRTEI{
    21,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo ke_emlrtRTEI{
    31,                      // lineNo
    29,                      // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo le_emlrtRTEI{
    20,               // lineNo
    9,                // colNo
    "reorientOutput", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/reorientOutput.m" // pName
};

// Function Declarations
static __global__ void resample_kernel24(const emxArray_creal_T varargin_1,
                                         const int32_T b,
                                         emxArray_creal_T opts_x);

static __global__ void resample_kernel25(const emxArray_creal_T w,
                                         const int32_T u0, const int32_T b,
                                         emxArray_creal_T y);

static __global__ void resample_kernel26(emxArray_real_T y);

static __global__ void
resample_kernel27(const emxArray_creal_T y, const emxArray_real_T b_y,
                  const real_T nlast, const int32_T exponent, const int32_T b,
                  emxArray_creal_T varargout_1, int32_T varargout_1_dim0);

static __global__ void resample_kernel28(const int32_T b, emxArray_real_T y);

static __global__ void resample_kernel29(const emxArray_creal_T varargout_1,
                                         const int32_T b_varargout_1,
                                         const int32_T c_varargout_1,
                                         emxArray_creal_T d_varargout_1,
                                         int32_T varargout_1_dim0,
                                         int32_T b_varargout_1_dim0);

static __global__ void resample_kernel30(const emxArray_creal_T varargout_1,
                                         const int32_T b_varargout_1,
                                         emxArray_creal_T c_varargout_1);

static __global__ void resample_kernel31(const emxArray_creal_T varargin_1,
                                         const int32_T b_varargin_1,
                                         emxArray_creal_T opts_x);

static __global__ void
resample_kernel32(const emxArray_creal_T varargin_1, const int32_T b_varargin_1,
                  const int32_T c_varargin_1, emxArray_creal_T opts_x,
                  int32_T opts_x_dim0, int32_T varargin_1_dim0);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void resample_kernel24(
    const emxArray_creal_T varargin_1, const int32_T b, emxArray_creal_T opts_x)
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
    opts_x.data[i1] = varargin_1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel25(
    const emxArray_creal_T w, const int32_T u0, const int32_T b,
    emxArray_creal_T y)
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
    y.data[i1] = w.data[u0 * i1];
  }
}

static __global__ __launch_bounds__(32,
                                    1) void resample_kernel26(emxArray_real_T y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel27(
    const emxArray_creal_T y, const emxArray_real_T b_y, const real_T nlast,
    const int32_T exponent, const int32_T b, emxArray_creal_T varargout_1,
    int32_T varargout_1_dim0)
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
    varargout_1.data[i1 + varargout_1_dim0 * exponent] =
        y.data[static_cast<int32_T>(nlast + b_y.data[i1]) - 1];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void resample_kernel28(const int32_T b,
                                                              emxArray_real_T y)
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
    y.data[i1] = static_cast<real_T>(i1) + 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel29(
    const emxArray_creal_T varargout_1, const int32_T b_varargout_1,
    const int32_T c_varargout_1, emxArray_creal_T d_varargout_1,
    int32_T varargout_1_dim0, int32_T b_varargout_1_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_varargout_1) + 1UL) *
                (static_cast<uint64_T>(b_varargout_1) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T i2;
    i2 = static_cast<int32_T>(idx %
                              (static_cast<uint64_T>(b_varargout_1) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(i2)) /
                              (static_cast<uint64_T>(b_varargout_1) + 1UL));
    d_varargout_1.data[i2 + varargout_1_dim0 * i1] =
        varargout_1.data[i1 + b_varargout_1_dim0 * i2];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel30(
    const emxArray_creal_T varargout_1, const int32_T b_varargout_1,
    emxArray_creal_T c_varargout_1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_varargout_1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c_varargout_1.data[i1] = varargout_1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel31(
    const emxArray_creal_T varargin_1, const int32_T b_varargin_1,
    emxArray_creal_T opts_x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_varargin_1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    opts_x.data[i1] = varargin_1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel32(
    const emxArray_creal_T varargin_1, const int32_T b_varargin_1,
    const int32_T c_varargin_1, emxArray_creal_T opts_x, int32_T opts_x_dim0,
    int32_T varargin_1_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_varargin_1) + 1UL) *
                (static_cast<uint64_T>(b_varargin_1) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T i2;
    i2 =
        static_cast<int32_T>(idx % (static_cast<uint64_T>(b_varargin_1) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(i2)) /
                              (static_cast<uint64_T>(b_varargin_1) + 1UL));
    opts_x.data[i2 + opts_x_dim0 * i1] =
        varargin_1.data[i1 + varargin_1_dim0 * i2];
  }
}

//
//
namespace coder {
void resample(emxArray_creal_T *cpu_varargin_1,
              emxArray_creal_T *gpu_varargin_1,
              boolean_T *varargin_1_outdatedOnGpu, real_T varargin_2,
              real_T varargin_3, emxArray_creal_T *cpu_varargout_1,
              boolean_T *varargout_1_outdatedOnCpu,
              emxArray_creal_T *gpu_varargout_1,
              boolean_T *varargout_1_outdatedOnGpu)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  b_signal::internal::resample::ResampleParser expl_temp;
  dim3 block;
  dim3 grid;
  emxArray_creal_T b_gpu_varargout_1;
  emxArray_creal_T b_yCol;
  emxArray_creal_T gpu_opts_x;
  emxArray_creal_T gpu_w;
  emxArray_creal_T gpu_y;
  emxArray_creal_T *b_cpu_varargout_1;
  emxArray_creal_T *cpu_opts_x;
  emxArray_creal_T *cpu_w;
  emxArray_creal_T *cpu_y;
  emxArray_creal_T *yCol;
  emxArray_real_T b_gpu_y;
  emxArray_real_T *b_cpu_y;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *y;
  real_T varargin_1[2];
  real_T Ly;
  real_T absx;
  real_T dlast;
  real_T n;
  real_T x;
  real_T xin;
  int32_T b_expl_temp[1];
  int32_T b_varargin_1;
  int32_T exponent;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T opts_dim;
  int32_T u1;
  char_T unusedExpr[23];
  boolean_T validLaunchParams;
  boolean_T w_outdatedOnCpu;
  boolean_T w_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  nvtxRangePushA("#fcn#resample#" MW_AT_LOCATION "#M100");
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_w);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&b_gpu_varargout_1);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_opts_x);
  w_outdatedOnGpu = false;
  y_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if ((cpu_varargin_1->size[0] == 1) || (cpu_varargin_1->size[1] == 1)) {
    opts_dim = 1;
  } else {
    opts_dim = 2;
    if (cpu_varargin_1->size[0] != 1) {
      opts_dim = 1;
    }
  }
  w_outdatedOnCpu = (cpu_varargin_1->size[0] == 1);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_opts_x, 2, &ge_emlrtRTEI, true);
  if (opts_dim == 1) {
    if ((cpu_varargin_1->size[0] == 1) || (cpu_varargin_1->size[1] == 1)) {
      if ((cpu_varargin_1->size[0] == 0) || (cpu_varargin_1->size[1] == 0)) {
        u1 = 0;
      } else {
        b_varargin_1 = cpu_varargin_1->size[0];
        u1 = cpu_varargin_1->size[1];
        if (b_varargin_1 >= u1) {
          u1 = b_varargin_1;
        }
      }
      i = cpu_opts_x->size[0] * cpu_opts_x->size[1];
      cpu_opts_x->size[0] = u1;
      cpu_opts_x->size[1] = 1;
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_opts_x, i, &ge_emlrtRTEI);
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(u1 - 1), &grid, &block,
                              2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_varargin_1, gpu_varargin_1,
                                   !*varargin_1_outdatedOnGpu);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_opts_x, &gpu_opts_x, true);
      if (*varargin_1_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal_T(gpu_varargin_1, cpu_varargin_1);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#resample_kernel24#" MW_AT_LINE);
        resample_kernel24<<<grid, block>>>(*gpu_varargin_1, u1 - 1, gpu_opts_x);
      }
    } else {
      i = cpu_opts_x->size[0] * cpu_opts_x->size[1];
      cpu_opts_x->size[0] = cpu_varargin_1->size[0];
      cpu_opts_x->size[1] = cpu_varargin_1->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_opts_x, i, &ge_emlrtRTEI);
      i = cpu_varargin_1->size[0] * cpu_varargin_1->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_varargin_1, gpu_varargin_1,
                                   !*varargin_1_outdatedOnGpu);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_opts_x, &gpu_opts_x, true);
      if (*varargin_1_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal_T(gpu_varargin_1, cpu_varargin_1);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#resample_kernel31#" MW_AT_LINE);
        resample_kernel31<<<grid, block>>>(*gpu_varargin_1, i, gpu_opts_x);
      }
    }
  } else {
    i = cpu_opts_x->size[0] * cpu_opts_x->size[1];
    cpu_opts_x->size[0] = cpu_varargin_1->size[1];
    cpu_opts_x->size[1] = cpu_varargin_1->size[0];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_opts_x, i, &ge_emlrtRTEI);
    i = cpu_varargin_1->size[0] - 1;
    b_varargin_1 = cpu_varargin_1->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i, b_varargin_1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_varargin_1, gpu_varargin_1,
                                 !*varargin_1_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_opts_x, &gpu_opts_x, true);
    if (*varargin_1_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(gpu_varargin_1, cpu_varargin_1);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#resample_kernel32#" MW_AT_LINE);
      resample_kernel32<<<grid, block>>>(*gpu_varargin_1, b_varargin_1, i,
                                         gpu_opts_x, cpu_opts_x->size[0U],
                                         cpu_varargin_1->size[0U]);
    }
  }
  x = varargin_2 / varargin_3;
  xin = x;
  absx = std::abs(x);
  if (std::isinf(absx) || std::isnan(absx)) {
    absx = rtNaN;
  } else if (absx < 4.4501477170144028E-308) {
    absx = 4.94065645841247E-324;
  } else {
    std::frexp(absx, &exponent);
    absx = std::ldexp(1.0, exponent - 53);
  }
  absx = std::fmax(1.0E-12, absx);
  if (std::isinf(x) || std::isnan(x)) {
    n = !std::isnan(x);
    absx = 0.0;
  } else {
    real_T d;
    real_T nlast;
    n = 1.0;
    d = 0.0;
    nlast = 0.0;
    dlast = 1.0;
    nvtxRangePushA("#loop#resample_whileloop_0##" MW_AT_LINE);
    real_T rndx;
    int32_T exitg1;
    do {
      exitg1 = 0;
      rndx = std::round(x);
      if (!std::isinf(x)) {
        real_T tmp;
        x -= rndx;
        tmp = nlast;
        nlast = n;
        n = n * rndx + tmp;
        tmp = dlast;
        dlast = d;
        d = d * rndx + tmp;
      } else {
        nlast = n;
        dlast = d;
        n = x;
        d = 0.0;
      }
      if ((x == 0.0) || (std::abs(n / d - xin) <= absx)) {
        exitg1 = 1;
      } else {
        x = 1.0 / x;
      }
    } while (exitg1 == 0);
    nvtxRangePop();
    if (std::isnan(d)) {
      x = rtNaN;
    } else if (d < 0.0) {
      x = -1.0;
    } else {
      x = (d > 0.0);
    }
    n /= x;
    absx = std::abs(d);
  }
  profileLoopStart("resample_loop_0", __LINE__, 1 + 1, "");
  for (i = 0; i < 2; i++) {
    varargin_1[i] = cpu_varargin_1->size[i];
  }
  profileLoopEnd();
  nvtxMarkA("#emxInitStruct_ResampleParser#" MW_AT_LINE);
  emxInitStruct_ResampleParser(&expl_temp, &ge_emlrtRTEI, true);
  nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
  gpuEmxMemcpyGpuToCpu_creal_T(cpu_opts_x, &gpu_opts_x);
  nvtxMarkA("#c_ResampleParser_createFilterAn#" MW_AT_LINE);
  b_signal::internal::resample::c_ResampleParser_createFilterAn(
      opts_dim, n, absx, varargin_1, w_outdatedOnCpu, cpu_opts_x, &expl_temp);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_opts_x);
  absx = expl_temp.p;
  n = expl_temp.q;
  if (expl_temp.dim == 1) {
    if (expl_temp.isRowVectorInput) {
      *varargout_1_outdatedOnCpu = false;
      *varargout_1_outdatedOnGpu = false;
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = expl_temp.x->size[0];
      cpu_varargout_1->size[1] = expl_temp.x->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &je_emlrtRTEI);
      profileLoopStart("resample_loop_3", __LINE__,
                       (expl_temp.x->size[0] * expl_temp.x->size[1] - 1) + 1,
                       "");
      for (i = 0; i < expl_temp.x->size[0] * expl_temp.x->size[1]; i++) {
        cpu_varargout_1->data[i] = expl_temp.x->data[i];
        *varargout_1_outdatedOnGpu = true;
      }
      profileLoopEnd();
      nvtxMarkA("#uniformResampleAlongFirstDim#" MW_AT_LINE);
      b_signal::internal::resample::uniformResampleAlongFirstDim(
          cpu_varargout_1, varargout_1_outdatedOnCpu, gpu_varargout_1,
          varargout_1_outdatedOnGpu, expl_temp.p, expl_temp.q,
          expl_temp.filterWithPadding, expl_temp.filterDelay);
      if ((cpu_varargout_1->size[0] == 0) || (cpu_varargout_1->size[1] == 0)) {
        u1 = 0;
      } else {
        b_varargin_1 = cpu_varargout_1->size[0];
        u1 = cpu_varargout_1->size[1];
        if (b_varargin_1 >= u1) {
          u1 = b_varargin_1;
        }
      }
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = 1;
      cpu_varargout_1->size[1] = u1;
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &ie_emlrtRTEI);
    } else {
      *varargout_1_outdatedOnCpu = false;
      *varargout_1_outdatedOnGpu = false;
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = expl_temp.x->size[0];
      cpu_varargout_1->size[1] = expl_temp.x->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &ie_emlrtRTEI);
      profileLoopStart("resample_loop_2", __LINE__,
                       (expl_temp.x->size[0] * expl_temp.x->size[1] - 1) + 1,
                       "");
      for (i = 0; i < expl_temp.x->size[0] * expl_temp.x->size[1]; i++) {
        cpu_varargout_1->data[i] = expl_temp.x->data[i];
        *varargout_1_outdatedOnGpu = true;
      }
      profileLoopEnd();
      nvtxMarkA("#uniformResampleAlongFirstDim#" MW_AT_LINE);
      b_signal::internal::resample::uniformResampleAlongFirstDim(
          cpu_varargout_1, varargout_1_outdatedOnCpu, gpu_varargout_1,
          varargout_1_outdatedOnGpu, expl_temp.p, expl_temp.q,
          expl_temp.filterWithPadding, expl_temp.filterDelay);
    }
  } else {
    boolean_T c_varargout_1_needsGpuEnsureCap;
    if (expl_temp.x->size[0] == 1) {
      dlast = std::ceil(expl_temp.p / expl_temp.q);
      *varargout_1_outdatedOnCpu = false;
      *varargout_1_outdatedOnGpu = false;
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = static_cast<int32_T>(dlast);
      cpu_varargout_1->size[1] = expl_temp.x->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &ke_emlrtRTEI);
      c_varargout_1_needsGpuEnsureCap = true;
      opts_dim = expl_temp.x->size[0] * expl_temp.x->size[1];
      if (opts_dim - 1 >= 0) {
        if ((static_cast<int32_T>(expl_temp.p) == 0) ||
            ((static_cast<int32_T>(expl_temp.p) > 0) &&
             (static_cast<int32_T>(expl_temp.p) < 1))) {
          i1 = 1;
          i2 = 0;
        } else {
          i1 = static_cast<int32_T>(expl_temp.p);
          i2 = static_cast<int32_T>(expl_temp.p);
        }
        Ly = std::ceil(
            (0.0 * expl_temp.p +
             static_cast<real_T>(expl_temp.filterWithPadding->size[0])) /
            expl_temp.q);
      }
      nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
      emxInit_creal_T(&yCol, 1, &pe_emlrtRTEI, true);
      nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
      emxInit_creal_T(&cpu_w, 1, &ne_emlrtRTEI, true);
      nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
      emxInit_creal_T(&cpu_y, 1, &ne_emlrtRTEI, true);
      nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
      emxInit_real_T(&b_cpu_y, 2, &qe_emlrtRTEI, true);
      profileLoopStart("resample_loop_4", __LINE__, (opts_dim - 1) + 1, "");
      for (exponent = 0; exponent < opts_dim; exponent++) {
        if (!(absx - 1.0 >= 0.0)) {
          y = nullptr;
          m = emlrtCreateCharArray(2, &iv[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
          emlrtAssign(&y, m);
          b_y = nullptr;
          m1 = emlrtCreateDoubleScalar(absx - 1.0);
          emlrtAssign(&b_y, m1);
          nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
          nvtxMarkA("#b_sprintf#" MW_AT_LINE);
          emlrt_marshallIn(b_sprintf(y, b_y, &f_emlrtMCI),
                           "<output of sprintf>", unusedExpr);
        }
        i = yCol->size[0];
        yCol->size[0] = static_cast<int32_T>(absx);
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(yCol, i, &me_emlrtRTEI);
        profileLoopStart("resample_loop_5", __LINE__,
                         (static_cast<int32_T>(absx) - 1) + 1, "");
        for (i = 0; i < static_cast<int32_T>(absx); i++) {
          yCol->data[i].re = 0.0;
          yCol->data[i].im = 0.0;
        }
        profileLoopEnd();
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        b_varargin_1 = div_s32(i2 - 1, i1) + 1;
        profileLoopStart("resample_loop_6", __LINE__, (b_varargin_1 - 1) + 1,
                         "");
        for (i = 0; i < b_varargin_1; i++) {
          yCol->data[i1 * i] = expl_temp.x->data[exponent];
        }
        profileLoopEnd();
        b_yCol = *yCol;
        b_expl_temp[0] = static_cast<int32_T>(absx);
        b_yCol.size = &b_expl_temp[0];
        b_yCol.numDimensions = 1;
        nvtxMarkA("#b_conv2#" MW_AT_LINE);
        b_conv2(&b_yCol, expl_temp.filterWithPadding, cpu_w, &w_outdatedOnCpu,
                &gpu_w, &w_outdatedOnGpu);
        if (!(n - 1.0 >= 0.0)) {
          c_y = nullptr;
          m2 = emlrtCreateCharArray(2, &iv1[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m2, &rfmt[0]);
          emlrtAssign(&c_y, m2);
          d_y = nullptr;
          m3 = emlrtCreateDoubleScalar(n - 1.0);
          emlrtAssign(&d_y, m3);
          nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
          nvtxMarkA("#b_sprintf#" MW_AT_LINE);
          emlrt_marshallIn(b_sprintf(c_y, d_y, &f_emlrtMCI),
                           "<output of sprintf>", unusedExpr);
        }
        if (n == 0.0) {
          b_varargin_1 = 1;
          u1 = -1;
        } else {
          b_varargin_1 = static_cast<int32_T>(n);
          u1 = cpu_w->size[0] - 1;
        }
        i = cpu_y->size[0];
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        cpu_y->size[0] = div_s32(u1, b_varargin_1) + 1;
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(cpu_y, i, &ne_emlrtRTEI);
        i = u1 / b_varargin_1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_w, &gpu_w, !w_outdatedOnGpu);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_y, &gpu_y, true);
        w_outdatedOnCpu = false;
        if (w_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_w, cpu_w);
        }
        w_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#resample_kernel25#" MW_AT_LINE);
          resample_kernel25<<<grid, block>>>(gpu_w, b_varargin_1, i, gpu_y);
        }
        nvtxMarkA("#div_s32#" MW_AT_LINE);
        if (!(div_s32(u1, b_varargin_1) + 1 < Ly)) {
          i = cpu_y->size[0];
          if (Ly < 1.0) {
            cpu_y->size[0] = 0;
          } else {
            cpu_y->size[0] = static_cast<int32_T>(Ly);
          }
          nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
          emxEnsureCapacity_creal_T(cpu_y, i, &oe_emlrtRTEI);
          w_outdatedOnCpu = true;
        }
        if (std::isnan(dlast)) {
          i = b_cpu_y->size[0] * b_cpu_y->size[1];
          b_cpu_y->size[0] = 1;
          b_cpu_y->size[1] = 1;
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(b_cpu_y, i, &ib_emlrtRTEI);
          nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
          y_needsGpuEnsureCapacity = false;
          nvtxMarkA("#resample_kernel26#" MW_AT_LINE);
          resample_kernel26<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_y);
        } else if (dlast < 1.0) {
          b_cpu_y->size[0] = 1;
          b_cpu_y->size[1] = 0;
        } else {
          i = b_cpu_y->size[0] * b_cpu_y->size[1];
          b_cpu_y->size[0] = 1;
          b_cpu_y->size[1] = static_cast<int32_T>(dlast - 1.0) + 1;
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(b_cpu_y, i, &ib_emlrtRTEI);
          nvtxMarkA("#computeNumIters#" MW_AT_LINE);
          mwGetLaunchParameters1D(
              computeNumIters(static_cast<int32_T>(dlast - 1.0)), &grid, &block,
              2147483647U);
          nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
          y_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            nvtxMarkA("#resample_kernel28#" MW_AT_LINE);
            resample_kernel28<<<grid, block>>>(
                static_cast<int32_T>(dlast - 1.0), b_gpu_y);
          }
        }
        b_varargin_1 = cpu_varargout_1->size[0];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(b_varargin_1 - 1), &grid,
                                &block, 2147483647U);
        if (w_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_creal_T(cpu_y, &gpu_y, true);
        }
        if (y_needsGpuEnsureCapacity) {
          nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
        }
        y_needsGpuEnsureCapacity = false;
        if (c_varargout_1_needsGpuEnsureCap) {
          nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_creal_T(cpu_varargout_1, gpu_varargout_1, true);
        }
        c_varargout_1_needsGpuEnsureCap = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#resample_kernel27#" MW_AT_LINE);
          resample_kernel27<<<grid, block>>>(
              gpu_y, b_gpu_y, expl_temp.filterDelay, exponent, b_varargin_1 - 1,
              *gpu_varargout_1, cpu_varargout_1->size[0U]);
        }
        *varargout_1_outdatedOnCpu = true;
      }
      profileLoopEnd();
      nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
      emxFree_real_T(&b_cpu_y);
      nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
      emxFree_creal_T(&cpu_y);
      nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
      emxFree_creal_T(&cpu_w);
      nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
      emxFree_creal_T(&yCol);
    } else {
      *varargout_1_outdatedOnCpu = false;
      *varargout_1_outdatedOnGpu = false;
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = expl_temp.x->size[0];
      cpu_varargout_1->size[1] = expl_temp.x->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &he_emlrtRTEI);
      profileLoopStart("resample_loop_1", __LINE__,
                       (expl_temp.x->size[0] * expl_temp.x->size[1] - 1) + 1,
                       "");
      for (i = 0; i < expl_temp.x->size[0] * expl_temp.x->size[1]; i++) {
        cpu_varargout_1->data[i] = expl_temp.x->data[i];
        *varargout_1_outdatedOnGpu = true;
      }
      profileLoopEnd();
      nvtxMarkA("#uniformResampleAlongFirstDim#" MW_AT_LINE);
      b_signal::internal::resample::uniformResampleAlongFirstDim(
          cpu_varargout_1, varargout_1_outdatedOnCpu, gpu_varargout_1,
          varargout_1_outdatedOnGpu, expl_temp.p, expl_temp.q,
          expl_temp.filterWithPadding, expl_temp.filterDelay);
      c_varargout_1_needsGpuEnsureCap = true;
    }
    if ((expl_temp.x->size[0] == 1) || (expl_temp.x->size[1] == 1)) {
      uint32_T outSize_idx_1;
      outSize_idx_1 = static_cast<uint32_T>(cpu_varargout_1->size[0]);
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = static_cast<int32_T>(expl_temp.inputSize[0]);
      cpu_varargout_1->size[1] = static_cast<int32_T>(outSize_idx_1);
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &ie_emlrtRTEI);
    } else {
      nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
      emxInit_creal_T(&b_cpu_varargout_1, 2, &le_emlrtRTEI, true);
      i = b_cpu_varargout_1->size[0] * b_cpu_varargout_1->size[1];
      b_cpu_varargout_1->size[0] = cpu_varargout_1->size[1];
      b_cpu_varargout_1->size[1] = cpu_varargout_1->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(b_cpu_varargout_1, i, &le_emlrtRTEI);
      i = cpu_varargout_1->size[0] - 1;
      b_varargin_1 = cpu_varargout_1->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i, b_varargin_1), &grid, &block,
                              2147483647U);
      if (c_varargout_1_needsGpuEnsureCap) {
        nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal_T(cpu_varargout_1, gpu_varargout_1,
                                     !*varargout_1_outdatedOnGpu);
      }
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(b_cpu_varargout_1, &b_gpu_varargout_1, true);
      if (*varargout_1_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal_T(gpu_varargout_1, cpu_varargout_1);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#resample_kernel29#" MW_AT_LINE);
        resample_kernel29<<<grid, block>>>(
            *gpu_varargout_1, b_varargin_1, i, b_gpu_varargout_1,
            b_cpu_varargout_1->size[0U], cpu_varargout_1->size[0U]);
      }
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = b_cpu_varargout_1->size[0];
      cpu_varargout_1->size[1] = b_cpu_varargout_1->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &ie_emlrtRTEI);
      i = b_cpu_varargout_1->size[0] * b_cpu_varargout_1->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal_T(cpu_varargout_1, gpu_varargout_1, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#resample_kernel30#" MW_AT_LINE);
        resample_kernel30<<<grid, block>>>(b_gpu_varargout_1, i,
                                           *gpu_varargout_1);
      }
      *varargout_1_outdatedOnGpu = false;
      *varargout_1_outdatedOnCpu = true;
      nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
      emxFree_creal_T(&b_cpu_varargout_1);
    }
  }
  nvtxMarkA("#emxFreeStruct_ResampleParser#" MW_AT_LINE);
  emxFreeStruct_ResampleParser(&expl_temp);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_opts_x);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&b_gpu_varargout_1);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_w);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_y);
  *varargin_1_outdatedOnGpu = false;
  nvtxRangePop();
}

} // namespace coder

// End of code generation (resample.cu)
