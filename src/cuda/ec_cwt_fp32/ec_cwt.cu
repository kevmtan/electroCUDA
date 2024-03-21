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
#include "cufft.h"
#include "math_constants.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include <algorithm>
#include <cmath>
#include <cstring>

// Type Definitions
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
  131643U,                             // fVersionInfo
  nullptr,                             // fErrorFunction
  "ec_cwt",                            // fFunctionName
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

static emlrtRTEInfo emlrtRTEI{ 999,    // lineNo
  17,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo b_emlrtRTEI{ 1000, // lineNo
  17,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 1009, // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 28,   // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 28,   // lineNo
  1,                                   // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 18,   // lineNo
  5,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 60,   // lineNo
  20,                                  // colNo
  "bsxfun",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/bsxfun.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 18,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 31,   // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 30,   // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 33,   // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 25,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 31,   // lineNo
  23,                                  // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 31,   // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 34,   // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 33,   // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 956,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 41,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 30,   // lineNo
  1,                                   // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 32,   // lineNo
  24,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 35,   // lineNo
  21,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
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

static emlrtRTEInfo fb_emlrtRTEI{ 42,  // lineNo
  6,                                   // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 44,  // lineNo
  16,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 44,  // lineNo
  10,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 1276,// lineNo
  30,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 1276,// lineNo
  25,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 26,  // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 21,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 32,  // lineNo
  18,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 34,  // lineNo
  42,                                  // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 32,  // lineNo
  13,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 934, // lineNo
  26,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 32,  // lineNo
  18,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 151, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 42,  // lineNo
  12,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 1,   // lineNo
  23,                                  // colNo
  "ec_cwt",                            // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "_coder_ec_cwt_api",                 // fName
  ""                                   // pName
};

static char_T (*global_gpu_cv)[128];
static boolean_T gpuConstsCopied_ec_cwt;

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real32_T *ret);
static real_T (*b_emlrt_marshallIn(const mxArray *b_nullptr, const char_T
  *identifier))[2];
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2];
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_char_T *ret);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_1(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_3(real_T in1_data[], int32_T in1_size[2], const
  real_T in2_data[], const int32_T in2_size[2], const real_T in3_data[], const
  int32_T in3_size[2], const real_T in4_data[], const int32_T in4_size[2]);
static real32_T c_emlrt_marshallIn(const mxArray *b_nullptr, const char_T
  *identifier);
static real32_T c_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T
  b_line);
static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static uint64_T computeNumIters(int32_T ub);
static uint64_T computeNumIters(int32_T ub, int32_T b_ub);
static real_T d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static int32_T div_s32(int32_T numerator, int32_T denominator);
static real_T (*e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2];
static __global__ void ec_cwt_kernel1(const char_T cv[128], char_T wname[5],
  char_T wav[5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3,
  char_T b_dim4);
static __global__ void ec_cwt_kernel10(const emxArray_real_T omega_tmp2, const
  int32_T b, emxArray_real_T fb_Omega);
static __global__ void ec_cwt_kernel11(const int32_T nrefine, const int32_T lidx,
  const emxArray_real_T omega_tmp2, const int32_T nsubs, emxArray_real_T
  fb_Omega, int32_T omega_tmp2_dim1);
static __global__ void ec_cwt_kernel12(emxArray_real_T y);
static __global__ void ec_cwt_kernel13(const emxArray_real_T y, const real_T tol,
  const int32_T b, emxArray_real_T b_y);
static __global__ void ec_cwt_kernel14(const emxArray_real_T y, const real_T
  halfh, const int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ec_cwt_kernel15(const emxArray_real_T somega, const
  int32_T b, emxArray_real_T absomega);
static __global__ void ec_cwt_kernel16(const emxArray_real_T absomega, const
  int32_T b_absomega, emxArray_real_T powscales);
static __global__ void ec_cwt_kernel17(const int32_T b, emxArray_real_T absomega);
static __global__ void ec_cwt_kernel18(const emxArray_real_T powscales, const
  emxArray_real_T absomega, const int32_T b_absomega, emxArray_real_T x);
static __global__ void ec_cwt_kernel19(const int32_T b, emxArray_real_T x);
static __global__ void ec_cwt_kernel2(real_T interval[650]);
static __global__ void ec_cwt_kernel20(const emxArray_real_T somega, const
  emxArray_real_T x, const int32_T b_x, emxArray_real_T daughter);
static __global__ void ec_cwt_kernel21(const emxArray_real_T fb_Scales, const
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ec_cwt_kernel22(const real_T fs, const int32_T i,
  emxArray_real_T f);
static __global__ void ec_cwt_kernel23(const emxArray_real_T f, const int32_T
  b_f, emxArray_real_T freqs);
static __global__ void ec_cwt_kernel24(const emxArray_real_T daughter, const
  int32_T b_daughter, emxArray_real32_T psihat);
static __global__ void ec_cwt_kernel25(const int32_T nrefine, const
  emxArray_real32_T x, const int32_T b_x, emxArray_real32_T xv, int32_T x_dim0);
static __global__ void ec_cwt_kernel26(const int32_T nrefine, const
  emxArray_real32_T x, const int32_T b, emxArray_real32_T b_x, int32_T x_dim0);
static __global__ void ec_cwt_kernel27(const int32_T fb_SignalPad, const int32_T
  b, emxArray_real32_T x);
static __global__ void ec_cwt_kernel28(const emxArray_real32_T x, const int32_T
  b, emxArray_real32_T xv);
static __global__ void ec_cwt_kernel29(const emxArray_real32_T xv, const int32_T
  b_xv, emxArray_creal32_T xposdft);
static __global__ void ec_cwt_kernel3(real_T interval[650]);
static __global__ void ec_cwt_kernel30(const emxArray_creal32_T xposdft, const
  emxArray_real32_T psihat, const int32_T lidx, const int32_T cfsposdft, const
  int32_T pathlen, emxArray_creal32_T b_cfsposdft, int32_T psihat_dim0, int32_T
  cfsposdft_dim0);
static __global__ void ec_cwt_kernel31(const int32_T xSize, emxArray_creal32_T
  cfspos);
static __global__ void ec_cwt_kernel32(const emxArray_creal32_T cfspos, const
  int32_T b, emxArray_real32_T y);
static __global__ void ec_cwt_kernel33(const emxArray_real32_T y, const int32_T
  b_y, const int32_T c_y, emxArray_real32_T xCh, int32_T xCh_dim0, int32_T
  y_dim0);
static __global__ void ec_cwt_kernel34(const emxArray_real32_T xCh, const
  int32_T pathlen, const int32_T b, const int32_T c, emxArray_real32_T b_xCh,
  int32_T xCh_dim0, int32_T b_xCh_dim0);
static __global__ void ec_cwt_kernel35(const emxArray_real32_T xCh, const
  int32_T b_xCh, emxArray_real32_T c_xCh);
static __global__ void ec_cwt_kernel36(const emxArray_real32_T xCh, const
  int32_T xx_dim0, const int32_T nrefine, const int32_T xx, const int32_T b_xx,
  emxArray_real32_T c_xx, int32_T b_xx_dim0, int32_T xx_dim1);
static __global__ void ec_cwt_kernel37(const real32_T cfsposdft_re, const
  emxArray_creal32_T cfsposdft, const int32_T b_cfsposdft, emxArray_creal32_T
  cfspos);
static __global__ void ec_cwt_kernel38(const int32_T b, emxArray_creal32_T
  xposdft, uint32_T xSize_dim1);
static __global__ void ec_cwt_kernel39(const real32_T ds2, const int32_T b,
  emxArray_real32_T fv);
static __global__ void ec_cwt_kernel4(const int32_T k, real_T interval[650]);
static __global__ void ec_cwt_kernel40(const emxArray_real_T fb_Omega, const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, const int32_T b,
  emxArray_real_T somega, int32_T somega_dim0);
static __global__ void ec_cwt_kernel41(const emxArray_real_T somega, const
  int32_T b_somega, emxArray_real_T w);
static __global__ void ec_cwt_kernel42(const emxArray_real_T w, const int32_T
  b_w, emxArray_real_T expnt);
static __global__ void ec_cwt_kernel43(const int32_T b, emxArray_real_T expnt);
static __global__ void ec_cwt_kernel44(const emxArray_real_T w, const int32_T b,
  emxArray_real_T y);
static __global__ void ec_cwt_kernel45(const emxArray_real_T y, const
  emxArray_real_T expnt, const int32_T b_expnt, emxArray_real_T daughter);
static __global__ void ec_cwt_kernel46(const int32_T nrefine, emxArray_real_T
  daughter);
static __global__ void ec_cwt_kernel47(const emxArray_real_T fb_Scales, const
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ec_cwt_kernel48(const emxArray_real_T fb_Omega, const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, const int32_T b,
  emxArray_real_T somega, int32_T somega_dim0);
static __global__ void ec_cwt_kernel49(const int32_T b, emxArray_real_T y);
static __global__ void ec_cwt_kernel5(real_T interval[650]);
static __global__ void ec_cwt_kernel50(const char_T cv[128], char_T wav[5],
  char_T wname[5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3,
  char_T b_dim4);
static __global__ void ec_cwt_kernel51(real_T interval[650]);
static __global__ void ec_cwt_kernel52(real_T interval[650]);
static __global__ void ec_cwt_kernel53(const int32_T k, real_T interval[650]);
static __global__ void ec_cwt_kernel54(real_T interval[650]);
static __global__ void ec_cwt_kernel55(real_T interval[650]);
static __global__ void ec_cwt_kernel56(const int32_T k, real_T interval[650]);
static __global__ void ec_cwt_kernel57(emxArray_real_T y);
static __global__ void ec_cwt_kernel58(const emxArray_real_T y, const real_T r,
  const int32_T b, emxArray_real_T b_y);
static __global__ void ec_cwt_kernel59(const emxArray_real_T y, const real_T
  halfh, const int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ec_cwt_kernel6(real_T interval[650]);
static __global__ void ec_cwt_kernel60(const int32_T b, emxArray_real_T y);
static __global__ void ec_cwt_kernel61(const real_T interval[650], const int32_T
  b, real_T subs[1298]);
static __global__ void ec_cwt_kernel62(const real_T x_data[9735], const int32_T
  b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwt_kernel63(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwt_kernel64(const real_T x_data[9735], const int32_T
  b, real_T dv16_data[9735]);
static __global__ void ec_cwt_kernel65(const real_T x_data[9735], const int32_T
  b, real_T y_data[9735]);
static __global__ void ec_cwt_kernel66(const real_T y_data[9735], const int32_T
  b, real_T x_data[9735]);
static __global__ void ec_cwt_kernel67(const real_T xt_data[9735], const real_T
  x_data[9735], const real_T dv16_data[9735], const int32_T dv16_size, real_T
  fx_data[9735]);
static __global__ void ec_cwt_kernel68(const real_T interval[650], const int32_T
  b, real_T subs[1298]);
static __global__ void ec_cwt_kernel69(const real_T x_data[9735], const int32_T
  b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwt_kernel7(const int32_T k, real_T interval[650]);
static __global__ void ec_cwt_kernel70(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwt_kernel71(const real_T x_data[9735], const int32_T
  b, real_T y_data[9735]);
static __global__ void ec_cwt_kernel72(const real_T x_data[9735], const int32_T
  b, real_T b_x_data[9735]);
static __global__ void ec_cwt_kernel73(const real_T x_data[9735], const real_T
  y_data[9735], const int32_T y_size, real_T a_data[9735]);
static __global__ void ec_cwt_kernel74(const real_T a_data[9735], const int32_T
  b, real_T dv11_data[9735]);
static __global__ void ec_cwt_kernel75(const real_T x_data[9735], const int32_T
  b, real_T y_data[9735]);
static __global__ void ec_cwt_kernel76(const real_T y_data[9735], const int32_T
  b, real_T x_data[9735]);
static __global__ void ec_cwt_kernel77(const real_T xt_data[9735], const real_T
  x_data[9735], const real_T dv11_data[9735], const int32_T dv11_size, real_T
  fx_data[9735]);
static __global__ void ec_cwt_kernel78(const int32_T b, emxArray_int32_T
  omega_tmp1);
static __global__ void ec_cwt_kernel79(const real_T interval[650], const int32_T
  b, real_T subs[1298]);
static __global__ void ec_cwt_kernel8(const real_T maxScale, const
  emxArray_int32_T omega_tmp1, const int32_T b_omega_tmp1, emxArray_real_T
  omega_tmp2);
static __global__ void ec_cwt_kernel80(const real_T x_data[9735], const int32_T
  b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwt_kernel81(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwt_kernel82(const real_T x_data[9735], const int32_T
  b, real_T dv10_data[9735]);
static __global__ void ec_cwt_kernel83(const real_T x_data[9735], const int32_T
  b, real_T y_data[9735]);
static __global__ void ec_cwt_kernel84(const real_T y_data[9735], const int32_T
  b, real_T x_data[9735]);
static __global__ void ec_cwt_kernel85(const real_T xt_data[9735], const real_T
  x_data[9735], const real_T dv10_data[9735], const int32_T dv10_size, real_T
  fx_data[9735]);
static __global__ void ec_cwt_kernel86(const real_T interval[650], const int32_T
  b, real_T subs[1298]);
static __global__ void ec_cwt_kernel87(const real_T x_data[9735], const int32_T
  b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwt_kernel88(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwt_kernel89(const real_T x_data[9735], const int32_T
  b, real_T y_data[9735]);
static __global__ void ec_cwt_kernel9(emxArray_real_T fb_Omega);
static __global__ void ec_cwt_kernel90(const real_T x_data[9735], const int32_T
  b, real_T b_x_data[9735]);
static __global__ void ec_cwt_kernel91(const real_T x_data[9735], const real_T
  y_data[9735], const int32_T y_size, real_T a_data[9735]);
static __global__ void ec_cwt_kernel92(const real_T a_data[9735], const int32_T
  b, real_T dv4_data[9735]);
static __global__ void ec_cwt_kernel93(const real_T x_data[9735], const int32_T
  b, real_T y_data[9735]);
static __global__ void ec_cwt_kernel94(const real_T y_data[9735], const int32_T
  b, real_T x_data[9735]);
static __global__ void ec_cwt_kernel95(const real_T xt_data[9735], const real_T
  x_data[9735], const real_T dv4_data[9735], const int32_T dv4_size, real_T
  fx_data[9735]);
static void ec_cwt_once();
static void emlrtExitTimeCleanupDtorFcn(const void *r);
static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
  emxArray_real32_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y);
static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
  emxArray_char_T *y);
static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static real_T emlrt_marshallIn(const mxArray *a__output_of_length_, const char_T
  *identifier);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_char_T *y);
static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
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
static void emxFree_char_T(emxArray_char_T **pEmxArray);
static void emxFree_creal32_T(emxArray_creal32_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_real32_T(emxArray_real32_T **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
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
static real32_T f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId);
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
static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
static void gpuEmxFree_real32_T(emxArray_real32_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
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
  y = e_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
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
      in1->data[i1 + in1->size[0] * i] = 0.0050536085896138528 * in2->data[i1 *
        stride_0_0 + in2->size[0] * aux_0_1] * static_cast<real_T>(in3->data[i1 *
        stride_1_0 + in3->size[0] * aux_1_1] > 0.0);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void binary_expand_op_1(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &n_emlrtRTEI);
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
      in1->data[i1 + in1->size[0] * i] = 5.43656365691809 * in2->data[i1 *
        stride_0_0 + in2->size[0] * aux_0_1] * static_cast<real_T>(in3->data[i1 *
        stride_1_0 + in3->size[0] * aux_1_1] < 0.99999999999999978);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void binary_expand_op_3(real_T in1_data[], int32_T in1_size[2], const
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

static real32_T c_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real32_T y;
  y = f_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real32_T c_emlrt_marshallIn(const mxArray *b_nullptr, const char_T
  *identifier)
{
  emlrtMsgIdentifier thisId;
  real32_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = c_emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
  return y;
}

static void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T
  b_line)
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

static real_T d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
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

static real_T (*e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
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
static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel1(const char_T cv
[128], char_T wname[5], char_T wav[5], char_T b_dim0, char_T b_dim1, char_T
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel10(const
  emxArray_real_T omega_tmp2, const int32_T b, emxArray_real_T fb_Omega)
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
    fb_Omega.data[k + 1] = omega_tmp2.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel11(const int32_T
  nrefine, const int32_T lidx, const emxArray_real_T omega_tmp2, const int32_T
  nsubs, emxArray_real_T fb_Omega, int32_T omega_tmp2_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nsubs);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fb_Omega.data[(k + omega_tmp2_dim1) + 1] = -omega_tmp2.data[lidx + nrefine *
      k];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel12(emxArray_real_T
  y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel13(const
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel14(const
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
    int32_T k;
    k = static_cast<int32_T>(idx);
    fb_Scales.data[k] = halfh * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel15(const
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel16(const
  emxArray_real_T absomega, const int32_T b_absomega, emxArray_real_T powscales)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_absomega);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    powscales.data[k] = absomega.data[k] * absomega.data[k] * absomega.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel17(const int32_T
  b, emxArray_real_T absomega)
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel18(const
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
    int32_T k;
    k = static_cast<int32_T>(idx);
    x.data[k] = 20.0 * absomega.data[k] - powscales.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel19(const int32_T
  b, emxArray_real_T x)
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

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel2(real_T interval
  [650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel20(const
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
    int32_T k;
    k = static_cast<int32_T>(idx);
    daughter.data[k] = 0.0050536085896138528 * x.data[k] * static_cast<real_T>
      (somega.data[k] > 0.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel21(const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    f.data[k] = 1.8820720577620569 / fb_Scales.data[k] / 6.2831853071795862;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel22(const real_T
  fs, const int32_T i, emxArray_real_T f)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    f.data[k] *= fs;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel23(const
  emxArray_real_T f, const int32_T b_f, emxArray_real_T freqs)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_f);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    freqs.data[k] = f.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel24(const
  emxArray_real_T daughter, const int32_T b_daughter, emxArray_real32_T psihat)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_daughter);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    psihat.data[k] = static_cast<real32_T>(daughter.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel25(const int32_T
  nrefine, const emxArray_real32_T x, const int32_T b_x, emxArray_real32_T xv,
  int32_T x_dim0)
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
    xv.data[k] = x.data[k + x_dim0 * (nrefine - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel26(const int32_T
  nrefine, const emxArray_real32_T x, const int32_T b, emxArray_real32_T b_x,
  int32_T x_dim0)
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
    b_x.data[k] = x.data[k + x_dim0 * (nrefine - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel27(const int32_T
  fb_SignalPad, const int32_T b, emxArray_real32_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T j2;
    real32_T xtmp;
    bcoef = static_cast<int32_T>(idx);
    j2 = (fb_SignalPad - bcoef) - 1;
    xtmp = x.data[bcoef];
    x.data[bcoef] = x.data[j2];
    x.data[j2] = xtmp;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel28(const
  emxArray_real32_T x, const int32_T b, emxArray_real32_T xv)
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
    xv.data[k] = x.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel29(const
  emxArray_real32_T xv, const int32_T b_xv, emxArray_creal32_T xposdft)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    xposdft.data[k].re = xv.data[k];
    xposdft.data[k].im = 0.0F;
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwt_kernel3(real_T interval
  [650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel30(const
  emxArray_creal32_T xposdft, const emxArray_real32_T psihat, const int32_T lidx,
  const int32_T cfsposdft, const int32_T pathlen, emxArray_creal32_T b_cfsposdft,
  int32_T psihat_dim0, int32_T cfsposdft_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(pathlen) + 1UL) * (static_cast<uint64_T>
    (cfsposdft) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_k;
    int32_T bcoef;
    int32_T j2;
    int32_T k;
    b_k = static_cast<int32_T>(idx % (static_cast<uint64_T>(cfsposdft) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(b_k)) /
      (static_cast<uint64_T>(cfsposdft) + 1UL));
    j2 = lidx * k + 1;
    bcoef = static_cast<int32_T>(psihat_dim0 != 1);
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].re = psihat.data[bcoef * b_k +
      psihat_dim0 * (j2 - 1)] * xposdft.data[k].re;
    b_cfsposdft.data[b_k + cfsposdft_dim0 * k].im = psihat.data[bcoef * b_k +
      psihat_dim0 * (j2 - 1)] * xposdft.data[k].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel31(const int32_T
  xSize, emxArray_creal32_T cfspos)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xSize);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    cfspos.data[k].re = 0.0F;
    cfspos.data[k].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel32(const
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel33(const
  emxArray_real32_T y, const int32_T b_y, const int32_T c_y, emxArray_real32_T
  xCh, int32_T xCh_dim0, int32_T y_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_y) + 1UL) * (static_cast<uint64_T>(b_y) +
    1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T k;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) / (
      static_cast<uint64_T>(b_y) + 1UL));
    xCh.data[bcoef + xCh_dim0 * k] = y.data[k + y_dim0 * bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel34(const
  emxArray_real32_T xCh, const int32_T pathlen, const int32_T b, const int32_T c,
  emxArray_real32_T b_xCh, int32_T xCh_dim0, int32_T b_xCh_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL)
    - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T k;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) / (
      static_cast<uint64_T>(b) + 1UL));
    b_xCh.data[bcoef + xCh_dim0 * k] = xCh.data[pathlen * bcoef + b_xCh_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel35(const
  emxArray_real32_T xCh, const int32_T b_xCh, emxArray_real32_T c_xCh)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xCh);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    c_xCh.data[k] = xCh.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel36(const
  emxArray_real32_T xCh, const int32_T xx_dim0, const int32_T nrefine, const
  int32_T xx, const int32_T b_xx, emxArray_real32_T c_xx, int32_T b_xx_dim0,
  int32_T xx_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xx) + 1UL) * (static_cast<uint64_T>(xx) +
    1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T k;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(xx) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) / (
      static_cast<uint64_T>(xx) + 1UL));
    c_xx.data[(bcoef + b_xx_dim0 * (nrefine - 1)) + b_xx_dim0 * xx_dim1 * k] =
      xCh.data[bcoef + xx_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel37(const real32_T
  cfsposdft_re, const emxArray_creal32_T cfsposdft, const int32_T b_cfsposdft,
  emxArray_creal32_T cfspos)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfsposdft);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    real32_T ai;
    real32_T xtmp;
    k = static_cast<int32_T>(idx);
    xtmp = cfsposdft.data[k].re;
    ai = cfsposdft.data[k].im;
    if (ai == 0.0F) {
      cfspos.data[k].re = xtmp / cfsposdft_re;
      cfspos.data[k].im = 0.0F;
    } else if (xtmp == 0.0F) {
      cfspos.data[k].re = 0.0F;
      cfspos.data[k].im = ai / cfsposdft_re;
    } else {
      cfspos.data[k].re = xtmp / cfsposdft_re;
      cfspos.data[k].im = ai / cfsposdft_re;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel38(const int32_T
  b, emxArray_creal32_T xposdft, uint32_T xSize_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - bcoef) - 1].re =
      xposdft.data[bcoef + 1].re;
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - bcoef) - 1].im =
      -xposdft.data[bcoef + 1].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel39(const real32_T
  ds2, const int32_T b, emxArray_real32_T fv)
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
    fv.data[k] = static_cast<real32_T>(static_cast<real_T>(ds2) *
      static_cast<real_T>(k) + 1.0);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel4(const int32_T k,
  real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel40(const
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
    int32_T bcoef;
    int32_T k;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fb_Scales) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) / (
      static_cast<uint64_T>(b_fb_Scales) + 1UL));
    somega.data[bcoef + somega_dim0 * k] = fb_Scales.data[bcoef] *
      fb_Omega.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel41(const
  emxArray_real_T somega, const int32_T b_somega, emxArray_real_T w)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_somega);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    w.data[k] = (somega.data[k] - 5.0) / 0.6;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel42(const
  emxArray_real_T w, const int32_T b_w, emxArray_real_T expnt)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_w);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    expnt.data[k] = -1.0 / (1.0 - w.data[k] * w.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel43(const int32_T
  b, emxArray_real_T expnt)
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel44(const
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel45(const
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
    int32_T k;
    k = static_cast<int32_T>(idx);
    daughter.data[k] = 5.43656365691809 * expnt.data[k] * static_cast<real_T>
      (y.data[k] < 0.99999999999999978);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel46(const int32_T
  nrefine, emxArray_real_T daughter)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    if (isnan(daughter.data[bcoef])) {
      daughter.data[bcoef] = 0.0;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel47(const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    f.data[k] = 0.79577471545947676 / fb_Scales.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel48(const
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
    int32_T bcoef;
    int32_T k;
    bcoef = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fb_Scales) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(bcoef)) / (
      static_cast<uint64_T>(b_fb_Scales) + 1UL));
    somega.data[bcoef + somega_dim0 * k] = fb_Scales.data[bcoef] *
      fb_Omega.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel49(const int32_T
  b, emxArray_real_T y)
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
    y.data[k] = static_cast<real_T>(k);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel5(real_T interval
  [650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel50(const char_T cv
  [128], char_T wav[5], char_T wname[5], char_T b_dim0, char_T b_dim1, char_T
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

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel51(real_T interval
  [650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwt_kernel52(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel53(const int32_T k,
  real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[k];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel54(real_T interval
  [650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwt_kernel55(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel56(const int32_T k,
  real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[k];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel57(emxArray_real_T
  y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel58(const
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel59(const
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
    int32_T k;
    k = static_cast<int32_T>(idx);
    fb_Scales.data[k] = halfh * y.data[k];
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwt_kernel6(real_T interval
  [650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel60(const int32_T
  b, emxArray_real_T y)
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
    y.data[k] = static_cast<real_T>(k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel61(const real_T
  interval[650], const int32_T b, real_T subs[1298])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel62(const real_T
  x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel63(const int32_T
  b, real_T fx_data[9735])
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
    fx_data[k] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel64(const real_T
  x_data[9735], const int32_T b, real_T dv16_data[9735])
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
    dv16_data[k] = pow(x_data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel65(const real_T
  x_data[9735], const int32_T b, real_T y_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel66(const real_T
  y_data[9735], const int32_T b, real_T x_data[9735])
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
    x_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel67(const real_T
  xt_data[9735], const real_T x_data[9735], const real_T dv16_data[9735], const
  int32_T dv16_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv16_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fx_data[k] = dv16_data[k] * x_data[k] * xt_data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel68(const real_T
  interval[650], const int32_T b, real_T subs[1298])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel69(const real_T
  x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data[9735])
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

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel7(const int32_T k,
  real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel70(const int32_T
  b, real_T fx_data[9735])
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
    fx_data[k] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel71(const real_T
  x_data[9735], const int32_T b, real_T y_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel72(const real_T
  x_data[9735], const int32_T b, real_T b_x_data[9735])
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
    b_x_data[k] = pow(x_data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel73(const real_T
  x_data[9735], const real_T y_data[9735], const int32_T y_size, real_T a_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a_data[k] = 20.0 * y_data[k] - 3.0 * x_data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel74(const real_T
  a_data[9735], const int32_T b, real_T dv11_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel75(const real_T
  x_data[9735], const int32_T b, real_T y_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel76(const real_T
  y_data[9735], const int32_T b, real_T x_data[9735])
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
    x_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel77(const real_T
  xt_data[9735], const real_T x_data[9735], const real_T dv11_data[9735], const
  int32_T dv11_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv11_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fx_data[k] = dv11_data[k] * x_data[k] * xt_data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel78(const int32_T
  b, emxArray_int32_T omega_tmp1)
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
    omega_tmp1.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel79(const real_T
  interval[650], const int32_T b, real_T subs[1298])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel8(const real_T
  maxScale, const emxArray_int32_T omega_tmp1, const int32_T b_omega_tmp1,
  emxArray_real_T omega_tmp2)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_omega_tmp1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    omega_tmp2.data[k] = static_cast<real_T>(omega_tmp1.data[k]) * maxScale;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel80(const real_T
  x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel81(const int32_T
  b, real_T fx_data[9735])
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
    fx_data[k] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel82(const real_T
  x_data[9735], const int32_T b, real_T dv10_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel83(const real_T
  x_data[9735], const int32_T b, real_T y_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel84(const real_T
  y_data[9735], const int32_T b, real_T x_data[9735])
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
    x_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel85(const real_T
  xt_data[9735], const real_T x_data[9735], const real_T dv10_data[9735], const
  int32_T dv10_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv10_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fx_data[k] = dv10_data[k] * x_data[k] * xt_data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel86(const real_T
  interval[650], const int32_T b, real_T subs[1298])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel87(const real_T
  x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel88(const int32_T
  b, real_T fx_data[9735])
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
    fx_data[k] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel89(const real_T
  x_data[9735], const int32_T b, real_T y_data[9735])
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

static __global__ __launch_bounds__(32, 1) void ec_cwt_kernel9(emxArray_real_T
  fb_Omega)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    fb_Omega.data[0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel90(const real_T
  x_data[9735], const int32_T b, real_T b_x_data[9735])
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
    b_x_data[k] = pow(x_data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel91(const real_T
  x_data[9735], const real_T y_data[9735], const int32_T y_size, real_T a_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a_data[k] = 20.0 * y_data[k] - 3.0 * x_data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel92(const real_T
  a_data[9735], const int32_T b, real_T dv4_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel93(const real_T
  x_data[9735], const int32_T b, real_T y_data[9735])
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

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel94(const real_T
  y_data[9735], const int32_T b, real_T x_data[9735])
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
    x_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel95(const real_T
  xt_data[9735], const real_T x_data[9735], const real_T dv4_data[9735], const
  int32_T dv4_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fx_data[k] = dv4_data[k] * x_data[k] * xt_data[k];
  }
}

static void ec_cwt_once()
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
  y = d_emlrt_marshallIn(emlrtAlias(u), parentId);
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

static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u)
{
  static const int32_T iv[3]{ 0, 0, 0 };

  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(3, (const void *)&iv[0], mxSINGLE_CLASS, mxREAL);
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

static real32_T f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId)
{
  static const int32_T dims{ 0 };

  real32_T ret;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single", false, 0U, (
    const void *)&dims);
  ret = *static_cast<real32_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret;
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
void ec_cwt(ec_cwtStackData *SD, const emxArray_real32_T *cpu_x, real_T fs,
            real_T fLims[2], real_T fOctave, real32_T ds2, emxArray_real32_T
            *cpu_xx, emxArray_real_T *cpu_freqs)
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
  emxArray_real32_T b_gpu_x;
  emxArray_real32_T b_gpu_xCh;
  emxArray_real32_T c_gpu_x;
  emxArray_real32_T c_gpu_y;
  emxArray_real32_T gpu_fv;
  emxArray_real32_T gpu_psihat;
  emxArray_real32_T gpu_xCh;
  emxArray_real32_T gpu_xv;
  emxArray_real32_T gpu_xx;
  emxArray_real32_T *b_cpu_xCh;
  emxArray_real32_T *c_cpu_x;
  emxArray_real32_T *cpu_fv;
  emxArray_real32_T *cpu_psihat;
  emxArray_real32_T *cpu_xCh;
  emxArray_real32_T *cpu_xv;
  emxArray_real32_T *f_cpu_y;
  emxArray_real_T b_gpu_somega;
  emxArray_real_T b_gpu_y;
  emxArray_real_T d_gpu_y;
  emxArray_real_T e_gpu_y;
  emxArray_real_T f_gpu_y;
  emxArray_real_T gpu_absomega;
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
  emxArray_real_T *b_cpu_somega;
  emxArray_real_T *b_cpu_x;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_absomega;
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
  const mxArray *b_tmpStr;
  const mxArray *b_y;
  const mxArray *c_tmpStr;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *f_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *m4;
  const mxArray *m5;
  const mxArray *y;
  int64_T e;
  real_T cpu_dv11_data[9735];
  real_T cpu_fx_data[9735];
  real_T (*b_gpu_a_data)[9735];
  real_T (*b_gpu_fx_data)[9735];
  real_T (*b_gpu_x_data)[9735];
  real_T (*c_gpu_fx_data)[9735];
  real_T (*d_gpu_fx_data)[9735];
  real_T (*gpu_a_data)[9735];
  real_T (*gpu_dv10_data)[9735];
  real_T (*gpu_dv11_data)[9735];
  real_T (*gpu_dv16_data)[9735];
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
  real_T c_r;
  real_T d;
  real_T err_ok;
  real_T fb_VoicesPerOctave;
  real_T halfh;
  real_T intDsq;
  real_T intFsq;
  real_T maxScale;
  real_T omegac;
  real_T q_ok;
  real_T r;
  real_T s;
  real_T tol;
  real_T toler;
  int32_T xx[3];
  int32_T a_size[2];
  int32_T b_a_size[2];
  int32_T b_xt_size[2];
  int32_T dv11_size[2];
  int32_T dv14_size[2];
  int32_T dv4_size[2];
  int32_T dv7_size[2];
  int32_T fx_size[2];
  int32_T xt_size[2];
  int32_T b_eint;
  int32_T b_k;
  int32_T c_eint;
  int32_T eint;
  int32_T exitg1;
  int32_T fb_CutOff;
  int32_T fb_SignalPad;
  int32_T ix;
  int32_T j;
  int32_T k;
  int32_T lidx;
  int32_T nrefine;
  int32_T nsubs;
  int32_T pathlen;
  uint32_T xSize[2];
  uint32_T N;
  uint32_T nChs;
  char_T cpu_wav[5];
  char_T cpu_wname[5];
  char_T (*gpu_wav)[5];
  char_T (*gpu_wname)[5];
  int8_T n_idx_0;
  boolean_T b_b[2];
  boolean_T b_fx_data_outdatedOnCpu;
  boolean_T b_y_needsGpuEnsureCapacity;
  boolean_T c_omega_tmp1_needsGpuEnsureCapa;
  boolean_T exitg2;
  boolean_T fb_Omega_outdatedOnCpu;
  boolean_T first_iteration;
  boolean_T fx_data_outdatedOnCpu;
  boolean_T guard1;
  boolean_T interval_outdatedOnGpu;
  boolean_T subs_outdatedOnCpu;
  boolean_T validLaunchParams;
  boolean_T wav_outdatedOnCpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  if (!gpuConstsCopied_ec_cwt) {
    gpuConstsCopied_ec_cwt = true;
    checkCudaError(cudaMemcpy(*global_gpu_cv, cpu_cv, sizeof(char_T [128]),
      cudaMemcpyHostToDevice), __FILE__, __LINE__);
  }

  gpuEmxReset_real32_T(&b_gpu_xCh);
  gpuEmxReset_real32_T(&gpu_xCh);
  gpuEmxReset_real32_T(&c_gpu_y);
  gpuEmxReset_creal32_T(&gpu_cfsposdft);
  gpuEmxReset_real32_T(&c_gpu_x);
  gpuEmxReset_creal32_T(&gpu_xposdft);
  gpuEmxReset_real32_T(&gpu_xv);
  gpuEmxReset_real32_T(&gpu_psihat);
  gpuEmxReset_creal32_T(&gpu_cfspos);
  gpuEmxReset_real32_T(&gpu_fv);
  checkCudaError(mwCudaMalloc(&gpu_fx_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv11_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv16_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_real_T(&gpu_x);
  checkCudaError(mwCudaMalloc(&gpu_a_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_powscales);
  checkCudaError(mwCudaMalloc(&b_gpu_fx_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_expnt);
  gpuEmxReset_real_T(&gpu_absomega);
  gpuEmxReset_real_T(&gpu_w);
  gpuEmxReset_real_T(&gpu_somega);
  gpuEmxReset_real_T(&b_gpu_somega);
  gpuEmxReset_real_T(&gpu_f);
  gpuEmxReset_real_T(&gpu_daughter);
  checkCudaError(mwCudaMalloc(&c_gpu_fx_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv4_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv10_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&f_gpu_y);
  checkCudaError(mwCudaMalloc(&b_gpu_a_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&e_gpu_y);
  checkCudaError(mwCudaMalloc(&d_gpu_fx_data, 77880UL), __FILE__, __LINE__);
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
  gpuEmxReset_real_T(&gpu_freqs);
  gpuEmxReset_real32_T(&gpu_xx);
  gpuEmxReset_real32_T(&b_gpu_x);
  b_fx_data_outdatedOnCpu = false;
  fx_data_outdatedOnCpu = false;
  x_outdatedOnGpu = true;
  b_y_needsGpuEnsureCapacity = true;
  y_needsGpuEnsureCapacity = true;
  c_omega_tmp1_needsGpuEnsureCapa = true;
  x_needsGpuEnsureCapacity = true;
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
  if (fLims[0] < 0.001) {
    // 'ec_cwt:18' ;
    // 'ec_cwt:18' fLims(1)=1e-3;
    fLims[0] = 0.001;
  }

  // 'ec_cwt:19' if fLims(2)>fs/2
  if (fLims[1] > fs / 2.0) {
    // 'ec_cwt:19' ;
    // 'ec_cwt:19' fLims(2)=fs/2;
    fLims[1] = fs / 2.0;
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
      fb_SignalPad = static_cast<int32_T>(std::floor(static_cast<real_T>
        (cpu_x->size[0]) / 2.0));
    } else {
      r = std::frexp(static_cast<real_T>(cpu_x->size[0]), &nrefine);
      if (r == 0.5) {
        r = static_cast<real_T>(nrefine) - 1.0;
      } else {
        r = std::log(r) / 0.69314718055994529 + static_cast<real_T>(nrefine);
      }

      r = std::ceil(r);
      fb_SignalPad = static_cast<int32_T>(r);
    }
  } else {
    fb_SignalPad = 0;
  }

  for (k = 0; k < 2; k++) {
    b_b[k] = std::isnan(fLims[k]);
  }

  first_iteration = true;
  b_k = 0;
  exitg2 = false;
  while ((!exitg2) && (b_k < 2)) {
    if (!b_b[b_k]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      b_k++;
    }
  }

  if (!first_iteration) {
    real_T freqrange[2];
    real_T cf;
    for (k = 0; k < 2; k++) {
      freqrange[k] = fLims[k];
    }

    NyquistRange[1] = fs / 2.0;
    emxInit_char_T(&tmpStr, 2, &vb_emlrtRTEI, true);
    if ((fLims[1] <= 0.0) || (fLims[0] >= NyquistRange[1])) {
      b_tmpStr = nullptr;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m1 = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 2, m1, &formatSpec[0]);
      emlrtAssign(&b_y, m1);
      c_y = nullptr;
      m2 = emlrtCreateDoubleScalar(NyquistRange[1]);
      emlrtAssign(&c_y, m2);
      emlrtAssign(&b_tmpStr, feval(y, b_y, c_y, &emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(b_tmpStr), &b_emlrtMCI),
                       "<output of length>");
      emlrt_marshallIn(emlrtAlias(b_tmpStr), "tmpStr", tmpStr);
      emlrtDestroyArray(&b_tmpStr);
    }

    emxFree_char_T(&tmpStr);
    omegac = 3.1415926535897931;
    ec_cwt_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*global_gpu_cv,
      *gpu_wname, *gpu_wav, c_b[0], c_b[1], c_b[2], c_b[3], c_b[4]);
    wav_outdatedOnCpu = true;
    checkCudaError(cudaMemcpy(cpu_wname, *gpu_wname, 5UL, cudaMemcpyDeviceToHost),
                   __FILE__, __LINE__);
    if (cpu_wname[0] == 'm') {
      cf = 1.8820720577620569;
      b_r = 0.0057083835261;
      c_r = 0.0057083835261;
      r = 0.0057083835261;
      for (lidx = 0; lidx < 6; lidx++) {
        maxScale = c[lidx];
        b_r = b_r * 0.005353955978584176 + maxScale;
        c_r = c_r * 0.005353955978584176 + maxScale;
        r = r * 0.005353955978584176 + maxScale;
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
        ec_cwt_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwt_kernel3<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>(*gpu_interval);
        interval_outdatedOnGpu = false;
        intDsq = 0.0;
        b_k = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        pathlen = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            lidx = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (j = 0; j < lidx; j++) {
              cpu_interval[n_idx_0 - j] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - j) * r;
            }
          }

          b_k = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (nrefine = 0; nrefine < b_k; nrefine++) {
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

          ec_cwt_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_k,
            *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
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
            ec_cwt_kernel86<<<grid, block>>>(*gpu_interval, nsubs - 1, *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            k = 15 * nsubs;
            ix = -1;
            for (b_k = 0; b_k < nsubs; b_k++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              maxScale = cpu_subs[b_k << 1];
              subs_outdatedOnCpu = false;
              r = cpu_subs[(b_k << 1) + 1];
              c_r = (maxScale + r) / 2.0;
              halfh = (r - maxScale) / 2.0;
              for (j = 0; j < 15; j++) {
                SD->f0.cpu_x_data[(ix + j) + 1] = NODES[j] * halfh + c_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            xt_size[0] = 1;
            xt_size[1] = k;
            mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
              2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwt_kernel87<<<grid, block>>>(*gpu_x_data, k - 1, *gpu_xt_data,
                *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              c_r = std::abs(SD->f0.cpu_x_data[0]);
              b_k = 0;
              exitg2 = false;
              while ((!exitg2) && (b_k <= k - 2)) {
                tol = c_r;
                c_r = std::abs(SD->f0.cpu_x_data[b_k + 1]);
                if (std::abs(SD->f0.cpu_x_data[b_k + 1] - SD->f0.cpu_x_data[b_k])
                    <= 2.2204460492503131E-14 * std::fmax(tol, c_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  b_k++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                  2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwt_kernel88<<<grid, block>>>(k - 1, *d_gpu_fx_data);
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
              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel89<<<grid, block>>>(*b_gpu_x_data, k - 1,
                  *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel90<<<grid, block>>>(*b_gpu_x_data, k - 1,
                  *gpu_x_data);
              }

              a_size[1] = k;
              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel91<<<grid, block>>>(*gpu_x_data, *gpu_y_data, k - 1,
                  *b_gpu_a_data);
              }

              dv4_size[0] = 1;
              dv4_size[1] = a_size[1];
              mwGetLaunchParameters1D(computeNumIters(a_size[1] - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel92<<<grid, block>>>(*b_gpu_a_data, a_size[1] - 1,
                  *gpu_dv4_data);
              }

              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel93<<<grid, block>>>(*b_gpu_x_data, k - 1,
                  *gpu_y_data);
              }

              dv7_size[0] = 1;
              dv7_size[1] = k;
              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel94<<<grid, block>>>(*gpu_y_data, k - 1, *gpu_x_data);
              }

              if (a_size[1] == k) {
                fx_size[0] = 1;
                fx_size[1] = a_size[1];
                mwGetLaunchParameters1D(computeNumIters(a_size[1] - 1), &grid,
                  &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwt_kernel95<<<grid, block>>>(*gpu_xt_data, *gpu_x_data,
                    *gpu_dv4_data, a_size[1] - 1, *d_gpu_fx_data);
                }

                fx_data_outdatedOnCpu = true;
              } else {
                if (fx_data_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *d_gpu_fx_data,
                    77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                checkCudaError(cudaMemcpy(SD->f0.cpu_dv4_data, *gpu_dv4_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *gpu_x_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_xt_data, *gpu_xt_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                binary_expand_op_3(SD->f0.cpu_fx_data, fx_size,
                                   SD->f0.cpu_dv4_data, dv4_size,
                                   SD->f0.cpu_x_data, dv7_size,
                                   SD->f0.cpu_xt_data, xt_size);
                fx_data_outdatedOnCpu = false;
              }

              c_r = 0.0;
              ix = -1;
              for (b_k = 0; b_k < nsubs; b_k++) {
                maxScale = 0.0;
                r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *d_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  maxScale += dv5[j] * SD->f0.cpu_fx_data[(ix + j) + 1];
                  fx_data_outdatedOnCpu = false;
                  r += dv6[j] * SD->f0.cpu_fx_data[(ix + j) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                halfh = (cpu_subs[(b_k << 1) + 1] - cpu_subs[b_k << 1]) / 2.0;
                maxScale *= halfh;
                qsub[b_k] = maxScale;
                c_r += maxScale;
                errsub[b_k] = r * halfh;
              }

              intDsq = c_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              c_r = 2.0 * tol;
              r = 0.0;
              nrefine = 0;
              for (b_k = 0; b_k < nsubs; b_k++) {
                maxScale = errsub[b_k];
                halfh = std::abs(maxScale);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (halfh <= c_r * ((cpu_subs[(b_k << 1) + 1] - cpu_subs[b_k <<
                                     1]) / 2.0)) {
                  err_ok += maxScale;
                  q_ok += qsub[b_k];
                } else {
                  r += halfh;
                  nrefine++;
                  cpu_subs[(nrefine - 1) << 1] = cpu_subs[b_k << 1];
                  cpu_subs[((nrefine - 1) << 1) + 1] = cpu_subs[(b_k << 1) + 1];
                }
              }

              c_r = std::abs(err_ok) + r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(c_r)) && (!std::isnan(c_r))) && (nrefine != 0) &&
                  (!(c_r <= tol))) {
                nsubs = nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (b_k = 0; b_k < nrefine; b_k++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((nrefine - b_k) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nrefine - b_k) - 1) << 1) + 1];
                    cpu_subs[(((nrefine - b_k) << 1) - 1) << 1] = (cpu_subs
                      [((nrefine - b_k) - 1) << 1] + cpu_subs[(((nrefine - b_k)
                      - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nrefine - b_k) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nrefine - b_k) << 1) - 1) << 1];
                    cpu_subs[(((nrefine - b_k) << 1) - 2) << 1] = cpu_subs
                      [((nrefine - b_k) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        ec_cwt_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwt_kernel6<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>(*gpu_interval);
        interval_outdatedOnGpu = false;
        intFsq = 0.0;
        b_k = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        pathlen = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (j = 0; j < nrefine; j++) {
              cpu_interval[n_idx_0 - j] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - j) * r;
            }
          }

          b_k = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (nrefine = 0; nrefine < b_k; nrefine++) {
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

          ec_cwt_kernel7<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_k,
            *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
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
            ec_cwt_kernel79<<<grid, block>>>(*gpu_interval, nsubs - 1, *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            k = 15 * nsubs;
            ix = -1;
            for (b_k = 0; b_k < nsubs; b_k++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              maxScale = cpu_subs[b_k << 1];
              subs_outdatedOnCpu = false;
              r = cpu_subs[(b_k << 1) + 1];
              c_r = (maxScale + r) / 2.0;
              halfh = (r - maxScale) / 2.0;
              for (j = 0; j < 15; j++) {
                SD->f0.cpu_x_data[(ix + j) + 1] = NODES[j] * halfh + c_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
              2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwt_kernel80<<<grid, block>>>(*gpu_x_data, k - 1, *gpu_xt_data,
                *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              c_r = std::abs(SD->f0.cpu_x_data[0]);
              b_k = 0;
              exitg2 = false;
              while ((!exitg2) && (b_k <= k - 2)) {
                tol = c_r;
                c_r = std::abs(SD->f0.cpu_x_data[b_k + 1]);
                if (std::abs(SD->f0.cpu_x_data[b_k + 1] - SD->f0.cpu_x_data[b_k])
                    <= 2.2204460492503131E-14 * std::fmax(tol, c_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  b_k++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                  2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwt_kernel81<<<grid, block>>>(k - 1, *c_gpu_fx_data);
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
              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel82<<<grid, block>>>(*b_gpu_x_data, k - 1,
                  *gpu_dv10_data);
              }

              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel83<<<grid, block>>>(*b_gpu_x_data, k - 1,
                  *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel84<<<grid, block>>>(*gpu_y_data, k - 1, *gpu_x_data);
              }

              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel85<<<grid, block>>>(*gpu_xt_data, *gpu_x_data,
                  *gpu_dv10_data, k - 1, *c_gpu_fx_data);
              }

              fx_data_outdatedOnCpu = true;
              c_r = 0.0;
              ix = -1;
              for (b_k = 0; b_k < nsubs; b_k++) {
                maxScale = 0.0;
                r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *c_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  maxScale += dv5[j] * SD->f0.cpu_fx_data[(ix + j) + 1];
                  fx_data_outdatedOnCpu = false;
                  r += dv6[j] * SD->f0.cpu_fx_data[(ix + j) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                halfh = (cpu_subs[(b_k << 1) + 1] - cpu_subs[b_k << 1]) / 2.0;
                maxScale *= halfh;
                qsub[b_k] = maxScale;
                c_r += maxScale;
                errsub[b_k] = r * halfh;
              }

              intFsq = c_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              c_r = 2.0 * tol;
              r = 0.0;
              nrefine = 0;
              for (b_k = 0; b_k < nsubs; b_k++) {
                maxScale = errsub[b_k];
                halfh = std::abs(maxScale);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (halfh <= c_r * ((cpu_subs[(b_k << 1) + 1] - cpu_subs[b_k <<
                                     1]) / 2.0)) {
                  err_ok += maxScale;
                  q_ok += qsub[b_k];
                } else {
                  r += halfh;
                  nrefine++;
                  cpu_subs[(nrefine - 1) << 1] = cpu_subs[b_k << 1];
                  cpu_subs[((nrefine - 1) << 1) + 1] = cpu_subs[(b_k << 1) + 1];
                }
              }

              c_r = std::abs(err_ok) + r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(c_r)) && (!std::isnan(c_r))) && (nrefine != 0) &&
                  (!(c_r <= tol))) {
                nsubs = nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (b_k = 0; b_k < nrefine; b_k++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((nrefine - b_k) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nrefine - b_k) - 1) << 1) + 1];
                    cpu_subs[(((nrefine - b_k) << 1) - 1) << 1] = (cpu_subs
                      [((nrefine - b_k) - 1) << 1] + cpu_subs[(((nrefine - b_k)
                      - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nrefine - b_k) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nrefine - b_k) << 1) - 1) << 1];
                    cpu_subs[(((nrefine - b_k) << 1) - 2) << 1] = cpu_subs
                      [((nrefine - b_k) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        c_r = std::sqrt(3.5421952306087032 * (intDsq / intFsq));
      }
    } else if (cpu_wname[0] == 'a') {
      cf = 6.0;
      c_r = 1.4142135623730951;
    } else {
      cf = 5.0;
      c_r = 5.847705;
    }

    halfh = static_cast<real_T>(cpu_x->size[0]) / (c_r * 2.0);
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
        q_ok = 1.0;
        if (c_r == 0.0) {
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
              err_ok = c_r;
              d = omegac - a;
              intDsq = d;
            }

            if (std::abs(err_ok) < std::abs(q_ok)) {
              a = omegac;
              omegac = intFsq;
              intFsq = a;
              c_r = q_ok;
              q_ok = err_ok;
              err_ok = c_r;
            }

            b_m = 0.5 * (intFsq - omegac);
            toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(b_m) <= toler) || (q_ok == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(intDsq) < toler) || (std::abs(c_r) <= std::abs(q_ok)))
              {
                d = b_m;
                intDsq = b_m;
              } else {
                s = q_ok / c_r;
                if (a == intFsq) {
                  c_r = 2.0 * b_m * s;
                  tol = 1.0 - s;
                } else {
                  tol = c_r / err_ok;
                  b_r = q_ok / err_ok;
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
                    (c_r < std::abs(0.5 * intDsq * tol))) {
                  intDsq = d;
                  d = c_r / tol;
                } else {
                  d = b_m;
                  intDsq = b_m;
                }
              }

              a = omegac;
              c_r = q_ok;
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
    if (fLims[0] < r) {
      fLims[0] = r;
      freqrange[0] = r;
    }

    if (fLims[1] > fs / 2.0) {
      fLims[1] = fs / 2.0;
      freqrange[1] = fLims[1];
    }

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

    if ((!std::isinf(freqrange[0])) && (!std::isnan(freqrange[0]))) {
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

    if (!(c_r - r >= 1.0 / fb_VoicesPerOctave)) {
      c_tmpStr = nullptr;
      d_y = nullptr;
      m3 = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m3, &u[0]);
      emlrtAssign(&d_y, m3);
      e_y = nullptr;
      m4 = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 5, m4, &b_formatSpec[0]);
      emlrtAssign(&e_y, m4);
      f_y = nullptr;
      m5 = emlrtCreateDoubleScalar(1.0 / fb_VoicesPerOctave);
      emlrtAssign(&f_y, m5);
      emlrtAssign(&c_tmpStr, feval(d_y, e_y, f_y, &emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(c_tmpStr), &b_emlrtMCI),
                       "<output of length>");
      emxInit_char_T(&d_tmpStr, 2, &vb_emlrtRTEI, true);
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

  N = static_cast<uint32_T>(cpu_x->size[0]) + static_cast<uint32_T>(fb_SignalPad
    << 1);
  nrefine = static_cast<int32_T>(std::trunc(static_cast<real_T>(N) / 2.0));
  emxInit_int32_T(&cpu_omega_tmp1, 2, &emlrtRTEI, true);
  if (nrefine < 1) {
    cpu_omega_tmp1->size[0] = 1;
    cpu_omega_tmp1->size[1] = 0;
  } else {
    eint = cpu_omega_tmp1->size[0] * cpu_omega_tmp1->size[1];
    cpu_omega_tmp1->size[0] = 1;
    cpu_omega_tmp1->size[1] = nrefine;
    emxEnsureCapacity_int32_T(cpu_omega_tmp1, eint, &emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(nrefine - 1), &grid, &block,
      2147483647U);
    gpuEmxEnsureCapacity_int32_T(cpu_omega_tmp1, &gpu_omega_tmp1, true);
    c_omega_tmp1_needsGpuEnsureCapa = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel78<<<grid, block>>>(nrefine - 1, gpu_omega_tmp1);
    }
  }

  emxInit_real_T(&cpu_omega_tmp2, 2, &b_emlrtRTEI, true);
  eint = cpu_omega_tmp2->size[0] * cpu_omega_tmp2->size[1];
  cpu_omega_tmp2->size[0] = 1;
  cpu_omega_tmp2->size[1] = cpu_omega_tmp1->size[1];
  emxEnsureCapacity_real_T(cpu_omega_tmp2, eint, &b_emlrtRTEI);
  k = cpu_omega_tmp1->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
  if (c_omega_tmp1_needsGpuEnsureCapa) {
    gpuEmxEnsureCapacity_int32_T(cpu_omega_tmp1, &gpu_omega_tmp1, true);
  }

  gpuEmxEnsureCapacity_real_T(cpu_omega_tmp2, &gpu_omega_tmp2, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwt_kernel8<<<grid, block>>>(6.2831853071795862 / static_cast<real_T>(N),
      gpu_omega_tmp1, k, gpu_omega_tmp2);
  }

  emxFree_int32_T(&cpu_omega_tmp1);
  nrefine = static_cast<int32_T>(std::trunc((static_cast<real_T>(N) - 1.0) / 2.0));
  if (nrefine < 1) {
    lidx = 0;
    nrefine = 1;
    pathlen = -1;
  } else {
    lidx = nrefine - 1;
    nrefine = -1;
    pathlen = 0;
  }

  emxInit_real_T(&cpu_fb_Omega, 2, &f_emlrtRTEI, true);
  eint = cpu_fb_Omega->size[0] * cpu_fb_Omega->size[1];
  cpu_fb_Omega->size[0] = 1;
  cpu_fb_Omega->size[1] = (cpu_omega_tmp2->size[1] + div_s32(pathlen - lidx,
    nrefine)) + 2;
  emxEnsureCapacity_real_T(cpu_fb_Omega, eint, &c_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_fb_Omega, &gpu_fb_Omega, true);
  ec_cwt_kernel9<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_fb_Omega);
  nsubs = cpu_omega_tmp2->size[1];
  mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block, 2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwt_kernel10<<<grid, block>>>(gpu_omega_tmp2, nsubs - 1, gpu_fb_Omega);
  }

  nsubs = div_s32(pathlen - lidx, nrefine);
  mwGetLaunchParameters1D(computeNumIters(nsubs), &grid, &block, 2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwt_kernel11<<<grid, block>>>(nrefine, lidx, gpu_omega_tmp2, nsubs,
      gpu_fb_Omega, cpu_omega_tmp2->size[1U]);
  }

  fb_Omega_outdatedOnCpu = true;
  emxFree_real_T(&cpu_omega_tmp2);
  for (k = 0; k < 2; k++) {
    b_b[k] = std::isnan(fLims[k]);
  }

  first_iteration = true;
  b_k = 0;
  exitg2 = false;
  while ((!exitg2) && (b_k < 2)) {
    if (!b_b[b_k]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      b_k++;
    }
  }

  emxInit_real_T(&cpu_fb_Scales, 2, &f_emlrtRTEI, true);
  if (!first_iteration) {
    for (k = 0; k < 2; k++) {
      NyquistRange[k] = fLims[k] / fs * 2.0 * 3.1415926535897931;
    }

    for (k = 0; k < 5; k++) {
      cpu_wname[k] = cpu_cv[static_cast<int32_T>(c_b[k])];
    }

    if (cpu_wname[0] == 'm') {
      r = 1.8820720577620569;
    } else {
      j = 1;
      if (cpu_wname[0] == 'a') {
        j = 2;
      }

      if (j > 1) {
        r = 6.0;
      } else {
        r = 5.0;
      }
    }

    halfh = r / NyquistRange[1];
    r = r / NyquistRange[0] / halfh;
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

    emxInit_real_T(&cpu_y, 2, &ib_emlrtRTEI, true);
    r *= fb_VoicesPerOctave;
    if (std::isnan(r)) {
      eint = cpu_y->size[0] * cpu_y->size[1];
      cpu_y->size[0] = 1;
      cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_y, eint, &d_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
      y_needsGpuEnsureCapacity = false;
      ec_cwt_kernel12<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_y);
    } else if (r < 0.0) {
      cpu_y->size[0] = 1;
      cpu_y->size[1] = 0;
    } else {
      eint = cpu_y->size[0] * cpu_y->size[1];
      cpu_y->size[0] = 1;
      cpu_y->size[1] = static_cast<int32_T>(r) + 1;
      emxEnsureCapacity_real_T(cpu_y, eint, &d_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(r)), &grid,
        &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
      y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel49<<<grid, block>>>(static_cast<int32_T>(r), gpu_y);
      }
    }

    emxInit_real_T(&b_cpu_y, 2, &jb_emlrtRTEI, true);
    eint = b_cpu_y->size[0] * b_cpu_y->size[1];
    b_cpu_y->size[0] = 1;
    b_cpu_y->size[1] = cpu_y->size[1];
    emxEnsureCapacity_real_T(b_cpu_y, eint, &e_emlrtRTEI);
    b_k = cpu_y->size[1];
    mwGetLaunchParameters1D(computeNumIters(b_k - 1), &grid, &block, 2147483647U);
    if (y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
    }

    gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel13<<<grid, block>>>(gpu_y, rt_powd_snf(2.0, 1.0 /
        fb_VoicesPerOctave), b_k - 1, b_gpu_y);
    }

    emxFree_real_T(&cpu_y);
    eint = cpu_fb_Scales->size[0] * cpu_fb_Scales->size[1];
    cpu_fb_Scales->size[0] = 1;
    cpu_fb_Scales->size[1] = b_cpu_y->size[1];
    emxEnsureCapacity_real_T(cpu_fb_Scales, eint, &f_emlrtRTEI);
    k = b_cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    y_needsGpuEnsureCapacity = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel14<<<grid, block>>>(b_gpu_y, halfh, k, gpu_fb_Scales);
    }

    fx_data_outdatedOnCpu = true;
    emxFree_real_T(&b_cpu_y);
  } else {
    omegac = 3.1415926535897931;
    ec_cwt_kernel50<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*global_gpu_cv,
      *gpu_wav, *gpu_wname, c_b[0], c_b[1], c_b[2], c_b[3], c_b[4]);
    wav_outdatedOnCpu = true;
    checkCudaError(cudaMemcpy(cpu_wav, *gpu_wav, 5UL, cudaMemcpyDeviceToHost),
                   __FILE__, __LINE__);
    if (cpu_wav[0] == 'm') {
      a = 1.8820720577620569;
      b_r = 0.0057083835261;
      c_r = 0.0057083835261;
      r = 0.0057083835261;
      for (lidx = 0; lidx < 6; lidx++) {
        maxScale = c[lidx];
        b_r = b_r * 0.005353955978584176 + maxScale;
        c_r = c_r * 0.005353955978584176 + maxScale;
        r = r * 0.005353955978584176 + maxScale;
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
        ec_cwt_kernel51<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwt_kernel52<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>(*gpu_interval);
        interval_outdatedOnGpu = false;
        intDsq = 0.0;
        b_k = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        pathlen = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (j = 0; j < nrefine; j++) {
              cpu_interval[n_idx_0 - j] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - j) * r;
            }
          }

          b_k = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (nrefine = 0; nrefine < b_k; nrefine++) {
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

          ec_cwt_kernel53<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_k,
            *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
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
            ec_cwt_kernel68<<<grid, block>>>(*gpu_interval, nsubs - 1, *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            k = 15 * nsubs;
            ix = -1;
            for (b_k = 0; b_k < nsubs; b_k++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              maxScale = cpu_subs[b_k << 1];
              subs_outdatedOnCpu = false;
              r = cpu_subs[(b_k << 1) + 1];
              c_r = (maxScale + r) / 2.0;
              halfh = (r - maxScale) / 2.0;
              for (j = 0; j < 15; j++) {
                SD->f0.cpu_x_data[(ix + j) + 1] = NODES[j] * halfh + c_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            b_xt_size[0] = 1;
            b_xt_size[1] = k;
            mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
              2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwt_kernel69<<<grid, block>>>(*gpu_x_data, k - 1, *gpu_xt_data,
                *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              c_r = std::abs(SD->f0.cpu_x_data[0]);
              b_k = 0;
              exitg2 = false;
              while ((!exitg2) && (b_k <= k - 2)) {
                tol = c_r;
                c_r = std::abs(SD->f0.cpu_x_data[b_k + 1]);
                if (std::abs(SD->f0.cpu_x_data[b_k + 1] - SD->f0.cpu_x_data[b_k])
                    <= 2.2204460492503131E-14 * std::fmax(tol, c_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  b_k++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                  2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwt_kernel70<<<grid, block>>>(k - 1, *b_gpu_fx_data);
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
              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel71<<<grid, block>>>(*b_gpu_x_data, k - 1,
                  *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel72<<<grid, block>>>(*b_gpu_x_data, k - 1,
                  *gpu_x_data);
              }

              b_a_size[1] = k;
              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel73<<<grid, block>>>(*gpu_x_data, *gpu_y_data, k - 1,
                  *gpu_a_data);
              }

              dv11_size[0] = 1;
              dv11_size[1] = b_a_size[1];
              mwGetLaunchParameters1D(computeNumIters(b_a_size[1] - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel74<<<grid, block>>>(*gpu_a_data, b_a_size[1] - 1,
                  *gpu_dv11_data);
              }

              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel75<<<grid, block>>>(*b_gpu_x_data, k - 1,
                  *gpu_y_data);
              }

              dv14_size[0] = 1;
              dv14_size[1] = k;
              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel76<<<grid, block>>>(*gpu_y_data, k - 1, *gpu_x_data);
              }

              if (b_a_size[1] == k) {
                fx_size[0] = 1;
                fx_size[1] = b_a_size[1];
                mwGetLaunchParameters1D(computeNumIters(b_a_size[1] - 1), &grid,
                  &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwt_kernel77<<<grid, block>>>(*gpu_xt_data, *gpu_x_data,
                    *gpu_dv11_data, b_a_size[1] - 1, *b_gpu_fx_data);
                }

                b_fx_data_outdatedOnCpu = true;
              } else {
                if (b_fx_data_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_fx_data, *b_gpu_fx_data, 77880UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                checkCudaError(cudaMemcpy(cpu_dv11_data, *gpu_dv11_data, 77880UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *gpu_x_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_xt_data, *gpu_xt_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                binary_expand_op_3(cpu_fx_data, fx_size, cpu_dv11_data,
                                   dv11_size, SD->f0.cpu_x_data, dv14_size,
                                   SD->f0.cpu_xt_data, b_xt_size);
                b_fx_data_outdatedOnCpu = false;
              }

              c_r = 0.0;
              ix = -1;
              for (b_k = 0; b_k < nsubs; b_k++) {
                maxScale = 0.0;
                r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (b_fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(cpu_fx_data, *b_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  maxScale += dv5[j] * cpu_fx_data[(ix + j) + 1];
                  b_fx_data_outdatedOnCpu = false;
                  r += dv6[j] * cpu_fx_data[(ix + j) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                halfh = (cpu_subs[(b_k << 1) + 1] - cpu_subs[b_k << 1]) / 2.0;
                maxScale *= halfh;
                qsub[b_k] = maxScale;
                c_r += maxScale;
                errsub[b_k] = r * halfh;
              }

              intDsq = c_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              c_r = 2.0 * tol;
              r = 0.0;
              nrefine = 0;
              for (b_k = 0; b_k < nsubs; b_k++) {
                maxScale = errsub[b_k];
                halfh = std::abs(maxScale);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (halfh <= c_r * ((cpu_subs[(b_k << 1) + 1] - cpu_subs[b_k <<
                                     1]) / 2.0)) {
                  err_ok += maxScale;
                  q_ok += qsub[b_k];
                } else {
                  r += halfh;
                  nrefine++;
                  cpu_subs[(nrefine - 1) << 1] = cpu_subs[b_k << 1];
                  cpu_subs[((nrefine - 1) << 1) + 1] = cpu_subs[(b_k << 1) + 1];
                }
              }

              c_r = std::abs(err_ok) + r;
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(c_r)) && (!std::isnan(c_r))) && (nrefine != 0) &&
                  (!(c_r <= tol))) {
                nsubs = nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (b_k = 0; b_k < nrefine; b_k++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((nrefine - b_k) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nrefine - b_k) - 1) << 1) + 1];
                    cpu_subs[(((nrefine - b_k) << 1) - 1) << 1] = (cpu_subs
                      [((nrefine - b_k) - 1) << 1] + cpu_subs[(((nrefine - b_k)
                      - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nrefine - b_k) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nrefine - b_k) << 1) - 1) << 1];
                    cpu_subs[(((nrefine - b_k) << 1) - 2) << 1] = cpu_subs
                      [((nrefine - b_k) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        ec_cwt_kernel54<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwt_kernel55<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>(*gpu_interval);
        interval_outdatedOnGpu = false;
        intFsq = 0.0;
        b_k = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        pathlen = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (pathlen > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            r = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (j = 0; j < nrefine; j++) {
              cpu_interval[n_idx_0 - j] = cpu_interval[0] + static_cast<real_T>
                (n_idx_0 - j) * r;
            }
          }

          b_k = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (nrefine = 0; nrefine < b_k; nrefine++) {
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

          ec_cwt_kernel56<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_k,
            *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (pathlen <= 0) {
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
            ec_cwt_kernel61<<<grid, block>>>(*gpu_interval, nsubs - 1, *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            k = 15 * nsubs;
            ix = -1;
            for (b_k = 0; b_k < nsubs; b_k++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              maxScale = cpu_subs[b_k << 1];
              subs_outdatedOnCpu = false;
              r = cpu_subs[(b_k << 1) + 1];
              c_r = (maxScale + r) / 2.0;
              halfh = (r - maxScale) / 2.0;
              for (j = 0; j < 15; j++) {
                SD->f0.cpu_x_data[(ix + j) + 1] = NODES[j] * halfh + c_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
              2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwt_kernel62<<<grid, block>>>(*gpu_x_data, k - 1, *gpu_xt_data,
                *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              c_r = std::abs(SD->f0.cpu_x_data[0]);
              b_k = 0;
              exitg2 = false;
              while ((!exitg2) && (b_k <= k - 2)) {
                tol = c_r;
                c_r = std::abs(SD->f0.cpu_x_data[b_k + 1]);
                if (std::abs(SD->f0.cpu_x_data[b_k + 1] - SD->f0.cpu_x_data[b_k])
                    <= 2.2204460492503131E-14 * std::fmax(tol, c_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  b_k++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                  2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwt_kernel63<<<grid, block>>>(k - 1, *gpu_fx_data);
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
              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel64<<<grid, block>>>(*b_gpu_x_data, k - 1,
                  *gpu_dv16_data);
              }

              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel65<<<grid, block>>>(*b_gpu_x_data, k - 1,
                  *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel66<<<grid, block>>>(*gpu_y_data, k - 1, *gpu_x_data);
              }

              mwGetLaunchParameters1D(computeNumIters(k - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel67<<<grid, block>>>(*gpu_xt_data, *gpu_x_data,
                  *gpu_dv16_data, k - 1, *gpu_fx_data);
              }

              b_fx_data_outdatedOnCpu = true;
              c_r = 0.0;
              ix = -1;
              for (b_k = 0; b_k < nsubs; b_k++) {
                maxScale = 0.0;
                r = 0.0;
                for (j = 0; j < 15; j++) {
                  if (b_fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  maxScale += dv5[j] * SD->f0.cpu_fx_data[(ix + j) + 1];
                  b_fx_data_outdatedOnCpu = false;
                  r += dv6[j] * SD->f0.cpu_fx_data[(ix + j) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                halfh = (cpu_subs[(b_k << 1) + 1] - cpu_subs[b_k << 1]) / 2.0;
                maxScale *= halfh;
                qsub[b_k] = maxScale;
                c_r += maxScale;
                errsub[b_k] = r * halfh;
              }

              intFsq = c_r + q_ok;
              tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              c_r = 2.0 * tol;
              r = 0.0;
              nrefine = 0;
              for (b_k = 0; b_k < nsubs; b_k++) {
                maxScale = errsub[b_k];
                halfh = std::abs(maxScale);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (halfh <= c_r * ((cpu_subs[(b_k << 1) + 1] - cpu_subs[b_k <<
                                     1]) / 2.0)) {
                  err_ok += maxScale;
                  q_ok += qsub[b_k];
                } else {
                  r += halfh;
                  nrefine++;
                  cpu_subs[(nrefine - 1) << 1] = cpu_subs[b_k << 1];
                  cpu_subs[((nrefine - 1) << 1) + 1] = cpu_subs[(b_k << 1) + 1];
                }
              }

              c_r = std::abs(err_ok) + r;
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(c_r)) && (!std::isnan(c_r))) && (nrefine != 0) &&
                  (!(c_r <= tol))) {
                nsubs = nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (b_k = 0; b_k < nrefine; b_k++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((nrefine - b_k) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((nrefine - b_k) - 1) << 1) + 1];
                    cpu_subs[(((nrefine - b_k) << 1) - 1) << 1] = (cpu_subs
                      [((nrefine - b_k) - 1) << 1] + cpu_subs[(((nrefine - b_k)
                      - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((nrefine - b_k) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((nrefine - b_k) << 1) - 1) << 1];
                    cpu_subs[(((nrefine - b_k) << 1) - 2) << 1] = cpu_subs
                      [((nrefine - b_k) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        c_r = std::sqrt(3.5421952306087032 * (intDsq / intFsq));
      }
    } else if (cpu_wav[0] == 'a') {
      a = 6.0;
      c_r = 1.4142135623730951;
    } else {
      a = 5.0;
      c_r = 5.847705;
    }

    maxScale = static_cast<real_T>(cpu_x->size[0]) / (c_r * 2.0);
    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (wav_outdatedOnCpu) {
          checkCudaError(cudaMemcpy(cpu_wname, *gpu_wname, 5UL,
            cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        }

        wav_outdatedOnCpu = false;
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
        q_ok = r;
        if (c_r == 0.0) {
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
              err_ok = c_r;
              d = omegac - a;
              intDsq = d;
            }

            if (std::abs(err_ok) < std::abs(q_ok)) {
              a = omegac;
              omegac = intFsq;
              intFsq = a;
              c_r = q_ok;
              q_ok = err_ok;
              err_ok = c_r;
            }

            b_m = 0.5 * (intFsq - omegac);
            toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(b_m) <= toler) || (q_ok == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(intDsq) < toler) || (std::abs(c_r) <= std::abs(q_ok)))
              {
                d = b_m;
                intDsq = b_m;
              } else {
                s = q_ok / c_r;
                if (a == intFsq) {
                  c_r = 2.0 * b_m * s;
                  tol = 1.0 - s;
                } else {
                  tol = c_r / err_ok;
                  b_r = q_ok / err_ok;
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
                    (c_r < std::abs(0.5 * intDsq * tol))) {
                  intDsq = d;
                  d = c_r / tol;
                } else {
                  d = b_m;
                  intDsq = b_m;
                }
              }

              a = omegac;
              c_r = q_ok;
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

    emxInit_real_T(&c_cpu_y, 2, &ob_emlrtRTEI, true);
    r = std::fmax(tol, 1.0 / fb_VoicesPerOctave) * fb_VoicesPerOctave;
    if (std::isnan(r)) {
      eint = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(c_cpu_y, eint, &d_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &e_gpu_y, true);
      b_y_needsGpuEnsureCapacity = false;
      ec_cwt_kernel57<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(e_gpu_y);
    } else if (r < 0.0) {
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = 0;
    } else {
      eint = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = static_cast<int32_T>(r) + 1;
      emxEnsureCapacity_real_T(c_cpu_y, eint, &d_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(r)), &grid,
        &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &e_gpu_y, true);
      b_y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel60<<<grid, block>>>(static_cast<int32_T>(r), e_gpu_y);
      }
    }

    emxInit_real_T(&d_cpu_y, 2, &qb_emlrtRTEI, true);
    eint = d_cpu_y->size[0] * d_cpu_y->size[1];
    d_cpu_y->size[0] = 1;
    d_cpu_y->size[1] = c_cpu_y->size[1];
    emxEnsureCapacity_real_T(d_cpu_y, eint, &e_emlrtRTEI);
    b_k = c_cpu_y->size[1];
    mwGetLaunchParameters1D(computeNumIters(b_k - 1), &grid, &block, 2147483647U);
    if (b_y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &e_gpu_y, true);
    }

    gpuEmxEnsureCapacity_real_T(d_cpu_y, &f_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel58<<<grid, block>>>(e_gpu_y, rt_powd_snf(2.0, 1.0 /
        fb_VoicesPerOctave), b_k - 1, f_gpu_y);
    }

    emxFree_real_T(&c_cpu_y);
    eint = cpu_fb_Scales->size[0] * cpu_fb_Scales->size[1];
    cpu_fb_Scales->size[0] = 1;
    cpu_fb_Scales->size[1] = d_cpu_y->size[1];
    emxEnsureCapacity_real_T(cpu_fb_Scales, eint, &f_emlrtRTEI);
    k = d_cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    y_needsGpuEnsureCapacity = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel59<<<grid, block>>>(f_gpu_y, halfh, k, gpu_fb_Scales);
    }

    fx_data_outdatedOnCpu = true;
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

  emxInit_real_T(&cpu_daughter, 2, &p_emlrtRTEI, true);
  emxInit_real_T(&cpu_f, 2, &rb_emlrtRTEI, true);
  if (first_iteration) {
    emxInit_real_T(&b_cpu_somega, 2, &lb_emlrtRTEI, true);
    if (cpu_fb_Scales->size[1] == 1) {
      c_omega_tmp1_needsGpuEnsureCapa = false;
      interval_outdatedOnGpu = false;
      eint = b_cpu_somega->size[0] * b_cpu_somega->size[1];
      b_cpu_somega->size[0] = 1;
      if (cpu_fb_Omega->size[1] == 1) {
        b_cpu_somega->size[1] = 1;
      } else {
        b_cpu_somega->size[1] = cpu_fb_Omega->size[1];
      }

      emxEnsureCapacity_real_T(b_cpu_somega, eint, &h_emlrtRTEI);
      wav_outdatedOnCpu = true;
      lidx = (cpu_fb_Omega->size[1] != 1);
      nrefine = b_cpu_somega->size[1] - 1;
      for (b_k = 0; b_k <= nrefine; b_k++) {
        if (fx_data_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
        }

        fx_data_outdatedOnCpu = false;
        if (fb_Omega_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Omega, &gpu_fb_Omega);
        }

        fb_Omega_outdatedOnCpu = false;
        b_cpu_somega->data[b_k] = cpu_fb_Scales->data[0] * cpu_fb_Omega->
          data[lidx * b_k];
        interval_outdatedOnGpu = true;
        y_needsGpuEnsureCapacity = true;
      }
    } else {
      eint = b_cpu_somega->size[0] * b_cpu_somega->size[1];
      b_cpu_somega->size[0] = cpu_fb_Scales->size[1];
      b_cpu_somega->size[1] = cpu_fb_Omega->size[1];
      emxEnsureCapacity_real_T(b_cpu_somega, eint, &i_emlrtRTEI);
      nsubs = cpu_fb_Omega->size[1];
      k = cpu_fb_Scales->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(nsubs - 1, k), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_somega, &gpu_somega, true);
      wav_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel40<<<grid, block>>>(gpu_fb_Omega, gpu_fb_Scales, k, nsubs -
          1, gpu_somega, b_cpu_somega->size[0U]);
      }

      interval_outdatedOnGpu = false;
      c_omega_tmp1_needsGpuEnsureCapa = true;
    }

    b_k = b_cpu_somega->size[0] * b_cpu_somega->size[1];
    for (k = 0; k < 2; k++) {
      xSize[k] = static_cast<uint32_T>(b_cpu_somega->size[k]);
    }

    emxInit_real_T(&cpu_absomega, 2, &nb_emlrtRTEI, true);
    eint = cpu_absomega->size[0] * cpu_absomega->size[1];
    cpu_absomega->size[0] = static_cast<int32_T>(xSize[0]);
    cpu_absomega->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(cpu_absomega, eint, &k_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(b_k - 1), &grid, &block, 2147483647U);
    if (wav_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real_T(b_cpu_somega, &gpu_somega,
        !interval_outdatedOnGpu);
    }

    gpuEmxEnsureCapacity_real_T(cpu_absomega, &gpu_absomega, true);
    if (interval_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, b_cpu_somega);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel15<<<grid, block>>>(gpu_somega, b_k - 1, gpu_absomega);
    }

    emxInit_real_T(&cpu_powscales, 2, &m_emlrtRTEI, true);
    eint = cpu_powscales->size[0] * cpu_powscales->size[1];
    cpu_powscales->size[0] = cpu_absomega->size[0];
    cpu_powscales->size[1] = cpu_absomega->size[1];
    emxEnsureCapacity_real_T(cpu_powscales, eint, &m_emlrtRTEI);
    k = cpu_absomega->size[0] * cpu_absomega->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_powscales, &gpu_powscales, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel16<<<grid, block>>>(gpu_absomega, k, gpu_powscales);
    }

    b_k = cpu_absomega->size[0] * cpu_absomega->size[1];
    mwGetLaunchParameters1D(computeNumIters(b_k - 1), &grid, &block, 2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel17<<<grid, block>>>(b_k - 1, gpu_absomega);
    }

    emxInit_real_T(&b_cpu_x, 2, &n_emlrtRTEI, true);
    if ((cpu_absomega->size[0] == cpu_powscales->size[0]) && (cpu_absomega->
         size[1] == cpu_powscales->size[1])) {
      eint = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = cpu_absomega->size[0];
      b_cpu_x->size[1] = cpu_absomega->size[1];
      emxEnsureCapacity_real_T(b_cpu_x, eint, &n_emlrtRTEI);
      k = cpu_absomega->size[0] * cpu_absomega->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_x, &gpu_x, true);
      interval_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel18<<<grid, block>>>(gpu_powscales, gpu_absomega, k, gpu_x);
      }

      wav_outdatedOnCpu = false;
    } else {
      gpuEmxMemcpyGpuToCpu_real_T(cpu_absomega, &gpu_absomega);
      gpuEmxMemcpyGpuToCpu_real_T(cpu_powscales, &gpu_powscales);
      binary_expand_op_1(b_cpu_x, cpu_absomega, cpu_powscales);
      wav_outdatedOnCpu = true;
      interval_outdatedOnGpu = true;
    }

    emxFree_real_T(&cpu_powscales);
    emxFree_real_T(&cpu_absomega);
    b_k = b_cpu_x->size[0] * b_cpu_x->size[1];
    mwGetLaunchParameters1D(computeNumIters(b_k - 1), &grid, &block, 2147483647U);
    if (interval_outdatedOnGpu) {
      gpuEmxEnsureCapacity_real_T(b_cpu_x, &gpu_x, !wav_outdatedOnCpu);
    }

    if (wav_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, b_cpu_x);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel19<<<grid, block>>>(b_k - 1, gpu_x);
    }

    if ((b_cpu_x->size[0] == b_cpu_somega->size[0]) && (b_cpu_x->size[1] ==
         b_cpu_somega->size[1])) {
      eint = cpu_daughter->size[0] * cpu_daughter->size[1];
      cpu_daughter->size[0] = b_cpu_x->size[0];
      cpu_daughter->size[1] = b_cpu_x->size[1];
      emxEnsureCapacity_real_T(cpu_daughter, eint, &o_emlrtRTEI);
      k = b_cpu_x->size[0] * b_cpu_x->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter, true);
      b_fx_data_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel20<<<grid, block>>>(gpu_somega, gpu_x, k, gpu_daughter);
      }

      subs_outdatedOnCpu = false;
    } else {
      gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &gpu_x);
      if (c_omega_tmp1_needsGpuEnsureCapa) {
        gpuEmxMemcpyGpuToCpu_real_T(b_cpu_somega, &gpu_somega);
      }

      binary_expand_op(cpu_daughter, b_cpu_x, b_cpu_somega);
      subs_outdatedOnCpu = true;
      b_fx_data_outdatedOnCpu = true;
    }

    emxFree_real_T(&b_cpu_x);
    emxFree_real_T(&b_cpu_somega);
    eint = cpu_f->size[0] * cpu_f->size[1];
    cpu_f->size[0] = 1;
    cpu_f->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real_T(cpu_f, eint, &q_emlrtRTEI);
    k = cpu_fb_Scales->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    if (y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    }

    gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel21<<<grid, block>>>(gpu_fb_Scales, k, gpu_f);
    }
  } else {
    emxInit_real_T(&cpu_somega, 2, &kb_emlrtRTEI, true);
    if (cpu_fb_Scales->size[1] == 1) {
      interval_outdatedOnGpu = false;
      eint = cpu_somega->size[0] * cpu_somega->size[1];
      cpu_somega->size[0] = 1;
      if (cpu_fb_Omega->size[1] == 1) {
        cpu_somega->size[1] = 1;
      } else {
        cpu_somega->size[1] = cpu_fb_Omega->size[1];
      }

      emxEnsureCapacity_real_T(cpu_somega, eint, &h_emlrtRTEI);
      wav_outdatedOnCpu = true;
      lidx = (cpu_fb_Omega->size[1] != 1);
      nrefine = cpu_somega->size[1] - 1;
      for (b_k = 0; b_k <= nrefine; b_k++) {
        if (fx_data_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
        }

        fx_data_outdatedOnCpu = false;
        if (fb_Omega_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Omega, &gpu_fb_Omega);
        }

        fb_Omega_outdatedOnCpu = false;
        cpu_somega->data[b_k] = cpu_fb_Scales->data[0] * cpu_fb_Omega->data[lidx
          * b_k];
        interval_outdatedOnGpu = true;
        y_needsGpuEnsureCapacity = true;
      }
    } else {
      eint = cpu_somega->size[0] * cpu_somega->size[1];
      cpu_somega->size[0] = cpu_fb_Scales->size[1];
      cpu_somega->size[1] = cpu_fb_Omega->size[1];
      emxEnsureCapacity_real_T(cpu_somega, eint, &g_emlrtRTEI);
      nsubs = cpu_fb_Omega->size[1];
      k = cpu_fb_Scales->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(nsubs - 1, k), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_somega, &b_gpu_somega, true);
      wav_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel48<<<grid, block>>>(gpu_fb_Omega, gpu_fb_Scales, k, nsubs -
          1, b_gpu_somega, cpu_somega->size[0U]);
      }

      interval_outdatedOnGpu = false;
    }

    emxInit_real_T(&cpu_w, 2, &j_emlrtRTEI, true);
    eint = cpu_w->size[0] * cpu_w->size[1];
    cpu_w->size[0] = cpu_somega->size[0];
    cpu_w->size[1] = cpu_somega->size[1];
    emxEnsureCapacity_real_T(cpu_w, eint, &j_emlrtRTEI);
    k = cpu_somega->size[0] * cpu_somega->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    if (wav_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real_T(cpu_somega, &b_gpu_somega,
        !interval_outdatedOnGpu);
    }

    gpuEmxEnsureCapacity_real_T(cpu_w, &gpu_w, true);
    if (interval_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_somega, cpu_somega);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel41<<<grid, block>>>(b_gpu_somega, k, gpu_w);
    }

    emxFree_real_T(&cpu_somega);
    emxInit_real_T(&cpu_expnt, 2, &mb_emlrtRTEI, true);
    eint = cpu_expnt->size[0] * cpu_expnt->size[1];
    cpu_expnt->size[0] = cpu_w->size[0];
    cpu_expnt->size[1] = cpu_w->size[1];
    emxEnsureCapacity_real_T(cpu_expnt, eint, &l_emlrtRTEI);
    k = cpu_w->size[0] * cpu_w->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_expnt, &gpu_expnt, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel42<<<grid, block>>>(gpu_w, k, gpu_expnt);
    }

    b_k = cpu_expnt->size[0] * cpu_expnt->size[1];
    mwGetLaunchParameters1D(computeNumIters(b_k - 1), &grid, &block, 2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel43<<<grid, block>>>(b_k - 1, gpu_expnt);
    }

    b_k = cpu_w->size[0] * cpu_w->size[1];
    for (k = 0; k < 2; k++) {
      xSize[k] = static_cast<uint32_T>(cpu_w->size[k]);
    }

    emxInit_real_T(&e_cpu_y, 2, &pb_emlrtRTEI, true);
    eint = e_cpu_y->size[0] * e_cpu_y->size[1];
    e_cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    e_cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(e_cpu_y, eint, &k_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(b_k - 1), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(e_cpu_y, &d_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel44<<<grid, block>>>(gpu_w, b_k - 1, d_gpu_y);
    }

    emxFree_real_T(&cpu_w);
    if ((cpu_expnt->size[0] == e_cpu_y->size[0]) && (cpu_expnt->size[1] ==
         e_cpu_y->size[1])) {
      eint = cpu_daughter->size[0] * cpu_daughter->size[1];
      cpu_daughter->size[0] = cpu_expnt->size[0];
      cpu_daughter->size[1] = cpu_expnt->size[1];
      emxEnsureCapacity_real_T(cpu_daughter, eint, &p_emlrtRTEI);
      k = cpu_expnt->size[0] * cpu_expnt->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter, true);
      b_fx_data_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel45<<<grid, block>>>(d_gpu_y, gpu_expnt, k, gpu_daughter);
      }

      subs_outdatedOnCpu = false;
    } else {
      gpuEmxMemcpyGpuToCpu_real_T(cpu_expnt, &gpu_expnt);
      gpuEmxMemcpyGpuToCpu_real_T(e_cpu_y, &d_gpu_y);
      binary_expand_op_2(cpu_daughter, cpu_expnt, e_cpu_y);
      subs_outdatedOnCpu = true;
      b_fx_data_outdatedOnCpu = true;
    }

    emxFree_real_T(&e_cpu_y);
    emxFree_real_T(&cpu_expnt);
    nrefine = cpu_daughter->size[0] * cpu_daughter->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(nrefine), &grid, &block, 2147483647U);
    if (b_fx_data_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter,
        !subs_outdatedOnCpu);
    }

    b_fx_data_outdatedOnCpu = false;
    if (subs_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_daughter, cpu_daughter);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel46<<<grid, block>>>(nrefine, gpu_daughter);
    }

    subs_outdatedOnCpu = false;
    eint = cpu_f->size[0] * cpu_f->size[1];
    cpu_f->size[0] = 1;
    cpu_f->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real_T(cpu_f, eint, &s_emlrtRTEI);
    k = cpu_fb_Scales->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    if (y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    }

    gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel47<<<grid, block>>>(gpu_fb_Scales, k, gpu_f);
    }
  }

  emxFree_real_T(&cpu_fb_Omega);
  emxFree_real_T(&cpu_fb_Scales);
  eint = cpu_f->size[0] * cpu_f->size[1];
  cpu_f->size[0] = 1;
  emxEnsureCapacity_real_T(cpu_f, eint, &r_emlrtRTEI);
  eint = cpu_f->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(eint), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwt_kernel22<<<grid, block>>>(fs, eint, gpu_f);
  }

  // 'ec_cwt:30' freqs = centerFrequencies(fb);
  eint = cpu_freqs->size[0];
  cpu_freqs->size[0] = cpu_f->size[1];
  emxEnsureCapacity_real_T(cpu_freqs, eint, &t_emlrtRTEI);
  k = cpu_f->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_freqs, &gpu_freqs, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwt_kernel23<<<grid, block>>>(gpu_f, k, gpu_freqs);
  }

  // 'ec_cwt:31' nFreqs = uint32(numel(freqs));
  // 'ec_cwt:32' nFrames = uint32(numel(1:ds2:nFrames));
  emxInit_real32_T(&cpu_fv, 2, &sb_emlrtRTEI, true);
  if (std::isnan(ds2)) {
    eint = cpu_fv->size[0] * cpu_fv->size[1];
    cpu_fv->size[1] = 1;
    emxEnsureCapacity_real32_T(cpu_fv, eint, &u_emlrtRTEI);
  } else if ((ds2 == 0.0F) || ((cpu_x->size[0] > 1) && (ds2 < 0.0F)) ||
             ((cpu_x->size[0] < 1) && (ds2 > 0.0F))) {
    cpu_fv->size[1] = 0;
  } else if (std::isinf(ds2)) {
    eint = cpu_fv->size[0] * cpu_fv->size[1];
    cpu_fv->size[1] = 1;
    emxEnsureCapacity_real32_T(cpu_fv, eint, &u_emlrtRTEI);
  } else {
    eint = cpu_x->size[0];
    ix = cpu_fv->size[0] * cpu_fv->size[1];
    cpu_fv->size[0] = 1;
    cpu_fv->size[1] = static_cast<int32_T>((static_cast<real_T>(cpu_x->size[0])
      - 1.0) / ds2) + 1;
    emxEnsureCapacity_real32_T(cpu_fv, ix, &u_emlrtRTEI);
    k = static_cast<int32_T>((static_cast<real_T>(eint) - 1.0) / ds2);
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel39<<<grid, block>>>(ds2, k, gpu_fv);
    }
  }

  //  Preallocate
  // 'ec_cwt:35' xx = coder.nullcopy(zeros([nFrames nChs nFreqs],like=x));
  wav_outdatedOnCpu = false;
  eint = cpu_xx->size[0] * cpu_xx->size[1] * cpu_xx->size[2];
  cpu_xx->size[0] = cpu_fv->size[1];
  emxFree_real32_T(&cpu_fv);
  cpu_xx->size[1] = cpu_x->size[1];
  cpu_xx->size[2] = cpu_f->size[1];
  emxFree_real_T(&cpu_f);
  emxEnsureCapacity_real32_T(cpu_xx, eint, &v_emlrtRTEI);
  c_omega_tmp1_needsGpuEnsureCapa = true;

  //  Preallocate output
  //  xx = cell(1,nChs);
  //  CWT per channel
  // 'ec_cwt:39' coder.gpu.kernel(nChs,-1)
  // 'ec_cwt:40' for ch = 1:nChs
  emxInit_creal32_T(&cpu_cfspos, 2, &db_emlrtRTEI, true);
  emxInit_real32_T(&cpu_psihat, 2, &w_emlrtRTEI, true);
  emxInit_real32_T(&cpu_xv, 2, &x_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_xposdft, 2, &y_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_x, 2, &bb_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_cfsposdft, 2, &tb_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_y, 2, &ub_emlrtRTEI, true);
  emxInit_real32_T(&cpu_xCh, 2, &fb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_xCh, 2, &gb_emlrtRTEI, true);
  e = computeEndIdx(1L, static_cast<int64_T>(nChs), 1L);
  for (int64_T ch{0L}; ch <= e; ch++) {
    // 'ec_cwt:41' coder.gpu.constantMemory(xx);
    // 'ec_cwt:42' xCh = abs(wt(fb,x(:,ch)))';
    eint = cpu_psihat->size[0] * cpu_psihat->size[1];
    cpu_psihat->size[0] = cpu_daughter->size[0];
    cpu_psihat->size[1] = cpu_daughter->size[1];
    emxEnsureCapacity_real32_T(cpu_psihat, eint, &w_emlrtRTEI);
    k = cpu_daughter->size[0] * cpu_daughter->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    if (b_fx_data_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter,
        !subs_outdatedOnCpu);
    }

    b_fx_data_outdatedOnCpu = false;
    gpuEmxEnsureCapacity_real32_T(cpu_psihat, &gpu_psihat, true);
    if (subs_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_daughter, cpu_daughter);
    }

    subs_outdatedOnCpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel24<<<grid, block>>>(gpu_daughter, k, gpu_psihat);
    }

    eint = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    cpu_xv->size[1] = cpu_x->size[0];
    emxEnsureCapacity_real32_T(cpu_xv, eint, &x_emlrtRTEI);
    k = cpu_x->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    if (x_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real32_T(cpu_x, &b_gpu_x, !x_outdatedOnGpu);
    }

    x_needsGpuEnsureCapacity = false;
    gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, true);
    wav_outdatedOnCpu = false;
    if (x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_x, cpu_x);
    }

    x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel25<<<grid, block>>>(static_cast<int32_T>(ch + 1L), b_gpu_x, k,
        gpu_xv, cpu_x->size[0U]);
    }

    interval_outdatedOnGpu = false;
    if (fb_SignalPad > 0) {
      lidx = cpu_x->size[0] - fb_SignalPad;
      if (lidx + 1 > cpu_x->size[0]) {
        ix = 0;
        b_k = 1;
        lidx = -1;
      } else {
        ix = cpu_x->size[0] - 1;
        b_k = -1;
      }

      eint = c_cpu_x->size[0] * c_cpu_x->size[1];
      c_cpu_x->size[0] = 1;
      c_cpu_x->size[1] = fb_SignalPad;
      emxEnsureCapacity_real32_T(c_cpu_x, eint, &bb_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(fb_SignalPad - 1), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real32_T(c_cpu_x, &c_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel26<<<grid, block>>>(static_cast<int32_T>(ch + 1L), b_gpu_x,
          fb_SignalPad - 1, c_gpu_x, cpu_x->size[0U]);
      }

      mwGetLaunchParameters1D(computeNumIters((fb_SignalPad >> 1) - 1), &grid,
        &block, 2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel27<<<grid, block>>>(fb_SignalPad, (fb_SignalPad >> 1) - 1,
          c_gpu_x);
      }

      eint = cpu_xv->size[0] * cpu_xv->size[1];
      cpu_xv->size[0] = 1;
      cpu_xv->size[1] = ((cpu_x->size[0] + c_cpu_x->size[1]) + div_s32(lidx - ix,
        b_k)) + 1;
      emxEnsureCapacity_real32_T(cpu_xv, eint, &cb_emlrtRTEI);
      nsubs = c_cpu_x->size[1];
      mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel28<<<grid, block>>>(c_gpu_x, nsubs - 1, gpu_xv);
      }

      fx_data_outdatedOnCpu = true;
      nsubs = cpu_x->size[0];
      for (eint = 0; eint < nsubs; eint++) {
        if (fx_data_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xv, &gpu_xv);
        }

        cpu_xv->data[eint + c_cpu_x->size[1]] = cpu_x->data[eint + cpu_x->size[0]
          * (static_cast<int32_T>(ch + 1L) - 1)];
        fx_data_outdatedOnCpu = false;
        interval_outdatedOnGpu = true;
        x_needsGpuEnsureCapacity = true;
        wav_outdatedOnCpu = true;
      }

      nsubs = div_s32(lidx - ix, b_k);
      for (eint = 0; eint <= nsubs; eint++) {
        if (fx_data_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xv, &gpu_xv);
        }

        cpu_xv->data[(eint + cpu_x->size[0]) + c_cpu_x->size[1]] = cpu_x->data
          [(ix + b_k * eint) + cpu_x->size[0] * (static_cast<int32_T>(ch + 1L) -
          1)];
        fx_data_outdatedOnCpu = false;
        interval_outdatedOnGpu = true;
        x_needsGpuEnsureCapacity = true;
        wav_outdatedOnCpu = true;
      }
    }

    if (cpu_xv->size[1] - (static_cast<int32_T>(static_cast<uint32_T>
          (cpu_xv->size[1]) >> 1) << 1) == 1) {
      cufftHandle fftPlanHandle;
      eint = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = cpu_xv->size[1];
      emxEnsureCapacity_creal32_T(cpu_xposdft, eint, &y_emlrtRTEI);
      k = cpu_xv->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      if (wav_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, !interval_outdatedOnGpu);
      }

      gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft, true);
      if (interval_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
      }

      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel29<<<grid, block>>>(gpu_xv, k, gpu_xposdft);
      }

      nrefine = cpu_xposdft->size[1];
      fftPlanHandle = acquireCUFFTPlan(1, &nrefine, &nrefine, 1, 1, CUFFT_C2C, 1);
      cufftExecC2C(fftPlanHandle, (cufftComplex *)&gpu_xposdft.data[0],
                   (cufftComplex *)&gpu_xposdft.data[0], CUFFT_FORWARD);
    } else {
      cufftHandle b_fftPlanHandle;
      nrefine = cpu_xv->size[1];
      for (k = 0; k < 2; k++) {
        xSize[k] = static_cast<uint32_T>(cpu_xv->size[k]);
      }

      eint = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = static_cast<int32_T>(xSize[1]);
      emxEnsureCapacity_creal32_T(cpu_xposdft, eint, &ab_emlrtRTEI);
      b_fftPlanHandle = acquireCUFFTPlan(1, &nrefine, &nrefine, 1, 1, CUFFT_R2C,
        1);
      if (wav_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, !interval_outdatedOnGpu);
      }

      gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft, true);
      if (interval_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
      }

      cufftExecR2C(b_fftPlanHandle, (cufftReal *)&gpu_xv.data[0], (cufftComplex *)
                   &gpu_xposdft.data[0]);
      mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>
        (static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) / 2.0) - 2),
        &grid, &block, 2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel38<<<grid, block>>>(static_cast<int32_T>(static_cast<real_T>
          (static_cast<int32_T>(xSize[1]) + 1) / 2.0) - 2, gpu_xposdft, xSize[1]);
      }
    }

    nrefine = cpu_psihat->size[1];
    pathlen = cpu_xposdft->size[1];
    if (nrefine <= pathlen) {
      pathlen = nrefine;
    }

    if (cpu_psihat->size[1] == 1) {
      eint = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == cpu_psihat->size[1]) {
      eint = cpu_xposdft->size[1];
    } else {
      eint = pathlen;
    }

    ix = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
    cpu_cfsposdft->size[0] = cpu_psihat->size[0];
    nrefine = cpu_psihat->size[1];
    pathlen = cpu_xposdft->size[1];
    if (nrefine <= pathlen) {
      pathlen = nrefine;
    }

    if (cpu_psihat->size[1] == 1) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == cpu_psihat->size[1]) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else {
      cpu_cfsposdft->size[1] = pathlen;
    }

    emxEnsureCapacity_creal32_T(cpu_cfsposdft, ix, &h_emlrtRTEI);
    wav_outdatedOnCpu = true;
    if ((cpu_psihat->size[0] != 0) && (eint != 0)) {
      lidx = (cpu_psihat->size[1] != 1);
      pathlen = cpu_cfsposdft->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(eint - 1, pathlen), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_cfsposdft, &gpu_cfsposdft, true);
      wav_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel30<<<grid, block>>>(gpu_xposdft, gpu_psihat, lidx, pathlen,
          eint - 1, gpu_cfsposdft, cpu_psihat->size[0U], cpu_cfsposdft->size[0U]);
      }
    }

    if ((cpu_cfsposdft->size[0] == 0) || (cpu_cfsposdft->size[1] == 0)) {
      for (k = 0; k < 2; k++) {
        xSize[k] = static_cast<uint32_T>(cpu_cfsposdft->size[k]);
      }

      xSize[1] = static_cast<uint32_T>(cpu_cfsposdft->size[1]);
      eint = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[0] = static_cast<int32_T>(xSize[0]);
      cpu_cfspos->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal32_T(cpu_cfspos, eint, &db_emlrtRTEI);
      k = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_cfspos, &gpu_cfspos, true);
      wav_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel31<<<grid, block>>>(k, gpu_cfspos);
      }

      interval_outdatedOnGpu = false;
      fx_data_outdatedOnCpu = true;
    } else {
      cufftHandle c_fftPlanHandle;
      real32_T cfsposdft_re;
      nrefine = cpu_cfsposdft->size[1];
      c_fftPlanHandle = acquireCUFFTPlan(1, &nrefine, &nrefine,
        cpu_cfsposdft->size[0], 1, CUFFT_C2C, cpu_cfsposdft->size[0]);
      if (wav_outdatedOnCpu) {
        gpuEmxEnsureCapacity_creal32_T(cpu_cfsposdft, &gpu_cfsposdft, true);
      }

      cufftExecC2C(c_fftPlanHandle, (cufftComplex *)&gpu_cfsposdft.data[0],
                   (cufftComplex *)&gpu_cfsposdft.data[0], CUFFT_INVERSE);
      eint = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[0] = cpu_cfsposdft->size[0];
      cpu_cfspos->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal32_T(cpu_cfspos, eint, &db_emlrtRTEI);
      cfsposdft_re = static_cast<real32_T>(cpu_cfsposdft->size[1]);
      pathlen = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(pathlen), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_cfspos, &gpu_cfspos, true);
      wav_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel37<<<grid, block>>>(cfsposdft_re, gpu_cfsposdft, pathlen,
          gpu_cfspos);
      }

      interval_outdatedOnGpu = false;
      fx_data_outdatedOnCpu = true;
    }

    if (fb_SignalPad > 0) {
      nChs = static_cast<uint32_T>(fb_SignalPad) + static_cast<uint32_T>
        (cpu_x->size[0]);
      if (static_cast<uint32_T>(fb_SignalPad + 1) > nChs) {
        pathlen = 0;
        nrefine = 0;
      } else {
        pathlen = fb_SignalPad;
        nrefine = static_cast<int32_T>(nChs);
      }

      lidx = cpu_cfspos->size[0];
      nsubs = nrefine - pathlen;
      for (eint = 0; eint < nsubs; eint++) {
        for (ix = 0; ix < lidx; ix++) {
          if (fx_data_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_cfspos, &gpu_cfspos);
          }

          cpu_cfspos->data[ix + lidx * eint] = cpu_cfspos->data[ix +
            cpu_cfspos->size[0] * (pathlen + eint)];
          fx_data_outdatedOnCpu = false;
          interval_outdatedOnGpu = true;
        }
      }

      eint = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[1] = nrefine - pathlen;
      emxEnsureCapacity_creal32_T(cpu_cfspos, eint, &eb_emlrtRTEI);
      wav_outdatedOnCpu = true;
    }

    b_k = cpu_cfspos->size[0] * cpu_cfspos->size[1];
    for (k = 0; k < 2; k++) {
      xSize[k] = static_cast<uint32_T>(cpu_cfspos->size[k]);
    }

    eint = f_cpu_y->size[0] * f_cpu_y->size[1];
    f_cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    f_cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real32_T(f_cpu_y, eint, &k_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(b_k - 1), &grid, &block, 2147483647U);
    if (wav_outdatedOnCpu) {
      gpuEmxEnsureCapacity_creal32_T(cpu_cfspos, &gpu_cfspos,
        !interval_outdatedOnGpu);
    }

    gpuEmxEnsureCapacity_real32_T(f_cpu_y, &c_gpu_y, true);
    if (interval_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_cfspos, cpu_cfspos);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel32<<<grid, block>>>(gpu_cfspos, b_k - 1, c_gpu_y);
    }

    eint = cpu_xCh->size[0] * cpu_xCh->size[1];
    cpu_xCh->size[0] = f_cpu_y->size[1];
    cpu_xCh->size[1] = f_cpu_y->size[0];
    emxEnsureCapacity_real32_T(cpu_xCh, eint, &fb_emlrtRTEI);
    k = f_cpu_y->size[0] - 1;
    pathlen = f_cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k, pathlen), &grid, &block,
      2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_xCh, &gpu_xCh, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel33<<<grid, block>>>(c_gpu_y, pathlen, k, gpu_xCh,
        cpu_xCh->size[0U], f_cpu_y->size[0U]);
    }

    //  CWT
    // 'ec_cwt:43' if ds2>1
    if (ds2 > 1.0F) {
      // 'ec_cwt:44' xCh = xCh(1:ds2:end,:);
      if (cpu_xCh->size[0] < 1.0F) {
        pathlen = 1;
        nrefine = -1;
      } else {
        pathlen = static_cast<int32_T>(ds2);
        nrefine = static_cast<int32_T>(static_cast<real32_T>(cpu_xCh->size[0]))
          - 1;
      }

      lidx = cpu_xCh->size[1];
      eint = b_cpu_xCh->size[0] * b_cpu_xCh->size[1];
      b_cpu_xCh->size[0] = div_s32(nrefine, pathlen) + 1;
      b_cpu_xCh->size[1] = cpu_xCh->size[1];
      emxEnsureCapacity_real32_T(b_cpu_xCh, eint, &gb_emlrtRTEI);
      k = nrefine / pathlen;
      mwGetLaunchParameters1D(computeNumIters(lidx - 1, k), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real32_T(b_cpu_xCh, &b_gpu_xCh, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel34<<<grid, block>>>(gpu_xCh, pathlen, k, lidx - 1,
          b_gpu_xCh, b_cpu_xCh->size[0U], cpu_xCh->size[0U]);
      }

      eint = cpu_xCh->size[0] * cpu_xCh->size[1];
      cpu_xCh->size[0] = b_cpu_xCh->size[0];
      cpu_xCh->size[1] = b_cpu_xCh->size[1];
      emxEnsureCapacity_real32_T(cpu_xCh, eint, &hb_emlrtRTEI);
      k = b_cpu_xCh->size[0] * b_cpu_xCh->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_xCh, &gpu_xCh, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwt_kernel35<<<grid, block>>>(b_gpu_xCh, k, gpu_xCh);
      }

      //  Downsample
    }

    // 'ec_cwt:46' xx(:,ch,:) = xCh;
    xx[0] = cpu_xx->size[0];
    xx[2] = cpu_xx->size[2];
    mwGetLaunchParameters1D(computeNumIters(xx[2] - 1, xx[0] - 1), &grid, &block,
      2147483647U);
    if (c_omega_tmp1_needsGpuEnsureCapa) {
      gpuEmxEnsureCapacity_real32_T(cpu_xx, &gpu_xx, true);
    }

    c_omega_tmp1_needsGpuEnsureCapa = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel36<<<grid, block>>>(gpu_xCh, xx[0], static_cast<int32_T>(ch +
        1L), xx[0] - 1, xx[2] - 1, gpu_xx, cpu_xx->size[0U], cpu_xx->size[1U]);
    }

    wav_outdatedOnCpu = true;

    //  Copy to output matrix
  }

  emxFree_real32_T(&b_cpu_xCh);
  emxFree_real32_T(&cpu_xCh);
  emxFree_real32_T(&f_cpu_y);
  emxFree_creal32_T(&cpu_cfsposdft);
  emxFree_real32_T(&c_cpu_x);
  emxFree_creal32_T(&cpu_xposdft);
  emxFree_real32_T(&cpu_xv);
  emxFree_real32_T(&cpu_psihat);
  emxFree_creal32_T(&cpu_cfspos);
  emxFree_real_T(&cpu_daughter);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (wav_outdatedOnCpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_xx, &gpu_xx);
  }

  gpuEmxMemcpyGpuToCpu_real_T(cpu_freqs, &gpu_freqs);
  gpuEmxFree_real32_T(&b_gpu_x);
  gpuEmxFree_real32_T(&gpu_xx);
  gpuEmxFree_real_T(&gpu_freqs);
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
  checkCudaError(mwCudaFree(*d_gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&e_gpu_y);
  checkCudaError(mwCudaFree(*b_gpu_a_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&f_gpu_y);
  checkCudaError(mwCudaFree(*gpu_dv10_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_dv4_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*c_gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_daughter);
  gpuEmxFree_real_T(&gpu_f);
  gpuEmxFree_real_T(&b_gpu_somega);
  gpuEmxFree_real_T(&gpu_somega);
  gpuEmxFree_real_T(&gpu_w);
  gpuEmxFree_real_T(&gpu_absomega);
  gpuEmxFree_real_T(&gpu_expnt);
  checkCudaError(mwCudaFree(*b_gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_powscales);
  checkCudaError(mwCudaFree(*gpu_a_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&d_gpu_y);
  checkCudaError(mwCudaFree(*gpu_dv16_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_dv11_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real32_T(&gpu_fv);
  gpuEmxFree_creal32_T(&gpu_cfspos);
  gpuEmxFree_real32_T(&gpu_psihat);
  gpuEmxFree_real32_T(&gpu_xv);
  gpuEmxFree_creal32_T(&gpu_xposdft);
  gpuEmxFree_real32_T(&c_gpu_x);
  gpuEmxFree_creal32_T(&gpu_cfsposdft);
  gpuEmxFree_real32_T(&c_gpu_y);
  gpuEmxFree_real32_T(&gpu_xCh);
  gpuEmxFree_real32_T(&b_gpu_xCh);
}

void ec_cwt_api(ec_cwtStackData *SD, const mxArray * const prhs[5], int32_T nlhs,
                const mxArray *plhs[2])
{
  emxArray_real32_T *x;
  emxArray_real32_T *xx;
  emxArray_real_T *freqs;
  const mxArray *prhs_copy_idx_2;
  real_T (*fLims)[2];
  real_T fOctave;
  real_T fs;
  real32_T ds2;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_2 = emlrtProtectR2012b(prhs[2], 2, false, -1);

  // Marshall function inputs
  emxInit_real32_T(&x, 2, &wb_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  fs = emlrt_marshallIn(emlrtAliasP(prhs[1]), "fs");
  fLims = b_emlrt_marshallIn(emlrtAlias(prhs_copy_idx_2), "fLims");
  fOctave = emlrt_marshallIn(emlrtAliasP(prhs[3]), "fOctave");
  ds2 = c_emlrt_marshallIn(emlrtAliasP(prhs[4]), "ds2");

  // Invoke the target function
  emxInit_real32_T(&xx, 3, &wb_emlrtRTEI, true);
  emxInit_real_T(&freqs, 1, &wb_emlrtRTEI, true);
  ec_cwt(SD, x, fs, *fLims, fOctave, ds2, xx, freqs);
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

void ec_cwt_atexit()
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

void ec_cwt_initialize()
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
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    ec_cwt_once();
  }
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
}

// End of code generation (ec_cwt.cu)
