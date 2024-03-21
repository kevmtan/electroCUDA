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
#include "MWErrorCodeUtils.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "cufft.h"
#include "math_constants.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include <algorithm>
#include <cmath>
#include <cstdlib>
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
  131643U,                             // fVersionInfo
  nullptr,                             // fErrorFunction
  "ec_cwtAvg",                         // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 1075284325U, 2201364878U, 3488609979U, 1269018621U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtMCInfo emlrtMCI{ 53,       // lineNo
  14,                                  // colNo
  "nonConstPrint",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtMCInfo b_emlrtMCI{ 55,     // lineNo
  15,                                  // colNo
  "nonConstPrint",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtRTEInfo emlrtRTEI{ 1,      // lineNo
  1,                                   // colNo
  "_coder_ec_cwtAvg_api",              // fName
  ""                                   // pName
};

static emlrtRTEInfo b_emlrtRTEI{ 999,  // lineNo
  17,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 1000, // lineNo
  17,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 1009, // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 28,   // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 27,   // lineNo
  1,                                   // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 18,   // lineNo
  5,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 60,   // lineNo
  20,                                  // colNo
  "bsxfun",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/bsxfun.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 18,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 31,   // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 30,   // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 33,   // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 25,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 31,   // lineNo
  23,                                  // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 31,   // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 34,   // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 33,   // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 956,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 41,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 29,   // lineNo
  1,                                   // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 230,  // lineNo
  1,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 102,  // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 135,  // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 143,  // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "cuFFTNDCallback",                   // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/cuFFTNDCallback.p"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 138, // lineNo
  19,                                  // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 138, // lineNo
  6,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 161, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 180, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 22,  // lineNo
  32,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 12,  // lineNo
  5,                                   // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 211, // lineNo
  24,                                  // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 96,  // lineNo
  5,                                   // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 294, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 298, // lineNo
  18,                                  // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 297, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 1276,// lineNo
  30,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 1276,// lineNo
  25,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 26,  // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 21,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 32,  // lineNo
  18,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 34,  // lineNo
  42,                                  // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 32,  // lineNo
  13,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 934, // lineNo
  26,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 287, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 151, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 12,  // lineNo
  12,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 12,  // lineNo
  1,                                   // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 26,  // lineNo
  43,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 26,  // lineNo
  37,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 293, // lineNo
  14,                                  // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 293, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 1,   // lineNo
  22,                                  // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static char_T (*global_gpu_cv)[128];
static boolean_T gpuConstsCopied_ec_cwtAvg;

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_char_T *ret);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real32_T *ret);
static real_T (*b_emlrt_marshallIn(const mxArray *b_nullptr, const char_T
  *identifier))[2];
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2];
static void b_raiseCudaError(int32_T errCode, const char_T *file, uint32_T
  b_line, const char_T *errorName, const char_T *errorString);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3);
static void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_3(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_4(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_5(real_T in1_data[], int32_T in1_size[2], const
  real_T in2_data[], const int32_T in2_size[2], const real_T in3_data[], const
  int32_T in3_size[2], const real_T in4_data[], const int32_T in4_size[2]);
static real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T
  b_line);
static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static uint64_T computeNumIters(int32_T ub, int32_T b_ub);
static uint64_T computeNumIters(int32_T ub);
static void cublasCheck(cublasStatus_t errCode, const char_T *file, uint32_T
  b_line);
static real_T (*d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2];
static int32_T div_s32(int32_T numerator, int32_T denominator);
static __global__ void ec_cwtAvg_kernel1(const char_T cv[128], char_T wname[5],
  char_T wav[5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3,
  char_T b_dim4);
static __global__ void ec_cwtAvg_kernel10(const emxArray_real_T omega_tmp2,
  const int32_T b, emxArray_real_T fb_Omega);
static __global__ void ec_cwtAvg_kernel100(const real_T x_data[9735], const
  int32_T b, real_T dv15_data[9735]);
static __global__ void ec_cwtAvg_kernel101(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel102(const real_T y_data[9735], const
  int32_T b, real_T b_y_data[9735]);
static __global__ void ec_cwtAvg_kernel103(const real_T xt_data[9735], const
  real_T y_data[9735], const real_T dv15_data[9735], const int32_T dv15_size,
  real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel104(const real_T interval[650], const
  int32_T b, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel105(const real_T x_data[9735], const
  int32_T b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwtAvg_kernel106(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel107(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel108(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel109(const real_T y_data[9735], const
  real_T b_y_data[9735], const int32_T y_size, real_T a_data[9735]);
static __global__ void ec_cwtAvg_kernel11(const int32_T nrefine, const int32_T i,
  const emxArray_real_T omega_tmp2, const int32_T nx, emxArray_real_T fb_Omega,
  int32_T omega_tmp2_dim1);
static __global__ void ec_cwtAvg_kernel110(const real_T a_data[9735], const
  int32_T b, real_T dv11_data[9735]);
static __global__ void ec_cwtAvg_kernel111(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel112(const real_T y_data[9735], const
  int32_T b, real_T b_y_data[9735]);
static __global__ void ec_cwtAvg_kernel113(const real_T xt_data[9735], const
  real_T y_data[9735], const real_T dv11_data[9735], const int32_T dv11_size,
  real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel114(const int32_T b, emxArray_int32_T
  omega_tmp1);
static __global__ void ec_cwtAvg_kernel115(const real_T interval[650], const
  int32_T b, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel116(const real_T x_data[9735], const
  int32_T b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwtAvg_kernel117(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel118(const real_T x_data[9735], const
  int32_T b, real_T dv10_data[9735]);
static __global__ void ec_cwtAvg_kernel119(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel12(emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel120(const real_T y_data[9735], const
  int32_T b, real_T b_y_data[9735]);
static __global__ void ec_cwtAvg_kernel121(const real_T xt_data[9735], const
  real_T y_data[9735], const real_T dv10_data[9735], const int32_T dv10_size,
  real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel122(const real_T interval[650], const
  int32_T b, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel123(const real_T x_data[9735], const
  int32_T b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwtAvg_kernel124(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel125(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel126(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel127(const real_T y_data[9735], const
  real_T b_y_data[9735], const int32_T y_size, real_T a_data[9735]);
static __global__ void ec_cwtAvg_kernel128(const real_T a_data[9735], const
  int32_T b, real_T dv4_data[9735]);
static __global__ void ec_cwtAvg_kernel129(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel13(const emxArray_real_T y, const real_T
  tol, const int32_T b, emxArray_real_T b_y);
static __global__ void ec_cwtAvg_kernel130(const real_T y_data[9735], const
  int32_T b, real_T b_y_data[9735]);
static __global__ void ec_cwtAvg_kernel131(const real_T xt_data[9735], const
  real_T y_data[9735], const real_T dv4_data[9735], const int32_T dv4_size,
  real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel14(const emxArray_real_T y, const real_T
  halfh, const int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ec_cwtAvg_kernel15(const emxArray_real_T somega, const
  int32_T b, emxArray_real_T absomega);
static __global__ void ec_cwtAvg_kernel16(const emxArray_real_T absomega, const
  int32_T b_absomega, emxArray_real_T powscales);
static __global__ void ec_cwtAvg_kernel17(const int32_T b, emxArray_real_T
  absomega);
static __global__ void ec_cwtAvg_kernel18(const emxArray_real_T powscales, const
  emxArray_real_T absomega, const int32_T b_absomega, emxArray_real_T x);
static __global__ void ec_cwtAvg_kernel19(const int32_T b, emxArray_real_T x);
static __global__ void ec_cwtAvg_kernel2(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel20(const emxArray_real_T somega, const
  emxArray_real_T x, const int32_T b_x, emxArray_real_T daughter);
static __global__ void ec_cwtAvg_kernel21(const emxArray_real_T fb_Scales, const
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ec_cwtAvg_kernel22(const real_T fs, const int32_T i,
  emxArray_real_T f);
static __global__ void ec_cwtAvg_kernel23(const emxArray_real_T f, const int32_T
  b_f, emxArray_real_T freqs);
static __global__ void ec_cwtAvg_kernel24(const emxArray_real_T fb_Scales, const
  int32_T b_fb_Scales, emxArray_real32_T Scales);
static __global__ void ec_cwtAvg_kernel25(const emxArray_real_T daughter, const
  int32_T b_daughter, emxArray_real32_T psihat);
static __global__ void ec_cwtAvg_kernel26(const int32_T i, const
  emxArray_real32_T x, const int32_T b_x, emxArray_real32_T xv, int32_T x_dim0);
static __global__ void ec_cwtAvg_kernel27(const int32_T i, const
  emxArray_real32_T x, const int32_T b, emxArray_real32_T b_x, int32_T x_dim0);
static __global__ void ec_cwtAvg_kernel28(const real_T y, const int32_T b,
  emxArray_real32_T x);
static __global__ void ec_cwtAvg_kernel29(const emxArray_real32_T x, const
  int32_T b, emxArray_real32_T xv);
static __global__ void ec_cwtAvg_kernel3(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel30(const emxArray_real32_T xv, const
  int32_T b_xv, emxArray_creal32_T xposdft);
static __global__ void ec_cwtAvg_kernel31(const emxArray_creal32_T xposdft,
  const emxArray_real32_T psihat, const int32_T bcoef, const int32_T cfsposdft,
  const int32_T i, emxArray_creal32_T b_cfsposdft, int32_T psihat_dim0, int32_T
  cfsposdft_dim0);
static __global__ void ec_cwtAvg_kernel32(const int32_T xSize,
  emxArray_creal32_T cfspos);
static __global__ void ec_cwtAvg_kernel33(const emxArray_creal32_T cfspos, const
  int32_T b, emxArray_real32_T y);
static __global__ void ec_cwtAvg_kernel34(const emxArray_real32_T y, const
  int32_T b, emxArray_real32_T abscfssq);
static __global__ void ec_cwtAvg_kernel35(const emxArray_real32_T abscfssq,
  const int32_T b_abscfssq, emxArray_real32_T a);
static __global__ void ec_cwtAvg_kernel36(const emxArray_real32_T Scales, const
  emxArray_real32_T a, const int32_T nrefine, const int32_T abscfssq, const
  int32_T i, emxArray_real32_T b_abscfssq, int32_T a_dim0, int32_T Scales_dim1,
  int32_T abscfssq_dim0);
static __global__ void ec_cwtAvg_kernel37(const int32_T abscfssq,
  emxArray_real32_T z);
static __global__ void ec_cwtAvg_kernel38(const emxArray_uint32_T y, const
  int32_T b, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel39(const emxArray_uint32_T y,
  emxArray_real_T c, real_T *r);
static __global__ void ec_cwtAvg_kernel4(const int32_T i, real_T interval[650]);
static __global__ void ec_cwtAvg_kernel40(const real_T *r, emxArray_real_T c,
  int32_T abscfssq_dim1);
static __global__ void ec_cwtAvg_kernel41(const int32_T b, emxArray_real32_T z);
static __global__ void ec_cwtAvg_kernel42(const real32_T xbar, const int32_T b,
  emxArray_creal32_T cfspos);
static __global__ void ec_cwtAvg_kernel43(const emxArray_creal32_T cfspos, const
  int32_T b, emxArray_real32_T y);
static __global__ void ec_cwtAvg_kernel44(const emxArray_real32_T y, const
  int32_T b, emxArray_real32_T abswt2);
static __global__ void ec_cwtAvg_kernel45(const emxArray_real32_T Scales, const
  emxArray_real32_T abswt2, const int32_T b_abswt2, const int32_T c_abswt2,
  emxArray_real32_T abswt2S, int32_T abswt2S_dim0, int32_T abswt2_dim0);
static __global__ void ec_cwtAvg_kernel46(const emxArray_real32_T abswt2S, const
  int32_T b, const int32_T b_abswt2S, emxArray_real32_T y, int32_T y_dim0,
  int32_T abswt2S_dim0);
static __global__ void ec_cwtAvg_kernel47(const int32_T abswt2S,
  emxArray_real32_T savgpTMP);
static __global__ void ec_cwtAvg_kernel48(const emxArray_real32_T Scales, const
  int32_T b, emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel49(const int32_T outsize_idx_0, const
  emxArray_real32_T Scales, emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel5(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel50(const emxArray_real32_T Scales,
  emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel51(const emxArray_real32_T Scales, const
  int32_T b, emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel52(const emxArray_real32_T Scales, const
  int32_T outsize_idx_0, emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel53(const emxArray_real32_T Scales, const
  int32_T b, emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel54(const real32_T xbar, emxArray_real32_T
  c, int32_T z_dim0);
static __global__ void ec_cwtAvg_kernel55(const emxArray_real32_T Scales,
  emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel56(const emxArray_real32_T Scales, const
  int32_T b, emxArray_real32_T c);
static __global__ void ec_cwtAvg_kernel57(const emxArray_real32_T Scales,
  emxArray_real32_T c, int32_T z_dim0);
static __global__ void ec_cwtAvg_kernel58(const emxArray_uint32_T y,
  emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel59(const emxArray_uint32_T y, const
  int32_T b, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel6(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel60(const emxArray_uint32_T y,
  emxArray_real_T c, int32_T abscfssq_dim1);
static __global__ void ec_cwtAvg_kernel61(const int32_T b, emxArray_uint32_T y);
static __global__ void ec_cwtAvg_kernel62(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel63(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel64(const int32_T i, real_T interval[650]);
static __global__ void ec_cwtAvg_kernel65(const real_T interval[650], const
  int32_T b, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel66(const real_T x_data[9735], const
  int32_T b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwtAvg_kernel67(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel68(const real_T x_data[9735], const
  int32_T x_size, real_T a_data[9735]);
static __global__ void ec_cwtAvg_kernel69(const real_T a_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel7(const int32_T i, real_T interval[650]);
static __global__ void ec_cwtAvg_kernel70(const real_T y_data[9735], const
  int32_T b, real_T x_data[9735]);
static __global__ void ec_cwtAvg_kernel71(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel72(const real_T y_data[9735], const
  int32_T b, real_T b_y_data[9735]);
static __global__ void ec_cwtAvg_kernel73(const real_T xt_data[9735], const
  real_T x_data[9735], const real_T y_data[9735], const int32_T y_size, real_T
  fx_data[9735]);
static __global__ void ec_cwtAvg_kernel74(const real32_T cfsposdft_re, const
  emxArray_creal32_T cfsposdft, const int32_T b_cfsposdft, emxArray_creal32_T
  cfspos);
static __global__ void ec_cwtAvg_kernel75(const int32_T b, emxArray_creal32_T
  xposdft, uint32_T xSize_dim1);
static __global__ void ec_cwtAvg_kernel76(const emxArray_real_T fb_Omega, const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, const int32_T b,
  emxArray_real_T somega, int32_T somega_dim0);
static __global__ void ec_cwtAvg_kernel77(const emxArray_real_T somega, const
  int32_T b_somega, emxArray_real_T w);
static __global__ void ec_cwtAvg_kernel78(const emxArray_real_T w, const int32_T
  b_w, emxArray_real_T expnt);
static __global__ void ec_cwtAvg_kernel79(const int32_T b, emxArray_real_T expnt);
static __global__ void ec_cwtAvg_kernel8(const real_T fc, const emxArray_int32_T
  omega_tmp1, const int32_T b_omega_tmp1, emxArray_real_T omega_tmp2);
static __global__ void ec_cwtAvg_kernel80(const emxArray_real_T w, const int32_T
  b, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel81(const emxArray_real_T y, const
  emxArray_real_T expnt, const int32_T b_expnt, emxArray_real_T daughter);
static __global__ void ec_cwtAvg_kernel82(const int32_T nrefine, emxArray_real_T
  daughter);
static __global__ void ec_cwtAvg_kernel83(const emxArray_real_T fb_Scales, const
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ec_cwtAvg_kernel84(const emxArray_real_T fb_Omega, const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, const int32_T b,
  emxArray_real_T somega, int32_T somega_dim0);
static __global__ void ec_cwtAvg_kernel85(const int32_T b, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel86(const char_T cv[128], char_T wav[5],
  char_T wname[5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3,
  char_T b_dim4);
static __global__ void ec_cwtAvg_kernel87(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel88(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel89(const int32_T i, real_T interval[650]);
static __global__ void ec_cwtAvg_kernel9(emxArray_real_T fb_Omega);
static __global__ void ec_cwtAvg_kernel90(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel91(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel92(const int32_T i, real_T interval[650]);
static __global__ void ec_cwtAvg_kernel93(emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel94(const emxArray_real_T y, const real_T
  r, const int32_T b, emxArray_real_T b_y);
static __global__ void ec_cwtAvg_kernel95(const emxArray_real_T y, const real_T
  halfh, const int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ec_cwtAvg_kernel96(const int32_T b, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel97(const real_T interval[650], const
  int32_T b, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel98(const real_T x_data[9735], const
  int32_T b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwtAvg_kernel99(const int32_T b, real_T fx_data[9735]);
static void ec_cwtAvg_once();
static void emlrtExitTimeCleanupDtorFcn(const void *r);
static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
  emxArray_real32_T *y);
static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
  emxArray_char_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_char_T *y);
static real_T emlrt_marshallIn(const mxArray *a__output_of_length_, const char_T
  *identifier);
static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static void emlrt_marshallOut(const emxArray_real32_T *u, const mxArray *y);
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
  emxArray_creal32_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
  emxArray_real32_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu, boolean_T needsCopy);
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
static void gpuEmxReset_creal32_T(emxArray_creal32_T *gpu);
static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);
static void gpuEmxReset_real32_T(emxArray_real32_T *gpu);
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu);
static const mxArray *length(const mxArray *m1, emlrtMCInfo *location);
static void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
  const char_T *errorName, const char_T *errorString);
static real_T rt_powd_snf(real_T u0, real_T u1);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_char_T *ret)
{
  static const int32_T dims[2]{ 1, -1 };

  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{ false, true };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U, (
    const void *)&dims[0], &bv[0], &iv[0]);
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_char_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, &ret->data[0], 1, false);
  emlrtDestroyArray(&src);
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

static real_T (*b_emlrt_marshallIn(const mxArray *b_nullptr, const char_T
  *identifier))[2]
{
  emlrtMsgIdentifier thisId;
  real_T (*y)[2];
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
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

static void b_raiseCudaError(int32_T errCode, const char_T *file, uint32_T
  b_line, const char_T *errorName, const char_T *errorString)
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
  emlrtCUDAError(static_cast<uint32_T>(errCode), (char_T *)errorName, (char_T *)
                 errorString, &rtInfo, emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in3_idx_0 = in3->size[1];
  i = in1->size[0] * in1->size[1];
  if (in3_idx_0 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3_idx_0;
  }

  in1->size[1] = in2->size[1];
  emxEnsureCapacity_real32_T(in1, i, &jb_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3_idx_0 != 1);
  for (i = 0; i < in2->size[1]; i++) {
    int32_T b;
    if (in3_idx_0 == 1) {
      b = in2->size[0];
    } else {
      b = in3_idx_0;
    }

    for (int32_T i1{0}; i1 < b; i1++) {
      in1->data[i1 + in1->size[0] * i] = in2->data[i1 * stride_0_0 + in2->size[0]
        * i] / in3->data[i1 * stride_1_0];
    }
  }
}

static void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &p_emlrtRTEI);
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

static void binary_expand_op_3(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &o_emlrtRTEI);
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

static void binary_expand_op_4(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &q_emlrtRTEI);
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
      in1->data[i1 + in1->size[0] * i] = 5.43656365691809 * in2->data[i1 *
        stride_0_0 + in2->size[0] * aux_0_1] * static_cast<real_T>(in3->data[i1 *
        stride_1_0 + in3->size[0] * aux_1_1] < 0.99999999999999978);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void binary_expand_op_5(real_T in1_data[], int32_T in1_size[2], const
  real_T in2_data[], const int32_T in2_size[2], const real_T in3_data[], const
  int32_T in3_size[2], const real_T in4_data[], const int32_T in4_size[2])
{
  int32_T stride_0_1;
  int32_T stride_1_1;
  in1_size[0] = 1;
  in1_size[1] = in4_size[1];
  stride_0_1 = (in2_size[1] != 1);
  stride_1_1 = (in3_size[1] != 1);
  for (int32_T i{0}; i < in4_size[1]; i++) {
    in1_data[i] = in2_data[i * stride_0_1] * in3_data[i * stride_1_1] *
      in4_data[i];
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

static void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T
  b_line)
{
  if (errCode != cudaSuccess) {
    b_raiseCudaError(errCode, file, b_line, cudaGetErrorName(errCode),
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

static uint64_T computeNumIters(int32_T ub, int32_T b_ub)
{
  uint64_T n;
  uint64_T numIters;
  n = 0UL;
  if (ub >= 0) {
    n = static_cast<uint64_T>(ub + 1);
  }

  numIters = n;
  n = 0UL;
  if (b_ub >= 0) {
    n = static_cast<uint64_T>(b_ub + 1);
  }

  numIters *= n;
  return numIters;
}

static void cublasCheck(cublasStatus_t errCode, const char_T *file, uint32_T
  b_line)
{
  const char *errName;
  const char *errString;
  if (errCode != CUBLAS_STATUS_SUCCESS) {
    cublasGetErrorName(errCode, &errName);
    cublasGetErrorString(errCode, &errString);
    raiseCudaError(errCode, file, b_line, errName, errString);
  }
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel1(const char_T
  cv[128], char_T wname[5], char_T wav[5], char_T b_dim0, char_T b_dim1, char_T
  b_dim2, char_T b_dim3, char_T b_dim4)
{
  __shared__ char_T b_shared[5];
  int32_T k;
  if (mwGetThreadIndexWithinBlock() == 0U) {
    b_shared[0] = b_dim0;
    b_shared[1] = b_dim1;
    b_shared[2] = b_dim2;
    b_shared[3] = b_dim3;
    b_shared[4] = b_dim4;
  }

  __syncthreads();
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 5) {
    wav[k] = cv[static_cast<int32_T>(b_shared[k])];
    wname[k] = cv[static_cast<int32_T>(cv[static_cast<int32_T>(b_shared[k])])];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel10(const
  emxArray_real_T omega_tmp2, const int32_T b, emxArray_real_T fb_Omega)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fb_Omega.data[j2 + 1] = omega_tmp2.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel100(const
  real_T x_data[9735], const int32_T b, real_T dv15_data[9735])
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
    dv15_data[k] = pow(x_data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel101(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel102(const
  real_T y_data[9735], const int32_T b, real_T b_y_data[9735])
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
    b_y_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel103(const
  real_T xt_data[9735], const real_T y_data[9735], const real_T dv15_data[9735],
  const int32_T dv15_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv15_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fx_data[j2] = dv15_data[j2] * y_data[j2] * xt_data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel104(const
  real_T interval[650], const int32_T b, real_T subs[1298])
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
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel105(const
  real_T x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T d;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = x_data[k];
    tkd1mtk = d / (1.0 - d);
    b_x_data[k] = tkd1mtk * tkd1mtk;
    xt_data[k] = 2.0 * tkd1mtk / ((1.0 - d) * (1.0 - d));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel106(const
  int32_T b, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fx_data[j2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel107(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 19.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel108(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel109(const
  real_T y_data[9735], const real_T b_y_data[9735], const int32_T y_size, real_T
  a_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    a_data[j2] = 20.0 * b_y_data[j2] - 3.0 * y_data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel11(const
  int32_T nrefine, const int32_T i, const emxArray_real_T omega_tmp2, const
  int32_T nx, emxArray_real_T fb_Omega, int32_T omega_tmp2_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fb_Omega.data[(j2 + omega_tmp2_dim1) + 1] = -omega_tmp2.data[i + nrefine *
      j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel110(const
  real_T a_data[9735], const int32_T b, real_T dv11_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a_data[k];
    dv11_data[k] = d * d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel111(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel112(const
  real_T y_data[9735], const int32_T b, real_T b_y_data[9735])
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
    b_y_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel113(const
  real_T xt_data[9735], const real_T y_data[9735], const real_T dv11_data[9735],
  const int32_T dv11_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv11_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fx_data[j2] = dv11_data[j2] * y_data[j2] * xt_data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel114(const
  int32_T b, emxArray_int32_T omega_tmp1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    omega_tmp1.data[j2] = j2 + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel115(const
  real_T interval[650], const int32_T b, real_T subs[1298])
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
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel116(const
  real_T x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T d;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = x_data[k];
    tkd1mtk = d / (1.0 - d);
    b_x_data[k] = tkd1mtk * tkd1mtk;
    xt_data[k] = 2.0 * tkd1mtk / ((1.0 - d) * (1.0 - d));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel117(const
  int32_T b, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fx_data[j2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel118(const
  real_T x_data[9735], const int32_T b, real_T dv10_data[9735])
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
    dv10_data[k] = pow(x_data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel119(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 3.0);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel12
  (emxArray_real_T y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel120(const
  real_T y_data[9735], const int32_T b, real_T b_y_data[9735])
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
    b_y_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel121(const
  real_T xt_data[9735], const real_T y_data[9735], const real_T dv10_data[9735],
  const int32_T dv10_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv10_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fx_data[j2] = dv10_data[j2] * y_data[j2] * xt_data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel122(const
  real_T interval[650], const int32_T b, real_T subs[1298])
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
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel123(const
  real_T x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T d;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = x_data[k];
    tkd1mtk = d / (1.0 - d);
    b_x_data[k] = tkd1mtk * tkd1mtk;
    xt_data[k] = 2.0 * tkd1mtk / ((1.0 - d) * (1.0 - d));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel124(const
  int32_T b, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fx_data[j2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel125(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 19.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel126(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel127(const
  real_T y_data[9735], const real_T b_y_data[9735], const int32_T y_size, real_T
  a_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    a_data[j2] = 20.0 * b_y_data[j2] - 3.0 * y_data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel128(const
  real_T a_data[9735], const int32_T b, real_T dv4_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a_data[k];
    dv4_data[k] = d * d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel129(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel13(const
  emxArray_real_T y, const real_T tol, const int32_T b, emxArray_real_T b_y)
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
    b_y.data[k] = pow(tol, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel130(const
  real_T y_data[9735], const int32_T b, real_T b_y_data[9735])
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
    b_y_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel131(const
  real_T xt_data[9735], const real_T y_data[9735], const real_T dv4_data[9735],
  const int32_T dv4_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fx_data[j2] = dv4_data[j2] * y_data[j2] * xt_data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel14(const
  emxArray_real_T y, const real_T halfh, const int32_T b_y, emxArray_real_T
  fb_Scales)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fb_Scales.data[j2] = halfh * y.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel15(const
  emxArray_real_T somega, const int32_T b, emxArray_real_T absomega)
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
    absomega.data[k] = fabs(somega.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel16(const
  emxArray_real_T absomega, const int32_T b_absomega, emxArray_real_T powscales)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_absomega);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    powscales.data[j2] = absomega.data[j2] * absomega.data[j2] *
      absomega.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel17(const
  int32_T b, emxArray_real_T absomega)
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
    absomega.data[k] = log(absomega.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel18(const
  emxArray_real_T powscales, const emxArray_real_T absomega, const int32_T
  b_absomega, emxArray_real_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_absomega);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    x.data[j2] = 20.0 * absomega.data[j2] - powscales.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel19(const
  int32_T b, emxArray_real_T x)
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
    x.data[k] = exp(x.data[k]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel2(real_T
  interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel20(const
  emxArray_real_T somega, const emxArray_real_T x, const int32_T b_x,
  emxArray_real_T daughter)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    daughter.data[j2] = 0.0050536085896138528 * x.data[j2] * static_cast<real_T>
      (somega.data[j2] > 0.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel21(const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    f.data[j2] = 1.8820720577620569 / fb_Scales.data[j2] / 6.2831853071795862;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel22(const
  real_T fs, const int32_T i, emxArray_real_T f)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    f.data[j2] *= fs;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel23(const
  emxArray_real_T f, const int32_T b_f, emxArray_real_T freqs)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_f);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    freqs.data[j2] = f.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel24(const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, emxArray_real32_T Scales)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    Scales.data[j2] = static_cast<real32_T>(fb_Scales.data[j2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel25(const
  emxArray_real_T daughter, const int32_T b_daughter, emxArray_real32_T psihat)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_daughter);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    psihat.data[j2] = static_cast<real32_T>(daughter.data[j2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel26(const
  int32_T i, const emxArray_real32_T x, const int32_T b_x, emxArray_real32_T xv,
  int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    xv.data[j2] = x.data[j2 + x_dim0 * (i - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel27(const
  int32_T i, const emxArray_real32_T x, const int32_T b, emxArray_real32_T b_x,
  int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    b_x.data[j2] = x.data[j2 + x_dim0 * (i - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel28(const
  real_T y, const int32_T b, emxArray_real32_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T acoef;
    int32_T j2;
    real32_T xtmp;
    acoef = static_cast<int32_T>(idx);
    j2 = (static_cast<int32_T>(y) - acoef) - 1;
    xtmp = x.data[acoef];
    x.data[acoef] = x.data[j2];
    x.data[j2] = xtmp;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel29(const
  emxArray_real32_T x, const int32_T b, emxArray_real32_T xv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    xv.data[j2] = x.data[j2];
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwtAvg_kernel3(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel30(const
  emxArray_real32_T xv, const int32_T b_xv, emxArray_creal32_T xposdft)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    xposdft.data[j2].re = xv.data[j2];
    xposdft.data[j2].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel31(const
  emxArray_creal32_T xposdft, const emxArray_real32_T psihat, const int32_T
  bcoef, const int32_T cfsposdft, const int32_T i, emxArray_creal32_T
  b_cfsposdft, int32_T psihat_dim0, int32_T cfsposdft_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(i) + 1UL) * (static_cast<uint64_T>(cfsposdft)
    + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
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

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel32(const
  int32_T xSize, emxArray_creal32_T cfspos)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xSize);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    cfspos.data[j2].re = 0.0F;
    cfspos.data[j2].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel33(const
  emxArray_creal32_T cfspos, const int32_T b, emxArray_real32_T y)
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
    y.data[k] = hypotf(cfspos.data[k].re, cfspos.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel34(const
  emxArray_real32_T y, const int32_T b, emxArray_real32_T abscfssq)
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
    abscfssq.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel35(const
  emxArray_real32_T abscfssq, const int32_T b_abscfssq, emxArray_real32_T a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_abscfssq);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    a.data[j2] = abscfssq.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel36(const
  emxArray_real32_T Scales, const emxArray_real32_T a, const int32_T nrefine,
  const int32_T abscfssq, const int32_T i, emxArray_real32_T b_abscfssq, int32_T
  a_dim0, int32_T Scales_dim1, int32_T abscfssq_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(i) + 1UL) * (static_cast<uint64_T>(abscfssq)
    + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_k;
    int32_T k;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(abscfssq) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) / (static_cast<
      uint64_T>(abscfssq) + 1UL));
    b_abscfssq.data[b_k + abscfssq_dim0 * k] = a.data[static_cast<int32_T>
      (a_dim0 != 1) * b_k + a_dim0 * (nrefine * k)] / Scales.data
      [static_cast<int32_T>(Scales_dim1 != 1) * b_k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel37(const
  int32_T abscfssq, emxArray_real32_T z)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abscfssq);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    z.data[j2] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel38(const
  emxArray_uint32_T y, const int32_T b, emxArray_real_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    c.data[j2] = static_cast<real_T>(y.data[0]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel39(const
  emxArray_uint32_T y, emxArray_real_T c, real_T *r)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *r = 0.5 * static_cast<real_T>(y.data[0]);
    c.data[0] = *r;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel4(const int32_T
  i, real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel40(const real_T *
  r, emxArray_real_T c, int32_T abscfssq_dim1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[abscfssq_dim1 - 1] = *r;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel41(const
  int32_T b, emxArray_real32_T z)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T acoef;
    acoef = static_cast<int32_T>(idx);
    z.data[acoef] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel42(const
  real32_T xbar, const int32_T b, emxArray_creal32_T cfspos)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    cfspos.data[j2].re *= xbar;
    cfspos.data[j2].im *= xbar;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel43(const
  emxArray_creal32_T cfspos, const int32_T b, emxArray_real32_T y)
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
    y.data[k] = hypotf(cfspos.data[k].re, cfspos.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel44(const
  emxArray_real32_T y, const int32_T b, emxArray_real32_T abswt2)
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
    abswt2.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel45(const
  emxArray_real32_T Scales, const emxArray_real32_T abswt2, const int32_T
  b_abswt2, const int32_T c_abswt2, emxArray_real32_T abswt2S, int32_T
  abswt2S_dim0, int32_T abswt2_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_abswt2) + 1UL) * (static_cast<uint64_T>
    (b_abswt2) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T acoef;
    int32_T j2;
    acoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_abswt2) + 1UL));
    j2 = static_cast<int32_T>((idx - static_cast<uint64_T>(acoef)) / (
      static_cast<uint64_T>(b_abswt2) + 1UL));
    abswt2S.data[acoef + abswt2S_dim0 * j2] = abswt2.data[acoef + abswt2_dim0 *
      j2] / Scales.data[acoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel46(const
  emxArray_real32_T abswt2S, const int32_T b, const int32_T b_abswt2S,
  emxArray_real32_T y, int32_T y_dim0, int32_T abswt2S_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_abswt2S) + 1UL) * (static_cast<uint64_T>(b)
    + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T acoef;
    int32_T j2;
    acoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    j2 = static_cast<int32_T>((idx - static_cast<uint64_T>(acoef)) / (
      static_cast<uint64_T>(b) + 1UL));
    y.data[acoef + y_dim0 * j2] = abswt2S.data[acoef + abswt2S_dim0 * j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel47(const
  int32_T abswt2S, emxArray_real32_T savgpTMP)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abswt2S);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    savgpTMP.data[j2] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel48(const
  emxArray_real32_T Scales, const int32_T b, emxArray_real32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    c.data[j2] = Scales.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel49(const int32_T
  outsize_idx_0, const emxArray_real32_T Scales, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    real32_T xbar;
    xbar = 0.5F * Scales.data[0];
    c.data[0] = xbar;
    c.data[outsize_idx_0 - 1] = xbar;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel5(real_T
  interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel50(const
  emxArray_real32_T Scales, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = 0.5F * (Scales.data[1] - Scales.data[0]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel51(const
  emxArray_real32_T Scales, const int32_T b, emxArray_real32_T c)
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
    c.data[k + 1] = 0.5F * (Scales.data[k + 2] - Scales.data[k]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel52(const
  emxArray_real32_T Scales, const int32_T outsize_idx_0, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[outsize_idx_0 - 1] = 0.5F * (Scales.data[outsize_idx_0 - 1] -
      Scales.data[outsize_idx_0 - 2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel53(const
  emxArray_real32_T Scales, const int32_T b, emxArray_real32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    c.data[j2] = Scales.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel54(const
  real32_T xbar, emxArray_real32_T c, int32_T z_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = xbar;
    c.data[z_dim0 - 1] = xbar;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel55(const
  emxArray_real32_T Scales, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = 0.5F * (Scales.data[1] - Scales.data[0]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel56(const
  emxArray_real32_T Scales, const int32_T b, emxArray_real32_T c)
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
    c.data[k + 1] = 0.5F * (Scales.data[k + 2] - Scales.data[k]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel57(const
  emxArray_real32_T Scales, emxArray_real32_T c, int32_T z_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[z_dim0 - 1] = 0.5F * (Scales.data[z_dim0 - 1] - Scales.data[z_dim0 -
      2]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel58(const
  emxArray_uint32_T y, emxArray_real_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = 0.5 * static_cast<real_T>(static_cast<int32_T>(y.data[1]) -
      static_cast<int32_T>(y.data[0]));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel59(const
  emxArray_uint32_T y, const int32_T b, emxArray_real_T c)
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
    c.data[k + 1] = 0.5 * static_cast<real_T>(static_cast<int32_T>(y.data[k + 2])
      - static_cast<int32_T>(y.data[k]));
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwtAvg_kernel6(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel60(const
  emxArray_uint32_T y, emxArray_real_T c, int32_T abscfssq_dim1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[abscfssq_dim1 - 1] = 0.5 * static_cast<real_T>(static_cast<int32_T>
      (y.data[abscfssq_dim1 - 1]) - static_cast<int32_T>(y.data[abscfssq_dim1 -
      2]));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel61(const
  int32_T b, emxArray_uint32_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    y.data[j2] = static_cast<uint32_T>(j2) + 1U;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel62(real_T
  interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = -1.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwtAvg_kernel63(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel64(const int32_T
  i, real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel65(const
  real_T interval[650], const int32_T b, real_T subs[1298])
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
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel66(const
  real_T x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T d;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = x_data[k];
    tkd1mtk = d * d;
    b_x_data[k] = 0.29999999999999982 * d * (3.0 - tkd1mtk) + 5.0;
    xt_data[k] = 0.89999999999999947 * (1.0 - tkd1mtk);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel67(const
  int32_T b, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fx_data[j2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel68(const
  real_T x_data[9735], const int32_T x_size, real_T a_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    a_data[j2] = (x_data[j2] - 5.0) / 0.6;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel69(const
  real_T a_data[9735], const int32_T b, real_T y_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T d;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = a_data[k];
    y_data[k] = d * d;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel7(const int32_T
  i, real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel70(const
  real_T y_data[9735], const int32_T b, real_T x_data[9735])
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
    x_data[k] = exp(-2.0 * (1.0 / (1.0 - y_data[k])));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel71(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    y_data[j2] = 14.7781121978613 * x_data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel72(const
  real_T y_data[9735], const int32_T b, real_T b_y_data[9735])
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
    b_y_data[k] = y_data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel73(const
  real_T xt_data[9735], const real_T x_data[9735], const real_T y_data[9735],
  const int32_T y_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fx_data[j2] = y_data[j2] / x_data[j2] * xt_data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel74(const
  real32_T cfsposdft_re, const emxArray_creal32_T cfsposdft, const int32_T
  b_cfsposdft, emxArray_creal32_T cfspos)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfsposdft);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    real32_T ai;
    real32_T xtmp;
    j2 = static_cast<int32_T>(idx);
    xtmp = cfsposdft.data[j2].re;
    ai = cfsposdft.data[j2].im;
    if (ai == 0.0F) {
      cfspos.data[j2].re = xtmp / cfsposdft_re;
      cfspos.data[j2].im = 0.0F;
    } else if (xtmp == 0.0F) {
      cfspos.data[j2].re = 0.0F;
      cfspos.data[j2].im = ai / cfsposdft_re;
    } else {
      cfspos.data[j2].re = xtmp / cfsposdft_re;
      cfspos.data[j2].im = ai / cfsposdft_re;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel75(const
  int32_T b, emxArray_creal32_T xposdft, uint32_T xSize_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T acoef;
    acoef = static_cast<int32_T>(idx);
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - acoef) - 1].re =
      xposdft.data[acoef + 1].re;
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - acoef) - 1].im =
      -xposdft.data[acoef + 1].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel76(const
  emxArray_real_T fb_Omega, const emxArray_real_T fb_Scales, const int32_T
  b_fb_Scales, const int32_T b, emxArray_real_T somega, int32_T somega_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b) + 1UL) * (static_cast<uint64_T>
    (b_fb_Scales) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T acoef;
    int32_T j2;
    acoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fb_Scales) + 1UL));
    j2 = static_cast<int32_T>((idx - static_cast<uint64_T>(acoef)) / (
      static_cast<uint64_T>(b_fb_Scales) + 1UL));
    somega.data[acoef + somega_dim0 * j2] = fb_Scales.data[acoef] *
      fb_Omega.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel77(const
  emxArray_real_T somega, const int32_T b_somega, emxArray_real_T w)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_somega);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    w.data[j2] = (somega.data[j2] - 5.0) / 0.6;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel78(const
  emxArray_real_T w, const int32_T b_w, emxArray_real_T expnt)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_w);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    expnt.data[j2] = -1.0 / (1.0 - w.data[j2] * w.data[j2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel79(const
  int32_T b, emxArray_real_T expnt)
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
    expnt.data[k] = exp(expnt.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel8(const real_T
  fc, const emxArray_int32_T omega_tmp1, const int32_T b_omega_tmp1,
  emxArray_real_T omega_tmp2)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_omega_tmp1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    omega_tmp2.data[j2] = static_cast<real_T>(omega_tmp1.data[j2]) * fc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel80(const
  emxArray_real_T w, const int32_T b, emxArray_real_T y)
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
    y.data[k] = fabs(w.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel81(const
  emxArray_real_T y, const emxArray_real_T expnt, const int32_T b_expnt,
  emxArray_real_T daughter)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_expnt);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    daughter.data[j2] = 5.43656365691809 * expnt.data[j2] * static_cast<real_T>
      (y.data[j2] < 0.99999999999999978);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel82(const
  int32_T nrefine, emxArray_real_T daughter)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T acoef;
    acoef = static_cast<int32_T>(idx);
    if (isnan(daughter.data[acoef])) {
      daughter.data[acoef] = 0.0;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel83(const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    f.data[j2] = 0.79577471545947676 / fb_Scales.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel84(const
  emxArray_real_T fb_Omega, const emxArray_real_T fb_Scales, const int32_T
  b_fb_Scales, const int32_T b, emxArray_real_T somega, int32_T somega_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b) + 1UL) * (static_cast<uint64_T>
    (b_fb_Scales) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T acoef;
    int32_T j2;
    acoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fb_Scales) + 1UL));
    j2 = static_cast<int32_T>((idx - static_cast<uint64_T>(acoef)) / (
      static_cast<uint64_T>(b_fb_Scales) + 1UL));
    somega.data[acoef + somega_dim0 * j2] = fb_Scales.data[acoef] *
      fb_Omega.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel85(const
  int32_T b, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    y.data[j2] = static_cast<real_T>(j2);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel86(const char_T
  cv[128], char_T wav[5], char_T wname[5], char_T b_dim0, char_T b_dim1, char_T
  b_dim2, char_T b_dim3, char_T b_dim4)
{
  __shared__ char_T b_shared[5];
  int32_T k;
  if (mwGetThreadIndexWithinBlock() == 0U) {
    b_shared[0] = b_dim0;
    b_shared[1] = b_dim1;
    b_shared[2] = b_dim2;
    b_shared[3] = b_dim3;
    b_shared[4] = b_dim4;
  }

  __syncthreads();
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 5) {
    wname[k] = cv[static_cast<int32_T>(b_shared[k])];
    wav[k] = cv[static_cast<int32_T>(cv[static_cast<int32_T>(b_shared[k])])];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel87(real_T
  interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwtAvg_kernel88(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel89(const int32_T
  i, real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel9
  (emxArray_real_T fb_Omega)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    fb_Omega.data[0] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel90(real_T
  interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwtAvg_kernel91(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel92(const int32_T
  i, real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel93
  (emxArray_real_T y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel94(const
  emxArray_real_T y, const real_T r, const int32_T b, emxArray_real_T b_y)
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
    b_y.data[k] = pow(r, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel95(const
  emxArray_real_T y, const real_T halfh, const int32_T b_y, emxArray_real_T
  fb_Scales)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fb_Scales.data[j2] = halfh * y.data[j2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel96(const
  int32_T b, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    y.data[j2] = static_cast<real_T>(j2);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel97(const
  real_T interval[650], const int32_T b, real_T subs[1298])
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
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel98(const
  real_T x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T d;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    d = x_data[k];
    tkd1mtk = d / (1.0 - d);
    b_x_data[k] = tkd1mtk * tkd1mtk;
    xt_data[k] = 2.0 * tkd1mtk / ((1.0 - d) * (1.0 - d));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel99(const
  int32_T b, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T j2;
    j2 = static_cast<int32_T>(idx);
    fx_data[j2] = 0.0;
  }
}

static void ec_cwtAvg_once()
{
  mex_InitInfAndNan();
  checkCudaError(mwCudaMalloc(&global_gpu_cv, sizeof(char_T [128])), __FILE__,
                 __LINE__);
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

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = c_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
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

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_char_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(char_T));
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(creal32_T));
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(int32_T));
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(real32_T));
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(real_T));
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(uint32_T));
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
  emxArray_creal32_T *gpu, boolean_T needsCopy)
{
  creal32_T *newData;
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(static_cast<uint32_T>
      (gpu->numDimensions), sizeof(int32_T)));
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

    checkCudaError(mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof
      (creal32_T)), __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(cudaMemcpy(newData, gpu->data, static_cast<uint32_T>
        (totalSizeGpu) * sizeof(creal32_T), cudaMemcpyDeviceToDevice), __FILE__,
                     __LINE__);
    }

    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }

    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu, boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  int32_T *newData;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(static_cast<uint32_T>
      (gpu->numDimensions), sizeof(int32_T)));
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

    checkCudaError(mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof
      (int32_T)), __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(cudaMemcpy(newData, gpu->data, static_cast<uint32_T>
        (totalSizeGpu) * sizeof(int32_T), cudaMemcpyDeviceToDevice), __FILE__,
                     __LINE__);
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
  emxArray_real32_T *gpu, boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  real32_T *newData;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(static_cast<uint32_T>
      (gpu->numDimensions), sizeof(int32_T)));
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

    checkCudaError(mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof
      (real32_T)), __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(cudaMemcpy(newData, gpu->data, static_cast<uint32_T>
        (totalSizeGpu) * sizeof(real32_T), cudaMemcpyDeviceToDevice), __FILE__,
                     __LINE__);
    }

    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }

    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu, boolean_T needsCopy)
{
  real_T *newData;
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(static_cast<uint32_T>
      (gpu->numDimensions), sizeof(int32_T)));
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

    checkCudaError(mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof
      (real_T)), __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(cudaMemcpy(newData, gpu->data, static_cast<uint32_T>
        (totalSizeGpu) * sizeof(real_T), cudaMemcpyDeviceToDevice), __FILE__,
                     __LINE__);
    }

    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }

    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu, boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  uint32_T *newData;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(static_cast<uint32_T>
      (gpu->numDimensions), sizeof(int32_T)));
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

    checkCudaError(mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof
      (uint32_T)), __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(cudaMemcpy(newData, gpu->data, static_cast<uint32_T>
        (totalSizeGpu) * sizeof(uint32_T), cudaMemcpyDeviceToDevice), __FILE__,
                     __LINE__);
    }

    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }

    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }

  emlrtFreeMex(gpu->size);
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

static void gpuEmxFree_real_T(emxArray_real_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }

  emlrtFreeMex(gpu->size);
}

static void gpuEmxFree_uint32_T(emxArray_uint32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }

  emlrtFreeMex(gpu->size);
}

static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu, const
  emxArray_creal32_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(creal32_T), cudaMemcpyHostToDevice), __FILE__,
                 __LINE__);
}

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu, const
  emxArray_real32_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(real32_T), cudaMemcpyHostToDevice), __FILE__, __LINE__);
}

static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu, const
  emxArray_real_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(real_T), cudaMemcpyHostToDevice), __FILE__, __LINE__);
}

static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
  emxArray_creal32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(creal32_T), cudaMemcpyDeviceToHost), __FILE__,
                 __LINE__);
}

static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
  emxArray_real32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(real32_T), cudaMemcpyDeviceToHost), __FILE__, __LINE__);
}

static void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T
  *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(real_T), cudaMemcpyDeviceToHost), __FILE__, __LINE__);
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

static void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
  const char_T *errorName, const char_T *errorString)
{
  emlrtRTEInfo rtInfo;
  uint64_T len;
  char_T *brk;
  char_T *fn;
  char_T *pn;
  len = strlen(file);
  pn = static_cast<char_T *>(std::calloc(static_cast<uint32_T>(len + 1UL), 1U));
  fn = static_cast<char_T *>(std::calloc(static_cast<uint32_T>(len + 1UL), 1U));
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
  emlrtCUDAError(static_cast<uint32_T>(errCode), (char_T *)errorName, (char_T *)
                 errorString, &rtInfo, emlrtRootTLSGlobal);
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
void ec_cwtAvg(ec_cwtAvgStackData *SD, const emxArray_real32_T *cpu_x, real_T fs,
               real_T fLims[2], real_T fOctave, emxArray_real_T *cpu_freqs)
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

  static const int32_T iv[2]{ 1, 7 };

  static const int32_T iv1[2]{ 1, 2 };

  static const int32_T iv2[2]{ 1, 7 };

  static const int32_T iv3[2]{ 1, 5 };

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

  static const char_T b[10]{ 'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o', 'n' };

  static const char_T cv1[10]{ 'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o', 'n'
  };

  static const char_T u[7]{ 's', 'p', 'r', 'i', 'n', 't', 'f' };

  static const char_T b_formatSpec[5]{ '%', '2', '.', '2', 'f' };

  static const char_T c_b[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T cv2[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T cv3[5]{ 'm', 'o', 'r', 's', 'e' };

  static const char_T d_b[5]{ 'm', 'o', 'r', 's', 'e' };

  static const char_T formatSpec[2]{ '%', 'f' };

  dim3 block;
  dim3 grid;
  emxArray_char_T *d_tmpStr;
  emxArray_char_T *tmpStr;
  emxArray_creal32_T gpu_cfspos;
  emxArray_creal32_T gpu_cfsposdft;
  emxArray_creal32_T gpu_xposdft;
  emxArray_creal32_T *cpu_cfspos;
  emxArray_creal32_T *cpu_cfsposdft;
  emxArray_creal32_T *cpu_xposdft;
  emxArray_int32_T gpu_omega_tmp1;
  emxArray_int32_T *cpu_omega_tmp1;
  emxArray_real32_T b_gpu_c;
  emxArray_real32_T b_gpu_x;
  emxArray_real32_T c_gpu_c;
  emxArray_real32_T c_gpu_x;
  emxArray_real32_T c_gpu_y;
  emxArray_real32_T e_gpu_y;
  emxArray_real32_T f_gpu_y;
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
  emxArray_real32_T *c_cpu_c;
  emxArray_real32_T *c_cpu_x;
  emxArray_real32_T *cpu_Scales;
  emxArray_real32_T *cpu_a;
  emxArray_real32_T *cpu_abscfssq;
  emxArray_real32_T *cpu_abswt2;
  emxArray_real32_T *cpu_abswt2S;
  emxArray_real32_T *cpu_psihat;
  emxArray_real32_T *cpu_savgpTMP;
  emxArray_real32_T *cpu_xv;
  emxArray_real32_T *cpu_z;
  emxArray_real32_T *f_cpu_y;
  emxArray_real32_T *h_cpu_y;
  emxArray_real32_T *i_cpu_y;
  emxArray_real_T b_gpu_somega;
  emxArray_real_T b_gpu_y;
  emxArray_real_T g_gpu_y;
  emxArray_real_T gpu_absomega;
  emxArray_real_T gpu_c;
  emxArray_real_T gpu_daughter;
  emxArray_real_T gpu_expnt;
  emxArray_real_T gpu_f;
  emxArray_real_T gpu_fb_Omega;
  emxArray_real_T gpu_fb_Scales;
  emxArray_real_T gpu_freqs;
  emxArray_real_T gpu_omega_tmp2;
  emxArray_real_T gpu_powscales;
  emxArray_real_T gpu_somega;
  emxArray_real_T gpu_w;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_y;
  emxArray_real_T h_gpu_y;
  emxArray_real_T i_gpu_y;
  emxArray_real_T *b_cpu_somega;
  emxArray_real_T *b_cpu_x;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_absomega;
  emxArray_real_T *cpu_c;
  emxArray_real_T *cpu_daughter;
  emxArray_real_T *cpu_expnt;
  emxArray_real_T *cpu_f;
  emxArray_real_T *cpu_fb_Omega;
  emxArray_real_T *cpu_fb_Scales;
  emxArray_real_T *cpu_omega_tmp2;
  emxArray_real_T *cpu_powscales;
  emxArray_real_T *cpu_somega;
  emxArray_real_T *cpu_w;
  emxArray_real_T *cpu_y;
  emxArray_real_T *d_cpu_y;
  emxArray_real_T *e_cpu_y;
  emxArray_uint32_T d_gpu_y;
  emxArray_uint32_T *g_cpu_y;
  const mxArray *b_tmpStr;
  const mxArray *b_y;
  const mxArray *c_tmpStr;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *f_y;
  const mxArray *g_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *m4;
  const mxArray *m5;
  int64_T d;
  real_T cpu_dv11_data[9735];
  real_T cpu_fx_data[9735];
  real_T (*b_gpu_a_data)[9735];
  real_T (*b_gpu_fx_data)[9735];
  real_T (*b_gpu_x_data)[9735];
  real_T (*b_gpu_y_data)[9735];
  real_T (*c_gpu_fx_data)[9735];
  real_T (*d_gpu_fx_data)[9735];
  real_T (*e_gpu_fx_data)[9735];
  real_T (*gpu_a_data)[9735];
  real_T (*gpu_dv10_data)[9735];
  real_T (*gpu_dv11_data)[9735];
  real_T (*gpu_dv15_data)[9735];
  real_T (*gpu_dv4_data)[9735];
  real_T (*gpu_fx_data)[9735];
  real_T (*gpu_x_data)[9735];
  real_T (*gpu_xt_data)[9735];
  real_T (*gpu_y_data)[9735];
  real_T cpu_subs[1298];
  real_T (*gpu_subs)[1298];
  real_T cpu_interval[650];
  real_T (*gpu_interval)[650];
  real_T errsub[649];
  real_T qsub[649];
  real_T NyquistRange[2];
  real_T a;
  real_T b_m;
  real_T b_r;
  real_T cpu_r;
  real_T err_ok;
  real_T fb_VoicesPerOctave;
  real_T fc;
  real_T halfh;
  real_T intDsq;
  real_T intFsq;
  real_T omegac;
  real_T q_ok;
  real_T r;
  real_T s;
  real_T tol;
  real_T toler;
  real_T y;
  real_T *gpu_r;
  int32_T a_size[2];
  int32_T b_a_size[2];
  int32_T b_xt_size[2];
  int32_T dv11_size[2];
  int32_T dv13_size[2];
  int32_T dv4_size[2];
  int32_T dv7_size[2];
  int32_T fx_size[2];
  int32_T xt_size[2];
  int32_T b_eint;
  int32_T bcoef;
  int32_T c_eint;
  int32_T eint;
  int32_T exitg1;
  int32_T fb_CutOff;
  int32_T i;
  int32_T i34;
  int32_T ix;
  int32_T j2;
  int32_T lidx;
  int32_T nrefine;
  int32_T nsubs;
  int32_T nx;
  int32_T outsize_idx_0;
  real32_T cpu_t;
  real32_T *gpu_t;
  uint32_T xSize[2];
  uint32_T N;
  uint32_T nChs;
  char_T cpu_wav[5];
  char_T cpu_wname[5];
  char_T wavname[5];
  char_T (*gpu_wav)[5];
  char_T (*gpu_wname)[5];
  int8_T n_idx_0;
  boolean_T b_b[2];
  boolean_T abswt2S_outdatedOnCpu;
  boolean_T b_fx_data_outdatedOnCpu;
  boolean_T b_y_needsGpuEnsureCapacity;
  boolean_T c_omega_tmp1_needsGpuEnsureCapa;
  boolean_T c_y_needsGpuEnsureCapacity;
  boolean_T daughter_needsGpuEnsureCapacity;
  boolean_T daughter_outdatedOnGpu;
  boolean_T exitg2;
  boolean_T fb_Omega_outdatedOnCpu;
  boolean_T first_iteration;
  boolean_T fx_data_outdatedOnCpu;
  boolean_T guard1;
  boolean_T interval_outdatedOnGpu;
  boolean_T subs_outdatedOnCpu;
  boolean_T validLaunchParams;
  boolean_T wav_outdatedOnCpu;
  boolean_T x_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  if (!gpuConstsCopied_ec_cwtAvg) {
    gpuConstsCopied_ec_cwtAvg = true;
    checkCudaError(cudaMemcpy(*global_gpu_cv, cpu_cv, sizeof(char_T [128]),
      cudaMemcpyHostToDevice), __FILE__, __LINE__);
  }

  checkCudaError(mwCudaMalloc(&gpu_fx_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_t, 4UL), __FILE__, __LINE__);
  gpuEmxReset_real32_T(&b_gpu_c);
  gpuEmxReset_real32_T(&f_gpu_y);
  gpuEmxReset_real32_T(&gpu_abswt2S);
  gpuEmxReset_real32_T(&gpu_abswt2);
  gpuEmxReset_real32_T(&e_gpu_y);
  gpuEmxReset_real32_T(&c_gpu_c);
  gpuEmxReset_real_T(&gpu_c);
  gpuEmxReset_real32_T(&gpu_z);
  gpuEmxReset_uint32_T(&d_gpu_y);
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
  checkCudaError(mwCudaMalloc(&b_gpu_fx_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv11_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv15_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&g_gpu_y);
  gpuEmxReset_real_T(&gpu_x);
  checkCudaError(mwCudaMalloc(&b_gpu_a_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_powscales);
  checkCudaError(mwCudaMalloc(&c_gpu_fx_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_expnt);
  gpuEmxReset_real_T(&gpu_absomega);
  gpuEmxReset_real_T(&gpu_w);
  gpuEmxReset_real_T(&gpu_somega);
  gpuEmxReset_real_T(&b_gpu_somega);
  gpuEmxReset_real_T(&gpu_f);
  gpuEmxReset_real_T(&gpu_daughter);
  checkCudaError(mwCudaMalloc(&d_gpu_fx_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv4_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv10_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&i_gpu_y);
  checkCudaError(mwCudaMalloc(&gpu_a_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&h_gpu_y);
  checkCudaError(mwCudaMalloc(&e_gpu_fx_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&b_gpu_y_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&b_gpu_y);
  checkCudaError(mwCudaMalloc(&gpu_y_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_y);
  checkCudaError(mwCudaMalloc(&gpu_xt_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&b_gpu_x_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_fb_Scales);
  checkCudaError(mwCudaMalloc(&gpu_x_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_subs, 10384UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_fb_Omega);
  checkCudaError(mwCudaMalloc(&gpu_interval, 5200UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_omega_tmp2);
  checkCudaError(mwCudaMalloc(&gpu_wname, 5UL), __FILE__, __LINE__);
  gpuEmxReset_int32_T(&gpu_omega_tmp1);
  checkCudaError(mwCudaMalloc(&gpu_wav, 5UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_r, 8UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_freqs);
  gpuEmxReset_real32_T(&b_gpu_x);
  abswt2S_outdatedOnCpu = false;
  b_fx_data_outdatedOnCpu = false;
  fx_data_outdatedOnCpu = false;
  x_outdatedOnGpu = true;
  c_y_needsGpuEnsureCapacity = true;
  b_y_needsGpuEnsureCapacity = true;
  y_needsGpuEnsureCapacity = true;
  c_omega_tmp1_needsGpuEnsureCapa = true;
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
  if (fLims[0] < 0.001) {
    // 'ec_cwtAvg:18' ;
    // 'ec_cwtAvg:18' fLims(1)=1e-3;
    fLims[0] = 0.001;
  }

  // 'ec_cwtAvg:19' if fLims(2)>fs/2
  if (fLims[1] > fs / 2.0) {
    // 'ec_cwtAvg:19' ;
    // 'ec_cwtAvg:19' fLims(2)=fs/2;
    fLims[1] = fs / 2.0;
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
  lidx = 0;
  do {
    exitg1 = 0;
    if (lidx + 1 < 11) {
      if (cpu_cv[static_cast<int32_T>(b[lidx])] != cpu_cv[static_cast<int32_T>
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
    if (cpu_x->size[0] <= 100000) {
      y = std::floor(static_cast<real_T>(cpu_x->size[0]) / 2.0);
    } else {
      cpu_r = std::frexp(static_cast<real_T>(cpu_x->size[0]), &nrefine);
      if (cpu_r == 0.5) {
        y = static_cast<real_T>(nrefine) - 1.0;
      } else {
        y = std::log(cpu_r) / 0.69314718055994529 + static_cast<real_T>(nrefine);
      }

      y = std::ceil(y);
    }
  } else {
    y = 0.0;
  }

  for (j2 = 0; j2 < 2; j2++) {
    b_b[j2] = std::isnan(fLims[j2]);
  }

  first_iteration = true;
  lidx = 0;
  exitg2 = false;
  while ((!exitg2) && (lidx < 2)) {
    if (!b_b[lidx]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      lidx++;
    }
  }

  if (!first_iteration) {
    real_T freqrange[2];
    real_T cf;
    for (j2 = 0; j2 < 2; j2++) {
      freqrange[j2] = fLims[j2];
    }

    NyquistRange[1] = fs / 2.0;
    emxInit_char_T(&tmpStr, 2, &fc_emlrtRTEI, true);
    if ((fLims[1] <= 0.0) || (fLims[0] >= NyquistRange[1])) {
      b_tmpStr = nullptr;
      b_y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&b_y, m);
      c_y = nullptr;
      m1 = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 2, m1, &formatSpec[0]);
      emlrtAssign(&c_y, m1);
      d_y = nullptr;
      m2 = emlrtCreateDoubleScalar(NyquistRange[1]);
      emlrtAssign(&d_y, m2);
      emlrtAssign(&b_tmpStr, feval(b_y, c_y, d_y, &emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(b_tmpStr), &b_emlrtMCI),
                       "<output of length>");
      emlrt_marshallIn(emlrtAlias(b_tmpStr), "tmpStr", tmpStr);
      emlrtDestroyArray(&b_tmpStr);
    }

    emxFree_char_T(&tmpStr);
    omegac = 3.1415926535897931;
    ec_cwtAvg_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*global_gpu_cv,
      *gpu_wname, *gpu_wav, c_b[0], c_b[1], c_b[2], c_b[3], c_b[4]);
    wav_outdatedOnCpu = true;
    checkCudaError(cudaMemcpy(cpu_wname, *gpu_wname, 5UL, cudaMemcpyDeviceToHost),
                   __FILE__, __LINE__);
    if (cpu_wname[0] == 'm') {
      cf = 1.8820720577620569;
      r = 0.0057083835261;
      cpu_r = 0.0057083835261;
      b_r = 0.0057083835261;
      for (i = 0; i < 6; i++) {
        fc = c[i];
        r = r * 0.005353955978584176 + fc;
        cpu_r = cpu_r * 0.005353955978584176 + fc;
        b_r = b_r * 0.005353955978584176 + fc;
      }

      r /= 13.666666666666666;
      cpu_r /= 13.666666666666666;
      b_r /= 13.666666666666666;
      b_r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((cpu_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(b_r) || std::isnan(b_r)) {
        ec_cwtAvg_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwtAvg_kernel3<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>
          (*gpu_interval);
        interval_outdatedOnGpu = false;
        intDsq = 0.0;
        i = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        nx = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (nx > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            cpu_r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (i = 0; i < nrefine; i++) {
              cpu_interval[n_idx_0 - i] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - i) * cpu_r;
            }
          }

          i = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (nrefine = 0; nrefine < i; nrefine++) {
          if (std::abs(cpu_interval[nrefine + 1] - cpu_interval[lidx]) > 0.0) {
            lidx++;
            cpu_interval[lidx] = cpu_interval[nrefine + 1];
            interval_outdatedOnGpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          ec_cwtAvg_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i,
            *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (nx <= 0) {
          intDsq = rtNaN;
        } else {
          mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel122<<<grid, block>>>(*gpu_interval, nsubs - 1,
              *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            bcoef = 15 * nsubs;
            ix = -1;
            for (lidx = 0; lidx < nsubs; lidx++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              fc = cpu_subs[lidx << 1];
              subs_outdatedOnCpu = false;
              b_r = cpu_subs[(lidx << 1) + 1];
              cpu_r = (fc + b_r) / 2.0;
              halfh = (b_r - fc) / 2.0;
              for (i = 0; i < 15; i++) {
                SD->f0.cpu_x_data[(ix + i) + 1] = NODES[i] * halfh + cpu_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            xt_size[0] = 1;
            xt_size[1] = bcoef;
            mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
              2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel123<<<grid, block>>>(*gpu_x_data, bcoef - 1,
                *gpu_xt_data, *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              cpu_r = std::abs(SD->f0.cpu_x_data[0]);
              lidx = 0;
              exitg2 = false;
              while ((!exitg2) && (lidx <= bcoef - 2)) {
                tol = cpu_r;
                cpu_r = std::abs(SD->f0.cpu_x_data[lidx + 1]);
                if (std::abs(SD->f0.cpu_x_data[lidx + 1] - SD->
                             f0.cpu_x_data[lidx]) <= 2.2204460492503131E-14 *
                    std::fmax(tol, cpu_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  lidx++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid,
                  &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel124<<<grid, block>>>(bcoef - 1, *e_gpu_fx_data);
                }

                exitg1 = 1;
              } else {
                guard1 = true;
              }
            } else {
              guard1 = true;
            }

            if (guard1) {
              first_iteration = false;
              mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel125<<<grid, block>>>(*b_gpu_x_data, bcoef - 1,
                  *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel126<<<grid, block>>>(*b_gpu_x_data, bcoef - 1,
                  *b_gpu_y_data);
              }

              a_size[1] = bcoef;
              mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel127<<<grid, block>>>(*b_gpu_y_data, *gpu_y_data,
                  bcoef - 1, *gpu_a_data);
              }

              dv4_size[0] = 1;
              dv4_size[1] = a_size[1];
              mwGetLaunchParameters1D(computeNumIters(a_size[1] - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel128<<<grid, block>>>(*gpu_a_data, a_size[1] - 1,
                  *gpu_dv4_data);
              }

              mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel129<<<grid, block>>>(*b_gpu_x_data, bcoef - 1,
                  *gpu_y_data);
              }

              dv7_size[0] = 1;
              dv7_size[1] = bcoef;
              mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel130<<<grid, block>>>(*gpu_y_data, bcoef - 1,
                  *b_gpu_y_data);
              }

              if (a_size[1] == bcoef) {
                fx_size[0] = 1;
                fx_size[1] = a_size[1];
                mwGetLaunchParameters1D(computeNumIters(a_size[1] - 1), &grid,
                  &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel131<<<grid, block>>>(*gpu_xt_data,
                    *b_gpu_y_data, *gpu_dv4_data, a_size[1] - 1, *e_gpu_fx_data);
                }

                fx_data_outdatedOnCpu = true;
              } else {
                if (fx_data_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *e_gpu_fx_data,
                    77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                checkCudaError(cudaMemcpy(SD->f0.cpu_dv4_data, *gpu_dv4_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_y_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_xt_data, *gpu_xt_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                binary_expand_op_5(SD->f0.cpu_fx_data, fx_size,
                                   SD->f0.cpu_dv4_data, dv4_size,
                                   SD->f0.cpu_x_data, dv7_size,
                                   SD->f0.cpu_xt_data, xt_size);
                fx_data_outdatedOnCpu = false;
              }

              cpu_r = 0.0;
              ix = -1;
              for (lidx = 0; lidx < nsubs; lidx++) {
                fc = 0.0;
                b_r = 0.0;
                for (i = 0; i < 15; i++) {
                  if (fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *e_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  fc += dv5[i] * SD->f0.cpu_fx_data[(ix + i) + 1];
                  fx_data_outdatedOnCpu = false;
                  b_r += dv6[i] * SD->f0.cpu_fx_data[(ix + i) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                halfh = (cpu_subs[(lidx << 1) + 1] - cpu_subs[lidx << 1]) / 2.0;
                fc *= halfh;
                qsub[lidx] = fc;
                cpu_r += fc;
                errsub[lidx] = b_r * halfh;
              }

              intDsq = cpu_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              cpu_r = 2.0 * tol;
              b_r = 0.0;
              nrefine = 0;
              for (lidx = 0; lidx < nsubs; lidx++) {
                fc = errsub[lidx];
                halfh = std::abs(fc);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (halfh <= cpu_r * ((cpu_subs[(lidx << 1) + 1] - cpu_subs[lidx
                      << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[lidx];
                } else {
                  b_r += halfh;
                  nrefine++;
                  cpu_subs[(nrefine - 1) << 1] = cpu_subs[lidx << 1];
                  cpu_subs[((nrefine - 1) << 1) + 1] = cpu_subs[(lidx << 1) + 1];
                }
              }

              cpu_r = std::abs(err_ok) + b_r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(cpu_r)) && (!std::isnan(cpu_r))) && (nrefine != 0) &&
                  (!(cpu_r <= tol))) {
                nsubs = nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (lidx = 0; lidx < nrefine; lidx++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((nrefine - lidx) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nrefine - lidx) - 1) << 1) + 1];
                    cpu_subs[(((nrefine - lidx) << 1) - 1) << 1] = (cpu_subs
                      [((nrefine - lidx) - 1) << 1] + cpu_subs[(((nrefine - lidx)
                      - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nrefine - lidx) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nrefine - lidx) << 1) - 1) << 1];
                    cpu_subs[(((nrefine - lidx) << 1) - 2) << 1] = cpu_subs
                      [((nrefine - lidx) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        ec_cwtAvg_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwtAvg_kernel6<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>
          (*gpu_interval);
        interval_outdatedOnGpu = false;
        intFsq = 0.0;
        i = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        nx = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (nx > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            cpu_r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (i = 0; i < nrefine; i++) {
              cpu_interval[n_idx_0 - i] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - i) * cpu_r;
            }
          }

          i = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (nrefine = 0; nrefine < i; nrefine++) {
          if (std::abs(cpu_interval[nrefine + 1] - cpu_interval[lidx]) > 0.0) {
            lidx++;
            cpu_interval[lidx] = cpu_interval[nrefine + 1];
            interval_outdatedOnGpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          ec_cwtAvg_kernel7<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i,
            *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (nx <= 0) {
          intFsq = rtNaN;
        } else {
          mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel115<<<grid, block>>>(*gpu_interval, nsubs - 1,
              *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            j2 = 15 * nsubs;
            ix = -1;
            for (lidx = 0; lidx < nsubs; lidx++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              fc = cpu_subs[lidx << 1];
              subs_outdatedOnCpu = false;
              b_r = cpu_subs[(lidx << 1) + 1];
              cpu_r = (fc + b_r) / 2.0;
              halfh = (b_r - fc) / 2.0;
              for (i = 0; i < 15; i++) {
                SD->f0.cpu_x_data[(ix + i) + 1] = NODES[i] * halfh + cpu_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
              2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel116<<<grid, block>>>(*gpu_x_data, j2 - 1,
                *gpu_xt_data, *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              cpu_r = std::abs(SD->f0.cpu_x_data[0]);
              lidx = 0;
              exitg2 = false;
              while ((!exitg2) && (lidx <= j2 - 2)) {
                tol = cpu_r;
                cpu_r = std::abs(SD->f0.cpu_x_data[lidx + 1]);
                if (std::abs(SD->f0.cpu_x_data[lidx + 1] - SD->
                             f0.cpu_x_data[lidx]) <= 2.2204460492503131E-14 *
                    std::fmax(tol, cpu_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  lidx++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                  2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel117<<<grid, block>>>(j2 - 1, *d_gpu_fx_data);
                }

                exitg1 = 1;
              } else {
                guard1 = true;
              }
            } else {
              guard1 = true;
            }

            if (guard1) {
              first_iteration = false;
              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel118<<<grid, block>>>(*b_gpu_x_data, j2 - 1,
                  *gpu_dv10_data);
              }

              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel119<<<grid, block>>>(*b_gpu_x_data, j2 - 1,
                  *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel120<<<grid, block>>>(*gpu_y_data, j2 - 1,
                  *b_gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel121<<<grid, block>>>(*gpu_xt_data, *b_gpu_y_data,
                  *gpu_dv10_data, j2 - 1, *d_gpu_fx_data);
              }

              fx_data_outdatedOnCpu = true;
              cpu_r = 0.0;
              ix = -1;
              for (lidx = 0; lidx < nsubs; lidx++) {
                fc = 0.0;
                b_r = 0.0;
                for (i = 0; i < 15; i++) {
                  if (fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *d_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  fc += dv5[i] * SD->f0.cpu_fx_data[(ix + i) + 1];
                  fx_data_outdatedOnCpu = false;
                  b_r += dv6[i] * SD->f0.cpu_fx_data[(ix + i) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                halfh = (cpu_subs[(lidx << 1) + 1] - cpu_subs[lidx << 1]) / 2.0;
                fc *= halfh;
                qsub[lidx] = fc;
                cpu_r += fc;
                errsub[lidx] = b_r * halfh;
              }

              intFsq = cpu_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              cpu_r = 2.0 * tol;
              b_r = 0.0;
              nrefine = 0;
              for (lidx = 0; lidx < nsubs; lidx++) {
                fc = errsub[lidx];
                halfh = std::abs(fc);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (halfh <= cpu_r * ((cpu_subs[(lidx << 1) + 1] - cpu_subs[lidx
                      << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[lidx];
                } else {
                  b_r += halfh;
                  nrefine++;
                  cpu_subs[(nrefine - 1) << 1] = cpu_subs[lidx << 1];
                  cpu_subs[((nrefine - 1) << 1) + 1] = cpu_subs[(lidx << 1) + 1];
                }
              }

              cpu_r = std::abs(err_ok) + b_r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(cpu_r)) && (!std::isnan(cpu_r))) && (nrefine != 0) &&
                  (!(cpu_r <= tol))) {
                nsubs = nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (lidx = 0; lidx < nrefine; lidx++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((nrefine - lidx) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nrefine - lidx) - 1) << 1) + 1];
                    cpu_subs[(((nrefine - lidx) << 1) - 1) << 1] = (cpu_subs
                      [((nrefine - lidx) - 1) << 1] + cpu_subs[(((nrefine - lidx)
                      - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nrefine - lidx) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nrefine - lidx) << 1) - 1) << 1];
                    cpu_subs[(((nrefine - lidx) << 1) - 2) << 1] = cpu_subs
                      [((nrefine - lidx) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        b_r = std::sqrt(3.5421952306087032 * (intDsq / intFsq));
      }
    } else if (cpu_wname[0] == 'a') {
      cf = 6.0;
      b_r = 1.4142135623730951;
    } else {
      cf = 5.0;
      b_r = 5.847705;
    }

    b_r = static_cast<real_T>(cpu_x->size[0]) / (b_r * 2.0);
    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (wav_outdatedOnCpu) {
          checkCudaError(cudaMemcpy(cpu_wav, *gpu_wav, 5UL,
            cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        }

        wav_outdatedOnCpu = false;
        if (cv3[lidx] != cpu_wav[lidx]) {
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
      j2 = 0;
    } else {
      j2 = -1;
    }

    if (j2 == 0) {
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
        cpu_r = 1.0 - 0.0050536085896138528 * rt_powd_snf(cf, 20.0) * std::exp
          (-rt_powd_snf(cf, 3.0));
        intFsq = 1.0;
        if (cpu_r == 0.0) {
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
              fc = cpu_r;
              err_ok = omegac - a;
              q_ok = err_ok;
            }

            if (std::abs(fc) < std::abs(intFsq)) {
              a = omegac;
              omegac = intDsq;
              intDsq = a;
              cpu_r = intFsq;
              intFsq = fc;
              fc = cpu_r;
            }

            b_m = 0.5 * (intDsq - omegac);
            toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(b_m) <= toler) || (intFsq == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(q_ok) < toler) || (std::abs(cpu_r) <= std::abs
                   (intFsq))) {
                err_ok = b_m;
                q_ok = b_m;
              } else {
                s = intFsq / cpu_r;
                if (a == intDsq) {
                  cpu_r = 2.0 * b_m * s;
                  halfh = 1.0 - s;
                } else {
                  halfh = cpu_r / fc;
                  r = intFsq / fc;
                  cpu_r = s * (2.0 * b_m * halfh * (halfh - r) - (omegac - a) *
                               (r - 1.0));
                  halfh = (halfh - 1.0) * (r - 1.0) * (s - 1.0);
                }

                if (cpu_r > 0.0) {
                  halfh = -halfh;
                } else {
                  cpu_r = -cpu_r;
                }

                if ((2.0 * cpu_r < 3.0 * b_m * halfh - std::abs(toler * halfh)) &&
                    (cpu_r < std::abs(0.5 * q_ok * halfh))) {
                  q_ok = err_ok;
                  err_ok = cpu_r / halfh;
                } else {
                  err_ok = b_m;
                  q_ok = b_m;
                }
              }

              a = omegac;
              cpu_r = intFsq;
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

    cpu_r = omegac / 3.1415926535897931;
    if (b_r < cpu_r * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave)) {
      b_r = cpu_r * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave);
    }

    cpu_r = 1.0 / (b_r * (6.2831853071795862 / cf)) * fs;
    if (fLims[0] < cpu_r) {
      fLims[0] = cpu_r;
      freqrange[0] = cpu_r;
    }

    if (fLims[1] > fs / 2.0) {
      fLims[1] = fs / 2.0;
      freqrange[1] = fLims[1];
    }

    if (freqrange[1] == 0.0) {
      b_r = rtMinusInf;
    } else if (freqrange[1] < 0.0) {
      b_r = rtNaN;
    } else if ((!std::isinf(freqrange[1])) && (!std::isnan(freqrange[1]))) {
      cpu_r = std::frexp(freqrange[1], &eint);
      if (cpu_r == 0.5) {
        b_r = static_cast<real_T>(eint) - 1.0;
      } else if ((eint == 1) && (cpu_r < 0.75)) {
        b_r = std::log(2.0 * cpu_r) / 0.69314718055994529;
      } else {
        b_r = std::log(cpu_r) / 0.69314718055994529 + static_cast<real_T>(eint);
      }
    } else {
      b_r = freqrange[1];
    }

    if ((!std::isinf(freqrange[0])) && (!std::isnan(freqrange[0]))) {
      cpu_r = std::frexp(freqrange[0], &b_eint);
      if (cpu_r == 0.5) {
        cpu_r = static_cast<real_T>(b_eint) - 1.0;
      } else if ((b_eint == 1) && (cpu_r < 0.75)) {
        cpu_r = std::log(2.0 * cpu_r) / 0.69314718055994529;
      } else {
        cpu_r = std::log(cpu_r) / 0.69314718055994529 + static_cast<real_T>
          (b_eint);
      }
    } else {
      cpu_r = freqrange[0];
    }

    if (!(b_r - cpu_r >= 1.0 / fb_VoicesPerOctave)) {
      c_tmpStr = nullptr;
      e_y = nullptr;
      m3 = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m3, &u[0]);
      emlrtAssign(&e_y, m3);
      f_y = nullptr;
      m4 = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 5, m4, &b_formatSpec[0]);
      emlrtAssign(&f_y, m4);
      g_y = nullptr;
      m5 = emlrtCreateDoubleScalar(1.0 / fb_VoicesPerOctave);
      emlrtAssign(&g_y, m5);
      emlrtAssign(&c_tmpStr, feval(e_y, f_y, g_y, &emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(c_tmpStr), &b_emlrtMCI),
                       "<output of length>");
      emxInit_char_T(&d_tmpStr, 2, &fc_emlrtRTEI, true);
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
      if (cpu_cv[static_cast<int32_T>(c_b[lidx])] != cpu_cv[static_cast<int32_T>
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

  N = static_cast<uint32_T>(cpu_x->size[0]) + static_cast<uint32_T>
    (static_cast<int32_T>(y) << 1);
  nrefine = static_cast<int32_T>(std::trunc(static_cast<real_T>(N) / 2.0));
  emxInit_int32_T(&cpu_omega_tmp1, 2, &b_emlrtRTEI, true);
  if (nrefine < 1) {
    cpu_omega_tmp1->size[0] = 1;
    cpu_omega_tmp1->size[1] = 0;
  } else {
    nsubs = cpu_omega_tmp1->size[0] * cpu_omega_tmp1->size[1];
    cpu_omega_tmp1->size[0] = 1;
    cpu_omega_tmp1->size[1] = nrefine;
    emxEnsureCapacity_int32_T(cpu_omega_tmp1, nsubs, &b_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(nrefine - 1), &grid, &block,
      2147483647U);
    gpuEmxEnsureCapacity_int32_T(cpu_omega_tmp1, &gpu_omega_tmp1, true);
    c_omega_tmp1_needsGpuEnsureCapa = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel114<<<grid, block>>>(nrefine - 1, gpu_omega_tmp1);
    }
  }

  emxInit_real_T(&cpu_omega_tmp2, 2, &c_emlrtRTEI, true);
  nsubs = cpu_omega_tmp2->size[0] * cpu_omega_tmp2->size[1];
  cpu_omega_tmp2->size[0] = 1;
  cpu_omega_tmp2->size[1] = cpu_omega_tmp1->size[1];
  emxEnsureCapacity_real_T(cpu_omega_tmp2, nsubs, &c_emlrtRTEI);
  j2 = cpu_omega_tmp1->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
  if (c_omega_tmp1_needsGpuEnsureCapa) {
    gpuEmxEnsureCapacity_int32_T(cpu_omega_tmp1, &gpu_omega_tmp1, true);
  }

  gpuEmxEnsureCapacity_real_T(cpu_omega_tmp2, &gpu_omega_tmp2, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwtAvg_kernel8<<<grid, block>>>(6.2831853071795862 / static_cast<real_T>
      (N), gpu_omega_tmp1, j2, gpu_omega_tmp2);
  }

  emxFree_int32_T(&cpu_omega_tmp1);
  nrefine = static_cast<int32_T>(std::trunc((static_cast<real_T>(N) - 1.0) / 2.0));
  if (nrefine < 1) {
    i = 0;
    nrefine = 1;
    lidx = -1;
  } else {
    i = nrefine - 1;
    nrefine = -1;
    lidx = 0;
  }

  emxInit_real_T(&cpu_fb_Omega, 2, &g_emlrtRTEI, true);
  nsubs = cpu_fb_Omega->size[0] * cpu_fb_Omega->size[1];
  cpu_fb_Omega->size[0] = 1;
  cpu_fb_Omega->size[1] = (cpu_omega_tmp2->size[1] + div_s32(lidx - i, nrefine))
    + 2;
  emxEnsureCapacity_real_T(cpu_fb_Omega, nsubs, &d_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_fb_Omega, &gpu_fb_Omega, true);
  ec_cwtAvg_kernel9<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_fb_Omega);
  nx = cpu_omega_tmp2->size[1];
  mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block, 2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwtAvg_kernel10<<<grid, block>>>(gpu_omega_tmp2, nx - 1, gpu_fb_Omega);
  }

  nx = div_s32(lidx - i, nrefine);
  mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwtAvg_kernel11<<<grid, block>>>(nrefine, i, gpu_omega_tmp2, nx,
      gpu_fb_Omega, cpu_omega_tmp2->size[1U]);
  }

  fb_Omega_outdatedOnCpu = true;
  emxFree_real_T(&cpu_omega_tmp2);
  for (j2 = 0; j2 < 2; j2++) {
    b_b[j2] = std::isnan(fLims[j2]);
  }

  first_iteration = true;
  lidx = 0;
  exitg2 = false;
  while ((!exitg2) && (lidx < 2)) {
    if (!b_b[lidx]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      lidx++;
    }
  }

  emxInit_real_T(&cpu_fb_Scales, 2, &g_emlrtRTEI, true);
  if (!first_iteration) {
    for (j2 = 0; j2 < 2; j2++) {
      NyquistRange[j2] = fLims[j2] / fs * 2.0 * 3.1415926535897931;
    }

    for (j2 = 0; j2 < 5; j2++) {
      cpu_wname[j2] = cpu_cv[static_cast<int32_T>(c_b[j2])];
    }

    if (cpu_wname[0] == 'm') {
      cpu_r = 1.8820720577620569;
    } else {
      i = 1;
      if (cpu_wname[0] == 'a') {
        i = 2;
      }

      if (i > 1) {
        cpu_r = 6.0;
      } else {
        cpu_r = 5.0;
      }
    }

    halfh = cpu_r / NyquistRange[1];
    cpu_r = cpu_r / NyquistRange[0] / halfh;
    if (cpu_r == 0.0) {
      cpu_r = rtMinusInf;
    } else if (cpu_r < 0.0) {
      cpu_r = rtNaN;
    } else if ((!std::isinf(cpu_r)) && (!std::isnan(cpu_r))) {
      cpu_r = std::frexp(cpu_r, &c_eint);
      if (cpu_r == 0.5) {
        cpu_r = static_cast<real_T>(c_eint) - 1.0;
      } else if ((c_eint == 1) && (cpu_r < 0.75)) {
        cpu_r = std::log(2.0 * cpu_r) / 0.69314718055994529;
      } else {
        cpu_r = std::log(cpu_r) / 0.69314718055994529 + static_cast<real_T>
          (c_eint);
      }
    }

    emxInit_real_T(&cpu_y, 2, &mb_emlrtRTEI, true);
    cpu_r *= fb_VoicesPerOctave;
    if (std::isnan(cpu_r)) {
      nsubs = cpu_y->size[0] * cpu_y->size[1];
      cpu_y->size[0] = 1;
      cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_y, nsubs, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
      y_needsGpuEnsureCapacity = false;
      ec_cwtAvg_kernel12<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_y);
    } else if (cpu_r < 0.0) {
      cpu_y->size[0] = 1;
      cpu_y->size[1] = 0;
    } else {
      nsubs = cpu_y->size[0] * cpu_y->size[1];
      cpu_y->size[0] = 1;
      cpu_y->size[1] = static_cast<int32_T>(cpu_r) + 1;
      emxEnsureCapacity_real_T(cpu_y, nsubs, &e_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(cpu_r)),
        &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
      y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel85<<<grid, block>>>(static_cast<int32_T>(cpu_r), gpu_y);
      }
    }

    emxInit_real_T(&b_cpu_y, 2, &nb_emlrtRTEI, true);
    nsubs = b_cpu_y->size[0] * b_cpu_y->size[1];
    b_cpu_y->size[0] = 1;
    b_cpu_y->size[1] = cpu_y->size[1];
    emxEnsureCapacity_real_T(b_cpu_y, nsubs, &f_emlrtRTEI);
    i = cpu_y->size[1];
    mwGetLaunchParameters1D(computeNumIters(i - 1), &grid, &block, 2147483647U);
    if (y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
    }

    gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel13<<<grid, block>>>(gpu_y, rt_powd_snf(2.0, 1.0 /
        fb_VoicesPerOctave), i - 1, b_gpu_y);
    }

    emxFree_real_T(&cpu_y);
    nsubs = cpu_fb_Scales->size[0] * cpu_fb_Scales->size[1];
    cpu_fb_Scales->size[0] = 1;
    cpu_fb_Scales->size[1] = b_cpu_y->size[1];
    emxEnsureCapacity_real_T(cpu_fb_Scales, nsubs, &g_emlrtRTEI);
    j2 = b_cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    interval_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel14<<<grid, block>>>(b_gpu_y, halfh, j2, gpu_fb_Scales);
    }

    c_omega_tmp1_needsGpuEnsureCapa = true;
    emxFree_real_T(&b_cpu_y);
  } else {
    omegac = 3.1415926535897931;
    ec_cwtAvg_kernel86<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*global_gpu_cv, *
      gpu_wav, *gpu_wname, c_b[0], c_b[1], c_b[2], c_b[3], c_b[4]);
    y_needsGpuEnsureCapacity = true;
    checkCudaError(cudaMemcpy(cpu_wav, *gpu_wav, 5UL, cudaMemcpyDeviceToHost),
                   __FILE__, __LINE__);
    if (cpu_wav[0] == 'm') {
      a = 1.8820720577620569;
      r = 0.0057083835261;
      cpu_r = 0.0057083835261;
      b_r = 0.0057083835261;
      for (i = 0; i < 6; i++) {
        fc = c[i];
        r = r * 0.005353955978584176 + fc;
        cpu_r = cpu_r * 0.005353955978584176 + fc;
        b_r = b_r * 0.005353955978584176 + fc;
      }

      r /= 13.666666666666666;
      cpu_r /= 13.666666666666666;
      b_r /= 13.666666666666666;
      b_r = std::sqrt((std::exp((table100[12] + 7.7183093240718676) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((table100[14] + 2.5377749931802178) - (((cpu_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((table100[13] + 5.8211893391859881) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(b_r) || std::isnan(b_r)) {
        ec_cwtAvg_kernel87<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ec_cwtAvg_kernel88<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>
          (*gpu_interval);
        interval_outdatedOnGpu = false;
        intDsq = 0.0;
        i = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        nx = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (nx > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            cpu_r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (i = 0; i < nrefine; i++) {
              cpu_interval[n_idx_0 - i] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - i) * cpu_r;
            }
          }

          i = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (nrefine = 0; nrefine < i; nrefine++) {
          if (std::abs(cpu_interval[nrefine + 1] - cpu_interval[lidx]) > 0.0) {
            lidx++;
            cpu_interval[lidx] = cpu_interval[nrefine + 1];
            interval_outdatedOnGpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          ec_cwtAvg_kernel89<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i,
            *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (nx <= 0) {
          intDsq = rtNaN;
        } else {
          mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel104<<<grid, block>>>(*gpu_interval, nsubs - 1,
              *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            j2 = 15 * nsubs;
            ix = -1;
            for (lidx = 0; lidx < nsubs; lidx++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              fc = cpu_subs[lidx << 1];
              subs_outdatedOnCpu = false;
              b_r = cpu_subs[(lidx << 1) + 1];
              cpu_r = (fc + b_r) / 2.0;
              halfh = (b_r - fc) / 2.0;
              for (i = 0; i < 15; i++) {
                SD->f0.cpu_x_data[(ix + i) + 1] = NODES[i] * halfh + cpu_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            b_xt_size[0] = 1;
            b_xt_size[1] = j2;
            mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
              2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel105<<<grid, block>>>(*gpu_x_data, j2 - 1,
                *gpu_xt_data, *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              cpu_r = std::abs(SD->f0.cpu_x_data[0]);
              lidx = 0;
              exitg2 = false;
              while ((!exitg2) && (lidx <= j2 - 2)) {
                tol = cpu_r;
                cpu_r = std::abs(SD->f0.cpu_x_data[lidx + 1]);
                if (std::abs(SD->f0.cpu_x_data[lidx + 1] - SD->
                             f0.cpu_x_data[lidx]) <= 2.2204460492503131E-14 *
                    std::fmax(tol, cpu_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  lidx++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                  2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel106<<<grid, block>>>(j2 - 1, *c_gpu_fx_data);
                }

                exitg1 = 1;
              } else {
                guard1 = true;
              }
            } else {
              guard1 = true;
            }

            if (guard1) {
              first_iteration = false;
              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel107<<<grid, block>>>(*b_gpu_x_data, j2 - 1,
                  *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel108<<<grid, block>>>(*b_gpu_x_data, j2 - 1,
                  *b_gpu_y_data);
              }

              b_a_size[1] = j2;
              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel109<<<grid, block>>>(*b_gpu_y_data, *gpu_y_data,
                  j2 - 1, *b_gpu_a_data);
              }

              dv11_size[0] = 1;
              dv11_size[1] = b_a_size[1];
              mwGetLaunchParameters1D(computeNumIters(b_a_size[1] - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel110<<<grid, block>>>(*b_gpu_a_data, b_a_size[1]
                  - 1, *gpu_dv11_data);
              }

              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel111<<<grid, block>>>(*b_gpu_x_data, j2 - 1,
                  *gpu_y_data);
              }

              dv13_size[0] = 1;
              dv13_size[1] = j2;
              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel112<<<grid, block>>>(*gpu_y_data, j2 - 1,
                  *b_gpu_y_data);
              }

              if (b_a_size[1] == j2) {
                fx_size[0] = 1;
                fx_size[1] = b_a_size[1];
                mwGetLaunchParameters1D(computeNumIters(b_a_size[1] - 1), &grid,
                  &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel113<<<grid, block>>>(*gpu_xt_data,
                    *b_gpu_y_data, *gpu_dv11_data, b_a_size[1] - 1,
                    *c_gpu_fx_data);
                }

                b_fx_data_outdatedOnCpu = true;
              } else {
                if (b_fx_data_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_fx_data, *c_gpu_fx_data, 77880UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                checkCudaError(cudaMemcpy(cpu_dv11_data, *gpu_dv11_data, 77880UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_y_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_xt_data, *gpu_xt_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                binary_expand_op_5(cpu_fx_data, fx_size, cpu_dv11_data,
                                   dv11_size, SD->f0.cpu_x_data, dv13_size,
                                   SD->f0.cpu_xt_data, b_xt_size);
                b_fx_data_outdatedOnCpu = false;
              }

              cpu_r = 0.0;
              ix = -1;
              for (lidx = 0; lidx < nsubs; lidx++) {
                fc = 0.0;
                b_r = 0.0;
                for (i = 0; i < 15; i++) {
                  if (b_fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(cpu_fx_data, *c_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  fc += dv5[i] * cpu_fx_data[(ix + i) + 1];
                  b_fx_data_outdatedOnCpu = false;
                  b_r += dv6[i] * cpu_fx_data[(ix + i) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                halfh = (cpu_subs[(lidx << 1) + 1] - cpu_subs[lidx << 1]) / 2.0;
                fc *= halfh;
                qsub[lidx] = fc;
                cpu_r += fc;
                errsub[lidx] = b_r * halfh;
              }

              intDsq = cpu_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              cpu_r = 2.0 * tol;
              b_r = 0.0;
              nrefine = 0;
              for (lidx = 0; lidx < nsubs; lidx++) {
                fc = errsub[lidx];
                halfh = std::abs(fc);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (halfh <= cpu_r * ((cpu_subs[(lidx << 1) + 1] - cpu_subs[lidx
                      << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[lidx];
                } else {
                  b_r += halfh;
                  nrefine++;
                  cpu_subs[(nrefine - 1) << 1] = cpu_subs[lidx << 1];
                  cpu_subs[((nrefine - 1) << 1) + 1] = cpu_subs[(lidx << 1) + 1];
                }
              }

              cpu_r = std::abs(err_ok) + b_r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(cpu_r)) && (!std::isnan(cpu_r))) && (nrefine != 0) &&
                  (!(cpu_r <= tol))) {
                nsubs = nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (lidx = 0; lidx < nrefine; lidx++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((nrefine - lidx) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nrefine - lidx) - 1) << 1) + 1];
                    cpu_subs[(((nrefine - lidx) << 1) - 1) << 1] = (cpu_subs
                      [((nrefine - lidx) - 1) << 1] + cpu_subs[(((nrefine - lidx)
                      - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nrefine - lidx) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nrefine - lidx) << 1) - 1) << 1];
                    cpu_subs[(((nrefine - lidx) << 1) - 2) << 1] = cpu_subs
                      [((nrefine - lidx) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        ec_cwtAvg_kernel90<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ec_cwtAvg_kernel91<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>
          (*gpu_interval);
        interval_outdatedOnGpu = false;
        intFsq = 0.0;
        i = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        nx = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (nx > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            cpu_r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (i = 0; i < nrefine; i++) {
              cpu_interval[n_idx_0 - i] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - i) * cpu_r;
            }
          }

          i = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (nrefine = 0; nrefine < i; nrefine++) {
          if (std::abs(cpu_interval[nrefine + 1] - cpu_interval[lidx]) > 0.0) {
            lidx++;
            cpu_interval[lidx] = cpu_interval[nrefine + 1];
            interval_outdatedOnGpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          ec_cwtAvg_kernel92<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i,
            *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (nx <= 0) {
          intFsq = rtNaN;
        } else {
          mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel97<<<grid, block>>>(*gpu_interval, nsubs - 1,
              *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            j2 = 15 * nsubs;
            ix = -1;
            for (lidx = 0; lidx < nsubs; lidx++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              fc = cpu_subs[lidx << 1];
              subs_outdatedOnCpu = false;
              b_r = cpu_subs[(lidx << 1) + 1];
              cpu_r = (fc + b_r) / 2.0;
              halfh = (b_r - fc) / 2.0;
              for (i = 0; i < 15; i++) {
                SD->f0.cpu_x_data[(ix + i) + 1] = NODES[i] * halfh + cpu_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
              2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel98<<<grid, block>>>(*gpu_x_data, j2 - 1,
                *gpu_xt_data, *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              cpu_r = std::abs(SD->f0.cpu_x_data[0]);
              lidx = 0;
              exitg2 = false;
              while ((!exitg2) && (lidx <= j2 - 2)) {
                tol = cpu_r;
                cpu_r = std::abs(SD->f0.cpu_x_data[lidx + 1]);
                if (std::abs(SD->f0.cpu_x_data[lidx + 1] - SD->
                             f0.cpu_x_data[lidx]) <= 2.2204460492503131E-14 *
                    std::fmax(tol, cpu_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  lidx++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                  2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel99<<<grid, block>>>(j2 - 1, *b_gpu_fx_data);
                }

                exitg1 = 1;
              } else {
                guard1 = true;
              }
            } else {
              guard1 = true;
            }

            if (guard1) {
              first_iteration = false;
              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel100<<<grid, block>>>(*b_gpu_x_data, j2 - 1,
                  *gpu_dv15_data);
              }

              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel101<<<grid, block>>>(*b_gpu_x_data, j2 - 1,
                  *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel102<<<grid, block>>>(*gpu_y_data, j2 - 1,
                  *b_gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel103<<<grid, block>>>(*gpu_xt_data, *b_gpu_y_data,
                  *gpu_dv15_data, j2 - 1, *b_gpu_fx_data);
              }

              b_fx_data_outdatedOnCpu = true;
              cpu_r = 0.0;
              ix = -1;
              for (lidx = 0; lidx < nsubs; lidx++) {
                fc = 0.0;
                b_r = 0.0;
                for (i = 0; i < 15; i++) {
                  if (b_fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *b_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  fc += dv5[i] * SD->f0.cpu_fx_data[(ix + i) + 1];
                  b_fx_data_outdatedOnCpu = false;
                  b_r += dv6[i] * SD->f0.cpu_fx_data[(ix + i) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                halfh = (cpu_subs[(lidx << 1) + 1] - cpu_subs[lidx << 1]) / 2.0;
                fc *= halfh;
                qsub[lidx] = fc;
                cpu_r += fc;
                errsub[lidx] = b_r * halfh;
              }

              intFsq = cpu_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              cpu_r = 2.0 * tol;
              b_r = 0.0;
              nrefine = 0;
              for (lidx = 0; lidx < nsubs; lidx++) {
                fc = errsub[lidx];
                halfh = std::abs(fc);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (halfh <= cpu_r * ((cpu_subs[(lidx << 1) + 1] - cpu_subs[lidx
                      << 1]) / 2.0)) {
                  err_ok += fc;
                  q_ok += qsub[lidx];
                } else {
                  b_r += halfh;
                  nrefine++;
                  cpu_subs[(nrefine - 1) << 1] = cpu_subs[lidx << 1];
                  cpu_subs[((nrefine - 1) << 1) + 1] = cpu_subs[(lidx << 1) + 1];
                }
              }

              cpu_r = std::abs(err_ok) + b_r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(cpu_r)) && (!std::isnan(cpu_r))) && (nrefine != 0) &&
                  (!(cpu_r <= tol))) {
                nsubs = nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (lidx = 0; lidx < nrefine; lidx++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((nrefine - lidx) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nrefine - lidx) - 1) << 1) + 1];
                    cpu_subs[(((nrefine - lidx) << 1) - 1) << 1] = (cpu_subs
                      [((nrefine - lidx) - 1) << 1] + cpu_subs[(((nrefine - lidx)
                      - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nrefine - lidx) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nrefine - lidx) << 1) - 1) << 1];
                    cpu_subs[(((nrefine - lidx) << 1) - 2) << 1] = cpu_subs
                      [((nrefine - lidx) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        b_r = std::sqrt(3.5421952306087032 * (intDsq / intFsq));
      }
    } else if (cpu_wav[0] == 'a') {
      a = 6.0;
      b_r = 1.4142135623730951;
    } else {
      a = 5.0;
      b_r = 5.847705;
    }

    tol = static_cast<real_T>(cpu_x->size[0]) / (b_r * 2.0);
    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (y_needsGpuEnsureCapacity) {
          checkCudaError(cudaMemcpy(cpu_wname, *gpu_wname, 5UL,
            cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        }

        y_needsGpuEnsureCapacity = false;
        if (cv3[lidx] != cpu_wname[lidx]) {
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
      j2 = 0;
    } else {
      j2 = -1;
    }

    if (j2 == 0) {
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
        cpu_r = b_r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
          (-rt_powd_snf(a, 3.0));
        intFsq = b_r;
        if (cpu_r == 0.0) {
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
              fc = cpu_r;
              err_ok = omegac - a;
              q_ok = err_ok;
            }

            if (std::abs(fc) < std::abs(intFsq)) {
              a = omegac;
              omegac = intDsq;
              intDsq = a;
              cpu_r = intFsq;
              intFsq = fc;
              fc = cpu_r;
            }

            b_m = 0.5 * (intDsq - omegac);
            toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(b_m) <= toler) || (intFsq == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(q_ok) < toler) || (std::abs(cpu_r) <= std::abs
                   (intFsq))) {
                err_ok = b_m;
                q_ok = b_m;
              } else {
                s = intFsq / cpu_r;
                if (a == intDsq) {
                  cpu_r = 2.0 * b_m * s;
                  halfh = 1.0 - s;
                } else {
                  halfh = cpu_r / fc;
                  r = intFsq / fc;
                  cpu_r = s * (2.0 * b_m * halfh * (halfh - r) - (omegac - a) *
                               (r - 1.0));
                  halfh = (halfh - 1.0) * (r - 1.0) * (s - 1.0);
                }

                if (cpu_r > 0.0) {
                  halfh = -halfh;
                } else {
                  cpu_r = -cpu_r;
                }

                if ((2.0 * cpu_r < 3.0 * b_m * halfh - std::abs(toler * halfh)) &&
                    (cpu_r < std::abs(0.5 * q_ok * halfh))) {
                  q_ok = err_ok;
                  err_ok = cpu_r / halfh;
                } else {
                  err_ok = b_m;
                  q_ok = b_m;
                }
              }

              a = omegac;
              cpu_r = intFsq;
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
      tol = std::frexp(tol, &c_eint);
      if (tol == 0.5) {
        tol = static_cast<real_T>(c_eint) - 1.0;
      } else if ((c_eint == 1) && (tol < 0.75)) {
        tol = std::log(2.0 * tol) / 0.69314718055994529;
      } else {
        tol = std::log(tol) / 0.69314718055994529 + static_cast<real_T>(c_eint);
      }
    }

    emxInit_real_T(&c_cpu_y, 2, &sb_emlrtRTEI, true);
    cpu_r = std::fmax(tol, 1.0 / fb_VoicesPerOctave) * fb_VoicesPerOctave;
    if (std::isnan(cpu_r)) {
      nsubs = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(c_cpu_y, nsubs, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &h_gpu_y, true);
      b_y_needsGpuEnsureCapacity = false;
      ec_cwtAvg_kernel93<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(h_gpu_y);
    } else if (cpu_r < 0.0) {
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = 0;
    } else {
      nsubs = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = static_cast<int32_T>(cpu_r) + 1;
      emxEnsureCapacity_real_T(c_cpu_y, nsubs, &e_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(cpu_r)),
        &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &h_gpu_y, true);
      b_y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel96<<<grid, block>>>(static_cast<int32_T>(cpu_r), h_gpu_y);
      }
    }

    emxInit_real_T(&d_cpu_y, 2, &ub_emlrtRTEI, true);
    nsubs = d_cpu_y->size[0] * d_cpu_y->size[1];
    d_cpu_y->size[0] = 1;
    d_cpu_y->size[1] = c_cpu_y->size[1];
    emxEnsureCapacity_real_T(d_cpu_y, nsubs, &f_emlrtRTEI);
    i = c_cpu_y->size[1];
    mwGetLaunchParameters1D(computeNumIters(i - 1), &grid, &block, 2147483647U);
    if (b_y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &h_gpu_y, true);
    }

    gpuEmxEnsureCapacity_real_T(d_cpu_y, &i_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel94<<<grid, block>>>(h_gpu_y, rt_powd_snf(2.0, 1.0 /
        fb_VoicesPerOctave), i - 1, i_gpu_y);
    }

    emxFree_real_T(&c_cpu_y);
    nsubs = cpu_fb_Scales->size[0] * cpu_fb_Scales->size[1];
    cpu_fb_Scales->size[0] = 1;
    cpu_fb_Scales->size[1] = d_cpu_y->size[1];
    emxEnsureCapacity_real_T(cpu_fb_Scales, nsubs, &g_emlrtRTEI);
    j2 = d_cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    interval_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel95<<<grid, block>>>(i_gpu_y, halfh, j2, gpu_fb_Scales);
    }

    c_omega_tmp1_needsGpuEnsureCapa = true;
    emxFree_real_T(&d_cpu_y);
  }

  first_iteration = false;
  lidx = 0;
  do {
    exitg1 = 0;
    if (lidx + 1 < 6) {
      if (cpu_cv[static_cast<int32_T>(c_b[lidx])] != cpu_cv[static_cast<int32_T>
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

  emxInit_real_T(&cpu_daughter, 2, &q_emlrtRTEI, true);
  emxInit_real_T(&cpu_f, 2, &vb_emlrtRTEI, true);
  if (first_iteration) {
    emxInit_real_T(&b_cpu_somega, 2, &pb_emlrtRTEI, true);
    if (cpu_fb_Scales->size[1] == 1) {
      wav_outdatedOnCpu = false;
      fx_data_outdatedOnCpu = false;
      nsubs = b_cpu_somega->size[0] * b_cpu_somega->size[1];
      b_cpu_somega->size[0] = 1;
      if (cpu_fb_Omega->size[1] == 1) {
        b_cpu_somega->size[1] = 1;
      } else {
        b_cpu_somega->size[1] = cpu_fb_Omega->size[1];
      }

      emxEnsureCapacity_real_T(b_cpu_somega, nsubs, &i_emlrtRTEI);
      y_needsGpuEnsureCapacity = true;
      bcoef = (cpu_fb_Omega->size[1] != 1);
      nrefine = b_cpu_somega->size[1] - 1;
      for (lidx = 0; lidx <= nrefine; lidx++) {
        if (c_omega_tmp1_needsGpuEnsureCapa) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
        }

        c_omega_tmp1_needsGpuEnsureCapa = false;
        if (fb_Omega_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Omega, &gpu_fb_Omega);
        }

        fb_Omega_outdatedOnCpu = false;
        b_cpu_somega->data[lidx] = cpu_fb_Scales->data[0] * cpu_fb_Omega->
          data[bcoef * lidx];
        fx_data_outdatedOnCpu = true;
        interval_outdatedOnGpu = true;
      }
    } else {
      nsubs = b_cpu_somega->size[0] * b_cpu_somega->size[1];
      b_cpu_somega->size[0] = cpu_fb_Scales->size[1];
      b_cpu_somega->size[1] = cpu_fb_Omega->size[1];
      emxEnsureCapacity_real_T(b_cpu_somega, nsubs, &j_emlrtRTEI);
      nx = cpu_fb_Omega->size[1];
      j2 = cpu_fb_Scales->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(nx - 1, j2), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_somega, &gpu_somega, true);
      y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel76<<<grid, block>>>(gpu_fb_Omega, gpu_fb_Scales, j2, nx
          - 1, gpu_somega, b_cpu_somega->size[0U]);
      }

      fx_data_outdatedOnCpu = false;
      wav_outdatedOnCpu = true;
    }

    i = b_cpu_somega->size[0] * b_cpu_somega->size[1];
    for (j2 = 0; j2 < 2; j2++) {
      xSize[j2] = static_cast<uint32_T>(b_cpu_somega->size[j2]);
    }

    emxInit_real_T(&cpu_absomega, 2, &rb_emlrtRTEI, true);
    nsubs = cpu_absomega->size[0] * cpu_absomega->size[1];
    cpu_absomega->size[0] = static_cast<int32_T>(xSize[0]);
    cpu_absomega->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(cpu_absomega, nsubs, &l_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(i - 1), &grid, &block, 2147483647U);
    if (y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(b_cpu_somega, &gpu_somega,
        !fx_data_outdatedOnCpu);
    }

    gpuEmxEnsureCapacity_real_T(cpu_absomega, &gpu_absomega, true);
    if (fx_data_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, b_cpu_somega);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel15<<<grid, block>>>(gpu_somega, i - 1, gpu_absomega);
    }

    emxInit_real_T(&cpu_powscales, 2, &n_emlrtRTEI, true);
    nsubs = cpu_powscales->size[0] * cpu_powscales->size[1];
    cpu_powscales->size[0] = cpu_absomega->size[0];
    cpu_powscales->size[1] = cpu_absomega->size[1];
    emxEnsureCapacity_real_T(cpu_powscales, nsubs, &n_emlrtRTEI);
    j2 = cpu_absomega->size[0] * cpu_absomega->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_powscales, &gpu_powscales, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel16<<<grid, block>>>(gpu_absomega, j2, gpu_powscales);
    }

    i = cpu_absomega->size[0] * cpu_absomega->size[1];
    mwGetLaunchParameters1D(computeNumIters(i - 1), &grid, &block, 2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel17<<<grid, block>>>(i - 1, gpu_absomega);
    }

    emxInit_real_T(&b_cpu_x, 2, &o_emlrtRTEI, true);
    if ((cpu_absomega->size[0] == cpu_powscales->size[0]) && (cpu_absomega->
         size[1] == cpu_powscales->size[1])) {
      nsubs = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = cpu_absomega->size[0];
      b_cpu_x->size[1] = cpu_absomega->size[1];
      emxEnsureCapacity_real_T(b_cpu_x, nsubs, &o_emlrtRTEI);
      j2 = cpu_absomega->size[0] * cpu_absomega->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_x, &gpu_x, true);
      fx_data_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel18<<<grid, block>>>(gpu_powscales, gpu_absomega, j2,
          gpu_x);
      }

      y_needsGpuEnsureCapacity = false;
    } else {
      gpuEmxMemcpyGpuToCpu_real_T(cpu_absomega, &gpu_absomega);
      gpuEmxMemcpyGpuToCpu_real_T(cpu_powscales, &gpu_powscales);
      binary_expand_op_3(b_cpu_x, cpu_absomega, cpu_powscales);
      y_needsGpuEnsureCapacity = true;
      fx_data_outdatedOnCpu = true;
    }

    emxFree_real_T(&cpu_powscales);
    emxFree_real_T(&cpu_absomega);
    i = b_cpu_x->size[0] * b_cpu_x->size[1];
    mwGetLaunchParameters1D(computeNumIters(i - 1), &grid, &block, 2147483647U);
    if (fx_data_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real_T(b_cpu_x, &gpu_x, !y_needsGpuEnsureCapacity);
    }

    if (y_needsGpuEnsureCapacity) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, b_cpu_x);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel19<<<grid, block>>>(i - 1, gpu_x);
    }

    if ((b_cpu_x->size[0] == b_cpu_somega->size[0]) && (b_cpu_x->size[1] ==
         b_cpu_somega->size[1])) {
      nsubs = cpu_daughter->size[0] * cpu_daughter->size[1];
      cpu_daughter->size[0] = b_cpu_x->size[0];
      cpu_daughter->size[1] = b_cpu_x->size[1];
      emxEnsureCapacity_real_T(cpu_daughter, nsubs, &p_emlrtRTEI);
      j2 = b_cpu_x->size[0] * b_cpu_x->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter, true);
      daughter_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel20<<<grid, block>>>(gpu_somega, gpu_x, j2, gpu_daughter);
      }

      daughter_outdatedOnGpu = false;
    } else {
      gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &gpu_x);
      if (wav_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(b_cpu_somega, &gpu_somega);
      }

      binary_expand_op_2(cpu_daughter, b_cpu_x, b_cpu_somega);
      daughter_outdatedOnGpu = true;
      daughter_needsGpuEnsureCapacity = true;
    }

    emxFree_real_T(&b_cpu_x);
    emxFree_real_T(&b_cpu_somega);
    nsubs = cpu_f->size[0] * cpu_f->size[1];
    cpu_f->size[0] = 1;
    cpu_f->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real_T(cpu_f, nsubs, &r_emlrtRTEI);
    j2 = cpu_fb_Scales->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    if (interval_outdatedOnGpu) {
      gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    }

    gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel21<<<grid, block>>>(gpu_fb_Scales, j2, gpu_f);
    }
  } else {
    emxInit_real_T(&cpu_somega, 2, &ob_emlrtRTEI, true);
    if (cpu_fb_Scales->size[1] == 1) {
      fx_data_outdatedOnCpu = false;
      nsubs = cpu_somega->size[0] * cpu_somega->size[1];
      cpu_somega->size[0] = 1;
      if (cpu_fb_Omega->size[1] == 1) {
        cpu_somega->size[1] = 1;
      } else {
        cpu_somega->size[1] = cpu_fb_Omega->size[1];
      }

      emxEnsureCapacity_real_T(cpu_somega, nsubs, &i_emlrtRTEI);
      y_needsGpuEnsureCapacity = true;
      bcoef = (cpu_fb_Omega->size[1] != 1);
      nrefine = cpu_somega->size[1] - 1;
      for (lidx = 0; lidx <= nrefine; lidx++) {
        if (c_omega_tmp1_needsGpuEnsureCapa) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
        }

        c_omega_tmp1_needsGpuEnsureCapa = false;
        if (fb_Omega_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Omega, &gpu_fb_Omega);
        }

        fb_Omega_outdatedOnCpu = false;
        cpu_somega->data[lidx] = cpu_fb_Scales->data[0] * cpu_fb_Omega->
          data[bcoef * lidx];
        fx_data_outdatedOnCpu = true;
        interval_outdatedOnGpu = true;
      }
    } else {
      nsubs = cpu_somega->size[0] * cpu_somega->size[1];
      cpu_somega->size[0] = cpu_fb_Scales->size[1];
      cpu_somega->size[1] = cpu_fb_Omega->size[1];
      emxEnsureCapacity_real_T(cpu_somega, nsubs, &h_emlrtRTEI);
      nx = cpu_fb_Omega->size[1];
      j2 = cpu_fb_Scales->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(nx - 1, j2), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_somega, &b_gpu_somega, true);
      y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel84<<<grid, block>>>(gpu_fb_Omega, gpu_fb_Scales, j2, nx
          - 1, b_gpu_somega, cpu_somega->size[0U]);
      }

      fx_data_outdatedOnCpu = false;
    }

    emxInit_real_T(&cpu_w, 2, &k_emlrtRTEI, true);
    nsubs = cpu_w->size[0] * cpu_w->size[1];
    cpu_w->size[0] = cpu_somega->size[0];
    cpu_w->size[1] = cpu_somega->size[1];
    emxEnsureCapacity_real_T(cpu_w, nsubs, &k_emlrtRTEI);
    j2 = cpu_somega->size[0] * cpu_somega->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    if (y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_somega, &b_gpu_somega,
        !fx_data_outdatedOnCpu);
    }

    gpuEmxEnsureCapacity_real_T(cpu_w, &gpu_w, true);
    if (fx_data_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_somega, cpu_somega);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel77<<<grid, block>>>(b_gpu_somega, j2, gpu_w);
    }

    emxFree_real_T(&cpu_somega);
    emxInit_real_T(&cpu_expnt, 2, &qb_emlrtRTEI, true);
    nsubs = cpu_expnt->size[0] * cpu_expnt->size[1];
    cpu_expnt->size[0] = cpu_w->size[0];
    cpu_expnt->size[1] = cpu_w->size[1];
    emxEnsureCapacity_real_T(cpu_expnt, nsubs, &m_emlrtRTEI);
    j2 = cpu_w->size[0] * cpu_w->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_expnt, &gpu_expnt, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel78<<<grid, block>>>(gpu_w, j2, gpu_expnt);
    }

    i = cpu_expnt->size[0] * cpu_expnt->size[1];
    mwGetLaunchParameters1D(computeNumIters(i - 1), &grid, &block, 2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel79<<<grid, block>>>(i - 1, gpu_expnt);
    }

    i = cpu_w->size[0] * cpu_w->size[1];
    for (j2 = 0; j2 < 2; j2++) {
      xSize[j2] = static_cast<uint32_T>(cpu_w->size[j2]);
    }

    emxInit_real_T(&e_cpu_y, 2, &tb_emlrtRTEI, true);
    nsubs = e_cpu_y->size[0] * e_cpu_y->size[1];
    e_cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    e_cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(e_cpu_y, nsubs, &l_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(i - 1), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(e_cpu_y, &g_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel80<<<grid, block>>>(gpu_w, i - 1, g_gpu_y);
    }

    emxFree_real_T(&cpu_w);
    if ((cpu_expnt->size[0] == e_cpu_y->size[0]) && (cpu_expnt->size[1] ==
         e_cpu_y->size[1])) {
      nsubs = cpu_daughter->size[0] * cpu_daughter->size[1];
      cpu_daughter->size[0] = cpu_expnt->size[0];
      cpu_daughter->size[1] = cpu_expnt->size[1];
      emxEnsureCapacity_real_T(cpu_daughter, nsubs, &q_emlrtRTEI);
      j2 = cpu_expnt->size[0] * cpu_expnt->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter, true);
      daughter_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel81<<<grid, block>>>(g_gpu_y, gpu_expnt, j2, gpu_daughter);
      }

      daughter_outdatedOnGpu = false;
    } else {
      gpuEmxMemcpyGpuToCpu_real_T(cpu_expnt, &gpu_expnt);
      gpuEmxMemcpyGpuToCpu_real_T(e_cpu_y, &g_gpu_y);
      binary_expand_op_4(cpu_daughter, cpu_expnt, e_cpu_y);
      daughter_outdatedOnGpu = true;
      daughter_needsGpuEnsureCapacity = true;
    }

    emxFree_real_T(&e_cpu_y);
    emxFree_real_T(&cpu_expnt);
    nrefine = cpu_daughter->size[0] * cpu_daughter->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(nrefine), &grid, &block, 2147483647U);
    if (daughter_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter,
        !daughter_outdatedOnGpu);
    }

    daughter_needsGpuEnsureCapacity = false;
    if (daughter_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_daughter, cpu_daughter);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel82<<<grid, block>>>(nrefine, gpu_daughter);
    }

    daughter_outdatedOnGpu = false;
    nsubs = cpu_f->size[0] * cpu_f->size[1];
    cpu_f->size[0] = 1;
    cpu_f->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real_T(cpu_f, nsubs, &t_emlrtRTEI);
    j2 = cpu_fb_Scales->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    if (interval_outdatedOnGpu) {
      gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    }

    gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel83<<<grid, block>>>(gpu_fb_Scales, j2, gpu_f);
    }
  }

  emxFree_real_T(&cpu_fb_Omega);
  nsubs = cpu_f->size[0] * cpu_f->size[1];
  cpu_f->size[0] = 1;
  emxEnsureCapacity_real_T(cpu_f, nsubs, &s_emlrtRTEI);
  nsubs = cpu_f->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(nsubs), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwtAvg_kernel22<<<grid, block>>>(fs, nsubs, gpu_f);
  }

  // 'ec_cwtAvg:29' freqs = centerFrequencies(fb);
  nsubs = cpu_freqs->size[0];
  cpu_freqs->size[0] = cpu_f->size[1];
  emxEnsureCapacity_real_T(cpu_freqs, nsubs, &u_emlrtRTEI);
  j2 = cpu_f->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_freqs, &gpu_freqs, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwtAvg_kernel23<<<grid, block>>>(gpu_f, j2, gpu_freqs);
  }

  emxFree_real_T(&cpu_f);

  //  Preallocate
  // 'ec_cwtAvg:32' xx = coder.nullcopy(x);
  //  Preallocate output
  //  CWT average power (L1-norm & variance-norm usng weighted integrals)
  // 'ec_cwtAvg:36' coder.gpu.kernel(nChs,-1)
  // 'ec_cwtAvg:37' for ch = 1:nChs
  emxInit_real32_T(&cpu_savgpTMP, 2, &wb_emlrtRTEI, true);
  if (computeEndIdx(1L, static_cast<int64_T>(nChs), 1L) >= 0L) {
    i34 = cpu_fb_Scales->size[1];
    outsize_idx_0 = cpu_fb_Scales->size[1];
  }

  emxInit_real32_T(&cpu_Scales, 2, &v_emlrtRTEI, true);
  emxInit_real32_T(&cpu_psihat, 2, &w_emlrtRTEI, true);
  emxInit_real32_T(&cpu_xv, 2, &x_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_xposdft, 2, &y_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_x, 2, &bb_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_cfsposdft, 2, &xb_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_cfspos, 2, &db_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_y, 2, &yb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_abscfssq, 2, &ac_emlrtRTEI, true);
  emxInit_real32_T(&cpu_a, 2, &fb_emlrtRTEI, true);
  emxInit_uint32_T(&g_cpu_y, 2, &bc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_z, 1, &cc_emlrtRTEI, true);
  emxInit_real_T(&cpu_c, 1, &ib_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_c, 1, &ib_emlrtRTEI, true);
  emxInit_real32_T(&h_cpu_y, 2, &dc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_abswt2, 2, &ec_emlrtRTEI, true);
  emxInit_real32_T(&cpu_abswt2S, 2, &jb_emlrtRTEI, true);
  emxInit_real32_T(&i_cpu_y, 2, &kb_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_c, 1, &ib_emlrtRTEI, true);
  d = computeEndIdx(1L, static_cast<int64_T>(nChs), 1L);
  for (int64_T ch{0L}; ch <= d; ch++) {
    real32_T normfac;
    real32_T varsig;
    real32_T xbar;
    boolean_T Scales_needsGpuEnsureCapacity;

    // 'ec_cwtAvg:38' coder.gpu.constantMemory(xx);
    // 'ec_cwtAvg:39' xx(:,ch) = scaleSpectrum(fb,x(:,ch),SpectrumType="density")';
    nsubs = cpu_Scales->size[0] * cpu_Scales->size[1];
    cpu_Scales->size[0] = 1;
    cpu_Scales->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real32_T(cpu_Scales, nsubs, &v_emlrtRTEI);
    j2 = cpu_fb_Scales->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_Scales, &gpu_Scales, true);
    Scales_needsGpuEnsureCapacity = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel24<<<grid, block>>>(gpu_fb_Scales, j2, gpu_Scales);
    }

    fb_Omega_outdatedOnCpu = true;
    nrefine = cpu_x->size[0] - 1;
    if (cpu_x->size[0] == 1) {
      xbar = cpu_x->data[cpu_x->size[0] * (static_cast<int32_T>(ch + 1L) - 1)];
      if ((!std::isinf(xbar)) && (!std::isnan(xbar))) {
        normfac = 0.0F;
      } else {
        normfac = rtNaNF;
      }
    } else {
      xbar = cpu_x->data[cpu_x->size[0] * (static_cast<int32_T>(ch + 1L) - 1)];
      for (lidx = 0; lidx < nrefine; lidx++) {
        xbar += cpu_x->data[(lidx + cpu_x->size[0] * (static_cast<int32_T>(ch +
          1L) - 1)) + 1];
      }

      xbar /= static_cast<real32_T>(cpu_x->size[0]);
      varsig = 0.0F;
      for (lidx = 0; lidx <= nrefine; lidx++) {
        cpu_t = cpu_x->data[lidx + cpu_x->size[0] * (static_cast<int32_T>(ch +
          1L) - 1)] - xbar;
        varsig += cpu_t * cpu_t;
      }

      normfac = varsig / static_cast<real32_T>(cpu_x->size[0]);
    }

    nsubs = cpu_psihat->size[0] * cpu_psihat->size[1];
    cpu_psihat->size[0] = cpu_daughter->size[0];
    cpu_psihat->size[1] = cpu_daughter->size[1];
    emxEnsureCapacity_real32_T(cpu_psihat, nsubs, &w_emlrtRTEI);
    j2 = cpu_daughter->size[0] * cpu_daughter->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    if (daughter_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter,
        !daughter_outdatedOnGpu);
    }

    daughter_needsGpuEnsureCapacity = false;
    gpuEmxEnsureCapacity_real32_T(cpu_psihat, &gpu_psihat, true);
    if (daughter_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_daughter, cpu_daughter);
    }

    daughter_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel25<<<grid, block>>>(gpu_daughter, j2, gpu_psihat);
    }

    nsubs = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    cpu_xv->size[1] = cpu_x->size[0];
    emxEnsureCapacity_real32_T(cpu_xv, nsubs, &x_emlrtRTEI);
    j2 = cpu_x->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_x, &b_gpu_x, !x_outdatedOnGpu);
    gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, true);
    y_needsGpuEnsureCapacity = false;
    if (x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_x, cpu_x);
    }

    x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel26<<<grid, block>>>(static_cast<int32_T>(ch + 1L), b_gpu_x,
        j2, gpu_xv, cpu_x->size[0U]);
    }

    fx_data_outdatedOnCpu = false;
    if (y > 0.0) {
      lidx = cpu_x->size[0] - static_cast<int32_T>(y);
      if (lidx + 1 > cpu_x->size[0]) {
        bcoef = 0;
        ix = 1;
        lidx = -1;
      } else {
        bcoef = cpu_x->size[0] - 1;
        ix = -1;
      }

      nsubs = c_cpu_x->size[0] * c_cpu_x->size[1];
      c_cpu_x->size[0] = 1;
      c_cpu_x->size[1] = static_cast<int32_T>(y);
      emxEnsureCapacity_real32_T(c_cpu_x, nsubs, &bb_emlrtRTEI);
      j2 = static_cast<int32_T>(y) - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(c_cpu_x, &c_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel27<<<grid, block>>>(static_cast<int32_T>(ch + 1L),
          b_gpu_x, j2, c_gpu_x, cpu_x->size[0U]);
      }

      mwGetLaunchParameters1D(computeNumIters((static_cast<int32_T>(y) >> 1) - 1),
        &grid, &block, 2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel28<<<grid, block>>>(y, (static_cast<int32_T>(y) >> 1) -
          1, c_gpu_x);
      }

      nsubs = cpu_xv->size[0] * cpu_xv->size[1];
      cpu_xv->size[0] = 1;
      cpu_xv->size[1] = ((cpu_x->size[0] + c_cpu_x->size[1]) + div_s32(lidx -
        bcoef, ix)) + 1;
      emxEnsureCapacity_real32_T(cpu_xv, nsubs, &cb_emlrtRTEI);
      nx = c_cpu_x->size[1];
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel29<<<grid, block>>>(c_gpu_x, nx - 1, gpu_xv);
      }

      c_omega_tmp1_needsGpuEnsureCapa = true;
      nx = cpu_x->size[0];
      for (nsubs = 0; nsubs < nx; nsubs++) {
        if (c_omega_tmp1_needsGpuEnsureCapa) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xv, &gpu_xv);
        }

        cpu_xv->data[nsubs + c_cpu_x->size[1]] = cpu_x->data[nsubs + cpu_x->
          size[0] * (static_cast<int32_T>(ch + 1L) - 1)];
        c_omega_tmp1_needsGpuEnsureCapa = false;
        fx_data_outdatedOnCpu = true;
        y_needsGpuEnsureCapacity = true;
      }

      nx = div_s32(lidx - bcoef, ix);
      for (nsubs = 0; nsubs <= nx; nsubs++) {
        if (c_omega_tmp1_needsGpuEnsureCapa) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xv, &gpu_xv);
        }

        cpu_xv->data[(nsubs + cpu_x->size[0]) + c_cpu_x->size[1]] = cpu_x->data
          [(bcoef + ix * nsubs) + cpu_x->size[0] * (static_cast<int32_T>(ch + 1L)
          - 1)];
        c_omega_tmp1_needsGpuEnsureCapa = false;
        fx_data_outdatedOnCpu = true;
        y_needsGpuEnsureCapacity = true;
      }
    }

    if (cpu_xv->size[1] - (static_cast<int32_T>(static_cast<uint32_T>
          (cpu_xv->size[1]) >> 1) << 1) == 1) {
      cufftHandle fftPlanHandle;
      nsubs = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = cpu_xv->size[1];
      emxEnsureCapacity_creal32_T(cpu_xposdft, nsubs, &y_emlrtRTEI);
      j2 = cpu_xv->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      if (y_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, !fx_data_outdatedOnCpu);
      }

      gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft, true);
      if (fx_data_outdatedOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
      }

      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel30<<<grid, block>>>(gpu_xv, j2, gpu_xposdft);
      }

      nrefine = cpu_xposdft->size[1];
      fftPlanHandle = acquireCUFFTPlan(1, &nrefine, &nrefine, 1, 1, CUFFT_C2C, 1);
      cufftExecC2C(fftPlanHandle, (cufftComplex *)&gpu_xposdft.data[0],
                   (cufftComplex *)&gpu_xposdft.data[0], CUFFT_FORWARD);
    } else {
      cufftHandle b_fftPlanHandle;
      nrefine = cpu_xv->size[1];
      for (j2 = 0; j2 < 2; j2++) {
        xSize[j2] = static_cast<uint32_T>(cpu_xv->size[j2]);
      }

      nsubs = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = static_cast<int32_T>(xSize[1]);
      emxEnsureCapacity_creal32_T(cpu_xposdft, nsubs, &ab_emlrtRTEI);
      b_fftPlanHandle = acquireCUFFTPlan(1, &nrefine, &nrefine, 1, 1, CUFFT_R2C,
        1);
      if (y_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, !fx_data_outdatedOnCpu);
      }

      gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft, true);
      if (fx_data_outdatedOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
      }

      cufftExecR2C(b_fftPlanHandle, (cufftReal *)&gpu_xv.data[0], (cufftComplex *)
                   &gpu_xposdft.data[0]);
      mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>
        (static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) / 2.0) - 2),
        &grid, &block, 2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel75<<<grid, block>>>(static_cast<int32_T>
          (static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) / 2.0) - 2,
          gpu_xposdft, xSize[1]);
      }
    }

    nrefine = cpu_psihat->size[1];
    i = cpu_xposdft->size[1];
    if (nrefine <= i) {
      i = nrefine;
    }

    if (cpu_psihat->size[1] == 1) {
      nsubs = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == cpu_psihat->size[1]) {
      nsubs = cpu_xposdft->size[1];
    } else {
      nsubs = i;
    }

    lidx = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
    cpu_cfsposdft->size[0] = cpu_psihat->size[0];
    nrefine = cpu_psihat->size[1];
    i = cpu_xposdft->size[1];
    if (nrefine <= i) {
      i = nrefine;
    }

    if (cpu_psihat->size[1] == 1) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == cpu_psihat->size[1]) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else {
      cpu_cfsposdft->size[1] = i;
    }

    emxEnsureCapacity_creal32_T(cpu_cfsposdft, lidx, &i_emlrtRTEI);
    y_needsGpuEnsureCapacity = true;
    if ((cpu_psihat->size[0] != 0) && (nsubs != 0)) {
      bcoef = (cpu_psihat->size[1] != 1);
      nx = cpu_cfsposdft->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(nsubs - 1, nx), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_cfsposdft, &gpu_cfsposdft, true);
      y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel31<<<grid, block>>>(gpu_xposdft, gpu_psihat, bcoef, nx,
          nsubs - 1, gpu_cfsposdft, cpu_psihat->size[0U], cpu_cfsposdft->size[0U]);
      }
    }

    if ((cpu_cfsposdft->size[0] == 0) || (cpu_cfsposdft->size[1] == 0)) {
      for (j2 = 0; j2 < 2; j2++) {
        xSize[j2] = static_cast<uint32_T>(cpu_cfsposdft->size[j2]);
      }

      xSize[1] = static_cast<uint32_T>(cpu_cfsposdft->size[1]);
      nsubs = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[0] = static_cast<int32_T>(xSize[0]);
      cpu_cfspos->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal32_T(cpu_cfspos, nsubs, &db_emlrtRTEI);
      j2 = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_cfspos, &gpu_cfspos, true);
      fx_data_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel32<<<grid, block>>>(j2, gpu_cfspos);
      }

      c_omega_tmp1_needsGpuEnsureCapa = false;
      y_needsGpuEnsureCapacity = true;
    } else {
      cufftHandle c_fftPlanHandle;
      nrefine = cpu_cfsposdft->size[1];
      c_fftPlanHandle = acquireCUFFTPlan(1, &nrefine, &nrefine,
        cpu_cfsposdft->size[0], 1, CUFFT_C2C, cpu_cfsposdft->size[0]);
      if (y_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_creal32_T(cpu_cfsposdft, &gpu_cfsposdft, true);
      }

      cufftExecC2C(c_fftPlanHandle, (cufftComplex *)&gpu_cfsposdft.data[0],
                   (cufftComplex *)&gpu_cfsposdft.data[0], CUFFT_INVERSE);
      nsubs = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[0] = cpu_cfsposdft->size[0];
      cpu_cfspos->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal32_T(cpu_cfspos, nsubs, &db_emlrtRTEI);
      xbar = static_cast<real32_T>(cpu_cfsposdft->size[1]);
      nx = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_cfspos, &gpu_cfspos, true);
      fx_data_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel74<<<grid, block>>>(xbar, gpu_cfsposdft, nx, gpu_cfspos);
      }

      c_omega_tmp1_needsGpuEnsureCapa = false;
      y_needsGpuEnsureCapacity = true;
    }

    if (y > 0.0) {
      N = static_cast<uint32_T>(y) + static_cast<uint32_T>(cpu_x->size[0]);
      if (static_cast<uint32_T>(static_cast<int32_T>(y) + 1) > N) {
        i = 0;
        bcoef = 0;
      } else {
        i = static_cast<int32_T>(y);
        bcoef = static_cast<int32_T>(N);
      }

      nrefine = cpu_cfspos->size[0];
      nx = bcoef - i;
      for (nsubs = 0; nsubs < nx; nsubs++) {
        for (lidx = 0; lidx < nrefine; lidx++) {
          if (y_needsGpuEnsureCapacity) {
            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_cfspos, &gpu_cfspos);
          }

          cpu_cfspos->data[lidx + nrefine * nsubs] = cpu_cfspos->data[lidx +
            cpu_cfspos->size[0] * (i + nsubs)];
          y_needsGpuEnsureCapacity = false;
          c_omega_tmp1_needsGpuEnsureCapa = true;
        }
      }

      nsubs = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[1] = bcoef - i;
      emxEnsureCapacity_creal32_T(cpu_cfspos, nsubs, &eb_emlrtRTEI);
      fx_data_outdatedOnCpu = true;
    }

    nrefine = 0;
    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (cpu_cv[static_cast<int32_T>(c_b[lidx])] != cpu_cv
            [static_cast<int32_T>(cv3[lidx])]) {
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
      nrefine = 1;
      for (j2 = 0; j2 < 5; j2++) {
        cpu_wav[j2] = d_b[j2];
      }
    } else {
      for (j2 = 0; j2 < 5; j2++) {
        cpu_wav[j2] = ' ';
      }
    }

    if (nrefine != 0) {
      for (j2 = 0; j2 < 5; j2++) {
        wavname[j2] = cpu_wav[j2];
      }
    }

    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (cpu_cv[static_cast<int32_T>(wavname[lidx])] != cpu_cv
            [static_cast<int32_T>(cv3[lidx])]) {
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
      cpu_r = 0.0057083835261;
      for (i = 0; i < 6; i++) {
        cpu_r = cpu_r / 177.7777777777778 + c[i];
      }

      cpu_r = (cpu_r / 13.333333333333334 - 13.333333333333334) +
        0.91893853320467278;
      cpu_r += 33.241761956554775;
      intFsq = 8.2480004101996545E-10 * std::exp(cpu_r);
    } else {
      ec_cwtAvg_kernel62<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
      ec_cwtAvg_kernel63<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>(*gpu_interval);
      interval_outdatedOnGpu = false;
      intFsq = 0.0;
      i = 1;
      checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
      nx = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
        (cpu_interval[0]);
      if (nx > 0) {
        cpu_r = 10.0 / static_cast<real_T>(nx);
        n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::ceil(std::abs
          (cpu_interval[1] - cpu_interval[0]) * cpu_r)) - 1);
        nsubs = static_cast<int32_T>(std::ceil(std::abs(cpu_interval[1] -
          cpu_interval[0]) * cpu_r));
        if (nsubs + 1 > 2) {
          nrefine = n_idx_0;
          cpu_interval[nsubs] = cpu_interval[1];
          interval_outdatedOnGpu = true;
          cpu_r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
            (n_idx_0) + 1.0);
          for (i = 0; i < nrefine; i++) {
            cpu_interval[(nsubs - i) - 1] = cpu_interval[0] + static_cast<real_T>
              (n_idx_0 - i) * cpu_r;
          }
        }

        i = nsubs;
      } else {
        nsubs = 1;
      }

      lidx = 0;
      for (nrefine = 0; nrefine < i; nrefine++) {
        if (std::abs(cpu_interval[nrefine + 1] - cpu_interval[lidx]) > 0.0) {
          lidx++;
          cpu_interval[lidx] = cpu_interval[nrefine + 1];
          interval_outdatedOnGpu = true;
        } else {
          nsubs--;
        }
      }

      if (nsubs + 1 < 2) {
        if (interval_outdatedOnGpu) {
          checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
            cudaMemcpyHostToDevice), __FILE__, __LINE__);
        }

        ec_cwtAvg_kernel64<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i,
          *gpu_interval);
        interval_outdatedOnGpu = false;
        nsubs = 1;
      }

      if (nx <= 0) {
        intFsq = 0.47999999999999976;
      } else {
        mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
          2147483647U);
        if (interval_outdatedOnGpu) {
          checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
            cudaMemcpyHostToDevice), __FILE__, __LINE__);
        }

        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel65<<<grid, block>>>(*gpu_interval, nsubs - 1,
            *gpu_subs);
        }

        subs_outdatedOnCpu = true;
        q_ok = 0.0;
        err_ok = 0.0;
        first_iteration = true;
        do {
          exitg1 = 0;
          interval_outdatedOnGpu = false;
          j2 = 15 * nsubs;
          ix = -1;
          for (lidx = 0; lidx < nsubs; lidx++) {
            if (subs_outdatedOnCpu) {
              checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                cudaMemcpyDeviceToHost), __FILE__, __LINE__);
            }

            fc = cpu_subs[lidx << 1];
            subs_outdatedOnCpu = false;
            b_r = cpu_subs[(lidx << 1) + 1];
            cpu_r = (fc + b_r) / 2.0;
            halfh = (b_r - fc) / 2.0;
            for (i = 0; i < 15; i++) {
              SD->f0.cpu_x_data[(ix + i) + 1] = NODES[i] * halfh + cpu_r;
              interval_outdatedOnGpu = true;
            }

            ix += 15;
          }

          mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel66<<<grid, block>>>(*gpu_x_data, j2 - 1,
              *gpu_xt_data, *b_gpu_x_data);
          }

          guard1 = false;
          if (!first_iteration) {
            checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data, 77880UL,
              cudaMemcpyDeviceToHost), __FILE__, __LINE__);
            cpu_r = std::abs(SD->f0.cpu_x_data[0]);
            lidx = 0;
            exitg2 = false;
            while ((!exitg2) && (lidx <= j2 - 2)) {
              tol = cpu_r;
              cpu_r = std::abs(SD->f0.cpu_x_data[lidx + 1]);
              if (std::abs(SD->f0.cpu_x_data[lidx + 1] - SD->f0.cpu_x_data[lidx])
                  <= 2.2204460492503131E-14 * std::fmax(tol, cpu_r)) {
                first_iteration = true;
                exitg2 = true;
              } else {
                lidx++;
              }
            }

            if (first_iteration) {
              mwGetLaunchParameters1D(computeNumIters(static_cast<int16_T>(j2) -
                1), &grid, &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel67<<<grid, block>>>(static_cast<int16_T>(j2) - 1,
                  *gpu_fx_data);
              }

              exitg1 = 1;
            } else {
              guard1 = true;
            }
          } else {
            guard1 = true;
          }

          if (guard1) {
            first_iteration = false;
            mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel68<<<grid, block>>>(*b_gpu_x_data, j2 - 1,
                *gpu_a_data);
            }

            mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel69<<<grid, block>>>(*gpu_a_data, j2 - 1,
                *gpu_y_data);
            }

            mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel70<<<grid, block>>>(*gpu_y_data, j2 - 1,
                *gpu_x_data);
            }

            mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel71<<<grid, block>>>(*gpu_x_data, j2 - 1,
                *b_gpu_y_data);
            }

            mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel72<<<grid, block>>>(*b_gpu_y_data, j2 - 1,
                *gpu_y_data);
            }

            mwGetLaunchParameters1D(computeNumIters(j2 - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel73<<<grid, block>>>(*gpu_xt_data, *b_gpu_x_data,
                *gpu_y_data, j2 - 1, *gpu_fx_data);
            }

            b_fx_data_outdatedOnCpu = true;
            cpu_r = 0.0;
            ix = -1;
            for (lidx = 0; lidx < nsubs; lidx++) {
              fc = 0.0;
              b_r = 0.0;
              for (i = 0; i < 15; i++) {
                if (b_fx_data_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *gpu_fx_data,
                    77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                fc += dv5[i] * SD->f0.cpu_fx_data[(ix + i) + 1];
                b_fx_data_outdatedOnCpu = false;
                b_r += dv6[i] * SD->f0.cpu_fx_data[(ix + i) + 1];
              }

              ix += 15;
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              subs_outdatedOnCpu = false;
              halfh = (cpu_subs[(lidx << 1) + 1] - cpu_subs[lidx << 1]) / 2.0;
              fc *= halfh;
              qsub[lidx] = fc;
              cpu_r += fc;
              errsub[lidx] = b_r * halfh;
            }

            intFsq = cpu_r + q_ok;
            tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
            cpu_r = 2.0 * tol / static_cast<real_T>(nx);
            b_r = 0.0;
            nrefine = 0;
            for (lidx = 0; lidx < nsubs; lidx++) {
              fc = errsub[lidx];
              halfh = std::abs(fc);
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              subs_outdatedOnCpu = false;
              if (halfh <= cpu_r * ((cpu_subs[(lidx << 1) + 1] - cpu_subs[lidx <<
                    1]) / 2.0)) {
                err_ok += fc;
                q_ok += qsub[lidx];
              } else {
                b_r += halfh;
                nrefine++;
                cpu_subs[(nrefine - 1) << 1] = cpu_subs[lidx << 1];
                cpu_subs[((nrefine - 1) << 1) + 1] = cpu_subs[(lidx << 1) + 1];
              }
            }

            cpu_r = std::abs(err_ok) + b_r;
            if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::isinf
                  (cpu_r)) && (!std::isnan(cpu_r))) && (nrefine != 0) &&
                (!(cpu_r <= tol))) {
              nsubs = nrefine << 1;
              if (nsubs > 650) {
                exitg1 = 1;
              } else {
                for (lidx = 0; lidx < nrefine; lidx++) {
                  if (subs_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                      cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  cpu_subs[((((nrefine - lidx) << 1) - 1) << 1) + 1] = cpu_subs
                    [(((nrefine - lidx) - 1) << 1) + 1];
                  cpu_subs[(((nrefine - lidx) << 1) - 1) << 1] = (cpu_subs
                    [((nrefine - lidx) - 1) << 1] + cpu_subs[(((nrefine - lidx)
                    - 1) << 1) + 1]) / 2.0;
                  cpu_subs[((((nrefine - lidx) << 1) - 2) << 1) + 1] = cpu_subs
                    [(((nrefine - lidx) << 1) - 1) << 1];
                  cpu_subs[(((nrefine - lidx) << 1) - 2) << 1] = cpu_subs
                    [((nrefine - lidx) - 1) << 1];
                  subs_outdatedOnCpu = false;
                }
              }
            } else {
              exitg1 = 1;
            }
          }
        } while (exitg1 == 0);
      }
    }

    i = cpu_cfspos->size[0] * cpu_cfspos->size[1];
    for (j2 = 0; j2 < 2; j2++) {
      xSize[j2] = static_cast<uint32_T>(cpu_cfspos->size[j2]);
    }

    nsubs = f_cpu_y->size[0] * f_cpu_y->size[1];
    f_cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    f_cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(f_cpu_y, nsubs, &l_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(i - 1), &grid, &block, 2147483647U);
    if (fx_data_outdatedOnCpu) {
      gpuEmxEnsureCapacity_creal32_T(cpu_cfspos, &gpu_cfspos,
        !c_omega_tmp1_needsGpuEnsureCapa);
    }

    gpuEmxEnsureCapacity_real32_T(f_cpu_y, &c_gpu_y, true);
    if (c_omega_tmp1_needsGpuEnsureCapa) {
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_cfspos, cpu_cfspos);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel33<<<grid, block>>>(gpu_cfspos, i - 1, c_gpu_y);
    }

    for (j2 = 0; j2 < 2; j2++) {
      xSize[j2] = static_cast<uint32_T>(f_cpu_y->size[j2]);
    }

    nsubs = cpu_abscfssq->size[0] * cpu_abscfssq->size[1];
    cpu_abscfssq->size[0] = static_cast<int32_T>(xSize[0]);
    cpu_abscfssq->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(cpu_abscfssq, nsubs, &f_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(xSize[0]) *
      static_cast<int32_T>(xSize[1]) - 1), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_abscfssq, &gpu_abscfssq, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel34<<<grid, block>>>(c_gpu_y, static_cast<int32_T>(xSize[0])
        * static_cast<int32_T>(xSize[1]) - 1, gpu_abscfssq);
    }

    nsubs = cpu_a->size[0] * cpu_a->size[1];
    cpu_a->size[0] = cpu_abscfssq->size[0];
    cpu_a->size[1] = cpu_abscfssq->size[1];
    emxEnsureCapacity_real32_T(cpu_a, nsubs, &fb_emlrtRTEI);
    j2 = cpu_abscfssq->size[0] * cpu_abscfssq->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel35<<<grid, block>>>(gpu_abscfssq, j2, gpu_a);
    }

    nrefine = cpu_Scales->size[1];
    i = cpu_abscfssq->size[0];
    if (nrefine <= i) {
      i = nrefine;
    }

    if (cpu_Scales->size[1] == 1) {
      nsubs = cpu_abscfssq->size[0];
    } else if (cpu_abscfssq->size[0] == 1) {
      nsubs = cpu_Scales->size[1];
    } else if (cpu_abscfssq->size[0] == cpu_Scales->size[1]) {
      nsubs = cpu_abscfssq->size[0];
    } else {
      nsubs = i;
    }

    lidx = cpu_abscfssq->size[1];
    wav_outdatedOnCpu = false;
    nrefine = cpu_abscfssq->size[0] * cpu_abscfssq->size[1];
    cpu_abscfssq->size[0] = nsubs;
    cpu_abscfssq->size[1] = lidx;
    emxEnsureCapacity_real32_T(cpu_abscfssq, nrefine, &i_emlrtRTEI);
    y_needsGpuEnsureCapacity = true;
    if ((nsubs != 0) && (lidx != 0)) {
      nrefine = (cpu_a->size[1] != 1);
      j2 = cpu_abscfssq->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(lidx - 1, j2), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_abscfssq, &gpu_abscfssq, true);
      y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel36<<<grid, block>>>(gpu_Scales, gpu_a, nrefine, j2, lidx
          - 1, gpu_abscfssq, cpu_a->size[0U], cpu_Scales->size[1U],
          cpu_abscfssq->size[0U]);
      }

      wav_outdatedOnCpu = true;
    }

    if (cpu_abscfssq->size[1] < 1) {
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = 0;
    } else {
      N = static_cast<uint32_T>(cpu_abscfssq->size[1]);
      nsubs = g_cpu_y->size[0] * g_cpu_y->size[1];
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = cpu_abscfssq->size[1];
      emxEnsureCapacity_uint32_T(g_cpu_y, nsubs, &e_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(N) - 1),
        &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_uint32_T(g_cpu_y, &d_gpu_y, true);
      c_y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel61<<<grid, block>>>(static_cast<int32_T>(N) - 1, d_gpu_y);
      }
    }

    nsubs = cpu_z->size[0];
    cpu_z->size[0] = cpu_abscfssq->size[0];
    emxEnsureCapacity_real32_T(cpu_z, nsubs, &gb_emlrtRTEI);
    j2 = cpu_abscfssq->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z, true);
    interval_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel37<<<grid, block>>>(j2, gpu_z);
    }

    b_y_needsGpuEnsureCapacity = false;
    if (cpu_abscfssq->size[1] > 1) {
      if (g_cpu_y->size[1] == 1) {
        nrefine = cpu_abscfssq->size[1];
        nsubs = cpu_c->size[0];
        cpu_c->size[0] = cpu_abscfssq->size[1];
        emxEnsureCapacity_real_T(cpu_c, nsubs, &ib_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(nrefine - 1), &grid, &block,
          2147483647U);
        if (c_y_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_uint32_T(g_cpu_y, &d_gpu_y, true);
        }

        gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel38<<<grid, block>>>(d_gpu_y, nrefine - 1, gpu_c);
        }

        c_y_needsGpuEnsureCapacity = false;
        ec_cwtAvg_kernel39<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_y,
          gpu_c, gpu_r);
        if (y_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(cpu_abscfssq, &gpu_abscfssq, true);
        }

        ec_cwtAvg_kernel40<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_r, gpu_c,
          cpu_abscfssq->size[1U]);
        fx_data_outdatedOnCpu = true;
      } else {
        nsubs = cpu_c->size[0];
        cpu_c->size[0] = cpu_abscfssq->size[1];
        emxEnsureCapacity_real_T(cpu_c, nsubs, &hb_emlrtRTEI);
        if (c_y_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_uint32_T(g_cpu_y, &d_gpu_y, true);
        }

        gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c, true);
        ec_cwtAvg_kernel58<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_y,
          gpu_c);
        nrefine = cpu_abscfssq->size[1];
        mwGetLaunchParameters1D(computeNumIters(nrefine - 3), &grid, &block,
          2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel59<<<grid, block>>>(d_gpu_y, nrefine - 3, gpu_c);
        }

        c_y_needsGpuEnsureCapacity = false;
        if (y_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(cpu_abscfssq, &gpu_abscfssq, true);
        }

        ec_cwtAvg_kernel60<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_y,
          gpu_c, cpu_abscfssq->size[1U]);
        fx_data_outdatedOnCpu = true;
      }

      lidx = cpu_abscfssq->size[0];
      if (cpu_abscfssq->size[0] != 0) {
        int64_T e;
        nrefine = cpu_abscfssq->size[0];
        mwGetLaunchParameters1D(computeNumIters(nrefine - 1), &grid, &block,
          2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel41<<<grid, block>>>(nrefine - 1, gpu_z);
        }

        c_omega_tmp1_needsGpuEnsureCapa = true;
        ix = 0;
        nrefine = cpu_abscfssq->size[0] * (cpu_abscfssq->size[1] - 1) + 1;
        e = computeEndIdx(1L, static_cast<int64_T>(nrefine), static_cast<int64_T>
                          (lidx));
        for (int64_T iac{0L}; iac <= e; iac++) {
          int64_T f;
          f = computeEndIdx(static_cast<int64_T>(static_cast<int32_T>(iac * lidx
            + 1L)), static_cast<int64_T>((static_cast<int32_T>(iac * lidx + 1L)
            + lidx) - 1), 1L);
          for (int64_T ia{0L}; ia <= f; ia++) {
            if (c_omega_tmp1_needsGpuEnsureCapa) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_z, &gpu_z);
            }

            if (wav_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_abscfssq, &gpu_abscfssq);
            }

            wav_outdatedOnCpu = false;
            if (fx_data_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_c, &gpu_c);
            }

            fx_data_outdatedOnCpu = false;
            cpu_z->data[static_cast<int32_T>(ia)] += cpu_abscfssq->data[
              static_cast<int32_T>(static_cast<int32_T>(iac * lidx + 1L) + ia) -
              1] * static_cast<real32_T>(cpu_c->data[ix]);
            c_omega_tmp1_needsGpuEnsureCapa = false;
            b_y_needsGpuEnsureCapacity = true;
            interval_outdatedOnGpu = true;
          }

          ix++;
        }
      }
    }

    cpu_t = 0.0F;
    y_needsGpuEnsureCapacity = false;
    if (cpu_z->size[0] <= 1) {
      if (cpu_Scales->size[1] == 1) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_Scales, &gpu_Scales);
        fb_Omega_outdatedOnCpu = false;
        if (std::isinf(cpu_Scales->data[0]) || std::isnan(cpu_Scales->data[0]))
        {
          Scales_needsGpuEnsureCapacity = true;
          cpu_t = rtNaNF;
        } else {
          Scales_needsGpuEnsureCapacity = true;
        }
      }
    } else {
      if (cpu_Scales->size[1] == 1) {
        nrefine = cpu_z->size[0];
        nsubs = b_cpu_c->size[0];
        b_cpu_c->size[0] = cpu_z->size[0];
        emxEnsureCapacity_real32_T(b_cpu_c, nsubs, &ib_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(nrefine - 1), &grid, &block,
          2147483647U);
        gpuEmxEnsureCapacity_real32_T(b_cpu_c, &c_gpu_c, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel53<<<grid, block>>>(gpu_Scales, nrefine - 1, c_gpu_c);
        }

        gpuEmxMemcpyGpuToCpu_real32_T(cpu_Scales, &gpu_Scales);
        fb_Omega_outdatedOnCpu = false;
        xbar = 0.5F * cpu_Scales->data[0];
        Scales_needsGpuEnsureCapacity = true;
        if (interval_outdatedOnGpu) {
          gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z,
            !b_y_needsGpuEnsureCapacity);
        }

        if (b_y_needsGpuEnsureCapacity) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
        }

        ec_cwtAvg_kernel54<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(xbar,
          c_gpu_c, cpu_z->size[0U]);
      } else {
        nsubs = b_cpu_c->size[0];
        b_cpu_c->size[0] = cpu_z->size[0];
        emxEnsureCapacity_real32_T(b_cpu_c, nsubs, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_c, &c_gpu_c, true);
        ec_cwtAvg_kernel55<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_Scales,
          c_gpu_c);
        nrefine = cpu_z->size[0];
        mwGetLaunchParameters1D(computeNumIters(nrefine - 3), &grid, &block,
          2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel56<<<grid, block>>>(gpu_Scales, nrefine - 3, c_gpu_c);
        }

        if (interval_outdatedOnGpu) {
          gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z,
            !b_y_needsGpuEnsureCapacity);
        }

        if (b_y_needsGpuEnsureCapacity) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
        }

        ec_cwtAvg_kernel57<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_Scales,
          c_gpu_c, cpu_z->size[0U]);
      }

      xbar = 0.0F;
      varsig = 1.0F;
      checkCudaError(cudaMemcpy(gpu_t, &cpu_t, 4UL, cudaMemcpyHostToDevice),
                     __FILE__, __LINE__);
      cublasCheck(cublasSgemv(getCublasGlobalHandle(), CUBLAS_OP_T, cpu_z->size
        [0], 1, (float *)&varsig, (float *)&gpu_z.data[0], cpu_z->size[0],
        (float *)&c_gpu_c.data[0], 1, (float *)&xbar, (float *)gpu_t, 1),
                  __FILE__, __LINE__);
      y_needsGpuEnsureCapacity = true;
    }

    if (!(normfac == 0.0F)) {
      if (y_needsGpuEnsureCapacity) {
        checkCudaError(cudaMemcpy(&cpu_t, gpu_t, 4UL, cudaMemcpyDeviceToHost),
                       __FILE__, __LINE__);
      }

      xbar = std::sqrt(normfac / (static_cast<real32_T>(2.0 / intFsq /
        static_cast<real_T>(cpu_abscfssq->size[1])) * cpu_t));
      nsubs = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
        2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel42<<<grid, block>>>(xbar, nsubs - 1, gpu_cfspos);
      }
    }

    i = cpu_cfspos->size[0] * cpu_cfspos->size[1];
    for (j2 = 0; j2 < 2; j2++) {
      xSize[j2] = static_cast<uint32_T>(cpu_cfspos->size[j2]);
    }

    nsubs = h_cpu_y->size[0] * h_cpu_y->size[1];
    h_cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    h_cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(h_cpu_y, nsubs, &l_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(i - 1), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(h_cpu_y, &e_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel43<<<grid, block>>>(gpu_cfspos, i - 1, e_gpu_y);
    }

    for (j2 = 0; j2 < 2; j2++) {
      xSize[j2] = static_cast<uint32_T>(h_cpu_y->size[j2]);
    }

    nsubs = cpu_abswt2->size[0] * cpu_abswt2->size[1];
    cpu_abswt2->size[0] = static_cast<int32_T>(xSize[0]);
    cpu_abswt2->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(cpu_abswt2, nsubs, &f_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(xSize[0]) *
      static_cast<int32_T>(xSize[1]) - 1), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_abswt2, &gpu_abswt2, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel44<<<grid, block>>>(e_gpu_y, static_cast<int32_T>(xSize[0])
        * static_cast<int32_T>(xSize[1]) - 1, gpu_abswt2);
    }

    if (cpu_abswt2->size[0] == cpu_Scales->size[1]) {
      nsubs = cpu_abswt2S->size[0] * cpu_abswt2S->size[1];
      cpu_abswt2S->size[0] = cpu_abswt2->size[0];
      cpu_abswt2S->size[1] = cpu_abswt2->size[1];
      emxEnsureCapacity_real32_T(cpu_abswt2S, nsubs, &jb_emlrtRTEI);
      j2 = cpu_abswt2->size[1] - 1;
      nx = cpu_abswt2->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2, nx), &grid, &block,
        2147483647U);
      if (Scales_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_Scales, &gpu_Scales, true);
      }

      Scales_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_real32_T(cpu_abswt2S, &gpu_abswt2S, true);
      fx_data_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel45<<<grid, block>>>(gpu_Scales, gpu_abswt2, nx, j2,
          gpu_abswt2S, cpu_abswt2S->size[0U], cpu_abswt2->size[0U]);
      }

      y_needsGpuEnsureCapacity = false;
      abswt2S_outdatedOnCpu = true;
    } else {
      if (abswt2S_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_abswt2S, &gpu_abswt2S);
      }

      gpuEmxMemcpyGpuToCpu_real32_T(cpu_abswt2, &gpu_abswt2);
      if (fb_Omega_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_Scales, &gpu_Scales);
      }

      binary_expand_op(cpu_abswt2S, cpu_abswt2, cpu_Scales);
      abswt2S_outdatedOnCpu = false;
      y_needsGpuEnsureCapacity = true;
      Scales_needsGpuEnsureCapacity = true;
      fx_data_outdatedOnCpu = true;
    }

    nsubs = i_cpu_y->size[0] * i_cpu_y->size[1];
    i_cpu_y->size[0] = outsize_idx_0;
    i_cpu_y->size[1] = cpu_abswt2S->size[1];
    emxEnsureCapacity_real32_T(i_cpu_y, nsubs, &kb_emlrtRTEI);
    j2 = cpu_abswt2S->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(j2, outsize_idx_0 - 1), &grid,
      &block, 2147483647U);
    if (fx_data_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real32_T(cpu_abswt2S, &gpu_abswt2S,
        !y_needsGpuEnsureCapacity);
    }

    gpuEmxEnsureCapacity_real32_T(i_cpu_y, &f_gpu_y, true);
    if (y_needsGpuEnsureCapacity) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_abswt2S, cpu_abswt2S);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel46<<<grid, block>>>(gpu_abswt2S, outsize_idx_0 - 1, j2,
        f_gpu_y, i_cpu_y->size[0U], cpu_abswt2S->size[0U]);
    }

    if ((outsize_idx_0 != 0) || (cpu_abswt2S->size[1] != 0)) {
      nsubs = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
      cpu_savgpTMP->size[0] = 1;
      cpu_savgpTMP->size[1] = cpu_abswt2S->size[1];
      emxEnsureCapacity_real32_T(cpu_savgpTMP, nsubs, &lb_emlrtRTEI);
      j2 = cpu_abswt2S->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(j2), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_savgpTMP, &gpu_savgpTMP, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel47<<<grid, block>>>(j2, gpu_savgpTMP);
      }

      if (outsize_idx_0 > 1) {
        if (i34 == 1) {
          nsubs = c_cpu_c->size[0];
          c_cpu_c->size[0] = outsize_idx_0;
          emxEnsureCapacity_real32_T(c_cpu_c, nsubs, &ib_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(outsize_idx_0 - 1), &grid,
            &block, 2147483647U);
          if (Scales_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_Scales, &gpu_Scales, true);
          }

          gpuEmxEnsureCapacity_real32_T(c_cpu_c, &b_gpu_c, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel48<<<grid, block>>>(gpu_Scales, outsize_idx_0 - 1,
              b_gpu_c);
          }

          ec_cwtAvg_kernel49<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (outsize_idx_0, gpu_Scales, b_gpu_c);
        } else {
          nsubs = c_cpu_c->size[0];
          c_cpu_c->size[0] = outsize_idx_0;
          emxEnsureCapacity_real32_T(c_cpu_c, nsubs, &hb_emlrtRTEI);
          if (Scales_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_Scales, &gpu_Scales, true);
          }

          gpuEmxEnsureCapacity_real32_T(c_cpu_c, &b_gpu_c, true);
          ec_cwtAvg_kernel50<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_Scales,
            b_gpu_c);
          mwGetLaunchParameters1D(computeNumIters(outsize_idx_0 - 3), &grid,
            &block, 2147483647U);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel51<<<grid, block>>>(gpu_Scales, outsize_idx_0 - 3,
              b_gpu_c);
          }

          ec_cwtAvg_kernel52<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_Scales,
            outsize_idx_0, b_gpu_c);
        }

        if (cpu_abswt2S->size[1] >= 1) {
          xbar = 0.0F;
          varsig = 1.0F;
          cublasCheck(cublasSgemv(getCublasGlobalHandle(), CUBLAS_OP_T,
            outsize_idx_0, cpu_abswt2S->size[1], (float *)&varsig, (float *)
            &f_gpu_y.data[0], outsize_idx_0, (float *)&b_gpu_c.data[0], 1,
            (float *)&xbar, (float *)&gpu_savgpTMP.data[0], 1), __FILE__,
                      __LINE__);
        }
      }
    }
  }

  emxFree_real32_T(&c_cpu_c);
  emxFree_real32_T(&i_cpu_y);
  emxFree_real32_T(&cpu_abswt2S);
  emxFree_real32_T(&cpu_abswt2);
  emxFree_real32_T(&h_cpu_y);
  emxFree_real32_T(&b_cpu_c);
  emxFree_real_T(&cpu_c);
  emxFree_real32_T(&cpu_z);
  emxFree_uint32_T(&g_cpu_y);
  emxFree_real32_T(&cpu_a);
  emxFree_real32_T(&cpu_abscfssq);
  emxFree_real32_T(&f_cpu_y);
  emxFree_creal32_T(&cpu_cfspos);
  emxFree_creal32_T(&cpu_cfsposdft);
  emxFree_real32_T(&c_cpu_x);
  emxFree_creal32_T(&cpu_xposdft);
  emxFree_real32_T(&cpu_xv);
  emxFree_real32_T(&cpu_psihat);
  emxFree_real32_T(&cpu_Scales);
  emxFree_real32_T(&cpu_savgpTMP);
  emxFree_real_T(&cpu_daughter);
  emxFree_real_T(&cpu_fb_Scales);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxMemcpyGpuToCpu_real_T(cpu_freqs, &gpu_freqs);
  gpuEmxFree_real32_T(&b_gpu_x);
  gpuEmxFree_real_T(&gpu_freqs);
  checkCudaError(mwCudaFree(gpu_r), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_wav), __FILE__, __LINE__);
  gpuEmxFree_int32_T(&gpu_omega_tmp1);
  checkCudaError(mwCudaFree(*gpu_wname), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_omega_tmp2);
  checkCudaError(mwCudaFree(*gpu_interval), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_fb_Omega);
  checkCudaError(mwCudaFree(*gpu_subs), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_x_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_fb_Scales);
  checkCudaError(mwCudaFree(*b_gpu_x_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_xt_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_y);
  checkCudaError(mwCudaFree(*gpu_y_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&b_gpu_y);
  checkCudaError(mwCudaFree(*b_gpu_y_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*e_gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&h_gpu_y);
  checkCudaError(mwCudaFree(*gpu_a_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&i_gpu_y);
  checkCudaError(mwCudaFree(*gpu_dv10_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_dv4_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*d_gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_daughter);
  gpuEmxFree_real_T(&gpu_f);
  gpuEmxFree_real_T(&b_gpu_somega);
  gpuEmxFree_real_T(&gpu_somega);
  gpuEmxFree_real_T(&gpu_w);
  gpuEmxFree_real_T(&gpu_absomega);
  gpuEmxFree_real_T(&gpu_expnt);
  checkCudaError(mwCudaFree(*c_gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_powscales);
  checkCudaError(mwCudaFree(*b_gpu_a_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&g_gpu_y);
  checkCudaError(mwCudaFree(*gpu_dv15_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_dv11_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*b_gpu_fx_data), __FILE__, __LINE__);
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
  gpuEmxFree_uint32_T(&d_gpu_y);
  gpuEmxFree_real32_T(&gpu_z);
  gpuEmxFree_real_T(&gpu_c);
  gpuEmxFree_real32_T(&c_gpu_c);
  gpuEmxFree_real32_T(&e_gpu_y);
  gpuEmxFree_real32_T(&gpu_abswt2);
  gpuEmxFree_real32_T(&gpu_abswt2S);
  gpuEmxFree_real32_T(&f_gpu_y);
  gpuEmxFree_real32_T(&b_gpu_c);
  checkCudaError(mwCudaFree(gpu_t), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_fx_data), __FILE__, __LINE__);
}

void ec_cwtAvg_api(ec_cwtAvgStackData *SD, const mxArray * const prhs[4],
                   int32_T nlhs, const mxArray *plhs[2])
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
  ec_cwtAvg(SD, x, fs, *fLims, fOctave, freqs);

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
  try {
    emlrtPushHeapReferenceStackR2021a(emlrtRootTLSGlobal, false, nullptr, (void *)
      &emlrtExitTimeCleanupDtorFcn, nullptr, nullptr, nullptr);
    emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
    emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
    emlrtExitTimeCleanup(&emlrtContextGlobal);
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }

  mwCudaFree(*global_gpu_cv);
}

void ec_cwtAvg_initialize()
{
  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
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
}

// End of code generation (ec_cwtAvg.cu)
