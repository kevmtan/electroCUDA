//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecu_cwt64.cu
//
// Code generation for function 'ecu_cwt64'
//

// Include files
#include "ecu_cwt64.h"
#include "_coder_ecu_cwt64_mex.h"
#include "ecu_cwt64_types.h"
#include "rt_nonfinite.h"
#include "MWCUFFTPlanManager.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWMemoryManager.hpp"
#include "cufft.h"
#include <algorithm>
#include <cmath>
#include <cstring>

// Type Definitions
struct emxArray_uint32_T
{
  uint32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct emxArray_int32_T
{
  int32_T *data;
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

struct emxArray_char_T
{
  char_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{ nullptr };

emlrtContext emlrtContextGlobal{ true, // bFirstTime
  false,                               // bInitialized
  131627U,                             // fVersionInfo
  nullptr,                             // fErrorFunction
  "ecu_cwt64",                         // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 1075284325U, 2201364878U, 3488609979U, 1269018621U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtMCInfo emlrtMCI{ 53,       // lineNo
  19,                                  // colNo
  "flt2str",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/flt2str.m"// pName
};

static emlrtMCInfo b_emlrtMCI{ 53,     // lineNo
  14,                                  // colNo
  "nonConstPrint",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtMCInfo c_emlrtMCI{ 55,     // lineNo
  15,                                  // colNo
  "nonConstPrint",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtRTEInfo emlrtRTEI{ 986,    // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo b_emlrtRTEI{ 987,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 988,  // lineNo
  21,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 988,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 273,  // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 445,  // lineNo
  20,                                  // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 446,  // lineNo
  21,                                  // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 28,   // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 486,  // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 63,   // lineNo
  17,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 23,   // lineNo
  1,                                   // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 76,   // lineNo
  9,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 18,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 60,   // lineNo
  20,                                  // colNo
  "bsxfun",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/bsxfun.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 498,  // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 43,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 946,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 30,   // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 25,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 25,   // lineNo
  1,                                   // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 31,   // lineNo
  23,                                  // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 29,   // lineNo
  21,                                  // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 31,   // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 30,  // lineNo
  1,                                   // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 33,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 31,  // lineNo
  1,                                   // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 34,  // lineNo
  8,                                   // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 34,  // lineNo
  14,                                  // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 34,  // lineNo
  38,                                  // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 135, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 143, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "cuFFTNDCallback",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+gpucoder/+internal/cuFFTNDCallback.p"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 138, // lineNo
  19,                                  // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 138, // lineNo
  6,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 161, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 164, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 180, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 47,  // lineNo
  20,                                  // colNo
  "permute",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/permute.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 34,  // lineNo
  20,                                  // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 1256,// lineNo
  30,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 1256,// lineNo
  25,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 1,   // lineNo
  23,                                  // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 445, // lineNo
  1,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 924, // lineNo
  26,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 32,  // lineNo
  18,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 446, // lineNo
  1,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 21,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 32,  // lineNo
  13,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 63,  // lineNo
  20,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 63,  // lineNo
  34,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 63,  // lineNo
  60,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 64,  // lineNo
  31,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 151, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 34,  // lineNo
  28,                                  // colNo
  "ecu_cwt64",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_cwt64.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "_coder_ecu_cwt64_api",              // fName
  ""                                   // pName
};

static char_T (*cv_gpu_clone)[128];
static boolean_T gpuConstsCopied_ecu_cwt64;

// Function Declarations
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static real_T (*b_emlrt_marshallIn(const mxArray *fLims, const char_T
  *identifier))[2];
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2];
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_char_T *ret);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[23]);
static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u);
static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
  emlrtMCInfo *location);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4);
static void c_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static real_T (*d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2];
static int32_T div_s32(int32_T numerator, int32_T denominator);
static __global__ void ecu_cwt64_kernel1(real_T fb_FrequencyLimits[2], real_T
  fLims_dim0, real_T fLims_dim1);
static __global__ void ecu_cwt64_kernel10(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecu_cwt64_kernel100(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecu_cwt64_kernel101(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel102(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel103(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ecu_cwt64_kernel104(const emxArray_real_T a, int32_T
  nrefine, emxArray_real_T dv21);
static __global__ void ecu_cwt64_kernel105(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel106(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv24);
static __global__ void ecu_cwt64_kernel107(int32_T nrefine, emxArray_real_T dv24);
static __global__ void ecu_cwt64_kernel108(const emxArray_real_T xt, const
  emxArray_real_T dv24, const emxArray_real_T dv21, int32_T b_dv21,
  emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel109(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel11(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel110(real_T interval[650]);
static __global__ void ecu_cwt64_kernel111(real_T interval[650]);
static __global__ void ecu_cwt64_kernel112(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecu_cwt64_kernel113(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecu_cwt64_kernel114(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecu_cwt64_kernel115(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T dv27);
static __global__ void ecu_cwt64_kernel116(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel117(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv31);
static __global__ void ecu_cwt64_kernel118(int32_T nrefine, emxArray_real_T dv31);
static __global__ void ecu_cwt64_kernel119(const emxArray_real_T xt, const
  emxArray_real_T dv31, const emxArray_real_T dv27, int32_T b_dv27,
  emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel12(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel120(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel121(real_T r, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel122(const emxArray_real_T y, const real_T
  toler, int32_T nrefine, emxArray_real_T b_y);
static __global__ void ecu_cwt64_kernel123(const emxArray_real_T y, const real_T
  r, int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ecu_cwt64_kernel124(int32_T fb_Scales, emxArray_real_T
  psidft);
static __global__ void ecu_cwt64_kernel125(const emxArray_real_T fb_Scales,
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ecu_cwt64_kernel126(const emxArray_real_T omega, const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, int32_T eint, const
  int32_T somega_dim0, emxArray_real_T somega);
static __global__ void ecu_cwt64_kernel127(const emxArray_real_T somega, int32_T
  nrefine, emxArray_real_T absomega);
static __global__ void ecu_cwt64_kernel128(const emxArray_real_T absomega,
  int32_T b_absomega, emxArray_real_T powscales);
static __global__ void ecu_cwt64_kernel129(int32_T nrefine, emxArray_real_T
  absomega);
static __global__ void ecu_cwt64_kernel13(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ecu_cwt64_kernel130(const emxArray_real_T powscales,
  const emxArray_real_T absomega, int32_T b_absomega, emxArray_real_T x);
static __global__ void ecu_cwt64_kernel131(int32_T nrefine, emxArray_real_T x);
static __global__ void ecu_cwt64_kernel132(const emxArray_real_T somega, const
  emxArray_real_T x, int32_T b_x, emxArray_real_T psidft);
static __global__ void ecu_cwt64_kernel133(const emxArray_real_T fb_Scales,
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ecu_cwt64_kernel134(const real_T fs, int32_T i,
  emxArray_real_T f);
static __global__ void ecu_cwt64_kernel135(const emxArray_real_T f, int32_T lidx,
  emxArray_real_T freqs);
static __global__ void ecu_cwt64_kernel136(uint32_T N, emxArray_uint32_T ii);
static __global__ void ecu_cwt64_kernel137(uint32_T N, emxArray_uint32_T is);
static __global__ void ecu_cwt64_kernel138(const emxArray_uint32_T ii, int32_T
  b_ii, emxArray_int32_T iv8);
static __global__ void ecu_cwt64_kernel139(const emxArray_uint32_T is, int32_T
  b_is, emxArray_int32_T iv10);
static __global__ void ecu_cwt64_kernel14(const emxArray_real_T a, int32_T
  nrefine, emxArray_real_T dv8);
static __global__ void ecu_cwt64_kernel140(const int32_T ch, const
  emxArray_real_T x, const emxArray_uint32_T ii, int32_T b_ii, const int32_T
  x_dim0, emxArray_real_T b_x);
static __global__ void ecu_cwt64_kernel141(const emxArray_real_T x, int32_T b_x,
  emxArray_real_T xv);
static __global__ void ecu_cwt64_kernel142(const emxArray_real_T x, int32_T
  fb_SignalPad, emxArray_real_T b_x);
static __global__ void ecu_cwt64_kernel143(const emxArray_real_T x, int32_T eint,
  emxArray_real_T xv);
static __global__ void ecu_cwt64_kernel144(const emxArray_real_T xv, int32_T
  b_xv, emxArray_creal_T xposdft);
static __global__ void ecu_cwt64_kernel145(const emxArray_creal_T xposdft, const
  emxArray_real_T psidft, const int32_T nsubs, const int32_T nrefine, const
  int32_T cfsposdft, int32_T lidx, const int32_T psidft_dim0, const int32_T
  cfsposdft_dim0, emxArray_creal_T b_cfsposdft);
static __global__ void ecu_cwt64_kernel146(const int32_T cfsposdft_dim1, creal_T
  *cfsposdft);
static __global__ void ecu_cwt64_kernel147(const creal_T *cfsposdft, const
  emxArray_creal_T b_cfsposdft, int32_T c_cfsposdft, emxArray_creal_T cfspos);
static __global__ void ecu_cwt64_kernel148(const int32_T cfsposdft_dim1,
  uint32_T xSize[2]);
static __global__ void ecu_cwt64_kernel149(int32_T xSize, emxArray_creal_T
  cfspos);
static __global__ void ecu_cwt64_kernel15(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel150(const emxArray_creal_T cfspos,
  int32_T b_cfspos, emxArray_creal_T cfs);
static __global__ void ecu_cwt64_kernel151(const emxArray_creal_T cfspos, const
  int32_T b_cfspos, const uint32_T N, uint32_T u, const int32_T cfs_dim0, const
  int32_T cfspos_dim0, emxArray_creal_T cfs);
static __global__ void ecu_cwt64_kernel152(const emxArray_creal_T cfs, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel153(const emxArray_real_T y, int32_T
  nrefine, emxArray_real_T b_y);
static __global__ void ecu_cwt64_kernel154(const emxArray_real_T y, const
  int32_T b_y, int32_T lidx, const int32_T dv23_dim0, const int32_T y_dim0,
  emxArray_real_T dv23);
static __global__ void ecu_cwt64_kernel155(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv23);
static __global__ void ecu_cwt64_kernel156(const emxArray_real_T dv23, const
  emxArray_int32_T iv10, const int32_T ch, const emxArray_int32_T iv8, const
  int32_T b_dv23, int32_T c_dv23, const int32_T xx_dim0, const int32_T xx_dim1,
  const int32_T dv23_dim0, emxArray_real_T xx);
static __global__ void ecu_cwt64_kernel16(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv12);
static __global__ void ecu_cwt64_kernel17(int32_T nrefine, emxArray_real_T dv12);
static __global__ void ecu_cwt64_kernel18(const emxArray_real_T xt, const
  emxArray_real_T dv12, const emxArray_real_T dv8, int32_T b_dv8,
  emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel19(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel2(boolean_T b[2], real_T fLims_dim0,
  real_T fLims_dim1);
static __global__ void ecu_cwt64_kernel20(real_T interval[650]);
static __global__ void ecu_cwt64_kernel21(real_T interval[650]);
static __global__ void ecu_cwt64_kernel22(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecu_cwt64_kernel23(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecu_cwt64_kernel24(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecu_cwt64_kernel25(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T dv15);
static __global__ void ecu_cwt64_kernel26(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel27(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv17);
static __global__ void ecu_cwt64_kernel28(int32_T nrefine, emxArray_real_T dv17);
static __global__ void ecu_cwt64_kernel29(const emxArray_real_T xt, const
  emxArray_real_T dv17, const emxArray_real_T dv15, int32_T b_dv15,
  emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel3(real_T freqrange[2], real_T fLims_dim0,
  real_T fLims_dim1);
static __global__ void ecu_cwt64_kernel30(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel31(const real_T r, real_T freqrange[2],
  real_T fb_FrequencyLimits[2]);
static __global__ void ecu_cwt64_kernel32(const real_T fs, real_T
  fb_FrequencyLimits[2]);
static __global__ void ecu_cwt64_kernel33(const real_T fb_FrequencyLimits[2],
  real_T freqrange[2]);
static __global__ void ecu_cwt64_kernel34(real_T interval[650]);
static __global__ void ecu_cwt64_kernel35(real_T interval[650]);
static __global__ void ecu_cwt64_kernel36(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecu_cwt64_kernel37(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecu_cwt64_kernel38(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecu_cwt64_kernel39(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel4(const real_T fs, real_T NyquistRange[2]);
static __global__ void ecu_cwt64_kernel40(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel41(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ecu_cwt64_kernel42(const emxArray_real_T a, int32_T
  nrefine, emxArray_real_T dv5);
static __global__ void ecu_cwt64_kernel43(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel44(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv9);
static __global__ void ecu_cwt64_kernel45(int32_T nrefine, emxArray_real_T dv9);
static __global__ void ecu_cwt64_kernel46(const emxArray_real_T xt, const
  emxArray_real_T dv9, const emxArray_real_T dv5, int32_T b_dv5, emxArray_real_T
  fx);
static __global__ void ecu_cwt64_kernel47(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel48(real_T interval[650]);
static __global__ void ecu_cwt64_kernel49(real_T interval[650]);
static __global__ void ecu_cwt64_kernel5(const char_T cv[128], char_T wav[5],
  char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4);
static __global__ void ecu_cwt64_kernel50(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecu_cwt64_kernel51(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecu_cwt64_kernel52(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecu_cwt64_kernel53(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T dv11);
static __global__ void ecu_cwt64_kernel54(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel55(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv14);
static __global__ void ecu_cwt64_kernel56(int32_T nrefine, emxArray_real_T dv14);
static __global__ void ecu_cwt64_kernel57(const emxArray_real_T xt, const
  emxArray_real_T dv14, const emxArray_real_T dv11, int32_T b_dv11,
  emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel58(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel59(int32_T lidx, emxArray_real_T omega);
static __global__ void ecu_cwt64_kernel6(real_T interval[650]);
static __global__ void ecu_cwt64_kernel60(const uint32_T N, int32_T i,
  emxArray_real_T omega);
static __global__ void ecu_cwt64_kernel61(emxArray_real_T r);
static __global__ void ecu_cwt64_kernel62(const emxArray_real_T omega, int32_T
  eint, emxArray_real_T r);
static __global__ void ecu_cwt64_kernel63(const int32_T lidx, const int32_T i,
  const emxArray_real_T omega, int32_T eint, const int32_T omega_dim1,
  emxArray_real_T r);
static __global__ void ecu_cwt64_kernel64(const emxArray_real_T r, int32_T b_r,
  emxArray_real_T omega);
static __global__ void ecu_cwt64_kernel65(const real_T fb_FrequencyLimits[2],
  boolean_T b[2]);
static __global__ void ecu_cwt64_kernel66(const char_T cv[128], char_T wav[5],
  char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4);
static __global__ void ecu_cwt64_kernel67(real_T interval[650]);
static __global__ void ecu_cwt64_kernel68(real_T interval[650]);
static __global__ void ecu_cwt64_kernel69(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecu_cwt64_kernel7(real_T interval[650]);
static __global__ void ecu_cwt64_kernel70(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecu_cwt64_kernel71(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecu_cwt64_kernel72(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel73(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel74(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ecu_cwt64_kernel75(const emxArray_real_T a, int32_T
  nrefine, emxArray_real_T dv22);
static __global__ void ecu_cwt64_kernel76(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel77(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv28);
static __global__ void ecu_cwt64_kernel78(int32_T nrefine, emxArray_real_T dv28);
static __global__ void ecu_cwt64_kernel79(const emxArray_real_T xt, const
  emxArray_real_T dv28, const emxArray_real_T dv22, int32_T b_dv22,
  emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel8(const int32_T nrefine, real_T interval
  [650]);
static __global__ void ecu_cwt64_kernel80(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel81(real_T interval[650]);
static __global__ void ecu_cwt64_kernel82(real_T interval[650]);
static __global__ void ecu_cwt64_kernel83(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecu_cwt64_kernel84(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecu_cwt64_kernel85(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecu_cwt64_kernel86(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T dv30);
static __global__ void ecu_cwt64_kernel87(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel88(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv32);
static __global__ void ecu_cwt64_kernel89(int32_T nrefine, emxArray_real_T dv32);
static __global__ void ecu_cwt64_kernel9(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecu_cwt64_kernel90(const emxArray_real_T xt, const
  emxArray_real_T dv32, const emxArray_real_T dv30, int32_T b_dv30,
  emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel91(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecu_cwt64_kernel92(real_T r, emxArray_real_T y);
static __global__ void ecu_cwt64_kernel93(const emxArray_real_T y, const real_T
  toler, int32_T nrefine, emxArray_real_T b_y);
static __global__ void ecu_cwt64_kernel94(const emxArray_real_T y, const real_T
  r, int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ecu_cwt64_kernel95(const real_T fs, const real_T
  fb_FrequencyLimits[2], real_T NyquistRange[2]);
static __global__ void ecu_cwt64_kernel96(real_T interval[650]);
static __global__ void ecu_cwt64_kernel97(real_T interval[650]);
static __global__ void ecu_cwt64_kernel98(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecu_cwt64_kernel99(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static void ecu_cwt64_once();
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[23]);
static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_, const char_T *
  identifier, char_T y[23]);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static real_T emlrt_marshallIn(const mxArray *a__output_of_length_, const char_T
  *identifier);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_char_T *y);
static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
  emxArray_char_T *y);
static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_creal_T(emxArray_creal_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_uint32_T(emxArray_uint32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxFree_char_T(emxArray_char_T **pEmxArray);
static void emxFree_creal_T(emxArray_creal_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxFree_uint32_T(emxArray_uint32_T **pEmxArray);
static void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_creal_T(emxArray_creal_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_uint32_T(emxArray_uint32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static const mxArray *feval(const mxArray *m1, const mxArray *m2, const mxArray *
  m3, emlrtMCInfo *location);
static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
  emxArray_creal_T *gpu);
static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu);
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu);
static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu);
static void gpuEmxFree_creal_T(emxArray_creal_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
static void gpuEmxFree_uint32_T(emxArray_uint32_T *gpu);
static void gpuEmxMemcpyCpuToGpu_creal_T(emxArray_creal_T *gpu, const
  emxArray_creal_T *cpu);
static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu, const
  emxArray_real_T *cpu);
static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu, emxArray_creal_T
  *gpu);
static void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T
  *gpu);
static void gpuEmxReset_creal_T(emxArray_creal_T *gpu);
static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu);
static const mxArray *length(const mxArray *m1, emlrtMCInfo *location);
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

  emxEnsureCapacity_real_T(in1, i, &w_emlrtRTEI);
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

static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2]
{
  real_T (*y)[2];
  y = d_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
*msgId, char_T ret[23])
{
  static const int32_T dims[2]{ 1, 23 };
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U, (
    const void *)&dims[0]);
  emlrtImportCharArrayR2015b(emlrtRootTLSGlobal, src, &ret[0], 23);
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
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
*msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2]{ -1, -1 };
  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2]{ true, true };

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

static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_char_T *ret)
{
  static const int32_T dims[2]{ 1, -1 };

  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2]{ false, true };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U, (
    const void *)&dims[0], &bv[0], &iv[0]);
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_char_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, &ret->data[0], 1, false);
  emlrtDestroyArray(&src);
}

static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u)
{
  static const int32_T iv[2]{ 0, 0 };

  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 2);
  emlrtAssign(&y, m);
  return y;
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

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4)
{
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  in1->size[1] = in4->size[1];
  emxEnsureCapacity_real_T(in1, i, &q_emlrtRTEI);
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

  emxEnsureCapacity_real_T(in1, i, &k_emlrtRTEI);
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

static real_T (*d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2]
{
  static const int32_T dims[2]{ 1, 2 };

  real_T (*ret)[2];
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U, (
    const void *)&dims[0]);
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel1(real_T
  fb_FrequencyLimits[2], real_T fLims_dim0, real_T fLims_dim1)
{
  __shared__ real_T fLims_shared[2];
  uint64_T threadId;
  int32_T varargin_3;
  if (mwGetThreadIndexWithinBlock() == 0) {
    fLims_shared[0] = fLims_dim0;
    fLims_shared[1] = fLims_dim1;
  }

  __syncthreads();
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_3 = static_cast<int32_T>(threadId);
  if (varargin_3 < 2) {
    fb_FrequencyLimits[varargin_3] = fLims_shared[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel10(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel100(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel101(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 19.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel102(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel103(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel104(const
  emxArray_real_T a, int32_T nrefine, emxArray_real_T dv21)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    int32_T k;
    k = static_cast<int32_T>(idx);
    ar = a.data[k];
    dv21.data[k] = ar * ar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel105(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel106(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv24)
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
    dv24.data[varargin_3] = -2.0 * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel107(int32_T
  nrefine, emxArray_real_T dv24)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv24.data[k] = exp(dv24.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel108(const
  emxArray_real_T xt, const emxArray_real_T dv24, const emxArray_real_T dv21,
  int32_T b_dv21, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv21);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv21.data[varargin_3] * dv24.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel109(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel11(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 19.0);
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel110(real_T
  interval[650])
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

static __global__ __launch_bounds__(512, 1) void ecu_cwt64_kernel111(real_T
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel112(const
  int32_T nrefine, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel113(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel114(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel115(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T dv27)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv27.data[k] = pow(x.data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel116(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel117(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv31)
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
    dv31.data[varargin_3] = -2.0 * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel118(int32_T
  nrefine, emxArray_real_T dv31)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv31.data[k] = exp(dv31.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel119(const
  emxArray_real_T xt, const emxArray_real_T dv31, const emxArray_real_T dv27,
  int32_T b_dv27, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv27);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv27.data[varargin_3] * dv31.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel12(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel120(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel121(real_T r,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(r));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    y.data[varargin_3] = varargin_3;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel122(const
  emxArray_real_T y, const real_T toler, int32_T nrefine, emxArray_real_T b_y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b_y.data[k] = pow(toler, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel123(const
  emxArray_real_T y, const real_T r, int32_T b_y, emxArray_real_T fb_Scales)
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
    fb_Scales.data[varargin_3] = r * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel124(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel125(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel126(const
  emxArray_real_T omega, const emxArray_real_T fb_Scales, const int32_T
  b_fb_Scales, int32_T eint, const int32_T somega_dim0, emxArray_real_T somega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_fb_Scales) + 1UL) * (static_cast<uint64_T>
    (eint) + 1UL) - 1UL;
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel127(const
  emxArray_real_T somega, int32_T nrefine, emxArray_real_T absomega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absomega.data[k] = fabs(somega.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel128(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel129(int32_T
  nrefine, emxArray_real_T absomega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absomega.data[k] = log(absomega.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel13(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel130(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel131(int32_T
  nrefine, emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    x.data[k] = exp(x.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel132(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel133(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel134(const
  real_T fs, int32_T i, emxArray_real_T f)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    f.data[varargin_3] *= fs;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel135(const
  emxArray_real_T f, int32_T lidx, emxArray_real_T freqs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    freqs.data[varargin_3] = f.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel136(uint32_T N,
  emxArray_uint32_T ii)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(N) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    ii.data[varargin_3] = static_cast<uint32_T>(varargin_3) + 1U;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel137(uint32_T N,
  emxArray_uint32_T is)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(N) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    is.data[varargin_3] = static_cast<uint32_T>(varargin_3) + 1U;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel138(const
  emxArray_uint32_T ii, int32_T b_ii, emxArray_int32_T iv8)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_ii);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    iv8.data[varargin_3] = static_cast<int32_T>(ii.data[varargin_3]) - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel139(const
  emxArray_uint32_T is, int32_T b_is, emxArray_int32_T iv10)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_is);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    iv10.data[varargin_3] = static_cast<int32_T>(is.data[varargin_3]) - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel14(const
  emxArray_real_T a, int32_T nrefine, emxArray_real_T dv8)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    int32_T k;
    k = static_cast<int32_T>(idx);
    ar = a.data[k];
    dv8.data[k] = ar * ar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel140(const
  int32_T ch, const emxArray_real_T x, const emxArray_uint32_T ii, int32_T b_ii,
  const int32_T x_dim0, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_ii);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    b_x.data[varargin_3] = x.data[(static_cast<int32_T>(ii.data[varargin_3]) +
      x_dim0 * ch) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel141(const
  emxArray_real_T x, int32_T b_x, emxArray_real_T xv)
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
    xv.data[varargin_3] = x.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel142(const
  emxArray_real_T x, int32_T fb_SignalPad, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fb_SignalPad - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    b_x.data[varargin_3] = x.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel143(const
  emxArray_real_T x, int32_T eint, emxArray_real_T xv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(eint);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    xv.data[varargin_3] = x.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel144(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel145(const
  emxArray_creal_T xposdft, const emxArray_real_T psidft, const int32_T nsubs,
  const int32_T nrefine, const int32_T cfsposdft, int32_T lidx, const int32_T
  psidft_dim0, const int32_T cfsposdft_dim0, emxArray_creal_T b_cfsposdft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(cfsposdft) + 1UL) * (static_cast<uint64_T>
    (lidx - 1) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_k;
    int32_T bcoef;
    int32_T k;
    int32_T varargin_2;
    int32_T varargin_3;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(cfsposdft) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) /
      (static_cast<uint64_T>(cfsposdft) + 1UL));
    varargin_2 = nrefine * k + 1;
    varargin_3 = nsubs * k + 1;
    bcoef = (psidft_dim0 != 1);
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].re = psidft.data[bcoef * b_k +
      psidft_dim0 * (varargin_3 - 1)] * xposdft.data[varargin_2 - 1].re;
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].im = psidft.data[bcoef * b_k +
      psidft_dim0 * (varargin_3 - 1)] * xposdft.data[varargin_2 - 1].im;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel146(const
  int32_T cfsposdft_dim1, creal_T *cfsposdft)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    cfsposdft->re = cfsposdft_dim1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel147(const
  creal_T *cfsposdft, const emxArray_creal_T b_cfsposdft, int32_T c_cfsposdft,
  emxArray_creal_T cfspos)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_cfsposdft);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    real_T tkd1mtk;
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    ar = b_cfsposdft.data[varargin_3].re;
    tkd1mtk = b_cfsposdft.data[varargin_3].im;
    if (tkd1mtk == 0.0) {
      cfspos.data[varargin_3].re = ar / cfsposdft->re;
      cfspos.data[varargin_3].im = 0.0;
    } else if (ar == 0.0) {
      cfspos.data[varargin_3].re = 0.0;
      cfspos.data[varargin_3].im = tkd1mtk / cfsposdft->re;
    } else {
      cfspos.data[varargin_3].re = ar / cfsposdft->re;
      cfspos.data[varargin_3].im = tkd1mtk / cfsposdft->re;
    }
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel148(const
  int32_T cfsposdft_dim1, uint32_T xSize[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    xSize[1] = static_cast<uint32_T>(cfsposdft_dim1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel149(int32_T
  xSize, emxArray_creal_T cfspos)
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel15(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel150(const
  emxArray_creal_T cfspos, int32_T b_cfspos, emxArray_creal_T cfs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfspos);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    cfs.data[varargin_3] = cfspos.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel151(const
  emxArray_creal_T cfspos, const int32_T b_cfspos, const uint32_T N, uint32_T u,
  const int32_T cfs_dim0, const int32_T cfspos_dim0, emxArray_creal_T cfs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_cfspos) + 1UL) * (static_cast<uint64_T>(
    static_cast<int32_T>(u) - static_cast<int32_T>(N)) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T varargin_3;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_cfspos) + 1UL));
    varargin_3 = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) / (
      static_cast<uint64_T>(b_cfspos) + 1UL));
    cfs.data[bcoef + cfs_dim0 * varargin_3] = cfspos.data[bcoef + cfspos_dim0 *
      ((static_cast<int32_T>(N) + varargin_3) - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel152(const
  emxArray_creal_T cfs, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = hypot(cfs.data[k].re, cfs.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel153(const
  emxArray_real_T y, int32_T nrefine, emxArray_real_T b_y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b_y.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel154(const
  emxArray_real_T y, const int32_T b_y, int32_T lidx, const int32_T dv23_dim0,
  const int32_T y_dim0, emxArray_real_T dv23)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>(lidx) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_k;
    int32_T k;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) /
      (static_cast<uint64_T>(b_y) + 1UL));
    dv23.data[k + dv23_dim0 * b_k] = y.data[b_k + y_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel155(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv23)
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
    dv23.data[varargin_3] = y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel156(const
  emxArray_real_T dv23, const emxArray_int32_T iv10, const int32_T ch, const
  emxArray_int32_T iv8, const int32_T b_dv23, int32_T c_dv23, const int32_T
  xx_dim0, const int32_T xx_dim1, const int32_T dv23_dim0, emxArray_real_T xx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_dv23) + 1UL) * (static_cast<uint64_T>
    (c_dv23) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T varargin_3;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_dv23) + 1UL));
    varargin_3 = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) / (
      static_cast<uint64_T>(b_dv23) + 1UL));
    xx.data[(iv8.data[bcoef] + xx_dim0 * ch) + xx_dim0 * xx_dim1 *
      iv10.data[varargin_3]] = dv23.data[bcoef + dv23_dim0 * varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel16(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv12)
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
    dv12.data[varargin_3] = -2.0 * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel17(int32_T
  nrefine, emxArray_real_T dv12)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv12.data[k] = exp(dv12.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel18(const
  emxArray_real_T xt, const emxArray_real_T dv12, const emxArray_real_T dv8,
  int32_T b_dv8, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv8);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv8.data[varargin_3] * dv12.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel19(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel2(boolean_T b[2],
  real_T fLims_dim0, real_T fLims_dim1)
{
  __shared__ real_T fLims_shared[2];
  uint64_T threadId;
  int32_T varargin_3;
  if (mwGetThreadIndexWithinBlock() == 0) {
    fLims_shared[0] = fLims_dim0;
    fLims_shared[1] = fLims_dim1;
  }

  __syncthreads();
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_3 = static_cast<int32_T>(threadId);
  if (varargin_3 < 2) {
    b[varargin_3] = isnan(fLims_shared[varargin_3]);
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel20(real_T
  interval[650])
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

static __global__ __launch_bounds__(512, 1) void ecu_cwt64_kernel21(real_T
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel22(const int32_T
  nrefine, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel23(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel24(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel25(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T dv15)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv15.data[k] = pow(x.data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel26(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel27(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv17)
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
    dv17.data[varargin_3] = -2.0 * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel28(int32_T
  nrefine, emxArray_real_T dv17)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv17.data[k] = exp(dv17.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel29(const
  emxArray_real_T xt, const emxArray_real_T dv17, const emxArray_real_T dv15,
  int32_T b_dv15, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv15);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv15.data[varargin_3] * dv17.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel3(real_T
  freqrange[2], real_T fLims_dim0, real_T fLims_dim1)
{
  __shared__ real_T fLims_shared[2];
  uint64_T threadId;
  int32_T varargin_3;
  if (mwGetThreadIndexWithinBlock() == 0) {
    fLims_shared[0] = fLims_dim0;
    fLims_shared[1] = fLims_dim1;
  }

  __syncthreads();
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_3 = static_cast<int32_T>(threadId);
  if (varargin_3 < 2) {
    freqrange[varargin_3] = fLims_shared[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel30(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel31(const real_T
  r, real_T freqrange[2], real_T fb_FrequencyLimits[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fb_FrequencyLimits[0] = r;
    freqrange[0] = r;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel32(const real_T
  fs, real_T fb_FrequencyLimits[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fb_FrequencyLimits[1] = fs / 2.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel33(const real_T
  fb_FrequencyLimits[2], real_T freqrange[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    freqrange[1] = fb_FrequencyLimits[1];
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel34(real_T
  interval[650])
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

static __global__ __launch_bounds__(512, 1) void ecu_cwt64_kernel35(real_T
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel36(const int32_T
  nrefine, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel37(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel38(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel39(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 19.0);
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel4(const real_T
  fs, real_T NyquistRange[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    NyquistRange[1] = fs / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel40(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel41(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel42(const
  emxArray_real_T a, int32_T nrefine, emxArray_real_T dv5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    int32_T k;
    k = static_cast<int32_T>(idx);
    ar = a.data[k];
    dv5.data[k] = ar * ar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel43(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel44(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv9)
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
    dv9.data[varargin_3] = -2.0 * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel45(int32_T
  nrefine, emxArray_real_T dv9)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv9.data[k] = exp(dv9.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel46(const
  emxArray_real_T xt, const emxArray_real_T dv9, const emxArray_real_T dv5,
  int32_T b_dv5, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv5);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv5.data[varargin_3] * dv9.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel47(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel48(real_T
  interval[650])
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

static __global__ __launch_bounds__(512, 1) void ecu_cwt64_kernel49(real_T
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel5(const char_T
  cv[128], char_T wav[5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel50(const int32_T
  nrefine, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel51(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel52(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel53(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T dv11)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv11.data[k] = pow(x.data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel54(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel55(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv14)
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
    dv14.data[varargin_3] = -2.0 * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel56(int32_T
  nrefine, emxArray_real_T dv14)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv14.data[k] = exp(dv14.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel57(const
  emxArray_real_T xt, const emxArray_real_T dv14, const emxArray_real_T dv11,
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
    fx.data[varargin_3] = dv11.data[varargin_3] * dv14.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel58(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel59(int32_T
  lidx, emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    omega.data[varargin_3] = static_cast<real_T>(varargin_3) + 1.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel6(real_T
  interval[650])
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel60(const
  uint32_T N, int32_T i, emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    omega.data[varargin_3] = omega.data[varargin_3] * 6.2831853071795862 /
      static_cast<real_T>(N);
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel61
  (emxArray_real_T r)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    r.data[0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel62(const
  emxArray_real_T omega, int32_T eint, emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(eint);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    r.data[varargin_3 + 1] = omega.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel63(const
  int32_T lidx, const int32_T i, const emxArray_real_T omega, int32_T eint,
  const int32_T omega_dim1, emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(eint);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    r.data[(varargin_3 + omega_dim1) + 1] = -omega.data[i + lidx * varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel64(const
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel65(const real_T
  fb_FrequencyLimits[2], boolean_T b[2])
{
  uint64_T threadId;
  int32_T varargin_3;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_3 = static_cast<int32_T>(threadId);
  if (varargin_3 < 2) {
    b[varargin_3] = isnan(fb_FrequencyLimits[varargin_3]);
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel66(const char_T
  cv[128], char_T wav[5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel67(real_T
  interval[650])
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

static __global__ __launch_bounds__(512, 1) void ecu_cwt64_kernel68(real_T
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel69(const int32_T
  nrefine, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(512, 1) void ecu_cwt64_kernel7(real_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel70(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel71(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel72(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 19.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel73(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel74(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel75(const
  emxArray_real_T a, int32_T nrefine, emxArray_real_T dv22)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T ar;
    int32_T k;
    k = static_cast<int32_T>(idx);
    ar = a.data[k];
    dv22.data[k] = ar * ar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel76(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel77(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv28)
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
    dv28.data[varargin_3] = -2.0 * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel78(int32_T
  nrefine, emxArray_real_T dv28)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv28.data[k] = exp(dv28.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel79(const
  emxArray_real_T xt, const emxArray_real_T dv28, const emxArray_real_T dv22,
  int32_T b_dv22, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv22);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv22.data[varargin_3] * dv28.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel8(const int32_T
  nrefine, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel80(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel81(real_T
  interval[650])
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

static __global__ __launch_bounds__(512, 1) void ecu_cwt64_kernel82(real_T
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel83(const int32_T
  nrefine, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel84(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel85(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel86(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T dv30)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv30.data[k] = pow(x.data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel87(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel88(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv32)
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
    dv32.data[varargin_3] = -2.0 * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel89(int32_T
  nrefine, emxArray_real_T dv32)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv32.data[k] = exp(dv32.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel9(const real_T
  interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel90(const
  emxArray_real_T xt, const emxArray_real_T dv32, const emxArray_real_T dv30,
  int32_T b_dv30, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv30);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = dv30.data[varargin_3] * dv32.data[varargin_3] *
      xt.data[varargin_3];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel91(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    fx.data[varargin_3] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel92(real_T r,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(r));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_3;
    varargin_3 = static_cast<int32_T>(idx);
    y.data[varargin_3] = varargin_3;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel93(const
  emxArray_real_T y, const real_T toler, int32_T nrefine, emxArray_real_T b_y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b_y.data[k] = pow(toler, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel94(const
  emxArray_real_T y, const real_T r, int32_T b_y, emxArray_real_T fb_Scales)
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
    fb_Scales.data[varargin_3] = r * y.data[varargin_3];
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel95(const real_T
  fs, const real_T fb_FrequencyLimits[2], real_T NyquistRange[2])
{
  uint64_T threadId;
  int32_T varargin_3;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_3 = static_cast<int32_T>(threadId);
  if (varargin_3 < 2) {
    NyquistRange[varargin_3] = fb_FrequencyLimits[varargin_3] / fs * 2.0 *
      3.1415926535897931;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel96(real_T
  interval[650])
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

static __global__ __launch_bounds__(512, 1) void ecu_cwt64_kernel97(real_T
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

static __global__ __launch_bounds__(32, 1) void ecu_cwt64_kernel98(const int32_T
  nrefine, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_cwt64_kernel99(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static void ecu_cwt64_once()
{
  mwMemoryManagerInit(256U, 1U, 8U, 8192U);
  mwCudaMalloc(&cv_gpu_clone, static_cast<uint64_T>(sizeof(char_T [128])));
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[23])
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T emlrt_marshallIn(const mxArray *a__output_of_length_, const char_T
  *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(a__output_of_length_), &thisId);
  emlrtDestroyArray(&a__output_of_length_);
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

static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
  emxArray_char_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(tmpStr), &thisId, y);
  emlrtDestroyArray(&tmpStr);
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

static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_, const char_T *
  identifier, char_T y[23])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(a__output_of_sprintf_), &thisId, y);
  emlrtDestroyArray(&a__output_of_sprintf_);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_char_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
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

static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(int32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
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

static void emxEnsureCapacity_uint32_T(emxArray_uint32_T *emxArray, int32_T
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(uint32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<uint32_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<uint32_T *>(newData);
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

static void emxFree_int32_T(emxArray_int32_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_int32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<int32_T *>(nullptr)) && (*pEmxArray
        )->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_int32_T *>(nullptr);
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

static void emxFree_uint32_T(emxArray_uint32_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_uint32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<uint32_T *>(nullptr)) && (*pEmxArray
        )->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_uint32_T *>(nullptr);
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

static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_int32_T *emxArray;
  *pEmxArray = static_cast<emxArray_int32_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_int32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_int32_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<int32_T *>(nullptr);
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

static void emxInit_uint32_T(emxArray_uint32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_uint32_T *emxArray;
  *pEmxArray = static_cast<emxArray_uint32_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_uint32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_uint32_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<uint32_T *>(nullptr);
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

static const mxArray *feval(const mxArray *m1, const mxArray *m2, const mxArray *
  m3, emlrtMCInfo *location)
{
  const mxArray *pArrays[3];
  const mxArray *m;
  pArrays[0] = m1;
  pArrays[1] = m2;
  pArrays[2] = m3;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 3, &pArrays[0],
    "feval", true, location);
}

static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
  emxArray_creal_T *gpu)
{
  creal_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
      (cpu->allocatedSize) * sizeof(creal_T)));
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
      mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
        (cpu->allocatedSize) * sizeof(creal_T)));
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

static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu)
{
  int32_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
      (cpu->allocatedSize) * sizeof(int32_T)));
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
      mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
        (cpu->allocatedSize) * sizeof(int32_T)));
      cudaMemcpy(newData, gpu->data, static_cast<uint32_T>(actualSizeGpu) *
                 sizeof(int32_T), cudaMemcpyDeviceToDevice);
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
    mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
      (cpu->allocatedSize) * sizeof(real_T)));
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
      mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
        (cpu->allocatedSize) * sizeof(real_T)));
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

static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu)
{
  uint32_T *newData;
  if (gpu->data == 0U) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
      (cpu->allocatedSize) * sizeof(uint32_T)));
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
      mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
        (cpu->allocatedSize) * sizeof(uint32_T)));
      cudaMemcpy(newData, gpu->data, static_cast<uint32_T>(actualSizeGpu) *
                 sizeof(uint32_T), cudaMemcpyDeviceToDevice);
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

static void gpuEmxFree_int32_T(emxArray_int32_T *gpu)
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

static void gpuEmxFree_uint32_T(emxArray_uint32_T *gpu)
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
    mwCudaMalloc(&gpu->data, static_cast<uint64_T>(static_cast<uint32_T>
      (gpu->allocatedSize) * sizeof(creal_T)));
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
    mwCudaMalloc(&gpu->data, static_cast<uint64_T>(static_cast<uint32_T>
      (gpu->allocatedSize) * sizeof(real_T)));
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

static void gpuEmxReset_int32_T(emxArray_int32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_int32_T));
}

static void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real_T));
}

static void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_uint32_T));
}

static const mxArray *length(const mxArray *m1, emlrtMCInfo *location)
{
  const mxArray *m;
  const mxArray *pArray;
  pArray = m1;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 1, &pArray, "length",
    true, location);
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
// function [xx,freqs] = ecu_cwt64(x,fs,fLims,fOctave)
void ecu_cwt64(const emxArray_real_T *x, real_T fs, const real_T fLims[2],
               real_T fOctave, emxArray_real_T *xx, emxArray_real_T *freqs)
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

  static const real_T dv6[15]{ 0.022935322010529221, 0.063092092629978544,
    0.1047900103222502, 0.14065325971552589, 0.16900472663926791,
    0.19035057806478539, 0.20443294007529891, 0.20948214108472779,
    0.20443294007529891, 0.19035057806478539, 0.16900472663926791,
    0.14065325971552589, 0.1047900103222502, 0.063092092629978544,
    0.022935322010529221 };

  static const real_T dv7[15]{ 0.022935322010529221, -0.066392873538891159,
    0.1047900103222502, -0.13905213177375081, 0.16900472663926791,
    -0.19147947244033353, 0.20443294007529891, -0.20847704258874161,
    0.20443294007529891, -0.19147947244033353, 0.16900472663926791,
    -0.13905213177375081, 0.1047900103222502, -0.066392873538891159,
    0.022935322010529221 };

  static const real_T c[7]{ -0.001910444077728, 0.00084171387781295,
    -0.00059523799130430121, 0.0007936507935003503, -0.0027777777777776816,
    0.083333333333333329, 0.0057083835261 };

  static const int32_T iv[2]{ 1, 7 };

  static const int32_T iv1[2]{ 1, 7 };

  static const int32_T iv2[2]{ 1, 2 };

  static const int32_T iv3[2]{ 1, 7 };

  static const int32_T iv4[2]{ 1, 5 };

  static const char_T cv[128]{ '\x00', '\x01', '\x02', '\x03', '\x04', '\x05',
    '\x06', '\x07', '\x08', '\x09', '\x0a', '\x0b', '\x0c', '\x0d', '\x0e',
    '\x0f', '\x10', '\x11', '\x12', '\x13', '\x14', '\x15', '\x16', '\x17',
    '\x18', '\x19', '\x1a', '\x1b', '\x1c', '\x1d', '\x1e', '\x1f', ' ', '!',
    '\"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', '0',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?',
    '@', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
    'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '[', '\\', ']',
    '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
    'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{',
    '|', '}', '~', '\x7f' };

  static const char_T Bndry[10]{ 'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o',
    'n' };

  static const char_T cv1[10]{ 'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o', 'n'
  };

  static const char_T rfmt[7]{ '%', '2', '3', '.', '1', '5', 'e' };

  static const char_T u[7]{ 's', 'p', 'r', 'i', 'n', 't', 'f' };

  static const char_T b_b[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T b_formatSpec[5]{ '%', '2', '.', '2', 'f' };

  static const char_T cv2[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T cv3[5]{ 'm', 'o', 'r', 's', 'e' };

  static const char_T formatSpec[2]{ '%', 'f' };

  static const int8_T dv25[3]{ 2, 3, 1 };

  dim3 block;
  dim3 grid;
  emxArray_char_T *d_tmpStr;
  emxArray_char_T *tmpStr;
  emxArray_creal_T gpu_cfs;
  emxArray_creal_T gpu_cfspos;
  emxArray_creal_T gpu_cfsposdft;
  emxArray_creal_T gpu_xposdft;
  emxArray_creal_T *cfs;
  emxArray_creal_T *cfspos;
  emxArray_creal_T *cfsposdft;
  emxArray_creal_T *xposdft;
  emxArray_int32_T gpu_iv10;
  emxArray_int32_T gpu_iv8;
  emxArray_int32_T *iv10;
  emxArray_int32_T *iv8;
  emxArray_real_T b_gpu_a;
  emxArray_real_T b_gpu_fx;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_xt;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_a;
  emxArray_real_T c_gpu_fx;
  emxArray_real_T c_gpu_x;
  emxArray_real_T c_gpu_xt;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_a;
  emxArray_real_T d_gpu_fx;
  emxArray_real_T d_gpu_x;
  emxArray_real_T d_gpu_xt;
  emxArray_real_T d_gpu_y;
  emxArray_real_T e_gpu_fx;
  emxArray_real_T e_gpu_x;
  emxArray_real_T e_gpu_xt;
  emxArray_real_T e_gpu_y;
  emxArray_real_T f_gpu_fx;
  emxArray_real_T f_gpu_x;
  emxArray_real_T f_gpu_xt;
  emxArray_real_T f_gpu_y;
  emxArray_real_T g_gpu_fx;
  emxArray_real_T g_gpu_x;
  emxArray_real_T g_gpu_xt;
  emxArray_real_T g_gpu_y;
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_absomega;
  emxArray_real_T gpu_dv11;
  emxArray_real_T gpu_dv12;
  emxArray_real_T gpu_dv14;
  emxArray_real_T gpu_dv15;
  emxArray_real_T gpu_dv17;
  emxArray_real_T gpu_dv21;
  emxArray_real_T gpu_dv22;
  emxArray_real_T gpu_dv23;
  emxArray_real_T gpu_dv24;
  emxArray_real_T gpu_dv27;
  emxArray_real_T gpu_dv28;
  emxArray_real_T gpu_dv30;
  emxArray_real_T gpu_dv31;
  emxArray_real_T gpu_dv32;
  emxArray_real_T gpu_dv5;
  emxArray_real_T gpu_dv8;
  emxArray_real_T gpu_dv9;
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
  emxArray_real_T gpu_xt;
  emxArray_real_T gpu_xv;
  emxArray_real_T gpu_xx;
  emxArray_real_T gpu_y;
  emxArray_real_T h_gpu_fx;
  emxArray_real_T h_gpu_x;
  emxArray_real_T h_gpu_xt;
  emxArray_real_T h_gpu_y;
  emxArray_real_T i_gpu_x;
  emxArray_real_T i_gpu_y;
  emxArray_real_T j_gpu_x;
  emxArray_real_T j_gpu_y;
  emxArray_real_T k_gpu_x;
  emxArray_real_T k_gpu_y;
  emxArray_real_T l_gpu_x;
  emxArray_real_T l_gpu_y;
  emxArray_real_T m_gpu_x;
  emxArray_real_T m_gpu_y;
  emxArray_real_T n_gpu_x;
  emxArray_real_T n_gpu_y;
  emxArray_real_T o_gpu_x;
  emxArray_real_T o_gpu_y;
  emxArray_real_T p_gpu_x;
  emxArray_real_T p_gpu_y;
  emxArray_real_T q_gpu_x;
  emxArray_real_T q_gpu_y;
  emxArray_real_T r_gpu_x;
  emxArray_real_T r_gpu_y;
  emxArray_real_T s_gpu_x;
  emxArray_real_T s_gpu_y;
  emxArray_real_T t_gpu_x;
  emxArray_real_T t_gpu_y;
  emxArray_real_T u_gpu_y;
  emxArray_real_T v_gpu_y;
  emxArray_real_T *ab_y;
  emxArray_real_T *absomega;
  emxArray_real_T *b_a;
  emxArray_real_T *b_fx;
  emxArray_real_T *b_x;
  emxArray_real_T *b_xt;
  emxArray_real_T *bb_y;
  emxArray_real_T *c_a;
  emxArray_real_T *c_fx;
  emxArray_real_T *c_x;
  emxArray_real_T *c_xt;
  emxArray_real_T *cb_y;
  emxArray_real_T *d_a;
  emxArray_real_T *d_fx;
  emxArray_real_T *d_r;
  emxArray_real_T *d_x;
  emxArray_real_T *d_xt;
  emxArray_real_T *db_y;
  emxArray_real_T *dv11;
  emxArray_real_T *dv12;
  emxArray_real_T *dv14;
  emxArray_real_T *dv15;
  emxArray_real_T *dv17;
  emxArray_real_T *dv21;
  emxArray_real_T *dv22;
  emxArray_real_T *dv23;
  emxArray_real_T *dv24;
  emxArray_real_T *dv27;
  emxArray_real_T *dv28;
  emxArray_real_T *dv30;
  emxArray_real_T *dv31;
  emxArray_real_T *dv32;
  emxArray_real_T *dv5;
  emxArray_real_T *dv8;
  emxArray_real_T *dv9;
  emxArray_real_T *e_a;
  emxArray_real_T *e_fx;
  emxArray_real_T *e_x;
  emxArray_real_T *e_xt;
  emxArray_real_T *eb_y;
  emxArray_real_T *f;
  emxArray_real_T *f_fx;
  emxArray_real_T *f_x;
  emxArray_real_T *f_xt;
  emxArray_real_T *fb_Scales;
  emxArray_real_T *fx;
  emxArray_real_T *g_fx;
  emxArray_real_T *g_x;
  emxArray_real_T *g_xt;
  emxArray_real_T *h_fx;
  emxArray_real_T *h_x;
  emxArray_real_T *h_xt;
  emxArray_real_T *h_y;
  emxArray_real_T *i_x;
  emxArray_real_T *i_y;
  emxArray_real_T *j_x;
  emxArray_real_T *k_x;
  emxArray_real_T *k_y;
  emxArray_real_T *l_x;
  emxArray_real_T *l_y;
  emxArray_real_T *m_x;
  emxArray_real_T *m_y;
  emxArray_real_T *n_x;
  emxArray_real_T *n_y;
  emxArray_real_T *o_x;
  emxArray_real_T *o_y;
  emxArray_real_T *omega;
  emxArray_real_T *p_x;
  emxArray_real_T *p_y;
  emxArray_real_T *powscales;
  emxArray_real_T *psidft;
  emxArray_real_T *q_x;
  emxArray_real_T *q_y;
  emxArray_real_T *r_x;
  emxArray_real_T *r_y;
  emxArray_real_T *s_x;
  emxArray_real_T *s_y;
  emxArray_real_T *somega;
  emxArray_real_T *t_x;
  emxArray_real_T *t_y;
  emxArray_real_T *u_y;
  emxArray_real_T *v_y;
  emxArray_real_T *w_y;
  emxArray_real_T *x_y;
  emxArray_real_T *xt;
  emxArray_real_T *xv;
  emxArray_real_T *y_y;
  emxArray_uint32_T gpu_ii;
  emxArray_uint32_T gpu_is;
  emxArray_uint32_T *ii;
  emxArray_uint32_T *is;
  const mxArray *b_tmpStr;
  const mxArray *b_y;
  const mxArray *c_tmpStr;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *f_y;
  const mxArray *g_y;
  const mxArray *j_y;
  const mxArray *m;
  const mxArray *y;
  creal_T *b_gpu_cfsposdft;
  real_T subs[1298];
  real_T (*gpu_subs)[1298];
  real_T interval[650];
  real_T (*gpu_interval)[650];
  real_T errsub[649];
  real_T qsub[649];
  real_T NyquistRange[2];
  real_T freqrange[2];
  real_T (*gpu_NyquistRange)[2];
  real_T (*gpu_fb_FrequencyLimits)[2];
  real_T (*gpu_freqrange)[2];
  real_T a;
  real_T b_m;
  real_T b_r;
  real_T c_r;
  real_T err_ok;
  real_T fb;
  real_T halfh;
  real_T intDsq;
  real_T intFsq;
  real_T omegac;
  real_T q_ok;
  real_T r;
  real_T s;
  real_T tol;
  real_T toler;
  int32_T b_eint;
  int32_T b_i;
  int32_T c_eint;
  int32_T csz_idx_0;
  int32_T eint;
  int32_T exitg1;
  int32_T fb_CutOff;
  int32_T fb_SignalPad;
  int32_T i;
  int32_T k;
  int32_T lidx;
  int32_T nrefine;
  int32_T nsubs;
  uint32_T xSize[2];
  uint32_T (*gpu_xSize)[2];
  uint32_T N;
  int16_T dv4_idx_1;
  char_T unusedExpr[23];
  char_T wav[5];
  char_T (*gpu_wav)[5];
  int8_T n_idx_0;
  boolean_T b[2];
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
  boolean_T c_a_dirtyOnCpu;
  boolean_T c_a_dirtyOnGpu;
  boolean_T c_fx_dirtyOnCpu;
  boolean_T c_fx_dirtyOnGpu;
  boolean_T c_x_dirtyOnCpu;
  boolean_T c_x_dirtyOnGpu;
  boolean_T c_xt_dirtyOnGpu;
  boolean_T c_y_dirtyOnGpu;
  boolean_T d_a_dirtyOnCpu;
  boolean_T d_a_dirtyOnGpu;
  boolean_T d_fx_dirtyOnCpu;
  boolean_T d_fx_dirtyOnGpu;
  boolean_T d_x_dirtyOnCpu;
  boolean_T d_x_dirtyOnGpu;
  boolean_T d_xt_dirtyOnGpu;
  boolean_T d_y_dirtyOnGpu;
  boolean_T dv11_dirtyOnGpu;
  boolean_T dv12_dirtyOnGpu;
  boolean_T dv14_dirtyOnGpu;
  boolean_T dv15_dirtyOnGpu;
  boolean_T dv17_dirtyOnGpu;
  boolean_T dv21_dirtyOnGpu;
  boolean_T dv22_dirtyOnGpu;
  boolean_T dv24_dirtyOnGpu;
  boolean_T dv27_dirtyOnGpu;
  boolean_T dv28_dirtyOnGpu;
  boolean_T dv30_dirtyOnGpu;
  boolean_T dv31_dirtyOnGpu;
  boolean_T dv32_dirtyOnGpu;
  boolean_T dv5_dirtyOnGpu;
  boolean_T dv8_dirtyOnGpu;
  boolean_T dv9_dirtyOnGpu;
  boolean_T e_fx_dirtyOnCpu;
  boolean_T e_fx_dirtyOnGpu;
  boolean_T e_x_dirtyOnCpu;
  boolean_T e_x_dirtyOnGpu;
  boolean_T e_xt_dirtyOnGpu;
  boolean_T e_y_dirtyOnGpu;
  boolean_T exitg2;
  boolean_T f_fx_dirtyOnCpu;
  boolean_T f_fx_dirtyOnGpu;
  boolean_T f_x_dirtyOnCpu;
  boolean_T f_x_dirtyOnGpu;
  boolean_T f_xt_dirtyOnGpu;
  boolean_T f_y_dirtyOnGpu;
  boolean_T fb_Scales_dirtyOnGpu;
  boolean_T first_iteration;
  boolean_T freqs_dirtyOnGpu;
  boolean_T fx_dirtyOnCpu;
  boolean_T fx_dirtyOnGpu;
  boolean_T g_fx_dirtyOnCpu;
  boolean_T g_fx_dirtyOnGpu;
  boolean_T g_x_dirtyOnCpu;
  boolean_T g_x_dirtyOnGpu;
  boolean_T g_xt_dirtyOnGpu;
  boolean_T g_y_dirtyOnGpu;
  boolean_T h_fx_dirtyOnCpu;
  boolean_T h_fx_dirtyOnGpu;
  boolean_T h_x_dirtyOnCpu;
  boolean_T h_x_dirtyOnGpu;
  boolean_T h_xt_dirtyOnGpu;
  boolean_T h_y_dirtyOnGpu;
  boolean_T i_x_dirtyOnCpu;
  boolean_T i_x_dirtyOnGpu;
  boolean_T interval_dirtyOnCpu;
  boolean_T j_x_dirtyOnCpu;
  boolean_T j_x_dirtyOnGpu;
  boolean_T k_x_dirtyOnCpu;
  boolean_T k_x_dirtyOnGpu;
  boolean_T l_x_dirtyOnCpu;
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
  if (!gpuConstsCopied_ecu_cwt64) {
    gpuConstsCopied_ecu_cwt64 = true;
    cudaMemcpy(*cv_gpu_clone, cv, sizeof(char_T [128]), cudaMemcpyHostToDevice);
  }

  gpuEmxReset_real_T(&gpu_xx);
  gpuEmxReset_real_T(&gpu_dv23);
  gpuEmxReset_real_T(&v_gpu_y);
  gpuEmxReset_real_T(&u_gpu_y);
  gpuEmxReset_creal_T(&gpu_cfs);
  gpuEmxReset_creal_T(&gpu_cfspos);
  mwCudaMalloc(&b_gpu_cfsposdft, 16UL);
  mwCudaMalloc(&gpu_xSize, 8UL);
  gpuEmxReset_creal_T(&gpu_cfsposdft);
  gpuEmxReset_real_T(&t_gpu_x);
  gpuEmxReset_creal_T(&gpu_xposdft);
  gpuEmxReset_real_T(&gpu_xv);
  gpuEmxReset_real_T(&s_gpu_x);
  gpuEmxReset_real_T(&r_gpu_x);
  gpuEmxReset_int32_T(&gpu_iv10);
  gpuEmxReset_int32_T(&gpu_iv8);
  gpuEmxReset_real_T(&gpu_dv28);
  gpuEmxReset_real_T(&gpu_dv24);
  gpuEmxReset_real_T(&gpu_dv32);
  gpuEmxReset_uint32_T(&gpu_is);
  gpuEmxReset_real_T(&gpu_dv31);
  gpuEmxReset_real_T(&t_gpu_y);
  gpuEmxReset_real_T(&s_gpu_y);
  gpuEmxReset_real_T(&r_gpu_y);
  gpuEmxReset_uint32_T(&gpu_ii);
  gpuEmxReset_real_T(&h_gpu_fx);
  gpuEmxReset_real_T(&q_gpu_y);
  gpuEmxReset_real_T(&gpu_dv22);
  gpuEmxReset_real_T(&gpu_dv21);
  gpuEmxReset_real_T(&g_gpu_fx);
  gpuEmxReset_real_T(&d_gpu_a);
  gpuEmxReset_real_T(&c_gpu_a);
  gpuEmxReset_real_T(&gpu_dv30);
  gpuEmxReset_real_T(&q_gpu_x);
  gpuEmxReset_real_T(&gpu_dv27);
  gpuEmxReset_real_T(&p_gpu_y);
  gpuEmxReset_real_T(&o_gpu_y);
  gpuEmxReset_real_T(&f_gpu_fx);
  gpuEmxReset_real_T(&e_gpu_fx);
  gpuEmxReset_real_T(&p_gpu_x);
  gpuEmxReset_real_T(&h_gpu_xt);
  gpuEmxReset_real_T(&o_gpu_x);
  gpuEmxReset_real_T(&gpu_freqs);
  gpuEmxReset_real_T(&n_gpu_x);
  gpuEmxReset_real_T(&g_gpu_xt);
  gpuEmxReset_real_T(&m_gpu_x);
  gpuEmxReset_real_T(&n_gpu_y);
  gpuEmxReset_real_T(&m_gpu_y);
  gpuEmxReset_real_T(&gpu_powscales);
  gpuEmxReset_real_T(&gpu_absomega);
  gpuEmxReset_real_T(&l_gpu_x);
  gpuEmxReset_real_T(&f_gpu_xt);
  gpuEmxReset_real_T(&k_gpu_x);
  gpuEmxReset_real_T(&j_gpu_x);
  gpuEmxReset_real_T(&e_gpu_xt);
  gpuEmxReset_real_T(&i_gpu_x);
  gpuEmxReset_real_T(&gpu_f);
  gpuEmxReset_real_T(&gpu_somega);
  gpuEmxReset_real_T(&gpu_dv12);
  gpuEmxReset_real_T(&gpu_psidft);
  gpuEmxReset_real_T(&gpu_dv17);
  gpuEmxReset_real_T(&gpu_dv9);
  gpuEmxReset_real_T(&l_gpu_y);
  gpuEmxReset_real_T(&k_gpu_y);
  gpuEmxReset_real_T(&gpu_dv14);
  gpuEmxReset_real_T(&d_gpu_fx);
  gpuEmxReset_real_T(&j_gpu_y);
  gpuEmxReset_real_T(&gpu_dv8);
  gpuEmxReset_real_T(&i_gpu_y);
  gpuEmxReset_real_T(&b_gpu_a);
  gpuEmxReset_real_T(&gpu_dv15);
  gpuEmxReset_real_T(&gpu_fb_Scales);
  gpuEmxReset_real_T(&h_gpu_y);
  gpuEmxReset_real_T(&g_gpu_y);
  gpuEmxReset_real_T(&gpu_dv5);
  gpuEmxReset_real_T(&c_gpu_fx);
  gpuEmxReset_real_T(&gpu_a);
  gpuEmxReset_real_T(&f_gpu_y);
  gpuEmxReset_real_T(&b_gpu_fx);
  gpuEmxReset_real_T(&gpu_dv11);
  gpuEmxReset_real_T(&e_gpu_y);
  gpuEmxReset_real_T(&h_gpu_x);
  gpuEmxReset_real_T(&d_gpu_xt);
  gpuEmxReset_real_T(&g_gpu_x);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_real_T(&gpu_fx);
  gpuEmxReset_real_T(&f_gpu_x);
  gpuEmxReset_real_T(&c_gpu_xt);
  gpuEmxReset_real_T(&e_gpu_x);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&d_gpu_x);
  gpuEmxReset_real_T(&b_gpu_xt);
  gpuEmxReset_real_T(&c_gpu_x);
  gpuEmxReset_real_T(&b_gpu_x);
  gpuEmxReset_real_T(&gpu_xt);
  gpuEmxReset_real_T(&gpu_x);
  mwCudaMalloc(&gpu_subs, 10384UL);
  gpuEmxReset_real_T(&gpu_r);
  gpuEmxReset_real_T(&gpu_omega);
  mwCudaMalloc(&gpu_interval, 5200UL);
  mwCudaMalloc(&gpu_wav, 5UL);
  mwCudaMalloc(&gpu_NyquistRange, 16UL);
  mwCudaMalloc(&gpu_freqrange, 16UL);
  mwCudaMalloc(&gpu_b, 2UL);
  mwCudaMalloc(&gpu_fb_FrequencyLimits, 16UL);
  k_x_dirtyOnGpu = false;
  xv_dirtyOnGpu = false;
  j_x_dirtyOnGpu = false;
  dv28_dirtyOnGpu = false;
  dv24_dirtyOnGpu = false;
  dv32_dirtyOnGpu = false;
  dv31_dirtyOnGpu = false;
  h_fx_dirtyOnGpu = false;
  dv22_dirtyOnGpu = false;
  dv21_dirtyOnGpu = false;
  g_fx_dirtyOnGpu = false;
  d_a_dirtyOnGpu = false;
  c_a_dirtyOnGpu = false;
  dv30_dirtyOnGpu = false;
  i_x_dirtyOnGpu = false;
  dv27_dirtyOnGpu = false;
  h_y_dirtyOnGpu = false;
  g_y_dirtyOnGpu = false;
  f_fx_dirtyOnGpu = false;
  e_fx_dirtyOnGpu = false;
  h_x_dirtyOnGpu = false;
  h_xt_dirtyOnGpu = false;
  g_x_dirtyOnGpu = false;
  g_xt_dirtyOnGpu = false;
  f_y_dirtyOnGpu = false;
  e_y_dirtyOnGpu = false;
  powscales_dirtyOnGpu = false;
  absomega_dirtyOnGpu = false;
  f_x_dirtyOnGpu = false;
  f_xt_dirtyOnGpu = false;
  e_x_dirtyOnGpu = false;
  e_xt_dirtyOnGpu = false;
  somega_dirtyOnGpu = false;
  dv12_dirtyOnGpu = false;
  dv17_dirtyOnGpu = false;
  dv9_dirtyOnGpu = false;
  dv14_dirtyOnGpu = false;
  d_fx_dirtyOnGpu = false;
  dv8_dirtyOnGpu = false;
  b_a_dirtyOnGpu = false;
  dv15_dirtyOnGpu = false;
  fb_Scales_dirtyOnGpu = false;
  dv5_dirtyOnGpu = false;
  c_fx_dirtyOnGpu = false;
  a_dirtyOnGpu = false;
  d_y_dirtyOnGpu = false;
  b_fx_dirtyOnGpu = false;
  dv11_dirtyOnGpu = false;
  d_x_dirtyOnGpu = false;
  d_xt_dirtyOnGpu = false;
  c_y_dirtyOnGpu = false;
  b_y_dirtyOnGpu = false;
  fx_dirtyOnGpu = false;
  c_x_dirtyOnGpu = false;
  c_xt_dirtyOnGpu = false;
  y_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  b_xt_dirtyOnGpu = false;
  x_dirtyOnGpu = false;
  xt_dirtyOnGpu = false;
  subs_dirtyOnGpu = false;
  omega_dirtyOnGpu = false;
  xSize_dirtyOnCpu = false;
  l_x_dirtyOnCpu = false;
  xposdft_dirtyOnCpu = false;
  xv_dirtyOnCpu = false;
  k_x_dirtyOnCpu = false;
  h_fx_dirtyOnCpu = false;
  g_fx_dirtyOnCpu = false;
  d_a_dirtyOnCpu = false;
  c_a_dirtyOnCpu = false;
  i_x_dirtyOnCpu = false;
  f_fx_dirtyOnCpu = false;
  e_fx_dirtyOnCpu = false;
  h_x_dirtyOnCpu = false;
  g_x_dirtyOnCpu = false;
  f_x_dirtyOnCpu = false;
  e_x_dirtyOnCpu = false;
  somega_dirtyOnCpu = false;
  psidft_dirtyOnCpu = false;
  d_fx_dirtyOnCpu = false;
  b_a_dirtyOnCpu = false;
  b_y_dirtyOnCpu = false;
  c_fx_dirtyOnCpu = false;
  a_dirtyOnCpu = false;
  b_fx_dirtyOnCpu = false;
  d_x_dirtyOnCpu = false;
  y_dirtyOnCpu = false;
  fx_dirtyOnCpu = false;
  c_x_dirtyOnCpu = false;
  b_x_dirtyOnCpu = false;
  x_dirtyOnCpu = false;
  subs_dirtyOnCpu = false;
  interval_dirtyOnCpu = false;
  j_x_dirtyOnCpu = true;
  xx_dirtyOnGpu = false;
  xx_dirtyOnCpu = true;
  freqs_dirtyOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  //  Continuous wavelet transform - CUDA binary wrapper (double-precision, FP64)
  //  CWT uses morse wavelets, as they account for unequal variance-covariance across freqs.
  //  L1-norm is applied to mitigate 1/f decay of neuronal field potentials.
  //  Log-transform & robust z-scoring converts absolute valued CWT outputs into normal distribution.
  //
  //  Kevin Tan, 2022 (kevmtan.github.io)
  //  Input validation
  // 'ecu_cwt64:11' x double
  //  Input data
  // 'ecu_cwt64:12' fs (1,1){mustBeGreaterThan(fs,1)} = 1000
  //  Sampling rate
  // 'ecu_cwt64:13' fLims (1,2){mustBeGreaterThanOrEqual(fLims,1),...
  // 'ecu_cwt64:14'         mustBeLessThan(fLims,fs)} = [1 300]
  first_iteration = true;
  if ((!(fLims[0] < fs)) || (!(fLims[1] < fs))) {
    first_iteration = false;
  }

  if (!first_iteration) {
    y = nullptr;
    m = emlrtCreateCharArray(2, &iv[0]);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
    emlrtAssign(&y, m);
    b_y = nullptr;
    m = emlrtCreateDoubleScalar(fs);
    emlrtAssign(&b_y, m);
    emlrt_marshallIn(b_sprintf(y, b_y, &emlrtMCI), "<output of sprintf>",
                     unusedExpr);
  }

  //  Frequency limits
  // 'ecu_cwt64:15' fOctave (1,1){mustBeGreaterThanOrEqual(fOctave,1),...
  // 'ecu_cwt64:16'         mustBeLessThanOrEqual(fOctave,48)} = 10
  //  Voices per octave
  //  Initialize
  // 'ecu_cwt64:20' coder.gpu.kernelfun;
  //  Trigger CUDA kernel generation
  // 'ecu_cwt64:21' nFrames = size(x,1);
  // 'ecu_cwt64:22' nChs = size(x,2);
  // 'ecu_cwt64:23' fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,SamplingFrequency=fs,...
  // 'ecu_cwt64:24'     VoicesPerOctave=fOctave,FrequencyLimits=fLims);
  fb_CutOff = 50;
  ecu_cwt64_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
    (*gpu_fb_FrequencyLimits, fLims[0], fLims[1]);
  first_iteration = false;
  lidx = 0;
  do {
    exitg1 = 0;
    if (lidx + 1 < 11) {
      if (cv[static_cast<int32_T>(Bndry[lidx])] != cv[static_cast<int32_T>
          (cv1[lidx])]) {
        exitg1 = 1;
      } else {
        lidx++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (first_iteration) {
    if (x->size[0] <= 100000) {
      fb_SignalPad = static_cast<int32_T>(std::floor(static_cast<real_T>(x->
        size[0]) / 2.0));
    } else {
      r = std::frexp(static_cast<real_T>(x->size[0]), &nrefine);
      if (r == 0.5) {
        toler = static_cast<real_T>(nrefine) - 1.0;
      } else {
        toler = std::log(r) / 0.69314718055994529 + static_cast<real_T>(nrefine);
      }

      toler = std::ceil(toler);
      fb_SignalPad = static_cast<int32_T>(toler);
    }
  } else {
    fb_SignalPad = 0;
  }

  ecu_cwt64_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_b, fLims[0],
    fLims[1]);
  b_dirtyOnGpu = true;
  first_iteration = true;
  k = 0;
  exitg2 = false;
  while ((!exitg2) && (k <= 1)) {
    if (b_dirtyOnGpu) {
      cudaMemcpy(b, *gpu_b, 2UL, cudaMemcpyDeviceToHost);
    }

    b_dirtyOnGpu = false;
    if (!b[k]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      k++;
    }
  }

  if (!first_iteration) {
    real_T cf;
    boolean_T guard1{ false };

    ecu_cwt64_kernel3<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_freqrange,
      fLims[0], fLims[1]);
    ecu_cwt64_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs,
      *gpu_NyquistRange);
    b_dirtyOnGpu = true;
    emxInit_char_T(&tmpStr, 2, &sb_emlrtRTEI, true);
    guard1 = false;
    if (fLims[1] <= 0.0) {
      guard1 = true;
    } else {
      cudaMemcpy(NyquistRange, *gpu_NyquistRange, 16UL, cudaMemcpyDeviceToHost);
      b_dirtyOnGpu = false;
      if (fLims[0] >= NyquistRange[1]) {
        guard1 = true;
      }
    }

    if (guard1) {
      b_tmpStr = nullptr;
      c_y = nullptr;
      m = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&c_y, m);
      d_y = nullptr;
      m = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 2, m, &formatSpec[0]);
      emlrtAssign(&d_y, m);
      e_y = nullptr;
      if (b_dirtyOnGpu) {
        cudaMemcpy(NyquistRange, *gpu_NyquistRange, 16UL, cudaMemcpyDeviceToHost);
      }

      m = emlrtCreateDoubleScalar(NyquistRange[1]);
      emlrtAssign(&e_y, m);
      emlrtAssign(&b_tmpStr, feval(c_y, d_y, e_y, &b_emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(b_tmpStr), &c_emlrtMCI),
                       "<output of length>");
      emlrt_marshallIn(emlrtAlias(b_tmpStr), "tmpStr", tmpStr);
      emlrtDestroyArray(&b_tmpStr);
    }

    emxFree_char_T(&tmpStr);
    ecu_cwt64_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*cv_gpu_clone,
      *gpu_wav, 'M', 'o', 'r', 's', 'e');
    omegac = 3.1415926535897931;
    cf = 0.0;
    c_r = 0.0;
    cudaMemcpy(wav, *gpu_wav, 5UL, cudaMemcpyDeviceToHost);
    if (cv[static_cast<int32_T>(wav[0])] == 'm') {
      lidx = 0;
    } else if (cv[static_cast<int32_T>(wav[0])] == 'a') {
      lidx = 1;
    } else if (cv[static_cast<int32_T>(wav[0])] == 'b') {
      lidx = 2;
    } else {
      lidx = -1;
    }

    switch (lidx) {
     case 0:
      cf = 1.8820720577620569;
      b_r = 0.0057083835261;
      c_r = 0.0057083835261;
      r = 0.0057083835261;
      for (i = 0; i < 6; i++) {
        fb = c[i];
        b_r = b_r * 0.005353955978584176 + fb;
        c_r = c_r * 0.005353955978584176 + fb;
        r = r * 0.005353955978584176 + fb;
      }

      b_r /= 13.666666666666666;
      c_r /= 13.666666666666666;
      r /= 13.666666666666666;
      c_r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((c_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(c_r) || std::isnan(c_r)) {
        ecu_cwt64_kernel6<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ecu_cwt64_kernel7<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        intDsq = 0.0;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        i = static_cast<int32_T>(interval[1]) - static_cast<int32_T>(interval[0]);
        if (i > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          k = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            r = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) +
              1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * r;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          k = 1;
        }

        lidx = 0;
        for (nsubs = 0; nsubs < nrefine; nsubs++) {
          if (std::abs(interval[nsubs + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[nsubs + 1];
            interval_dirtyOnCpu = true;
          } else {
            k--;
          }
        }

        if (k + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecu_cwt64_kernel8<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          k = 1;
        }

        if (i <= 0) {
          intDsq = rtNaN;
        } else {
          nsubs = k - 1;
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) +
            1L), &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            ecu_cwt64_kernel9<<<grid, block>>>(*gpu_interval, k - 1, *gpu_subs);
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&d_x, 2, &e_emlrtRTEI, true);
          emxInit_real_T(&e_x, 2, &tb_emlrtRTEI, true);
          emxInit_real_T(&b_xt, 2, &xb_emlrtRTEI, true);
          emxInit_real_T(&l_y, 2, &bc_emlrtRTEI, true);
          emxInit_real_T(&b_fx, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&m_y, 2, &cc_emlrtRTEI, true);
          emxInit_real_T(&c_a, 2, &k_emlrtRTEI, true);
          emxInit_real_T(&dv8, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&n_y, 2, &dc_emlrtRTEI, true);
          emxInit_real_T(&dv12, 2, &sb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            b_i = d_x->size[0] * d_x->size[1];
            d_x->size[0] = 1;
            d_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(d_x, b_i, &e_emlrtRTEI);
            if (!b_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(d_x, &c_gpu_x);
            }

            lidx = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fb = subs[k << 1];
              subs_dirtyOnGpu = false;
              r = subs[(k << 1) + 1];
              c_r = (fb + r) / 2.0;
              halfh = (r - fb) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                d_x->data[(lidx + nrefine) + 1] = NODES[nrefine] * halfh + c_r;
                b_x_dirtyOnCpu = true;
              }

              lidx += 15;
            }

            b_i = e_x->size[0] * e_x->size[1];
            e_x->size[0] = 1;
            e_x->size[1] = d_x->size[1];
            emxEnsureCapacity_real_T(e_x, b_i, &f_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(e_x, &d_gpu_x);
            b_i = b_xt->size[0] * b_xt->size[1];
            b_xt->size[0] = 1;
            b_xt->size[1] = d_x->size[1];
            emxEnsureCapacity_real_T(b_xt, b_i, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_xt, &b_gpu_xt);
            lidx = d_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(lidx + 1L),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, d_x);
              }

              b_x_dirtyOnCpu = false;
              ecu_cwt64_kernel10<<<grid, block>>>(c_gpu_x, lidx, b_gpu_xt,
                d_gpu_x);
              b_x_dirtyOnGpu = true;
              b_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (b_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(e_x, &d_gpu_x);
              }

              b_x_dirtyOnGpu = false;
              c_r = std::abs(e_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= e_x->size[1] - 2)) {
                toler = c_r;
                c_r = std::abs(e_x->data[k + 1]);
                if (std::abs(e_x->data[k + 1] - e_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(toler, c_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(d_x->size[1]);
                b_i = b_fx->size[0] * b_fx->size[1];
                b_fx->size[0] = 1;
                b_fx->size[1] = d_x->size[1];
                emxEnsureCapacity_real_T(b_fx, b_i, &j_emlrtRTEI);
                if (!b_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(b_fx, &b_gpu_fx);
                }

                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (b_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_fx, b_fx);
                  }

                  ecu_cwt64_kernel19<<<grid, block>>>(dv4_idx_1, b_gpu_fx);
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
              b_i = l_y->size[0] * l_y->size[1];
              l_y->size[0] = 1;
              l_y->size[1] = e_x->size[1];
              emxEnsureCapacity_real_T(l_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(l_y, &c_gpu_y);
              nrefine = e_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel11<<<grid, block>>>(d_gpu_x, nrefine, c_gpu_y);
                b_y_dirtyOnGpu = true;
              }

              b_i = m_y->size[0] * m_y->size[1];
              m_y->size[0] = 1;
              m_y->size[1] = e_x->size[1];
              emxEnsureCapacity_real_T(m_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(m_y, &f_gpu_y);
              nrefine = e_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel12<<<grid, block>>>(d_gpu_x, nrefine, f_gpu_y);
                d_y_dirtyOnGpu = true;
              }

              if (l_y->size[1] == m_y->size[1]) {
                b_i = c_a->size[0] * c_a->size[1];
                c_a->size[0] = 1;
                c_a->size[1] = l_y->size[1];
                emxEnsureCapacity_real_T(c_a, b_i, &k_emlrtRTEI);
                if (!b_a_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(c_a, &b_gpu_a);
                }

                i = l_y->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (b_a_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_a, c_a);
                  }

                  ecu_cwt64_kernel13<<<grid, block>>>(f_gpu_y, c_gpu_y, i,
                    b_gpu_a);
                  b_a_dirtyOnCpu = false;
                  b_a_dirtyOnGpu = true;
                }
              } else {
                if (b_a_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_a, &b_gpu_a);
                }

                if (b_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(l_y, &c_gpu_y);
                }

                b_y_dirtyOnGpu = false;
                if (d_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(m_y, &f_gpu_y);
                }

                d_y_dirtyOnGpu = false;
                c_binary_expand_op(c_a, l_y, m_y);
                b_a_dirtyOnGpu = false;
                b_a_dirtyOnCpu = true;
              }

              b_i = dv8->size[0] * dv8->size[1];
              dv8->size[0] = 1;
              dv8->size[1] = static_cast<int16_T>(c_a->size[1]);
              emxEnsureCapacity_real_T(dv8, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv8, &gpu_dv8);
              nrefine = static_cast<int16_T>(c_a->size[1]) - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                if (b_a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_a, c_a);
                }

                b_a_dirtyOnCpu = false;
                ecu_cwt64_kernel14<<<grid, block>>>(b_gpu_a, nrefine, gpu_dv8);
                dv8_dirtyOnGpu = true;
              }

              b_i = n_y->size[0] * n_y->size[1];
              n_y->size[0] = 1;
              n_y->size[1] = e_x->size[1];
              emxEnsureCapacity_real_T(n_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(n_y, &l_gpu_y);
              nrefine = e_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel15<<<grid, block>>>(d_gpu_x, nrefine, l_gpu_y);
              }

              b_i = dv12->size[0] * dv12->size[1];
              dv12->size[0] = 1;
              dv12->size[1] = n_y->size[1];
              emxEnsureCapacity_real_T(dv12, b_i, &m_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv12, &gpu_dv12);
              i = n_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel16<<<grid, block>>>(l_gpu_y, i, gpu_dv12);
                dv12_dirtyOnGpu = true;
              }

              nrefine = dv12->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel17<<<grid, block>>>(nrefine, gpu_dv12);
                dv12_dirtyOnGpu = true;
              }

              if (dv8->size[1] == dv12->size[1]) {
                b_i = b_fx->size[0] * b_fx->size[1];
                b_fx->size[0] = 1;
                b_fx->size[1] = dv8->size[1];
                emxEnsureCapacity_real_T(b_fx, b_i, &q_emlrtRTEI);
                if (!b_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(b_fx, &b_gpu_fx);
                }

                k = dv8->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (b_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_fx, b_fx);
                  }

                  ecu_cwt64_kernel18<<<grid, block>>>(b_gpu_xt, gpu_dv12,
                    gpu_dv8, k, b_gpu_fx);
                  b_fx_dirtyOnCpu = false;
                  b_fx_dirtyOnGpu = true;
                }
              } else {
                if (b_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_fx, &b_gpu_fx);
                }

                if (dv8_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv8, &gpu_dv8);
                }

                dv8_dirtyOnGpu = false;
                if (dv12_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv12, &gpu_dv12);
                }

                dv12_dirtyOnGpu = false;
                if (b_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_xt, &b_gpu_xt);
                }

                b_xt_dirtyOnGpu = false;
                binary_expand_op(b_fx, dv8, dv12, b_xt);
                b_fx_dirtyOnGpu = false;
                b_fx_dirtyOnCpu = true;
              }

              c_r = 0.0;
              lidx = -1;
              for (k = 0; k <= nsubs; k++) {
                fb = 0.0;
                r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (b_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(b_fx, &b_gpu_fx);
                  }

                  fb += dv6[nrefine] * b_fx->data[(lidx + nrefine) + 1];
                  b_fx_dirtyOnGpu = false;
                  r += dv7[nrefine] * b_fx->data[(lidx + nrefine) + 1];
                }

                lidx += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fb *= halfh;
                qsub[k] = fb;
                c_r += fb;
                errsub[k] = r * halfh;
              }

              intDsq = c_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              c_r = 2.0 * tol;
              r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fb = errsub[k];
                halfh = std::abs(fb);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= c_r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0))
                {
                  err_ok += fb;
                  q_ok += qsub[k];
                } else {
                  r += halfh;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              c_r = std::abs(err_ok) + r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(c_r)) && (!std::isnan(c_r))) && (nrefine != 0) &&
                  (!(c_r <= tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    lidx = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((lidx << 1) - 1) << 1) + 1] = subs[((lidx - 1) << 1)
                      + 1];
                    subs[((lidx << 1) - 1) << 1] = (subs[(lidx - 1) << 1] +
                      subs[((lidx - 1) << 1) + 1]) / 2.0;
                    subs[(((lidx << 1) - 2) << 1) + 1] = subs[((lidx << 1) - 1) <<
                      1];
                    subs[((lidx << 1) - 2) << 1] = subs[(lidx - 1) << 1];
                    subs_dirtyOnGpu = false;
                    subs_dirtyOnCpu = true;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&dv12);
          emxFree_real_T(&n_y);
          emxFree_real_T(&dv8);
          emxFree_real_T(&c_a);
          emxFree_real_T(&m_y);
          emxFree_real_T(&b_fx);
          emxFree_real_T(&l_y);
          emxFree_real_T(&b_xt);
          emxFree_real_T(&e_x);
          emxFree_real_T(&d_x);
        }

        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecu_cwt64_kernel20<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecu_cwt64_kernel21<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        intFsq = 0.0;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        i = static_cast<int32_T>(interval[1]) - static_cast<int32_T>(interval[0]);
        if (i > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          k = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            r = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) +
              1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * r;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          k = 1;
        }

        lidx = 0;
        for (nsubs = 0; nsubs < nrefine; nsubs++) {
          if (std::abs(interval[nsubs + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[nsubs + 1];
            interval_dirtyOnCpu = true;
          } else {
            k--;
          }
        }

        if (k + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecu_cwt64_kernel22<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          k = 1;
        }

        if (i <= 0) {
          intFsq = rtNaN;
        } else {
          nsubs = k - 1;
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) +
            1L), &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ecu_cwt64_kernel23<<<grid, block>>>(*gpu_interval, k - 1, *gpu_subs);
            subs_dirtyOnCpu = false;
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&h_x, 2, &e_emlrtRTEI, true);
          emxInit_real_T(&i_x, 2, &tb_emlrtRTEI, true);
          emxInit_real_T(&d_xt, 2, &xb_emlrtRTEI, true);
          emxInit_real_T(&dv15, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&d_fx, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&q_y, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&dv17, 2, &sb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            b_i = h_x->size[0] * h_x->size[1];
            h_x->size[0] = 1;
            h_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(h_x, b_i, &e_emlrtRTEI);
            if (!d_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(h_x, &g_gpu_x);
            }

            lidx = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fb = subs[k << 1];
              subs_dirtyOnGpu = false;
              r = subs[(k << 1) + 1];
              c_r = (fb + r) / 2.0;
              halfh = (r - fb) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                h_x->data[(lidx + nrefine) + 1] = NODES[nrefine] * halfh + c_r;
                d_x_dirtyOnCpu = true;
              }

              lidx += 15;
            }

            b_i = i_x->size[0] * i_x->size[1];
            i_x->size[0] = 1;
            i_x->size[1] = h_x->size[1];
            emxEnsureCapacity_real_T(i_x, b_i, &f_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(i_x, &h_gpu_x);
            b_i = d_xt->size[0] * d_xt->size[1];
            d_xt->size[0] = 1;
            d_xt->size[1] = h_x->size[1];
            emxEnsureCapacity_real_T(d_xt, b_i, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_xt, &d_gpu_xt);
            lidx = h_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(lidx + 1L),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (d_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_x, h_x);
              }

              d_x_dirtyOnCpu = false;
              ecu_cwt64_kernel24<<<grid, block>>>(g_gpu_x, lidx, d_gpu_xt,
                h_gpu_x);
              d_x_dirtyOnGpu = true;
              d_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (d_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_x, &h_gpu_x);
              }

              d_x_dirtyOnGpu = false;
              c_r = std::abs(i_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= i_x->size[1] - 2)) {
                toler = c_r;
                c_r = std::abs(i_x->data[k + 1]);
                if (std::abs(i_x->data[k + 1] - i_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(toler, c_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(h_x->size[1]);
                b_i = d_fx->size[0] * d_fx->size[1];
                d_fx->size[0] = 1;
                d_fx->size[1] = h_x->size[1];
                emxEnsureCapacity_real_T(d_fx, b_i, &j_emlrtRTEI);
                if (!d_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_fx, &d_gpu_fx);
                }

                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (d_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_fx, d_fx);
                  }

                  ecu_cwt64_kernel30<<<grid, block>>>(dv4_idx_1, d_gpu_fx);
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
              b_i = dv15->size[0] * dv15->size[1];
              dv15->size[0] = 1;
              dv15->size[1] = i_x->size[1];
              emxEnsureCapacity_real_T(dv15, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv15, &gpu_dv15);
              nrefine = i_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel25<<<grid, block>>>(h_gpu_x, nrefine, gpu_dv15);
                dv15_dirtyOnGpu = true;
              }

              b_i = q_y->size[0] * q_y->size[1];
              q_y->size[0] = 1;
              q_y->size[1] = i_x->size[1];
              emxEnsureCapacity_real_T(q_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(q_y, &k_gpu_y);
              nrefine = i_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel26<<<grid, block>>>(h_gpu_x, nrefine, k_gpu_y);
              }

              b_i = dv17->size[0] * dv17->size[1];
              dv17->size[0] = 1;
              dv17->size[1] = q_y->size[1];
              emxEnsureCapacity_real_T(dv17, b_i, &m_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv17, &gpu_dv17);
              i = q_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel27<<<grid, block>>>(k_gpu_y, i, gpu_dv17);
                dv17_dirtyOnGpu = true;
              }

              nrefine = dv17->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel28<<<grid, block>>>(nrefine, gpu_dv17);
                dv17_dirtyOnGpu = true;
              }

              if (dv15->size[1] == dv17->size[1]) {
                b_i = d_fx->size[0] * d_fx->size[1];
                d_fx->size[0] = 1;
                d_fx->size[1] = dv15->size[1];
                emxEnsureCapacity_real_T(d_fx, b_i, &q_emlrtRTEI);
                if (!d_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_fx, &d_gpu_fx);
                }

                i = dv15->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (d_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_fx, d_fx);
                  }

                  ecu_cwt64_kernel29<<<grid, block>>>(d_gpu_xt, gpu_dv17,
                    gpu_dv15, i, d_gpu_fx);
                  d_fx_dirtyOnCpu = false;
                  d_fx_dirtyOnGpu = true;
                }
              } else {
                if (d_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_fx, &d_gpu_fx);
                }

                if (dv15_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv15, &gpu_dv15);
                }

                dv15_dirtyOnGpu = false;
                if (dv17_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv17, &gpu_dv17);
                }

                dv17_dirtyOnGpu = false;
                if (d_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_xt, &d_gpu_xt);
                }

                d_xt_dirtyOnGpu = false;
                binary_expand_op(d_fx, dv15, dv17, d_xt);
                d_fx_dirtyOnGpu = false;
                d_fx_dirtyOnCpu = true;
              }

              c_r = 0.0;
              lidx = -1;
              for (k = 0; k <= nsubs; k++) {
                fb = 0.0;
                r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (d_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(d_fx, &d_gpu_fx);
                  }

                  fb += dv6[nrefine] * d_fx->data[(lidx + nrefine) + 1];
                  d_fx_dirtyOnGpu = false;
                  r += dv7[nrefine] * d_fx->data[(lidx + nrefine) + 1];
                }

                lidx += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fb *= halfh;
                qsub[k] = fb;
                c_r += fb;
                errsub[k] = r * halfh;
              }

              intFsq = c_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              c_r = 2.0 * tol;
              r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fb = errsub[k];
                halfh = std::abs(fb);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= c_r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0))
                {
                  err_ok += fb;
                  q_ok += qsub[k];
                } else {
                  r += halfh;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              c_r = std::abs(err_ok) + r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(c_r)) && (!std::isnan(c_r))) && (nrefine != 0) &&
                  (!(c_r <= tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    lidx = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((lidx << 1) - 1) << 1) + 1] = subs[((lidx - 1) << 1)
                      + 1];
                    subs[((lidx << 1) - 1) << 1] = (subs[(lidx - 1) << 1] +
                      subs[((lidx - 1) << 1) + 1]) / 2.0;
                    subs[(((lidx << 1) - 2) << 1) + 1] = subs[((lidx << 1) - 1) <<
                      1];
                    subs[((lidx << 1) - 2) << 1] = subs[(lidx - 1) << 1];
                    subs_dirtyOnGpu = false;
                    subs_dirtyOnCpu = true;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&dv17);
          emxFree_real_T(&q_y);
          emxFree_real_T(&d_fx);
          emxFree_real_T(&dv15);
          emxFree_real_T(&d_xt);
          emxFree_real_T(&i_x);
          emxFree_real_T(&h_x);
        }

        c_r = std::sqrt(3.5421952306087032 * (intDsq / intFsq));
      }
      break;

     case 1:
      cf = 6.0;
      c_r = 1.4142135623730951;
      break;

     case 2:
      cf = 5.0;
      c_r = 5.847705;
      break;
    }

    halfh = static_cast<real_T>(x->size[0]) / (c_r * 2.0);
    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (wav[lidx] != cv3[lidx]) {
          exitg1 = 1;
        } else {
          lidx++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      k = 0;
    } else {
      k = -1;
    }

    if (k == 0) {
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
        c_r = 1.0 - 0.0050536085896138528 * rt_powd_snf(cf, 20.0) * std::exp
          (-rt_powd_snf(cf, 3.0));
        fb = 1.0;
        if (c_r == 0.0) {
          omegac = cf;
        } else {
          intFsq = 1.0;
          intDsq = 9.0856029641606977;
          q_ok = 0.0;
          err_ok = 0.0;
          exitg2 = false;
          while ((!exitg2) && ((fb != 0.0) && (a != omegac))) {
            if ((fb > 0.0) == (intFsq > 0.0)) {
              intDsq = a;
              intFsq = c_r;
              err_ok = omegac - a;
              q_ok = err_ok;
            }

            if (std::abs(intFsq) < std::abs(fb)) {
              a = omegac;
              omegac = intDsq;
              intDsq = a;
              c_r = fb;
              fb = intFsq;
              intFsq = c_r;
            }

            b_m = 0.5 * (intDsq - omegac);
            toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(b_m) <= toler) || (fb == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(q_ok) < toler) || (std::abs(c_r) <= std::abs(fb))) {
                err_ok = b_m;
                q_ok = b_m;
              } else {
                s = fb / c_r;
                if (a == intDsq) {
                  c_r = 2.0 * b_m * s;
                  tol = 1.0 - s;
                } else {
                  tol = c_r / intFsq;
                  b_r = fb / intFsq;
                  c_r = s * (2.0 * b_m * tol * (tol - b_r) - (omegac - a) * (b_r
                              - 1.0));
                  tol = (tol - 1.0) * (b_r - 1.0) * (s - 1.0);
                }

                if (c_r > 0.0) {
                  tol = -tol;
                } else {
                  c_r = -c_r;
                }

                if ((2.0 * c_r < 3.0 * b_m * tol - std::abs(toler * tol)) &&
                    (c_r < std::abs(0.5 * q_ok * tol))) {
                  q_ok = err_ok;
                  err_ok = c_r / tol;
                } else {
                  err_ok = b_m;
                  q_ok = b_m;
                }
              }

              a = omegac;
              c_r = fb;
              if (std::abs(err_ok) > toler) {
                omegac += err_ok;
              } else if (omegac > intDsq) {
                omegac -= toler;
              } else {
                omegac += toler;
              }

              fb = 1.0 - 0.0050536085896138528 * rt_powd_snf(omegac, 20.0) * std::
                exp(-rt_powd_snf(omegac, 3.0));
            }
          }
        }
      }
    }

    r = omegac / 3.1415926535897931;
    if (halfh < r * rt_powd_snf(2.0, 1.0 / fOctave)) {
      halfh = r * rt_powd_snf(2.0, 1.0 / fOctave);
    }

    r = 1.0 / (halfh * (6.2831853071795862 / cf)) * fs;
    if (fLims[0] < r) {
      ecu_cwt64_kernel31<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(r,
        *gpu_freqrange, *gpu_fb_FrequencyLimits);
    }

    if (fLims[1] > fs / 2.0) {
      ecu_cwt64_kernel32<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs,
        *gpu_fb_FrequencyLimits);
      ecu_cwt64_kernel33<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
        (*gpu_fb_FrequencyLimits, *gpu_freqrange);
    }

    cudaMemcpy(freqrange, *gpu_freqrange, 16UL, cudaMemcpyDeviceToHost);
    if (freqrange[1] == 0.0) {
      c_r = rtMinusInf;
    } else if (freqrange[1] < 0.0) {
      c_r = rtNaN;
    } else if ((!std::isinf(freqrange[1])) && (!std::isnan(freqrange[1]))) {
      r = std::frexp(freqrange[1], &eint);
      if (r == 0.5) {
        c_r = static_cast<real_T>(eint) - 1.0;
      } else if ((eint == 1) && (r < 0.75)) {
        c_r = std::log(2.0 * r) / 0.69314718055994529;
      } else {
        c_r = std::log(r) / 0.69314718055994529 + static_cast<real_T>(eint);
      }
    } else {
      c_r = freqrange[1];
    }

    if (freqrange[0] == 0.0) {
      r = rtMinusInf;
    } else if (freqrange[0] < 0.0) {
      r = rtNaN;
    } else if ((!std::isinf(freqrange[0])) && (!std::isnan(freqrange[0]))) {
      r = std::frexp(freqrange[0], &b_eint);
      if (r == 0.5) {
        r = static_cast<real_T>(b_eint) - 1.0;
      } else if ((b_eint == 1) && (r < 0.75)) {
        r = std::log(2.0 * r) / 0.69314718055994529;
      } else {
        r = std::log(r) / 0.69314718055994529 + static_cast<real_T>(b_eint);
      }
    } else {
      r = freqrange[0];
    }

    if (!(c_r - r >= 1.0 / fOctave)) {
      c_tmpStr = nullptr;
      f_y = nullptr;
      m = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&f_y, m);
      g_y = nullptr;
      m = emlrtCreateCharArray(2, &iv4[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 5, m, &b_formatSpec[0]);
      emlrtAssign(&g_y, m);
      j_y = nullptr;
      m = emlrtCreateDoubleScalar(1.0 / fOctave);
      emlrtAssign(&j_y, m);
      emlrtAssign(&c_tmpStr, feval(f_y, g_y, j_y, &b_emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(c_tmpStr), &c_emlrtMCI),
                       "<output of length>");
      emxInit_char_T(&d_tmpStr, 2, &sb_emlrtRTEI, true);
      emlrt_marshallIn(emlrtAlias(c_tmpStr), "tmpStr", d_tmpStr);
      emxFree_char_T(&d_tmpStr);
      emlrtDestroyArray(&c_tmpStr);
    }
  }

  first_iteration = false;
  lidx = 0;
  do {
    exitg1 = 0;
    if (lidx + 1 < 6) {
      if (cv[static_cast<int32_T>(b_b[lidx])] != cv[static_cast<int32_T>
          (cv2[lidx])]) {
        exitg1 = 1;
      } else {
        lidx++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (!first_iteration) {
    fb_CutOff = 10;
  }

  if (cv[77] == 'm') {
    lidx = 0;
  } else if (cv[77] == 'a') {
    lidx = 1;
  } else if (cv[77] == 'b') {
    lidx = 2;
  } else {
    lidx = -1;
  }

  switch (lidx) {
   case 0:
    b_r = 0.0057083835261;
    c_r = 0.0057083835261;
    r = 0.0057083835261;
    for (i = 0; i < 6; i++) {
      fb = c[i];
      b_r = b_r * 0.005353955978584176 + fb;
      c_r = c_r * 0.005353955978584176 + fb;
      r = r * 0.005353955978584176 + fb;
    }

    b_r /= 13.666666666666666;
    c_r /= 13.666666666666666;
    r /= 13.666666666666666;
    toler = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((b_r +
      0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((c_r +
      0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((r +
      0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
    if (std::isinf(toler) || std::isnan(toler)) {
      if (interval_dirtyOnCpu) {
        cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
      }

      ecu_cwt64_kernel34<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
      ecu_cwt64_kernel35<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*gpu_interval);
      interval_dirtyOnCpu = false;
      nrefine = 1;
      cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
      i = static_cast<int32_T>(interval[1]) - static_cast<int32_T>(interval[0]);
      if (i > 0) {
        n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
          - interval[0])) * 10 - 1);
        k = n_idx_0 + 1;
        if (n_idx_0 + 2 > 2) {
          lidx = n_idx_0;
          interval[n_idx_0 + 1] = interval[1];
          interval_dirtyOnCpu = true;
          r = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) + 1.0);
          for (nrefine = 0; nrefine < lidx; nrefine++) {
            interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
              (n_idx_0 - nrefine) * r;
          }
        }

        nrefine = n_idx_0 + 1;
      } else {
        k = 1;
      }

      lidx = 0;
      for (nsubs = 0; nsubs < nrefine; nsubs++) {
        if (std::abs(interval[nsubs + 1] - interval[lidx]) > 0.0) {
          lidx++;
          interval[lidx] = interval[nsubs + 1];
          interval_dirtyOnCpu = true;
        } else {
          k--;
        }
      }

      if (k + 1 < 2) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecu_cwt64_kernel36<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
          *gpu_interval);
        interval_dirtyOnCpu = false;
        k = 1;
      }

      if (i > 0) {
        nsubs = k - 1;
        b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) + 1L),
          &grid, &block, 1024U, 65535U);
        if (b_dirtyOnGpu) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          interval_dirtyOnCpu = false;
          if (subs_dirtyOnCpu) {
            cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
          }

          ecu_cwt64_kernel37<<<grid, block>>>(*gpu_interval, k - 1, *gpu_subs);
          subs_dirtyOnCpu = false;
          subs_dirtyOnGpu = true;
        }

        q_ok = 0.0;
        err_ok = 0.0;
        first_iteration = true;
        emxInit_real_T(&b_x, 2, &e_emlrtRTEI, true);
        emxInit_real_T(&c_x, 2, &tb_emlrtRTEI, true);
        emxInit_real_T(&xt, 2, &xb_emlrtRTEI, true);
        emxInit_real_T(&h_y, 2, &bc_emlrtRTEI, true);
        emxInit_real_T(&fx, 2, &sb_emlrtRTEI, true);
        emxInit_real_T(&i_y, 2, &cc_emlrtRTEI, true);
        emxInit_real_T(&b_a, 2, &k_emlrtRTEI, true);
        emxInit_real_T(&dv5, 2, &sb_emlrtRTEI, true);
        emxInit_real_T(&k_y, 2, &dc_emlrtRTEI, true);
        emxInit_real_T(&dv9, 2, &sb_emlrtRTEI, true);
        do {
          exitg1 = 0;
          b_i = b_x->size[0] * b_x->size[1];
          b_x->size[0] = 1;
          b_x->size[1] = 15 * (nsubs + 1);
          emxEnsureCapacity_real_T(b_x, b_i, &e_emlrtRTEI);
          if (!x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b_x, &gpu_x);
          }

          lidx = -1;
          for (k = 0; k <= nsubs; k++) {
            if (subs_dirtyOnGpu) {
              cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
            }

            fb = subs[k << 1];
            subs_dirtyOnGpu = false;
            r = subs[(k << 1) + 1];
            c_r = (fb + r) / 2.0;
            halfh = (r - fb) / 2.0;
            for (nrefine = 0; nrefine < 15; nrefine++) {
              b_x->data[(lidx + nrefine) + 1] = NODES[nrefine] * halfh + c_r;
              x_dirtyOnCpu = true;
            }

            lidx += 15;
          }

          b_i = c_x->size[0] * c_x->size[1];
          c_x->size[0] = 1;
          c_x->size[1] = b_x->size[1];
          emxEnsureCapacity_real_T(c_x, b_i, &f_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_x, &b_gpu_x);
          b_i = xt->size[0] * xt->size[1];
          xt->size[0] = 1;
          xt->size[1] = b_x->size[1];
          emxEnsureCapacity_real_T(xt, b_i, &g_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(xt, &gpu_xt);
          lidx = b_x->size[1] - 1;
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(lidx + 1L),
            &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, b_x);
            }

            x_dirtyOnCpu = false;
            ecu_cwt64_kernel38<<<grid, block>>>(gpu_x, lidx, gpu_xt, b_gpu_x);
            x_dirtyOnGpu = true;
            xt_dirtyOnGpu = true;
          }

          b_guard1 = false;
          if (!first_iteration) {
            if (x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_x, &b_gpu_x);
            }

            x_dirtyOnGpu = false;
            c_r = std::abs(c_x->data[0]);
            k = 0;
            exitg2 = false;
            while ((!exitg2) && (k <= c_x->size[1] - 2)) {
              toler = c_r;
              c_r = std::abs(c_x->data[k + 1]);
              if (std::abs(c_x->data[k + 1] - c_x->data[k]) <=
                  2.2204460492503131E-14 * std::fmax(toler, c_r)) {
                first_iteration = true;
                exitg2 = true;
              } else {
                k++;
              }
            }

            if (first_iteration) {
              dv4_idx_1 = static_cast<int16_T>(b_x->size[1]);
              b_i = fx->size[0] * fx->size[1];
              fx->size[0] = 1;
              fx->size[1] = b_x->size[1];
              emxEnsureCapacity_real_T(fx, b_i, &j_emlrtRTEI);
              if (!fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(fx, &gpu_fx);
              }

              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                if (fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_fx, fx);
                }

                ecu_cwt64_kernel47<<<grid, block>>>(dv4_idx_1, gpu_fx);
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
            b_i = h_y->size[0] * h_y->size[1];
            h_y->size[0] = 1;
            h_y->size[1] = c_x->size[1];
            emxEnsureCapacity_real_T(h_y, b_i, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(h_y, &gpu_y);
            nrefine = c_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine +
              1L), &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              ecu_cwt64_kernel39<<<grid, block>>>(b_gpu_x, nrefine, gpu_y);
              y_dirtyOnGpu = true;
            }

            b_i = i_y->size[0] * i_y->size[1];
            i_y->size[0] = 1;
            i_y->size[1] = c_x->size[1];
            emxEnsureCapacity_real_T(i_y, b_i, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(i_y, &d_gpu_y);
            nrefine = c_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine +
              1L), &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              ecu_cwt64_kernel40<<<grid, block>>>(b_gpu_x, nrefine, d_gpu_y);
              c_y_dirtyOnGpu = true;
            }

            if (h_y->size[1] == i_y->size[1]) {
              b_i = b_a->size[0] * b_a->size[1];
              b_a->size[0] = 1;
              b_a->size[1] = h_y->size[1];
              emxEnsureCapacity_real_T(b_a, b_i, &k_emlrtRTEI);
              if (!a_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(b_a, &gpu_a);
              }

              i = h_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                if (a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, b_a);
                }

                ecu_cwt64_kernel41<<<grid, block>>>(d_gpu_y, gpu_y, i, gpu_a);
                a_dirtyOnCpu = false;
                a_dirtyOnGpu = true;
              }
            } else {
              if (a_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_a, &gpu_a);
              }

              if (y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(h_y, &gpu_y);
              }

              y_dirtyOnGpu = false;
              if (c_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_y, &d_gpu_y);
              }

              c_y_dirtyOnGpu = false;
              c_binary_expand_op(b_a, h_y, i_y);
              a_dirtyOnGpu = false;
              a_dirtyOnCpu = true;
            }

            b_i = dv5->size[0] * dv5->size[1];
            dv5->size[0] = 1;
            dv5->size[1] = static_cast<int16_T>(b_a->size[1]);
            emxEnsureCapacity_real_T(dv5, b_i, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv5, &gpu_dv5);
            nrefine = static_cast<int16_T>(b_a->size[1]) - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine +
              1L), &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (a_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, b_a);
              }

              a_dirtyOnCpu = false;
              ecu_cwt64_kernel42<<<grid, block>>>(gpu_a, nrefine, gpu_dv5);
              dv5_dirtyOnGpu = true;
            }

            b_i = k_y->size[0] * k_y->size[1];
            k_y->size[0] = 1;
            k_y->size[1] = c_x->size[1];
            emxEnsureCapacity_real_T(k_y, b_i, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(k_y, &j_gpu_y);
            nrefine = c_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine +
              1L), &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              ecu_cwt64_kernel43<<<grid, block>>>(b_gpu_x, nrefine, j_gpu_y);
            }

            b_i = dv9->size[0] * dv9->size[1];
            dv9->size[0] = 1;
            dv9->size[1] = k_y->size[1];
            emxEnsureCapacity_real_T(dv9, b_i, &m_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv9, &gpu_dv9);
            i = k_y->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              ecu_cwt64_kernel44<<<grid, block>>>(j_gpu_y, i, gpu_dv9);
              dv9_dirtyOnGpu = true;
            }

            nrefine = dv9->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine +
              1L), &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              ecu_cwt64_kernel45<<<grid, block>>>(nrefine, gpu_dv9);
              dv9_dirtyOnGpu = true;
            }

            if (dv5->size[1] == dv9->size[1]) {
              b_i = fx->size[0] * fx->size[1];
              fx->size[0] = 1;
              fx->size[1] = dv5->size[1];
              emxEnsureCapacity_real_T(fx, b_i, &q_emlrtRTEI);
              if (!fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(fx, &gpu_fx);
              }

              k = dv5->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                if (fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_fx, fx);
                }

                ecu_cwt64_kernel46<<<grid, block>>>(gpu_xt, gpu_dv9, gpu_dv5, k,
                  gpu_fx);
                fx_dirtyOnCpu = false;
                fx_dirtyOnGpu = true;
              }
            } else {
              if (fx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(fx, &gpu_fx);
              }

              if (dv5_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(dv5, &gpu_dv5);
              }

              dv5_dirtyOnGpu = false;
              if (dv9_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(dv9, &gpu_dv9);
              }

              dv9_dirtyOnGpu = false;
              if (xt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(xt, &gpu_xt);
              }

              xt_dirtyOnGpu = false;
              binary_expand_op(fx, dv5, dv9, xt);
              fx_dirtyOnGpu = false;
              fx_dirtyOnCpu = true;
            }

            c_r = 0.0;
            lidx = -1;
            for (k = 0; k <= nsubs; k++) {
              fb = 0.0;
              r = 0.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                if (fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(fx, &gpu_fx);
                }

                fb += dv6[nrefine] * fx->data[(lidx + nrefine) + 1];
                fx_dirtyOnGpu = false;
                r += dv7[nrefine] * fx->data[(lidx + nrefine) + 1];
              }

              lidx += 15;
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
              fb *= halfh;
              qsub[k] = fb;
              c_r += fb;
              errsub[k] = r * halfh;
            }

            intDsq = c_r + q_ok;
            tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
            c_r = 2.0 * tol;
            r = 0.0;
            nrefine = 0;
            for (k = 0; k <= nsubs; k++) {
              fb = errsub[k];
              halfh = std::abs(fb);
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              if (halfh <= c_r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                err_ok += fb;
                q_ok += qsub[k];
              } else {
                r += halfh;
                nrefine++;
                subs[(nrefine - 1) << 1] = subs[k << 1];
                subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                subs_dirtyOnCpu = true;
              }
            }

            c_r = std::abs(err_ok) + r;
            if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::isinf
                  (c_r)) && (!std::isnan(c_r))) && (nrefine != 0) && (!(c_r <=
                  tol))) {
              nsubs = (nrefine << 1) - 1;
              if (nsubs + 1 > 650) {
                exitg1 = 1;
              } else {
                for (k = 0; k < nrefine; k++) {
                  lidx = nrefine - k;
                  if (subs_dirtyOnGpu) {
                    cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                  }

                  subs[(((lidx << 1) - 1) << 1) + 1] = subs[((lidx - 1) << 1) +
                    1];
                  subs[((lidx << 1) - 1) << 1] = (subs[(lidx - 1) << 1] + subs
                    [((lidx - 1) << 1) + 1]) / 2.0;
                  subs[(((lidx << 1) - 2) << 1) + 1] = subs[((lidx << 1) - 1) <<
                    1];
                  subs[((lidx << 1) - 2) << 1] = subs[(lidx - 1) << 1];
                  subs_dirtyOnGpu = false;
                  subs_dirtyOnCpu = true;
                }
              }
            } else {
              exitg1 = 1;
            }
          }
        } while (exitg1 == 0);

        emxFree_real_T(&dv9);
        emxFree_real_T(&k_y);
        emxFree_real_T(&dv5);
        emxFree_real_T(&b_a);
        emxFree_real_T(&i_y);
        emxFree_real_T(&fx);
        emxFree_real_T(&h_y);
        emxFree_real_T(&xt);
        emxFree_real_T(&c_x);
        emxFree_real_T(&b_x);
      }

      if (interval_dirtyOnCpu) {
        cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
      }

      ecu_cwt64_kernel48<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
      ecu_cwt64_kernel49<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*gpu_interval);
      interval_dirtyOnCpu = false;
      nrefine = 1;
      cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
      i = static_cast<int32_T>(interval[1]) - static_cast<int32_T>(interval[0]);
      if (i > 0) {
        n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
          - interval[0])) * 10 - 1);
        k = n_idx_0 + 1;
        if (n_idx_0 + 2 > 2) {
          lidx = n_idx_0;
          interval[n_idx_0 + 1] = interval[1];
          interval_dirtyOnCpu = true;
          r = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) + 1.0);
          for (nrefine = 0; nrefine < lidx; nrefine++) {
            interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
              (n_idx_0 - nrefine) * r;
          }
        }

        nrefine = n_idx_0 + 1;
      } else {
        k = 1;
      }

      lidx = 0;
      for (nsubs = 0; nsubs < nrefine; nsubs++) {
        if (std::abs(interval[nsubs + 1] - interval[lidx]) > 0.0) {
          lidx++;
          interval[lidx] = interval[nsubs + 1];
          interval_dirtyOnCpu = true;
        } else {
          k--;
        }
      }

      if (k + 1 < 2) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecu_cwt64_kernel50<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
          *gpu_interval);
        interval_dirtyOnCpu = false;
        k = 1;
      }

      if (i > 0) {
        nsubs = k - 1;
        b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) + 1L),
          &grid, &block, 1024U, 65535U);
        if (b_dirtyOnGpu) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          interval_dirtyOnCpu = false;
          if (subs_dirtyOnCpu) {
            cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
          }

          ecu_cwt64_kernel51<<<grid, block>>>(*gpu_interval, k - 1, *gpu_subs);
          subs_dirtyOnCpu = false;
          subs_dirtyOnGpu = true;
        }

        q_ok = 0.0;
        err_ok = 0.0;
        first_iteration = true;
        emxInit_real_T(&f_x, 2, &e_emlrtRTEI, true);
        emxInit_real_T(&g_x, 2, &tb_emlrtRTEI, true);
        emxInit_real_T(&c_xt, 2, &xb_emlrtRTEI, true);
        emxInit_real_T(&dv11, 2, &sb_emlrtRTEI, true);
        emxInit_real_T(&c_fx, 2, &sb_emlrtRTEI, true);
        emxInit_real_T(&o_y, 2, &ec_emlrtRTEI, true);
        emxInit_real_T(&dv14, 2, &sb_emlrtRTEI, true);
        do {
          exitg1 = 0;
          b_i = f_x->size[0] * f_x->size[1];
          f_x->size[0] = 1;
          f_x->size[1] = 15 * (nsubs + 1);
          emxEnsureCapacity_real_T(f_x, b_i, &e_emlrtRTEI);
          if (!c_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(f_x, &e_gpu_x);
          }

          lidx = -1;
          for (k = 0; k <= nsubs; k++) {
            if (subs_dirtyOnGpu) {
              cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
            }

            fb = subs[k << 1];
            subs_dirtyOnGpu = false;
            r = subs[(k << 1) + 1];
            c_r = (fb + r) / 2.0;
            halfh = (r - fb) / 2.0;
            for (nrefine = 0; nrefine < 15; nrefine++) {
              f_x->data[(lidx + nrefine) + 1] = NODES[nrefine] * halfh + c_r;
              c_x_dirtyOnCpu = true;
            }

            lidx += 15;
          }

          b_i = g_x->size[0] * g_x->size[1];
          g_x->size[0] = 1;
          g_x->size[1] = f_x->size[1];
          emxEnsureCapacity_real_T(g_x, b_i, &f_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(g_x, &f_gpu_x);
          b_i = c_xt->size[0] * c_xt->size[1];
          c_xt->size[0] = 1;
          c_xt->size[1] = f_x->size[1];
          emxEnsureCapacity_real_T(c_xt, b_i, &g_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_xt, &c_gpu_xt);
          lidx = f_x->size[1] - 1;
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(lidx + 1L),
            &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (c_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_x, f_x);
            }

            c_x_dirtyOnCpu = false;
            ecu_cwt64_kernel52<<<grid, block>>>(e_gpu_x, lidx, c_gpu_xt, f_gpu_x);
            c_x_dirtyOnGpu = true;
            c_xt_dirtyOnGpu = true;
          }

          b_guard1 = false;
          if (!first_iteration) {
            if (c_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_x, &f_gpu_x);
            }

            c_x_dirtyOnGpu = false;
            c_r = std::abs(g_x->data[0]);
            k = 0;
            exitg2 = false;
            while ((!exitg2) && (k <= g_x->size[1] - 2)) {
              toler = c_r;
              c_r = std::abs(g_x->data[k + 1]);
              if (std::abs(g_x->data[k + 1] - g_x->data[k]) <=
                  2.2204460492503131E-14 * std::fmax(toler, c_r)) {
                first_iteration = true;
                exitg2 = true;
              } else {
                k++;
              }
            }

            if (first_iteration) {
              dv4_idx_1 = static_cast<int16_T>(f_x->size[1]);
              b_i = c_fx->size[0] * c_fx->size[1];
              c_fx->size[0] = 1;
              c_fx->size[1] = f_x->size[1];
              emxEnsureCapacity_real_T(c_fx, b_i, &j_emlrtRTEI);
              if (!c_fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(c_fx, &c_gpu_fx);
              }

              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                if (c_fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_fx, c_fx);
                }

                ecu_cwt64_kernel58<<<grid, block>>>(dv4_idx_1, c_gpu_fx);
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
            b_i = dv11->size[0] * dv11->size[1];
            dv11->size[0] = 1;
            dv11->size[1] = g_x->size[1];
            emxEnsureCapacity_real_T(dv11, b_i, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv11, &gpu_dv11);
            nrefine = g_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine +
              1L), &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              ecu_cwt64_kernel53<<<grid, block>>>(f_gpu_x, nrefine, gpu_dv11);
              dv11_dirtyOnGpu = true;
            }

            b_i = o_y->size[0] * o_y->size[1];
            o_y->size[0] = 1;
            o_y->size[1] = g_x->size[1];
            emxEnsureCapacity_real_T(o_y, b_i, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(o_y, &h_gpu_y);
            nrefine = g_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine +
              1L), &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              ecu_cwt64_kernel54<<<grid, block>>>(f_gpu_x, nrefine, h_gpu_y);
            }

            b_i = dv14->size[0] * dv14->size[1];
            dv14->size[0] = 1;
            dv14->size[1] = o_y->size[1];
            emxEnsureCapacity_real_T(dv14, b_i, &m_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv14, &gpu_dv14);
            i = o_y->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              ecu_cwt64_kernel55<<<grid, block>>>(h_gpu_y, i, gpu_dv14);
              dv14_dirtyOnGpu = true;
            }

            nrefine = dv14->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine +
              1L), &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              ecu_cwt64_kernel56<<<grid, block>>>(nrefine, gpu_dv14);
              dv14_dirtyOnGpu = true;
            }

            if (dv11->size[1] == dv14->size[1]) {
              b_i = c_fx->size[0] * c_fx->size[1];
              c_fx->size[0] = 1;
              c_fx->size[1] = dv11->size[1];
              emxEnsureCapacity_real_T(c_fx, b_i, &q_emlrtRTEI);
              if (!c_fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(c_fx, &c_gpu_fx);
              }

              i = dv11->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                if (c_fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_fx, c_fx);
                }

                ecu_cwt64_kernel57<<<grid, block>>>(c_gpu_xt, gpu_dv14, gpu_dv11,
                  i, c_gpu_fx);
                c_fx_dirtyOnCpu = false;
                c_fx_dirtyOnGpu = true;
              }
            } else {
              if (c_fx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_fx, &c_gpu_fx);
              }

              if (dv11_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(dv11, &gpu_dv11);
              }

              dv11_dirtyOnGpu = false;
              if (dv14_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(dv14, &gpu_dv14);
              }

              dv14_dirtyOnGpu = false;
              if (c_xt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_xt, &c_gpu_xt);
              }

              c_xt_dirtyOnGpu = false;
              binary_expand_op(c_fx, dv11, dv14, c_xt);
              c_fx_dirtyOnGpu = false;
              c_fx_dirtyOnCpu = true;
            }

            c_r = 0.0;
            lidx = -1;
            for (k = 0; k <= nsubs; k++) {
              fb = 0.0;
              r = 0.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                if (c_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_fx, &c_gpu_fx);
                }

                fb += dv6[nrefine] * c_fx->data[(lidx + nrefine) + 1];
                c_fx_dirtyOnGpu = false;
                r += dv7[nrefine] * c_fx->data[(lidx + nrefine) + 1];
              }

              lidx += 15;
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
              fb *= halfh;
              qsub[k] = fb;
              c_r += fb;
              errsub[k] = r * halfh;
            }

            intFsq = c_r + q_ok;
            tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
            c_r = 2.0 * tol;
            r = 0.0;
            nrefine = 0;
            for (k = 0; k <= nsubs; k++) {
              fb = errsub[k];
              halfh = std::abs(fb);
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              if (halfh <= c_r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                err_ok += fb;
                q_ok += qsub[k];
              } else {
                r += halfh;
                nrefine++;
                subs[(nrefine - 1) << 1] = subs[k << 1];
                subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                subs_dirtyOnCpu = true;
              }
            }

            c_r = std::abs(err_ok) + r;
            if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::isinf
                  (c_r)) && (!std::isnan(c_r))) && (nrefine != 0) && (!(c_r <=
                  tol))) {
              nsubs = (nrefine << 1) - 1;
              if (nsubs + 1 > 650) {
                exitg1 = 1;
              } else {
                for (k = 0; k < nrefine; k++) {
                  lidx = nrefine - k;
                  if (subs_dirtyOnGpu) {
                    cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                  }

                  subs[(((lidx << 1) - 1) << 1) + 1] = subs[((lidx - 1) << 1) +
                    1];
                  subs[((lidx << 1) - 1) << 1] = (subs[(lidx - 1) << 1] + subs
                    [((lidx - 1) << 1) + 1]) / 2.0;
                  subs[(((lidx << 1) - 2) << 1) + 1] = subs[((lidx << 1) - 1) <<
                    1];
                  subs[((lidx << 1) - 2) << 1] = subs[(lidx - 1) << 1];
                  subs_dirtyOnGpu = false;
                  subs_dirtyOnCpu = true;
                }
              }
            } else {
              exitg1 = 1;
            }
          }
        } while (exitg1 == 0);

        emxFree_real_T(&dv14);
        emxFree_real_T(&o_y);
        emxFree_real_T(&c_fx);
        emxFree_real_T(&dv11);
        emxFree_real_T(&c_xt);
        emxFree_real_T(&g_x);
        emxFree_real_T(&f_x);
      }
    }
    break;

   case 1:
   case 2:
    break;
  }

  N = static_cast<uint32_T>(x->size[0]) + static_cast<uint32_T>(fb_SignalPad <<
    1);
  lidx = static_cast<int32_T>(std::trunc(static_cast<real_T>(N) / 2.0));
  emxInit_real_T(&omega, 2, &emlrtRTEI, true);
  if (lidx < 1) {
    omega->size[1] = 0;
  } else {
    b_i = omega->size[0] * omega->size[1];
    omega->size[0] = 1;
    omega->size[1] = lidx;
    emxEnsureCapacity_real_T(omega, b_i, &emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(omega, &gpu_omega);
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((lidx - 1) + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel59<<<grid, block>>>(lidx, gpu_omega);
      omega_dirtyOnGpu = true;
    }
  }

  b_i = omega->size[0] * omega->size[1];
  omega->size[0] = 1;
  emxEnsureCapacity_real_T(omega, b_i, &b_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(omega, &gpu_omega);
  b_i = omega->size[1];
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((b_i - 1) + 1L),
    &grid, &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ecu_cwt64_kernel60<<<grid, block>>>(N, b_i, gpu_omega);
    omega_dirtyOnGpu = true;
  }

  lidx = static_cast<int32_T>(std::trunc((static_cast<real_T>(N) - 1.0) / 2.0));
  if (lidx < 1) {
    i = 0;
    lidx = 1;
    nrefine = -1;
  } else {
    i = lidx - 1;
    lidx = -1;
    nrefine = 0;
  }

  emxInit_real_T(&d_r, 2, &c_emlrtRTEI, true);
  b_i = d_r->size[0] * d_r->size[1];
  d_r->size[0] = 1;
  d_r->size[1] = (omega->size[1] + div_s32(nrefine - i, lidx)) + 2;
  emxEnsureCapacity_real_T(d_r, b_i, &c_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(d_r, &gpu_r);
  ecu_cwt64_kernel61<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_r);
  eint = omega->size[1] - 1;
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(eint + 1L), &grid,
    &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ecu_cwt64_kernel62<<<grid, block>>>(gpu_omega, eint, gpu_r);
  }

  eint = div_s32(nrefine - i, lidx);
  b_i = omega->size[1];
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(eint + 1L), &grid,
    &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ecu_cwt64_kernel63<<<grid, block>>>(lidx, i, gpu_omega, eint, b_i, gpu_r);
  }

  b_i = omega->size[0] * omega->size[1];
  omega->size[0] = 1;
  omega->size[1] = d_r->size[1];
  emxEnsureCapacity_real_T(omega, b_i, &d_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(omega, &gpu_omega);
  k = d_r->size[1] - 1;
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
    &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ecu_cwt64_kernel64<<<grid, block>>>(gpu_r, k, gpu_omega);
    omega_dirtyOnGpu = true;
  }

  emxFree_real_T(&d_r);
  ecu_cwt64_kernel65<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
    (*gpu_fb_FrequencyLimits, *gpu_b);
  b_dirtyOnGpu = true;
  first_iteration = true;
  k = 0;
  exitg2 = false;
  while ((!exitg2) && (k <= 1)) {
    if (b_dirtyOnGpu) {
      cudaMemcpy(b, *gpu_b, 2UL, cudaMemcpyDeviceToHost);
    }

    b_dirtyOnGpu = false;
    if (!b[k]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      k++;
    }
  }

  emxInit_real_T(&fb_Scales, 2, &l_emlrtRTEI, true);
  if (!first_iteration) {
    ecu_cwt64_kernel95<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs,
      *gpu_fb_FrequencyLimits, *gpu_NyquistRange);
    b_m = 0.0;
    if (cv[77] == 'm') {
      lidx = 0;
    } else if (cv[77] == 'a') {
      lidx = 1;
    } else if (cv[77] == 'b') {
      lidx = 2;
    } else {
      lidx = -1;
    }

    switch (lidx) {
     case 0:
      b_m = 1.8820720577620569;
      b_r = 0.0057083835261;
      c_r = 0.0057083835261;
      r = 0.0057083835261;
      for (i = 0; i < 6; i++) {
        fb = c[i];
        b_r = b_r * 0.005353955978584176 + fb;
        c_r = c_r * 0.005353955978584176 + fb;
        r = r * 0.005353955978584176 + fb;
      }

      b_r /= 13.666666666666666;
      c_r /= 13.666666666666666;
      r /= 13.666666666666666;
      r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                     exp((table100[14] + 2.5377749931802178) - (((c_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                    exp((table100[13] + 5.8211893391859881) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(r) || std::isnan(r)) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecu_cwt64_kernel96<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecu_cwt64_kernel97<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        i = static_cast<int32_T>(interval[1]) - static_cast<int32_T>(interval[0]);
        if (i > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          k = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            r = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) +
              1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * r;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          k = 1;
        }

        lidx = 0;
        for (nsubs = 0; nsubs < nrefine; nsubs++) {
          if (std::abs(interval[nsubs + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[nsubs + 1];
            interval_dirtyOnCpu = true;
          } else {
            k--;
          }
        }

        if (k + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecu_cwt64_kernel98<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          k = 1;
        }

        if (i > 0) {
          nsubs = k - 1;
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) +
            1L), &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ecu_cwt64_kernel99<<<grid, block>>>(*gpu_interval, k - 1, *gpu_subs);
            subs_dirtyOnCpu = false;
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&j_x, 2, &e_emlrtRTEI, true);
          emxInit_real_T(&k_x, 2, &tb_emlrtRTEI, true);
          emxInit_real_T(&e_xt, 2, &xb_emlrtRTEI, true);
          emxInit_real_T(&u_y, 2, &bc_emlrtRTEI, true);
          emxInit_real_T(&e_fx, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&w_y, 2, &cc_emlrtRTEI, true);
          emxInit_real_T(&d_a, 2, &k_emlrtRTEI, true);
          emxInit_real_T(&dv21, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&y_y, 2, &dc_emlrtRTEI, true);
          emxInit_real_T(&dv24, 2, &sb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            b_i = j_x->size[0] * j_x->size[1];
            j_x->size[0] = 1;
            j_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(j_x, b_i, &e_emlrtRTEI);
            if (!e_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(j_x, &i_gpu_x);
            }

            lidx = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fb = subs[k << 1];
              subs_dirtyOnGpu = false;
              r = subs[(k << 1) + 1];
              c_r = (fb + r) / 2.0;
              halfh = (r - fb) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                j_x->data[(lidx + nrefine) + 1] = NODES[nrefine] * halfh + c_r;
                e_x_dirtyOnCpu = true;
              }

              lidx += 15;
            }

            b_i = k_x->size[0] * k_x->size[1];
            k_x->size[0] = 1;
            k_x->size[1] = j_x->size[1];
            emxEnsureCapacity_real_T(k_x, b_i, &f_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(k_x, &j_gpu_x);
            b_i = e_xt->size[0] * e_xt->size[1];
            e_xt->size[0] = 1;
            e_xt->size[1] = j_x->size[1];
            emxEnsureCapacity_real_T(e_xt, b_i, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(e_xt, &e_gpu_xt);
            lidx = j_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(lidx + 1L),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (e_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_x, j_x);
              }

              e_x_dirtyOnCpu = false;
              ecu_cwt64_kernel100<<<grid, block>>>(i_gpu_x, lidx, e_gpu_xt,
                j_gpu_x);
              e_x_dirtyOnGpu = true;
              e_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (e_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(k_x, &j_gpu_x);
              }

              e_x_dirtyOnGpu = false;
              c_r = std::abs(k_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= k_x->size[1] - 2)) {
                r = c_r;
                c_r = std::abs(k_x->data[k + 1]);
                if (std::abs(k_x->data[k + 1] - k_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(r, c_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(j_x->size[1]);
                b_i = e_fx->size[0] * e_fx->size[1];
                e_fx->size[0] = 1;
                e_fx->size[1] = j_x->size[1];
                emxEnsureCapacity_real_T(e_fx, b_i, &j_emlrtRTEI);
                if (!e_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(e_fx, &e_gpu_fx);
                }

                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (e_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_fx, e_fx);
                  }

                  ecu_cwt64_kernel109<<<grid, block>>>(dv4_idx_1, e_gpu_fx);
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
              b_i = u_y->size[0] * u_y->size[1];
              u_y->size[0] = 1;
              u_y->size[1] = k_x->size[1];
              emxEnsureCapacity_real_T(u_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(u_y, &m_gpu_y);
              nrefine = k_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel101<<<grid, block>>>(j_gpu_x, nrefine, m_gpu_y);
                e_y_dirtyOnGpu = true;
              }

              b_i = w_y->size[0] * w_y->size[1];
              w_y->size[0] = 1;
              w_y->size[1] = k_x->size[1];
              emxEnsureCapacity_real_T(w_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(w_y, &o_gpu_y);
              nrefine = k_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel102<<<grid, block>>>(j_gpu_x, nrefine, o_gpu_y);
                g_y_dirtyOnGpu = true;
              }

              if (u_y->size[1] == w_y->size[1]) {
                b_i = d_a->size[0] * d_a->size[1];
                d_a->size[0] = 1;
                d_a->size[1] = u_y->size[1];
                emxEnsureCapacity_real_T(d_a, b_i, &k_emlrtRTEI);
                if (!c_a_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_a, &c_gpu_a);
                }

                i = u_y->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (c_a_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_a, d_a);
                  }

                  ecu_cwt64_kernel103<<<grid, block>>>(o_gpu_y, m_gpu_y, i,
                    c_gpu_a);
                  c_a_dirtyOnCpu = false;
                  c_a_dirtyOnGpu = true;
                }
              } else {
                if (c_a_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_a, &c_gpu_a);
                }

                if (e_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(u_y, &m_gpu_y);
                }

                e_y_dirtyOnGpu = false;
                if (g_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(w_y, &o_gpu_y);
                }

                g_y_dirtyOnGpu = false;
                c_binary_expand_op(d_a, u_y, w_y);
                c_a_dirtyOnGpu = false;
                c_a_dirtyOnCpu = true;
              }

              b_i = dv21->size[0] * dv21->size[1];
              dv21->size[0] = 1;
              dv21->size[1] = static_cast<int16_T>(d_a->size[1]);
              emxEnsureCapacity_real_T(dv21, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv21, &gpu_dv21);
              nrefine = static_cast<int16_T>(d_a->size[1]) - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                if (c_a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_a, d_a);
                }

                c_a_dirtyOnCpu = false;
                ecu_cwt64_kernel104<<<grid, block>>>(c_gpu_a, nrefine, gpu_dv21);
                dv21_dirtyOnGpu = true;
              }

              b_i = y_y->size[0] * y_y->size[1];
              y_y->size[0] = 1;
              y_y->size[1] = k_x->size[1];
              emxEnsureCapacity_real_T(y_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(y_y, &s_gpu_y);
              nrefine = k_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel105<<<grid, block>>>(j_gpu_x, nrefine, s_gpu_y);
              }

              b_i = dv24->size[0] * dv24->size[1];
              dv24->size[0] = 1;
              dv24->size[1] = y_y->size[1];
              emxEnsureCapacity_real_T(dv24, b_i, &m_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv24, &gpu_dv24);
              i = y_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel106<<<grid, block>>>(s_gpu_y, i, gpu_dv24);
                dv24_dirtyOnGpu = true;
              }

              nrefine = dv24->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel107<<<grid, block>>>(nrefine, gpu_dv24);
                dv24_dirtyOnGpu = true;
              }

              if (dv21->size[1] == dv24->size[1]) {
                b_i = e_fx->size[0] * e_fx->size[1];
                e_fx->size[0] = 1;
                e_fx->size[1] = dv21->size[1];
                emxEnsureCapacity_real_T(e_fx, b_i, &q_emlrtRTEI);
                if (!e_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(e_fx, &e_gpu_fx);
                }

                k = dv21->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (e_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_fx, e_fx);
                  }

                  ecu_cwt64_kernel108<<<grid, block>>>(e_gpu_xt, gpu_dv24,
                    gpu_dv21, k, e_gpu_fx);
                  e_fx_dirtyOnCpu = false;
                  e_fx_dirtyOnGpu = true;
                }
              } else {
                if (e_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(e_fx, &e_gpu_fx);
                }

                if (dv21_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv21, &gpu_dv21);
                }

                dv21_dirtyOnGpu = false;
                if (dv24_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv24, &gpu_dv24);
                }

                dv24_dirtyOnGpu = false;
                if (e_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(e_xt, &e_gpu_xt);
                }

                e_xt_dirtyOnGpu = false;
                binary_expand_op(e_fx, dv21, dv24, e_xt);
                e_fx_dirtyOnGpu = false;
                e_fx_dirtyOnCpu = true;
              }

              c_r = 0.0;
              lidx = -1;
              for (k = 0; k <= nsubs; k++) {
                fb = 0.0;
                r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (e_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(e_fx, &e_gpu_fx);
                  }

                  fb += dv6[nrefine] * e_fx->data[(lidx + nrefine) + 1];
                  e_fx_dirtyOnGpu = false;
                  r += dv7[nrefine] * e_fx->data[(lidx + nrefine) + 1];
                }

                lidx += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fb *= halfh;
                qsub[k] = fb;
                c_r += fb;
                errsub[k] = r * halfh;
              }

              intDsq = c_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              c_r = 2.0 * tol;
              r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fb = errsub[k];
                halfh = std::abs(fb);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= c_r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0))
                {
                  err_ok += fb;
                  q_ok += qsub[k];
                } else {
                  r += halfh;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              c_r = std::abs(err_ok) + r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(c_r)) && (!std::isnan(c_r))) && (nrefine != 0) &&
                  (!(c_r <= tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    lidx = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((lidx << 1) - 1) << 1) + 1] = subs[((lidx - 1) << 1)
                      + 1];
                    subs[((lidx << 1) - 1) << 1] = (subs[(lidx - 1) << 1] +
                      subs[((lidx - 1) << 1) + 1]) / 2.0;
                    subs[(((lidx << 1) - 2) << 1) + 1] = subs[((lidx << 1) - 1) <<
                      1];
                    subs[((lidx << 1) - 2) << 1] = subs[(lidx - 1) << 1];
                    subs_dirtyOnGpu = false;
                    subs_dirtyOnCpu = true;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&dv24);
          emxFree_real_T(&y_y);
          emxFree_real_T(&dv21);
          emxFree_real_T(&d_a);
          emxFree_real_T(&w_y);
          emxFree_real_T(&e_fx);
          emxFree_real_T(&u_y);
          emxFree_real_T(&e_xt);
          emxFree_real_T(&k_x);
          emxFree_real_T(&j_x);
        }

        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecu_cwt64_kernel110<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecu_cwt64_kernel111<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        i = static_cast<int32_T>(interval[1]) - static_cast<int32_T>(interval[0]);
        if (i > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          k = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            r = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) +
              1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * r;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          k = 1;
        }

        lidx = 0;
        for (nsubs = 0; nsubs < nrefine; nsubs++) {
          if (std::abs(interval[nsubs + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[nsubs + 1];
            interval_dirtyOnCpu = true;
          } else {
            k--;
          }
        }

        if (k + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecu_cwt64_kernel112<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine, *
            gpu_interval);
          interval_dirtyOnCpu = false;
          k = 1;
        }

        if (i > 0) {
          nsubs = k - 1;
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) +
            1L), &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ecu_cwt64_kernel113<<<grid, block>>>(*gpu_interval, k - 1, *gpu_subs);
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&n_x, 2, &e_emlrtRTEI, true);
          emxInit_real_T(&o_x, 2, &tb_emlrtRTEI, true);
          emxInit_real_T(&g_xt, 2, &xb_emlrtRTEI, true);
          emxInit_real_T(&dv27, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&g_fx, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&bb_y, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&dv31, 2, &sb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            b_i = n_x->size[0] * n_x->size[1];
            n_x->size[0] = 1;
            n_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(n_x, b_i, &e_emlrtRTEI);
            if (!g_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(n_x, &m_gpu_x);
            }

            lidx = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fb = subs[k << 1];
              subs_dirtyOnGpu = false;
              r = subs[(k << 1) + 1];
              c_r = (fb + r) / 2.0;
              halfh = (r - fb) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                n_x->data[(lidx + nrefine) + 1] = NODES[nrefine] * halfh + c_r;
                g_x_dirtyOnCpu = true;
              }

              lidx += 15;
            }

            b_i = o_x->size[0] * o_x->size[1];
            o_x->size[0] = 1;
            o_x->size[1] = n_x->size[1];
            emxEnsureCapacity_real_T(o_x, b_i, &f_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(o_x, &n_gpu_x);
            b_i = g_xt->size[0] * g_xt->size[1];
            g_xt->size[0] = 1;
            g_xt->size[1] = n_x->size[1];
            emxEnsureCapacity_real_T(g_xt, b_i, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(g_xt, &g_gpu_xt);
            lidx = n_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(lidx + 1L),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (g_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_x, n_x);
              }

              g_x_dirtyOnCpu = false;
              ecu_cwt64_kernel114<<<grid, block>>>(m_gpu_x, lidx, g_gpu_xt,
                n_gpu_x);
              g_x_dirtyOnGpu = true;
              g_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (g_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(o_x, &n_gpu_x);
              }

              g_x_dirtyOnGpu = false;
              c_r = std::abs(o_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= o_x->size[1] - 2)) {
                r = c_r;
                c_r = std::abs(o_x->data[k + 1]);
                if (std::abs(o_x->data[k + 1] - o_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(r, c_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(n_x->size[1]);
                b_i = g_fx->size[0] * g_fx->size[1];
                g_fx->size[0] = 1;
                g_fx->size[1] = n_x->size[1];
                emxEnsureCapacity_real_T(g_fx, b_i, &j_emlrtRTEI);
                if (!g_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(g_fx, &g_gpu_fx);
                }

                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (g_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_fx, g_fx);
                  }

                  ecu_cwt64_kernel120<<<grid, block>>>(dv4_idx_1, g_gpu_fx);
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
              b_i = dv27->size[0] * dv27->size[1];
              dv27->size[0] = 1;
              dv27->size[1] = o_x->size[1];
              emxEnsureCapacity_real_T(dv27, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv27, &gpu_dv27);
              nrefine = o_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel115<<<grid, block>>>(n_gpu_x, nrefine, gpu_dv27);
                dv27_dirtyOnGpu = true;
              }

              b_i = bb_y->size[0] * bb_y->size[1];
              bb_y->size[0] = 1;
              bb_y->size[1] = o_x->size[1];
              emxEnsureCapacity_real_T(bb_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(bb_y, &q_gpu_y);
              nrefine = o_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel116<<<grid, block>>>(n_gpu_x, nrefine, q_gpu_y);
              }

              b_i = dv31->size[0] * dv31->size[1];
              dv31->size[0] = 1;
              dv31->size[1] = bb_y->size[1];
              emxEnsureCapacity_real_T(dv31, b_i, &m_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv31, &gpu_dv31);
              i = bb_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel117<<<grid, block>>>(q_gpu_y, i, gpu_dv31);
                dv31_dirtyOnGpu = true;
              }

              nrefine = dv31->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel118<<<grid, block>>>(nrefine, gpu_dv31);
                dv31_dirtyOnGpu = true;
              }

              if (dv27->size[1] == dv31->size[1]) {
                b_i = g_fx->size[0] * g_fx->size[1];
                g_fx->size[0] = 1;
                g_fx->size[1] = dv27->size[1];
                emxEnsureCapacity_real_T(g_fx, b_i, &q_emlrtRTEI);
                if (!g_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(g_fx, &g_gpu_fx);
                }

                k = dv27->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (g_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_fx, g_fx);
                  }

                  ecu_cwt64_kernel119<<<grid, block>>>(g_gpu_xt, gpu_dv31,
                    gpu_dv27, k, g_gpu_fx);
                  g_fx_dirtyOnCpu = false;
                  g_fx_dirtyOnGpu = true;
                }
              } else {
                if (g_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(g_fx, &g_gpu_fx);
                }

                if (dv27_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv27, &gpu_dv27);
                }

                dv27_dirtyOnGpu = false;
                if (dv31_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv31, &gpu_dv31);
                }

                dv31_dirtyOnGpu = false;
                if (g_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(g_xt, &g_gpu_xt);
                }

                g_xt_dirtyOnGpu = false;
                binary_expand_op(g_fx, dv27, dv31, g_xt);
                g_fx_dirtyOnGpu = false;
                g_fx_dirtyOnCpu = true;
              }

              c_r = 0.0;
              lidx = -1;
              for (k = 0; k <= nsubs; k++) {
                fb = 0.0;
                r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (g_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(g_fx, &g_gpu_fx);
                  }

                  fb += dv6[nrefine] * g_fx->data[(lidx + nrefine) + 1];
                  g_fx_dirtyOnGpu = false;
                  r += dv7[nrefine] * g_fx->data[(lidx + nrefine) + 1];
                }

                lidx += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fb *= halfh;
                qsub[k] = fb;
                c_r += fb;
                errsub[k] = r * halfh;
              }

              intFsq = c_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              c_r = 2.0 * tol;
              r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fb = errsub[k];
                halfh = std::abs(fb);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= c_r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0))
                {
                  err_ok += fb;
                  q_ok += qsub[k];
                } else {
                  r += halfh;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                }
              }

              c_r = std::abs(err_ok) + r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(c_r)) && (!std::isnan(c_r))) && (nrefine != 0) &&
                  (!(c_r <= tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    lidx = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((lidx << 1) - 1) << 1) + 1] = subs[((lidx - 1) << 1)
                      + 1];
                    subs[((lidx << 1) - 1) << 1] = (subs[(lidx - 1) << 1] +
                      subs[((lidx - 1) << 1) + 1]) / 2.0;
                    subs[(((lidx << 1) - 2) << 1) + 1] = subs[((lidx << 1) - 1) <<
                      1];
                    subs[((lidx << 1) - 2) << 1] = subs[(lidx - 1) << 1];
                    subs_dirtyOnGpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&dv31);
          emxFree_real_T(&bb_y);
          emxFree_real_T(&g_fx);
          emxFree_real_T(&dv27);
          emxFree_real_T(&g_xt);
          emxFree_real_T(&o_x);
          emxFree_real_T(&n_x);
        }
      }
      break;

     case 1:
      b_m = 6.0;
      break;

     case 2:
      b_m = 5.0;
      break;
    }

    cudaMemcpy(NyquistRange, *gpu_NyquistRange, 16UL, cudaMemcpyDeviceToHost);
    c_r = b_m / NyquistRange[1];
    r = b_m / NyquistRange[0] / c_r;
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

    emxInit_real_T(&p_y, 2, &qb_emlrtRTEI, true);
    r *= fOctave;
    if (std::isnan(r)) {
      b_i = p_y->size[0] * p_y->size[1];
      p_y->size[0] = 1;
      p_y->size[1] = 1;
      emxEnsureCapacity_real_T(p_y, b_i, &i_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(p_y, &b_gpu_y);
      p_y->data[0] = rtNaN;
      y_dirtyOnCpu = true;
    } else if (r < 0.0) {
      p_y->size[0] = 1;
      p_y->size[1] = 0;
    } else {
      b_i = p_y->size[0] * p_y->size[1];
      p_y->size[0] = 1;
      p_y->size[1] = static_cast<int32_T>(r) + 1;
      emxEnsureCapacity_real_T(p_y, b_i, &i_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(p_y, &b_gpu_y);
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(static_cast<
        int32_T>(r) + 1L), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ecu_cwt64_kernel121<<<grid, block>>>(r, b_gpu_y);
      }
    }

    emxInit_real_T(&r_y, 2, &rb_emlrtRTEI, true);
    b_i = r_y->size[0] * r_y->size[1];
    r_y->size[0] = 1;
    r_y->size[1] = p_y->size[1];
    emxEnsureCapacity_real_T(r_y, b_i, &h_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(r_y, &e_gpu_y);
    nrefine = p_y->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (y_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_y, p_y);
      }

      ecu_cwt64_kernel122<<<grid, block>>>(b_gpu_y, rt_powd_snf(2.0, 1.0 /
        fOctave), nrefine, e_gpu_y);
    }

    emxFree_real_T(&p_y);
    b_i = fb_Scales->size[0] * fb_Scales->size[1];
    fb_Scales->size[0] = 1;
    fb_Scales->size[1] = r_y->size[1];
    emxEnsureCapacity_real_T(fb_Scales, b_i, &l_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(fb_Scales, &gpu_fb_Scales);
    i = r_y->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel123<<<grid, block>>>(e_gpu_y, c_r, i, gpu_fb_Scales);
      fb_Scales_dirtyOnGpu = true;
    }

    emxFree_real_T(&r_y);
  } else {
    ecu_cwt64_kernel66<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*cv_gpu_clone,
      *gpu_wav, 'M', 'o', 'r', 's', 'e');
    omegac = 3.1415926535897931;
    a = 0.0;
    c_r = 0.0;
    cudaMemcpy(wav, *gpu_wav, 5UL, cudaMemcpyDeviceToHost);
    if (cv[static_cast<int32_T>(wav[0])] == 'm') {
      lidx = 0;
    } else if (cv[static_cast<int32_T>(wav[0])] == 'a') {
      lidx = 1;
    } else if (cv[static_cast<int32_T>(wav[0])] == 'b') {
      lidx = 2;
    } else {
      lidx = -1;
    }

    switch (lidx) {
     case 0:
      a = 1.8820720577620569;
      b_r = 0.0057083835261;
      c_r = 0.0057083835261;
      r = 0.0057083835261;
      for (i = 0; i < 6; i++) {
        fb = c[i];
        b_r = b_r * 0.005353955978584176 + fb;
        c_r = c_r * 0.005353955978584176 + fb;
        r = r * 0.005353955978584176 + fb;
      }

      b_r /= 13.666666666666666;
      c_r /= 13.666666666666666;
      r /= 13.666666666666666;
      c_r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((c_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(c_r) || std::isnan(c_r)) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecu_cwt64_kernel67<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecu_cwt64_kernel68<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        intDsq = 0.0;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        i = static_cast<int32_T>(interval[1]) - static_cast<int32_T>(interval[0]);
        if (i > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          k = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            r = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) +
              1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * r;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          k = 1;
        }

        lidx = 0;
        for (nsubs = 0; nsubs < nrefine; nsubs++) {
          if (std::abs(interval[nsubs + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[nsubs + 1];
            interval_dirtyOnCpu = true;
          } else {
            k--;
          }
        }

        if (k + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecu_cwt64_kernel69<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          k = 1;
        }

        if (i <= 0) {
          intDsq = rtNaN;
        } else {
          nsubs = k - 1;
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) +
            1L), &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ecu_cwt64_kernel70<<<grid, block>>>(*gpu_interval, k - 1, *gpu_subs);
            subs_dirtyOnCpu = false;
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          emxInit_real_T(&l_x, 2, &e_emlrtRTEI, true);
          emxInit_real_T(&m_x, 2, &tb_emlrtRTEI, true);
          emxInit_real_T(&f_xt, 2, &xb_emlrtRTEI, true);
          emxInit_real_T(&v_y, 2, &bc_emlrtRTEI, true);
          emxInit_real_T(&f_fx, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&x_y, 2, &cc_emlrtRTEI, true);
          emxInit_real_T(&e_a, 2, &k_emlrtRTEI, true);
          emxInit_real_T(&dv22, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&ab_y, 2, &dc_emlrtRTEI, true);
          emxInit_real_T(&dv28, 2, &sb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            b_i = l_x->size[0] * l_x->size[1];
            l_x->size[0] = 1;
            l_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(l_x, b_i, &e_emlrtRTEI);
            if (!f_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(l_x, &k_gpu_x);
            }

            lidx = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fb = subs[k << 1];
              subs_dirtyOnGpu = false;
              r = subs[(k << 1) + 1];
              c_r = (fb + r) / 2.0;
              halfh = (r - fb) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                l_x->data[(lidx + nrefine) + 1] = NODES[nrefine] * halfh + c_r;
                f_x_dirtyOnCpu = true;
              }

              lidx += 15;
            }

            b_i = m_x->size[0] * m_x->size[1];
            m_x->size[0] = 1;
            m_x->size[1] = l_x->size[1];
            emxEnsureCapacity_real_T(m_x, b_i, &f_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(m_x, &l_gpu_x);
            b_i = f_xt->size[0] * f_xt->size[1];
            f_xt->size[0] = 1;
            f_xt->size[1] = l_x->size[1];
            emxEnsureCapacity_real_T(f_xt, b_i, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(f_xt, &f_gpu_xt);
            lidx = l_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(lidx + 1L),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (f_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&k_gpu_x, l_x);
              }

              f_x_dirtyOnCpu = false;
              ecu_cwt64_kernel71<<<grid, block>>>(k_gpu_x, lidx, f_gpu_xt,
                l_gpu_x);
              f_x_dirtyOnGpu = true;
              f_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (f_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(m_x, &l_gpu_x);
              }

              f_x_dirtyOnGpu = false;
              c_r = std::abs(m_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= m_x->size[1] - 2)) {
                toler = c_r;
                c_r = std::abs(m_x->data[k + 1]);
                if (std::abs(m_x->data[k + 1] - m_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(toler, c_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(l_x->size[1]);
                b_i = f_fx->size[0] * f_fx->size[1];
                f_fx->size[0] = 1;
                f_fx->size[1] = l_x->size[1];
                emxEnsureCapacity_real_T(f_fx, b_i, &j_emlrtRTEI);
                if (!f_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(f_fx, &f_gpu_fx);
                }

                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (f_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_fx, f_fx);
                  }

                  ecu_cwt64_kernel80<<<grid, block>>>(dv4_idx_1, f_gpu_fx);
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
              b_i = v_y->size[0] * v_y->size[1];
              v_y->size[0] = 1;
              v_y->size[1] = m_x->size[1];
              emxEnsureCapacity_real_T(v_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(v_y, &n_gpu_y);
              nrefine = m_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel72<<<grid, block>>>(l_gpu_x, nrefine, n_gpu_y);
                f_y_dirtyOnGpu = true;
              }

              b_i = x_y->size[0] * x_y->size[1];
              x_y->size[0] = 1;
              x_y->size[1] = m_x->size[1];
              emxEnsureCapacity_real_T(x_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(x_y, &p_gpu_y);
              nrefine = m_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel73<<<grid, block>>>(l_gpu_x, nrefine, p_gpu_y);
                h_y_dirtyOnGpu = true;
              }

              if (v_y->size[1] == x_y->size[1]) {
                b_i = e_a->size[0] * e_a->size[1];
                e_a->size[0] = 1;
                e_a->size[1] = v_y->size[1];
                emxEnsureCapacity_real_T(e_a, b_i, &k_emlrtRTEI);
                if (!d_a_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(e_a, &d_gpu_a);
                }

                i = v_y->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (d_a_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, e_a);
                  }

                  ecu_cwt64_kernel74<<<grid, block>>>(p_gpu_y, n_gpu_y, i,
                    d_gpu_a);
                  d_a_dirtyOnCpu = false;
                  d_a_dirtyOnGpu = true;
                }
              } else {
                if (d_a_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(e_a, &d_gpu_a);
                }

                if (f_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(v_y, &n_gpu_y);
                }

                f_y_dirtyOnGpu = false;
                if (h_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(x_y, &p_gpu_y);
                }

                h_y_dirtyOnGpu = false;
                c_binary_expand_op(e_a, v_y, x_y);
                d_a_dirtyOnGpu = false;
                d_a_dirtyOnCpu = true;
              }

              b_i = dv22->size[0] * dv22->size[1];
              dv22->size[0] = 1;
              dv22->size[1] = static_cast<int16_T>(e_a->size[1]);
              emxEnsureCapacity_real_T(dv22, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv22, &gpu_dv22);
              nrefine = static_cast<int16_T>(e_a->size[1]) - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                if (d_a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, e_a);
                }

                d_a_dirtyOnCpu = false;
                ecu_cwt64_kernel75<<<grid, block>>>(d_gpu_a, nrefine, gpu_dv22);
                dv22_dirtyOnGpu = true;
              }

              b_i = ab_y->size[0] * ab_y->size[1];
              ab_y->size[0] = 1;
              ab_y->size[1] = m_x->size[1];
              emxEnsureCapacity_real_T(ab_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(ab_y, &t_gpu_y);
              nrefine = m_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel76<<<grid, block>>>(l_gpu_x, nrefine, t_gpu_y);
              }

              b_i = dv28->size[0] * dv28->size[1];
              dv28->size[0] = 1;
              dv28->size[1] = ab_y->size[1];
              emxEnsureCapacity_real_T(dv28, b_i, &m_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv28, &gpu_dv28);
              i = ab_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel77<<<grid, block>>>(t_gpu_y, i, gpu_dv28);
                dv28_dirtyOnGpu = true;
              }

              nrefine = dv28->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel78<<<grid, block>>>(nrefine, gpu_dv28);
                dv28_dirtyOnGpu = true;
              }

              if (dv22->size[1] == dv28->size[1]) {
                b_i = f_fx->size[0] * f_fx->size[1];
                f_fx->size[0] = 1;
                f_fx->size[1] = dv22->size[1];
                emxEnsureCapacity_real_T(f_fx, b_i, &q_emlrtRTEI);
                if (!f_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(f_fx, &f_gpu_fx);
                }

                k = dv22->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (f_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_fx, f_fx);
                  }

                  ecu_cwt64_kernel79<<<grid, block>>>(f_gpu_xt, gpu_dv28,
                    gpu_dv22, k, f_gpu_fx);
                  f_fx_dirtyOnCpu = false;
                  f_fx_dirtyOnGpu = true;
                }
              } else {
                if (f_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(f_fx, &f_gpu_fx);
                }

                if (dv22_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv22, &gpu_dv22);
                }

                dv22_dirtyOnGpu = false;
                if (dv28_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv28, &gpu_dv28);
                }

                dv28_dirtyOnGpu = false;
                if (f_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(f_xt, &f_gpu_xt);
                }

                f_xt_dirtyOnGpu = false;
                binary_expand_op(f_fx, dv22, dv28, f_xt);
                f_fx_dirtyOnGpu = false;
                f_fx_dirtyOnCpu = true;
              }

              c_r = 0.0;
              lidx = -1;
              for (k = 0; k <= nsubs; k++) {
                fb = 0.0;
                r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (f_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(f_fx, &f_gpu_fx);
                  }

                  fb += dv6[nrefine] * f_fx->data[(lidx + nrefine) + 1];
                  f_fx_dirtyOnGpu = false;
                  r += dv7[nrefine] * f_fx->data[(lidx + nrefine) + 1];
                }

                lidx += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fb *= halfh;
                qsub[k] = fb;
                c_r += fb;
                errsub[k] = r * halfh;
              }

              intDsq = c_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              c_r = 2.0 * tol;
              r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fb = errsub[k];
                halfh = std::abs(fb);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= c_r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0))
                {
                  err_ok += fb;
                  q_ok += qsub[k];
                } else {
                  r += halfh;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              c_r = std::abs(err_ok) + r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(c_r)) && (!std::isnan(c_r))) && (nrefine != 0) &&
                  (!(c_r <= tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    lidx = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((lidx << 1) - 1) << 1) + 1] = subs[((lidx - 1) << 1)
                      + 1];
                    subs[((lidx << 1) - 1) << 1] = (subs[(lidx - 1) << 1] +
                      subs[((lidx - 1) << 1) + 1]) / 2.0;
                    subs[(((lidx << 1) - 2) << 1) + 1] = subs[((lidx << 1) - 1) <<
                      1];
                    subs[((lidx << 1) - 2) << 1] = subs[(lidx - 1) << 1];
                    subs_dirtyOnGpu = false;
                    subs_dirtyOnCpu = true;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&dv28);
          emxFree_real_T(&ab_y);
          emxFree_real_T(&dv22);
          emxFree_real_T(&e_a);
          emxFree_real_T(&x_y);
          emxFree_real_T(&f_fx);
          emxFree_real_T(&v_y);
          emxFree_real_T(&f_xt);
          emxFree_real_T(&m_x);
          emxFree_real_T(&l_x);
        }

        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecu_cwt64_kernel81<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecu_cwt64_kernel82<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        intFsq = 0.0;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        i = static_cast<int32_T>(interval[1]) - static_cast<int32_T>(interval[0]);
        if (i > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          k = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            r = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) +
              1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * r;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          k = 1;
        }

        lidx = 0;
        for (nsubs = 0; nsubs < nrefine; nsubs++) {
          if (std::abs(interval[nsubs + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[nsubs + 1];
            interval_dirtyOnCpu = true;
          } else {
            k--;
          }
        }

        if (k + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecu_cwt64_kernel83<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          k = 1;
        }

        if (i <= 0) {
          intFsq = rtNaN;
        } else {
          nsubs = k - 1;
          b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) +
            1L), &grid, &block, 1024U, 65535U);
          if (b_dirtyOnGpu) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ecu_cwt64_kernel84<<<grid, block>>>(*gpu_interval, k - 1, *gpu_subs);
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&p_x, 2, &e_emlrtRTEI, true);
          emxInit_real_T(&q_x, 2, &tb_emlrtRTEI, true);
          emxInit_real_T(&h_xt, 2, &xb_emlrtRTEI, true);
          emxInit_real_T(&dv30, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&h_fx, 2, &sb_emlrtRTEI, true);
          emxInit_real_T(&cb_y, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&dv32, 2, &sb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            b_i = p_x->size[0] * p_x->size[1];
            p_x->size[0] = 1;
            p_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(p_x, b_i, &e_emlrtRTEI);
            if (!h_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(p_x, &o_gpu_x);
            }

            lidx = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fb = subs[k << 1];
              subs_dirtyOnGpu = false;
              r = subs[(k << 1) + 1];
              c_r = (fb + r) / 2.0;
              halfh = (r - fb) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                p_x->data[(lidx + nrefine) + 1] = NODES[nrefine] * halfh + c_r;
                h_x_dirtyOnCpu = true;
              }

              lidx += 15;
            }

            b_i = q_x->size[0] * q_x->size[1];
            q_x->size[0] = 1;
            q_x->size[1] = p_x->size[1];
            emxEnsureCapacity_real_T(q_x, b_i, &f_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(q_x, &p_gpu_x);
            b_i = h_xt->size[0] * h_xt->size[1];
            h_xt->size[0] = 1;
            h_xt->size[1] = p_x->size[1];
            emxEnsureCapacity_real_T(h_xt, b_i, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(h_xt, &h_gpu_xt);
            lidx = p_x->size[1] - 1;
            b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(lidx + 1L),
              &grid, &block, 1024U, 65535U);
            if (b_dirtyOnGpu) {
              if (h_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&o_gpu_x, p_x);
              }

              h_x_dirtyOnCpu = false;
              ecu_cwt64_kernel85<<<grid, block>>>(o_gpu_x, lidx, h_gpu_xt,
                p_gpu_x);
              h_x_dirtyOnGpu = true;
              h_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (h_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(q_x, &p_gpu_x);
              }

              h_x_dirtyOnGpu = false;
              c_r = std::abs(q_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= q_x->size[1] - 2)) {
                toler = c_r;
                c_r = std::abs(q_x->data[k + 1]);
                if (std::abs(q_x->data[k + 1] - q_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(toler, c_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(p_x->size[1]);
                b_i = h_fx->size[0] * h_fx->size[1];
                h_fx->size[0] = 1;
                h_fx->size[1] = p_x->size[1];
                emxEnsureCapacity_real_T(h_fx, b_i, &j_emlrtRTEI);
                if (!h_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(h_fx, &h_gpu_fx);
                }

                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (h_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_fx, h_fx);
                  }

                  ecu_cwt64_kernel91<<<grid, block>>>(dv4_idx_1, h_gpu_fx);
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
              b_i = dv30->size[0] * dv30->size[1];
              dv30->size[0] = 1;
              dv30->size[1] = q_x->size[1];
              emxEnsureCapacity_real_T(dv30, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv30, &gpu_dv30);
              nrefine = q_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel86<<<grid, block>>>(p_gpu_x, nrefine, gpu_dv30);
                dv30_dirtyOnGpu = true;
              }

              b_i = cb_y->size[0] * cb_y->size[1];
              cb_y->size[0] = 1;
              cb_y->size[1] = q_x->size[1];
              emxEnsureCapacity_real_T(cb_y, b_i, &h_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cb_y, &r_gpu_y);
              nrefine = q_x->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel87<<<grid, block>>>(p_gpu_x, nrefine, r_gpu_y);
              }

              b_i = dv32->size[0] * dv32->size[1];
              dv32->size[0] = 1;
              dv32->size[1] = cb_y->size[1];
              emxEnsureCapacity_real_T(dv32, b_i, &m_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv32, &gpu_dv32);
              i = cb_y->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
                &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel88<<<grid, block>>>(r_gpu_y, i, gpu_dv32);
                dv32_dirtyOnGpu = true;
              }

              nrefine = dv32->size[1] - 1;
              b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine
                + 1L), &grid, &block, 1024U, 65535U);
              if (b_dirtyOnGpu) {
                ecu_cwt64_kernel89<<<grid, block>>>(nrefine, gpu_dv32);
                dv32_dirtyOnGpu = true;
              }

              if (dv30->size[1] == dv32->size[1]) {
                b_i = h_fx->size[0] * h_fx->size[1];
                h_fx->size[0] = 1;
                h_fx->size[1] = dv30->size[1];
                emxEnsureCapacity_real_T(h_fx, b_i, &q_emlrtRTEI);
                if (!h_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(h_fx, &h_gpu_fx);
                }

                k = dv30->size[1] - 1;
                b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k +
                  1L), &grid, &block, 1024U, 65535U);
                if (b_dirtyOnGpu) {
                  if (h_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_fx, h_fx);
                  }

                  ecu_cwt64_kernel90<<<grid, block>>>(h_gpu_xt, gpu_dv32,
                    gpu_dv30, k, h_gpu_fx);
                  h_fx_dirtyOnCpu = false;
                  h_fx_dirtyOnGpu = true;
                }
              } else {
                if (h_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(h_fx, &h_gpu_fx);
                }

                if (dv30_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv30, &gpu_dv30);
                }

                dv30_dirtyOnGpu = false;
                if (dv32_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv32, &gpu_dv32);
                }

                dv32_dirtyOnGpu = false;
                if (h_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(h_xt, &h_gpu_xt);
                }

                h_xt_dirtyOnGpu = false;
                binary_expand_op(h_fx, dv30, dv32, h_xt);
                h_fx_dirtyOnGpu = false;
                h_fx_dirtyOnCpu = true;
              }

              c_r = 0.0;
              lidx = -1;
              for (k = 0; k <= nsubs; k++) {
                fb = 0.0;
                r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (h_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(h_fx, &h_gpu_fx);
                  }

                  fb += dv6[nrefine] * h_fx->data[(lidx + nrefine) + 1];
                  h_fx_dirtyOnGpu = false;
                  r += dv7[nrefine] * h_fx->data[(lidx + nrefine) + 1];
                }

                lidx += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fb *= halfh;
                qsub[k] = fb;
                c_r += fb;
                errsub[k] = r * halfh;
              }

              intFsq = c_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              c_r = 2.0 * tol;
              r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fb = errsub[k];
                halfh = std::abs(fb);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= c_r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0))
                {
                  err_ok += fb;
                  q_ok += qsub[k];
                } else {
                  r += halfh;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                }
              }

              c_r = std::abs(err_ok) + r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(c_r)) && (!std::isnan(c_r))) && (nrefine != 0) &&
                  (!(c_r <= tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    lidx = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((lidx << 1) - 1) << 1) + 1] = subs[((lidx - 1) << 1)
                      + 1];
                    subs[((lidx << 1) - 1) << 1] = (subs[(lidx - 1) << 1] +
                      subs[((lidx - 1) << 1) + 1]) / 2.0;
                    subs[(((lidx << 1) - 2) << 1) + 1] = subs[((lidx << 1) - 1) <<
                      1];
                    subs[((lidx << 1) - 2) << 1] = subs[(lidx - 1) << 1];
                    subs_dirtyOnGpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&dv32);
          emxFree_real_T(&cb_y);
          emxFree_real_T(&h_fx);
          emxFree_real_T(&dv30);
          emxFree_real_T(&h_xt);
          emxFree_real_T(&q_x);
          emxFree_real_T(&p_x);
        }

        c_r = std::sqrt(3.5421952306087032 * (intDsq / intFsq));
      }
      break;

     case 1:
      a = 6.0;
      c_r = 1.4142135623730951;
      break;

     case 2:
      a = 5.0;
      c_r = 5.847705;
      break;
    }

    halfh = static_cast<real_T>(x->size[0]) / (c_r * 2.0);
    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (wav[lidx] != cv3[lidx]) {
          exitg1 = 1;
        } else {
          lidx++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      k = 0;
    } else {
      k = -1;
    }

    if (k == 0) {
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
        c_r = r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
          (-rt_powd_snf(a, 3.0));
        fb = r;
        if (c_r == 0.0) {
          omegac = a;
        } else {
          intFsq = r;
          intDsq = 9.0856029641606977;
          q_ok = 0.0;
          err_ok = 0.0;
          exitg2 = false;
          while ((!exitg2) && ((fb != 0.0) && (a != omegac))) {
            if ((fb > 0.0) == (intFsq > 0.0)) {
              intDsq = a;
              intFsq = c_r;
              err_ok = omegac - a;
              q_ok = err_ok;
            }

            if (std::abs(intFsq) < std::abs(fb)) {
              a = omegac;
              omegac = intDsq;
              intDsq = a;
              c_r = fb;
              fb = intFsq;
              intFsq = c_r;
            }

            b_m = 0.5 * (intDsq - omegac);
            toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(b_m) <= toler) || (fb == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(q_ok) < toler) || (std::abs(c_r) <= std::abs(fb))) {
                err_ok = b_m;
                q_ok = b_m;
              } else {
                s = fb / c_r;
                if (a == intDsq) {
                  c_r = 2.0 * b_m * s;
                  tol = 1.0 - s;
                } else {
                  tol = c_r / intFsq;
                  b_r = fb / intFsq;
                  c_r = s * (2.0 * b_m * tol * (tol - b_r) - (omegac - a) * (b_r
                              - 1.0));
                  tol = (tol - 1.0) * (b_r - 1.0) * (s - 1.0);
                }

                if (c_r > 0.0) {
                  tol = -tol;
                } else {
                  c_r = -c_r;
                }

                if ((2.0 * c_r < 3.0 * b_m * tol - std::abs(toler * tol)) &&
                    (c_r < std::abs(0.5 * q_ok * tol))) {
                  q_ok = err_ok;
                  err_ok = c_r / tol;
                } else {
                  err_ok = b_m;
                  q_ok = b_m;
                }
              }

              a = omegac;
              c_r = fb;
              if (std::abs(err_ok) > toler) {
                omegac += err_ok;
              } else if (omegac > intDsq) {
                omegac -= toler;
              } else {
                omegac += toler;
              }

              fb = r - 0.0050536085896138528 * rt_powd_snf(omegac, 20.0) * std::
                exp(-rt_powd_snf(omegac, 3.0));
            }
          }
        }
      }
    }

    c_r = omegac / 3.1415926535897931;
    if (halfh < c_r * rt_powd_snf(2.0, 1.0 / fOctave)) {
      halfh = c_r * rt_powd_snf(2.0, 1.0 / fOctave);
    }

    r = halfh / c_r;
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

    emxInit_real_T(&s_y, 2, &wb_emlrtRTEI, true);
    r = std::fmax(r, 1.0 / fOctave) * fOctave;
    if (std::isnan(r)) {
      b_i = s_y->size[0] * s_y->size[1];
      s_y->size[0] = 1;
      s_y->size[1] = 1;
      emxEnsureCapacity_real_T(s_y, b_i, &i_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(s_y, &g_gpu_y);
      s_y->data[0] = rtNaN;
      b_y_dirtyOnCpu = true;
    } else if (r < 0.0) {
      s_y->size[0] = 1;
      s_y->size[1] = 0;
    } else {
      b_i = s_y->size[0] * s_y->size[1];
      s_y->size[0] = 1;
      s_y->size[1] = static_cast<int32_T>(r) + 1;
      emxEnsureCapacity_real_T(s_y, b_i, &i_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(s_y, &g_gpu_y);
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(static_cast<
        int32_T>(r) + 1L), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ecu_cwt64_kernel92<<<grid, block>>>(r, g_gpu_y);
      }
    }

    emxInit_real_T(&t_y, 2, &ac_emlrtRTEI, true);
    b_i = t_y->size[0] * t_y->size[1];
    t_y->size[0] = 1;
    t_y->size[1] = s_y->size[1];
    emxEnsureCapacity_real_T(t_y, b_i, &h_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(t_y, &i_gpu_y);
    nrefine = s_y->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (b_y_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_y, s_y);
      }

      ecu_cwt64_kernel93<<<grid, block>>>(g_gpu_y, rt_powd_snf(2.0, 1.0 /
        fOctave), nrefine, i_gpu_y);
    }

    emxFree_real_T(&s_y);
    b_i = fb_Scales->size[0] * fb_Scales->size[1];
    fb_Scales->size[0] = 1;
    fb_Scales->size[1] = t_y->size[1];
    emxEnsureCapacity_real_T(fb_Scales, b_i, &l_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(fb_Scales, &gpu_fb_Scales);
    i = t_y->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel94<<<grid, block>>>(i_gpu_y, c_r, i, gpu_fb_Scales);
      fb_Scales_dirtyOnGpu = true;
    }

    emxFree_real_T(&t_y);
  }

  first_iteration = false;
  lidx = 0;
  do {
    exitg1 = 0;
    if (lidx + 1 < 6) {
      if (cv[static_cast<int32_T>(b_b[lidx])] != cv[static_cast<int32_T>
          (cv2[lidx])]) {
        exitg1 = 1;
      } else {
        lidx++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  emxInit_real_T(&psidft, 2, &sb_emlrtRTEI, true);
  emxInit_real_T(&f, 2, &ub_emlrtRTEI, true);
  if (first_iteration) {
    emxInit_real_T(&somega, 2, &vb_emlrtRTEI, true);
    if (fb_Scales->size[1] == 1) {
      b_i = somega->size[0] * somega->size[1];
      somega->size[0] = 1;
      if (omega->size[1] == 1) {
        somega->size[1] = 1;
      } else {
        somega->size[1] = omega->size[1];
      }

      emxEnsureCapacity_real_T(somega, b_i, &p_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(somega, &gpu_somega);
      nsubs = (omega->size[1] != 1);
      lidx = somega->size[1] - 1;
      for (k = 0; k <= lidx; k++) {
        if (fb_Scales_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(fb_Scales, &gpu_fb_Scales);
        }

        fb_Scales_dirtyOnGpu = false;
        if (omega_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(omega, &gpu_omega);
        }

        omega_dirtyOnGpu = false;
        somega->data[k] = fb_Scales->data[0] * omega->data[nsubs * k];
        somega_dirtyOnCpu = true;
      }
    } else {
      b_i = somega->size[0] * somega->size[1];
      somega->size[0] = fb_Scales->size[1];
      somega->size[1] = omega->size[1];
      emxEnsureCapacity_real_T(somega, b_i, &o_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(somega, &gpu_somega);
      eint = omega->size[1] - 1;
      k = fb_Scales->size[1] - 1;
      i = somega->size[0];
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k + 1L) *
        (eint + 1L)), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ecu_cwt64_kernel126<<<grid, block>>>(gpu_omega, gpu_fb_Scales, k, eint,
          i, gpu_somega);
        somega_dirtyOnGpu = true;
      }
    }

    nrefine = somega->size[0] * somega->size[1] - 1;
    for (k = 0; k < 2; k++) {
      xSize[k] = static_cast<uint32_T>(somega->size[k]);
      xSize_dirtyOnCpu = true;
    }

    emxInit_real_T(&absomega, 2, &yb_emlrtRTEI, true);
    b_i = absomega->size[0] * absomega->size[1];
    absomega->size[0] = static_cast<int32_T>(xSize[0]);
    absomega->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(absomega, b_i, &t_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(absomega, &gpu_absomega);
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (somega_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, somega);
      }

      somega_dirtyOnCpu = false;
      ecu_cwt64_kernel127<<<grid, block>>>(gpu_somega, nrefine, gpu_absomega);
      absomega_dirtyOnGpu = true;
    }

    emxInit_real_T(&powscales, 2, &u_emlrtRTEI, true);
    b_i = powscales->size[0] * powscales->size[1];
    powscales->size[0] = absomega->size[0];
    powscales->size[1] = absomega->size[1];
    emxEnsureCapacity_real_T(powscales, b_i, &u_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(powscales, &gpu_powscales);
    k = absomega->size[0] * absomega->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel128<<<grid, block>>>(gpu_absomega, k, gpu_powscales);
      powscales_dirtyOnGpu = true;
    }

    nrefine = absomega->size[0] * absomega->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel129<<<grid, block>>>(nrefine, gpu_absomega);
      absomega_dirtyOnGpu = true;
    }

    emxInit_real_T(&r_x, 2, &w_emlrtRTEI, true);
    if ((absomega->size[0] == powscales->size[0]) && (absomega->size[1] ==
         powscales->size[1])) {
      b_i = r_x->size[0] * r_x->size[1];
      r_x->size[0] = absomega->size[0];
      r_x->size[1] = absomega->size[1];
      emxEnsureCapacity_real_T(r_x, b_i, &w_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(r_x, &q_gpu_x);
      k = absomega->size[0] * absomega->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
        &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ecu_cwt64_kernel130<<<grid, block>>>(gpu_powscales, gpu_absomega, k,
          q_gpu_x);
        i_x_dirtyOnGpu = true;
      }
    } else {
      if (absomega_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(absomega, &gpu_absomega);
      }

      if (powscales_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(powscales, &gpu_powscales);
      }

      b_binary_expand_op(r_x, absomega, powscales);
      i_x_dirtyOnCpu = true;
    }

    emxFree_real_T(&powscales);
    emxFree_real_T(&absomega);
    nrefine = r_x->size[0] * r_x->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (i_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&q_gpu_x, r_x);
      }

      ecu_cwt64_kernel131<<<grid, block>>>(nrefine, q_gpu_x);
      i_x_dirtyOnCpu = false;
      i_x_dirtyOnGpu = true;
    }

    if ((r_x->size[0] == somega->size[0]) && (r_x->size[1] == somega->size[1]))
    {
      b_i = psidft->size[0] * psidft->size[1];
      psidft->size[0] = r_x->size[0];
      psidft->size[1] = r_x->size[1];
      emxEnsureCapacity_real_T(psidft, b_i, &y_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(psidft, &gpu_psidft);
      k = r_x->size[0] * r_x->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
        &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (somega_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, somega);
        }

        if (i_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&q_gpu_x, r_x);
        }

        ecu_cwt64_kernel132<<<grid, block>>>(gpu_somega, q_gpu_x, k, gpu_psidft);
      }
    } else {
      if (i_x_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(r_x, &q_gpu_x);
      }

      if (somega_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(somega, &gpu_somega);
      }

      binary_expand_op(psidft, r_x, somega);
      psidft_dirtyOnCpu = true;
    }

    emxFree_real_T(&r_x);
    emxFree_real_T(&somega);
    b_i = f->size[0] * f->size[1];
    f->size[0] = 1;
    f->size[1] = fb_Scales->size[1];
    emxEnsureCapacity_real_T(f, b_i, &bb_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(f, &gpu_f);
    k = fb_Scales->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel133<<<grid, block>>>(gpu_fb_Scales, k, gpu_f);
    }
  } else {
    b_i = psidft->size[0] * psidft->size[1];
    psidft->size[0] = fb_Scales->size[1];
    psidft->size[1] = omega->size[1];
    emxEnsureCapacity_real_T(psidft, b_i, &n_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(psidft, &gpu_psidft);
    k = fb_Scales->size[1] * omega->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel124<<<grid, block>>>(k, gpu_psidft);
    }

    b_i = f->size[0] * f->size[1];
    f->size[0] = 1;
    f->size[1] = fb_Scales->size[1];
    emxEnsureCapacity_real_T(f, b_i, &r_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(f, &gpu_f);
    k = fb_Scales->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel125<<<grid, block>>>(gpu_fb_Scales, k, gpu_f);
    }
  }

  emxFree_real_T(&omega);
  emxFree_real_T(&fb_Scales);
  b_i = f->size[0] * f->size[1];
  f->size[0] = 1;
  emxEnsureCapacity_real_T(f, b_i, &s_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(f, &gpu_f);
  b_i = f->size[1];
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((b_i - 1) + 1L),
    &grid, &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ecu_cwt64_kernel134<<<grid, block>>>(fs, b_i, gpu_f);
  }

  // 'ecu_cwt64:25' freqs = fb.centerFrequencies';
  lidx = f->size[1];
  b_i = freqs->size[0] * freqs->size[1];
  freqs->size[0] = 1;
  freqs->size[1] = f->size[1];
  emxEnsureCapacity_real_T(freqs, b_i, &v_emlrtRTEI);
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((lidx - 1) + 1L),
    &grid, &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    gpuEmxMemcpyCpuToGpu_real_T(&gpu_freqs, freqs);
    ecu_cwt64_kernel135<<<grid, block>>>(gpu_f, lidx, gpu_freqs);
    freqs_dirtyOnGpu = true;
  }

  // 'ecu_cwt64:26' nFreqs = numel(freqs);
  //  Do CWT (L1-normed & variance-normed)
  // 'ecu_cwt64:29' xx = coder.nullcopy(zeros([nFrames nChs nFreqs],'like',x));
  b_i = xx->size[0] * xx->size[1] * xx->size[2];
  xx->size[0] = x->size[0];
  xx->size[1] = x->size[1];
  xx->size[2] = f->size[1];
  emxEnsureCapacity_real_T(xx, b_i, &x_emlrtRTEI);

  //  Preallocate output
  // 'ecu_cwt64:30' ii = 1:nFrames;
  emxInit_uint32_T(&ii, 2, &ab_emlrtRTEI, true);
  if (x->size[0] < 1) {
    ii->size[0] = 1;
    ii->size[1] = 0;
  } else {
    N = static_cast<uint32_T>(x->size[0]);
    b_i = ii->size[0] * ii->size[1];
    ii->size[0] = 1;
    ii->size[1] = x->size[0];
    emxEnsureCapacity_uint32_T(ii, b_i, &ab_emlrtRTEI);
    gpuEmxEnsureCapacity_uint32_T(ii, &gpu_ii);
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
      ((static_cast<int32_T>(N) - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel136<<<grid, block>>>(N, gpu_ii);
    }
  }

  // 'ecu_cwt64:31' is = 1:nFreqs;
  emxInit_uint32_T(&is, 2, &cb_emlrtRTEI, true);
  if (f->size[1] < 1) {
    is->size[0] = 1;
    is->size[1] = 0;
  } else {
    N = static_cast<uint32_T>(f->size[1]);
    b_i = is->size[0] * is->size[1];
    is->size[0] = 1;
    is->size[1] = f->size[1];
    emxEnsureCapacity_uint32_T(is, b_i, &cb_emlrtRTEI);
    gpuEmxEnsureCapacity_uint32_T(is, &gpu_is);
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>
      ((static_cast<int32_T>(N) - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel137<<<grid, block>>>(N, gpu_is);
    }
  }

  emxFree_real_T(&f);

  // 'ecu_cwt64:33' for ch = 1:nChs
  b_eint = x->size[1];
  emxInit_creal_T(&cfs, 2, &mb_emlrtRTEI, true);
  if (x->size[1] - 1 >= 0) {
    csz_idx_0 = psidft->size[0];
  }

  emxInit_int32_T(&iv8, 1, &sb_emlrtRTEI, true);
  emxInit_int32_T(&iv10, 1, &sb_emlrtRTEI, true);
  emxInit_real_T(&s_x, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&xv, 2, &gb_emlrtRTEI, true);
  emxInit_creal_T(&xposdft, 2, &hb_emlrtRTEI, true);
  emxInit_real_T(&t_x, 2, &jb_emlrtRTEI, true);
  emxInit_creal_T(&cfsposdft, 2, &fc_emlrtRTEI, true);
  emxInit_creal_T(&cfspos, 2, &lb_emlrtRTEI, true);
  emxInit_real_T(&db_y, 2, &gc_emlrtRTEI, true);
  emxInit_real_T(&eb_y, 2, &gc_emlrtRTEI, true);
  emxInit_real_T(&dv23, 3, &sb_emlrtRTEI, true);
  for (int32_T ch{0}; ch < b_eint; ch++) {
    // 'ecu_cwt64:34' xx(ii,ch,is) = permute(abs(wt(fb,x(ii,ch))).^2, [2 3 1]);
    b_i = iv8->size[0];
    iv8->size[0] = ii->size[1];
    emxEnsureCapacity_int32_T(iv8, b_i, &db_emlrtRTEI);
    gpuEmxEnsureCapacity_int32_T(iv8, &gpu_iv8);
    k = ii->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel138<<<grid, block>>>(gpu_ii, k, gpu_iv8);
    }

    b_i = iv10->size[0];
    iv10->size[0] = is->size[1];
    emxEnsureCapacity_int32_T(iv10, b_i, &eb_emlrtRTEI);
    gpuEmxEnsureCapacity_int32_T(iv10, &gpu_iv10);
    k = is->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel139<<<grid, block>>>(gpu_is, k, gpu_iv10);
    }

    b_i = s_x->size[0];
    s_x->size[0] = ii->size[1];
    emxEnsureCapacity_real_T(s_x, b_i, &fb_emlrtRTEI);
    if (!k_x_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real_T(s_x, &s_gpu_x);
    }

    k = ii->size[1] - 1;
    i = x->size[0];
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (j_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&r_gpu_x, x);
      }

      j_x_dirtyOnCpu = false;
      if (k_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&s_gpu_x, s_x);
      }

      ecu_cwt64_kernel140<<<grid, block>>>(ch, r_gpu_x, gpu_ii, k, i, s_gpu_x);
      k_x_dirtyOnCpu = false;
      j_x_dirtyOnGpu = true;
    }

    b_i = xv->size[0] * xv->size[1];
    xv->size[0] = 1;
    xv->size[1] = s_x->size[0];
    emxEnsureCapacity_real_T(xv, b_i, &gb_emlrtRTEI);
    if (!xv_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real_T(xv, &gpu_xv);
    }

    k = s_x->size[0] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (k_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&s_gpu_x, s_x);
      }

      k_x_dirtyOnCpu = false;
      if (xv_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, xv);
      }

      ecu_cwt64_kernel141<<<grid, block>>>(s_gpu_x, k, gpu_xv);
      xv_dirtyOnCpu = false;
      xv_dirtyOnGpu = true;
    }

    if (fb_SignalPad > 0) {
      nsubs = ii->size[1] - fb_SignalPad;
      if (nsubs + 1 > ii->size[1]) {
        i = 0;
        k = 1;
        nsubs = -1;
      } else {
        i = ii->size[1] - 1;
        k = -1;
      }

      b_i = t_x->size[0] * t_x->size[1];
      t_x->size[0] = 1;
      t_x->size[1] = fb_SignalPad;
      emxEnsureCapacity_real_T(t_x, b_i, &jb_emlrtRTEI);
      if (!l_x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(t_x, &t_gpu_x);
      }

      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((fb_SignalPad -
        1) + 1L), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (k_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&s_gpu_x, s_x);
        }

        k_x_dirtyOnCpu = false;
        if (l_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&t_gpu_x, t_x);
        }

        ecu_cwt64_kernel142<<<grid, block>>>(s_gpu_x, fb_SignalPad, t_gpu_x);
        l_x_dirtyOnCpu = false;
        k_x_dirtyOnGpu = true;
      }

      lidx = fb_SignalPad >> 1;
      for (eint = 0; eint < lidx; eint++) {
        nrefine = (fb_SignalPad - eint) - 1;
        if (k_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(t_x, &t_gpu_x);
        }

        r = t_x->data[eint];
        t_x->data[eint] = t_x->data[nrefine];
        t_x->data[nrefine] = r;
        k_x_dirtyOnGpu = false;
        l_x_dirtyOnCpu = true;
      }

      b_i = xv->size[0] * xv->size[1];
      xv->size[0] = 1;
      xv->size[1] = ((s_x->size[0] + t_x->size[1]) + div_s32(nsubs - i, k)) + 1;
      emxEnsureCapacity_real_T(xv, b_i, &kb_emlrtRTEI);
      if (!xv_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(xv, &gpu_xv);
      }

      eint = t_x->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(eint + 1L),
        &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (l_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&t_gpu_x, t_x);
        }

        l_x_dirtyOnCpu = false;
        if (xv_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, xv);
        }

        ecu_cwt64_kernel143<<<grid, block>>>(t_gpu_x, eint, gpu_xv);
        xv_dirtyOnCpu = false;
        xv_dirtyOnGpu = true;
      }

      eint = s_x->size[0];
      for (b_i = 0; b_i < eint; b_i++) {
        if (xv_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(xv, &gpu_xv);
        }

        if (j_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(s_x, &s_gpu_x);
        }

        j_x_dirtyOnGpu = false;
        xv->data[b_i + t_x->size[1]] = s_x->data[b_i];
        k_x_dirtyOnGpu = false;
        l_x_dirtyOnCpu = true;
        xv_dirtyOnGpu = false;
        xv_dirtyOnCpu = true;
      }

      eint = div_s32(nsubs - i, k);
      for (b_i = 0; b_i <= eint; b_i++) {
        if (xv_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(xv, &gpu_xv);
        }

        if (j_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(s_x, &s_gpu_x);
        }

        xv->data[(b_i + s_x->size[0]) + t_x->size[1]] = s_x->data[i + k * b_i];
        k_x_dirtyOnGpu = false;
        l_x_dirtyOnCpu = true;
        j_x_dirtyOnGpu = false;
        k_x_dirtyOnCpu = true;
        xv_dirtyOnGpu = false;
        xv_dirtyOnCpu = true;
      }
    }

    if (xv->size[1] - (static_cast<int32_T>(static_cast<uint32_T>(xv->size[1]) >>
          1) << 1) == 1) {
      cufftHandle fftPlanHandle;
      b_i = xposdft->size[0] * xposdft->size[1];
      xposdft->size[0] = 1;
      xposdft->size[1] = xv->size[1];
      emxEnsureCapacity_creal_T(xposdft, b_i, &hb_emlrtRTEI);
      if (!xposdft_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal_T(xposdft, &gpu_xposdft);
      }

      k = xv->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
        &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (xv_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, xv);
        }

        xv_dirtyOnCpu = false;
        if (xposdft_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_xposdft, xposdft);
        }

        ecu_cwt64_kernel144<<<grid, block>>>(gpu_xv, k, gpu_xposdft);
        xposdft_dirtyOnCpu = false;
      }

      lidx = xposdft->size[1];
      fftPlanHandle = acquireCUFFTPlan(1, &lidx, &lidx, 1, 1, CUFFT_Z2Z, 1);
      if (xposdft_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_xposdft, xposdft);
      }

      cufftExecZ2Z(fftPlanHandle, (cufftDoubleComplex *)&gpu_xposdft.data[0],
                   (cufftDoubleComplex *)&gpu_xposdft.data[0], CUFFT_FORWARD);
      xposdft_dirtyOnCpu = false;
    } else {
      cufftHandle b_fftPlanHandle;
      lidx = xv->size[1];
      for (k = 0; k < 2; k++) {
        xSize[k] = static_cast<uint32_T>(xv->size[k]);
        xSize_dirtyOnCpu = true;
      }

      b_i = xposdft->size[0] * xposdft->size[1];
      xposdft->size[0] = 1;
      xposdft->size[1] = static_cast<int32_T>(xSize[1]);
      emxEnsureCapacity_creal_T(xposdft, b_i, &ib_emlrtRTEI);
      if (!xposdft_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal_T(xposdft, &gpu_xposdft);
      }

      b_fftPlanHandle = acquireCUFFTPlan(1, &lidx, &lidx, 1, 1, CUFFT_D2Z, 1);
      if (xv_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, xv);
      }

      xv_dirtyOnCpu = false;
      if (xposdft_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_xposdft, xposdft);
      }

      cufftExecD2Z(b_fftPlanHandle, (cufftDoubleReal *)&gpu_xv.data[0],
                   (cufftDoubleComplex *)&gpu_xposdft.data[0]);
      xposdft_dirtyOnCpu = false;
      b_dirtyOnGpu = true;
      lidx = static_cast<int32_T>(static_cast<real_T>(static_cast<int32_T>
        (xSize[1]) + 1) / 2.0);
      for (i = 0; i <= lidx - 2; i++) {
        if (b_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_creal_T(xposdft, &gpu_xposdft);
        }

        xposdft->data[(static_cast<int32_T>(xSize[1]) - i) - 1].re =
          xposdft->data[i + 1].re;
        xposdft->data[(static_cast<int32_T>(xSize[1]) - i) - 1].im =
          -xposdft->data[i + 1].im;
        b_dirtyOnGpu = false;
        xposdft_dirtyOnCpu = true;
      }
    }

    b_i = cfsposdft->size[0] * cfsposdft->size[1];
    cfsposdft->size[0] = csz_idx_0;
    lidx = psidft->size[1];
    nrefine = xposdft->size[1];
    if (lidx <= nrefine) {
      nrefine = lidx;
    }

    if (psidft->size[1] == 1) {
      cfsposdft->size[1] = xposdft->size[1];
    } else if (xposdft->size[1] == 1) {
      cfsposdft->size[1] = psidft->size[1];
    } else if (xposdft->size[1] == psidft->size[1]) {
      cfsposdft->size[1] = xposdft->size[1];
    } else {
      cfsposdft->size[1] = nrefine;
    }

    emxEnsureCapacity_creal_T(cfsposdft, b_i, &p_emlrtRTEI);
    gpuEmxEnsureCapacity_creal_T(cfsposdft, &gpu_cfsposdft);
    if ((cfsposdft->size[0] != 0) && (cfsposdft->size[1] != 0)) {
      nrefine = (xposdft->size[1] != 1);
      nsubs = (psidft->size[1] != 1);
      lidx = cfsposdft->size[1];
      k = cfsposdft->size[0] - 1;
      i = cfsposdft->size[0];
      b_i = psidft->size[0];
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k + 1L) *
        ((lidx - 1) + 1L)), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (xposdft_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_xposdft, xposdft);
        }

        xposdft_dirtyOnCpu = false;
        if (psidft_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_psidft, psidft);
        }

        psidft_dirtyOnCpu = false;
        ecu_cwt64_kernel145<<<grid, block>>>(gpu_xposdft, gpu_psidft, nsubs,
          nrefine, k, lidx, b_i, i, gpu_cfsposdft);
      }
    }

    if ((cfsposdft->size[0] == 0) || (cfsposdft->size[1] == 0)) {
      for (k = 0; k < 2; k++) {
        xSize[k] = static_cast<uint32_T>(cfsposdft->size[k]);
        xSize_dirtyOnCpu = true;
      }

      k = cfsposdft->size[1];
      if (xSize_dirtyOnCpu) {
        cudaMemcpy(*gpu_xSize, xSize, 8UL, cudaMemcpyHostToDevice);
      }

      ecu_cwt64_kernel148<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(k, *gpu_xSize);
      xSize_dirtyOnCpu = false;
      b_i = cfspos->size[0] * cfspos->size[1];
      cudaMemcpy(xSize, *gpu_xSize, 8UL, cudaMemcpyDeviceToHost);
      cfspos->size[0] = static_cast<int32_T>(xSize[0]);
      cfspos->size[1] = cfsposdft->size[1];
      emxEnsureCapacity_creal_T(cfspos, b_i, &lb_emlrtRTEI);
      gpuEmxEnsureCapacity_creal_T(cfspos, &gpu_cfspos);
      k = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
        &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ecu_cwt64_kernel149<<<grid, block>>>(k, gpu_cfspos);
      }
    } else {
      cufftHandle c_fftPlanHandle;
      lidx = cfsposdft->size[1];
      c_fftPlanHandle = acquireCUFFTPlan(1, &lidx, &lidx, cfsposdft->size[0], 1,
        CUFFT_Z2Z, cfsposdft->size[0]);
      cufftExecZ2Z(c_fftPlanHandle, (cufftDoubleComplex *)&gpu_cfsposdft.data[0],
                   (cufftDoubleComplex *)&gpu_cfsposdft.data[0], CUFFT_INVERSE);
      b_i = cfspos->size[0] * cfspos->size[1];
      cfspos->size[0] = cfsposdft->size[0];
      cfspos->size[1] = cfsposdft->size[1];
      emxEnsureCapacity_creal_T(cfspos, b_i, &lb_emlrtRTEI);
      gpuEmxEnsureCapacity_creal_T(cfspos, &gpu_cfspos);
      k = cfsposdft->size[1];
      ecu_cwt64_kernel146<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(k,
        b_gpu_cfsposdft);
      k = cfsposdft->size[0] * cfsposdft->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
        &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ecu_cwt64_kernel147<<<grid, block>>>(b_gpu_cfsposdft, gpu_cfsposdft, k,
          gpu_cfspos);
      }
    }

    b_i = cfs->size[0] * cfs->size[1];
    cfs->size[0] = cfspos->size[0];
    cfs->size[1] = cfspos->size[1];
    emxEnsureCapacity_creal_T(cfs, b_i, &mb_emlrtRTEI);
    gpuEmxEnsureCapacity_creal_T(cfs, &gpu_cfs);
    k = cfspos->size[0] * cfspos->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L), &grid,
      &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel150<<<grid, block>>>(gpu_cfspos, k, gpu_cfs);
    }

    if (fb_SignalPad > 0) {
      N = static_cast<uint32_T>(x->size[0]) + static_cast<uint32_T>(fb_SignalPad);
      b_i = cfs->size[0] * cfs->size[1];
      cfs->size[0] = cfspos->size[0];
      cfs->size[1] = static_cast<int32_T>(N) - fb_SignalPad;
      emxEnsureCapacity_creal_T(cfs, b_i, &nb_emlrtRTEI);
      gpuEmxEnsureCapacity_creal_T(cfs, &gpu_cfs);
      k = cfspos->size[0] - 1;
      i = cfs->size[0];
      b_i = cfspos->size[0];
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((k + 1L) * (((
        static_cast<int32_T>(N) - fb_SignalPad) - 1) + 1L)), &grid, &block,
        1024U, 65535U);
      if (b_dirtyOnGpu) {
        ecu_cwt64_kernel151<<<grid, block>>>(gpu_cfspos, k, static_cast<uint32_T>
          (fb_SignalPad) + 1U, N, i, b_i, gpu_cfs);
      }
    }

    nrefine = cfs->size[0] * cfs->size[1] - 1;
    for (k = 0; k < 2; k++) {
      xSize[k] = static_cast<uint32_T>(cfs->size[k]);
      xSize_dirtyOnCpu = true;
    }

    b_i = db_y->size[0] * db_y->size[1];
    db_y->size[0] = static_cast<int32_T>(xSize[0]);
    db_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(db_y, b_i, &t_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(db_y, &u_gpu_y);
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel152<<<grid, block>>>(gpu_cfs, nrefine, u_gpu_y);
    }

    for (k = 0; k < 2; k++) {
      xSize[k] = static_cast<uint32_T>(db_y->size[k]);
      xSize_dirtyOnCpu = true;
    }

    b_i = eb_y->size[0] * eb_y->size[1];
    eb_y->size[0] = static_cast<int32_T>(xSize[0]);
    eb_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(eb_y, b_i, &h_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(eb_y, &v_gpu_y);
    nrefine = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) -
      1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ecu_cwt64_kernel153<<<grid, block>>>(u_gpu_y, nrefine, v_gpu_y);
    }

    first_iteration = true;
    if ((eb_y->size[0] != 0) && (eb_y->size[1] != 0)) {
      lidx = 0;
      k = 0;
      exitg2 = false;
      while ((!exitg2) && (k + 1 < 4)) {
        if (dv25[k] <= 2) {
          nrefine = eb_y->size[dv25[k] - 1];
        } else {
          nrefine = 1;
        }

        if (nrefine != 1) {
          if (lidx > dv25[k]) {
            first_iteration = false;
            exitg2 = true;
          } else {
            lidx = dv25[k];
            k++;
          }
        } else {
          k++;
        }
      }
    }

    if (first_iteration) {
      b_i = dv23->size[0] * dv23->size[1] * dv23->size[2];
      dv23->size[0] = eb_y->size[1];
      dv23->size[1] = 1;
      dv23->size[2] = eb_y->size[0];
      emxEnsureCapacity_real_T(dv23, b_i, &pb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(dv23, &gpu_dv23);
      i = eb_y->size[0] * eb_y->size[1] - 1;
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L), &grid,
        &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ecu_cwt64_kernel155<<<grid, block>>>(v_gpu_y, i, gpu_dv23);
      }
    } else {
      b_i = dv23->size[0] * dv23->size[1] * dv23->size[2];
      dv23->size[0] = eb_y->size[1];
      dv23->size[1] = 1;
      dv23->size[2] = eb_y->size[0];
      emxEnsureCapacity_real_T(dv23, b_i, &ob_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(dv23, &gpu_dv23);
      lidx = eb_y->size[1] - 1;
      i = eb_y->size[0] - 1;
      c_eint = dv23->size[0];
      k = eb_y->size[0];
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L) *
        (lidx + 1L)), &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ecu_cwt64_kernel154<<<grid, block>>>(v_gpu_y, i, lidx, c_eint, k,
          gpu_dv23);
      }
    }

    k = dv23->size[2] - 1;
    i = dv23->size[0] - 1;
    b_i = xx->size[0];
    lidx = xx->size[1];
    c_eint = dv23->size[0];
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L) * (k +
      1L)), &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (xx_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
      }

      ecu_cwt64_kernel156<<<grid, block>>>(gpu_dv23, gpu_iv10, ch, gpu_iv8, i, k,
        b_i, lidx, c_eint, gpu_xx);
      xx_dirtyOnCpu = false;
      xx_dirtyOnGpu = true;
    }
  }

  emxFree_real_T(&dv23);
  emxFree_real_T(&eb_y);
  emxFree_real_T(&db_y);
  emxFree_creal_T(&cfspos);
  emxFree_creal_T(&cfsposdft);
  emxFree_real_T(&t_x);
  emxFree_creal_T(&xposdft);
  emxFree_real_T(&xv);
  emxFree_real_T(&s_x);
  emxFree_creal_T(&cfs);
  emxFree_int32_T(&iv10);
  emxFree_int32_T(&iv8);
  emxFree_uint32_T(&is);
  emxFree_uint32_T(&ii);
  emxFree_real_T(&psidft);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (xx_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(xx, &gpu_xx);
  }

  if (freqs_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(freqs, &gpu_freqs);
  }

  mwCudaFree(&(*gpu_fb_FrequencyLimits)[0]);
  mwCudaFree(&(*gpu_b)[0]);
  mwCudaFree(&(*gpu_freqrange)[0]);
  mwCudaFree(&(*gpu_NyquistRange)[0]);
  mwCudaFree(&(*gpu_wav)[0]);
  mwCudaFree(&(*gpu_interval)[0]);
  gpuEmxFree_real_T(&gpu_omega);
  gpuEmxFree_real_T(&gpu_r);
  mwCudaFree(&(*gpu_subs)[0]);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_xt);
  gpuEmxFree_real_T(&b_gpu_x);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_real_T(&b_gpu_xt);
  gpuEmxFree_real_T(&d_gpu_x);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_real_T(&e_gpu_x);
  gpuEmxFree_real_T(&c_gpu_xt);
  gpuEmxFree_real_T(&f_gpu_x);
  gpuEmxFree_real_T(&gpu_fx);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&d_gpu_y);
  gpuEmxFree_real_T(&g_gpu_x);
  gpuEmxFree_real_T(&d_gpu_xt);
  gpuEmxFree_real_T(&h_gpu_x);
  gpuEmxFree_real_T(&e_gpu_y);
  gpuEmxFree_real_T(&gpu_dv11);
  gpuEmxFree_real_T(&b_gpu_fx);
  gpuEmxFree_real_T(&f_gpu_y);
  gpuEmxFree_real_T(&gpu_a);
  gpuEmxFree_real_T(&c_gpu_fx);
  gpuEmxFree_real_T(&gpu_dv5);
  gpuEmxFree_real_T(&g_gpu_y);
  gpuEmxFree_real_T(&h_gpu_y);
  gpuEmxFree_real_T(&gpu_fb_Scales);
  gpuEmxFree_real_T(&gpu_dv15);
  gpuEmxFree_real_T(&b_gpu_a);
  gpuEmxFree_real_T(&i_gpu_y);
  gpuEmxFree_real_T(&gpu_dv8);
  gpuEmxFree_real_T(&j_gpu_y);
  gpuEmxFree_real_T(&d_gpu_fx);
  gpuEmxFree_real_T(&gpu_dv14);
  gpuEmxFree_real_T(&k_gpu_y);
  gpuEmxFree_real_T(&l_gpu_y);
  gpuEmxFree_real_T(&gpu_dv9);
  gpuEmxFree_real_T(&gpu_dv17);
  gpuEmxFree_real_T(&gpu_psidft);
  gpuEmxFree_real_T(&gpu_dv12);
  gpuEmxFree_real_T(&gpu_somega);
  gpuEmxFree_real_T(&gpu_f);
  gpuEmxFree_real_T(&i_gpu_x);
  gpuEmxFree_real_T(&e_gpu_xt);
  gpuEmxFree_real_T(&j_gpu_x);
  gpuEmxFree_real_T(&k_gpu_x);
  gpuEmxFree_real_T(&f_gpu_xt);
  gpuEmxFree_real_T(&l_gpu_x);
  gpuEmxFree_real_T(&gpu_absomega);
  gpuEmxFree_real_T(&gpu_powscales);
  gpuEmxFree_real_T(&m_gpu_y);
  gpuEmxFree_real_T(&n_gpu_y);
  gpuEmxFree_real_T(&m_gpu_x);
  gpuEmxFree_real_T(&g_gpu_xt);
  gpuEmxFree_real_T(&n_gpu_x);
  gpuEmxFree_real_T(&gpu_freqs);
  gpuEmxFree_real_T(&o_gpu_x);
  gpuEmxFree_real_T(&h_gpu_xt);
  gpuEmxFree_real_T(&p_gpu_x);
  gpuEmxFree_real_T(&e_gpu_fx);
  gpuEmxFree_real_T(&f_gpu_fx);
  gpuEmxFree_real_T(&o_gpu_y);
  gpuEmxFree_real_T(&p_gpu_y);
  gpuEmxFree_real_T(&gpu_dv27);
  gpuEmxFree_real_T(&q_gpu_x);
  gpuEmxFree_real_T(&gpu_dv30);
  gpuEmxFree_real_T(&c_gpu_a);
  gpuEmxFree_real_T(&d_gpu_a);
  gpuEmxFree_real_T(&g_gpu_fx);
  gpuEmxFree_real_T(&gpu_dv21);
  gpuEmxFree_real_T(&gpu_dv22);
  gpuEmxFree_real_T(&q_gpu_y);
  gpuEmxFree_real_T(&h_gpu_fx);
  gpuEmxFree_uint32_T(&gpu_ii);
  gpuEmxFree_real_T(&r_gpu_y);
  gpuEmxFree_real_T(&s_gpu_y);
  gpuEmxFree_real_T(&t_gpu_y);
  gpuEmxFree_real_T(&gpu_dv31);
  gpuEmxFree_uint32_T(&gpu_is);
  gpuEmxFree_real_T(&gpu_dv32);
  gpuEmxFree_real_T(&gpu_dv24);
  gpuEmxFree_real_T(&gpu_dv28);
  gpuEmxFree_int32_T(&gpu_iv8);
  gpuEmxFree_int32_T(&gpu_iv10);
  gpuEmxFree_real_T(&r_gpu_x);
  gpuEmxFree_real_T(&s_gpu_x);
  gpuEmxFree_real_T(&gpu_xv);
  gpuEmxFree_creal_T(&gpu_xposdft);
  gpuEmxFree_real_T(&t_gpu_x);
  gpuEmxFree_creal_T(&gpu_cfsposdft);
  mwCudaFree(&(*gpu_xSize)[0]);
  mwCudaFree(b_gpu_cfsposdft);
  gpuEmxFree_creal_T(&gpu_cfspos);
  gpuEmxFree_creal_T(&gpu_cfs);
  gpuEmxFree_real_T(&u_gpu_y);
  gpuEmxFree_real_T(&v_gpu_y);
  gpuEmxFree_real_T(&gpu_dv23);
  gpuEmxFree_real_T(&gpu_xx);
}

void ecu_cwt64_api(const mxArray * const prhs[4], int32_T nlhs, const mxArray
                   *plhs[2])
{
  emxArray_real_T *freqs;
  emxArray_real_T *x;
  emxArray_real_T *xx;
  const mxArray *prhs_copy_idx_2;
  real_T (*fLims)[2];
  real_T fOctave;
  real_T fs;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_2 = emlrtProtectR2012b(prhs[2], 2, false, -1);

  // Marshall function inputs
  emxInit_real_T(&x, 2, &hc_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  fs = emlrt_marshallIn(emlrtAliasP(prhs[1]), "fs");
  fLims = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_2), "fLims");
  fOctave = emlrt_marshallIn(emlrtAliasP(prhs[3]), "fOctave");

  // Invoke the target function
  emxInit_real_T(&xx, 3, &hc_emlrtRTEI, true);
  emxInit_real_T(&freqs, 2, &hc_emlrtRTEI, true);
  ecu_cwt64(x, fs, *fLims, fOctave, xx, freqs);
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

void ecu_cwt64_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  mwCudaFree(&(*cv_gpu_clone)[0]);
}

void ecu_cwt64_initialize()
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
    ecu_cwt64_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ecu_cwt64_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode), (char_T *)
                       cudaGetErrorString(errCode), (char_T *)cudaGetErrorName
                       (errCode), (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }

  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  mwMemoryManagerTerminate();
}

// End of code generation (ecu_cwt64.cu)
