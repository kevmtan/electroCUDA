//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecc_detrend.cu
//
// Code generation for function 'ecc_detrend'
//

// Include files
#include "ecc_detrend.h"
#include "_coder_ecc_detrend_mex.h"
#include "ecc_detrend_types.h"
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
struct emxArray_creal_T
{
  creal_T *data;
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

struct emxArray_int8_T
{
  int8_T *data;
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
  "ecc_detrend",                       // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 3130694236U, 2616137409U, 972914731U, 129233577U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtRTEInfo emlrtRTEI{ 1,      // lineNo
  1,                                   // colNo
  "_coder_ecc_detrend_api",            // fName
  ""                                   // pName
};

static emlrtRTEInfo b_emlrtRTEI{ 46,   // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 46,   // lineNo
  15,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 47,   // lineNo
  13,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 99,   // lineNo
  20,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 75,   // lineNo
  20,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 55,   // lineNo
  6,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 103,  // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 49,   // lineNo
  20,                                  // colNo
  "linspace",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/linspace.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 104,  // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 82,   // lineNo
  20,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 92,   // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 187,  // lineNo
  10,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 170,  // lineNo
  24,                                  // colNo
  "combineVectorElements",             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "sum",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/sum.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 172,  // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 173,  // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 44,   // lineNo
  36,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 158,  // lineNo
  24,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 94,   // lineNo
  5,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 68,   // lineNo
  24,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 72,   // lineNo
  28,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 175,  // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 97,   // lineNo
  9,                                   // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 176, // lineNo
  10,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 76,  // lineNo
  22,                                  // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 109, // lineNo
  24,                                  // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 83,  // lineNo
  24,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 101, // lineNo
  13,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 176, // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 42,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 86,  // lineNo
  21,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 69,  // lineNo
  13,                                  // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 90,  // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 115, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 86,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 116, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 177, // lineNo
  9,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 118, // lineNo
  35,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 46,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 111, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 87,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 85,  // lineNo
  9,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 112, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 177, // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 144, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 137, // lineNo
  10,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 152, // lineNo
  16,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 188, // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 129, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 177, // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 137, // lineNo
  12,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 145, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 32,  // lineNo
  13,                                  // colNo
  "eigStandard",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/private/eigStandard.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 130, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 17,  // lineNo
  5,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 142, // lineNo
  41,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 178, // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 18,  // lineNo
  29,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 44,  // lineNo
  32,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 179, // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 50,  // lineNo
  31,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 44,  // lineNo
  35,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 44,  // lineNo
  48,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 53,  // lineNo
  13,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 61,  // lineNo
  9,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 92,  // lineNo
  22,                                  // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 105, // lineNo
  1,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 180, // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 85,  // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 88,  // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 85,  // lineNo
  1,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 126, // lineNo
  34,                                  // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 30,  // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 90,  // lineNo
  7,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 119, // lineNo
  5,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 52,  // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo ed_emlrtRTEI{ 122, // lineNo
  9,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo fd_emlrtRTEI{ 126, // lineNo
  18,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo gd_emlrtRTEI{ 28,  // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo hd_emlrtRTEI{ 128, // lineNo
  30,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo id_emlrtRTEI{ 113, // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo jd_emlrtRTEI{ 126, // lineNo
  13,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo kd_emlrtRTEI{ 128, // lineNo
  13,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo ld_emlrtRTEI{ 130, // lineNo
  13,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo md_emlrtRTEI{ 320, // lineNo
  20,                                  // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo nd_emlrtRTEI{ 134, // lineNo
  27,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo od_emlrtRTEI{ 135, // lineNo
  31,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo pd_emlrtRTEI{ 136, // lineNo
  27,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo qd_emlrtRTEI{ 146, // lineNo
  7,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo rd_emlrtRTEI{ 55,  // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo sd_emlrtRTEI{ 148, // lineNo
  11,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo td_emlrtRTEI{ 151, // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo ud_emlrtRTEI{ 153, // lineNo
  7,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo vd_emlrtRTEI{ 1,   // lineNo
  18,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo wd_emlrtRTEI{ 75,  // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo xd_emlrtRTEI{ 76,  // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo yd_emlrtRTEI{ 82,  // lineNo
  1,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo ae_emlrtRTEI{ 112, // lineNo
  23,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo be_emlrtRTEI{ 187, // lineNo
  6,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo ce_emlrtRTEI{ 85,  // lineNo
  22,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo de_emlrtRTEI{ 174, // lineNo
  2,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo ee_emlrtRTEI{ 174, // lineNo
  4,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo fe_emlrtRTEI{ 83,  // lineNo
  1,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ge_emlrtRTEI{ 115, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo he_emlrtRTEI{ 116, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ie_emlrtRTEI{ 118, // lineNo
  10,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo je_emlrtRTEI{ 111, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ke_emlrtRTEI{ 160, // lineNo
  13,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo le_emlrtRTEI{ 112, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo me_emlrtRTEI{ 44,  // lineNo
  9,                                   // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo ne_emlrtRTEI{ 18,  // lineNo
  5,                                   // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo oe_emlrtRTEI{ 180, // lineNo
  8,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo pe_emlrtRTEI{ 126, // lineNo
  9,                                   // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo qe_emlrtRTEI{ 126, // lineNo
  55,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo re_emlrtRTEI{ 130, // lineNo
  18,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo se_emlrtRTEI{ 128, // lineNo
  18,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo te_emlrtRTEI{ 130, // lineNo
  30,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo ue_emlrtRTEI{ 147, // lineNo
  13,                                  // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

static emlrtRTEInfo ve_emlrtRTEI{ 147, // lineNo
  5,                                   // colNo
  "ecc_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detrend.m"// pName
};

// Function Declarations
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, real_T in4);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static real_T b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5, const emxArray_real_T
  *in6, int32_T in7, int32_T in8);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6, const emxArray_real_T *in7);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, int32_T in4, int32_T in5, real_T in6);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, real_T in5, const emxArray_real_T *in6, int32_T in7,
  int32_T in8);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5, int32_T in6, int32_T in7);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  real_T in3, const emxArray_real_T *in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, real_T in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  real_T in3);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, const emxArray_real_T *in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, int32_T in4, int32_T in5);
static void binary_expand_op(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6);
static void binary_expand_op(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6, int32_T in7, int32_T in8, const
  emxArray_real_T *in9, const emxArray_real_T *in10);
static __global__ void ecc_detrend_kernel1(creal_T *dc);
static __global__ void ecc_detrend_kernel10(const emxArray_real_T w, const
  emxArray_real_T x, int32_T b_x, emxArray_real_T c_x);
static __global__ void ecc_detrend_kernel100(int32_T A, emxArray_real_T b_A);
static __global__ void ecc_detrend_kernel101(const emxArray_real_T wimag, const
  emxArray_real_T wreal, int32_T *n, emxArray_creal_T W);
static __global__ void ecc_detrend_kernel102(const emxArray_real_T vright,
  int32_T b_vright, emxArray_creal_T V);
static __global__ void ecc_detrend_kernel103(const int32_T i, int32_T *n, const
  int32_T V_dim0, emxArray_creal_T V);
static __global__ void ecc_detrend_kernel104(const creal_T *dc, int32_T jend,
  emxArray_creal_T W);
static __global__ void ecc_detrend_kernel105(const creal_T *dc, int32_T V,
  emxArray_creal_T b_V);
static __global__ void ecc_detrend_kernel106(int32_T A, emxArray_creal_T D);
static __global__ void ecc_detrend_kernel107(int32_T V, emxArray_real_T A);
static __global__ void ecc_detrend_kernel108(int32_T jend, emxArray_real_T tau);
static __global__ void ecc_detrend_kernel109(const emxArray_real_T A, int32_T
  b_A, emxArray_real_T U);
static __global__ void ecc_detrend_kernel11(const emxArray_real_T w, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T x_dim0, const
  int32_T r_dim0, emxArray_real_T x);
static __global__ void ecc_detrend_kernel110(int32_T V, emxArray_real_T U);
static __global__ void ecc_detrend_kernel111(int32_T V, emxArray_real_T A);
static __global__ void ecc_detrend_kernel112(int32_T V, emxArray_real_T U);
static __global__ void ecc_detrend_kernel113(int32_T sz, emxArray_real_T U);
static __global__ void ecc_detrend_kernel114(int32_T sz, emxArray_real_T A);
static __global__ void ecc_detrend_kernel115(int32_T A, emxArray_creal_T D);
static __global__ void ecc_detrend_kernel116(const emxArray_real_T U, int32_T
  b_U, emxArray_creal_T V);
static __global__ void ecc_detrend_kernel117(int32_T V, emxArray_real_T A);
static __global__ void ecc_detrend_kernel118(int32_T jend, emxArray_real_T tau);
static __global__ void ecc_detrend_kernel119(const emxArray_real_T A, int32_T
  b_A, emxArray_real_T V);
static __global__ void ecc_detrend_kernel12(const int32_T vlen, const
  emxArray_real_T x, int32_T npages, const int32_T x_dim0, emxArray_real_T y);
static __global__ void ecc_detrend_kernel120(int32_T V, emxArray_real_T b_V);
static __global__ void ecc_detrend_kernel121(int32_T V, emxArray_real_T A);
static __global__ void ecc_detrend_kernel122(int32_T V, emxArray_real_T b_V);
static __global__ void ecc_detrend_kernel123(int32_T sz, emxArray_real_T V);
static __global__ void ecc_detrend_kernel124(int32_T sz, emxArray_real_T A);
static __global__ void ecc_detrend_kernel125(const int32_T A_dim0, int32_T *n,
  emxArray_real_T A);
static __global__ void ecc_detrend_kernel126(const int32_T A_dim0,
  emxArray_real_T A, int32_T *n);
static __global__ void ecc_detrend_kernel127(const emxArray_real_T V, int32_T
  b_V, emxArray_creal_T c_V);
static __global__ void ecc_detrend_kernel128(const emxArray_real_T A, int32_T
  b_A, emxArray_creal_T D);
static __global__ void ecc_detrend_kernel129(const creal_T *dc, int32_T V,
  emxArray_creal_T b_V);
static __global__ void ecc_detrend_kernel13(int32_T sz, emxArray_real_T y);
static __global__ void ecc_detrend_kernel130(int32_T V, emxArray_creal_T D);
static __global__ void ecc_detrend_kernel131(const emxArray_creal_T V, int32_T
  b_V, emxArray_real_T c_V);
static __global__ void ecc_detrend_kernel132(const emxArray_creal_T D, int32_T
  b_D, emxArray_real_T v);
static __global__ void ecc_detrend_kernel133(const emxArray_real_T v, int32_T
  vlen, const int32_T v_dim0, emxArray_real_T D);
static __global__ void ecc_detrend_kernel134(const emxArray_real_T D, int32_T
  b_D, real_T *d2scaled, emxArray_boolean_T bv1);
static __global__ void ecc_detrend_kernel135(const emxArray_int32_T iv2, const
  emxArray_real_T V, const int32_T npages, int32_T b_iv2, const int32_T V_dim0,
  const int32_T b_V_dim0, emxArray_real_T b_V);
static __global__ void ecc_detrend_kernel136(const emxArray_real_T V, int32_T
  b_V, emxArray_real_T c_V);
static __global__ void ecc_detrend_kernel137(const emxArray_real_T rr, int32_T
  b_rr, emxArray_real_T A);
static __global__ void ecc_detrend_kernel138(int32_T npages, int32_T *n,
  emxArray_real_T rr);
static __global__ void ecc_detrend_kernel139(const emxArray_real_T w, const
  int32_T i11, const real_T mn, const emxArray_real_T x, const int32_T i7,
  int32_T ii, emxArray_real_T A);
static __global__ void ecc_detrend_kernel14(const emxArray_real_T y, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T r_dim0, const
  int32_T b_r_dim0, real_T *abnrm, emxArray_real_T d_r);
static __global__ void ecc_detrend_kernel140(int32_T rr, emxArray_real_T b);
static __global__ void ecc_detrend_kernel141(const emxArray_real_T rr, const
  int32_T b_rr, int32_T c_rr, const int32_T A_dim0, const int32_T rr_dim0,
  emxArray_real_T A);
static __global__ void ecc_detrend_kernel142(int32_T A, emxArray_real_T b_A);
static __global__ void ecc_detrend_kernel143(const emxArray_real_T A, const
  int32_T b_A, int32_T c_A, const int32_T A_dim0, const int32_T b_A_dim0,
  emxArray_real_T d_A);
static __global__ void ecc_detrend_kernel144(const emxArray_real_T b, int32_T
  b_b, emxArray_real_T B);
static __global__ void ecc_detrend_kernel145(int32_T A, emxArray_int32_T jpvt);
static __global__ void ecc_detrend_kernel146(const int32_T npages, int32_T *n,
  const int32_T A_dim0, emxArray_real_T A);
static __global__ void ecc_detrend_kernel147(int32_T npages, emxArray_real_T tau);
static __global__ void ecc_detrend_kernel148(int32_T *n, emxArray_int32_T jpvt);
static __global__ void ecc_detrend_kernel149(int32_T vlen, emxArray_real_T Y);
static __global__ void ecc_detrend_kernel15(const emxArray_real_T w, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T rr_dim0,
  const int32_T r_dim0, emxArray_real_T rr);
static __global__ void ecc_detrend_kernel150(int32_T vlen, emxArray_real_T B);
static __global__ void ecc_detrend_kernel151(const emxArray_real_T B, const
  emxArray_int32_T jpvt, int32_T nx, emxArray_real_T Y);
static __global__ void ecc_detrend_kernel152(const emxArray_real_T Y, int32_T
  b_Y, emxArray_real_T b);
static __global__ void ecc_detrend_kernel153(const emxArray_int32_T ipiv_t,
  int32_T vlen, emxArray_int32_T ipiv);
static __global__ void ecc_detrend_kernel154(int32_T V, emxArray_real_T A);
static __global__ void ecc_detrend_kernel155(int32_T vlen, emxArray_int32_T ipiv);
static __global__ void ecc_detrend_kernel156(int32_T sz, emxArray_real_T b);
static __global__ void ecc_detrend_kernel157(const emxArray_real_T b, int32_T
  b_b, emxArray_real_T B);
static __global__ void ecc_detrend_kernel158(int32_T V, emxArray_real_T y);
static __global__ void ecc_detrend_kernel159(int32_T r, emxArray_real_T dv13);
static __global__ void ecc_detrend_kernel16(const emxArray_real_T rr, const
  int32_T b_rr, int32_T c_rr, const int32_T A_dim0, const int32_T rr_dim0,
  emxArray_real_T A);
static __global__ void ecc_detrend_kernel160(const real_T mn, const
  emxArray_real_T x, const int32_T i7, const emxArray_real_T dv13, int32_T
  b_dv13, emxArray_real_T z);
static __global__ void ecc_detrend_kernel161(const emxArray_real_T w, const
  int32_T i11, const emxArray_real_T z, const emxArray_real_T x, const int32_T
  i7, int32_T ii, emxArray_real_T d);
static __global__ void ecc_detrend_kernel162(const emxArray_real_T d, int32_T n,
  real_T *d2scaled, emxArray_real_T absdiff);
static __global__ void ecc_detrend_kernel163(const emxArray_real_T z, const
  emxArray_real_T x, const int32_T i7, int32_T ii, emxArray_real_T yy);
static __global__ void ecc_detrend_kernel164(real_T d2scaled, emxArray_real_T y);
static __global__ void ecc_detrend_kernel165(const real_T rconde, real_T *abnrm,
  emxArray_real_T y);
static __global__ void ecc_detrend_kernel166(const real_T rconde, const int32_T
  n, int32_T vlen, real_T *d2scaled, emxArray_real_T y);
static __global__ void ecc_detrend_kernel167(const int32_T jend, real_T
  *d2scaled, emxArray_real_T y);
static __global__ void ecc_detrend_kernel168(const real_T rconde, const int32_T
  jend, emxArray_real_T y);
static __global__ void ecc_detrend_kernel169(const real_T rconde, const int32_T
  jend, real_T *d2scaled, emxArray_real_T y);
static __global__ void ecc_detrend_kernel17(int32_T A, emxArray_real_T b_A);
static __global__ void ecc_detrend_kernel170(emxArray_real_T y, real_T *d2scaled);
static __global__ void ecc_detrend_kernel171(const emxArray_real_T y, int32_T
  vlen, emxArray_real_T b);
static __global__ void ecc_detrend_kernel172(real_T d2scaled, emxArray_real_T y);
static __global__ void ecc_detrend_kernel173(real_T wsize2, emxArray_int8_T a);
static __global__ void ecc_detrend_kernel174(const emxArray_real_T y, int32_T
  vlen, emxArray_real_T b);
static __global__ void ecc_detrend_kernel175(real_T wsize2, emxArray_int8_T a);
static __global__ void ecc_detrend_kernel176(const real_T rconde, real_T *abnrm,
  emxArray_real_T y);
static __global__ void ecc_detrend_kernel177(const real_T rconde, const int32_T
  n, int32_T vlen, real_T *d2scaled, emxArray_real_T y);
static __global__ void ecc_detrend_kernel178(const int32_T jend, real_T
  *d2scaled, emxArray_real_T y);
static __global__ void ecc_detrend_kernel179(const real_T rconde, const int32_T
  jend, emxArray_real_T y);
static __global__ void ecc_detrend_kernel18(const emxArray_real_T wimag, const
  emxArray_real_T wreal, int32_T *n, emxArray_creal_T W);
static __global__ void ecc_detrend_kernel180(const real_T rconde, const int32_T
  jend, real_T *d2scaled, emxArray_real_T y);
static __global__ void ecc_detrend_kernel181(emxArray_real_T y, real_T *d2scaled);
static __global__ void ecc_detrend_kernel182(const real_T wsize2, int32_T vlen,
  emxArray_real_T b);
static __global__ void ecc_detrend_kernel183(const emxArray_real_T b, const
  emxArray_real_T yy, const emxArray_real_T x, const int32_T vlen, int32_T jend,
  emxArray_real_T b_x);
static __global__ void ecc_detrend_kernel184(const emxArray_real_T x, const
  int32_T npages, int32_T b_x, emxArray_real_T c_x);
static __global__ void ecc_detrend_kernel185(const emxArray_real_T b, const
  emxArray_real_T yy, const emxArray_real_T x, const emxArray_real_T trend,
  const int32_T jend, int32_T npages, int32_T *n, emxArray_real_T b_trend);
static __global__ void ecc_detrend_kernel186(const emxArray_real_T trend, const
  int32_T nx, int32_T b_trend, emxArray_real_T c_trend);
static __global__ void ecc_detrend_kernel187(const emxArray_real_T b, const
  emxArray_real_T a, const int32_T vlen, int32_T jend, emxArray_real_T b_a);
static __global__ void ecc_detrend_kernel188(const emxArray_real_T a, const
  int32_T npages, int32_T b_a, emxArray_real_T c_a);
static __global__ void ecc_detrend_kernel189(const int32_T x_dim0, const int32_T
  a_dim0, emxArray_real_T a, emxArray_real_T x);
static __global__ void ecc_detrend_kernel19(const emxArray_real_T vright,
  int32_T b_vright, emxArray_creal_T V);
static __global__ void ecc_detrend_kernel190(const emxArray_real_T a, int32_T x,
  emxArray_real_T b_x);
static __global__ void ecc_detrend_kernel191(const emxArray_real_T x, int32_T
  b_x, emxArray_boolean_T bv4);
static __global__ void ecc_detrend_kernel192(const emxArray_int32_T iv8, int32_T
  b_iv8, emxArray_real_T x);
static __global__ void ecc_detrend_kernel193(const emxArray_real_T a, int32_T
  trend, emxArray_real_T b_trend);
static __global__ void ecc_detrend_kernel194(const emxArray_real_T trend,
  int32_T b_trend, emxArray_boolean_T bv5);
static __global__ void ecc_detrend_kernel195(const emxArray_int32_T iv9, int32_T
  b_iv9, emxArray_real_T trend);
static __global__ void ecc_detrend_kernel196(const emxArray_real_T w, const
  emxArray_real_T trend, const emxArray_real_T x, int32_T b_x, emxArray_real_T d);
static __global__ void ecc_detrend_kernel197(const emxArray_real_T d, int32_T n,
  real_T *d2scaled, emxArray_real_T absdiff);
static __global__ void ecc_detrend_kernel198(const emxArray_real_T d, int32_T nx,
  emxArray_real_T y);
static __global__ void ecc_detrend_kernel199(const emxArray_real_T y, int32_T
  b_y, real_T *d2scaled, emxArray_boolean_T bv6);
static __global__ void ecc_detrend_kernel2(const int32_T ch, const
  emxArray_real_T x, int32_T vlen, const int32_T x_dim0, emxArray_real_T b_x);
static __global__ void ecc_detrend_kernel20(const int32_T i, int32_T *n, const
  int32_T V_dim0, emxArray_creal_T V);
static __global__ void ecc_detrend_kernel200(const emxArray_int32_T iv10,
  int32_T b_iv10, emxArray_real_T w);
static __global__ void ecc_detrend_kernel201(const emxArray_real_T x, int32_T
  b_x, emxArray_real_T c_x);
static __global__ void ecc_detrend_kernel202(const emxArray_real_T x, const
  int32_T ch, int32_T b_x, const int32_T x_dim0, emxArray_real_T c_x);
static __global__ void ecc_detrend_kernel203(const emxArray_real_T w, const
  int32_T ch, int32_T b_w, const int32_T w_dim0, emxArray_real_T c_w);
static __global__ void ecc_detrend_kernel21(const creal_T *dc, int32_T jend,
  emxArray_creal_T W);
static __global__ void ecc_detrend_kernel22(const creal_T *dc, int32_T V,
  emxArray_creal_T b_V);
static __global__ void ecc_detrend_kernel23(int32_T A, emxArray_creal_T D);
static __global__ void ecc_detrend_kernel24(int32_T V, emxArray_real_T A);
static __global__ void ecc_detrend_kernel25(int32_T jend, emxArray_real_T tau);
static __global__ void ecc_detrend_kernel26(const emxArray_real_T A, int32_T b_A,
  emxArray_real_T U);
static __global__ void ecc_detrend_kernel27(int32_T V, emxArray_real_T U);
static __global__ void ecc_detrend_kernel28(int32_T V, emxArray_real_T A);
static __global__ void ecc_detrend_kernel29(int32_T V, emxArray_real_T U);
static __global__ void ecc_detrend_kernel3(const int32_T ch, const
  emxArray_real_T w, int32_T vlen, const int32_T w_dim0, emxArray_real_T b_w);
static __global__ void ecc_detrend_kernel30(int32_T sz, emxArray_real_T U);
static __global__ void ecc_detrend_kernel31(int32_T sz, emxArray_real_T A);
static __global__ void ecc_detrend_kernel32(int32_T A, emxArray_creal_T D);
static __global__ void ecc_detrend_kernel33(const emxArray_real_T U, int32_T b_U,
  emxArray_creal_T V);
static __global__ void ecc_detrend_kernel34(int32_T V, emxArray_real_T A);
static __global__ void ecc_detrend_kernel35(int32_T jend, emxArray_real_T tau);
static __global__ void ecc_detrend_kernel36(const emxArray_real_T A, int32_T b_A,
  emxArray_real_T V);
static __global__ void ecc_detrend_kernel37(int32_T V, emxArray_real_T b_V);
static __global__ void ecc_detrend_kernel38(int32_T V, emxArray_real_T A);
static __global__ void ecc_detrend_kernel39(int32_T V, emxArray_real_T b_V);
static __global__ void ecc_detrend_kernel4(int32_T w, emxArray_real_T b_w);
static __global__ void ecc_detrend_kernel40(int32_T sz, emxArray_real_T V);
static __global__ void ecc_detrend_kernel41(int32_T sz, emxArray_real_T A);
static __global__ void ecc_detrend_kernel42(const int32_T A_dim0, int32_T *n,
  emxArray_real_T A);
static __global__ void ecc_detrend_kernel43(const int32_T A_dim0,
  emxArray_real_T A, int32_T *n);
static __global__ void ecc_detrend_kernel44(const emxArray_real_T V, int32_T b_V,
  emxArray_creal_T c_V);
static __global__ void ecc_detrend_kernel45(const emxArray_real_T A, int32_T b_A,
  emxArray_creal_T D);
static __global__ void ecc_detrend_kernel46(const creal_T *dc, int32_T V,
  emxArray_creal_T b_V);
static __global__ void ecc_detrend_kernel47(int32_T V, emxArray_creal_T D);
static __global__ void ecc_detrend_kernel48(const emxArray_creal_T V, int32_T
  b_V, emxArray_real_T c_V);
static __global__ void ecc_detrend_kernel49(const emxArray_creal_T D, int32_T
  b_D, emxArray_real_T v);
static __global__ void ecc_detrend_kernel5(int32_T vlen, const int32_T lin_dim1,
  real_T *d2scaled, emxArray_real_T lin);
static __global__ void ecc_detrend_kernel50(const emxArray_real_T v, int32_T
  vlen, const int32_T v_dim0, emxArray_real_T D);
static __global__ void ecc_detrend_kernel51(const emxArray_real_T D, int32_T b_D,
  real_T *d2scaled, emxArray_boolean_T bv);
static __global__ void ecc_detrend_kernel52(const emxArray_int32_T iv, const
  emxArray_real_T V, const int32_T npages, int32_T b_iv, const int32_T V_dim0,
  const int32_T b_V_dim0, emxArray_real_T b_V);
static __global__ void ecc_detrend_kernel53(const emxArray_real_T V, int32_T b_V,
  emxArray_real_T c_V);
static __global__ void ecc_detrend_kernel54(const emxArray_real_T rr, int32_T
  b_rr, emxArray_real_T A);
static __global__ void ecc_detrend_kernel55(int32_T npages, int32_T *n,
  emxArray_real_T rr);
static __global__ void ecc_detrend_kernel56(const emxArray_real_T w, const
  real_T mn, const emxArray_real_T x, int32_T b_x, emxArray_real_T A);
static __global__ void ecc_detrend_kernel57(int32_T rr, emxArray_real_T b);
static __global__ void ecc_detrend_kernel58(const emxArray_real_T rr, const
  int32_T b_rr, int32_T c_rr, const int32_T A_dim0, const int32_T rr_dim0,
  emxArray_real_T A);
static __global__ void ecc_detrend_kernel59(int32_T A, emxArray_real_T b_A);
static __global__ void ecc_detrend_kernel6(const int32_T lin_dim1,
  emxArray_real_T lin);
static __global__ void ecc_detrend_kernel60(const emxArray_real_T A, const
  int32_T b_A, int32_T c_A, const int32_T A_dim0, const int32_T b_A_dim0,
  emxArray_real_T d_A);
static __global__ void ecc_detrend_kernel61(const emxArray_real_T b, int32_T b_b,
  emxArray_real_T B);
static __global__ void ecc_detrend_kernel62(int32_T A, emxArray_int32_T jpvt);
static __global__ void ecc_detrend_kernel63(const int32_T npages, int32_T *n,
  const int32_T A_dim0, emxArray_real_T A);
static __global__ void ecc_detrend_kernel64(int32_T npages, emxArray_real_T tau);
static __global__ void ecc_detrend_kernel65(int32_T *n, emxArray_int32_T jpvt);
static __global__ void ecc_detrend_kernel66(int32_T vlen, emxArray_real_T Y);
static __global__ void ecc_detrend_kernel67(int32_T vlen, emxArray_real_T B);
static __global__ void ecc_detrend_kernel68(const emxArray_real_T B, const
  emxArray_int32_T jpvt, int32_T nx, emxArray_real_T Y);
static __global__ void ecc_detrend_kernel69(const emxArray_real_T Y, int32_T b_Y,
  emxArray_real_T b);
static __global__ void ecc_detrend_kernel7(const int32_T npages, const
  emxArray_real_T lin, int32_T nx, emxArray_real_T dv);
static __global__ void ecc_detrend_kernel70(const emxArray_int32_T ipiv_t,
  int32_T vlen, emxArray_int32_T ipiv);
static __global__ void ecc_detrend_kernel71(int32_T V, emxArray_real_T A);
static __global__ void ecc_detrend_kernel72(int32_T vlen, emxArray_int32_T ipiv);
static __global__ void ecc_detrend_kernel73(int32_T sz, emxArray_real_T b);
static __global__ void ecc_detrend_kernel74(const emxArray_real_T b, int32_T b_b,
  emxArray_real_T B);
static __global__ void ecc_detrend_kernel75(int32_T V, emxArray_real_T y);
static __global__ void ecc_detrend_kernel76(int32_T r, emxArray_real_T dv7);
static __global__ void ecc_detrend_kernel77(const real_T mn, const
  emxArray_real_T x, const emxArray_real_T dv7, int32_T b_dv7, emxArray_real_T z);
static __global__ void ecc_detrend_kernel78(const emxArray_real_T w, const
  emxArray_real_T z, const emxArray_real_T x, int32_T b_x, emxArray_real_T d);
static __global__ void ecc_detrend_kernel79(const emxArray_real_T d, int32_T n,
  real_T *d2scaled, emxArray_real_T absdiff);
static __global__ void ecc_detrend_kernel8(const emxArray_real_T dv, const
  int32_T npages, int32_T jend, const int32_T r_dim0, emxArray_real_T r);
static __global__ void ecc_detrend_kernel80(const emxArray_real_T d, int32_T nx,
  emxArray_real_T y);
static __global__ void ecc_detrend_kernel81(const emxArray_real_T y, int32_T b_y,
  real_T *d2scaled, emxArray_boolean_T bv2);
static __global__ void ecc_detrend_kernel82(const emxArray_int32_T iv4, int32_T
  b_iv4, emxArray_real_T w);
static __global__ void ecc_detrend_kernel83(const emxArray_real_T z, const
  int32_T ch, const emxArray_real_T x, int32_T vlen, const int32_T x_dim0,
  emxArray_real_T b_x);
static __global__ void ecc_detrend_kernel84(uint32_T dims_idx_0, emxArray_real_T
  trend);
static __global__ void ecc_detrend_kernel85(uint32_T dims_idx_0, emxArray_real_T
  a);
static __global__ void ecc_detrend_kernel86(const emxArray_real_T w, const
  int32_T jend, int32_T nx, emxArray_real_T minval);
static __global__ void ecc_detrend_kernel87(int32_T vlen, const int32_T lin_dim1,
  real_T *d2scaled, emxArray_real_T lin);
static __global__ void ecc_detrend_kernel88(const int32_T lin_dim1,
  emxArray_real_T lin);
static __global__ void ecc_detrend_kernel89(const int32_T npages, const
  emxArray_real_T lin, int32_T nx, emxArray_real_T dv1);
static __global__ void ecc_detrend_kernel9(const emxArray_real_T w, const
  emxArray_real_T x, int32_T b_x, emxArray_real_T c_x);
static __global__ void ecc_detrend_kernel90(const emxArray_real_T dv1, const
  int32_T npages, int32_T jend, const int32_T r_dim0, emxArray_real_T r);
static __global__ void ecc_detrend_kernel91(const emxArray_real_T w, const
  int32_T i11, const emxArray_real_T x, const int32_T i7, int32_T ii,
  emxArray_real_T b_x);
static __global__ void ecc_detrend_kernel92(const emxArray_real_T w, const
  int32_T i11, const emxArray_real_T x, const int32_T i7, int32_T ii,
  emxArray_real_T b_x);
static __global__ void ecc_detrend_kernel93(const emxArray_real_T w, const
  int32_T i11, const emxArray_real_T r, const int32_T b_r, int32_T c_r, const
  int32_T x_dim0, const int32_T r_dim0, emxArray_real_T x);
static __global__ void ecc_detrend_kernel94(const int32_T vlen, const
  emxArray_real_T x, int32_T npages, const int32_T x_dim0, emxArray_real_T y);
static __global__ void ecc_detrend_kernel95(int32_T sz, emxArray_real_T y);
static __global__ void ecc_detrend_kernel96(const emxArray_real_T y, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T r_dim0, const
  int32_T b_r_dim0, real_T *abnrm, emxArray_real_T d_r);
static __global__ void ecc_detrend_kernel97(const emxArray_real_T r, int32_T b_r,
  emxArray_real_T c_r);
static __global__ void ecc_detrend_kernel98(const emxArray_real_T w, const
  int32_T i11, const emxArray_real_T r, const int32_T b_r, int32_T c_r, const
  int32_T rr_dim0, const int32_T r_dim0, emxArray_real_T rr);
static __global__ void ecc_detrend_kernel99(const emxArray_real_T rr, const
  int32_T b_rr, int32_T c_rr, const int32_T A_dim0, const int32_T rr_dim0,
  emxArray_real_T A);
static void ecc_detrend_once();
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static real_T emlrt_marshallIn(const mxArray *order, const char_T *identifier);
static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static void emlrt_marshallOut(const emxArray_real_T *u, const mxArray *y);
static void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_creal_T(emxArray_creal_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int8_T(emxArray_int8_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_ptrdiff_t(emxArray_ptrdiff_t *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxFree_boolean_T(emxArray_boolean_T **pEmxArray);
static void emxFree_creal_T(emxArray_creal_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_int8_T(emxArray_int8_T **pEmxArray);
static void emxFree_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxInit_boolean_T(emxArray_boolean_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_creal_T(emxArray_creal_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int8_T(emxArray_int8_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void gpuEmxEnsureCapacity_boolean_T(const emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu);
static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
  emxArray_creal_T *gpu);
static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu);
static void gpuEmxEnsureCapacity_int8_T(const emxArray_int8_T *cpu,
  emxArray_int8_T *gpu);
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu);
static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxFree_creal_T(emxArray_creal_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
static void gpuEmxFree_int8_T(emxArray_int8_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
static void gpuEmxMemcpyCpuToGpu_creal_T(emxArray_creal_T *gpu, const
  emxArray_creal_T *cpu);
static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu, const
  emxArray_int32_T *cpu);
static void gpuEmxMemcpyCpuToGpu_int8_T(emxArray_int8_T *gpu, const
  emxArray_int8_T *cpu);
static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu, const
  emxArray_real_T *cpu);
static void gpuEmxMemcpyGpuToCpu_boolean_T(emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu);
static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu, emxArray_creal_T
  *gpu);
static void gpuEmxMemcpyGpuToCpu_int32_T(emxArray_int32_T *cpu, emxArray_int32_T
  *gpu);
static void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T
  *gpu);
static void gpuEmxReset_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxReset_creal_T(emxArray_creal_T *gpu);
static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);
static void gpuEmxReset_int8_T(emxArray_int8_T *gpu);
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static real_T rt_remd_snf(real_T u0, real_T u1);
static void times(emxArray_real_T *in1, const emxArray_real_T *in2, const
                  emxArray_real_T *in3);

// Function Definitions
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, real_T in4)
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

  emxEnsureCapacity_real_T(in1, i, &q_emlrtRTEI);
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
        - in3->data[aux_1_1] / (in4 + 2.2204460492503131E-16);
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

static real_T b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
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

static void binary_expand_op(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &pd_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in6->size[0] == 1) {
    b_in1->size[0] = (in5 - in4) + 1;
  } else {
    b_in1->size[0] = in6->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &pd_emlrtRTEI);
  stride_0_0 = ((in5 - in4) + 1 != 1);
  stride_1_0 = (in6->size[0] != 1);
  if (in6->size[0] == 1) {
    b = (in5 - in4) + 1;
  } else {
    b = in6->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[in4 + i * stride_0_0] + in6->data[i * stride_1_0];
  }

  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[in2 + i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, int32_T in4, int32_T in5, real_T in6)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if ((in5 - in4) + 1 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = (in5 - in4) + 1;
  }

  emxEnsureCapacity_real_T(in1, i, &vc_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = ((in5 - in4) + 1 != 1);
  if ((in5 - in4) + 1 == 1) {
    b = in2->size[0];
  } else {
    b = (in5 - in4) + 1;
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[i * stride_0_0] + (in3->data[in4 + i * stride_1_0]
      - (in3->data[in4 + i * stride_1_0] - in6));
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, real_T in4)
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

  emxEnsureCapacity_real_T(in1, i, &vc_emlrtRTEI);
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

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5, const emxArray_real_T
  *in6, int32_T in7, int32_T in8)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  i = in1->size[0];
  if (in8 - in7 == 1) {
    if (in5->size[0] == 1) {
      in1->size[0] = (in4 - in3) + 1;
    } else {
      in1->size[0] = in5->size[0];
    }
  } else {
    in1->size[0] = in8 - in7;
  }

  emxEnsureCapacity_real_T(in1, i, &wc_emlrtRTEI);
  stride_0_0 = ((in4 - in3) + 1 != 1);
  stride_1_0 = (in5->size[0] != 1);
  stride_2_0 = (in8 - in7 != 1);
  if (in8 - in7 == 1) {
    if (in5->size[0] == 1) {
      b = (in4 - in3) + 1;
    } else {
      b = in5->size[0];
    }
  } else {
    b = in8 - in7;
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = (in2->data[in3 + i * stride_0_0] - in5->data[i * stride_1_0])
      * in6->data[(in7 + i * stride_2_0) - 1];
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, const emxArray_real_T *in4)
{
  int32_T i;
  int32_T in2_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in2_idx_0 = in2->size[0];
  i = in1->size[0];
  if (in4->size[0] == 1) {
    in1->size[0] = in2_idx_0;
  } else {
    in1->size[0] = in4->size[0];
  }

  emxEnsureCapacity_real_T(in1, i, &m_emlrtRTEI);
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

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in5->size[0] == 1) {
    in1->size[0] = (in4 - in3) + 1;
  } else {
    in1->size[0] = in5->size[0];
  }

  emxEnsureCapacity_real_T(in1, i, &ed_emlrtRTEI);
  stride_0_0 = ((in4 - in3) + 1 != 1);
  stride_1_0 = (in5->size[0] != 1);
  if (in5->size[0] == 1) {
    b = (in4 - in3) + 1;
  } else {
    b = in5->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[in3 + i * stride_0_0] - in5->data[i * stride_1_0];
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3)
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
  emxEnsureCapacity_real_T(in1, i, &r_emlrtRTEI);
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

static void binary_expand_op(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6, const emxArray_real_T *in7)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &nd_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in7->size[0] == 1) {
    b = in6->size[0];
  } else {
    b = in7->size[0];
  }

  if (b == 1) {
    b_in1->size[0] = (in5 - in4) + 1;
  } else if (in7->size[0] == 1) {
    b_in1->size[0] = in6->size[0];
  } else {
    b_in1->size[0] = in7->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &nd_emlrtRTEI);
  stride_0_0 = ((in5 - in4) + 1 != 1);
  stride_1_0 = (in6->size[0] != 1);
  stride_2_0 = (in7->size[0] != 1);
  if (in7->size[0] == 1) {
    b = in6->size[0];
  } else {
    b = in7->size[0];
  }

  if (b == 1) {
    b = (in5 - in4) + 1;
  } else if (in7->size[0] == 1) {
    b = in6->size[0];
  } else {
    b = in7->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[in4 + i * stride_0_0] + in6->data[i * stride_1_0]
      * in7->data[i * stride_2_0];
  }

  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[in2 + i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5, int32_T in6, int32_T in7)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in7 - in6 == 1) {
    in1->size[0] = (in4 - in3) + 1;
  } else {
    in1->size[0] = in7 - in6;
  }

  emxEnsureCapacity_real_T(in1, i, &n_emlrtRTEI);
  stride_0_0 = ((in4 - in3) + 1 != 1);
  stride_1_0 = (in7 - in6 != 1);
  if (in7 - in6 == 1) {
    b = (in4 - in3) + 1;
  } else {
    b = in7 - in6;
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[in3 + i * stride_0_0] * in5->data[(in6 + i *
      stride_1_0) - 1];
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, real_T in5, const emxArray_real_T *in6, int32_T in7,
  int32_T in8)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  if (in8 - in7 == 1) {
    in1->size[1] = (in4 - in3) + 1;
  } else {
    in1->size[1] = in8 - in7;
  }

  emxEnsureCapacity_real_T(in1, i, &s_emlrtRTEI);
  stride_0_1 = ((in4 - in3) + 1 != 1);
  stride_1_1 = (in8 - in7 != 1);
  if (in8 - in7 == 1) {
    b = (in4 - in3) + 1;
  } else {
    b = in8 - in7;
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = (in2->data[in3 + i * stride_0_1] - in5) * in6->data[(in7 + i *
      stride_1_1) - 1];
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, int32_T in4, int32_T in5)
{
  int32_T i;
  int32_T in5_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in5_idx_0 = in5 - in4;
  i = in1->size[0] * in1->size[1];
  if (in5_idx_0 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in5_idx_0;
  }

  in1->size[1] = in2->size[1];
  emxEnsureCapacity_real_T(in1, i, &r_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in5_idx_0 != 1);
  for (i = 0; i < in2->size[1]; i++) {
    int32_T b;
    if (in5_idx_0 == 1) {
      b = in2->size[0];
    } else {
      b = in5_idx_0;
    }

    for (int32_T i1{0}; i1 < b; i1++) {
      in1->data[i1 + in1->size[0] * i] = in2->data[i1 * stride_0_0 + in2->size[0]
        * i] * in3->data[(in4 + i1 * stride_1_0) - 1];
    }
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &ue_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in2->size[0] == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in2->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &ue_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in2->size[0] != 1);
  if (in2->size[0] == 1) {
    b = in1->size[0];
  } else {
    b = in2->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0] * (1.0 / in2->data[i * stride_1_0]);
  }

  i = in1->size[0];
  in1->size[0] = b_in1->size[0];
  emxEnsureCapacity_real_T(in1, i, &ve_emlrtRTEI);
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  i = in1->size[0];
  if (in4->size[0] == 1) {
    if (in3->size[0] == 1) {
      in1->size[0] = in2->size[0];
    } else {
      in1->size[0] = in3->size[0];
    }
  } else {
    in1->size[0] = in4->size[0];
  }

  emxEnsureCapacity_real_T(in1, i, &wc_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  stride_2_0 = (in4->size[0] != 1);
  if (in4->size[0] == 1) {
    if (in3->size[0] == 1) {
      b = in2->size[0];
    } else {
      b = in3->size[0];
    }
  } else {
    b = in4->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = (in2->data[i * stride_0_0] - in3->data[i * stride_1_0]) *
      in4->data[i * stride_2_0];
  }
}

static void binary_expand_op(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6, int32_T in7, int32_T in8, const
  emxArray_real_T *in9, const emxArray_real_T *in10)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  int32_T stride_3_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &od_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in10->size[0] == 1) {
    if (in9->size[0] == 1) {
      b = (in8 - in7) + 1;
    } else {
      b = in9->size[0];
    }
  } else {
    b = in10->size[0];
  }

  if (b == 1) {
    b_in1->size[0] = (in5 - in4) + 1;
  } else if (in10->size[0] == 1) {
    if (in9->size[0] == 1) {
      b_in1->size[0] = (in8 - in7) + 1;
    } else {
      b_in1->size[0] = in9->size[0];
    }
  } else {
    b_in1->size[0] = in10->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &od_emlrtRTEI);
  stride_0_0 = ((in5 - in4) + 1 != 1);
  stride_1_0 = ((in8 - in7) + 1 != 1);
  stride_2_0 = (in9->size[0] != 1);
  stride_3_0 = (in10->size[0] != 1);
  if (in10->size[0] == 1) {
    if (in9->size[0] == 1) {
      b = (in8 - in7) + 1;
    } else {
      b = in9->size[0];
    }
  } else {
    b = in10->size[0];
  }

  if (b == 1) {
    b = (in5 - in4) + 1;
  } else if (in10->size[0] == 1) {
    if (in9->size[0] == 1) {
      b = (in8 - in7) + 1;
    } else {
      b = in9->size[0];
    }
  } else {
    b = in10->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[in4 + i * stride_0_0] + (in6->data[in7 + i *
      stride_1_0] - in9->data[i * stride_2_0]) * in10->data[i * stride_3_0];
  }

  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[in2 + i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  real_T in3, const emxArray_real_T *in4)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  if (in4->size[0] == 1) {
    in1->size[1] = in2->size[0];
  } else {
    in1->size[1] = in4->size[0];
  }

  emxEnsureCapacity_real_T(in1, i, &s_emlrtRTEI);
  stride_0_1 = (in2->size[0] != 1);
  stride_1_1 = (in4->size[0] != 1);
  if (in4->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in4->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = (in2->data[i * stride_0_1] - in3) * in4->data[i * stride_1_1];
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  real_T in3)
{
  emxArray_real_T *b_in1;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 2, &yb_emlrtRTEI, true);
  i = b_in1->size[0] * b_in1->size[1];
  b_in1->size[0] = in1->size[0];
  if (in2->size[1] == 1) {
    b_in1->size[1] = in1->size[1];
  } else {
    b_in1->size[1] = in2->size[1];
  }

  emxEnsureCapacity_real_T(b_in1, i, &yb_emlrtRTEI);
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
        aux_0_1] - in2->data[aux_1_1] / (in3 + 2.2204460492503131E-16);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }

  i = in1->size[0] * in1->size[1];
  in1->size[0] = b_in1->size[0];
  in1->size[1] = b_in1->size[1];
  emxEnsureCapacity_real_T(in1, i, &q_emlrtRTEI);
  for (i = 0; i < b_in1->size[1]; i++) {
    for (int32_T i1{0}; i1 < b_in1->size[0]; i1++) {
      in1->data[i1 + in1->size[0] * i] = b_in1->data[i1 + b_in1->size[0] * i];
    }
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel1(creal_T *dc)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    dc->re = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel10(const
  emxArray_real_T w, const emxArray_real_T x, int32_T b_x, emxArray_real_T c_x)
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
    c_x.data[i] = x.data[i] * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel100(int32_T
  A, emxArray_real_T b_A)
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
    b_A.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel101(const
  emxArray_real_T wimag, const emxArray_real_T wreal, int32_T *n,
  emxArray_creal_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i].re = wreal.data[i];
    W.data[i].im = wimag.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel102(const
  emxArray_real_T vright, int32_T b_vright, emxArray_creal_T V)
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
    V.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel103(const
  int32_T i, int32_T *n, const int32_T V_dim0, emxArray_creal_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    d = V.data[xpageoffset + V_dim0 * (i + 1)].re;
    V.data[xpageoffset + V_dim0 * i].im = d;
    V.data[xpageoffset + V_dim0 * (i + 1)].re = V.data[xpageoffset + V_dim0 * i]
      .re;
    V.data[xpageoffset + V_dim0 * (i + 1)].im = -V.data[xpageoffset + V_dim0 * i]
      .im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel104(const
  creal_T *dc, int32_T jend, emxArray_creal_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel105(const
  creal_T *dc, int32_T V, emxArray_creal_T b_V)
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
    b_V.data[i] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel106(int32_T
  A, emxArray_creal_T D)
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
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel107(int32_T
  V, emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel108(int32_T
  jend, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel109(const
  emxArray_real_T A, int32_T b_A, emxArray_real_T U)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel11(const
  emxArray_real_T w, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T x_dim0, const int32_T r_dim0, emxArray_real_T x)
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
    x.data[xpageoffset + x_dim0 * i] = r.data[xpageoffset + r_dim0 * i] *
      w.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel110(int32_T
  V, emxArray_real_T U)
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
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel111(int32_T
  V, emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel112(int32_T
  V, emxArray_real_T U)
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
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel113(int32_T
  sz, emxArray_real_T U)
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
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel114(int32_T
  sz, emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel115(int32_T
  A, emxArray_creal_T D)
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
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel116(const
  emxArray_real_T U, int32_T b_U, emxArray_creal_T V)
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
    V.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel117(int32_T
  V, emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel118(int32_T
  jend, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel119(const
  emxArray_real_T A, int32_T b_A, emxArray_real_T V)
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
    V.data[i] = A.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel12(const
  int32_T vlen, const emxArray_real_T x, int32_T npages, const int32_T x_dim0,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx);
    xpageoffset = i * x_dim0;
    y.data[i] = x.data[xpageoffset];
    for (int32_T k{0}; k <= vlen - 2; k++) {
      y.data[i] += x.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel120(int32_T
  V, emxArray_real_T b_V)
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
    b_V.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel121(int32_T
  V, emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel122(int32_T
  V, emxArray_real_T b_V)
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
    b_V.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel123(int32_T
  sz, emxArray_real_T V)
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
    V.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel124(int32_T
  sz, emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel125(const
  int32_T A_dim0, int32_T *n, emxArray_real_T A)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    A.data[(*n + A_dim0 * *n) + 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel126(const
  int32_T A_dim0, emxArray_real_T A, int32_T *n)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i + A_dim0 * (*n + 1)] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel127(const
  emxArray_real_T V, int32_T b_V, emxArray_creal_T c_V)
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
    c_V.data[i].re = V.data[i];
    c_V.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel128(const
  emxArray_real_T A, int32_T b_A, emxArray_creal_T D)
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
    D.data[i].re = A.data[i];
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel129(const
  creal_T *dc, int32_T V, emxArray_creal_T b_V)
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
    b_V.data[i] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel13(int32_T
  sz, emxArray_real_T y)
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
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel130(int32_T
  V, emxArray_creal_T D)
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
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel131(const
  emxArray_creal_T V, int32_T b_V, emxArray_real_T c_V)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel132(const
  emxArray_creal_T D, int32_T b_D, emxArray_real_T v)
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
    v.data[i] = D.data[i].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel133(const
  emxArray_real_T v, int32_T vlen, const int32_T v_dim0, emxArray_real_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    D.data[k] = v.data[k + v_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel134(const
  emxArray_real_T D, int32_T b_D, real_T *d2scaled, emxArray_boolean_T bv1)
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
    bv1.data[i] = (D.data[i] / *d2scaled > 1.0E-7);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel135(const
  emxArray_int32_T iv2, const emxArray_real_T V, const int32_T npages, int32_T
  b_iv2, const int32_T V_dim0, const int32_T b_V_dim0, emxArray_real_T b_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(npages - 1) + 1UL) * (static_cast<uint64_T>
    (b_iv2) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(npages - 1)
      + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(npages - 1) + 1UL));
    b_V.data[xpageoffset + V_dim0 * i] = V.data[xpageoffset + b_V_dim0 *
      (iv2.data[i] - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel136(const
  emxArray_real_T V, int32_T b_V, emxArray_real_T c_V)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel137(const
  emxArray_real_T rr, int32_T b_rr, emxArray_real_T A)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel138(int32_T
  npages, int32_T *n, emxArray_real_T rr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages * *n - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    rr.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel139(const
  emxArray_real_T w, const int32_T i11, const real_T mn, const emxArray_real_T x,
  const int32_T i7, int32_T ii, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ii - i7);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = (x.data[i7 + i] - mn) * w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel14(const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T r_dim0, const int32_T b_r_dim0, real_T *abnrm, emxArray_real_T
  d_r)
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
      y.data[i] / *abnrm;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel140(int32_T
  rr, emxArray_real_T b)
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
    b.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel141(const
  emxArray_real_T rr, const int32_T b_rr, int32_T c_rr, const int32_T A_dim0,
  const int32_T rr_dim0, emxArray_real_T A)
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
    A.data[xpageoffset + A_dim0 * i] = rr.data[i + rr_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel142(int32_T
  A, emxArray_real_T b_A)
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
    b_A.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel143(const
  emxArray_real_T A, const int32_T b_A, int32_T c_A, const int32_T A_dim0, const
  int32_T b_A_dim0, emxArray_real_T d_A)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel144(const
  emxArray_real_T b, int32_T b_b, emxArray_real_T B)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel145(int32_T
  A, emxArray_int32_T jpvt)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel146(const
  int32_T npages, int32_T *n, const int32_T A_dim0, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(npages - 1) + 1UL) * (static_cast<uint64_T>
    (*n) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(npages - 1) + 1UL));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) / (
      static_cast<uint64_T>(npages - 1) + 1UL));
    A.data[xpageoffset * A_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel147(int32_T
  npages, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    tau.data[k] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel148(int32_T *
  n, emxArray_int32_T jpvt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    jpvt.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel149(int32_T
  vlen, emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel15(const
  emxArray_real_T w, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T rr_dim0, const int32_T r_dim0, emxArray_real_T rr)
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
      w.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel150(int32_T
  vlen, emxArray_real_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel151(const
  emxArray_real_T B, const emxArray_int32_T jpvt, int32_T nx, emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[jpvt.data[i] - 1] = B.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel152(const
  emxArray_real_T Y, int32_T b_Y, emxArray_real_T b)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel153(const
  emxArray_int32_T ipiv_t, int32_T vlen, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel154(int32_T
  V, emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel155(int32_T
  vlen, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel156(int32_T
  sz, emxArray_real_T b)
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
    b.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel157(const
  emxArray_real_T b, int32_T b_b, emxArray_real_T B)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel158(int32_T
  V, emxArray_real_T y)
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
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel159(int32_T
  r, emxArray_real_T dv13)
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
    dv13.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel16(const
  emxArray_real_T rr, const int32_T b_rr, int32_T c_rr, const int32_T A_dim0,
  const int32_T rr_dim0, emxArray_real_T A)
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
    A.data[xpageoffset + A_dim0 * i] = rr.data[i + rr_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel160(const
  real_T mn, const emxArray_real_T x, const int32_T i7, const emxArray_real_T
  dv13, int32_T b_dv13, emxArray_real_T z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv13);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    z.data[i] = dv13.data[i] + (x.data[i7 + i] - (x.data[i7 + i] - mn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel161(const
  emxArray_real_T w, const int32_T i11, const emxArray_real_T z, const
  emxArray_real_T x, const int32_T i7, int32_T ii, emxArray_real_T d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ii - i7);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = (x.data[i7 + i] - z.data[i]) * w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel162(const
  emxArray_real_T d, int32_T n, real_T *d2scaled, emxArray_real_T absdiff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n + 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabs(d.data[k] - *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel163(const
  emxArray_real_T z, const emxArray_real_T x, const int32_T i7, int32_T ii,
  emxArray_real_T yy)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ii - i7);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    yy.data[i] = x.data[i7 + i] - z.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel164(real_T
  d2scaled, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(d2scaled - 1.0));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = static_cast<real_T>(i) + 1.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel165(const
  real_T rconde, real_T *abnrm, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[static_cast<int32_T>(*abnrm) - 1] = rconde;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel166(const
  real_T rconde, const int32_T n, int32_T vlen, real_T *d2scaled,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k + 1] = *d2scaled - (static_cast<real_T>(k) + 1.0);
    y.data[(n - k) - 2] = rconde - (-(static_cast<real_T>(k) + 1.0));
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel167(const
  int32_T jend, real_T *d2scaled, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[jend] = *d2scaled - static_cast<real_T>(jend);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel168(const
  real_T rconde, const int32_T jend, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[jend + 1] = rconde - (-static_cast<real_T>(jend));
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel169(const
  real_T rconde, const int32_T jend, real_T *d2scaled, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[jend] = (*d2scaled + rconde) / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel17(int32_T A,
  emxArray_real_T b_A)
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
    b_A.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel170
  (emxArray_real_T y, real_T *d2scaled)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(-(1.0 - *d2scaled)));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = *d2scaled - static_cast<real_T>(i);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel171(const
  emxArray_real_T y, int32_T vlen, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel172(real_T
  d2scaled, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(d2scaled - 1.0));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = static_cast<real_T>(i) + 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel173(real_T
  wsize2, emxArray_int8_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(wsize2 / 2.0) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[i] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel174(const
  emxArray_real_T y, int32_T vlen, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel175(real_T
  wsize2, emxArray_int8_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(wsize2 / 2.0) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[i] = 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel176(const
  real_T rconde, real_T *abnrm, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[static_cast<int32_T>(*abnrm) - 1] = rconde;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel177(const
  real_T rconde, const int32_T n, int32_T vlen, real_T *d2scaled,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k + 1] = *d2scaled - (static_cast<real_T>(k) + 1.0);
    y.data[(n - k) - 2] = rconde - (-(static_cast<real_T>(k) + 1.0));
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel178(const
  int32_T jend, real_T *d2scaled, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[jend] = *d2scaled - static_cast<real_T>(jend);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel179(const
  real_T rconde, const int32_T jend, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[jend + 1] = rconde - (-static_cast<real_T>(jend));
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel18(const
  emxArray_real_T wimag, const emxArray_real_T wreal, int32_T *n,
  emxArray_creal_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i].re = wreal.data[i];
    W.data[i].im = wimag.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel180(const
  real_T rconde, const int32_T jend, real_T *d2scaled, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[jend] = (*d2scaled + rconde) / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel181
  (emxArray_real_T y, real_T *d2scaled)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(-(1.0 - *d2scaled)));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = *d2scaled - static_cast<real_T>(i);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel182(const
  real_T wsize2, int32_T vlen, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = wsize2 / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel183(const
  emxArray_real_T b, const emxArray_real_T yy, const emxArray_real_T x, const
  int32_T vlen, int32_T jend, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_x.data[i] = x.data[vlen + i] + yy.data[i] * b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel184(const
  emxArray_real_T x, const int32_T npages, int32_T b_x, emxArray_real_T c_x)
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
    c_x.data[npages + i] = x.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel185(const
  emxArray_real_T b, const emxArray_real_T yy, const emxArray_real_T x, const
  emxArray_real_T trend, const int32_T jend, int32_T npages, int32_T *n,
  emxArray_real_T b_trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages - jend);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_trend.data[i] = trend.data[jend + i] + (x.data[*n + i] - yy.data[i]) *
      b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel186(const
  emxArray_real_T trend, const int32_T nx, int32_T b_trend, emxArray_real_T
  c_trend)
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
    c_trend.data[nx + i] = trend.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel187(const
  emxArray_real_T b, const emxArray_real_T a, const int32_T vlen, int32_T jend,
  emxArray_real_T b_a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_a.data[i] = a.data[vlen + i] + b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel188(const
  emxArray_real_T a, const int32_T npages, int32_T b_a, emxArray_real_T c_a)
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
    c_a.data[npages + i] = a.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel189(const
  int32_T x_dim0, const int32_T a_dim0, emxArray_real_T a, emxArray_real_T x)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    x.data[x_dim0 - 1] = x.data[x_dim0 - 2];

    // 'ecc_detrend:143' a(end,:) = a(end-1,:);
    a.data[a_dim0 - 1] = a.data[a_dim0 - 2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel19(const
  emxArray_real_T vright, int32_T b_vright, emxArray_creal_T V)
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
    V.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel190(const
  emxArray_real_T a, int32_T x, emxArray_real_T b_x)
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
    b_x.data[i] *= 1.0 / a.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel191(const
  emxArray_real_T x, int32_T b_x, emxArray_boolean_T bv4)
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
    bv4.data[i] = isnan(x.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel192(const
  emxArray_int32_T iv8, int32_T b_iv8, emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_iv8);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[iv8.data[i] - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel193(const
  emxArray_real_T a, int32_T trend, emxArray_real_T b_trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(trend);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_trend.data[i] *= 1.0 / a.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel194(const
  emxArray_real_T trend, int32_T b_trend, emxArray_boolean_T bv5)
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
    bv5.data[i] = isnan(trend.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel195(const
  emxArray_int32_T iv9, int32_T b_iv9, emxArray_real_T trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_iv9);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    trend.data[iv9.data[i] - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel196(const
  emxArray_real_T w, const emxArray_real_T trend, const emxArray_real_T x,
  int32_T b_x, emxArray_real_T d)
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
    d.data[i] = (x.data[i] - trend.data[i]) * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel197(const
  emxArray_real_T d, int32_T n, real_T *d2scaled, emxArray_real_T absdiff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n + 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabs(d.data[k] - *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel198(const
  emxArray_real_T d, int32_T nx, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = fabs(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel199(const
  emxArray_real_T y, int32_T b_y, real_T *d2scaled, emxArray_boolean_T bv6)
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
    bv6.data[i] = (y.data[i] > *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel2(const
  int32_T ch, const emxArray_real_T x, int32_T vlen, const int32_T x_dim0,
  emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_x.data[i] = x.data[i + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel20(const
  int32_T i, int32_T *n, const int32_T V_dim0, emxArray_creal_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    d = V.data[xpageoffset + V_dim0 * (i + 1)].re;
    V.data[xpageoffset + V_dim0 * i].im = d;
    V.data[xpageoffset + V_dim0 * (i + 1)].re = V.data[xpageoffset + V_dim0 * i]
      .re;
    V.data[xpageoffset + V_dim0 * (i + 1)].im = -V.data[xpageoffset + V_dim0 * i]
      .im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel200(const
  emxArray_int32_T iv10, int32_T b_iv10, emxArray_real_T w)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_iv10);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    w.data[iv10.data[i] - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel201(const
  emxArray_real_T x, int32_T b_x, emxArray_real_T c_x)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel202(const
  emxArray_real_T x, const int32_T ch, int32_T b_x, const int32_T x_dim0,
  emxArray_real_T c_x)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel203(const
  emxArray_real_T w, const int32_T ch, int32_T b_w, const int32_T w_dim0,
  emxArray_real_T c_w)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel21(const
  creal_T *dc, int32_T jend, emxArray_creal_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel22(const
  creal_T *dc, int32_T V, emxArray_creal_T b_V)
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
    b_V.data[i] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel23(int32_T A,
  emxArray_creal_T D)
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
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel24(int32_T V,
  emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel25(int32_T
  jend, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel26(const
  emxArray_real_T A, int32_T b_A, emxArray_real_T U)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel27(int32_T V,
  emxArray_real_T U)
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
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel28(int32_T V,
  emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel29(int32_T V,
  emxArray_real_T U)
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
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel3(const
  int32_T ch, const emxArray_real_T w, int32_T vlen, const int32_T w_dim0,
  emxArray_real_T b_w)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_w.data[i] = w.data[i + w_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel30(int32_T
  sz, emxArray_real_T U)
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
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel31(int32_T
  sz, emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel32(int32_T A,
  emxArray_creal_T D)
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
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel33(const
  emxArray_real_T U, int32_T b_U, emxArray_creal_T V)
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
    V.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel34(int32_T V,
  emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel35(int32_T
  jend, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel36(const
  emxArray_real_T A, int32_T b_A, emxArray_real_T V)
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
    V.data[i] = A.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel37(int32_T V,
  emxArray_real_T b_V)
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
    b_V.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel38(int32_T V,
  emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel39(int32_T V,
  emxArray_real_T b_V)
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
    b_V.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel4(int32_T w,
  emxArray_real_T b_w)
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
    b_w.data[i] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel40(int32_T
  sz, emxArray_real_T V)
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
    V.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel41(int32_T
  sz, emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel42(const
  int32_T A_dim0, int32_T *n, emxArray_real_T A)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    A.data[(*n + A_dim0 * *n) + 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel43(const
  int32_T A_dim0, emxArray_real_T A, int32_T *n)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i + A_dim0 * (*n + 1)] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel44(const
  emxArray_real_T V, int32_T b_V, emxArray_creal_T c_V)
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
    c_V.data[i].re = V.data[i];
    c_V.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel45(const
  emxArray_real_T A, int32_T b_A, emxArray_creal_T D)
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
    D.data[i].re = A.data[i];
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel46(const
  creal_T *dc, int32_T V, emxArray_creal_T b_V)
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
    b_V.data[i] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel47(int32_T V,
  emxArray_creal_T D)
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
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel48(const
  emxArray_creal_T V, int32_T b_V, emxArray_real_T c_V)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel49(const
  emxArray_creal_T D, int32_T b_D, emxArray_real_T v)
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
    v.data[i] = D.data[i].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel5(int32_T
  vlen, const int32_T lin_dim1, real_T *d2scaled, emxArray_real_T lin)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real_T>((((k + 2) << 1) - lin_dim1) - 1) *
      *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel50(const
  emxArray_real_T v, int32_T vlen, const int32_T v_dim0, emxArray_real_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    D.data[k] = v.data[k + v_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel51(const
  emxArray_real_T D, int32_T b_D, real_T *d2scaled, emxArray_boolean_T bv)
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
    bv.data[i] = (D.data[i] / *d2scaled > 1.0E-7);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel52(const
  emxArray_int32_T iv, const emxArray_real_T V, const int32_T npages, int32_T
  b_iv, const int32_T V_dim0, const int32_T b_V_dim0, emxArray_real_T b_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(npages - 1) + 1UL) * (static_cast<uint64_T>
    (b_iv) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(npages - 1)
      + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(npages - 1) + 1UL));
    b_V.data[xpageoffset + V_dim0 * i] = V.data[xpageoffset + b_V_dim0 *
      (iv.data[i] - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel53(const
  emxArray_real_T V, int32_T b_V, emxArray_real_T c_V)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel54(const
  emxArray_real_T rr, int32_T b_rr, emxArray_real_T A)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel55(int32_T
  npages, int32_T *n, emxArray_real_T rr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages * *n - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    rr.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel56(const
  emxArray_real_T w, const real_T mn, const emxArray_real_T x, int32_T b_x,
  emxArray_real_T A)
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
    A.data[i] = (x.data[i] - mn) * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel57(int32_T
  rr, emxArray_real_T b)
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
    b.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel58(const
  emxArray_real_T rr, const int32_T b_rr, int32_T c_rr, const int32_T A_dim0,
  const int32_T rr_dim0, emxArray_real_T A)
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
    A.data[xpageoffset + A_dim0 * i] = rr.data[i + rr_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel59(int32_T A,
  emxArray_real_T b_A)
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
    b_A.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel6(const
  int32_T lin_dim1, emxArray_real_T lin)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[lin_dim1 >> 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel60(const
  emxArray_real_T A, const int32_T b_A, int32_T c_A, const int32_T A_dim0, const
  int32_T b_A_dim0, emxArray_real_T d_A)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel61(const
  emxArray_real_T b, int32_T b_b, emxArray_real_T B)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel62(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel63(const
  int32_T npages, int32_T *n, const int32_T A_dim0, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(npages - 1) + 1UL) * (static_cast<uint64_T>
    (*n) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(npages - 1) + 1UL));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) / (
      static_cast<uint64_T>(npages - 1) + 1UL));
    A.data[xpageoffset * A_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel64(int32_T
  npages, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    tau.data[k] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel65(int32_T
  *n, emxArray_int32_T jpvt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    jpvt.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel66(int32_T
  vlen, emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel67(int32_T
  vlen, emxArray_real_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel68(const
  emxArray_real_T B, const emxArray_int32_T jpvt, int32_T nx, emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[jpvt.data[i] - 1] = B.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel69(const
  emxArray_real_T Y, int32_T b_Y, emxArray_real_T b)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel7(const
  int32_T npages, const emxArray_real_T lin, int32_T nx, emxArray_real_T dv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv.data[k] = pow(lin.data[k], static_cast<real_T>(npages) + 1.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel70(const
  emxArray_int32_T ipiv_t, int32_T vlen, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel71(int32_T V,
  emxArray_real_T A)
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
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel72(int32_T
  vlen, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel73(int32_T
  sz, emxArray_real_T b)
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
    b.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel74(const
  emxArray_real_T b, int32_T b_b, emxArray_real_T B)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel75(int32_T V,
  emxArray_real_T y)
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
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel76(int32_T r,
  emxArray_real_T dv7)
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
    dv7.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel77(const
  real_T mn, const emxArray_real_T x, const emxArray_real_T dv7, int32_T b_dv7,
  emxArray_real_T z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv7);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    z.data[i] = dv7.data[i] + (x.data[i] - (x.data[i] - mn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel78(const
  emxArray_real_T w, const emxArray_real_T z, const emxArray_real_T x, int32_T
  b_x, emxArray_real_T d)
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
    d.data[i] = (x.data[i] - z.data[i]) * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel79(const
  emxArray_real_T d, int32_T n, real_T *d2scaled, emxArray_real_T absdiff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n + 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabs(d.data[k] - *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel8(const
  emxArray_real_T dv, const int32_T npages, int32_T jend, const int32_T r_dim0,
  emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    r.data[i + r_dim0 * npages] = dv.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel80(const
  emxArray_real_T d, int32_T nx, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = fabs(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel81(const
  emxArray_real_T y, int32_T b_y, real_T *d2scaled, emxArray_boolean_T bv2)
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
    bv2.data[i] = (y.data[i] > *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel82(const
  emxArray_int32_T iv4, int32_T b_iv4, emxArray_real_T w)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_iv4);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    w.data[iv4.data[i] - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel83(const
  emxArray_real_T z, const int32_T ch, const emxArray_real_T x, int32_T vlen,
  const int32_T x_dim0, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_x.data[i] = x.data[i + x_dim0 * ch] - z.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel84(uint32_T
  dims_idx_0, emxArray_real_T trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(dims_idx_0) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    trend.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel85(uint32_T
  dims_idx_0, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(dims_idx_0) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel86(const
  emxArray_real_T w, const int32_T jend, int32_T nx, emxArray_real_T minval)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    minval.data[k] = fmin(w.data[(jend + k) - 1], 2.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel87(int32_T
  vlen, const int32_T lin_dim1, real_T *d2scaled, emxArray_real_T lin)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real_T>((((k + 2) << 1) - lin_dim1) - 1) *
      *d2scaled;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detrend_kernel88(const
  int32_T lin_dim1, emxArray_real_T lin)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[lin_dim1 >> 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel89(const
  int32_T npages, const emxArray_real_T lin, int32_T nx, emxArray_real_T dv1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv1.data[k] = pow(lin.data[k], static_cast<real_T>(npages) + 1.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel9(const
  emxArray_real_T w, const emxArray_real_T x, int32_T b_x, emxArray_real_T c_x)
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
    c_x.data[i] = x.data[i] * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel90(const
  emxArray_real_T dv1, const int32_T npages, int32_T jend, const int32_T r_dim0,
  emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    r.data[i + r_dim0 * npages] = dv1.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel91(const
  emxArray_real_T w, const int32_T i11, const emxArray_real_T x, const int32_T
  i7, int32_T ii, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ii - i7);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_x.data[i] = x.data[i7 + i] * w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel92(const
  emxArray_real_T w, const int32_T i11, const emxArray_real_T x, const int32_T
  i7, int32_T ii, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ii - i7);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_x.data[i] = x.data[i7 + i] * w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel93(const
  emxArray_real_T w, const int32_T i11, const emxArray_real_T r, const int32_T
  b_r, int32_T c_r, const int32_T x_dim0, const int32_T r_dim0, emxArray_real_T
  x)
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
    x.data[xpageoffset + x_dim0 * i] = r.data[xpageoffset + r_dim0 * i] *
      w.data[(i11 + xpageoffset) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel94(const
  int32_T vlen, const emxArray_real_T x, int32_T npages, const int32_T x_dim0,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx);
    xpageoffset = i * x_dim0;
    y.data[i] = x.data[xpageoffset];
    for (int32_T k{0}; k <= vlen - 2; k++) {
      y.data[i] += x.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel95(int32_T
  sz, emxArray_real_T y)
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
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel96(const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T r_dim0, const int32_T b_r_dim0, real_T *abnrm, emxArray_real_T
  d_r)
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
      y.data[i] / *abnrm;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel97(const
  emxArray_real_T r, int32_T b_r, emxArray_real_T c_r)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel98(const
  emxArray_real_T w, const int32_T i11, const emxArray_real_T r, const int32_T
  b_r, int32_T c_r, const int32_T rr_dim0, const int32_T r_dim0, emxArray_real_T
  rr)
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
      w.data[(i11 + xpageoffset) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detrend_kernel99(const
  emxArray_real_T rr, const int32_T b_rr, int32_T c_rr, const int32_T A_dim0,
  const int32_T rr_dim0, emxArray_real_T A)
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
    A.data[xpageoffset + A_dim0 * i] = rr.data[i + rr_dim0 * xpageoffset];
  }
}

static void ecc_detrend_once()
{
  mwMemoryManagerInit(256U, 1U, 8U, 8192U);
}

static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = b_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T emlrt_marshallIn(const mxArray *order, const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(order), &thisId);
  emlrtDestroyArray(&order);
  return y;
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
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

static void emlrt_marshallOut(const emxArray_real_T *u, const mxArray *y)
{
  emlrtMxSetData((mxArray *)y, &u->data[0]);
  emlrtSetDimensions((mxArray *)y, &u->size[0], 2);
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

static void emxEnsureCapacity_int8_T(emxArray_int8_T *emxArray, int32_T oldNumel,
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(int8_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<int8_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<int8_T *>(newData);
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

static void emxFree_int8_T(emxArray_int8_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_int8_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<int8_T *>(nullptr)) && (*pEmxArray)
        ->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_int8_T *>(nullptr);
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

static void emxInit_int8_T(emxArray_int8_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_int8_T *emxArray;
  *pEmxArray = static_cast<emxArray_int8_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_int8_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_int8_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<int8_T *>(nullptr);
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

static void gpuEmxEnsureCapacity_boolean_T(const emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu)
{
  boolean_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
      (cpu->allocatedSize) * sizeof(boolean_T)));
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
        (cpu->allocatedSize) * sizeof(boolean_T)));
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

static void gpuEmxEnsureCapacity_int8_T(const emxArray_int8_T *cpu,
  emxArray_int8_T *gpu)
{
  int8_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
      (cpu->allocatedSize) * sizeof(int8_T)));
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
        (cpu->allocatedSize) * sizeof(int8_T)));
      cudaMemcpy(newData, gpu->data, static_cast<uint32_T>(actualSizeGpu) *
                 sizeof(int8_T), cudaMemcpyDeviceToDevice);
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

static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    mwCudaFree(gpu->data);
  }

  emlrtFreeMex(gpu->size);
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

static void gpuEmxFree_int8_T(emxArray_int8_T *gpu)
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
    mwCudaMalloc(&gpu->data, static_cast<uint64_T>(static_cast<uint32_T>
      (gpu->allocatedSize) * sizeof(creal_T)));
  }

  cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (creal_T), cudaMemcpyHostToDevice);
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
    mwCudaMalloc(&gpu->data, static_cast<uint64_T>(static_cast<uint32_T>
      (gpu->allocatedSize) * sizeof(int32_T)));
  }

  cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (int32_T), cudaMemcpyHostToDevice);
}

static void gpuEmxMemcpyCpuToGpu_int8_T(emxArray_int8_T *gpu, const
  emxArray_int8_T *cpu)
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
      (gpu->allocatedSize) * sizeof(int8_T)));
  }

  cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (int8_T), cudaMemcpyHostToDevice);
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

static void gpuEmxMemcpyGpuToCpu_boolean_T(emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (boolean_T), cudaMemcpyDeviceToHost);
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

static void gpuEmxReset_boolean_T(emxArray_boolean_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_boolean_T));
}

static void gpuEmxReset_creal_T(emxArray_creal_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_creal_T));
}

static void gpuEmxReset_int32_T(emxArray_int32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_int32_T));
}

static void gpuEmxReset_int8_T(emxArray_int8_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_int8_T));
}

static void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real_T));
}

static real_T rt_remd_snf(real_T u0, real_T u1)
{
  real_T y;
  if (std::isnan(u0) || std::isnan(u1) || std::isinf(u0)) {
    y = rtNaN;
  } else if (std::isinf(u1)) {
    y = u0;
  } else if ((u1 != 0.0) && (u1 != std::trunc(u1))) {
    real_T q;
    q = std::abs(u0 / u1);
    if (!(std::abs(q - std::floor(q + 0.5)) > DBL_EPSILON * q)) {
      y = 0.0 * u0;
    } else {
      y = std::fmod(u0, u1);
    }
  } else {
    y = std::fmod(u0, u1);
  }

  return y;
}

static void times(emxArray_real_T *in1, const emxArray_real_T *in2, const
                  emxArray_real_T *in3)
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

  emxEnsureCapacity_real_T(in1, i, &n_emlrtRTEI);
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
// function [x,w] = ecc_detrend(x,w,order,thr,nItr,winSz)
void ecc_detrend(emxArray_real_T *x, emxArray_real_T *w, real_T order, real_T
                 thr, real_T nItr, real_T winSz)
{
  static creal_T dc{ 0.0,              // re
    0.0                                // im
  };

  ptrdiff_t b_ihi_t;
  ptrdiff_t b_ilo_t;
  ptrdiff_t ihi_t;
  ptrdiff_t ilo_t;
  dim3 block;
  dim3 grid;
  emxArray_boolean_T gpu_bv;
  emxArray_boolean_T gpu_bv1;
  emxArray_boolean_T gpu_bv2;
  emxArray_boolean_T gpu_bv4;
  emxArray_boolean_T gpu_bv5;
  emxArray_boolean_T gpu_bv6;
  emxArray_boolean_T *bv;
  emxArray_boolean_T *bv1;
  emxArray_boolean_T *bv2;
  emxArray_boolean_T *bv4;
  emxArray_boolean_T *bv5;
  emxArray_boolean_T *bv6;
  emxArray_creal_T b_gpu_W;
  emxArray_creal_T c_gpu_D;
  emxArray_creal_T e_gpu_V;
  emxArray_creal_T gpu_D;
  emxArray_creal_T gpu_V;
  emxArray_creal_T gpu_W;
  emxArray_creal_T *D;
  emxArray_creal_T *V;
  emxArray_creal_T *W;
  emxArray_creal_T *b_W;
  emxArray_creal_T *c_D;
  emxArray_creal_T *d_V;
  emxArray_int32_T b_gpu_ipiv;
  emxArray_int32_T b_gpu_ipiv_t;
  emxArray_int32_T b_gpu_jpvt;
  emxArray_int32_T gpu_ipiv;
  emxArray_int32_T gpu_ipiv_t;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv10;
  emxArray_int32_T gpu_iv2;
  emxArray_int32_T gpu_iv4;
  emxArray_int32_T gpu_iv8;
  emxArray_int32_T gpu_iv9;
  emxArray_int32_T gpu_jpvt;
  emxArray_int32_T *b_ipiv;
  emxArray_int32_T *b_ipiv_t;
  emxArray_int32_T *b_jpvt;
  emxArray_int32_T *ipiv;
  emxArray_int32_T *ipiv_t;
  emxArray_int32_T *iv;
  emxArray_int32_T *iv10;
  emxArray_int32_T *iv2;
  emxArray_int32_T *iv4;
  emxArray_int32_T *iv8;
  emxArray_int32_T *iv9;
  emxArray_int32_T *jpvt;
  emxArray_int8_T b_gpu_a;
  emxArray_int8_T c_gpu_a;
  emxArray_int8_T *b_a;
  emxArray_int8_T *c_a;
  emxArray_ptrdiff_t *b_jpvt_t;
  emxArray_ptrdiff_t *jpvt_t;
  emxArray_real_T b_gpu_A;
  emxArray_real_T b_gpu_B;
  emxArray_real_T b_gpu_D;
  emxArray_real_T b_gpu_U;
  emxArray_real_T b_gpu_V;
  emxArray_real_T b_gpu_Y;
  emxArray_real_T b_gpu_absdiff;
  emxArray_real_T b_gpu_b;
  emxArray_real_T b_gpu_d;
  emxArray_real_T b_gpu_lin;
  emxArray_real_T b_gpu_r;
  emxArray_real_T b_gpu_rr;
  emxArray_real_T b_gpu_tau;
  emxArray_real_T b_gpu_trend;
  emxArray_real_T b_gpu_v;
  emxArray_real_T b_gpu_vright;
  emxArray_real_T b_gpu_w;
  emxArray_real_T b_gpu_wimag;
  emxArray_real_T b_gpu_wreal;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_y;
  emxArray_real_T b_gpu_z;
  emxArray_real_T c_gpu_A;
  emxArray_real_T c_gpu_B;
  emxArray_real_T c_gpu_V;
  emxArray_real_T c_gpu_absdiff;
  emxArray_real_T c_gpu_b;
  emxArray_real_T c_gpu_d;
  emxArray_real_T c_gpu_r;
  emxArray_real_T c_gpu_tau;
  emxArray_real_T c_gpu_x;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_A;
  emxArray_real_T d_gpu_B;
  emxArray_real_T d_gpu_D;
  emxArray_real_T d_gpu_V;
  emxArray_real_T d_gpu_a;
  emxArray_real_T d_gpu_r;
  emxArray_real_T d_gpu_tau;
  emxArray_real_T d_gpu_x;
  emxArray_real_T d_gpu_y;
  emxArray_real_T e_gpu_A;
  emxArray_real_T e_gpu_tau;
  emxArray_real_T e_gpu_x;
  emxArray_real_T e_gpu_y;
  emxArray_real_T f_gpu_A;
  emxArray_real_T f_gpu_V;
  emxArray_real_T f_gpu_tau;
  emxArray_real_T f_gpu_x;
  emxArray_real_T f_gpu_y;
  emxArray_real_T g_gpu_A;
  emxArray_real_T g_gpu_V;
  emxArray_real_T g_gpu_x;
  emxArray_real_T g_gpu_y;
  emxArray_real_T gpu_A;
  emxArray_real_T gpu_B;
  emxArray_real_T gpu_U;
  emxArray_real_T gpu_Y;
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_absdiff;
  emxArray_real_T gpu_b;
  emxArray_real_T gpu_d;
  emxArray_real_T gpu_dv;
  emxArray_real_T gpu_dv1;
  emxArray_real_T gpu_dv13;
  emxArray_real_T gpu_dv7;
  emxArray_real_T gpu_lin;
  emxArray_real_T gpu_minval;
  emxArray_real_T gpu_r;
  emxArray_real_T gpu_rr;
  emxArray_real_T gpu_tau;
  emxArray_real_T gpu_trend;
  emxArray_real_T gpu_v;
  emxArray_real_T gpu_vright;
  emxArray_real_T gpu_w;
  emxArray_real_T gpu_wimag;
  emxArray_real_T gpu_wreal;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_yy;
  emxArray_real_T gpu_z;
  emxArray_real_T h_gpu_A;
  emxArray_real_T h_gpu_V;
  emxArray_real_T h_gpu_x;
  emxArray_real_T h_gpu_y;
  emxArray_real_T i_gpu_A;
  emxArray_real_T i_gpu_x;
  emxArray_real_T i_gpu_y;
  emxArray_real_T j_gpu_A;
  emxArray_real_T j_gpu_x;
  emxArray_real_T j_gpu_y;
  emxArray_real_T k_gpu_A;
  emxArray_real_T l_gpu_A;
  emxArray_real_T m_gpu_A;
  emxArray_real_T n_gpu_A;
  emxArray_real_T *A;
  emxArray_real_T *B;
  emxArray_real_T *U;
  emxArray_real_T *Y;
  emxArray_real_T *a;
  emxArray_real_T *absdiff;
  emxArray_real_T *b;
  emxArray_real_T *b_A;
  emxArray_real_T *b_B;
  emxArray_real_T *b_D;
  emxArray_real_T *b_U;
  emxArray_real_T *b_V;
  emxArray_real_T *b_Y;
  emxArray_real_T *b_absdiff;
  emxArray_real_T *b_b;
  emxArray_real_T *b_d;
  emxArray_real_T *b_lin;
  emxArray_real_T *b_r;
  emxArray_real_T *b_rr;
  emxArray_real_T *b_scale;
  emxArray_real_T *b_tau;
  emxArray_real_T *b_trend;
  emxArray_real_T *b_v;
  emxArray_real_T *b_vright;
  emxArray_real_T *b_w;
  emxArray_real_T *b_wi;
  emxArray_real_T *b_wimag;
  emxArray_real_T *b_wr;
  emxArray_real_T *b_wreal;
  emxArray_real_T *b_x;
  emxArray_real_T *b_y;
  emxArray_real_T *b_z;
  emxArray_real_T *c_A;
  emxArray_real_T *c_B;
  emxArray_real_T *c_V;
  emxArray_real_T *c_absdiff;
  emxArray_real_T *c_b;
  emxArray_real_T *c_d;
  emxArray_real_T *c_r;
  emxArray_real_T *c_tau;
  emxArray_real_T *c_wi;
  emxArray_real_T *c_wr;
  emxArray_real_T *c_x;
  emxArray_real_T *c_y;
  emxArray_real_T *d;
  emxArray_real_T *d_A;
  emxArray_real_T *d_B;
  emxArray_real_T *d_D;
  emxArray_real_T *d_a;
  emxArray_real_T *d_r;
  emxArray_real_T *d_tau;
  emxArray_real_T *d_wi;
  emxArray_real_T *d_wr;
  emxArray_real_T *d_x;
  emxArray_real_T *d_y;
  emxArray_real_T *dv;
  emxArray_real_T *dv1;
  emxArray_real_T *dv13;
  emxArray_real_T *dv7;
  emxArray_real_T *e_A;
  emxArray_real_T *e_V;
  emxArray_real_T *e_tau;
  emxArray_real_T *e_x;
  emxArray_real_T *e_y;
  emxArray_real_T *f_A;
  emxArray_real_T *f_V;
  emxArray_real_T *f_tau;
  emxArray_real_T *f_x;
  emxArray_real_T *f_y;
  emxArray_real_T *g_A;
  emxArray_real_T *g_V;
  emxArray_real_T *g_x;
  emxArray_real_T *g_y;
  emxArray_real_T *h_A;
  emxArray_real_T *h_V;
  emxArray_real_T *h_x;
  emxArray_real_T *h_y;
  emxArray_real_T *i_A;
  emxArray_real_T *i_x;
  emxArray_real_T *i_y;
  emxArray_real_T *j_A;
  emxArray_real_T *j_x;
  emxArray_real_T *j_y;
  emxArray_real_T *k_A;
  emxArray_real_T *l_A;
  emxArray_real_T *lin;
  emxArray_real_T *m_A;
  emxArray_real_T *minval;
  emxArray_real_T *n_A;
  emxArray_real_T *r;
  emxArray_real_T *rr;
  emxArray_real_T *scale;
  emxArray_real_T *tau;
  emxArray_real_T *trend;
  emxArray_real_T *v;
  emxArray_real_T *vright;
  emxArray_real_T *wi;
  emxArray_real_T *wimag;
  emxArray_real_T *wr;
  emxArray_real_T *wreal;
  emxArray_real_T *y;
  emxArray_real_T *yy;
  emxArray_real_T *z;
  creal_T *gpu_dc;
  real_T abnrm;
  real_T d2scaled;
  real_T rconde;
  real_T rcondv;
  real_T *gpu_abnrm;
  real_T *gpu_d2scaled;
  int32_T i;
  int32_T i13;
  int32_T n;
  int32_T *gpu_n;
  uint32_T sz[2];
  boolean_T A_dirtyOnCpu;
  boolean_T A_dirtyOnGpu;
  boolean_T D_dirtyOnCpu;
  boolean_T D_dirtyOnGpu;
  boolean_T U_dirtyOnCpu;
  boolean_T U_dirtyOnGpu;
  boolean_T V_dirtyOnCpu;
  boolean_T V_dirtyOnGpu;
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
  boolean_T b_W_dirtyOnGpu;
  boolean_T b_Y_dirtyOnCpu;
  boolean_T b_Y_dirtyOnGpu;
  boolean_T b_a_dirtyOnCpu;
  boolean_T b_b_dirtyOnCpu;
  boolean_T b_d_dirtyOnCpu;
  boolean_T b_d_dirtyOnGpu;
  boolean_T b_dirtyOnCpu;
  boolean_T b_dirtyOnGpu;
  boolean_T b_ipiv_dirtyOnCpu;
  boolean_T b_ipiv_dirtyOnGpu;
  boolean_T b_jpvt_dirtyOnCpu;
  boolean_T b_jpvt_dirtyOnGpu;
  boolean_T b_lin_dirtyOnCpu;
  boolean_T b_lin_dirtyOnGpu;
  boolean_T b_r_dirtyOnCpu;
  boolean_T b_r_dirtyOnGpu;
  boolean_T b_rr_dirtyOnCpu;
  boolean_T b_rr_dirtyOnGpu;
  boolean_T b_tau_dirtyOnCpu;
  boolean_T b_tau_dirtyOnGpu;
  boolean_T b_v_dirtyOnGpu;
  boolean_T b_vright_dirtyOnCpu;
  boolean_T b_w_dirtyOnGpu;
  boolean_T b_wimag_dirtyOnCpu;
  boolean_T b_wreal_dirtyOnCpu;
  boolean_T b_x_dirtyOnCpu;
  boolean_T b_x_dirtyOnGpu;
  boolean_T b_y_dirtyOnCpu;
  boolean_T b_y_dirtyOnGpu;
  boolean_T b_z_dirtyOnCpu;
  boolean_T b_z_dirtyOnGpu;
  boolean_T bv1_dirtyOnGpu;
  boolean_T bv2_dirtyOnGpu;
  boolean_T bv4_dirtyOnGpu;
  boolean_T bv5_dirtyOnGpu;
  boolean_T bv6_dirtyOnGpu;
  boolean_T bv_dirtyOnGpu;
  boolean_T c_A_dirtyOnCpu;
  boolean_T c_A_dirtyOnGpu;
  boolean_T c_D_dirtyOnCpu;
  boolean_T c_D_dirtyOnGpu;
  boolean_T c_V_dirtyOnCpu;
  boolean_T c_V_dirtyOnGpu;
  boolean_T c_b_dirtyOnCpu;
  boolean_T c_d_dirtyOnCpu;
  boolean_T c_d_dirtyOnGpu;
  boolean_T c_r_dirtyOnGpu;
  boolean_T c_tau_dirtyOnCpu;
  boolean_T c_tau_dirtyOnGpu;
  boolean_T c_x_dirtyOnCpu;
  boolean_T c_x_dirtyOnGpu;
  boolean_T c_y_dirtyOnCpu;
  boolean_T c_y_dirtyOnGpu;
  boolean_T d_A_dirtyOnGpu;
  boolean_T d_D_dirtyOnCpu;
  boolean_T d_D_dirtyOnGpu;
  boolean_T d_V_dirtyOnCpu;
  boolean_T d_V_dirtyOnGpu;
  boolean_T d_dirtyOnCpu;
  boolean_T d_dirtyOnGpu;
  boolean_T d_tau_dirtyOnCpu;
  boolean_T d_tau_dirtyOnGpu;
  boolean_T d_x_dirtyOnCpu;
  boolean_T d_x_dirtyOnGpu;
  boolean_T d_y_dirtyOnCpu;
  boolean_T d_y_dirtyOnGpu;
  boolean_T dc_dirtyOnGpu;
  boolean_T dv13_dirtyOnGpu;
  boolean_T dv7_dirtyOnGpu;
  boolean_T e_A_dirtyOnCpu;
  boolean_T e_A_dirtyOnGpu;
  boolean_T e_tau_dirtyOnGpu;
  boolean_T e_x_dirtyOnCpu;
  boolean_T e_x_dirtyOnGpu;
  boolean_T f_A_dirtyOnGpu;
  boolean_T f_tau_dirtyOnGpu;
  boolean_T f_x_dirtyOnCpu;
  boolean_T f_x_dirtyOnGpu;
  boolean_T g_x_dirtyOnCpu;
  boolean_T g_x_dirtyOnGpu;
  boolean_T h_x_dirtyOnCpu;
  boolean_T h_x_dirtyOnGpu;
  boolean_T i_x_dirtyOnCpu;
  boolean_T i_x_dirtyOnGpu;
  boolean_T ipiv_dirtyOnCpu;
  boolean_T ipiv_dirtyOnGpu;
  boolean_T iv10_dirtyOnCpu;
  boolean_T iv2_dirtyOnCpu;
  boolean_T iv4_dirtyOnCpu;
  boolean_T iv8_dirtyOnCpu;
  boolean_T iv9_dirtyOnCpu;
  boolean_T iv_dirtyOnCpu;
  boolean_T jpvt_dirtyOnCpu;
  boolean_T jpvt_dirtyOnGpu;
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
  boolean_T v_dirtyOnGpu;
  boolean_T vright_dirtyOnCpu;
  boolean_T w_dirtyOnCpu;
  boolean_T w_dirtyOnGpu;
  boolean_T wimag_dirtyOnCpu;
  boolean_T wreal_dirtyOnCpu;
  boolean_T x_dirtyOnCpu;
  boolean_T x_dirtyOnGpu;
  boolean_T y_dirtyOnCpu;
  boolean_T y_dirtyOnGpu;
  boolean_T yy_dirtyOnCpu;
  boolean_T yy_dirtyOnGpu;
  boolean_T z_dirtyOnCpu;
  boolean_T z_dirtyOnGpu;
  gpuEmxReset_int32_T(&gpu_iv10);
  gpuEmxReset_boolean_T(&gpu_bv6);
  gpuEmxReset_real_T(&j_gpu_y);
  gpuEmxReset_real_T(&c_gpu_absdiff);
  gpuEmxReset_real_T(&c_gpu_d);
  gpuEmxReset_int32_T(&gpu_iv9);
  gpuEmxReset_boolean_T(&gpu_bv5);
  gpuEmxReset_int32_T(&gpu_iv8);
  gpuEmxReset_boolean_T(&gpu_bv4);
  gpuEmxReset_real_T(&d_gpu_a);
  gpuEmxReset_real_T(&b_gpu_trend);
  gpuEmxReset_real_T(&j_gpu_x);
  gpuEmxReset_real_T(&c_gpu_b);
  gpuEmxReset_real_T(&i_gpu_y);
  gpuEmxReset_real_T(&h_gpu_y);
  gpuEmxReset_int8_T(&c_gpu_a);
  gpuEmxReset_real_T(&g_gpu_y);
  gpuEmxReset_real_T(&f_gpu_y);
  gpuEmxReset_int8_T(&b_gpu_a);
  gpuEmxReset_real_T(&b_gpu_absdiff);
  gpuEmxReset_real_T(&gpu_yy);
  gpuEmxReset_real_T(&b_gpu_Y);
  gpuEmxReset_real_T(&f_gpu_tau);
  gpuEmxReset_real_T(&b_gpu_d);
  gpuEmxReset_real_T(&b_gpu_z);
  gpuEmxReset_real_T(&gpu_dv13);
  gpuEmxReset_int32_T(&b_gpu_jpvt);
  gpuEmxReset_real_T(&e_gpu_y);
  gpuEmxReset_int32_T(&b_gpu_ipiv);
  gpuEmxReset_real_T(&d_gpu_B);
  gpuEmxReset_real_T(&c_gpu_B);
  gpuEmxReset_real_T(&n_gpu_A);
  gpuEmxReset_int32_T(&gpu_iv4);
  gpuEmxReset_int32_T(&b_gpu_ipiv_t);
  gpuEmxReset_boolean_T(&gpu_bv2);
  gpuEmxReset_real_T(&m_gpu_A);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_real_T(&gpu_absdiff);
  gpuEmxReset_real_T(&gpu_Y);
  gpuEmxReset_real_T(&l_gpu_A);
  gpuEmxReset_real_T(&e_gpu_tau);
  gpuEmxReset_real_T(&gpu_d);
  gpuEmxReset_real_T(&b_gpu_b);
  gpuEmxReset_real_T(&k_gpu_A);
  gpuEmxReset_real_T(&gpu_dv7);
  gpuEmxReset_int32_T(&gpu_jpvt);
  gpuEmxReset_real_T(&j_gpu_A);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_int32_T(&gpu_ipiv);
  gpuEmxReset_real_T(&b_gpu_B);
  gpuEmxReset_real_T(&gpu_B);
  gpuEmxReset_real_T(&i_gpu_A);
  gpuEmxReset_int32_T(&gpu_ipiv_t);
  gpuEmxReset_real_T(&h_gpu_V);
  gpuEmxReset_int32_T(&gpu_iv2);
  gpuEmxReset_real_T(&h_gpu_A);
  gpuEmxReset_real_T(&b_gpu_vright);
  gpuEmxReset_real_T(&d_gpu_tau);
  gpuEmxReset_creal_T(&b_gpu_W);
  gpuEmxReset_real_T(&b_gpu_wreal);
  gpuEmxReset_real_T(&b_gpu_wimag);
  gpuEmxReset_real_T(&g_gpu_A);
  gpuEmxReset_real_T(&c_gpu_tau);
  gpuEmxReset_boolean_T(&gpu_bv1);
  gpuEmxReset_real_T(&d_gpu_D);
  gpuEmxReset_real_T(&b_gpu_U);
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_real_T(&g_gpu_V);
  gpuEmxReset_real_T(&f_gpu_A);
  gpuEmxReset_real_T(&b_gpu_v);
  gpuEmxReset_creal_T(&c_gpu_D);
  gpuEmxReset_real_T(&f_gpu_V);
  gpuEmxReset_creal_T(&e_gpu_V);
  gpuEmxReset_real_T(&e_gpu_A);
  gpuEmxReset_real_T(&d_gpu_A);
  gpuEmxReset_real_T(&d_gpu_V);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_real_T(&gpu_vright);
  gpuEmxReset_real_T(&c_gpu_A);
  gpuEmxReset_real_T(&b_gpu_rr);
  gpuEmxReset_real_T(&b_gpu_tau);
  gpuEmxReset_real_T(&d_gpu_r);
  gpuEmxReset_creal_T(&gpu_W);
  mwCudaMalloc(&gpu_n, 4UL);
  gpuEmxReset_real_T(&gpu_wreal);
  gpuEmxReset_real_T(&gpu_wimag);
  gpuEmxReset_real_T(&gpu_tau);
  gpuEmxReset_boolean_T(&gpu_bv);
  gpuEmxReset_real_T(&b_gpu_D);
  gpuEmxReset_real_T(&gpu_U);
  gpuEmxReset_real_T(&c_gpu_V);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_real_T(&i_gpu_x);
  gpuEmxReset_real_T(&gpu_v);
  gpuEmxReset_creal_T(&gpu_D);
  gpuEmxReset_real_T(&b_gpu_V);
  gpuEmxReset_creal_T(&gpu_V);
  gpuEmxReset_real_T(&h_gpu_x);
  gpuEmxReset_real_T(&b_gpu_A);
  gpuEmxReset_real_T(&g_gpu_x);
  gpuEmxReset_real_T(&gpu_A);
  gpuEmxReset_real_T(&gpu_rr);
  gpuEmxReset_real_T(&c_gpu_r);
  gpuEmxReset_real_T(&b_gpu_r);
  mwCudaMalloc(&gpu_abnrm, 8UL);
  gpuEmxReset_real_T(&gpu_dv1);
  gpuEmxReset_real_T(&b_gpu_lin);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&f_gpu_x);
  gpuEmxReset_real_T(&e_gpu_x);
  gpuEmxReset_real_T(&d_gpu_x);
  gpuEmxReset_real_T(&gpu_minval);
  gpuEmxReset_real_T(&gpu_z);
  gpuEmxReset_real_T(&gpu_r);
  gpuEmxReset_real_T(&gpu_dv);
  gpuEmxReset_real_T(&gpu_lin);
  mwCudaMalloc(&gpu_d2scaled, 8UL);
  gpuEmxReset_real_T(&gpu_a);
  gpuEmxReset_real_T(&gpu_trend);
  gpuEmxReset_real_T(&c_gpu_x);
  gpuEmxReset_real_T(&b_gpu_w);
  gpuEmxReset_real_T(&gpu_w);
  gpuEmxReset_real_T(&b_gpu_x);
  gpuEmxReset_real_T(&gpu_x);
  mwCudaMalloc(&gpu_dc, 16UL);
  bv6_dirtyOnGpu = false;
  c_d_dirtyOnGpu = false;
  bv5_dirtyOnGpu = false;
  bv4_dirtyOnGpu = false;
  b_dirtyOnGpu = false;
  d_y_dirtyOnGpu = false;
  c_y_dirtyOnGpu = false;
  yy_dirtyOnGpu = false;
  b_Y_dirtyOnGpu = false;
  f_tau_dirtyOnGpu = false;
  b_d_dirtyOnGpu = false;
  b_z_dirtyOnGpu = false;
  dv13_dirtyOnGpu = false;
  b_jpvt_dirtyOnGpu = false;
  b_ipiv_dirtyOnGpu = false;
  f_A_dirtyOnGpu = false;
  bv2_dirtyOnGpu = false;
  Y_dirtyOnGpu = false;
  e_tau_dirtyOnGpu = false;
  d_dirtyOnGpu = false;
  e_A_dirtyOnGpu = false;
  dv7_dirtyOnGpu = false;
  jpvt_dirtyOnGpu = false;
  ipiv_dirtyOnGpu = false;
  d_A_dirtyOnGpu = false;
  d_tau_dirtyOnGpu = false;
  b_W_dirtyOnGpu = false;
  c_tau_dirtyOnGpu = false;
  bv1_dirtyOnGpu = false;
  d_D_dirtyOnGpu = false;
  b_U_dirtyOnGpu = false;
  d_V_dirtyOnGpu = false;
  c_A_dirtyOnGpu = false;
  b_v_dirtyOnGpu = false;
  c_D_dirtyOnGpu = false;
  c_V_dirtyOnGpu = false;
  b_A_dirtyOnGpu = false;
  b_rr_dirtyOnGpu = false;
  b_tau_dirtyOnGpu = false;
  W_dirtyOnGpu = false;
  tau_dirtyOnGpu = false;
  bv_dirtyOnGpu = false;
  b_D_dirtyOnGpu = false;
  U_dirtyOnGpu = false;
  b_V_dirtyOnGpu = false;
  b_y_dirtyOnGpu = false;
  i_x_dirtyOnGpu = false;
  v_dirtyOnGpu = false;
  D_dirtyOnGpu = false;
  V_dirtyOnGpu = false;
  h_x_dirtyOnGpu = false;
  A_dirtyOnGpu = false;
  g_x_dirtyOnGpu = false;
  rr_dirtyOnGpu = false;
  c_r_dirtyOnGpu = false;
  b_r_dirtyOnGpu = false;
  b_lin_dirtyOnGpu = false;
  y_dirtyOnGpu = false;
  f_x_dirtyOnGpu = false;
  e_x_dirtyOnGpu = false;
  d_x_dirtyOnGpu = false;
  minval_dirtyOnGpu = false;
  z_dirtyOnGpu = false;
  r_dirtyOnGpu = false;
  lin_dirtyOnGpu = false;
  a_dirtyOnGpu = false;
  trend_dirtyOnGpu = false;
  c_x_dirtyOnGpu = false;
  b_w_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  iv10_dirtyOnCpu = false;
  c_d_dirtyOnCpu = false;
  iv9_dirtyOnCpu = false;
  iv8_dirtyOnCpu = false;
  c_b_dirtyOnCpu = false;
  d_y_dirtyOnCpu = false;
  c_y_dirtyOnCpu = false;
  b_y_dirtyOnCpu = false;
  y_dirtyOnCpu = false;
  b_a_dirtyOnCpu = false;
  yy_dirtyOnCpu = false;
  b_Y_dirtyOnCpu = false;
  b_d_dirtyOnCpu = false;
  b_z_dirtyOnCpu = false;
  b_jpvt_dirtyOnCpu = false;
  b_ipiv_dirtyOnCpu = false;
  iv4_dirtyOnCpu = false;
  Y_dirtyOnCpu = false;
  d_dirtyOnCpu = false;
  b_b_dirtyOnCpu = false;
  e_A_dirtyOnCpu = false;
  jpvt_dirtyOnCpu = false;
  ipiv_dirtyOnCpu = false;
  iv2_dirtyOnCpu = false;
  b_vright_dirtyOnCpu = false;
  d_tau_dirtyOnCpu = false;
  b_wreal_dirtyOnCpu = false;
  b_wimag_dirtyOnCpu = false;
  c_tau_dirtyOnCpu = false;
  d_D_dirtyOnCpu = false;
  b_U_dirtyOnCpu = false;
  b_dirtyOnCpu = false;
  d_V_dirtyOnCpu = false;
  c_A_dirtyOnCpu = false;
  c_D_dirtyOnCpu = false;
  c_V_dirtyOnCpu = false;
  b_A_dirtyOnCpu = false;
  iv_dirtyOnCpu = false;
  vright_dirtyOnCpu = false;
  b_rr_dirtyOnCpu = false;
  b_tau_dirtyOnCpu = false;
  wreal_dirtyOnCpu = false;
  wimag_dirtyOnCpu = false;
  tau_dirtyOnCpu = false;
  b_D_dirtyOnCpu = false;
  U_dirtyOnCpu = false;
  b_V_dirtyOnCpu = false;
  i_x_dirtyOnCpu = false;
  D_dirtyOnCpu = false;
  V_dirtyOnCpu = false;
  h_x_dirtyOnCpu = false;
  A_dirtyOnCpu = false;
  g_x_dirtyOnCpu = false;
  rr_dirtyOnCpu = false;
  b_r_dirtyOnCpu = false;
  r_dirtyOnCpu = false;
  b_lin_dirtyOnCpu = false;
  f_x_dirtyOnCpu = false;
  e_x_dirtyOnCpu = false;
  d_x_dirtyOnCpu = false;
  z_dirtyOnCpu = false;
  lin_dirtyOnCpu = false;
  a_dirtyOnCpu = false;
  trend_dirtyOnCpu = false;
  c_x_dirtyOnCpu = false;
  b_x_dirtyOnCpu = false;
  w_dirtyOnGpu = false;
  w_dirtyOnCpu = true;
  x_dirtyOnGpu = false;
  x_dirtyOnCpu = true;
  cudaMemcpy(gpu_dc, &dc, 16UL, cudaMemcpyHostToDevice);
  ecc_detrend_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_dc);
  dc_dirtyOnGpu = true;
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
  // 'ecc_detrend:19' coder.gpu.kernelfun;
  //  trigger CUDA kernel generation
  // 'ecc_detrend:20' if order<1
  if (order < 1.0) {
    // 'ecc_detrend:20' ;
    // 'ecc_detrend:20' order=ones(1,"like",order);
    order = 1.0;
  }

  // 'ecc_detrend:21' if thr<1
  if (thr < 1.0) {
    // 'ecc_detrend:21' ;
    // 'ecc_detrend:21' thr=ones(1,"like",thr);
    thr = 1.0;
  }

  // 'ecc_detrend:22' if nItr<1
  if (nItr < 1.0) {
    // 'ecc_detrend:22' ;
    // 'ecc_detrend:22' nItr=ones(1,"like",nItr);
    nItr = 1.0;
  }

  //  Detrend per channel
  // 'ecc_detrend:25' nChs = size(x,2);
  // 'ecc_detrend:26' for ch = 1:nChs
  i = x->size[1];
  emxInit_real_T(&b_x, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&b_w, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&c_x, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&trend, 1, &h_emlrtRTEI, true);
  emxInit_real_T(&r, 2, &wd_emlrtRTEI, true);
  emxInit_real_T(&a, 1, &j_emlrtRTEI, true);
  emxInit_real_T(&lin, 2, &xd_emlrtRTEI, true);
  emxInit_real_T(&z, 1, &yd_emlrtRTEI, true);
  emxInit_real_T(&dv, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&minval, 1, &ae_emlrtRTEI, true);
  emxInit_real_T(&d_x, 1, &n_emlrtRTEI, true);
  emxInit_real_T(&e_x, 1, &n_emlrtRTEI, true);
  emxInit_real_T(&b_r, 2, &wd_emlrtRTEI, true);
  emxInit_real_T(&y, 2, &be_emlrtRTEI, true);
  emxInit_real_T(&f_x, 2, &n_emlrtRTEI, true);
  emxInit_real_T(&b_lin, 2, &xd_emlrtRTEI, true);
  emxInit_real_T(&b_z, 1, &yd_emlrtRTEI, true);
  emxInit_real_T(&dv1, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&c_r, 2, &ce_emlrtRTEI, true);
  emxInit_real_T(&rr, 2, &r_emlrtRTEI, true);
  emxInit_real_T(&A, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&b_A, 2, &s_emlrtRTEI, true);
  emxInit_real_T(&g_x, 1, &n_emlrtRTEI, true);
  emxInit_creal_T(&V, 2, &vd_emlrtRTEI, true);
  emxInit_creal_T(&D, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&b_V, 2, &de_emlrtRTEI, true);
  emxInit_real_T(&v, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&b_D, 1, &ee_emlrtRTEI, true);
  emxInit_real_T(&h_x, 1, &n_emlrtRTEI, true);
  emxInit_boolean_T(&bv, 1, &nb_emlrtRTEI, true);
  emxInit_int32_T(&iv, 1, &nb_emlrtRTEI, true);
  emxInit_real_T(&c_V, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&b_y, 2, &be_emlrtRTEI, true);
  emxInit_real_T(&i_x, 2, &n_emlrtRTEI, true);
  emxInit_real_T(&scale, 1, &fe_emlrtRTEI, true);
  emxInit_real_T(&tau, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&U, 2, &vd_emlrtRTEI, true);
  emxInit_creal_T(&W, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&c_A, 2, &ic_emlrtRTEI, true);
  emxInit_real_T(&wreal, 1, &ge_emlrtRTEI, true);
  emxInit_real_T(&b_tau, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&d_A, 2, &s_emlrtRTEI, true);
  emxInit_real_T(&wimag, 1, &he_emlrtRTEI, true);
  emxInit_real_T(&vright, 2, &ie_emlrtRTEI, true);
  emxInit_real_T(&wr, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&b, 2, &ke_emlrtRTEI, true);
  emxInit_real_T(&wi, 2, &le_emlrtRTEI, true);
  emxInit_real_T(&b_rr, 2, &r_emlrtRTEI, true);
  emxInit_real_T(&e_A, 2, &s_emlrtRTEI, true);
  emxInit_real_T(&f_A, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&g_A, 2, &s_emlrtRTEI, true);
  emxInit_real_T(&b_wr, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&b_wi, 2, &le_emlrtRTEI, true);
  emxInit_real_T(&h_A, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&Y, 1, &me_emlrtRTEI, true);
  emxInit_creal_T(&d_V, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&i_A, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&B, 1, &oc_emlrtRTEI, true);
  emxInit_int32_T(&ipiv, 2, &vd_emlrtRTEI, true);
  emxInit_creal_T(&c_D, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&b_B, 1, &pc_emlrtRTEI, true);
  emxInit_int32_T(&jpvt, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&e_V, 2, &de_emlrtRTEI, true);
  emxInit_int32_T(&ipiv_t, 1, &ne_emlrtRTEI, true);
  emxInit_real_T(&c_tau, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&c_y, 1, &oe_emlrtRTEI, true);
  emxInit_real_T(&b_v, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&d_D, 1, &ee_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &tc_emlrtRTEI, true);
  emxInit_real_T(&dv7, 1, &vd_emlrtRTEI, true);
  emxInit_boolean_T(&bv1, 1, &nb_emlrtRTEI, true);
  emxInit_real_T(&d, 1, &wc_emlrtRTEI, true);
  emxInit_int32_T(&iv2, 1, &nb_emlrtRTEI, true);
  emxInit_real_T(&f_V, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&absdiff, 1, &pe_emlrtRTEI, true);
  emxInit_real_T(&d_y, 1, &bd_emlrtRTEI, true);
  emxInit_real_T(&b_scale, 1, &fe_emlrtRTEI, true);
  emxInit_real_T(&d_tau, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&b_U, 2, &vd_emlrtRTEI, true);
  emxInit_creal_T(&b_W, 1, &vd_emlrtRTEI, true);
  emxInit_boolean_T(&bv2, 1, &bd_emlrtRTEI, true);
  emxInit_real_T(&j_A, 2, &ic_emlrtRTEI, true);
  emxInit_real_T(&b_wreal, 1, &ge_emlrtRTEI, true);
  emxInit_real_T(&e_tau, 1, &vd_emlrtRTEI, true);
  emxInit_int32_T(&iv4, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&k_A, 2, &s_emlrtRTEI, true);
  emxInit_real_T(&b_wimag, 1, &he_emlrtRTEI, true);
  emxInit_real_T(&b_vright, 2, &ie_emlrtRTEI, true);
  emxInit_real_T(&c_wr, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&b_b, 2, &ke_emlrtRTEI, true);
  emxInit_real_T(&c_wi, 2, &le_emlrtRTEI, true);
  emxInit_real_T(&l_A, 2, &s_emlrtRTEI, true);
  emxInit_real_T(&d_wr, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&d_wi, 2, &le_emlrtRTEI, true);
  emxInit_real_T(&m_A, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&b_Y, 1, &me_emlrtRTEI, true);
  emxInit_real_T(&n_A, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&c_B, 1, &oc_emlrtRTEI, true);
  emxInit_int32_T(&b_ipiv, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&d_B, 1, &pc_emlrtRTEI, true);
  emxInit_int32_T(&b_jpvt, 2, &vd_emlrtRTEI, true);
  emxInit_int32_T(&b_ipiv_t, 1, &ne_emlrtRTEI, true);
  emxInit_real_T(&f_tau, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&e_y, 1, &oe_emlrtRTEI, true);
  emxInit_ptrdiff_t(&b_jpvt_t, 1, &tc_emlrtRTEI, true);
  emxInit_real_T(&dv13, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&b_d, 1, &wc_emlrtRTEI, true);
  emxInit_real_T(&b_absdiff, 1, &pe_emlrtRTEI, true);
  emxInit_real_T(&yy, 1, &ed_emlrtRTEI, true);
  emxInit_int8_T(&b_a, 2, &fd_emlrtRTEI, true);
  emxInit_real_T(&f_y, 2, &qe_emlrtRTEI, true);
  emxInit_real_T(&g_y, 2, &re_emlrtRTEI, true);
  emxInit_real_T(&h_y, 2, &se_emlrtRTEI, true);
  emxInit_real_T(&c_b, 1, &jd_emlrtRTEI, true);
  emxInit_real_T(&i_y, 2, &te_emlrtRTEI, true);
  emxInit_int8_T(&c_a, 2, &hd_emlrtRTEI, true);
  emxInit_boolean_T(&bv4, 1, &qd_emlrtRTEI, true);
  emxInit_int32_T(&iv8, 1, &vd_emlrtRTEI, true);
  emxInit_boolean_T(&bv5, 1, &sd_emlrtRTEI, true);
  emxInit_int32_T(&iv9, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&c_d, 1, &td_emlrtRTEI, true);
  emxInit_real_T(&c_absdiff, 1, &pe_emlrtRTEI, true);
  emxInit_real_T(&j_y, 1, &ud_emlrtRTEI, true);
  emxInit_boolean_T(&bv6, 1, &ud_emlrtRTEI, true);
  emxInit_int32_T(&iv10, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&g_V, 2, &ub_emlrtRTEI, true);
  emxInit_real_T(&d_r, 2, &yb_emlrtRTEI, true);
  emxInit_real_T(&h_V, 2, &ub_emlrtRTEI, true);
  emxInit_real_T(&j_x, 1, &nd_emlrtRTEI, true);
  emxInit_real_T(&b_trend, 1, &od_emlrtRTEI, true);
  emxInit_real_T(&d_a, 1, &pd_emlrtRTEI, true);
  for (int32_T ch{0}; ch < i; ch++) {
    int32_T b_i;
    int32_T npages;
    int32_T nx;
    int32_T vlen;
    int32_T w_dim0;
    boolean_T validLaunchParams;

    // 'ecc_detrend:27' [x(:,ch),w(:,ch)] = detrendCh_lfn(x(:,ch),w(:,ch),order,thr,nItr,winSz);
    //  % Run detrend
    //  if ~nnz(winSz)
    //      % Standard detrending (trend fit to entire data)
    //      [x,w] = detrend_lfn(x,w,order,thr,nItr);
    //  else
    //      % Overlapping window detrending
    //      [x,w] = detrendWin_lfn(x,w,order,thr,nItr,winSz);
    //  end
    // %%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    // 'ecc_detrend:46' x=squeeze(x);
    vlen = x->size[0];
    b_i = b_x->size[0];
    b_x->size[0] = vlen;
    emxEnsureCapacity_real_T(b_x, b_i, &b_emlrtRTEI);
    if (!b_x_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real_T(b_x, &b_gpu_x);
    }

    nx = x->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((vlen - 1) +
      1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
      }

      x_dirtyOnCpu = false;
      if (b_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
      }

      ecc_detrend_kernel2<<<grid, block>>>(ch, gpu_x, vlen, nx, b_gpu_x);
      b_x_dirtyOnCpu = false;
      b_x_dirtyOnGpu = true;
    }

    // 'ecc_detrend:46' w=squeeze(w);
    vlen = w->size[0];
    b_i = b_w->size[0];
    b_w->size[0] = vlen;
    emxEnsureCapacity_real_T(b_w, b_i, &c_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_w, &b_gpu_w);
    w_dim0 = w->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((vlen - 1) +
      1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (w_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, w);
      }

      w_dirtyOnCpu = false;
      ecc_detrend_kernel3<<<grid, block>>>(ch, gpu_w, vlen, w_dim0, b_gpu_w);
      b_w_dirtyOnGpu = true;
    }

    // 'ecc_detrend:47' if ~nnz(w)
    w_dim0 = 0;
    vlen = w->size[0];
    for (npages = 0; npages < vlen; npages++) {
      if (w_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(w, &gpu_w);
      }

      w_dirtyOnGpu = false;
      if (w->data[npages + w->size[0] * ch] != 0.0) {
        w_dim0++;
      }
    }

    if (w_dim0 == 0) {
      // 'ecc_detrend:47' ;
      // 'ecc_detrend:47' w(:)=1;
      b_i = b_w->size[0];
      b_w->size[0] = w->size[0];
      emxEnsureCapacity_real_T(b_w, b_i, &d_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_w, &b_gpu_w);
      b_i = w->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_detrend_kernel4<<<grid, block>>>(b_i, b_gpu_w);
        b_w_dirtyOnGpu = true;
      }
    }

    //  Run detrend
    // 'ecc_detrend:50' if ~nnz(winSz)
    if (winSz != 0.0) {
      int32_T i2;
      uint32_T dims_idx_0;

      // 'ecc_detrend:53' else
      //  Overlapping window detrending
      // 'ecc_detrend:55' [x,w] = detrendWin_lfn(x,w,order,thr,nItr,winSz);
      //  Detrend across overlapping time windows
      // 'ecc_detrend:98' dims = size(x);
      b_i = x->size[0];
      dims_idx_0 = static_cast<uint32_T>(b_i);

      // 'ecc_detrend:99' y = coder.nullcopy(zeros(size(x),'like',x));
      vlen = c_x->size[0];
      c_x->size[0] = b_i;
      emxEnsureCapacity_real_T(c_x, vlen, &e_emlrtRTEI);
      if (!c_x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(c_x, &c_gpu_x);
      }

      //  1) divide into windows, 2) detrend each, 3) stitch together, 4) estimate w
      // 'ecc_detrend:102' for iIter = 1:nItr
      i2 = static_cast<int32_T>(nItr);
      if (static_cast<int32_T>(nItr) - 1 >= 0) {
        i13 = static_cast<int32_T>(order);
      }

      for (int32_T iIter{0}; iIter < i2; iIter++) {
        real_T offset;
        real_T stop;
        boolean_T abnrm_dirtyOnGpu;

        // 'ecc_detrend:103' trend = zeros(dims,'like',x);
        b_i = trend->size[0];
        trend->size[0] = static_cast<int32_T>(dims_idx_0);
        emxEnsureCapacity_real_T(trend, b_i, &h_emlrtRTEI);
        if (!trend_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(trend, &gpu_trend);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(dims_idx_0) - 1) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          if (trend_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
          }

          ecc_detrend_kernel84<<<grid, block>>>(dims_idx_0, gpu_trend);
          trend_dirtyOnCpu = false;
          trend_dirtyOnGpu = true;
        }

        // 'ecc_detrend:104' a = zeros(dims(1),1,'like',x);
        b_i = a->size[0];
        a->size[0] = static_cast<int32_T>(dims_idx_0);
        emxEnsureCapacity_real_T(a, b_i, &j_emlrtRTEI);
        if (!a_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(a, &gpu_a);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(dims_idx_0) - 1) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          if (a_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, a);
          }

          ecc_detrend_kernel85<<<grid, block>>>(dims_idx_0, gpu_a);
          a_dirtyOnCpu = false;
          a_dirtyOnGpu = true;
        }

        // 'ecc_detrend:105' offset = 0;
        offset = 0.0;

        // 'ecc_detrend:106' while true
        real_T start;
        do {
          real_T b_mn;
          real_T mn;
          real_T wsize2;
          int32_T i_V[2];
          int32_T exitg1;
          int32_T i11;
          int32_T i12;
          int32_T i7;
          int32_T ii;
          int32_T jend;
          int32_T r_dim0;
          boolean_T d2scaled_dirtyOnCpu;
          boolean_T n_dirtyOnCpu;

          // 'ecc_detrend:107' start = offset+1;
          start = offset + 1.0;

          // 'ecc_detrend:108' stop = min(dims(1),offset+winSz);
          stop = std::fmin(static_cast<real_T>(dims_idx_0), offset + winSz);

          //  if not enough valid samples grow window:
          // 'ecc_detrend:111' counter = 5;
          npages = 5;

          // 'ecc_detrend:112' while any(sum(min(w(start:stop),2))) < winSz
          do {
            exitg1 = 0;
            if (start > stop) {
              jend = 1;
              vlen = 0;
            } else {
              jend = static_cast<int32_T>(start);
              vlen = static_cast<int32_T>(stop);
            }

            b_i = minval->size[0];
            minval->size[0] = (vlen - jend) + 1;
            emxEnsureCapacity_real_T(minval, b_i, &k_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(minval, &gpu_minval);
            nx = vlen - jend;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_detrend_kernel86<<<grid, block>>>(b_gpu_w, jend, nx,
                gpu_minval);
              minval_dirtyOnGpu = true;
            }

            vlen = minval->size[0];
            if (minval->size[0] == 0) {
              abnrm = 0.0;
            } else {
              if (minval_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(minval, &gpu_minval);
              }

              minval_dirtyOnGpu = false;
              abnrm = minval->data[0];
              for (b_i = 0; b_i <= vlen - 2; b_i++) {
                abnrm += minval->data[b_i + 1];
              }
            }

            if ((abnrm == 0.0) || std::isnan(abnrm)) {
              validLaunchParams = true;
            } else {
              validLaunchParams = false;
            }

            if (((!validLaunchParams) < winSz) && (npages > 0)) {
              // 'ecc_detrend:113' if counter <= 0
              // 'ecc_detrend:114' start = max(1,start-winSz/2);
              start = std::fmax(1.0, start - winSz / 2.0);

              // 'ecc_detrend:115' stop = min(dims(1),stop+winSz/2);
              stop = std::fmin(static_cast<real_T>(dims_idx_0), stop + winSz /
                               2.0);

              // 'ecc_detrend:116' counter = counter-1;
              npages--;
            } else {
              exitg1 = 1;
            }
          } while (exitg1 == 0);

          // 'ecc_detrend:113' ;
          // 'ecc_detrend:118' if rem(stop-start+1,2)==1
          if (rt_remd_snf((stop - start) + 1.0, 2.0) == 1.0) {
            // 'ecc_detrend:118' ;
            // 'ecc_detrend:118' stop = stop-1;
            stop--;
          }

          // 'ecc_detrend:119' wsize2 = stop-start+1;
          wsize2 = (stop - start) + 1.0;

          //  detrend this window
          // 'ecc_detrend:122' yy = detrend_lfn(x(start:stop,:),w(start:stop,:),order,thr,1);
          if (start > stop) {
            i7 = 0;
            ii = -1;
            i11 = 1;
            i12 = 1;
          } else {
            i7 = static_cast<int32_T>(start) - 1;
            ii = static_cast<int32_T>(stop) - 1;
            i11 = static_cast<int32_T>(start);
            i12 = static_cast<int32_T>(stop) + 1;
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
          // 'ecc_detrend:74' nFrames = height(x);
          // 'ecc_detrend:75' r = coder.nullcopy(zeros(nFrames,order,'like',x));
          b_i = b_r->size[0] * b_r->size[1];
          b_r->size[0] = (ii - i7) + 1;
          b_r->size[1] = static_cast<int32_T>(order);
          emxEnsureCapacity_real_T(b_r, b_i, &f_emlrtRTEI);
          if (!b_r_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b_r, &c_gpu_r);
          }

          // 'ecc_detrend:76' lin = linspace(-1,1,nFrames);
          b_i = b_lin->size[0] * b_lin->size[1];
          b_lin->size[0] = 1;
          b_lin->size[1] = (ii - i7) + 1;
          emxEnsureCapacity_real_T(b_lin, b_i, &i_emlrtRTEI);
          if (!b_lin_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b_lin, &b_gpu_lin);
          }

          if (b_lin->size[1] >= 1) {
            if (b_lin_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_lin, &b_gpu_lin);
            }

            b_lin->data[b_lin->size[1] - 1] = 1.0;
            b_lin_dirtyOnGpu = false;
            b_lin_dirtyOnCpu = true;
            if (b_lin->size[1] >= 2) {
              b_lin->data[0] = -1.0;
              if (b_lin->size[1] >= 3) {
                d2scaled = 1.0 / (static_cast<real_T>(b_lin->size[1]) - 1.0);
                vlen = b_lin->size[1] - 3;
                b_i = b_lin->size[1];
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (vlen + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                             cudaMemcpyHostToDevice);
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_lin, b_lin);
                  ecc_detrend_kernel87<<<grid, block>>>(vlen, b_i, gpu_d2scaled,
                    b_gpu_lin);
                  b_lin_dirtyOnCpu = false;
                  b_lin_dirtyOnGpu = true;
                }

                if ((b_lin->size[1] & 1) == 1) {
                  b_i = b_lin->size[1];
                  if (b_lin_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_lin, b_lin);
                  }

                  ecc_detrend_kernel88<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (b_i, b_gpu_lin);
                  b_lin_dirtyOnCpu = false;
                  b_lin_dirtyOnGpu = true;
                }
              }
            }
          }

          // 'ecc_detrend:77' for k=1:order
          for (npages = 0; npages < i13; npages++) {
            // 'ecc_detrend:78' r(:,k) = lin.^k;
            b_i = dv1->size[0] * dv1->size[1];
            dv1->size[0] = 1;
            dv1->size[1] = b_lin->size[1];
            emxEnsureCapacity_real_T(dv1, b_i, &k_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv1, &gpu_dv1);
            nx = b_lin->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_lin_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_lin, b_lin);
              }

              b_lin_dirtyOnCpu = false;
              ecc_detrend_kernel89<<<grid, block>>>(npages, b_gpu_lin, nx,
                gpu_dv1);
            }

            jend = b_r->size[0];
            r_dim0 = b_r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((jend - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_r, b_r);
              }

              ecc_detrend_kernel90<<<grid, block>>>(gpu_dv1, npages, jend,
                r_dim0, c_gpu_r);
              b_r_dirtyOnCpu = false;
              c_r_dirtyOnGpu = true;
            }
          }

          //  Remove trends
          // 'ecc_detrend:82' z = coder.nullcopy(zeros(size(x),'like',x));
          // 'ecc_detrend:83' for ii = 1:nItr
          //  Weighted regression on basis
          // 'ecc_detrend:85' z = regw_lfn(x,w,r);
          //  Weighted Regression
          //   b: regression matrix (apply to r to approximate x)
          //   z: regression (r*b)
          //  discard dimensions of r with eigenvalue lower than this
          // 'ecc_detrend:165' thrPCA = 1e-7;
          // zeros(1,1,class(x));
          //  save weighted mean
          // 'ecc_detrend:168' mn = x - demean_lfn(x,w);
          //  Demean
          // 'ecc_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if ((ii - i7) + 1 == i12 - i11) {
            b_i = g_x->size[0];
            g_x->size[0] = (ii - i7) + 1;
            emxEnsureCapacity_real_T(g_x, b_i, &n_emlrtRTEI);
            if (!g_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(g_x, &g_gpu_x);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ii
              - i7) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
              }

              b_x_dirtyOnCpu = false;
              if (g_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_x, g_x);
              }

              ecc_detrend_kernel91<<<grid, block>>>(b_gpu_w, i11, b_gpu_x, i7,
                ii, g_gpu_x);
              g_x_dirtyOnCpu = false;
              g_x_dirtyOnGpu = true;
            }
          } else {
            if (g_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_x, &g_gpu_x);
            }

            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
            }

            b_x_dirtyOnGpu = false;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            binary_expand_op(g_x, b_x, i7, ii, b_w, i11, i12);
            g_x_dirtyOnGpu = false;
            g_x_dirtyOnCpu = true;
          }

          vlen = g_x->size[0];
          if (g_x->size[0] == 0) {
            abnrm = 0.0;
          } else {
            if (g_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_x, &g_gpu_x);
            }

            g_x_dirtyOnGpu = false;
            abnrm = g_x->data[0];
            for (b_i = 0; b_i <= vlen - 2; b_i++) {
              abnrm += g_x->data[b_i + 1];
            }
          }

          vlen = i12 - i11;
          if (i12 - i11 == 0) {
            d2scaled = 0.0;
          } else {
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            d2scaled = b_w->data[i11 - 1];
            for (b_i = 0; b_i <= vlen - 2; b_i++) {
              d2scaled += b_w->data[i11 + b_i];
            }
          }

          mn = abnrm / (d2scaled + 2.2204460492503131E-16);

          // 'ecc_detrend:188' x = x - mn;
          //  Fit weighted regression
          // 'ecc_detrend:171' x = demean_lfn(x,w).* w;
          //  Demean
          // 'ecc_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if ((ii - i7) + 1 == i12 - i11) {
            b_i = h_x->size[0];
            h_x->size[0] = (ii - i7) + 1;
            emxEnsureCapacity_real_T(h_x, b_i, &n_emlrtRTEI);
            if (!h_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(h_x, &h_gpu_x);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ii
              - i7) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
              }

              b_x_dirtyOnCpu = false;
              if (h_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_x, h_x);
              }

              ecc_detrend_kernel92<<<grid, block>>>(b_gpu_w, i11, b_gpu_x, i7,
                ii, h_gpu_x);
              h_x_dirtyOnCpu = false;
              h_x_dirtyOnGpu = true;
            }
          } else {
            if (h_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_x, &h_gpu_x);
            }

            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
            }

            b_x_dirtyOnGpu = false;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            binary_expand_op(h_x, b_x, i7, ii, b_w, i11, i12);
            h_x_dirtyOnGpu = false;
            h_x_dirtyOnCpu = true;
          }

          vlen = h_x->size[0];
          if (h_x->size[0] == 0) {
            abnrm = 0.0;
          } else {
            if (h_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_x, &h_gpu_x);
            }

            h_x_dirtyOnGpu = false;
            abnrm = h_x->data[0];
            for (b_i = 0; b_i <= vlen - 2; b_i++) {
              abnrm += h_x->data[b_i + 1];
            }
          }

          vlen = i12 - i11;
          if (i12 - i11 == 0) {
            d2scaled = 0.0;
          } else {
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            d2scaled = b_w->data[i11 - 1];
            for (b_i = 0; b_i <= vlen - 2; b_i++) {
              d2scaled += b_w->data[i11 + b_i];
            }
          }

          b_mn = abnrm / (d2scaled + 2.2204460492503131E-16);

          // 'ecc_detrend:188' x = x - mn;
          // 'ecc_detrend:172' r = demean_lfn(r,w);
          //  Demean
          // 'ecc_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if (b_r->size[0] == i12 - i11) {
            b_i = i_x->size[0] * i_x->size[1];
            i_x->size[0] = b_r->size[0];
            i_x->size[1] = b_r->size[1];
            emxEnsureCapacity_real_T(i_x, b_i, &n_emlrtRTEI);
            if (!i_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(i_x, &i_gpu_x);
            }

            w_dim0 = b_r->size[1] - 1;
            jend = b_r->size[0] - 1;
            nx = i_x->size[0];
            r_dim0 = b_r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((jend + 1L) * (w_dim0 + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_r, b_r);
              }

              b_r_dirtyOnCpu = false;
              if (i_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_x, i_x);
              }

              ecc_detrend_kernel93<<<grid, block>>>(b_gpu_w, i11, c_gpu_r, jend,
                w_dim0, nx, r_dim0, i_gpu_x);
              i_x_dirtyOnCpu = false;
              i_x_dirtyOnGpu = true;
            }
          } else {
            if (i_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(i_x, &i_gpu_x);
            }

            if (c_r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_r, &c_gpu_r);
            }

            c_r_dirtyOnGpu = false;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            binary_expand_op(i_x, b_r, b_w, i11, i12);
            i_x_dirtyOnGpu = false;
            i_x_dirtyOnCpu = true;
          }

          vlen = i_x->size[0];
          if ((i_x->size[0] == 0) || (i_x->size[1] == 0)) {
            for (b_i = 0; b_i < 2; b_i++) {
              sz[b_i] = static_cast<uint32_T>(i_x->size[b_i]);
            }

            b_i = b_y->size[0] * b_y->size[1];
            b_y->size[0] = 1;
            b_y->size[1] = static_cast<int32_T>(sz[1]);
            emxEnsureCapacity_real_T(b_y, b_i, &p_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_y, &b_gpu_y);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(sz[1]) - 1) + 1L), &grid, &block, 1024U,
              65535U);
            if (validLaunchParams) {
              ecc_detrend_kernel95<<<grid, block>>>(static_cast<int32_T>(sz[1])
                - 1, b_gpu_y);
              b_y_dirtyOnGpu = true;
            }
          } else {
            npages = i_x->size[1] - 1;
            b_i = b_y->size[0] * b_y->size[1];
            b_y->size[0] = 1;
            b_y->size[1] = i_x->size[1];
            emxEnsureCapacity_real_T(b_y, b_i, &o_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_y, &b_gpu_y);
            nx = i_x->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (i_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_x, i_x);
              }

              i_x_dirtyOnCpu = false;
              ecc_detrend_kernel94<<<grid, block>>>(vlen, i_gpu_x, npages, nx,
                b_gpu_y);
              b_y_dirtyOnGpu = true;
            }
          }

          vlen = i12 - i11;
          if (i12 - i11 == 0) {
            abnrm = 0.0;
            abnrm_dirtyOnGpu = false;
          } else {
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            abnrm = b_w->data[i11 - 1];
            abnrm_dirtyOnGpu = false;
            for (b_i = 0; b_i <= vlen - 2; b_i++) {
              abnrm += b_w->data[i11 + b_i];
            }
          }

          // 'ecc_detrend:188' x = x - mn;
          if (b_r->size[1] == b_y->size[1]) {
            abnrm += 2.2204460492503131E-16;
            b_i = d_r->size[0] * d_r->size[1];
            d_r->size[0] = b_r->size[0];
            d_r->size[1] = b_r->size[1];
            emxEnsureCapacity_real_T(d_r, b_i, &yb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_r, &d_gpu_r);
            w_dim0 = b_r->size[1] - 1;
            jend = b_r->size[0] - 1;
            r_dim0 = d_r->size[0];
            b_i = b_r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((jend + 1L) * (w_dim0 + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_r, b_r);
              }

              b_r_dirtyOnCpu = false;
              cudaMemcpy(gpu_abnrm, &abnrm, 8UL, cudaMemcpyHostToDevice);
              ecc_detrend_kernel96<<<grid, block>>>(b_gpu_y, c_gpu_r, jend,
                w_dim0, r_dim0, b_i, gpu_abnrm, d_gpu_r);
              abnrm_dirtyOnGpu = true;
            }

            b_i = b_r->size[0] * b_r->size[1];
            b_r->size[0] = d_r->size[0];
            b_r->size[1] = d_r->size[1];
            emxEnsureCapacity_real_T(b_r, b_i, &q_emlrtRTEI);
            if (!b_r_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_r, &c_gpu_r);
            }

            w_dim0 = d_r->size[0] * d_r->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (w_dim0 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_r, b_r);
              }

              ecc_detrend_kernel97<<<grid, block>>>(d_gpu_r, w_dim0, c_gpu_r);
              b_r_dirtyOnCpu = false;
              c_r_dirtyOnGpu = true;
            }
          } else {
            if (c_r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_r, &c_gpu_r);
            }

            if (b_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_y, &b_gpu_y);
            }

            b_y_dirtyOnGpu = false;
            binary_expand_op(b_r, b_y, abnrm);
            c_r_dirtyOnGpu = false;
            b_r_dirtyOnCpu = true;
          }

          //  remove channel-specific-weighted mean from regressor
          // 'ecc_detrend:173' rr = r.*w;
          if (b_r->size[0] == i12 - i11) {
            b_i = b_rr->size[0] * b_rr->size[1];
            b_rr->size[0] = b_r->size[0];
            b_rr->size[1] = b_r->size[1];
            emxEnsureCapacity_real_T(b_rr, b_i, &r_emlrtRTEI);
            if (!b_rr_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_rr, &b_gpu_rr);
            }

            w_dim0 = b_r->size[1] - 1;
            jend = b_r->size[0] - 1;
            nx = b_rr->size[0];
            r_dim0 = b_r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((jend + 1L) * (w_dim0 + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_r, b_r);
              }

              b_r_dirtyOnCpu = false;
              if (b_rr_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, b_rr);
              }

              ecc_detrend_kernel98<<<grid, block>>>(b_gpu_w, i11, c_gpu_r, jend,
                w_dim0, nx, r_dim0, b_gpu_rr);
              b_rr_dirtyOnCpu = false;
              b_rr_dirtyOnGpu = true;
            }
          } else {
            if (b_rr_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_rr, &b_gpu_rr);
            }

            if (c_r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_r, &c_gpu_r);
            }

            c_r_dirtyOnGpu = false;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            binary_expand_op(b_rr, b_r, b_w, i11, i12);
            b_rr_dirtyOnGpu = false;
            b_rr_dirtyOnCpu = true;
          }

          // 'ecc_detrend:174' [V,D] = eig(rr'*rr);
          b_i = g_A->size[0] * g_A->size[1];
          g_A->size[0] = b_rr->size[1];
          g_A->size[1] = b_rr->size[0];
          emxEnsureCapacity_real_T(g_A, b_i, &s_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(g_A, &c_gpu_A);
          w_dim0 = b_rr->size[0] - 1;
          b_i = b_rr->size[1] - 1;
          r_dim0 = g_A->size[0];
          nx = b_rr->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i +
            1L) * (w_dim0 + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, b_rr);
            }

            b_rr_dirtyOnCpu = false;
            ecc_detrend_kernel99<<<grid, block>>>(b_gpu_rr, b_i, w_dim0, r_dim0,
              nx, c_gpu_A);
          }

          if ((g_A->size[0] == 0) || (g_A->size[1] == 0) || (b_rr->size[0] == 0)
              || (b_rr->size[1] == 0)) {
            b_i = f_A->size[0] * f_A->size[1];
            f_A->size[0] = g_A->size[0];
            f_A->size[1] = b_rr->size[1];
            emxEnsureCapacity_real_T(f_A, b_i, &u_emlrtRTEI);
            if (!b_A_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(f_A, &d_gpu_A);
            }

            jend = g_A->size[0] * b_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(jend
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_A_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
              }

              ecc_detrend_kernel100<<<grid, block>>>(jend, d_gpu_A);
              b_A_dirtyOnCpu = false;
              b_A_dirtyOnGpu = true;
            }
          } else {
            b_i = f_A->size[0] * f_A->size[1];
            f_A->size[0] = g_A->size[0];
            f_A->size[1] = b_rr->size[1];
            emxEnsureCapacity_real_T(f_A, b_i, &t_emlrtRTEI);
            if (!b_A_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(f_A, &d_gpu_A);
            }

            d2scaled = 1.0;
            abnrm = 0.0;
            abnrm_dirtyOnGpu = false;
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, b_rr);
            }

            b_rr_dirtyOnCpu = false;
            if (b_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
            }

            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        g_A->size[0], b_rr->size[1], g_A->size[1], (double *)
                        &d2scaled, (double *)&c_gpu_A.data[0], g_A->size[0],
                        (double *)&b_gpu_rr.data[0], g_A->size[1], (double *)
                        &abnrm, (double *)&d_gpu_A.data[0], g_A->size[0]);
            b_A_dirtyOnCpu = false;
            b_A_dirtyOnGpu = true;
          }

          w_dim0 = f_A->size[0];
          b_i = d_V->size[0] * d_V->size[1];
          d_V->size[0] = f_A->size[0];
          d_V->size[1] = f_A->size[0];
          emxEnsureCapacity_creal_T(d_V, b_i, &v_emlrtRTEI);
          if (!c_V_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal_T(d_V, &e_gpu_V);
          }

          b_i = c_D->size[0] * c_D->size[1];
          c_D->size[0] = f_A->size[0];
          c_D->size[1] = f_A->size[0];
          emxEnsureCapacity_creal_T(c_D, b_i, &w_emlrtRTEI);
          if (!c_D_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal_T(c_D, &c_gpu_D);
          }

          if ((f_A->size[0] != 0) && (f_A->size[1] != 0)) {
            nx = f_A->size[0] * f_A->size[1];
            validLaunchParams = true;
            for (npages = 0; npages < nx; npages++) {
              if (validLaunchParams) {
                if (b_A_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                }

                b_A_dirtyOnGpu = false;
                if (std::isinf(f_A->data[npages]) || std::isnan(f_A->data[npages]))
                {
                  validLaunchParams = false;
                }
              } else {
                validLaunchParams = false;
              }
            }

            if (!validLaunchParams) {
              for (b_i = 0; b_i < 2; b_i++) {
                i_V[b_i] = d_V->size[b_i];
              }

              b_i = d_V->size[0] * d_V->size[1];
              d_V->size[0] = i_V[0];
              d_V->size[1] = i_V[1];
              emxEnsureCapacity_creal_T(d_V, b_i, &y_emlrtRTEI);
              if (!c_V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(d_V, &e_gpu_V);
              }

              b_i = i_V[0] * i_V[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (b_i + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (c_V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&e_gpu_V, d_V);
                }

                ecc_detrend_kernel129<<<grid, block>>>(gpu_dc, b_i, e_gpu_V);
                c_V_dirtyOnCpu = false;
                c_V_dirtyOnGpu = true;
              }

              for (b_i = 0; b_i < 2; b_i++) {
                i_V[b_i] = c_D->size[b_i];
              }

              b_i = c_D->size[0] * c_D->size[1];
              c_D->size[0] = i_V[0];
              c_D->size[1] = i_V[1];
              emxEnsureCapacity_creal_T(c_D, b_i, &eb_emlrtRTEI);
              if (!c_D_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(c_D, &c_gpu_D);
              }

              b_i = i_V[0] * i_V[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (b_i + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (c_D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_D, c_D);
                }

                ecc_detrend_kernel130<<<grid, block>>>(b_i, c_gpu_D);
                c_D_dirtyOnCpu = false;
                c_D_dirtyOnGpu = true;
              }

              for (npages = 0; npages < w_dim0; npages++) {
                if (c_D_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_creal_T(c_D, &c_gpu_D);
                }

                if (dc_dirtyOnGpu) {
                  cudaMemcpy(&dc, gpu_dc, 16UL, cudaMemcpyDeviceToHost);
                }

                dc_dirtyOnGpu = false;
                c_D->data[npages + c_D->size[0] * npages] = dc;
                c_D_dirtyOnGpu = false;
                c_D_dirtyOnCpu = true;
              }
            } else {
              boolean_T exitg2;
              validLaunchParams = (f_A->size[0] == f_A->size[1]);
              if (validLaunchParams) {
                n = 0;
                exitg2 = false;
                while ((!exitg2) && (n <= f_A->size[1] - 1)) {
                  b_i = 0;
                  do {
                    exitg1 = 0;
                    if (b_i <= n) {
                      if (b_A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                      }

                      b_A_dirtyOnGpu = false;
                      if (!(f_A->data[b_i + f_A->size[0] * n] == f_A->data[n +
                            f_A->size[0] * b_i])) {
                        validLaunchParams = false;
                        exitg1 = 1;
                      } else {
                        b_i++;
                      }
                    } else {
                      n++;
                      exitg1 = 2;
                    }
                  } while (exitg1 == 0);

                  if (exitg1 == 1) {
                    exitg2 = true;
                  }
                }
              }

              if (validLaunchParams) {
                nx = f_A->size[0] * f_A->size[1];
                for (npages = 0; npages < nx; npages++) {
                  if (validLaunchParams) {
                    if (b_A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                    }

                    b_A_dirtyOnGpu = false;
                    if (std::isinf(f_A->data[npages]) || std::isnan(f_A->
                         data[npages])) {
                      validLaunchParams = false;
                    }
                  } else {
                    validLaunchParams = false;
                  }
                }

                if (!validLaunchParams) {
                  for (b_i = 0; b_i < 2; b_i++) {
                    sz[b_i] = static_cast<uint32_T>(f_A->size[b_i]);
                  }

                  b_i = f_V->size[0] * f_V->size[1];
                  f_V->size[0] = static_cast<int32_T>(sz[0]);
                  f_V->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real_T(f_V, b_i, &gb_emlrtRTEI);
                  if (!d_V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(f_V, &g_gpu_V);
                  }

                  b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (d_V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_V, f_V);
                    }

                    ecc_detrend_kernel123<<<grid, block>>>(b_i, g_gpu_V);
                    d_V_dirtyOnCpu = false;
                    d_V_dirtyOnGpu = true;
                  }

                  npages = static_cast<int32_T>(sz[0]) - 1;
                  if (static_cast<int32_T>(sz[0]) > 1) {
                    vlen = 1;
                    if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>
                        (sz[1]) - 1) {
                      jend = static_cast<int32_T>(sz[0]) - 1;
                    } else {
                      jend = static_cast<int32_T>(sz[1]);
                    }

                    for (n = 0; n < jend; n++) {
                      for (b_i = 0; b_i <= npages - vlen; b_i++) {
                        if (d_V_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_real_T(f_V, &g_gpu_V);
                        }

                        f_V->data[(vlen + b_i) + f_V->size[0] * n] = 0.0;
                        d_V_dirtyOnGpu = false;
                        d_V_dirtyOnCpu = true;
                      }

                      vlen++;
                    }
                  }

                  for (b_i = 0; b_i < 2; b_i++) {
                    sz[b_i] = static_cast<uint32_T>(f_A->size[b_i]);
                  }

                  b_i = f_A->size[0] * f_A->size[1];
                  f_A->size[0] = static_cast<int32_T>(sz[0]);
                  f_A->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real_T(f_A, b_i, &pb_emlrtRTEI);
                  if (!b_A_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(f_A, &d_gpu_A);
                  }

                  b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (b_A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
                    }

                    ecc_detrend_kernel124<<<grid, block>>>(b_i, d_gpu_A);
                    b_A_dirtyOnCpu = false;
                    b_A_dirtyOnGpu = true;
                  }
                } else {
                  ptrdiff_t c_n_t;
                  ptrdiff_t j_info_t;
                  ptrdiff_t l_info_t;
                  w_dim0 = f_A->size[0];
                  b_i = d_tau->size[0];
                  d_tau->size[0] = f_A->size[0] - 1;
                  emxEnsureCapacity_real_T(d_tau, b_i, &bb_emlrtRTEI);
                  if (!c_tau_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(d_tau, &c_gpu_tau);
                  }

                  if (f_A->size[0] > 1) {
                    ptrdiff_t h_info_t;
                    if (b_A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                    }

                    h_info_t = LAPACKE_dgehrd(102, (ptrdiff_t)f_A->size[0],
                      (ptrdiff_t)1, (ptrdiff_t)f_A->size[0], &f_A->data[0],
                      (ptrdiff_t)f_A->size[0], &d_tau->data[0]);
                    c_tau_dirtyOnCpu = true;
                    b_A_dirtyOnGpu = false;
                    b_A_dirtyOnCpu = true;
                    if ((int32_T)h_info_t != 0) {
                      for (b_i = 0; b_i < 2; b_i++) {
                        i_V[b_i] = f_A->size[b_i];
                      }

                      b_i = f_A->size[0] * f_A->size[1];
                      f_A->size[0] = i_V[0];
                      f_A->size[1] = i_V[1];
                      emxEnsureCapacity_real_T(f_A, b_i, &lb_emlrtRTEI);
                      b_i = i_V[0] * i_V[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
                        ecc_detrend_kernel117<<<grid, block>>>(b_i, d_gpu_A);
                        b_A_dirtyOnCpu = false;
                        b_A_dirtyOnGpu = true;
                      }

                      jend = d_tau->size[0];
                      b_i = d_tau->size[0];
                      d_tau->size[0] = jend;
                      emxEnsureCapacity_real_T(d_tau, b_i, &rb_emlrtRTEI);
                      validLaunchParams = mwGetLaunchParameters1D(static_cast<
                        real_T>((jend - 1) + 1L), &grid, &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_tau, d_tau);
                        ecc_detrend_kernel118<<<grid, block>>>(jend, c_gpu_tau);
                        c_tau_dirtyOnCpu = false;
                        c_tau_dirtyOnGpu = true;
                      }
                    }
                  }

                  b_i = f_V->size[0] * f_V->size[1];
                  f_V->size[0] = f_A->size[0];
                  f_V->size[1] = f_A->size[1];
                  emxEnsureCapacity_real_T(f_V, b_i, &ib_emlrtRTEI);
                  if (!d_V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(f_V, &g_gpu_V);
                  }

                  jend = f_A->size[0] * f_A->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (jend + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (b_A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
                    }

                    if (d_V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_V, f_V);
                    }

                    ecc_detrend_kernel119<<<grid, block>>>(d_gpu_A, jend,
                      g_gpu_V);
                    d_V_dirtyOnGpu = true;
                  }

                  if (d_V_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(f_V, &g_gpu_V);
                  }

                  if (c_tau_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(d_tau, &c_gpu_tau);
                  }

                  c_tau_dirtyOnGpu = false;
                  j_info_t = LAPACKE_dorghr(102, (ptrdiff_t)w_dim0, (ptrdiff_t)1,
                    (ptrdiff_t)w_dim0, &f_V->data[0], (ptrdiff_t)w_dim0,
                    &d_tau->data[0]);
                  d_V_dirtyOnGpu = false;
                  if ((int32_T)j_info_t != 0) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      i_V[b_i] = f_V->size[b_i];
                    }

                    b_i = f_V->size[0] * f_V->size[1];
                    f_V->size[0] = i_V[0];
                    f_V->size[1] = i_V[1];
                    emxEnsureCapacity_real_T(f_V, b_i, &ib_emlrtRTEI);
                    b_i = i_V[0] * i_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_V, f_V);
                      ecc_detrend_kernel120<<<grid, block>>>(b_i, g_gpu_V);
                      d_V_dirtyOnGpu = true;
                    }
                  }

                  c_n_t = (ptrdiff_t)f_A->size[0];
                  b_i = c_wr->size[0] * c_wr->size[1];
                  c_wr->size[0] = 1;
                  c_wr->size[1] = f_A->size[0];
                  emxEnsureCapacity_real_T(c_wr, b_i, &qb_emlrtRTEI);
                  b_i = c_wi->size[0] * c_wi->size[1];
                  c_wi->size[0] = 1;
                  c_wi->size[1] = f_A->size[0];
                  emxEnsureCapacity_real_T(c_wi, b_i, &tb_emlrtRTEI);
                  if (b_A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                  }

                  if (d_V_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(f_V, &g_gpu_V);
                  }

                  if (f_A->size[0] <= 1) {
                    w_dim0 = 1;
                  } else {
                    w_dim0 = f_A->size[0];
                  }

                  l_info_t = LAPACKE_dhseqr(102, 'S', 'V', c_n_t, (ptrdiff_t)1,
                    (ptrdiff_t)f_A->size[0], &f_A->data[0], c_n_t, &c_wr->data[0],
                    &c_wi->data[0], &f_V->data[0], (ptrdiff_t)w_dim0);
                  d_V_dirtyOnGpu = false;
                  d_V_dirtyOnCpu = true;
                  b_A_dirtyOnGpu = false;
                  b_A_dirtyOnCpu = true;
                  if ((int32_T)l_info_t < 0) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      i_V[b_i] = f_A->size[b_i];
                    }

                    b_i = f_A->size[0] * f_A->size[1];
                    f_A->size[0] = i_V[0];
                    f_A->size[1] = i_V[1];
                    emxEnsureCapacity_real_T(f_A, b_i, &ac_emlrtRTEI);
                    b_i = i_V[0] * i_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
                      ecc_detrend_kernel121<<<grid, block>>>(b_i, d_gpu_A);
                      b_A_dirtyOnCpu = false;
                      b_A_dirtyOnGpu = true;
                    }

                    for (b_i = 0; b_i < 2; b_i++) {
                      i_V[b_i] = f_V->size[b_i];
                    }

                    b_i = f_V->size[0] * f_V->size[1];
                    f_V->size[0] = i_V[0];
                    f_V->size[1] = i_V[1];
                    emxEnsureCapacity_real_T(f_V, b_i, &gc_emlrtRTEI);
                    b_i = i_V[0] * i_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D(static_cast<
                      real_T>(b_i + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_V, f_V);
                      ecc_detrend_kernel122<<<grid, block>>>(b_i, g_gpu_V);
                      d_V_dirtyOnCpu = false;
                      d_V_dirtyOnGpu = true;
                    }
                  }
                }

                w_dim0 = f_A->size[0];
                for (n = 0; n <= w_dim0 - 2; n++) {
                  r_dim0 = f_A->size[0];
                  cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
                  if (b_A_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
                  }

                  ecc_detrend_kernel125<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (r_dim0, gpu_n, d_gpu_A);
                  b_A_dirtyOnCpu = false;
                  b_A_dirtyOnGpu = true;
                  r_dim0 = f_A->size[0];
                  cudaMemcpy(&n, gpu_n, 4UL, cudaMemcpyDeviceToHost);
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (n + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    ecc_detrend_kernel126<<<grid, block>>>(r_dim0, d_gpu_A,
                      gpu_n);
                  }
                }

                b_i = d_V->size[0] * d_V->size[1];
                d_V->size[0] = f_V->size[0];
                d_V->size[1] = f_V->size[1];
                emxEnsureCapacity_creal_T(d_V, b_i, &wb_emlrtRTEI);
                if (!c_V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(d_V, &e_gpu_V);
                }

                b_i = f_V->size[0] * f_V->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_i + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (d_V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_V, f_V);
                  }

                  d_V_dirtyOnCpu = false;
                  if (c_V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&e_gpu_V, d_V);
                  }

                  ecc_detrend_kernel127<<<grid, block>>>(g_gpu_V, b_i, e_gpu_V);
                  c_V_dirtyOnCpu = false;
                  c_V_dirtyOnGpu = true;
                }

                b_i = c_D->size[0] * c_D->size[1];
                c_D->size[0] = f_A->size[0];
                c_D->size[1] = f_A->size[1];
                emxEnsureCapacity_creal_T(c_D, b_i, &dc_emlrtRTEI);
                if (!c_D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(c_D, &c_gpu_D);
                }

                jend = f_A->size[0] * f_A->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (jend + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_A_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
                  }

                  b_A_dirtyOnCpu = false;
                  if (c_D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_D, c_D);
                  }

                  ecc_detrend_kernel128<<<grid, block>>>(d_gpu_A, jend, c_gpu_D);
                  c_D_dirtyOnCpu = false;
                  c_D_dirtyOnGpu = true;
                }
              } else {
                validLaunchParams = (f_A->size[0] == f_A->size[1]);
                if (validLaunchParams) {
                  n = 0;
                  exitg2 = false;
                  while ((!exitg2) && (n <= f_A->size[1] - 1)) {
                    b_i = 0;
                    do {
                      exitg1 = 0;
                      if (b_i <= n) {
                        if (b_A_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                        }

                        b_A_dirtyOnGpu = false;
                        if (!(f_A->data[b_i + f_A->size[0] * n] == -f_A->data[n
                              + f_A->size[0] * b_i])) {
                          validLaunchParams = false;
                          exitg1 = 1;
                        } else {
                          b_i++;
                        }
                      } else {
                        n++;
                        exitg1 = 2;
                      }
                    } while (exitg1 == 0);

                    if (exitg1 == 1) {
                      exitg2 = true;
                    }
                  }
                }

                if (validLaunchParams) {
                  nx = f_A->size[0] * f_A->size[1];
                  for (npages = 0; npages < nx; npages++) {
                    if (validLaunchParams) {
                      if (b_A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                      }

                      b_A_dirtyOnGpu = false;
                      if (std::isinf(f_A->data[npages]) || std::isnan(f_A->
                           data[npages])) {
                        validLaunchParams = false;
                      }
                    } else {
                      validLaunchParams = false;
                    }
                  }

                  if (!validLaunchParams) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      sz[b_i] = static_cast<uint32_T>(f_A->size[b_i]);
                    }

                    b_i = b_U->size[0] * b_U->size[1];
                    b_U->size[0] = static_cast<int32_T>(sz[0]);
                    b_U->size[1] = static_cast<int32_T>(sz[1]);
                    emxEnsureCapacity_real_T(b_U, b_i, &gb_emlrtRTEI);
                    if (!b_U_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_real_T(b_U, &b_gpu_U);
                    }

                    b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz
                      [1]) - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      if (b_U_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, b_U);
                      }

                      ecc_detrend_kernel113<<<grid, block>>>(b_i, b_gpu_U);
                      b_U_dirtyOnCpu = false;
                      b_U_dirtyOnGpu = true;
                    }

                    npages = static_cast<int32_T>(sz[0]) - 1;
                    if (static_cast<int32_T>(sz[0]) > 1) {
                      vlen = 1;
                      if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>
                          (sz[1]) - 1) {
                        jend = static_cast<int32_T>(sz[0]) - 1;
                      } else {
                        jend = static_cast<int32_T>(sz[1]);
                      }

                      for (n = 0; n < jend; n++) {
                        for (b_i = 0; b_i <= npages - vlen; b_i++) {
                          if (b_U_dirtyOnGpu) {
                            gpuEmxMemcpyGpuToCpu_real_T(b_U, &b_gpu_U);
                          }

                          b_U->data[(vlen + b_i) + b_U->size[0] * n] = 0.0;
                          b_U_dirtyOnGpu = false;
                          b_U_dirtyOnCpu = true;
                        }

                        vlen++;
                      }
                    }

                    for (b_i = 0; b_i < 2; b_i++) {
                      sz[b_i] = static_cast<uint32_T>(f_A->size[b_i]);
                    }

                    b_i = f_A->size[0] * f_A->size[1];
                    f_A->size[0] = static_cast<int32_T>(sz[0]);
                    f_A->size[1] = static_cast<int32_T>(sz[1]);
                    emxEnsureCapacity_real_T(f_A, b_i, &pb_emlrtRTEI);
                    if (!b_A_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_real_T(f_A, &d_gpu_A);
                    }

                    b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz
                      [1]) - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      if (b_A_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
                      }

                      ecc_detrend_kernel114<<<grid, block>>>(b_i, d_gpu_A);
                      b_A_dirtyOnCpu = false;
                      b_A_dirtyOnGpu = true;
                    }
                  } else {
                    ptrdiff_t d_n_t;
                    ptrdiff_t k_info_t;
                    ptrdiff_t n_info_t;
                    w_dim0 = f_A->size[0];
                    b_i = e_tau->size[0];
                    e_tau->size[0] = f_A->size[0] - 1;
                    emxEnsureCapacity_real_T(e_tau, b_i, &bb_emlrtRTEI);
                    if (!d_tau_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_real_T(e_tau, &d_gpu_tau);
                    }

                    if (f_A->size[0] > 1) {
                      ptrdiff_t i_info_t;
                      if (b_A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                      }

                      i_info_t = LAPACKE_dgehrd(102, (ptrdiff_t)f_A->size[0],
                        (ptrdiff_t)1, (ptrdiff_t)f_A->size[0], &f_A->data[0],
                        (ptrdiff_t)f_A->size[0], &e_tau->data[0]);
                      d_tau_dirtyOnCpu = true;
                      b_A_dirtyOnGpu = false;
                      b_A_dirtyOnCpu = true;
                      if ((int32_T)i_info_t != 0) {
                        for (b_i = 0; b_i < 2; b_i++) {
                          i_V[b_i] = f_A->size[b_i];
                        }

                        b_i = f_A->size[0] * f_A->size[1];
                        f_A->size[0] = i_V[0];
                        f_A->size[1] = i_V[1];
                        emxEnsureCapacity_real_T(f_A, b_i, &lb_emlrtRTEI);
                        b_i = i_V[0] * i_V[1] - 1;
                        validLaunchParams = mwGetLaunchParameters1D(static_cast<
                          real_T>(b_i + 1L), &grid, &block, 1024U, 65535U);
                        if (validLaunchParams) {
                          gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
                          ecc_detrend_kernel107<<<grid, block>>>(b_i, d_gpu_A);
                          b_A_dirtyOnCpu = false;
                          b_A_dirtyOnGpu = true;
                        }

                        jend = e_tau->size[0];
                        b_i = e_tau->size[0];
                        e_tau->size[0] = jend;
                        emxEnsureCapacity_real_T(e_tau, b_i, &rb_emlrtRTEI);
                        validLaunchParams = mwGetLaunchParameters1D(static_cast<
                          real_T>((jend - 1) + 1L), &grid, &block, 1024U, 65535U);
                        if (validLaunchParams) {
                          gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_tau, e_tau);
                          ecc_detrend_kernel108<<<grid, block>>>(jend, d_gpu_tau);
                          d_tau_dirtyOnCpu = false;
                          d_tau_dirtyOnGpu = true;
                        }
                      }
                    }

                    b_i = b_U->size[0] * b_U->size[1];
                    b_U->size[0] = f_A->size[0];
                    b_U->size[1] = f_A->size[1];
                    emxEnsureCapacity_real_T(b_U, b_i, &ib_emlrtRTEI);
                    if (!b_U_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_real_T(b_U, &b_gpu_U);
                    }

                    jend = f_A->size[0] * f_A->size[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(jend + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      if (b_A_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
                      }

                      if (b_U_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, b_U);
                      }

                      ecc_detrend_kernel109<<<grid, block>>>(d_gpu_A, jend,
                        b_gpu_U);
                      b_U_dirtyOnGpu = true;
                    }

                    if (b_U_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(b_U, &b_gpu_U);
                    }

                    if (d_tau_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(e_tau, &d_gpu_tau);
                    }

                    d_tau_dirtyOnGpu = false;
                    k_info_t = LAPACKE_dorghr(102, (ptrdiff_t)w_dim0, (ptrdiff_t)
                      1, (ptrdiff_t)w_dim0, &b_U->data[0], (ptrdiff_t)w_dim0,
                      &e_tau->data[0]);
                    b_U_dirtyOnGpu = false;
                    if ((int32_T)k_info_t != 0) {
                      for (b_i = 0; b_i < 2; b_i++) {
                        i_V[b_i] = b_U->size[b_i];
                      }

                      b_i = b_U->size[0] * b_U->size[1];
                      b_U->size[0] = i_V[0];
                      b_U->size[1] = i_V[1];
                      emxEnsureCapacity_real_T(b_U, b_i, &ib_emlrtRTEI);
                      b_i = i_V[0] * i_V[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, b_U);
                        ecc_detrend_kernel110<<<grid, block>>>(b_i, b_gpu_U);
                        b_U_dirtyOnGpu = true;
                      }
                    }

                    d_n_t = (ptrdiff_t)f_A->size[0];
                    b_i = d_wr->size[0] * d_wr->size[1];
                    d_wr->size[0] = 1;
                    d_wr->size[1] = f_A->size[0];
                    emxEnsureCapacity_real_T(d_wr, b_i, &qb_emlrtRTEI);
                    b_i = d_wi->size[0] * d_wi->size[1];
                    d_wi->size[0] = 1;
                    d_wi->size[1] = f_A->size[0];
                    emxEnsureCapacity_real_T(d_wi, b_i, &tb_emlrtRTEI);
                    if (b_A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                    }

                    if (b_U_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(b_U, &b_gpu_U);
                    }

                    if (f_A->size[0] <= 1) {
                      w_dim0 = 1;
                    } else {
                      w_dim0 = f_A->size[0];
                    }

                    n_info_t = LAPACKE_dhseqr(102, 'S', 'V', d_n_t, (ptrdiff_t)1,
                      (ptrdiff_t)f_A->size[0], &f_A->data[0], d_n_t, &d_wr->
                      data[0], &d_wi->data[0], &b_U->data[0], (ptrdiff_t)w_dim0);
                    b_U_dirtyOnGpu = false;
                    b_U_dirtyOnCpu = true;
                    b_A_dirtyOnGpu = false;
                    b_A_dirtyOnCpu = true;
                    if ((int32_T)n_info_t < 0) {
                      for (b_i = 0; b_i < 2; b_i++) {
                        i_V[b_i] = f_A->size[b_i];
                      }

                      b_i = f_A->size[0] * f_A->size[1];
                      f_A->size[0] = i_V[0];
                      f_A->size[1] = i_V[1];
                      emxEnsureCapacity_real_T(f_A, b_i, &ac_emlrtRTEI);
                      b_i = i_V[0] * i_V[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, f_A);
                        ecc_detrend_kernel111<<<grid, block>>>(b_i, d_gpu_A);
                        b_A_dirtyOnCpu = false;
                        b_A_dirtyOnGpu = true;
                      }

                      for (b_i = 0; b_i < 2; b_i++) {
                        i_V[b_i] = b_U->size[b_i];
                      }

                      b_i = b_U->size[0] * b_U->size[1];
                      b_U->size[0] = i_V[0];
                      b_U->size[1] = i_V[1];
                      emxEnsureCapacity_real_T(b_U, b_i, &gc_emlrtRTEI);
                      b_i = i_V[0] * i_V[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D(static_cast<
                        real_T>(b_i + 1L), &grid, &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, b_U);
                        ecc_detrend_kernel112<<<grid, block>>>(b_i, b_gpu_U);
                        b_U_dirtyOnCpu = false;
                        b_U_dirtyOnGpu = true;
                      }
                    }
                  }

                  w_dim0 = f_A->size[0];
                  b_i = c_D->size[0] * c_D->size[1];
                  c_D->size[0] = f_A->size[0];
                  c_D->size[1] = f_A->size[0];
                  emxEnsureCapacity_creal_T(c_D, b_i, &cc_emlrtRTEI);
                  if (!c_D_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(c_D, &c_gpu_D);
                  }

                  jend = f_A->size[0] * f_A->size[0] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (jend + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (c_D_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_D, c_D);
                    }

                    ecc_detrend_kernel115<<<grid, block>>>(jend, c_gpu_D);
                    c_D_dirtyOnCpu = false;
                    c_D_dirtyOnGpu = true;
                  }

                  b_i = 1;
                  do {
                    exitg1 = 0;
                    if (b_i <= w_dim0) {
                      if (b_i != w_dim0) {
                        if (b_A_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                        }

                        b_A_dirtyOnGpu = false;
                        if (f_A->data[b_i + f_A->size[0] * (b_i - 1)] != 0.0) {
                          d2scaled = std::abs(f_A->data[b_i + f_A->size[0] *
                                              (b_i - 1)]);
                          if (c_D_dirtyOnGpu) {
                            gpuEmxMemcpyGpuToCpu_creal_T(c_D, &c_gpu_D);
                          }

                          c_D->data[(b_i + c_D->size[0] * (b_i - 1)) - 1].re =
                            0.0;
                          c_D->data[(b_i + c_D->size[0] * (b_i - 1)) - 1].im =
                            d2scaled;
                          c_D->data[b_i + c_D->size[0] * b_i].re = 0.0;
                          c_D->data[b_i + c_D->size[0] * b_i].im = -d2scaled;
                          c_D_dirtyOnGpu = false;
                          c_D_dirtyOnCpu = true;
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

                  b_i = d_V->size[0] * d_V->size[1];
                  d_V->size[0] = b_U->size[0];
                  d_V->size[1] = b_U->size[1];
                  emxEnsureCapacity_creal_T(d_V, b_i, &hc_emlrtRTEI);
                  if (!c_V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(d_V, &e_gpu_V);
                  }

                  b_i = b_U->size[0] * b_U->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (b_U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, b_U);
                    }

                    b_U_dirtyOnCpu = false;
                    if (c_V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&e_gpu_V, d_V);
                    }

                    ecc_detrend_kernel116<<<grid, block>>>(b_gpu_U, b_i, e_gpu_V);
                    c_V_dirtyOnCpu = false;
                    c_V_dirtyOnGpu = true;
                  }

                  n = 1;
                  w_dim0 = f_A->size[0];
                  do {
                    exitg1 = 0;
                    if (n <= w_dim0) {
                      if (n != w_dim0) {
                        if (b_A_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                        }

                        b_A_dirtyOnGpu = false;
                        if (f_A->data[n + f_A->size[0] * (n - 1)] != 0.0) {
                          if (f_A->data[n + f_A->size[0] * (n - 1)] < 0.0) {
                            jend = 1;
                          } else {
                            jend = -1;
                          }

                          for (b_i = 0; b_i < w_dim0; b_i++) {
                            if (c_V_dirtyOnGpu) {
                              gpuEmxMemcpyGpuToCpu_creal_T(d_V, &e_gpu_V);
                            }

                            d2scaled = d_V->data[b_i + d_V->size[0] * (n - 1)].
                              re;
                            abnrm = static_cast<real_T>(jend) * d_V->data[b_i +
                              d_V->size[0] * n].re;
                            abnrm_dirtyOnGpu = false;
                            if (abnrm == 0.0) {
                              d_V->data[b_i + d_V->size[0] * (n - 1)].re =
                                d2scaled / 1.4142135623730951;
                              d_V->data[b_i + d_V->size[0] * (n - 1)].im = 0.0;
                            } else if (d2scaled == 0.0) {
                              d_V->data[b_i + d_V->size[0] * (n - 1)].re = 0.0;
                              d_V->data[b_i + d_V->size[0] * (n - 1)].im = abnrm
                                / 1.4142135623730951;
                            } else {
                              d_V->data[b_i + d_V->size[0] * (n - 1)].re =
                                d2scaled / 1.4142135623730951;
                              d_V->data[b_i + d_V->size[0] * (n - 1)].im = abnrm
                                / 1.4142135623730951;
                            }

                            d_V->data[b_i + d_V->size[0] * n].re = d_V->data[b_i
                              + d_V->size[0] * (n - 1)].re;
                            d_V->data[b_i + d_V->size[0] * n].im = -d_V->
                              data[b_i + d_V->size[0] * (n - 1)].im;
                            c_V_dirtyOnGpu = false;
                            c_V_dirtyOnCpu = true;
                          }

                          n += 2;
                        } else {
                          n++;
                        }
                      } else {
                        n++;
                      }
                    } else {
                      exitg1 = 1;
                    }
                  } while (exitg1 == 0);
                } else {
                  ptrdiff_t m_info_t;
                  w_dim0 = f_A->size[0];
                  n = f_A->size[1] - 1;
                  n_dirtyOnCpu = true;
                  b_i = b_scale->size[0];
                  b_scale->size[0] = f_A->size[1];
                  emxEnsureCapacity_real_T(b_scale, b_i, &db_emlrtRTEI);
                  b_i = b_W->size[0];
                  b_W->size[0] = f_A->size[1];
                  emxEnsureCapacity_creal_T(b_W, b_i, &hb_emlrtRTEI);
                  gpuEmxEnsureCapacity_creal_T(b_W, &b_gpu_W);
                  b_i = d_V->size[0] * d_V->size[1];
                  d_V->size[0] = f_A->size[1];
                  d_V->size[1] = f_A->size[1];
                  emxEnsureCapacity_creal_T(d_V, b_i, &jb_emlrtRTEI);
                  if (!c_V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(d_V, &e_gpu_V);
                  }

                  b_i = b_wreal->size[0];
                  b_wreal->size[0] = f_A->size[1];
                  emxEnsureCapacity_real_T(b_wreal, b_i, &kb_emlrtRTEI);
                  if (!b_wreal_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(b_wreal, &b_gpu_wreal);
                  }

                  b_i = b_wimag->size[0];
                  b_wimag->size[0] = f_A->size[1];
                  emxEnsureCapacity_real_T(b_wimag, b_i, &mb_emlrtRTEI);
                  if (!b_wimag_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(b_wimag, &b_gpu_wimag);
                  }

                  b_i = b_vright->size[0] * b_vright->size[1];
                  b_vright->size[0] = f_A->size[1];
                  b_vright->size[1] = f_A->size[1];
                  emxEnsureCapacity_real_T(b_vright, b_i, &ob_emlrtRTEI);
                  if (!b_vright_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(b_vright, &b_gpu_vright);
                  }

                  if (b_A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(f_A, &d_gpu_A);
                  }

                  if (abnrm_dirtyOnGpu) {
                    cudaMemcpy(&abnrm, gpu_abnrm, 8UL, cudaMemcpyDeviceToHost);
                  }

                  m_info_t = LAPACKE_dgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)
                    f_A->size[1], &f_A->data[0], (ptrdiff_t)f_A->size[0],
                    &b_wreal->data[0], &b_wimag->data[0], &d2scaled, (ptrdiff_t)
                    1, &b_vright->data[0], (ptrdiff_t)f_A->size[1], &b_ilo_t,
                    &b_ihi_t, &b_scale->data[0], &abnrm, &rconde, &rcondv);
                  abnrm_dirtyOnGpu = false;
                  b_vright_dirtyOnCpu = true;
                  b_wimag_dirtyOnCpu = true;
                  b_wreal_dirtyOnCpu = true;
                  b_A_dirtyOnGpu = false;
                  b_A_dirtyOnCpu = true;
                  if ((int32_T)m_info_t < 0) {
                    jend = f_A->size[1];
                    b_i = b_W->size[0];
                    b_W->size[0] = f_A->size[1];
                    emxEnsureCapacity_creal_T(b_W, b_i, &vb_emlrtRTEI);
                    gpuEmxEnsureCapacity_creal_T(b_W, &b_gpu_W);
                    validLaunchParams = mwGetLaunchParameters1D(static_cast<
                      real_T>((jend - 1) + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      ecc_detrend_kernel104<<<grid, block>>>(gpu_dc, jend,
                        b_gpu_W);
                      b_W_dirtyOnGpu = true;
                    }

                    for (b_i = 0; b_i < 2; b_i++) {
                      i_V[b_i] = d_V->size[b_i];
                    }

                    b_i = d_V->size[0] * d_V->size[1];
                    d_V->size[0] = i_V[0];
                    d_V->size[1] = i_V[1];
                    emxEnsureCapacity_creal_T(d_V, b_i, &ec_emlrtRTEI);
                    if (!c_V_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_creal_T(d_V, &e_gpu_V);
                    }

                    b_i = i_V[0] * i_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      if (c_V_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_creal_T(&e_gpu_V, d_V);
                      }

                      ecc_detrend_kernel105<<<grid, block>>>(gpu_dc, b_i,
                        e_gpu_V);
                      c_V_dirtyOnCpu = false;
                      c_V_dirtyOnGpu = true;
                    }
                  } else {
                    validLaunchParams = mwGetLaunchParameters1D(static_cast<
                      real_T>(n + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_wimag, b_wimag);
                      b_wimag_dirtyOnCpu = false;
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_wreal, b_wreal);
                      b_wreal_dirtyOnCpu = false;
                      cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
                      n_dirtyOnCpu = false;
                      ecc_detrend_kernel101<<<grid, block>>>(b_gpu_wimag,
                        b_gpu_wreal, gpu_n, b_gpu_W);
                      b_W_dirtyOnGpu = true;
                    }

                    b_i = d_V->size[0] * d_V->size[1];
                    d_V->size[0] = b_vright->size[0];
                    d_V->size[1] = b_vright->size[1];
                    emxEnsureCapacity_creal_T(d_V, b_i, &xb_emlrtRTEI);
                    if (!c_V_dirtyOnCpu) {
                      gpuEmxEnsureCapacity_creal_T(d_V, &e_gpu_V);
                    }

                    b_i = b_vright->size[0] * b_vright->size[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_vright, b_vright);
                      b_vright_dirtyOnCpu = false;
                      if (c_V_dirtyOnCpu) {
                        gpuEmxMemcpyCpuToGpu_creal_T(&e_gpu_V, d_V);
                      }

                      ecc_detrend_kernel102<<<grid, block>>>(b_gpu_vright, b_i,
                        e_gpu_V);
                      c_V_dirtyOnCpu = false;
                      c_V_dirtyOnGpu = true;
                    }

                    for (b_i = 0; b_i < n; b_i++) {
                      if ((b_wimag->data[b_i] > 0.0) && (b_wimag->data[b_i + 1] <
                           0.0)) {
                        jend = d_V->size[0];
                        validLaunchParams = mwGetLaunchParameters1D(static_cast<
                          real_T>(n + 1L), &grid, &block, 1024U, 65535U);
                        if (validLaunchParams) {
                          if (n_dirtyOnCpu) {
                            cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
                          }

                          n_dirtyOnCpu = false;
                          if (c_V_dirtyOnCpu) {
                            gpuEmxMemcpyCpuToGpu_creal_T(&e_gpu_V, d_V);
                          }

                          ecc_detrend_kernel103<<<grid, block>>>(b_i, gpu_n,
                            jend, e_gpu_V);
                          c_V_dirtyOnCpu = false;
                          c_V_dirtyOnGpu = true;
                        }
                      }
                    }
                  }

                  b_i = c_D->size[0] * c_D->size[1];
                  c_D->size[0] = f_A->size[0];
                  c_D->size[1] = f_A->size[0];
                  emxEnsureCapacity_creal_T(c_D, b_i, &fc_emlrtRTEI);
                  if (!c_D_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(c_D, &c_gpu_D);
                  }

                  jend = f_A->size[0] * f_A->size[0] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (jend + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (c_D_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_D, c_D);
                    }

                    ecc_detrend_kernel106<<<grid, block>>>(jend, c_gpu_D);
                    c_D_dirtyOnCpu = false;
                    c_D_dirtyOnGpu = true;
                  }

                  for (npages = 0; npages < w_dim0; npages++) {
                    if (c_D_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_creal_T(c_D, &c_gpu_D);
                    }

                    if (b_W_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_creal_T(b_W, &b_gpu_W);
                    }

                    b_W_dirtyOnGpu = false;
                    c_D->data[npages + c_D->size[0] * npages] = b_W->data[npages];
                    c_D_dirtyOnGpu = false;
                    c_D_dirtyOnCpu = true;
                  }
                }
              }
            }
          }

          // 'ecc_detrend:175' V = real(V);
          b_i = e_V->size[0] * e_V->size[1];
          e_V->size[0] = d_V->size[0];
          e_V->size[1] = d_V->size[1];
          emxEnsureCapacity_real_T(e_V, b_i, &x_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(e_V, &f_gpu_V);
          b_i = d_V->size[0] * d_V->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_V_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&e_gpu_V, d_V);
            }

            c_V_dirtyOnCpu = false;
            ecc_detrend_kernel131<<<grid, block>>>(e_gpu_V, b_i, f_gpu_V);
          }

          // 'ecc_detrend:176' D = diag(real(D));
          b_i = b_v->size[0] * b_v->size[1];
          b_v->size[0] = c_D->size[0];
          b_v->size[1] = c_D->size[1];
          emxEnsureCapacity_real_T(b_v, b_i, &ab_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_v, &b_gpu_v);
          b_i = c_D->size[0] * c_D->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_D_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_D, c_D);
            }

            c_D_dirtyOnCpu = false;
            ecc_detrend_kernel132<<<grid, block>>>(c_gpu_D, b_i, b_gpu_v);
            b_v_dirtyOnGpu = true;
          }

          if ((b_v->size[0] == 1) && (b_v->size[1] == 1)) {
            b_i = d_D->size[0];
            d_D->size[0] = 1;
            emxEnsureCapacity_real_T(d_D, b_i, &fb_emlrtRTEI);
            if (!d_D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(d_D, &d_gpu_D);
            }

            if (b_v_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_v, &b_gpu_v);
            }

            b_v_dirtyOnGpu = false;
            d_D->data[0] = b_v->data[0];
            d_D_dirtyOnCpu = true;
          } else {
            jend = b_v->size[0];
            npages = b_v->size[1];
            if (jend <= npages) {
              npages = jend;
            }

            if (b_v->size[1] > 0) {
              vlen = npages;
            } else {
              vlen = 0;
            }

            b_i = d_D->size[0];
            d_D->size[0] = vlen;
            emxEnsureCapacity_real_T(d_D, b_i, &cb_emlrtRTEI);
            if (!d_D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(d_D, &d_gpu_D);
            }

            b_i = b_v->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((vlen - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (d_D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_D, d_D);
              }

              ecc_detrend_kernel133<<<grid, block>>>(b_gpu_v, vlen, b_i, d_gpu_D);
              d_D_dirtyOnCpu = false;
              d_D_dirtyOnGpu = true;
            }
          }

          // 'ecc_detrend:177' V = V(:,D/max(D)>thrPCA);
          vlen = d_D->size[0];
          if (d_D_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_D, &d_gpu_D);
          }

          d_D_dirtyOnGpu = false;
          d2scaled = d_D->data[0];
          d2scaled_dirtyOnCpu = true;
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            if (std::isnan(d_D->data[b_i + 1])) {
              validLaunchParams = false;
            } else if (std::isnan(d2scaled)) {
              validLaunchParams = true;
            } else {
              validLaunchParams = (d2scaled < d_D->data[b_i + 1]);
            }

            if (validLaunchParams) {
              d2scaled = d_D->data[b_i + 1];
            }
          }

          b_i = bv1->size[0];
          bv1->size[0] = d_D->size[0];
          emxEnsureCapacity_boolean_T(bv1, b_i, &nb_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(bv1, &gpu_bv1);
          b_i = d_D->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (d_D_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_D, d_D);
            }

            d_D_dirtyOnCpu = false;
            cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
            ecc_detrend_kernel134<<<grid, block>>>(d_gpu_D, b_i, gpu_d2scaled,
              gpu_bv1);
            bv1_dirtyOnGpu = true;
          }

          n = bv1->size[0] - 1;
          npages = 0;
          for (b_i = 0; b_i <= n; b_i++) {
            if (bv1_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(bv1, &gpu_bv1);
            }

            bv1_dirtyOnGpu = false;
            if (bv1->data[b_i]) {
              npages++;
            }
          }

          b_i = iv2->size[0];
          iv2->size[0] = npages;
          emxEnsureCapacity_int32_T(iv2, b_i, &sb_emlrtRTEI);
          if (!iv2_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(iv2, &gpu_iv2);
          }

          vlen = 0;
          for (b_i = 0; b_i <= n; b_i++) {
            if (bv1_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(bv1, &gpu_bv1);
            }

            bv1_dirtyOnGpu = false;
            if (bv1->data[b_i]) {
              iv2->data[vlen] = b_i + 1;
              iv2_dirtyOnCpu = true;
              vlen++;
            }
          }

          npages = e_V->size[0];
          b_i = h_V->size[0] * h_V->size[1];
          h_V->size[0] = e_V->size[0];
          h_V->size[1] = iv2->size[0];
          emxEnsureCapacity_real_T(h_V, b_i, &ub_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(h_V, &h_gpu_V);
          b_i = iv2->size[0] - 1;
          jend = h_V->size[0];
          w_dim0 = e_V->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (((npages - 1) + 1L) * (b_i + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (iv2_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv2, iv2);
            }

            iv2_dirtyOnCpu = false;
            ecc_detrend_kernel135<<<grid, block>>>(gpu_iv2, f_gpu_V, npages, b_i,
              jend, w_dim0, h_gpu_V);
          }

          b_i = e_V->size[0] * e_V->size[1];
          e_V->size[0] = h_V->size[0];
          e_V->size[1] = h_V->size[1];
          emxEnsureCapacity_real_T(e_V, b_i, &bc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(e_V, &f_gpu_V);
          b_i = h_V->size[0] * h_V->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detrend_kernel136<<<grid, block>>>(h_gpu_V, b_i, f_gpu_V);
          }

          //  discard weak dims
          // 'ecc_detrend:178' rr = rr*V;
          npages = b_rr->size[0];
          n = b_rr->size[1];
          n_dirtyOnCpu = true;
          if ((b_rr->size[0] == 0) || (b_rr->size[1] == 0) || (e_V->size[0] == 0)
              || (e_V->size[1] == 0)) {
            nx = b_rr->size[0];
            npages = b_rr->size[0];
            n = e_V->size[1];
            b_i = b_rr->size[0] * b_rr->size[1];
            b_rr->size[0] = nx;
            b_rr->size[1] = e_V->size[1];
            emxEnsureCapacity_real_T(b_rr, b_i, &jc_emlrtRTEI);
            if (!b_rr_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_rr, &b_gpu_rr);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((npages * n - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
              n_dirtyOnCpu = false;
              if (b_rr_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, b_rr);
              }

              ecc_detrend_kernel138<<<grid, block>>>(npages, gpu_n, b_gpu_rr);
              b_rr_dirtyOnCpu = false;
              b_rr_dirtyOnGpu = true;
            }
          } else {
            b_i = j_A->size[0] * j_A->size[1];
            j_A->size[0] = b_rr->size[0];
            j_A->size[1] = b_rr->size[1];
            emxEnsureCapacity_real_T(j_A, b_i, &ic_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(j_A, &j_gpu_A);
            w_dim0 = b_rr->size[0] * b_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (w_dim0 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_rr_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, b_rr);
              }

              b_rr_dirtyOnCpu = false;
              ecc_detrend_kernel137<<<grid, block>>>(b_gpu_rr, w_dim0, j_gpu_A);
            }

            b_i = b_rr->size[0] * b_rr->size[1];
            b_rr->size[0] = npages;
            b_rr->size[1] = e_V->size[1];
            emxEnsureCapacity_real_T(b_rr, b_i, &t_emlrtRTEI);
            if (!b_rr_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_rr, &b_gpu_rr);
            }

            d2scaled = 1.0;
            abnrm = 0.0;
            abnrm_dirtyOnGpu = false;
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, b_rr);
            }

            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        npages, e_V->size[1], n, (double *)&d2scaled, (double *)
                        &j_gpu_A.data[0], npages, (double *)&f_gpu_V.data[0], n,
                        (double *)&abnrm, (double *)&b_gpu_rr.data[0], npages);
            b_rr_dirtyOnCpu = false;
            b_rr_dirtyOnGpu = true;
          }

          // 'ecc_detrend:179' b = (x'*rr) / (rr'*rr);
          if ((ii - i7) + 1 == i12 - i11) {
            b_i = k_A->size[0] * k_A->size[1];
            k_A->size[0] = 1;
            k_A->size[1] = (ii - i7) + 1;
            emxEnsureCapacity_real_T(k_A, b_i, &s_emlrtRTEI);
            if (!e_A_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(k_A, &k_gpu_A);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ii
              - i7) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
              }

              b_x_dirtyOnCpu = false;
              if (e_A_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&k_gpu_A, k_A);
              }

              ecc_detrend_kernel139<<<grid, block>>>(b_gpu_w, i11, b_mn, b_gpu_x,
                i7, ii, k_gpu_A);
              e_A_dirtyOnCpu = false;
              e_A_dirtyOnGpu = true;
            }
          } else {
            if (e_A_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(k_A, &k_gpu_A);
            }

            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
            }

            b_x_dirtyOnGpu = false;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            binary_expand_op(k_A, b_x, i7, ii, b_mn, b_w, i11, i12);
            e_A_dirtyOnGpu = false;
            e_A_dirtyOnCpu = true;
          }

          if ((k_A->size[1] == 0) || (b_rr->size[0] == 0) || (b_rr->size[1] == 0))
          {
            b_i = b_b->size[0] * b_b->size[1];
            b_b->size[0] = 1;
            b_b->size[1] = b_rr->size[1];
            emxEnsureCapacity_real_T(b_b, b_i, &u_emlrtRTEI);
            if (!b_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_b, &b_gpu_b);
            }

            w_dim0 = b_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (w_dim0 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, b_b);
              }

              ecc_detrend_kernel140<<<grid, block>>>(w_dim0, b_gpu_b);
              b_b_dirtyOnCpu = false;
            }
          } else {
            b_i = b_b->size[0] * b_b->size[1];
            b_b->size[0] = 1;
            b_b->size[1] = b_rr->size[1];
            emxEnsureCapacity_real_T(b_b, b_i, &t_emlrtRTEI);
            if (!b_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_b, &b_gpu_b);
            }

            d2scaled = 1.0;
            abnrm = 0.0;
            abnrm_dirtyOnGpu = false;
            if (e_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&k_gpu_A, k_A);
            }

            e_A_dirtyOnCpu = false;
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, b_rr);
            }

            b_rr_dirtyOnCpu = false;
            if (b_b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, b_b);
            }

            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                        b_rr->size[1], k_A->size[1], (double *)&d2scaled,
                        (double *)&k_gpu_A.data[0], 1, (double *)&b_gpu_rr.data
                        [0], k_A->size[1], (double *)&abnrm, (double *)
                        &b_gpu_b.data[0], 1);
            b_b_dirtyOnCpu = false;
          }

          b_i = l_A->size[0] * l_A->size[1];
          l_A->size[0] = b_rr->size[1];
          l_A->size[1] = b_rr->size[0];
          emxEnsureCapacity_real_T(l_A, b_i, &s_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(l_A, &l_gpu_A);
          w_dim0 = b_rr->size[0] - 1;
          b_i = b_rr->size[1] - 1;
          r_dim0 = l_A->size[0];
          nx = b_rr->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i +
            1L) * (w_dim0 + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, b_rr);
            }

            b_rr_dirtyOnCpu = false;
            ecc_detrend_kernel141<<<grid, block>>>(b_gpu_rr, b_i, w_dim0, r_dim0,
              nx, l_gpu_A);
          }

          if ((l_A->size[0] == 0) || (l_A->size[1] == 0) || (b_rr->size[0] == 0)
              || (b_rr->size[1] == 0)) {
            b_i = m_A->size[0] * m_A->size[1];
            m_A->size[0] = l_A->size[0];
            m_A->size[1] = b_rr->size[1];
            emxEnsureCapacity_real_T(m_A, b_i, &u_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(m_A, &m_gpu_A);
            jend = l_A->size[0] * b_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(jend
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_detrend_kernel142<<<grid, block>>>(jend, m_gpu_A);
            }
          } else {
            b_i = m_A->size[0] * m_A->size[1];
            m_A->size[0] = l_A->size[0];
            m_A->size[1] = b_rr->size[1];
            emxEnsureCapacity_real_T(m_A, b_i, &t_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(m_A, &m_gpu_A);
            d2scaled = 1.0;
            abnrm = 0.0;
            abnrm_dirtyOnGpu = false;
            if (b_rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, b_rr);
            }

            b_rr_dirtyOnCpu = false;
            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        l_A->size[0], b_rr->size[1], l_A->size[1], (double *)
                        &d2scaled, (double *)&l_gpu_A.data[0], l_A->size[0],
                        (double *)&b_gpu_rr.data[0], l_A->size[1], (double *)
                        &abnrm, (double *)&m_gpu_A.data[0], l_A->size[0]);
          }

          if ((b_b->size[1] == 0) || ((m_A->size[0] == 0) || (m_A->size[1] == 0)))
          {
            sz[1] = static_cast<uint32_T>(m_A->size[0]);
            b_i = b_b->size[0] * b_b->size[1];
            b_b->size[0] = 1;
            b_b->size[1] = m_A->size[0];
            emxEnsureCapacity_real_T(b_b, b_i, &mc_emlrtRTEI);
            if (!b_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_b, &b_gpu_b);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(sz[1]) - 1) + 1L), &grid, &block, 1024U,
              65535U);
            if (validLaunchParams) {
              if (b_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, b_b);
              }

              ecc_detrend_kernel156<<<grid, block>>>(static_cast<int32_T>(sz[1])
                - 1, b_gpu_b);
              b_b_dirtyOnCpu = false;
            }
          } else if (m_A->size[0] == m_A->size[1]) {
            w_dim0 = m_A->size[1];
            b_i = b_ipiv_t->size[0];
            b_ipiv_t->size[0] = m_A->size[1];
            emxEnsureCapacity_int32_T(b_ipiv_t, b_i, &kc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_ipiv_t, &b_gpu_ipiv_t);
            cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), m_A->size[1],
              m_A->size[1], (double *)&m_gpu_A.data[0], m_A->size[1],
              getCuSolverWorkspaceReq());
            setCuSolverWorkspaceTypeSize(8);
            cusolverInitWorkspace();
            if (n_dirtyOnCpu) {
              cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
            }

            cusolverDnDgetrf(getCuSolverGlobalHandle(), m_A->size[1], m_A->size
                             [1], (double *)&m_gpu_A.data[0], m_A->size[1],
                             static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                             &b_gpu_ipiv_t.data[0], gpu_n);
            b_i = b_ipiv->size[0] * b_ipiv->size[1];
            b_ipiv->size[0] = 1;
            b_ipiv->size[1] = b_ipiv_t->size[0];
            emxEnsureCapacity_int32_T(b_ipiv, b_i, &nc_emlrtRTEI);
            if (!b_ipiv_dirtyOnCpu) {
              gpuEmxEnsureCapacity_int32_T(b_ipiv, &b_gpu_ipiv);
            }

            cudaMemcpy(&n, gpu_n, 4UL, cudaMemcpyDeviceToHost);
            if (n < 0) {
              for (b_i = 0; b_i < 2; b_i++) {
                i_V[b_i] = m_A->size[b_i];
              }

              b_i = m_A->size[0] * m_A->size[1];
              m_A->size[0] = i_V[0];
              m_A->size[1] = i_V[1];
              emxEnsureCapacity_real_T(m_A, b_i, &qc_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(m_A, &m_gpu_A);
              b_i = i_V[0] * i_V[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (b_i + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_detrend_kernel154<<<grid, block>>>(b_i, m_gpu_A);
              }

              vlen = b_ipiv->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((vlen - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_ipiv_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_ipiv, b_ipiv);
                }

                ecc_detrend_kernel155<<<grid, block>>>(vlen, b_gpu_ipiv);
                b_ipiv_dirtyOnCpu = false;
                b_ipiv_dirtyOnGpu = true;
              }
            } else {
              vlen = b_ipiv_t->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((vlen - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_ipiv_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_ipiv, b_ipiv);
                }

                ecc_detrend_kernel153<<<grid, block>>>(b_gpu_ipiv_t, vlen,
                  b_gpu_ipiv);
                b_ipiv_dirtyOnCpu = false;
                b_ipiv_dirtyOnGpu = true;
              }
            }

            d2scaled = 1.0;
            if (b_b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, b_b);
            }

            cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                        CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N,
                        CUBLAS_DIAG_NON_UNIT, 1, w_dim0, (double *)&d2scaled,
                        (double *)&m_gpu_A.data[0], w_dim0, (double *)
                        &b_gpu_b.data[0], 1);
            d2scaled = 1.0;
            cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                        CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                        w_dim0, (double *)&d2scaled, (double *)&m_gpu_A.data[0],
                        w_dim0, (double *)&b_gpu_b.data[0], 1);
            b_b_dirtyOnCpu = false;
            validLaunchParams = true;
            for (n = 0; n <= w_dim0 - 2; n++) {
              npages = (w_dim0 - n) - 2;
              if (b_ipiv_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_ipiv, &b_gpu_ipiv);
              }

              b_ipiv_dirtyOnGpu = false;
              if (b_ipiv->data[npages] != npages + 1) {
                if (validLaunchParams) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_b, &b_gpu_b);
                }

                d2scaled = b_b->data[npages];
                b_b->data[npages] = b_b->data[b_ipiv->data[npages] - 1];
                b_b->data[b_ipiv->data[npages] - 1] = d2scaled;
                b_ipiv_dirtyOnCpu = true;
                validLaunchParams = false;
                b_b_dirtyOnCpu = true;
              }
            }
          } else {
            ptrdiff_t p_info_t;
            boolean_T d_A_dirtyOnCpu;
            boolean_T e_tau_dirtyOnCpu;
            b_i = n_A->size[0] * n_A->size[1];
            n_A->size[0] = m_A->size[1];
            n_A->size[1] = m_A->size[0];
            emxEnsureCapacity_real_T(n_A, b_i, &lc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(n_A, &n_gpu_A);
            jend = m_A->size[0] - 1;
            b_i = m_A->size[1] - 1;
            r_dim0 = n_A->size[0];
            w_dim0 = m_A->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i
              + 1L) * (jend + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_detrend_kernel143<<<grid, block>>>(m_gpu_A, b_i, jend, r_dim0,
                w_dim0, n_gpu_A);
              f_A_dirtyOnGpu = true;
            }

            b_i = c_B->size[0];
            c_B->size[0] = b_b->size[1];
            emxEnsureCapacity_real_T(c_B, b_i, &oc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(c_B, &d_gpu_B);
            b_i = b_b->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, b_b);
              }

              b_b_dirtyOnCpu = false;
              ecc_detrend_kernel144<<<grid, block>>>(b_gpu_b, b_i, d_gpu_B);
            }

            npages = n_A->size[0];
            n = n_A->size[1] - 1;
            n_dirtyOnCpu = true;
            b_i = b_jpvt->size[0] * b_jpvt->size[1];
            b_jpvt->size[0] = 1;
            b_jpvt->size[1] = n_A->size[1];
            emxEnsureCapacity_int32_T(b_jpvt, b_i, &rc_emlrtRTEI);
            if (!b_jpvt_dirtyOnCpu) {
              gpuEmxEnsureCapacity_int32_T(b_jpvt, &b_gpu_jpvt);
            }

            jend = n_A->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(jend
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, b_jpvt);
              }

              ecc_detrend_kernel145<<<grid, block>>>(jend, b_gpu_jpvt);
              b_jpvt_dirtyOnCpu = false;
              b_jpvt_dirtyOnGpu = true;
            }

            jend = n_A->size[0];
            nx = n_A->size[1];
            if (jend <= nx) {
              nx = jend;
            }

            b_i = f_tau->size[0];
            f_tau->size[0] = nx;
            emxEnsureCapacity_real_T(f_tau, b_i, &sc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(f_tau, &f_gpu_tau);
            b_i = b_jpvt_t->size[0];
            b_jpvt_t->size[0] = n_A->size[1];
            emxEnsureCapacity_ptrdiff_t(b_jpvt_t, b_i, &tc_emlrtRTEI);
            for (b_i = 0; b_i < n_A->size[1]; b_i++) {
              b_jpvt_t->data[b_i] = (ptrdiff_t)0;
            }

            if (f_A_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(n_A, &n_gpu_A);
            }

            if (f_tau_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_tau, &f_gpu_tau);
            }

            p_info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)n_A->size[0], (ptrdiff_t)
              n_A->size[1], &n_A->data[0], (ptrdiff_t)n_A->size[0],
              &b_jpvt_t->data[0], &f_tau->data[0]);
            f_tau_dirtyOnGpu = false;
            e_tau_dirtyOnCpu = true;
            f_A_dirtyOnGpu = false;
            d_A_dirtyOnCpu = true;
            if ((int32_T)p_info_t != 0) {
              r_dim0 = n_A->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (((npages - 1) + 1L) * (n + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
                n_dirtyOnCpu = false;
                gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_A, n_A);
                ecc_detrend_kernel146<<<grid, block>>>(npages, gpu_n, r_dim0,
                  n_gpu_A);
                d_A_dirtyOnCpu = false;
                f_A_dirtyOnGpu = true;
              }

              jend = n_A->size[0];
              npages = n_A->size[1];
              if (jend <= npages) {
                npages = jend;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_tau, f_tau);
                ecc_detrend_kernel147<<<grid, block>>>(npages, f_gpu_tau);
                e_tau_dirtyOnCpu = false;
                f_tau_dirtyOnGpu = true;
              }

              if ((nx - npages) - 1 >= 0) {
                if (f_tau_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(f_tau, &f_gpu_tau);
                }

                std::memset(&f_tau->data[npages], 0, static_cast<uint32_T>((nx -
                  (npages + 1)) + 1) * sizeof(real_T));
                f_tau_dirtyOnGpu = false;
                e_tau_dirtyOnCpu = true;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (n_dirtyOnCpu) {
                  cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
                }

                if (b_jpvt_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, b_jpvt);
                }

                ecc_detrend_kernel148<<<grid, block>>>(gpu_n, b_gpu_jpvt);
                b_jpvt_dirtyOnCpu = false;
                b_jpvt_dirtyOnGpu = true;
              }
            } else {
              for (b_i = 0; b_i <= n; b_i++) {
                if (b_jpvt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(b_jpvt, &b_gpu_jpvt);
                }

                b_jpvt->data[b_i] = (int32_T)b_jpvt_t->data[b_i];
                b_jpvt_dirtyOnGpu = false;
                b_jpvt_dirtyOnCpu = true;
              }
            }

            nx = 0;
            if (n_A->size[0] < n_A->size[1]) {
              npages = n_A->size[0];
              vlen = n_A->size[1];
            } else {
              npages = n_A->size[1];
              vlen = n_A->size[0];
            }

            if (f_A_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(n_A, &n_gpu_A);
            }

            f_A_dirtyOnGpu = false;
            d2scaled = std::fmin(1.4901161193847656E-8, 2.2204460492503131E-15 *
                                 static_cast<real_T>(vlen)) * std::abs(n_A->
              data[0]);
            while ((nx < npages) && (!(std::abs(n_A->data[nx + n_A->size[0] * nx])
                     <= d2scaled))) {
              nx++;
            }

            vlen = n_A->size[1];
            b_i = b_Y->size[0];
            b_Y->size[0] = n_A->size[1];
            emxEnsureCapacity_real_T(b_Y, b_i, &xc_emlrtRTEI);
            if (!b_Y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_Y, &b_gpu_Y);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((vlen - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_Y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_Y, b_Y);
              }

              ecc_detrend_kernel149<<<grid, block>>>(vlen, b_gpu_Y);
              b_Y_dirtyOnCpu = false;
              b_Y_dirtyOnGpu = true;
            }

            n = 0;
            jend = n_A->size[0];
            npages = n_A->size[1];
            if (jend <= npages) {
              npages = jend;
            }

            if (d_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_A, n_A);
            }

            if (e_tau_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_tau, f_tau);
            }

            cusolverDnDormqr_bufferSize(getCuSolverGlobalHandle(),
              CUBLAS_SIDE_LEFT, CUBLAS_OP_T, c_B->size[0], 1, npages, (double *)
              &n_gpu_A.data[0], n_A->size[0], (double *)&f_gpu_tau.data[0],
              (double *)&d_gpu_B.data[0], c_B->size[0], getCuSolverWorkspaceReq());
            setCuSolverWorkspaceTypeSize(8);
            cusolverInitWorkspace();
            cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
            cusolverDnDormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                             CUBLAS_OP_T, c_B->size[0], 1, npages, (double *)
                             &n_gpu_A.data[0], n_A->size[0], (double *)
                             &f_gpu_tau.data[0], (double *)&d_gpu_B.data[0],
                             c_B->size[0], static_cast<real_T *>
                             (getCuSolverWorkspaceBuff()),
                             *getCuSolverWorkspaceReq(), gpu_n);
            cudaMemcpy(&n, gpu_n, 4UL, cudaMemcpyDeviceToHost);
            if (n < 0) {
              vlen = c_B->size[0];
              b_i = c_B->size[0];
              c_B->size[0] = vlen;
              emxEnsureCapacity_real_T(c_B, b_i, &cd_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(c_B, &d_gpu_B);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((vlen - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecc_detrend_kernel150<<<grid, block>>>(vlen, d_gpu_B);
              }
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx
              - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, b_jpvt);
              }

              b_jpvt_dirtyOnCpu = false;
              if (b_Y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_Y, b_Y);
              }

              ecc_detrend_kernel151<<<grid, block>>>(d_gpu_B, b_gpu_jpvt, nx,
                b_gpu_Y);
              b_Y_dirtyOnCpu = false;
              b_Y_dirtyOnGpu = true;
            }

            for (n = 0; n < nx; n++) {
              npages = (nx - n) - 1;
              if (b_Y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_Y, &b_gpu_Y);
              }

              if (b_jpvt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_jpvt, &b_gpu_jpvt);
              }

              b_Y->data[b_jpvt->data[npages] - 1] /= n_A->data[npages +
                n_A->size[0] * npages];
              b_jpvt_dirtyOnGpu = false;
              b_jpvt_dirtyOnCpu = true;
              b_Y_dirtyOnGpu = false;
              b_Y_dirtyOnCpu = true;
              for (b_i = 0; b_i < npages; b_i++) {
                b_Y->data[b_jpvt->data[b_i] - 1] -= b_Y->data[b_jpvt->
                  data[npages] - 1] * n_A->data[b_i + n_A->size[0] * npages];
              }
            }

            b_i = b_b->size[0] * b_b->size[1];
            b_b->size[0] = 1;
            b_b->size[1] = b_Y->size[0];
            emxEnsureCapacity_real_T(b_b, b_i, &mc_emlrtRTEI);
            if (!b_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_b, &b_gpu_b);
            }

            b_i = b_Y->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_Y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_Y, b_Y);
              }

              b_Y_dirtyOnCpu = false;
              if (b_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, b_b);
              }

              ecc_detrend_kernel152<<<grid, block>>>(b_gpu_Y, b_i, b_gpu_b);
              b_b_dirtyOnCpu = false;
            }
          }

          // 'ecc_detrend:180' z = r*(V*b') + mn;
          b_i = d_B->size[0];
          d_B->size[0] = b_b->size[1];
          emxEnsureCapacity_real_T(d_B, b_i, &pc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(d_B, &c_gpu_B);
          b_i = b_b->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, b_b);
            }

            b_b_dirtyOnCpu = false;
            ecc_detrend_kernel157<<<grid, block>>>(b_gpu_b, b_i, c_gpu_B);
          }

          if ((e_V->size[0] == 0) || (e_V->size[1] == 0) || (d_B->size[0] == 0))
          {
            b_i = e_y->size[0];
            e_y->size[0] = e_V->size[0];
            emxEnsureCapacity_real_T(e_y, b_i, &u_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(e_y, &e_gpu_y);
            b_i = e_V->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_detrend_kernel158<<<grid, block>>>(b_i, e_gpu_y);
            }
          } else {
            b_i = e_y->size[0];
            e_y->size[0] = e_V->size[0];
            emxEnsureCapacity_real_T(e_y, b_i, &t_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(e_y, &e_gpu_y);
            d2scaled = 1.0;
            abnrm = 0.0;
            abnrm_dirtyOnGpu = false;
            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        e_V->size[0], 1, e_V->size[1], (double *)&d2scaled,
                        (double *)&f_gpu_V.data[0], e_V->size[0], (double *)
                        &c_gpu_B.data[0], e_V->size[1], (double *)&abnrm,
                        (double *)&e_gpu_y.data[0], e_V->size[0]);
          }

          if ((b_r->size[0] == 0) || (b_r->size[1] == 0) || (e_y->size[0] == 0))
          {
            b_i = dv13->size[0];
            dv13->size[0] = b_r->size[0];
            emxEnsureCapacity_real_T(dv13, b_i, &uc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv13, &gpu_dv13);
            w_dim0 = b_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (w_dim0 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_detrend_kernel159<<<grid, block>>>(w_dim0, gpu_dv13);
              dv13_dirtyOnGpu = true;
            }
          } else {
            b_i = dv13->size[0];
            dv13->size[0] = b_r->size[0];
            emxEnsureCapacity_real_T(dv13, b_i, &t_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv13, &gpu_dv13);
            d2scaled = 1.0;
            abnrm = 0.0;
            abnrm_dirtyOnGpu = false;
            if (b_r_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_r, b_r);
            }

            b_r_dirtyOnCpu = false;
            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        b_r->size[0], 1, b_r->size[1], (double *)&d2scaled,
                        (double *)&c_gpu_r.data[0], b_r->size[0], (double *)
                        &e_gpu_y.data[0], b_r->size[1], (double *)&abnrm,
                        (double *)&gpu_dv13.data[0], b_r->size[0]);
            dv13_dirtyOnGpu = true;
          }

          if (dv13->size[0] == (ii - i7) + 1) {
            b_i = b_z->size[0];
            b_z->size[0] = dv13->size[0];
            emxEnsureCapacity_real_T(b_z, b_i, &vc_emlrtRTEI);
            if (!b_z_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_z, &b_gpu_z);
            }

            b_i = dv13->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
              }

              b_x_dirtyOnCpu = false;
              if (b_z_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_z, b_z);
              }

              ecc_detrend_kernel160<<<grid, block>>>(mn, b_gpu_x, i7, gpu_dv13,
                b_i, b_gpu_z);
              b_z_dirtyOnCpu = false;
              b_z_dirtyOnGpu = true;
            }
          } else {
            if (b_z_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_z, &b_gpu_z);
            }

            if (dv13_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv13, &gpu_dv13);
            }

            dv13_dirtyOnGpu = false;
            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
            }

            b_x_dirtyOnGpu = false;
            binary_expand_op(b_z, dv13, b_x, i7, ii, mn);
            b_z_dirtyOnGpu = false;
            b_z_dirtyOnCpu = true;
          }

          //  Find outliers
          // 'ecc_detrend:88' d = (x-z).*w;
          if ((ii - i7) + 1 == 1) {
            w_dim0 = b_z->size[0];
          } else {
            w_dim0 = (ii - i7) + 1;
          }

          if (((ii - i7) + 1 == b_z->size[0]) && (w_dim0 == i12 - i11)) {
            b_i = b_d->size[0];
            b_d->size[0] = (ii - i7) + 1;
            emxEnsureCapacity_real_T(b_d, b_i, &wc_emlrtRTEI);
            if (!b_d_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_d, &b_gpu_d);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ii
              - i7) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_z_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_z, b_z);
              }

              b_z_dirtyOnCpu = false;
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
              }

              b_x_dirtyOnCpu = false;
              if (b_d_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, b_d);
              }

              ecc_detrend_kernel161<<<grid, block>>>(b_gpu_w, i11, b_gpu_z,
                b_gpu_x, i7, ii, b_gpu_d);
              b_d_dirtyOnCpu = false;
              b_d_dirtyOnGpu = true;
            }
          } else {
            if (b_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_d, &b_gpu_d);
            }

            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
            }

            b_x_dirtyOnGpu = false;
            if (b_z_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_z, &b_gpu_z);
            }

            b_z_dirtyOnGpu = false;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            binary_expand_op(b_d, b_x, i7, ii, b_z, b_w, i11, i12);
            b_d_dirtyOnGpu = false;
            b_d_dirtyOnCpu = true;
          }

          // 'ecc_detrend:89' thrItr = thr*std(d);
          w_dim0 = b_d->size[0] - 2;
          if ((b_d->size[0] != 0) && (b_d->size[0] != 1)) {
            if (b_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_d, &b_gpu_d);
            }

            b_d_dirtyOnGpu = false;
            d2scaled = b_d->data[0];
            for (b_i = 0; b_i <= w_dim0; b_i++) {
              d2scaled += b_d->data[b_i + 1];
            }

            d2scaled /= static_cast<real_T>(b_d->size[0]);
            b_i = b_absdiff->size[0];
            b_absdiff->size[0] = b_d->size[0];
            emxEnsureCapacity_real_T(b_absdiff, b_i, &yc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_absdiff, &b_gpu_absdiff);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((w_dim0 + 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_d_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, b_d);
              }

              b_d_dirtyOnCpu = false;
              cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
              ecc_detrend_kernel162<<<grid, block>>>(b_gpu_d, w_dim0,
                gpu_d2scaled, b_gpu_absdiff);
            }

            if (abnrm_dirtyOnGpu) {
              cudaMemcpy(&abnrm, gpu_abnrm, 8UL, cudaMemcpyDeviceToHost);
            }

            cublasDnrm2(getCublasGlobalHandle(), b_d->size[0], (double *)
                        &b_gpu_absdiff.data[0], 1, (double *)&abnrm);
            abnrm_dirtyOnGpu = false;
          }

          // 'ecc_detrend:90' w(abs(d)>thrItr) = 0;
          //  update weights
          // 'ecc_detrend:92' x = x-z;
          if ((ii - i7) + 1 == b_z->size[0]) {
            b_i = yy->size[0];
            yy->size[0] = (ii - i7) + 1;
            emxEnsureCapacity_real_T(yy, b_i, &ed_emlrtRTEI);
            if (!yy_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(yy, &gpu_yy);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ii
              - i7) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_z_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_z, b_z);
              }

              b_z_dirtyOnCpu = false;
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
              }

              b_x_dirtyOnCpu = false;
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, yy);
              }

              ecc_detrend_kernel163<<<grid, block>>>(b_gpu_z, b_gpu_x, i7, ii,
                gpu_yy);
              yy_dirtyOnCpu = false;
              yy_dirtyOnGpu = true;
            }
          } else {
            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(yy, &gpu_yy);
            }

            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
            }

            b_x_dirtyOnGpu = false;
            if (b_z_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_z, &b_gpu_z);
            }

            b_z_dirtyOnGpu = false;
            binary_expand_op(yy, b_x, i7, ii, b_z);
            yy_dirtyOnGpu = false;
            yy_dirtyOnCpu = true;
          }

          //  triangular weighting
          // 'ecc_detrend:125' if start==1
          if (start == 1.0) {
            // 'ecc_detrend:126' b = [ones(1,wsize2/2,'like',yy)*wsize2/2, wsize2/2:-1:1]';
            b_i = b_a->size[0] * b_a->size[1];
            b_a->size[0] = 1;
            b_a->size[1] = static_cast<int32_T>(wsize2 / 2.0);
            emxEnsureCapacity_int8_T(b_a, b_i, &fd_emlrtRTEI);
            if (!b_a_dirtyOnCpu) {
              gpuEmxEnsureCapacity_int8_T(b_a, &b_gpu_a);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(wsize2 / 2.0) - 1) + 1L), &grid, &block,
              1024U, 65535U);
            if (validLaunchParams) {
              if (b_a_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int8_T(&b_gpu_a, b_a);
              }

              ecc_detrend_kernel175<<<grid, block>>>(wsize2, b_gpu_a);
              b_a_dirtyOnCpu = false;
            }

            d2scaled = wsize2 / 2.0;
            if (d2scaled < 1.0) {
              f_y->size[0] = 1;
              f_y->size[1] = 0;
            } else if (std::floor(d2scaled) == d2scaled) {
              b_i = f_y->size[0] * f_y->size[1];
              f_y->size[0] = 1;
              f_y->size[1] = static_cast<int32_T>(-(1.0 - d2scaled)) + 1;
              emxEnsureCapacity_real_T(f_y, b_i, &id_emlrtRTEI);
              if (!d_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(f_y, &i_gpu_y);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int32_T>(-(1.0 - d2scaled)) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                if (d_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_y, f_y);
                }

                cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
                ecc_detrend_kernel181<<<grid, block>>>(i_gpu_y, gpu_d2scaled);
                d_y_dirtyOnCpu = false;
                d_y_dirtyOnGpu = true;
              }
            } else {
              abnrm = std::floor(-(1.0 - d2scaled) + 0.5);
              abnrm_dirtyOnGpu = false;
              rconde = d2scaled - abnrm;
              if (std::abs(1.0 - rconde) < 4.4408920985006262E-16 * d2scaled) {
                abnrm++;
                rconde = 1.0;
              } else if (1.0 - rconde > 0.0) {
                rconde = d2scaled - (abnrm - 1.0);
              } else {
                abnrm++;
              }

              w_dim0 = static_cast<int32_T>(abnrm);
              b_i = f_y->size[0] * f_y->size[1];
              f_y->size[0] = 1;
              f_y->size[1] = static_cast<int32_T>(abnrm);
              emxEnsureCapacity_real_T(f_y, b_i, &md_emlrtRTEI);
              if (!d_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(f_y, &i_gpu_y);
              }

              if (static_cast<int32_T>(abnrm) > 0) {
                if (d_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(f_y, &i_gpu_y);
                }

                f_y->data[0] = d2scaled;
                d_y_dirtyOnGpu = false;
                d_y_dirtyOnCpu = true;
                if (static_cast<int32_T>(abnrm) > 1) {
                  cudaMemcpy(gpu_abnrm, &abnrm, 8UL, cudaMemcpyHostToDevice);
                  gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_y, f_y);
                  ecc_detrend_kernel176<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (rconde, gpu_abnrm, i_gpu_y);
                  cudaMemcpy(&abnrm, gpu_abnrm, 8UL, cudaMemcpyDeviceToHost);
                  jend = (static_cast<int32_T>(abnrm) - 1) / 2;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    ((jend - 2) + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                               cudaMemcpyHostToDevice);
                    ecc_detrend_kernel177<<<grid, block>>>(rconde, w_dim0, jend
                      - 2, gpu_d2scaled, i_gpu_y);
                    d2scaled_dirtyOnCpu = false;
                  }

                  if (jend << 1 == w_dim0 - 1) {
                    if (d2scaled_dirtyOnCpu) {
                      cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ecc_detrend_kernel180<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, jend, gpu_d2scaled, i_gpu_y);
                    d_y_dirtyOnCpu = false;
                    d_y_dirtyOnGpu = true;
                  } else {
                    if (d2scaled_dirtyOnCpu) {
                      cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ecc_detrend_kernel178<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (jend, gpu_d2scaled, i_gpu_y);
                    ecc_detrend_kernel179<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, jend, i_gpu_y);
                    d_y_dirtyOnCpu = false;
                    d_y_dirtyOnGpu = true;
                  }
                }
              }
            }

            b_i = c_b->size[0];
            c_b->size[0] = b_a->size[1] + f_y->size[1];
            emxEnsureCapacity_real_T(c_b, b_i, &jd_emlrtRTEI);
            if (!c_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(c_b, &c_gpu_b);
            }

            vlen = b_a->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, c_b);
              }

              ecc_detrend_kernel182<<<grid, block>>>(wsize2, vlen, c_gpu_b);
              c_b_dirtyOnCpu = false;
              b_dirtyOnGpu = true;
            }

            vlen = f_y->size[1];
            for (b_i = 0; b_i < vlen; b_i++) {
              if (b_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_b, &c_gpu_b);
              }

              if (d_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(f_y, &i_gpu_y);
              }

              d_y_dirtyOnGpu = false;
              c_b->data[b_i + b_a->size[1]] = f_y->data[b_i];
              b_a_dirtyOnCpu = true;
              b_dirtyOnGpu = false;
              c_b_dirtyOnCpu = true;
            }
          } else if (stop == dims_idx_0) {
            // 'ecc_detrend:127' elseif stop==dims(1)
            // 'ecc_detrend:128' b = [1:wsize2/2, ones(1,wsize2/2,'like',yy)*wsize2/2]';
            d2scaled = wsize2 / 2.0;
            if (d2scaled < 1.0) {
              h_y->size[0] = 1;
              h_y->size[1] = 0;
            } else {
              b_i = h_y->size[0] * h_y->size[1];
              h_y->size[0] = 1;
              h_y->size[1] = static_cast<int32_T>(d2scaled - 1.0) + 1;
              emxEnsureCapacity_real_T(h_y, b_i, &gd_emlrtRTEI);
              if (!b_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(h_y, &g_gpu_y);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int32_T>(d2scaled - 1.0) + 1L), &grid, &block, 1024U,
                65535U);
              if (validLaunchParams) {
                if (b_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_y, h_y);
                }

                ecc_detrend_kernel172<<<grid, block>>>(d2scaled, g_gpu_y);
                b_y_dirtyOnCpu = false;
              }
            }

            b_i = c_a->size[0] * c_a->size[1];
            c_a->size[0] = 1;
            c_a->size[1] = static_cast<int32_T>(wsize2 / 2.0);
            emxEnsureCapacity_int8_T(c_a, b_i, &hd_emlrtRTEI);
            gpuEmxEnsureCapacity_int8_T(c_a, &c_gpu_a);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(wsize2 / 2.0) - 1) + 1L), &grid, &block,
              1024U, 65535U);
            if (validLaunchParams) {
              ecc_detrend_kernel173<<<grid, block>>>(wsize2, c_gpu_a);
            }

            b_i = c_b->size[0];
            c_b->size[0] = h_y->size[1] + c_a->size[1];
            emxEnsureCapacity_real_T(c_b, b_i, &kd_emlrtRTEI);
            if (!c_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(c_b, &c_gpu_b);
            }

            vlen = h_y->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_y, h_y);
              }

              b_y_dirtyOnCpu = false;
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, c_b);
              }

              ecc_detrend_kernel174<<<grid, block>>>(g_gpu_y, vlen, c_gpu_b);
              c_b_dirtyOnCpu = false;
              b_dirtyOnGpu = true;
            }

            vlen = c_a->size[1];
            for (b_i = 0; b_i < vlen; b_i++) {
              if (b_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_b, &c_gpu_b);
              }

              c_b->data[b_i + h_y->size[1]] = wsize2 / 2.0;
              b_y_dirtyOnCpu = true;
              b_dirtyOnGpu = false;
              c_b_dirtyOnCpu = true;
            }
          } else {
            // 'ecc_detrend:129' else
            // 'ecc_detrend:130' b = [1:wsize2/2, wsize2/2:-1:1]';
            d2scaled = wsize2 / 2.0;
            if (d2scaled < 1.0) {
              g_y->size[0] = 1;
              g_y->size[1] = 0;
            } else {
              b_i = g_y->size[0] * g_y->size[1];
              g_y->size[0] = 1;
              g_y->size[1] = static_cast<int32_T>(d2scaled - 1.0) + 1;
              emxEnsureCapacity_real_T(g_y, b_i, &gd_emlrtRTEI);
              if (!y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(g_y, &f_gpu_y);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int32_T>(d2scaled - 1.0) + 1L), &grid, &block, 1024U,
                65535U);
              if (validLaunchParams) {
                if (y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_y, g_y);
                }

                ecc_detrend_kernel164<<<grid, block>>>(d2scaled, f_gpu_y);
                y_dirtyOnCpu = false;
              }
            }

            d2scaled = wsize2 / 2.0;
            if (d2scaled < 1.0) {
              i_y->size[0] = 1;
              i_y->size[1] = 0;
            } else if (std::floor(d2scaled) == d2scaled) {
              b_i = i_y->size[0] * i_y->size[1];
              i_y->size[0] = 1;
              i_y->size[1] = static_cast<int32_T>(-(1.0 - d2scaled)) + 1;
              emxEnsureCapacity_real_T(i_y, b_i, &id_emlrtRTEI);
              if (!c_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(i_y, &h_gpu_y);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int32_T>(-(1.0 - d2scaled)) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                if (c_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_y, i_y);
                }

                cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
                ecc_detrend_kernel170<<<grid, block>>>(h_gpu_y, gpu_d2scaled);
                c_y_dirtyOnCpu = false;
                c_y_dirtyOnGpu = true;
              }
            } else {
              abnrm = std::floor(-(1.0 - d2scaled) + 0.5);
              abnrm_dirtyOnGpu = false;
              rconde = d2scaled - abnrm;
              if (std::abs(1.0 - rconde) < 4.4408920985006262E-16 * d2scaled) {
                abnrm++;
                rconde = 1.0;
              } else if (1.0 - rconde > 0.0) {
                rconde = d2scaled - (abnrm - 1.0);
              } else {
                abnrm++;
              }

              w_dim0 = static_cast<int32_T>(abnrm);
              b_i = i_y->size[0] * i_y->size[1];
              i_y->size[0] = 1;
              i_y->size[1] = static_cast<int32_T>(abnrm);
              emxEnsureCapacity_real_T(i_y, b_i, &md_emlrtRTEI);
              if (!c_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(i_y, &h_gpu_y);
              }

              if (static_cast<int32_T>(abnrm) > 0) {
                if (c_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(i_y, &h_gpu_y);
                }

                i_y->data[0] = d2scaled;
                c_y_dirtyOnGpu = false;
                c_y_dirtyOnCpu = true;
                if (static_cast<int32_T>(abnrm) > 1) {
                  cudaMemcpy(gpu_abnrm, &abnrm, 8UL, cudaMemcpyHostToDevice);
                  gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_y, i_y);
                  ecc_detrend_kernel165<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (rconde, gpu_abnrm, h_gpu_y);
                  cudaMemcpy(&abnrm, gpu_abnrm, 8UL, cudaMemcpyDeviceToHost);
                  jend = (static_cast<int32_T>(abnrm) - 1) / 2;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    ((jend - 2) + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                               cudaMemcpyHostToDevice);
                    ecc_detrend_kernel166<<<grid, block>>>(rconde, w_dim0, jend
                      - 2, gpu_d2scaled, h_gpu_y);
                    d2scaled_dirtyOnCpu = false;
                  }

                  if (jend << 1 == w_dim0 - 1) {
                    if (d2scaled_dirtyOnCpu) {
                      cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ecc_detrend_kernel169<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, jend, gpu_d2scaled, h_gpu_y);
                    c_y_dirtyOnCpu = false;
                    c_y_dirtyOnGpu = true;
                  } else {
                    if (d2scaled_dirtyOnCpu) {
                      cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                                 cudaMemcpyHostToDevice);
                    }

                    ecc_detrend_kernel167<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (jend, gpu_d2scaled, h_gpu_y);
                    ecc_detrend_kernel168<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, jend, h_gpu_y);
                    c_y_dirtyOnCpu = false;
                    c_y_dirtyOnGpu = true;
                  }
                }
              }
            }

            b_i = c_b->size[0];
            c_b->size[0] = g_y->size[1] + i_y->size[1];
            emxEnsureCapacity_real_T(c_b, b_i, &ld_emlrtRTEI);
            if (!c_b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(c_b, &c_gpu_b);
            }

            vlen = g_y->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_y, g_y);
              }

              y_dirtyOnCpu = false;
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, c_b);
              }

              ecc_detrend_kernel171<<<grid, block>>>(f_gpu_y, vlen, c_gpu_b);
              c_b_dirtyOnCpu = false;
              b_dirtyOnGpu = true;
            }

            vlen = i_y->size[1];
            for (b_i = 0; b_i < vlen; b_i++) {
              if (b_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_b, &c_gpu_b);
              }

              if (c_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_y, &h_gpu_y);
              }

              c_y_dirtyOnGpu = false;
              c_b->data[b_i + g_y->size[1]] = i_y->data[b_i];
              y_dirtyOnCpu = true;
              b_dirtyOnGpu = false;
              c_b_dirtyOnCpu = true;
            }
          }

          //  overlap-add to output
          // 'ecc_detrend:134' y(start:stop,:) = y(start:stop,:) + (yy.*b);
          if (start > stop) {
            vlen = 0;
            jend = -1;
            npages = 0;
          } else {
            vlen = static_cast<int32_T>(start) - 1;
            jend = static_cast<int32_T>(stop) - 1;
            npages = static_cast<int32_T>(start) - 1;
          }

          if (yy->size[0] == 1) {
            w_dim0 = c_b->size[0];
          } else {
            w_dim0 = yy->size[0];
          }

          if ((yy->size[0] == c_b->size[0]) && ((jend - vlen) + 1 == w_dim0)) {
            b_i = j_x->size[0];
            j_x->size[0] = (jend - vlen) + 1;
            emxEnsureCapacity_real_T(j_x, b_i, &nd_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(j_x, &j_gpu_x);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((jend - vlen) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, c_b);
              }

              c_b_dirtyOnCpu = false;
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, yy);
              }

              yy_dirtyOnCpu = false;
              if (c_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, c_x);
              }

              c_x_dirtyOnCpu = false;
              ecc_detrend_kernel183<<<grid, block>>>(c_gpu_b, gpu_yy, c_gpu_x,
                vlen, jend, j_gpu_x);
            }

            b_i = j_x->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, c_x);
              }

              ecc_detrend_kernel184<<<grid, block>>>(j_gpu_x, npages, b_i,
                c_gpu_x);
              c_x_dirtyOnCpu = false;
              c_x_dirtyOnGpu = true;
            }
          } else {
            if (c_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_x, &c_gpu_x);
            }

            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(yy, &gpu_yy);
            }

            yy_dirtyOnGpu = false;
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_b, &c_gpu_b);
            }

            b_dirtyOnGpu = false;
            binary_expand_op(c_x, npages, vlen, jend, yy, c_b);
            c_x_dirtyOnGpu = false;
            c_x_dirtyOnCpu = true;
          }

          // bsxfun(@times,yy,b);
          // 'ecc_detrend:135' trend(start:stop,:) = trend(start:stop,:) + (x(start:stop,:)-yy).*b;
          if (start > stop) {
            jend = 0;
            npages = -1;
            n = 0;
            vlen = 0;
            nx = 0;
          } else {
            jend = static_cast<int32_T>(start) - 1;
            npages = static_cast<int32_T>(stop) - 1;
            n = static_cast<int32_T>(start) - 1;
            vlen = static_cast<int32_T>(stop);
            nx = static_cast<int32_T>(start) - 1;
          }

          if (vlen - n == 1) {
            w_dim0 = yy->size[0];
            b_i = yy->size[0];
          } else {
            w_dim0 = vlen - n;
            b_i = vlen - n;
          }

          if (b_i == 1) {
            b_i = c_b->size[0];
          } else if (vlen - n == 1) {
            b_i = yy->size[0];
          } else {
            b_i = vlen - n;
          }

          if ((vlen - n == yy->size[0]) && (w_dim0 == c_b->size[0]) && ((npages
                - jend) + 1 == b_i)) {
            b_i = b_trend->size[0];
            b_trend->size[0] = (npages - jend) + 1;
            emxEnsureCapacity_real_T(b_trend, b_i, &od_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_trend, &b_gpu_trend);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((npages - jend) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, c_b);
              }

              c_b_dirtyOnCpu = false;
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, yy);
              }

              yy_dirtyOnCpu = false;
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
              }

              b_x_dirtyOnCpu = false;
              if (trend_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
              }

              trend_dirtyOnCpu = false;
              cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
              ecc_detrend_kernel185<<<grid, block>>>(c_gpu_b, gpu_yy, b_gpu_x,
                gpu_trend, jend, npages, gpu_n, b_gpu_trend);
            }

            b_i = b_trend->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (trend_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
              }

              ecc_detrend_kernel186<<<grid, block>>>(b_gpu_trend, nx, b_i,
                gpu_trend);
              trend_dirtyOnCpu = false;
              trend_dirtyOnGpu = true;
            }
          } else {
            if (trend_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(trend, &gpu_trend);
            }

            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
            }

            b_x_dirtyOnGpu = false;
            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(yy, &gpu_yy);
            }

            yy_dirtyOnGpu = false;
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_b, &c_gpu_b);
            }

            b_dirtyOnGpu = false;
            binary_expand_op(trend, nx, jend, npages, b_x, n, vlen - 1, yy, c_b);
            trend_dirtyOnGpu = false;
            trend_dirtyOnCpu = true;
          }

          // bsxfun(@times,x(start:stop,:)-yy,b);
          // 'ecc_detrend:136' a(start:stop,1) = a(start:stop)+b;
          if (start > stop) {
            vlen = 0;
            jend = -1;
            npages = 0;
          } else {
            vlen = static_cast<int32_T>(start) - 1;
            jend = static_cast<int32_T>(stop) - 1;
            npages = static_cast<int32_T>(start) - 1;
          }

          if ((jend - vlen) + 1 == c_b->size[0]) {
            b_i = d_a->size[0];
            d_a->size[0] = (jend - vlen) + 1;
            emxEnsureCapacity_real_T(d_a, b_i, &pd_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_a, &d_gpu_a);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((jend - vlen) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, c_b);
              }

              c_b_dirtyOnCpu = false;
              if (a_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, a);
              }

              a_dirtyOnCpu = false;
              ecc_detrend_kernel187<<<grid, block>>>(c_gpu_b, gpu_a, vlen, jend,
                d_gpu_a);
            }

            b_i = d_a->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (a_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, a);
              }

              ecc_detrend_kernel188<<<grid, block>>>(d_gpu_a, npages, b_i, gpu_a);
              a_dirtyOnCpu = false;
              a_dirtyOnGpu = true;
            }
          } else {
            if (a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(a, &gpu_a);
            }

            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_b, &c_gpu_b);
            }

            b_dirtyOnGpu = false;
            binary_expand_op(a, npages, vlen, jend, c_b);
            a_dirtyOnGpu = false;
            a_dirtyOnCpu = true;
          }

          // 'ecc_detrend:137' offset = offset+winSz/2;
          offset += winSz / 2.0;

          // 'ecc_detrend:138' if offset > dims(1)-winSz/2
        } while (!(offset > static_cast<real_T>(dims_idx_0) - winSz / 2.0));

        // 'ecc_detrend:138' ;
        // 'ecc_detrend:141' if stop<dims(1)
        if (stop < dims_idx_0) {
          //  last sample can be missed
          // 'ecc_detrend:142' y(end,:) = y(end-1,:);
          nx = c_x->size[0];
          b_i = a->size[0];
          if (a_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, a);
          }

          if (c_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, c_x);
          }

          ecc_detrend_kernel189<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nx, b_i,
            gpu_a, c_gpu_x);
          c_x_dirtyOnCpu = false;
          c_x_dirtyOnGpu = true;
          a_dirtyOnCpu = false;
          a_dirtyOnGpu = true;
        }

        // 'ecc_detrend:145' y = y.*(1./a);
        if (c_x->size[0] == a->size[0]) {
          b_i = c_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (a_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, a);
            }

            a_dirtyOnCpu = false;
            if (c_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, c_x);
            }

            ecc_detrend_kernel190<<<grid, block>>>(gpu_a, b_i, c_gpu_x);
            c_x_dirtyOnCpu = false;
            c_x_dirtyOnGpu = true;
          }
        } else {
          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_x, &c_gpu_x);
          }

          if (a_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(a, &gpu_a);
          }

          a_dirtyOnGpu = false;
          binary_expand_op(c_x, a);
          c_x_dirtyOnGpu = false;
          c_x_dirtyOnCpu = true;
        }

        // bsxfun(@times,y,1./a);
        // 'ecc_detrend:146' y(isnan(y)) = 0;
        b_i = bv4->size[0];
        bv4->size[0] = c_x->size[0];
        emxEnsureCapacity_boolean_T(bv4, b_i, &qd_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv4, &gpu_bv4);
        b_i = c_x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, c_x);
          }

          c_x_dirtyOnCpu = false;
          ecc_detrend_kernel191<<<grid, block>>>(c_gpu_x, b_i, gpu_bv4);
          bv4_dirtyOnGpu = true;
        }

        n = bv4->size[0] - 1;
        npages = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (bv4_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv4, &gpu_bv4);
          }

          bv4_dirtyOnGpu = false;
          if (bv4->data[b_i]) {
            npages++;
          }
        }

        b_i = iv8->size[0];
        iv8->size[0] = npages;
        emxEnsureCapacity_int32_T(iv8, b_i, &rd_emlrtRTEI);
        if (!iv8_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(iv8, &gpu_iv8);
        }

        vlen = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (bv4_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv4, &gpu_bv4);
          }

          bv4_dirtyOnGpu = false;
          if (bv4->data[b_i]) {
            iv8->data[vlen] = b_i + 1;
            iv8_dirtyOnCpu = true;
            vlen++;
          }
        }

        b_i = iv8->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv8_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv8, iv8);
          }

          iv8_dirtyOnCpu = false;
          if (c_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, c_x);
          }

          ecc_detrend_kernel192<<<grid, block>>>(gpu_iv8, b_i, c_gpu_x);
          c_x_dirtyOnCpu = false;
          c_x_dirtyOnGpu = true;
        }

        // 'ecc_detrend:147' trend = trend.*(1./a);
        if (trend->size[0] == a->size[0]) {
          b_i = trend->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (a_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, a);
            }

            a_dirtyOnCpu = false;
            if (trend_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
            }

            ecc_detrend_kernel193<<<grid, block>>>(gpu_a, b_i, gpu_trend);
            trend_dirtyOnCpu = false;
            trend_dirtyOnGpu = true;
          }
        } else {
          if (trend_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(trend, &gpu_trend);
          }

          if (a_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(a, &gpu_a);
          }

          a_dirtyOnGpu = false;
          binary_expand_op(trend, a);
          trend_dirtyOnGpu = false;
          trend_dirtyOnCpu = true;
        }

        // bsxfun(@times,trend,1./a);
        // 'ecc_detrend:148' trend(isnan(trend)) = 0;
        b_i = bv5->size[0];
        bv5->size[0] = trend->size[0];
        emxEnsureCapacity_boolean_T(bv5, b_i, &sd_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv5, &gpu_bv5);
        b_i = trend->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (trend_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
          }

          trend_dirtyOnCpu = false;
          ecc_detrend_kernel194<<<grid, block>>>(gpu_trend, b_i, gpu_bv5);
          bv5_dirtyOnGpu = true;
        }

        n = bv5->size[0] - 1;
        npages = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (bv5_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv5, &gpu_bv5);
          }

          bv5_dirtyOnGpu = false;
          if (bv5->data[b_i]) {
            npages++;
          }
        }

        b_i = iv9->size[0];
        iv9->size[0] = npages;
        emxEnsureCapacity_int32_T(iv9, b_i, &rd_emlrtRTEI);
        if (!iv9_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(iv9, &gpu_iv9);
        }

        vlen = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (bv5_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv5, &gpu_bv5);
          }

          bv5_dirtyOnGpu = false;
          if (bv5->data[b_i]) {
            iv9->data[vlen] = b_i + 1;
            iv9_dirtyOnCpu = true;
            vlen++;
          }
        }

        b_i = iv9->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv9_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv9, iv9);
          }

          iv9_dirtyOnCpu = false;
          if (trend_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
          }

          ecc_detrend_kernel195<<<grid, block>>>(gpu_iv9, b_i, gpu_trend);
          trend_dirtyOnCpu = false;
          trend_dirtyOnGpu = true;
        }

        //  Find outliers
        // 'ecc_detrend:151' d = (x-trend).*w;
        if (b_x->size[0] == 1) {
          w_dim0 = trend->size[0];
        } else {
          w_dim0 = b_x->size[0];
        }

        if ((b_x->size[0] == trend->size[0]) && (w_dim0 == b_w->size[0])) {
          b_i = c_d->size[0];
          c_d->size[0] = b_x->size[0];
          emxEnsureCapacity_real_T(c_d, b_i, &td_emlrtRTEI);
          if (!c_d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(c_d, &c_gpu_d);
          }

          b_i = b_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (trend_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
            }

            trend_dirtyOnCpu = false;
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
            }

            b_x_dirtyOnCpu = false;
            if (c_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, c_d);
            }

            ecc_detrend_kernel196<<<grid, block>>>(b_gpu_w, gpu_trend, b_gpu_x,
              b_i, c_gpu_d);
            c_d_dirtyOnCpu = false;
            c_d_dirtyOnGpu = true;
          }
        } else {
          if (c_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_d, &c_gpu_d);
          }

          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          if (trend_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(trend, &gpu_trend);
          }

          trend_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(c_d, b_x, trend, b_w);
          c_d_dirtyOnGpu = false;
          c_d_dirtyOnCpu = true;
        }

        // 'ecc_detrend:152' thrItr = thr*std(d);
        w_dim0 = c_d->size[0] - 2;
        if (c_d->size[0] == 0) {
          abnrm = rtNaN;
        } else if (c_d->size[0] == 1) {
          if (c_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_d, &c_gpu_d);
          }

          c_d_dirtyOnGpu = false;
          if ((!std::isinf(c_d->data[0])) && (!std::isnan(c_d->data[0]))) {
            abnrm = 0.0;
          } else {
            abnrm = rtNaN;
          }
        } else {
          if (c_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_d, &c_gpu_d);
          }

          c_d_dirtyOnGpu = false;
          d2scaled = c_d->data[0];
          for (b_i = 0; b_i <= w_dim0; b_i++) {
            d2scaled += c_d->data[b_i + 1];
          }

          d2scaled /= static_cast<real_T>(c_d->size[0]);
          b_i = c_absdiff->size[0];
          c_absdiff->size[0] = c_d->size[0];
          emxEnsureCapacity_real_T(c_absdiff, b_i, &yc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_absdiff, &c_gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((w_dim0 + 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, c_d);
            }

            c_d_dirtyOnCpu = false;
            cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
            ecc_detrend_kernel197<<<grid, block>>>(c_gpu_d, w_dim0, gpu_d2scaled,
              c_gpu_absdiff);
          }

          if (abnrm_dirtyOnGpu) {
            cudaMemcpy(&abnrm, gpu_abnrm, 8UL, cudaMemcpyDeviceToHost);
          }

          cublasDnrm2(getCublasGlobalHandle(), c_d->size[0], (double *)
                      &c_gpu_absdiff.data[0], 1, (double *)&abnrm);
          abnrm /= std::sqrt(static_cast<real_T>(c_d->size[0]) - 1.0);
        }

        d2scaled = thr * abnrm;

        // 'ecc_detrend:153' w(abs(d)>thrItr) = 0;
        nx = c_d->size[0] - 1;
        b_i = j_y->size[0];
        j_y->size[0] = c_d->size[0];
        emxEnsureCapacity_real_T(j_y, b_i, &ad_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_y, &j_gpu_y);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, c_d);
          }

          c_d_dirtyOnCpu = false;
          ecc_detrend_kernel198<<<grid, block>>>(c_gpu_d, nx, j_gpu_y);
        }

        b_i = bv6->size[0];
        bv6->size[0] = j_y->size[0];
        emxEnsureCapacity_boolean_T(bv6, b_i, &ud_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv6, &gpu_bv6);
        b_i = j_y->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
          ecc_detrend_kernel199<<<grid, block>>>(j_gpu_y, b_i, gpu_d2scaled,
            gpu_bv6);
          bv6_dirtyOnGpu = true;
        }

        n = bv6->size[0] - 1;
        npages = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (bv6_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv6, &gpu_bv6);
          }

          bv6_dirtyOnGpu = false;
          if (bv6->data[b_i]) {
            npages++;
          }
        }

        b_i = iv10->size[0];
        iv10->size[0] = npages;
        emxEnsureCapacity_int32_T(iv10, b_i, &rd_emlrtRTEI);
        if (!iv10_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(iv10, &gpu_iv10);
        }

        vlen = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (bv6_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv6, &gpu_bv6);
          }

          bv6_dirtyOnGpu = false;
          if (bv6->data[b_i]) {
            iv10->data[vlen] = b_i + 1;
            iv10_dirtyOnCpu = true;
            vlen++;
          }
        }

        b_i = iv10->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv10_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv10, iv10);
          }

          iv10_dirtyOnCpu = false;
          ecc_detrend_kernel200<<<grid, block>>>(gpu_iv10, b_i, b_gpu_w);
          b_w_dirtyOnGpu = true;
        }

        //  update weights
      }

      b_i = b_x->size[0];
      b_x->size[0] = c_x->size[0];
      emxEnsureCapacity_real_T(b_x, b_i, &g_emlrtRTEI);
      if (!b_x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(b_x, &b_gpu_x);
      }

      b_i = c_x->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (c_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, c_x);
        }

        c_x_dirtyOnCpu = false;
        if (b_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
        }

        ecc_detrend_kernel201<<<grid, block>>>(c_gpu_x, b_i, b_gpu_x);
        b_x_dirtyOnCpu = false;
        b_x_dirtyOnGpu = true;
      }
    } else {
      int32_T i7;
      int32_T jend;
      int32_T r_dim0;

      //  Standard detrending (trend fit to entire data)
      // 'ecc_detrend:52' [x,w] = detrend_lfn(x,w,order,thr,nItr);
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
      // 'ecc_detrend:74' nFrames = height(x);
      // 'ecc_detrend:75' r = coder.nullcopy(zeros(nFrames,order,'like',x));
      b_i = x->size[0];
      vlen = r->size[0] * r->size[1];
      r->size[0] = b_i;
      r->size[1] = static_cast<int32_T>(order);
      emxEnsureCapacity_real_T(r, vlen, &f_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(r, &gpu_r);

      // 'ecc_detrend:76' lin = linspace(-1,1,nFrames);
      vlen = lin->size[0] * lin->size[1];
      lin->size[0] = 1;
      lin->size[1] = b_i;
      emxEnsureCapacity_real_T(lin, vlen, &i_emlrtRTEI);
      if (!lin_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(lin, &gpu_lin);
      }

      if (b_i >= 1) {
        if (lin_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(lin, &gpu_lin);
        }

        lin->data[b_i - 1] = 1.0;
        lin_dirtyOnGpu = false;
        lin_dirtyOnCpu = true;
        if (lin->size[1] >= 2) {
          lin->data[0] = -1.0;
          if (lin->size[1] >= 3) {
            d2scaled = 1.0 / (static_cast<real_T>(lin->size[1]) - 1.0);
            vlen = lin->size[1] - 3;
            b_i = lin->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, lin);
              ecc_detrend_kernel5<<<grid, block>>>(vlen, b_i, gpu_d2scaled,
                gpu_lin);
              lin_dirtyOnCpu = false;
              lin_dirtyOnGpu = true;
            }

            if ((lin->size[1] & 1) == 1) {
              b_i = lin->size[1];
              if (lin_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, lin);
              }

              ecc_detrend_kernel6<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_i,
                gpu_lin);
              lin_dirtyOnCpu = false;
              lin_dirtyOnGpu = true;
            }
          }
        }
      }

      // 'ecc_detrend:77' for k=1:order
      vlen = static_cast<int32_T>(order);
      for (npages = 0; npages < vlen; npages++) {
        // 'ecc_detrend:78' r(:,k) = lin.^k;
        b_i = dv->size[0] * dv->size[1];
        dv->size[0] = 1;
        dv->size[1] = lin->size[1];
        emxEnsureCapacity_real_T(dv, b_i, &k_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(dv, &gpu_dv);
        nx = lin->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (lin_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, lin);
          }

          lin_dirtyOnCpu = false;
          ecc_detrend_kernel7<<<grid, block>>>(npages, gpu_lin, nx, gpu_dv);
        }

        jend = r->size[0];
        r_dim0 = r->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((jend -
          1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ecc_detrend_kernel8<<<grid, block>>>(gpu_dv, npages, jend, r_dim0,
            gpu_r);
          r_dirtyOnGpu = true;
        }
      }

      //  Remove trends
      // 'ecc_detrend:82' z = coder.nullcopy(zeros(size(x),'like',x));
      b_i = z->size[0];
      z->size[0] = x->size[0];
      emxEnsureCapacity_real_T(z, b_i, &l_emlrtRTEI);
      if (!z_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(z, &gpu_z);
      }

      // 'ecc_detrend:83' for ii = 1:nItr
      i7 = static_cast<int32_T>(nItr);
      for (int32_T ii{0}; ii < i7; ii++) {
        real_T b_mn;
        real_T mn;
        int32_T i_V[2];
        boolean_T abnrm_dirtyOnGpu;
        boolean_T n_dirtyOnCpu;

        //  Weighted regression on basis
        // 'ecc_detrend:85' z = regw_lfn(x,w,r);
        //  Weighted Regression
        //   b: regression matrix (apply to r to approximate x)
        //   z: regression (r*b)
        //  discard dimensions of r with eigenvalue lower than this
        // 'ecc_detrend:165' thrPCA = 1e-7;
        // zeros(1,1,class(x));
        //  save weighted mean
        // 'ecc_detrend:168' mn = x - demean_lfn(x,w);
        //  Demean
        // 'ecc_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (b_x->size[0] == b_w->size[0]) {
          b_i = d_x->size[0];
          d_x->size[0] = b_x->size[0];
          emxEnsureCapacity_real_T(d_x, b_i, &n_emlrtRTEI);
          if (!d_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(d_x, &d_gpu_x);
          }

          b_i = b_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
            }

            b_x_dirtyOnCpu = false;
            if (d_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_x, d_x);
            }

            ecc_detrend_kernel9<<<grid, block>>>(b_gpu_w, b_gpu_x, b_i, d_gpu_x);
            d_x_dirtyOnCpu = false;
            d_x_dirtyOnGpu = true;
          }
        } else {
          if (d_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_x, &d_gpu_x);
          }

          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          times(d_x, b_x, b_w);
          d_x_dirtyOnGpu = false;
          d_x_dirtyOnCpu = true;
        }

        vlen = d_x->size[0];
        if (d_x->size[0] == 0) {
          abnrm = 0.0;
        } else {
          if (d_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_x, &d_gpu_x);
          }

          d_x_dirtyOnGpu = false;
          abnrm = d_x->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            abnrm += d_x->data[b_i + 1];
          }
        }

        vlen = b_w->size[0];
        if (b_w->size[0] == 0) {
          d2scaled = 0.0;
        } else {
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          d2scaled = b_w->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            d2scaled += b_w->data[b_i + 1];
          }
        }

        mn = abnrm / (d2scaled + 2.2204460492503131E-16);

        // 'ecc_detrend:188' x = x - mn;
        //  Fit weighted regression
        // 'ecc_detrend:171' x = demean_lfn(x,w).* w;
        //  Demean
        // 'ecc_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (b_x->size[0] == b_w->size[0]) {
          b_i = e_x->size[0];
          e_x->size[0] = b_x->size[0];
          emxEnsureCapacity_real_T(e_x, b_i, &n_emlrtRTEI);
          if (!e_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(e_x, &e_gpu_x);
          }

          b_i = b_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
            }

            b_x_dirtyOnCpu = false;
            if (e_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_x, e_x);
            }

            ecc_detrend_kernel10<<<grid, block>>>(b_gpu_w, b_gpu_x, b_i, e_gpu_x);
            e_x_dirtyOnCpu = false;
            e_x_dirtyOnGpu = true;
          }
        } else {
          if (e_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_x, &e_gpu_x);
          }

          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          times(e_x, b_x, b_w);
          e_x_dirtyOnGpu = false;
          e_x_dirtyOnCpu = true;
        }

        vlen = e_x->size[0];
        if (e_x->size[0] == 0) {
          abnrm = 0.0;
        } else {
          if (e_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_x, &e_gpu_x);
          }

          e_x_dirtyOnGpu = false;
          abnrm = e_x->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            abnrm += e_x->data[b_i + 1];
          }
        }

        vlen = b_w->size[0];
        if (b_w->size[0] == 0) {
          d2scaled = 0.0;
        } else {
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          d2scaled = b_w->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            d2scaled += b_w->data[b_i + 1];
          }
        }

        b_mn = abnrm / (d2scaled + 2.2204460492503131E-16);

        // 'ecc_detrend:188' x = x - mn;
        // 'ecc_detrend:172' r = demean_lfn(r,w);
        //  Demean
        // 'ecc_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (r->size[0] == b_w->size[0]) {
          b_i = f_x->size[0] * f_x->size[1];
          f_x->size[0] = r->size[0];
          f_x->size[1] = r->size[1];
          emxEnsureCapacity_real_T(f_x, b_i, &n_emlrtRTEI);
          if (!f_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(f_x, &f_gpu_x);
          }

          w_dim0 = r->size[1] - 1;
          jend = r->size[0] - 1;
          nx = f_x->size[0];
          r_dim0 = r->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((jend
            + 1L) * (w_dim0 + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (f_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, f_x);
            }

            ecc_detrend_kernel11<<<grid, block>>>(b_gpu_w, gpu_r, jend, w_dim0,
              nx, r_dim0, f_gpu_x);
            f_x_dirtyOnCpu = false;
            f_x_dirtyOnGpu = true;
          }
        } else {
          if (f_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(f_x, &f_gpu_x);
          }

          if (r_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
          }

          r_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(f_x, r, b_w);
          f_x_dirtyOnGpu = false;
          f_x_dirtyOnCpu = true;
        }

        vlen = f_x->size[0];
        if ((f_x->size[0] == 0) || (f_x->size[1] == 0)) {
          for (b_i = 0; b_i < 2; b_i++) {
            sz[b_i] = static_cast<uint32_T>(f_x->size[b_i]);
          }

          b_i = y->size[0] * y->size[1];
          y->size[0] = 1;
          y->size[1] = static_cast<int32_T>(sz[1]);
          emxEnsureCapacity_real_T(y, b_i, &p_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(y, &gpu_y);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
            static_cast<int32_T>(sz[1]) - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detrend_kernel13<<<grid, block>>>(static_cast<int32_T>(sz[1]) -
              1, gpu_y);
            y_dirtyOnGpu = true;
          }
        } else {
          npages = f_x->size[1] - 1;
          b_i = y->size[0] * y->size[1];
          y->size[0] = 1;
          y->size[1] = f_x->size[1];
          emxEnsureCapacity_real_T(y, b_i, &o_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(y, &gpu_y);
          nx = f_x->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (f_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, f_x);
            }

            f_x_dirtyOnCpu = false;
            ecc_detrend_kernel12<<<grid, block>>>(vlen, f_gpu_x, npages, nx,
              gpu_y);
            y_dirtyOnGpu = true;
          }
        }

        vlen = b_w->size[0];
        if (b_w->size[0] == 0) {
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
        } else {
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          abnrm = b_w->data[0];
          abnrm_dirtyOnGpu = false;
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            abnrm += b_w->data[b_i + 1];
          }
        }

        // 'ecc_detrend:188' x = x - mn;
        if (r->size[1] == y->size[1]) {
          abnrm += 2.2204460492503131E-16;
          b_i = c_r->size[0] * c_r->size[1];
          c_r->size[0] = r->size[0];
          c_r->size[1] = r->size[1];
          emxEnsureCapacity_real_T(c_r, b_i, &q_emlrtRTEI);
          if (!r_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(c_r, &b_gpu_r);
          }

          w_dim0 = r->size[1] - 1;
          jend = r->size[0] - 1;
          r_dim0 = c_r->size[0];
          b_i = r->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((jend
            + 1L) * (w_dim0 + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_abnrm, &abnrm, 8UL, cudaMemcpyHostToDevice);
            if (r_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, c_r);
            }

            ecc_detrend_kernel14<<<grid, block>>>(gpu_y, gpu_r, jend, w_dim0,
              r_dim0, b_i, gpu_abnrm, b_gpu_r);
            r_dirtyOnCpu = false;
            b_r_dirtyOnGpu = true;
            abnrm_dirtyOnGpu = true;
          }
        } else {
          if (b_r_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_r, &b_gpu_r);
          }

          if (r_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
          }

          r_dirtyOnGpu = false;
          if (y_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(y, &gpu_y);
          }

          y_dirtyOnGpu = false;
          b_binary_expand_op(c_r, r, y, abnrm);
          b_r_dirtyOnGpu = false;
          r_dirtyOnCpu = true;
        }

        //  remove channel-specific-weighted mean from regressor
        // 'ecc_detrend:173' rr = r.*w;
        if (c_r->size[0] == b_w->size[0]) {
          b_i = rr->size[0] * rr->size[1];
          rr->size[0] = c_r->size[0];
          rr->size[1] = c_r->size[1];
          emxEnsureCapacity_real_T(rr, b_i, &r_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(rr, &gpu_rr);
          }

          w_dim0 = c_r->size[1] - 1;
          jend = c_r->size[0] - 1;
          nx = rr->size[0];
          r_dim0 = c_r->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((jend
            + 1L) * (w_dim0 + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (r_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, c_r);
            }

            r_dirtyOnCpu = false;
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
            }

            ecc_detrend_kernel15<<<grid, block>>>(b_gpu_w, b_gpu_r, jend, w_dim0,
              nx, r_dim0, gpu_rr);
            rr_dirtyOnCpu = false;
            rr_dirtyOnGpu = true;
          }
        } else {
          if (rr_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(rr, &gpu_rr);
          }

          if (b_r_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_r, &b_gpu_r);
          }

          b_r_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(rr, c_r, b_w);
          rr_dirtyOnGpu = false;
          rr_dirtyOnCpu = true;
        }

        // 'ecc_detrend:174' [V,D] = eig(rr'*rr);
        b_i = b_A->size[0] * b_A->size[1];
        b_A->size[0] = rr->size[1];
        b_A->size[1] = rr->size[0];
        emxEnsureCapacity_real_T(b_A, b_i, &s_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_A, &gpu_A);
        w_dim0 = rr->size[0] - 1;
        b_i = rr->size[1] - 1;
        r_dim0 = b_A->size[0];
        nx = rr->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i +
          1L) * (w_dim0 + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          rr_dirtyOnCpu = false;
          ecc_detrend_kernel16<<<grid, block>>>(gpu_rr, b_i, w_dim0, r_dim0, nx,
            gpu_A);
        }

        if ((b_A->size[0] == 0) || (b_A->size[1] == 0) || (rr->size[0] == 0) ||
            (rr->size[1] == 0)) {
          b_i = A->size[0] * A->size[1];
          A->size[0] = b_A->size[0];
          A->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(A, b_i, &u_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(A, &b_gpu_A);
          }

          jend = b_A->size[0] * rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(jend +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
            }

            ecc_detrend_kernel17<<<grid, block>>>(jend, b_gpu_A);
            A_dirtyOnCpu = false;
            A_dirtyOnGpu = true;
          }
        } else {
          b_i = A->size[0] * A->size[1];
          A->size[0] = b_A->size[0];
          A->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(A, b_i, &t_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(A, &b_gpu_A);
          }

          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          rr_dirtyOnCpu = false;
          if (A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      b_A->size[0], rr->size[1], b_A->size[1], (double *)
                      &d2scaled, (double *)&gpu_A.data[0], b_A->size[0], (double
            *)&gpu_rr.data[0], b_A->size[1], (double *)&abnrm, (double *)
                      &b_gpu_A.data[0], b_A->size[0]);
          A_dirtyOnCpu = false;
          A_dirtyOnGpu = true;
        }

        w_dim0 = A->size[0];
        b_i = V->size[0] * V->size[1];
        V->size[0] = A->size[0];
        V->size[1] = A->size[0];
        emxEnsureCapacity_creal_T(V, b_i, &v_emlrtRTEI);
        if (!V_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
        }

        b_i = D->size[0] * D->size[1];
        D->size[0] = A->size[0];
        D->size[1] = A->size[0];
        emxEnsureCapacity_creal_T(D, b_i, &w_emlrtRTEI);
        if (!D_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
        }

        if ((A->size[0] != 0) && (A->size[1] != 0)) {
          nx = A->size[0] * A->size[1];
          validLaunchParams = true;
          for (npages = 0; npages < nx; npages++) {
            if (validLaunchParams) {
              if (A_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
              }

              A_dirtyOnGpu = false;
              if (std::isinf(A->data[npages]) || std::isnan(A->data[npages])) {
                validLaunchParams = false;
              }
            } else {
              validLaunchParams = false;
            }
          }

          if (!validLaunchParams) {
            for (b_i = 0; b_i < 2; b_i++) {
              i_V[b_i] = V->size[b_i];
            }

            b_i = V->size[0] * V->size[1];
            V->size[0] = i_V[0];
            V->size[1] = i_V[1];
            emxEnsureCapacity_creal_T(V, b_i, &y_emlrtRTEI);
            if (!V_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
            }

            b_i = i_V[0] * i_V[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (V_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
              }

              ecc_detrend_kernel46<<<grid, block>>>(gpu_dc, b_i, gpu_V);
              V_dirtyOnCpu = false;
              V_dirtyOnGpu = true;
            }

            for (b_i = 0; b_i < 2; b_i++) {
              i_V[b_i] = D->size[b_i];
            }

            b_i = D->size[0] * D->size[1];
            D->size[0] = i_V[0];
            D->size[1] = i_V[1];
            emxEnsureCapacity_creal_T(D, b_i, &eb_emlrtRTEI);
            if (!D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
            }

            b_i = i_V[0] * i_V[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
              }

              ecc_detrend_kernel47<<<grid, block>>>(b_i, gpu_D);
              D_dirtyOnCpu = false;
              D_dirtyOnGpu = true;
            }

            for (npages = 0; npages < w_dim0; npages++) {
              if (D_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_creal_T(D, &gpu_D);
              }

              if (dc_dirtyOnGpu) {
                cudaMemcpy(&dc, gpu_dc, 16UL, cudaMemcpyDeviceToHost);
              }

              dc_dirtyOnGpu = false;
              D->data[npages + D->size[0] * npages] = dc;
              D_dirtyOnGpu = false;
              D_dirtyOnCpu = true;
            }
          } else {
            int32_T exitg1;
            boolean_T exitg2;
            validLaunchParams = (A->size[0] == A->size[1]);
            if (validLaunchParams) {
              n = 0;
              exitg2 = false;
              while ((!exitg2) && (n <= A->size[1] - 1)) {
                b_i = 0;
                do {
                  exitg1 = 0;
                  if (b_i <= n) {
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                    }

                    A_dirtyOnGpu = false;
                    if (!(A->data[b_i + A->size[0] * n] == A->data[n + A->size[0]
                          * b_i])) {
                      validLaunchParams = false;
                      exitg1 = 1;
                    } else {
                      b_i++;
                    }
                  } else {
                    n++;
                    exitg1 = 2;
                  }
                } while (exitg1 == 0);

                if (exitg1 == 1) {
                  exitg2 = true;
                }
              }
            }

            if (validLaunchParams) {
              nx = A->size[0] * A->size[1];
              for (npages = 0; npages < nx; npages++) {
                if (validLaunchParams) {
                  if (A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                  }

                  A_dirtyOnGpu = false;
                  if (std::isinf(A->data[npages]) || std::isnan(A->data[npages]))
                  {
                    validLaunchParams = false;
                  }
                } else {
                  validLaunchParams = false;
                }
              }

              if (!validLaunchParams) {
                for (b_i = 0; b_i < 2; b_i++) {
                  sz[b_i] = static_cast<uint32_T>(A->size[b_i]);
                }

                b_i = c_V->size[0] * c_V->size[1];
                c_V->size[0] = static_cast<int32_T>(sz[0]);
                c_V->size[1] = static_cast<int32_T>(sz[1]);
                emxEnsureCapacity_real_T(c_V, b_i, &gb_emlrtRTEI);
                if (!b_V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(c_V, &c_gpu_V);
                }

                b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                  - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_i + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_V, c_V);
                  }

                  ecc_detrend_kernel40<<<grid, block>>>(b_i, c_gpu_V);
                  b_V_dirtyOnCpu = false;
                  b_V_dirtyOnGpu = true;
                }

                npages = static_cast<int32_T>(sz[0]) - 1;
                if (static_cast<int32_T>(sz[0]) > 1) {
                  vlen = 1;
                  if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>(sz
                       [1]) - 1) {
                    jend = static_cast<int32_T>(sz[0]) - 1;
                  } else {
                    jend = static_cast<int32_T>(sz[1]);
                  }

                  for (n = 0; n < jend; n++) {
                    for (b_i = 0; b_i <= npages - vlen; b_i++) {
                      if (b_V_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(c_V, &c_gpu_V);
                      }

                      c_V->data[(vlen + b_i) + c_V->size[0] * n] = 0.0;
                      b_V_dirtyOnGpu = false;
                      b_V_dirtyOnCpu = true;
                    }

                    vlen++;
                  }
                }

                for (b_i = 0; b_i < 2; b_i++) {
                  sz[b_i] = static_cast<uint32_T>(A->size[b_i]);
                }

                b_i = A->size[0] * A->size[1];
                A->size[0] = static_cast<int32_T>(sz[0]);
                A->size[1] = static_cast<int32_T>(sz[1]);
                emxEnsureCapacity_real_T(A, b_i, &pb_emlrtRTEI);
                if (!A_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(A, &b_gpu_A);
                }

                b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                  - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_i + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (A_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                  }

                  ecc_detrend_kernel41<<<grid, block>>>(b_i, b_gpu_A);
                  A_dirtyOnCpu = false;
                  A_dirtyOnGpu = true;
                }
              } else {
                ptrdiff_t c_info_t;
                ptrdiff_t e_info_t;
                ptrdiff_t n_t;
                w_dim0 = A->size[0];
                b_i = tau->size[0];
                tau->size[0] = A->size[0] - 1;
                emxEnsureCapacity_real_T(tau, b_i, &bb_emlrtRTEI);
                if (!tau_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(tau, &gpu_tau);
                }

                if (A->size[0] > 1) {
                  ptrdiff_t info_t;
                  if (A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                  }

                  info_t = LAPACKE_dgehrd(102, (ptrdiff_t)A->size[0], (ptrdiff_t)
                    1, (ptrdiff_t)A->size[0], &A->data[0], (ptrdiff_t)A->size[0],
                    &tau->data[0]);
                  tau_dirtyOnCpu = true;
                  A_dirtyOnGpu = false;
                  A_dirtyOnCpu = true;
                  if ((int32_T)info_t != 0) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      i_V[b_i] = A->size[b_i];
                    }

                    b_i = A->size[0] * A->size[1];
                    A->size[0] = i_V[0];
                    A->size[1] = i_V[1];
                    emxEnsureCapacity_real_T(A, b_i, &lb_emlrtRTEI);
                    b_i = i_V[0] * i_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                      ecc_detrend_kernel34<<<grid, block>>>(b_i, b_gpu_A);
                      A_dirtyOnCpu = false;
                      A_dirtyOnGpu = true;
                    }

                    jend = tau->size[0];
                    b_i = tau->size[0];
                    tau->size[0] = jend;
                    emxEnsureCapacity_real_T(tau, b_i, &rb_emlrtRTEI);
                    validLaunchParams = mwGetLaunchParameters1D(static_cast<
                      real_T>((jend - 1) + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, tau);
                      ecc_detrend_kernel35<<<grid, block>>>(jend, gpu_tau);
                      tau_dirtyOnCpu = false;
                      tau_dirtyOnGpu = true;
                    }
                  }
                }

                b_i = c_V->size[0] * c_V->size[1];
                c_V->size[0] = A->size[0];
                c_V->size[1] = A->size[1];
                emxEnsureCapacity_real_T(c_V, b_i, &ib_emlrtRTEI);
                if (!b_V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(c_V, &c_gpu_V);
                }

                jend = A->size[0] * A->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (jend + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (A_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                  }

                  if (b_V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_V, c_V);
                  }

                  ecc_detrend_kernel36<<<grid, block>>>(b_gpu_A, jend, c_gpu_V);
                  b_V_dirtyOnGpu = true;
                }

                if (b_V_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_V, &c_gpu_V);
                }

                if (tau_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(tau, &gpu_tau);
                }

                tau_dirtyOnGpu = false;
                c_info_t = LAPACKE_dorghr(102, (ptrdiff_t)w_dim0, (ptrdiff_t)1,
                  (ptrdiff_t)w_dim0, &c_V->data[0], (ptrdiff_t)w_dim0,
                  &tau->data[0]);
                b_V_dirtyOnGpu = false;
                if ((int32_T)c_info_t != 0) {
                  for (b_i = 0; b_i < 2; b_i++) {
                    i_V[b_i] = c_V->size[b_i];
                  }

                  b_i = c_V->size[0] * c_V->size[1];
                  c_V->size[0] = i_V[0];
                  c_V->size[1] = i_V[1];
                  emxEnsureCapacity_real_T(c_V, b_i, &ib_emlrtRTEI);
                  b_i = i_V[0] * i_V[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_V, c_V);
                    ecc_detrend_kernel37<<<grid, block>>>(b_i, c_gpu_V);
                    b_V_dirtyOnGpu = true;
                  }
                }

                n_t = (ptrdiff_t)A->size[0];
                b_i = wr->size[0] * wr->size[1];
                wr->size[0] = 1;
                wr->size[1] = A->size[0];
                emxEnsureCapacity_real_T(wr, b_i, &qb_emlrtRTEI);
                b_i = wi->size[0] * wi->size[1];
                wi->size[0] = 1;
                wi->size[1] = A->size[0];
                emxEnsureCapacity_real_T(wi, b_i, &tb_emlrtRTEI);
                if (A_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                }

                if (b_V_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_V, &c_gpu_V);
                }

                if (A->size[0] <= 1) {
                  w_dim0 = 1;
                } else {
                  w_dim0 = A->size[0];
                }

                e_info_t = LAPACKE_dhseqr(102, 'S', 'V', n_t, (ptrdiff_t)1,
                  (ptrdiff_t)A->size[0], &A->data[0], n_t, &wr->data[0],
                  &wi->data[0], &c_V->data[0], (ptrdiff_t)w_dim0);
                b_V_dirtyOnGpu = false;
                b_V_dirtyOnCpu = true;
                A_dirtyOnGpu = false;
                A_dirtyOnCpu = true;
                if ((int32_T)e_info_t < 0) {
                  for (b_i = 0; b_i < 2; b_i++) {
                    i_V[b_i] = A->size[b_i];
                  }

                  b_i = A->size[0] * A->size[1];
                  A->size[0] = i_V[0];
                  A->size[1] = i_V[1];
                  emxEnsureCapacity_real_T(A, b_i, &ac_emlrtRTEI);
                  b_i = i_V[0] * i_V[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                    ecc_detrend_kernel38<<<grid, block>>>(b_i, b_gpu_A);
                    A_dirtyOnCpu = false;
                    A_dirtyOnGpu = true;
                  }

                  for (b_i = 0; b_i < 2; b_i++) {
                    i_V[b_i] = c_V->size[b_i];
                  }

                  b_i = c_V->size[0] * c_V->size[1];
                  c_V->size[0] = i_V[0];
                  c_V->size[1] = i_V[1];
                  emxEnsureCapacity_real_T(c_V, b_i, &gc_emlrtRTEI);
                  b_i = i_V[0] * i_V[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_V, c_V);
                    ecc_detrend_kernel39<<<grid, block>>>(b_i, c_gpu_V);
                    b_V_dirtyOnCpu = false;
                    b_V_dirtyOnGpu = true;
                  }
                }
              }

              w_dim0 = A->size[0];
              for (n = 0; n <= w_dim0 - 2; n++) {
                r_dim0 = A->size[0];
                cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
                if (A_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                }

                ecc_detrend_kernel42<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                  (r_dim0, gpu_n, b_gpu_A);
                A_dirtyOnCpu = false;
                A_dirtyOnGpu = true;
                r_dim0 = A->size[0];
                cudaMemcpy(&n, gpu_n, 4UL, cudaMemcpyDeviceToHost);
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (n + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  ecc_detrend_kernel43<<<grid, block>>>(r_dim0, b_gpu_A, gpu_n);
                }
              }

              b_i = V->size[0] * V->size[1];
              V->size[0] = c_V->size[0];
              V->size[1] = c_V->size[1];
              emxEnsureCapacity_creal_T(V, b_i, &wb_emlrtRTEI);
              if (!V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
              }

              b_i = c_V->size[0] * c_V->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (b_i + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_V, c_V);
                }

                b_V_dirtyOnCpu = false;
                if (V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                }

                ecc_detrend_kernel44<<<grid, block>>>(c_gpu_V, b_i, gpu_V);
                V_dirtyOnCpu = false;
                V_dirtyOnGpu = true;
              }

              b_i = D->size[0] * D->size[1];
              D->size[0] = A->size[0];
              D->size[1] = A->size[1];
              emxEnsureCapacity_creal_T(D, b_i, &dc_emlrtRTEI);
              if (!D_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
              }

              jend = A->size[0] * A->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (jend + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (A_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                }

                A_dirtyOnCpu = false;
                if (D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
                }

                ecc_detrend_kernel45<<<grid, block>>>(b_gpu_A, jend, gpu_D);
                D_dirtyOnCpu = false;
                D_dirtyOnGpu = true;
              }
            } else {
              validLaunchParams = (A->size[0] == A->size[1]);
              if (validLaunchParams) {
                n = 0;
                exitg2 = false;
                while ((!exitg2) && (n <= A->size[1] - 1)) {
                  b_i = 0;
                  do {
                    exitg1 = 0;
                    if (b_i <= n) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (!(A->data[b_i + A->size[0] * n] == -A->data[n +
                            A->size[0] * b_i])) {
                        validLaunchParams = false;
                        exitg1 = 1;
                      } else {
                        b_i++;
                      }
                    } else {
                      n++;
                      exitg1 = 2;
                    }
                  } while (exitg1 == 0);

                  if (exitg1 == 1) {
                    exitg2 = true;
                  }
                }
              }

              if (validLaunchParams) {
                nx = A->size[0] * A->size[1];
                for (npages = 0; npages < nx; npages++) {
                  if (validLaunchParams) {
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                    }

                    A_dirtyOnGpu = false;
                    if (std::isinf(A->data[npages]) || std::isnan(A->data[npages]))
                    {
                      validLaunchParams = false;
                    }
                  } else {
                    validLaunchParams = false;
                  }
                }

                if (!validLaunchParams) {
                  for (b_i = 0; b_i < 2; b_i++) {
                    sz[b_i] = static_cast<uint32_T>(A->size[b_i]);
                  }

                  b_i = U->size[0] * U->size[1];
                  U->size[0] = static_cast<int32_T>(sz[0]);
                  U->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real_T(U, b_i, &gb_emlrtRTEI);
                  if (!U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(U, &gpu_U);
                  }

                  b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                    }

                    ecc_detrend_kernel30<<<grid, block>>>(b_i, gpu_U);
                    U_dirtyOnCpu = false;
                    U_dirtyOnGpu = true;
                  }

                  npages = static_cast<int32_T>(sz[0]) - 1;
                  if (static_cast<int32_T>(sz[0]) > 1) {
                    vlen = 1;
                    if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>
                        (sz[1]) - 1) {
                      jend = static_cast<int32_T>(sz[0]) - 1;
                    } else {
                      jend = static_cast<int32_T>(sz[1]);
                    }

                    for (n = 0; n < jend; n++) {
                      for (b_i = 0; b_i <= npages - vlen; b_i++) {
                        if (U_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_real_T(U, &gpu_U);
                        }

                        U->data[(vlen + b_i) + U->size[0] * n] = 0.0;
                        U_dirtyOnGpu = false;
                        U_dirtyOnCpu = true;
                      }

                      vlen++;
                    }
                  }

                  for (b_i = 0; b_i < 2; b_i++) {
                    sz[b_i] = static_cast<uint32_T>(A->size[b_i]);
                  }

                  b_i = A->size[0] * A->size[1];
                  A->size[0] = static_cast<int32_T>(sz[0]);
                  A->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real_T(A, b_i, &pb_emlrtRTEI);
                  if (!A_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(A, &b_gpu_A);
                  }

                  b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                    }

                    ecc_detrend_kernel31<<<grid, block>>>(b_i, b_gpu_A);
                    A_dirtyOnCpu = false;
                    A_dirtyOnGpu = true;
                  }
                } else {
                  ptrdiff_t b_n_t;
                  ptrdiff_t d_info_t;
                  ptrdiff_t g_info_t;
                  w_dim0 = A->size[0];
                  b_i = b_tau->size[0];
                  b_tau->size[0] = A->size[0] - 1;
                  emxEnsureCapacity_real_T(b_tau, b_i, &bb_emlrtRTEI);
                  if (!b_tau_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(b_tau, &b_gpu_tau);
                  }

                  if (A->size[0] > 1) {
                    ptrdiff_t b_info_t;
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                    }

                    b_info_t = LAPACKE_dgehrd(102, (ptrdiff_t)A->size[0],
                      (ptrdiff_t)1, (ptrdiff_t)A->size[0], &A->data[0],
                      (ptrdiff_t)A->size[0], &b_tau->data[0]);
                    b_tau_dirtyOnCpu = true;
                    A_dirtyOnGpu = false;
                    A_dirtyOnCpu = true;
                    if ((int32_T)b_info_t != 0) {
                      for (b_i = 0; b_i < 2; b_i++) {
                        i_V[b_i] = A->size[b_i];
                      }

                      b_i = A->size[0] * A->size[1];
                      A->size[0] = i_V[0];
                      A->size[1] = i_V[1];
                      emxEnsureCapacity_real_T(A, b_i, &lb_emlrtRTEI);
                      b_i = i_V[0] * i_V[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                        ecc_detrend_kernel24<<<grid, block>>>(b_i, b_gpu_A);
                        A_dirtyOnCpu = false;
                        A_dirtyOnGpu = true;
                      }

                      jend = b_tau->size[0];
                      b_i = b_tau->size[0];
                      b_tau->size[0] = jend;
                      emxEnsureCapacity_real_T(b_tau, b_i, &rb_emlrtRTEI);
                      validLaunchParams = mwGetLaunchParameters1D(static_cast<
                        real_T>((jend - 1) + 1L), &grid, &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_tau, b_tau);
                        ecc_detrend_kernel25<<<grid, block>>>(jend, b_gpu_tau);
                        b_tau_dirtyOnCpu = false;
                        b_tau_dirtyOnGpu = true;
                      }
                    }
                  }

                  b_i = U->size[0] * U->size[1];
                  U->size[0] = A->size[0];
                  U->size[1] = A->size[1];
                  emxEnsureCapacity_real_T(U, b_i, &ib_emlrtRTEI);
                  if (!U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(U, &gpu_U);
                  }

                  jend = A->size[0] * A->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (jend + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                    }

                    if (U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                    }

                    ecc_detrend_kernel26<<<grid, block>>>(b_gpu_A, jend, gpu_U);
                    U_dirtyOnGpu = true;
                  }

                  if (U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(U, &gpu_U);
                  }

                  if (b_tau_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(b_tau, &b_gpu_tau);
                  }

                  b_tau_dirtyOnGpu = false;
                  d_info_t = LAPACKE_dorghr(102, (ptrdiff_t)w_dim0, (ptrdiff_t)1,
                    (ptrdiff_t)w_dim0, &U->data[0], (ptrdiff_t)w_dim0,
                    &b_tau->data[0]);
                  U_dirtyOnGpu = false;
                  if ((int32_T)d_info_t != 0) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      i_V[b_i] = U->size[b_i];
                    }

                    b_i = U->size[0] * U->size[1];
                    U->size[0] = i_V[0];
                    U->size[1] = i_V[1];
                    emxEnsureCapacity_real_T(U, b_i, &ib_emlrtRTEI);
                    b_i = i_V[0] * i_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                      ecc_detrend_kernel27<<<grid, block>>>(b_i, gpu_U);
                      U_dirtyOnGpu = true;
                    }
                  }

                  b_n_t = (ptrdiff_t)A->size[0];
                  b_i = b_wr->size[0] * b_wr->size[1];
                  b_wr->size[0] = 1;
                  b_wr->size[1] = A->size[0];
                  emxEnsureCapacity_real_T(b_wr, b_i, &qb_emlrtRTEI);
                  b_i = b_wi->size[0] * b_wi->size[1];
                  b_wi->size[0] = 1;
                  b_wi->size[1] = A->size[0];
                  emxEnsureCapacity_real_T(b_wi, b_i, &tb_emlrtRTEI);
                  if (A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                  }

                  if (U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(U, &gpu_U);
                  }

                  if (A->size[0] <= 1) {
                    w_dim0 = 1;
                  } else {
                    w_dim0 = A->size[0];
                  }

                  g_info_t = LAPACKE_dhseqr(102, 'S', 'V', b_n_t, (ptrdiff_t)1,
                    (ptrdiff_t)A->size[0], &A->data[0], b_n_t, &b_wr->data[0],
                    &b_wi->data[0], &U->data[0], (ptrdiff_t)w_dim0);
                  U_dirtyOnGpu = false;
                  U_dirtyOnCpu = true;
                  A_dirtyOnGpu = false;
                  A_dirtyOnCpu = true;
                  if ((int32_T)g_info_t < 0) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      i_V[b_i] = A->size[b_i];
                    }

                    b_i = A->size[0] * A->size[1];
                    A->size[0] = i_V[0];
                    A->size[1] = i_V[1];
                    emxEnsureCapacity_real_T(A, b_i, &ac_emlrtRTEI);
                    b_i = i_V[0] * i_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                      ecc_detrend_kernel28<<<grid, block>>>(b_i, b_gpu_A);
                      A_dirtyOnCpu = false;
                      A_dirtyOnGpu = true;
                    }

                    for (b_i = 0; b_i < 2; b_i++) {
                      i_V[b_i] = U->size[b_i];
                    }

                    b_i = U->size[0] * U->size[1];
                    U->size[0] = i_V[0];
                    U->size[1] = i_V[1];
                    emxEnsureCapacity_real_T(U, b_i, &gc_emlrtRTEI);
                    b_i = i_V[0] * i_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D(static_cast<
                      real_T>(b_i + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                      ecc_detrend_kernel29<<<grid, block>>>(b_i, gpu_U);
                      U_dirtyOnCpu = false;
                      U_dirtyOnGpu = true;
                    }
                  }
                }

                w_dim0 = A->size[0];
                b_i = D->size[0] * D->size[1];
                D->size[0] = A->size[0];
                D->size[1] = A->size[0];
                emxEnsureCapacity_creal_T(D, b_i, &cc_emlrtRTEI);
                if (!D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
                }

                jend = A->size[0] * A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (jend + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
                  }

                  ecc_detrend_kernel32<<<grid, block>>>(jend, gpu_D);
                  D_dirtyOnCpu = false;
                  D_dirtyOnGpu = true;
                }

                b_i = 1;
                do {
                  exitg1 = 0;
                  if (b_i <= w_dim0) {
                    if (b_i != w_dim0) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (A->data[b_i + A->size[0] * (b_i - 1)] != 0.0) {
                        d2scaled = std::abs(A->data[b_i + A->size[0] * (b_i - 1)]);
                        if (D_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_creal_T(D, &gpu_D);
                        }

                        D->data[(b_i + D->size[0] * (b_i - 1)) - 1].re = 0.0;
                        D->data[(b_i + D->size[0] * (b_i - 1)) - 1].im =
                          d2scaled;
                        D->data[b_i + D->size[0] * b_i].re = 0.0;
                        D->data[b_i + D->size[0] * b_i].im = -d2scaled;
                        D_dirtyOnGpu = false;
                        D_dirtyOnCpu = true;
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

                b_i = V->size[0] * V->size[1];
                V->size[0] = U->size[0];
                V->size[1] = U->size[1];
                emxEnsureCapacity_creal_T(V, b_i, &hc_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
                }

                b_i = U->size[0] * U->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_i + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (U_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                  }

                  U_dirtyOnCpu = false;
                  if (V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                  }

                  ecc_detrend_kernel33<<<grid, block>>>(gpu_U, b_i, gpu_V);
                  V_dirtyOnCpu = false;
                  V_dirtyOnGpu = true;
                }

                n = 1;
                w_dim0 = A->size[0];
                do {
                  exitg1 = 0;
                  if (n <= w_dim0) {
                    if (n != w_dim0) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (A->data[n + A->size[0] * (n - 1)] != 0.0) {
                        if (A->data[n + A->size[0] * (n - 1)] < 0.0) {
                          jend = 1;
                        } else {
                          jend = -1;
                        }

                        for (b_i = 0; b_i < w_dim0; b_i++) {
                          if (V_dirtyOnGpu) {
                            gpuEmxMemcpyGpuToCpu_creal_T(V, &gpu_V);
                          }

                          d2scaled = V->data[b_i + V->size[0] * (n - 1)].re;
                          abnrm = static_cast<real_T>(jend) * V->data[b_i +
                            V->size[0] * n].re;
                          abnrm_dirtyOnGpu = false;
                          if (abnrm == 0.0) {
                            V->data[b_i + V->size[0] * (n - 1)].re = d2scaled /
                              1.4142135623730951;
                            V->data[b_i + V->size[0] * (n - 1)].im = 0.0;
                          } else if (d2scaled == 0.0) {
                            V->data[b_i + V->size[0] * (n - 1)].re = 0.0;
                            V->data[b_i + V->size[0] * (n - 1)].im = abnrm /
                              1.4142135623730951;
                          } else {
                            V->data[b_i + V->size[0] * (n - 1)].re = d2scaled /
                              1.4142135623730951;
                            V->data[b_i + V->size[0] * (n - 1)].im = abnrm /
                              1.4142135623730951;
                          }

                          V->data[b_i + V->size[0] * n].re = V->data[b_i +
                            V->size[0] * (n - 1)].re;
                          V->data[b_i + V->size[0] * n].im = -V->data[b_i +
                            V->size[0] * (n - 1)].im;
                          V_dirtyOnGpu = false;
                          V_dirtyOnCpu = true;
                        }

                        n += 2;
                      } else {
                        n++;
                      }
                    } else {
                      n++;
                    }
                  } else {
                    exitg1 = 1;
                  }
                } while (exitg1 == 0);
              } else {
                ptrdiff_t f_info_t;
                w_dim0 = A->size[0];
                n = A->size[1] - 1;
                n_dirtyOnCpu = true;
                b_i = scale->size[0];
                scale->size[0] = A->size[1];
                emxEnsureCapacity_real_T(scale, b_i, &db_emlrtRTEI);
                b_i = W->size[0];
                W->size[0] = A->size[1];
                emxEnsureCapacity_creal_T(W, b_i, &hb_emlrtRTEI);
                gpuEmxEnsureCapacity_creal_T(W, &gpu_W);
                b_i = V->size[0] * V->size[1];
                V->size[0] = A->size[1];
                V->size[1] = A->size[1];
                emxEnsureCapacity_creal_T(V, b_i, &jb_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
                }

                b_i = wreal->size[0];
                wreal->size[0] = A->size[1];
                emxEnsureCapacity_real_T(wreal, b_i, &kb_emlrtRTEI);
                if (!wreal_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(wreal, &gpu_wreal);
                }

                b_i = wimag->size[0];
                wimag->size[0] = A->size[1];
                emxEnsureCapacity_real_T(wimag, b_i, &mb_emlrtRTEI);
                if (!wimag_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(wimag, &gpu_wimag);
                }

                b_i = vright->size[0] * vright->size[1];
                vright->size[0] = A->size[1];
                vright->size[1] = A->size[1];
                emxEnsureCapacity_real_T(vright, b_i, &ob_emlrtRTEI);
                if (!vright_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(vright, &gpu_vright);
                }

                if (A_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                }

                if (abnrm_dirtyOnGpu) {
                  cudaMemcpy(&abnrm, gpu_abnrm, 8UL, cudaMemcpyDeviceToHost);
                }

                f_info_t = LAPACKE_dgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)
                  A->size[1], &A->data[0], (ptrdiff_t)A->size[0], &wreal->data[0],
                  &wimag->data[0], &d2scaled, (ptrdiff_t)1, &vright->data[0],
                  (ptrdiff_t)A->size[1], &ilo_t, &ihi_t, &scale->data[0], &abnrm,
                  &rconde, &rcondv);
                abnrm_dirtyOnGpu = false;
                vright_dirtyOnCpu = true;
                wimag_dirtyOnCpu = true;
                wreal_dirtyOnCpu = true;
                A_dirtyOnGpu = false;
                A_dirtyOnCpu = true;
                if ((int32_T)f_info_t < 0) {
                  jend = A->size[1];
                  b_i = W->size[0];
                  W->size[0] = A->size[1];
                  emxEnsureCapacity_creal_T(W, b_i, &vb_emlrtRTEI);
                  gpuEmxEnsureCapacity_creal_T(W, &gpu_W);
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    ((jend - 1) + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    ecc_detrend_kernel21<<<grid, block>>>(gpu_dc, jend, gpu_W);
                    W_dirtyOnGpu = true;
                  }

                  for (b_i = 0; b_i < 2; b_i++) {
                    i_V[b_i] = V->size[b_i];
                  }

                  b_i = V->size[0] * V->size[1];
                  V->size[0] = i_V[0];
                  V->size[1] = i_V[1];
                  emxEnsureCapacity_creal_T(V, b_i, &ec_emlrtRTEI);
                  if (!V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
                  }

                  b_i = i_V[0] * i_V[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                    }

                    ecc_detrend_kernel22<<<grid, block>>>(gpu_dc, b_i, gpu_V);
                    V_dirtyOnCpu = false;
                    V_dirtyOnGpu = true;
                  }
                } else {
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (n + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_wimag, wimag);
                    wimag_dirtyOnCpu = false;
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_wreal, wreal);
                    wreal_dirtyOnCpu = false;
                    cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
                    n_dirtyOnCpu = false;
                    ecc_detrend_kernel18<<<grid, block>>>(gpu_wimag, gpu_wreal,
                      gpu_n, gpu_W);
                    W_dirtyOnGpu = true;
                  }

                  b_i = V->size[0] * V->size[1];
                  V->size[0] = vright->size[0];
                  V->size[1] = vright->size[1];
                  emxEnsureCapacity_creal_T(V, b_i, &xb_emlrtRTEI);
                  if (!V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
                  }

                  b_i = vright->size[0] * vright->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_vright, vright);
                    vright_dirtyOnCpu = false;
                    if (V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                    }

                    ecc_detrend_kernel19<<<grid, block>>>(gpu_vright, b_i, gpu_V);
                    V_dirtyOnCpu = false;
                    V_dirtyOnGpu = true;
                  }

                  for (b_i = 0; b_i < n; b_i++) {
                    if ((wimag->data[b_i] > 0.0) && (wimag->data[b_i + 1] < 0.0))
                    {
                      jend = V->size[0];
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(n + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        if (n_dirtyOnCpu) {
                          cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
                        }

                        n_dirtyOnCpu = false;
                        if (V_dirtyOnCpu) {
                          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                        }

                        ecc_detrend_kernel20<<<grid, block>>>(b_i, gpu_n, jend,
                          gpu_V);
                        V_dirtyOnCpu = false;
                        V_dirtyOnGpu = true;
                      }
                    }
                  }
                }

                b_i = D->size[0] * D->size[1];
                D->size[0] = A->size[0];
                D->size[1] = A->size[0];
                emxEnsureCapacity_creal_T(D, b_i, &fc_emlrtRTEI);
                if (!D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
                }

                jend = A->size[0] * A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (jend + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
                  }

                  ecc_detrend_kernel23<<<grid, block>>>(jend, gpu_D);
                  D_dirtyOnCpu = false;
                  D_dirtyOnGpu = true;
                }

                for (npages = 0; npages < w_dim0; npages++) {
                  if (D_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal_T(D, &gpu_D);
                  }

                  if (W_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal_T(W, &gpu_W);
                  }

                  W_dirtyOnGpu = false;
                  D->data[npages + D->size[0] * npages] = W->data[npages];
                  D_dirtyOnGpu = false;
                  D_dirtyOnCpu = true;
                }
              }
            }
          }
        }

        // 'ecc_detrend:175' V = real(V);
        b_i = b_V->size[0] * b_V->size[1];
        b_V->size[0] = V->size[0];
        b_V->size[1] = V->size[1];
        emxEnsureCapacity_real_T(b_V, b_i, &x_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_V, &b_gpu_V);
        b_i = V->size[0] * V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (V_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
          }

          V_dirtyOnCpu = false;
          ecc_detrend_kernel48<<<grid, block>>>(gpu_V, b_i, b_gpu_V);
        }

        // 'ecc_detrend:176' D = diag(real(D));
        b_i = v->size[0] * v->size[1];
        v->size[0] = D->size[0];
        v->size[1] = D->size[1];
        emxEnsureCapacity_real_T(v, b_i, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(v, &gpu_v);
        b_i = D->size[0] * D->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (D_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
          }

          D_dirtyOnCpu = false;
          ecc_detrend_kernel49<<<grid, block>>>(gpu_D, b_i, gpu_v);
          v_dirtyOnGpu = true;
        }

        if ((v->size[0] == 1) && (v->size[1] == 1)) {
          b_i = b_D->size[0];
          b_D->size[0] = 1;
          emxEnsureCapacity_real_T(b_D, b_i, &fb_emlrtRTEI);
          if (!b_D_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b_D, &b_gpu_D);
          }

          if (v_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(v, &gpu_v);
          }

          v_dirtyOnGpu = false;
          b_D->data[0] = v->data[0];
          b_D_dirtyOnCpu = true;
        } else {
          jend = v->size[0];
          npages = v->size[1];
          if (jend <= npages) {
            npages = jend;
          }

          if (v->size[1] > 0) {
            vlen = npages;
          } else {
            vlen = 0;
          }

          b_i = b_D->size[0];
          b_D->size[0] = vlen;
          emxEnsureCapacity_real_T(b_D, b_i, &cb_emlrtRTEI);
          if (!b_D_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b_D, &b_gpu_D);
          }

          b_i = v->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((vlen
            - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_D_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_D, b_D);
            }

            ecc_detrend_kernel50<<<grid, block>>>(gpu_v, vlen, b_i, b_gpu_D);
            b_D_dirtyOnCpu = false;
            b_D_dirtyOnGpu = true;
          }
        }

        // 'ecc_detrend:177' V = V(:,D/max(D)>thrPCA);
        vlen = b_D->size[0];
        if (b_D_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(b_D, &b_gpu_D);
        }

        b_D_dirtyOnGpu = false;
        d2scaled = b_D->data[0];
        for (b_i = 0; b_i <= vlen - 2; b_i++) {
          if (std::isnan(b_D->data[b_i + 1])) {
            validLaunchParams = false;
          } else if (std::isnan(d2scaled)) {
            validLaunchParams = true;
          } else {
            validLaunchParams = (d2scaled < b_D->data[b_i + 1]);
          }

          if (validLaunchParams) {
            d2scaled = b_D->data[b_i + 1];
          }
        }

        b_i = bv->size[0];
        bv->size[0] = b_D->size[0];
        emxEnsureCapacity_boolean_T(bv, b_i, &nb_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv, &gpu_bv);
        b_i = b_D->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_D_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_D, b_D);
          }

          b_D_dirtyOnCpu = false;
          cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
          ecc_detrend_kernel51<<<grid, block>>>(b_gpu_D, b_i, gpu_d2scaled,
            gpu_bv);
          bv_dirtyOnGpu = true;
        }

        n = bv->size[0] - 1;
        npages = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (bv_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv, &gpu_bv);
          }

          bv_dirtyOnGpu = false;
          if (bv->data[b_i]) {
            npages++;
          }
        }

        b_i = iv->size[0];
        iv->size[0] = npages;
        emxEnsureCapacity_int32_T(iv, b_i, &sb_emlrtRTEI);
        if (!iv_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(iv, &gpu_iv);
        }

        vlen = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (bv_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv, &gpu_bv);
          }

          bv_dirtyOnGpu = false;
          if (bv->data[b_i]) {
            iv->data[vlen] = b_i + 1;
            iv_dirtyOnCpu = true;
            vlen++;
          }
        }

        npages = b_V->size[0];
        b_i = g_V->size[0] * g_V->size[1];
        g_V->size[0] = b_V->size[0];
        g_V->size[1] = iv->size[0];
        emxEnsureCapacity_real_T(g_V, b_i, &ub_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_V, &d_gpu_V);
        b_i = iv->size[0] - 1;
        jend = g_V->size[0];
        w_dim0 = b_V->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((npages
          - 1) + 1L) * (b_i + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv, iv);
          }

          iv_dirtyOnCpu = false;
          ecc_detrend_kernel52<<<grid, block>>>(gpu_iv, b_gpu_V, npages, b_i,
            jend, w_dim0, d_gpu_V);
        }

        b_i = b_V->size[0] * b_V->size[1];
        b_V->size[0] = g_V->size[0];
        b_V->size[1] = g_V->size[1];
        emxEnsureCapacity_real_T(b_V, b_i, &bc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_V, &b_gpu_V);
        b_i = g_V->size[0] * g_V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ecc_detrend_kernel53<<<grid, block>>>(d_gpu_V, b_i, b_gpu_V);
        }

        //  discard weak dims
        // 'ecc_detrend:178' rr = rr*V;
        npages = rr->size[0];
        n = rr->size[1];
        n_dirtyOnCpu = true;
        if ((rr->size[0] == 0) || (rr->size[1] == 0) || (b_V->size[0] == 0) ||
            (b_V->size[1] == 0)) {
          nx = rr->size[0];
          npages = rr->size[0];
          n = b_V->size[1];
          b_i = rr->size[0] * rr->size[1];
          rr->size[0] = nx;
          rr->size[1] = b_V->size[1];
          emxEnsureCapacity_real_T(rr, b_i, &jc_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(rr, &gpu_rr);
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((npages * n - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
            n_dirtyOnCpu = false;
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
            }

            ecc_detrend_kernel55<<<grid, block>>>(npages, gpu_n, gpu_rr);
            rr_dirtyOnCpu = false;
            rr_dirtyOnGpu = true;
          }
        } else {
          b_i = c_A->size[0] * c_A->size[1];
          c_A->size[0] = rr->size[0];
          c_A->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(c_A, b_i, &ic_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_A, &e_gpu_A);
          w_dim0 = rr->size[0] * rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(w_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
            }

            rr_dirtyOnCpu = false;
            ecc_detrend_kernel54<<<grid, block>>>(gpu_rr, w_dim0, e_gpu_A);
          }

          b_i = rr->size[0] * rr->size[1];
          rr->size[0] = npages;
          rr->size[1] = b_V->size[1];
          emxEnsureCapacity_real_T(rr, b_i, &t_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(rr, &gpu_rr);
          }

          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, npages,
                      b_V->size[1], n, (double *)&d2scaled, (double *)
                      &e_gpu_A.data[0], npages, (double *)&b_gpu_V.data[0], n,
                      (double *)&abnrm, (double *)&gpu_rr.data[0], npages);
          rr_dirtyOnCpu = false;
          rr_dirtyOnGpu = true;
        }

        // 'ecc_detrend:179' b = (x'*rr) / (rr'*rr);
        if (b_x->size[0] == b_w->size[0]) {
          b_i = d_A->size[0] * d_A->size[1];
          d_A->size[0] = 1;
          d_A->size[1] = b_x->size[0];
          emxEnsureCapacity_real_T(d_A, b_i, &s_emlrtRTEI);
          if (!c_A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(d_A, &f_gpu_A);
          }

          b_i = b_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
            }

            b_x_dirtyOnCpu = false;
            if (c_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_A, d_A);
            }

            ecc_detrend_kernel56<<<grid, block>>>(b_gpu_w, b_mn, b_gpu_x, b_i,
              f_gpu_A);
            c_A_dirtyOnCpu = false;
            c_A_dirtyOnGpu = true;
          }
        } else {
          if (c_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_A, &f_gpu_A);
          }

          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(d_A, b_x, b_mn, b_w);
          c_A_dirtyOnGpu = false;
          c_A_dirtyOnCpu = true;
        }

        if ((d_A->size[1] == 0) || (rr->size[0] == 0) || (rr->size[1] == 0)) {
          b_i = b->size[0] * b->size[1];
          b->size[0] = 1;
          b->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(b, b_i, &u_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b, &gpu_b);
          }

          w_dim0 = rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(w_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
            }

            ecc_detrend_kernel57<<<grid, block>>>(w_dim0, gpu_b);
            b_dirtyOnCpu = false;
          }
        } else {
          b_i = b->size[0] * b->size[1];
          b->size[0] = 1;
          b->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(b, b_i, &t_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b, &gpu_b);
          }

          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          if (c_A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_A, d_A);
          }

          c_A_dirtyOnCpu = false;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          rr_dirtyOnCpu = false;
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                      rr->size[1], d_A->size[1], (double *)&d2scaled, (double *)
                      &f_gpu_A.data[0], 1, (double *)&gpu_rr.data[0], d_A->size
                      [1], (double *)&abnrm, (double *)&gpu_b.data[0], 1);
          b_dirtyOnCpu = false;
        }

        b_i = e_A->size[0] * e_A->size[1];
        e_A->size[0] = rr->size[1];
        e_A->size[1] = rr->size[0];
        emxEnsureCapacity_real_T(e_A, b_i, &s_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_A, &g_gpu_A);
        w_dim0 = rr->size[0] - 1;
        b_i = rr->size[1] - 1;
        r_dim0 = e_A->size[0];
        nx = rr->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i +
          1L) * (w_dim0 + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          rr_dirtyOnCpu = false;
          ecc_detrend_kernel58<<<grid, block>>>(gpu_rr, b_i, w_dim0, r_dim0, nx,
            g_gpu_A);
        }

        if ((e_A->size[0] == 0) || (e_A->size[1] == 0) || (rr->size[0] == 0) ||
            (rr->size[1] == 0)) {
          b_i = h_A->size[0] * h_A->size[1];
          h_A->size[0] = e_A->size[0];
          h_A->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(h_A, b_i, &u_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(h_A, &h_gpu_A);
          jend = e_A->size[0] * rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(jend +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detrend_kernel59<<<grid, block>>>(jend, h_gpu_A);
          }
        } else {
          b_i = h_A->size[0] * h_A->size[1];
          h_A->size[0] = e_A->size[0];
          h_A->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(h_A, b_i, &t_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(h_A, &h_gpu_A);
          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          rr_dirtyOnCpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      e_A->size[0], rr->size[1], e_A->size[1], (double *)
                      &d2scaled, (double *)&g_gpu_A.data[0], e_A->size[0],
                      (double *)&gpu_rr.data[0], e_A->size[1], (double *)&abnrm,
                      (double *)&h_gpu_A.data[0], e_A->size[0]);
        }

        if ((b->size[1] == 0) || ((h_A->size[0] == 0) || (h_A->size[1] == 0))) {
          sz[1] = static_cast<uint32_T>(h_A->size[0]);
          b_i = b->size[0] * b->size[1];
          b->size[0] = 1;
          b->size[1] = h_A->size[0];
          emxEnsureCapacity_real_T(b, b_i, &mc_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b, &gpu_b);
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
            static_cast<int32_T>(sz[1]) - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
            }

            ecc_detrend_kernel73<<<grid, block>>>(static_cast<int32_T>(sz[1]) -
              1, gpu_b);
            b_dirtyOnCpu = false;
          }
        } else if (h_A->size[0] == h_A->size[1]) {
          w_dim0 = h_A->size[1];
          b_i = ipiv_t->size[0];
          ipiv_t->size[0] = h_A->size[1];
          emxEnsureCapacity_int32_T(ipiv_t, b_i, &kc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(ipiv_t, &gpu_ipiv_t);
          cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), h_A->size[1],
            h_A->size[1], (double *)&h_gpu_A.data[0], h_A->size[1],
            getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(8);
          cusolverInitWorkspace();
          if (n_dirtyOnCpu) {
            cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
          }

          cusolverDnDgetrf(getCuSolverGlobalHandle(), h_A->size[1], h_A->size[1],
                           (double *)&h_gpu_A.data[0], h_A->size[1],
                           static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                           &gpu_ipiv_t.data[0], gpu_n);
          b_i = ipiv->size[0] * ipiv->size[1];
          ipiv->size[0] = 1;
          ipiv->size[1] = ipiv_t->size[0];
          emxEnsureCapacity_int32_T(ipiv, b_i, &nc_emlrtRTEI);
          if (!ipiv_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(ipiv, &gpu_ipiv);
          }

          cudaMemcpy(&n, gpu_n, 4UL, cudaMemcpyDeviceToHost);
          if (n < 0) {
            for (b_i = 0; b_i < 2; b_i++) {
              i_V[b_i] = h_A->size[b_i];
            }

            b_i = h_A->size[0] * h_A->size[1];
            h_A->size[0] = i_V[0];
            h_A->size[1] = i_V[1];
            emxEnsureCapacity_real_T(h_A, b_i, &qc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(h_A, &h_gpu_A);
            b_i = i_V[0] * i_V[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_detrend_kernel71<<<grid, block>>>(b_i, h_gpu_A);
            }

            vlen = ipiv->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((vlen - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (ipiv_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_ipiv, ipiv);
              }

              ecc_detrend_kernel72<<<grid, block>>>(vlen, gpu_ipiv);
              ipiv_dirtyOnCpu = false;
              ipiv_dirtyOnGpu = true;
            }
          } else {
            vlen = ipiv_t->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((vlen - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (ipiv_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_ipiv, ipiv);
              }

              ecc_detrend_kernel70<<<grid, block>>>(gpu_ipiv_t, vlen, gpu_ipiv);
              ipiv_dirtyOnCpu = false;
              ipiv_dirtyOnGpu = true;
            }
          }

          d2scaled = 1.0;
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
          }

          cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N, CUBLAS_DIAG_NON_UNIT,
                      1, w_dim0, (double *)&d2scaled, (double *)&h_gpu_A.data[0],
                      w_dim0, (double *)&gpu_b.data[0], 1);
          d2scaled = 1.0;
          cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                      w_dim0, (double *)&d2scaled, (double *)&h_gpu_A.data[0],
                      w_dim0, (double *)&gpu_b.data[0], 1);
          b_dirtyOnCpu = false;
          validLaunchParams = true;
          for (n = 0; n <= w_dim0 - 2; n++) {
            npages = (w_dim0 - n) - 2;
            if (ipiv_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(ipiv, &gpu_ipiv);
            }

            ipiv_dirtyOnGpu = false;
            if (ipiv->data[npages] != npages + 1) {
              if (validLaunchParams) {
                gpuEmxMemcpyGpuToCpu_real_T(b, &gpu_b);
              }

              d2scaled = b->data[npages];
              b->data[npages] = b->data[ipiv->data[npages] - 1];
              b->data[ipiv->data[npages] - 1] = d2scaled;
              ipiv_dirtyOnCpu = true;
              validLaunchParams = false;
              b_dirtyOnCpu = true;
            }
          }
        } else {
          ptrdiff_t o_info_t;
          boolean_T d_A_dirtyOnCpu;
          boolean_T e_tau_dirtyOnCpu;
          b_i = i_A->size[0] * i_A->size[1];
          i_A->size[0] = h_A->size[1];
          i_A->size[1] = h_A->size[0];
          emxEnsureCapacity_real_T(i_A, b_i, &lc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(i_A, &i_gpu_A);
          jend = h_A->size[0] - 1;
          b_i = h_A->size[1] - 1;
          r_dim0 = i_A->size[0];
          w_dim0 = h_A->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i +
            1L) * (jend + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detrend_kernel60<<<grid, block>>>(h_gpu_A, b_i, jend, r_dim0,
              w_dim0, i_gpu_A);
            d_A_dirtyOnGpu = true;
          }

          b_i = B->size[0];
          B->size[0] = b->size[1];
          emxEnsureCapacity_real_T(B, b_i, &oc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(B, &b_gpu_B);
          b_i = b->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
            }

            b_dirtyOnCpu = false;
            ecc_detrend_kernel61<<<grid, block>>>(gpu_b, b_i, b_gpu_B);
          }

          npages = i_A->size[0];
          n = i_A->size[1] - 1;
          n_dirtyOnCpu = true;
          b_i = jpvt->size[0] * jpvt->size[1];
          jpvt->size[0] = 1;
          jpvt->size[1] = i_A->size[1];
          emxEnsureCapacity_int32_T(jpvt, b_i, &rc_emlrtRTEI);
          if (!jpvt_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(jpvt, &gpu_jpvt);
          }

          jend = i_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(jend +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, jpvt);
            }

            ecc_detrend_kernel62<<<grid, block>>>(jend, gpu_jpvt);
            jpvt_dirtyOnCpu = false;
            jpvt_dirtyOnGpu = true;
          }

          jend = i_A->size[0];
          nx = i_A->size[1];
          if (jend <= nx) {
            nx = jend;
          }

          b_i = c_tau->size[0];
          c_tau->size[0] = nx;
          emxEnsureCapacity_real_T(c_tau, b_i, &sc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_tau, &e_gpu_tau);
          b_i = jpvt_t->size[0];
          jpvt_t->size[0] = i_A->size[1];
          emxEnsureCapacity_ptrdiff_t(jpvt_t, b_i, &tc_emlrtRTEI);
          for (b_i = 0; b_i < i_A->size[1]; b_i++) {
            jpvt_t->data[b_i] = (ptrdiff_t)0;
          }

          if (d_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(i_A, &i_gpu_A);
          }

          if (e_tau_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_tau, &e_gpu_tau);
          }

          o_info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)i_A->size[0], (ptrdiff_t)
            i_A->size[1], &i_A->data[0], (ptrdiff_t)i_A->size[0], &jpvt_t->data
            [0], &c_tau->data[0]);
          e_tau_dirtyOnGpu = false;
          e_tau_dirtyOnCpu = true;
          d_A_dirtyOnGpu = false;
          d_A_dirtyOnCpu = true;
          if ((int32_T)o_info_t != 0) {
            r_dim0 = i_A->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (((npages - 1) + 1L) * (n + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
              n_dirtyOnCpu = false;
              gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, i_A);
              ecc_detrend_kernel63<<<grid, block>>>(npages, gpu_n, r_dim0,
                i_gpu_A);
              d_A_dirtyOnCpu = false;
              d_A_dirtyOnGpu = true;
            }

            jend = i_A->size[0];
            npages = i_A->size[1];
            if (jend <= npages) {
              npages = jend;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_tau, c_tau);
              ecc_detrend_kernel64<<<grid, block>>>(npages, e_gpu_tau);
              e_tau_dirtyOnCpu = false;
              e_tau_dirtyOnGpu = true;
            }

            if ((nx - npages) - 1 >= 0) {
              if (e_tau_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_tau, &e_gpu_tau);
              }

              std::memset(&c_tau->data[npages], 0, static_cast<uint32_T>((nx -
                (npages + 1)) + 1) * sizeof(real_T));
              e_tau_dirtyOnGpu = false;
              e_tau_dirtyOnCpu = true;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (n_dirtyOnCpu) {
                cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
              }

              if (jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, jpvt);
              }

              ecc_detrend_kernel65<<<grid, block>>>(gpu_n, gpu_jpvt);
              jpvt_dirtyOnCpu = false;
              jpvt_dirtyOnGpu = true;
            }
          } else {
            for (b_i = 0; b_i <= n; b_i++) {
              if (jpvt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(jpvt, &gpu_jpvt);
              }

              jpvt->data[b_i] = (int32_T)jpvt_t->data[b_i];
              jpvt_dirtyOnGpu = false;
              jpvt_dirtyOnCpu = true;
            }
          }

          nx = 0;
          if (i_A->size[0] < i_A->size[1]) {
            npages = i_A->size[0];
            vlen = i_A->size[1];
          } else {
            npages = i_A->size[1];
            vlen = i_A->size[0];
          }

          if (d_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(i_A, &i_gpu_A);
          }

          d_A_dirtyOnGpu = false;
          d2scaled = std::fmin(1.4901161193847656E-8, 2.2204460492503131E-15 *
                               static_cast<real_T>(vlen)) * std::abs(i_A->data[0]);
          while ((nx < npages) && (!(std::abs(i_A->data[nx + i_A->size[0] * nx])
                   <= d2scaled))) {
            nx++;
          }

          vlen = i_A->size[1];
          b_i = Y->size[0];
          Y->size[0] = i_A->size[1];
          emxEnsureCapacity_real_T(Y, b_i, &xc_emlrtRTEI);
          if (!Y_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(Y, &gpu_Y);
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((vlen
            - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, Y);
            }

            ecc_detrend_kernel66<<<grid, block>>>(vlen, gpu_Y);
            Y_dirtyOnCpu = false;
            Y_dirtyOnGpu = true;
          }

          n = 0;
          jend = i_A->size[0];
          npages = i_A->size[1];
          if (jend <= npages) {
            npages = jend;
          }

          if (d_A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, i_A);
          }

          if (e_tau_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_tau, c_tau);
          }

          cusolverDnDormqr_bufferSize(getCuSolverGlobalHandle(),
            CUBLAS_SIDE_LEFT, CUBLAS_OP_T, B->size[0], 1, npages, (double *)
            &i_gpu_A.data[0], i_A->size[0], (double *)&e_gpu_tau.data[0],
            (double *)&b_gpu_B.data[0], B->size[0], getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(8);
          cusolverInitWorkspace();
          cudaMemcpy(gpu_n, &n, 4UL, cudaMemcpyHostToDevice);
          cusolverDnDormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                           CUBLAS_OP_T, B->size[0], 1, npages, (double *)
                           &i_gpu_A.data[0], i_A->size[0], (double *)
                           &e_gpu_tau.data[0], (double *)&b_gpu_B.data[0],
                           B->size[0], static_cast<real_T *>
                           (getCuSolverWorkspaceBuff()),
                           *getCuSolverWorkspaceReq(), gpu_n);
          cudaMemcpy(&n, gpu_n, 4UL, cudaMemcpyDeviceToHost);
          if (n < 0) {
            vlen = B->size[0];
            b_i = B->size[0];
            B->size[0] = vlen;
            emxEnsureCapacity_real_T(B, b_i, &cd_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(B, &b_gpu_B);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((vlen - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_detrend_kernel67<<<grid, block>>>(vlen, b_gpu_B);
            }
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx -
            1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, jpvt);
            }

            jpvt_dirtyOnCpu = false;
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, Y);
            }

            ecc_detrend_kernel68<<<grid, block>>>(b_gpu_B, gpu_jpvt, nx, gpu_Y);
            Y_dirtyOnCpu = false;
            Y_dirtyOnGpu = true;
          }

          for (n = 0; n < nx; n++) {
            npages = (nx - n) - 1;
            if (Y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(Y, &gpu_Y);
            }

            if (jpvt_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(jpvt, &gpu_jpvt);
            }

            Y->data[jpvt->data[npages] - 1] /= i_A->data[npages + i_A->size[0] *
              npages];
            jpvt_dirtyOnGpu = false;
            jpvt_dirtyOnCpu = true;
            Y_dirtyOnGpu = false;
            Y_dirtyOnCpu = true;
            for (b_i = 0; b_i < npages; b_i++) {
              Y->data[jpvt->data[b_i] - 1] -= Y->data[jpvt->data[npages] - 1] *
                i_A->data[b_i + i_A->size[0] * npages];
            }
          }

          b_i = b->size[0] * b->size[1];
          b->size[0] = 1;
          b->size[1] = Y->size[0];
          emxEnsureCapacity_real_T(b, b_i, &mc_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b, &gpu_b);
          }

          b_i = Y->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, Y);
            }

            Y_dirtyOnCpu = false;
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
            }

            ecc_detrend_kernel69<<<grid, block>>>(gpu_Y, b_i, gpu_b);
            b_dirtyOnCpu = false;
          }
        }

        // 'ecc_detrend:180' z = r*(V*b') + mn;
        b_i = b_B->size[0];
        b_B->size[0] = b->size[1];
        emxEnsureCapacity_real_T(b_B, b_i, &pc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_B, &gpu_B);
        b_i = b->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
          }

          b_dirtyOnCpu = false;
          ecc_detrend_kernel74<<<grid, block>>>(gpu_b, b_i, gpu_B);
        }

        if ((b_V->size[0] == 0) || (b_V->size[1] == 0) || (b_B->size[0] == 0)) {
          b_i = c_y->size[0];
          c_y->size[0] = b_V->size[0];
          emxEnsureCapacity_real_T(c_y, b_i, &u_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_y, &c_gpu_y);
          b_i = b_V->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detrend_kernel75<<<grid, block>>>(b_i, c_gpu_y);
          }
        } else {
          b_i = c_y->size[0];
          c_y->size[0] = b_V->size[0];
          emxEnsureCapacity_real_T(c_y, b_i, &t_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_y, &c_gpu_y);
          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      b_V->size[0], 1, b_V->size[1], (double *)&d2scaled,
                      (double *)&b_gpu_V.data[0], b_V->size[0], (double *)
                      &gpu_B.data[0], b_V->size[1], (double *)&abnrm, (double *)
                      &c_gpu_y.data[0], b_V->size[0]);
        }

        if ((c_r->size[0] == 0) || (c_r->size[1] == 0) || (c_y->size[0] == 0)) {
          b_i = dv7->size[0];
          dv7->size[0] = c_r->size[0];
          emxEnsureCapacity_real_T(dv7, b_i, &uc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(dv7, &gpu_dv7);
          w_dim0 = c_r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(w_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detrend_kernel76<<<grid, block>>>(w_dim0, gpu_dv7);
            dv7_dirtyOnGpu = true;
          }
        } else {
          b_i = dv7->size[0];
          dv7->size[0] = c_r->size[0];
          emxEnsureCapacity_real_T(dv7, b_i, &t_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(dv7, &gpu_dv7);
          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          if (r_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, c_r);
          }

          r_dirtyOnCpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      c_r->size[0], 1, c_r->size[1], (double *)&d2scaled,
                      (double *)&b_gpu_r.data[0], c_r->size[0], (double *)
                      &c_gpu_y.data[0], c_r->size[1], (double *)&abnrm, (double *)
                      &gpu_dv7.data[0], c_r->size[0]);
          dv7_dirtyOnGpu = true;
        }

        if (dv7->size[0] == b_x->size[0]) {
          b_i = z->size[0];
          z->size[0] = dv7->size[0];
          emxEnsureCapacity_real_T(z, b_i, &vc_emlrtRTEI);
          if (!z_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(z, &gpu_z);
          }

          b_i = dv7->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
            }

            b_x_dirtyOnCpu = false;
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, z);
            }

            ecc_detrend_kernel77<<<grid, block>>>(mn, b_gpu_x, gpu_dv7, b_i,
              gpu_z);
            z_dirtyOnCpu = false;
            z_dirtyOnGpu = true;
          }
        } else {
          if (z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(z, &gpu_z);
          }

          if (dv7_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv7, &gpu_dv7);
          }

          dv7_dirtyOnGpu = false;
          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          binary_expand_op(z, dv7, b_x, mn);
          z_dirtyOnGpu = false;
          z_dirtyOnCpu = true;
        }

        //  Find outliers
        // 'ecc_detrend:88' d = (x-z).*w;
        if (b_x->size[0] == 1) {
          w_dim0 = z->size[0];
        } else {
          w_dim0 = b_x->size[0];
        }

        if ((b_x->size[0] == z->size[0]) && (w_dim0 == b_w->size[0])) {
          b_i = d->size[0];
          d->size[0] = b_x->size[0];
          emxEnsureCapacity_real_T(d, b_i, &wc_emlrtRTEI);
          if (!d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(d, &gpu_d);
          }

          b_i = b_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, z);
            }

            z_dirtyOnCpu = false;
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
            }

            b_x_dirtyOnCpu = false;
            if (d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, d);
            }

            ecc_detrend_kernel78<<<grid, block>>>(b_gpu_w, gpu_z, b_gpu_x, b_i,
              gpu_d);
            d_dirtyOnCpu = false;
            d_dirtyOnGpu = true;
          }
        } else {
          if (d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d, &gpu_d);
          }

          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          if (z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(z, &gpu_z);
          }

          z_dirtyOnGpu = false;
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          binary_expand_op(d, b_x, z, b_w);
          d_dirtyOnGpu = false;
          d_dirtyOnCpu = true;
        }

        // 'ecc_detrend:89' thrItr = thr*std(d);
        w_dim0 = d->size[0] - 2;
        if (d->size[0] == 0) {
          abnrm = rtNaN;
        } else if (d->size[0] == 1) {
          if (d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d, &gpu_d);
          }

          d_dirtyOnGpu = false;
          if ((!std::isinf(d->data[0])) && (!std::isnan(d->data[0]))) {
            abnrm = 0.0;
          } else {
            abnrm = rtNaN;
          }
        } else {
          if (d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d, &gpu_d);
          }

          d_dirtyOnGpu = false;
          d2scaled = d->data[0];
          for (b_i = 0; b_i <= w_dim0; b_i++) {
            d2scaled += d->data[b_i + 1];
          }

          d2scaled /= static_cast<real_T>(d->size[0]);
          b_i = absdiff->size[0];
          absdiff->size[0] = d->size[0];
          emxEnsureCapacity_real_T(absdiff, b_i, &yc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(absdiff, &gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((w_dim0 + 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, d);
            }

            d_dirtyOnCpu = false;
            cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
            ecc_detrend_kernel79<<<grid, block>>>(gpu_d, w_dim0, gpu_d2scaled,
              gpu_absdiff);
          }

          if (abnrm_dirtyOnGpu) {
            cudaMemcpy(&abnrm, gpu_abnrm, 8UL, cudaMemcpyDeviceToHost);
          }

          cublasDnrm2(getCublasGlobalHandle(), d->size[0], (double *)
                      &gpu_absdiff.data[0], 1, (double *)&abnrm);
          abnrm /= std::sqrt(static_cast<real_T>(d->size[0]) - 1.0);
        }

        d2scaled = thr * abnrm;

        // 'ecc_detrend:90' w(abs(d)>thrItr) = 0;
        nx = d->size[0] - 1;
        b_i = d_y->size[0];
        d_y->size[0] = d->size[0];
        emxEnsureCapacity_real_T(d_y, b_i, &ad_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_y, &d_gpu_y);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, d);
          }

          d_dirtyOnCpu = false;
          ecc_detrend_kernel80<<<grid, block>>>(gpu_d, nx, d_gpu_y);
        }

        b_i = bv2->size[0];
        bv2->size[0] = d_y->size[0];
        emxEnsureCapacity_boolean_T(bv2, b_i, &bd_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv2, &gpu_bv2);
        b_i = d_y->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
          ecc_detrend_kernel81<<<grid, block>>>(d_gpu_y, b_i, gpu_d2scaled,
            gpu_bv2);
          bv2_dirtyOnGpu = true;
        }

        n = bv2->size[0] - 1;
        npages = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (bv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv2, &gpu_bv2);
          }

          bv2_dirtyOnGpu = false;
          if (bv2->data[b_i]) {
            npages++;
          }
        }

        b_i = iv4->size[0];
        iv4->size[0] = npages;
        emxEnsureCapacity_int32_T(iv4, b_i, &dd_emlrtRTEI);
        if (!iv4_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(iv4, &gpu_iv4);
        }

        vlen = 0;
        for (b_i = 0; b_i <= n; b_i++) {
          if (bv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv2, &gpu_bv2);
          }

          bv2_dirtyOnGpu = false;
          if (bv2->data[b_i]) {
            iv4->data[vlen] = b_i + 1;
            iv4_dirtyOnCpu = true;
            vlen++;
          }
        }

        b_i = iv4->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv4_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv4, iv4);
          }

          iv4_dirtyOnCpu = false;
          ecc_detrend_kernel82<<<grid, block>>>(gpu_iv4, b_i, b_gpu_w);
          b_w_dirtyOnGpu = true;
        }

        //  update weights
      }

      // 'ecc_detrend:92' x = x-z;
      vlen = x->size[0];
      if (vlen == z->size[0]) {
        b_i = b_x->size[0];
        b_x->size[0] = vlen;
        emxEnsureCapacity_real_T(b_x, b_i, &m_emlrtRTEI);
        if (!b_x_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(b_x, &b_gpu_x);
        }

        nx = x->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((vlen -
          1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (z_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, z);
          }

          z_dirtyOnCpu = false;
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
          }

          x_dirtyOnCpu = false;
          if (b_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
          }

          ecc_detrend_kernel83<<<grid, block>>>(gpu_z, ch, gpu_x, vlen, nx,
            b_gpu_x);
          b_x_dirtyOnCpu = false;
          b_x_dirtyOnGpu = true;
        }
      } else {
        if (b_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
        }

        if (x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
        }

        x_dirtyOnGpu = false;
        if (z_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(z, &gpu_z);
        }

        z_dirtyOnGpu = false;
        binary_expand_op(b_x, x, ch, z);
        b_x_dirtyOnGpu = false;
        b_x_dirtyOnCpu = true;
      }
    }

    b_i = b_x->size[0] - 1;
    nx = x->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (b_x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
      }

      b_x_dirtyOnCpu = false;
      if (x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
      }

      ecc_detrend_kernel202<<<grid, block>>>(b_gpu_x, ch, b_i, nx, gpu_x);
      x_dirtyOnCpu = false;
      x_dirtyOnGpu = true;
    }

    b_i = b_w->size[0] - 1;
    w_dim0 = w->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (w_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, w);
      }

      ecc_detrend_kernel203<<<grid, block>>>(b_gpu_w, ch, b_i, w_dim0, gpu_w);
      w_dirtyOnCpu = false;
      w_dirtyOnGpu = true;
    }
  }

  emxFree_real_T(&d_a);
  emxFree_real_T(&b_trend);
  emxFree_real_T(&j_x);
  emxFree_real_T(&h_V);
  emxFree_real_T(&d_r);
  emxFree_real_T(&g_V);
  emxFree_int32_T(&iv10);
  emxFree_boolean_T(&bv6);
  emxFree_real_T(&j_y);
  emxFree_real_T(&c_absdiff);
  emxFree_real_T(&c_d);
  emxFree_int32_T(&iv9);
  emxFree_boolean_T(&bv5);
  emxFree_int32_T(&iv8);
  emxFree_boolean_T(&bv4);
  emxFree_int8_T(&c_a);
  emxFree_real_T(&i_y);
  emxFree_real_T(&c_b);
  emxFree_real_T(&h_y);
  emxFree_real_T(&g_y);
  emxFree_real_T(&f_y);
  emxFree_int8_T(&b_a);
  emxFree_real_T(&yy);
  emxFree_real_T(&b_absdiff);
  emxFree_real_T(&b_d);
  emxFree_real_T(&dv13);
  emxFree_ptrdiff_t(&b_jpvt_t);
  emxFree_real_T(&e_y);
  emxFree_real_T(&f_tau);
  emxFree_int32_T(&b_ipiv_t);
  emxFree_int32_T(&b_jpvt);
  emxFree_real_T(&d_B);
  emxFree_int32_T(&b_ipiv);
  emxFree_real_T(&c_B);
  emxFree_real_T(&n_A);
  emxFree_real_T(&b_Y);
  emxFree_real_T(&m_A);
  emxFree_real_T(&d_wi);
  emxFree_real_T(&d_wr);
  emxFree_real_T(&l_A);
  emxFree_real_T(&c_wi);
  emxFree_real_T(&b_b);
  emxFree_real_T(&c_wr);
  emxFree_real_T(&b_vright);
  emxFree_real_T(&b_wimag);
  emxFree_real_T(&k_A);
  emxFree_int32_T(&iv4);
  emxFree_real_T(&e_tau);
  emxFree_real_T(&b_wreal);
  emxFree_real_T(&j_A);
  emxFree_boolean_T(&bv2);
  emxFree_creal_T(&b_W);
  emxFree_real_T(&b_U);
  emxFree_real_T(&d_tau);
  emxFree_real_T(&b_scale);
  emxFree_real_T(&d_y);
  emxFree_real_T(&absdiff);
  emxFree_real_T(&f_V);
  emxFree_int32_T(&iv2);
  emxFree_real_T(&d);
  emxFree_boolean_T(&bv1);
  emxFree_real_T(&dv7);
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_real_T(&d_D);
  emxFree_real_T(&b_v);
  emxFree_real_T(&c_y);
  emxFree_real_T(&c_tau);
  emxFree_int32_T(&ipiv_t);
  emxFree_real_T(&e_V);
  emxFree_int32_T(&jpvt);
  emxFree_real_T(&b_B);
  emxFree_creal_T(&c_D);
  emxFree_int32_T(&ipiv);
  emxFree_real_T(&B);
  emxFree_real_T(&i_A);
  emxFree_creal_T(&d_V);
  emxFree_real_T(&Y);
  emxFree_real_T(&h_A);
  emxFree_real_T(&b_wi);
  emxFree_real_T(&b_wr);
  emxFree_real_T(&g_A);
  emxFree_real_T(&f_A);
  emxFree_real_T(&e_A);
  emxFree_real_T(&b_rr);
  emxFree_real_T(&wi);
  emxFree_real_T(&b);
  emxFree_real_T(&wr);
  emxFree_real_T(&vright);
  emxFree_real_T(&wimag);
  emxFree_real_T(&d_A);
  emxFree_real_T(&b_tau);
  emxFree_real_T(&wreal);
  emxFree_real_T(&c_A);
  emxFree_creal_T(&W);
  emxFree_real_T(&U);
  emxFree_real_T(&tau);
  emxFree_real_T(&scale);
  emxFree_real_T(&i_x);
  emxFree_real_T(&b_y);
  emxFree_real_T(&c_V);
  emxFree_int32_T(&iv);
  emxFree_boolean_T(&bv);
  emxFree_real_T(&h_x);
  emxFree_real_T(&b_D);
  emxFree_real_T(&v);
  emxFree_real_T(&b_V);
  emxFree_creal_T(&D);
  emxFree_creal_T(&V);
  emxFree_real_T(&g_x);
  emxFree_real_T(&b_A);
  emxFree_real_T(&A);
  emxFree_real_T(&rr);
  emxFree_real_T(&c_r);
  emxFree_real_T(&dv1);
  emxFree_real_T(&b_z);
  emxFree_real_T(&b_lin);
  emxFree_real_T(&f_x);
  emxFree_real_T(&y);
  emxFree_real_T(&b_r);
  emxFree_real_T(&e_x);
  emxFree_real_T(&d_x);
  emxFree_real_T(&minval);
  emxFree_real_T(&dv);
  emxFree_real_T(&z);
  emxFree_real_T(&lin);
  emxFree_real_T(&a);
  emxFree_real_T(&r);
  emxFree_real_T(&trend);
  emxFree_real_T(&c_x);
  emxFree_real_T(&b_w);
  emxFree_real_T(&b_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
  }

  if (w_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(w, &gpu_w);
  }

  mwCudaFree(gpu_dc);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&b_gpu_x);
  gpuEmxFree_real_T(&gpu_w);
  gpuEmxFree_real_T(&b_gpu_w);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_real_T(&gpu_trend);
  gpuEmxFree_real_T(&gpu_a);
  mwCudaFree(gpu_d2scaled);
  gpuEmxFree_real_T(&gpu_lin);
  gpuEmxFree_real_T(&gpu_dv);
  gpuEmxFree_real_T(&gpu_r);
  gpuEmxFree_real_T(&gpu_z);
  gpuEmxFree_real_T(&gpu_minval);
  gpuEmxFree_real_T(&d_gpu_x);
  gpuEmxFree_real_T(&e_gpu_x);
  gpuEmxFree_real_T(&f_gpu_x);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_real_T(&b_gpu_lin);
  gpuEmxFree_real_T(&gpu_dv1);
  mwCudaFree(gpu_abnrm);
  gpuEmxFree_real_T(&b_gpu_r);
  gpuEmxFree_real_T(&c_gpu_r);
  gpuEmxFree_real_T(&gpu_rr);
  gpuEmxFree_real_T(&gpu_A);
  gpuEmxFree_real_T(&g_gpu_x);
  gpuEmxFree_real_T(&b_gpu_A);
  gpuEmxFree_real_T(&h_gpu_x);
  gpuEmxFree_creal_T(&gpu_V);
  gpuEmxFree_real_T(&b_gpu_V);
  gpuEmxFree_creal_T(&gpu_D);
  gpuEmxFree_real_T(&gpu_v);
  gpuEmxFree_real_T(&i_gpu_x);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&c_gpu_V);
  gpuEmxFree_real_T(&gpu_U);
  gpuEmxFree_real_T(&b_gpu_D);
  gpuEmxFree_boolean_T(&gpu_bv);
  gpuEmxFree_real_T(&gpu_tau);
  gpuEmxFree_real_T(&gpu_wimag);
  gpuEmxFree_real_T(&gpu_wreal);
  mwCudaFree(gpu_n);
  gpuEmxFree_creal_T(&gpu_W);
  gpuEmxFree_real_T(&d_gpu_r);
  gpuEmxFree_real_T(&b_gpu_tau);
  gpuEmxFree_real_T(&b_gpu_rr);
  gpuEmxFree_real_T(&c_gpu_A);
  gpuEmxFree_real_T(&gpu_vright);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_real_T(&d_gpu_V);
  gpuEmxFree_real_T(&d_gpu_A);
  gpuEmxFree_real_T(&e_gpu_A);
  gpuEmxFree_creal_T(&e_gpu_V);
  gpuEmxFree_real_T(&f_gpu_V);
  gpuEmxFree_creal_T(&c_gpu_D);
  gpuEmxFree_real_T(&b_gpu_v);
  gpuEmxFree_real_T(&f_gpu_A);
  gpuEmxFree_real_T(&g_gpu_V);
  gpuEmxFree_real_T(&gpu_b);
  gpuEmxFree_real_T(&b_gpu_U);
  gpuEmxFree_real_T(&d_gpu_D);
  gpuEmxFree_boolean_T(&gpu_bv1);
  gpuEmxFree_real_T(&c_gpu_tau);
  gpuEmxFree_real_T(&g_gpu_A);
  gpuEmxFree_real_T(&b_gpu_wimag);
  gpuEmxFree_real_T(&b_gpu_wreal);
  gpuEmxFree_creal_T(&b_gpu_W);
  gpuEmxFree_real_T(&d_gpu_tau);
  gpuEmxFree_real_T(&b_gpu_vright);
  gpuEmxFree_real_T(&h_gpu_A);
  gpuEmxFree_int32_T(&gpu_iv2);
  gpuEmxFree_real_T(&h_gpu_V);
  gpuEmxFree_int32_T(&gpu_ipiv_t);
  gpuEmxFree_real_T(&i_gpu_A);
  gpuEmxFree_real_T(&gpu_B);
  gpuEmxFree_real_T(&b_gpu_B);
  gpuEmxFree_int32_T(&gpu_ipiv);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&j_gpu_A);
  gpuEmxFree_int32_T(&gpu_jpvt);
  gpuEmxFree_real_T(&gpu_dv7);
  gpuEmxFree_real_T(&k_gpu_A);
  gpuEmxFree_real_T(&b_gpu_b);
  gpuEmxFree_real_T(&gpu_d);
  gpuEmxFree_real_T(&e_gpu_tau);
  gpuEmxFree_real_T(&l_gpu_A);
  gpuEmxFree_real_T(&gpu_Y);
  gpuEmxFree_real_T(&gpu_absdiff);
  gpuEmxFree_real_T(&d_gpu_y);
  gpuEmxFree_real_T(&m_gpu_A);
  gpuEmxFree_boolean_T(&gpu_bv2);
  gpuEmxFree_int32_T(&b_gpu_ipiv_t);
  gpuEmxFree_int32_T(&gpu_iv4);
  gpuEmxFree_real_T(&n_gpu_A);
  gpuEmxFree_real_T(&c_gpu_B);
  gpuEmxFree_real_T(&d_gpu_B);
  gpuEmxFree_int32_T(&b_gpu_ipiv);
  gpuEmxFree_real_T(&e_gpu_y);
  gpuEmxFree_int32_T(&b_gpu_jpvt);
  gpuEmxFree_real_T(&gpu_dv13);
  gpuEmxFree_real_T(&b_gpu_z);
  gpuEmxFree_real_T(&b_gpu_d);
  gpuEmxFree_real_T(&f_gpu_tau);
  gpuEmxFree_real_T(&b_gpu_Y);
  gpuEmxFree_real_T(&gpu_yy);
  gpuEmxFree_real_T(&b_gpu_absdiff);
  gpuEmxFree_int8_T(&b_gpu_a);
  gpuEmxFree_real_T(&f_gpu_y);
  gpuEmxFree_real_T(&g_gpu_y);
  gpuEmxFree_int8_T(&c_gpu_a);
  gpuEmxFree_real_T(&h_gpu_y);
  gpuEmxFree_real_T(&i_gpu_y);
  gpuEmxFree_real_T(&c_gpu_b);
  gpuEmxFree_real_T(&j_gpu_x);
  gpuEmxFree_real_T(&b_gpu_trend);
  gpuEmxFree_real_T(&d_gpu_a);
  gpuEmxFree_boolean_T(&gpu_bv4);
  gpuEmxFree_int32_T(&gpu_iv8);
  gpuEmxFree_boolean_T(&gpu_bv5);
  gpuEmxFree_int32_T(&gpu_iv9);
  gpuEmxFree_real_T(&c_gpu_d);
  gpuEmxFree_real_T(&c_gpu_absdiff);
  gpuEmxFree_real_T(&j_gpu_y);
  gpuEmxFree_boolean_T(&gpu_bv6);
  gpuEmxFree_int32_T(&gpu_iv10);
}

void ecc_detrend_api(const mxArray * const prhs[6], int32_T nlhs, const mxArray *
                     plhs[2])
{
  emxArray_real_T *w;
  emxArray_real_T *x;
  const mxArray *prhs_copy_idx_0;
  const mxArray *prhs_copy_idx_1;
  real_T nItr;
  real_T order;
  real_T thr;
  real_T winSz;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_0 = emlrtProtectR2012b(prhs[0], 0, true, -1);
  prhs_copy_idx_1 = emlrtProtectR2012b(prhs[1], 1, true, -1);

  // Marshall function inputs
  emxInit_real_T(&x, 2, &emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs_copy_idx_0), "x", x);
  emxInit_real_T(&w, 2, &emlrtRTEI, true);
  w->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs_copy_idx_1), "w", w);
  order = emlrt_marshallIn(emlrtAliasP(prhs[2]), "order");
  thr = emlrt_marshallIn(emlrtAliasP(prhs[3]), "thr");
  nItr = emlrt_marshallIn(emlrtAliasP(prhs[4]), "nItr");
  winSz = emlrt_marshallIn(emlrtAliasP(prhs[5]), "winSz");

  // Invoke the target function
  ecc_detrend(x, w, order, thr, nItr, winSz);

  // Marshall function outputs
  x->canFreeData = false;
  emlrt_marshallOut(x, prhs_copy_idx_0);
  emxFree_real_T(&x);
  plhs[0] = prhs_copy_idx_0;
  if (nlhs > 1) {
    w->canFreeData = false;
    emlrt_marshallOut(w, prhs_copy_idx_1);
    plhs[1] = prhs_copy_idx_1;
  }

  emxFree_real_T(&w);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ecc_detrend_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  cusolverDestroyWorkspace();
  cusolverEnsureDestruction();
}

void ecc_detrend_initialize()
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
    ecc_detrend_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ecc_detrend_terminate()
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

// End of code generation (ecc_detrend.cu)
