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
#include "_coder_ec_filtfilt1_mex.h"
#include "ec_filtfilt1_types.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWMemoryManager.hpp"
#include <algorithm>
#include <cmath>
#include <cstring>

// Type Definitions
struct emxArray_int32_T {
  int32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{nullptr};

emlrtContext emlrtContextGlobal{
    true,                                               // bFirstTime
    false,                                              // bInitialized
    131642U,                                            // fVersionInfo
    nullptr,                                            // fErrorFunction
    "ec_filtfilt1",                                     // fFunctionName
    nullptr,                                            // fRTCallStack
    false,                                              // bDebugMode
    {3130694236U, 2616137409U, 972914731U, 129233577U}, // fSigWrd
    nullptr                                             // fSigMem
};

static emlrtRTEInfo emlrtRTEI{
    99,                                                         // lineNo
    1,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    106,                                                        // lineNo
    28,                                                         // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    60,                                                              // lineNo
    20,                                                              // colNo
    "bsxfun",                                                        // fName
    "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/bsxfun.m" // pName
};

static emlrtRTEInfo
    d_emlrtRTEI{
        76,                  // lineNo
        9,                   // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

static emlrtRTEInfo e_emlrtRTEI{
    106,                                                        // lineNo
    15,                                                         // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    1,               // lineNo
    1,               // colNo
    "gpufilterImpl", // fName
    "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/private/"
    "gpufilterImpl.p" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "stencil_codegen", // fName
    "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "stencil_codegen.p" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    172,                                                          // lineNo
    20,                                                           // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    143,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    146,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    106,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    139,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    140,                                                        // lineNo
    40,                                                         // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo n_emlrtRTEI{
    1,                                                          // lineNo
    14,                                                         // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    145,                                                        // lineNo
    53,                                                         // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo p_emlrtRTEI{
    1,                         // lineNo
    1,                         // colNo
    "_coder_ec_filtfilt1_api", // fName
    ""                         // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *b, const char_T *identifier,
                               emxArray_real32_T *y);

static void b_emlrt_marshallIn(const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real32_T *y);

static real32_T b_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId);

static void c_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);

static void d_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static int32_T div_s32(int32_T numerator, int32_T denominator);

static
#ifdef __CUDACC__
    __device__
#endif
        int32_T
        div_s32_device(int32_T numerator, int32_T denominator);

static __global__ void ec_filtfilt1_kernel1(const emxArray_real32_T a,
                                            real32_T *a1, real32_T *b_a1,
                                            real32_T *c_a1, real32_T *d_a1,
                                            real32_T *e_a1);

static __global__ void ec_filtfilt1_kernel10(int32_T OH, uint32_T window_idx_0,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel11(const emxArray_real32_T xt,
                                             const int32_T offsetH,
                                             const emxArray_int32_T y,
                                             int32_T b_y,
                                             emxArray_real32_T expanded);

static __global__ void
ec_filtfilt1_kernel12(const emxArray_real32_T expanded,
                      const emxArray_int32_T rows, const emxArray_real32_T b,
                      int32_T OH, emxArray_real32_T convOut, int32_T b_dim0);

static __global__ void ec_filtfilt1_kernel13(const emxArray_real32_T y,
                                             int32_T x,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel14(const emxArray_real32_T y,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel15(const emxArray_real32_T convOut,
                                             const int32_T x, int32_T bcoef,
                                             emxArray_real32_T zfIIR);

static __global__ void ec_filtfilt1_kernel16(const emxArray_real32_T convOut,
                                             const emxArray_real32_T a,
                                             int32_T x, emxArray_real32_T zfIIR,
                                             int32_T a_dim0, int32_T xt_dim0);

static __global__ void ec_filtfilt1_kernel17(const emxArray_real32_T b,
                                             int32_T b_b,
                                             emxArray_real32_T c_b);

static __global__ void ec_filtfilt1_kernel18(const emxArray_real32_T a,
                                             int32_T b_a,
                                             emxArray_real32_T c_a);

static __global__ void ec_filtfilt1_kernel19(const real32_T *a1, int32_T nb,
                                             emxArray_real32_T b);

static __global__ void ec_filtfilt1_kernel2(const int32_T x,
                                            const emxArray_real32_T b_x,
                                            int32_T c_x, emxArray_real32_T fv,
                                            int32_T x_dim0);

static __global__ void ec_filtfilt1_kernel20(const real32_T *a1, int32_T na,
                                             emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel21(emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel22(int32_T OH, uint32_T window_idx_0,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel23(const emxArray_real32_T fv,
                                             const int32_T offsetH,
                                             const emxArray_int32_T y,
                                             int32_T b_y,
                                             emxArray_real32_T expanded);

static __global__ void
ec_filtfilt1_kernel24(const emxArray_real32_T expanded,
                      const emxArray_int32_T rows, const emxArray_real32_T b,
                      int32_T OH, emxArray_real32_T convOut, int32_T b_dim0);

static __global__ void ec_filtfilt1_kernel25(const emxArray_real32_T zfIIR,
                                             int32_T x,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel26(const emxArray_real32_T convOut,
                                             const int32_T x, int32_T bcoef,
                                             emxArray_real32_T zfIIR);

static __global__ void ec_filtfilt1_kernel27(const emxArray_real32_T convOut,
                                             const emxArray_real32_T a,
                                             int32_T x, emxArray_real32_T zfIIR,
                                             int32_T a_dim0, int32_T fv_dim0);

static __global__ void ec_filtfilt1_kernel28(const emxArray_real32_T convOut,
                                             int32_T fv, emxArray_real32_T y);

static __global__ void ec_filtfilt1_kernel29(const emxArray_real32_T fv,
                                             const int32_T bcoef,
                                             const int32_T KH, const int32_T n,
                                             const real32_T a, int32_T x,
                                             emxArray_real32_T xt);

static __global__ void ec_filtfilt1_kernel3(const emxArray_real32_T fv,
                                            const int32_T bcoef,
                                            const int32_T i2, const int32_T i1,
                                            const real32_T a, int32_T x,
                                            emxArray_real32_T xt);

static __global__ void ec_filtfilt1_kernel30(const emxArray_real32_T b,
                                             int32_T b_b,
                                             emxArray_real32_T c_b);

static __global__ void ec_filtfilt1_kernel31(const emxArray_real32_T a,
                                             int32_T b_a,
                                             emxArray_real32_T c_a);

static __global__ void ec_filtfilt1_kernel32(const real32_T *a1, int32_T nb,
                                             emxArray_real32_T b);

static __global__ void ec_filtfilt1_kernel33(const real32_T *a1, int32_T na,
                                             emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel34(emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel35(int32_T OH, uint32_T window_idx_0,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel36(const emxArray_real32_T xt,
                                             const int32_T offsetH,
                                             const emxArray_int32_T y,
                                             int32_T b_y,
                                             emxArray_real32_T expanded);

static __global__ void
ec_filtfilt1_kernel37(const emxArray_real32_T expanded,
                      const emxArray_int32_T rows, const emxArray_real32_T b,
                      int32_T OH, emxArray_real32_T convOut, int32_T b_dim0);

static __global__ void ec_filtfilt1_kernel38(const emxArray_real32_T zfIIR,
                                             int32_T x,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel39(const emxArray_real32_T convOut,
                                             int32_T xt, emxArray_real32_T yc3);

static __global__ void ec_filtfilt1_kernel4(const real32_T a,
                                            const emxArray_real32_T z,
                                            int32_T b_z, emxArray_real32_T y);

static __global__ void ec_filtfilt1_kernel40(const real32_T a,
                                             const emxArray_real32_T z,
                                             int32_T b_z, emxArray_real32_T y);

static __global__ void ec_filtfilt1_kernel41(const emxArray_real32_T b,
                                             int32_T b_b,
                                             emxArray_real32_T c_b);

static __global__ void ec_filtfilt1_kernel42(const emxArray_real32_T a,
                                             int32_T b_a,
                                             emxArray_real32_T c_a);

static __global__ void ec_filtfilt1_kernel43(const real32_T *a1, int32_T nb,
                                             emxArray_real32_T b);

static __global__ void ec_filtfilt1_kernel44(const real32_T *a1, int32_T na,
                                             emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel45(emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel46(int32_T OH, uint32_T window_idx_0,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel47(const int32_T offsetH,
                                             const emxArray_int32_T y,
                                             int32_T b_y, emxArray_int32_T iv3);

static __global__ void
ec_filtfilt1_kernel48(const emxArray_real32_T yc3, const int32_T i25,
                      const int32_T i23, const emxArray_int32_T iv3, int32_T k,
                      emxArray_real32_T expanded);

static __global__ void
ec_filtfilt1_kernel49(const emxArray_real32_T expanded,
                      const emxArray_int32_T rows, const emxArray_real32_T b,
                      int32_T OH, emxArray_real32_T convOut, int32_T b_dim0);

static __global__ void ec_filtfilt1_kernel5(const emxArray_real32_T b,
                                            int32_T b_b, emxArray_real32_T c_b);

static __global__ void ec_filtfilt1_kernel50(const emxArray_real32_T y,
                                             int32_T x,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel51(const emxArray_real32_T y,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel52(const emxArray_real32_T convOut,
                                             const int32_T x, int32_T bcoef,
                                             emxArray_real32_T zfIIR);

static __global__ void
ec_filtfilt1_kernel53(const emxArray_real32_T convOut, const int32_T i25,
                      const int32_T i23, const int32_T i26,
                      const emxArray_real32_T a, int32_T x,
                      emxArray_real32_T zfIIR, int32_T a_dim0);

static __global__ void ec_filtfilt1_kernel54(const emxArray_real32_T b,
                                             int32_T b_b,
                                             emxArray_real32_T c_b);

static __global__ void ec_filtfilt1_kernel55(const emxArray_real32_T a,
                                             int32_T b_a,
                                             emxArray_real32_T c_a);

static __global__ void ec_filtfilt1_kernel56(const real32_T *a1, int32_T nb,
                                             emxArray_real32_T b);

static __global__ void ec_filtfilt1_kernel57(const real32_T *a1, int32_T na,
                                             emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel58(emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel59(int32_T OH, uint32_T window_idx_0,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel6(const emxArray_real32_T a,
                                            int32_T b_a, emxArray_real32_T c_a);

static __global__ void ec_filtfilt1_kernel60(const int32_T offsetH,
                                             const emxArray_int32_T y,
                                             int32_T b_y, emxArray_int32_T iv4);

static __global__ void
ec_filtfilt1_kernel61(const emxArray_real32_T y, const int32_T i25,
                      const int32_T i23, const emxArray_int32_T iv4, int32_T k,
                      emxArray_real32_T expanded);

static __global__ void
ec_filtfilt1_kernel62(const emxArray_real32_T expanded,
                      const emxArray_int32_T rows, const emxArray_real32_T b,
                      int32_T OH, emxArray_real32_T convOut, int32_T b_dim0);

static __global__ void ec_filtfilt1_kernel63(const emxArray_real32_T zfIIR,
                                             int32_T x,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel64(const emxArray_real32_T convOut,
                                             int32_T i26, int32_T i23,
                                             int32_T i25,
                                             emxArray_real32_T yc5);

static __global__ void ec_filtfilt1_kernel65(const emxArray_real32_T yc5,
                                             const int32_T bcoef,
                                             const int32_T x, int32_T n,
                                             emxArray_real32_T fv);

static __global__ void ec_filtfilt1_kernel66(const emxArray_real32_T fv,
                                             const int32_T x, int32_T b_fv,
                                             emxArray_real32_T y,
                                             int32_T y_dim0);

static __global__ void ec_filtfilt1_kernel7(const real32_T *a1, int32_T nb,
                                            emxArray_real32_T b);

static __global__ void ec_filtfilt1_kernel8(const real32_T *a1, int32_T na,
                                            emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel9(emxArray_real32_T a);

static void ec_filtfilt1_once();

static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
                             emxArray_real32_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y);

static real32_T emlrt_marshallIn(const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static real32_T emlrt_marshallIn(const mxArray *nf, const char_T *identifier);

static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u);

static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray,
                                      int32_T oldNumel,
                                      const emlrtRTEInfo *srcLocation);

static void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray,
                                       int32_T oldNumel,
                                       const emlrtRTEInfo *srcLocation);

static void emxFree_int32_T(emxArray_int32_T **pEmxArray);

static void emxFree_real32_T(emxArray_real32_T **pEmxArray);

static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
                            const emlrtRTEInfo *srcLocation, boolean_T doPush);

static void emxInit_real32_T(emxArray_real32_T **pEmxArray,
                             int32_T numDimensions,
                             const emlrtRTEInfo *srcLocation, boolean_T doPush);

static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
                                         emxArray_int32_T *gpu);

static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu);

static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);

static void gpuEmxFree_real32_T(emxArray_real32_T *gpu);

static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu,
                                         const emxArray_int32_T *cpu);

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                          const emxArray_real32_T *cpu);

static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu);

static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);

static void gpuEmxReset_real32_T(emxArray_real32_T *gpu);

// Function Definitions
static real32_T b_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  real32_T ret;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single", false, 0U,
                          (const void *)&dims);
  ret = *static_cast<real32_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret;
}

static void b_emlrt_marshallIn(const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real32_T *y)
{
  d_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void b_emlrt_marshallIn(const mxArray *b, const char_T *identifier,
                               emxArray_real32_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(emlrtAlias(b), &thisId, y);
  emlrtDestroyArray(&b);
}

static void c_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret)
{
  static const int32_T dims[2]{-1, -1};
  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{true, true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real32_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  ret->data = static_cast<real32_T *>(emlrtMxGetData(src));
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride)
{
  int64_T newEnd;
  newEnd = -1L;
  if ((stride > 0L) && (start <= end)) {
    newEnd = (end - start) / stride;
  } else if ((stride < 0L) && (end <= start)) {
    newEnd = (start - end) / -stride;
  }
  return newEnd;
}

static void d_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret)
{
  static const int32_T dims[1]{-1};
  int32_T iv[1];
  int32_T i;
  boolean_T bv[1]{true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single", false, 1U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0];
  i = ret->size[0];
  ret->size[0] = iv[0];
  emxEnsureCapacity_real32_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  ret->data = static_cast<real32_T *>(emlrtMxGetData(src));
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel1(
    const emxArray_real32_T a, real32_T *a1, real32_T *b_a1, real32_T *c_a1,
    real32_T *d_a1, real32_T *e_a1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *e_a1 = a.data[0];
    *d_a1 = a.data[0];
    *c_a1 = a.data[0];
    *b_a1 = a.data[0];
    *a1 = a.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel10(
    int32_T OH, uint32_T window_idx_0, emxArray_real32_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd =
      static_cast<uint64_T>(OH + static_cast<int32_T>(window_idx_0)) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    expanded.data[k] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel11(
    const emxArray_real32_T xt, const int32_T offsetH, const emxArray_int32_T y,
    int32_T b_y, emxArray_real32_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
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
    expanded.data[j - 1] = xt.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel12(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_real32_T b, int32_T OH, emxArray_real32_T convOut,
    int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T orow;
    real32_T cv;
    orow = static_cast<int32_T>(idx);
    cv = 0.0F;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T j;
      j = rows.data[m];
      if (j > 2147483646 - orow) {
        j = MAX_int32_T;
      } else {
        j = (orow + j) + 1;
      }
      cv += expanded.data[j - 1] * b.data[(b_dim0 - m) - 1];
    }
    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel13(
    const emxArray_real32_T y, int32_T x, emxArray_real32_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    convOut.data[orow] += y.data[orow];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel14(
    const emxArray_real32_T y, emxArray_real32_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += y.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel15(
    const emxArray_real32_T convOut, const int32_T x, int32_T bcoef,
    emxArray_real32_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef - x) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    zfIIR.data[k] = convOut.data[x + k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel16(
    const emxArray_real32_T convOut, const emxArray_real32_T a, int32_T x,
    emxArray_real32_T zfIIR, int32_T a_dim0, int32_T xt_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    k = static_cast<int32_T>(
        fmin(static_cast<real_T>(orow) + 2.0, static_cast<real_T>(a_dim0)));
    for (int32_T j{0}; j <= k - 2; j++) {
      zfIIR.data[orow + 1] +=
          convOut.data[(xt_dim0 + orow) - j] * a.data[j + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel17(
    const emxArray_real32_T b, int32_T b_b, emxArray_real32_T c_b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_b.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel18(
    const emxArray_real32_T a, int32_T b_a, emxArray_real32_T c_a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_a.data[k] = a.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel19(
    const real32_T *a1, int32_T nb, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel2(
    const int32_T x, const emxArray_real32_T b_x, int32_T c_x,
    emxArray_real32_T fv, int32_T x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv.data[k] = b_x.data[k + x_dim0 * (x - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel20(
    const real32_T *a1, int32_T na, emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_filtfilt1_kernel21(emxArray_real32_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel22(
    int32_T OH, uint32_T window_idx_0, emxArray_real32_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd =
      static_cast<uint64_T>(OH + static_cast<int32_T>(window_idx_0)) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    expanded.data[k] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel23(
    const emxArray_real32_T fv, const int32_T offsetH, const emxArray_int32_T y,
    int32_T b_y, emxArray_real32_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
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
    expanded.data[j - 1] = fv.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel24(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_real32_T b, int32_T OH, emxArray_real32_T convOut,
    int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T orow;
    real32_T cv;
    orow = static_cast<int32_T>(idx);
    cv = 0.0F;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T j;
      j = rows.data[m];
      if (j > 2147483646 - orow) {
        j = MAX_int32_T;
      } else {
        j = (orow + j) + 1;
      }
      cv += expanded.data[j - 1] * b.data[(b_dim0 - m) - 1];
    }
    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel25(
    const emxArray_real32_T zfIIR, int32_T x, emxArray_real32_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    convOut.data[orow] += zfIIR.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel26(
    const emxArray_real32_T convOut, const int32_T x, int32_T bcoef,
    emxArray_real32_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef - x) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    zfIIR.data[k] = convOut.data[x + k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel27(
    const emxArray_real32_T convOut, const emxArray_real32_T a, int32_T x,
    emxArray_real32_T zfIIR, int32_T a_dim0, int32_T fv_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    k = static_cast<int32_T>(
        fmin(static_cast<real_T>(orow) + 2.0, static_cast<real_T>(a_dim0)));
    for (int32_T j{0}; j <= k - 2; j++) {
      zfIIR.data[orow + 1] +=
          convOut.data[(fv_dim0 + orow) - j] * a.data[j + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel28(
    const emxArray_real32_T convOut, int32_T fv, emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = convOut.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel29(
    const emxArray_real32_T fv, const int32_T bcoef, const int32_T KH,
    const int32_T n, const real32_T a, int32_T x, emxArray_real32_T xt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    xt.data[k] = a - fv.data[(n + KH * (bcoef * k)) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel3(
    const emxArray_real32_T fv, const int32_T bcoef, const int32_T i2,
    const int32_T i1, const real32_T a, int32_T x, emxArray_real32_T xt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    xt.data[k] = a - fv.data[(i1 + i2 * (bcoef * k)) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel30(
    const emxArray_real32_T b, int32_T b_b, emxArray_real32_T c_b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_b.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel31(
    const emxArray_real32_T a, int32_T b_a, emxArray_real32_T c_a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_a.data[k] = a.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel32(
    const real32_T *a1, int32_T nb, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel33(
    const real32_T *a1, int32_T na, emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_filtfilt1_kernel34(emxArray_real32_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel35(
    int32_T OH, uint32_T window_idx_0, emxArray_real32_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd =
      static_cast<uint64_T>(OH + static_cast<int32_T>(window_idx_0)) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    expanded.data[k] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel36(
    const emxArray_real32_T xt, const int32_T offsetH, const emxArray_int32_T y,
    int32_T b_y, emxArray_real32_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
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
    expanded.data[j - 1] = xt.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel37(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_real32_T b, int32_T OH, emxArray_real32_T convOut,
    int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T orow;
    real32_T cv;
    orow = static_cast<int32_T>(idx);
    cv = 0.0F;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T j;
      j = rows.data[m];
      if (j > 2147483646 - orow) {
        j = MAX_int32_T;
      } else {
        j = (orow + j) + 1;
      }
      cv += expanded.data[j - 1] * b.data[(b_dim0 - m) - 1];
    }
    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel38(
    const emxArray_real32_T zfIIR, int32_T x, emxArray_real32_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    convOut.data[orow] += zfIIR.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel39(
    const emxArray_real32_T convOut, int32_T xt, emxArray_real32_T yc3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xt);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    yc3.data[k] = convOut.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel4(
    const real32_T a, const emxArray_real32_T z, int32_T b_z,
    emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_z);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = z.data[k] * a;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel40(
    const real32_T a, const emxArray_real32_T z, int32_T b_z,
    emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_z);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = z.data[k] * a;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel41(
    const emxArray_real32_T b, int32_T b_b, emxArray_real32_T c_b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_b.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel42(
    const emxArray_real32_T a, int32_T b_a, emxArray_real32_T c_a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_a.data[k] = a.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel43(
    const real32_T *a1, int32_T nb, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel44(
    const real32_T *a1, int32_T na, emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_filtfilt1_kernel45(emxArray_real32_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel46(
    int32_T OH, uint32_T window_idx_0, emxArray_real32_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd =
      static_cast<uint64_T>(OH + static_cast<int32_T>(window_idx_0)) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    expanded.data[k] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel47(
    const int32_T offsetH, const emxArray_int32_T y, int32_T b_y,
    emxArray_int32_T iv3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
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
    iv3.data[k] = j - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel48(
    const emxArray_real32_T yc3, const int32_T i25, const int32_T i23,
    const emxArray_int32_T iv3, int32_T k, emxArray_real32_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(k);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_k;
    b_k = static_cast<int32_T>(idx);
    expanded.data[iv3.data[b_k]] = yc3.data[(i23 + i25 * b_k) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel49(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_real32_T b, int32_T OH, emxArray_real32_T convOut,
    int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T orow;
    real32_T cv;
    orow = static_cast<int32_T>(idx);
    cv = 0.0F;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T j;
      j = rows.data[m];
      if ((orow + 1 < 0) && (j < MAX_int32_T - orow)) {
        j = MIN_int32_T;
      } else if ((orow + 1 > 0) && (j > 2147483646 - orow)) {
        j = MAX_int32_T;
      } else {
        j = (orow + j) + 1;
      }
      cv += expanded.data[j - 1] * b.data[(b_dim0 - m) - 1];
    }
    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel5(
    const emxArray_real32_T b, int32_T b_b, emxArray_real32_T c_b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_b.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel50(
    const emxArray_real32_T y, int32_T x, emxArray_real32_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    convOut.data[orow] += y.data[orow];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel51(
    const emxArray_real32_T y, emxArray_real32_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += y.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel52(
    const emxArray_real32_T convOut, const int32_T x, int32_T bcoef,
    emxArray_real32_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef - x) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    zfIIR.data[k] = convOut.data[x + k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel53(
    const emxArray_real32_T convOut, const int32_T i25, const int32_T i23,
    const int32_T i26, const emxArray_real32_T a, int32_T x,
    emxArray_real32_T zfIIR, int32_T a_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    k = static_cast<int32_T>(
        fmin(static_cast<real_T>(orow) + 2.0, static_cast<real_T>(a_dim0)));
    for (int32_T j{0}; j <= k - 2; j++) {
      zfIIR.data[orow + 1] +=
          convOut.data[((div_s32_device(i26 - i23, i25) + orow) - j) + 1] *
          a.data[j + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel54(
    const emxArray_real32_T b, int32_T b_b, emxArray_real32_T c_b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_b.data[k] = b.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel55(
    const emxArray_real32_T a, int32_T b_a, emxArray_real32_T c_a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_a.data[k] = a.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel56(
    const real32_T *a1, int32_T nb, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel57(
    const real32_T *a1, int32_T na, emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_filtfilt1_kernel58(emxArray_real32_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel59(
    int32_T OH, uint32_T window_idx_0, emxArray_real32_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd =
      static_cast<uint64_T>(OH + static_cast<int32_T>(window_idx_0)) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    expanded.data[k] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel6(
    const emxArray_real32_T a, int32_T b_a, emxArray_real32_T c_a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_a.data[k] = a.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel60(
    const int32_T offsetH, const emxArray_int32_T y, int32_T b_y,
    emxArray_int32_T iv4)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
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
    iv4.data[k] = j - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel61(
    const emxArray_real32_T y, const int32_T i25, const int32_T i23,
    const emxArray_int32_T iv4, int32_T k, emxArray_real32_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(k);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_k;
    b_k = static_cast<int32_T>(idx);
    expanded.data[iv4.data[b_k]] = y.data[(i23 + i25 * b_k) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel62(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_real32_T b, int32_T OH, emxArray_real32_T convOut,
    int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T orow;
    real32_T cv;
    orow = static_cast<int32_T>(idx);
    cv = 0.0F;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T j;
      j = rows.data[m];
      if ((orow + 1 < 0) && (j < MAX_int32_T - orow)) {
        j = MIN_int32_T;
      } else if ((orow + 1 > 0) && (j > 2147483646 - orow)) {
        j = MAX_int32_T;
      } else {
        j = (orow + j) + 1;
      }
      cv += expanded.data[j - 1] * b.data[(b_dim0 - m) - 1];
    }
    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel63(
    const emxArray_real32_T zfIIR, int32_T x, emxArray_real32_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    convOut.data[orow] += zfIIR.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel64(
    const emxArray_real32_T convOut, int32_T i26, int32_T i23, int32_T i25,
    emxArray_real32_T yc5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i26 - i23) / i25);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    yc5.data[k] = convOut.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel65(
    const emxArray_real32_T yc5, const int32_T bcoef, const int32_T x,
    int32_T n, emxArray_real32_T fv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((n - x) / bcoef);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv.data[k] = yc5.data[x + bcoef * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel66(
    const emxArray_real32_T fv, const int32_T x, int32_T b_fv,
    emxArray_real32_T y, int32_T y_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k + y_dim0 * (x - 1)] = fv.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel7(
    const real32_T *a1, int32_T nb, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel8(
    const real32_T *a1, int32_T na, emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_filtfilt1_kernel9(emxArray_real32_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static void ec_filtfilt1_once()
{
  mwMemoryManagerInit(256U, 2U, 8U, 2048U);
}

static real32_T emlrt_marshallIn(const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real32_T y;
  y = b_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real32_T emlrt_marshallIn(const mxArray *nf, const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real32_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(nf), &thisId);
  emlrtDestroyArray(&nf);
  return y;
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y)
{
  c_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
                             emxArray_real32_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(x), &thisId, y);
  emlrtDestroyArray(&x);
}

static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u)
{
  static const int32_T iv[2]{0, 0};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxSINGLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 2);
  emlrtAssign(&y, m);
  return y;
}

static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray,
                                      int32_T oldNumel,
                                      const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(int32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<int32_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<int32_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

static void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray,
                                       int32_T oldNumel,
                                       const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(
        emlrtSizeMulR2012b((size_t) static_cast<uint32_T>(newNumel),
                           (size_t) static_cast<uint32_T>(emxArray->size[i]),
                           srcLocation, emlrtRootTLSGlobal));
  }
  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }
    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }
    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(real32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }
    if (emxArray->data != nullptr) {
      std::copy(emxArray->data,
                emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<real32_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }
    emxArray->data = static_cast<real32_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

static void emxFree_int32_T(emxArray_int32_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_int32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<int32_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_int32_T *>(nullptr);
  }
}

static void emxFree_real32_T(emxArray_real32_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_real32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<real32_T *>(nullptr)) &&
        (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }
    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_real32_T *>(nullptr);
  }
}

static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
                            const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_int32_T *emxArray;
  *pEmxArray = static_cast<emxArray_int32_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_int32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray, (void *)&emxFree_int32_T,
        nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<int32_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

static void emxInit_real32_T(emxArray_real32_T **pEmxArray,
                             int32_T numDimensions,
                             const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_real32_T *emxArray;
  *pEmxArray = static_cast<emxArray_real32_T *>(
      emlrtMallocEmxArray(sizeof(emxArray_real32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(
        emlrtRootTLSGlobal, false, (void *)pEmxArray, (void *)&emxFree_real32_T,
        nullptr, nullptr, nullptr);
  }
  emxArray = *pEmxArray;
  emxArray->data = static_cast<real32_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(
      emlrtMallocMex(sizeof(int32_T) * static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
                                         emxArray_int32_T *gpu)
{
  int32_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData,
                 static_cast<uint32_T>(cpu->allocatedSize) * sizeof(int32_T));
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      gpu->size[i] = cpu->size[i];
    }
    gpu->allocatedSize = cpu->allocatedSize;
    gpu->canFreeData = true;
    gpu->data = newData;
  } else {
    int32_T actualSizeCpu;
    int32_T actualSizeGpu;
    actualSizeCpu = 1;
    actualSizeGpu = 1;
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      actualSizeGpu *= gpu->size[i];
      actualSizeCpu *= cpu->size[i];
      gpu->size[i] = cpu->size[i];
    }
    if (gpu->allocatedSize < actualSizeCpu) {
      newData = 0UL;
      mwCudaMalloc(&newData,
                   static_cast<uint32_T>(cpu->allocatedSize) * sizeof(int32_T));
      cudaMemcpy(newData, gpu->data,
                 static_cast<uint32_T>(actualSizeGpu) * sizeof(int32_T),
                 cudaMemcpyDeviceToDevice);
      gpu->allocatedSize = cpu->allocatedSize;
      if (gpu->canFreeData) {
        mwCudaFree(gpu->data);
      }
      gpu->canFreeData = true;
      gpu->data = newData;
    }
  }
}

static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu)
{
  real32_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData,
                 static_cast<uint32_T>(cpu->allocatedSize) * sizeof(real32_T));
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      gpu->size[i] = cpu->size[i];
    }
    gpu->allocatedSize = cpu->allocatedSize;
    gpu->canFreeData = true;
    gpu->data = newData;
  } else {
    int32_T actualSizeCpu;
    int32_T actualSizeGpu;
    actualSizeCpu = 1;
    actualSizeGpu = 1;
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      actualSizeGpu *= gpu->size[i];
      actualSizeCpu *= cpu->size[i];
      gpu->size[i] = cpu->size[i];
    }
    if (gpu->allocatedSize < actualSizeCpu) {
      newData = 0UL;
      mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) *
                                 sizeof(real32_T));
      cudaMemcpy(newData, gpu->data,
                 static_cast<uint32_T>(actualSizeGpu) * sizeof(real32_T),
                 cudaMemcpyDeviceToDevice);
      gpu->allocatedSize = cpu->allocatedSize;
      if (gpu->canFreeData) {
        mwCudaFree(gpu->data);
      }
      gpu->canFreeData = true;
      gpu->data = newData;
    }
  }
}

static void gpuEmxFree_int32_T(emxArray_int32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    mwCudaFree(gpu->data);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxFree_real32_T(emxArray_real32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    mwCudaFree(gpu->data);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu,
                                         const emxArray_int32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  if (gpu->numDimensions < cpu->numDimensions) {
    gpu->numDimensions = cpu->numDimensions;
    emlrtFreeMex(gpu->size);
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  } else {
    gpu->numDimensions = cpu->numDimensions;
  }
  actualSize = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < actualSize) {
    if (gpu->canFreeData) {
      mwCudaFree(gpu->data);
    }
    i = cpu->allocatedSize;
    if (i < actualSize) {
      i = actualSize;
    }
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
    mwCudaMalloc(&gpu->data,
                 static_cast<uint32_T>(gpu->allocatedSize) * sizeof(int32_T));
  }
  cudaMemcpy(gpu->data, cpu->data,
             static_cast<uint32_T>(actualSize) * sizeof(int32_T),
             cudaMemcpyHostToDevice);
}

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                          const emxArray_real32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  if (gpu->numDimensions < cpu->numDimensions) {
    gpu->numDimensions = cpu->numDimensions;
    emlrtFreeMex(gpu->size);
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  } else {
    gpu->numDimensions = cpu->numDimensions;
  }
  actualSize = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < actualSize) {
    if (gpu->canFreeData) {
      mwCudaFree(gpu->data);
    }
    i = cpu->allocatedSize;
    if (i < actualSize) {
      i = actualSize;
    }
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
    mwCudaMalloc(&gpu->data,
                 static_cast<uint32_T>(gpu->allocatedSize) * sizeof(real32_T));
  }
  cudaMemcpy(gpu->data, cpu->data,
             static_cast<uint32_T>(actualSize) * sizeof(real32_T),
             cudaMemcpyHostToDevice);
}

static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  cudaMemcpy(cpu->data, gpu->data,
             static_cast<uint32_T>(actualSize) * sizeof(real32_T),
             cudaMemcpyDeviceToHost);
}

static void gpuEmxReset_int32_T(emxArray_int32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_int32_T));
}

static void gpuEmxReset_real32_T(emxArray_real32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real32_T));
}

//
// function y = ec_filtfilt1(x,b,a,z,nf,L)
void ec_filtfilt1(const emxArray_real32_T *cpu_x,
                  const emxArray_real32_T *cpu_b,
                  const emxArray_real32_T *cpu_a,
                  const emxArray_real32_T *cpu_z, real32_T nf, real32_T L,
                  emxArray_real32_T *cpu_y)
{
  dim3 block;
  dim3 grid;
  emxArray_int32_T b_gpu_rows;
  emxArray_int32_T c_gpu_rows;
  emxArray_int32_T c_gpu_y;
  emxArray_int32_T d_gpu_rows;
  emxArray_int32_T e_gpu_rows;
  emxArray_int32_T e_gpu_y;
  emxArray_int32_T f_gpu_y;
  emxArray_int32_T g_gpu_y;
  emxArray_int32_T gpu_iv3;
  emxArray_int32_T gpu_iv4;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T h_gpu_y;
  emxArray_int32_T *b_cpu_rows;
  emxArray_int32_T *c_cpu_rows;
  emxArray_int32_T *c_cpu_y;
  emxArray_int32_T *cpu_iv3;
  emxArray_int32_T *cpu_iv4;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *d_cpu_rows;
  emxArray_int32_T *e_cpu_rows;
  emxArray_int32_T *e_cpu_y;
  emxArray_int32_T *f_cpu_y;
  emxArray_int32_T *h_cpu_y;
  emxArray_int32_T *i_cpu_y;
  emxArray_real32_T b_gpu_a;
  emxArray_real32_T b_gpu_b;
  emxArray_real32_T b_gpu_convOut;
  emxArray_real32_T b_gpu_expanded;
  emxArray_real32_T b_gpu_y;
  emxArray_real32_T b_gpu_zfIIR;
  emxArray_real32_T c_gpu_a;
  emxArray_real32_T c_gpu_b;
  emxArray_real32_T c_gpu_convOut;
  emxArray_real32_T c_gpu_expanded;
  emxArray_real32_T c_gpu_zfIIR;
  emxArray_real32_T d_gpu_a;
  emxArray_real32_T d_gpu_b;
  emxArray_real32_T d_gpu_convOut;
  emxArray_real32_T d_gpu_expanded;
  emxArray_real32_T d_gpu_y;
  emxArray_real32_T e_gpu_a;
  emxArray_real32_T e_gpu_b;
  emxArray_real32_T e_gpu_convOut;
  emxArray_real32_T e_gpu_expanded;
  emxArray_real32_T f_gpu_a;
  emxArray_real32_T f_gpu_b;
  emxArray_real32_T gpu_a;
  emxArray_real32_T gpu_b;
  emxArray_real32_T gpu_convOut;
  emxArray_real32_T gpu_expanded;
  emxArray_real32_T gpu_fv;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_xt;
  emxArray_real32_T gpu_y;
  emxArray_real32_T gpu_yc3;
  emxArray_real32_T gpu_yc5;
  emxArray_real32_T gpu_z;
  emxArray_real32_T gpu_zfIIR;
  emxArray_real32_T i_gpu_y;
  emxArray_real32_T *b_cpu_a;
  emxArray_real32_T *b_cpu_b;
  emxArray_real32_T *b_cpu_convOut;
  emxArray_real32_T *b_cpu_expanded;
  emxArray_real32_T *b_cpu_y;
  emxArray_real32_T *b_cpu_zfIIR;
  emxArray_real32_T *c_cpu_a;
  emxArray_real32_T *c_cpu_b;
  emxArray_real32_T *c_cpu_convOut;
  emxArray_real32_T *c_cpu_expanded;
  emxArray_real32_T *c_cpu_zfIIR;
  emxArray_real32_T *cpu_convOut;
  emxArray_real32_T *cpu_expanded;
  emxArray_real32_T *cpu_fv;
  emxArray_real32_T *cpu_xt;
  emxArray_real32_T *cpu_yc3;
  emxArray_real32_T *cpu_yc5;
  emxArray_real32_T *cpu_zfIIR;
  emxArray_real32_T *d_cpu_a;
  emxArray_real32_T *d_cpu_b;
  emxArray_real32_T *d_cpu_convOut;
  emxArray_real32_T *d_cpu_expanded;
  emxArray_real32_T *d_cpu_y;
  emxArray_real32_T *e_cpu_a;
  emxArray_real32_T *e_cpu_b;
  emxArray_real32_T *e_cpu_convOut;
  emxArray_real32_T *e_cpu_expanded;
  emxArray_real32_T *f_cpu_a;
  emxArray_real32_T *f_cpu_b;
  emxArray_real32_T *g_cpu_y;
  int64_T b;
  int32_T b_na;
  int32_T b_nb;
  int32_T bcoef;
  int32_T c_na;
  int32_T c_nb;
  int32_T csz_idx_0;
  int32_T d_na;
  int32_T d_nb;
  int32_T e_na;
  int32_T e_nb;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T k;
  int32_T na;
  int32_T nb;
  real32_T *b_gpu_a1;
  real32_T *c_gpu_a1;
  real32_T *d_gpu_a1;
  real32_T *e_gpu_a1;
  real32_T *gpu_a1;
  boolean_T a_dirtyOnCpu;
  boolean_T a_dirtyOnGpu;
  boolean_T b_a_dirtyOnGpu;
  boolean_T b_b_dirtyOnCpu;
  boolean_T b_b_dirtyOnGpu;
  boolean_T b_convOut_dirtyOnCpu;
  boolean_T b_convOut_dirtyOnGpu;
  boolean_T b_dirtyOnCpu;
  boolean_T b_dirtyOnGpu;
  boolean_T b_rows_dirtyOnCpu;
  boolean_T b_y_dirtyOnCpu;
  boolean_T b_zfIIR_dirtyOnGpu;
  boolean_T c_a_dirtyOnGpu;
  boolean_T c_b_dirtyOnCpu;
  boolean_T c_b_dirtyOnGpu;
  boolean_T c_convOut_dirtyOnCpu;
  boolean_T c_convOut_dirtyOnGpu;
  boolean_T c_rows_dirtyOnCpu;
  boolean_T c_y_dirtyOnCpu;
  boolean_T c_zfIIR_dirtyOnGpu;
  boolean_T convOut_dirtyOnCpu;
  boolean_T convOut_dirtyOnGpu;
  boolean_T d_a_dirtyOnGpu;
  boolean_T d_b_dirtyOnCpu;
  boolean_T d_b_dirtyOnGpu;
  boolean_T d_convOut_dirtyOnCpu;
  boolean_T d_convOut_dirtyOnGpu;
  boolean_T d_rows_dirtyOnCpu;
  boolean_T d_y_dirtyOnCpu;
  boolean_T e_a_dirtyOnGpu;
  boolean_T e_b_dirtyOnCpu;
  boolean_T e_b_dirtyOnGpu;
  boolean_T e_convOut_dirtyOnCpu;
  boolean_T e_convOut_dirtyOnGpu;
  boolean_T e_rows_dirtyOnCpu;
  boolean_T e_y_dirtyOnCpu;
  boolean_T f_b_dirtyOnCpu;
  boolean_T f_y_dirtyOnCpu;
  boolean_T fv_dirtyOnGpu;
  boolean_T rows_dirtyOnCpu;
  boolean_T x_dirtyOnCpu;
  boolean_T xt_dirtyOnGpu;
  boolean_T y_dirtyOnCpu;
  boolean_T y_dirtyOnGpu;
  boolean_T yc3_dirtyOnGpu;
  boolean_T z_dirtyOnCpu;
  boolean_T zfIIR_dirtyOnGpu;
  gpuEmxReset_real32_T(&gpu_convOut);
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv4);
  gpuEmxReset_real32_T(&gpu_zfIIR);
  gpuEmxReset_int32_T(&c_gpu_y);
  gpuEmxReset_real32_T(&gpu_expanded);
  gpuEmxReset_real32_T(&b_gpu_convOut);
  gpuEmxReset_real32_T(&gpu_yc5);
  gpuEmxReset_int32_T(&b_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv3);
  gpuEmxReset_real32_T(&f_gpu_a);
  gpuEmxReset_real32_T(&f_gpu_b);
  gpuEmxReset_int32_T(&e_gpu_y);
  gpuEmxReset_real32_T(&b_gpu_expanded);
  gpuEmxReset_real32_T(&c_gpu_convOut);
  gpuEmxReset_int32_T(&c_gpu_rows);
  gpuEmxReset_real32_T(&e_gpu_a);
  gpuEmxReset_real32_T(&e_gpu_b);
  gpuEmxReset_real32_T(&b_gpu_y);
  gpuEmxReset_int32_T(&f_gpu_y);
  mwCudaMalloc(&gpu_a1, 4UL);
  gpuEmxReset_real32_T(&c_gpu_expanded);
  gpuEmxReset_real32_T(&b_gpu_zfIIR);
  gpuEmxReset_real32_T(&gpu_yc3);
  mwCudaMalloc(&b_gpu_a1, 4UL);
  gpuEmxReset_real32_T(&d_gpu_convOut);
  gpuEmxReset_real32_T(&d_gpu_a);
  gpuEmxReset_real32_T(&d_gpu_b);
  mwCudaMalloc(&c_gpu_a1, 4UL);
  gpuEmxReset_real32_T(&c_gpu_zfIIR);
  gpuEmxReset_int32_T(&d_gpu_rows);
  gpuEmxReset_int32_T(&g_gpu_y);
  mwCudaMalloc(&d_gpu_a1, 4UL);
  gpuEmxReset_real32_T(&d_gpu_expanded);
  gpuEmxReset_real32_T(&e_gpu_convOut);
  gpuEmxReset_real32_T(&d_gpu_y);
  mwCudaMalloc(&e_gpu_a1, 4UL);
  gpuEmxReset_int32_T(&e_gpu_rows);
  gpuEmxReset_int32_T(&h_gpu_y);
  gpuEmxReset_real32_T(&e_gpu_expanded);
  gpuEmxReset_real32_T(&c_gpu_a);
  gpuEmxReset_real32_T(&c_gpu_b);
  gpuEmxReset_real32_T(&b_gpu_a);
  gpuEmxReset_real32_T(&b_gpu_b);
  gpuEmxReset_real32_T(&gpu_y);
  gpuEmxReset_real32_T(&gpu_xt);
  gpuEmxReset_real32_T(&gpu_fv);
  gpuEmxReset_real32_T(&i_gpu_y);
  gpuEmxReset_real32_T(&gpu_z);
  gpuEmxReset_real32_T(&gpu_a);
  gpuEmxReset_real32_T(&gpu_b);
  gpuEmxReset_real32_T(&gpu_x);
  e_convOut_dirtyOnGpu = false;
  e_convOut_dirtyOnCpu = false;
  e_rows_dirtyOnCpu = false;
  c_zfIIR_dirtyOnGpu = false;
  f_y_dirtyOnCpu = false;
  d_convOut_dirtyOnGpu = false;
  d_convOut_dirtyOnCpu = false;
  d_rows_dirtyOnCpu = false;
  e_a_dirtyOnGpu = false;
  e_b_dirtyOnGpu = false;
  f_b_dirtyOnCpu = false;
  e_y_dirtyOnCpu = false;
  c_convOut_dirtyOnGpu = false;
  c_convOut_dirtyOnCpu = false;
  c_rows_dirtyOnCpu = false;
  d_a_dirtyOnGpu = false;
  d_b_dirtyOnGpu = false;
  e_b_dirtyOnCpu = false;
  d_y_dirtyOnCpu = false;
  b_zfIIR_dirtyOnGpu = false;
  yc3_dirtyOnGpu = false;
  b_convOut_dirtyOnGpu = false;
  b_convOut_dirtyOnCpu = false;
  c_a_dirtyOnGpu = false;
  c_b_dirtyOnGpu = false;
  d_b_dirtyOnCpu = false;
  zfIIR_dirtyOnGpu = false;
  b_rows_dirtyOnCpu = false;
  c_y_dirtyOnCpu = false;
  convOut_dirtyOnGpu = false;
  convOut_dirtyOnCpu = false;
  rows_dirtyOnCpu = false;
  b_y_dirtyOnCpu = false;
  b_a_dirtyOnGpu = false;
  b_b_dirtyOnGpu = false;
  c_b_dirtyOnCpu = false;
  a_dirtyOnGpu = false;
  b_dirtyOnGpu = false;
  b_b_dirtyOnCpu = false;
  xt_dirtyOnGpu = false;
  fv_dirtyOnGpu = false;
  y_dirtyOnCpu = true;
  y_dirtyOnGpu = false;
  z_dirtyOnCpu = true;
  a_dirtyOnCpu = true;
  b_dirtyOnCpu = true;
  x_dirtyOnCpu = true;
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
  // 'ec_filtfilt1:95' coder.gpu.kernelfun;
  //  Add kernelfun pragma to trigger kernel creation
  //  Run
  // 'ec_filtfilt1:98' nChs = cast(width(x),"uint16");
  k = cpu_x->size[1];
  if (cpu_x->size[1] > 65535) {
    k = 65535;
  }
  // 'ec_filtfilt1:99' y = coder.nullcopy(x);
  bcoef = cpu_y->size[0] * cpu_y->size[1];
  cpu_y->size[0] = cpu_x->size[0];
  cpu_y->size[1] = cpu_x->size[1];
  emxEnsureCapacity_real32_T(cpu_y, bcoef, &emlrtRTEI);
  //  Loop across chans
  // 'ec_filtfilt1:102' coder.gpu.kernel(nChs,-1);
  //  Add kernelfun pragma to trigger kernel creation
  // 'ec_filtfilt1:103' for ch = 1:nChs
  if (computeEndIdx(1L, static_cast<int64_T>(static_cast<uint16_T>(k)), 1L) >=
      0L) {
    i = static_cast<int32_T>(L);
    if (static_cast<int32_T>(L) - 1 >= 0) {
      if (nf + 1.0F < 2.0F) {
        i1 = 1;
        i2 = 1;
        i3 = 0;
      } else {
        i1 = static_cast<int32_T>(nf + 1.0F);
        i2 = -1;
        i3 = 2;
      }
      csz_idx_0 = div_s32(i3 - i1, i2) + 1;
      na = cpu_a->size[0];
      nb = cpu_b->size[0];
      b_na = cpu_a->size[0];
      b_nb = cpu_b->size[0];
      c_na = cpu_a->size[0];
      c_nb = cpu_b->size[0];
      d_na = cpu_a->size[0];
      d_nb = cpu_b->size[0];
      e_na = cpu_a->size[0];
      e_nb = cpu_b->size[0];
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
      a_dirtyOnCpu = false;
      ec_filtfilt1_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
          gpu_a, gpu_a1, b_gpu_a1, c_gpu_a1, d_gpu_a1, e_gpu_a1);
    }
  }
  emxInit_real32_T(&cpu_fv, 1, &k_emlrtRTEI, true);
  emxInit_real32_T(&cpu_xt, 1, &l_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_y, 1, &m_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_b, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_a, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_b, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_a, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&cpu_expanded, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&c_cpu_y, 2, &g_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_y, 1, &n_emlrtRTEI, true);
  emxInit_real32_T(&cpu_convOut, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_expanded, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&e_cpu_y, 2, &g_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_rows, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&cpu_zfIIR, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_b, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_a, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_convOut, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&cpu_yc3, 1, &i_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_zfIIR, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_expanded, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&f_cpu_y, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&g_cpu_y, 1, &o_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_b, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_a, 1, &e_emlrtRTEI, true);
  emxInit_int32_T(&c_cpu_rows, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_convOut, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_expanded, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&h_cpu_y, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_b, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_a, 1, &e_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv3, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&d_cpu_rows, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&cpu_yc5, 1, &j_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_convOut, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_expanded, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&i_cpu_y, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_zfIIR, 1, &f_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv4, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&e_cpu_rows, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_convOut, 1, &f_emlrtRTEI, true);
  b = computeEndIdx(1L, static_cast<int64_T>(static_cast<uint16_T>(k)), 1L);
  for (int64_T ch{0L}; ch <= b; ch++) {
    int32_T b_x;
    boolean_T validLaunchParams;
    // 'ec_filtfilt1:104' coder.gpu.constantMemory(x);
    // 'ec_filtfilt1:105' coder.gpu.constantMemory(y);
    // 'ec_filtfilt1:106' y(:,ch) = filtfilt_lfn(x(:,ch),b,a,z,nf,L);
    k = cpu_fv->size[0];
    cpu_fv->size[0] = cpu_x->size[0];
    emxEnsureCapacity_real32_T(cpu_fv, k, &b_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv);
    b_x = cpu_x->size[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_x + 1L),
                                                &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
      }
      x_dirtyOnCpu = false;
      ec_filtfilt1_kernel2<<<grid, block>>>(
          static_cast<int32_T>(static_cast<uint16_T>(ch + 1L)), gpu_x, b_x,
          gpu_fv, cpu_x->size[0U]);
      fv_dirtyOnGpu = true;
    }
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
    // 'ec_filtfilt1:134' for ii = 1:L
    for (int32_T ii{0}; ii < i; ii++) {
      dim3 r;
      dim3 r1;
      real_T b_OH;
      real_T x;
      int32_T KH;
      int32_T i23;
      int32_T i25;
      int32_T i26;
      int32_T n;
      int32_T offsetH;
      int32_T zfSize_idx_0;
      real32_T a;
      uint32_T OH;
      uint32_T u;
      uint32_T window_idx_0;
      // 'ec_filtfilt1:135' coder.gpu.constantMemory(x);
      // 'ec_filtfilt1:136' coder.gpu.constantMemory(b);
      // 'ec_filtfilt1:137' coder.gpu.constantMemory(a);
      // 'ec_filtfilt1:138' coder.gpu.constantMemory(z);
      // 'ec_filtfilt1:139' xt = bsxfun(@minus, 2*x(1,:),x(nf(1,1)+1:-1:2,:));
      if (fv_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv, &gpu_fv);
      }
      a = 2.0F * cpu_fv->data[0];
      k = cpu_xt->size[0];
      cpu_xt->size[0] = csz_idx_0;
      emxEnsureCapacity_real32_T(cpu_xt, k, &c_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_xt, &gpu_xt);
      if (csz_idx_0 != 0) {
        b_x = csz_idx_0 - 1;
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(b_x + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel3<<<grid, block>>>(
              gpu_fv, static_cast<int32_T>(div_s32(i3 - i1, i2) + 1 != 1), i2,
              i1, a, csz_idx_0 - 1, gpu_xt);
          xt_dirtyOnGpu = true;
        }
      }
      // 'ec_filtfilt1:140' [~,zo] =
      // filter(b(:,ii),a(:,ii),xt,z(:,ii)*xt(1,:),1);
      if (xt_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_xt, &gpu_xt);
      }
      xt_dirtyOnGpu = false;
      a = cpu_xt->data[0];
      k = b_cpu_y->size[0];
      b_cpu_y->size[0] = cpu_z->size[0];
      emxEnsureCapacity_real32_T(b_cpu_y, k, &d_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(b_cpu_y, &gpu_y);
      bcoef = cpu_z->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (z_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
        }
        z_dirtyOnCpu = false;
        ec_filtfilt1_kernel4<<<grid, block>>>(a, gpu_z, bcoef, gpu_y);
      }
      k = b_cpu_b->size[0];
      b_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real32_T(b_cpu_b, k, &e_emlrtRTEI);
      if (!b_b_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(b_cpu_b, &b_gpu_b);
      }
      bcoef = cpu_b->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (b_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
        }
        b_dirtyOnCpu = false;
        if (b_b_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_b, b_cpu_b);
        }
        ec_filtfilt1_kernel5<<<grid, block>>>(gpu_b, bcoef, b_gpu_b);
        b_dirtyOnGpu = true;
        b_b_dirtyOnCpu = false;
      }
      k = b_cpu_a->size[0];
      b_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real32_T(b_cpu_a, k, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(b_cpu_a, &b_gpu_a);
      bcoef = cpu_a->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (a_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
        }
        a_dirtyOnCpu = false;
        ec_filtfilt1_kernel6<<<grid, block>>>(gpu_a, bcoef, b_gpu_a);
        a_dirtyOnGpu = true;
      }
      if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
          (!(cpu_a->data[0] == 0.0F)) && (cpu_a->data[0] != 1.0F)) {
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(nb), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_b, b_cpu_b);
          }
          ec_filtfilt1_kernel7<<<grid, block>>>(e_gpu_a1, nb, b_gpu_b);
          b_dirtyOnGpu = true;
          b_b_dirtyOnCpu = false;
        }
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(na - 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel8<<<grid, block>>>(e_gpu_a1, na, b_gpu_a);
        }
        ec_filtfilt1_kernel9<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_a);
        a_dirtyOnGpu = true;
      }
      if (b_cpu_a->size[0] > b_cpu_b->size[0]) {
        b_x = b_cpu_a->size[0] - b_cpu_b->size[0];
        k = b_cpu_b->size[0];
        bcoef = b_cpu_b->size[0];
        b_cpu_b->size[0] = b_cpu_a->size[0];
        emxEnsureCapacity_real32_T(b_cpu_b, bcoef, &f_emlrtRTEI);
        if (!b_b_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(b_cpu_b, &b_gpu_b);
        }
        if (b_x - 1 >= 0) {
          if (b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_b, &b_gpu_b);
          }
          std::memset(&b_cpu_b->data[k], 0,
                      static_cast<uint32_T>(b_x) * sizeof(real32_T));
          b_b_dirtyOnCpu = true;
          b_dirtyOnGpu = false;
        }
      }
      zfSize_idx_0 = b_cpu_b->size[0] - 1;
      if (cpu_xt->size[0] == 0) {
        k = cpu_zfIIR->size[0];
        cpu_zfIIR->size[0] = b_cpu_b->size[0] - 1;
        emxEnsureCapacity_real32_T(cpu_zfIIR, k, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_zfIIR, &c_gpu_zfIIR);
      } else {
        window_idx_0 = static_cast<uint32_T>(b_cpu_b->size[0]);
        OH = (static_cast<uint32_T>(cpu_xt->size[0]) +
              static_cast<uint32_T>(b_cpu_b->size[0])) -
             1U;
        b_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }
        KH = b_cpu_b->size[0];
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(b_cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(b_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) &&
            (b_cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(u))) {
          bcoef = MAX_int32_T;
        } else {
          bcoef = static_cast<int32_T>(u) + b_cpu_b->size[0];
        }
        k = cpu_expanded->size[0];
        cpu_expanded->size[0] = bcoef - 1;
        emxEnsureCapacity_real32_T(cpu_expanded, k, &g_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_expanded, &e_gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(
                (static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) -
                1L),
            &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel10<<<grid, block>>>(static_cast<int32_T>(u),
                                                 window_idx_0, e_gpu_expanded);
        }
        n = cpu_xt->size[0];
        k = c_cpu_y->size[0] * c_cpu_y->size[1];
        c_cpu_y->size[0] = 1;
        c_cpu_y->size[1] = cpu_xt->size[0];
        emxEnsureCapacity_int32_T(c_cpu_y, k, &h_emlrtRTEI);
        if (!b_y_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(c_cpu_y, &h_gpu_y);
        }
        c_cpu_y->data[0] = 1;
        b_y_dirtyOnCpu = true;
        bcoef = 1;
        for (k = 0; k <= n - 2; k++) {
          bcoef++;
          c_cpu_y->data[k + 1] = bcoef;
        }
        bcoef = c_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&h_gpu_y, c_cpu_y);
          b_y_dirtyOnCpu = false;
          ec_filtfilt1_kernel11<<<grid, block>>>(gpu_xt, offsetH, h_gpu_y,
                                                 bcoef, e_gpu_expanded);
        }
        k = cpu_rows->size[0] * cpu_rows->size[1];
        cpu_rows->size[0] = 1;
        cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(cpu_rows, k, &h_emlrtRTEI);
        if (!rows_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(cpu_rows, &e_gpu_rows);
        }
        cpu_rows->data[0] = 0;
        rows_dirtyOnCpu = true;
        bcoef = 0;
        for (k = 0; k <= KH - 2; k++) {
          bcoef++;
          cpu_rows->data[k + 1] = bcoef;
        }
        k = cpu_convOut->size[0];
        cpu_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real32_T(cpu_convOut, k, &g_emlrtRTEI);
        if (!convOut_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(cpu_convOut, &e_gpu_convOut);
        }
        r = dim3(
            static_cast<uint32_T>(std::floor(
                (static_cast<real_T>(OH) + (static_cast<real_T>(b_x) - 1.0)) /
                static_cast<real_T>(b_x))),
            1U, 1U);
        r1 = dim3(static_cast<uint32_T>(b_x), 1U, 1U);
        validLaunchParams = mwApplyLaunchParameters(
            static_cast<real_T>(static_cast<int32_T>(u)), r, r1, &grid, &block,
            1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&e_gpu_rows, cpu_rows);
          rows_dirtyOnCpu = false;
          if (b_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_b, b_cpu_b);
          }
          b_b_dirtyOnCpu = false;
          if (convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_convOut, cpu_convOut);
          }
          ec_filtfilt1_kernel12<<<grid, block>>>(
              e_gpu_expanded, e_gpu_rows, b_gpu_b, static_cast<int32_T>(u),
              e_gpu_convOut, b_cpu_b->size[0U]);
          convOut_dirtyOnGpu = true;
          convOut_dirtyOnCpu = false;
        }
        if (b_cpu_y->size[0] != 0) {
          if (b_cpu_y->size[0] == 1) {
            if (convOut_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_convOut, cpu_convOut);
            }
            ec_filtfilt1_kernel14<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                gpu_y, e_gpu_convOut);
            convOut_dirtyOnGpu = true;
            convOut_dirtyOnCpu = false;
          } else {
            b_x = b_cpu_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(
                static_cast<real_T>(b_x), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (convOut_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_convOut, cpu_convOut);
              }
              ec_filtfilt1_kernel13<<<grid, block>>>(gpu_y, b_x, e_gpu_convOut);
              convOut_dirtyOnGpu = true;
              convOut_dirtyOnCpu = false;
            }
          }
        }
        b_x = cpu_xt->size[0] + b_cpu_a->size[0];
        for (KH = 0; KH <= b_x - 2; KH++) {
          bcoef = static_cast<int32_T>(
              std::fmin(static_cast<real_T>(KH) + 1.0,
                        static_cast<real_T>(b_cpu_a->size[0])));
          for (offsetH = 0; offsetH <= bcoef - 2; offsetH++) {
            if (convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_convOut, &e_gpu_convOut);
            }
            if (a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_a, &b_gpu_a);
            }
            a_dirtyOnGpu = false;
            cpu_convOut->data[KH] -= cpu_convOut->data[(KH - offsetH) - 1] *
                                     b_cpu_a->data[offsetH + 1];
            convOut_dirtyOnCpu = true;
            convOut_dirtyOnGpu = false;
          }
        }
        if (static_cast<uint32_T>(cpu_xt->size[0]) + 1U >
            static_cast<uint32_T>(cpu_convOut->size[0])) {
          b_x = 0;
          bcoef = 0;
        } else {
          b_x = cpu_xt->size[0];
          bcoef = cpu_convOut->size[0];
        }
        k = cpu_zfIIR->size[0];
        cpu_zfIIR->size[0] = bcoef - b_x;
        emxEnsureCapacity_real32_T(cpu_zfIIR, k, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_zfIIR, &c_gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(bcoef - b_x), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_convOut, cpu_convOut);
          }
          convOut_dirtyOnCpu = false;
          ec_filtfilt1_kernel15<<<grid, block>>>(e_gpu_convOut, b_x, bcoef,
                                                 c_gpu_zfIIR);
          zfIIR_dirtyOnGpu = true;
        }
        b_x = b_cpu_a->size[0];
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(b_x - 2L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_convOut, cpu_convOut);
          }
          convOut_dirtyOnCpu = false;
          ec_filtfilt1_kernel16<<<grid, block>>>(e_gpu_convOut, b_gpu_a, b_x,
                                                 c_gpu_zfIIR, b_cpu_a->size[0U],
                                                 cpu_xt->size[0U]);
          zfIIR_dirtyOnGpu = true;
        }
        k = cpu_zfIIR->size[0];
        cpu_zfIIR->size[0] = zfSize_idx_0;
        emxEnsureCapacity_real32_T(cpu_zfIIR, k, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_zfIIR, &c_gpu_zfIIR);
      }
      //  outer product
      // 'ec_filtfilt1:141' [yc2,zo] = filter(b(:,ii),a(:,ii),x,zo,1);
      k = c_cpu_b->size[0];
      c_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real32_T(c_cpu_b, k, &e_emlrtRTEI);
      if (!c_b_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(c_cpu_b, &c_gpu_b);
      }
      bcoef = cpu_b->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (b_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
        }
        b_dirtyOnCpu = false;
        if (c_b_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_b, c_cpu_b);
        }
        ec_filtfilt1_kernel17<<<grid, block>>>(gpu_b, bcoef, c_gpu_b);
        b_b_dirtyOnGpu = true;
        c_b_dirtyOnCpu = false;
      }
      k = c_cpu_a->size[0];
      c_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real32_T(c_cpu_a, k, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(c_cpu_a, &c_gpu_a);
      bcoef = cpu_a->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (a_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
        }
        a_dirtyOnCpu = false;
        ec_filtfilt1_kernel18<<<grid, block>>>(gpu_a, bcoef, c_gpu_a);
        b_a_dirtyOnGpu = true;
      }
      if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
          (!(cpu_a->data[0] == 0.0F)) && (cpu_a->data[0] != 1.0F)) {
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(b_nb), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_b, c_cpu_b);
          }
          ec_filtfilt1_kernel19<<<grid, block>>>(d_gpu_a1, b_nb, c_gpu_b);
          b_b_dirtyOnGpu = true;
          c_b_dirtyOnCpu = false;
        }
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(b_na - 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel20<<<grid, block>>>(d_gpu_a1, b_na, c_gpu_a);
        }
        ec_filtfilt1_kernel21<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(c_gpu_a);
        b_a_dirtyOnGpu = true;
      }
      if (c_cpu_a->size[0] > c_cpu_b->size[0]) {
        b_x = c_cpu_a->size[0] - c_cpu_b->size[0];
        k = c_cpu_b->size[0];
        bcoef = c_cpu_b->size[0];
        c_cpu_b->size[0] = c_cpu_a->size[0];
        emxEnsureCapacity_real32_T(c_cpu_b, bcoef, &f_emlrtRTEI);
        if (!c_b_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(c_cpu_b, &c_gpu_b);
        }
        if (b_x - 1 >= 0) {
          if (b_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_b, &c_gpu_b);
          }
          std::memset(&c_cpu_b->data[k], 0,
                      static_cast<uint32_T>(b_x) * sizeof(real32_T));
          c_b_dirtyOnCpu = true;
          b_b_dirtyOnGpu = false;
        }
      }
      zfSize_idx_0 = c_cpu_b->size[0] - 1;
      if (cpu_fv->size[0] == 0) {
        d_cpu_y->size[0] = 0;
        k = b_cpu_zfIIR->size[0];
        b_cpu_zfIIR->size[0] = c_cpu_b->size[0] - 1;
        emxEnsureCapacity_real32_T(b_cpu_zfIIR, k, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_zfIIR, &b_gpu_zfIIR);
      } else {
        window_idx_0 = static_cast<uint32_T>(c_cpu_b->size[0]);
        OH = (static_cast<uint32_T>(cpu_fv->size[0]) +
              static_cast<uint32_T>(c_cpu_b->size[0])) -
             1U;
        b_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }
        KH = c_cpu_b->size[0];
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(c_cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(c_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) &&
            (c_cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(u))) {
          bcoef = MAX_int32_T;
        } else {
          bcoef = static_cast<int32_T>(u) + c_cpu_b->size[0];
        }
        k = b_cpu_expanded->size[0];
        b_cpu_expanded->size[0] = bcoef - 1;
        emxEnsureCapacity_real32_T(b_cpu_expanded, k, &g_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_expanded, &d_gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(
                (static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) -
                1L),
            &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel22<<<grid, block>>>(static_cast<int32_T>(u),
                                                 window_idx_0, d_gpu_expanded);
        }
        n = cpu_fv->size[0];
        k = e_cpu_y->size[0] * e_cpu_y->size[1];
        e_cpu_y->size[0] = 1;
        e_cpu_y->size[1] = cpu_fv->size[0];
        emxEnsureCapacity_int32_T(e_cpu_y, k, &h_emlrtRTEI);
        if (!c_y_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(e_cpu_y, &g_gpu_y);
        }
        e_cpu_y->data[0] = 1;
        c_y_dirtyOnCpu = true;
        bcoef = 1;
        for (k = 0; k <= n - 2; k++) {
          bcoef++;
          e_cpu_y->data[k + 1] = bcoef;
        }
        bcoef = e_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&g_gpu_y, e_cpu_y);
          c_y_dirtyOnCpu = false;
          ec_filtfilt1_kernel23<<<grid, block>>>(gpu_fv, offsetH, g_gpu_y,
                                                 bcoef, d_gpu_expanded);
        }
        k = b_cpu_rows->size[0] * b_cpu_rows->size[1];
        b_cpu_rows->size[0] = 1;
        b_cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(b_cpu_rows, k, &h_emlrtRTEI);
        if (!b_rows_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(b_cpu_rows, &d_gpu_rows);
        }
        b_cpu_rows->data[0] = 0;
        b_rows_dirtyOnCpu = true;
        bcoef = 0;
        for (k = 0; k <= KH - 2; k++) {
          bcoef++;
          b_cpu_rows->data[k + 1] = bcoef;
        }
        k = b_cpu_convOut->size[0];
        b_cpu_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real32_T(b_cpu_convOut, k, &g_emlrtRTEI);
        if (!b_convOut_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(b_cpu_convOut, &d_gpu_convOut);
        }
        r = dim3(
            static_cast<uint32_T>(std::floor(
                (static_cast<real_T>(OH) + (static_cast<real_T>(b_x) - 1.0)) /
                static_cast<real_T>(b_x))),
            1U, 1U);
        r1 = dim3(static_cast<uint32_T>(b_x), 1U, 1U);
        validLaunchParams = mwApplyLaunchParameters(
            static_cast<real_T>(static_cast<int32_T>(u)), r, r1, &grid, &block,
            1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&d_gpu_rows, b_cpu_rows);
          b_rows_dirtyOnCpu = false;
          if (c_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_b, c_cpu_b);
          }
          c_b_dirtyOnCpu = false;
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_convOut, b_cpu_convOut);
          }
          ec_filtfilt1_kernel24<<<grid, block>>>(
              d_gpu_expanded, d_gpu_rows, c_gpu_b, static_cast<int32_T>(u),
              d_gpu_convOut, c_cpu_b->size[0U]);
          b_convOut_dirtyOnGpu = true;
          b_convOut_dirtyOnCpu = false;
        }
        if (cpu_zfIIR->size[0] != 0) {
          if (cpu_zfIIR->size[0] == 1) {
            if (b_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_convOut, &d_gpu_convOut);
            }
            if (zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_zfIIR, &c_gpu_zfIIR);
            }
            zfIIR_dirtyOnGpu = false;
            b_cpu_convOut->data[0] += cpu_zfIIR->data[0];
            b_convOut_dirtyOnCpu = true;
            b_convOut_dirtyOnGpu = false;
          } else {
            b_x = cpu_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(
                static_cast<real_T>(b_x), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_convOut_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_convOut, b_cpu_convOut);
              }
              ec_filtfilt1_kernel25<<<grid, block>>>(c_gpu_zfIIR, b_x,
                                                     d_gpu_convOut);
              b_convOut_dirtyOnGpu = true;
              b_convOut_dirtyOnCpu = false;
            }
          }
        }
        b_x = cpu_fv->size[0] + c_cpu_a->size[0];
        for (KH = 0; KH <= b_x - 2; KH++) {
          bcoef = static_cast<int32_T>(
              std::fmin(static_cast<real_T>(KH) + 1.0,
                        static_cast<real_T>(c_cpu_a->size[0])));
          for (offsetH = 0; offsetH <= bcoef - 2; offsetH++) {
            if (b_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_convOut, &d_gpu_convOut);
            }
            if (b_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_a, &c_gpu_a);
            }
            b_a_dirtyOnGpu = false;
            b_cpu_convOut->data[KH] -= b_cpu_convOut->data[(KH - offsetH) - 1] *
                                       c_cpu_a->data[offsetH + 1];
            b_convOut_dirtyOnCpu = true;
            b_convOut_dirtyOnGpu = false;
          }
        }
        if (static_cast<uint32_T>(cpu_fv->size[0]) + 1U >
            static_cast<uint32_T>(b_cpu_convOut->size[0])) {
          b_x = 0;
          bcoef = 0;
        } else {
          b_x = cpu_fv->size[0];
          bcoef = b_cpu_convOut->size[0];
        }
        k = b_cpu_zfIIR->size[0];
        b_cpu_zfIIR->size[0] = bcoef - b_x;
        emxEnsureCapacity_real32_T(b_cpu_zfIIR, k, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_zfIIR, &b_gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(bcoef - b_x), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_convOut, b_cpu_convOut);
          }
          b_convOut_dirtyOnCpu = false;
          ec_filtfilt1_kernel26<<<grid, block>>>(d_gpu_convOut, b_x, bcoef,
                                                 b_gpu_zfIIR);
          b_zfIIR_dirtyOnGpu = true;
        }
        b_x = c_cpu_a->size[0];
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(b_x - 2L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_convOut, b_cpu_convOut);
          }
          b_convOut_dirtyOnCpu = false;
          ec_filtfilt1_kernel27<<<grid, block>>>(d_gpu_convOut, c_gpu_a, b_x,
                                                 b_gpu_zfIIR, c_cpu_a->size[0U],
                                                 cpu_fv->size[0U]);
          b_zfIIR_dirtyOnGpu = true;
        }
        k = b_cpu_zfIIR->size[0];
        b_cpu_zfIIR->size[0] = zfSize_idx_0;
        emxEnsureCapacity_real32_T(b_cpu_zfIIR, k, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_zfIIR, &b_gpu_zfIIR);
        k = d_cpu_y->size[0];
        d_cpu_y->size[0] = cpu_fv->size[0];
        emxEnsureCapacity_real32_T(d_cpu_y, k, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(d_cpu_y, &d_gpu_y);
        bcoef = cpu_fv->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_convOut, b_cpu_convOut);
          }
          b_convOut_dirtyOnCpu = false;
          ec_filtfilt1_kernel28<<<grid, block>>>(d_gpu_convOut, bcoef, d_gpu_y);
        }
      }
      // 'ec_filtfilt1:142' xt = bsxfun(@minus,
      // 2*x(end,:),x(end-1:-1:end-nf(1,1),:));
      a = static_cast<real32_T>(cpu_fv->size[0]) - nf;
      if (a >
          static_cast<real32_T>(static_cast<real_T>(cpu_fv->size[0]) - 1.0)) {
        n = 1;
        KH = 1;
        b_x = 0;
      } else {
        n = static_cast<int32_T>(
            static_cast<real32_T>(static_cast<real_T>(cpu_fv->size[0]) - 1.0));
        KH = -1;
        b_x = static_cast<int32_T>(a);
      }
      fv_dirtyOnGpu = false;
      a = 2.0F * cpu_fv->data[cpu_fv->size[0] - 1];
      k = div_s32(b_x - n, KH) + 1;
      bcoef = cpu_xt->size[0];
      cpu_xt->size[0] = div_s32(b_x - n, KH) + 1;
      emxEnsureCapacity_real32_T(cpu_xt, bcoef, &c_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_xt, &gpu_xt);
      if (k != 0) {
        bcoef = (div_s32(b_x - n, KH) + 1 != 1);
        b_x = k - 1;
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(b_x + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel29<<<grid, block>>>(gpu_fv, bcoef, KH, n, a, k - 1,
                                                 gpu_xt);
          xt_dirtyOnGpu = true;
        }
      }
      // 'ec_filtfilt1:143' yc3 = filter(b(:,ii),a(:,ii),xt,zo,1);
      k = d_cpu_b->size[0];
      d_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real32_T(d_cpu_b, k, &e_emlrtRTEI);
      if (!d_b_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(d_cpu_b, &d_gpu_b);
      }
      bcoef = cpu_b->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (b_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
        }
        b_dirtyOnCpu = false;
        if (d_b_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_b, d_cpu_b);
        }
        ec_filtfilt1_kernel30<<<grid, block>>>(gpu_b, bcoef, d_gpu_b);
        c_b_dirtyOnGpu = true;
        d_b_dirtyOnCpu = false;
      }
      k = d_cpu_a->size[0];
      d_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real32_T(d_cpu_a, k, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(d_cpu_a, &d_gpu_a);
      bcoef = cpu_a->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (a_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
        }
        a_dirtyOnCpu = false;
        ec_filtfilt1_kernel31<<<grid, block>>>(gpu_a, bcoef, d_gpu_a);
        c_a_dirtyOnGpu = true;
      }
      if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
          (!(cpu_a->data[0] == 0.0F)) && (cpu_a->data[0] != 1.0F)) {
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(c_nb), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_b, d_cpu_b);
          }
          ec_filtfilt1_kernel32<<<grid, block>>>(c_gpu_a1, c_nb, d_gpu_b);
          c_b_dirtyOnGpu = true;
          d_b_dirtyOnCpu = false;
        }
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(c_na - 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel33<<<grid, block>>>(c_gpu_a1, c_na, d_gpu_a);
        }
        ec_filtfilt1_kernel34<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_a);
        c_a_dirtyOnGpu = true;
      }
      if (d_cpu_a->size[0] > d_cpu_b->size[0]) {
        b_x = d_cpu_a->size[0] - d_cpu_b->size[0];
        k = d_cpu_b->size[0];
        bcoef = d_cpu_b->size[0];
        d_cpu_b->size[0] = d_cpu_a->size[0];
        emxEnsureCapacity_real32_T(d_cpu_b, bcoef, &f_emlrtRTEI);
        if (!d_b_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(d_cpu_b, &d_gpu_b);
        }
        if (b_x - 1 >= 0) {
          if (c_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_b, &d_gpu_b);
          }
          std::memset(&d_cpu_b->data[k], 0,
                      static_cast<uint32_T>(b_x) * sizeof(real32_T));
          d_b_dirtyOnCpu = true;
          c_b_dirtyOnGpu = false;
        }
      }
      if (cpu_xt->size[0] == 0) {
        cpu_yc3->size[0] = 0;
      } else {
        window_idx_0 = static_cast<uint32_T>(d_cpu_b->size[0]);
        OH = (static_cast<uint32_T>(cpu_xt->size[0]) +
              static_cast<uint32_T>(d_cpu_b->size[0])) -
             1U;
        b_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }
        KH = d_cpu_b->size[0];
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(d_cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(d_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) &&
            (d_cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(u))) {
          bcoef = MAX_int32_T;
        } else {
          bcoef = static_cast<int32_T>(u) + d_cpu_b->size[0];
        }
        k = c_cpu_expanded->size[0];
        c_cpu_expanded->size[0] = bcoef - 1;
        emxEnsureCapacity_real32_T(c_cpu_expanded, k, &g_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_cpu_expanded, &c_gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(
                (static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) -
                1L),
            &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel35<<<grid, block>>>(static_cast<int32_T>(u),
                                                 window_idx_0, c_gpu_expanded);
        }
        n = cpu_xt->size[0];
        k = f_cpu_y->size[0] * f_cpu_y->size[1];
        f_cpu_y->size[0] = 1;
        f_cpu_y->size[1] = cpu_xt->size[0];
        emxEnsureCapacity_int32_T(f_cpu_y, k, &h_emlrtRTEI);
        if (!d_y_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(f_cpu_y, &f_gpu_y);
        }
        f_cpu_y->data[0] = 1;
        d_y_dirtyOnCpu = true;
        bcoef = 1;
        for (k = 0; k <= n - 2; k++) {
          bcoef++;
          f_cpu_y->data[k + 1] = bcoef;
        }
        bcoef = f_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&f_gpu_y, f_cpu_y);
          d_y_dirtyOnCpu = false;
          ec_filtfilt1_kernel36<<<grid, block>>>(gpu_xt, offsetH, f_gpu_y,
                                                 bcoef, c_gpu_expanded);
        }
        k = c_cpu_rows->size[0] * c_cpu_rows->size[1];
        c_cpu_rows->size[0] = 1;
        c_cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(c_cpu_rows, k, &h_emlrtRTEI);
        if (!c_rows_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(c_cpu_rows, &c_gpu_rows);
        }
        c_cpu_rows->data[0] = 0;
        c_rows_dirtyOnCpu = true;
        bcoef = 0;
        for (k = 0; k <= KH - 2; k++) {
          bcoef++;
          c_cpu_rows->data[k + 1] = bcoef;
        }
        k = c_cpu_convOut->size[0];
        c_cpu_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real32_T(c_cpu_convOut, k, &g_emlrtRTEI);
        if (!c_convOut_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(c_cpu_convOut, &c_gpu_convOut);
        }
        r = dim3(
            static_cast<uint32_T>(std::floor(
                (static_cast<real_T>(OH) + (static_cast<real_T>(b_x) - 1.0)) /
                static_cast<real_T>(b_x))),
            1U, 1U);
        r1 = dim3(static_cast<uint32_T>(b_x), 1U, 1U);
        validLaunchParams = mwApplyLaunchParameters(
            static_cast<real_T>(static_cast<int32_T>(u)), r, r1, &grid, &block,
            1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_rows, c_cpu_rows);
          c_rows_dirtyOnCpu = false;
          if (d_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_b, d_cpu_b);
          }
          d_b_dirtyOnCpu = false;
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_convOut, c_cpu_convOut);
          }
          ec_filtfilt1_kernel37<<<grid, block>>>(
              c_gpu_expanded, c_gpu_rows, d_gpu_b, static_cast<int32_T>(u),
              c_gpu_convOut, d_cpu_b->size[0U]);
          c_convOut_dirtyOnGpu = true;
          c_convOut_dirtyOnCpu = false;
        }
        if (b_cpu_zfIIR->size[0] != 0) {
          if (b_cpu_zfIIR->size[0] == 1) {
            if (c_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_convOut, &c_gpu_convOut);
            }
            if (b_zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_zfIIR, &b_gpu_zfIIR);
            }
            b_zfIIR_dirtyOnGpu = false;
            c_cpu_convOut->data[0] += b_cpu_zfIIR->data[0];
            c_convOut_dirtyOnCpu = true;
            c_convOut_dirtyOnGpu = false;
          } else {
            b_x = b_cpu_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(
                static_cast<real_T>(b_x), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_convOut_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_convOut, c_cpu_convOut);
              }
              ec_filtfilt1_kernel38<<<grid, block>>>(b_gpu_zfIIR, b_x,
                                                     c_gpu_convOut);
              c_convOut_dirtyOnGpu = true;
              c_convOut_dirtyOnCpu = false;
            }
          }
        }
        b_x = cpu_xt->size[0] + d_cpu_a->size[0];
        for (KH = 0; KH <= b_x - 2; KH++) {
          bcoef = static_cast<int32_T>(
              std::fmin(static_cast<real_T>(KH) + 1.0,
                        static_cast<real_T>(d_cpu_a->size[0])));
          for (offsetH = 0; offsetH <= bcoef - 2; offsetH++) {
            if (c_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_convOut, &c_gpu_convOut);
            }
            if (c_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_a, &d_gpu_a);
            }
            c_a_dirtyOnGpu = false;
            c_cpu_convOut->data[KH] -= c_cpu_convOut->data[(KH - offsetH) - 1] *
                                       d_cpu_a->data[offsetH + 1];
            c_convOut_dirtyOnCpu = true;
            c_convOut_dirtyOnGpu = false;
          }
        }
        k = cpu_yc3->size[0];
        cpu_yc3->size[0] = cpu_xt->size[0];
        emxEnsureCapacity_real32_T(cpu_yc3, k, &i_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_yc3, &gpu_yc3);
        bcoef = cpu_xt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_convOut, c_cpu_convOut);
          }
          c_convOut_dirtyOnCpu = false;
          ec_filtfilt1_kernel39<<<grid, block>>>(c_gpu_convOut, bcoef, gpu_yc3);
          yc3_dirtyOnGpu = true;
        }
      }
      // 'ec_filtfilt1:145' [~,zo] =
      // filter(b(:,ii),a(:,ii),yc3(end:-1:1,:),z(:,ii)*yc3(end,:),1);
      if (cpu_yc3->size[0] < 1) {
        i23 = 1;
        i25 = 1;
        i26 = 0;
      } else {
        i23 = cpu_yc3->size[0];
        i25 = -1;
        i26 = 1;
      }
      if (yc3_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_yc3, &gpu_yc3);
      }
      yc3_dirtyOnGpu = false;
      a = cpu_yc3->data[cpu_yc3->size[0] - 1];
      k = g_cpu_y->size[0];
      g_cpu_y->size[0] = cpu_z->size[0];
      emxEnsureCapacity_real32_T(g_cpu_y, k, &d_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(g_cpu_y, &b_gpu_y);
      bcoef = cpu_z->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (z_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
        }
        z_dirtyOnCpu = false;
        ec_filtfilt1_kernel40<<<grid, block>>>(a, gpu_z, bcoef, b_gpu_y);
      }
      k = e_cpu_b->size[0];
      e_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real32_T(e_cpu_b, k, &e_emlrtRTEI);
      if (!e_b_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(e_cpu_b, &e_gpu_b);
      }
      bcoef = cpu_b->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (b_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
        }
        b_dirtyOnCpu = false;
        if (e_b_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_b, e_cpu_b);
        }
        ec_filtfilt1_kernel41<<<grid, block>>>(gpu_b, bcoef, e_gpu_b);
        d_b_dirtyOnGpu = true;
        e_b_dirtyOnCpu = false;
      }
      k = e_cpu_a->size[0];
      e_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real32_T(e_cpu_a, k, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(e_cpu_a, &e_gpu_a);
      bcoef = cpu_a->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (a_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
        }
        a_dirtyOnCpu = false;
        ec_filtfilt1_kernel42<<<grid, block>>>(gpu_a, bcoef, e_gpu_a);
        d_a_dirtyOnGpu = true;
      }
      if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
          (!(cpu_a->data[0] == 0.0F)) && (cpu_a->data[0] != 1.0F)) {
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(d_nb), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (e_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_b, e_cpu_b);
          }
          ec_filtfilt1_kernel43<<<grid, block>>>(b_gpu_a1, d_nb, e_gpu_b);
          d_b_dirtyOnGpu = true;
          e_b_dirtyOnCpu = false;
        }
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(d_na - 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel44<<<grid, block>>>(b_gpu_a1, d_na, e_gpu_a);
        }
        ec_filtfilt1_kernel45<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(e_gpu_a);
        d_a_dirtyOnGpu = true;
      }
      if (e_cpu_a->size[0] > e_cpu_b->size[0]) {
        b_x = e_cpu_a->size[0] - e_cpu_b->size[0];
        k = e_cpu_b->size[0];
        bcoef = e_cpu_b->size[0];
        e_cpu_b->size[0] = e_cpu_a->size[0];
        emxEnsureCapacity_real32_T(e_cpu_b, bcoef, &f_emlrtRTEI);
        if (!e_b_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(e_cpu_b, &e_gpu_b);
        }
        if (b_x - 1 >= 0) {
          if (d_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_b, &e_gpu_b);
          }
          std::memset(&e_cpu_b->data[k], 0,
                      static_cast<uint32_T>(b_x) * sizeof(real32_T));
          e_b_dirtyOnCpu = true;
          d_b_dirtyOnGpu = false;
        }
      }
      zfSize_idx_0 = e_cpu_b->size[0] - 1;
      if (div_s32(i26 - i23, i25) + 1 == 0) {
        k = c_cpu_zfIIR->size[0];
        c_cpu_zfIIR->size[0] = e_cpu_b->size[0] - 1;
        emxEnsureCapacity_real32_T(c_cpu_zfIIR, k, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_cpu_zfIIR, &gpu_zfIIR);
      } else {
        window_idx_0 = static_cast<uint32_T>(e_cpu_b->size[0]);
        b_OH = (static_cast<real_T>(div_s32(i26 - i23, i25) + 1) +
                static_cast<real_T>(e_cpu_b->size[0])) -
               1.0;
        x = std::fmin(32.0, b_OH);
        if (b_OH < 2.147483648E+9) {
          if (b_OH >= -2.147483648E+9) {
            b_x = static_cast<int32_T>(b_OH);
          } else {
            b_x = MIN_int32_T;
          }
        } else {
          b_x = MAX_int32_T;
        }
        KH = e_cpu_b->size[0];
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(e_cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(e_cpu_b->size[0]) - 1.0) / 2.0));
        if ((b_x < 0) && (e_cpu_b->size[0] < MIN_int32_T - b_x)) {
          bcoef = MIN_int32_T;
        } else if ((b_x > 0) && (e_cpu_b->size[0] > MAX_int32_T - b_x)) {
          bcoef = MAX_int32_T;
        } else {
          bcoef = b_x + e_cpu_b->size[0];
        }
        if (bcoef >= -2147483647) {
          bcoef--;
        }
        k = d_cpu_expanded->size[0];
        d_cpu_expanded->size[0] = bcoef;
        emxEnsureCapacity_real32_T(d_cpu_expanded, k, &g_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(d_cpu_expanded, &b_gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>((b_x + static_cast<int32_T>(window_idx_0)) -
                                1L),
            &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel46<<<grid, block>>>(b_x, window_idx_0,
                                                 b_gpu_expanded);
        }
        n = div_s32(i26 - i23, i25);
        k = h_cpu_y->size[0] * h_cpu_y->size[1];
        h_cpu_y->size[0] = 1;
        h_cpu_y->size[1] = div_s32(i26 - i23, i25) + 1;
        emxEnsureCapacity_int32_T(h_cpu_y, k, &h_emlrtRTEI);
        if (!e_y_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(h_cpu_y, &e_gpu_y);
        }
        h_cpu_y->data[0] = 1;
        e_y_dirtyOnCpu = true;
        bcoef = 1;
        for (k = 0; k < n; k++) {
          bcoef++;
          h_cpu_y->data[k + 1] = bcoef;
        }
        k = cpu_iv3->size[0];
        cpu_iv3->size[0] = h_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv3, k, &g_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv3, &gpu_iv3);
        bcoef = h_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&e_gpu_y, h_cpu_y);
          e_y_dirtyOnCpu = false;
          ec_filtfilt1_kernel47<<<grid, block>>>(offsetH, e_gpu_y, bcoef,
                                                 gpu_iv3);
        }
        k = div_s32(i26 - i23, i25);
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(k + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel48<<<grid, block>>>(gpu_yc3, i25, i23, gpu_iv3, k,
                                                 b_gpu_expanded);
        }
        k = d_cpu_rows->size[0] * d_cpu_rows->size[1];
        d_cpu_rows->size[0] = 1;
        d_cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(d_cpu_rows, k, &h_emlrtRTEI);
        if (!d_rows_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(d_cpu_rows, &b_gpu_rows);
        }
        d_cpu_rows->data[0] = 0;
        d_rows_dirtyOnCpu = true;
        bcoef = 0;
        for (k = 0; k <= KH - 2; k++) {
          bcoef++;
          d_cpu_rows->data[k + 1] = bcoef;
        }
        k = d_cpu_convOut->size[0];
        d_cpu_convOut->size[0] = b_x;
        emxEnsureCapacity_real32_T(d_cpu_convOut, k, &g_emlrtRTEI);
        if (!d_convOut_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(d_cpu_convOut, &b_gpu_convOut);
        }
        r = dim3(static_cast<uint32_T>(std::floor((b_OH + (x - 1.0)) / x)), 1U,
                 1U);
        if (x >= -2.147483648E+9) {
          k = static_cast<int32_T>(x);
        } else {
          k = MIN_int32_T;
        }
        r1 = dim3(static_cast<uint32_T>(k), 1U, 1U);
        validLaunchParams = mwApplyLaunchParameters(
            static_cast<real_T>(b_x), r, r1, &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_rows, d_cpu_rows);
          d_rows_dirtyOnCpu = false;
          if (e_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_b, e_cpu_b);
          }
          e_b_dirtyOnCpu = false;
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_convOut, d_cpu_convOut);
          }
          ec_filtfilt1_kernel49<<<grid, block>>>(b_gpu_expanded, b_gpu_rows,
                                                 e_gpu_b, b_x, b_gpu_convOut,
                                                 e_cpu_b->size[0U]);
          d_convOut_dirtyOnGpu = true;
          d_convOut_dirtyOnCpu = false;
        }
        if (g_cpu_y->size[0] != 0) {
          if (g_cpu_y->size[0] == 1) {
            if (d_convOut_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_convOut, d_cpu_convOut);
            }
            ec_filtfilt1_kernel51<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                b_gpu_y, b_gpu_convOut);
            d_convOut_dirtyOnGpu = true;
            d_convOut_dirtyOnCpu = false;
          } else {
            b_x = g_cpu_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(
                static_cast<real_T>(b_x), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (d_convOut_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_convOut, d_cpu_convOut);
              }
              ec_filtfilt1_kernel50<<<grid, block>>>(b_gpu_y, b_x,
                                                     b_gpu_convOut);
              d_convOut_dirtyOnGpu = true;
              d_convOut_dirtyOnCpu = false;
            }
          }
        }
        b_x = div_s32(i26 - i23, i25) + e_cpu_a->size[0];
        for (KH = 0; KH < b_x; KH++) {
          bcoef = static_cast<int32_T>(
              std::fmin(static_cast<real_T>(KH) + 1.0,
                        static_cast<real_T>(e_cpu_a->size[0])));
          for (offsetH = 0; offsetH <= bcoef - 2; offsetH++) {
            if (d_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_convOut, &b_gpu_convOut);
            }
            if (d_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_a, &e_gpu_a);
            }
            d_a_dirtyOnGpu = false;
            d_cpu_convOut->data[KH] -= d_cpu_convOut->data[(KH - offsetH) - 1] *
                                       e_cpu_a->data[offsetH + 1];
            d_convOut_dirtyOnCpu = true;
            d_convOut_dirtyOnGpu = false;
          }
        }
        if (static_cast<real_T>(div_s32(i26 - i23, i25) + 1) + 1.0 >
            d_cpu_convOut->size[0]) {
          b_x = 0;
          bcoef = 0;
        } else {
          b_x = div_s32(i26 - i23, i25) + 1;
          bcoef = d_cpu_convOut->size[0];
        }
        k = c_cpu_zfIIR->size[0];
        c_cpu_zfIIR->size[0] = bcoef - b_x;
        emxEnsureCapacity_real32_T(c_cpu_zfIIR, k, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_cpu_zfIIR, &gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(bcoef - b_x), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_convOut, d_cpu_convOut);
          }
          d_convOut_dirtyOnCpu = false;
          ec_filtfilt1_kernel52<<<grid, block>>>(b_gpu_convOut, b_x, bcoef,
                                                 gpu_zfIIR);
          c_zfIIR_dirtyOnGpu = true;
        }
        b_x = e_cpu_a->size[0];
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(b_x - 2L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_convOut, d_cpu_convOut);
          }
          d_convOut_dirtyOnCpu = false;
          ec_filtfilt1_kernel53<<<grid, block>>>(b_gpu_convOut, i25, i23, i26,
                                                 e_gpu_a, b_x, gpu_zfIIR,
                                                 e_cpu_a->size[0U]);
          c_zfIIR_dirtyOnGpu = true;
        }
        k = c_cpu_zfIIR->size[0];
        c_cpu_zfIIR->size[0] = zfSize_idx_0;
        emxEnsureCapacity_real32_T(c_cpu_zfIIR, k, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_cpu_zfIIR, &gpu_zfIIR);
      }
      //  outer product
      // 'ec_filtfilt1:146' yc5 = filter(b(:,ii),a(:,ii),yc2(end:-1:1,:),zo,1);
      if (d_cpu_y->size[0] < 1) {
        i23 = 1;
        i25 = 1;
        i26 = 0;
      } else {
        i23 = d_cpu_y->size[0];
        i25 = -1;
        i26 = 1;
      }
      k = f_cpu_b->size[0];
      f_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real32_T(f_cpu_b, k, &e_emlrtRTEI);
      if (!f_b_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(f_cpu_b, &f_gpu_b);
      }
      bcoef = cpu_b->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (b_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
        }
        b_dirtyOnCpu = false;
        if (f_b_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&f_gpu_b, f_cpu_b);
        }
        ec_filtfilt1_kernel54<<<grid, block>>>(gpu_b, bcoef, f_gpu_b);
        e_b_dirtyOnGpu = true;
        f_b_dirtyOnCpu = false;
      }
      k = f_cpu_a->size[0];
      f_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real32_T(f_cpu_a, k, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(f_cpu_a, &f_gpu_a);
      bcoef = cpu_a->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(
          static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (a_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
        }
        a_dirtyOnCpu = false;
        ec_filtfilt1_kernel55<<<grid, block>>>(gpu_a, bcoef, f_gpu_a);
        e_a_dirtyOnGpu = true;
      }
      if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
          (!(cpu_a->data[0] == 0.0F)) && (cpu_a->data[0] != 1.0F)) {
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(e_nb), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (f_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&f_gpu_b, f_cpu_b);
          }
          ec_filtfilt1_kernel56<<<grid, block>>>(gpu_a1, e_nb, f_gpu_b);
          e_b_dirtyOnGpu = true;
          f_b_dirtyOnCpu = false;
        }
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(e_na - 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel57<<<grid, block>>>(gpu_a1, e_na, f_gpu_a);
        }
        ec_filtfilt1_kernel58<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(f_gpu_a);
        e_a_dirtyOnGpu = true;
      }
      if (f_cpu_a->size[0] > f_cpu_b->size[0]) {
        b_x = f_cpu_a->size[0] - f_cpu_b->size[0];
        k = f_cpu_b->size[0];
        bcoef = f_cpu_b->size[0];
        f_cpu_b->size[0] = f_cpu_a->size[0];
        emxEnsureCapacity_real32_T(f_cpu_b, bcoef, &f_emlrtRTEI);
        if (!f_b_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(f_cpu_b, &f_gpu_b);
        }
        if (b_x - 1 >= 0) {
          if (e_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(f_cpu_b, &f_gpu_b);
          }
          std::memset(&f_cpu_b->data[k], 0,
                      static_cast<uint32_T>(b_x) * sizeof(real32_T));
          f_b_dirtyOnCpu = true;
          e_b_dirtyOnGpu = false;
        }
      }
      if (div_s32(i26 - i23, i25) + 1 == 0) {
        cpu_yc5->size[0] = 0;
      } else {
        window_idx_0 = static_cast<uint32_T>(f_cpu_b->size[0]);
        b_OH = (static_cast<real_T>(div_s32(i26 - i23, i25) + 1) +
                static_cast<real_T>(f_cpu_b->size[0])) -
               1.0;
        x = std::fmin(32.0, b_OH);
        if (b_OH < 2.147483648E+9) {
          if (b_OH >= -2.147483648E+9) {
            b_x = static_cast<int32_T>(b_OH);
          } else {
            b_x = MIN_int32_T;
          }
        } else {
          b_x = MAX_int32_T;
        }
        KH = f_cpu_b->size[0];
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(f_cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(f_cpu_b->size[0]) - 1.0) / 2.0));
        if ((b_x < 0) && (f_cpu_b->size[0] < MIN_int32_T - b_x)) {
          bcoef = MIN_int32_T;
        } else if ((b_x > 0) && (f_cpu_b->size[0] > MAX_int32_T - b_x)) {
          bcoef = MAX_int32_T;
        } else {
          bcoef = b_x + f_cpu_b->size[0];
        }
        if (bcoef >= -2147483647) {
          bcoef--;
        }
        k = e_cpu_expanded->size[0];
        e_cpu_expanded->size[0] = bcoef;
        emxEnsureCapacity_real32_T(e_cpu_expanded, k, &g_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(e_cpu_expanded, &gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>((b_x + static_cast<int32_T>(window_idx_0)) -
                                1L),
            &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel59<<<grid, block>>>(b_x, window_idx_0,
                                                 gpu_expanded);
        }
        n = div_s32(i26 - i23, i25);
        k = i_cpu_y->size[0] * i_cpu_y->size[1];
        i_cpu_y->size[0] = 1;
        i_cpu_y->size[1] = div_s32(i26 - i23, i25) + 1;
        emxEnsureCapacity_int32_T(i_cpu_y, k, &h_emlrtRTEI);
        if (!f_y_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(i_cpu_y, &c_gpu_y);
        }
        i_cpu_y->data[0] = 1;
        f_y_dirtyOnCpu = true;
        bcoef = 1;
        for (k = 0; k < n; k++) {
          bcoef++;
          i_cpu_y->data[k + 1] = bcoef;
        }
        k = cpu_iv4->size[0];
        cpu_iv4->size[0] = i_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv4, k, &g_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv4, &gpu_iv4);
        bcoef = i_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(bcoef + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_y, i_cpu_y);
          f_y_dirtyOnCpu = false;
          ec_filtfilt1_kernel60<<<grid, block>>>(offsetH, c_gpu_y, bcoef,
                                                 gpu_iv4);
        }
        k = div_s32(i26 - i23, i25);
        validLaunchParams = mwGetLaunchParameters1D(
            static_cast<real_T>(k + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt1_kernel61<<<grid, block>>>(d_gpu_y, i25, i23, gpu_iv4, k,
                                                 gpu_expanded);
        }
        k = e_cpu_rows->size[0] * e_cpu_rows->size[1];
        e_cpu_rows->size[0] = 1;
        e_cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(e_cpu_rows, k, &h_emlrtRTEI);
        if (!e_rows_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(e_cpu_rows, &gpu_rows);
        }
        e_cpu_rows->data[0] = 0;
        e_rows_dirtyOnCpu = true;
        bcoef = 0;
        for (k = 0; k <= KH - 2; k++) {
          bcoef++;
          e_cpu_rows->data[k + 1] = bcoef;
        }
        k = e_cpu_convOut->size[0];
        e_cpu_convOut->size[0] = b_x;
        emxEnsureCapacity_real32_T(e_cpu_convOut, k, &g_emlrtRTEI);
        if (!e_convOut_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(e_cpu_convOut, &gpu_convOut);
        }
        r = dim3(static_cast<uint32_T>(std::floor((b_OH + (x - 1.0)) / x)), 1U,
                 1U);
        if (x >= -2.147483648E+9) {
          k = static_cast<int32_T>(x);
        } else {
          k = MIN_int32_T;
        }
        r1 = dim3(static_cast<uint32_T>(k), 1U, 1U);
        validLaunchParams = mwApplyLaunchParameters(
            static_cast<real_T>(b_x), r, r1, &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, e_cpu_rows);
          e_rows_dirtyOnCpu = false;
          if (f_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&f_gpu_b, f_cpu_b);
          }
          f_b_dirtyOnCpu = false;
          if (e_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_convOut, e_cpu_convOut);
          }
          ec_filtfilt1_kernel62<<<grid, block>>>(gpu_expanded, gpu_rows,
                                                 f_gpu_b, b_x, gpu_convOut,
                                                 f_cpu_b->size[0U]);
          e_convOut_dirtyOnGpu = true;
          e_convOut_dirtyOnCpu = false;
        }
        if (c_cpu_zfIIR->size[0] != 0) {
          if (c_cpu_zfIIR->size[0] == 1) {
            if (e_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_convOut, &gpu_convOut);
            }
            if (c_zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_zfIIR, &gpu_zfIIR);
            }
            c_zfIIR_dirtyOnGpu = false;
            e_cpu_convOut->data[0] += c_cpu_zfIIR->data[0];
            e_convOut_dirtyOnCpu = true;
            e_convOut_dirtyOnGpu = false;
          } else {
            b_x = c_cpu_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(
                static_cast<real_T>(b_x), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (e_convOut_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_convOut, e_cpu_convOut);
              }
              ec_filtfilt1_kernel63<<<grid, block>>>(gpu_zfIIR, b_x,
                                                     gpu_convOut);
              e_convOut_dirtyOnGpu = true;
              e_convOut_dirtyOnCpu = false;
            }
          }
        }
        b_x = div_s32(i26 - i23, i25) + f_cpu_a->size[0];
        for (KH = 0; KH < b_x; KH++) {
          n = static_cast<int32_T>(
              std::fmin(static_cast<real_T>(KH) + 1.0,
                        static_cast<real_T>(f_cpu_a->size[0])));
          for (offsetH = 0; offsetH <= n - 2; offsetH++) {
            if (e_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_convOut, &gpu_convOut);
            }
            if (e_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(f_cpu_a, &f_gpu_a);
            }
            e_a_dirtyOnGpu = false;
            e_cpu_convOut->data[KH] -= e_cpu_convOut->data[(KH - offsetH) - 1] *
                                       f_cpu_a->data[offsetH + 1];
            e_convOut_dirtyOnCpu = true;
            e_convOut_dirtyOnGpu = false;
          }
        }
        k = cpu_yc5->size[0];
        cpu_yc5->size[0] = div_s32(i26 - i23, i25) + 1;
        emxEnsureCapacity_real32_T(cpu_yc5, k, &j_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_yc5, &gpu_yc5);
        validLaunchParams =
            mwGetLaunchParameters1D(static_cast<real_T>((i26 - i23) / i25 + 1L),
                                    &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (e_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_convOut, e_cpu_convOut);
          }
          e_convOut_dirtyOnCpu = false;
          ec_filtfilt1_kernel64<<<grid, block>>>(gpu_convOut, i26, i23, i25,
                                                 gpu_yc5);
        }
      }
      // 'ec_filtfilt1:148' x = yc5(end:-1:1,:);
      if (cpu_yc5->size[0] < 1) {
        b_x = 0;
        bcoef = 1;
        n = -1;
      } else {
        b_x = cpu_yc5->size[0] - 1;
        bcoef = -1;
        n = 0;
      }
      k = cpu_fv->size[0];
      cpu_fv->size[0] = div_s32(n - b_x, bcoef) + 1;
      emxEnsureCapacity_real32_T(cpu_fv, k, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv);
      validLaunchParams =
          mwGetLaunchParameters1D(static_cast<real_T>((n - b_x) / bcoef + 1L),
                                  &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt1_kernel65<<<grid, block>>>(gpu_yc5, bcoef, b_x, n, gpu_fv);
        fv_dirtyOnGpu = true;
      }
    }
    //  LocalWords:  x b a nf L
    //  LocalWords:  Lx th zi nfilt xc yc IIR nfact xt unreversed nullcopy Npts
    //  nb na yout LocalWords:  Nchans filtord designfilt noisysignals
    //  highpassiir Sanjit Mitra LocalWords:  nd Graw Fredrik Gustafsson
    bcoef = cpu_fv->size[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
                                                &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (y_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&i_gpu_y, cpu_y);
      }
      ec_filtfilt1_kernel66<<<grid, block>>>(
          gpu_fv, static_cast<int32_T>(static_cast<uint16_T>(ch + 1L)), bcoef,
          i_gpu_y, cpu_y->size[0U]);
      y_dirtyOnGpu = true;
      y_dirtyOnCpu = false;
    }
  }
  emxFree_real32_T(&e_cpu_convOut);
  emxFree_int32_T(&e_cpu_rows);
  emxFree_int32_T(&cpu_iv4);
  emxFree_real32_T(&c_cpu_zfIIR);
  emxFree_int32_T(&i_cpu_y);
  emxFree_real32_T(&e_cpu_expanded);
  emxFree_real32_T(&d_cpu_convOut);
  emxFree_real32_T(&cpu_yc5);
  emxFree_int32_T(&d_cpu_rows);
  emxFree_int32_T(&cpu_iv3);
  emxFree_real32_T(&f_cpu_a);
  emxFree_real32_T(&f_cpu_b);
  emxFree_int32_T(&h_cpu_y);
  emxFree_real32_T(&d_cpu_expanded);
  emxFree_real32_T(&c_cpu_convOut);
  emxFree_int32_T(&c_cpu_rows);
  emxFree_real32_T(&e_cpu_a);
  emxFree_real32_T(&e_cpu_b);
  emxFree_real32_T(&g_cpu_y);
  emxFree_int32_T(&f_cpu_y);
  emxFree_real32_T(&c_cpu_expanded);
  emxFree_real32_T(&b_cpu_zfIIR);
  emxFree_real32_T(&cpu_yc3);
  emxFree_real32_T(&b_cpu_convOut);
  emxFree_real32_T(&d_cpu_a);
  emxFree_real32_T(&d_cpu_b);
  emxFree_real32_T(&cpu_zfIIR);
  emxFree_int32_T(&b_cpu_rows);
  emxFree_int32_T(&e_cpu_y);
  emxFree_real32_T(&b_cpu_expanded);
  emxFree_real32_T(&cpu_convOut);
  emxFree_real32_T(&d_cpu_y);
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&c_cpu_y);
  emxFree_real32_T(&cpu_expanded);
  emxFree_real32_T(&c_cpu_a);
  emxFree_real32_T(&c_cpu_b);
  emxFree_real32_T(&b_cpu_a);
  emxFree_real32_T(&b_cpu_b);
  emxFree_real32_T(&b_cpu_y);
  emxFree_real32_T(&cpu_xt);
  emxFree_real32_T(&cpu_fv);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (y_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_y, &i_gpu_y);
  }
  gpuEmxFree_real32_T(&gpu_x);
  gpuEmxFree_real32_T(&gpu_b);
  gpuEmxFree_real32_T(&gpu_a);
  gpuEmxFree_real32_T(&gpu_z);
  gpuEmxFree_real32_T(&i_gpu_y);
  gpuEmxFree_real32_T(&gpu_fv);
  gpuEmxFree_real32_T(&gpu_xt);
  gpuEmxFree_real32_T(&gpu_y);
  gpuEmxFree_real32_T(&b_gpu_b);
  gpuEmxFree_real32_T(&b_gpu_a);
  gpuEmxFree_real32_T(&c_gpu_b);
  gpuEmxFree_real32_T(&c_gpu_a);
  gpuEmxFree_real32_T(&e_gpu_expanded);
  gpuEmxFree_int32_T(&h_gpu_y);
  gpuEmxFree_int32_T(&e_gpu_rows);
  mwCudaFree(e_gpu_a1);
  gpuEmxFree_real32_T(&d_gpu_y);
  gpuEmxFree_real32_T(&e_gpu_convOut);
  gpuEmxFree_real32_T(&d_gpu_expanded);
  mwCudaFree(d_gpu_a1);
  gpuEmxFree_int32_T(&g_gpu_y);
  gpuEmxFree_int32_T(&d_gpu_rows);
  gpuEmxFree_real32_T(&c_gpu_zfIIR);
  mwCudaFree(c_gpu_a1);
  gpuEmxFree_real32_T(&d_gpu_b);
  gpuEmxFree_real32_T(&d_gpu_a);
  gpuEmxFree_real32_T(&d_gpu_convOut);
  mwCudaFree(b_gpu_a1);
  gpuEmxFree_real32_T(&gpu_yc3);
  gpuEmxFree_real32_T(&b_gpu_zfIIR);
  gpuEmxFree_real32_T(&c_gpu_expanded);
  mwCudaFree(gpu_a1);
  gpuEmxFree_int32_T(&f_gpu_y);
  gpuEmxFree_real32_T(&b_gpu_y);
  gpuEmxFree_real32_T(&e_gpu_b);
  gpuEmxFree_real32_T(&e_gpu_a);
  gpuEmxFree_int32_T(&c_gpu_rows);
  gpuEmxFree_real32_T(&c_gpu_convOut);
  gpuEmxFree_real32_T(&b_gpu_expanded);
  gpuEmxFree_int32_T(&e_gpu_y);
  gpuEmxFree_real32_T(&f_gpu_b);
  gpuEmxFree_real32_T(&f_gpu_a);
  gpuEmxFree_int32_T(&gpu_iv3);
  gpuEmxFree_int32_T(&b_gpu_rows);
  gpuEmxFree_real32_T(&gpu_yc5);
  gpuEmxFree_real32_T(&b_gpu_convOut);
  gpuEmxFree_real32_T(&gpu_expanded);
  gpuEmxFree_int32_T(&c_gpu_y);
  gpuEmxFree_real32_T(&gpu_zfIIR);
  gpuEmxFree_int32_T(&gpu_iv4);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_real32_T(&gpu_convOut);
}

void ec_filtfilt1_api(const mxArray *const prhs[6], const mxArray *plhs[1])
{
  emxArray_real32_T *a;
  emxArray_real32_T *b;
  emxArray_real32_T *x;
  emxArray_real32_T *y;
  emxArray_real32_T *z;
  real32_T L;
  real32_T nf;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  // Marshall function inputs
  emxInit_real32_T(&x, 2, &p_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  emxInit_real32_T(&b, 1, &p_emlrtRTEI, true);
  b->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[1]), "b", b);
  emxInit_real32_T(&a, 1, &p_emlrtRTEI, true);
  a->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[2]), "a", a);
  emxInit_real32_T(&z, 1, &p_emlrtRTEI, true);
  z->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[3]), "z", z);
  nf = emlrt_marshallIn(emlrtAliasP(prhs[4]), "nf");
  L = emlrt_marshallIn(emlrtAliasP(prhs[5]), "L");
  // Invoke the target function
  emxInit_real32_T(&y, 2, &p_emlrtRTEI, true);
  ec_filtfilt1(x, b, a, z, nf, L, y);
  emxFree_real32_T(&z);
  emxFree_real32_T(&a);
  emxFree_real32_T(&b);
  emxFree_real32_T(&x);
  // Marshall function outputs
  y->canFreeData = false;
  plhs[0] = emlrt_marshallOut(y);
  emxFree_real32_T(&y);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ec_filtfilt1_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void ec_filtfilt1_initialize()
{
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
                          "EMLRT:runTime:MexFunctionNeedsLicense",
                          "distrib_computing_toolbox", 2);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    ec_filtfilt1_once();
  }
  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ec_filtfilt1_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode),
                       (char_T *)cudaGetErrorName(errCode),
                       (char_T *)cudaGetErrorString(errCode),
                       (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  mwMemoryManagerTerminate();
}

// End of code generation (ec_filtfilt1.cu)
