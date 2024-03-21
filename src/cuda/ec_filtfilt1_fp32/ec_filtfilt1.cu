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
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
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
    131643U,                                            // fVersionInfo
    nullptr,                                            // fErrorFunction
    "ec_filtfilt1",                                     // fFunctionName
    nullptr,                                            // fRTCallStack
    false,                                              // bDebugMode
    {3130694236U, 2616137409U, 972914731U, 129233577U}, // fSigWrd
    nullptr                                             // fSigMem
};

static emlrtRTEInfo emlrtRTEI{
    100,                                                        // lineNo
    1,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    104,                                                        // lineNo
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

static emlrtRTEInfo
    d_emlrtRTEI{
        76,                  // lineNo
        9,                   // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

static emlrtRTEInfo e_emlrtRTEI{
    104,                                                        // lineNo
    15,                                                         // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    1,               // lineNo
    1,               // colNo
    "gpufilterImpl", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/"
    "gpufilterImpl.p" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "stencil_codegen", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "stencil_codegen.p" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    172,                                                          // lineNo
    20,                                                           // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    137,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    140,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    104,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    133,                                                        // lineNo
    5,                                                          // colNo
    "ec_filtfilt1",                                             // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_filtfilt1.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    134,                                                        // lineNo
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
    139,                                                        // lineNo
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
static void b_emlrt_marshallIn(const mxArray *b_nullptr,
                               const char_T *identifier, emxArray_real32_T *y);

static void b_emlrt_marshallIn(const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real32_T *y);

static real32_T b_emlrt_marshallIn(const mxArray *src,
                                   const emlrtMsgIdentifier *msgId);

static void c_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_real32_T *ret);

static void checkCudaError(cudaError_t errCode, const char_T *file,
                           uint32_T b_line);

static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);

static uint64_T computeNumIters(int32_T ub);

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

static __global__ void
ec_filtfilt1_kernel10(const real32_T *a1, const int32_T b, emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel11(emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel12(const emxArray_real32_T b,
                                             const int32_T b_b,
                                             emxArray_real32_T c_b);

static __global__ void ec_filtfilt1_kernel13(const emxArray_real32_T a,
                                             const int32_T b_a,
                                             emxArray_real32_T c_a);

static __global__ void ec_filtfilt1_kernel14(const real32_T *a1,
                                             const int32_T b,
                                             emxArray_real32_T b_b);

static __global__ void
ec_filtfilt1_kernel15(const real32_T *a1, const int32_T b, emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel16(emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel17(const emxArray_real32_T fv,
                                             real32_T *a, int32_T fv_dim0);

static __global__ void
ec_filtfilt1_kernel18(const emxArray_real32_T fv, const int32_T bcoef,
                      const int32_T KH, const int32_T offsetH,
                      const real32_T *a, const int32_T x, emxArray_real32_T xt);

static __global__ void ec_filtfilt1_kernel19(const emxArray_real32_T b,
                                             const int32_T b_b,
                                             emxArray_real32_T c_b);

static __global__ void
ec_filtfilt1_kernel2(const int32_T x, const emxArray_real32_T b_x,
                     const int32_T c_x, emxArray_real32_T fv, int32_T x_dim0);

static __global__ void ec_filtfilt1_kernel20(const emxArray_real32_T a,
                                             const int32_T b_a,
                                             emxArray_real32_T c_a);

static __global__ void ec_filtfilt1_kernel21(const real32_T *a1,
                                             const int32_T b,
                                             emxArray_real32_T b_b);

static __global__ void
ec_filtfilt1_kernel22(const real32_T *a1, const int32_T b, emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel23(emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel24(const emxArray_real32_T yc3,
                                             real32_T *a, int32_T yc3_dim0);

static __global__ void ec_filtfilt1_kernel25(const real32_T *a,
                                             const emxArray_real32_T z,
                                             const int32_T b_z,
                                             emxArray_real32_T y);

static __global__ void ec_filtfilt1_kernel26(const emxArray_real32_T b,
                                             const int32_T b_b,
                                             emxArray_real32_T c_b);

static __global__ void ec_filtfilt1_kernel27(const emxArray_real32_T a,
                                             const int32_T b_a,
                                             emxArray_real32_T c_a);

static __global__ void ec_filtfilt1_kernel28(const real32_T *a1,
                                             const int32_T b,
                                             emxArray_real32_T b_b);

static __global__ void
ec_filtfilt1_kernel29(const real32_T *a1, const int32_T b, emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel3(const emxArray_real32_T fv,
                                            real32_T *a);

static __global__ void ec_filtfilt1_kernel30(emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel31(const emxArray_real32_T b,
                                             const int32_T b_b,
                                             emxArray_real32_T c_b);

static __global__ void ec_filtfilt1_kernel32(const emxArray_real32_T a,
                                             const int32_T b_a,
                                             emxArray_real32_T c_a);

static __global__ void ec_filtfilt1_kernel33(const real32_T *a1,
                                             const int32_T b,
                                             emxArray_real32_T b_b);

static __global__ void
ec_filtfilt1_kernel34(const real32_T *a1, const int32_T b, emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel35(emxArray_real32_T a);

static __global__ void ec_filtfilt1_kernel36(const emxArray_real32_T yc5,
                                             const int32_T bcoef,
                                             const int32_T x, const int32_T b,
                                             emxArray_real32_T fv);

static __global__ void ec_filtfilt1_kernel37(const int32_T b,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel38(const int32_T offsetH,
                                             const emxArray_int32_T y,
                                             const int32_T b_y,
                                             emxArray_int32_T iv4);

static __global__ void
ec_filtfilt1_kernel39(const emxArray_real32_T y, const int32_T i24,
                      const int32_T i22, const emxArray_int32_T iv4,
                      const int32_T b, emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel4(const emxArray_real32_T fv,
                                            const int32_T bcoef,
                                            const int32_T i2, const int32_T i1,
                                            const real32_T *a, const int32_T x,
                                            emxArray_real32_T xt);

static __global__ void ec_filtfilt1_kernel40(const emxArray_real32_T expanded,
                                             const emxArray_int32_T rows,
                                             const emxArray_real32_T b,
                                             const int32_T c,
                                             emxArray_real32_T convOut,
                                             int32_T b_dim0);

static __global__ void ec_filtfilt1_kernel41(const emxArray_real32_T zfIIR,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel42(const emxArray_real32_T convOut,
                                             const int32_T b,
                                             emxArray_real32_T yc5);

static __global__ void ec_filtfilt1_kernel43(const emxArray_real32_T zfIIR,
                                             const int32_T b,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel44(const int32_T b,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel45(const int32_T offsetH,
                                             const emxArray_int32_T y,
                                             const int32_T b_y,
                                             emxArray_int32_T iv3);

static __global__ void
ec_filtfilt1_kernel46(const emxArray_real32_T yc3, const int32_T i24,
                      const int32_T i22, const emxArray_int32_T iv3,
                      const int32_T b, emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel47(const emxArray_real32_T expanded,
                                             const emxArray_int32_T rows,
                                             const emxArray_real32_T b,
                                             const int32_T c,
                                             emxArray_real32_T convOut,
                                             int32_T b_dim0);

static __global__ void ec_filtfilt1_kernel48(const emxArray_real32_T y,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel49(const emxArray_real32_T convOut,
                                             const int32_T x, const int32_T b,
                                             emxArray_real32_T zfIIR);

static __global__ void ec_filtfilt1_kernel5(const emxArray_real32_T xt,
                                            real32_T *a);

static __global__ void
ec_filtfilt1_kernel50(const emxArray_real32_T convOut, const int32_T i24,
                      const int32_T i22, const int32_T i25,
                      const emxArray_real32_T a, const int32_T b,
                      emxArray_real32_T zfIIR, int32_T a_dim0);

static __global__ void ec_filtfilt1_kernel51(const emxArray_real32_T y,
                                             const int32_T b,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel52(const int32_T b,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel53(const int32_T offsetH,
                                             const emxArray_int32_T y,
                                             const int32_T b_y,
                                             emxArray_int32_T iv2);

static __global__ void ec_filtfilt1_kernel54(const emxArray_real32_T xt,
                                             const emxArray_int32_T iv2,
                                             const int32_T b,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel55(const emxArray_real32_T expanded,
                                             const emxArray_int32_T rows,
                                             const emxArray_real32_T b,
                                             const int32_T c,
                                             emxArray_real32_T convOut,
                                             int32_T b_dim0);

static __global__ void ec_filtfilt1_kernel56(const emxArray_real32_T zfIIR,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel57(const emxArray_real32_T convOut,
                                             const int32_T xt,
                                             emxArray_real32_T yc3);

static __global__ void ec_filtfilt1_kernel58(const emxArray_real32_T zfIIR,
                                             const int32_T b,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel59(const int32_T b,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel6(const real32_T *a,
                                            const emxArray_real32_T z,
                                            const int32_T b_z,
                                            emxArray_real32_T y);

static __global__ void ec_filtfilt1_kernel60(const int32_T offsetH,
                                             const emxArray_int32_T y,
                                             const int32_T b_y,
                                             emxArray_int32_T iv1);

static __global__ void ec_filtfilt1_kernel61(const emxArray_real32_T fv,
                                             const emxArray_int32_T iv1,
                                             const int32_T b,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel62(const emxArray_real32_T expanded,
                                             const emxArray_int32_T rows,
                                             const emxArray_real32_T b,
                                             const int32_T c,
                                             emxArray_real32_T convOut,
                                             int32_T b_dim0);

static __global__ void ec_filtfilt1_kernel63(const emxArray_real32_T zfIIR,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel64(const emxArray_real32_T convOut,
                                             const int32_T x, const int32_T b,
                                             emxArray_real32_T zfIIR);

static __global__ void ec_filtfilt1_kernel65(const emxArray_real32_T convOut,
                                             const emxArray_real32_T a,
                                             const int32_T b,
                                             emxArray_real32_T zfIIR,
                                             int32_T a_dim0, int32_T fv_dim0);

static __global__ void ec_filtfilt1_kernel66(const emxArray_real32_T convOut,
                                             const int32_T fv,
                                             emxArray_real32_T y);

static __global__ void ec_filtfilt1_kernel67(const emxArray_real32_T zfIIR,
                                             const int32_T b,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel68(const int32_T b,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel69(const int32_T offsetH,
                                             const emxArray_int32_T y,
                                             const int32_T b_y,
                                             emxArray_int32_T iv);

static __global__ void ec_filtfilt1_kernel7(const emxArray_real32_T b,
                                            const int32_T b_b,
                                            emxArray_real32_T c_b);

static __global__ void ec_filtfilt1_kernel70(const emxArray_real32_T xt,
                                             const emxArray_int32_T iv,
                                             const int32_T b,
                                             emxArray_real32_T expanded);

static __global__ void ec_filtfilt1_kernel71(const emxArray_real32_T expanded,
                                             const emxArray_int32_T rows,
                                             const emxArray_real32_T b,
                                             const int32_T c,
                                             emxArray_real32_T convOut,
                                             int32_T b_dim0);

static __global__ void ec_filtfilt1_kernel72(const emxArray_real32_T y,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel73(const emxArray_real32_T convOut,
                                             const int32_T x, const int32_T b,
                                             emxArray_real32_T zfIIR);

static __global__ void ec_filtfilt1_kernel74(const emxArray_real32_T convOut,
                                             const emxArray_real32_T a,
                                             const int32_T b,
                                             emxArray_real32_T zfIIR,
                                             int32_T a_dim0, int32_T xt_dim0);

static __global__ void ec_filtfilt1_kernel75(const emxArray_real32_T y,
                                             const int32_T b,
                                             emxArray_real32_T convOut);

static __global__ void ec_filtfilt1_kernel76(const emxArray_real32_T fv,
                                             const int32_T x, const int32_T b,
                                             emxArray_real32_T y,
                                             int32_T y_dim0);

static __global__ void ec_filtfilt1_kernel8(const emxArray_real32_T a,
                                            const int32_T b_a,
                                            emxArray_real32_T c_a);

static __global__ void ec_filtfilt1_kernel9(const real32_T *a1, const int32_T b,
                                            emxArray_real32_T b_b);

static void emlrtExitTimeCleanupDtorFcn(const void *r);

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_real32_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y);

static real32_T emlrt_marshallIn(const mxArray *b_nullptr,
                                 const char_T *identifier);

static real32_T emlrt_marshallIn(const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

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
                                         emxArray_int32_T *gpu,
                                         boolean_T needsCopy);

static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu,
                                          boolean_T needsCopy);

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

static void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                           const char_T *errorName, const char_T *errorString);

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

static void b_emlrt_marshallIn(const mxArray *b_nullptr,
                               const char_T *identifier, emxArray_real32_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId, y);
  emlrtDestroyArray(&b_nullptr);
}

static void b_emlrt_marshallIn(const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               emxArray_real32_T *y)
{
  d_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
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

static void checkCudaError(cudaError_t errCode, const char_T *file,
                           uint32_T b_line)
{
  if (errCode != cudaSuccess) {
    raiseCudaError(errCode, file, b_line, cudaGetErrorName(errCode),
                   cudaGetErrorString(errCode));
  }
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

static uint64_T computeNumIters(int32_T ub)
{
  uint64_T numIters;
  numIters = 0UL;
  if (ub >= 0) {
    numIters = static_cast<uint64_T>(ub + 1);
  }
  return numIters;
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
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *e_a1 = a.data[0];
    *d_a1 = a.data[0];
    *c_a1 = a.data[0];
    *b_a1 = a.data[0];
    *a1 = a.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel10(
    const real32_T *a1, const int32_T b, emxArray_real32_T a)
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

static __global__
    __launch_bounds__(32, 1) void ec_filtfilt1_kernel11(emxArray_real32_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel12(
    const emxArray_real32_T b, const int32_T b_b, emxArray_real32_T c_b)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel13(
    const emxArray_real32_T a, const int32_T b_a, emxArray_real32_T c_a)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel14(
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel15(
    const real32_T *a1, const int32_T b, emxArray_real32_T a)
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

static __global__
    __launch_bounds__(32, 1) void ec_filtfilt1_kernel16(emxArray_real32_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel17(
    const emxArray_real32_T fv, real32_T *a, int32_T fv_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *a = 2.0F * fv.data[fv_dim0 - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel18(
    const emxArray_real32_T fv, const int32_T bcoef, const int32_T KH,
    const int32_T offsetH, const real32_T *a, const int32_T x,
    emxArray_real32_T xt)
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
    xt.data[k] = *a - fv.data[(offsetH + KH * (bcoef * k)) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel19(
    const emxArray_real32_T b, const int32_T b_b, emxArray_real32_T c_b)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel2(
    const int32_T x, const emxArray_real32_T b_x, const int32_T c_x,
    emxArray_real32_T fv, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv.data[k] = b_x.data[k + x_dim0 * (x - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel20(
    const emxArray_real32_T a, const int32_T b_a, emxArray_real32_T c_a)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel21(
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel22(
    const real32_T *a1, const int32_T b, emxArray_real32_T a)
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

static __global__
    __launch_bounds__(32, 1) void ec_filtfilt1_kernel23(emxArray_real32_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel24(
    const emxArray_real32_T yc3, real32_T *a, int32_T yc3_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *a = yc3.data[yc3_dim0 - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel25(
    const real32_T *a, const emxArray_real32_T z, const int32_T b_z,
    emxArray_real32_T y)
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
    y.data[k] = z.data[k] * *a;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel26(
    const emxArray_real32_T b, const int32_T b_b, emxArray_real32_T c_b)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel27(
    const emxArray_real32_T a, const int32_T b_a, emxArray_real32_T c_a)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel28(
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel29(
    const real32_T *a1, const int32_T b, emxArray_real32_T a)
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel3(
    const emxArray_real32_T fv, real32_T *a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    // 'ec_filtfilt1:133' xt = bsxfun(@minus, 2*x(1,:),x(nf(1,1)+1:-1:2,:));
    *a = 2.0F * fv.data[0];
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_filtfilt1_kernel30(emxArray_real32_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel31(
    const emxArray_real32_T b, const int32_T b_b, emxArray_real32_T c_b)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel32(
    const emxArray_real32_T a, const int32_T b_a, emxArray_real32_T c_a)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel33(
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel34(
    const real32_T *a1, const int32_T b, emxArray_real32_T a)
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

static __global__
    __launch_bounds__(32, 1) void ec_filtfilt1_kernel35(emxArray_real32_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel36(
    const emxArray_real32_T yc5, const int32_T bcoef, const int32_T x,
    const int32_T b, emxArray_real32_T fv)
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
    fv.data[k] = yc5.data[x + bcoef * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel37(
    const int32_T b, emxArray_real32_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel38(
    const int32_T offsetH, const emxArray_int32_T y, const int32_T b_y,
    emxArray_int32_T iv4)
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
    iv4.data[k] = j - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel39(
    const emxArray_real32_T y, const int32_T i24, const int32_T i22,
    const emxArray_int32_T iv4, const int32_T b, emxArray_real32_T expanded)
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
    expanded.data[iv4.data[k]] = y.data[(i22 + i24 * k) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel4(
    const emxArray_real32_T fv, const int32_T bcoef, const int32_T i2,
    const int32_T i1, const real32_T *a, const int32_T x, emxArray_real32_T xt)
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
    xt.data[k] = *a - fv.data[(i1 + i2 * (bcoef * k)) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel40(
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel41(
    const emxArray_real32_T zfIIR, emxArray_real32_T convOut)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    convOut.data[0] += zfIIR.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel42(
    const emxArray_real32_T convOut, const int32_T b, emxArray_real32_T yc5)
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
    yc5.data[k] = convOut.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel43(
    const emxArray_real32_T zfIIR, const int32_T b, emxArray_real32_T convOut)
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
    convOut.data[orow] += zfIIR.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel44(
    const int32_T b, emxArray_real32_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel45(
    const int32_T offsetH, const emxArray_int32_T y, const int32_T b_y,
    emxArray_int32_T iv3)
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
    iv3.data[k] = j - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel46(
    const emxArray_real32_T yc3, const int32_T i24, const int32_T i22,
    const emxArray_int32_T iv3, const int32_T b, emxArray_real32_T expanded)
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
    expanded.data[iv3.data[k]] = yc3.data[(i22 + i24 * k) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel47(
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel48(
    const emxArray_real32_T y, emxArray_real32_T convOut)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    convOut.data[0] += y.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel49(
    const emxArray_real32_T convOut, const int32_T x, const int32_T b,
    emxArray_real32_T zfIIR)
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
    zfIIR.data[k] = convOut.data[x + k];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel5(
    const emxArray_real32_T xt, real32_T *a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    // 'ec_filtfilt1:134' [~,zo] = filter(b(:,ii),a(:,ii),xt,z(:,ii)*xt(1,:),1);
    *a = xt.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel50(
    const emxArray_real32_T convOut, const int32_T i24, const int32_T i22,
    const int32_T i25, const emxArray_real32_T a, const int32_T b,
    emxArray_real32_T zfIIR, int32_T a_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    k = static_cast<int32_T>(
        fmin(static_cast<real_T>(orow) + 2.0, static_cast<real_T>(a_dim0)));
    for (int32_T j{0}; j <= k - 2; j++) {
      zfIIR.data[orow + 1] +=
          convOut.data[((div_s32_device(i25 - i22, i24) + orow) - j) + 1] *
          a.data[j + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel51(
    const emxArray_real32_T y, const int32_T b, emxArray_real32_T convOut)
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
    convOut.data[orow] += y.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel52(
    const int32_T b, emxArray_real32_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel53(
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
    iv2.data[k] = j - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel54(
    const emxArray_real32_T xt, const emxArray_int32_T iv2, const int32_T b,
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
    expanded.data[iv2.data[k]] = xt.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel55(
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel56(
    const emxArray_real32_T zfIIR, emxArray_real32_T convOut)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    convOut.data[0] += zfIIR.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel57(
    const emxArray_real32_T convOut, const int32_T xt, emxArray_real32_T yc3)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xt);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    yc3.data[k] = convOut.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel58(
    const emxArray_real32_T zfIIR, const int32_T b, emxArray_real32_T convOut)
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
    convOut.data[orow] += zfIIR.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel59(
    const int32_T b, emxArray_real32_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel6(
    const real32_T *a, const emxArray_real32_T z, const int32_T b_z,
    emxArray_real32_T y)
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
    y.data[k] = z.data[k] * *a;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel60(
    const int32_T offsetH, const emxArray_int32_T y, const int32_T b_y,
    emxArray_int32_T iv1)
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
    iv1.data[k] = j - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel61(
    const emxArray_real32_T fv, const emxArray_int32_T iv1, const int32_T b,
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
    expanded.data[iv1.data[k]] = fv.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel62(
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel63(
    const emxArray_real32_T zfIIR, emxArray_real32_T convOut)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    convOut.data[0] += zfIIR.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel64(
    const emxArray_real32_T convOut, const int32_T x, const int32_T b,
    emxArray_real32_T zfIIR)
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
    zfIIR.data[k] = convOut.data[x + k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel65(
    const emxArray_real32_T convOut, const emxArray_real32_T a, const int32_T b,
    emxArray_real32_T zfIIR, int32_T a_dim0, int32_T fv_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel66(
    const emxArray_real32_T convOut, const int32_T fv, emxArray_real32_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = convOut.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel67(
    const emxArray_real32_T zfIIR, const int32_T b, emxArray_real32_T convOut)
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
    convOut.data[orow] += zfIIR.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel68(
    const int32_T b, emxArray_real32_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel69(
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel7(
    const emxArray_real32_T b, const int32_T b_b, emxArray_real32_T c_b)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel70(
    const emxArray_real32_T xt, const emxArray_int32_T iv, const int32_T b,
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
    expanded.data[iv.data[k]] = xt.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel71(
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt1_kernel72(
    const emxArray_real32_T y, emxArray_real32_T convOut)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    convOut.data[0] += y.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel73(
    const emxArray_real32_T convOut, const int32_T x, const int32_T b,
    emxArray_real32_T zfIIR)
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
    zfIIR.data[k] = convOut.data[x + k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel74(
    const emxArray_real32_T convOut, const emxArray_real32_T a, const int32_T b,
    emxArray_real32_T zfIIR, int32_T a_dim0, int32_T xt_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel75(
    const emxArray_real32_T y, const int32_T b, emxArray_real32_T convOut)
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
    convOut.data[orow] += y.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel76(
    const emxArray_real32_T fv, const int32_T x, const int32_T b,
    emxArray_real32_T y, int32_T y_dim0)
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
    y.data[k + y_dim0 * (x - 1)] = fv.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel8(
    const emxArray_real32_T a, const int32_T b_a, emxArray_real32_T c_a)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt1_kernel9(
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

static void emlrtExitTimeCleanupDtorFcn(const void *r)
{
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
                             emxArray_real32_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId, y);
  emlrtDestroyArray(&b_nullptr);
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_real32_T *y)
{
  c_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real32_T emlrt_marshallIn(const mxArray *b_nullptr,
                                 const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real32_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
  return y;
}

static real32_T emlrt_marshallIn(const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real32_T y;
  y = b_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
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
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(int32_T));
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
    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(real32_T));
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
                                         emxArray_int32_T *gpu,
                                         boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  int32_T *newData;
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
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(int32_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(int32_T),
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

static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu,
                                          boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  real32_T *newData;
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
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(real32_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(real32_T),
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

static void gpuEmxFree_int32_T(emxArray_int32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxFree_real32_T(emxArray_real32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu,
                                         const emxArray_int32_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(cudaMemcpy(gpu->data, cpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(int32_T),
                            cudaMemcpyHostToDevice),
                 __FILE__, __LINE__);
}

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                          const emxArray_real32_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(
      cudaMemcpy(gpu->data, cpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(real32_T),
                 cudaMemcpyHostToDevice),
      __FILE__, __LINE__);
}

static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(
      cudaMemcpy(cpu->data, gpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(real32_T),
                 cudaMemcpyDeviceToHost),
      __FILE__, __LINE__);
}

static void gpuEmxReset_int32_T(emxArray_int32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_int32_T));
}

static void gpuEmxReset_real32_T(emxArray_real32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real32_T));
}

static void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                           const char_T *errorName, const char_T *errorString)
{
  emlrtRTEInfo rtInfo;
  uint64_T len;
  char_T *brk;
  char_T *fn;
  char_T *pn;
  len = strlen(file);
  pn = static_cast<char_T *>(calloc(len + 1UL, 1UL));
  fn = static_cast<char_T *>(calloc(len + 1UL, 1UL));
  memcpy(pn, file, len);
  memcpy(fn, file, len);
  brk = strrchr(fn, '.');
  *brk = '\x00';
  brk = strrchr(fn, '/');
  if (brk == nullptr) {
    brk = strrchr(fn, '\\');
  }
  if (brk == nullptr) {
    brk = fn;
  } else {
    brk++;
  }
  rtInfo.lineNo = static_cast<int32_T>(b_line);
  rtInfo.colNo = 0;
  rtInfo.fName = brk;
  rtInfo.pName = pn;
  emlrtCUDAError(static_cast<uint32_T>(errCode), (char_T *)errorName,
                 (char_T *)errorString, &rtInfo, emlrtRootTLSGlobal);
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
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_iv2;
  emxArray_int32_T gpu_iv3;
  emxArray_int32_T gpu_iv4;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T h_gpu_y;
  emxArray_int32_T *b_cpu_rows;
  emxArray_int32_T *c_cpu_rows;
  emxArray_int32_T *c_cpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv1;
  emxArray_int32_T *cpu_iv2;
  emxArray_int32_T *cpu_iv3;
  emxArray_int32_T *cpu_iv4;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *d_cpu_rows;
  emxArray_int32_T *e_cpu_rows;
  emxArray_int32_T *e_cpu_y;
  emxArray_int32_T *g_cpu_y;
  emxArray_int32_T *h_cpu_y;
  emxArray_int32_T *i_cpu_y;
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
  emxArray_real32_T g_gpu_a;
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
  emxArray_real32_T *f_cpu_y;
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
  real32_T *b_gpu_a;
  real32_T *b_gpu_a1;
  real32_T *c_gpu_a1;
  real32_T *d_gpu_a1;
  real32_T *e_gpu_a1;
  real32_T *gpu_a1;
  boolean_T a_needsGpuEnsureCapacity;
  boolean_T a_outdatedOnGpu;
  boolean_T b_convOut_outdatedOnGpu;
  boolean_T b_needsGpuEnsureCapacity;
  boolean_T b_outdatedOnGpu;
  boolean_T b_y_needsGpuEnsureCapacity;
  boolean_T c_convOut_outdatedOnGpu;
  boolean_T convOut_outdatedOnGpu;
  boolean_T d_convOut_outdatedOnGpu;
  boolean_T e_convOut_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  boolean_T y_outdatedOnCpu;
  boolean_T yc3_needsGpuEnsureCapacity;
  boolean_T yc5_needsGpuEnsureCapacity;
  boolean_T z_needsGpuEnsureCapacity;
  boolean_T z_outdatedOnGpu;
  checkCudaError(mwCudaMalloc(&b_gpu_a, 4UL), __FILE__, __LINE__);
  gpuEmxReset_real32_T(&gpu_convOut);
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_real32_T(&gpu_zfIIR);
  gpuEmxReset_int32_T(&gpu_iv4);
  gpuEmxReset_int32_T(&c_gpu_y);
  gpuEmxReset_real32_T(&gpu_expanded);
  gpuEmxReset_real32_T(&b_gpu_convOut);
  gpuEmxReset_real32_T(&gpu_yc5);
  gpuEmxReset_int32_T(&b_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv3);
  gpuEmxReset_real32_T(&g_gpu_a);
  gpuEmxReset_int32_T(&e_gpu_y);
  gpuEmxReset_real32_T(&f_gpu_b);
  gpuEmxReset_real32_T(&b_gpu_expanded);
  gpuEmxReset_real32_T(&c_gpu_convOut);
  gpuEmxReset_int32_T(&c_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv2);
  gpuEmxReset_real32_T(&f_gpu_a);
  gpuEmxReset_real32_T(&e_gpu_b);
  gpuEmxReset_int32_T(&f_gpu_y);
  gpuEmxReset_real32_T(&b_gpu_y);
  gpuEmxReset_real32_T(&c_gpu_expanded);
  gpuEmxReset_real32_T(&b_gpu_zfIIR);
  checkCudaError(mwCudaMalloc(&gpu_a1, 4UL), __FILE__, __LINE__);
  gpuEmxReset_real32_T(&gpu_yc3);
  gpuEmxReset_real32_T(&d_gpu_convOut);
  gpuEmxReset_real32_T(&c_gpu_zfIIR);
  checkCudaError(mwCudaMalloc(&b_gpu_a1, 4UL), __FILE__, __LINE__);
  gpuEmxReset_real32_T(&e_gpu_a);
  gpuEmxReset_real32_T(&d_gpu_b);
  gpuEmxReset_int32_T(&d_gpu_rows);
  checkCudaError(mwCudaMalloc(&c_gpu_a1, 4UL), __FILE__, __LINE__);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_int32_T(&g_gpu_y);
  gpuEmxReset_real32_T(&d_gpu_expanded);
  checkCudaError(mwCudaMalloc(&d_gpu_a1, 4UL), __FILE__, __LINE__);
  gpuEmxReset_real32_T(&e_gpu_convOut);
  gpuEmxReset_int32_T(&e_gpu_rows);
  gpuEmxReset_real32_T(&d_gpu_y);
  checkCudaError(mwCudaMalloc(&e_gpu_a1, 4UL), __FILE__, __LINE__);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&h_gpu_y);
  gpuEmxReset_real32_T(&e_gpu_expanded);
  gpuEmxReset_real32_T(&d_gpu_a);
  gpuEmxReset_real32_T(&c_gpu_b);
  gpuEmxReset_real32_T(&c_gpu_a);
  gpuEmxReset_real32_T(&b_gpu_b);
  gpuEmxReset_real32_T(&gpu_y);
  gpuEmxReset_real32_T(&gpu_xt);
  gpuEmxReset_real32_T(&gpu_fv);
  gpuEmxReset_real32_T(&i_gpu_y);
  gpuEmxReset_real32_T(&gpu_z);
  gpuEmxReset_real32_T(&gpu_a);
  gpuEmxReset_real32_T(&gpu_b);
  gpuEmxReset_real32_T(&gpu_x);
  e_convOut_outdatedOnGpu = false;
  d_convOut_outdatedOnGpu = false;
  c_convOut_outdatedOnGpu = false;
  b_convOut_outdatedOnGpu = false;
  convOut_outdatedOnGpu = false;
  z_outdatedOnGpu = true;
  a_outdatedOnGpu = true;
  b_outdatedOnGpu = true;
  x_outdatedOnGpu = true;
  yc5_needsGpuEnsureCapacity = true;
  yc3_needsGpuEnsureCapacity = true;
  b_y_needsGpuEnsureCapacity = true;
  z_needsGpuEnsureCapacity = true;
  a_needsGpuEnsureCapacity = true;
  b_needsGpuEnsureCapacity = true;
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
  // 'ec_filtfilt1:99' nChs = cast(width(x),"uint16");
  k = cpu_x->size[1];
  if (cpu_x->size[1] > 65535) {
    k = 65535;
  }
  // 'ec_filtfilt1:100' y = coder.nullcopy(x);
  y_outdatedOnCpu = false;
  bcoef = cpu_y->size[0] * cpu_y->size[1];
  cpu_y->size[0] = cpu_x->size[0];
  cpu_y->size[1] = cpu_x->size[1];
  emxEnsureCapacity_real32_T(cpu_y, bcoef, &emlrtRTEI);
  y_needsGpuEnsureCapacity = true;
  //  Loop across chans
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
      gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a, false);
      a_needsGpuEnsureCapacity = false;
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
      a_outdatedOnGpu = false;
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
  emxInit_int32_T(&cpu_iv, 1, &g_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_y, 1, &n_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&cpu_convOut, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_expanded, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&e_cpu_y, 2, &g_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv1, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_rows, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_b, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_a, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&cpu_zfIIR, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_convOut, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&cpu_yc3, 1, &i_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_zfIIR, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_expanded, 1, &g_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_y, 1, &o_emlrtRTEI, true);
  emxInit_int32_T(&g_cpu_y, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_b, 1, &e_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_a, 1, &e_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv2, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&c_cpu_rows, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_convOut, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_expanded, 1, &g_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_b, 1, &e_emlrtRTEI, true);
  emxInit_int32_T(&h_cpu_y, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_a, 1, &e_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv3, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&d_cpu_rows, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&cpu_yc5, 1, &j_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_convOut, 1, &f_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_expanded, 1, &g_emlrtRTEI, true);
  emxInit_int32_T(&i_cpu_y, 2, &g_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv4, 1, &g_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_zfIIR, 1, &f_emlrtRTEI, true);
  emxInit_int32_T(&e_cpu_rows, 2, &g_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_convOut, 1, &f_emlrtRTEI, true);
  b = computeEndIdx(1L, static_cast<int64_T>(static_cast<uint16_T>(k)), 1L);
  for (int64_T ch{0L}; ch <= b; ch++) {
    int32_T b_x;
    boolean_T validLaunchParams;
    // 'ec_filtfilt1:104' y(:,ch) = filtfilt_lfn(x(:,ch),b,a,z,nf,L);
    k = cpu_fv->size[0];
    cpu_fv->size[0] = cpu_x->size[0];
    emxEnsureCapacity_real32_T(cpu_fv, k, &b_emlrtRTEI);
    b_x = cpu_x->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(b_x), &grid, &block, 2147483647U);
    if (x_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real32_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
    }
    x_needsGpuEnsureCapacity = false;
    gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
    if (x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
    }
    x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_filtfilt1_kernel2<<<grid, block>>>(
          static_cast<int32_T>(static_cast<uint16_T>(ch + 1L)), gpu_x, b_x,
          gpu_fv, cpu_x->size[0U]);
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
    // 'ec_filtfilt1:132' for ii = 1:L
    for (int32_T ii{0}; ii < i; ii++) {
      real_T blockDims_idx_0;
      real_T c_OH;
      real_T x;
      int32_T KH;
      int32_T b_OH;
      int32_T i22;
      int32_T i24;
      int32_T i25;
      int32_T j;
      int32_T offsetH;
      int32_T zfSize_idx_0;
      real32_T g_cpu_a;
      uint32_T OH;
      uint32_T window_idx_0;
      int8_T threadDims_idx_0;
      boolean_T a_outdatedOnCpu;
      boolean_T convOut_needsGpuEnsureCapacity;
      boolean_T convOut_outdatedOnCpu;
      // 'ec_filtfilt1:133' xt = bsxfun(@minus, 2*x(1,:),x(nf(1,1)+1:-1:2,:));
      ec_filtfilt1_kernel3<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_fv,
                                                                    b_gpu_a);
      k = cpu_xt->size[0];
      cpu_xt->size[0] = csz_idx_0;
      emxEnsureCapacity_real32_T(cpu_xt, k, &c_emlrtRTEI);
      y_outdatedOnCpu = true;
      if (csz_idx_0 != 0) {
        mwGetLaunchParameters1D(computeNumIters(csz_idx_0 - 1), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_real32_T(cpu_xt, &gpu_xt, true);
        y_outdatedOnCpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel4<<<grid, block>>>(
              gpu_fv, static_cast<int32_T>(div_s32(i3 - i1, i2) + 1 != 1), i2,
              i1, b_gpu_a, csz_idx_0 - 1, gpu_xt);
        }
      }
      // 'ec_filtfilt1:134' [~,zo] =
      // filter(b(:,ii),a(:,ii),xt,z(:,ii)*xt(1,:),1);
      if (y_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real32_T(cpu_xt, &gpu_xt, true);
      }
      ec_filtfilt1_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_xt,
                                                                    b_gpu_a);
      k = b_cpu_y->size[0];
      b_cpu_y->size[0] = cpu_z->size[0];
      emxEnsureCapacity_real32_T(b_cpu_y, k, &d_emlrtRTEI);
      k = cpu_z->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      if (z_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z, !z_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_real32_T(b_cpu_y, &gpu_y, true);
      if (z_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel6<<<grid, block>>>(b_gpu_a, gpu_z, k, gpu_y);
      }
      k = b_cpu_b->size[0];
      b_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real32_T(b_cpu_b, k, &e_emlrtRTEI);
      k = cpu_b->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      if (b_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b, !b_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_real32_T(b_cpu_b, &b_gpu_b, true);
      b_needsGpuEnsureCapacity = false;
      if (b_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel7<<<grid, block>>>(gpu_b, k, b_gpu_b);
      }
      k = b_cpu_a->size[0];
      b_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real32_T(b_cpu_a, k, &e_emlrtRTEI);
      k = cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      if (a_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a, !a_outdatedOnGpu);
      }
      gpuEmxEnsureCapacity_real32_T(b_cpu_a, &c_gpu_a, true);
      y_outdatedOnCpu = false;
      if (a_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
      }
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel8<<<grid, block>>>(gpu_a, k, c_gpu_a);
      }
      a_outdatedOnCpu = true;
      if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0]))) {
        if (!(cpu_a->data[0] == 0.0F)) {
          if (cpu_a->data[0] != 1.0F) {
            a_needsGpuEnsureCapacity = true;
            mwGetLaunchParameters1D(computeNumIters(nb - 1), &grid, &block,
                                    2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_filtfilt1_kernel9<<<grid, block>>>(e_gpu_a1, nb - 1, b_gpu_b);
            }
            mwGetLaunchParameters1D(computeNumIters(na - 2), &grid, &block,
                                    2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_filtfilt1_kernel10<<<grid, block>>>(e_gpu_a1, na - 2, c_gpu_a);
            }
            ec_filtfilt1_kernel11<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                c_gpu_a);
          } else {
            a_needsGpuEnsureCapacity = true;
          }
        } else {
          a_needsGpuEnsureCapacity = true;
        }
      } else {
        a_needsGpuEnsureCapacity = true;
      }
      if (b_cpu_a->size[0] > b_cpu_b->size[0]) {
        b_x = b_cpu_a->size[0] - b_cpu_b->size[0];
        k = b_cpu_b->size[0];
        bcoef = b_cpu_b->size[0];
        b_cpu_b->size[0] = b_cpu_a->size[0];
        emxEnsureCapacity_real32_T(b_cpu_b, bcoef, &f_emlrtRTEI);
        b_needsGpuEnsureCapacity = true;
        if (b_x - 1 >= 0) {
          gpuEmxEnsureCapacity_real32_T(b_cpu_b, &b_gpu_b, true);
          b_needsGpuEnsureCapacity = false;
          cudaMemset(&b_gpu_b.data[k], 0,
                     static_cast<uint32_T>(b_x) * sizeof(real32_T));
        }
      }
      zfSize_idx_0 = b_cpu_b->size[0] - 1;
      if (cpu_xt->size[0] == 0) {
        k = cpu_zfIIR->size[0];
        cpu_zfIIR->size[0] = b_cpu_b->size[0] - 1;
        emxEnsureCapacity_real32_T(cpu_zfIIR, k, &f_emlrtRTEI);
      } else {
        window_idx_0 = static_cast<uint32_T>(b_cpu_b->size[0]);
        OH = (static_cast<uint32_T>(cpu_xt->size[0]) +
              static_cast<uint32_T>(b_cpu_b->size[0])) -
             1U;
        b_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        blockDims_idx_0 = std::floor(
            (static_cast<real_T>(OH) + (static_cast<real_T>(b_x) - 1.0)) /
            static_cast<real_T>(b_x));
        threadDims_idx_0 = static_cast<int8_T>(b_x);
        if (OH > 2147483647U) {
          OH = 2147483647U;
        }
        KH = b_cpu_b->size[0];
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(b_cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(b_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(OH) > 0) &&
            (b_cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(OH))) {
          b_x = MAX_int32_T;
        } else {
          b_x = static_cast<int32_T>(OH) + b_cpu_b->size[0];
        }
        k = cpu_expanded->size[0];
        cpu_expanded->size[0] = b_x - 1;
        emxEnsureCapacity_real32_T(cpu_expanded, k, &g_emlrtRTEI);
        k = (static_cast<int32_T>(OH) + static_cast<int32_T>(window_idx_0)) - 2;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real32_T(cpu_expanded, &e_gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel68<<<grid, block>>>(k, e_gpu_expanded);
        }
        bcoef = cpu_xt->size[0];
        k = c_cpu_y->size[0] * c_cpu_y->size[1];
        c_cpu_y->size[0] = 1;
        c_cpu_y->size[1] = cpu_xt->size[0];
        emxEnsureCapacity_int32_T(c_cpu_y, k, &h_emlrtRTEI);
        c_cpu_y->data[0] = 1;
        b_x = 1;
        for (k = 0; k <= bcoef - 2; k++) {
          b_x++;
          c_cpu_y->data[k + 1] = b_x;
        }
        k = cpu_iv->size[0];
        cpu_iv->size[0] = c_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv, k, &g_emlrtRTEI);
        k = c_cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_int32_T(c_cpu_y, &h_gpu_y, false);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&h_gpu_y, c_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel69<<<grid, block>>>(offsetH, h_gpu_y, k, gpu_iv);
        }
        bcoef = cpu_iv->size[0];
        mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel70<<<grid, block>>>(gpu_xt, gpu_iv, bcoef - 1,
                                                 e_gpu_expanded);
        }
        k = cpu_rows->size[0] * cpu_rows->size[1];
        cpu_rows->size[0] = 1;
        cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(cpu_rows, k, &h_emlrtRTEI);
        cpu_rows->data[0] = 0;
        b_x = 0;
        for (k = 0; k <= KH - 2; k++) {
          b_x++;
          cpu_rows->data[k + 1] = b_x;
        }
        k = cpu_convOut->size[0];
        cpu_convOut->size[0] = static_cast<int32_T>(OH);
        emxEnsureCapacity_real32_T(cpu_convOut, k, &g_emlrtRTEI);
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
        mwApplyLaunchParameters(
            computeNumIters(static_cast<int32_T>(OH) - 1),
            dim3(window_idx_0, 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid,
            &block);
        gpuEmxEnsureCapacity_int32_T(cpu_rows, &e_gpu_rows, false);
        if (b_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(b_cpu_b, &b_gpu_b, true);
        }
        gpuEmxEnsureCapacity_real32_T(cpu_convOut, &e_gpu_convOut, true);
        convOut_needsGpuEnsureCapacity = false;
        gpuEmxMemcpyCpuToGpu_int32_T(&e_gpu_rows, cpu_rows);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel71<<<grid, block>>>(
              e_gpu_expanded, e_gpu_rows, b_gpu_b, static_cast<int32_T>(OH) - 1,
              e_gpu_convOut, b_cpu_b->size[0U]);
        }
        convOut_outdatedOnCpu = true;
        if (b_cpu_y->size[0] != 0) {
          if (b_cpu_y->size[0] == 1) {
            ec_filtfilt1_kernel72<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                gpu_y, e_gpu_convOut);
          } else {
            b_x = b_cpu_y->size[0];
            mwGetLaunchParameters1D(computeNumIters(b_x - 1), &grid, &block,
                                    2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_filtfilt1_kernel75<<<grid, block>>>(gpu_y, b_x - 1,
                                                     e_gpu_convOut);
            }
          }
        }
        b_x = cpu_xt->size[0] + b_cpu_a->size[0];
        for (KH = 0; KH <= b_x - 2; KH++) {
          bcoef = static_cast<int32_T>(
              std::fmin(static_cast<real_T>(KH) + 1.0,
                        static_cast<real_T>(b_cpu_a->size[0])));
          for (j = 0; j <= bcoef - 2; j++) {
            if (convOut_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_convOut, &e_gpu_convOut);
            }
            if (a_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_a, &c_gpu_a);
            }
            a_outdatedOnCpu = false;
            cpu_convOut->data[KH] -=
                cpu_convOut->data[(KH - j) - 1] * b_cpu_a->data[j + 1];
            convOut_outdatedOnCpu = false;
            convOut_outdatedOnGpu = true;
            y_outdatedOnCpu = true;
            convOut_needsGpuEnsureCapacity = true;
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
        k = (bcoef - b_x) - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        if (convOut_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(cpu_convOut, &e_gpu_convOut,
                                        !convOut_outdatedOnGpu);
        }
        gpuEmxEnsureCapacity_real32_T(cpu_zfIIR, &c_gpu_zfIIR, true);
        if (convOut_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_convOut, cpu_convOut);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel73<<<grid, block>>>(e_gpu_convOut, b_x, k,
                                                 c_gpu_zfIIR);
        }
        b_x = b_cpu_a->size[0];
        mwGetLaunchParameters1D(computeNumIters(b_x - 3), &grid, &block,
                                2147483647U);
        if (y_outdatedOnCpu) {
          gpuEmxEnsureCapacity_real32_T(b_cpu_a, &c_gpu_a, true);
        }
        convOut_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel74<<<grid, block>>>(
              e_gpu_convOut, c_gpu_a, b_x - 3, c_gpu_zfIIR, b_cpu_a->size[0U],
              cpu_xt->size[0U]);
        }
        k = cpu_zfIIR->size[0];
        cpu_zfIIR->size[0] = zfSize_idx_0;
        emxEnsureCapacity_real32_T(cpu_zfIIR, k, &f_emlrtRTEI);
      }
      //  outer product
      // 'ec_filtfilt1:135' [yc2,zo] = filter(b(:,ii),a(:,ii),x,zo,1);
      k = c_cpu_b->size[0];
      c_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real32_T(c_cpu_b, k, &e_emlrtRTEI);
      k = cpu_b->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(c_cpu_b, &c_gpu_b, true);
      b_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel12<<<grid, block>>>(gpu_b, k, c_gpu_b);
      }
      k = c_cpu_a->size[0];
      c_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real32_T(c_cpu_a, k, &e_emlrtRTEI);
      k = cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a, true);
      gpuEmxEnsureCapacity_real32_T(c_cpu_a, &d_gpu_a, true);
      y_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel13<<<grid, block>>>(gpu_a, k, d_gpu_a);
      }
      a_outdatedOnCpu = true;
      if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
          (!(cpu_a->data[0] == 0.0F)) && (cpu_a->data[0] != 1.0F)) {
        mwGetLaunchParameters1D(computeNumIters(b_nb - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel14<<<grid, block>>>(d_gpu_a1, b_nb - 1, c_gpu_b);
        }
        mwGetLaunchParameters1D(computeNumIters(b_na - 2), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel15<<<grid, block>>>(d_gpu_a1, b_na - 2, d_gpu_a);
        }
        ec_filtfilt1_kernel16<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_a);
      }
      if (c_cpu_a->size[0] > c_cpu_b->size[0]) {
        b_x = c_cpu_a->size[0] - c_cpu_b->size[0];
        k = c_cpu_b->size[0];
        bcoef = c_cpu_b->size[0];
        c_cpu_b->size[0] = c_cpu_a->size[0];
        emxEnsureCapacity_real32_T(c_cpu_b, bcoef, &f_emlrtRTEI);
        b_needsGpuEnsureCapacity = true;
        if (b_x - 1 >= 0) {
          gpuEmxEnsureCapacity_real32_T(c_cpu_b, &c_gpu_b, true);
          b_needsGpuEnsureCapacity = false;
          cudaMemset(&c_gpu_b.data[k], 0,
                     static_cast<uint32_T>(b_x) * sizeof(real32_T));
        }
      }
      zfSize_idx_0 = c_cpu_b->size[0] - 1;
      if (cpu_fv->size[0] == 0) {
        d_cpu_y->size[0] = 0;
        k = b_cpu_zfIIR->size[0];
        b_cpu_zfIIR->size[0] = c_cpu_b->size[0] - 1;
        emxEnsureCapacity_real32_T(b_cpu_zfIIR, k, &f_emlrtRTEI);
      } else {
        window_idx_0 = static_cast<uint32_T>(c_cpu_b->size[0]);
        OH = (static_cast<uint32_T>(cpu_fv->size[0]) +
              static_cast<uint32_T>(c_cpu_b->size[0])) -
             1U;
        b_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        blockDims_idx_0 = std::floor(
            (static_cast<real_T>(OH) + (static_cast<real_T>(b_x) - 1.0)) /
            static_cast<real_T>(b_x));
        threadDims_idx_0 = static_cast<int8_T>(b_x);
        if (OH > 2147483647U) {
          OH = 2147483647U;
        }
        KH = c_cpu_b->size[0];
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(c_cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(c_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(OH) > 0) &&
            (c_cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(OH))) {
          b_x = MAX_int32_T;
        } else {
          b_x = static_cast<int32_T>(OH) + c_cpu_b->size[0];
        }
        k = b_cpu_expanded->size[0];
        b_cpu_expanded->size[0] = b_x - 1;
        emxEnsureCapacity_real32_T(b_cpu_expanded, k, &g_emlrtRTEI);
        k = (static_cast<int32_T>(OH) + static_cast<int32_T>(window_idx_0)) - 2;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real32_T(b_cpu_expanded, &d_gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel59<<<grid, block>>>(k, d_gpu_expanded);
        }
        bcoef = cpu_fv->size[0];
        k = e_cpu_y->size[0] * e_cpu_y->size[1];
        e_cpu_y->size[0] = 1;
        e_cpu_y->size[1] = cpu_fv->size[0];
        emxEnsureCapacity_int32_T(e_cpu_y, k, &h_emlrtRTEI);
        e_cpu_y->data[0] = 1;
        b_x = 1;
        for (k = 0; k <= bcoef - 2; k++) {
          b_x++;
          e_cpu_y->data[k + 1] = b_x;
        }
        k = cpu_iv1->size[0];
        cpu_iv1->size[0] = e_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv1, k, &g_emlrtRTEI);
        k = e_cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_int32_T(e_cpu_y, &g_gpu_y, false);
        gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&g_gpu_y, e_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel60<<<grid, block>>>(offsetH, g_gpu_y, k, gpu_iv1);
        }
        bcoef = cpu_iv1->size[0];
        mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel61<<<grid, block>>>(gpu_fv, gpu_iv1, bcoef - 1,
                                                 d_gpu_expanded);
        }
        k = b_cpu_rows->size[0] * b_cpu_rows->size[1];
        b_cpu_rows->size[0] = 1;
        b_cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(b_cpu_rows, k, &h_emlrtRTEI);
        b_cpu_rows->data[0] = 0;
        b_x = 0;
        for (k = 0; k <= KH - 2; k++) {
          b_x++;
          b_cpu_rows->data[k + 1] = b_x;
        }
        k = b_cpu_convOut->size[0];
        b_cpu_convOut->size[0] = static_cast<int32_T>(OH);
        emxEnsureCapacity_real32_T(b_cpu_convOut, k, &g_emlrtRTEI);
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
        mwApplyLaunchParameters(
            computeNumIters(static_cast<int32_T>(OH) - 1),
            dim3(window_idx_0, 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid,
            &block);
        gpuEmxEnsureCapacity_int32_T(b_cpu_rows, &d_gpu_rows, false);
        if (b_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(c_cpu_b, &c_gpu_b, true);
        }
        gpuEmxEnsureCapacity_real32_T(b_cpu_convOut, &d_gpu_convOut, true);
        convOut_needsGpuEnsureCapacity = false;
        gpuEmxMemcpyCpuToGpu_int32_T(&d_gpu_rows, b_cpu_rows);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel62<<<grid, block>>>(
              d_gpu_expanded, d_gpu_rows, c_gpu_b, static_cast<int32_T>(OH) - 1,
              d_gpu_convOut, c_cpu_b->size[0U]);
        }
        convOut_outdatedOnCpu = true;
        if (cpu_zfIIR->size[0] != 0) {
          if (cpu_zfIIR->size[0] == 1) {
            gpuEmxEnsureCapacity_real32_T(cpu_zfIIR, &c_gpu_zfIIR, true);
            ec_filtfilt1_kernel63<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                c_gpu_zfIIR, d_gpu_convOut);
          } else {
            b_x = cpu_zfIIR->size[0];
            mwGetLaunchParameters1D(computeNumIters(b_x - 1), &grid, &block,
                                    2147483647U);
            gpuEmxEnsureCapacity_real32_T(cpu_zfIIR, &c_gpu_zfIIR, true);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_filtfilt1_kernel67<<<grid, block>>>(c_gpu_zfIIR, b_x - 1,
                                                     d_gpu_convOut);
            }
          }
        }
        b_x = cpu_fv->size[0] + c_cpu_a->size[0];
        for (KH = 0; KH <= b_x - 2; KH++) {
          bcoef = static_cast<int32_T>(
              std::fmin(static_cast<real_T>(KH) + 1.0,
                        static_cast<real_T>(c_cpu_a->size[0])));
          for (j = 0; j <= bcoef - 2; j++) {
            if (convOut_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_convOut, &d_gpu_convOut);
            }
            if (a_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_a, &d_gpu_a);
            }
            a_outdatedOnCpu = false;
            b_cpu_convOut->data[KH] -=
                b_cpu_convOut->data[(KH - j) - 1] * c_cpu_a->data[j + 1];
            convOut_outdatedOnCpu = false;
            b_convOut_outdatedOnGpu = true;
            y_outdatedOnCpu = true;
            convOut_needsGpuEnsureCapacity = true;
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
        k = (bcoef - b_x) - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        if (convOut_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(b_cpu_convOut, &d_gpu_convOut,
                                        !b_convOut_outdatedOnGpu);
        }
        gpuEmxEnsureCapacity_real32_T(b_cpu_zfIIR, &b_gpu_zfIIR, true);
        if (b_convOut_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_convOut, b_cpu_convOut);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel64<<<grid, block>>>(d_gpu_convOut, b_x, k,
                                                 b_gpu_zfIIR);
        }
        b_x = c_cpu_a->size[0];
        mwGetLaunchParameters1D(computeNumIters(b_x - 3), &grid, &block,
                                2147483647U);
        if (y_outdatedOnCpu) {
          gpuEmxEnsureCapacity_real32_T(c_cpu_a, &d_gpu_a, true);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel65<<<grid, block>>>(
              d_gpu_convOut, d_gpu_a, b_x - 3, b_gpu_zfIIR, c_cpu_a->size[0U],
              cpu_fv->size[0U]);
        }
        k = b_cpu_zfIIR->size[0];
        b_cpu_zfIIR->size[0] = zfSize_idx_0;
        emxEnsureCapacity_real32_T(b_cpu_zfIIR, k, &f_emlrtRTEI);
        k = d_cpu_y->size[0];
        d_cpu_y->size[0] = cpu_fv->size[0];
        emxEnsureCapacity_real32_T(d_cpu_y, k, &f_emlrtRTEI);
        k = cpu_fv->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real32_T(d_cpu_y, &d_gpu_y, true);
        b_y_needsGpuEnsureCapacity = false;
        b_convOut_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel66<<<grid, block>>>(d_gpu_convOut, k, d_gpu_y);
        }
      }
      // 'ec_filtfilt1:136' xt = bsxfun(@minus,
      // 2*x(end,:),x(end-1:-1:end-nf(1,1),:));
      g_cpu_a = static_cast<real32_T>(cpu_fv->size[0]) - nf;
      if (g_cpu_a >
          static_cast<real32_T>(static_cast<real_T>(cpu_fv->size[0]) - 1.0)) {
        offsetH = 1;
        KH = 1;
        b_x = 0;
      } else {
        offsetH = static_cast<int32_T>(
            static_cast<real32_T>(static_cast<real_T>(cpu_fv->size[0]) - 1.0));
        KH = -1;
        b_x = static_cast<int32_T>(g_cpu_a);
      }
      ec_filtfilt1_kernel17<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
          gpu_fv, b_gpu_a, cpu_fv->size[0U]);
      k = div_s32(b_x - offsetH, KH) + 1;
      bcoef = cpu_xt->size[0];
      cpu_xt->size[0] = k;
      emxEnsureCapacity_real32_T(cpu_xt, bcoef, &c_emlrtRTEI);
      y_outdatedOnCpu = true;
      if (k != 0) {
        mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_real32_T(cpu_xt, &gpu_xt, true);
        y_outdatedOnCpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel18<<<grid, block>>>(
              gpu_fv, static_cast<int32_T>(div_s32(b_x - offsetH, KH) + 1 != 1),
              KH, offsetH, b_gpu_a, k - 1, gpu_xt);
        }
      }
      // 'ec_filtfilt1:137' yc3 = filter(b(:,ii),a(:,ii),xt,zo,1);
      k = d_cpu_b->size[0];
      d_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real32_T(d_cpu_b, k, &e_emlrtRTEI);
      k = cpu_b->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(d_cpu_b, &d_gpu_b, true);
      b_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel19<<<grid, block>>>(gpu_b, k, d_gpu_b);
      }
      k = d_cpu_a->size[0];
      d_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real32_T(d_cpu_a, k, &e_emlrtRTEI);
      k = cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a, true);
      gpuEmxEnsureCapacity_real32_T(d_cpu_a, &e_gpu_a, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel20<<<grid, block>>>(gpu_a, k, e_gpu_a);
      }
      a_outdatedOnCpu = true;
      if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
          (!(cpu_a->data[0] == 0.0F)) && (cpu_a->data[0] != 1.0F)) {
        mwGetLaunchParameters1D(computeNumIters(c_nb - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel21<<<grid, block>>>(c_gpu_a1, c_nb - 1, d_gpu_b);
        }
        mwGetLaunchParameters1D(computeNumIters(c_na - 2), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel22<<<grid, block>>>(c_gpu_a1, c_na - 2, e_gpu_a);
        }
        ec_filtfilt1_kernel23<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(e_gpu_a);
      }
      if (d_cpu_a->size[0] > d_cpu_b->size[0]) {
        b_x = d_cpu_a->size[0] - d_cpu_b->size[0];
        k = d_cpu_b->size[0];
        bcoef = d_cpu_b->size[0];
        d_cpu_b->size[0] = d_cpu_a->size[0];
        emxEnsureCapacity_real32_T(d_cpu_b, bcoef, &f_emlrtRTEI);
        b_needsGpuEnsureCapacity = true;
        if (b_x - 1 >= 0) {
          gpuEmxEnsureCapacity_real32_T(d_cpu_b, &d_gpu_b, true);
          b_needsGpuEnsureCapacity = false;
          cudaMemset(&d_gpu_b.data[k], 0,
                     static_cast<uint32_T>(b_x) * sizeof(real32_T));
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
        blockDims_idx_0 = std::floor(
            (static_cast<real_T>(OH) + (static_cast<real_T>(b_x) - 1.0)) /
            static_cast<real_T>(b_x));
        threadDims_idx_0 = static_cast<int8_T>(b_x);
        if (OH > 2147483647U) {
          OH = 2147483647U;
        }
        KH = d_cpu_b->size[0];
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(d_cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(d_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(OH) > 0) &&
            (d_cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(OH))) {
          b_x = MAX_int32_T;
        } else {
          b_x = static_cast<int32_T>(OH) + d_cpu_b->size[0];
        }
        k = c_cpu_expanded->size[0];
        c_cpu_expanded->size[0] = b_x - 1;
        emxEnsureCapacity_real32_T(c_cpu_expanded, k, &g_emlrtRTEI);
        k = (static_cast<int32_T>(OH) + static_cast<int32_T>(window_idx_0)) - 2;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real32_T(c_cpu_expanded, &c_gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel52<<<grid, block>>>(k, c_gpu_expanded);
        }
        bcoef = cpu_xt->size[0];
        k = g_cpu_y->size[0] * g_cpu_y->size[1];
        g_cpu_y->size[0] = 1;
        g_cpu_y->size[1] = cpu_xt->size[0];
        emxEnsureCapacity_int32_T(g_cpu_y, k, &h_emlrtRTEI);
        g_cpu_y->data[0] = 1;
        b_x = 1;
        for (k = 0; k <= bcoef - 2; k++) {
          b_x++;
          g_cpu_y->data[k + 1] = b_x;
        }
        k = cpu_iv2->size[0];
        cpu_iv2->size[0] = g_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv2, k, &g_emlrtRTEI);
        k = g_cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_int32_T(g_cpu_y, &f_gpu_y, false);
        gpuEmxEnsureCapacity_int32_T(cpu_iv2, &gpu_iv2, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&f_gpu_y, g_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel53<<<grid, block>>>(offsetH, f_gpu_y, k, gpu_iv2);
        }
        bcoef = cpu_iv2->size[0];
        mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                                2147483647U);
        if (y_outdatedOnCpu) {
          gpuEmxEnsureCapacity_real32_T(cpu_xt, &gpu_xt, true);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel54<<<grid, block>>>(gpu_xt, gpu_iv2, bcoef - 1,
                                                 c_gpu_expanded);
        }
        k = c_cpu_rows->size[0] * c_cpu_rows->size[1];
        c_cpu_rows->size[0] = 1;
        c_cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(c_cpu_rows, k, &h_emlrtRTEI);
        c_cpu_rows->data[0] = 0;
        b_x = 0;
        for (k = 0; k <= KH - 2; k++) {
          b_x++;
          c_cpu_rows->data[k + 1] = b_x;
        }
        k = c_cpu_convOut->size[0];
        c_cpu_convOut->size[0] = static_cast<int32_T>(OH);
        emxEnsureCapacity_real32_T(c_cpu_convOut, k, &g_emlrtRTEI);
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
        mwApplyLaunchParameters(
            computeNumIters(static_cast<int32_T>(OH) - 1),
            dim3(window_idx_0, 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid,
            &block);
        gpuEmxEnsureCapacity_int32_T(c_cpu_rows, &c_gpu_rows, false);
        if (b_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(d_cpu_b, &d_gpu_b, true);
        }
        gpuEmxEnsureCapacity_real32_T(c_cpu_convOut, &c_gpu_convOut, true);
        convOut_needsGpuEnsureCapacity = false;
        gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_rows, c_cpu_rows);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel55<<<grid, block>>>(
              c_gpu_expanded, c_gpu_rows, d_gpu_b, static_cast<int32_T>(OH) - 1,
              c_gpu_convOut, d_cpu_b->size[0U]);
        }
        convOut_outdatedOnCpu = true;
        if (b_cpu_zfIIR->size[0] != 0) {
          if (b_cpu_zfIIR->size[0] == 1) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_zfIIR, &b_gpu_zfIIR, true);
            ec_filtfilt1_kernel56<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                b_gpu_zfIIR, c_gpu_convOut);
          } else {
            b_x = b_cpu_zfIIR->size[0];
            mwGetLaunchParameters1D(computeNumIters(b_x - 1), &grid, &block,
                                    2147483647U);
            gpuEmxEnsureCapacity_real32_T(b_cpu_zfIIR, &b_gpu_zfIIR, true);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_filtfilt1_kernel58<<<grid, block>>>(b_gpu_zfIIR, b_x - 1,
                                                     c_gpu_convOut);
            }
          }
        }
        b_x = cpu_xt->size[0] + d_cpu_a->size[0];
        for (KH = 0; KH <= b_x - 2; KH++) {
          bcoef = static_cast<int32_T>(
              std::fmin(static_cast<real_T>(KH) + 1.0,
                        static_cast<real_T>(d_cpu_a->size[0])));
          for (j = 0; j <= bcoef - 2; j++) {
            if (convOut_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_convOut, &c_gpu_convOut);
            }
            if (a_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_a, &e_gpu_a);
            }
            a_outdatedOnCpu = false;
            c_cpu_convOut->data[KH] -=
                c_cpu_convOut->data[(KH - j) - 1] * d_cpu_a->data[j + 1];
            convOut_outdatedOnCpu = false;
            c_convOut_outdatedOnGpu = true;
            convOut_needsGpuEnsureCapacity = true;
          }
        }
        k = cpu_yc3->size[0];
        cpu_yc3->size[0] = cpu_xt->size[0];
        emxEnsureCapacity_real32_T(cpu_yc3, k, &i_emlrtRTEI);
        k = cpu_xt->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        if (convOut_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(c_cpu_convOut, &c_gpu_convOut,
                                        !c_convOut_outdatedOnGpu);
        }
        gpuEmxEnsureCapacity_real32_T(cpu_yc3, &gpu_yc3, true);
        yc3_needsGpuEnsureCapacity = false;
        if (c_convOut_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_convOut, c_cpu_convOut);
        }
        c_convOut_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel57<<<grid, block>>>(c_gpu_convOut, k, gpu_yc3);
        }
      }
      // 'ec_filtfilt1:139' [~,zo] =
      // filter(b(:,ii),a(:,ii),yc3(end:-1:1,:),z(:,ii)*yc3(end,:),1);
      if (cpu_yc3->size[0] < 1) {
        i22 = 1;
        i24 = 1;
        i25 = 0;
      } else {
        i22 = cpu_yc3->size[0];
        i24 = -1;
        i25 = 1;
      }
      if (yc3_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_yc3, &gpu_yc3, true);
      }
      yc3_needsGpuEnsureCapacity = false;
      ec_filtfilt1_kernel24<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
          gpu_yc3, b_gpu_a, cpu_yc3->size[0U]);
      k = f_cpu_y->size[0];
      f_cpu_y->size[0] = cpu_z->size[0];
      emxEnsureCapacity_real32_T(f_cpu_y, k, &d_emlrtRTEI);
      k = cpu_z->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      z_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_real32_T(f_cpu_y, &b_gpu_y, true);
      z_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel25<<<grid, block>>>(b_gpu_a, gpu_z, k, b_gpu_y);
      }
      k = e_cpu_b->size[0];
      e_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real32_T(e_cpu_b, k, &e_emlrtRTEI);
      k = cpu_b->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(e_cpu_b, &e_gpu_b, true);
      b_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel26<<<grid, block>>>(gpu_b, k, e_gpu_b);
      }
      k = e_cpu_a->size[0];
      e_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real32_T(e_cpu_a, k, &e_emlrtRTEI);
      k = cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a, true);
      gpuEmxEnsureCapacity_real32_T(e_cpu_a, &f_gpu_a, true);
      y_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel27<<<grid, block>>>(gpu_a, k, f_gpu_a);
      }
      a_outdatedOnCpu = true;
      if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
          (!(cpu_a->data[0] == 0.0F)) && (cpu_a->data[0] != 1.0F)) {
        mwGetLaunchParameters1D(computeNumIters(d_nb - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel28<<<grid, block>>>(b_gpu_a1, d_nb - 1, e_gpu_b);
        }
        mwGetLaunchParameters1D(computeNumIters(d_na - 2), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel29<<<grid, block>>>(b_gpu_a1, d_na - 2, f_gpu_a);
        }
        ec_filtfilt1_kernel30<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(f_gpu_a);
      }
      if (e_cpu_a->size[0] > e_cpu_b->size[0]) {
        b_x = e_cpu_a->size[0] - e_cpu_b->size[0];
        k = e_cpu_b->size[0];
        bcoef = e_cpu_b->size[0];
        e_cpu_b->size[0] = e_cpu_a->size[0];
        emxEnsureCapacity_real32_T(e_cpu_b, bcoef, &f_emlrtRTEI);
        b_needsGpuEnsureCapacity = true;
        if (b_x - 1 >= 0) {
          gpuEmxEnsureCapacity_real32_T(e_cpu_b, &e_gpu_b, true);
          b_needsGpuEnsureCapacity = false;
          cudaMemset(&e_gpu_b.data[k], 0,
                     static_cast<uint32_T>(b_x) * sizeof(real32_T));
        }
      }
      zfSize_idx_0 = e_cpu_b->size[0] - 1;
      if (div_s32(i25 - i22, i24) + 1 == 0) {
        k = c_cpu_zfIIR->size[0];
        c_cpu_zfIIR->size[0] = e_cpu_b->size[0] - 1;
        emxEnsureCapacity_real32_T(c_cpu_zfIIR, k, &f_emlrtRTEI);
      } else {
        window_idx_0 = static_cast<uint32_T>(e_cpu_b->size[0]);
        c_OH = (static_cast<real_T>(div_s32(i25 - i22, i24) + 1) +
                static_cast<real_T>(e_cpu_b->size[0])) -
               1.0;
        x = std::fmin(32.0, c_OH);
        blockDims_idx_0 = std::floor((c_OH + (x - 1.0)) / x);
        if (x >= -2.147483648E+9) {
          j = static_cast<int32_T>(x);
        } else {
          j = MIN_int32_T;
        }
        if (c_OH < 2.147483648E+9) {
          if (c_OH >= -2.147483648E+9) {
            b_OH = static_cast<int32_T>(c_OH);
          } else {
            b_OH = MIN_int32_T;
          }
        } else {
          b_OH = MAX_int32_T;
        }
        KH = e_cpu_b->size[0];
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(e_cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(e_cpu_b->size[0]) - 1.0) / 2.0));
        if ((b_OH < 0) && (e_cpu_b->size[0] < MIN_int32_T - b_OH)) {
          b_x = MIN_int32_T;
        } else if ((b_OH > 0) && (e_cpu_b->size[0] > MAX_int32_T - b_OH)) {
          b_x = MAX_int32_T;
        } else {
          b_x = b_OH + e_cpu_b->size[0];
        }
        if (b_x >= -2147483647) {
          b_x--;
        }
        k = d_cpu_expanded->size[0];
        d_cpu_expanded->size[0] = b_x;
        emxEnsureCapacity_real32_T(d_cpu_expanded, k, &g_emlrtRTEI);
        k = (b_OH + static_cast<int32_T>(window_idx_0)) - 2;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real32_T(d_cpu_expanded, &b_gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel44<<<grid, block>>>(k, b_gpu_expanded);
        }
        bcoef = div_s32(i25 - i22, i24);
        k = h_cpu_y->size[0] * h_cpu_y->size[1];
        h_cpu_y->size[0] = 1;
        h_cpu_y->size[1] = div_s32(i25 - i22, i24) + 1;
        emxEnsureCapacity_int32_T(h_cpu_y, k, &h_emlrtRTEI);
        h_cpu_y->data[0] = 1;
        b_x = 1;
        for (k = 0; k < bcoef; k++) {
          b_x++;
          h_cpu_y->data[k + 1] = b_x;
        }
        k = cpu_iv3->size[0];
        cpu_iv3->size[0] = h_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv3, k, &g_emlrtRTEI);
        k = h_cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_int32_T(h_cpu_y, &e_gpu_y, false);
        gpuEmxEnsureCapacity_int32_T(cpu_iv3, &gpu_iv3, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&e_gpu_y, h_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel45<<<grid, block>>>(offsetH, e_gpu_y, k, gpu_iv3);
        }
        bcoef = cpu_iv3->size[0];
        mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel46<<<grid, block>>>(gpu_yc3, i24, i22, gpu_iv3,
                                                 bcoef - 1, b_gpu_expanded);
        }
        k = d_cpu_rows->size[0] * d_cpu_rows->size[1];
        d_cpu_rows->size[0] = 1;
        d_cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(d_cpu_rows, k, &h_emlrtRTEI);
        d_cpu_rows->data[0] = 0;
        b_x = 0;
        for (k = 0; k <= KH - 2; k++) {
          b_x++;
          d_cpu_rows->data[k + 1] = b_x;
        }
        k = d_cpu_convOut->size[0];
        d_cpu_convOut->size[0] = b_OH;
        emxEnsureCapacity_real32_T(d_cpu_convOut, k, &g_emlrtRTEI);
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
        if (j < 0) {
          j = 0;
        }
        mwApplyLaunchParameters(
            computeNumIters(b_OH - 1), dim3(window_idx_0, 1U, 1U),
            dim3(static_cast<uint32_T>(j), 1U, 1U), &grid, &block);
        gpuEmxEnsureCapacity_int32_T(d_cpu_rows, &b_gpu_rows, false);
        if (b_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(e_cpu_b, &e_gpu_b, true);
        }
        gpuEmxEnsureCapacity_real32_T(d_cpu_convOut, &b_gpu_convOut, true);
        convOut_needsGpuEnsureCapacity = false;
        gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_rows, d_cpu_rows);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel47<<<grid, block>>>(
              b_gpu_expanded, b_gpu_rows, e_gpu_b, b_OH - 1, b_gpu_convOut,
              e_cpu_b->size[0U]);
        }
        convOut_outdatedOnCpu = true;
        if (f_cpu_y->size[0] != 0) {
          if (f_cpu_y->size[0] == 1) {
            ec_filtfilt1_kernel48<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                b_gpu_y, b_gpu_convOut);
          } else {
            b_x = f_cpu_y->size[0];
            mwGetLaunchParameters1D(computeNumIters(b_x - 1), &grid, &block,
                                    2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_filtfilt1_kernel51<<<grid, block>>>(b_gpu_y, b_x - 1,
                                                     b_gpu_convOut);
            }
          }
        }
        b_x = div_s32(i25 - i22, i24) + e_cpu_a->size[0];
        for (KH = 0; KH < b_x; KH++) {
          bcoef = static_cast<int32_T>(
              std::fmin(static_cast<real_T>(KH) + 1.0,
                        static_cast<real_T>(e_cpu_a->size[0])));
          for (j = 0; j <= bcoef - 2; j++) {
            if (convOut_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_convOut, &b_gpu_convOut);
            }
            if (a_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_a, &f_gpu_a);
            }
            a_outdatedOnCpu = false;
            d_cpu_convOut->data[KH] -=
                d_cpu_convOut->data[(KH - j) - 1] * e_cpu_a->data[j + 1];
            convOut_outdatedOnCpu = false;
            d_convOut_outdatedOnGpu = true;
            y_outdatedOnCpu = true;
            convOut_needsGpuEnsureCapacity = true;
          }
        }
        if (static_cast<real_T>(div_s32(i25 - i22, i24) + 1) + 1.0 >
            d_cpu_convOut->size[0]) {
          b_x = 0;
          bcoef = 0;
        } else {
          b_x = div_s32(i25 - i22, i24) + 1;
          bcoef = d_cpu_convOut->size[0];
        }
        k = c_cpu_zfIIR->size[0];
        c_cpu_zfIIR->size[0] = bcoef - b_x;
        emxEnsureCapacity_real32_T(c_cpu_zfIIR, k, &f_emlrtRTEI);
        k = (bcoef - b_x) - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        if (convOut_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(d_cpu_convOut, &b_gpu_convOut,
                                        !d_convOut_outdatedOnGpu);
        }
        gpuEmxEnsureCapacity_real32_T(c_cpu_zfIIR, &gpu_zfIIR, true);
        if (d_convOut_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_convOut, d_cpu_convOut);
        }
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel49<<<grid, block>>>(b_gpu_convOut, b_x, k,
                                                 gpu_zfIIR);
        }
        b_x = e_cpu_a->size[0];
        mwGetLaunchParameters1D(computeNumIters(b_x - 3), &grid, &block,
                                2147483647U);
        if (y_outdatedOnCpu) {
          gpuEmxEnsureCapacity_real32_T(e_cpu_a, &f_gpu_a, true);
        }
        d_convOut_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel50<<<grid, block>>>(b_gpu_convOut, i24, i22, i25,
                                                 f_gpu_a, b_x - 3, gpu_zfIIR,
                                                 e_cpu_a->size[0U]);
        }
        k = c_cpu_zfIIR->size[0];
        c_cpu_zfIIR->size[0] = zfSize_idx_0;
        emxEnsureCapacity_real32_T(c_cpu_zfIIR, k, &f_emlrtRTEI);
      }
      //  outer product
      // 'ec_filtfilt1:140' yc5 = filter(b(:,ii),a(:,ii),yc2(end:-1:1,:),zo,1);
      if (d_cpu_y->size[0] < 1) {
        i22 = 1;
        i24 = 1;
        i25 = 0;
      } else {
        i22 = d_cpu_y->size[0];
        i24 = -1;
        i25 = 1;
      }
      k = f_cpu_b->size[0];
      f_cpu_b->size[0] = cpu_b->size[0];
      emxEnsureCapacity_real32_T(f_cpu_b, k, &e_emlrtRTEI);
      k = cpu_b->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      b_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_real32_T(f_cpu_b, &f_gpu_b, true);
      y_outdatedOnCpu = false;
      b_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel31<<<grid, block>>>(gpu_b, k, f_gpu_b);
      }
      k = f_cpu_a->size[0];
      f_cpu_a->size[0] = cpu_a->size[0];
      emxEnsureCapacity_real32_T(f_cpu_a, k, &e_emlrtRTEI);
      k = cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a, true);
      gpuEmxEnsureCapacity_real32_T(f_cpu_a, &g_gpu_a, true);
      a_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel32<<<grid, block>>>(gpu_a, k, g_gpu_a);
      }
      a_outdatedOnCpu = true;
      if ((!std::isinf(cpu_a->data[0])) && (!std::isnan(cpu_a->data[0])) &&
          (!(cpu_a->data[0] == 0.0F)) && (cpu_a->data[0] != 1.0F)) {
        mwGetLaunchParameters1D(computeNumIters(e_nb - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel33<<<grid, block>>>(gpu_a1, e_nb - 1, f_gpu_b);
        }
        mwGetLaunchParameters1D(computeNumIters(e_na - 2), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel34<<<grid, block>>>(gpu_a1, e_na - 2, g_gpu_a);
        }
        ec_filtfilt1_kernel35<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(g_gpu_a);
      }
      if (f_cpu_a->size[0] > f_cpu_b->size[0]) {
        b_x = f_cpu_a->size[0] - f_cpu_b->size[0];
        k = f_cpu_b->size[0];
        bcoef = f_cpu_b->size[0];
        f_cpu_b->size[0] = f_cpu_a->size[0];
        emxEnsureCapacity_real32_T(f_cpu_b, bcoef, &f_emlrtRTEI);
        y_outdatedOnCpu = true;
        if (b_x - 1 >= 0) {
          gpuEmxEnsureCapacity_real32_T(f_cpu_b, &f_gpu_b, true);
          y_outdatedOnCpu = false;
          cudaMemset(&f_gpu_b.data[k], 0,
                     static_cast<uint32_T>(b_x) * sizeof(real32_T));
        }
      }
      if (div_s32(i25 - i22, i24) + 1 == 0) {
        cpu_yc5->size[0] = 0;
      } else {
        window_idx_0 = static_cast<uint32_T>(f_cpu_b->size[0]);
        c_OH = (static_cast<real_T>(div_s32(i25 - i22, i24) + 1) +
                static_cast<real_T>(f_cpu_b->size[0])) -
               1.0;
        x = std::fmin(32.0, c_OH);
        blockDims_idx_0 = std::floor((c_OH + (x - 1.0)) / x);
        if (x >= -2.147483648E+9) {
          j = static_cast<int32_T>(x);
        } else {
          j = MIN_int32_T;
        }
        if (c_OH < 2.147483648E+9) {
          if (c_OH >= -2.147483648E+9) {
            b_OH = static_cast<int32_T>(c_OH);
          } else {
            b_OH = MIN_int32_T;
          }
        } else {
          b_OH = MAX_int32_T;
        }
        KH = f_cpu_b->size[0];
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(f_cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(f_cpu_b->size[0]) - 1.0) / 2.0));
        if ((b_OH < 0) && (f_cpu_b->size[0] < MIN_int32_T - b_OH)) {
          b_x = MIN_int32_T;
        } else if ((b_OH > 0) && (f_cpu_b->size[0] > MAX_int32_T - b_OH)) {
          b_x = MAX_int32_T;
        } else {
          b_x = b_OH + f_cpu_b->size[0];
        }
        if (b_x >= -2147483647) {
          b_x--;
        }
        k = e_cpu_expanded->size[0];
        e_cpu_expanded->size[0] = b_x;
        emxEnsureCapacity_real32_T(e_cpu_expanded, k, &g_emlrtRTEI);
        k = (b_OH + static_cast<int32_T>(window_idx_0)) - 2;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real32_T(e_cpu_expanded, &gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel37<<<grid, block>>>(k, gpu_expanded);
        }
        bcoef = div_s32(i25 - i22, i24);
        k = i_cpu_y->size[0] * i_cpu_y->size[1];
        i_cpu_y->size[0] = 1;
        i_cpu_y->size[1] = div_s32(i25 - i22, i24) + 1;
        emxEnsureCapacity_int32_T(i_cpu_y, k, &h_emlrtRTEI);
        i_cpu_y->data[0] = 1;
        b_x = 1;
        for (k = 0; k < bcoef; k++) {
          b_x++;
          i_cpu_y->data[k + 1] = b_x;
        }
        k = cpu_iv4->size[0];
        cpu_iv4->size[0] = i_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv4, k, &g_emlrtRTEI);
        k = i_cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_int32_T(i_cpu_y, &c_gpu_y, false);
        gpuEmxEnsureCapacity_int32_T(cpu_iv4, &gpu_iv4, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_y, i_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel38<<<grid, block>>>(offsetH, c_gpu_y, k, gpu_iv4);
        }
        bcoef = cpu_iv4->size[0];
        mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                                2147483647U);
        if (b_y_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(d_cpu_y, &d_gpu_y, true);
        }
        b_y_needsGpuEnsureCapacity = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel39<<<grid, block>>>(d_gpu_y, i24, i22, gpu_iv4,
                                                 bcoef - 1, gpu_expanded);
        }
        k = e_cpu_rows->size[0] * e_cpu_rows->size[1];
        e_cpu_rows->size[0] = 1;
        e_cpu_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(e_cpu_rows, k, &h_emlrtRTEI);
        e_cpu_rows->data[0] = 0;
        b_x = 0;
        for (k = 0; k <= KH - 2; k++) {
          b_x++;
          e_cpu_rows->data[k + 1] = b_x;
        }
        k = e_cpu_convOut->size[0];
        e_cpu_convOut->size[0] = b_OH;
        emxEnsureCapacity_real32_T(e_cpu_convOut, k, &g_emlrtRTEI);
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
        if (j < 0) {
          j = 0;
        }
        mwApplyLaunchParameters(
            computeNumIters(b_OH - 1), dim3(window_idx_0, 1U, 1U),
            dim3(static_cast<uint32_T>(j), 1U, 1U), &grid, &block);
        gpuEmxEnsureCapacity_int32_T(e_cpu_rows, &gpu_rows, false);
        if (y_outdatedOnCpu) {
          gpuEmxEnsureCapacity_real32_T(f_cpu_b, &f_gpu_b, true);
        }
        gpuEmxEnsureCapacity_real32_T(e_cpu_convOut, &gpu_convOut, true);
        convOut_needsGpuEnsureCapacity = false;
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, e_cpu_rows);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel40<<<grid, block>>>(gpu_expanded, gpu_rows,
                                                 f_gpu_b, b_OH - 1, gpu_convOut,
                                                 f_cpu_b->size[0U]);
        }
        convOut_outdatedOnCpu = true;
        if (c_cpu_zfIIR->size[0] != 0) {
          if (c_cpu_zfIIR->size[0] == 1) {
            gpuEmxEnsureCapacity_real32_T(c_cpu_zfIIR, &gpu_zfIIR, true);
            ec_filtfilt1_kernel41<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
                gpu_zfIIR, gpu_convOut);
          } else {
            b_x = c_cpu_zfIIR->size[0];
            mwGetLaunchParameters1D(computeNumIters(b_x - 1), &grid, &block,
                                    2147483647U);
            gpuEmxEnsureCapacity_real32_T(c_cpu_zfIIR, &gpu_zfIIR, true);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_filtfilt1_kernel43<<<grid, block>>>(gpu_zfIIR, b_x - 1,
                                                     gpu_convOut);
            }
          }
        }
        b_x = div_s32(i25 - i22, i24) + f_cpu_a->size[0];
        for (KH = 0; KH < b_x; KH++) {
          offsetH = static_cast<int32_T>(
              std::fmin(static_cast<real_T>(KH) + 1.0,
                        static_cast<real_T>(f_cpu_a->size[0])));
          for (j = 0; j <= offsetH - 2; j++) {
            if (convOut_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_convOut, &gpu_convOut);
            }
            if (a_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(f_cpu_a, &g_gpu_a);
            }
            a_outdatedOnCpu = false;
            e_cpu_convOut->data[KH] -=
                e_cpu_convOut->data[(KH - j) - 1] * f_cpu_a->data[j + 1];
            convOut_outdatedOnCpu = false;
            e_convOut_outdatedOnGpu = true;
            convOut_needsGpuEnsureCapacity = true;
          }
        }
        k = cpu_yc5->size[0];
        cpu_yc5->size[0] = div_s32(i25 - i22, i24) + 1;
        emxEnsureCapacity_real32_T(cpu_yc5, k, &j_emlrtRTEI);
        k = (i25 - i22) / i24;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        if (convOut_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(e_cpu_convOut, &gpu_convOut,
                                        !e_convOut_outdatedOnGpu);
        }
        gpuEmxEnsureCapacity_real32_T(cpu_yc5, &gpu_yc5, true);
        yc5_needsGpuEnsureCapacity = false;
        if (e_convOut_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_convOut, e_cpu_convOut);
        }
        e_convOut_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_filtfilt1_kernel42<<<grid, block>>>(gpu_convOut, k, gpu_yc5);
        }
      }
      // 'ec_filtfilt1:142' x = yc5(end:-1:1,:);
      if (cpu_yc5->size[0] < 1) {
        b_x = 0;
        bcoef = 1;
        offsetH = -1;
      } else {
        b_x = cpu_yc5->size[0] - 1;
        bcoef = -1;
        offsetH = 0;
      }
      k = cpu_fv->size[0];
      cpu_fv->size[0] = div_s32(offsetH - b_x, bcoef) + 1;
      emxEnsureCapacity_real32_T(cpu_fv, k, &e_emlrtRTEI);
      k = (offsetH - b_x) / bcoef;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      if (yc5_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_yc5, &gpu_yc5, true);
      }
      yc5_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_filtfilt1_kernel36<<<grid, block>>>(gpu_yc5, bcoef, b_x, k, gpu_fv);
      }
    }
    //  LocalWords:  x b a nf L
    //  LocalWords:  Lx th zi nfilt xc yc IIR nfact xt unreversed nullcopy Npts
    //  nb na yout LocalWords:  Nchans filtord designfilt noisysignals
    //  highpassiir Sanjit Mitra LocalWords:  nd Graw Fredrik Gustafsson
    bcoef = cpu_y->size[0];
    mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                            2147483647U);
    if (y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real32_T(cpu_y, &i_gpu_y, true);
    }
    y_needsGpuEnsureCapacity = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_filtfilt1_kernel76<<<grid, block>>>(
          gpu_fv, static_cast<int32_T>(static_cast<uint16_T>(ch + 1L)),
          bcoef - 1, i_gpu_y, cpu_y->size[0U]);
    }
    y_outdatedOnCpu = true;
  }
  emxFree_real32_T(&e_cpu_convOut);
  emxFree_int32_T(&e_cpu_rows);
  emxFree_real32_T(&c_cpu_zfIIR);
  emxFree_int32_T(&cpu_iv4);
  emxFree_int32_T(&i_cpu_y);
  emxFree_real32_T(&e_cpu_expanded);
  emxFree_real32_T(&d_cpu_convOut);
  emxFree_real32_T(&cpu_yc5);
  emxFree_int32_T(&d_cpu_rows);
  emxFree_int32_T(&cpu_iv3);
  emxFree_real32_T(&f_cpu_a);
  emxFree_int32_T(&h_cpu_y);
  emxFree_real32_T(&f_cpu_b);
  emxFree_real32_T(&d_cpu_expanded);
  emxFree_real32_T(&c_cpu_convOut);
  emxFree_int32_T(&c_cpu_rows);
  emxFree_int32_T(&cpu_iv2);
  emxFree_real32_T(&e_cpu_a);
  emxFree_real32_T(&e_cpu_b);
  emxFree_int32_T(&g_cpu_y);
  emxFree_real32_T(&f_cpu_y);
  emxFree_real32_T(&c_cpu_expanded);
  emxFree_real32_T(&b_cpu_zfIIR);
  emxFree_real32_T(&cpu_yc3);
  emxFree_real32_T(&b_cpu_convOut);
  emxFree_real32_T(&cpu_zfIIR);
  emxFree_real32_T(&d_cpu_a);
  emxFree_real32_T(&d_cpu_b);
  emxFree_int32_T(&b_cpu_rows);
  emxFree_int32_T(&cpu_iv1);
  emxFree_int32_T(&e_cpu_y);
  emxFree_real32_T(&b_cpu_expanded);
  emxFree_real32_T(&cpu_convOut);
  emxFree_int32_T(&cpu_rows);
  emxFree_real32_T(&d_cpu_y);
  emxFree_int32_T(&cpu_iv);
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
  if (y_outdatedOnCpu) {
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
  gpuEmxFree_real32_T(&c_gpu_a);
  gpuEmxFree_real32_T(&c_gpu_b);
  gpuEmxFree_real32_T(&d_gpu_a);
  gpuEmxFree_real32_T(&e_gpu_expanded);
  gpuEmxFree_int32_T(&h_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  checkCudaError(mwCudaFree(e_gpu_a1), __FILE__, __LINE__);
  gpuEmxFree_real32_T(&d_gpu_y);
  gpuEmxFree_int32_T(&e_gpu_rows);
  gpuEmxFree_real32_T(&e_gpu_convOut);
  checkCudaError(mwCudaFree(d_gpu_a1), __FILE__, __LINE__);
  gpuEmxFree_real32_T(&d_gpu_expanded);
  gpuEmxFree_int32_T(&g_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv1);
  checkCudaError(mwCudaFree(c_gpu_a1), __FILE__, __LINE__);
  gpuEmxFree_int32_T(&d_gpu_rows);
  gpuEmxFree_real32_T(&d_gpu_b);
  gpuEmxFree_real32_T(&e_gpu_a);
  checkCudaError(mwCudaFree(b_gpu_a1), __FILE__, __LINE__);
  gpuEmxFree_real32_T(&c_gpu_zfIIR);
  gpuEmxFree_real32_T(&d_gpu_convOut);
  gpuEmxFree_real32_T(&gpu_yc3);
  checkCudaError(mwCudaFree(gpu_a1), __FILE__, __LINE__);
  gpuEmxFree_real32_T(&b_gpu_zfIIR);
  gpuEmxFree_real32_T(&c_gpu_expanded);
  gpuEmxFree_real32_T(&b_gpu_y);
  gpuEmxFree_int32_T(&f_gpu_y);
  gpuEmxFree_real32_T(&e_gpu_b);
  gpuEmxFree_real32_T(&f_gpu_a);
  gpuEmxFree_int32_T(&gpu_iv2);
  gpuEmxFree_int32_T(&c_gpu_rows);
  gpuEmxFree_real32_T(&c_gpu_convOut);
  gpuEmxFree_real32_T(&b_gpu_expanded);
  gpuEmxFree_real32_T(&f_gpu_b);
  gpuEmxFree_int32_T(&e_gpu_y);
  gpuEmxFree_real32_T(&g_gpu_a);
  gpuEmxFree_int32_T(&gpu_iv3);
  gpuEmxFree_int32_T(&b_gpu_rows);
  gpuEmxFree_real32_T(&gpu_yc5);
  gpuEmxFree_real32_T(&b_gpu_convOut);
  gpuEmxFree_real32_T(&gpu_expanded);
  gpuEmxFree_int32_T(&c_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv4);
  gpuEmxFree_real32_T(&gpu_zfIIR);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_real32_T(&gpu_convOut);
  checkCudaError(mwCudaFree(b_gpu_a), __FILE__, __LINE__);
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
  try {
    emlrtPushHeapReferenceStackR2021a(emlrtRootTLSGlobal, false, nullptr,
                                      (void *)&emlrtExitTimeCleanupDtorFcn,
                                      nullptr, nullptr, nullptr);
    emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
    emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
    emlrtExitTimeCleanup(&emlrtContextGlobal);
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
}

void ec_filtfilt1_initialize()
{
  mex_InitInfAndNan();
  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
                          "EMLRT:runTime:MexFunctionNeedsLicense",
                          "distrib_computing_toolbox", 2);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
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
}

// End of code generation (ec_filtfilt1.cu)
