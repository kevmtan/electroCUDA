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
#include "conv2.h"
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "firls.h"
#include "kaiser.h"
#include "mod.h"
#include "rat.h"
#include "rt_nonfinite.h"
#include "uniformResampleKernel.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "math_constants.h"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo hg_emlrtRTEI{
    161,                                                        // lineNo
    9,                                                          // colNo
    "resample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/resample.m" // pName
};

// Function Declarations
static __global__ void resample_kernel71(const emxArray_creal_T varargin_1,
                                         const int32_T b,
                                         emxArray_creal_T varargout_1);

static __global__ void resample_kernel72(const emxArray_real_T r,
                                         const int32_T b_r,
                                         emxArray_real_T b_dv);

static __global__ void resample_kernel73(const emxArray_real_T b_dv1,
                                         const emxArray_real_T b_dv,
                                         const int32_T c_dv,
                                         emxArray_real_T h1);

static __global__ void resample_kernel74(const real_T pqmax,
                                         const emxArray_real_T h1,
                                         const real_T opts_p,
                                         const int32_T b_h1,
                                         emxArray_real_T opts_filter);

static __global__ void resample_kernel75(const int32_T nZeroBegin,
                                         emxArray_real_T h);

static __global__ void resample_kernel76(const emxArray_uint32_T y,
                                         const real_T nZeroBegin,
                                         const int32_T b_y,
                                         emxArray_int32_T iv);

static __global__ void resample_kernel77(const emxArray_real_T opts_filter,
                                         const emxArray_int32_T iv,
                                         const int32_T b_iv, emxArray_real_T h);

static __global__ void resample_kernel78(const emxArray_creal_T varargout_1,
                                         const int32_T b_varargout_1,
                                         emxArray_creal_T b_y1);

static __global__ void resample_kernel79(const emxArray_creal_T b_y1,
                                         const int32_T b,
                                         emxArray_creal_T varargout_1);

static __global__ void resample_kernel80(const emxArray_creal_T w,
                                         const int32_T vlen, const int32_T b,
                                         emxArray_creal_T y);

static __global__ void resample_kernel81(emxArray_real_T y);

static __global__ void
resample_kernel82(const emxArray_creal_T y, const emxArray_real_T b_y,
                  const real_T opts_filterDelay, const int32_T ii,
                  const int32_T b, emxArray_creal_T b_y1, int32_T y1_dim0);

static __global__ void resample_kernel83(const int32_T b, emxArray_real_T y);

static __global__ void resample_kernel84(const emxArray_creal_T b_y1,
                                         const int32_T varargin_1,
                                         emxArray_creal_T varargout_1);

static __global__ void resample_kernel85(const emxArray_creal_T b_y1,
                                         const int32_T c_y1, const int32_T d_y1,
                                         emxArray_creal_T varargout_1,
                                         int32_T varargout_1_dim0,
                                         int32_T y1_dim0);

static __global__ void resample_kernel86(const emxArray_creal_T varargout_1,
                                         const int32_T b_varargout_1,
                                         emxArray_creal_T b_y1);

static __global__ void resample_kernel87(const int32_T b, emxArray_uint32_T y);

static __global__ void resample_kernel88(const emxArray_creal_T varargin_1,
                                         const int32_T b_varargin_1,
                                         emxArray_creal_T varargout_1);

static __global__ void
resample_kernel89(const emxArray_creal_T varargin_1, const int32_T b_varargin_1,
                  const int32_T c_varargin_1, emxArray_creal_T varargout_1,
                  int32_T varargout_1_dim0, int32_T varargin_1_dim0);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void resample_kernel71(
    const emxArray_creal_T varargin_1, const int32_T b,
    emxArray_creal_T varargout_1)
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
    varargout_1.data[i1] = varargin_1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel72(
    const emxArray_real_T r, const int32_T b_r, emxArray_real_T b_dv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_r);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    b_dv.data[i1] = r.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel73(
    const emxArray_real_T b_dv1, const emxArray_real_T b_dv, const int32_T c_dv,
    emxArray_real_T h1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_dv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    h1.data[i1] = b_dv.data[i1] * b_dv1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel74(
    const real_T pqmax, const emxArray_real_T h1, const real_T opts_p,
    const int32_T b_h1, emxArray_real_T opts_filter)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_h1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    opts_filter.data[i1] = opts_p * h1.data[i1] / pqmax;
  }
}

static __global__
    __launch_bounds__(1024, 1) void resample_kernel75(const int32_T nZeroBegin,
                                                      emxArray_real_T h)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nZeroBegin);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    h.data[i1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel76(
    const emxArray_uint32_T y, const real_T nZeroBegin, const int32_T b_y,
    emxArray_int32_T iv)
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
    iv.data[i1] =
        static_cast<int32_T>(nZeroBegin + static_cast<real_T>(y.data[i1]));
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel77(
    const emxArray_real_T opts_filter, const emxArray_int32_T iv,
    const int32_T b_iv, emxArray_real_T h)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_iv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    h.data[iv.data[i1] - 1] = opts_filter.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel78(
    const emxArray_creal_T varargout_1, const int32_T b_varargout_1,
    emxArray_creal_T b_y1)
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
    b_y1.data[i1] = varargout_1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel79(
    const emxArray_creal_T b_y1, const int32_T b, emxArray_creal_T varargout_1)
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
    varargout_1.data[i1] = b_y1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel80(
    const emxArray_creal_T w, const int32_T vlen, const int32_T b,
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
    y.data[i1] = w.data[vlen * i1];
  }
}

static __global__ __launch_bounds__(32,
                                    1) void resample_kernel81(emxArray_real_T y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel82(
    const emxArray_creal_T y, const emxArray_real_T b_y,
    const real_T opts_filterDelay, const int32_T ii, const int32_T b,
    emxArray_creal_T b_y1, int32_T y1_dim0)
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
    b_y1.data[i1 + y1_dim0 * ii] =
        y.data[static_cast<int32_T>(opts_filterDelay + b_y.data[i1]) - 1];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void resample_kernel83(const int32_T b,
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

static __global__ __launch_bounds__(1024, 1) void resample_kernel84(
    const emxArray_creal_T b_y1, const int32_T varargin_1,
    emxArray_creal_T varargout_1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(varargin_1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    varargout_1.data[i1] = b_y1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel85(
    const emxArray_creal_T b_y1, const int32_T c_y1, const int32_T d_y1,
    emxArray_creal_T varargout_1, int32_T varargout_1_dim0, int32_T y1_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(d_y1) + 1UL) *
                (static_cast<uint64_T>(c_y1) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(c_y1) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(c_y1) + 1UL));
    varargout_1.data[k + varargout_1_dim0 * i1] = b_y1.data[i1 + y1_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel86(
    const emxArray_creal_T varargout_1, const int32_T b_varargout_1,
    emxArray_creal_T b_y1)
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
    b_y1.data[i1] = varargout_1.data[i1];
  }
}

static __global__
    __launch_bounds__(1024, 1) void resample_kernel87(const int32_T b,
                                                      emxArray_uint32_T y)
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
    y.data[i1] = static_cast<uint32_T>(i1) + 1U;
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel88(
    const emxArray_creal_T varargin_1, const int32_T b_varargin_1,
    emxArray_creal_T varargout_1)
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
    varargout_1.data[i1] = varargin_1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel89(
    const emxArray_creal_T varargin_1, const int32_T b_varargin_1,
    const int32_T c_varargin_1, emxArray_creal_T varargout_1,
    int32_T varargout_1_dim0, int32_T varargin_1_dim0)
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_varargin_1) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_varargin_1) + 1UL));
    varargout_1.data[k + varargout_1_dim0 * i1] =
        varargin_1.data[i1 + varargin_1_dim0 * k];
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
  static const int32_T iv1[2]{1, 7};
  static const int32_T iv2[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  dim3 block;
  dim3 grid;
  emxArray_creal_T b_gpu_y;
  emxArray_creal_T b_yCol;
  emxArray_creal_T gpu_w;
  emxArray_creal_T gpu_y1;
  emxArray_creal_T *b_cpu_y;
  emxArray_creal_T *cpu_w;
  emxArray_creal_T *cpu_y1;
  emxArray_creal_T *yCol;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T *cpu_iv;
  emxArray_real_T c_gpu_y;
  emxArray_real_T gpu_dv;
  emxArray_real_T gpu_dv1;
  emxArray_real_T gpu_h;
  emxArray_real_T gpu_h1;
  emxArray_real_T gpu_opts_filter;
  emxArray_real_T gpu_r;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_dv;
  emxArray_real_T *cpu_dv1;
  emxArray_real_T *cpu_h;
  emxArray_real_T *cpu_h1;
  emxArray_real_T *cpu_opts_filter;
  emxArray_real_T *cpu_r;
  emxArray_uint32_T gpu_y;
  emxArray_uint32_T *cpu_y;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *y;
  real_T b_dv[4];
  real_T Ly;
  real_T fc;
  real_T nZeroBegin;
  real_T opts_filterDelay;
  real_T opts_p;
  real_T opts_q;
  real_T pqmax;
  int32_T varargout_1[1];
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T opts_dim;
  int32_T u1;
  int32_T varargin_1;
  int32_T vlen;
  uint32_T outSize_idx_1;
  char_T unusedExpr[23];
  boolean_T b_y_needsGpuEnsureCapacity;
  boolean_T h_outdatedOnCpu;
  boolean_T h_outdatedOnGpu;
  boolean_T opts_isRowVectorInput;
  boolean_T validLaunchParams;
  boolean_T w_outdatedOnCpu;
  boolean_T w_outdatedOnGpu;
  boolean_T y1_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_creal_T(&b_gpu_y);
  gpuEmxReset_creal_T(&gpu_w);
  gpuEmxReset_creal_T(&gpu_y1);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_uint32_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_h);
  gpuEmxReset_real_T(&gpu_opts_filter);
  gpuEmxReset_real_T(&gpu_h1);
  gpuEmxReset_real_T(&gpu_dv1);
  gpuEmxReset_real_T(&gpu_dv);
  gpuEmxReset_real_T(&gpu_r);
  w_outdatedOnGpu = false;
  b_y_needsGpuEnsureCapacity = true;
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
  opts_isRowVectorInput = (cpu_varargin_1->size[0] == 1);
  if (opts_dim == 1) {
    if ((cpu_varargin_1->size[0] == 1) || (cpu_varargin_1->size[1] == 1)) {
      if ((cpu_varargin_1->size[0] == 0) || (cpu_varargin_1->size[1] == 0)) {
        u1 = 0;
      } else {
        vlen = cpu_varargin_1->size[0];
        u1 = cpu_varargin_1->size[1];
        if (vlen >= u1) {
          u1 = vlen;
        }
      }
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = u1;
      cpu_varargout_1->size[1] = 1;
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &g_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(u1 - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_creal_T(cpu_varargin_1, gpu_varargin_1,
                                   !*varargin_1_outdatedOnGpu);
      gpuEmxEnsureCapacity_creal_T(cpu_varargout_1, gpu_varargout_1, true);
      if (*varargin_1_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(gpu_varargin_1, cpu_varargin_1);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        resample_kernel71<<<grid, block>>>(*gpu_varargin_1, u1 - 1,
                                           *gpu_varargout_1);
      }
      *varargout_1_outdatedOnGpu = false;
      *varargout_1_outdatedOnCpu = true;
    } else {
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = cpu_varargin_1->size[0];
      cpu_varargout_1->size[1] = cpu_varargin_1->size[1];
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &g_emlrtRTEI);
      i = cpu_varargin_1->size[0] * cpu_varargin_1->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal_T(cpu_varargin_1, gpu_varargin_1,
                                   !*varargin_1_outdatedOnGpu);
      gpuEmxEnsureCapacity_creal_T(cpu_varargout_1, gpu_varargout_1, true);
      if (*varargin_1_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(gpu_varargin_1, cpu_varargin_1);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        resample_kernel88<<<grid, block>>>(*gpu_varargin_1, i,
                                           *gpu_varargout_1);
      }
      *varargout_1_outdatedOnGpu = false;
      *varargout_1_outdatedOnCpu = true;
    }
  } else {
    i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
    cpu_varargout_1->size[0] = cpu_varargin_1->size[1];
    cpu_varargout_1->size[1] = cpu_varargin_1->size[0];
    emxEnsureCapacity_creal_T(cpu_varargout_1, i, &g_emlrtRTEI);
    i = cpu_varargin_1->size[0] - 1;
    varargin_1 = cpu_varargin_1->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i, varargin_1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_creal_T(cpu_varargin_1, gpu_varargin_1,
                                 !*varargin_1_outdatedOnGpu);
    gpuEmxEnsureCapacity_creal_T(cpu_varargout_1, gpu_varargout_1, true);
    if (*varargin_1_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_creal_T(gpu_varargin_1, cpu_varargin_1);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      resample_kernel89<<<grid, block>>>(
          *gpu_varargin_1, varargin_1, i, *gpu_varargout_1,
          cpu_varargout_1->size[0U], cpu_varargin_1->size[0U]);
    }
    *varargout_1_outdatedOnGpu = false;
    *varargout_1_outdatedOnCpu = true;
  }
  opts_p = rat(varargin_2 / varargin_3, &opts_q);
  pqmax = std::fmax(opts_p, opts_q);
  fc = 0.5 / pqmax;
  pqmax = 20.0 * pqmax + 1.0;
  b_dv[0] = 0.0;
  b_dv[1] = 2.0 * fc;
  b_dv[2] = 2.0 * fc;
  b_dv[3] = 1.0;
  emxInit_real_T(&cpu_r, 2, &k_emlrtRTEI, true);
  firls(pqmax - 1.0, b_dv, cpu_r);
  emxInit_real_T(&cpu_dv, 1, &k_emlrtRTEI, true);
  i = cpu_dv->size[0];
  cpu_dv->size[0] = cpu_r->size[1];
  emxEnsureCapacity_real_T(cpu_dv, i, &k_emlrtRTEI);
  i = cpu_r->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_r, &gpu_r, false);
  gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
  gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, cpu_r);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    resample_kernel72<<<grid, block>>>(gpu_r, i, gpu_dv);
  }
  emxFree_real_T(&cpu_r);
  emxInit_real_T(&cpu_dv1, 1, &k_emlrtRTEI, true);
  kaiser(pqmax, cpu_dv1);
  emxInit_real_T(&cpu_h1, 1, &l_emlrtRTEI, true);
  i = cpu_h1->size[0];
  cpu_h1->size[0] = cpu_dv->size[0];
  emxEnsureCapacity_real_T(cpu_h1, i, &l_emlrtRTEI);
  varargin_1 = cpu_dv->size[0] - 1;
  mwGetLaunchParameters1D(computeNumIters(varargin_1), &grid, &block,
                          2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1, false);
  gpuEmxEnsureCapacity_real_T(cpu_h1, &gpu_h1, true);
  w_outdatedOnCpu = false;
  gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, cpu_dv1);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    resample_kernel73<<<grid, block>>>(gpu_dv1, gpu_dv, varargin_1, gpu_h1);
  }
  emxFree_real_T(&cpu_dv1);
  emxFree_real_T(&cpu_dv);
  vlen = cpu_h1->size[0];
  if (cpu_h1->size[0] == 0) {
    pqmax = 0.0;
  } else {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_h1, &gpu_h1);
    pqmax = cpu_h1->data[0];
    w_outdatedOnCpu = true;
    for (varargin_1 = 0; varargin_1 <= vlen - 2; varargin_1++) {
      pqmax += cpu_h1->data[varargin_1 + 1];
    }
  }
  emxInit_real_T(&cpu_opts_filter, 1, &g_emlrtRTEI, true);
  i = cpu_opts_filter->size[0];
  cpu_opts_filter->size[0] = cpu_h1->size[0];
  emxEnsureCapacity_real_T(cpu_opts_filter, i, &g_emlrtRTEI);
  i = cpu_h1->size[0] - 1;
  mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
  if (w_outdatedOnCpu) {
    gpuEmxEnsureCapacity_real_T(cpu_h1, &gpu_h1, true);
  }
  gpuEmxEnsureCapacity_real_T(cpu_opts_filter, &gpu_opts_filter, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    resample_kernel74<<<grid, block>>>(pqmax, gpu_h1, opts_p, i,
                                       gpu_opts_filter);
  }
  emxFree_real_T(&cpu_h1);
  pqmax = (static_cast<real_T>(cpu_opts_filter->size[0]) - 1.0) / 2.0;
  nZeroBegin = std::floor(opts_q - b_mod(pqmax, opts_q));
  opts_filterDelay = std::floor(std::ceil(pqmax + nZeroBegin) / opts_q);
  pqmax = static_cast<real_T>(cpu_opts_filter->size[0]) + nZeroBegin;
  fc = 0.0;
  vlen = cpu_varargout_1->size[0];
  while (std::ceil((((static_cast<real_T>(vlen) - 1.0) * opts_p + pqmax) + fc) /
                   opts_q) -
             opts_filterDelay <
         std::ceil(static_cast<real_T>(vlen) * opts_p / opts_q)) {
    fc++;
  }
  emxInit_real_T(&cpu_h, 1, &m_emlrtRTEI, true);
  i = cpu_h->size[0];
  cpu_h->size[0] = static_cast<int32_T>(
      (nZeroBegin + static_cast<real_T>(cpu_opts_filter->size[0])) + fc);
  emxEnsureCapacity_real_T(cpu_h, i, &m_emlrtRTEI);
  i = static_cast<int32_T>(
          (nZeroBegin + static_cast<real_T>(cpu_opts_filter->size[0])) + fc) -
      1;
  mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_h, &gpu_h, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    resample_kernel75<<<grid, block>>>(i, gpu_h);
  }
  emxInit_uint32_T(&cpu_y, 2, &ab_emlrtRTEI, true);
  if (cpu_opts_filter->size[0] < 1) {
    cpu_y->size[0] = 1;
    cpu_y->size[1] = 0;
  } else {
    outSize_idx_1 = static_cast<uint32_T>(cpu_opts_filter->size[0]);
    i = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = 1;
    cpu_y->size[1] = cpu_opts_filter->size[0];
    emxEnsureCapacity_uint32_T(cpu_y, i, &n_emlrtRTEI);
    mwGetLaunchParameters1D(
        computeNumIters(static_cast<int32_T>(outSize_idx_1) - 1), &grid, &block,
        2147483647U);
    gpuEmxEnsureCapacity_uint32_T(cpu_y, &gpu_y, true);
    y_needsGpuEnsureCapacity = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      resample_kernel87<<<grid, block>>>(
          static_cast<int32_T>(outSize_idx_1) - 1, gpu_y);
    }
  }
  emxInit_int32_T(&cpu_iv, 2, &bb_emlrtRTEI, true);
  i = cpu_iv->size[0] * cpu_iv->size[1];
  cpu_iv->size[0] = 1;
  cpu_iv->size[1] = cpu_y->size[1];
  emxEnsureCapacity_int32_T(cpu_iv, i, &o_emlrtRTEI);
  i = cpu_y->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
  if (y_needsGpuEnsureCapacity) {
    gpuEmxEnsureCapacity_uint32_T(cpu_y, &gpu_y, true);
  }
  gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    resample_kernel76<<<grid, block>>>(gpu_y, nZeroBegin, i, gpu_iv);
  }
  emxFree_uint32_T(&cpu_y);
  i = cpu_iv->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    resample_kernel77<<<grid, block>>>(gpu_opts_filter, gpu_iv, i, gpu_h);
  }
  h_outdatedOnGpu = false;
  h_outdatedOnCpu = true;
  emxFree_int32_T(&cpu_iv);
  emxFree_real_T(&cpu_opts_filter);
  emxInit_creal_T(&cpu_y1, 2, &cb_emlrtRTEI, true);
  if (opts_dim == 1) {
    if (opts_isRowVectorInput) {
      i = cpu_y1->size[0] * cpu_y1->size[1];
      cpu_y1->size[0] = cpu_varargout_1->size[0];
      cpu_y1->size[1] = cpu_varargout_1->size[1];
      emxEnsureCapacity_creal_T(cpu_y1, i, &r_emlrtRTEI);
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal_T(cpu_y1, &gpu_y1, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        resample_kernel78<<<grid, block>>>(*gpu_varargout_1, i, gpu_y1);
      }
      y1_outdatedOnGpu = false;
      w_outdatedOnCpu = true;
      b_signal::internal::resample::b_uniformResampleAlongFirstDim(
          cpu_y1, &w_outdatedOnCpu, &gpu_y1, &y1_outdatedOnGpu, opts_p, opts_q,
          cpu_h, &h_outdatedOnCpu, &gpu_h, &h_outdatedOnGpu, opts_filterDelay);
      if ((cpu_y1->size[0] == 0) || (cpu_y1->size[1] == 0)) {
        u1 = 0;
      } else {
        vlen = cpu_y1->size[0];
        u1 = cpu_y1->size[1];
        if (vlen >= u1) {
          u1 = vlen;
        }
      }
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = 1;
      cpu_varargout_1->size[1] = u1;
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &hg_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(u1 - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_creal_T(cpu_y1, &gpu_y1, !y1_outdatedOnGpu);
      gpuEmxEnsureCapacity_creal_T(cpu_varargout_1, gpu_varargout_1, true);
      if (y1_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_y1, cpu_y1);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        resample_kernel79<<<grid, block>>>(gpu_y1, u1 - 1, *gpu_varargout_1);
      }
    } else {
      b_signal::internal::resample::b_uniformResampleAlongFirstDim(
          cpu_varargout_1, varargout_1_outdatedOnCpu, gpu_varargout_1,
          varargout_1_outdatedOnGpu, opts_p, opts_q, cpu_h, &h_outdatedOnCpu,
          &gpu_h, &h_outdatedOnGpu, opts_filterDelay);
    }
  } else {
    if (cpu_varargout_1->size[0] == 1) {
      pqmax = std::ceil(opts_p / opts_q);
      y1_outdatedOnGpu = false;
      i = cpu_y1->size[0] * cpu_y1->size[1];
      cpu_y1->size[0] = static_cast<int32_T>(pqmax);
      cpu_y1->size[1] = cpu_varargout_1->size[1];
      emxEnsureCapacity_creal_T(cpu_y1, i, &s_emlrtRTEI);
      opts_isRowVectorInput = true;
      opts_dim = cpu_varargout_1->size[1];
      if (cpu_varargout_1->size[1] - 1 >= 0) {
        if ((static_cast<int32_T>(opts_p) == 0) ||
            ((static_cast<int32_T>(opts_p) > 0) &&
             (static_cast<int32_T>(opts_p) < 1))) {
          i1 = 1;
          i2 = 0;
        } else {
          i1 = static_cast<int32_T>(opts_p);
          i2 = static_cast<int32_T>(opts_p);
        }
        Ly = std::ceil((0.0 * opts_p + static_cast<real_T>(cpu_h->size[0])) /
                       opts_q);
      }
      emxInit_creal_T(&yCol, 1, &db_emlrtRTEI, true);
      emxInit_creal_T(&cpu_w, 1, &v_emlrtRTEI, true);
      emxInit_creal_T(&b_cpu_y, 1, &v_emlrtRTEI, true);
      emxInit_real_T(&c_cpu_y, 2, &eb_emlrtRTEI, true);
      for (int32_T ii{0}; ii < opts_dim; ii++) {
        if (!(opts_p - 1.0 >= 0.0)) {
          y = nullptr;
          m = emlrtCreateCharArray(2, &iv1[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
          emlrtAssign(&y, m);
          b_y = nullptr;
          m1 = emlrtCreateDoubleScalar(opts_p - 1.0);
          emlrtAssign(&b_y, m1);
          emlrt_marshallIn(b_sprintf(y, b_y, &emlrtMCI), "<output of sprintf>",
                           unusedExpr);
        }
        i = yCol->size[0];
        yCol->size[0] = static_cast<int32_T>(opts_p);
        emxEnsureCapacity_creal_T(yCol, i, &t_emlrtRTEI);
        for (varargin_1 = 0; varargin_1 < static_cast<int32_T>(opts_p);
             varargin_1++) {
          yCol->data[varargin_1].re = 0.0;
          yCol->data[varargin_1].im = 0.0;
        }
        vlen = div_s32(i2 - 1, i1) + 1;
        for (varargin_1 = 0; varargin_1 < vlen; varargin_1++) {
          if (*varargout_1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_creal_T(cpu_varargout_1, gpu_varargout_1);
          }
          *varargout_1_outdatedOnCpu = false;
          yCol->data[i1 * varargin_1] = cpu_varargout_1->data[ii];
        }
        b_yCol = *yCol;
        varargout_1[0] = static_cast<int32_T>(opts_p);
        b_yCol.size = &varargout_1[0];
        b_yCol.numDimensions = 1;
        d_conv2(&b_yCol, cpu_h, &h_outdatedOnCpu, &gpu_h, &h_outdatedOnGpu,
                cpu_w, &w_outdatedOnCpu, &gpu_w, &w_outdatedOnGpu);
        if (!(opts_q - 1.0 >= 0.0)) {
          c_y = nullptr;
          m2 = emlrtCreateCharArray(2, &iv2[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m2, &rfmt[0]);
          emlrtAssign(&c_y, m2);
          d_y = nullptr;
          m3 = emlrtCreateDoubleScalar(opts_q - 1.0);
          emlrtAssign(&d_y, m3);
          emlrt_marshallIn(b_sprintf(c_y, d_y, &emlrtMCI),
                           "<output of sprintf>", unusedExpr);
        }
        if (opts_q == 0.0) {
          vlen = 1;
          u1 = -1;
        } else {
          vlen = static_cast<int32_T>(opts_q);
          u1 = cpu_w->size[0] - 1;
        }
        i = b_cpu_y->size[0];
        b_cpu_y->size[0] = div_s32(u1, vlen) + 1;
        emxEnsureCapacity_creal_T(b_cpu_y, i, &v_emlrtRTEI);
        varargin_1 = u1 / vlen;
        mwGetLaunchParameters1D(computeNumIters(varargin_1), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_creal_T(cpu_w, &gpu_w, !w_outdatedOnGpu);
        gpuEmxEnsureCapacity_creal_T(b_cpu_y, &b_gpu_y, true);
        y_needsGpuEnsureCapacity = false;
        if (w_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_w, cpu_w);
        }
        w_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          resample_kernel80<<<grid, block>>>(gpu_w, vlen, varargin_1, b_gpu_y);
        }
        if (!(div_s32(u1, vlen) + 1 < Ly)) {
          i = b_cpu_y->size[0];
          if (Ly < 1.0) {
            b_cpu_y->size[0] = 0;
          } else {
            b_cpu_y->size[0] = static_cast<int32_T>(Ly);
          }
          emxEnsureCapacity_creal_T(b_cpu_y, i, &w_emlrtRTEI);
          y_needsGpuEnsureCapacity = true;
        }
        if (std::isnan(pqmax)) {
          i = c_cpu_y->size[0] * c_cpu_y->size[1];
          c_cpu_y->size[0] = 1;
          c_cpu_y->size[1] = 1;
          emxEnsureCapacity_real_T(c_cpu_y, i, &n_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_cpu_y, &c_gpu_y, true);
          b_y_needsGpuEnsureCapacity = false;
          resample_kernel81<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(c_gpu_y);
        } else if (pqmax < 1.0) {
          c_cpu_y->size[0] = 1;
          c_cpu_y->size[1] = 0;
        } else {
          i = c_cpu_y->size[0] * c_cpu_y->size[1];
          c_cpu_y->size[0] = 1;
          c_cpu_y->size[1] = static_cast<int32_T>(pqmax - 1.0) + 1;
          emxEnsureCapacity_real_T(c_cpu_y, i, &n_emlrtRTEI);
          mwGetLaunchParameters1D(
              computeNumIters(static_cast<int32_T>(pqmax - 1.0)), &grid, &block,
              2147483647U);
          gpuEmxEnsureCapacity_real_T(c_cpu_y, &c_gpu_y, true);
          b_y_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            resample_kernel83<<<grid, block>>>(
                static_cast<int32_T>(pqmax - 1.0), c_gpu_y);
          }
        }
        vlen = cpu_y1->size[0];
        mwGetLaunchParameters1D(computeNumIters(vlen - 1), &grid, &block,
                                2147483647U);
        if (y_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_creal_T(b_cpu_y, &b_gpu_y, true);
        }
        if (b_y_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real_T(c_cpu_y, &c_gpu_y, true);
        }
        b_y_needsGpuEnsureCapacity = false;
        if (opts_isRowVectorInput) {
          gpuEmxEnsureCapacity_creal_T(cpu_y1, &gpu_y1, true);
        }
        opts_isRowVectorInput = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          resample_kernel82<<<grid, block>>>(b_gpu_y, c_gpu_y, opts_filterDelay,
                                             ii, vlen - 1, gpu_y1,
                                             cpu_y1->size[0U]);
        }
      }
      emxFree_real_T(&c_cpu_y);
      emxFree_creal_T(&b_cpu_y);
      emxFree_creal_T(&cpu_w);
      emxFree_creal_T(&yCol);
    } else {
      i = cpu_y1->size[0] * cpu_y1->size[1];
      cpu_y1->size[0] = cpu_varargout_1->size[0];
      cpu_y1->size[1] = cpu_varargout_1->size[1];
      emxEnsureCapacity_creal_T(cpu_y1, i, &p_emlrtRTEI);
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal_T(cpu_y1, &gpu_y1, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        resample_kernel86<<<grid, block>>>(*gpu_varargout_1, i, gpu_y1);
      }
      y1_outdatedOnGpu = false;
      w_outdatedOnCpu = true;
      b_signal::internal::resample::b_uniformResampleAlongFirstDim(
          cpu_y1, &w_outdatedOnCpu, &gpu_y1, &y1_outdatedOnGpu, opts_p, opts_q,
          cpu_h, &h_outdatedOnCpu, &gpu_h, &h_outdatedOnGpu, opts_filterDelay);
      opts_isRowVectorInput = true;
    }
    if ((cpu_varargout_1->size[0] == 1) || (cpu_varargout_1->size[1] == 1)) {
      outSize_idx_1 = static_cast<uint32_T>(cpu_y1->size[0]);
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = cpu_varargin_1->size[0];
      cpu_varargout_1->size[1] = cpu_y1->size[0];
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &hg_emlrtRTEI);
      i = cpu_varargin_1->size[0] * static_cast<int32_T>(outSize_idx_1) - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      if (opts_isRowVectorInput) {
        gpuEmxEnsureCapacity_creal_T(cpu_y1, &gpu_y1, !y1_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_creal_T(cpu_varargout_1, gpu_varargout_1, true);
      if (y1_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_y1, cpu_y1);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        resample_kernel84<<<grid, block>>>(gpu_y1, i, *gpu_varargout_1);
      }
      *varargout_1_outdatedOnCpu = true;
    } else {
      i = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
      cpu_varargout_1->size[0] = cpu_y1->size[1];
      cpu_varargout_1->size[1] = cpu_y1->size[0];
      emxEnsureCapacity_creal_T(cpu_varargout_1, i, &hg_emlrtRTEI);
      i = cpu_y1->size[0] - 1;
      varargin_1 = cpu_y1->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(i, varargin_1), &grid, &block,
                              2147483647U);
      if (opts_isRowVectorInput) {
        gpuEmxEnsureCapacity_creal_T(cpu_y1, &gpu_y1, !y1_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_creal_T(cpu_varargout_1, gpu_varargout_1, true);
      if (y1_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_y1, cpu_y1);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        resample_kernel85<<<grid, block>>>(
            gpu_y1, varargin_1, i, *gpu_varargout_1, cpu_varargout_1->size[0U],
            cpu_y1->size[0U]);
      }
      *varargout_1_outdatedOnCpu = true;
    }
  }
  emxFree_creal_T(&cpu_y1);
  emxFree_real_T(&cpu_h);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&gpu_r);
  gpuEmxFree_real_T(&gpu_dv);
  gpuEmxFree_real_T(&gpu_dv1);
  gpuEmxFree_real_T(&gpu_h1);
  gpuEmxFree_real_T(&gpu_opts_filter);
  gpuEmxFree_real_T(&gpu_h);
  gpuEmxFree_uint32_T(&gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_creal_T(&gpu_y1);
  gpuEmxFree_creal_T(&gpu_w);
  gpuEmxFree_creal_T(&b_gpu_y);
  gpuEmxFree_real_T(&c_gpu_y);
  *varargin_1_outdatedOnGpu = false;
}

} // namespace coder

// End of code generation (resample.cu)
