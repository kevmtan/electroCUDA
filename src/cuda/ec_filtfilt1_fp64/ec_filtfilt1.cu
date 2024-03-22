//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt1.cu
//
// Code generation for function 'ec_filtfilt1'
//

// Include files
#include "ec_filtfilt1.h"
#include "ec_filtfilt1_data.h"
#include "ec_filtfilt1_emxutil.h"
#include "ec_filtfilt1_mexutil.h"
#include "ec_filtfilt1_types.h"
#include "filter.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"

// Variable Definitions
static emlrtRTEInfo emlrtRTEI{
    99,                                                         // lineNo
    1,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    103,                                                        // lineNo
    28,                                                         // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    60,                                                              // lineNo
    20,                                                              // colNo
    "bsxfun",                                                        // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/bsxfun.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    103,                                                        // lineNo
    15,                                                         // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo
    e_emlrtRTEI{
        76,                  // lineNo
        13,                  // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

static emlrtRTEInfo f_emlrtRTEI{
    103,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    132,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    1,                                                          // lineNo
    14,                                                         // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    135,                                                        // lineNo
    10,                                                         // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    136,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    139,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

// Function Declarations
static int32_T div_s32(int32_T numerator, int32_T denominator);

static __global__ void ec_filtfilt1_kernel1(const int32_T ch,
                                            const emxArray_real_T x,
                                            const int32_T b_x,
                                            emxArray_real_T dv, int32_T x_dim0);

static __global__ void ec_filtfilt1_kernel10(const emxArray_real_T a,
                                             const int32_T b_a,
                                             emxArray_real_T c_a);

static __global__ void ec_filtfilt1_kernel11(const emxArray_real_T b,
                                             const int32_T b_b,
                                             emxArray_real_T c_b);

static __global__ void ec_filtfilt1_kernel12(const emxArray_real_T a,
                                             const int32_T b_a,
                                             emxArray_real_T c_a);

static __global__ void ec_filtfilt1_kernel13(const emxArray_real_T yc3,
                                             const int32_T bcoef,
                                             const int32_T i5, const int32_T b,
                                             emxArray_real_T b_yc3);

static __global__ void ec_filtfilt1_kernel14(const real_T a,
                                             const emxArray_real_T z,
                                             const int32_T b_z,
                                             emxArray_real_T c_z);

static __global__ void ec_filtfilt1_kernel15(const emxArray_real_T b,
                                             const int32_T b_b,
                                             emxArray_real_T c_b);

static __global__ void ec_filtfilt1_kernel16(const emxArray_real_T a,
                                             const int32_T b_a,
                                             emxArray_real_T c_a);

static __global__ void ec_filtfilt1_kernel17(const emxArray_real_T yc2,
                                             const int32_T bcoef,
                                             const int32_T i5, const int32_T b,
                                             emxArray_real_T b_yc2);

static __global__ void ec_filtfilt1_kernel18(const emxArray_real_T yc5,
                                             const int32_T bcoef,
                                             const int32_T i5, const int32_T b,
                                             emxArray_real_T dv);

static __global__ void ec_filtfilt1_kernel19(const emxArray_real_T dv,
                                             const int32_T ch, const int32_T b,
                                             emxArray_real_T y, int32_T y_dim0);

static __global__ void ec_filtfilt1_kernel2(const emxArray_real_T dv,
                                            const int32_T bcoef,
                                            const int32_T i3, const int32_T i2,
                                            const real_T a, const int32_T i5,
                                            emxArray_real_T xt);

static __global__ void ec_filtfilt1_kernel3(const emxArray_real_T b,
                                            const int32_T b_b,
                                            emxArray_real_T c_b);

static __global__ void ec_filtfilt1_kernel4(const emxArray_real_T a,
                                            const int32_T b_a,
                                            emxArray_real_T c_a);

static __global__ void ec_filtfilt1_kernel5(const real_T a,
                                            const emxArray_real_T z,
                                            const int32_T b_z,
                                            emxArray_real_T c_z);

static __global__ void ec_filtfilt1_kernel6(const emxArray_real_T b,
                                            const int32_T b_b,
                                            emxArray_real_T c_b);

static __global__ void ec_filtfilt1_kernel7(const emxArray_real_T a,
                                            const int32_T b_a,
                                            emxArray_real_T c_a);

static __global__ void ec_filtfilt1_kernel8(const emxArray_real_T dv,
                                            const int32_T bcoef,
                                            const int32_T i7, const int32_T i6,
                                            const real_T a, const int32_T i5,
                                            emxArray_real_T c);

static __global__ void ec_filtfilt1_kernel9(const emxArray_real_T b,
                                            const int32_T b_b,
                                            emxArray_real_T c_b);

// Function Definitions
static int32_T div_s32(int32_T numerator, int32_T denominator)
{
  int32_T quotient;
  if (denominator == 0) {
    emlrtDivisionByZeroErrorR2012b(nullptr, emlrtRootTLSGlobal);
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
    if ((numerator < 0) != (denominator < 0)) {
      quotient = -static_cast<int32_T>(tempAbsQuotient);
    } else {
      quotient = static_cast<int32_T>(tempAbsQuotient);
    }
  }
  return quotient;
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel1(
    const int32_T ch, const emxArray_real_T x, const int32_T b_x,
    emxArray_real_T dv, int32_T x_dim0)
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
    dv.data[k] = x.data[k + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel10(
    const emxArray_real_T a, const int32_T b_a, emxArray_real_T c_a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_a.data[k] = a.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel11(
    const emxArray_real_T b, const int32_T b_b, emxArray_real_T c_b)
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
    c_b.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel12(
    const emxArray_real_T a, const int32_T b_a, emxArray_real_T c_a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_a.data[k] = a.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel13(
    const emxArray_real_T yc3, const int32_T bcoef, const int32_T i5,
    const int32_T b, emxArray_real_T b_yc3)
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
    b_yc3.data[k] = yc3.data[i5 + bcoef * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel14(
    const real_T a, const emxArray_real_T z, const int32_T b_z,
    emxArray_real_T c_z)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_z);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_z.data[k] = z.data[k] * a;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel15(
    const emxArray_real_T b, const int32_T b_b, emxArray_real_T c_b)
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
    c_b.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel16(
    const emxArray_real_T a, const int32_T b_a, emxArray_real_T c_a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_a.data[k] = a.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel17(
    const emxArray_real_T yc2, const int32_T bcoef, const int32_T i5,
    const int32_T b, emxArray_real_T b_yc2)
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
    b_yc2.data[k] = yc2.data[i5 + bcoef * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel18(
    const emxArray_real_T yc5, const int32_T bcoef, const int32_T i5,
    const int32_T b, emxArray_real_T dv)
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
    dv.data[k] = yc5.data[i5 + bcoef * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel19(
    const emxArray_real_T dv, const int32_T ch, const int32_T b,
    emxArray_real_T y, int32_T y_dim0)
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
    y.data[k + y_dim0 * ch] = dv.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel2(
    const emxArray_real_T dv, const int32_T bcoef, const int32_T i3,
    const int32_T i2, const real_T a, const int32_T i5, emxArray_real_T xt)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i5);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    xt.data[k] = a - dv.data[(i2 + i3 * (bcoef * k)) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel3(
    const emxArray_real_T b, const int32_T b_b, emxArray_real_T c_b)
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
    c_b.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel4(
    const emxArray_real_T a, const int32_T b_a, emxArray_real_T c_a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_a.data[k] = a.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel5(
    const real_T a, const emxArray_real_T z, const int32_T b_z,
    emxArray_real_T c_z)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_z);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_z.data[k] = z.data[k] * a;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel6(
    const emxArray_real_T b, const int32_T b_b, emxArray_real_T c_b)
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
    c_b.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel7(
    const emxArray_real_T a, const int32_T b_a, emxArray_real_T c_a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_a.data[k] = a.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel8(
    const emxArray_real_T dv, const int32_T bcoef, const int32_T i7,
    const int32_T i6, const real_T a, const int32_T i5, emxArray_real_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i5);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c.data[k] = a - dv.data[(i6 + i7 * (bcoef * k)) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel9(
    const emxArray_real_T b, const int32_T b_b, emxArray_real_T c_b)
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
    c_b.data[k] = b.data[k];
  }
}

//
// function y = ec_filtfilt1(x,b,a,z,nf,L)
void ec_filtfilt1(const emxArray_real_T *cpu_x, const emxArray_real_T *cpu_b,
                  const emxArray_real_T *cpu_a, const emxArray_real_T *cpu_z,
                  real_T nf, real_T L, emxArray_real_T *cpu_y)
{
  dim3 block;
  dim3 grid;
  emxArray_real_T b_gpu_a;
  emxArray_real_T b_gpu_b;
  emxArray_real_T b_gpu_yc2;
  emxArray_real_T b_gpu_yc3;
  emxArray_real_T b_gpu_z;
  emxArray_real_T b_gpu_zo;
  emxArray_real_T c_gpu_a;
  emxArray_real_T c_gpu_b;
  emxArray_real_T c_gpu_z;
  emxArray_real_T c_gpu_zo;
  emxArray_real_T d_gpu_a;
  emxArray_real_T d_gpu_b;
  emxArray_real_T e_gpu_a;
  emxArray_real_T e_gpu_b;
  emxArray_real_T f_gpu_a;
  emxArray_real_T f_gpu_b;
  emxArray_real_T gpu__1;
  emxArray_real_T gpu__2;
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_b;
  emxArray_real_T gpu_c;
  emxArray_real_T gpu_dv;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xt;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_yc2;
  emxArray_real_T gpu_yc3;
  emxArray_real_T gpu_yc5;
  emxArray_real_T gpu_z;
  emxArray_real_T gpu_zo;
  emxArray_real_T *b_cpu_a;
  emxArray_real_T *b_cpu_b;
  emxArray_real_T *b_cpu_yc2;
  emxArray_real_T *b_cpu_yc3;
  emxArray_real_T *b_cpu_z;
  emxArray_real_T *b_cpu_zo;
  emxArray_real_T *c_cpu_a;
  emxArray_real_T *c_cpu_b;
  emxArray_real_T *c_cpu_z;
  emxArray_real_T *c_cpu_zo;
  emxArray_real_T *cpu__1;
  emxArray_real_T *cpu__2;
  emxArray_real_T *cpu_c;
  emxArray_real_T *cpu_dv;
  emxArray_real_T *cpu_xt;
  emxArray_real_T *cpu_yc2;
  emxArray_real_T *cpu_yc3;
  emxArray_real_T *cpu_yc5;
  emxArray_real_T *cpu_zo;
  emxArray_real_T *d_cpu_a;
  emxArray_real_T *d_cpu_b;
  emxArray_real_T *e_cpu_a;
  emxArray_real_T *e_cpu_b;
  emxArray_real_T *f_cpu_a;
  emxArray_real_T *f_cpu_b;
  int32_T b_i;
  int32_T csz_idx_0;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  boolean_T a_outdatedOnCpu;
  boolean_T a_outdatedOnGpu;
  boolean_T b_outdatedOnCpu;
  boolean_T b_outdatedOnGpu;
  boolean_T b_zo_outdatedOnGpu;
  boolean_T dv_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  boolean_T xt_outdatedOnCpu;
  boolean_T y_needsGpuEnsureCapacity;
  boolean_T yc2_outdatedOnCpu;
  boolean_T yc2_outdatedOnGpu;
  boolean_T yc3_outdatedOnCpu;
  boolean_T yc3_outdatedOnGpu;
  boolean_T yc5_outdatedOnCpu;
  boolean_T yc5_outdatedOnGpu;
  boolean_T z_needsGpuEnsureCapacity;
  boolean_T z_outdatedOnGpu;
  boolean_T zo_outdatedOnCpu;
  boolean_T zo_outdatedOnGpu;
  gpuEmxReset_real_T(&b_gpu_yc2);
  gpuEmxReset_real_T(&f_gpu_a);
  gpuEmxReset_real_T(&f_gpu_b);
  gpuEmxReset_real_T(&c_gpu_z);
  gpuEmxReset_real_T(&b_gpu_yc3);
  gpuEmxReset_real_T(&e_gpu_a);
  gpuEmxReset_real_T(&e_gpu_b);
  gpuEmxReset_real_T(&d_gpu_a);
  gpuEmxReset_real_T(&d_gpu_b);
  gpuEmxReset_real_T(&c_gpu_a);
  gpuEmxReset_real_T(&c_gpu_b);
  gpuEmxReset_real_T(&b_gpu_z);
  gpuEmxReset_real_T(&b_gpu_a);
  gpuEmxReset_real_T(&b_gpu_b);
  gpuEmxReset_real_T(&gpu_yc5);
  gpuEmxReset_real_T(&c_gpu_zo);
  gpuEmxReset_real_T(&gpu__2);
  gpuEmxReset_real_T(&gpu_yc3);
  gpuEmxReset_real_T(&gpu_c);
  gpuEmxReset_real_T(&b_gpu_zo);
  gpuEmxReset_real_T(&gpu_yc2);
  gpuEmxReset_real_T(&gpu_zo);
  gpuEmxReset_real_T(&gpu__1);
  gpuEmxReset_real_T(&gpu_xt);
  gpuEmxReset_real_T(&gpu_dv);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_z);
  gpuEmxReset_real_T(&gpu_a);
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_real_T(&gpu_x);
  zo_outdatedOnCpu = false;
  b_zo_outdatedOnGpu = false;
  yc2_outdatedOnGpu = false;
  yc5_outdatedOnGpu = false;
  z_outdatedOnGpu = true;
  a_outdatedOnGpu = true;
  b_outdatedOnGpu = true;
  x_outdatedOnGpu = true;
  z_needsGpuEnsureCapacity = true;
  yc3_outdatedOnGpu = true;
  zo_outdatedOnGpu = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  //  [ec_filtfilt1] helper function for ec_filtfilt()
  //  FILTFILT Zero-phase forward and reverse digital IIR filtering.
  //    Y = FILTFILT(B,A,X) filters the data in vector, matrix, or N-D
  //    array, X, with the filter described by vectors A and B to create
  //    the filtered data Y. The filter is described by the difference
  //    equation:
  //
  //      a(1)*y(n) = b(1)*x(n) + b(2)*x(n-1) + ... + b(nb+1)*x(n-nb)
  //                            - a(2)*y(n-1) - ... - a(na+1)*y(n-na)
  //
  //    filtfilt operates along the first dimension of X except when X is a
  //    row vector in which case it operates along the second dimension.
  //    The length of the input channels must be more than three times the
  //    filter order, defined as max(length(B)-1,length(A)-1).
  //
  //    Y = FILTFILT(SOS,G,X) filters the data in vector, matrix, or N-D
  //    array, X, with the second-order section (SOS) filter described by
  //    the matrix SOS and the vector G. The coefficients of the SOS matrix
  //    must be expressed using an Lx6 matrix where L is the number of
  //    second-order sections. The scale values of the filter must be
  //    expressed using the vector G. The length of G must be between 1 and
  //    L+1, and the length of input channels in X must be more than three
  //    times the filter order (input channel length must be greater than
  //    one when the order is zero). You can use filtord(SOS) to get the
  //    order of the filter. The SOS matrix should have the following form:
  //
  //    SOS = [ b01 b11 b21 a01 a11 a21
  //            b02 b12 b22 a02 a12 a22
  //            ...
  //            b0L b1L b2L a0L a1L a2L ]
  //
  //    Y = FILTFILT(D,X) filters the data in vector, matrix, or N-D
  //    array, X, with the digital filter D. You design a digital filter,
  //    D, by calling the <a href="matlab:help designfilt">designfilt</a>
  //    function. The length of the input channels in X must be more than
  //    three times the filter order. You can use filtord(D) to get the
  //    order of the digital filter D.
  //
  //    After filtering in the forward direction, the filtered data is
  //    reversed and run back through the filter; Y is the time reverse of
  //    the output of the second filtering operation. The result has
  //    precisely zero phase distortion, and magnitude modified by the
  //    square of the filter's magnitude response. Startup and ending
  //    transients are minimized by matching initial conditions.
  //
  //    Note that FILTFILT should not be used when the intent of a filter
  //    is to modify signal phase, such as differentiators and Hilbert
  //    filters.
  //
  //    % Example 1:
  //    %   Zero-phase filter a noisy ECG waveform using an IIR filter.
  //
  //    load noisysignals x;                    % noisy waveform
  //    [b,a] = butter(12,0.2,'low');           % IIR filter design
  //    y = filtfilt(b,a,x);                    % zero-phase filtering
  //    y2 = filter(b,a,x);                     % conventional filtering
  //    plot(x,'k-.'); grid on ; hold on
  //    plot([y y2],'LineWidth',1.5);
  //    legend('Noisy ECG','Zero-phase Filtering','Conventional Filtering');
  //
  //    % Example 2:
  //    %   Use the designfilt function to design a highpass IIR digital
  //    %   filter with order 4, passband frequency of 75 KHz, and a passband
  //    %   ripple of 0.2 dB. Sample rate is 200 KHz. Apply zero-phase
  //    %   filtering to a vector of data.
  //
  //    D = designfilt('highpassiir', 'FilterOrder', 4, ...
  //             'PassbandFrequency', 75e3, 'PassbandRipple', 0.2,...
  //             'SampleRate', 200e3);
  //
  //    x = rand(1000,1);
  //    y = filtfilt(D,x);
  //
  //    See also FILTER, SOSFILT.
  //    References:
  //      [1] Sanjit K. Mitra, Digital Signal Processing, 2nd ed.,
  //          McGraw-Hill, 2001
  //      [2] Fredrik Gustafsson, Determining the initial states in forward-
  //          backward filtering, IEEE Transactions on Signal Processing,
  //          pp. 988-992, April 1996, Volume 44, Issue 4
  //    Copyright 1988-2022 The MathWorks, Inc.
  //
  //  For filtfilt(D,X), the inputs passed to the function are B,A,X thanks
  //  to the method of D.
  //  Input validation
  // 'ec_filtfilt1:89' lfn = coder.target('MATLAB');
  // 'ec_filtfilt1:90' if ~lfn
  // 'ec_filtfilt1:91'
  // validateattributes(b,{'double','single'},{'2d','finite','nonempty'},'filtfilt');
  // 'ec_filtfilt1:92'
  // validateattributes(a,{'double','single'},{'2d','finite','vector','nonempty'},'filtfilt');
  // 'ec_filtfilt1:93'
  // validateattributes(x,{'double','single'},{'2d','finite','nonempty'},'filtfilt');
  //  Run
  // 'ec_filtfilt1:99' y = coder.nullcopy(x);
  yc5_outdatedOnCpu = false;
  i = cpu_y->size[0] * cpu_y->size[1];
  cpu_y->size[0] = cpu_x->size[0];
  cpu_y->size[1] = cpu_x->size[1];
  emxEnsureCapacity_real_T(cpu_y, i, &emlrtRTEI);
  y_needsGpuEnsureCapacity = true;
  //  Loop across chans
  // 'ec_filtfilt1:102' for ch = 1:width(x)
  b_i = cpu_x->size[1];
  if (cpu_x->size[1] - 1 >= 0) {
    i1 = static_cast<int32_T>(L);
    if (static_cast<int32_T>(L) - 1 >= 0) {
      if (nf + 1.0 < 2.0) {
        i2 = 1;
        i3 = 1;
        i4 = 0;
      } else {
        i2 = static_cast<int32_T>(nf + 1.0);
        i3 = -1;
        i4 = 2;
      }
      csz_idx_0 = div_s32(i4 - i2, i3) + 1;
    }
  }
  emxInit_real_T(&cpu_dv, 1, &f_emlrtRTEI, true);
  emxInit_real_T(&cpu_xt, 1, &g_emlrtRTEI, true);
  emxInit_real_T(&cpu__1, 1, &h_emlrtRTEI, true);
  emxInit_real_T(&cpu_zo, 1, &h_emlrtRTEI, true);
  emxInit_real_T(&cpu_yc2, 1, &h_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_zo, 1, &h_emlrtRTEI, true);
  emxInit_real_T(&cpu_c, 1, &i_emlrtRTEI, true);
  emxInit_real_T(&cpu_yc3, 1, &j_emlrtRTEI, true);
  emxInit_real_T(&cpu__2, 1, &h_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_zo, 1, &h_emlrtRTEI, true);
  emxInit_real_T(&cpu_yc5, 1, &k_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_b, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_a, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_z, 1, &e_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_b, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_a, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_b, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_a, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_b, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_a, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_yc3, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_z, 1, &e_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_b, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_a, 1, &d_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_yc2, 1, &d_emlrtRTEI, true);
  for (int32_T ch{0}; ch < b_i; ch++) {
    int32_T i5;
    boolean_T validLaunchParams;
    // 'ec_filtfilt1:103' y(:,ch) = filtfilt_lfn(x(:,ch),b,a,z,nf,L);
    i = cpu_dv->size[0];
    cpu_dv->size[0] = cpu_x->size[0];
    emxEnsureCapacity_real_T(cpu_dv, i, &b_emlrtRTEI);
    i = cpu_x->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    if (x_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
    }
    x_needsGpuEnsureCapacity = false;
    gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
    if (x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
    }
    x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_filtfilt1_kernel1<<<grid, block>>>(ch, gpu_x, i, gpu_dv,
                                            cpu_x->size[0U]);
    }
    dv_outdatedOnGpu = false;
    //  oneCh_lfn %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    //  Perform filtering of input data with no phase distortion
    //
    //  xc: matrix of input data
    //  yc: matrix of output data, same dimensions as xc
    //  a,b: IIR coefficients, both of same order/length
    //  zi: initial states
    //  nfact: scalar
    //  L: scalar
    //  odt: output data type
    //
    //  Same comments as in ffOneChan, except here we need to use bsxfun.
    //  Instead of doing scalar subtraction with a vector, we are doing
    //  vector addition with a matrix.  bsxfun replicates the vector
    //  for us.
    //
    //  We also take care to preserve column dimensions
    // coder.gpu.nokernel(); % No kernel due to dependencies across loops
    // coder.gpu.kernelfun; % Add kernelfun pragma to trigger kernel creation
    //  Loop by L
    // 'ec_filtfilt1:131' for ii = 1:L
    for (int32_T ii{0}; ii < i1; ii++) {
      real_T a;
      int32_T bcoef;
      int32_T i6;
      int32_T i7;
      boolean_T dv_outdatedOnCpu;
      // 'ec_filtfilt1:132' xt = bsxfun(@minus, 2*x(1,:),x(nf(1,1)+1:-1:2,:));
      gpuEmxMemcpyGpuToCpu_real_T(cpu_dv, &gpu_dv);
      dv_outdatedOnCpu = false;
      a = 2.0 * cpu_dv->data[0];
      xt_outdatedOnCpu = false;
      yc3_outdatedOnCpu = false;
      i = cpu_xt->size[0];
      cpu_xt->size[0] = csz_idx_0;
      emxEnsureCapacity_real_T(cpu_xt, i, &c_emlrtRTEI);
      if (csz_idx_0 != 0) {
        mwGetLaunchParameters1D(computeNumIters(csz_idx_0 - 1), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
        gpuEmxEnsureCapacity_real_T(cpu_xt, &gpu_xt, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel2<<<grid, block>>>(
              gpu_dv, static_cast<int32_T>(div_s32(i4 - i2, i3) + 1 != 1), i3,
              i2, a, csz_idx_0 - 1, gpu_xt);
        }
        xt_outdatedOnCpu = true;
      }
      // 'ec_filtfilt1:133' [~,zo] =
      // filter(b(:,ii),a(:,ii),xt,z(:,ii)*xt(1,:),1);
      if (xt_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_xt, &gpu_xt);
      }
      a = cpu_xt->data[0];
      i = b_cpu_b->size[0];
      b_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real_T(b_cpu_b, i, &d_emlrtRTEI);
      i = cpu_b->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      if (zo_outdatedOnGpu) {
        gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, !b_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_real_T(b_cpu_b, &b_gpu_b, true);
      if (b_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel3<<<grid, block>>>(gpu_b, i, b_gpu_b);
      }
      b_outdatedOnGpu = false;
      b_outdatedOnCpu = true;
      i = b_cpu_a->size[0];
      b_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real_T(b_cpu_a, i, &d_emlrtRTEI);
      i = cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      if (yc3_outdatedOnGpu) {
        gpuEmxEnsureCapacity_real_T(cpu_a, &gpu_a, !a_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_real_T(b_cpu_a, &b_gpu_a, true);
      if (a_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel4<<<grid, block>>>(gpu_a, i, b_gpu_a);
      }
      a_outdatedOnGpu = false;
      a_outdatedOnCpu = true;
      i = b_cpu_z->size[0];
      b_cpu_z->size[0] = cpu_z->size[0];
      emxEnsureCapacity_real_T(b_cpu_z, i, &e_emlrtRTEI);
      i = cpu_z->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      if (z_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z, !z_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_real_T(b_cpu_z, &b_gpu_z, true);
      if (z_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, cpu_z);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel5<<<grid, block>>>(a, gpu_z, i, b_gpu_z);
      }
      z_outdatedOnGpu = false;
      yc2_outdatedOnCpu = true;
      coder::filter(b_cpu_b, &b_outdatedOnCpu, &b_gpu_b, &b_outdatedOnGpu,
                    b_cpu_a, &a_outdatedOnCpu, &b_gpu_a, &a_outdatedOnGpu,
                    cpu_xt, &gpu_xt, &yc3_outdatedOnCpu, b_cpu_z,
                    &yc2_outdatedOnCpu, &b_gpu_z, &z_outdatedOnGpu, cpu__1,
                    &yc5_outdatedOnCpu, &gpu__1, &yc5_outdatedOnGpu, cpu_zo,
                    &yc3_outdatedOnGpu, &gpu_zo, &zo_outdatedOnGpu);
      //  outer product
      // 'ec_filtfilt1:134' [yc2,zo] = filter(b(:,ii),a(:,ii),x,zo,1);
      i = c_cpu_b->size[0];
      c_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real_T(c_cpu_b, i, &d_emlrtRTEI);
      i = cpu_b->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(c_cpu_b, &c_gpu_b, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel6<<<grid, block>>>(gpu_b, i, c_gpu_b);
      }
      b_outdatedOnGpu = false;
      b_outdatedOnCpu = true;
      i = c_cpu_a->size[0];
      c_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real_T(c_cpu_a, i, &d_emlrtRTEI);
      i = cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(c_cpu_a, &c_gpu_a, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel7<<<grid, block>>>(gpu_a, i, c_gpu_a);
      }
      a_outdatedOnGpu = false;
      a_outdatedOnCpu = true;
      coder::filter(c_cpu_b, &b_outdatedOnCpu, &c_gpu_b, &b_outdatedOnGpu,
                    c_cpu_a, &a_outdatedOnCpu, &c_gpu_a, &a_outdatedOnGpu,
                    cpu_dv, &gpu_dv, &dv_outdatedOnGpu, cpu_zo,
                    &yc3_outdatedOnGpu, &gpu_zo, &zo_outdatedOnGpu, cpu_yc2,
                    &yc2_outdatedOnCpu, &gpu_yc2, &yc2_outdatedOnGpu, b_cpu_zo,
                    &zo_outdatedOnCpu, &b_gpu_zo, &b_zo_outdatedOnGpu);
      // 'ec_filtfilt1:135' xt = bsxfun(@minus,
      // 2*x(end,:),x(end-1:-1:end-nf(1,1),:));
      a = static_cast<real_T>(cpu_dv->size[0]) - nf;
      if (a > static_cast<real_T>(cpu_dv->size[0]) - 1.0) {
        i6 = 1;
        i7 = 1;
        i5 = 0;
      } else {
        i6 = cpu_dv->size[0] - 1;
        i7 = -1;
        i5 = static_cast<int32_T>(a);
      }
      // 'ec_filtfilt1:136' yc3 = filter(b(:,ii),a(:,ii),xt,zo,1);
      if (dv_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_dv, &gpu_dv);
      }
      a = 2.0 * cpu_dv->data[cpu_dv->size[0] - 1];
      i = div_s32(i5 - i6, i7) + 1;
      yc5_outdatedOnCpu = false;
      yc5_outdatedOnGpu = false;
      bcoef = cpu_c->size[0];
      cpu_c->size[0] = i;
      emxEnsureCapacity_real_T(cpu_c, bcoef, &c_emlrtRTEI);
      if (i != 0) {
        mwGetLaunchParameters1D(computeNumIters(i - 1), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, !dv_outdatedOnGpu);
        gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c, true);
        if (dv_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv, cpu_dv);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel8<<<grid, block>>>(
              gpu_dv, static_cast<int32_T>(div_s32(i5 - i6, i7) + 1 != 1), i7,
              i6, a, i - 1, gpu_c);
        }
        yc5_outdatedOnCpu = true;
      }
      i = d_cpu_b->size[0];
      d_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real_T(d_cpu_b, i, &d_emlrtRTEI);
      i = cpu_b->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(d_cpu_b, &d_gpu_b, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel9<<<grid, block>>>(gpu_b, i, d_gpu_b);
      }
      b_outdatedOnGpu = false;
      b_outdatedOnCpu = true;
      i = d_cpu_a->size[0];
      d_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real_T(d_cpu_a, i, &d_emlrtRTEI);
      i = cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(d_cpu_a, &d_gpu_a, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel10<<<grid, block>>>(gpu_a, i, d_gpu_a);
      }
      a_outdatedOnGpu = false;
      a_outdatedOnCpu = true;
      coder::b_filter(d_cpu_b, &b_outdatedOnCpu, &d_gpu_b, &b_outdatedOnGpu,
                      d_cpu_a, &a_outdatedOnCpu, &d_gpu_a, &a_outdatedOnGpu,
                      cpu_c, &gpu_c, &yc5_outdatedOnGpu, b_cpu_zo,
                      &zo_outdatedOnCpu, &b_gpu_zo, &b_zo_outdatedOnGpu,
                      cpu_yc3, &yc3_outdatedOnCpu, &gpu_yc3,
                      &yc3_outdatedOnGpu);
      // 'ec_filtfilt1:138' [~,zo] =
      // filter(b(:,ii),a(:,ii),yc3(end:-1:1,:),z(:,ii)*yc3(end,:),1);
      if (cpu_yc3->size[0] < 1) {
        i5 = 0;
        bcoef = 1;
        i6 = -1;
      } else {
        i5 = cpu_yc3->size[0] - 1;
        bcoef = -1;
        i6 = 0;
      }
      if (yc3_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_yc3, &gpu_yc3);
      }
      a = cpu_yc3->data[cpu_yc3->size[0] - 1];
      i = e_cpu_b->size[0];
      e_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real_T(e_cpu_b, i, &d_emlrtRTEI);
      i = cpu_b->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(e_cpu_b, &e_gpu_b, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel11<<<grid, block>>>(gpu_b, i, e_gpu_b);
      }
      b_outdatedOnGpu = false;
      b_outdatedOnCpu = true;
      i = e_cpu_a->size[0];
      e_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real_T(e_cpu_a, i, &d_emlrtRTEI);
      i = cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(e_cpu_a, &e_gpu_a, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel12<<<grid, block>>>(gpu_a, i, e_gpu_a);
      }
      a_outdatedOnGpu = false;
      a_outdatedOnCpu = true;
      i = b_cpu_yc3->size[0];
      b_cpu_yc3->size[0] = div_s32(i6 - i5, bcoef) + 1;
      emxEnsureCapacity_real_T(b_cpu_yc3, i, &d_emlrtRTEI);
      i = (i6 - i5) / bcoef;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_yc3, &gpu_yc3, !yc3_outdatedOnGpu);
      gpuEmxEnsureCapacity_real_T(b_cpu_yc3, &b_gpu_yc3, true);
      if (yc3_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_yc3, cpu_yc3);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel13<<<grid, block>>>(gpu_yc3, bcoef, i5, i,
                                               b_gpu_yc3);
      }
      yc3_outdatedOnGpu = false;
      i = c_cpu_z->size[0];
      c_cpu_z->size[0] = cpu_z->size[0];
      emxEnsureCapacity_real_T(c_cpu_z, i, &e_emlrtRTEI);
      i = cpu_z->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      z_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_real_T(c_cpu_z, &c_gpu_z, true);
      z_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel14<<<grid, block>>>(a, gpu_z, i, c_gpu_z);
      }
      xt_outdatedOnCpu = false;
      yc2_outdatedOnCpu = true;
      coder::filter(e_cpu_b, &b_outdatedOnCpu, &e_gpu_b, &b_outdatedOnGpu,
                    e_cpu_a, &a_outdatedOnCpu, &e_gpu_a, &a_outdatedOnGpu,
                    b_cpu_yc3, &b_gpu_yc3, &yc3_outdatedOnGpu, c_cpu_z,
                    &yc2_outdatedOnCpu, &c_gpu_z, &xt_outdatedOnCpu, cpu__2,
                    &yc5_outdatedOnCpu, &gpu__2, &yc5_outdatedOnGpu, c_cpu_zo,
                    &zo_outdatedOnCpu, &c_gpu_zo, &b_zo_outdatedOnGpu);
      //  outer product
      // 'ec_filtfilt1:139' yc5 = filter(b(:,ii),a(:,ii),yc2(end:-1:1,:),zo,1);
      if (cpu_yc2->size[0] < 1) {
        i5 = 0;
        bcoef = 1;
        i6 = -1;
      } else {
        i5 = cpu_yc2->size[0] - 1;
        bcoef = -1;
        i6 = 0;
      }
      i = f_cpu_b->size[0];
      f_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real_T(f_cpu_b, i, &d_emlrtRTEI);
      i = cpu_b->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      zo_outdatedOnGpu = false;
      gpuEmxEnsureCapacity_real_T(f_cpu_b, &f_gpu_b, true);
      b_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel15<<<grid, block>>>(gpu_b, i, f_gpu_b);
      }
      xt_outdatedOnCpu = false;
      b_outdatedOnCpu = true;
      i = f_cpu_a->size[0];
      f_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real_T(f_cpu_a, i, &d_emlrtRTEI);
      i = cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      yc3_outdatedOnGpu = false;
      gpuEmxEnsureCapacity_real_T(f_cpu_a, &f_gpu_a, true);
      a_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel16<<<grid, block>>>(gpu_a, i, f_gpu_a);
      }
      yc3_outdatedOnCpu = false;
      a_outdatedOnCpu = true;
      i = b_cpu_yc2->size[0];
      b_cpu_yc2->size[0] = div_s32(i6 - i5, bcoef) + 1;
      emxEnsureCapacity_real_T(b_cpu_yc2, i, &d_emlrtRTEI);
      i = (i6 - i5) / bcoef;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_yc2, &gpu_yc2, !yc2_outdatedOnGpu);
      gpuEmxEnsureCapacity_real_T(b_cpu_yc2, &b_gpu_yc2, true);
      if (yc2_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_yc2, cpu_yc2);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel17<<<grid, block>>>(gpu_yc2, bcoef, i5, i,
                                               b_gpu_yc2);
      }
      yc2_outdatedOnGpu = false;
      coder::b_filter(f_cpu_b, &b_outdatedOnCpu, &f_gpu_b, &xt_outdatedOnCpu,
                      f_cpu_a, &a_outdatedOnCpu, &f_gpu_a, &yc3_outdatedOnCpu,
                      b_cpu_yc2, &b_gpu_yc2, &yc2_outdatedOnGpu, c_cpu_zo,
                      &zo_outdatedOnCpu, &c_gpu_zo, &b_zo_outdatedOnGpu,
                      cpu_yc5, &yc5_outdatedOnCpu, &gpu_yc5,
                      &yc5_outdatedOnGpu);
      // 'ec_filtfilt1:141' x = yc5(end:-1:1,:);
      if (cpu_yc5->size[0] < 1) {
        i5 = 0;
        bcoef = 1;
        i6 = -1;
      } else {
        i5 = cpu_yc5->size[0] - 1;
        bcoef = -1;
        i6 = 0;
      }
      i = cpu_dv->size[0];
      cpu_dv->size[0] = div_s32(i6 - i5, bcoef) + 1;
      emxEnsureCapacity_real_T(cpu_dv, i, &d_emlrtRTEI);
      i = (i6 - i5) / bcoef;
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_yc5, &gpu_yc5, !yc5_outdatedOnGpu);
      gpuEmxEnsureCapacity_real_T(cpu_dv, &gpu_dv, true);
      if (yc5_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_yc5, cpu_yc5);
      }
      yc5_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel18<<<grid, block>>>(gpu_yc5, bcoef, i5, i, gpu_dv);
      }
      dv_outdatedOnGpu = false;
    }
    //  LocalWords:  x b a nf L
    //  LocalWords:  Lx th zi nfilt xc yc IIR nfact xt unreversed nullcopy Npts
    //  nb na yout LocalWords:  Nchans filtord designfilt noisysignals
    //  highpassiir Sanjit Mitra LocalWords:  nd Graw Fredrik Gustafsson
    i5 = cpu_y->size[0];
    mwGetLaunchParameters1D(computeNumIters(i5 - 1), &grid, &block,
                            2147483647U);
    if (y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
    }
    y_needsGpuEnsureCapacity = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_filtfilt1_kernel19<<<grid, block>>>(gpu_dv, ch, i5 - 1, gpu_y,
                                             cpu_y->size[0U]);
    }
    yc5_outdatedOnCpu = true;
  }
  emxFree_real_T(&b_cpu_yc2);
  emxFree_real_T(&f_cpu_a);
  emxFree_real_T(&f_cpu_b);
  emxFree_real_T(&c_cpu_z);
  emxFree_real_T(&b_cpu_yc3);
  emxFree_real_T(&e_cpu_a);
  emxFree_real_T(&e_cpu_b);
  emxFree_real_T(&d_cpu_a);
  emxFree_real_T(&d_cpu_b);
  emxFree_real_T(&c_cpu_a);
  emxFree_real_T(&c_cpu_b);
  emxFree_real_T(&b_cpu_z);
  emxFree_real_T(&b_cpu_a);
  emxFree_real_T(&b_cpu_b);
  emxFree_real_T(&cpu_yc5);
  emxFree_real_T(&c_cpu_zo);
  emxFree_real_T(&cpu__2);
  emxFree_real_T(&cpu_yc3);
  emxFree_real_T(&cpu_c);
  emxFree_real_T(&b_cpu_zo);
  emxFree_real_T(&cpu_yc2);
  emxFree_real_T(&cpu_zo);
  emxFree_real_T(&cpu__1);
  emxFree_real_T(&cpu_xt);
  emxFree_real_T(&cpu_dv);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (yc5_outdatedOnCpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_y, &gpu_y);
  }
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_b);
  gpuEmxFree_real_T(&gpu_a);
  gpuEmxFree_real_T(&gpu_z);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_real_T(&gpu_dv);
  gpuEmxFree_real_T(&gpu_xt);
  gpuEmxFree_real_T(&gpu__1);
  gpuEmxFree_real_T(&gpu_zo);
  gpuEmxFree_real_T(&gpu_yc2);
  gpuEmxFree_real_T(&b_gpu_zo);
  gpuEmxFree_real_T(&gpu_c);
  gpuEmxFree_real_T(&gpu_yc3);
  gpuEmxFree_real_T(&gpu__2);
  gpuEmxFree_real_T(&c_gpu_zo);
  gpuEmxFree_real_T(&gpu_yc5);
  gpuEmxFree_real_T(&b_gpu_b);
  gpuEmxFree_real_T(&b_gpu_a);
  gpuEmxFree_real_T(&b_gpu_z);
  gpuEmxFree_real_T(&c_gpu_b);
  gpuEmxFree_real_T(&c_gpu_a);
  gpuEmxFree_real_T(&d_gpu_b);
  gpuEmxFree_real_T(&d_gpu_a);
  gpuEmxFree_real_T(&e_gpu_b);
  gpuEmxFree_real_T(&e_gpu_a);
  gpuEmxFree_real_T(&b_gpu_yc3);
  gpuEmxFree_real_T(&c_gpu_z);
  gpuEmxFree_real_T(&f_gpu_b);
  gpuEmxFree_real_T(&f_gpu_a);
  gpuEmxFree_real_T(&b_gpu_yc2);
}

// End of code generation (ec_filtfilt1.cu)
