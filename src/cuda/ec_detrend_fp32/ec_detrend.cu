//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detrend.cu
//
// Code generation for function 'ec_detrend'
//

// Include files
#include "ec_detrend.h"
#include "_coder_ec_detrend_mex.h"
#include "ec_detrend_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCUSOLVERUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWMemoryManager.hpp"
#include "lapacke.h"
#include "math_constants.h"
#include <algorithm>
#include <cfloat>
#include <cmath>
#include <cstddef>
#include <cstring>

// Type Definitions
struct emxArray_creal32_T
{
  creal32_T *data;
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

struct emxArray_ptrdiff_t
{
  ptrdiff_t *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct emxArray_boolean_T
{
  boolean_T *data;
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
  "ec_detrend",                        // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 3130694236U, 2616137409U, 972914731U, 129233577U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtRTEInfo emlrtRTEI{ 1,      // lineNo
  1,                                   // colNo
  "_coder_ec_detrend_api",             // fName
  ""                                   // pName
};

static emlrtRTEInfo b_emlrtRTEI{ 27,   // lineNo
  39,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 38,   // lineNo
  1,                                   // colNo
  "squeeze",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/squeeze.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 47,   // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 99,   // lineNo
  20,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 75,   // lineNo
  20,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 49,   // lineNo
  20,                                  // colNo
  "linspace",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/linspace.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 103,  // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 1,    // lineNo
  1,                                   // colNo
  "dts_zeros",                         // fName
  "/usr/local/MATLAB/R2023a/toolbox/coder/float2fixed/dtslib/dts_zeros.p"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 82,   // lineNo
  20,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 92,   // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 6,    // lineNo
  5,                                   // colNo
  "singleCInternal",                   // fName
  ""                                   // pName
};

static emlrtRTEInfo n_emlrtRTEI{ 112,  // lineNo
  29,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 119,  // lineNo
  28,                                  // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 320,  // lineNo
  20,                                  // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 171,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 55,   // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 170,  // lineNo
  24,                                  // colNo
  "combineVectorElements",             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "sum",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/sum.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 172,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 173,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 174,  // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 158,  // lineNo
  24,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 56,   // lineNo
  24,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 60,  // lineNo
  28,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 175, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 85,  // lineNo
  9,                                   // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 176, // lineNo
  10,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 47,  // lineNo
  20,                                  // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 109, // lineNo
  24,                                  // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 99,  // lineNo
  24,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 89,  // lineNo
  13,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 100, // lineNo
  5,                                   // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 102, // lineNo
  21,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 28,  // lineNo
  9,                                   // colNo
  "eigHermitianStandard",              // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/private/eigHermitianStandard.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 62,  // lineNo
  9,                                   // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 76,  // lineNo
  22,                                  // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 106, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 131, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 42,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 132, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 69,  // lineNo
  13,                                  // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 63,  // lineNo
  9,                                   // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 33,  // lineNo
  5,                                   // colNo
  "eigHermitianStandard",              // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/private/eigHermitianStandard.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 134, // lineNo
  35,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 1,   // lineNo
  18,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 86,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 177, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 46,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 111, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 87,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 177, // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 160, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 112, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 168, // lineNo
  16,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 23,  // lineNo
  9,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 161, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 129, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 27,  // lineNo
  13,                                  // colNo
  "eigStandard",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/private/eigStandard.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 24,  // lineNo
  9,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "dts_binary_op",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/coder/float2fixed/dtslib/dts_binary_op.p"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 142, // lineNo
  41,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 178, // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 130, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 179, // lineNo
  6,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 179, // lineNo
  16,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 18,  // lineNo
  29,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 44,  // lineNo
  32,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 179, // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 50,  // lineNo
  31,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 44,  // lineNo
  35,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 180, // lineNo
  10,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 53,  // lineNo
  13,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 61,  // lineNo
  9,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 92,  // lineNo
  22,                                  // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 105, // lineNo
  1,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 85,  // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 85,  // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ed_emlrtRTEI{ 85,  // lineNo
  1,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo fd_emlrtRTEI{ 88,  // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo gd_emlrtRTEI{ 119, // lineNo
  5,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo hd_emlrtRTEI{ 30,  // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo id_emlrtRTEI{ 126, // lineNo
  34,                                  // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo jd_emlrtRTEI{ 90,  // lineNo
  7,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo kd_emlrtRTEI{ 122, // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ld_emlrtRTEI{ 126, // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo md_emlrtRTEI{ 128, // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo nd_emlrtRTEI{ 130, // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo od_emlrtRTEI{ 134, // lineNo
  11,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo pd_emlrtRTEI{ 134, // lineNo
  27,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo qd_emlrtRTEI{ 135, // lineNo
  15,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo rd_emlrtRTEI{ 135, // lineNo
  31,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo sd_emlrtRTEI{ 136, // lineNo
  29,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo td_emlrtRTEI{ 136, // lineNo
  11,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ud_emlrtRTEI{ 34,  // lineNo
  1,                                   // colNo
  "rdivide_helper",                    // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/rdivide_helper.m"// pName
};

static emlrtRTEInfo vd_emlrtRTEI{ 145, // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo wd_emlrtRTEI{ 145, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo xd_emlrtRTEI{ 147, // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo yd_emlrtRTEI{ 147, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ae_emlrtRTEI{ 151, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo be_emlrtRTEI{ 153, // lineNo
  7,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ce_emlrtRTEI{ 45,  // lineNo
  11,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo de_emlrtRTEI{ 104, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ee_emlrtRTEI{ 75,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo fe_emlrtRTEI{ 76,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ge_emlrtRTEI{ 78,  // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo he_emlrtRTEI{ 82,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ie_emlrtRTEI{ 112, // lineNo
  27,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo je_emlrtRTEI{ 112, // lineNo
  23,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ke_emlrtRTEI{ 187, // lineNo
  10,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo le_emlrtRTEI{ 122, // lineNo
  28,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo me_emlrtRTEI{ 122, // lineNo
  44,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ne_emlrtRTEI{ 187, // lineNo
  6,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo oe_emlrtRTEI{ 174, // lineNo
  2,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo pe_emlrtRTEI{ 174, // lineNo
  4,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo qe_emlrtRTEI{ 177, // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo re_emlrtRTEI{ 99,  // lineNo
  1,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo se_emlrtRTEI{ 160, // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo te_emlrtRTEI{ 131, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ue_emlrtRTEI{ 132, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ve_emlrtRTEI{ 134, // lineNo
  10,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo we_emlrtRTEI{ 111, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo xe_emlrtRTEI{ 112, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ye_emlrtRTEI{ 44,  // lineNo
  9,                                   // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo af_emlrtRTEI{ 180, // lineNo
  8,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo bf_emlrtRTEI{ 18,  // lineNo
  5,                                   // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo cf_emlrtRTEI{ 88,  // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo df_emlrtRTEI{ 126, // lineNo
  9,                                   // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo ef_emlrtRTEI{ 130, // lineNo
  18,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ff_emlrtRTEI{ 128, // lineNo
  18,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo gf_emlrtRTEI{ 126, // lineNo
  55,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo hf_emlrtRTEI{ 130, // lineNo
  30,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo if_emlrtRTEI{ 134, // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo jf_emlrtRTEI{ 134, // lineNo
  29,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo kf_emlrtRTEI{ 135, // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo lf_emlrtRTEI{ 135, // lineNo
  37,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo mf_emlrtRTEI{ 135, // lineNo
  56,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo nf_emlrtRTEI{ 136, // lineNo
  27,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo of_emlrtRTEI{ 136, // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo pf_emlrtRTEI{ 151, // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

// Function Declarations
static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, int32_T in3, const emxArray_real32_T *in4, const emxArray_real32_T *in5);
static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, real32_T in4);
static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5, const emxArray_real32_T *in6);
static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4);
static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, int32_T in3, const emxArray_real32_T *in4);
static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5);
static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3);
static real32_T b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real32_T *ret);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, real32_T in3, const emxArray_real32_T *in4);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, real32_T in3);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, int32_T in3, const emxArray_real32_T *in4, const emxArray_real32_T *in5);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4, int32_T in5,
  real32_T in6);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, real32_T in4);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, int32_T in3, const emxArray_real32_T *in4);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_int32_T *in2,
  const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5, const emxArray_real32_T *in6, const emxArray_real32_T *
  in7);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_int32_T *in2,
  const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5, const emxArray_real32_T *in6);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_int32_T *in2,
  const emxArray_real32_T *in3, const emxArray_real32_T *in4);
static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static
#ifdef __CUDACC__

__device__
#endif

int64_T computeEndIdx_device(int64_T start, int64_T end, int64_T stride);
static __global__ void ec_detrend_kernel1(creal32_T *fc, creal32_T *fc2);
static __global__ void ec_detrend_kernel10(const emxArray_real32_T w, const
  real32_T out, const emxArray_real32_T x, int32_T b_x, emxArray_real32_T fv4);
static __global__ void ec_detrend_kernel100(const int32_T vlen, int32_T m,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel101(const real32_T start, real32_T stop,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel102(const emxArray_real32_T x, const
  emxArray_real32_T vec, int32_T b_vec, emxArray_real32_T fv2);
static __global__ void ec_detrend_kernel103(const emxArray_real32_T w, const
  emxArray_real32_T vec, int32_T b_vec, emxArray_real32_T fv3);
static __global__ void ec_detrend_kernel104(const real32_T d2scaled, int32_T
  *npages, emxArray_real32_T lin, int32_T lin_dim1);
static __global__ void ec_detrend_kernel105(emxArray_real32_T lin, int32_T
  lin_dim1);
static __global__ void ec_detrend_kernel106(const int32_T n, const
  emxArray_real32_T lin, int32_T nx, emxArray_real32_T fv5);
static __global__ void ec_detrend_kernel107(const emxArray_real32_T fv5, const
  int32_T vlen, int32_T x, emxArray_real32_T r, int32_T r_dim0);
static __global__ void ec_detrend_kernel108(const emxArray_real32_T fv3, const
  emxArray_real32_T fv2, int32_T b_fv2, emxArray_real32_T c);
static __global__ void ec_detrend_kernel109(const emxArray_real32_T fv3, const
  emxArray_real32_T fv2, int32_T b_fv2, emxArray_real32_T c);
static __global__ void ec_detrend_kernel11(const emxArray_real32_T w, const
  emxArray_real32_T r, const int32_T b_r, int32_T c_r, emxArray_real32_T c,
  int32_T c_dim0, int32_T r_dim0);
static __global__ void ec_detrend_kernel110(const emxArray_real32_T fv3, const
  real32_T d2scaled, const emxArray_real32_T fv2, int32_T b_fv2,
  emxArray_real32_T fv7);
static __global__ void ec_detrend_kernel111(const emxArray_real32_T fv3, const
  emxArray_real32_T r, const int32_T b_r, int32_T c_r, emxArray_real32_T c,
  int32_T c_dim0, int32_T r_dim0);
static __global__ void ec_detrend_kernel112(const int32_T vlen, const
  emxArray_real32_T c, int32_T *npages, emxArray_real32_T y, int32_T c_dim0);
static __global__ void ec_detrend_kernel113(int32_T sz, emxArray_real32_T y);
static __global__ void ec_detrend_kernel114(const real32_T d2scaled, const
  emxArray_real32_T y, const emxArray_real32_T r, const int32_T b_r, int32_T c_r,
  emxArray_real32_T d_r, int32_T r_dim0, int32_T b_r_dim0);
static __global__ void ec_detrend_kernel115(const emxArray_real32_T r, int32_T
  b_r, emxArray_real32_T c_r);
static __global__ void ec_detrend_kernel116(const emxArray_real32_T fv3, const
  emxArray_real32_T r, const int32_T b_r, int32_T c_r, emxArray_real32_T rr,
  int32_T rr_dim0, int32_T r_dim0);
static __global__ void ec_detrend_kernel117(const emxArray_real32_T rr, const
  int32_T b_rr, int32_T c_rr, emxArray_real32_T a, int32_T a_dim0, int32_T
  rr_dim0);
static __global__ void ec_detrend_kernel118(int32_T a, emxArray_real32_T A);
static __global__ void ec_detrend_kernel119(const emxArray_real32_T wimag, const
  emxArray_real32_T wreal, int32_T n, emxArray_creal32_T W);
static __global__ void ec_detrend_kernel12(const int32_T vlen, const
  emxArray_real32_T c, int32_T *npages, emxArray_real32_T y, int32_T c_dim0);
static __global__ void ec_detrend_kernel120(const emxArray_real32_T vright,
  int32_T b_vright, emxArray_creal32_T V);
static __global__ void ec_detrend_kernel121(const int32_T *npages, int32_T n,
  emxArray_creal32_T V, int32_T V_dim0);
static __global__ void ec_detrend_kernel122(const creal32_T *fc2, int32_T x,
  emxArray_creal32_T W);
static __global__ void ec_detrend_kernel123(const creal32_T *fc2, int32_T V,
  emxArray_creal32_T b_V);
static __global__ void ec_detrend_kernel124(int32_T A, emxArray_creal32_T D);
static __global__ void ec_detrend_kernel125(int32_T V, emxArray_real32_T A);
static __global__ void ec_detrend_kernel126(int32_T x, emxArray_real32_T tau);
static __global__ void ec_detrend_kernel127(const emxArray_real32_T A, int32_T
  b_A, emxArray_real32_T U);
static __global__ void ec_detrend_kernel128(int32_T V, emxArray_real32_T U);
static __global__ void ec_detrend_kernel129(int32_T V, emxArray_real32_T A);
static __global__ void ec_detrend_kernel13(int32_T sz, emxArray_real32_T y);
static __global__ void ec_detrend_kernel130(int32_T V, emxArray_real32_T U);
static __global__ void ec_detrend_kernel131(int32_T sz, emxArray_real32_T U);
static __global__ void ec_detrend_kernel132(const int32_T n, const int32_T
  *npages, int32_T m, emxArray_real32_T U, int32_T U_dim0);
static __global__ void ec_detrend_kernel133(int32_T sz, emxArray_real32_T A);
static __global__ void ec_detrend_kernel134(int32_T A, emxArray_creal32_T D);
static __global__ void ec_detrend_kernel135(const emxArray_real32_T U, int32_T
  b_U, emxArray_creal32_T V);
static __global__ void ec_detrend_kernel136(int32_T x, emxArray_real32_T W);
static __global__ void ec_detrend_kernel137(int32_T V, emxArray_real32_T A);
static __global__ void ec_detrend_kernel138(int32_T m, emxArray_creal32_T D);
static __global__ void ec_detrend_kernel139(const emxArray_real32_T A, int32_T
  b_A, emxArray_creal32_T V);
static __global__ void ec_detrend_kernel14(const real32_T d2scaled, const
  emxArray_real32_T y, const emxArray_real32_T r, const int32_T b_r, int32_T c_r,
  emxArray_real32_T fv6, int32_T fv6_dim0, int32_T r_dim0);
static __global__ void ec_detrend_kernel140(const creal32_T *fc, int32_T V,
  emxArray_creal32_T b_V);
static __global__ void ec_detrend_kernel141(int32_T V, emxArray_creal32_T D);
static __global__ void ec_detrend_kernel142(const emxArray_creal32_T V, int32_T
  b_V, emxArray_real32_T c_V);
static __global__ void ec_detrend_kernel143(const emxArray_creal32_T D, int32_T
  b_D, emxArray_real32_T fcnOutput);
static __global__ void ec_detrend_kernel144(const emxArray_real32_T fcnOutput,
  int32_T *npages, emxArray_real32_T D, int32_T fcnOutput_dim0);
static __global__ void ec_detrend_kernel145(const emxArray_int32_T iv2, const
  emxArray_real32_T V, const int32_T vlen, int32_T b_iv2, emxArray_real32_T b_V,
  int32_T V_dim0, int32_T b_V_dim0);
static __global__ void ec_detrend_kernel146(const emxArray_real32_T V, int32_T
  b_V, emxArray_real32_T c_V);
static __global__ void ec_detrend_kernel147(const emxArray_real32_T rr, int32_T
  b_rr, emxArray_real32_T A);
static __global__ void ec_detrend_kernel148(int32_T V, emxArray_real32_T rr);
static __global__ void ec_detrend_kernel149(const emxArray_real32_T fv7, int32_T
  b_fv7, emxArray_real32_T a);
static __global__ void ec_detrend_kernel15(const emxArray_real32_T w, const
  emxArray_real32_T fv6, const int32_T b_fv6, int32_T c_fv6, emxArray_real32_T
  rr, int32_T rr_dim0, int32_T fv6_dim0);
static __global__ void ec_detrend_kernel150(int32_T rr, emxArray_real32_T b);
static __global__ void ec_detrend_kernel151(const emxArray_real32_T rr, const
  int32_T b_rr, int32_T c_rr, emxArray_real32_T a, int32_T a_dim0, int32_T
  rr_dim0);
static __global__ void ec_detrend_kernel152(int32_T a, emxArray_real32_T A);
static __global__ void ec_detrend_kernel153(const emxArray_real32_T A, const
  int32_T b_A, int32_T c_A, emxArray_real32_T d_A, int32_T A_dim0, int32_T
  b_A_dim0);
static __global__ void ec_detrend_kernel154(const emxArray_real32_T b, int32_T
  b_b, emxArray_real32_T B);
static __global__ void ec_detrend_kernel155(int32_T A, emxArray_int32_T jpvt);
static __global__ void ec_detrend_kernel156(const int32_T m, int32_T na,
  emxArray_real32_T A, int32_T A_dim0);
static __global__ void ec_detrend_kernel157(int32_T vlen, emxArray_real32_T tau);
static __global__ void ec_detrend_kernel158(const int32_T *npages, int32_T nx,
  emxArray_real32_T tau);
static __global__ void ec_detrend_kernel159(int32_T na, emxArray_int32_T jpvt);
static __global__ void ec_detrend_kernel16(const emxArray_real32_T rr, const
  int32_T b_rr, int32_T c_rr, emxArray_real32_T a, int32_T a_dim0, int32_T
  rr_dim0);
static __global__ void ec_detrend_kernel160(int32_T *npages, emxArray_real32_T Y);
static __global__ void ec_detrend_kernel161(int32_T x, emxArray_real32_T B);
static __global__ void ec_detrend_kernel162(const emxArray_real32_T B, const
  emxArray_int32_T jpvt, int32_T nx, emxArray_real32_T Y);
static __global__ void ec_detrend_kernel163(const emxArray_real32_T Y, int32_T
  b_Y, emxArray_real32_T b);
static __global__ void ec_detrend_kernel164(const emxArray_int32_T ipiv_t,
  int32_T *npages, emxArray_int32_T ipiv);
static __global__ void ec_detrend_kernel165(int32_T V, emxArray_real32_T A);
static __global__ void ec_detrend_kernel166(int32_T *npages, emxArray_int32_T
  ipiv);
static __global__ void ec_detrend_kernel167(int32_T sz, emxArray_real32_T b);
static __global__ void ec_detrend_kernel168(const emxArray_real32_T b, int32_T
  b_b, emxArray_real32_T c_b);
static __global__ void ec_detrend_kernel169(int32_T V, emxArray_real32_T c);
static __global__ void ec_detrend_kernel17(int32_T a, emxArray_real32_T A);
static __global__ void ec_detrend_kernel170(int32_T r, emxArray_real32_T fv9);
static __global__ void ec_detrend_kernel171(const real32_T out, const
  emxArray_real32_T fv2, const emxArray_real32_T fv9, int32_T b_fv9,
  emxArray_real32_T z);
static __global__ void ec_detrend_kernel172(const emxArray_real32_T fv3, const
  emxArray_real32_T z, const emxArray_real32_T fv2, int32_T *npages,
  emxArray_real32_T c);
static __global__ void ec_detrend_kernel173(const emxArray_real32_T fv3, const
  emxArray_real32_T z, const emxArray_real32_T fv2, int32_T *npages,
  emxArray_real32_T d);
static __global__ void ec_detrend_kernel174(const real32_T d2scaled, const
  emxArray_real32_T c, int32_T m, emxArray_real32_T absdiff);
static __global__ void ec_detrend_kernel175(const emxArray_real32_T z, const
  emxArray_real32_T fv2, int32_T *npages, emxArray_real32_T yy);
static __global__ void ec_detrend_kernel176(int32_T m, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel177(real32_T d2scaled, emxArray_real32_T
  vec);
static __global__ void ec_detrend_kernel178(const real32_T d2scaled, const
  real_T ndbl, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel179(const real32_T d2scaled, const
  int32_T m, const real32_T abnrm, int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel18(const emxArray_real32_T wimag, const
  emxArray_real32_T wreal, int32_T n, emxArray_creal32_T W);
static __global__ void ec_detrend_kernel180(const real32_T abnrm, const int32_T *
  npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel181(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel182(const real32_T d2scaled, const
  real32_T abnrm, const int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel183(const int32_T vlen,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel184(const real32_T abnrm,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel185(const emxArray_real32_T vec, int32_T
  *npages, emxArray_real32_T b);
static __global__ void ec_detrend_kernel186(int32_T m, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel187(real32_T d2scaled, emxArray_real32_T
  vec);
static __global__ void ec_detrend_kernel188(const emxArray_real32_T vec, int32_T
  *npages, emxArray_real32_T b);
static __global__ void ec_detrend_kernel189(const real32_T d2scaled, const
  real_T ndbl, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel19(const emxArray_real32_T vright,
  int32_T b_vright, emxArray_creal32_T V);
static __global__ void ec_detrend_kernel190(const real32_T d2scaled, const
  int32_T m, const real32_T abnrm, int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel191(const real32_T abnrm, const int32_T *
  npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel192(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel193(const real32_T d2scaled, const
  real32_T abnrm, const int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel194(const int32_T vlen,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel195(const real32_T abnrm,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel196(const real32_T out, int32_T *npages,
  emxArray_real32_T b);
static __global__ void ec_detrend_kernel197(const real32_T d2scaled, const
  int32_T m, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel198(const real32_T d2scaled, const
  int32_T m, const real32_T start, int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel199(const real32_T start, const int32_T *
  npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel2(const emxArray_real32_T w, const
  int32_T ch, const emxArray_real32_T x, int32_T b_x, emxArray_real32_T b_w,
  emxArray_real32_T c_x, emxArray_real32_T d_x, int32_T x_dim0, int32_T w_dim0);
static __global__ void ec_detrend_kernel20(const int32_T *npages, int32_T n,
  emxArray_creal32_T V, int32_T V_dim0);
static __global__ void ec_detrend_kernel200(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel201(const real32_T d2scaled, const
  real32_T start, const int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel202(const int32_T vlen, int32_T m,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel203(const real32_T start, real32_T stop,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel204(const emxArray_real32_T vec, int32_T
  b_vec, emxArray_int32_T iv6);
static __global__ void ec_detrend_kernel205(const real32_T d2scaled, const
  int32_T m, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel206(const real32_T d2scaled, const
  int32_T m, const real32_T start, int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel207(const real32_T start, const int32_T *
  npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel208(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel209(const real32_T d2scaled, const
  real32_T start, const int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel21(const creal32_T *fc2, int32_T x,
  emxArray_creal32_T W);
static __global__ void ec_detrend_kernel210(const int32_T vlen, int32_T m,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel211(const real32_T start, real32_T stop,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel212(const emxArray_real32_T x, const
  emxArray_real32_T vec, int32_T b_vec, emxArray_real32_T a);
static __global__ void ec_detrend_kernel213(const emxArray_real32_T b, const
  emxArray_real32_T yy, const emxArray_real32_T a, const emxArray_int32_T iv6,
  int32_T b_a, emxArray_real32_T x);
static __global__ void ec_detrend_kernel214(const real32_T d2scaled, const
  int32_T m, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel215(const real32_T d2scaled, const
  int32_T m, const real32_T start, int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel216(const real32_T start, const int32_T *
  npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel217(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel218(const real32_T d2scaled, const
  real32_T start, const int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel219(const int32_T vlen, int32_T m,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel22(const creal32_T *fc2, int32_T V,
  emxArray_creal32_T b_V);
static __global__ void ec_detrend_kernel220(const real32_T start, real32_T stop,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel221(const emxArray_real32_T vec, int32_T
  b_vec, emxArray_int32_T iv7);
static __global__ void ec_detrend_kernel222(const real32_T d2scaled, const
  int32_T m, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel223(const real32_T d2scaled, const
  int32_T m, const real32_T start, int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel224(const real32_T start, const int32_T *
  npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel225(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel226(const real32_T d2scaled, const
  real32_T start, const int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel227(const int32_T vlen, int32_T m,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel228(const real32_T start, real32_T stop,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel229(const real32_T d2scaled, const
  int32_T m, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel23(int32_T A, emxArray_creal32_T D);
static __global__ void ec_detrend_kernel230(const real32_T d2scaled, const
  int32_T m, const real32_T start, int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel231(const real32_T start, const int32_T *
  npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel232(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel233(const real32_T d2scaled, const
  real32_T start, const int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel234(const int32_T vlen, int32_T m,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel235(const real32_T start, real32_T stop,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel236(const emxArray_real32_T x, const
  emxArray_real32_T vec, int32_T b_vec, emxArray_real32_T fv10);
static __global__ void ec_detrend_kernel237(const emxArray_real32_T trend, const
  emxArray_real32_T vec, int32_T b_vec, emxArray_real32_T a);
static __global__ void ec_detrend_kernel238(const emxArray_real32_T b, const
  emxArray_real32_T yy, const emxArray_real32_T fv10, const emxArray_real32_T a,
  const emxArray_int32_T iv7, int32_T b_a, emxArray_real32_T trend);
static __global__ void ec_detrend_kernel239(const real32_T d2scaled, const
  int32_T m, emxArray_real32_T fv11);
static __global__ void ec_detrend_kernel24(int32_T V, emxArray_real32_T A);
static __global__ void ec_detrend_kernel240(const real32_T d2scaled, const
  int32_T m, const real32_T start, int32_T *npages, emxArray_real32_T fv11);
static __global__ void ec_detrend_kernel241(const real32_T start, const int32_T *
  npages, emxArray_real32_T fv11);
static __global__ void ec_detrend_kernel242(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T fv11);
static __global__ void ec_detrend_kernel243(const real32_T d2scaled, const
  real32_T start, const int32_T *npages, emxArray_real32_T fv11);
static __global__ void ec_detrend_kernel244(const int32_T vlen, int32_T m,
  emxArray_real32_T fv11);
static __global__ void ec_detrend_kernel245(const real32_T start, real32_T stop,
  emxArray_real32_T fv11);
static __global__ void ec_detrend_kernel246(const real32_T d2scaled, const
  int32_T m, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel247(const real32_T d2scaled, const
  int32_T m, const real32_T start, int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel248(const real32_T start, const int32_T *
  npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel249(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel25(int32_T x, emxArray_real32_T tau);
static __global__ void ec_detrend_kernel250(const real32_T d2scaled, const
  real32_T start, const int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel251(const int32_T vlen, int32_T m,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel252(const real32_T start, real32_T stop,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel253(const emxArray_real32_T vec, int32_T
  b_vec, emxArray_int32_T iv8);
static __global__ void ec_detrend_kernel254(const emxArray_real32_T b, const
  emxArray_real32_T a, const emxArray_real32_T fv11, int32_T b_fv11,
  emxArray_real32_T b_a);
static __global__ void ec_detrend_kernel255(const emxArray_real32_T a, const
  emxArray_int32_T iv8, int32_T b_a, emxArray_real32_T c_a);
static __global__ void ec_detrend_kernel256(emxArray_real32_T a, int32_T a_dim0);
static __global__ void ec_detrend_kernel257(const emxArray_real32_T a, int32_T
  b_a, emxArray_real32_T fv12);
static __global__ void ec_detrend_kernel258(const emxArray_real32_T fv12, const
  emxArray_real32_T x, int32_T b_x, emxArray_real32_T c);
static __global__ void ec_detrend_kernel259(const emxArray_real32_T fv12, const
  emxArray_real32_T x, int32_T b_x, emxArray_real32_T c_x);
static __global__ void ec_detrend_kernel26(const emxArray_real32_T A, int32_T
  b_A, emxArray_real32_T U);
static __global__ void ec_detrend_kernel260(const emxArray_real32_T x, int32_T
  b_x, emxArray_real32_T c_x);
static __global__ void ec_detrend_kernel261(int32_T n, emxArray_real32_T x);
static __global__ void ec_detrend_kernel262(const emxArray_real32_T a, int32_T
  b_a, emxArray_real32_T fv13);
static __global__ void ec_detrend_kernel263(const emxArray_real32_T fv13, const
  emxArray_real32_T trend, int32_T b_trend, emxArray_real32_T c);
static __global__ void ec_detrend_kernel264(const emxArray_real32_T fv13, const
  emxArray_real32_T trend, int32_T b_trend, emxArray_real32_T c_trend);
static __global__ void ec_detrend_kernel265(const emxArray_real32_T trend,
  int32_T b_trend, emxArray_real32_T c_trend);
static __global__ void ec_detrend_kernel266(int32_T n, emxArray_real32_T trend);
static __global__ void ec_detrend_kernel267(const emxArray_real32_T w, const
  emxArray_real32_T trend, const emxArray_real32_T x, int32_T V,
  emxArray_real32_T c);
static __global__ void ec_detrend_kernel268(const emxArray_real32_T w, const
  emxArray_real32_T trend, const emxArray_real32_T x, int32_T V,
  emxArray_real32_T d);
static __global__ void ec_detrend_kernel269(const real32_T d2scaled, const
  emxArray_real32_T c, int32_T m, emxArray_real32_T absdiff);
static __global__ void ec_detrend_kernel27(int32_T V, emxArray_real32_T U);
static __global__ void ec_detrend_kernel270(const emxArray_real32_T d, int32_T
  nx, emxArray_real32_T y);
static __global__ void ec_detrend_kernel271(const real32_T y_data_dim0, const
  real32_T thr, const emxArray_real32_T y, int32_T b_y, emxArray_boolean_T r1);
static __global__ void ec_detrend_kernel272(const emxArray_boolean_T r1, int32_T
  n, emxArray_real32_T w);
static __global__ void ec_detrend_kernel273(const emxArray_real32_T x, const
  int32_T ch, int32_T b_x, emxArray_real32_T c_x, int32_T x_dim0);
static __global__ void ec_detrend_kernel274(const emxArray_real32_T w, const
  int32_T ch, int32_T b_w, emxArray_real32_T c_w, int32_T w_dim0);
static __global__ void ec_detrend_kernel28(int32_T V, emxArray_real32_T A);
static __global__ void ec_detrend_kernel29(int32_T V, emxArray_real32_T U);
static __global__ void ec_detrend_kernel3(int32_T w, emxArray_real32_T b_w);
static __global__ void ec_detrend_kernel30(int32_T sz, emxArray_real32_T U);
static __global__ void ec_detrend_kernel31(const int32_T n, const int32_T
  *npages, int32_T m, emxArray_real32_T U, int32_T U_dim0);
static __global__ void ec_detrend_kernel32(int32_T sz, emxArray_real32_T A);
static __global__ void ec_detrend_kernel33(int32_T A, emxArray_creal32_T D);
static __global__ void ec_detrend_kernel34(const emxArray_real32_T U, int32_T
  b_U, emxArray_creal32_T V);
static __global__ void ec_detrend_kernel35(int32_T x, emxArray_real32_T W);
static __global__ void ec_detrend_kernel36(int32_T V, emxArray_real32_T A);
static __global__ void ec_detrend_kernel37(int32_T m, emxArray_creal32_T D);
static __global__ void ec_detrend_kernel38(const emxArray_real32_T A, int32_T
  b_A, emxArray_creal32_T V);
static __global__ void ec_detrend_kernel39(const creal32_T *fc, int32_T V,
  emxArray_creal32_T b_V);
static __global__ void ec_detrend_kernel4(const real32_T d2scaled, int32_T
  *npages, emxArray_real32_T lin, int32_T lin_dim1);
static __global__ void ec_detrend_kernel40(int32_T V, emxArray_creal32_T D);
static __global__ void ec_detrend_kernel41(const emxArray_creal32_T V, int32_T
  b_V, emxArray_real32_T c_V);
static __global__ void ec_detrend_kernel42(const emxArray_creal32_T D, int32_T
  b_D, emxArray_real32_T fcnOutput);
static __global__ void ec_detrend_kernel43(const emxArray_real32_T fcnOutput,
  int32_T *npages, emxArray_real32_T D, int32_T fcnOutput_dim0);
static __global__ void ec_detrend_kernel44(const emxArray_int32_T iv, const
  emxArray_real32_T V, const int32_T vlen, int32_T b_iv, emxArray_real32_T b_V,
  int32_T V_dim0, int32_T b_V_dim0);
static __global__ void ec_detrend_kernel45(const emxArray_real32_T V, int32_T
  b_V, emxArray_real32_T c_V);
static __global__ void ec_detrend_kernel46(const emxArray_real32_T rr, int32_T
  b_rr, emxArray_real32_T A);
static __global__ void ec_detrend_kernel47(int32_T V, emxArray_real32_T rr);
static __global__ void ec_detrend_kernel48(const emxArray_real32_T fv4, int32_T
  b_fv4, emxArray_real32_T a);
static __global__ void ec_detrend_kernel49(int32_T rr, emxArray_real32_T b);
static __global__ void ec_detrend_kernel5(emxArray_real32_T lin, int32_T
  lin_dim1);
static __global__ void ec_detrend_kernel50(const emxArray_real32_T rr, const
  int32_T b_rr, int32_T c_rr, emxArray_real32_T a, int32_T a_dim0, int32_T
  rr_dim0);
static __global__ void ec_detrend_kernel51(int32_T a, emxArray_real32_T A);
static __global__ void ec_detrend_kernel52(const emxArray_real32_T A, const
  int32_T b_A, int32_T c_A, emxArray_real32_T d_A, int32_T A_dim0, int32_T
  b_A_dim0);
static __global__ void ec_detrend_kernel53(const emxArray_real32_T b, int32_T
  b_b, emxArray_real32_T B);
static __global__ void ec_detrend_kernel54(int32_T A, emxArray_int32_T jpvt);
static __global__ void ec_detrend_kernel55(const int32_T m, int32_T na,
  emxArray_real32_T A, int32_T A_dim0);
static __global__ void ec_detrend_kernel56(int32_T vlen, emxArray_real32_T tau);
static __global__ void ec_detrend_kernel57(const int32_T *npages, int32_T nx,
  emxArray_real32_T tau);
static __global__ void ec_detrend_kernel58(int32_T na, emxArray_int32_T jpvt);
static __global__ void ec_detrend_kernel59(int32_T *npages, emxArray_real32_T Y);
static __global__ void ec_detrend_kernel6(const int32_T n, const
  emxArray_real32_T lin, int32_T nx, emxArray_real32_T fv);
static __global__ void ec_detrend_kernel60(int32_T x, emxArray_real32_T B);
static __global__ void ec_detrend_kernel61(const emxArray_real32_T B, const
  emxArray_int32_T jpvt, int32_T nx, emxArray_real32_T Y);
static __global__ void ec_detrend_kernel62(const emxArray_real32_T Y, int32_T
  b_Y, emxArray_real32_T b);
static __global__ void ec_detrend_kernel63(const emxArray_int32_T ipiv_t,
  int32_T *npages, emxArray_int32_T ipiv);
static __global__ void ec_detrend_kernel64(int32_T V, emxArray_real32_T A);
static __global__ void ec_detrend_kernel65(int32_T *npages, emxArray_int32_T
  ipiv);
static __global__ void ec_detrend_kernel66(int32_T sz, emxArray_real32_T b);
static __global__ void ec_detrend_kernel67(const emxArray_real32_T b, int32_T
  b_b, emxArray_real32_T c_b);
static __global__ void ec_detrend_kernel68(int32_T V, emxArray_real32_T c);
static __global__ void ec_detrend_kernel69(int32_T fv6, emxArray_real32_T fv8);
static __global__ void ec_detrend_kernel7(const emxArray_real32_T fv, const
  int32_T vlen, int32_T x, emxArray_real32_T r, int32_T r_dim0);
static __global__ void ec_detrend_kernel70(const real32_T out, const
  emxArray_real32_T x, const emxArray_real32_T b_x, const emxArray_real32_T fv8,
  int32_T b_fv8, emxArray_real32_T z);
static __global__ void ec_detrend_kernel71(const emxArray_real32_T z, int32_T
  b_z, emxArray_real32_T c_z);
static __global__ void ec_detrend_kernel72(const emxArray_real32_T w, const
  emxArray_real32_T z, const emxArray_real32_T x, int32_T V, emxArray_real32_T c);
static __global__ void ec_detrend_kernel73(const emxArray_real32_T w, const
  emxArray_real32_T z, const emxArray_real32_T x, int32_T V, emxArray_real32_T d);
static __global__ void ec_detrend_kernel74(const real32_T d2scaled, const
  emxArray_real32_T c, int32_T m, emxArray_real32_T absdiff);
static __global__ void ec_detrend_kernel75(const emxArray_real32_T d, int32_T nx,
  emxArray_real32_T y);
static __global__ void ec_detrend_kernel76(const real32_T y_data_dim0, const
  real32_T thr, const emxArray_real32_T y, int32_T b_y, emxArray_boolean_T r);
static __global__ void ec_detrend_kernel77(const emxArray_boolean_T r, int32_T n,
  emxArray_real32_T w);
static __global__ void ec_detrend_kernel78(const emxArray_real32_T z, const
  int32_T ch, const emxArray_real32_T x, int32_T V, emxArray_real32_T b_x,
  int32_T x_dim0);
static __global__ void ec_detrend_kernel79(real32_T dims_idx_0,
  emxArray_real32_T a, emxArray_real32_T trend);
static __global__ void ec_detrend_kernel8(const emxArray_real32_T w, const
  emxArray_real32_T x, int32_T b_x, emxArray_real32_T c);
static __global__ void ec_detrend_kernel80(const real32_T d2scaled, const
  int32_T m, emxArray_real32_T fv1);
static __global__ void ec_detrend_kernel81(const real32_T d2scaled, const
  int32_T m, const real32_T start, int32_T *npages, emxArray_real32_T fv1);
static __global__ void ec_detrend_kernel82(const real32_T start, const int32_T
  *npages, emxArray_real32_T fv1);
static __global__ void ec_detrend_kernel83(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T fv1);
static __global__ void ec_detrend_kernel84(const real32_T d2scaled, const
  real32_T start, const int32_T *npages, emxArray_real32_T fv1);
static __global__ void ec_detrend_kernel85(const int32_T vlen, int32_T m,
  emxArray_real32_T fv1);
static __global__ void ec_detrend_kernel86(const real32_T start, real32_T stop,
  emxArray_real32_T fv1);
static __global__ void ec_detrend_kernel87(const emxArray_real32_T w, const
  emxArray_real32_T fv1, int32_T nx, emxArray_real32_T minval);
static __global__ void ec_detrend_kernel88(const real32_T d2scaled, const
  int32_T m, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel89(const real32_T d2scaled, const
  int32_T m, const real32_T start, int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel9(const emxArray_real32_T w, const
  emxArray_real32_T x, int32_T b_x, emxArray_real32_T c);
static __global__ void ec_detrend_kernel90(const real32_T start, const int32_T
  *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel91(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel92(const real32_T d2scaled, const
  real32_T start, const int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel93(const int32_T vlen, int32_T m,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel94(const real32_T start, real32_T stop,
  emxArray_real32_T vec);
static __global__ void ec_detrend_kernel95(const real32_T d2scaled, const
  int32_T m, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel96(const real32_T d2scaled, const
  int32_T m, const real32_T start, int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel97(const real32_T start, const int32_T
  *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel98(const real32_T d2scaled, const
  int32_T *npages, emxArray_real32_T vec);
static __global__ void ec_detrend_kernel99(const real32_T d2scaled, const
  real32_T start, const int32_T *npages, emxArray_real32_T vec);
static void ec_detrend_once();
static real32_T emlrt_marshallIn(const mxArray *order, const char_T *identifier);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y);
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real32_T *y);
static real32_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u);
static void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_creal32_T(emxArray_creal32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_ptrdiff_t(emxArray_ptrdiff_t *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxFree_boolean_T(emxArray_boolean_T **pEmxArray);
static void emxFree_creal32_T(emxArray_creal32_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray);
static void emxFree_real32_T(emxArray_real32_T **pEmxArray);
static void emxInit_boolean_T(emxArray_boolean_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_creal32_T(emxArray_creal32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void gpuEmxEnsureCapacity_boolean_T(const emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu);
static void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
  emxArray_creal32_T *gpu);
static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu);
static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
  emxArray_real32_T *gpu);
static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
static void gpuEmxFree_real32_T(emxArray_real32_T *gpu);
static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu, const
  emxArray_creal32_T *cpu);
static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu, const
  emxArray_int32_T *cpu);
static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu, const
  emxArray_real32_T *cpu);
static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
  emxArray_creal32_T *gpu);
static void gpuEmxMemcpyGpuToCpu_int32_T(emxArray_int32_T *cpu, emxArray_int32_T
  *gpu);
static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
  emxArray_real32_T *gpu);
static void gpuEmxReset_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxReset_creal32_T(emxArray_creal32_T *gpu);
static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);
static void gpuEmxReset_real32_T(emxArray_real32_T *gpu);
static real32_T rt_remf_snf(real32_T u0, real32_T u1);
static void times(emxArray_real32_T *in1, const emxArray_real32_T *in2, const
                  emxArray_real32_T *in3);

// Function Definitions
static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T in5_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  in3_idx_0 = in3->size[0];
  in5_idx_0 = in5->size[0];
  i = in1->size[0] * in1->size[1];
  if (in5_idx_0 == 1) {
    if (in4->size[0] == 1) {
      in1->size[0] = in3_idx_0;
    } else {
      in1->size[0] = in4->size[0];
    }
  } else {
    in1->size[0] = in5_idx_0;
  }

  in1->size[1] = 1;
  emxEnsureCapacity_real32_T(in1, i, &ae_emlrtRTEI);
  stride_0_0 = (in3_idx_0 != 1);
  stride_1_0 = (in4->size[0] != 1);
  stride_2_0 = (in5_idx_0 != 1);
  if (in5_idx_0 == 1) {
    if (in4->size[0] == 1) {
      in5_idx_0 = in3_idx_0;
    } else {
      in5_idx_0 = in4->size[0];
    }
  }

  for (i = 0; i < in5_idx_0; i++) {
    in1->data[i] = (in2->data[i * stride_0_0] - in4->data[i * stride_1_0]) *
      in5->data[i * stride_2_0];
  }
}

static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5, const emxArray_real32_T *in6)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T in4_idx_0;
  int32_T in6_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  in3_idx_0 = in3->size[1];
  in4_idx_0 = in4->size[0];
  in6_idx_0 = in6->size[1];
  i = in1->size[0] * in1->size[1];
  if (in6_idx_0 == 1) {
    if (in4_idx_0 == 1) {
      in1->size[0] = in3_idx_0;
    } else {
      in1->size[0] = in4_idx_0;
    }
  } else {
    in1->size[0] = in6_idx_0;
  }

  in1->size[1] = 1;
  emxEnsureCapacity_real32_T(in1, i, &m_emlrtRTEI);
  stride_0_0 = (in3_idx_0 != 1);
  stride_1_0 = (in4_idx_0 != 1);
  stride_2_0 = (in6_idx_0 != 1);
  if (in6_idx_0 == 1) {
    if (in4_idx_0 == 1) {
      in6_idx_0 = in3_idx_0;
    } else {
      in6_idx_0 = in4_idx_0;
    }
  }

  for (i = 0; i < in6_idx_0; i++) {
    in1->data[i] = (in2->data[i * stride_0_0] - in4->data[i * stride_1_0]) *
      in5->data[i * stride_2_0];
  }
}

static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, int32_T in3, const emxArray_real32_T *in4, const emxArray_real32_T *in5)
{
  int32_T i;
  int32_T in5_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  in5_idx_0 = in5->size[0];
  i = in1->size[0] * in1->size[1];
  if (in5_idx_0 == 1) {
    if (in4->size[0] == 1) {
      in1->size[0] = in3;
    } else {
      in1->size[0] = in4->size[0];
    }
  } else {
    in1->size[0] = in5_idx_0;
  }

  in1->size[1] = 1;
  emxEnsureCapacity_real32_T(in1, i, &m_emlrtRTEI);
  stride_0_0 = (in3 != 1);
  stride_1_0 = (in4->size[0] != 1);
  stride_2_0 = (in5_idx_0 != 1);
  if (in5_idx_0 == 1) {
    if (in4->size[0] == 1) {
      in5_idx_0 = in3;
    } else {
      in5_idx_0 = in4->size[0];
    }
  }

  for (i = 0; i < in5_idx_0; i++) {
    in1->data[i] = (in2->data[i * stride_0_0] - in4->data[i * stride_1_0]) *
      in5->data[i * stride_2_0];
  }
}

static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, int32_T in3, const emxArray_real32_T *in4)
{
  int32_T i;
  int32_T in2_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in2_idx_0 = in2->size[0];
  i = in1->size[0] * in1->size[1];
  if (in4->size[0] == 1) {
    in1->size[0] = in2_idx_0;
  } else {
    in1->size[0] = in4->size[0];
  }

  in1->size[1] = 1;
  emxEnsureCapacity_real32_T(in1, i, &l_emlrtRTEI);
  stride_0_0 = (in2_idx_0 != 1);
  stride_1_0 = (in4->size[0] != 1);
  if (in4->size[0] != 1) {
    in2_idx_0 = in4->size[0];
  }

  for (i = 0; i < in2_idx_0; i++) {
    in1->data[i] = in2->data[i * stride_0_0 + in2->size[0] * in3] - in4->data[i *
      stride_1_0];
  }
}

static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, real32_T in4)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in3->size[0] == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3->size[0];
  }

  emxEnsureCapacity_real32_T(in1, i, &cd_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in3->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[i * stride_0_0] + (in3->data[i * stride_1_0] -
      (in3->data[i * stride_1_0] - in4));
  }
}

static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in3_idx_0 = in3->size[0];
  i = in1->size[0] * in1->size[1];
  if (in3_idx_0 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3_idx_0;
  }

  in1->size[1] = 1;
  emxEnsureCapacity_real32_T(in1, i, &m_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3_idx_0 != 1);
  if (in3_idx_0 == 1) {
    in3_idx_0 = in2->size[0];
  }

  for (i = 0; i < in3_idx_0; i++) {
    in1->data[i] = in2->data[i * stride_0_0] * in3->data[i * stride_1_0];
  }
}

static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4)
{
  int32_T i;
  int32_T in4_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in4_idx_0 = in4->size[1];
  i = in1->size[0] * in1->size[1];
  if (in4_idx_0 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in4_idx_0;
  }

  in1->size[1] = in2->size[1];
  emxEnsureCapacity_real32_T(in1, i, &v_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in4_idx_0 != 1);
  for (i = 0; i < in2->size[1]; i++) {
    int32_T b;
    if (in4_idx_0 == 1) {
      b = in2->size[0];
    } else {
      b = in4_idx_0;
    }

    for (int32_T i1{0}; i1 < b; i1++) {
      in1->data[i1 + in1->size[0] * i] = in2->data[i1 * stride_0_0 + in2->size[0]
        * i] * in3->data[i1 * stride_1_0];
    }
  }
}

static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real32_T *ret)
{
  static const int32_T dims[2]{ -1, 999 };

  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{ true, true };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single|double",
    false, 2U, (const void *)&dims[0], &bv[0], &iv[0]);
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real32_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, &ret->data[0], 4, false);
  emlrtDestroyArray(&src);
}

static real32_T b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId)
{
  static const int32_T dims{ 0 };

  real32_T ret;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single|double", false,
    0U, (const void *)&dims);
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, &ret, 4, false);
  emlrtDestroyArray(&src);
  return ret;
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, int32_T in3, const emxArray_real32_T *in4)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in4->size[0] == 1) {
    in1->size[0] = in3;
  } else {
    in1->size[0] = in4->size[0];
  }

  emxEnsureCapacity_real32_T(in1, i, &m_emlrtRTEI);
  stride_0_0 = (in3 != 1);
  stride_1_0 = (in4->size[0] != 1);
  if (in4->size[0] == 1) {
    b = in3;
  } else {
    b = in4->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[i * stride_0_0] * in4->data[i * stride_1_0];
  }
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_int32_T *in2,
  const emxArray_real32_T *in3, const emxArray_real32_T *in4)
{
  emxArray_real32_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real32_T(&b_in1, 1, &lc_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in4->size[0] == 1) {
    b_in1->size[0] = in3->size[1];
  } else {
    b_in1->size[0] = in4->size[0];
  }

  emxEnsureCapacity_real32_T(b_in1, i, &lc_emlrtRTEI);
  stride_0_0 = (in3->size[1] != 1);
  stride_1_0 = (in4->size[0] != 1);
  if (in4->size[0] == 1) {
    b = in3->size[1];
  } else {
    b = in4->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[static_cast<int32_T>(in3->data[i * stride_0_0]) -
      1] + in4->data[i * stride_1_0];
  }

  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[in2->data[i]] = b_in1->data[i];
  }

  emxFree_real32_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, real32_T in4)
{
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = in2->size[0];
  if (in3->size[1] == 1) {
    in1->size[1] = in2->size[1];
  } else {
    in1->size[1] = in3->size[1];
  }

  emxEnsureCapacity_real32_T(in1, i, &u_emlrtRTEI);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_1 = (in3->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (in3->size[1] == 1) {
    b = in2->size[1];
  } else {
    b = in3->size[1];
  }

  for (i = 0; i < b; i++) {
    for (int32_T i1{0}; i1 < in2->size[0]; i1++) {
      in1->data[i1 + in1->size[0] * i] = in2->data[i1 + in2->size[0] * aux_0_1]
        - in3->data[aux_1_1] / (in4 + 2.22044605E-16F);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in3_idx_0 = in3->size[0];
  i = in1->size[0] * in1->size[1];
  if (in3_idx_0 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3_idx_0;
  }

  in1->size[1] = in2->size[1];
  emxEnsureCapacity_real32_T(in1, i, &v_emlrtRTEI);
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
        * i] * in3->data[i1 * stride_1_0];
    }
  }
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5, const emxArray_real32_T *in6)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T in4_idx_0;
  int32_T in6_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  in3_idx_0 = in3->size[1];
  in4_idx_0 = in4->size[0];
  in6_idx_0 = in6->size[1];
  i = in1->size[0] * in1->size[1];
  if (in6_idx_0 == 1) {
    if (in4_idx_0 == 1) {
      in1->size[0] = in3_idx_0;
    } else {
      in1->size[0] = in4_idx_0;
    }
  } else {
    in1->size[0] = in6_idx_0;
  }

  in1->size[1] = 1;
  emxEnsureCapacity_real32_T(in1, i, &fd_emlrtRTEI);
  stride_0_0 = (in3_idx_0 != 1);
  stride_1_0 = (in4_idx_0 != 1);
  stride_2_0 = (in6_idx_0 != 1);
  if (in6_idx_0 == 1) {
    if (in4_idx_0 == 1) {
      in6_idx_0 = in3_idx_0;
    } else {
      in6_idx_0 = in4_idx_0;
    }
  }

  for (i = 0; i < in6_idx_0; i++) {
    in1->data[i] = (in2->data[i * stride_0_0] - in4->data[i * stride_1_0]) *
      in5->data[i * stride_2_0];
  }
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T in4_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in3_idx_0 = in3->size[1];
  in4_idx_0 = in4->size[0];
  i = in1->size[0] * in1->size[1];
  if (in4_idx_0 == 1) {
    in1->size[0] = in3_idx_0;
  } else {
    in1->size[0] = in4_idx_0;
  }

  in1->size[1] = 1;
  emxEnsureCapacity_real32_T(in1, i, &kd_emlrtRTEI);
  stride_0_0 = (in3_idx_0 != 1);
  stride_1_0 = (in4_idx_0 != 1);
  if (in4_idx_0 == 1) {
    in4_idx_0 = in3_idx_0;
  }

  for (i = 0; i < in4_idx_0; i++) {
    in1->data[i] = in2->data[i * stride_0_0] - in4->data[i * stride_1_0];
  }
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_int32_T *in2,
  const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5, const emxArray_real32_T *in6, const emxArray_real32_T *
  in7)
{
  int32_T b;
  int32_T in5_idx_0;
  int32_T in7_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  int32_T stride_3_0;
  in5_idx_0 = in5->size[1];
  in7_idx_0 = in7->size[0];
  stride_0_0 = (in3->size[0] != 1);
  stride_1_0 = (in5_idx_0 != 1);
  stride_2_0 = (in6->size[0] != 1);
  stride_3_0 = (in7_idx_0 != 1);
  if (in7_idx_0 == 1) {
    if (in6->size[0] == 1) {
      b = in5_idx_0;
    } else {
      b = in6->size[0];
    }
  } else {
    b = in7_idx_0;
  }

  if (b == 1) {
    in7_idx_0 = in3->size[0];
  } else if (in7_idx_0 == 1) {
    if (in6->size[0] == 1) {
      in7_idx_0 = in5_idx_0;
    } else {
      in7_idx_0 = in6->size[0];
    }
  }

  for (in5_idx_0 = 0; in5_idx_0 < in7_idx_0; in5_idx_0++) {
    in1->data[in2->data[in5_idx_0]] = in3->data[in5_idx_0 * stride_0_0] +
      (in4->data[in5_idx_0 * stride_1_0] - in6->data[in5_idx_0 * stride_2_0]) *
      in7->data[in5_idx_0 * stride_3_0];
  }
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_int32_T *in2,
  const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5)
{
  int32_T i;
  int32_T in5_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  in5_idx_0 = in5->size[0];
  stride_0_0 = (in3->size[0] != 1);
  stride_1_0 = (in4->size[0] != 1);
  stride_2_0 = (in5_idx_0 != 1);
  if (in5_idx_0 == 1) {
    i = in4->size[0];
  } else {
    i = in5_idx_0;
  }

  if (i == 1) {
    in5_idx_0 = in3->size[0];
  } else if (in5_idx_0 == 1) {
    in5_idx_0 = in4->size[0];
  }

  for (i = 0; i < in5_idx_0; i++) {
    in1->data[in2->data[i]] = in3->data[i * stride_0_0] + in4->data[i *
      stride_1_0] * in5->data[i * stride_2_0];
  }
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, real32_T in3)
{
  emxArray_real32_T *b_in1;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real32_T(&b_in1, 2, &lc_emlrtRTEI, true);
  i = b_in1->size[0] * b_in1->size[1];
  b_in1->size[0] = in1->size[0];
  if (in2->size[1] == 1) {
    b_in1->size[1] = in1->size[1];
  } else {
    b_in1->size[1] = in2->size[1];
  }

  emxEnsureCapacity_real32_T(b_in1, i, &lc_emlrtRTEI);
  stride_0_1 = (in1->size[1] != 1);
  stride_1_1 = (in2->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (in2->size[1] == 1) {
    b = in1->size[1];
  } else {
    b = in2->size[1];
  }

  for (i = 0; i < b; i++) {
    for (int32_T i1{0}; i1 < in1->size[0]; i1++) {
      b_in1->data[i1 + b_in1->size[0] * i] = in1->data[i1 + in1->size[0] *
        aux_0_1] - in2->data[aux_1_1] / (in3 + 2.22044605E-16F);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }

  i = in1->size[0] * in1->size[1];
  in1->size[0] = b_in1->size[0];
  in1->size[1] = b_in1->size[1];
  emxEnsureCapacity_real32_T(in1, i, &u_emlrtRTEI);
  for (i = 0; i < b_in1->size[1]; i++) {
    for (int32_T i1{0}; i1 < b_in1->size[0]; i1++) {
      in1->data[i1 + in1->size[0] * i] = b_in1->data[i1 + b_in1->size[0] * i];
    }
  }

  emxFree_real32_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4, int32_T in5,
  real32_T in6)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  i = in1->size[0];
  if (in5 == 1) {
    b = in3->size[0];
  } else {
    b = in5;
  }

  if (b == 1) {
    in1->size[0] = in2->size[0];
  } else if (in5 == 1) {
    in1->size[0] = in3->size[0];
  } else {
    in1->size[0] = in5;
  }

  emxEnsureCapacity_real32_T(in1, i, &cd_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  stride_2_0 = (in5 != 1);
  if (in5 == 1) {
    b = in3->size[0];
  } else {
    b = in5;
  }

  if (b == 1) {
    b = in2->size[0];
  } else if (in5 == 1) {
    b = in3->size[0];
  } else {
    b = in5;
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[i * stride_0_0] + (in3->data[i * stride_1_0] -
      (in4->data[i * stride_2_0] - in6));
  }
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, real32_T in3, const emxArray_real32_T *in4)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in4->size[0] == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in4->size[0];
  }

  emxEnsureCapacity_real32_T(in1, i, &q_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in4->size[0] != 1);
  if (in4->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in4->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = (in2->data[i * stride_0_0] - in3) * in4->data[i * stride_1_0];
  }
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, int32_T in3, const emxArray_real32_T *in4, const emxArray_real32_T *in5)
{
  int32_T i;
  int32_T in4_idx_0;
  int32_T in5_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  in4_idx_0 = in4->size[0];
  in5_idx_0 = in5->size[0];
  i = in1->size[0] * in1->size[1];
  if (in5_idx_0 == 1) {
    if (in4_idx_0 == 1) {
      in1->size[0] = in3;
    } else {
      in1->size[0] = in4_idx_0;
    }
  } else {
    in1->size[0] = in5_idx_0;
  }

  in1->size[1] = 1;
  emxEnsureCapacity_real32_T(in1, i, &m_emlrtRTEI);
  stride_0_0 = (in3 != 1);
  stride_1_0 = (in4_idx_0 != 1);
  stride_2_0 = (in5_idx_0 != 1);
  if (in5_idx_0 == 1) {
    if (in4_idx_0 == 1) {
      in5_idx_0 = in3;
    } else {
      in5_idx_0 = in4_idx_0;
    }
  }

  for (i = 0; i < in5_idx_0; i++) {
    in1->data[i] = (in2->data[i * stride_0_0] - in4->data[i * stride_1_0]) *
      in5->data[i * stride_2_0];
  }
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2)
{
  emxArray_real32_T *b_in1;
  int32_T i;
  int32_T in2_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  in2_idx_0 = in2->size[0];
  emxInit_real32_T(&b_in1, 2, &xd_emlrtRTEI, true);
  i = b_in1->size[0] * b_in1->size[1];
  if (in2_idx_0 == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in2_idx_0;
  }

  b_in1->size[1] = 1;
  emxEnsureCapacity_real32_T(b_in1, i, &xd_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in2_idx_0 != 1);
  if (in2_idx_0 == 1) {
    in2_idx_0 = in1->size[0];
  }

  for (i = 0; i < in2_idx_0; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0] * in2->data[i * stride_1_0];
  }

  i = in1->size[0] * in1->size[1];
  in1->size[0] = b_in1->size[0];
  in1->size[1] = 1;
  emxEnsureCapacity_real32_T(in1, i, &yd_emlrtRTEI);
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }

  emxFree_real32_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4, const
  emxArray_real32_T *in5)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T in4_idx_0;
  int32_T in5_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  in3_idx_0 = in3->size[0];
  in4_idx_0 = in4->size[0];
  in5_idx_0 = in5->size[0];
  i = in1->size[0] * in1->size[1];
  if (in5_idx_0 == 1) {
    if (in4_idx_0 == 1) {
      in1->size[0] = in3_idx_0;
    } else {
      in1->size[0] = in4_idx_0;
    }
  } else {
    in1->size[0] = in5_idx_0;
  }

  in1->size[1] = 1;
  emxEnsureCapacity_real32_T(in1, i, &fd_emlrtRTEI);
  stride_0_0 = (in3_idx_0 != 1);
  stride_1_0 = (in4_idx_0 != 1);
  stride_2_0 = (in5_idx_0 != 1);
  if (in5_idx_0 == 1) {
    if (in4_idx_0 == 1) {
      in5_idx_0 = in3_idx_0;
    } else {
      in5_idx_0 = in4_idx_0;
    }
  }

  for (i = 0; i < in5_idx_0; i++) {
    in1->data[i] = (in2->data[i * stride_0_0] - in4->data[i * stride_1_0]) *
      in5->data[i * stride_2_0];
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

static __device__ int64_T computeEndIdx_device(int64_T start, int64_T end,
  int64_T stride)
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

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel1(creal32_T *fc,
  creal32_T *fc2)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fc2->re = CUDART_NAN_F;
    fc->re = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel10(const
  emxArray_real32_T w, const real32_T out, const emxArray_real32_T x, int32_T
  b_x, emxArray_real32_T fv4)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv4.data[i] = (x.data[i] - out) * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel100(const
  int32_T vlen, int32_T m, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(vlen + k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel101(const
  real32_T start, real32_T stop, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(stop) - static_cast<real_T>
    (start));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(start) +
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel102(const
  emxArray_real32_T x, const emxArray_real32_T vec, int32_T b_vec,
  emxArray_real32_T fv2)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vec);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv2.data[i] = x.data[static_cast<int32_T>(vec.data[i]) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel103(const
  emxArray_real32_T w, const emxArray_real32_T vec, int32_T b_vec,
  emxArray_real32_T fv3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vec);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv3.data[i] = w.data[static_cast<int32_T>(vec.data[i]) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel104(const
  real32_T d2scaled, int32_T *npages, emxArray_real32_T lin, int32_T lin_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real32_T>((((k + 2) << 1) - lin_dim1) - 1) *
      d2scaled;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel105
  (emxArray_real32_T lin, int32_T lin_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[lin_dim1 >> 1] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel106(const
  int32_T n, const emxArray_real32_T lin, int32_T nx, emxArray_real32_T fv5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv5.data[k] = powf(lin.data[k], static_cast<real32_T>(n) + 1.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel107(const
  emxArray_real32_T fv5, const int32_T vlen, int32_T x, emxArray_real32_T r,
  int32_T r_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    r.data[i + r_dim0 * (vlen - 1)] = fv5.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel108(const
  emxArray_real32_T fv3, const emxArray_real32_T fv2, int32_T b_fv2,
  emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = fv2.data[i] * fv3.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel109(const
  emxArray_real32_T fv3, const emxArray_real32_T fv2, int32_T b_fv2,
  emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = fv2.data[i] * fv3.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel11(const
  emxArray_real32_T w, const emxArray_real32_T r, const int32_T b_r, int32_T c_r,
  emxArray_real32_T c, int32_T c_dim0, int32_T r_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_r) + 1UL) * (static_cast<uint64_T>(c_r) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_r) + 1UL));
    c.data[xpageoffset + c_dim0 * i] = r.data[xpageoffset + r_dim0 * i] *
      w.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel110(const
  emxArray_real32_T fv3, const real32_T d2scaled, const emxArray_real32_T fv2,
  int32_T b_fv2, emxArray_real32_T fv7)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv7.data[i] = (fv2.data[i] - d2scaled) * fv3.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel111(const
  emxArray_real32_T fv3, const emxArray_real32_T r, const int32_T b_r, int32_T
  c_r, emxArray_real32_T c, int32_T c_dim0, int32_T r_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_r) + 1UL) * (static_cast<uint64_T>(c_r) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_r) + 1UL));
    c.data[xpageoffset + c_dim0 * i] = r.data[xpageoffset + r_dim0 * i] *
      fv3.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel112(const
  int32_T vlen, const emxArray_real32_T c, int32_T *npages, emxArray_real32_T y,
  int32_T c_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx);
    xpageoffset = i * c_dim0;
    y.data[i] = c.data[xpageoffset];
    for (int32_T k{0}; k <= vlen - 2; k++) {
      y.data[i] += c.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel113(int32_T
  sz, emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel114(const
  real32_T d2scaled, const emxArray_real32_T y, const emxArray_real32_T r, const
  int32_T b_r, int32_T c_r, emxArray_real32_T d_r, int32_T r_dim0, int32_T
  b_r_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_r) + 1UL) * (static_cast<uint64_T>(c_r) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_r) + 1UL));
    d_r.data[xpageoffset + r_dim0 * i] = r.data[xpageoffset + b_r_dim0 * i] -
      y.data[i] / d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel115(const
  emxArray_real32_T r, int32_T b_r, emxArray_real32_T c_r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_r);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_r.data[i] = r.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel116(const
  emxArray_real32_T fv3, const emxArray_real32_T r, const int32_T b_r, int32_T
  c_r, emxArray_real32_T rr, int32_T rr_dim0, int32_T r_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_r) + 1UL) * (static_cast<uint64_T>(c_r) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_r) + 1UL));
    rr.data[xpageoffset + rr_dim0 * i] = r.data[xpageoffset + r_dim0 * i] *
      fv3.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel117(const
  emxArray_real32_T rr, const int32_T b_rr, int32_T c_rr, emxArray_real32_T a,
  int32_T a_dim0, int32_T rr_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_rr) + 1UL) * (static_cast<uint64_T>(c_rr) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_rr) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_rr) + 1UL));
    a.data[xpageoffset + a_dim0 * i] = rr.data[i + rr_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel118(int32_T a,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel119(const
  emxArray_real32_T wimag, const emxArray_real32_T wreal, int32_T n,
  emxArray_creal32_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i].re = wreal.data[i];
    W.data[i].im = wimag.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel12(const
  int32_T vlen, const emxArray_real32_T c, int32_T *npages, emxArray_real32_T y,
  int32_T c_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx);
    xpageoffset = i * c_dim0;
    y.data[i] = c.data[xpageoffset];
    for (int32_T k{0}; k <= vlen - 2; k++) {
      y.data[i] += c.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel120(const
  emxArray_real32_T vright, int32_T b_vright, emxArray_creal32_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vright);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i].re = vright.data[i];
    V.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel121(const
  int32_T *npages, int32_T n, emxArray_creal32_T V, int32_T V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T xpageoffset;
    real32_T f;
    xpageoffset = static_cast<int32_T>(idx);
    f = V.data[xpageoffset + V_dim0 * (*npages - 1)].re;
    V.data[xpageoffset + V_dim0 * (*npages - 2)].im = f;
    V.data[xpageoffset + V_dim0 * (*npages - 1)].re = V.data[xpageoffset +
      V_dim0 * (*npages - 2)].re;
    V.data[xpageoffset + V_dim0 * (*npages - 1)].im = -V.data[xpageoffset +
      V_dim0 * (*npages - 2)].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel122(const
  creal32_T *fc2, int32_T x, emxArray_creal32_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = *fc2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel123(const
  creal32_T *fc2, int32_T V, emxArray_creal32_T b_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_V.data[i] = *fc2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel124(int32_T A,
  emxArray_creal32_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel125(int32_T V,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel126(int32_T x,
  emxArray_real32_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel127(const
  emxArray_real32_T A, int32_T b_A, emxArray_real32_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_A);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = A.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel128(int32_T V,
  emxArray_real32_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel129(int32_T V,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel13(int32_T sz,
  emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel130(int32_T V,
  emxArray_real32_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel131(int32_T
  sz, emxArray_real32_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel132(const
  int32_T n, const int32_T *npages, int32_T m, emxArray_real32_T U, int32_T
  U_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>
    (*npages), static_cast<int64_T>(m), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    U.data[(static_cast<int32_T>(static_cast<int64_T>(*npages) + i) + U_dim0 *
            (n - 1)) - 1] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel133(int32_T
  sz, emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel134(int32_T A,
  emxArray_creal32_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel135(const
  emxArray_real32_T U, int32_T b_U, emxArray_creal32_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_U);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i].re = U.data[i];
    V.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel136(int32_T x,
  emxArray_real32_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel137(int32_T V,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel138(int32_T m,
  emxArray_creal32_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m * m) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel139(const
  emxArray_real32_T A, int32_T b_A, emxArray_creal32_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_A);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i].re = A.data[i];
    V.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel14(const
  real32_T d2scaled, const emxArray_real32_T y, const emxArray_real32_T r, const
  int32_T b_r, int32_T c_r, emxArray_real32_T fv6, int32_T fv6_dim0, int32_T
  r_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_r) + 1UL) * (static_cast<uint64_T>(c_r) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_r) + 1UL));
    fv6.data[xpageoffset + fv6_dim0 * i] = r.data[xpageoffset + r_dim0 * i] -
      y.data[i] / d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel140(const
  creal32_T *fc, int32_T V, emxArray_creal32_T b_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_V.data[i] = *fc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel141(int32_T V,
  emxArray_creal32_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel142(const
  emxArray_creal32_T V, int32_T b_V, emxArray_real32_T c_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_V.data[i] = V.data[i].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel143(const
  emxArray_creal32_T D, int32_T b_D, emxArray_real32_T fcnOutput)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_D);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fcnOutput.data[i] = D.data[i].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel144(const
  emxArray_real32_T fcnOutput, int32_T *npages, emxArray_real32_T D, int32_T
  fcnOutput_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    D.data[k] = fcnOutput.data[k + fcnOutput_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel145(const
  emxArray_int32_T iv2, const emxArray_real32_T V, const int32_T vlen, int32_T
  b_iv2, emxArray_real32_T b_V, int32_T V_dim0, int32_T b_V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) * (static_cast<uint64_T>(b_iv2) + 1UL) -
    1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % static_cast<uint64_T>(vlen));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) /
      static_cast<uint64_T>(vlen));
    b_V.data[xpageoffset + V_dim0 * i] = V.data[xpageoffset + b_V_dim0 *
      iv2.data[i]];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel146(const
  emxArray_real32_T V, int32_T b_V, emxArray_real32_T c_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_V.data[i] = V.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel147(const
  emxArray_real32_T rr, int32_T b_rr, emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_rr);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = rr.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel148(int32_T V,
  emxArray_real32_T rr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    rr.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel149(const
  emxArray_real32_T fv7, int32_T b_fv7, emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv7);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[i] = fv7.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel15(const
  emxArray_real32_T w, const emxArray_real32_T fv6, const int32_T b_fv6, int32_T
  c_fv6, emxArray_real32_T rr, int32_T rr_dim0, int32_T fv6_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_fv6) + 1UL) * (static_cast<uint64_T>(c_fv6)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fv6) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_fv6) + 1UL));
    rr.data[xpageoffset + rr_dim0 * i] = fv6.data[xpageoffset + fv6_dim0 * i] *
      w.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel150(int32_T
  rr, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(rr);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel151(const
  emxArray_real32_T rr, const int32_T b_rr, int32_T c_rr, emxArray_real32_T a,
  int32_T a_dim0, int32_T rr_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_rr) + 1UL) * (static_cast<uint64_T>(c_rr) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_rr) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_rr) + 1UL));
    a.data[xpageoffset + a_dim0 * i] = rr.data[i + rr_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel152(int32_T a,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel153(const
  emxArray_real32_T A, const int32_T b_A, int32_T c_A, emxArray_real32_T d_A,
  int32_T A_dim0, int32_T b_A_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_A) + 1UL) * (static_cast<uint64_T>(c_A) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_A) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_A) + 1UL));
    d_A.data[xpageoffset + A_dim0 * i] = A.data[i + b_A_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel154(const
  emxArray_real32_T b, int32_T b_b, emxArray_real32_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel155(int32_T A,
  emxArray_int32_T jpvt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    jpvt.data[i] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel156(const
  int32_T m, int32_T na, emxArray_real32_T A, int32_T A_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m) * (static_cast<uint64_T>(na) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx % static_cast<uint64_T>(m));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      static_cast<uint64_T>(m));
    A.data[xpageoffset * A_dim0 + i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel157(int32_T
  vlen, emxArray_real32_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    tau.data[k] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel158(const
  int32_T *npages, int32_T nx, emxArray_real32_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>
    (*npages), static_cast<int64_T>(nx), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    tau.data[static_cast<int32_T>(static_cast<int64_T>(*npages) + i) - 1] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel159(int32_T
  na, emxArray_int32_T jpvt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    jpvt.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel16(const
  emxArray_real32_T rr, const int32_T b_rr, int32_T c_rr, emxArray_real32_T a,
  int32_T a_dim0, int32_T rr_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_rr) + 1UL) * (static_cast<uint64_T>(c_rr) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_rr) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_rr) + 1UL));
    a.data[xpageoffset + a_dim0 * i] = rr.data[i + rr_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel160(int32_T
  *npages, emxArray_real32_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel161(int32_T x,
  emxArray_real32_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel162(const
  emxArray_real32_T B, const emxArray_int32_T jpvt, int32_T nx,
  emxArray_real32_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[jpvt.data[i] - 1] = B.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel163(const
  emxArray_real32_T Y, int32_T b_Y, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_Y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = Y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel164(const
  emxArray_int32_T ipiv_t, int32_T *npages, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel165(int32_T V,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel166(int32_T
  *npages, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel167(int32_T
  sz, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel168(const
  emxArray_real32_T b, int32_T b_b, emxArray_real32_T c_b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_b.data[i] = b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel169(int32_T V,
  emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel17(int32_T a,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel170(int32_T r,
  emxArray_real32_T fv9)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(r);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv9.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel171(const
  real32_T out, const emxArray_real32_T fv2, const emxArray_real32_T fv9,
  int32_T b_fv9, emxArray_real32_T z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv9);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    z.data[i] = fv9.data[i] + (fv2.data[i] - (fv2.data[i] - out));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel172(const
  emxArray_real32_T fv3, const emxArray_real32_T z, const emxArray_real32_T fv2,
  int32_T *npages, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = (fv2.data[i] - z.data[i]) * fv3.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel173(const
  emxArray_real32_T fv3, const emxArray_real32_T z, const emxArray_real32_T fv2,
  int32_T *npages, emxArray_real32_T d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = (fv2.data[i] - z.data[i]) * fv3.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel174(const
  real32_T d2scaled, const emxArray_real32_T c, int32_T m, emxArray_real32_T
  absdiff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabsf(c.data[k] - d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel175(const
  emxArray_real32_T z, const emxArray_real32_T fv2, int32_T *npages,
  emxArray_real32_T yy)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    yy.data[i] = fv2.data[i] - z.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel176(int32_T m,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel177(real32_T
  d2scaled, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(d2scaled) - 1.0);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(i) + 1.0);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel178(const
  real32_T d2scaled, const real_T ndbl, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[static_cast<int32_T>(ndbl) - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel179(const
  real32_T d2scaled, const int32_T m, const real32_T abnrm, int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k + 1] = abnrm - static_cast<real32_T>(k + 1);
    vec.data[(m - k) - 2] = d2scaled - (-static_cast<real32_T>(k + 1));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel18(const
  emxArray_real32_T wimag, const emxArray_real32_T wreal, int32_T n,
  emxArray_creal32_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i].re = wreal.data[i];
    W.data[i].im = wimag.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel180(const
  real32_T abnrm, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = abnrm - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel181(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages + 1] = d2scaled - (-static_cast<real32_T>(*npages));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel182(const
  real32_T d2scaled, const real32_T abnrm, const int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = (abnrm + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel183(const
  int32_T vlen, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(vlen - k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel184(const
  real32_T abnrm, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(-(1.0 - static_cast<real_T>(abnrm)));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(abnrm) -
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel185(const
  emxArray_real32_T vec, int32_T *npages, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = vec.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel186(int32_T m,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel187(real32_T
  d2scaled, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(d2scaled) - 1.0);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(i) + 1.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel188(const
  emxArray_real32_T vec, int32_T *npages, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = vec.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel189(const
  real32_T d2scaled, const real_T ndbl, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[static_cast<int32_T>(ndbl) - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel19(const
  emxArray_real32_T vright, int32_T b_vright, emxArray_creal32_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vright);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i].re = vright.data[i];
    V.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel190(const
  real32_T d2scaled, const int32_T m, const real32_T abnrm, int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k + 1] = abnrm - static_cast<real32_T>(k + 1);
    vec.data[(m - k) - 2] = d2scaled - (-static_cast<real32_T>(k + 1));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel191(const
  real32_T abnrm, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = abnrm - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel192(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages + 1] = d2scaled - (-static_cast<real32_T>(*npages));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel193(const
  real32_T d2scaled, const real32_T abnrm, const int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = (abnrm + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel194(const
  int32_T vlen, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(vlen - k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel195(const
  real32_T abnrm, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(-(1.0 - static_cast<real_T>(abnrm)));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(abnrm) -
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel196(const
  real32_T out, int32_T *npages, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = (out + 1.0F) / 2.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel197(const
  real32_T d2scaled, const int32_T m, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[m - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel198(const
  real32_T d2scaled, const int32_T m, const real32_T start, int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k + 1] = start + static_cast<real32_T>(k + 1);
    vec.data[(m - k) - 2] = d2scaled - static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel199(const
  real32_T start, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = start + static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel2(const
  emxArray_real32_T w, const int32_T ch, const emxArray_real32_T x, int32_T b_x,
  emxArray_real32_T b_w, emxArray_real32_T c_x, emxArray_real32_T d_x, int32_T
  x_dim0, int32_T w_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d_x.data[i] = x.data[i + x_dim0 * ch];
    c_x.data[i] = x.data[i + x_dim0 * ch];
    b_w.data[i] = w.data[i + w_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel20(const
  int32_T *npages, int32_T n, emxArray_creal32_T V, int32_T V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T xpageoffset;
    real32_T f;
    xpageoffset = static_cast<int32_T>(idx);
    f = V.data[xpageoffset + V_dim0 * (*npages - 1)].re;
    V.data[xpageoffset + V_dim0 * (*npages - 2)].im = f;
    V.data[xpageoffset + V_dim0 * (*npages - 1)].re = V.data[xpageoffset +
      V_dim0 * (*npages - 2)].re;
    V.data[xpageoffset + V_dim0 * (*npages - 1)].im = -V.data[xpageoffset +
      V_dim0 * (*npages - 2)].im;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel200(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages + 1] = d2scaled - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel201(const
  real32_T d2scaled, const real32_T start, const int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = (start + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel202(const
  int32_T vlen, int32_T m, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(vlen + k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel203(const
  real32_T start, real32_T stop, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(stop) - static_cast<real_T>
    (start));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(start) +
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel204(const
  emxArray_real32_T vec, int32_T b_vec, emxArray_int32_T iv6)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vec);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    iv6.data[i] = static_cast<int32_T>(vec.data[i]) - 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel205(const
  real32_T d2scaled, const int32_T m, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[m - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel206(const
  real32_T d2scaled, const int32_T m, const real32_T start, int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k + 1] = start + static_cast<real32_T>(k + 1);
    vec.data[(m - k) - 2] = d2scaled - static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel207(const
  real32_T start, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = start + static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel208(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages + 1] = d2scaled - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel209(const
  real32_T d2scaled, const real32_T start, const int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = (start + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel21(const
  creal32_T *fc2, int32_T x, emxArray_creal32_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = *fc2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel210(const
  int32_T vlen, int32_T m, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(vlen + k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel211(const
  real32_T start, real32_T stop, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(stop) - static_cast<real_T>
    (start));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(start) +
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel212(const
  emxArray_real32_T x, const emxArray_real32_T vec, int32_T b_vec,
  emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vec);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[i] = x.data[static_cast<int32_T>(vec.data[i]) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel213(const
  emxArray_real32_T b, const emxArray_real32_T yy, const emxArray_real32_T a,
  const emxArray_int32_T iv6, int32_T b_a, emxArray_real32_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[iv6.data[i]] = a.data[i] + yy.data[i] * b.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel214(const
  real32_T d2scaled, const int32_T m, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[m - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel215(const
  real32_T d2scaled, const int32_T m, const real32_T start, int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k + 1] = start + static_cast<real32_T>(k + 1);
    vec.data[(m - k) - 2] = d2scaled - static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel216(const
  real32_T start, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = start + static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel217(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages + 1] = d2scaled - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel218(const
  real32_T d2scaled, const real32_T start, const int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = (start + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel219(const
  int32_T vlen, int32_T m, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(vlen + k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel22(const
  creal32_T *fc2, int32_T V, emxArray_creal32_T b_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_V.data[i] = *fc2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel220(const
  real32_T start, real32_T stop, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(stop) - static_cast<real_T>
    (start));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(start) +
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel221(const
  emxArray_real32_T vec, int32_T b_vec, emxArray_int32_T iv7)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vec);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    iv7.data[i] = static_cast<int32_T>(vec.data[i]) - 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel222(const
  real32_T d2scaled, const int32_T m, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[m - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel223(const
  real32_T d2scaled, const int32_T m, const real32_T start, int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k + 1] = start + static_cast<real32_T>(k + 1);
    vec.data[(m - k) - 2] = d2scaled - static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel224(const
  real32_T start, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = start + static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel225(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages + 1] = d2scaled - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel226(const
  real32_T d2scaled, const real32_T start, const int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = (start + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel227(const
  int32_T vlen, int32_T m, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(vlen + k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel228(const
  real32_T start, real32_T stop, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(stop) - static_cast<real_T>
    (start));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(start) +
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel229(const
  real32_T d2scaled, const int32_T m, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[m - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel23(int32_T A,
  emxArray_creal32_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel230(const
  real32_T d2scaled, const int32_T m, const real32_T start, int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k + 1] = start + static_cast<real32_T>(k + 1);
    vec.data[(m - k) - 2] = d2scaled - static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel231(const
  real32_T start, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = start + static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel232(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages + 1] = d2scaled - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel233(const
  real32_T d2scaled, const real32_T start, const int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = (start + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel234(const
  int32_T vlen, int32_T m, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(vlen + k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel235(const
  real32_T start, real32_T stop, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(stop) - static_cast<real_T>
    (start));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(start) +
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel236(const
  emxArray_real32_T x, const emxArray_real32_T vec, int32_T b_vec,
  emxArray_real32_T fv10)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vec);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv10.data[i] = x.data[static_cast<int32_T>(vec.data[i]) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel237(const
  emxArray_real32_T trend, const emxArray_real32_T vec, int32_T b_vec,
  emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vec);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[i] = trend.data[static_cast<int32_T>(vec.data[i]) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel238(const
  emxArray_real32_T b, const emxArray_real32_T yy, const emxArray_real32_T fv10,
  const emxArray_real32_T a, const emxArray_int32_T iv7, int32_T b_a,
  emxArray_real32_T trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    trend.data[iv7.data[i]] = a.data[i] + (fv10.data[i] - yy.data[i]) * b.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel239(const
  real32_T d2scaled, const int32_T m, emxArray_real32_T fv11)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fv11.data[m - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel24(int32_T V,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel240(const
  real32_T d2scaled, const int32_T m, const real32_T start, int32_T *npages,
  emxArray_real32_T fv11)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv11.data[k + 1] = start + static_cast<real32_T>(k + 1);
    fv11.data[(m - k) - 2] = d2scaled - static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel241(const
  real32_T start, const int32_T *npages, emxArray_real32_T fv11)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fv11.data[*npages] = start + static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel242(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T fv11)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fv11.data[*npages + 1] = d2scaled - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel243(const
  real32_T d2scaled, const real32_T start, const int32_T *npages,
  emxArray_real32_T fv11)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fv11.data[*npages] = (start + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel244(const
  int32_T vlen, int32_T m, emxArray_real32_T fv11)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv11.data[k] = static_cast<real32_T>(vlen + k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel245(const
  real32_T start, real32_T stop, emxArray_real32_T fv11)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(stop) - static_cast<real_T>
    (start));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv11.data[i] = static_cast<real32_T>(static_cast<real_T>(start) +
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel246(const
  real32_T d2scaled, const int32_T m, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[m - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel247(const
  real32_T d2scaled, const int32_T m, const real32_T start, int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k + 1] = start + static_cast<real32_T>(k + 1);
    vec.data[(m - k) - 2] = d2scaled - static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel248(const
  real32_T start, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = start + static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel249(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages + 1] = d2scaled - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel25(int32_T x,
  emxArray_real32_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel250(const
  real32_T d2scaled, const real32_T start, const int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = (start + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel251(const
  int32_T vlen, int32_T m, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(vlen + k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel252(const
  real32_T start, real32_T stop, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(stop) - static_cast<real_T>
    (start));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(start) +
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel253(const
  emxArray_real32_T vec, int32_T b_vec, emxArray_int32_T iv8)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vec);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    iv8.data[i] = static_cast<int32_T>(vec.data[i]) - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel254(const
  emxArray_real32_T b, const emxArray_real32_T a, const emxArray_real32_T fv11,
  int32_T b_fv11, emxArray_real32_T b_a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv11);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_a.data[i] = a.data[static_cast<int32_T>(fv11.data[i]) - 1] + b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel255(const
  emxArray_real32_T a, const emxArray_int32_T iv8, int32_T b_a,
  emxArray_real32_T c_a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_a.data[iv8.data[i]] = a.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel256
  (emxArray_real32_T a, int32_T a_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    // 'ec_detrend:143' a(end,:) = a(end-1,:);
    a.data[static_cast<int32_T>(static_cast<real32_T>(a_dim0)) - 1] = a.data[
      static_cast<int32_T>(static_cast<real32_T>(a_dim0) - 1.0F) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel257(const
  emxArray_real32_T a, int32_T b_a, emxArray_real32_T fv12)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv12.data[i] = 1.0F / a.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel258(const
  emxArray_real32_T fv12, const emxArray_real32_T x, int32_T b_x,
  emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = x.data[i] * fv12.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel259(const
  emxArray_real32_T fv12, const emxArray_real32_T x, int32_T b_x,
  emxArray_real32_T c_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_x.data[i] = x.data[i] * fv12.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel26(const
  emxArray_real32_T A, int32_T b_A, emxArray_real32_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_A);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = A.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel260(const
  emxArray_real32_T x, int32_T b_x, emxArray_real32_T c_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_x.data[i] = x.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel261(int32_T n,
  emxArray_real32_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (isnan(x.data[i])) {
      x.data[i] = 0.0F;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel262(const
  emxArray_real32_T a, int32_T b_a, emxArray_real32_T fv13)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv13.data[i] = 1.0F / a.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel263(const
  emxArray_real32_T fv13, const emxArray_real32_T trend, int32_T b_trend,
  emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_trend);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = trend.data[i] * fv13.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel264(const
  emxArray_real32_T fv13, const emxArray_real32_T trend, int32_T b_trend,
  emxArray_real32_T c_trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_trend);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_trend.data[i] = trend.data[i] * fv13.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel265(const
  emxArray_real32_T trend, int32_T b_trend, emxArray_real32_T c_trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_trend);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_trend.data[i] = trend.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel266(int32_T n,
  emxArray_real32_T trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (isnan(trend.data[i])) {
      trend.data[i] = 0.0F;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel267(const
  emxArray_real32_T w, const emxArray_real32_T trend, const emxArray_real32_T x,
  int32_T V, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = (x.data[i] - trend.data[i]) * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel268(const
  emxArray_real32_T w, const emxArray_real32_T trend, const emxArray_real32_T x,
  int32_T V, emxArray_real32_T d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = (x.data[i] - trend.data[i]) * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel269(const
  real32_T d2scaled, const emxArray_real32_T c, int32_T m, emxArray_real32_T
  absdiff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabsf(c.data[k] - d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel27(int32_T V,
  emxArray_real32_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel270(const
  emxArray_real32_T d, int32_T nx, emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = fabsf(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel271(const
  real32_T y_data_dim0, const real32_T thr, const emxArray_real32_T y, int32_T
  b_y, emxArray_boolean_T r1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    r1.data[i] = (y.data[i] > thr * y_data_dim0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel272(const
  emxArray_boolean_T r1, int32_T n, emxArray_real32_T w)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (r1.data[i]) {
      w.data[i] = 0.0F;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel273(const
  emxArray_real32_T x, const int32_T ch, int32_T b_x, emxArray_real32_T c_x,
  int32_T x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_x.data[i + x_dim0 * ch] = x.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel274(const
  emxArray_real32_T w, const int32_T ch, int32_T b_w, emxArray_real32_T c_w,
  int32_T w_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_w);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_w.data[i + w_dim0 * ch] = w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel28(int32_T V,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel29(int32_T V,
  emxArray_real32_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel3(int32_T w,
  emxArray_real32_T b_w)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(w);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_w.data[i] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel30(int32_T sz,
  emxArray_real32_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel31(const
  int32_T n, const int32_T *npages, int32_T m, emxArray_real32_T U, int32_T
  U_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>
    (*npages), static_cast<int64_T>(m), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    U.data[(static_cast<int32_T>(static_cast<int64_T>(*npages) + i) + U_dim0 *
            (n - 1)) - 1] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel32(int32_T sz,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel33(int32_T A,
  emxArray_creal32_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel34(const
  emxArray_real32_T U, int32_T b_U, emxArray_creal32_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_U);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i].re = U.data[i];
    V.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel35(int32_T x,
  emxArray_real32_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel36(int32_T V,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel37(int32_T m,
  emxArray_creal32_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m * m) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel38(const
  emxArray_real32_T A, int32_T b_A, emxArray_creal32_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_A);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i].re = A.data[i];
    V.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel39(const
  creal32_T *fc, int32_T V, emxArray_creal32_T b_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_V.data[i] = *fc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel4(const
  real32_T d2scaled, int32_T *npages, emxArray_real32_T lin, int32_T lin_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real32_T>((((k + 2) << 1) - lin_dim1) - 1) *
      d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel40(int32_T V,
  emxArray_creal32_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel41(const
  emxArray_creal32_T V, int32_T b_V, emxArray_real32_T c_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_V.data[i] = V.data[i].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel42(const
  emxArray_creal32_T D, int32_T b_D, emxArray_real32_T fcnOutput)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_D);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fcnOutput.data[i] = D.data[i].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel43(const
  emxArray_real32_T fcnOutput, int32_T *npages, emxArray_real32_T D, int32_T
  fcnOutput_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    D.data[k] = fcnOutput.data[k + fcnOutput_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel44(const
  emxArray_int32_T iv, const emxArray_real32_T V, const int32_T vlen, int32_T
  b_iv, emxArray_real32_T b_V, int32_T V_dim0, int32_T b_V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) * (static_cast<uint64_T>(b_iv) + 1UL) -
    1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % static_cast<uint64_T>(vlen));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) /
      static_cast<uint64_T>(vlen));
    b_V.data[xpageoffset + V_dim0 * i] = V.data[xpageoffset + b_V_dim0 *
      iv.data[i]];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel45(const
  emxArray_real32_T V, int32_T b_V, emxArray_real32_T c_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_V.data[i] = V.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel46(const
  emxArray_real32_T rr, int32_T b_rr, emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_rr);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = rr.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel47(int32_T V,
  emxArray_real32_T rr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    rr.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel48(const
  emxArray_real32_T fv4, int32_T b_fv4, emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv4);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[i] = fv4.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel49(int32_T rr,
  emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(rr);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel5
  (emxArray_real32_T lin, int32_T lin_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[lin_dim1 >> 1] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel50(const
  emxArray_real32_T rr, const int32_T b_rr, int32_T c_rr, emxArray_real32_T a,
  int32_T a_dim0, int32_T rr_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_rr) + 1UL) * (static_cast<uint64_T>(c_rr) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_rr) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_rr) + 1UL));
    a.data[xpageoffset + a_dim0 * i] = rr.data[i + rr_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel51(int32_T a,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel52(const
  emxArray_real32_T A, const int32_T b_A, int32_T c_A, emxArray_real32_T d_A,
  int32_T A_dim0, int32_T b_A_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_A) + 1UL) * (static_cast<uint64_T>(c_A) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_A) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_A) + 1UL));
    d_A.data[xpageoffset + A_dim0 * i] = A.data[i + b_A_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel53(const
  emxArray_real32_T b, int32_T b_b, emxArray_real32_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel54(int32_T A,
  emxArray_int32_T jpvt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    jpvt.data[i] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel55(const
  int32_T m, int32_T na, emxArray_real32_T A, int32_T A_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m) * (static_cast<uint64_T>(na) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx % static_cast<uint64_T>(m));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      static_cast<uint64_T>(m));
    A.data[xpageoffset * A_dim0 + i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel56(int32_T
  vlen, emxArray_real32_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    tau.data[k] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel57(const
  int32_T *npages, int32_T nx, emxArray_real32_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>
    (*npages), static_cast<int64_T>(nx), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    tau.data[static_cast<int32_T>(static_cast<int64_T>(*npages) + i) - 1] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel58(int32_T na,
  emxArray_int32_T jpvt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    jpvt.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel59(int32_T
  *npages, emxArray_real32_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel6(const
  int32_T n, const emxArray_real32_T lin, int32_T nx, emxArray_real32_T fv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv.data[k] = powf(lin.data[k], static_cast<real32_T>(n) + 1.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel60(int32_T x,
  emxArray_real32_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel61(const
  emxArray_real32_T B, const emxArray_int32_T jpvt, int32_T nx,
  emxArray_real32_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[jpvt.data[i] - 1] = B.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel62(const
  emxArray_real32_T Y, int32_T b_Y, emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_Y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = Y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel63(const
  emxArray_int32_T ipiv_t, int32_T *npages, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel64(int32_T V,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel65(int32_T
  *npages, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel66(int32_T sz,
  emxArray_real32_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel67(const
  emxArray_real32_T b, int32_T b_b, emxArray_real32_T c_b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_b.data[i] = b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel68(int32_T V,
  emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel69(int32_T
  fv6, emxArray_real32_T fv8)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv6);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv8.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel7(const
  emxArray_real32_T fv, const int32_T vlen, int32_T x, emxArray_real32_T r,
  int32_T r_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    r.data[i + r_dim0 * (vlen - 1)] = fv.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel70(const
  real32_T out, const emxArray_real32_T x, const emxArray_real32_T b_x, const
  emxArray_real32_T fv8, int32_T b_fv8, emxArray_real32_T z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv8);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    z.data[i] = fv8.data[i] + (b_x.data[i] - (x.data[i] - out));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel71(const
  emxArray_real32_T z, int32_T b_z, emxArray_real32_T c_z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_z);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_z.data[i] = z.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel72(const
  emxArray_real32_T w, const emxArray_real32_T z, const emxArray_real32_T x,
  int32_T V, emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = (x.data[i] - z.data[i]) * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel73(const
  emxArray_real32_T w, const emxArray_real32_T z, const emxArray_real32_T x,
  int32_T V, emxArray_real32_T d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = (x.data[i] - z.data[i]) * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel74(const
  real32_T d2scaled, const emxArray_real32_T c, int32_T m, emxArray_real32_T
  absdiff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabsf(c.data[k] - d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel75(const
  emxArray_real32_T d, int32_T nx, emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = fabsf(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel76(const
  real32_T y_data_dim0, const real32_T thr, const emxArray_real32_T y, int32_T
  b_y, emxArray_boolean_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    r.data[i] = (y.data[i] > thr * y_data_dim0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel77(const
  emxArray_boolean_T r, int32_T n, emxArray_real32_T w)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (r.data[i]) {
      w.data[i] = 0.0F;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel78(const
  emxArray_real32_T z, const int32_T ch, const emxArray_real32_T x, int32_T V,
  emxArray_real32_T b_x, int32_T x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_x.data[i] = x.data[i + x_dim0 * ch] - z.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel79(real32_T
  dims_idx_0, emxArray_real32_T a, emxArray_real32_T trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(dims_idx_0)) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    trend.data[i] = 0.0F;
    a.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel8(const
  emxArray_real32_T w, const emxArray_real32_T x, int32_T b_x, emxArray_real32_T
  c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = x.data[i] * w.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel80(const
  real32_T d2scaled, const int32_T m, emxArray_real32_T fv1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fv1.data[m - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel81(const
  real32_T d2scaled, const int32_T m, const real32_T start, int32_T *npages,
  emxArray_real32_T fv1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv1.data[k + 1] = start + static_cast<real32_T>(k + 1);
    fv1.data[(m - k) - 2] = d2scaled - static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel82(const
  real32_T start, const int32_T *npages, emxArray_real32_T fv1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fv1.data[*npages] = start + static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel83(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T fv1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fv1.data[*npages + 1] = d2scaled - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel84(const
  real32_T d2scaled, const real32_T start, const int32_T *npages,
  emxArray_real32_T fv1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    fv1.data[*npages] = (start + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel85(const
  int32_T vlen, int32_T m, emxArray_real32_T fv1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    fv1.data[k] = static_cast<real32_T>(vlen + k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel86(const
  real32_T start, real32_T stop, emxArray_real32_T fv1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(stop) - static_cast<real_T>
    (start));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv1.data[i] = static_cast<real32_T>(static_cast<real_T>(start) +
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel87(const
  emxArray_real32_T w, const emxArray_real32_T fv1, int32_T nx,
  emxArray_real32_T minval)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    minval.data[k] = fminf(w.data[static_cast<int32_T>(fv1.data[k]) - 1], 2.0F);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel88(const
  real32_T d2scaled, const int32_T m, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[m - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel89(const
  real32_T d2scaled, const int32_T m, const real32_T start, int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k + 1] = start + static_cast<real32_T>(k + 1);
    vec.data[(m - k) - 2] = d2scaled - static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel9(const
  emxArray_real32_T w, const emxArray_real32_T x, int32_T b_x, emxArray_real32_T
  c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = x.data[i] * w.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel90(const
  real32_T start, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = start + static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel91(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages + 1] = d2scaled - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel92(const
  real32_T d2scaled, const real32_T start, const int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = (start + d2scaled) / 2.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel93(const
  int32_T vlen, int32_T m, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k] = static_cast<real32_T>(vlen + k);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel94(const
  real32_T start, real32_T stop, emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<real_T>(stop) - static_cast<real_T>
    (start));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    vec.data[i] = static_cast<real32_T>(static_cast<real_T>(start) +
      static_cast<real_T>(i));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel95(const
  real32_T d2scaled, const int32_T m, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[m - 1] = d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel96(const
  real32_T d2scaled, const int32_T m, const real32_T start, int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    vec.data[k + 1] = start + static_cast<real32_T>(k + 1);
    vec.data[(m - k) - 2] = d2scaled - static_cast<real32_T>(k + 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel97(const
  real32_T start, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = start + static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel98(const
  real32_T d2scaled, const int32_T *npages, emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages + 1] = d2scaled - static_cast<real32_T>(*npages);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel99(const
  real32_T d2scaled, const real32_T start, const int32_T *npages,
  emxArray_real32_T vec)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vec.data[*npages] = (start + d2scaled) / 2.0F;
  }
}

static void ec_detrend_once()
{
  mwMemoryManagerInit(256U, 2U, 8U, 2048U);
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

static real32_T emlrt_marshallIn(const mxArray *order, const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real32_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(order), &thisId);
  emlrtDestroyArray(&order);
  return y;
}

static real32_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real32_T y;
  y = b_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *emlrt_marshallOut(const emxArray_real32_T *u)
{
  const mxArray *m;
  const mxArray *y;
  int32_T iv[2];
  int32_T i;
  int32_T loopUpperBound;
  real32_T *pData;
  y = nullptr;
  iv[0] = u->size[0];
  iv[1] = u->size[1];
  m = emlrtCreateNumericArray(2, &iv[0], mxSINGLE_CLASS, mxREAL);
  pData = static_cast<real32_T *>(emlrtMxGetData(m));
  i = 0;
  loopUpperBound = u->size[1];
  for (int32_T b_i{0}; b_i < loopUpperBound; b_i++) {
    int32_T b_loopUpperBound;
    b_loopUpperBound = u->size[0];
    for (int32_T c_i{0}; c_i < b_loopUpperBound; c_i++) {
      pData[i + c_i] = u->data[c_i + u->size[0] * b_i];
    }

    i += u->size[0];
  }

  emlrtAssign(&y, m);
  return y;
}

static void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(boolean_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<boolean_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<boolean_T *>(newData);
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

static void emxEnsureCapacity_ptrdiff_t(emxArray_ptrdiff_t *emxArray, int32_T
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(ptrdiff_t));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<ptrdiff_t *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<ptrdiff_t *>(newData);
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

static void emxFree_boolean_T(emxArray_boolean_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_boolean_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<boolean_T *>(nullptr)) && (*pEmxArray)
        ->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_boolean_T *>(nullptr);
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

static void emxFree_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_ptrdiff_t *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<ptrdiff_t *>(nullptr)) && (*pEmxArray)
        ->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_ptrdiff_t *>(nullptr);
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

static void emxInit_boolean_T(emxArray_boolean_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_boolean_T *emxArray;
  *pEmxArray = static_cast<emxArray_boolean_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_boolean_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_boolean_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<boolean_T *>(nullptr);
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

static void emxInit_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_ptrdiff_t *emxArray;
  *pEmxArray = static_cast<emxArray_ptrdiff_t *>(emlrtMallocEmxArray(sizeof
    (emxArray_ptrdiff_t)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_ptrdiff_t, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<ptrdiff_t *>(nullptr);
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

static void gpuEmxEnsureCapacity_boolean_T(const emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu)
{
  boolean_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) * sizeof
                 (boolean_T));
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
                   (boolean_T));
      cudaMemcpy(newData, gpu->data, static_cast<uint32_T>(actualSizeGpu) *
                 sizeof(boolean_T), cudaMemcpyDeviceToDevice);
      gpu->allocatedSize = cpu->allocatedSize;
      if (gpu->canFreeData) {
        mwCudaFree(gpu->data);
      }

      gpu->canFreeData = true;
      gpu->data = newData;
    }
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

static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu)
{
  int32_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) * sizeof
                 (int32_T));
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
                   (int32_T));
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

static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    mwCudaFree(gpu->data);
  }

  emlrtFreeMex(gpu->size);
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

static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu, const
  emxArray_int32_T *cpu)
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
                 (int32_T));
  }

  cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (int32_T), cudaMemcpyHostToDevice);
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

static void gpuEmxMemcpyGpuToCpu_int32_T(emxArray_int32_T *cpu, emxArray_int32_T
  *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (int32_T), cudaMemcpyDeviceToHost);
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

static void gpuEmxReset_boolean_T(emxArray_boolean_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_boolean_T));
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

static real32_T rt_remf_snf(real32_T u0, real32_T u1)
{
  real32_T y;
  if (std::isnan(u0) || std::isnan(u1) || std::isinf(u0)) {
    y = rtNaNF;
  } else if (std::isinf(u1)) {
    y = u0;
  } else if ((u1 != 0.0F) && (u1 != std::trunc(u1))) {
    real32_T q;
    q = std::abs(u0 / u1);
    if (!(std::abs(q - std::floor(q + 0.5F)) > FLT_EPSILON * q)) {
      y = 0.0F * u0;
    } else {
      y = std::fmod(u0, u1);
    }
  } else {
    y = std::fmod(u0, u1);
  }

  return y;
}

static void times(emxArray_real32_T *in1, const emxArray_real32_T *in2, const
                  emxArray_real32_T *in3)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in3->size[0] == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3->size[0];
  }

  emxEnsureCapacity_real32_T(in1, i, &m_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in3->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[i * stride_0_0] * in3->data[i * stride_1_0];
  }
}

//
// function [x,w] = ec_detrend(x,w,order,thr,nItr,winSz)
void ec_detrend(emxArray_real32_T *cpu_x, emxArray_real32_T *cpu_w, real32_T
                order, real32_T thr, real32_T nItr, real32_T winSz)
{
  static creal32_T cpu_fc{ 0.0F,       // re
    0.0F                               // im
  };

  static creal32_T cpu_fc2{ 0.0F,      // re
    0.0F                               // im
  };

  ptrdiff_t b_ihi_t;
  ptrdiff_t b_ilo_t;
  ptrdiff_t ihi_t;
  ptrdiff_t ilo_t;
  dim3 block;
  dim3 grid;
  emxArray_boolean_T d_gpu_r;
  emxArray_boolean_T gpu_r1;
  emxArray_boolean_T *c_cpu_r;
  emxArray_boolean_T *cpu_r1;
  emxArray_creal32_T b_gpu_W;
  emxArray_creal32_T c_gpu_D;
  emxArray_creal32_T d_gpu_V;
  emxArray_creal32_T d_gpu_W;
  emxArray_creal32_T gpu_D;
  emxArray_creal32_T gpu_V;
  emxArray_creal32_T *b_cpu_W;
  emxArray_creal32_T *c_cpu_D;
  emxArray_creal32_T *c_cpu_V;
  emxArray_creal32_T *cpu_D;
  emxArray_creal32_T *cpu_V;
  emxArray_creal32_T *d_cpu_W;
  emxArray_int32_T b_gpu_ipiv;
  emxArray_int32_T b_gpu_ipiv_t;
  emxArray_int32_T b_gpu_jpvt;
  emxArray_int32_T gpu_ipiv;
  emxArray_int32_T gpu_ipiv_t;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv2;
  emxArray_int32_T gpu_iv6;
  emxArray_int32_T gpu_iv7;
  emxArray_int32_T gpu_iv8;
  emxArray_int32_T gpu_jpvt;
  emxArray_int32_T *b_cpu_ipiv;
  emxArray_int32_T *b_cpu_ipiv_t;
  emxArray_int32_T *b_cpu_jpvt;
  emxArray_int32_T *cpu_ipiv;
  emxArray_int32_T *cpu_ipiv_t;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv2;
  emxArray_int32_T *cpu_iv6;
  emxArray_int32_T *cpu_iv7;
  emxArray_int32_T *cpu_iv8;
  emxArray_int32_T *cpu_jpvt;
  emxArray_ptrdiff_t *b_jpvt_t;
  emxArray_ptrdiff_t *jpvt_t;
  emxArray_real32_T b_gpu_A;
  emxArray_real32_T b_gpu_B;
  emxArray_real32_T b_gpu_D;
  emxArray_real32_T b_gpu_U;
  emxArray_real32_T b_gpu_V;
  emxArray_real32_T b_gpu_Y;
  emxArray_real32_T b_gpu_a;
  emxArray_real32_T b_gpu_absdiff;
  emxArray_real32_T b_gpu_b;
  emxArray_real32_T b_gpu_c;
  emxArray_real32_T b_gpu_d;
  emxArray_real32_T b_gpu_fcnOutput;
  emxArray_real32_T b_gpu_lin;
  emxArray_real32_T b_gpu_r;
  emxArray_real32_T b_gpu_rr;
  emxArray_real32_T b_gpu_tau;
  emxArray_real32_T b_gpu_trend;
  emxArray_real32_T b_gpu_vec;
  emxArray_real32_T b_gpu_vright;
  emxArray_real32_T b_gpu_w;
  emxArray_real32_T b_gpu_wimag;
  emxArray_real32_T b_gpu_wreal;
  emxArray_real32_T b_gpu_x;
  emxArray_real32_T b_gpu_y;
  emxArray_real32_T b_gpu_z;
  emxArray_real32_T c_gpu_A;
  emxArray_real32_T c_gpu_V;
  emxArray_real32_T c_gpu_W;
  emxArray_real32_T c_gpu_a;
  emxArray_real32_T c_gpu_absdiff;
  emxArray_real32_T c_gpu_b;
  emxArray_real32_T c_gpu_c;
  emxArray_real32_T c_gpu_d;
  emxArray_real32_T c_gpu_r;
  emxArray_real32_T c_gpu_tau;
  emxArray_real32_T c_gpu_vec;
  emxArray_real32_T c_gpu_x;
  emxArray_real32_T c_gpu_y;
  emxArray_real32_T c_gpu_z;
  emxArray_real32_T d_gpu_A;
  emxArray_real32_T d_gpu_D;
  emxArray_real32_T d_gpu_a;
  emxArray_real32_T d_gpu_b;
  emxArray_real32_T d_gpu_c;
  emxArray_real32_T d_gpu_tau;
  emxArray_real32_T d_gpu_vec;
  emxArray_real32_T d_gpu_x;
  emxArray_real32_T d_gpu_y;
  emxArray_real32_T e_gpu_A;
  emxArray_real32_T e_gpu_V;
  emxArray_real32_T e_gpu_a;
  emxArray_real32_T e_gpu_b;
  emxArray_real32_T e_gpu_c;
  emxArray_real32_T e_gpu_vec;
  emxArray_real32_T e_gpu_x;
  emxArray_real32_T f_gpu_A;
  emxArray_real32_T f_gpu_V;
  emxArray_real32_T f_gpu_a;
  emxArray_real32_T f_gpu_c;
  emxArray_real32_T f_gpu_vec;
  emxArray_real32_T g_gpu_A;
  emxArray_real32_T g_gpu_a;
  emxArray_real32_T g_gpu_c;
  emxArray_real32_T g_gpu_vec;
  emxArray_real32_T gpu_A;
  emxArray_real32_T gpu_B;
  emxArray_real32_T gpu_U;
  emxArray_real32_T gpu_W;
  emxArray_real32_T gpu_Y;
  emxArray_real32_T gpu_a;
  emxArray_real32_T gpu_absdiff;
  emxArray_real32_T gpu_b;
  emxArray_real32_T gpu_c;
  emxArray_real32_T gpu_d;
  emxArray_real32_T gpu_fcnOutput;
  emxArray_real32_T gpu_fv;
  emxArray_real32_T gpu_fv1;
  emxArray_real32_T gpu_fv10;
  emxArray_real32_T gpu_fv11;
  emxArray_real32_T gpu_fv12;
  emxArray_real32_T gpu_fv13;
  emxArray_real32_T gpu_fv2;
  emxArray_real32_T gpu_fv3;
  emxArray_real32_T gpu_fv4;
  emxArray_real32_T gpu_fv5;
  emxArray_real32_T gpu_fv6;
  emxArray_real32_T gpu_fv7;
  emxArray_real32_T gpu_fv8;
  emxArray_real32_T gpu_fv9;
  emxArray_real32_T gpu_lin;
  emxArray_real32_T gpu_minval;
  emxArray_real32_T gpu_r;
  emxArray_real32_T gpu_rr;
  emxArray_real32_T gpu_tau;
  emxArray_real32_T gpu_trend;
  emxArray_real32_T gpu_vec;
  emxArray_real32_T gpu_vright;
  emxArray_real32_T gpu_w;
  emxArray_real32_T gpu_wimag;
  emxArray_real32_T gpu_wreal;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_y;
  emxArray_real32_T gpu_yy;
  emxArray_real32_T gpu_z;
  emxArray_real32_T h_gpu_A;
  emxArray_real32_T h_gpu_a;
  emxArray_real32_T h_gpu_c;
  emxArray_real32_T h_gpu_vec;
  emxArray_real32_T i_gpu_a;
  emxArray_real32_T i_gpu_c;
  emxArray_real32_T i_gpu_vec;
  emxArray_real32_T j_gpu_a;
  emxArray_real32_T j_gpu_c;
  emxArray_real32_T j_gpu_vec;
  emxArray_real32_T k_gpu_c;
  emxArray_real32_T k_gpu_vec;
  emxArray_real32_T l_gpu_c;
  emxArray_real32_T l_gpu_vec;
  emxArray_real32_T m_gpu_c;
  emxArray_real32_T *b_cpu_A;
  emxArray_real32_T *b_cpu_B;
  emxArray_real32_T *b_cpu_D;
  emxArray_real32_T *b_cpu_U;
  emxArray_real32_T *b_cpu_V;
  emxArray_real32_T *b_cpu_Y;
  emxArray_real32_T *b_cpu_a;
  emxArray_real32_T *b_cpu_absdiff;
  emxArray_real32_T *b_cpu_b;
  emxArray_real32_T *b_cpu_c;
  emxArray_real32_T *b_cpu_d;
  emxArray_real32_T *b_cpu_fcnOutput;
  emxArray_real32_T *b_cpu_lin;
  emxArray_real32_T *b_cpu_r;
  emxArray_real32_T *b_cpu_rr;
  emxArray_real32_T *b_cpu_tau;
  emxArray_real32_T *b_cpu_trend;
  emxArray_real32_T *b_cpu_vec;
  emxArray_real32_T *b_cpu_vright;
  emxArray_real32_T *b_cpu_w;
  emxArray_real32_T *b_cpu_wimag;
  emxArray_real32_T *b_cpu_wreal;
  emxArray_real32_T *b_cpu_x;
  emxArray_real32_T *b_cpu_y;
  emxArray_real32_T *b_cpu_z;
  emxArray_real32_T *b_scale;
  emxArray_real32_T *b_wi;
  emxArray_real32_T *b_wr;
  emxArray_real32_T *c_cpu_A;
  emxArray_real32_T *c_cpu_W;
  emxArray_real32_T *c_cpu_a;
  emxArray_real32_T *c_cpu_absdiff;
  emxArray_real32_T *c_cpu_b;
  emxArray_real32_T *c_cpu_c;
  emxArray_real32_T *c_cpu_d;
  emxArray_real32_T *c_cpu_tau;
  emxArray_real32_T *c_cpu_vec;
  emxArray_real32_T *c_cpu_x;
  emxArray_real32_T *c_cpu_y;
  emxArray_real32_T *c_cpu_z;
  emxArray_real32_T *cpu_A;
  emxArray_real32_T *cpu_B;
  emxArray_real32_T *cpu_U;
  emxArray_real32_T *cpu_W;
  emxArray_real32_T *cpu_Y;
  emxArray_real32_T *cpu_a;
  emxArray_real32_T *cpu_absdiff;
  emxArray_real32_T *cpu_b;
  emxArray_real32_T *cpu_c;
  emxArray_real32_T *cpu_d;
  emxArray_real32_T *cpu_fcnOutput;
  emxArray_real32_T *cpu_fv;
  emxArray_real32_T *cpu_fv1;
  emxArray_real32_T *cpu_fv10;
  emxArray_real32_T *cpu_fv11;
  emxArray_real32_T *cpu_fv12;
  emxArray_real32_T *cpu_fv13;
  emxArray_real32_T *cpu_fv2;
  emxArray_real32_T *cpu_fv3;
  emxArray_real32_T *cpu_fv4;
  emxArray_real32_T *cpu_fv5;
  emxArray_real32_T *cpu_fv6;
  emxArray_real32_T *cpu_fv7;
  emxArray_real32_T *cpu_fv8;
  emxArray_real32_T *cpu_fv9;
  emxArray_real32_T *cpu_lin;
  emxArray_real32_T *cpu_minval;
  emxArray_real32_T *cpu_r;
  emxArray_real32_T *cpu_rr;
  emxArray_real32_T *cpu_tau;
  emxArray_real32_T *cpu_trend;
  emxArray_real32_T *cpu_vec;
  emxArray_real32_T *cpu_vright;
  emxArray_real32_T *cpu_wimag;
  emxArray_real32_T *cpu_wreal;
  emxArray_real32_T *cpu_y;
  emxArray_real32_T *cpu_yy;
  emxArray_real32_T *cpu_z;
  emxArray_real32_T *d_cpu_A;
  emxArray_real32_T *d_cpu_D;
  emxArray_real32_T *d_cpu_V;
  emxArray_real32_T *d_cpu_a;
  emxArray_real32_T *d_cpu_b;
  emxArray_real32_T *d_cpu_c;
  emxArray_real32_T *d_cpu_r;
  emxArray_real32_T *d_cpu_tau;
  emxArray_real32_T *d_cpu_vec;
  emxArray_real32_T *d_cpu_x;
  emxArray_real32_T *d_cpu_y;
  emxArray_real32_T *e_cpu_A;
  emxArray_real32_T *e_cpu_V;
  emxArray_real32_T *e_cpu_a;
  emxArray_real32_T *e_cpu_b;
  emxArray_real32_T *e_cpu_c;
  emxArray_real32_T *e_cpu_vec;
  emxArray_real32_T *e_cpu_x;
  emxArray_real32_T *f_cpu_A;
  emxArray_real32_T *f_cpu_V;
  emxArray_real32_T *f_cpu_a;
  emxArray_real32_T *f_cpu_c;
  emxArray_real32_T *f_cpu_vec;
  emxArray_real32_T *g_cpu_A;
  emxArray_real32_T *g_cpu_a;
  emxArray_real32_T *g_cpu_c;
  emxArray_real32_T *g_cpu_vec;
  emxArray_real32_T *h_cpu_A;
  emxArray_real32_T *h_cpu_a;
  emxArray_real32_T *h_cpu_c;
  emxArray_real32_T *h_cpu_vec;
  emxArray_real32_T *i_cpu_a;
  emxArray_real32_T *i_cpu_c;
  emxArray_real32_T *i_cpu_vec;
  emxArray_real32_T *j_cpu_a;
  emxArray_real32_T *j_cpu_c;
  emxArray_real32_T *j_cpu_vec;
  emxArray_real32_T *k_cpu_c;
  emxArray_real32_T *k_cpu_vec;
  emxArray_real32_T *l_cpu_c;
  emxArray_real32_T *l_cpu_vec;
  emxArray_real32_T *m_cpu_c;
  emxArray_real32_T *scale;
  emxArray_real32_T *wi;
  emxArray_real32_T *wr;
  creal32_T *gpu_fc;
  creal32_T *gpu_fc2;
  int32_T V[2];
  int32_T b_cpu_info;
  int32_T cpu_info;
  int32_T cpu_npages;
  int32_T i;
  int32_T *b_gpu_info;
  int32_T *gpu_info;
  int32_T *gpu_npages;
  real32_T abnrm;
  real32_T d2scaled;
  real32_T rconde;
  real32_T rcondv;
  uint32_T sz[2];
  boolean_T A_dirtyOnCpu;
  boolean_T A_dirtyOnGpu;
  boolean_T D_dirtyOnCpu;
  boolean_T D_dirtyOnGpu;
  boolean_T U_dirtyOnCpu;
  boolean_T U_dirtyOnGpu;
  boolean_T V_dirtyOnCpu;
  boolean_T V_dirtyOnGpu;
  boolean_T W_dirtyOnCpu;
  boolean_T W_dirtyOnGpu;
  boolean_T Y_dirtyOnCpu;
  boolean_T Y_dirtyOnGpu;
  boolean_T a_dirtyOnCpu;
  boolean_T a_dirtyOnGpu;
  boolean_T b_A_dirtyOnCpu;
  boolean_T b_A_dirtyOnGpu;
  boolean_T b_D_dirtyOnCpu;
  boolean_T b_D_dirtyOnGpu;
  boolean_T b_U_dirtyOnCpu;
  boolean_T b_U_dirtyOnGpu;
  boolean_T b_V_dirtyOnCpu;
  boolean_T b_V_dirtyOnGpu;
  boolean_T b_W_dirtyOnCpu;
  boolean_T b_W_dirtyOnGpu;
  boolean_T b_Y_dirtyOnCpu;
  boolean_T b_Y_dirtyOnGpu;
  boolean_T b_a_dirtyOnGpu;
  boolean_T b_b_dirtyOnCpu;
  boolean_T b_c_dirtyOnCpu;
  boolean_T b_c_dirtyOnGpu;
  boolean_T b_d_dirtyOnCpu;
  boolean_T b_d_dirtyOnGpu;
  boolean_T b_dirtyOnCpu;
  boolean_T b_dirtyOnGpu;
  boolean_T b_fcnOutput_dirtyOnGpu;
  boolean_T b_ipiv_dirtyOnGpu;
  boolean_T b_jpvt_dirtyOnCpu;
  boolean_T b_jpvt_dirtyOnGpu;
  boolean_T b_lin_dirtyOnCpu;
  boolean_T b_lin_dirtyOnGpu;
  boolean_T b_r_dirtyOnGpu;
  boolean_T b_rr_dirtyOnCpu;
  boolean_T b_rr_dirtyOnGpu;
  boolean_T b_tau_dirtyOnCpu;
  boolean_T b_tau_dirtyOnGpu;
  boolean_T b_vec_dirtyOnCpu;
  boolean_T b_vec_dirtyOnGpu;
  boolean_T b_vright_dirtyOnCpu;
  boolean_T b_w_dirtyOnGpu;
  boolean_T b_wimag_dirtyOnCpu;
  boolean_T b_wreal_dirtyOnCpu;
  boolean_T b_x_dirtyOnCpu;
  boolean_T b_x_dirtyOnGpu;
  boolean_T b_y_dirtyOnGpu;
  boolean_T b_z_dirtyOnCpu;
  boolean_T b_z_dirtyOnGpu;
  boolean_T c_A_dirtyOnGpu;
  boolean_T c_D_dirtyOnCpu;
  boolean_T c_D_dirtyOnGpu;
  boolean_T c_W_dirtyOnGpu;
  boolean_T c_a_dirtyOnGpu;
  boolean_T c_b_dirtyOnCpu;
  boolean_T c_c_dirtyOnCpu;
  boolean_T c_c_dirtyOnGpu;
  boolean_T c_d_dirtyOnCpu;
  boolean_T c_d_dirtyOnGpu;
  boolean_T c_dirtyOnCpu;
  boolean_T c_dirtyOnGpu;
  boolean_T c_tau_dirtyOnGpu;
  boolean_T c_vec_dirtyOnCpu;
  boolean_T c_vec_dirtyOnGpu;
  boolean_T c_x_dirtyOnGpu;
  boolean_T c_z_dirtyOnGpu;
  boolean_T d_A_dirtyOnGpu;
  boolean_T d_D_dirtyOnCpu;
  boolean_T d_D_dirtyOnGpu;
  boolean_T d_W_dirtyOnGpu;
  boolean_T d_c_dirtyOnCpu;
  boolean_T d_c_dirtyOnGpu;
  boolean_T d_dirtyOnCpu;
  boolean_T d_dirtyOnGpu;
  boolean_T d_tau_dirtyOnGpu;
  boolean_T d_vec_dirtyOnCpu;
  boolean_T d_vec_dirtyOnGpu;
  boolean_T d_x_dirtyOnGpu;
  boolean_T e_c_dirtyOnCpu;
  boolean_T e_c_dirtyOnGpu;
  boolean_T e_vec_dirtyOnCpu;
  boolean_T e_vec_dirtyOnGpu;
  boolean_T f_c_dirtyOnCpu;
  boolean_T f_c_dirtyOnGpu;
  boolean_T f_vec_dirtyOnCpu;
  boolean_T f_vec_dirtyOnGpu;
  boolean_T fc_dirtyOnGpu;
  boolean_T fcnOutput_dirtyOnGpu;
  boolean_T fv10_dirtyOnGpu;
  boolean_T fv11_dirtyOnCpu;
  boolean_T fv11_dirtyOnGpu;
  boolean_T fv12_dirtyOnGpu;
  boolean_T fv13_dirtyOnGpu;
  boolean_T fv1_dirtyOnCpu;
  boolean_T fv1_dirtyOnGpu;
  boolean_T fv2_dirtyOnGpu;
  boolean_T fv3_dirtyOnGpu;
  boolean_T fv4_dirtyOnCpu;
  boolean_T fv4_dirtyOnGpu;
  boolean_T fv6_dirtyOnCpu;
  boolean_T fv6_dirtyOnGpu;
  boolean_T fv7_dirtyOnCpu;
  boolean_T fv7_dirtyOnGpu;
  boolean_T fv8_dirtyOnGpu;
  boolean_T fv9_dirtyOnGpu;
  boolean_T g_c_dirtyOnCpu;
  boolean_T g_c_dirtyOnGpu;
  boolean_T g_vec_dirtyOnCpu;
  boolean_T g_vec_dirtyOnGpu;
  boolean_T h_c_dirtyOnCpu;
  boolean_T h_c_dirtyOnGpu;
  boolean_T h_vec_dirtyOnCpu;
  boolean_T h_vec_dirtyOnGpu;
  boolean_T i_c_dirtyOnCpu;
  boolean_T i_c_dirtyOnGpu;
  boolean_T i_vec_dirtyOnCpu;
  boolean_T i_vec_dirtyOnGpu;
  boolean_T ipiv_dirtyOnGpu;
  boolean_T iv2_dirtyOnCpu;
  boolean_T iv6_dirtyOnGpu;
  boolean_T iv7_dirtyOnGpu;
  boolean_T iv8_dirtyOnGpu;
  boolean_T iv_dirtyOnCpu;
  boolean_T j_c_dirtyOnCpu;
  boolean_T j_c_dirtyOnGpu;
  boolean_T j_vec_dirtyOnCpu;
  boolean_T j_vec_dirtyOnGpu;
  boolean_T jpvt_dirtyOnCpu;
  boolean_T jpvt_dirtyOnGpu;
  boolean_T k_c_dirtyOnCpu;
  boolean_T k_c_dirtyOnGpu;
  boolean_T k_vec_dirtyOnCpu;
  boolean_T k_vec_dirtyOnGpu;
  boolean_T l_vec_dirtyOnCpu;
  boolean_T l_vec_dirtyOnGpu;
  boolean_T lin_dirtyOnCpu;
  boolean_T lin_dirtyOnGpu;
  boolean_T minval_dirtyOnGpu;
  boolean_T r_dirtyOnCpu;
  boolean_T r_dirtyOnGpu;
  boolean_T rr_dirtyOnCpu;
  boolean_T rr_dirtyOnGpu;
  boolean_T tau_dirtyOnCpu;
  boolean_T tau_dirtyOnGpu;
  boolean_T trend_dirtyOnCpu;
  boolean_T trend_dirtyOnGpu;
  boolean_T vec_dirtyOnCpu;
  boolean_T vec_dirtyOnGpu;
  boolean_T vright_dirtyOnCpu;
  boolean_T w_dirtyOnCpu;
  boolean_T w_dirtyOnGpu;
  boolean_T wimag_dirtyOnCpu;
  boolean_T wreal_dirtyOnCpu;
  boolean_T x_dirtyOnCpu;
  boolean_T x_dirtyOnGpu;
  boolean_T y_dirtyOnGpu;
  boolean_T yy_dirtyOnCpu;
  boolean_T yy_dirtyOnGpu;
  boolean_T z_dirtyOnCpu;
  boolean_T z_dirtyOnGpu;
  mwCudaMalloc(&gpu_info, 4UL);
  mwCudaMalloc(&b_gpu_info, 4UL);
  mwCudaMalloc(&gpu_npages, 4UL);
  gpuEmxReset_real32_T(&b_gpu_trend);
  gpuEmxReset_real32_T(&e_gpu_x);
  gpuEmxReset_real32_T(&g_gpu_a);
  gpuEmxReset_real32_T(&c_gpu_V);
  gpuEmxReset_real32_T(&b_gpu_r);
  gpuEmxReset_real32_T(&f_gpu_V);
  gpuEmxReset_boolean_T(&gpu_r1);
  gpuEmxReset_boolean_T(&d_gpu_r);
  gpuEmxReset_real32_T(&b_gpu_absdiff);
  gpuEmxReset_real32_T(&b_gpu_y);
  gpuEmxReset_real32_T(&b_gpu_d);
  gpuEmxReset_real32_T(&h_gpu_c);
  gpuEmxReset_real32_T(&g_gpu_c);
  gpuEmxReset_real32_T(&gpu_fv13);
  gpuEmxReset_real32_T(&f_gpu_c);
  gpuEmxReset_real32_T(&gpu_fv12);
  gpuEmxReset_int32_T(&gpu_iv8);
  gpuEmxReset_real32_T(&h_gpu_vec);
  gpuEmxReset_real32_T(&gpu_fv11);
  gpuEmxReset_real32_T(&f_gpu_a);
  gpuEmxReset_real32_T(&gpu_fv10);
  gpuEmxReset_real32_T(&f_gpu_vec);
  gpuEmxReset_real32_T(&g_gpu_vec);
  gpuEmxReset_int32_T(&gpu_iv7);
  gpuEmxReset_real32_T(&e_gpu_vec);
  gpuEmxReset_real32_T(&e_gpu_a);
  gpuEmxReset_real32_T(&d_gpu_vec);
  gpuEmxReset_int32_T(&gpu_iv6);
  gpuEmxReset_real32_T(&c_gpu_vec);
  gpuEmxReset_real32_T(&l_gpu_vec);
  gpuEmxReset_real32_T(&c_gpu_b);
  gpuEmxReset_real32_T(&i_gpu_vec);
  gpuEmxReset_real32_T(&j_gpu_vec);
  gpuEmxReset_real32_T(&k_gpu_vec);
  gpuEmxReset_real32_T(&gpu_yy);
  gpuEmxReset_real32_T(&gpu_absdiff);
  gpuEmxReset_real32_T(&gpu_d);
  gpuEmxReset_real32_T(&e_gpu_c);
  gpuEmxReset_real32_T(&gpu_z);
  gpuEmxReset_real32_T(&gpu_fv9);
  gpuEmxReset_real32_T(&gpu_tau);
  gpuEmxReset_int32_T(&gpu_ipiv_t);
  gpuEmxReset_int32_T(&gpu_jpvt);
  gpuEmxReset_real32_T(&b_gpu_b);
  gpuEmxReset_real32_T(&d_gpu_c);
  gpuEmxReset_int32_T(&gpu_ipiv);
  gpuEmxReset_real32_T(&gpu_B);
  gpuEmxReset_real32_T(&c_gpu_A);
  gpuEmxReset_real32_T(&gpu_Y);
  gpuEmxReset_real32_T(&gpu_vright);
  gpuEmxReset_real32_T(&d_gpu_a);
  gpuEmxReset_real32_T(&b_gpu_A);
  gpuEmxReset_real32_T(&gpu_wimag);
  gpuEmxReset_real32_T(&b_gpu_tau);
  gpuEmxReset_real32_T(&gpu_wreal);
  gpuEmxReset_creal32_T(&b_gpu_W);
  gpuEmxReset_real32_T(&c_gpu_a);
  gpuEmxReset_real32_T(&gpu_U);
  gpuEmxReset_real32_T(&gpu_b);
  gpuEmxReset_real32_T(&c_gpu_absdiff);
  gpuEmxReset_real32_T(&d_gpu_A);
  gpuEmxReset_real32_T(&d_gpu_y);
  gpuEmxReset_real32_T(&gpu_W);
  gpuEmxReset_int32_T(&gpu_iv2);
  gpuEmxReset_real32_T(&c_gpu_d);
  gpuEmxReset_real32_T(&m_gpu_c);
  gpuEmxReset_real32_T(&b_gpu_z);
  gpuEmxReset_real32_T(&b_gpu_D);
  gpuEmxReset_real32_T(&gpu_fv8);
  gpuEmxReset_real32_T(&gpu_fcnOutput);
  gpuEmxReset_real32_T(&b_gpu_V);
  gpuEmxReset_creal32_T(&gpu_D);
  gpuEmxReset_real32_T(&c_gpu_tau);
  gpuEmxReset_creal32_T(&gpu_V);
  gpuEmxReset_int32_T(&b_gpu_ipiv_t);
  gpuEmxReset_int32_T(&b_gpu_jpvt);
  gpuEmxReset_real32_T(&e_gpu_b);
  gpuEmxReset_real32_T(&l_gpu_c);
  gpuEmxReset_int32_T(&b_gpu_ipiv);
  gpuEmxReset_real32_T(&b_gpu_B);
  gpuEmxReset_real32_T(&g_gpu_A);
  gpuEmxReset_real32_T(&b_gpu_Y);
  gpuEmxReset_real32_T(&b_gpu_a);
  gpuEmxReset_real32_T(&gpu_A);
  gpuEmxReset_real32_T(&gpu_rr);
  gpuEmxReset_real32_T(&b_gpu_vright);
  gpuEmxReset_real32_T(&j_gpu_a);
  gpuEmxReset_real32_T(&f_gpu_A);
  gpuEmxReset_real32_T(&b_gpu_wimag);
  gpuEmxReset_real32_T(&d_gpu_tau);
  gpuEmxReset_real32_T(&b_gpu_wreal);
  gpuEmxReset_creal32_T(&d_gpu_W);
  gpuEmxReset_real32_T(&i_gpu_a);
  gpuEmxReset_real32_T(&b_gpu_U);
  gpuEmxReset_real32_T(&d_gpu_b);
  gpuEmxReset_real32_T(&gpu_y);
  gpuEmxReset_real32_T(&c_gpu_c);
  gpuEmxReset_real32_T(&h_gpu_A);
  gpuEmxReset_real32_T(&gpu_fv7);
  gpuEmxReset_real32_T(&c_gpu_W);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_real32_T(&b_gpu_c);
  gpuEmxReset_real32_T(&d_gpu_D);
  gpuEmxReset_real32_T(&b_gpu_fcnOutput);
  gpuEmxReset_real32_T(&e_gpu_V);
  gpuEmxReset_creal32_T(&c_gpu_D);
  gpuEmxReset_creal32_T(&d_gpu_V);
  gpuEmxReset_real32_T(&gpu_c);
  gpuEmxReset_real32_T(&h_gpu_a);
  gpuEmxReset_real32_T(&e_gpu_A);
  gpuEmxReset_real32_T(&b_gpu_rr);
  gpuEmxReset_real32_T(&gpu_fv6);
  gpuEmxReset_real32_T(&gpu_fv5);
  gpuEmxReset_real32_T(&c_gpu_y);
  gpuEmxReset_real32_T(&gpu_lin);
  gpuEmxReset_real32_T(&k_gpu_c);
  gpuEmxReset_real32_T(&gpu_r);
  gpuEmxReset_real32_T(&gpu_fv4);
  gpuEmxReset_real32_T(&j_gpu_c);
  gpuEmxReset_real32_T(&gpu_fv3);
  gpuEmxReset_real32_T(&gpu_fv2);
  gpuEmxReset_real32_T(&b_gpu_vec);
  gpuEmxReset_real32_T(&gpu_vec);
  gpuEmxReset_real32_T(&i_gpu_c);
  gpuEmxReset_real32_T(&gpu_minval);
  gpuEmxReset_real32_T(&gpu_fv1);
  gpuEmxReset_real32_T(&c_gpu_z);
  gpuEmxReset_real32_T(&gpu_fv);
  gpuEmxReset_real32_T(&b_gpu_lin);
  gpuEmxReset_real32_T(&c_gpu_r);
  gpuEmxReset_real32_T(&gpu_a);
  gpuEmxReset_real32_T(&gpu_trend);
  gpuEmxReset_real32_T(&d_gpu_x);
  gpuEmxReset_real32_T(&b_gpu_w);
  gpuEmxReset_real32_T(&b_gpu_x);
  gpuEmxReset_real32_T(&c_gpu_x);
  mwCudaMalloc(&gpu_fc, 8UL);
  mwCudaMalloc(&gpu_fc2, 8UL);
  gpuEmxReset_real32_T(&gpu_w);
  gpuEmxReset_real32_T(&gpu_x);
  c_d_dirtyOnGpu = false;
  c_d_dirtyOnCpu = false;
  k_c_dirtyOnGpu = false;
  k_c_dirtyOnCpu = false;
  j_c_dirtyOnGpu = false;
  j_c_dirtyOnCpu = false;
  fv13_dirtyOnGpu = false;
  i_c_dirtyOnGpu = false;
  i_c_dirtyOnCpu = false;
  fv12_dirtyOnGpu = false;
  iv8_dirtyOnGpu = false;
  l_vec_dirtyOnGpu = false;
  l_vec_dirtyOnCpu = false;
  fv11_dirtyOnGpu = false;
  fv11_dirtyOnCpu = false;
  c_a_dirtyOnGpu = false;
  fv10_dirtyOnGpu = false;
  k_vec_dirtyOnGpu = false;
  k_vec_dirtyOnCpu = false;
  j_vec_dirtyOnGpu = false;
  j_vec_dirtyOnCpu = false;
  iv7_dirtyOnGpu = false;
  i_vec_dirtyOnGpu = false;
  i_vec_dirtyOnCpu = false;
  b_a_dirtyOnGpu = false;
  h_vec_dirtyOnGpu = false;
  h_vec_dirtyOnCpu = false;
  iv6_dirtyOnGpu = false;
  g_vec_dirtyOnGpu = false;
  g_vec_dirtyOnCpu = false;
  f_vec_dirtyOnGpu = false;
  f_vec_dirtyOnCpu = false;
  b_dirtyOnGpu = false;
  c_b_dirtyOnCpu = false;
  e_vec_dirtyOnGpu = false;
  e_vec_dirtyOnCpu = false;
  d_vec_dirtyOnGpu = false;
  d_vec_dirtyOnCpu = false;
  c_vec_dirtyOnGpu = false;
  c_vec_dirtyOnCpu = false;
  yy_dirtyOnGpu = false;
  yy_dirtyOnCpu = false;
  b_d_dirtyOnGpu = false;
  b_d_dirtyOnCpu = false;
  h_c_dirtyOnGpu = false;
  h_c_dirtyOnCpu = false;
  c_z_dirtyOnGpu = false;
  b_z_dirtyOnCpu = false;
  fv9_dirtyOnGpu = false;
  d_tau_dirtyOnGpu = false;
  b_jpvt_dirtyOnGpu = false;
  b_jpvt_dirtyOnCpu = false;
  b_ipiv_dirtyOnGpu = false;
  d_A_dirtyOnGpu = false;
  b_Y_dirtyOnGpu = false;
  b_Y_dirtyOnCpu = false;
  b_vright_dirtyOnCpu = false;
  b_wimag_dirtyOnCpu = false;
  c_tau_dirtyOnGpu = false;
  b_tau_dirtyOnCpu = false;
  b_wreal_dirtyOnCpu = false;
  d_W_dirtyOnGpu = false;
  b_U_dirtyOnGpu = false;
  b_U_dirtyOnCpu = false;
  b_b_dirtyOnCpu = false;
  c_W_dirtyOnGpu = false;
  b_W_dirtyOnCpu = false;
  iv2_dirtyOnCpu = false;
  d_dirtyOnGpu = false;
  d_dirtyOnCpu = false;
  g_c_dirtyOnGpu = false;
  g_c_dirtyOnCpu = false;
  b_z_dirtyOnGpu = false;
  z_dirtyOnCpu = false;
  d_D_dirtyOnGpu = false;
  d_D_dirtyOnCpu = false;
  fv8_dirtyOnGpu = false;
  b_fcnOutput_dirtyOnGpu = false;
  c_D_dirtyOnGpu = false;
  c_D_dirtyOnCpu = false;
  b_tau_dirtyOnGpu = false;
  b_V_dirtyOnGpu = false;
  b_V_dirtyOnCpu = false;
  jpvt_dirtyOnGpu = false;
  jpvt_dirtyOnCpu = false;
  ipiv_dirtyOnGpu = false;
  c_A_dirtyOnGpu = false;
  Y_dirtyOnGpu = false;
  Y_dirtyOnCpu = false;
  b_A_dirtyOnGpu = false;
  b_A_dirtyOnCpu = false;
  b_rr_dirtyOnGpu = false;
  b_rr_dirtyOnCpu = false;
  vright_dirtyOnCpu = false;
  wimag_dirtyOnCpu = false;
  tau_dirtyOnGpu = false;
  tau_dirtyOnCpu = false;
  wreal_dirtyOnCpu = false;
  b_W_dirtyOnGpu = false;
  U_dirtyOnGpu = false;
  U_dirtyOnCpu = false;
  b_dirtyOnCpu = false;
  b_y_dirtyOnGpu = false;
  f_c_dirtyOnGpu = false;
  f_c_dirtyOnCpu = false;
  fv7_dirtyOnGpu = false;
  fv7_dirtyOnCpu = false;
  W_dirtyOnGpu = false;
  W_dirtyOnCpu = false;
  iv_dirtyOnCpu = false;
  e_c_dirtyOnGpu = false;
  e_c_dirtyOnCpu = false;
  b_D_dirtyOnGpu = false;
  b_D_dirtyOnCpu = false;
  fcnOutput_dirtyOnGpu = false;
  D_dirtyOnGpu = false;
  D_dirtyOnCpu = false;
  V_dirtyOnGpu = false;
  V_dirtyOnCpu = false;
  d_c_dirtyOnGpu = false;
  d_c_dirtyOnCpu = false;
  A_dirtyOnGpu = false;
  A_dirtyOnCpu = false;
  rr_dirtyOnGpu = false;
  rr_dirtyOnCpu = false;
  fv6_dirtyOnGpu = false;
  fv6_dirtyOnCpu = false;
  y_dirtyOnGpu = false;
  b_lin_dirtyOnGpu = false;
  b_lin_dirtyOnCpu = false;
  c_c_dirtyOnGpu = false;
  c_c_dirtyOnCpu = false;
  b_r_dirtyOnGpu = false;
  r_dirtyOnCpu = false;
  fv4_dirtyOnGpu = false;
  fv4_dirtyOnCpu = false;
  b_c_dirtyOnGpu = false;
  b_c_dirtyOnCpu = false;
  fv3_dirtyOnGpu = false;
  fv2_dirtyOnGpu = false;
  b_vec_dirtyOnGpu = false;
  b_vec_dirtyOnCpu = false;
  vec_dirtyOnGpu = false;
  vec_dirtyOnCpu = false;
  c_dirtyOnGpu = false;
  c_dirtyOnCpu = false;
  minval_dirtyOnGpu = false;
  fv1_dirtyOnGpu = false;
  fv1_dirtyOnCpu = false;
  z_dirtyOnGpu = false;
  lin_dirtyOnGpu = false;
  lin_dirtyOnCpu = false;
  r_dirtyOnGpu = false;
  a_dirtyOnGpu = false;
  a_dirtyOnCpu = false;
  trend_dirtyOnGpu = false;
  trend_dirtyOnCpu = false;
  d_x_dirtyOnGpu = false;
  b_x_dirtyOnCpu = false;
  b_w_dirtyOnGpu = false;
  c_x_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  w_dirtyOnCpu = true;
  w_dirtyOnGpu = false;
  x_dirtyOnCpu = true;
  x_dirtyOnGpu = false;
  cudaMemcpy(gpu_fc, &cpu_fc, 8UL, cudaMemcpyHostToDevice);
  cudaMemcpy(gpu_fc2, &cpu_fc2, 8UL, cudaMemcpyHostToDevice);
  ec_detrend_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_fc, gpu_fc2);
  fc_dirtyOnGpu = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  //  Robust detrending - wrapper for GPU processing (CUDA source code)
  //
  //  INPUTS:
  //     see 'input validation' section below
  //  OUTPUTS:
  //     y = detrended data
  //     w = updated weights
  //     r = basis matrix used
  //
  //  This code was adapted from NoiseTools (audition.ens.fr/adc/NoiseTools)
  //
  //  Modified by: Kevin Tan, 2022 (kevmtan.github.io)
  //     - Added GPU support
  //     - Replaced bsxfun with implicit expansion operators (much faster)
  //     - Miscellaneous compute & readability enhancements
  //  Main
  // 'ec_detrend:19' coder.gpu.kernelfun;
  //  trigger CUDA kernel generation
  // 'ec_detrend:20' if order<1
  if (order < 1.0F) {
    // 'ec_detrend:20' ;
    // 'ec_detrend:20' order=ones(1,"like",order);
    order = 1.0F;
  }

  // 'ec_detrend:21' if thr<1
  if (thr < 1.0F) {
    // 'ec_detrend:21' ;
    // 'ec_detrend:21' thr=ones(1,"like",thr);
    thr = 1.0F;
  }

  // 'ec_detrend:22' if nItr<1
  if (nItr < 1.0F) {
    // 'ec_detrend:22' ;
    // 'ec_detrend:22' nItr=ones(1,"like",nItr);
    nItr = 1.0F;
  }

  //  Detrend per channel
  // 'ec_detrend:25' nChs = size(x,2);
  // 'ec_detrend:26' for ch = 1:nChs
  i = cpu_x->size[1];
  emxInit_real32_T(&b_cpu_x, 1, &b_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_x, 1, &ce_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_w, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_x, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_trend, 2, &h_emlrtRTEI, true);
  emxInit_real32_T(&cpu_a, 1, &de_emlrtRTEI, true);
  emxInit_real32_T(&cpu_r, 2, &ee_emlrtRTEI, true);
  emxInit_real32_T(&cpu_lin, 2, &fe_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv, 2, &ge_emlrtRTEI, true);
  emxInit_real32_T(&cpu_z, 2, &he_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv1, 2, &ie_emlrtRTEI, true);
  emxInit_real32_T(&cpu_minval, 1, &je_emlrtRTEI, true);
  emxInit_real32_T(&cpu_c, 1, &ke_emlrtRTEI, true);
  emxInit_real32_T(&cpu_vec, 2, &le_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_vec, 2, &me_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv2, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv3, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_c, 1, &ke_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv4, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_r, 2, &ee_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_c, 2, &ke_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_lin, 2, &fe_emlrtRTEI, true);
  emxInit_real32_T(&cpu_y, 2, &ne_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv5, 2, &ge_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv6, 2, &lc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_rr, 2, &v_emlrtRTEI, true);
  emxInit_real32_T(&cpu_A, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_a, 2, &w_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_c, 1, &ke_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_V, 2, &oe_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_D, 2, &pe_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_V, 2, &oe_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fcnOutput, 2, &db_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_D, 1, &pe_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_c, 1, &ke_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &qe_emlrtRTEI, true);
  emxInit_real32_T(&cpu_W, 1, &vb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv7, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_A, 2, &mc_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_c, 2, &ke_emlrtRTEI, true);
  emxInit_real32_T(&scale, 1, &re_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_y, 2, &ne_emlrtRTEI, true);
  emxInit_real32_T(&cpu_b, 2, &se_emlrtRTEI, true);
  emxInit_real32_T(&cpu_U, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_a, 2, &pc_emlrtRTEI, true);
  emxInit_creal32_T(&b_cpu_W, 1, &vb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_wreal, 1, &te_emlrtRTEI, true);
  emxInit_real32_T(&cpu_tau, 1, &vb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_wimag, 1, &ue_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_A, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_a, 2, &qc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_vright, 2, &ve_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_rr, 2, &v_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_A, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&wr, 2, &we_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_a, 2, &w_emlrtRTEI, true);
  emxInit_real32_T(&wi, 2, &xe_emlrtRTEI, true);
  emxInit_real32_T(&cpu_Y, 1, &ye_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_A, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_B, 1, &vc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&g_cpu_c, 1, &af_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_b, 1, &wc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_jpvt, 2, &vb_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv_t, 1, &bf_emlrtRTEI, true);
  emxInit_creal32_T(&c_cpu_V, 2, &oe_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_tau, 1, &vb_emlrtRTEI, true);
  emxInit_creal32_T(&c_cpu_D, 2, &pe_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &bd_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_V, 2, &oe_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_fcnOutput, 2, &db_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv8, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_D, 1, &pe_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_z, 1, &dd_emlrtRTEI, true);
  emxInit_real32_T(&h_cpu_c, 2, &cf_emlrtRTEI, true);
  emxInit_real32_T(&cpu_d, 2, &fd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv2, 1, &qe_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_W, 1, &vb_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_y, 2, &jd_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_A, 2, &mc_emlrtRTEI, true);
  emxInit_real32_T(&b_scale, 1, &re_emlrtRTEI, true);
  emxInit_real32_T(&cpu_absdiff, 1, &df_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_b, 2, &se_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_U, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_a, 2, &pc_emlrtRTEI, true);
  emxInit_creal32_T(&d_cpu_W, 1, &vb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_wreal, 1, &te_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_tau, 1, &vb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_wimag, 1, &ue_emlrtRTEI, true);
  emxInit_real32_T(&g_cpu_A, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&g_cpu_a, 2, &qc_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_vright, 2, &ve_emlrtRTEI, true);
  emxInit_real32_T(&b_wr, 2, &we_emlrtRTEI, true);
  emxInit_real32_T(&b_wi, 2, &xe_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_Y, 1, &ye_emlrtRTEI, true);
  emxInit_real32_T(&h_cpu_A, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_B, 1, &vc_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_ipiv, 2, &vb_emlrtRTEI, true);
  emxInit_real32_T(&i_cpu_c, 1, &af_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_b, 1, &wc_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_jpvt, 2, &vb_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_ipiv_t, 1, &bf_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_tau, 1, &vb_emlrtRTEI, true);
  emxInit_ptrdiff_t(&b_jpvt_t, 1, &bd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv9, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_z, 1, &dd_emlrtRTEI, true);
  emxInit_real32_T(&j_cpu_c, 2, &cf_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_d, 2, &fd_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_absdiff, 1, &df_emlrtRTEI, true);
  emxInit_real32_T(&cpu_yy, 2, &kd_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_vec, 2, &ef_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_vec, 2, &ff_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_vec, 2, &gf_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_b, 1, &ld_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_vec, 2, &hf_emlrtRTEI, true);
  emxInit_real32_T(&g_cpu_vec, 2, &od_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv6, 1, &if_emlrtRTEI, true);
  emxInit_real32_T(&h_cpu_vec, 2, &jf_emlrtRTEI, true);
  emxInit_real32_T(&h_cpu_a, 2, &pd_emlrtRTEI, true);
  emxInit_real32_T(&i_cpu_vec, 2, &qd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv7, 1, &kf_emlrtRTEI, true);
  emxInit_real32_T(&j_cpu_vec, 2, &lf_emlrtRTEI, true);
  emxInit_real32_T(&k_cpu_vec, 2, &mf_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv10, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&i_cpu_a, 2, &rd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv11, 2, &nf_emlrtRTEI, true);
  emxInit_real32_T(&l_cpu_vec, 2, &td_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv8, 1, &of_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv12, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&k_cpu_c, 2, &vd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv13, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&l_cpu_c, 2, &xd_emlrtRTEI, true);
  emxInit_real32_T(&m_cpu_c, 2, &pf_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_d, 2, &ae_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_y, 2, &be_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_absdiff, 1, &df_emlrtRTEI, true);
  emxInit_boolean_T(&c_cpu_r, 2, &jd_emlrtRTEI, true);
  emxInit_boolean_T(&cpu_r1, 2, &be_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_V, 2, &xb_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_r, 2, &lc_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_V, 2, &xb_emlrtRTEI, true);
  emxInit_real32_T(&j_cpu_a, 1, &lc_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_x, 2, &vd_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_trend, 2, &xd_emlrtRTEI, true);
  for (int32_T ch{0}; ch < i; ch++) {
    int32_T x[1];
    int32_T b_i;
    int32_T i1;
    int32_T m;
    int32_T n;
    int32_T na;
    boolean_T validLaunchParams;

    // 'ec_detrend:27' [x(:,ch),w(:,ch)] = detrendCh_lfn(x(:,ch),w(:,ch),order,thr,nItr,winSz);
    i1 = cpu_x->size[0];
    b_i = b_cpu_x->size[0];
    b_cpu_x->size[0] = i1;
    emxEnsureCapacity_real32_T(b_cpu_x, b_i, &b_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(b_cpu_x, &c_gpu_x);

    //  % Run detrend
    //  if ~nnz(winSz)
    //      % Standard detrending (trend fit to entire data)
    //      [x,w] = detrend_lfn(x,w,order,thr,nItr);
    //  else
    //      % Overlapping window detrending
    //      [x,w] = detrendWin_lfn(x,w,order,thr,nItr,winSz);
    //  end
    // %%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    // 'ec_detrend:46' x=squeeze(x);
    b_i = c_cpu_x->size[0];
    c_cpu_x->size[0] = i1;
    emxEnsureCapacity_real32_T(c_cpu_x, b_i, &c_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(c_cpu_x, &b_gpu_x);

    // 'ec_detrend:46' w=squeeze(w);
    b_i = b_cpu_w->size[0];
    b_cpu_w->size[0] = cpu_w->size[0];
    emxEnsureCapacity_real32_T(b_cpu_w, b_i, &c_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(b_cpu_w, &b_gpu_w);
    na = cpu_x->size[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (w_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_w, cpu_w);
      }

      w_dirtyOnCpu = false;
      if (x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
      }

      x_dirtyOnCpu = false;
      ec_detrend_kernel2<<<grid, block>>>(gpu_w, ch, gpu_x, na, b_gpu_w, b_gpu_x,
        c_gpu_x, cpu_x->size[0U], cpu_w->size[0U]);
      b_x_dirtyOnGpu = true;
      c_x_dirtyOnGpu = true;
      b_w_dirtyOnGpu = true;
    }

    // 'ec_detrend:47' if ~nnz(w)
    m = 0;
    cpu_npages = cpu_w->size[0];
    for (n = 0; n < cpu_npages; n++) {
      if (w_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_w, &gpu_w);
      }

      w_dirtyOnGpu = false;
      if (cpu_w->data[n + cpu_w->size[0] * ch] != 0.0F) {
        m++;
      }
    }

    if (!(m != 0.0F)) {
      // 'ec_detrend:47' ;
      // 'ec_detrend:47' w(:)=1;
      b_i = b_cpu_w->size[0];
      b_cpu_w->size[0] = cpu_w->size[0];
      emxEnsureCapacity_real32_T(b_cpu_w, b_i, &d_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(b_cpu_w, &b_gpu_w);
      na = cpu_w->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_detrend_kernel3<<<grid, block>>>(na, b_gpu_w);
        b_w_dirtyOnGpu = true;
      }
    }

    //  Run detrend
    // 'ec_detrend:50' if ~nnz(winSz)
    if (winSz != 0.0F) {
      int32_T i7;
      int32_T ii;
      real32_T dims_idx_0;

      // 'ec_detrend:53' else
      //  Overlapping window detrending
      // 'ec_detrend:55' [x,w] = detrendWin_lfn(x,w,order,thr,nItr,winSz);
      //  Detrend across overlapping time windows
      // 'ec_detrend:98' dims = size(x);
      b_i = cpu_x->size[0];
      dims_idx_0 = static_cast<real32_T>(b_i);

      // 'ec_detrend:99' y = coder.nullcopy(zeros(size(x),'like',x));
      cpu_npages = d_cpu_x->size[0] * d_cpu_x->size[1];
      d_cpu_x->size[0] = static_cast<int32_T>(static_cast<real32_T>(b_i));
      d_cpu_x->size[1] = 1;
      emxEnsureCapacity_real32_T(d_cpu_x, cpu_npages, &e_emlrtRTEI);
      if (!b_x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(d_cpu_x, &d_gpu_x);
      }

      //  1) divide into windows, 2) detrend each, 3) stitch together, 4) estimate w
      // 'ec_detrend:102' for iIter = 1:nItr
      i7 = static_cast<int32_T>(nItr);
      ii = static_cast<int32_T>(order);
      for (int32_T iIter{0}; iIter < i7; iIter++) {
        int32_T nx;
        real32_T y_data[1];
        real32_T offset;
        real32_T stop;

        // 'ec_detrend:103' trend = zeros(dims,'like',x);
        b_i = cpu_trend->size[0] * cpu_trend->size[1];
        cpu_trend->size[0] = static_cast<int32_T>(dims_idx_0);
        cpu_trend->size[1] = 1;
        emxEnsureCapacity_real32_T(cpu_trend, b_i, &h_emlrtRTEI);
        if (!trend_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(cpu_trend, &gpu_trend);
        }

        // 'ec_detrend:104' a = zeros(dims(1),1,'like',x);
        b_i = cpu_a->size[0];
        cpu_a->size[0] = static_cast<int32_T>(dims_idx_0);
        emxEnsureCapacity_real32_T(cpu_a, b_i, &i_emlrtRTEI);
        if (!a_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
          static_cast<int32_T>(dims_idx_0)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (a_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
          }

          if (trend_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_trend, cpu_trend);
          }

          ec_detrend_kernel79<<<grid, block>>>(dims_idx_0, gpu_a, gpu_trend);
          trend_dirtyOnGpu = true;
          trend_dirtyOnCpu = false;
          a_dirtyOnGpu = true;
          a_dirtyOnCpu = false;
        }

        // 'ec_detrend:105' offset = 0;
        offset = 0.0F;

        // 'ec_detrend:106' while true
        real32_T start;
        do {
          real_T apnd;
          real_T cdiff;
          real_T ndbl;
          int32_T exitg1;
          int32_T vlen;
          real32_T b_out;
          real32_T out;
          boolean_T p;

          // 'ec_detrend:107' start = offset+1;
          start = offset + 1.0F;

          // 'ec_detrend:108' stop = min(dims(1),offset+winSz);
          stop = std::fmin(dims_idx_0, offset + winSz);

          //  if not enough valid samples grow window:
          // 'ec_detrend:111' counter = 5;
          n = 5;

          // 'ec_detrend:112' while any(sum(min(w(start:stop),2))) < winSz
          do {
            exitg1 = 0;
            if (std::isnan(start)) {
              b_i = cpu_fv1->size[0] * cpu_fv1->size[1];
              cpu_fv1->size[0] = 1;
              cpu_fv1->size[1] = 1;
              emxEnsureCapacity_real32_T(cpu_fv1, b_i, &n_emlrtRTEI);
              if (!fv1_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1);
              }

              if (fv1_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
              }

              cpu_fv1->data[0] = rtNaNF;
              fv1_dirtyOnCpu = true;
              fv1_dirtyOnGpu = false;
            } else if (stop < start) {
              cpu_fv1->size[0] = 1;
              cpu_fv1->size[1] = 0;
            } else if ((std::isinf(start) || std::isinf(stop)) && (start == stop))
            {
              b_i = cpu_fv1->size[0] * cpu_fv1->size[1];
              cpu_fv1->size[0] = 1;
              cpu_fv1->size[1] = 1;
              emxEnsureCapacity_real32_T(cpu_fv1, b_i, &n_emlrtRTEI);
              if (!fv1_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1);
              }

              if (fv1_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
              }

              cpu_fv1->data[0] = rtNaNF;
              fv1_dirtyOnCpu = true;
              fv1_dirtyOnGpu = false;
            } else if (std::floor(start) == start) {
              if ((std::abs(start) >= 1.07374182E+9F) || (std::abs(stop) >=
                   1.07374182E+9F)) {
                b_i = cpu_fv1->size[0] * cpu_fv1->size[1];
                cpu_fv1->size[0] = 1;
                cpu_fv1->size[1] = static_cast<int32_T>(static_cast<real_T>(stop)
                  - start) + 1;
                emxEnsureCapacity_real32_T(cpu_fv1, b_i, &n_emlrtRTEI);
                if (!fv1_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                  static_cast<int64_T>(static_cast<real_T>(stop) - start) + 1L),
                  &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (fv1_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv1, cpu_fv1);
                  }

                  ec_detrend_kernel86<<<grid, block>>>(start, stop, gpu_fv1);
                  fv1_dirtyOnGpu = true;
                  fv1_dirtyOnCpu = false;
                }
              } else {
                m = static_cast<int32_T>(std::trunc(stop)) - static_cast<int32_T>
                  (start);
                b_i = cpu_fv1->size[0] * cpu_fv1->size[1];
                cpu_fv1->size[0] = 1;
                cpu_fv1->size[1] = (static_cast<int32_T>(std::trunc(stop)) -
                                    static_cast<int32_T>(start)) + 1;
                emxEnsureCapacity_real32_T(cpu_fv1, b_i, &o_emlrtRTEI);
                if (!fv1_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (fv1_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv1, cpu_fv1);
                  }

                  ec_detrend_kernel85<<<grid, block>>>(static_cast<int32_T>
                    (start), m, gpu_fv1);
                  fv1_dirtyOnGpu = true;
                  fv1_dirtyOnCpu = false;
                }
              }
            } else {
              ndbl = std::floor((static_cast<real_T>(stop) - start) + 0.5);
              apnd = start + ndbl;
              cdiff = apnd - stop;
              if (std::abs(cdiff) < 2.384185791015625E-7 * std::fmax(std::abs(
                    static_cast<real_T>(start)), std::abs(static_cast<real_T>
                    (stop)))) {
                ndbl++;
                d2scaled = stop;
              } else if (cdiff > 0.0) {
                d2scaled = static_cast<real32_T>(start + (ndbl - 1.0));
              } else {
                ndbl++;
                d2scaled = static_cast<real32_T>(apnd);
              }

              if (ndbl >= 0.0) {
                m = static_cast<int32_T>(ndbl);
              } else {
                m = 0;
              }

              b_i = cpu_fv1->size[0] * cpu_fv1->size[1];
              cpu_fv1->size[0] = 1;
              cpu_fv1->size[1] = m;
              emxEnsureCapacity_real32_T(cpu_fv1, b_i, &p_emlrtRTEI);
              if (!fv1_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1);
              }

              if (m > 0) {
                if (fv1_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
                }

                cpu_fv1->data[0] = start;
                fv1_dirtyOnCpu = true;
                fv1_dirtyOnGpu = false;
                if (m > 1) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv1, cpu_fv1);
                  ec_detrend_kernel80<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, m, gpu_fv1);
                  fv1_dirtyOnCpu = false;
                  cpu_npages = (m - 1) / 2;
                  p = true;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                    p = false;
                    ec_detrend_kernel81<<<grid, block>>>(d2scaled, m, start,
                      gpu_npages, gpu_fv1);
                  }

                  if (cpu_npages << 1 == m - 1) {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel84<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, start, gpu_npages, gpu_fv1);
                    fv1_dirtyOnGpu = true;
                  } else {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel82<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (start, gpu_npages, gpu_fv1);
                    ec_detrend_kernel83<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, gpu_npages, gpu_fv1);
                    fv1_dirtyOnGpu = true;
                  }
                }
              }
            }

            b_i = cpu_minval->size[0];
            cpu_minval->size[0] = cpu_fv1->size[1];
            emxEnsureCapacity_real32_T(cpu_minval, b_i, &j_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(cpu_minval, &gpu_minval);
            nx = cpu_fv1->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx),
              &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (fv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv1, cpu_fv1);
              }

              fv1_dirtyOnCpu = false;
              ec_detrend_kernel87<<<grid, block>>>(b_gpu_w, gpu_fv1, nx,
                gpu_minval);
              minval_dirtyOnGpu = true;
            }

            vlen = cpu_minval->size[0];
            if (cpu_minval->size[0] == 0) {
              d2scaled = 0.0F;
            } else {
              if (minval_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_minval, &gpu_minval);
              }

              minval_dirtyOnGpu = false;
              d2scaled = cpu_minval->data[0];
              for (na = 0; na <= vlen - 2; na++) {
                d2scaled += cpu_minval->data[na + 1];
              }
            }

            if ((d2scaled == 0.0F) || std::isnan(d2scaled)) {
              p = true;
            } else {
              p = false;
            }

            if (((!p) < winSz) && (n > 0)) {
              // 'ec_detrend:113' if counter <= 0
              // 'ec_detrend:114' start = max(1,start-winSz/2);
              start = std::fmax(1.0F, start - winSz / 2.0F);

              // 'ec_detrend:115' stop = min(dims(1),stop+winSz/2);
              stop = std::fmin(dims_idx_0, stop + winSz / 2.0F);

              // 'ec_detrend:116' counter = counter-1;
              n--;
            } else {
              exitg1 = 1;
            }
          } while (exitg1 == 0);

          // 'ec_detrend:113' ;
          // 'ec_detrend:118' if rem(stop-start+1,2)==1
          if (rt_remf_snf((stop - start) + 1.0F, 2.0F) == 1.0F) {
            // 'ec_detrend:118' ;
            // 'ec_detrend:118' stop = stop-1;
            stop--;
          }

          // 'ec_detrend:119' wsize2 = stop-start+1;
          out = stop - start;

          //  detrend this window
          // 'ec_detrend:122' yy = detrend_lfn(x(start:stop,:),w(start:stop,:),order,thr,1);
          if (std::isnan(start)) {
            b_i = cpu_vec->size[0] * cpu_vec->size[1];
            cpu_vec->size[0] = 1;
            cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(cpu_vec, b_i, &m_emlrtRTEI);
            if (!vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(cpu_vec, &gpu_vec);
            }

            if (vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_vec, &gpu_vec);
            }

            cpu_vec->data[0] = rtNaNF;
            vec_dirtyOnCpu = true;
            vec_dirtyOnGpu = false;
            b_i = b_cpu_vec->size[0] * b_cpu_vec->size[1];
            b_cpu_vec->size[0] = 1;
            b_cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(b_cpu_vec, b_i, &m_emlrtRTEI);
            if (!b_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(b_cpu_vec, &b_gpu_vec);
            }

            if (b_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_vec, &b_gpu_vec);
            }

            b_cpu_vec->data[0] = rtNaNF;
            b_vec_dirtyOnCpu = true;
            b_vec_dirtyOnGpu = false;
          } else if (stop < start) {
            cpu_vec->size[0] = 1;
            cpu_vec->size[1] = 0;
            b_cpu_vec->size[0] = 1;
            b_cpu_vec->size[1] = 0;
          } else {
            if ((std::isinf(start) || std::isinf(stop)) && (start == stop)) {
              b_i = cpu_vec->size[0] * cpu_vec->size[1];
              cpu_vec->size[0] = 1;
              cpu_vec->size[1] = 1;
              emxEnsureCapacity_real32_T(cpu_vec, b_i, &m_emlrtRTEI);
              if (!vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(cpu_vec, &gpu_vec);
              }

              if (vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_vec, &gpu_vec);
              }

              cpu_vec->data[0] = rtNaNF;
              vec_dirtyOnCpu = true;
              vec_dirtyOnGpu = false;
            } else if (std::floor(start) == start) {
              if ((std::abs(start) >= 1.07374182E+9F) || (std::abs(stop) >=
                   1.07374182E+9F)) {
                b_i = cpu_vec->size[0] * cpu_vec->size[1];
                cpu_vec->size[0] = 1;
                cpu_vec->size[1] = static_cast<int32_T>(static_cast<real_T>(stop)
                  - start) + 1;
                emxEnsureCapacity_real32_T(cpu_vec, b_i, &m_emlrtRTEI);
                if (!vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_vec, &gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                  static_cast<int64_T>(static_cast<real_T>(stop) - start) + 1L),
                  &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_vec, cpu_vec);
                  }

                  ec_detrend_kernel94<<<grid, block>>>(start, stop, gpu_vec);
                  vec_dirtyOnGpu = true;
                  vec_dirtyOnCpu = false;
                }
              } else {
                m = static_cast<int32_T>(std::trunc(stop)) - static_cast<int32_T>
                  (start);
                b_i = cpu_vec->size[0] * cpu_vec->size[1];
                cpu_vec->size[0] = 1;
                cpu_vec->size[1] = (static_cast<int32_T>(std::trunc(stop)) -
                                    static_cast<int32_T>(start)) + 1;
                emxEnsureCapacity_real32_T(cpu_vec, b_i, &o_emlrtRTEI);
                if (!vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_vec, &gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_vec, cpu_vec);
                  }

                  ec_detrend_kernel93<<<grid, block>>>(static_cast<int32_T>
                    (start), m, gpu_vec);
                  vec_dirtyOnGpu = true;
                  vec_dirtyOnCpu = false;
                }
              }
            } else {
              ndbl = std::floor((static_cast<real_T>(stop) - start) + 0.5);
              apnd = start + ndbl;
              cdiff = apnd - stop;
              if (std::abs(cdiff) < 2.384185791015625E-7 * std::fmax(std::abs(
                    static_cast<real_T>(start)), std::abs(static_cast<real_T>
                    (stop)))) {
                ndbl++;
                d2scaled = stop;
              } else if (cdiff > 0.0) {
                d2scaled = static_cast<real32_T>(start + (ndbl - 1.0));
              } else {
                ndbl++;
                d2scaled = static_cast<real32_T>(apnd);
              }

              if (ndbl >= 0.0) {
                m = static_cast<int32_T>(ndbl);
              } else {
                m = 0;
              }

              b_i = cpu_vec->size[0] * cpu_vec->size[1];
              cpu_vec->size[0] = 1;
              cpu_vec->size[1] = m;
              emxEnsureCapacity_real32_T(cpu_vec, b_i, &p_emlrtRTEI);
              if (!vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(cpu_vec, &gpu_vec);
              }

              if (m > 0) {
                if (vec_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(cpu_vec, &gpu_vec);
                }

                cpu_vec->data[0] = start;
                vec_dirtyOnCpu = true;
                vec_dirtyOnGpu = false;
                if (m > 1) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_vec, cpu_vec);
                  ec_detrend_kernel88<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, m, gpu_vec);
                  vec_dirtyOnCpu = false;
                  cpu_npages = (m - 1) / 2;
                  p = true;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                    p = false;
                    ec_detrend_kernel89<<<grid, block>>>(d2scaled, m, start,
                      gpu_npages, gpu_vec);
                  }

                  if (cpu_npages << 1 == m - 1) {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel92<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, start, gpu_npages, gpu_vec);
                    vec_dirtyOnGpu = true;
                  } else {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel90<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (start, gpu_npages, gpu_vec);
                    ec_detrend_kernel91<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, gpu_npages, gpu_vec);
                    vec_dirtyOnGpu = true;
                  }
                }
              }
            }

            if ((std::isinf(start) || std::isinf(stop)) && (start == stop)) {
              b_i = b_cpu_vec->size[0] * b_cpu_vec->size[1];
              b_cpu_vec->size[0] = 1;
              b_cpu_vec->size[1] = 1;
              emxEnsureCapacity_real32_T(b_cpu_vec, b_i, &m_emlrtRTEI);
              if (!b_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(b_cpu_vec, &b_gpu_vec);
              }

              if (b_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_vec, &b_gpu_vec);
              }

              b_cpu_vec->data[0] = rtNaNF;
              b_vec_dirtyOnCpu = true;
              b_vec_dirtyOnGpu = false;
            } else if (std::floor(start) == start) {
              if ((std::abs(start) >= 1.07374182E+9F) || (std::abs(stop) >=
                   1.07374182E+9F)) {
                b_i = b_cpu_vec->size[0] * b_cpu_vec->size[1];
                b_cpu_vec->size[0] = 1;
                b_cpu_vec->size[1] = static_cast<int32_T>(static_cast<real_T>
                  (stop) - start) + 1;
                emxEnsureCapacity_real32_T(b_cpu_vec, b_i, &m_emlrtRTEI);
                if (!b_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(b_cpu_vec, &b_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                  static_cast<int64_T>(static_cast<real_T>(stop) - start) + 1L),
                  &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_vec, b_cpu_vec);
                  }

                  ec_detrend_kernel101<<<grid, block>>>(start, stop, b_gpu_vec);
                  b_vec_dirtyOnGpu = true;
                  b_vec_dirtyOnCpu = false;
                }
              } else {
                m = static_cast<int32_T>(std::trunc(stop)) - static_cast<int32_T>
                  (start);
                b_i = b_cpu_vec->size[0] * b_cpu_vec->size[1];
                b_cpu_vec->size[0] = 1;
                b_cpu_vec->size[1] = (static_cast<int32_T>(std::trunc(stop)) -
                                      static_cast<int32_T>(start)) + 1;
                emxEnsureCapacity_real32_T(b_cpu_vec, b_i, &o_emlrtRTEI);
                if (!b_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(b_cpu_vec, &b_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_vec, b_cpu_vec);
                  }

                  ec_detrend_kernel100<<<grid, block>>>(static_cast<int32_T>
                    (start), m, b_gpu_vec);
                  b_vec_dirtyOnGpu = true;
                  b_vec_dirtyOnCpu = false;
                }
              }
            } else {
              ndbl = std::floor((static_cast<real_T>(stop) - start) + 0.5);
              apnd = start + ndbl;
              cdiff = apnd - stop;
              if (std::abs(cdiff) < 2.384185791015625E-7 * std::fmax(std::abs(
                    static_cast<real_T>(start)), std::abs(static_cast<real_T>
                    (stop)))) {
                ndbl++;
                d2scaled = stop;
              } else if (cdiff > 0.0) {
                d2scaled = static_cast<real32_T>(start + (ndbl - 1.0));
              } else {
                ndbl++;
                d2scaled = static_cast<real32_T>(apnd);
              }

              if (ndbl >= 0.0) {
                m = static_cast<int32_T>(ndbl);
              } else {
                m = 0;
              }

              b_i = b_cpu_vec->size[0] * b_cpu_vec->size[1];
              b_cpu_vec->size[0] = 1;
              b_cpu_vec->size[1] = m;
              emxEnsureCapacity_real32_T(b_cpu_vec, b_i, &p_emlrtRTEI);
              if (!b_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(b_cpu_vec, &b_gpu_vec);
              }

              if (m > 0) {
                if (b_vec_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_vec, &b_gpu_vec);
                }

                b_cpu_vec->data[0] = start;
                b_vec_dirtyOnCpu = true;
                b_vec_dirtyOnGpu = false;
                if (m > 1) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_vec, b_cpu_vec);
                  ec_detrend_kernel95<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, m, b_gpu_vec);
                  b_vec_dirtyOnCpu = false;
                  cpu_npages = (m - 1) / 2;
                  p = true;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                    p = false;
                    ec_detrend_kernel96<<<grid, block>>>(d2scaled, m, start,
                      gpu_npages, b_gpu_vec);
                  }

                  if (cpu_npages << 1 == m - 1) {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel99<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, start, gpu_npages, b_gpu_vec);
                    b_vec_dirtyOnGpu = true;
                  } else {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel97<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (start, gpu_npages, b_gpu_vec);
                    ec_detrend_kernel98<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, gpu_npages, b_gpu_vec);
                    b_vec_dirtyOnGpu = true;
                  }
                }
              }
            }
          }

          b_i = cpu_fv2->size[0];
          cpu_fv2->size[0] = cpu_vec->size[1];
          emxEnsureCapacity_real32_T(cpu_fv2, b_i, &r_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_fv2, &gpu_fv2);
          na = cpu_vec->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (vec_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_vec, cpu_vec);
            }

            vec_dirtyOnCpu = false;
            ec_detrend_kernel102<<<grid, block>>>(c_gpu_x, gpu_vec, na, gpu_fv2);
            fv2_dirtyOnGpu = true;
          }

          b_i = cpu_fv3->size[0];
          cpu_fv3->size[0] = b_cpu_vec->size[1];
          emxEnsureCapacity_real32_T(cpu_fv3, b_i, &r_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_fv3, &gpu_fv3);
          na = b_cpu_vec->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_vec_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_vec, b_cpu_vec);
            }

            b_vec_dirtyOnCpu = false;
            ec_detrend_kernel103<<<grid, block>>>(b_gpu_w, b_gpu_vec, na,
              gpu_fv3);
            fv3_dirtyOnGpu = true;
          }

          //  Standard detrending (trend fit to entire data)
          //  The data are fit to the basis using weighted least squares. The weight is
          //  updated by setting samples for which the residual is greater than 'thresh'
          //  times its std to zero, and the fit is repeated at most 'niter'-1 times.
          //
          //  The choice of order (and basis) determines what complexity of the trend
          //  that can be removed.  It may be useful to first detrend with a low order
          //  to avoid fitting outliers, and then increase the order.
          //
          //  The tricky bit is to ensure that weighted means are removed before
          //  calculating the regression (see nt_regw)
          //  Get regressors from basis function
          // 'ec_detrend:74' nFrames = height(x);
          // 'ec_detrend:75' r = coder.nullcopy(zeros(nFrames,order,'like',x));
          b_i = b_cpu_r->size[0] * b_cpu_r->size[1];
          b_cpu_r->size[0] = static_cast<int32_T>(static_cast<real32_T>
            (cpu_vec->size[1]));
          b_cpu_r->size[1] = static_cast<int32_T>(order);
          emxEnsureCapacity_real32_T(b_cpu_r, b_i, &f_emlrtRTEI);
          if (!r_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_r, &gpu_r);
          }

          // 'ec_detrend:76' lin = linspace(-1,1,nFrames);
          b_i = b_cpu_lin->size[0] * b_cpu_lin->size[1];
          b_cpu_lin->size[0] = 1;
          b_cpu_lin->size[1] = static_cast<int32_T>(static_cast<real32_T>
            (cpu_vec->size[1]));
          emxEnsureCapacity_real32_T(b_cpu_lin, b_i, &g_emlrtRTEI);
          if (!b_lin_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_lin, &gpu_lin);
          }

          if (static_cast<int32_T>(static_cast<real32_T>(cpu_vec->size[1])) >= 1)
          {
            if (b_lin_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_lin, &gpu_lin);
            }

            b_cpu_lin->data[static_cast<int32_T>(static_cast<real32_T>
              (cpu_vec->size[1])) - 1] = 1.0F;
            b_lin_dirtyOnCpu = true;
            b_lin_dirtyOnGpu = false;
            if (b_cpu_lin->size[1] >= 2) {
              b_cpu_lin->data[0] = -1.0F;
              if (b_cpu_lin->size[1] >= 3) {
                d2scaled = 1.0F / static_cast<real32_T>(b_cpu_lin->size[1] - 1);
                cpu_npages = b_cpu_lin->size[1];
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (cpu_npages - 2L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                             cudaMemcpyHostToDevice);
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_lin, b_cpu_lin);
                  ec_detrend_kernel104<<<grid, block>>>(d2scaled, gpu_npages,
                    gpu_lin, b_cpu_lin->size[1U]);
                  b_lin_dirtyOnGpu = true;
                  b_lin_dirtyOnCpu = false;
                }

                if ((b_cpu_lin->size[1] & 1) == 1) {
                  if (b_lin_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_lin, b_cpu_lin);
                  }

                  ec_detrend_kernel105<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (gpu_lin, b_cpu_lin->size[1U]);
                  b_lin_dirtyOnGpu = true;
                  b_lin_dirtyOnCpu = false;
                }
              }
            }
          }

          // 'ec_detrend:77' for k=1:order
          nx = b_cpu_lin->size[1];
          for (n = 0; n < ii; n++) {
            // 'ec_detrend:78' r(:,k) = lin.^k;
            b_i = cpu_fv5->size[0] * cpu_fv5->size[1];
            cpu_fv5->size[0] = 1;
            cpu_fv5->size[1] = b_cpu_lin->size[1];
            emxEnsureCapacity_real32_T(cpu_fv5, b_i, &j_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(cpu_fv5, &gpu_fv5);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx),
              &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_lin_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_lin, b_cpu_lin);
              }

              b_lin_dirtyOnCpu = false;
              ec_detrend_kernel106<<<grid, block>>>(n, gpu_lin, nx, gpu_fv5);
            }

            x[0] = b_cpu_r->size[0];
            na = x[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_r, b_cpu_r);
              }

              ec_detrend_kernel107<<<grid, block>>>(gpu_fv5, static_cast<int32_T>
                (static_cast<real32_T>(n) + 1.0F), x[0] - 1, gpu_r,
                b_cpu_r->size[0U]);
              b_r_dirtyOnGpu = true;
              r_dirtyOnCpu = false;
            }
          }

          //  Remove trends
          // 'ec_detrend:82' z = coder.nullcopy(zeros(size(x),'like',x));
          // 'ec_detrend:83' for ii = 1:nItr
          //  Weighted regression on basis
          // 'ec_detrend:85' z = regw_lfn(x,w,r);
          //  Weighted Regression
          //   b: regression matrix (apply to r to approximate x)
          //   z: regression (r*b)
          //  discard dimensions of r with eigenvalue lower than this
          // 'ec_detrend:165' thrPCA = 1e-7;
          // zeros(1,1,class(x));
          //  save weighted mean
          // 'ec_detrend:168' mn = x - demean_lfn(x,w);
          //  Demean
          // 'ec_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if (cpu_fv2->size[0] == cpu_fv3->size[0]) {
            b_i = d_cpu_c->size[0];
            d_cpu_c->size[0] = cpu_fv2->size[0];
            emxEnsureCapacity_real32_T(d_cpu_c, b_i, &m_emlrtRTEI);
            if (!d_c_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(d_cpu_c, &gpu_c);
            }

            na = cpu_fv2->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (d_c_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_c, d_cpu_c);
              }

              ec_detrend_kernel108<<<grid, block>>>(gpu_fv3, gpu_fv2, na, gpu_c);
              d_c_dirtyOnGpu = true;
              d_c_dirtyOnCpu = false;
            }
          } else {
            if (d_c_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_c, &gpu_c);
            }

            if (fv2_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
            }

            fv2_dirtyOnGpu = false;
            if (fv3_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv3, &gpu_fv3);
            }

            fv3_dirtyOnGpu = false;
            times(d_cpu_c, cpu_fv2, cpu_fv3);
            d_c_dirtyOnCpu = true;
            d_c_dirtyOnGpu = false;
          }

          vlen = d_cpu_c->size[0];
          if (d_cpu_c->size[0] == 0) {
            d2scaled = 0.0F;
          } else {
            if (d_c_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_c, &gpu_c);
            }

            d_c_dirtyOnGpu = false;
            d2scaled = d_cpu_c->data[0];
            for (na = 0; na <= vlen - 2; na++) {
              d2scaled += d_cpu_c->data[na + 1];
            }
          }

          vlen = b_cpu_vec->size[1];
          if (b_cpu_vec->size[1] == 0) {
            abnrm = 0.0F;
          } else {
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            if (b_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_vec, &b_gpu_vec);
            }

            b_vec_dirtyOnGpu = false;
            abnrm = b_cpu_w->data[static_cast<int32_T>(b_cpu_vec->data[0]) - 1];
            for (na = 0; na <= vlen - 2; na++) {
              abnrm += b_cpu_w->data[static_cast<int32_T>(b_cpu_vec->data[na + 1])
                - 1];
            }
          }

          b_out = d2scaled / (abnrm + 2.22044605E-16F);

          // 'ec_detrend:188' x = x - mn;
          //  Fit weighted regression
          // 'ec_detrend:171' x = demean_lfn(x,w).* w;
          //  Demean
          // 'ec_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if (cpu_fv2->size[0] == cpu_fv3->size[0]) {
            b_i = e_cpu_c->size[0];
            e_cpu_c->size[0] = cpu_fv2->size[0];
            emxEnsureCapacity_real32_T(e_cpu_c, b_i, &m_emlrtRTEI);
            if (!e_c_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(e_cpu_c, &b_gpu_c);
            }

            na = cpu_fv2->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (e_c_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_c, e_cpu_c);
              }

              ec_detrend_kernel109<<<grid, block>>>(gpu_fv3, gpu_fv2, na,
                b_gpu_c);
              e_c_dirtyOnGpu = true;
              e_c_dirtyOnCpu = false;
            }
          } else {
            if (e_c_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_c, &b_gpu_c);
            }

            if (fv2_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
            }

            fv2_dirtyOnGpu = false;
            if (fv3_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv3, &gpu_fv3);
            }

            fv3_dirtyOnGpu = false;
            times(e_cpu_c, cpu_fv2, cpu_fv3);
            e_c_dirtyOnCpu = true;
            e_c_dirtyOnGpu = false;
          }

          vlen = e_cpu_c->size[0];
          if (e_cpu_c->size[0] == 0) {
            d2scaled = 0.0F;
          } else {
            if (e_c_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_c, &b_gpu_c);
            }

            e_c_dirtyOnGpu = false;
            d2scaled = e_cpu_c->data[0];
            for (na = 0; na <= vlen - 2; na++) {
              d2scaled += e_cpu_c->data[na + 1];
            }
          }

          vlen = b_cpu_vec->size[1];
          if (b_cpu_vec->size[1] == 0) {
            abnrm = 0.0F;
          } else {
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            if (b_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_vec, &b_gpu_vec);
            }

            b_vec_dirtyOnGpu = false;
            abnrm = b_cpu_w->data[static_cast<int32_T>(b_cpu_vec->data[0]) - 1];
            for (na = 0; na <= vlen - 2; na++) {
              abnrm += b_cpu_w->data[static_cast<int32_T>(b_cpu_vec->data[na + 1])
                - 1];
            }
          }

          d2scaled /= abnrm + 2.22044605E-16F;

          // 'ec_detrend:188' x = x - mn;
          if (cpu_fv2->size[0] == cpu_fv3->size[0]) {
            b_i = cpu_fv7->size[0];
            cpu_fv7->size[0] = cpu_fv2->size[0];
            emxEnsureCapacity_real32_T(cpu_fv7, b_i, &q_emlrtRTEI);
            if (!fv7_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(cpu_fv7, &gpu_fv7);
            }

            na = cpu_fv2->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (fv7_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv7, cpu_fv7);
              }

              ec_detrend_kernel110<<<grid, block>>>(gpu_fv3, d2scaled, gpu_fv2,
                na, gpu_fv7);
              fv7_dirtyOnGpu = true;
              fv7_dirtyOnCpu = false;
            }
          } else {
            if (fv7_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv7, &gpu_fv7);
            }

            if (fv2_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
            }

            fv2_dirtyOnGpu = false;
            if (fv3_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv3, &gpu_fv3);
            }

            fv3_dirtyOnGpu = false;
            binary_expand_op(cpu_fv7, cpu_fv2, d2scaled, cpu_fv3);
            fv7_dirtyOnCpu = true;
            fv7_dirtyOnGpu = false;
          }

          // 'ec_detrend:172' r = demean_lfn(r,w);
          //  Demean
          // 'ec_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if (b_cpu_r->size[0] == b_cpu_vec->size[1]) {
            b_i = f_cpu_c->size[0] * f_cpu_c->size[1];
            f_cpu_c->size[0] = b_cpu_r->size[0];
            f_cpu_c->size[1] = b_cpu_r->size[1];
            emxEnsureCapacity_real32_T(f_cpu_c, b_i, &m_emlrtRTEI);
            if (!f_c_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(f_cpu_c, &c_gpu_c);
            }

            na = b_cpu_r->size[1] - 1;
            nx = b_cpu_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx
              + 1L) * (na + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_r, b_cpu_r);
              }

              r_dirtyOnCpu = false;
              if (f_c_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_c, f_cpu_c);
              }

              ec_detrend_kernel111<<<grid, block>>>(gpu_fv3, gpu_r, nx, na,
                c_gpu_c, f_cpu_c->size[0U], b_cpu_r->size[0U]);
              f_c_dirtyOnGpu = true;
              f_c_dirtyOnCpu = false;
            }
          } else {
            if (f_c_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(f_cpu_c, &c_gpu_c);
            }

            if (b_r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_r, &gpu_r);
            }

            b_r_dirtyOnGpu = false;
            if (fv3_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv3, &gpu_fv3);
            }

            fv3_dirtyOnGpu = false;
            if (b_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_vec, &b_gpu_vec);
            }

            b_vec_dirtyOnGpu = false;
            b_binary_expand_op(f_cpu_c, b_cpu_r, cpu_fv3, b_cpu_vec);
            f_c_dirtyOnCpu = true;
            f_c_dirtyOnGpu = false;
          }

          vlen = f_cpu_c->size[0];
          if ((f_cpu_c->size[0] == 0) || (f_cpu_c->size[1] == 0)) {
            for (b_i = 0; b_i < 2; b_i++) {
              sz[b_i] = static_cast<uint32_T>(f_cpu_c->size[b_i]);
            }

            b_i = b_cpu_y->size[0] * b_cpu_y->size[1];
            b_cpu_y->size[0] = 1;
            b_cpu_y->size[1] = static_cast<int32_T>(sz[1]);
            emxEnsureCapacity_real32_T(b_cpu_y, b_i, &t_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(b_cpu_y, &gpu_y);
            na = static_cast<int32_T>(sz[1]) - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel113<<<grid, block>>>(static_cast<int32_T>(sz[1])
                - 1, gpu_y);
              b_y_dirtyOnGpu = true;
            }
          } else {
            cpu_npages = f_cpu_c->size[1];
            b_i = b_cpu_y->size[0] * b_cpu_y->size[1];
            b_cpu_y->size[0] = 1;
            b_cpu_y->size[1] = f_cpu_c->size[1];
            emxEnsureCapacity_real32_T(b_cpu_y, b_i, &s_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(b_cpu_y, &gpu_y);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (f_c_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_c, f_cpu_c);
              }

              f_c_dirtyOnCpu = false;
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              ec_detrend_kernel112<<<grid, block>>>(vlen, c_gpu_c, gpu_npages,
                gpu_y, f_cpu_c->size[0U]);
              b_y_dirtyOnGpu = true;
            }
          }

          vlen = b_cpu_vec->size[1];
          if (b_cpu_vec->size[1] == 0) {
            d2scaled = 0.0F;
          } else {
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            if (b_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_vec, &b_gpu_vec);
            }

            b_vec_dirtyOnGpu = false;
            d2scaled = b_cpu_w->data[static_cast<int32_T>(b_cpu_vec->data[0]) -
              1];
            for (na = 0; na <= vlen - 2; na++) {
              d2scaled += b_cpu_w->data[static_cast<int32_T>(b_cpu_vec->data[na
                + 1]) - 1];
            }
          }

          // 'ec_detrend:188' x = x - mn;
          if (b_cpu_r->size[1] == b_cpu_y->size[1]) {
            d2scaled += 2.22044605E-16F;
            b_i = d_cpu_r->size[0] * d_cpu_r->size[1];
            d_cpu_r->size[0] = b_cpu_r->size[0];
            d_cpu_r->size[1] = b_cpu_r->size[1];
            emxEnsureCapacity_real32_T(d_cpu_r, b_i, &lc_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(d_cpu_r, &b_gpu_r);
            na = b_cpu_r->size[1] - 1;
            nx = b_cpu_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx
              + 1L) * (na + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_r, b_cpu_r);
              }

              r_dirtyOnCpu = false;
              ec_detrend_kernel114<<<grid, block>>>(d2scaled, gpu_y, gpu_r, nx,
                na, b_gpu_r, d_cpu_r->size[0U], b_cpu_r->size[0U]);
            }

            b_i = b_cpu_r->size[0] * b_cpu_r->size[1];
            b_cpu_r->size[0] = d_cpu_r->size[0];
            b_cpu_r->size[1] = d_cpu_r->size[1];
            emxEnsureCapacity_real32_T(b_cpu_r, b_i, &u_emlrtRTEI);
            if (!r_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(b_cpu_r, &gpu_r);
            }

            na = d_cpu_r->size[0] * d_cpu_r->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_r, b_cpu_r);
              }

              ec_detrend_kernel115<<<grid, block>>>(b_gpu_r, na, gpu_r);
              b_r_dirtyOnGpu = true;
              r_dirtyOnCpu = false;
            }
          } else {
            if (b_r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_r, &gpu_r);
            }

            if (b_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_y, &gpu_y);
            }

            b_y_dirtyOnGpu = false;
            binary_expand_op(b_cpu_r, b_cpu_y, d2scaled);
            r_dirtyOnCpu = true;
            b_r_dirtyOnGpu = false;
          }

          //  remove channel-specific-weighted mean from regressor
          // 'ec_detrend:173' rr = r.*w;
          if (b_cpu_r->size[0] == b_cpu_vec->size[1]) {
            b_i = b_cpu_rr->size[0] * b_cpu_rr->size[1];
            b_cpu_rr->size[0] = b_cpu_r->size[0];
            b_cpu_rr->size[1] = b_cpu_r->size[1];
            emxEnsureCapacity_real32_T(b_cpu_rr, b_i, &v_emlrtRTEI);
            if (!b_rr_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(b_cpu_rr, &gpu_rr);
            }

            na = b_cpu_r->size[1] - 1;
            nx = b_cpu_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx
              + 1L) * (na + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_r, b_cpu_r);
              }

              r_dirtyOnCpu = false;
              if (b_rr_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, b_cpu_rr);
              }

              ec_detrend_kernel116<<<grid, block>>>(gpu_fv3, gpu_r, nx, na,
                gpu_rr, b_cpu_rr->size[0U], b_cpu_r->size[0U]);
              b_rr_dirtyOnGpu = true;
              b_rr_dirtyOnCpu = false;
            }
          } else {
            if (b_rr_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_rr, &gpu_rr);
            }

            if (b_r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_r, &gpu_r);
            }

            b_r_dirtyOnGpu = false;
            if (fv3_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv3, &gpu_fv3);
            }

            fv3_dirtyOnGpu = false;
            if (b_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_vec, &b_gpu_vec);
            }

            b_vec_dirtyOnGpu = false;
            b_binary_expand_op(b_cpu_rr, b_cpu_r, cpu_fv3, b_cpu_vec);
            b_rr_dirtyOnCpu = true;
            b_rr_dirtyOnGpu = false;
          }

          // 'ec_detrend:174' [V,D] = eig(rr'*rr);
          b_i = e_cpu_a->size[0] * e_cpu_a->size[1];
          e_cpu_a->size[0] = b_cpu_rr->size[1];
          e_cpu_a->size[1] = b_cpu_rr->size[0];
          emxEnsureCapacity_real32_T(e_cpu_a, b_i, &w_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(e_cpu_a, &b_gpu_a);
          nx = b_cpu_rr->size[0] - 1;
          na = b_cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((na +
            1L) * (nx + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, b_cpu_rr);
            }

            b_rr_dirtyOnCpu = false;
            ec_detrend_kernel117<<<grid, block>>>(gpu_rr, na, nx, b_gpu_a,
              e_cpu_a->size[0U], b_cpu_rr->size[0U]);
          }

          if ((e_cpu_a->size[0] == 0) || (e_cpu_a->size[1] == 0) ||
              (b_cpu_rr->size[0] == 0) || (b_cpu_rr->size[1] == 0)) {
            b_i = d_cpu_A->size[0] * d_cpu_A->size[1];
            d_cpu_A->size[0] = e_cpu_a->size[0];
            d_cpu_A->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real32_T(d_cpu_A, b_i, &m_emlrtRTEI);
            if (!b_A_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(d_cpu_A, &gpu_A);
            }

            na = e_cpu_a->size[0] * b_cpu_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_A_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, d_cpu_A);
              }

              ec_detrend_kernel118<<<grid, block>>>(na, gpu_A);
              b_A_dirtyOnGpu = true;
              b_A_dirtyOnCpu = false;
            }
          } else {
            b_i = d_cpu_A->size[0] * d_cpu_A->size[1];
            d_cpu_A->size[0] = e_cpu_a->size[0];
            d_cpu_A->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real32_T(d_cpu_A, b_i, &x_emlrtRTEI);
            if (!b_A_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(d_cpu_A, &gpu_A);
            }

            d2scaled = 1.0F;
            abnrm = 0.0F;
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, b_cpu_rr);
            }

            b_rr_dirtyOnCpu = false;
            if (b_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, d_cpu_A);
            }

            cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        e_cpu_a->size[0], b_cpu_rr->size[1], e_cpu_a->size[1],
                        (float *)&d2scaled, (float *)&b_gpu_a.data[0],
                        e_cpu_a->size[0], (float *)&gpu_rr.data[0],
                        e_cpu_a->size[1], (float *)&abnrm, (float *)&gpu_A.data
                        [0], e_cpu_a->size[0]);
            b_A_dirtyOnGpu = true;
            b_A_dirtyOnCpu = false;
          }

          m = d_cpu_A->size[0];
          b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
          c_cpu_V->size[0] = d_cpu_A->size[0];
          c_cpu_V->size[1] = d_cpu_A->size[0];
          emxEnsureCapacity_creal32_T(c_cpu_V, b_i, &y_emlrtRTEI);
          if (!b_V_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal32_T(c_cpu_V, &gpu_V);
          }

          b_i = c_cpu_D->size[0] * c_cpu_D->size[1];
          c_cpu_D->size[0] = d_cpu_A->size[0];
          c_cpu_D->size[1] = d_cpu_A->size[0];
          emxEnsureCapacity_creal32_T(c_cpu_D, b_i, &ab_emlrtRTEI);
          if (!c_D_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal32_T(c_cpu_D, &gpu_D);
          }

          if ((d_cpu_A->size[0] != 0) && (d_cpu_A->size[1] != 0)) {
            nx = d_cpu_A->size[0] * d_cpu_A->size[1];
            p = true;
            for (n = 0; n < nx; n++) {
              if (p) {
                if (b_A_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &gpu_A);
                }

                b_A_dirtyOnGpu = false;
                if (std::isinf(d_cpu_A->data[n]) || std::isnan(d_cpu_A->data[n]))
                {
                  p = false;
                }
              } else {
                p = false;
              }
            }

            if (!p) {
              for (b_i = 0; b_i < 2; b_i++) {
                V[b_i] = c_cpu_V->size[b_i];
              }

              b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
              c_cpu_V->size[0] = V[0];
              c_cpu_V->size[1] = V[1];
              emxEnsureCapacity_creal32_T(c_cpu_V, b_i, &cb_emlrtRTEI);
              if (!b_V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal32_T(c_cpu_V, &gpu_V);
              }

              na = V[0] * V[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, c_cpu_V);
                }

                ec_detrend_kernel140<<<grid, block>>>(gpu_fc, na, gpu_V);
                b_V_dirtyOnGpu = true;
                b_V_dirtyOnCpu = false;
              }

              for (b_i = 0; b_i < 2; b_i++) {
                V[b_i] = c_cpu_D->size[b_i];
              }

              b_i = c_cpu_D->size[0] * c_cpu_D->size[1];
              c_cpu_D->size[0] = V[0];
              c_cpu_D->size[1] = V[1];
              emxEnsureCapacity_creal32_T(c_cpu_D, b_i, &hb_emlrtRTEI);
              if (!c_D_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal32_T(c_cpu_D, &gpu_D);
              }

              na = V[0] * V[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (c_D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, c_cpu_D);
                }

                ec_detrend_kernel141<<<grid, block>>>(na, gpu_D);
                c_D_dirtyOnGpu = true;
                c_D_dirtyOnCpu = false;
              }

              for (n = 0; n < m; n++) {
                if (c_D_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_creal32_T(c_cpu_D, &gpu_D);
                }

                if (fc_dirtyOnGpu) {
                  cudaMemcpy(&cpu_fc, gpu_fc, 8UL, cudaMemcpyDeviceToHost);
                }

                fc_dirtyOnGpu = false;
                c_cpu_D->data[n + c_cpu_D->size[0] * n] = cpu_fc;
                c_D_dirtyOnCpu = true;
                c_D_dirtyOnGpu = false;
              }
            } else {
              boolean_T exitg2;
              p = (d_cpu_A->size[0] == d_cpu_A->size[1]);
              if (p) {
                na = 0;
                exitg2 = false;
                while ((!exitg2) && (na <= d_cpu_A->size[1] - 1)) {
                  b_i = 0;
                  do {
                    exitg1 = 0;
                    if (b_i <= na) {
                      if (b_A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &gpu_A);
                      }

                      b_A_dirtyOnGpu = false;
                      if (!(d_cpu_A->data[b_i + d_cpu_A->size[0] * na] ==
                            d_cpu_A->data[na + d_cpu_A->size[0] * b_i])) {
                        p = false;
                        exitg1 = 1;
                      } else {
                        b_i++;
                      }
                    } else {
                      na++;
                      exitg1 = 2;
                    }
                  } while (exitg1 == 0);

                  if (exitg1 == 1) {
                    exitg2 = true;
                  }
                }
              }

              if (p) {
                ptrdiff_t c_n_t;
                ptrdiff_t f_info_t;
                m = d_cpu_A->size[0];
                c_n_t = (ptrdiff_t)d_cpu_A->size[0];
                b_i = c_cpu_W->size[0];
                c_cpu_W->size[0] = d_cpu_A->size[0];
                emxEnsureCapacity_real32_T(c_cpu_W, b_i, &eb_emlrtRTEI);
                if (!b_W_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(c_cpu_W, &gpu_W);
                }

                if (b_A_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &gpu_A);
                }

                if (c_W_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_W, &gpu_W);
                }

                f_info_t = LAPACKE_ssyev(102, 'V', 'L', c_n_t, &d_cpu_A->data[0],
                  c_n_t, &c_cpu_W->data[0]);
                b_W_dirtyOnCpu = true;
                c_W_dirtyOnGpu = false;
                b_A_dirtyOnCpu = true;
                b_A_dirtyOnGpu = false;
                if ((int32_T)f_info_t < 0) {
                  x[0] = c_cpu_W->size[0];
                  b_i = c_cpu_W->size[0];
                  c_cpu_W->size[0] = x[0];
                  emxEnsureCapacity_real32_T(c_cpu_W, b_i, &lb_emlrtRTEI);
                  na = x[0] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (na + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_W, c_cpu_W);
                    ec_detrend_kernel136<<<grid, block>>>(x[0] - 1, gpu_W);
                    c_W_dirtyOnGpu = true;
                    b_W_dirtyOnCpu = false;
                  }

                  for (b_i = 0; b_i < 2; b_i++) {
                    V[b_i] = d_cpu_A->size[b_i];
                  }

                  b_i = d_cpu_A->size[0] * d_cpu_A->size[1];
                  d_cpu_A->size[0] = V[0];
                  d_cpu_A->size[1] = V[1];
                  emxEnsureCapacity_real32_T(d_cpu_A, b_i, &sb_emlrtRTEI);
                  na = V[0] * V[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (na + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, d_cpu_A);
                    ec_detrend_kernel137<<<grid, block>>>(na, gpu_A);
                    b_A_dirtyOnGpu = true;
                    b_A_dirtyOnCpu = false;
                  }
                }

                b_i = c_cpu_D->size[0] * c_cpu_D->size[1];
                c_cpu_D->size[0] = m;
                c_cpu_D->size[1] = m;
                emxEnsureCapacity_creal32_T(c_cpu_D, b_i, &kb_emlrtRTEI);
                if (!c_D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal32_T(c_cpu_D, &gpu_D);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m * m), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (c_D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, c_cpu_D);
                  }

                  ec_detrend_kernel138<<<grid, block>>>(m, gpu_D);
                  c_D_dirtyOnGpu = true;
                  c_D_dirtyOnCpu = false;
                }

                for (b_i = 0; b_i < m; b_i++) {
                  if (c_D_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal32_T(c_cpu_D, &gpu_D);
                  }

                  if (c_W_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_W, &gpu_W);
                  }

                  c_W_dirtyOnGpu = false;
                  c_cpu_D->data[b_i + c_cpu_D->size[0] * b_i].re = c_cpu_W->
                    data[b_i];
                  c_cpu_D->data[b_i + c_cpu_D->size[0] * b_i].im = 0.0F;
                  c_D_dirtyOnCpu = true;
                  c_D_dirtyOnGpu = false;
                }

                b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
                c_cpu_V->size[0] = d_cpu_A->size[0];
                c_cpu_V->size[1] = d_cpu_A->size[1];
                emxEnsureCapacity_creal32_T(c_cpu_V, b_i, &tb_emlrtRTEI);
                if (!b_V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal32_T(c_cpu_V, &gpu_V);
                }

                nx = d_cpu_A->size[0] * d_cpu_A->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (nx + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_A_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, d_cpu_A);
                  }

                  b_A_dirtyOnCpu = false;
                  if (b_V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, c_cpu_V);
                  }

                  ec_detrend_kernel139<<<grid, block>>>(gpu_A, nx, gpu_V);
                  b_V_dirtyOnGpu = true;
                  b_V_dirtyOnCpu = false;
                }
              } else {
                p = (d_cpu_A->size[0] == d_cpu_A->size[1]);
                if (p) {
                  na = 0;
                  exitg2 = false;
                  while ((!exitg2) && (na <= d_cpu_A->size[1] - 1)) {
                    b_i = 0;
                    do {
                      exitg1 = 0;
                      if (b_i <= na) {
                        if (b_A_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &gpu_A);
                        }

                        b_A_dirtyOnGpu = false;
                        if (!(d_cpu_A->data[b_i + d_cpu_A->size[0] * na] ==
                              -d_cpu_A->data[na + d_cpu_A->size[0] * b_i])) {
                          p = false;
                          exitg1 = 1;
                        } else {
                          b_i++;
                        }
                      } else {
                        na++;
                        exitg1 = 2;
                      }
                    } while (exitg1 == 0);

                    if (exitg1 == 1) {
                      exitg2 = true;
                    }
                  }
                }

                if (p) {
                  nx = d_cpu_A->size[0] * d_cpu_A->size[1];
                  for (n = 0; n < nx; n++) {
                    if (p) {
                      if (b_A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &gpu_A);
                      }

                      b_A_dirtyOnGpu = false;
                      if (std::isinf(d_cpu_A->data[n]) || std::isnan
                          (d_cpu_A->data[n])) {
                        p = false;
                      }
                    } else {
                      p = false;
                    }
                  }

                  if (!p) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      sz[b_i] = static_cast<uint32_T>(d_cpu_A->size[b_i]);
                    }

                    b_i = b_cpu_U->size[0] * b_cpu_U->size[1];
                    b_cpu_U->size[0] = static_cast<int32_T>(sz[0]);
                    b_cpu_U->size[1] = static_cast<int32_T>(sz[1]);
                    emxEnsureCapacity_real32_T(b_cpu_U, b_i, &pb_emlrtRTEI);
                    if (!b_U_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_real32_T(b_cpu_U, &gpu_U);
                    }

                    na = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                      - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      if (b_U_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, b_cpu_U);
                      }

                      ec_detrend_kernel131<<<grid, block>>>(na, gpu_U);
                      b_U_dirtyOnGpu = true;
                      b_U_dirtyOnCpu = false;
                    }

                    m = static_cast<int32_T>(sz[0]);
                    if (static_cast<int32_T>(sz[0]) > 1) {
                      cpu_npages = 2;
                      if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>
                          (sz[1]) - 1) {
                        vlen = static_cast<int32_T>(sz[0]) - 1;
                      } else {
                        vlen = static_cast<int32_T>(sz[1]);
                      }

                      for (na = 0; na < vlen; na++) {
                        validLaunchParams = mwGetLaunchParameters1D
                          (static_cast<real_T>(computeEndIdx(static_cast<int64_T>
                             (cpu_npages), static_cast<int64_T>(m), 1L) + 1L),
                           &grid, &block, 1024U, 65535U);
                        if (validLaunchParams) {
                          cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                     cudaMemcpyHostToDevice);
                          if (b_U_dirtyOnCpu) {
                            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, b_cpu_U);
                          }

                          ec_detrend_kernel132<<<grid, block>>>(na + 1,
                            gpu_npages, m, gpu_U, b_cpu_U->size[0U]);
                          b_U_dirtyOnGpu = true;
                          b_U_dirtyOnCpu = false;
                        }

                        cpu_npages++;
                      }
                    }

                    for (b_i = 0; b_i < 2; b_i++) {
                      sz[b_i] = static_cast<uint32_T>(d_cpu_A->size[b_i]);
                    }

                    b_i = d_cpu_A->size[0] * d_cpu_A->size[1];
                    d_cpu_A->size[0] = static_cast<int32_T>(sz[0]);
                    d_cpu_A->size[1] = static_cast<int32_T>(sz[1]);
                    emxEnsureCapacity_real32_T(d_cpu_A, b_i, &yb_emlrtRTEI);
                    if (!b_A_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_real32_T(d_cpu_A, &gpu_A);
                    }

                    na = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                      - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      if (b_A_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, d_cpu_A);
                      }

                      ec_detrend_kernel133<<<grid, block>>>(na, gpu_A);
                      b_A_dirtyOnGpu = true;
                      b_A_dirtyOnCpu = false;
                    }
                  } else {
                    ptrdiff_t d_n_t;
                    ptrdiff_t h_info_t;
                    ptrdiff_t j_info_t;
                    m = d_cpu_A->size[0];
                    b_i = c_cpu_tau->size[0];
                    c_cpu_tau->size[0] = d_cpu_A->size[0] - 1;
                    emxEnsureCapacity_real32_T(c_cpu_tau, b_i, &mb_emlrtRTEI);
                    if (!b_tau_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_real32_T(c_cpu_tau, &b_gpu_tau);
                    }

                    if (d_cpu_A->size[0] > 1) {
                      ptrdiff_t g_info_t;
                      if (b_A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &gpu_A);
                      }

                      g_info_t = LAPACKE_sgehrd(102, (ptrdiff_t)d_cpu_A->size[0],
                        (ptrdiff_t)1, (ptrdiff_t)d_cpu_A->size[0],
                        &d_cpu_A->data[0], (ptrdiff_t)d_cpu_A->size[0],
                        &c_cpu_tau->data[0]);
                      b_tau_dirtyOnCpu = true;
                      b_A_dirtyOnCpu = true;
                      b_A_dirtyOnGpu = false;
                      if ((int32_T)g_info_t != 0) {
                        for (b_i = 0; b_i < 2; b_i++) {
                          V[b_i] = d_cpu_A->size[b_i];
                        }

                        b_i = d_cpu_A->size[0] * d_cpu_A->size[1];
                        d_cpu_A->size[0] = V[0];
                        d_cpu_A->size[1] = V[1];
                        emxEnsureCapacity_real32_T(d_cpu_A, b_i, &wb_emlrtRTEI);
                        na = V[0] * V[1] - 1;
                        validLaunchParams = mwGetLaunchParameters1D
                          (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                           65535U);
                        if (validLaunchParams) {
                          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, d_cpu_A);
                          ec_detrend_kernel125<<<grid, block>>>(na, gpu_A);
                          b_A_dirtyOnGpu = true;
                          b_A_dirtyOnCpu = false;
                        }

                        x[0] = c_cpu_tau->size[0];
                        b_i = c_cpu_tau->size[0];
                        c_cpu_tau->size[0] = x[0];
                        emxEnsureCapacity_real32_T(c_cpu_tau, b_i, &bc_emlrtRTEI);
                        na = x[0] - 1;
                        validLaunchParams = mwGetLaunchParameters1D(static_cast<
                          real_T>(na + 1L), &grid, &block, 1024U, 65535U);
                        if (validLaunchParams) {
                          gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_tau, c_cpu_tau);
                          ec_detrend_kernel126<<<grid, block>>>(x[0] - 1,
                            b_gpu_tau);
                          c_tau_dirtyOnGpu = true;
                          b_tau_dirtyOnCpu = false;
                        }
                      }
                    }

                    b_i = b_cpu_U->size[0] * b_cpu_U->size[1];
                    b_cpu_U->size[0] = d_cpu_A->size[0];
                    b_cpu_U->size[1] = d_cpu_A->size[1];
                    emxEnsureCapacity_real32_T(b_cpu_U, b_i, &rb_emlrtRTEI);
                    if (!b_U_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_real32_T(b_cpu_U, &gpu_U);
                    }

                    nx = d_cpu_A->size[0] * d_cpu_A->size[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(nx + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      if (b_A_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, d_cpu_A);
                      }

                      if (b_U_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, b_cpu_U);
                      }

                      ec_detrend_kernel127<<<grid, block>>>(gpu_A, nx, gpu_U);
                      b_U_dirtyOnGpu = true;
                    }

                    if (b_U_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_U, &gpu_U);
                    }

                    if (c_tau_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_tau, &b_gpu_tau);
                    }

                    c_tau_dirtyOnGpu = false;
                    h_info_t = LAPACKE_sorghr(102, (ptrdiff_t)m, (ptrdiff_t)1,
                      (ptrdiff_t)m, &b_cpu_U->data[0], (ptrdiff_t)m,
                      &c_cpu_tau->data[0]);
                    b_U_dirtyOnGpu = false;
                    if ((int32_T)h_info_t != 0) {
                      for (b_i = 0; b_i < 2; b_i++) {
                        V[b_i] = b_cpu_U->size[b_i];
                      }

                      b_i = b_cpu_U->size[0] * b_cpu_U->size[1];
                      b_cpu_U->size[0] = V[0];
                      b_cpu_U->size[1] = V[1];
                      emxEnsureCapacity_real32_T(b_cpu_U, b_i, &rb_emlrtRTEI);
                      na = V[0] * V[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, b_cpu_U);
                        ec_detrend_kernel128<<<grid, block>>>(na, gpu_U);
                        b_U_dirtyOnGpu = true;
                      }
                    }

                    d_n_t = (ptrdiff_t)d_cpu_A->size[0];
                    b_i = b_wr->size[0] * b_wr->size[1];
                    b_wr->size[0] = 1;
                    b_wr->size[1] = d_cpu_A->size[0];
                    emxEnsureCapacity_real32_T(b_wr, b_i, &ac_emlrtRTEI);
                    b_i = b_wi->size[0] * b_wi->size[1];
                    b_wi->size[0] = 1;
                    b_wi->size[1] = d_cpu_A->size[0];
                    emxEnsureCapacity_real32_T(b_wi, b_i, &ec_emlrtRTEI);
                    if (b_A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &gpu_A);
                    }

                    if (b_U_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_U, &gpu_U);
                    }

                    if (d_cpu_A->size[0] <= 1) {
                      nx = 1;
                    } else {
                      nx = d_cpu_A->size[0];
                    }

                    j_info_t = LAPACKE_shseqr(102, 'S', 'V', d_n_t, (ptrdiff_t)1,
                      (ptrdiff_t)d_cpu_A->size[0], &d_cpu_A->data[0], d_n_t,
                      &b_wr->data[0], &b_wi->data[0], &b_cpu_U->data[0],
                      (ptrdiff_t)nx);
                    b_U_dirtyOnCpu = true;
                    b_U_dirtyOnGpu = false;
                    b_A_dirtyOnCpu = true;
                    b_A_dirtyOnGpu = false;
                    if ((int32_T)j_info_t < 0) {
                      for (b_i = 0; b_i < 2; b_i++) {
                        V[b_i] = d_cpu_A->size[b_i];
                      }

                      b_i = d_cpu_A->size[0] * d_cpu_A->size[1];
                      d_cpu_A->size[0] = V[0];
                      d_cpu_A->size[1] = V[1];
                      emxEnsureCapacity_real32_T(d_cpu_A, b_i, &ic_emlrtRTEI);
                      na = V[0] * V[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, d_cpu_A);
                        ec_detrend_kernel129<<<grid, block>>>(na, gpu_A);
                        b_A_dirtyOnGpu = true;
                        b_A_dirtyOnCpu = false;
                      }

                      for (b_i = 0; b_i < 2; b_i++) {
                        V[b_i] = b_cpu_U->size[b_i];
                      }

                      b_i = b_cpu_U->size[0] * b_cpu_U->size[1];
                      b_cpu_U->size[0] = V[0];
                      b_cpu_U->size[1] = V[1];
                      emxEnsureCapacity_real32_T(b_cpu_U, b_i, &oc_emlrtRTEI);
                      na = V[0] * V[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, b_cpu_U);
                        ec_detrend_kernel130<<<grid, block>>>(na, gpu_U);
                        b_U_dirtyOnGpu = true;
                        b_U_dirtyOnCpu = false;
                      }
                    }
                  }

                  m = d_cpu_A->size[0];
                  b_i = c_cpu_D->size[0] * c_cpu_D->size[1];
                  c_cpu_D->size[0] = d_cpu_A->size[0];
                  c_cpu_D->size[1] = d_cpu_A->size[0];
                  emxEnsureCapacity_creal32_T(c_cpu_D, b_i, &gc_emlrtRTEI);
                  if (!c_D_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal32_T(c_cpu_D, &gpu_D);
                  }

                  nx = d_cpu_A->size[0] * d_cpu_A->size[0] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (nx + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (c_D_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, c_cpu_D);
                    }

                    ec_detrend_kernel134<<<grid, block>>>(nx, gpu_D);
                    c_D_dirtyOnGpu = true;
                    c_D_dirtyOnCpu = false;
                  }

                  b_i = 1;
                  do {
                    exitg1 = 0;
                    if (b_i <= m) {
                      if (b_i != m) {
                        if (b_A_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &gpu_A);
                        }

                        b_A_dirtyOnGpu = false;
                        if (d_cpu_A->data[b_i + d_cpu_A->size[0] * (b_i - 1)] !=
                            0.0F) {
                          d2scaled = std::abs(d_cpu_A->data[b_i + d_cpu_A->size
                                              [0] * (b_i - 1)]);
                          if (c_D_dirtyOnGpu) {
                            gpuEmxMemcpyGpuToCpu_creal32_T(c_cpu_D, &gpu_D);
                          }

                          c_cpu_D->data[(b_i + c_cpu_D->size[0] * (b_i - 1)) - 1]
                            .re = 0.0F;
                          c_cpu_D->data[(b_i + c_cpu_D->size[0] * (b_i - 1)) - 1]
                            .im = d2scaled;
                          c_cpu_D->data[b_i + c_cpu_D->size[0] * b_i].re = 0.0F;
                          c_cpu_D->data[b_i + c_cpu_D->size[0] * b_i].im =
                            -d2scaled;
                          c_D_dirtyOnCpu = true;
                          c_D_dirtyOnGpu = false;
                          b_i += 2;
                        } else {
                          b_i++;
                        }
                      } else {
                        b_i++;
                      }
                    } else {
                      exitg1 = 1;
                    }
                  } while (exitg1 == 0);

                  b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
                  c_cpu_V->size[0] = b_cpu_U->size[0];
                  c_cpu_V->size[1] = b_cpu_U->size[1];
                  emxEnsureCapacity_creal32_T(c_cpu_V, b_i, &kc_emlrtRTEI);
                  if (!b_V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal32_T(c_cpu_V, &gpu_V);
                  }

                  na = b_cpu_U->size[0] * b_cpu_U->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (na + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (b_U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, b_cpu_U);
                    }

                    b_U_dirtyOnCpu = false;
                    if (b_V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, c_cpu_V);
                    }

                    ec_detrend_kernel135<<<grid, block>>>(gpu_U, na, gpu_V);
                    b_V_dirtyOnGpu = true;
                    b_V_dirtyOnCpu = false;
                  }

                  na = 1;
                  m = d_cpu_A->size[0];
                  do {
                    exitg1 = 0;
                    if (na <= m) {
                      if (na != m) {
                        if (b_A_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &gpu_A);
                        }

                        b_A_dirtyOnGpu = false;
                        if (d_cpu_A->data[na + d_cpu_A->size[0] * (na - 1)] !=
                            0.0F) {
                          if (d_cpu_A->data[na + d_cpu_A->size[0] * (na - 1)] <
                              0.0F) {
                            cpu_npages = 1;
                          } else {
                            cpu_npages = -1;
                          }

                          for (b_i = 0; b_i < m; b_i++) {
                            if (b_V_dirtyOnGpu) {
                              gpuEmxMemcpyGpuToCpu_creal32_T(c_cpu_V, &gpu_V);
                            }

                            d2scaled = c_cpu_V->data[b_i + c_cpu_V->size[0] *
                              (na - 1)].re;
                            abnrm = static_cast<real32_T>(cpu_npages) *
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * na].re;
                            if (abnrm == 0.0F) {
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (na - 1)].
                                re = d2scaled / 1.41421354F;
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (na - 1)].
                                im = 0.0F;
                              b_V_dirtyOnGpu = false;
                            } else if (d2scaled == 0.0F) {
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (na - 1)].
                                re = 0.0F;
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (na - 1)].
                                im = abnrm / 1.41421354F;
                              b_V_dirtyOnGpu = false;
                            } else {
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (na - 1)].
                                re = d2scaled / 1.41421354F;
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (na - 1)].
                                im = abnrm / 1.41421354F;
                              b_V_dirtyOnGpu = false;
                            }

                            c_cpu_V->data[b_i + c_cpu_V->size[0] * na].re =
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (na - 1)].
                              re;
                            c_cpu_V->data[b_i + c_cpu_V->size[0] * na].im =
                              -c_cpu_V->data[b_i + c_cpu_V->size[0] * (na - 1)].
                              im;
                            b_V_dirtyOnCpu = true;
                          }

                          na += 2;
                        } else {
                          na++;
                        }
                      } else {
                        na++;
                      }
                    } else {
                      exitg1 = 1;
                    }
                  } while (exitg1 == 0);
                } else {
                  ptrdiff_t i_info_t;
                  m = d_cpu_A->size[0];
                  n = d_cpu_A->size[1] - 1;
                  b_i = b_scale->size[0];
                  b_scale->size[0] = d_cpu_A->size[1];
                  emxEnsureCapacity_real32_T(b_scale, b_i, &gb_emlrtRTEI);
                  b_i = d_cpu_W->size[0];
                  d_cpu_W->size[0] = d_cpu_A->size[1];
                  emxEnsureCapacity_creal32_T(d_cpu_W, b_i, &jb_emlrtRTEI);
                  gpuEmxEnsureCapacity_creal32_T(d_cpu_W, &b_gpu_W);
                  b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
                  c_cpu_V->size[0] = d_cpu_A->size[1];
                  c_cpu_V->size[1] = d_cpu_A->size[1];
                  emxEnsureCapacity_creal32_T(c_cpu_V, b_i, &nb_emlrtRTEI);
                  if (!b_V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal32_T(c_cpu_V, &gpu_V);
                  }

                  b_i = b_cpu_wreal->size[0];
                  b_cpu_wreal->size[0] = d_cpu_A->size[1];
                  emxEnsureCapacity_real32_T(b_cpu_wreal, b_i, &ob_emlrtRTEI);
                  if (!b_wreal_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(b_cpu_wreal, &gpu_wreal);
                  }

                  b_i = b_cpu_wimag->size[0];
                  b_cpu_wimag->size[0] = d_cpu_A->size[1];
                  emxEnsureCapacity_real32_T(b_cpu_wimag, b_i, &qb_emlrtRTEI);
                  if (!b_wimag_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(b_cpu_wimag, &gpu_wimag);
                  }

                  b_i = b_cpu_vright->size[0] * b_cpu_vright->size[1];
                  b_cpu_vright->size[0] = d_cpu_A->size[1];
                  b_cpu_vright->size[1] = d_cpu_A->size[1];
                  emxEnsureCapacity_real32_T(b_cpu_vright, b_i, &ub_emlrtRTEI);
                  if (!b_vright_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(b_cpu_vright, &gpu_vright);
                  }

                  if (b_A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &gpu_A);
                  }

                  i_info_t = LAPACKE_sgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)
                    d_cpu_A->size[1], &d_cpu_A->data[0], (ptrdiff_t)
                    d_cpu_A->size[0], &b_cpu_wreal->data[0], &b_cpu_wimag->data
                    [0], &d2scaled, (ptrdiff_t)1, &b_cpu_vright->data[0],
                    (ptrdiff_t)d_cpu_A->size[1], &b_ilo_t, &b_ihi_t,
                    &b_scale->data[0], &abnrm, &rconde, &rcondv);
                  b_vright_dirtyOnCpu = true;
                  b_wimag_dirtyOnCpu = true;
                  b_wreal_dirtyOnCpu = true;
                  b_A_dirtyOnCpu = true;
                  b_A_dirtyOnGpu = false;
                  if ((int32_T)i_info_t < 0) {
                    x[0] = d_cpu_A->size[1];
                    b_i = d_cpu_W->size[0];
                    d_cpu_W->size[0] = d_cpu_A->size[1];
                    emxEnsureCapacity_creal32_T(d_cpu_W, b_i, &dc_emlrtRTEI);
                    gpuEmxEnsureCapacity_creal32_T(d_cpu_W, &b_gpu_W);
                    na = x[0] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      ec_detrend_kernel122<<<grid, block>>>(gpu_fc2, x[0] - 1,
                        b_gpu_W);
                      d_W_dirtyOnGpu = true;
                    }

                    for (b_i = 0; b_i < 2; b_i++) {
                      V[b_i] = c_cpu_V->size[b_i];
                    }

                    b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
                    c_cpu_V->size[0] = V[0];
                    c_cpu_V->size[1] = V[1];
                    emxEnsureCapacity_creal32_T(c_cpu_V, b_i, &hc_emlrtRTEI);
                    if (!b_V_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_creal32_T(c_cpu_V, &gpu_V);
                    }

                    na = V[0] * V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      if (b_V_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, c_cpu_V);
                      }

                      ec_detrend_kernel123<<<grid, block>>>(gpu_fc2, na, gpu_V);
                      b_V_dirtyOnGpu = true;
                      b_V_dirtyOnCpu = false;
                    }
                  } else {
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(n + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_wimag, b_cpu_wimag);
                      b_wimag_dirtyOnCpu = false;
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_wreal, b_cpu_wreal);
                      b_wreal_dirtyOnCpu = false;
                      ec_detrend_kernel119<<<grid, block>>>(gpu_wimag, gpu_wreal,
                        n, b_gpu_W);
                      d_W_dirtyOnGpu = true;
                    }

                    b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
                    c_cpu_V->size[0] = b_cpu_vright->size[0];
                    c_cpu_V->size[1] = b_cpu_vright->size[1];
                    emxEnsureCapacity_creal32_T(c_cpu_V, b_i, &fc_emlrtRTEI);
                    if (!b_V_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_creal32_T(c_cpu_V, &gpu_V);
                    }

                    na = b_cpu_vright->size[0] * b_cpu_vright->size[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D(static_cast<
                      real_T>(na + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_vright, b_cpu_vright);
                      b_vright_dirtyOnCpu = false;
                      if (b_V_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, c_cpu_V);
                      }

                      ec_detrend_kernel120<<<grid, block>>>(gpu_vright, na,
                        gpu_V);
                      b_V_dirtyOnGpu = true;
                      b_V_dirtyOnCpu = false;
                    }

                    for (b_i = 0; b_i < n; b_i++) {
                      cpu_npages = b_i + 2;
                      if ((b_cpu_wimag->data[b_i] > 0.0F) && (b_cpu_wimag->
                           data[b_i + 1] < 0.0F)) {
                        validLaunchParams = mwGetLaunchParameters1D(static_cast<
                          real_T>(n + 1L), &grid, &block, 1024U, 65535U);
                        if (validLaunchParams) {
                          cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                     cudaMemcpyHostToDevice);
                          if (b_V_dirtyOnCpu) {
                            gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, c_cpu_V);
                          }

                          ec_detrend_kernel121<<<grid, block>>>(gpu_npages, n,
                            gpu_V, c_cpu_V->size[0U]);
                          b_V_dirtyOnGpu = true;
                          b_V_dirtyOnCpu = false;
                        }
                      }
                    }
                  }

                  b_i = c_cpu_D->size[0] * c_cpu_D->size[1];
                  c_cpu_D->size[0] = d_cpu_A->size[0];
                  c_cpu_D->size[1] = d_cpu_A->size[0];
                  emxEnsureCapacity_creal32_T(c_cpu_D, b_i, &jc_emlrtRTEI);
                  if (!c_D_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal32_T(c_cpu_D, &gpu_D);
                  }

                  nx = d_cpu_A->size[0] * d_cpu_A->size[0] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (nx + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (c_D_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, c_cpu_D);
                    }

                    ec_detrend_kernel124<<<grid, block>>>(nx, gpu_D);
                    c_D_dirtyOnGpu = true;
                    c_D_dirtyOnCpu = false;
                  }

                  for (n = 0; n < m; n++) {
                    if (c_D_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_creal32_T(c_cpu_D, &gpu_D);
                    }

                    if (d_W_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_creal32_T(d_cpu_W, &b_gpu_W);
                    }

                    d_W_dirtyOnGpu = false;
                    c_cpu_D->data[n + c_cpu_D->size[0] * n] = d_cpu_W->data[n];
                    c_D_dirtyOnCpu = true;
                    c_D_dirtyOnGpu = false;
                  }
                }
              }
            }
          }

          // 'ec_detrend:175' V = real(V);
          b_i = d_cpu_V->size[0] * d_cpu_V->size[1];
          d_cpu_V->size[0] = c_cpu_V->size[0];
          d_cpu_V->size[1] = c_cpu_V->size[1];
          emxEnsureCapacity_real32_T(d_cpu_V, b_i, &bb_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(d_cpu_V, &b_gpu_V);
          na = c_cpu_V->size[0] * c_cpu_V->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_V_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, c_cpu_V);
            }

            b_V_dirtyOnCpu = false;
            ec_detrend_kernel142<<<grid, block>>>(gpu_V, na, b_gpu_V);
          }

          // 'ec_detrend:176' D = diag(real(D));
          b_i = b_cpu_fcnOutput->size[0] * b_cpu_fcnOutput->size[1];
          b_cpu_fcnOutput->size[0] = c_cpu_D->size[0];
          b_cpu_fcnOutput->size[1] = c_cpu_D->size[1];
          emxEnsureCapacity_real32_T(b_cpu_fcnOutput, b_i, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(b_cpu_fcnOutput, &gpu_fcnOutput);
          na = c_cpu_D->size[0] * c_cpu_D->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_D_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, c_cpu_D);
            }

            c_D_dirtyOnCpu = false;
            ec_detrend_kernel143<<<grid, block>>>(gpu_D, na, gpu_fcnOutput);
            b_fcnOutput_dirtyOnGpu = true;
          }

          if ((b_cpu_fcnOutput->size[0] == 1) && (b_cpu_fcnOutput->size[1] == 1))
          {
            b_i = d_cpu_D->size[0];
            d_cpu_D->size[0] = 1;
            emxEnsureCapacity_real32_T(d_cpu_D, b_i, &ib_emlrtRTEI);
            if (!d_D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(d_cpu_D, &b_gpu_D);
            }

            if (b_fcnOutput_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_fcnOutput, &gpu_fcnOutput);
            }

            b_fcnOutput_dirtyOnGpu = false;
            d_cpu_D->data[0] = b_cpu_fcnOutput->data[0];
            d_D_dirtyOnCpu = true;
          } else {
            n = b_cpu_fcnOutput->size[0];
            vlen = b_cpu_fcnOutput->size[1];
            if (n <= vlen) {
              vlen = n;
            }

            if (b_cpu_fcnOutput->size[1] > 0) {
              cpu_npages = vlen;
            } else {
              cpu_npages = 0;
            }

            b_i = d_cpu_D->size[0];
            d_cpu_D->size[0] = cpu_npages;
            emxEnsureCapacity_real32_T(d_cpu_D, b_i, &fb_emlrtRTEI);
            if (!d_D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(d_cpu_D, &b_gpu_D);
            }

            cpu_npages--;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              if (d_D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_D, d_cpu_D);
              }

              ec_detrend_kernel144<<<grid, block>>>(gpu_fcnOutput, gpu_npages,
                b_gpu_D, b_cpu_fcnOutput->size[0U]);
              d_D_dirtyOnGpu = true;
              d_D_dirtyOnCpu = false;
            }
          }

          // 'ec_detrend:177' V = V(:,D/max(D)>thrPCA);
          vlen = d_cpu_D->size[0];
          if (d_D_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_D, &b_gpu_D);
          }

          d_D_dirtyOnGpu = false;
          d2scaled = d_cpu_D->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            if (std::isnan(d_cpu_D->data[b_i + 1])) {
              p = false;
            } else if (std::isnan(d2scaled)) {
              p = true;
            } else {
              p = (d2scaled < d_cpu_D->data[b_i + 1]);
            }

            if (p) {
              d2scaled = d_cpu_D->data[b_i + 1];
            }
          }

          n = d_cpu_D->size[0] - 1;
          vlen = 0;
          for (b_i = 0; b_i <= n; b_i++) {
            if (d_cpu_D->data[b_i] / d2scaled > 1.0E-7F) {
              vlen++;
            }
          }

          b_i = cpu_iv2->size[0];
          cpu_iv2->size[0] = vlen;
          emxEnsureCapacity_int32_T(cpu_iv2, b_i, &vb_emlrtRTEI);
          if (!iv2_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(cpu_iv2, &gpu_iv2);
          }

          cpu_npages = 0;
          for (b_i = 0; b_i <= n; b_i++) {
            if (d_cpu_D->data[b_i] / d2scaled > 1.0E-7F) {
              cpu_iv2->data[cpu_npages] = b_i;
              iv2_dirtyOnCpu = true;
              cpu_npages++;
            }
          }

          vlen = d_cpu_V->size[0];
          b_i = f_cpu_V->size[0] * f_cpu_V->size[1];
          f_cpu_V->size[0] = d_cpu_V->size[0];
          f_cpu_V->size[1] = cpu_iv2->size[0];
          emxEnsureCapacity_real32_T(f_cpu_V, b_i, &xb_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(f_cpu_V, &c_gpu_V);
          na = cpu_iv2->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen *
            (na + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (iv2_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv2, cpu_iv2);
            }

            iv2_dirtyOnCpu = false;
            ec_detrend_kernel145<<<grid, block>>>(gpu_iv2, b_gpu_V, vlen, na,
              c_gpu_V, f_cpu_V->size[0U], d_cpu_V->size[0U]);
          }

          b_i = d_cpu_V->size[0] * d_cpu_V->size[1];
          d_cpu_V->size[0] = f_cpu_V->size[0];
          d_cpu_V->size[1] = f_cpu_V->size[1];
          emxEnsureCapacity_real32_T(d_cpu_V, b_i, &cc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(d_cpu_V, &b_gpu_V);
          na = f_cpu_V->size[0] * f_cpu_V->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel146<<<grid, block>>>(c_gpu_V, na, b_gpu_V);
          }

          //  discard weak dims
          // 'ec_detrend:178' rr = rr*V;
          vlen = b_cpu_rr->size[0];
          cpu_npages = b_cpu_rr->size[1];
          if ((b_cpu_rr->size[0] == 0) || (b_cpu_rr->size[1] == 0) ||
              (d_cpu_V->size[0] == 0) || (d_cpu_V->size[1] == 0)) {
            cpu_npages = b_cpu_rr->size[0];
            V[0] = b_cpu_rr->size[0];
            V[1] = d_cpu_V->size[1];
            b_i = b_cpu_rr->size[0] * b_cpu_rr->size[1];
            b_cpu_rr->size[0] = cpu_npages;
            b_cpu_rr->size[1] = d_cpu_V->size[1];
            emxEnsureCapacity_real32_T(b_cpu_rr, b_i, &nc_emlrtRTEI);
            if (!b_rr_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(b_cpu_rr, &gpu_rr);
            }

            na = V[0] * V[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_rr_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, b_cpu_rr);
              }

              ec_detrend_kernel148<<<grid, block>>>(na, gpu_rr);
              b_rr_dirtyOnGpu = true;
              b_rr_dirtyOnCpu = false;
            }
          } else {
            b_i = f_cpu_A->size[0] * f_cpu_A->size[1];
            f_cpu_A->size[0] = b_cpu_rr->size[0];
            f_cpu_A->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real32_T(f_cpu_A, b_i, &mc_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(f_cpu_A, &d_gpu_A);
            nx = b_cpu_rr->size[0] * b_cpu_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_rr_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, b_cpu_rr);
              }

              b_rr_dirtyOnCpu = false;
              ec_detrend_kernel147<<<grid, block>>>(gpu_rr, nx, d_gpu_A);
            }

            b_i = b_cpu_rr->size[0] * b_cpu_rr->size[1];
            b_cpu_rr->size[0] = vlen;
            b_cpu_rr->size[1] = d_cpu_V->size[1];
            emxEnsureCapacity_real32_T(b_cpu_rr, b_i, &x_emlrtRTEI);
            if (!b_rr_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(b_cpu_rr, &gpu_rr);
            }

            d2scaled = 1.0F;
            abnrm = 0.0F;
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, b_cpu_rr);
            }

            cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, vlen,
                        d_cpu_V->size[1], cpu_npages, (float *)&d2scaled, (float
              *)&d_gpu_A.data[0], vlen, (float *)&b_gpu_V.data[0], cpu_npages,
                        (float *)&abnrm, (float *)&gpu_rr.data[0], vlen);
            b_rr_dirtyOnGpu = true;
            b_rr_dirtyOnCpu = false;
          }

          // 'ec_detrend:179' b = (x'*rr) / (rr'*rr);
          b_i = f_cpu_a->size[0] * f_cpu_a->size[1];
          f_cpu_a->size[0] = 1;
          f_cpu_a->size[1] = cpu_fv7->size[0];
          emxEnsureCapacity_real32_T(f_cpu_a, b_i, &pc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(f_cpu_a, &c_gpu_a);
          na = cpu_fv7->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (fv7_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv7, cpu_fv7);
            }

            fv7_dirtyOnCpu = false;
            ec_detrend_kernel149<<<grid, block>>>(gpu_fv7, na, c_gpu_a);
          }

          if ((cpu_fv7->size[0] == 0) || (b_cpu_rr->size[0] == 0) ||
              (b_cpu_rr->size[1] == 0)) {
            b_i = c_cpu_b->size[0] * c_cpu_b->size[1];
            c_cpu_b->size[0] = 1;
            c_cpu_b->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real32_T(c_cpu_b, b_i, &m_emlrtRTEI);
            if (!b_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(c_cpu_b, &gpu_b);
            }

            nx = b_cpu_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, c_cpu_b);
              }

              ec_detrend_kernel150<<<grid, block>>>(nx, gpu_b);
              b_b_dirtyOnCpu = false;
            }
          } else {
            b_i = c_cpu_b->size[0] * c_cpu_b->size[1];
            c_cpu_b->size[0] = 1;
            c_cpu_b->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real32_T(c_cpu_b, b_i, &x_emlrtRTEI);
            if (!b_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(c_cpu_b, &gpu_b);
            }

            d2scaled = 1.0F;
            abnrm = 0.0F;
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, b_cpu_rr);
            }

            b_rr_dirtyOnCpu = false;
            if (b_b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, c_cpu_b);
            }

            cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                        b_cpu_rr->size[1], cpu_fv7->size[0], (float *)&d2scaled,
                        (float *)&c_gpu_a.data[0], 1, (float *)&gpu_rr.data[0],
                        cpu_fv7->size[0], (float *)&abnrm, (float *)&gpu_b.data
                        [0], 1);
            b_b_dirtyOnCpu = false;
          }

          b_i = g_cpu_a->size[0] * g_cpu_a->size[1];
          g_cpu_a->size[0] = b_cpu_rr->size[1];
          g_cpu_a->size[1] = b_cpu_rr->size[0];
          emxEnsureCapacity_real32_T(g_cpu_a, b_i, &qc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(g_cpu_a, &d_gpu_a);
          nx = b_cpu_rr->size[0] - 1;
          na = b_cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((na +
            1L) * (nx + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, b_cpu_rr);
            }

            b_rr_dirtyOnCpu = false;
            ec_detrend_kernel151<<<grid, block>>>(gpu_rr, na, nx, d_gpu_a,
              g_cpu_a->size[0U], b_cpu_rr->size[0U]);
          }

          if ((g_cpu_a->size[0] == 0) || (g_cpu_a->size[1] == 0) ||
              (b_cpu_rr->size[0] == 0) || (b_cpu_rr->size[1] == 0)) {
            b_i = g_cpu_A->size[0] * g_cpu_A->size[1];
            g_cpu_A->size[0] = g_cpu_a->size[0];
            g_cpu_A->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real32_T(g_cpu_A, b_i, &m_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(g_cpu_A, &b_gpu_A);
            na = g_cpu_a->size[0] * b_cpu_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel152<<<grid, block>>>(na, b_gpu_A);
            }
          } else {
            b_i = g_cpu_A->size[0] * g_cpu_A->size[1];
            g_cpu_A->size[0] = g_cpu_a->size[0];
            g_cpu_A->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real32_T(g_cpu_A, b_i, &x_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(g_cpu_A, &b_gpu_A);
            d2scaled = 1.0F;
            abnrm = 0.0F;
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, b_cpu_rr);
            }

            b_rr_dirtyOnCpu = false;
            cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        g_cpu_a->size[0], b_cpu_rr->size[1], g_cpu_a->size[1],
                        (float *)&d2scaled, (float *)&d_gpu_a.data[0],
                        g_cpu_a->size[0], (float *)&gpu_rr.data[0],
                        g_cpu_a->size[1], (float *)&abnrm, (float *)
                        &b_gpu_A.data[0], g_cpu_a->size[0]);
          }

          if ((c_cpu_b->size[1] == 0) || ((g_cpu_A->size[0] == 0) ||
               (g_cpu_A->size[1] == 0))) {
            sz[1] = static_cast<uint32_T>(g_cpu_A->size[0]);
            b_i = c_cpu_b->size[0] * c_cpu_b->size[1];
            c_cpu_b->size[0] = 1;
            c_cpu_b->size[1] = g_cpu_A->size[0];
            emxEnsureCapacity_real32_T(c_cpu_b, b_i, &tc_emlrtRTEI);
            if (!b_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(c_cpu_b, &gpu_b);
            }

            na = static_cast<int32_T>(sz[1]) - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, c_cpu_b);
              }

              ec_detrend_kernel167<<<grid, block>>>(static_cast<int32_T>(sz[1])
                - 1, gpu_b);
              b_b_dirtyOnCpu = false;
            }
          } else if (g_cpu_A->size[0] == g_cpu_A->size[1]) {
            m = g_cpu_A->size[1] - 2;
            b_i = b_cpu_ipiv_t->size[0];
            b_cpu_ipiv_t->size[0] = g_cpu_A->size[1];
            emxEnsureCapacity_int32_T(b_cpu_ipiv_t, b_i, &rc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_cpu_ipiv_t, &gpu_ipiv_t);
            cusolverDnSgetrf_bufferSize(getCuSolverGlobalHandle(), g_cpu_A->
              size[1], g_cpu_A->size[1], (float *)&b_gpu_A.data[0],
              g_cpu_A->size[1], getCuSolverWorkspaceReq());
            setCuSolverWorkspaceTypeSize(4);
            cusolverInitWorkspace();
            cusolverDnSgetrf(getCuSolverGlobalHandle(), g_cpu_A->size[1],
                             g_cpu_A->size[1], (float *)&b_gpu_A.data[0],
                             g_cpu_A->size[1], static_cast<real32_T *>
                             (getCuSolverWorkspaceBuff()), &gpu_ipiv_t.data[0],
                             gpu_info);
            b_i = b_cpu_ipiv->size[0] * b_cpu_ipiv->size[1];
            b_cpu_ipiv->size[0] = 1;
            b_cpu_ipiv->size[1] = b_cpu_ipiv_t->size[0];
            emxEnsureCapacity_int32_T(b_cpu_ipiv, b_i, &uc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_cpu_ipiv, &gpu_ipiv);
            cudaMemcpy(&b_cpu_info, gpu_info, 4UL, cudaMemcpyDeviceToHost);
            if (b_cpu_info < 0) {
              for (b_i = 0; b_i < 2; b_i++) {
                V[b_i] = g_cpu_A->size[b_i];
              }

              b_i = g_cpu_A->size[0] * g_cpu_A->size[1];
              g_cpu_A->size[0] = V[0];
              g_cpu_A->size[1] = V[1];
              emxEnsureCapacity_real32_T(g_cpu_A, b_i, &xc_emlrtRTEI);
              gpuEmxEnsureCapacity_real32_T(g_cpu_A, &b_gpu_A);
              na = V[0] * V[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_detrend_kernel165<<<grid, block>>>(na, b_gpu_A);
              }

              cpu_npages = b_cpu_ipiv->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (cpu_npages + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
                ec_detrend_kernel166<<<grid, block>>>(gpu_npages, gpu_ipiv);
                b_ipiv_dirtyOnGpu = true;
              }
            } else {
              cpu_npages = b_cpu_ipiv_t->size[0] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (cpu_npages + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
                ec_detrend_kernel164<<<grid, block>>>(gpu_ipiv_t, gpu_npages,
                  gpu_ipiv);
                b_ipiv_dirtyOnGpu = true;
              }
            }

            d2scaled = 1.0F;
            if (b_b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, c_cpu_b);
            }

            cublasStrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                        CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N,
                        CUBLAS_DIAG_NON_UNIT, 1, m + 2, (float *)&d2scaled,
                        (float *)&b_gpu_A.data[0], m + 2, (float *)&gpu_b.data[0],
                        1);
            cublasStrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                        CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                        m + 2, (float *)&d2scaled, (float *)&b_gpu_A.data[0], m
                        + 2, (float *)&gpu_b.data[0], 1);
            p = true;
            b_b_dirtyOnCpu = false;
            for (na = 0; na <= m; na++) {
              if (b_ipiv_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_ipiv, &gpu_ipiv);
              }

              b_ipiv_dirtyOnGpu = false;
              if (b_cpu_ipiv->data[m - na] != (m - na) + 1) {
                if (p) {
                  gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_b, &gpu_b);
                }

                d2scaled = c_cpu_b->data[m - na];
                c_cpu_b->data[m - na] = c_cpu_b->data[b_cpu_ipiv->data[m - na] -
                  1];
                c_cpu_b->data[b_cpu_ipiv->data[m - na] - 1] = d2scaled;
                b_b_dirtyOnCpu = true;
                p = false;
              }
            }
          } else {
            ptrdiff_t l_info_t;
            boolean_T c_A_dirtyOnCpu;
            b_i = h_cpu_A->size[0] * h_cpu_A->size[1];
            h_cpu_A->size[0] = g_cpu_A->size[1];
            h_cpu_A->size[1] = g_cpu_A->size[0];
            emxEnsureCapacity_real32_T(h_cpu_A, b_i, &sc_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(h_cpu_A, &c_gpu_A);
            nx = g_cpu_A->size[0] - 1;
            na = g_cpu_A->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((na
              + 1L) * (nx + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel153<<<grid, block>>>(b_gpu_A, na, nx, c_gpu_A,
                h_cpu_A->size[0U], g_cpu_A->size[0U]);
              d_A_dirtyOnGpu = true;
            }

            b_i = b_cpu_B->size[0];
            b_cpu_B->size[0] = c_cpu_b->size[1];
            emxEnsureCapacity_real32_T(b_cpu_B, b_i, &vc_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(b_cpu_B, &gpu_B);
            na = c_cpu_b->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, c_cpu_b);
              }

              b_b_dirtyOnCpu = false;
              ec_detrend_kernel154<<<grid, block>>>(gpu_b, na, gpu_B);
            }

            m = h_cpu_A->size[0];
            na = h_cpu_A->size[1] - 1;
            b_i = b_cpu_jpvt->size[0] * b_cpu_jpvt->size[1];
            b_cpu_jpvt->size[0] = 1;
            b_cpu_jpvt->size[1] = h_cpu_A->size[1];
            emxEnsureCapacity_int32_T(b_cpu_jpvt, b_i, &yc_emlrtRTEI);
            if (!b_jpvt_dirtyOnCpu) {
              gpuEmxEnsureCapacity_int32_T(b_cpu_jpvt, &gpu_jpvt);
            }

            nx = h_cpu_A->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, b_cpu_jpvt);
              }

              ec_detrend_kernel155<<<grid, block>>>(nx, gpu_jpvt);
              b_jpvt_dirtyOnGpu = true;
              b_jpvt_dirtyOnCpu = false;
            }

            n = h_cpu_A->size[0];
            nx = h_cpu_A->size[1];
            if (n <= nx) {
              nx = n;
            }

            b_i = d_cpu_tau->size[0];
            d_cpu_tau->size[0] = nx;
            emxEnsureCapacity_real32_T(d_cpu_tau, b_i, &ad_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(d_cpu_tau, &gpu_tau);
            b_i = b_jpvt_t->size[0];
            b_jpvt_t->size[0] = h_cpu_A->size[1];
            emxEnsureCapacity_ptrdiff_t(b_jpvt_t, b_i, &bd_emlrtRTEI);
            for (b_i = 0; b_i < h_cpu_A->size[1]; b_i++) {
              b_jpvt_t->data[b_i] = (ptrdiff_t)0;
            }

            if (d_A_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(h_cpu_A, &c_gpu_A);
            }

            if (d_tau_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_tau, &gpu_tau);
            }

            l_info_t = LAPACKE_sgeqp3(102, (ptrdiff_t)h_cpu_A->size[0],
              (ptrdiff_t)h_cpu_A->size[1], &h_cpu_A->data[0], (ptrdiff_t)
              h_cpu_A->size[0], &b_jpvt_t->data[0], &d_cpu_tau->data[0]);
            p = true;
            d_tau_dirtyOnGpu = false;
            c_A_dirtyOnCpu = true;
            d_A_dirtyOnGpu = false;
            if ((int32_T)l_info_t != 0) {
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m *
                (na + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_A, h_cpu_A);
                ec_detrend_kernel156<<<grid, block>>>(m, na, c_gpu_A,
                  h_cpu_A->size[0U]);
                d_A_dirtyOnGpu = true;
                c_A_dirtyOnCpu = false;
              }

              n = h_cpu_A->size[0];
              vlen = h_cpu_A->size[1];
              if (n <= vlen) {
                vlen = n;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vlen), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_tau, d_cpu_tau);
                ec_detrend_kernel157<<<grid, block>>>(vlen, gpu_tau);
                d_tau_dirtyOnGpu = true;
                p = false;
              }

              cpu_npages = vlen + 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (computeEndIdx(static_cast<int64_T>(cpu_npages),
                               static_cast<int64_T>(nx), 1L) + 1L), &grid,
                &block, 1024U, 65535U);
              if (validLaunchParams) {
                cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
                if (p) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_tau, d_cpu_tau);
                }

                ec_detrend_kernel158<<<grid, block>>>(gpu_npages, nx, gpu_tau);
                d_tau_dirtyOnGpu = true;
                p = false;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_jpvt_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, b_cpu_jpvt);
                }

                ec_detrend_kernel159<<<grid, block>>>(na, gpu_jpvt);
                b_jpvt_dirtyOnGpu = true;
                b_jpvt_dirtyOnCpu = false;
              }
            } else {
              for (n = 0; n <= na; n++) {
                if (b_jpvt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_jpvt, &gpu_jpvt);
                }

                b_cpu_jpvt->data[n] = (int32_T)b_jpvt_t->data[n];
                b_jpvt_dirtyOnCpu = true;
                b_jpvt_dirtyOnGpu = false;
              }
            }

            nx = -1;
            if (h_cpu_A->size[0] < h_cpu_A->size[1]) {
              vlen = h_cpu_A->size[0];
              cpu_npages = h_cpu_A->size[1];
            } else {
              vlen = h_cpu_A->size[1];
              cpu_npages = h_cpu_A->size[0];
            }

            if (d_A_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(h_cpu_A, &c_gpu_A);
            }

            d_A_dirtyOnGpu = false;
            d2scaled = std::fmin(0.000345266977F, 1.1920929E-6F *
                                 static_cast<real32_T>(cpu_npages)) * std::abs
              (h_cpu_A->data[0]);
            while ((nx + 1 < vlen) && (!(std::abs(h_cpu_A->data[(nx +
                       h_cpu_A->size[0] * (nx + 1)) + 1]) <= d2scaled))) {
              nx++;
            }

            cpu_npages = h_cpu_A->size[1];
            b_i = b_cpu_Y->size[0];
            b_cpu_Y->size[0] = h_cpu_A->size[1];
            emxEnsureCapacity_real32_T(b_cpu_Y, b_i, &ed_emlrtRTEI);
            if (!b_Y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(b_cpu_Y, &gpu_Y);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              if (b_Y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_Y, b_cpu_Y);
              }

              ec_detrend_kernel160<<<grid, block>>>(gpu_npages, gpu_Y);
              b_Y_dirtyOnGpu = true;
              b_Y_dirtyOnCpu = false;
            }

            cpu_npages = 0;
            n = h_cpu_A->size[0];
            vlen = h_cpu_A->size[1];
            if (n <= vlen) {
              vlen = n;
            }

            if (c_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_A, h_cpu_A);
            }

            if (p) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_tau, d_cpu_tau);
            }

            cusolverDnSormqr_bufferSize(getCuSolverGlobalHandle(),
              CUBLAS_SIDE_LEFT, CUBLAS_OP_T, b_cpu_B->size[0], 1, vlen, (float *)
              &c_gpu_A.data[0], h_cpu_A->size[0], (float *)&gpu_tau.data[0],
              (float *)&gpu_B.data[0], b_cpu_B->size[0], getCuSolverWorkspaceReq
              ());
            setCuSolverWorkspaceTypeSize(4);
            cusolverInitWorkspace();
            cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
            cusolverDnSormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                             CUBLAS_OP_T, b_cpu_B->size[0], 1, vlen, (float *)
                             &c_gpu_A.data[0], h_cpu_A->size[0], (float *)
                             &gpu_tau.data[0], (float *)&gpu_B.data[0],
                             b_cpu_B->size[0], static_cast<real32_T *>
                             (getCuSolverWorkspaceBuff()),
                             *getCuSolverWorkspaceReq(), gpu_npages);
            cudaMemcpy(&cpu_npages, gpu_npages, 4UL, cudaMemcpyDeviceToHost);
            if (cpu_npages < 0) {
              x[0] = b_cpu_B->size[0];
              b_i = b_cpu_B->size[0];
              b_cpu_B->size[0] = x[0];
              emxEnsureCapacity_real32_T(b_cpu_B, b_i, &gd_emlrtRTEI);
              gpuEmxEnsureCapacity_real32_T(b_cpu_B, &gpu_B);
              na = x[0] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_detrend_kernel161<<<grid, block>>>(x[0] - 1, gpu_B);
              }
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, b_cpu_jpvt);
              }

              b_jpvt_dirtyOnCpu = false;
              if (b_Y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_Y, b_cpu_Y);
              }

              ec_detrend_kernel162<<<grid, block>>>(gpu_B, gpu_jpvt, nx, gpu_Y);
              b_Y_dirtyOnGpu = true;
              b_Y_dirtyOnCpu = false;
            }

            for (na = 0; na <= nx; na++) {
              if (b_Y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_Y, &gpu_Y);
              }

              if (b_jpvt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_jpvt, &gpu_jpvt);
              }

              b_jpvt_dirtyOnGpu = false;
              b_cpu_Y->data[b_cpu_jpvt->data[nx - na] - 1] /= h_cpu_A->data[(nx
                - na) + h_cpu_A->size[0] * (nx - na)];
              b_Y_dirtyOnCpu = true;
              b_Y_dirtyOnGpu = false;
              cpu_npages = nx - na;
              for (b_i = 0; b_i < cpu_npages; b_i++) {
                b_cpu_Y->data[b_cpu_jpvt->data[b_i] - 1] -= b_cpu_Y->
                  data[b_cpu_jpvt->data[nx - na] - 1] * h_cpu_A->data[b_i +
                  h_cpu_A->size[0] * (nx - na)];
              }
            }

            b_i = c_cpu_b->size[0] * c_cpu_b->size[1];
            c_cpu_b->size[0] = 1;
            c_cpu_b->size[1] = b_cpu_Y->size[0];
            emxEnsureCapacity_real32_T(c_cpu_b, b_i, &tc_emlrtRTEI);
            if (!b_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(c_cpu_b, &gpu_b);
            }

            na = b_cpu_Y->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_Y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_Y, b_cpu_Y);
              }

              b_Y_dirtyOnCpu = false;
              if (b_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, c_cpu_b);
              }

              ec_detrend_kernel163<<<grid, block>>>(gpu_Y, na, gpu_b);
              b_b_dirtyOnCpu = false;
            }
          }

          // 'ec_detrend:180' z = r*(V*b') + mn;
          b_i = d_cpu_b->size[0];
          d_cpu_b->size[0] = c_cpu_b->size[1];
          emxEnsureCapacity_real32_T(d_cpu_b, b_i, &wc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(d_cpu_b, &b_gpu_b);
          na = c_cpu_b->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, c_cpu_b);
            }

            b_b_dirtyOnCpu = false;
            ec_detrend_kernel168<<<grid, block>>>(gpu_b, na, b_gpu_b);
          }

          if ((d_cpu_V->size[0] == 0) || (d_cpu_V->size[1] == 0) ||
              (d_cpu_b->size[0] == 0)) {
            b_i = i_cpu_c->size[0];
            i_cpu_c->size[0] = d_cpu_V->size[0];
            emxEnsureCapacity_real32_T(i_cpu_c, b_i, &m_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(i_cpu_c, &d_gpu_c);
            na = d_cpu_V->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel169<<<grid, block>>>(na, d_gpu_c);
            }
          } else {
            b_i = i_cpu_c->size[0];
            i_cpu_c->size[0] = d_cpu_V->size[0];
            emxEnsureCapacity_real32_T(i_cpu_c, b_i, &x_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(i_cpu_c, &d_gpu_c);
            d2scaled = 1.0F;
            abnrm = 0.0F;
            cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        d_cpu_V->size[0], 1, d_cpu_V->size[1], (float *)
                        &d2scaled, (float *)&b_gpu_V.data[0], d_cpu_V->size[0],
                        (float *)&b_gpu_b.data[0], d_cpu_V->size[1], (float *)
                        &abnrm, (float *)&d_gpu_c.data[0], d_cpu_V->size[0]);
          }

          if ((b_cpu_r->size[0] == 0) || (b_cpu_r->size[1] == 0) ||
              (i_cpu_c->size[0] == 0)) {
            b_i = cpu_fv9->size[0];
            cpu_fv9->size[0] = b_cpu_r->size[0];
            emxEnsureCapacity_real32_T(cpu_fv9, b_i, &m_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(cpu_fv9, &gpu_fv9);
            na = b_cpu_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel170<<<grid, block>>>(na, gpu_fv9);
              fv9_dirtyOnGpu = true;
            }
          } else {
            b_i = cpu_fv9->size[0];
            cpu_fv9->size[0] = b_cpu_r->size[0];
            emxEnsureCapacity_real32_T(cpu_fv9, b_i, &x_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(cpu_fv9, &gpu_fv9);
            d2scaled = 1.0F;
            abnrm = 0.0F;
            if (r_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_r, b_cpu_r);
            }

            r_dirtyOnCpu = false;
            cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        b_cpu_r->size[0], 1, b_cpu_r->size[1], (float *)
                        &d2scaled, (float *)&gpu_r.data[0], b_cpu_r->size[0],
                        (float *)&d_gpu_c.data[0], b_cpu_r->size[1], (float *)
                        &abnrm, (float *)&gpu_fv9.data[0], b_cpu_r->size[0]);
            fv9_dirtyOnGpu = true;
          }

          if (cpu_fv9->size[0] == cpu_fv2->size[0]) {
            b_i = c_cpu_z->size[0];
            c_cpu_z->size[0] = cpu_fv9->size[0];
            emxEnsureCapacity_real32_T(c_cpu_z, b_i, &cd_emlrtRTEI);
            if (!b_z_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(c_cpu_z, &gpu_z);
            }

            na = cpu_fv9->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_z_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, c_cpu_z);
              }

              ec_detrend_kernel171<<<grid, block>>>(b_out, gpu_fv2, gpu_fv9, na,
                gpu_z);
              c_z_dirtyOnGpu = true;
              b_z_dirtyOnCpu = false;
            }
          } else {
            if (c_z_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_z, &gpu_z);
            }

            if (fv9_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv9, &gpu_fv9);
            }

            fv9_dirtyOnGpu = false;
            if (fv2_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
            }

            fv2_dirtyOnGpu = false;
            b_binary_expand_op(c_cpu_z, cpu_fv9, cpu_fv2, b_out);
            b_z_dirtyOnCpu = true;
            c_z_dirtyOnGpu = false;
          }

          //  Find outliers
          // 'ec_detrend:88' d = (x-z).*w;
          if (cpu_vec->size[1] == 1) {
            nx = c_cpu_z->size[0];
          } else {
            nx = cpu_vec->size[1];
          }

          if ((c_cpu_z->size[0] == cpu_vec->size[1]) && (nx == b_cpu_vec->size[1]))
          {
            cpu_npages = cpu_vec->size[1];
            b_i = j_cpu_c->size[0] * j_cpu_c->size[1];
            j_cpu_c->size[0] = cpu_vec->size[1];
            j_cpu_c->size[1] = 1;
            emxEnsureCapacity_real32_T(j_cpu_c, b_i, &m_emlrtRTEI);
            if (!h_c_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(j_cpu_c, &e_gpu_c);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_z_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, c_cpu_z);
              }

              b_z_dirtyOnCpu = false;
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              if (h_c_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_c, j_cpu_c);
              }

              ec_detrend_kernel172<<<grid, block>>>(gpu_fv3, gpu_z, gpu_fv2,
                gpu_npages, e_gpu_c);
              h_c_dirtyOnGpu = true;
              h_c_dirtyOnCpu = false;
            }
          } else {
            if (h_c_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(j_cpu_c, &e_gpu_c);
            }

            if (fv2_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
            }

            fv2_dirtyOnGpu = false;
            if (vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_vec, &gpu_vec);
            }

            vec_dirtyOnGpu = false;
            if (c_z_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_z, &gpu_z);
            }

            c_z_dirtyOnGpu = false;
            if (fv3_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv3, &gpu_fv3);
            }

            fv3_dirtyOnGpu = false;
            if (b_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_vec, &b_gpu_vec);
            }

            b_vec_dirtyOnGpu = false;
            b_binary_expand_op(j_cpu_c, cpu_fv2, cpu_vec, c_cpu_z, cpu_fv3,
                               b_cpu_vec);
            h_c_dirtyOnCpu = true;
            h_c_dirtyOnGpu = false;
          }

          if (cpu_vec->size[1] == 1) {
            nx = c_cpu_z->size[0];
          } else {
            nx = cpu_vec->size[1];
          }

          if ((c_cpu_z->size[0] == cpu_vec->size[1]) && (nx == b_cpu_vec->size[1]))
          {
            cpu_npages = cpu_vec->size[1];
            b_i = b_cpu_d->size[0] * b_cpu_d->size[1];
            b_cpu_d->size[0] = cpu_vec->size[1];
            b_cpu_d->size[1] = 1;
            emxEnsureCapacity_real32_T(b_cpu_d, b_i, &fd_emlrtRTEI);
            if (!b_d_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(b_cpu_d, &gpu_d);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_z_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, c_cpu_z);
              }

              b_z_dirtyOnCpu = false;
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              if (b_d_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_d, b_cpu_d);
              }

              ec_detrend_kernel173<<<grid, block>>>(gpu_fv3, gpu_z, gpu_fv2,
                gpu_npages, gpu_d);
              b_d_dirtyOnGpu = true;
              b_d_dirtyOnCpu = false;
            }
          } else {
            if (b_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_d, &gpu_d);
            }

            if (fv2_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
            }

            fv2_dirtyOnGpu = false;
            if (vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_vec, &gpu_vec);
            }

            vec_dirtyOnGpu = false;
            if (c_z_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_z, &gpu_z);
            }

            c_z_dirtyOnGpu = false;
            if (fv3_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv3, &gpu_fv3);
            }

            fv3_dirtyOnGpu = false;
            if (b_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_vec, &b_gpu_vec);
            }

            b_vec_dirtyOnGpu = false;
            binary_expand_op(b_cpu_d, cpu_fv2, cpu_vec, c_cpu_z, cpu_fv3,
                             b_cpu_vec);
            b_d_dirtyOnCpu = true;
            b_d_dirtyOnGpu = false;
          }

          // 'ec_detrend:89' thrItr = thr*std(d);
          m = j_cpu_c->size[0];
          if ((m != 0) && (m != 1)) {
            if (b_cpu_d->size[0] == 0) {
              d2scaled = 0.0F;
            } else {
              if (b_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_d, &gpu_d);
              }

              b_d_dirtyOnGpu = false;
              d2scaled = b_cpu_d->data[0];
              for (na = 0; na <= m - 2; na++) {
                d2scaled += b_cpu_d->data[na + 1];
              }
            }

            d2scaled /= static_cast<real32_T>(m);
            b_i = b_cpu_absdiff->size[0];
            b_cpu_absdiff->size[0] = b_cpu_d->size[0];
            emxEnsureCapacity_real32_T(b_cpu_absdiff, b_i, &id_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(b_cpu_absdiff, &gpu_absdiff);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m),
              &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (h_c_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_c, j_cpu_c);
              }

              h_c_dirtyOnCpu = false;
              ec_detrend_kernel174<<<grid, block>>>(d2scaled, e_gpu_c, m,
                gpu_absdiff);
            }

            cublasSnrm2(getCublasGlobalHandle(), m, (float *)&gpu_absdiff.data[0],
                        1, (float *)&d2scaled);
          }

          // 'ec_detrend:90' w(abs(d)>thrItr) = 0;
          //  update weights
          // 'ec_detrend:92' x = x-z;
          if (c_cpu_z->size[0] == cpu_vec->size[1]) {
            cpu_npages = cpu_vec->size[1];
            b_i = cpu_yy->size[0] * cpu_yy->size[1];
            cpu_yy->size[0] = cpu_vec->size[1];
            cpu_yy->size[1] = 1;
            emxEnsureCapacity_real32_T(cpu_yy, b_i, &kd_emlrtRTEI);
            if (!yy_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(cpu_yy, &gpu_yy);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_z_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, c_cpu_z);
              }

              b_z_dirtyOnCpu = false;
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_yy, cpu_yy);
              }

              ec_detrend_kernel175<<<grid, block>>>(gpu_z, gpu_fv2, gpu_npages,
                gpu_yy);
              yy_dirtyOnGpu = true;
              yy_dirtyOnCpu = false;
            }
          } else {
            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_yy, &gpu_yy);
            }

            if (fv2_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
            }

            fv2_dirtyOnGpu = false;
            if (vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_vec, &gpu_vec);
            }

            vec_dirtyOnGpu = false;
            if (c_z_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_z, &gpu_z);
            }

            c_z_dirtyOnGpu = false;
            binary_expand_op(cpu_yy, cpu_fv2, cpu_vec, c_cpu_z);
            yy_dirtyOnCpu = true;
            yy_dirtyOnGpu = false;
          }

          //  triangular weighting
          // 'ec_detrend:125' if start==1
          if (start == 1.0F) {
            // 'ec_detrend:126' b = [ones(1,wsize2/2,'like',yy)*wsize2/2, wsize2/2:-1:1]';
            rconde = (out + 1.0F) / 2.0F;
            abnrm = (out + 1.0F) / 2.0F;
            if (std::isnan(abnrm)) {
              b_i = e_cpu_vec->size[0] * e_cpu_vec->size[1];
              e_cpu_vec->size[0] = 1;
              e_cpu_vec->size[1] = 1;
              emxEnsureCapacity_real32_T(e_cpu_vec, b_i, &m_emlrtRTEI);
              if (!e_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(e_cpu_vec, &i_gpu_vec);
              }

              if (e_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_vec, &i_gpu_vec);
              }

              e_cpu_vec->data[0] = rtNaNF;
              e_vec_dirtyOnCpu = true;
              e_vec_dirtyOnGpu = false;
            } else if (abnrm < 1.0F) {
              e_cpu_vec->size[0] = 1;
              e_cpu_vec->size[1] = 0;
            } else if (std::floor(abnrm) == abnrm) {
              if (abnrm >= 1.07374182E+9F) {
                b_i = e_cpu_vec->size[0] * e_cpu_vec->size[1];
                e_cpu_vec->size[0] = 1;
                e_cpu_vec->size[1] = static_cast<int32_T>(-(1.0 - abnrm)) + 1;
                emxEnsureCapacity_real32_T(e_cpu_vec, b_i, &m_emlrtRTEI);
                if (!e_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(e_cpu_vec, &i_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                  static_cast<int64_T>(-(1.0 - abnrm)) + 1L), &grid, &block,
                  1024U, 65535U);
                if (validLaunchParams) {
                  if (e_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&i_gpu_vec, e_cpu_vec);
                  }

                  ec_detrend_kernel195<<<grid, block>>>(abnrm, i_gpu_vec);
                  e_vec_dirtyOnGpu = true;
                  e_vec_dirtyOnCpu = false;
                }
              } else {
                vlen = static_cast<int32_T>(abnrm);
                b_i = e_cpu_vec->size[0] * e_cpu_vec->size[1];
                e_cpu_vec->size[0] = 1;
                e_cpu_vec->size[1] = static_cast<int32_T>(abnrm);
                emxEnsureCapacity_real32_T(e_cpu_vec, b_i, &o_emlrtRTEI);
                if (!e_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(e_cpu_vec, &i_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (vlen), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (e_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&i_gpu_vec, e_cpu_vec);
                  }

                  ec_detrend_kernel194<<<grid, block>>>(vlen, i_gpu_vec);
                  e_vec_dirtyOnGpu = true;
                  e_vec_dirtyOnCpu = false;
                }
              }
            } else {
              ndbl = std::floor(-(1.0 - abnrm) + 0.5);
              apnd = abnrm - ndbl;
              if (std::abs(1.0 - apnd) < 2.384185791015625E-7 * abnrm) {
                ndbl++;
                d2scaled = 1.0F;
              } else if (1.0 - apnd > 0.0) {
                d2scaled = static_cast<real32_T>(abnrm - (ndbl - 1.0));
              } else {
                ndbl++;
                d2scaled = static_cast<real32_T>(apnd);
              }

              b_i = e_cpu_vec->size[0] * e_cpu_vec->size[1];
              e_cpu_vec->size[0] = 1;
              e_cpu_vec->size[1] = static_cast<int32_T>(ndbl);
              emxEnsureCapacity_real32_T(e_cpu_vec, b_i, &p_emlrtRTEI);
              if (!e_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(e_cpu_vec, &i_gpu_vec);
              }

              if (static_cast<int32_T>(ndbl) > 0) {
                if (e_vec_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_vec, &i_gpu_vec);
                }

                e_cpu_vec->data[0] = abnrm;
                e_vec_dirtyOnCpu = true;
                e_vec_dirtyOnGpu = false;
                if (static_cast<int32_T>(ndbl) > 1) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&i_gpu_vec, e_cpu_vec);
                  ec_detrend_kernel189<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, ndbl, i_gpu_vec);
                  e_vec_dirtyOnCpu = false;
                  cpu_npages = (static_cast<int32_T>(ndbl) - 1) / 2;
                  p = true;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                    p = false;
                    ec_detrend_kernel190<<<grid, block>>>(d2scaled, static_cast<
                      int32_T>(ndbl), abnrm, gpu_npages, i_gpu_vec);
                  }

                  if (cpu_npages << 1 == static_cast<int32_T>(ndbl) - 1) {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel193<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, abnrm, gpu_npages, i_gpu_vec);
                    e_vec_dirtyOnGpu = true;
                  } else {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel191<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (abnrm, gpu_npages, i_gpu_vec);
                    ec_detrend_kernel192<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, gpu_npages, i_gpu_vec);
                    e_vec_dirtyOnGpu = true;
                  }
                }
              }
            }

            b_i = e_cpu_b->size[0];
            e_cpu_b->size[0] = static_cast<int32_T>(rconde) + e_cpu_vec->size[1];
            emxEnsureCapacity_real32_T(e_cpu_b, b_i, &ld_emlrtRTEI);
            if (!c_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(e_cpu_b, &c_gpu_b);
            }

            cpu_npages = static_cast<int32_T>(rconde);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_b, e_cpu_b);
              }

              ec_detrend_kernel196<<<grid, block>>>(out, gpu_npages, c_gpu_b);
              b_dirtyOnGpu = true;
              c_b_dirtyOnCpu = false;
            }

            cpu_npages = e_cpu_vec->size[1];
            for (b_i = 0; b_i < cpu_npages; b_i++) {
              if (b_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_b, &c_gpu_b);
              }

              if (e_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_vec, &i_gpu_vec);
              }

              e_vec_dirtyOnGpu = false;
              e_cpu_b->data[b_i + static_cast<int32_T>(rconde)] =
                e_cpu_vec->data[b_i];
              c_b_dirtyOnCpu = true;
              b_dirtyOnGpu = false;
            }
          } else if (stop == dims_idx_0) {
            // 'ec_detrend:127' elseif stop==dims(1)
            // 'ec_detrend:128' b = [1:wsize2/2, ones(1,wsize2/2,'like',yy)*wsize2/2]';
            d2scaled = (out + 1.0F) / 2.0F;
            if (std::isnan(d2scaled)) {
              b_i = d_cpu_vec->size[0] * d_cpu_vec->size[1];
              d_cpu_vec->size[0] = 1;
              d_cpu_vec->size[1] = 1;
              emxEnsureCapacity_real32_T(d_cpu_vec, b_i, &m_emlrtRTEI);
              if (!d_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(d_cpu_vec, &j_gpu_vec);
              }

              if (d_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_vec, &j_gpu_vec);
              }

              d_cpu_vec->data[0] = rtNaNF;
              d_vec_dirtyOnCpu = true;
              d_vec_dirtyOnGpu = false;
            } else if (d2scaled < 1.0F) {
              d_cpu_vec->size[0] = 1;
              d_cpu_vec->size[1] = 0;
            } else if (d2scaled >= 1.07374182E+9F) {
              b_i = d_cpu_vec->size[0] * d_cpu_vec->size[1];
              d_cpu_vec->size[0] = 1;
              d_cpu_vec->size[1] = static_cast<int32_T>(d2scaled - 1.0) + 1;
              emxEnsureCapacity_real32_T(d_cpu_vec, b_i, &m_emlrtRTEI);
              if (!d_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(d_cpu_vec, &j_gpu_vec);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int64_T>(d2scaled - 1.0) + 1L), &grid, &block, 1024U,
                65535U);
              if (validLaunchParams) {
                if (d_vec_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&j_gpu_vec, d_cpu_vec);
                }

                ec_detrend_kernel187<<<grid, block>>>(d2scaled, j_gpu_vec);
                d_vec_dirtyOnGpu = true;
                d_vec_dirtyOnCpu = false;
              }
            } else {
              m = static_cast<int32_T>(std::trunc(d2scaled));
              b_i = d_cpu_vec->size[0] * d_cpu_vec->size[1];
              d_cpu_vec->size[0] = 1;
              d_cpu_vec->size[1] = static_cast<int32_T>(std::trunc(d2scaled));
              emxEnsureCapacity_real32_T(d_cpu_vec, b_i, &o_emlrtRTEI);
              if (!d_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(d_cpu_vec, &j_gpu_vec);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m),
                &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (d_vec_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&j_gpu_vec, d_cpu_vec);
                }

                ec_detrend_kernel186<<<grid, block>>>(m, j_gpu_vec);
                d_vec_dirtyOnGpu = true;
                d_vec_dirtyOnCpu = false;
              }
            }

            V[1] = static_cast<int32_T>((out + 1.0F) / 2.0F);
            b_i = e_cpu_b->size[0];
            e_cpu_b->size[0] = d_cpu_vec->size[1] + static_cast<int32_T>((out +
              1.0F) / 2.0F);
            emxEnsureCapacity_real32_T(e_cpu_b, b_i, &md_emlrtRTEI);
            if (!c_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(e_cpu_b, &c_gpu_b);
            }

            cpu_npages = d_cpu_vec->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (d_vec_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&j_gpu_vec, d_cpu_vec);
              }

              d_vec_dirtyOnCpu = false;
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_b, e_cpu_b);
              }

              ec_detrend_kernel188<<<grid, block>>>(j_gpu_vec, gpu_npages,
                c_gpu_b);
              b_dirtyOnGpu = true;
              c_b_dirtyOnCpu = false;
            }

            cpu_npages = V[1];
            for (b_i = 0; b_i < cpu_npages; b_i++) {
              if (b_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_b, &c_gpu_b);
              }

              e_cpu_b->data[b_i + d_cpu_vec->size[1]] = (out + 1.0F) / 2.0F;
              c_b_dirtyOnCpu = true;
              b_dirtyOnGpu = false;
            }
          } else {
            // 'ec_detrend:129' else
            // 'ec_detrend:130' b = [1:wsize2/2, wsize2/2:-1:1]';
            d2scaled = (out + 1.0F) / 2.0F;
            if (std::isnan(d2scaled)) {
              b_i = c_cpu_vec->size[0] * c_cpu_vec->size[1];
              c_cpu_vec->size[0] = 1;
              c_cpu_vec->size[1] = 1;
              emxEnsureCapacity_real32_T(c_cpu_vec, b_i, &m_emlrtRTEI);
              if (!c_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(c_cpu_vec, &k_gpu_vec);
              }

              if (c_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_vec, &k_gpu_vec);
              }

              c_cpu_vec->data[0] = rtNaNF;
              c_vec_dirtyOnCpu = true;
              c_vec_dirtyOnGpu = false;
            } else if (d2scaled < 1.0F) {
              c_cpu_vec->size[0] = 1;
              c_cpu_vec->size[1] = 0;
            } else if (d2scaled >= 1.07374182E+9F) {
              b_i = c_cpu_vec->size[0] * c_cpu_vec->size[1];
              c_cpu_vec->size[0] = 1;
              c_cpu_vec->size[1] = static_cast<int32_T>(d2scaled - 1.0) + 1;
              emxEnsureCapacity_real32_T(c_cpu_vec, b_i, &m_emlrtRTEI);
              if (!c_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(c_cpu_vec, &k_gpu_vec);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int64_T>(d2scaled - 1.0) + 1L), &grid, &block, 1024U,
                65535U);
              if (validLaunchParams) {
                if (c_vec_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&k_gpu_vec, c_cpu_vec);
                }

                ec_detrend_kernel177<<<grid, block>>>(d2scaled, k_gpu_vec);
                c_vec_dirtyOnGpu = true;
                c_vec_dirtyOnCpu = false;
              }
            } else {
              m = static_cast<int32_T>(std::trunc(d2scaled));
              b_i = c_cpu_vec->size[0] * c_cpu_vec->size[1];
              c_cpu_vec->size[0] = 1;
              c_cpu_vec->size[1] = static_cast<int32_T>(std::trunc(d2scaled));
              emxEnsureCapacity_real32_T(c_cpu_vec, b_i, &o_emlrtRTEI);
              if (!c_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(c_cpu_vec, &k_gpu_vec);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m),
                &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (c_vec_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&k_gpu_vec, c_cpu_vec);
                }

                ec_detrend_kernel176<<<grid, block>>>(m, k_gpu_vec);
                c_vec_dirtyOnGpu = true;
                c_vec_dirtyOnCpu = false;
              }
            }

            abnrm = (out + 1.0F) / 2.0F;
            if (std::isnan(abnrm)) {
              b_i = f_cpu_vec->size[0] * f_cpu_vec->size[1];
              f_cpu_vec->size[0] = 1;
              f_cpu_vec->size[1] = 1;
              emxEnsureCapacity_real32_T(f_cpu_vec, b_i, &m_emlrtRTEI);
              if (!f_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(f_cpu_vec, &l_gpu_vec);
              }

              if (f_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(f_cpu_vec, &l_gpu_vec);
              }

              f_cpu_vec->data[0] = rtNaNF;
              f_vec_dirtyOnCpu = true;
              f_vec_dirtyOnGpu = false;
            } else if (abnrm < 1.0F) {
              f_cpu_vec->size[0] = 1;
              f_cpu_vec->size[1] = 0;
            } else if (std::floor(abnrm) == abnrm) {
              if (abnrm >= 1.07374182E+9F) {
                b_i = f_cpu_vec->size[0] * f_cpu_vec->size[1];
                f_cpu_vec->size[0] = 1;
                f_cpu_vec->size[1] = static_cast<int32_T>(-(1.0 - abnrm)) + 1;
                emxEnsureCapacity_real32_T(f_cpu_vec, b_i, &m_emlrtRTEI);
                if (!f_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(f_cpu_vec, &l_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                  static_cast<int64_T>(-(1.0 - abnrm)) + 1L), &grid, &block,
                  1024U, 65535U);
                if (validLaunchParams) {
                  if (f_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&l_gpu_vec, f_cpu_vec);
                  }

                  ec_detrend_kernel184<<<grid, block>>>(abnrm, l_gpu_vec);
                  f_vec_dirtyOnGpu = true;
                  f_vec_dirtyOnCpu = false;
                }
              } else {
                vlen = static_cast<int32_T>(abnrm);
                b_i = f_cpu_vec->size[0] * f_cpu_vec->size[1];
                f_cpu_vec->size[0] = 1;
                f_cpu_vec->size[1] = static_cast<int32_T>(abnrm);
                emxEnsureCapacity_real32_T(f_cpu_vec, b_i, &o_emlrtRTEI);
                if (!f_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(f_cpu_vec, &l_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (vlen), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (f_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&l_gpu_vec, f_cpu_vec);
                  }

                  ec_detrend_kernel183<<<grid, block>>>(vlen, l_gpu_vec);
                  f_vec_dirtyOnGpu = true;
                  f_vec_dirtyOnCpu = false;
                }
              }
            } else {
              ndbl = std::floor(-(1.0 - abnrm) + 0.5);
              apnd = abnrm - ndbl;
              if (std::abs(1.0 - apnd) < 2.384185791015625E-7 * abnrm) {
                ndbl++;
                d2scaled = 1.0F;
              } else if (1.0 - apnd > 0.0) {
                d2scaled = static_cast<real32_T>(abnrm - (ndbl - 1.0));
              } else {
                ndbl++;
                d2scaled = static_cast<real32_T>(apnd);
              }

              b_i = f_cpu_vec->size[0] * f_cpu_vec->size[1];
              f_cpu_vec->size[0] = 1;
              f_cpu_vec->size[1] = static_cast<int32_T>(ndbl);
              emxEnsureCapacity_real32_T(f_cpu_vec, b_i, &p_emlrtRTEI);
              if (!f_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(f_cpu_vec, &l_gpu_vec);
              }

              if (static_cast<int32_T>(ndbl) > 0) {
                if (f_vec_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(f_cpu_vec, &l_gpu_vec);
                }

                f_cpu_vec->data[0] = abnrm;
                f_vec_dirtyOnCpu = true;
                f_vec_dirtyOnGpu = false;
                if (static_cast<int32_T>(ndbl) > 1) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&l_gpu_vec, f_cpu_vec);
                  ec_detrend_kernel178<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, ndbl, l_gpu_vec);
                  f_vec_dirtyOnCpu = false;
                  cpu_npages = (static_cast<int32_T>(ndbl) - 1) / 2;
                  p = true;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                    p = false;
                    ec_detrend_kernel179<<<grid, block>>>(d2scaled, static_cast<
                      int32_T>(ndbl), abnrm, gpu_npages, l_gpu_vec);
                  }

                  if (cpu_npages << 1 == static_cast<int32_T>(ndbl) - 1) {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel182<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, abnrm, gpu_npages, l_gpu_vec);
                    f_vec_dirtyOnGpu = true;
                  } else {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel180<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (abnrm, gpu_npages, l_gpu_vec);
                    ec_detrend_kernel181<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, gpu_npages, l_gpu_vec);
                    f_vec_dirtyOnGpu = true;
                  }
                }
              }
            }

            b_i = e_cpu_b->size[0];
            e_cpu_b->size[0] = c_cpu_vec->size[1] + f_cpu_vec->size[1];
            emxEnsureCapacity_real32_T(e_cpu_b, b_i, &nd_emlrtRTEI);
            if (!c_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(e_cpu_b, &c_gpu_b);
            }

            cpu_npages = c_cpu_vec->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_vec_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&k_gpu_vec, c_cpu_vec);
              }

              c_vec_dirtyOnCpu = false;
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_b, e_cpu_b);
              }

              ec_detrend_kernel185<<<grid, block>>>(k_gpu_vec, gpu_npages,
                c_gpu_b);
              b_dirtyOnGpu = true;
              c_b_dirtyOnCpu = false;
            }

            cpu_npages = f_cpu_vec->size[1];
            for (b_i = 0; b_i < cpu_npages; b_i++) {
              if (b_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_b, &c_gpu_b);
              }

              if (f_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(f_cpu_vec, &l_gpu_vec);
              }

              f_vec_dirtyOnGpu = false;
              e_cpu_b->data[b_i + c_cpu_vec->size[1]] = f_cpu_vec->data[b_i];
              c_b_dirtyOnCpu = true;
              b_dirtyOnGpu = false;
            }
          }

          //  overlap-add to output
          // 'ec_detrend:134' y(start:stop,:) = y(start:stop,:) + (yy.*b);
          if (std::isnan(start)) {
            b_i = g_cpu_vec->size[0] * g_cpu_vec->size[1];
            g_cpu_vec->size[0] = 1;
            g_cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(g_cpu_vec, b_i, &m_emlrtRTEI);
            if (!g_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(g_cpu_vec, &c_gpu_vec);
            }

            if (g_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(g_cpu_vec, &c_gpu_vec);
            }

            g_cpu_vec->data[0] = rtNaNF;
            g_vec_dirtyOnCpu = true;
            g_vec_dirtyOnGpu = false;
          } else if (stop < start) {
            g_cpu_vec->size[0] = 1;
            g_cpu_vec->size[1] = 0;
          } else if ((std::isinf(start) || std::isinf(stop)) && (start == stop))
          {
            b_i = g_cpu_vec->size[0] * g_cpu_vec->size[1];
            g_cpu_vec->size[0] = 1;
            g_cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(g_cpu_vec, b_i, &m_emlrtRTEI);
            if (!g_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(g_cpu_vec, &c_gpu_vec);
            }

            if (g_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(g_cpu_vec, &c_gpu_vec);
            }

            g_cpu_vec->data[0] = rtNaNF;
            g_vec_dirtyOnCpu = true;
            g_vec_dirtyOnGpu = false;
          } else if (std::floor(start) == start) {
            if ((std::abs(start) >= 1.07374182E+9F) || (std::abs(stop) >=
                 1.07374182E+9F)) {
              b_i = g_cpu_vec->size[0] * g_cpu_vec->size[1];
              g_cpu_vec->size[0] = 1;
              g_cpu_vec->size[1] = static_cast<int32_T>(static_cast<real_T>(stop)
                - start) + 1;
              emxEnsureCapacity_real32_T(g_cpu_vec, b_i, &m_emlrtRTEI);
              if (!g_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(g_cpu_vec, &c_gpu_vec);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int64_T>(static_cast<real_T>(stop) - start) + 1L),
                &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (g_vec_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_vec, g_cpu_vec);
                }

                ec_detrend_kernel203<<<grid, block>>>(start, stop, c_gpu_vec);
                g_vec_dirtyOnGpu = true;
                g_vec_dirtyOnCpu = false;
              }
            } else {
              m = static_cast<int32_T>(std::trunc(stop)) - static_cast<int32_T>
                (start);
              b_i = g_cpu_vec->size[0] * g_cpu_vec->size[1];
              g_cpu_vec->size[0] = 1;
              g_cpu_vec->size[1] = (static_cast<int32_T>(std::trunc(stop)) -
                                    static_cast<int32_T>(start)) + 1;
              emxEnsureCapacity_real32_T(g_cpu_vec, b_i, &o_emlrtRTEI);
              if (!g_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(g_cpu_vec, &c_gpu_vec);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (g_vec_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_vec, g_cpu_vec);
                }

                ec_detrend_kernel202<<<grid, block>>>(static_cast<int32_T>(start),
                  m, c_gpu_vec);
                g_vec_dirtyOnGpu = true;
                g_vec_dirtyOnCpu = false;
              }
            }
          } else {
            ndbl = std::floor((static_cast<real_T>(stop) - start) + 0.5);
            apnd = start + ndbl;
            cdiff = apnd - stop;
            if (std::abs(cdiff) < 2.384185791015625E-7 * std::fmax(std::abs(
                  static_cast<real_T>(start)), std::abs(static_cast<real_T>(stop))))
            {
              ndbl++;
              d2scaled = stop;
            } else if (cdiff > 0.0) {
              d2scaled = static_cast<real32_T>(start + (ndbl - 1.0));
            } else {
              ndbl++;
              d2scaled = static_cast<real32_T>(apnd);
            }

            if (ndbl >= 0.0) {
              m = static_cast<int32_T>(ndbl);
            } else {
              m = 0;
            }

            b_i = g_cpu_vec->size[0] * g_cpu_vec->size[1];
            g_cpu_vec->size[0] = 1;
            g_cpu_vec->size[1] = m;
            emxEnsureCapacity_real32_T(g_cpu_vec, b_i, &p_emlrtRTEI);
            if (!g_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(g_cpu_vec, &c_gpu_vec);
            }

            if (m > 0) {
              if (g_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(g_cpu_vec, &c_gpu_vec);
              }

              g_cpu_vec->data[0] = start;
              g_vec_dirtyOnCpu = true;
              g_vec_dirtyOnGpu = false;
              if (m > 1) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_vec, g_cpu_vec);
                ec_detrend_kernel197<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                  (d2scaled, m, c_gpu_vec);
                g_vec_dirtyOnCpu = false;
                cpu_npages = (m - 1) / 2;
                p = true;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                             cudaMemcpyHostToDevice);
                  p = false;
                  ec_detrend_kernel198<<<grid, block>>>(d2scaled, m, start,
                    gpu_npages, c_gpu_vec);
                }

                if (cpu_npages << 1 == m - 1) {
                  if (p) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                  }

                  ec_detrend_kernel201<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, start, gpu_npages, c_gpu_vec);
                  g_vec_dirtyOnGpu = true;
                } else {
                  if (p) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                  }

                  ec_detrend_kernel199<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (start, gpu_npages, c_gpu_vec);
                  ec_detrend_kernel200<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, gpu_npages, c_gpu_vec);
                  g_vec_dirtyOnGpu = true;
                }
              }
            }
          }

          b_i = cpu_iv6->size[0];
          cpu_iv6->size[0] = g_cpu_vec->size[1];
          emxEnsureCapacity_int32_T(cpu_iv6, b_i, &od_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_iv6, &gpu_iv6);
          na = g_cpu_vec->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (g_vec_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_vec, g_cpu_vec);
            }

            g_vec_dirtyOnCpu = false;
            ec_detrend_kernel204<<<grid, block>>>(c_gpu_vec, na, gpu_iv6);
            iv6_dirtyOnGpu = true;
          }

          if (std::isnan(start)) {
            b_i = h_cpu_vec->size[0] * h_cpu_vec->size[1];
            h_cpu_vec->size[0] = 1;
            h_cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(h_cpu_vec, b_i, &m_emlrtRTEI);
            if (!h_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(h_cpu_vec, &d_gpu_vec);
            }

            if (h_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(h_cpu_vec, &d_gpu_vec);
            }

            h_cpu_vec->data[0] = rtNaNF;
            h_vec_dirtyOnCpu = true;
            h_vec_dirtyOnGpu = false;
          } else if (stop < start) {
            h_cpu_vec->size[0] = 1;
            h_cpu_vec->size[1] = 0;
          } else if ((std::isinf(start) || std::isinf(stop)) && (start == stop))
          {
            b_i = h_cpu_vec->size[0] * h_cpu_vec->size[1];
            h_cpu_vec->size[0] = 1;
            h_cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(h_cpu_vec, b_i, &m_emlrtRTEI);
            if (!h_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(h_cpu_vec, &d_gpu_vec);
            }

            if (h_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(h_cpu_vec, &d_gpu_vec);
            }

            h_cpu_vec->data[0] = rtNaNF;
            h_vec_dirtyOnCpu = true;
            h_vec_dirtyOnGpu = false;
          } else if (std::floor(start) == start) {
            if ((std::abs(start) >= 1.07374182E+9F) || (std::abs(stop) >=
                 1.07374182E+9F)) {
              b_i = h_cpu_vec->size[0] * h_cpu_vec->size[1];
              h_cpu_vec->size[0] = 1;
              h_cpu_vec->size[1] = static_cast<int32_T>(static_cast<real_T>(stop)
                - start) + 1;
              emxEnsureCapacity_real32_T(h_cpu_vec, b_i, &m_emlrtRTEI);
              if (!h_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(h_cpu_vec, &d_gpu_vec);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int64_T>(static_cast<real_T>(stop) - start) + 1L),
                &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (h_vec_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_vec, h_cpu_vec);
                }

                ec_detrend_kernel211<<<grid, block>>>(start, stop, d_gpu_vec);
                h_vec_dirtyOnGpu = true;
                h_vec_dirtyOnCpu = false;
              }
            } else {
              m = static_cast<int32_T>(std::trunc(stop)) - static_cast<int32_T>
                (start);
              b_i = h_cpu_vec->size[0] * h_cpu_vec->size[1];
              h_cpu_vec->size[0] = 1;
              h_cpu_vec->size[1] = (static_cast<int32_T>(std::trunc(stop)) -
                                    static_cast<int32_T>(start)) + 1;
              emxEnsureCapacity_real32_T(h_cpu_vec, b_i, &o_emlrtRTEI);
              if (!h_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(h_cpu_vec, &d_gpu_vec);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (h_vec_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_vec, h_cpu_vec);
                }

                ec_detrend_kernel210<<<grid, block>>>(static_cast<int32_T>(start),
                  m, d_gpu_vec);
                h_vec_dirtyOnGpu = true;
                h_vec_dirtyOnCpu = false;
              }
            }
          } else {
            ndbl = std::floor((static_cast<real_T>(stop) - start) + 0.5);
            apnd = start + ndbl;
            cdiff = apnd - stop;
            if (std::abs(cdiff) < 2.384185791015625E-7 * std::fmax(std::abs(
                  static_cast<real_T>(start)), std::abs(static_cast<real_T>(stop))))
            {
              ndbl++;
              d2scaled = stop;
            } else if (cdiff > 0.0) {
              d2scaled = static_cast<real32_T>(start + (ndbl - 1.0));
            } else {
              ndbl++;
              d2scaled = static_cast<real32_T>(apnd);
            }

            if (ndbl >= 0.0) {
              m = static_cast<int32_T>(ndbl);
            } else {
              m = 0;
            }

            b_i = h_cpu_vec->size[0] * h_cpu_vec->size[1];
            h_cpu_vec->size[0] = 1;
            h_cpu_vec->size[1] = m;
            emxEnsureCapacity_real32_T(h_cpu_vec, b_i, &p_emlrtRTEI);
            if (!h_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(h_cpu_vec, &d_gpu_vec);
            }

            if (m > 0) {
              if (h_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(h_cpu_vec, &d_gpu_vec);
              }

              h_cpu_vec->data[0] = start;
              h_vec_dirtyOnCpu = true;
              h_vec_dirtyOnGpu = false;
              if (m > 1) {
                gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_vec, h_cpu_vec);
                ec_detrend_kernel205<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                  (d2scaled, m, d_gpu_vec);
                h_vec_dirtyOnCpu = false;
                cpu_npages = (m - 1) / 2;
                p = true;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                             cudaMemcpyHostToDevice);
                  p = false;
                  ec_detrend_kernel206<<<grid, block>>>(d2scaled, m, start,
                    gpu_npages, d_gpu_vec);
                }

                if (cpu_npages << 1 == m - 1) {
                  if (p) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                  }

                  ec_detrend_kernel209<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, start, gpu_npages, d_gpu_vec);
                  h_vec_dirtyOnGpu = true;
                } else {
                  if (p) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                  }

                  ec_detrend_kernel207<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (start, gpu_npages, d_gpu_vec);
                  ec_detrend_kernel208<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, gpu_npages, d_gpu_vec);
                  h_vec_dirtyOnGpu = true;
                }
              }
            }
          }

          b_i = h_cpu_a->size[0] * h_cpu_a->size[1];
          h_cpu_a->size[0] = h_cpu_vec->size[1];
          h_cpu_a->size[1] = 1;
          emxEnsureCapacity_real32_T(h_cpu_a, b_i, &pd_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(h_cpu_a, &e_gpu_a);
          na = h_cpu_vec->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_x, d_cpu_x);
            }

            b_x_dirtyOnCpu = false;
            if (h_vec_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_vec, h_cpu_vec);
            }

            h_vec_dirtyOnCpu = false;
            ec_detrend_kernel212<<<grid, block>>>(d_gpu_x, d_gpu_vec, na,
              e_gpu_a);
            b_a_dirtyOnGpu = true;
          }

          if (cpu_yy->size[0] == 1) {
            nx = e_cpu_b->size[0];
          } else {
            nx = cpu_yy->size[0];
          }

          if ((cpu_yy->size[0] == e_cpu_b->size[0]) && (h_cpu_a->size[0] == nx))
          {
            na = h_cpu_a->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_b, e_cpu_b);
              }

              c_b_dirtyOnCpu = false;
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_yy, cpu_yy);
              }

              yy_dirtyOnCpu = false;
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_x, d_cpu_x);
              }

              ec_detrend_kernel213<<<grid, block>>>(c_gpu_b, gpu_yy, e_gpu_a,
                gpu_iv6, na, d_gpu_x);
              d_x_dirtyOnGpu = true;
              b_x_dirtyOnCpu = false;
            }
          } else {
            if (d_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_x, &d_gpu_x);
            }

            if (iv6_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_iv6, &gpu_iv6);
            }

            iv6_dirtyOnGpu = false;
            if (b_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(h_cpu_a, &e_gpu_a);
            }

            b_a_dirtyOnGpu = false;
            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_yy, &gpu_yy);
            }

            yy_dirtyOnGpu = false;
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_b, &c_gpu_b);
            }

            b_dirtyOnGpu = false;
            binary_expand_op(d_cpu_x, cpu_iv6, h_cpu_a, cpu_yy, e_cpu_b);
            b_x_dirtyOnCpu = true;
            d_x_dirtyOnGpu = false;
          }

          // bsxfun(@times,yy,b);
          // 'ec_detrend:135' trend(start:stop,:) = trend(start:stop,:) + (x(start:stop,:)-yy).*b;
          if (std::isnan(start)) {
            b_i = i_cpu_vec->size[0] * i_cpu_vec->size[1];
            i_cpu_vec->size[0] = 1;
            i_cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(i_cpu_vec, b_i, &m_emlrtRTEI);
            if (!i_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(i_cpu_vec, &e_gpu_vec);
            }

            if (i_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(i_cpu_vec, &e_gpu_vec);
            }

            i_cpu_vec->data[0] = rtNaNF;
            i_vec_dirtyOnCpu = true;
            i_vec_dirtyOnGpu = false;
          } else if (stop < start) {
            i_cpu_vec->size[0] = 1;
            i_cpu_vec->size[1] = 0;
          } else if ((std::isinf(start) || std::isinf(stop)) && (start == stop))
          {
            b_i = i_cpu_vec->size[0] * i_cpu_vec->size[1];
            i_cpu_vec->size[0] = 1;
            i_cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(i_cpu_vec, b_i, &m_emlrtRTEI);
            if (!i_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(i_cpu_vec, &e_gpu_vec);
            }

            if (i_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(i_cpu_vec, &e_gpu_vec);
            }

            i_cpu_vec->data[0] = rtNaNF;
            i_vec_dirtyOnCpu = true;
            i_vec_dirtyOnGpu = false;
          } else if (std::floor(start) == start) {
            if ((std::abs(start) >= 1.07374182E+9F) || (std::abs(stop) >=
                 1.07374182E+9F)) {
              b_i = i_cpu_vec->size[0] * i_cpu_vec->size[1];
              i_cpu_vec->size[0] = 1;
              i_cpu_vec->size[1] = static_cast<int32_T>(static_cast<real_T>(stop)
                - start) + 1;
              emxEnsureCapacity_real32_T(i_cpu_vec, b_i, &m_emlrtRTEI);
              if (!i_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(i_cpu_vec, &e_gpu_vec);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int64_T>(static_cast<real_T>(stop) - start) + 1L),
                &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (i_vec_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_vec, i_cpu_vec);
                }

                ec_detrend_kernel220<<<grid, block>>>(start, stop, e_gpu_vec);
                i_vec_dirtyOnGpu = true;
                i_vec_dirtyOnCpu = false;
              }
            } else {
              m = static_cast<int32_T>(std::trunc(stop)) - static_cast<int32_T>
                (start);
              b_i = i_cpu_vec->size[0] * i_cpu_vec->size[1];
              i_cpu_vec->size[0] = 1;
              i_cpu_vec->size[1] = (static_cast<int32_T>(std::trunc(stop)) -
                                    static_cast<int32_T>(start)) + 1;
              emxEnsureCapacity_real32_T(i_cpu_vec, b_i, &o_emlrtRTEI);
              if (!i_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(i_cpu_vec, &e_gpu_vec);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (i_vec_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_vec, i_cpu_vec);
                }

                ec_detrend_kernel219<<<grid, block>>>(static_cast<int32_T>(start),
                  m, e_gpu_vec);
                i_vec_dirtyOnGpu = true;
                i_vec_dirtyOnCpu = false;
              }
            }
          } else {
            ndbl = std::floor((static_cast<real_T>(stop) - start) + 0.5);
            apnd = start + ndbl;
            cdiff = apnd - stop;
            if (std::abs(cdiff) < 2.384185791015625E-7 * std::fmax(std::abs(
                  static_cast<real_T>(start)), std::abs(static_cast<real_T>(stop))))
            {
              ndbl++;
              d2scaled = stop;
            } else if (cdiff > 0.0) {
              d2scaled = static_cast<real32_T>(start + (ndbl - 1.0));
            } else {
              ndbl++;
              d2scaled = static_cast<real32_T>(apnd);
            }

            if (ndbl >= 0.0) {
              m = static_cast<int32_T>(ndbl);
            } else {
              m = 0;
            }

            b_i = i_cpu_vec->size[0] * i_cpu_vec->size[1];
            i_cpu_vec->size[0] = 1;
            i_cpu_vec->size[1] = m;
            emxEnsureCapacity_real32_T(i_cpu_vec, b_i, &p_emlrtRTEI);
            if (!i_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(i_cpu_vec, &e_gpu_vec);
            }

            if (m > 0) {
              if (i_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(i_cpu_vec, &e_gpu_vec);
              }

              i_cpu_vec->data[0] = start;
              i_vec_dirtyOnCpu = true;
              i_vec_dirtyOnGpu = false;
              if (m > 1) {
                gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_vec, i_cpu_vec);
                ec_detrend_kernel214<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                  (d2scaled, m, e_gpu_vec);
                i_vec_dirtyOnCpu = false;
                cpu_npages = (m - 1) / 2;
                p = true;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                             cudaMemcpyHostToDevice);
                  p = false;
                  ec_detrend_kernel215<<<grid, block>>>(d2scaled, m, start,
                    gpu_npages, e_gpu_vec);
                }

                if (cpu_npages << 1 == m - 1) {
                  if (p) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                  }

                  ec_detrend_kernel218<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, start, gpu_npages, e_gpu_vec);
                  i_vec_dirtyOnGpu = true;
                } else {
                  if (p) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                  }

                  ec_detrend_kernel216<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (start, gpu_npages, e_gpu_vec);
                  ec_detrend_kernel217<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, gpu_npages, e_gpu_vec);
                  i_vec_dirtyOnGpu = true;
                }
              }
            }
          }

          b_i = cpu_iv7->size[0];
          cpu_iv7->size[0] = i_cpu_vec->size[1];
          emxEnsureCapacity_int32_T(cpu_iv7, b_i, &qd_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_iv7, &gpu_iv7);
          na = i_cpu_vec->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (i_vec_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_vec, i_cpu_vec);
            }

            i_vec_dirtyOnCpu = false;
            ec_detrend_kernel221<<<grid, block>>>(e_gpu_vec, na, gpu_iv7);
            iv7_dirtyOnGpu = true;
          }

          if (std::isnan(start)) {
            b_i = j_cpu_vec->size[0] * j_cpu_vec->size[1];
            j_cpu_vec->size[0] = 1;
            j_cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(j_cpu_vec, b_i, &m_emlrtRTEI);
            if (!j_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(j_cpu_vec, &g_gpu_vec);
            }

            if (j_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(j_cpu_vec, &g_gpu_vec);
            }

            j_cpu_vec->data[0] = rtNaNF;
            j_vec_dirtyOnCpu = true;
            j_vec_dirtyOnGpu = false;
            b_i = k_cpu_vec->size[0] * k_cpu_vec->size[1];
            k_cpu_vec->size[0] = 1;
            k_cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(k_cpu_vec, b_i, &m_emlrtRTEI);
            if (!k_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(k_cpu_vec, &f_gpu_vec);
            }

            if (k_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(k_cpu_vec, &f_gpu_vec);
            }

            k_cpu_vec->data[0] = rtNaNF;
            k_vec_dirtyOnCpu = true;
            k_vec_dirtyOnGpu = false;
          } else if (stop < start) {
            j_cpu_vec->size[0] = 1;
            j_cpu_vec->size[1] = 0;
            k_cpu_vec->size[0] = 1;
            k_cpu_vec->size[1] = 0;
          } else {
            if ((std::isinf(start) || std::isinf(stop)) && (start == stop)) {
              b_i = j_cpu_vec->size[0] * j_cpu_vec->size[1];
              j_cpu_vec->size[0] = 1;
              j_cpu_vec->size[1] = 1;
              emxEnsureCapacity_real32_T(j_cpu_vec, b_i, &m_emlrtRTEI);
              if (!j_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(j_cpu_vec, &g_gpu_vec);
              }

              if (j_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(j_cpu_vec, &g_gpu_vec);
              }

              j_cpu_vec->data[0] = rtNaNF;
              j_vec_dirtyOnCpu = true;
              j_vec_dirtyOnGpu = false;
            } else if (std::floor(start) == start) {
              if ((std::abs(start) >= 1.07374182E+9F) || (std::abs(stop) >=
                   1.07374182E+9F)) {
                b_i = j_cpu_vec->size[0] * j_cpu_vec->size[1];
                j_cpu_vec->size[0] = 1;
                j_cpu_vec->size[1] = static_cast<int32_T>(static_cast<real_T>
                  (stop) - start) + 1;
                emxEnsureCapacity_real32_T(j_cpu_vec, b_i, &m_emlrtRTEI);
                if (!j_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(j_cpu_vec, &g_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                  static_cast<int64_T>(static_cast<real_T>(stop) - start) + 1L),
                  &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (j_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&g_gpu_vec, j_cpu_vec);
                  }

                  ec_detrend_kernel228<<<grid, block>>>(start, stop, g_gpu_vec);
                  j_vec_dirtyOnGpu = true;
                  j_vec_dirtyOnCpu = false;
                }
              } else {
                m = static_cast<int32_T>(std::trunc(stop)) - static_cast<int32_T>
                  (start);
                b_i = j_cpu_vec->size[0] * j_cpu_vec->size[1];
                j_cpu_vec->size[0] = 1;
                j_cpu_vec->size[1] = (static_cast<int32_T>(std::trunc(stop)) -
                                      static_cast<int32_T>(start)) + 1;
                emxEnsureCapacity_real32_T(j_cpu_vec, b_i, &o_emlrtRTEI);
                if (!j_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(j_cpu_vec, &g_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (j_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&g_gpu_vec, j_cpu_vec);
                  }

                  ec_detrend_kernel227<<<grid, block>>>(static_cast<int32_T>
                    (start), m, g_gpu_vec);
                  j_vec_dirtyOnGpu = true;
                  j_vec_dirtyOnCpu = false;
                }
              }
            } else {
              ndbl = std::floor((static_cast<real_T>(stop) - start) + 0.5);
              apnd = start + ndbl;
              cdiff = apnd - stop;
              if (std::abs(cdiff) < 2.384185791015625E-7 * std::fmax(std::abs(
                    static_cast<real_T>(start)), std::abs(static_cast<real_T>
                    (stop)))) {
                ndbl++;
                d2scaled = stop;
              } else if (cdiff > 0.0) {
                d2scaled = static_cast<real32_T>(start + (ndbl - 1.0));
              } else {
                ndbl++;
                d2scaled = static_cast<real32_T>(apnd);
              }

              if (ndbl >= 0.0) {
                m = static_cast<int32_T>(ndbl);
              } else {
                m = 0;
              }

              b_i = j_cpu_vec->size[0] * j_cpu_vec->size[1];
              j_cpu_vec->size[0] = 1;
              j_cpu_vec->size[1] = m;
              emxEnsureCapacity_real32_T(j_cpu_vec, b_i, &p_emlrtRTEI);
              if (!j_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(j_cpu_vec, &g_gpu_vec);
              }

              if (m > 0) {
                if (j_vec_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(j_cpu_vec, &g_gpu_vec);
                }

                j_cpu_vec->data[0] = start;
                j_vec_dirtyOnCpu = true;
                j_vec_dirtyOnGpu = false;
                if (m > 1) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&g_gpu_vec, j_cpu_vec);
                  ec_detrend_kernel222<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, m, g_gpu_vec);
                  j_vec_dirtyOnCpu = false;
                  cpu_npages = (m - 1) / 2;
                  p = true;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                    p = false;
                    ec_detrend_kernel223<<<grid, block>>>(d2scaled, m, start,
                      gpu_npages, g_gpu_vec);
                  }

                  if (cpu_npages << 1 == m - 1) {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel226<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, start, gpu_npages, g_gpu_vec);
                    j_vec_dirtyOnGpu = true;
                  } else {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel224<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (start, gpu_npages, g_gpu_vec);
                    ec_detrend_kernel225<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, gpu_npages, g_gpu_vec);
                    j_vec_dirtyOnGpu = true;
                  }
                }
              }
            }

            if ((std::isinf(start) || std::isinf(stop)) && (start == stop)) {
              b_i = k_cpu_vec->size[0] * k_cpu_vec->size[1];
              k_cpu_vec->size[0] = 1;
              k_cpu_vec->size[1] = 1;
              emxEnsureCapacity_real32_T(k_cpu_vec, b_i, &m_emlrtRTEI);
              if (!k_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(k_cpu_vec, &f_gpu_vec);
              }

              if (k_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(k_cpu_vec, &f_gpu_vec);
              }

              k_cpu_vec->data[0] = rtNaNF;
              k_vec_dirtyOnCpu = true;
              k_vec_dirtyOnGpu = false;
            } else if (std::floor(start) == start) {
              if ((std::abs(start) >= 1.07374182E+9F) || (std::abs(stop) >=
                   1.07374182E+9F)) {
                b_i = k_cpu_vec->size[0] * k_cpu_vec->size[1];
                k_cpu_vec->size[0] = 1;
                k_cpu_vec->size[1] = static_cast<int32_T>(static_cast<real_T>
                  (stop) - start) + 1;
                emxEnsureCapacity_real32_T(k_cpu_vec, b_i, &m_emlrtRTEI);
                if (!k_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(k_cpu_vec, &f_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                  static_cast<int64_T>(static_cast<real_T>(stop) - start) + 1L),
                  &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (k_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&f_gpu_vec, k_cpu_vec);
                  }

                  ec_detrend_kernel235<<<grid, block>>>(start, stop, f_gpu_vec);
                  k_vec_dirtyOnGpu = true;
                  k_vec_dirtyOnCpu = false;
                }
              } else {
                m = static_cast<int32_T>(std::trunc(stop)) - static_cast<int32_T>
                  (start);
                b_i = k_cpu_vec->size[0] * k_cpu_vec->size[1];
                k_cpu_vec->size[0] = 1;
                k_cpu_vec->size[1] = (static_cast<int32_T>(std::trunc(stop)) -
                                      static_cast<int32_T>(start)) + 1;
                emxEnsureCapacity_real32_T(k_cpu_vec, b_i, &o_emlrtRTEI);
                if (!k_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(k_cpu_vec, &f_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (k_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&f_gpu_vec, k_cpu_vec);
                  }

                  ec_detrend_kernel234<<<grid, block>>>(static_cast<int32_T>
                    (start), m, f_gpu_vec);
                  k_vec_dirtyOnGpu = true;
                  k_vec_dirtyOnCpu = false;
                }
              }
            } else {
              ndbl = std::floor((static_cast<real_T>(stop) - start) + 0.5);
              apnd = start + ndbl;
              cdiff = apnd - stop;
              if (std::abs(cdiff) < 2.384185791015625E-7 * std::fmax(std::abs(
                    static_cast<real_T>(start)), std::abs(static_cast<real_T>
                    (stop)))) {
                ndbl++;
                d2scaled = stop;
              } else if (cdiff > 0.0) {
                d2scaled = static_cast<real32_T>(start + (ndbl - 1.0));
              } else {
                ndbl++;
                d2scaled = static_cast<real32_T>(apnd);
              }

              if (ndbl >= 0.0) {
                m = static_cast<int32_T>(ndbl);
              } else {
                m = 0;
              }

              b_i = k_cpu_vec->size[0] * k_cpu_vec->size[1];
              k_cpu_vec->size[0] = 1;
              k_cpu_vec->size[1] = m;
              emxEnsureCapacity_real32_T(k_cpu_vec, b_i, &p_emlrtRTEI);
              if (!k_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(k_cpu_vec, &f_gpu_vec);
              }

              if (m > 0) {
                if (k_vec_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(k_cpu_vec, &f_gpu_vec);
                }

                k_cpu_vec->data[0] = start;
                k_vec_dirtyOnCpu = true;
                k_vec_dirtyOnGpu = false;
                if (m > 1) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&f_gpu_vec, k_cpu_vec);
                  ec_detrend_kernel229<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, m, f_gpu_vec);
                  k_vec_dirtyOnCpu = false;
                  cpu_npages = (m - 1) / 2;
                  p = true;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                    p = false;
                    ec_detrend_kernel230<<<grid, block>>>(d2scaled, m, start,
                      gpu_npages, f_gpu_vec);
                  }

                  if (cpu_npages << 1 == m - 1) {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel233<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, start, gpu_npages, f_gpu_vec);
                    k_vec_dirtyOnGpu = true;
                  } else {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel231<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (start, gpu_npages, f_gpu_vec);
                    ec_detrend_kernel232<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, gpu_npages, f_gpu_vec);
                    k_vec_dirtyOnGpu = true;
                  }
                }
              }
            }
          }

          b_i = cpu_fv10->size[0];
          cpu_fv10->size[0] = k_cpu_vec->size[1];
          emxEnsureCapacity_real32_T(cpu_fv10, b_i, &r_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_fv10, &gpu_fv10);
          na = k_cpu_vec->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (k_vec_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&f_gpu_vec, k_cpu_vec);
            }

            k_vec_dirtyOnCpu = false;
            ec_detrend_kernel236<<<grid, block>>>(c_gpu_x, f_gpu_vec, na,
              gpu_fv10);
            fv10_dirtyOnGpu = true;
          }

          b_i = i_cpu_a->size[0] * i_cpu_a->size[1];
          i_cpu_a->size[0] = j_cpu_vec->size[1];
          i_cpu_a->size[1] = 1;
          emxEnsureCapacity_real32_T(i_cpu_a, b_i, &rd_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(i_cpu_a, &f_gpu_a);
          na = j_cpu_vec->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (trend_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_trend, cpu_trend);
            }

            trend_dirtyOnCpu = false;
            if (j_vec_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&g_gpu_vec, j_cpu_vec);
            }

            j_vec_dirtyOnCpu = false;
            ec_detrend_kernel237<<<grid, block>>>(gpu_trend, g_gpu_vec, na,
              f_gpu_a);
            c_a_dirtyOnGpu = true;
          }

          if (k_cpu_vec->size[1] == 1) {
            nx = cpu_yy->size[0];
          } else {
            nx = k_cpu_vec->size[1];
          }

          if (k_cpu_vec->size[1] == 1) {
            na = cpu_yy->size[0];
          } else {
            na = k_cpu_vec->size[1];
          }

          if (na == 1) {
            na = e_cpu_b->size[0];
          } else if (k_cpu_vec->size[1] == 1) {
            na = cpu_yy->size[0];
          } else {
            na = k_cpu_vec->size[1];
          }

          if ((cpu_yy->size[0] == k_cpu_vec->size[1]) && (nx == e_cpu_b->size[0])
              && (i_cpu_a->size[0] == na)) {
            na = i_cpu_a->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_b, e_cpu_b);
              }

              c_b_dirtyOnCpu = false;
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_yy, cpu_yy);
              }

              yy_dirtyOnCpu = false;
              if (trend_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_trend, cpu_trend);
              }

              ec_detrend_kernel238<<<grid, block>>>(c_gpu_b, gpu_yy, gpu_fv10,
                f_gpu_a, gpu_iv7, na, gpu_trend);
              trend_dirtyOnGpu = true;
              trend_dirtyOnCpu = false;
            }
          } else {
            if (trend_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_trend, &gpu_trend);
            }

            if (iv7_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_iv7, &gpu_iv7);
            }

            iv7_dirtyOnGpu = false;
            if (c_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(i_cpu_a, &f_gpu_a);
            }

            c_a_dirtyOnGpu = false;
            if (fv10_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv10, &gpu_fv10);
            }

            fv10_dirtyOnGpu = false;
            if (k_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(k_cpu_vec, &f_gpu_vec);
            }

            k_vec_dirtyOnGpu = false;
            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_yy, &gpu_yy);
            }

            yy_dirtyOnGpu = false;
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_b, &c_gpu_b);
            }

            b_dirtyOnGpu = false;
            binary_expand_op(cpu_trend, cpu_iv7, i_cpu_a, cpu_fv10, k_cpu_vec,
                             cpu_yy, e_cpu_b);
            trend_dirtyOnCpu = true;
            trend_dirtyOnGpu = false;
          }

          // bsxfun(@times,x(start:stop,:)-yy,b);
          // 'ec_detrend:136' a(start:stop,1) = a(start:stop)+b;
          if (std::isnan(start)) {
            b_i = cpu_fv11->size[0] * cpu_fv11->size[1];
            cpu_fv11->size[0] = 1;
            cpu_fv11->size[1] = 1;
            emxEnsureCapacity_real32_T(cpu_fv11, b_i, &sd_emlrtRTEI);
            if (!fv11_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(cpu_fv11, &gpu_fv11);
            }

            if (fv11_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv11, &gpu_fv11);
            }

            cpu_fv11->data[0] = rtNaNF;
            fv11_dirtyOnCpu = true;
            fv11_dirtyOnGpu = false;
            b_i = l_cpu_vec->size[0] * l_cpu_vec->size[1];
            l_cpu_vec->size[0] = 1;
            l_cpu_vec->size[1] = 1;
            emxEnsureCapacity_real32_T(l_cpu_vec, b_i, &m_emlrtRTEI);
            if (!l_vec_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real32_T(l_cpu_vec, &h_gpu_vec);
            }

            if (l_vec_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(l_cpu_vec, &h_gpu_vec);
            }

            l_cpu_vec->data[0] = rtNaNF;
            l_vec_dirtyOnCpu = true;
            l_vec_dirtyOnGpu = false;
          } else if (stop < start) {
            cpu_fv11->size[0] = 1;
            cpu_fv11->size[1] = 0;
            l_cpu_vec->size[0] = 1;
            l_cpu_vec->size[1] = 0;
          } else {
            if ((std::isinf(start) || std::isinf(stop)) && (start == stop)) {
              b_i = cpu_fv11->size[0] * cpu_fv11->size[1];
              cpu_fv11->size[0] = 1;
              cpu_fv11->size[1] = 1;
              emxEnsureCapacity_real32_T(cpu_fv11, b_i, &sd_emlrtRTEI);
              if (!fv11_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(cpu_fv11, &gpu_fv11);
              }

              if (fv11_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv11, &gpu_fv11);
              }

              cpu_fv11->data[0] = rtNaNF;
              fv11_dirtyOnCpu = true;
              fv11_dirtyOnGpu = false;
            } else if (std::floor(start) == start) {
              if ((std::abs(start) >= 1.07374182E+9F) || (std::abs(stop) >=
                   1.07374182E+9F)) {
                b_i = cpu_fv11->size[0] * cpu_fv11->size[1];
                cpu_fv11->size[0] = 1;
                cpu_fv11->size[1] = static_cast<int32_T>(static_cast<real_T>
                  (stop) - start) + 1;
                emxEnsureCapacity_real32_T(cpu_fv11, b_i, &sd_emlrtRTEI);
                if (!fv11_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_fv11, &gpu_fv11);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                  static_cast<int64_T>(static_cast<real_T>(stop) - start) + 1L),
                  &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (fv11_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv11, cpu_fv11);
                  }

                  ec_detrend_kernel245<<<grid, block>>>(start, stop, gpu_fv11);
                  fv11_dirtyOnGpu = true;
                  fv11_dirtyOnCpu = false;
                }
              } else {
                m = static_cast<int32_T>(std::trunc(stop)) - static_cast<int32_T>
                  (start);
                b_i = cpu_fv11->size[0] * cpu_fv11->size[1];
                cpu_fv11->size[0] = 1;
                cpu_fv11->size[1] = (static_cast<int32_T>(std::trunc(stop)) -
                                     static_cast<int32_T>(start)) + 1;
                emxEnsureCapacity_real32_T(cpu_fv11, b_i, &o_emlrtRTEI);
                if (!fv11_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_fv11, &gpu_fv11);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (fv11_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv11, cpu_fv11);
                  }

                  ec_detrend_kernel244<<<grid, block>>>(static_cast<int32_T>
                    (start), m, gpu_fv11);
                  fv11_dirtyOnGpu = true;
                  fv11_dirtyOnCpu = false;
                }
              }
            } else {
              ndbl = std::floor((static_cast<real_T>(stop) - start) + 0.5);
              apnd = start + ndbl;
              cdiff = apnd - stop;
              if (std::abs(cdiff) < 2.384185791015625E-7 * std::fmax(std::abs(
                    static_cast<real_T>(start)), std::abs(static_cast<real_T>
                    (stop)))) {
                ndbl++;
                d2scaled = stop;
              } else if (cdiff > 0.0) {
                d2scaled = static_cast<real32_T>(start + (ndbl - 1.0));
              } else {
                ndbl++;
                d2scaled = static_cast<real32_T>(apnd);
              }

              if (ndbl >= 0.0) {
                m = static_cast<int32_T>(ndbl);
              } else {
                m = 0;
              }

              b_i = cpu_fv11->size[0] * cpu_fv11->size[1];
              cpu_fv11->size[0] = 1;
              cpu_fv11->size[1] = m;
              emxEnsureCapacity_real32_T(cpu_fv11, b_i, &p_emlrtRTEI);
              if (!fv11_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(cpu_fv11, &gpu_fv11);
              }

              if (m > 0) {
                if (fv11_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv11, &gpu_fv11);
                }

                cpu_fv11->data[0] = start;
                fv11_dirtyOnCpu = true;
                fv11_dirtyOnGpu = false;
                if (m > 1) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv11, cpu_fv11);
                  ec_detrend_kernel239<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, m, gpu_fv11);
                  fv11_dirtyOnCpu = false;
                  cpu_npages = (m - 1) / 2;
                  p = true;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                    p = false;
                    ec_detrend_kernel240<<<grid, block>>>(d2scaled, m, start,
                      gpu_npages, gpu_fv11);
                  }

                  if (cpu_npages << 1 == m - 1) {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel243<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, start, gpu_npages, gpu_fv11);
                    fv11_dirtyOnGpu = true;
                  } else {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel241<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (start, gpu_npages, gpu_fv11);
                    ec_detrend_kernel242<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, gpu_npages, gpu_fv11);
                    fv11_dirtyOnGpu = true;
                  }
                }
              }
            }

            if ((std::isinf(start) || std::isinf(stop)) && (start == stop)) {
              b_i = l_cpu_vec->size[0] * l_cpu_vec->size[1];
              l_cpu_vec->size[0] = 1;
              l_cpu_vec->size[1] = 1;
              emxEnsureCapacity_real32_T(l_cpu_vec, b_i, &m_emlrtRTEI);
              if (!l_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(l_cpu_vec, &h_gpu_vec);
              }

              if (l_vec_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(l_cpu_vec, &h_gpu_vec);
              }

              l_cpu_vec->data[0] = rtNaNF;
              l_vec_dirtyOnCpu = true;
              l_vec_dirtyOnGpu = false;
            } else if (std::floor(start) == start) {
              if ((std::abs(start) >= 1.07374182E+9F) || (std::abs(stop) >=
                   1.07374182E+9F)) {
                b_i = l_cpu_vec->size[0] * l_cpu_vec->size[1];
                l_cpu_vec->size[0] = 1;
                l_cpu_vec->size[1] = static_cast<int32_T>(static_cast<real_T>
                  (stop) - start) + 1;
                emxEnsureCapacity_real32_T(l_cpu_vec, b_i, &m_emlrtRTEI);
                if (!l_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(l_cpu_vec, &h_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                  static_cast<int64_T>(static_cast<real_T>(stop) - start) + 1L),
                  &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (l_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&h_gpu_vec, l_cpu_vec);
                  }

                  ec_detrend_kernel252<<<grid, block>>>(start, stop, h_gpu_vec);
                  l_vec_dirtyOnGpu = true;
                  l_vec_dirtyOnCpu = false;
                }
              } else {
                m = static_cast<int32_T>(std::trunc(stop)) - static_cast<int32_T>
                  (start);
                b_i = l_cpu_vec->size[0] * l_cpu_vec->size[1];
                l_cpu_vec->size[0] = 1;
                l_cpu_vec->size[1] = (static_cast<int32_T>(std::trunc(stop)) -
                                      static_cast<int32_T>(start)) + 1;
                emxEnsureCapacity_real32_T(l_cpu_vec, b_i, &o_emlrtRTEI);
                if (!l_vec_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(l_cpu_vec, &h_gpu_vec);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (l_vec_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&h_gpu_vec, l_cpu_vec);
                  }

                  ec_detrend_kernel251<<<grid, block>>>(static_cast<int32_T>
                    (start), m, h_gpu_vec);
                  l_vec_dirtyOnGpu = true;
                  l_vec_dirtyOnCpu = false;
                }
              }
            } else {
              ndbl = std::floor((static_cast<real_T>(stop) - start) + 0.5);
              apnd = start + ndbl;
              cdiff = apnd - stop;
              if (std::abs(cdiff) < 2.384185791015625E-7 * std::fmax(std::abs(
                    static_cast<real_T>(start)), std::abs(static_cast<real_T>
                    (stop)))) {
                ndbl++;
                d2scaled = stop;
              } else if (cdiff > 0.0) {
                d2scaled = static_cast<real32_T>(start + (ndbl - 1.0));
              } else {
                ndbl++;
                d2scaled = static_cast<real32_T>(apnd);
              }

              if (ndbl >= 0.0) {
                m = static_cast<int32_T>(ndbl);
              } else {
                m = 0;
              }

              b_i = l_cpu_vec->size[0] * l_cpu_vec->size[1];
              l_cpu_vec->size[0] = 1;
              l_cpu_vec->size[1] = m;
              emxEnsureCapacity_real32_T(l_cpu_vec, b_i, &p_emlrtRTEI);
              if (!l_vec_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(l_cpu_vec, &h_gpu_vec);
              }

              if (m > 0) {
                if (l_vec_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(l_cpu_vec, &h_gpu_vec);
                }

                l_cpu_vec->data[0] = start;
                l_vec_dirtyOnCpu = true;
                l_vec_dirtyOnGpu = false;
                if (m > 1) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&h_gpu_vec, l_cpu_vec);
                  ec_detrend_kernel246<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (d2scaled, m, h_gpu_vec);
                  l_vec_dirtyOnCpu = false;
                  cpu_npages = (m - 1) / 2;
                  p = true;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_npages - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                    p = false;
                    ec_detrend_kernel247<<<grid, block>>>(d2scaled, m, start,
                      gpu_npages, h_gpu_vec);
                  }

                  if (cpu_npages << 1 == m - 1) {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel250<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, start, gpu_npages, h_gpu_vec);
                    l_vec_dirtyOnGpu = true;
                  } else {
                    if (p) {
                      cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ec_detrend_kernel248<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (start, gpu_npages, h_gpu_vec);
                    ec_detrend_kernel249<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (d2scaled, gpu_npages, h_gpu_vec);
                    l_vec_dirtyOnGpu = true;
                  }
                }
              }
            }
          }

          b_i = cpu_iv8->size[0];
          cpu_iv8->size[0] = l_cpu_vec->size[1];
          emxEnsureCapacity_int32_T(cpu_iv8, b_i, &td_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_iv8, &gpu_iv8);
          na = l_cpu_vec->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (l_vec_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&h_gpu_vec, l_cpu_vec);
            }

            l_vec_dirtyOnCpu = false;
            ec_detrend_kernel253<<<grid, block>>>(h_gpu_vec, na, gpu_iv8);
            iv8_dirtyOnGpu = true;
          }

          if (e_cpu_b->size[0] == cpu_fv11->size[1]) {
            b_i = j_cpu_a->size[0];
            j_cpu_a->size[0] = cpu_fv11->size[1];
            emxEnsureCapacity_real32_T(j_cpu_a, b_i, &lc_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(j_cpu_a, &g_gpu_a);
            na = cpu_fv11->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_b, e_cpu_b);
              }

              c_b_dirtyOnCpu = false;
              if (a_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
              }

              a_dirtyOnCpu = false;
              if (fv11_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv11, cpu_fv11);
              }

              fv11_dirtyOnCpu = false;
              ec_detrend_kernel254<<<grid, block>>>(c_gpu_b, gpu_a, gpu_fv11, na,
                g_gpu_a);
            }

            na = j_cpu_a->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (a_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
              }

              ec_detrend_kernel255<<<grid, block>>>(g_gpu_a, gpu_iv8, na, gpu_a);
              a_dirtyOnGpu = true;
              a_dirtyOnCpu = false;
            }
          } else {
            if (a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_a, &gpu_a);
            }

            if (iv8_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_iv8, &gpu_iv8);
            }

            iv8_dirtyOnGpu = false;
            if (fv11_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv11, &gpu_fv11);
            }

            fv11_dirtyOnGpu = false;
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_b, &c_gpu_b);
            }

            b_dirtyOnGpu = false;
            binary_expand_op(cpu_a, cpu_iv8, cpu_fv11, e_cpu_b);
            a_dirtyOnCpu = true;
            a_dirtyOnGpu = false;
          }

          // 'ec_detrend:137' offset = offset+winSz/2;
          offset += winSz / 2.0F;

          // 'ec_detrend:138' if offset > dims(1)-winSz/2
        } while (!(offset > dims_idx_0 - winSz / 2.0F));

        // 'ec_detrend:138' ;
        // 'ec_detrend:141' if stop<dims(1)
        if (stop < dims_idx_0) {
          //  last sample can be missed
          // 'ec_detrend:142' y(end,:) = y(end-1,:);
          if (d_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_x, &d_gpu_x);
          }

          y_data[0] = d_cpu_x->data[static_cast<int32_T>(static_cast<real32_T>
            (d_cpu_x->size[0]) - 1.0F) - 1];
          d_cpu_x->data[static_cast<int32_T>(static_cast<real32_T>(d_cpu_x->
            size[0])) - 1] = y_data[0];
          b_x_dirtyOnCpu = true;
          d_x_dirtyOnGpu = false;

          // 'ec_detrend:143' a(end,:) = a(end-1,:);
          if (a_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
          }

          ec_detrend_kernel256<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a,
            cpu_a->size[0U]);
          a_dirtyOnGpu = true;
          a_dirtyOnCpu = false;
        }

        // 'ec_detrend:145' y = y.*(1./a);
        b_i = cpu_fv12->size[0];
        cpu_fv12->size[0] = cpu_a->size[0];
        emxEnsureCapacity_real32_T(cpu_fv12, b_i, &ud_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_fv12, &gpu_fv12);
        na = cpu_a->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (a_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
          }

          a_dirtyOnCpu = false;
          ec_detrend_kernel257<<<grid, block>>>(gpu_a, na, gpu_fv12);
          fv12_dirtyOnGpu = true;
        }

        if (d_cpu_x->size[0] == cpu_fv12->size[0]) {
          b_i = k_cpu_c->size[0] * k_cpu_c->size[1];
          k_cpu_c->size[0] = d_cpu_x->size[0];
          k_cpu_c->size[1] = 1;
          emxEnsureCapacity_real32_T(k_cpu_c, b_i, &m_emlrtRTEI);
          if (!i_c_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(k_cpu_c, &f_gpu_c);
          }

          na = d_cpu_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_x, d_cpu_x);
            }

            b_x_dirtyOnCpu = false;
            if (i_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&f_gpu_c, k_cpu_c);
            }

            ec_detrend_kernel258<<<grid, block>>>(gpu_fv12, d_gpu_x, na, f_gpu_c);
            i_c_dirtyOnGpu = true;
            i_c_dirtyOnCpu = false;
          }
        } else {
          if (i_c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(k_cpu_c, &f_gpu_c);
          }

          if (d_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_x, &d_gpu_x);
          }

          d_x_dirtyOnGpu = false;
          if (fv12_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv12, &gpu_fv12);
          }

          fv12_dirtyOnGpu = false;
          b_binary_expand_op(k_cpu_c, d_cpu_x, cpu_fv12);
          i_c_dirtyOnCpu = true;
          i_c_dirtyOnGpu = false;
        }

        if (d_cpu_x->size[0] == cpu_fv12->size[0]) {
          b_i = e_cpu_x->size[0] * e_cpu_x->size[1];
          e_cpu_x->size[0] = d_cpu_x->size[0];
          e_cpu_x->size[1] = 1;
          emxEnsureCapacity_real32_T(e_cpu_x, b_i, &vd_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(e_cpu_x, &e_gpu_x);
          na = d_cpu_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_x, d_cpu_x);
            }

            b_x_dirtyOnCpu = false;
            ec_detrend_kernel259<<<grid, block>>>(gpu_fv12, d_gpu_x, na, e_gpu_x);
          }

          b_i = d_cpu_x->size[0] * d_cpu_x->size[1];
          d_cpu_x->size[0] = e_cpu_x->size[0];
          d_cpu_x->size[1] = 1;
          emxEnsureCapacity_real32_T(d_cpu_x, b_i, &wd_emlrtRTEI);
          if (!b_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(d_cpu_x, &d_gpu_x);
          }

          na = e_cpu_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_x, d_cpu_x);
            }

            ec_detrend_kernel260<<<grid, block>>>(e_gpu_x, na, d_gpu_x);
            d_x_dirtyOnGpu = true;
            b_x_dirtyOnCpu = false;
          }
        } else {
          if (d_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_x, &d_gpu_x);
          }

          if (fv12_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv12, &gpu_fv12);
          }

          fv12_dirtyOnGpu = false;
          binary_expand_op(d_cpu_x, cpu_fv12);
          b_x_dirtyOnCpu = true;
          d_x_dirtyOnGpu = false;
        }

        // bsxfun(@times,y,1./a);
        // 'ec_detrend:146' y(isnan(y)) = 0;
        n = d_cpu_x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_x, d_cpu_x);
          }

          ec_detrend_kernel261<<<grid, block>>>(n, d_gpu_x);
          d_x_dirtyOnGpu = true;
          b_x_dirtyOnCpu = false;
        }

        // 'ec_detrend:147' trend = trend.*(1./a);
        b_i = cpu_fv13->size[0];
        cpu_fv13->size[0] = cpu_a->size[0];
        emxEnsureCapacity_real32_T(cpu_fv13, b_i, &ud_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_fv13, &gpu_fv13);
        na = cpu_a->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (a_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
          }

          a_dirtyOnCpu = false;
          ec_detrend_kernel262<<<grid, block>>>(gpu_a, na, gpu_fv13);
          fv13_dirtyOnGpu = true;
        }

        if (cpu_trend->size[0] == cpu_fv13->size[0]) {
          b_i = l_cpu_c->size[0] * l_cpu_c->size[1];
          l_cpu_c->size[0] = cpu_trend->size[0];
          l_cpu_c->size[1] = 1;
          emxEnsureCapacity_real32_T(l_cpu_c, b_i, &m_emlrtRTEI);
          if (!j_c_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(l_cpu_c, &g_gpu_c);
          }

          na = cpu_trend->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (trend_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_trend, cpu_trend);
            }

            trend_dirtyOnCpu = false;
            if (j_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&g_gpu_c, l_cpu_c);
            }

            ec_detrend_kernel263<<<grid, block>>>(gpu_fv13, gpu_trend, na,
              g_gpu_c);
            j_c_dirtyOnGpu = true;
            j_c_dirtyOnCpu = false;
          }
        } else {
          if (j_c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(l_cpu_c, &g_gpu_c);
          }

          if (trend_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_trend, &gpu_trend);
          }

          trend_dirtyOnGpu = false;
          if (fv13_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv13, &gpu_fv13);
          }

          fv13_dirtyOnGpu = false;
          b_binary_expand_op(l_cpu_c, cpu_trend, cpu_fv13);
          j_c_dirtyOnCpu = true;
          j_c_dirtyOnGpu = false;
        }

        if (cpu_trend->size[0] == cpu_fv13->size[0]) {
          b_i = b_cpu_trend->size[0] * b_cpu_trend->size[1];
          b_cpu_trend->size[0] = cpu_trend->size[0];
          b_cpu_trend->size[1] = 1;
          emxEnsureCapacity_real32_T(b_cpu_trend, b_i, &xd_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(b_cpu_trend, &b_gpu_trend);
          na = cpu_trend->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (trend_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_trend, cpu_trend);
            }

            trend_dirtyOnCpu = false;
            ec_detrend_kernel264<<<grid, block>>>(gpu_fv13, gpu_trend, na,
              b_gpu_trend);
          }

          b_i = cpu_trend->size[0] * cpu_trend->size[1];
          cpu_trend->size[0] = b_cpu_trend->size[0];
          cpu_trend->size[1] = 1;
          emxEnsureCapacity_real32_T(cpu_trend, b_i, &yd_emlrtRTEI);
          if (!trend_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_trend, &gpu_trend);
          }

          na = b_cpu_trend->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (trend_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_trend, cpu_trend);
            }

            ec_detrend_kernel265<<<grid, block>>>(b_gpu_trend, na, gpu_trend);
            trend_dirtyOnGpu = true;
            trend_dirtyOnCpu = false;
          }
        } else {
          if (trend_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_trend, &gpu_trend);
          }

          if (fv13_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv13, &gpu_fv13);
          }

          fv13_dirtyOnGpu = false;
          binary_expand_op(cpu_trend, cpu_fv13);
          trend_dirtyOnCpu = true;
          trend_dirtyOnGpu = false;
        }

        // bsxfun(@times,trend,1./a);
        // 'ec_detrend:148' trend(isnan(trend)) = 0;
        n = cpu_trend->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (trend_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_trend, cpu_trend);
          }

          ec_detrend_kernel266<<<grid, block>>>(n, gpu_trend);
          trend_dirtyOnGpu = true;
          trend_dirtyOnCpu = false;
        }

        //  Find outliers
        // 'ec_detrend:151' d = (x-trend).*w;
        if (i1 == 1) {
          nx = cpu_trend->size[0];
        } else {
          nx = i1;
        }

        if ((i1 == cpu_trend->size[0]) && (nx == b_cpu_w->size[0])) {
          b_i = m_cpu_c->size[0] * m_cpu_c->size[1];
          m_cpu_c->size[0] = i1;
          m_cpu_c->size[1] = 1;
          emxEnsureCapacity_real32_T(m_cpu_c, b_i, &m_emlrtRTEI);
          if (!k_c_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(m_cpu_c, &h_gpu_c);
          }

          na = i1 - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (trend_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_trend, cpu_trend);
            }

            trend_dirtyOnCpu = false;
            if (k_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&h_gpu_c, m_cpu_c);
            }

            ec_detrend_kernel267<<<grid, block>>>(b_gpu_w, gpu_trend, c_gpu_x,
              i1 - 1, h_gpu_c);
            k_c_dirtyOnGpu = true;
            k_c_dirtyOnCpu = false;
          }
        } else {
          if (k_c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(m_cpu_c, &h_gpu_c);
          }

          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_x, &c_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          if (trend_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_trend, &gpu_trend);
          }

          trend_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          b_binary_expand_op(m_cpu_c, b_cpu_x, i1, cpu_trend, b_cpu_w);
          k_c_dirtyOnCpu = true;
          k_c_dirtyOnGpu = false;
        }

        b_i = cpu_x->size[0];
        if (b_i == 1) {
          nx = cpu_trend->size[0];
        } else {
          nx = b_i;
        }

        if ((b_i == cpu_trend->size[0]) && (nx == b_cpu_w->size[0])) {
          cpu_npages = c_cpu_d->size[0] * c_cpu_d->size[1];
          c_cpu_d->size[0] = b_i;
          c_cpu_d->size[1] = 1;
          emxEnsureCapacity_real32_T(c_cpu_d, cpu_npages, &ae_emlrtRTEI);
          if (!c_d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(c_cpu_d, &b_gpu_d);
          }

          na = b_i - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (trend_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_trend, cpu_trend);
            }

            trend_dirtyOnCpu = false;
            if (c_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_d, c_cpu_d);
            }

            ec_detrend_kernel268<<<grid, block>>>(b_gpu_w, gpu_trend, b_gpu_x,
              b_i - 1, b_gpu_d);
            c_d_dirtyOnGpu = true;
            c_d_dirtyOnCpu = false;
          }
        } else {
          if (c_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_d, &b_gpu_d);
          }

          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_x, &b_gpu_x);
          }

          c_x_dirtyOnGpu = false;
          if (x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_x, &gpu_x);
          }

          x_dirtyOnGpu = false;
          if (trend_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_trend, &gpu_trend);
          }

          trend_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          b_binary_expand_op(c_cpu_d, c_cpu_x, cpu_x, cpu_trend, b_cpu_w);
          c_d_dirtyOnCpu = true;
          c_d_dirtyOnGpu = false;
        }

        // 'ec_detrend:152' thrItr = thr*std(d);
        m = m_cpu_c->size[0];
        if (m == 0) {
          y_data[0] = rtNaNF;
        } else if (m == 1) {
          if (c_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_d, &b_gpu_d);
          }

          c_d_dirtyOnGpu = false;
          d2scaled = c_cpu_d->data[0];
          if ((!std::isinf(d2scaled)) && (!std::isnan(d2scaled))) {
            y_data[0] = 0.0F;
          } else {
            y_data[0] = rtNaNF;
          }
        } else {
          if (c_cpu_d->size[0] == 0) {
            d2scaled = 0.0F;
          } else {
            if (c_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_d, &b_gpu_d);
            }

            c_d_dirtyOnGpu = false;
            d2scaled = c_cpu_d->data[0];
            for (na = 0; na <= m - 2; na++) {
              d2scaled += c_cpu_d->data[na + 1];
            }
          }

          d2scaled /= static_cast<real32_T>(m);
          b_i = c_cpu_absdiff->size[0];
          c_cpu_absdiff->size[0] = c_cpu_d->size[0];
          emxEnsureCapacity_real32_T(c_cpu_absdiff, b_i, &id_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(c_cpu_absdiff, &b_gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (k_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&h_gpu_c, m_cpu_c);
            }

            k_c_dirtyOnCpu = false;
            ec_detrend_kernel269<<<grid, block>>>(d2scaled, h_gpu_c, m,
              b_gpu_absdiff);
          }

          cublasSnrm2(getCublasGlobalHandle(), m, (float *)&b_gpu_absdiff.data[0],
                      1, (float *)&d2scaled);
          y_data[0] = d2scaled / std::sqrt(static_cast<real32_T>(m - 1));
        }

        // 'ec_detrend:153' w(abs(d)>thrItr) = 0;
        nx = m_cpu_c->size[0];
        b_i = d_cpu_y->size[0] * d_cpu_y->size[1];
        d_cpu_y->size[0] = c_cpu_d->size[0];
        d_cpu_y->size[1] = 1;
        emxEnsureCapacity_real32_T(d_cpu_y, b_i, &hd_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(d_cpu_y, &b_gpu_y);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_d, c_cpu_d);
          }

          c_d_dirtyOnCpu = false;
          ec_detrend_kernel270<<<grid, block>>>(b_gpu_d, nx, b_gpu_y);
        }

        b_i = cpu_r1->size[0] * cpu_r1->size[1];
        cpu_r1->size[0] = d_cpu_y->size[0];
        cpu_r1->size[1] = 1;
        emxEnsureCapacity_boolean_T(cpu_r1, b_i, &be_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(cpu_r1, &gpu_r1);
        na = d_cpu_y->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detrend_kernel271<<<grid, block>>>(y_data[0], thr, b_gpu_y, na,
            gpu_r1);
        }

        n = cpu_r1->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detrend_kernel272<<<grid, block>>>(gpu_r1, n, b_gpu_w);
          b_w_dirtyOnGpu = true;
        }

        //  update weights
      }
    } else {
      int32_T i7;
      int32_T nx;

      //  Standard detrending (trend fit to entire data)
      // 'ec_detrend:52' [x,w] = detrend_lfn(x,w,order,thr,nItr);
      //  Standard detrending (trend fit to entire data)
      //  The data are fit to the basis using weighted least squares. The weight is
      //  updated by setting samples for which the residual is greater than 'thresh'
      //  times its std to zero, and the fit is repeated at most 'niter'-1 times.
      //
      //  The choice of order (and basis) determines what complexity of the trend
      //  that can be removed.  It may be useful to first detrend with a low order
      //  to avoid fitting outliers, and then increase the order.
      //
      //  The tricky bit is to ensure that weighted means are removed before
      //  calculating the regression (see nt_regw)
      //  Get regressors from basis function
      // 'ec_detrend:74' nFrames = height(x);
      // 'ec_detrend:75' r = coder.nullcopy(zeros(nFrames,order,'like',x));
      b_i = cpu_x->size[0];
      cpu_npages = cpu_r->size[0] * cpu_r->size[1];
      cpu_r->size[0] = static_cast<int32_T>(static_cast<real32_T>(b_i));
      cpu_r->size[1] = static_cast<int32_T>(order);
      emxEnsureCapacity_real32_T(cpu_r, cpu_npages, &f_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_r, &c_gpu_r);

      // 'ec_detrend:76' lin = linspace(-1,1,nFrames);
      cpu_npages = cpu_lin->size[0] * cpu_lin->size[1];
      cpu_lin->size[0] = 1;
      cpu_lin->size[1] = static_cast<int32_T>(static_cast<real32_T>(b_i));
      emxEnsureCapacity_real32_T(cpu_lin, cpu_npages, &g_emlrtRTEI);
      if (!lin_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(cpu_lin, &b_gpu_lin);
      }

      if (static_cast<int32_T>(static_cast<real32_T>(b_i)) >= 1) {
        if (lin_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_lin, &b_gpu_lin);
        }

        cpu_lin->data[static_cast<int32_T>(static_cast<real32_T>(b_i)) - 1] =
          1.0F;
        lin_dirtyOnCpu = true;
        lin_dirtyOnGpu = false;
        if (cpu_lin->size[1] >= 2) {
          cpu_lin->data[0] = -1.0F;
          if (cpu_lin->size[1] >= 3) {
            d2scaled = 1.0F / static_cast<real32_T>(cpu_lin->size[1] - 1);
            cpu_npages = cpu_lin->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages - 2L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_lin, cpu_lin);
              ec_detrend_kernel4<<<grid, block>>>(d2scaled, gpu_npages,
                b_gpu_lin, cpu_lin->size[1U]);
              lin_dirtyOnGpu = true;
              lin_dirtyOnCpu = false;
            }

            if ((cpu_lin->size[1] & 1) == 1) {
              if (lin_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_lin, cpu_lin);
              }

              ec_detrend_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (b_gpu_lin, cpu_lin->size[1U]);
              lin_dirtyOnGpu = true;
              lin_dirtyOnCpu = false;
            }
          }
        }
      }

      // 'ec_detrend:77' for k=1:order
      cpu_npages = static_cast<int32_T>(order);
      nx = cpu_lin->size[1];
      for (n = 0; n < cpu_npages; n++) {
        // 'ec_detrend:78' r(:,k) = lin.^k;
        b_i = cpu_fv->size[0] * cpu_fv->size[1];
        cpu_fv->size[0] = 1;
        cpu_fv->size[1] = cpu_lin->size[1];
        emxEnsureCapacity_real32_T(cpu_fv, b_i, &j_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (lin_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_lin, cpu_lin);
          }

          lin_dirtyOnCpu = false;
          ec_detrend_kernel6<<<grid, block>>>(n, b_gpu_lin, nx, gpu_fv);
        }

        x[0] = cpu_r->size[0];
        na = x[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detrend_kernel7<<<grid, block>>>(gpu_fv, static_cast<int32_T>(
            static_cast<real32_T>(n) + 1.0F), x[0] - 1, c_gpu_r, cpu_r->size[0U]);
          r_dirtyOnGpu = true;
        }
      }

      //  Remove trends
      // 'ec_detrend:82' z = coder.nullcopy(zeros(size(x),'like',x));
      b_i = cpu_z->size[0] * cpu_z->size[1];
      cpu_z->size[0] = static_cast<int32_T>(static_cast<real32_T>(cpu_x->size[0]));
      cpu_z->size[1] = 1;
      emxEnsureCapacity_real32_T(cpu_z, b_i, &k_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_z, &c_gpu_z);

      // 'ec_detrend:83' for ii = 1:nItr
      i7 = static_cast<int32_T>(nItr);
      for (int32_T ii{0}; ii < i7; ii++) {
        int32_T vlen;
        real32_T y_data[1];
        real32_T b_out;
        real32_T out;
        boolean_T p;

        //  Weighted regression on basis
        // 'ec_detrend:85' z = regw_lfn(x,w,r);
        //  Weighted Regression
        //   b: regression matrix (apply to r to approximate x)
        //   z: regression (r*b)
        //  discard dimensions of r with eigenvalue lower than this
        // 'ec_detrend:165' thrPCA = 1e-7;
        // zeros(1,1,class(x));
        //  save weighted mean
        // 'ec_detrend:168' mn = x - demean_lfn(x,w);
        //  Demean
        // 'ec_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (i1 == b_cpu_w->size[0]) {
          b_i = cpu_c->size[0];
          cpu_c->size[0] = i1;
          emxEnsureCapacity_real32_T(cpu_c, b_i, &m_emlrtRTEI);
          if (!c_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_c, &i_gpu_c);
          }

          na = i1 - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&i_gpu_c, cpu_c);
            }

            ec_detrend_kernel8<<<grid, block>>>(b_gpu_w, c_gpu_x, i1 - 1,
              i_gpu_c);
            c_dirtyOnGpu = true;
            c_dirtyOnCpu = false;
          }
        } else {
          if (c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_c, &i_gpu_c);
          }

          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_x, &c_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(cpu_c, b_cpu_x, i1, b_cpu_w);
          c_dirtyOnCpu = true;
          c_dirtyOnGpu = false;
        }

        vlen = cpu_c->size[0];
        if (cpu_c->size[0] == 0) {
          d2scaled = 0.0F;
        } else {
          if (c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_c, &i_gpu_c);
          }

          c_dirtyOnGpu = false;
          d2scaled = cpu_c->data[0];
          for (na = 0; na <= vlen - 2; na++) {
            d2scaled += cpu_c->data[na + 1];
          }
        }

        vlen = b_cpu_w->size[0];
        if (b_cpu_w->size[0] == 0) {
          abnrm = 0.0F;
        } else {
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          abnrm = b_cpu_w->data[0];
          for (na = 0; na <= vlen - 2; na++) {
            abnrm += b_cpu_w->data[na + 1];
          }
        }

        out = d2scaled / (abnrm + 2.22044605E-16F);

        // 'ec_detrend:188' x = x - mn;
        //  Fit weighted regression
        // 'ec_detrend:171' x = demean_lfn(x,w).* w;
        //  Demean
        // 'ec_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (i1 == b_cpu_w->size[0]) {
          b_i = b_cpu_c->size[0];
          b_cpu_c->size[0] = i1;
          emxEnsureCapacity_real32_T(b_cpu_c, b_i, &m_emlrtRTEI);
          if (!b_c_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_c, &j_gpu_c);
          }

          na = i1 - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&j_gpu_c, b_cpu_c);
            }

            ec_detrend_kernel9<<<grid, block>>>(b_gpu_w, c_gpu_x, i1 - 1,
              j_gpu_c);
            b_c_dirtyOnGpu = true;
            b_c_dirtyOnCpu = false;
          }
        } else {
          if (b_c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_c, &j_gpu_c);
          }

          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_x, &c_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(b_cpu_c, b_cpu_x, i1, b_cpu_w);
          b_c_dirtyOnCpu = true;
          b_c_dirtyOnGpu = false;
        }

        vlen = b_cpu_c->size[0];
        if (b_cpu_c->size[0] == 0) {
          d2scaled = 0.0F;
        } else {
          if (b_c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_c, &j_gpu_c);
          }

          b_c_dirtyOnGpu = false;
          d2scaled = b_cpu_c->data[0];
          for (na = 0; na <= vlen - 2; na++) {
            d2scaled += b_cpu_c->data[na + 1];
          }
        }

        vlen = b_cpu_w->size[0];
        if (b_cpu_w->size[0] == 0) {
          abnrm = 0.0F;
        } else {
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          abnrm = b_cpu_w->data[0];
          for (na = 0; na <= vlen - 2; na++) {
            abnrm += b_cpu_w->data[na + 1];
          }
        }

        b_out = d2scaled / (abnrm + 2.22044605E-16F);

        // 'ec_detrend:188' x = x - mn;
        if (c_cpu_x->size[0] == b_cpu_w->size[0]) {
          b_i = cpu_fv4->size[0];
          cpu_fv4->size[0] = c_cpu_x->size[0];
          emxEnsureCapacity_real32_T(cpu_fv4, b_i, &q_emlrtRTEI);
          if (!fv4_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv4, &gpu_fv4);
          }

          na = c_cpu_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (fv4_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv4, cpu_fv4);
            }

            ec_detrend_kernel10<<<grid, block>>>(b_gpu_w, b_out, b_gpu_x, na,
              gpu_fv4);
            fv4_dirtyOnGpu = true;
            fv4_dirtyOnCpu = false;
          }
        } else {
          if (fv4_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv4, &gpu_fv4);
          }

          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_x, &b_gpu_x);
          }

          c_x_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(cpu_fv4, c_cpu_x, b_out, b_cpu_w);
          fv4_dirtyOnCpu = true;
          fv4_dirtyOnGpu = false;
        }

        // 'ec_detrend:172' r = demean_lfn(r,w);
        //  Demean
        // 'ec_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_r->size[0] == b_cpu_w->size[0]) {
          b_i = c_cpu_c->size[0] * c_cpu_c->size[1];
          c_cpu_c->size[0] = cpu_r->size[0];
          c_cpu_c->size[1] = cpu_r->size[1];
          emxEnsureCapacity_real32_T(c_cpu_c, b_i, &m_emlrtRTEI);
          if (!c_c_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(c_cpu_c, &k_gpu_c);
          }

          na = cpu_r->size[1] - 1;
          nx = cpu_r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx +
            1L) * (na + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&k_gpu_c, c_cpu_c);
            }

            ec_detrend_kernel11<<<grid, block>>>(b_gpu_w, c_gpu_r, nx, na,
              k_gpu_c, c_cpu_c->size[0U], cpu_r->size[0U]);
            c_c_dirtyOnGpu = true;
            c_c_dirtyOnCpu = false;
          }
        } else {
          if (c_c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_c, &k_gpu_c);
          }

          if (r_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_r, &c_gpu_r);
          }

          r_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(c_cpu_c, cpu_r, b_cpu_w);
          c_c_dirtyOnCpu = true;
          c_c_dirtyOnGpu = false;
        }

        vlen = c_cpu_c->size[0];
        if ((c_cpu_c->size[0] == 0) || (c_cpu_c->size[1] == 0)) {
          for (b_i = 0; b_i < 2; b_i++) {
            sz[b_i] = static_cast<uint32_T>(c_cpu_c->size[b_i]);
          }

          b_i = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = static_cast<int32_T>(sz[1]);
          emxEnsureCapacity_real32_T(cpu_y, b_i, &t_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_y, &c_gpu_y);
          na = static_cast<int32_T>(sz[1]) - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel13<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
              c_gpu_y);
            y_dirtyOnGpu = true;
          }
        } else {
          cpu_npages = c_cpu_c->size[1];
          b_i = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = c_cpu_c->size[1];
          emxEnsureCapacity_real32_T(cpu_y, b_i, &s_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_y, &c_gpu_y);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (cpu_npages), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&k_gpu_c, c_cpu_c);
            }

            c_c_dirtyOnCpu = false;
            cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
            ec_detrend_kernel12<<<grid, block>>>(vlen, k_gpu_c, gpu_npages,
              c_gpu_y, c_cpu_c->size[0U]);
            y_dirtyOnGpu = true;
          }
        }

        vlen = b_cpu_w->size[0];
        if (b_cpu_w->size[0] == 0) {
          d2scaled = 0.0F;
        } else {
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          d2scaled = b_cpu_w->data[0];
          for (na = 0; na <= vlen - 2; na++) {
            d2scaled += b_cpu_w->data[na + 1];
          }
        }

        // 'ec_detrend:188' x = x - mn;
        if (cpu_r->size[1] == cpu_y->size[1]) {
          d2scaled += 2.22044605E-16F;
          b_i = cpu_fv6->size[0] * cpu_fv6->size[1];
          cpu_fv6->size[0] = cpu_r->size[0];
          cpu_fv6->size[1] = cpu_r->size[1];
          emxEnsureCapacity_real32_T(cpu_fv6, b_i, &u_emlrtRTEI);
          if (!fv6_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv6, &gpu_fv6);
          }

          na = cpu_r->size[1] - 1;
          nx = cpu_r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx +
            1L) * (na + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (fv6_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv6, cpu_fv6);
            }

            ec_detrend_kernel14<<<grid, block>>>(d2scaled, c_gpu_y, c_gpu_r, nx,
              na, gpu_fv6, cpu_fv6->size[0U], cpu_r->size[0U]);
            fv6_dirtyOnGpu = true;
            fv6_dirtyOnCpu = false;
          }
        } else {
          if (fv6_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv6, &gpu_fv6);
          }

          if (r_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_r, &c_gpu_r);
          }

          r_dirtyOnGpu = false;
          if (y_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_y, &c_gpu_y);
          }

          y_dirtyOnGpu = false;
          binary_expand_op(cpu_fv6, cpu_r, cpu_y, d2scaled);
          fv6_dirtyOnCpu = true;
          fv6_dirtyOnGpu = false;
        }

        //  remove channel-specific-weighted mean from regressor
        // 'ec_detrend:173' rr = r.*w;
        if (cpu_fv6->size[0] == b_cpu_w->size[0]) {
          b_i = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = cpu_fv6->size[0];
          cpu_rr->size[1] = cpu_fv6->size[1];
          emxEnsureCapacity_real32_T(cpu_rr, b_i, &v_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_rr, &b_gpu_rr);
          }

          na = cpu_fv6->size[1] - 1;
          nx = cpu_fv6->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx +
            1L) * (na + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (fv6_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv6, cpu_fv6);
            }

            fv6_dirtyOnCpu = false;
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_rr, cpu_rr);
            }

            ec_detrend_kernel15<<<grid, block>>>(b_gpu_w, gpu_fv6, nx, na,
              b_gpu_rr, cpu_rr->size[0U], cpu_fv6->size[0U]);
            rr_dirtyOnGpu = true;
            rr_dirtyOnCpu = false;
          }
        } else {
          if (rr_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_rr, &b_gpu_rr);
          }

          if (fv6_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv6, &gpu_fv6);
          }

          fv6_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(cpu_rr, cpu_fv6, b_cpu_w);
          rr_dirtyOnCpu = true;
          rr_dirtyOnGpu = false;
        }

        // 'ec_detrend:174' [V,D] = eig(rr'*rr);
        b_i = b_cpu_a->size[0] * b_cpu_a->size[1];
        b_cpu_a->size[0] = cpu_rr->size[1];
        b_cpu_a->size[1] = cpu_rr->size[0];
        emxEnsureCapacity_real32_T(b_cpu_a, b_i, &w_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_a, &h_gpu_a);
        nx = cpu_rr->size[0] - 1;
        na = cpu_rr->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((na + 1L)
          * (nx + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          ec_detrend_kernel16<<<grid, block>>>(b_gpu_rr, na, nx, h_gpu_a,
            b_cpu_a->size[0U], cpu_rr->size[0U]);
        }

        if ((b_cpu_a->size[0] == 0) || (b_cpu_a->size[1] == 0) || (cpu_rr->size
             [0] == 0) || (cpu_rr->size[1] == 0)) {
          b_i = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = b_cpu_a->size[0];
          cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(cpu_A, b_i, &m_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_A, &e_gpu_A);
          }

          na = b_cpu_a->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_A, cpu_A);
            }

            ec_detrend_kernel17<<<grid, block>>>(na, e_gpu_A);
            A_dirtyOnGpu = true;
            A_dirtyOnCpu = false;
          }
        } else {
          b_i = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = b_cpu_a->size[0];
          cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(cpu_A, b_i, &x_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_A, &e_gpu_A);
          }

          d2scaled = 1.0F;
          abnrm = 0.0F;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          if (A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_A, cpu_A);
          }

          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      b_cpu_a->size[0], cpu_rr->size[1], b_cpu_a->size[1],
                      (float *)&d2scaled, (float *)&h_gpu_a.data[0],
                      b_cpu_a->size[0], (float *)&b_gpu_rr.data[0],
                      b_cpu_a->size[1], (float *)&abnrm, (float *)&e_gpu_A.data
                      [0], b_cpu_a->size[0]);
          A_dirtyOnGpu = true;
          A_dirtyOnCpu = false;
        }

        m = cpu_A->size[0];
        b_i = cpu_V->size[0] * cpu_V->size[1];
        cpu_V->size[0] = cpu_A->size[0];
        cpu_V->size[1] = cpu_A->size[0];
        emxEnsureCapacity_creal32_T(cpu_V, b_i, &y_emlrtRTEI);
        if (!V_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal32_T(cpu_V, &d_gpu_V);
        }

        b_i = cpu_D->size[0] * cpu_D->size[1];
        cpu_D->size[0] = cpu_A->size[0];
        cpu_D->size[1] = cpu_A->size[0];
        emxEnsureCapacity_creal32_T(cpu_D, b_i, &ab_emlrtRTEI);
        if (!D_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal32_T(cpu_D, &c_gpu_D);
        }

        if ((cpu_A->size[0] != 0) && (cpu_A->size[1] != 0)) {
          nx = cpu_A->size[0] * cpu_A->size[1];
          p = true;
          for (n = 0; n < nx; n++) {
            if (p) {
              if (A_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &e_gpu_A);
              }

              A_dirtyOnGpu = false;
              if (std::isinf(cpu_A->data[n]) || std::isnan(cpu_A->data[n])) {
                p = false;
              }
            } else {
              p = false;
            }
          }

          if (!p) {
            for (b_i = 0; b_i < 2; b_i++) {
              V[b_i] = cpu_V->size[b_i];
            }

            b_i = cpu_V->size[0] * cpu_V->size[1];
            cpu_V->size[0] = V[0];
            cpu_V->size[1] = V[1];
            emxEnsureCapacity_creal32_T(cpu_V, b_i, &cb_emlrtRTEI);
            if (!V_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal32_T(cpu_V, &d_gpu_V);
            }

            na = V[0] * V[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (V_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal32_T(&d_gpu_V, cpu_V);
              }

              ec_detrend_kernel39<<<grid, block>>>(gpu_fc, na, d_gpu_V);
              V_dirtyOnGpu = true;
              V_dirtyOnCpu = false;
            }

            for (b_i = 0; b_i < 2; b_i++) {
              V[b_i] = cpu_D->size[b_i];
            }

            b_i = cpu_D->size[0] * cpu_D->size[1];
            cpu_D->size[0] = V[0];
            cpu_D->size[1] = V[1];
            emxEnsureCapacity_creal32_T(cpu_D, b_i, &hb_emlrtRTEI);
            if (!D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal32_T(cpu_D, &c_gpu_D);
            }

            na = V[0] * V[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal32_T(&c_gpu_D, cpu_D);
              }

              ec_detrend_kernel40<<<grid, block>>>(na, c_gpu_D);
              D_dirtyOnGpu = true;
              D_dirtyOnCpu = false;
            }

            for (n = 0; n < m; n++) {
              if (D_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &c_gpu_D);
              }

              if (fc_dirtyOnGpu) {
                cudaMemcpy(&cpu_fc, gpu_fc, 8UL, cudaMemcpyDeviceToHost);
              }

              fc_dirtyOnGpu = false;
              cpu_D->data[n + cpu_D->size[0] * n] = cpu_fc;
              D_dirtyOnCpu = true;
              D_dirtyOnGpu = false;
            }
          } else {
            int32_T exitg1;
            boolean_T exitg2;
            p = (cpu_A->size[0] == cpu_A->size[1]);
            if (p) {
              na = 0;
              exitg2 = false;
              while ((!exitg2) && (na <= cpu_A->size[1] - 1)) {
                b_i = 0;
                do {
                  exitg1 = 0;
                  if (b_i <= na) {
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &e_gpu_A);
                    }

                    A_dirtyOnGpu = false;
                    if (!(cpu_A->data[b_i + cpu_A->size[0] * na] == cpu_A->
                          data[na + cpu_A->size[0] * b_i])) {
                      p = false;
                      exitg1 = 1;
                    } else {
                      b_i++;
                    }
                  } else {
                    na++;
                    exitg1 = 2;
                  }
                } while (exitg1 == 0);

                if (exitg1 == 1) {
                  exitg2 = true;
                }
              }
            }

            if (p) {
              ptrdiff_t info_t;
              ptrdiff_t n_t;
              m = cpu_A->size[0];
              n_t = (ptrdiff_t)cpu_A->size[0];
              b_i = cpu_W->size[0];
              cpu_W->size[0] = cpu_A->size[0];
              emxEnsureCapacity_real32_T(cpu_W, b_i, &eb_emlrtRTEI);
              if (!W_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(cpu_W, &c_gpu_W);
              }

              if (A_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &e_gpu_A);
              }

              if (W_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_W, &c_gpu_W);
              }

              info_t = LAPACKE_ssyev(102, 'V', 'L', n_t, &cpu_A->data[0], n_t,
                &cpu_W->data[0]);
              W_dirtyOnCpu = true;
              W_dirtyOnGpu = false;
              A_dirtyOnCpu = true;
              A_dirtyOnGpu = false;
              if ((int32_T)info_t < 0) {
                x[0] = cpu_W->size[0];
                b_i = cpu_W->size[0];
                cpu_W->size[0] = x[0];
                emxEnsureCapacity_real32_T(cpu_W, b_i, &lb_emlrtRTEI);
                na = x[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (na + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_W, cpu_W);
                  ec_detrend_kernel35<<<grid, block>>>(x[0] - 1, c_gpu_W);
                  W_dirtyOnGpu = true;
                  W_dirtyOnCpu = false;
                }

                for (b_i = 0; b_i < 2; b_i++) {
                  V[b_i] = cpu_A->size[b_i];
                }

                b_i = cpu_A->size[0] * cpu_A->size[1];
                cpu_A->size[0] = V[0];
                cpu_A->size[1] = V[1];
                emxEnsureCapacity_real32_T(cpu_A, b_i, &sb_emlrtRTEI);
                na = V[0] * V[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (na + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_A, cpu_A);
                  ec_detrend_kernel36<<<grid, block>>>(na, e_gpu_A);
                  A_dirtyOnGpu = true;
                  A_dirtyOnCpu = false;
                }
              }

              b_i = cpu_D->size[0] * cpu_D->size[1];
              cpu_D->size[0] = m;
              cpu_D->size[1] = m;
              emxEnsureCapacity_creal32_T(cpu_D, b_i, &kb_emlrtRTEI);
              if (!D_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal32_T(cpu_D, &c_gpu_D);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m *
                m), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal32_T(&c_gpu_D, cpu_D);
                }

                ec_detrend_kernel37<<<grid, block>>>(m, c_gpu_D);
                D_dirtyOnGpu = true;
                D_dirtyOnCpu = false;
              }

              for (b_i = 0; b_i < m; b_i++) {
                if (D_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &c_gpu_D);
                }

                if (W_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(cpu_W, &c_gpu_W);
                }

                W_dirtyOnGpu = false;
                cpu_D->data[b_i + cpu_D->size[0] * b_i].re = cpu_W->data[b_i];
                cpu_D->data[b_i + cpu_D->size[0] * b_i].im = 0.0F;
                D_dirtyOnCpu = true;
                D_dirtyOnGpu = false;
              }

              b_i = cpu_V->size[0] * cpu_V->size[1];
              cpu_V->size[0] = cpu_A->size[0];
              cpu_V->size[1] = cpu_A->size[1];
              emxEnsureCapacity_creal32_T(cpu_V, b_i, &tb_emlrtRTEI);
              if (!V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal32_T(cpu_V, &d_gpu_V);
              }

              nx = cpu_A->size[0] * cpu_A->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (A_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_A, cpu_A);
                }

                A_dirtyOnCpu = false;
                if (V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal32_T(&d_gpu_V, cpu_V);
                }

                ec_detrend_kernel38<<<grid, block>>>(e_gpu_A, nx, d_gpu_V);
                V_dirtyOnGpu = true;
                V_dirtyOnCpu = false;
              }
            } else {
              p = (cpu_A->size[0] == cpu_A->size[1]);
              if (p) {
                na = 0;
                exitg2 = false;
                while ((!exitg2) && (na <= cpu_A->size[1] - 1)) {
                  b_i = 0;
                  do {
                    exitg1 = 0;
                    if (b_i <= na) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &e_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (!(cpu_A->data[b_i + cpu_A->size[0] * na] ==
                            -cpu_A->data[na + cpu_A->size[0] * b_i])) {
                        p = false;
                        exitg1 = 1;
                      } else {
                        b_i++;
                      }
                    } else {
                      na++;
                      exitg1 = 2;
                    }
                  } while (exitg1 == 0);

                  if (exitg1 == 1) {
                    exitg2 = true;
                  }
                }
              }

              if (p) {
                nx = cpu_A->size[0] * cpu_A->size[1];
                for (n = 0; n < nx; n++) {
                  if (p) {
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &e_gpu_A);
                    }

                    A_dirtyOnGpu = false;
                    if (std::isinf(cpu_A->data[n]) || std::isnan(cpu_A->data[n]))
                    {
                      p = false;
                    }
                  } else {
                    p = false;
                  }
                }

                if (!p) {
                  for (b_i = 0; b_i < 2; b_i++) {
                    sz[b_i] = static_cast<uint32_T>(cpu_A->size[b_i]);
                  }

                  b_i = cpu_U->size[0] * cpu_U->size[1];
                  cpu_U->size[0] = static_cast<int32_T>(sz[0]);
                  cpu_U->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real32_T(cpu_U, b_i, &pb_emlrtRTEI);
                  if (!U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(cpu_U, &b_gpu_U);
                  }

                  na = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (na + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_U, cpu_U);
                    }

                    ec_detrend_kernel30<<<grid, block>>>(na, b_gpu_U);
                    U_dirtyOnGpu = true;
                    U_dirtyOnCpu = false;
                  }

                  m = static_cast<int32_T>(sz[0]);
                  if (static_cast<int32_T>(sz[0]) > 1) {
                    cpu_npages = 2;
                    if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>
                        (sz[1]) - 1) {
                      vlen = static_cast<int32_T>(sz[0]) - 1;
                    } else {
                      vlen = static_cast<int32_T>(sz[1]);
                    }

                    for (na = 0; na < vlen; na++) {
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(computeEndIdx(static_cast<int64_T>
                           (cpu_npages), static_cast<int64_T>(m), 1L) + 1L),
                         &grid, &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                   cudaMemcpyHostToDevice);
                        if (U_dirtyOnCpu) {
                          gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_U, cpu_U);
                        }

                        ec_detrend_kernel31<<<grid, block>>>(na + 1, gpu_npages,
                          m, b_gpu_U, cpu_U->size[0U]);
                        U_dirtyOnGpu = true;
                        U_dirtyOnCpu = false;
                      }

                      cpu_npages++;
                    }
                  }

                  for (b_i = 0; b_i < 2; b_i++) {
                    sz[b_i] = static_cast<uint32_T>(cpu_A->size[b_i]);
                  }

                  b_i = cpu_A->size[0] * cpu_A->size[1];
                  cpu_A->size[0] = static_cast<int32_T>(sz[0]);
                  cpu_A->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real32_T(cpu_A, b_i, &yb_emlrtRTEI);
                  if (!A_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(cpu_A, &e_gpu_A);
                  }

                  na = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (na + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_A, cpu_A);
                    }

                    ec_detrend_kernel32<<<grid, block>>>(na, e_gpu_A);
                    A_dirtyOnGpu = true;
                    A_dirtyOnCpu = false;
                  }
                } else {
                  ptrdiff_t b_n_t;
                  ptrdiff_t c_info_t;
                  ptrdiff_t e_info_t;
                  m = cpu_A->size[0];
                  b_i = cpu_tau->size[0];
                  cpu_tau->size[0] = cpu_A->size[0] - 1;
                  emxEnsureCapacity_real32_T(cpu_tau, b_i, &mb_emlrtRTEI);
                  if (!tau_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(cpu_tau, &d_gpu_tau);
                  }

                  if (cpu_A->size[0] > 1) {
                    ptrdiff_t b_info_t;
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &e_gpu_A);
                    }

                    b_info_t = LAPACKE_sgehrd(102, (ptrdiff_t)cpu_A->size[0],
                      (ptrdiff_t)1, (ptrdiff_t)cpu_A->size[0], &cpu_A->data[0],
                      (ptrdiff_t)cpu_A->size[0], &cpu_tau->data[0]);
                    tau_dirtyOnCpu = true;
                    A_dirtyOnCpu = true;
                    A_dirtyOnGpu = false;
                    if ((int32_T)b_info_t != 0) {
                      for (b_i = 0; b_i < 2; b_i++) {
                        V[b_i] = cpu_A->size[b_i];
                      }

                      b_i = cpu_A->size[0] * cpu_A->size[1];
                      cpu_A->size[0] = V[0];
                      cpu_A->size[1] = V[1];
                      emxEnsureCapacity_real32_T(cpu_A, b_i, &wb_emlrtRTEI);
                      na = V[0] * V[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_A, cpu_A);
                        ec_detrend_kernel24<<<grid, block>>>(na, e_gpu_A);
                        A_dirtyOnGpu = true;
                        A_dirtyOnCpu = false;
                      }

                      x[0] = cpu_tau->size[0];
                      b_i = cpu_tau->size[0];
                      cpu_tau->size[0] = x[0];
                      emxEnsureCapacity_real32_T(cpu_tau, b_i, &bc_emlrtRTEI);
                      na = x[0] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_tau, cpu_tau);
                        ec_detrend_kernel25<<<grid, block>>>(x[0] - 1, d_gpu_tau);
                        tau_dirtyOnGpu = true;
                        tau_dirtyOnCpu = false;
                      }
                    }
                  }

                  b_i = cpu_U->size[0] * cpu_U->size[1];
                  cpu_U->size[0] = cpu_A->size[0];
                  cpu_U->size[1] = cpu_A->size[1];
                  emxEnsureCapacity_real32_T(cpu_U, b_i, &rb_emlrtRTEI);
                  if (!U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(cpu_U, &b_gpu_U);
                  }

                  nx = cpu_A->size[0] * cpu_A->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (nx + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_A, cpu_A);
                    }

                    if (U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_U, cpu_U);
                    }

                    ec_detrend_kernel26<<<grid, block>>>(e_gpu_A, nx, b_gpu_U);
                    U_dirtyOnGpu = true;
                  }

                  if (U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_U, &b_gpu_U);
                  }

                  if (tau_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_tau, &d_gpu_tau);
                  }

                  tau_dirtyOnGpu = false;
                  c_info_t = LAPACKE_sorghr(102, (ptrdiff_t)m, (ptrdiff_t)1,
                    (ptrdiff_t)m, &cpu_U->data[0], (ptrdiff_t)m, &cpu_tau->data
                    [0]);
                  U_dirtyOnGpu = false;
                  if ((int32_T)c_info_t != 0) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      V[b_i] = cpu_U->size[b_i];
                    }

                    b_i = cpu_U->size[0] * cpu_U->size[1];
                    cpu_U->size[0] = V[0];
                    cpu_U->size[1] = V[1];
                    emxEnsureCapacity_real32_T(cpu_U, b_i, &rb_emlrtRTEI);
                    na = V[0] * V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_U, cpu_U);
                      ec_detrend_kernel27<<<grid, block>>>(na, b_gpu_U);
                      U_dirtyOnGpu = true;
                    }
                  }

                  b_n_t = (ptrdiff_t)cpu_A->size[0];
                  b_i = wr->size[0] * wr->size[1];
                  wr->size[0] = 1;
                  wr->size[1] = cpu_A->size[0];
                  emxEnsureCapacity_real32_T(wr, b_i, &ac_emlrtRTEI);
                  b_i = wi->size[0] * wi->size[1];
                  wi->size[0] = 1;
                  wi->size[1] = cpu_A->size[0];
                  emxEnsureCapacity_real32_T(wi, b_i, &ec_emlrtRTEI);
                  if (A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &e_gpu_A);
                  }

                  if (U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_U, &b_gpu_U);
                  }

                  if (cpu_A->size[0] <= 1) {
                    nx = 1;
                  } else {
                    nx = cpu_A->size[0];
                  }

                  e_info_t = LAPACKE_shseqr(102, 'S', 'V', b_n_t, (ptrdiff_t)1,
                    (ptrdiff_t)cpu_A->size[0], &cpu_A->data[0], b_n_t, &wr->
                    data[0], &wi->data[0], &cpu_U->data[0], (ptrdiff_t)nx);
                  U_dirtyOnCpu = true;
                  U_dirtyOnGpu = false;
                  A_dirtyOnCpu = true;
                  A_dirtyOnGpu = false;
                  if ((int32_T)e_info_t < 0) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      V[b_i] = cpu_A->size[b_i];
                    }

                    b_i = cpu_A->size[0] * cpu_A->size[1];
                    cpu_A->size[0] = V[0];
                    cpu_A->size[1] = V[1];
                    emxEnsureCapacity_real32_T(cpu_A, b_i, &ic_emlrtRTEI);
                    na = V[0] * V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D(static_cast<
                      real_T>(na + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&e_gpu_A, cpu_A);
                      ec_detrend_kernel28<<<grid, block>>>(na, e_gpu_A);
                      A_dirtyOnGpu = true;
                      A_dirtyOnCpu = false;
                    }

                    for (b_i = 0; b_i < 2; b_i++) {
                      V[b_i] = cpu_U->size[b_i];
                    }

                    b_i = cpu_U->size[0] * cpu_U->size[1];
                    cpu_U->size[0] = V[0];
                    cpu_U->size[1] = V[1];
                    emxEnsureCapacity_real32_T(cpu_U, b_i, &oc_emlrtRTEI);
                    na = V[0] * V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(na + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_U, cpu_U);
                      ec_detrend_kernel29<<<grid, block>>>(na, b_gpu_U);
                      U_dirtyOnGpu = true;
                      U_dirtyOnCpu = false;
                    }
                  }
                }

                m = cpu_A->size[0];
                b_i = cpu_D->size[0] * cpu_D->size[1];
                cpu_D->size[0] = cpu_A->size[0];
                cpu_D->size[1] = cpu_A->size[0];
                emxEnsureCapacity_creal32_T(cpu_D, b_i, &gc_emlrtRTEI);
                if (!D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal32_T(cpu_D, &c_gpu_D);
                }

                nx = cpu_A->size[0] * cpu_A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (nx + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal32_T(&c_gpu_D, cpu_D);
                  }

                  ec_detrend_kernel33<<<grid, block>>>(nx, c_gpu_D);
                  D_dirtyOnGpu = true;
                  D_dirtyOnCpu = false;
                }

                b_i = 1;
                do {
                  exitg1 = 0;
                  if (b_i <= m) {
                    if (b_i != m) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &e_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (cpu_A->data[b_i + cpu_A->size[0] * (b_i - 1)] != 0.0F)
                      {
                        d2scaled = std::abs(cpu_A->data[b_i + cpu_A->size[0] *
                                            (b_i - 1)]);
                        if (D_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &c_gpu_D);
                        }

                        cpu_D->data[(b_i + cpu_D->size[0] * (b_i - 1)) - 1].re =
                          0.0F;
                        cpu_D->data[(b_i + cpu_D->size[0] * (b_i - 1)) - 1].im =
                          d2scaled;
                        cpu_D->data[b_i + cpu_D->size[0] * b_i].re = 0.0F;
                        cpu_D->data[b_i + cpu_D->size[0] * b_i].im = -d2scaled;
                        D_dirtyOnCpu = true;
                        D_dirtyOnGpu = false;
                        b_i += 2;
                      } else {
                        b_i++;
                      }
                    } else {
                      b_i++;
                    }
                  } else {
                    exitg1 = 1;
                  }
                } while (exitg1 == 0);

                b_i = cpu_V->size[0] * cpu_V->size[1];
                cpu_V->size[0] = cpu_U->size[0];
                cpu_V->size[1] = cpu_U->size[1];
                emxEnsureCapacity_creal32_T(cpu_V, b_i, &kc_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal32_T(cpu_V, &d_gpu_V);
                }

                na = cpu_U->size[0] * cpu_U->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (na + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (U_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_U, cpu_U);
                  }

                  U_dirtyOnCpu = false;
                  if (V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal32_T(&d_gpu_V, cpu_V);
                  }

                  ec_detrend_kernel34<<<grid, block>>>(b_gpu_U, na, d_gpu_V);
                  V_dirtyOnGpu = true;
                  V_dirtyOnCpu = false;
                }

                na = 1;
                m = cpu_A->size[0];
                do {
                  exitg1 = 0;
                  if (na <= m) {
                    if (na != m) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &e_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (cpu_A->data[na + cpu_A->size[0] * (na - 1)] != 0.0F) {
                        if (cpu_A->data[na + cpu_A->size[0] * (na - 1)] < 0.0F)
                        {
                          cpu_npages = 1;
                        } else {
                          cpu_npages = -1;
                        }

                        for (b_i = 0; b_i < m; b_i++) {
                          if (V_dirtyOnGpu) {
                            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_V, &d_gpu_V);
                          }

                          d2scaled = cpu_V->data[b_i + cpu_V->size[0] * (na - 1)]
                            .re;
                          abnrm = static_cast<real32_T>(cpu_npages) *
                            cpu_V->data[b_i + cpu_V->size[0] * na].re;
                          if (abnrm == 0.0F) {
                            cpu_V->data[b_i + cpu_V->size[0] * (na - 1)].re =
                              d2scaled / 1.41421354F;
                            cpu_V->data[b_i + cpu_V->size[0] * (na - 1)].im =
                              0.0F;
                            V_dirtyOnGpu = false;
                          } else if (d2scaled == 0.0F) {
                            cpu_V->data[b_i + cpu_V->size[0] * (na - 1)].re =
                              0.0F;
                            cpu_V->data[b_i + cpu_V->size[0] * (na - 1)].im =
                              abnrm / 1.41421354F;
                            V_dirtyOnGpu = false;
                          } else {
                            cpu_V->data[b_i + cpu_V->size[0] * (na - 1)].re =
                              d2scaled / 1.41421354F;
                            cpu_V->data[b_i + cpu_V->size[0] * (na - 1)].im =
                              abnrm / 1.41421354F;
                            V_dirtyOnGpu = false;
                          }

                          cpu_V->data[b_i + cpu_V->size[0] * na].re =
                            cpu_V->data[b_i + cpu_V->size[0] * (na - 1)].re;
                          cpu_V->data[b_i + cpu_V->size[0] * na].im =
                            -cpu_V->data[b_i + cpu_V->size[0] * (na - 1)].im;
                          V_dirtyOnCpu = true;
                        }

                        na += 2;
                      } else {
                        na++;
                      }
                    } else {
                      na++;
                    }
                  } else {
                    exitg1 = 1;
                  }
                } while (exitg1 == 0);
              } else {
                ptrdiff_t d_info_t;
                m = cpu_A->size[0];
                n = cpu_A->size[1] - 1;
                b_i = scale->size[0];
                scale->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(scale, b_i, &gb_emlrtRTEI);
                b_i = b_cpu_W->size[0];
                b_cpu_W->size[0] = cpu_A->size[1];
                emxEnsureCapacity_creal32_T(b_cpu_W, b_i, &jb_emlrtRTEI);
                gpuEmxEnsureCapacity_creal32_T(b_cpu_W, &d_gpu_W);
                b_i = cpu_V->size[0] * cpu_V->size[1];
                cpu_V->size[0] = cpu_A->size[1];
                cpu_V->size[1] = cpu_A->size[1];
                emxEnsureCapacity_creal32_T(cpu_V, b_i, &nb_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal32_T(cpu_V, &d_gpu_V);
                }

                b_i = cpu_wreal->size[0];
                cpu_wreal->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(cpu_wreal, b_i, &ob_emlrtRTEI);
                if (!wreal_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_wreal, &b_gpu_wreal);
                }

                b_i = cpu_wimag->size[0];
                cpu_wimag->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(cpu_wimag, b_i, &qb_emlrtRTEI);
                if (!wimag_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_wimag, &b_gpu_wimag);
                }

                b_i = cpu_vright->size[0] * cpu_vright->size[1];
                cpu_vright->size[0] = cpu_A->size[1];
                cpu_vright->size[1] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(cpu_vright, b_i, &ub_emlrtRTEI);
                if (!vright_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_vright, &b_gpu_vright);
                }

                if (A_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &e_gpu_A);
                }

                d_info_t = LAPACKE_sgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)
                  cpu_A->size[1], &cpu_A->data[0], (ptrdiff_t)cpu_A->size[0],
                  &cpu_wreal->data[0], &cpu_wimag->data[0], &d2scaled,
                  (ptrdiff_t)1, &cpu_vright->data[0], (ptrdiff_t)cpu_A->size[1],
                  &ilo_t, &ihi_t, &scale->data[0], &abnrm, &rconde, &rcondv);
                vright_dirtyOnCpu = true;
                wimag_dirtyOnCpu = true;
                wreal_dirtyOnCpu = true;
                A_dirtyOnCpu = true;
                A_dirtyOnGpu = false;
                if ((int32_T)d_info_t < 0) {
                  x[0] = cpu_A->size[1];
                  b_i = b_cpu_W->size[0];
                  b_cpu_W->size[0] = cpu_A->size[1];
                  emxEnsureCapacity_creal32_T(b_cpu_W, b_i, &dc_emlrtRTEI);
                  gpuEmxEnsureCapacity_creal32_T(b_cpu_W, &d_gpu_W);
                  na = x[0] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (na + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    ec_detrend_kernel21<<<grid, block>>>(gpu_fc2, x[0] - 1,
                      d_gpu_W);
                    b_W_dirtyOnGpu = true;
                  }

                  for (b_i = 0; b_i < 2; b_i++) {
                    V[b_i] = cpu_V->size[b_i];
                  }

                  b_i = cpu_V->size[0] * cpu_V->size[1];
                  cpu_V->size[0] = V[0];
                  cpu_V->size[1] = V[1];
                  emxEnsureCapacity_creal32_T(cpu_V, b_i, &hc_emlrtRTEI);
                  if (!V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal32_T(cpu_V, &d_gpu_V);
                  }

                  na = V[0] * V[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (na + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal32_T(&d_gpu_V, cpu_V);
                    }

                    ec_detrend_kernel22<<<grid, block>>>(gpu_fc2, na, d_gpu_V);
                    V_dirtyOnGpu = true;
                    V_dirtyOnCpu = false;
                  }
                } else {
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (n + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_wimag, cpu_wimag);
                    wimag_dirtyOnCpu = false;
                    gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_wreal, cpu_wreal);
                    wreal_dirtyOnCpu = false;
                    ec_detrend_kernel18<<<grid, block>>>(b_gpu_wimag,
                      b_gpu_wreal, n, d_gpu_W);
                    b_W_dirtyOnGpu = true;
                  }

                  b_i = cpu_V->size[0] * cpu_V->size[1];
                  cpu_V->size[0] = cpu_vright->size[0];
                  cpu_V->size[1] = cpu_vright->size[1];
                  emxEnsureCapacity_creal32_T(cpu_V, b_i, &fc_emlrtRTEI);
                  if (!V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal32_T(cpu_V, &d_gpu_V);
                  }

                  na = cpu_vright->size[0] * cpu_vright->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (na + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_vright, cpu_vright);
                    vright_dirtyOnCpu = false;
                    if (V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal32_T(&d_gpu_V, cpu_V);
                    }

                    ec_detrend_kernel19<<<grid, block>>>(b_gpu_vright, na,
                      d_gpu_V);
                    V_dirtyOnGpu = true;
                    V_dirtyOnCpu = false;
                  }

                  for (b_i = 0; b_i < n; b_i++) {
                    cpu_npages = b_i + 2;
                    if ((cpu_wimag->data[b_i] > 0.0F) && (cpu_wimag->data[b_i +
                         1] < 0.0F)) {
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(n + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                   cudaMemcpyHostToDevice);
                        if (V_dirtyOnCpu) {
                          gpuEmxMemcpyCpuToGpu_creal32_T(&d_gpu_V, cpu_V);
                        }

                        ec_detrend_kernel20<<<grid, block>>>(gpu_npages, n,
                          d_gpu_V, cpu_V->size[0U]);
                        V_dirtyOnGpu = true;
                        V_dirtyOnCpu = false;
                      }
                    }
                  }
                }

                b_i = cpu_D->size[0] * cpu_D->size[1];
                cpu_D->size[0] = cpu_A->size[0];
                cpu_D->size[1] = cpu_A->size[0];
                emxEnsureCapacity_creal32_T(cpu_D, b_i, &jc_emlrtRTEI);
                if (!D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal32_T(cpu_D, &c_gpu_D);
                }

                nx = cpu_A->size[0] * cpu_A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (nx + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal32_T(&c_gpu_D, cpu_D);
                  }

                  ec_detrend_kernel23<<<grid, block>>>(nx, c_gpu_D);
                  D_dirtyOnGpu = true;
                  D_dirtyOnCpu = false;
                }

                for (n = 0; n < m; n++) {
                  if (D_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &c_gpu_D);
                  }

                  if (b_W_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal32_T(b_cpu_W, &d_gpu_W);
                  }

                  b_W_dirtyOnGpu = false;
                  cpu_D->data[n + cpu_D->size[0] * n] = b_cpu_W->data[n];
                  D_dirtyOnCpu = true;
                  D_dirtyOnGpu = false;
                }
              }
            }
          }
        }

        // 'ec_detrend:175' V = real(V);
        b_i = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = cpu_V->size[0];
        b_cpu_V->size[1] = cpu_V->size[1];
        emxEnsureCapacity_real32_T(b_cpu_V, b_i, &bb_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_V, &e_gpu_V);
        na = cpu_V->size[0] * cpu_V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (V_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal32_T(&d_gpu_V, cpu_V);
          }

          V_dirtyOnCpu = false;
          ec_detrend_kernel41<<<grid, block>>>(d_gpu_V, na, e_gpu_V);
        }

        // 'ec_detrend:176' D = diag(real(D));
        b_i = cpu_fcnOutput->size[0] * cpu_fcnOutput->size[1];
        cpu_fcnOutput->size[0] = cpu_D->size[0];
        cpu_fcnOutput->size[1] = cpu_D->size[1];
        emxEnsureCapacity_real32_T(cpu_fcnOutput, b_i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_fcnOutput, &b_gpu_fcnOutput);
        na = cpu_D->size[0] * cpu_D->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (D_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal32_T(&c_gpu_D, cpu_D);
          }

          D_dirtyOnCpu = false;
          ec_detrend_kernel42<<<grid, block>>>(c_gpu_D, na, b_gpu_fcnOutput);
          fcnOutput_dirtyOnGpu = true;
        }

        if ((cpu_fcnOutput->size[0] == 1) && (cpu_fcnOutput->size[1] == 1)) {
          b_i = b_cpu_D->size[0];
          b_cpu_D->size[0] = 1;
          emxEnsureCapacity_real32_T(b_cpu_D, b_i, &ib_emlrtRTEI);
          if (!b_D_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_D, &d_gpu_D);
          }

          if (fcnOutput_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fcnOutput, &b_gpu_fcnOutput);
          }

          fcnOutput_dirtyOnGpu = false;
          b_cpu_D->data[0] = cpu_fcnOutput->data[0];
          b_D_dirtyOnCpu = true;
        } else {
          n = cpu_fcnOutput->size[0];
          vlen = cpu_fcnOutput->size[1];
          if (n <= vlen) {
            vlen = n;
          }

          if (cpu_fcnOutput->size[1] > 0) {
            cpu_npages = vlen;
          } else {
            cpu_npages = 0;
          }

          b_i = b_cpu_D->size[0];
          b_cpu_D->size[0] = cpu_npages;
          emxEnsureCapacity_real32_T(b_cpu_D, b_i, &fb_emlrtRTEI);
          if (!b_D_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_D, &d_gpu_D);
          }

          cpu_npages--;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (cpu_npages + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
            if (b_D_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_D, b_cpu_D);
            }

            ec_detrend_kernel43<<<grid, block>>>(b_gpu_fcnOutput, gpu_npages,
              d_gpu_D, cpu_fcnOutput->size[0U]);
            b_D_dirtyOnGpu = true;
            b_D_dirtyOnCpu = false;
          }
        }

        // 'ec_detrend:177' V = V(:,D/max(D)>thrPCA);
        vlen = b_cpu_D->size[0];
        if (b_D_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_D, &d_gpu_D);
        }

        b_D_dirtyOnGpu = false;
        d2scaled = b_cpu_D->data[0];
        for (b_i = 0; b_i <= vlen - 2; b_i++) {
          if (std::isnan(b_cpu_D->data[b_i + 1])) {
            p = false;
          } else if (std::isnan(d2scaled)) {
            p = true;
          } else {
            p = (d2scaled < b_cpu_D->data[b_i + 1]);
          }

          if (p) {
            d2scaled = b_cpu_D->data[b_i + 1];
          }
        }

        n = b_cpu_D->size[0] - 1;
        vlen = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (b_cpu_D->data[b_i] / d2scaled > 1.0E-7F) {
            vlen++;
          }
        }

        b_i = cpu_iv->size[0];
        cpu_iv->size[0] = vlen;
        emxEnsureCapacity_int32_T(cpu_iv, b_i, &vb_emlrtRTEI);
        if (!iv_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv);
        }

        cpu_npages = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (b_cpu_D->data[b_i] / d2scaled > 1.0E-7F) {
            cpu_iv->data[cpu_npages] = b_i;
            iv_dirtyOnCpu = true;
            cpu_npages++;
          }
        }

        vlen = b_cpu_V->size[0];
        b_i = e_cpu_V->size[0] * e_cpu_V->size[1];
        e_cpu_V->size[0] = b_cpu_V->size[0];
        e_cpu_V->size[1] = cpu_iv->size[0];
        emxEnsureCapacity_real32_T(e_cpu_V, b_i, &xb_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(e_cpu_V, &f_gpu_V);
        na = cpu_iv->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen *
          (na + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv, cpu_iv);
          }

          iv_dirtyOnCpu = false;
          ec_detrend_kernel44<<<grid, block>>>(gpu_iv, e_gpu_V, vlen, na,
            f_gpu_V, e_cpu_V->size[0U], b_cpu_V->size[0U]);
        }

        b_i = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = e_cpu_V->size[0];
        b_cpu_V->size[1] = e_cpu_V->size[1];
        emxEnsureCapacity_real32_T(b_cpu_V, b_i, &cc_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_V, &e_gpu_V);
        na = e_cpu_V->size[0] * e_cpu_V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detrend_kernel45<<<grid, block>>>(f_gpu_V, na, e_gpu_V);
        }

        //  discard weak dims
        // 'ec_detrend:178' rr = rr*V;
        vlen = cpu_rr->size[0];
        cpu_npages = cpu_rr->size[1];
        if ((cpu_rr->size[0] == 0) || (cpu_rr->size[1] == 0) || (b_cpu_V->size[0]
             == 0) || (b_cpu_V->size[1] == 0)) {
          cpu_npages = cpu_rr->size[0];
          V[0] = cpu_rr->size[0];
          V[1] = b_cpu_V->size[1];
          b_i = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = cpu_npages;
          cpu_rr->size[1] = b_cpu_V->size[1];
          emxEnsureCapacity_real32_T(cpu_rr, b_i, &nc_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_rr, &b_gpu_rr);
          }

          na = V[0] * V[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_rr, cpu_rr);
            }

            ec_detrend_kernel47<<<grid, block>>>(na, b_gpu_rr);
            rr_dirtyOnGpu = true;
            rr_dirtyOnCpu = false;
          }
        } else {
          b_i = b_cpu_A->size[0] * b_cpu_A->size[1];
          b_cpu_A->size[0] = cpu_rr->size[0];
          b_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(b_cpu_A, b_i, &mc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(b_cpu_A, &h_gpu_A);
          nx = cpu_rr->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_rr, cpu_rr);
            }

            rr_dirtyOnCpu = false;
            ec_detrend_kernel46<<<grid, block>>>(b_gpu_rr, nx, h_gpu_A);
          }

          b_i = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = vlen;
          cpu_rr->size[1] = b_cpu_V->size[1];
          emxEnsureCapacity_real32_T(cpu_rr, b_i, &x_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_rr, &b_gpu_rr);
          }

          d2scaled = 1.0F;
          abnrm = 0.0F;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_rr, cpu_rr);
          }

          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, vlen,
                      b_cpu_V->size[1], cpu_npages, (float *)&d2scaled, (float *)
                      &h_gpu_A.data[0], vlen, (float *)&e_gpu_V.data[0],
                      cpu_npages, (float *)&abnrm, (float *)&b_gpu_rr.data[0],
                      vlen);
          rr_dirtyOnGpu = true;
          rr_dirtyOnCpu = false;
        }

        // 'ec_detrend:179' b = (x'*rr) / (rr'*rr);
        b_i = c_cpu_a->size[0] * c_cpu_a->size[1];
        c_cpu_a->size[0] = 1;
        c_cpu_a->size[1] = cpu_fv4->size[0];
        emxEnsureCapacity_real32_T(c_cpu_a, b_i, &pc_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_cpu_a, &i_gpu_a);
        na = cpu_fv4->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (fv4_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv4, cpu_fv4);
          }

          fv4_dirtyOnCpu = false;
          ec_detrend_kernel48<<<grid, block>>>(gpu_fv4, na, i_gpu_a);
        }

        if ((cpu_fv4->size[0] == 0) || (cpu_rr->size[0] == 0) || (cpu_rr->size[1]
             == 0)) {
          b_i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(cpu_b, b_i, &m_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_b, &d_gpu_b);
          }

          nx = cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_b, cpu_b);
            }

            ec_detrend_kernel49<<<grid, block>>>(nx, d_gpu_b);
            b_dirtyOnCpu = false;
          }
        } else {
          b_i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(cpu_b, b_i, &x_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_b, &d_gpu_b);
          }

          d2scaled = 1.0F;
          abnrm = 0.0F;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_b, cpu_b);
          }

          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                      cpu_rr->size[1], cpu_fv4->size[0], (float *)&d2scaled,
                      (float *)&i_gpu_a.data[0], 1, (float *)&b_gpu_rr.data[0],
                      cpu_fv4->size[0], (float *)&abnrm, (float *)&d_gpu_b.data
                      [0], 1);
          b_dirtyOnCpu = false;
        }

        b_i = d_cpu_a->size[0] * d_cpu_a->size[1];
        d_cpu_a->size[0] = cpu_rr->size[1];
        d_cpu_a->size[1] = cpu_rr->size[0];
        emxEnsureCapacity_real32_T(d_cpu_a, b_i, &qc_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(d_cpu_a, &j_gpu_a);
        nx = cpu_rr->size[0] - 1;
        na = cpu_rr->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((na + 1L)
          * (nx + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          ec_detrend_kernel50<<<grid, block>>>(b_gpu_rr, na, nx, j_gpu_a,
            d_cpu_a->size[0U], cpu_rr->size[0U]);
        }

        if ((d_cpu_a->size[0] == 0) || (d_cpu_a->size[1] == 0) || (cpu_rr->size
             [0] == 0) || (cpu_rr->size[1] == 0)) {
          b_i = c_cpu_A->size[0] * c_cpu_A->size[1];
          c_cpu_A->size[0] = d_cpu_a->size[0];
          c_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(c_cpu_A, b_i, &m_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(c_cpu_A, &f_gpu_A);
          na = d_cpu_a->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel51<<<grid, block>>>(na, f_gpu_A);
          }
        } else {
          b_i = c_cpu_A->size[0] * c_cpu_A->size[1];
          c_cpu_A->size[0] = d_cpu_a->size[0];
          c_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(c_cpu_A, b_i, &x_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(c_cpu_A, &f_gpu_A);
          d2scaled = 1.0F;
          abnrm = 0.0F;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      d_cpu_a->size[0], cpu_rr->size[1], d_cpu_a->size[1],
                      (float *)&d2scaled, (float *)&j_gpu_a.data[0],
                      d_cpu_a->size[0], (float *)&b_gpu_rr.data[0],
                      d_cpu_a->size[1], (float *)&abnrm, (float *)&f_gpu_A.data
                      [0], d_cpu_a->size[0]);
        }

        if ((cpu_b->size[1] == 0) || ((c_cpu_A->size[0] == 0) || (c_cpu_A->size
              [1] == 0))) {
          sz[1] = static_cast<uint32_T>(c_cpu_A->size[0]);
          b_i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = c_cpu_A->size[0];
          emxEnsureCapacity_real32_T(cpu_b, b_i, &tc_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_b, &d_gpu_b);
          }

          na = static_cast<int32_T>(sz[1]) - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_b, cpu_b);
            }

            ec_detrend_kernel66<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
              d_gpu_b);
            b_dirtyOnCpu = false;
          }
        } else if (c_cpu_A->size[0] == c_cpu_A->size[1]) {
          m = c_cpu_A->size[1] - 2;
          b_i = cpu_ipiv_t->size[0];
          cpu_ipiv_t->size[0] = c_cpu_A->size[1];
          emxEnsureCapacity_int32_T(cpu_ipiv_t, b_i, &rc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_ipiv_t, &b_gpu_ipiv_t);
          cusolverDnSgetrf_bufferSize(getCuSolverGlobalHandle(), c_cpu_A->size[1],
            c_cpu_A->size[1], (float *)&f_gpu_A.data[0], c_cpu_A->size[1],
            getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(4);
          cusolverInitWorkspace();
          cusolverDnSgetrf(getCuSolverGlobalHandle(), c_cpu_A->size[1],
                           c_cpu_A->size[1], (float *)&f_gpu_A.data[0],
                           c_cpu_A->size[1], static_cast<real32_T *>
                           (getCuSolverWorkspaceBuff()), &b_gpu_ipiv_t.data[0],
                           b_gpu_info);
          b_i = cpu_ipiv->size[0] * cpu_ipiv->size[1];
          cpu_ipiv->size[0] = 1;
          cpu_ipiv->size[1] = cpu_ipiv_t->size[0];
          emxEnsureCapacity_int32_T(cpu_ipiv, b_i, &uc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_ipiv, &b_gpu_ipiv);
          cudaMemcpy(&cpu_info, b_gpu_info, 4UL, cudaMemcpyDeviceToHost);
          if (cpu_info < 0) {
            for (b_i = 0; b_i < 2; b_i++) {
              V[b_i] = c_cpu_A->size[b_i];
            }

            b_i = c_cpu_A->size[0] * c_cpu_A->size[1];
            c_cpu_A->size[0] = V[0];
            c_cpu_A->size[1] = V[1];
            emxEnsureCapacity_real32_T(c_cpu_A, b_i, &xc_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(c_cpu_A, &f_gpu_A);
            na = V[0] * V[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel64<<<grid, block>>>(na, f_gpu_A);
            }

            cpu_npages = cpu_ipiv->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              ec_detrend_kernel65<<<grid, block>>>(gpu_npages, b_gpu_ipiv);
              ipiv_dirtyOnGpu = true;
            }
          } else {
            cpu_npages = cpu_ipiv_t->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              ec_detrend_kernel63<<<grid, block>>>(b_gpu_ipiv_t, gpu_npages,
                b_gpu_ipiv);
              ipiv_dirtyOnGpu = true;
            }
          }

          d2scaled = 1.0F;
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_b, cpu_b);
          }

          cublasStrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N, CUBLAS_DIAG_NON_UNIT,
                      1, m + 2, (float *)&d2scaled, (float *)&f_gpu_A.data[0], m
                      + 2, (float *)&d_gpu_b.data[0], 1);
          cublasStrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                      m + 2, (float *)&d2scaled, (float *)&f_gpu_A.data[0], m +
                      2, (float *)&d_gpu_b.data[0], 1);
          p = true;
          b_dirtyOnCpu = false;
          for (na = 0; na <= m; na++) {
            if (ipiv_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_ipiv, &b_gpu_ipiv);
            }

            ipiv_dirtyOnGpu = false;
            if (cpu_ipiv->data[m - na] != (m - na) + 1) {
              if (p) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, &d_gpu_b);
              }

              d2scaled = cpu_b->data[m - na];
              cpu_b->data[m - na] = cpu_b->data[cpu_ipiv->data[m - na] - 1];
              cpu_b->data[cpu_ipiv->data[m - na] - 1] = d2scaled;
              b_dirtyOnCpu = true;
              p = false;
            }
          }
        } else {
          ptrdiff_t k_info_t;
          boolean_T c_A_dirtyOnCpu;
          b_i = e_cpu_A->size[0] * e_cpu_A->size[1];
          e_cpu_A->size[0] = c_cpu_A->size[1];
          e_cpu_A->size[1] = c_cpu_A->size[0];
          emxEnsureCapacity_real32_T(e_cpu_A, b_i, &sc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(e_cpu_A, &g_gpu_A);
          nx = c_cpu_A->size[0] - 1;
          na = c_cpu_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((na +
            1L) * (nx + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel52<<<grid, block>>>(f_gpu_A, na, nx, g_gpu_A,
              e_cpu_A->size[0U], c_cpu_A->size[0U]);
            c_A_dirtyOnGpu = true;
          }

          b_i = cpu_B->size[0];
          cpu_B->size[0] = cpu_b->size[1];
          emxEnsureCapacity_real32_T(cpu_B, b_i, &vc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_B, &b_gpu_B);
          na = cpu_b->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_b, cpu_b);
            }

            b_dirtyOnCpu = false;
            ec_detrend_kernel53<<<grid, block>>>(d_gpu_b, na, b_gpu_B);
          }

          m = e_cpu_A->size[0];
          na = e_cpu_A->size[1] - 1;
          b_i = cpu_jpvt->size[0] * cpu_jpvt->size[1];
          cpu_jpvt->size[0] = 1;
          cpu_jpvt->size[1] = e_cpu_A->size[1];
          emxEnsureCapacity_int32_T(cpu_jpvt, b_i, &yc_emlrtRTEI);
          if (!jpvt_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &b_gpu_jpvt);
          }

          nx = e_cpu_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, cpu_jpvt);
            }

            ec_detrend_kernel54<<<grid, block>>>(nx, b_gpu_jpvt);
            jpvt_dirtyOnGpu = true;
            jpvt_dirtyOnCpu = false;
          }

          n = e_cpu_A->size[0];
          nx = e_cpu_A->size[1];
          if (n <= nx) {
            nx = n;
          }

          b_i = b_cpu_tau->size[0];
          b_cpu_tau->size[0] = nx;
          emxEnsureCapacity_real32_T(b_cpu_tau, b_i, &ad_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(b_cpu_tau, &c_gpu_tau);
          b_i = jpvt_t->size[0];
          jpvt_t->size[0] = e_cpu_A->size[1];
          emxEnsureCapacity_ptrdiff_t(jpvt_t, b_i, &bd_emlrtRTEI);
          for (b_i = 0; b_i < e_cpu_A->size[1]; b_i++) {
            jpvt_t->data[b_i] = (ptrdiff_t)0;
          }

          if (c_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_A, &g_gpu_A);
          }

          if (b_tau_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_tau, &c_gpu_tau);
          }

          k_info_t = LAPACKE_sgeqp3(102, (ptrdiff_t)e_cpu_A->size[0], (ptrdiff_t)
            e_cpu_A->size[1], &e_cpu_A->data[0], (ptrdiff_t)e_cpu_A->size[0],
            &jpvt_t->data[0], &b_cpu_tau->data[0]);
          p = true;
          b_tau_dirtyOnGpu = false;
          c_A_dirtyOnCpu = true;
          c_A_dirtyOnGpu = false;
          if ((int32_T)k_info_t != 0) {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m *
              (na + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real32_T(&g_gpu_A, e_cpu_A);
              ec_detrend_kernel55<<<grid, block>>>(m, na, g_gpu_A, e_cpu_A->
                size[0U]);
              c_A_dirtyOnGpu = true;
              c_A_dirtyOnCpu = false;
            }

            n = e_cpu_A->size[0];
            vlen = e_cpu_A->size[1];
            if (n <= vlen) {
              vlen = n;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen),
              &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_tau, b_cpu_tau);
              ec_detrend_kernel56<<<grid, block>>>(vlen, c_gpu_tau);
              b_tau_dirtyOnGpu = true;
              p = false;
            }

            cpu_npages = vlen + 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (computeEndIdx(static_cast<int64_T>(cpu_npages),
                             static_cast<int64_T>(nx), 1L) + 1L), &grid, &block,
              1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              if (p) {
                gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_tau, b_cpu_tau);
              }

              ec_detrend_kernel57<<<grid, block>>>(gpu_npages, nx, c_gpu_tau);
              b_tau_dirtyOnGpu = true;
              p = false;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, cpu_jpvt);
              }

              ec_detrend_kernel58<<<grid, block>>>(na, b_gpu_jpvt);
              jpvt_dirtyOnGpu = true;
              jpvt_dirtyOnCpu = false;
            }
          } else {
            for (n = 0; n <= na; n++) {
              if (jpvt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &b_gpu_jpvt);
              }

              cpu_jpvt->data[n] = (int32_T)jpvt_t->data[n];
              jpvt_dirtyOnCpu = true;
              jpvt_dirtyOnGpu = false;
            }
          }

          nx = -1;
          if (e_cpu_A->size[0] < e_cpu_A->size[1]) {
            vlen = e_cpu_A->size[0];
            cpu_npages = e_cpu_A->size[1];
          } else {
            vlen = e_cpu_A->size[1];
            cpu_npages = e_cpu_A->size[0];
          }

          if (c_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_A, &g_gpu_A);
          }

          c_A_dirtyOnGpu = false;
          d2scaled = std::fmin(0.000345266977F, 1.1920929E-6F *
                               static_cast<real32_T>(cpu_npages)) * std::abs
            (e_cpu_A->data[0]);
          while ((nx + 1 < vlen) && (!(std::abs(e_cpu_A->data[(nx +
                     e_cpu_A->size[0] * (nx + 1)) + 1]) <= d2scaled))) {
            nx++;
          }

          cpu_npages = e_cpu_A->size[1];
          b_i = cpu_Y->size[0];
          cpu_Y->size[0] = e_cpu_A->size[1];
          emxEnsureCapacity_real32_T(cpu_Y, b_i, &ed_emlrtRTEI);
          if (!Y_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_Y, &b_gpu_Y);
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (cpu_npages), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_Y, cpu_Y);
            }

            ec_detrend_kernel59<<<grid, block>>>(gpu_npages, b_gpu_Y);
            Y_dirtyOnGpu = true;
            Y_dirtyOnCpu = false;
          }

          cpu_npages = 0;
          n = e_cpu_A->size[0];
          vlen = e_cpu_A->size[1];
          if (n <= vlen) {
            vlen = n;
          }

          if (c_A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&g_gpu_A, e_cpu_A);
          }

          if (p) {
            gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_tau, b_cpu_tau);
          }

          cusolverDnSormqr_bufferSize(getCuSolverGlobalHandle(),
            CUBLAS_SIDE_LEFT, CUBLAS_OP_T, cpu_B->size[0], 1, vlen, (float *)
            &g_gpu_A.data[0], e_cpu_A->size[0], (float *)&c_gpu_tau.data[0],
            (float *)&b_gpu_B.data[0], cpu_B->size[0], getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(4);
          cusolverInitWorkspace();
          cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
          cusolverDnSormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                           CUBLAS_OP_T, cpu_B->size[0], 1, vlen, (float *)
                           &g_gpu_A.data[0], e_cpu_A->size[0], (float *)
                           &c_gpu_tau.data[0], (float *)&b_gpu_B.data[0],
                           cpu_B->size[0], static_cast<real32_T *>
                           (getCuSolverWorkspaceBuff()),
                           *getCuSolverWorkspaceReq(), gpu_npages);
          cudaMemcpy(&cpu_npages, gpu_npages, 4UL, cudaMemcpyDeviceToHost);
          if (cpu_npages < 0) {
            x[0] = cpu_B->size[0];
            b_i = cpu_B->size[0];
            cpu_B->size[0] = x[0];
            emxEnsureCapacity_real32_T(cpu_B, b_i, &gd_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(cpu_B, &b_gpu_B);
            na = x[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel60<<<grid, block>>>(x[0] - 1, b_gpu_B);
            }
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, cpu_jpvt);
            }

            jpvt_dirtyOnCpu = false;
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_Y, cpu_Y);
            }

            ec_detrend_kernel61<<<grid, block>>>(b_gpu_B, b_gpu_jpvt, nx,
              b_gpu_Y);
            Y_dirtyOnGpu = true;
            Y_dirtyOnCpu = false;
          }

          for (na = 0; na <= nx; na++) {
            if (Y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_Y, &b_gpu_Y);
            }

            if (jpvt_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &b_gpu_jpvt);
            }

            jpvt_dirtyOnGpu = false;
            cpu_Y->data[cpu_jpvt->data[nx - na] - 1] /= e_cpu_A->data[(nx - na)
              + e_cpu_A->size[0] * (nx - na)];
            Y_dirtyOnCpu = true;
            Y_dirtyOnGpu = false;
            cpu_npages = nx - na;
            for (b_i = 0; b_i < cpu_npages; b_i++) {
              cpu_Y->data[cpu_jpvt->data[b_i] - 1] -= cpu_Y->data[cpu_jpvt->
                data[nx - na] - 1] * e_cpu_A->data[b_i + e_cpu_A->size[0] * (nx
                - na)];
            }
          }

          b_i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_Y->size[0];
          emxEnsureCapacity_real32_T(cpu_b, b_i, &tc_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_b, &d_gpu_b);
          }

          na = cpu_Y->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_Y, cpu_Y);
            }

            Y_dirtyOnCpu = false;
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_b, cpu_b);
            }

            ec_detrend_kernel62<<<grid, block>>>(b_gpu_Y, na, d_gpu_b);
            b_dirtyOnCpu = false;
          }
        }

        // 'ec_detrend:180' z = r*(V*b') + mn;
        b_i = b_cpu_b->size[0];
        b_cpu_b->size[0] = cpu_b->size[1];
        emxEnsureCapacity_real32_T(b_cpu_b, b_i, &wc_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_b, &e_gpu_b);
        na = cpu_b->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_b, cpu_b);
          }

          b_dirtyOnCpu = false;
          ec_detrend_kernel67<<<grid, block>>>(d_gpu_b, na, e_gpu_b);
        }

        if ((b_cpu_V->size[0] == 0) || (b_cpu_V->size[1] == 0) || (b_cpu_b->
             size[0] == 0)) {
          b_i = g_cpu_c->size[0];
          g_cpu_c->size[0] = b_cpu_V->size[0];
          emxEnsureCapacity_real32_T(g_cpu_c, b_i, &m_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(g_cpu_c, &l_gpu_c);
          na = b_cpu_V->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel68<<<grid, block>>>(na, l_gpu_c);
          }
        } else {
          b_i = g_cpu_c->size[0];
          g_cpu_c->size[0] = b_cpu_V->size[0];
          emxEnsureCapacity_real32_T(g_cpu_c, b_i, &x_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(g_cpu_c, &l_gpu_c);
          d2scaled = 1.0F;
          abnrm = 0.0F;
          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      b_cpu_V->size[0], 1, b_cpu_V->size[1], (float *)&d2scaled,
                      (float *)&e_gpu_V.data[0], b_cpu_V->size[0], (float *)
                      &e_gpu_b.data[0], b_cpu_V->size[1], (float *)&abnrm,
                      (float *)&l_gpu_c.data[0], b_cpu_V->size[0]);
        }

        if ((cpu_fv6->size[0] == 0) || (cpu_fv6->size[1] == 0) || (g_cpu_c->
             size[0] == 0)) {
          b_i = cpu_fv8->size[0];
          cpu_fv8->size[0] = cpu_fv6->size[0];
          emxEnsureCapacity_real32_T(cpu_fv8, b_i, &m_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_fv8, &gpu_fv8);
          na = cpu_fv6->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel69<<<grid, block>>>(na, gpu_fv8);
            fv8_dirtyOnGpu = true;
          }
        } else {
          b_i = cpu_fv8->size[0];
          cpu_fv8->size[0] = cpu_fv6->size[0];
          emxEnsureCapacity_real32_T(cpu_fv8, b_i, &x_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_fv8, &gpu_fv8);
          d2scaled = 1.0F;
          abnrm = 0.0F;
          if (fv6_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv6, cpu_fv6);
          }

          fv6_dirtyOnCpu = false;
          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      cpu_fv6->size[0], 1, cpu_fv6->size[1], (float *)&d2scaled,
                      (float *)&gpu_fv6.data[0], cpu_fv6->size[0], (float *)
                      &l_gpu_c.data[0], cpu_fv6->size[1], (float *)&abnrm,
                      (float *)&gpu_fv8.data[0], cpu_fv6->size[0]);
          fv8_dirtyOnGpu = true;
        }

        if (c_cpu_x->size[0] == 1) {
          nx = i1;
        } else {
          nx = c_cpu_x->size[0];
        }

        if ((c_cpu_x->size[0] == i1) && (cpu_fv8->size[0] == nx)) {
          b_i = b_cpu_z->size[0];
          b_cpu_z->size[0] = cpu_fv8->size[0];
          emxEnsureCapacity_real32_T(b_cpu_z, b_i, &cd_emlrtRTEI);
          if (!z_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_z, &b_gpu_z);
          }

          na = cpu_fv8->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_z, b_cpu_z);
            }

            ec_detrend_kernel70<<<grid, block>>>(out, c_gpu_x, b_gpu_x, gpu_fv8,
              na, b_gpu_z);
            b_z_dirtyOnGpu = true;
            z_dirtyOnCpu = false;
          }
        } else {
          if (b_z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_z, &b_gpu_z);
          }

          if (fv8_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv8, &gpu_fv8);
          }

          fv8_dirtyOnGpu = false;
          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_x, &b_gpu_x);
          }

          c_x_dirtyOnGpu = false;
          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_x, &c_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          binary_expand_op(b_cpu_z, cpu_fv8, c_cpu_x, b_cpu_x, i1, out);
          z_dirtyOnCpu = true;
          b_z_dirtyOnGpu = false;
        }

        b_i = cpu_z->size[0] * cpu_z->size[1];
        cpu_z->size[0] = b_cpu_z->size[0];
        cpu_z->size[1] = 1;
        emxEnsureCapacity_real32_T(cpu_z, b_i, &dd_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_z, &c_gpu_z);
        na = b_cpu_z->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (z_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_z, b_cpu_z);
          }

          z_dirtyOnCpu = false;
          ec_detrend_kernel71<<<grid, block>>>(b_gpu_z, na, c_gpu_z);
          z_dirtyOnGpu = true;
        }

        //  Find outliers
        // 'ec_detrend:88' d = (x-z).*w;
        if (i1 == 1) {
          nx = b_cpu_z->size[0];
        } else {
          nx = i1;
        }

        if ((i1 == b_cpu_z->size[0]) && (nx == b_cpu_w->size[0])) {
          b_i = h_cpu_c->size[0] * h_cpu_c->size[1];
          h_cpu_c->size[0] = i1;
          h_cpu_c->size[1] = 1;
          emxEnsureCapacity_real32_T(h_cpu_c, b_i, &m_emlrtRTEI);
          if (!g_c_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(h_cpu_c, &m_gpu_c);
          }

          na = i1 - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_z, b_cpu_z);
            }

            z_dirtyOnCpu = false;
            if (g_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&m_gpu_c, h_cpu_c);
            }

            ec_detrend_kernel72<<<grid, block>>>(b_gpu_w, b_gpu_z, c_gpu_x, i1 -
              1, m_gpu_c);
            g_c_dirtyOnGpu = true;
            g_c_dirtyOnCpu = false;
          }
        } else {
          if (g_c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(h_cpu_c, &m_gpu_c);
          }

          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_x, &c_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          if (b_z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_z, &b_gpu_z);
          }

          b_z_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(h_cpu_c, b_cpu_x, i1, b_cpu_z, b_cpu_w);
          g_c_dirtyOnCpu = true;
          g_c_dirtyOnGpu = false;
        }

        b_i = cpu_x->size[0];
        if (b_i == 1) {
          nx = b_cpu_z->size[0];
        } else {
          nx = b_i;
        }

        if ((b_i == b_cpu_z->size[0]) && (nx == b_cpu_w->size[0])) {
          cpu_npages = cpu_d->size[0] * cpu_d->size[1];
          cpu_d->size[0] = b_i;
          cpu_d->size[1] = 1;
          emxEnsureCapacity_real32_T(cpu_d, cpu_npages, &fd_emlrtRTEI);
          if (!d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_d, &c_gpu_d);
          }

          na = b_i - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_z, b_cpu_z);
            }

            z_dirtyOnCpu = false;
            if (d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_d, cpu_d);
            }

            ec_detrend_kernel73<<<grid, block>>>(b_gpu_w, b_gpu_z, b_gpu_x, b_i
              - 1, c_gpu_d);
            d_dirtyOnGpu = true;
            d_dirtyOnCpu = false;
          }
        } else {
          if (d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_d, &c_gpu_d);
          }

          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_x, &b_gpu_x);
          }

          c_x_dirtyOnGpu = false;
          if (x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_x, &gpu_x);
          }

          x_dirtyOnGpu = false;
          if (b_z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_z, &b_gpu_z);
          }

          b_z_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(cpu_d, c_cpu_x, cpu_x, b_cpu_z, b_cpu_w);
          d_dirtyOnCpu = true;
          d_dirtyOnGpu = false;
        }

        // 'ec_detrend:89' thrItr = thr*std(d);
        m = h_cpu_c->size[0];
        if (m == 0) {
          y_data[0] = rtNaNF;
        } else if (m == 1) {
          if (d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_d, &c_gpu_d);
          }

          d_dirtyOnGpu = false;
          d2scaled = cpu_d->data[0];
          if ((!std::isinf(d2scaled)) && (!std::isnan(d2scaled))) {
            y_data[0] = 0.0F;
          } else {
            y_data[0] = rtNaNF;
          }
        } else {
          if (cpu_d->size[0] == 0) {
            d2scaled = 0.0F;
          } else {
            if (d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_d, &c_gpu_d);
            }

            d_dirtyOnGpu = false;
            d2scaled = cpu_d->data[0];
            for (na = 0; na <= m - 2; na++) {
              d2scaled += cpu_d->data[na + 1];
            }
          }

          d2scaled /= static_cast<real32_T>(m);
          b_i = cpu_absdiff->size[0];
          cpu_absdiff->size[0] = cpu_d->size[0];
          emxEnsureCapacity_real32_T(cpu_absdiff, b_i, &id_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_absdiff, &c_gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (g_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&m_gpu_c, h_cpu_c);
            }

            g_c_dirtyOnCpu = false;
            ec_detrend_kernel74<<<grid, block>>>(d2scaled, m_gpu_c, m,
              c_gpu_absdiff);
          }

          cublasSnrm2(getCublasGlobalHandle(), m, (float *)&c_gpu_absdiff.data[0],
                      1, (float *)&d2scaled);
          y_data[0] = d2scaled / std::sqrt(static_cast<real32_T>(m - 1));
        }

        // 'ec_detrend:90' w(abs(d)>thrItr) = 0;
        nx = h_cpu_c->size[0];
        b_i = c_cpu_y->size[0] * c_cpu_y->size[1];
        c_cpu_y->size[0] = cpu_d->size[0];
        c_cpu_y->size[1] = 1;
        emxEnsureCapacity_real32_T(c_cpu_y, b_i, &hd_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_cpu_y, &d_gpu_y);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_d, cpu_d);
          }

          d_dirtyOnCpu = false;
          ec_detrend_kernel75<<<grid, block>>>(c_gpu_d, nx, d_gpu_y);
        }

        b_i = c_cpu_r->size[0] * c_cpu_r->size[1];
        c_cpu_r->size[0] = c_cpu_y->size[0];
        c_cpu_r->size[1] = 1;
        emxEnsureCapacity_boolean_T(c_cpu_r, b_i, &jd_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(c_cpu_r, &d_gpu_r);
        na = c_cpu_y->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detrend_kernel76<<<grid, block>>>(y_data[0], thr, d_gpu_y, na,
            d_gpu_r);
        }

        n = c_cpu_r->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detrend_kernel77<<<grid, block>>>(d_gpu_r, n, b_gpu_w);
          b_w_dirtyOnGpu = true;
        }

        //  update weights
      }

      // 'ec_detrend:92' x = x-z;
      b_i = cpu_x->size[0];
      if (b_i == cpu_z->size[0]) {
        cpu_npages = d_cpu_x->size[0] * d_cpu_x->size[1];
        d_cpu_x->size[0] = b_i;
        d_cpu_x->size[1] = 1;
        emxEnsureCapacity_real32_T(d_cpu_x, cpu_npages, &l_emlrtRTEI);
        if (!b_x_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real32_T(d_cpu_x, &d_gpu_x);
        }

        na = b_i - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
          }

          x_dirtyOnCpu = false;
          if (b_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_x, d_cpu_x);
          }

          ec_detrend_kernel78<<<grid, block>>>(c_gpu_z, ch, gpu_x, b_i - 1,
            d_gpu_x, cpu_x->size[0U]);
          d_x_dirtyOnGpu = true;
          b_x_dirtyOnCpu = false;
        }
      } else {
        if (d_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_x, &d_gpu_x);
        }

        if (x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_x, &gpu_x);
        }

        x_dirtyOnGpu = false;
        if (z_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_z, &c_gpu_z);
        }

        z_dirtyOnGpu = false;
        b_binary_expand_op(d_cpu_x, cpu_x, ch, cpu_z);
        b_x_dirtyOnCpu = true;
        d_x_dirtyOnGpu = false;
      }
    }

    x[0] = cpu_x->size[0];
    na = x[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (b_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_x, d_cpu_x);
      }

      b_x_dirtyOnCpu = false;
      if (x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
      }

      ec_detrend_kernel273<<<grid, block>>>(d_gpu_x, ch, x[0] - 1, gpu_x,
        cpu_x->size[0U]);
      x_dirtyOnGpu = true;
      x_dirtyOnCpu = false;
    }

    na = b_cpu_w->size[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (w_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_w, cpu_w);
      }

      ec_detrend_kernel274<<<grid, block>>>(b_gpu_w, ch, na, gpu_w, cpu_w->size
        [0U]);
      w_dirtyOnGpu = true;
      w_dirtyOnCpu = false;
    }
  }

  emxFree_real32_T(&b_cpu_trend);
  emxFree_real32_T(&e_cpu_x);
  emxFree_real32_T(&j_cpu_a);
  emxFree_real32_T(&f_cpu_V);
  emxFree_real32_T(&d_cpu_r);
  emxFree_real32_T(&e_cpu_V);
  emxFree_boolean_T(&cpu_r1);
  emxFree_boolean_T(&c_cpu_r);
  emxFree_real32_T(&c_cpu_absdiff);
  emxFree_real32_T(&d_cpu_y);
  emxFree_real32_T(&c_cpu_d);
  emxFree_real32_T(&m_cpu_c);
  emxFree_real32_T(&l_cpu_c);
  emxFree_real32_T(&cpu_fv13);
  emxFree_real32_T(&k_cpu_c);
  emxFree_real32_T(&cpu_fv12);
  emxFree_int32_T(&cpu_iv8);
  emxFree_real32_T(&l_cpu_vec);
  emxFree_real32_T(&cpu_fv11);
  emxFree_real32_T(&i_cpu_a);
  emxFree_real32_T(&cpu_fv10);
  emxFree_real32_T(&k_cpu_vec);
  emxFree_real32_T(&j_cpu_vec);
  emxFree_int32_T(&cpu_iv7);
  emxFree_real32_T(&i_cpu_vec);
  emxFree_real32_T(&h_cpu_a);
  emxFree_real32_T(&h_cpu_vec);
  emxFree_int32_T(&cpu_iv6);
  emxFree_real32_T(&g_cpu_vec);
  emxFree_real32_T(&f_cpu_vec);
  emxFree_real32_T(&e_cpu_b);
  emxFree_real32_T(&e_cpu_vec);
  emxFree_real32_T(&d_cpu_vec);
  emxFree_real32_T(&c_cpu_vec);
  emxFree_real32_T(&cpu_yy);
  emxFree_real32_T(&b_cpu_absdiff);
  emxFree_real32_T(&b_cpu_d);
  emxFree_real32_T(&j_cpu_c);
  emxFree_real32_T(&c_cpu_z);
  emxFree_real32_T(&cpu_fv9);
  emxFree_ptrdiff_t(&b_jpvt_t);
  emxFree_real32_T(&d_cpu_tau);
  emxFree_int32_T(&b_cpu_ipiv_t);
  emxFree_int32_T(&b_cpu_jpvt);
  emxFree_real32_T(&d_cpu_b);
  emxFree_real32_T(&i_cpu_c);
  emxFree_int32_T(&b_cpu_ipiv);
  emxFree_real32_T(&b_cpu_B);
  emxFree_real32_T(&h_cpu_A);
  emxFree_real32_T(&b_cpu_Y);
  emxFree_real32_T(&b_wi);
  emxFree_real32_T(&b_wr);
  emxFree_real32_T(&b_cpu_vright);
  emxFree_real32_T(&g_cpu_a);
  emxFree_real32_T(&g_cpu_A);
  emxFree_real32_T(&b_cpu_wimag);
  emxFree_real32_T(&c_cpu_tau);
  emxFree_real32_T(&b_cpu_wreal);
  emxFree_creal32_T(&d_cpu_W);
  emxFree_real32_T(&f_cpu_a);
  emxFree_real32_T(&b_cpu_U);
  emxFree_real32_T(&c_cpu_b);
  emxFree_real32_T(&cpu_absdiff);
  emxFree_real32_T(&b_scale);
  emxFree_real32_T(&f_cpu_A);
  emxFree_real32_T(&c_cpu_y);
  emxFree_real32_T(&c_cpu_W);
  emxFree_int32_T(&cpu_iv2);
  emxFree_real32_T(&cpu_d);
  emxFree_real32_T(&h_cpu_c);
  emxFree_real32_T(&b_cpu_z);
  emxFree_real32_T(&d_cpu_D);
  emxFree_real32_T(&cpu_fv8);
  emxFree_real32_T(&b_cpu_fcnOutput);
  emxFree_real32_T(&d_cpu_V);
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_creal32_T(&c_cpu_D);
  emxFree_real32_T(&b_cpu_tau);
  emxFree_creal32_T(&c_cpu_V);
  emxFree_int32_T(&cpu_ipiv_t);
  emxFree_int32_T(&cpu_jpvt);
  emxFree_real32_T(&b_cpu_b);
  emxFree_real32_T(&g_cpu_c);
  emxFree_int32_T(&cpu_ipiv);
  emxFree_real32_T(&cpu_B);
  emxFree_real32_T(&e_cpu_A);
  emxFree_real32_T(&cpu_Y);
  emxFree_real32_T(&wi);
  emxFree_real32_T(&e_cpu_a);
  emxFree_real32_T(&wr);
  emxFree_real32_T(&d_cpu_A);
  emxFree_real32_T(&b_cpu_rr);
  emxFree_real32_T(&cpu_vright);
  emxFree_real32_T(&d_cpu_a);
  emxFree_real32_T(&c_cpu_A);
  emxFree_real32_T(&cpu_wimag);
  emxFree_real32_T(&cpu_tau);
  emxFree_real32_T(&cpu_wreal);
  emxFree_creal32_T(&b_cpu_W);
  emxFree_real32_T(&c_cpu_a);
  emxFree_real32_T(&cpu_U);
  emxFree_real32_T(&cpu_b);
  emxFree_real32_T(&b_cpu_y);
  emxFree_real32_T(&scale);
  emxFree_real32_T(&f_cpu_c);
  emxFree_real32_T(&b_cpu_A);
  emxFree_real32_T(&cpu_fv7);
  emxFree_real32_T(&cpu_W);
  emxFree_int32_T(&cpu_iv);
  emxFree_real32_T(&e_cpu_c);
  emxFree_real32_T(&b_cpu_D);
  emxFree_real32_T(&cpu_fcnOutput);
  emxFree_real32_T(&b_cpu_V);
  emxFree_creal32_T(&cpu_D);
  emxFree_creal32_T(&cpu_V);
  emxFree_real32_T(&d_cpu_c);
  emxFree_real32_T(&b_cpu_a);
  emxFree_real32_T(&cpu_A);
  emxFree_real32_T(&cpu_rr);
  emxFree_real32_T(&cpu_fv6);
  emxFree_real32_T(&cpu_fv5);
  emxFree_real32_T(&cpu_y);
  emxFree_real32_T(&b_cpu_lin);
  emxFree_real32_T(&c_cpu_c);
  emxFree_real32_T(&b_cpu_r);
  emxFree_real32_T(&cpu_fv4);
  emxFree_real32_T(&b_cpu_c);
  emxFree_real32_T(&cpu_fv3);
  emxFree_real32_T(&cpu_fv2);
  emxFree_real32_T(&b_cpu_vec);
  emxFree_real32_T(&cpu_vec);
  emxFree_real32_T(&cpu_c);
  emxFree_real32_T(&cpu_minval);
  emxFree_real32_T(&cpu_fv1);
  emxFree_real32_T(&cpu_z);
  emxFree_real32_T(&cpu_fv);
  emxFree_real32_T(&cpu_lin);
  emxFree_real32_T(&cpu_r);
  emxFree_real32_T(&cpu_a);
  emxFree_real32_T(&cpu_trend);
  emxFree_real32_T(&d_cpu_x);
  emxFree_real32_T(&b_cpu_w);
  emxFree_real32_T(&c_cpu_x);
  emxFree_real32_T(&b_cpu_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_x, &gpu_x);
  }

  if (w_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_w, &gpu_w);
  }

  gpuEmxFree_real32_T(&gpu_x);
  gpuEmxFree_real32_T(&gpu_w);
  mwCudaFree(gpu_fc2);
  mwCudaFree(gpu_fc);
  gpuEmxFree_real32_T(&c_gpu_x);
  gpuEmxFree_real32_T(&b_gpu_x);
  gpuEmxFree_real32_T(&b_gpu_w);
  gpuEmxFree_real32_T(&d_gpu_x);
  gpuEmxFree_real32_T(&gpu_trend);
  gpuEmxFree_real32_T(&gpu_a);
  gpuEmxFree_real32_T(&c_gpu_r);
  gpuEmxFree_real32_T(&b_gpu_lin);
  gpuEmxFree_real32_T(&gpu_fv);
  gpuEmxFree_real32_T(&c_gpu_z);
  gpuEmxFree_real32_T(&gpu_fv1);
  gpuEmxFree_real32_T(&gpu_minval);
  gpuEmxFree_real32_T(&i_gpu_c);
  gpuEmxFree_real32_T(&gpu_vec);
  gpuEmxFree_real32_T(&b_gpu_vec);
  gpuEmxFree_real32_T(&gpu_fv2);
  gpuEmxFree_real32_T(&gpu_fv3);
  gpuEmxFree_real32_T(&j_gpu_c);
  gpuEmxFree_real32_T(&gpu_fv4);
  gpuEmxFree_real32_T(&gpu_r);
  gpuEmxFree_real32_T(&k_gpu_c);
  gpuEmxFree_real32_T(&gpu_lin);
  gpuEmxFree_real32_T(&c_gpu_y);
  gpuEmxFree_real32_T(&gpu_fv5);
  gpuEmxFree_real32_T(&gpu_fv6);
  gpuEmxFree_real32_T(&b_gpu_rr);
  gpuEmxFree_real32_T(&e_gpu_A);
  gpuEmxFree_real32_T(&h_gpu_a);
  gpuEmxFree_real32_T(&gpu_c);
  gpuEmxFree_creal32_T(&d_gpu_V);
  gpuEmxFree_creal32_T(&c_gpu_D);
  gpuEmxFree_real32_T(&e_gpu_V);
  gpuEmxFree_real32_T(&b_gpu_fcnOutput);
  gpuEmxFree_real32_T(&d_gpu_D);
  gpuEmxFree_real32_T(&b_gpu_c);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_real32_T(&c_gpu_W);
  gpuEmxFree_real32_T(&gpu_fv7);
  gpuEmxFree_real32_T(&h_gpu_A);
  gpuEmxFree_real32_T(&c_gpu_c);
  gpuEmxFree_real32_T(&gpu_y);
  gpuEmxFree_real32_T(&d_gpu_b);
  gpuEmxFree_real32_T(&b_gpu_U);
  gpuEmxFree_real32_T(&i_gpu_a);
  gpuEmxFree_creal32_T(&d_gpu_W);
  gpuEmxFree_real32_T(&b_gpu_wreal);
  gpuEmxFree_real32_T(&d_gpu_tau);
  gpuEmxFree_real32_T(&b_gpu_wimag);
  gpuEmxFree_real32_T(&f_gpu_A);
  gpuEmxFree_real32_T(&j_gpu_a);
  gpuEmxFree_real32_T(&b_gpu_vright);
  gpuEmxFree_real32_T(&gpu_rr);
  gpuEmxFree_real32_T(&gpu_A);
  gpuEmxFree_real32_T(&b_gpu_a);
  gpuEmxFree_real32_T(&b_gpu_Y);
  gpuEmxFree_real32_T(&g_gpu_A);
  gpuEmxFree_real32_T(&b_gpu_B);
  gpuEmxFree_int32_T(&b_gpu_ipiv);
  gpuEmxFree_real32_T(&l_gpu_c);
  gpuEmxFree_real32_T(&e_gpu_b);
  gpuEmxFree_int32_T(&b_gpu_jpvt);
  gpuEmxFree_int32_T(&b_gpu_ipiv_t);
  gpuEmxFree_creal32_T(&gpu_V);
  gpuEmxFree_real32_T(&c_gpu_tau);
  gpuEmxFree_creal32_T(&gpu_D);
  gpuEmxFree_real32_T(&b_gpu_V);
  gpuEmxFree_real32_T(&gpu_fcnOutput);
  gpuEmxFree_real32_T(&gpu_fv8);
  gpuEmxFree_real32_T(&b_gpu_D);
  gpuEmxFree_real32_T(&b_gpu_z);
  gpuEmxFree_real32_T(&m_gpu_c);
  gpuEmxFree_real32_T(&c_gpu_d);
  gpuEmxFree_int32_T(&gpu_iv2);
  gpuEmxFree_real32_T(&gpu_W);
  gpuEmxFree_real32_T(&d_gpu_y);
  gpuEmxFree_real32_T(&d_gpu_A);
  gpuEmxFree_real32_T(&c_gpu_absdiff);
  gpuEmxFree_real32_T(&gpu_b);
  gpuEmxFree_real32_T(&gpu_U);
  gpuEmxFree_real32_T(&c_gpu_a);
  gpuEmxFree_creal32_T(&b_gpu_W);
  gpuEmxFree_real32_T(&gpu_wreal);
  gpuEmxFree_real32_T(&b_gpu_tau);
  gpuEmxFree_real32_T(&gpu_wimag);
  gpuEmxFree_real32_T(&b_gpu_A);
  gpuEmxFree_real32_T(&d_gpu_a);
  gpuEmxFree_real32_T(&gpu_vright);
  gpuEmxFree_real32_T(&gpu_Y);
  gpuEmxFree_real32_T(&c_gpu_A);
  gpuEmxFree_real32_T(&gpu_B);
  gpuEmxFree_int32_T(&gpu_ipiv);
  gpuEmxFree_real32_T(&d_gpu_c);
  gpuEmxFree_real32_T(&b_gpu_b);
  gpuEmxFree_int32_T(&gpu_jpvt);
  gpuEmxFree_int32_T(&gpu_ipiv_t);
  gpuEmxFree_real32_T(&gpu_tau);
  gpuEmxFree_real32_T(&gpu_fv9);
  gpuEmxFree_real32_T(&gpu_z);
  gpuEmxFree_real32_T(&e_gpu_c);
  gpuEmxFree_real32_T(&gpu_d);
  gpuEmxFree_real32_T(&gpu_absdiff);
  gpuEmxFree_real32_T(&gpu_yy);
  gpuEmxFree_real32_T(&k_gpu_vec);
  gpuEmxFree_real32_T(&j_gpu_vec);
  gpuEmxFree_real32_T(&i_gpu_vec);
  gpuEmxFree_real32_T(&c_gpu_b);
  gpuEmxFree_real32_T(&l_gpu_vec);
  gpuEmxFree_real32_T(&c_gpu_vec);
  gpuEmxFree_int32_T(&gpu_iv6);
  gpuEmxFree_real32_T(&d_gpu_vec);
  gpuEmxFree_real32_T(&e_gpu_a);
  gpuEmxFree_real32_T(&e_gpu_vec);
  gpuEmxFree_int32_T(&gpu_iv7);
  gpuEmxFree_real32_T(&g_gpu_vec);
  gpuEmxFree_real32_T(&f_gpu_vec);
  gpuEmxFree_real32_T(&gpu_fv10);
  gpuEmxFree_real32_T(&f_gpu_a);
  gpuEmxFree_real32_T(&gpu_fv11);
  gpuEmxFree_real32_T(&h_gpu_vec);
  gpuEmxFree_int32_T(&gpu_iv8);
  gpuEmxFree_real32_T(&gpu_fv12);
  gpuEmxFree_real32_T(&f_gpu_c);
  gpuEmxFree_real32_T(&gpu_fv13);
  gpuEmxFree_real32_T(&g_gpu_c);
  gpuEmxFree_real32_T(&h_gpu_c);
  gpuEmxFree_real32_T(&b_gpu_d);
  gpuEmxFree_real32_T(&b_gpu_y);
  gpuEmxFree_real32_T(&b_gpu_absdiff);
  gpuEmxFree_boolean_T(&d_gpu_r);
  gpuEmxFree_boolean_T(&gpu_r1);
  gpuEmxFree_real32_T(&f_gpu_V);
  gpuEmxFree_real32_T(&b_gpu_r);
  gpuEmxFree_real32_T(&c_gpu_V);
  gpuEmxFree_real32_T(&g_gpu_a);
  gpuEmxFree_real32_T(&e_gpu_x);
  gpuEmxFree_real32_T(&b_gpu_trend);
  mwCudaFree(gpu_npages);
  mwCudaFree(b_gpu_info);
  mwCudaFree(gpu_info);
}

void ec_detrend_api(const mxArray * const prhs[6], int32_T nlhs, const mxArray
                    *plhs[2])
{
  emxArray_real32_T *w;
  emxArray_real32_T *x;
  real32_T nItr;
  real32_T order;
  real32_T thr;
  real32_T winSz;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  // Marshall function inputs
  emxInit_real32_T(&x, 2, &emlrtRTEI, true);
  emlrt_marshallIn(emlrtAliasP(prhs[0]), "x", x);
  emxInit_real32_T(&w, 2, &emlrtRTEI, true);
  emlrt_marshallIn(emlrtAliasP(prhs[1]), "w", w);
  order = emlrt_marshallIn(emlrtAliasP(prhs[2]), "order");
  thr = emlrt_marshallIn(emlrtAliasP(prhs[3]), "thr");
  nItr = emlrt_marshallIn(emlrtAliasP(prhs[4]), "nItr");
  winSz = emlrt_marshallIn(emlrtAliasP(prhs[5]), "winSz");

  // Invoke the target function
  ec_detrend(x, w, order, thr, nItr, winSz);

  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(x);
  emxFree_real32_T(&x);
  if (nlhs > 1) {
    plhs[1] = emlrt_marshallOut(w);
  }

  emxFree_real32_T(&w);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ec_detrend_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  cusolverDestroyWorkspace();
  cusolverEnsureDestruction();
}

void ec_detrend_initialize()
{
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "distrib_computing_toolbox", 2);
  cublasEnsureInitialization(CUBLAS_POINTER_MODE_HOST);
  cusolverEnsureInitialization();
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    ec_detrend_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ec_detrend_terminate()
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

// End of code generation (ec_detrend.cu)
