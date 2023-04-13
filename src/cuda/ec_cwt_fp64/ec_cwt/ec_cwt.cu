//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_cwt.cu
//
// Code generation for function 'ec_cwt'
//

// Include files
#include "ec_cwt.h"
#include "_coder_ec_cwt_mex.h"
#include "ec_cwt_types.h"
#include "rt_nonfinite.h"
#include "MWCUFFTPlanManager.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWMemoryManager.hpp"
#include "cufft.h"
#include "emlrt.h"
#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstring>

// Type Definitions
struct emxArray_char_T
{
  char_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct emxArray_creal_T
{
  creal_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{ nullptr };

emlrtContext emlrtContextGlobal{ true, // bFirstTime
  false,                               // bInitialized
  131642U,                             // fVersionInfo
  nullptr,                             // fErrorFunction
  "ec_cwt",                            // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 1075284325U, 2201364878U, 3488609979U, 1269018621U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtRTEInfo emlrtRTEI{ 95,     // lineNo
  22,                                  // colNo
  "sprintf",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtRTEInfo b_emlrtRTEI{ 986,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 987,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 988,  // lineNo
  21,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 988,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 273,  // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 445,  // lineNo
  20,                                  // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 446,  // lineNo
  21,                                  // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 28,   // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 28,   // lineNo
  1,                                   // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 486,  // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 18,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 60,   // lineNo
  20,                                  // colNo
  "bsxfun",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/bsxfun.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 63,   // lineNo
  17,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 43,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 946,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 30,   // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 30,   // lineNo
  1,                                   // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 25,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 32,   // lineNo
  24,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 63,   // lineNo
  57,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 64,   // lineNo
  28,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 31,   // lineNo
  23,                                  // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 35,  // lineNo
  21,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 498, // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 31,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 33,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 135, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 143, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "cuFFTNDCallback",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/cuFFTNDCallback.p"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 138, // lineNo
  19,                                  // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 138, // lineNo
  6,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 161, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 180, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 42,  // lineNo
  6,                                   // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 44,  // lineNo
  16,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 44,  // lineNo
  10,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 95,  // lineNo
  1,                                   // colNo
  "sprintf",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 1256,// lineNo
  30,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 1256,// lineNo
  25,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 1,   // lineNo
  23,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 924, // lineNo
  26,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 32,  // lineNo
  18,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 21,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 32,  // lineNo
  13,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 32,  // lineNo
  18,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 445, // lineNo
  1,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 446, // lineNo
  1,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 63,  // lineNo
  20,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 63,  // lineNo
  34,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 151, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 63,  // lineNo
  16,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 63,  // lineNo
  60,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 42,  // lineNo
  12,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 64,  // lineNo
  12,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 64,  // lineNo
  31,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "_coder_ec_cwt_api",                 // fName
  ""                                   // pName
};

static char_T (*cpu_cv_gpu_clone)[128];
static boolean_T gpuConstsCopied_ec_cwt;

// Function Declarations
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static real_T (*b_emlrt_marshallIn(const mxArray *fLims, const char_T
  *identifier))[2];
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2];
static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4);
static void c_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static real_T (*d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2];
static int32_T div_s32(int32_T numerator, int32_T denominator);
static __global__ void ec_cwt_kernel1(const real_T fLims[2], boolean_T b[2]);
static __global__ void ec_cwt_kernel10(const emxArray_real_T x, int32_T bcoef,
  emxArray_real_T y);
static __global__ void ec_cwt_kernel11(const emxArray_real_T x, int32_T bcoef,
  emxArray_real_T y);
static __global__ void ec_cwt_kernel12(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ec_cwt_kernel13(const emxArray_real_T a, int32_T bcoef,
  emxArray_real_T dv4);
static __global__ void ec_cwt_kernel14(const emxArray_real_T x, int32_T bcoef,
  emxArray_real_T y);
static __global__ void ec_cwt_kernel15(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv8);
static __global__ void ec_cwt_kernel16(const emxArray_real_T xt, const
  emxArray_real_T dv8, const emxArray_real_T dv4, int32_T b_dv4, emxArray_real_T
  fx);
static __global__ void ec_cwt_kernel17(int16_T dv3_idx_1, emxArray_real_T fx);
static __global__ void ec_cwt_kernel18(real_T interval[650]);
static __global__ void ec_cwt_kernel19(real_T interval[650]);
static __global__ void ec_cwt_kernel2(const real_T fLims[2], real_T freqrange[2]);
static __global__ void ec_cwt_kernel20(const int32_T bcoef, real_T interval[650]);
static __global__ void ec_cwt_kernel21(const real_T interval[650], int32_T nsubs,
  real_T subs[1298]);
static __global__ void ec_cwt_kernel22(const emxArray_real_T x, int32_T nbytes,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ec_cwt_kernel23(const emxArray_real_T x, int32_T bcoef,
  emxArray_real_T dv11);
static __global__ void ec_cwt_kernel24(const emxArray_real_T x, int32_T bcoef,
  emxArray_real_T y);
static __global__ void ec_cwt_kernel25(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv13);
static __global__ void ec_cwt_kernel26(const emxArray_real_T xt, const
  emxArray_real_T dv13, const emxArray_real_T dv11, int32_T b_dv11,
  emxArray_real_T fx);
static __global__ void ec_cwt_kernel27(int16_T dv3_idx_1, emxArray_real_T fx);
static __global__ void ec_cwt_kernel28(const real_T r, real_T freqrange[2],
  real_T fLims[2]);
static __global__ void ec_cwt_kernel29(const real_T fs, real_T freqrange[2],
  real_T fLims[2]);
static __global__ void ec_cwt_kernel3(const real_T fs, real_T NyquistRange[2]);
static __global__ void ec_cwt_kernel30(int32_T nbytes, emxArray_real_T omega);
static __global__ void ec_cwt_kernel31(const uint32_T N, int32_T i,
  emxArray_real_T omega);
static __global__ void ec_cwt_kernel32(emxArray_real_T r);
static __global__ void ec_cwt_kernel33(const emxArray_real_T omega, int32_T j,
  emxArray_real_T r);
static __global__ void ec_cwt_kernel34(const int32_T nbytes, const int32_T nsubs,
  const emxArray_real_T omega, int32_T j, emxArray_real_T r, int32_T omega_dim1);
static __global__ void ec_cwt_kernel35(const emxArray_real_T r, int32_T b_r,
  emxArray_real_T omega);
static __global__ void ec_cwt_kernel36(const real_T fLims[2], boolean_T b[2]);
static __global__ void ec_cwt_kernel37(const char_T cv[128], char_T wav[5],
  char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4);
static __global__ void ec_cwt_kernel38(real_T interval[650]);
static __global__ void ec_cwt_kernel39(real_T interval[650]);
static __global__ void ec_cwt_kernel4(const char_T cv[128], char_T wav[5],
  char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4);
static __global__ void ec_cwt_kernel40(const int32_T bcoef, real_T interval[650]);
static __global__ void ec_cwt_kernel41(const real_T interval[650], int32_T nsubs,
  real_T subs[1298]);
static __global__ void ec_cwt_kernel42(const emxArray_real_T x, int32_T nbytes,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ec_cwt_kernel43(const emxArray_real_T x, int32_T bcoef,
  emxArray_real_T y);
static __global__ void ec_cwt_kernel44(const emxArray_real_T x, int32_T bcoef,
  emxArray_real_T y);
static __global__ void ec_cwt_kernel45(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ec_cwt_kernel46(const emxArray_real_T a, int32_T bcoef,
  emxArray_real_T dv12);
static __global__ void ec_cwt_kernel47(const emxArray_real_T x, int32_T bcoef,
  emxArray_real_T y);
static __global__ void ec_cwt_kernel48(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv14);
static __global__ void ec_cwt_kernel49(const emxArray_real_T xt, const
  emxArray_real_T dv14, const emxArray_real_T dv12, int32_T b_dv12,
  emxArray_real_T fx);
static __global__ void ec_cwt_kernel5(real_T interval[650]);
static __global__ void ec_cwt_kernel50(int16_T dv3_idx_1, emxArray_real_T fx);
static __global__ void ec_cwt_kernel51(real_T interval[650]);
static __global__ void ec_cwt_kernel52(real_T interval[650]);
static __global__ void ec_cwt_kernel53(const int32_T bcoef, real_T interval[650]);
static __global__ void ec_cwt_kernel54(const real_T interval[650], int32_T nsubs,
  real_T subs[1298]);
static __global__ void ec_cwt_kernel55(const emxArray_real_T x, int32_T nbytes,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ec_cwt_kernel56(const emxArray_real_T x, int32_T bcoef,
  emxArray_real_T dv16);
static __global__ void ec_cwt_kernel57(const emxArray_real_T x, int32_T bcoef,
  emxArray_real_T y);
static __global__ void ec_cwt_kernel58(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv17);
static __global__ void ec_cwt_kernel59(const emxArray_real_T xt, const
  emxArray_real_T dv17, const emxArray_real_T dv16, int32_T b_dv16,
  emxArray_real_T fx);
static __global__ void ec_cwt_kernel6(real_T interval[650]);
static __global__ void ec_cwt_kernel60(int16_T dv3_idx_1, emxArray_real_T fx);
static __global__ void ec_cwt_kernel61(real_T r, emxArray_real_T y);
static __global__ void ec_cwt_kernel62(const emxArray_real_T y, const real_T r,
  int32_T bcoef, emxArray_real_T b_y);
static __global__ void ec_cwt_kernel63(const emxArray_real_T y, const real_T
  halfh, int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ec_cwt_kernel64(const real_T fs, const real_T fLims[2],
  real_T NyquistRange[2]);
static __global__ void ec_cwt_kernel65(real_T r, emxArray_real_T y);
static __global__ void ec_cwt_kernel66(const emxArray_real_T y, const real_T tol,
  int32_T bcoef, emxArray_real_T b_y);
static __global__ void ec_cwt_kernel67(const emxArray_real_T y, const real_T
  halfh, int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ec_cwt_kernel68(int32_T fb_Scales, emxArray_real_T psidft);
static __global__ void ec_cwt_kernel69(const emxArray_real_T fb_Scales, int32_T
  b_fb_Scales, emxArray_real_T f);
static __global__ void ec_cwt_kernel7(const int32_T bcoef, real_T interval[650]);
static __global__ void ec_cwt_kernel70(const emxArray_real_T omega, const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, int32_T j,
  emxArray_real_T somega, int32_T somega_dim0);
static __global__ void ec_cwt_kernel71(const emxArray_real_T somega, int32_T
  bcoef, emxArray_real_T absomega);
static __global__ void ec_cwt_kernel72(const emxArray_real_T absomega, int32_T
  b_absomega, emxArray_real_T powscales);
static __global__ void ec_cwt_kernel73(int32_T bcoef, emxArray_real_T absomega);
static __global__ void ec_cwt_kernel74(const emxArray_real_T powscales, const
  emxArray_real_T absomega, int32_T b_absomega, emxArray_real_T x);
static __global__ void ec_cwt_kernel75(int32_T bcoef, emxArray_real_T x);
static __global__ void ec_cwt_kernel76(const emxArray_real_T somega, const
  emxArray_real_T x, int32_T b_x, emxArray_real_T psidft);
static __global__ void ec_cwt_kernel77(const emxArray_real_T fb_Scales, int32_T
  b_fb_Scales, emxArray_real_T f);
static __global__ void ec_cwt_kernel78(const real_T fs, int32_T i,
  emxArray_real_T f);
static __global__ void ec_cwt_kernel79(const emxArray_real_T f, int32_T b_f,
  emxArray_real_T freqs);
static __global__ void ec_cwt_kernel8(const real_T interval[650], int32_T nsubs,
  real_T subs[1298]);
static __global__ void ec_cwt_kernel80(const real_T ds2, int32_T i,
  emxArray_real_T dv1);
static __global__ void ec_cwt_kernel81(const int32_T k, const emxArray_real_T x,
  int32_T b_x, emxArray_real_T xv, int32_T x_dim0);
static __global__ void ec_cwt_kernel82(const int32_T k, const emxArray_real_T x,
  int32_T fb_SignalPad, emxArray_real_T b_x, int32_T x_dim0);
static __global__ void ec_cwt_kernel83(const emxArray_real_T x, int32_T j,
  emxArray_real_T xv);
static __global__ void ec_cwt_kernel84(const emxArray_real_T xv, int32_T b_xv,
  emxArray_creal_T xposdft);
static __global__ void ec_cwt_kernel85(const emxArray_creal_T xposdft, const
  emxArray_real_T psidft, const int32_T bcoef, const int32_T cfsposdft, int32_T
  nbytes, emxArray_creal_T b_cfsposdft, int32_T psidft_dim0, int32_T
  cfsposdft_dim0);
static __global__ void ec_cwt_kernel86(const real_T cfsposdft_re, const
  emxArray_creal_T cfsposdft, int32_T b_cfsposdft, emxArray_creal_T cfspos);
static __global__ void ec_cwt_kernel87(uint32_T xSize[2], int32_T cfsposdft_dim1);
static __global__ void ec_cwt_kernel88(int32_T xSize, emxArray_creal_T cfspos);
static __global__ void ec_cwt_kernel89(const emxArray_creal_T cfspos, int32_T
  bcoef, emxArray_real_T y);
static __global__ void ec_cwt_kernel9(const emxArray_real_T x, int32_T nbytes,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ec_cwt_kernel90(const emxArray_real_T y, const int32_T
  b_y, int32_T c_y, emxArray_real_T xCh, int32_T xCh_dim0, int32_T y_dim0);
static __global__ void ec_cwt_kernel91(const emxArray_real_T xCh, const int32_T
  nbytes, const int32_T bcoef, int32_T k, emxArray_real_T b_xCh, int32_T
  xCh_dim0, int32_T b_xCh_dim0);
static __global__ void ec_cwt_kernel92(const emxArray_real_T xCh, int32_T b_xCh,
  emxArray_real_T c_xCh);
static __global__ void ec_cwt_kernel93(const emxArray_real_T xCh, const int32_T
  xx_dim0, const int32_T k, const int32_T xx, int32_T b_xx, emxArray_real_T c_xx,
  int32_T b_xx_dim0, int32_T xx_dim1);
static void ec_cwt_once();
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static real_T emlrt_marshallIn(const mxArray *fs, const char_T *identifier);
static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_creal_T(emxArray_creal_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxFree_char_T(emxArray_char_T **pEmxArray);
static void emxFree_creal_T(emxArray_creal_T **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_creal_T(emxArray_creal_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
  emxArray_creal_T *gpu);
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu);
static void gpuEmxFree_creal_T(emxArray_creal_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
static void gpuEmxMemcpyCpuToGpu_creal_T(emxArray_creal_T *gpu, const
  emxArray_creal_T *cpu);
static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu, const
  emxArray_real_T *cpu);
static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu, emxArray_creal_T
  *gpu);
static void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T
  *gpu);
static void gpuEmxReset_creal_T(emxArray_creal_T *gpu);
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static real_T rt_powd_snf(real_T u0, real_T u1);

// Function Definitions
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3)
{
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_0_1;
  int32_T stride_1_0;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  if (in3->size[0] == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3->size[0];
  }

  if (in3->size[1] == 1) {
    in1->size[1] = in2->size[1];
  } else {
    in1->size[1] = in3->size[1];
  }

  emxEnsureCapacity_real_T(in1, i, &y_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_0 = (in3->size[0] != 1);
  stride_1_1 = (in3->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (in3->size[1] == 1) {
    b = in2->size[1];
  } else {
    b = in3->size[1];
  }

  for (i = 0; i < b; i++) {
    int32_T c;
    if (in3->size[0] == 1) {
      c = in2->size[0];
    } else {
      c = in3->size[0];
    }

    for (int32_T i1{0}; i1 < c; i1++) {
      in1->data[i1 + in1->size[0] * i] = 20.0 * in2->data[i1 * stride_0_0 +
        in2->size[0] * aux_0_1] - in3->data[i1 * stride_1_0 + in3->size[0] *
        aux_1_1];
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2]{ -1, -1 };

  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{ true, true };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  ret->data = static_cast<real_T *>(emlrtMxGetData(src));
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static real_T (*b_emlrt_marshallIn(const mxArray *fLims, const char_T
  *identifier))[2]
{
  emlrtMsgIdentifier thisId;
  real_T (*y)[2];
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(fLims), &thisId);
  emlrtDestroyArray(&fLims);
  return y;
}
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
*parentId))[2]
{
  real_T (*y)[2];
  y = d_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u)
{
  static const int32_T iv[1]{ 0 };

  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(1, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 1);
  emlrtAssign(&y, m);
  return y;
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4)
{
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  in1->size[1] = in4->size[1];
  emxEnsureCapacity_real_T(in1, i, &bb_emlrtRTEI);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_1 = (in3->size[1] != 1);
  for (i = 0; i < in4->size[1]; i++) {
    in1->data[i] = in2->data[i * stride_0_1] * in3->data[i * stride_1_1] *
      in4->data[i];
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3)
{
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_0_1;
  int32_T stride_1_0;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  if (in3->size[0] == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3->size[0];
  }

  if (in3->size[1] == 1) {
    in1->size[1] = in2->size[1];
  } else {
    in1->size[1] = in3->size[1];
  }

  emxEnsureCapacity_real_T(in1, i, &cb_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_0 = (in3->size[0] != 1);
  stride_1_1 = (in3->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (in3->size[1] == 1) {
    b = in2->size[1];
  } else {
    b = in3->size[1];
  }

  for (i = 0; i < b; i++) {
    int32_T c;
    if (in3->size[0] == 1) {
      c = in2->size[0];
    } else {
      c = in3->size[0];
    }

    for (int32_T i1{0}; i1 < c; i1++) {
      in1->data[i1 + in1->size[0] * i] = 0.0050536085896138528 * in2->data[i1 *
        stride_0_0 + in2->size[0] * aux_0_1] * static_cast<real_T>(in3->data[i1 *
        stride_1_0 + in3->size[0] * aux_1_1] > 0.0);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void c_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  if (in3->size[1] == 1) {
    in1->size[1] = in2->size[1];
  } else {
    in1->size[1] = in3->size[1];
  }

  emxEnsureCapacity_real_T(in1, i, &p_emlrtRTEI);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_1 = (in3->size[1] != 1);
  if (in3->size[1] == 1) {
    b = in2->size[1];
  } else {
    b = in3->size[1];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = 20.0 * in2->data[i * stride_0_1] - 3.0 * in3->data[i *
      stride_1_1];
  }
}

static real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId)
{
  static const int32_T dims{ 0 };

  real_T ret;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 0U, (
    const void *)&dims);
  ret = *static_cast<real_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret;
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

static real_T (*d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2]
{
  static const int32_T dims[2]{ 1, 2 };

  real_T (*ret)[2];
  int32_T iv[2];
  boolean_T bv[2]{ false, false };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    (const void *)&dims[0], &bv[0], &iv[0]);
  ret = (real_T (*)[2])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
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

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel1(const real_T
  fLims[2], boolean_T b[2])
{
  uint64_T threadId;
  int32_T varargin_3;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_3 = static_cast<int32_T>(threadId);
  if (varargin_3 < 2) {
    b[varargin_3] = isnan(fLims[varargin_3]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel10(const
  emxArray_real_T x, int32_T bcoef, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 19.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel11(const
  emxArray_real_T x, int32_T bcoef, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel12(const
  emxArray_real_T y, const emxArray_real_T b_y, int32_T c_y, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    a.data[varargin_3] = 20.0 * b_y.data[varargin_3] - 3.0 * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel13(const
  emxArray_real_T a, int32_T bcoef, emxArray_real_T dv4)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    int32_T k;
    k = static_cast<int32_T>(idx);
    ar = a.data[k];
    dv4.data[k] = ar * ar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel14(const
  emxArray_real_T x, int32_T bcoef, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel15(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv8)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv8.data[k] = exp(-2.0 * y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel16(const
  emxArray_real_T xt, const emxArray_real_T dv8, const emxArray_real_T dv4,
  int32_T b_dv4, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv4);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv4.data[varargin_3] * dv8.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel17(int16_T
  dv3_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv3_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel18(real_T interval
  [650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(512, 1) void ec_cwt_kernel19(real_T
  interval[650])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel2(const real_T
  fLims[2], real_T freqrange[2])
{
  uint64_T threadId;
  int32_T varargin_3;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_3 = static_cast<int32_T>(threadId);
  if (varargin_3 < 2) {
    freqrange[varargin_3] = fLims[varargin_3];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel20(const int32_T
  bcoef, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel21(const real_T
  interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel22(const
  emxArray_real_T x, int32_T nbytes, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    ar = x.data[k];
    tkd1mtk = ar / (1.0 - ar);
    b_x.data[k] = tkd1mtk * tkd1mtk;
    xt.data[k] = 2.0 * tkd1mtk / ((1.0 - ar) * (1.0 - ar));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel23(const
  emxArray_real_T x, int32_T bcoef, emxArray_real_T dv11)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv11.data[k] = pow(x.data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel24(const
  emxArray_real_T x, int32_T bcoef, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel25(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv13)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv13.data[k] = exp(-2.0 * y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel26(const
  emxArray_real_T xt, const emxArray_real_T dv13, const emxArray_real_T dv11,
  int32_T b_dv11, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv11);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv11.data[varargin_3] * dv13.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel27(int16_T
  dv3_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv3_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel28(const real_T r,
  real_T freqrange[2], real_T fLims[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fLims[0] = r;
    freqrange[0] = r;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel29(const real_T fs,
  real_T freqrange[2], real_T fLims[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fLims[1] = fs / 2.0;
    freqrange[1] = fLims[1];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel3(const real_T fs,
  real_T NyquistRange[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    NyquistRange[1] = fs / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel30(int32_T nbytes,
  emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    omega.data[varargin_3] = static_cast<real_T>(varargin_3) + 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel31(const uint32_T
  N, int32_T i, emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    omega.data[varargin_3] = omega.data[varargin_3] * 6.2831853071795862 /
      static_cast<real_T>(N);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel32(emxArray_real_T
  r)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    r.data[0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel33(const
  emxArray_real_T omega, int32_T j, emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(j) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    r.data[varargin_3 + 1] = omega.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel34(const int32_T
  nbytes, const int32_T nsubs, const emxArray_real_T omega, int32_T j,
  emxArray_real_T r, int32_T omega_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(j);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    r.data[(varargin_3 + omega_dim1) + 1] = -omega.data[nsubs + nbytes *
      varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel35(const
  emxArray_real_T r, int32_T b_r, emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_r);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    omega.data[varargin_3] = r.data[varargin_3];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel36(const real_T
  fLims[2], boolean_T b[2])
{
  uint64_T threadId;
  int32_T varargin_3;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_3 = static_cast<int32_T>(threadId);
  if (varargin_3 < 2) {
    b[varargin_3] = isnan(fLims[varargin_3]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel37(const char_T cv
  [128], char_T wav[5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T
  b_dim3, char_T b_dim4)
{
  __shared__ char_T b_shared[5];
  uint64_T threadId;
  int32_T k;
  if (mwGetThreadIndexWithinBlock() == 0) {
    b_shared[0] = b_dim0;
    b_shared[1] = b_dim1;
    b_shared[2] = b_dim2;
    b_shared[3] = b_dim3;
    b_shared[4] = b_dim4;
  }

  __syncthreads();
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 5) {
    wav[k] = cv[static_cast<int32_T>(b_shared[k])];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel38(real_T interval
  [650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(512, 1) void ec_cwt_kernel39(real_T
  interval[650])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel4(const char_T cv
  [128], char_T wav[5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T
  b_dim3, char_T b_dim4)
{
  __shared__ char_T b_shared[5];
  uint64_T threadId;
  int32_T k;
  if (mwGetThreadIndexWithinBlock() == 0) {
    b_shared[0] = b_dim0;
    b_shared[1] = b_dim1;
    b_shared[2] = b_dim2;
    b_shared[3] = b_dim3;
    b_shared[4] = b_dim4;
  }

  __syncthreads();
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 5) {
    wav[k] = cv[static_cast<int32_T>(b_shared[k])];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel40(const int32_T
  bcoef, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel41(const real_T
  interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel42(const
  emxArray_real_T x, int32_T nbytes, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    ar = x.data[k];
    tkd1mtk = ar / (1.0 - ar);
    b_x.data[k] = tkd1mtk * tkd1mtk;
    xt.data[k] = 2.0 * tkd1mtk / ((1.0 - ar) * (1.0 - ar));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel43(const
  emxArray_real_T x, int32_T bcoef, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 19.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel44(const
  emxArray_real_T x, int32_T bcoef, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel45(const
  emxArray_real_T y, const emxArray_real_T b_y, int32_T c_y, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    a.data[varargin_3] = 20.0 * b_y.data[varargin_3] - 3.0 * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel46(const
  emxArray_real_T a, int32_T bcoef, emxArray_real_T dv12)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    int32_T k;
    k = static_cast<int32_T>(idx);
    ar = a.data[k];
    dv12.data[k] = ar * ar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel47(const
  emxArray_real_T x, int32_T bcoef, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel48(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv14)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv14.data[k] = exp(-2.0 * y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel49(const
  emxArray_real_T xt, const emxArray_real_T dv14, const emxArray_real_T dv12,
  int32_T b_dv12, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv12.data[varargin_3] * dv14.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel5(real_T interval
  [650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel50(int16_T
  dv3_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv3_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel51(real_T interval
  [650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(512, 1) void ec_cwt_kernel52(real_T
  interval[650])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel53(const int32_T
  bcoef, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel54(const real_T
  interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel55(const
  emxArray_real_T x, int32_T nbytes, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    ar = x.data[k];
    tkd1mtk = ar / (1.0 - ar);
    b_x.data[k] = tkd1mtk * tkd1mtk;
    xt.data[k] = 2.0 * tkd1mtk / ((1.0 - ar) * (1.0 - ar));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel56(const
  emxArray_real_T x, int32_T bcoef, emxArray_real_T dv16)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv16.data[k] = pow(x.data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel57(const
  emxArray_real_T x, int32_T bcoef, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel58(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv17)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv17.data[k] = exp(-2.0 * y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel59(const
  emxArray_real_T xt, const emxArray_real_T dv17, const emxArray_real_T dv16,
  int32_T b_dv16, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv16);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv16.data[varargin_3] * dv17.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(512, 1) void ec_cwt_kernel6(real_T interval
  [650])
{
  uint64_T threadId;
  int32_T k;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  k = static_cast<int32_T>(threadId);
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel60(int16_T
  dv3_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv3_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel61(real_T r,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(r);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    y.data[varargin_3] = static_cast<real_T>(varargin_3);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel62(const
  emxArray_real_T y, const real_T r, int32_T bcoef, emxArray_real_T b_y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b_y.data[k] = pow(r, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel63(const
  emxArray_real_T y, const real_T halfh, int32_T b_y, emxArray_real_T fb_Scales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fb_Scales.data[varargin_3] = halfh * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel64(const real_T fs,
  const real_T fLims[2], real_T NyquistRange[2])
{
  uint64_T threadId;
  int32_T varargin_3;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_3 = static_cast<int32_T>(threadId);
  if (varargin_3 < 2) {
    NyquistRange[varargin_3] = fLims[varargin_3] / fs * 2.0 * 3.1415926535897931;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel65(real_T r,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(r);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    y.data[varargin_3] = static_cast<real_T>(varargin_3);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel66(const
  emxArray_real_T y, const real_T tol, int32_T bcoef, emxArray_real_T b_y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b_y.data[k] = pow(tol, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel67(const
  emxArray_real_T y, const real_T halfh, int32_T b_y, emxArray_real_T fb_Scales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fb_Scales.data[varargin_3] = halfh * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel68(int32_T
  fb_Scales, emxArray_real_T psidft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    psidft.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel69(const
  emxArray_real_T fb_Scales, int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    f.data[varargin_3] = 0.0 / fb_Scales.data[varargin_3];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel7(const int32_T
  bcoef, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel70(const
  emxArray_real_T omega, const emxArray_real_T fb_Scales, const int32_T
  b_fb_Scales, int32_T j, emxArray_real_T somega, int32_T somega_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_fb_Scales) + 1UL) * static_cast<uint64_T>(j)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T varargin_3;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fb_Scales) + 1UL));
    varargin_3 = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) / (
      static_cast<uint64_T>(b_fb_Scales) + 1UL));
    somega.data[bcoef + somega_dim0 * varargin_3] = fb_Scales.data[bcoef] *
      omega.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel71(const
  emxArray_real_T somega, int32_T bcoef, emxArray_real_T absomega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absomega.data[k] = fabs(somega.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel72(const
  emxArray_real_T absomega, int32_T b_absomega, emxArray_real_T powscales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_absomega);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    powscales.data[varargin_3] = absomega.data[varargin_3] *
      absomega.data[varargin_3] * absomega.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel73(int32_T bcoef,
  emxArray_real_T absomega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absomega.data[k] = log(absomega.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel74(const
  emxArray_real_T powscales, const emxArray_real_T absomega, int32_T b_absomega,
  emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_absomega);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    x.data[varargin_3] = 20.0 * absomega.data[varargin_3] -
      powscales.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel75(int32_T bcoef,
  emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    x.data[k] = exp(x.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel76(const
  emxArray_real_T somega, const emxArray_real_T x, int32_T b_x, emxArray_real_T
  psidft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    psidft.data[varargin_3] = 0.0050536085896138528 * x.data[varargin_3] *
      static_cast<real_T>(somega.data[varargin_3] > 0.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel77(const
  emxArray_real_T fb_Scales, int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    f.data[varargin_3] = 1.8820720577620569 / fb_Scales.data[varargin_3] /
      6.2831853071795862;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel78(const real_T
  fs, int32_T i, emxArray_real_T f)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    f.data[varargin_3] *= fs;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel79(const
  emxArray_real_T f, int32_T b_f, emxArray_real_T freqs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_f);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    freqs.data[varargin_3] = f.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel8(const real_T
  interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel80(const real_T
  ds2, int32_T i, emxArray_real_T dv1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((static_cast<real_T>(i) - 1.0) / ds2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    dv1.data[varargin_3] = ds2 * static_cast<real_T>(varargin_3) + 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel81(const int32_T
  k, const emxArray_real_T x, int32_T b_x, emxArray_real_T xv, int32_T x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    xv.data[varargin_3] = x.data[varargin_3 + x_dim0 * (k - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel82(const int32_T
  k, const emxArray_real_T x, int32_T fb_SignalPad, emxArray_real_T b_x, int32_T
  x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fb_SignalPad) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    b_x.data[varargin_3] = x.data[varargin_3 + x_dim0 * (k - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel83(const
  emxArray_real_T x, int32_T j, emxArray_real_T xv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(j) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    xv.data[varargin_3] = x.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel84(const
  emxArray_real_T xv, int32_T b_xv, emxArray_creal_T xposdft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xv);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    xposdft.data[varargin_3].re = xv.data[varargin_3];
    xposdft.data[varargin_3].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel85(const
  emxArray_creal_T xposdft, const emxArray_real_T psidft, const int32_T bcoef,
  const int32_T cfsposdft, int32_T nbytes, emxArray_creal_T b_cfsposdft, int32_T
  psidft_dim0, int32_T cfsposdft_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(cfsposdft) + 1UL) * (static_cast<uint64_T>
    (nbytes) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_bcoef;
    int32_T b_k;
    int32_T k;
    int32_T varargin_3;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(cfsposdft) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) /
      (static_cast<uint64_T>(cfsposdft) + 1UL));
    varargin_3 = bcoef * k + 1;
    b_bcoef = static_cast<int32_T>(psidft_dim0 != 1);
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].re = psidft.data[b_bcoef * b_k +
      psidft_dim0 * (varargin_3 - 1)] * xposdft.data[k].re;
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].im = psidft.data[b_bcoef * b_k +
      psidft_dim0 * (varargin_3 - 1)] * xposdft.data[k].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel86(const real_T
  cfsposdft_re, const emxArray_creal_T cfsposdft, int32_T b_cfsposdft,
  emxArray_creal_T cfspos)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfsposdft);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    real_T tkd1mtk;
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    ar = cfsposdft.data[varargin_3].re;
    tkd1mtk = cfsposdft.data[varargin_3].im;
    if (tkd1mtk == 0.0) {
      cfspos.data[varargin_3].re = ar / cfsposdft_re;
      cfspos.data[varargin_3].im = 0.0;
    } else if (ar == 0.0) {
      cfspos.data[varargin_3].re = 0.0;
      cfspos.data[varargin_3].im = tkd1mtk / cfsposdft_re;
    } else {
      cfspos.data[varargin_3].re = ar / cfsposdft_re;
      cfspos.data[varargin_3].im = tkd1mtk / cfsposdft_re;
    }
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel87(uint32_T xSize[2],
  int32_T cfsposdft_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    xSize[1] = static_cast<uint32_T>(cfsposdft_dim1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel88(int32_T xSize,
  emxArray_creal_T cfspos)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xSize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    cfspos.data[varargin_3].re = 0.0;
    cfspos.data[varargin_3].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel89(const
  emxArray_creal_T cfspos, int32_T bcoef, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(bcoef) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = hypot(cfspos.data[k].re, cfspos.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel9(const
  emxArray_real_T x, int32_T nbytes, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    ar = x.data[k];
    tkd1mtk = ar / (1.0 - ar);
    b_x.data[k] = tkd1mtk * tkd1mtk;
    xt.data[k] = 2.0 * tkd1mtk / ((1.0 - ar) * (1.0 - ar));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel90(const
  emxArray_real_T y, const int32_T b_y, int32_T c_y, emxArray_real_T xCh,
  int32_T xCh_dim0, int32_T y_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>(c_y) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T varargin_3;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    varargin_3 = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) / (
      static_cast<uint64_T>(b_y) + 1UL));
    xCh.data[bcoef + xCh_dim0 * varargin_3] = y.data[varargin_3 + y_dim0 * bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel91(const
  emxArray_real_T xCh, const int32_T nbytes, const int32_T bcoef, int32_T k,
  emxArray_real_T b_xCh, int32_T xCh_dim0, int32_T b_xCh_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(bcoef / nbytes) + 1UL) * static_cast<uint64_T>
    (k) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_bcoef;
    int32_T varargin_3;
    b_bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(bcoef / nbytes)
      + 1UL));
    varargin_3 = static_cast<int32_T>((idx - static_cast<uint64_T>(b_bcoef)) / (
      static_cast<uint64_T>(bcoef / nbytes) + 1UL));
    b_xCh.data[b_bcoef + xCh_dim0 * varargin_3] = xCh.data[nbytes * b_bcoef +
      b_xCh_dim0 * varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel92(const
  emxArray_real_T xCh, int32_T b_xCh, emxArray_real_T c_xCh)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xCh);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    c_xCh.data[varargin_3] = xCh.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel93(const
  emxArray_real_T xCh, const int32_T xx_dim0, const int32_T k, const int32_T xx,
  int32_T b_xx, emxArray_real_T c_xx, int32_T b_xx_dim0, int32_T xx_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(xx) + 1UL) * (static_cast<uint64_T>(b_xx) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T varargin_3;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(xx) + 1UL));
    varargin_3 = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) / (
      static_cast<uint64_T>(xx) + 1UL));
    c_xx.data[(bcoef + b_xx_dim0 * (k - 1)) + b_xx_dim0 * xx_dim1 * varargin_3] =
      xCh.data[bcoef + xx_dim0 * varargin_3];
  }
}

static void ec_cwt_once()
{
  mwMemoryManagerInit(256U, 2U, 8U, 2048U);
  mwCudaMalloc(&cpu_cv_gpu_clone, sizeof(char_T [128]));
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T emlrt_marshallIn(const mxArray *fs, const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(fs), &thisId);
  emlrtDestroyArray(&fs);
  return y;
}

static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = c_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(x), &thisId, y);
  emlrtDestroyArray(&x);
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  static const int32_T iv[3]{ 0, 0, 0 };

  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(3, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 3);
  emlrtAssign(&y, m);
  return y;
}

static void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
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
    newNumel = static_cast<int32_T>(emlrtSizeMulR2012b((size_t)
      static_cast<uint32_T>(newNumel), (size_t)static_cast<uint32_T>
      (emxArray->size[i]), srcLocation, emlrtRootTLSGlobal));
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(char_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<char_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<char_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

static void emxEnsureCapacity_creal_T(emxArray_creal_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation)
{
  int32_T i;
  int32_T newNumel;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }

  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel = static_cast<int32_T>(emlrtSizeMulR2012b((size_t)
      static_cast<uint32_T>(newNumel), (size_t)static_cast<uint32_T>
      (emxArray->size[i]), srcLocation, emlrtRootTLSGlobal));
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(creal_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<creal_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<creal_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
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
    newNumel = static_cast<int32_T>(emlrtSizeMulR2012b((size_t)
      static_cast<uint32_T>(newNumel), (size_t)static_cast<uint32_T>
      (emxArray->size[i]), srcLocation, emlrtRootTLSGlobal));
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(real_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<real_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<real_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

static void emxFree_char_T(emxArray_char_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_char_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<char_T *>(nullptr)) && (*pEmxArray)
        ->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_char_T *>(nullptr);
  }
}

static void emxFree_creal_T(emxArray_creal_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_creal_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<creal_T *>(nullptr)) && (*pEmxArray
        )->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_creal_T *>(nullptr);
  }
}

static void emxFree_real_T(emxArray_real_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_real_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<real_T *>(nullptr)) && (*pEmxArray)
        ->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_real_T *>(nullptr);
  }
}

static void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_char_T *emxArray;
  *pEmxArray = static_cast<emxArray_char_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_char_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_char_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<char_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(emlrtMallocMex(sizeof(int32_T) *
    static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

static void emxInit_creal_T(emxArray_creal_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_creal_T *emxArray;
  *pEmxArray = static_cast<emxArray_creal_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_creal_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_creal_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<creal_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(emlrtMallocMex(sizeof(int32_T) *
    static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

static void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_real_T *emxArray;
  *pEmxArray = static_cast<emxArray_real_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_real_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_real_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<real_T *>(nullptr);
  emxArray->numDimensions = numDimensions;
  emxArray->size = static_cast<int32_T *>(emlrtMallocMex(sizeof(int32_T) *
    static_cast<uint32_T>(numDimensions)));
  if ((void *)emxArray->size == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (int32_T i{0}; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
  emxArray_creal_T *gpu)
{
  creal_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) * sizeof
                 (creal_T));
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(static_cast<uint32_T>
      (gpu->numDimensions), sizeof(int32_T)));
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
      mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) * sizeof
                   (creal_T));
      cudaMemcpy(newData, gpu->data, static_cast<uint32_T>(actualSizeGpu) *
                 sizeof(creal_T), cudaMemcpyDeviceToDevice);
      gpu->allocatedSize = cpu->allocatedSize;
      if (gpu->canFreeData) {
        mwCudaFree(gpu->data);
      }

      gpu->canFreeData = true;
      gpu->data = newData;
    }
  }
}

static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu)
{
  real_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) * sizeof
                 (real_T));
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(static_cast<uint32_T>
      (gpu->numDimensions), sizeof(int32_T)));
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
      mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) * sizeof
                   (real_T));
      cudaMemcpy(newData, gpu->data, static_cast<uint32_T>(actualSizeGpu) *
                 sizeof(real_T), cudaMemcpyDeviceToDevice);
      gpu->allocatedSize = cpu->allocatedSize;
      if (gpu->canFreeData) {
        mwCudaFree(gpu->data);
      }

      gpu->canFreeData = true;
      gpu->data = newData;
    }
  }
}

static void gpuEmxFree_creal_T(emxArray_creal_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    mwCudaFree(gpu->data);
  }

  emlrtFreeMex(gpu->size);
}

static void gpuEmxFree_real_T(emxArray_real_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    mwCudaFree(gpu->data);
  }

  emlrtFreeMex(gpu->size);
}

static void gpuEmxMemcpyCpuToGpu_creal_T(emxArray_creal_T *gpu, const
  emxArray_creal_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  if (gpu->numDimensions < cpu->numDimensions) {
    gpu->numDimensions = cpu->numDimensions;
    emlrtFreeMex(gpu->size);
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(static_cast<uint32_T>
      (gpu->numDimensions), sizeof(int32_T)));
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
    mwCudaMalloc(&gpu->data, static_cast<uint32_T>(gpu->allocatedSize) * sizeof
                 (creal_T));
  }

  cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (creal_T), cudaMemcpyHostToDevice);
}

static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu, const
  emxArray_real_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  if (gpu->numDimensions < cpu->numDimensions) {
    gpu->numDimensions = cpu->numDimensions;
    emlrtFreeMex(gpu->size);
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(static_cast<uint32_T>
      (gpu->numDimensions), sizeof(int32_T)));
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
    mwCudaMalloc(&gpu->data, static_cast<uint32_T>(gpu->allocatedSize) * sizeof
                 (real_T));
  }

  cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (real_T), cudaMemcpyHostToDevice);
}

static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu, emxArray_creal_T
  *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (creal_T), cudaMemcpyDeviceToHost);
}

static void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T
  *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (real_T), cudaMemcpyDeviceToHost);
}

static void gpuEmxReset_creal_T(emxArray_creal_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_creal_T));
}

static void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real_T));
}

static real_T rt_powd_snf(real_T u0, real_T u1)
{
  real_T y;
  if (std::isnan(u0) || std::isnan(u1)) {
    y = rtNaN;
  } else {
    real_T b;
    real_T c;
    b = std::abs(u0);
    c = std::abs(u1);
    if (std::isinf(u1)) {
      if (b == 1.0) {
        y = 1.0;
      } else if (b > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (c == 0.0) {
      y = 1.0;
    } else if (c == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = std::sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > std::floor(u1))) {
      y = rtNaN;
    } else {
      y = std::pow(u0, u1);
    }
  }

  return y;
}

//
// function [xx,freqs] = ec_cwt(x,fs,fLims,fOctave,ds2)
void ec_cwt(const emxArray_real_T *cpu_x, real_T fs, real_T cpu_fLims[2], real_T
            fOctave, real_T ds2, emxArray_real_T *cpu_xx, emxArray_real_T
            *cpu_freqs)
{
  static const real_T table100[100]{ 0.0, 0.0, 0.69314718055994529,
    1.791759469228055, 3.1780538303479458, 4.7874917427820458,
    6.5792512120101012, 8.5251613610654147, 10.604602902745251,
    12.801827480081469, 15.104412573075516, 17.502307845873887,
    19.987214495661885, 22.552163853123425, 25.19122118273868, 27.89927138384089,
    30.671860106080672, 33.505073450136891, 36.395445208033053,
    39.339884187199495, 42.335616460753485, 45.380138898476908,
    48.471181351835227, 51.606675567764377, 54.784729398112319,
    58.003605222980518, 61.261701761002, 64.557538627006338, 67.88974313718154,
    71.257038967168015, 74.658236348830158, 78.0922235533153, 81.557959456115043,
    85.054467017581516, 88.580827542197682, 92.1361756036871, 95.7196945421432,
    99.330612454787428, 102.96819861451381, 106.63176026064346,
    110.32063971475739, 114.03421178146171, 117.77188139974507,
    121.53308151543864, 125.3172711493569, 129.12393363912722,
    132.95257503561632, 136.80272263732635, 140.67392364823425,
    144.5657439463449, 148.47776695177302, 152.40959258449735, 156.3608363030788,
    160.3311282166309, 164.32011226319517, 168.32744544842765,
    172.35279713916279, 176.39584840699735, 180.45629141754378,
    184.53382886144948, 188.6281734236716, 192.7390472878449, 196.86618167289,
    201.00931639928152, 205.1681994826412, 209.34258675253685,
    213.53224149456327, 217.73693411395422, 221.95644181913033,
    226.1905483237276, 230.43904356577696, 234.70172344281826,
    238.97838956183432, 243.26884900298271, 247.57291409618688,
    251.89040220972319, 256.22113555000954, 260.56494097186322,
    264.92164979855278, 269.29109765101981, 273.67312428569369,
    278.06757344036612, 282.4742926876304, 286.893133295427, 291.32395009427029,
    295.76660135076065, 300.22094864701415, 304.68685676566872,
    309.1641935801469, 313.65282994987905, 318.1526396202093, 322.66349912672615,
    327.1852877037752, 331.71788719692847, 336.26118197919845, 340.815058870799,
    345.37940706226686, 349.95411804077025, 354.53908551944079,
    359.1342053695754 };

  static const real_T NODES[15]{ -0.99145537112081261, -0.94910791234275849,
    -0.8648644233597691, -0.74153118559939435, -0.58608723546769115,
    -0.40584515137739718, -0.20778495500789851, 0.0, 0.20778495500789851,
    0.40584515137739718, 0.58608723546769115, 0.74153118559939435,
    0.8648644233597691, 0.94910791234275849, 0.99145537112081261 };

  static const real_T dv5[15]{ 0.022935322010529221, 0.063092092629978544,
    0.1047900103222502, 0.14065325971552589, 0.16900472663926791,
    0.19035057806478539, 0.20443294007529891, 0.20948214108472779,
    0.20443294007529891, 0.19035057806478539, 0.16900472663926791,
    0.14065325971552589, 0.1047900103222502, 0.063092092629978544,
    0.022935322010529221 };

  static const real_T dv6[15]{ 0.022935322010529221, -0.066392873538891159,
    0.1047900103222502, -0.13905213177375081, 0.16900472663926791,
    -0.19147947244033353, 0.20443294007529891, -0.20847704258874161,
    0.20443294007529891, -0.19147947244033353, 0.16900472663926791,
    -0.13905213177375081, 0.1047900103222502, -0.066392873538891159,
    0.022935322010529221 };

  static const real_T c[7]{ -0.001910444077728, 0.00084171387781295,
    -0.00059523799130430121, 0.0007936507935003503, -0.0027777777777776816,
    0.083333333333333329, 0.0057083835261 };

  static const char_T cpu_cv[128]{ '\x00', '\x01', '\x02', '\x03', '\x04',
    '\x05', '\x06', '\a', '\b', '\t', '\n', '\v', '\f', '\r', '\x0e', '\x0f',
    '\x10', '\x11', '\x12', '\x13', '\x14', '\x15', '\x16', '\x17', '\x18',
    '\x19', '\x1a', '\x1b', '\x1c', '\x1d', '\x1e', '\x1f', ' ', '!', '\"', '#',
    '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', '0', '1', '2',
    '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'a',
    'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
    'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '[', '\\', ']', '^', '_',
    '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
    'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}',
    '~', '\x7f' };

  static const char_T Bndry[10]{ 'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o',
    'n' };

  static const char_T cv1[10]{ 'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o', 'n'
  };

  static const char_T b[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T cv3[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T cv4[5]{ 'm', 'o', 'r', 's', 'e' };

  dim3 block;
  dim3 grid;
  emxArray_char_T *b_str;
  emxArray_char_T *str;
  emxArray_creal_T gpu_cfspos;
  emxArray_creal_T gpu_cfsposdft;
  emxArray_creal_T gpu_xposdft;
  emxArray_creal_T *cpu_cfspos;
  emxArray_creal_T *cpu_cfsposdft;
  emxArray_creal_T *cpu_xposdft;
  emxArray_real_T b_gpu_a;
  emxArray_real_T b_gpu_fx;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_xCh;
  emxArray_real_T b_gpu_xt;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_fx;
  emxArray_real_T c_gpu_x;
  emxArray_real_T c_gpu_xt;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_fx;
  emxArray_real_T d_gpu_x;
  emxArray_real_T d_gpu_xt;
  emxArray_real_T d_gpu_y;
  emxArray_real_T e_gpu_x;
  emxArray_real_T e_gpu_y;
  emxArray_real_T f_gpu_x;
  emxArray_real_T f_gpu_y;
  emxArray_real_T g_gpu_x;
  emxArray_real_T g_gpu_y;
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_absomega;
  emxArray_real_T gpu_dv1;
  emxArray_real_T gpu_dv11;
  emxArray_real_T gpu_dv12;
  emxArray_real_T gpu_dv13;
  emxArray_real_T gpu_dv14;
  emxArray_real_T gpu_dv16;
  emxArray_real_T gpu_dv17;
  emxArray_real_T gpu_dv4;
  emxArray_real_T gpu_dv8;
  emxArray_real_T gpu_f;
  emxArray_real_T gpu_fb_Scales;
  emxArray_real_T gpu_freqs;
  emxArray_real_T gpu_fx;
  emxArray_real_T gpu_omega;
  emxArray_real_T gpu_powscales;
  emxArray_real_T gpu_psidft;
  emxArray_real_T gpu_r;
  emxArray_real_T gpu_somega;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xCh;
  emxArray_real_T gpu_xt;
  emxArray_real_T gpu_xv;
  emxArray_real_T gpu_xx;
  emxArray_real_T gpu_y;
  emxArray_real_T h_gpu_x;
  emxArray_real_T h_gpu_y;
  emxArray_real_T i_gpu_x;
  emxArray_real_T i_gpu_y;
  emxArray_real_T j_gpu_x;
  emxArray_real_T j_gpu_y;
  emxArray_real_T k_gpu_x;
  emxArray_real_T k_gpu_y;
  emxArray_real_T l_gpu_y;
  emxArray_real_T m_gpu_y;
  emxArray_real_T *b_cpu_a;
  emxArray_real_T *b_cpu_fx;
  emxArray_real_T *b_cpu_x;
  emxArray_real_T *b_cpu_xCh;
  emxArray_real_T *b_cpu_xt;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_fx;
  emxArray_real_T *c_cpu_x;
  emxArray_real_T *c_cpu_xt;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_a;
  emxArray_real_T *cpu_absomega;
  emxArray_real_T *cpu_dv1;
  emxArray_real_T *cpu_dv11;
  emxArray_real_T *cpu_dv12;
  emxArray_real_T *cpu_dv13;
  emxArray_real_T *cpu_dv14;
  emxArray_real_T *cpu_dv16;
  emxArray_real_T *cpu_dv17;
  emxArray_real_T *cpu_dv4;
  emxArray_real_T *cpu_dv8;
  emxArray_real_T *cpu_f;
  emxArray_real_T *cpu_fb_Scales;
  emxArray_real_T *cpu_fx;
  emxArray_real_T *cpu_omega;
  emxArray_real_T *cpu_powscales;
  emxArray_real_T *cpu_psidft;
  emxArray_real_T *cpu_r;
  emxArray_real_T *cpu_somega;
  emxArray_real_T *cpu_xCh;
  emxArray_real_T *cpu_xt;
  emxArray_real_T *cpu_xv;
  emxArray_real_T *cpu_y;
  emxArray_real_T *d_cpu_fx;
  emxArray_real_T *d_cpu_x;
  emxArray_real_T *d_cpu_xt;
  emxArray_real_T *d_cpu_y;
  emxArray_real_T *e_cpu_x;
  emxArray_real_T *e_cpu_y;
  emxArray_real_T *f_cpu_x;
  emxArray_real_T *f_cpu_y;
  emxArray_real_T *g_cpu_x;
  emxArray_real_T *g_cpu_y;
  emxArray_real_T *h_cpu_x;
  emxArray_real_T *h_cpu_y;
  emxArray_real_T *i_cpu_x;
  emxArray_real_T *i_cpu_y;
  emxArray_real_T *j_cpu_x;
  emxArray_real_T *j_cpu_y;
  emxArray_real_T *k_cpu_x;
  emxArray_real_T *k_cpu_y;
  emxArray_real_T *l_cpu_y;
  emxArray_real_T *m_cpu_y;
  int64_T e;
  real_T cpu_subs[1298];
  real_T (*gpu_subs)[1298];
  real_T cpu_interval[650];
  real_T (*gpu_interval)[650];
  real_T errsub[649];
  real_T qsub[649];
  real_T cpu_NyquistRange[2];
  real_T cpu_freqrange[2];
  real_T (*gpu_NyquistRange)[2];
  real_T (*gpu_fLims)[2];
  real_T (*gpu_freqrange)[2];
  real_T a;
  real_T b_r;
  real_T c_r;
  real_T d;
  real_T err_ok;
  real_T fb_VoicesPerOctave;
  real_T halfh;
  real_T intDsq;
  real_T intFsq;
  real_T m;
  real_T maxScale;
  real_T omegac;
  real_T q_ok;
  real_T r;
  real_T s;
  real_T tol;
  real_T toler;
  int32_T xx[3];
  int32_T b_eint;
  int32_T bcoef;
  int32_T c_eint;
  int32_T csz_idx_0;
  int32_T eint;
  int32_T exitg1;
  int32_T fb_CutOff;
  int32_T fb_SignalPad;
  int32_T i;
  int32_T j;
  int32_T k;
  int32_T nbytes;
  int32_T nsubs;
  uint32_T cpu_xSize[2];
  uint32_T (*gpu_xSize)[2];
  uint32_T N;
  uint32_T nChs;
  int16_T dv3_idx_1;
  char_T cpu_wav[5];
  char_T (*gpu_wav)[5];
  int8_T n_idx_0;
  boolean_T cpu_b[2];
  boolean_T (*gpu_b)[2];
  boolean_T a_dirtyOnCpu;
  boolean_T a_dirtyOnGpu;
  boolean_T absomega_dirtyOnGpu;
  boolean_T b_a_dirtyOnCpu;
  boolean_T b_a_dirtyOnGpu;
  boolean_T b_dirtyOnGpu;
  boolean_T b_fx_dirtyOnCpu;
  boolean_T b_fx_dirtyOnGpu;
  boolean_T b_guard1{ false };

  boolean_T b_x_dirtyOnCpu;
  boolean_T b_x_dirtyOnGpu;
  boolean_T b_xt_dirtyOnGpu;
  boolean_T b_y_dirtyOnCpu;
  boolean_T b_y_dirtyOnGpu;
  boolean_T c_fx_dirtyOnCpu;
  boolean_T c_fx_dirtyOnGpu;
  boolean_T c_x_dirtyOnCpu;
  boolean_T c_x_dirtyOnGpu;
  boolean_T c_xt_dirtyOnGpu;
  boolean_T c_y_dirtyOnGpu;
  boolean_T cfspos_dirtyOnCpu;
  boolean_T cfspos_dirtyOnGpu;
  boolean_T d_fx_dirtyOnCpu;
  boolean_T d_fx_dirtyOnGpu;
  boolean_T d_x_dirtyOnCpu;
  boolean_T d_x_dirtyOnGpu;
  boolean_T d_xt_dirtyOnGpu;
  boolean_T d_y_dirtyOnGpu;
  boolean_T dv11_dirtyOnGpu;
  boolean_T dv12_dirtyOnGpu;
  boolean_T dv13_dirtyOnGpu;
  boolean_T dv14_dirtyOnGpu;
  boolean_T dv16_dirtyOnGpu;
  boolean_T dv17_dirtyOnGpu;
  boolean_T dv4_dirtyOnGpu;
  boolean_T dv8_dirtyOnGpu;
  boolean_T e_x_dirtyOnCpu;
  boolean_T e_x_dirtyOnGpu;
  boolean_T exitg2;
  boolean_T f_x_dirtyOnCpu;
  boolean_T f_x_dirtyOnGpu;
  boolean_T fb_Scales_dirtyOnGpu;
  boolean_T first_iteration;
  boolean_T freqs_dirtyOnGpu;
  boolean_T fx_dirtyOnCpu;
  boolean_T fx_dirtyOnGpu;
  boolean_T g_x_dirtyOnCpu;
  boolean_T interval_dirtyOnCpu;
  boolean_T omega_dirtyOnGpu;
  boolean_T powscales_dirtyOnGpu;
  boolean_T psidft_dirtyOnCpu;
  boolean_T somega_dirtyOnCpu;
  boolean_T somega_dirtyOnGpu;
  boolean_T subs_dirtyOnCpu;
  boolean_T subs_dirtyOnGpu;
  boolean_T xSize_dirtyOnCpu;
  boolean_T x_dirtyOnCpu;
  boolean_T x_dirtyOnGpu;
  boolean_T xposdft_dirtyOnCpu;
  boolean_T xt_dirtyOnGpu;
  boolean_T xv_dirtyOnCpu;
  boolean_T xv_dirtyOnGpu;
  boolean_T xx_dirtyOnCpu;
  boolean_T xx_dirtyOnGpu;
  boolean_T y_dirtyOnCpu;
  boolean_T y_dirtyOnGpu;
  if (!gpuConstsCopied_ec_cwt) {
    gpuConstsCopied_ec_cwt = true;
    cudaMemcpy(*cpu_cv_gpu_clone, cpu_cv, sizeof(char_T [128]),
               cudaMemcpyHostToDevice);
  }

  gpuEmxReset_real_T(&b_gpu_xCh);
  gpuEmxReset_real_T(&gpu_xCh);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_creal_T(&gpu_cfsposdft);
  gpuEmxReset_real_T(&c_gpu_x);
  gpuEmxReset_creal_T(&gpu_xposdft);
  gpuEmxReset_real_T(&gpu_xv);
  gpuEmxReset_creal_T(&gpu_cfspos);
  gpuEmxReset_real_T(&gpu_x);
  gpuEmxReset_real_T(&gpu_dv1);
  gpuEmxReset_real_T(&gpu_dv17);
  gpuEmxReset_real_T(&f_gpu_y);
  gpuEmxReset_real_T(&gpu_fx);
  gpuEmxReset_real_T(&gpu_dv16);
  gpuEmxReset_real_T(&gpu_powscales);
  gpuEmxReset_real_T(&gpu_xt);
  gpuEmxReset_real_T(&e_gpu_x);
  gpuEmxReset_real_T(&d_gpu_x);
  gpuEmxReset_real_T(&gpu_absomega);
  mwCudaMalloc(&gpu_xSize, 8UL);
  gpuEmxReset_real_T(&gpu_dv14);
  gpuEmxReset_real_T(&i_gpu_y);
  gpuEmxReset_real_T(&gpu_dv12);
  gpuEmxReset_real_T(&gpu_a);
  gpuEmxReset_real_T(&h_gpu_y);
  gpuEmxReset_real_T(&b_gpu_fx);
  gpuEmxReset_real_T(&gpu_somega);
  gpuEmxReset_real_T(&g_gpu_y);
  gpuEmxReset_real_T(&b_gpu_xt);
  gpuEmxReset_real_T(&gpu_f);
  gpuEmxReset_real_T(&g_gpu_x);
  gpuEmxReset_real_T(&gpu_psidft);
  gpuEmxReset_real_T(&f_gpu_x);
  gpuEmxReset_real_T(&e_gpu_y);
  gpuEmxReset_real_T(&gpu_dv13);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_real_T(&j_gpu_y);
  gpuEmxReset_real_T(&c_gpu_fx);
  gpuEmxReset_real_T(&gpu_dv11);
  gpuEmxReset_real_T(&c_gpu_xt);
  gpuEmxReset_real_T(&i_gpu_x);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_real_T(&h_gpu_x);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_dv8);
  gpuEmxReset_real_T(&m_gpu_y);
  gpuEmxReset_real_T(&gpu_dv4);
  gpuEmxReset_real_T(&b_gpu_a);
  gpuEmxReset_real_T(&l_gpu_y);
  gpuEmxReset_real_T(&d_gpu_fx);
  gpuEmxReset_real_T(&k_gpu_y);
  gpuEmxReset_real_T(&d_gpu_xt);
  gpuEmxReset_real_T(&k_gpu_x);
  gpuEmxReset_real_T(&j_gpu_x);
  gpuEmxReset_real_T(&gpu_fb_Scales);
  mwCudaMalloc(&gpu_subs, 10384UL);
  mwCudaMalloc(&gpu_interval, 5200UL);
  gpuEmxReset_real_T(&gpu_r);
  gpuEmxReset_real_T(&gpu_omega);
  mwCudaMalloc(&gpu_wav, 5UL);
  mwCudaMalloc(&gpu_NyquistRange, 16UL);
  mwCudaMalloc(&gpu_freqrange, 16UL);
  mwCudaMalloc(&gpu_b, 2UL);
  gpuEmxReset_real_T(&gpu_freqs);
  gpuEmxReset_real_T(&gpu_xx);
  mwCudaMalloc(&gpu_fLims, 16UL);
  gpuEmxReset_real_T(&b_gpu_x);
  f_x_dirtyOnGpu = false;
  g_x_dirtyOnCpu = false;
  xposdft_dirtyOnCpu = false;
  xv_dirtyOnGpu = false;
  xv_dirtyOnCpu = false;
  cfspos_dirtyOnGpu = false;
  cfspos_dirtyOnCpu = false;
  e_x_dirtyOnGpu = false;
  f_x_dirtyOnCpu = false;
  dv17_dirtyOnGpu = false;
  d_fx_dirtyOnGpu = false;
  d_fx_dirtyOnCpu = false;
  dv16_dirtyOnGpu = false;
  powscales_dirtyOnGpu = false;
  d_xt_dirtyOnGpu = false;
  d_x_dirtyOnGpu = false;
  e_x_dirtyOnCpu = false;
  absomega_dirtyOnGpu = false;
  xSize_dirtyOnCpu = false;
  dv14_dirtyOnGpu = false;
  dv12_dirtyOnGpu = false;
  b_a_dirtyOnGpu = false;
  b_a_dirtyOnCpu = false;
  d_y_dirtyOnGpu = false;
  c_fx_dirtyOnGpu = false;
  c_fx_dirtyOnCpu = false;
  somega_dirtyOnGpu = false;
  somega_dirtyOnCpu = false;
  c_y_dirtyOnGpu = false;
  c_xt_dirtyOnGpu = false;
  c_x_dirtyOnGpu = false;
  psidft_dirtyOnCpu = false;
  d_x_dirtyOnCpu = false;
  dv13_dirtyOnGpu = false;
  b_y_dirtyOnCpu = false;
  b_fx_dirtyOnGpu = false;
  b_fx_dirtyOnCpu = false;
  dv11_dirtyOnGpu = false;
  b_xt_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  c_x_dirtyOnCpu = false;
  y_dirtyOnCpu = false;
  dv8_dirtyOnGpu = false;
  dv4_dirtyOnGpu = false;
  a_dirtyOnGpu = false;
  a_dirtyOnCpu = false;
  b_y_dirtyOnGpu = false;
  fx_dirtyOnGpu = false;
  fx_dirtyOnCpu = false;
  y_dirtyOnGpu = false;
  xt_dirtyOnGpu = false;
  x_dirtyOnGpu = false;
  b_x_dirtyOnCpu = false;
  fb_Scales_dirtyOnGpu = false;
  subs_dirtyOnGpu = false;
  subs_dirtyOnCpu = false;
  interval_dirtyOnCpu = false;
  omega_dirtyOnGpu = false;
  freqs_dirtyOnGpu = false;
  xx_dirtyOnCpu = true;
  xx_dirtyOnGpu = false;
  x_dirtyOnCpu = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  //  Continuous wavelet transform - CUDA binary wrapper (double-precision, FP64)
  //  CWT uses morse wavelets, as they account for unequal variance-covariance across freqs.
  //  L1-norm is applied to mitigate 1/f decay of neuronal field potentials.
  //  Log-transform & robust z-scoring converts absolute valued CWT outputs into normal distribution.
  //
  //  Kevin Tan, 2022 (kevmtan.github.io)
  //  Input validation
  //  arguments
  //      x (:,:){mustBeFloat} % Input data
  //      fs (1,1) double = 1000 % Sampling rate
  //      fLims (1,2) double = [1 300] % Frequency limits
  //      fOctave (1,1) double = 10 % Voices per octave
  //  end
  // 'ec_cwt:16' coder.gpu.kernelfun;
  // 'ec_cwt:17' if fs<10
  if (fs < 10.0) {
    // 'ec_cwt:17' ;
    // 'ec_cwt:17' fs=10;
    fs = 10.0;
  }

  // 'ec_cwt:18' if fLims(1)<1e-3
  if (cpu_fLims[0] < 0.001) {
    // 'ec_cwt:18' ;
    // 'ec_cwt:18' fLims(1)=1e-3;
    cpu_fLims[0] = 0.001;
  }

  // 'ec_cwt:19' if fLims(2)>fs/2
  if (cpu_fLims[1] > fs / 2.0) {
    // 'ec_cwt:19' ;
    // 'ec_cwt:19' fLims(2)=fs/2;
    cpu_fLims[1] = fs / 2.0;
  }

  // 'ec_cwt:20' if fOctave<1
  if (fOctave < 1.0) {
    // 'ec_cwt:20' ;
    // 'ec_cwt:20' fOctave=1;
    fOctave = 1.0;
  } else if (fOctave > 48.0) {
    // 'ec_cwt:20' elseif fOctave>48
    // 'ec_cwt:20' ;
    // 'ec_cwt:20' fOctave=48;
    fOctave = 48.0;
  }

  // 'ec_cwt:21' ds2 = floor(ds2);
  ds2 = std::floor(ds2);

  // 'ec_cwt:22' fOctave = round(fOctave);
  // 'ec_cwt:23' nFrames = height(x);
  // 'ec_cwt:24' nChs = uint32(width(x));
  nChs = static_cast<uint32_T>(cpu_x->size[1]);

  //  Prep CWT
  // coder.extrinsic("cwtfilterbank","centerFrequencies");
  // 'ec_cwt:28' fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
  // 'ec_cwt:29'     SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fOctave);
  fb_CutOff = 50;
  fb_VoicesPerOctave = std::round(fOctave);
  first_iteration = false;
  bcoef = 0;
  do {
    exitg1 = 0;
    if (bcoef + 1 < 11) {
      if (cpu_cv[static_cast<int32_T>(Bndry[bcoef])] != cpu_cv
          [static_cast<int32_T>(cv1[bcoef])]) {
        exitg1 = 1;
      } else {
        bcoef++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (first_iteration) {
    if (cpu_x->size[0] <= 100000) {
      fb_SignalPad = static_cast<int32_T>(std::floor(static_cast<real_T>
        (cpu_x->size[0]) / 2.0));
    } else {
      r = std::frexp(static_cast<real_T>(cpu_x->size[0]), &nbytes);
      if (r == 0.5) {
        r = static_cast<real_T>(nbytes) - 1.0;
      } else {
        r = std::log(r) / 0.69314718055994529 + static_cast<real_T>(nbytes);
      }

      r = std::ceil(r);
      fb_SignalPad = static_cast<int32_T>(r);
    }
  } else {
    fb_SignalPad = 0;
  }

  cudaMemcpy(*gpu_fLims, cpu_fLims, 16UL, cudaMemcpyHostToDevice);
  ec_cwt_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_fLims, *gpu_b);
  b_dirtyOnGpu = true;
  first_iteration = true;
  k = 0;
  exitg2 = false;
  while ((!exitg2) && (k < 2)) {
    if (b_dirtyOnGpu) {
      cudaMemcpy(cpu_b, *gpu_b, 2UL, cudaMemcpyDeviceToHost);
    }

    b_dirtyOnGpu = false;
    if (!cpu_b[k]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      k++;
    }
  }

  if (!first_iteration) {
    real_T cf;
    boolean_T guard1{ false };

    ec_cwt_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_fLims,
      *gpu_freqrange);
    ec_cwt_kernel3<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs,
      *gpu_NyquistRange);
    b_dirtyOnGpu = true;
    emxInit_char_T(&str, 2, &ob_emlrtRTEI, true);
    guard1 = false;
    if (cpu_fLims[1] <= 0.0) {
      guard1 = true;
    } else {
      cudaMemcpy(cpu_NyquistRange, *gpu_NyquistRange, 16UL,
                 cudaMemcpyDeviceToHost);
      b_dirtyOnGpu = false;
      if (cpu_fLims[0] >= cpu_NyquistRange[1]) {
        guard1 = true;
      }
    }

    if (guard1) {
      if (b_dirtyOnGpu) {
        cudaMemcpy(cpu_NyquistRange, *gpu_NyquistRange, 16UL,
                   cudaMemcpyDeviceToHost);
      }

      nbytes = (int32_T)emlrtMexSnprintf(nullptr, 0, "%f", cpu_NyquistRange[1])
        + 1;
      i = str->size[0] * str->size[1];
      str->size[0] = 1;
      str->size[1] = nbytes;
      emxEnsureCapacity_char_T(str, i, &emlrtRTEI);
      emlrtMexSnprintf(&str->data[0], (size_t)nbytes, "%f", cpu_NyquistRange[1]);
    }

    emxFree_char_T(&str);
    ec_cwt_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*cpu_cv_gpu_clone,
      *gpu_wav, b[0], b[1], b[2], b[3], b[4]);
    omegac = 3.1415926535897931;
    cf = 0.0;
    b_r = 0.0;
    cudaMemcpy(cpu_wav, *gpu_wav, 5UL, cudaMemcpyDeviceToHost);
    if (cpu_cv[static_cast<int32_T>(cpu_wav[0])] == 'm') {
      nbytes = 0;
    } else if (cpu_cv[static_cast<int32_T>(cpu_wav[0])] == 'a') {
      nbytes = 1;
    } else if (cpu_cv[static_cast<int32_T>(cpu_wav[0])] == 'b') {
      nbytes = 2;
    } else {
      nbytes = -1;
    }

    switch (nbytes) {
     case 0:
      cf = 1.8820720577620569;
      c_r = 0.0057083835261;
      b_r = 0.0057083835261;
      r = 0.0057083835261;
      for (nsubs = 0; nsubs < 6; nsubs++) {
        maxScale = c[nsubs];
        c_r = c_r * 0.005353955978584176 + maxScale;
        b_r = b_r * 0.005353955978584176 + maxScale;
        r = r * 0.005353955978584176 + maxScale;
      }

      c_r /= 13.666666666666666;
      b_r /= 13.666666666666666;
      r /= 13.666666666666666;
      b_r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((c_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(b_r) || std::isnan(b_r)) {
        ec_cwt_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwt_kernel6<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*gpu_interval);
        intDsq = 0.0;
        bcoef = 1;
        cudaMemcpy(cpu_interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        k = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (k > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            nbytes = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_dirtyOnCpu = true;
            r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (j = 0; j < nbytes; j++) {
              cpu_interval[n_idx_0 - j] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - j) * r;
            }
          }

          bcoef = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        nbytes = 0;
        for (j = 0; j < bcoef; j++) {
          if (std::abs(cpu_interval[j + 1] - cpu_interval[nbytes]) > 0.0) {
            nbytes++;
            cpu_interval[nbytes] = cpu_interval[j + 1];
            interval_dirtyOnCpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                       cudaMemcpyHostToDevice);
          }

          ec_cwt_kernel7<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(bcoef,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (k <= 0) {
          intDsq = rtNaN;
        } else {
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nsubs),
            &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                         cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            ec_cwt_kernel8<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&b_cpu_x, 2, &f_emlrtRTEI, true);
          emxInit_real_T(&c_cpu_x, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&cpu_xt, 2, &ac_emlrtRTEI, true);
          emxInit_real_T(&cpu_y, 2, &bc_emlrtRTEI, true);
          emxInit_real_T(&cpu_fx, 2, &rb_emlrtRTEI, true);
          emxInit_real_T(&b_cpu_y, 2, &cc_emlrtRTEI, true);
          emxInit_real_T(&cpu_a, 2, &p_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv4, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&c_cpu_y, 2, &fc_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv8, 2, &ec_emlrtRTEI, true);
          do {
            exitg1 = 0;
            i = b_cpu_x->size[0] * b_cpu_x->size[1];
            b_cpu_x->size[0] = 1;
            b_cpu_x->size[1] = 15 * nsubs;
            emxEnsureCapacity_real_T(b_cpu_x, i, &f_emlrtRTEI);
            if (!b_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_x, &j_gpu_x);
            }

            nbytes = -1;
            for (k = 0; k < nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              maxScale = cpu_subs[k << 1];
              subs_dirtyOnGpu = false;
              r = cpu_subs[(k << 1) + 1];
              b_r = (maxScale + r) / 2.0;
              halfh = (r - maxScale) / 2.0;
              for (j = 0; j < 15; j++) {
                b_cpu_x->data[(nbytes + j) + 1] = NODES[j] * halfh + b_r;
                b_x_dirtyOnCpu = true;
              }

              nbytes += 15;
            }

            i = c_cpu_x->size[0] * c_cpu_x->size[1];
            c_cpu_x->size[0] = 1;
            c_cpu_x->size[1] = b_cpu_x->size[1];
            emxEnsureCapacity_real_T(c_cpu_x, i, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(c_cpu_x, &k_gpu_x);
            i = cpu_xt->size[0] * cpu_xt->size[1];
            cpu_xt->size[0] = 1;
            cpu_xt->size[1] = b_cpu_x->size[1];
            emxEnsureCapacity_real_T(cpu_xt, i, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_xt, &d_gpu_xt);
            nbytes = b_cpu_x->size[1];
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nbytes),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_x, b_cpu_x);
              }

              b_x_dirtyOnCpu = false;
              ec_cwt_kernel9<<<grid, block>>>(j_gpu_x, nbytes, d_gpu_xt, k_gpu_x);
              x_dirtyOnGpu = true;
              xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_cpu_x, &k_gpu_x);
              }

              x_dirtyOnGpu = false;
              b_r = std::abs(c_cpu_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= c_cpu_x->size[1] - 2)) {
                tol = b_r;
                b_r = std::abs(c_cpu_x->data[k + 1]);
                if (std::abs(c_cpu_x->data[k + 1] - c_cpu_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(tol, b_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv3_idx_1 = static_cast<int16_T>(b_cpu_x->size[1]);
                i = cpu_fx->size[0] * cpu_fx->size[1];
                cpu_fx->size[0] = 1;
                cpu_fx->size[1] = b_cpu_x->size[1];
                emxEnsureCapacity_real_T(cpu_fx, i, &l_emlrtRTEI);
                if (!fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_fx, &d_gpu_fx);
                }

                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                  (dv3_idx_1), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_fx, cpu_fx);
                  }

                  ec_cwt_kernel17<<<grid, block>>>(dv3_idx_1, d_gpu_fx);
                }

                exitg1 = 1;
              } else {
                b_guard1 = true;
              }
            } else {
              b_guard1 = true;
            }

            if (b_guard1) {
              first_iteration = false;
              i = cpu_y->size[0] * cpu_y->size[1];
              cpu_y->size[0] = 1;
              cpu_y->size[1] = c_cpu_x->size[1];
              emxEnsureCapacity_real_T(cpu_y, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_y, &k_gpu_y);
              bcoef = c_cpu_x->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel10<<<grid, block>>>(k_gpu_x, bcoef, k_gpu_y);
                y_dirtyOnGpu = true;
              }

              i = b_cpu_y->size[0] * b_cpu_y->size[1];
              b_cpu_y->size[0] = 1;
              b_cpu_y->size[1] = c_cpu_x->size[1];
              emxEnsureCapacity_real_T(b_cpu_y, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(b_cpu_y, &l_gpu_y);
              bcoef = c_cpu_x->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel11<<<grid, block>>>(k_gpu_x, bcoef, l_gpu_y);
                b_y_dirtyOnGpu = true;
              }

              if (cpu_y->size[1] == b_cpu_y->size[1]) {
                i = cpu_a->size[0] * cpu_a->size[1];
                cpu_a->size[0] = 1;
                cpu_a->size[1] = cpu_y->size[1];
                emxEnsureCapacity_real_T(cpu_a, i, &p_emlrtRTEI);
                if (!a_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_a, &b_gpu_a);
                }

                k = cpu_y->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (a_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_a, cpu_a);
                  }

                  ec_cwt_kernel12<<<grid, block>>>(l_gpu_y, k_gpu_y, k, b_gpu_a);
                  a_dirtyOnGpu = true;
                  a_dirtyOnCpu = false;
                }
              } else {
                if (a_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_a, &b_gpu_a);
                }

                if (y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_y, &k_gpu_y);
                }

                y_dirtyOnGpu = false;
                if (b_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_cpu_y, &l_gpu_y);
                }

                b_y_dirtyOnGpu = false;
                c_binary_expand_op(cpu_a, cpu_y, b_cpu_y);
                a_dirtyOnCpu = true;
                a_dirtyOnGpu = false;
              }

              i = cpu_dv4->size[0] * cpu_dv4->size[1];
              cpu_dv4->size[0] = 1;
              cpu_dv4->size[1] = cpu_a->size[1];
              emxEnsureCapacity_real_T(cpu_dv4, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv4, &gpu_dv4);
              bcoef = cpu_a->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                if (a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_a, cpu_a);
                }

                a_dirtyOnCpu = false;
                ec_cwt_kernel13<<<grid, block>>>(b_gpu_a, bcoef, gpu_dv4);
                dv4_dirtyOnGpu = true;
              }

              i = c_cpu_y->size[0] * c_cpu_y->size[1];
              c_cpu_y->size[0] = 1;
              c_cpu_y->size[1] = c_cpu_x->size[1];
              emxEnsureCapacity_real_T(c_cpu_y, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(c_cpu_y, &m_gpu_y);
              bcoef = c_cpu_x->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel14<<<grid, block>>>(k_gpu_x, bcoef, m_gpu_y);
              }

              i = cpu_dv8->size[0] * cpu_dv8->size[1];
              cpu_dv8->size[0] = 1;
              cpu_dv8->size[1] = c_cpu_y->size[1];
              emxEnsureCapacity_real_T(cpu_dv8, i, &w_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv8, &gpu_dv8);
              k = c_cpu_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel15<<<grid, block>>>(m_gpu_y, k, gpu_dv8);
                dv8_dirtyOnGpu = true;
              }

              if (cpu_dv4->size[1] == cpu_dv8->size[1]) {
                i = cpu_fx->size[0] * cpu_fx->size[1];
                cpu_fx->size[0] = 1;
                cpu_fx->size[1] = cpu_dv4->size[1];
                emxEnsureCapacity_real_T(cpu_fx, i, &bb_emlrtRTEI);
                if (!fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_fx, &d_gpu_fx);
                }

                bcoef = cpu_dv4->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef
                  + 1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_fx, cpu_fx);
                  }

                  ec_cwt_kernel16<<<grid, block>>>(d_gpu_xt, gpu_dv8, gpu_dv4,
                    bcoef, d_gpu_fx);
                  fx_dirtyOnGpu = true;
                  fx_dirtyOnCpu = false;
                }
              } else {
                if (fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_fx, &d_gpu_fx);
                }

                if (dv4_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv4, &gpu_dv4);
                }

                dv4_dirtyOnGpu = false;
                if (dv8_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv8, &gpu_dv8);
                }

                dv8_dirtyOnGpu = false;
                if (xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_xt, &d_gpu_xt);
                }

                xt_dirtyOnGpu = false;
                binary_expand_op(cpu_fx, cpu_dv4, cpu_dv8, cpu_xt);
                fx_dirtyOnCpu = true;
                fx_dirtyOnGpu = false;
              }

              b_r = 0.0;
              nbytes = -1;
              for (k = 0; k < nsubs; k++) {
                maxScale = 0.0;
                r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(cpu_fx, &d_gpu_fx);
                  }

                  maxScale += dv5[j] * cpu_fx->data[(nbytes + j) + 1];
                  fx_dirtyOnGpu = false;
                  r += dv6[j] * cpu_fx->data[(nbytes + j) + 1];
                }

                nbytes += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) / 2.0;
                maxScale *= halfh;
                qsub[k] = maxScale;
                b_r += maxScale;
                errsub[k] = r * halfh;
              }

              intDsq = b_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              b_r = 2.0 * tol;
              r = 0.0;
              nbytes = 0;
              for (k = 0; k < nsubs; k++) {
                maxScale = errsub[k];
                halfh = std::abs(maxScale);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= b_r * ((cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) /
                                    2.0)) {
                  err_ok += maxScale;
                  q_ok += qsub[k];
                } else {
                  r += halfh;
                  nbytes++;
                  cpu_subs[(nbytes - 1) << 1] = cpu_subs[k << 1];
                  cpu_subs[((nbytes - 1) << 1) + 1] = cpu_subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              b_r = std::abs(err_ok) + r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(b_r)) && (!std::isnan(b_r))) && (nbytes != 0) &&
                  (!(b_r <= tol))) {
                nsubs = nbytes << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nbytes; k++) {
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    cpu_subs[((((nbytes - k) << 1) - 1) << 1) + 1] = cpu_subs
                      [(((nbytes - k) - 1) << 1) + 1];
                    cpu_subs[(((nbytes - k) << 1) - 1) << 1] = (cpu_subs
                      [((nbytes - k) - 1) << 1] + cpu_subs[(((nbytes - k) - 1) <<
                      1) + 1]) / 2.0;
                    cpu_subs[((((nbytes - k) << 1) - 2) << 1) + 1] = cpu_subs
                      [(((nbytes - k) << 1) - 1) << 1];
                    cpu_subs[(((nbytes - k) << 1) - 2) << 1] = cpu_subs[((nbytes
                      - k) - 1) << 1];
                    subs_dirtyOnCpu = true;
                    subs_dirtyOnGpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&cpu_dv8);
          emxFree_real_T(&c_cpu_y);
          emxFree_real_T(&cpu_dv4);
          emxFree_real_T(&cpu_a);
          emxFree_real_T(&b_cpu_y);
          emxFree_real_T(&cpu_fx);
          emxFree_real_T(&cpu_y);
          emxFree_real_T(&cpu_xt);
          emxFree_real_T(&c_cpu_x);
          emxFree_real_T(&b_cpu_x);
        }

        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, cpu_interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ec_cwt_kernel18<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwt_kernel19<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*gpu_interval);
        interval_dirtyOnCpu = false;
        intFsq = 0.0;
        bcoef = 1;
        cudaMemcpy(cpu_interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        k = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (k > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            nbytes = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_dirtyOnCpu = true;
            r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (j = 0; j < nbytes; j++) {
              cpu_interval[n_idx_0 - j] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - j) * r;
            }
          }

          bcoef = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        nbytes = 0;
        for (j = 0; j < bcoef; j++) {
          if (std::abs(cpu_interval[j + 1] - cpu_interval[nbytes]) > 0.0) {
            nbytes++;
            cpu_interval[nbytes] = cpu_interval[j + 1];
            interval_dirtyOnCpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                       cudaMemcpyHostToDevice);
          }

          ec_cwt_kernel20<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(bcoef,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (k <= 0) {
          intFsq = rtNaN;
        } else {
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nsubs),
            &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                         cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, cpu_subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ec_cwt_kernel21<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnGpu = true;
            subs_dirtyOnCpu = false;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&d_cpu_x, 2, &f_emlrtRTEI, true);
          emxInit_real_T(&e_cpu_x, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&b_cpu_xt, 2, &ac_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv11, 2, &hc_emlrtRTEI, true);
          emxInit_real_T(&b_cpu_fx, 2, &rb_emlrtRTEI, true);
          emxInit_real_T(&f_cpu_y, 2, &ic_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv13, 2, &hc_emlrtRTEI, true);
          do {
            exitg1 = 0;
            i = d_cpu_x->size[0] * d_cpu_x->size[1];
            d_cpu_x->size[0] = 1;
            d_cpu_x->size[1] = 15 * nsubs;
            emxEnsureCapacity_real_T(d_cpu_x, i, &f_emlrtRTEI);
            if (!c_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(d_cpu_x, &h_gpu_x);
            }

            nbytes = -1;
            for (k = 0; k < nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              maxScale = cpu_subs[k << 1];
              subs_dirtyOnGpu = false;
              r = cpu_subs[(k << 1) + 1];
              b_r = (maxScale + r) / 2.0;
              halfh = (r - maxScale) / 2.0;
              for (j = 0; j < 15; j++) {
                d_cpu_x->data[(nbytes + j) + 1] = NODES[j] * halfh + b_r;
                c_x_dirtyOnCpu = true;
              }

              nbytes += 15;
            }

            i = e_cpu_x->size[0] * e_cpu_x->size[1];
            e_cpu_x->size[0] = 1;
            e_cpu_x->size[1] = d_cpu_x->size[1];
            emxEnsureCapacity_real_T(e_cpu_x, i, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(e_cpu_x, &i_gpu_x);
            i = b_cpu_xt->size[0] * b_cpu_xt->size[1];
            b_cpu_xt->size[0] = 1;
            b_cpu_xt->size[1] = d_cpu_x->size[1];
            emxEnsureCapacity_real_T(b_cpu_xt, i, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_cpu_xt, &c_gpu_xt);
            nbytes = d_cpu_x->size[1];
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nbytes),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (c_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_x, d_cpu_x);
              }

              c_x_dirtyOnCpu = false;
              ec_cwt_kernel22<<<grid, block>>>(h_gpu_x, nbytes, c_gpu_xt,
                i_gpu_x);
              b_x_dirtyOnGpu = true;
              b_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (b_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(e_cpu_x, &i_gpu_x);
              }

              b_x_dirtyOnGpu = false;
              b_r = std::abs(e_cpu_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= e_cpu_x->size[1] - 2)) {
                tol = b_r;
                b_r = std::abs(e_cpu_x->data[k + 1]);
                if (std::abs(e_cpu_x->data[k + 1] - e_cpu_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(tol, b_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv3_idx_1 = static_cast<int16_T>(d_cpu_x->size[1]);
                i = b_cpu_fx->size[0] * b_cpu_fx->size[1];
                b_cpu_fx->size[0] = 1;
                b_cpu_fx->size[1] = d_cpu_x->size[1];
                emxEnsureCapacity_real_T(b_cpu_fx, i, &l_emlrtRTEI);
                if (!b_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(b_cpu_fx, &c_gpu_fx);
                }

                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                  (dv3_idx_1), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (b_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_fx, b_cpu_fx);
                  }

                  ec_cwt_kernel27<<<grid, block>>>(dv3_idx_1, c_gpu_fx);
                }

                exitg1 = 1;
              } else {
                b_guard1 = true;
              }
            } else {
              b_guard1 = true;
            }

            if (b_guard1) {
              first_iteration = false;
              i = cpu_dv11->size[0] * cpu_dv11->size[1];
              cpu_dv11->size[0] = 1;
              cpu_dv11->size[1] = e_cpu_x->size[1];
              emxEnsureCapacity_real_T(cpu_dv11, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv11, &gpu_dv11);
              bcoef = e_cpu_x->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel23<<<grid, block>>>(i_gpu_x, bcoef, gpu_dv11);
                dv11_dirtyOnGpu = true;
              }

              i = f_cpu_y->size[0] * f_cpu_y->size[1];
              f_cpu_y->size[0] = 1;
              f_cpu_y->size[1] = e_cpu_x->size[1];
              emxEnsureCapacity_real_T(f_cpu_y, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(f_cpu_y, &j_gpu_y);
              bcoef = e_cpu_x->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel24<<<grid, block>>>(i_gpu_x, bcoef, j_gpu_y);
              }

              i = cpu_dv13->size[0] * cpu_dv13->size[1];
              cpu_dv13->size[0] = 1;
              cpu_dv13->size[1] = f_cpu_y->size[1];
              emxEnsureCapacity_real_T(cpu_dv13, i, &x_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv13, &gpu_dv13);
              k = f_cpu_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel25<<<grid, block>>>(j_gpu_y, k, gpu_dv13);
                dv13_dirtyOnGpu = true;
              }

              if (cpu_dv11->size[1] == cpu_dv13->size[1]) {
                i = b_cpu_fx->size[0] * b_cpu_fx->size[1];
                b_cpu_fx->size[0] = 1;
                b_cpu_fx->size[1] = cpu_dv11->size[1];
                emxEnsureCapacity_real_T(b_cpu_fx, i, &bb_emlrtRTEI);
                if (!b_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(b_cpu_fx, &c_gpu_fx);
                }

                k = cpu_dv11->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (b_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_fx, b_cpu_fx);
                  }

                  ec_cwt_kernel26<<<grid, block>>>(c_gpu_xt, gpu_dv13, gpu_dv11,
                    k, c_gpu_fx);
                  b_fx_dirtyOnGpu = true;
                  b_fx_dirtyOnCpu = false;
                }
              } else {
                if (b_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_cpu_fx, &c_gpu_fx);
                }

                if (dv11_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv11, &gpu_dv11);
                }

                dv11_dirtyOnGpu = false;
                if (dv13_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv13, &gpu_dv13);
                }

                dv13_dirtyOnGpu = false;
                if (b_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_cpu_xt, &c_gpu_xt);
                }

                b_xt_dirtyOnGpu = false;
                binary_expand_op(b_cpu_fx, cpu_dv11, cpu_dv13, b_cpu_xt);
                b_fx_dirtyOnCpu = true;
                b_fx_dirtyOnGpu = false;
              }

              b_r = 0.0;
              nbytes = -1;
              for (k = 0; k < nsubs; k++) {
                maxScale = 0.0;
                r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (b_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(b_cpu_fx, &c_gpu_fx);
                  }

                  maxScale += dv5[j] * b_cpu_fx->data[(nbytes + j) + 1];
                  b_fx_dirtyOnGpu = false;
                  r += dv6[j] * b_cpu_fx->data[(nbytes + j) + 1];
                }

                nbytes += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) / 2.0;
                maxScale *= halfh;
                qsub[k] = maxScale;
                b_r += maxScale;
                errsub[k] = r * halfh;
              }

              intFsq = b_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              b_r = 2.0 * tol;
              r = 0.0;
              nbytes = 0;
              for (k = 0; k < nsubs; k++) {
                maxScale = errsub[k];
                halfh = std::abs(maxScale);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= b_r * ((cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) /
                                    2.0)) {
                  err_ok += maxScale;
                  q_ok += qsub[k];
                } else {
                  r += halfh;
                  nbytes++;
                  cpu_subs[(nbytes - 1) << 1] = cpu_subs[k << 1];
                  cpu_subs[((nbytes - 1) << 1) + 1] = cpu_subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              b_r = std::abs(err_ok) + r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(b_r)) && (!std::isnan(b_r))) && (nbytes != 0) &&
                  (!(b_r <= tol))) {
                nsubs = nbytes << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nbytes; k++) {
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    cpu_subs[((((nbytes - k) << 1) - 1) << 1) + 1] = cpu_subs
                      [(((nbytes - k) - 1) << 1) + 1];
                    cpu_subs[(((nbytes - k) << 1) - 1) << 1] = (cpu_subs
                      [((nbytes - k) - 1) << 1] + cpu_subs[(((nbytes - k) - 1) <<
                      1) + 1]) / 2.0;
                    cpu_subs[((((nbytes - k) << 1) - 2) << 1) + 1] = cpu_subs
                      [(((nbytes - k) << 1) - 1) << 1];
                    cpu_subs[(((nbytes - k) << 1) - 2) << 1] = cpu_subs[((nbytes
                      - k) - 1) << 1];
                    subs_dirtyOnCpu = true;
                    subs_dirtyOnGpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&cpu_dv13);
          emxFree_real_T(&f_cpu_y);
          emxFree_real_T(&b_cpu_fx);
          emxFree_real_T(&cpu_dv11);
          emxFree_real_T(&b_cpu_xt);
          emxFree_real_T(&e_cpu_x);
          emxFree_real_T(&d_cpu_x);
        }

        b_r = std::sqrt(3.5421952306087032 * (intDsq / intFsq));
      }
      break;

     case 1:
      cf = 6.0;
      b_r = 1.4142135623730951;
      break;

     case 2:
      cf = 5.0;
      b_r = 5.847705;
      break;
    }

    halfh = static_cast<real_T>(cpu_x->size[0]) / (b_r * 2.0);
    first_iteration = false;
    bcoef = 0;
    do {
      exitg1 = 0;
      if (bcoef + 1 < 6) {
        if (cpu_wav[bcoef] != cv4[bcoef]) {
          exitg1 = 1;
        } else {
          bcoef++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      bcoef = 0;
    } else {
      bcoef = -1;
    }

    if (bcoef == 0) {
      if (1.0 - 0.0050536085896138528 * rt_powd_snf(cf, 20.0) * std::exp
          (-rt_powd_snf(cf, 3.0)) >= 0.0) {
        if (1.0 - 0.0050536085896138528 * rt_powd_snf(cf, 20.0) * std::exp
            (-rt_powd_snf(cf, 3.0)) == 1.0) {
          omegac = 9.0856029641606977;
        } else {
          omegac = cf;
        }
      } else {
        a = cf;
        omegac = 9.0856029641606977;
        b_r = 1.0 - 0.0050536085896138528 * rt_powd_snf(cf, 20.0) * std::exp
          (-rt_powd_snf(cf, 3.0));
        q_ok = 1.0;
        if (b_r == 0.0) {
          omegac = cf;
        } else {
          err_ok = 1.0;
          intFsq = 9.0856029641606977;
          intDsq = 0.0;
          d = 0.0;
          exitg2 = false;
          while ((!exitg2) && ((q_ok != 0.0) && (a != omegac))) {
            if ((q_ok > 0.0) == (err_ok > 0.0)) {
              intFsq = a;
              err_ok = b_r;
              d = omegac - a;
              intDsq = d;
            }

            if (std::abs(err_ok) < std::abs(q_ok)) {
              a = omegac;
              omegac = intFsq;
              intFsq = a;
              b_r = q_ok;
              q_ok = err_ok;
              err_ok = b_r;
            }

            m = 0.5 * (intFsq - omegac);
            toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(m) <= toler) || (q_ok == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(intDsq) < toler) || (std::abs(b_r) <= std::abs(q_ok)))
              {
                d = m;
                intDsq = m;
              } else {
                s = q_ok / b_r;
                if (a == intFsq) {
                  b_r = 2.0 * m * s;
                  tol = 1.0 - s;
                } else {
                  tol = b_r / err_ok;
                  c_r = q_ok / err_ok;
                  b_r = s * (2.0 * m * tol * (tol - c_r) - (omegac - a) * (c_r -
                              1.0));
                  tol = (tol - 1.0) * (c_r - 1.0) * (s - 1.0);
                }

                if (b_r > 0.0) {
                  tol = -tol;
                } else {
                  b_r = -b_r;
                }

                if ((2.0 * b_r < 3.0 * m * tol - std::abs(toler * tol)) && (b_r <
                     std::abs(0.5 * intDsq * tol))) {
                  intDsq = d;
                  d = b_r / tol;
                } else {
                  d = m;
                  intDsq = m;
                }
              }

              a = omegac;
              b_r = q_ok;
              if (std::abs(d) > toler) {
                omegac += d;
              } else if (omegac > intFsq) {
                omegac -= toler;
              } else {
                omegac += toler;
              }

              q_ok = 1.0 - 0.0050536085896138528 * rt_powd_snf(omegac, 20.0) *
                std::exp(-rt_powd_snf(omegac, 3.0));
            }
          }
        }
      }
    }

    r = omegac / 3.1415926535897931;
    if (halfh < r * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave)) {
      halfh = r * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave);
    }

    r = 1.0 / (halfh * (6.2831853071795862 / cf)) * fs;
    if (cpu_fLims[0] < r) {
      ec_cwt_kernel28<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(r, *gpu_freqrange,
        *gpu_fLims);
      cudaMemcpy(cpu_fLims, *gpu_fLims, 16UL, cudaMemcpyDeviceToHost);
    }

    if (cpu_fLims[1] > fs / 2.0) {
      ec_cwt_kernel29<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs,
        *gpu_freqrange, *gpu_fLims);
    }

    cudaMemcpy(cpu_freqrange, *gpu_freqrange, 16UL, cudaMemcpyDeviceToHost);
    if (cpu_freqrange[1] == 0.0) {
      b_r = rtMinusInf;
    } else if (cpu_freqrange[1] < 0.0) {
      b_r = rtNaN;
    } else if ((!std::isinf(cpu_freqrange[1])) && (!std::isnan(cpu_freqrange[1])))
    {
      r = std::frexp(cpu_freqrange[1], &eint);
      if (r == 0.5) {
        b_r = static_cast<real_T>(eint) - 1.0;
      } else if ((eint == 1) && (r < 0.75)) {
        b_r = std::log(2.0 * r) / 0.69314718055994529;
      } else {
        b_r = std::log(r) / 0.69314718055994529 + static_cast<real_T>(eint);
      }
    } else {
      b_r = cpu_freqrange[1];
    }

    if ((!std::isinf(cpu_freqrange[0])) && (!std::isnan(cpu_freqrange[0]))) {
      r = std::frexp(cpu_freqrange[0], &b_eint);
      if (r == 0.5) {
        r = static_cast<real_T>(b_eint) - 1.0;
      } else if ((b_eint == 1) && (r < 0.75)) {
        r = std::log(2.0 * r) / 0.69314718055994529;
      } else {
        r = std::log(r) / 0.69314718055994529 + static_cast<real_T>(b_eint);
      }
    } else {
      r = cpu_freqrange[0];
    }

    if (!(b_r - r >= 1.0 / fb_VoicesPerOctave)) {
      r = 1.0 / fb_VoicesPerOctave;
      nbytes = (int32_T)emlrtMexSnprintf(nullptr, 0, "%2.2f", r) + 1;
      emxInit_char_T(&b_str, 2, &ob_emlrtRTEI, true);
      i = b_str->size[0] * b_str->size[1];
      b_str->size[0] = 1;
      b_str->size[1] = nbytes;
      emxEnsureCapacity_char_T(b_str, i, &emlrtRTEI);
      emlrtMexSnprintf(&b_str->data[0], (size_t)nbytes, "%2.2f", r);
      emxFree_char_T(&b_str);
    }
  }

  first_iteration = false;
  bcoef = 0;
  do {
    exitg1 = 0;
    if (bcoef + 1 < 6) {
      if (cpu_cv[static_cast<int32_T>(b[bcoef])] != cpu_cv[static_cast<int32_T>
          (cv3[bcoef])]) {
        exitg1 = 1;
      } else {
        bcoef++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (!first_iteration) {
    fb_CutOff = 10;
  }

  N = static_cast<uint32_T>(cpu_x->size[0]) + static_cast<uint32_T>(fb_SignalPad
    << 1);
  nbytes = static_cast<int32_T>(std::trunc(static_cast<real_T>(N) / 2.0));
  emxInit_real_T(&cpu_omega, 2, &b_emlrtRTEI, true);
  if (nbytes < 1) {
    cpu_omega->size[1] = 0;
  } else {
    i = cpu_omega->size[0] * cpu_omega->size[1];
    cpu_omega->size[0] = 1;
    cpu_omega->size[1] = nbytes;
    emxEnsureCapacity_real_T(cpu_omega, i, &b_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_omega, &gpu_omega);
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nbytes), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_cwt_kernel30<<<grid, block>>>(nbytes, gpu_omega);
      omega_dirtyOnGpu = true;
    }
  }

  i = cpu_omega->size[0] * cpu_omega->size[1];
  cpu_omega->size[0] = 1;
  emxEnsureCapacity_real_T(cpu_omega, i, &c_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_omega, &gpu_omega);
  i = cpu_omega->size[1] - 1;
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L), &grid,
    &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ec_cwt_kernel31<<<grid, block>>>(N, i, gpu_omega);
    omega_dirtyOnGpu = true;
  }

  nbytes = static_cast<int32_T>(std::trunc((static_cast<real_T>(N) - 1.0) / 2.0));
  if (nbytes < 1) {
    nsubs = 0;
    nbytes = 1;
    bcoef = -1;
  } else {
    nsubs = nbytes - 1;
    nbytes = -1;
    bcoef = 0;
  }

  emxInit_real_T(&cpu_r, 2, &d_emlrtRTEI, true);
  i = cpu_r->size[0] * cpu_r->size[1];
  cpu_r->size[0] = 1;
  cpu_r->size[1] = (cpu_omega->size[1] + div_s32(bcoef - nsubs, nbytes)) + 2;
  emxEnsureCapacity_real_T(cpu_r, i, &d_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_r, &gpu_r);
  ec_cwt_kernel32<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_r);
  j = cpu_omega->size[1];
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(j), &grid, &block,
    1024U, 65535U);
  if (b_dirtyOnGpu) {
    ec_cwt_kernel33<<<grid, block>>>(gpu_omega, j, gpu_r);
  }

  j = div_s32(bcoef - nsubs, nbytes);
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(j + 1L), &grid,
    &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ec_cwt_kernel34<<<grid, block>>>(nbytes, nsubs, gpu_omega, j, gpu_r,
      cpu_omega->size[1U]);
  }

  i = cpu_omega->size[0] * cpu_omega->size[1];
  cpu_omega->size[0] = 1;
  cpu_omega->size[1] = cpu_r->size[1];
  emxEnsureCapacity_real_T(cpu_omega, i, &e_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_omega, &gpu_omega);
  bcoef = cpu_r->size[1] - 1;
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L), &grid,
    &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ec_cwt_kernel35<<<grid, block>>>(gpu_r, bcoef, gpu_omega);
    omega_dirtyOnGpu = true;
  }

  emxFree_real_T(&cpu_r);
  ec_cwt_kernel36<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_fLims, *gpu_b);
  b_dirtyOnGpu = true;
  first_iteration = true;
  k = 0;
  exitg2 = false;
  while ((!exitg2) && (k < 2)) {
    if (b_dirtyOnGpu) {
      cudaMemcpy(cpu_b, *gpu_b, 2UL, cudaMemcpyDeviceToHost);
    }

    b_dirtyOnGpu = false;
    if (!cpu_b[k]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      k++;
    }
  }

  emxInit_real_T(&cpu_fb_Scales, 2, &k_emlrtRTEI, true);
  if (!first_iteration) {
    ec_cwt_kernel64<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs, *gpu_fLims,
      *gpu_NyquistRange);
    r = 0.0;
    if (cpu_cv[77] == 'm') {
      nbytes = 0;
    } else if (cpu_cv[77] == 'a') {
      nbytes = 1;
    } else if (cpu_cv[77] == 'b') {
      nbytes = 2;
    } else {
      nbytes = -1;
    }

    switch (nbytes) {
     case 0:
      r = 1.8820720577620569;
      break;

     case 1:
      r = 6.0;
      break;

     case 2:
      r = 5.0;
      break;
    }

    cudaMemcpy(cpu_NyquistRange, *gpu_NyquistRange, 16UL, cudaMemcpyDeviceToHost);
    halfh = r / cpu_NyquistRange[1];
    r = r / cpu_NyquistRange[0] / halfh;
    if (r == 0.0) {
      r = rtMinusInf;
    } else if (r < 0.0) {
      r = rtNaN;
    } else if ((!std::isinf(r)) && (!std::isnan(r))) {
      r = std::frexp(r, &c_eint);
      if (r == 0.5) {
        r = static_cast<real_T>(c_eint) - 1.0;
      } else if ((c_eint == 1) && (r < 0.75)) {
        r = std::log(2.0 * r) / 0.69314718055994529;
      } else {
        r = std::log(r) / 0.69314718055994529 + static_cast<real_T>(c_eint);
      }
    }

    emxInit_real_T(&d_cpu_y, 2, &pb_emlrtRTEI, true);
    r *= fb_VoicesPerOctave;
    if (std::isnan(r)) {
      i = d_cpu_y->size[0] * d_cpu_y->size[1];
      d_cpu_y->size[0] = 1;
      d_cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(d_cpu_y, i, &i_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(d_cpu_y, &gpu_y);
      d_cpu_y->data[0] = rtNaN;
      y_dirtyOnCpu = true;
    } else if (r < 0.0) {
      d_cpu_y->size[0] = 1;
      d_cpu_y->size[1] = 0;
    } else {
      i = d_cpu_y->size[0] * d_cpu_y->size[1];
      d_cpu_y->size[0] = 1;
      d_cpu_y->size[1] = static_cast<int32_T>(r) + 1;
      emxEnsureCapacity_real_T(d_cpu_y, i, &i_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(d_cpu_y, &gpu_y);
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(static_cast<
        int64_T>(r) + 1L), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ec_cwt_kernel65<<<grid, block>>>(r, gpu_y);
      }
    }

    emxInit_real_T(&e_cpu_y, 2, &qb_emlrtRTEI, true);
    i = e_cpu_y->size[0] * e_cpu_y->size[1];
    e_cpu_y->size[0] = 1;
    e_cpu_y->size[1] = d_cpu_y->size[1];
    emxEnsureCapacity_real_T(e_cpu_y, i, &j_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(e_cpu_y, &b_gpu_y);
    bcoef = d_cpu_y->size[1];
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (y_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_y, d_cpu_y);
      }

      ec_cwt_kernel66<<<grid, block>>>(gpu_y, rt_powd_snf(2.0, 1.0 /
        fb_VoicesPerOctave), bcoef, b_gpu_y);
    }

    emxFree_real_T(&d_cpu_y);
    i = cpu_fb_Scales->size[0] * cpu_fb_Scales->size[1];
    cpu_fb_Scales->size[0] = 1;
    cpu_fb_Scales->size[1] = e_cpu_y->size[1];
    emxEnsureCapacity_real_T(cpu_fb_Scales, i, &k_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales);
    k = e_cpu_y->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_cwt_kernel67<<<grid, block>>>(b_gpu_y, halfh, k, gpu_fb_Scales);
      fb_Scales_dirtyOnGpu = true;
    }

    emxFree_real_T(&e_cpu_y);
  } else {
    ec_cwt_kernel37<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*cpu_cv_gpu_clone, *
      gpu_wav, b[0], b[1], b[2], b[3], b[4]);
    omegac = 3.1415926535897931;
    a = 0.0;
    b_r = 0.0;
    cudaMemcpy(cpu_wav, *gpu_wav, 5UL, cudaMemcpyDeviceToHost);
    if (cpu_cv[static_cast<int32_T>(cpu_wav[0])] == 'm') {
      nbytes = 0;
    } else if (cpu_cv[static_cast<int32_T>(cpu_wav[0])] == 'a') {
      nbytes = 1;
    } else if (cpu_cv[static_cast<int32_T>(cpu_wav[0])] == 'b') {
      nbytes = 2;
    } else {
      nbytes = -1;
    }

    switch (nbytes) {
     case 0:
      a = 1.8820720577620569;
      c_r = 0.0057083835261;
      b_r = 0.0057083835261;
      r = 0.0057083835261;
      for (nsubs = 0; nsubs < 6; nsubs++) {
        maxScale = c[nsubs];
        c_r = c_r * 0.005353955978584176 + maxScale;
        b_r = b_r * 0.005353955978584176 + maxScale;
        r = r * 0.005353955978584176 + maxScale;
      }

      c_r /= 13.666666666666666;
      b_r /= 13.666666666666666;
      r /= 13.666666666666666;
      b_r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((c_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(b_r) || std::isnan(b_r)) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, cpu_interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ec_cwt_kernel38<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwt_kernel39<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*gpu_interval);
        interval_dirtyOnCpu = false;
        intDsq = 0.0;
        bcoef = 1;
        cudaMemcpy(cpu_interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        k = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (k > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            bcoef = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_dirtyOnCpu = true;
            r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (j = 0; j < bcoef; j++) {
              cpu_interval[n_idx_0 - j] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - j) * r;
            }
          }

          bcoef = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        nbytes = 0;
        for (j = 0; j < bcoef; j++) {
          if (std::abs(cpu_interval[j + 1] - cpu_interval[nbytes]) > 0.0) {
            nbytes++;
            cpu_interval[nbytes] = cpu_interval[j + 1];
            interval_dirtyOnCpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                       cudaMemcpyHostToDevice);
          }

          ec_cwt_kernel40<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(bcoef,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (k <= 0) {
          intDsq = rtNaN;
        } else {
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nsubs),
            &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                         cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, cpu_subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ec_cwt_kernel41<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnGpu = true;
            subs_dirtyOnCpu = false;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          emxInit_real_T(&f_cpu_x, 2, &f_emlrtRTEI, true);
          emxInit_real_T(&g_cpu_x, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&c_cpu_xt, 2, &ac_emlrtRTEI, true);
          emxInit_real_T(&i_cpu_y, 2, &bc_emlrtRTEI, true);
          emxInit_real_T(&c_cpu_fx, 2, &rb_emlrtRTEI, true);
          emxInit_real_T(&j_cpu_y, 2, &cc_emlrtRTEI, true);
          emxInit_real_T(&b_cpu_a, 2, &p_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv12, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&k_cpu_y, 2, &fc_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv14, 2, &ec_emlrtRTEI, true);
          do {
            exitg1 = 0;
            i = f_cpu_x->size[0] * f_cpu_x->size[1];
            f_cpu_x->size[0] = 1;
            f_cpu_x->size[1] = 15 * nsubs;
            emxEnsureCapacity_real_T(f_cpu_x, i, &f_emlrtRTEI);
            if (!d_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(f_cpu_x, &f_gpu_x);
            }

            nbytes = -1;
            for (k = 0; k < nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              maxScale = cpu_subs[k << 1];
              subs_dirtyOnGpu = false;
              r = cpu_subs[(k << 1) + 1];
              b_r = (maxScale + r) / 2.0;
              halfh = (r - maxScale) / 2.0;
              for (j = 0; j < 15; j++) {
                f_cpu_x->data[(nbytes + j) + 1] = NODES[j] * halfh + b_r;
                d_x_dirtyOnCpu = true;
              }

              nbytes += 15;
            }

            i = g_cpu_x->size[0] * g_cpu_x->size[1];
            g_cpu_x->size[0] = 1;
            g_cpu_x->size[1] = f_cpu_x->size[1];
            emxEnsureCapacity_real_T(g_cpu_x, i, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(g_cpu_x, &g_gpu_x);
            i = c_cpu_xt->size[0] * c_cpu_xt->size[1];
            c_cpu_xt->size[0] = 1;
            c_cpu_xt->size[1] = f_cpu_x->size[1];
            emxEnsureCapacity_real_T(c_cpu_xt, i, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(c_cpu_xt, &b_gpu_xt);
            nbytes = f_cpu_x->size[1];
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nbytes),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (d_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, f_cpu_x);
              }

              d_x_dirtyOnCpu = false;
              ec_cwt_kernel42<<<grid, block>>>(f_gpu_x, nbytes, b_gpu_xt,
                g_gpu_x);
              c_x_dirtyOnGpu = true;
              c_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (c_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(g_cpu_x, &g_gpu_x);
              }

              c_x_dirtyOnGpu = false;
              b_r = std::abs(g_cpu_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= g_cpu_x->size[1] - 2)) {
                tol = b_r;
                b_r = std::abs(g_cpu_x->data[k + 1]);
                if (std::abs(g_cpu_x->data[k + 1] - g_cpu_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(tol, b_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv3_idx_1 = static_cast<int16_T>(f_cpu_x->size[1]);
                i = c_cpu_fx->size[0] * c_cpu_fx->size[1];
                c_cpu_fx->size[0] = 1;
                c_cpu_fx->size[1] = f_cpu_x->size[1];
                emxEnsureCapacity_real_T(c_cpu_fx, i, &l_emlrtRTEI);
                if (!c_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(c_cpu_fx, &b_gpu_fx);
                }

                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                  (dv3_idx_1), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (c_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_fx, c_cpu_fx);
                  }

                  ec_cwt_kernel50<<<grid, block>>>(dv3_idx_1, b_gpu_fx);
                }

                exitg1 = 1;
              } else {
                b_guard1 = true;
              }
            } else {
              b_guard1 = true;
            }

            if (b_guard1) {
              first_iteration = false;
              i = i_cpu_y->size[0] * i_cpu_y->size[1];
              i_cpu_y->size[0] = 1;
              i_cpu_y->size[1] = g_cpu_x->size[1];
              emxEnsureCapacity_real_T(i_cpu_y, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(i_cpu_y, &g_gpu_y);
              bcoef = g_cpu_x->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel43<<<grid, block>>>(g_gpu_x, bcoef, g_gpu_y);
                c_y_dirtyOnGpu = true;
              }

              i = j_cpu_y->size[0] * j_cpu_y->size[1];
              j_cpu_y->size[0] = 1;
              j_cpu_y->size[1] = g_cpu_x->size[1];
              emxEnsureCapacity_real_T(j_cpu_y, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(j_cpu_y, &h_gpu_y);
              bcoef = g_cpu_x->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel44<<<grid, block>>>(g_gpu_x, bcoef, h_gpu_y);
                d_y_dirtyOnGpu = true;
              }

              if (i_cpu_y->size[1] == j_cpu_y->size[1]) {
                i = b_cpu_a->size[0] * b_cpu_a->size[1];
                b_cpu_a->size[0] = 1;
                b_cpu_a->size[1] = i_cpu_y->size[1];
                emxEnsureCapacity_real_T(b_cpu_a, i, &p_emlrtRTEI);
                if (!b_a_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(b_cpu_a, &gpu_a);
                }

                k = i_cpu_y->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (b_a_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, b_cpu_a);
                  }

                  ec_cwt_kernel45<<<grid, block>>>(h_gpu_y, g_gpu_y, k, gpu_a);
                  b_a_dirtyOnGpu = true;
                  b_a_dirtyOnCpu = false;
                }
              } else {
                if (b_a_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_cpu_a, &gpu_a);
                }

                if (c_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(i_cpu_y, &g_gpu_y);
                }

                c_y_dirtyOnGpu = false;
                if (d_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(j_cpu_y, &h_gpu_y);
                }

                d_y_dirtyOnGpu = false;
                c_binary_expand_op(b_cpu_a, i_cpu_y, j_cpu_y);
                b_a_dirtyOnCpu = true;
                b_a_dirtyOnGpu = false;
              }

              i = cpu_dv12->size[0] * cpu_dv12->size[1];
              cpu_dv12->size[0] = 1;
              cpu_dv12->size[1] = b_cpu_a->size[1];
              emxEnsureCapacity_real_T(cpu_dv12, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv12, &gpu_dv12);
              bcoef = b_cpu_a->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                if (b_a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, b_cpu_a);
                }

                b_a_dirtyOnCpu = false;
                ec_cwt_kernel46<<<grid, block>>>(gpu_a, bcoef, gpu_dv12);
                dv12_dirtyOnGpu = true;
              }

              i = k_cpu_y->size[0] * k_cpu_y->size[1];
              k_cpu_y->size[0] = 1;
              k_cpu_y->size[1] = g_cpu_x->size[1];
              emxEnsureCapacity_real_T(k_cpu_y, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(k_cpu_y, &i_gpu_y);
              bcoef = g_cpu_x->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel47<<<grid, block>>>(g_gpu_x, bcoef, i_gpu_y);
              }

              i = cpu_dv14->size[0] * cpu_dv14->size[1];
              cpu_dv14->size[0] = 1;
              cpu_dv14->size[1] = k_cpu_y->size[1];
              emxEnsureCapacity_real_T(cpu_dv14, i, &w_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv14, &gpu_dv14);
              k = k_cpu_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel48<<<grid, block>>>(i_gpu_y, k, gpu_dv14);
                dv14_dirtyOnGpu = true;
              }

              if (cpu_dv12->size[1] == cpu_dv14->size[1]) {
                i = c_cpu_fx->size[0] * c_cpu_fx->size[1];
                c_cpu_fx->size[0] = 1;
                c_cpu_fx->size[1] = cpu_dv12->size[1];
                emxEnsureCapacity_real_T(c_cpu_fx, i, &bb_emlrtRTEI);
                if (!c_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(c_cpu_fx, &b_gpu_fx);
                }

                k = cpu_dv12->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (c_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_fx, c_cpu_fx);
                  }

                  ec_cwt_kernel49<<<grid, block>>>(b_gpu_xt, gpu_dv14, gpu_dv12,
                    k, b_gpu_fx);
                  c_fx_dirtyOnGpu = true;
                  c_fx_dirtyOnCpu = false;
                }
              } else {
                if (c_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_cpu_fx, &b_gpu_fx);
                }

                if (dv12_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv12, &gpu_dv12);
                }

                dv12_dirtyOnGpu = false;
                if (dv14_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv14, &gpu_dv14);
                }

                dv14_dirtyOnGpu = false;
                if (c_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_cpu_xt, &b_gpu_xt);
                }

                c_xt_dirtyOnGpu = false;
                binary_expand_op(c_cpu_fx, cpu_dv12, cpu_dv14, c_cpu_xt);
                c_fx_dirtyOnCpu = true;
                c_fx_dirtyOnGpu = false;
              }

              b_r = 0.0;
              nbytes = -1;
              for (k = 0; k < nsubs; k++) {
                maxScale = 0.0;
                r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (c_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(c_cpu_fx, &b_gpu_fx);
                  }

                  maxScale += dv5[j] * c_cpu_fx->data[(nbytes + j) + 1];
                  c_fx_dirtyOnGpu = false;
                  r += dv6[j] * c_cpu_fx->data[(nbytes + j) + 1];
                }

                nbytes += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) / 2.0;
                maxScale *= halfh;
                qsub[k] = maxScale;
                b_r += maxScale;
                errsub[k] = r * halfh;
              }

              intDsq = b_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              b_r = 2.0 * tol;
              r = 0.0;
              nbytes = 0;
              for (k = 0; k < nsubs; k++) {
                maxScale = errsub[k];
                halfh = std::abs(maxScale);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= b_r * ((cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) /
                                    2.0)) {
                  err_ok += maxScale;
                  q_ok += qsub[k];
                } else {
                  r += halfh;
                  nbytes++;
                  cpu_subs[(nbytes - 1) << 1] = cpu_subs[k << 1];
                  cpu_subs[((nbytes - 1) << 1) + 1] = cpu_subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              b_r = std::abs(err_ok) + r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(b_r)) && (!std::isnan(b_r))) && (nbytes != 0) &&
                  (!(b_r <= tol))) {
                nsubs = nbytes << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nbytes; k++) {
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    cpu_subs[((((nbytes - k) << 1) - 1) << 1) + 1] = cpu_subs
                      [(((nbytes - k) - 1) << 1) + 1];
                    cpu_subs[(((nbytes - k) << 1) - 1) << 1] = (cpu_subs
                      [((nbytes - k) - 1) << 1] + cpu_subs[(((nbytes - k) - 1) <<
                      1) + 1]) / 2.0;
                    cpu_subs[((((nbytes - k) << 1) - 2) << 1) + 1] = cpu_subs
                      [(((nbytes - k) << 1) - 1) << 1];
                    cpu_subs[(((nbytes - k) << 1) - 2) << 1] = cpu_subs[((nbytes
                      - k) - 1) << 1];
                    subs_dirtyOnCpu = true;
                    subs_dirtyOnGpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&cpu_dv14);
          emxFree_real_T(&k_cpu_y);
          emxFree_real_T(&cpu_dv12);
          emxFree_real_T(&b_cpu_a);
          emxFree_real_T(&j_cpu_y);
          emxFree_real_T(&c_cpu_fx);
          emxFree_real_T(&i_cpu_y);
          emxFree_real_T(&c_cpu_xt);
          emxFree_real_T(&g_cpu_x);
          emxFree_real_T(&f_cpu_x);
        }

        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, cpu_interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ec_cwt_kernel51<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwt_kernel52<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*gpu_interval);
        interval_dirtyOnCpu = false;
        intFsq = 0.0;
        bcoef = 1;
        cudaMemcpy(cpu_interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        k = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (k > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            bcoef = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_dirtyOnCpu = true;
            r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (j = 0; j < bcoef; j++) {
              cpu_interval[n_idx_0 - j] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - j) * r;
            }
          }

          bcoef = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        nbytes = 0;
        for (j = 0; j < bcoef; j++) {
          if (std::abs(cpu_interval[j + 1] - cpu_interval[nbytes]) > 0.0) {
            nbytes++;
            cpu_interval[nbytes] = cpu_interval[j + 1];
            interval_dirtyOnCpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                       cudaMemcpyHostToDevice);
          }

          ec_cwt_kernel53<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(bcoef,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (k <= 0) {
          intFsq = rtNaN;
        } else {
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nsubs),
            &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                         cudaMemcpyHostToDevice);
            }

            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, cpu_subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ec_cwt_kernel54<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&h_cpu_x, 2, &f_emlrtRTEI, true);
          emxInit_real_T(&i_cpu_x, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&d_cpu_xt, 2, &ac_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv16, 2, &hc_emlrtRTEI, true);
          emxInit_real_T(&d_cpu_fx, 2, &rb_emlrtRTEI, true);
          emxInit_real_T(&l_cpu_y, 2, &ic_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv17, 2, &hc_emlrtRTEI, true);
          do {
            exitg1 = 0;
            i = h_cpu_x->size[0] * h_cpu_x->size[1];
            h_cpu_x->size[0] = 1;
            h_cpu_x->size[1] = 15 * nsubs;
            emxEnsureCapacity_real_T(h_cpu_x, i, &f_emlrtRTEI);
            if (!e_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(h_cpu_x, &d_gpu_x);
            }

            nbytes = -1;
            for (k = 0; k < nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              maxScale = cpu_subs[k << 1];
              subs_dirtyOnGpu = false;
              r = cpu_subs[(k << 1) + 1];
              b_r = (maxScale + r) / 2.0;
              halfh = (r - maxScale) / 2.0;
              for (j = 0; j < 15; j++) {
                h_cpu_x->data[(nbytes + j) + 1] = NODES[j] * halfh + b_r;
                e_x_dirtyOnCpu = true;
              }

              nbytes += 15;
            }

            i = i_cpu_x->size[0] * i_cpu_x->size[1];
            i_cpu_x->size[0] = 1;
            i_cpu_x->size[1] = h_cpu_x->size[1];
            emxEnsureCapacity_real_T(i_cpu_x, i, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(i_cpu_x, &e_gpu_x);
            i = d_cpu_xt->size[0] * d_cpu_xt->size[1];
            d_cpu_xt->size[0] = 1;
            d_cpu_xt->size[1] = h_cpu_x->size[1];
            emxEnsureCapacity_real_T(d_cpu_xt, i, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_cpu_xt, &gpu_xt);
            nbytes = h_cpu_x->size[1];
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nbytes),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (e_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_x, h_cpu_x);
              }

              e_x_dirtyOnCpu = false;
              ec_cwt_kernel55<<<grid, block>>>(d_gpu_x, nbytes, gpu_xt, e_gpu_x);
              d_x_dirtyOnGpu = true;
              d_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (d_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_cpu_x, &e_gpu_x);
              }

              d_x_dirtyOnGpu = false;
              b_r = std::abs(i_cpu_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= i_cpu_x->size[1] - 2)) {
                tol = b_r;
                b_r = std::abs(i_cpu_x->data[k + 1]);
                if (std::abs(i_cpu_x->data[k + 1] - i_cpu_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(tol, b_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv3_idx_1 = static_cast<int16_T>(h_cpu_x->size[1]);
                i = d_cpu_fx->size[0] * d_cpu_fx->size[1];
                d_cpu_fx->size[0] = 1;
                d_cpu_fx->size[1] = h_cpu_x->size[1];
                emxEnsureCapacity_real_T(d_cpu_fx, i, &l_emlrtRTEI);
                if (!d_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_cpu_fx, &gpu_fx);
                }

                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                  (dv3_idx_1), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (d_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_fx, d_cpu_fx);
                  }

                  ec_cwt_kernel60<<<grid, block>>>(dv3_idx_1, gpu_fx);
                }

                exitg1 = 1;
              } else {
                b_guard1 = true;
              }
            } else {
              b_guard1 = true;
            }

            if (b_guard1) {
              first_iteration = false;
              i = cpu_dv16->size[0] * cpu_dv16->size[1];
              cpu_dv16->size[0] = 1;
              cpu_dv16->size[1] = i_cpu_x->size[1];
              emxEnsureCapacity_real_T(cpu_dv16, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv16, &gpu_dv16);
              bcoef = i_cpu_x->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel56<<<grid, block>>>(e_gpu_x, bcoef, gpu_dv16);
                dv16_dirtyOnGpu = true;
              }

              i = l_cpu_y->size[0] * l_cpu_y->size[1];
              l_cpu_y->size[0] = 1;
              l_cpu_y->size[1] = i_cpu_x->size[1];
              emxEnsureCapacity_real_T(l_cpu_y, i, &j_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(l_cpu_y, &f_gpu_y);
              bcoef = i_cpu_x->size[1];
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel57<<<grid, block>>>(e_gpu_x, bcoef, f_gpu_y);
              }

              i = cpu_dv17->size[0] * cpu_dv17->size[1];
              cpu_dv17->size[0] = 1;
              cpu_dv17->size[1] = l_cpu_y->size[1];
              emxEnsureCapacity_real_T(cpu_dv17, i, &x_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv17, &gpu_dv17);
              k = l_cpu_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ec_cwt_kernel58<<<grid, block>>>(f_gpu_y, k, gpu_dv17);
                dv17_dirtyOnGpu = true;
              }

              if (cpu_dv16->size[1] == cpu_dv17->size[1]) {
                i = d_cpu_fx->size[0] * d_cpu_fx->size[1];
                d_cpu_fx->size[0] = 1;
                d_cpu_fx->size[1] = cpu_dv16->size[1];
                emxEnsureCapacity_real_T(d_cpu_fx, i, &bb_emlrtRTEI);
                if (!d_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_cpu_fx, &gpu_fx);
                }

                bcoef = cpu_dv16->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef
                  + 1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (d_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_fx, d_cpu_fx);
                  }

                  ec_cwt_kernel59<<<grid, block>>>(gpu_xt, gpu_dv17, gpu_dv16,
                    bcoef, gpu_fx);
                  d_fx_dirtyOnGpu = true;
                  d_fx_dirtyOnCpu = false;
                }
              } else {
                if (d_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_cpu_fx, &gpu_fx);
                }

                if (dv16_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv16, &gpu_dv16);
                }

                dv16_dirtyOnGpu = false;
                if (dv17_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv17, &gpu_dv17);
                }

                dv17_dirtyOnGpu = false;
                if (d_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_cpu_xt, &gpu_xt);
                }

                d_xt_dirtyOnGpu = false;
                binary_expand_op(d_cpu_fx, cpu_dv16, cpu_dv17, d_cpu_xt);
                d_fx_dirtyOnCpu = true;
                d_fx_dirtyOnGpu = false;
              }

              b_r = 0.0;
              nbytes = -1;
              for (k = 0; k < nsubs; k++) {
                maxScale = 0.0;
                r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (d_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(d_cpu_fx, &gpu_fx);
                  }

                  maxScale += dv5[j] * d_cpu_fx->data[(nbytes + j) + 1];
                  d_fx_dirtyOnGpu = false;
                  r += dv6[j] * d_cpu_fx->data[(nbytes + j) + 1];
                }

                nbytes += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) / 2.0;
                maxScale *= halfh;
                qsub[k] = maxScale;
                b_r += maxScale;
                errsub[k] = r * halfh;
              }

              intFsq = b_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              b_r = 2.0 * tol;
              r = 0.0;
              nbytes = 0;
              for (k = 0; k < nsubs; k++) {
                maxScale = errsub[k];
                halfh = std::abs(maxScale);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= b_r * ((cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) /
                                    2.0)) {
                  err_ok += maxScale;
                  q_ok += qsub[k];
                } else {
                  r += halfh;
                  nbytes++;
                  cpu_subs[(nbytes - 1) << 1] = cpu_subs[k << 1];
                  cpu_subs[((nbytes - 1) << 1) + 1] = cpu_subs[(k << 1) + 1];
                }
              }

              b_r = std::abs(err_ok) + r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(b_r)) && (!std::isnan(b_r))) && (nbytes != 0) &&
                  (!(b_r <= tol))) {
                nsubs = nbytes << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nbytes; k++) {
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    cpu_subs[((((nbytes - k) << 1) - 1) << 1) + 1] = cpu_subs
                      [(((nbytes - k) - 1) << 1) + 1];
                    cpu_subs[(((nbytes - k) << 1) - 1) << 1] = (cpu_subs
                      [((nbytes - k) - 1) << 1] + cpu_subs[(((nbytes - k) - 1) <<
                      1) + 1]) / 2.0;
                    cpu_subs[((((nbytes - k) << 1) - 2) << 1) + 1] = cpu_subs
                      [(((nbytes - k) << 1) - 1) << 1];
                    cpu_subs[(((nbytes - k) << 1) - 2) << 1] = cpu_subs[((nbytes
                      - k) - 1) << 1];
                    subs_dirtyOnGpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&cpu_dv17);
          emxFree_real_T(&l_cpu_y);
          emxFree_real_T(&d_cpu_fx);
          emxFree_real_T(&cpu_dv16);
          emxFree_real_T(&d_cpu_xt);
          emxFree_real_T(&i_cpu_x);
          emxFree_real_T(&h_cpu_x);
        }

        b_r = std::sqrt(3.5421952306087032 * (intDsq / intFsq));
      }
      break;

     case 1:
      a = 6.0;
      b_r = 1.4142135623730951;
      break;

     case 2:
      a = 5.0;
      b_r = 5.847705;
      break;
    }

    maxScale = static_cast<real_T>(cpu_x->size[0]) / (b_r * 2.0);
    first_iteration = false;
    bcoef = 0;
    do {
      exitg1 = 0;
      if (bcoef + 1 < 6) {
        if (cpu_wav[bcoef] != cv4[bcoef]) {
          exitg1 = 1;
        } else {
          bcoef++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      bcoef = 0;
    } else {
      bcoef = -1;
    }

    if (bcoef == 0) {
      r = 2.0 * (static_cast<real_T>(fb_CutOff) / 100.0);
      if (r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
          (-rt_powd_snf(a, 3.0)) >= 0.0) {
        if (r == r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
            (-rt_powd_snf(a, 3.0))) {
          omegac = 9.0856029641606977;
        } else {
          omegac = a;
        }
      } else {
        omegac = 9.0856029641606977;
        b_r = r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
          (-rt_powd_snf(a, 3.0));
        q_ok = r;
        if (b_r == 0.0) {
          omegac = a;
        } else {
          err_ok = r;
          intFsq = 9.0856029641606977;
          intDsq = 0.0;
          d = 0.0;
          exitg2 = false;
          while ((!exitg2) && ((q_ok != 0.0) && (a != omegac))) {
            if ((q_ok > 0.0) == (err_ok > 0.0)) {
              intFsq = a;
              err_ok = b_r;
              d = omegac - a;
              intDsq = d;
            }

            if (std::abs(err_ok) < std::abs(q_ok)) {
              a = omegac;
              omegac = intFsq;
              intFsq = a;
              b_r = q_ok;
              q_ok = err_ok;
              err_ok = b_r;
            }

            m = 0.5 * (intFsq - omegac);
            toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(m) <= toler) || (q_ok == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(intDsq) < toler) || (std::abs(b_r) <= std::abs(q_ok)))
              {
                d = m;
                intDsq = m;
              } else {
                s = q_ok / b_r;
                if (a == intFsq) {
                  b_r = 2.0 * m * s;
                  tol = 1.0 - s;
                } else {
                  tol = b_r / err_ok;
                  c_r = q_ok / err_ok;
                  b_r = s * (2.0 * m * tol * (tol - c_r) - (omegac - a) * (c_r -
                              1.0));
                  tol = (tol - 1.0) * (c_r - 1.0) * (s - 1.0);
                }

                if (b_r > 0.0) {
                  tol = -tol;
                } else {
                  b_r = -b_r;
                }

                if ((2.0 * b_r < 3.0 * m * tol - std::abs(toler * tol)) && (b_r <
                     std::abs(0.5 * intDsq * tol))) {
                  intDsq = d;
                  d = b_r / tol;
                } else {
                  d = m;
                  intDsq = m;
                }
              }

              a = omegac;
              b_r = q_ok;
              if (std::abs(d) > toler) {
                omegac += d;
              } else if (omegac > intFsq) {
                omegac -= toler;
              } else {
                omegac += toler;
              }

              q_ok = r - 0.0050536085896138528 * rt_powd_snf(omegac, 20.0) * std::
                exp(-rt_powd_snf(omegac, 3.0));
            }
          }
        }
      }
    }

    halfh = omegac / 3.1415926535897931;
    if (maxScale < halfh * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave)) {
      maxScale = halfh * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave);
    }

    tol = maxScale / halfh;
    if (tol == 0.0) {
      tol = rtMinusInf;
    } else if (tol < 0.0) {
      tol = rtNaN;
    } else if ((!std::isinf(tol)) && (!std::isnan(tol))) {
      tol = std::frexp(tol, &c_eint);
      if (tol == 0.5) {
        tol = static_cast<real_T>(c_eint) - 1.0;
      } else if ((c_eint == 1) && (tol < 0.75)) {
        tol = std::log(2.0 * tol) / 0.69314718055994529;
      } else {
        tol = std::log(tol) / 0.69314718055994529 + static_cast<real_T>(c_eint);
      }
    }

    emxInit_real_T(&g_cpu_y, 2, &ub_emlrtRTEI, true);
    r = std::fmax(tol, 1.0 / fb_VoicesPerOctave) * fb_VoicesPerOctave;
    if (std::isnan(r)) {
      i = g_cpu_y->size[0] * g_cpu_y->size[1];
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(g_cpu_y, i, &i_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(g_cpu_y, &d_gpu_y);
      g_cpu_y->data[0] = rtNaN;
      b_y_dirtyOnCpu = true;
    } else if (r < 0.0) {
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = 0;
    } else {
      i = g_cpu_y->size[0] * g_cpu_y->size[1];
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = static_cast<int32_T>(r) + 1;
      emxEnsureCapacity_real_T(g_cpu_y, i, &i_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(g_cpu_y, &d_gpu_y);
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
        (static_cast<int64_T>(r) + 1L), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ec_cwt_kernel61<<<grid, block>>>(r, d_gpu_y);
      }
    }

    emxInit_real_T(&h_cpu_y, 2, &wb_emlrtRTEI, true);
    i = h_cpu_y->size[0] * h_cpu_y->size[1];
    h_cpu_y->size[0] = 1;
    h_cpu_y->size[1] = g_cpu_y->size[1];
    emxEnsureCapacity_real_T(h_cpu_y, i, &j_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(h_cpu_y, &e_gpu_y);
    bcoef = g_cpu_y->size[1];
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (b_y_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_y, g_cpu_y);
      }

      ec_cwt_kernel62<<<grid, block>>>(d_gpu_y, rt_powd_snf(2.0, 1.0 /
        fb_VoicesPerOctave), bcoef, e_gpu_y);
    }

    emxFree_real_T(&g_cpu_y);
    i = cpu_fb_Scales->size[0] * cpu_fb_Scales->size[1];
    cpu_fb_Scales->size[0] = 1;
    cpu_fb_Scales->size[1] = h_cpu_y->size[1];
    emxEnsureCapacity_real_T(cpu_fb_Scales, i, &k_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales);
    k = h_cpu_y->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_cwt_kernel63<<<grid, block>>>(e_gpu_y, halfh, k, gpu_fb_Scales);
      fb_Scales_dirtyOnGpu = true;
    }

    emxFree_real_T(&h_cpu_y);
  }

  first_iteration = false;
  bcoef = 0;
  do {
    exitg1 = 0;
    if (bcoef + 1 < 6) {
      if (cpu_cv[static_cast<int32_T>(b[bcoef])] != cpu_cv[static_cast<int32_T>
          (cv3[bcoef])]) {
        exitg1 = 1;
      } else {
        bcoef++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  emxInit_real_T(&cpu_psidft, 2, &rb_emlrtRTEI, true);
  emxInit_real_T(&cpu_f, 2, &sb_emlrtRTEI, true);
  if (first_iteration) {
    emxInit_real_T(&cpu_somega, 2, &tb_emlrtRTEI, true);
    if (cpu_fb_Scales->size[1] == 1) {
      i = cpu_somega->size[0] * cpu_somega->size[1];
      cpu_somega->size[0] = 1;
      if (cpu_omega->size[1] == 1) {
        cpu_somega->size[1] = 1;
      } else {
        cpu_somega->size[1] = cpu_omega->size[1];
      }

      emxEnsureCapacity_real_T(cpu_somega, i, &o_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_somega, &gpu_somega);
      bcoef = (cpu_omega->size[1] != 1);
      nbytes = cpu_somega->size[1] - 1;
      for (k = 0; k <= nbytes; k++) {
        if (fb_Scales_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
        }

        fb_Scales_dirtyOnGpu = false;
        if (omega_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_omega, &gpu_omega);
        }

        omega_dirtyOnGpu = false;
        cpu_somega->data[k] = cpu_fb_Scales->data[0] * cpu_omega->data[bcoef * k];
        somega_dirtyOnCpu = true;
      }
    } else {
      i = cpu_somega->size[0] * cpu_somega->size[1];
      cpu_somega->size[0] = cpu_fb_Scales->size[1];
      cpu_somega->size[1] = cpu_omega->size[1];
      emxEnsureCapacity_real_T(cpu_somega, i, &n_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_somega, &gpu_somega);
      j = cpu_omega->size[1];
      bcoef = cpu_fb_Scales->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((bcoef + 1L) *
        j), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ec_cwt_kernel70<<<grid, block>>>(gpu_omega, gpu_fb_Scales, bcoef, j,
          gpu_somega, cpu_somega->size[0U]);
        somega_dirtyOnGpu = true;
      }
    }

    bcoef = cpu_somega->size[0] * cpu_somega->size[1];
    for (k = 0; k < 2; k++) {
      cpu_xSize[k] = static_cast<uint32_T>(cpu_somega->size[k]);
      xSize_dirtyOnCpu = true;
    }

    emxInit_real_T(&cpu_absomega, 2, &vb_emlrtRTEI, true);
    i = cpu_absomega->size[0] * cpu_absomega->size[1];
    cpu_absomega->size[0] = static_cast<int32_T>(cpu_xSize[0]);
    cpu_absomega->size[1] = static_cast<int32_T>(cpu_xSize[1]);
    emxEnsureCapacity_real_T(cpu_absomega, i, &s_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_absomega, &gpu_absomega);
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (somega_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, cpu_somega);
      }

      somega_dirtyOnCpu = false;
      ec_cwt_kernel71<<<grid, block>>>(gpu_somega, bcoef, gpu_absomega);
      absomega_dirtyOnGpu = true;
    }

    emxInit_real_T(&cpu_powscales, 2, &u_emlrtRTEI, true);
    i = cpu_powscales->size[0] * cpu_powscales->size[1];
    cpu_powscales->size[0] = cpu_absomega->size[0];
    cpu_powscales->size[1] = cpu_absomega->size[1];
    emxEnsureCapacity_real_T(cpu_powscales, i, &u_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_powscales, &gpu_powscales);
    bcoef = cpu_absomega->size[0] * cpu_absomega->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_cwt_kernel72<<<grid, block>>>(gpu_absomega, bcoef, gpu_powscales);
      powscales_dirtyOnGpu = true;
    }

    bcoef = cpu_absomega->size[0] * cpu_absomega->size[1];
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_cwt_kernel73<<<grid, block>>>(bcoef, gpu_absomega);
      absomega_dirtyOnGpu = true;
    }

    emxInit_real_T(&j_cpu_x, 2, &y_emlrtRTEI, true);
    if ((cpu_absomega->size[0] == cpu_powscales->size[0]) && (cpu_absomega->
         size[1] == cpu_powscales->size[1])) {
      i = j_cpu_x->size[0] * j_cpu_x->size[1];
      j_cpu_x->size[0] = cpu_absomega->size[0];
      j_cpu_x->size[1] = cpu_absomega->size[1];
      emxEnsureCapacity_real_T(j_cpu_x, i, &y_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(j_cpu_x, &gpu_x);
      bcoef = cpu_absomega->size[0] * cpu_absomega->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
        &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ec_cwt_kernel74<<<grid, block>>>(gpu_powscales, gpu_absomega, bcoef,
          gpu_x);
        e_x_dirtyOnGpu = true;
      }
    } else {
      if (absomega_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_absomega, &gpu_absomega);
      }

      if (powscales_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_powscales, &gpu_powscales);
      }

      b_binary_expand_op(j_cpu_x, cpu_absomega, cpu_powscales);
      f_x_dirtyOnCpu = true;
    }

    emxFree_real_T(&cpu_powscales);
    emxFree_real_T(&cpu_absomega);
    bcoef = j_cpu_x->size[0] * j_cpu_x->size[1];
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (f_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, j_cpu_x);
      }

      ec_cwt_kernel75<<<grid, block>>>(bcoef, gpu_x);
      e_x_dirtyOnGpu = true;
      f_x_dirtyOnCpu = false;
    }

    if ((j_cpu_x->size[0] == cpu_somega->size[0]) && (j_cpu_x->size[1] ==
         cpu_somega->size[1])) {
      i = cpu_psidft->size[0] * cpu_psidft->size[1];
      cpu_psidft->size[0] = j_cpu_x->size[0];
      cpu_psidft->size[1] = j_cpu_x->size[1];
      emxEnsureCapacity_real_T(cpu_psidft, i, &cb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_psidft, &gpu_psidft);
      bcoef = j_cpu_x->size[0] * j_cpu_x->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
        &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (somega_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, cpu_somega);
        }

        if (f_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, j_cpu_x);
        }

        ec_cwt_kernel76<<<grid, block>>>(gpu_somega, gpu_x, bcoef, gpu_psidft);
      }
    } else {
      if (e_x_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(j_cpu_x, &gpu_x);
      }

      if (somega_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_somega, &gpu_somega);
      }

      binary_expand_op(cpu_psidft, j_cpu_x, cpu_somega);
      psidft_dirtyOnCpu = true;
    }

    emxFree_real_T(&j_cpu_x);
    emxFree_real_T(&cpu_somega);
    i = cpu_f->size[0] * cpu_f->size[1];
    cpu_f->size[0] = 1;
    cpu_f->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real_T(cpu_f, i, &db_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f);
    bcoef = cpu_fb_Scales->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_cwt_kernel77<<<grid, block>>>(gpu_fb_Scales, bcoef, gpu_f);
    }
  } else {
    i = cpu_psidft->size[0] * cpu_psidft->size[1];
    cpu_psidft->size[0] = cpu_fb_Scales->size[1];
    cpu_psidft->size[1] = cpu_omega->size[1];
    emxEnsureCapacity_real_T(cpu_psidft, i, &m_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_psidft, &gpu_psidft);
    bcoef = cpu_fb_Scales->size[1] * cpu_omega->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_cwt_kernel68<<<grid, block>>>(bcoef, gpu_psidft);
    }

    i = cpu_f->size[0] * cpu_f->size[1];
    cpu_f->size[0] = 1;
    cpu_f->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real_T(cpu_f, i, &q_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f);
    bcoef = cpu_fb_Scales->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_cwt_kernel69<<<grid, block>>>(gpu_fb_Scales, bcoef, gpu_f);
    }
  }

  emxFree_real_T(&cpu_omega);
  emxFree_real_T(&cpu_fb_Scales);
  i = cpu_f->size[0] * cpu_f->size[1];
  cpu_f->size[0] = 1;
  emxEnsureCapacity_real_T(cpu_f, i, &r_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f);
  i = cpu_f->size[1] - 1;
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L), &grid,
    &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ec_cwt_kernel78<<<grid, block>>>(fs, i, gpu_f);
  }

  // 'ec_cwt:30' freqs = centerFrequencies(fb);
  i = cpu_freqs->size[0];
  cpu_freqs->size[0] = cpu_f->size[1];
  emxEnsureCapacity_real_T(cpu_freqs, i, &t_emlrtRTEI);
  bcoef = cpu_f->size[1] - 1;
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L), &grid,
    &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    gpuEmxMemcpyCpuToGpu_real_T(&gpu_freqs, cpu_freqs);
    ec_cwt_kernel79<<<grid, block>>>(gpu_f, bcoef, gpu_freqs);
    freqs_dirtyOnGpu = true;
  }

  // 'ec_cwt:31' nFreqs = uint32(numel(freqs));
  // 'ec_cwt:32' nFrames = uint32(numel(1:ds2:nFrames));
  emxInit_real_T(&cpu_dv1, 2, &xb_emlrtRTEI, true);
  if (std::isnan(ds2)) {
    i = cpu_dv1->size[0] * cpu_dv1->size[1];
    cpu_dv1->size[1] = 1;
    emxEnsureCapacity_real_T(cpu_dv1, i, &v_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1);
  } else if ((ds2 == 0.0) || ((cpu_x->size[0] > 1) && (ds2 < 0.0)) ||
             ((cpu_x->size[0] < 1) && (ds2 > 0.0))) {
    cpu_dv1->size[1] = 0;
  } else if (std::isinf(ds2)) {
    i = cpu_dv1->size[0] * cpu_dv1->size[1];
    cpu_dv1->size[1] = 1;
    emxEnsureCapacity_real_T(cpu_dv1, i, &v_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1);
  } else {
    i = cpu_x->size[0];
    nsubs = cpu_dv1->size[0] * cpu_dv1->size[1];
    cpu_dv1->size[0] = 1;
    cpu_dv1->size[1] = static_cast<int32_T>((static_cast<real_T>(cpu_x->size[0])
      - 1.0) / ds2) + 1;
    emxEnsureCapacity_real_T(cpu_dv1, nsubs, &v_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1);
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
      (static_cast<int64_T>((static_cast<real_T>(i) - 1.0) / ds2) + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_cwt_kernel80<<<grid, block>>>(ds2, i, gpu_dv1);
    }
  }

  //  Preallocate
  // 'ec_cwt:35' xx = coder.nullcopy(zeros([nFrames nChs nFreqs],like=x));
  i = cpu_xx->size[0] * cpu_xx->size[1] * cpu_xx->size[2];
  cpu_xx->size[0] = cpu_dv1->size[1];
  emxFree_real_T(&cpu_dv1);
  cpu_xx->size[1] = static_cast<int32_T>(nChs);
  cpu_xx->size[2] = cpu_f->size[1];
  emxFree_real_T(&cpu_f);
  emxEnsureCapacity_real_T(cpu_xx, i, &ab_emlrtRTEI);

  //  Preallocate output
  //  xx = cell(1,nChs);
  //  CWT per channel
  // 'ec_cwt:39' coder.gpu.kernel(nChs,-1)
  // 'ec_cwt:40' for ch = 1:nChs
  emxInit_creal_T(&cpu_cfspos, 2, &jb_emlrtRTEI, true);
  if (computeEndIdx(1L, static_cast<int64_T>(nChs), 1L) >= 0L) {
    csz_idx_0 = cpu_psidft->size[0];
  }

  emxInit_real_T(&cpu_xv, 2, &eb_emlrtRTEI, true);
  emxInit_creal_T(&cpu_xposdft, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&k_cpu_x, 2, &hb_emlrtRTEI, true);
  emxInit_creal_T(&cpu_cfsposdft, 2, &dc_emlrtRTEI, true);
  emxInit_real_T(&m_cpu_y, 2, &gc_emlrtRTEI, true);
  emxInit_real_T(&cpu_xCh, 2, &lb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_xCh, 2, &mb_emlrtRTEI, true);
  e = computeEndIdx(1L, static_cast<int64_T>(nChs), 1L);
  for (int64_T ch{0L}; ch <= e; ch++) {
    // 'ec_cwt:41' coder.gpu.constantMemory(xx);
    // 'ec_cwt:42' xCh = abs(wt(fb,x(:,ch)))';
    i = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    cpu_xv->size[1] = cpu_x->size[0];
    emxEnsureCapacity_real_T(cpu_xv, i, &eb_emlrtRTEI);
    if (!xv_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv);
    }

    bcoef = cpu_x->size[0] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
      }

      x_dirtyOnCpu = false;
      if (xv_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, cpu_xv);
      }

      ec_cwt_kernel81<<<grid, block>>>(static_cast<int32_T>(ch + 1L), b_gpu_x,
        bcoef, gpu_xv, cpu_x->size[0U]);
      xv_dirtyOnGpu = true;
      xv_dirtyOnCpu = false;
    }

    if (fb_SignalPad > 0) {
      nsubs = cpu_x->size[0] - fb_SignalPad;
      if (nsubs + 1 > cpu_x->size[0]) {
        eint = 0;
        b_eint = 1;
        nsubs = -1;
      } else {
        eint = cpu_x->size[0] - 1;
        b_eint = -1;
      }

      i = k_cpu_x->size[0] * k_cpu_x->size[1];
      k_cpu_x->size[0] = 1;
      k_cpu_x->size[1] = fb_SignalPad;
      emxEnsureCapacity_real_T(k_cpu_x, i, &hb_emlrtRTEI);
      if (!g_x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(k_cpu_x, &c_gpu_x);
      }

      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(fb_SignalPad),
        &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
        }

        x_dirtyOnCpu = false;
        if (g_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, k_cpu_x);
        }

        ec_cwt_kernel82<<<grid, block>>>(static_cast<int32_T>(ch + 1L), b_gpu_x,
          fb_SignalPad, c_gpu_x, cpu_x->size[0U]);
        f_x_dirtyOnGpu = true;
        g_x_dirtyOnCpu = false;
      }

      bcoef = fb_SignalPad >> 1;
      for (k = 0; k < bcoef; k++) {
        nbytes = (fb_SignalPad - k) - 1;
        if (f_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(k_cpu_x, &c_gpu_x);
        }

        r = k_cpu_x->data[k];
        k_cpu_x->data[k] = k_cpu_x->data[nbytes];
        k_cpu_x->data[nbytes] = r;
        g_x_dirtyOnCpu = true;
        f_x_dirtyOnGpu = false;
      }

      i = cpu_xv->size[0] * cpu_xv->size[1];
      cpu_xv->size[0] = 1;
      cpu_xv->size[1] = ((cpu_x->size[0] + k_cpu_x->size[1]) + div_s32(nsubs -
        eint, b_eint)) + 1;
      emxEnsureCapacity_real_T(cpu_xv, i, &ib_emlrtRTEI);
      if (!xv_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv);
      }

      j = k_cpu_x->size[1];
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(j), &grid,
        &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (g_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, k_cpu_x);
        }

        g_x_dirtyOnCpu = false;
        if (xv_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, cpu_xv);
        }

        ec_cwt_kernel83<<<grid, block>>>(c_gpu_x, j, gpu_xv);
        xv_dirtyOnGpu = true;
        xv_dirtyOnCpu = false;
      }

      j = cpu_x->size[0];
      for (i = 0; i < j; i++) {
        if (xv_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xv, &gpu_xv);
        }

        cpu_xv->data[i + k_cpu_x->size[1]] = cpu_x->data[i + cpu_x->size[0] * (
          static_cast<int32_T>(ch + 1L) - 1)];
        xv_dirtyOnCpu = true;
        xv_dirtyOnGpu = false;
      }

      j = div_s32(nsubs - eint, b_eint);
      for (i = 0; i <= j; i++) {
        if (xv_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xv, &gpu_xv);
        }

        cpu_xv->data[(i + cpu_x->size[0]) + k_cpu_x->size[1]] = cpu_x->data
          [(eint + b_eint * i) + cpu_x->size[0] * (static_cast<int32_T>(ch + 1L)
          - 1)];
        xv_dirtyOnCpu = true;
        xv_dirtyOnGpu = false;
      }
    }

    if (cpu_xv->size[1] - (static_cast<int32_T>(static_cast<uint32_T>
          (cpu_xv->size[1]) >> 1) << 1) == 1) {
      cufftHandle b_fftPlanHandle;
      cufftType b_fftType;
      int fftDirection;
      i = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = cpu_xv->size[1];
      emxEnsureCapacity_creal_T(cpu_xposdft, i, &fb_emlrtRTEI);
      if (!xposdft_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal_T(cpu_xposdft, &gpu_xposdft);
      }

      bcoef = cpu_xv->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
        &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (xv_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, cpu_xv);
        }

        xv_dirtyOnCpu = false;
        if (xposdft_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_xposdft, cpu_xposdft);
        }

        ec_cwt_kernel84<<<grid, block>>>(gpu_xv, bcoef, gpu_xposdft);
        xposdft_dirtyOnCpu = false;
      }

      nbytes = cpu_xposdft->size[1];
      fftDirection = CUFFT_FORWARD;
      b_fftType = CUFFT_Z2Z;
      b_fftPlanHandle = acquireCUFFTPlan(1, &nbytes, &nbytes, 1, 1, b_fftType, 1);
      if (xposdft_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_xposdft, cpu_xposdft);
      }

      cufftExecZ2Z(b_fftPlanHandle, (cufftDoubleComplex *)&gpu_xposdft.data[0],
                   (cufftDoubleComplex *)&gpu_xposdft.data[0], fftDirection);
      xposdft_dirtyOnCpu = false;
    } else {
      cufftHandle fftPlanHandle;
      cufftType fftType;
      nbytes = cpu_xv->size[1];
      for (k = 0; k < 2; k++) {
        cpu_xSize[k] = static_cast<uint32_T>(cpu_xv->size[k]);
        xSize_dirtyOnCpu = true;
      }

      i = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = static_cast<int32_T>(cpu_xSize[1]);
      emxEnsureCapacity_creal_T(cpu_xposdft, i, &gb_emlrtRTEI);
      if (!xposdft_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal_T(cpu_xposdft, &gpu_xposdft);
      }

      fftType = CUFFT_D2Z;
      fftPlanHandle = acquireCUFFTPlan(1, &nbytes, &nbytes, 1, 1, fftType, 1);
      if (xv_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, cpu_xv);
      }

      xv_dirtyOnCpu = false;
      if (xposdft_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_xposdft, cpu_xposdft);
      }

      cufftExecD2Z(fftPlanHandle, (cufftDoubleReal *)&gpu_xv.data[0],
                   (cufftDoubleComplex *)&gpu_xposdft.data[0]);
      b_dirtyOnGpu = true;
      xposdft_dirtyOnCpu = false;
      nbytes = static_cast<int32_T>(static_cast<real_T>(static_cast<int32_T>
        (cpu_xSize[1]) + 1) / 2.0);
      for (nsubs = 0; nsubs <= nbytes - 2; nsubs++) {
        if (b_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_creal_T(cpu_xposdft, &gpu_xposdft);
        }

        cpu_xposdft->data[(static_cast<int32_T>(cpu_xSize[1]) - nsubs) - 1].re =
          cpu_xposdft->data[nsubs + 1].re;
        cpu_xposdft->data[(static_cast<int32_T>(cpu_xSize[1]) - nsubs) - 1].im =
          -cpu_xposdft->data[nsubs + 1].im;
        xposdft_dirtyOnCpu = true;
        b_dirtyOnGpu = false;
      }
    }

    nbytes = cpu_psidft->size[1];
    bcoef = cpu_xposdft->size[1];
    if (nbytes <= bcoef) {
      bcoef = nbytes;
    }

    if (cpu_psidft->size[1] == 1) {
      i = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == cpu_psidft->size[1]) {
      i = cpu_xposdft->size[1];
    } else {
      i = bcoef;
    }

    nsubs = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
    cpu_cfsposdft->size[0] = csz_idx_0;
    nbytes = cpu_psidft->size[1];
    bcoef = cpu_xposdft->size[1];
    if (nbytes <= bcoef) {
      bcoef = nbytes;
    }

    if (cpu_psidft->size[1] == 1) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == cpu_psidft->size[1]) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else {
      cpu_cfsposdft->size[1] = bcoef;
    }

    emxEnsureCapacity_creal_T(cpu_cfsposdft, nsubs, &o_emlrtRTEI);
    gpuEmxEnsureCapacity_creal_T(cpu_cfsposdft, &gpu_cfsposdft);
    if ((csz_idx_0 != 0) && (i != 0)) {
      bcoef = (cpu_psidft->size[1] != 1);
      nbytes = i - 1;
      k = cpu_cfsposdft->size[0] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k + 1L) *
        (nbytes + 1L)), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (xposdft_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_xposdft, cpu_xposdft);
        }

        xposdft_dirtyOnCpu = false;
        if (psidft_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_psidft, cpu_psidft);
        }

        psidft_dirtyOnCpu = false;
        ec_cwt_kernel85<<<grid, block>>>(gpu_xposdft, gpu_psidft, bcoef, k, i -
          1, gpu_cfsposdft, cpu_psidft->size[0U], cpu_cfsposdft->size[0U]);
      }
    }

    if ((cpu_cfsposdft->size[0] == 0) || (cpu_cfsposdft->size[1] == 0)) {
      for (k = 0; k < 2; k++) {
        cpu_xSize[k] = static_cast<uint32_T>(cpu_cfsposdft->size[k]);
        xSize_dirtyOnCpu = true;
      }

      if (xSize_dirtyOnCpu) {
        cudaMemcpy(*gpu_xSize, cpu_xSize, 8UL, cudaMemcpyHostToDevice);
      }

      ec_cwt_kernel87<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_xSize,
        cpu_cfsposdft->size[1U]);
      xSize_dirtyOnCpu = false;
      i = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cudaMemcpy(cpu_xSize, *gpu_xSize, 8UL, cudaMemcpyDeviceToHost);
      cpu_cfspos->size[0] = static_cast<int32_T>(cpu_xSize[0]);
      cpu_cfspos->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal_T(cpu_cfspos, i, &jb_emlrtRTEI);
      if (!cfspos_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal_T(cpu_cfspos, &gpu_cfspos);
      }

      bcoef = static_cast<int32_T>(cpu_xSize[0]) * static_cast<int32_T>
        (cpu_xSize[1]) - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
        &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (cfspos_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_cfspos, cpu_cfspos);
        }

        ec_cwt_kernel88<<<grid, block>>>(bcoef, gpu_cfspos);
        cfspos_dirtyOnGpu = true;
        cfspos_dirtyOnCpu = false;
      }
    } else {
      cufftHandle c_fftPlanHandle;
      cufftType c_fftType;
      int b_fftDirection;
      nbytes = cpu_cfsposdft->size[1];
      b_fftDirection = CUFFT_INVERSE;
      c_fftType = CUFFT_Z2Z;
      c_fftPlanHandle = acquireCUFFTPlan(1, &nbytes, &nbytes,
        cpu_cfsposdft->size[0], 1, c_fftType, cpu_cfsposdft->size[0]);
      cufftExecZ2Z(c_fftPlanHandle, (cufftDoubleComplex *)&gpu_cfsposdft.data[0],
                   (cufftDoubleComplex *)&gpu_cfsposdft.data[0], b_fftDirection);
      i = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[0] = cpu_cfsposdft->size[0];
      cpu_cfspos->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal_T(cpu_cfspos, i, &jb_emlrtRTEI);
      if (!cfspos_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal_T(cpu_cfspos, &gpu_cfspos);
      }

      bcoef = cpu_cfsposdft->size[1];
      k = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
        &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (cfspos_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_cfspos, cpu_cfspos);
        }

        ec_cwt_kernel86<<<grid, block>>>(static_cast<real_T>(bcoef),
          gpu_cfsposdft, k, gpu_cfspos);
        cfspos_dirtyOnGpu = true;
        cfspos_dirtyOnCpu = false;
      }
    }

    if (fb_SignalPad > 0) {
      nChs = static_cast<uint32_T>(fb_SignalPad) + static_cast<uint32_T>
        (cpu_x->size[0]);
      if (static_cast<uint32_T>(fb_SignalPad + 1) > nChs) {
        nbytes = 0;
        bcoef = 0;
      } else {
        nbytes = fb_SignalPad;
        bcoef = static_cast<int32_T>(nChs);
      }

      k = cpu_cfspos->size[0];
      j = bcoef - nbytes;
      for (i = 0; i < j; i++) {
        for (nsubs = 0; nsubs < k; nsubs++) {
          if (cfspos_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_creal_T(cpu_cfspos, &gpu_cfspos);
          }

          cpu_cfspos->data[nsubs + k * i] = cpu_cfspos->data[nsubs +
            cpu_cfspos->size[0] * (nbytes + i)];
          cfspos_dirtyOnCpu = true;
          cfspos_dirtyOnGpu = false;
        }
      }

      i = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[1] = bcoef - nbytes;
      emxEnsureCapacity_creal_T(cpu_cfspos, i, &kb_emlrtRTEI);
      if (!cfspos_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal_T(cpu_cfspos, &gpu_cfspos);
      }
    }

    bcoef = cpu_cfspos->size[0] * cpu_cfspos->size[1];
    for (k = 0; k < 2; k++) {
      cpu_xSize[k] = static_cast<uint32_T>(cpu_cfspos->size[k]);
      xSize_dirtyOnCpu = true;
    }

    i = m_cpu_y->size[0] * m_cpu_y->size[1];
    m_cpu_y->size[0] = static_cast<int32_T>(cpu_xSize[0]);
    m_cpu_y->size[1] = static_cast<int32_T>(cpu_xSize[1]);
    emxEnsureCapacity_real_T(m_cpu_y, i, &s_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(m_cpu_y, &c_gpu_y);
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (cfspos_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_cfspos, cpu_cfspos);
      }

      cfspos_dirtyOnCpu = false;
      ec_cwt_kernel89<<<grid, block>>>(gpu_cfspos, bcoef, c_gpu_y);
    }

    i = cpu_xCh->size[0] * cpu_xCh->size[1];
    cpu_xCh->size[0] = m_cpu_y->size[1];
    cpu_xCh->size[1] = m_cpu_y->size[0];
    emxEnsureCapacity_real_T(cpu_xCh, i, &lb_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_xCh, &gpu_xCh);
    k = m_cpu_y->size[0] - 1;
    bcoef = m_cpu_y->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((bcoef + 1L) * (k
      + 1L)), &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_cwt_kernel90<<<grid, block>>>(c_gpu_y, bcoef, k, gpu_xCh, cpu_xCh->
        size[0U], m_cpu_y->size[0U]);
    }

    //  CWT
    // 'ec_cwt:43' if ds2>1
    if (ds2 > 1.0) {
      // 'ec_cwt:44' xCh = xCh(1:ds2:end,:);
      if (cpu_xCh->size[0] < 1) {
        nbytes = 1;
        bcoef = -1;
      } else {
        nbytes = static_cast<int32_T>(ds2);
        bcoef = cpu_xCh->size[0] - 1;
      }

      k = cpu_xCh->size[1];
      i = b_cpu_xCh->size[0] * b_cpu_xCh->size[1];
      b_cpu_xCh->size[0] = div_s32(bcoef, nbytes) + 1;
      b_cpu_xCh->size[1] = cpu_xCh->size[1];
      emxEnsureCapacity_real_T(b_cpu_xCh, i, &mb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_cpu_xCh, &b_gpu_xCh);
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((bcoef / nbytes
        + 1L) * k), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ec_cwt_kernel91<<<grid, block>>>(gpu_xCh, nbytes, bcoef, k, b_gpu_xCh,
          b_cpu_xCh->size[0U], cpu_xCh->size[0U]);
      }

      i = cpu_xCh->size[0] * cpu_xCh->size[1];
      cpu_xCh->size[0] = b_cpu_xCh->size[0];
      cpu_xCh->size[1] = b_cpu_xCh->size[1];
      emxEnsureCapacity_real_T(cpu_xCh, i, &nb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_xCh, &gpu_xCh);
      bcoef = b_cpu_xCh->size[0] * b_cpu_xCh->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
        &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ec_cwt_kernel92<<<grid, block>>>(b_gpu_xCh, bcoef, gpu_xCh);
      }

      //  Downsample
    }

    // 'ec_cwt:46' xx(:,ch,:) = xCh;
    xx[0] = cpu_xx->size[0];
    xx[2] = cpu_xx->size[2];
    bcoef = xx[2] - 1;
    k = xx[0] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k + 1L) * (bcoef
      + 1L)), &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (xx_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, cpu_xx);
      }

      ec_cwt_kernel93<<<grid, block>>>(gpu_xCh, xx[0], static_cast<int32_T>(ch +
        1L), xx[0] - 1, xx[2] - 1, gpu_xx, cpu_xx->size[0U], cpu_xx->size[1U]);
      xx_dirtyOnGpu = true;
      xx_dirtyOnCpu = false;
    }

    //  Copy to output matrix
  }

  emxFree_real_T(&b_cpu_xCh);
  emxFree_real_T(&cpu_xCh);
  emxFree_real_T(&m_cpu_y);
  emxFree_creal_T(&cpu_cfsposdft);
  emxFree_real_T(&k_cpu_x);
  emxFree_creal_T(&cpu_xposdft);
  emxFree_real_T(&cpu_xv);
  emxFree_creal_T(&cpu_cfspos);
  emxFree_real_T(&cpu_psidft);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (xx_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_xx, &gpu_xx);
  }

  if (freqs_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_freqs, &gpu_freqs);
  }

  gpuEmxFree_real_T(&b_gpu_x);
  mwCudaFree(*gpu_fLims);
  gpuEmxFree_real_T(&gpu_xx);
  gpuEmxFree_real_T(&gpu_freqs);
  mwCudaFree(*gpu_b);
  mwCudaFree(*gpu_freqrange);
  mwCudaFree(*gpu_NyquistRange);
  mwCudaFree(*gpu_wav);
  gpuEmxFree_real_T(&gpu_omega);
  gpuEmxFree_real_T(&gpu_r);
  mwCudaFree(*gpu_interval);
  mwCudaFree(*gpu_subs);
  gpuEmxFree_real_T(&gpu_fb_Scales);
  gpuEmxFree_real_T(&j_gpu_x);
  gpuEmxFree_real_T(&k_gpu_x);
  gpuEmxFree_real_T(&d_gpu_xt);
  gpuEmxFree_real_T(&k_gpu_y);
  gpuEmxFree_real_T(&d_gpu_fx);
  gpuEmxFree_real_T(&l_gpu_y);
  gpuEmxFree_real_T(&b_gpu_a);
  gpuEmxFree_real_T(&gpu_dv4);
  gpuEmxFree_real_T(&m_gpu_y);
  gpuEmxFree_real_T(&gpu_dv8);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_real_T(&h_gpu_x);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&i_gpu_x);
  gpuEmxFree_real_T(&c_gpu_xt);
  gpuEmxFree_real_T(&gpu_dv11);
  gpuEmxFree_real_T(&c_gpu_fx);
  gpuEmxFree_real_T(&j_gpu_y);
  gpuEmxFree_real_T(&d_gpu_y);
  gpuEmxFree_real_T(&gpu_dv13);
  gpuEmxFree_real_T(&e_gpu_y);
  gpuEmxFree_real_T(&f_gpu_x);
  gpuEmxFree_real_T(&gpu_psidft);
  gpuEmxFree_real_T(&g_gpu_x);
  gpuEmxFree_real_T(&gpu_f);
  gpuEmxFree_real_T(&b_gpu_xt);
  gpuEmxFree_real_T(&g_gpu_y);
  gpuEmxFree_real_T(&gpu_somega);
  gpuEmxFree_real_T(&b_gpu_fx);
  gpuEmxFree_real_T(&h_gpu_y);
  gpuEmxFree_real_T(&gpu_a);
  gpuEmxFree_real_T(&gpu_dv12);
  gpuEmxFree_real_T(&i_gpu_y);
  gpuEmxFree_real_T(&gpu_dv14);
  mwCudaFree(*gpu_xSize);
  gpuEmxFree_real_T(&gpu_absomega);
  gpuEmxFree_real_T(&d_gpu_x);
  gpuEmxFree_real_T(&e_gpu_x);
  gpuEmxFree_real_T(&gpu_xt);
  gpuEmxFree_real_T(&gpu_powscales);
  gpuEmxFree_real_T(&gpu_dv16);
  gpuEmxFree_real_T(&gpu_fx);
  gpuEmxFree_real_T(&f_gpu_y);
  gpuEmxFree_real_T(&gpu_dv17);
  gpuEmxFree_real_T(&gpu_dv1);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_creal_T(&gpu_cfspos);
  gpuEmxFree_real_T(&gpu_xv);
  gpuEmxFree_creal_T(&gpu_xposdft);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_creal_T(&gpu_cfsposdft);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&gpu_xCh);
  gpuEmxFree_real_T(&b_gpu_xCh);
}

void ec_cwt_api(const mxArray * const prhs[5], int32_T nlhs, const mxArray *
                plhs[2])
{
  emxArray_real_T *freqs;
  emxArray_real_T *x;
  emxArray_real_T *xx;
  const mxArray *prhs_copy_idx_2;
  real_T (*fLims)[2];
  real_T ds2;
  real_T fOctave;
  real_T fs;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_2 = emlrtProtectR2012b(prhs[2], 2, false, -1);

  // Marshall function inputs
  emxInit_real_T(&x, 2, &jc_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  fs = emlrt_marshallIn(emlrtAliasP(prhs[1]), "fs");
  fLims = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_2), "fLims");
  fOctave = emlrt_marshallIn(emlrtAliasP(prhs[3]), "fOctave");
  ds2 = emlrt_marshallIn(emlrtAliasP(prhs[4]), "ds2");

  // Invoke the target function
  emxInit_real_T(&xx, 3, &jc_emlrtRTEI, true);
  emxInit_real_T(&freqs, 1, &jc_emlrtRTEI, true);
  ec_cwt(x, fs, *fLims, fOctave, ds2, xx, freqs);
  emxFree_real_T(&x);

  // Marshall function outputs
  xx->canFreeData = false;
  plhs[0] = emlrt_marshallOut(xx);
  emxFree_real_T(&xx);
  if (nlhs > 1) {
    freqs->canFreeData = false;
    plhs[1] = b_emlrt_marshallOut(freqs);
  }

  emxFree_real_T(&freqs);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ec_cwt_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  mwCudaFree(*cpu_cv_gpu_clone);
}

void ec_cwt_initialize()
{
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "distrib_computing_toolbox", 2);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "wavelet_toolbox", 2);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    ec_cwt_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ec_cwt_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode), (char_T *)
                       cudaGetErrorName(errCode), (char_T *)cudaGetErrorString
                       (errCode), (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }

  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  mwMemoryManagerTerminate();
}

// End of code generation (ec_cwt.cu)
