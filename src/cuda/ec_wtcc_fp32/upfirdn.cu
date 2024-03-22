//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// upfirdn.cu
//
// Code generation for function 'upfirdn'
//

// Include files
#include "upfirdn.h"
#include "circshift.h"
#include "conv2.h"
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo pf_emlrtRTEI{
    49,                                                     // lineNo
    5,                                                      // colNo
    "upfirdn",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/upfirdn.m" // pName
};

static emlrtRTEInfo qf_emlrtRTEI{
    47,                                                     // lineNo
    5,                                                      // colNo
    "upfirdn",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/upfirdn.m" // pName
};

static emlrtRTEInfo rf_emlrtRTEI{
    71,                                                     // lineNo
    9,                                                      // colNo
    "upfirdn",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/upfirdn.m" // pName
};

static emlrtRTEInfo sf_emlrtRTEI{
    91,                                                           // lineNo
    14,                                                           // colNo
    "downsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/downsample.m" // pName
};

static emlrtRTEInfo tf_emlrtRTEI{
    83,                                                     // lineNo
    13,                                                     // colNo
    "upfirdn",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/upfirdn.m" // pName
};

static emlrtRTEInfo uf_emlrtRTEI{
    83,                                                     // lineNo
    5,                                                      // colNo
    "upfirdn",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/upfirdn.m" // pName
};

// Function Declarations
static
#ifdef __CUDACC__
    __device__
#endif
        int32_T
        div_s32_device(int32_T numerator, int32_T denominator);

static __global__ void upfirdn_kernel103(const emxArray_creal32_T x,
                                         const int32_T b_x,
                                         emxArray_creal32_T xCol);

static __global__ void upfirdn_kernel32(const emxArray_real32_T x,
                                        const int32_T b_x,
                                        emxArray_real32_T xCol);

static __global__ void upfirdn_kernel33(const int32_T nx, const int32_T n,
                                        const int32_T dim, int32_T origSiz[2]);

static __global__ void upfirdn_kernel34(const emxArray_real32_T w,
                                        const int32_T nElements_dim0,
                                        const int32_T nx, const int32_T b,
                                        const int32_T c, emxArray_real32_T b_w,
                                        int32_T w_dim0);

static __global__ void upfirdn_kernel35(const emxArray_real32_T w,
                                        const int32_T nElements,
                                        emxArray_real32_T y_out);

static __global__ void upfirdn_kernel36(const emxArray_real32_T w,
                                        const int32_T nElements_dim0,
                                        const int32_T nx, const int32_T b,
                                        const int32_T c, emxArray_real32_T b_w,
                                        int32_T w_dim0);

static __global__ void upfirdn_kernel37(const emxArray_real32_T w,
                                        const int32_T nElements_dim0,
                                        const int32_T b, const int32_T c,
                                        emxArray_real32_T y_out,
                                        int32_T y_out_dim0);

static __global__ void upfirdn_kernel38(const emxArray_real32_T y_out,
                                        const int32_T b,
                                        emxArray_real32_T b_y_out,
                                        int32_T y_out_dim0);

static __global__ void upfirdn_kernel39(const emxArray_real32_T y_out,
                                        const int32_T b_y_out,
                                        emxArray_real32_T c_y_out);

static __global__ void upfirdn_kernel43(const emxArray_real32_T x,
                                        const int32_T b_x,
                                        emxArray_real32_T xCol);

static __global__ void upfirdn_kernel92(const emxArray_creal32_T x,
                                        const int32_T b_x,
                                        emxArray_creal32_T xCol);

static __global__ void upfirdn_kernel93(const int32_T nx, const int32_T n,
                                        const int32_T dim, int32_T origSiz[2]);

static __global__ void upfirdn_kernel94(const emxArray_creal32_T w,
                                        const int32_T nElements_dim0,
                                        const int32_T nx, const int32_T b,
                                        const int32_T c, emxArray_creal32_T b_w,
                                        int32_T w_dim0);

static __global__ void upfirdn_kernel95(const emxArray_creal32_T w,
                                        const int32_T nElements,
                                        emxArray_creal32_T y_out);

static __global__ void upfirdn_kernel96(const emxArray_creal32_T w,
                                        const int32_T nElements_dim0,
                                        const int32_T nx, const int32_T b,
                                        const int32_T c, emxArray_creal32_T b_w,
                                        int32_T w_dim0);

static __global__ void upfirdn_kernel97(const emxArray_creal32_T w,
                                        const int32_T nElements_dim0,
                                        const int32_T b, const int32_T c,
                                        emxArray_creal32_T y_out,
                                        int32_T y_out_dim0);

static __global__ void upfirdn_kernel98(const emxArray_creal32_T y_out,
                                        const int32_T b,
                                        emxArray_creal32_T b_y_out,
                                        int32_T y_out_dim0);

static __global__ void upfirdn_kernel99(const emxArray_creal32_T y_out,
                                        const int32_T b_y_out,
                                        emxArray_creal32_T c_y_out);

// Function Definitions
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

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel103(
    const emxArray_creal32_T x, const int32_T b_x, emxArray_creal32_T xCol)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    xCol.data[i1] = x.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel32(
    const emxArray_real32_T x, const int32_T b_x, emxArray_real32_T xCol)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    xCol.data[i1] = x.data[i1];
  }
}

static __global__ __launch_bounds__(32, 1) void upfirdn_kernel33(
    const int32_T nx, const int32_T n, const int32_T dim, int32_T origSiz[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    origSiz[dim] = div_s32_device(n, nx) + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel34(
    const emxArray_real32_T w, const int32_T nElements_dim0, const int32_T nx,
    const int32_T b, const int32_T c, emxArray_real32_T b_w, int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T i2;
    i2 = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(i2)) /
                              (static_cast<uint64_T>(b) + 1UL));
    b_w.data[i2 + w_dim0 * i1] = w.data[nx * i2 + nElements_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel35(
    const emxArray_real32_T w, const int32_T nElements, emxArray_real32_T y_out)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nElements);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    y_out.data[i1] = w.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel36(
    const emxArray_real32_T w, const int32_T nElements_dim0, const int32_T nx,
    const int32_T b, const int32_T c, emxArray_real32_T b_w, int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T i2;
    i2 = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(i2)) /
                              (static_cast<uint64_T>(b) + 1UL));
    b_w.data[i2 + w_dim0 * i1] = w.data[nx * i2 + nElements_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel37(
    const emxArray_real32_T w, const int32_T nElements_dim0, const int32_T b,
    const int32_T c, emxArray_real32_T y_out, int32_T y_out_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T i2;
    i2 = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(i2)) /
                              (static_cast<uint64_T>(b) + 1UL));
    y_out.data[i2 + y_out_dim0 * i1] = w.data[i2 + nElements_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel38(
    const emxArray_real32_T y_out, const int32_T b, emxArray_real32_T b_y_out,
    int32_T y_out_dim0)
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
    b_y_out.data[y_out_dim0 * i1] = y_out.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel39(
    const emxArray_real32_T y_out, const int32_T b_y_out,
    emxArray_real32_T c_y_out)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y_out);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c_y_out.data[i1] = y_out.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel43(
    const emxArray_real32_T x, const int32_T b_x, emxArray_real32_T xCol)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    xCol.data[i1] = x.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel92(
    const emxArray_creal32_T x, const int32_T b_x, emxArray_creal32_T xCol)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    xCol.data[i1] = x.data[i1];
  }
}

static __global__ __launch_bounds__(32, 1) void upfirdn_kernel93(
    const int32_T nx, const int32_T n, const int32_T dim, int32_T origSiz[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    origSiz[dim] = div_s32_device(n, nx) + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel94(
    const emxArray_creal32_T w, const int32_T nElements_dim0, const int32_T nx,
    const int32_T b, const int32_T c, emxArray_creal32_T b_w, int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T i2;
    i2 = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(i2)) /
                              (static_cast<uint64_T>(b) + 1UL));
    b_w.data[i2 + w_dim0 * i1] = w.data[nx * i2 + nElements_dim0 * i1];
  }
}

static __global__
    __launch_bounds__(1024, 1) void upfirdn_kernel95(const emxArray_creal32_T w,
                                                     const int32_T nElements,
                                                     emxArray_creal32_T y_out)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nElements);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    y_out.data[i1] = w.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel96(
    const emxArray_creal32_T w, const int32_T nElements_dim0, const int32_T nx,
    const int32_T b, const int32_T c, emxArray_creal32_T b_w, int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T i2;
    i2 = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(i2)) /
                              (static_cast<uint64_T>(b) + 1UL));
    b_w.data[i2 + w_dim0 * i1] = w.data[nx * i2 + nElements_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel97(
    const emxArray_creal32_T w, const int32_T nElements_dim0, const int32_T b,
    const int32_T c, emxArray_creal32_T y_out, int32_T y_out_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T i2;
    i2 = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(i2)) /
                              (static_cast<uint64_T>(b) + 1UL));
    y_out.data[i2 + y_out_dim0 * i1] = w.data[i2 + nElements_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel98(
    const emxArray_creal32_T y_out, const int32_T b, emxArray_creal32_T b_y_out,
    int32_T y_out_dim0)
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
    b_y_out.data[y_out_dim0 * i1] = y_out.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void upfirdn_kernel99(
    const emxArray_creal32_T y_out, const int32_T b_y_out,
    emxArray_creal32_T c_y_out)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y_out);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c_y_out.data[i1] = y_out.data[i1];
  }
}

//
//
namespace coder {
void b_upfirdn(emxArray_creal32_T *cpu_x, emxArray_creal32_T *gpu_x,
               boolean_T *x_outdatedOnGpu, emxArray_real32_T *cpu_h,
               boolean_T *h_outdatedOnCpu, emxArray_real32_T *gpu_h,
               boolean_T *h_outdatedOnGpu, real_T varargin_1, real_T varargin_2,
               emxArray_creal32_T *cpu_y_out, boolean_T *y_out_outdatedOnCpu,
               emxArray_creal32_T *gpu_y_out, boolean_T *y_out_outdatedOnGpu)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  dim3 block;
  dim3 grid;
  emxArray_creal32_T b_gpu_w;
  emxArray_creal32_T b_gpu_y_out;
  emxArray_creal32_T b_yCol;
  emxArray_creal32_T c_gpu_w;
  emxArray_creal32_T gpu_result;
  emxArray_creal32_T gpu_w;
  emxArray_creal32_T gpu_xCol;
  emxArray_creal32_T *A;
  emxArray_creal32_T *b_cpu_w;
  emxArray_creal32_T *b_cpu_y_out;
  emxArray_creal32_T *c_cpu_w;
  emxArray_creal32_T *cpu_result;
  emxArray_creal32_T *cpu_w;
  emxArray_creal32_T *cpu_xCol;
  emxArray_creal32_T *yCol;
  emxArray_real32_T gpu_B;
  emxArray_real32_T *cpu_B;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *y;
  real_T Ly;
  int32_T b_nElements[2];
  int32_T cpu_lshift[2];
  int32_T cpu_origSiz[2];
  int32_T(*gpu_lshift)[2];
  int32_T(*gpu_origSiz)[2];
  int32_T b_i;
  int32_T dim;
  int32_T i;
  int32_T n;
  int32_T nElements;
  int32_T nx;
  char_T unusedExpr[23];
  boolean_T B_outdatedOnCpu;
  boolean_T result_outdatedOnCpu;
  boolean_T validLaunchParams;
  boolean_T w_needsGpuEnsureCapacity;
  boolean_T w_outdatedOnCpu;
  boolean_T w_outdatedOnGpu;
  boolean_T xIsRow;
  gpuEmxReset_creal32_T(&c_gpu_w);
  gpuEmxReset_creal32_T(&b_gpu_y_out);
  gpuEmxReset_creal32_T(&b_gpu_w);
  checkCudaError(mwCudaMalloc(&gpu_lshift, 8UL), __FILE__, __LINE__);
  gpuEmxReset_creal32_T(&gpu_result);
  gpuEmxReset_real32_T(&gpu_B);
  gpuEmxReset_creal32_T(&gpu_w);
  checkCudaError(mwCudaMalloc(&gpu_origSiz, 8UL), __FILE__, __LINE__);
  gpuEmxReset_creal32_T(&gpu_xCol);
  w_outdatedOnCpu = false;
  w_outdatedOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  xIsRow = (cpu_x->size[0] == 1);
  emxInit_creal32_T(&cpu_xCol, 2, &qf_emlrtRTEI, true);
  if (xIsRow) {
    i = cpu_xCol->size[0] * cpu_xCol->size[1];
    cpu_xCol->size[0] = cpu_x->size[0] * cpu_x->size[1];
    cpu_xCol->size[1] = 1;
    emxEnsureCapacity_creal32_T(cpu_xCol, i, &qf_emlrtRTEI);
    i = cpu_x->size[0] * cpu_x->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    gpuEmxEnsureCapacity_creal32_T(cpu_xCol, &gpu_xCol, true);
    if (*x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_creal32_T(gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel92<<<grid, block>>>(*gpu_x, i, gpu_xCol);
    }
    result_outdatedOnCpu = true;
  } else {
    i = cpu_xCol->size[0] * cpu_xCol->size[1];
    cpu_xCol->size[0] = cpu_x->size[0];
    cpu_xCol->size[1] = cpu_x->size[1];
    emxEnsureCapacity_creal32_T(cpu_xCol, i, &pf_emlrtRTEI);
    i = cpu_x->size[0] * cpu_x->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    gpuEmxEnsureCapacity_creal32_T(cpu_xCol, &gpu_xCol, true);
    if (*x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_creal32_T(gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel103<<<grid, block>>>(*gpu_x, i, gpu_xCol);
    }
    result_outdatedOnCpu = true;
  }
  if (!(varargin_1 - 1.0 >= 0.0)) {
    y = nullptr;
    m = emlrtCreateCharArray(2, &iv[0]);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
    emlrtAssign(&y, m);
    b_y = nullptr;
    m1 = emlrtCreateDoubleScalar(varargin_1 - 1.0);
    emlrtAssign(&b_y, m1);
    emlrt_marshallIn(b_sprintf(y, b_y, &emlrtMCI), "<output of sprintf>",
                     unusedExpr);
  }
  nx = cpu_xCol->size[0] * cpu_xCol->size[1];
  if ((cpu_xCol->size[0] == 1) && (cpu_xCol->size[1] == 1)) {
    dim = 0;
  } else {
    dim = 1;
    if (cpu_xCol->size[0] != 1) {
      dim = 0;
    }
  }
  for (i = 0; i < 2; i++) {
    cpu_origSiz[i] = cpu_xCol->size[i];
  }
  nElements = cpu_xCol->size[0] * cpu_xCol->size[1];
  emxInit_creal32_T(&yCol, 1, &db_emlrtRTEI, true);
  i = yCol->size[0];
  yCol->size[0] = nx * static_cast<int32_T>(varargin_1);
  emxEnsureCapacity_creal32_T(yCol, i, &t_emlrtRTEI);
  for (i = 0; i < nx * static_cast<int32_T>(varargin_1); i++) {
    yCol->data[i].re = 0.0F;
    yCol->data[i].im = 0.0F;
  }
  if ((static_cast<int32_T>(varargin_1) == 0) ||
      (((static_cast<int32_T>(varargin_1) > 0) &&
        (nElements * static_cast<int32_T>(varargin_1) < 1)) ||
       ((static_cast<int32_T>(varargin_1) < 0) &&
        (nElements * static_cast<int32_T>(varargin_1) > 1)))) {
    b_i = 1;
    nElements = 0;
  } else {
    b_i = static_cast<int32_T>(varargin_1);
    nElements = nx * static_cast<int32_T>(varargin_1);
  }
  nElements = div_s32(nElements - 1, b_i) + 1;
  for (i = 0; i < nElements; i++) {
    if (result_outdatedOnCpu) {
      gpuEmxMemcpyGpuToCpu_creal32_T(cpu_xCol, &gpu_xCol);
    }
    result_outdatedOnCpu = false;
    yCol->data[b_i * i] = cpu_xCol->data[i];
  }
  cpu_origSiz[dim] = cpu_xCol->size[dim] * static_cast<int32_T>(varargin_1);
  emxInit_creal32_T(&cpu_w, 2, &v_emlrtRTEI, true);
  emxInit_creal32_T(&A, 1, &v_emlrtRTEI, true);
  emxInit_real32_T(&cpu_B, 1, &rf_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_result, 1, &v_emlrtRTEI, true);
  b_yCol = *yCol;
  b_nElements[0] = cpu_origSiz[0];
  b_nElements[1] = cpu_origSiz[1];
  b_yCol.size = &b_nElements[0];
  b_yCol.numDimensions = 2;
  c_conv2(&b_yCol, cpu_h, h_outdatedOnCpu, gpu_h, h_outdatedOnGpu, cpu_w,
          &w_outdatedOnCpu, &gpu_w, &w_outdatedOnGpu);
  w_needsGpuEnsureCapacity = true;
  emxFree_creal32_T(&cpu_result);
  emxFree_real32_T(&cpu_B);
  emxFree_creal32_T(&A);
  emxFree_creal32_T(&yCol);
  if (!(varargin_2 - 1.0 >= 0.0)) {
    c_y = nullptr;
    m2 = emlrtCreateCharArray(2, &iv1[0]);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m2, &rfmt[0]);
    emlrtAssign(&c_y, m2);
    d_y = nullptr;
    m3 = emlrtCreateDoubleScalar(varargin_2 - 1.0);
    emlrtAssign(&d_y, m3);
    emlrt_marshallIn(b_sprintf(c_y, d_y, &emlrtMCI), "<output of sprintf>",
                     unusedExpr);
  }
  dim = 1;
  if (cpu_w->size[0] != 1) {
    dim = 0;
  }
  result_outdatedOnCpu = false;
  w_outdatedOnCpu = false;
  B_outdatedOnCpu = false;
  for (i = 0; i < 2; i++) {
    cpu_origSiz[i] = cpu_w->size[i];
    result_outdatedOnCpu = true;
    cpu_lshift[i] = cpu_w->size[i];
    B_outdatedOnCpu = true;
  }
  circshift(cpu_lshift, &w_outdatedOnCpu, *gpu_lshift, &B_outdatedOnCpu, -dim);
  if (w_outdatedOnCpu) {
    checkCudaError(
        cudaMemcpy(cpu_lshift, *gpu_lshift, 8UL, cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
  }
  if ((varargin_2 == 0.0) || ((varargin_2 > 0.0) && (cpu_lshift[0] < 1))) {
    nx = 1;
    n = -1;
  } else {
    nx = static_cast<int32_T>(varargin_2);
    n = cpu_lshift[0] - 1;
  }
  if (result_outdatedOnCpu) {
    checkCudaError(
        cudaMemcpy(*gpu_origSiz, cpu_origSiz, 8UL, cudaMemcpyHostToDevice),
        __FILE__, __LINE__);
  }
  upfirdn_kernel93<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nx, n, dim,
                                                            *gpu_origSiz);
  emxInit_creal32_T(&b_cpu_w, 2, &sf_emlrtRTEI, true);
  nElements = b_cpu_w->size[0] * b_cpu_w->size[1];
  b_cpu_w->size[0] = div_s32(n, nx) + 1;
  b_cpu_w->size[1] = cpu_lshift[1];
  emxEnsureCapacity_creal32_T(b_cpu_w, nElements, &sf_emlrtRTEI);
  i = n / nx;
  mwGetLaunchParameters1D(computeNumIters(cpu_lshift[1] - 1, i), &grid, &block,
                          2147483647U);
  if (w_needsGpuEnsureCapacity) {
    gpuEmxEnsureCapacity_creal32_T(cpu_w, &gpu_w, !w_outdatedOnGpu);
  }
  gpuEmxEnsureCapacity_creal32_T(b_cpu_w, &b_gpu_w, true);
  if (w_outdatedOnGpu) {
    gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_w, cpu_w);
  }
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    upfirdn_kernel94<<<grid, block>>>(gpu_w, cpu_lshift[0], nx, i,
                                      cpu_lshift[1] - 1, b_gpu_w,
                                      b_cpu_w->size[0U]);
  }
  checkCudaError(
      cudaMemcpy(cpu_origSiz, *gpu_origSiz, 8UL, cudaMemcpyDeviceToHost),
      __FILE__, __LINE__);
  i = cpu_y_out->size[0] * cpu_y_out->size[1];
  cpu_y_out->size[0] = cpu_origSiz[0];
  cpu_y_out->size[1] = cpu_origSiz[1];
  emxEnsureCapacity_creal32_T(cpu_y_out, i, &v_emlrtRTEI);
  nElements = cpu_origSiz[0] * cpu_origSiz[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(nElements), &grid, &block,
                          2147483647U);
  gpuEmxEnsureCapacity_creal32_T(cpu_y_out, gpu_y_out, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    upfirdn_kernel95<<<grid, block>>>(b_gpu_w, nElements, *gpu_y_out);
  }
  emxFree_creal32_T(&b_cpu_w);
  Ly = std::ceil(((static_cast<real_T>(cpu_xCol->size[0]) - 1.0) * varargin_1 +
                  static_cast<real_T>(cpu_h->size[0])) /
                 varargin_2);
  emxFree_creal32_T(&cpu_xCol);
  if (!(cpu_origSiz[0] < Ly)) {
    if (Ly < 1.0) {
      b_i = 0;
    } else {
      b_i = static_cast<int32_T>(Ly);
    }
    emxInit_creal32_T(&c_cpu_w, 2, &sf_emlrtRTEI, true);
    nElements = c_cpu_w->size[0] * c_cpu_w->size[1];
    c_cpu_w->size[0] = div_s32(n, nx) + 1;
    c_cpu_w->size[1] = cpu_lshift[1];
    emxEnsureCapacity_creal32_T(c_cpu_w, nElements, &sf_emlrtRTEI);
    i = n / nx;
    mwGetLaunchParameters1D(computeNumIters(cpu_lshift[1] - 1, i), &grid,
                            &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(c_cpu_w, &c_gpu_w, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel96<<<grid, block>>>(gpu_w, cpu_lshift[0], nx, i,
                                        cpu_lshift[1] - 1, c_gpu_w,
                                        c_cpu_w->size[0U]);
    }
    nElements = cpu_y_out->size[0] * cpu_y_out->size[1];
    cpu_y_out->size[0] = b_i;
    cpu_y_out->size[1] = cpu_origSiz[1];
    emxEnsureCapacity_creal32_T(cpu_y_out, nElements, &w_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(cpu_origSiz[1] - 1, b_i - 1), &grid,
                            &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_y_out, gpu_y_out, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel97<<<grid, block>>>(c_gpu_w, cpu_origSiz[0], b_i - 1,
                                        cpu_origSiz[1] - 1, *gpu_y_out,
                                        cpu_y_out->size[0U]);
    }
    emxFree_creal32_T(&c_cpu_w);
  }
  emxFree_creal32_T(&cpu_w);
  if (xIsRow) {
    nElements = cpu_y_out->size[0] * cpu_y_out->size[1];
    emxInit_creal32_T(&b_cpu_y_out, 2, &tf_emlrtRTEI, true);
    i = b_cpu_y_out->size[0] * b_cpu_y_out->size[1];
    b_cpu_y_out->size[0] = 1;
    b_cpu_y_out->size[1] = nElements;
    emxEnsureCapacity_creal32_T(b_cpu_y_out, i, &tf_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(nElements - 1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_creal32_T(b_cpu_y_out, &b_gpu_y_out, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel98<<<grid, block>>>(*gpu_y_out, nElements - 1, b_gpu_y_out,
                                        b_cpu_y_out->size[0U]);
    }
    i = cpu_y_out->size[0] * cpu_y_out->size[1];
    cpu_y_out->size[0] = 1;
    cpu_y_out->size[1] = b_cpu_y_out->size[1];
    emxEnsureCapacity_creal32_T(cpu_y_out, i, &uf_emlrtRTEI);
    i = b_cpu_y_out->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_y_out, gpu_y_out, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel99<<<grid, block>>>(b_gpu_y_out, i, *gpu_y_out);
    }
    emxFree_creal32_T(&b_cpu_y_out);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_creal32_T(&gpu_xCol);
  checkCudaError(mwCudaFree(*gpu_origSiz), __FILE__, __LINE__);
  gpuEmxFree_creal32_T(&gpu_w);
  gpuEmxFree_real32_T(&gpu_B);
  gpuEmxFree_creal32_T(&gpu_result);
  checkCudaError(mwCudaFree(*gpu_lshift), __FILE__, __LINE__);
  gpuEmxFree_creal32_T(&b_gpu_w);
  gpuEmxFree_creal32_T(&b_gpu_y_out);
  gpuEmxFree_creal32_T(&c_gpu_w);
  *x_outdatedOnGpu = false;
  *y_out_outdatedOnCpu = true;
  *y_out_outdatedOnGpu = false;
}

//
//
void upfirdn(emxArray_real32_T *cpu_x, emxArray_real32_T *gpu_x,
             boolean_T *x_outdatedOnGpu, emxArray_real32_T *cpu_h,
             boolean_T *h_outdatedOnCpu, emxArray_real32_T *gpu_h,
             boolean_T *h_outdatedOnGpu, real_T varargin_1, real_T varargin_2,
             emxArray_real32_T *cpu_y_out, boolean_T *y_out_outdatedOnCpu,
             emxArray_real32_T *gpu_y_out, boolean_T *y_out_outdatedOnGpu)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  dim3 block;
  dim3 grid;
  emxArray_real32_T b_gpu_w;
  emxArray_real32_T b_gpu_y_out;
  emxArray_real32_T b_yCol;
  emxArray_real32_T c_gpu_w;
  emxArray_real32_T gpu_B;
  emxArray_real32_T gpu_result;
  emxArray_real32_T gpu_w;
  emxArray_real32_T gpu_xCol;
  emxArray_real32_T *A;
  emxArray_real32_T *b_cpu_w;
  emxArray_real32_T *b_cpu_y_out;
  emxArray_real32_T *c_cpu_w;
  emxArray_real32_T *cpu_B;
  emxArray_real32_T *cpu_result;
  emxArray_real32_T *cpu_w;
  emxArray_real32_T *cpu_xCol;
  emxArray_real32_T *yCol;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *y;
  real_T Ly;
  int32_T b_nElements[2];
  int32_T cpu_lshift[2];
  int32_T cpu_origSiz[2];
  int32_T(*gpu_lshift)[2];
  int32_T(*gpu_origSiz)[2];
  int32_T b_i;
  int32_T dim;
  int32_T i;
  int32_T n;
  int32_T nElements;
  int32_T nx;
  char_T unusedExpr[23];
  boolean_T B_outdatedOnCpu;
  boolean_T result_outdatedOnCpu;
  boolean_T validLaunchParams;
  boolean_T w_outdatedOnCpu;
  boolean_T w_outdatedOnGpu;
  boolean_T xCol_outdatedOnCpu;
  boolean_T xIsRow;
  gpuEmxReset_real32_T(&c_gpu_w);
  gpuEmxReset_real32_T(&b_gpu_y_out);
  gpuEmxReset_real32_T(&b_gpu_w);
  checkCudaError(mwCudaMalloc(&gpu_lshift, 8UL), __FILE__, __LINE__);
  gpuEmxReset_real32_T(&gpu_result);
  gpuEmxReset_real32_T(&gpu_B);
  gpuEmxReset_real32_T(&gpu_w);
  checkCudaError(mwCudaMalloc(&gpu_origSiz, 8UL), __FILE__, __LINE__);
  gpuEmxReset_real32_T(&gpu_xCol);
  w_outdatedOnCpu = false;
  w_outdatedOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  xIsRow = (cpu_x->size[0] == 1);
  emxInit_real32_T(&cpu_xCol, 2, &qf_emlrtRTEI, true);
  if (xIsRow) {
    i = cpu_xCol->size[0] * cpu_xCol->size[1];
    cpu_xCol->size[0] = cpu_x->size[0] * cpu_x->size[1];
    cpu_xCol->size[1] = 1;
    emxEnsureCapacity_real32_T(cpu_xCol, i, &qf_emlrtRTEI);
    i = cpu_x->size[0] * cpu_x->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    gpuEmxEnsureCapacity_real32_T(cpu_xCol, &gpu_xCol, true);
    if (*x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel32<<<grid, block>>>(*gpu_x, i, gpu_xCol);
    }
    xCol_outdatedOnCpu = true;
  } else {
    i = cpu_xCol->size[0] * cpu_xCol->size[1];
    cpu_xCol->size[0] = cpu_x->size[0];
    cpu_xCol->size[1] = cpu_x->size[1];
    emxEnsureCapacity_real32_T(cpu_xCol, i, &pf_emlrtRTEI);
    i = cpu_x->size[0] * cpu_x->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    gpuEmxEnsureCapacity_real32_T(cpu_xCol, &gpu_xCol, true);
    if (*x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel43<<<grid, block>>>(*gpu_x, i, gpu_xCol);
    }
    xCol_outdatedOnCpu = true;
  }
  if (!(varargin_1 - 1.0 >= 0.0)) {
    y = nullptr;
    m = emlrtCreateCharArray(2, &iv[0]);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
    emlrtAssign(&y, m);
    b_y = nullptr;
    m1 = emlrtCreateDoubleScalar(varargin_1 - 1.0);
    emlrtAssign(&b_y, m1);
    emlrt_marshallIn(b_sprintf(y, b_y, &emlrtMCI), "<output of sprintf>",
                     unusedExpr);
  }
  nx = cpu_xCol->size[0] * cpu_xCol->size[1];
  if ((cpu_xCol->size[0] == 1) && (cpu_xCol->size[1] == 1)) {
    dim = 0;
  } else {
    dim = 1;
    if (cpu_xCol->size[0] != 1) {
      dim = 0;
    }
  }
  for (i = 0; i < 2; i++) {
    cpu_origSiz[i] = cpu_xCol->size[i];
  }
  nElements = cpu_xCol->size[0] * cpu_xCol->size[1];
  emxInit_real32_T(&yCol, 1, &db_emlrtRTEI, true);
  i = yCol->size[0];
  yCol->size[0] = nx * static_cast<int32_T>(varargin_1);
  emxEnsureCapacity_real32_T(yCol, i, &t_emlrtRTEI);
  for (i = 0; i < nx * static_cast<int32_T>(varargin_1); i++) {
    yCol->data[i] = 0.0F;
  }
  if ((static_cast<int32_T>(varargin_1) == 0) ||
      (((static_cast<int32_T>(varargin_1) > 0) &&
        (nElements * static_cast<int32_T>(varargin_1) < 1)) ||
       ((static_cast<int32_T>(varargin_1) < 0) &&
        (nElements * static_cast<int32_T>(varargin_1) > 1)))) {
    b_i = 1;
    nElements = 0;
  } else {
    b_i = static_cast<int32_T>(varargin_1);
    nElements = nx * static_cast<int32_T>(varargin_1);
  }
  nElements = div_s32(nElements - 1, b_i) + 1;
  for (i = 0; i < nElements; i++) {
    if (xCol_outdatedOnCpu) {
      gpuEmxMemcpyGpuToCpu_real32_T(cpu_xCol, &gpu_xCol);
    }
    xCol_outdatedOnCpu = false;
    yCol->data[b_i * i] = cpu_xCol->data[i];
  }
  cpu_origSiz[dim] = cpu_xCol->size[dim] * static_cast<int32_T>(varargin_1);
  emxInit_real32_T(&cpu_w, 2, &v_emlrtRTEI, true);
  emxInit_real32_T(&A, 1, &v_emlrtRTEI, true);
  emxInit_real32_T(&cpu_B, 1, &rf_emlrtRTEI, true);
  emxInit_real32_T(&cpu_result, 1, &v_emlrtRTEI, true);
  b_yCol = *yCol;
  b_nElements[0] = cpu_origSiz[0];
  b_nElements[1] = cpu_origSiz[1];
  b_yCol.size = &b_nElements[0];
  b_yCol.numDimensions = 2;
  conv2(&b_yCol, cpu_h, h_outdatedOnCpu, gpu_h, h_outdatedOnGpu, cpu_w,
        &w_outdatedOnCpu, &gpu_w, &w_outdatedOnGpu);
  result_outdatedOnCpu = true;
  emxFree_real32_T(&cpu_result);
  emxFree_real32_T(&cpu_B);
  emxFree_real32_T(&A);
  emxFree_real32_T(&yCol);
  if (!(varargin_2 - 1.0 >= 0.0)) {
    c_y = nullptr;
    m2 = emlrtCreateCharArray(2, &iv1[0]);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m2, &rfmt[0]);
    emlrtAssign(&c_y, m2);
    d_y = nullptr;
    m3 = emlrtCreateDoubleScalar(varargin_2 - 1.0);
    emlrtAssign(&d_y, m3);
    emlrt_marshallIn(b_sprintf(c_y, d_y, &emlrtMCI), "<output of sprintf>",
                     unusedExpr);
  }
  dim = 1;
  if (cpu_w->size[0] != 1) {
    dim = 0;
  }
  xCol_outdatedOnCpu = false;
  w_outdatedOnCpu = false;
  B_outdatedOnCpu = false;
  for (i = 0; i < 2; i++) {
    cpu_origSiz[i] = cpu_w->size[i];
    xCol_outdatedOnCpu = true;
    cpu_lshift[i] = cpu_w->size[i];
    B_outdatedOnCpu = true;
  }
  circshift(cpu_lshift, &w_outdatedOnCpu, *gpu_lshift, &B_outdatedOnCpu, -dim);
  if (w_outdatedOnCpu) {
    checkCudaError(
        cudaMemcpy(cpu_lshift, *gpu_lshift, 8UL, cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
  }
  if ((varargin_2 == 0.0) || ((varargin_2 > 0.0) && (cpu_lshift[0] < 1))) {
    nx = 1;
    n = -1;
  } else {
    nx = static_cast<int32_T>(varargin_2);
    n = cpu_lshift[0] - 1;
  }
  if (xCol_outdatedOnCpu) {
    checkCudaError(
        cudaMemcpy(*gpu_origSiz, cpu_origSiz, 8UL, cudaMemcpyHostToDevice),
        __FILE__, __LINE__);
  }
  upfirdn_kernel33<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nx, n, dim,
                                                            *gpu_origSiz);
  emxInit_real32_T(&b_cpu_w, 2, &sf_emlrtRTEI, true);
  nElements = b_cpu_w->size[0] * b_cpu_w->size[1];
  b_cpu_w->size[0] = div_s32(n, nx) + 1;
  b_cpu_w->size[1] = cpu_lshift[1];
  emxEnsureCapacity_real32_T(b_cpu_w, nElements, &sf_emlrtRTEI);
  i = n / nx;
  mwGetLaunchParameters1D(computeNumIters(cpu_lshift[1] - 1, i), &grid, &block,
                          2147483647U);
  if (result_outdatedOnCpu) {
    gpuEmxEnsureCapacity_real32_T(cpu_w, &gpu_w, !w_outdatedOnGpu);
  }
  gpuEmxEnsureCapacity_real32_T(b_cpu_w, &b_gpu_w, true);
  if (w_outdatedOnGpu) {
    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_w, cpu_w);
  }
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    upfirdn_kernel34<<<grid, block>>>(gpu_w, cpu_lshift[0], nx, i,
                                      cpu_lshift[1] - 1, b_gpu_w,
                                      b_cpu_w->size[0U]);
  }
  checkCudaError(
      cudaMemcpy(cpu_origSiz, *gpu_origSiz, 8UL, cudaMemcpyDeviceToHost),
      __FILE__, __LINE__);
  i = cpu_y_out->size[0] * cpu_y_out->size[1];
  cpu_y_out->size[0] = cpu_origSiz[0];
  cpu_y_out->size[1] = cpu_origSiz[1];
  emxEnsureCapacity_real32_T(cpu_y_out, i, &v_emlrtRTEI);
  nElements = cpu_origSiz[0] * cpu_origSiz[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(nElements), &grid, &block,
                          2147483647U);
  gpuEmxEnsureCapacity_real32_T(cpu_y_out, gpu_y_out, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    upfirdn_kernel35<<<grid, block>>>(b_gpu_w, nElements, *gpu_y_out);
  }
  emxFree_real32_T(&b_cpu_w);
  Ly = std::ceil(((static_cast<real_T>(cpu_xCol->size[0]) - 1.0) * varargin_1 +
                  static_cast<real_T>(cpu_h->size[0])) /
                 varargin_2);
  emxFree_real32_T(&cpu_xCol);
  if (!(cpu_origSiz[0] < Ly)) {
    if (Ly < 1.0) {
      b_i = 0;
    } else {
      b_i = static_cast<int32_T>(Ly);
    }
    emxInit_real32_T(&c_cpu_w, 2, &sf_emlrtRTEI, true);
    nElements = c_cpu_w->size[0] * c_cpu_w->size[1];
    c_cpu_w->size[0] = div_s32(n, nx) + 1;
    c_cpu_w->size[1] = cpu_lshift[1];
    emxEnsureCapacity_real32_T(c_cpu_w, nElements, &sf_emlrtRTEI);
    i = n / nx;
    mwGetLaunchParameters1D(computeNumIters(cpu_lshift[1] - 1, i), &grid,
                            &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(c_cpu_w, &c_gpu_w, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel36<<<grid, block>>>(gpu_w, cpu_lshift[0], nx, i,
                                        cpu_lshift[1] - 1, c_gpu_w,
                                        c_cpu_w->size[0U]);
    }
    nElements = cpu_y_out->size[0] * cpu_y_out->size[1];
    cpu_y_out->size[0] = b_i;
    cpu_y_out->size[1] = cpu_origSiz[1];
    emxEnsureCapacity_real32_T(cpu_y_out, nElements, &w_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(cpu_origSiz[1] - 1, b_i - 1), &grid,
                            &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_y_out, gpu_y_out, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel37<<<grid, block>>>(c_gpu_w, cpu_origSiz[0], b_i - 1,
                                        cpu_origSiz[1] - 1, *gpu_y_out,
                                        cpu_y_out->size[0U]);
    }
    emxFree_real32_T(&c_cpu_w);
  }
  emxFree_real32_T(&cpu_w);
  if (xIsRow) {
    nElements = cpu_y_out->size[0] * cpu_y_out->size[1];
    emxInit_real32_T(&b_cpu_y_out, 2, &tf_emlrtRTEI, true);
    i = b_cpu_y_out->size[0] * b_cpu_y_out->size[1];
    b_cpu_y_out->size[0] = 1;
    b_cpu_y_out->size[1] = nElements;
    emxEnsureCapacity_real32_T(b_cpu_y_out, i, &tf_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(nElements - 1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_real32_T(b_cpu_y_out, &b_gpu_y_out, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel38<<<grid, block>>>(*gpu_y_out, nElements - 1, b_gpu_y_out,
                                        b_cpu_y_out->size[0U]);
    }
    i = cpu_y_out->size[0] * cpu_y_out->size[1];
    cpu_y_out->size[0] = 1;
    cpu_y_out->size[1] = b_cpu_y_out->size[1];
    emxEnsureCapacity_real32_T(cpu_y_out, i, &uf_emlrtRTEI);
    i = b_cpu_y_out->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_y_out, gpu_y_out, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      upfirdn_kernel39<<<grid, block>>>(b_gpu_y_out, i, *gpu_y_out);
    }
    emxFree_real32_T(&b_cpu_y_out);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real32_T(&gpu_xCol);
  checkCudaError(mwCudaFree(*gpu_origSiz), __FILE__, __LINE__);
  gpuEmxFree_real32_T(&gpu_w);
  gpuEmxFree_real32_T(&gpu_B);
  gpuEmxFree_real32_T(&gpu_result);
  checkCudaError(mwCudaFree(*gpu_lshift), __FILE__, __LINE__);
  gpuEmxFree_real32_T(&b_gpu_w);
  gpuEmxFree_real32_T(&b_gpu_y_out);
  gpuEmxFree_real32_T(&c_gpu_w);
  *x_outdatedOnGpu = false;
  *y_out_outdatedOnCpu = true;
  *y_out_outdatedOnGpu = false;
}

} // namespace coder

// End of code generation (upfirdn.cu)
