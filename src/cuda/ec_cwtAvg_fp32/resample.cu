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
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_mexutil.h"
#include "ec_cwtAvg_types.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "math_constants.h"
#include <cmath>

// Variable Definitions
static emlrtMCInfo e_emlrtMCI{
    53,        // lineNo
    19,        // colNo
    "flt2str", // fName
    "/usr/local/MATLAB/R2024a/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "flt2str.m" // pName
};

static emlrtRTEInfo id_emlrtRTEI{
    161,                                                        // lineNo
    71,                                                         // colNo
    "resample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/resample.m" // pName
};

static emlrtRTEInfo jd_emlrtRTEI{
    161,                                                        // lineNo
    9,                                                          // colNo
    "resample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/resample.m" // pName
};

static emlrtRTEInfo kd_emlrtRTEI{
    91,                                                         // lineNo
    5,                                                          // colNo
    "upsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/upsample.m" // pName
};

static emlrtRTEInfo ld_emlrtRTEI{
    1,                // lineNo
    1,                // colNo
    "upfirdnGPUImpl", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+codegenable/+gpu/upfirdnGPUImpl.p" // pName
};

static emlrtRTEInfo od_emlrtRTEI{
    91,                                                           // lineNo
    14,                                                           // colNo
    "downsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/downsample.m" // pName
};

static emlrtRTEInfo pd_emlrtRTEI{
    20,                        // lineNo
    5,                         // colNo
    "uniformScalarVectorCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformScalarVectorCore.m" // pName
};

static emlrtRTEInfo qd_emlrtRTEI{
    24,                      // lineNo
    13,                      // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo rd_emlrtRTEI{
    154,                                                        // lineNo
    1,                                                          // colNo
    "resample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/resample.m" // pName
};

static emlrtRTEInfo sd_emlrtRTEI{
    24,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo td_emlrtRTEI{
    88,                                                         // lineNo
    5,                                                          // colNo
    "upsample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/upsample.m" // pName
};

static emlrtRTEInfo vd_emlrtRTEI{
    17,                        // lineNo
    5,                         // colNo
    "uniformScalarVectorCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformScalarVectorCore.m" // pName
};

static emlrtRTEInfo wd_emlrtRTEI{
    22,                        // lineNo
    23,                        // colNo
    "uniformScalarVectorCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformScalarVectorCore.m" // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId, char_T ret[23]);

static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
                                emlrtMCInfo *location);

static
#ifdef __CUDACC__
    __device__
#endif
        int32_T
        div_s32_device(int32_T numerator, int32_T denominator);

static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_,
                             const char_T *identifier, char_T y[23]);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId, char_T y[23]);

static __global__ void resample_kernel24(const emxArray_real32_T varargin_1,
                                         const int32_T b_varargin_1,
                                         emxArray_real32_T y);

static __global__ void resample_kernel25(const emxArray_real32_T y,
                                         const int32_T b_y,
                                         emxArray_real32_T varargout_1);

static __global__ void resample_kernel26(const int32_T offsetH, const int32_T b,
                                         int32_T lshift[2]);

static __global__ void resample_kernel27(const int32_T n, const int32_T offsetH,
                                         const int32_T OH, int32_T sizeX[2]);

static __global__ void resample_kernel28(const emxArray_real32_T w,
                                         const int32_T y_dim0, const int32_T n,
                                         const int32_T b, const int32_T c,
                                         emxArray_real32_T b_w, int32_T w_dim0);

static __global__ void resample_kernel29(const emxArray_real32_T w,
                                         const int32_T y,
                                         emxArray_real32_T yOut);

static __global__ void resample_kernel30(emxArray_real_T y);

static __global__ void resample_kernel31(const emxArray_real32_T yOut,
                                         const emxArray_real_T y,
                                         const real_T nlast, const int32_T b,
                                         emxArray_real32_T b_y);

static __global__ void resample_kernel32(const int32_T b, emxArray_real_T y);

static __global__ void resample_kernel33(const int32_T b, emxArray_real32_T w);

static __global__ void resample_kernel34(const real32_T f, emxArray_real32_T w);

static __global__ void resample_kernel35(const int32_T OH,
                                         emxArray_real32_T expanded);

static __global__ void resample_kernel36(const int32_T offsetH,
                                         const emxArray_int32_T y,
                                         const int32_T b_y,
                                         emxArray_int32_T iv2);

static __global__ void
resample_kernel37(const emxArray_real32_T opts_filterWithPadding,
                  const emxArray_int32_T iv2, const int32_T b,
                  emxArray_real32_T expanded);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId, char_T ret[23])
{
  static const int32_T dims[2]{1, 23};
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U,
                          (const void *)&dims[0]);
  emlrtImportCharArrayR2015b(emlrtRootTLSGlobal, src, &ret[0], 23);
  emlrtDestroyArray(&src);
}

static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
                                emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m;
  pArrays[0] = m1;
  pArrays[1] = m2;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 2, &pArrays[0],
                               "sprintf", true, location);
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

static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_,
                             const char_T *identifier, char_T y[23])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(a__output_of_sprintf_), &thisId, y);
  emlrtDestroyArray(&a__output_of_sprintf_);
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId, char_T y[23])
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel24(
    const emxArray_real32_T varargin_1, const int32_T b_varargin_1,
    emxArray_real32_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_varargin_1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    y.data[orow] = varargin_1.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel25(
    const emxArray_real32_T y, const int32_T b_y, emxArray_real32_T varargout_1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    varargout_1.data[orow] = y.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel26(
    const int32_T offsetH, const int32_T b, int32_T lshift[2])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T h;
    h = lshift[0];
    lshift[0] = lshift[1 - offsetH];
    lshift[1 - offsetH] = h;
  }
}

static __global__ __launch_bounds__(32, 1) void resample_kernel27(
    const int32_T n, const int32_T offsetH, const int32_T OH, int32_T sizeX[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    sizeX[OH - 1] = div_s32_device(offsetH, n) + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel28(
    const emxArray_real32_T w, const int32_T y_dim0, const int32_T n,
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
    int32_T h;
    int32_T orow;
    h = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    orow = static_cast<int32_T>((idx - static_cast<uint64_T>(h)) /
                                (static_cast<uint64_T>(b) + 1UL));
    b_w.data[h + w_dim0 * orow] = w.data[n * h + y_dim0 * orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel29(
    const emxArray_real32_T w, const int32_T y, emxArray_real32_T yOut)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    yOut.data[orow] = w.data[orow];
  }
}

static __global__ __launch_bounds__(32,
                                    1) void resample_kernel30(emxArray_real_T y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel31(
    const emxArray_real32_T yOut, const emxArray_real_T y, const real_T nlast,
    const int32_T b, emxArray_real32_T b_y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    b_y.data[orow] = yOut.data[static_cast<int32_T>(nlast + y.data[orow]) - 1];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void resample_kernel32(const int32_T b,
                                                              emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    y.data[orow] = static_cast<real_T>(orow) + 1.0;
  }
}

static __global__
    __launch_bounds__(1024, 1) void resample_kernel33(const int32_T b,
                                                      emxArray_real32_T w)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    w.data[orow] = 0.0F;
  }
}

static __global__
    __launch_bounds__(32, 1) void resample_kernel34(const real32_T f,
                                                    emxArray_real32_T w)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    w.data[0] = f;
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel35(
    const int32_T OH, emxArray_real32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    expanded.data[orow] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel36(
    const int32_T offsetH, const emxArray_int32_T y, const int32_T b_y,
    emxArray_int32_T iv2)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    int32_T q1;
    orow = static_cast<int32_T>(idx);
    q1 = y.data[orow];
    if ((offsetH < 0) && (q1 < MIN_int32_T - offsetH)) {
      q1 = MIN_int32_T;
    } else if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv2.data[orow] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void resample_kernel37(
    const emxArray_real32_T opts_filterWithPadding, const emxArray_int32_T iv2,
    const int32_T b, emxArray_real32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    expanded.data[iv2.data[orow]] = opts_filterWithPadding.data[orow];
  }
}

//
//
namespace coder {
void resample(emxArray_real32_T *cpu_varargin_1,
              emxArray_real32_T *gpu_varargin_1,
              boolean_T *varargin_1_outdatedOnGpu, real_T varargin_2,
              real_T varargin_3, emxArray_real32_T *cpu_varargout_1,
              boolean_T *varargout_1_outdatedOnCpu,
              emxArray_real32_T *gpu_varargout_1,
              boolean_T *varargout_1_outdatedOnGpu)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  dim3 block;
  dim3 grid;
  emxArray_int32_T c_gpu_y;
  emxArray_int32_T gpu_iv2;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *cpu_iv2;
  emxArray_int32_T *rows;
  emxArray_real32_T b_gpu_w;
  emxArray_real32_T b_yCol;
  emxArray_real32_T gpu_expanded;
  emxArray_real32_T gpu_opts_filterWithPadding;
  emxArray_real32_T gpu_w;
  emxArray_real32_T gpu_y;
  emxArray_real32_T gpu_yOut;
  emxArray_real32_T *b_cpu_w;
  emxArray_real32_T *cpu_expanded;
  emxArray_real32_T *cpu_opts_filterWithPadding;
  emxArray_real32_T *cpu_w;
  emxArray_real32_T *cpu_y;
  emxArray_real32_T *cpu_yOut;
  emxArray_real32_T *opts_filter;
  emxArray_real32_T *yCol;
  emxArray_real_T b_gpu_y;
  emxArray_real_T *c_cpu_y;
  const mxArray *b_y;
  const mxArray *e_y;
  const mxArray *f_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *y;
  real_T absx;
  real_T dlast;
  real_T n;
  real_T nlast;
  real_T x;
  real_T xin;
  int32_T d_y[2];
  int32_T(*gpu_lshift)[2];
  int32_T(*gpu_sizeX)[2];
  int32_T k;
  int32_T mc;
  char_T unusedExpr[23];
  boolean_T d_opts_filterWithPadding_outdat;
  boolean_T validLaunchParams;
  boolean_T w_outdatedOnCpu;
  boolean_T w_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  checkCudaError(mwCudaMalloc(&gpu_lshift, 8UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_sizeX, 8UL), __FILE__, __LINE__);
  gpuEmxReset_real32_T(&b_gpu_w);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_real32_T(&gpu_yOut);
  gpuEmxReset_int32_T(&gpu_iv2);
  gpuEmxReset_int32_T(&c_gpu_y);
  gpuEmxReset_real32_T(&gpu_expanded);
  gpuEmxReset_real32_T(&gpu_w);
  gpuEmxReset_real32_T(&gpu_y);
  gpuEmxReset_real32_T(&gpu_opts_filterWithPadding);
  w_outdatedOnGpu = false;
  y_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real32_T(&opts_filter, 1, &rd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_opts_filterWithPadding, 1, &rd_emlrtRTEI, true);
  opts_filter->size[0] = 0;
  cpu_opts_filterWithPadding->size[0] = 0;
  x = varargin_2 / varargin_3;
  xin = x;
  absx = std::abs(x);
  if (std::isinf(absx) || std::isnan(absx)) {
    absx = rtNaN;
  } else if (absx < 4.4501477170144028E-308) {
    absx = 4.94065645841247E-324;
  } else {
    std::frexp(absx, &mc);
    absx = std::ldexp(1.0, mc - 53);
  }
  absx = std::fmax(1.0E-12, absx);
  if (std::isinf(x) || std::isnan(x)) {
    if (!std::isnan(x)) {
      if (x < 0.0) {
        n = -1.0;
      } else {
        n = 1.0;
      }
    } else {
      n = 0.0;
    }
    absx = 0.0;
  } else {
    real_T d;
    n = 1.0;
    d = 0.0;
    nlast = 0.0;
    dlast = 1.0;
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
    if (std::isnan(d)) {
      absx = rtNaN;
    } else if (d < 0.0) {
      absx = -1.0;
    } else {
      absx = (d > 0.0);
    }
    n /= absx;
    absx = std::abs(d);
  }
  emxInit_real32_T(&cpu_y, 1, &sd_emlrtRTEI, true);
  k = cpu_y->size[0];
  cpu_y->size[0] = cpu_varargin_1->size[0];
  emxEnsureCapacity_real32_T(cpu_y, k, &id_emlrtRTEI);
  k = cpu_varargin_1->size[0] - 1;
  mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real32_T(cpu_varargin_1, gpu_varargin_1,
                                !*varargin_1_outdatedOnGpu);
  gpuEmxEnsureCapacity_real32_T(cpu_y, &gpu_y, true);
  if (*varargin_1_outdatedOnGpu) {
    gpuEmxMemcpyCpuToGpu_real32_T(gpu_varargin_1, cpu_varargin_1);
  }
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    resample_kernel24<<<grid, block>>>(*gpu_varargin_1, k, gpu_y);
  }
  gpuEmxMemcpyGpuToCpu_real32_T(cpu_y, &gpu_y);
  b_signal::internal::resample::c_ResampleParser_createFilterAn(
      &n, &absx, opts_filter, cpu_opts_filterWithPadding, &nlast, cpu_y);
  d_opts_filterWithPadding_outdat = true;
  w_outdatedOnCpu = true;
  emxFree_real32_T(&opts_filter);
  emxInit_real32_T(&yCol, 1, &td_emlrtRTEI, true);
  emxInit_real32_T(&cpu_w, 2, &ld_emlrtRTEI, true);
  emxInit_real32_T(&cpu_expanded, 2, &md_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_y, 2, &ud_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv2, 1, &md_emlrtRTEI, true);
  emxInit_real32_T(&cpu_yOut, 2, &vd_emlrtRTEI, true);
  emxInit_int32_T(&rows, 2, &md_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_y, 2, &wd_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_w, 2, &od_emlrtRTEI, true);
  if ((!(n == 1.0)) || (!(absx == 1.0))) {
    int32_T cpu_lshift[2];
    int32_T cpu_sizeX[2];
    int32_T OH;
    int32_T b_n;
    int32_T offsetH;
    boolean_T c_opts_filterWithPadding_outdat;
    boolean_T w_needsGpuEnsureCapacity;
    dlast = std::ceil(static_cast<real_T>(cpu_y->size[0]) * n / absx);
    if (!(n - 1.0 >= 0.0)) {
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m1 = emlrtCreateDoubleScalar(n - 1.0);
      emlrtAssign(&b_y, m1);
      emlrt_marshallIn(b_sprintf(y, b_y, &e_emlrtMCI), "<output of sprintf>",
                       unusedExpr);
    }
    k = yCol->size[0];
    yCol->size[0] = cpu_y->size[0] * static_cast<int32_T>(n);
    emxEnsureCapacity_real32_T(yCol, k, &kd_emlrtRTEI);
    for (offsetH = 0; offsetH < cpu_y->size[0] * static_cast<int32_T>(n);
         offsetH++) {
      yCol->data[offsetH] = 0.0F;
    }
    if ((static_cast<int32_T>(n) == 0) ||
        (((static_cast<int32_T>(n) > 0) &&
          (cpu_y->size[0] * static_cast<int32_T>(n) < 1)) ||
         ((static_cast<int32_T>(n) < 0) &&
          (cpu_y->size[0] * static_cast<int32_T>(n) > 1)))) {
      b_n = 1;
      mc = 0;
    } else {
      b_n = static_cast<int32_T>(n);
      mc = cpu_y->size[0] * static_cast<int32_T>(n);
    }
    mc = div_s32(mc - 1, b_n) + 1;
    for (offsetH = 0; offsetH < mc; offsetH++) {
      yCol->data[b_n * offsetH] = cpu_y->data[offsetH];
    }
    if ((cpu_y->size[0] * static_cast<int32_T>(n) == 1) &&
        (cpu_opts_filterWithPadding->size[0] == 1)) {
      k = cpu_w->size[0] * cpu_w->size[1];
      cpu_w->size[0] = 1;
      cpu_w->size[1] = 1;
      emxEnsureCapacity_real32_T(cpu_w, k, &ld_emlrtRTEI);
      cpu_w->data[0] = yCol->data[0] * cpu_opts_filterWithPadding->data[0];
      w_outdatedOnGpu = true;
      w_needsGpuEnsureCapacity = true;
    } else if (cpu_opts_filterWithPadding->size[0] >
               cpu_y->size[0] * static_cast<int32_T>(n)) {
      if (cpu_y->size[0] * static_cast<int32_T>(n) == 0) {
        mc = cpu_opts_filterWithPadding->size[0] +
             cpu_y->size[0] * static_cast<int32_T>(n);
      } else {
        mc = (cpu_opts_filterWithPadding->size[0] +
              cpu_y->size[0] * static_cast<int32_T>(n)) -
             1;
      }
      k = cpu_w->size[0] * cpu_w->size[1];
      cpu_w->size[0] = mc;
      cpu_w->size[1] = 1;
      emxEnsureCapacity_real32_T(cpu_w, k, &ld_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_w, &gpu_w, true);
      w_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        resample_kernel33<<<grid, block>>>(mc - 1, gpu_w);
      }
      w_outdatedOnCpu = true;
      if (cpu_y->size[0] * static_cast<int32_T>(n) != 0) {
        if ((cpu_opts_filterWithPadding->size[0] == 1) &&
            (cpu_y->size[0] * static_cast<int32_T>(n) == 1)) {
          real32_T b_cv;
          k = cpu_w->size[0] * cpu_w->size[1];
          cpu_w->size[0] = 1;
          cpu_w->size[1] = 1;
          emxEnsureCapacity_real32_T(cpu_w, k, &ld_emlrtRTEI);
          b_cv = cpu_opts_filterWithPadding->data[0] * yCol->data[0];
          gpuEmxEnsureCapacity_real32_T(cpu_w, &gpu_w, true);
          resample_kernel34<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_cv,
                                                                     gpu_w);
        } else {
          uint32_T b_OH;
          b_OH = (static_cast<uint32_T>(cpu_opts_filterWithPadding->size[0]) +
                  static_cast<uint32_T>(cpu_y->size[0] *
                                        static_cast<int32_T>(n))) -
                 1U;
          if (b_OH > 2147483647U) {
            b_OH = 2147483647U;
          }
          OH = static_cast<int32_T>(b_OH);
          offsetH =
              static_cast<int32_T>(
                  std::floor(static_cast<real_T>(cpu_y->size[0] *
                                                 static_cast<int32_T>(n)) /
                             2.0)) +
              static_cast<int32_T>(
                  std::floor((static_cast<real_T>(cpu_y->size[0] *
                                                  static_cast<int32_T>(n)) -
                              1.0) /
                             2.0));
          mc = cpu_y->size[0] * static_cast<int32_T>(n);
          if ((static_cast<int32_T>(b_OH) > 0) &&
              (mc > MAX_int32_T - static_cast<int32_T>(b_OH))) {
            mc = MAX_int32_T;
          } else {
            mc += static_cast<int32_T>(b_OH);
          }
          k = cpu_expanded->size[0] * cpu_expanded->size[1];
          cpu_expanded->size[0] = mc - 1;
          cpu_expanded->size[1] = 1;
          emxEnsureCapacity_real32_T(cpu_expanded, k, &md_emlrtRTEI);
          k = (static_cast<int32_T>(b_OH) +
               cpu_y->size[0] * static_cast<int32_T>(n)) -
              2;
          mwGetLaunchParameters1D(computeNumIters(k), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_expanded, &gpu_expanded, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            resample_kernel35<<<grid, block>>>(k, gpu_expanded);
          }
          b_n = cpu_opts_filterWithPadding->size[0];
          k = b_cpu_y->size[0] * b_cpu_y->size[1];
          b_cpu_y->size[0] = 1;
          b_cpu_y->size[1] = cpu_opts_filterWithPadding->size[0];
          emxEnsureCapacity_int32_T(b_cpu_y, k, &nd_emlrtRTEI);
          b_cpu_y->data[0] = 1;
          mc = 1;
          for (k = 0; k <= b_n - 2; k++) {
            mc++;
            b_cpu_y->data[k + 1] = mc;
          }
          k = cpu_iv2->size[0];
          cpu_iv2->size[0] = b_cpu_y->size[1];
          emxEnsureCapacity_int32_T(cpu_iv2, k, &md_emlrtRTEI);
          k = b_cpu_y->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(k), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_int32_T(b_cpu_y, &c_gpu_y, false);
          gpuEmxEnsureCapacity_int32_T(cpu_iv2, &gpu_iv2, true);
          gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_y, b_cpu_y);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            resample_kernel36<<<grid, block>>>(offsetH, c_gpu_y, k, gpu_iv2);
          }
          mc = cpu_iv2->size[0];
          mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_opts_filterWithPadding,
                                        &gpu_opts_filterWithPadding, false);
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_opts_filterWithPadding,
                                        cpu_opts_filterWithPadding);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            resample_kernel37<<<grid, block>>>(gpu_opts_filterWithPadding,
                                               gpu_iv2, mc - 1, gpu_expanded);
          }
          c_opts_filterWithPadding_outdat = true;
          mc = cpu_y->size[0] * static_cast<int32_T>(n);
          if (mc - 1 < 0) {
            b_n = 0;
          } else {
            b_n = mc;
          }
          k = rows->size[0] * rows->size[1];
          rows->size[0] = 1;
          rows->size[1] = b_n;
          emxEnsureCapacity_int32_T(rows, k, &nd_emlrtRTEI);
          if (b_n > 0) {
            rows->data[0] = 0;
            mc = 0;
            for (k = 0; k <= b_n - 2; k++) {
              mc++;
              rows->data[k + 1] = mc;
            }
          }
          k = cpu_w->size[0] * cpu_w->size[1];
          cpu_w->size[0] = static_cast<int32_T>(b_OH);
          cpu_w->size[1] = 1;
          emxEnsureCapacity_real32_T(cpu_w, k, &md_emlrtRTEI);
          w_needsGpuEnsureCapacity = true;
          if (static_cast<int32_T>(b_OH) != 0) {
            for (offsetH = 0; offsetH < OH; offsetH++) {
              real32_T b_cv;
              b_cv = 0.0F;
              k = cpu_y->size[0] * static_cast<int32_T>(n);
              for (b_n = 0; b_n < k; b_n++) {
                mc = rows->data[b_n];
                if (mc > 2147483646 - offsetH) {
                  mc = MAX_int32_T;
                } else {
                  mc = (offsetH + mc) + 1;
                }
                if (c_opts_filterWithPadding_outdat) {
                  gpuEmxMemcpyGpuToCpu_real32_T(cpu_expanded, &gpu_expanded);
                }
                c_opts_filterWithPadding_outdat = false;
                b_cv += cpu_expanded->data[mc - 1] * yCol->data[(k - b_n) - 1];
              }
              if (w_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_w, &gpu_w);
              }
              cpu_w->data[offsetH] = b_cv;
              w_outdatedOnCpu = false;
              w_outdatedOnGpu = true;
            }
          }
        }
      }
    } else {
      int32_T c_y[2];
      c_y[0] = cpu_y->size[0] * static_cast<int32_T>(n);
      b_yCol = *yCol;
      d_y[0] = c_y[0];
      d_y[1] = 1;
      b_yCol.size = &d_y[0];
      b_yCol.numDimensions = 2;
      conv2NonSeparable(&b_yCol, cpu_opts_filterWithPadding,
                        &gpu_opts_filterWithPadding,
                        &d_opts_filterWithPadding_outdat, cpu_w,
                        &w_outdatedOnCpu, &gpu_w, &w_outdatedOnGpu);
      w_needsGpuEnsureCapacity = true;
    }
    if (!(absx - 1.0 >= 0.0)) {
      e_y = nullptr;
      m2 = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m2, &rfmt[0]);
      emlrtAssign(&e_y, m2);
      f_y = nullptr;
      m3 = emlrtCreateDoubleScalar(absx - 1.0);
      emlrtAssign(&f_y, m3);
      emlrt_marshallIn(b_sprintf(e_y, f_y, &e_emlrtMCI), "<output of sprintf>",
                       unusedExpr);
    }
    OH = 2;
    if (cpu_w->size[0] != 1) {
      OH = 1;
    }
    d_opts_filterWithPadding_outdat = false;
    c_opts_filterWithPadding_outdat = false;
    for (offsetH = 0; offsetH < 2; offsetH++) {
      cpu_sizeX[offsetH] = cpu_w->size[offsetH];
      c_opts_filterWithPadding_outdat = true;
      cpu_lshift[offsetH] = cpu_w->size[offsetH];
      d_opts_filterWithPadding_outdat = true;
    }
    if (1 - OH >= 0) {
      mwGetLaunchParameters1D(
          computeNumIters(static_cast<int32_T>(
                              (2.0 - (1.0 - static_cast<real_T>(OH))) / 2.0) -
                          1),
          &grid, &block, 2147483647U);
      if (d_opts_filterWithPadding_outdat) {
        checkCudaError(
            cudaMemcpy(*gpu_lshift, cpu_lshift, 8UL, cudaMemcpyHostToDevice),
            __FILE__, __LINE__);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        resample_kernel26<<<grid, block>>>(
            1 - OH,
            static_cast<int32_T>((2.0 - (1.0 - static_cast<real_T>(OH))) /
                                 2.0) -
                1,
            *gpu_lshift);
      }
      checkCudaError(
          cudaMemcpy(cpu_lshift, *gpu_lshift, 8UL, cudaMemcpyDeviceToHost),
          __FILE__, __LINE__);
    }
    mc = cpu_lshift[0];
    cpu_lshift[0] = cpu_lshift[1];
    if ((absx == 0.0) || ((absx > 0.0) && (cpu_lshift[0] < 1))) {
      b_n = 1;
      offsetH = -1;
    } else {
      b_n = static_cast<int32_T>(absx);
      offsetH = cpu_lshift[0] - 1;
    }
    if (c_opts_filterWithPadding_outdat) {
      checkCudaError(
          cudaMemcpy(*gpu_sizeX, cpu_sizeX, 8UL, cudaMemcpyHostToDevice),
          __FILE__, __LINE__);
    }
    resample_kernel27<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_n, offsetH, OH,
                                                               *gpu_sizeX);
    k = b_cpu_w->size[0] * b_cpu_w->size[1];
    b_cpu_w->size[0] = div_s32(offsetH, b_n) + 1;
    b_cpu_w->size[1] = mc;
    emxEnsureCapacity_real32_T(b_cpu_w, k, &od_emlrtRTEI);
    k = offsetH / b_n;
    mwGetLaunchParameters1D(computeNumIters(mc - 1, k), &grid, &block,
                            2147483647U);
    if (w_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real32_T(cpu_w, &gpu_w, !w_outdatedOnGpu);
    }
    gpuEmxEnsureCapacity_real32_T(b_cpu_w, &b_gpu_w, true);
    if (w_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_w, cpu_w);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      resample_kernel28<<<grid, block>>>(gpu_w, cpu_lshift[0], b_n, k, mc - 1,
                                         b_gpu_w, b_cpu_w->size[0U]);
    }
    checkCudaError(
        cudaMemcpy(cpu_sizeX, *gpu_sizeX, 8UL, cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
    k = cpu_yOut->size[0] * cpu_yOut->size[1];
    cpu_yOut->size[0] = cpu_sizeX[0];
    cpu_yOut->size[1] = cpu_sizeX[1];
    emxEnsureCapacity_real32_T(cpu_yOut, k, &pd_emlrtRTEI);
    k = cpu_sizeX[0] * cpu_sizeX[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_yOut, &gpu_yOut, true);
    c_opts_filterWithPadding_outdat = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      resample_kernel29<<<grid, block>>>(b_gpu_w, k, gpu_yOut);
    }
    w_needsGpuEnsureCapacity = false;
    d_opts_filterWithPadding_outdat = true;
    absx =
        std::ceil(((static_cast<real_T>(cpu_y->size[0]) - 1.0) * n +
                   static_cast<real_T>(cpu_opts_filterWithPadding->size[0])) /
                  absx);
    if (!(cpu_yOut->size[0] < absx)) {
      if (absx < 1.0) {
        mc = 0;
      } else {
        mc = static_cast<int32_T>(absx);
      }
      b_n = cpu_yOut->size[1];
      for (k = 0; k < b_n; k++) {
        for (offsetH = 0; offsetH < mc; offsetH++) {
          if (d_opts_filterWithPadding_outdat) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_yOut, &gpu_yOut);
          }
          cpu_yOut->data[offsetH + mc * k] =
              cpu_yOut->data[offsetH + cpu_yOut->size[0] * k];
          d_opts_filterWithPadding_outdat = false;
          w_needsGpuEnsureCapacity = true;
        }
      }
      k = cpu_yOut->size[0] * cpu_yOut->size[1];
      cpu_yOut->size[0] = mc;
      emxEnsureCapacity_real32_T(cpu_yOut, k, &pd_emlrtRTEI);
      c_opts_filterWithPadding_outdat = true;
    }
    if (std::isnan(dlast)) {
      k = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(c_cpu_y, k, &gb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &b_gpu_y, true);
      y_needsGpuEnsureCapacity = false;
      resample_kernel30<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_y);
    } else if (dlast < 1.0) {
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = 0;
    } else {
      k = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = static_cast<int32_T>(dlast - 1.0) + 1;
      emxEnsureCapacity_real_T(c_cpu_y, k, &gb_emlrtRTEI);
      mwGetLaunchParameters1D(
          computeNumIters(static_cast<int32_T>(dlast - 1.0)), &grid, &block,
          2147483647U);
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &b_gpu_y, true);
      y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        resample_kernel32<<<grid, block>>>(static_cast<int32_T>(dlast - 1.0),
                                           b_gpu_y);
      }
    }
    k = cpu_y->size[0];
    cpu_y->size[0] = static_cast<int32_T>(dlast);
    emxEnsureCapacity_real32_T(cpu_y, k, &qd_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(dlast) - 1),
                            &grid, &block, 2147483647U);
    if (c_opts_filterWithPadding_outdat) {
      gpuEmxEnsureCapacity_real32_T(cpu_yOut, &gpu_yOut,
                                    !w_needsGpuEnsureCapacity);
    }
    if (y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &b_gpu_y, true);
    }
    gpuEmxEnsureCapacity_real32_T(cpu_y, &gpu_y, true);
    w_outdatedOnCpu = false;
    if (w_needsGpuEnsureCapacity) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_yOut, cpu_yOut);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      resample_kernel31<<<grid, block>>>(
          gpu_yOut, b_gpu_y, nlast, static_cast<int32_T>(dlast) - 1, gpu_y);
    }
  }
  emxFree_real32_T(&b_cpu_w);
  emxFree_real_T(&c_cpu_y);
  emxFree_int32_T(&rows);
  emxFree_real32_T(&cpu_yOut);
  emxFree_int32_T(&cpu_iv2);
  emxFree_int32_T(&b_cpu_y);
  emxFree_real32_T(&cpu_expanded);
  emxFree_real32_T(&cpu_w);
  emxFree_real32_T(&yCol);
  emxFree_real32_T(&cpu_opts_filterWithPadding);
  k = cpu_varargout_1->size[0] * cpu_varargout_1->size[1];
  cpu_varargout_1->size[0] = cpu_y->size[0];
  cpu_varargout_1->size[1] = 1;
  emxEnsureCapacity_real32_T(cpu_varargout_1, k, &jd_emlrtRTEI);
  k = cpu_y->size[0] - 1;
  mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
  if (w_outdatedOnCpu) {
    gpuEmxEnsureCapacity_real32_T(cpu_y, &gpu_y, true);
  }
  gpuEmxEnsureCapacity_real32_T(cpu_varargout_1, gpu_varargout_1, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    resample_kernel25<<<grid, block>>>(gpu_y, k, *gpu_varargout_1);
  }
  emxFree_real32_T(&cpu_y);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real32_T(&gpu_opts_filterWithPadding);
  gpuEmxFree_real32_T(&gpu_y);
  gpuEmxFree_real32_T(&gpu_w);
  gpuEmxFree_real32_T(&gpu_expanded);
  gpuEmxFree_int32_T(&c_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv2);
  gpuEmxFree_real32_T(&gpu_yOut);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real32_T(&b_gpu_w);
  checkCudaError(mwCudaFree(*gpu_sizeX), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_lshift), __FILE__, __LINE__);
  *varargin_1_outdatedOnGpu = false;
  *varargout_1_outdatedOnCpu = true;
  *varargout_1_outdatedOnGpu = false;
}

} // namespace coder

// End of code generation (resample.cu)
