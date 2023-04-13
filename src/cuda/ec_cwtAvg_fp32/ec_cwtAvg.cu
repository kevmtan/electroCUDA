//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_cwtAvg.cu
//
// Code generation for function 'ec_cwtAvg'
//

// Include files
#include "ec_cwtAvg.h"
#include "_coder_ec_cwtAvg_mex.h"
#include "ec_cwtAvg_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
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

struct emxArray_creal32_T
{
  creal32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct emxArray_uint32_T
{
  uint32_T *data;
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
  "ec_cwtAvg",                         // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 1075284325U, 2201364878U, 3488609979U, 1269018621U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtRTEInfo emlrtRTEI{ 1,      // lineNo
  1,                                   // colNo
  "_coder_ec_cwtAvg_api",              // fName
  ""                                   // pName
};

static emlrtRTEInfo b_emlrtRTEI{ 95,   // lineNo
  22,                                  // colNo
  "sprintf",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 986,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 987,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 988,  // lineNo
  21,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 988,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 273,  // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 445,  // lineNo
  20,                                  // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 446,  // lineNo
  21,                                  // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 28,   // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 27,   // lineNo
  1,                                   // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 486,  // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 18,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 60,   // lineNo
  20,                                  // colNo
  "bsxfun",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/bsxfun.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 63,   // lineNo
  17,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 43,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 946,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 30,   // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 29,   // lineNo
  1,                                   // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 25,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
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

static emlrtRTEInfo ab_emlrtRTEI{ 498, // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 31,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 230, // lineNo
  1,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 33,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 102, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 135, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 143, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "cuFFTNDCallback",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/cuFFTNDCallback.p"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 138, // lineNo
  19,                                  // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 138, // lineNo
  6,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 161, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 180, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 22,  // lineNo
  32,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 12,  // lineNo
  5,                                   // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 211, // lineNo
  24,                                  // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 28,  // lineNo
  47,                                  // colNo
  "numCpsi",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/numCpsi.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 96,  // lineNo
  5,                                   // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 28,  // lineNo
  36,                                  // colNo
  "numCpsi",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/numCpsi.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 28,  // lineNo
  23,                                  // colNo
  "numCpsi",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/numCpsi.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 301, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 95,  // lineNo
  1,                                   // colNo
  "sprintf",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 1256,// lineNo
  30,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 1256,// lineNo
  25,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 1,   // lineNo
  22,                                  // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 924, // lineNo
  26,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 32,  // lineNo
  18,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 21,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 32,  // lineNo
  13,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 287, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 445, // lineNo
  1,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 446, // lineNo
  1,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 63,  // lineNo
  20,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 63,  // lineNo
  34,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 151, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 63,  // lineNo
  16,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 63,  // lineNo
  60,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 64,  // lineNo
  12,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 64,  // lineNo
  31,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 12,  // lineNo
  12,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 12,  // lineNo
  1,                                   // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 26,  // lineNo
  43,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 26,  // lineNo
  37,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 28,  // lineNo
  46,                                  // colNo
  "numCpsi",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/numCpsi.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 293, // lineNo
  14,                                  // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 293, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 28,  // lineNo
  19,                                  // colNo
  "numCpsi",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/numCpsi.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 295, // lineNo
  9,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static char_T (*cpu_cv_gpu_clone)[128];
static boolean_T gpuConstsCopied_ec_cwtAvg;

// Function Declarations
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4);
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real32_T *ret);
static real_T (*b_emlrt_marshallIn(const mxArray *fLims, const char_T
  *identifier))[2];
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2];
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void c_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static real_T (*d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2];
static int32_T div_s32(int32_T numerator, int32_T denominator);
static __global__ void ec_cwtAvg_kernel1(const real_T fLims[2], boolean_T b[2]);
static __global__ void ec_cwtAvg_kernel10(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel100(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T x);
static __global__ void ec_cwtAvg_kernel101(const emxArray_real_T x, int32_T b_x,
  emxArray_real_T c_x);
static __global__ void ec_cwtAvg_kernel102(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel103(const emxArray_real_T xt, const
  emxArray_real_T x, const emxArray_real_T y, int32_T b_y, emxArray_real_T fx);
static __global__ void ec_cwtAvg_kernel104(int16_T dv2_idx_1, emxArray_real_T fx);
static __global__ void ec_cwtAvg_kernel105(const emxArray_creal32_T cfspos,
  int32_T vstride, emxArray_real32_T y);
static __global__ void ec_cwtAvg_kernel106(const emxArray_real32_T y, int32_T
  vstride, emxArray_real32_T abscfssq);
static __global__ void ec_cwtAvg_kernel107(const emxArray_real32_T abscfssq,
  int32_T b_abscfssq, emxArray_real32_T a);
static __global__ void ec_cwtAvg_kernel108(const emxArray_real32_T Scales, const
  emxArray_real32_T a, const int32_T acoef, const int32_T abscfssq, int32_T
  nbytes, emxArray_real32_T b_abscfssq, int32_T a_dim0, int32_T Scales_dim1,
  int32_T abscfssq_dim0);
static __global__ void ec_cwtAvg_kernel109(uint32_T N, emxArray_uint32_T y);
static __global__ void ec_cwtAvg_kernel11(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel110(int32_T abscfssq, emxArray_real32_T z);
static __global__ void ec_cwtAvg_kernel111(const emxArray_uint32_T y,
  emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel112(const emxArray_uint32_T y, int32_T
  nbytes, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel113(const emxArray_uint32_T y,
  emxArray_real_T c, int32_T abscfssq_dim1);
static __global__ void ec_cwtAvg_kernel114(const emxArray_uint32_T y, int32_T
  nbytes, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel115(const real_T r, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel116(const real_T r, emxArray_real_T c,
  int32_T abscfssq_dim1);
static __global__ void ec_cwtAvg_kernel117(int32_T nbytes, emxArray_real32_T z);
static __global__ void ec_cwtAvg_kernel118(const emxArray_real32_T Scales,
  emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel119(const emxArray_real32_T Scales,
  int32_T nbytes, emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel12(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel120(const emxArray_real32_T Scales,
  emxArray_real32_T c, int32_T z_dim0);
static __global__ void ec_cwtAvg_kernel121(const emxArray_real32_T Scales,
  int32_T nbytes, emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel122(const real32_T xbar,
  emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel123(const real32_T xbar,
  emxArray_real32_T c, int32_T z_dim0);
static __global__ void ec_cwtAvg_kernel124(const real32_T xbar, int32_T j,
  emxArray_creal32_T cfspos);
static __global__ void ec_cwtAvg_kernel125(const emxArray_creal32_T cfspos,
  int32_T vstride, emxArray_real32_T y);
static __global__ void ec_cwtAvg_kernel126(const emxArray_real32_T y, int32_T
  vstride, emxArray_real32_T abswt2);
static __global__ void ec_cwtAvg_kernel127(const emxArray_real32_T Scales, const
  emxArray_real32_T abswt2, const int32_T acoef, const int32_T abswt2S, int32_T
  nbytes, emxArray_real32_T b_abswt2S, int32_T abswt2_dim0, int32_T Scales_dim1,
  int32_T abswt2S_dim0);
static __global__ void ec_cwtAvg_kernel128(int32_T abswt2S, emxArray_real32_T
  savgpTMP);
static __global__ void ec_cwtAvg_kernel129(const emxArray_real32_T Scales,
  emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel13(const emxArray_real_T a, int32_T
  vstride, emxArray_real_T dv3);
static __global__ void ec_cwtAvg_kernel130(const emxArray_real32_T Scales,
  int32_T nbytes, emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel131(const emxArray_real32_T Scales,
  emxArray_real32_T c, int32_T abswt2S_dim0);
static __global__ void ec_cwtAvg_kernel132(const emxArray_real32_T Scales,
  int32_T nbytes, emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel133(const real32_T xbar,
  emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel134(const real32_T xbar,
  emxArray_real32_T c, int32_T abswt2S_dim0);
static __global__ void ec_cwtAvg_kernel14(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel15(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv6);
static __global__ void ec_cwtAvg_kernel16(const emxArray_real_T xt, const
  emxArray_real_T dv6, const emxArray_real_T dv3, int32_T b_dv3, emxArray_real_T
  fx);
static __global__ void ec_cwtAvg_kernel17(int16_T dv2_idx_1, emxArray_real_T fx);
static __global__ void ec_cwtAvg_kernel18(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel19(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel2(const real_T fLims[2], real_T
  freqrange[2]);
static __global__ void ec_cwtAvg_kernel20(const int32_T vstride, real_T
  interval[650]);
static __global__ void ec_cwtAvg_kernel21(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel22(const emxArray_real_T x, int32_T
  nbytes, emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ec_cwtAvg_kernel23(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T dv9);
static __global__ void ec_cwtAvg_kernel24(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel25(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv11);
static __global__ void ec_cwtAvg_kernel26(const emxArray_real_T xt, const
  emxArray_real_T dv11, const emxArray_real_T dv9, int32_T b_dv9,
  emxArray_real_T fx);
static __global__ void ec_cwtAvg_kernel27(int16_T dv2_idx_1, emxArray_real_T fx);
static __global__ void ec_cwtAvg_kernel28(const real_T r, real_T freqrange[2],
  real_T fLims[2]);
static __global__ void ec_cwtAvg_kernel29(const real_T fs, real_T freqrange[2],
  real_T fLims[2]);
static __global__ void ec_cwtAvg_kernel3(const real_T fs, real_T NyquistRange[2]);
static __global__ void ec_cwtAvg_kernel30(int32_T nbytes, emxArray_real_T omega);
static __global__ void ec_cwtAvg_kernel31(const uint32_T N, int32_T j,
  emxArray_real_T omega);
static __global__ void ec_cwtAvg_kernel32(emxArray_real_T r);
static __global__ void ec_cwtAvg_kernel33(const emxArray_real_T omega, int32_T
  pathlen, emxArray_real_T r);
static __global__ void ec_cwtAvg_kernel34(const int32_T nbytes, const int32_T
  vstride, const emxArray_real_T omega, int32_T pathlen, emxArray_real_T r,
  int32_T omega_dim1);
static __global__ void ec_cwtAvg_kernel35(const emxArray_real_T r, int32_T b_r,
  emxArray_real_T omega);
static __global__ void ec_cwtAvg_kernel36(const real_T fLims[2], boolean_T b[2]);
static __global__ void ec_cwtAvg_kernel37(const char_T cv[128], char_T wav[5],
  char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4);
static __global__ void ec_cwtAvg_kernel38(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel39(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel4(const char_T cv[128], char_T wav[5],
  char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4);
static __global__ void ec_cwtAvg_kernel40(const int32_T vstride, real_T
  interval[650]);
static __global__ void ec_cwtAvg_kernel41(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel42(const emxArray_real_T x, int32_T
  nbytes, emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ec_cwtAvg_kernel43(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel44(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel45(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel46(const emxArray_real_T a, int32_T
  vstride, emxArray_real_T dv10);
static __global__ void ec_cwtAvg_kernel47(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel48(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv12);
static __global__ void ec_cwtAvg_kernel49(const emxArray_real_T xt, const
  emxArray_real_T dv12, const emxArray_real_T dv10, int32_T b_dv10,
  emxArray_real_T fx);
static __global__ void ec_cwtAvg_kernel5(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel50(int16_T dv2_idx_1, emxArray_real_T fx);
static __global__ void ec_cwtAvg_kernel51(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel52(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel53(const int32_T vstride, real_T
  interval[650]);
static __global__ void ec_cwtAvg_kernel54(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel55(const emxArray_real_T x, int32_T
  nbytes, emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ec_cwtAvg_kernel56(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T dv14);
static __global__ void ec_cwtAvg_kernel57(const emxArray_real_T x, int32_T
  vstride, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel58(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv17);
static __global__ void ec_cwtAvg_kernel59(const emxArray_real_T xt, const
  emxArray_real_T dv17, const emxArray_real_T dv14, int32_T b_dv14,
  emxArray_real_T fx);
static __global__ void ec_cwtAvg_kernel6(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel60(int16_T dv2_idx_1, emxArray_real_T fx);
static __global__ void ec_cwtAvg_kernel61(real_T r, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel62(const emxArray_real_T y, const real_T
  r, int32_T vstride, emxArray_real_T b_y);
static __global__ void ec_cwtAvg_kernel63(const emxArray_real_T y, const real_T
  halfh, int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ec_cwtAvg_kernel64(const real_T fs, const real_T fLims[2],
  real_T NyquistRange[2]);
static __global__ void ec_cwtAvg_kernel65(real_T r, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel66(const emxArray_real_T y, const real_T
  tol, int32_T vstride, emxArray_real_T b_y);
static __global__ void ec_cwtAvg_kernel67(const emxArray_real_T y, const real_T
  halfh, int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ec_cwtAvg_kernel68(int32_T fb_Scales, emxArray_real_T
  psidft);
static __global__ void ec_cwtAvg_kernel69(const emxArray_real_T fb_Scales,
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ec_cwtAvg_kernel7(const int32_T vstride, real_T interval
  [650]);
static __global__ void ec_cwtAvg_kernel70(const emxArray_real_T omega, const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, int32_T pathlen,
  emxArray_real_T somega, int32_T somega_dim0);
static __global__ void ec_cwtAvg_kernel71(const emxArray_real_T somega, int32_T
  vstride, emxArray_real_T absomega);
static __global__ void ec_cwtAvg_kernel72(const emxArray_real_T absomega,
  int32_T b_absomega, emxArray_real_T powscales);
static __global__ void ec_cwtAvg_kernel73(int32_T vstride, emxArray_real_T
  absomega);
static __global__ void ec_cwtAvg_kernel74(const emxArray_real_T powscales, const
  emxArray_real_T absomega, int32_T b_absomega, emxArray_real_T x);
static __global__ void ec_cwtAvg_kernel75(int32_T vstride, emxArray_real_T x);
static __global__ void ec_cwtAvg_kernel76(const emxArray_real_T somega, const
  emxArray_real_T x, int32_T b_x, emxArray_real_T psidft);
static __global__ void ec_cwtAvg_kernel77(const emxArray_real_T fb_Scales,
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ec_cwtAvg_kernel78(const real_T fs, int32_T j,
  emxArray_real_T f);
static __global__ void ec_cwtAvg_kernel79(const emxArray_real_T f, int32_T b_f,
  emxArray_real_T freqs);
static __global__ void ec_cwtAvg_kernel8(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel80(const emxArray_real_T fb_Scales,
  int32_T b_fb_Scales, emxArray_real32_T Scales);
static __global__ void ec_cwtAvg_kernel81(const emxArray_real_T psidft, int32_T
  b_psidft, emxArray_real32_T psihat);
static __global__ void ec_cwtAvg_kernel82(const int32_T nbytes, const
  emxArray_real32_T x, int32_T b_x, emxArray_real32_T xv, int32_T x_dim0);
static __global__ void ec_cwtAvg_kernel83(const int32_T nbytes, const
  emxArray_real32_T x, real_T y, emxArray_real32_T b_x, int32_T x_dim0);
static __global__ void ec_cwtAvg_kernel84(const emxArray_real32_T x, int32_T
  pathlen, emxArray_real32_T xv);
static __global__ void ec_cwtAvg_kernel85(const emxArray_real32_T xv, int32_T
  b_xv, emxArray_creal32_T xposdft);
static __global__ void ec_cwtAvg_kernel86(const emxArray_creal32_T xposdft,
  const emxArray_real32_T psihat, const int32_T bcoef, const int32_T cfsposdft,
  int32_T nbytes, emxArray_creal32_T b_cfsposdft, int32_T psihat_dim0, int32_T
  cfsposdft_dim0);
static __global__ void ec_cwtAvg_kernel87(const real32_T cfsposdft_re, const
  emxArray_creal32_T cfsposdft, int32_T b_cfsposdft, emxArray_creal32_T cfspos);
static __global__ void ec_cwtAvg_kernel88(uint32_T xSize[2], int32_T
  cfsposdft_dim1);
static __global__ void ec_cwtAvg_kernel89(int32_T xSize, emxArray_creal32_T
  cfspos);
static __global__ void ec_cwtAvg_kernel9(const emxArray_real_T x, int32_T nbytes,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ec_cwtAvg_kernel90(char_T wav[5]);
static __global__ void ec_cwtAvg_kernel91(char_T wav[5], char_T b_dim0, char_T
  b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4);
static __global__ void ec_cwtAvg_kernel92(const char_T wav[5], char_T wavname[5]);
static __global__ void ec_cwtAvg_kernel93(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel94(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel95(const int32_T vstride, real_T
  interval[650]);
static __global__ void ec_cwtAvg_kernel96(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel97(const emxArray_real_T x, int32_T
  nbytes, emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ec_cwtAvg_kernel98(const emxArray_real_T x, int32_T b_x,
  emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel99(const emxArray_real_T a, int32_T
  vstride, emxArray_real_T y);
static void ec_cwtAvg_once();
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real32_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y);
static real_T emlrt_marshallIn(const mxArray *fs, const char_T *identifier);
static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static void emlrt_marshallOut(const emxArray_real32_T *u, const mxArray *y);
static void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_creal32_T(emxArray_creal32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_uint32_T(emxArray_uint32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxFree_char_T(emxArray_char_T **pEmxArray);
static void emxFree_creal32_T(emxArray_creal32_T **pEmxArray);
static void emxFree_real32_T(emxArray_real32_T **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxFree_uint32_T(emxArray_uint32_T **pEmxArray);
static void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_creal32_T(emxArray_creal32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_uint32_T(emxArray_uint32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
  emxArray_creal32_T *gpu);
static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
  emxArray_real32_T *gpu);
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu);
static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu);
static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu);
static void gpuEmxFree_real32_T(emxArray_real32_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
static void gpuEmxFree_uint32_T(emxArray_uint32_T *gpu);
static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu, const
  emxArray_creal32_T *cpu);
static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu, const
  emxArray_real32_T *cpu);
static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu, const
  emxArray_real_T *cpu);
static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
  emxArray_creal32_T *gpu);
static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
  emxArray_real32_T *gpu);
static void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T
  *gpu);
static void gpuEmxMemcpyGpuToCpu_uint32_T(emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu);
static void gpuEmxReset_creal32_T(emxArray_creal32_T *gpu);
static void gpuEmxReset_real32_T(emxArray_real32_T *gpu);
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu);
static real_T rt_powd_snf(real_T u0, real_T u1);

// Function Definitions
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4)
{
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  in1->size[1] = in4->size[1];
  emxEnsureCapacity_real_T(in1, i, &ab_emlrtRTEI);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_1 = (in3->size[1] != 1);
  for (i = 0; i < in4->size[1]; i++) {
    in1->data[i] = in2->data[i * stride_0_1] * in3->data[i * stride_1_1] *
      in4->data[i];
  }
}

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
  *msgId, emxArray_real32_T *ret)
{
  static const int32_T dims[2]{ -1, -1 };

  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{ true, true };

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

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4)
{
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  in1->size[1] = in4->size[1];
  emxEnsureCapacity_real_T(in1, i, &ab_emlrtRTEI);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_1 = (in3->size[1] != 1);
  for (i = 0; i < in4->size[1]; i++) {
    in1->data[i] = in2->data[i * stride_0_1] / in3->data[i * stride_1_1] *
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

  emxEnsureCapacity_real_T(in1, i, &bb_emlrtRTEI);
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

  emxEnsureCapacity_real_T(in1, i, &q_emlrtRTEI);
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel1(const real_T
  fLims[2], boolean_T b[2])
{
  uint64_T threadId;
  int32_T varargin_2;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_2 = static_cast<int32_T>(threadId);
  if (varargin_2 < 2) {
    b[varargin_2] = isnan(fLims[varargin_2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel10(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 19.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel100(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T x)
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
    x.data[k] = exp(-2.0 * (1.0 / (1.0 - y.data[k])));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel101(const
  emxArray_real_T x, int32_T b_x, emxArray_real_T c_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    c_x.data[varargin_2] = 14.7781121978613 * x.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel102(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = x.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel103(const
  emxArray_real_T xt, const emxArray_real_T x, const emxArray_real_T y, int32_T
  b_y, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fx.data[varargin_2] = y.data[varargin_2] / x.data[varargin_2] *
      xt.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel104(int16_T
  dv2_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fx.data[varargin_2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel105(const
  emxArray_creal32_T cfspos, int32_T vstride, emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = hypotf(cfspos.data[k].re, cfspos.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel106(const
  emxArray_real32_T y, int32_T vstride, emxArray_real32_T abscfssq)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    abscfssq.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel107(const
  emxArray_real32_T abscfssq, int32_T b_abscfssq, emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_abscfssq);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    a.data[varargin_2] = abscfssq.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel108(const
  emxArray_real32_T Scales, const emxArray_real32_T a, const int32_T acoef,
  const int32_T abscfssq, int32_T nbytes, emxArray_real32_T b_abscfssq, int32_T
  a_dim0, int32_T Scales_dim1, int32_T abscfssq_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(abscfssq) + 1UL) * (static_cast<uint64_T>
    (nbytes) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_k;
    int32_T k;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(abscfssq) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) / (static_cast<
      uint64_T>(abscfssq) + 1UL));
    b_abscfssq.data[b_k + abscfssq_dim0 * k] = a.data[static_cast<int32_T>
      (a_dim0 != 1) * b_k + a_dim0 * (acoef * k)] / Scales.data
      [static_cast<int32_T>(Scales_dim1 != 1) * b_k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel109(uint32_T N,
  emxArray_uint32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(N)) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    y.data[varargin_2] = static_cast<uint32_T>(varargin_2) + 1U;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel11(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel110(int32_T
  abscfssq, emxArray_real32_T z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abscfssq);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    z.data[varargin_2] = 0.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel111(const
  emxArray_uint32_T y, emxArray_real_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[0] = 0.5 * static_cast<real_T>(static_cast<int32_T>(y.data[1]) -
      static_cast<int32_T>(y.data[0]));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel112(const
  emxArray_uint32_T y, int32_T nbytes, emxArray_real_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c.data[k + 1] = 0.5 * static_cast<real_T>(static_cast<int32_T>(y.data[k + 2])
      - static_cast<int32_T>(y.data[k]));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel113(const
  emxArray_uint32_T y, emxArray_real_T c, int32_T abscfssq_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[abscfssq_dim1 - 1] = 0.5 * static_cast<real_T>(static_cast<int32_T>
      (y.data[abscfssq_dim1 - 1]) - static_cast<int32_T>(y.data[abscfssq_dim1 -
      2]));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel114(const
  emxArray_uint32_T y, int32_T nbytes, emxArray_real_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    c.data[varargin_2] = static_cast<real_T>(y.data[0]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel115(const real_T
  r, emxArray_real_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[0] = r;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel116(const real_T
  r, emxArray_real_T c, int32_T abscfssq_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[abscfssq_dim1 - 1] = r;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel117(int32_T
  nbytes, emxArray_real32_T z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T acoef;
    acoef = static_cast<int32_T>(idx);
    z.data[acoef] = 0.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel118(const
  emxArray_real32_T Scales, emxArray_real32_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[0] = 0.5F * (Scales.data[1] - Scales.data[0]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel119(const
  emxArray_real32_T Scales, int32_T nbytes, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c.data[k + 1] = 0.5F * (Scales.data[k + 2] - Scales.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel12(const
  emxArray_real_T y, const emxArray_real_T b_y, int32_T c_y, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    a.data[varargin_2] = 20.0 * b_y.data[varargin_2] - 3.0 * y.data[varargin_2];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel120(const
  emxArray_real32_T Scales, emxArray_real32_T c, int32_T z_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[z_dim0 - 1] = 0.5F * (Scales.data[z_dim0 - 1] - Scales.data[z_dim0 -
      2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel121(const
  emxArray_real32_T Scales, int32_T nbytes, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    c.data[varargin_2] = Scales.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel122(const
  real32_T xbar, emxArray_real32_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[0] = xbar;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel123(const
  real32_T xbar, emxArray_real32_T c, int32_T z_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[z_dim0 - 1] = xbar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel124(const
  real32_T xbar, int32_T j, emxArray_creal32_T cfspos)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(j) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    cfspos.data[varargin_2].re *= xbar;
    cfspos.data[varargin_2].im *= xbar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel125(const
  emxArray_creal32_T cfspos, int32_T vstride, emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = hypotf(cfspos.data[k].re, cfspos.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel126(const
  emxArray_real32_T y, int32_T vstride, emxArray_real32_T abswt2)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    abswt2.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel127(const
  emxArray_real32_T Scales, const emxArray_real32_T abswt2, const int32_T acoef,
  const int32_T abswt2S, int32_T nbytes, emxArray_real32_T b_abswt2S, int32_T
  abswt2_dim0, int32_T Scales_dim1, int32_T abswt2S_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(abswt2S) + 1UL) * (static_cast<uint64_T>
    (nbytes) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_k;
    int32_T k;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(abswt2S) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) /
      (static_cast<uint64_T>(abswt2S) + 1UL));
    b_abswt2S.data[b_k + abswt2S_dim0 * k] = abswt2.data[static_cast<int32_T>
      (abswt2_dim0 != 1) * b_k + abswt2_dim0 * (acoef * k)] / Scales.data[
      static_cast<int32_T>(Scales_dim1 != 1) * b_k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel128(int32_T
  abswt2S, emxArray_real32_T savgpTMP)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abswt2S);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    savgpTMP.data[varargin_2] = 0.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel129(const
  emxArray_real32_T Scales, emxArray_real32_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[0] = 0.5F * (Scales.data[1] - Scales.data[0]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel13(const
  emxArray_real_T a, int32_T vstride, emxArray_real_T dv3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a.data[k];
    dv3.data[k] = d * d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel130(const
  emxArray_real32_T Scales, int32_T nbytes, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c.data[k + 1] = 0.5F * (Scales.data[k + 2] - Scales.data[k]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel131(const
  emxArray_real32_T Scales, emxArray_real32_T c, int32_T abswt2S_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[abswt2S_dim0 - 1] = 0.5F * (Scales.data[abswt2S_dim0 - 1] -
      Scales.data[abswt2S_dim0 - 2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel132(const
  emxArray_real32_T Scales, int32_T nbytes, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    c.data[varargin_2] = Scales.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel133(const
  real32_T xbar, emxArray_real32_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[0] = xbar;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel134(const
  real32_T xbar, emxArray_real32_T c, int32_T abswt2S_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[abswt2S_dim0 - 1] = xbar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel14(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel15(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv6)
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
    dv6.data[k] = exp(-2.0 * y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel16(const
  emxArray_real_T xt, const emxArray_real_T dv6, const emxArray_real_T dv3,
  int32_T b_dv3, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv3);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fx.data[varargin_2] = dv3.data[varargin_2] * dv6.data[varargin_2] *
      xt.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel17(int16_T
  dv2_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fx.data[varargin_2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel18(real_T
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

static __global__ __launch_bounds__(512, 1) void ec_cwtAvg_kernel19(real_T
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel2(const real_T
  fLims[2], real_T freqrange[2])
{
  uint64_T threadId;
  int32_T varargin_2;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_2 = static_cast<int32_T>(threadId);
  if (varargin_2 < 2) {
    freqrange[varargin_2] = fLims[varargin_2];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel20(const int32_T
  vstride, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[vstride];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel21(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel22(const
  emxArray_real_T x, int32_T nbytes, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = x.data[k];
    tkd1mtk = d / (1.0 - d);
    b_x.data[k] = tkd1mtk * tkd1mtk;
    xt.data[k] = 2.0 * tkd1mtk / ((1.0 - d) * (1.0 - d));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel23(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T dv9)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv9.data[k] = pow(x.data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel24(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel25(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv11)
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
    dv11.data[k] = exp(-2.0 * y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel26(const
  emxArray_real_T xt, const emxArray_real_T dv11, const emxArray_real_T dv9,
  int32_T b_dv9, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv9);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fx.data[varargin_2] = dv9.data[varargin_2] * dv11.data[varargin_2] *
      xt.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel27(int16_T
  dv2_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fx.data[varargin_2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel28(const real_T
  r, real_T freqrange[2], real_T fLims[2])
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel29(const real_T
  fs, real_T freqrange[2], real_T fLims[2])
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel3(const real_T
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel30(int32_T
  nbytes, emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    omega.data[varargin_2] = static_cast<real_T>(varargin_2) + 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel31(const
  uint32_T N, int32_T j, emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(j);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    omega.data[varargin_2] = omega.data[varargin_2] * 6.2831853071795862 /
      static_cast<real_T>(N);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel32
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel33(const
  emxArray_real_T omega, int32_T pathlen, emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(pathlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    r.data[varargin_2 + 1] = omega.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel34(const
  int32_T nbytes, const int32_T vstride, const emxArray_real_T omega, int32_T
  pathlen, emxArray_real_T r, int32_T omega_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(pathlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    r.data[(varargin_2 + omega_dim1) + 1] = -omega.data[vstride + nbytes *
      varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel35(const
  emxArray_real_T r, int32_T b_r, emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_r);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    omega.data[varargin_2] = r.data[varargin_2];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel36(const real_T
  fLims[2], boolean_T b[2])
{
  uint64_T threadId;
  int32_T varargin_2;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_2 = static_cast<int32_T>(threadId);
  if (varargin_2 < 2) {
    b[varargin_2] = isnan(fLims[varargin_2]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel37(const char_T
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel38(real_T
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

static __global__ __launch_bounds__(512, 1) void ec_cwtAvg_kernel39(real_T
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel4(const char_T
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel40(const int32_T
  vstride, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[vstride];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel41(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel42(const
  emxArray_real_T x, int32_T nbytes, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = x.data[k];
    tkd1mtk = d / (1.0 - d);
    b_x.data[k] = tkd1mtk * tkd1mtk;
    xt.data[k] = 2.0 * tkd1mtk / ((1.0 - d) * (1.0 - d));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel43(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 19.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel44(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel45(const
  emxArray_real_T y, const emxArray_real_T b_y, int32_T c_y, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    a.data[varargin_2] = 20.0 * b_y.data[varargin_2] - 3.0 * y.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel46(const
  emxArray_real_T a, int32_T vstride, emxArray_real_T dv10)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a.data[k];
    dv10.data[k] = d * d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel47(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel48(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv12)
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
    dv12.data[k] = exp(-2.0 * y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel49(const
  emxArray_real_T xt, const emxArray_real_T dv12, const emxArray_real_T dv10,
  int32_T b_dv10, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv10);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fx.data[varargin_2] = dv10.data[varargin_2] * dv12.data[varargin_2] *
      xt.data[varargin_2];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel5(real_T
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel50(int16_T
  dv2_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fx.data[varargin_2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel51(real_T
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

static __global__ __launch_bounds__(512, 1) void ec_cwtAvg_kernel52(real_T
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel53(const int32_T
  vstride, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[vstride];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel54(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel55(const
  emxArray_real_T x, int32_T nbytes, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = x.data[k];
    tkd1mtk = d / (1.0 - d);
    b_x.data[k] = tkd1mtk * tkd1mtk;
    xt.data[k] = 2.0 * tkd1mtk / ((1.0 - d) * (1.0 - d));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel56(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T dv14)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv14.data[k] = pow(x.data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel57(const
  emxArray_real_T x, int32_T vstride, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = pow(x.data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel58(const
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel59(const
  emxArray_real_T xt, const emxArray_real_T dv17, const emxArray_real_T dv14,
  int32_T b_dv14, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv14);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fx.data[varargin_2] = dv14.data[varargin_2] * dv17.data[varargin_2] *
      xt.data[varargin_2];
  }
}

static __global__ __launch_bounds__(512, 1) void ec_cwtAvg_kernel6(real_T
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel60(int16_T
  dv2_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fx.data[varargin_2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel61(real_T r,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(r);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    y.data[varargin_2] = static_cast<real_T>(varargin_2);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel62(const
  emxArray_real_T y, const real_T r, int32_T vstride, emxArray_real_T b_y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b_y.data[k] = pow(r, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel63(const
  emxArray_real_T y, const real_T halfh, int32_T b_y, emxArray_real_T fb_Scales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fb_Scales.data[varargin_2] = halfh * y.data[varargin_2];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel64(const real_T
  fs, const real_T fLims[2], real_T NyquistRange[2])
{
  uint64_T threadId;
  int32_T varargin_2;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_2 = static_cast<int32_T>(threadId);
  if (varargin_2 < 2) {
    NyquistRange[varargin_2] = fLims[varargin_2] / fs * 2.0 * 3.1415926535897931;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel65(real_T r,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(r);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    y.data[varargin_2] = static_cast<real_T>(varargin_2);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel66(const
  emxArray_real_T y, const real_T tol, int32_T vstride, emxArray_real_T b_y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b_y.data[k] = pow(tol, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel67(const
  emxArray_real_T y, const real_T halfh, int32_T b_y, emxArray_real_T fb_Scales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    fb_Scales.data[varargin_2] = halfh * y.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel68(int32_T
  fb_Scales, emxArray_real_T psidft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    psidft.data[varargin_2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel69(const
  emxArray_real_T fb_Scales, int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    f.data[varargin_2] = 0.0 / fb_Scales.data[varargin_2];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel7(const int32_T
  vstride, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[vstride];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel70(const
  emxArray_real_T omega, const emxArray_real_T fb_Scales, const int32_T
  b_fb_Scales, int32_T pathlen, emxArray_real_T somega, int32_T somega_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_fb_Scales) + 1UL) * static_cast<uint64_T>
    (pathlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T acoef;
    int32_T varargin_2;
    acoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fb_Scales) + 1UL));
    varargin_2 = static_cast<int32_T>((idx - static_cast<uint64_T>(acoef)) / (
      static_cast<uint64_T>(b_fb_Scales) + 1UL));
    somega.data[acoef + somega_dim0 * varargin_2] = fb_Scales.data[acoef] *
      omega.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel71(const
  emxArray_real_T somega, int32_T vstride, emxArray_real_T absomega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absomega.data[k] = fabs(somega.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel72(const
  emxArray_real_T absomega, int32_T b_absomega, emxArray_real_T powscales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_absomega);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    powscales.data[varargin_2] = absomega.data[varargin_2] *
      absomega.data[varargin_2] * absomega.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel73(int32_T
  vstride, emxArray_real_T absomega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absomega.data[k] = log(absomega.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel74(const
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
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    x.data[varargin_2] = 20.0 * absomega.data[varargin_2] -
      powscales.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel75(int32_T
  vstride, emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    x.data[k] = exp(x.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel76(const
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
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    psidft.data[varargin_2] = 0.0050536085896138528 * x.data[varargin_2] *
      static_cast<real_T>(somega.data[varargin_2] > 0.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel77(const
  emxArray_real_T fb_Scales, int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    f.data[varargin_2] = 1.8820720577620569 / fb_Scales.data[varargin_2] /
      6.2831853071795862;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel78(const
  real_T fs, int32_T j, emxArray_real_T f)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(j);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    f.data[varargin_2] *= fs;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel79(const
  emxArray_real_T f, int32_T b_f, emxArray_real_T freqs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_f);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    freqs.data[varargin_2] = f.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel8(const real_T
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel80(const
  emxArray_real_T fb_Scales, int32_T b_fb_Scales, emxArray_real32_T Scales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    Scales.data[varargin_2] = static_cast<real32_T>(fb_Scales.data[varargin_2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel81(const
  emxArray_real_T psidft, int32_T b_psidft, emxArray_real32_T psihat)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_psidft);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    psihat.data[varargin_2] = static_cast<real32_T>(psidft.data[varargin_2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel82(const
  int32_T nbytes, const emxArray_real32_T x, int32_T b_x, emxArray_real32_T xv,
  int32_T x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    xv.data[varargin_2] = x.data[varargin_2 + x_dim0 * (nbytes - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel83(const
  int32_T nbytes, const emxArray_real32_T x, real_T y, emxArray_real32_T b_x,
  int32_T x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(y)) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    b_x.data[varargin_2] = x.data[varargin_2 + x_dim0 * (nbytes - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel84(const
  emxArray_real32_T x, int32_T pathlen, emxArray_real32_T xv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(pathlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    xv.data[varargin_2] = x.data[varargin_2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel85(const
  emxArray_real32_T xv, int32_T b_xv, emxArray_creal32_T xposdft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xv);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    xposdft.data[varargin_2].re = xv.data[varargin_2];
    xposdft.data[varargin_2].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel86(const
  emxArray_creal32_T xposdft, const emxArray_real32_T psihat, const int32_T
  bcoef, const int32_T cfsposdft, int32_T nbytes, emxArray_creal32_T b_cfsposdft,
  int32_T psihat_dim0, int32_T cfsposdft_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(cfsposdft) + 1UL) * (static_cast<uint64_T>
    (nbytes) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T acoef;
    int32_T b_bcoef;
    int32_T b_k;
    int32_T k;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(cfsposdft) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) /
      (static_cast<uint64_T>(cfsposdft) + 1UL));
    acoef = bcoef * k + 1;
    b_bcoef = static_cast<int32_T>(psihat_dim0 != 1);
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].re = psihat.data[b_bcoef * b_k +
      psihat_dim0 * (acoef - 1)] * xposdft.data[k].re;
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].im = psihat.data[b_bcoef * b_k +
      psihat_dim0 * (acoef - 1)] * xposdft.data[k].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel87(const
  real32_T cfsposdft_re, const emxArray_creal32_T cfsposdft, int32_T b_cfsposdft,
  emxArray_creal32_T cfspos)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfsposdft);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    real32_T ai;
    real32_T ar;
    varargin_2 = static_cast<int32_T>(idx);
    ar = cfsposdft.data[varargin_2].re;
    ai = cfsposdft.data[varargin_2].im;
    if (ai == 0.0F) {
      cfspos.data[varargin_2].re = ar / cfsposdft_re;
      cfspos.data[varargin_2].im = 0.0F;
    } else if (ar == 0.0F) {
      cfspos.data[varargin_2].re = 0.0F;
      cfspos.data[varargin_2].im = ai / cfsposdft_re;
    } else {
      cfspos.data[varargin_2].re = ar / cfsposdft_re;
      cfspos.data[varargin_2].im = ai / cfsposdft_re;
    }
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel88(uint32_T
  xSize[2], int32_T cfsposdft_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    xSize[1] = static_cast<uint32_T>(cfsposdft_dim1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel89(int32_T
  xSize, emxArray_creal32_T cfspos)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xSize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    cfspos.data[varargin_2].re = 0.0F;
    cfspos.data[varargin_2].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel9(const
  emxArray_real_T x, int32_T nbytes, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = x.data[k];
    tkd1mtk = d / (1.0 - d);
    b_x.data[k] = tkd1mtk * tkd1mtk;
    xt.data[k] = 2.0 * tkd1mtk / ((1.0 - d) * (1.0 - d));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel90(char_T wav[5])
{
  uint64_T threadId;
  int32_T varargin_2;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_2 = static_cast<int32_T>(threadId);
  if (varargin_2 < 5) {
    wav[varargin_2] = ' ';
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel91(char_T wav[5],
  char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4)
{
  __shared__ char_T b_shared[5];
  uint64_T threadId;
  int32_T varargin_2;
  if (mwGetThreadIndexWithinBlock() == 0) {
    b_shared[0] = b_dim0;
    b_shared[1] = b_dim1;
    b_shared[2] = b_dim2;
    b_shared[3] = b_dim3;
    b_shared[4] = b_dim4;
  }

  __syncthreads();
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_2 = static_cast<int32_T>(threadId);
  if (varargin_2 < 5) {
    wav[varargin_2] = b_shared[varargin_2];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel92(const char_T
  wav[5], char_T wavname[5])
{
  uint64_T threadId;
  int32_T varargin_2;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  varargin_2 = static_cast<int32_T>(threadId);
  if (varargin_2 < 5) {
    wavname[varargin_2] = wav[varargin_2];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel93(real_T
  interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[0] = -1.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(512, 1) void ec_cwtAvg_kernel94(real_T
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel95(const int32_T
  vstride, real_T interval[650])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    interval[1] = interval[vstride];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel96(const
  real_T interval[650], int32_T nsubs, real_T subs[1298])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel97(const
  emxArray_real_T x, int32_T nbytes, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nbytes) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = x.data[k];
    tkd1mtk = d * d;
    b_x.data[k] = 0.29999999999999982 * d * (3.0 - tkd1mtk) + 5.0;
    xt.data[k] = 0.89999999999999947 * (1.0 - tkd1mtk);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel98(const
  emxArray_real_T x, int32_T b_x, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T varargin_2;
    varargin_2 = static_cast<int32_T>(idx);
    a.data[varargin_2] = (x.data[varargin_2] - 5.0) / 0.6;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel99(const
  emxArray_real_T a, int32_T vstride, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vstride) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a.data[k];
    y.data[k] = d * d;
  }
}

static void ec_cwtAvg_once()
{
  mwMemoryManagerInit(256U, 2U, 8U, 2048U);
  mwCudaMalloc(&cpu_cv_gpu_clone, sizeof(char_T [128]));
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

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y)
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

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
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

static void emlrt_marshallOut(const emxArray_real32_T *u, const mxArray *y)
{
  emlrtMxSetData((mxArray *)y, &u->data[0]);
  emlrtSetDimensions((mxArray *)y, &u->size[0], 2);
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

static void emxEnsureCapacity_creal32_T(emxArray_creal32_T *emxArray, int32_T
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(creal32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<creal32_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<creal32_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

static void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(real32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
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

static void emxFree_creal32_T(emxArray_creal32_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_creal32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<creal32_T *>(nullptr)) && (*pEmxArray)
        ->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_creal32_T *>(nullptr);
  }
}

static void emxFree_real32_T(emxArray_real32_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_real32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<real32_T *>(nullptr)) && (*pEmxArray
        )->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_real32_T *>(nullptr);
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

static void emxInit_creal32_T(emxArray_creal32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_creal32_T *emxArray;
  *pEmxArray = static_cast<emxArray_creal32_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_creal32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_creal32_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<creal32_T *>(nullptr);
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

static void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_real32_T *emxArray;
  *pEmxArray = static_cast<emxArray_real32_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_real32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_real32_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<real32_T *>(nullptr);
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

static void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
  emxArray_creal32_T *gpu)
{
  creal32_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) * sizeof
                 (creal32_T));
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
                   (creal32_T));
      cudaMemcpy(newData, gpu->data, static_cast<uint32_T>(actualSizeGpu) *
                 sizeof(creal32_T), cudaMemcpyDeviceToDevice);
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
    mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) * sizeof
                 (real32_T));
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
                   (real32_T));
      cudaMemcpy(newData, gpu->data, static_cast<uint32_T>(actualSizeGpu) *
                 sizeof(real32_T), cudaMemcpyDeviceToDevice);
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

static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu)
{
  uint32_T *newData;
  if (gpu->data == 0U) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) * sizeof
                 (uint32_T));
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
                   (uint32_T));
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

static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu)
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

static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu, const
  emxArray_creal32_T *cpu)
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
                 (creal32_T));
  }

  cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (creal32_T), cudaMemcpyHostToDevice);
}

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu, const
  emxArray_real32_T *cpu)
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
                 (real32_T));
  }

  cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (real32_T), cudaMemcpyHostToDevice);
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

static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
  emxArray_creal32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (creal32_T), cudaMemcpyDeviceToHost);
}

static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
  emxArray_real32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (real32_T), cudaMemcpyDeviceToHost);
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

static void gpuEmxMemcpyGpuToCpu_uint32_T(emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (uint32_T), cudaMemcpyDeviceToHost);
}

static void gpuEmxReset_creal32_T(emxArray_creal32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_creal32_T));
}

static void gpuEmxReset_real32_T(emxArray_real32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real32_T));
}

static void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real_T));
}

static void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_uint32_T));
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
// function [x,freqs] = ec_cwtAvg(x,fs,fLims,fOctave)
void ec_cwtAvg(const emxArray_real32_T *cpu_x, real_T fs, real_T cpu_fLims[2],
               real_T fOctave, emxArray_real_T *cpu_freqs)
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

  static const real_T dv4[15]{ 0.022935322010529221, 0.063092092629978544,
    0.1047900103222502, 0.14065325971552589, 0.16900472663926791,
    0.19035057806478539, 0.20443294007529891, 0.20948214108472779,
    0.20443294007529891, 0.19035057806478539, 0.16900472663926791,
    0.14065325971552589, 0.1047900103222502, 0.063092092629978544,
    0.022935322010529221 };

  static const real_T dv5[15]{ 0.022935322010529221, -0.066392873538891159,
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

  static const char_T b_b[5]{ 'm', 'o', 'r', 's', 'e' };

  static const char_T cv3[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T cv4[5]{ 'm', 'o', 'r', 's', 'e' };

  dim3 block;
  dim3 grid;
  emxArray_char_T *b_str;
  emxArray_char_T *str;
  emxArray_creal32_T gpu_cfspos;
  emxArray_creal32_T gpu_cfsposdft;
  emxArray_creal32_T gpu_xposdft;
  emxArray_creal32_T *cpu_cfspos;
  emxArray_creal32_T *cpu_cfsposdft;
  emxArray_creal32_T *cpu_xposdft;
  emxArray_real32_T b_gpu_c;
  emxArray_real32_T b_gpu_x;
  emxArray_real32_T c_gpu_c;
  emxArray_real32_T c_gpu_x;
  emxArray_real32_T c_gpu_y;
  emxArray_real32_T e_gpu_y;
  emxArray_real32_T gpu_Scales;
  emxArray_real32_T gpu_a;
  emxArray_real32_T gpu_abscfssq;
  emxArray_real32_T gpu_abswt2;
  emxArray_real32_T gpu_abswt2S;
  emxArray_real32_T gpu_psihat;
  emxArray_real32_T gpu_savgpTMP;
  emxArray_real32_T gpu_xv;
  emxArray_real32_T gpu_z;
  emxArray_real32_T *b_cpu_c;
  emxArray_real32_T *c_cpu_a;
  emxArray_real32_T *c_cpu_c;
  emxArray_real32_T *cpu_Scales;
  emxArray_real32_T *cpu_abscfssq;
  emxArray_real32_T *cpu_abswt2;
  emxArray_real32_T *cpu_abswt2S;
  emxArray_real32_T *cpu_psihat;
  emxArray_real32_T *cpu_savgpTMP;
  emxArray_real32_T *cpu_xv;
  emxArray_real32_T *cpu_z;
  emxArray_real32_T *k_cpu_x;
  emxArray_real32_T *m_cpu_y;
  emxArray_real32_T *p_cpu_y;
  emxArray_real_T b_gpu_a;
  emxArray_real_T b_gpu_fx;
  emxArray_real_T b_gpu_xt;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_a;
  emxArray_real_T c_gpu_fx;
  emxArray_real_T c_gpu_xt;
  emxArray_real_T d_gpu_a;
  emxArray_real_T d_gpu_fx;
  emxArray_real_T d_gpu_x;
  emxArray_real_T d_gpu_xt;
  emxArray_real_T e_gpu_fx;
  emxArray_real_T e_gpu_x;
  emxArray_real_T e_gpu_xt;
  emxArray_real_T f_gpu_x;
  emxArray_real_T f_gpu_y;
  emxArray_real_T g_gpu_x;
  emxArray_real_T g_gpu_y;
  emxArray_real_T gpu_absomega;
  emxArray_real_T gpu_c;
  emxArray_real_T gpu_dv10;
  emxArray_real_T gpu_dv11;
  emxArray_real_T gpu_dv12;
  emxArray_real_T gpu_dv14;
  emxArray_real_T gpu_dv17;
  emxArray_real_T gpu_dv3;
  emxArray_real_T gpu_dv6;
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
  emxArray_real_T gpu_y;
  emxArray_real_T h_gpu_x;
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
  emxArray_real_T p_gpu_y;
  emxArray_real_T q_gpu_y;
  emxArray_real_T *b_cpu_a;
  emxArray_real_T *b_cpu_fx;
  emxArray_real_T *b_cpu_x;
  emxArray_real_T *b_cpu_xt;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_fx;
  emxArray_real_T *c_cpu_x;
  emxArray_real_T *c_cpu_xt;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_a;
  emxArray_real_T *cpu_absomega;
  emxArray_real_T *cpu_c;
  emxArray_real_T *cpu_dv10;
  emxArray_real_T *cpu_dv11;
  emxArray_real_T *cpu_dv12;
  emxArray_real_T *cpu_dv14;
  emxArray_real_T *cpu_dv17;
  emxArray_real_T *cpu_dv3;
  emxArray_real_T *cpu_dv6;
  emxArray_real_T *cpu_dv9;
  emxArray_real_T *cpu_f;
  emxArray_real_T *cpu_fb_Scales;
  emxArray_real_T *cpu_fx;
  emxArray_real_T *cpu_omega;
  emxArray_real_T *cpu_powscales;
  emxArray_real_T *cpu_psidft;
  emxArray_real_T *cpu_r;
  emxArray_real_T *cpu_somega;
  emxArray_real_T *cpu_xt;
  emxArray_real_T *cpu_y;
  emxArray_real_T *d_cpu_a;
  emxArray_real_T *d_cpu_fx;
  emxArray_real_T *d_cpu_x;
  emxArray_real_T *d_cpu_xt;
  emxArray_real_T *d_cpu_y;
  emxArray_real_T *e_cpu_fx;
  emxArray_real_T *e_cpu_x;
  emxArray_real_T *e_cpu_xt;
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
  emxArray_real_T *k_cpu_y;
  emxArray_real_T *l_cpu_x;
  emxArray_real_T *l_cpu_y;
  emxArray_real_T *m_cpu_x;
  emxArray_real_T *n_cpu_x;
  emxArray_real_T *o_cpu_x;
  emxArray_real_T *o_cpu_y;
  emxArray_real_T *q_cpu_y;
  emxArray_uint32_T d_gpu_y;
  emxArray_uint32_T *n_cpu_y;
  int64_T d;
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
  real_T err_ok;
  real_T fb_VoicesPerOctave;
  real_T fc;
  real_T halfh;
  real_T intDsq;
  real_T intFsq;
  real_T m;
  real_T omegac;
  real_T q_ok;
  real_T r;
  real_T s;
  real_T tol;
  real_T toler;
  real_T y;
  int32_T acoef;
  int32_T b_eint;
  int32_T bcoef;
  int32_T eint;
  int32_T exitg1;
  int32_T fb_CutOff;
  int32_T i34;
  int32_T ix;
  int32_T j;
  int32_T nbytes;
  int32_T nsubs;
  int32_T pathlen;
  int32_T vstride;
  real32_T cpu_t;
  real32_T *gpu_t;
  uint32_T cpu_xSize[2];
  uint32_T (*gpu_xSize)[2];
  uint32_T N;
  uint32_T nChs;
  int16_T dv2_idx_1;
  char_T cpu_wav[5];
  char_T cpu_wavname[5];
  char_T (*gpu_wav)[5];
  char_T (*gpu_wavname)[5];
  int8_T n_idx_0;
  boolean_T cpu_b[2];
  boolean_T (*gpu_b)[2];
  boolean_T Scales_dirtyOnGpu;
  boolean_T a_dirtyOnCpu;
  boolean_T a_dirtyOnGpu;
  boolean_T abscfssq_dirtyOnGpu;
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
  boolean_T dv10_dirtyOnGpu;
  boolean_T dv11_dirtyOnGpu;
  boolean_T dv12_dirtyOnGpu;
  boolean_T dv14_dirtyOnGpu;
  boolean_T dv17_dirtyOnGpu;
  boolean_T dv3_dirtyOnGpu;
  boolean_T dv6_dirtyOnGpu;
  boolean_T dv9_dirtyOnGpu;
  boolean_T e_fx_dirtyOnCpu;
  boolean_T e_fx_dirtyOnGpu;
  boolean_T e_x_dirtyOnCpu;
  boolean_T e_x_dirtyOnGpu;
  boolean_T e_xt_dirtyOnGpu;
  boolean_T e_y_dirtyOnGpu;
  boolean_T exitg2;
  boolean_T f_x_dirtyOnCpu;
  boolean_T f_x_dirtyOnGpu;
  boolean_T f_y_dirtyOnGpu;
  boolean_T fb_Scales_dirtyOnGpu;
  boolean_T first_iteration;
  boolean_T freqs_dirtyOnGpu;
  boolean_T fx_dirtyOnCpu;
  boolean_T fx_dirtyOnGpu;
  boolean_T g_x_dirtyOnCpu;
  boolean_T g_x_dirtyOnGpu;
  boolean_T h_x_dirtyOnCpu;
  boolean_T interval_dirtyOnCpu;
  boolean_T omega_dirtyOnGpu;
  boolean_T powscales_dirtyOnGpu;
  boolean_T psidft_dirtyOnCpu;
  boolean_T somega_dirtyOnCpu;
  boolean_T somega_dirtyOnGpu;
  boolean_T subs_dirtyOnCpu;
  boolean_T subs_dirtyOnGpu;
  boolean_T validLaunchParams;
  boolean_T wavname_dirtyOnGpu;
  boolean_T xSize_dirtyOnCpu;
  boolean_T x_dirtyOnCpu;
  boolean_T x_dirtyOnGpu;
  boolean_T xposdft_dirtyOnCpu;
  boolean_T xt_dirtyOnGpu;
  boolean_T xv_dirtyOnCpu;
  boolean_T xv_dirtyOnGpu;
  boolean_T y_dirtyOnCpu;
  boolean_T y_dirtyOnGpu;
  boolean_T z_dirtyOnCpu;
  boolean_T z_dirtyOnGpu;
  if (!gpuConstsCopied_ec_cwtAvg) {
    gpuConstsCopied_ec_cwtAvg = true;
    cudaMemcpy(*cpu_cv_gpu_clone, cpu_cv, sizeof(char_T [128]),
               cudaMemcpyHostToDevice);
  }

  mwCudaMalloc(&gpu_wavname, 5UL);
  mwCudaMalloc(&gpu_t, 4UL);
  gpuEmxReset_real32_T(&b_gpu_c);
  gpuEmxReset_real32_T(&gpu_abswt2S);
  gpuEmxReset_real_T(&g_gpu_y);
  gpuEmxReset_real_T(&g_gpu_x);
  gpuEmxReset_real32_T(&gpu_abswt2);
  gpuEmxReset_real_T(&f_gpu_x);
  gpuEmxReset_real_T(&gpu_fx);
  gpuEmxReset_real_T(&b_gpu_a);
  gpuEmxReset_real32_T(&e_gpu_y);
  gpuEmxReset_real_T(&f_gpu_y);
  gpuEmxReset_real32_T(&c_gpu_c);
  gpuEmxReset_real_T(&gpu_c);
  gpuEmxReset_real_T(&gpu_xt);
  gpuEmxReset_real_T(&e_gpu_x);
  gpuEmxReset_real32_T(&gpu_z);
  gpuEmxReset_uint32_T(&d_gpu_y);
  gpuEmxReset_real_T(&d_gpu_x);
  gpuEmxReset_real32_T(&gpu_a);
  gpuEmxReset_real32_T(&gpu_abscfssq);
  gpuEmxReset_real32_T(&c_gpu_y);
  gpuEmxReset_creal32_T(&gpu_cfspos);
  gpuEmxReset_creal32_T(&gpu_cfsposdft);
  gpuEmxReset_real32_T(&c_gpu_x);
  gpuEmxReset_creal32_T(&gpu_xposdft);
  gpuEmxReset_real32_T(&gpu_xv);
  gpuEmxReset_real32_T(&gpu_psihat);
  gpuEmxReset_real32_T(&gpu_Scales);
  gpuEmxReset_real32_T(&gpu_savgpTMP);
  gpuEmxReset_real_T(&gpu_x);
  gpuEmxReset_real_T(&gpu_dv17);
  gpuEmxReset_real_T(&j_gpu_y);
  gpuEmxReset_real_T(&b_gpu_fx);
  gpuEmxReset_real_T(&gpu_dv14);
  gpuEmxReset_real_T(&gpu_powscales);
  gpuEmxReset_real_T(&b_gpu_xt);
  gpuEmxReset_real_T(&i_gpu_x);
  gpuEmxReset_real_T(&h_gpu_x);
  gpuEmxReset_real_T(&gpu_absomega);
  mwCudaMalloc(&gpu_xSize, 8UL);
  gpuEmxReset_real_T(&gpu_dv12);
  gpuEmxReset_real_T(&m_gpu_y);
  gpuEmxReset_real_T(&gpu_dv10);
  gpuEmxReset_real_T(&c_gpu_a);
  gpuEmxReset_real_T(&l_gpu_y);
  gpuEmxReset_real_T(&c_gpu_fx);
  gpuEmxReset_real_T(&gpu_somega);
  gpuEmxReset_real_T(&k_gpu_y);
  gpuEmxReset_real_T(&c_gpu_xt);
  gpuEmxReset_real_T(&gpu_f);
  gpuEmxReset_real_T(&k_gpu_x);
  gpuEmxReset_real_T(&gpu_psidft);
  gpuEmxReset_real_T(&j_gpu_x);
  gpuEmxReset_real_T(&i_gpu_y);
  gpuEmxReset_real_T(&gpu_dv11);
  gpuEmxReset_real_T(&h_gpu_y);
  gpuEmxReset_real_T(&n_gpu_y);
  gpuEmxReset_real_T(&d_gpu_fx);
  gpuEmxReset_real_T(&gpu_dv9);
  gpuEmxReset_real_T(&d_gpu_xt);
  gpuEmxReset_real_T(&m_gpu_x);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_real_T(&l_gpu_x);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_dv6);
  gpuEmxReset_real_T(&q_gpu_y);
  gpuEmxReset_real_T(&gpu_dv3);
  gpuEmxReset_real_T(&d_gpu_a);
  gpuEmxReset_real_T(&p_gpu_y);
  gpuEmxReset_real_T(&e_gpu_fx);
  gpuEmxReset_real_T(&o_gpu_y);
  gpuEmxReset_real_T(&e_gpu_xt);
  gpuEmxReset_real_T(&o_gpu_x);
  gpuEmxReset_real_T(&n_gpu_x);
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
  mwCudaMalloc(&gpu_fLims, 16UL);
  gpuEmxReset_real32_T(&b_gpu_x);
  wavname_dirtyOnGpu = false;
  f_y_dirtyOnGpu = false;
  e_fx_dirtyOnGpu = false;
  e_fx_dirtyOnCpu = false;
  e_xt_dirtyOnGpu = false;
  g_x_dirtyOnGpu = false;
  z_dirtyOnGpu = false;
  z_dirtyOnCpu = false;
  e_y_dirtyOnGpu = false;
  h_x_dirtyOnCpu = false;
  abscfssq_dirtyOnGpu = false;
  cfspos_dirtyOnGpu = false;
  cfspos_dirtyOnCpu = false;
  f_x_dirtyOnGpu = false;
  g_x_dirtyOnCpu = false;
  xposdft_dirtyOnCpu = false;
  xv_dirtyOnGpu = false;
  xv_dirtyOnCpu = false;
  Scales_dirtyOnGpu = false;
  e_x_dirtyOnGpu = false;
  f_x_dirtyOnCpu = false;
  dv17_dirtyOnGpu = false;
  d_fx_dirtyOnGpu = false;
  d_fx_dirtyOnCpu = false;
  dv14_dirtyOnGpu = false;
  powscales_dirtyOnGpu = false;
  d_xt_dirtyOnGpu = false;
  d_x_dirtyOnGpu = false;
  e_x_dirtyOnCpu = false;
  absomega_dirtyOnGpu = false;
  xSize_dirtyOnCpu = false;
  dv12_dirtyOnGpu = false;
  dv10_dirtyOnGpu = false;
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
  dv11_dirtyOnGpu = false;
  b_y_dirtyOnCpu = false;
  b_fx_dirtyOnGpu = false;
  b_fx_dirtyOnCpu = false;
  dv9_dirtyOnGpu = false;
  b_xt_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  c_x_dirtyOnCpu = false;
  y_dirtyOnCpu = false;
  dv6_dirtyOnGpu = false;
  dv3_dirtyOnGpu = false;
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
  x_dirtyOnCpu = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  //  CWT scale spectrum - CUDA binary wrapper (double-precision, FP64)
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
  // 'ec_cwtAvg:16' coder.gpu.kernelfun;
  // 'ec_cwtAvg:17' if fs<10
  if (fs < 10.0) {
    // 'ec_cwtAvg:17' ;
    // 'ec_cwtAvg:17' fs=10;
    fs = 10.0;
  }

  // 'ec_cwtAvg:18' if fLims(1)<1e-3
  if (cpu_fLims[0] < 0.001) {
    // 'ec_cwtAvg:18' ;
    // 'ec_cwtAvg:18' fLims(1)=1e-3;
    cpu_fLims[0] = 0.001;
  }

  // 'ec_cwtAvg:19' if fLims(2)>fs/2
  if (cpu_fLims[1] > fs / 2.0) {
    // 'ec_cwtAvg:19' ;
    // 'ec_cwtAvg:19' fLims(2)=fs/2;
    cpu_fLims[1] = fs / 2.0;
  }

  // 'ec_cwtAvg:20' if fOctave<1
  if (fOctave < 1.0) {
    // 'ec_cwtAvg:20' ;
    // 'ec_cwtAvg:20' fOctave=1;
    fOctave = 1.0;
  } else if (fOctave > 48.0) {
    // 'ec_cwtAvg:20' elseif fOctave>48
    // 'ec_cwtAvg:20' ;
    // 'ec_cwtAvg:20' fOctave=48;
    fOctave = 48.0;
  }

  // 'ec_cwtAvg:21' fOctave = round(fOctave);
  // 'ec_cwtAvg:22' nFrames = height(x);
  // 'ec_cwtAvg:23' nChs = uint32(width(x));
  nChs = static_cast<uint32_T>(cpu_x->size[1]);

  //  Prep CWT
  // coder.extrinsic("cwtfilterbank","centerFrequencies");
  // 'ec_cwtAvg:27' fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
  // 'ec_cwtAvg:28'     SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fOctave);
  fb_CutOff = 50;
  fb_VoicesPerOctave = std::round(fOctave);
  first_iteration = false;
  acoef = 0;
  do {
    exitg1 = 0;
    if (acoef + 1 < 11) {
      if (cpu_cv[static_cast<int32_T>(Bndry[acoef])] != cpu_cv
          [static_cast<int32_T>(cv1[acoef])]) {
        exitg1 = 1;
      } else {
        acoef++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (first_iteration) {
    if (cpu_x->size[0] <= 100000) {
      y = std::floor(static_cast<real_T>(cpu_x->size[0]) / 2.0);
    } else {
      r = std::frexp(static_cast<real_T>(cpu_x->size[0]), &nbytes);
      if (r == 0.5) {
        y = static_cast<real_T>(nbytes) - 1.0;
      } else {
        y = std::log(r) / 0.69314718055994529 + static_cast<real_T>(nbytes);
      }

      y = std::ceil(y);
    }
  } else {
    y = 0.0;
  }

  cudaMemcpy(*gpu_fLims, cpu_fLims, 16UL, cudaMemcpyHostToDevice);
  ec_cwtAvg_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_fLims, *gpu_b);
  b_dirtyOnGpu = true;
  first_iteration = true;
  vstride = 0;
  exitg2 = false;
  while ((!exitg2) && (vstride < 2)) {
    if (b_dirtyOnGpu) {
      cudaMemcpy(cpu_b, *gpu_b, 2UL, cudaMemcpyDeviceToHost);
    }

    b_dirtyOnGpu = false;
    if (!cpu_b[vstride]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      vstride++;
    }
  }

  if (!first_iteration) {
    real_T cf;
    boolean_T guard1{ false };

    ec_cwtAvg_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_fLims,
      *gpu_freqrange);
    ec_cwtAvg_kernel3<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs,
      *gpu_NyquistRange);
    b_dirtyOnGpu = true;
    emxInit_char_T(&str, 2, &ub_emlrtRTEI, true);
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
      j = str->size[0] * str->size[1];
      str->size[0] = 1;
      str->size[1] = nbytes;
      emxEnsureCapacity_char_T(str, j, &b_emlrtRTEI);
      emlrtMexSnprintf(&str->data[0], (size_t)nbytes, "%f", cpu_NyquistRange[1]);
    }

    emxFree_char_T(&str);
    ec_cwtAvg_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*cpu_cv_gpu_clone,
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
      r = 0.0057083835261;
      b_r = 0.0057083835261;
      for (vstride = 0; vstride < 6; vstride++) {
        fc = c[vstride];
        c_r = c_r * 0.005353955978584176 + fc;
        r = r * 0.005353955978584176 + fc;
        b_r = b_r * 0.005353955978584176 + fc;
      }

      c_r /= 13.666666666666666;
      r /= 13.666666666666666;
      b_r /= 13.666666666666666;
      b_r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((c_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(b_r) || std::isnan(b_r)) {
        ec_cwtAvg_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwtAvg_kernel6<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        intDsq = 0.0;
        vstride = 1;
        cudaMemcpy(cpu_interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        pathlen = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (pathlen > 0) {
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

          vstride = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        nbytes = 0;
        for (acoef = 0; acoef < vstride; acoef++) {
          if (std::abs(cpu_interval[acoef + 1] - cpu_interval[nbytes]) > 0.0) {
            nbytes++;
            cpu_interval[nbytes] = cpu_interval[acoef + 1];
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

          ec_cwtAvg_kernel7<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(vstride,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
          intDsq = rtNaN;
        } else {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                         cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            ec_cwtAvg_kernel8<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&b_cpu_x, 2, &g_emlrtRTEI, true);
          emxInit_real_T(&c_cpu_x, 2, &fc_emlrtRTEI, true);
          emxInit_real_T(&cpu_xt, 2, &gc_emlrtRTEI, true);
          emxInit_real_T(&cpu_y, 2, &hc_emlrtRTEI, true);
          emxInit_real_T(&cpu_fx, 2, &xb_emlrtRTEI, true);
          emxInit_real_T(&b_cpu_y, 2, &ic_emlrtRTEI, true);
          emxInit_real_T(&cpu_a, 2, &q_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv3, 2, &kc_emlrtRTEI, true);
          emxInit_real_T(&c_cpu_y, 2, &lc_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv6, 2, &kc_emlrtRTEI, true);
          do {
            exitg1 = 0;
            j = b_cpu_x->size[0] * b_cpu_x->size[1];
            b_cpu_x->size[0] = 1;
            b_cpu_x->size[1] = 15 * nsubs;
            emxEnsureCapacity_real_T(b_cpu_x, j, &g_emlrtRTEI);
            if (!b_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_x, &n_gpu_x);
            }

            ix = -1;
            for (vstride = 0; vstride < nsubs; vstride++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fc = cpu_subs[vstride << 1];
              subs_dirtyOnGpu = false;
              b_r = cpu_subs[(vstride << 1) + 1];
              r = (fc + b_r) / 2.0;
              halfh = (b_r - fc) / 2.0;
              for (j = 0; j < 15; j++) {
                b_cpu_x->data[(ix + j) + 1] = NODES[j] * halfh + r;
                b_x_dirtyOnCpu = true;
              }

              ix += 15;
            }

            j = c_cpu_x->size[0] * c_cpu_x->size[1];
            c_cpu_x->size[0] = 1;
            c_cpu_x->size[1] = b_cpu_x->size[1];
            emxEnsureCapacity_real_T(c_cpu_x, j, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(c_cpu_x, &o_gpu_x);
            j = cpu_xt->size[0] * cpu_xt->size[1];
            cpu_xt->size[0] = 1;
            cpu_xt->size[1] = b_cpu_x->size[1];
            emxEnsureCapacity_real_T(cpu_xt, j, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_xt, &e_gpu_xt);
            nbytes = b_cpu_x->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nbytes), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_x, b_cpu_x);
              }

              b_x_dirtyOnCpu = false;
              ec_cwtAvg_kernel9<<<grid, block>>>(n_gpu_x, nbytes, e_gpu_xt,
                o_gpu_x);
              x_dirtyOnGpu = true;
              xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_cpu_x, &o_gpu_x);
              }

              x_dirtyOnGpu = false;
              r = std::abs(c_cpu_x->data[0]);
              vstride = 0;
              exitg2 = false;
              while ((!exitg2) && (vstride <= c_cpu_x->size[1] - 2)) {
                tol = r;
                r = std::abs(c_cpu_x->data[vstride + 1]);
                if (std::abs(c_cpu_x->data[vstride + 1] - c_cpu_x->data[vstride])
                    <= 2.2204460492503131E-14 * std::fmax(tol, r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  vstride++;
                }
              }

              if (first_iteration) {
                dv2_idx_1 = static_cast<int16_T>(b_cpu_x->size[1]);
                j = cpu_fx->size[0] * cpu_fx->size[1];
                cpu_fx->size[0] = 1;
                cpu_fx->size[1] = b_cpu_x->size[1];
                emxEnsureCapacity_real_T(cpu_fx, j, &m_emlrtRTEI);
                if (!fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_fx, &e_gpu_fx);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (dv2_idx_1), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_fx, cpu_fx);
                  }

                  ec_cwtAvg_kernel17<<<grid, block>>>(dv2_idx_1, e_gpu_fx);
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
              j = cpu_y->size[0] * cpu_y->size[1];
              cpu_y->size[0] = 1;
              cpu_y->size[1] = c_cpu_x->size[1];
              emxEnsureCapacity_real_T(cpu_y, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_y, &o_gpu_y);
              vstride = c_cpu_x->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel10<<<grid, block>>>(o_gpu_x, vstride, o_gpu_y);
                y_dirtyOnGpu = true;
              }

              j = b_cpu_y->size[0] * b_cpu_y->size[1];
              b_cpu_y->size[0] = 1;
              b_cpu_y->size[1] = c_cpu_x->size[1];
              emxEnsureCapacity_real_T(b_cpu_y, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(b_cpu_y, &p_gpu_y);
              vstride = c_cpu_x->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel11<<<grid, block>>>(o_gpu_x, vstride, p_gpu_y);
                b_y_dirtyOnGpu = true;
              }

              if (cpu_y->size[1] == b_cpu_y->size[1]) {
                j = cpu_a->size[0] * cpu_a->size[1];
                cpu_a->size[0] = 1;
                cpu_a->size[1] = cpu_y->size[1];
                emxEnsureCapacity_real_T(cpu_a, j, &q_emlrtRTEI);
                if (!a_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_a, &d_gpu_a);
                }

                ix = cpu_y->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (ix + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (a_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, cpu_a);
                  }

                  ec_cwtAvg_kernel12<<<grid, block>>>(p_gpu_y, o_gpu_y, ix,
                    d_gpu_a);
                  a_dirtyOnGpu = true;
                  a_dirtyOnCpu = false;
                }
              } else {
                if (a_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_a, &d_gpu_a);
                }

                if (y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_y, &o_gpu_y);
                }

                y_dirtyOnGpu = false;
                if (b_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_cpu_y, &p_gpu_y);
                }

                b_y_dirtyOnGpu = false;
                c_binary_expand_op(cpu_a, cpu_y, b_cpu_y);
                a_dirtyOnCpu = true;
                a_dirtyOnGpu = false;
              }

              j = cpu_dv3->size[0] * cpu_dv3->size[1];
              cpu_dv3->size[0] = 1;
              cpu_dv3->size[1] = cpu_a->size[1];
              emxEnsureCapacity_real_T(cpu_dv3, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv3, &gpu_dv3);
              vstride = cpu_a->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, cpu_a);
                }

                a_dirtyOnCpu = false;
                ec_cwtAvg_kernel13<<<grid, block>>>(d_gpu_a, vstride, gpu_dv3);
                dv3_dirtyOnGpu = true;
              }

              j = c_cpu_y->size[0] * c_cpu_y->size[1];
              c_cpu_y->size[0] = 1;
              c_cpu_y->size[1] = c_cpu_x->size[1];
              emxEnsureCapacity_real_T(c_cpu_y, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(c_cpu_y, &q_gpu_y);
              vstride = c_cpu_x->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel14<<<grid, block>>>(o_gpu_x, vstride, q_gpu_y);
              }

              j = cpu_dv6->size[0] * cpu_dv6->size[1];
              cpu_dv6->size[0] = 1;
              cpu_dv6->size[1] = c_cpu_y->size[1];
              emxEnsureCapacity_real_T(cpu_dv6, j, &w_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv6, &gpu_dv6);
              ix = c_cpu_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel15<<<grid, block>>>(q_gpu_y, ix, gpu_dv6);
                dv6_dirtyOnGpu = true;
              }

              if (cpu_dv3->size[1] == cpu_dv6->size[1]) {
                j = cpu_fx->size[0] * cpu_fx->size[1];
                cpu_fx->size[0] = 1;
                cpu_fx->size[1] = cpu_dv3->size[1];
                emxEnsureCapacity_real_T(cpu_fx, j, &ab_emlrtRTEI);
                if (!fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_fx, &e_gpu_fx);
                }

                ix = cpu_dv3->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (ix + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_fx, cpu_fx);
                  }

                  ec_cwtAvg_kernel16<<<grid, block>>>(e_gpu_xt, gpu_dv6, gpu_dv3,
                    ix, e_gpu_fx);
                  fx_dirtyOnGpu = true;
                  fx_dirtyOnCpu = false;
                }
              } else {
                if (fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_fx, &e_gpu_fx);
                }

                if (dv3_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv3, &gpu_dv3);
                }

                dv3_dirtyOnGpu = false;
                if (dv6_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv6, &gpu_dv6);
                }

                dv6_dirtyOnGpu = false;
                if (xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_xt, &e_gpu_xt);
                }

                xt_dirtyOnGpu = false;
                b_binary_expand_op(cpu_fx, cpu_dv3, cpu_dv6, cpu_xt);
                fx_dirtyOnCpu = true;
                fx_dirtyOnGpu = false;
              }

              r = 0.0;
              ix = -1;
              for (vstride = 0; vstride < nsubs; vstride++) {
                fc = 0.0;
                b_r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(cpu_fx, &e_gpu_fx);
                  }

                  fc += dv4[j] * cpu_fx->data[(ix + j) + 1];
                  fx_dirtyOnGpu = false;
                  b_r += dv5[j] * cpu_fx->data[(ix + j) + 1];
                }

                ix += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (cpu_subs[(vstride << 1) + 1] - cpu_subs[vstride << 1]) /
                  2.0;
                fc *= halfh;
                qsub[vstride] = fc;
                r += fc;
                errsub[vstride] = b_r * halfh;
              }

              intDsq = r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              r = 2.0 * tol;
              b_r = 0.0;
              nbytes = 0;
              for (vstride = 0; vstride < nsubs; vstride++) {
                fc = errsub[vstride];
                halfh = std::abs(fc);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= r * ((cpu_subs[(vstride << 1) + 1] -
                                   cpu_subs[vstride << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[vstride];
                } else {
                  b_r += halfh;
                  nbytes++;
                  cpu_subs[(nbytes - 1) << 1] = cpu_subs[vstride << 1];
                  cpu_subs[((nbytes - 1) << 1) + 1] = cpu_subs[(vstride << 1) +
                    1];
                  subs_dirtyOnCpu = true;
                }
              }

              r = std::abs(err_ok) + b_r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(r)) && (!std::isnan(r))) && (nbytes != 0) && (!(r <=
                    tol))) {
                nsubs = nbytes << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (vstride = 0; vstride < nbytes; vstride++) {
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    cpu_subs[((((nbytes - vstride) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nbytes - vstride) - 1) << 1) + 1];
                    cpu_subs[(((nbytes - vstride) << 1) - 1) << 1] = (cpu_subs
                      [((nbytes - vstride) - 1) << 1] + cpu_subs[(((nbytes -
                      vstride) - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nbytes - vstride) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nbytes - vstride) << 1) - 1) << 1];
                    cpu_subs[(((nbytes - vstride) << 1) - 2) << 1] = cpu_subs
                      [((nbytes - vstride) - 1) << 1];
                    subs_dirtyOnCpu = true;
                    subs_dirtyOnGpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&cpu_dv6);
          emxFree_real_T(&c_cpu_y);
          emxFree_real_T(&cpu_dv3);
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

        ec_cwtAvg_kernel18<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ec_cwtAvg_kernel19<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        intFsq = 0.0;
        vstride = 1;
        cudaMemcpy(cpu_interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        pathlen = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (pathlen > 0) {
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

          vstride = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        nbytes = 0;
        for (acoef = 0; acoef < vstride; acoef++) {
          if (std::abs(cpu_interval[acoef + 1] - cpu_interval[nbytes]) > 0.0) {
            nbytes++;
            cpu_interval[nbytes] = cpu_interval[acoef + 1];
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

          ec_cwtAvg_kernel20<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(vstride,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
          intFsq = rtNaN;
        } else {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                         cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, cpu_subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ec_cwtAvg_kernel21<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnGpu = true;
            subs_dirtyOnCpu = false;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&d_cpu_x, 2, &g_emlrtRTEI, true);
          emxInit_real_T(&e_cpu_x, 2, &fc_emlrtRTEI, true);
          emxInit_real_T(&b_cpu_xt, 2, &gc_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv9, 2, &mc_emlrtRTEI, true);
          emxInit_real_T(&b_cpu_fx, 2, &xb_emlrtRTEI, true);
          emxInit_real_T(&f_cpu_y, 2, &nc_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv11, 2, &mc_emlrtRTEI, true);
          do {
            exitg1 = 0;
            j = d_cpu_x->size[0] * d_cpu_x->size[1];
            d_cpu_x->size[0] = 1;
            d_cpu_x->size[1] = 15 * nsubs;
            emxEnsureCapacity_real_T(d_cpu_x, j, &g_emlrtRTEI);
            if (!c_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(d_cpu_x, &l_gpu_x);
            }

            ix = -1;
            for (vstride = 0; vstride < nsubs; vstride++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fc = cpu_subs[vstride << 1];
              subs_dirtyOnGpu = false;
              b_r = cpu_subs[(vstride << 1) + 1];
              r = (fc + b_r) / 2.0;
              halfh = (b_r - fc) / 2.0;
              for (j = 0; j < 15; j++) {
                d_cpu_x->data[(ix + j) + 1] = NODES[j] * halfh + r;
                c_x_dirtyOnCpu = true;
              }

              ix += 15;
            }

            j = e_cpu_x->size[0] * e_cpu_x->size[1];
            e_cpu_x->size[0] = 1;
            e_cpu_x->size[1] = d_cpu_x->size[1];
            emxEnsureCapacity_real_T(e_cpu_x, j, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(e_cpu_x, &m_gpu_x);
            j = b_cpu_xt->size[0] * b_cpu_xt->size[1];
            b_cpu_xt->size[0] = 1;
            b_cpu_xt->size[1] = d_cpu_x->size[1];
            emxEnsureCapacity_real_T(b_cpu_xt, j, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_cpu_xt, &d_gpu_xt);
            nbytes = d_cpu_x->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nbytes), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_x, d_cpu_x);
              }

              c_x_dirtyOnCpu = false;
              ec_cwtAvg_kernel22<<<grid, block>>>(l_gpu_x, nbytes, d_gpu_xt,
                m_gpu_x);
              b_x_dirtyOnGpu = true;
              b_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (b_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(e_cpu_x, &m_gpu_x);
              }

              b_x_dirtyOnGpu = false;
              r = std::abs(e_cpu_x->data[0]);
              vstride = 0;
              exitg2 = false;
              while ((!exitg2) && (vstride <= e_cpu_x->size[1] - 2)) {
                tol = r;
                r = std::abs(e_cpu_x->data[vstride + 1]);
                if (std::abs(e_cpu_x->data[vstride + 1] - e_cpu_x->data[vstride])
                    <= 2.2204460492503131E-14 * std::fmax(tol, r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  vstride++;
                }
              }

              if (first_iteration) {
                dv2_idx_1 = static_cast<int16_T>(d_cpu_x->size[1]);
                j = b_cpu_fx->size[0] * b_cpu_fx->size[1];
                b_cpu_fx->size[0] = 1;
                b_cpu_fx->size[1] = d_cpu_x->size[1];
                emxEnsureCapacity_real_T(b_cpu_fx, j, &m_emlrtRTEI);
                if (!b_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(b_cpu_fx, &d_gpu_fx);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (dv2_idx_1), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_fx, b_cpu_fx);
                  }

                  ec_cwtAvg_kernel27<<<grid, block>>>(dv2_idx_1, d_gpu_fx);
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
              j = cpu_dv9->size[0] * cpu_dv9->size[1];
              cpu_dv9->size[0] = 1;
              cpu_dv9->size[1] = e_cpu_x->size[1];
              emxEnsureCapacity_real_T(cpu_dv9, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv9, &gpu_dv9);
              vstride = e_cpu_x->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel23<<<grid, block>>>(m_gpu_x, vstride, gpu_dv9);
                dv9_dirtyOnGpu = true;
              }

              j = f_cpu_y->size[0] * f_cpu_y->size[1];
              f_cpu_y->size[0] = 1;
              f_cpu_y->size[1] = e_cpu_x->size[1];
              emxEnsureCapacity_real_T(f_cpu_y, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(f_cpu_y, &n_gpu_y);
              vstride = e_cpu_x->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel24<<<grid, block>>>(m_gpu_x, vstride, n_gpu_y);
              }

              j = cpu_dv11->size[0] * cpu_dv11->size[1];
              cpu_dv11->size[0] = 1;
              cpu_dv11->size[1] = f_cpu_y->size[1];
              emxEnsureCapacity_real_T(cpu_dv11, j, &x_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv11, &gpu_dv11);
              ix = f_cpu_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel25<<<grid, block>>>(n_gpu_y, ix, gpu_dv11);
                dv11_dirtyOnGpu = true;
              }

              if (cpu_dv9->size[1] == cpu_dv11->size[1]) {
                j = b_cpu_fx->size[0] * b_cpu_fx->size[1];
                b_cpu_fx->size[0] = 1;
                b_cpu_fx->size[1] = cpu_dv9->size[1];
                emxEnsureCapacity_real_T(b_cpu_fx, j, &ab_emlrtRTEI);
                if (!b_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(b_cpu_fx, &d_gpu_fx);
                }

                ix = cpu_dv9->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (ix + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_fx, b_cpu_fx);
                  }

                  ec_cwtAvg_kernel26<<<grid, block>>>(d_gpu_xt, gpu_dv11,
                    gpu_dv9, ix, d_gpu_fx);
                  b_fx_dirtyOnGpu = true;
                  b_fx_dirtyOnCpu = false;
                }
              } else {
                if (b_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_cpu_fx, &d_gpu_fx);
                }

                if (dv9_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv9, &gpu_dv9);
                }

                dv9_dirtyOnGpu = false;
                if (dv11_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv11, &gpu_dv11);
                }

                dv11_dirtyOnGpu = false;
                if (b_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_cpu_xt, &d_gpu_xt);
                }

                b_xt_dirtyOnGpu = false;
                b_binary_expand_op(b_cpu_fx, cpu_dv9, cpu_dv11, b_cpu_xt);
                b_fx_dirtyOnCpu = true;
                b_fx_dirtyOnGpu = false;
              }

              r = 0.0;
              ix = -1;
              for (vstride = 0; vstride < nsubs; vstride++) {
                fc = 0.0;
                b_r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (b_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(b_cpu_fx, &d_gpu_fx);
                  }

                  fc += dv4[j] * b_cpu_fx->data[(ix + j) + 1];
                  b_fx_dirtyOnGpu = false;
                  b_r += dv5[j] * b_cpu_fx->data[(ix + j) + 1];
                }

                ix += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (cpu_subs[(vstride << 1) + 1] - cpu_subs[vstride << 1]) /
                  2.0;
                fc *= halfh;
                qsub[vstride] = fc;
                r += fc;
                errsub[vstride] = b_r * halfh;
              }

              intFsq = r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              r = 2.0 * tol;
              b_r = 0.0;
              nbytes = 0;
              for (vstride = 0; vstride < nsubs; vstride++) {
                fc = errsub[vstride];
                halfh = std::abs(fc);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= r * ((cpu_subs[(vstride << 1) + 1] -
                                   cpu_subs[vstride << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[vstride];
                } else {
                  b_r += halfh;
                  nbytes++;
                  cpu_subs[(nbytes - 1) << 1] = cpu_subs[vstride << 1];
                  cpu_subs[((nbytes - 1) << 1) + 1] = cpu_subs[(vstride << 1) +
                    1];
                  subs_dirtyOnCpu = true;
                }
              }

              r = std::abs(err_ok) + b_r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(r)) && (!std::isnan(r))) && (nbytes != 0) && (!(r <=
                    tol))) {
                nsubs = nbytes << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (vstride = 0; vstride < nbytes; vstride++) {
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    cpu_subs[((((nbytes - vstride) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nbytes - vstride) - 1) << 1) + 1];
                    cpu_subs[(((nbytes - vstride) << 1) - 1) << 1] = (cpu_subs
                      [((nbytes - vstride) - 1) << 1] + cpu_subs[(((nbytes -
                      vstride) - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nbytes - vstride) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nbytes - vstride) << 1) - 1) << 1];
                    cpu_subs[(((nbytes - vstride) << 1) - 2) << 1] = cpu_subs
                      [((nbytes - vstride) - 1) << 1];
                    subs_dirtyOnCpu = true;
                    subs_dirtyOnGpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&cpu_dv11);
          emxFree_real_T(&f_cpu_y);
          emxFree_real_T(&b_cpu_fx);
          emxFree_real_T(&cpu_dv9);
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

    b_r = static_cast<real_T>(cpu_x->size[0]) / (b_r * 2.0);
    first_iteration = false;
    acoef = 0;
    do {
      exitg1 = 0;
      if (acoef + 1 < 6) {
        if (cpu_wav[acoef] != cv4[acoef]) {
          exitg1 = 1;
        } else {
          acoef++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      ix = 0;
    } else {
      ix = -1;
    }

    if (ix == 0) {
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
        r = 1.0 - 0.0050536085896138528 * rt_powd_snf(cf, 20.0) * std::exp
          (-rt_powd_snf(cf, 3.0));
        intFsq = 1.0;
        if (r == 0.0) {
          omegac = cf;
        } else {
          fc = 1.0;
          intDsq = 9.0856029641606977;
          q_ok = 0.0;
          err_ok = 0.0;
          exitg2 = false;
          while ((!exitg2) && ((intFsq != 0.0) && (a != omegac))) {
            if ((intFsq > 0.0) == (fc > 0.0)) {
              intDsq = a;
              fc = r;
              err_ok = omegac - a;
              q_ok = err_ok;
            }

            if (std::abs(fc) < std::abs(intFsq)) {
              a = omegac;
              omegac = intDsq;
              intDsq = a;
              r = intFsq;
              intFsq = fc;
              fc = r;
            }

            m = 0.5 * (intDsq - omegac);
            toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(m) <= toler) || (intFsq == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(q_ok) < toler) || (std::abs(r) <= std::abs(intFsq)))
              {
                err_ok = m;
                q_ok = m;
              } else {
                s = intFsq / r;
                if (a == intDsq) {
                  r = 2.0 * m * s;
                  halfh = 1.0 - s;
                } else {
                  halfh = r / fc;
                  c_r = intFsq / fc;
                  r = s * (2.0 * m * halfh * (halfh - c_r) - (omegac - a) * (c_r
                            - 1.0));
                  halfh = (halfh - 1.0) * (c_r - 1.0) * (s - 1.0);
                }

                if (r > 0.0) {
                  halfh = -halfh;
                } else {
                  r = -r;
                }

                if ((2.0 * r < 3.0 * m * halfh - std::abs(toler * halfh)) && (r <
                     std::abs(0.5 * q_ok * halfh))) {
                  q_ok = err_ok;
                  err_ok = r / halfh;
                } else {
                  err_ok = m;
                  q_ok = m;
                }
              }

              a = omegac;
              r = intFsq;
              if (std::abs(err_ok) > toler) {
                omegac += err_ok;
              } else if (omegac > intDsq) {
                omegac -= toler;
              } else {
                omegac += toler;
              }

              intFsq = 1.0 - 0.0050536085896138528 * rt_powd_snf(omegac, 20.0) *
                std::exp(-rt_powd_snf(omegac, 3.0));
            }
          }
        }
      }
    }

    r = omegac / 3.1415926535897931;
    if (b_r < r * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave)) {
      b_r = r * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave);
    }

    r = 1.0 / (b_r * (6.2831853071795862 / cf)) * fs;
    if (cpu_fLims[0] < r) {
      ec_cwtAvg_kernel28<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(r,
        *gpu_freqrange, *gpu_fLims);
      cudaMemcpy(cpu_fLims, *gpu_fLims, 16UL, cudaMemcpyDeviceToHost);
    }

    if (cpu_fLims[1] > fs / 2.0) {
      ec_cwtAvg_kernel29<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs,
        *gpu_freqrange, *gpu_fLims);
    }

    cudaMemcpy(cpu_freqrange, *gpu_freqrange, 16UL, cudaMemcpyDeviceToHost);
    if (cpu_freqrange[1] == 0.0) {
      b_r = rtMinusInf;
    } else if (cpu_freqrange[1] < 0.0) {
      b_r = rtNaN;
    } else if ((!std::isinf(cpu_freqrange[1])) && (!std::isnan(cpu_freqrange[1])))
    {
      r = std::frexp(cpu_freqrange[1], &bcoef);
      if (r == 0.5) {
        b_r = static_cast<real_T>(bcoef) - 1.0;
      } else if ((bcoef == 1) && (r < 0.75)) {
        b_r = std::log(2.0 * r) / 0.69314718055994529;
      } else {
        b_r = std::log(r) / 0.69314718055994529 + static_cast<real_T>(bcoef);
      }
    } else {
      b_r = cpu_freqrange[1];
    }

    if ((!std::isinf(cpu_freqrange[0])) && (!std::isnan(cpu_freqrange[0]))) {
      r = std::frexp(cpu_freqrange[0], &eint);
      if (r == 0.5) {
        r = static_cast<real_T>(eint) - 1.0;
      } else if ((eint == 1) && (r < 0.75)) {
        r = std::log(2.0 * r) / 0.69314718055994529;
      } else {
        r = std::log(r) / 0.69314718055994529 + static_cast<real_T>(eint);
      }
    } else {
      r = cpu_freqrange[0];
    }

    if (!(b_r - r >= 1.0 / fb_VoicesPerOctave)) {
      r = 1.0 / fb_VoicesPerOctave;
      nbytes = (int32_T)emlrtMexSnprintf(nullptr, 0, "%2.2f", r) + 1;
      emxInit_char_T(&b_str, 2, &ub_emlrtRTEI, true);
      j = b_str->size[0] * b_str->size[1];
      b_str->size[0] = 1;
      b_str->size[1] = nbytes;
      emxEnsureCapacity_char_T(b_str, j, &b_emlrtRTEI);
      emlrtMexSnprintf(&b_str->data[0], (size_t)nbytes, "%2.2f", r);
      emxFree_char_T(&b_str);
    }
  }

  first_iteration = false;
  acoef = 0;
  do {
    exitg1 = 0;
    if (acoef + 1 < 6) {
      if (cpu_cv[static_cast<int32_T>(b[acoef])] != cpu_cv[static_cast<int32_T>
          (cv3[acoef])]) {
        exitg1 = 1;
      } else {
        acoef++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (!first_iteration) {
    fb_CutOff = 10;
  }

  N = static_cast<uint32_T>(cpu_x->size[0]) + static_cast<uint32_T>(static_cast<
    int32_T>(y) << 1);
  nbytes = static_cast<int32_T>(std::trunc(static_cast<real_T>(N) / 2.0));
  emxInit_real_T(&cpu_omega, 2, &c_emlrtRTEI, true);
  if (nbytes < 1) {
    cpu_omega->size[1] = 0;
  } else {
    j = cpu_omega->size[0] * cpu_omega->size[1];
    cpu_omega->size[0] = 1;
    cpu_omega->size[1] = nbytes;
    emxEnsureCapacity_real_T(cpu_omega, j, &c_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_omega, &gpu_omega);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nbytes),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel30<<<grid, block>>>(nbytes, gpu_omega);
      omega_dirtyOnGpu = true;
    }
  }

  j = cpu_omega->size[0] * cpu_omega->size[1];
  cpu_omega->size[0] = 1;
  emxEnsureCapacity_real_T(cpu_omega, j, &d_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_omega, &gpu_omega);
  j = cpu_omega->size[1] - 1;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(j + 1L), &grid,
    &block, 1024U, 65535U);
  if (validLaunchParams) {
    ec_cwtAvg_kernel31<<<grid, block>>>(N, j, gpu_omega);
    omega_dirtyOnGpu = true;
  }

  nbytes = static_cast<int32_T>(std::trunc((static_cast<real_T>(N) - 1.0) / 2.0));
  if (nbytes < 1) {
    vstride = 0;
    nbytes = 1;
    bcoef = -1;
  } else {
    vstride = nbytes - 1;
    nbytes = -1;
    bcoef = 0;
  }

  emxInit_real_T(&cpu_r, 2, &e_emlrtRTEI, true);
  j = cpu_r->size[0] * cpu_r->size[1];
  cpu_r->size[0] = 1;
  cpu_r->size[1] = (cpu_omega->size[1] + div_s32(bcoef - vstride, nbytes)) + 2;
  emxEnsureCapacity_real_T(cpu_r, j, &e_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_r, &gpu_r);
  ec_cwtAvg_kernel32<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_r);
  pathlen = cpu_omega->size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(pathlen),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ec_cwtAvg_kernel33<<<grid, block>>>(gpu_omega, pathlen, gpu_r);
  }

  pathlen = div_s32(bcoef - vstride, nbytes);
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(pathlen + 1L),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ec_cwtAvg_kernel34<<<grid, block>>>(nbytes, vstride, gpu_omega, pathlen,
      gpu_r, cpu_omega->size[1U]);
  }

  j = cpu_omega->size[0] * cpu_omega->size[1];
  cpu_omega->size[0] = 1;
  cpu_omega->size[1] = cpu_r->size[1];
  emxEnsureCapacity_real_T(cpu_omega, j, &f_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_omega, &gpu_omega);
  ix = cpu_r->size[1] - 1;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ec_cwtAvg_kernel35<<<grid, block>>>(gpu_r, ix, gpu_omega);
    omega_dirtyOnGpu = true;
  }

  emxFree_real_T(&cpu_r);
  ec_cwtAvg_kernel36<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_fLims, *gpu_b);
  b_dirtyOnGpu = true;
  first_iteration = true;
  vstride = 0;
  exitg2 = false;
  while ((!exitg2) && (vstride < 2)) {
    if (b_dirtyOnGpu) {
      cudaMemcpy(cpu_b, *gpu_b, 2UL, cudaMemcpyDeviceToHost);
    }

    b_dirtyOnGpu = false;
    if (!cpu_b[vstride]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      vstride++;
    }
  }

  emxInit_real_T(&cpu_fb_Scales, 2, &l_emlrtRTEI, true);
  if (!first_iteration) {
    ec_cwtAvg_kernel64<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs, *gpu_fLims, *
      gpu_NyquistRange);
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
      r = std::frexp(r, &b_eint);
      if (r == 0.5) {
        r = static_cast<real_T>(b_eint) - 1.0;
      } else if ((b_eint == 1) && (r < 0.75)) {
        r = std::log(2.0 * r) / 0.69314718055994529;
      } else {
        r = std::log(r) / 0.69314718055994529 + static_cast<real_T>(b_eint);
      }
    }

    emxInit_real_T(&d_cpu_y, 2, &vb_emlrtRTEI, true);
    r *= fb_VoicesPerOctave;
    if (std::isnan(r)) {
      j = d_cpu_y->size[0] * d_cpu_y->size[1];
      d_cpu_y->size[0] = 1;
      d_cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(d_cpu_y, j, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(d_cpu_y, &gpu_y);
      d_cpu_y->data[0] = rtNaN;
      y_dirtyOnCpu = true;
    } else if (r < 0.0) {
      d_cpu_y->size[0] = 1;
      d_cpu_y->size[1] = 0;
    } else {
      j = d_cpu_y->size[0] * d_cpu_y->size[1];
      d_cpu_y->size[0] = 1;
      d_cpu_y->size[1] = static_cast<int32_T>(r) + 1;
      emxEnsureCapacity_real_T(d_cpu_y, j, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(d_cpu_y, &gpu_y);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
        static_cast<int64_T>(r) + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_cwtAvg_kernel65<<<grid, block>>>(r, gpu_y);
      }
    }

    emxInit_real_T(&e_cpu_y, 2, &wb_emlrtRTEI, true);
    j = e_cpu_y->size[0] * e_cpu_y->size[1];
    e_cpu_y->size[0] = 1;
    e_cpu_y->size[1] = d_cpu_y->size[1];
    emxEnsureCapacity_real_T(e_cpu_y, j, &k_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(e_cpu_y, &b_gpu_y);
    vstride = d_cpu_y->size[1];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vstride),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (y_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_y, d_cpu_y);
      }

      ec_cwtAvg_kernel66<<<grid, block>>>(gpu_y, rt_powd_snf(2.0, 1.0 /
        fb_VoicesPerOctave), vstride, b_gpu_y);
    }

    emxFree_real_T(&d_cpu_y);
    j = cpu_fb_Scales->size[0] * cpu_fb_Scales->size[1];
    cpu_fb_Scales->size[0] = 1;
    cpu_fb_Scales->size[1] = e_cpu_y->size[1];
    emxEnsureCapacity_real_T(cpu_fb_Scales, j, &l_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales);
    ix = e_cpu_y->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel67<<<grid, block>>>(b_gpu_y, halfh, ix, gpu_fb_Scales);
      fb_Scales_dirtyOnGpu = true;
    }

    emxFree_real_T(&e_cpu_y);
  } else {
    ec_cwtAvg_kernel37<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
      (*cpu_cv_gpu_clone, *gpu_wav, b[0], b[1], b[2], b[3], b[4]);
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
      r = 0.0057083835261;
      b_r = 0.0057083835261;
      for (vstride = 0; vstride < 6; vstride++) {
        fc = c[vstride];
        c_r = c_r * 0.005353955978584176 + fc;
        r = r * 0.005353955978584176 + fc;
        b_r = b_r * 0.005353955978584176 + fc;
      }

      c_r /= 13.666666666666666;
      r /= 13.666666666666666;
      b_r /= 13.666666666666666;
      b_r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((c_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(b_r) || std::isnan(b_r)) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, cpu_interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ec_cwtAvg_kernel38<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ec_cwtAvg_kernel39<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        intDsq = 0.0;
        vstride = 1;
        cudaMemcpy(cpu_interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        pathlen = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (pathlen > 0) {
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

          vstride = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        nbytes = 0;
        for (acoef = 0; acoef < vstride; acoef++) {
          if (std::abs(cpu_interval[acoef + 1] - cpu_interval[nbytes]) > 0.0) {
            nbytes++;
            cpu_interval[nbytes] = cpu_interval[acoef + 1];
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

          ec_cwtAvg_kernel40<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(vstride,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
          intDsq = rtNaN;
        } else {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                         cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, cpu_subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ec_cwtAvg_kernel41<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnGpu = true;
            subs_dirtyOnCpu = false;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          emxInit_real_T(&f_cpu_x, 2, &g_emlrtRTEI, true);
          emxInit_real_T(&g_cpu_x, 2, &fc_emlrtRTEI, true);
          emxInit_real_T(&c_cpu_xt, 2, &gc_emlrtRTEI, true);
          emxInit_real_T(&i_cpu_y, 2, &hc_emlrtRTEI, true);
          emxInit_real_T(&c_cpu_fx, 2, &xb_emlrtRTEI, true);
          emxInit_real_T(&j_cpu_y, 2, &ic_emlrtRTEI, true);
          emxInit_real_T(&b_cpu_a, 2, &q_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv10, 2, &kc_emlrtRTEI, true);
          emxInit_real_T(&k_cpu_y, 2, &lc_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv12, 2, &kc_emlrtRTEI, true);
          do {
            exitg1 = 0;
            j = f_cpu_x->size[0] * f_cpu_x->size[1];
            f_cpu_x->size[0] = 1;
            f_cpu_x->size[1] = 15 * nsubs;
            emxEnsureCapacity_real_T(f_cpu_x, j, &g_emlrtRTEI);
            if (!d_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(f_cpu_x, &j_gpu_x);
            }

            ix = -1;
            for (vstride = 0; vstride < nsubs; vstride++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fc = cpu_subs[vstride << 1];
              subs_dirtyOnGpu = false;
              b_r = cpu_subs[(vstride << 1) + 1];
              r = (fc + b_r) / 2.0;
              halfh = (b_r - fc) / 2.0;
              for (j = 0; j < 15; j++) {
                f_cpu_x->data[(ix + j) + 1] = NODES[j] * halfh + r;
                d_x_dirtyOnCpu = true;
              }

              ix += 15;
            }

            j = g_cpu_x->size[0] * g_cpu_x->size[1];
            g_cpu_x->size[0] = 1;
            g_cpu_x->size[1] = f_cpu_x->size[1];
            emxEnsureCapacity_real_T(g_cpu_x, j, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(g_cpu_x, &k_gpu_x);
            j = c_cpu_xt->size[0] * c_cpu_xt->size[1];
            c_cpu_xt->size[0] = 1;
            c_cpu_xt->size[1] = f_cpu_x->size[1];
            emxEnsureCapacity_real_T(c_cpu_xt, j, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(c_cpu_xt, &c_gpu_xt);
            nbytes = f_cpu_x->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nbytes), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (d_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_x, f_cpu_x);
              }

              d_x_dirtyOnCpu = false;
              ec_cwtAvg_kernel42<<<grid, block>>>(j_gpu_x, nbytes, c_gpu_xt,
                k_gpu_x);
              c_x_dirtyOnGpu = true;
              c_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (c_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(g_cpu_x, &k_gpu_x);
              }

              c_x_dirtyOnGpu = false;
              r = std::abs(g_cpu_x->data[0]);
              vstride = 0;
              exitg2 = false;
              while ((!exitg2) && (vstride <= g_cpu_x->size[1] - 2)) {
                tol = r;
                r = std::abs(g_cpu_x->data[vstride + 1]);
                if (std::abs(g_cpu_x->data[vstride + 1] - g_cpu_x->data[vstride])
                    <= 2.2204460492503131E-14 * std::fmax(tol, r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  vstride++;
                }
              }

              if (first_iteration) {
                dv2_idx_1 = static_cast<int16_T>(f_cpu_x->size[1]);
                j = c_cpu_fx->size[0] * c_cpu_fx->size[1];
                c_cpu_fx->size[0] = 1;
                c_cpu_fx->size[1] = f_cpu_x->size[1];
                emxEnsureCapacity_real_T(c_cpu_fx, j, &m_emlrtRTEI);
                if (!c_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(c_cpu_fx, &c_gpu_fx);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (dv2_idx_1), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (c_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_fx, c_cpu_fx);
                  }

                  ec_cwtAvg_kernel50<<<grid, block>>>(dv2_idx_1, c_gpu_fx);
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
              j = i_cpu_y->size[0] * i_cpu_y->size[1];
              i_cpu_y->size[0] = 1;
              i_cpu_y->size[1] = g_cpu_x->size[1];
              emxEnsureCapacity_real_T(i_cpu_y, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(i_cpu_y, &k_gpu_y);
              vstride = g_cpu_x->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel43<<<grid, block>>>(k_gpu_x, vstride, k_gpu_y);
                c_y_dirtyOnGpu = true;
              }

              j = j_cpu_y->size[0] * j_cpu_y->size[1];
              j_cpu_y->size[0] = 1;
              j_cpu_y->size[1] = g_cpu_x->size[1];
              emxEnsureCapacity_real_T(j_cpu_y, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(j_cpu_y, &l_gpu_y);
              vstride = g_cpu_x->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel44<<<grid, block>>>(k_gpu_x, vstride, l_gpu_y);
                d_y_dirtyOnGpu = true;
              }

              if (i_cpu_y->size[1] == j_cpu_y->size[1]) {
                j = b_cpu_a->size[0] * b_cpu_a->size[1];
                b_cpu_a->size[0] = 1;
                b_cpu_a->size[1] = i_cpu_y->size[1];
                emxEnsureCapacity_real_T(b_cpu_a, j, &q_emlrtRTEI);
                if (!b_a_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(b_cpu_a, &c_gpu_a);
                }

                ix = i_cpu_y->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (ix + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_a_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_a, b_cpu_a);
                  }

                  ec_cwtAvg_kernel45<<<grid, block>>>(l_gpu_y, k_gpu_y, ix,
                    c_gpu_a);
                  b_a_dirtyOnGpu = true;
                  b_a_dirtyOnCpu = false;
                }
              } else {
                if (b_a_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_cpu_a, &c_gpu_a);
                }

                if (c_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(i_cpu_y, &k_gpu_y);
                }

                c_y_dirtyOnGpu = false;
                if (d_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(j_cpu_y, &l_gpu_y);
                }

                d_y_dirtyOnGpu = false;
                c_binary_expand_op(b_cpu_a, i_cpu_y, j_cpu_y);
                b_a_dirtyOnCpu = true;
                b_a_dirtyOnGpu = false;
              }

              j = cpu_dv10->size[0] * cpu_dv10->size[1];
              cpu_dv10->size[0] = 1;
              cpu_dv10->size[1] = b_cpu_a->size[1];
              emxEnsureCapacity_real_T(cpu_dv10, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv10, &gpu_dv10);
              vstride = b_cpu_a->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_a, b_cpu_a);
                }

                b_a_dirtyOnCpu = false;
                ec_cwtAvg_kernel46<<<grid, block>>>(c_gpu_a, vstride, gpu_dv10);
                dv10_dirtyOnGpu = true;
              }

              j = k_cpu_y->size[0] * k_cpu_y->size[1];
              k_cpu_y->size[0] = 1;
              k_cpu_y->size[1] = g_cpu_x->size[1];
              emxEnsureCapacity_real_T(k_cpu_y, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(k_cpu_y, &m_gpu_y);
              vstride = g_cpu_x->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel47<<<grid, block>>>(k_gpu_x, vstride, m_gpu_y);
              }

              j = cpu_dv12->size[0] * cpu_dv12->size[1];
              cpu_dv12->size[0] = 1;
              cpu_dv12->size[1] = k_cpu_y->size[1];
              emxEnsureCapacity_real_T(cpu_dv12, j, &w_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv12, &gpu_dv12);
              ix = k_cpu_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel48<<<grid, block>>>(m_gpu_y, ix, gpu_dv12);
                dv12_dirtyOnGpu = true;
              }

              if (cpu_dv10->size[1] == cpu_dv12->size[1]) {
                j = c_cpu_fx->size[0] * c_cpu_fx->size[1];
                c_cpu_fx->size[0] = 1;
                c_cpu_fx->size[1] = cpu_dv10->size[1];
                emxEnsureCapacity_real_T(c_cpu_fx, j, &ab_emlrtRTEI);
                if (!c_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(c_cpu_fx, &c_gpu_fx);
                }

                ix = cpu_dv10->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (ix + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (c_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_fx, c_cpu_fx);
                  }

                  ec_cwtAvg_kernel49<<<grid, block>>>(c_gpu_xt, gpu_dv12,
                    gpu_dv10, ix, c_gpu_fx);
                  c_fx_dirtyOnGpu = true;
                  c_fx_dirtyOnCpu = false;
                }
              } else {
                if (c_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_cpu_fx, &c_gpu_fx);
                }

                if (dv10_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv10, &gpu_dv10);
                }

                dv10_dirtyOnGpu = false;
                if (dv12_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv12, &gpu_dv12);
                }

                dv12_dirtyOnGpu = false;
                if (c_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_cpu_xt, &c_gpu_xt);
                }

                c_xt_dirtyOnGpu = false;
                b_binary_expand_op(c_cpu_fx, cpu_dv10, cpu_dv12, c_cpu_xt);
                c_fx_dirtyOnCpu = true;
                c_fx_dirtyOnGpu = false;
              }

              r = 0.0;
              ix = -1;
              for (vstride = 0; vstride < nsubs; vstride++) {
                fc = 0.0;
                b_r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (c_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(c_cpu_fx, &c_gpu_fx);
                  }

                  fc += dv4[j] * c_cpu_fx->data[(ix + j) + 1];
                  c_fx_dirtyOnGpu = false;
                  b_r += dv5[j] * c_cpu_fx->data[(ix + j) + 1];
                }

                ix += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (cpu_subs[(vstride << 1) + 1] - cpu_subs[vstride << 1]) /
                  2.0;
                fc *= halfh;
                qsub[vstride] = fc;
                r += fc;
                errsub[vstride] = b_r * halfh;
              }

              intDsq = r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              r = 2.0 * tol;
              b_r = 0.0;
              nbytes = 0;
              for (vstride = 0; vstride < nsubs; vstride++) {
                fc = errsub[vstride];
                halfh = std::abs(fc);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= r * ((cpu_subs[(vstride << 1) + 1] -
                                   cpu_subs[vstride << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[vstride];
                } else {
                  b_r += halfh;
                  nbytes++;
                  cpu_subs[(nbytes - 1) << 1] = cpu_subs[vstride << 1];
                  cpu_subs[((nbytes - 1) << 1) + 1] = cpu_subs[(vstride << 1) +
                    1];
                  subs_dirtyOnCpu = true;
                }
              }

              r = std::abs(err_ok) + b_r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(r)) && (!std::isnan(r))) && (nbytes != 0) && (!(r <=
                    tol))) {
                nsubs = nbytes << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (vstride = 0; vstride < nbytes; vstride++) {
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    cpu_subs[((((nbytes - vstride) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nbytes - vstride) - 1) << 1) + 1];
                    cpu_subs[(((nbytes - vstride) << 1) - 1) << 1] = (cpu_subs
                      [((nbytes - vstride) - 1) << 1] + cpu_subs[(((nbytes -
                      vstride) - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nbytes - vstride) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nbytes - vstride) << 1) - 1) << 1];
                    cpu_subs[(((nbytes - vstride) << 1) - 2) << 1] = cpu_subs
                      [((nbytes - vstride) - 1) << 1];
                    subs_dirtyOnCpu = true;
                    subs_dirtyOnGpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&cpu_dv12);
          emxFree_real_T(&k_cpu_y);
          emxFree_real_T(&cpu_dv10);
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

        ec_cwtAvg_kernel51<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ec_cwtAvg_kernel52<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        intFsq = 0.0;
        vstride = 1;
        cudaMemcpy(cpu_interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        pathlen = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            acoef = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_dirtyOnCpu = true;
            r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (j = 0; j < acoef; j++) {
              cpu_interval[n_idx_0 - j] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - j) * r;
            }
          }

          vstride = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        nbytes = 0;
        for (acoef = 0; acoef < vstride; acoef++) {
          if (std::abs(cpu_interval[acoef + 1] - cpu_interval[nbytes]) > 0.0) {
            nbytes++;
            cpu_interval[nbytes] = cpu_interval[acoef + 1];
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

          ec_cwtAvg_kernel53<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(vstride,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
          intFsq = rtNaN;
        } else {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                         cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, cpu_subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ec_cwtAvg_kernel54<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnGpu = true;
            subs_dirtyOnCpu = false;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&h_cpu_x, 2, &g_emlrtRTEI, true);
          emxInit_real_T(&i_cpu_x, 2, &fc_emlrtRTEI, true);
          emxInit_real_T(&d_cpu_xt, 2, &gc_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv14, 2, &mc_emlrtRTEI, true);
          emxInit_real_T(&d_cpu_fx, 2, &xb_emlrtRTEI, true);
          emxInit_real_T(&l_cpu_y, 2, &nc_emlrtRTEI, true);
          emxInit_real_T(&cpu_dv17, 2, &mc_emlrtRTEI, true);
          do {
            exitg1 = 0;
            j = h_cpu_x->size[0] * h_cpu_x->size[1];
            h_cpu_x->size[0] = 1;
            h_cpu_x->size[1] = 15 * nsubs;
            emxEnsureCapacity_real_T(h_cpu_x, j, &g_emlrtRTEI);
            if (!e_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(h_cpu_x, &h_gpu_x);
            }

            ix = -1;
            for (vstride = 0; vstride < nsubs; vstride++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fc = cpu_subs[vstride << 1];
              subs_dirtyOnGpu = false;
              b_r = cpu_subs[(vstride << 1) + 1];
              r = (fc + b_r) / 2.0;
              halfh = (b_r - fc) / 2.0;
              for (j = 0; j < 15; j++) {
                h_cpu_x->data[(ix + j) + 1] = NODES[j] * halfh + r;
                e_x_dirtyOnCpu = true;
              }

              ix += 15;
            }

            j = i_cpu_x->size[0] * i_cpu_x->size[1];
            i_cpu_x->size[0] = 1;
            i_cpu_x->size[1] = h_cpu_x->size[1];
            emxEnsureCapacity_real_T(i_cpu_x, j, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(i_cpu_x, &i_gpu_x);
            j = d_cpu_xt->size[0] * d_cpu_xt->size[1];
            d_cpu_xt->size[0] = 1;
            d_cpu_xt->size[1] = h_cpu_x->size[1];
            emxEnsureCapacity_real_T(d_cpu_xt, j, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_cpu_xt, &b_gpu_xt);
            nbytes = h_cpu_x->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nbytes), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (e_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_x, h_cpu_x);
              }

              e_x_dirtyOnCpu = false;
              ec_cwtAvg_kernel55<<<grid, block>>>(h_gpu_x, nbytes, b_gpu_xt,
                i_gpu_x);
              d_x_dirtyOnGpu = true;
              d_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (d_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_cpu_x, &i_gpu_x);
              }

              d_x_dirtyOnGpu = false;
              r = std::abs(i_cpu_x->data[0]);
              vstride = 0;
              exitg2 = false;
              while ((!exitg2) && (vstride <= i_cpu_x->size[1] - 2)) {
                tol = r;
                r = std::abs(i_cpu_x->data[vstride + 1]);
                if (std::abs(i_cpu_x->data[vstride + 1] - i_cpu_x->data[vstride])
                    <= 2.2204460492503131E-14 * std::fmax(tol, r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  vstride++;
                }
              }

              if (first_iteration) {
                dv2_idx_1 = static_cast<int16_T>(h_cpu_x->size[1]);
                j = d_cpu_fx->size[0] * d_cpu_fx->size[1];
                d_cpu_fx->size[0] = 1;
                d_cpu_fx->size[1] = h_cpu_x->size[1];
                emxEnsureCapacity_real_T(d_cpu_fx, j, &m_emlrtRTEI);
                if (!d_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_cpu_fx, &b_gpu_fx);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (dv2_idx_1), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (d_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_fx, d_cpu_fx);
                  }

                  ec_cwtAvg_kernel60<<<grid, block>>>(dv2_idx_1, b_gpu_fx);
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
              j = cpu_dv14->size[0] * cpu_dv14->size[1];
              cpu_dv14->size[0] = 1;
              cpu_dv14->size[1] = i_cpu_x->size[1];
              emxEnsureCapacity_real_T(cpu_dv14, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv14, &gpu_dv14);
              vstride = i_cpu_x->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel56<<<grid, block>>>(i_gpu_x, vstride, gpu_dv14);
                dv14_dirtyOnGpu = true;
              }

              j = l_cpu_y->size[0] * l_cpu_y->size[1];
              l_cpu_y->size[0] = 1;
              l_cpu_y->size[1] = i_cpu_x->size[1];
              emxEnsureCapacity_real_T(l_cpu_y, j, &k_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(l_cpu_y, &j_gpu_y);
              vstride = i_cpu_x->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vstride), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel57<<<grid, block>>>(i_gpu_x, vstride, j_gpu_y);
              }

              j = cpu_dv17->size[0] * cpu_dv17->size[1];
              cpu_dv17->size[0] = 1;
              cpu_dv17->size[1] = l_cpu_y->size[1];
              emxEnsureCapacity_real_T(cpu_dv17, j, &x_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(cpu_dv17, &gpu_dv17);
              ix = l_cpu_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_cwtAvg_kernel58<<<grid, block>>>(j_gpu_y, ix, gpu_dv17);
                dv17_dirtyOnGpu = true;
              }

              if (cpu_dv14->size[1] == cpu_dv17->size[1]) {
                j = d_cpu_fx->size[0] * d_cpu_fx->size[1];
                d_cpu_fx->size[0] = 1;
                d_cpu_fx->size[1] = cpu_dv14->size[1];
                emxEnsureCapacity_real_T(d_cpu_fx, j, &ab_emlrtRTEI);
                if (!d_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_cpu_fx, &b_gpu_fx);
                }

                ix = cpu_dv14->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (ix + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (d_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_fx, d_cpu_fx);
                  }

                  ec_cwtAvg_kernel59<<<grid, block>>>(b_gpu_xt, gpu_dv17,
                    gpu_dv14, ix, b_gpu_fx);
                  d_fx_dirtyOnGpu = true;
                  d_fx_dirtyOnCpu = false;
                }
              } else {
                if (d_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_cpu_fx, &b_gpu_fx);
                }

                if (dv14_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv14, &gpu_dv14);
                }

                dv14_dirtyOnGpu = false;
                if (dv17_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_dv17, &gpu_dv17);
                }

                dv17_dirtyOnGpu = false;
                if (d_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_cpu_xt, &b_gpu_xt);
                }

                d_xt_dirtyOnGpu = false;
                b_binary_expand_op(d_cpu_fx, cpu_dv14, cpu_dv17, d_cpu_xt);
                d_fx_dirtyOnCpu = true;
                d_fx_dirtyOnGpu = false;
              }

              r = 0.0;
              ix = -1;
              for (vstride = 0; vstride < nsubs; vstride++) {
                fc = 0.0;
                b_r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (d_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(d_cpu_fx, &b_gpu_fx);
                  }

                  fc += dv4[j] * d_cpu_fx->data[(ix + j) + 1];
                  d_fx_dirtyOnGpu = false;
                  b_r += dv5[j] * d_cpu_fx->data[(ix + j) + 1];
                }

                ix += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                halfh = (cpu_subs[(vstride << 1) + 1] - cpu_subs[vstride << 1]) /
                  2.0;
                fc *= halfh;
                qsub[vstride] = fc;
                r += fc;
                errsub[vstride] = b_r * halfh;
              }

              intFsq = r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              r = 2.0 * tol;
              b_r = 0.0;
              nbytes = 0;
              for (vstride = 0; vstride < nsubs; vstride++) {
                fc = errsub[vstride];
                halfh = std::abs(fc);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                             cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (halfh <= r * ((cpu_subs[(vstride << 1) + 1] -
                                   cpu_subs[vstride << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[vstride];
                } else {
                  b_r += halfh;
                  nbytes++;
                  cpu_subs[(nbytes - 1) << 1] = cpu_subs[vstride << 1];
                  cpu_subs[((nbytes - 1) << 1) + 1] = cpu_subs[(vstride << 1) +
                    1];
                  subs_dirtyOnCpu = true;
                }
              }

              r = std::abs(err_ok) + b_r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(r)) && (!std::isnan(r))) && (nbytes != 0) && (!(r <=
                    tol))) {
                nsubs = nbytes << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (vstride = 0; vstride < nbytes; vstride++) {
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    cpu_subs[((((nbytes - vstride) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nbytes - vstride) - 1) << 1) + 1];
                    cpu_subs[(((nbytes - vstride) << 1) - 1) << 1] = (cpu_subs
                      [((nbytes - vstride) - 1) << 1] + cpu_subs[(((nbytes -
                      vstride) - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nbytes - vstride) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nbytes - vstride) << 1) - 1) << 1];
                    cpu_subs[(((nbytes - vstride) << 1) - 2) << 1] = cpu_subs
                      [((nbytes - vstride) - 1) << 1];
                    subs_dirtyOnCpu = true;
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
          emxFree_real_T(&cpu_dv14);
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

    tol = static_cast<real_T>(cpu_x->size[0]) / (b_r * 2.0);
    first_iteration = false;
    acoef = 0;
    do {
      exitg1 = 0;
      if (acoef + 1 < 6) {
        if (cpu_wav[acoef] != cv4[acoef]) {
          exitg1 = 1;
        } else {
          acoef++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      ix = 0;
    } else {
      ix = -1;
    }

    if (ix == 0) {
      b_r = 2.0 * (static_cast<real_T>(fb_CutOff) / 100.0);
      if (b_r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
          (-rt_powd_snf(a, 3.0)) >= 0.0) {
        if (b_r == b_r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
            (-rt_powd_snf(a, 3.0))) {
          omegac = 9.0856029641606977;
        } else {
          omegac = a;
        }
      } else {
        omegac = 9.0856029641606977;
        r = b_r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
          (-rt_powd_snf(a, 3.0));
        intFsq = b_r;
        if (r == 0.0) {
          omegac = a;
        } else {
          fc = b_r;
          intDsq = 9.0856029641606977;
          q_ok = 0.0;
          err_ok = 0.0;
          exitg2 = false;
          while ((!exitg2) && ((intFsq != 0.0) && (a != omegac))) {
            if ((intFsq > 0.0) == (fc > 0.0)) {
              intDsq = a;
              fc = r;
              err_ok = omegac - a;
              q_ok = err_ok;
            }

            if (std::abs(fc) < std::abs(intFsq)) {
              a = omegac;
              omegac = intDsq;
              intDsq = a;
              r = intFsq;
              intFsq = fc;
              fc = r;
            }

            m = 0.5 * (intDsq - omegac);
            toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(m) <= toler) || (intFsq == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(q_ok) < toler) || (std::abs(r) <= std::abs(intFsq)))
              {
                err_ok = m;
                q_ok = m;
              } else {
                s = intFsq / r;
                if (a == intDsq) {
                  r = 2.0 * m * s;
                  halfh = 1.0 - s;
                } else {
                  halfh = r / fc;
                  c_r = intFsq / fc;
                  r = s * (2.0 * m * halfh * (halfh - c_r) - (omegac - a) * (c_r
                            - 1.0));
                  halfh = (halfh - 1.0) * (c_r - 1.0) * (s - 1.0);
                }

                if (r > 0.0) {
                  halfh = -halfh;
                } else {
                  r = -r;
                }

                if ((2.0 * r < 3.0 * m * halfh - std::abs(toler * halfh)) && (r <
                     std::abs(0.5 * q_ok * halfh))) {
                  q_ok = err_ok;
                  err_ok = r / halfh;
                } else {
                  err_ok = m;
                  q_ok = m;
                }
              }

              a = omegac;
              r = intFsq;
              if (std::abs(err_ok) > toler) {
                omegac += err_ok;
              } else if (omegac > intDsq) {
                omegac -= toler;
              } else {
                omegac += toler;
              }

              intFsq = b_r - 0.0050536085896138528 * rt_powd_snf(omegac, 20.0) *
                std::exp(-rt_powd_snf(omegac, 3.0));
            }
          }
        }
      }
    }

    halfh = omegac / 3.1415926535897931;
    if (tol < halfh * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave)) {
      tol = halfh * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave);
    }

    tol /= halfh;
    if (tol == 0.0) {
      tol = rtMinusInf;
    } else if (tol < 0.0) {
      tol = rtNaN;
    } else if ((!std::isinf(tol)) && (!std::isnan(tol))) {
      tol = std::frexp(tol, &b_eint);
      if (tol == 0.5) {
        tol = static_cast<real_T>(b_eint) - 1.0;
      } else if ((b_eint == 1) && (tol < 0.75)) {
        tol = std::log(2.0 * tol) / 0.69314718055994529;
      } else {
        tol = std::log(tol) / 0.69314718055994529 + static_cast<real_T>(b_eint);
      }
    }

    emxInit_real_T(&g_cpu_y, 2, &bc_emlrtRTEI, true);
    r = std::fmax(tol, 1.0 / fb_VoicesPerOctave) * fb_VoicesPerOctave;
    if (std::isnan(r)) {
      j = g_cpu_y->size[0] * g_cpu_y->size[1];
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(g_cpu_y, j, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(g_cpu_y, &h_gpu_y);
      g_cpu_y->data[0] = rtNaN;
      b_y_dirtyOnCpu = true;
    } else if (r < 0.0) {
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = 0;
    } else {
      j = g_cpu_y->size[0] * g_cpu_y->size[1];
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = static_cast<int32_T>(r) + 1;
      emxEnsureCapacity_real_T(g_cpu_y, j, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(g_cpu_y, &h_gpu_y);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
        static_cast<int64_T>(r) + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_cwtAvg_kernel61<<<grid, block>>>(r, h_gpu_y);
      }
    }

    emxInit_real_T(&h_cpu_y, 2, &dc_emlrtRTEI, true);
    j = h_cpu_y->size[0] * h_cpu_y->size[1];
    h_cpu_y->size[0] = 1;
    h_cpu_y->size[1] = g_cpu_y->size[1];
    emxEnsureCapacity_real_T(h_cpu_y, j, &k_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(h_cpu_y, &i_gpu_y);
    vstride = g_cpu_y->size[1];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vstride),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (b_y_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_y, g_cpu_y);
      }

      ec_cwtAvg_kernel62<<<grid, block>>>(h_gpu_y, rt_powd_snf(2.0, 1.0 /
        fb_VoicesPerOctave), vstride, i_gpu_y);
    }

    emxFree_real_T(&g_cpu_y);
    j = cpu_fb_Scales->size[0] * cpu_fb_Scales->size[1];
    cpu_fb_Scales->size[0] = 1;
    cpu_fb_Scales->size[1] = h_cpu_y->size[1];
    emxEnsureCapacity_real_T(cpu_fb_Scales, j, &l_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales);
    ix = h_cpu_y->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel63<<<grid, block>>>(i_gpu_y, halfh, ix, gpu_fb_Scales);
      fb_Scales_dirtyOnGpu = true;
    }

    emxFree_real_T(&h_cpu_y);
  }

  first_iteration = false;
  acoef = 0;
  do {
    exitg1 = 0;
    if (acoef + 1 < 6) {
      if (cpu_cv[static_cast<int32_T>(b[acoef])] != cpu_cv[static_cast<int32_T>
          (cv3[acoef])]) {
        exitg1 = 1;
      } else {
        acoef++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  emxInit_real_T(&cpu_psidft, 2, &xb_emlrtRTEI, true);
  emxInit_real_T(&cpu_f, 2, &yb_emlrtRTEI, true);
  if (first_iteration) {
    emxInit_real_T(&cpu_somega, 2, &ac_emlrtRTEI, true);
    if (cpu_fb_Scales->size[1] == 1) {
      j = cpu_somega->size[0] * cpu_somega->size[1];
      cpu_somega->size[0] = 1;
      if (cpu_omega->size[1] == 1) {
        cpu_somega->size[1] = 1;
      } else {
        cpu_somega->size[1] = cpu_omega->size[1];
      }

      emxEnsureCapacity_real_T(cpu_somega, j, &p_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_somega, &gpu_somega);
      bcoef = (cpu_omega->size[1] != 1);
      nbytes = cpu_somega->size[1] - 1;
      for (vstride = 0; vstride <= nbytes; vstride++) {
        if (fb_Scales_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
        }

        fb_Scales_dirtyOnGpu = false;
        if (omega_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_omega, &gpu_omega);
        }

        omega_dirtyOnGpu = false;
        cpu_somega->data[vstride] = cpu_fb_Scales->data[0] * cpu_omega->
          data[bcoef * vstride];
        somega_dirtyOnCpu = true;
      }
    } else {
      j = cpu_somega->size[0] * cpu_somega->size[1];
      cpu_somega->size[0] = cpu_fb_Scales->size[1];
      cpu_somega->size[1] = cpu_omega->size[1];
      emxEnsureCapacity_real_T(cpu_somega, j, &o_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_somega, &gpu_somega);
      pathlen = cpu_omega->size[1];
      ix = cpu_fb_Scales->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ix + 1L) *
        pathlen), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_cwtAvg_kernel70<<<grid, block>>>(gpu_omega, gpu_fb_Scales, ix,
          pathlen, gpu_somega, cpu_somega->size[0U]);
        somega_dirtyOnGpu = true;
      }
    }

    vstride = cpu_somega->size[0] * cpu_somega->size[1];
    for (ix = 0; ix < 2; ix++) {
      cpu_xSize[ix] = static_cast<uint32_T>(cpu_somega->size[ix]);
      xSize_dirtyOnCpu = true;
    }

    emxInit_real_T(&cpu_absomega, 2, &cc_emlrtRTEI, true);
    j = cpu_absomega->size[0] * cpu_absomega->size[1];
    cpu_absomega->size[0] = static_cast<int32_T>(cpu_xSize[0]);
    cpu_absomega->size[1] = static_cast<int32_T>(cpu_xSize[1]);
    emxEnsureCapacity_real_T(cpu_absomega, j, &t_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_absomega, &gpu_absomega);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vstride),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (somega_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, cpu_somega);
      }

      somega_dirtyOnCpu = false;
      ec_cwtAvg_kernel71<<<grid, block>>>(gpu_somega, vstride, gpu_absomega);
      absomega_dirtyOnGpu = true;
    }

    emxInit_real_T(&cpu_powscales, 2, &v_emlrtRTEI, true);
    j = cpu_powscales->size[0] * cpu_powscales->size[1];
    cpu_powscales->size[0] = cpu_absomega->size[0];
    cpu_powscales->size[1] = cpu_absomega->size[1];
    emxEnsureCapacity_real_T(cpu_powscales, j, &v_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_powscales, &gpu_powscales);
    ix = cpu_absomega->size[0] * cpu_absomega->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel72<<<grid, block>>>(gpu_absomega, ix, gpu_powscales);
      powscales_dirtyOnGpu = true;
    }

    vstride = cpu_absomega->size[0] * cpu_absomega->size[1];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vstride),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel73<<<grid, block>>>(vstride, gpu_absomega);
      absomega_dirtyOnGpu = true;
    }

    emxInit_real_T(&j_cpu_x, 2, &y_emlrtRTEI, true);
    if ((cpu_absomega->size[0] == cpu_powscales->size[0]) && (cpu_absomega->
         size[1] == cpu_powscales->size[1])) {
      j = j_cpu_x->size[0] * j_cpu_x->size[1];
      j_cpu_x->size[0] = cpu_absomega->size[0];
      j_cpu_x->size[1] = cpu_absomega->size[1];
      emxEnsureCapacity_real_T(j_cpu_x, j, &y_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(j_cpu_x, &gpu_x);
      ix = cpu_absomega->size[0] * cpu_absomega->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_cwtAvg_kernel74<<<grid, block>>>(gpu_powscales, gpu_absomega, ix,
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
    vstride = j_cpu_x->size[0] * j_cpu_x->size[1];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vstride),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (f_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, j_cpu_x);
      }

      ec_cwtAvg_kernel75<<<grid, block>>>(vstride, gpu_x);
      e_x_dirtyOnGpu = true;
      f_x_dirtyOnCpu = false;
    }

    if ((j_cpu_x->size[0] == cpu_somega->size[0]) && (j_cpu_x->size[1] ==
         cpu_somega->size[1])) {
      j = cpu_psidft->size[0] * cpu_psidft->size[1];
      cpu_psidft->size[0] = j_cpu_x->size[0];
      cpu_psidft->size[1] = j_cpu_x->size[1];
      emxEnsureCapacity_real_T(cpu_psidft, j, &bb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_psidft, &gpu_psidft);
      ix = j_cpu_x->size[0] * j_cpu_x->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (somega_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, cpu_somega);
        }

        if (f_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, j_cpu_x);
        }

        ec_cwtAvg_kernel76<<<grid, block>>>(gpu_somega, gpu_x, ix, gpu_psidft);
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
    j = cpu_f->size[0] * cpu_f->size[1];
    cpu_f->size[0] = 1;
    cpu_f->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real_T(cpu_f, j, &db_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f);
    ix = cpu_fb_Scales->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel77<<<grid, block>>>(gpu_fb_Scales, ix, gpu_f);
    }
  } else {
    j = cpu_psidft->size[0] * cpu_psidft->size[1];
    cpu_psidft->size[0] = cpu_fb_Scales->size[1];
    cpu_psidft->size[1] = cpu_omega->size[1];
    emxEnsureCapacity_real_T(cpu_psidft, j, &n_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_psidft, &gpu_psidft);
    ix = cpu_fb_Scales->size[1] * cpu_omega->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel68<<<grid, block>>>(ix, gpu_psidft);
    }

    j = cpu_f->size[0] * cpu_f->size[1];
    cpu_f->size[0] = 1;
    cpu_f->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real_T(cpu_f, j, &r_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f);
    ix = cpu_fb_Scales->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel69<<<grid, block>>>(gpu_fb_Scales, ix, gpu_f);
    }
  }

  emxFree_real_T(&cpu_omega);
  j = cpu_f->size[0] * cpu_f->size[1];
  cpu_f->size[0] = 1;
  emxEnsureCapacity_real_T(cpu_f, j, &s_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f);
  j = cpu_f->size[1] - 1;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(j + 1L), &grid,
    &block, 1024U, 65535U);
  if (validLaunchParams) {
    ec_cwtAvg_kernel78<<<grid, block>>>(fs, j, gpu_f);
  }

  // 'ec_cwtAvg:29' freqs = centerFrequencies(fb);
  j = cpu_freqs->size[0];
  cpu_freqs->size[0] = cpu_f->size[1];
  emxEnsureCapacity_real_T(cpu_freqs, j, &u_emlrtRTEI);
  ix = cpu_f->size[1] - 1;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    gpuEmxMemcpyCpuToGpu_real_T(&gpu_freqs, cpu_freqs);
    ec_cwtAvg_kernel79<<<grid, block>>>(gpu_f, ix, gpu_freqs);
    freqs_dirtyOnGpu = true;
  }

  emxFree_real_T(&cpu_f);

  //  Preallocate
  // 'ec_cwtAvg:32' xx = coder.nullcopy(x);
  //  Preallocate output
  //  CWT average power (L1-norm & variance-norm usng weighted integrals)
  // 'ec_cwtAvg:36' coder.gpu.kernel(nChs,-1)
  // 'ec_cwtAvg:37' for ch = 1:nChs
  emxInit_real32_T(&cpu_savgpTMP, 2, &ec_emlrtRTEI, true);
  if (computeEndIdx(1L, static_cast<int64_T>(nChs), 1L) >= 0L) {
    if (cpu_fb_Scales->size[1] < 1) {
      i34 = 0;
    } else {
      i34 = cpu_fb_Scales->size[1];
    }
  }

  emxInit_real32_T(&cpu_Scales, 2, &cb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_psihat, 2, &eb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_xv, 2, &fb_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_xposdft, 2, &gb_emlrtRTEI, true);
  emxInit_real32_T(&k_cpu_x, 2, &ib_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_cfsposdft, 2, &jc_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_cfspos, 2, &kb_emlrtRTEI, true);
  emxInit_real32_T(&m_cpu_y, 2, &oc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_abscfssq, 2, &pc_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_a, 2, &mb_emlrtRTEI, true);
  emxInit_real_T(&l_cpu_x, 2, &g_emlrtRTEI, true);
  emxInit_uint32_T(&n_cpu_y, 2, &qc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_z, 1, &rc_emlrtRTEI, true);
  emxInit_real_T(&m_cpu_x, 2, &fc_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_xt, 2, &gc_emlrtRTEI, true);
  emxInit_real_T(&cpu_c, 1, &qb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_c, 1, &qb_emlrtRTEI, true);
  emxInit_real_T(&o_cpu_y, 2, &sc_emlrtRTEI, true);
  emxInit_real32_T(&p_cpu_y, 2, &tc_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_a, 2, &pb_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_fx, 2, &xb_emlrtRTEI, true);
  emxInit_real_T(&n_cpu_x, 2, &rb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_abswt2, 2, &uc_emlrtRTEI, true);
  emxInit_real_T(&o_cpu_x, 2, &sb_emlrtRTEI, true);
  emxInit_real_T(&q_cpu_y, 2, &vc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_abswt2S, 2, &wc_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_c, 1, &qb_emlrtRTEI, true);
  d = computeEndIdx(1L, static_cast<int64_T>(nChs), 1L);
  for (int64_T ch{0L}; ch <= d; ch++) {
    real32_T normfac;
    real32_T varsig;
    real32_T xbar;

    // 'ec_cwtAvg:38' coder.gpu.constantMemory(xx);
    // 'ec_cwtAvg:39' xx(:,ch) = scaleSpectrum(fb,x(:,ch),SpectrumType="density")';
    j = cpu_Scales->size[0] * cpu_Scales->size[1];
    cpu_Scales->size[0] = 1;
    cpu_Scales->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real32_T(cpu_Scales, j, &cb_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(cpu_Scales, &gpu_Scales);
    ix = cpu_fb_Scales->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel80<<<grid, block>>>(gpu_fb_Scales, ix, gpu_Scales);
      Scales_dirtyOnGpu = true;
    }

    nbytes = cpu_x->size[0] - 1;
    if (cpu_x->size[0] == 1) {
      xbar = cpu_x->data[cpu_x->size[0] * (static_cast<int32_T>(ch + 1L) - 1)];
      if ((!std::isinf(xbar)) && (!std::isnan(xbar))) {
        normfac = 0.0F;
      } else {
        normfac = rtNaNF;
      }
    } else {
      xbar = cpu_x->data[cpu_x->size[0] * (static_cast<int32_T>(ch + 1L) - 1)];
      for (vstride = 0; vstride < nbytes; vstride++) {
        xbar += cpu_x->data[(vstride + cpu_x->size[0] * (static_cast<int32_T>(ch
          + 1L) - 1)) + 1];
      }

      xbar /= static_cast<real32_T>(cpu_x->size[0]);
      varsig = 0.0F;
      for (vstride = 0; vstride <= nbytes; vstride++) {
        cpu_t = cpu_x->data[vstride + cpu_x->size[0] * (static_cast<int32_T>(ch
          + 1L) - 1)] - xbar;
        varsig += cpu_t * cpu_t;
      }

      normfac = varsig / static_cast<real32_T>(cpu_x->size[0]);
    }

    j = cpu_psihat->size[0] * cpu_psihat->size[1];
    cpu_psihat->size[0] = cpu_psidft->size[0];
    cpu_psihat->size[1] = cpu_psidft->size[1];
    emxEnsureCapacity_real32_T(cpu_psihat, j, &eb_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(cpu_psihat, &gpu_psihat);
    ix = cpu_psidft->size[0] * cpu_psidft->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (psidft_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_psidft, cpu_psidft);
      }

      psidft_dirtyOnCpu = false;
      ec_cwtAvg_kernel81<<<grid, block>>>(gpu_psidft, ix, gpu_psihat);
    }

    j = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    cpu_xv->size[1] = cpu_x->size[0];
    emxEnsureCapacity_real32_T(cpu_xv, j, &fb_emlrtRTEI);
    if (!xv_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv);
    }

    ix = cpu_x->size[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_x, cpu_x);
      }

      x_dirtyOnCpu = false;
      if (xv_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
      }

      ec_cwtAvg_kernel82<<<grid, block>>>(static_cast<int32_T>(ch + 1L), b_gpu_x,
        ix, gpu_xv, cpu_x->size[0U]);
      xv_dirtyOnGpu = true;
      xv_dirtyOnCpu = false;
    }

    if (y > 0.0) {
      vstride = cpu_x->size[0] - static_cast<int32_T>(y);
      if (vstride + 1 > cpu_x->size[0]) {
        acoef = 0;
        ix = 1;
        vstride = -1;
      } else {
        acoef = cpu_x->size[0] - 1;
        ix = -1;
      }

      j = k_cpu_x->size[0] * k_cpu_x->size[1];
      k_cpu_x->size[0] = 1;
      k_cpu_x->size[1] = static_cast<int32_T>(y);
      emxEnsureCapacity_real32_T(k_cpu_x, j, &ib_emlrtRTEI);
      if (!g_x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(k_cpu_x, &c_gpu_x);
      }

      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
        static_cast<int32_T>(y)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_x, cpu_x);
        }

        x_dirtyOnCpu = false;
        if (g_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_x, k_cpu_x);
        }

        ec_cwtAvg_kernel83<<<grid, block>>>(static_cast<int32_T>(ch + 1L),
          b_gpu_x, y, c_gpu_x, cpu_x->size[0U]);
        f_x_dirtyOnGpu = true;
        g_x_dirtyOnCpu = false;
      }

      nbytes = static_cast<int32_T>(y) >> 1;
      for (pathlen = 0; pathlen < nbytes; pathlen++) {
        bcoef = (static_cast<int32_T>(y) - pathlen) - 1;
        if (f_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(k_cpu_x, &c_gpu_x);
        }

        xbar = k_cpu_x->data[pathlen];
        k_cpu_x->data[pathlen] = k_cpu_x->data[bcoef];
        k_cpu_x->data[bcoef] = xbar;
        g_x_dirtyOnCpu = true;
        f_x_dirtyOnGpu = false;
      }

      j = cpu_xv->size[0] * cpu_xv->size[1];
      cpu_xv->size[0] = 1;
      cpu_xv->size[1] = ((cpu_x->size[0] + k_cpu_x->size[1]) + div_s32(vstride -
        acoef, ix)) + 1;
      emxEnsureCapacity_real32_T(cpu_xv, j, &jb_emlrtRTEI);
      if (!xv_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv);
      }

      pathlen = k_cpu_x->size[1];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(pathlen),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (g_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_x, k_cpu_x);
        }

        g_x_dirtyOnCpu = false;
        if (xv_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
        }

        ec_cwtAvg_kernel84<<<grid, block>>>(c_gpu_x, pathlen, gpu_xv);
        xv_dirtyOnGpu = true;
        xv_dirtyOnCpu = false;
      }

      pathlen = cpu_x->size[0];
      for (j = 0; j < pathlen; j++) {
        if (xv_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xv, &gpu_xv);
        }

        cpu_xv->data[j + k_cpu_x->size[1]] = cpu_x->data[j + cpu_x->size[0] * (
          static_cast<int32_T>(ch + 1L) - 1)];
        xv_dirtyOnCpu = true;
        xv_dirtyOnGpu = false;
      }

      pathlen = div_s32(vstride - acoef, ix);
      for (j = 0; j <= pathlen; j++) {
        if (xv_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xv, &gpu_xv);
        }

        cpu_xv->data[(j + cpu_x->size[0]) + k_cpu_x->size[1]] = cpu_x->data
          [(acoef + ix * j) + cpu_x->size[0] * (static_cast<int32_T>(ch + 1L) -
          1)];
        xv_dirtyOnCpu = true;
        xv_dirtyOnGpu = false;
      }
    }

    if (cpu_xv->size[1] - (static_cast<int32_T>(static_cast<uint32_T>
          (cpu_xv->size[1]) >> 1) << 1) == 1) {
      cufftHandle b_fftPlanHandle;
      cufftType b_fftType;
      int fftDirection;
      j = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = cpu_xv->size[1];
      emxEnsureCapacity_creal32_T(cpu_xposdft, j, &gb_emlrtRTEI);
      if (!xposdft_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft);
      }

      ix = cpu_xv->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (xv_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
        }

        xv_dirtyOnCpu = false;
        if (xposdft_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_xposdft, cpu_xposdft);
        }

        ec_cwtAvg_kernel85<<<grid, block>>>(gpu_xv, ix, gpu_xposdft);
        xposdft_dirtyOnCpu = false;
      }

      nbytes = cpu_xposdft->size[1];
      fftDirection = CUFFT_FORWARD;
      b_fftType = CUFFT_C2C;
      b_fftPlanHandle = acquireCUFFTPlan(1, &nbytes, &nbytes, 1, 1, b_fftType, 1);
      if (xposdft_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_xposdft, cpu_xposdft);
      }

      cufftExecC2C(b_fftPlanHandle, (cufftComplex *)&gpu_xposdft.data[0],
                   (cufftComplex *)&gpu_xposdft.data[0], fftDirection);
      xposdft_dirtyOnCpu = false;
    } else {
      cufftHandle fftPlanHandle;
      cufftType fftType;
      nbytes = cpu_xv->size[1];
      for (ix = 0; ix < 2; ix++) {
        cpu_xSize[ix] = static_cast<uint32_T>(cpu_xv->size[ix]);
        xSize_dirtyOnCpu = true;
      }

      j = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = static_cast<int32_T>(cpu_xSize[1]);
      emxEnsureCapacity_creal32_T(cpu_xposdft, j, &hb_emlrtRTEI);
      if (!xposdft_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft);
      }

      fftType = CUFFT_R2C;
      fftPlanHandle = acquireCUFFTPlan(1, &nbytes, &nbytes, 1, 1, fftType, 1);
      if (xv_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
      }

      xv_dirtyOnCpu = false;
      if (xposdft_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_xposdft, cpu_xposdft);
      }

      cufftExecR2C(fftPlanHandle, (cufftReal *)&gpu_xv.data[0], (cufftComplex *)
                   &gpu_xposdft.data[0]);
      b_dirtyOnGpu = true;
      xposdft_dirtyOnCpu = false;
      nbytes = static_cast<int32_T>(static_cast<real_T>(static_cast<int32_T>
        (cpu_xSize[1]) + 1) / 2.0);
      for (vstride = 0; vstride <= nbytes - 2; vstride++) {
        if (b_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_xposdft, &gpu_xposdft);
        }

        cpu_xposdft->data[(static_cast<int32_T>(cpu_xSize[1]) - vstride) - 1].re
          = cpu_xposdft->data[vstride + 1].re;
        cpu_xposdft->data[(static_cast<int32_T>(cpu_xSize[1]) - vstride) - 1].im
          = -cpu_xposdft->data[vstride + 1].im;
        xposdft_dirtyOnCpu = true;
        b_dirtyOnGpu = false;
      }
    }

    nbytes = cpu_psihat->size[1];
    bcoef = cpu_xposdft->size[1];
    if (nbytes <= bcoef) {
      bcoef = nbytes;
    }

    if (cpu_psihat->size[1] == 1) {
      j = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == cpu_psihat->size[1]) {
      j = cpu_xposdft->size[1];
    } else {
      j = bcoef;
    }

    vstride = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
    cpu_cfsposdft->size[0] = cpu_psihat->size[0];
    nbytes = cpu_psihat->size[1];
    bcoef = cpu_xposdft->size[1];
    if (nbytes <= bcoef) {
      bcoef = nbytes;
    }

    if (cpu_psihat->size[1] == 1) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == cpu_psihat->size[1]) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else {
      cpu_cfsposdft->size[1] = bcoef;
    }

    emxEnsureCapacity_creal32_T(cpu_cfsposdft, vstride, &p_emlrtRTEI);
    gpuEmxEnsureCapacity_creal32_T(cpu_cfsposdft, &gpu_cfsposdft);
    if ((cpu_psihat->size[0] != 0) && (j != 0)) {
      bcoef = (cpu_psihat->size[1] != 1);
      nbytes = j - 1;
      ix = cpu_cfsposdft->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ix + 1L) *
        (nbytes + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (xposdft_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_xposdft, cpu_xposdft);
        }

        xposdft_dirtyOnCpu = false;
        ec_cwtAvg_kernel86<<<grid, block>>>(gpu_xposdft, gpu_psihat, bcoef, ix,
          j - 1, gpu_cfsposdft, cpu_psihat->size[0U], cpu_cfsposdft->size[0U]);
      }
    }

    if ((cpu_cfsposdft->size[0] == 0) || (cpu_cfsposdft->size[1] == 0)) {
      for (ix = 0; ix < 2; ix++) {
        cpu_xSize[ix] = static_cast<uint32_T>(cpu_cfsposdft->size[ix]);
        xSize_dirtyOnCpu = true;
      }

      if (xSize_dirtyOnCpu) {
        cudaMemcpy(*gpu_xSize, cpu_xSize, 8UL, cudaMemcpyHostToDevice);
      }

      ec_cwtAvg_kernel88<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_xSize,
        cpu_cfsposdft->size[1U]);
      xSize_dirtyOnCpu = false;
      j = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cudaMemcpy(cpu_xSize, *gpu_xSize, 8UL, cudaMemcpyDeviceToHost);
      cpu_cfspos->size[0] = static_cast<int32_T>(cpu_xSize[0]);
      cpu_cfspos->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal32_T(cpu_cfspos, j, &kb_emlrtRTEI);
      if (!cfspos_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal32_T(cpu_cfspos, &gpu_cfspos);
      }

      ix = static_cast<int32_T>(cpu_xSize[0]) * static_cast<int32_T>(cpu_xSize[1])
        - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (cfspos_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_cfspos, cpu_cfspos);
        }

        ec_cwtAvg_kernel89<<<grid, block>>>(ix, gpu_cfspos);
        cfspos_dirtyOnGpu = true;
        cfspos_dirtyOnCpu = false;
      }
    } else {
      cufftHandle c_fftPlanHandle;
      cufftType c_fftType;
      int b_fftDirection;
      nbytes = cpu_cfsposdft->size[1];
      b_fftDirection = CUFFT_INVERSE;
      c_fftType = CUFFT_C2C;
      c_fftPlanHandle = acquireCUFFTPlan(1, &nbytes, &nbytes,
        cpu_cfsposdft->size[0], 1, c_fftType, cpu_cfsposdft->size[0]);
      cufftExecC2C(c_fftPlanHandle, (cufftComplex *)&gpu_cfsposdft.data[0],
                   (cufftComplex *)&gpu_cfsposdft.data[0], b_fftDirection);
      j = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[0] = cpu_cfsposdft->size[0];
      cpu_cfspos->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal32_T(cpu_cfspos, j, &kb_emlrtRTEI);
      if (!cfspos_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal32_T(cpu_cfspos, &gpu_cfspos);
      }

      xbar = static_cast<real32_T>(cpu_cfsposdft->size[1]);
      ix = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (cfspos_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_cfspos, cpu_cfspos);
        }

        ec_cwtAvg_kernel87<<<grid, block>>>(xbar, gpu_cfsposdft, ix, gpu_cfspos);
        cfspos_dirtyOnGpu = true;
        cfspos_dirtyOnCpu = false;
      }
    }

    if (y > 0.0) {
      N = static_cast<uint32_T>(y) + static_cast<uint32_T>(cpu_x->size[0]);
      if (static_cast<uint32_T>(static_cast<int32_T>(y) + 1) > N) {
        nbytes = 0;
        acoef = 0;
      } else {
        nbytes = static_cast<int32_T>(y);
        acoef = static_cast<int32_T>(N);
      }

      bcoef = cpu_cfspos->size[0];
      pathlen = acoef - nbytes;
      for (j = 0; j < pathlen; j++) {
        for (vstride = 0; vstride < bcoef; vstride++) {
          if (cfspos_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_cfspos, &gpu_cfspos);
          }

          cpu_cfspos->data[vstride + bcoef * j] = cpu_cfspos->data[vstride +
            cpu_cfspos->size[0] * (nbytes + j)];
          cfspos_dirtyOnCpu = true;
          cfspos_dirtyOnGpu = false;
        }
      }

      j = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[1] = acoef - nbytes;
      emxEnsureCapacity_creal32_T(cpu_cfspos, j, &lb_emlrtRTEI);
      if (!cfspos_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal32_T(cpu_cfspos, &gpu_cfspos);
      }
    }

    first_iteration = false;
    acoef = 0;
    do {
      exitg1 = 0;
      if (acoef + 1 < 6) {
        if (cpu_cv[static_cast<int32_T>(b[acoef])] != cpu_cv[static_cast<int32_T>
            (cv4[acoef])]) {
          exitg1 = 1;
        } else {
          acoef++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      ec_cwtAvg_kernel91<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_wav, b_b
        [0], b_b[1], b_b[2], b_b[3], b_b[4]);
      ec_cwtAvg_kernel92<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_wav,
        *gpu_wavname);
      wavname_dirtyOnGpu = true;
    } else {
      ec_cwtAvg_kernel90<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_wav);
    }

    first_iteration = false;
    acoef = 0;
    do {
      exitg1 = 0;
      if (acoef + 1 < 6) {
        if (wavname_dirtyOnGpu) {
          cudaMemcpy(cpu_wavname, *gpu_wavname, 5UL, cudaMemcpyDeviceToHost);
        }

        wavname_dirtyOnGpu = false;
        if (cpu_cv[static_cast<int32_T>(cpu_wavname[acoef])] != cpu_cv[
            static_cast<int32_T>(cv4[acoef])]) {
          exitg1 = 1;
        } else {
          acoef++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      r = 0.0057083835261;
      for (vstride = 0; vstride < 6; vstride++) {
        r = r / 177.7777777777778 + c[vstride];
      }

      r = (r / 13.333333333333334 - 13.333333333333334) + 0.91893853320467278;
      r += 33.241761956554775;
      intFsq = 8.2480004101996545E-10 * std::exp(r);
    } else {
      if (interval_dirtyOnCpu) {
        cudaMemcpy(*gpu_interval, cpu_interval, 5200UL, cudaMemcpyHostToDevice);
      }

      ec_cwtAvg_kernel93<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
      ec_cwtAvg_kernel94<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*gpu_interval);
      interval_dirtyOnCpu = false;
      intFsq = 0.0;
      vstride = 1;
      cudaMemcpy(cpu_interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
      pathlen = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
        (cpu_interval[0]);
      if (pathlen > 0) {
        r = 10.0 / static_cast<real_T>(pathlen);
        n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::ceil(std::abs
          (cpu_interval[1] - cpu_interval[0]) * r)) - 1);
        nsubs = static_cast<int32_T>(std::ceil(std::abs(cpu_interval[1] -
          cpu_interval[0]) * r));
        if (nsubs + 1 > 2) {
          nbytes = n_idx_0;
          cpu_interval[nsubs] = cpu_interval[1];
          interval_dirtyOnCpu = true;
          r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>(n_idx_0)
            + 1.0);
          for (j = 0; j < nbytes; j++) {
            cpu_interval[(nsubs - j) - 1] = cpu_interval[0] + static_cast<real_T>
              (n_idx_0 - j) * r;
          }
        }

        vstride = nsubs;
      } else {
        nsubs = 1;
      }

      nbytes = 0;
      for (acoef = 0; acoef < vstride; acoef++) {
        if (std::abs(cpu_interval[acoef + 1] - cpu_interval[nbytes]) > 0.0) {
          nbytes++;
          cpu_interval[nbytes] = cpu_interval[acoef + 1];
          interval_dirtyOnCpu = true;
        } else {
          nsubs--;
        }
      }

      if (nsubs + 1 < 2) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, cpu_interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ec_cwtAvg_kernel95<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(vstride,
          *gpu_interval);
        interval_dirtyOnCpu = false;
        nsubs = 1;
      }

      if (pathlen <= 0) {
        intFsq = 0.47999999999999976;
      } else {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
                       cudaMemcpyHostToDevice);
          }

          interval_dirtyOnCpu = false;
          if (subs_dirtyOnCpu) {
            cudaMemcpy(*gpu_subs, cpu_subs, 10384UL, cudaMemcpyHostToDevice);
          }

          ec_cwtAvg_kernel96<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
          subs_dirtyOnGpu = true;
          subs_dirtyOnCpu = false;
        }

        q_ok = 0.0;
        err_ok = 0.0;
        first_iteration = true;
        do {
          exitg1 = 0;
          j = l_cpu_x->size[0] * l_cpu_x->size[1];
          l_cpu_x->size[0] = 1;
          l_cpu_x->size[1] = 15 * nsubs;
          emxEnsureCapacity_real_T(l_cpu_x, j, &g_emlrtRTEI);
          if (!h_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(l_cpu_x, &d_gpu_x);
          }

          ix = -1;
          for (vstride = 0; vstride < nsubs; vstride++) {
            if (subs_dirtyOnGpu) {
              cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
            }

            fc = cpu_subs[vstride << 1];
            subs_dirtyOnGpu = false;
            b_r = cpu_subs[(vstride << 1) + 1];
            r = (fc + b_r) / 2.0;
            halfh = (b_r - fc) / 2.0;
            for (j = 0; j < 15; j++) {
              l_cpu_x->data[(ix + j) + 1] = NODES[j] * halfh + r;
              h_x_dirtyOnCpu = true;
            }

            ix += 15;
          }

          j = m_cpu_x->size[0] * m_cpu_x->size[1];
          m_cpu_x->size[0] = 1;
          m_cpu_x->size[1] = l_cpu_x->size[1];
          emxEnsureCapacity_real_T(m_cpu_x, j, &h_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(m_cpu_x, &e_gpu_x);
          j = e_cpu_xt->size[0] * e_cpu_xt->size[1];
          e_cpu_xt->size[0] = 1;
          e_cpu_xt->size[1] = l_cpu_x->size[1];
          emxEnsureCapacity_real_T(e_cpu_xt, j, &i_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(e_cpu_xt, &gpu_xt);
          nbytes = l_cpu_x->size[1];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nbytes),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (h_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_x, l_cpu_x);
            }

            h_x_dirtyOnCpu = false;
            ec_cwtAvg_kernel97<<<grid, block>>>(d_gpu_x, nbytes, gpu_xt, e_gpu_x);
            g_x_dirtyOnGpu = true;
            e_xt_dirtyOnGpu = true;
          }

          b_guard1 = false;
          if (!first_iteration) {
            if (g_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(m_cpu_x, &e_gpu_x);
            }

            g_x_dirtyOnGpu = false;
            r = std::abs(m_cpu_x->data[0]);
            vstride = 0;
            exitg2 = false;
            while ((!exitg2) && (vstride <= m_cpu_x->size[1] - 2)) {
              tol = r;
              r = std::abs(m_cpu_x->data[vstride + 1]);
              if (std::abs(m_cpu_x->data[vstride + 1] - m_cpu_x->data[vstride]) <=
                  2.2204460492503131E-14 * std::fmax(tol, r)) {
                first_iteration = true;
                exitg2 = true;
              } else {
                vstride++;
              }
            }

            if (first_iteration) {
              dv2_idx_1 = static_cast<int16_T>(l_cpu_x->size[1]);
              j = e_cpu_fx->size[0] * e_cpu_fx->size[1];
              e_cpu_fx->size[0] = 1;
              e_cpu_fx->size[1] = l_cpu_x->size[1];
              emxEnsureCapacity_real_T(e_cpu_fx, j, &m_emlrtRTEI);
              if (!e_fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(e_cpu_fx, &gpu_fx);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (dv2_idx_1), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (e_fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_fx, e_cpu_fx);
                }

                ec_cwtAvg_kernel104<<<grid, block>>>(dv2_idx_1, gpu_fx);
                e_fx_dirtyOnGpu = true;
                e_fx_dirtyOnCpu = false;
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
            j = d_cpu_a->size[0] * d_cpu_a->size[1];
            d_cpu_a->size[0] = 1;
            d_cpu_a->size[1] = m_cpu_x->size[1];
            emxEnsureCapacity_real_T(d_cpu_a, j, &pb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_cpu_a, &b_gpu_a);
            ix = m_cpu_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_cwtAvg_kernel98<<<grid, block>>>(e_gpu_x, ix, b_gpu_a);
            }

            j = o_cpu_y->size[0] * o_cpu_y->size[1];
            o_cpu_y->size[0] = 1;
            o_cpu_y->size[1] = d_cpu_a->size[1];
            emxEnsureCapacity_real_T(o_cpu_y, j, &k_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(o_cpu_y, &f_gpu_y);
            vstride = d_cpu_a->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (vstride), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_cwtAvg_kernel99<<<grid, block>>>(b_gpu_a, vstride, f_gpu_y);
            }

            j = n_cpu_x->size[0] * n_cpu_x->size[1];
            n_cpu_x->size[0] = 1;
            n_cpu_x->size[1] = o_cpu_y->size[1];
            emxEnsureCapacity_real_T(n_cpu_x, j, &rb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(n_cpu_x, &f_gpu_x);
            ix = o_cpu_y->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_cwtAvg_kernel100<<<grid, block>>>(f_gpu_y, ix, f_gpu_x);
            }

            j = o_cpu_x->size[0] * o_cpu_x->size[1];
            o_cpu_x->size[0] = 1;
            o_cpu_x->size[1] = n_cpu_x->size[1];
            emxEnsureCapacity_real_T(o_cpu_x, j, &sb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(o_cpu_x, &g_gpu_x);
            ix = n_cpu_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_cwtAvg_kernel101<<<grid, block>>>(f_gpu_x, ix, g_gpu_x);
            }

            vstride = n_cpu_x->size[1];
            j = q_cpu_y->size[0] * q_cpu_y->size[1];
            q_cpu_y->size[0] = 1;
            q_cpu_y->size[1] = o_cpu_x->size[1];
            emxEnsureCapacity_real_T(q_cpu_y, j, &t_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(q_cpu_y, &g_gpu_y);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (vstride), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_cwtAvg_kernel102<<<grid, block>>>(g_gpu_x, vstride, g_gpu_y);
              f_y_dirtyOnGpu = true;
            }

            if (q_cpu_y->size[1] == m_cpu_x->size[1]) {
              j = e_cpu_fx->size[0] * e_cpu_fx->size[1];
              e_cpu_fx->size[0] = 1;
              e_cpu_fx->size[1] = q_cpu_y->size[1];
              emxEnsureCapacity_real_T(e_cpu_fx, j, &ab_emlrtRTEI);
              if (!e_fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(e_cpu_fx, &gpu_fx);
              }

              ix = q_cpu_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (e_fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_fx, e_cpu_fx);
                }

                ec_cwtAvg_kernel103<<<grid, block>>>(gpu_xt, e_gpu_x, g_gpu_y,
                  ix, gpu_fx);
                e_fx_dirtyOnGpu = true;
                e_fx_dirtyOnCpu = false;
              }
            } else {
              if (e_fx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(e_cpu_fx, &gpu_fx);
              }

              if (f_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(q_cpu_y, &g_gpu_y);
              }

              f_y_dirtyOnGpu = false;
              if (g_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(m_cpu_x, &e_gpu_x);
              }

              g_x_dirtyOnGpu = false;
              if (e_xt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(e_cpu_xt, &gpu_xt);
              }

              e_xt_dirtyOnGpu = false;
              binary_expand_op(e_cpu_fx, q_cpu_y, m_cpu_x, e_cpu_xt);
              e_fx_dirtyOnCpu = true;
              e_fx_dirtyOnGpu = false;
            }

            r = 0.0;
            ix = -1;
            for (vstride = 0; vstride < nsubs; vstride++) {
              fc = 0.0;
              b_r = 0.0;
              for (j = 0; j < 15; j++) {
                if (e_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(e_cpu_fx, &gpu_fx);
                }

                fc += dv4[j] * e_cpu_fx->data[(ix + j) + 1];
                e_fx_dirtyOnGpu = false;
                b_r += dv5[j] * e_cpu_fx->data[(ix + j) + 1];
              }

              ix += 15;
              if (subs_dirtyOnGpu) {
                cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              halfh = (cpu_subs[(vstride << 1) + 1] - cpu_subs[vstride << 1]) /
                2.0;
              fc *= halfh;
              qsub[vstride] = fc;
              r += fc;
              errsub[vstride] = b_r * halfh;
            }

            intFsq = r + q_ok;
            tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
            r = 2.0 * tol / static_cast<real_T>(pathlen);
            b_r = 0.0;
            nbytes = 0;
            for (vstride = 0; vstride < nsubs; vstride++) {
              fc = errsub[vstride];
              halfh = std::abs(fc);
              if (subs_dirtyOnGpu) {
                cudaMemcpy(cpu_subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              if (halfh <= r * ((cpu_subs[(vstride << 1) + 1] - cpu_subs[vstride
                                 << 1]) / 2.0)) {
                err_ok += fc;
                q_ok += qsub[vstride];
              } else {
                b_r += halfh;
                nbytes++;
                cpu_subs[(nbytes - 1) << 1] = cpu_subs[vstride << 1];
                cpu_subs[((nbytes - 1) << 1) + 1] = cpu_subs[(vstride << 1) + 1];
                subs_dirtyOnCpu = true;
              }
            }

            r = std::abs(err_ok) + b_r;
            if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::isinf
                  (r)) && (!std::isnan(r))) && (nbytes != 0) && (!(r <= tol))) {
              nsubs = nbytes << 1;
              if (nsubs > 650) {
                exitg1 = 1;
              } else {
                for (vstride = 0; vstride < nbytes; vstride++) {
                  if (subs_dirtyOnGpu) {
                    cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                               cudaMemcpyDeviceToHost);
                  }

                  cpu_subs[((((nbytes - vstride) << 1) - 1) << 1) + 1] =
                    cpu_subs[(((nbytes - vstride) - 1) << 1) + 1];
                  cpu_subs[(((nbytes - vstride) << 1) - 1) << 1] = (cpu_subs
                    [((nbytes - vstride) - 1) << 1] + cpu_subs[(((nbytes -
                    vstride) - 1) << 1) + 1]) / 2.0;
                  cpu_subs[((((nbytes - vstride) << 1) - 2) << 1) + 1] =
                    cpu_subs[(((nbytes - vstride) << 1) - 1) << 1];
                  cpu_subs[(((nbytes - vstride) << 1) - 2) << 1] = cpu_subs
                    [((nbytes - vstride) - 1) << 1];
                  subs_dirtyOnCpu = true;
                  subs_dirtyOnGpu = false;
                }
              }
            } else {
              exitg1 = 1;
            }
          }
        } while (exitg1 == 0);
      }
    }

    vstride = cpu_cfspos->size[0] * cpu_cfspos->size[1];
    for (ix = 0; ix < 2; ix++) {
      cpu_xSize[ix] = static_cast<uint32_T>(cpu_cfspos->size[ix]);
      xSize_dirtyOnCpu = true;
    }

    j = m_cpu_y->size[0] * m_cpu_y->size[1];
    m_cpu_y->size[0] = static_cast<int32_T>(cpu_xSize[0]);
    m_cpu_y->size[1] = static_cast<int32_T>(cpu_xSize[1]);
    emxEnsureCapacity_real32_T(m_cpu_y, j, &t_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(m_cpu_y, &c_gpu_y);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vstride),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (cfspos_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_cfspos, cpu_cfspos);
      }

      cfspos_dirtyOnCpu = false;
      ec_cwtAvg_kernel105<<<grid, block>>>(gpu_cfspos, vstride, c_gpu_y);
    }

    for (ix = 0; ix < 2; ix++) {
      cpu_xSize[ix] = static_cast<uint32_T>(m_cpu_y->size[ix]);
      xSize_dirtyOnCpu = true;
    }

    j = cpu_abscfssq->size[0] * cpu_abscfssq->size[1];
    cpu_abscfssq->size[0] = static_cast<int32_T>(cpu_xSize[0]);
    cpu_abscfssq->size[1] = static_cast<int32_T>(cpu_xSize[1]);
    emxEnsureCapacity_real32_T(cpu_abscfssq, j, &k_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(cpu_abscfssq, &gpu_abscfssq);
    vstride = static_cast<int32_T>(cpu_xSize[0]) * static_cast<int32_T>
      (cpu_xSize[1]);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vstride),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel106<<<grid, block>>>(c_gpu_y, vstride, gpu_abscfssq);
      abscfssq_dirtyOnGpu = true;
    }

    j = c_cpu_a->size[0] * c_cpu_a->size[1];
    c_cpu_a->size[0] = cpu_abscfssq->size[0];
    c_cpu_a->size[1] = cpu_abscfssq->size[1];
    emxEnsureCapacity_real32_T(c_cpu_a, j, &mb_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(c_cpu_a, &gpu_a);
    ix = cpu_abscfssq->size[0] * cpu_abscfssq->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel107<<<grid, block>>>(gpu_abscfssq, ix, gpu_a);
    }

    nbytes = cpu_Scales->size[1];
    bcoef = cpu_abscfssq->size[0];
    if (nbytes <= bcoef) {
      bcoef = nbytes;
    }

    if (cpu_Scales->size[1] == 1) {
      j = cpu_abscfssq->size[0];
    } else if (cpu_abscfssq->size[0] == 1) {
      j = cpu_Scales->size[1];
    } else if (cpu_abscfssq->size[0] == cpu_Scales->size[1]) {
      j = cpu_abscfssq->size[0];
    } else {
      j = bcoef;
    }

    vstride = cpu_abscfssq->size[1];
    nbytes = cpu_abscfssq->size[0] * cpu_abscfssq->size[1];
    cpu_abscfssq->size[0] = j;
    cpu_abscfssq->size[1] = vstride;
    emxEnsureCapacity_real32_T(cpu_abscfssq, nbytes, &p_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(cpu_abscfssq, &gpu_abscfssq);
    if ((j != 0) && (vstride != 0)) {
      acoef = (c_cpu_a->size[1] != 1);
      nbytes = vstride - 1;
      ix = cpu_abscfssq->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ix + 1L) *
        (nbytes + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_cwtAvg_kernel108<<<grid, block>>>(gpu_Scales, gpu_a, acoef, ix,
          vstride - 1, gpu_abscfssq, c_cpu_a->size[0U], cpu_Scales->size[1U],
          cpu_abscfssq->size[0U]);
        abscfssq_dirtyOnGpu = true;
      }
    }

    if (cpu_abscfssq->size[1] < 1) {
      n_cpu_y->size[0] = 1;
      n_cpu_y->size[1] = 0;
    } else {
      N = static_cast<uint32_T>(cpu_abscfssq->size[1]);
      j = n_cpu_y->size[0] * n_cpu_y->size[1];
      n_cpu_y->size[0] = 1;
      n_cpu_y->size[1] = cpu_abscfssq->size[1];
      emxEnsureCapacity_uint32_T(n_cpu_y, j, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_uint32_T(n_cpu_y, &d_gpu_y);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
        static_cast<int32_T>(N)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_cwtAvg_kernel109<<<grid, block>>>(N, d_gpu_y);
        e_y_dirtyOnGpu = true;
      }
    }

    j = cpu_z->size[0];
    cpu_z->size[0] = cpu_abscfssq->size[0];
    emxEnsureCapacity_real32_T(cpu_z, j, &nb_emlrtRTEI);
    if (!z_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z);
    }

    ix = cpu_abscfssq->size[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (z_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
      }

      ec_cwtAvg_kernel110<<<grid, block>>>(ix, gpu_z);
      z_dirtyOnGpu = true;
      z_dirtyOnCpu = false;
    }

    if (cpu_abscfssq->size[1] > 1) {
      if (n_cpu_y->size[1] == 1) {
        nbytes = cpu_abscfssq->size[1];
        j = cpu_c->size[0];
        cpu_c->size[0] = cpu_abscfssq->size[1];
        emxEnsureCapacity_real_T(cpu_c, j, &qb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nbytes),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_cwtAvg_kernel114<<<grid, block>>>(d_gpu_y, nbytes, gpu_c);
        }

        if (e_y_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_uint32_T(n_cpu_y, &d_gpu_y);
        }

        e_y_dirtyOnGpu = false;
        r = 0.5 * static_cast<real_T>(n_cpu_y->data[0]);
        ec_cwtAvg_kernel115<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(r, gpu_c);
        ec_cwtAvg_kernel116<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(r, gpu_c,
          cpu_abscfssq->size[1U]);
        b_dirtyOnGpu = true;
      } else {
        j = cpu_c->size[0];
        cpu_c->size[0] = cpu_abscfssq->size[1];
        emxEnsureCapacity_real_T(cpu_c, j, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c);
        ec_cwtAvg_kernel111<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_y,
          gpu_c);
        nbytes = cpu_abscfssq->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nbytes -
          2L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_cwtAvg_kernel112<<<grid, block>>>(d_gpu_y, nbytes, gpu_c);
        }

        ec_cwtAvg_kernel113<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_y,
          gpu_c, cpu_abscfssq->size[1U]);
        b_dirtyOnGpu = true;
      }

      vstride = cpu_abscfssq->size[0];
      if (cpu_abscfssq->size[0] != 0) {
        int64_T e;
        nbytes = cpu_abscfssq->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nbytes),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (z_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
          }

          ec_cwtAvg_kernel117<<<grid, block>>>(nbytes, gpu_z);
          z_dirtyOnGpu = true;
          z_dirtyOnCpu = false;
        }

        ix = 0;
        nbytes = cpu_abscfssq->size[0] * (cpu_abscfssq->size[1] - 1) + 1;
        e = computeEndIdx(1L, static_cast<int64_T>(nbytes), static_cast<int64_T>
                          (vstride));
        for (int64_T iac{0L}; iac <= e; iac++) {
          int64_T f;
          f = computeEndIdx(static_cast<int64_T>(static_cast<int32_T>(iac *
            vstride + 1L)), static_cast<int64_T>((static_cast<int32_T>(iac *
            vstride + 1L) + vstride) - 1), 1L);
          for (int64_T ia{0L}; ia <= f; ia++) {
            if (z_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_z, &gpu_z);
            }

            if (abscfssq_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_abscfssq, &gpu_abscfssq);
            }

            abscfssq_dirtyOnGpu = false;
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_c, &gpu_c);
            }

            b_dirtyOnGpu = false;
            cpu_z->data[static_cast<int32_T>(ia)] += cpu_abscfssq->data[
              static_cast<int32_T>(static_cast<int32_T>(iac * vstride + 1L) + ia)
              - 1] * static_cast<real32_T>(cpu_c->data[ix]);
            z_dirtyOnCpu = true;
            z_dirtyOnGpu = false;
          }

          ix++;
        }
      }
    }

    cpu_t = 0.0F;
    b_dirtyOnGpu = false;
    if (cpu_z->size[0] <= 1) {
      if (cpu_Scales->size[1] == 1) {
        if (Scales_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_Scales, &gpu_Scales);
        }

        Scales_dirtyOnGpu = false;
        if (std::isinf(cpu_Scales->data[0]) || std::isnan(cpu_Scales->data[0]))
        {
          cpu_t = rtNaNF;
        }
      }
    } else {
      if (cpu_Scales->size[1] == 1) {
        nbytes = cpu_z->size[0];
        j = b_cpu_c->size[0];
        b_cpu_c->size[0] = cpu_z->size[0];
        emxEnsureCapacity_real32_T(b_cpu_c, j, &qb_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_c, &c_gpu_c);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nbytes),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_cwtAvg_kernel121<<<grid, block>>>(gpu_Scales, nbytes, c_gpu_c);
        }

        if (Scales_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_Scales, &gpu_Scales);
        }

        Scales_dirtyOnGpu = false;
        xbar = 0.5F * cpu_Scales->data[0];
        ec_cwtAvg_kernel122<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(xbar,
          c_gpu_c);
        if (z_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
        }

        z_dirtyOnCpu = false;
        ec_cwtAvg_kernel123<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(xbar,
          c_gpu_c, cpu_z->size[0U]);
      } else {
        j = b_cpu_c->size[0];
        b_cpu_c->size[0] = cpu_z->size[0];
        emxEnsureCapacity_real32_T(b_cpu_c, j, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_c, &c_gpu_c);
        ec_cwtAvg_kernel118<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_Scales,
          c_gpu_c);
        nbytes = cpu_z->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nbytes -
          2L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_cwtAvg_kernel119<<<grid, block>>>(gpu_Scales, nbytes, c_gpu_c);
        }

        if (z_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
        }

        z_dirtyOnCpu = false;
        ec_cwtAvg_kernel120<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_Scales,
          c_gpu_c, cpu_z->size[0U]);
      }

      xbar = 0.0F;
      varsig = 1.0F;
      cudaMemcpy(gpu_t, &cpu_t, 4UL, cudaMemcpyHostToDevice);
      cublasSgemv(getCublasGlobalHandle(), CUBLAS_OP_T, cpu_z->size[0], 1,
                  (float *)&varsig, (float *)&gpu_z.data[0], cpu_z->size[0],
                  (float *)&c_gpu_c.data[0], 1, (float *)&xbar, (float *)gpu_t,
                  1);
      b_dirtyOnGpu = true;
    }

    if (!(normfac == 0.0F)) {
      if (b_dirtyOnGpu) {
        cudaMemcpy(&cpu_t, gpu_t, 4UL, cudaMemcpyDeviceToHost);
      }

      xbar = std::sqrt(normfac / (static_cast<real32_T>(2.0 / intFsq /
        static_cast<real_T>(cpu_abscfssq->size[1])) * cpu_t));
      j = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(j), &grid,
        &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (cfspos_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_cfspos, cpu_cfspos);
        }

        ec_cwtAvg_kernel124<<<grid, block>>>(xbar, j, gpu_cfspos);
        cfspos_dirtyOnGpu = true;
        cfspos_dirtyOnCpu = false;
      }
    }

    vstride = cpu_cfspos->size[0] * cpu_cfspos->size[1];
    for (ix = 0; ix < 2; ix++) {
      cpu_xSize[ix] = static_cast<uint32_T>(cpu_cfspos->size[ix]);
      xSize_dirtyOnCpu = true;
    }

    j = p_cpu_y->size[0] * p_cpu_y->size[1];
    p_cpu_y->size[0] = static_cast<int32_T>(cpu_xSize[0]);
    p_cpu_y->size[1] = static_cast<int32_T>(cpu_xSize[1]);
    emxEnsureCapacity_real32_T(p_cpu_y, j, &t_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(p_cpu_y, &e_gpu_y);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vstride),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (cfspos_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_cfspos, cpu_cfspos);
      }

      cfspos_dirtyOnCpu = false;
      ec_cwtAvg_kernel125<<<grid, block>>>(gpu_cfspos, vstride, e_gpu_y);
    }

    for (ix = 0; ix < 2; ix++) {
      cpu_xSize[ix] = static_cast<uint32_T>(p_cpu_y->size[ix]);
      xSize_dirtyOnCpu = true;
    }

    j = cpu_abswt2->size[0] * cpu_abswt2->size[1];
    cpu_abswt2->size[0] = static_cast<int32_T>(cpu_xSize[0]);
    cpu_abswt2->size[1] = static_cast<int32_T>(cpu_xSize[1]);
    emxEnsureCapacity_real32_T(cpu_abswt2, j, &k_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(cpu_abswt2, &gpu_abswt2);
    vstride = static_cast<int32_T>(cpu_xSize[0]) * static_cast<int32_T>
      (cpu_xSize[1]);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vstride),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_cwtAvg_kernel126<<<grid, block>>>(e_gpu_y, vstride, gpu_abswt2);
    }

    j = cpu_abswt2S->size[0] * cpu_abswt2S->size[1];
    nbytes = cpu_Scales->size[1];
    bcoef = cpu_abswt2->size[0];
    if (nbytes <= bcoef) {
      bcoef = nbytes;
    }

    if (cpu_Scales->size[1] == 1) {
      cpu_abswt2S->size[0] = cpu_abswt2->size[0];
    } else if (cpu_abswt2->size[0] == 1) {
      cpu_abswt2S->size[0] = cpu_Scales->size[1];
    } else if (cpu_abswt2->size[0] == cpu_Scales->size[1]) {
      cpu_abswt2S->size[0] = cpu_abswt2->size[0];
    } else {
      cpu_abswt2S->size[0] = bcoef;
    }

    cpu_abswt2S->size[1] = cpu_abswt2->size[1];
    emxEnsureCapacity_real32_T(cpu_abswt2S, j, &p_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(cpu_abswt2S, &gpu_abswt2S);
    nbytes = cpu_Scales->size[1];
    bcoef = cpu_abswt2->size[0];
    if (nbytes <= bcoef) {
      bcoef = nbytes;
    }

    if (cpu_Scales->size[1] == 1) {
      bcoef = cpu_abswt2->size[0];
    } else if (cpu_abswt2->size[0] == 1) {
      bcoef = cpu_Scales->size[1];
    } else if (cpu_abswt2->size[0] == cpu_Scales->size[1]) {
      bcoef = cpu_abswt2->size[0];
    }

    if ((bcoef != 0) && (cpu_abswt2->size[1] != 0)) {
      acoef = (cpu_abswt2->size[1] != 1);
      nbytes = cpu_abswt2->size[1] - 1;
      ix = cpu_abswt2S->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ix + 1L) *
        (nbytes + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_cwtAvg_kernel127<<<grid, block>>>(gpu_Scales, gpu_abswt2, acoef, ix,
          nbytes, gpu_abswt2S, cpu_abswt2->size[0U], cpu_Scales->size[1U],
          cpu_abswt2S->size[0U]);
      }
    }

    if ((cpu_abswt2S->size[0] != 0) || (cpu_abswt2S->size[1] != 0)) {
      j = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
      cpu_savgpTMP->size[0] = 1;
      cpu_savgpTMP->size[1] = cpu_abswt2S->size[1];
      emxEnsureCapacity_real32_T(cpu_savgpTMP, j, &tb_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_savgpTMP, &gpu_savgpTMP);
      ix = cpu_abswt2S->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_cwtAvg_kernel128<<<grid, block>>>(ix, gpu_savgpTMP);
      }

      if (cpu_abswt2S->size[0] > 1) {
        if (i34 == 1) {
          nbytes = cpu_abswt2S->size[0];
          j = c_cpu_c->size[0];
          c_cpu_c->size[0] = cpu_abswt2S->size[0];
          emxEnsureCapacity_real32_T(c_cpu_c, j, &qb_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(c_cpu_c, &b_gpu_c);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nbytes),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_cwtAvg_kernel132<<<grid, block>>>(gpu_Scales, nbytes, b_gpu_c);
          }

          if (Scales_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_Scales, &gpu_Scales);
          }

          Scales_dirtyOnGpu = false;
          xbar = 0.5F * cpu_Scales->data[0];
          ec_cwtAvg_kernel133<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(xbar,
            b_gpu_c);
          ec_cwtAvg_kernel134<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(xbar,
            b_gpu_c, cpu_abswt2S->size[0U]);
        } else {
          j = c_cpu_c->size[0];
          c_cpu_c->size[0] = cpu_abswt2S->size[0];
          emxEnsureCapacity_real32_T(c_cpu_c, j, &ob_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(c_cpu_c, &b_gpu_c);
          ec_cwtAvg_kernel129<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (gpu_Scales, b_gpu_c);
          nbytes = cpu_abswt2S->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nbytes
            - 2L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_cwtAvg_kernel130<<<grid, block>>>(gpu_Scales, nbytes, b_gpu_c);
          }

          ec_cwtAvg_kernel131<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (gpu_Scales, b_gpu_c, cpu_abswt2S->size[0U]);
        }

        if (cpu_abswt2S->size[1] >= 1) {
          xbar = 0.0F;
          varsig = 1.0F;
          cublasSgemv(getCublasGlobalHandle(), CUBLAS_OP_T, cpu_abswt2S->size[0],
                      cpu_abswt2S->size[1], (float *)&varsig, (float *)
                      &gpu_abswt2S.data[0], cpu_abswt2S->size[0], (float *)
                      &b_gpu_c.data[0], 1, (float *)&xbar, (float *)
                      &gpu_savgpTMP.data[0], 1);
        }
      }
    }
  }

  emxFree_real32_T(&c_cpu_c);
  emxFree_real32_T(&cpu_abswt2S);
  emxFree_real_T(&q_cpu_y);
  emxFree_real_T(&o_cpu_x);
  emxFree_real32_T(&cpu_abswt2);
  emxFree_real_T(&n_cpu_x);
  emxFree_real_T(&e_cpu_fx);
  emxFree_real_T(&d_cpu_a);
  emxFree_real32_T(&p_cpu_y);
  emxFree_real_T(&o_cpu_y);
  emxFree_real32_T(&b_cpu_c);
  emxFree_real_T(&cpu_c);
  emxFree_real_T(&e_cpu_xt);
  emxFree_real_T(&m_cpu_x);
  emxFree_real32_T(&cpu_z);
  emxFree_uint32_T(&n_cpu_y);
  emxFree_real_T(&l_cpu_x);
  emxFree_real32_T(&c_cpu_a);
  emxFree_real32_T(&cpu_abscfssq);
  emxFree_real32_T(&m_cpu_y);
  emxFree_creal32_T(&cpu_cfspos);
  emxFree_creal32_T(&cpu_cfsposdft);
  emxFree_real32_T(&k_cpu_x);
  emxFree_creal32_T(&cpu_xposdft);
  emxFree_real32_T(&cpu_xv);
  emxFree_real32_T(&cpu_psihat);
  emxFree_real32_T(&cpu_Scales);
  emxFree_real32_T(&cpu_savgpTMP);
  emxFree_real_T(&cpu_psidft);
  emxFree_real_T(&cpu_fb_Scales);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (freqs_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_freqs, &gpu_freqs);
  }

  gpuEmxFree_real32_T(&b_gpu_x);
  mwCudaFree(*gpu_fLims);
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
  gpuEmxFree_real_T(&n_gpu_x);
  gpuEmxFree_real_T(&o_gpu_x);
  gpuEmxFree_real_T(&e_gpu_xt);
  gpuEmxFree_real_T(&o_gpu_y);
  gpuEmxFree_real_T(&e_gpu_fx);
  gpuEmxFree_real_T(&p_gpu_y);
  gpuEmxFree_real_T(&d_gpu_a);
  gpuEmxFree_real_T(&gpu_dv3);
  gpuEmxFree_real_T(&q_gpu_y);
  gpuEmxFree_real_T(&gpu_dv6);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_real_T(&l_gpu_x);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&m_gpu_x);
  gpuEmxFree_real_T(&d_gpu_xt);
  gpuEmxFree_real_T(&gpu_dv9);
  gpuEmxFree_real_T(&d_gpu_fx);
  gpuEmxFree_real_T(&n_gpu_y);
  gpuEmxFree_real_T(&h_gpu_y);
  gpuEmxFree_real_T(&gpu_dv11);
  gpuEmxFree_real_T(&i_gpu_y);
  gpuEmxFree_real_T(&j_gpu_x);
  gpuEmxFree_real_T(&gpu_psidft);
  gpuEmxFree_real_T(&k_gpu_x);
  gpuEmxFree_real_T(&gpu_f);
  gpuEmxFree_real_T(&c_gpu_xt);
  gpuEmxFree_real_T(&k_gpu_y);
  gpuEmxFree_real_T(&gpu_somega);
  gpuEmxFree_real_T(&c_gpu_fx);
  gpuEmxFree_real_T(&l_gpu_y);
  gpuEmxFree_real_T(&c_gpu_a);
  gpuEmxFree_real_T(&gpu_dv10);
  gpuEmxFree_real_T(&m_gpu_y);
  gpuEmxFree_real_T(&gpu_dv12);
  mwCudaFree(*gpu_xSize);
  gpuEmxFree_real_T(&gpu_absomega);
  gpuEmxFree_real_T(&h_gpu_x);
  gpuEmxFree_real_T(&i_gpu_x);
  gpuEmxFree_real_T(&b_gpu_xt);
  gpuEmxFree_real_T(&gpu_powscales);
  gpuEmxFree_real_T(&gpu_dv14);
  gpuEmxFree_real_T(&b_gpu_fx);
  gpuEmxFree_real_T(&j_gpu_y);
  gpuEmxFree_real_T(&gpu_dv17);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real32_T(&gpu_savgpTMP);
  gpuEmxFree_real32_T(&gpu_Scales);
  gpuEmxFree_real32_T(&gpu_psihat);
  gpuEmxFree_real32_T(&gpu_xv);
  gpuEmxFree_creal32_T(&gpu_xposdft);
  gpuEmxFree_real32_T(&c_gpu_x);
  gpuEmxFree_creal32_T(&gpu_cfsposdft);
  gpuEmxFree_creal32_T(&gpu_cfspos);
  gpuEmxFree_real32_T(&c_gpu_y);
  gpuEmxFree_real32_T(&gpu_abscfssq);
  gpuEmxFree_real32_T(&gpu_a);
  gpuEmxFree_real_T(&d_gpu_x);
  gpuEmxFree_uint32_T(&d_gpu_y);
  gpuEmxFree_real32_T(&gpu_z);
  gpuEmxFree_real_T(&e_gpu_x);
  gpuEmxFree_real_T(&gpu_xt);
  gpuEmxFree_real_T(&gpu_c);
  gpuEmxFree_real32_T(&c_gpu_c);
  gpuEmxFree_real_T(&f_gpu_y);
  gpuEmxFree_real32_T(&e_gpu_y);
  gpuEmxFree_real_T(&b_gpu_a);
  gpuEmxFree_real_T(&gpu_fx);
  gpuEmxFree_real_T(&f_gpu_x);
  gpuEmxFree_real32_T(&gpu_abswt2);
  gpuEmxFree_real_T(&g_gpu_x);
  gpuEmxFree_real_T(&g_gpu_y);
  gpuEmxFree_real32_T(&gpu_abswt2S);
  gpuEmxFree_real32_T(&b_gpu_c);
  mwCudaFree(gpu_t);
  mwCudaFree(*gpu_wavname);
}

void ec_cwtAvg_api(const mxArray * const prhs[4], int32_T nlhs, const mxArray
                   *plhs[2])
{
  emxArray_real32_T *x;
  emxArray_real_T *freqs;
  const mxArray *prhs_copy_idx_0;
  const mxArray *prhs_copy_idx_2;
  real_T (*fLims)[2];
  real_T fOctave;
  real_T fs;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_0 = emlrtProtectR2012b(prhs[0], 0, true, -1);
  prhs_copy_idx_2 = emlrtProtectR2012b(prhs[2], 2, false, -1);

  // Marshall function inputs
  emxInit_real32_T(&x, 2, &emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs_copy_idx_0), "x", x);
  fs = emlrt_marshallIn(emlrtAliasP(prhs[1]), "fs");
  fLims = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_2), "fLims");
  fOctave = emlrt_marshallIn(emlrtAliasP(prhs[3]), "fOctave");

  // Invoke the target function
  emxInit_real_T(&freqs, 1, &emlrtRTEI, true);
  ec_cwtAvg(x, fs, *fLims, fOctave, freqs);

  // Marshall function outputs
  x->canFreeData = false;
  emlrt_marshallOut(x, prhs_copy_idx_0);
  emxFree_real32_T(&x);
  plhs[0] = prhs_copy_idx_0;
  if (nlhs > 1) {
    freqs->canFreeData = false;
    plhs[1] = emlrt_marshallOut(freqs);
  }

  emxFree_real_T(&freqs);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ec_cwtAvg_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  mwCudaFree(*cpu_cv_gpu_clone);
}

void ec_cwtAvg_initialize()
{
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "distrib_computing_toolbox", 2);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "wavelet_toolbox", 2);
  cublasEnsureInitialization(CUBLAS_POINTER_MODE_HOST);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    ec_cwtAvg_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ec_cwtAvg_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode), (char_T *)
                       cudaGetErrorName(errCode), (char_T *)cudaGetErrorString
                       (errCode), (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }

  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  cublasEnsureDestruction();
  mwMemoryManagerTerminate();
}

// End of code generation (ec_cwtAvg.cu)
