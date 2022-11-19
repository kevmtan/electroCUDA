//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecu_detrend.cu
//
// Code generation for function 'ecu_detrend'
//

// Include files
#include "ecu_detrend.h"
#include "_coder_ecu_detrend_mex.h"
#include "ecu_detrend_types.h"
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
struct emxArray_int8_T
{
  int8_T *data;
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

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{ nullptr };

emlrtContext emlrtContextGlobal{ true, // bFirstTime
  false,                               // bInitialized
  131627U,                             // fVersionInfo
  nullptr,                             // fErrorFunction
  "ecu_detrend",                       // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 3130694236U, 2616137409U, 972914731U, 129233577U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtMCInfo emlrtMCI{ 27,       // lineNo
  5,                                   // colNo
  "error",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/lang/error.m"// pName
};

static emlrtMCInfo b_emlrtMCI{ 353,    // lineNo
  9,                                   // colNo
  "fold_lfn",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo emlrtRTEI{ 234,    // lineNo
  20,                                  // colNo
  "ixfun",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/ixfun.m"// pName
};

static emlrtRTEInfo b_emlrtRTEI{ 1,    // lineNo
  1,                                   // colNo
  "_coder_ecu_detrend_api",            // fName
  ""                                   // pName
};

static emlrtRTEInfo c_emlrtRTEI{ 38,   // lineNo
  5,                                   // colNo
  "ecu_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_detrend.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 13,   // lineNo
  5,                                   // colNo
  "any",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/any.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 45,   // lineNo
  43,                                  // colNo
  "ecu_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_detrend.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 45,   // lineNo
  76,                                  // colNo
  "ecu_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_detrend.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 142,  // lineNo
  24,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 42,   // lineNo
  6,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 146,  // lineNo
  28,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 147,  // lineNo
  28,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 148,  // lineNo
  24,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 96,   // lineNo
  28,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 96,   // lineNo
  43,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 49,   // lineNo
  20,                                  // colNo
  "linspace",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/linspace.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 116,  // lineNo
  24,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 39,   // lineNo
  6,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 235,  // lineNo
  23,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 305,  // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 326,  // lineNo
  18,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 235,  // lineNo
  10,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 244,  // lineNo
  23,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 244,  // lineNo
  10,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 59,   // lineNo
  28,                                  // colNo
  "repmat",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/repmat.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 245,  // lineNo
  23,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 170, // lineNo
  24,                                  // colNo
  "combineVectorElements",             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 97,  // lineNo
  13,                                  // colNo
  "combineVectorElements",             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 245, // lineNo
  10,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 20,  // lineNo
  1,                                   // colNo
  "sum",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/sum.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 245, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 44,  // lineNo
  36,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 158, // lineNo
  24,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 94,  // lineNo
  5,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 68,  // lineNo
  24,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 72,  // lineNo
  28,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 248, // lineNo
  28,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 97,  // lineNo
  9,                                   // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 109, // lineNo
  24,                                  // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 83,  // lineNo
  24,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 100, // lineNo
  5,                                   // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 42,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 86,  // lineNo
  21,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 69,  // lineNo
  13,                                  // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 46,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 115, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 248, // lineNo
  17,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 101, // lineNo
  13,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 116, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 118, // lineNo
  35,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 137, // lineNo
  10,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 17,  // lineNo
  5,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 111, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 137, // lineNo
  12,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 112, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 119, // lineNo
  9,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 144, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 152, // lineNo
  16,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 248, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 145, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 129, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 32,  // lineNo
  13,                                  // colNo
  "eigStandard",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/private/eigStandard.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 130, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 249, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 18,  // lineNo
  29,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 44,  // lineNo
  32,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 250, // lineNo
  10,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 50,  // lineNo
  31,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 44,  // lineNo
  35,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 251, // lineNo
  22,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 53,  // lineNo
  13,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 61,  // lineNo
  9,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 92,  // lineNo
  22,                                  // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 105, // lineNo
  1,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 85,  // lineNo
  1,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 119, // lineNo
  5,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 321, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 332, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 44,  // lineNo
  48,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo ed_emlrtRTEI{ 119, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo fd_emlrtRTEI{ 321, // lineNo
  9,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo gd_emlrtRTEI{ 332, // lineNo
  9,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo hd_emlrtRTEI{ 167, // lineNo
  9,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo id_emlrtRTEI{ 122, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo jd_emlrtRTEI{ 124, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo kd_emlrtRTEI{ 30,  // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo ld_emlrtRTEI{ 125, // lineNo
  8,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo md_emlrtRTEI{ 126, // lineNo
  34,                                  // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo nd_emlrtRTEI{ 129, // lineNo
  9,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo od_emlrtRTEI{ 57,  // lineNo
  48,                                  // colNo
  "ixfun",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/ixfun.m"// pName
};

static emlrtRTEInfo pd_emlrtRTEI{ 171, // lineNo
  18,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo qd_emlrtRTEI{ 28,  // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo rd_emlrtRTEI{ 173, // lineNo
  30,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo sd_emlrtRTEI{ 113, // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo td_emlrtRTEI{ 171, // lineNo
  13,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo ud_emlrtRTEI{ 173, // lineNo
  13,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo vd_emlrtRTEI{ 175, // lineNo
  13,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo wd_emlrtRTEI{ 320, // lineNo
  20,                                  // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo xd_emlrtRTEI{ 179, // lineNo
  27,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo yd_emlrtRTEI{ 180, // lineNo
  31,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo ae_emlrtRTEI{ 181, // lineNo
  27,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo be_emlrtRTEI{ 191, // lineNo
  7,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo ce_emlrtRTEI{ 42,  // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo de_emlrtRTEI{ 193, // lineNo
  11,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo ee_emlrtRTEI{ 196, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo fe_emlrtRTEI{ 198, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo ge_emlrtRTEI{ 199, // lineNo
  8,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo he_emlrtRTEI{ 203, // lineNo
  9,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo ie_emlrtRTEI{ 10,  // lineNo
  8,                                   // colNo
  "isany",                             // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/admin/isany.m"// pName
};

static emlrtRTEInfo je_emlrtRTEI{ 1,   // lineNo
  18,                                  // colNo
  "ecu_detrend",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecu_detrend.m"// pName
};

static emlrtRTEInfo ke_emlrtRTEI{ 147, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo le_emlrtRTEI{ 148, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo me_emlrtRTEI{ 156, // lineNo
  23,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo ne_emlrtRTEI{ 97,  // lineNo
  9,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo oe_emlrtRTEI{ 55,  // lineNo
  15,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo pe_emlrtRTEI{ 49,  // lineNo
  9,                                   // colNo
  "mean",                              // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/mean.m"// pName
};

static emlrtRTEInfo qe_emlrtRTEI{ 326, // lineNo
  14,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo re_emlrtRTEI{ 248, // lineNo
  23,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo se_emlrtRTEI{ 83,  // lineNo
  1,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo te_emlrtRTEI{ 111, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ue_emlrtRTEI{ 112, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ve_emlrtRTEI{ 115, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo we_emlrtRTEI{ 116, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo xe_emlrtRTEI{ 118, // lineNo
  10,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ye_emlrtRTEI{ 44,  // lineNo
  9,                                   // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo af_emlrtRTEI{ 18,  // lineNo
  5,                                   // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo bf_emlrtRTEI{ 251, // lineNo
  9,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo cf_emlrtRTEI{ 126, // lineNo
  9,                                   // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo df_emlrtRTEI{ 171, // lineNo
  45,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo ef_emlrtRTEI{ 175, // lineNo
  18,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo ff_emlrtRTEI{ 173, // lineNo
  18,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo gf_emlrtRTEI{ 175, // lineNo
  30,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo hf_emlrtRTEI{ 123, // lineNo
  25,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo if_emlrtRTEI{ 123, // lineNo
  21,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo jf_emlrtRTEI{ 252, // lineNo
  9,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo kf_emlrtRTEI{ 192, // lineNo
  13,                                  // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo lf_emlrtRTEI{ 192, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

static emlrtRTEInfo mf_emlrtRTEI{ 134, // lineNo
  5,                                   // colNo
  "ec_detrendCompute",                 // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ec_detrendCompute.m"// pName
};

// Function Declarations
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2);
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5);
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_boolean_T *in3);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static real_T b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_boolean_T *ret);
static void b_error(const mxArray *m, emlrtMCInfo *location);
static void binary_expand_op(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_boolean_T *in5);
static void binary_expand_op(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6, int32_T in7, int32_T in8, const
  emxArray_real_T *in9, const emxArray_real_T *in10);
static void binary_expand_op(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6, const emxArray_real_T *in7);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4);
static void binary_expand_op(emxArray_boolean_T *in1, const emxArray_real_T *in2,
  real_T in3, real_T in4, const int32_T in5[2]);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_boolean_T *in2,
  int32_T in3, int32_T in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, int32_T in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_boolean_T *in3);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_boolean_T *in2);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, const emxArray_real_T *in4);
static void c_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_boolean_T *in3);
namespace coder
{
  namespace internal
  {
    static void expand_min(const emxArray_boolean_T *a, const emxArray_boolean_T
      *b, emxArray_boolean_T *c);
  }
}

static void d_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_boolean_T *in3);
static void disp(const mxArray *m, emlrtMCInfo *location);
static __global__ void ecu_detrend_kernel1(creal_T *dc);
static __global__ void ecu_detrend_kernel10(const int32_T lin_dim1,
  emxArray_real_T lin);
static __global__ void ecu_detrend_kernel100(const real_T rconde, real_T
  *d2scaled, int32_T *na, emxArray_real_T y);
static __global__ void ecu_detrend_kernel101(emxArray_real_T y, real_T *d2scaled);
static __global__ void ecu_detrend_kernel102(const emxArray_real_T y, int32_T
  npages, emxArray_real_T b);
static __global__ void ecu_detrend_kernel103(real_T d2scaled, emxArray_real_T y);
static __global__ void ecu_detrend_kernel104(real_T wsize2, emxArray_int8_T a);
static __global__ void ecu_detrend_kernel105(const emxArray_real_T y, int32_T
  npages, emxArray_real_T b);
static __global__ void ecu_detrend_kernel106(real_T wsize2, emxArray_int8_T a);
static __global__ void ecu_detrend_kernel107(const real_T rconde, real_T *abnrm,
  emxArray_real_T y);
static __global__ void ecu_detrend_kernel108(const real_T rconde, const int32_T
  i2, int32_T npages, real_T *d2scaled, emxArray_real_T y);
static __global__ void ecu_detrend_kernel109(real_T *d2scaled, int32_T *na,
  emxArray_real_T y);
static __global__ void ecu_detrend_kernel11(const emxArray_real_T lin, int32_T
  nx, emxArray_real_T dv3);
static __global__ void ecu_detrend_kernel110(const real_T rconde, int32_T *na,
  emxArray_real_T y);
static __global__ void ecu_detrend_kernel111(const real_T rconde, real_T
  *d2scaled, int32_T *na, emxArray_real_T y);
static __global__ void ecu_detrend_kernel112(emxArray_real_T y, real_T *d2scaled);
static __global__ void ecu_detrend_kernel113(const real_T wsize2, int32_T npages,
  emxArray_real_T b);
static __global__ void ecu_detrend_kernel114(const emxArray_real_T b, const
  emxArray_real_T yy, const emxArray_real_T x, const int32_T npages, int32_T
  ntilecols, emxArray_real_T b_x);
static __global__ void ecu_detrend_kernel115(const emxArray_real_T x, int32_T
  b_x, int32_T *na, emxArray_real_T c_x);
static __global__ void ecu_detrend_kernel116(const emxArray_real_T b, const
  emxArray_real_T yy, const emxArray_real_T dv1, const int32_T i2, const
  emxArray_real_T trend, const int32_T ntilecols, int32_T *na, emxArray_real_T
  b_trend);
static __global__ void ecu_detrend_kernel117(const emxArray_real_T trend, const
  int32_T nx, int32_T b_trend, emxArray_real_T c_trend);
static __global__ void ecu_detrend_kernel118(const emxArray_real_T b, const
  emxArray_real_T a, const int32_T npages, int32_T ntilecols, emxArray_real_T
  b_a);
static __global__ void ecu_detrend_kernel119(const emxArray_real_T a, int32_T
  b_a, int32_T *na, emxArray_real_T c_a);
static __global__ void ecu_detrend_kernel12(const emxArray_real_T dv3, int32_T
  ntilecols, emxArray_real_T r);
static __global__ void ecu_detrend_kernel120(const int32_T x_dim0, const int32_T
  a_dim0, emxArray_real_T a, emxArray_real_T x);
static __global__ void ecu_detrend_kernel121(const emxArray_real_T a, int32_T x,
  emxArray_real_T b_x);
static __global__ void ecu_detrend_kernel122(const emxArray_real_T x, int32_T
  b_x, emxArray_boolean_T bv8);
static __global__ void ecu_detrend_kernel123(const emxArray_int32_T iv37,
  int32_T b_iv37, emxArray_real_T x);
static __global__ void ecu_detrend_kernel124(const emxArray_real_T a, int32_T
  trend, emxArray_real_T b_trend);
static __global__ void ecu_detrend_kernel125(const emxArray_real_T trend,
  int32_T b_trend, emxArray_boolean_T bv9);
static __global__ void ecu_detrend_kernel126(const emxArray_int32_T iv38,
  int32_T b_iv38, emxArray_real_T trend);
static __global__ void ecu_detrend_kernel127(const emxArray_real_T trend, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T d);
static __global__ void ecu_detrend_kernel128(const emxArray_boolean_T w, int32_T
  d, emxArray_real_T b_d);
static __global__ void ecu_detrend_kernel129(int32_T outsize, emxArray_boolean_T
  ww);
static __global__ void ecu_detrend_kernel13(const emxArray_boolean_T w, const
  int32_T i11, int32_T i12, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel130(const emxArray_real_T d, int32_T nx,
  emxArray_real_T dv23);
static __global__ void ecu_detrend_kernel131(const emxArray_real_T d, int32_T i2,
  real_T *d2scaled, emxArray_real_T absdiff);
static __global__ void ecu_detrend_kernel132(const real_T thresh, const
  emxArray_real_T dv23, int32_T b_dv23, real_T *d2scaled, emxArray_boolean_T
  bv10);
static __global__ void ecu_detrend_kernel133(const emxArray_boolean_T bv10,
  int32_T *na, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel134(const emxArray_boolean_T w, int32_T
  b_w, emxArray_boolean_T a);
static __global__ void ecu_detrend_kernel135(const emxArray_boolean_T ww, const
  emxArray_boolean_T a, int32_T nx, emxArray_boolean_T w);
static __global__ void ecu_detrend_kernel136(const emxArray_boolean_T ww,
  int32_T b_ww, emxArray_boolean_T w);
static __global__ void ecu_detrend_kernel137(const emxArray_real_T x, int32_T
  b_x, emxArray_real_T dv1);
static __global__ void ecu_detrend_kernel138(int32_T r, emxArray_real_T b_r);
static __global__ void ecu_detrend_kernel139(int32_T npages, const int32_T
  lin_dim1, real_T *d2scaled, emxArray_real_T lin);
static __global__ void ecu_detrend_kernel14(int32_T i9, int32_T i8,
  emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel140(const int32_T lin_dim1,
  emxArray_real_T lin);
static __global__ void ecu_detrend_kernel141(const emxArray_real_T lin, int32_T
  nx, emxArray_real_T dv2);
static __global__ void ecu_detrend_kernel142(const emxArray_real_T dv2, int32_T
  ntilecols, emxArray_real_T r);
static __global__ void ecu_detrend_kernel143(int32_T x, emxArray_real_T b_x);
static __global__ void ecu_detrend_kernel144(const emxArray_boolean_T w, int32_T
  b_w, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel145(int32_T x, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel146(const emxArray_boolean_T w, int32_T
  *na, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel147(const emxArray_boolean_T ww, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T x);
static __global__ void ecu_detrend_kernel148(const real_T mn, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T dv4);
static __global__ void ecu_detrend_kernel149(const real_T mn, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T dv4);
static __global__ void ecu_detrend_kernel15(const emxArray_boolean_T w, const
  int32_T i11, int32_T *na, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel150(const emxArray_boolean_T w, int32_T
  b_w, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel151(int32_T x, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel152(const emxArray_boolean_T w, int32_T
  *na, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel153(const emxArray_boolean_T ww, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T x);
static __global__ void ecu_detrend_kernel154(const real_T mn, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T dv5);
static __global__ void ecu_detrend_kernel155(const real_T mn, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T dv5);
static __global__ void ecu_detrend_kernel156(const emxArray_boolean_T w, int32_T
  npages, emxArray_boolean_T bv);
static __global__ void ecu_detrend_kernel157(const emxArray_boolean_T w, int32_T
  b_w, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel158(int32_T r, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel159(const emxArray_boolean_T w, int32_T
  *na, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel16(const emxArray_boolean_T ww, const
  emxArray_real_T dv1, const int32_T i8, int32_T i9, emxArray_real_T x);
static __global__ void ecu_detrend_kernel160(const emxArray_boolean_T ww, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T x_dim0, const
  int32_T r_dim0, emxArray_real_T x);
static __global__ void ecu_detrend_kernel161(int32_T outsize, emxArray_real_T y);
static __global__ void ecu_detrend_kernel162(const emxArray_real_T y, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T dv7_dim0,
  const int32_T r_dim0, real_T *d2scaled, emxArray_real_T dv7);
static __global__ void ecu_detrend_kernel163(int32_T outsize, emxArray_real_T y);
static __global__ void ecu_detrend_kernel164(const int32_T npages, const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T dv7_dim0, const int32_T r_dim0, emxArray_real_T dv7);
static __global__ void ecu_detrend_kernel165(const emxArray_boolean_T w, int32_T
  npages, emxArray_boolean_T bv1);
static __global__ void ecu_detrend_kernel166(const emxArray_boolean_T bv1, const
  emxArray_real_T dv7, int32_T b_dv7, emxArray_real_T xx);
static __global__ void ecu_detrend_kernel167(const emxArray_real_T xx, const
  int32_T b_xx, int32_T c_xx, const int32_T A_dim0, const int32_T xx_dim0,
  emxArray_real_T A);
static __global__ void ecu_detrend_kernel168(int32_T A, emxArray_real_T b_A);
static __global__ void ecu_detrend_kernel169(const emxArray_real_T A, int32_T
  b_A, emxArray_real_T V);
static __global__ void ecu_detrend_kernel17(const real_T mn, const
  emxArray_real_T dv1, const int32_T i8, int32_T i9, emxArray_real_T dv6);
static __global__ void ecu_detrend_kernel170(int32_T V, emxArray_real_T b_V);
static __global__ void ecu_detrend_kernel171(int32_T V, emxArray_real_T A);
static __global__ void ecu_detrend_kernel172(int32_T V, emxArray_real_T b_V);
static __global__ void ecu_detrend_kernel173(const emxArray_real_T V, int32_T
  b_V, emxArray_creal_T c_V);
static __global__ void ecu_detrend_kernel174(const emxArray_real_T A, int32_T
  b_A, emxArray_creal_T D);
static __global__ void ecu_detrend_kernel175(const emxArray_real_T A, int32_T
  b_A, emxArray_real_T U);
static __global__ void ecu_detrend_kernel176(int32_T V, emxArray_real_T U);
static __global__ void ecu_detrend_kernel177(int32_T V, emxArray_real_T U);
static __global__ void ecu_detrend_kernel178(const emxArray_real_T U, int32_T
  b_U, emxArray_creal_T V);
static __global__ void ecu_detrend_kernel179(const creal_T *dc, emxArray_creal_T
  V);
static __global__ void ecu_detrend_kernel18(const real_T mn, const
  emxArray_real_T dv1, const int32_T i8, int32_T i9, emxArray_real_T dv6);
static __global__ void ecu_detrend_kernel180(const int32_T D_dim0, const int32_T
  D_dim1, int32_T *i);
static __global__ void ecu_detrend_kernel181(emxArray_creal_T D);
static __global__ void ecu_detrend_kernel182(const emxArray_creal_T dt,
  emxArray_creal_T D);
static __global__ void ecu_detrend_kernel183(const creal_T *dc, int32_T V,
  emxArray_creal_T b_V);
static __global__ void ecu_detrend_kernel184(int32_T V, emxArray_creal_T D);
static __global__ void ecu_detrend_kernel185(const creal_T *dc, emxArray_creal_T
  D);
static __global__ void ecu_detrend_kernel186(const emxArray_creal_T D, int32_T
  b_D, emxArray_real_T v);
static __global__ void ecu_detrend_kernel187(const creal_T d, const
  emxArray_creal_T D, int32_T b_D, emxArray_boolean_T bv3);
static __global__ void ecu_detrend_kernel188(const emxArray_creal_T V, const
  int32_T b_V, int32_T iv19, const int32_T topcs_dim0, emxArray_real_T topcs);
static __global__ void ecu_detrend_kernel189(int32_T xx, emxArray_real_T xxx);
static __global__ void ecu_detrend_kernel19(const emxArray_boolean_T w, const
  int32_T i11, int32_T i12, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel190(const emxArray_boolean_T bv, const
  emxArray_real_T dv5, int32_T b_dv5, emxArray_real_T A);
static __global__ void ecu_detrend_kernel191(int32_T xxx, emxArray_real_T X);
static __global__ void ecu_detrend_kernel192(const emxArray_real_T xxx, const
  int32_T b_xxx, int32_T c_xxx, const int32_T A_dim0, const int32_T xxx_dim0,
  emxArray_real_T A);
static __global__ void ecu_detrend_kernel193(int32_T A, emxArray_real_T b_A);
static __global__ void ecu_detrend_kernel194(const emxArray_real_T A, const
  int32_T b_A, int32_T c_A, const int32_T A_dim0, const int32_T b_A_dim0,
  emxArray_real_T d_A);
static __global__ void ecu_detrend_kernel195(const emxArray_real_T X, int32_T
  b_X, emxArray_real_T B);
static __global__ void ecu_detrend_kernel196(int32_T A, emxArray_int32_T jpvt);
static __global__ void ecu_detrend_kernel197(const int32_T npages, int32_T *na,
  const int32_T A_dim0, emxArray_real_T A);
static __global__ void ecu_detrend_kernel198(int32_T ntilecols, emxArray_real_T
  tau);
static __global__ void ecu_detrend_kernel199(int32_T *na, emxArray_int32_T jpvt);
static __global__ void ecu_detrend_kernel2(int32_T outsize, emxArray_boolean_T y);
static __global__ void ecu_detrend_kernel20(int32_T i9, int32_T i8,
  emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel200(int32_T dims_idx_0, emxArray_real_T
  Y);
static __global__ void ecu_detrend_kernel201(int32_T npages, emxArray_real_T B);
static __global__ void ecu_detrend_kernel202(const emxArray_real_T B, const
  emxArray_int32_T jpvt, int32_T nx, emxArray_real_T Y);
static __global__ void ecu_detrend_kernel203(const emxArray_real_T Y, int32_T
  b_Y, emxArray_real_T X);
static __global__ void ecu_detrend_kernel204(const emxArray_int32_T ipiv_t,
  int32_T npages, emxArray_int32_T ipiv);
static __global__ void ecu_detrend_kernel205(int32_T V, emxArray_real_T A);
static __global__ void ecu_detrend_kernel206(int32_T npages, emxArray_int32_T
  ipiv);
static __global__ void ecu_detrend_kernel207(const int32_T A_dim0, uint32_T
  outsize[2]);
static __global__ void ecu_detrend_kernel208(const uint32_T outsize[2], int32_T *
  b_outsize);
static __global__ void ecu_detrend_kernel209(int32_T *outsize, emxArray_real_T X);
static __global__ void ecu_detrend_kernel21(const emxArray_boolean_T w, const
  int32_T i11, int32_T *na, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel210(const emxArray_boolean_T w, int32_T
  b_w, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel211(int32_T r, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel212(const emxArray_boolean_T w, int32_T
  *na, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel213(const emxArray_boolean_T ww, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T x_dim0, const
  int32_T r_dim0, emxArray_real_T x);
static __global__ void ecu_detrend_kernel214(int32_T outsize, emxArray_real_T y);
static __global__ void ecu_detrend_kernel215(const emxArray_real_T y, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T x_dim0, const
  int32_T r_dim0, real_T *d2scaled, emxArray_real_T x);
static __global__ void ecu_detrend_kernel216(int32_T outsize, emxArray_real_T y);
static __global__ void ecu_detrend_kernel217(const int32_T npages, const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T x_dim0, const int32_T r_dim0, emxArray_real_T x);
static __global__ void ecu_detrend_kernel218(int32_T x, emxArray_real_T y);
static __global__ void ecu_detrend_kernel219(const emxArray_real_T X, int32_T
  b_X, emxArray_real_T B);
static __global__ void ecu_detrend_kernel22(const emxArray_boolean_T ww, const
  emxArray_real_T dv1, const int32_T i8, int32_T i9, emxArray_real_T x);
static __global__ void ecu_detrend_kernel220(int32_T y, emxArray_real_T x);
static __global__ void ecu_detrend_kernel221(const emxArray_real_T dv4, const
  emxArray_real_T dv1, int32_T x, emxArray_real_T b_x);
static __global__ void ecu_detrend_kernel222(const emxArray_real_T x, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T d);
static __global__ void ecu_detrend_kernel223(const emxArray_boolean_T w, int32_T
  d, emxArray_real_T b_d);
static __global__ void ecu_detrend_kernel224(uint32_T dims_idx_0,
  emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel225(const emxArray_real_T d, int32_T nx,
  emxArray_real_T dv20);
static __global__ void ecu_detrend_kernel226(const emxArray_real_T d, int32_T i2,
  real_T *d2scaled, emxArray_real_T absdiff);
static __global__ void ecu_detrend_kernel227(const real_T thresh, const
  emxArray_real_T dv20, int32_T b_dv20, real_T *d2scaled, emxArray_boolean_T bv6);
static __global__ void ecu_detrend_kernel228(const emxArray_boolean_T bv6,
  int32_T *na, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel229(const emxArray_boolean_T w, int32_T
  b_w, emxArray_boolean_T a);
static __global__ void ecu_detrend_kernel23(const real_T mn, const
  emxArray_real_T dv1, const int32_T i8, int32_T i9, emxArray_real_T dv8);
static __global__ void ecu_detrend_kernel230(const emxArray_boolean_T ww, const
  emxArray_boolean_T a, int32_T nx, emxArray_boolean_T w);
static __global__ void ecu_detrend_kernel231(const emxArray_boolean_T ww,
  int32_T b_ww, emxArray_boolean_T w);
static __global__ void ecu_detrend_kernel232(const emxArray_real_T x, const
  int32_T ch, const emxArray_real_T b_x, int32_T c_x, const int32_T x_dim0,
  emxArray_real_T dv1);
static __global__ void ecu_detrend_kernel233(const emxArray_real_T dv1, const
  int32_T ch, int32_T b_dv1, const int32_T x_dim0, emxArray_real_T x);
static __global__ void ecu_detrend_kernel234(const emxArray_boolean_T w, const
  int32_T ch, int32_T b_w, const int32_T w_dim0, emxArray_boolean_T c_w);
static __global__ void ecu_detrend_kernel24(const real_T mn, const
  emxArray_real_T dv1, const int32_T i8, int32_T i9, emxArray_real_T dv8);
static __global__ void ecu_detrend_kernel25(const emxArray_boolean_T w, const
  int32_T i11, int32_T npages, emxArray_boolean_T bv2);
static __global__ void ecu_detrend_kernel26(const emxArray_boolean_T w, const
  int32_T i11, int32_T i12, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel27(int32_T r, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel28(const emxArray_boolean_T w, const
  int32_T i11, int32_T *na, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel29(const emxArray_boolean_T ww, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T x_dim0, const
  int32_T r_dim0, emxArray_real_T x);
static __global__ void ecu_detrend_kernel3(const int32_T ch, const
  emxArray_real_T x, int32_T b_x, const int32_T x_dim0, emxArray_real_T dv1);
static __global__ void ecu_detrend_kernel30(int32_T outsize, emxArray_real_T y);
static __global__ void ecu_detrend_kernel31(const emxArray_real_T y, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T dv13_dim0,
  const int32_T r_dim0, real_T *d2scaled, emxArray_real_T dv13);
static __global__ void ecu_detrend_kernel32(int32_T outsize, emxArray_real_T y);
static __global__ void ecu_detrend_kernel33(const int32_T npages, const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T dv13_dim0, const int32_T r_dim0, emxArray_real_T dv13);
static __global__ void ecu_detrend_kernel34(const emxArray_boolean_T w, const
  int32_T i11, int32_T npages, emxArray_boolean_T bv4);
static __global__ void ecu_detrend_kernel35(const emxArray_boolean_T bv4, const
  emxArray_real_T dv13, int32_T b_dv13, emxArray_real_T xx);
static __global__ void ecu_detrend_kernel36(const emxArray_real_T xx, const
  int32_T b_xx, int32_T c_xx, const int32_T A_dim0, const int32_T xx_dim0,
  emxArray_real_T A);
static __global__ void ecu_detrend_kernel37(int32_T A, emxArray_real_T b_A);
static __global__ void ecu_detrend_kernel38(const emxArray_real_T A, int32_T b_A,
  emxArray_real_T V);
static __global__ void ecu_detrend_kernel39(int32_T V, emxArray_real_T b_V);
static __global__ void ecu_detrend_kernel4(const int32_T ch, const
  emxArray_boolean_T w, int32_T b_w, const int32_T w_dim0, emxArray_boolean_T
  c_w);
static __global__ void ecu_detrend_kernel40(int32_T V, emxArray_real_T A);
static __global__ void ecu_detrend_kernel41(int32_T V, emxArray_real_T b_V);
static __global__ void ecu_detrend_kernel42(const emxArray_real_T V, int32_T b_V,
  emxArray_creal_T c_V);
static __global__ void ecu_detrend_kernel43(const emxArray_real_T A, int32_T b_A,
  emxArray_creal_T D);
static __global__ void ecu_detrend_kernel44(const emxArray_real_T A, int32_T b_A,
  emxArray_real_T U);
static __global__ void ecu_detrend_kernel45(int32_T V, emxArray_real_T U);
static __global__ void ecu_detrend_kernel46(int32_T V, emxArray_real_T U);
static __global__ void ecu_detrend_kernel47(const emxArray_real_T U, int32_T b_U,
  emxArray_creal_T V);
static __global__ void ecu_detrend_kernel48(const creal_T *dc, emxArray_creal_T
  V);
static __global__ void ecu_detrend_kernel49(const int32_T D_dim0, const int32_T
  D_dim1, int32_T *i);
static __global__ void ecu_detrend_kernel5(int32_T x, emxArray_real_T b_x);
static __global__ void ecu_detrend_kernel50(emxArray_creal_T D);
static __global__ void ecu_detrend_kernel51(const emxArray_creal_T dt,
  emxArray_creal_T D);
static __global__ void ecu_detrend_kernel52(const creal_T *dc, int32_T V,
  emxArray_creal_T b_V);
static __global__ void ecu_detrend_kernel53(int32_T V, emxArray_creal_T D);
static __global__ void ecu_detrend_kernel54(const creal_T *dc, emxArray_creal_T
  D);
static __global__ void ecu_detrend_kernel55(const emxArray_creal_T D, int32_T
  b_D, emxArray_real_T v);
static __global__ void ecu_detrend_kernel56(const creal_T d, const
  emxArray_creal_T D, int32_T b_D, emxArray_boolean_T bv5);
static __global__ void ecu_detrend_kernel57(const emxArray_creal_T V, const
  int32_T b_V, int32_T iv26, const int32_T topcs_dim0, emxArray_real_T topcs);
static __global__ void ecu_detrend_kernel58(int32_T xx, emxArray_real_T xxx);
static __global__ void ecu_detrend_kernel59(const emxArray_boolean_T bv2, const
  emxArray_real_T dv8, int32_T b_dv8, emxArray_real_T A);
static __global__ void ecu_detrend_kernel6(int32_T x, emxArray_real_T b_x);
static __global__ void ecu_detrend_kernel60(int32_T xxx, emxArray_real_T X);
static __global__ void ecu_detrend_kernel61(const emxArray_real_T xxx, const
  int32_T b_xxx, int32_T c_xxx, const int32_T A_dim0, const int32_T xxx_dim0,
  emxArray_real_T A);
static __global__ void ecu_detrend_kernel62(int32_T A, emxArray_real_T b_A);
static __global__ void ecu_detrend_kernel63(const emxArray_real_T A, const
  int32_T b_A, int32_T c_A, const int32_T A_dim0, const int32_T b_A_dim0,
  emxArray_real_T d_A);
static __global__ void ecu_detrend_kernel64(const emxArray_real_T X, int32_T b_X,
  emxArray_real_T B);
static __global__ void ecu_detrend_kernel65(int32_T A, emxArray_int32_T jpvt);
static __global__ void ecu_detrend_kernel66(const int32_T npages, int32_T *na,
  const int32_T A_dim0, emxArray_real_T A);
static __global__ void ecu_detrend_kernel67(int32_T ntilecols, emxArray_real_T
  tau);
static __global__ void ecu_detrend_kernel68(int32_T *na, emxArray_int32_T jpvt);
static __global__ void ecu_detrend_kernel69(int32_T npages, emxArray_real_T Y);
static __global__ void ecu_detrend_kernel7(const emxArray_boolean_T w, const
  int32_T i2, int32_T nx, emxArray_int8_T minval);
static __global__ void ecu_detrend_kernel70(int32_T npages, emxArray_real_T B);
static __global__ void ecu_detrend_kernel71(const emxArray_real_T B, const
  emxArray_int32_T jpvt, int32_T nx, emxArray_real_T Y);
static __global__ void ecu_detrend_kernel72(const emxArray_real_T Y, int32_T b_Y,
  emxArray_real_T X);
static __global__ void ecu_detrend_kernel73(const emxArray_int32_T ipiv_t,
  int32_T npages, emxArray_int32_T ipiv);
static __global__ void ecu_detrend_kernel74(int32_T V, emxArray_real_T A);
static __global__ void ecu_detrend_kernel75(int32_T npages, emxArray_int32_T
  ipiv);
static __global__ void ecu_detrend_kernel76(int32_T outsize, emxArray_real_T X);
static __global__ void ecu_detrend_kernel77(const emxArray_boolean_T w, const
  int32_T i11, int32_T i12, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel78(int32_T r, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel79(const emxArray_boolean_T w, const
  int32_T i11, int32_T *na, emxArray_boolean_T ww);
static __global__ void ecu_detrend_kernel8(int32_T r, emxArray_real_T b_r);
static __global__ void ecu_detrend_kernel80(const emxArray_boolean_T ww, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T x_dim0, const
  int32_T r_dim0, emxArray_real_T x);
static __global__ void ecu_detrend_kernel81(int32_T outsize, emxArray_real_T y);
static __global__ void ecu_detrend_kernel82(const emxArray_real_T y, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T r_dim0, const
  int32_T b_r_dim0, real_T *d2scaled, emxArray_real_T d_r);
static __global__ void ecu_detrend_kernel83(const emxArray_real_T r, int32_T b_r,
  emxArray_real_T c_r);
static __global__ void ecu_detrend_kernel84(int32_T outsize, emxArray_real_T y);
static __global__ void ecu_detrend_kernel85(const int32_T npages, const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T r_dim0, const int32_T b_r_dim0, emxArray_real_T d_r);
static __global__ void ecu_detrend_kernel86(const emxArray_real_T r, int32_T b_r,
  emxArray_real_T c_r);
static __global__ void ecu_detrend_kernel87(int32_T r, emxArray_real_T y);
static __global__ void ecu_detrend_kernel88(const emxArray_real_T X, int32_T b_X,
  emxArray_real_T B);
static __global__ void ecu_detrend_kernel89(int32_T y, emxArray_real_T yy);
static __global__ void ecu_detrend_kernel9(int32_T npages, const int32_T
  lin_dim1, real_T *d2scaled, emxArray_real_T lin);
static __global__ void ecu_detrend_kernel90(const emxArray_real_T dv6, const
  emxArray_real_T dv1, const int32_T i8, int32_T yy, emxArray_real_T b_yy);
static __global__ void ecu_detrend_kernel91(const emxArray_real_T yy, const
  emxArray_real_T dv1, const int32_T i8, int32_T i9, emxArray_real_T d);
static __global__ void ecu_detrend_kernel92(const emxArray_boolean_T w, const
  int32_T i11, int32_T d, emxArray_real_T b_d);
static __global__ void ecu_detrend_kernel93(const emxArray_real_T d, int32_T i2,
  real_T *d2scaled, emxArray_real_T absdiff);
static __global__ void ecu_detrend_kernel94(const emxArray_real_T dv1, const
  int32_T i8, int32_T i9, emxArray_real_T yy);
static __global__ void ecu_detrend_kernel95(real_T d2scaled, emxArray_real_T y);
static __global__ void ecu_detrend_kernel96(const real_T rconde, real_T *abnrm,
  emxArray_real_T y);
static __global__ void ecu_detrend_kernel97(const real_T rconde, const int32_T
  i2, int32_T npages, real_T *d2scaled, emxArray_real_T y);
static __global__ void ecu_detrend_kernel98(real_T *d2scaled, int32_T *na,
  emxArray_real_T y);
static __global__ void ecu_detrend_kernel99(const real_T rconde, int32_T *na,
  emxArray_real_T y);
static void ecu_detrend_once();
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_boolean_T *y);
static void emlrt_marshallIn(const mxArray *w, const char_T *identifier,
  emxArray_boolean_T *y);
static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static real_T emlrt_marshallIn(const mxArray *order, const char_T *identifier);
static void emlrt_marshallOut(const emxArray_boolean_T *u, const mxArray *y);
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
static void gpuEmxMemcpyCpuToGpu_boolean_T(emxArray_boolean_T *gpu, const
  emxArray_boolean_T *cpu);
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
static void gpuEmxMemcpyGpuToCpu_int8_T(emxArray_int8_T *cpu, emxArray_int8_T
  *gpu);
static void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T
  *gpu);
static void gpuEmxReset_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxReset_creal_T(emxArray_creal_T *gpu);
static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);
static void gpuEmxReset_int8_T(emxArray_int8_T *gpu);
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static void minus(emxArray_real_T *in1, const emxArray_real_T *in2, const
                  emxArray_real_T *in3);
static real_T rt_remd_snf(real_T u0, real_T u1);

// Function Definitions
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2)
{
  emxArray_real_T *c_in1;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T b_in1;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  b_in1 = in1->size[0];
  emxInit_real_T(&c_in1, 2, &fd_emlrtRTEI, true);
  i = c_in1->size[0] * c_in1->size[1];
  c_in1->size[0] = in1->size[0];
  if (in2->size[1] == 1) {
    c_in1->size[1] = in1->size[1];
  } else {
    c_in1->size[1] = in2->size[1];
  }

  emxEnsureCapacity_real_T(c_in1, i, &fd_emlrtRTEI);
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
      c_in1->data[i1 + c_in1->size[0] * i] = in1->data[i1 + in1->size[0] *
        aux_0_1] - in2->data[aux_1_1] / static_cast<real_T>(b_in1);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }

  i = in1->size[0] * in1->size[1];
  in1->size[0] = c_in1->size[0];
  in1->size[1] = c_in1->size[1];
  emxEnsureCapacity_real_T(in1, i, &bd_emlrtRTEI);
  for (i = 0; i < c_in1->size[1]; i++) {
    for (int32_T i1{0}; i1 < c_in1->size[0]; i1++) {
      in1->data[i1 + in1->size[0] * i] = c_in1->data[i1 + c_in1->size[0] * i];
    }
  }

  emxFree_real_T(&c_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3)
{
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T b_in2;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  b_in2 = in2->size[0];
  i = in1->size[0] * in1->size[1];
  in1->size[0] = in2->size[0];
  if (in3->size[1] == 1) {
    in1->size[1] = in2->size[1];
  } else {
    in1->size[1] = in3->size[1];
  }

  emxEnsureCapacity_real_T(in1, i, &bd_emlrtRTEI);
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
        - in3->data[aux_1_1] / static_cast<real_T>(b_in2);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &jf_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in5->size[0] == 1) {
    b = in4 - in3;
  } else {
    b = in5->size[0];
  }

  if (b == 1) {
    b_in1->size[0] = in1->size[0];
  } else if (in5->size[0] == 1) {
    b_in1->size[0] = in4 - in3;
  } else {
    b_in1->size[0] = in5->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &jf_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in4 - in3 != 1);
  stride_2_0 = (in5->size[0] != 1);
  if (in5->size[0] == 1) {
    b = in4 - in3;
  } else {
    b = in5->size[0];
  }

  if (b == 1) {
    b = in1->size[0];
  } else if (in5->size[0] == 1) {
    b = in4 - in3;
  } else {
    b = in5->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0] + (in2->data[(in3 + i *
      stride_1_0) - 1] - in5->data[i * stride_2_0]);
  }

  i = in1->size[0];
  in1->size[0] = b_in1->size[0];
  emxEnsureCapacity_real_T(in1, i, &hd_emlrtRTEI);
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_boolean_T *in3)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  if (in3->size[0] == 1) {
    in1->size[1] = in2->size[0];
  } else {
    in1->size[1] = in3->size[0];
  }

  emxEnsureCapacity_real_T(in1, i, &fb_emlrtRTEI);
  stride_0_1 = (in2->size[0] != 1);
  stride_1_1 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in3->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[i * stride_0_1] * static_cast<real_T>(in3->data[i *
      stride_1_1]);
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

static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_boolean_T *ret)
{
  static const int32_T dims[2]{ -1, -1 };

  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2]{ true, true };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "logical", false, 2U,
    (const void *)&dims[0], &bv[0], &iv[0]);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_boolean_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  ret->data = static_cast<boolean_T *>(emlrtMxGetData(src));
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void b_error(const mxArray *m, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = m;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, nullptr, 1, &pArray, "error",
                        true, location);
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
  emxInit_real_T(&b_in1, 1, &yd_emlrtRTEI, true);
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

  emxEnsureCapacity_real_T(b_in1, i, &yd_emlrtRTEI);
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

static void binary_expand_op(emxArray_real_T *in1, const emxArray_boolean_T *in2)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &hf_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in2->size[0] == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in2->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &hf_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in2->size[0] != 1);
  if (in2->size[0] == 1) {
    b = in1->size[0];
  } else {
    b = in2->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0] * static_cast<real_T>(in2->data[i
      * stride_1_0]);
  }

  i = in1->size[0];
  in1->size[0] = b_in1->size[0];
  emxEnsureCapacity_real_T(in1, i, &if_emlrtRTEI);
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
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
  emxInit_real_T(&b_in1, 1, &xd_emlrtRTEI, true);
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

  emxEnsureCapacity_real_T(b_in1, i, &xd_emlrtRTEI);
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
  int32_T in3, const emxArray_real_T *in4)
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

  emxEnsureCapacity_real_T(in1, i, &q_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in4->size[0] != 1);
  if (in4->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in4->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[i * stride_0_0 + in2->size[0] * in3] - in4->data[i *
      stride_1_0];
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4)
{
  emxArray_real_T *b_in2;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in2, 1, &mf_emlrtRTEI, true);
  i = b_in2->size[0];
  if (in1->size[0] == 1) {
    b_in2->size[0] = in4 - in3;
  } else {
    b_in2->size[0] = in1->size[0];
  }

  emxEnsureCapacity_real_T(b_in2, i, &mf_emlrtRTEI);
  stride_0_0 = (in4 - in3 != 1);
  stride_1_0 = (in1->size[0] != 1);
  if (in1->size[0] == 1) {
    b = in4 - in3;
  } else {
    b = in1->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in2->data[i] = in2->data[(in3 + i * stride_0_0) - 1] - in1->data[i *
      stride_1_0];
  }

  i = in1->size[0];
  in1->size[0] = b_in2->size[0];
  emxEnsureCapacity_real_T(in1, i, &hd_emlrtRTEI);
  for (i = 0; i < b_in2->size[0]; i++) {
    in1->data[i] = b_in2->data[i];
  }

  emxFree_real_T(&b_in2);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_boolean_T *in2,
  int32_T in3, int32_T in4)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &hf_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in4 - in3 == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in4 - in3;
  }

  emxEnsureCapacity_real_T(b_in1, i, &hf_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in4 - in3 != 1);
  if (in4 - in3 == 1) {
    b = in1->size[0];
  } else {
    b = in4 - in3;
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0] * static_cast<real_T>(in2->data
      [(in3 + i * stride_1_0) - 1]);
  }

  i = in1->size[0];
  in1->size[0] = b_in1->size[0];
  emxEnsureCapacity_real_T(in1, i, &if_emlrtRTEI);
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
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
    in1->size[0] = in4 - in3;
  } else {
    in1->size[0] = in5->size[0];
  }

  emxEnsureCapacity_real_T(in1, i, &id_emlrtRTEI);
  stride_0_0 = (in4 - in3 != 1);
  stride_1_0 = (in5->size[0] != 1);
  if (in5->size[0] == 1) {
    b = in4 - in3;
  } else {
    b = in5->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[(in3 + i * stride_0_0) - 1] - in5->data[i *
      stride_1_0];
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3)
{
  emxArray_real_T *b_in1;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 2, &gd_emlrtRTEI, true);
  i = b_in1->size[0] * b_in1->size[1];
  b_in1->size[0] = in1->size[0];
  if (in2->size[1] == 1) {
    b_in1->size[1] = in1->size[1];
  } else {
    b_in1->size[1] = in2->size[1];
  }

  emxEnsureCapacity_real_T(b_in1, i, &gd_emlrtRTEI);
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
        aux_0_1] - in2->data[aux_1_1] / (static_cast<real_T>(in3) +
        2.2204460492503131E-16);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }

  i = in1->size[0] * in1->size[1];
  in1->size[0] = b_in1->size[0];
  in1->size[1] = b_in1->size[1];
  emxEnsureCapacity_real_T(in1, i, &cd_emlrtRTEI);
  for (i = 0; i < b_in1->size[1]; i++) {
    for (int32_T i1{0}; i1 < b_in1->size[0]; i1++) {
      in1->data[i1 + in1->size[0] * i] = b_in1->data[i1 + b_in1->size[0] * i];
    }
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_boolean_T *in5)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in5->size[0] == 1) {
    in1->size[0] = in4 - in3;
  } else {
    in1->size[0] = in5->size[0];
  }

  emxEnsureCapacity_real_T(in1, i, &t_emlrtRTEI);
  stride_0_0 = (in4 - in3 != 1);
  stride_1_0 = (in5->size[0] != 1);
  if (in5->size[0] == 1) {
    b = in4 - in3;
  } else {
    b = in5->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[(in3 + i * stride_0_0) - 1] * static_cast<real_T>
      (in5->data[i * stride_1_0]);
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
  emxInit_real_T(&b_in1, 1, &kf_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in2->size[0] == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in2->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &kf_emlrtRTEI);
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
  emxEnsureCapacity_real_T(in1, i, &lf_emlrtRTEI);
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
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
  emxInit_real_T(&b_in1, 1, &ae_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in6->size[0] == 1) {
    b_in1->size[0] = (in5 - in4) + 1;
  } else {
    b_in1->size[0] = in6->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &ae_emlrtRTEI);
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
  const emxArray_real_T *in3)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &jf_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in3->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in3->size[0];
  }

  if (b == 1) {
    b_in1->size[0] = in1->size[0];
  } else if (in3->size[0] == 1) {
    b_in1->size[0] = in2->size[0];
  } else {
    b_in1->size[0] = in3->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &jf_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in2->size[0] != 1);
  stride_2_0 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in3->size[0];
  }

  if (b == 1) {
    b = in1->size[0];
  } else if (in3->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in3->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0] + (in2->data[i * stride_1_0] -
      in3->data[i * stride_2_0]);
  }

  i = in1->size[0];
  in1->size[0] = b_in1->size[0];
  emxEnsureCapacity_real_T(in1, i, &ed_emlrtRTEI);
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, int32_T in4)
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

  emxEnsureCapacity_real_T(in1, i, &cd_emlrtRTEI);
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
        - in3->data[aux_1_1] / (static_cast<real_T>(in4) +
        2.2204460492503131E-16);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_boolean_T *in3)
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
  emxEnsureCapacity_real_T(in1, i, &t_emlrtRTEI);
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
        * i] * static_cast<real_T>(in3->data[i1 * stride_1_0]);
    }
  }
}

static void binary_expand_op(emxArray_boolean_T *in1, const emxArray_real_T *in2,
  real_T in3, real_T in4, const int32_T in5[2])
{
  int32_T i;
  int32_T in5_idx_0;
  int32_T stride_0_0;
  in5_idx_0 = in5[0];
  i = in1->size[0];
  if (in5_idx_0 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in5_idx_0;
  }

  emxEnsureCapacity_boolean_T(in1, i, &ld_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  if (in5_idx_0 == 1) {
    in5_idx_0 = in2->size[0];
  }

  for (i = 0; i < in5_idx_0; i++) {
    in1->data[i] = (in2->data[i * stride_0_0] > in3 * in4);
  }
}

static void c_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_boolean_T *in3)
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

  emxEnsureCapacity_real_T(in1, i, &eb_emlrtRTEI);
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
      in1->data[i1 + in1->size[0] * i] = in2->data[i1 * stride_0_0 + in2->size[0]
        * aux_0_1] * static_cast<real_T>(in3->data[i1 * stride_1_0 + in3->size[0]
        * aux_1_1]);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

//
//
namespace coder
{
  namespace internal
  {
    static void expand_min(const emxArray_boolean_T *a, const emxArray_boolean_T
      *b, emxArray_boolean_T *c)
    {
      int32_T csz_idx_0;
      int32_T i;
      int32_T k;
      int32_T u0;
      u0 = a->size[0];
      k = b->size[0];
      if (u0 <= k) {
        k = u0;
      }

      if (b->size[0] == 1) {
        csz_idx_0 = a->size[0];
      } else if (a->size[0] == 1) {
        csz_idx_0 = b->size[0];
      } else {
        csz_idx_0 = k;
      }

      i = c->size[0];
      u0 = a->size[0];
      k = b->size[0];
      if (u0 <= k) {
        k = u0;
      }

      if (b->size[0] == 1) {
        c->size[0] = a->size[0];
      } else if (a->size[0] == 1) {
        c->size[0] = b->size[0];
      } else {
        c->size[0] = k;
      }

      emxEnsureCapacity_boolean_T(c, i, &emlrtRTEI);
      if (csz_idx_0 != 0) {
        boolean_T b1;
        boolean_T b_b;
        b_b = (a->size[0] != 1);
        b1 = (b->size[0] != 1);
        u0 = csz_idx_0 - 1;
        for (k = 0; k <= u0; k++) {
          if (static_cast<int32_T>(a->data[b_b * k]) > static_cast<int32_T>
              (b->data[b1 * k])) {
            c->data[k] = b->data[b1 * k];
          } else {
            c->data[k] = a->data[b_b * k];
          }
        }
      }
    }
  }
}

static void d_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_boolean_T *in3)
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

  emxEnsureCapacity_real_T(in1, i, &t_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in3->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[i * stride_0_0] * static_cast<real_T>(in3->data[i *
      stride_1_0]);
  }
}

static void disp(const mxArray *m, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = m;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, nullptr, 1, &pArray, "disp", true,
                        location);
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel1(creal_T *dc)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    dc->re = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel10(const
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

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel100(const
  real_T rconde, real_T *d2scaled, int32_T *na, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[*na] = (*d2scaled + rconde) / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel101
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel102(const
  emxArray_real_T y, int32_T npages, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel103(real_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel104(real_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel105(const
  emxArray_real_T y, int32_T npages, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel106(real_T
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

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel107(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel108(const
  real_T rconde, const int32_T i2, int32_T npages, real_T *d2scaled,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k + 1] = *d2scaled - (static_cast<real_T>(k) + 1.0);
    y.data[(i2 - k) - 2] = rconde - (-(static_cast<real_T>(k) + 1.0));
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel109(real_T
  *d2scaled, int32_T *na, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[*na] = *d2scaled - static_cast<real_T>(*na);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel11(const
  emxArray_real_T lin, int32_T nx, emxArray_real_T dv3)
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
    dv3.data[k] = pow(lin.data[k], 1.0);
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel110(const
  real_T rconde, int32_T *na, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[*na + 1] = rconde - (-static_cast<real_T>(*na));
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel111(const
  real_T rconde, real_T *d2scaled, int32_T *na, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[*na] = (*d2scaled + rconde) / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel112
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel113(const
  real_T wsize2, int32_T npages, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = wsize2 / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel114(const
  emxArray_real_T b, const emxArray_real_T yy, const emxArray_real_T x, const
  int32_T npages, int32_T ntilecols, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ntilecols - npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_x.data[i] = x.data[npages + i] + yy.data[i] * b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel115(const
  emxArray_real_T x, int32_T b_x, int32_T *na, emxArray_real_T c_x)
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
    c_x.data[*na + i] = x.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel116(const
  emxArray_real_T b, const emxArray_real_T yy, const emxArray_real_T dv1, const
  int32_T i2, const emxArray_real_T trend, const int32_T ntilecols, int32_T *na,
  emxArray_real_T b_trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na - ntilecols);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_trend.data[i] = trend.data[ntilecols + i] + (dv1.data[i2 + i] - yy.data[i])
      * b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel117(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel118(const
  emxArray_real_T b, const emxArray_real_T a, const int32_T npages, int32_T
  ntilecols, emxArray_real_T b_a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ntilecols - npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_a.data[i] = a.data[npages + i] + b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel119(const
  emxArray_real_T a, int32_T b_a, int32_T *na, emxArray_real_T c_a)
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
    c_a.data[*na + i] = a.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel12(const
  emxArray_real_T dv3, int32_T ntilecols, emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ntilecols - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    r.data[i] = dv3.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel120(const
  int32_T x_dim0, const int32_T a_dim0, emxArray_real_T a, emxArray_real_T x)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    x.data[x_dim0 - 1] = x.data[x_dim0 - 2];

    // 'ec_detrendCompute:188' a(end,:) = a(end-1,:);
    a.data[a_dim0 - 1] = a.data[a_dim0 - 2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel121(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel122(const
  emxArray_real_T x, int32_T b_x, emxArray_boolean_T bv8)
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
    bv8.data[i] = isnan(x.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel123(const
  emxArray_int32_T iv37, int32_T b_iv37, emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_iv37);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[iv37.data[i] - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel124(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel125(const
  emxArray_real_T trend, int32_T b_trend, emxArray_boolean_T bv9)
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
    bv9.data[i] = isnan(trend.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel126(const
  emxArray_int32_T iv38, int32_T b_iv38, emxArray_real_T trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_iv38);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    trend.data[iv38.data[i] - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel127(const
  emxArray_real_T trend, const emxArray_real_T dv1, int32_T b_dv1,
  emxArray_real_T d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = dv1.data[i] - trend.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel128(const
  emxArray_boolean_T w, int32_T d, emxArray_real_T b_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(d);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_d.data[i] *= static_cast<real_T>(w.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel129(int32_T
  outsize, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    ww.data[i] = true;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel13(const
  emxArray_boolean_T w, const int32_T i11, int32_T i12, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i12 - i11) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    ww.data[i] = w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel130(const
  emxArray_real_T d, int32_T nx, emxArray_real_T dv23)
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
    dv23.data[k] = fabs(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel131(const
  emxArray_real_T d, int32_T i2, real_T *d2scaled, emxArray_real_T absdiff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i2 + 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabs(d.data[k] - *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel132(const
  real_T thresh, const emxArray_real_T dv23, int32_T b_dv23, real_T *d2scaled,
  emxArray_boolean_T bv10)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv23);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    bv10.data[i] = (dv23.data[i] > thresh * *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel133(const
  emxArray_boolean_T bv10, int32_T *na, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (bv10.data[i]) {
      ww.data[i] = false;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel134(const
  emxArray_boolean_T w, int32_T b_w, emxArray_boolean_T a)
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
    a.data[i] = w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel135(const
  emxArray_boolean_T ww, const emxArray_boolean_T a, int32_T nx,
  emxArray_boolean_T w)
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
    if (static_cast<int32_T>(a.data[k]) > static_cast<int32_T>(ww.data[k])) {
      w.data[k] = ww.data[k];
    } else {
      w.data[k] = a.data[k];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel136(const
  emxArray_boolean_T ww, int32_T b_ww, emxArray_boolean_T w)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_ww);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    w.data[i] = ww.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel137(const
  emxArray_real_T x, int32_T b_x, emxArray_real_T dv1)
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
    dv1.data[i] = x.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel138(int32_T
  r, emxArray_real_T b_r)
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
    b_r.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel139(int32_T
  npages, const int32_T lin_dim1, real_T *d2scaled, emxArray_real_T lin)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real_T>((((k + 2) << 1) - lin_dim1) - 1) *
      *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel14(int32_T
  i9, int32_T i8, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i9 - i8) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    ww.data[i] = false;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel140(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel141(const
  emxArray_real_T lin, int32_T nx, emxArray_real_T dv2)
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
    dv2.data[k] = pow(lin.data[k], 1.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel142(const
  emxArray_real_T dv2, int32_T ntilecols, emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ntilecols - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    r.data[i] = dv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel143(int32_T
  x, emxArray_real_T b_x)
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
    b_x.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel144(const
  emxArray_boolean_T w, int32_T b_w, emxArray_boolean_T ww)
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
    ww.data[i] = w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel145(int32_T
  x, emxArray_boolean_T ww)
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
    ww.data[i] = false;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel146(const
  emxArray_boolean_T w, int32_T *na, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (w.data[i]) {
      ww.data[i] = true;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel147(const
  emxArray_boolean_T ww, const emxArray_real_T dv1, int32_T b_dv1,
  emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = dv1.data[i] * static_cast<real_T>(ww.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel148(const
  real_T mn, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T dv4)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv4.data[i] = dv1.data[i] - mn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel149(const
  real_T mn, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T dv4)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv4.data[i] = dv1.data[i] - mn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel15(const
  emxArray_boolean_T w, const int32_T i11, int32_T *na, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (w.data[(i11 + i) - 1]) {
      ww.data[i] = true;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel150(const
  emxArray_boolean_T w, int32_T b_w, emxArray_boolean_T ww)
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
    ww.data[i] = w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel151(int32_T
  x, emxArray_boolean_T ww)
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
    ww.data[i] = false;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel152(const
  emxArray_boolean_T w, int32_T *na, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (w.data[i]) {
      ww.data[i] = true;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel153(const
  emxArray_boolean_T ww, const emxArray_real_T dv1, int32_T b_dv1,
  emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = dv1.data[i] * static_cast<real_T>(ww.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel154(const
  real_T mn, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T dv5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv5.data[i] = dv1.data[i] - mn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel155(const
  real_T mn, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T dv5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv5.data[i] = dv1.data[i] - mn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel156(const
  emxArray_boolean_T w, int32_T npages, emxArray_boolean_T bv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    bv.data[k] = w.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel157(const
  emxArray_boolean_T w, int32_T b_w, emxArray_boolean_T ww)
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
    ww.data[i] = w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel158(int32_T
  r, emxArray_boolean_T ww)
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
    ww.data[i] = false;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel159(const
  emxArray_boolean_T w, int32_T *na, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (w.data[i]) {
      ww.data[i] = true;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel16(const
  emxArray_boolean_T ww, const emxArray_real_T dv1, const int32_T i8, int32_T i9,
  emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i9 - i8) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = dv1.data[(i8 + i) - 1] * static_cast<real_T>(ww.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel160(const
  emxArray_boolean_T ww, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    x.data[k + x_dim0 * i] = r.data[k + r_dim0 * i] * static_cast<real_T>
      (ww.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel161(int32_T
  outsize, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel162(const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T dv7_dim0, const int32_T r_dim0, real_T *d2scaled,
  emxArray_real_T dv7)
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    dv7.data[k + dv7_dim0 * i] = r.data[k + r_dim0 * i] - y.data[i] / *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel163(int32_T
  outsize, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel164(const
  int32_T npages, const emxArray_real_T y, const emxArray_real_T r, const
  int32_T b_r, int32_T c_r, const int32_T dv7_dim0, const int32_T r_dim0,
  emxArray_real_T dv7)
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    dv7.data[k + dv7_dim0 * i] = r.data[k + r_dim0 * i] - y.data[i] /
      static_cast<real_T>(npages);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel165(const
  emxArray_boolean_T w, int32_T npages, emxArray_boolean_T bv1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    bv1.data[k] = w.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel166(const
  emxArray_boolean_T bv1, const emxArray_real_T dv7, int32_T b_dv7,
  emxArray_real_T xx)
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
    xx.data[i] = dv7.data[i] * static_cast<real_T>(bv1.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel167(const
  emxArray_real_T xx, const int32_T b_xx, int32_T c_xx, const int32_T A_dim0,
  const int32_T xx_dim0, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xx) + 1UL) * (static_cast<uint64_T>(c_xx) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xx) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_xx) + 1UL));
    A.data[k + A_dim0 * i] = xx.data[i + xx_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel168(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel169(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel17(const
  real_T mn, const emxArray_real_T dv1, const int32_T i8, int32_T i9,
  emxArray_real_T dv6)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i9 - i8) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv6.data[i] = dv1.data[(i8 + i) - 1] - mn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel170(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel171(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel172(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel173(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel174(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel175(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel176(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel177(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel178(const
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

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel179(const
  creal_T *dc, emxArray_creal_T V)
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 1) {
    V.data[0] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel18(const
  real_T mn, const emxArray_real_T dv1, const int32_T i8, int32_T i9,
  emxArray_real_T dv6)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i9 - i8) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv6.data[i] = dv1.data[(i8 + i) - 1] - mn;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel180(const
  int32_T D_dim0, const int32_T D_dim1, int32_T *i)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *i = D_dim0 * D_dim1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel181
  (emxArray_creal_T D)
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 1) {
    D.data[0].re = 0.0;
    D.data[0].im = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel182(const
  emxArray_creal_T dt, emxArray_creal_T D)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    D.data[0] = dt.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel183(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel184(int32_T
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

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel185(const
  creal_T *dc, emxArray_creal_T D)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    D.data[0] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel186(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel187(const
  creal_T d, const emxArray_creal_T D, int32_T b_D, emxArray_boolean_T bv3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_D);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T D_re;
    int32_T i;
    i = static_cast<int32_T>(idx);
    D_re = D.data[i].re;
    if (D.data[i].im == 0.0) {
      D_re /= d.re;
    } else if (D_re == 0.0) {
      D_re = 0.0;
    } else {
      D_re /= d.re;
    }

    bv3.data[i] = (D_re > 1.0E-7);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel188(const
  emxArray_creal_T V, const int32_T b_V, int32_T iv19, const int32_T topcs_dim0,
  emxArray_real_T topcs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_V) + 1UL) * (static_cast<uint64_T>(iv19) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_V) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_V) + 1UL));
    topcs.data[k + topcs_dim0 * i] = V.data[k].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel189(int32_T
  xx, emxArray_real_T xxx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    xxx.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel19(const
  emxArray_boolean_T w, const int32_T i11, int32_T i12, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i12 - i11) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    ww.data[i] = w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel190(const
  emxArray_boolean_T bv, const emxArray_real_T dv5, int32_T b_dv5,
  emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv5);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = dv5.data[i] * static_cast<real_T>(bv.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel191(int32_T
  xxx, emxArray_real_T X)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xxx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    X.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel192(const
  emxArray_real_T xxx, const int32_T b_xxx, int32_T c_xxx, const int32_T A_dim0,
  const int32_T xxx_dim0, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xxx) + 1UL) * (static_cast<uint64_T>(c_xxx)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xxx) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_xxx) + 1UL));
    A.data[k + A_dim0 * i] = xxx.data[i + xxx_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel193(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel194(const
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_A) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_A) + 1UL));
    d_A.data[k + A_dim0 * i] = A.data[i + b_A_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel195(const
  emxArray_real_T X, int32_T b_X, emxArray_real_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_X);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = X.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel196(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel197(const
  int32_T npages, int32_T *na, const int32_T A_dim0, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(npages - 1) + 1UL) * (static_cast<uint64_T>
    (*na) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(npages - 1) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(npages - 1) + 1UL));
    A.data[k * A_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel198(int32_T
  ntilecols, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ntilecols - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    tau.data[k] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel199(int32_T *
  na, emxArray_int32_T jpvt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    jpvt.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel2(int32_T
  outsize, emxArray_boolean_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = false;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel20(int32_T
  i9, int32_T i8, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i9 - i8) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    ww.data[i] = false;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel200(int32_T
  dims_idx_0, emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dims_idx_0 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel201(int32_T
  npages, emxArray_real_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel202(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel203(const
  emxArray_real_T Y, int32_T b_Y, emxArray_real_T X)
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
    X.data[i] = Y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel204(const
  emxArray_int32_T ipiv_t, int32_T npages, emxArray_int32_T ipiv)
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
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel205(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel206(int32_T
  npages, emxArray_int32_T ipiv)
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
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel207(const
  int32_T A_dim0, uint32_T outsize[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    outsize[1] = static_cast<uint32_T>(A_dim0);
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel208(const
  uint32_T outsize[2], int32_T *b_outsize)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *b_outsize = static_cast<int32_T>(outsize[1]) - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel209(int32_T *
  outsize, emxArray_real_T X)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    X.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel21(const
  emxArray_boolean_T w, const int32_T i11, int32_T *na, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (w.data[(i11 + i) - 1]) {
      ww.data[i] = true;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel210(const
  emxArray_boolean_T w, int32_T b_w, emxArray_boolean_T ww)
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
    ww.data[i] = w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel211(int32_T
  r, emxArray_boolean_T ww)
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
    ww.data[i] = false;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel212(const
  emxArray_boolean_T w, int32_T *na, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (w.data[i]) {
      ww.data[i] = true;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel213(const
  emxArray_boolean_T ww, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    x.data[k + x_dim0 * i] = r.data[k + r_dim0 * i] * static_cast<real_T>
      (ww.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel214(int32_T
  outsize, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel215(const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T x_dim0, const int32_T r_dim0, real_T *d2scaled, emxArray_real_T
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    x.data[k + x_dim0 * i] = r.data[k + r_dim0 * i] - y.data[i] / *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel216(int32_T
  outsize, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel217(const
  int32_T npages, const emxArray_real_T y, const emxArray_real_T r, const
  int32_T b_r, int32_T c_r, const int32_T x_dim0, const int32_T r_dim0,
  emxArray_real_T x)
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    x.data[k + x_dim0 * i] = r.data[k + r_dim0 * i] - y.data[i] /
      static_cast<real_T>(npages);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel218(int32_T
  x, emxArray_real_T y)
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
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel219(const
  emxArray_real_T X, int32_T b_X, emxArray_real_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_X);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = X.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel22(const
  emxArray_boolean_T ww, const emxArray_real_T dv1, const int32_T i8, int32_T i9,
  emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i9 - i8) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = dv1.data[(i8 + i) - 1] * static_cast<real_T>(ww.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel220(int32_T
  y, emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel221(const
  emxArray_real_T dv4, const emxArray_real_T dv1, int32_T x, emxArray_real_T b_x)
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
    b_x.data[i] += dv1.data[i] - dv4.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel222(const
  emxArray_real_T x, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = dv1.data[i] - x.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel223(const
  emxArray_boolean_T w, int32_T d, emxArray_real_T b_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(d);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_d.data[i] *= static_cast<real_T>(w.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel224(uint32_T
  dims_idx_0, emxArray_boolean_T ww)
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
    ww.data[i] = true;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel225(const
  emxArray_real_T d, int32_T nx, emxArray_real_T dv20)
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
    dv20.data[k] = fabs(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel226(const
  emxArray_real_T d, int32_T i2, real_T *d2scaled, emxArray_real_T absdiff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i2 + 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabs(d.data[k] - *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel227(const
  real_T thresh, const emxArray_real_T dv20, int32_T b_dv20, real_T *d2scaled,
  emxArray_boolean_T bv6)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv20);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    bv6.data[i] = (dv20.data[i] > thresh * *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel228(const
  emxArray_boolean_T bv6, int32_T *na, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (bv6.data[i]) {
      ww.data[i] = false;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel229(const
  emxArray_boolean_T w, int32_T b_w, emxArray_boolean_T a)
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
    a.data[i] = w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel23(const
  real_T mn, const emxArray_real_T dv1, const int32_T i8, int32_T i9,
  emxArray_real_T dv8)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i9 - i8) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv8.data[i] = dv1.data[(i8 + i) - 1] - mn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel230(const
  emxArray_boolean_T ww, const emxArray_boolean_T a, int32_T nx,
  emxArray_boolean_T w)
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
    if (static_cast<int32_T>(a.data[k]) > static_cast<int32_T>(ww.data[k])) {
      w.data[k] = ww.data[k];
    } else {
      w.data[k] = a.data[k];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel231(const
  emxArray_boolean_T ww, int32_T b_ww, emxArray_boolean_T w)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_ww);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    w.data[i] = ww.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel232(const
  emxArray_real_T x, const int32_T ch, const emxArray_real_T b_x, int32_T c_x,
  const int32_T x_dim0, emxArray_real_T dv1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv1.data[i] = b_x.data[i + x_dim0 * ch] - x.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel233(const
  emxArray_real_T dv1, const int32_T ch, int32_T b_dv1, const int32_T x_dim0,
  emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i + x_dim0 * ch] = dv1.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel234(const
  emxArray_boolean_T w, const int32_T ch, int32_T b_w, const int32_T w_dim0,
  emxArray_boolean_T c_w)
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel24(const
  real_T mn, const emxArray_real_T dv1, const int32_T i8, int32_T i9,
  emxArray_real_T dv8)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i9 - i8) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv8.data[i] = dv1.data[(i8 + i) - 1] - mn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel25(const
  emxArray_boolean_T w, const int32_T i11, int32_T npages, emxArray_boolean_T
  bv2)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    bv2.data[k] = w.data[(i11 + k) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel26(const
  emxArray_boolean_T w, const int32_T i11, int32_T i12, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i12 - i11) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    ww.data[i] = w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel27(int32_T r,
  emxArray_boolean_T ww)
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
    ww.data[i] = false;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel28(const
  emxArray_boolean_T w, const int32_T i11, int32_T *na, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (w.data[(i11 + i) - 1]) {
      ww.data[i] = true;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel29(const
  emxArray_boolean_T ww, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    x.data[k + x_dim0 * i] = r.data[k + r_dim0 * i] * static_cast<real_T>
      (ww.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel3(const
  int32_T ch, const emxArray_real_T x, int32_T b_x, const int32_T x_dim0,
  emxArray_real_T dv1)
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
    dv1.data[i] = x.data[i + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel30(int32_T
  outsize, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel31(const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T dv13_dim0, const int32_T r_dim0, real_T *d2scaled,
  emxArray_real_T dv13)
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    dv13.data[k + dv13_dim0 * i] = r.data[k + r_dim0 * i] - y.data[i] /
      *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel32(int32_T
  outsize, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel33(const
  int32_T npages, const emxArray_real_T y, const emxArray_real_T r, const
  int32_T b_r, int32_T c_r, const int32_T dv13_dim0, const int32_T r_dim0,
  emxArray_real_T dv13)
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    dv13.data[k + dv13_dim0 * i] = r.data[k + r_dim0 * i] - y.data[i] /
      static_cast<real_T>(npages);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel34(const
  emxArray_boolean_T w, const int32_T i11, int32_T npages, emxArray_boolean_T
  bv4)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    bv4.data[k] = w.data[(i11 + k) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel35(const
  emxArray_boolean_T bv4, const emxArray_real_T dv13, int32_T b_dv13,
  emxArray_real_T xx)
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
    xx.data[i] = dv13.data[i] * static_cast<real_T>(bv4.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel36(const
  emxArray_real_T xx, const int32_T b_xx, int32_T c_xx, const int32_T A_dim0,
  const int32_T xx_dim0, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xx) + 1UL) * (static_cast<uint64_T>(c_xx) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xx) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_xx) + 1UL));
    A.data[k + A_dim0 * i] = xx.data[i + xx_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel37(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel38(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel39(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel4(const
  int32_T ch, const emxArray_boolean_T w, int32_T b_w, const int32_T w_dim0,
  emxArray_boolean_T c_w)
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
    c_w.data[i] = w.data[i + w_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel40(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel41(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel42(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel43(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel44(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel45(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel46(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel47(const
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

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel48(const
  creal_T *dc, emxArray_creal_T V)
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 1) {
    V.data[0] = *dc;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel49(const
  int32_T D_dim0, const int32_T D_dim1, int32_T *i)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *i = D_dim0 * D_dim1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel5(int32_T x,
  emxArray_real_T b_x)
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
    b_x.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel50
  (emxArray_creal_T D)
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 1) {
    D.data[0].re = 0.0;
    D.data[0].im = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel51(const
  emxArray_creal_T dt, emxArray_creal_T D)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    D.data[0] = dt.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel52(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel53(int32_T V,
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

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel54(const
  creal_T *dc, emxArray_creal_T D)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    D.data[0] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel55(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel56(const
  creal_T d, const emxArray_creal_T D, int32_T b_D, emxArray_boolean_T bv5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_D);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T D_re;
    int32_T i;
    i = static_cast<int32_T>(idx);
    D_re = D.data[i].re;
    if (D.data[i].im == 0.0) {
      D_re /= d.re;
    } else if (D_re == 0.0) {
      D_re = 0.0;
    } else {
      D_re /= d.re;
    }

    bv5.data[i] = (D_re > 1.0E-7);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel57(const
  emxArray_creal_T V, const int32_T b_V, int32_T iv26, const int32_T topcs_dim0,
  emxArray_real_T topcs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_V) + 1UL) * (static_cast<uint64_T>(iv26) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_V) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_V) + 1UL));
    topcs.data[k + topcs_dim0 * i] = V.data[k].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel58(int32_T
  xx, emxArray_real_T xxx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    xxx.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel59(const
  emxArray_boolean_T bv2, const emxArray_real_T dv8, int32_T b_dv8,
  emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv8);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = dv8.data[i] * static_cast<real_T>(bv2.data[i]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel6(int32_T x,
  emxArray_real_T b_x)
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
    b_x.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel60(int32_T
  xxx, emxArray_real_T X)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xxx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    X.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel61(const
  emxArray_real_T xxx, const int32_T b_xxx, int32_T c_xxx, const int32_T A_dim0,
  const int32_T xxx_dim0, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xxx) + 1UL) * (static_cast<uint64_T>(c_xxx)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xxx) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_xxx) + 1UL));
    A.data[k + A_dim0 * i] = xxx.data[i + xxx_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel62(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel63(const
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_A) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_A) + 1UL));
    d_A.data[k + A_dim0 * i] = A.data[i + b_A_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel64(const
  emxArray_real_T X, int32_T b_X, emxArray_real_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_X);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = X.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel65(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel66(const
  int32_T npages, int32_T *na, const int32_T A_dim0, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(npages - 1) + 1UL) * (static_cast<uint64_T>
    (*na) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T k;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(npages - 1) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(npages - 1) + 1UL));
    A.data[k * A_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel67(int32_T
  ntilecols, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ntilecols - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    tau.data[k] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel68(int32_T
  *na, emxArray_int32_T jpvt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    jpvt.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel69(int32_T
  npages, emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel7(const
  emxArray_boolean_T w, const int32_T i2, int32_T nx, emxArray_int8_T minval)
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
    minval.data[k] = static_cast<int8_T>(w.data[(i2 + k) - 1]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel70(int32_T
  npages, emxArray_real_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel71(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel72(const
  emxArray_real_T Y, int32_T b_Y, emxArray_real_T X)
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
    X.data[i] = Y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel73(const
  emxArray_int32_T ipiv_t, int32_T npages, emxArray_int32_T ipiv)
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
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel74(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel75(int32_T
  npages, emxArray_int32_T ipiv)
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
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel76(int32_T
  outsize, emxArray_real_T X)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    X.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel77(const
  emxArray_boolean_T w, const int32_T i11, int32_T i12, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i12 - i11) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    ww.data[i] = w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel78(int32_T r,
  emxArray_boolean_T ww)
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
    ww.data[i] = false;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel79(const
  emxArray_boolean_T w, const int32_T i11, int32_T *na, emxArray_boolean_T ww)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (w.data[(i11 + i) - 1]) {
      ww.data[i] = true;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel8(int32_T r,
  emxArray_real_T b_r)
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
    b_r.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel80(const
  emxArray_boolean_T ww, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    x.data[k + x_dim0 * i] = r.data[k + r_dim0 * i] * static_cast<real_T>
      (ww.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel81(int32_T
  outsize, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel82(const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  const int32_T r_dim0, const int32_T b_r_dim0, real_T *d2scaled,
  emxArray_real_T d_r)
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    d_r.data[k + r_dim0 * i] = r.data[k + b_r_dim0 * i] - y.data[i] / *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel83(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel84(int32_T
  outsize, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel85(const
  int32_T npages, const emxArray_real_T y, const emxArray_real_T r, const
  int32_T b_r, int32_T c_r, const int32_T r_dim0, const int32_T b_r_dim0,
  emxArray_real_T d_r)
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
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_r) + 1UL));
    d_r.data[k + r_dim0 * i] = r.data[k + b_r_dim0 * i] - y.data[i] /
      static_cast<real_T>(npages);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel86(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel87(int32_T r,
  emxArray_real_T y)
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
    y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel88(const
  emxArray_real_T X, int32_T b_X, emxArray_real_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_X);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = X.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel89(int32_T y,
  emxArray_real_T yy)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    yy.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel9(int32_T
  npages, const int32_T lin_dim1, real_T *d2scaled, emxArray_real_T lin)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real_T>((((k + 2) << 1) - lin_dim1) - 1) *
      *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel90(const
  emxArray_real_T dv6, const emxArray_real_T dv1, const int32_T i8, int32_T yy,
  emxArray_real_T b_yy)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(yy);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_yy.data[i] += dv1.data[(i8 + i) - 1] - dv6.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel91(const
  emxArray_real_T yy, const emxArray_real_T dv1, const int32_T i8, int32_T i9,
  emxArray_real_T d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i9 - i8) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = dv1.data[(i8 + i) - 1] - yy.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel92(const
  emxArray_boolean_T w, const int32_T i11, int32_T d, emxArray_real_T b_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(d);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_d.data[i] *= static_cast<real_T>(w.data[(i11 + i) - 1]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel93(const
  emxArray_real_T d, int32_T i2, real_T *d2scaled, emxArray_real_T absdiff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i2 + 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabs(d.data[k] - *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel94(const
  emxArray_real_T dv1, const int32_T i8, int32_T i9, emxArray_real_T yy)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((i9 - i8) - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    yy.data[i] = dv1.data[(i8 + i) - 1] - yy.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel95(real_T
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

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel96(const
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

static __global__ __launch_bounds__(1024, 1) void ecu_detrend_kernel97(const
  real_T rconde, const int32_T i2, int32_T npages, real_T *d2scaled,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k + 1] = *d2scaled - (static_cast<real_T>(k) + 1.0);
    y.data[(i2 - k) - 2] = rconde - (-(static_cast<real_T>(k) + 1.0));
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel98(real_T
  *d2scaled, int32_T *na, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[*na] = *d2scaled - static_cast<real_T>(*na);
  }
}

static __global__ __launch_bounds__(32, 1) void ecu_detrend_kernel99(const
  real_T rconde, int32_T *na, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[*na + 1] = rconde - (-static_cast<real_T>(*na));
  }
}

static void ecu_detrend_once()
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

static void emlrt_marshallIn(const mxArray *w, const char_T *identifier,
  emxArray_boolean_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(w), &thisId, y);
  emlrtDestroyArray(&w);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_boolean_T *y)
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

static void emlrt_marshallOut(const emxArray_boolean_T *u, const mxArray *y)
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

static void gpuEmxMemcpyCpuToGpu_boolean_T(emxArray_boolean_T *gpu, const
  emxArray_boolean_T *cpu)
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
      (gpu->allocatedSize) * sizeof(boolean_T)));
  }

  cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (boolean_T), cudaMemcpyHostToDevice);
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

static void gpuEmxMemcpyGpuToCpu_int8_T(emxArray_int8_T *cpu, emxArray_int8_T
  *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (int8_T), cudaMemcpyDeviceToHost);
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

static void minus(emxArray_real_T *in1, const emxArray_real_T *in2, const
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

  emxEnsureCapacity_real_T(in1, i, &id_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in2->size[0];
  } else {
    b = in3->size[0];
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = in2->data[i * stride_0_0] - in3->data[i * stride_1_0];
  }
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

//
// function [x,w] = ecu_detrend(x,order,thresh,niter,wsize,w)
void ecu_detrend(emxArray_real_T *x, real_T order, real_T thresh, real_T niter,
                 real_T wsize, emxArray_boolean_T *w)
{
  static creal_T dc{ 0.0,              // re
    0.0                                // im
  };

  static const int32_T iv[2]{ 1, 93 };

  static const int32_T iv1[2]{ 1, 51 };

  static const int32_T iv10[2]{ 1, 30 };

  static const int32_T iv11[2]{ 1, 16 };

  static const int32_T iv12[2]{ 1, 52 };

  static const int32_T iv13[2]{ 1, 30 };

  static const int32_T iv14[2]{ 1, 52 };

  static const int32_T iv17[2]{ 1, 30 };

  static const int32_T iv2[2]{ 1, 52 };

  static const int32_T iv20[2]{ 1, 52 };

  static const int32_T iv21[2]{ 1, 30 };

  static const int32_T iv27[2]{ 1, 52 };

  static const int32_T iv28[2]{ 1, 30 };

  static const int32_T iv3[2]{ 1, 30 };

  static const int32_T iv31[2]{ 1, 52 };

  static const int32_T iv32[2]{ 1, 30 };

  static const int32_T iv33[2]{ 1, 50 };

  static const int32_T iv35[2]{ 1, 50 };

  static const int32_T iv4[2]{ 1, 16 };

  static const int32_T iv5[2]{ 1, 51 };

  static const int32_T iv6[2]{ 1, 52 };

  static const int32_T iv7[2]{ 1, 30 };

  static const int32_T iv8[2]{ 1, 52 };

  static const char_T u[93]{ 'e', 'c', 'u', '_', 'd', 'e', 't', 'r', 'e', 'n',
    'd', ':', ' ', 'i', 'n', 'p', 'u', 't', ' ', 'w', 'e', 'i', 'g', 'h', 't',
    's', ' ', '\'', 'w', '\'', ' ', 'm', 'u', 's', 't', ' ', 'b', 'e', ' ', 's',
    'a', 'm', 'e', ' ', 's', 'i', 'z', 'e', ' ', 'a', 's', ' ', 'i', 'n', 'p',
    'u', 't', ' ', 'd', 'a', 't', 'a', ' ', '\'', 'x', '\'', ' ', '(', 'G', 'P',
    'U', ' ', 'p', 'r', 'e', 'a', 'l', 'l', 'o', 'c', 'a', 't', 'i', 'o', 'n',
    ' ', 'i', 's', 's', 'u', 'e', 's', ')' };

  static const char_T varargin_1[52]{ 'w', ' ', 'i', 'n', 't', 'e', 'r', 'p',
    'r', 'e', 't', 'e', 'd', ' ', 'a', 's', ' ', 'i', 'n', 'd', 'i', 'c', 'e',
    's', ' ', 'b', 'u', 't', ' ', 'v', 'a', 'l', 'u', 'e', 's', ' ', 'a', 'r',
    'e', ' ', 'o', 'u', 't', ' ', 'o', 'f', ' ', 'r', 'a', 'n', 'g', 'e' };

  static const char_T b_u[51]{ 'e', 'c', '_', 'd', 'e', 't', 'r', 'e', 'n', 'd',
    'C', 'o', 'm', 'p', 'u', 't', 'e', '/', 'r', 'e', 'g', 'w', '_', 'l', 'f',
    'n', ':', ' ', 'x', ' ', '&', ' ', 'y', ' ', 'a', 'r', 'e', ' ', 'u', 'n',
    'e', 'q', 'u', 'a', 'l', ' ', 's', 'i', 'z', 'e', 's' };

  static const char_T c_u[50]{ 'n', 's', 'a', 'm', 'p', 'l', 'e', 's', ' ', 'n',
    'o', 't', ' ', 'm', 'u', 'l', 't', 'i', 'p', 'l', 'e', ' ', 'o', 'f', ' ',
    'e', 'p', 'o', 'c', 'h', ' ', 's', 'i', 'z', 'e', ',', ' ', 't', 'r', 'u',
    'n', 'c', 'a', 't', 'i', 'n', 'g', '.', '.', '.' };

  static const char_T b_varargin_1[30]{ 'X', ' ', 'a', 'n', 'd', ' ', 'W', ' ',
    's', 'h', 'o', 'u', 'l', 'd', ' ', 'h', 'a', 'v', 'e', ' ', 's', 'a', 'm',
    'e', ' ', 'n', 'r', 'o', 'w', 's' };

  static const char_T c_varargin_1[16]{ 'w', 'e', 'i', 'g', 'h', 't', 's', ' ',
    'a', 'l', 'l', ' ', 'z', 'e', 'r', 'o' };

  ptrdiff_t b_ihi_t;
  ptrdiff_t b_ilo_t;
  ptrdiff_t ihi_t;
  ptrdiff_t ilo_t;
  dim3 block;
  dim3 grid;
  emxArray_boolean_T b_gpu_w;
  emxArray_boolean_T b_gpu_ww;
  emxArray_boolean_T c_gpu_ww;
  emxArray_boolean_T d_gpu_ww;
  emxArray_boolean_T e_gpu_ww;
  emxArray_boolean_T f_gpu_a;
  emxArray_boolean_T f_gpu_ww;
  emxArray_boolean_T g_gpu_ww;
  emxArray_boolean_T gpu_a;
  emxArray_boolean_T gpu_bv;
  emxArray_boolean_T gpu_bv1;
  emxArray_boolean_T gpu_bv10;
  emxArray_boolean_T gpu_bv2;
  emxArray_boolean_T gpu_bv3;
  emxArray_boolean_T gpu_bv4;
  emxArray_boolean_T gpu_bv5;
  emxArray_boolean_T gpu_bv6;
  emxArray_boolean_T gpu_bv8;
  emxArray_boolean_T gpu_bv9;
  emxArray_boolean_T gpu_w;
  emxArray_boolean_T gpu_ww;
  emxArray_boolean_T gpu_y;
  emxArray_boolean_T h_gpu_ww;
  emxArray_boolean_T i_gpu_ww;
  emxArray_boolean_T j_gpu_ww;
  emxArray_boolean_T *b_a;
  emxArray_boolean_T *b_w;
  emxArray_boolean_T *b_ww;
  emxArray_boolean_T *bv;
  emxArray_boolean_T *bv1;
  emxArray_boolean_T *bv10;
  emxArray_boolean_T *bv2;
  emxArray_boolean_T *bv3;
  emxArray_boolean_T *bv4;
  emxArray_boolean_T *bv5;
  emxArray_boolean_T *bv6;
  emxArray_boolean_T *bv8;
  emxArray_boolean_T *bv9;
  emxArray_boolean_T *c_w;
  emxArray_boolean_T *c_ww;
  emxArray_boolean_T *d_w;
  emxArray_boolean_T *d_ww;
  emxArray_boolean_T *e_a;
  emxArray_boolean_T *e_ww;
  emxArray_boolean_T *f_ww;
  emxArray_boolean_T *g_ww;
  emxArray_boolean_T *h_ww;
  emxArray_boolean_T *i_ww;
  emxArray_boolean_T *j_ww;
  emxArray_boolean_T *ww;
  emxArray_boolean_T *y;
  emxArray_creal_T b_gpu_D;
  emxArray_creal_T b_gpu_dt;
  emxArray_creal_T c_gpu_V;
  emxArray_creal_T gpu_D;
  emxArray_creal_T gpu_V;
  emxArray_creal_T gpu_dt;
  emxArray_creal_T *D;
  emxArray_creal_T *V;
  emxArray_creal_T *b_D;
  emxArray_creal_T *b_dt;
  emxArray_creal_T *c_V;
  emxArray_creal_T *dt;
  emxArray_int32_T b_gpu_ipiv;
  emxArray_int32_T b_gpu_ipiv_t;
  emxArray_int32_T b_gpu_jpvt;
  emxArray_int32_T gpu_ipiv;
  emxArray_int32_T gpu_ipiv_t;
  emxArray_int32_T gpu_iv37;
  emxArray_int32_T gpu_iv38;
  emxArray_int32_T gpu_jpvt;
  emxArray_int32_T *b_ipiv;
  emxArray_int32_T *b_ipiv_t;
  emxArray_int32_T *b_jpvt;
  emxArray_int32_T *ipiv;
  emxArray_int32_T *ipiv_t;
  emxArray_int32_T *iv37;
  emxArray_int32_T *iv38;
  emxArray_int32_T *jpvt;
  emxArray_int8_T b_gpu_a;
  emxArray_int8_T c_gpu_a;
  emxArray_int8_T gpu_minval;
  emxArray_int8_T *c_a;
  emxArray_int8_T *d_a;
  emxArray_int8_T *iv19;
  emxArray_int8_T *iv26;
  emxArray_int8_T *minval;
  emxArray_ptrdiff_t *b_jpvt_t;
  emxArray_ptrdiff_t *jpvt_t;
  emxArray_real_T b_gpu_A;
  emxArray_real_T b_gpu_B;
  emxArray_real_T b_gpu_U;
  emxArray_real_T b_gpu_V;
  emxArray_real_T b_gpu_X;
  emxArray_real_T b_gpu_Y;
  emxArray_real_T b_gpu_absdiff;
  emxArray_real_T b_gpu_d;
  emxArray_real_T b_gpu_lin;
  emxArray_real_T b_gpu_r;
  emxArray_real_T b_gpu_tau;
  emxArray_real_T b_gpu_topcs;
  emxArray_real_T b_gpu_trend;
  emxArray_real_T b_gpu_v;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_xx;
  emxArray_real_T b_gpu_xxx;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_A;
  emxArray_real_T c_gpu_B;
  emxArray_real_T c_gpu_absdiff;
  emxArray_real_T c_gpu_d;
  emxArray_real_T c_gpu_r;
  emxArray_real_T c_gpu_x;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_A;
  emxArray_real_T d_gpu_B;
  emxArray_real_T d_gpu_V;
  emxArray_real_T d_gpu_a;
  emxArray_real_T d_gpu_r;
  emxArray_real_T d_gpu_x;
  emxArray_real_T d_gpu_y;
  emxArray_real_T e_gpu_A;
  emxArray_real_T e_gpu_a;
  emxArray_real_T e_gpu_x;
  emxArray_real_T e_gpu_y;
  emxArray_real_T f_gpu_A;
  emxArray_real_T f_gpu_x;
  emxArray_real_T f_gpu_y;
  emxArray_real_T g_gpu_A;
  emxArray_real_T g_gpu_x;
  emxArray_real_T g_gpu_y;
  emxArray_real_T gpu_A;
  emxArray_real_T gpu_B;
  emxArray_real_T gpu_U;
  emxArray_real_T gpu_X;
  emxArray_real_T gpu_Y;
  emxArray_real_T gpu_absdiff;
  emxArray_real_T gpu_b;
  emxArray_real_T gpu_d;
  emxArray_real_T gpu_dv1;
  emxArray_real_T gpu_dv13;
  emxArray_real_T gpu_dv2;
  emxArray_real_T gpu_dv20;
  emxArray_real_T gpu_dv23;
  emxArray_real_T gpu_dv3;
  emxArray_real_T gpu_dv4;
  emxArray_real_T gpu_dv5;
  emxArray_real_T gpu_dv6;
  emxArray_real_T gpu_dv7;
  emxArray_real_T gpu_dv8;
  emxArray_real_T gpu_lin;
  emxArray_real_T gpu_r;
  emxArray_real_T gpu_tau;
  emxArray_real_T gpu_topcs;
  emxArray_real_T gpu_trend;
  emxArray_real_T gpu_v;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xx;
  emxArray_real_T gpu_xxx;
  emxArray_real_T gpu_yy;
  emxArray_real_T h_gpu_A;
  emxArray_real_T h_gpu_x;
  emxArray_real_T h_gpu_y;
  emxArray_real_T i_gpu_A;
  emxArray_real_T i_gpu_x;
  emxArray_real_T i_gpu_y;
  emxArray_real_T j_gpu_A;
  emxArray_real_T j_gpu_x;
  emxArray_real_T j_gpu_y;
  emxArray_real_T k_gpu_A;
  emxArray_real_T k_gpu_x;
  emxArray_real_T k_gpu_y;
  emxArray_real_T l_gpu_A;
  emxArray_real_T l_gpu_x;
  emxArray_real_T l_gpu_y;
  emxArray_real_T m_gpu_x;
  emxArray_real_T m_gpu_y;
  emxArray_real_T n_gpu_y;
  emxArray_real_T o_gpu_y;
  emxArray_real_T *A;
  emxArray_real_T *B;
  emxArray_real_T *U;
  emxArray_real_T *X;
  emxArray_real_T *Y;
  emxArray_real_T *a;
  emxArray_real_T *absdiff;
  emxArray_real_T *b;
  emxArray_real_T *b_A;
  emxArray_real_T *b_B;
  emxArray_real_T *b_U;
  emxArray_real_T *b_V;
  emxArray_real_T *b_X;
  emxArray_real_T *b_Y;
  emxArray_real_T *b_absdiff;
  emxArray_real_T *b_d;
  emxArray_real_T *b_lin;
  emxArray_real_T *b_r;
  emxArray_real_T *b_scale;
  emxArray_real_T *b_tau;
  emxArray_real_T *b_topcs;
  emxArray_real_T *b_trend;
  emxArray_real_T *b_v;
  emxArray_real_T *b_vright;
  emxArray_real_T *b_wi;
  emxArray_real_T *b_wimag;
  emxArray_real_T *b_wr;
  emxArray_real_T *b_wreal;
  emxArray_real_T *b_x;
  emxArray_real_T *b_xx;
  emxArray_real_T *b_xxx;
  emxArray_real_T *c_A;
  emxArray_real_T *c_B;
  emxArray_real_T *c_absdiff;
  emxArray_real_T *c_d;
  emxArray_real_T *c_r;
  emxArray_real_T *c_tau;
  emxArray_real_T *c_wi;
  emxArray_real_T *c_wr;
  emxArray_real_T *d;
  emxArray_real_T *d_A;
  emxArray_real_T *d_B;
  emxArray_real_T *d_V;
  emxArray_real_T *d_d;
  emxArray_real_T *d_r;
  emxArray_real_T *d_tau;
  emxArray_real_T *d_wi;
  emxArray_real_T *d_wr;
  emxArray_real_T *d_x;
  emxArray_real_T *dv1;
  emxArray_real_T *dv13;
  emxArray_real_T *dv2;
  emxArray_real_T *dv20;
  emxArray_real_T *dv23;
  emxArray_real_T *dv3;
  emxArray_real_T *dv4;
  emxArray_real_T *dv5;
  emxArray_real_T *dv6;
  emxArray_real_T *dv7;
  emxArray_real_T *dv8;
  emxArray_real_T *e_A;
  emxArray_real_T *e_d;
  emxArray_real_T *e_tau;
  emxArray_real_T *e_x;
  emxArray_real_T *f_A;
  emxArray_real_T *f_a;
  emxArray_real_T *f_tau;
  emxArray_real_T *f_x;
  emxArray_real_T *f_y;
  emxArray_real_T *g_A;
  emxArray_real_T *g_x;
  emxArray_real_T *g_y;
  emxArray_real_T *h_A;
  emxArray_real_T *h_x;
  emxArray_real_T *h_y;
  emxArray_real_T *i_A;
  emxArray_real_T *i_x;
  emxArray_real_T *i_y;
  emxArray_real_T *j_A;
  emxArray_real_T *j_x;
  emxArray_real_T *j_y;
  emxArray_real_T *k_A;
  emxArray_real_T *k_x;
  emxArray_real_T *k_y;
  emxArray_real_T *l_A;
  emxArray_real_T *l_x;
  emxArray_real_T *l_y;
  emxArray_real_T *lin;
  emxArray_real_T *m_x;
  emxArray_real_T *m_y;
  emxArray_real_T *n_x;
  emxArray_real_T *n_y;
  emxArray_real_T *o_y;
  emxArray_real_T *p_y;
  emxArray_real_T *q_y;
  emxArray_real_T *r;
  emxArray_real_T *r_y;
  emxArray_real_T *s_y;
  emxArray_real_T *scale;
  emxArray_real_T *tau;
  emxArray_real_T *topcs;
  emxArray_real_T *trend;
  emxArray_real_T *v;
  emxArray_real_T *vright;
  emxArray_real_T *wi;
  emxArray_real_T *wimag;
  emxArray_real_T *wr;
  emxArray_real_T *wreal;
  emxArray_real_T *xx;
  emxArray_real_T *xxx;
  emxArray_real_T *yy;
  const mxArray *propValues[1];
  const mxArray *ab_y;
  const mxArray *bb_y;
  const mxArray *cb_y;
  const mxArray *d_y;
  const mxArray *db_y;
  const mxArray *e_y;
  const mxArray *eb_y;
  const mxArray *fb_y;
  const mxArray *gb_y;
  const mxArray *hb_y;
  const mxArray *ib_y;
  const mxArray *jb_y;
  const mxArray *kb_y;
  const mxArray *lb_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m8;
  const mxArray *mb_y;
  const mxArray *nb_y;
  const mxArray *ob_y;
  const mxArray *pb_y;
  const mxArray *qb_y;
  const mxArray *rb_y;
  const mxArray *sb_y;
  const mxArray *t_y;
  const mxArray *tb_y;
  const mxArray *u_y;
  const mxArray *v_y;
  const mxArray *w_y;
  const mxArray *x_y;
  const mxArray *y_y;
  creal_T f_d;
  creal_T *gpu_dc;
  real_T abnrm;
  real_T d2scaled;
  real_T rconde;
  real_T rcondv;
  real_T *gpu_abnrm;
  real_T *gpu_d2scaled;
  int32_T b_outsize[2];
  int32_T c_outsize[2];
  int32_T b_i;
  int32_T d_outsize;
  int32_T i;
  int32_T i13;
  int32_T i14;
  int32_T i2;
  int32_T na;
  int32_T npages;
  int32_T ntilecols;
  int32_T *b_gpu_outsize;
  int32_T *gpu_i;
  int32_T *gpu_na;
  uint32_T outsize[2];
  uint32_T (*gpu_outsize)[2];
  const char_T *b_propClasses[1]{ "coder.internal.string" };

  const char_T *b_propNames[1]{ "Value" };

  const char_T *c_propClasses[1]{ "coder.internal.string" };

  const char_T *c_propNames[1]{ "Value" };

  const char_T *propClasses[1]{ "coder.internal.string" };

  const char_T *propNames[1]{ "Value" };

  boolean_T A_dirtyOnCpu;
  boolean_T A_dirtyOnGpu;
  boolean_T D_dirtyOnCpu;
  boolean_T D_dirtyOnGpu;
  boolean_T U_dirtyOnCpu;
  boolean_T U_dirtyOnGpu;
  boolean_T V_dirtyOnCpu;
  boolean_T V_dirtyOnGpu;
  boolean_T X_dirtyOnCpu;
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
  boolean_T b_X_dirtyOnCpu;
  boolean_T b_Y_dirtyOnCpu;
  boolean_T b_Y_dirtyOnGpu;
  boolean_T b_a_dirtyOnCpu;
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
  boolean_T b_r_dirtyOnGpu;
  boolean_T b_tau_dirtyOnGpu;
  boolean_T b_v_dirtyOnGpu;
  boolean_T b_w_dirtyOnCpu;
  boolean_T b_w_dirtyOnGpu;
  boolean_T b_ww_dirtyOnGpu;
  boolean_T b_x_dirtyOnCpu;
  boolean_T b_x_dirtyOnGpu;
  boolean_T b_xx_dirtyOnCpu;
  boolean_T b_xx_dirtyOnGpu;
  boolean_T b_y;
  boolean_T b_y_dirtyOnCpu;
  boolean_T b_y_dirtyOnGpu;
  boolean_T bv10_dirtyOnCpu;
  boolean_T bv10_dirtyOnGpu;
  boolean_T bv1_dirtyOnGpu;
  boolean_T bv2_dirtyOnGpu;
  boolean_T bv3_dirtyOnGpu;
  boolean_T bv4_dirtyOnGpu;
  boolean_T bv5_dirtyOnGpu;
  boolean_T bv6_dirtyOnCpu;
  boolean_T bv6_dirtyOnGpu;
  boolean_T bv8_dirtyOnGpu;
  boolean_T bv9_dirtyOnGpu;
  boolean_T bv_dirtyOnGpu;
  boolean_T c_A_dirtyOnCpu;
  boolean_T c_A_dirtyOnGpu;
  boolean_T c_V_dirtyOnCpu;
  boolean_T c_V_dirtyOnGpu;
  boolean_T c_d_dirtyOnCpu;
  boolean_T c_d_dirtyOnGpu;
  boolean_T c_ww_dirtyOnGpu;
  boolean_T c_x_dirtyOnCpu;
  boolean_T c_x_dirtyOnGpu;
  boolean_T c_y;
  boolean_T c_y_dirtyOnCpu;
  boolean_T c_y_dirtyOnGpu;
  boolean_T d_A_dirtyOnCpu;
  boolean_T d_A_dirtyOnGpu;
  boolean_T d_V_dirtyOnCpu;
  boolean_T d_V_dirtyOnGpu;
  boolean_T d_dirtyOnCpu;
  boolean_T d_dirtyOnGpu;
  boolean_T d_ww_dirtyOnGpu;
  boolean_T d_x_dirtyOnCpu;
  boolean_T d_x_dirtyOnGpu;
  boolean_T d_y_dirtyOnCpu;
  boolean_T d_y_dirtyOnGpu;
  boolean_T dc_dirtyOnGpu;
  boolean_T dv13_dirtyOnCpu;
  boolean_T dv13_dirtyOnGpu;
  boolean_T dv1_dirtyOnCpu;
  boolean_T dv1_dirtyOnGpu;
  boolean_T dv20_dirtyOnGpu;
  boolean_T dv23_dirtyOnGpu;
  boolean_T dv4_dirtyOnGpu;
  boolean_T dv5_dirtyOnGpu;
  boolean_T dv6_dirtyOnGpu;
  boolean_T dv7_dirtyOnCpu;
  boolean_T dv7_dirtyOnGpu;
  boolean_T dv8_dirtyOnGpu;
  boolean_T e_A_dirtyOnGpu;
  boolean_T e_ww_dirtyOnGpu;
  boolean_T e_x_dirtyOnCpu;
  boolean_T e_x_dirtyOnGpu;
  boolean_T e_y_dirtyOnCpu;
  boolean_T e_y_dirtyOnGpu;
  boolean_T f_A_dirtyOnGpu;
  boolean_T f_ww_dirtyOnGpu;
  boolean_T f_x_dirtyOnCpu;
  boolean_T f_x_dirtyOnGpu;
  boolean_T f_y_dirtyOnCpu;
  boolean_T f_y_dirtyOnGpu;
  boolean_T g_ww_dirtyOnGpu;
  boolean_T g_x_dirtyOnCpu;
  boolean_T g_x_dirtyOnGpu;
  boolean_T g_y_dirtyOnCpu;
  boolean_T g_y_dirtyOnGpu;
  boolean_T guard1{ false };

  boolean_T h_ww_dirtyOnGpu;
  boolean_T h_x_dirtyOnCpu;
  boolean_T h_x_dirtyOnGpu;
  boolean_T h_y_dirtyOnCpu;
  boolean_T h_y_dirtyOnGpu;
  boolean_T i_ww_dirtyOnGpu;
  boolean_T i_x_dirtyOnCpu;
  boolean_T i_x_dirtyOnGpu;
  boolean_T i_y_dirtyOnCpu;
  boolean_T i_y_dirtyOnGpu;
  boolean_T ipiv_dirtyOnCpu;
  boolean_T ipiv_dirtyOnGpu;
  boolean_T iv37_dirtyOnCpu;
  boolean_T iv38_dirtyOnCpu;
  boolean_T j_ww_dirtyOnGpu;
  boolean_T j_x_dirtyOnCpu;
  boolean_T j_x_dirtyOnGpu;
  boolean_T j_y_dirtyOnCpu;
  boolean_T j_y_dirtyOnGpu;
  boolean_T jpvt_dirtyOnCpu;
  boolean_T jpvt_dirtyOnGpu;
  boolean_T k_x_dirtyOnCpu;
  boolean_T k_x_dirtyOnGpu;
  boolean_T k_y_dirtyOnCpu;
  boolean_T k_y_dirtyOnGpu;
  boolean_T l_x_dirtyOnCpu;
  boolean_T l_x_dirtyOnGpu;
  boolean_T l_y_dirtyOnCpu;
  boolean_T lin_dirtyOnCpu;
  boolean_T lin_dirtyOnGpu;
  boolean_T minval_dirtyOnGpu;
  boolean_T outsize_dirtyOnCpu;
  boolean_T outsize_dirtyOnGpu;
  boolean_T r_dirtyOnCpu;
  boolean_T r_dirtyOnGpu;
  boolean_T tau_dirtyOnGpu;
  boolean_T trend_dirtyOnCpu;
  boolean_T trend_dirtyOnGpu;
  boolean_T v_dirtyOnGpu;
  boolean_T validLaunchParams;
  boolean_T w_dirtyOnCpu;
  boolean_T w_dirtyOnGpu;
  boolean_T ww_dirtyOnGpu;
  boolean_T x_dirtyOnCpu;
  boolean_T x_dirtyOnGpu;
  boolean_T xx_dirtyOnCpu;
  boolean_T xx_dirtyOnGpu;
  boolean_T y_dirtyOnCpu;
  boolean_T y_dirtyOnGpu;
  boolean_T yy_dirtyOnCpu;
  boolean_T yy_dirtyOnGpu;
  gpuEmxReset_boolean_T(&f_gpu_a);
  gpuEmxReset_real_T(&c_gpu_absdiff);
  gpuEmxReset_boolean_T(&gpu_bv10);
  gpuEmxReset_real_T(&gpu_dv23);
  gpuEmxReset_boolean_T(&j_gpu_ww);
  gpuEmxReset_real_T(&c_gpu_d);
  gpuEmxReset_int32_T(&gpu_iv38);
  gpuEmxReset_boolean_T(&gpu_bv9);
  gpuEmxReset_int32_T(&gpu_iv37);
  gpuEmxReset_boolean_T(&gpu_bv8);
  gpuEmxReset_real_T(&e_gpu_a);
  gpuEmxReset_real_T(&d_gpu_a);
  gpuEmxReset_real_T(&b_gpu_trend);
  gpuEmxReset_real_T(&gpu_trend);
  gpuEmxReset_real_T(&m_gpu_x);
  mwCudaMalloc(&gpu_abnrm, 8UL);
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_real_T(&o_gpu_y);
  gpuEmxReset_real_T(&n_gpu_y);
  gpuEmxReset_int8_T(&c_gpu_a);
  gpuEmxReset_real_T(&m_gpu_y);
  gpuEmxReset_real_T(&l_gpu_y);
  gpuEmxReset_int8_T(&b_gpu_a);
  gpuEmxReset_real_T(&b_gpu_absdiff);
  gpuEmxReset_real_T(&b_gpu_d);
  gpuEmxReset_boolean_T(&gpu_a);
  gpuEmxReset_real_T(&gpu_absdiff);
  gpuEmxReset_boolean_T(&gpu_bv6);
  gpuEmxReset_real_T(&gpu_dv20);
  gpuEmxReset_boolean_T(&i_gpu_ww);
  gpuEmxReset_real_T(&gpu_d);
  gpuEmxReset_real_T(&gpu_yy);
  gpuEmxReset_real_T(&d_gpu_r);
  gpuEmxReset_real_T(&d_gpu_B);
  gpuEmxReset_real_T(&k_gpu_y);
  gpuEmxReset_real_T(&c_gpu_r);
  gpuEmxReset_real_T(&j_gpu_y);
  gpuEmxReset_real_T(&l_gpu_x);
  gpuEmxReset_real_T(&i_gpu_y);
  gpuEmxReset_real_T(&b_gpu_Y);
  gpuEmxReset_real_T(&b_gpu_tau);
  gpuEmxReset_int32_T(&b_gpu_jpvt);
  gpuEmxReset_real_T(&c_gpu_B);
  gpuEmxReset_int32_T(&b_gpu_ipiv);
  gpuEmxReset_real_T(&b_gpu_B);
  gpuEmxReset_boolean_T(&h_gpu_ww);
  gpuEmxReset_real_T(&h_gpu_y);
  gpuEmxReset_real_T(&l_gpu_A);
  gpuEmxReset_real_T(&k_gpu_x);
  gpuEmxReset_int32_T(&b_gpu_ipiv_t);
  gpuEmxReset_real_T(&g_gpu_y);
  gpuEmxReset_real_T(&j_gpu_x);
  gpuEmxReset_real_T(&f_gpu_y);
  gpuEmxReset_real_T(&k_gpu_A);
  gpuEmxReset_real_T(&gpu_Y);
  gpuEmxReset_real_T(&j_gpu_A);
  gpuEmxReset_real_T(&gpu_tau);
  gpuEmxReset_real_T(&b_gpu_X);
  gpuEmxReset_real_T(&i_gpu_A);
  gpuEmxReset_int32_T(&gpu_jpvt);
  gpuEmxReset_real_T(&b_gpu_xxx);
  gpuEmxReset_boolean_T(&g_gpu_ww);
  gpuEmxReset_int32_T(&gpu_ipiv);
  gpuEmxReset_real_T(&gpu_B);
  gpuEmxReset_real_T(&b_gpu_topcs);
  gpuEmxReset_real_T(&h_gpu_A);
  gpuEmxReset_creal_T(&b_gpu_dt);
  gpuEmxReset_int32_T(&gpu_ipiv_t);
  mwCudaMalloc(&b_gpu_outsize, 4UL);
  mwCudaMalloc(&gpu_outsize, 8UL);
  gpuEmxReset_real_T(&g_gpu_A);
  gpuEmxReset_boolean_T(&gpu_bv5);
  gpuEmxReset_real_T(&f_gpu_A);
  gpuEmxReset_real_T(&b_gpu_U);
  gpuEmxReset_real_T(&d_gpu_V);
  gpuEmxReset_creal_T(&c_gpu_V);
  gpuEmxReset_real_T(&b_gpu_v);
  gpuEmxReset_creal_T(&b_gpu_D);
  gpuEmxReset_real_T(&gpu_X);
  gpuEmxReset_real_T(&e_gpu_A);
  gpuEmxReset_real_T(&gpu_xxx);
  gpuEmxReset_real_T(&d_gpu_A);
  gpuEmxReset_real_T(&c_gpu_A);
  gpuEmxReset_real_T(&gpu_topcs);
  gpuEmxReset_creal_T(&gpu_dt);
  gpuEmxReset_real_T(&b_gpu_xx);
  gpuEmxReset_boolean_T(&gpu_bv4);
  mwCudaMalloc(&gpu_i, 4UL);
  gpuEmxReset_real_T(&gpu_dv13);
  gpuEmxReset_real_T(&e_gpu_y);
  gpuEmxReset_real_T(&i_gpu_x);
  gpuEmxReset_boolean_T(&gpu_bv3);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_real_T(&gpu_U);
  gpuEmxReset_real_T(&b_gpu_V);
  gpuEmxReset_creal_T(&gpu_V);
  gpuEmxReset_real_T(&gpu_v);
  gpuEmxReset_creal_T(&gpu_D);
  gpuEmxReset_real_T(&b_gpu_A);
  gpuEmxReset_real_T(&gpu_A);
  gpuEmxReset_boolean_T(&f_gpu_ww);
  gpuEmxReset_real_T(&gpu_xx);
  gpuEmxReset_boolean_T(&gpu_bv2);
  gpuEmxReset_boolean_T(&gpu_bv1);
  gpuEmxReset_real_T(&gpu_dv7);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_real_T(&gpu_dv8);
  gpuEmxReset_real_T(&h_gpu_x);
  gpuEmxReset_real_T(&g_gpu_x);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_boolean_T(&e_gpu_ww);
  gpuEmxReset_boolean_T(&d_gpu_ww);
  gpuEmxReset_boolean_T(&gpu_bv);
  gpuEmxReset_real_T(&gpu_dv6);
  gpuEmxReset_real_T(&f_gpu_x);
  gpuEmxReset_real_T(&e_gpu_x);
  gpuEmxReset_real_T(&gpu_dv5);
  gpuEmxReset_boolean_T(&c_gpu_ww);
  gpuEmxReset_boolean_T(&b_gpu_ww);
  gpuEmxReset_real_T(&d_gpu_x);
  gpuEmxReset_real_T(&gpu_dv4);
  mwCudaMalloc(&gpu_na, 4UL);
  gpuEmxReset_boolean_T(&gpu_ww);
  gpuEmxReset_real_T(&gpu_dv3);
  gpuEmxReset_real_T(&b_gpu_lin);
  gpuEmxReset_real_T(&b_gpu_r);
  gpuEmxReset_real_T(&c_gpu_x);
  gpuEmxReset_real_T(&gpu_dv2);
  gpuEmxReset_real_T(&gpu_lin);
  mwCudaMalloc(&gpu_d2scaled, 8UL);
  gpuEmxReset_int8_T(&gpu_minval);
  gpuEmxReset_real_T(&gpu_r);
  gpuEmxReset_real_T(&b_gpu_x);
  gpuEmxReset_boolean_T(&b_gpu_w);
  gpuEmxReset_boolean_T(&gpu_w);
  gpuEmxReset_real_T(&gpu_dv1);
  gpuEmxReset_real_T(&gpu_x);
  gpuEmxReset_boolean_T(&gpu_y);
  mwCudaMalloc(&gpu_dc, 16UL);
  bv10_dirtyOnGpu = false;
  dv23_dirtyOnGpu = false;
  j_ww_dirtyOnGpu = false;
  c_d_dirtyOnGpu = false;
  bv9_dirtyOnGpu = false;
  bv8_dirtyOnGpu = false;
  a_dirtyOnGpu = false;
  trend_dirtyOnGpu = false;
  b_dirtyOnGpu = false;
  k_y_dirtyOnGpu = false;
  j_y_dirtyOnGpu = false;
  b_d_dirtyOnGpu = false;
  bv6_dirtyOnGpu = false;
  dv20_dirtyOnGpu = false;
  i_ww_dirtyOnGpu = false;
  d_dirtyOnGpu = false;
  yy_dirtyOnGpu = false;
  i_y_dirtyOnGpu = false;
  l_x_dirtyOnGpu = false;
  h_y_dirtyOnGpu = false;
  b_Y_dirtyOnGpu = false;
  b_tau_dirtyOnGpu = false;
  b_jpvt_dirtyOnGpu = false;
  b_ipiv_dirtyOnGpu = false;
  h_ww_dirtyOnGpu = false;
  f_A_dirtyOnGpu = false;
  k_x_dirtyOnGpu = false;
  g_y_dirtyOnGpu = false;
  j_x_dirtyOnGpu = false;
  f_y_dirtyOnGpu = false;
  Y_dirtyOnGpu = false;
  tau_dirtyOnGpu = false;
  e_A_dirtyOnGpu = false;
  jpvt_dirtyOnGpu = false;
  g_ww_dirtyOnGpu = false;
  ipiv_dirtyOnGpu = false;
  d_A_dirtyOnGpu = false;
  outsize_dirtyOnGpu = false;
  bv5_dirtyOnGpu = false;
  b_U_dirtyOnGpu = false;
  d_V_dirtyOnGpu = false;
  c_V_dirtyOnGpu = false;
  b_v_dirtyOnGpu = false;
  b_D_dirtyOnGpu = false;
  c_A_dirtyOnGpu = false;
  b_A_dirtyOnGpu = false;
  b_xx_dirtyOnGpu = false;
  bv4_dirtyOnGpu = false;
  dv13_dirtyOnGpu = false;
  e_y_dirtyOnGpu = false;
  i_x_dirtyOnGpu = false;
  bv3_dirtyOnGpu = false;
  d_y_dirtyOnGpu = false;
  U_dirtyOnGpu = false;
  b_V_dirtyOnGpu = false;
  V_dirtyOnGpu = false;
  v_dirtyOnGpu = false;
  D_dirtyOnGpu = false;
  A_dirtyOnGpu = false;
  f_ww_dirtyOnGpu = false;
  xx_dirtyOnGpu = false;
  bv2_dirtyOnGpu = false;
  bv1_dirtyOnGpu = false;
  dv7_dirtyOnGpu = false;
  c_y_dirtyOnGpu = false;
  dv8_dirtyOnGpu = false;
  h_x_dirtyOnGpu = false;
  g_x_dirtyOnGpu = false;
  b_y_dirtyOnGpu = false;
  e_ww_dirtyOnGpu = false;
  d_ww_dirtyOnGpu = false;
  bv_dirtyOnGpu = false;
  dv6_dirtyOnGpu = false;
  f_x_dirtyOnGpu = false;
  e_x_dirtyOnGpu = false;
  dv5_dirtyOnGpu = false;
  c_ww_dirtyOnGpu = false;
  b_ww_dirtyOnGpu = false;
  d_x_dirtyOnGpu = false;
  dv4_dirtyOnGpu = false;
  ww_dirtyOnGpu = false;
  b_lin_dirtyOnGpu = false;
  b_r_dirtyOnGpu = false;
  c_x_dirtyOnGpu = false;
  lin_dirtyOnGpu = false;
  minval_dirtyOnGpu = false;
  r_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  b_w_dirtyOnGpu = false;
  dv1_dirtyOnGpu = false;
  y_dirtyOnGpu = false;
  bv10_dirtyOnCpu = false;
  c_d_dirtyOnCpu = false;
  iv38_dirtyOnCpu = false;
  iv37_dirtyOnCpu = false;
  b_a_dirtyOnCpu = false;
  trend_dirtyOnCpu = false;
  b_dirtyOnCpu = false;
  l_y_dirtyOnCpu = false;
  k_y_dirtyOnCpu = false;
  j_y_dirtyOnCpu = false;
  i_y_dirtyOnCpu = false;
  a_dirtyOnCpu = false;
  b_d_dirtyOnCpu = false;
  bv6_dirtyOnCpu = false;
  d_dirtyOnCpu = false;
  yy_dirtyOnCpu = false;
  h_y_dirtyOnCpu = false;
  l_x_dirtyOnCpu = false;
  g_y_dirtyOnCpu = false;
  b_Y_dirtyOnCpu = false;
  b_jpvt_dirtyOnCpu = false;
  b_ipiv_dirtyOnCpu = false;
  k_x_dirtyOnCpu = false;
  f_y_dirtyOnCpu = false;
  j_x_dirtyOnCpu = false;
  e_y_dirtyOnCpu = false;
  Y_dirtyOnCpu = false;
  b_X_dirtyOnCpu = false;
  d_A_dirtyOnCpu = false;
  jpvt_dirtyOnCpu = false;
  ipiv_dirtyOnCpu = false;
  outsize_dirtyOnCpu = false;
  b_U_dirtyOnCpu = false;
  d_V_dirtyOnCpu = false;
  c_V_dirtyOnCpu = false;
  b_D_dirtyOnCpu = false;
  X_dirtyOnCpu = false;
  c_A_dirtyOnCpu = false;
  b_A_dirtyOnCpu = false;
  b_xx_dirtyOnCpu = false;
  dv13_dirtyOnCpu = false;
  d_y_dirtyOnCpu = false;
  i_x_dirtyOnCpu = false;
  c_y_dirtyOnCpu = false;
  U_dirtyOnCpu = false;
  b_V_dirtyOnCpu = false;
  V_dirtyOnCpu = false;
  D_dirtyOnCpu = false;
  A_dirtyOnCpu = false;
  xx_dirtyOnCpu = false;
  dv7_dirtyOnCpu = false;
  b_y_dirtyOnCpu = false;
  h_x_dirtyOnCpu = false;
  g_x_dirtyOnCpu = false;
  y_dirtyOnCpu = false;
  f_x_dirtyOnCpu = false;
  e_x_dirtyOnCpu = false;
  d_x_dirtyOnCpu = false;
  b_lin_dirtyOnCpu = false;
  r_dirtyOnCpu = false;
  c_x_dirtyOnCpu = false;
  lin_dirtyOnCpu = false;
  b_x_dirtyOnCpu = false;
  b_w_dirtyOnCpu = false;
  dv1_dirtyOnCpu = false;
  w_dirtyOnGpu = false;
  w_dirtyOnCpu = true;
  x_dirtyOnGpu = false;
  x_dirtyOnCpu = true;
  cudaMemcpy(gpu_dc, &dc, 16UL, cudaMemcpyHostToDevice);
  ecu_detrend_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_dc);
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
  //  Input validation
  // 'ecu_detrend:20' x double
  //  Raw data
  // 'ecu_detrend:21' order double = 10
  //  Polynomial order (default=10)
  // 'ecu_detrend:22' thresh double = 3
  //  Outlier threshold (default=3)
  // 'ecu_detrend:23' niter double = 3
  //  Number of iterations (default=3)
  // 'ecu_detrend:24' wsize double = 0
  //  Overlapping window size (default=0, fit to entire timecourse)
  // 'ecu_detrend:25' w logical = false
  //  Pre-calculated weights
  // basis {istext} = 'polynomials' % Basis function
  // doubleIn logical = false       % Compute in double-precision
  // singleOut logical = true       % Output in single-precision
  //  feature('SetPrecision', 24); % default to single precision in future
  //  Generate CUDA kernel
  // 'ecu_detrend:33' coder.gpu.kernelfun;
  //  Preallocate
  // 'ecu_detrend:36' nChs = size(x,2);
  // 'ecu_detrend:37' if ~isany(w)
  //  Return if empty
  // 'isany:3' if isempty(x)
  emxInit_boolean_T(&y, 2, &ie_emlrtRTEI, true);
  guard1 = false;
  if ((w->size[0] == 0) || (w->size[1] == 0)) {
    // 'isany:3' ;
    // 'isany:3' y=false;
    guard1 = true;
  } else {
    boolean_T exitg1;

    //  Convert to cell
    // 'isany:6' if istable(x)
    //  Find non-empty, non-zero numeric vals, or text~=""
    // 'isany:9' if isnumeric(x) || islogical(x)
    // 'isany:10' if any(x)
    for (i = 0; i < 2; i++) {
      outsize[i] = static_cast<uint32_T>(w->size[i]);
      outsize_dirtyOnCpu = true;
    }

    i = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = static_cast<int32_T>(outsize[1]);
    emxEnsureCapacity_boolean_T(y, i, &d_emlrtRTEI);
    gpuEmxEnsureCapacity_boolean_T(y, &gpu_y);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
      static_cast<int32_T>(outsize[1]) - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ecu_detrend_kernel2<<<grid, block>>>(static_cast<int32_T>(outsize[1]) - 1,
        gpu_y);
      y_dirtyOnGpu = true;
    }

    npages = w->size[1];
    i2 = 0;
    for (b_i = 0; b_i < npages; b_i++) {
      i = w->size[0];
      na = i2 + i;
      ntilecols = i2;
      i2 += i;
      exitg1 = false;
      while ((!exitg1) && (ntilecols + 1 <= na)) {
        if (w->data[ntilecols]) {
          if (y_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(y, &gpu_y);
          }

          y->data[b_i] = true;
          y_dirtyOnGpu = false;
          exitg1 = true;
        } else {
          ntilecols++;
        }
      }
    }

    b_y = true;
    na = 1;
    exitg1 = false;
    while ((!exitg1) && (na <= y->size[1])) {
      if (y_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_boolean_T(y, &gpu_y);
      }

      y_dirtyOnGpu = false;
      if (!y->data[na - 1]) {
        b_y = false;
        exitg1 = true;
      } else {
        na++;
      }
    }

    if (b_y) {
      boolean_T c_x[2];

      // 'isany:10' ;
      // 'isany:10' y=true;
      for (i = 0; i < 2; i++) {
        c_x[i] = (w->size[i] != x->size[i]);
      }

      na = 1;
      exitg1 = false;
      while ((!exitg1) && (na < 3)) {
        if (!c_x[na - 1]) {
          b_y = false;
          exitg1 = true;
        } else {
          na++;
        }
      }

      if (b_y) {
        // 'ecu_detrend:39' elseif size(w)~=size(x)
        // 'ecu_detrend:40' error("ecu_detrend: input weights 'w' must be same size as input data 'x' (GPU preallocation issues)");
        d_y = nullptr;
        m = nullptr;
        emlrtAssign(&d_y, emlrtCreateClassInstance2022a(emlrtRootTLSGlobal,
          "coder.internal.string"));
        m = nullptr;
        e_y = nullptr;
        m1 = emlrtCreateCharArray(2, &iv[0]);
        emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 93, m1, &u[0]);
        emlrtAssign(&e_y, m1);
        emlrtAssign(&m, e_y);
        propValues[0] = m;
        emlrtSetAllProperties(emlrtRootTLSGlobal, &d_y, 0, 1, (const char_T **)
                              &propNames[0], (const char_T **)&propClasses[0],
                              &propValues[0]);
        emlrtAssign(&d_y, emlrtConvertInstanceToRedirectSource
                    (emlrtRootTLSGlobal, d_y, 0, "coder.internal.string"));
        b_error(d_y, &emlrtMCI);
      }
    } else {
      // 'isany:10' else
      // 'isany:10' ;
      // 'isany:10' y=false;
      guard1 = true;
    }
  }

  if (guard1) {
    // 'ecu_detrend:38' w = coder.nullcopy(true(size(x)));
    for (i = 0; i < 2; i++) {
      outsize[i] = static_cast<uint32_T>(x->size[i]);
      outsize_dirtyOnCpu = true;
    }

    i = w->size[0] * w->size[1];
    w->size[0] = static_cast<int32_T>(outsize[0]);
    w->size[1] = static_cast<int32_T>(outsize[1]);
    emxEnsureCapacity_boolean_T(w, i, &c_emlrtRTEI);
  }

  emxFree_boolean_T(&y);

  //  Call computational functions - parfor loop across channels
  // 'ecu_detrend:44' for ch = 1:nChs
  b_i = x->size[1];
  if (b_i - 1 >= 0) {
    if ((wsize == 0.0) || std::isnan(wsize)) {
      // 'isany:10' else
      // 'isany:10' ;
      // 'isany:10' y=false;
      c_y = false;
    } else {
      // 'isany:10' ;
      // 'isany:10' y=true;
      c_y = true;
    }
  }

  emxInit_real_T(&dv1, 1, &je_emlrtRTEI, true);
  emxInit_boolean_T(&b_w, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&b_x, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&trend, 1, &ke_emlrtRTEI, true);
  emxInit_real_T(&a, 1, &le_emlrtRTEI, true);
  emxInit_int8_T(&minval, 1, &me_emlrtRTEI, true);
  emxInit_real_T(&r, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&lin, 2, &ne_emlrtRTEI, true);
  emxInit_real_T(&dv2, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&d_x, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&b_r, 2, &oe_emlrtRTEI, true);
  emxInit_real_T(&b_lin, 2, &ne_emlrtRTEI, true);
  emxInit_real_T(&dv3, 2, &je_emlrtRTEI, true);
  emxInit_boolean_T(&ww, 1, &s_emlrtRTEI, true);
  emxInit_real_T(&e_x, 1, &t_emlrtRTEI, true);
  emxInit_real_T(&dv4, 1, &je_emlrtRTEI, true);
  emxInit_boolean_T(&b_ww, 1, &s_emlrtRTEI, true);
  emxInit_real_T(&f_x, 1, &t_emlrtRTEI, true);
  emxInit_real_T(&dv5, 1, &je_emlrtRTEI, true);
  emxInit_boolean_T(&c_ww, 1, &s_emlrtRTEI, true);
  emxInit_boolean_T(&bv, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&g_x, 1, &t_emlrtRTEI, true);
  emxInit_real_T(&dv6, 1, &je_emlrtRTEI, true);
  emxInit_boolean_T(&d_ww, 1, &s_emlrtRTEI, true);
  emxInit_real_T(&f_y, 2, &pe_emlrtRTEI, true);
  emxInit_real_T(&g_y, 2, &qe_emlrtRTEI, true);
  emxInit_real_T(&h_x, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&dv7, 2, &je_emlrtRTEI, true);
  emxInit_boolean_T(&e_ww, 1, &s_emlrtRTEI, true);
  emxInit_boolean_T(&bv1, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&i_x, 1, &t_emlrtRTEI, true);
  emxInit_real_T(&dv8, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&xx, 2, &eb_emlrtRTEI, true);
  emxInit_real_T(&A, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&b_A, 2, &fb_emlrtRTEI, true);
  emxInit_boolean_T(&bv2, 1, &je_emlrtRTEI, true);
  emxInit_creal_T(&V, 2, &je_emlrtRTEI, true);
  emxInit_creal_T(&D, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&d, 1, &re_emlrtRTEI, true);
  emxInit_real_T(&v, 2, &kb_emlrtRTEI, true);
  emxInit_boolean_T(&bv3, 2, &ub_emlrtRTEI, true);
  emxInit_int8_T(&iv19, 1, &ub_emlrtRTEI, true);
  emxInit_real_T(&topcs, 2, &ic_emlrtRTEI, true);
  emxInit_real_T(&tau, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&b_V, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&xxx, 2, &nc_emlrtRTEI, true);
  emxInit_real_T(&scale, 1, &se_emlrtRTEI, true);
  emxInit_real_T(&wr, 2, &te_emlrtRTEI, true);
  emxInit_real_T(&b_tau, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&U, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&wi, 2, &ue_emlrtRTEI, true);
  emxInit_boolean_T(&f_ww, 1, &s_emlrtRTEI, true);
  emxInit_real_T(&c_A, 2, &fb_emlrtRTEI, true);
  emxInit_creal_T(&dt, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&h_y, 2, &pe_emlrtRTEI, true);
  emxInit_real_T(&wreal, 1, &ve_emlrtRTEI, true);
  emxInit_real_T(&X, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&b_wr, 2, &te_emlrtRTEI, true);
  emxInit_real_T(&wimag, 1, &we_emlrtRTEI, true);
  emxInit_real_T(&d_A, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&b_wi, 2, &ue_emlrtRTEI, true);
  emxInit_real_T(&i_y, 2, &qe_emlrtRTEI, true);
  emxInit_real_T(&vright, 2, &xe_emlrtRTEI, true);
  emxInit_real_T(&j_x, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&dv13, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&e_A, 2, &je_emlrtRTEI, true);
  emxInit_boolean_T(&bv4, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&Y, 1, &ye_emlrtRTEI, true);
  emxInit_real_T(&f_A, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&B, 1, &sc_emlrtRTEI, true);
  emxInit_int32_T(&ipiv, 2, &je_emlrtRTEI, true);
  emxInit_int32_T(&jpvt, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&b_xx, 2, &eb_emlrtRTEI, true);
  emxInit_real_T(&g_A, 2, &je_emlrtRTEI, true);
  emxInit_int32_T(&ipiv_t, 1, &af_emlrtRTEI, true);
  emxInit_real_T(&h_A, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&c_tau, 1, &je_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &xc_emlrtRTEI, true);
  emxInit_creal_T(&c_V, 2, &je_emlrtRTEI, true);
  emxInit_creal_T(&b_D, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&b_d, 1, &re_emlrtRTEI, true);
  emxInit_real_T(&b_v, 2, &kb_emlrtRTEI, true);
  emxInit_boolean_T(&bv5, 2, &ub_emlrtRTEI, true);
  emxInit_int8_T(&iv26, 1, &ub_emlrtRTEI, true);
  emxInit_boolean_T(&g_ww, 1, &s_emlrtRTEI, true);
  emxInit_real_T(&j_y, 2, &pe_emlrtRTEI, true);
  emxInit_real_T(&b_topcs, 2, &ic_emlrtRTEI, true);
  emxInit_real_T(&d_tau, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&d_V, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&k_y, 2, &qe_emlrtRTEI, true);
  emxInit_real_T(&k_x, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&l_x, 2, &bf_emlrtRTEI, true);
  emxInit_real_T(&b_xxx, 2, &nc_emlrtRTEI, true);
  emxInit_real_T(&b_scale, 1, &se_emlrtRTEI, true);
  emxInit_real_T(&c_wr, 2, &te_emlrtRTEI, true);
  emxInit_real_T(&e_tau, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&b_U, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&c_wi, 2, &ue_emlrtRTEI, true);
  emxInit_real_T(&i_A, 2, &fb_emlrtRTEI, true);
  emxInit_creal_T(&b_dt, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&l_y, 2, &bf_emlrtRTEI, true);
  emxInit_real_T(&b_wreal, 1, &ve_emlrtRTEI, true);
  emxInit_real_T(&b_X, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&d_wr, 2, &te_emlrtRTEI, true);
  emxInit_real_T(&b_B, 1, &dd_emlrtRTEI, true);
  emxInit_real_T(&b_wimag, 1, &we_emlrtRTEI, true);
  emxInit_real_T(&j_A, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&d_wi, 2, &ue_emlrtRTEI, true);
  emxInit_real_T(&b_vright, 2, &xe_emlrtRTEI, true);
  emxInit_real_T(&k_A, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&b_Y, 1, &ye_emlrtRTEI, true);
  emxInit_real_T(&l_A, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&c_B, 1, &sc_emlrtRTEI, true);
  emxInit_int32_T(&b_ipiv, 2, &je_emlrtRTEI, true);
  emxInit_int32_T(&b_jpvt, 2, &je_emlrtRTEI, true);
  emxInit_int32_T(&b_ipiv_t, 1, &af_emlrtRTEI, true);
  emxInit_real_T(&f_tau, 1, &je_emlrtRTEI, true);
  emxInit_ptrdiff_t(&b_jpvt_t, 1, &xc_emlrtRTEI, true);
  emxInit_boolean_T(&h_ww, 1, &s_emlrtRTEI, true);
  emxInit_real_T(&m_y, 2, &pe_emlrtRTEI, true);
  emxInit_real_T(&n_y, 2, &qe_emlrtRTEI, true);
  emxInit_real_T(&m_x, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&o_y, 2, &bf_emlrtRTEI, true);
  emxInit_real_T(&d_B, 1, &dd_emlrtRTEI, true);
  emxInit_real_T(&yy, 1, &hd_emlrtRTEI, true);
  emxInit_real_T(&c_d, 1, &id_emlrtRTEI, true);
  emxInit_boolean_T(&i_ww, 1, &jd_emlrtRTEI, true);
  emxInit_real_T(&dv20, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&absdiff, 1, &cf_emlrtRTEI, true);
  emxInit_boolean_T(&bv6, 1, &ld_emlrtRTEI, true);
  emxInit_boolean_T(&b_a, 1, &od_emlrtRTEI, true);
  emxInit_real_T(&d_d, 1, &id_emlrtRTEI, true);
  emxInit_real_T(&b_absdiff, 1, &cf_emlrtRTEI, true);
  emxInit_int8_T(&c_a, 2, &pd_emlrtRTEI, true);
  emxInit_real_T(&p_y, 2, &df_emlrtRTEI, true);
  emxInit_real_T(&q_y, 2, &ef_emlrtRTEI, true);
  emxInit_real_T(&r_y, 2, &ff_emlrtRTEI, true);
  emxInit_real_T(&b, 1, &td_emlrtRTEI, true);
  emxInit_real_T(&s_y, 2, &gf_emlrtRTEI, true);
  emxInit_int8_T(&d_a, 2, &rd_emlrtRTEI, true);
  emxInit_boolean_T(&bv8, 1, &be_emlrtRTEI, true);
  emxInit_int32_T(&iv37, 1, &je_emlrtRTEI, true);
  emxInit_boolean_T(&bv9, 1, &de_emlrtRTEI, true);
  emxInit_int32_T(&iv38, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&e_d, 1, &ee_emlrtRTEI, true);
  emxInit_boolean_T(&j_ww, 1, &fe_emlrtRTEI, true);
  emxInit_real_T(&dv23, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&c_absdiff, 1, &cf_emlrtRTEI, true);
  emxInit_boolean_T(&bv10, 1, &ge_emlrtRTEI, true);
  emxInit_boolean_T(&e_a, 1, &od_emlrtRTEI, true);
  emxInit_real_T(&c_r, 2, &fd_emlrtRTEI, true);
  emxInit_real_T(&d_r, 2, &gd_emlrtRTEI, true);
  emxInit_real_T(&n_x, 1, &xd_emlrtRTEI, true);
  emxInit_real_T(&b_trend, 1, &yd_emlrtRTEI, true);
  emxInit_real_T(&f_a, 1, &ae_emlrtRTEI, true);
  emxInit_boolean_T(&c_w, 1, &od_emlrtRTEI, true);
  emxInit_boolean_T(&d_w, 1, &od_emlrtRTEI, true);
  for (int32_T ch{0}; ch < b_i; ch++) {
    int32_T o_x;
    int32_T x_dim0;

    // 'ecu_detrend:45' [x(:,ch),w(:,ch)] = ec_detrendCompute(x(:,ch),order,thresh,niter,wsize,w(:,ch));
    i = dv1->size[0];
    dv1->size[0] = x->size[0];
    emxEnsureCapacity_real_T(dv1, i, &e_emlrtRTEI);
    if (!dv1_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real_T(dv1, &gpu_dv1);
    }

    o_x = x->size[0] - 1;
    x_dim0 = x->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
      }

      x_dirtyOnCpu = false;
      if (dv1_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
      }

      ecu_detrend_kernel3<<<grid, block>>>(ch, gpu_x, o_x, x_dim0, gpu_dv1);
      dv1_dirtyOnCpu = false;
      dv1_dirtyOnGpu = true;
    }

    i = b_w->size[0];
    b_w->size[0] = w->size[0];
    emxEnsureCapacity_boolean_T(b_w, i, &f_emlrtRTEI);
    if (!b_w_dirtyOnCpu) {
      gpuEmxEnsureCapacity_boolean_T(b_w, &b_gpu_w);
    }

    x_dim0 = w->size[0] - 1;
    o_x = w->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0 + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (w_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_boolean_T(&gpu_w, w);
      }

      w_dirtyOnCpu = false;
      if (b_w_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
      }

      ecu_detrend_kernel4<<<grid, block>>>(ch, gpu_w, x_dim0, o_x, b_gpu_w);
      b_w_dirtyOnCpu = false;
      b_w_dirtyOnGpu = true;
    }

    // ,doubleIn,singleOut)
    //  Robust detrending - main computational functions
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
    //  Input validation
    // 'ec_detrendCompute:20' x {mustBeFloat}
    //  Raw data
    // 'ec_detrendCompute:21' order {isnumeric} = 10
    //  Polynomial order (default=10)
    // 'ec_detrendCompute:22' thresh {isnumeric} = 3
    //  Outlier threshold (default=3)
    // 'ec_detrendCompute:23' niter {isnumeric} = 3
    //  Number of iterations (default=3)
    // 'ec_detrendCompute:24' wsize {isnumeric} = 0
    //  Overlapping window size (default=[])
    // 'ec_detrendCompute:25' w logical = true(size(x))
    //  Pre-calculated weights
    // 'ec_detrendCompute:26' basis {istext} = 'polynomials'
    //  Basis function
    // doubleIn logical = true       % Compute in double-precision
    // singleOut logical = false     % Output in single-precision
    //  if isa(x,'single') && doubleIn
    //      x=x); order=order); thresh=thresh); niter=niter); wsize=wsize);
    //  elseif ~doubleIn
    //      x=single(x); order=single(order); thresh=single(thresh); niter=single(niter); wsize=single(wsize);
    //  end
    //  Call computational functions
    // 'ec_detrendCompute:37' if ~isany(wsize)
    //  Return if empty
    // 'isany:3' if isempty(x)
    //  Convert to cell
    // 'isany:6' if istable(x)
    //  Find non-empty, non-zero numeric vals, or text~=""
    // 'isany:9' if isnumeric(x) || islogical(x)
    // 'isany:10' if any(x)
    if (!c_y) {
      int32_T e_r[2];
      int32_T i8;
      int32_T nx;
      uint32_T dims_idx_0;

      //  Standard detrending (trend fit to entire data)
      // 'ec_detrendCompute:39' [x,w,r] = ec_detrend_lfn(x,order,thresh,niter,w,basis);
      //  if ~islogical(w); w = logical(w); end
      //  if singleOut && ~isa(x,'single'); x=single(x); r=single(r); end
      // %%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      //  Standard detrending (trend fit to entire data) %%%%%%%%%%%%%%%%%%%%%%%%%
      // [y,w,r]=nt_detrend(x,order,w,basis,thresh,niter) - robustly remove trend
      //
      //   y: detrended data
      //   w: updated weights
      //   r: basis matrix used
      //
      //   x: raw data
      //   order: order of polynomial or number of sin/cosine pairs
      //   w: weights
      //   basis: 'polynomials' [default] or 'sinusoids', or user-provided matrix
      //   thresh: threshold for outliers [default: 3 sd]
      //   niter: number of iterations [default: 3]
      //
      //  Noise tools
      //  See nt_regw().
      //
      //  The data are fit to the basis using weighted least squares. The weight is
      //  updated by setting samples for which the residual is greater than 'thresh'
      //  times its std to zero, and the fit is repeated at most 'niter'-1 times.
      //
      //  The choice of order (and basis) determines what complexity of the trend
      //  that can be removed.  It may be useful to first detrend with a low order
      //  to avoid fitting outliers, and then increase the order.
      //
      //  Examples:
      //  Fit linear trend, ignoring samples > 3*sd from it, and remove:
      //    y=nt_detrend(x,1);
      //  Fit/remove polynomial order=5 with initial weighting w, threshold = 4*sd:
      //    y=nt_detrend(x,5,w,[],4);
      //  Fit/remove linear then 3rd order polynomial:
      //    [y,w]=nt_detrend(x,1);
      //    [yy,ww]=nt_detrend(y,3);
      //  Regressors
      // 'ec_detrendCompute:90' dims = size(x);
      i = x->size[0];
      dims_idx_0 = static_cast<uint32_T>(i);

      //  if isnumeric(basis)
      //      r = basis;
      //  else
      // 'ec_detrendCompute:94' switch basis
      // 'ec_detrendCompute:95' case 'polynomials'
      // 'ec_detrendCompute:96' r = coder.nullcopy(x(:,1:order));
      npages = r->size[0] * r->size[1];
      r->size[0] = i;
      r->size[1] = !(order < 1.0);
      emxEnsureCapacity_real_T(r, npages, &l_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(r, &gpu_r);

      // 'ec_detrendCompute:96' r(:)=0;
      for (i = 0; i < 2; i++) {
        e_r[i] = r->size[i];
      }

      i = r->size[0] * r->size[1];
      r->size[0] = e_r[0];
      r->size[1] = e_r[1];
      emxEnsureCapacity_real_T(r, i, &m_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(r, &gpu_r);
      i = e_r[0] * e_r[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecu_detrend_kernel138<<<grid, block>>>(i, gpu_r);
        r_dirtyOnGpu = true;
      }

      //  r=zeros(dims(1),numel(order));
      // 'ec_detrendCompute:97' lin = linspace(-1,1,dims(1));
      i = lin->size[0] * lin->size[1];
      lin->size[0] = 1;
      lin->size[1] = static_cast<int32_T>(dims_idx_0);
      emxEnsureCapacity_real_T(lin, i, &n_emlrtRTEI);
      if (!lin_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(lin, &gpu_lin);
      }

      if (static_cast<int32_T>(dims_idx_0) >= 1) {
        if (lin_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(lin, &gpu_lin);
        }

        lin->data[static_cast<int32_T>(dims_idx_0) - 1] = 1.0;
        lin_dirtyOnGpu = false;
        lin_dirtyOnCpu = true;
        if (lin->size[1] >= 2) {
          lin->data[0] = -1.0;
          if (lin->size[1] >= 3) {
            d2scaled = 1.0 / (static_cast<real_T>(lin->size[1]) - 1.0);
            npages = lin->size[1] - 3;
            x_dim0 = lin->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, lin);
              ecu_detrend_kernel139<<<grid, block>>>(npages, x_dim0,
                gpu_d2scaled, gpu_lin);
              lin_dirtyOnCpu = false;
              lin_dirtyOnGpu = true;
            }

            if ((lin->size[1] & 1) == 1) {
              x_dim0 = lin->size[1];
              if (lin_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, lin);
              }

              ecu_detrend_kernel140<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (x_dim0, gpu_lin);
              lin_dirtyOnCpu = false;
              lin_dirtyOnGpu = true;
            }
          }
        }
      }

      // 'ec_detrendCompute:98' for k=1:order
      npages = static_cast<int32_T>(order);
      for (na = 0; na < npages; na++) {
        // 'ec_detrendCompute:99' r(:,k) = lin.^k;
        i = dv2->size[0] * dv2->size[1];
        dv2->size[0] = 1;
        dv2->size[1] = lin->size[1];
        emxEnsureCapacity_real_T(dv2, i, &o_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(dv2, &gpu_dv2);
        nx = lin->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (lin_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, lin);
          }

          lin_dirtyOnCpu = false;
          ecu_detrend_kernel141<<<grid, block>>>(gpu_lin, nx, gpu_dv2);
        }

        ntilecols = r->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((ntilecols - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ecu_detrend_kernel142<<<grid, block>>>(gpu_dv2, ntilecols, gpu_r);
          r_dirtyOnGpu = true;
        }
      }

      //  Remove trends
      //  The tricky bit is to ensure that weighted means are removed before
      //  calculating the regression (see nt_regw).
      // 'ec_detrendCompute:116' y = coder.nullcopy(x);
      // 'ec_detrendCompute:116' y(:)=0;
      i = d_x->size[0];
      d_x->size[0] = x->size[0];
      emxEnsureCapacity_real_T(d_x, i, &p_emlrtRTEI);
      if (!c_x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(d_x, &c_gpu_x);
      }

      o_x = x->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (c_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, d_x);
        }

        ecu_detrend_kernel143<<<grid, block>>>(o_x, c_gpu_x);
        c_x_dirtyOnCpu = false;
        c_x_dirtyOnGpu = true;
      }

      // zeros(size(x));
      // 'ec_detrendCompute:117' for ii = 1:niter
      i8 = static_cast<int32_T>(niter);
      if (static_cast<int32_T>(niter) - 1 >= 0) {
        c_outsize[0] = static_cast<int32_T>(dims_idx_0);
      }

      for (int32_T ii{0}; ii < i8; ii++) {
        real_T mn;

        //  weighted regression on basis
        // 'ec_detrendCompute:119' y = regw_lfn(x,r,w);
        //  Weighted Regression %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // [b,z]=nt_regw(y,x,w) - weighted regression
        //
        //   b: regression matrix (apply to x to approximate y)
        //   z: regression (x*b)
        //
        //   y: data
        //   x: regressor
        //   w: weight to apply to y
        //
        //   w is either a matrix of same size as y, or a column vector to be applied
        //   to each column of y
        //  Sanity checks
        // 'ec_detrendCompute:226' thr_PCA = 1e-7;
        //  discard dimensions of x with eigenvalue lower than this
        // 'ec_detrendCompute:227' m = size(y,1);
        // 'ec_detrendCompute:228' x = unfold_lfn(x);
        //  Unfold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // y=nt_fold(x) - unfold 3D to 2D
        //
        //   y: 2D matrix of concatentated data (time * channel)
        //
        //   x: 3D matrix of (time * channel * trial)
        //
        //  NoiseTools
        // 'ec_detrendCompute:372' if ~isempty(x) && numel(size(x))>=3
        //  Depreciated
        //  % Vector Add %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //  function x = vecadd_lfn(x,v)
        //  %y=nt_vecadd(x,v) - add vector to all rows or columns of matrix
        //  %
        //  % See vecmult, bsxfun
        //  %
        //  % NoiseTools
        //
        //  [m,~,~]=size(x);
        //  x=unfold_lfn(x);
        //  v=unfold_lfn(v);
        //
        //  [mm,nn]=size(x);
        //  if numel(v)==1;
        //      x=x+v;
        //  elseif size(v,1)==1
        //      if size(v,2)~=nn; error('V should have same number of columns as X'); end
        //      if bsxfun_exists;
        //          x=bsxfun(@plus,x,v);
        //          %        vecop_core(x, v, 2, 1);  % 1 is the opcode of addition in vecop_core
        //      else
        //          x=x + repmat(v,mm,1);
        //      end
        //  elseif size(v,2)==1
        //      if size(v,1)~=mm; error('V should have same number of rows as X'); end
        //      if bsxfun_exists;
        //          x=bsxfun(@plus,x,v);
        //          %       y=vecop_core(x, v, 1, 1);  % 1 is the opcode of addition in vecop_core
        //      else
        //          x=x + repmat(v,1,nn);
        //      end
        //  end
        //  x=nt_fold(x,m);
        //
        //  % Vector multiplication %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //  function x = vecmult_lfn(x,v)
        //  %y=nt_vecmult(x,v) - multiply all rows or columns of matrix by vector
        //  %
        //  % See vecadd, bsxfun
        //  %
        //  % NoiseTools
        //
        //  % check once and for all to save time
        //  persistent bsxfun_exists;
        //  if isempty(bsxfun_exists); bsxfun_exists=(exist('bsxfun')==5); end
        //
        //  [m,n,o]=size(x);
        //  x=nt_unfold(x);
        //  v=nt_unfold(v);
        //
        //  [mm,nn]=size(x);
        //  [mv,nv]=size(v);
        //  if mv==mm
        //      % same number of rows, v should be column vector (or same size as x)
        //      if nv==nn
        //          x=x.*v;
        //      elseif nv==1
        //          if bsxfun_exists;
        //              x=bsxfun(@times,x,v);
        //              %y=vecop_core(x, v, 1, 2);  % 2 is the opcode of multiplication in vecop_core
        //          else
        //              x=x .* repmat(v,1,nn);
        //          end
        //      else
        //          error('V should be row vector');
        //      end
        //
        //  elseif nv==nn
        //      % same number of columns, v should be row vector (or same size as x)
        //      if mv==mm
        //          x=x.*v;
        //      elseif mv==1
        //          if bsxfun_exists;
        //              x=bsxfun(@times,x,v);
        //              %y=vecop_core(x, v, 2, 2);  % 2 is the opcode of multiplication in vecop_core
        //          else
        //              x=x .* repmat(v,mm,1);
        //          end
        //      else
        //          error('V should be column vector');
        //      end
        //
        //  else
        //      error('V and X should have same number of rows or columns');
        //  end
        //  x=nt_fold(x,m);
        // 'ec_detrendCompute:229' y = unfold_lfn(y);
        //  Unfold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // y=nt_fold(x) - unfold 3D to 2D
        //
        //   y: 2D matrix of concatentated data (time * channel)
        //
        //   x: 3D matrix of (time * channel * trial)
        //
        //  NoiseTools
        // 'ec_detrendCompute:372' if ~isempty(x) && numel(size(x))>=3
        //  Depreciated
        //  % Vector Add %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //  function x = vecadd_lfn(x,v)
        //  %y=nt_vecadd(x,v) - add vector to all rows or columns of matrix
        //  %
        //  % See vecmult, bsxfun
        //  %
        //  % NoiseTools
        //
        //  [m,~,~]=size(x);
        //  x=unfold_lfn(x);
        //  v=unfold_lfn(v);
        //
        //  [mm,nn]=size(x);
        //  if numel(v)==1;
        //      x=x+v;
        //  elseif size(v,1)==1
        //      if size(v,2)~=nn; error('V should have same number of columns as X'); end
        //      if bsxfun_exists;
        //          x=bsxfun(@plus,x,v);
        //          %        vecop_core(x, v, 2, 1);  % 1 is the opcode of addition in vecop_core
        //      else
        //          x=x + repmat(v,mm,1);
        //      end
        //  elseif size(v,2)==1
        //      if size(v,1)~=mm; error('V should have same number of rows as X'); end
        //      if bsxfun_exists;
        //          x=bsxfun(@plus,x,v);
        //          %       y=vecop_core(x, v, 1, 1);  % 1 is the opcode of addition in vecop_core
        //      else
        //          x=x + repmat(v,1,nn);
        //      end
        //  end
        //  x=nt_fold(x,m);
        //
        //  % Vector multiplication %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //  function x = vecmult_lfn(x,v)
        //  %y=nt_vecmult(x,v) - multiply all rows or columns of matrix by vector
        //  %
        //  % See vecadd, bsxfun
        //  %
        //  % NoiseTools
        //
        //  % check once and for all to save time
        //  persistent bsxfun_exists;
        //  if isempty(bsxfun_exists); bsxfun_exists=(exist('bsxfun')==5); end
        //
        //  [m,n,o]=size(x);
        //  x=nt_unfold(x);
        //  v=nt_unfold(v);
        //
        //  [mm,nn]=size(x);
        //  [mv,nv]=size(v);
        //  if mv==mm
        //      % same number of rows, v should be column vector (or same size as x)
        //      if nv==nn
        //          x=x.*v;
        //      elseif nv==1
        //          if bsxfun_exists;
        //              x=bsxfun(@times,x,v);
        //              %y=vecop_core(x, v, 1, 2);  % 2 is the opcode of multiplication in vecop_core
        //          else
        //              x=x .* repmat(v,1,nn);
        //          end
        //      else
        //          error('V should be row vector');
        //      end
        //
        //  elseif nv==nn
        //      % same number of columns, v should be row vector (or same size as x)
        //      if mv==mm
        //          x=x.*v;
        //      elseif mv==1
        //          if bsxfun_exists;
        //              x=bsxfun(@times,x,v);
        //              %y=vecop_core(x, v, 2, 2);  % 2 is the opcode of multiplication in vecop_core
        //          else
        //              x=x .* repmat(v,mm,1);
        //          end
        //      else
        //          error('V should be column vector');
        //      end
        //
        //  else
        //      error('V and X should have same number of rows or columns');
        //  end
        //  x=nt_fold(x,m);
        // 'ec_detrendCompute:230' if size(x,1) ~= size(y,1)
        if (r->size[0] != x->size[0]) {
          // 'ec_detrendCompute:231' error("ec_detrendCompute/regw_lfn: x & y are unequal sizes");
          t_y = nullptr;
          m2 = nullptr;
          emlrtAssign(&t_y, emlrtCreateClassInstance2022a(emlrtRootTLSGlobal,
            "coder.internal.string"));
          m2 = nullptr;
          u_y = nullptr;
          m1 = emlrtCreateCharArray(2, &iv1[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 51, m1, &b_u[0]);
          emlrtAssign(&u_y, m1);
          emlrtAssign(&m2, u_y);
          propValues[0] = m2;
          emlrtSetAllProperties(emlrtRootTLSGlobal, &t_y, 0, 1, (const char_T **)
                                &b_propNames[0], (const char_T **)
                                &b_propClasses[0], &propValues[0]);
          emlrtAssign(&t_y, emlrtConvertInstanceToRedirectSource
                      (emlrtRootTLSGlobal, t_y, 0, "coder.internal.string"));
          b_error(t_y, &emlrtMCI);
        }

        //  save weighted mean
        // 'ec_detrendCompute:235' mn = y - demean_lfn(y,w);
        i = ww->size[0];
        ww->size[0] = b_w->size[0];
        emxEnsureCapacity_boolean_T(ww, i, &r_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(ww, &gpu_ww);
        x_dim0 = b_w->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0 +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_w_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
          }

          b_w_dirtyOnCpu = false;
          ecu_detrend_kernel144<<<grid, block>>>(b_gpu_w, x_dim0, gpu_ww);
          ww_dirtyOnGpu = true;
        }

        //  if isempty(w)
        //      % simple regression
        //      xx = demean_lfn(x);
        //      yy = demean_lfn(y);
        //      [V,D] = eig(xx'*xx);
        //      V = real(V);
        //      D = real(D);
        //      topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
        //      xxx = xx*topcs;
        //      b = ((yy'*xxx) / (xxx'*xxx))';
        //      z = demean_lfn(x,w)*topcs*b;
        //      z = z + mn;
        //  else
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //  [y,mn]=nt_demean(x,w) - remove weighted mean over cols
        //
        //  If w is a vector with fewer samples than size(x,1), it is interpreted as
        //  a vector of indices to be set to 1, the others being set to 0.
        // 'ec_detrendCompute:297' [m,n] = size(x);
        // 'ec_detrendCompute:299' if ~isempty(w) && numel(w)<m
        i = b_w->size[0];
        if ((b_w->size[0] != 0) && (b_w->size[0] < x->size[0])) {
          // 'ec_detrendCompute:300' w=w(:);
          //  interpret w as array of indices to set to 1
          // 'ec_detrendCompute:302' if min(w)<1 || max(w)>m
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          b_y = b_w->data[0];
          for (o_x = 0; o_x <= i - 2; o_x++) {
            if (static_cast<int32_T>(b_y) > static_cast<int32_T>(b_w->data[o_x +
                 1])) {
              b_y = b_w->data[o_x + 1];
            }
          }

          if (!b_y) {
            // 'ec_detrendCompute:303' error('w interpreted as indices but values are out of range');
            v_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv2[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 52, m1, &varargin_1[0]);
            emlrtAssign(&v_y, m1);
            b_error(v_y, &emlrtMCI);
          }

          // 'ec_detrendCompute:305' ww = false(m,1);
          i = ww->size[0];
          ww->size[0] = x->size[0];
          emxEnsureCapacity_boolean_T(ww, i, &s_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(ww, &gpu_ww);
          o_x = x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecu_detrend_kernel145<<<grid, block>>>(o_x, gpu_ww);
            ww_dirtyOnGpu = true;
          }

          // 'ec_detrendCompute:306' ww(w) = true;
          na = b_w->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
            ecu_detrend_kernel146<<<grid, block>>>(b_gpu_w, gpu_na, gpu_ww);
            ww_dirtyOnGpu = true;
          }

          // 'ec_detrendCompute:307' w = ww;
        }

        //  if size(w,3)~=p
        //      if size(w,3)==1 && p~=1
        //          w = repmat(w,[1,1,p]);
        //      else
        //          error('W should have same npages as X, or else 1');
        //      end
        //  end
        // if p>1; x = unfold_lfn(x); end
        // 'ec_detrendCompute:319' if isempty(w)
        if (ww->size[0] == 0) {
          // 'ec_detrendCompute:320' mn = mean(x,1);
          i2 = x->size[0];
          if (i2 == 0) {
            d2scaled = 0.0;
          } else {
            if (x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
            }

            x_dirtyOnGpu = false;
            d2scaled = x->data[x->size[0] * ch];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              d2scaled += x->data[(o_x + x->size[0] * ch) + 1];
            }
          }

          mn = d2scaled / static_cast<real_T>(x->size[0]);

          // 'ec_detrendCompute:321' x = x - mn;
          i = dv4->size[0];
          dv4->size[0] = dv1->size[0];
          emxEnsureCapacity_real_T(dv4, i, &u_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(dv4, &gpu_dv4);
          o_x = dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (dv1_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
            }

            dv1_dirtyOnCpu = false;
            ecu_detrend_kernel149<<<grid, block>>>(mn, gpu_dv1, o_x, gpu_dv4);
            dv4_dirtyOnGpu = true;
          }

          // vecadd_lfn(x,-mn);
        } else {
          // 'ec_detrendCompute:322' else
          // if p>1; w = unfold_lfn(w); end
          // 'ec_detrendCompute:324' if size(w,1)~=size(x,1)
          if (ww->size[0] != x->size[0]) {
            // 'ec_detrendCompute:324' ;
            // 'ec_detrendCompute:324' error('X and W should have same nrows');
            w_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv3[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 30, m1, &b_varargin_1[0]);
            emlrtAssign(&w_y, m1);
            b_error(w_y, &emlrtMCI);
          }

          // 'ec_detrendCompute:325' if size(w,2)==1
          // 'ec_detrendCompute:326' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if (dv1->size[0] == ww->size[0]) {
            i = e_x->size[0];
            e_x->size[0] = dv1->size[0];
            emxEnsureCapacity_real_T(e_x, i, &t_emlrtRTEI);
            if (!d_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(e_x, &d_gpu_x);
            }

            o_x = dv1->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (dv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
              }

              dv1_dirtyOnCpu = false;
              if (d_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_x, e_x);
              }

              ecu_detrend_kernel147<<<grid, block>>>(gpu_ww, gpu_dv1, o_x,
                d_gpu_x);
              d_x_dirtyOnCpu = false;
              d_x_dirtyOnGpu = true;
            }
          } else {
            if (d_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_x, &d_gpu_x);
            }

            if (dv1_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
            }

            dv1_dirtyOnGpu = false;
            if (ww_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(ww, &gpu_ww);
            }

            ww_dirtyOnGpu = false;
            d_binary_expand_op(e_x, dv1, ww);
            d_x_dirtyOnGpu = false;
            d_x_dirtyOnCpu = true;
          }

          i2 = e_x->size[0];
          if (e_x->size[0] == 0) {
            d2scaled = 0.0;
          } else {
            if (d_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_x, &d_gpu_x);
            }

            d_x_dirtyOnGpu = false;
            d2scaled = e_x->data[0];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              d2scaled += e_x->data[o_x + 1];
            }
          }

          i2 = ww->size[0];
          if (ww_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(ww, &gpu_ww);
          }

          ww_dirtyOnGpu = false;
          npages = ww->data[0];
          for (o_x = 0; o_x <= i2 - 2; o_x++) {
            npages += ww->data[o_x + 1];
          }

          mn = d2scaled / (static_cast<real_T>(npages) + 2.2204460492503131E-16);

          // sum(vecmult_lfn(x),w),1) ./ (sum(w,1)+eps);
          // 'ec_detrendCompute:332' x = x - mn;
          i = dv4->size[0];
          dv4->size[0] = dv1->size[0];
          emxEnsureCapacity_real_T(dv4, i, &u_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(dv4, &gpu_dv4);
          o_x = dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (dv1_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
            }

            dv1_dirtyOnCpu = false;
            ecu_detrend_kernel148<<<grid, block>>>(mn, gpu_dv1, o_x, gpu_dv4);
            dv4_dirtyOnGpu = true;
          }

          // x = vecadd_lfn(x,-mn);
        }

        //  Fit weighted regression
        // 'ec_detrendCompute:238' if size(w,1)~=size(x,1)
        if (b_w->size[0] != r->size[0]) {
          // 'ec_detrendCompute:238' ;
          // 'ec_detrendCompute:238' error('!');
          x_y = nullptr;
          m1 = emlrtCreateString1R2022a(emlrtRootTLSGlobal, '!');
          emlrtAssign(&x_y, m1);
          b_error(x_y, &emlrtMCI);
        }

        // 'ec_detrendCompute:239' if size(w,2)==1
        //  same weight for all channels
        // 'ec_detrendCompute:241' if sum(w(:))==0
        i2 = b_w->size[0];
        if (b_w->size[0] == 0) {
          npages = 0;
        } else {
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          npages = b_w->data[0];
          for (o_x = 0; o_x <= i2 - 2; o_x++) {
            npages += b_w->data[o_x + 1];
          }
        }

        if (npages == 0) {
          // 'ec_detrendCompute:242' error('weights all zero');
          y_y = nullptr;
          m1 = emlrtCreateCharArray(2, &iv4[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 16, m1, &c_varargin_1[0]);
          emlrtAssign(&y_y, m1);
          b_error(y_y, &emlrtMCI);
        }

        // 'ec_detrendCompute:244' yy = demean_lfn(y,w).*repmat(w,1,size(y,2));
        i = b_ww->size[0];
        b_ww->size[0] = b_w->size[0];
        emxEnsureCapacity_boolean_T(b_ww, i, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(b_ww, &b_gpu_ww);
        x_dim0 = b_w->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0 +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_w_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
          }

          b_w_dirtyOnCpu = false;
          ecu_detrend_kernel150<<<grid, block>>>(b_gpu_w, x_dim0, b_gpu_ww);
          b_ww_dirtyOnGpu = true;
        }

        //  if isempty(w)
        //      % simple regression
        //      xx = demean_lfn(x);
        //      yy = demean_lfn(y);
        //      [V,D] = eig(xx'*xx);
        //      V = real(V);
        //      D = real(D);
        //      topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
        //      xxx = xx*topcs;
        //      b = ((yy'*xxx) / (xxx'*xxx))';
        //      z = demean_lfn(x,w)*topcs*b;
        //      z = z + mn;
        //  else
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //  [y,mn]=nt_demean(x,w) - remove weighted mean over cols
        //
        //  If w is a vector with fewer samples than size(x,1), it is interpreted as
        //  a vector of indices to be set to 1, the others being set to 0.
        // 'ec_detrendCompute:297' [m,n] = size(x);
        // 'ec_detrendCompute:299' if ~isempty(w) && numel(w)<m
        i = b_w->size[0];
        if ((b_w->size[0] != 0) && (b_w->size[0] < x->size[0])) {
          // 'ec_detrendCompute:300' w=w(:);
          //  interpret w as array of indices to set to 1
          // 'ec_detrendCompute:302' if min(w)<1 || max(w)>m
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          b_y = b_w->data[0];
          for (o_x = 0; o_x <= i - 2; o_x++) {
            if (static_cast<int32_T>(b_y) > static_cast<int32_T>(b_w->data[o_x +
                 1])) {
              b_y = b_w->data[o_x + 1];
            }
          }

          if (!b_y) {
            // 'ec_detrendCompute:303' error('w interpreted as indices but values are out of range');
            cb_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv6[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 52, m1, &varargin_1[0]);
            emlrtAssign(&cb_y, m1);
            b_error(cb_y, &emlrtMCI);
          }

          // 'ec_detrendCompute:305' ww = false(m,1);
          i = b_ww->size[0];
          b_ww->size[0] = x->size[0];
          emxEnsureCapacity_boolean_T(b_ww, i, &s_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(b_ww, &b_gpu_ww);
          o_x = x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecu_detrend_kernel151<<<grid, block>>>(o_x, b_gpu_ww);
            b_ww_dirtyOnGpu = true;
          }

          // 'ec_detrendCompute:306' ww(w) = true;
          na = b_w->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
            ecu_detrend_kernel152<<<grid, block>>>(b_gpu_w, gpu_na, b_gpu_ww);
            b_ww_dirtyOnGpu = true;
          }

          // 'ec_detrendCompute:307' w = ww;
        }

        //  if size(w,3)~=p
        //      if size(w,3)==1 && p~=1
        //          w = repmat(w,[1,1,p]);
        //      else
        //          error('W should have same npages as X, or else 1');
        //      end
        //  end
        // if p>1; x = unfold_lfn(x); end
        // 'ec_detrendCompute:319' if isempty(w)
        if (b_ww->size[0] == 0) {
          // 'ec_detrendCompute:320' mn = mean(x,1);
          i2 = x->size[0];
          if (i2 == 0) {
            d2scaled = 0.0;
            y_dirtyOnGpu = false;
          } else {
            if (x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
            }

            x_dirtyOnGpu = false;
            d2scaled = x->data[x->size[0] * ch];
            y_dirtyOnGpu = false;
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              d2scaled += x->data[(o_x + x->size[0] * ch) + 1];
            }
          }

          mn = d2scaled / static_cast<real_T>(x->size[0]);

          // 'ec_detrendCompute:321' x = x - mn;
          i = dv5->size[0];
          dv5->size[0] = dv1->size[0];
          emxEnsureCapacity_real_T(dv5, i, &w_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(dv5, &gpu_dv5);
          o_x = dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (dv1_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
            }

            dv1_dirtyOnCpu = false;
            ecu_detrend_kernel155<<<grid, block>>>(mn, gpu_dv1, o_x, gpu_dv5);
            dv5_dirtyOnGpu = true;
          }

          // vecadd_lfn(x,-mn);
        } else {
          // 'ec_detrendCompute:322' else
          // if p>1; w = unfold_lfn(w); end
          // 'ec_detrendCompute:324' if size(w,1)~=size(x,1)
          if (b_ww->size[0] != x->size[0]) {
            // 'ec_detrendCompute:324' ;
            // 'ec_detrendCompute:324' error('X and W should have same nrows');
            eb_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv7[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 30, m1, &b_varargin_1[0]);
            emlrtAssign(&eb_y, m1);
            b_error(eb_y, &emlrtMCI);
          }

          // 'ec_detrendCompute:325' if size(w,2)==1
          // 'ec_detrendCompute:326' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if (dv1->size[0] == b_ww->size[0]) {
            i = f_x->size[0];
            f_x->size[0] = dv1->size[0];
            emxEnsureCapacity_real_T(f_x, i, &t_emlrtRTEI);
            if (!e_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(f_x, &e_gpu_x);
            }

            o_x = dv1->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (dv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
              }

              dv1_dirtyOnCpu = false;
              if (e_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_x, f_x);
              }

              ecu_detrend_kernel153<<<grid, block>>>(b_gpu_ww, gpu_dv1, o_x,
                e_gpu_x);
              e_x_dirtyOnCpu = false;
              e_x_dirtyOnGpu = true;
            }
          } else {
            if (e_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_x, &e_gpu_x);
            }

            if (dv1_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
            }

            dv1_dirtyOnGpu = false;
            if (b_ww_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(b_ww, &b_gpu_ww);
            }

            b_ww_dirtyOnGpu = false;
            d_binary_expand_op(f_x, dv1, b_ww);
            e_x_dirtyOnGpu = false;
            e_x_dirtyOnCpu = true;
          }

          i2 = f_x->size[0];
          if (f_x->size[0] == 0) {
            d2scaled = 0.0;
            y_dirtyOnGpu = false;
          } else {
            if (e_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_x, &e_gpu_x);
            }

            e_x_dirtyOnGpu = false;
            d2scaled = f_x->data[0];
            y_dirtyOnGpu = false;
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              d2scaled += f_x->data[o_x + 1];
            }
          }

          i2 = b_ww->size[0];
          if (b_ww_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(b_ww, &b_gpu_ww);
          }

          b_ww_dirtyOnGpu = false;
          npages = b_ww->data[0];
          for (o_x = 0; o_x <= i2 - 2; o_x++) {
            npages += b_ww->data[o_x + 1];
          }

          mn = d2scaled / (static_cast<real_T>(npages) + 2.2204460492503131E-16);

          // sum(vecmult_lfn(x),w),1) ./ (sum(w,1)+eps);
          // 'ec_detrendCompute:332' x = x - mn;
          i = dv5->size[0];
          dv5->size[0] = dv1->size[0];
          emxEnsureCapacity_real_T(dv5, i, &w_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(dv5, &gpu_dv5);
          o_x = dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (dv1_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
            }

            dv1_dirtyOnCpu = false;
            ecu_detrend_kernel154<<<grid, block>>>(mn, gpu_dv1, o_x, gpu_dv5);
            dv5_dirtyOnGpu = true;
          }

          // x = vecadd_lfn(x,-mn);
        }

        i = bv->size[0];
        bv->size[0] = b_w->size[0];
        emxEnsureCapacity_boolean_T(bv, i, &x_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv, &gpu_bv);
        npages = b_w->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_w_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
          }

          b_w_dirtyOnCpu = false;
          ecu_detrend_kernel156<<<grid, block>>>(b_gpu_w, npages, gpu_bv);
          bv_dirtyOnGpu = true;
        }

        // 'ec_detrendCompute:245' xx = demean_lfn(x,w).*repmat(w,1,size(x,2));
        i = d_ww->size[0];
        d_ww->size[0] = b_w->size[0];
        emxEnsureCapacity_boolean_T(d_ww, i, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(d_ww, &d_gpu_ww);
        x_dim0 = b_w->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0 +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_w_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
          }

          b_w_dirtyOnCpu = false;
          ecu_detrend_kernel157<<<grid, block>>>(b_gpu_w, x_dim0, d_gpu_ww);
          d_ww_dirtyOnGpu = true;
        }

        //  if isempty(w)
        //      % simple regression
        //      xx = demean_lfn(x);
        //      yy = demean_lfn(y);
        //      [V,D] = eig(xx'*xx);
        //      V = real(V);
        //      D = real(D);
        //      topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
        //      xxx = xx*topcs;
        //      b = ((yy'*xxx) / (xxx'*xxx))';
        //      z = demean_lfn(x,w)*topcs*b;
        //      z = z + mn;
        //  else
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //  [y,mn]=nt_demean(x,w) - remove weighted mean over cols
        //
        //  If w is a vector with fewer samples than size(x,1), it is interpreted as
        //  a vector of indices to be set to 1, the others being set to 0.
        // 'ec_detrendCompute:297' [m,n] = size(x);
        // 'ec_detrendCompute:299' if ~isempty(w) && numel(w)<m
        i = b_w->size[0];
        if ((b_w->size[0] != 0) && (b_w->size[0] < r->size[0])) {
          // 'ec_detrendCompute:300' w=w(:);
          //  interpret w as array of indices to set to 1
          // 'ec_detrendCompute:302' if min(w)<1 || max(w)>m
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          b_y = b_w->data[0];
          for (o_x = 0; o_x <= i - 2; o_x++) {
            if (static_cast<int32_T>(b_y) > static_cast<int32_T>(b_w->data[o_x +
                 1])) {
              b_y = b_w->data[o_x + 1];
            }
          }

          if (!b_y) {
            // 'ec_detrendCompute:303' error('w interpreted as indices but values are out of range');
            ib_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv12[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 52, m1, &varargin_1[0]);
            emlrtAssign(&ib_y, m1);
            b_error(ib_y, &emlrtMCI);
          }

          // 'ec_detrendCompute:305' ww = false(m,1);
          i = d_ww->size[0];
          d_ww->size[0] = r->size[0];
          emxEnsureCapacity_boolean_T(d_ww, i, &s_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(d_ww, &d_gpu_ww);
          i = r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecu_detrend_kernel158<<<grid, block>>>(i, d_gpu_ww);
            d_ww_dirtyOnGpu = true;
          }

          // 'ec_detrendCompute:306' ww(w) = true;
          na = b_w->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
            ecu_detrend_kernel159<<<grid, block>>>(b_gpu_w, gpu_na, d_gpu_ww);
            d_ww_dirtyOnGpu = true;
          }

          // 'ec_detrendCompute:307' w = ww;
        }

        //  if size(w,3)~=p
        //      if size(w,3)==1 && p~=1
        //          w = repmat(w,[1,1,p]);
        //      else
        //          error('W should have same npages as X, or else 1');
        //      end
        //  end
        // if p>1; x = unfold_lfn(x); end
        // 'ec_detrendCompute:319' if isempty(w)
        if (d_ww->size[0] == 0) {
          // 'ec_detrendCompute:320' mn = mean(x,1);
          i2 = r->size[0];
          if ((r->size[0] == 0) || (r->size[1] == 0)) {
            for (i = 0; i < 2; i++) {
              if (outsize_dirtyOnGpu) {
                cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
              }

              outsize[i] = static_cast<uint32_T>(r->size[i]);
              outsize_dirtyOnGpu = false;
              outsize_dirtyOnCpu = true;
            }

            i = f_y->size[0] * f_y->size[1];
            f_y->size[0] = 1;
            if (outsize_dirtyOnGpu) {
              cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
            }

            f_y->size[1] = static_cast<int32_T>(outsize[1]);
            emxEnsureCapacity_real_T(f_y, i, &bb_emlrtRTEI);
            if (!y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(f_y, &b_gpu_y);
            }

            outsize_dirtyOnGpu = false;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(outsize[1]) - 1) + 1L), &grid, &block, 1024U,
              65535U);
            if (validLaunchParams) {
              if (y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_y, f_y);
              }

              ecu_detrend_kernel163<<<grid, block>>>(static_cast<int32_T>
                (outsize[1]) - 1, b_gpu_y);
              y_dirtyOnCpu = false;
              b_y_dirtyOnGpu = true;
            }
          } else {
            i = f_y->size[0] * f_y->size[1];
            f_y->size[0] = 1;
            f_y->size[1] = 1;
            emxEnsureCapacity_real_T(f_y, i, &ab_emlrtRTEI);
            if (!y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(f_y, &b_gpu_y);
            }

            if (b_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_y, &b_gpu_y);
            }

            if (r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
            }

            r_dirtyOnGpu = false;
            f_y->data[0] = r->data[0];
            b_y_dirtyOnGpu = false;
            y_dirtyOnCpu = true;
            for (na = 0; na <= i2 - 2; na++) {
              f_y->data[0] += r->data[na + 1];
            }
          }

          // 'ec_detrendCompute:321' x = x - mn;
          if (r->size[1] == f_y->size[1]) {
            npages = r->size[0];
            i = dv7->size[0] * dv7->size[1];
            dv7->size[0] = r->size[0];
            dv7->size[1] = r->size[1];
            emxEnsureCapacity_real_T(dv7, i, &cb_emlrtRTEI);
            if (!dv7_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(dv7, &gpu_dv7);
            }

            i = r->size[1] - 1;
            nx = r->size[0] - 1;
            o_x = dv7->size[0];
            ntilecols = r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx
              + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_y, f_y);
              }

              y_dirtyOnCpu = false;
              if (dv7_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv7, dv7);
              }

              ecu_detrend_kernel164<<<grid, block>>>(npages, b_gpu_y, gpu_r, nx,
                i, o_x, ntilecols, gpu_dv7);
              dv7_dirtyOnCpu = false;
              dv7_dirtyOnGpu = true;
            }
          } else {
            if (dv7_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv7, &gpu_dv7);
            }

            if (r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
            }

            r_dirtyOnGpu = false;
            if (b_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_y, &b_gpu_y);
            }

            b_y_dirtyOnGpu = false;
            b_binary_expand_op(dv7, r, f_y);
            dv7_dirtyOnGpu = false;
            dv7_dirtyOnCpu = true;
          }

          // vecadd_lfn(x,-mn);
        } else {
          // 'ec_detrendCompute:322' else
          // if p>1; w = unfold_lfn(w); end
          // 'ec_detrendCompute:324' if size(w,1)~=size(x,1)
          if (d_ww->size[0] != r->size[0]) {
            // 'ec_detrendCompute:324' ;
            // 'ec_detrendCompute:324' error('X and W should have same nrows');
            jb_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv13[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 30, m1, &b_varargin_1[0]);
            emlrtAssign(&jb_y, m1);
            b_error(jb_y, &emlrtMCI);
          }

          // 'ec_detrendCompute:325' if size(w,2)==1
          // 'ec_detrendCompute:326' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if (r->size[0] == d_ww->size[0]) {
            i = h_x->size[0] * h_x->size[1];
            h_x->size[0] = r->size[0];
            h_x->size[1] = r->size[1];
            emxEnsureCapacity_real_T(h_x, i, &t_emlrtRTEI);
            if (!g_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(h_x, &g_gpu_x);
            }

            i = r->size[1] - 1;
            nx = r->size[0] - 1;
            x_dim0 = h_x->size[0];
            ntilecols = r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx
              + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (g_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_x, h_x);
              }

              ecu_detrend_kernel160<<<grid, block>>>(d_gpu_ww, gpu_r, nx, i,
                x_dim0, ntilecols, g_gpu_x);
              g_x_dirtyOnCpu = false;
              g_x_dirtyOnGpu = true;
            }
          } else {
            if (g_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_x, &g_gpu_x);
            }

            if (r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
            }

            r_dirtyOnGpu = false;
            if (d_ww_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(d_ww, &d_gpu_ww);
            }

            d_ww_dirtyOnGpu = false;
            binary_expand_op(h_x, r, d_ww);
            g_x_dirtyOnGpu = false;
            g_x_dirtyOnCpu = true;
          }

          i2 = h_x->size[0];
          if ((h_x->size[0] == 0) || (h_x->size[1] == 0)) {
            for (i = 0; i < 2; i++) {
              if (outsize_dirtyOnGpu) {
                cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
              }

              outsize[i] = static_cast<uint32_T>(h_x->size[i]);
              outsize_dirtyOnGpu = false;
              outsize_dirtyOnCpu = true;
            }

            i = g_y->size[0] * g_y->size[1];
            g_y->size[0] = 1;
            if (outsize_dirtyOnGpu) {
              cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
            }

            g_y->size[1] = static_cast<int32_T>(outsize[1]);
            emxEnsureCapacity_real_T(g_y, i, &db_emlrtRTEI);
            if (!b_y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(g_y, &c_gpu_y);
            }

            outsize_dirtyOnGpu = false;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(outsize[1]) - 1) + 1L), &grid, &block, 1024U,
              65535U);
            if (validLaunchParams) {
              if (b_y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_y, g_y);
              }

              ecu_detrend_kernel161<<<grid, block>>>(static_cast<int32_T>
                (outsize[1]) - 1, c_gpu_y);
              b_y_dirtyOnCpu = false;
              c_y_dirtyOnGpu = true;
            }
          } else {
            i = g_y->size[0] * g_y->size[1];
            g_y->size[0] = 1;
            g_y->size[1] = 1;
            emxEnsureCapacity_real_T(g_y, i, &ab_emlrtRTEI);
            if (!b_y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(g_y, &c_gpu_y);
            }

            if (c_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_y, &c_gpu_y);
            }

            if (g_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_x, &g_gpu_x);
            }

            g_x_dirtyOnGpu = false;
            g_y->data[0] = h_x->data[0];
            c_y_dirtyOnGpu = false;
            b_y_dirtyOnCpu = true;
            for (na = 0; na <= i2 - 2; na++) {
              g_y->data[0] += h_x->data[na + 1];
            }
          }

          i2 = d_ww->size[0];
          if (d_ww_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(d_ww, &d_gpu_ww);
          }

          d_ww_dirtyOnGpu = false;
          npages = d_ww->data[0];
          for (o_x = 0; o_x <= i2 - 2; o_x++) {
            npages += d_ww->data[o_x + 1];
          }

          // sum(vecmult_lfn(x),w),1) ./ (sum(w,1)+eps);
          // 'ec_detrendCompute:332' x = x - mn;
          if (r->size[1] == g_y->size[1]) {
            d2scaled = static_cast<real_T>(npages) + 2.2204460492503131E-16;
            i = dv7->size[0] * dv7->size[1];
            dv7->size[0] = r->size[0];
            dv7->size[1] = r->size[1];
            emxEnsureCapacity_real_T(dv7, i, &cb_emlrtRTEI);
            if (!dv7_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(dv7, &gpu_dv7);
            }

            i = r->size[1] - 1;
            nx = r->size[0] - 1;
            o_x = dv7->size[0];
            ntilecols = r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx
              + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_y, g_y);
              }

              b_y_dirtyOnCpu = false;
              cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
              if (dv7_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv7, dv7);
              }

              ecu_detrend_kernel162<<<grid, block>>>(c_gpu_y, gpu_r, nx, i, o_x,
                ntilecols, gpu_d2scaled, gpu_dv7);
              dv7_dirtyOnCpu = false;
              dv7_dirtyOnGpu = true;
              y_dirtyOnGpu = true;
            }
          } else {
            if (dv7_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv7, &gpu_dv7);
            }

            if (r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
            }

            r_dirtyOnGpu = false;
            if (c_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_y, &c_gpu_y);
            }

            c_y_dirtyOnGpu = false;
            binary_expand_op(dv7, r, g_y, npages);
            dv7_dirtyOnGpu = false;
            dv7_dirtyOnCpu = true;
          }

          // x = vecadd_lfn(x,-mn);
        }

        i = bv1->size[0] * bv1->size[1];
        bv1->size[0] = b_w->size[0];
        bv1->size[1] = r->size[1];
        emxEnsureCapacity_boolean_T(bv1, i, &x_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv1, &gpu_bv1);
        npages = b_w->size[0] - 1;
        ntilecols = r->size[1];
        for (i2 = 0; i2 < ntilecols; i2++) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            ecu_detrend_kernel165<<<grid, block>>>(b_gpu_w, npages, gpu_bv1);
            bv1_dirtyOnGpu = true;
          }
        }

        if ((dv7->size[0] == bv1->size[0]) && (dv7->size[1] == bv1->size[1])) {
          i = xx->size[0] * xx->size[1];
          xx->size[0] = dv7->size[0];
          xx->size[1] = dv7->size[1];
          emxEnsureCapacity_real_T(xx, i, &eb_emlrtRTEI);
          if (!xx_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(xx, &gpu_xx);
          }

          o_x = dv7->size[0] * dv7->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (dv7_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv7, dv7);
            }

            dv7_dirtyOnCpu = false;
            if (xx_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
            }

            ecu_detrend_kernel166<<<grid, block>>>(gpu_bv1, gpu_dv7, o_x, gpu_xx);
            xx_dirtyOnCpu = false;
            xx_dirtyOnGpu = true;
          }
        } else {
          if (xx_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(xx, &gpu_xx);
          }

          if (dv7_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv7, &gpu_dv7);
          }

          dv7_dirtyOnGpu = false;
          if (bv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv1, &gpu_bv1);
          }

          bv1_dirtyOnGpu = false;
          c_binary_expand_op(xx, dv7, bv1);
          xx_dirtyOnGpu = false;
          xx_dirtyOnCpu = true;
        }

        // 'ec_detrendCompute:246' [V,D] = eig(xx'*xx);
        i = b_A->size[0] * b_A->size[1];
        b_A->size[0] = xx->size[1];
        b_A->size[1] = xx->size[0];
        emxEnsureCapacity_real_T(b_A, i, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_A, &gpu_A);
        nx = xx->size[0] - 1;
        x_dim0 = xx->size[1] - 1;
        ntilecols = b_A->size[0];
        o_x = xx->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((x_dim0
          + 1L) * (nx + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          ecu_detrend_kernel167<<<grid, block>>>(gpu_xx, x_dim0, nx, ntilecols,
            o_x, gpu_A);
        }

        if ((b_A->size[0] == 0) || (b_A->size[1] == 0) || (xx->size[0] == 0) ||
            (xx->size[1] == 0)) {
          i = A->size[0] * A->size[1];
          A->size[0] = b_A->size[0];
          A->size[1] = xx->size[1];
          emxEnsureCapacity_real_T(A, i, &hb_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(A, &b_gpu_A);
          }

          nx = b_A->size[0] * xx->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
            }

            ecu_detrend_kernel168<<<grid, block>>>(nx, b_gpu_A);
            A_dirtyOnCpu = false;
            A_dirtyOnGpu = true;
          }
        } else {
          i = A->size[0] * A->size[1];
          A->size[0] = 1;
          A->size[1] = 1;
          emxEnsureCapacity_real_T(A, i, &gb_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(A, &b_gpu_A);
          }

          d2scaled = 1.0;
          y_dirtyOnGpu = false;
          abnrm = 0.0;
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          if (A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1, 1,
                      b_A->size[1], (double *)&d2scaled, (double *)&gpu_A.data[0],
                      1, (double *)&gpu_xx.data[0], b_A->size[1], (double *)
                      &abnrm, (double *)&b_gpu_A.data[0], 1);
          A_dirtyOnCpu = false;
          A_dirtyOnGpu = true;
        }

        i2 = A->size[0];
        i = V->size[0] * V->size[1];
        V->size[0] = A->size[0];
        V->size[1] = A->size[0];
        emxEnsureCapacity_creal_T(V, i, &ib_emlrtRTEI);
        if (!V_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
        }

        i = D->size[0] * D->size[1];
        D->size[0] = A->size[0];
        D->size[1] = A->size[0];
        emxEnsureCapacity_creal_T(D, i, &jb_emlrtRTEI);
        if (!D_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
        }

        if ((A->size[0] != 0) && (A->size[1] != 0)) {
          if (A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
          }

          A_dirtyOnGpu = false;
          if (std::isinf(A->data[0]) || std::isnan(A->data[0])) {
            for (i = 0; i < 2; i++) {
              e_r[i] = V->size[i];
            }

            i = V->size[0] * V->size[1];
            V->size[0] = e_r[0];
            V->size[1] = e_r[1];
            emxEnsureCapacity_creal_T(V, i, &lb_emlrtRTEI);
            if (!V_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
            }

            ntilecols = e_r[0] * e_r[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (ntilecols + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (V_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
              }

              ecu_detrend_kernel183<<<grid, block>>>(gpu_dc, ntilecols, gpu_V);
              V_dirtyOnCpu = false;
              V_dirtyOnGpu = true;
            }

            for (i = 0; i < 2; i++) {
              e_r[i] = D->size[i];
            }

            i = D->size[0] * D->size[1];
            D->size[0] = e_r[0];
            D->size[1] = e_r[1];
            emxEnsureCapacity_creal_T(D, i, &vb_emlrtRTEI);
            if (!D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
            }

            ntilecols = e_r[0] * e_r[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (ntilecols + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
              }

              ecu_detrend_kernel184<<<grid, block>>>(ntilecols, gpu_D);
              D_dirtyOnCpu = false;
              D_dirtyOnGpu = true;
            }

            if (i2 - 1 >= 0) {
              if (D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
              }

              ecu_detrend_kernel185<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (gpu_dc, gpu_D);
              D_dirtyOnCpu = false;
              D_dirtyOnGpu = true;
            }
          } else if (!(A->data[0] == A->data[0])) {
            if (!(A->data[0] == -A->data[0])) {
              ptrdiff_t e_info_t;
              i = scale->size[0];
              scale->size[0] = 1;
              emxEnsureCapacity_real_T(scale, i, &nb_emlrtRTEI);
              i = dt->size[0];
              dt->size[0] = 1;
              emxEnsureCapacity_creal_T(dt, i, &qb_emlrtRTEI);
              gpuEmxEnsureCapacity_creal_T(dt, &gpu_dt);
              i = wreal->size[0];
              wreal->size[0] = 1;
              emxEnsureCapacity_real_T(wreal, i, &tb_emlrtRTEI);
              i = wimag->size[0];
              wimag->size[0] = 1;
              emxEnsureCapacity_real_T(wimag, i, &wb_emlrtRTEI);
              i = vright->size[0] * vright->size[1];
              vright->size[0] = 1;
              vright->size[1] = 1;
              emxEnsureCapacity_real_T(vright, i, &xb_emlrtRTEI);
              if (y_dirtyOnGpu) {
                cudaMemcpy(&d2scaled, gpu_d2scaled, 8UL, cudaMemcpyDeviceToHost);
              }

              e_info_t = LAPACKE_dgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)1,
                &A->data[0], (ptrdiff_t)1, &wreal->data[0], &wimag->data[0],
                &d2scaled, (ptrdiff_t)1, &vright->data[0], (ptrdiff_t)1, &ilo_t,
                &ihi_t, &scale->data[0], &abnrm, &rconde, &rcondv);
              A_dirtyOnCpu = true;
              if ((int32_T)e_info_t < 0) {
                i = dt->size[0];
                dt->size[0] = 1;
                emxEnsureCapacity_creal_T(dt, i, &gc_emlrtRTEI);
                gpuEmxEnsureCapacity_creal_T(dt, &gpu_dt);
                if (dc_dirtyOnGpu) {
                  cudaMemcpy(&dc, gpu_dc, 16UL, cudaMemcpyDeviceToHost);
                }

                dc_dirtyOnGpu = false;
                dt->data[0] = dc;
                i = V->size[0] * V->size[1];
                V->size[0] = 1;
                V->size[1] = 1;
                emxEnsureCapacity_creal_T(V, i, &jc_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
                } else {
                  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                }

                ecu_detrend_kernel179<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                  (gpu_dc, gpu_V);
                V_dirtyOnCpu = false;
                V_dirtyOnGpu = true;
              } else {
                real_T d1;
                dt->data[0].re = wreal->data[0];
                dt->data[0].im = wimag->data[0];
                i = V->size[0] * V->size[1];
                V->size[0] = 1;
                V->size[1] = 1;
                emxEnsureCapacity_creal_T(V, i, &hc_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
                }

                d1 = vright->data[0];
                i = 1;
                if (V_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_creal_T(V, &gpu_V);
                }

                V->data[0].im = 0.0;
                V->data[0].re = d1;
                V_dirtyOnGpu = false;
                V_dirtyOnCpu = true;
              }

              x_dim0 = D->size[0];
              o_x = D->size[1];
              if (D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
              }

              cudaMemcpy(gpu_i, &i, 4UL, cudaMemcpyHostToDevice);
              ecu_detrend_kernel180<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (x_dim0, o_x, gpu_i);
              D->size[0] = 1;
              D->size[1] = 1;
              cudaMemcpy(&i, gpu_i, 4UL, cudaMemcpyDeviceToHost);
              emxEnsureCapacity_creal_T(D, i, &lc_emlrtRTEI);
              gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
              ecu_detrend_kernel181<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (gpu_D);
              gpuEmxMemcpyCpuToGpu_creal_T(&gpu_dt, dt);
              ecu_detrend_kernel182<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (gpu_dt, gpu_D);
              D_dirtyOnCpu = false;
              D_dirtyOnGpu = true;
            } else {
              if (std::isinf(A->data[0]) || std::isnan(A->data[0])) {
                i = U->size[0] * U->size[1];
                U->size[0] = 1;
                U->size[1] = 1;
                emxEnsureCapacity_real_T(U, i, &pb_emlrtRTEI);
                if (!U_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(U, &gpu_U);
                }

                if (U_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(U, &gpu_U);
                }

                U->data[0] = rtNaN;
                U_dirtyOnGpu = false;
                U_dirtyOnCpu = true;
              } else {
                ptrdiff_t b_info_t;
                ptrdiff_t b_n_t;
                ptrdiff_t d_info_t;
                b_tau->size[0] = 0;
                i = U->size[0] * U->size[1];
                U->size[0] = A->size[0];
                U->size[1] = A->size[1];
                emxEnsureCapacity_real_T(U, i, &rb_emlrtRTEI);
                if (!U_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(U, &gpu_U);
                }

                nx = A->size[0] * A->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (nx + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (A_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                  }

                  if (U_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                  }

                  ecu_detrend_kernel175<<<grid, block>>>(b_gpu_A, nx, gpu_U);
                  U_dirtyOnGpu = true;
                }

                if (U_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(U, &gpu_U);
                }

                b_info_t = LAPACKE_dorghr(102, (ptrdiff_t)1, (ptrdiff_t)1,
                  (ptrdiff_t)1, &U->data[0], (ptrdiff_t)1, &b_tau->data[0]);
                U_dirtyOnGpu = false;
                if ((int32_T)b_info_t != 0) {
                  for (i = 0; i < 2; i++) {
                    e_r[i] = U->size[i];
                  }

                  i = U->size[0] * U->size[1];
                  U->size[0] = e_r[0];
                  U->size[1] = e_r[1];
                  emxEnsureCapacity_real_T(U, i, &rb_emlrtRTEI);
                  ntilecols = e_r[0] * e_r[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (ntilecols + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                    ecu_detrend_kernel176<<<grid, block>>>(ntilecols, gpu_U);
                    U_dirtyOnGpu = true;
                  }
                }

                b_n_t = (ptrdiff_t)1;
                i = b_wr->size[0] * b_wr->size[1];
                b_wr->size[0] = 1;
                b_wr->size[1] = 1;
                emxEnsureCapacity_real_T(b_wr, i, &cc_emlrtRTEI);
                i = b_wi->size[0] * b_wi->size[1];
                b_wi->size[0] = 1;
                b_wi->size[1] = 1;
                emxEnsureCapacity_real_T(b_wi, i, &ec_emlrtRTEI);
                if (U_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(U, &gpu_U);
                }

                d_info_t = LAPACKE_dhseqr(102, 'S', 'V', b_n_t, (ptrdiff_t)1,
                  (ptrdiff_t)1, &A->data[0], b_n_t, &b_wr->data[0], &b_wi->data
                  [0], &U->data[0], (ptrdiff_t)1);
                U_dirtyOnGpu = false;
                U_dirtyOnCpu = true;
                A_dirtyOnCpu = true;
                if ((int32_T)d_info_t < 0) {
                  for (i = 0; i < 2; i++) {
                    e_r[i] = U->size[i];
                  }

                  i = U->size[0] * U->size[1];
                  U->size[0] = e_r[0];
                  U->size[1] = e_r[1];
                  emxEnsureCapacity_real_T(U, i, &mc_emlrtRTEI);
                  ntilecols = e_r[0] * e_r[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (ntilecols + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                    ecu_detrend_kernel177<<<grid, block>>>(ntilecols, gpu_U);
                    U_dirtyOnCpu = false;
                    U_dirtyOnGpu = true;
                  }
                }
              }

              i = D->size[0] * D->size[1];
              D->size[0] = 1;
              D->size[1] = 1;
              emxEnsureCapacity_creal_T(D, i, &ac_emlrtRTEI);
              if (!D_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
              }

              if (D_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_creal_T(D, &gpu_D);
              }

              D->data[0].im = 0.0;
              D->data[0].re = 0.0;
              D_dirtyOnGpu = false;
              D_dirtyOnCpu = true;
              i = V->size[0] * V->size[1];
              V->size[0] = U->size[0];
              V->size[1] = U->size[1];
              emxEnsureCapacity_creal_T(V, i, &bc_emlrtRTEI);
              if (!V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
              }

              x_dim0 = U->size[0] * U->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (U_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                }

                U_dirtyOnCpu = false;
                if (V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                }

                ecu_detrend_kernel178<<<grid, block>>>(gpu_U, x_dim0, gpu_V);
                V_dirtyOnCpu = false;
                V_dirtyOnGpu = true;
              }
            }
          } else {
            if (std::isinf(A->data[0]) || std::isnan(A->data[0])) {
              i = b_V->size[0] * b_V->size[1];
              b_V->size[0] = 1;
              b_V->size[1] = 1;
              emxEnsureCapacity_real_T(b_V, i, &pb_emlrtRTEI);
              if (!b_V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(b_V, &b_gpu_V);
              }

              i = A->size[0] * A->size[1];
              A->size[0] = 1;
              A->size[1] = 1;
              emxEnsureCapacity_real_T(A, i, &sb_emlrtRTEI);
              if (!A_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(A, &b_gpu_A);
              }

              if (b_V_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_V, &b_gpu_V);
              }

              b_V->data[0] = rtNaN;
              b_V_dirtyOnGpu = false;
              b_V_dirtyOnCpu = true;
              A->data[0] = rtNaN;
              A_dirtyOnCpu = true;
            } else {
              ptrdiff_t c_info_t;
              ptrdiff_t info_t;
              ptrdiff_t n_t;
              tau->size[0] = 0;
              i = b_V->size[0] * b_V->size[1];
              b_V->size[0] = A->size[0];
              b_V->size[1] = A->size[1];
              emxEnsureCapacity_real_T(b_V, i, &rb_emlrtRTEI);
              if (!b_V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(b_V, &b_gpu_V);
              }

              nx = A->size[0] * A->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (A_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                }

                if (b_V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_V, b_V);
                }

                ecu_detrend_kernel169<<<grid, block>>>(b_gpu_A, nx, b_gpu_V);
                b_V_dirtyOnGpu = true;
              }

              if (b_V_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_V, &b_gpu_V);
              }

              info_t = LAPACKE_dorghr(102, (ptrdiff_t)1, (ptrdiff_t)1,
                (ptrdiff_t)1, &b_V->data[0], (ptrdiff_t)1, &tau->data[0]);
              b_V_dirtyOnGpu = false;
              if ((int32_T)info_t != 0) {
                for (i = 0; i < 2; i++) {
                  e_r[i] = b_V->size[i];
                }

                i = b_V->size[0] * b_V->size[1];
                b_V->size[0] = e_r[0];
                b_V->size[1] = e_r[1];
                emxEnsureCapacity_real_T(b_V, i, &rb_emlrtRTEI);
                ntilecols = e_r[0] * e_r[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (ntilecols + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_V, b_V);
                  ecu_detrend_kernel170<<<grid, block>>>(ntilecols, b_gpu_V);
                  b_V_dirtyOnGpu = true;
                }
              }

              n_t = (ptrdiff_t)1;
              i = wr->size[0] * wr->size[1];
              wr->size[0] = 1;
              wr->size[1] = 1;
              emxEnsureCapacity_real_T(wr, i, &cc_emlrtRTEI);
              i = wi->size[0] * wi->size[1];
              wi->size[0] = 1;
              wi->size[1] = 1;
              emxEnsureCapacity_real_T(wi, i, &ec_emlrtRTEI);
              if (b_V_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_V, &b_gpu_V);
              }

              c_info_t = LAPACKE_dhseqr(102, 'S', 'V', n_t, (ptrdiff_t)1,
                (ptrdiff_t)1, &A->data[0], n_t, &wr->data[0], &wi->data[0],
                &b_V->data[0], (ptrdiff_t)1);
              b_V_dirtyOnGpu = false;
              b_V_dirtyOnCpu = true;
              A_dirtyOnCpu = true;
              if ((int32_T)c_info_t < 0) {
                for (i = 0; i < 2; i++) {
                  e_r[i] = A->size[i];
                }

                i = A->size[0] * A->size[1];
                A->size[0] = e_r[0];
                A->size[1] = e_r[1];
                emxEnsureCapacity_real_T(A, i, &kc_emlrtRTEI);
                ntilecols = e_r[0] * e_r[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (ntilecols + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                  ecu_detrend_kernel171<<<grid, block>>>(ntilecols, b_gpu_A);
                  A_dirtyOnCpu = false;
                  A_dirtyOnGpu = true;
                }

                for (i = 0; i < 2; i++) {
                  e_r[i] = b_V->size[i];
                }

                i = b_V->size[0] * b_V->size[1];
                b_V->size[0] = e_r[0];
                b_V->size[1] = e_r[1];
                emxEnsureCapacity_real_T(b_V, i, &mc_emlrtRTEI);
                ntilecols = e_r[0] * e_r[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (ntilecols + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_V, b_V);
                  ecu_detrend_kernel172<<<grid, block>>>(ntilecols, b_gpu_V);
                  b_V_dirtyOnCpu = false;
                  b_V_dirtyOnGpu = true;
                }
              }
            }

            i = V->size[0] * V->size[1];
            V->size[0] = b_V->size[0];
            V->size[1] = b_V->size[1];
            emxEnsureCapacity_creal_T(V, i, &yb_emlrtRTEI);
            if (!V_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
            }

            ntilecols = b_V->size[0] * b_V->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (ntilecols + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_V_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_V, b_V);
              }

              b_V_dirtyOnCpu = false;
              if (V_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
              }

              ecu_detrend_kernel173<<<grid, block>>>(b_gpu_V, ntilecols, gpu_V);
              V_dirtyOnCpu = false;
              V_dirtyOnGpu = true;
            }

            i = D->size[0] * D->size[1];
            D->size[0] = A->size[0];
            D->size[1] = A->size[1];
            emxEnsureCapacity_creal_T(D, i, &dc_emlrtRTEI);
            if (!D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
            }

            nx = A->size[0] * A->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (A_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
              }

              A_dirtyOnCpu = false;
              if (D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
              }

              ecu_detrend_kernel174<<<grid, block>>>(b_gpu_A, nx, gpu_D);
              D_dirtyOnCpu = false;
              D_dirtyOnGpu = true;
            }
          }
        }

        // 'ec_detrendCompute:247' V = real(V);
        // 'ec_detrendCompute:248' topcs = V(:,D/max(diag(real(D))) > thr_PCA);
        i = v->size[0] * v->size[1];
        v->size[0] = D->size[0];
        v->size[1] = D->size[1];
        emxEnsureCapacity_real_T(v, i, &kb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(v, &gpu_v);
        x_dim0 = D->size[0] * D->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0 +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (D_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
          }

          D_dirtyOnCpu = false;
          ecu_detrend_kernel186<<<grid, block>>>(gpu_D, x_dim0, gpu_v);
          v_dirtyOnGpu = true;
        }

        if ((v->size[0] == 1) && (v->size[1] == 1)) {
          i = d->size[0];
          d->size[0] = 1;
          emxEnsureCapacity_real_T(d, i, &ob_emlrtRTEI);
          if (v_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(v, &gpu_v);
          }

          v_dirtyOnGpu = false;
          d->data[0] = v->data[0];
        } else {
          if (v->size[1] > 0) {
            npages = v->size[0];
          } else {
            npages = 0;
          }

          i = d->size[0];
          d->size[0] = npages;
          emxEnsureCapacity_real_T(d, i, &mb_emlrtRTEI);
          if (npages - 1 >= 0) {
            if (v_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(v, &gpu_v);
            }

            v_dirtyOnGpu = false;
            d->data[0] = v->data[0];
          }
        }

        i = bv3->size[0] * bv3->size[1];
        bv3->size[0] = D->size[0];
        bv3->size[1] = D->size[1];
        emxEnsureCapacity_boolean_T(bv3, i, &ub_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv3, &gpu_bv3);
        f_d.re = d->data[0];
        x_dim0 = D->size[0] * D->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0 +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (D_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
          }

          D_dirtyOnCpu = false;
          ecu_detrend_kernel187<<<grid, block>>>(f_d, gpu_D, x_dim0, gpu_bv3);
          bv3_dirtyOnGpu = true;
        }

        na = bv3->size[0] * bv3->size[1] - 1;
        npages = 0;
        for (o_x = 0; o_x <= na; o_x++) {
          if (bv3_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv3, &gpu_bv3);
          }

          bv3_dirtyOnGpu = false;
          if (bv3->data[0]) {
            npages++;
          }
        }

        i = iv19->size[0];
        iv19->size[0] = npages;
        emxEnsureCapacity_int8_T(iv19, i, &fc_emlrtRTEI);
        npages = 0;
        for (o_x = 0; o_x <= na; o_x++) {
          if (bv3_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv3, &gpu_bv3);
          }

          bv3_dirtyOnGpu = false;
          if (bv3->data[0]) {
            iv19->data[npages] = 1;
            npages++;
          }
        }

        i = topcs->size[0] * topcs->size[1];
        topcs->size[0] = V->size[0];
        topcs->size[1] = iv19->size[0];
        emxEnsureCapacity_real_T(topcs, i, &ic_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(topcs, &gpu_topcs);
        o_x = iv19->size[0] - 1;
        ntilecols = V->size[0] - 1;
        nx = topcs->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((ntilecols + 1L) * (o_x + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (V_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
          }

          V_dirtyOnCpu = false;
          ecu_detrend_kernel188<<<grid, block>>>(gpu_V, ntilecols, o_x, nx,
            gpu_topcs);
        }

        //  discard weak dims
        // 'ec_detrendCompute:249' xxx = xx*topcs;
        if ((xx->size[0] == 0) || (xx->size[1] == 0) || (topcs->size[0] == 0) ||
            (topcs->size[1] == 0)) {
          i = xxx->size[0] * xxx->size[1];
          xxx->size[0] = xx->size[0];
          xxx->size[1] = topcs->size[1];
          emxEnsureCapacity_real_T(xxx, i, &nc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(xxx, &gpu_xxx);
          nx = xx->size[0] * topcs->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecu_detrend_kernel189<<<grid, block>>>(nx, gpu_xxx);
          }
        } else {
          i = xxx->size[0] * xxx->size[1];
          xxx->size[0] = xx->size[0];
          xxx->size[1] = topcs->size[1];
          emxEnsureCapacity_real_T(xxx, i, &gb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(xxx, &gpu_xxx);
          d2scaled = 1.0;
          abnrm = 0.0;
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      xx->size[0], topcs->size[1], 1, (double *)&d2scaled,
                      (double *)&gpu_xx.data[0], xx->size[0], (double *)
                      &gpu_topcs.data[0], 1, (double *)&abnrm, (double *)
                      &gpu_xxx.data[0], xx->size[0]);
        }

        // 'ec_detrendCompute:250' b = ((yy'*xxx) / (xxx'*xxx))';
        if (dv5->size[0] == bv->size[0]) {
          i = c_A->size[0] * c_A->size[1];
          c_A->size[0] = 1;
          c_A->size[1] = dv5->size[0];
          emxEnsureCapacity_real_T(c_A, i, &fb_emlrtRTEI);
          if (!c_A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(c_A, &e_gpu_A);
          }

          o_x = dv5->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_A, c_A);
            }

            ecu_detrend_kernel190<<<grid, block>>>(gpu_bv, gpu_dv5, o_x, e_gpu_A);
            c_A_dirtyOnCpu = false;
            c_A_dirtyOnGpu = true;
          }
        } else {
          if (c_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_A, &e_gpu_A);
          }

          if (dv5_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv5, &gpu_dv5);
          }

          dv5_dirtyOnGpu = false;
          if (bv_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv, &gpu_bv);
          }

          bv_dirtyOnGpu = false;
          b_binary_expand_op(c_A, dv5, bv);
          c_A_dirtyOnGpu = false;
          c_A_dirtyOnCpu = true;
        }

        if ((c_A->size[1] == 0) || (xxx->size[0] == 0) || (xxx->size[1] == 0)) {
          i = X->size[0] * X->size[1];
          X->size[0] = 1;
          X->size[1] = xxx->size[1];
          emxEnsureCapacity_real_T(X, i, &hb_emlrtRTEI);
          if (!X_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(X, &gpu_X);
          }

          x_dim0 = xxx->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (X_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_X, X);
            }

            ecu_detrend_kernel191<<<grid, block>>>(x_dim0, gpu_X);
            X_dirtyOnCpu = false;
          }
        } else {
          i = X->size[0] * X->size[1];
          X->size[0] = 1;
          X->size[1] = xxx->size[1];
          emxEnsureCapacity_real_T(X, i, &gb_emlrtRTEI);
          if (!X_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(X, &gpu_X);
          }

          d2scaled = 1.0;
          abnrm = 0.0;
          if (c_A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_A, c_A);
          }

          c_A_dirtyOnCpu = false;
          if (X_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_X, X);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                      xxx->size[1], c_A->size[1], (double *)&d2scaled, (double *)
                      &e_gpu_A.data[0], 1, (double *)&gpu_xxx.data[0], c_A->
                      size[1], (double *)&abnrm, (double *)&gpu_X.data[0], 1);
          X_dirtyOnCpu = false;
        }

        i = d_A->size[0] * d_A->size[1];
        d_A->size[0] = xxx->size[1];
        d_A->size[1] = xxx->size[0];
        emxEnsureCapacity_real_T(d_A, i, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_A, &f_gpu_A);
        x_dim0 = xxx->size[0] - 1;
        o_x = xxx->size[1] - 1;
        ntilecols = d_A->size[0];
        nx = xxx->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((o_x +
          1L) * (x_dim0 + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ecu_detrend_kernel192<<<grid, block>>>(gpu_xxx, o_x, x_dim0, ntilecols,
            nx, f_gpu_A);
        }

        if ((d_A->size[0] == 0) || (d_A->size[1] == 0) || (xxx->size[0] == 0) ||
            (xxx->size[1] == 0)) {
          i = e_A->size[0] * e_A->size[1];
          e_A->size[0] = d_A->size[0];
          e_A->size[1] = xxx->size[1];
          emxEnsureCapacity_real_T(e_A, i, &hb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(e_A, &g_gpu_A);
          nx = d_A->size[0] * xxx->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecu_detrend_kernel193<<<grid, block>>>(nx, g_gpu_A);
          }
        } else {
          i = e_A->size[0] * e_A->size[1];
          e_A->size[0] = d_A->size[0];
          e_A->size[1] = xxx->size[1];
          emxEnsureCapacity_real_T(e_A, i, &gb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(e_A, &g_gpu_A);
          d2scaled = 1.0;
          abnrm = 0.0;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      d_A->size[0], xxx->size[1], d_A->size[1], (double *)
                      &d2scaled, (double *)&f_gpu_A.data[0], d_A->size[0],
                      (double *)&gpu_xxx.data[0], d_A->size[1], (double *)&abnrm,
                      (double *)&g_gpu_A.data[0], d_A->size[0]);
        }

        if ((X->size[1] == 0) || ((e_A->size[0] == 0) || (e_A->size[1] == 0))) {
          ntilecols = e_A->size[0];
          if (outsize_dirtyOnCpu) {
            cudaMemcpy(*gpu_outsize, outsize, 8UL, cudaMemcpyHostToDevice);
          }

          ecu_detrend_kernel207<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (ntilecols, *gpu_outsize);
          outsize_dirtyOnCpu = false;
          outsize_dirtyOnGpu = true;
          i = X->size[0] * X->size[1];
          X->size[0] = 1;
          X->size[1] = e_A->size[0];
          emxEnsureCapacity_real_T(X, i, &qc_emlrtRTEI);
          if (!X_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(X, &gpu_X);
          }

          ecu_detrend_kernel208<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (*gpu_outsize, b_gpu_outsize);
          cudaMemcpy(&d_outsize, b_gpu_outsize, 4UL, cudaMemcpyDeviceToHost);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (d_outsize + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (X_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_X, X);
            }

            ecu_detrend_kernel209<<<grid, block>>>(b_gpu_outsize, gpu_X);
            X_dirtyOnCpu = false;
          }
        } else if (e_A->size[0] == e_A->size[1]) {
          i2 = e_A->size[1];
          i = ipiv_t->size[0];
          ipiv_t->size[0] = e_A->size[1];
          emxEnsureCapacity_int32_T(ipiv_t, i, &oc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(ipiv_t, &gpu_ipiv_t);
          cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), e_A->size[1],
            e_A->size[1], (double *)&g_gpu_A.data[0], e_A->size[1],
            getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(8);
          cusolverInitWorkspace();
          cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
          cusolverDnDgetrf(getCuSolverGlobalHandle(), e_A->size[1], e_A->size[1],
                           (double *)&g_gpu_A.data[0], e_A->size[1],
                           static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                           &gpu_ipiv_t.data[0], gpu_na);
          i = ipiv->size[0] * ipiv->size[1];
          ipiv->size[0] = 1;
          ipiv->size[1] = ipiv_t->size[0];
          emxEnsureCapacity_int32_T(ipiv, i, &rc_emlrtRTEI);
          if (!ipiv_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(ipiv, &gpu_ipiv);
          }

          cudaMemcpy(&na, gpu_na, 4UL, cudaMemcpyDeviceToHost);
          if (na < 0) {
            for (i = 0; i < 2; i++) {
              e_r[i] = e_A->size[i];
            }

            i = e_A->size[0] * e_A->size[1];
            e_A->size[0] = e_r[0];
            e_A->size[1] = e_r[1];
            emxEnsureCapacity_real_T(e_A, i, &uc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(e_A, &g_gpu_A);
            ntilecols = e_r[0] * e_r[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (ntilecols + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel205<<<grid, block>>>(ntilecols, g_gpu_A);
            }

            npages = ipiv->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (ipiv_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_ipiv, ipiv);
              }

              ecu_detrend_kernel206<<<grid, block>>>(npages, gpu_ipiv);
              ipiv_dirtyOnCpu = false;
              ipiv_dirtyOnGpu = true;
            }
          } else {
            npages = ipiv_t->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (ipiv_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_ipiv, ipiv);
              }

              ecu_detrend_kernel204<<<grid, block>>>(gpu_ipiv_t, npages,
                gpu_ipiv);
              ipiv_dirtyOnCpu = false;
              ipiv_dirtyOnGpu = true;
            }
          }

          d2scaled = 1.0;
          if (X_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_X, X);
          }

          cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N, CUBLAS_DIAG_NON_UNIT,
                      1, i2, (double *)&d2scaled, (double *)&g_gpu_A.data[0], i2,
                      (double *)&gpu_X.data[0], 1);
          d2scaled = 1.0;
          cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                      i2, (double *)&d2scaled, (double *)&g_gpu_A.data[0], i2,
                      (double *)&gpu_X.data[0], 1);
          X_dirtyOnCpu = false;
          y_dirtyOnGpu = true;
          for (ntilecols = 0; ntilecols <= i2 - 2; ntilecols++) {
            npages = (i2 - ntilecols) - 2;
            if (ipiv_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(ipiv, &gpu_ipiv);
            }

            ipiv_dirtyOnGpu = false;
            if (ipiv->data[npages] != npages + 1) {
              if (y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(X, &gpu_X);
              }

              d2scaled = X->data[npages];
              X->data[npages] = X->data[ipiv->data[npages] - 1];
              X->data[ipiv->data[npages] - 1] = d2scaled;
              ipiv_dirtyOnCpu = true;
              y_dirtyOnGpu = false;
              X_dirtyOnCpu = true;
            }
          }
        } else {
          ptrdiff_t k_info_t;
          int32_T b_dims_idx_0;
          boolean_T e_A_dirtyOnCpu;
          i = f_A->size[0] * f_A->size[1];
          f_A->size[0] = e_A->size[1];
          f_A->size[1] = e_A->size[0];
          emxEnsureCapacity_real_T(f_A, i, &pc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_A, &h_gpu_A);
          nx = e_A->size[0] - 1;
          x_dim0 = e_A->size[1] - 1;
          ntilecols = f_A->size[0];
          o_x = e_A->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((x_dim0 + 1L) * (nx + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecu_detrend_kernel194<<<grid, block>>>(g_gpu_A, x_dim0, nx,
              ntilecols, o_x, h_gpu_A);
            d_A_dirtyOnGpu = true;
          }

          i = B->size[0];
          B->size[0] = X->size[1];
          emxEnsureCapacity_real_T(B, i, &sc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(B, &gpu_B);
          x_dim0 = X->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (X_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_X, X);
            }

            X_dirtyOnCpu = false;
            ecu_detrend_kernel195<<<grid, block>>>(gpu_X, x_dim0, gpu_B);
          }

          npages = f_A->size[0];
          na = f_A->size[1] - 1;
          y_dirtyOnGpu = true;
          i = jpvt->size[0] * jpvt->size[1];
          jpvt->size[0] = 1;
          jpvt->size[1] = f_A->size[1];
          emxEnsureCapacity_int32_T(jpvt, i, &vc_emlrtRTEI);
          if (!jpvt_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(jpvt, &gpu_jpvt);
          }

          nx = f_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, jpvt);
            }

            ecu_detrend_kernel196<<<grid, block>>>(nx, gpu_jpvt);
            jpvt_dirtyOnCpu = false;
            jpvt_dirtyOnGpu = true;
          }

          i2 = f_A->size[0];
          nx = f_A->size[1];
          if (i2 <= nx) {
            nx = i2;
          }

          i = c_tau->size[0];
          c_tau->size[0] = nx;
          emxEnsureCapacity_real_T(c_tau, i, &wc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_tau, &gpu_tau);
          i = jpvt_t->size[0];
          jpvt_t->size[0] = f_A->size[1];
          emxEnsureCapacity_ptrdiff_t(jpvt_t, i, &xc_emlrtRTEI);
          for (i = 0; i < f_A->size[1]; i++) {
            jpvt_t->data[i] = (ptrdiff_t)0;
          }

          if (d_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(f_A, &h_gpu_A);
          }

          if (tau_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_tau, &gpu_tau);
          }

          k_info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)f_A->size[0], (ptrdiff_t)
            f_A->size[1], &f_A->data[0], (ptrdiff_t)f_A->size[0], &jpvt_t->data
            [0], &c_tau->data[0]);
          tau_dirtyOnGpu = false;
          b_y = true;
          d_A_dirtyOnGpu = false;
          e_A_dirtyOnCpu = true;
          if ((int32_T)k_info_t != 0) {
            ntilecols = f_A->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (((npages - 1) + 1L) * (na + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
              y_dirtyOnGpu = false;
              gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_A, f_A);
              ecu_detrend_kernel197<<<grid, block>>>(npages, gpu_na, ntilecols,
                h_gpu_A);
              e_A_dirtyOnCpu = false;
              d_A_dirtyOnGpu = true;
            }

            i2 = f_A->size[0];
            ntilecols = f_A->size[1];
            if (i2 <= ntilecols) {
              ntilecols = i2;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((ntilecols - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, c_tau);
              ecu_detrend_kernel198<<<grid, block>>>(ntilecols, gpu_tau);
              b_y = false;
              tau_dirtyOnGpu = true;
            }

            if ((nx - ntilecols) - 1 >= 0) {
              if (tau_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_tau, &gpu_tau);
              }

              std::memset(&c_tau->data[ntilecols], 0, static_cast<uint32_T>((nx
                - (ntilecols + 1)) + 1) * sizeof(real_T));
              tau_dirtyOnGpu = false;
              b_y = true;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (y_dirtyOnGpu) {
                cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
              }

              if (jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, jpvt);
              }

              ecu_detrend_kernel199<<<grid, block>>>(gpu_na, gpu_jpvt);
              jpvt_dirtyOnCpu = false;
              jpvt_dirtyOnGpu = true;
            }
          } else {
            for (o_x = 0; o_x <= na; o_x++) {
              if (jpvt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(jpvt, &gpu_jpvt);
              }

              jpvt->data[o_x] = (int32_T)jpvt_t->data[o_x];
              jpvt_dirtyOnGpu = false;
              jpvt_dirtyOnCpu = true;
            }
          }

          nx = 0;
          if (f_A->size[0] < f_A->size[1]) {
            ntilecols = f_A->size[0];
            npages = f_A->size[1];
          } else {
            ntilecols = f_A->size[1];
            npages = f_A->size[0];
          }

          if (d_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(f_A, &h_gpu_A);
          }

          d_A_dirtyOnGpu = false;
          d2scaled = std::fmin(1.4901161193847656E-8, 2.2204460492503131E-15 *
                               static_cast<real_T>(npages)) * std::abs(f_A->
            data[0]);
          while ((nx < ntilecols) && (!(std::abs(f_A->data[nx + f_A->size[0] *
                    nx]) <= d2scaled))) {
            nx++;
          }

          b_dims_idx_0 = f_A->size[1];
          i = Y->size[0];
          Y->size[0] = f_A->size[1];
          emxEnsureCapacity_real_T(Y, i, &yc_emlrtRTEI);
          if (!Y_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(Y, &gpu_Y);
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((b_dims_idx_0 - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, Y);
            }

            ecu_detrend_kernel200<<<grid, block>>>(b_dims_idx_0, gpu_Y);
            Y_dirtyOnCpu = false;
            Y_dirtyOnGpu = true;
          }

          na = 0;
          i2 = f_A->size[0];
          npages = f_A->size[1];
          if (i2 <= npages) {
            npages = i2;
          }

          if (e_A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_A, f_A);
          }

          if (b_y) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, c_tau);
          }

          cusolverDnDormqr_bufferSize(getCuSolverGlobalHandle(),
            CUBLAS_SIDE_LEFT, CUBLAS_OP_T, B->size[0], 1, npages, (double *)
            &h_gpu_A.data[0], f_A->size[0], (double *)&gpu_tau.data[0], (double *)
            &gpu_B.data[0], B->size[0], getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(8);
          cusolverInitWorkspace();
          cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
          cusolverDnDormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                           CUBLAS_OP_T, B->size[0], 1, npages, (double *)
                           &h_gpu_A.data[0], f_A->size[0], (double *)
                           &gpu_tau.data[0], (double *)&gpu_B.data[0], B->size[0],
                           static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                           *getCuSolverWorkspaceReq(), gpu_na);
          cudaMemcpy(&na, gpu_na, 4UL, cudaMemcpyDeviceToHost);
          if (na < 0) {
            npages = B->size[0];
            i = B->size[0];
            B->size[0] = npages;
            emxEnsureCapacity_real_T(B, i, &ad_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(B, &gpu_B);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel201<<<grid, block>>>(npages, gpu_B);
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

            ecu_detrend_kernel202<<<grid, block>>>(gpu_B, gpu_jpvt, nx, gpu_Y);
            Y_dirtyOnCpu = false;
            Y_dirtyOnGpu = true;
          }

          for (ntilecols = 0; ntilecols < nx; ntilecols++) {
            npages = (nx - ntilecols) - 1;
            if (Y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(Y, &gpu_Y);
            }

            if (jpvt_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(jpvt, &gpu_jpvt);
            }

            Y->data[jpvt->data[npages] - 1] /= f_A->data[npages + f_A->size[0] *
              npages];
            jpvt_dirtyOnGpu = false;
            jpvt_dirtyOnCpu = true;
            Y_dirtyOnGpu = false;
            Y_dirtyOnCpu = true;
            for (o_x = 0; o_x < npages; o_x++) {
              Y->data[jpvt->data[o_x] - 1] -= Y->data[jpvt->data[npages] - 1] *
                f_A->data[o_x + f_A->size[0] * npages];
            }
          }

          i = X->size[0] * X->size[1];
          X->size[0] = 1;
          X->size[1] = Y->size[0];
          emxEnsureCapacity_real_T(X, i, &qc_emlrtRTEI);
          if (!X_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(X, &gpu_X);
          }

          x_dim0 = Y->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, Y);
            }

            Y_dirtyOnCpu = false;
            if (X_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_X, X);
            }

            ecu_detrend_kernel203<<<grid, block>>>(gpu_Y, x_dim0, gpu_X);
            X_dirtyOnCpu = false;
          }
        }

        // 'ec_detrendCompute:251' z = demean_lfn(x,w)*topcs*b;
        i = g_ww->size[0];
        g_ww->size[0] = b_w->size[0];
        emxEnsureCapacity_boolean_T(g_ww, i, &tc_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(g_ww, &g_gpu_ww);
        x_dim0 = b_w->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0 +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_w_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
          }

          b_w_dirtyOnCpu = false;
          ecu_detrend_kernel210<<<grid, block>>>(b_gpu_w, x_dim0, g_gpu_ww);
          g_ww_dirtyOnGpu = true;
        }

        //  if isempty(w)
        //      % simple regression
        //      xx = demean_lfn(x);
        //      yy = demean_lfn(y);
        //      [V,D] = eig(xx'*xx);
        //      V = real(V);
        //      D = real(D);
        //      topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
        //      xxx = xx*topcs;
        //      b = ((yy'*xxx) / (xxx'*xxx))';
        //      z = demean_lfn(x,w)*topcs*b;
        //      z = z + mn;
        //  else
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //  [y,mn]=nt_demean(x,w) - remove weighted mean over cols
        //
        //  If w is a vector with fewer samples than size(x,1), it is interpreted as
        //  a vector of indices to be set to 1, the others being set to 0.
        // 'ec_detrendCompute:297' [m,n] = size(x);
        // 'ec_detrendCompute:299' if ~isempty(w) && numel(w)<m
        i = b_w->size[0];
        if ((b_w->size[0] != 0) && (b_w->size[0] < r->size[0])) {
          // 'ec_detrendCompute:300' w=w(:);
          //  interpret w as array of indices to set to 1
          // 'ec_detrendCompute:302' if min(w)<1 || max(w)>m
          if (b_w_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
          }

          b_w_dirtyOnGpu = false;
          b_y = b_w->data[0];
          for (o_x = 0; o_x <= i - 2; o_x++) {
            if (static_cast<int32_T>(b_y) > static_cast<int32_T>(b_w->data[o_x +
                 1])) {
              b_y = b_w->data[o_x + 1];
            }
          }

          if (!b_y) {
            // 'ec_detrendCompute:303' error('w interpreted as indices but values are out of range');
            ob_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv27[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 52, m1, &varargin_1[0]);
            emlrtAssign(&ob_y, m1);
            b_error(ob_y, &emlrtMCI);
          }

          // 'ec_detrendCompute:305' ww = false(m,1);
          i = g_ww->size[0];
          g_ww->size[0] = r->size[0];
          emxEnsureCapacity_boolean_T(g_ww, i, &s_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(g_ww, &g_gpu_ww);
          i = r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecu_detrend_kernel211<<<grid, block>>>(i, g_gpu_ww);
            g_ww_dirtyOnGpu = true;
          }

          // 'ec_detrendCompute:306' ww(w) = true;
          na = b_w->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
            ecu_detrend_kernel212<<<grid, block>>>(b_gpu_w, gpu_na, g_gpu_ww);
            g_ww_dirtyOnGpu = true;
          }

          // 'ec_detrendCompute:307' w = ww;
        }

        //  if size(w,3)~=p
        //      if size(w,3)==1 && p~=1
        //          w = repmat(w,[1,1,p]);
        //      else
        //          error('W should have same npages as X, or else 1');
        //      end
        //  end
        // if p>1; x = unfold_lfn(x); end
        // 'ec_detrendCompute:319' if isempty(w)
        if (g_ww->size[0] == 0) {
          // 'ec_detrendCompute:320' mn = mean(x,1);
          i2 = r->size[0];
          if ((r->size[0] == 0) || (r->size[1] == 0)) {
            for (i = 0; i < 2; i++) {
              if (outsize_dirtyOnGpu) {
                cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
              }

              outsize[i] = static_cast<uint32_T>(r->size[i]);
              outsize_dirtyOnGpu = false;
              outsize_dirtyOnCpu = true;
            }

            i = j_y->size[0] * j_y->size[1];
            j_y->size[0] = 1;
            if (outsize_dirtyOnGpu) {
              cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
            }

            j_y->size[1] = static_cast<int32_T>(outsize[1]);
            emxEnsureCapacity_real_T(j_y, i, &bb_emlrtRTEI);
            if (!e_y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(j_y, &f_gpu_y);
            }

            outsize_dirtyOnGpu = false;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(outsize[1]) - 1) + 1L), &grid, &block, 1024U,
              65535U);
            if (validLaunchParams) {
              if (e_y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_y, j_y);
              }

              ecu_detrend_kernel216<<<grid, block>>>(static_cast<int32_T>
                (outsize[1]) - 1, f_gpu_y);
              e_y_dirtyOnCpu = false;
              f_y_dirtyOnGpu = true;
            }
          } else {
            i = j_y->size[0] * j_y->size[1];
            j_y->size[0] = 1;
            j_y->size[1] = 1;
            emxEnsureCapacity_real_T(j_y, i, &ab_emlrtRTEI);
            if (!e_y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(j_y, &f_gpu_y);
            }

            if (f_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(j_y, &f_gpu_y);
            }

            if (r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
            }

            r_dirtyOnGpu = false;
            j_y->data[0] = r->data[0];
            f_y_dirtyOnGpu = false;
            e_y_dirtyOnCpu = true;
            for (na = 0; na <= i2 - 2; na++) {
              j_y->data[0] += r->data[na + 1];
            }
          }

          // 'ec_detrendCompute:321' x = x - mn;
          if (r->size[1] == j_y->size[1]) {
            npages = r->size[0];
            i = l_x->size[0] * l_x->size[1];
            l_x->size[0] = r->size[0];
            l_x->size[1] = r->size[1];
            emxEnsureCapacity_real_T(l_x, i, &bd_emlrtRTEI);
            if (!k_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(l_x, &k_gpu_x);
            }

            i = r->size[1] - 1;
            nx = r->size[0] - 1;
            x_dim0 = l_x->size[0];
            ntilecols = r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx
              + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (e_y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_y, j_y);
              }

              e_y_dirtyOnCpu = false;
              if (k_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&k_gpu_x, l_x);
              }

              ecu_detrend_kernel217<<<grid, block>>>(npages, f_gpu_y, gpu_r, nx,
                i, x_dim0, ntilecols, k_gpu_x);
              k_x_dirtyOnCpu = false;
              k_x_dirtyOnGpu = true;
            }
          } else {
            if (k_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_x, &k_gpu_x);
            }

            if (r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
            }

            r_dirtyOnGpu = false;
            if (f_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(j_y, &f_gpu_y);
            }

            f_y_dirtyOnGpu = false;
            b_binary_expand_op(l_x, r, j_y);
            k_x_dirtyOnGpu = false;
            k_x_dirtyOnCpu = true;
          }

          // vecadd_lfn(x,-mn);
        } else {
          // 'ec_detrendCompute:322' else
          // if p>1; w = unfold_lfn(w); end
          // 'ec_detrendCompute:324' if size(w,1)~=size(x,1)
          if (g_ww->size[0] != r->size[0]) {
            // 'ec_detrendCompute:324' ;
            // 'ec_detrendCompute:324' error('X and W should have same nrows');
            pb_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv28[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 30, m1, &b_varargin_1[0]);
            emlrtAssign(&pb_y, m1);
            b_error(pb_y, &emlrtMCI);
          }

          // 'ec_detrendCompute:325' if size(w,2)==1
          // 'ec_detrendCompute:326' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if (r->size[0] == g_ww->size[0]) {
            i = k_x->size[0] * k_x->size[1];
            k_x->size[0] = r->size[0];
            k_x->size[1] = r->size[1];
            emxEnsureCapacity_real_T(k_x, i, &t_emlrtRTEI);
            if (!j_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(k_x, &j_gpu_x);
            }

            i = r->size[1] - 1;
            nx = r->size[0] - 1;
            x_dim0 = k_x->size[0];
            ntilecols = r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx
              + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (j_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_x, k_x);
              }

              ecu_detrend_kernel213<<<grid, block>>>(g_gpu_ww, gpu_r, nx, i,
                x_dim0, ntilecols, j_gpu_x);
              j_x_dirtyOnCpu = false;
              j_x_dirtyOnGpu = true;
            }
          } else {
            if (j_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(k_x, &j_gpu_x);
            }

            if (r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
            }

            r_dirtyOnGpu = false;
            if (g_ww_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(g_ww, &g_gpu_ww);
            }

            g_ww_dirtyOnGpu = false;
            binary_expand_op(k_x, r, g_ww);
            j_x_dirtyOnGpu = false;
            j_x_dirtyOnCpu = true;
          }

          i2 = k_x->size[0];
          if ((k_x->size[0] == 0) || (k_x->size[1] == 0)) {
            for (i = 0; i < 2; i++) {
              if (outsize_dirtyOnGpu) {
                cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
              }

              outsize[i] = static_cast<uint32_T>(k_x->size[i]);
              outsize_dirtyOnGpu = false;
              outsize_dirtyOnCpu = true;
            }

            i = k_y->size[0] * k_y->size[1];
            k_y->size[0] = 1;
            if (outsize_dirtyOnGpu) {
              cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
            }

            k_y->size[1] = static_cast<int32_T>(outsize[1]);
            emxEnsureCapacity_real_T(k_y, i, &db_emlrtRTEI);
            if (!f_y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(k_y, &g_gpu_y);
            }

            outsize_dirtyOnGpu = false;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(outsize[1]) - 1) + 1L), &grid, &block, 1024U,
              65535U);
            if (validLaunchParams) {
              if (f_y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_y, k_y);
              }

              ecu_detrend_kernel214<<<grid, block>>>(static_cast<int32_T>
                (outsize[1]) - 1, g_gpu_y);
              f_y_dirtyOnCpu = false;
              g_y_dirtyOnGpu = true;
            }
          } else {
            i = k_y->size[0] * k_y->size[1];
            k_y->size[0] = 1;
            k_y->size[1] = 1;
            emxEnsureCapacity_real_T(k_y, i, &ab_emlrtRTEI);
            if (!f_y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(k_y, &g_gpu_y);
            }

            if (g_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(k_y, &g_gpu_y);
            }

            if (j_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(k_x, &j_gpu_x);
            }

            j_x_dirtyOnGpu = false;
            k_y->data[0] = k_x->data[0];
            g_y_dirtyOnGpu = false;
            f_y_dirtyOnCpu = true;
            for (na = 0; na <= i2 - 2; na++) {
              k_y->data[0] += k_x->data[na + 1];
            }
          }

          i2 = g_ww->size[0];
          if (g_ww_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(g_ww, &g_gpu_ww);
          }

          g_ww_dirtyOnGpu = false;
          npages = g_ww->data[0];
          for (o_x = 0; o_x <= i2 - 2; o_x++) {
            npages += g_ww->data[o_x + 1];
          }

          // sum(vecmult_lfn(x),w),1) ./ (sum(w,1)+eps);
          // 'ec_detrendCompute:332' x = x - mn;
          if (r->size[1] == k_y->size[1]) {
            d2scaled = static_cast<real_T>(npages) + 2.2204460492503131E-16;
            i = l_x->size[0] * l_x->size[1];
            l_x->size[0] = r->size[0];
            l_x->size[1] = r->size[1];
            emxEnsureCapacity_real_T(l_x, i, &cd_emlrtRTEI);
            if (!k_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(l_x, &k_gpu_x);
            }

            i = r->size[1] - 1;
            nx = r->size[0] - 1;
            x_dim0 = l_x->size[0];
            ntilecols = r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nx
              + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (f_y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_y, k_y);
              }

              f_y_dirtyOnCpu = false;
              cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
              if (k_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&k_gpu_x, l_x);
              }

              ecu_detrend_kernel215<<<grid, block>>>(g_gpu_y, gpu_r, nx, i,
                x_dim0, ntilecols, gpu_d2scaled, k_gpu_x);
              k_x_dirtyOnCpu = false;
              k_x_dirtyOnGpu = true;
            }
          } else {
            if (k_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_x, &k_gpu_x);
            }

            if (r_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
            }

            r_dirtyOnGpu = false;
            if (g_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(k_y, &g_gpu_y);
            }

            g_y_dirtyOnGpu = false;
            binary_expand_op(l_x, r, k_y, npages);
            k_x_dirtyOnGpu = false;
            k_x_dirtyOnCpu = true;
          }

          // x = vecadd_lfn(x,-mn);
        }

        if ((l_x->size[0] == 0) || (l_x->size[1] == 0) || (topcs->size[0] == 0) ||
            (topcs->size[1] == 0)) {
          i = l_y->size[0] * l_y->size[1];
          l_y->size[0] = l_x->size[0];
          l_y->size[1] = topcs->size[1];
          emxEnsureCapacity_real_T(l_y, i, &hb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(l_y, &h_gpu_y);
          o_x = l_x->size[0] * topcs->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecu_detrend_kernel218<<<grid, block>>>(o_x, h_gpu_y);
          }
        } else {
          i = l_y->size[0] * l_y->size[1];
          l_y->size[0] = l_x->size[0];
          l_y->size[1] = topcs->size[1];
          emxEnsureCapacity_real_T(l_y, i, &gb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(l_y, &h_gpu_y);
          d2scaled = 1.0;
          abnrm = 0.0;
          if (k_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&k_gpu_x, l_x);
          }

          k_x_dirtyOnCpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      l_x->size[0], topcs->size[1], 1, (double *)&d2scaled,
                      (double *)&k_gpu_x.data[0], l_x->size[0], (double *)
                      &gpu_topcs.data[0], 1, (double *)&abnrm, (double *)
                      &h_gpu_y.data[0], l_x->size[0]);
        }

        i = b_B->size[0];
        b_B->size[0] = X->size[1];
        emxEnsureCapacity_real_T(b_B, i, &dd_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_B, &c_gpu_B);
        x_dim0 = X->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0 +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (X_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_X, X);
          }

          X_dirtyOnCpu = false;
          ecu_detrend_kernel219<<<grid, block>>>(gpu_X, x_dim0, c_gpu_B);
        }

        if ((l_y->size[0] == 0) || (l_y->size[1] == 0) || (b_B->size[0] == 0)) {
          i = d_x->size[0];
          d_x->size[0] = l_y->size[0];
          emxEnsureCapacity_real_T(d_x, i, &ed_emlrtRTEI);
          if (!c_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(d_x, &c_gpu_x);
          }

          x_dim0 = l_y->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, d_x);
            }

            ecu_detrend_kernel220<<<grid, block>>>(x_dim0, c_gpu_x);
            c_x_dirtyOnCpu = false;
            c_x_dirtyOnGpu = true;
          }
        } else {
          i = d_x->size[0];
          d_x->size[0] = l_y->size[0];
          emxEnsureCapacity_real_T(d_x, i, &gb_emlrtRTEI);
          if (!c_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(d_x, &c_gpu_x);
          }

          d2scaled = 1.0;
          abnrm = 0.0;
          if (c_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, d_x);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      l_y->size[0], 1, l_y->size[1], (double *)&d2scaled,
                      (double *)&h_gpu_y.data[0], l_y->size[0], (double *)
                      &c_gpu_B.data[0], l_y->size[1], (double *)&abnrm, (double *)
                      &c_gpu_x.data[0], l_y->size[0]);
          c_x_dirtyOnCpu = false;
          c_x_dirtyOnGpu = true;
        }

        // 'ec_detrendCompute:252' z = z + mn;
        if (dv1->size[0] == 1) {
          o_x = dv4->size[0];
        } else {
          o_x = dv1->size[0];
        }

        if ((dv1->size[0] == dv4->size[0]) && (d_x->size[0] == o_x)) {
          o_x = d_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (dv1_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
            }

            dv1_dirtyOnCpu = false;
            if (c_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, d_x);
            }

            ecu_detrend_kernel221<<<grid, block>>>(gpu_dv4, gpu_dv1, o_x,
              c_gpu_x);
            c_x_dirtyOnCpu = false;
            c_x_dirtyOnGpu = true;
          }
        } else {
          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_x, &c_gpu_x);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (dv4_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv4, &gpu_dv4);
          }

          dv4_dirtyOnGpu = false;
          binary_expand_op(d_x, dv1, dv4);
          c_x_dirtyOnGpu = false;
          c_x_dirtyOnCpu = true;
        }

        // 'ec_detrendCompute:273' z = fold_lfn(z,m);
        // if p>1; x = fold_lfn(x,m); end
        //  Fold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //   y=fold(x,epochsize) - fold 2D to 3D
        //
        //   y: 3D matrix of (time * channel * trial)
        //
        //   x: 2D matrix of concatentated data (time * channel)
        //   epochsize: number of samples in each trial
        // 'ec_detrendCompute:347' x = unfold_lfn(x);
        //  Unfold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // y=nt_fold(x) - unfold 3D to 2D
        //
        //   y: 2D matrix of concatentated data (time * channel)
        //
        //   x: 3D matrix of (time * channel * trial)
        //
        //  NoiseTools
        // 'ec_detrendCompute:372' if ~isempty(x) && numel(size(x))>=3
        //  Depreciated
        //  % Vector Add %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //  function x = vecadd_lfn(x,v)
        //  %y=nt_vecadd(x,v) - add vector to all rows or columns of matrix
        //  %
        //  % See vecmult, bsxfun
        //  %
        //  % NoiseTools
        //
        //  [m,~,~]=size(x);
        //  x=unfold_lfn(x);
        //  v=unfold_lfn(v);
        //
        //  [mm,nn]=size(x);
        //  if numel(v)==1;
        //      x=x+v;
        //  elseif size(v,1)==1
        //      if size(v,2)~=nn; error('V should have same number of columns as X'); end
        //      if bsxfun_exists;
        //          x=bsxfun(@plus,x,v);
        //          %        vecop_core(x, v, 2, 1);  % 1 is the opcode of addition in vecop_core
        //      else
        //          x=x + repmat(v,mm,1);
        //      end
        //  elseif size(v,2)==1
        //      if size(v,1)~=mm; error('V should have same number of rows as X'); end
        //      if bsxfun_exists;
        //          x=bsxfun(@plus,x,v);
        //          %       y=vecop_core(x, v, 1, 1);  % 1 is the opcode of addition in vecop_core
        //      else
        //          x=x + repmat(v,1,nn);
        //      end
        //  end
        //  x=nt_fold(x,m);
        //
        //  % Vector multiplication %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //  function x = vecmult_lfn(x,v)
        //  %y=nt_vecmult(x,v) - multiply all rows or columns of matrix by vector
        //  %
        //  % See vecadd, bsxfun
        //  %
        //  % NoiseTools
        //
        //  % check once and for all to save time
        //  persistent bsxfun_exists;
        //  if isempty(bsxfun_exists); bsxfun_exists=(exist('bsxfun')==5); end
        //
        //  [m,n,o]=size(x);
        //  x=nt_unfold(x);
        //  v=nt_unfold(v);
        //
        //  [mm,nn]=size(x);
        //  [mv,nv]=size(v);
        //  if mv==mm
        //      % same number of rows, v should be column vector (or same size as x)
        //      if nv==nn
        //          x=x.*v;
        //      elseif nv==1
        //          if bsxfun_exists;
        //              x=bsxfun(@times,x,v);
        //              %y=vecop_core(x, v, 1, 2);  % 2 is the opcode of multiplication in vecop_core
        //          else
        //              x=x .* repmat(v,1,nn);
        //          end
        //      else
        //          error('V should be row vector');
        //      end
        //
        //  elseif nv==nn
        //      % same number of columns, v should be row vector (or same size as x)
        //      if mv==mm
        //          x=x.*v;
        //      elseif mv==1
        //          if bsxfun_exists;
        //              x=bsxfun(@times,x,v);
        //              %y=vecop_core(x, v, 2, 2);  % 2 is the opcode of multiplication in vecop_core
        //          else
        //              x=x .* repmat(v,mm,1);
        //          end
        //      else
        //          error('V should be column vector');
        //      end
        //
        //  else
        //      error('V and X should have same number of rows or columns');
        //  end
        //  x=nt_fold(x,m);
        //  in case it was already folded
        // 'ec_detrendCompute:348' if ~isempty(x)
        if (d_x->size[0] != 0) {
          real_T nepochs;

          // 'ec_detrendCompute:349' nepochs = size(x,1)/N;
          i = x->size[0];
          nepochs = static_cast<real_T>(d_x->size[0]) / static_cast<real_T>(i);

          // 'ec_detrendCompute:350' if nepochs~=round(nepochs)
          if (nepochs != std::round(nepochs)) {
            // 'ec_detrendCompute:351' nepochs = floor(nepochs);
            nepochs = std::floor(nepochs);

            // 'ec_detrendCompute:352' x = x(1:N*nepochs,:);
            d2scaled = static_cast<real_T>(i) * nepochs;
            i = d_x->size[0];
            if (d2scaled < 1.0) {
              d_x->size[0] = 0;
            } else {
              d_x->size[0] = static_cast<int32_T>(d2scaled);
            }

            emxEnsureCapacity_real_T(d_x, i, &ed_emlrtRTEI);
            if (!c_x_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(d_x, &c_gpu_x);
            }

            // 'ec_detrendCompute:353' disp('nsamples not multiple of epoch size, truncating...');
            sb_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv33[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 50, m1, &c_u[0]);
            emlrtAssign(&sb_y, m1);
            disp(sb_y, &b_emlrtMCI);
          }

          // if nepochs>1
          //     x = permute(reshape(x,[N, size(x,1)/N, size(x,2)]), [1 3 2]);
          // end
        }

        //  find outliers
        // 'ec_detrendCompute:122' d = x-y;
        if (dv1->size[0] == d_x->size[0]) {
          i = c_d->size[0];
          c_d->size[0] = dv1->size[0];
          emxEnsureCapacity_real_T(c_d, i, &id_emlrtRTEI);
          if (!d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(c_d, &gpu_d);
          }

          o_x = dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, d_x);
            }

            c_x_dirtyOnCpu = false;
            if (dv1_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
            }

            dv1_dirtyOnCpu = false;
            if (d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, c_d);
            }

            ecu_detrend_kernel222<<<grid, block>>>(c_gpu_x, gpu_dv1, o_x, gpu_d);
            d_dirtyOnCpu = false;
            d_dirtyOnGpu = true;
          }
        } else {
          if (d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_d, &gpu_d);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_x, &c_gpu_x);
          }

          c_x_dirtyOnGpu = false;
          minus(c_d, dv1, d_x);
          d_dirtyOnGpu = false;
          d_dirtyOnCpu = true;
        }

        // 'ec_detrendCompute:123' if ~isempty(w)
        if (b_w->size[0] != 0) {
          // 'ec_detrendCompute:123' ;
          // 'ec_detrendCompute:123' d = d.*w;
          if (c_d->size[0] == b_w->size[0]) {
            o_x = c_d->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_w_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
              }

              b_w_dirtyOnCpu = false;
              if (d_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, c_d);
              }

              ecu_detrend_kernel223<<<grid, block>>>(b_gpu_w, o_x, gpu_d);
              d_dirtyOnCpu = false;
              d_dirtyOnGpu = true;
            }
          } else {
            if (d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_d, &gpu_d);
            }

            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            binary_expand_op(c_d, b_w);
            d_dirtyOnGpu = false;
            d_dirtyOnCpu = true;
          }
        }

        // 'ec_detrendCompute:124' ww = true(dims);
        i = i_ww->size[0];
        i_ww->size[0] = static_cast<int32_T>(dims_idx_0);
        emxEnsureCapacity_boolean_T(i_ww, i, &jd_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(i_ww, &i_gpu_ww);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(dims_idx_0) - 1) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          ecu_detrend_kernel224<<<grid, block>>>(dims_idx_0, i_gpu_ww);
          i_ww_dirtyOnGpu = true;
        }

        // 'ec_detrendCompute:125' ww(abs(d) > thresh * repmat(std(d),dims(1),1)) = false;
        nx = c_d->size[0] - 1;
        i = dv20->size[0];
        dv20->size[0] = c_d->size[0];
        emxEnsureCapacity_real_T(dv20, i, &kd_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(dv20, &gpu_dv20);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, c_d);
          }

          d_dirtyOnCpu = false;
          ecu_detrend_kernel225<<<grid, block>>>(gpu_d, nx, gpu_dv20);
          dv20_dirtyOnGpu = true;
        }

        i2 = c_d->size[0] - 2;
        if (c_d->size[0] == 0) {
          d2scaled = rtNaN;
        } else if (c_d->size[0] == 1) {
          if (d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_d, &gpu_d);
          }

          d_dirtyOnGpu = false;
          if ((!std::isinf(c_d->data[0])) && (!std::isnan(c_d->data[0]))) {
            d2scaled = 0.0;
          } else {
            d2scaled = rtNaN;
          }
        } else {
          if (d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_d, &gpu_d);
          }

          d_dirtyOnGpu = false;
          d2scaled = c_d->data[0];
          for (o_x = 0; o_x <= i2; o_x++) {
            d2scaled += c_d->data[o_x + 1];
          }

          d2scaled /= static_cast<real_T>(c_d->size[0]);
          i = absdiff->size[0];
          absdiff->size[0] = c_d->size[0];
          emxEnsureCapacity_real_T(absdiff, i, &md_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(absdiff, &gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i2 +
            1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, c_d);
            }

            d_dirtyOnCpu = false;
            cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
            ecu_detrend_kernel226<<<grid, block>>>(gpu_d, i2, gpu_d2scaled,
              gpu_absdiff);
            cudaMemcpy(&d2scaled, gpu_d2scaled, 8UL, cudaMemcpyDeviceToHost);
          }

          cublasDnrm2(getCublasGlobalHandle(), c_d->size[0], (double *)
                      &gpu_absdiff.data[0], 1, (double *)&d2scaled);
          d2scaled /= std::sqrt(static_cast<real_T>(c_d->size[0]) - 1.0);
        }

        if (dv20->size[0] == static_cast<int32_T>(dims_idx_0)) {
          i = bv6->size[0];
          bv6->size[0] = dv20->size[0];
          emxEnsureCapacity_boolean_T(bv6, i, &ld_emlrtRTEI);
          if (!bv6_dirtyOnCpu) {
            gpuEmxEnsureCapacity_boolean_T(bv6, &gpu_bv6);
          }

          o_x = dv20->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
            if (bv6_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&gpu_bv6, bv6);
            }

            ecu_detrend_kernel227<<<grid, block>>>(thresh, gpu_dv20, o_x,
              gpu_d2scaled, gpu_bv6);
            bv6_dirtyOnCpu = false;
            bv6_dirtyOnGpu = true;
          }
        } else {
          if (bv6_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv6, &gpu_bv6);
          }

          if (dv20_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv20, &gpu_dv20);
          }

          dv20_dirtyOnGpu = false;
          binary_expand_op(bv6, dv20, thresh, d2scaled, c_outsize);
          bv6_dirtyOnGpu = false;
          bv6_dirtyOnCpu = true;
        }

        na = bv6->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (bv6_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_boolean_T(&gpu_bv6, bv6);
          }

          bv6_dirtyOnCpu = false;
          cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
          ecu_detrend_kernel228<<<grid, block>>>(gpu_bv6, gpu_na, i_gpu_ww);
          i_ww_dirtyOnGpu = true;
        }

        //  update weights
        // 'ec_detrendCompute:128' if isempty(w)
        if (b_w->size[0] == 0) {
          // 'ec_detrendCompute:129' w = ww;
          i = b_w->size[0];
          b_w->size[0] = i_ww->size[0];
          emxEnsureCapacity_boolean_T(b_w, i, &nd_emlrtRTEI);
          if (!b_w_dirtyOnCpu) {
            gpuEmxEnsureCapacity_boolean_T(b_w, &b_gpu_w);
          }

          o_x = i_ww->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            ecu_detrend_kernel231<<<grid, block>>>(i_gpu_ww, o_x, b_gpu_w);
            b_w_dirtyOnCpu = false;
            b_w_dirtyOnGpu = true;
          }
        } else {
          // 'ec_detrendCompute:130' else
          // 'ec_detrendCompute:131' w = min(w,ww);
          i = b_a->size[0];
          b_a->size[0] = b_w->size[0];
          emxEnsureCapacity_boolean_T(b_a, i, &od_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(b_a, &gpu_a);
          x_dim0 = b_w->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            ecu_detrend_kernel229<<<grid, block>>>(b_gpu_w, x_dim0, gpu_a);
          }

          if (b_w->size[0] == i_ww->size[0]) {
            i2 = b_a->size[0];
            npages = i_ww->size[0];
            if (i2 <= npages) {
              npages = i2;
            }

            i = b_w->size[0];
            b_w->size[0] = npages;
            emxEnsureCapacity_boolean_T(b_w, i, &o_emlrtRTEI);
            if (!b_w_dirtyOnCpu) {
              gpuEmxEnsureCapacity_boolean_T(b_w, &b_gpu_w);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_w_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
              }

              ecu_detrend_kernel230<<<grid, block>>>(i_gpu_ww, gpu_a, npages - 1,
                b_gpu_w);
              b_w_dirtyOnCpu = false;
              b_w_dirtyOnGpu = true;
            }
          } else {
            i = d_w->size[0];
            d_w->size[0] = b_w->size[0];
            emxEnsureCapacity_boolean_T(d_w, i, &od_emlrtRTEI);
            npages = b_w->size[0] - 1;
            for (i = 0; i <= npages; i++) {
              if (b_w_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
              }

              b_w_dirtyOnGpu = false;
              d_w->data[i] = b_w->data[i];
            }

            if (i_ww_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(i_ww, &i_gpu_ww);
            }

            i_ww_dirtyOnGpu = false;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
            }

            coder::internal::expand_min(d_w, i_ww, b_w);
            b_w_dirtyOnGpu = false;
            b_w_dirtyOnCpu = true;
          }
        }
      }

      // 'ec_detrendCompute:134' y = x-y;
      i = x->size[0];
      if (i == d_x->size[0]) {
        npages = dv1->size[0];
        dv1->size[0] = i;
        emxEnsureCapacity_real_T(dv1, npages, &q_emlrtRTEI);
        if (!dv1_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(dv1, &gpu_dv1);
        }

        o_x = x->size[0] - 1;
        x_dim0 = x->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, d_x);
          }

          c_x_dirtyOnCpu = false;
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
          }

          x_dirtyOnCpu = false;
          if (dv1_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
          }

          ecu_detrend_kernel232<<<grid, block>>>(c_gpu_x, ch, gpu_x, o_x, x_dim0,
            gpu_dv1);
          dv1_dirtyOnCpu = false;
          dv1_dirtyOnGpu = true;
        }
      } else {
        if (dv1_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
        }

        if (x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
        }

        x_dirtyOnGpu = false;
        if (c_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(d_x, &c_gpu_x);
        }

        c_x_dirtyOnGpu = false;
        binary_expand_op(dv1, x, ch, d_x);
        dv1_dirtyOnGpu = false;
        dv1_dirtyOnCpu = true;
      }
    } else {
      real_T b_wsize;
      int32_T i1;
      uint32_T dims_idx_0;

      // 'ec_detrendCompute:40' else
      //  Overlapping window detrending
      // 'ec_detrendCompute:42' [x,w] = ec_detrendWin_lfn(x,order,thresh,niter,wsize,w,basis);
      //  Detrend across overlapping time windows %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      // 'ec_detrendCompute:140' dims = size(x);
      i = x->size[0];
      dims_idx_0 = static_cast<uint32_T>(i);

      // 'ec_detrendCompute:141' wsize = 2*floor(wsize/2);
      b_wsize = 2.0 * std::floor(wsize / 2.0);

      // 'ec_detrendCompute:142' y = coder.nullcopy(x);
      // 'ec_detrendCompute:142' y(:)=0;
      npages = b_x->size[0];
      b_x->size[0] = i;
      emxEnsureCapacity_real_T(b_x, npages, &g_emlrtRTEI);
      if (!b_x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(b_x, &b_gpu_x);
      }

      o_x = x->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (b_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
        }

        ecu_detrend_kernel5<<<grid, block>>>(o_x, b_gpu_x);
        b_x_dirtyOnCpu = false;
        b_x_dirtyOnGpu = true;
      }

      //  1) divide into windows, 2) detrend each, 3) stitch together, 4) estimate w
      // 'ec_detrendCompute:145' for iIter = 1:niter
      i1 = static_cast<int32_T>(niter);
      if (static_cast<int32_T>(niter) - 1 >= 0) {
        i13 = !(order < 1.0);
        i14 = static_cast<int32_T>(order);
        b_outsize[0] = i;
      }

      for (int32_T iIter{0}; iIter < i1; iIter++) {
        real_T offset;
        real_T stop;
        int32_T nx;

        // 'ec_detrendCompute:146' y = coder.nullcopy(x);
        // 'ec_detrendCompute:146' y(:)=0;
        i = b_x->size[0];
        b_x->size[0] = x->size[0];
        emxEnsureCapacity_real_T(b_x, i, &i_emlrtRTEI);
        if (!b_x_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(b_x, &b_gpu_x);
        }

        o_x = x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
          }

          ecu_detrend_kernel6<<<grid, block>>>(o_x, b_gpu_x);
          b_x_dirtyOnCpu = false;
          b_x_dirtyOnGpu = true;
        }

        // y = zeros(size(x));
        // 'ec_detrendCompute:147' trend = coder.nullcopy(y);
        i = x->size[0];
        npages = trend->size[0];
        trend->size[0] = i;
        emxEnsureCapacity_real_T(trend, npages, &j_emlrtRTEI);
        if (!trend_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(trend, &gpu_trend);
        }

        // trend = zeros(size(x));
        // 'ec_detrendCompute:148' a = coder.nullcopy(y(:,1));
        npages = a->size[0];
        a->size[0] = i;
        emxEnsureCapacity_real_T(a, npages, &k_emlrtRTEI);
        if (!b_a_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(a, &d_gpu_a);
        }

        // zeros(dims(1),1);
        // 'ec_detrendCompute:149' offset = 0;
        offset = 0.0;

        // 'ec_detrendCompute:150' while true
        real_T start;
        int32_T counter;
        do {
          real_T mn;
          real_T wsize2;
          int32_T e_r[2];
          int32_T b_dims_idx_0;
          int32_T i11;
          int32_T i12;
          int32_T i8;
          int32_T i9;

          // 'ec_detrendCompute:151' start = offset+1;
          start = offset + 1.0;

          // 'ec_detrendCompute:152' stop = min(dims(1),offset+wsize);
          stop = std::fmin(static_cast<real_T>(dims_idx_0), offset + b_wsize);

          //  if not enough valid samples grow window:
          // 'ec_detrendCompute:155' counter = 5;
          counter = 5;

          // 'ec_detrendCompute:156' while any(sum(min(w(start:stop),2))) < wsize
          int32_T exitg2;
          do {
            exitg2 = 0;
            if (start > stop) {
              i2 = 1;
              npages = 0;
            } else {
              i2 = static_cast<int32_T>(start);
              npages = static_cast<int32_T>(stop);
            }

            i = minval->size[0];
            minval->size[0] = (npages - i2) + 1;
            emxEnsureCapacity_int8_T(minval, i, &o_emlrtRTEI);
            gpuEmxEnsureCapacity_int8_T(minval, &gpu_minval);
            nx = npages - i2;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_w_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
              }

              b_w_dirtyOnCpu = false;
              ecu_detrend_kernel7<<<grid, block>>>(b_gpu_w, i2, nx, gpu_minval);
              minval_dirtyOnGpu = true;
            }

            i2 = minval->size[0];
            if (minval->size[0] == 0) {
              d2scaled = 0.0;
            } else {
              if (minval_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int8_T(minval, &gpu_minval);
              }

              minval_dirtyOnGpu = false;
              d2scaled = minval->data[0];
              for (o_x = 0; o_x <= i2 - 2; o_x++) {
                d2scaled += static_cast<real_T>(minval->data[o_x + 1]);
              }
            }

            if (((!(d2scaled == 0.0)) < b_wsize) && (counter > 0)) {
              // 'ec_detrendCompute:157' if counter <= 0
              // 'ec_detrendCompute:158' start = max(1,start-wsize/2);
              start = std::fmax(1.0, start - b_wsize / 2.0);

              // 'ec_detrendCompute:159' stop = min(dims(1),stop+wsize/2);
              stop = std::fmin(static_cast<real_T>(dims_idx_0), stop + b_wsize /
                               2.0);

              // 'ec_detrendCompute:160' counter = counter-1;
              counter--;
            } else {
              exitg2 = 1;
            }
          } while (exitg2 == 0);

          // 'ec_detrendCompute:157' ;
          // 'ec_detrendCompute:162' if rem(stop-start+1,2)==1
          if (rt_remd_snf((stop - start) + 1.0, 2.0) == 1.0) {
            // 'ec_detrendCompute:162' ;
            // 'ec_detrendCompute:162' stop = stop-1;
            stop--;
          }

          // 'ec_detrendCompute:163' wsize2 = stop-start+1;
          wsize2 = (stop - start) + 1.0;

          //  detrend this window
          // 'ec_detrendCompute:166' NITER = 1;
          // 'ec_detrendCompute:167' yy = ec_detrend_lfn(x(start:stop,:),order,thresh,NITER,w(start:stop,:),basis);
          if (start > stop) {
            i8 = 1;
            i9 = 1;
            i11 = 1;
            i12 = 1;
          } else {
            i8 = static_cast<int32_T>(start);
            i9 = static_cast<int32_T>(stop) + 1;
            i11 = static_cast<int32_T>(start);
            i12 = static_cast<int32_T>(stop) + 1;
          }

          //  if ~islogical(w); w = logical(w); end
          //  if singleOut && ~isa(x,'single'); x=single(x); r=single(r); end
          // %%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  Standard detrending (trend fit to entire data) %%%%%%%%%%%%%%%%%%%%%%%%%
          // [y,w,r]=nt_detrend(x,order,w,basis,thresh,niter) - robustly remove trend
          //
          //   y: detrended data
          //   w: updated weights
          //   r: basis matrix used
          //
          //   x: raw data
          //   order: order of polynomial or number of sin/cosine pairs
          //   w: weights
          //   basis: 'polynomials' [default] or 'sinusoids', or user-provided matrix
          //   thresh: threshold for outliers [default: 3 sd]
          //   niter: number of iterations [default: 3]
          //
          //  Noise tools
          //  See nt_regw().
          //
          //  The data are fit to the basis using weighted least squares. The weight is
          //  updated by setting samples for which the residual is greater than 'thresh'
          //  times its std to zero, and the fit is repeated at most 'niter'-1 times.
          //
          //  The choice of order (and basis) determines what complexity of the trend
          //  that can be removed.  It may be useful to first detrend with a low order
          //  to avoid fitting outliers, and then increase the order.
          //
          //  Examples:
          //  Fit linear trend, ignoring samples > 3*sd from it, and remove:
          //    y=nt_detrend(x,1);
          //  Fit/remove polynomial order=5 with initial weighting w, threshold = 4*sd:
          //    y=nt_detrend(x,5,w,[],4);
          //  Fit/remove linear then 3rd order polynomial:
          //    [y,w]=nt_detrend(x,1);
          //    [yy,ww]=nt_detrend(y,3);
          //  Regressors
          // 'ec_detrendCompute:90' dims = size(x);
          b_dims_idx_0 = i9 - i8;

          //  if isnumeric(basis)
          //      r = basis;
          //  else
          // 'ec_detrendCompute:94' switch basis
          // 'ec_detrendCompute:95' case 'polynomials'
          // 'ec_detrendCompute:96' r = coder.nullcopy(x(:,1:order));
          i = b_r->size[0] * b_r->size[1];
          b_r->size[0] = i9 - i8;
          b_r->size[1] = i13;
          emxEnsureCapacity_real_T(b_r, i, &l_emlrtRTEI);
          if (!r_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b_r, &b_gpu_r);
          }

          // 'ec_detrendCompute:96' r(:)=0;
          for (i = 0; i < 2; i++) {
            e_r[i] = b_r->size[i];
          }

          i = b_r->size[0] * b_r->size[1];
          b_r->size[0] = e_r[0];
          b_r->size[1] = e_r[1];
          emxEnsureCapacity_real_T(b_r, i, &m_emlrtRTEI);
          if (!r_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b_r, &b_gpu_r);
          }

          i = e_r[0] * e_r[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (r_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
            }

            ecu_detrend_kernel8<<<grid, block>>>(i, b_gpu_r);
            r_dirtyOnCpu = false;
            b_r_dirtyOnGpu = true;
          }

          //  r=zeros(dims(1),numel(order));
          // 'ec_detrendCompute:97' lin = linspace(-1,1,dims(1));
          i = b_lin->size[0] * b_lin->size[1];
          b_lin->size[0] = 1;
          b_lin->size[1] = b_dims_idx_0;
          emxEnsureCapacity_real_T(b_lin, i, &n_emlrtRTEI);
          if (!b_lin_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b_lin, &b_gpu_lin);
          }

          if (b_dims_idx_0 >= 1) {
            if (b_lin_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_lin, &b_gpu_lin);
            }

            b_lin->data[b_dims_idx_0 - 1] = 1.0;
            b_lin_dirtyOnGpu = false;
            b_lin_dirtyOnCpu = true;
            if (b_lin->size[1] >= 2) {
              b_lin->data[0] = -1.0;
              if (b_lin->size[1] >= 3) {
                d2scaled = 1.0 / (static_cast<real_T>(b_lin->size[1]) - 1.0);
                npages = b_lin->size[1] - 3;
                x_dim0 = b_lin->size[1];
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (npages + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                             cudaMemcpyHostToDevice);
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_lin, b_lin);
                  ecu_detrend_kernel9<<<grid, block>>>(npages, x_dim0,
                    gpu_d2scaled, b_gpu_lin);
                  b_lin_dirtyOnCpu = false;
                  b_lin_dirtyOnGpu = true;
                }

                if ((b_lin->size[1] & 1) == 1) {
                  x_dim0 = b_lin->size[1];
                  if (b_lin_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_lin, b_lin);
                  }

                  ecu_detrend_kernel10<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (x_dim0, b_gpu_lin);
                  b_lin_dirtyOnCpu = false;
                  b_lin_dirtyOnGpu = true;
                }
              }
            }
          }

          // 'ec_detrendCompute:98' for k=1:order
          for (na = 0; na < i14; na++) {
            // 'ec_detrendCompute:99' r(:,k) = lin.^k;
            i = dv3->size[0] * dv3->size[1];
            dv3->size[0] = 1;
            dv3->size[1] = b_lin->size[1];
            emxEnsureCapacity_real_T(dv3, i, &o_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv3, &gpu_dv3);
            nx = b_lin->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_lin_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_lin, b_lin);
              }

              b_lin_dirtyOnCpu = false;
              ecu_detrend_kernel11<<<grid, block>>>(b_gpu_lin, nx, gpu_dv3);
            }

            ntilecols = b_r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((ntilecols - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
              }

              ecu_detrend_kernel12<<<grid, block>>>(gpu_dv3, ntilecols, b_gpu_r);
              r_dirtyOnCpu = false;
              b_r_dirtyOnGpu = true;
            }
          }

          //  Remove trends
          //  The tricky bit is to ensure that weighted means are removed before
          //  calculating the regression (see nt_regw).
          // 'ec_detrendCompute:116' y = coder.nullcopy(x);
          // 'ec_detrendCompute:116' y(:)=0;
          // zeros(size(x));
          // 'ec_detrendCompute:117' for ii = 1:niter
          //  weighted regression on basis
          // 'ec_detrendCompute:119' y = regw_lfn(x,r,w);
          //  Weighted Regression %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          // [b,z]=nt_regw(y,x,w) - weighted regression
          //
          //   b: regression matrix (apply to x to approximate y)
          //   z: regression (x*b)
          //
          //   y: data
          //   x: regressor
          //   w: weight to apply to y
          //
          //   w is either a matrix of same size as y, or a column vector to be applied
          //   to each column of y
          //  Sanity checks
          // 'ec_detrendCompute:226' thr_PCA = 1e-7;
          //  discard dimensions of x with eigenvalue lower than this
          // 'ec_detrendCompute:227' m = size(y,1);
          // 'ec_detrendCompute:228' x = unfold_lfn(x);
          //  Unfold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          // y=nt_fold(x) - unfold 3D to 2D
          //
          //   y: 2D matrix of concatentated data (time * channel)
          //
          //   x: 3D matrix of (time * channel * trial)
          //
          //  NoiseTools
          // 'ec_detrendCompute:372' if ~isempty(x) && numel(size(x))>=3
          //  Depreciated
          //  % Vector Add %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  function x = vecadd_lfn(x,v)
          //  %y=nt_vecadd(x,v) - add vector to all rows or columns of matrix
          //  %
          //  % See vecmult, bsxfun
          //  %
          //  % NoiseTools
          //
          //  [m,~,~]=size(x);
          //  x=unfold_lfn(x);
          //  v=unfold_lfn(v);
          //
          //  [mm,nn]=size(x);
          //  if numel(v)==1;
          //      x=x+v;
          //  elseif size(v,1)==1
          //      if size(v,2)~=nn; error('V should have same number of columns as X'); end
          //      if bsxfun_exists;
          //          x=bsxfun(@plus,x,v);
          //          %        vecop_core(x, v, 2, 1);  % 1 is the opcode of addition in vecop_core
          //      else
          //          x=x + repmat(v,mm,1);
          //      end
          //  elseif size(v,2)==1
          //      if size(v,1)~=mm; error('V should have same number of rows as X'); end
          //      if bsxfun_exists;
          //          x=bsxfun(@plus,x,v);
          //          %       y=vecop_core(x, v, 1, 1);  % 1 is the opcode of addition in vecop_core
          //      else
          //          x=x + repmat(v,1,nn);
          //      end
          //  end
          //  x=nt_fold(x,m);
          //
          //  % Vector multiplication %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  function x = vecmult_lfn(x,v)
          //  %y=nt_vecmult(x,v) - multiply all rows or columns of matrix by vector
          //  %
          //  % See vecadd, bsxfun
          //  %
          //  % NoiseTools
          //
          //  % check once and for all to save time
          //  persistent bsxfun_exists;
          //  if isempty(bsxfun_exists); bsxfun_exists=(exist('bsxfun')==5); end
          //
          //  [m,n,o]=size(x);
          //  x=nt_unfold(x);
          //  v=nt_unfold(v);
          //
          //  [mm,nn]=size(x);
          //  [mv,nv]=size(v);
          //  if mv==mm
          //      % same number of rows, v should be column vector (or same size as x)
          //      if nv==nn
          //          x=x.*v;
          //      elseif nv==1
          //          if bsxfun_exists;
          //              x=bsxfun(@times,x,v);
          //              %y=vecop_core(x, v, 1, 2);  % 2 is the opcode of multiplication in vecop_core
          //          else
          //              x=x .* repmat(v,1,nn);
          //          end
          //      else
          //          error('V should be row vector');
          //      end
          //
          //  elseif nv==nn
          //      % same number of columns, v should be row vector (or same size as x)
          //      if mv==mm
          //          x=x.*v;
          //      elseif mv==1
          //          if bsxfun_exists;
          //              x=bsxfun(@times,x,v);
          //              %y=vecop_core(x, v, 2, 2);  % 2 is the opcode of multiplication in vecop_core
          //          else
          //              x=x .* repmat(v,mm,1);
          //          end
          //      else
          //          error('V should be column vector');
          //      end
          //
          //  else
          //      error('V and X should have same number of rows or columns');
          //  end
          //  x=nt_fold(x,m);
          // 'ec_detrendCompute:229' y = unfold_lfn(y);
          //  Unfold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          // y=nt_fold(x) - unfold 3D to 2D
          //
          //   y: 2D matrix of concatentated data (time * channel)
          //
          //   x: 3D matrix of (time * channel * trial)
          //
          //  NoiseTools
          // 'ec_detrendCompute:372' if ~isempty(x) && numel(size(x))>=3
          //  Depreciated
          //  % Vector Add %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  function x = vecadd_lfn(x,v)
          //  %y=nt_vecadd(x,v) - add vector to all rows or columns of matrix
          //  %
          //  % See vecmult, bsxfun
          //  %
          //  % NoiseTools
          //
          //  [m,~,~]=size(x);
          //  x=unfold_lfn(x);
          //  v=unfold_lfn(v);
          //
          //  [mm,nn]=size(x);
          //  if numel(v)==1;
          //      x=x+v;
          //  elseif size(v,1)==1
          //      if size(v,2)~=nn; error('V should have same number of columns as X'); end
          //      if bsxfun_exists;
          //          x=bsxfun(@plus,x,v);
          //          %        vecop_core(x, v, 2, 1);  % 1 is the opcode of addition in vecop_core
          //      else
          //          x=x + repmat(v,mm,1);
          //      end
          //  elseif size(v,2)==1
          //      if size(v,1)~=mm; error('V should have same number of rows as X'); end
          //      if bsxfun_exists;
          //          x=bsxfun(@plus,x,v);
          //          %       y=vecop_core(x, v, 1, 1);  % 1 is the opcode of addition in vecop_core
          //      else
          //          x=x + repmat(v,1,nn);
          //      end
          //  end
          //  x=nt_fold(x,m);
          //
          //  % Vector multiplication %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  function x = vecmult_lfn(x,v)
          //  %y=nt_vecmult(x,v) - multiply all rows or columns of matrix by vector
          //  %
          //  % See vecadd, bsxfun
          //  %
          //  % NoiseTools
          //
          //  % check once and for all to save time
          //  persistent bsxfun_exists;
          //  if isempty(bsxfun_exists); bsxfun_exists=(exist('bsxfun')==5); end
          //
          //  [m,n,o]=size(x);
          //  x=nt_unfold(x);
          //  v=nt_unfold(v);
          //
          //  [mm,nn]=size(x);
          //  [mv,nv]=size(v);
          //  if mv==mm
          //      % same number of rows, v should be column vector (or same size as x)
          //      if nv==nn
          //          x=x.*v;
          //      elseif nv==1
          //          if bsxfun_exists;
          //              x=bsxfun(@times,x,v);
          //              %y=vecop_core(x, v, 1, 2);  % 2 is the opcode of multiplication in vecop_core
          //          else
          //              x=x .* repmat(v,1,nn);
          //          end
          //      else
          //          error('V should be row vector');
          //      end
          //
          //  elseif nv==nn
          //      % same number of columns, v should be row vector (or same size as x)
          //      if mv==mm
          //          x=x.*v;
          //      elseif mv==1
          //          if bsxfun_exists;
          //              x=bsxfun(@times,x,v);
          //              %y=vecop_core(x, v, 2, 2);  % 2 is the opcode of multiplication in vecop_core
          //          else
          //              x=x .* repmat(v,mm,1);
          //          end
          //      else
          //          error('V should be column vector');
          //      end
          //
          //  else
          //      error('V and X should have same number of rows or columns');
          //  end
          //  x=nt_fold(x,m);
          // 'ec_detrendCompute:230' if size(x,1) ~= size(y,1)
          if (b_r->size[0] != i9 - i8) {
            // 'ec_detrendCompute:231' error("ec_detrendCompute/regw_lfn: x & y are unequal sizes");
            ab_y = nullptr;
            m8 = nullptr;
            emlrtAssign(&ab_y, emlrtCreateClassInstance2022a(emlrtRootTLSGlobal,
              "coder.internal.string"));
            m8 = nullptr;
            bb_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv5[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 51, m1, &b_u[0]);
            emlrtAssign(&bb_y, m1);
            emlrtAssign(&m8, bb_y);
            propValues[0] = m8;
            emlrtSetAllProperties(emlrtRootTLSGlobal, &ab_y, 0, 1, (const char_T
              **)&c_propNames[0], (const char_T **)&c_propClasses[0],
                                  &propValues[0]);
            emlrtAssign(&ab_y, emlrtConvertInstanceToRedirectSource
                        (emlrtRootTLSGlobal, ab_y, 0, "coder.internal.string"));
            b_error(ab_y, &emlrtMCI);
          }

          //  save weighted mean
          // 'ec_detrendCompute:235' mn = y - demean_lfn(y,w);
          i = c_ww->size[0];
          c_ww->size[0] = i12 - i11;
          emxEnsureCapacity_boolean_T(c_ww, i, &r_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(c_ww, &c_gpu_ww);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i12
            - i11) - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            ecu_detrend_kernel13<<<grid, block>>>(b_gpu_w, i11, i12, c_gpu_ww);
            c_ww_dirtyOnGpu = true;
          }

          //  if isempty(w)
          //      % simple regression
          //      xx = demean_lfn(x);
          //      yy = demean_lfn(y);
          //      [V,D] = eig(xx'*xx);
          //      V = real(V);
          //      D = real(D);
          //      topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
          //      xxx = xx*topcs;
          //      b = ((yy'*xxx) / (xxx'*xxx))';
          //      z = demean_lfn(x,w)*topcs*b;
          //      z = z + mn;
          //  else
          //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  [y,mn]=nt_demean(x,w) - remove weighted mean over cols
          //
          //  If w is a vector with fewer samples than size(x,1), it is interpreted as
          //  a vector of indices to be set to 1, the others being set to 0.
          // 'ec_detrendCompute:297' [m,n] = size(x);
          // 'ec_detrendCompute:299' if ~isempty(w) && numel(w)<m
          if ((i12 - i11 != 0) && ((i12 - i11) - 1 < (i9 - i8) - 1)) {
            // 'ec_detrendCompute:300' w=w(:);
            //  interpret w as array of indices to set to 1
            // 'ec_detrendCompute:302' if min(w)<1 || max(w)>m
            i2 = i12 - i11;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            b_y = b_w->data[i11 - 1];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              if (static_cast<int32_T>(b_y) > static_cast<int32_T>(b_w->data[i11
                   + o_x])) {
                b_y = b_w->data[i11 + o_x];
              }
            }

            if (!b_y) {
              // 'ec_detrendCompute:303' error('w interpreted as indices but values are out of range');
              db_y = nullptr;
              m1 = emlrtCreateCharArray(2, &iv8[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 52, m1, &varargin_1[0]);
              emlrtAssign(&db_y, m1);
              b_error(db_y, &emlrtMCI);
            }

            // 'ec_detrendCompute:305' ww = false(m,1);
            i = c_ww->size[0];
            c_ww->size[0] = i9 - i8;
            emxEnsureCapacity_boolean_T(c_ww, i, &s_emlrtRTEI);
            gpuEmxEnsureCapacity_boolean_T(c_ww, &c_gpu_ww);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i9
              - i8) - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel14<<<grid, block>>>(i9, i8, c_gpu_ww);
              c_ww_dirtyOnGpu = true;
            }

            // 'ec_detrendCompute:306' ww(w) = true;
            na = (i12 - i11) - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_w_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
              }

              b_w_dirtyOnCpu = false;
              cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
              ecu_detrend_kernel15<<<grid, block>>>(b_gpu_w, i11, gpu_na,
                c_gpu_ww);
              c_ww_dirtyOnGpu = true;
            }

            // 'ec_detrendCompute:307' w = ww;
          }

          //  if size(w,3)~=p
          //      if size(w,3)==1 && p~=1
          //          w = repmat(w,[1,1,p]);
          //      else
          //          error('W should have same npages as X, or else 1');
          //      end
          //  end
          // if p>1; x = unfold_lfn(x); end
          // 'ec_detrendCompute:319' if isempty(w)
          if (c_ww->size[0] == 0) {
            // 'ec_detrendCompute:320' mn = mean(x,1);
            i2 = i9 - i8;
            if (i9 - i8 == 0) {
              d2scaled = 0.0;
            } else {
              if (x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
              }

              x_dirtyOnGpu = false;
              d2scaled = x->data[(i8 + x->size[0] * ch) - 1];
              for (o_x = 0; o_x <= i2 - 2; o_x++) {
                d2scaled += x->data[(i8 + o_x) + x->size[0] * ch];
              }
            }

            mn = d2scaled / (static_cast<real_T>((i9 - i8) - 1) + 1.0);

            // 'ec_detrendCompute:321' x = x - mn;
            i = dv6->size[0];
            dv6->size[0] = i9 - i8;
            emxEnsureCapacity_real_T(dv6, i, &u_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv6, &gpu_dv6);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i9
              - i8) - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (dv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
              }

              dv1_dirtyOnCpu = false;
              ecu_detrend_kernel18<<<grid, block>>>(mn, gpu_dv1, i8, i9, gpu_dv6);
              dv6_dirtyOnGpu = true;
            }

            // vecadd_lfn(x,-mn);
          } else {
            // 'ec_detrendCompute:322' else
            // if p>1; w = unfold_lfn(w); end
            // 'ec_detrendCompute:324' if size(w,1)~=size(x,1)
            if (c_ww->size[0] != i9 - i8) {
              // 'ec_detrendCompute:324' ;
              // 'ec_detrendCompute:324' error('X and W should have same nrows');
              fb_y = nullptr;
              m1 = emlrtCreateCharArray(2, &iv10[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 30, m1,
                &b_varargin_1[0]);
              emlrtAssign(&fb_y, m1);
              b_error(fb_y, &emlrtMCI);
            }

            // 'ec_detrendCompute:325' if size(w,2)==1
            // 'ec_detrendCompute:326' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
            if (i9 - i8 == c_ww->size[0]) {
              i = g_x->size[0];
              g_x->size[0] = i9 - i8;
              emxEnsureCapacity_real_T(g_x, i, &t_emlrtRTEI);
              if (!f_x_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(g_x, &f_gpu_x);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (((i9 - i8) - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (dv1_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
                }

                dv1_dirtyOnCpu = false;
                if (f_x_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, g_x);
                }

                ecu_detrend_kernel16<<<grid, block>>>(c_gpu_ww, gpu_dv1, i8, i9,
                  f_gpu_x);
                f_x_dirtyOnCpu = false;
                f_x_dirtyOnGpu = true;
              }
            } else {
              if (f_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(g_x, &f_gpu_x);
              }

              if (dv1_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
              }

              dv1_dirtyOnGpu = false;
              if (c_ww_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_boolean_T(c_ww, &c_gpu_ww);
              }

              c_ww_dirtyOnGpu = false;
              binary_expand_op(g_x, dv1, i8, i9, c_ww);
              f_x_dirtyOnGpu = false;
              f_x_dirtyOnCpu = true;
            }

            i2 = g_x->size[0];
            if (g_x->size[0] == 0) {
              d2scaled = 0.0;
            } else {
              if (f_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(g_x, &f_gpu_x);
              }

              f_x_dirtyOnGpu = false;
              d2scaled = g_x->data[0];
              for (o_x = 0; o_x <= i2 - 2; o_x++) {
                d2scaled += g_x->data[o_x + 1];
              }
            }

            i2 = c_ww->size[0];
            if (c_ww_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(c_ww, &c_gpu_ww);
            }

            c_ww_dirtyOnGpu = false;
            npages = c_ww->data[0];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              npages += c_ww->data[o_x + 1];
            }

            mn = d2scaled / (static_cast<real_T>(npages) +
                             2.2204460492503131E-16);

            // sum(vecmult_lfn(x),w),1) ./ (sum(w,1)+eps);
            // 'ec_detrendCompute:332' x = x - mn;
            i = dv6->size[0];
            dv6->size[0] = i9 - i8;
            emxEnsureCapacity_real_T(dv6, i, &u_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv6, &gpu_dv6);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i9
              - i8) - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (dv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
              }

              dv1_dirtyOnCpu = false;
              ecu_detrend_kernel17<<<grid, block>>>(mn, gpu_dv1, i8, i9, gpu_dv6);
              dv6_dirtyOnGpu = true;
            }

            // x = vecadd_lfn(x,-mn);
          }

          //  Fit weighted regression
          // 'ec_detrendCompute:238' if size(w,1)~=size(x,1)
          if (i12 - i11 != b_r->size[0]) {
            // 'ec_detrendCompute:238' ;
            // 'ec_detrendCompute:238' error('!');
            gb_y = nullptr;
            m1 = emlrtCreateString1R2022a(emlrtRootTLSGlobal, '!');
            emlrtAssign(&gb_y, m1);
            b_error(gb_y, &emlrtMCI);
          }

          // 'ec_detrendCompute:239' if size(w,2)==1
          //  same weight for all channels
          // 'ec_detrendCompute:241' if sum(w(:))==0
          i2 = i12 - i11;
          if (i12 - i11 == 0) {
            npages = 0;
          } else {
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            npages = b_w->data[i11 - 1];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              npages += b_w->data[i11 + o_x];
            }
          }

          if (npages == 0) {
            // 'ec_detrendCompute:242' error('weights all zero');
            hb_y = nullptr;
            m1 = emlrtCreateCharArray(2, &iv11[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 16, m1, &c_varargin_1[0]);
            emlrtAssign(&hb_y, m1);
            b_error(hb_y, &emlrtMCI);
          }

          // 'ec_detrendCompute:244' yy = demean_lfn(y,w).*repmat(w,1,size(y,2));
          i = e_ww->size[0];
          e_ww->size[0] = i12 - i11;
          emxEnsureCapacity_boolean_T(e_ww, i, &v_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(e_ww, &e_gpu_ww);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i12
            - i11) - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            ecu_detrend_kernel19<<<grid, block>>>(b_gpu_w, i11, i12, e_gpu_ww);
            e_ww_dirtyOnGpu = true;
          }

          //  if isempty(w)
          //      % simple regression
          //      xx = demean_lfn(x);
          //      yy = demean_lfn(y);
          //      [V,D] = eig(xx'*xx);
          //      V = real(V);
          //      D = real(D);
          //      topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
          //      xxx = xx*topcs;
          //      b = ((yy'*xxx) / (xxx'*xxx))';
          //      z = demean_lfn(x,w)*topcs*b;
          //      z = z + mn;
          //  else
          //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  [y,mn]=nt_demean(x,w) - remove weighted mean over cols
          //
          //  If w is a vector with fewer samples than size(x,1), it is interpreted as
          //  a vector of indices to be set to 1, the others being set to 0.
          // 'ec_detrendCompute:297' [m,n] = size(x);
          // 'ec_detrendCompute:299' if ~isempty(w) && numel(w)<m
          if ((i12 - i11 != 0) && ((i12 - i11) - 1 < (i9 - i8) - 1)) {
            // 'ec_detrendCompute:300' w=w(:);
            //  interpret w as array of indices to set to 1
            // 'ec_detrendCompute:302' if min(w)<1 || max(w)>m
            i2 = i12 - i11;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            b_y = b_w->data[i11 - 1];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              if (static_cast<int32_T>(b_y) > static_cast<int32_T>(b_w->data[i11
                   + o_x])) {
                b_y = b_w->data[i11 + o_x];
              }
            }

            if (!b_y) {
              // 'ec_detrendCompute:303' error('w interpreted as indices but values are out of range');
              kb_y = nullptr;
              m1 = emlrtCreateCharArray(2, &iv14[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 52, m1, &varargin_1[0]);
              emlrtAssign(&kb_y, m1);
              b_error(kb_y, &emlrtMCI);
            }

            // 'ec_detrendCompute:305' ww = false(m,1);
            i = e_ww->size[0];
            e_ww->size[0] = i9 - i8;
            emxEnsureCapacity_boolean_T(e_ww, i, &s_emlrtRTEI);
            gpuEmxEnsureCapacity_boolean_T(e_ww, &e_gpu_ww);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i9
              - i8) - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel20<<<grid, block>>>(i9, i8, e_gpu_ww);
              e_ww_dirtyOnGpu = true;
            }

            // 'ec_detrendCompute:306' ww(w) = true;
            na = (i12 - i11) - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_w_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
              }

              b_w_dirtyOnCpu = false;
              cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
              ecu_detrend_kernel21<<<grid, block>>>(b_gpu_w, i11, gpu_na,
                e_gpu_ww);
              e_ww_dirtyOnGpu = true;
            }

            // 'ec_detrendCompute:307' w = ww;
          }

          //  if size(w,3)~=p
          //      if size(w,3)==1 && p~=1
          //          w = repmat(w,[1,1,p]);
          //      else
          //          error('W should have same npages as X, or else 1');
          //      end
          //  end
          // if p>1; x = unfold_lfn(x); end
          // 'ec_detrendCompute:319' if isempty(w)
          if (e_ww->size[0] == 0) {
            // 'ec_detrendCompute:320' mn = mean(x,1);
            i2 = i9 - i8;
            if (i9 - i8 == 0) {
              d2scaled = 0.0;
              y_dirtyOnGpu = false;
            } else {
              if (x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
              }

              x_dirtyOnGpu = false;
              d2scaled = x->data[(i8 + x->size[0] * ch) - 1];
              y_dirtyOnGpu = false;
              for (o_x = 0; o_x <= i2 - 2; o_x++) {
                d2scaled += x->data[(i8 + o_x) + x->size[0] * ch];
              }
            }

            mn = d2scaled / (static_cast<real_T>((i9 - i8) - 1) + 1.0);

            // 'ec_detrendCompute:321' x = x - mn;
            i = dv8->size[0];
            dv8->size[0] = i9 - i8;
            emxEnsureCapacity_real_T(dv8, i, &w_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv8, &gpu_dv8);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i9
              - i8) - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (dv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
              }

              dv1_dirtyOnCpu = false;
              ecu_detrend_kernel24<<<grid, block>>>(mn, gpu_dv1, i8, i9, gpu_dv8);
              dv8_dirtyOnGpu = true;
            }

            // vecadd_lfn(x,-mn);
          } else {
            // 'ec_detrendCompute:322' else
            // if p>1; w = unfold_lfn(w); end
            // 'ec_detrendCompute:324' if size(w,1)~=size(x,1)
            if (e_ww->size[0] != i9 - i8) {
              // 'ec_detrendCompute:324' ;
              // 'ec_detrendCompute:324' error('X and W should have same nrows');
              lb_y = nullptr;
              m1 = emlrtCreateCharArray(2, &iv17[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 30, m1,
                &b_varargin_1[0]);
              emlrtAssign(&lb_y, m1);
              b_error(lb_y, &emlrtMCI);
            }

            // 'ec_detrendCompute:325' if size(w,2)==1
            // 'ec_detrendCompute:326' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
            if (i9 - i8 == e_ww->size[0]) {
              i = i_x->size[0];
              i_x->size[0] = i9 - i8;
              emxEnsureCapacity_real_T(i_x, i, &t_emlrtRTEI);
              if (!h_x_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(i_x, &h_gpu_x);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (((i9 - i8) - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (dv1_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
                }

                dv1_dirtyOnCpu = false;
                if (h_x_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_x, i_x);
                }

                ecu_detrend_kernel22<<<grid, block>>>(e_gpu_ww, gpu_dv1, i8, i9,
                  h_gpu_x);
                h_x_dirtyOnCpu = false;
                h_x_dirtyOnGpu = true;
              }
            } else {
              if (h_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_x, &h_gpu_x);
              }

              if (dv1_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
              }

              dv1_dirtyOnGpu = false;
              if (e_ww_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_boolean_T(e_ww, &e_gpu_ww);
              }

              e_ww_dirtyOnGpu = false;
              binary_expand_op(i_x, dv1, i8, i9, e_ww);
              h_x_dirtyOnGpu = false;
              h_x_dirtyOnCpu = true;
            }

            i2 = i_x->size[0];
            if (i_x->size[0] == 0) {
              d2scaled = 0.0;
              y_dirtyOnGpu = false;
            } else {
              if (h_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_x, &h_gpu_x);
              }

              h_x_dirtyOnGpu = false;
              d2scaled = i_x->data[0];
              y_dirtyOnGpu = false;
              for (o_x = 0; o_x <= i2 - 2; o_x++) {
                d2scaled += i_x->data[o_x + 1];
              }
            }

            i2 = e_ww->size[0];
            if (e_ww_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(e_ww, &e_gpu_ww);
            }

            e_ww_dirtyOnGpu = false;
            npages = e_ww->data[0];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              npages += e_ww->data[o_x + 1];
            }

            mn = d2scaled / (static_cast<real_T>(npages) +
                             2.2204460492503131E-16);

            // sum(vecmult_lfn(x),w),1) ./ (sum(w,1)+eps);
            // 'ec_detrendCompute:332' x = x - mn;
            i = dv8->size[0];
            dv8->size[0] = i9 - i8;
            emxEnsureCapacity_real_T(dv8, i, &w_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(dv8, &gpu_dv8);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i9
              - i8) - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (dv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
              }

              dv1_dirtyOnCpu = false;
              ecu_detrend_kernel23<<<grid, block>>>(mn, gpu_dv1, i8, i9, gpu_dv8);
              dv8_dirtyOnGpu = true;
            }

            // x = vecadd_lfn(x,-mn);
          }

          i = bv2->size[0];
          bv2->size[0] = i12 - i11;
          emxEnsureCapacity_boolean_T(bv2, i, &x_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(bv2, &gpu_bv2);
          npages = (i12 - i11) - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            ecu_detrend_kernel25<<<grid, block>>>(b_gpu_w, i11, npages, gpu_bv2);
            bv2_dirtyOnGpu = true;
          }

          // 'ec_detrendCompute:245' xx = demean_lfn(x,w).*repmat(w,1,size(x,2));
          i = f_ww->size[0];
          f_ww->size[0] = i12 - i11;
          emxEnsureCapacity_boolean_T(f_ww, i, &y_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(f_ww, &f_gpu_ww);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i12
            - i11) - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            ecu_detrend_kernel26<<<grid, block>>>(b_gpu_w, i11, i12, f_gpu_ww);
            f_ww_dirtyOnGpu = true;
          }

          //  if isempty(w)
          //      % simple regression
          //      xx = demean_lfn(x);
          //      yy = demean_lfn(y);
          //      [V,D] = eig(xx'*xx);
          //      V = real(V);
          //      D = real(D);
          //      topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
          //      xxx = xx*topcs;
          //      b = ((yy'*xxx) / (xxx'*xxx))';
          //      z = demean_lfn(x,w)*topcs*b;
          //      z = z + mn;
          //  else
          //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  [y,mn]=nt_demean(x,w) - remove weighted mean over cols
          //
          //  If w is a vector with fewer samples than size(x,1), it is interpreted as
          //  a vector of indices to be set to 1, the others being set to 0.
          // 'ec_detrendCompute:297' [m,n] = size(x);
          // 'ec_detrendCompute:299' if ~isempty(w) && numel(w)<m
          if ((i12 - i11 != 0) && (i12 - i11 < b_r->size[0])) {
            // 'ec_detrendCompute:300' w=w(:);
            //  interpret w as array of indices to set to 1
            // 'ec_detrendCompute:302' if min(w)<1 || max(w)>m
            i2 = i12 - i11;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            b_y = b_w->data[i11 - 1];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              if (static_cast<int32_T>(b_y) > static_cast<int32_T>(b_w->data[i11
                   + o_x])) {
                b_y = b_w->data[i11 + o_x];
              }
            }

            if (!b_y) {
              // 'ec_detrendCompute:303' error('w interpreted as indices but values are out of range');
              mb_y = nullptr;
              m1 = emlrtCreateCharArray(2, &iv20[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 52, m1, &varargin_1[0]);
              emlrtAssign(&mb_y, m1);
              b_error(mb_y, &emlrtMCI);
            }

            // 'ec_detrendCompute:305' ww = false(m,1);
            i = f_ww->size[0];
            f_ww->size[0] = b_r->size[0];
            emxEnsureCapacity_boolean_T(f_ww, i, &s_emlrtRTEI);
            gpuEmxEnsureCapacity_boolean_T(f_ww, &f_gpu_ww);
            i = b_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel27<<<grid, block>>>(i, f_gpu_ww);
              f_ww_dirtyOnGpu = true;
            }

            // 'ec_detrendCompute:306' ww(w) = true;
            na = (i12 - i11) - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_w_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
              }

              b_w_dirtyOnCpu = false;
              cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
              ecu_detrend_kernel28<<<grid, block>>>(b_gpu_w, i11, gpu_na,
                f_gpu_ww);
              f_ww_dirtyOnGpu = true;
            }

            // 'ec_detrendCompute:307' w = ww;
          }

          //  if size(w,3)~=p
          //      if size(w,3)==1 && p~=1
          //          w = repmat(w,[1,1,p]);
          //      else
          //          error('W should have same npages as X, or else 1');
          //      end
          //  end
          // if p>1; x = unfold_lfn(x); end
          // 'ec_detrendCompute:319' if isempty(w)
          if (f_ww->size[0] == 0) {
            // 'ec_detrendCompute:320' mn = mean(x,1);
            i2 = b_r->size[0];
            if ((b_r->size[0] == 0) || (b_r->size[1] == 0)) {
              for (i = 0; i < 2; i++) {
                if (outsize_dirtyOnGpu) {
                  cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
                }

                outsize[i] = static_cast<uint32_T>(b_r->size[i]);
                outsize_dirtyOnGpu = false;
              }

              i = h_y->size[0] * h_y->size[1];
              h_y->size[0] = 1;
              if (outsize_dirtyOnGpu) {
                cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
              }

              h_y->size[1] = static_cast<int32_T>(outsize[1]);
              emxEnsureCapacity_real_T(h_y, i, &bb_emlrtRTEI);
              if (!c_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(h_y, &d_gpu_y);
              }

              outsize_dirtyOnGpu = false;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
                static_cast<int32_T>(outsize[1]) - 1) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                if (c_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_y, h_y);
                }

                ecu_detrend_kernel32<<<grid, block>>>(static_cast<int32_T>
                  (outsize[1]) - 1, d_gpu_y);
                c_y_dirtyOnCpu = false;
                d_y_dirtyOnGpu = true;
              }
            } else {
              i = h_y->size[0] * h_y->size[1];
              h_y->size[0] = 1;
              h_y->size[1] = 1;
              emxEnsureCapacity_real_T(h_y, i, &ab_emlrtRTEI);
              if (!c_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(h_y, &d_gpu_y);
              }

              if (d_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(h_y, &d_gpu_y);
              }

              if (b_r_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_r, &b_gpu_r);
              }

              b_r_dirtyOnGpu = false;
              h_y->data[0] = b_r->data[0];
              d_y_dirtyOnGpu = false;
              c_y_dirtyOnCpu = true;
              for (na = 0; na <= i2 - 2; na++) {
                h_y->data[0] += b_r->data[na + 1];
              }
            }

            // 'ec_detrendCompute:321' x = x - mn;
            if (b_r->size[1] == h_y->size[1]) {
              npages = b_r->size[0];
              i = dv13->size[0] * dv13->size[1];
              dv13->size[0] = b_r->size[0];
              dv13->size[1] = b_r->size[1];
              emxEnsureCapacity_real_T(dv13, i, &cb_emlrtRTEI);
              if (!dv13_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(dv13, &gpu_dv13);
              }

              i = b_r->size[1] - 1;
              nx = b_r->size[0] - 1;
              x_dim0 = dv13->size[0];
              ntilecols = b_r->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((nx + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (c_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_y, h_y);
                }

                c_y_dirtyOnCpu = false;
                if (r_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
                }

                r_dirtyOnCpu = false;
                if (dv13_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv13, dv13);
                }

                ecu_detrend_kernel33<<<grid, block>>>(npages, d_gpu_y, b_gpu_r,
                  nx, i, x_dim0, ntilecols, gpu_dv13);
                dv13_dirtyOnCpu = false;
                dv13_dirtyOnGpu = true;
              }
            } else {
              if (dv13_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(dv13, &gpu_dv13);
              }

              if (b_r_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_r, &b_gpu_r);
              }

              b_r_dirtyOnGpu = false;
              if (d_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(h_y, &d_gpu_y);
              }

              d_y_dirtyOnGpu = false;
              b_binary_expand_op(dv13, b_r, h_y);
              dv13_dirtyOnGpu = false;
              dv13_dirtyOnCpu = true;
            }

            // vecadd_lfn(x,-mn);
          } else {
            // 'ec_detrendCompute:322' else
            // if p>1; w = unfold_lfn(w); end
            // 'ec_detrendCompute:324' if size(w,1)~=size(x,1)
            if (f_ww->size[0] != b_r->size[0]) {
              // 'ec_detrendCompute:324' ;
              // 'ec_detrendCompute:324' error('X and W should have same nrows');
              nb_y = nullptr;
              m1 = emlrtCreateCharArray(2, &iv21[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 30, m1,
                &b_varargin_1[0]);
              emlrtAssign(&nb_y, m1);
              b_error(nb_y, &emlrtMCI);
            }

            // 'ec_detrendCompute:325' if size(w,2)==1
            // 'ec_detrendCompute:326' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
            if (b_r->size[0] == f_ww->size[0]) {
              i = j_x->size[0] * j_x->size[1];
              j_x->size[0] = b_r->size[0];
              j_x->size[1] = b_r->size[1];
              emxEnsureCapacity_real_T(j_x, i, &t_emlrtRTEI);
              if (!i_x_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(j_x, &i_gpu_x);
              }

              i = b_r->size[1] - 1;
              nx = b_r->size[0] - 1;
              x_dim0 = j_x->size[0];
              ntilecols = b_r->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((nx + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (r_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
                }

                r_dirtyOnCpu = false;
                if (i_x_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_x, j_x);
                }

                ecu_detrend_kernel29<<<grid, block>>>(f_gpu_ww, b_gpu_r, nx, i,
                  x_dim0, ntilecols, i_gpu_x);
                i_x_dirtyOnCpu = false;
                i_x_dirtyOnGpu = true;
              }
            } else {
              if (i_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(j_x, &i_gpu_x);
              }

              if (b_r_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_r, &b_gpu_r);
              }

              b_r_dirtyOnGpu = false;
              if (f_ww_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_boolean_T(f_ww, &f_gpu_ww);
              }

              f_ww_dirtyOnGpu = false;
              binary_expand_op(j_x, b_r, f_ww);
              i_x_dirtyOnGpu = false;
              i_x_dirtyOnCpu = true;
            }

            i2 = j_x->size[0];
            if ((j_x->size[0] == 0) || (j_x->size[1] == 0)) {
              for (i = 0; i < 2; i++) {
                if (outsize_dirtyOnGpu) {
                  cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
                }

                outsize[i] = static_cast<uint32_T>(j_x->size[i]);
                outsize_dirtyOnGpu = false;
              }

              i = i_y->size[0] * i_y->size[1];
              i_y->size[0] = 1;
              if (outsize_dirtyOnGpu) {
                cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
              }

              i_y->size[1] = static_cast<int32_T>(outsize[1]);
              emxEnsureCapacity_real_T(i_y, i, &db_emlrtRTEI);
              if (!d_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(i_y, &e_gpu_y);
              }

              outsize_dirtyOnGpu = false;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
                static_cast<int32_T>(outsize[1]) - 1) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                if (d_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_y, i_y);
                }

                ecu_detrend_kernel30<<<grid, block>>>(static_cast<int32_T>
                  (outsize[1]) - 1, e_gpu_y);
                d_y_dirtyOnCpu = false;
                e_y_dirtyOnGpu = true;
              }
            } else {
              i = i_y->size[0] * i_y->size[1];
              i_y->size[0] = 1;
              i_y->size[1] = 1;
              emxEnsureCapacity_real_T(i_y, i, &ab_emlrtRTEI);
              if (!d_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(i_y, &e_gpu_y);
              }

              if (e_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_y, &e_gpu_y);
              }

              if (i_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(j_x, &i_gpu_x);
              }

              i_x_dirtyOnGpu = false;
              i_y->data[0] = j_x->data[0];
              e_y_dirtyOnGpu = false;
              d_y_dirtyOnCpu = true;
              for (na = 0; na <= i2 - 2; na++) {
                i_y->data[0] += j_x->data[na + 1];
              }
            }

            i2 = f_ww->size[0];
            if (f_ww_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(f_ww, &f_gpu_ww);
            }

            f_ww_dirtyOnGpu = false;
            npages = f_ww->data[0];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              npages += f_ww->data[o_x + 1];
            }

            // sum(vecmult_lfn(x),w),1) ./ (sum(w,1)+eps);
            // 'ec_detrendCompute:332' x = x - mn;
            if (b_r->size[1] == i_y->size[1]) {
              d2scaled = static_cast<real_T>(npages) + 2.2204460492503131E-16;
              i = dv13->size[0] * dv13->size[1];
              dv13->size[0] = b_r->size[0];
              dv13->size[1] = b_r->size[1];
              emxEnsureCapacity_real_T(dv13, i, &cb_emlrtRTEI);
              if (!dv13_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(dv13, &gpu_dv13);
              }

              i = b_r->size[1] - 1;
              nx = b_r->size[0] - 1;
              x_dim0 = dv13->size[0];
              ntilecols = b_r->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((nx + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (d_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_y, i_y);
                }

                d_y_dirtyOnCpu = false;
                if (r_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
                }

                r_dirtyOnCpu = false;
                cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
                if (dv13_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv13, dv13);
                }

                ecu_detrend_kernel31<<<grid, block>>>(e_gpu_y, b_gpu_r, nx, i,
                  x_dim0, ntilecols, gpu_d2scaled, gpu_dv13);
                dv13_dirtyOnCpu = false;
                dv13_dirtyOnGpu = true;
                y_dirtyOnGpu = true;
              }
            } else {
              if (dv13_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(dv13, &gpu_dv13);
              }

              if (b_r_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_r, &b_gpu_r);
              }

              b_r_dirtyOnGpu = false;
              if (e_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_y, &e_gpu_y);
              }

              e_y_dirtyOnGpu = false;
              binary_expand_op(dv13, b_r, i_y, npages);
              dv13_dirtyOnGpu = false;
              dv13_dirtyOnCpu = true;
            }

            // x = vecadd_lfn(x,-mn);
          }

          i = bv4->size[0] * bv4->size[1];
          bv4->size[0] = i12 - i11;
          bv4->size[1] = b_r->size[1];
          emxEnsureCapacity_boolean_T(bv4, i, &x_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(bv4, &gpu_bv4);
          npages = (i12 - i11) - 1;
          ntilecols = b_r->size[1];
          for (i2 = 0; i2 < ntilecols; i2++) {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_w_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
              }

              b_w_dirtyOnCpu = false;
              ecu_detrend_kernel34<<<grid, block>>>(b_gpu_w, i11, npages,
                gpu_bv4);
              bv4_dirtyOnGpu = true;
            }
          }

          if ((dv13->size[0] == bv4->size[0]) && (dv13->size[1] == bv4->size[1]))
          {
            i = b_xx->size[0] * b_xx->size[1];
            b_xx->size[0] = dv13->size[0];
            b_xx->size[1] = dv13->size[1];
            emxEnsureCapacity_real_T(b_xx, i, &eb_emlrtRTEI);
            if (!b_xx_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_xx, &b_gpu_xx);
            }

            o_x = dv13->size[0] * dv13->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (dv13_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv13, dv13);
              }

              dv13_dirtyOnCpu = false;
              if (b_xx_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_xx, b_xx);
              }

              ecu_detrend_kernel35<<<grid, block>>>(gpu_bv4, gpu_dv13, o_x,
                b_gpu_xx);
              b_xx_dirtyOnCpu = false;
              b_xx_dirtyOnGpu = true;
            }
          } else {
            if (b_xx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_xx, &b_gpu_xx);
            }

            if (dv13_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv13, &gpu_dv13);
            }

            dv13_dirtyOnGpu = false;
            if (bv4_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(bv4, &gpu_bv4);
            }

            bv4_dirtyOnGpu = false;
            c_binary_expand_op(b_xx, dv13, bv4);
            b_xx_dirtyOnGpu = false;
            b_xx_dirtyOnCpu = true;
          }

          // 'ec_detrendCompute:246' [V,D] = eig(xx'*xx);
          i = h_A->size[0] * h_A->size[1];
          h_A->size[0] = b_xx->size[1];
          h_A->size[1] = b_xx->size[0];
          emxEnsureCapacity_real_T(h_A, i, &fb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(h_A, &c_gpu_A);
          nx = b_xx->size[0] - 1;
          x_dim0 = b_xx->size[1] - 1;
          ntilecols = h_A->size[0];
          o_x = b_xx->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((x_dim0 + 1L) * (nx + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_xx_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_xx, b_xx);
            }

            b_xx_dirtyOnCpu = false;
            ecu_detrend_kernel36<<<grid, block>>>(b_gpu_xx, x_dim0, nx,
              ntilecols, o_x, c_gpu_A);
          }

          if ((h_A->size[0] == 0) || (h_A->size[1] == 0) || (b_xx->size[0] == 0)
              || (b_xx->size[1] == 0)) {
            i = g_A->size[0] * g_A->size[1];
            g_A->size[0] = h_A->size[0];
            g_A->size[1] = b_xx->size[1];
            emxEnsureCapacity_real_T(g_A, i, &hb_emlrtRTEI);
            if (!b_A_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(g_A, &d_gpu_A);
            }

            nx = h_A->size[0] * b_xx->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_A_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, g_A);
              }

              ecu_detrend_kernel37<<<grid, block>>>(nx, d_gpu_A);
              b_A_dirtyOnCpu = false;
              b_A_dirtyOnGpu = true;
            }
          } else {
            i = g_A->size[0] * g_A->size[1];
            g_A->size[0] = 1;
            g_A->size[1] = 1;
            emxEnsureCapacity_real_T(g_A, i, &gb_emlrtRTEI);
            if (!b_A_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(g_A, &d_gpu_A);
            }

            d2scaled = 1.0;
            y_dirtyOnGpu = false;
            abnrm = 0.0;
            if (b_xx_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_xx, b_xx);
            }

            b_xx_dirtyOnCpu = false;
            if (b_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, g_A);
            }

            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1, 1,
                        h_A->size[1], (double *)&d2scaled, (double *)
                        &c_gpu_A.data[0], 1, (double *)&b_gpu_xx.data[0],
                        h_A->size[1], (double *)&abnrm, (double *)&d_gpu_A.data
                        [0], 1);
            b_A_dirtyOnCpu = false;
            b_A_dirtyOnGpu = true;
          }

          i2 = g_A->size[0];
          i = c_V->size[0] * c_V->size[1];
          c_V->size[0] = g_A->size[0];
          c_V->size[1] = g_A->size[0];
          emxEnsureCapacity_creal_T(c_V, i, &ib_emlrtRTEI);
          if (!c_V_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal_T(c_V, &c_gpu_V);
          }

          i = b_D->size[0] * b_D->size[1];
          b_D->size[0] = g_A->size[0];
          b_D->size[1] = g_A->size[0];
          emxEnsureCapacity_creal_T(b_D, i, &jb_emlrtRTEI);
          if (!b_D_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal_T(b_D, &b_gpu_D);
          }

          if ((g_A->size[0] != 0) && (g_A->size[1] != 0)) {
            if (b_A_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_A, &d_gpu_A);
            }

            b_A_dirtyOnGpu = false;
            if (std::isinf(g_A->data[0]) || std::isnan(g_A->data[0])) {
              for (i = 0; i < 2; i++) {
                e_r[i] = c_V->size[i];
              }

              i = c_V->size[0] * c_V->size[1];
              c_V->size[0] = e_r[0];
              c_V->size[1] = e_r[1];
              emxEnsureCapacity_creal_T(c_V, i, &lb_emlrtRTEI);
              if (!c_V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(c_V, &c_gpu_V);
              }

              ntilecols = e_r[0] * e_r[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (ntilecols + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (c_V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_V, c_V);
                }

                ecu_detrend_kernel52<<<grid, block>>>(gpu_dc, ntilecols, c_gpu_V);
                c_V_dirtyOnCpu = false;
                c_V_dirtyOnGpu = true;
              }

              for (i = 0; i < 2; i++) {
                e_r[i] = b_D->size[i];
              }

              i = b_D->size[0] * b_D->size[1];
              b_D->size[0] = e_r[0];
              b_D->size[1] = e_r[1];
              emxEnsureCapacity_creal_T(b_D, i, &vb_emlrtRTEI);
              if (!b_D_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(b_D, &b_gpu_D);
              }

              ntilecols = e_r[0] * e_r[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (ntilecols + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&b_gpu_D, b_D);
                }

                ecu_detrend_kernel53<<<grid, block>>>(ntilecols, b_gpu_D);
                b_D_dirtyOnCpu = false;
                b_D_dirtyOnGpu = true;
              }

              if (i2 - 1 >= 0) {
                if (b_D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&b_gpu_D, b_D);
                }

                ecu_detrend_kernel54<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                  (gpu_dc, b_gpu_D);
                b_D_dirtyOnCpu = false;
                b_D_dirtyOnGpu = true;
              }
            } else if (!(g_A->data[0] == g_A->data[0])) {
              if (!(g_A->data[0] == -g_A->data[0])) {
                ptrdiff_t j_info_t;
                i = b_scale->size[0];
                b_scale->size[0] = 1;
                emxEnsureCapacity_real_T(b_scale, i, &nb_emlrtRTEI);
                i = b_dt->size[0];
                b_dt->size[0] = 1;
                emxEnsureCapacity_creal_T(b_dt, i, &qb_emlrtRTEI);
                gpuEmxEnsureCapacity_creal_T(b_dt, &b_gpu_dt);
                i = b_wreal->size[0];
                b_wreal->size[0] = 1;
                emxEnsureCapacity_real_T(b_wreal, i, &tb_emlrtRTEI);
                i = b_wimag->size[0];
                b_wimag->size[0] = 1;
                emxEnsureCapacity_real_T(b_wimag, i, &wb_emlrtRTEI);
                i = b_vright->size[0] * b_vright->size[1];
                b_vright->size[0] = 1;
                b_vright->size[1] = 1;
                emxEnsureCapacity_real_T(b_vright, i, &xb_emlrtRTEI);
                if (y_dirtyOnGpu) {
                  cudaMemcpy(&d2scaled, gpu_d2scaled, 8UL,
                             cudaMemcpyDeviceToHost);
                }

                j_info_t = LAPACKE_dgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)1,
                  &g_A->data[0], (ptrdiff_t)1, &b_wreal->data[0], &b_wimag->
                  data[0], &d2scaled, (ptrdiff_t)1, &b_vright->data[0],
                  (ptrdiff_t)1, &b_ilo_t, &b_ihi_t, &b_scale->data[0], &abnrm,
                  &rconde, &rcondv);
                b_A_dirtyOnCpu = true;
                if ((int32_T)j_info_t < 0) {
                  i = b_dt->size[0];
                  b_dt->size[0] = 1;
                  emxEnsureCapacity_creal_T(b_dt, i, &gc_emlrtRTEI);
                  gpuEmxEnsureCapacity_creal_T(b_dt, &b_gpu_dt);
                  if (dc_dirtyOnGpu) {
                    cudaMemcpy(&dc, gpu_dc, 16UL, cudaMemcpyDeviceToHost);
                  }

                  dc_dirtyOnGpu = false;
                  b_dt->data[0] = dc;
                  i = c_V->size[0] * c_V->size[1];
                  c_V->size[0] = 1;
                  c_V->size[1] = 1;
                  emxEnsureCapacity_creal_T(c_V, i, &jc_emlrtRTEI);
                  if (!c_V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(c_V, &c_gpu_V);
                  } else {
                    gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_V, c_V);
                  }

                  ecu_detrend_kernel48<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (gpu_dc, c_gpu_V);
                  c_V_dirtyOnCpu = false;
                  c_V_dirtyOnGpu = true;
                } else {
                  real_T d1;
                  b_dt->data[0].re = b_wreal->data[0];
                  b_dt->data[0].im = b_wimag->data[0];
                  i = c_V->size[0] * c_V->size[1];
                  c_V->size[0] = 1;
                  c_V->size[1] = 1;
                  emxEnsureCapacity_creal_T(c_V, i, &hc_emlrtRTEI);
                  if (!c_V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(c_V, &c_gpu_V);
                  }

                  d1 = b_vright->data[0];
                  i = 1;
                  if (c_V_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal_T(c_V, &c_gpu_V);
                  }

                  c_V->data[0].im = 0.0;
                  c_V->data[0].re = d1;
                  c_V_dirtyOnGpu = false;
                  c_V_dirtyOnCpu = true;
                }

                x_dim0 = b_D->size[0];
                o_x = b_D->size[1];
                if (b_D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&b_gpu_D, b_D);
                }

                cudaMemcpy(gpu_i, &i, 4UL, cudaMemcpyHostToDevice);
                ecu_detrend_kernel49<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                  (x_dim0, o_x, gpu_i);
                b_D->size[0] = 1;
                b_D->size[1] = 1;
                cudaMemcpy(&i, gpu_i, 4UL, cudaMemcpyDeviceToHost);
                emxEnsureCapacity_creal_T(b_D, i, &lc_emlrtRTEI);
                gpuEmxEnsureCapacity_creal_T(b_D, &b_gpu_D);
                ecu_detrend_kernel50<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                  (b_gpu_D);
                gpuEmxMemcpyCpuToGpu_creal_T(&b_gpu_dt, b_dt);
                ecu_detrend_kernel51<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                  (b_gpu_dt, b_gpu_D);
                b_D_dirtyOnCpu = false;
                b_D_dirtyOnGpu = true;
              } else {
                if (std::isinf(g_A->data[0]) || std::isnan(g_A->data[0])) {
                  i = b_U->size[0] * b_U->size[1];
                  b_U->size[0] = 1;
                  b_U->size[1] = 1;
                  emxEnsureCapacity_real_T(b_U, i, &pb_emlrtRTEI);
                  if (!b_U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(b_U, &b_gpu_U);
                  }

                  if (b_U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(b_U, &b_gpu_U);
                  }

                  b_U->data[0] = rtNaN;
                  b_U_dirtyOnGpu = false;
                  b_U_dirtyOnCpu = true;
                } else {
                  ptrdiff_t d_n_t;
                  ptrdiff_t g_info_t;
                  ptrdiff_t i_info_t;
                  e_tau->size[0] = 0;
                  i = b_U->size[0] * b_U->size[1];
                  b_U->size[0] = g_A->size[0];
                  b_U->size[1] = g_A->size[1];
                  emxEnsureCapacity_real_T(b_U, i, &rb_emlrtRTEI);
                  if (!b_U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(b_U, &b_gpu_U);
                  }

                  nx = g_A->size[0] * g_A->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (nx + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (b_A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, g_A);
                    }

                    if (b_U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, b_U);
                    }

                    ecu_detrend_kernel44<<<grid, block>>>(d_gpu_A, nx, b_gpu_U);
                    b_U_dirtyOnGpu = true;
                  }

                  if (b_U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(b_U, &b_gpu_U);
                  }

                  g_info_t = LAPACKE_dorghr(102, (ptrdiff_t)1, (ptrdiff_t)1,
                    (ptrdiff_t)1, &b_U->data[0], (ptrdiff_t)1, &e_tau->data[0]);
                  b_U_dirtyOnGpu = false;
                  if ((int32_T)g_info_t != 0) {
                    for (i = 0; i < 2; i++) {
                      e_r[i] = b_U->size[i];
                    }

                    i = b_U->size[0] * b_U->size[1];
                    b_U->size[0] = e_r[0];
                    b_U->size[1] = e_r[1];
                    emxEnsureCapacity_real_T(b_U, i, &rb_emlrtRTEI);
                    ntilecols = e_r[0] * e_r[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(ntilecols + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, b_U);
                      ecu_detrend_kernel45<<<grid, block>>>(ntilecols, b_gpu_U);
                      b_U_dirtyOnGpu = true;
                    }
                  }

                  d_n_t = (ptrdiff_t)1;
                  i = d_wr->size[0] * d_wr->size[1];
                  d_wr->size[0] = 1;
                  d_wr->size[1] = 1;
                  emxEnsureCapacity_real_T(d_wr, i, &cc_emlrtRTEI);
                  i = d_wi->size[0] * d_wi->size[1];
                  d_wi->size[0] = 1;
                  d_wi->size[1] = 1;
                  emxEnsureCapacity_real_T(d_wi, i, &ec_emlrtRTEI);
                  if (b_U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(b_U, &b_gpu_U);
                  }

                  i_info_t = LAPACKE_dhseqr(102, 'S', 'V', d_n_t, (ptrdiff_t)1,
                    (ptrdiff_t)1, &g_A->data[0], d_n_t, &d_wr->data[0],
                    &d_wi->data[0], &b_U->data[0], (ptrdiff_t)1);
                  b_U_dirtyOnGpu = false;
                  b_U_dirtyOnCpu = true;
                  b_A_dirtyOnCpu = true;
                  if ((int32_T)i_info_t < 0) {
                    for (i = 0; i < 2; i++) {
                      e_r[i] = b_U->size[i];
                    }

                    i = b_U->size[0] * b_U->size[1];
                    b_U->size[0] = e_r[0];
                    b_U->size[1] = e_r[1];
                    emxEnsureCapacity_real_T(b_U, i, &mc_emlrtRTEI);
                    ntilecols = e_r[0] * e_r[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(ntilecols + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, b_U);
                      ecu_detrend_kernel46<<<grid, block>>>(ntilecols, b_gpu_U);
                      b_U_dirtyOnCpu = false;
                      b_U_dirtyOnGpu = true;
                    }
                  }
                }

                i = b_D->size[0] * b_D->size[1];
                b_D->size[0] = 1;
                b_D->size[1] = 1;
                emxEnsureCapacity_creal_T(b_D, i, &ac_emlrtRTEI);
                if (!b_D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(b_D, &b_gpu_D);
                }

                if (b_D_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_creal_T(b_D, &b_gpu_D);
                }

                b_D->data[0].im = 0.0;
                b_D->data[0].re = 0.0;
                b_D_dirtyOnGpu = false;
                b_D_dirtyOnCpu = true;
                i = c_V->size[0] * c_V->size[1];
                c_V->size[0] = b_U->size[0];
                c_V->size[1] = b_U->size[1];
                emxEnsureCapacity_creal_T(c_V, i, &bc_emlrtRTEI);
                if (!c_V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(c_V, &c_gpu_V);
                }

                x_dim0 = b_U->size[0] * b_U->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_U_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, b_U);
                  }

                  b_U_dirtyOnCpu = false;
                  if (c_V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_V, c_V);
                  }

                  ecu_detrend_kernel47<<<grid, block>>>(b_gpu_U, x_dim0, c_gpu_V);
                  c_V_dirtyOnCpu = false;
                  c_V_dirtyOnGpu = true;
                }
              }
            } else {
              if (std::isinf(g_A->data[0]) || std::isnan(g_A->data[0])) {
                i = d_V->size[0] * d_V->size[1];
                d_V->size[0] = 1;
                d_V->size[1] = 1;
                emxEnsureCapacity_real_T(d_V, i, &pb_emlrtRTEI);
                if (!d_V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_V, &d_gpu_V);
                }

                i = g_A->size[0] * g_A->size[1];
                g_A->size[0] = 1;
                g_A->size[1] = 1;
                emxEnsureCapacity_real_T(g_A, i, &sb_emlrtRTEI);
                if (!b_A_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(g_A, &d_gpu_A);
                }

                if (d_V_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_V, &d_gpu_V);
                }

                d_V->data[0] = rtNaN;
                d_V_dirtyOnGpu = false;
                d_V_dirtyOnCpu = true;
                g_A->data[0] = rtNaN;
                b_A_dirtyOnCpu = true;
              } else {
                ptrdiff_t c_n_t;
                ptrdiff_t f_info_t;
                ptrdiff_t h_info_t;
                d_tau->size[0] = 0;
                i = d_V->size[0] * d_V->size[1];
                d_V->size[0] = g_A->size[0];
                d_V->size[1] = g_A->size[1];
                emxEnsureCapacity_real_T(d_V, i, &rb_emlrtRTEI);
                if (!d_V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(d_V, &d_gpu_V);
                }

                nx = g_A->size[0] * g_A->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (nx + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_A_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, g_A);
                  }

                  if (d_V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_V, d_V);
                  }

                  ecu_detrend_kernel38<<<grid, block>>>(d_gpu_A, nx, d_gpu_V);
                  d_V_dirtyOnGpu = true;
                }

                if (d_V_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_V, &d_gpu_V);
                }

                f_info_t = LAPACKE_dorghr(102, (ptrdiff_t)1, (ptrdiff_t)1,
                  (ptrdiff_t)1, &d_V->data[0], (ptrdiff_t)1, &d_tau->data[0]);
                d_V_dirtyOnGpu = false;
                if ((int32_T)f_info_t != 0) {
                  for (i = 0; i < 2; i++) {
                    e_r[i] = d_V->size[i];
                  }

                  i = d_V->size[0] * d_V->size[1];
                  d_V->size[0] = e_r[0];
                  d_V->size[1] = e_r[1];
                  emxEnsureCapacity_real_T(d_V, i, &rb_emlrtRTEI);
                  ntilecols = e_r[0] * e_r[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (ntilecols + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_V, d_V);
                    ecu_detrend_kernel39<<<grid, block>>>(ntilecols, d_gpu_V);
                    d_V_dirtyOnGpu = true;
                  }
                }

                c_n_t = (ptrdiff_t)1;
                i = c_wr->size[0] * c_wr->size[1];
                c_wr->size[0] = 1;
                c_wr->size[1] = 1;
                emxEnsureCapacity_real_T(c_wr, i, &cc_emlrtRTEI);
                i = c_wi->size[0] * c_wi->size[1];
                c_wi->size[0] = 1;
                c_wi->size[1] = 1;
                emxEnsureCapacity_real_T(c_wi, i, &ec_emlrtRTEI);
                if (d_V_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(d_V, &d_gpu_V);
                }

                h_info_t = LAPACKE_dhseqr(102, 'S', 'V', c_n_t, (ptrdiff_t)1,
                  (ptrdiff_t)1, &g_A->data[0], c_n_t, &c_wr->data[0],
                  &c_wi->data[0], &d_V->data[0], (ptrdiff_t)1);
                d_V_dirtyOnGpu = false;
                d_V_dirtyOnCpu = true;
                b_A_dirtyOnCpu = true;
                if ((int32_T)h_info_t < 0) {
                  for (i = 0; i < 2; i++) {
                    e_r[i] = g_A->size[i];
                  }

                  i = g_A->size[0] * g_A->size[1];
                  g_A->size[0] = e_r[0];
                  g_A->size[1] = e_r[1];
                  emxEnsureCapacity_real_T(g_A, i, &kc_emlrtRTEI);
                  ntilecols = e_r[0] * e_r[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (ntilecols + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, g_A);
                    ecu_detrend_kernel40<<<grid, block>>>(ntilecols, d_gpu_A);
                    b_A_dirtyOnCpu = false;
                    b_A_dirtyOnGpu = true;
                  }

                  for (i = 0; i < 2; i++) {
                    e_r[i] = d_V->size[i];
                  }

                  i = d_V->size[0] * d_V->size[1];
                  d_V->size[0] = e_r[0];
                  d_V->size[1] = e_r[1];
                  emxEnsureCapacity_real_T(d_V, i, &mc_emlrtRTEI);
                  ntilecols = e_r[0] * e_r[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (ntilecols + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_V, d_V);
                    ecu_detrend_kernel41<<<grid, block>>>(ntilecols, d_gpu_V);
                    d_V_dirtyOnCpu = false;
                    d_V_dirtyOnGpu = true;
                  }
                }
              }

              i = c_V->size[0] * c_V->size[1];
              c_V->size[0] = d_V->size[0];
              c_V->size[1] = d_V->size[1];
              emxEnsureCapacity_creal_T(c_V, i, &yb_emlrtRTEI);
              if (!c_V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(c_V, &c_gpu_V);
              }

              ntilecols = d_V->size[0] * d_V->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (ntilecols + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (d_V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_V, d_V);
                }

                d_V_dirtyOnCpu = false;
                if (c_V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_V, c_V);
                }

                ecu_detrend_kernel42<<<grid, block>>>(d_gpu_V, ntilecols,
                  c_gpu_V);
                c_V_dirtyOnCpu = false;
                c_V_dirtyOnGpu = true;
              }

              i = b_D->size[0] * b_D->size[1];
              b_D->size[0] = g_A->size[0];
              b_D->size[1] = g_A->size[1];
              emxEnsureCapacity_creal_T(b_D, i, &dc_emlrtRTEI);
              if (!b_D_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(b_D, &b_gpu_D);
              }

              nx = g_A->size[0] * g_A->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_A_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, g_A);
                }

                b_A_dirtyOnCpu = false;
                if (b_D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&b_gpu_D, b_D);
                }

                ecu_detrend_kernel43<<<grid, block>>>(d_gpu_A, nx, b_gpu_D);
                b_D_dirtyOnCpu = false;
                b_D_dirtyOnGpu = true;
              }
            }
          }

          // 'ec_detrendCompute:247' V = real(V);
          // 'ec_detrendCompute:248' topcs = V(:,D/max(diag(real(D))) > thr_PCA);
          i = b_v->size[0] * b_v->size[1];
          b_v->size[0] = b_D->size[0];
          b_v->size[1] = b_D->size[1];
          emxEnsureCapacity_real_T(b_v, i, &kb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_v, &b_gpu_v);
          x_dim0 = b_D->size[0] * b_D->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_D_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&b_gpu_D, b_D);
            }

            b_D_dirtyOnCpu = false;
            ecu_detrend_kernel55<<<grid, block>>>(b_gpu_D, x_dim0, b_gpu_v);
            b_v_dirtyOnGpu = true;
          }

          if ((b_v->size[0] == 1) && (b_v->size[1] == 1)) {
            i = b_d->size[0];
            b_d->size[0] = 1;
            emxEnsureCapacity_real_T(b_d, i, &ob_emlrtRTEI);
            if (b_v_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_v, &b_gpu_v);
            }

            b_v_dirtyOnGpu = false;
            b_d->data[0] = b_v->data[0];
          } else {
            if (b_v->size[1] > 0) {
              npages = b_v->size[0];
            } else {
              npages = 0;
            }

            i = b_d->size[0];
            b_d->size[0] = npages;
            emxEnsureCapacity_real_T(b_d, i, &mb_emlrtRTEI);
            if (npages - 1 >= 0) {
              if (b_v_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_v, &b_gpu_v);
              }

              b_v_dirtyOnGpu = false;
              b_d->data[0] = b_v->data[0];
            }
          }

          i = bv5->size[0] * bv5->size[1];
          bv5->size[0] = b_D->size[0];
          bv5->size[1] = b_D->size[1];
          emxEnsureCapacity_boolean_T(bv5, i, &ub_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(bv5, &gpu_bv5);
          f_d.re = b_d->data[0];
          x_dim0 = b_D->size[0] * b_D->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_D_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&b_gpu_D, b_D);
            }

            b_D_dirtyOnCpu = false;
            ecu_detrend_kernel56<<<grid, block>>>(f_d, b_gpu_D, x_dim0, gpu_bv5);
            bv5_dirtyOnGpu = true;
          }

          na = bv5->size[0] * bv5->size[1] - 1;
          npages = 0;
          for (o_x = 0; o_x <= na; o_x++) {
            if (bv5_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(bv5, &gpu_bv5);
            }

            bv5_dirtyOnGpu = false;
            if (bv5->data[0]) {
              npages++;
            }
          }

          i = iv26->size[0];
          iv26->size[0] = npages;
          emxEnsureCapacity_int8_T(iv26, i, &fc_emlrtRTEI);
          npages = 0;
          for (o_x = 0; o_x <= na; o_x++) {
            if (bv5_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(bv5, &gpu_bv5);
            }

            bv5_dirtyOnGpu = false;
            if (bv5->data[0]) {
              iv26->data[npages] = 1;
              npages++;
            }
          }

          i = b_topcs->size[0] * b_topcs->size[1];
          b_topcs->size[0] = c_V->size[0];
          b_topcs->size[1] = iv26->size[0];
          emxEnsureCapacity_real_T(b_topcs, i, &ic_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_topcs, &b_gpu_topcs);
          x_dim0 = iv26->size[0] - 1;
          ntilecols = c_V->size[0] - 1;
          nx = b_topcs->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((ntilecols + 1L) * (x_dim0 + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_V_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_V, c_V);
            }

            c_V_dirtyOnCpu = false;
            ecu_detrend_kernel57<<<grid, block>>>(c_gpu_V, ntilecols, x_dim0, nx,
              b_gpu_topcs);
          }

          //  discard weak dims
          // 'ec_detrendCompute:249' xxx = xx*topcs;
          if ((b_xx->size[0] == 0) || (b_xx->size[1] == 0) || (b_topcs->size[0] ==
               0) || (b_topcs->size[1] == 0)) {
            i = b_xxx->size[0] * b_xxx->size[1];
            b_xxx->size[0] = b_xx->size[0];
            b_xxx->size[1] = b_topcs->size[1];
            emxEnsureCapacity_real_T(b_xxx, i, &nc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_xxx, &b_gpu_xxx);
            nx = b_xx->size[0] * b_topcs->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel58<<<grid, block>>>(nx, b_gpu_xxx);
            }
          } else {
            i = b_xxx->size[0] * b_xxx->size[1];
            b_xxx->size[0] = b_xx->size[0];
            b_xxx->size[1] = b_topcs->size[1];
            emxEnsureCapacity_real_T(b_xxx, i, &gb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_xxx, &b_gpu_xxx);
            d2scaled = 1.0;
            abnrm = 0.0;
            if (b_xx_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_xx, b_xx);
            }

            b_xx_dirtyOnCpu = false;
            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        b_xx->size[0], b_topcs->size[1], 1, (double *)&d2scaled,
                        (double *)&b_gpu_xx.data[0], b_xx->size[0], (double *)
                        &b_gpu_topcs.data[0], 1, (double *)&abnrm, (double *)
                        &b_gpu_xxx.data[0], b_xx->size[0]);
          }

          // 'ec_detrendCompute:250' b = ((yy'*xxx) / (xxx'*xxx))';
          if (dv8->size[0] == bv2->size[0]) {
            i = i_A->size[0] * i_A->size[1];
            i_A->size[0] = 1;
            i_A->size[1] = dv8->size[0];
            emxEnsureCapacity_real_T(i_A, i, &fb_emlrtRTEI);
            if (!d_A_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(i_A, &i_gpu_A);
            }

            x_dim0 = dv8->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (d_A_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, i_A);
              }

              ecu_detrend_kernel59<<<grid, block>>>(gpu_bv2, gpu_dv8, x_dim0,
                i_gpu_A);
              d_A_dirtyOnCpu = false;
              e_A_dirtyOnGpu = true;
            }
          } else {
            if (e_A_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(i_A, &i_gpu_A);
            }

            if (dv8_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv8, &gpu_dv8);
            }

            dv8_dirtyOnGpu = false;
            if (bv2_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(bv2, &gpu_bv2);
            }

            bv2_dirtyOnGpu = false;
            b_binary_expand_op(i_A, dv8, bv2);
            e_A_dirtyOnGpu = false;
            d_A_dirtyOnCpu = true;
          }

          if ((i_A->size[1] == 0) || (b_xxx->size[0] == 0) || (b_xxx->size[1] ==
               0)) {
            i = b_X->size[0] * b_X->size[1];
            b_X->size[0] = 1;
            b_X->size[1] = b_xxx->size[1];
            emxEnsureCapacity_real_T(b_X, i, &hb_emlrtRTEI);
            if (!b_X_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_X, &b_gpu_X);
            }

            x_dim0 = b_xxx->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_X_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_X, b_X);
              }

              ecu_detrend_kernel60<<<grid, block>>>(x_dim0, b_gpu_X);
              b_X_dirtyOnCpu = false;
            }
          } else {
            i = b_X->size[0] * b_X->size[1];
            b_X->size[0] = 1;
            b_X->size[1] = b_xxx->size[1];
            emxEnsureCapacity_real_T(b_X, i, &gb_emlrtRTEI);
            if (!b_X_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_X, &b_gpu_X);
            }

            d2scaled = 1.0;
            abnrm = 0.0;
            if (d_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, i_A);
            }

            d_A_dirtyOnCpu = false;
            if (b_X_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_X, b_X);
            }

            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                        b_xxx->size[1], i_A->size[1], (double *)&d2scaled,
                        (double *)&i_gpu_A.data[0], 1, (double *)
                        &b_gpu_xxx.data[0], i_A->size[1], (double *)&abnrm,
                        (double *)&b_gpu_X.data[0], 1);
            b_X_dirtyOnCpu = false;
          }

          i = j_A->size[0] * j_A->size[1];
          j_A->size[0] = b_xxx->size[1];
          j_A->size[1] = b_xxx->size[0];
          emxEnsureCapacity_real_T(j_A, i, &fb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(j_A, &j_gpu_A);
          x_dim0 = b_xxx->size[0] - 1;
          o_x = b_xxx->size[1] - 1;
          ntilecols = j_A->size[0];
          nx = b_xxx->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((o_x +
            1L) * (x_dim0 + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecu_detrend_kernel61<<<grid, block>>>(b_gpu_xxx, o_x, x_dim0,
              ntilecols, nx, j_gpu_A);
          }

          if ((j_A->size[0] == 0) || (j_A->size[1] == 0) || (b_xxx->size[0] == 0)
              || (b_xxx->size[1] == 0)) {
            i = k_A->size[0] * k_A->size[1];
            k_A->size[0] = j_A->size[0];
            k_A->size[1] = b_xxx->size[1];
            emxEnsureCapacity_real_T(k_A, i, &hb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(k_A, &k_gpu_A);
            nx = j_A->size[0] * b_xxx->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel62<<<grid, block>>>(nx, k_gpu_A);
            }
          } else {
            i = k_A->size[0] * k_A->size[1];
            k_A->size[0] = j_A->size[0];
            k_A->size[1] = b_xxx->size[1];
            emxEnsureCapacity_real_T(k_A, i, &gb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(k_A, &k_gpu_A);
            d2scaled = 1.0;
            abnrm = 0.0;
            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        j_A->size[0], b_xxx->size[1], j_A->size[1], (double *)
                        &d2scaled, (double *)&j_gpu_A.data[0], j_A->size[0],
                        (double *)&b_gpu_xxx.data[0], j_A->size[1], (double *)
                        &abnrm, (double *)&k_gpu_A.data[0], j_A->size[0]);
          }

          if ((b_X->size[1] == 0) || ((k_A->size[0] == 0) || (k_A->size[1] == 0)))
          {
            if (outsize_dirtyOnGpu) {
              cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
            }

            outsize[1] = static_cast<uint32_T>(k_A->size[0]);
            outsize_dirtyOnGpu = false;
            i = b_X->size[0] * b_X->size[1];
            b_X->size[0] = 1;
            b_X->size[1] = k_A->size[0];
            emxEnsureCapacity_real_T(b_X, i, &qc_emlrtRTEI);
            if (!b_X_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_X, &b_gpu_X);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(outsize[1]) - 1) + 1L), &grid, &block, 1024U,
              65535U);
            if (validLaunchParams) {
              if (b_X_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_X, b_X);
              }

              ecu_detrend_kernel76<<<grid, block>>>(static_cast<int32_T>
                (outsize[1]) - 1, b_gpu_X);
              b_X_dirtyOnCpu = false;
            }
          } else if (k_A->size[0] == k_A->size[1]) {
            i2 = k_A->size[1];
            i = b_ipiv_t->size[0];
            b_ipiv_t->size[0] = k_A->size[1];
            emxEnsureCapacity_int32_T(b_ipiv_t, i, &oc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_ipiv_t, &b_gpu_ipiv_t);
            cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), k_A->size[1],
              k_A->size[1], (double *)&k_gpu_A.data[0], k_A->size[1],
              getCuSolverWorkspaceReq());
            setCuSolverWorkspaceTypeSize(8);
            cusolverInitWorkspace();
            cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
            cusolverDnDgetrf(getCuSolverGlobalHandle(), k_A->size[1], k_A->size
                             [1], (double *)&k_gpu_A.data[0], k_A->size[1],
                             static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                             &b_gpu_ipiv_t.data[0], gpu_na);
            i = b_ipiv->size[0] * b_ipiv->size[1];
            b_ipiv->size[0] = 1;
            b_ipiv->size[1] = b_ipiv_t->size[0];
            emxEnsureCapacity_int32_T(b_ipiv, i, &rc_emlrtRTEI);
            if (!b_ipiv_dirtyOnCpu) {
              gpuEmxEnsureCapacity_int32_T(b_ipiv, &b_gpu_ipiv);
            }

            cudaMemcpy(&na, gpu_na, 4UL, cudaMemcpyDeviceToHost);
            if (na < 0) {
              for (i = 0; i < 2; i++) {
                e_r[i] = k_A->size[i];
              }

              i = k_A->size[0] * k_A->size[1];
              k_A->size[0] = e_r[0];
              k_A->size[1] = e_r[1];
              emxEnsureCapacity_real_T(k_A, i, &uc_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(k_A, &k_gpu_A);
              ntilecols = e_r[0] * e_r[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (ntilecols + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecu_detrend_kernel74<<<grid, block>>>(ntilecols, k_gpu_A);
              }

              npages = b_ipiv->size[1];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_ipiv_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_ipiv, b_ipiv);
                }

                ecu_detrend_kernel75<<<grid, block>>>(npages, b_gpu_ipiv);
                b_ipiv_dirtyOnCpu = false;
                b_ipiv_dirtyOnGpu = true;
              }
            } else {
              npages = b_ipiv_t->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_ipiv_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_ipiv, b_ipiv);
                }

                ecu_detrend_kernel73<<<grid, block>>>(b_gpu_ipiv_t, npages,
                  b_gpu_ipiv);
                b_ipiv_dirtyOnCpu = false;
                b_ipiv_dirtyOnGpu = true;
              }
            }

            d2scaled = 1.0;
            if (b_X_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_X, b_X);
            }

            cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                        CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N,
                        CUBLAS_DIAG_NON_UNIT, 1, i2, (double *)&d2scaled,
                        (double *)&k_gpu_A.data[0], i2, (double *)&b_gpu_X.data
                        [0], 1);
            d2scaled = 1.0;
            cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                        CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                        i2, (double *)&d2scaled, (double *)&k_gpu_A.data[0], i2,
                        (double *)&b_gpu_X.data[0], 1);
            b_X_dirtyOnCpu = false;
            y_dirtyOnGpu = true;
            for (ntilecols = 0; ntilecols <= i2 - 2; ntilecols++) {
              npages = (i2 - ntilecols) - 2;
              if (b_ipiv_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_ipiv, &b_gpu_ipiv);
              }

              b_ipiv_dirtyOnGpu = false;
              if (b_ipiv->data[npages] != npages + 1) {
                if (y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_X, &b_gpu_X);
                }

                d2scaled = b_X->data[npages];
                b_X->data[npages] = b_X->data[b_ipiv->data[npages] - 1];
                b_X->data[b_ipiv->data[npages] - 1] = d2scaled;
                b_ipiv_dirtyOnCpu = true;
                y_dirtyOnGpu = false;
                b_X_dirtyOnCpu = true;
              }
            }
          } else {
            ptrdiff_t l_info_t;
            boolean_T e_A_dirtyOnCpu;
            i = l_A->size[0] * l_A->size[1];
            l_A->size[0] = k_A->size[1];
            l_A->size[1] = k_A->size[0];
            emxEnsureCapacity_real_T(l_A, i, &pc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(l_A, &l_gpu_A);
            nx = k_A->size[0] - 1;
            x_dim0 = k_A->size[1] - 1;
            ntilecols = l_A->size[0];
            o_x = k_A->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((x_dim0 + 1L) * (nx + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel63<<<grid, block>>>(k_gpu_A, x_dim0, nx,
                ntilecols, o_x, l_gpu_A);
              f_A_dirtyOnGpu = true;
            }

            i = c_B->size[0];
            c_B->size[0] = b_X->size[1];
            emxEnsureCapacity_real_T(c_B, i, &sc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(c_B, &b_gpu_B);
            x_dim0 = b_X->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_X_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_X, b_X);
              }

              b_X_dirtyOnCpu = false;
              ecu_detrend_kernel64<<<grid, block>>>(b_gpu_X, x_dim0, b_gpu_B);
            }

            npages = l_A->size[0];
            na = l_A->size[1] - 1;
            y_dirtyOnGpu = true;
            i = b_jpvt->size[0] * b_jpvt->size[1];
            b_jpvt->size[0] = 1;
            b_jpvt->size[1] = l_A->size[1];
            emxEnsureCapacity_int32_T(b_jpvt, i, &vc_emlrtRTEI);
            if (!b_jpvt_dirtyOnCpu) {
              gpuEmxEnsureCapacity_int32_T(b_jpvt, &b_gpu_jpvt);
            }

            nx = l_A->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, b_jpvt);
              }

              ecu_detrend_kernel65<<<grid, block>>>(nx, b_gpu_jpvt);
              b_jpvt_dirtyOnCpu = false;
              b_jpvt_dirtyOnGpu = true;
            }

            i2 = l_A->size[0];
            nx = l_A->size[1];
            if (i2 <= nx) {
              nx = i2;
            }

            i = f_tau->size[0];
            f_tau->size[0] = nx;
            emxEnsureCapacity_real_T(f_tau, i, &wc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(f_tau, &b_gpu_tau);
            i = b_jpvt_t->size[0];
            b_jpvt_t->size[0] = l_A->size[1];
            emxEnsureCapacity_ptrdiff_t(b_jpvt_t, i, &xc_emlrtRTEI);
            for (i = 0; i < l_A->size[1]; i++) {
              b_jpvt_t->data[i] = (ptrdiff_t)0;
            }

            if (f_A_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_A, &l_gpu_A);
            }

            if (b_tau_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_tau, &b_gpu_tau);
            }

            l_info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)l_A->size[0], (ptrdiff_t)
              l_A->size[1], &l_A->data[0], (ptrdiff_t)l_A->size[0],
              &b_jpvt_t->data[0], &f_tau->data[0]);
            b_tau_dirtyOnGpu = false;
            b_y = true;
            f_A_dirtyOnGpu = false;
            e_A_dirtyOnCpu = true;
            if ((int32_T)l_info_t != 0) {
              ntilecols = l_A->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (((npages - 1) + 1L) * (na + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
                y_dirtyOnGpu = false;
                gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_A, l_A);
                ecu_detrend_kernel66<<<grid, block>>>(npages, gpu_na, ntilecols,
                  l_gpu_A);
                e_A_dirtyOnCpu = false;
                f_A_dirtyOnGpu = true;
              }

              i2 = l_A->size[0];
              ntilecols = l_A->size[1];
              if (i2 <= ntilecols) {
                ntilecols = i2;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((ntilecols - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_tau, f_tau);
                ecu_detrend_kernel67<<<grid, block>>>(ntilecols, b_gpu_tau);
                b_y = false;
                b_tau_dirtyOnGpu = true;
              }

              if ((nx - ntilecols) - 1 >= 0) {
                if (b_tau_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(f_tau, &b_gpu_tau);
                }

                std::memset(&f_tau->data[ntilecols], 0, static_cast<uint32_T>
                            ((nx - (ntilecols + 1)) + 1) * sizeof(real_T));
                b_tau_dirtyOnGpu = false;
                b_y = true;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (y_dirtyOnGpu) {
                  cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
                }

                if (b_jpvt_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, b_jpvt);
                }

                ecu_detrend_kernel68<<<grid, block>>>(gpu_na, b_gpu_jpvt);
                b_jpvt_dirtyOnCpu = false;
                b_jpvt_dirtyOnGpu = true;
              }
            } else {
              for (o_x = 0; o_x <= na; o_x++) {
                if (b_jpvt_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(b_jpvt, &b_gpu_jpvt);
                }

                b_jpvt->data[o_x] = (int32_T)b_jpvt_t->data[o_x];
                b_jpvt_dirtyOnGpu = false;
                b_jpvt_dirtyOnCpu = true;
              }
            }

            nx = 0;
            if (l_A->size[0] < l_A->size[1]) {
              ntilecols = l_A->size[0];
              npages = l_A->size[1];
            } else {
              ntilecols = l_A->size[1];
              npages = l_A->size[0];
            }

            if (f_A_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_A, &l_gpu_A);
            }

            f_A_dirtyOnGpu = false;
            d2scaled = std::fmin(1.4901161193847656E-8, 2.2204460492503131E-15 *
                                 static_cast<real_T>(npages)) * std::abs
              (l_A->data[0]);
            while ((nx < ntilecols) && (!(std::abs(l_A->data[nx + l_A->size[0] *
                      nx]) <= d2scaled))) {
              nx++;
            }

            npages = l_A->size[1];
            i = b_Y->size[0];
            b_Y->size[0] = l_A->size[1];
            emxEnsureCapacity_real_T(b_Y, i, &yc_emlrtRTEI);
            if (!b_Y_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_Y, &b_gpu_Y);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_Y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_Y, b_Y);
              }

              ecu_detrend_kernel69<<<grid, block>>>(npages, b_gpu_Y);
              b_Y_dirtyOnCpu = false;
              b_Y_dirtyOnGpu = true;
            }

            na = 0;
            i2 = l_A->size[0];
            npages = l_A->size[1];
            if (i2 <= npages) {
              npages = i2;
            }

            if (e_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_A, l_A);
            }

            if (b_y) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_tau, f_tau);
            }

            cusolverDnDormqr_bufferSize(getCuSolverGlobalHandle(),
              CUBLAS_SIDE_LEFT, CUBLAS_OP_T, c_B->size[0], 1, npages, (double *)
              &l_gpu_A.data[0], l_A->size[0], (double *)&b_gpu_tau.data[0],
              (double *)&b_gpu_B.data[0], c_B->size[0], getCuSolverWorkspaceReq());
            setCuSolverWorkspaceTypeSize(8);
            cusolverInitWorkspace();
            cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
            cusolverDnDormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                             CUBLAS_OP_T, c_B->size[0], 1, npages, (double *)
                             &l_gpu_A.data[0], l_A->size[0], (double *)
                             &b_gpu_tau.data[0], (double *)&b_gpu_B.data[0],
                             c_B->size[0], static_cast<real_T *>
                             (getCuSolverWorkspaceBuff()),
                             *getCuSolverWorkspaceReq(), gpu_na);
            cudaMemcpy(&na, gpu_na, 4UL, cudaMemcpyDeviceToHost);
            if (na < 0) {
              npages = c_B->size[0];
              i = c_B->size[0];
              c_B->size[0] = npages;
              emxEnsureCapacity_real_T(c_B, i, &ad_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(c_B, &b_gpu_B);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ecu_detrend_kernel70<<<grid, block>>>(npages, b_gpu_B);
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

              ecu_detrend_kernel71<<<grid, block>>>(b_gpu_B, b_gpu_jpvt, nx,
                b_gpu_Y);
              b_Y_dirtyOnCpu = false;
              b_Y_dirtyOnGpu = true;
            }

            for (ntilecols = 0; ntilecols < nx; ntilecols++) {
              npages = (nx - ntilecols) - 1;
              if (b_Y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_Y, &b_gpu_Y);
              }

              if (b_jpvt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_jpvt, &b_gpu_jpvt);
              }

              b_Y->data[b_jpvt->data[npages] - 1] /= l_A->data[npages +
                l_A->size[0] * npages];
              b_jpvt_dirtyOnGpu = false;
              b_jpvt_dirtyOnCpu = true;
              b_Y_dirtyOnGpu = false;
              b_Y_dirtyOnCpu = true;
              for (o_x = 0; o_x < npages; o_x++) {
                b_Y->data[b_jpvt->data[o_x] - 1] -= b_Y->data[b_jpvt->
                  data[npages] - 1] * l_A->data[o_x + l_A->size[0] * npages];
              }
            }

            i = b_X->size[0] * b_X->size[1];
            b_X->size[0] = 1;
            b_X->size[1] = b_Y->size[0];
            emxEnsureCapacity_real_T(b_X, i, &qc_emlrtRTEI);
            if (!b_X_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_X, &b_gpu_X);
            }

            x_dim0 = b_Y->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_Y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_Y, b_Y);
              }

              b_Y_dirtyOnCpu = false;
              if (b_X_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_X, b_X);
              }

              ecu_detrend_kernel72<<<grid, block>>>(b_gpu_Y, x_dim0, b_gpu_X);
              b_X_dirtyOnCpu = false;
            }
          }

          // 'ec_detrendCompute:251' z = demean_lfn(x,w)*topcs*b;
          i = h_ww->size[0];
          h_ww->size[0] = i12 - i11;
          emxEnsureCapacity_boolean_T(h_ww, i, &tc_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(h_ww, &h_gpu_ww);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i12
            - i11) - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            ecu_detrend_kernel77<<<grid, block>>>(b_gpu_w, i11, i12, h_gpu_ww);
            h_ww_dirtyOnGpu = true;
          }

          //  if isempty(w)
          //      % simple regression
          //      xx = demean_lfn(x);
          //      yy = demean_lfn(y);
          //      [V,D] = eig(xx'*xx);
          //      V = real(V);
          //      D = real(D);
          //      topcs = V(:,D/max(D) > thr_PCA); % discard weak dims
          //      xxx = xx*topcs;
          //      b = ((yy'*xxx) / (xxx'*xxx))';
          //      z = demean_lfn(x,w)*topcs*b;
          //      z = z + mn;
          //  else
          //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  [y,mn]=nt_demean(x,w) - remove weighted mean over cols
          //
          //  If w is a vector with fewer samples than size(x,1), it is interpreted as
          //  a vector of indices to be set to 1, the others being set to 0.
          // 'ec_detrendCompute:297' [m,n] = size(x);
          // 'ec_detrendCompute:299' if ~isempty(w) && numel(w)<m
          if ((i12 - i11 != 0) && (i12 - i11 < b_r->size[0])) {
            // 'ec_detrendCompute:300' w=w(:);
            //  interpret w as array of indices to set to 1
            // 'ec_detrendCompute:302' if min(w)<1 || max(w)>m
            i2 = i12 - i11;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            b_y = b_w->data[i11 - 1];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              if (static_cast<int32_T>(b_y) > static_cast<int32_T>(b_w->data[i11
                   + o_x])) {
                b_y = b_w->data[i11 + o_x];
              }
            }

            if (!b_y) {
              // 'ec_detrendCompute:303' error('w interpreted as indices but values are out of range');
              qb_y = nullptr;
              m1 = emlrtCreateCharArray(2, &iv31[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 52, m1, &varargin_1[0]);
              emlrtAssign(&qb_y, m1);
              b_error(qb_y, &emlrtMCI);
            }

            // 'ec_detrendCompute:305' ww = false(m,1);
            i = h_ww->size[0];
            h_ww->size[0] = b_r->size[0];
            emxEnsureCapacity_boolean_T(h_ww, i, &s_emlrtRTEI);
            gpuEmxEnsureCapacity_boolean_T(h_ww, &h_gpu_ww);
            i = b_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel78<<<grid, block>>>(i, h_gpu_ww);
              h_ww_dirtyOnGpu = true;
            }

            // 'ec_detrendCompute:306' ww(w) = true;
            na = (i12 - i11) - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_w_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
              }

              b_w_dirtyOnCpu = false;
              cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
              ecu_detrend_kernel79<<<grid, block>>>(b_gpu_w, i11, gpu_na,
                h_gpu_ww);
              h_ww_dirtyOnGpu = true;
            }

            // 'ec_detrendCompute:307' w = ww;
          }

          //  if size(w,3)~=p
          //      if size(w,3)==1 && p~=1
          //          w = repmat(w,[1,1,p]);
          //      else
          //          error('W should have same npages as X, or else 1');
          //      end
          //  end
          // if p>1; x = unfold_lfn(x); end
          // 'ec_detrendCompute:319' if isempty(w)
          if (h_ww->size[0] == 0) {
            // 'ec_detrendCompute:320' mn = mean(x,1);
            i2 = b_r->size[0];
            if ((b_r->size[0] == 0) || (b_r->size[1] == 0)) {
              for (i = 0; i < 2; i++) {
                if (outsize_dirtyOnGpu) {
                  cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
                }

                outsize[i] = static_cast<uint32_T>(b_r->size[i]);
                outsize_dirtyOnGpu = false;
              }

              i = m_y->size[0] * m_y->size[1];
              m_y->size[0] = 1;
              if (outsize_dirtyOnGpu) {
                cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
              }

              m_y->size[1] = static_cast<int32_T>(outsize[1]);
              emxEnsureCapacity_real_T(m_y, i, &bb_emlrtRTEI);
              if (!g_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(m_y, &i_gpu_y);
              }

              outsize_dirtyOnGpu = false;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
                static_cast<int32_T>(outsize[1]) - 1) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                if (g_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_y, m_y);
                }

                ecu_detrend_kernel84<<<grid, block>>>(static_cast<int32_T>
                  (outsize[1]) - 1, i_gpu_y);
                g_y_dirtyOnCpu = false;
                h_y_dirtyOnGpu = true;
              }
            } else {
              i = m_y->size[0] * m_y->size[1];
              m_y->size[0] = 1;
              m_y->size[1] = 1;
              emxEnsureCapacity_real_T(m_y, i, &ab_emlrtRTEI);
              if (!g_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(m_y, &i_gpu_y);
              }

              if (h_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(m_y, &i_gpu_y);
              }

              if (b_r_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_r, &b_gpu_r);
              }

              b_r_dirtyOnGpu = false;
              m_y->data[0] = b_r->data[0];
              h_y_dirtyOnGpu = false;
              g_y_dirtyOnCpu = true;
              for (na = 0; na <= i2 - 2; na++) {
                m_y->data[0] += b_r->data[na + 1];
              }
            }

            // 'ec_detrendCompute:321' x = x - mn;
            if (b_r->size[1] == m_y->size[1]) {
              npages = b_r->size[0];
              i = c_r->size[0] * c_r->size[1];
              c_r->size[0] = b_r->size[0];
              c_r->size[1] = b_r->size[1];
              emxEnsureCapacity_real_T(c_r, i, &fd_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(c_r, &c_gpu_r);
              i = b_r->size[1] - 1;
              nx = b_r->size[0] - 1;
              ntilecols = c_r->size[0];
              x_dim0 = b_r->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((nx + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (g_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_y, m_y);
                }

                g_y_dirtyOnCpu = false;
                if (r_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
                }

                r_dirtyOnCpu = false;
                ecu_detrend_kernel85<<<grid, block>>>(npages, i_gpu_y, b_gpu_r,
                  nx, i, ntilecols, x_dim0, c_gpu_r);
              }

              i = b_r->size[0] * b_r->size[1];
              b_r->size[0] = c_r->size[0];
              b_r->size[1] = c_r->size[1];
              emxEnsureCapacity_real_T(b_r, i, &bd_emlrtRTEI);
              if (!r_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(b_r, &b_gpu_r);
              }

              i = c_r->size[0] * c_r->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (r_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
                }

                ecu_detrend_kernel86<<<grid, block>>>(c_gpu_r, i, b_gpu_r);
                r_dirtyOnCpu = false;
                b_r_dirtyOnGpu = true;
              }
            } else {
              if (b_r_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_r, &b_gpu_r);
              }

              if (h_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(m_y, &i_gpu_y);
              }

              h_y_dirtyOnGpu = false;
              b_binary_expand_op(b_r, m_y);
              b_r_dirtyOnGpu = false;
              r_dirtyOnCpu = true;
            }

            // vecadd_lfn(x,-mn);
          } else {
            // 'ec_detrendCompute:322' else
            // if p>1; w = unfold_lfn(w); end
            // 'ec_detrendCompute:324' if size(w,1)~=size(x,1)
            if (h_ww->size[0] != b_r->size[0]) {
              // 'ec_detrendCompute:324' ;
              // 'ec_detrendCompute:324' error('X and W should have same nrows');
              rb_y = nullptr;
              m1 = emlrtCreateCharArray(2, &iv32[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 30, m1,
                &b_varargin_1[0]);
              emlrtAssign(&rb_y, m1);
              b_error(rb_y, &emlrtMCI);
            }

            // 'ec_detrendCompute:325' if size(w,2)==1
            // 'ec_detrendCompute:326' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
            if (b_r->size[0] == h_ww->size[0]) {
              i = m_x->size[0] * m_x->size[1];
              m_x->size[0] = b_r->size[0];
              m_x->size[1] = b_r->size[1];
              emxEnsureCapacity_real_T(m_x, i, &t_emlrtRTEI);
              if (!l_x_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(m_x, &l_gpu_x);
              }

              i = b_r->size[1] - 1;
              nx = b_r->size[0] - 1;
              x_dim0 = m_x->size[0];
              ntilecols = b_r->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((nx + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (r_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
                }

                r_dirtyOnCpu = false;
                if (l_x_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_x, m_x);
                }

                ecu_detrend_kernel80<<<grid, block>>>(h_gpu_ww, b_gpu_r, nx, i,
                  x_dim0, ntilecols, l_gpu_x);
                l_x_dirtyOnCpu = false;
                l_x_dirtyOnGpu = true;
              }
            } else {
              if (l_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(m_x, &l_gpu_x);
              }

              if (b_r_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_r, &b_gpu_r);
              }

              b_r_dirtyOnGpu = false;
              if (h_ww_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_boolean_T(h_ww, &h_gpu_ww);
              }

              h_ww_dirtyOnGpu = false;
              binary_expand_op(m_x, b_r, h_ww);
              l_x_dirtyOnGpu = false;
              l_x_dirtyOnCpu = true;
            }

            i2 = m_x->size[0];
            if ((m_x->size[0] == 0) || (m_x->size[1] == 0)) {
              for (i = 0; i < 2; i++) {
                if (outsize_dirtyOnGpu) {
                  cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
                }

                outsize[i] = static_cast<uint32_T>(m_x->size[i]);
                outsize_dirtyOnGpu = false;
              }

              i = n_y->size[0] * n_y->size[1];
              n_y->size[0] = 1;
              if (outsize_dirtyOnGpu) {
                cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
              }

              n_y->size[1] = static_cast<int32_T>(outsize[1]);
              emxEnsureCapacity_real_T(n_y, i, &db_emlrtRTEI);
              if (!h_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(n_y, &j_gpu_y);
              }

              outsize_dirtyOnGpu = false;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
                static_cast<int32_T>(outsize[1]) - 1) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                if (h_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_y, n_y);
                }

                ecu_detrend_kernel81<<<grid, block>>>(static_cast<int32_T>
                  (outsize[1]) - 1, j_gpu_y);
                h_y_dirtyOnCpu = false;
                i_y_dirtyOnGpu = true;
              }
            } else {
              i = n_y->size[0] * n_y->size[1];
              n_y->size[0] = 1;
              n_y->size[1] = 1;
              emxEnsureCapacity_real_T(n_y, i, &ab_emlrtRTEI);
              if (!h_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(n_y, &j_gpu_y);
              }

              if (i_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(n_y, &j_gpu_y);
              }

              if (l_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(m_x, &l_gpu_x);
              }

              l_x_dirtyOnGpu = false;
              n_y->data[0] = m_x->data[0];
              i_y_dirtyOnGpu = false;
              h_y_dirtyOnCpu = true;
              for (na = 0; na <= i2 - 2; na++) {
                n_y->data[0] += m_x->data[na + 1];
              }
            }

            i2 = h_ww->size[0];
            if (h_ww_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(h_ww, &h_gpu_ww);
            }

            h_ww_dirtyOnGpu = false;
            npages = h_ww->data[0];
            for (o_x = 0; o_x <= i2 - 2; o_x++) {
              npages += h_ww->data[o_x + 1];
            }

            // sum(vecmult_lfn(x),w),1) ./ (sum(w,1)+eps);
            // 'ec_detrendCompute:332' x = x - mn;
            if (b_r->size[1] == n_y->size[1]) {
              d2scaled = static_cast<real_T>(npages) + 2.2204460492503131E-16;
              i = d_r->size[0] * d_r->size[1];
              d_r->size[0] = b_r->size[0];
              d_r->size[1] = b_r->size[1];
              emxEnsureCapacity_real_T(d_r, i, &gd_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(d_r, &d_gpu_r);
              i = b_r->size[1] - 1;
              nx = b_r->size[0] - 1;
              ntilecols = d_r->size[0];
              x_dim0 = b_r->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((nx + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (h_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_y, n_y);
                }

                h_y_dirtyOnCpu = false;
                if (r_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
                }

                r_dirtyOnCpu = false;
                cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
                ecu_detrend_kernel82<<<grid, block>>>(j_gpu_y, b_gpu_r, nx, i,
                  ntilecols, x_dim0, gpu_d2scaled, d_gpu_r);
              }

              i = b_r->size[0] * b_r->size[1];
              b_r->size[0] = d_r->size[0];
              b_r->size[1] = d_r->size[1];
              emxEnsureCapacity_real_T(b_r, i, &cd_emlrtRTEI);
              if (!r_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(b_r, &b_gpu_r);
              }

              i = d_r->size[0] * d_r->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (r_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
                }

                ecu_detrend_kernel83<<<grid, block>>>(d_gpu_r, i, b_gpu_r);
                r_dirtyOnCpu = false;
                b_r_dirtyOnGpu = true;
              }
            } else {
              if (b_r_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_r, &b_gpu_r);
              }

              if (i_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(n_y, &j_gpu_y);
              }

              i_y_dirtyOnGpu = false;
              binary_expand_op(b_r, n_y, npages);
              b_r_dirtyOnGpu = false;
              r_dirtyOnCpu = true;
            }

            // x = vecadd_lfn(x,-mn);
          }

          if ((b_r->size[0] == 0) || (b_r->size[1] == 0) || (b_topcs->size[0] ==
               0) || (b_topcs->size[1] == 0)) {
            i = o_y->size[0] * o_y->size[1];
            o_y->size[0] = b_r->size[0];
            o_y->size[1] = b_topcs->size[1];
            emxEnsureCapacity_real_T(o_y, i, &hb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(o_y, &k_gpu_y);
            i = b_r->size[0] * b_topcs->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel87<<<grid, block>>>(i, k_gpu_y);
            }
          } else {
            i = o_y->size[0] * o_y->size[1];
            o_y->size[0] = b_r->size[0];
            o_y->size[1] = b_topcs->size[1];
            emxEnsureCapacity_real_T(o_y, i, &gb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(o_y, &k_gpu_y);
            d2scaled = 1.0;
            abnrm = 0.0;
            if (r_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_r, b_r);
            }

            r_dirtyOnCpu = false;
            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        b_r->size[0], b_topcs->size[1], 1, (double *)&d2scaled,
                        (double *)&b_gpu_r.data[0], b_r->size[0], (double *)
                        &b_gpu_topcs.data[0], 1, (double *)&abnrm, (double *)
                        &k_gpu_y.data[0], b_r->size[0]);
          }

          i = d_B->size[0];
          d_B->size[0] = b_X->size[1];
          emxEnsureCapacity_real_T(d_B, i, &dd_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(d_B, &d_gpu_B);
          x_dim0 = b_X->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_X_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_X, b_X);
            }

            b_X_dirtyOnCpu = false;
            ecu_detrend_kernel88<<<grid, block>>>(b_gpu_X, x_dim0, d_gpu_B);
          }

          if ((o_y->size[0] == 0) || (o_y->size[1] == 0) || (d_B->size[0] == 0))
          {
            i = yy->size[0];
            yy->size[0] = o_y->size[0];
            emxEnsureCapacity_real_T(yy, i, &hd_emlrtRTEI);
            if (!yy_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(yy, &gpu_yy);
            }

            x_dim0 = o_y->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, yy);
              }

              ecu_detrend_kernel89<<<grid, block>>>(x_dim0, gpu_yy);
              yy_dirtyOnCpu = false;
              yy_dirtyOnGpu = true;
            }
          } else {
            i = yy->size[0];
            yy->size[0] = o_y->size[0];
            emxEnsureCapacity_real_T(yy, i, &gb_emlrtRTEI);
            if (!yy_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(yy, &gpu_yy);
            }

            d2scaled = 1.0;
            abnrm = 0.0;
            if (yy_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, yy);
            }

            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        o_y->size[0], 1, o_y->size[1], (double *)&d2scaled,
                        (double *)&k_gpu_y.data[0], o_y->size[0], (double *)
                        &d_gpu_B.data[0], o_y->size[1], (double *)&abnrm,
                        (double *)&gpu_yy.data[0], o_y->size[0]);
            yy_dirtyOnCpu = false;
            yy_dirtyOnGpu = true;
          }

          // 'ec_detrendCompute:252' z = z + mn;
          if (i9 - i8 == 1) {
            o_x = dv6->size[0];
          } else {
            o_x = i9 - i8;
          }

          if ((i9 - i8 == dv6->size[0]) && (yy->size[0] == o_x)) {
            o_x = yy->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (dv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
              }

              dv1_dirtyOnCpu = false;
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, yy);
              }

              ecu_detrend_kernel90<<<grid, block>>>(gpu_dv6, gpu_dv1, i8, o_x,
                gpu_yy);
              yy_dirtyOnCpu = false;
              yy_dirtyOnGpu = true;
            }
          } else {
            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(yy, &gpu_yy);
            }

            if (dv1_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
            }

            dv1_dirtyOnGpu = false;
            if (dv6_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv6, &gpu_dv6);
            }

            dv6_dirtyOnGpu = false;
            b_binary_expand_op(yy, dv1, i8, i9, dv6);
            yy_dirtyOnGpu = false;
            yy_dirtyOnCpu = true;
          }

          // 'ec_detrendCompute:273' z = fold_lfn(z,m);
          // if p>1; x = fold_lfn(x,m); end
          //  Fold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //   y=fold(x,epochsize) - fold 2D to 3D
          //
          //   y: 3D matrix of (time * channel * trial)
          //
          //   x: 2D matrix of concatentated data (time * channel)
          //   epochsize: number of samples in each trial
          // 'ec_detrendCompute:347' x = unfold_lfn(x);
          //  Unfold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          // y=nt_fold(x) - unfold 3D to 2D
          //
          //   y: 2D matrix of concatentated data (time * channel)
          //
          //   x: 3D matrix of (time * channel * trial)
          //
          //  NoiseTools
          // 'ec_detrendCompute:372' if ~isempty(x) && numel(size(x))>=3
          //  Depreciated
          //  % Vector Add %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  function x = vecadd_lfn(x,v)
          //  %y=nt_vecadd(x,v) - add vector to all rows or columns of matrix
          //  %
          //  % See vecmult, bsxfun
          //  %
          //  % NoiseTools
          //
          //  [m,~,~]=size(x);
          //  x=unfold_lfn(x);
          //  v=unfold_lfn(v);
          //
          //  [mm,nn]=size(x);
          //  if numel(v)==1;
          //      x=x+v;
          //  elseif size(v,1)==1
          //      if size(v,2)~=nn; error('V should have same number of columns as X'); end
          //      if bsxfun_exists;
          //          x=bsxfun(@plus,x,v);
          //          %        vecop_core(x, v, 2, 1);  % 1 is the opcode of addition in vecop_core
          //      else
          //          x=x + repmat(v,mm,1);
          //      end
          //  elseif size(v,2)==1
          //      if size(v,1)~=mm; error('V should have same number of rows as X'); end
          //      if bsxfun_exists;
          //          x=bsxfun(@plus,x,v);
          //          %       y=vecop_core(x, v, 1, 1);  % 1 is the opcode of addition in vecop_core
          //      else
          //          x=x + repmat(v,1,nn);
          //      end
          //  end
          //  x=nt_fold(x,m);
          //
          //  % Vector multiplication %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //  function x = vecmult_lfn(x,v)
          //  %y=nt_vecmult(x,v) - multiply all rows or columns of matrix by vector
          //  %
          //  % See vecadd, bsxfun
          //  %
          //  % NoiseTools
          //
          //  % check once and for all to save time
          //  persistent bsxfun_exists;
          //  if isempty(bsxfun_exists); bsxfun_exists=(exist('bsxfun')==5); end
          //
          //  [m,n,o]=size(x);
          //  x=nt_unfold(x);
          //  v=nt_unfold(v);
          //
          //  [mm,nn]=size(x);
          //  [mv,nv]=size(v);
          //  if mv==mm
          //      % same number of rows, v should be column vector (or same size as x)
          //      if nv==nn
          //          x=x.*v;
          //      elseif nv==1
          //          if bsxfun_exists;
          //              x=bsxfun(@times,x,v);
          //              %y=vecop_core(x, v, 1, 2);  % 2 is the opcode of multiplication in vecop_core
          //          else
          //              x=x .* repmat(v,1,nn);
          //          end
          //      else
          //          error('V should be row vector');
          //      end
          //
          //  elseif nv==nn
          //      % same number of columns, v should be row vector (or same size as x)
          //      if mv==mm
          //          x=x.*v;
          //      elseif mv==1
          //          if bsxfun_exists;
          //              x=bsxfun(@times,x,v);
          //              %y=vecop_core(x, v, 2, 2);  % 2 is the opcode of multiplication in vecop_core
          //          else
          //              x=x .* repmat(v,mm,1);
          //          end
          //      else
          //          error('V should be column vector');
          //      end
          //
          //  else
          //      error('V and X should have same number of rows or columns');
          //  end
          //  x=nt_fold(x,m);
          //  in case it was already folded
          // 'ec_detrendCompute:348' if ~isempty(x)
          if (yy->size[0] != 0) {
            real_T nepochs;

            // 'ec_detrendCompute:349' nepochs = size(x,1)/N;
            nepochs = static_cast<real_T>(yy->size[0]) / (static_cast<real_T>
              ((i9 - i8) - 1) + 1.0);

            // 'ec_detrendCompute:350' if nepochs~=round(nepochs)
            if (nepochs != std::round(nepochs)) {
              // 'ec_detrendCompute:351' nepochs = floor(nepochs);
              nepochs = std::floor(nepochs);

              // 'ec_detrendCompute:352' x = x(1:N*nepochs,:);
              d2scaled = (static_cast<real_T>((i9 - i8) - 1) + 1.0) * nepochs;
              i = yy->size[0];
              if (d2scaled < 1.0) {
                yy->size[0] = 0;
              } else {
                yy->size[0] = static_cast<int32_T>(d2scaled);
              }

              emxEnsureCapacity_real_T(yy, i, &hd_emlrtRTEI);
              if (!yy_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(yy, &gpu_yy);
              }

              // 'ec_detrendCompute:353' disp('nsamples not multiple of epoch size, truncating...');
              tb_y = nullptr;
              m1 = emlrtCreateCharArray(2, &iv35[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 50, m1, &c_u[0]);
              emlrtAssign(&tb_y, m1);
              disp(tb_y, &b_emlrtMCI);
            }

            // if nepochs>1
            //     x = permute(reshape(x,[N, size(x,1)/N, size(x,2)]), [1 3 2]);
            // end
          }

          //  find outliers
          // 'ec_detrendCompute:122' d = x-y;
          if (i9 - i8 == yy->size[0]) {
            i = d_d->size[0];
            d_d->size[0] = i9 - i8;
            emxEnsureCapacity_real_T(d_d, i, &id_emlrtRTEI);
            if (!b_d_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(d_d, &b_gpu_d);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i9
              - i8) - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, yy);
              }

              yy_dirtyOnCpu = false;
              if (dv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
              }

              dv1_dirtyOnCpu = false;
              if (b_d_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, d_d);
              }

              ecu_detrend_kernel91<<<grid, block>>>(gpu_yy, gpu_dv1, i8, i9,
                b_gpu_d);
              b_d_dirtyOnCpu = false;
              b_d_dirtyOnGpu = true;
            }
          } else {
            if (b_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(d_d, &b_gpu_d);
            }

            if (dv1_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
            }

            dv1_dirtyOnGpu = false;
            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(yy, &gpu_yy);
            }

            yy_dirtyOnGpu = false;
            binary_expand_op(d_d, dv1, i8, i9, yy);
            b_d_dirtyOnGpu = false;
            b_d_dirtyOnCpu = true;
          }

          // 'ec_detrendCompute:123' if ~isempty(w)
          if (i12 - i11 != 0) {
            // 'ec_detrendCompute:123' ;
            // 'ec_detrendCompute:123' d = d.*w;
            if (d_d->size[0] == i12 - i11) {
              o_x = d_d->size[0] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (o_x + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_w_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
                }

                b_w_dirtyOnCpu = false;
                if (b_d_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, d_d);
                }

                ecu_detrend_kernel92<<<grid, block>>>(b_gpu_w, i11, o_x, b_gpu_d);
                b_d_dirtyOnCpu = false;
                b_d_dirtyOnGpu = true;
              }
            } else {
              if (b_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(d_d, &b_gpu_d);
              }

              if (b_w_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
              }

              b_w_dirtyOnGpu = false;
              binary_expand_op(d_d, b_w, i11, i12);
              b_d_dirtyOnGpu = false;
              b_d_dirtyOnCpu = true;
            }
          }

          // 'ec_detrendCompute:124' ww = true(dims);
          // 'ec_detrendCompute:125' ww(abs(d) > thresh * repmat(std(d),dims(1),1)) = false;
          i2 = d_d->size[0] - 2;
          if ((d_d->size[0] != 0) && (d_d->size[0] != 1)) {
            if (b_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(d_d, &b_gpu_d);
            }

            b_d_dirtyOnGpu = false;
            d2scaled = d_d->data[0];
            for (o_x = 0; o_x <= i2; o_x++) {
              d2scaled += d_d->data[o_x + 1];
            }

            d2scaled /= static_cast<real_T>(d_d->size[0]);
            i = b_absdiff->size[0];
            b_absdiff->size[0] = d_d->size[0];
            emxEnsureCapacity_real_T(b_absdiff, i, &md_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_absdiff, &b_gpu_absdiff);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i2
              + 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_d_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, d_d);
              }

              b_d_dirtyOnCpu = false;
              cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
              ecu_detrend_kernel93<<<grid, block>>>(b_gpu_d, i2, gpu_d2scaled,
                b_gpu_absdiff);
              cudaMemcpy(&d2scaled, gpu_d2scaled, 8UL, cudaMemcpyDeviceToHost);
            }

            cublasDnrm2(getCublasGlobalHandle(), d_d->size[0], (double *)
                        &b_gpu_absdiff.data[0], 1, (double *)&d2scaled);
          }

          //  update weights
          // 'ec_detrendCompute:128' if isempty(w)
          // 'ec_detrendCompute:134' y = x-y;
          if (i9 - i8 == yy->size[0]) {
            i = yy->size[0];
            yy->size[0] = i9 - i8;
            emxEnsureCapacity_real_T(yy, i, &hd_emlrtRTEI);
            if (!yy_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(yy, &gpu_yy);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((i9
              - i8) - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (dv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
              }

              dv1_dirtyOnCpu = false;
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, yy);
              }

              ecu_detrend_kernel94<<<grid, block>>>(gpu_dv1, i8, i9, gpu_yy);
              yy_dirtyOnCpu = false;
              yy_dirtyOnGpu = true;
            }
          } else {
            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(yy, &gpu_yy);
            }

            if (dv1_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
            }

            dv1_dirtyOnGpu = false;
            binary_expand_op(yy, dv1, i8, i9);
            yy_dirtyOnGpu = false;
            yy_dirtyOnCpu = true;
          }

          //  triangular weighting
          // 'ec_detrendCompute:170' if start==1
          if (start == 1.0) {
            // 'ec_detrendCompute:171' b = [ones(1,wsize2/2)*wsize2/2, wsize2/2:-1:1]';
            i = c_a->size[0] * c_a->size[1];
            c_a->size[0] = 1;
            c_a->size[1] = static_cast<int32_T>(wsize2 / 2.0);
            emxEnsureCapacity_int8_T(c_a, i, &pd_emlrtRTEI);
            if (!a_dirtyOnCpu) {
              gpuEmxEnsureCapacity_int8_T(c_a, &b_gpu_a);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(wsize2 / 2.0) - 1) + 1L), &grid, &block,
              1024U, 65535U);
            if (validLaunchParams) {
              if (a_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int8_T(&b_gpu_a, c_a);
              }

              ecu_detrend_kernel106<<<grid, block>>>(wsize2, b_gpu_a);
              a_dirtyOnCpu = false;
            }

            d2scaled = wsize2 / 2.0;
            y_dirtyOnGpu = true;
            if (d2scaled < 1.0) {
              p_y->size[0] = 1;
              p_y->size[1] = 0;
            } else if (std::floor(d2scaled) == d2scaled) {
              i = p_y->size[0] * p_y->size[1];
              p_y->size[0] = 1;
              p_y->size[1] = static_cast<int32_T>(-(1.0 - d2scaled)) + 1;
              emxEnsureCapacity_real_T(p_y, i, &sd_emlrtRTEI);
              if (!l_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(p_y, &o_gpu_y);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int32_T>(-(1.0 - d2scaled)) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                if (l_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&o_gpu_y, p_y);
                }

                cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
                ecu_detrend_kernel112<<<grid, block>>>(o_gpu_y, gpu_d2scaled);
                l_y_dirtyOnCpu = false;
                k_y_dirtyOnGpu = true;
              }
            } else {
              abnrm = std::floor(-(1.0 - d2scaled) + 0.5);
              rconde = d2scaled - abnrm;
              if (std::abs(1.0 - rconde) < 4.4408920985006262E-16 * d2scaled) {
                abnrm++;
                rconde = 1.0;
              } else if (1.0 - rconde > 0.0) {
                rconde = d2scaled - (abnrm - 1.0);
              } else {
                abnrm++;
              }

              i2 = static_cast<int32_T>(abnrm);
              i = p_y->size[0] * p_y->size[1];
              p_y->size[0] = 1;
              p_y->size[1] = static_cast<int32_T>(abnrm);
              emxEnsureCapacity_real_T(p_y, i, &wd_emlrtRTEI);
              if (!l_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(p_y, &o_gpu_y);
              }

              if (static_cast<int32_T>(abnrm) > 0) {
                if (k_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(p_y, &o_gpu_y);
                }

                p_y->data[0] = d2scaled;
                k_y_dirtyOnGpu = false;
                l_y_dirtyOnCpu = true;
                if (static_cast<int32_T>(abnrm) > 1) {
                  cudaMemcpy(gpu_abnrm, &abnrm, 8UL, cudaMemcpyHostToDevice);
                  gpuEmxMemcpyCpuToGpu_real_T(&o_gpu_y, p_y);
                  ecu_detrend_kernel107<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (rconde, gpu_abnrm, o_gpu_y);
                  cudaMemcpy(&abnrm, gpu_abnrm, 8UL, cudaMemcpyDeviceToHost);
                  na = (static_cast<int32_T>(abnrm) - 1) / 2;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    ((na - 2) + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                               cudaMemcpyHostToDevice);
                    ecu_detrend_kernel108<<<grid, block>>>(rconde, i2, na - 2,
                      gpu_d2scaled, o_gpu_y);
                    y_dirtyOnGpu = false;
                  }

                  if (na << 1 == i2 - 1) {
                    if (y_dirtyOnGpu) {
                      cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                                 cudaMemcpyHostToDevice);
                    }

                    cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
                    ecu_detrend_kernel111<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, gpu_d2scaled, gpu_na, o_gpu_y);
                    l_y_dirtyOnCpu = false;
                    k_y_dirtyOnGpu = true;
                  } else {
                    if (y_dirtyOnGpu) {
                      cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                                 cudaMemcpyHostToDevice);
                    }

                    cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
                    ecu_detrend_kernel109<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (gpu_d2scaled, gpu_na, o_gpu_y);
                    ecu_detrend_kernel110<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, gpu_na, o_gpu_y);
                    l_y_dirtyOnCpu = false;
                    k_y_dirtyOnGpu = true;
                  }
                }
              }
            }

            i = b->size[0];
            b->size[0] = c_a->size[1] + p_y->size[1];
            emxEnsureCapacity_real_T(b, i, &td_emlrtRTEI);
            if (!b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b, &gpu_b);
            }

            npages = c_a->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
              }

              ecu_detrend_kernel113<<<grid, block>>>(wsize2, npages, gpu_b);
              b_dirtyOnCpu = false;
              b_dirtyOnGpu = true;
            }

            npages = p_y->size[1];
            for (i = 0; i < npages; i++) {
              if (b_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b, &gpu_b);
              }

              if (k_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(p_y, &o_gpu_y);
              }

              k_y_dirtyOnGpu = false;
              b->data[i + c_a->size[1]] = p_y->data[i];
              a_dirtyOnCpu = true;
              b_dirtyOnGpu = false;
              b_dirtyOnCpu = true;
            }
          } else if (stop == dims_idx_0) {
            // 'ec_detrendCompute:172' elseif stop==dims(1)
            // 'ec_detrendCompute:173' b = [1:wsize2/2, ones(1,wsize2/2)*wsize2/2]';
            d2scaled = wsize2 / 2.0;
            if (d2scaled < 1.0) {
              r_y->size[0] = 1;
              r_y->size[1] = 0;
            } else {
              i = r_y->size[0] * r_y->size[1];
              r_y->size[0] = 1;
              r_y->size[1] = static_cast<int32_T>(d2scaled - 1.0) + 1;
              emxEnsureCapacity_real_T(r_y, i, &qd_emlrtRTEI);
              if (!j_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(r_y, &m_gpu_y);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int32_T>(d2scaled - 1.0) + 1L), &grid, &block, 1024U,
                65535U);
              if (validLaunchParams) {
                if (j_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_y, r_y);
                }

                ecu_detrend_kernel103<<<grid, block>>>(d2scaled, m_gpu_y);
                j_y_dirtyOnCpu = false;
              }
            }

            i = d_a->size[0] * d_a->size[1];
            d_a->size[0] = 1;
            d_a->size[1] = static_cast<int32_T>(wsize2 / 2.0);
            emxEnsureCapacity_int8_T(d_a, i, &rd_emlrtRTEI);
            gpuEmxEnsureCapacity_int8_T(d_a, &c_gpu_a);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
              static_cast<int32_T>(wsize2 / 2.0) - 1) + 1L), &grid, &block,
              1024U, 65535U);
            if (validLaunchParams) {
              ecu_detrend_kernel104<<<grid, block>>>(wsize2, c_gpu_a);
            }

            i = b->size[0];
            b->size[0] = r_y->size[1] + d_a->size[1];
            emxEnsureCapacity_real_T(b, i, &ud_emlrtRTEI);
            if (!b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b, &gpu_b);
            }

            npages = r_y->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (j_y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_y, r_y);
              }

              j_y_dirtyOnCpu = false;
              if (b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
              }

              ecu_detrend_kernel105<<<grid, block>>>(m_gpu_y, npages, gpu_b);
              b_dirtyOnCpu = false;
              b_dirtyOnGpu = true;
            }

            npages = d_a->size[1];
            for (i = 0; i < npages; i++) {
              if (b_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b, &gpu_b);
              }

              b->data[i + r_y->size[1]] = wsize2 / 2.0;
              j_y_dirtyOnCpu = true;
              b_dirtyOnGpu = false;
              b_dirtyOnCpu = true;
            }
          } else {
            // 'ec_detrendCompute:174' else
            // 'ec_detrendCompute:175' b = [1:wsize2/2, wsize2/2:-1:1]';
            d2scaled = wsize2 / 2.0;
            if (d2scaled < 1.0) {
              q_y->size[0] = 1;
              q_y->size[1] = 0;
            } else {
              i = q_y->size[0] * q_y->size[1];
              q_y->size[0] = 1;
              q_y->size[1] = static_cast<int32_T>(d2scaled - 1.0) + 1;
              emxEnsureCapacity_real_T(q_y, i, &qd_emlrtRTEI);
              if (!i_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(q_y, &l_gpu_y);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int32_T>(d2scaled - 1.0) + 1L), &grid, &block, 1024U,
                65535U);
              if (validLaunchParams) {
                if (i_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_y, q_y);
                }

                ecu_detrend_kernel95<<<grid, block>>>(d2scaled, l_gpu_y);
                i_y_dirtyOnCpu = false;
              }
            }

            d2scaled = wsize2 / 2.0;
            y_dirtyOnGpu = true;
            if (d2scaled < 1.0) {
              s_y->size[0] = 1;
              s_y->size[1] = 0;
            } else if (std::floor(d2scaled) == d2scaled) {
              i = s_y->size[0] * s_y->size[1];
              s_y->size[0] = 1;
              s_y->size[1] = static_cast<int32_T>(-(1.0 - d2scaled)) + 1;
              emxEnsureCapacity_real_T(s_y, i, &sd_emlrtRTEI);
              if (!k_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(s_y, &n_gpu_y);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int32_T>(-(1.0 - d2scaled)) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                if (k_y_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_y, s_y);
                }

                cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
                ecu_detrend_kernel101<<<grid, block>>>(n_gpu_y, gpu_d2scaled);
                k_y_dirtyOnCpu = false;
                j_y_dirtyOnGpu = true;
              }
            } else {
              abnrm = std::floor(-(1.0 - d2scaled) + 0.5);
              rconde = d2scaled - abnrm;
              if (std::abs(1.0 - rconde) < 4.4408920985006262E-16 * d2scaled) {
                abnrm++;
                rconde = 1.0;
              } else if (1.0 - rconde > 0.0) {
                rconde = d2scaled - (abnrm - 1.0);
              } else {
                abnrm++;
              }

              i2 = static_cast<int32_T>(abnrm);
              i = s_y->size[0] * s_y->size[1];
              s_y->size[0] = 1;
              s_y->size[1] = static_cast<int32_T>(abnrm);
              emxEnsureCapacity_real_T(s_y, i, &wd_emlrtRTEI);
              if (!k_y_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(s_y, &n_gpu_y);
              }

              if (static_cast<int32_T>(abnrm) > 0) {
                if (j_y_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(s_y, &n_gpu_y);
                }

                s_y->data[0] = d2scaled;
                j_y_dirtyOnGpu = false;
                k_y_dirtyOnCpu = true;
                if (static_cast<int32_T>(abnrm) > 1) {
                  cudaMemcpy(gpu_abnrm, &abnrm, 8UL, cudaMemcpyHostToDevice);
                  gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_y, s_y);
                  ecu_detrend_kernel96<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (rconde, gpu_abnrm, n_gpu_y);
                  cudaMemcpy(&abnrm, gpu_abnrm, 8UL, cudaMemcpyDeviceToHost);
                  na = (static_cast<int32_T>(abnrm) - 1) / 2;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    ((na - 2) + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                               cudaMemcpyHostToDevice);
                    ecu_detrend_kernel97<<<grid, block>>>(rconde, i2, na - 2,
                      gpu_d2scaled, n_gpu_y);
                    y_dirtyOnGpu = false;
                  }

                  if (na << 1 == i2 - 1) {
                    if (y_dirtyOnGpu) {
                      cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                                 cudaMemcpyHostToDevice);
                    }

                    cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
                    ecu_detrend_kernel100<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, gpu_d2scaled, gpu_na, n_gpu_y);
                    k_y_dirtyOnCpu = false;
                    j_y_dirtyOnGpu = true;
                  } else {
                    if (y_dirtyOnGpu) {
                      cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL,
                                 cudaMemcpyHostToDevice);
                    }

                    cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
                    ecu_detrend_kernel98<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (gpu_d2scaled, gpu_na, n_gpu_y);
                    ecu_detrend_kernel99<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, gpu_na, n_gpu_y);
                    k_y_dirtyOnCpu = false;
                    j_y_dirtyOnGpu = true;
                  }
                }
              }
            }

            i = b->size[0];
            b->size[0] = q_y->size[1] + s_y->size[1];
            emxEnsureCapacity_real_T(b, i, &vd_emlrtRTEI);
            if (!b_dirtyOnCpu) {
              gpuEmxEnsureCapacity_real_T(b, &gpu_b);
            }

            npages = q_y->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (i_y_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_y, q_y);
              }

              i_y_dirtyOnCpu = false;
              if (b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
              }

              ecu_detrend_kernel102<<<grid, block>>>(l_gpu_y, npages, gpu_b);
              b_dirtyOnCpu = false;
              b_dirtyOnGpu = true;
            }

            npages = s_y->size[1];
            for (i = 0; i < npages; i++) {
              if (b_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b, &gpu_b);
              }

              if (j_y_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(s_y, &n_gpu_y);
              }

              j_y_dirtyOnGpu = false;
              b->data[i + q_y->size[1]] = s_y->data[i];
              i_y_dirtyOnCpu = true;
              b_dirtyOnGpu = false;
              b_dirtyOnCpu = true;
            }
          }

          //  overlap-add to output
          // 'ec_detrendCompute:179' y(start:stop,:) = y(start:stop,:) + (yy.*b);
          if (start > stop) {
            npages = 0;
            ntilecols = -1;
            na = 0;
          } else {
            npages = static_cast<int32_T>(start) - 1;
            ntilecols = static_cast<int32_T>(stop) - 1;
            na = static_cast<int32_T>(start) - 1;
          }

          if (yy->size[0] == 1) {
            o_x = b->size[0];
          } else {
            o_x = yy->size[0];
          }

          if ((yy->size[0] == b->size[0]) && ((ntilecols - npages) + 1 == o_x))
          {
            i = n_x->size[0];
            n_x->size[0] = (ntilecols - npages) + 1;
            emxEnsureCapacity_real_T(n_x, i, &xd_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(n_x, &m_gpu_x);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((ntilecols - npages) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
              }

              b_dirtyOnCpu = false;
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, yy);
              }

              yy_dirtyOnCpu = false;
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
              }

              b_x_dirtyOnCpu = false;
              ecu_detrend_kernel114<<<grid, block>>>(gpu_b, gpu_yy, b_gpu_x,
                npages, ntilecols, m_gpu_x);
            }

            o_x = n_x->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
              if (b_x_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
              }

              ecu_detrend_kernel115<<<grid, block>>>(m_gpu_x, o_x, gpu_na,
                b_gpu_x);
              b_x_dirtyOnCpu = false;
              b_x_dirtyOnGpu = true;
            }
          } else {
            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
            }

            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(yy, &gpu_yy);
            }

            yy_dirtyOnGpu = false;
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b, &gpu_b);
            }

            b_dirtyOnGpu = false;
            binary_expand_op(b_x, na, npages, ntilecols, yy, b);
            b_x_dirtyOnGpu = false;
            b_x_dirtyOnCpu = true;
          }

          // bsxfun(@times,yy,b);
          // 'ec_detrendCompute:180' trend(start:stop,:) = trend(start:stop,:) + (x(start:stop,:)-yy).*b;
          if (start > stop) {
            ntilecols = 0;
            na = -1;
            i2 = 0;
            npages = 0;
            nx = 0;
          } else {
            ntilecols = static_cast<int32_T>(start) - 1;
            na = static_cast<int32_T>(stop) - 1;
            i2 = static_cast<int32_T>(start) - 1;
            npages = static_cast<int32_T>(stop);
            nx = static_cast<int32_T>(start) - 1;
          }

          if (npages - i2 == 1) {
            o_x = yy->size[0];
            x_dim0 = yy->size[0];
          } else {
            o_x = npages - i2;
            x_dim0 = npages - i2;
          }

          if (x_dim0 == 1) {
            x_dim0 = b->size[0];
          } else if (npages - i2 == 1) {
            x_dim0 = yy->size[0];
          } else {
            x_dim0 = npages - i2;
          }

          if ((npages - i2 == yy->size[0]) && (o_x == b->size[0]) && ((na -
                ntilecols) + 1 == x_dim0)) {
            i = b_trend->size[0];
            b_trend->size[0] = (na - ntilecols) + 1;
            emxEnsureCapacity_real_T(b_trend, i, &yd_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_trend, &b_gpu_trend);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((na
              - ntilecols) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
              }

              b_dirtyOnCpu = false;
              if (yy_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, yy);
              }

              yy_dirtyOnCpu = false;
              if (dv1_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
              }

              dv1_dirtyOnCpu = false;
              if (trend_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
              }

              trend_dirtyOnCpu = false;
              cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
              ecu_detrend_kernel116<<<grid, block>>>(gpu_b, gpu_yy, gpu_dv1, i2,
                gpu_trend, ntilecols, gpu_na, b_gpu_trend);
            }

            o_x = b_trend->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (trend_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
              }

              ecu_detrend_kernel117<<<grid, block>>>(b_gpu_trend, nx, o_x,
                gpu_trend);
              trend_dirtyOnCpu = false;
              trend_dirtyOnGpu = true;
            }
          } else {
            if (trend_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(trend, &gpu_trend);
            }

            if (dv1_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
            }

            dv1_dirtyOnGpu = false;
            if (yy_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(yy, &gpu_yy);
            }

            yy_dirtyOnGpu = false;
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b, &gpu_b);
            }

            b_dirtyOnGpu = false;
            binary_expand_op(trend, nx, ntilecols, na, dv1, i2, npages - 1, yy,
                             b);
            trend_dirtyOnGpu = false;
            trend_dirtyOnCpu = true;
          }

          // bsxfun(@times,x(start:stop,:)-yy,b);
          // 'ec_detrendCompute:181' a(start:stop,1) = a(start:stop)+b;
          if (start > stop) {
            npages = 0;
            ntilecols = -1;
            na = 0;
          } else {
            npages = static_cast<int32_T>(start) - 1;
            ntilecols = static_cast<int32_T>(stop) - 1;
            na = static_cast<int32_T>(start) - 1;
          }

          if ((ntilecols - npages) + 1 == b->size[0]) {
            i = f_a->size[0];
            f_a->size[0] = (ntilecols - npages) + 1;
            emxEnsureCapacity_real_T(f_a, i, &ae_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(f_a, &e_gpu_a);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((ntilecols - npages) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
              }

              b_dirtyOnCpu = false;
              if (b_a_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, a);
              }

              b_a_dirtyOnCpu = false;
              ecu_detrend_kernel118<<<grid, block>>>(gpu_b, d_gpu_a, npages,
                ntilecols, e_gpu_a);
            }

            o_x = f_a->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
              if (b_a_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, a);
              }

              ecu_detrend_kernel119<<<grid, block>>>(e_gpu_a, o_x, gpu_na,
                d_gpu_a);
              b_a_dirtyOnCpu = false;
              a_dirtyOnGpu = true;
            }
          } else {
            if (a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(a, &d_gpu_a);
            }

            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b, &gpu_b);
            }

            b_dirtyOnGpu = false;
            binary_expand_op(a, na, npages, ntilecols, b);
            a_dirtyOnGpu = false;
            b_a_dirtyOnCpu = true;
          }

          // 'ec_detrendCompute:182' offset = offset+wsize/2;
          offset += b_wsize / 2.0;

          // 'ec_detrendCompute:183' if offset > dims(1)-wsize/2
        } while (!(offset > static_cast<real_T>(dims_idx_0) - b_wsize / 2.0));

        // 'ec_detrendCompute:183' ;
        // 'ec_detrendCompute:186' if stop<dims(1)
        if (stop < dims_idx_0) {
          //  last sample can be missed
          // 'ec_detrendCompute:187' y(end,:) = y(end-1,:);
          x_dim0 = b_x->size[0];
          o_x = a->size[0];
          if (b_a_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, a);
          }

          if (b_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
          }

          ecu_detrend_kernel120<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(x_dim0,
            o_x, d_gpu_a, b_gpu_x);
          b_x_dirtyOnCpu = false;
          b_x_dirtyOnGpu = true;
          b_a_dirtyOnCpu = false;
          a_dirtyOnGpu = true;
        }

        // 'ec_detrendCompute:190' y = y.*(1./a);
        if (b_x->size[0] == a->size[0]) {
          o_x = b_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_a_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, a);
            }

            b_a_dirtyOnCpu = false;
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
            }

            ecu_detrend_kernel121<<<grid, block>>>(d_gpu_a, o_x, b_gpu_x);
            b_x_dirtyOnCpu = false;
            b_x_dirtyOnGpu = true;
          }
        } else {
          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_x, &b_gpu_x);
          }

          if (a_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(a, &d_gpu_a);
          }

          a_dirtyOnGpu = false;
          binary_expand_op(b_x, a);
          b_x_dirtyOnGpu = false;
          b_x_dirtyOnCpu = true;
        }

        // bsxfun(@times,y,1./a);
        // 'ec_detrendCompute:191' y(isnan(y)) = 0;
        i = bv8->size[0];
        bv8->size[0] = b_x->size[0];
        emxEnsureCapacity_boolean_T(bv8, i, &be_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv8, &gpu_bv8);
        o_x = b_x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
          }

          b_x_dirtyOnCpu = false;
          ecu_detrend_kernel122<<<grid, block>>>(b_gpu_x, o_x, gpu_bv8);
          bv8_dirtyOnGpu = true;
        }

        na = bv8->size[0] - 1;
        npages = 0;
        for (o_x = 0; o_x <= na; o_x++) {
          if (bv8_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv8, &gpu_bv8);
          }

          bv8_dirtyOnGpu = false;
          if (bv8->data[o_x]) {
            npages++;
          }
        }

        i = iv37->size[0];
        iv37->size[0] = npages;
        emxEnsureCapacity_int32_T(iv37, i, &ce_emlrtRTEI);
        if (!iv37_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(iv37, &gpu_iv37);
        }

        npages = 0;
        for (o_x = 0; o_x <= na; o_x++) {
          if (bv8_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv8, &gpu_bv8);
          }

          bv8_dirtyOnGpu = false;
          if (bv8->data[o_x]) {
            iv37->data[npages] = o_x + 1;
            iv37_dirtyOnCpu = true;
            npages++;
          }
        }

        o_x = iv37->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv37_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv37, iv37);
          }

          iv37_dirtyOnCpu = false;
          if (b_x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
          }

          ecu_detrend_kernel123<<<grid, block>>>(gpu_iv37, o_x, b_gpu_x);
          b_x_dirtyOnCpu = false;
          b_x_dirtyOnGpu = true;
        }

        // 'ec_detrendCompute:192' trend = trend.*(1./a);
        if (trend->size[0] == a->size[0]) {
          o_x = trend->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_a_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_a, a);
            }

            b_a_dirtyOnCpu = false;
            if (trend_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
            }

            ecu_detrend_kernel124<<<grid, block>>>(d_gpu_a, o_x, gpu_trend);
            trend_dirtyOnCpu = false;
            trend_dirtyOnGpu = true;
          }
        } else {
          if (trend_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(trend, &gpu_trend);
          }

          if (a_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(a, &d_gpu_a);
          }

          a_dirtyOnGpu = false;
          binary_expand_op(trend, a);
          trend_dirtyOnGpu = false;
          trend_dirtyOnCpu = true;
        }

        // bsxfun(@times,trend,1./a);
        // 'ec_detrendCompute:193' trend(isnan(trend)) = 0;
        i = bv9->size[0];
        bv9->size[0] = trend->size[0];
        emxEnsureCapacity_boolean_T(bv9, i, &de_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv9, &gpu_bv9);
        o_x = trend->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (trend_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
          }

          trend_dirtyOnCpu = false;
          ecu_detrend_kernel125<<<grid, block>>>(gpu_trend, o_x, gpu_bv9);
          bv9_dirtyOnGpu = true;
        }

        na = bv9->size[0] - 1;
        npages = 0;
        for (o_x = 0; o_x <= na; o_x++) {
          if (bv9_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv9, &gpu_bv9);
          }

          bv9_dirtyOnGpu = false;
          if (bv9->data[o_x]) {
            npages++;
          }
        }

        i = iv38->size[0];
        iv38->size[0] = npages;
        emxEnsureCapacity_int32_T(iv38, i, &ce_emlrtRTEI);
        if (!iv38_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(iv38, &gpu_iv38);
        }

        npages = 0;
        for (o_x = 0; o_x <= na; o_x++) {
          if (bv9_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv9, &gpu_bv9);
          }

          bv9_dirtyOnGpu = false;
          if (bv9->data[o_x]) {
            iv38->data[npages] = o_x + 1;
            iv38_dirtyOnCpu = true;
            npages++;
          }
        }

        o_x = iv38->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv38_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv38, iv38);
          }

          iv38_dirtyOnCpu = false;
          if (trend_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
          }

          ecu_detrend_kernel126<<<grid, block>>>(gpu_iv38, o_x, gpu_trend);
          trend_dirtyOnCpu = false;
          trend_dirtyOnGpu = true;
        }

        //  find outliers
        // 'ec_detrendCompute:196' d = x-trend;
        if (dv1->size[0] == trend->size[0]) {
          i = e_d->size[0];
          e_d->size[0] = dv1->size[0];
          emxEnsureCapacity_real_T(e_d, i, &ee_emlrtRTEI);
          if (!c_d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(e_d, &c_gpu_d);
          }

          o_x = dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (trend_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, trend);
            }

            trend_dirtyOnCpu = false;
            if (dv1_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
            }

            dv1_dirtyOnCpu = false;
            if (c_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, e_d);
            }

            ecu_detrend_kernel127<<<grid, block>>>(gpu_trend, gpu_dv1, o_x,
              c_gpu_d);
            c_d_dirtyOnCpu = false;
            c_d_dirtyOnGpu = true;
          }
        } else {
          if (c_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_d, &c_gpu_d);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (trend_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(trend, &gpu_trend);
          }

          trend_dirtyOnGpu = false;
          minus(e_d, dv1, trend);
          c_d_dirtyOnGpu = false;
          c_d_dirtyOnCpu = true;
        }

        // 'ec_detrendCompute:197' if ~isempty(w)
        if (b_w->size[0] != 0) {
          // 'ec_detrendCompute:197' ;
          // 'ec_detrendCompute:197' d = d.*w;
          if (e_d->size[0] == b_w->size[0]) {
            o_x = e_d->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_w_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
              }

              b_w_dirtyOnCpu = false;
              if (c_d_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, e_d);
              }

              ecu_detrend_kernel128<<<grid, block>>>(b_gpu_w, o_x, c_gpu_d);
              c_d_dirtyOnCpu = false;
              c_d_dirtyOnGpu = true;
            }
          } else {
            if (c_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_d, &c_gpu_d);
            }

            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
            }

            b_w_dirtyOnGpu = false;
            binary_expand_op(e_d, b_w);
            c_d_dirtyOnGpu = false;
            c_d_dirtyOnCpu = true;
          }
        }

        // bsxfun(@times,d,w); end
        // 'ec_detrendCompute:198' ww = true(size(x));
        if (outsize_dirtyOnGpu) {
          cudaMemcpy(outsize, *gpu_outsize, 8UL, cudaMemcpyDeviceToHost);
        }

        outsize[0] = static_cast<uint32_T>(x->size[0]);
        outsize_dirtyOnGpu = false;
        outsize_dirtyOnCpu = true;
        i = j_ww->size[0];
        j_ww->size[0] = static_cast<int32_T>(outsize[0]);
        emxEnsureCapacity_boolean_T(j_ww, i, &fe_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(j_ww, &j_gpu_ww);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(outsize[0]) - 1) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          ecu_detrend_kernel129<<<grid, block>>>(static_cast<int32_T>(outsize[0])
            - 1, j_gpu_ww);
          j_ww_dirtyOnGpu = true;
        }

        // 'ec_detrendCompute:199' ww(abs(d) > thresh*repmat(std(d),dims(1),1)) = false;
        nx = e_d->size[0] - 1;
        i = dv23->size[0];
        dv23->size[0] = e_d->size[0];
        emxEnsureCapacity_real_T(dv23, i, &kd_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(dv23, &gpu_dv23);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, e_d);
          }

          c_d_dirtyOnCpu = false;
          ecu_detrend_kernel130<<<grid, block>>>(c_gpu_d, nx, gpu_dv23);
          dv23_dirtyOnGpu = true;
        }

        i2 = e_d->size[0] - 2;
        if (e_d->size[0] == 0) {
          d2scaled = rtNaN;
        } else if (e_d->size[0] == 1) {
          if (c_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_d, &c_gpu_d);
          }

          c_d_dirtyOnGpu = false;
          if ((!std::isinf(e_d->data[0])) && (!std::isnan(e_d->data[0]))) {
            d2scaled = 0.0;
          } else {
            d2scaled = rtNaN;
          }
        } else {
          if (c_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_d, &c_gpu_d);
          }

          c_d_dirtyOnGpu = false;
          d2scaled = e_d->data[0];
          for (o_x = 0; o_x <= i2; o_x++) {
            d2scaled += e_d->data[o_x + 1];
          }

          d2scaled /= static_cast<real_T>(e_d->size[0]);
          i = c_absdiff->size[0];
          c_absdiff->size[0] = e_d->size[0];
          emxEnsureCapacity_real_T(c_absdiff, i, &md_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_absdiff, &c_gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i2 +
            1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, e_d);
            }

            c_d_dirtyOnCpu = false;
            cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
            ecu_detrend_kernel131<<<grid, block>>>(c_gpu_d, i2, gpu_d2scaled,
              c_gpu_absdiff);
            cudaMemcpy(&d2scaled, gpu_d2scaled, 8UL, cudaMemcpyDeviceToHost);
          }

          cublasDnrm2(getCublasGlobalHandle(), e_d->size[0], (double *)
                      &c_gpu_absdiff.data[0], 1, (double *)&d2scaled);
          d2scaled /= std::sqrt(static_cast<real_T>(e_d->size[0]) - 1.0);
        }

        if (dv23->size[0] == static_cast<int32_T>(dims_idx_0)) {
          i = bv10->size[0];
          bv10->size[0] = dv23->size[0];
          emxEnsureCapacity_boolean_T(bv10, i, &ge_emlrtRTEI);
          if (!bv10_dirtyOnCpu) {
            gpuEmxEnsureCapacity_boolean_T(bv10, &gpu_bv10);
          }

          o_x = dv23->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
            if (bv10_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&gpu_bv10, bv10);
            }

            ecu_detrend_kernel132<<<grid, block>>>(thresh, gpu_dv23, o_x,
              gpu_d2scaled, gpu_bv10);
            bv10_dirtyOnCpu = false;
            bv10_dirtyOnGpu = true;
          }
        } else {
          if (bv10_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv10, &gpu_bv10);
          }

          if (dv23_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv23, &gpu_dv23);
          }

          dv23_dirtyOnGpu = false;
          binary_expand_op(bv10, dv23, thresh, d2scaled, b_outsize);
          bv10_dirtyOnGpu = false;
          bv10_dirtyOnCpu = true;
        }

        na = bv10->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (bv10_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_boolean_T(&gpu_bv10, bv10);
          }

          bv10_dirtyOnCpu = false;
          cudaMemcpy(gpu_na, &na, 4UL, cudaMemcpyHostToDevice);
          ecu_detrend_kernel133<<<grid, block>>>(gpu_bv10, gpu_na, j_gpu_ww);
          j_ww_dirtyOnGpu = true;
        }

        //  update weights
        // 'ec_detrendCompute:202' if isempty(w)
        if (b_w->size[0] == 0) {
          // 'ec_detrendCompute:203' w = ww;
          i = b_w->size[0];
          b_w->size[0] = j_ww->size[0];
          emxEnsureCapacity_boolean_T(b_w, i, &he_emlrtRTEI);
          if (!b_w_dirtyOnCpu) {
            gpuEmxEnsureCapacity_boolean_T(b_w, &b_gpu_w);
          }

          o_x = j_ww->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            ecu_detrend_kernel136<<<grid, block>>>(j_gpu_ww, o_x, b_gpu_w);
            b_w_dirtyOnCpu = false;
            b_w_dirtyOnGpu = true;
          }
        } else {
          // 'ec_detrendCompute:204' else
          // 'ec_detrendCompute:205' w = min(w,ww);
          i = e_a->size[0];
          e_a->size[0] = b_w->size[0];
          emxEnsureCapacity_boolean_T(e_a, i, &od_emlrtRTEI);
          gpuEmxEnsureCapacity_boolean_T(e_a, &f_gpu_a);
          x_dim0 = b_w->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_w_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
            }

            b_w_dirtyOnCpu = false;
            ecu_detrend_kernel134<<<grid, block>>>(b_gpu_w, x_dim0, f_gpu_a);
          }

          if (b_w->size[0] == j_ww->size[0]) {
            i2 = e_a->size[0];
            npages = j_ww->size[0];
            if (i2 <= npages) {
              npages = i2;
            }

            i = b_w->size[0];
            b_w->size[0] = npages;
            emxEnsureCapacity_boolean_T(b_w, i, &o_emlrtRTEI);
            if (!b_w_dirtyOnCpu) {
              gpuEmxEnsureCapacity_boolean_T(b_w, &b_gpu_w);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((npages - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_w_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
              }

              ecu_detrend_kernel135<<<grid, block>>>(j_gpu_ww, f_gpu_a, npages -
                1, b_gpu_w);
              b_w_dirtyOnCpu = false;
              b_w_dirtyOnGpu = true;
            }
          } else {
            i = c_w->size[0];
            c_w->size[0] = b_w->size[0];
            emxEnsureCapacity_boolean_T(c_w, i, &od_emlrtRTEI);
            npages = b_w->size[0] - 1;
            for (i = 0; i <= npages; i++) {
              if (b_w_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
              }

              b_w_dirtyOnGpu = false;
              c_w->data[i] = b_w->data[i];
            }

            if (j_ww_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(j_ww, &j_gpu_ww);
            }

            j_ww_dirtyOnGpu = false;
            if (b_w_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_boolean_T(b_w, &b_gpu_w);
            }

            coder::internal::expand_min(c_w, j_ww, b_w);
            b_w_dirtyOnGpu = false;
            b_w_dirtyOnCpu = true;
          }
        }
      }

      i = dv1->size[0];
      dv1->size[0] = b_x->size[0];
      emxEnsureCapacity_real_T(dv1, i, &h_emlrtRTEI);
      if (!dv1_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(dv1, &gpu_dv1);
      }

      o_x = b_x->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (b_x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_x);
        }

        b_x_dirtyOnCpu = false;
        if (dv1_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
        }

        ecu_detrend_kernel137<<<grid, block>>>(b_gpu_x, o_x, gpu_dv1);
        dv1_dirtyOnCpu = false;
        dv1_dirtyOnGpu = true;
      }

      // 'ec_detrendCompute:43' r = [];
    }

    o_x = dv1->size[0] - 1;
    x_dim0 = x->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(o_x + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (dv1_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, dv1);
      }

      dv1_dirtyOnCpu = false;
      if (x_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
      }

      ecu_detrend_kernel233<<<grid, block>>>(gpu_dv1, ch, o_x, x_dim0, gpu_x);
      x_dirtyOnCpu = false;
      x_dirtyOnGpu = true;
    }

    x_dim0 = b_w->size[0] - 1;
    o_x = w->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0 + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (b_w_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_boolean_T(&b_gpu_w, b_w);
      }

      b_w_dirtyOnCpu = false;
      if (w_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_boolean_T(&gpu_w, w);
      }

      ecu_detrend_kernel234<<<grid, block>>>(b_gpu_w, ch, x_dim0, o_x, gpu_w);
      w_dirtyOnCpu = false;
      w_dirtyOnGpu = true;
    }

    // ,doubleIn,singleOut);
  }

  emxFree_boolean_T(&d_w);
  emxFree_boolean_T(&c_w);
  emxFree_real_T(&f_a);
  emxFree_real_T(&b_trend);
  emxFree_real_T(&n_x);
  emxFree_real_T(&d_r);
  emxFree_real_T(&c_r);
  emxFree_boolean_T(&e_a);
  emxFree_boolean_T(&bv10);
  emxFree_real_T(&c_absdiff);
  emxFree_real_T(&dv23);
  emxFree_boolean_T(&j_ww);
  emxFree_real_T(&e_d);
  emxFree_int32_T(&iv38);
  emxFree_boolean_T(&bv9);
  emxFree_int32_T(&iv37);
  emxFree_boolean_T(&bv8);
  emxFree_int8_T(&d_a);
  emxFree_real_T(&s_y);
  emxFree_real_T(&b);
  emxFree_real_T(&r_y);
  emxFree_real_T(&q_y);
  emxFree_real_T(&p_y);
  emxFree_int8_T(&c_a);
  emxFree_real_T(&b_absdiff);
  emxFree_real_T(&d_d);
  emxFree_boolean_T(&b_a);
  emxFree_boolean_T(&bv6);
  emxFree_real_T(&absdiff);
  emxFree_real_T(&dv20);
  emxFree_boolean_T(&i_ww);
  emxFree_real_T(&c_d);
  emxFree_real_T(&yy);
  emxFree_real_T(&d_B);
  emxFree_real_T(&o_y);
  emxFree_real_T(&m_x);
  emxFree_real_T(&n_y);
  emxFree_real_T(&m_y);
  emxFree_boolean_T(&h_ww);
  emxFree_ptrdiff_t(&b_jpvt_t);
  emxFree_real_T(&f_tau);
  emxFree_int32_T(&b_ipiv_t);
  emxFree_int32_T(&b_jpvt);
  emxFree_int32_T(&b_ipiv);
  emxFree_real_T(&c_B);
  emxFree_real_T(&l_A);
  emxFree_real_T(&b_Y);
  emxFree_real_T(&k_A);
  emxFree_real_T(&b_vright);
  emxFree_real_T(&d_wi);
  emxFree_real_T(&j_A);
  emxFree_real_T(&b_wimag);
  emxFree_real_T(&b_B);
  emxFree_real_T(&d_wr);
  emxFree_real_T(&b_X);
  emxFree_real_T(&b_wreal);
  emxFree_real_T(&l_y);
  emxFree_creal_T(&b_dt);
  emxFree_real_T(&i_A);
  emxFree_real_T(&c_wi);
  emxFree_real_T(&b_U);
  emxFree_real_T(&e_tau);
  emxFree_real_T(&c_wr);
  emxFree_real_T(&b_scale);
  emxFree_real_T(&b_xxx);
  emxFree_real_T(&l_x);
  emxFree_real_T(&k_x);
  emxFree_real_T(&k_y);
  emxFree_real_T(&d_V);
  emxFree_real_T(&d_tau);
  emxFree_real_T(&b_topcs);
  emxFree_real_T(&j_y);
  emxFree_boolean_T(&g_ww);
  emxFree_int8_T(&iv26);
  emxFree_boolean_T(&bv5);
  emxFree_real_T(&b_v);
  emxFree_real_T(&b_d);
  emxFree_creal_T(&b_D);
  emxFree_creal_T(&c_V);
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_real_T(&c_tau);
  emxFree_real_T(&h_A);
  emxFree_int32_T(&ipiv_t);
  emxFree_real_T(&g_A);
  emxFree_real_T(&b_xx);
  emxFree_int32_T(&jpvt);
  emxFree_int32_T(&ipiv);
  emxFree_real_T(&B);
  emxFree_real_T(&f_A);
  emxFree_real_T(&Y);
  emxFree_boolean_T(&bv4);
  emxFree_real_T(&e_A);
  emxFree_real_T(&dv13);
  emxFree_real_T(&j_x);
  emxFree_real_T(&vright);
  emxFree_real_T(&i_y);
  emxFree_real_T(&b_wi);
  emxFree_real_T(&d_A);
  emxFree_real_T(&wimag);
  emxFree_real_T(&b_wr);
  emxFree_real_T(&X);
  emxFree_real_T(&wreal);
  emxFree_real_T(&h_y);
  emxFree_creal_T(&dt);
  emxFree_real_T(&c_A);
  emxFree_boolean_T(&f_ww);
  emxFree_real_T(&wi);
  emxFree_real_T(&U);
  emxFree_real_T(&b_tau);
  emxFree_real_T(&wr);
  emxFree_real_T(&scale);
  emxFree_real_T(&xxx);
  emxFree_real_T(&b_V);
  emxFree_real_T(&tau);
  emxFree_real_T(&topcs);
  emxFree_int8_T(&iv19);
  emxFree_boolean_T(&bv3);
  emxFree_real_T(&v);
  emxFree_real_T(&d);
  emxFree_creal_T(&D);
  emxFree_creal_T(&V);
  emxFree_boolean_T(&bv2);
  emxFree_real_T(&b_A);
  emxFree_real_T(&A);
  emxFree_real_T(&xx);
  emxFree_real_T(&dv8);
  emxFree_real_T(&i_x);
  emxFree_boolean_T(&bv1);
  emxFree_boolean_T(&e_ww);
  emxFree_real_T(&dv7);
  emxFree_real_T(&h_x);
  emxFree_real_T(&g_y);
  emxFree_real_T(&f_y);
  emxFree_boolean_T(&d_ww);
  emxFree_real_T(&dv6);
  emxFree_real_T(&g_x);
  emxFree_boolean_T(&bv);
  emxFree_boolean_T(&c_ww);
  emxFree_real_T(&dv5);
  emxFree_real_T(&f_x);
  emxFree_boolean_T(&b_ww);
  emxFree_real_T(&dv4);
  emxFree_real_T(&e_x);
  emxFree_boolean_T(&ww);
  emxFree_real_T(&dv3);
  emxFree_real_T(&b_lin);
  emxFree_real_T(&b_r);
  emxFree_real_T(&d_x);
  emxFree_real_T(&dv2);
  emxFree_real_T(&lin);
  emxFree_real_T(&r);
  emxFree_int8_T(&minval);
  emxFree_real_T(&a);
  emxFree_real_T(&trend);
  emxFree_real_T(&b_x);
  emxFree_boolean_T(&b_w);
  emxFree_real_T(&dv1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
  }

  if (w_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_boolean_T(w, &gpu_w);
  }

  mwCudaFree(gpu_dc);
  gpuEmxFree_boolean_T(&gpu_y);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_dv1);
  gpuEmxFree_boolean_T(&gpu_w);
  gpuEmxFree_boolean_T(&b_gpu_w);
  gpuEmxFree_real_T(&b_gpu_x);
  gpuEmxFree_real_T(&gpu_r);
  gpuEmxFree_int8_T(&gpu_minval);
  mwCudaFree(gpu_d2scaled);
  gpuEmxFree_real_T(&gpu_lin);
  gpuEmxFree_real_T(&gpu_dv2);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_real_T(&b_gpu_r);
  gpuEmxFree_real_T(&b_gpu_lin);
  gpuEmxFree_real_T(&gpu_dv3);
  gpuEmxFree_boolean_T(&gpu_ww);
  mwCudaFree(gpu_na);
  gpuEmxFree_real_T(&gpu_dv4);
  gpuEmxFree_real_T(&d_gpu_x);
  gpuEmxFree_boolean_T(&b_gpu_ww);
  gpuEmxFree_boolean_T(&c_gpu_ww);
  gpuEmxFree_real_T(&gpu_dv5);
  gpuEmxFree_real_T(&e_gpu_x);
  gpuEmxFree_real_T(&f_gpu_x);
  gpuEmxFree_real_T(&gpu_dv6);
  gpuEmxFree_boolean_T(&gpu_bv);
  gpuEmxFree_boolean_T(&d_gpu_ww);
  gpuEmxFree_boolean_T(&e_gpu_ww);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&g_gpu_x);
  gpuEmxFree_real_T(&h_gpu_x);
  gpuEmxFree_real_T(&gpu_dv8);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&gpu_dv7);
  gpuEmxFree_boolean_T(&gpu_bv1);
  gpuEmxFree_boolean_T(&gpu_bv2);
  gpuEmxFree_real_T(&gpu_xx);
  gpuEmxFree_boolean_T(&f_gpu_ww);
  gpuEmxFree_real_T(&gpu_A);
  gpuEmxFree_real_T(&b_gpu_A);
  gpuEmxFree_creal_T(&gpu_D);
  gpuEmxFree_real_T(&gpu_v);
  gpuEmxFree_creal_T(&gpu_V);
  gpuEmxFree_real_T(&b_gpu_V);
  gpuEmxFree_real_T(&gpu_U);
  gpuEmxFree_real_T(&d_gpu_y);
  gpuEmxFree_boolean_T(&gpu_bv3);
  gpuEmxFree_real_T(&i_gpu_x);
  gpuEmxFree_real_T(&e_gpu_y);
  gpuEmxFree_real_T(&gpu_dv13);
  mwCudaFree(gpu_i);
  gpuEmxFree_boolean_T(&gpu_bv4);
  gpuEmxFree_real_T(&b_gpu_xx);
  gpuEmxFree_creal_T(&gpu_dt);
  gpuEmxFree_real_T(&gpu_topcs);
  gpuEmxFree_real_T(&c_gpu_A);
  gpuEmxFree_real_T(&d_gpu_A);
  gpuEmxFree_real_T(&gpu_xxx);
  gpuEmxFree_real_T(&e_gpu_A);
  gpuEmxFree_real_T(&gpu_X);
  gpuEmxFree_creal_T(&b_gpu_D);
  gpuEmxFree_real_T(&b_gpu_v);
  gpuEmxFree_creal_T(&c_gpu_V);
  gpuEmxFree_real_T(&d_gpu_V);
  gpuEmxFree_real_T(&b_gpu_U);
  gpuEmxFree_real_T(&f_gpu_A);
  gpuEmxFree_boolean_T(&gpu_bv5);
  gpuEmxFree_real_T(&g_gpu_A);
  mwCudaFree(&(*gpu_outsize)[0]);
  mwCudaFree(b_gpu_outsize);
  gpuEmxFree_int32_T(&gpu_ipiv_t);
  gpuEmxFree_creal_T(&b_gpu_dt);
  gpuEmxFree_real_T(&h_gpu_A);
  gpuEmxFree_real_T(&b_gpu_topcs);
  gpuEmxFree_real_T(&gpu_B);
  gpuEmxFree_int32_T(&gpu_ipiv);
  gpuEmxFree_boolean_T(&g_gpu_ww);
  gpuEmxFree_real_T(&b_gpu_xxx);
  gpuEmxFree_int32_T(&gpu_jpvt);
  gpuEmxFree_real_T(&i_gpu_A);
  gpuEmxFree_real_T(&b_gpu_X);
  gpuEmxFree_real_T(&gpu_tau);
  gpuEmxFree_real_T(&j_gpu_A);
  gpuEmxFree_real_T(&gpu_Y);
  gpuEmxFree_real_T(&k_gpu_A);
  gpuEmxFree_real_T(&f_gpu_y);
  gpuEmxFree_real_T(&j_gpu_x);
  gpuEmxFree_real_T(&g_gpu_y);
  gpuEmxFree_int32_T(&b_gpu_ipiv_t);
  gpuEmxFree_real_T(&k_gpu_x);
  gpuEmxFree_real_T(&l_gpu_A);
  gpuEmxFree_real_T(&h_gpu_y);
  gpuEmxFree_boolean_T(&h_gpu_ww);
  gpuEmxFree_real_T(&b_gpu_B);
  gpuEmxFree_int32_T(&b_gpu_ipiv);
  gpuEmxFree_real_T(&c_gpu_B);
  gpuEmxFree_int32_T(&b_gpu_jpvt);
  gpuEmxFree_real_T(&b_gpu_tau);
  gpuEmxFree_real_T(&b_gpu_Y);
  gpuEmxFree_real_T(&i_gpu_y);
  gpuEmxFree_real_T(&l_gpu_x);
  gpuEmxFree_real_T(&j_gpu_y);
  gpuEmxFree_real_T(&c_gpu_r);
  gpuEmxFree_real_T(&k_gpu_y);
  gpuEmxFree_real_T(&d_gpu_B);
  gpuEmxFree_real_T(&d_gpu_r);
  gpuEmxFree_real_T(&gpu_yy);
  gpuEmxFree_real_T(&gpu_d);
  gpuEmxFree_boolean_T(&i_gpu_ww);
  gpuEmxFree_real_T(&gpu_dv20);
  gpuEmxFree_boolean_T(&gpu_bv6);
  gpuEmxFree_real_T(&gpu_absdiff);
  gpuEmxFree_boolean_T(&gpu_a);
  gpuEmxFree_real_T(&b_gpu_d);
  gpuEmxFree_real_T(&b_gpu_absdiff);
  gpuEmxFree_int8_T(&b_gpu_a);
  gpuEmxFree_real_T(&l_gpu_y);
  gpuEmxFree_real_T(&m_gpu_y);
  gpuEmxFree_int8_T(&c_gpu_a);
  gpuEmxFree_real_T(&n_gpu_y);
  gpuEmxFree_real_T(&o_gpu_y);
  gpuEmxFree_real_T(&gpu_b);
  mwCudaFree(gpu_abnrm);
  gpuEmxFree_real_T(&m_gpu_x);
  gpuEmxFree_real_T(&gpu_trend);
  gpuEmxFree_real_T(&b_gpu_trend);
  gpuEmxFree_real_T(&d_gpu_a);
  gpuEmxFree_real_T(&e_gpu_a);
  gpuEmxFree_boolean_T(&gpu_bv8);
  gpuEmxFree_int32_T(&gpu_iv37);
  gpuEmxFree_boolean_T(&gpu_bv9);
  gpuEmxFree_int32_T(&gpu_iv38);
  gpuEmxFree_real_T(&c_gpu_d);
  gpuEmxFree_boolean_T(&j_gpu_ww);
  gpuEmxFree_real_T(&gpu_dv23);
  gpuEmxFree_boolean_T(&gpu_bv10);
  gpuEmxFree_real_T(&c_gpu_absdiff);
  gpuEmxFree_boolean_T(&f_gpu_a);
}

void ecu_detrend_api(const mxArray * const prhs[6], int32_T nlhs, const mxArray *
                     plhs[2])
{
  emxArray_boolean_T *w;
  emxArray_real_T *x;
  const mxArray *prhs_copy_idx_0;
  const mxArray *prhs_copy_idx_5;
  real_T niter;
  real_T order;
  real_T thresh;
  real_T wsize;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_0 = emlrtProtectR2012b(prhs[0], 0, true, -1);
  prhs_copy_idx_5 = emlrtProtectR2012b(prhs[5], 5, true, -1);

  // Marshall function inputs
  emxInit_real_T(&x, 2, &b_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs_copy_idx_0), "x", x);
  order = emlrt_marshallIn(emlrtAliasP(prhs[1]), "order");
  thresh = emlrt_marshallIn(emlrtAliasP(prhs[2]), "thresh");
  niter = emlrt_marshallIn(emlrtAliasP(prhs[3]), "niter");
  wsize = emlrt_marshallIn(emlrtAliasP(prhs[4]), "wsize");
  emxInit_boolean_T(&w, 2, &b_emlrtRTEI, true);
  w->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs_copy_idx_5), "w", w);

  // Invoke the target function
  ecu_detrend(x, order, thresh, niter, wsize, w);

  // Marshall function outputs
  x->canFreeData = false;
  emlrt_marshallOut(x, prhs_copy_idx_0);
  emxFree_real_T(&x);
  plhs[0] = prhs_copy_idx_0;
  if (nlhs > 1) {
    w->canFreeData = false;
    emlrt_marshallOut(w, prhs_copy_idx_5);
    plhs[1] = prhs_copy_idx_5;
  }

  emxFree_boolean_T(&w);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ecu_detrend_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  cusolverDestroyWorkspace();
  cusolverEnsureDestruction();
}

void ecu_detrend_initialize()
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
    ecu_detrend_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ecu_detrend_terminate()
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

// End of code generation (ecu_detrend.cu)
