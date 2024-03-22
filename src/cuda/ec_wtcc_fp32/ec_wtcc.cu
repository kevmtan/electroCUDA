//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtcc.cu
//
// Code generation for function 'ec_wtcc'
//

// Include files
#include "ec_wtcc.h"
#include "conv2.h"
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "firls.h"
#include "kaiser.h"
#include "mod.h"
#include "rat.h"
#include "resample.h"
#include "rt_nonfinite.h"
#include "uniformResampleKernel.h"
#include "wcoherence.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "math_constants.h"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo emlrtRTEI{
    1,                                                   // lineNo
    20,                                                  // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    19,                                                  // lineNo
    21,                                                  // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    28,                                                  // lineNo
    29,                                                  // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    28,                                                  // lineNo
    41,                                                  // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    39,                                                  // lineNo
    1,                                                   // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    39,                                                  // lineNo
    9,                                                   // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    28,                                                  // lineNo
    12,                                                  // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    28,                                                  // lineNo
    6,                                                   // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo q_emlrtRTEI{
    43,                                                  // lineNo
    5,                                                   // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    44,                                                  // lineNo
    19,                                                  // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo x_emlrtRTEI{
    35,                                                  // lineNo
    14,                                                  // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

static emlrtRTEInfo y_emlrtRTEI{
    48,                                                  // lineNo
    6,                                                   // colNo
    "ec_wtcc",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_wtcc.m" // pName
};

// Function Declarations
static __global__ void ec_wtcc_kernel1(const int32_T c, const int32_T vlen,
                                       const emxArray_real32_T x,
                                       const int32_T b_x, emxArray_real32_T x2,
                                       emxArray_real32_T x1, int32_T x_dim0);

static __global__ void ec_wtcc_kernel10(const emxArray_uint32_T y,
                                        const real_T nZeroBegin,
                                        const int32_T b_y,
                                        emxArray_int32_T iv1);

static __global__ void ec_wtcc_kernel11(const emxArray_real32_T opts_filter,
                                        const emxArray_int32_T iv1,
                                        const int32_T b_iv1,
                                        emxArray_real32_T h);

static __global__ void ec_wtcc_kernel12(const emxArray_real32_T opts_x,
                                        const int32_T b_opts_x,
                                        emxArray_real32_T b_y1);

static __global__ void ec_wtcc_kernel13(const emxArray_real32_T b_y1,
                                        const int32_T b, emxArray_real32_T fv);

static __global__ void ec_wtcc_kernel14(const emxArray_creal32_T yp,
                                        const int32_T b, emxArray_real32_T y);

static __global__ void ec_wtcc_kernel15(const emxArray_real32_T opts_x,
                                        const int32_T b_opts_x,
                                        emxArray_real32_T fv);

static __global__ void ec_wtcc_kernel16(const emxArray_real32_T w,
                                        const int32_T vlen, const int32_T b,
                                        emxArray_real32_T y);

static __global__ void ec_wtcc_kernel17(emxArray_real_T y);

static __global__ void
ec_wtcc_kernel18(const emxArray_real32_T y, const emxArray_real_T b_y,
                 const real_T opts_filterDelay, const int32_T ii,
                 const int32_T b, emxArray_real32_T b_y1, int32_T y1_dim0);

static __global__ void ec_wtcc_kernel19(const int32_T b, emxArray_real_T y);

static __global__ void ec_wtcc_kernel2(const emxArray_real32_T xp,
                                       const int32_T b_xp, const int32_T c_xp,
                                       emxArray_real32_T fv, int32_T fv_dim0,
                                       int32_T xp_dim0);

static __global__ void ec_wtcc_kernel20(const emxArray_real32_T b_y1,
                                        const int32_T b, emxArray_real32_T fv);

static __global__ void ec_wtcc_kernel21(const emxArray_real32_T b_y1,
                                        const int32_T c_y1, const int32_T d_y1,
                                        emxArray_real32_T fv, int32_T fv_dim0,
                                        int32_T y1_dim0);

static __global__ void ec_wtcc_kernel22(const emxArray_real32_T opts_x,
                                        const int32_T b_opts_x,
                                        emxArray_real32_T b_y1);

static __global__ void ec_wtcc_kernel23(const int32_T b, emxArray_uint32_T y);

static __global__ void ec_wtcc_kernel24(const emxArray_real32_T fv,
                                        const int32_T b_fv,
                                        emxArray_real32_T opts_x);

static __global__ void ec_wtcc_kernel25(const emxArray_real32_T fv,
                                        const int32_T b_fv, const int32_T c_fv,
                                        emxArray_real32_T opts_x,
                                        int32_T opts_x_dim0, int32_T fv_dim0);

static __global__ void ec_wtcc_kernel3(const emxArray_creal32_T yp,
                                       const int32_T b_yp, const int32_T c_yp,
                                       emxArray_creal32_T d_yp, int32_T yp_dim0,
                                       int32_T b_yp_dim0);

static __global__ void ec_wtcc_kernel4(const emxArray_real32_T fv,
                                       const int32_T b,
                                       emxArray_real32_T opts_x);

static __global__ void ec_wtcc_kernel5(const emxArray_real_T r,
                                       const int32_T b_r,
                                       emxArray_real_T b_dv1);

static __global__ void ec_wtcc_kernel6(const emxArray_real_T b_dv2,
                                       const emxArray_real_T b_dv1,
                                       const int32_T c_dv1, emxArray_real_T h1);

static __global__ void ec_wtcc_kernel7(const real_T pqmax, const real_T opts_p,
                                       const int32_T h1, emxArray_real_T b_h1);

static __global__ void ec_wtcc_kernel8(const emxArray_real_T h1,
                                       const int32_T b_h1,
                                       emxArray_real32_T opts_filter);

static __global__ void ec_wtcc_kernel9(const int32_T nZeroBegin,
                                       emxArray_real32_T h);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel1(
    const int32_T c, const int32_T vlen, const emxArray_real32_T x,
    const int32_T b_x, emxArray_real32_T x2, emxArray_real32_T x1,
    int32_T x_dim0)
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
    x1.data[i1] = x.data[i1 + x_dim0 * (vlen - 1)];
    x2.data[i1] = x.data[i1 + x_dim0 * (c - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel10(
    const emxArray_uint32_T y, const real_T nZeroBegin, const int32_T b_y,
    emxArray_int32_T iv1)
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
    iv1.data[i1] =
        static_cast<int32_T>(nZeroBegin + static_cast<real_T>(y.data[i1]));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel11(
    const emxArray_real32_T opts_filter, const emxArray_int32_T iv1,
    const int32_T b_iv1, emxArray_real32_T h)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_iv1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    h.data[iv1.data[i1] - 1] = opts_filter.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel12(
    const emxArray_real32_T opts_x, const int32_T b_opts_x,
    emxArray_real32_T b_y1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_opts_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    b_y1.data[i1] = opts_x.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel13(
    const emxArray_real32_T b_y1, const int32_T b, emxArray_real32_T fv)
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
    fv.data[i1] = b_y1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel14(
    const emxArray_creal32_T yp, const int32_T b, emxArray_real32_T y)
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
    y.data[k] = atan2f(yp.data[k].im, yp.data[k].re);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel15(
    const emxArray_real32_T opts_x, const int32_T b_opts_x,
    emxArray_real32_T fv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_opts_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    fv.data[i1] = opts_x.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel16(
    const emxArray_real32_T w, const int32_T vlen, const int32_T b,
    emxArray_real32_T y)
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
                                    1) void ec_wtcc_kernel17(emxArray_real_T y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel18(
    const emxArray_real32_T y, const emxArray_real_T b_y,
    const real_T opts_filterDelay, const int32_T ii, const int32_T b,
    emxArray_real32_T b_y1, int32_T y1_dim0)
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
                                    1) void ec_wtcc_kernel19(const int32_T b,
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

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel2(
    const emxArray_real32_T xp, const int32_T b_xp, const int32_T c_xp,
    emxArray_real32_T fv, int32_T fv_dim0, int32_T xp_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_xp) + 1UL) *
                (static_cast<uint64_T>(b_xp) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xp) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_xp) + 1UL));
    fv.data[k + fv_dim0 * i1] = xp.data[i1 + xp_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel20(
    const emxArray_real32_T b_y1, const int32_T b, emxArray_real32_T fv)
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
    fv.data[i1] = b_y1.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel21(
    const emxArray_real32_T b_y1, const int32_T c_y1, const int32_T d_y1,
    emxArray_real32_T fv, int32_T fv_dim0, int32_T y1_dim0)
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
    fv.data[k + fv_dim0 * i1] = b_y1.data[i1 + y1_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel22(
    const emxArray_real32_T opts_x, const int32_T b_opts_x,
    emxArray_real32_T b_y1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_opts_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    b_y1.data[i1] = opts_x.data[i1];
  }
}

static __global__
    __launch_bounds__(1024, 1) void ec_wtcc_kernel23(const int32_T b,
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

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel24(
    const emxArray_real32_T fv, const int32_T b_fv, emxArray_real32_T opts_x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    opts_x.data[i1] = fv.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel25(
    const emxArray_real32_T fv, const int32_T b_fv, const int32_T c_fv,
    emxArray_real32_T opts_x, int32_T opts_x_dim0, int32_T fv_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_fv) + 1UL) *
                (static_cast<uint64_T>(b_fv) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fv) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_fv) + 1UL));
    opts_x.data[k + opts_x_dim0 * i1] = fv.data[i1 + fv_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel3(
    const emxArray_creal32_T yp, const int32_T b_yp, const int32_T c_yp,
    emxArray_creal32_T d_yp, int32_T yp_dim0, int32_T b_yp_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_yp) + 1UL) *
                (static_cast<uint64_T>(b_yp) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_yp) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_yp) + 1UL));
    d_yp.data[k + yp_dim0 * i1].re = yp.data[i1 + b_yp_dim0 * k].re;
    d_yp.data[k + yp_dim0 * i1].im = -yp.data[i1 + b_yp_dim0 * k].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel4(
    const emxArray_real32_T fv, const int32_T b, emxArray_real32_T opts_x)
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
    opts_x.data[i1] = fv.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel5(
    const emxArray_real_T r, const int32_T b_r, emxArray_real_T b_dv1)
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
    b_dv1.data[i1] = r.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel6(
    const emxArray_real_T b_dv2, const emxArray_real_T b_dv1,
    const int32_T c_dv1, emxArray_real_T h1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_dv1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    h1.data[i1] = b_dv1.data[i1] * b_dv2.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel7(
    const real_T pqmax, const real_T opts_p, const int32_T h1,
    emxArray_real_T b_h1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(h1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    b_h1.data[i1] = opts_p * b_h1.data[i1] / pqmax;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_wtcc_kernel8(
    const emxArray_real_T h1, const int32_T b_h1, emxArray_real32_T opts_filter)
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
    opts_filter.data[i1] = static_cast<real32_T>(h1.data[i1]);
  }
}

static __global__
    __launch_bounds__(1024, 1) void ec_wtcc_kernel9(const int32_T nZeroBegin,
                                                    emxArray_real32_T h)
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
    h.data[i1] = 0.0F;
  }
}

//
// function [xx,yy] = ec_wtcc(x,c,fs,fLims,fVoices,ds)
void ec_wtcc(const emxArray_real32_T *cpu_x, const emxArray_uint16_T *c,
             real_T fs, const real_T fLims[2], real_T fVoices, real_T ds[2],
             emxArray_cell_wrap_0 *xx, emxArray_cell_wrap_0 *yy)
{
  static const int32_T iv2[2]{1, 7};
  static const int32_T iv3[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  dim3 block;
  dim3 grid;
  emxArray_creal32_T b_gpu_yp;
  emxArray_creal32_T c_gpu_yp;
  emxArray_creal32_T gpu_yp;
  emxArray_creal32_T *b_cpu_yp;
  emxArray_creal32_T *c_cpu_yp;
  emxArray_creal32_T *cpu_yp;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T *cpu_iv1;
  emxArray_real32_T b_gpu_y;
  emxArray_real32_T b_yCol;
  emxArray_real32_T c_gpu_y;
  emxArray_real32_T gpu_fv;
  emxArray_real32_T gpu_h;
  emxArray_real32_T gpu_opts_filter;
  emxArray_real32_T gpu_opts_x;
  emxArray_real32_T gpu_w;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_x1;
  emxArray_real32_T gpu_x2;
  emxArray_real32_T gpu_xp;
  emxArray_real32_T gpu_y1;
  emxArray_real32_T *c_cpu_y;
  emxArray_real32_T *cpu_fv;
  emxArray_real32_T *cpu_h;
  emxArray_real32_T *cpu_opts_filter;
  emxArray_real32_T *cpu_opts_x;
  emxArray_real32_T *cpu_w;
  emxArray_real32_T *cpu_x1;
  emxArray_real32_T *cpu_x2;
  emxArray_real32_T *cpu_xp;
  emxArray_real32_T *cpu_y;
  emxArray_real32_T *cpu_y1;
  emxArray_real32_T *yCol;
  emxArray_real_T d_gpu_y;
  emxArray_real_T gpu_dv1;
  emxArray_real_T gpu_dv2;
  emxArray_real_T gpu_h1;
  emxArray_real_T gpu_r;
  emxArray_real_T *cpu_dv1;
  emxArray_real_T *cpu_dv2;
  emxArray_real_T *cpu_h1;
  emxArray_real_T *cpu_r;
  emxArray_real_T *d_cpu_y;
  emxArray_uint32_T gpu_y;
  emxArray_uint32_T *b_cpu_y;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *y;
  real_T Ly;
  real_T opts_q;
  int32_T opts_x[1];
  int32_T i;
  int32_T i1;
  int32_T i3;
  int32_T i4;
  char_T unusedExpr[23];
  boolean_T b_y_needsGpuEnsureCapacity;
  boolean_T b_yp_outdatedOnCpu;
  boolean_T fv_outdatedOnCpu;
  boolean_T h_outdatedOnCpu;
  boolean_T h_outdatedOnGpu;
  boolean_T opts_isRowVectorInput;
  boolean_T w_outdatedOnCpu;
  boolean_T w_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  boolean_T yp_needsGpuEnsureCapacity;
  boolean_T yp_outdatedOnCpu;
  boolean_T yp_outdatedOnGpu;
  gpuEmxReset_creal32_T(&c_gpu_yp);
  gpuEmxReset_real_T(&gpu_r);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_real32_T(&c_gpu_y);
  gpuEmxReset_real32_T(&gpu_w);
  gpuEmxReset_real32_T(&gpu_y1);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_uint32_T(&gpu_y);
  gpuEmxReset_real32_T(&gpu_h);
  gpuEmxReset_real_T(&gpu_h1);
  gpuEmxReset_real_T(&gpu_dv2);
  gpuEmxReset_real_T(&gpu_dv1);
  gpuEmxReset_real32_T(&gpu_opts_x);
  gpuEmxReset_real32_T(&gpu_opts_filter);
  gpuEmxReset_real32_T(&b_gpu_y);
  gpuEmxReset_creal32_T(&b_gpu_yp);
  gpuEmxReset_real32_T(&gpu_fv);
  gpuEmxReset_creal32_T(&gpu_yp);
  gpuEmxReset_real32_T(&gpu_xp);
  gpuEmxReset_real32_T(&gpu_x2);
  gpuEmxReset_real32_T(&gpu_x1);
  gpuEmxReset_real32_T(&gpu_x);
  w_outdatedOnCpu = false;
  w_outdatedOnGpu = false;
  yp_outdatedOnCpu = false;
  yp_outdatedOnGpu = false;
  x_outdatedOnGpu = true;
  b_y_needsGpuEnsureCapacity = true;
  y_needsGpuEnsureCapacity = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  //  Wavelet coherence & resample
  // 'ec_wtcc:4' x (:,:){mustBeFloat}
  // 'ec_wtcc:5' c (:,2) uint16
  // 'ec_wtcc:6' fs (1,1) double
  // 'ec_wtcc:7' fLims (1,2) double
  // 'ec_wtcc:8' fVoices (1,1) double = 12
  // 'ec_wtcc:9' ds (1,2) double = [1 1]
  //  Trigger kernel creation
  // 'ec_wtcc:13' coder.gpu.kernelfun;
  //  Make vars
  // 'ec_wtcc:16' nPairs = height(c);
  // 'ec_wtcc:17' tmp = cell(1,nPairs);
  i = xx->size[0] * xx->size[1];
  xx->size[0] = 1;
  xx->size[1] = c->size[0];
  emxEnsureCapacity_cell_wrap_0(xx, i, &emlrtRTEI);
  // 'ec_wtcc:18' xx = coder.nullcopy(tmp);
  //  Fix define array error
  // 'ec_wtcc:19' yy = coder.nullcopy(tmp);
  i = yy->size[0] * yy->size[1];
  yy->size[0] = 1;
  yy->size[1] = c->size[0];
  emxEnsureCapacity_cell_wrap_0(yy, i, &b_emlrtRTEI);
  // 'ec_wtcc:21' if ds(1)==0 || ds(2)==0 || ~(ds(2)>ds(1))
  if ((ds[0] == 0.0) || (ds[1] == 0.0) || (!(ds[1] > ds[0]))) {
    // 'ec_wtcc:22' ds(1) = 0;
    ds[0] = 0.0;
    // 'ec_wtcc:23' ds(2) = 0;
    ds[1] = 0.0;
  }
  //  Loop across pairs
  // 'ec_wtcc:27' for p = 1:nPairs
  i1 = c->size[0];
  emxInit_real32_T(&cpu_x1, 1, &c_emlrtRTEI, true);
  emxInit_real32_T(&cpu_x2, 1, &d_emlrtRTEI, true);
  emxInit_real32_T(&cpu_xp, 2, &emlrtRTEI, true);
  emxInit_creal32_T(&cpu_yp, 2, &emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv, 2, &emlrtRTEI, true);
  emxInit_creal32_T(&b_cpu_yp, 2, &x_emlrtRTEI, true);
  emxInit_real32_T(&cpu_y, 2, &y_emlrtRTEI, true);
  emxInit_real32_T(&cpu_opts_filter, 1, &g_emlrtRTEI, true);
  emxInit_real32_T(&cpu_opts_x, 2, &g_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv1, 1, &k_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv2, 1, &k_emlrtRTEI, true);
  emxInit_real_T(&cpu_h1, 1, &l_emlrtRTEI, true);
  emxInit_real32_T(&cpu_h, 1, &m_emlrtRTEI, true);
  emxInit_uint32_T(&b_cpu_y, 2, &ab_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv1, 2, &bb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_y1, 2, &cb_emlrtRTEI, true);
  emxInit_real32_T(&yCol, 1, &db_emlrtRTEI, true);
  emxInit_real32_T(&cpu_w, 1, &v_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_y, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_y, 2, &eb_emlrtRTEI, true);
  emxInit_real_T(&cpu_r, 2, &k_emlrtRTEI, true);
  emxInit_creal32_T(&c_cpu_yp, 2, &u_emlrtRTEI, true);
  for (int32_T p{0}; p < i1; p++) {
    int32_T b_c;
    int32_T vlen;
    int32_T x;
    uint32_T b_dv[2];
    boolean_T validLaunchParams;
    // 'ec_wtcc:28' [xx{p},yy{p}] =
    // wtc_lfn(x(:,c(p,1)),x(:,c(p,2)),fs,fLims,fVoices,ds);
    vlen = c->data[p];
    i = cpu_x1->size[0];
    cpu_x1->size[0] = cpu_x->size[0];
    emxEnsureCapacity_real32_T(cpu_x1, i, &c_emlrtRTEI);
    b_c = c->data[p + c->size[0]];
    i = cpu_x2->size[0];
    cpu_x2->size[0] = cpu_x->size[0];
    emxEnsureCapacity_real32_T(cpu_x2, i, &d_emlrtRTEI);
    x = cpu_x->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(x), &grid, &block, 2147483647U);
    if (x_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real32_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
    }
    x_needsGpuEnsureCapacity = false;
    gpuEmxEnsureCapacity_real32_T(cpu_x2, &gpu_x2, true);
    gpuEmxEnsureCapacity_real32_T(cpu_x1, &gpu_x1, true);
    if (x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
    }
    x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_wtcc_kernel1<<<grid, block>>>(b_c, vlen, gpu_x, x, gpu_x2, gpu_x1,
                                       cpu_x->size[0U]);
    }
    //  Wavelet coherence - local function
    //  Calculate wavelet coherence
    // 'ec_wtcc:38' [xp,yp] =
    // wcoherence(x1,x2,fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_x1, &gpu_x1);
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_x2, &gpu_x2);
    coder::wcoherence(cpu_x1, cpu_x2, fs, fLims, fVoices, cpu_xp, cpu_yp,
                      &yp_outdatedOnCpu, &gpu_yp, &yp_outdatedOnGpu);
    // 'ec_wtcc:39' xp=xp';
    i = cpu_fv->size[0] * cpu_fv->size[1];
    cpu_fv->size[0] = cpu_xp->size[1];
    cpu_fv->size[1] = cpu_xp->size[0];
    emxEnsureCapacity_real32_T(cpu_fv, i, &e_emlrtRTEI);
    x = cpu_xp->size[0] - 1;
    i = cpu_xp->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(x, i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_xp, &gpu_xp, false);
    gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xp, cpu_xp);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_wtcc_kernel2<<<grid, block>>>(gpu_xp, i, x, gpu_fv, cpu_fv->size[0U],
                                       cpu_xp->size[0U]);
    }
    fv_outdatedOnCpu = true;
    // 'ec_wtcc:39' yp=yp';
    i = b_cpu_yp->size[0] * b_cpu_yp->size[1];
    b_cpu_yp->size[0] = cpu_yp->size[1];
    b_cpu_yp->size[1] = cpu_yp->size[0];
    emxEnsureCapacity_creal32_T(b_cpu_yp, i, &f_emlrtRTEI);
    x = cpu_yp->size[0] - 1;
    i = cpu_yp->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(x, i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_yp, &gpu_yp, !yp_outdatedOnGpu);
    gpuEmxEnsureCapacity_creal32_T(b_cpu_yp, &b_gpu_yp, true);
    yp_needsGpuEnsureCapacity = false;
    if (yp_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_yp, cpu_yp);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_wtcc_kernel3<<<grid, block>>>(gpu_yp, i, x, b_gpu_yp,
                                       b_cpu_yp->size[0U], cpu_yp->size[0U]);
    }
    yp_outdatedOnGpu = false;
    b_yp_outdatedOnCpu = true;
    //  make column-major
    //  Downsample
    // 'ec_wtcc:42' if ds(2)
    if (ds[1] != 0.0) {
      real_T c_dv[4];
      real_T fc;
      real_T nZeroBegin;
      real_T opts_filterDelay;
      real_T opts_p;
      real_T pqmax;
      int32_T opts_dim;
      boolean_T opts_x_outdatedOnCpu;
      // 'ec_wtcc:43' xp = resample(xp,ds(1),ds(2));
      if ((cpu_fv->size[0] == 1) || (cpu_fv->size[1] == 1)) {
        opts_dim = 1;
      } else {
        opts_dim = 2;
        if (cpu_fv->size[0] != 1) {
          opts_dim = 1;
        }
      }
      opts_isRowVectorInput = (cpu_fv->size[0] == 1);
      if (opts_dim == 1) {
        if ((cpu_fv->size[0] == 1) || (cpu_fv->size[1] == 1)) {
          if ((cpu_fv->size[0] == 0) || (cpu_fv->size[1] == 0)) {
            b_c = 0;
          } else {
            vlen = cpu_fv->size[0];
            b_c = cpu_fv->size[1];
            if (vlen >= b_c) {
              b_c = vlen;
            }
          }
          i = cpu_opts_x->size[0] * cpu_opts_x->size[1];
          cpu_opts_x->size[0] = b_c;
          cpu_opts_x->size[1] = 1;
          emxEnsureCapacity_real32_T(cpu_opts_x, i, &g_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(b_c - 1), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_opts_x, &gpu_opts_x, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_wtcc_kernel4<<<grid, block>>>(gpu_fv, b_c - 1, gpu_opts_x);
          }
          opts_x_outdatedOnCpu = true;
        } else {
          i = cpu_opts_x->size[0] * cpu_opts_x->size[1];
          cpu_opts_x->size[0] = cpu_fv->size[0];
          cpu_opts_x->size[1] = cpu_fv->size[1];
          emxEnsureCapacity_real32_T(cpu_opts_x, i, &g_emlrtRTEI);
          i = cpu_fv->size[0] * cpu_fv->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(i), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_opts_x, &gpu_opts_x, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_wtcc_kernel24<<<grid, block>>>(gpu_fv, i, gpu_opts_x);
          }
          opts_x_outdatedOnCpu = true;
        }
      } else {
        i = cpu_opts_x->size[0] * cpu_opts_x->size[1];
        cpu_opts_x->size[0] = cpu_fv->size[1];
        cpu_opts_x->size[1] = cpu_fv->size[0];
        emxEnsureCapacity_real32_T(cpu_opts_x, i, &g_emlrtRTEI);
        i = cpu_fv->size[0] - 1;
        x = cpu_fv->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(i, x), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_real32_T(cpu_opts_x, &gpu_opts_x, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_wtcc_kernel25<<<grid, block>>>(
              gpu_fv, x, i, gpu_opts_x, cpu_opts_x->size[0U], cpu_fv->size[0U]);
        }
        opts_x_outdatedOnCpu = true;
      }
      opts_p = coder::rat(ds[0] / ds[1], &opts_q);
      pqmax = std::fmax(opts_p, opts_q);
      fc = 0.5 / pqmax;
      pqmax = 20.0 * pqmax + 1.0;
      c_dv[0] = 0.0;
      c_dv[1] = 2.0 * fc;
      c_dv[2] = 2.0 * fc;
      c_dv[3] = 1.0;
      coder::firls(pqmax - 1.0, c_dv, cpu_r);
      i = cpu_dv1->size[0];
      cpu_dv1->size[0] = cpu_r->size[1];
      emxEnsureCapacity_real_T(cpu_dv1, i, &k_emlrtRTEI);
      x = cpu_r->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(x), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_r, &gpu_r, false);
      gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1, true);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, cpu_r);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_wtcc_kernel5<<<grid, block>>>(gpu_r, x, gpu_dv1);
      }
      coder::kaiser(pqmax, cpu_dv2);
      i = cpu_h1->size[0];
      cpu_h1->size[0] = cpu_dv1->size[0];
      emxEnsureCapacity_real_T(cpu_h1, i, &l_emlrtRTEI);
      x = cpu_dv1->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(x), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_dv2, &gpu_dv2, false);
      gpuEmxEnsureCapacity_real_T(cpu_h1, &gpu_h1, true);
      yp_needsGpuEnsureCapacity = false;
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv2, cpu_dv2);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_wtcc_kernel6<<<grid, block>>>(gpu_dv2, gpu_dv1, x, gpu_h1);
      }
      vlen = cpu_h1->size[0];
      if (cpu_h1->size[0] == 0) {
        pqmax = 0.0;
      } else {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_h1, &gpu_h1);
        pqmax = cpu_h1->data[0];
        yp_needsGpuEnsureCapacity = true;
        for (i = 0; i <= vlen - 2; i++) {
          pqmax += cpu_h1->data[i + 1];
        }
      }
      x = cpu_h1->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(x), &grid, &block, 2147483647U);
      if (yp_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real_T(cpu_h1, &gpu_h1, true);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_wtcc_kernel7<<<grid, block>>>(pqmax, opts_p, x, gpu_h1);
      }
      i = cpu_opts_filter->size[0];
      cpu_opts_filter->size[0] = cpu_h1->size[0];
      emxEnsureCapacity_real32_T(cpu_opts_filter, i, &g_emlrtRTEI);
      x = cpu_h1->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(x), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_opts_filter, &gpu_opts_filter, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_wtcc_kernel8<<<grid, block>>>(gpu_h1, x, gpu_opts_filter);
      }
      pqmax = (static_cast<real_T>(cpu_opts_filter->size[0]) - 1.0) / 2.0;
      nZeroBegin = std::floor(opts_q - coder::b_mod(pqmax, opts_q));
      opts_filterDelay = std::floor(std::ceil(pqmax + nZeroBegin) / opts_q);
      pqmax = static_cast<real_T>(cpu_opts_filter->size[0]) + nZeroBegin;
      fc = 0.0;
      vlen = cpu_opts_x->size[0];
      while (std::ceil(
                 (((static_cast<real_T>(vlen) - 1.0) * opts_p + pqmax) + fc) /
                 opts_q) -
                 opts_filterDelay <
             std::ceil(static_cast<real_T>(vlen) * opts_p / opts_q)) {
        fc++;
      }
      i = cpu_h->size[0];
      cpu_h->size[0] = static_cast<int32_T>(
          (nZeroBegin + static_cast<real_T>(cpu_opts_filter->size[0])) + fc);
      emxEnsureCapacity_real32_T(cpu_h, i, &m_emlrtRTEI);
      x = static_cast<int32_T>(
              (nZeroBegin + static_cast<real_T>(cpu_opts_filter->size[0])) +
              fc) -
          1;
      mwGetLaunchParameters1D(computeNumIters(x), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_h, &gpu_h, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_wtcc_kernel9<<<grid, block>>>(x, gpu_h);
      }
      if (cpu_opts_filter->size[0] < 1) {
        b_cpu_y->size[0] = 1;
        b_cpu_y->size[1] = 0;
      } else {
        uint32_T u;
        u = static_cast<uint32_T>(cpu_opts_filter->size[0]);
        i = b_cpu_y->size[0] * b_cpu_y->size[1];
        b_cpu_y->size[0] = 1;
        b_cpu_y->size[1] = cpu_opts_filter->size[0];
        emxEnsureCapacity_uint32_T(b_cpu_y, i, &n_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(u) - 1),
                                &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_uint32_T(b_cpu_y, &gpu_y, true);
        y_needsGpuEnsureCapacity = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_wtcc_kernel23<<<grid, block>>>(static_cast<int32_T>(u) - 1, gpu_y);
        }
      }
      i = cpu_iv1->size[0] * cpu_iv1->size[1];
      cpu_iv1->size[0] = 1;
      cpu_iv1->size[1] = b_cpu_y->size[1];
      emxEnsureCapacity_int32_T(cpu_iv1, i, &o_emlrtRTEI);
      x = b_cpu_y->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(x), &grid, &block, 2147483647U);
      if (y_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_uint32_T(b_cpu_y, &gpu_y, true);
      }
      y_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_wtcc_kernel10<<<grid, block>>>(gpu_y, nZeroBegin, x, gpu_iv1);
      }
      x = cpu_iv1->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(x), &grid, &block, 2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_wtcc_kernel11<<<grid, block>>>(gpu_opts_filter, gpu_iv1, x, gpu_h);
      }
      h_outdatedOnGpu = false;
      h_outdatedOnCpu = true;
      if (opts_dim == 1) {
        if (opts_isRowVectorInput) {
          i = cpu_y1->size[0] * cpu_y1->size[1];
          cpu_y1->size[0] = cpu_opts_x->size[0];
          cpu_y1->size[1] = cpu_opts_x->size[1];
          emxEnsureCapacity_real32_T(cpu_y1, i, &r_emlrtRTEI);
          x = cpu_opts_x->size[0] * cpu_opts_x->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(x), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_y1, &gpu_y1, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_wtcc_kernel12<<<grid, block>>>(gpu_opts_x, x, gpu_y1);
          }
          opts_isRowVectorInput = false;
          yp_needsGpuEnsureCapacity = true;
          coder::b_signal::internal::resample::uniformResampleAlongFirstDim(
              cpu_y1, &yp_needsGpuEnsureCapacity, &gpu_y1,
              &opts_isRowVectorInput, opts_p, opts_q, cpu_h, &h_outdatedOnCpu,
              &gpu_h, &h_outdatedOnGpu, opts_filterDelay);
          if ((cpu_y1->size[0] == 0) || (cpu_y1->size[1] == 0)) {
            b_c = 0;
          } else {
            vlen = cpu_y1->size[0];
            b_c = cpu_y1->size[1];
            if (vlen >= b_c) {
              b_c = vlen;
            }
          }
          i = cpu_fv->size[0] * cpu_fv->size[1];
          cpu_fv->size[0] = 1;
          cpu_fv->size[1] = b_c;
          emxEnsureCapacity_real32_T(cpu_fv, i, &q_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(b_c - 1), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_y1, &gpu_y1,
                                        !opts_isRowVectorInput);
          gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
          if (opts_isRowVectorInput) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_y1, cpu_y1);
          }
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_wtcc_kernel13<<<grid, block>>>(gpu_y1, b_c - 1, gpu_fv);
          }
        } else {
          i = cpu_fv->size[0] * cpu_fv->size[1];
          cpu_fv->size[0] = cpu_opts_x->size[0];
          cpu_fv->size[1] = cpu_opts_x->size[1];
          emxEnsureCapacity_real32_T(cpu_fv, i, &q_emlrtRTEI);
          x = cpu_opts_x->size[0] * cpu_opts_x->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(x), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_wtcc_kernel15<<<grid, block>>>(gpu_opts_x, x, gpu_fv);
          }
          yp_needsGpuEnsureCapacity = false;
          coder::b_signal::internal::resample::uniformResampleAlongFirstDim(
              cpu_fv, &fv_outdatedOnCpu, &gpu_fv, &yp_needsGpuEnsureCapacity,
              opts_p, opts_q, cpu_h, &h_outdatedOnCpu, &gpu_h, &h_outdatedOnGpu,
              opts_filterDelay);
        }
      } else {
        if (cpu_opts_x->size[0] == 1) {
          pqmax = std::ceil(opts_p / opts_q);
          opts_isRowVectorInput = false;
          i = cpu_y1->size[0] * cpu_y1->size[1];
          cpu_y1->size[0] = static_cast<int32_T>(pqmax);
          cpu_y1->size[1] = cpu_opts_x->size[1];
          emxEnsureCapacity_real32_T(cpu_y1, i, &s_emlrtRTEI);
          yp_needsGpuEnsureCapacity = true;
          opts_dim = cpu_opts_x->size[1];
          if (cpu_opts_x->size[1] - 1 >= 0) {
            if ((static_cast<int32_T>(opts_p) == 0) ||
                ((static_cast<int32_T>(opts_p) > 0) &&
                 (static_cast<int32_T>(opts_p) < 1))) {
              i3 = 1;
              i4 = 0;
            } else {
              i3 = static_cast<int32_T>(opts_p);
              i4 = static_cast<int32_T>(opts_p);
            }
            Ly = std::ceil(
                (0.0 * opts_p + static_cast<real_T>(cpu_h->size[0])) / opts_q);
          }
          for (x = 0; x < opts_dim; x++) {
            if (!(opts_p - 1.0 >= 0.0)) {
              y = nullptr;
              m = emlrtCreateCharArray(2, &iv2[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
              emlrtAssign(&y, m);
              b_y = nullptr;
              m1 = emlrtCreateDoubleScalar(opts_p - 1.0);
              emlrtAssign(&b_y, m1);
              emlrt_marshallIn(b_sprintf(y, b_y, &emlrtMCI),
                               "<output of sprintf>", unusedExpr);
            }
            i = yCol->size[0];
            yCol->size[0] = static_cast<int32_T>(opts_p);
            emxEnsureCapacity_real32_T(yCol, i, &t_emlrtRTEI);
            for (i = 0; i < static_cast<int32_T>(opts_p); i++) {
              yCol->data[i] = 0.0F;
            }
            vlen = div_s32(i4 - 1, i3) + 1;
            for (i = 0; i < vlen; i++) {
              if (opts_x_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_opts_x, &gpu_opts_x);
              }
              opts_x_outdatedOnCpu = false;
              yCol->data[i3 * i] = cpu_opts_x->data[x];
            }
            b_yCol = *yCol;
            opts_x[0] = static_cast<int32_T>(opts_p);
            b_yCol.size = &opts_x[0];
            b_yCol.numDimensions = 1;
            coder::b_conv2(&b_yCol, cpu_h, &h_outdatedOnCpu, &gpu_h,
                           &h_outdatedOnGpu, cpu_w, &w_outdatedOnCpu, &gpu_w,
                           &w_outdatedOnGpu);
            if (!(opts_q - 1.0 >= 0.0)) {
              c_y = nullptr;
              m2 = emlrtCreateCharArray(2, &iv3[0]);
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
              b_c = -1;
            } else {
              vlen = static_cast<int32_T>(opts_q);
              b_c = cpu_w->size[0] - 1;
            }
            i = c_cpu_y->size[0];
            c_cpu_y->size[0] = div_s32(b_c, vlen) + 1;
            emxEnsureCapacity_real32_T(c_cpu_y, i, &v_emlrtRTEI);
            i = b_c / vlen;
            mwGetLaunchParameters1D(computeNumIters(i), &grid, &block,
                                    2147483647U);
            gpuEmxEnsureCapacity_real32_T(cpu_w, &gpu_w, !w_outdatedOnGpu);
            gpuEmxEnsureCapacity_real32_T(c_cpu_y, &c_gpu_y, true);
            yp_outdatedOnGpu = false;
            if (w_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_w, cpu_w);
            }
            w_outdatedOnGpu = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_wtcc_kernel16<<<grid, block>>>(gpu_w, vlen, i, c_gpu_y);
            }
            if (!(div_s32(b_c, vlen) + 1 < Ly)) {
              i = c_cpu_y->size[0];
              if (Ly < 1.0) {
                c_cpu_y->size[0] = 0;
              } else {
                c_cpu_y->size[0] = static_cast<int32_T>(Ly);
              }
              emxEnsureCapacity_real32_T(c_cpu_y, i, &w_emlrtRTEI);
              yp_outdatedOnGpu = true;
            }
            if (std::isnan(pqmax)) {
              i = d_cpu_y->size[0] * d_cpu_y->size[1];
              d_cpu_y->size[0] = 1;
              d_cpu_y->size[1] = 1;
              emxEnsureCapacity_real_T(d_cpu_y, i, &n_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(d_cpu_y, &d_gpu_y, true);
              b_y_needsGpuEnsureCapacity = false;
              ec_wtcc_kernel17<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                  d_gpu_y);
            } else if (pqmax < 1.0) {
              d_cpu_y->size[0] = 1;
              d_cpu_y->size[1] = 0;
            } else {
              i = d_cpu_y->size[0] * d_cpu_y->size[1];
              d_cpu_y->size[0] = 1;
              d_cpu_y->size[1] = static_cast<int32_T>(pqmax - 1.0) + 1;
              emxEnsureCapacity_real_T(d_cpu_y, i, &n_emlrtRTEI);
              mwGetLaunchParameters1D(
                  computeNumIters(static_cast<int32_T>(pqmax - 1.0)), &grid,
                  &block, 2147483647U);
              gpuEmxEnsureCapacity_real_T(d_cpu_y, &d_gpu_y, true);
              b_y_needsGpuEnsureCapacity = false;
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_wtcc_kernel19<<<grid, block>>>(
                    static_cast<int32_T>(pqmax - 1.0), d_gpu_y);
              }
            }
            vlen = cpu_y1->size[0];
            mwGetLaunchParameters1D(computeNumIters(vlen - 1), &grid, &block,
                                    2147483647U);
            if (yp_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real32_T(c_cpu_y, &c_gpu_y, true);
            }
            if (b_y_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(d_cpu_y, &d_gpu_y, true);
            }
            b_y_needsGpuEnsureCapacity = false;
            if (yp_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real32_T(cpu_y1, &gpu_y1, true);
            }
            yp_needsGpuEnsureCapacity = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_wtcc_kernel18<<<grid, block>>>(c_gpu_y, d_gpu_y,
                                                opts_filterDelay, x, vlen - 1,
                                                gpu_y1, cpu_y1->size[0U]);
            }
          }
        } else {
          i = cpu_y1->size[0] * cpu_y1->size[1];
          cpu_y1->size[0] = cpu_opts_x->size[0];
          cpu_y1->size[1] = cpu_opts_x->size[1];
          emxEnsureCapacity_real32_T(cpu_y1, i, &p_emlrtRTEI);
          x = cpu_opts_x->size[0] * cpu_opts_x->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(x), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_y1, &gpu_y1, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_wtcc_kernel22<<<grid, block>>>(gpu_opts_x, x, gpu_y1);
          }
          opts_isRowVectorInput = false;
          yp_needsGpuEnsureCapacity = true;
          coder::b_signal::internal::resample::uniformResampleAlongFirstDim(
              cpu_y1, &yp_needsGpuEnsureCapacity, &gpu_y1,
              &opts_isRowVectorInput, opts_p, opts_q, cpu_h, &h_outdatedOnCpu,
              &gpu_h, &h_outdatedOnGpu, opts_filterDelay);
          yp_needsGpuEnsureCapacity = true;
        }
        if ((cpu_opts_x->size[0] == 1) || (cpu_opts_x->size[1] == 1)) {
          vlen = cpu_fv->size[0];
          b_c = cpu_fv->size[0];
          opts_dim = cpu_y1->size[0];
          i = cpu_fv->size[0] * cpu_fv->size[1];
          cpu_fv->size[0] = vlen;
          cpu_fv->size[1] = cpu_y1->size[0];
          emxEnsureCapacity_real32_T(cpu_fv, i, &q_emlrtRTEI);
          i = b_c * opts_dim - 1;
          mwGetLaunchParameters1D(computeNumIters(i), &grid, &block,
                                  2147483647U);
          if (yp_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_y1, &gpu_y1,
                                          !opts_isRowVectorInput);
          }
          gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
          if (opts_isRowVectorInput) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_y1, cpu_y1);
          }
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_wtcc_kernel20<<<grid, block>>>(gpu_y1, i, gpu_fv);
          }
        } else {
          i = cpu_fv->size[0] * cpu_fv->size[1];
          cpu_fv->size[0] = cpu_y1->size[1];
          cpu_fv->size[1] = cpu_y1->size[0];
          emxEnsureCapacity_real32_T(cpu_fv, i, &q_emlrtRTEI);
          x = cpu_y1->size[0] - 1;
          i = cpu_y1->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(x, i), &grid, &block,
                                  2147483647U);
          if (yp_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_y1, &gpu_y1,
                                          !opts_isRowVectorInput);
          }
          gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
          if (opts_isRowVectorInput) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_y1, cpu_y1);
          }
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_wtcc_kernel21<<<grid, block>>>(
                gpu_y1, i, x, gpu_fv, cpu_fv->size[0U], cpu_y1->size[0U]);
          }
        }
      }
      // 'ec_wtcc:44' yp = resample(yp,ds(1),ds(2));
      opts_isRowVectorInput = false;
      i = c_cpu_yp->size[0] * c_cpu_yp->size[1];
      c_cpu_yp->size[0] = b_cpu_yp->size[0];
      c_cpu_yp->size[1] = b_cpu_yp->size[1];
      emxEnsureCapacity_creal32_T(c_cpu_yp, i, &u_emlrtRTEI);
      vlen = b_cpu_yp->size[0] * b_cpu_yp->size[1] - 1;
      for (i = 0; i <= vlen; i++) {
        if (b_yp_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_creal32_T(b_cpu_yp, &b_gpu_yp);
        }
        b_yp_outdatedOnCpu = false;
        c_cpu_yp->data[i] = b_cpu_yp->data[i];
        opts_isRowVectorInput = true;
      }
      coder::resample(c_cpu_yp, &c_gpu_yp, &opts_isRowVectorInput, ds[0], ds[1],
                      b_cpu_yp, &b_yp_outdatedOnCpu, &b_gpu_yp,
                      &yp_outdatedOnGpu);
      yp_needsGpuEnsureCapacity = true;
    }
    //  Convert wavelet to phase angle
    // 'ec_wtcc:48' yp = angle(yp);
    vlen = b_cpu_yp->size[0] * b_cpu_yp->size[1];
    for (i = 0; i < 2; i++) {
      b_dv[i] = static_cast<uint32_T>(b_cpu_yp->size[i]);
    }
    i = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = static_cast<int32_T>(b_dv[0]);
    cpu_y->size[1] = static_cast<int32_T>(b_dv[1]);
    emxEnsureCapacity_real32_T(cpu_y, i, &h_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(vlen - 1), &grid, &block,
                            2147483647U);
    if (yp_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_creal32_T(b_cpu_yp, &b_gpu_yp, !yp_outdatedOnGpu);
    }
    gpuEmxEnsureCapacity_real32_T(cpu_y, &b_gpu_y, true);
    if (yp_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_creal32_T(&b_gpu_yp, b_cpu_yp);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_wtcc_kernel14<<<grid, block>>>(b_gpu_yp, vlen - 1, b_gpu_y);
    }
    yp_needsGpuEnsureCapacity = true;
    i = yy->data[p].f1->size[0] * yy->data[p].f1->size[1];
    yy->data[p].f1->size[0] = cpu_y->size[0];
    emxEnsureCapacity_real32_T(yy->data[p].f1, i, &i_emlrtRTEI);
    i = yy->data[p].f1->size[0] * yy->data[p].f1->size[1];
    yy->data[p].f1->size[1] = cpu_y->size[1];
    emxEnsureCapacity_real32_T(yy->data[p].f1, i, &i_emlrtRTEI);
    for (i = 0; i < cpu_y->size[0] * cpu_y->size[1]; i++) {
      if (yp_needsGpuEnsureCapacity) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_y, &b_gpu_y);
      }
      yp_needsGpuEnsureCapacity = false;
      yy->data[p].f1->data[i] = cpu_y->data[i];
    }
    i = xx->data[p].f1->size[0] * xx->data[p].f1->size[1];
    xx->data[p].f1->size[0] = cpu_fv->size[0];
    emxEnsureCapacity_real32_T(xx->data[p].f1, i, &j_emlrtRTEI);
    i = xx->data[p].f1->size[0] * xx->data[p].f1->size[1];
    xx->data[p].f1->size[1] = cpu_fv->size[1];
    emxEnsureCapacity_real32_T(xx->data[p].f1, i, &j_emlrtRTEI);
    for (i = 0; i < cpu_fv->size[0] * cpu_fv->size[1]; i++) {
      if (fv_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv, &gpu_fv);
      }
      fv_outdatedOnCpu = false;
      xx->data[p].f1->data[i] = cpu_fv->data[i];
    }
  }
  emxFree_creal32_T(&c_cpu_yp);
  emxFree_real_T(&cpu_r);
  emxFree_real_T(&d_cpu_y);
  emxFree_real32_T(&c_cpu_y);
  emxFree_real32_T(&cpu_w);
  emxFree_real32_T(&yCol);
  emxFree_real32_T(&cpu_y1);
  emxFree_int32_T(&cpu_iv1);
  emxFree_uint32_T(&b_cpu_y);
  emxFree_real32_T(&cpu_h);
  emxFree_real_T(&cpu_h1);
  emxFree_real_T(&cpu_dv2);
  emxFree_real_T(&cpu_dv1);
  emxFree_real32_T(&cpu_opts_x);
  emxFree_real32_T(&cpu_opts_filter);
  emxFree_real32_T(&cpu_y);
  emxFree_creal32_T(&b_cpu_yp);
  emxFree_real32_T(&cpu_fv);
  emxFree_creal32_T(&cpu_yp);
  emxFree_real32_T(&cpu_xp);
  emxFree_real32_T(&cpu_x2);
  emxFree_real32_T(&cpu_x1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real32_T(&gpu_x);
  gpuEmxFree_real32_T(&gpu_x1);
  gpuEmxFree_real32_T(&gpu_x2);
  gpuEmxFree_real32_T(&gpu_xp);
  gpuEmxFree_creal32_T(&gpu_yp);
  gpuEmxFree_real32_T(&gpu_fv);
  gpuEmxFree_creal32_T(&b_gpu_yp);
  gpuEmxFree_real32_T(&b_gpu_y);
  gpuEmxFree_real32_T(&gpu_opts_filter);
  gpuEmxFree_real32_T(&gpu_opts_x);
  gpuEmxFree_real_T(&gpu_dv1);
  gpuEmxFree_real_T(&gpu_dv2);
  gpuEmxFree_real_T(&gpu_h1);
  gpuEmxFree_real32_T(&gpu_h);
  gpuEmxFree_uint32_T(&gpu_y);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_real32_T(&gpu_y1);
  gpuEmxFree_real32_T(&gpu_w);
  gpuEmxFree_real32_T(&c_gpu_y);
  gpuEmxFree_real_T(&d_gpu_y);
  gpuEmxFree_real_T(&gpu_r);
  gpuEmxFree_creal32_T(&c_gpu_yp);
}

// End of code generation (ec_wtcc.cu)
