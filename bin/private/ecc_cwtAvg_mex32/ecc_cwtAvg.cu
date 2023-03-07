//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecc_cwtAvg.cu
//
// Code generation for function 'ecc_cwtAvg'
//

// Include files
#include "ecc_cwtAvg.h"
#include "_coder_ecc_cwtAvg_mex.h"
#include "ecc_cwtAvg_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCUFFTPlanManager.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWMemoryManager.hpp"
#include "cufft.h"
#include "math_constants.h"
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

struct emxArray_creal32_T
{
  creal32_T *data;
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
  "ecc_cwtAvg",                        // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 1075284325U, 2201364878U, 3488609979U, 1269018621U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtMCInfo emlrtMCI{ 53,       // lineNo
  14,                                  // colNo
  "nonConstPrint",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtMCInfo b_emlrtMCI{ 55,     // lineNo
  15,                                  // colNo
  "nonConstPrint",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtRTEInfo emlrtRTEI{ 11,     // lineNo
  5,                                   // colNo
  "ecc_cwtAvg",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_cwtAvg.m"// pName
};

static emlrtRTEInfo b_emlrtRTEI{ 986,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 987,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 988,  // lineNo
  21,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 988,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 273,  // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 445,  // lineNo
  20,                                  // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 446,  // lineNo
  21,                                  // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 28,   // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 486,  // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 63,   // lineNo
  17,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 25,   // lineNo
  1,                                   // colNo
  "ecc_cwtAvg",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_cwtAvg.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 76,   // lineNo
  9,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 18,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 60,   // lineNo
  20,                                  // colNo
  "bsxfun",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/bsxfun.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 498,  // lineNo
  5,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 43,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 946,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 30,   // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 25,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 27,   // lineNo
  1,                                   // colNo
  "ecc_cwtAvg",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_cwtAvg.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 31,   // lineNo
  23,                                  // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 33,   // lineNo
  1,                                   // colNo
  "ecc_cwtAvg",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_cwtAvg.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 31,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 33,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 34,  // lineNo
  21,                                  // colNo
  "ecc_cwtAvg",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_cwtAvg.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 39,  // lineNo
  8,                                   // colNo
  "ecc_cwtAvg",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_cwtAvg.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 39,  // lineNo
  34,                                  // colNo
  "ecc_cwtAvg",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_cwtAvg.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 230, // lineNo
  1,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 102, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 135, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 143, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "cuFFTNDCallback",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+gpucoder/+internal/cuFFTNDCallback.p"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 138, // lineNo
  19,                                  // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 138, // lineNo
  6,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 161, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 164, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 180, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 22,  // lineNo
  32,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 12,  // lineNo
  5,                                   // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 28,  // lineNo
  47,                                  // colNo
  "numCpsi",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/numCpsi.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 211, // lineNo
  24,                                  // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 96,  // lineNo
  5,                                   // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 301, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 1,   // lineNo
  34,                                  // colNo
  "ecc_cwtAvg",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_cwtAvg.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 1256,// lineNo
  30,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 1256,// lineNo
  25,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 1,   // lineNo
  23,                                  // colNo
  "ecc_cwtAvg",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_cwtAvg.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 445, // lineNo
  1,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 924, // lineNo
  26,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 32,  // lineNo
  18,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 446, // lineNo
  1,                                   // colNo
  "quadgk",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/funfun/quadgk.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 21,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 32,  // lineNo
  13,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 63,  // lineNo
  20,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 63,  // lineNo
  34,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 63,  // lineNo
  60,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 64,  // lineNo
  31,                                  // colNo
  "morseproperties",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morseproperties.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 151, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 12,  // lineNo
  12,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 12,  // lineNo
  1,                                   // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 26,  // lineNo
  43,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 26,  // lineNo
  37,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 293, // lineNo
  14,                                  // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 28,  // lineNo
  46,                                  // colNo
  "numCpsi",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/numCpsi.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 28,  // lineNo
  36,                                  // colNo
  "numCpsi",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/numCpsi.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 293, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 28,  // lineNo
  23,                                  // colNo
  "numCpsi",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/numCpsi.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 28,  // lineNo
  19,                                  // colNo
  "numCpsi",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/numCpsi.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 295, // lineNo
  9,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 287, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "_coder_ecc_cwtAvg_api",             // fName
  ""                                   // pName
};

static char_T (*cv_gpu_clone)[128];
static boolean_T gpuConstsCopied_ecc_cwtAvg;

// Function Declarations
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real32_T *ret);
static real_T (*b_emlrt_marshallIn(const mxArray *fLims, const char_T
  *identifier))[2];
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2];
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_char_T *ret);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void c_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static real_T (*d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2];
static int32_T div_s32(int32_T numerator, int32_T denominator);
static __global__ void ecc_cwtAvg_kernel1(const emxArray_real32_T x, int32_T b_x,
  emxArray_real32_T c_x);
static __global__ void ecc_cwtAvg_kernel10(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecc_cwtAvg_kernel100(const emxArray_real_T x, int32_T
  lidx, emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecc_cwtAvg_kernel101(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel102(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel103(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ecc_cwtAvg_kernel104(const emxArray_real_T a, int32_T
  nrefine, emxArray_real_T dv19);
static __global__ void ecc_cwtAvg_kernel105(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel106(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv21);
static __global__ void ecc_cwtAvg_kernel107(int32_T nrefine, emxArray_real_T
  dv21);
static __global__ void ecc_cwtAvg_kernel108(const emxArray_real_T xt, const
  emxArray_real_T dv21, const emxArray_real_T dv19, int32_T b_dv19,
  emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel109(int16_T dv4_idx_1, emxArray_real_T
  fx);
static __global__ void ecc_cwtAvg_kernel11(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecc_cwtAvg_kernel110(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel111(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel112(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecc_cwtAvg_kernel113(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecc_cwtAvg_kernel114(const emxArray_real_T x, int32_T
  lidx, emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecc_cwtAvg_kernel115(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T dv23);
static __global__ void ecc_cwtAvg_kernel116(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel117(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv27);
static __global__ void ecc_cwtAvg_kernel118(int32_T nrefine, emxArray_real_T
  dv27);
static __global__ void ecc_cwtAvg_kernel119(const emxArray_real_T xt, const
  emxArray_real_T dv27, const emxArray_real_T dv23, int32_T b_dv23,
  emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel12(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel120(int16_T dv4_idx_1, emxArray_real_T
  fx);
static __global__ void ecc_cwtAvg_kernel121(real_T r, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel122(const emxArray_real_T y, const
  real_T toler, int32_T nrefine, emxArray_real_T b_y);
static __global__ void ecc_cwtAvg_kernel123(const emxArray_real_T y, const
  real_T r, int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ecc_cwtAvg_kernel124(int32_T fb_Scales, emxArray_real_T
  psidft);
static __global__ void ecc_cwtAvg_kernel125(const emxArray_real_T fb_Scales,
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ecc_cwtAvg_kernel126(const emxArray_real_T omega, const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, int32_T eint, const
  int32_T somega_dim0, emxArray_real_T somega);
static __global__ void ecc_cwtAvg_kernel127(const emxArray_real_T somega,
  int32_T nrefine, emxArray_real_T absomega);
static __global__ void ecc_cwtAvg_kernel128(const emxArray_real_T absomega,
  int32_T b_absomega, emxArray_real_T powscales);
static __global__ void ecc_cwtAvg_kernel129(int32_T nrefine, emxArray_real_T
  absomega);
static __global__ void ecc_cwtAvg_kernel13(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel130(const emxArray_real_T powscales,
  const emxArray_real_T absomega, int32_T b_absomega, emxArray_real_T x);
static __global__ void ecc_cwtAvg_kernel131(int32_T nrefine, emxArray_real_T x);
static __global__ void ecc_cwtAvg_kernel132(const emxArray_real_T somega, const
  emxArray_real_T x, int32_T b_x, emxArray_real_T psidft);
static __global__ void ecc_cwtAvg_kernel133(const emxArray_real_T fb_Scales,
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ecc_cwtAvg_kernel134(const real_T fs, int32_T k,
  emxArray_real_T f);
static __global__ void ecc_cwtAvg_kernel135(const emxArray_real_T f, int32_T
  lidx, emxArray_real_T freqs);
static __global__ void ecc_cwtAvg_kernel136(uint32_T N, emxArray_uint32_T ii);
static __global__ void ecc_cwtAvg_kernel137(const int32_T fb_CutOff, const
  emxArray_real32_T x, const emxArray_uint32_T ii, int32_T b_ii, const int32_T
  x_dim0, emxArray_real32_T b_x, emxArray_int32_T iv9);
static __global__ void ecc_cwtAvg_kernel138(const emxArray_real_T fb_Scales,
  int32_T b_fb_Scales, emxArray_real32_T Scales);
static __global__ void ecc_cwtAvg_kernel139(const emxArray_real_T psidft,
  int32_T b_psidft, emxArray_real32_T psihat);
static __global__ void ecc_cwtAvg_kernel14(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ecc_cwtAvg_kernel140(const emxArray_real32_T x, int32_T
  b_x, emxArray_real32_T xv);
static __global__ void ecc_cwtAvg_kernel141(const emxArray_real32_T x, int32_T
  fb_SignalPad, emxArray_real32_T b_x);
static __global__ void ecc_cwtAvg_kernel142(const emxArray_real32_T x, int32_T
  eint, emxArray_real32_T xv);
static __global__ void ecc_cwtAvg_kernel143(const emxArray_real32_T xv, int32_T
  b_xv, emxArray_creal32_T xposdft);
static __global__ void ecc_cwtAvg_kernel144(const emxArray_creal32_T xposdft,
  const emxArray_real32_T psihat, const int32_T nrefine, const int32_T acoef,
  const int32_T cfsposdft, int32_T lidx, const int32_T psihat_dim0, const
  int32_T cfsposdft_dim0, emxArray_creal32_T b_cfsposdft);
static __global__ void ecc_cwtAvg_kernel145(const int32_T cfsposdft_dim1,
  creal32_T *cfsposdft);
static __global__ void ecc_cwtAvg_kernel146(const creal32_T *cfsposdft, const
  emxArray_creal32_T b_cfsposdft, int32_T c_cfsposdft, emxArray_creal32_T cfspos);
static __global__ void ecc_cwtAvg_kernel147(const int32_T cfsposdft_dim1,
  uint32_T xSize[2]);
static __global__ void ecc_cwtAvg_kernel148(int32_T xSize, emxArray_creal32_T
  cfspos);
static __global__ void ecc_cwtAvg_kernel149(const emxArray_creal32_T cfspos,
  int32_T b_cfspos, emxArray_creal32_T cfs);
static __global__ void ecc_cwtAvg_kernel15(const emxArray_real_T a, int32_T
  nrefine, emxArray_real_T dv8);
static __global__ void ecc_cwtAvg_kernel150(const emxArray_creal32_T cfspos,
  const int32_T b_cfspos, const uint32_T N, uint32_T u, const int32_T cfs_dim0,
  const int32_T cfspos_dim0, emxArray_creal32_T cfs);
static __global__ void ecc_cwtAvg_kernel151(char_T wav[5]);
static __global__ void ecc_cwtAvg_kernel152(char_T wav[5], char_T b_dim0, char_T
  b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4);
static __global__ void ecc_cwtAvg_kernel153(const char_T wav[5], char_T wavname
  [5]);
static __global__ void ecc_cwtAvg_kernel154(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel155(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel156(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecc_cwtAvg_kernel157(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecc_cwtAvg_kernel158(const emxArray_real_T x, int32_T
  lidx, emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecc_cwtAvg_kernel159(const emxArray_real_T x, int32_T b_x,
  emxArray_real_T a);
static __global__ void ecc_cwtAvg_kernel16(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel160(const emxArray_real_T a, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel161(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T c_y);
static __global__ void ecc_cwtAvg_kernel162(int32_T nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel163(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T c_y);
static __global__ void ecc_cwtAvg_kernel164(const emxArray_real_T y, int32_T
  nrefine, emxArray_real_T b_y);
static __global__ void ecc_cwtAvg_kernel165(const emxArray_real_T xt, const
  emxArray_real_T x, const emxArray_real_T y, int32_T b_y, emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel166(int16_T dv4_idx_1, emxArray_real_T
  fx);
static __global__ void ecc_cwtAvg_kernel167(const emxArray_creal32_T cfs,
  int32_T nrefine, emxArray_real32_T y);
static __global__ void ecc_cwtAvg_kernel168(const emxArray_real32_T y, int32_T
  nrefine, emxArray_real32_T abscfssq);
static __global__ void ecc_cwtAvg_kernel169(const emxArray_real32_T abscfssq,
  int32_T b_abscfssq, emxArray_real32_T a);
static __global__ void ecc_cwtAvg_kernel17(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv12);
static __global__ void ecc_cwtAvg_kernel170(const emxArray_real32_T Scales,
  const emxArray_real32_T a, const int32_T acoef, const int32_T abscfssq,
  int32_T nrefine, const int32_T a_dim0, const int32_T Scales_dim1, const
  int32_T abscfssq_dim0, emxArray_real32_T b_abscfssq);
static __global__ void ecc_cwtAvg_kernel171(uint32_T N, emxArray_uint32_T y);
static __global__ void ecc_cwtAvg_kernel172(int32_T abscfssq, emxArray_real32_T
  z);
static __global__ void ecc_cwtAvg_kernel173(const emxArray_uint32_T y,
  emxArray_real_T c);
static __global__ void ecc_cwtAvg_kernel174(const emxArray_uint32_T y, int32_T
  lidx, emxArray_real_T c);
static __global__ void ecc_cwtAvg_kernel175(const emxArray_uint32_T y, const
  int32_T abscfssq_dim1, emxArray_real_T c);
static __global__ void ecc_cwtAvg_kernel176(const emxArray_uint32_T y, int32_T
  lidx, emxArray_real_T c);
static __global__ void ecc_cwtAvg_kernel177(const real_T r, emxArray_real_T c);
static __global__ void ecc_cwtAvg_kernel178(const real_T r, const int32_T
  abscfssq_dim1, emxArray_real_T c);
static __global__ void ecc_cwtAvg_kernel179(int32_T lidx, emxArray_real32_T z);
static __global__ void ecc_cwtAvg_kernel18(int32_T nrefine, emxArray_real_T dv12);
static __global__ void ecc_cwtAvg_kernel180(const emxArray_real32_T Scales,
  emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel181(const emxArray_real32_T Scales,
  int32_T lidx, emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel182(const emxArray_real32_T Scales,
  const int32_T z_dim0, emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel183(const emxArray_real32_T Scales,
  int32_T lidx, emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel184(real32_T *xbar, emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel185(const int32_T z_dim0, real32_T *xbar,
  emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel186(int32_T k, real32_T *xbar,
  emxArray_creal32_T cfs);
static __global__ void ecc_cwtAvg_kernel187(const emxArray_creal32_T cfs,
  int32_T nrefine, emxArray_real32_T y);
static __global__ void ecc_cwtAvg_kernel188(const emxArray_real32_T y, int32_T
  nrefine, emxArray_real32_T abswt2);
static __global__ void ecc_cwtAvg_kernel189(const emxArray_real32_T Scales,
  const emxArray_real32_T abswt2, const int32_T acoef, const int32_T abswt2S,
  int32_T lidx, const int32_T abswt2_dim0, const int32_T Scales_dim1, const
  int32_T abswt2S_dim0, emxArray_real32_T b_abswt2S);
static __global__ void ecc_cwtAvg_kernel19(const emxArray_real_T xt, const
  emxArray_real_T dv12, const emxArray_real_T dv8, int32_T b_dv8,
  emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel190(int32_T abswt2S, emxArray_real32_T
  savgpTMP);
static __global__ void ecc_cwtAvg_kernel191(const emxArray_real32_T Scales,
  emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel192(const emxArray_real32_T Scales,
  int32_T lidx, emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel193(const emxArray_real32_T Scales,
  const int32_T abswt2S_dim0, emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel194(const emxArray_real32_T Scales,
  int32_T lidx, emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel195(real32_T *xbar, emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel196(const int32_T abswt2S_dim0, real32_T
  *xbar, emxArray_real32_T c);
static __global__ void ecc_cwtAvg_kernel197(int32_T abswt2S, emxArray_real32_T
  savgpTMP);
static __global__ void ecc_cwtAvg_kernel198(const emxArray_real32_T savgpTMP,
  const int32_T fb_CutOff, const emxArray_int32_T iv9, int32_T lidx, const
  int32_T xx_dim0, emxArray_real32_T xx);
static __global__ void ecc_cwtAvg_kernel2(const emxArray_real32_T x, int32_T b_x,
  emxArray_real32_T c_x);
static __global__ void ecc_cwtAvg_kernel20(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel21(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel22(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel23(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecc_cwtAvg_kernel24(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecc_cwtAvg_kernel25(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecc_cwtAvg_kernel26(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T dv15);
static __global__ void ecc_cwtAvg_kernel27(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel28(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv17);
static __global__ void ecc_cwtAvg_kernel29(int32_T nrefine, emxArray_real_T dv17);
static __global__ void ecc_cwtAvg_kernel3(const real_T fLims[2], boolean_T b[2]);
static __global__ void ecc_cwtAvg_kernel30(const emxArray_real_T xt, const
  emxArray_real_T dv17, const emxArray_real_T dv15, int32_T b_dv15,
  emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel31(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel32(const real_T r, real_T freqrange[2],
  real_T fLims[2]);
static __global__ void ecc_cwtAvg_kernel33(const real_T fs, real_T freqrange[2],
  real_T fLims[2]);
static __global__ void ecc_cwtAvg_kernel34(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel35(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel36(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecc_cwtAvg_kernel37(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecc_cwtAvg_kernel38(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecc_cwtAvg_kernel39(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel4(const real_T fLims[2], real_T
  freqrange[2]);
static __global__ void ecc_cwtAvg_kernel40(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel41(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ecc_cwtAvg_kernel42(const emxArray_real_T a, int32_T
  nrefine, emxArray_real_T dv5);
static __global__ void ecc_cwtAvg_kernel43(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel44(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv9);
static __global__ void ecc_cwtAvg_kernel45(int32_T nrefine, emxArray_real_T dv9);
static __global__ void ecc_cwtAvg_kernel46(const emxArray_real_T xt, const
  emxArray_real_T dv9, const emxArray_real_T dv5, int32_T b_dv5, emxArray_real_T
  fx);
static __global__ void ecc_cwtAvg_kernel47(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel48(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel49(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel5(const real_T fs, real_T NyquistRange[2]);
static __global__ void ecc_cwtAvg_kernel50(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecc_cwtAvg_kernel51(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecc_cwtAvg_kernel52(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecc_cwtAvg_kernel53(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T dv11);
static __global__ void ecc_cwtAvg_kernel54(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel55(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv14);
static __global__ void ecc_cwtAvg_kernel56(int32_T nrefine, emxArray_real_T dv14);
static __global__ void ecc_cwtAvg_kernel57(const emxArray_real_T xt, const
  emxArray_real_T dv14, const emxArray_real_T dv11, int32_T b_dv11,
  emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel58(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel59(int32_T lidx, emxArray_real_T omega);
static __global__ void ecc_cwtAvg_kernel6(const char_T cv[128], char_T wav[5],
  char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4);
static __global__ void ecc_cwtAvg_kernel60(const uint32_T N, int32_T k,
  emxArray_real_T omega);
static __global__ void ecc_cwtAvg_kernel61(emxArray_real_T r);
static __global__ void ecc_cwtAvg_kernel62(const emxArray_real_T omega, int32_T
  eint, emxArray_real_T r);
static __global__ void ecc_cwtAvg_kernel63(const int32_T lidx, const int32_T
  acoef, const emxArray_real_T omega, int32_T eint, const int32_T omega_dim1,
  emxArray_real_T r);
static __global__ void ecc_cwtAvg_kernel64(const emxArray_real_T r, int32_T b_r,
  emxArray_real_T omega);
static __global__ void ecc_cwtAvg_kernel65(const real_T fLims[2], boolean_T b[2]);
static __global__ void ecc_cwtAvg_kernel66(const char_T cv[128], char_T wav[5],
  char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4);
static __global__ void ecc_cwtAvg_kernel67(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel68(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel69(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecc_cwtAvg_kernel7(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel70(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecc_cwtAvg_kernel71(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecc_cwtAvg_kernel72(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel73(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel74(const emxArray_real_T y, const
  emxArray_real_T b_y, int32_T c_y, emxArray_real_T a);
static __global__ void ecc_cwtAvg_kernel75(const emxArray_real_T a, int32_T
  nrefine, emxArray_real_T dv20);
static __global__ void ecc_cwtAvg_kernel76(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel77(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv24);
static __global__ void ecc_cwtAvg_kernel78(int32_T nrefine, emxArray_real_T dv24);
static __global__ void ecc_cwtAvg_kernel79(const emxArray_real_T xt, const
  emxArray_real_T dv24, const emxArray_real_T dv20, int32_T b_dv20,
  emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel8(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel80(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel81(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel82(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel83(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecc_cwtAvg_kernel84(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static __global__ void ecc_cwtAvg_kernel85(const emxArray_real_T x, int32_T lidx,
  emxArray_real_T xt, emxArray_real_T b_x);
static __global__ void ecc_cwtAvg_kernel86(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T dv26);
static __global__ void ecc_cwtAvg_kernel87(const emxArray_real_T x, int32_T
  nrefine, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel88(const emxArray_real_T y, int32_T b_y,
  emxArray_real_T dv29);
static __global__ void ecc_cwtAvg_kernel89(int32_T nrefine, emxArray_real_T dv29);
static __global__ void ecc_cwtAvg_kernel9(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecc_cwtAvg_kernel90(const emxArray_real_T xt, const
  emxArray_real_T dv29, const emxArray_real_T dv26, int32_T b_dv26,
  emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel91(int16_T dv4_idx_1, emxArray_real_T fx);
static __global__ void ecc_cwtAvg_kernel92(real_T r, emxArray_real_T y);
static __global__ void ecc_cwtAvg_kernel93(const emxArray_real_T y, const real_T
  delta, int32_T nrefine, emxArray_real_T b_y);
static __global__ void ecc_cwtAvg_kernel94(const emxArray_real_T y, const real_T
  r, int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ecc_cwtAvg_kernel95(const real_T fs, const real_T fLims[2],
  real_T NyquistRange[2]);
static __global__ void ecc_cwtAvg_kernel96(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel97(real_T interval[650]);
static __global__ void ecc_cwtAvg_kernel98(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ecc_cwtAvg_kernel99(const real_T interval[650], int32_T
  nsubs, real_T subs[1298]);
static void ecc_cwtAvg_once();
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real32_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_char_T *y);
static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
  emxArray_char_T *y);
static real_T emlrt_marshallIn(const mxArray *a__output_of_length_, const char_T
  *identifier);
static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u);
static void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_creal32_T(emxArray_creal32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_uint32_T(emxArray_uint32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxFree_char_T(emxArray_char_T **pEmxArray);
static void emxFree_creal32_T(emxArray_creal32_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_real32_T(emxArray_real32_T **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxFree_uint32_T(emxArray_uint32_T **pEmxArray);
static void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_creal32_T(emxArray_creal32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_uint32_T(emxArray_uint32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static const mxArray *feval(const mxArray *m1, const mxArray *m2, const mxArray *
  m3, emlrtMCInfo *location);
static void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
  emxArray_creal32_T *gpu);
static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu);
static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
  emxArray_real32_T *gpu);
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu);
static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu);
static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
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
static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);
static void gpuEmxReset_real32_T(emxArray_real32_T *gpu);
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu);
static const mxArray *length(const mxArray *m1, emlrtMCInfo *location);
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
  emxEnsureCapacity_real_T(in1, i, &r_emlrtRTEI);
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

  emxEnsureCapacity_real_T(in1, i, &x_emlrtRTEI);
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

static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2]
{
  real_T (*y)[2];
  y = d_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
*msgId, emxArray_real32_T *ret)
{
  static const int32_T dims[2]{ -1, -1 };
  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2]{ true, true };

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
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
const emxArray_real_T *in3, const emxArray_real_T *in4)
{
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  in1->size[1] = in4->size[1];
  emxEnsureCapacity_real_T(in1, i, &r_emlrtRTEI);
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

  emxEnsureCapacity_real_T(in1, i, &ab_emlrtRTEI);
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

  emxEnsureCapacity_real_T(in1, i, &l_emlrtRTEI);
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel1(const
  emxArray_real32_T x, int32_T b_x, emxArray_real32_T c_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    c_x.data[bcoef] = x.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel10(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel100(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel101(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel102(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel103(const
  emxArray_real_T y, const emxArray_real_T b_y, int32_T c_y, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = 20.0 * b_y.data[bcoef] - 3.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel104(const
  emxArray_real_T a, int32_T nrefine, emxArray_real_T dv19)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a.data[k];
    dv19.data[k] = d * d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel105(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel106(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv21)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    dv21.data[bcoef] = -2.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel107(int32_T
  nrefine, emxArray_real_T dv21)
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
    dv21.data[k] = exp(dv21.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel108(const
  emxArray_real_T xt, const emxArray_real_T dv21, const emxArray_real_T dv19,
  int32_T b_dv19, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv19);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = dv19.data[bcoef] * dv21.data[bcoef] * xt.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel109(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel11(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel110(real_T
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

static __global__ __launch_bounds__(512, 1) void ecc_cwtAvg_kernel111(real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel112(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel113(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel114(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel115(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T dv23)
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
    dv23.data[k] = pow(x.data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel116(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel117(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv27)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    dv27.data[bcoef] = -2.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel118(int32_T
  nrefine, emxArray_real_T dv27)
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
    dv27.data[k] = exp(dv27.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel119(const
  emxArray_real_T xt, const emxArray_real_T dv27, const emxArray_real_T dv23,
  int32_T b_dv23, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv23);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = dv23.data[bcoef] * dv27.data[bcoef] * xt.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel12(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel120(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel121(real_T r,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(r));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y.data[bcoef] = bcoef;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel122(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel123(const
  emxArray_real_T y, const real_T r, int32_T b_y, emxArray_real_T fb_Scales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fb_Scales.data[bcoef] = r * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel124(int32_T
  fb_Scales, emxArray_real_T psidft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    psidft.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel125(const
  emxArray_real_T fb_Scales, int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    f.data[bcoef] = 0.0 / fb_Scales.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel126(const
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
    int32_T acoef;
    int32_T bcoef;
    acoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fb_Scales) + 1UL));
    bcoef = static_cast<int32_T>((idx - static_cast<uint64_T>(acoef)) / (
      static_cast<uint64_T>(b_fb_Scales) + 1UL));
    somega.data[acoef + somega_dim0 * bcoef] = fb_Scales.data[acoef] *
      omega.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel127(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel128(const
  emxArray_real_T absomega, int32_T b_absomega, emxArray_real_T powscales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_absomega);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    powscales.data[bcoef] = absomega.data[bcoef] * absomega.data[bcoef] *
      absomega.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel129(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel13(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel130(const
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
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    x.data[bcoef] = 20.0 * absomega.data[bcoef] - powscales.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel131(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel132(const
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
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    psidft.data[bcoef] = 0.0050536085896138528 * x.data[bcoef] *
      static_cast<real_T>(somega.data[bcoef] > 0.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel133(const
  emxArray_real_T fb_Scales, int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    f.data[bcoef] = 1.8820720577620569 / fb_Scales.data[bcoef] /
      6.2831853071795862;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel134(const
  real_T fs, int32_T k, emxArray_real_T f)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(k - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    f.data[bcoef] *= fs;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel135(const
  emxArray_real_T f, int32_T lidx, emxArray_real_T freqs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    freqs.data[bcoef] = f.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel136(uint32_T
  N, emxArray_uint32_T ii)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(N) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    ii.data[bcoef] = static_cast<uint32_T>(bcoef) + 1U;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel137(const
  int32_T fb_CutOff, const emxArray_real32_T x, const emxArray_uint32_T ii,
  int32_T b_ii, const int32_T x_dim0, emxArray_real32_T b_x, emxArray_int32_T
  iv9)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_ii);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    iv9.data[bcoef] = static_cast<int32_T>(ii.data[bcoef]) - 1;
    b_x.data[bcoef] = x.data[(static_cast<int32_T>(ii.data[bcoef]) + x_dim0 *
      fb_CutOff) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel138(const
  emxArray_real_T fb_Scales, int32_T b_fb_Scales, emxArray_real32_T Scales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    Scales.data[bcoef] = static_cast<real32_T>(fb_Scales.data[bcoef]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel139(const
  emxArray_real_T psidft, int32_T b_psidft, emxArray_real32_T psihat)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_psidft);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    psihat.data[bcoef] = static_cast<real32_T>(psidft.data[bcoef]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel14(const
  emxArray_real_T y, const emxArray_real_T b_y, int32_T c_y, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = 20.0 * b_y.data[bcoef] - 3.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel140(const
  emxArray_real32_T x, int32_T b_x, emxArray_real32_T xv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xv.data[bcoef] = x.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel141(const
  emxArray_real32_T x, int32_T fb_SignalPad, emxArray_real32_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fb_SignalPad - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    b_x.data[bcoef] = x.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel142(const
  emxArray_real32_T x, int32_T eint, emxArray_real32_T xv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(eint);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xv.data[bcoef] = x.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel143(const
  emxArray_real32_T xv, int32_T b_xv, emxArray_creal32_T xposdft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xv);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xposdft.data[bcoef].re = xv.data[bcoef];
    xposdft.data[bcoef].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel144(const
  emxArray_creal32_T xposdft, const emxArray_real32_T psihat, const int32_T
  nrefine, const int32_T acoef, const int32_T cfsposdft, int32_T lidx, const
  int32_T psihat_dim0, const int32_T cfsposdft_dim0, emxArray_creal32_T
  b_cfsposdft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(cfsposdft) + 1UL) * (static_cast<uint64_T>
    (lidx - 1) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_acoef;
    int32_T b_k;
    int32_T bcoef;
    int32_T k;
    int32_T varargin_2;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(cfsposdft) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) /
      (static_cast<uint64_T>(cfsposdft) + 1UL));
    varargin_2 = acoef * k + 1;
    b_acoef = nrefine * k + 1;
    bcoef = (psihat_dim0 != 1);
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].re = psihat.data[bcoef * b_k +
      psihat_dim0 * (b_acoef - 1)] * xposdft.data[varargin_2 - 1].re;
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].im = psihat.data[bcoef * b_k +
      psihat_dim0 * (b_acoef - 1)] * xposdft.data[varargin_2 - 1].im;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel145(const
  int32_T cfsposdft_dim1, creal32_T *cfsposdft)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    cfsposdft->re = static_cast<real32_T>(cfsposdft_dim1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel146(const
  creal32_T *cfsposdft, const emxArray_creal32_T b_cfsposdft, int32_T
  c_cfsposdft, emxArray_creal32_T cfspos)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_cfsposdft);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    real32_T ai;
    real32_T ar;
    bcoef = static_cast<int32_T>(idx);
    ar = b_cfsposdft.data[bcoef].re;
    ai = b_cfsposdft.data[bcoef].im;
    if (ai == 0.0F) {
      cfspos.data[bcoef].re = ar / cfsposdft->re;
      cfspos.data[bcoef].im = 0.0F;
    } else if (ar == 0.0F) {
      cfspos.data[bcoef].re = 0.0F;
      cfspos.data[bcoef].im = ai / cfsposdft->re;
    } else {
      cfspos.data[bcoef].re = ar / cfsposdft->re;
      cfspos.data[bcoef].im = ai / cfsposdft->re;
    }
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel147(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel148(int32_T
  xSize, emxArray_creal32_T cfspos)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xSize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    cfspos.data[bcoef].re = 0.0F;
    cfspos.data[bcoef].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel149(const
  emxArray_creal32_T cfspos, int32_T b_cfspos, emxArray_creal32_T cfs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfspos);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    cfs.data[bcoef] = cfspos.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel15(const
  emxArray_real_T a, int32_T nrefine, emxArray_real_T dv8)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a.data[k];
    dv8.data[k] = d * d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel150(const
  emxArray_creal32_T cfspos, const int32_T b_cfspos, const uint32_T N, uint32_T
  u, const int32_T cfs_dim0, const int32_T cfspos_dim0, emxArray_creal32_T cfs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_cfspos) + 1UL) * (static_cast<uint64_T>(
    static_cast<int32_T>(u) - static_cast<int32_T>(N)) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T acoef;
    int32_T bcoef;
    acoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_cfspos) + 1UL));
    bcoef = static_cast<int32_T>((idx - static_cast<uint64_T>(acoef)) / (
      static_cast<uint64_T>(b_cfspos) + 1UL));
    cfs.data[acoef + cfs_dim0 * bcoef] = cfspos.data[acoef + cfspos_dim0 * ((
      static_cast<int32_T>(N) + bcoef) - 1)];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel151(char_T wav
  [5])
{
  uint64_T threadId;
  int32_T bcoef;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  bcoef = static_cast<int32_T>(threadId);
  if (bcoef < 5) {
    wav[bcoef] = ' ';
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel152(char_T wav
  [5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3, char_T b_dim4)
{
  __shared__ char_T b_shared[5];
  uint64_T threadId;
  int32_T bcoef;
  if (mwGetThreadIndexWithinBlock() == 0) {
    b_shared[0] = b_dim0;
    b_shared[1] = b_dim1;
    b_shared[2] = b_dim2;
    b_shared[3] = b_dim3;
    b_shared[4] = b_dim4;
  }

  __syncthreads();
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  bcoef = static_cast<int32_T>(threadId);
  if (bcoef < 5) {
    wav[bcoef] = b_shared[bcoef];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel153(const
  char_T wav[5], char_T wavname[5])
{
  uint64_T threadId;
  int32_T bcoef;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  bcoef = static_cast<int32_T>(threadId);
  if (bcoef < 5) {
    wavname[bcoef] = wav[bcoef];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel154(real_T
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

static __global__ __launch_bounds__(512, 1) void ecc_cwtAvg_kernel155(real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel156(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel157(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel158(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel159(const
  emxArray_real_T x, int32_T b_x, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = (x.data[bcoef] - 5.0) / 0.6;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel16(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel160(const
  emxArray_real_T a, int32_T nrefine, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a.data[k];
    y.data[k] = d * d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel161(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T c_y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    c_y.data[bcoef] = -2.0 * (1.0 / (1.0 - y.data[bcoef]));
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel162(int32_T
  nrefine, emxArray_real_T y)
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
    y.data[k] = exp(y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel163(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T c_y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    c_y.data[bcoef] = 14.7781121978613 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel164(const
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
    b_y.data[k] = fabs(y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel165(const
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
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = y.data[bcoef] / x.data[bcoef] * xt.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel166(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel167(const
  emxArray_creal32_T cfs, int32_T nrefine, emxArray_real32_T y)
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
    y.data[k] = hypotf(cfs.data[k].re, cfs.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel168(const
  emxArray_real32_T y, int32_T nrefine, emxArray_real32_T abscfssq)
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
    abscfssq.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel169(const
  emxArray_real32_T abscfssq, int32_T b_abscfssq, emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_abscfssq);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = abscfssq.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel17(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv12)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    dv12.data[bcoef] = -2.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel170(const
  emxArray_real32_T Scales, const emxArray_real32_T a, const int32_T acoef,
  const int32_T abscfssq, int32_T nrefine, const int32_T a_dim0, const int32_T
  Scales_dim1, const int32_T abscfssq_dim0, emxArray_real32_T b_abscfssq)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(abscfssq) + 1UL) * (static_cast<uint64_T>
    (nrefine - 1) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_k;
    int32_T k;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(abscfssq) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) / (static_cast<
      uint64_T>(abscfssq) + 1UL));
    b_abscfssq.data[b_k + abscfssq_dim0 * k] = a.data[(a_dim0 != 1) * b_k +
      a_dim0 * (acoef * k)] / Scales.data[(Scales_dim1 != 1) * b_k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel171(uint32_T
  N, emxArray_uint32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(N) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y.data[bcoef] = static_cast<uint32_T>(bcoef) + 1U;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel172(int32_T
  abscfssq, emxArray_real32_T z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abscfssq);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    z.data[bcoef] = 0.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel173(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel174(const
  emxArray_uint32_T y, int32_T lidx, emxArray_real_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c.data[k + 1] = 0.5 * static_cast<real_T>(static_cast<int32_T>(y.data[k + 2])
      - static_cast<int32_T>(y.data[k]));
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel175(const
  emxArray_uint32_T y, const int32_T abscfssq_dim1, emxArray_real_T c)
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel176(const
  emxArray_uint32_T y, int32_T lidx, emxArray_real_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    c.data[bcoef] = y.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel177(const
  real_T r, emxArray_real_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[0] = r;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel178(const
  real_T r, const int32_T abscfssq_dim1, emxArray_real_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[abscfssq_dim1 - 1] = r;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel179(int32_T
  lidx, emxArray_real32_T z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T acoef;
    acoef = static_cast<int32_T>(idx);
    z.data[acoef] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel18(int32_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel180(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel181(const
  emxArray_real32_T Scales, int32_T lidx, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c.data[k + 1] = 0.5F * (Scales.data[k + 2] - Scales.data[k]);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel182(const
  emxArray_real32_T Scales, const int32_T z_dim0, emxArray_real32_T c)
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel183(const
  emxArray_real32_T Scales, int32_T lidx, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    c.data[bcoef] = Scales.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel184(real32_T
  *xbar, emxArray_real32_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[0] = *xbar;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel185(const
  int32_T z_dim0, real32_T *xbar, emxArray_real32_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[z_dim0 - 1] = *xbar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel186(int32_T k,
  real32_T *xbar, emxArray_creal32_T cfs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(k - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    cfs.data[bcoef].re *= *xbar;
    cfs.data[bcoef].im *= *xbar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel187(const
  emxArray_creal32_T cfs, int32_T nrefine, emxArray_real32_T y)
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
    y.data[k] = hypotf(cfs.data[k].re, cfs.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel188(const
  emxArray_real32_T y, int32_T nrefine, emxArray_real32_T abswt2)
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
    abswt2.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel189(const
  emxArray_real32_T Scales, const emxArray_real32_T abswt2, const int32_T acoef,
  const int32_T abswt2S, int32_T lidx, const int32_T abswt2_dim0, const int32_T
  Scales_dim1, const int32_T abswt2S_dim0, emxArray_real32_T b_abswt2S)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(abswt2S) + 1UL) * (static_cast<uint64_T>(lidx
    - 1) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_k;
    int32_T k;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(abswt2S) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) /
      (static_cast<uint64_T>(abswt2S) + 1UL));
    b_abswt2S.data[b_k + abswt2S_dim0 * k] = abswt2.data[(abswt2_dim0 != 1) *
      b_k + abswt2_dim0 * (acoef * k)] / Scales.data[(Scales_dim1 != 1) * b_k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel19(const
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
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = dv8.data[bcoef] * dv12.data[bcoef] * xt.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel190(int32_T
  abswt2S, emxArray_real32_T savgpTMP)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abswt2S);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    savgpTMP.data[bcoef] = 0.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel191(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel192(const
  emxArray_real32_T Scales, int32_T lidx, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c.data[k + 1] = 0.5F * (Scales.data[k + 2] - Scales.data[k]);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel193(const
  emxArray_real32_T Scales, const int32_T abswt2S_dim0, emxArray_real32_T c)
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel194(const
  emxArray_real32_T Scales, int32_T lidx, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    c.data[bcoef] = Scales.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel195(real32_T
  *xbar, emxArray_real32_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[0] = *xbar;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel196(const
  int32_T abswt2S_dim0, real32_T *xbar, emxArray_real32_T c)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    c.data[abswt2S_dim0 - 1] = *xbar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel197(int32_T
  abswt2S, emxArray_real32_T savgpTMP)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abswt2S);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    savgpTMP.data[bcoef] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel198(const
  emxArray_real32_T savgpTMP, const int32_T fb_CutOff, const emxArray_int32_T
  iv9, int32_T lidx, const int32_T xx_dim0, emxArray_real32_T xx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xx.data[iv9.data[bcoef] + xx_dim0 * fb_CutOff] = savgpTMP.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel2(const
  emxArray_real32_T x, int32_T b_x, emxArray_real32_T c_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    c_x.data[bcoef] = x.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel20(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel21(real_T
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

static __global__ __launch_bounds__(512, 1) void ecc_cwtAvg_kernel22(real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel23(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel24(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel25(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel26(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel27(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel28(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv17)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    dv17.data[bcoef] = -2.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel29(int32_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel3(const real_T
  fLims[2], boolean_T b[2])
{
  uint64_T threadId;
  int32_T bcoef;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  bcoef = static_cast<int32_T>(threadId);
  if (bcoef < 2) {
    b[bcoef] = isnan(fLims[bcoef]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel30(const
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
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = dv15.data[bcoef] * dv17.data[bcoef] * xt.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel31(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel32(const real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel33(const real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel34(real_T
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

static __global__ __launch_bounds__(512, 1) void ecc_cwtAvg_kernel35(real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel36(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel37(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel38(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel39(const
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel4(const real_T
  fLims[2], real_T freqrange[2])
{
  uint64_T threadId;
  int32_T bcoef;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  bcoef = static_cast<int32_T>(threadId);
  if (bcoef < 2) {
    freqrange[bcoef] = fLims[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel40(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel41(const
  emxArray_real_T y, const emxArray_real_T b_y, int32_T c_y, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = 20.0 * b_y.data[bcoef] - 3.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel42(const
  emxArray_real_T a, int32_T nrefine, emxArray_real_T dv5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a.data[k];
    dv5.data[k] = d * d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel43(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel44(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv9)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    dv9.data[bcoef] = -2.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel45(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel46(const
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
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = dv5.data[bcoef] * dv9.data[bcoef] * xt.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel47(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel48(real_T
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

static __global__ __launch_bounds__(512, 1) void ecc_cwtAvg_kernel49(real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel5(const real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel50(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel51(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel52(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel53(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel54(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel55(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv14)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    dv14.data[bcoef] = -2.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel56(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel57(const
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
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = dv11.data[bcoef] * dv14.data[bcoef] * xt.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel58(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel59(int32_T
  lidx, emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    omega.data[bcoef] = static_cast<real_T>(bcoef) + 1.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel6(const char_T
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel60(const
  uint32_T N, int32_T k, emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(k - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    omega.data[bcoef] = omega.data[bcoef] * 6.2831853071795862 /
      static_cast<real_T>(N);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel61
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel62(const
  emxArray_real_T omega, int32_T eint, emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(eint);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    r.data[bcoef + 1] = omega.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel63(const
  int32_T lidx, const int32_T acoef, const emxArray_real_T omega, int32_T eint,
  const int32_T omega_dim1, emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(eint);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    r.data[(bcoef + omega_dim1) + 1] = -omega.data[acoef + lidx * bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel64(const
  emxArray_real_T r, int32_T b_r, emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_r);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    omega.data[bcoef] = r.data[bcoef];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel65(const real_T
  fLims[2], boolean_T b[2])
{
  uint64_T threadId;
  int32_T bcoef;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  bcoef = static_cast<int32_T>(threadId);
  if (bcoef < 2) {
    b[bcoef] = isnan(fLims[bcoef]);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel66(const char_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel67(real_T
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

static __global__ __launch_bounds__(512, 1) void ecc_cwtAvg_kernel68(real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel69(const
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel7(real_T
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel70(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel71(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel72(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel73(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel74(const
  emxArray_real_T y, const emxArray_real_T b_y, int32_T c_y, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = 20.0 * b_y.data[bcoef] - 3.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel75(const
  emxArray_real_T a, int32_T nrefine, emxArray_real_T dv20)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a.data[k];
    dv20.data[k] = d * d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel76(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel77(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv24)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    dv24.data[bcoef] = -2.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel78(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel79(const
  emxArray_real_T xt, const emxArray_real_T dv24, const emxArray_real_T dv20,
  int32_T b_dv20, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv20);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = dv20.data[bcoef] * dv24.data[bcoef] * xt.data[bcoef];
  }
}

static __global__ __launch_bounds__(512, 1) void ecc_cwtAvg_kernel8(real_T
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel80(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel81(real_T
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

static __global__ __launch_bounds__(512, 1) void ecc_cwtAvg_kernel82(real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel83(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel84(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel85(const
  emxArray_real_T x, int32_T lidx, emxArray_real_T xt, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(lidx);
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel86(const
  emxArray_real_T x, int32_T nrefine, emxArray_real_T dv26)
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
    dv26.data[k] = pow(x.data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel87(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel88(const
  emxArray_real_T y, int32_T b_y, emxArray_real_T dv29)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    dv29.data[bcoef] = -2.0 * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel89(int32_T
  nrefine, emxArray_real_T dv29)
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
    dv29.data[k] = exp(dv29.data[k]);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel9(const int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel90(const
  emxArray_real_T xt, const emxArray_real_T dv29, const emxArray_real_T dv26,
  int32_T b_dv26, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv26);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = dv26.data[bcoef] * dv29.data[bcoef] * xt.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel91(int16_T
  dv4_idx_1, emxArray_real_T fx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel92(real_T r,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(r));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y.data[bcoef] = bcoef;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel93(const
  emxArray_real_T y, const real_T delta, int32_T nrefine, emxArray_real_T b_y)
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
    b_y.data[k] = pow(delta, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel94(const
  emxArray_real_T y, const real_T r, int32_T b_y, emxArray_real_T fb_Scales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fb_Scales.data[bcoef] = r * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel95(const real_T
  fs, const real_T fLims[2], real_T NyquistRange[2])
{
  uint64_T threadId;
  int32_T bcoef;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  bcoef = static_cast<int32_T>(threadId);
  if (bcoef < 2) {
    NyquistRange[bcoef] = fLims[bcoef] / fs * 2.0 * 3.1415926535897931;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel96(real_T
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

static __global__ __launch_bounds__(512, 1) void ecc_cwtAvg_kernel97(real_T
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

static __global__ __launch_bounds__(32, 1) void ecc_cwtAvg_kernel98(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_cwtAvg_kernel99(const
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

static void ecc_cwtAvg_once()
{
  mwMemoryManagerInit(256U, 1U, 8U, 8192U);
  mwCudaMalloc(&cv_gpu_clone, static_cast<uint64_T>(sizeof(char_T [128])));
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
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

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_char_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u)
{
  static const int32_T iv[2]{ 0, 0 };

  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxSINGLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 2);
  emlrtAssign(&y, m);
  return y;
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
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

static void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
  emxArray_creal32_T *gpu)
{
  creal32_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
      (cpu->allocatedSize) * sizeof(creal32_T)));
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
        (cpu->allocatedSize) * sizeof(creal32_T)));
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

static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
  emxArray_real32_T *gpu)
{
  real32_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
      (cpu->allocatedSize) * sizeof(real32_T)));
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
        (cpu->allocatedSize) * sizeof(real32_T)));
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

static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu)
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
    mwCudaMalloc(&gpu->data, static_cast<uint64_T>(static_cast<uint32_T>
      (gpu->allocatedSize) * sizeof(creal32_T)));
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
    mwCudaMalloc(&gpu->data, static_cast<uint64_T>(static_cast<uint32_T>
      (gpu->allocatedSize) * sizeof(real32_T)));
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
    mwCudaMalloc(&gpu->data, static_cast<uint64_T>(static_cast<uint32_T>
      (gpu->allocatedSize) * sizeof(real_T)));
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

static void gpuEmxReset_int32_T(emxArray_int32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_int32_T));
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
// function [xx,freqs] = ecc_cwtAvg(x,fs,fLims,fOctave)
void ecc_cwtAvg(const emxArray_real32_T *x, real_T fs, real_T fLims[2], real_T
                fOctave, emxArray_real32_T *xx, emxArray_real_T *freqs)
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

  static const int32_T iv2[2]{ 1, 7 };

  static const int32_T iv3[2]{ 1, 2 };

  static const int32_T iv4[2]{ 1, 7 };

  static const int32_T iv5[2]{ 1, 5 };

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

  static const char_T u[7]{ 's', 'p', 'r', 'i', 'n', 't', 'f' };

  static const char_T b_b[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T b_formatSpec[5]{ '%', '2', '.', '2', 'f' };

  static const char_T cv2[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T cv3[5]{ 'm', 'o', 'r', 's', 'e' };

  static const char_T formatSpec[2]{ '%', 'f' };

  dim3 block;
  dim3 grid;
  emxArray_char_T *d_tmpStr;
  emxArray_char_T *tmpStr;
  emxArray_creal32_T gpu_cfs;
  emxArray_creal32_T gpu_cfspos;
  emxArray_creal32_T gpu_cfsposdft;
  emxArray_creal32_T gpu_xposdft;
  emxArray_creal32_T *cfs;
  emxArray_creal32_T *cfspos;
  emxArray_creal32_T *cfsposdft;
  emxArray_creal32_T *xposdft;
  emxArray_int32_T gpu_iv9;
  emxArray_int32_T *iv9;
  emxArray_real32_T b_gpu_c;
  emxArray_real32_T b_gpu_x;
  emxArray_real32_T c_gpu_c;
  emxArray_real32_T e_gpu_a;
  emxArray_real32_T gpu_Scales;
  emxArray_real32_T gpu_abscfssq;
  emxArray_real32_T gpu_abswt2;
  emxArray_real32_T gpu_abswt2S;
  emxArray_real32_T gpu_psihat;
  emxArray_real32_T gpu_savgpTMP;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_xv;
  emxArray_real32_T gpu_xx;
  emxArray_real32_T gpu_z;
  emxArray_real32_T t_gpu_x;
  emxArray_real32_T u_gpu_x;
  emxArray_real32_T u_gpu_y;
  emxArray_real32_T y_gpu_y;
  emxArray_real32_T *Scales;
  emxArray_real32_T *abscfssq;
  emxArray_real32_T *abswt2;
  emxArray_real32_T *abswt2S;
  emxArray_real32_T *b_x;
  emxArray_real32_T *bb_y;
  emxArray_real32_T *c_c;
  emxArray_real32_T *d_c;
  emxArray_real32_T *db_y;
  emxArray_real32_T *f_a;
  emxArray_real32_T *psihat;
  emxArray_real32_T *savgpTMP;
  emxArray_real32_T *t_x;
  emxArray_real32_T *u_x;
  emxArray_real32_T *xv;
  emxArray_real32_T *z;
  emxArray_real_T ab_gpu_y;
  emxArray_real_T b_gpu_a;
  emxArray_real_T b_gpu_fx;
  emxArray_real_T b_gpu_xt;
  emxArray_real_T b_gpu_y;
  emxArray_real_T bb_gpu_y;
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
  emxArray_real_T f_gpu_a;
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
  emxArray_real_T gpu_c;
  emxArray_real_T gpu_dv11;
  emxArray_real_T gpu_dv12;
  emxArray_real_T gpu_dv14;
  emxArray_real_T gpu_dv15;
  emxArray_real_T gpu_dv17;
  emxArray_real_T gpu_dv19;
  emxArray_real_T gpu_dv20;
  emxArray_real_T gpu_dv21;
  emxArray_real_T gpu_dv23;
  emxArray_real_T gpu_dv24;
  emxArray_real_T gpu_dv26;
  emxArray_real_T gpu_dv27;
  emxArray_real_T gpu_dv29;
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
  emxArray_real_T gpu_xt;
  emxArray_real_T gpu_y;
  emxArray_real_T h_gpu_fx;
  emxArray_real_T h_gpu_x;
  emxArray_real_T h_gpu_xt;
  emxArray_real_T h_gpu_y;
  emxArray_real_T i_gpu_fx;
  emxArray_real_T i_gpu_x;
  emxArray_real_T i_gpu_xt;
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
  emxArray_real_T t_gpu_y;
  emxArray_real_T v_gpu_x;
  emxArray_real_T w_gpu_x;
  emxArray_real_T w_gpu_y;
  emxArray_real_T x_gpu_y;
  emxArray_real_T *ab_y;
  emxArray_real_T *absomega;
  emxArray_real_T *b_a;
  emxArray_real_T *b_c;
  emxArray_real_T *b_fx;
  emxArray_real_T *b_xt;
  emxArray_real_T *c_a;
  emxArray_real_T *c_fx;
  emxArray_real_T *c_x;
  emxArray_real_T *c_xt;
  emxArray_real_T *d_a;
  emxArray_real_T *d_fx;
  emxArray_real_T *d_r;
  emxArray_real_T *d_x;
  emxArray_real_T *d_xt;
  emxArray_real_T *dv11;
  emxArray_real_T *dv12;
  emxArray_real_T *dv14;
  emxArray_real_T *dv15;
  emxArray_real_T *dv17;
  emxArray_real_T *dv19;
  emxArray_real_T *dv20;
  emxArray_real_T *dv21;
  emxArray_real_T *dv23;
  emxArray_real_T *dv24;
  emxArray_real_T *dv26;
  emxArray_real_T *dv27;
  emxArray_real_T *dv29;
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
  emxArray_real_T *f_y;
  emxArray_real_T *fb_Scales;
  emxArray_real_T *fb_y;
  emxArray_real_T *fx;
  emxArray_real_T *g_a;
  emxArray_real_T *g_fx;
  emxArray_real_T *g_x;
  emxArray_real_T *g_xt;
  emxArray_real_T *g_y;
  emxArray_real_T *gb_y;
  emxArray_real_T *h_fx;
  emxArray_real_T *h_x;
  emxArray_real_T *h_xt;
  emxArray_real_T *hb_y;
  emxArray_real_T *i_fx;
  emxArray_real_T *i_x;
  emxArray_real_T *i_xt;
  emxArray_real_T *i_y;
  emxArray_real_T *j_x;
  emxArray_real_T *j_y;
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
  emxArray_real_T *t_y;
  emxArray_real_T *u_y;
  emxArray_real_T *v_x;
  emxArray_real_T *v_y;
  emxArray_real_T *w_x;
  emxArray_real_T *w_y;
  emxArray_real_T *x_y;
  emxArray_real_T *xt;
  emxArray_real_T *y_y;
  emxArray_uint32_T gpu_ii;
  emxArray_uint32_T v_gpu_y;
  emxArray_uint32_T *cb_y;
  emxArray_uint32_T *ii;
  const mxArray *b_tmpStr;
  const mxArray *b_y;
  const mxArray *c_tmpStr;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *h_y;
  const mxArray *m2;
  const mxArray *y;
  creal32_T *b_gpu_cfsposdft;
  real_T subs[1298];
  real_T (*gpu_subs)[1298];
  real_T interval[650];
  real_T (*gpu_interval)[650];
  real_T errsub[649];
  real_T qsub[649];
  real_T NyquistRange[2];
  real_T freqrange[2];
  real_T (*gpu_NyquistRange)[2];
  real_T (*gpu_fLims)[2];
  real_T (*gpu_freqrange)[2];
  real_T a;
  real_T b_r;
  real_T c_r;
  real_T delta;
  real_T err_ok;
  real_T fc;
  real_T intDsq;
  real_T intFsq;
  real_T m;
  real_T omegac;
  real_T q_ok;
  real_T r;
  real_T s;
  real_T tol;
  real_T toler;
  int32_T acoef;
  int32_T b_eint;
  int32_T bcoef;
  int32_T c_eint;
  int32_T eint;
  int32_T exitg1;
  int32_T fb_CutOff;
  int32_T fb_SignalPad;
  int32_T i45;
  int32_T ix;
  int32_T k;
  int32_T lidx;
  int32_T n;
  int32_T nrefine;
  int32_T nsubs;
  int32_T pathlen;
  real32_T t;
  real32_T varsig;
  real32_T xbar;
  real32_T *gpu_t;
  real32_T *gpu_xbar;
  uint32_T xSize[2];
  uint32_T (*gpu_xSize)[2];
  uint32_T N;
  int16_T dv4_idx_1;
  char_T wav[5];
  char_T wavname[5];
  char_T (*gpu_wav)[5];
  char_T (*gpu_wavname)[5];
  int8_T n_idx_0;
  boolean_T b[2];
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
  boolean_T dv19_dirtyOnGpu;
  boolean_T dv20_dirtyOnGpu;
  boolean_T dv21_dirtyOnGpu;
  boolean_T dv23_dirtyOnGpu;
  boolean_T dv24_dirtyOnGpu;
  boolean_T dv26_dirtyOnGpu;
  boolean_T dv27_dirtyOnGpu;
  boolean_T dv29_dirtyOnGpu;
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
  boolean_T i_fx_dirtyOnCpu;
  boolean_T i_fx_dirtyOnGpu;
  boolean_T i_x_dirtyOnCpu;
  boolean_T i_x_dirtyOnGpu;
  boolean_T i_xt_dirtyOnGpu;
  boolean_T i_y_dirtyOnGpu;
  boolean_T ii_dirtyOnGpu;
  boolean_T interval_dirtyOnCpu;
  boolean_T j_x_dirtyOnCpu;
  boolean_T j_x_dirtyOnGpu;
  boolean_T j_y_dirtyOnGpu;
  boolean_T k_x_dirtyOnCpu;
  boolean_T k_x_dirtyOnGpu;
  boolean_T l_x_dirtyOnCpu;
  boolean_T l_x_dirtyOnGpu;
  boolean_T m_x_dirtyOnCpu;
  boolean_T m_x_dirtyOnGpu;
  boolean_T omega_dirtyOnGpu;
  boolean_T powscales_dirtyOnGpu;
  boolean_T psidft_dirtyOnCpu;
  boolean_T savgpTMP_dirtyOnCpu;
  boolean_T savgpTMP_dirtyOnGpu;
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
  boolean_T xx_dirtyOnCpu;
  boolean_T xx_dirtyOnGpu;
  boolean_T y_dirtyOnCpu;
  boolean_T y_dirtyOnGpu;
  boolean_T z_dirtyOnCpu;
  boolean_T z_dirtyOnGpu;
  if (!gpuConstsCopied_ecc_cwtAvg) {
    gpuConstsCopied_ecc_cwtAvg = true;
    cudaMemcpy(*cv_gpu_clone, cv, sizeof(char_T [128]), cudaMemcpyHostToDevice);
  }

  gpuEmxReset_real32_T(&gpu_xx);
  gpuEmxReset_real32_T(&c_gpu_c);
  gpuEmxReset_real32_T(&gpu_savgpTMP);
  gpuEmxReset_real32_T(&gpu_abswt2S);
  gpuEmxReset_real_T(&bb_gpu_y);
  gpuEmxReset_real32_T(&gpu_abswt2);
  gpuEmxReset_real_T(&ab_gpu_y);
  mwCudaMalloc(&gpu_t, 4UL);
  gpuEmxReset_real32_T(&y_gpu_y);
  mwCudaMalloc(&gpu_xbar, 4UL);
  gpuEmxReset_real_T(&x_gpu_y);
  gpuEmxReset_real32_T(&b_gpu_c);
  gpuEmxReset_real_T(&gpu_c);
  gpuEmxReset_real_T(&w_gpu_y);
  gpuEmxReset_real_T(&i_gpu_fx);
  gpuEmxReset_real32_T(&gpu_z);
  gpuEmxReset_uint32_T(&v_gpu_y);
  gpuEmxReset_real_T(&f_gpu_a);
  gpuEmxReset_real_T(&w_gpu_x);
  gpuEmxReset_real_T(&i_gpu_xt);
  gpuEmxReset_real_T(&v_gpu_x);
  gpuEmxReset_real32_T(&e_gpu_a);
  gpuEmxReset_real32_T(&gpu_abscfssq);
  gpuEmxReset_real32_T(&u_gpu_y);
  mwCudaMalloc(&gpu_wavname, 5UL);
  gpuEmxReset_creal32_T(&gpu_cfs);
  gpuEmxReset_creal32_T(&gpu_cfspos);
  mwCudaMalloc(&b_gpu_cfsposdft, 8UL);
  mwCudaMalloc(&gpu_xSize, 8UL);
  gpuEmxReset_creal32_T(&gpu_cfsposdft);
  gpuEmxReset_real32_T(&u_gpu_x);
  gpuEmxReset_creal32_T(&gpu_xposdft);
  gpuEmxReset_real32_T(&gpu_xv);
  gpuEmxReset_real32_T(&gpu_psihat);
  gpuEmxReset_real32_T(&gpu_Scales);
  gpuEmxReset_int32_T(&gpu_iv9);
  gpuEmxReset_real32_T(&t_gpu_x);
  gpuEmxReset_real_T(&gpu_dv24);
  gpuEmxReset_real_T(&gpu_dv21);
  gpuEmxReset_real_T(&gpu_dv29);
  gpuEmxReset_real_T(&gpu_dv27);
  gpuEmxReset_real_T(&t_gpu_y);
  gpuEmxReset_real_T(&s_gpu_y);
  gpuEmxReset_real_T(&r_gpu_y);
  gpuEmxReset_real_T(&h_gpu_fx);
  gpuEmxReset_real_T(&q_gpu_y);
  gpuEmxReset_real_T(&gpu_dv20);
  gpuEmxReset_real_T(&gpu_dv19);
  gpuEmxReset_real_T(&g_gpu_fx);
  gpuEmxReset_real_T(&d_gpu_a);
  gpuEmxReset_uint32_T(&gpu_ii);
  gpuEmxReset_real_T(&c_gpu_a);
  gpuEmxReset_real_T(&gpu_dv26);
  gpuEmxReset_real_T(&s_gpu_x);
  gpuEmxReset_real_T(&gpu_dv23);
  gpuEmxReset_real_T(&p_gpu_y);
  gpuEmxReset_real_T(&o_gpu_y);
  gpuEmxReset_real_T(&f_gpu_fx);
  gpuEmxReset_real_T(&e_gpu_fx);
  gpuEmxReset_real_T(&r_gpu_x);
  gpuEmxReset_real_T(&h_gpu_xt);
  gpuEmxReset_real_T(&q_gpu_x);
  gpuEmxReset_real_T(&gpu_freqs);
  gpuEmxReset_real_T(&p_gpu_x);
  gpuEmxReset_real_T(&g_gpu_xt);
  gpuEmxReset_real_T(&o_gpu_x);
  gpuEmxReset_real_T(&n_gpu_y);
  gpuEmxReset_real_T(&m_gpu_y);
  gpuEmxReset_real_T(&gpu_powscales);
  gpuEmxReset_real_T(&gpu_absomega);
  gpuEmxReset_real_T(&n_gpu_x);
  gpuEmxReset_real_T(&f_gpu_xt);
  gpuEmxReset_real_T(&m_gpu_x);
  gpuEmxReset_real_T(&l_gpu_x);
  gpuEmxReset_real_T(&e_gpu_xt);
  gpuEmxReset_real_T(&k_gpu_x);
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
  gpuEmxReset_real_T(&j_gpu_x);
  gpuEmxReset_real_T(&d_gpu_xt);
  gpuEmxReset_real_T(&i_gpu_x);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_real_T(&gpu_fx);
  gpuEmxReset_real_T(&h_gpu_x);
  gpuEmxReset_real_T(&c_gpu_xt);
  gpuEmxReset_real_T(&g_gpu_x);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&f_gpu_x);
  gpuEmxReset_real_T(&b_gpu_xt);
  gpuEmxReset_real_T(&e_gpu_x);
  gpuEmxReset_real_T(&d_gpu_x);
  gpuEmxReset_real_T(&gpu_xt);
  gpuEmxReset_real_T(&c_gpu_x);
  mwCudaMalloc(&gpu_subs, 10384UL);
  gpuEmxReset_real_T(&gpu_r);
  gpuEmxReset_real_T(&gpu_omega);
  mwCudaMalloc(&gpu_interval, 5200UL);
  mwCudaMalloc(&gpu_wav, 5UL);
  mwCudaMalloc(&gpu_NyquistRange, 16UL);
  mwCudaMalloc(&gpu_freqrange, 16UL);
  mwCudaMalloc(&gpu_b, 2UL);
  mwCudaMalloc(&gpu_fLims, 16UL);
  gpuEmxReset_real32_T(&b_gpu_x);
  gpuEmxReset_real32_T(&gpu_x);
  savgpTMP_dirtyOnGpu = false;
  j_y_dirtyOnGpu = false;
  i_fx_dirtyOnGpu = false;
  z_dirtyOnGpu = false;
  i_y_dirtyOnGpu = false;
  m_x_dirtyOnGpu = false;
  i_xt_dirtyOnGpu = false;
  abscfssq_dirtyOnGpu = false;
  wavname_dirtyOnGpu = false;
  l_x_dirtyOnGpu = false;
  xv_dirtyOnGpu = false;
  Scales_dirtyOnGpu = false;
  k_x_dirtyOnGpu = false;
  dv24_dirtyOnGpu = false;
  dv21_dirtyOnGpu = false;
  dv29_dirtyOnGpu = false;
  dv27_dirtyOnGpu = false;
  h_fx_dirtyOnGpu = false;
  dv20_dirtyOnGpu = false;
  dv19_dirtyOnGpu = false;
  g_fx_dirtyOnGpu = false;
  d_a_dirtyOnGpu = false;
  ii_dirtyOnGpu = false;
  c_a_dirtyOnGpu = false;
  dv26_dirtyOnGpu = false;
  j_x_dirtyOnGpu = false;
  dv23_dirtyOnGpu = false;
  h_y_dirtyOnGpu = false;
  g_y_dirtyOnGpu = false;
  f_fx_dirtyOnGpu = false;
  e_fx_dirtyOnGpu = false;
  i_x_dirtyOnGpu = false;
  h_xt_dirtyOnGpu = false;
  h_x_dirtyOnGpu = false;
  g_xt_dirtyOnGpu = false;
  f_y_dirtyOnGpu = false;
  e_y_dirtyOnGpu = false;
  powscales_dirtyOnGpu = false;
  absomega_dirtyOnGpu = false;
  g_x_dirtyOnGpu = false;
  f_xt_dirtyOnGpu = false;
  f_x_dirtyOnGpu = false;
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
  e_x_dirtyOnGpu = false;
  d_xt_dirtyOnGpu = false;
  c_y_dirtyOnGpu = false;
  b_y_dirtyOnGpu = false;
  fx_dirtyOnGpu = false;
  d_x_dirtyOnGpu = false;
  c_xt_dirtyOnGpu = false;
  y_dirtyOnGpu = false;
  c_x_dirtyOnGpu = false;
  b_xt_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  xt_dirtyOnGpu = false;
  subs_dirtyOnGpu = false;
  omega_dirtyOnGpu = false;
  x_dirtyOnGpu = false;
  savgpTMP_dirtyOnCpu = false;
  i_fx_dirtyOnCpu = false;
  z_dirtyOnCpu = false;
  m_x_dirtyOnCpu = false;
  xSize_dirtyOnCpu = false;
  l_x_dirtyOnCpu = false;
  xposdft_dirtyOnCpu = false;
  xv_dirtyOnCpu = false;
  k_x_dirtyOnCpu = false;
  h_fx_dirtyOnCpu = false;
  g_fx_dirtyOnCpu = false;
  d_a_dirtyOnCpu = false;
  c_a_dirtyOnCpu = false;
  j_x_dirtyOnCpu = false;
  f_fx_dirtyOnCpu = false;
  e_fx_dirtyOnCpu = false;
  i_x_dirtyOnCpu = false;
  h_x_dirtyOnCpu = false;
  g_x_dirtyOnCpu = false;
  f_x_dirtyOnCpu = false;
  somega_dirtyOnCpu = false;
  psidft_dirtyOnCpu = false;
  d_fx_dirtyOnCpu = false;
  b_a_dirtyOnCpu = false;
  b_y_dirtyOnCpu = false;
  c_fx_dirtyOnCpu = false;
  a_dirtyOnCpu = false;
  b_fx_dirtyOnCpu = false;
  e_x_dirtyOnCpu = false;
  y_dirtyOnCpu = false;
  fx_dirtyOnCpu = false;
  d_x_dirtyOnCpu = false;
  c_x_dirtyOnCpu = false;
  b_x_dirtyOnCpu = false;
  subs_dirtyOnCpu = false;
  interval_dirtyOnCpu = false;
  x_dirtyOnCpu = false;
  xx_dirtyOnGpu = false;
  xx_dirtyOnCpu = true;
  freqs_dirtyOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  //  CWT scale spectrum - CUDA binary wrapper (double-precision, FP64)
  //  CWT uses morse wavelets, as they account for unequal variance-covariance across freqs.
  //  L1-norm is applied to mitigate 1/f decay of neuronal field potentials.
  //  Log-transform & robust z-scoring converts absolute valued CWT outputs into normal distribution.
  //
  //  Kevin Tan, 2022 (kevmtan.github.io)
  //  Input validation
  // 'ecc_cwtAvg:11' x (:,:){mustBeFloat}
  emxInit_real32_T(&b_x, 2, &vb_emlrtRTEI, true);
  if ((x->size[0] == 1) && (x->size[1] == 1)) {
    k = b_x->size[0] * b_x->size[1];
    b_x->size[0] = 1;
    b_x->size[1] = 1;
    emxEnsureCapacity_real32_T(b_x, k, &emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(b_x, &b_gpu_x);
    b_x->data[0] = x->data[0];
    x_dirtyOnCpu = true;
  } else if ((x->size[0] == 0) || (x->size[1] == 0)) {
    k = b_x->size[0] * b_x->size[1];
    b_x->size[0] = x->size[0];
    b_x->size[1] = x->size[1];
    emxEnsureCapacity_real32_T(b_x, k, &emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(b_x, &b_gpu_x);
    k = x->size[0] * x->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, x);
      ecc_cwtAvg_kernel2<<<grid, block>>>(gpu_x, k, b_gpu_x);
      x_dirtyOnGpu = true;
    }
  } else {
    k = b_x->size[0] * b_x->size[1];
    b_x->size[0] = x->size[0];
    b_x->size[1] = x->size[1];
    emxEnsureCapacity_real32_T(b_x, k, &emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(b_x, &b_gpu_x);
    k = x->size[0] * x->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, x);
      ecc_cwtAvg_kernel1<<<grid, block>>>(gpu_x, k, b_gpu_x);
      x_dirtyOnGpu = true;
    }
  }

  //  Input data
  // 'ecc_cwtAvg:12' fs (1,1){mustBeFloat} = 1000
  //  Sampling rate
  // 'ecc_cwtAvg:13' fLims (1,2){mustBeFloat} = [1 300]
  //  Frequency limits
  // 'ecc_cwtAvg:14' fOctave (1,1){mustBeFloat} = 10
  //  Voices per octave
  // 'ecc_cwtAvg:16' if fs<10
  if (fs < 10.0) {
    // 'ecc_cwtAvg:16' ;
    // 'ecc_cwtAvg:16' fs=10;
    fs = 10.0;
  }

  // 'ecc_cwtAvg:17' if fLims(1)<1e-3
  if (fLims[0] < 0.001) {
    // 'ecc_cwtAvg:17' ;
    // 'ecc_cwtAvg:17' fLims(1)=1e-3;
    fLims[0] = 0.001;
  }

  // 'ecc_cwtAvg:18' if fLims(2)>fs/2
  if (fLims[1] > fs / 2.0) {
    // 'ecc_cwtAvg:18' ;
    // 'ecc_cwtAvg:18' fLims(2)=fs/2;
    fLims[1] = fs / 2.0;
  }

  // 'ecc_cwtAvg:19' if fLims(1)>fLims(2)*.8
  if (fLims[0] > fLims[1] * 0.8) {
    // 'ecc_cwtAvg:19' ;
    // 'ecc_cwtAvg:19' fLims(1)=fLims(2)*.8;
    fLims[0] = fLims[1] * 0.8;
  }

  // 'ecc_cwtAvg:20' if fOctave<1
  if (fOctave < 1.0) {
    // 'ecc_cwtAvg:20' ;
    // 'ecc_cwtAvg:20' fOctave=1;
    fOctave = 1.0;
  } else if (fOctave > 48.0) {
    // 'ecc_cwtAvg:20' elseif fOctave>48
    // 'ecc_cwtAvg:20' ;
    // 'ecc_cwtAvg:20' fOctave=48;
    fOctave = 48.0;
  }

  //  Initialize
  // 'ecc_cwtAvg:23' nFrames = height(x);
  // 'ecc_cwtAvg:24' nChs = width(x);
  // 'ecc_cwtAvg:25' fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,SamplingFrequency=fs,...
  // 'ecc_cwtAvg:26'     VoicesPerOctave=fOctave,FrequencyLimits=fLims);
  fb_CutOff = 50;
  first_iteration = false;
  nrefine = 0;
  do {
    exitg1 = 0;
    if (nrefine + 1 < 11) {
      if (cv[static_cast<int32_T>(Bndry[nrefine])] != cv[static_cast<int32_T>
          (cv1[nrefine])]) {
        exitg1 = 1;
      } else {
        nrefine++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (first_iteration) {
    if (b_x->size[0] <= 100000) {
      fb_SignalPad = static_cast<int32_T>(std::floor(static_cast<real_T>
        (b_x->size[0]) / 2.0));
    } else {
      r = std::frexp(static_cast<real_T>(b_x->size[0]), &lidx);
      if (r == 0.5) {
        toler = static_cast<real_T>(lidx) - 1.0;
      } else {
        toler = std::log(r) / 0.69314718055994529 + static_cast<real_T>(lidx);
      }

      toler = std::ceil(toler);
      fb_SignalPad = static_cast<int32_T>(toler);
    }
  } else {
    fb_SignalPad = 0;
  }

  cudaMemcpy(*gpu_fLims, fLims, 16UL, cudaMemcpyHostToDevice);
  ecc_cwtAvg_kernel3<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_fLims, *gpu_b);
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

    ecc_cwtAvg_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_fLims,
      *gpu_freqrange);
    ecc_cwtAvg_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs,
      *gpu_NyquistRange);
    b_dirtyOnGpu = true;
    emxInit_char_T(&tmpStr, 2, &yb_emlrtRTEI, true);
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
      y = nullptr;
      m2 = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m2, &u[0]);
      emlrtAssign(&y, m2);
      b_y = nullptr;
      m2 = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 2, m2, &formatSpec[0]);
      emlrtAssign(&b_y, m2);
      c_y = nullptr;
      if (b_dirtyOnGpu) {
        cudaMemcpy(NyquistRange, *gpu_NyquistRange, 16UL, cudaMemcpyDeviceToHost);
      }

      m2 = emlrtCreateDoubleScalar(NyquistRange[1]);
      emlrtAssign(&c_y, m2);
      emlrtAssign(&b_tmpStr, feval(y, b_y, c_y, &emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(b_tmpStr), &b_emlrtMCI),
                       "<output of length>");
      emlrt_marshallIn(emlrtAlias(b_tmpStr), "tmpStr", tmpStr);
      emlrtDestroyArray(&b_tmpStr);
    }

    emxFree_char_T(&tmpStr);
    ecc_cwtAvg_kernel6<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*cv_gpu_clone,
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
      r = 0.0057083835261;
      c_r = 0.0057083835261;
      for (acoef = 0; acoef < 6; acoef++) {
        fc = c[acoef];
        b_r = b_r * 0.005353955978584176 + fc;
        r = r * 0.005353955978584176 + fc;
        c_r = c_r * 0.005353955978584176 + fc;
      }

      b_r /= 13.666666666666666;
      r /= 13.666666666666666;
      c_r /= 13.666666666666666;
      c_r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((c_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(c_r) || std::isnan(c_r)) {
        ecc_cwtAvg_kernel7<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecc_cwtAvg_kernel8<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        intDsq = 0.0;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        pathlen = static_cast<int32_T>(interval[1]) - static_cast<int32_T>
          (interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            delta = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0)
              + 1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * delta;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (acoef = 0; acoef < nrefine; acoef++) {
          if (std::abs(interval[acoef + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[acoef + 1];
            interval_dirtyOnCpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecc_cwtAvg_kernel9<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
          intDsq = rtNaN;
        } else {
          nsubs--;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            ecc_cwtAvg_kernel10<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&e_x, 2, &f_emlrtRTEI, true);
          emxInit_real_T(&f_x, 2, &ac_emlrtRTEI, true);
          emxInit_real_T(&b_xt, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&j_y, 2, &hc_emlrtRTEI, true);
          emxInit_real_T(&b_fx, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&k_y, 2, &ic_emlrtRTEI, true);
          emxInit_real_T(&c_a, 2, &l_emlrtRTEI, true);
          emxInit_real_T(&dv8, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&l_y, 2, &jc_emlrtRTEI, true);
          emxInit_real_T(&dv12, 2, &yb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            k = e_x->size[0] * e_x->size[1];
            e_x->size[0] = 1;
            e_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(e_x, k, &f_emlrtRTEI);
            if (!c_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(e_x, &e_gpu_x);
            }

            ix = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fc = subs[k << 1];
              subs_dirtyOnGpu = false;
              c_r = subs[(k << 1) + 1];
              r = (fc + c_r) / 2.0;
              delta = (c_r - fc) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                e_x->data[(ix + nrefine) + 1] = NODES[nrefine] * delta + r;
                c_x_dirtyOnCpu = true;
              }

              ix += 15;
            }

            k = f_x->size[0] * f_x->size[1];
            f_x->size[0] = 1;
            f_x->size[1] = e_x->size[1];
            emxEnsureCapacity_real_T(f_x, k, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(f_x, &f_gpu_x);
            k = b_xt->size[0] * b_xt->size[1];
            b_xt->size[0] = 1;
            b_xt->size[1] = e_x->size[1];
            emxEnsureCapacity_real_T(b_xt, k, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_xt, &b_gpu_xt);
            lidx = e_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_x, e_x);
              }

              c_x_dirtyOnCpu = false;
              ecc_cwtAvg_kernel11<<<grid, block>>>(e_gpu_x, lidx, b_gpu_xt,
                f_gpu_x);
              c_x_dirtyOnGpu = true;
              b_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (c_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(f_x, &f_gpu_x);
              }

              c_x_dirtyOnGpu = false;
              r = std::abs(f_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= f_x->size[1] - 2)) {
                toler = r;
                r = std::abs(f_x->data[k + 1]);
                if (std::abs(f_x->data[k + 1] - f_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(toler, r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(e_x->size[1]);
                k = b_fx->size[0] * b_fx->size[1];
                b_fx->size[0] = 1;
                b_fx->size[1] = e_x->size[1];
                emxEnsureCapacity_real_T(b_fx, k, &k_emlrtRTEI);
                if (!b_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(b_fx, &b_gpu_fx);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_fx, b_fx);
                  }

                  ecc_cwtAvg_kernel20<<<grid, block>>>(dv4_idx_1, b_gpu_fx);
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
              k = j_y->size[0] * j_y->size[1];
              j_y->size[0] = 1;
              j_y->size[1] = f_x->size[1];
              emxEnsureCapacity_real_T(j_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(j_y, &c_gpu_y);
              nrefine = f_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel12<<<grid, block>>>(f_gpu_x, nrefine, c_gpu_y);
                b_y_dirtyOnGpu = true;
              }

              k = k_y->size[0] * k_y->size[1];
              k_y->size[0] = 1;
              k_y->size[1] = f_x->size[1];
              emxEnsureCapacity_real_T(k_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(k_y, &f_gpu_y);
              nrefine = f_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel13<<<grid, block>>>(f_gpu_x, nrefine, f_gpu_y);
                d_y_dirtyOnGpu = true;
              }

              if (j_y->size[1] == k_y->size[1]) {
                k = c_a->size[0] * c_a->size[1];
                c_a->size[0] = 1;
                c_a->size[1] = j_y->size[1];
                emxEnsureCapacity_real_T(c_a, k, &l_emlrtRTEI);
                if (!b_a_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(c_a, &b_gpu_a);
                }

                bcoef = j_y->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (bcoef + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_a_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_a, c_a);
                  }

                  ecc_cwtAvg_kernel14<<<grid, block>>>(f_gpu_y, c_gpu_y, bcoef,
                    b_gpu_a);
                  b_a_dirtyOnCpu = false;
                  b_a_dirtyOnGpu = true;
                }
              } else {
                if (b_a_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_a, &b_gpu_a);
                }

                if (b_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(j_y, &c_gpu_y);
                }

                b_y_dirtyOnGpu = false;
                if (d_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(k_y, &f_gpu_y);
                }

                d_y_dirtyOnGpu = false;
                c_binary_expand_op(c_a, j_y, k_y);
                b_a_dirtyOnGpu = false;
                b_a_dirtyOnCpu = true;
              }

              k = dv8->size[0] * dv8->size[1];
              dv8->size[0] = 1;
              dv8->size[1] = static_cast<int16_T>(c_a->size[1]);
              emxEnsureCapacity_real_T(dv8, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv8, &gpu_dv8);
              nrefine = static_cast<int16_T>(c_a->size[1]) - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_a, c_a);
                }

                b_a_dirtyOnCpu = false;
                ecc_cwtAvg_kernel15<<<grid, block>>>(b_gpu_a, nrefine, gpu_dv8);
                dv8_dirtyOnGpu = true;
              }

              k = l_y->size[0] * l_y->size[1];
              l_y->size[0] = 1;
              l_y->size[1] = f_x->size[1];
              emxEnsureCapacity_real_T(l_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(l_y, &l_gpu_y);
              nrefine = f_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel16<<<grid, block>>>(f_gpu_x, nrefine, l_gpu_y);
              }

              k = dv12->size[0] * dv12->size[1];
              dv12->size[0] = 1;
              dv12->size[1] = l_y->size[1];
              emxEnsureCapacity_real_T(dv12, k, &n_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv12, &gpu_dv12);
              bcoef = l_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (bcoef + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel17<<<grid, block>>>(l_gpu_y, bcoef, gpu_dv12);
                dv12_dirtyOnGpu = true;
              }

              nrefine = dv12->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel18<<<grid, block>>>(nrefine, gpu_dv12);
                dv12_dirtyOnGpu = true;
              }

              if (dv8->size[1] == dv12->size[1]) {
                k = b_fx->size[0] * b_fx->size[1];
                b_fx->size[0] = 1;
                b_fx->size[1] = dv8->size[1];
                emxEnsureCapacity_real_T(b_fx, k, &r_emlrtRTEI);
                if (!b_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(b_fx, &b_gpu_fx);
                }

                bcoef = dv8->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (bcoef + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_fx, b_fx);
                  }

                  ecc_cwtAvg_kernel19<<<grid, block>>>(b_gpu_xt, gpu_dv12,
                    gpu_dv8, bcoef, b_gpu_fx);
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
                b_binary_expand_op(b_fx, dv8, dv12, b_xt);
                b_fx_dirtyOnGpu = false;
                b_fx_dirtyOnCpu = true;
              }

              r = 0.0;
              ix = -1;
              for (k = 0; k <= nsubs; k++) {
                fc = 0.0;
                c_r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (b_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(b_fx, &b_gpu_fx);
                  }

                  fc += dv6[nrefine] * b_fx->data[(ix + nrefine) + 1];
                  b_fx_dirtyOnGpu = false;
                  c_r += dv7[nrefine] * b_fx->data[(ix + nrefine) + 1];
                }

                ix += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                delta = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fc *= delta;
                qsub[k] = fc;
                r += fc;
                errsub[k] = c_r * delta;
              }

              intDsq = r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              r = 2.0 * tol;
              c_r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fc = errsub[k];
                delta = std::abs(fc);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (delta <= r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[k];
                } else {
                  c_r += delta;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              r = std::abs(err_ok) + c_r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(r)) && (!std::isnan(r))) && (nrefine != 0) && (!(r <=
                    tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    acoef = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((acoef << 1) - 1) << 1) + 1] = subs[((acoef - 1) << 1)
                      + 1];
                    subs[((acoef << 1) - 1) << 1] = (subs[(acoef - 1) << 1] +
                      subs[((acoef - 1) << 1) + 1]) / 2.0;
                    subs[(((acoef << 1) - 2) << 1) + 1] = subs[((acoef << 1) - 1)
                      << 1];
                    subs[((acoef << 1) - 2) << 1] = subs[(acoef - 1) << 1];
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
          emxFree_real_T(&l_y);
          emxFree_real_T(&dv8);
          emxFree_real_T(&c_a);
          emxFree_real_T(&k_y);
          emxFree_real_T(&b_fx);
          emxFree_real_T(&j_y);
          emxFree_real_T(&b_xt);
          emxFree_real_T(&f_x);
          emxFree_real_T(&e_x);
        }

        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecc_cwtAvg_kernel21<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecc_cwtAvg_kernel22<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        intFsq = 0.0;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        pathlen = static_cast<int32_T>(interval[1]) - static_cast<int32_T>
          (interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            delta = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0)
              + 1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * delta;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (acoef = 0; acoef < nrefine; acoef++) {
          if (std::abs(interval[acoef + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[acoef + 1];
            interval_dirtyOnCpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecc_cwtAvg_kernel23<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine, *
            gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
          intFsq = rtNaN;
        } else {
          nsubs--;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ecc_cwtAvg_kernel24<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnCpu = false;
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&i_x, 2, &f_emlrtRTEI, true);
          emxInit_real_T(&j_x, 2, &ac_emlrtRTEI, true);
          emxInit_real_T(&d_xt, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&dv15, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&d_fx, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&o_y, 2, &kc_emlrtRTEI, true);
          emxInit_real_T(&dv17, 2, &yb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            k = i_x->size[0] * i_x->size[1];
            i_x->size[0] = 1;
            i_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(i_x, k, &f_emlrtRTEI);
            if (!e_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(i_x, &i_gpu_x);
            }

            ix = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fc = subs[k << 1];
              subs_dirtyOnGpu = false;
              c_r = subs[(k << 1) + 1];
              r = (fc + c_r) / 2.0;
              delta = (c_r - fc) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                i_x->data[(ix + nrefine) + 1] = NODES[nrefine] * delta + r;
                e_x_dirtyOnCpu = true;
              }

              ix += 15;
            }

            k = j_x->size[0] * j_x->size[1];
            j_x->size[0] = 1;
            j_x->size[1] = i_x->size[1];
            emxEnsureCapacity_real_T(j_x, k, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(j_x, &j_gpu_x);
            k = d_xt->size[0] * d_xt->size[1];
            d_xt->size[0] = 1;
            d_xt->size[1] = i_x->size[1];
            emxEnsureCapacity_real_T(d_xt, k, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_xt, &d_gpu_xt);
            lidx = i_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (e_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_x, i_x);
              }

              e_x_dirtyOnCpu = false;
              ecc_cwtAvg_kernel25<<<grid, block>>>(i_gpu_x, lidx, d_gpu_xt,
                j_gpu_x);
              e_x_dirtyOnGpu = true;
              d_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (e_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(j_x, &j_gpu_x);
              }

              e_x_dirtyOnGpu = false;
              r = std::abs(j_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= j_x->size[1] - 2)) {
                toler = r;
                r = std::abs(j_x->data[k + 1]);
                if (std::abs(j_x->data[k + 1] - j_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(toler, r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(i_x->size[1]);
                k = d_fx->size[0] * d_fx->size[1];
                d_fx->size[0] = 1;
                d_fx->size[1] = i_x->size[1];
                emxEnsureCapacity_real_T(d_fx, k, &k_emlrtRTEI);
                if (!d_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_fx, &d_gpu_fx);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (d_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_fx, d_fx);
                  }

                  ecc_cwtAvg_kernel31<<<grid, block>>>(dv4_idx_1, d_gpu_fx);
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
              k = dv15->size[0] * dv15->size[1];
              dv15->size[0] = 1;
              dv15->size[1] = j_x->size[1];
              emxEnsureCapacity_real_T(dv15, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv15, &gpu_dv15);
              nrefine = j_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel26<<<grid, block>>>(j_gpu_x, nrefine, gpu_dv15);
                dv15_dirtyOnGpu = true;
              }

              k = o_y->size[0] * o_y->size[1];
              o_y->size[0] = 1;
              o_y->size[1] = j_x->size[1];
              emxEnsureCapacity_real_T(o_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(o_y, &k_gpu_y);
              nrefine = j_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel27<<<grid, block>>>(j_gpu_x, nrefine, k_gpu_y);
              }

              k = dv17->size[0] * dv17->size[1];
              dv17->size[0] = 1;
              dv17->size[1] = o_y->size[1];
              emxEnsureCapacity_real_T(dv17, k, &n_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv17, &gpu_dv17);
              bcoef = o_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (bcoef + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel28<<<grid, block>>>(k_gpu_y, bcoef, gpu_dv17);
                dv17_dirtyOnGpu = true;
              }

              nrefine = dv17->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel29<<<grid, block>>>(nrefine, gpu_dv17);
                dv17_dirtyOnGpu = true;
              }

              if (dv15->size[1] == dv17->size[1]) {
                k = d_fx->size[0] * d_fx->size[1];
                d_fx->size[0] = 1;
                d_fx->size[1] = dv15->size[1];
                emxEnsureCapacity_real_T(d_fx, k, &r_emlrtRTEI);
                if (!d_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_fx, &d_gpu_fx);
                }

                k = dv15->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (k + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (d_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_fx, d_fx);
                  }

                  ecc_cwtAvg_kernel30<<<grid, block>>>(d_gpu_xt, gpu_dv17,
                    gpu_dv15, k, d_gpu_fx);
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
                b_binary_expand_op(d_fx, dv15, dv17, d_xt);
                d_fx_dirtyOnGpu = false;
                d_fx_dirtyOnCpu = true;
              }

              r = 0.0;
              ix = -1;
              for (k = 0; k <= nsubs; k++) {
                fc = 0.0;
                c_r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (d_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(d_fx, &d_gpu_fx);
                  }

                  fc += dv6[nrefine] * d_fx->data[(ix + nrefine) + 1];
                  d_fx_dirtyOnGpu = false;
                  c_r += dv7[nrefine] * d_fx->data[(ix + nrefine) + 1];
                }

                ix += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                delta = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fc *= delta;
                qsub[k] = fc;
                r += fc;
                errsub[k] = c_r * delta;
              }

              intFsq = r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              r = 2.0 * tol;
              c_r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fc = errsub[k];
                delta = std::abs(fc);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (delta <= r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[k];
                } else {
                  c_r += delta;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              r = std::abs(err_ok) + c_r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(r)) && (!std::isnan(r))) && (nrefine != 0) && (!(r <=
                    tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    acoef = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((acoef << 1) - 1) << 1) + 1] = subs[((acoef - 1) << 1)
                      + 1];
                    subs[((acoef << 1) - 1) << 1] = (subs[(acoef - 1) << 1] +
                      subs[((acoef - 1) << 1) + 1]) / 2.0;
                    subs[(((acoef << 1) - 2) << 1) + 1] = subs[((acoef << 1) - 1)
                      << 1];
                    subs[((acoef << 1) - 2) << 1] = subs[(acoef - 1) << 1];
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
          emxFree_real_T(&o_y);
          emxFree_real_T(&d_fx);
          emxFree_real_T(&dv15);
          emxFree_real_T(&d_xt);
          emxFree_real_T(&j_x);
          emxFree_real_T(&i_x);
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

    c_r = static_cast<real_T>(b_x->size[0]) / (c_r * 2.0);
    first_iteration = false;
    nrefine = 0;
    do {
      exitg1 = 0;
      if (nrefine + 1 < 6) {
        if (wav[nrefine] != cv3[nrefine]) {
          exitg1 = 1;
        } else {
          nrefine++;
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
                  delta = 1.0 - s;
                } else {
                  delta = r / fc;
                  b_r = intFsq / fc;
                  r = s * (2.0 * m * delta * (delta - b_r) - (omegac - a) * (b_r
                            - 1.0));
                  delta = (delta - 1.0) * (b_r - 1.0) * (s - 1.0);
                }

                if (r > 0.0) {
                  delta = -delta;
                } else {
                  r = -r;
                }

                if ((2.0 * r < 3.0 * m * delta - std::abs(toler * delta)) && (r <
                     std::abs(0.5 * q_ok * delta))) {
                  q_ok = err_ok;
                  err_ok = r / delta;
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
    if (c_r < r * rt_powd_snf(2.0, 1.0 / fOctave)) {
      c_r = r * rt_powd_snf(2.0, 1.0 / fOctave);
    }

    r = 1.0 / (c_r * (6.2831853071795862 / cf)) * fs;
    if (fLims[0] < r) {
      ecc_cwtAvg_kernel32<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(r,
        *gpu_freqrange, *gpu_fLims);
      cudaMemcpy(fLims, *gpu_fLims, 16UL, cudaMemcpyDeviceToHost);
    }

    if (fLims[1] > fs / 2.0) {
      ecc_cwtAvg_kernel33<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs,
        *gpu_freqrange, *gpu_fLims);
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
      d_y = nullptr;
      m2 = emlrtCreateCharArray(2, &iv4[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m2, &u[0]);
      emlrtAssign(&d_y, m2);
      e_y = nullptr;
      m2 = emlrtCreateCharArray(2, &iv5[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 5, m2, &b_formatSpec[0]);
      emlrtAssign(&e_y, m2);
      h_y = nullptr;
      m2 = emlrtCreateDoubleScalar(1.0 / fOctave);
      emlrtAssign(&h_y, m2);
      emlrtAssign(&c_tmpStr, feval(d_y, e_y, h_y, &emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(c_tmpStr), &b_emlrtMCI),
                       "<output of length>");
      emxInit_char_T(&d_tmpStr, 2, &yb_emlrtRTEI, true);
      emlrt_marshallIn(emlrtAlias(c_tmpStr), "tmpStr", d_tmpStr);
      emxFree_char_T(&d_tmpStr);
      emlrtDestroyArray(&c_tmpStr);
    }
  }

  first_iteration = false;
  nrefine = 0;
  do {
    exitg1 = 0;
    if (nrefine + 1 < 6) {
      if (cv[static_cast<int32_T>(b_b[nrefine])] != cv[static_cast<int32_T>
          (cv2[nrefine])]) {
        exitg1 = 1;
      } else {
        nrefine++;
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
    r = 0.0057083835261;
    c_r = 0.0057083835261;
    for (acoef = 0; acoef < 6; acoef++) {
      fc = c[acoef];
      b_r = b_r * 0.005353955978584176 + fc;
      r = r * 0.005353955978584176 + fc;
      c_r = c_r * 0.005353955978584176 + fc;
    }

    b_r /= 13.666666666666666;
    r /= 13.666666666666666;
    c_r /= 13.666666666666666;
    toler = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((b_r +
      0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((r +
      0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((c_r +
      0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
    if (std::isinf(toler) || std::isnan(toler)) {
      if (interval_dirtyOnCpu) {
        cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
      }

      ecc_cwtAvg_kernel34<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
      ecc_cwtAvg_kernel35<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
        (*gpu_interval);
      interval_dirtyOnCpu = false;
      nrefine = 1;
      cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
      pathlen = static_cast<int32_T>(interval[1]) - static_cast<int32_T>
        (interval[0]);
      if (pathlen > 0) {
        n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
          - interval[0])) * 10 - 1);
        nsubs = n_idx_0 + 1;
        if (n_idx_0 + 2 > 2) {
          lidx = n_idx_0;
          interval[n_idx_0 + 1] = interval[1];
          interval_dirtyOnCpu = true;
          delta = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) +
            1.0);
          for (nrefine = 0; nrefine < lidx; nrefine++) {
            interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
              (n_idx_0 - nrefine) * delta;
          }
        }

        nrefine = n_idx_0 + 1;
      } else {
        nsubs = 1;
      }

      lidx = 0;
      for (acoef = 0; acoef < nrefine; acoef++) {
        if (std::abs(interval[acoef + 1] - interval[lidx]) > 0.0) {
          lidx++;
          interval[lidx] = interval[acoef + 1];
          interval_dirtyOnCpu = true;
        } else {
          nsubs--;
        }
      }

      if (nsubs + 1 < 2) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecc_cwtAvg_kernel36<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
          *gpu_interval);
        interval_dirtyOnCpu = false;
        nsubs = 1;
      }

      if (pathlen > 0) {
        nsubs--;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          interval_dirtyOnCpu = false;
          if (subs_dirtyOnCpu) {
            cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
          }

          ecc_cwtAvg_kernel37<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
          subs_dirtyOnCpu = false;
          subs_dirtyOnGpu = true;
        }

        q_ok = 0.0;
        err_ok = 0.0;
        first_iteration = true;
        emxInit_real_T(&c_x, 2, &f_emlrtRTEI, true);
        emxInit_real_T(&d_x, 2, &ac_emlrtRTEI, true);
        emxInit_real_T(&xt, 2, &ec_emlrtRTEI, true);
        emxInit_real_T(&f_y, 2, &hc_emlrtRTEI, true);
        emxInit_real_T(&fx, 2, &yb_emlrtRTEI, true);
        emxInit_real_T(&g_y, 2, &ic_emlrtRTEI, true);
        emxInit_real_T(&b_a, 2, &l_emlrtRTEI, true);
        emxInit_real_T(&dv5, 2, &yb_emlrtRTEI, true);
        emxInit_real_T(&i_y, 2, &jc_emlrtRTEI, true);
        emxInit_real_T(&dv9, 2, &yb_emlrtRTEI, true);
        do {
          exitg1 = 0;
          k = c_x->size[0] * c_x->size[1];
          c_x->size[0] = 1;
          c_x->size[1] = 15 * (nsubs + 1);
          emxEnsureCapacity_real_T(c_x, k, &f_emlrtRTEI);
          if (!b_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(c_x, &c_gpu_x);
          }

          ix = -1;
          for (k = 0; k <= nsubs; k++) {
            if (subs_dirtyOnGpu) {
              cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
            }

            fc = subs[k << 1];
            subs_dirtyOnGpu = false;
            c_r = subs[(k << 1) + 1];
            r = (fc + c_r) / 2.0;
            delta = (c_r - fc) / 2.0;
            for (nrefine = 0; nrefine < 15; nrefine++) {
              c_x->data[(ix + nrefine) + 1] = NODES[nrefine] * delta + r;
              b_x_dirtyOnCpu = true;
            }

            ix += 15;
          }

          k = d_x->size[0] * d_x->size[1];
          d_x->size[0] = 1;
          d_x->size[1] = c_x->size[1];
          emxEnsureCapacity_real_T(d_x, k, &g_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(d_x, &d_gpu_x);
          k = xt->size[0] * xt->size[1];
          xt->size[0] = 1;
          xt->size[1] = c_x->size[1];
          emxEnsureCapacity_real_T(xt, k, &h_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(xt, &gpu_xt);
          lidx = c_x->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, c_x);
            }

            b_x_dirtyOnCpu = false;
            ecc_cwtAvg_kernel38<<<grid, block>>>(c_gpu_x, lidx, gpu_xt, d_gpu_x);
            b_x_dirtyOnGpu = true;
            xt_dirtyOnGpu = true;
          }

          b_guard1 = false;
          if (!first_iteration) {
            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(d_x, &d_gpu_x);
            }

            b_x_dirtyOnGpu = false;
            r = std::abs(d_x->data[0]);
            k = 0;
            exitg2 = false;
            while ((!exitg2) && (k <= d_x->size[1] - 2)) {
              toler = r;
              r = std::abs(d_x->data[k + 1]);
              if (std::abs(d_x->data[k + 1] - d_x->data[k]) <=
                  2.2204460492503131E-14 * std::fmax(toler, r)) {
                first_iteration = true;
                exitg2 = true;
              } else {
                k++;
              }
            }

            if (first_iteration) {
              dv4_idx_1 = static_cast<int16_T>(c_x->size[1]);
              k = fx->size[0] * fx->size[1];
              fx->size[0] = 1;
              fx->size[1] = c_x->size[1];
              emxEnsureCapacity_real_T(fx, k, &k_emlrtRTEI);
              if (!fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(fx, &gpu_fx);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_fx, fx);
                }

                ecc_cwtAvg_kernel47<<<grid, block>>>(dv4_idx_1, gpu_fx);
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
            k = f_y->size[0] * f_y->size[1];
            f_y->size[0] = 1;
            f_y->size[1] = d_x->size[1];
            emxEnsureCapacity_real_T(f_y, k, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(f_y, &gpu_y);
            nrefine = d_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel39<<<grid, block>>>(d_gpu_x, nrefine, gpu_y);
              y_dirtyOnGpu = true;
            }

            k = g_y->size[0] * g_y->size[1];
            g_y->size[0] = 1;
            g_y->size[1] = d_x->size[1];
            emxEnsureCapacity_real_T(g_y, k, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(g_y, &d_gpu_y);
            nrefine = d_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel40<<<grid, block>>>(d_gpu_x, nrefine, d_gpu_y);
              c_y_dirtyOnGpu = true;
            }

            if (f_y->size[1] == g_y->size[1]) {
              k = b_a->size[0] * b_a->size[1];
              b_a->size[0] = 1;
              b_a->size[1] = f_y->size[1];
              emxEnsureCapacity_real_T(b_a, k, &l_emlrtRTEI);
              if (!a_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(b_a, &gpu_a);
              }

              bcoef = f_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (bcoef + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, b_a);
                }

                ecc_cwtAvg_kernel41<<<grid, block>>>(d_gpu_y, gpu_y, bcoef,
                  gpu_a);
                a_dirtyOnCpu = false;
                a_dirtyOnGpu = true;
              }
            } else {
              if (a_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_a, &gpu_a);
              }

              if (y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(f_y, &gpu_y);
              }

              y_dirtyOnGpu = false;
              if (c_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(g_y, &d_gpu_y);
              }

              c_y_dirtyOnGpu = false;
              c_binary_expand_op(b_a, f_y, g_y);
              a_dirtyOnGpu = false;
              a_dirtyOnCpu = true;
            }

            k = dv5->size[0] * dv5->size[1];
            dv5->size[0] = 1;
            dv5->size[1] = static_cast<int16_T>(b_a->size[1]);
            emxEnsureCapacity_real_T(dv5, k, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv5, &gpu_dv5);
            nrefine = static_cast<int16_T>(b_a->size[1]) - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (a_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, b_a);
              }

              a_dirtyOnCpu = false;
              ecc_cwtAvg_kernel42<<<grid, block>>>(gpu_a, nrefine, gpu_dv5);
              dv5_dirtyOnGpu = true;
            }

            k = i_y->size[0] * i_y->size[1];
            i_y->size[0] = 1;
            i_y->size[1] = d_x->size[1];
            emxEnsureCapacity_real_T(i_y, k, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(i_y, &j_gpu_y);
            nrefine = d_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel43<<<grid, block>>>(d_gpu_x, nrefine, j_gpu_y);
            }

            k = dv9->size[0] * dv9->size[1];
            dv9->size[0] = 1;
            dv9->size[1] = i_y->size[1];
            emxEnsureCapacity_real_T(dv9, k, &n_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv9, &gpu_dv9);
            bcoef = i_y->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (bcoef + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel44<<<grid, block>>>(j_gpu_y, bcoef, gpu_dv9);
              dv9_dirtyOnGpu = true;
            }

            nrefine = dv9->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel45<<<grid, block>>>(nrefine, gpu_dv9);
              dv9_dirtyOnGpu = true;
            }

            if (dv5->size[1] == dv9->size[1]) {
              k = fx->size[0] * fx->size[1];
              fx->size[0] = 1;
              fx->size[1] = dv5->size[1];
              emxEnsureCapacity_real_T(fx, k, &r_emlrtRTEI);
              if (!fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(fx, &gpu_fx);
              }

              bcoef = dv5->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (bcoef + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_fx, fx);
                }

                ecc_cwtAvg_kernel46<<<grid, block>>>(gpu_xt, gpu_dv9, gpu_dv5,
                  bcoef, gpu_fx);
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
              b_binary_expand_op(fx, dv5, dv9, xt);
              fx_dirtyOnGpu = false;
              fx_dirtyOnCpu = true;
            }

            r = 0.0;
            ix = -1;
            for (k = 0; k <= nsubs; k++) {
              fc = 0.0;
              c_r = 0.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                if (fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(fx, &gpu_fx);
                }

                fc += dv6[nrefine] * fx->data[(ix + nrefine) + 1];
                fx_dirtyOnGpu = false;
                c_r += dv7[nrefine] * fx->data[(ix + nrefine) + 1];
              }

              ix += 15;
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              delta = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
              fc *= delta;
              qsub[k] = fc;
              r += fc;
              errsub[k] = c_r * delta;
            }

            intDsq = r + q_ok;
            tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
            r = 2.0 * tol;
            c_r = 0.0;
            nrefine = 0;
            for (k = 0; k <= nsubs; k++) {
              fc = errsub[k];
              delta = std::abs(fc);
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              if (delta <= r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                err_ok += fc;
                q_ok += qsub[k];
              } else {
                c_r += delta;
                nrefine++;
                subs[(nrefine - 1) << 1] = subs[k << 1];
                subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                subs_dirtyOnCpu = true;
              }
            }

            r = std::abs(err_ok) + c_r;
            if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::isinf
                  (r)) && (!std::isnan(r))) && (nrefine != 0) && (!(r <= tol)))
            {
              nsubs = (nrefine << 1) - 1;
              if (nsubs + 1 > 650) {
                exitg1 = 1;
              } else {
                for (k = 0; k < nrefine; k++) {
                  acoef = nrefine - k;
                  if (subs_dirtyOnGpu) {
                    cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                  }

                  subs[(((acoef << 1) - 1) << 1) + 1] = subs[((acoef - 1) << 1)
                    + 1];
                  subs[((acoef << 1) - 1) << 1] = (subs[(acoef - 1) << 1] +
                    subs[((acoef - 1) << 1) + 1]) / 2.0;
                  subs[(((acoef << 1) - 2) << 1) + 1] = subs[((acoef << 1) - 1) <<
                    1];
                  subs[((acoef << 1) - 2) << 1] = subs[(acoef - 1) << 1];
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
        emxFree_real_T(&i_y);
        emxFree_real_T(&dv5);
        emxFree_real_T(&b_a);
        emxFree_real_T(&g_y);
        emxFree_real_T(&fx);
        emxFree_real_T(&f_y);
        emxFree_real_T(&xt);
        emxFree_real_T(&d_x);
        emxFree_real_T(&c_x);
      }

      if (interval_dirtyOnCpu) {
        cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
      }

      ecc_cwtAvg_kernel48<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
      ecc_cwtAvg_kernel49<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
        (*gpu_interval);
      interval_dirtyOnCpu = false;
      nrefine = 1;
      cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
      pathlen = static_cast<int32_T>(interval[1]) - static_cast<int32_T>
        (interval[0]);
      if (pathlen > 0) {
        n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
          - interval[0])) * 10 - 1);
        nsubs = n_idx_0 + 1;
        if (n_idx_0 + 2 > 2) {
          lidx = n_idx_0;
          interval[n_idx_0 + 1] = interval[1];
          interval_dirtyOnCpu = true;
          delta = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) +
            1.0);
          for (nrefine = 0; nrefine < lidx; nrefine++) {
            interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
              (n_idx_0 - nrefine) * delta;
          }
        }

        nrefine = n_idx_0 + 1;
      } else {
        nsubs = 1;
      }

      lidx = 0;
      for (acoef = 0; acoef < nrefine; acoef++) {
        if (std::abs(interval[acoef + 1] - interval[lidx]) > 0.0) {
          lidx++;
          interval[lidx] = interval[acoef + 1];
          interval_dirtyOnCpu = true;
        } else {
          nsubs--;
        }
      }

      if (nsubs + 1 < 2) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecc_cwtAvg_kernel50<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
          *gpu_interval);
        interval_dirtyOnCpu = false;
        nsubs = 1;
      }

      if (pathlen > 0) {
        nsubs--;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          interval_dirtyOnCpu = false;
          if (subs_dirtyOnCpu) {
            cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
          }

          ecc_cwtAvg_kernel51<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
          subs_dirtyOnCpu = false;
          subs_dirtyOnGpu = true;
        }

        q_ok = 0.0;
        err_ok = 0.0;
        first_iteration = true;
        emxInit_real_T(&g_x, 2, &f_emlrtRTEI, true);
        emxInit_real_T(&h_x, 2, &ac_emlrtRTEI, true);
        emxInit_real_T(&c_xt, 2, &ec_emlrtRTEI, true);
        emxInit_real_T(&dv11, 2, &yb_emlrtRTEI, true);
        emxInit_real_T(&c_fx, 2, &yb_emlrtRTEI, true);
        emxInit_real_T(&m_y, 2, &kc_emlrtRTEI, true);
        emxInit_real_T(&dv14, 2, &yb_emlrtRTEI, true);
        do {
          exitg1 = 0;
          k = g_x->size[0] * g_x->size[1];
          g_x->size[0] = 1;
          g_x->size[1] = 15 * (nsubs + 1);
          emxEnsureCapacity_real_T(g_x, k, &f_emlrtRTEI);
          if (!d_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(g_x, &g_gpu_x);
          }

          ix = -1;
          for (k = 0; k <= nsubs; k++) {
            if (subs_dirtyOnGpu) {
              cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
            }

            fc = subs[k << 1];
            subs_dirtyOnGpu = false;
            c_r = subs[(k << 1) + 1];
            r = (fc + c_r) / 2.0;
            delta = (c_r - fc) / 2.0;
            for (nrefine = 0; nrefine < 15; nrefine++) {
              g_x->data[(ix + nrefine) + 1] = NODES[nrefine] * delta + r;
              d_x_dirtyOnCpu = true;
            }

            ix += 15;
          }

          k = h_x->size[0] * h_x->size[1];
          h_x->size[0] = 1;
          h_x->size[1] = g_x->size[1];
          emxEnsureCapacity_real_T(h_x, k, &g_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(h_x, &h_gpu_x);
          k = c_xt->size[0] * c_xt->size[1];
          c_xt->size[0] = 1;
          c_xt->size[1] = g_x->size[1];
          emxEnsureCapacity_real_T(c_xt, k, &h_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_xt, &c_gpu_xt);
          lidx = g_x->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (d_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_x, g_x);
            }

            d_x_dirtyOnCpu = false;
            ecc_cwtAvg_kernel52<<<grid, block>>>(g_gpu_x, lidx, c_gpu_xt,
              h_gpu_x);
            d_x_dirtyOnGpu = true;
            c_xt_dirtyOnGpu = true;
          }

          b_guard1 = false;
          if (!first_iteration) {
            if (d_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_x, &h_gpu_x);
            }

            d_x_dirtyOnGpu = false;
            r = std::abs(h_x->data[0]);
            k = 0;
            exitg2 = false;
            while ((!exitg2) && (k <= h_x->size[1] - 2)) {
              toler = r;
              r = std::abs(h_x->data[k + 1]);
              if (std::abs(h_x->data[k + 1] - h_x->data[k]) <=
                  2.2204460492503131E-14 * std::fmax(toler, r)) {
                first_iteration = true;
                exitg2 = true;
              } else {
                k++;
              }
            }

            if (first_iteration) {
              dv4_idx_1 = static_cast<int16_T>(g_x->size[1]);
              k = c_fx->size[0] * c_fx->size[1];
              c_fx->size[0] = 1;
              c_fx->size[1] = g_x->size[1];
              emxEnsureCapacity_real_T(c_fx, k, &k_emlrtRTEI);
              if (!c_fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(c_fx, &c_gpu_fx);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (c_fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_fx, c_fx);
                }

                ecc_cwtAvg_kernel58<<<grid, block>>>(dv4_idx_1, c_gpu_fx);
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
            k = dv11->size[0] * dv11->size[1];
            dv11->size[0] = 1;
            dv11->size[1] = h_x->size[1];
            emxEnsureCapacity_real_T(dv11, k, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv11, &gpu_dv11);
            nrefine = h_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel53<<<grid, block>>>(h_gpu_x, nrefine, gpu_dv11);
              dv11_dirtyOnGpu = true;
            }

            k = m_y->size[0] * m_y->size[1];
            m_y->size[0] = 1;
            m_y->size[1] = h_x->size[1];
            emxEnsureCapacity_real_T(m_y, k, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(m_y, &h_gpu_y);
            nrefine = h_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel54<<<grid, block>>>(h_gpu_x, nrefine, h_gpu_y);
            }

            k = dv14->size[0] * dv14->size[1];
            dv14->size[0] = 1;
            dv14->size[1] = m_y->size[1];
            emxEnsureCapacity_real_T(dv14, k, &n_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv14, &gpu_dv14);
            bcoef = m_y->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (bcoef + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel55<<<grid, block>>>(h_gpu_y, bcoef, gpu_dv14);
              dv14_dirtyOnGpu = true;
            }

            nrefine = dv14->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel56<<<grid, block>>>(nrefine, gpu_dv14);
              dv14_dirtyOnGpu = true;
            }

            if (dv11->size[1] == dv14->size[1]) {
              k = c_fx->size[0] * c_fx->size[1];
              c_fx->size[0] = 1;
              c_fx->size[1] = dv11->size[1];
              emxEnsureCapacity_real_T(c_fx, k, &r_emlrtRTEI);
              if (!c_fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(c_fx, &c_gpu_fx);
              }

              bcoef = dv11->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (bcoef + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (c_fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_fx, c_fx);
                }

                ecc_cwtAvg_kernel57<<<grid, block>>>(c_gpu_xt, gpu_dv14,
                  gpu_dv11, bcoef, c_gpu_fx);
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
              b_binary_expand_op(c_fx, dv11, dv14, c_xt);
              c_fx_dirtyOnGpu = false;
              c_fx_dirtyOnCpu = true;
            }

            r = 0.0;
            ix = -1;
            for (k = 0; k <= nsubs; k++) {
              fc = 0.0;
              c_r = 0.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                if (c_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_fx, &c_gpu_fx);
                }

                fc += dv6[nrefine] * c_fx->data[(ix + nrefine) + 1];
                c_fx_dirtyOnGpu = false;
                c_r += dv7[nrefine] * c_fx->data[(ix + nrefine) + 1];
              }

              ix += 15;
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              delta = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
              fc *= delta;
              qsub[k] = fc;
              r += fc;
              errsub[k] = c_r * delta;
            }

            intFsq = r + q_ok;
            tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
            r = 2.0 * tol;
            c_r = 0.0;
            nrefine = 0;
            for (k = 0; k <= nsubs; k++) {
              fc = errsub[k];
              delta = std::abs(fc);
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              if (delta <= r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                err_ok += fc;
                q_ok += qsub[k];
              } else {
                c_r += delta;
                nrefine++;
                subs[(nrefine - 1) << 1] = subs[k << 1];
                subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                subs_dirtyOnCpu = true;
              }
            }

            r = std::abs(err_ok) + c_r;
            if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::isinf
                  (r)) && (!std::isnan(r))) && (nrefine != 0) && (!(r <= tol)))
            {
              nsubs = (nrefine << 1) - 1;
              if (nsubs + 1 > 650) {
                exitg1 = 1;
              } else {
                for (k = 0; k < nrefine; k++) {
                  acoef = nrefine - k;
                  if (subs_dirtyOnGpu) {
                    cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                  }

                  subs[(((acoef << 1) - 1) << 1) + 1] = subs[((acoef - 1) << 1)
                    + 1];
                  subs[((acoef << 1) - 1) << 1] = (subs[(acoef - 1) << 1] +
                    subs[((acoef - 1) << 1) + 1]) / 2.0;
                  subs[(((acoef << 1) - 2) << 1) + 1] = subs[((acoef << 1) - 1) <<
                    1];
                  subs[((acoef << 1) - 2) << 1] = subs[(acoef - 1) << 1];
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
        emxFree_real_T(&m_y);
        emxFree_real_T(&c_fx);
        emxFree_real_T(&dv11);
        emxFree_real_T(&c_xt);
        emxFree_real_T(&h_x);
        emxFree_real_T(&g_x);
      }
    }
    break;

   case 1:
   case 2:
    break;
  }

  N = static_cast<uint32_T>(b_x->size[0]) + static_cast<uint32_T>(fb_SignalPad <<
    1);
  lidx = static_cast<int32_T>(std::trunc(static_cast<real_T>(N) / 2.0));
  emxInit_real_T(&omega, 2, &b_emlrtRTEI, true);
  if (lidx < 1) {
    omega->size[1] = 0;
  } else {
    k = omega->size[0] * omega->size[1];
    omega->size[0] = 1;
    omega->size[1] = lidx;
    emxEnsureCapacity_real_T(omega, k, &b_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(omega, &gpu_omega);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((lidx - 1) +
      1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel59<<<grid, block>>>(lidx, gpu_omega);
      omega_dirtyOnGpu = true;
    }
  }

  k = omega->size[0] * omega->size[1];
  omega->size[0] = 1;
  emxEnsureCapacity_real_T(omega, k, &c_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(omega, &gpu_omega);
  k = omega->size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) + 1L),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ecc_cwtAvg_kernel60<<<grid, block>>>(N, k, gpu_omega);
    omega_dirtyOnGpu = true;
  }

  lidx = static_cast<int32_T>(std::trunc((static_cast<real_T>(N) - 1.0) / 2.0));
  if (lidx < 1) {
    acoef = 0;
    lidx = 1;
    nrefine = -1;
  } else {
    acoef = lidx - 1;
    lidx = -1;
    nrefine = 0;
  }

  emxInit_real_T(&d_r, 2, &d_emlrtRTEI, true);
  k = d_r->size[0] * d_r->size[1];
  d_r->size[0] = 1;
  d_r->size[1] = (omega->size[1] + div_s32(nrefine - acoef, lidx)) + 2;
  emxEnsureCapacity_real_T(d_r, k, &d_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(d_r, &gpu_r);
  ecc_cwtAvg_kernel61<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_r);
  eint = omega->size[1] - 1;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(eint + 1L),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ecc_cwtAvg_kernel62<<<grid, block>>>(gpu_omega, eint, gpu_r);
  }

  eint = div_s32(nrefine - acoef, lidx);
  ix = omega->size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(eint + 1L),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ecc_cwtAvg_kernel63<<<grid, block>>>(lidx, acoef, gpu_omega, eint, ix, gpu_r);
  }

  k = omega->size[0] * omega->size[1];
  omega->size[0] = 1;
  omega->size[1] = d_r->size[1];
  emxEnsureCapacity_real_T(omega, k, &e_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(omega, &gpu_omega);
  bcoef = d_r->size[1] - 1;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ecc_cwtAvg_kernel64<<<grid, block>>>(gpu_r, bcoef, gpu_omega);
    omega_dirtyOnGpu = true;
  }

  emxFree_real_T(&d_r);
  ecc_cwtAvg_kernel65<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_fLims,
    *gpu_b);
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

  emxInit_real_T(&fb_Scales, 2, &m_emlrtRTEI, true);
  if (!first_iteration) {
    ecc_cwtAvg_kernel95<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(fs, *gpu_fLims,
      *gpu_NyquistRange);
    m = 0.0;
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
      m = 1.8820720577620569;
      b_r = 0.0057083835261;
      r = 0.0057083835261;
      c_r = 0.0057083835261;
      for (acoef = 0; acoef < 6; acoef++) {
        fc = c[acoef];
        b_r = b_r * 0.005353955978584176 + fc;
        r = r * 0.005353955978584176 + fc;
        c_r = c_r * 0.005353955978584176 + fc;
      }

      b_r /= 13.666666666666666;
      r /= 13.666666666666666;
      c_r /= 13.666666666666666;
      delta = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                         exp((table100[14] + 2.5377749931802178) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                        exp((table100[13] + 5.8211893391859881) - (((c_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(delta) || std::isnan(delta)) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecc_cwtAvg_kernel96<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecc_cwtAvg_kernel97<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        pathlen = static_cast<int32_T>(interval[1]) - static_cast<int32_T>
          (interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            delta = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0)
              + 1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * delta;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (acoef = 0; acoef < nrefine; acoef++) {
          if (std::abs(interval[acoef + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[acoef + 1];
            interval_dirtyOnCpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecc_cwtAvg_kernel98<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine, *
            gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (pathlen > 0) {
          nsubs--;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ecc_cwtAvg_kernel99<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnCpu = false;
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&k_x, 2, &f_emlrtRTEI, true);
          emxInit_real_T(&l_x, 2, &ac_emlrtRTEI, true);
          emxInit_real_T(&e_xt, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&s_y, 2, &hc_emlrtRTEI, true);
          emxInit_real_T(&e_fx, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&u_y, 2, &ic_emlrtRTEI, true);
          emxInit_real_T(&d_a, 2, &l_emlrtRTEI, true);
          emxInit_real_T(&dv19, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&w_y, 2, &jc_emlrtRTEI, true);
          emxInit_real_T(&dv21, 2, &yb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            k = k_x->size[0] * k_x->size[1];
            k_x->size[0] = 1;
            k_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(k_x, k, &f_emlrtRTEI);
            if (!f_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(k_x, &k_gpu_x);
            }

            ix = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fc = subs[k << 1];
              subs_dirtyOnGpu = false;
              c_r = subs[(k << 1) + 1];
              r = (fc + c_r) / 2.0;
              delta = (c_r - fc) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                k_x->data[(ix + nrefine) + 1] = NODES[nrefine] * delta + r;
                f_x_dirtyOnCpu = true;
              }

              ix += 15;
            }

            k = l_x->size[0] * l_x->size[1];
            l_x->size[0] = 1;
            l_x->size[1] = k_x->size[1];
            emxEnsureCapacity_real_T(l_x, k, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(l_x, &l_gpu_x);
            k = e_xt->size[0] * e_xt->size[1];
            e_xt->size[0] = 1;
            e_xt->size[1] = k_x->size[1];
            emxEnsureCapacity_real_T(e_xt, k, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(e_xt, &e_gpu_xt);
            lidx = k_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (f_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&k_gpu_x, k_x);
              }

              f_x_dirtyOnCpu = false;
              ecc_cwtAvg_kernel100<<<grid, block>>>(k_gpu_x, lidx, e_gpu_xt,
                l_gpu_x);
              f_x_dirtyOnGpu = true;
              e_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (f_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(l_x, &l_gpu_x);
              }

              f_x_dirtyOnGpu = false;
              r = std::abs(l_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= l_x->size[1] - 2)) {
                delta = r;
                r = std::abs(l_x->data[k + 1]);
                if (std::abs(l_x->data[k + 1] - l_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(delta, r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(k_x->size[1]);
                k = e_fx->size[0] * e_fx->size[1];
                e_fx->size[0] = 1;
                e_fx->size[1] = k_x->size[1];
                emxEnsureCapacity_real_T(e_fx, k, &k_emlrtRTEI);
                if (!e_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(e_fx, &e_gpu_fx);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (e_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_fx, e_fx);
                  }

                  ecc_cwtAvg_kernel109<<<grid, block>>>(dv4_idx_1, e_gpu_fx);
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
              k = s_y->size[0] * s_y->size[1];
              s_y->size[0] = 1;
              s_y->size[1] = l_x->size[1];
              emxEnsureCapacity_real_T(s_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(s_y, &m_gpu_y);
              nrefine = l_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel101<<<grid, block>>>(l_gpu_x, nrefine, m_gpu_y);
                e_y_dirtyOnGpu = true;
              }

              k = u_y->size[0] * u_y->size[1];
              u_y->size[0] = 1;
              u_y->size[1] = l_x->size[1];
              emxEnsureCapacity_real_T(u_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(u_y, &o_gpu_y);
              nrefine = l_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel102<<<grid, block>>>(l_gpu_x, nrefine, o_gpu_y);
                g_y_dirtyOnGpu = true;
              }

              if (s_y->size[1] == u_y->size[1]) {
                k = d_a->size[0] * d_a->size[1];
                d_a->size[0] = 1;
                d_a->size[1] = s_y->size[1];
                emxEnsureCapacity_real_T(d_a, k, &l_emlrtRTEI);
                if (!c_a_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_a, &c_gpu_a);
                }

                bcoef = s_y->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (bcoef + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (c_a_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_a, d_a);
                  }

                  ecc_cwtAvg_kernel103<<<grid, block>>>(o_gpu_y, m_gpu_y, bcoef,
                    c_gpu_a);
                  c_a_dirtyOnCpu = false;
                  c_a_dirtyOnGpu = true;
                }
              } else {
                if (c_a_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_a, &c_gpu_a);
                }

                if (e_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(s_y, &m_gpu_y);
                }

                e_y_dirtyOnGpu = false;
                if (g_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(u_y, &o_gpu_y);
                }

                g_y_dirtyOnGpu = false;
                c_binary_expand_op(d_a, s_y, u_y);
                c_a_dirtyOnGpu = false;
                c_a_dirtyOnCpu = true;
              }

              k = dv19->size[0] * dv19->size[1];
              dv19->size[0] = 1;
              dv19->size[1] = static_cast<int16_T>(d_a->size[1]);
              emxEnsureCapacity_real_T(dv19, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv19, &gpu_dv19);
              nrefine = static_cast<int16_T>(d_a->size[1]) - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (c_a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_a, d_a);
                }

                c_a_dirtyOnCpu = false;
                ecc_cwtAvg_kernel104<<<grid, block>>>(c_gpu_a, nrefine, gpu_dv19);
                dv19_dirtyOnGpu = true;
              }

              k = w_y->size[0] * w_y->size[1];
              w_y->size[0] = 1;
              w_y->size[1] = l_x->size[1];
              emxEnsureCapacity_real_T(w_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(w_y, &s_gpu_y);
              nrefine = l_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel105<<<grid, block>>>(l_gpu_x, nrefine, s_gpu_y);
              }

              k = dv21->size[0] * dv21->size[1];
              dv21->size[0] = 1;
              dv21->size[1] = w_y->size[1];
              emxEnsureCapacity_real_T(dv21, k, &n_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv21, &gpu_dv21);
              bcoef = w_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (bcoef + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel106<<<grid, block>>>(s_gpu_y, bcoef, gpu_dv21);
                dv21_dirtyOnGpu = true;
              }

              nrefine = dv21->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel107<<<grid, block>>>(nrefine, gpu_dv21);
                dv21_dirtyOnGpu = true;
              }

              if (dv19->size[1] == dv21->size[1]) {
                k = e_fx->size[0] * e_fx->size[1];
                e_fx->size[0] = 1;
                e_fx->size[1] = dv19->size[1];
                emxEnsureCapacity_real_T(e_fx, k, &r_emlrtRTEI);
                if (!e_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(e_fx, &e_gpu_fx);
                }

                bcoef = dv19->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (bcoef + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (e_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_fx, e_fx);
                  }

                  ecc_cwtAvg_kernel108<<<grid, block>>>(e_gpu_xt, gpu_dv21,
                    gpu_dv19, bcoef, e_gpu_fx);
                  e_fx_dirtyOnCpu = false;
                  e_fx_dirtyOnGpu = true;
                }
              } else {
                if (e_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(e_fx, &e_gpu_fx);
                }

                if (dv19_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv19, &gpu_dv19);
                }

                dv19_dirtyOnGpu = false;
                if (dv21_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv21, &gpu_dv21);
                }

                dv21_dirtyOnGpu = false;
                if (e_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(e_xt, &e_gpu_xt);
                }

                e_xt_dirtyOnGpu = false;
                b_binary_expand_op(e_fx, dv19, dv21, e_xt);
                e_fx_dirtyOnGpu = false;
                e_fx_dirtyOnCpu = true;
              }

              r = 0.0;
              ix = -1;
              for (k = 0; k <= nsubs; k++) {
                fc = 0.0;
                c_r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (e_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(e_fx, &e_gpu_fx);
                  }

                  fc += dv6[nrefine] * e_fx->data[(ix + nrefine) + 1];
                  e_fx_dirtyOnGpu = false;
                  c_r += dv7[nrefine] * e_fx->data[(ix + nrefine) + 1];
                }

                ix += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                delta = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fc *= delta;
                qsub[k] = fc;
                r += fc;
                errsub[k] = c_r * delta;
              }

              intDsq = r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              r = 2.0 * tol;
              c_r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fc = errsub[k];
                delta = std::abs(fc);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (delta <= r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[k];
                } else {
                  c_r += delta;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              r = std::abs(err_ok) + c_r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(r)) && (!std::isnan(r))) && (nrefine != 0) && (!(r <=
                    tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    acoef = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((acoef << 1) - 1) << 1) + 1] = subs[((acoef - 1) << 1)
                      + 1];
                    subs[((acoef << 1) - 1) << 1] = (subs[(acoef - 1) << 1] +
                      subs[((acoef - 1) << 1) + 1]) / 2.0;
                    subs[(((acoef << 1) - 2) << 1) + 1] = subs[((acoef << 1) - 1)
                      << 1];
                    subs[((acoef << 1) - 2) << 1] = subs[(acoef - 1) << 1];
                    subs_dirtyOnGpu = false;
                    subs_dirtyOnCpu = true;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&dv21);
          emxFree_real_T(&w_y);
          emxFree_real_T(&dv19);
          emxFree_real_T(&d_a);
          emxFree_real_T(&u_y);
          emxFree_real_T(&e_fx);
          emxFree_real_T(&s_y);
          emxFree_real_T(&e_xt);
          emxFree_real_T(&l_x);
          emxFree_real_T(&k_x);
        }

        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecc_cwtAvg_kernel110<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecc_cwtAvg_kernel111<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        pathlen = static_cast<int32_T>(interval[1]) - static_cast<int32_T>
          (interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            delta = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0)
              + 1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * delta;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (acoef = 0; acoef < nrefine; acoef++) {
          if (std::abs(interval[acoef + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[acoef + 1];
            interval_dirtyOnCpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecc_cwtAvg_kernel112<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
            *gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (pathlen > 0) {
          nsubs--;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ecc_cwtAvg_kernel113<<<grid, block>>>(*gpu_interval, nsubs,
              *gpu_subs);
            subs_dirtyOnCpu = false;
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&o_x, 2, &f_emlrtRTEI, true);
          emxInit_real_T(&p_x, 2, &ac_emlrtRTEI, true);
          emxInit_real_T(&g_xt, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&dv23, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&g_fx, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&y_y, 2, &kc_emlrtRTEI, true);
          emxInit_real_T(&dv27, 2, &yb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            k = o_x->size[0] * o_x->size[1];
            o_x->size[0] = 1;
            o_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(o_x, k, &f_emlrtRTEI);
            if (!h_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(o_x, &o_gpu_x);
            }

            ix = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fc = subs[k << 1];
              subs_dirtyOnGpu = false;
              c_r = subs[(k << 1) + 1];
              r = (fc + c_r) / 2.0;
              delta = (c_r - fc) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                o_x->data[(ix + nrefine) + 1] = NODES[nrefine] * delta + r;
                h_x_dirtyOnCpu = true;
              }

              ix += 15;
            }

            k = p_x->size[0] * p_x->size[1];
            p_x->size[0] = 1;
            p_x->size[1] = o_x->size[1];
            emxEnsureCapacity_real_T(p_x, k, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(p_x, &p_gpu_x);
            k = g_xt->size[0] * g_xt->size[1];
            g_xt->size[0] = 1;
            g_xt->size[1] = o_x->size[1];
            emxEnsureCapacity_real_T(g_xt, k, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(g_xt, &g_gpu_xt);
            lidx = o_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (h_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&o_gpu_x, o_x);
              }

              h_x_dirtyOnCpu = false;
              ecc_cwtAvg_kernel114<<<grid, block>>>(o_gpu_x, lidx, g_gpu_xt,
                p_gpu_x);
              h_x_dirtyOnGpu = true;
              g_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (h_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(p_x, &p_gpu_x);
              }

              h_x_dirtyOnGpu = false;
              r = std::abs(p_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= p_x->size[1] - 2)) {
                delta = r;
                r = std::abs(p_x->data[k + 1]);
                if (std::abs(p_x->data[k + 1] - p_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(delta, r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(o_x->size[1]);
                k = g_fx->size[0] * g_fx->size[1];
                g_fx->size[0] = 1;
                g_fx->size[1] = o_x->size[1];
                emxEnsureCapacity_real_T(g_fx, k, &k_emlrtRTEI);
                if (!g_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(g_fx, &g_gpu_fx);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (g_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_fx, g_fx);
                  }

                  ecc_cwtAvg_kernel120<<<grid, block>>>(dv4_idx_1, g_gpu_fx);
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
              k = dv23->size[0] * dv23->size[1];
              dv23->size[0] = 1;
              dv23->size[1] = p_x->size[1];
              emxEnsureCapacity_real_T(dv23, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv23, &gpu_dv23);
              nrefine = p_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel115<<<grid, block>>>(p_gpu_x, nrefine, gpu_dv23);
                dv23_dirtyOnGpu = true;
              }

              k = y_y->size[0] * y_y->size[1];
              y_y->size[0] = 1;
              y_y->size[1] = p_x->size[1];
              emxEnsureCapacity_real_T(y_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(y_y, &q_gpu_y);
              nrefine = p_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel116<<<grid, block>>>(p_gpu_x, nrefine, q_gpu_y);
              }

              k = dv27->size[0] * dv27->size[1];
              dv27->size[0] = 1;
              dv27->size[1] = y_y->size[1];
              emxEnsureCapacity_real_T(dv27, k, &n_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv27, &gpu_dv27);
              bcoef = y_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (bcoef + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel117<<<grid, block>>>(q_gpu_y, bcoef, gpu_dv27);
                dv27_dirtyOnGpu = true;
              }

              nrefine = dv27->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel118<<<grid, block>>>(nrefine, gpu_dv27);
                dv27_dirtyOnGpu = true;
              }

              if (dv23->size[1] == dv27->size[1]) {
                k = g_fx->size[0] * g_fx->size[1];
                g_fx->size[0] = 1;
                g_fx->size[1] = dv23->size[1];
                emxEnsureCapacity_real_T(g_fx, k, &r_emlrtRTEI);
                if (!g_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(g_fx, &g_gpu_fx);
                }

                bcoef = dv23->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (bcoef + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (g_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_fx, g_fx);
                  }

                  ecc_cwtAvg_kernel119<<<grid, block>>>(g_gpu_xt, gpu_dv27,
                    gpu_dv23, bcoef, g_gpu_fx);
                  g_fx_dirtyOnCpu = false;
                  g_fx_dirtyOnGpu = true;
                }
              } else {
                if (g_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(g_fx, &g_gpu_fx);
                }

                if (dv23_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv23, &gpu_dv23);
                }

                dv23_dirtyOnGpu = false;
                if (dv27_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv27, &gpu_dv27);
                }

                dv27_dirtyOnGpu = false;
                if (g_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(g_xt, &g_gpu_xt);
                }

                g_xt_dirtyOnGpu = false;
                b_binary_expand_op(g_fx, dv23, dv27, g_xt);
                g_fx_dirtyOnGpu = false;
                g_fx_dirtyOnCpu = true;
              }

              r = 0.0;
              ix = -1;
              for (k = 0; k <= nsubs; k++) {
                fc = 0.0;
                c_r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (g_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(g_fx, &g_gpu_fx);
                  }

                  fc += dv6[nrefine] * g_fx->data[(ix + nrefine) + 1];
                  g_fx_dirtyOnGpu = false;
                  c_r += dv7[nrefine] * g_fx->data[(ix + nrefine) + 1];
                }

                ix += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                delta = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fc *= delta;
                qsub[k] = fc;
                r += fc;
                errsub[k] = c_r * delta;
              }

              intFsq = r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              r = 2.0 * tol;
              c_r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fc = errsub[k];
                delta = std::abs(fc);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (delta <= r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[k];
                } else {
                  c_r += delta;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              r = std::abs(err_ok) + c_r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(r)) && (!std::isnan(r))) && (nrefine != 0) && (!(r <=
                    tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    acoef = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((acoef << 1) - 1) << 1) + 1] = subs[((acoef - 1) << 1)
                      + 1];
                    subs[((acoef << 1) - 1) << 1] = (subs[(acoef - 1) << 1] +
                      subs[((acoef - 1) << 1) + 1]) / 2.0;
                    subs[(((acoef << 1) - 2) << 1) + 1] = subs[((acoef << 1) - 1)
                      << 1];
                    subs[((acoef << 1) - 2) << 1] = subs[(acoef - 1) << 1];
                    subs_dirtyOnGpu = false;
                    subs_dirtyOnCpu = true;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&dv27);
          emxFree_real_T(&y_y);
          emxFree_real_T(&g_fx);
          emxFree_real_T(&dv23);
          emxFree_real_T(&g_xt);
          emxFree_real_T(&p_x);
          emxFree_real_T(&o_x);
        }
      }
      break;

     case 1:
      m = 6.0;
      break;

     case 2:
      m = 5.0;
      break;
    }

    cudaMemcpy(NyquistRange, *gpu_NyquistRange, 16UL, cudaMemcpyDeviceToHost);
    c_r = m / NyquistRange[1];
    r = m / NyquistRange[0] / c_r;
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

    emxInit_real_T(&n_y, 2, &wb_emlrtRTEI, true);
    r *= fOctave;
    if (std::isnan(r)) {
      k = n_y->size[0] * n_y->size[1];
      n_y->size[0] = 1;
      n_y->size[1] = 1;
      emxEnsureCapacity_real_T(n_y, k, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(n_y, &b_gpu_y);
      n_y->data[0] = rtNaN;
      y_dirtyOnCpu = true;
    } else if (r < 0.0) {
      n_y->size[0] = 1;
      n_y->size[1] = 0;
    } else {
      k = n_y->size[0] * n_y->size[1];
      n_y->size[0] = 1;
      n_y->size[1] = static_cast<int32_T>(r) + 1;
      emxEnsureCapacity_real_T(n_y, k, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(n_y, &b_gpu_y);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
        static_cast<int32_T>(r) + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_cwtAvg_kernel121<<<grid, block>>>(r, b_gpu_y);
      }
    }

    emxInit_real_T(&p_y, 2, &xb_emlrtRTEI, true);
    k = p_y->size[0] * p_y->size[1];
    p_y->size[0] = 1;
    p_y->size[1] = n_y->size[1];
    emxEnsureCapacity_real_T(p_y, k, &i_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(p_y, &e_gpu_y);
    nrefine = n_y->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (y_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_y, n_y);
      }

      ecc_cwtAvg_kernel122<<<grid, block>>>(b_gpu_y, rt_powd_snf(2.0, 1.0 /
        fOctave), nrefine, e_gpu_y);
    }

    emxFree_real_T(&n_y);
    k = fb_Scales->size[0] * fb_Scales->size[1];
    fb_Scales->size[0] = 1;
    fb_Scales->size[1] = p_y->size[1];
    emxEnsureCapacity_real_T(fb_Scales, k, &m_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(fb_Scales, &gpu_fb_Scales);
    bcoef = p_y->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel123<<<grid, block>>>(e_gpu_y, c_r, bcoef, gpu_fb_Scales);
      fb_Scales_dirtyOnGpu = true;
    }

    emxFree_real_T(&p_y);
  } else {
    ecc_cwtAvg_kernel66<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*cv_gpu_clone, *
      gpu_wav, 'M', 'o', 'r', 's', 'e');
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
      r = 0.0057083835261;
      c_r = 0.0057083835261;
      for (acoef = 0; acoef < 6; acoef++) {
        fc = c[acoef];
        b_r = b_r * 0.005353955978584176 + fc;
        r = r * 0.005353955978584176 + fc;
        c_r = c_r * 0.005353955978584176 + fc;
      }

      b_r /= 13.666666666666666;
      r /= 13.666666666666666;
      c_r /= 13.666666666666666;
      c_r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((c_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(c_r) || std::isnan(c_r)) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecc_cwtAvg_kernel67<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecc_cwtAvg_kernel68<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        intDsq = 0.0;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        pathlen = static_cast<int32_T>(interval[1]) - static_cast<int32_T>
          (interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            delta = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0)
              + 1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * delta;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (acoef = 0; acoef < nrefine; acoef++) {
          if (std::abs(interval[acoef + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[acoef + 1];
            interval_dirtyOnCpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecc_cwtAvg_kernel69<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine, *
            gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
          intDsq = rtNaN;
        } else {
          nsubs--;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ecc_cwtAvg_kernel70<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnCpu = false;
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          emxInit_real_T(&m_x, 2, &f_emlrtRTEI, true);
          emxInit_real_T(&n_x, 2, &ac_emlrtRTEI, true);
          emxInit_real_T(&f_xt, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&t_y, 2, &hc_emlrtRTEI, true);
          emxInit_real_T(&f_fx, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&v_y, 2, &ic_emlrtRTEI, true);
          emxInit_real_T(&e_a, 2, &l_emlrtRTEI, true);
          emxInit_real_T(&dv20, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&x_y, 2, &jc_emlrtRTEI, true);
          emxInit_real_T(&dv24, 2, &yb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            k = m_x->size[0] * m_x->size[1];
            m_x->size[0] = 1;
            m_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(m_x, k, &f_emlrtRTEI);
            if (!g_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(m_x, &m_gpu_x);
            }

            ix = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fc = subs[k << 1];
              subs_dirtyOnGpu = false;
              c_r = subs[(k << 1) + 1];
              r = (fc + c_r) / 2.0;
              delta = (c_r - fc) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                m_x->data[(ix + nrefine) + 1] = NODES[nrefine] * delta + r;
                g_x_dirtyOnCpu = true;
              }

              ix += 15;
            }

            k = n_x->size[0] * n_x->size[1];
            n_x->size[0] = 1;
            n_x->size[1] = m_x->size[1];
            emxEnsureCapacity_real_T(n_x, k, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(n_x, &n_gpu_x);
            k = f_xt->size[0] * f_xt->size[1];
            f_xt->size[0] = 1;
            f_xt->size[1] = m_x->size[1];
            emxEnsureCapacity_real_T(f_xt, k, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(f_xt, &f_gpu_xt);
            lidx = m_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (g_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_x, m_x);
              }

              g_x_dirtyOnCpu = false;
              ecc_cwtAvg_kernel71<<<grid, block>>>(m_gpu_x, lidx, f_gpu_xt,
                n_gpu_x);
              g_x_dirtyOnGpu = true;
              f_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (g_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(n_x, &n_gpu_x);
              }

              g_x_dirtyOnGpu = false;
              r = std::abs(n_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= n_x->size[1] - 2)) {
                toler = r;
                r = std::abs(n_x->data[k + 1]);
                if (std::abs(n_x->data[k + 1] - n_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(toler, r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(m_x->size[1]);
                k = f_fx->size[0] * f_fx->size[1];
                f_fx->size[0] = 1;
                f_fx->size[1] = m_x->size[1];
                emxEnsureCapacity_real_T(f_fx, k, &k_emlrtRTEI);
                if (!f_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(f_fx, &f_gpu_fx);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (f_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_fx, f_fx);
                  }

                  ecc_cwtAvg_kernel80<<<grid, block>>>(dv4_idx_1, f_gpu_fx);
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
              k = t_y->size[0] * t_y->size[1];
              t_y->size[0] = 1;
              t_y->size[1] = n_x->size[1];
              emxEnsureCapacity_real_T(t_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(t_y, &n_gpu_y);
              nrefine = n_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel72<<<grid, block>>>(n_gpu_x, nrefine, n_gpu_y);
                f_y_dirtyOnGpu = true;
              }

              k = v_y->size[0] * v_y->size[1];
              v_y->size[0] = 1;
              v_y->size[1] = n_x->size[1];
              emxEnsureCapacity_real_T(v_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(v_y, &p_gpu_y);
              nrefine = n_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel73<<<grid, block>>>(n_gpu_x, nrefine, p_gpu_y);
                h_y_dirtyOnGpu = true;
              }

              if (t_y->size[1] == v_y->size[1]) {
                k = e_a->size[0] * e_a->size[1];
                e_a->size[0] = 1;
                e_a->size[1] = t_y->size[1];
                emxEnsureCapacity_real_T(e_a, k, &l_emlrtRTEI);
                if (!d_a_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(e_a, &d_gpu_a);
                }

                bcoef = t_y->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (bcoef + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (d_a_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, e_a);
                  }

                  ecc_cwtAvg_kernel74<<<grid, block>>>(p_gpu_y, n_gpu_y, bcoef,
                    d_gpu_a);
                  d_a_dirtyOnCpu = false;
                  d_a_dirtyOnGpu = true;
                }
              } else {
                if (d_a_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(e_a, &d_gpu_a);
                }

                if (f_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(t_y, &n_gpu_y);
                }

                f_y_dirtyOnGpu = false;
                if (h_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(v_y, &p_gpu_y);
                }

                h_y_dirtyOnGpu = false;
                c_binary_expand_op(e_a, t_y, v_y);
                d_a_dirtyOnGpu = false;
                d_a_dirtyOnCpu = true;
              }

              k = dv20->size[0] * dv20->size[1];
              dv20->size[0] = 1;
              dv20->size[1] = static_cast<int16_T>(e_a->size[1]);
              emxEnsureCapacity_real_T(dv20, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv20, &gpu_dv20);
              nrefine = static_cast<int16_T>(e_a->size[1]) - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (d_a_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, e_a);
                }

                d_a_dirtyOnCpu = false;
                ecc_cwtAvg_kernel75<<<grid, block>>>(d_gpu_a, nrefine, gpu_dv20);
                dv20_dirtyOnGpu = true;
              }

              k = x_y->size[0] * x_y->size[1];
              x_y->size[0] = 1;
              x_y->size[1] = n_x->size[1];
              emxEnsureCapacity_real_T(x_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(x_y, &t_gpu_y);
              nrefine = n_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel76<<<grid, block>>>(n_gpu_x, nrefine, t_gpu_y);
              }

              k = dv24->size[0] * dv24->size[1];
              dv24->size[0] = 1;
              dv24->size[1] = x_y->size[1];
              emxEnsureCapacity_real_T(dv24, k, &n_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv24, &gpu_dv24);
              bcoef = x_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (bcoef + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel77<<<grid, block>>>(t_gpu_y, bcoef, gpu_dv24);
                dv24_dirtyOnGpu = true;
              }

              nrefine = dv24->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel78<<<grid, block>>>(nrefine, gpu_dv24);
                dv24_dirtyOnGpu = true;
              }

              if (dv20->size[1] == dv24->size[1]) {
                k = f_fx->size[0] * f_fx->size[1];
                f_fx->size[0] = 1;
                f_fx->size[1] = dv20->size[1];
                emxEnsureCapacity_real_T(f_fx, k, &r_emlrtRTEI);
                if (!f_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(f_fx, &f_gpu_fx);
                }

                bcoef = dv20->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (bcoef + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (f_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_fx, f_fx);
                  }

                  ecc_cwtAvg_kernel79<<<grid, block>>>(f_gpu_xt, gpu_dv24,
                    gpu_dv20, bcoef, f_gpu_fx);
                  f_fx_dirtyOnCpu = false;
                  f_fx_dirtyOnGpu = true;
                }
              } else {
                if (f_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(f_fx, &f_gpu_fx);
                }

                if (dv20_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv20, &gpu_dv20);
                }

                dv20_dirtyOnGpu = false;
                if (dv24_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv24, &gpu_dv24);
                }

                dv24_dirtyOnGpu = false;
                if (f_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(f_xt, &f_gpu_xt);
                }

                f_xt_dirtyOnGpu = false;
                b_binary_expand_op(f_fx, dv20, dv24, f_xt);
                f_fx_dirtyOnGpu = false;
                f_fx_dirtyOnCpu = true;
              }

              r = 0.0;
              ix = -1;
              for (k = 0; k <= nsubs; k++) {
                fc = 0.0;
                c_r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (f_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(f_fx, &f_gpu_fx);
                  }

                  fc += dv6[nrefine] * f_fx->data[(ix + nrefine) + 1];
                  f_fx_dirtyOnGpu = false;
                  c_r += dv7[nrefine] * f_fx->data[(ix + nrefine) + 1];
                }

                ix += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                delta = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fc *= delta;
                qsub[k] = fc;
                r += fc;
                errsub[k] = c_r * delta;
              }

              intDsq = r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              r = 2.0 * tol;
              c_r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fc = errsub[k];
                delta = std::abs(fc);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (delta <= r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[k];
                } else {
                  c_r += delta;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              r = std::abs(err_ok) + c_r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(r)) && (!std::isnan(r))) && (nrefine != 0) && (!(r <=
                    tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    acoef = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((acoef << 1) - 1) << 1) + 1] = subs[((acoef - 1) << 1)
                      + 1];
                    subs[((acoef << 1) - 1) << 1] = (subs[(acoef - 1) << 1] +
                      subs[((acoef - 1) << 1) + 1]) / 2.0;
                    subs[(((acoef << 1) - 2) << 1) + 1] = subs[((acoef << 1) - 1)
                      << 1];
                    subs[((acoef << 1) - 2) << 1] = subs[(acoef - 1) << 1];
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
          emxFree_real_T(&x_y);
          emxFree_real_T(&dv20);
          emxFree_real_T(&e_a);
          emxFree_real_T(&v_y);
          emxFree_real_T(&f_fx);
          emxFree_real_T(&t_y);
          emxFree_real_T(&f_xt);
          emxFree_real_T(&n_x);
          emxFree_real_T(&m_x);
        }

        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecc_cwtAvg_kernel81<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ecc_cwtAvg_kernel82<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
          (*gpu_interval);
        interval_dirtyOnCpu = false;
        intFsq = 0.0;
        nrefine = 1;
        cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
        pathlen = static_cast<int32_T>(interval[1]) - static_cast<int32_T>
          (interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs(interval[1]
            - interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            interval[n_idx_0 + 1] = interval[1];
            interval_dirtyOnCpu = true;
            delta = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0)
              + 1.0);
            for (nrefine = 0; nrefine < lidx; nrefine++) {
              interval[n_idx_0 - nrefine] = interval[0] + static_cast<real_T>
                (n_idx_0 - nrefine) * delta;
            }
          }

          nrefine = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (acoef = 0; acoef < nrefine; acoef++) {
          if (std::abs(interval[acoef + 1] - interval[lidx]) > 0.0) {
            lidx++;
            interval[lidx] = interval[acoef + 1];
            interval_dirtyOnCpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          ecc_cwtAvg_kernel83<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine, *
            gpu_interval);
          interval_dirtyOnCpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
          intFsq = rtNaN;
        } else {
          nsubs--;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (interval_dirtyOnCpu) {
              cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
            }

            interval_dirtyOnCpu = false;
            if (subs_dirtyOnCpu) {
              cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
            }

            ecc_cwtAvg_kernel84<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
            subs_dirtyOnCpu = false;
            subs_dirtyOnGpu = true;
          }

          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          emxInit_real_T(&q_x, 2, &f_emlrtRTEI, true);
          emxInit_real_T(&r_x, 2, &ac_emlrtRTEI, true);
          emxInit_real_T(&h_xt, 2, &ec_emlrtRTEI, true);
          emxInit_real_T(&dv26, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&h_fx, 2, &yb_emlrtRTEI, true);
          emxInit_real_T(&ab_y, 2, &kc_emlrtRTEI, true);
          emxInit_real_T(&dv29, 2, &yb_emlrtRTEI, true);
          do {
            exitg1 = 0;
            k = q_x->size[0] * q_x->size[1];
            q_x->size[0] = 1;
            q_x->size[1] = 15 * (nsubs + 1);
            emxEnsureCapacity_real_T(q_x, k, &f_emlrtRTEI);
            if (!i_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(q_x, &q_gpu_x);
            }

            ix = -1;
            for (k = 0; k <= nsubs; k++) {
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              fc = subs[k << 1];
              subs_dirtyOnGpu = false;
              c_r = subs[(k << 1) + 1];
              r = (fc + c_r) / 2.0;
              delta = (c_r - fc) / 2.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                q_x->data[(ix + nrefine) + 1] = NODES[nrefine] * delta + r;
                i_x_dirtyOnCpu = true;
              }

              ix += 15;
            }

            k = r_x->size[0] * r_x->size[1];
            r_x->size[0] = 1;
            r_x->size[1] = q_x->size[1];
            emxEnsureCapacity_real_T(r_x, k, &g_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(r_x, &r_gpu_x);
            k = h_xt->size[0] * h_xt->size[1];
            h_xt->size[0] = 1;
            h_xt->size[1] = q_x->size[1];
            emxEnsureCapacity_real_T(h_xt, k, &h_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(h_xt, &h_gpu_xt);
            lidx = q_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (i_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&q_gpu_x, q_x);
              }

              i_x_dirtyOnCpu = false;
              ecc_cwtAvg_kernel85<<<grid, block>>>(q_gpu_x, lidx, h_gpu_xt,
                r_gpu_x);
              i_x_dirtyOnGpu = true;
              h_xt_dirtyOnGpu = true;
            }

            b_guard1 = false;
            if (!first_iteration) {
              if (i_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(r_x, &r_gpu_x);
              }

              i_x_dirtyOnGpu = false;
              r = std::abs(r_x->data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= r_x->size[1] - 2)) {
                toler = r;
                r = std::abs(r_x->data[k + 1]);
                if (std::abs(r_x->data[k + 1] - r_x->data[k]) <=
                    2.2204460492503131E-14 * std::fmax(toler, r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                dv4_idx_1 = static_cast<int16_T>(q_x->size[1]);
                k = h_fx->size[0] * h_fx->size[1];
                h_fx->size[0] = 1;
                h_fx->size[1] = q_x->size[1];
                emxEnsureCapacity_real_T(h_fx, k, &k_emlrtRTEI);
                if (!h_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(h_fx, &h_gpu_fx);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (h_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_fx, h_fx);
                  }

                  ecc_cwtAvg_kernel91<<<grid, block>>>(dv4_idx_1, h_gpu_fx);
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
              k = dv26->size[0] * dv26->size[1];
              dv26->size[0] = 1;
              dv26->size[1] = r_x->size[1];
              emxEnsureCapacity_real_T(dv26, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv26, &gpu_dv26);
              nrefine = r_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel86<<<grid, block>>>(r_gpu_x, nrefine, gpu_dv26);
                dv26_dirtyOnGpu = true;
              }

              k = ab_y->size[0] * ab_y->size[1];
              ab_y->size[0] = 1;
              ab_y->size[1] = r_x->size[1];
              emxEnsureCapacity_real_T(ab_y, k, &i_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(ab_y, &r_gpu_y);
              nrefine = r_x->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel87<<<grid, block>>>(r_gpu_x, nrefine, r_gpu_y);
              }

              k = dv29->size[0] * dv29->size[1];
              dv29->size[0] = 1;
              dv29->size[1] = ab_y->size[1];
              emxEnsureCapacity_real_T(dv29, k, &n_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(dv29, &gpu_dv29);
              bcoef = ab_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (bcoef + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel88<<<grid, block>>>(r_gpu_y, bcoef, gpu_dv29);
                dv29_dirtyOnGpu = true;
              }

              nrefine = dv29->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (nrefine + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_cwtAvg_kernel89<<<grid, block>>>(nrefine, gpu_dv29);
                dv29_dirtyOnGpu = true;
              }

              if (dv26->size[1] == dv29->size[1]) {
                k = h_fx->size[0] * h_fx->size[1];
                h_fx->size[0] = 1;
                h_fx->size[1] = dv26->size[1];
                emxEnsureCapacity_real_T(h_fx, k, &r_emlrtRTEI);
                if (!h_fx_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(h_fx, &h_gpu_fx);
                }

                bcoef = dv26->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (bcoef + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (h_fx_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_fx, h_fx);
                  }

                  ecc_cwtAvg_kernel90<<<grid, block>>>(h_gpu_xt, gpu_dv29,
                    gpu_dv26, bcoef, h_gpu_fx);
                  h_fx_dirtyOnCpu = false;
                  h_fx_dirtyOnGpu = true;
                }
              } else {
                if (h_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(h_fx, &h_gpu_fx);
                }

                if (dv26_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv26, &gpu_dv26);
                }

                dv26_dirtyOnGpu = false;
                if (dv29_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(dv29, &gpu_dv29);
                }

                dv29_dirtyOnGpu = false;
                if (h_xt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(h_xt, &h_gpu_xt);
                }

                h_xt_dirtyOnGpu = false;
                b_binary_expand_op(h_fx, dv26, dv29, h_xt);
                h_fx_dirtyOnGpu = false;
                h_fx_dirtyOnCpu = true;
              }

              r = 0.0;
              ix = -1;
              for (k = 0; k <= nsubs; k++) {
                fc = 0.0;
                c_r = 0.0;
                for (nrefine = 0; nrefine < 15; nrefine++) {
                  if (h_fx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(h_fx, &h_gpu_fx);
                  }

                  fc += dv6[nrefine] * h_fx->data[(ix + nrefine) + 1];
                  h_fx_dirtyOnGpu = false;
                  c_r += dv7[nrefine] * h_fx->data[(ix + nrefine) + 1];
                }

                ix += 15;
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                delta = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
                fc *= delta;
                qsub[k] = fc;
                r += fc;
                errsub[k] = c_r * delta;
              }

              intFsq = r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              r = 2.0 * tol;
              c_r = 0.0;
              nrefine = 0;
              for (k = 0; k <= nsubs; k++) {
                fc = errsub[k];
                delta = std::abs(fc);
                if (subs_dirtyOnGpu) {
                  cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                }

                subs_dirtyOnGpu = false;
                if (delta <= r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[k];
                } else {
                  c_r += delta;
                  nrefine++;
                  subs[(nrefine - 1) << 1] = subs[k << 1];
                  subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                  subs_dirtyOnCpu = true;
                }
              }

              r = std::abs(err_ok) + c_r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(r)) && (!std::isnan(r))) && (nrefine != 0) && (!(r <=
                    tol))) {
                nsubs = (nrefine << 1) - 1;
                if (nsubs + 1 > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < nrefine; k++) {
                    acoef = nrefine - k;
                    if (subs_dirtyOnGpu) {
                      cudaMemcpy(subs, *gpu_subs, 10384UL,
                                 cudaMemcpyDeviceToHost);
                    }

                    subs[(((acoef << 1) - 1) << 1) + 1] = subs[((acoef - 1) << 1)
                      + 1];
                    subs[((acoef << 1) - 1) << 1] = (subs[(acoef - 1) << 1] +
                      subs[((acoef - 1) << 1) + 1]) / 2.0;
                    subs[(((acoef << 1) - 2) << 1) + 1] = subs[((acoef << 1) - 1)
                      << 1];
                    subs[((acoef << 1) - 2) << 1] = subs[(acoef - 1) << 1];
                    subs_dirtyOnGpu = false;
                    subs_dirtyOnCpu = true;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);

          emxFree_real_T(&dv29);
          emxFree_real_T(&ab_y);
          emxFree_real_T(&h_fx);
          emxFree_real_T(&dv26);
          emxFree_real_T(&h_xt);
          emxFree_real_T(&r_x);
          emxFree_real_T(&q_x);
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

    tol = static_cast<real_T>(b_x->size[0]) / (c_r * 2.0);
    first_iteration = false;
    nrefine = 0;
    do {
      exitg1 = 0;
      if (nrefine + 1 < 6) {
        if (wav[nrefine] != cv3[nrefine]) {
          exitg1 = 1;
        } else {
          nrefine++;
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
      c_r = 2.0 * (static_cast<real_T>(fb_CutOff) / 100.0);
      if (c_r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
          (-rt_powd_snf(a, 3.0)) >= 0.0) {
        if (c_r == c_r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
            (-rt_powd_snf(a, 3.0))) {
          omegac = 9.0856029641606977;
        } else {
          omegac = a;
        }
      } else {
        omegac = 9.0856029641606977;
        r = c_r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
          (-rt_powd_snf(a, 3.0));
        intFsq = c_r;
        if (r == 0.0) {
          omegac = a;
        } else {
          fc = c_r;
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
                  delta = 1.0 - s;
                } else {
                  delta = r / fc;
                  b_r = intFsq / fc;
                  r = s * (2.0 * m * delta * (delta - b_r) - (omegac - a) * (b_r
                            - 1.0));
                  delta = (delta - 1.0) * (b_r - 1.0) * (s - 1.0);
                }

                if (r > 0.0) {
                  delta = -delta;
                } else {
                  r = -r;
                }

                if ((2.0 * r < 3.0 * m * delta - std::abs(toler * delta)) && (r <
                     std::abs(0.5 * q_ok * delta))) {
                  q_ok = err_ok;
                  err_ok = r / delta;
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

              intFsq = c_r - 0.0050536085896138528 * rt_powd_snf(omegac, 20.0) *
                std::exp(-rt_powd_snf(omegac, 3.0));
            }
          }
        }
      }
    }

    c_r = omegac / 3.1415926535897931;
    if (tol < c_r * rt_powd_snf(2.0, 1.0 / fOctave)) {
      tol = c_r * rt_powd_snf(2.0, 1.0 / fOctave);
    }

    toler = tol / c_r;
    if (toler == 0.0) {
      toler = rtMinusInf;
    } else if (toler < 0.0) {
      toler = rtNaN;
    } else if ((!std::isinf(toler)) && (!std::isnan(toler))) {
      toler = std::frexp(toler, &c_eint);
      if (toler == 0.5) {
        toler = static_cast<real_T>(c_eint) - 1.0;
      } else if ((c_eint == 1) && (toler < 0.75)) {
        toler = std::log(2.0 * toler) / 0.69314718055994529;
      } else {
        toler = std::log(toler) / 0.69314718055994529 + static_cast<real_T>
          (c_eint);
      }
    }

    emxInit_real_T(&q_y, 2, &dc_emlrtRTEI, true);
    r = std::fmax(toler, 1.0 / fOctave) * fOctave;
    if (std::isnan(r)) {
      k = q_y->size[0] * q_y->size[1];
      q_y->size[0] = 1;
      q_y->size[1] = 1;
      emxEnsureCapacity_real_T(q_y, k, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(q_y, &g_gpu_y);
      q_y->data[0] = rtNaN;
      b_y_dirtyOnCpu = true;
    } else if (r < 0.0) {
      q_y->size[0] = 1;
      q_y->size[1] = 0;
    } else {
      k = q_y->size[0] * q_y->size[1];
      q_y->size[0] = 1;
      q_y->size[1] = static_cast<int32_T>(r) + 1;
      emxEnsureCapacity_real_T(q_y, k, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(q_y, &g_gpu_y);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
        static_cast<int32_T>(r) + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_cwtAvg_kernel92<<<grid, block>>>(r, g_gpu_y);
      }
    }

    emxInit_real_T(&r_y, 2, &gc_emlrtRTEI, true);
    k = r_y->size[0] * r_y->size[1];
    r_y->size[0] = 1;
    r_y->size[1] = q_y->size[1];
    emxEnsureCapacity_real_T(r_y, k, &i_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(r_y, &i_gpu_y);
    nrefine = q_y->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (b_y_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_y, q_y);
      }

      ecc_cwtAvg_kernel93<<<grid, block>>>(g_gpu_y, rt_powd_snf(2.0, 1.0 /
        fOctave), nrefine, i_gpu_y);
    }

    emxFree_real_T(&q_y);
    k = fb_Scales->size[0] * fb_Scales->size[1];
    fb_Scales->size[0] = 1;
    fb_Scales->size[1] = r_y->size[1];
    emxEnsureCapacity_real_T(fb_Scales, k, &m_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(fb_Scales, &gpu_fb_Scales);
    bcoef = r_y->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel94<<<grid, block>>>(i_gpu_y, c_r, bcoef, gpu_fb_Scales);
      fb_Scales_dirtyOnGpu = true;
    }

    emxFree_real_T(&r_y);
  }

  first_iteration = false;
  nrefine = 0;
  do {
    exitg1 = 0;
    if (nrefine + 1 < 6) {
      if (cv[static_cast<int32_T>(b_b[nrefine])] != cv[static_cast<int32_T>
          (cv2[nrefine])]) {
        exitg1 = 1;
      } else {
        nrefine++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  emxInit_real_T(&psidft, 2, &yb_emlrtRTEI, true);
  emxInit_real_T(&f, 2, &bc_emlrtRTEI, true);
  if (first_iteration) {
    emxInit_real_T(&somega, 2, &cc_emlrtRTEI, true);
    if (fb_Scales->size[1] == 1) {
      k = somega->size[0] * somega->size[1];
      somega->size[0] = 1;
      if (omega->size[1] == 1) {
        somega->size[1] = 1;
      } else {
        somega->size[1] = omega->size[1];
      }

      emxEnsureCapacity_real_T(somega, k, &q_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(somega, &gpu_somega);
      nrefine = (omega->size[1] != 1);
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
        somega->data[k] = fb_Scales->data[0] * omega->data[nrefine * k];
        somega_dirtyOnCpu = true;
      }
    } else {
      k = somega->size[0] * somega->size[1];
      somega->size[0] = fb_Scales->size[1];
      somega->size[1] = omega->size[1];
      emxEnsureCapacity_real_T(somega, k, &p_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(somega, &gpu_somega);
      eint = omega->size[1] - 1;
      k = fb_Scales->size[1] - 1;
      bcoef = somega->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((k + 1L) *
        (eint + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_cwtAvg_kernel126<<<grid, block>>>(gpu_omega, gpu_fb_Scales, k, eint,
          bcoef, gpu_somega);
        somega_dirtyOnGpu = true;
      }
    }

    nrefine = somega->size[0] * somega->size[1] - 1;
    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(somega->size[bcoef]);
      xSize_dirtyOnCpu = true;
    }

    emxInit_real_T(&absomega, 2, &fc_emlrtRTEI, true);
    k = absomega->size[0] * absomega->size[1];
    absomega->size[0] = static_cast<int32_T>(xSize[0]);
    absomega->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(absomega, k, &u_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(absomega, &gpu_absomega);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (somega_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, somega);
      }

      somega_dirtyOnCpu = false;
      ecc_cwtAvg_kernel127<<<grid, block>>>(gpu_somega, nrefine, gpu_absomega);
      absomega_dirtyOnGpu = true;
    }

    emxInit_real_T(&powscales, 2, &v_emlrtRTEI, true);
    k = powscales->size[0] * powscales->size[1];
    powscales->size[0] = absomega->size[0];
    powscales->size[1] = absomega->size[1];
    emxEnsureCapacity_real_T(powscales, k, &v_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(powscales, &gpu_powscales);
    bcoef = absomega->size[0] * absomega->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel128<<<grid, block>>>(gpu_absomega, bcoef, gpu_powscales);
      powscales_dirtyOnGpu = true;
    }

    nrefine = absomega->size[0] * absomega->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel129<<<grid, block>>>(nrefine, gpu_absomega);
      absomega_dirtyOnGpu = true;
    }

    emxInit_real_T(&s_x, 2, &x_emlrtRTEI, true);
    if ((absomega->size[0] == powscales->size[0]) && (absomega->size[1] ==
         powscales->size[1])) {
      k = s_x->size[0] * s_x->size[1];
      s_x->size[0] = absomega->size[0];
      s_x->size[1] = absomega->size[1];
      emxEnsureCapacity_real_T(s_x, k, &x_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(s_x, &s_gpu_x);
      bcoef = absomega->size[0] * absomega->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_cwtAvg_kernel130<<<grid, block>>>(gpu_powscales, gpu_absomega, bcoef,
          s_gpu_x);
        j_x_dirtyOnGpu = true;
      }
    } else {
      if (absomega_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(absomega, &gpu_absomega);
      }

      if (powscales_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(powscales, &gpu_powscales);
      }

      b_binary_expand_op(s_x, absomega, powscales);
      j_x_dirtyOnCpu = true;
    }

    emxFree_real_T(&powscales);
    emxFree_real_T(&absomega);
    nrefine = s_x->size[0] * s_x->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (j_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&s_gpu_x, s_x);
      }

      ecc_cwtAvg_kernel131<<<grid, block>>>(nrefine, s_gpu_x);
      j_x_dirtyOnCpu = false;
      j_x_dirtyOnGpu = true;
    }

    if ((s_x->size[0] == somega->size[0]) && (s_x->size[1] == somega->size[1]))
    {
      k = psidft->size[0] * psidft->size[1];
      psidft->size[0] = s_x->size[0];
      psidft->size[1] = s_x->size[1];
      emxEnsureCapacity_real_T(psidft, k, &ab_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(psidft, &gpu_psidft);
      k = s_x->size[0] * s_x->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (somega_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, somega);
        }

        if (j_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&s_gpu_x, s_x);
        }

        ecc_cwtAvg_kernel132<<<grid, block>>>(gpu_somega, s_gpu_x, k, gpu_psidft);
      }
    } else {
      if (j_x_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(s_x, &s_gpu_x);
      }

      if (somega_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(somega, &gpu_somega);
      }

      binary_expand_op(psidft, s_x, somega);
      psidft_dirtyOnCpu = true;
    }

    emxFree_real_T(&s_x);
    emxFree_real_T(&somega);
    k = f->size[0] * f->size[1];
    f->size[0] = 1;
    f->size[1] = fb_Scales->size[1];
    emxEnsureCapacity_real_T(f, k, &bb_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(f, &gpu_f);
    k = fb_Scales->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel133<<<grid, block>>>(gpu_fb_Scales, k, gpu_f);
    }
  } else {
    k = psidft->size[0] * psidft->size[1];
    psidft->size[0] = fb_Scales->size[1];
    psidft->size[1] = omega->size[1];
    emxEnsureCapacity_real_T(psidft, k, &o_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(psidft, &gpu_psidft);
    k = fb_Scales->size[1] * omega->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel124<<<grid, block>>>(k, gpu_psidft);
    }

    k = f->size[0] * f->size[1];
    f->size[0] = 1;
    f->size[1] = fb_Scales->size[1];
    emxEnsureCapacity_real_T(f, k, &s_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(f, &gpu_f);
    k = fb_Scales->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel125<<<grid, block>>>(gpu_fb_Scales, k, gpu_f);
    }
  }

  emxFree_real_T(&omega);
  k = f->size[0] * f->size[1];
  f->size[0] = 1;
  emxEnsureCapacity_real_T(f, k, &t_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(f, &gpu_f);
  k = f->size[1];
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) + 1L),
    &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    ecc_cwtAvg_kernel134<<<grid, block>>>(fs, k, gpu_f);
  }

  // 'ecc_cwtAvg:27' freqs = fb.centerFrequencies';
  lidx = f->size[1];
  k = freqs->size[0] * freqs->size[1];
  freqs->size[0] = 1;
  freqs->size[1] = f->size[1];
  emxEnsureCapacity_real_T(freqs, k, &w_emlrtRTEI);
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((lidx - 1) +
    1L), &grid, &block, 1024U, 65535U);
  if (validLaunchParams) {
    gpuEmxMemcpyCpuToGpu_real_T(&gpu_freqs, freqs);
    ecc_cwtAvg_kernel135<<<grid, block>>>(gpu_f, lidx, gpu_freqs);
    freqs_dirtyOnGpu = true;
  }

  emxFree_real_T(&f);

  //  Trigger CUDA kernel generation
  // 'ecc_cwtAvg:30' coder.gpu.kernelfun;
  //  Preallocate
  // 'ecc_cwtAvg:33' ii = 1:nFrames;
  emxInit_uint32_T(&ii, 2, &y_emlrtRTEI, true);
  if (b_x->size[0] < 1) {
    ii->size[0] = 1;
    ii->size[1] = 0;
  } else {
    N = static_cast<uint32_T>(b_x->size[0]);
    k = ii->size[0] * ii->size[1];
    ii->size[0] = 1;
    ii->size[1] = b_x->size[0];
    emxEnsureCapacity_uint32_T(ii, k, &y_emlrtRTEI);
    gpuEmxEnsureCapacity_uint32_T(ii, &gpu_ii);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
      static_cast<int32_T>(N) - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel136<<<grid, block>>>(N, gpu_ii);
      ii_dirtyOnGpu = true;
    }
  }

  // 'ecc_cwtAvg:34' xx = coder.nullcopy(zeros(size(x),'like',x));
  for (bcoef = 0; bcoef < 2; bcoef++) {
    xSize[bcoef] = static_cast<uint32_T>(b_x->size[bcoef]);
    xSize_dirtyOnCpu = true;
  }

  k = xx->size[0] * xx->size[1];
  xx->size[0] = static_cast<int32_T>(xSize[0]);
  xx->size[1] = static_cast<int32_T>(xSize[1]);
  emxEnsureCapacity_real32_T(xx, k, &cb_emlrtRTEI);

  //  Preallocate output
  //  CWT average power (L1-norm & variance-norm usng weighted integrals)
  // 'ecc_cwtAvg:38' for ch = 1:nChs
  b_eint = b_x->size[1];
  if (b_x->size[1] - 1 >= 0) {
    n = ii->size[1] - 1;
    if (fb_Scales->size[1] < 1) {
      i45 = 0;
    } else {
      i45 = fb_Scales->size[1];
    }
  }

  emxInit_int32_T(&iv9, 1, &yb_emlrtRTEI, true);
  emxInit_real32_T(&t_x, 1, &eb_emlrtRTEI, true);
  emxInit_real32_T(&Scales, 2, &fb_emlrtRTEI, true);
  emxInit_real32_T(&psihat, 2, &gb_emlrtRTEI, true);
  emxInit_real32_T(&xv, 2, &hb_emlrtRTEI, true);
  emxInit_creal32_T(&xposdft, 2, &ib_emlrtRTEI, true);
  emxInit_real32_T(&u_x, 2, &kb_emlrtRTEI, true);
  emxInit_creal32_T(&cfsposdft, 2, &lc_emlrtRTEI, true);
  emxInit_creal32_T(&cfspos, 2, &mb_emlrtRTEI, true);
  emxInit_creal32_T(&cfs, 2, &nb_emlrtRTEI, true);
  emxInit_real32_T(&bb_y, 2, &mc_emlrtRTEI, true);
  emxInit_real32_T(&abscfssq, 2, &nc_emlrtRTEI, true);
  emxInit_real32_T(&f_a, 2, &pb_emlrtRTEI, true);
  emxInit_real_T(&v_x, 2, &f_emlrtRTEI, true);
  emxInit_uint32_T(&cb_y, 2, &oc_emlrtRTEI, true);
  emxInit_real32_T(&z, 1, &pc_emlrtRTEI, true);
  emxInit_real_T(&w_x, 2, &ac_emlrtRTEI, true);
  emxInit_real_T(&b_c, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&i_xt, 2, &ec_emlrtRTEI, true);
  emxInit_real32_T(&c_c, 1, &tb_emlrtRTEI, true);
  emxInit_real32_T(&db_y, 2, &qc_emlrtRTEI, true);
  emxInit_real_T(&eb_y, 2, &rc_emlrtRTEI, true);
  emxInit_real_T(&g_a, 2, &rb_emlrtRTEI, true);
  emxInit_real_T(&i_fx, 2, &yb_emlrtRTEI, true);
  emxInit_real_T(&fb_y, 2, &sc_emlrtRTEI, true);
  emxInit_real32_T(&abswt2, 2, &tc_emlrtRTEI, true);
  emxInit_real_T(&gb_y, 2, &uc_emlrtRTEI, true);
  emxInit_real_T(&hb_y, 2, &vc_emlrtRTEI, true);
  emxInit_real32_T(&abswt2S, 2, &wc_emlrtRTEI, true);
  emxInit_real32_T(&savgpTMP, 2, &xc_emlrtRTEI, true);
  emxInit_real32_T(&d_c, 1, &tb_emlrtRTEI, true);
  for (fb_CutOff = 0; fb_CutOff < b_eint; fb_CutOff++) {
    real32_T normfac;

    // 'ecc_cwtAvg:39' xx(ii,ch) = scaleSpectrum(fb,x(ii,ch),SpectrumType="density");
    k = iv9->size[0];
    iv9->size[0] = ii->size[1];
    emxEnsureCapacity_int32_T(iv9, k, &db_emlrtRTEI);
    gpuEmxEnsureCapacity_int32_T(iv9, &gpu_iv9);
    k = t_x->size[0];
    t_x->size[0] = ii->size[1];
    emxEnsureCapacity_real32_T(t_x, k, &eb_emlrtRTEI);
    if (!k_x_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real32_T(t_x, &t_gpu_x);
    }

    bcoef = ii->size[1] - 1;
    k = b_x->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_x, b_x);
      }

      x_dirtyOnCpu = false;
      if (k_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&t_gpu_x, t_x);
      }

      ecc_cwtAvg_kernel137<<<grid, block>>>(fb_CutOff, b_gpu_x, gpu_ii, bcoef, k,
        t_gpu_x, gpu_iv9);
      k_x_dirtyOnCpu = false;
      k_x_dirtyOnGpu = true;
    }

    k = Scales->size[0] * Scales->size[1];
    Scales->size[0] = 1;
    Scales->size[1] = fb_Scales->size[1];
    emxEnsureCapacity_real32_T(Scales, k, &fb_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(Scales, &gpu_Scales);
    k = fb_Scales->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel138<<<grid, block>>>(gpu_fb_Scales, k, gpu_Scales);
      Scales_dirtyOnGpu = true;
    }

    if (ii->size[1] == 1) {
      if (x_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(b_x, &b_gpu_x);
      }

      x_dirtyOnGpu = false;
      if (ii_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_uint32_T(ii, &gpu_ii);
      }

      ii_dirtyOnGpu = false;
      xbar = b_x->data[(static_cast<int32_T>(ii->data[0]) + b_x->size[0] *
                        fb_CutOff) - 1];
      if ((!std::isinf(xbar)) && (!std::isnan(xbar))) {
        normfac = 0.0F;
      } else {
        normfac = rtNaNF;
      }
    } else {
      if (x_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(b_x, &b_gpu_x);
      }

      x_dirtyOnGpu = false;
      if (ii_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_uint32_T(ii, &gpu_ii);
      }

      ii_dirtyOnGpu = false;
      xbar = b_x->data[(static_cast<int32_T>(ii->data[0]) + b_x->size[0] *
                        fb_CutOff) - 1];
      for (k = 0; k < n; k++) {
        xbar += b_x->data[(static_cast<int32_T>(ii->data[k + 1]) + b_x->size[0] *
                           fb_CutOff) - 1];
      }

      xbar /= static_cast<real32_T>(ii->size[1]);
      varsig = 0.0F;
      for (k = 0; k <= n; k++) {
        t = b_x->data[(static_cast<int32_T>(ii->data[k]) + b_x->size[0] *
                       fb_CutOff) - 1] - xbar;
        varsig += t * t;
      }

      normfac = varsig / static_cast<real32_T>(ii->size[1]);
    }

    k = psihat->size[0] * psihat->size[1];
    psihat->size[0] = psidft->size[0];
    psihat->size[1] = psidft->size[1];
    emxEnsureCapacity_real32_T(psihat, k, &gb_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(psihat, &gpu_psihat);
    bcoef = psidft->size[0] * psidft->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (psidft_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_psidft, psidft);
      }

      psidft_dirtyOnCpu = false;
      ecc_cwtAvg_kernel139<<<grid, block>>>(gpu_psidft, bcoef, gpu_psihat);
    }

    k = xv->size[0] * xv->size[1];
    xv->size[0] = 1;
    xv->size[1] = t_x->size[0];
    emxEnsureCapacity_real32_T(xv, k, &hb_emlrtRTEI);
    if (!xv_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real32_T(xv, &gpu_xv);
    }

    k = t_x->size[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (k_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&t_gpu_x, t_x);
      }

      k_x_dirtyOnCpu = false;
      if (xv_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, xv);
      }

      ecc_cwtAvg_kernel140<<<grid, block>>>(t_gpu_x, k, gpu_xv);
      xv_dirtyOnCpu = false;
      xv_dirtyOnGpu = true;
    }

    if (fb_SignalPad > 0) {
      acoef = ii->size[1] - fb_SignalPad;
      if (acoef + 1 > ii->size[1]) {
        nsubs = 0;
        ix = 1;
        acoef = -1;
      } else {
        nsubs = ii->size[1] - 1;
        ix = -1;
      }

      k = u_x->size[0] * u_x->size[1];
      u_x->size[0] = 1;
      u_x->size[1] = fb_SignalPad;
      emxEnsureCapacity_real32_T(u_x, k, &kb_emlrtRTEI);
      if (!l_x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(u_x, &u_gpu_x);
      }

      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        ((fb_SignalPad - 1) + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (k_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&t_gpu_x, t_x);
        }

        k_x_dirtyOnCpu = false;
        if (l_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&u_gpu_x, u_x);
        }

        ecc_cwtAvg_kernel141<<<grid, block>>>(t_gpu_x, fb_SignalPad, u_gpu_x);
        l_x_dirtyOnCpu = false;
        l_x_dirtyOnGpu = true;
      }

      lidx = fb_SignalPad >> 1;
      for (eint = 0; eint < lidx; eint++) {
        nrefine = (fb_SignalPad - eint) - 1;
        if (l_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(u_x, &u_gpu_x);
        }

        xbar = u_x->data[eint];
        u_x->data[eint] = u_x->data[nrefine];
        u_x->data[nrefine] = xbar;
        l_x_dirtyOnGpu = false;
        l_x_dirtyOnCpu = true;
      }

      k = xv->size[0] * xv->size[1];
      xv->size[0] = 1;
      xv->size[1] = ((t_x->size[0] + u_x->size[1]) + div_s32(acoef - nsubs, ix))
        + 1;
      emxEnsureCapacity_real32_T(xv, k, &lb_emlrtRTEI);
      if (!xv_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(xv, &gpu_xv);
      }

      eint = u_x->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(eint + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (l_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&u_gpu_x, u_x);
        }

        l_x_dirtyOnCpu = false;
        if (xv_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, xv);
        }

        ecc_cwtAvg_kernel142<<<grid, block>>>(u_gpu_x, eint, gpu_xv);
        xv_dirtyOnCpu = false;
        xv_dirtyOnGpu = true;
      }

      eint = t_x->size[0];
      for (k = 0; k < eint; k++) {
        if (xv_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(xv, &gpu_xv);
        }

        if (k_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(t_x, &t_gpu_x);
        }

        k_x_dirtyOnGpu = false;
        xv->data[k + u_x->size[1]] = t_x->data[k];
        l_x_dirtyOnGpu = false;
        l_x_dirtyOnCpu = true;
        xv_dirtyOnGpu = false;
        xv_dirtyOnCpu = true;
      }

      eint = div_s32(acoef - nsubs, ix);
      for (k = 0; k <= eint; k++) {
        if (xv_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(xv, &gpu_xv);
        }

        if (k_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(t_x, &t_gpu_x);
        }

        xv->data[(k + t_x->size[0]) + u_x->size[1]] = t_x->data[nsubs + ix * k];
        l_x_dirtyOnGpu = false;
        l_x_dirtyOnCpu = true;
        k_x_dirtyOnGpu = false;
        k_x_dirtyOnCpu = true;
        xv_dirtyOnGpu = false;
        xv_dirtyOnCpu = true;
      }
    }

    if (xv->size[1] - (static_cast<int32_T>(static_cast<uint32_T>(xv->size[1]) >>
          1) << 1) == 1) {
      cufftHandle fftPlanHandle;
      k = xposdft->size[0] * xposdft->size[1];
      xposdft->size[0] = 1;
      xposdft->size[1] = xv->size[1];
      emxEnsureCapacity_creal32_T(xposdft, k, &ib_emlrtRTEI);
      if (!xposdft_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal32_T(xposdft, &gpu_xposdft);
      }

      bcoef = xv->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (xv_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, xv);
        }

        xv_dirtyOnCpu = false;
        if (xposdft_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_xposdft, xposdft);
        }

        ecc_cwtAvg_kernel143<<<grid, block>>>(gpu_xv, bcoef, gpu_xposdft);
        xposdft_dirtyOnCpu = false;
      }

      lidx = xposdft->size[1];
      fftPlanHandle = acquireCUFFTPlan(1, &lidx, &lidx, 1, 1, CUFFT_C2C, 1);
      if (xposdft_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_xposdft, xposdft);
      }

      cufftExecC2C(fftPlanHandle, (cufftComplex *)&gpu_xposdft.data[0],
                   (cufftComplex *)&gpu_xposdft.data[0], CUFFT_FORWARD);
      xposdft_dirtyOnCpu = false;
    } else {
      cufftHandle b_fftPlanHandle;
      lidx = xv->size[1];
      for (bcoef = 0; bcoef < 2; bcoef++) {
        xSize[bcoef] = static_cast<uint32_T>(xv->size[bcoef]);
        xSize_dirtyOnCpu = true;
      }

      k = xposdft->size[0] * xposdft->size[1];
      xposdft->size[0] = 1;
      xposdft->size[1] = static_cast<int32_T>(xSize[1]);
      emxEnsureCapacity_creal32_T(xposdft, k, &jb_emlrtRTEI);
      if (!xposdft_dirtyOnCpu) {
        gpuEmxEnsureCapacity_creal32_T(xposdft, &gpu_xposdft);
      }

      b_fftPlanHandle = acquireCUFFTPlan(1, &lidx, &lidx, 1, 1, CUFFT_R2C, 1);
      if (xv_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, xv);
      }

      xv_dirtyOnCpu = false;
      if (xposdft_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_xposdft, xposdft);
      }

      cufftExecR2C(b_fftPlanHandle, (cufftReal *)&gpu_xv.data[0], (cufftComplex *)
                   &gpu_xposdft.data[0]);
      xposdft_dirtyOnCpu = false;
      b_dirtyOnGpu = true;
      lidx = static_cast<int32_T>(static_cast<real_T>(static_cast<int32_T>
        (xSize[1]) + 1) / 2.0);
      for (acoef = 0; acoef <= lidx - 2; acoef++) {
        if (b_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_creal32_T(xposdft, &gpu_xposdft);
        }

        xposdft->data[(static_cast<int32_T>(xSize[1]) - acoef) - 1].re =
          xposdft->data[acoef + 1].re;
        xposdft->data[(static_cast<int32_T>(xSize[1]) - acoef) - 1].im =
          -xposdft->data[acoef + 1].im;
        b_dirtyOnGpu = false;
        xposdft_dirtyOnCpu = true;
      }
    }

    k = cfsposdft->size[0] * cfsposdft->size[1];
    cfsposdft->size[0] = psihat->size[0];
    lidx = psihat->size[1];
    nrefine = xposdft->size[1];
    if (lidx <= nrefine) {
      nrefine = lidx;
    }

    if (psihat->size[1] == 1) {
      cfsposdft->size[1] = xposdft->size[1];
    } else if (xposdft->size[1] == 1) {
      cfsposdft->size[1] = psihat->size[1];
    } else if (xposdft->size[1] == psihat->size[1]) {
      cfsposdft->size[1] = xposdft->size[1];
    } else {
      cfsposdft->size[1] = nrefine;
    }

    emxEnsureCapacity_creal32_T(cfsposdft, k, &q_emlrtRTEI);
    gpuEmxEnsureCapacity_creal32_T(cfsposdft, &gpu_cfsposdft);
    if ((cfsposdft->size[0] != 0) && (cfsposdft->size[1] != 0)) {
      acoef = (xposdft->size[1] != 1);
      nrefine = (psihat->size[1] != 1);
      lidx = cfsposdft->size[1];
      ix = cfsposdft->size[0] - 1;
      bcoef = cfsposdft->size[0];
      k = psihat->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ix + 1L) *
        ((lidx - 1) + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (xposdft_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_xposdft, xposdft);
        }

        xposdft_dirtyOnCpu = false;
        ecc_cwtAvg_kernel144<<<grid, block>>>(gpu_xposdft, gpu_psihat, nrefine,
          acoef, ix, lidx, k, bcoef, gpu_cfsposdft);
      }
    }

    if ((cfsposdft->size[0] == 0) || (cfsposdft->size[1] == 0)) {
      for (bcoef = 0; bcoef < 2; bcoef++) {
        xSize[bcoef] = static_cast<uint32_T>(cfsposdft->size[bcoef]);
        xSize_dirtyOnCpu = true;
      }

      bcoef = cfsposdft->size[1];
      if (xSize_dirtyOnCpu) {
        cudaMemcpy(*gpu_xSize, xSize, 8UL, cudaMemcpyHostToDevice);
      }

      ecc_cwtAvg_kernel147<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(bcoef,
        *gpu_xSize);
      xSize_dirtyOnCpu = false;
      k = cfspos->size[0] * cfspos->size[1];
      cudaMemcpy(xSize, *gpu_xSize, 8UL, cudaMemcpyDeviceToHost);
      cfspos->size[0] = static_cast<int32_T>(xSize[0]);
      cfspos->size[1] = cfsposdft->size[1];
      emxEnsureCapacity_creal32_T(cfspos, k, &mb_emlrtRTEI);
      gpuEmxEnsureCapacity_creal32_T(cfspos, &gpu_cfspos);
      bcoef = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) -
        1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_cwtAvg_kernel148<<<grid, block>>>(bcoef, gpu_cfspos);
      }
    } else {
      cufftHandle c_fftPlanHandle;
      lidx = cfsposdft->size[1];
      c_fftPlanHandle = acquireCUFFTPlan(1, &lidx, &lidx, cfsposdft->size[0], 1,
        CUFFT_C2C, cfsposdft->size[0]);
      cufftExecC2C(c_fftPlanHandle, (cufftComplex *)&gpu_cfsposdft.data[0],
                   (cufftComplex *)&gpu_cfsposdft.data[0], CUFFT_INVERSE);
      k = cfspos->size[0] * cfspos->size[1];
      cfspos->size[0] = cfsposdft->size[0];
      cfspos->size[1] = cfsposdft->size[1];
      emxEnsureCapacity_creal32_T(cfspos, k, &mb_emlrtRTEI);
      gpuEmxEnsureCapacity_creal32_T(cfspos, &gpu_cfspos);
      bcoef = cfsposdft->size[1];
      ecc_cwtAvg_kernel145<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(bcoef,
        b_gpu_cfsposdft);
      ix = cfsposdft->size[0] * cfsposdft->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_cwtAvg_kernel146<<<grid, block>>>(b_gpu_cfsposdft, gpu_cfsposdft, ix,
          gpu_cfspos);
      }
    }

    k = cfs->size[0] * cfs->size[1];
    cfs->size[0] = cfspos->size[0];
    cfs->size[1] = cfspos->size[1];
    emxEnsureCapacity_creal32_T(cfs, k, &nb_emlrtRTEI);
    gpuEmxEnsureCapacity_creal32_T(cfs, &gpu_cfs);
    bcoef = cfspos->size[0] * cfspos->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(bcoef + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel149<<<grid, block>>>(gpu_cfspos, bcoef, gpu_cfs);
    }

    if (fb_SignalPad > 0) {
      N = static_cast<uint32_T>(b_x->size[0]) + static_cast<uint32_T>
        (fb_SignalPad);
      k = cfs->size[0] * cfs->size[1];
      cfs->size[0] = cfspos->size[0];
      cfs->size[1] = static_cast<int32_T>(N) - fb_SignalPad;
      emxEnsureCapacity_creal32_T(cfs, k, &ob_emlrtRTEI);
      gpuEmxEnsureCapacity_creal32_T(cfs, &gpu_cfs);
      bcoef = cfspos->size[0] - 1;
      k = cfs->size[0];
      ix = cfspos->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((bcoef +
        1L) * (((static_cast<int32_T>(N) - fb_SignalPad) - 1) + 1L)), &grid,
        &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_cwtAvg_kernel150<<<grid, block>>>(gpu_cfspos, bcoef,
          static_cast<uint32_T>(fb_SignalPad) + 1U, N, k, ix, gpu_cfs);
      }
    }

    first_iteration = false;
    nrefine = 0;
    do {
      exitg1 = 0;
      if (nrefine + 1 < 6) {
        if (cv[static_cast<int32_T>(b_b[nrefine])] != cv[static_cast<int32_T>
            (cv3[nrefine])]) {
          exitg1 = 1;
        } else {
          nrefine++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      ecc_cwtAvg_kernel152<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_wav,
        'm', 'o', 'r', 's', 'e');
      ecc_cwtAvg_kernel153<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_wav,
        *gpu_wavname);
      wavname_dirtyOnGpu = true;
    } else {
      ecc_cwtAvg_kernel151<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_wav);
    }

    first_iteration = false;
    nrefine = 0;
    do {
      exitg1 = 0;
      if (nrefine + 1 < 6) {
        if (wavname_dirtyOnGpu) {
          cudaMemcpy(wavname, *gpu_wavname, 5UL, cudaMemcpyDeviceToHost);
        }

        wavname_dirtyOnGpu = false;
        if (cv[static_cast<int32_T>(wavname[nrefine])] != cv[static_cast<int32_T>
            (cv3[nrefine])]) {
          exitg1 = 1;
        } else {
          nrefine++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      r = 0.0057083835261;
      for (acoef = 0; acoef < 6; acoef++) {
        r = r / 177.7777777777778 + c[acoef];
      }

      r = (r / 13.333333333333334 - 13.333333333333334) + 0.91893853320467278;
      r += 33.241761956554775;
      intFsq = 8.2480004101996545E-10 * std::exp(r);
    } else {
      if (interval_dirtyOnCpu) {
        cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
      }

      ecc_cwtAvg_kernel154<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
        (*gpu_interval);
      ecc_cwtAvg_kernel155<<<dim3(2U, 1U, 1U), dim3(512U, 1U, 1U)>>>
        (*gpu_interval);
      interval_dirtyOnCpu = false;
      intFsq = 0.0;
      nrefine = 1;
      cudaMemcpy(interval, *gpu_interval, 5200UL, cudaMemcpyDeviceToHost);
      pathlen = static_cast<int32_T>(interval[1]) - static_cast<int32_T>
        (interval[0]);
      if (pathlen > 0) {
        r = 10.0 / static_cast<real_T>(pathlen);
        n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::ceil(std::abs
          (interval[1] - interval[0]) * r)) - 1);
        nsubs = static_cast<int32_T>(std::ceil(std::abs(interval[1] - interval[0])
          * r));
        if (nsubs + 1 > 2) {
          lidx = n_idx_0;
          interval[nsubs] = interval[1];
          interval_dirtyOnCpu = true;
          delta = (interval[1] - interval[0]) / (static_cast<real_T>(n_idx_0) +
            1.0);
          for (nrefine = 0; nrefine < lidx; nrefine++) {
            interval[(nsubs - nrefine) - 1] = interval[0] + static_cast<real_T>
              (n_idx_0 - nrefine) * delta;
          }
        }

        nrefine = nsubs;
      } else {
        nsubs = 1;
      }

      lidx = 0;
      for (acoef = 0; acoef < nrefine; acoef++) {
        if (std::abs(interval[acoef + 1] - interval[lidx]) > 0.0) {
          lidx++;
          interval[lidx] = interval[acoef + 1];
          interval_dirtyOnCpu = true;
        } else {
          nsubs--;
        }
      }

      if (nsubs + 1 < 2) {
        if (interval_dirtyOnCpu) {
          cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
        }

        ecc_cwtAvg_kernel156<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nrefine,
          *gpu_interval);
        interval_dirtyOnCpu = false;
        nsubs = 1;
      }

      if (pathlen <= 0) {
        intFsq = 0.47999999999999976;
      } else {
        nsubs--;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nsubs +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (interval_dirtyOnCpu) {
            cudaMemcpy(*gpu_interval, interval, 5200UL, cudaMemcpyHostToDevice);
          }

          interval_dirtyOnCpu = false;
          if (subs_dirtyOnCpu) {
            cudaMemcpy(*gpu_subs, subs, 10384UL, cudaMemcpyHostToDevice);
          }

          ecc_cwtAvg_kernel157<<<grid, block>>>(*gpu_interval, nsubs, *gpu_subs);
          subs_dirtyOnCpu = false;
          subs_dirtyOnGpu = true;
        }

        q_ok = 0.0;
        err_ok = 0.0;
        first_iteration = true;
        do {
          exitg1 = 0;
          k = v_x->size[0] * v_x->size[1];
          v_x->size[0] = 1;
          v_x->size[1] = 15 * (nsubs + 1);
          emxEnsureCapacity_real_T(v_x, k, &f_emlrtRTEI);
          if (!m_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(v_x, &v_gpu_x);
          }

          ix = -1;
          for (k = 0; k <= nsubs; k++) {
            if (subs_dirtyOnGpu) {
              cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
            }

            fc = subs[k << 1];
            subs_dirtyOnGpu = false;
            c_r = subs[(k << 1) + 1];
            r = (fc + c_r) / 2.0;
            delta = (c_r - fc) / 2.0;
            for (nrefine = 0; nrefine < 15; nrefine++) {
              v_x->data[(ix + nrefine) + 1] = NODES[nrefine] * delta + r;
              m_x_dirtyOnCpu = true;
            }

            ix += 15;
          }

          k = w_x->size[0] * w_x->size[1];
          w_x->size[0] = 1;
          w_x->size[1] = v_x->size[1];
          emxEnsureCapacity_real_T(w_x, k, &g_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(w_x, &w_gpu_x);
          k = i_xt->size[0] * i_xt->size[1];
          i_xt->size[0] = 1;
          i_xt->size[1] = v_x->size[1];
          emxEnsureCapacity_real_T(i_xt, k, &h_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(i_xt, &i_gpu_xt);
          lidx = v_x->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (m_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&v_gpu_x, v_x);
            }

            m_x_dirtyOnCpu = false;
            ecc_cwtAvg_kernel158<<<grid, block>>>(v_gpu_x, lidx, i_gpu_xt,
              w_gpu_x);
            m_x_dirtyOnGpu = true;
            i_xt_dirtyOnGpu = true;
          }

          b_guard1 = false;
          if (!first_iteration) {
            if (m_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(w_x, &w_gpu_x);
            }

            m_x_dirtyOnGpu = false;
            r = std::abs(w_x->data[0]);
            k = 0;
            exitg2 = false;
            while ((!exitg2) && (k <= w_x->size[1] - 2)) {
              toler = r;
              r = std::abs(w_x->data[k + 1]);
              if (std::abs(w_x->data[k + 1] - w_x->data[k]) <=
                  2.2204460492503131E-14 * std::fmax(toler, r)) {
                first_iteration = true;
                exitg2 = true;
              } else {
                k++;
              }
            }

            if (first_iteration) {
              dv4_idx_1 = static_cast<int16_T>(v_x->size[1]);
              k = i_fx->size[0] * i_fx->size[1];
              i_fx->size[0] = 1;
              i_fx->size[1] = v_x->size[1];
              emxEnsureCapacity_real_T(i_fx, k, &k_emlrtRTEI);
              if (!i_fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(i_fx, &i_gpu_fx);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((dv4_idx_1 - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (i_fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_fx, i_fx);
                }

                ecc_cwtAvg_kernel166<<<grid, block>>>(dv4_idx_1, i_gpu_fx);
                i_fx_dirtyOnCpu = false;
                i_fx_dirtyOnGpu = true;
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
            k = g_a->size[0] * g_a->size[1];
            g_a->size[0] = 1;
            g_a->size[1] = w_x->size[1];
            emxEnsureCapacity_real_T(g_a, k, &rb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(g_a, &f_gpu_a);
            k = w_x->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel159<<<grid, block>>>(w_gpu_x, k, f_gpu_a);
            }

            k = eb_y->size[0] * eb_y->size[1];
            eb_y->size[0] = 1;
            eb_y->size[1] = g_a->size[1];
            emxEnsureCapacity_real_T(eb_y, k, &i_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(eb_y, &w_gpu_y);
            nrefine = g_a->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel160<<<grid, block>>>(f_gpu_a, nrefine, w_gpu_y);
            }

            k = fb_y->size[0] * fb_y->size[1];
            fb_y->size[0] = 1;
            fb_y->size[1] = eb_y->size[1];
            emxEnsureCapacity_real_T(fb_y, k, &n_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(fb_y, &x_gpu_y);
            bcoef = eb_y->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (bcoef + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel161<<<grid, block>>>(w_gpu_y, bcoef, x_gpu_y);
            }

            nrefine = fb_y->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel162<<<grid, block>>>(nrefine, x_gpu_y);
            }

            k = gb_y->size[0] * gb_y->size[1];
            gb_y->size[0] = 1;
            gb_y->size[1] = fb_y->size[1];
            emxEnsureCapacity_real_T(gb_y, k, &n_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(gb_y, &ab_gpu_y);
            bcoef = fb_y->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (bcoef + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel163<<<grid, block>>>(x_gpu_y, bcoef, ab_gpu_y);
            }

            nrefine = gb_y->size[1] - 1;
            k = hb_y->size[0] * hb_y->size[1];
            hb_y->size[0] = 1;
            hb_y->size[1] = gb_y->size[1];
            emxEnsureCapacity_real_T(hb_y, k, &u_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(hb_y, &bb_gpu_y);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (nrefine + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_cwtAvg_kernel164<<<grid, block>>>(ab_gpu_y, nrefine, bb_gpu_y);
              j_y_dirtyOnGpu = true;
            }

            if (hb_y->size[1] == w_x->size[1]) {
              k = i_fx->size[0] * i_fx->size[1];
              i_fx->size[0] = 1;
              i_fx->size[1] = hb_y->size[1];
              emxEnsureCapacity_real_T(i_fx, k, &r_emlrtRTEI);
              if (!i_fx_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(i_fx, &i_gpu_fx);
              }

              bcoef = hb_y->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (bcoef + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (i_fx_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_fx, i_fx);
                }

                ecc_cwtAvg_kernel165<<<grid, block>>>(i_gpu_xt, w_gpu_x,
                  bb_gpu_y, bcoef, i_gpu_fx);
                i_fx_dirtyOnCpu = false;
                i_fx_dirtyOnGpu = true;
              }
            } else {
              if (i_fx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_fx, &i_gpu_fx);
              }

              if (j_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(hb_y, &bb_gpu_y);
              }

              j_y_dirtyOnGpu = false;
              if (m_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(w_x, &w_gpu_x);
              }

              m_x_dirtyOnGpu = false;
              if (i_xt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_xt, &i_gpu_xt);
              }

              i_xt_dirtyOnGpu = false;
              binary_expand_op(i_fx, hb_y, w_x, i_xt);
              i_fx_dirtyOnGpu = false;
              i_fx_dirtyOnCpu = true;
            }

            r = 0.0;
            ix = -1;
            for (k = 0; k <= nsubs; k++) {
              fc = 0.0;
              c_r = 0.0;
              for (nrefine = 0; nrefine < 15; nrefine++) {
                if (i_fx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(i_fx, &i_gpu_fx);
                }

                fc += dv6[nrefine] * i_fx->data[(ix + nrefine) + 1];
                i_fx_dirtyOnGpu = false;
                c_r += dv7[nrefine] * i_fx->data[(ix + nrefine) + 1];
              }

              ix += 15;
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              delta = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
              fc *= delta;
              qsub[k] = fc;
              r += fc;
              errsub[k] = c_r * delta;
            }

            intFsq = r + q_ok;
            tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
            r = 2.0 * tol / static_cast<real_T>(pathlen);
            c_r = 0.0;
            nrefine = 0;
            for (k = 0; k <= nsubs; k++) {
              fc = errsub[k];
              delta = std::abs(fc);
              if (subs_dirtyOnGpu) {
                cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
              }

              subs_dirtyOnGpu = false;
              if (delta <= r * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                err_ok += fc;
                q_ok += qsub[k];
              } else {
                c_r += delta;
                nrefine++;
                subs[(nrefine - 1) << 1] = subs[k << 1];
                subs[((nrefine - 1) << 1) + 1] = subs[(k << 1) + 1];
                subs_dirtyOnCpu = true;
              }
            }

            r = std::abs(err_ok) + c_r;
            if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::isinf
                  (r)) && (!std::isnan(r))) && (nrefine != 0) && (!(r <= tol)))
            {
              nsubs = (nrefine << 1) - 1;
              if (nsubs + 1 > 650) {
                exitg1 = 1;
              } else {
                for (k = 0; k < nrefine; k++) {
                  acoef = nrefine - k;
                  if (subs_dirtyOnGpu) {
                    cudaMemcpy(subs, *gpu_subs, 10384UL, cudaMemcpyDeviceToHost);
                  }

                  subs[(((acoef << 1) - 1) << 1) + 1] = subs[((acoef - 1) << 1)
                    + 1];
                  subs[((acoef << 1) - 1) << 1] = (subs[(acoef - 1) << 1] +
                    subs[((acoef - 1) << 1) + 1]) / 2.0;
                  subs[(((acoef << 1) - 2) << 1) + 1] = subs[((acoef << 1) - 1) <<
                    1];
                  subs[((acoef << 1) - 2) << 1] = subs[(acoef - 1) << 1];
                  subs_dirtyOnGpu = false;
                  subs_dirtyOnCpu = true;
                }
              }
            } else {
              exitg1 = 1;
            }
          }
        } while (exitg1 == 0);
      }
    }

    nrefine = cfs->size[0] * cfs->size[1] - 1;
    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(cfs->size[bcoef]);
      xSize_dirtyOnCpu = true;
    }

    k = bb_y->size[0] * bb_y->size[1];
    bb_y->size[0] = static_cast<int32_T>(xSize[0]);
    bb_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(bb_y, k, &u_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(bb_y, &u_gpu_y);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel167<<<grid, block>>>(gpu_cfs, nrefine, u_gpu_y);
    }

    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(bb_y->size[bcoef]);
      xSize_dirtyOnCpu = true;
    }

    k = abscfssq->size[0] * abscfssq->size[1];
    abscfssq->size[0] = static_cast<int32_T>(xSize[0]);
    abscfssq->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(abscfssq, k, &i_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(abscfssq, &gpu_abscfssq);
    nrefine = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) -
      1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel168<<<grid, block>>>(u_gpu_y, nrefine, gpu_abscfssq);
      abscfssq_dirtyOnGpu = true;
    }

    k = f_a->size[0] * f_a->size[1];
    f_a->size[0] = abscfssq->size[0];
    f_a->size[1] = abscfssq->size[1];
    emxEnsureCapacity_real32_T(f_a, k, &pb_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(f_a, &e_gpu_a);
    ix = abscfssq->size[0] * abscfssq->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel169<<<grid, block>>>(gpu_abscfssq, ix, e_gpu_a);
    }

    lidx = Scales->size[1];
    nrefine = abscfssq->size[0];
    if (lidx <= nrefine) {
      nrefine = lidx;
    }

    if (Scales->size[1] == 1) {
      k = abscfssq->size[0];
    } else if (abscfssq->size[0] == 1) {
      k = Scales->size[1];
    } else if (abscfssq->size[0] == Scales->size[1]) {
      k = abscfssq->size[0];
    } else {
      k = nrefine;
    }

    nrefine = abscfssq->size[1];
    lidx = abscfssq->size[0] * abscfssq->size[1];
    abscfssq->size[0] = k;
    abscfssq->size[1] = nrefine;
    emxEnsureCapacity_real32_T(abscfssq, lidx, &q_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(abscfssq, &gpu_abscfssq);
    if ((k != 0) && (nrefine != 0)) {
      acoef = (f_a->size[1] != 1);
      ix = abscfssq->size[0] - 1;
      nsubs = Scales->size[1];
      bcoef = abscfssq->size[0];
      k = f_a->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ix + 1L) *
        ((nrefine - 1) + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_cwtAvg_kernel170<<<grid, block>>>(gpu_Scales, e_gpu_a, acoef, ix,
          nrefine, k, nsubs, bcoef, gpu_abscfssq);
        abscfssq_dirtyOnGpu = true;
      }
    }

    if (abscfssq->size[1] < 1) {
      cb_y->size[0] = 1;
      cb_y->size[1] = 0;
    } else {
      N = static_cast<uint32_T>(abscfssq->size[1]);
      k = cb_y->size[0] * cb_y->size[1];
      cb_y->size[0] = 1;
      cb_y->size[1] = abscfssq->size[1];
      emxEnsureCapacity_uint32_T(cb_y, k, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_uint32_T(cb_y, &v_gpu_y);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
        static_cast<int32_T>(N) - 1) + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_cwtAvg_kernel171<<<grid, block>>>(N, v_gpu_y);
        i_y_dirtyOnGpu = true;
      }
    }

    k = z->size[0];
    z->size[0] = abscfssq->size[0];
    emxEnsureCapacity_real32_T(z, k, &qb_emlrtRTEI);
    if (!z_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real32_T(z, &gpu_z);
    }

    ix = abscfssq->size[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (z_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, z);
      }

      ecc_cwtAvg_kernel172<<<grid, block>>>(ix, gpu_z);
      z_dirtyOnCpu = false;
      z_dirtyOnGpu = true;
    }

    if (abscfssq->size[1] > 1) {
      if (cb_y->size[1] == 1) {
        lidx = abscfssq->size[1];
        k = b_c->size[0];
        b_c->size[0] = abscfssq->size[1];
        emxEnsureCapacity_real_T(b_c, k, &tb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_c, &gpu_c);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((lidx -
          1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ecc_cwtAvg_kernel176<<<grid, block>>>(v_gpu_y, lidx, gpu_c);
        }

        if (i_y_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_uint32_T(cb_y, &v_gpu_y);
        }

        i_y_dirtyOnGpu = false;
        r = 0.5 * static_cast<real_T>(cb_y->data[0]);
        ecc_cwtAvg_kernel177<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(r, gpu_c);
        bcoef = abscfssq->size[1];
        ecc_cwtAvg_kernel178<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(r, bcoef,
          gpu_c);
        b_dirtyOnGpu = true;
      } else {
        k = b_c->size[0];
        b_c->size[0] = abscfssq->size[1];
        emxEnsureCapacity_real_T(b_c, k, &sb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_c, &gpu_c);
        ecc_cwtAvg_kernel173<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(v_gpu_y,
          gpu_c);
        lidx = abscfssq->size[1] - 3;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ecc_cwtAvg_kernel174<<<grid, block>>>(v_gpu_y, lidx, gpu_c);
        }

        bcoef = abscfssq->size[1];
        ecc_cwtAvg_kernel175<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(v_gpu_y,
          bcoef, gpu_c);
        b_dirtyOnGpu = true;
      }

      nsubs = abscfssq->size[0];
      if (abscfssq->size[0] != 0) {
        lidx = abscfssq->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (z_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, z);
          }

          ecc_cwtAvg_kernel179<<<grid, block>>>(lidx, gpu_z);
          z_dirtyOnCpu = false;
          z_dirtyOnGpu = true;
        }

        ix = 0;
        lidx = abscfssq->size[0] * (abscfssq->size[1] - 1);
        for (eint = 0; eint <= div_s32(lidx, nsubs); eint++) {
          nrefine = eint * nsubs;
          acoef = (nrefine + nsubs) - 1;
          for (pathlen = 0; pathlen <= acoef - nrefine; pathlen++) {
            if (z_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(z, &gpu_z);
            }

            if (abscfssq_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(abscfssq, &gpu_abscfssq);
            }

            abscfssq_dirtyOnGpu = false;
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_c, &gpu_c);
            }

            b_dirtyOnGpu = false;
            z->data[pathlen] += abscfssq->data[nrefine + pathlen] * static_cast<
              real32_T>(b_c->data[ix]);
            z_dirtyOnGpu = false;
            z_dirtyOnCpu = true;
          }

          ix++;
        }
      }
    }

    t = 0.0F;
    b_dirtyOnGpu = false;
    if (z->size[0] <= 1) {
      if (Scales->size[1] == 1) {
        if (Scales_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(Scales, &gpu_Scales);
        }

        Scales_dirtyOnGpu = false;
        if (std::isinf(Scales->data[0]) || std::isnan(Scales->data[0])) {
          t = rtNaNF;
        }
      }
    } else {
      if (Scales->size[1] == 1) {
        lidx = z->size[0];
        k = c_c->size[0];
        c_c->size[0] = z->size[0];
        emxEnsureCapacity_real32_T(c_c, k, &tb_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_c, &b_gpu_c);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((lidx -
          1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ecc_cwtAvg_kernel183<<<grid, block>>>(gpu_Scales, lidx, b_gpu_c);
        }

        if (Scales_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(Scales, &gpu_Scales);
        }

        Scales_dirtyOnGpu = false;
        xbar = 0.5F * Scales->data[0];
        cudaMemcpy(gpu_xbar, &xbar, 4UL, cudaMemcpyHostToDevice);
        ecc_cwtAvg_kernel184<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_xbar,
          b_gpu_c);
        bcoef = z->size[0];
        if (z_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, z);
        }

        z_dirtyOnCpu = false;
        ecc_cwtAvg_kernel185<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(bcoef,
          gpu_xbar, b_gpu_c);
      } else {
        k = c_c->size[0];
        c_c->size[0] = z->size[0];
        emxEnsureCapacity_real32_T(c_c, k, &sb_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_c, &b_gpu_c);
        ecc_cwtAvg_kernel180<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_Scales,
          b_gpu_c);
        lidx = z->size[0] - 3;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ecc_cwtAvg_kernel181<<<grid, block>>>(gpu_Scales, lidx, b_gpu_c);
        }

        bcoef = z->size[0];
        if (z_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, z);
        }

        z_dirtyOnCpu = false;
        ecc_cwtAvg_kernel182<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_Scales,
          bcoef, b_gpu_c);
      }

      xbar = 0.0F;
      varsig = 1.0F;
      cudaMemcpy(gpu_t, &t, 4UL, cudaMemcpyHostToDevice);
      cublasSgemv(getCublasGlobalHandle(), CUBLAS_OP_T, z->size[0], 1, (float *)
                  &varsig, (float *)&gpu_z.data[0], z->size[0], (float *)
                  &b_gpu_c.data[0], 1, (float *)&xbar, (float *)gpu_t, 1);
      b_dirtyOnGpu = true;
    }

    if (!(normfac == 0.0F)) {
      if (b_dirtyOnGpu) {
        cudaMemcpy(&t, gpu_t, 4UL, cudaMemcpyDeviceToHost);
      }

      xbar = std::sqrt(normfac / (static_cast<real32_T>(2.0 / intFsq /
        static_cast<real_T>(abscfssq->size[1])) * t));
      k = cfs->size[0] * cfs->size[1];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((k - 1) +
        1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        cudaMemcpy(gpu_xbar, &xbar, 4UL, cudaMemcpyHostToDevice);
        ecc_cwtAvg_kernel186<<<grid, block>>>(k, gpu_xbar, gpu_cfs);
      }
    }

    nrefine = cfs->size[0] * cfs->size[1] - 1;
    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(cfs->size[bcoef]);
      xSize_dirtyOnCpu = true;
    }

    k = db_y->size[0] * db_y->size[1];
    db_y->size[0] = static_cast<int32_T>(xSize[0]);
    db_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(db_y, k, &u_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(db_y, &y_gpu_y);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel187<<<grid, block>>>(gpu_cfs, nrefine, y_gpu_y);
    }

    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(db_y->size[bcoef]);
      xSize_dirtyOnCpu = true;
    }

    k = abswt2->size[0] * abswt2->size[1];
    abswt2->size[0] = static_cast<int32_T>(xSize[0]);
    abswt2->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(abswt2, k, &i_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(abswt2, &gpu_abswt2);
    nrefine = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) -
      1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nrefine + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecc_cwtAvg_kernel188<<<grid, block>>>(y_gpu_y, nrefine, gpu_abswt2);
    }

    k = abswt2S->size[0] * abswt2S->size[1];
    lidx = Scales->size[1];
    nrefine = abswt2->size[0];
    if (lidx <= nrefine) {
      nrefine = lidx;
    }

    if (Scales->size[1] == 1) {
      abswt2S->size[0] = abswt2->size[0];
    } else if (abswt2->size[0] == 1) {
      abswt2S->size[0] = Scales->size[1];
    } else if (abswt2->size[0] == Scales->size[1]) {
      abswt2S->size[0] = abswt2->size[0];
    } else {
      abswt2S->size[0] = nrefine;
    }

    abswt2S->size[1] = abswt2->size[1];
    emxEnsureCapacity_real32_T(abswt2S, k, &q_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(abswt2S, &gpu_abswt2S);
    lidx = Scales->size[1];
    nrefine = abswt2->size[0];
    if (lidx <= nrefine) {
      nrefine = lidx;
    }

    if (Scales->size[1] == 1) {
      nrefine = abswt2->size[0];
    } else if (abswt2->size[0] == 1) {
      nrefine = Scales->size[1];
    } else if (abswt2->size[0] == Scales->size[1]) {
      nrefine = abswt2->size[0];
    }

    if ((nrefine != 0) && (abswt2->size[1] != 0)) {
      acoef = (abswt2->size[1] != 1);
      lidx = abswt2->size[1];
      ix = abswt2S->size[0] - 1;
      nsubs = Scales->size[1];
      bcoef = abswt2S->size[0];
      k = abswt2->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ix + 1L) *
        ((lidx - 1) + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_cwtAvg_kernel189<<<grid, block>>>(gpu_Scales, gpu_abswt2, acoef, ix,
          lidx, k, nsubs, bcoef, gpu_abswt2S);
      }
    }

    if ((abswt2S->size[0] == 0) && (abswt2S->size[1] == 0)) {
      if (i45 == 1) {
        if (Scales_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(Scales, &gpu_Scales);
        }

        Scales_dirtyOnGpu = false;
        t = Scales->data[0] * 0.0F;
      } else {
        t = 0.0F;
      }

      k = savgpTMP->size[0] * savgpTMP->size[1];
      savgpTMP->size[0] = 1;
      savgpTMP->size[1] = 1;
      emxEnsureCapacity_real32_T(savgpTMP, k, &ub_emlrtRTEI);
      if (!savgpTMP_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(savgpTMP, &gpu_savgpTMP);
      }

      if (savgpTMP_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(savgpTMP, &gpu_savgpTMP);
      }

      savgpTMP->data[0] = t;
      savgpTMP_dirtyOnGpu = false;
      savgpTMP_dirtyOnCpu = true;
    } else {
      k = savgpTMP->size[0] * savgpTMP->size[1];
      savgpTMP->size[0] = 1;
      savgpTMP->size[1] = abswt2S->size[1];
      emxEnsureCapacity_real32_T(savgpTMP, k, &ub_emlrtRTEI);
      if (!savgpTMP_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(savgpTMP, &gpu_savgpTMP);
      }

      ix = abswt2S->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (savgpTMP_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_savgpTMP, savgpTMP);
        }

        ecc_cwtAvg_kernel190<<<grid, block>>>(ix, gpu_savgpTMP);
        savgpTMP_dirtyOnCpu = false;
        savgpTMP_dirtyOnGpu = true;
      }

      if (abswt2S->size[0] <= 1) {
        if (i45 == 1) {
          if (Scales_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(Scales, &gpu_Scales);
          }

          Scales_dirtyOnGpu = false;
          if (std::isinf(Scales->data[0]) || std::isnan(Scales->data[0])) {
            k = savgpTMP->size[0] * savgpTMP->size[1];
            savgpTMP->size[0] = 1;
            savgpTMP->size[1] = abswt2S->size[1];
            emxEnsureCapacity_real32_T(savgpTMP, k, &ub_emlrtRTEI);
            if (!savgpTMP_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(savgpTMP, &gpu_savgpTMP);
            }

            ix = abswt2S->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ix +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (savgpTMP_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_savgpTMP, savgpTMP);
              }

              ecc_cwtAvg_kernel197<<<grid, block>>>(ix, gpu_savgpTMP);
              savgpTMP_dirtyOnCpu = false;
              savgpTMP_dirtyOnGpu = true;
            }
          }
        }
      } else {
        if (i45 == 1) {
          lidx = abswt2S->size[0];
          k = d_c->size[0];
          d_c->size[0] = abswt2S->size[0];
          emxEnsureCapacity_real32_T(d_c, k, &tb_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(d_c, &c_gpu_c);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((lidx
            - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_cwtAvg_kernel194<<<grid, block>>>(gpu_Scales, lidx, c_gpu_c);
          }

          if (Scales_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(Scales, &gpu_Scales);
          }

          Scales_dirtyOnGpu = false;
          xbar = 0.5F * Scales->data[0];
          cudaMemcpy(gpu_xbar, &xbar, 4UL, cudaMemcpyHostToDevice);
          ecc_cwtAvg_kernel195<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_xbar,
            c_gpu_c);
          bcoef = abswt2S->size[0];
          ecc_cwtAvg_kernel196<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(bcoef,
            gpu_xbar, c_gpu_c);
        } else {
          k = d_c->size[0];
          d_c->size[0] = abswt2S->size[0];
          emxEnsureCapacity_real32_T(d_c, k, &sb_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(d_c, &c_gpu_c);
          ecc_cwtAvg_kernel191<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (gpu_Scales, c_gpu_c);
          lidx = abswt2S->size[0] - 3;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(lidx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_cwtAvg_kernel192<<<grid, block>>>(gpu_Scales, lidx, c_gpu_c);
          }

          bcoef = abswt2S->size[0];
          ecc_cwtAvg_kernel193<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (gpu_Scales, bcoef, c_gpu_c);
        }

        if (abswt2S->size[1] >= 1) {
          xbar = 0.0F;
          varsig = 1.0F;
          if (savgpTMP_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_savgpTMP, savgpTMP);
          }

          cublasSgemv(getCublasGlobalHandle(), CUBLAS_OP_T, abswt2S->size[0],
                      abswt2S->size[1], (float *)&varsig, (float *)
                      &gpu_abswt2S.data[0], abswt2S->size[0], (float *)
                      &c_gpu_c.data[0], 1, (float *)&xbar, (float *)
                      &gpu_savgpTMP.data[0], 1);
          savgpTMP_dirtyOnCpu = false;
          savgpTMP_dirtyOnGpu = true;
        }
      }
    }

    lidx = iv9->size[0];
    bcoef = xx->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((lidx - 1) +
      1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (savgpTMP_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_savgpTMP, savgpTMP);
      }

      savgpTMP_dirtyOnCpu = false;
      if (xx_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xx, xx);
      }

      ecc_cwtAvg_kernel198<<<grid, block>>>(gpu_savgpTMP, fb_CutOff, gpu_iv9,
        lidx, bcoef, gpu_xx);
      xx_dirtyOnCpu = false;
      xx_dirtyOnGpu = true;
    }
  }

  emxFree_real32_T(&d_c);
  emxFree_real32_T(&savgpTMP);
  emxFree_real32_T(&abswt2S);
  emxFree_real_T(&hb_y);
  emxFree_real_T(&gb_y);
  emxFree_real32_T(&abswt2);
  emxFree_real_T(&fb_y);
  emxFree_real_T(&i_fx);
  emxFree_real_T(&g_a);
  emxFree_real_T(&eb_y);
  emxFree_real32_T(&db_y);
  emxFree_real32_T(&c_c);
  emxFree_real_T(&i_xt);
  emxFree_real_T(&b_c);
  emxFree_real_T(&w_x);
  emxFree_real32_T(&z);
  emxFree_uint32_T(&cb_y);
  emxFree_real_T(&v_x);
  emxFree_real32_T(&f_a);
  emxFree_real32_T(&abscfssq);
  emxFree_real32_T(&bb_y);
  emxFree_creal32_T(&cfs);
  emxFree_creal32_T(&cfspos);
  emxFree_creal32_T(&cfsposdft);
  emxFree_real32_T(&u_x);
  emxFree_creal32_T(&xposdft);
  emxFree_real32_T(&xv);
  emxFree_real32_T(&psihat);
  emxFree_real32_T(&Scales);
  emxFree_real32_T(&t_x);
  emxFree_int32_T(&iv9);
  emxFree_uint32_T(&ii);
  emxFree_real_T(&psidft);
  emxFree_real_T(&fb_Scales);
  emxFree_real32_T(&b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (xx_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(xx, &gpu_xx);
  }

  if (freqs_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(freqs, &gpu_freqs);
  }

  gpuEmxFree_real32_T(&gpu_x);
  gpuEmxFree_real32_T(&b_gpu_x);
  mwCudaFree(&(*gpu_fLims)[0]);
  mwCudaFree(&(*gpu_b)[0]);
  mwCudaFree(&(*gpu_freqrange)[0]);
  mwCudaFree(&(*gpu_NyquistRange)[0]);
  mwCudaFree(&(*gpu_wav)[0]);
  mwCudaFree(&(*gpu_interval)[0]);
  gpuEmxFree_real_T(&gpu_omega);
  gpuEmxFree_real_T(&gpu_r);
  mwCudaFree(&(*gpu_subs)[0]);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_real_T(&gpu_xt);
  gpuEmxFree_real_T(&d_gpu_x);
  gpuEmxFree_real_T(&e_gpu_x);
  gpuEmxFree_real_T(&b_gpu_xt);
  gpuEmxFree_real_T(&f_gpu_x);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_real_T(&g_gpu_x);
  gpuEmxFree_real_T(&c_gpu_xt);
  gpuEmxFree_real_T(&h_gpu_x);
  gpuEmxFree_real_T(&gpu_fx);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&d_gpu_y);
  gpuEmxFree_real_T(&i_gpu_x);
  gpuEmxFree_real_T(&d_gpu_xt);
  gpuEmxFree_real_T(&j_gpu_x);
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
  gpuEmxFree_real_T(&k_gpu_x);
  gpuEmxFree_real_T(&e_gpu_xt);
  gpuEmxFree_real_T(&l_gpu_x);
  gpuEmxFree_real_T(&m_gpu_x);
  gpuEmxFree_real_T(&f_gpu_xt);
  gpuEmxFree_real_T(&n_gpu_x);
  gpuEmxFree_real_T(&gpu_absomega);
  gpuEmxFree_real_T(&gpu_powscales);
  gpuEmxFree_real_T(&m_gpu_y);
  gpuEmxFree_real_T(&n_gpu_y);
  gpuEmxFree_real_T(&o_gpu_x);
  gpuEmxFree_real_T(&g_gpu_xt);
  gpuEmxFree_real_T(&p_gpu_x);
  gpuEmxFree_real_T(&gpu_freqs);
  gpuEmxFree_real_T(&q_gpu_x);
  gpuEmxFree_real_T(&h_gpu_xt);
  gpuEmxFree_real_T(&r_gpu_x);
  gpuEmxFree_real_T(&e_gpu_fx);
  gpuEmxFree_real_T(&f_gpu_fx);
  gpuEmxFree_real_T(&o_gpu_y);
  gpuEmxFree_real_T(&p_gpu_y);
  gpuEmxFree_real_T(&gpu_dv23);
  gpuEmxFree_real_T(&s_gpu_x);
  gpuEmxFree_real_T(&gpu_dv26);
  gpuEmxFree_real_T(&c_gpu_a);
  gpuEmxFree_uint32_T(&gpu_ii);
  gpuEmxFree_real_T(&d_gpu_a);
  gpuEmxFree_real_T(&g_gpu_fx);
  gpuEmxFree_real_T(&gpu_dv19);
  gpuEmxFree_real_T(&gpu_dv20);
  gpuEmxFree_real_T(&q_gpu_y);
  gpuEmxFree_real_T(&h_gpu_fx);
  gpuEmxFree_real_T(&r_gpu_y);
  gpuEmxFree_real_T(&s_gpu_y);
  gpuEmxFree_real_T(&t_gpu_y);
  gpuEmxFree_real_T(&gpu_dv27);
  gpuEmxFree_real_T(&gpu_dv29);
  gpuEmxFree_real_T(&gpu_dv21);
  gpuEmxFree_real_T(&gpu_dv24);
  gpuEmxFree_real32_T(&t_gpu_x);
  gpuEmxFree_int32_T(&gpu_iv9);
  gpuEmxFree_real32_T(&gpu_Scales);
  gpuEmxFree_real32_T(&gpu_psihat);
  gpuEmxFree_real32_T(&gpu_xv);
  gpuEmxFree_creal32_T(&gpu_xposdft);
  gpuEmxFree_real32_T(&u_gpu_x);
  gpuEmxFree_creal32_T(&gpu_cfsposdft);
  mwCudaFree(&(*gpu_xSize)[0]);
  mwCudaFree(b_gpu_cfsposdft);
  gpuEmxFree_creal32_T(&gpu_cfspos);
  gpuEmxFree_creal32_T(&gpu_cfs);
  mwCudaFree(&(*gpu_wavname)[0]);
  gpuEmxFree_real32_T(&u_gpu_y);
  gpuEmxFree_real32_T(&gpu_abscfssq);
  gpuEmxFree_real32_T(&e_gpu_a);
  gpuEmxFree_real_T(&v_gpu_x);
  gpuEmxFree_real_T(&i_gpu_xt);
  gpuEmxFree_real_T(&w_gpu_x);
  gpuEmxFree_real_T(&f_gpu_a);
  gpuEmxFree_uint32_T(&v_gpu_y);
  gpuEmxFree_real32_T(&gpu_z);
  gpuEmxFree_real_T(&i_gpu_fx);
  gpuEmxFree_real_T(&w_gpu_y);
  gpuEmxFree_real_T(&gpu_c);
  gpuEmxFree_real32_T(&b_gpu_c);
  gpuEmxFree_real_T(&x_gpu_y);
  mwCudaFree(gpu_xbar);
  gpuEmxFree_real32_T(&y_gpu_y);
  mwCudaFree(gpu_t);
  gpuEmxFree_real_T(&ab_gpu_y);
  gpuEmxFree_real32_T(&gpu_abswt2);
  gpuEmxFree_real_T(&bb_gpu_y);
  gpuEmxFree_real32_T(&gpu_abswt2S);
  gpuEmxFree_real32_T(&gpu_savgpTMP);
  gpuEmxFree_real32_T(&c_gpu_c);
  gpuEmxFree_real32_T(&gpu_xx);
}

void ecc_cwtAvg_api(const mxArray * const prhs[4], int32_T nlhs, const mxArray
                    *plhs[2])
{
  emxArray_real32_T *x;
  emxArray_real32_T *xx;
  emxArray_real_T *freqs;
  const mxArray *prhs_copy_idx_2;
  real_T (*fLims)[2];
  real_T fOctave;
  real_T fs;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_2 = emlrtProtectR2012b(prhs[2], 2, false, -1);

  // Marshall function inputs
  emxInit_real32_T(&x, 2, &yc_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  fs = emlrt_marshallIn(emlrtAliasP(prhs[1]), "fs");
  fLims = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_2), "fLims");
  fOctave = emlrt_marshallIn(emlrtAliasP(prhs[3]), "fOctave");

  // Invoke the target function
  emxInit_real32_T(&xx, 2, &yc_emlrtRTEI, true);
  emxInit_real_T(&freqs, 2, &yc_emlrtRTEI, true);
  ecc_cwtAvg(x, fs, *fLims, fOctave, xx, freqs);
  emxFree_real32_T(&x);

  // Marshall function outputs
  xx->canFreeData = false;
  plhs[0] = emlrt_marshallOut(xx);
  emxFree_real32_T(&xx);
  if (nlhs > 1) {
    freqs->canFreeData = false;
    plhs[1] = emlrt_marshallOut(freqs);
  }

  emxFree_real_T(&freqs);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ecc_cwtAvg_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  mwCudaFree(&(*cv_gpu_clone)[0]);
}

void ecc_cwtAvg_initialize()
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
    ecc_cwtAvg_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ecc_cwtAvg_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode), (char_T *)
                       cudaGetErrorString(errCode), (char_T *)cudaGetErrorName
                       (errCode), (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }

  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  cublasEnsureDestruction();
  mwMemoryManagerTerminate();
}

// End of code generation (ecc_cwtAvg.cu)
