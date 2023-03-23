//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecc_detr.cu
//
// Code generation for function 'ecc_detr'
//

// Include files
#include "ecc_detr.h"
#include "_coder_ecc_detr_mex.h"
#include "ecc_detr_types.h"
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
#include <cmath>
#include <cstddef>
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

struct emxArray_boolean_T
{
  boolean_T *data;
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
  "ecc_detr",                          // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 3130694236U, 2616137409U, 972914731U, 129233577U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtRTEInfo emlrtRTEI{ 1,      // lineNo
  1,                                   // colNo
  "_coder_ecc_detr_api",               // fName
  ""                                   // pName
};

static emlrtRTEInfo b_emlrtRTEI{ 20,   // lineNo
  7,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 21,   // lineNo
  7,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 22,   // lineNo
  5,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 23,   // lineNo
  5,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 24,   // lineNo
  5,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 32,   // lineNo
  24,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 170,  // lineNo
  24,                                  // colNo
  "combineVectorElements",             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 47,   // lineNo
  1,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 58,   // lineNo
  23,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 49,   // lineNo
  20,                                  // colNo
  "linspace",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/linspace.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 41,   // lineNo
  41,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 41,   // lineNo
  49,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 80,   // lineNo
  20,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 92,   // lineNo
  5,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 42,   // lineNo
  28,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 124,  // lineNo
  10,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "sum",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/sum.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 109,  // lineNo
  1,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 110,  // lineNo
  1,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 44,   // lineNo
  36,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 158,  // lineNo
  24,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 94,   // lineNo
  5,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 68,   // lineNo
  24,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 72,  // lineNo
  28,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 112, // lineNo
  1,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 97,  // lineNo
  9,                                   // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 109, // lineNo
  24,                                  // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 100, // lineNo
  5,                                   // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 113, // lineNo
  1,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 76,  // lineNo
  22,                                  // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 83,  // lineNo
  24,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 101, // lineNo
  13,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 42,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 86,  // lineNo
  21,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 69,  // lineNo
  13,                                  // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 90,  // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 114, // lineNo
  9,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 115, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 86,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 116, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 118, // lineNo
  35,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 83,  // lineNo
  9,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 46,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 111, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 87,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 112, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 114, // lineNo
  5,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 144, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 137, // lineNo
  10,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 114, // lineNo
  1,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 152, // lineNo
  16,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 129, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 137, // lineNo
  12,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 145, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 32,  // lineNo
  13,                                  // colNo
  "eigStandard",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/private/eigStandard.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 130, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 17,  // lineNo
  5,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 142, // lineNo
  41,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 115, // lineNo
  1,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 18,  // lineNo
  29,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 44,  // lineNo
  32,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 116, // lineNo
  1,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 50,  // lineNo
  31,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 44,  // lineNo
  35,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 44,  // lineNo
  48,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 53,  // lineNo
  13,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 61,  // lineNo
  9,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 92,  // lineNo
  22,                                  // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 105, // lineNo
  1,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 117, // lineNo
  5,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 83,  // lineNo
  5,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 86,  // lineNo
  5,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 85,  // lineNo
  1,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 126, // lineNo
  34,                                  // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 30,  // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 88,  // lineNo
  7,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo ed_emlrtRTEI{ 119, // lineNo
  5,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo fd_emlrtRTEI{ 41,  // lineNo
  9,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo gd_emlrtRTEI{ 1,   // lineNo
  37,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo hd_emlrtRTEI{ 1,   // lineNo
  41,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo id_emlrtRTEI{ 1,   // lineNo
  45,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo jd_emlrtRTEI{ 1,   // lineNo
  15,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo kd_emlrtRTEI{ 37,  // lineNo
  5,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo ld_emlrtRTEI{ 59,  // lineNo
  1,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo md_emlrtRTEI{ 1,   // lineNo
  24,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo nd_emlrtRTEI{ 80,  // lineNo
  1,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo od_emlrtRTEI{ 124, // lineNo
  6,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo pd_emlrtRTEI{ 83,  // lineNo
  22,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo qd_emlrtRTEI{ 111, // lineNo
  2,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo rd_emlrtRTEI{ 113, // lineNo
  10,                                  // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo sd_emlrtRTEI{ 111, // lineNo
  4,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo td_emlrtRTEI{ 83,  // lineNo
  1,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ud_emlrtRTEI{ 115, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo vd_emlrtRTEI{ 116, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo wd_emlrtRTEI{ 118, // lineNo
  10,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo xd_emlrtRTEI{ 111, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo yd_emlrtRTEI{ 112, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ae_emlrtRTEI{ 44,  // lineNo
  9,                                   // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo be_emlrtRTEI{ 18,  // lineNo
  5,                                   // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo ce_emlrtRTEI{ 117, // lineNo
  8,                                   // colNo
  "ecc_detr",                          // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/signal/ecc_detr.m"// pName
};

static emlrtRTEInfo de_emlrtRTEI{ 126, // lineNo
  9,                                   // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

// Function Declarations
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, real_T in4);
static void b_emlrt_marshallIn(const mxArray *ord, const char_T *identifier,
  emxArray_real_T *y);
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, real_T in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  real_T in3, const emxArray_real_T *in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4);
static void binary_expand_op(emxArray_real_T *in1, int32_T in2, const
  emxArray_real_T *in3);
static void c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static void d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static __global__ void ecc_detr_kernel1(creal_T *dc);
static __global__ void ecc_detr_kernel10(const emxArray_real_T thr, int32_T
  inVectorLength, emxArray_real_T b_thr);
static __global__ void ecc_detr_kernel100(const int32_T ch, const
  emxArray_real_T w, int32_T b_w, const int32_T w_dim0, emxArray_boolean_T x);
static __global__ void ecc_detr_kernel101(const emxArray_int32_T olPct, int32_T
  inVectorLength, const int32_T olPct_dim0, int32_T *vlen, emxArray_real_T
  b_olPct);
static __global__ void ecc_detr_kernel102(int32_T sz, emxArray_real_T olPct);
static __global__ void ecc_detr_kernel11(const emxArray_real_T thr, int8_T
  outsize_idx_1, emxArray_real_T b_thr);
static __global__ void ecc_detr_kernel12(const emxArray_real_T itr, int32_T
  inVectorLength, emxArray_real_T b_itr);
static __global__ void ecc_detr_kernel13(const emxArray_real_T itr, int32_T
  inVectorLength, emxArray_real_T b_itr);
static __global__ void ecc_detr_kernel14(const emxArray_real_T itr, int8_T
  outsize_idx_1, emxArray_real_T b_itr);
static __global__ void ecc_detr_kernel15(int32_T inVectorLength, const int32_T
  lin_dim1, real_T *d2scaled, emxArray_real_T lin);
static __global__ void ecc_detr_kernel16(const int32_T lin_dim1, emxArray_real_T
  lin);
static __global__ void ecc_detr_kernel17(const int32_T na, const emxArray_real_T
  lin, int32_T inVectorLength, emxArray_real_T dv);
static __global__ void ecc_detr_kernel18(const emxArray_real_T dv, const int32_T
  na, int32_T inVectorLength, const int32_T regs_dim0, emxArray_real_T regs);
static __global__ void ecc_detr_kernel19(const int32_T ch, const emxArray_real_T
  x, int32_T b_x, const int32_T x_dim0, emxArray_real_T dv1);
static __global__ void ecc_detr_kernel2(const int32_T x_dim0, const int32_T
  x_dim1, int32_T *i);
static __global__ void ecc_detr_kernel20(const int32_T ch, const emxArray_real_T
  w, int32_T b_w, const int32_T w_dim0, emxArray_real_T dv2);
static __global__ void ecc_detr_kernel21(const emxArray_real_T dv2, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T x);
static __global__ void ecc_detr_kernel22(const emxArray_real_T dv2, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T x);
static __global__ void ecc_detr_kernel23(const emxArray_real_T dv2, const
  emxArray_real_T regs, const int32_T b_regs, int32_T c_regs, const int32_T
  x_dim0, const int32_T regs_dim0, emxArray_real_T x);
static __global__ void ecc_detr_kernel24(const emxArray_real_T x, int32_T
  inVectorLength, const int32_T x_dim0, int32_T *vlen, emxArray_real_T y);
static __global__ void ecc_detr_kernel25(int32_T sz, emxArray_real_T y);
static __global__ void ecc_detr_kernel26(const emxArray_real_T y, const
  emxArray_real_T regs, const int32_T b_regs, int32_T c_regs, const int32_T
  r_dim0, const int32_T regs_dim0, real_T *abnrm, emxArray_real_T r);
static __global__ void ecc_detr_kernel27(const emxArray_real_T dv2, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, const int32_T rr_dim0,
  const int32_T r_dim0, emxArray_real_T rr);
static __global__ void ecc_detr_kernel28(const emxArray_real_T rr, const int32_T
  b_rr, int32_T c_rr, const int32_T A_dim0, const int32_T rr_dim0,
  emxArray_real_T A);
static __global__ void ecc_detr_kernel29(int32_T A, emxArray_real_T b_A);
static __global__ void ecc_detr_kernel3(real_T *d2scaled, emxArray_real_T x);
static __global__ void ecc_detr_kernel30(const emxArray_real_T wimag, const
  emxArray_real_T wreal, int32_T inVectorLength, emxArray_creal_T W);
static __global__ void ecc_detr_kernel31(const emxArray_real_T vright, int32_T
  b_vright, emxArray_creal_T V);
static __global__ void ecc_detr_kernel32(const int32_T *i, int32_T
  inVectorLength, const int32_T V_dim0, emxArray_creal_T V);
static __global__ void ecc_detr_kernel33(const creal_T *dc, int32_T
  inVectorLength, emxArray_creal_T W);
static __global__ void ecc_detr_kernel34(const creal_T *dc, int32_T V,
  emxArray_creal_T b_V);
static __global__ void ecc_detr_kernel35(int32_T A, emxArray_creal_T D);
static __global__ void ecc_detr_kernel36(int32_T V, emxArray_real_T A);
static __global__ void ecc_detr_kernel37(int32_T inVectorLength, emxArray_real_T
  tau);
static __global__ void ecc_detr_kernel38(const emxArray_real_T A, int32_T b_A,
  emxArray_real_T U);
static __global__ void ecc_detr_kernel39(int32_T V, emxArray_real_T U);
static __global__ void ecc_detr_kernel4(const int32_T w_dim0, const int32_T
  w_dim1, int32_T *i);
static __global__ void ecc_detr_kernel40(int32_T V, emxArray_real_T A);
static __global__ void ecc_detr_kernel41(int32_T V, emxArray_real_T U);
static __global__ void ecc_detr_kernel42(int32_T sz, emxArray_real_T U);
static __global__ void ecc_detr_kernel43(int32_T sz, emxArray_real_T A);
static __global__ void ecc_detr_kernel44(int32_T A, emxArray_creal_T D);
static __global__ void ecc_detr_kernel45(const emxArray_real_T U, int32_T b_U,
  emxArray_creal_T V);
static __global__ void ecc_detr_kernel46(int32_T V, emxArray_real_T A);
static __global__ void ecc_detr_kernel47(int32_T inVectorLength, emxArray_real_T
  tau);
static __global__ void ecc_detr_kernel48(const emxArray_real_T A, int32_T b_A,
  emxArray_real_T V);
static __global__ void ecc_detr_kernel49(int32_T V, emxArray_real_T b_V);
static __global__ void ecc_detr_kernel5(real_T *d2scaled, emxArray_real_T w);
static __global__ void ecc_detr_kernel50(int32_T V, emxArray_real_T A);
static __global__ void ecc_detr_kernel51(int32_T V, emxArray_real_T b_V);
static __global__ void ecc_detr_kernel52(int32_T sz, emxArray_real_T V);
static __global__ void ecc_detr_kernel53(int32_T sz, emxArray_real_T A);
static __global__ void ecc_detr_kernel54(const int32_T minmana, const int32_T
  A_dim0, emxArray_real_T A);
static __global__ void ecc_detr_kernel55(const int32_T minmana, const int32_T
  A_dim0, emxArray_real_T A);
static __global__ void ecc_detr_kernel56(const emxArray_real_T V, int32_T b_V,
  emxArray_creal_T c_V);
static __global__ void ecc_detr_kernel57(const emxArray_real_T A, int32_T b_A,
  emxArray_creal_T D);
static __global__ void ecc_detr_kernel58(const creal_T *dc, int32_T V,
  emxArray_creal_T b_V);
static __global__ void ecc_detr_kernel59(int32_T V, emxArray_creal_T D);
static __global__ void ecc_detr_kernel6(const emxArray_real_T ord, int32_T
  inVectorLength, emxArray_real_T b_ord);
static __global__ void ecc_detr_kernel60(const emxArray_creal_T V, int32_T b_V,
  emxArray_real_T c_V);
static __global__ void ecc_detr_kernel61(const emxArray_creal_T D, int32_T
  inVectorLength, const int32_T D_dim0, emxArray_creal_T d);
static __global__ void ecc_detr_kernel62(const emxArray_creal_T d, int32_T b_d,
  emxArray_real_T D);
static __global__ void ecc_detr_kernel63(const emxArray_real_T D, int32_T b_D,
  real_T *d2scaled, emxArray_boolean_T bv);
static __global__ void ecc_detr_kernel64(const emxArray_int32_T iv7, const
  emxArray_real_T V, const int32_T inVectorLength, int32_T b_iv7, const int32_T
  V_dim0, const int32_T b_V_dim0, emxArray_real_T b_V);
static __global__ void ecc_detr_kernel65(const emxArray_real_T V, int32_T b_V,
  emxArray_real_T c_V);
static __global__ void ecc_detr_kernel66(const emxArray_real_T rr, int32_T b_rr,
  emxArray_real_T A);
static __global__ void ecc_detr_kernel67(int32_T *vlen, int32_T n,
  emxArray_real_T rr);
static __global__ void ecc_detr_kernel68(const emxArray_real_T dv2, const real_T
  mn, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T A);
static __global__ void ecc_detr_kernel69(int32_T rr, emxArray_real_T b);
static __global__ void ecc_detr_kernel7(const emxArray_real_T ord, int32_T
  inVectorLength, emxArray_real_T b_ord);
static __global__ void ecc_detr_kernel70(const emxArray_real_T rr, const int32_T
  b_rr, int32_T c_rr, const int32_T A_dim0, const int32_T rr_dim0,
  emxArray_real_T A);
static __global__ void ecc_detr_kernel71(int32_T A, emxArray_real_T b_A);
static __global__ void ecc_detr_kernel72(const emxArray_real_T A, const int32_T
  b_A, int32_T c_A, const int32_T A_dim0, const int32_T b_A_dim0,
  emxArray_real_T d_A);
static __global__ void ecc_detr_kernel73(const emxArray_real_T b, int32_T b_b,
  emxArray_real_T B);
static __global__ void ecc_detr_kernel74(int32_T A, emxArray_int32_T jpvt);
static __global__ void ecc_detr_kernel75(const int32_T m, int32_T na, const
  int32_T A_dim0, emxArray_real_T A);
static __global__ void ecc_detr_kernel76(int32_T *vlen, emxArray_real_T tau);
static __global__ void ecc_detr_kernel77(int32_T na, emxArray_int32_T jpvt);
static __global__ void ecc_detr_kernel78(int32_T inVectorLength, emxArray_real_T
  Y);
static __global__ void ecc_detr_kernel79(int32_T inVectorLength, emxArray_real_T
  B);
static __global__ void ecc_detr_kernel8(const emxArray_real_T ord, int8_T
  outsize_idx_1, emxArray_real_T b_ord);
static __global__ void ecc_detr_kernel80(const emxArray_real_T B, const
  emxArray_int32_T jpvt, int32_T na, emxArray_real_T Y);
static __global__ void ecc_detr_kernel81(const emxArray_real_T Y, int32_T b_Y,
  emxArray_real_T b);
static __global__ void ecc_detr_kernel82(const emxArray_int32_T ipiv_t, int32_T
  inVectorLength, emxArray_int32_T ipiv);
static __global__ void ecc_detr_kernel83(int32_T V, emxArray_real_T A);
static __global__ void ecc_detr_kernel84(int32_T inVectorLength,
  emxArray_int32_T ipiv);
static __global__ void ecc_detr_kernel85(const int32_T A_dim0, uint32_T sz[2]);
static __global__ void ecc_detr_kernel86(const uint32_T sz[2], int32_T *b_sz);
static __global__ void ecc_detr_kernel87(int32_T *sz, emxArray_real_T b);
static __global__ void ecc_detr_kernel88(const emxArray_real_T b, int32_T b_b,
  emxArray_real_T B);
static __global__ void ecc_detr_kernel89(int32_T V, emxArray_real_T y);
static __global__ void ecc_detr_kernel9(const emxArray_real_T thr, int32_T
  inVectorLength, emxArray_real_T b_thr);
static __global__ void ecc_detr_kernel90(int32_T r, emxArray_real_T dv8);
static __global__ void ecc_detr_kernel91(const real_T mn, const emxArray_real_T
  dv1, const emxArray_real_T dv8, int32_T b_dv8, emxArray_real_T z);
static __global__ void ecc_detr_kernel92(const emxArray_real_T dv2, const
  emxArray_real_T z, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T d);
static __global__ void ecc_detr_kernel93(const emxArray_real_T d, int32_T n,
  real_T *d2scaled, emxArray_real_T absdiff);
static __global__ void ecc_detr_kernel94(const emxArray_real_T d, int32_T
  inVectorLength, emxArray_real_T y);
static __global__ void ecc_detr_kernel95(const emxArray_real_T y, int32_T b_y,
  real_T *d2scaled, emxArray_boolean_T bv1);
static __global__ void ecc_detr_kernel96(const emxArray_int32_T iv10, int32_T
  b_iv10, emxArray_real_T dv2);
static __global__ void ecc_detr_kernel97(const emxArray_real_T z, const int32_T
  ch, const emxArray_real_T x, int32_T b_x, const int32_T x_dim0,
  emxArray_real_T c_x);
static __global__ void ecc_detr_kernel98(const emxArray_real_T x, const int32_T
  ch, int32_T b_x, const int32_T x_dim0, emxArray_real_T c_x);
static __global__ void ecc_detr_kernel99(const emxArray_real_T dv2, const
  int32_T ch, int32_T b_dv2, const int32_T w_dim0, emxArray_real_T w);
static void ecc_detr_once();
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static void emlrt_marshallOut(const emxArray_real_T *u, const mxArray *y);
static void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_creal_T(emxArray_creal_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_ptrdiff_t(emxArray_ptrdiff_t *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxFree_boolean_T(emxArray_boolean_T **pEmxArray);
static void emxFree_creal_T(emxArray_creal_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxInit_boolean_T(emxArray_boolean_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_creal_T(emxArray_creal_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
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
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu);
static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxFree_creal_T(emxArray_creal_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
static void gpuEmxMemcpyCpuToGpu_creal_T(emxArray_creal_T *gpu, const
  emxArray_creal_T *cpu);
static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu, const
  emxArray_int32_T *cpu);
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
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
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

  emxEnsureCapacity_real_T(in1, i, &t_emlrtRTEI);
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

static void b_emlrt_marshallIn(const mxArray *ord, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(emlrtAlias(ord), &thisId, y);
  emlrtDestroyArray(&ord);
}

static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  d_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void binary_expand_op(emxArray_real_T *in1, int32_T in2, const
  emxArray_real_T *in3)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &p_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in3->size[0] == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in3->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &p_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in1->size[0];
  } else {
    b = in3->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0 + in1->size[0] * in2] - in3->
      data[i * stride_1_0];
  }

  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i + in1->size[0] * in2] = b_in1->data[i];
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

  emxEnsureCapacity_real_T(in1, i, &yc_emlrtRTEI);
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

  emxEnsureCapacity_real_T(in1, i, &xc_emlrtRTEI);
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

  emxEnsureCapacity_real_T(in1, i, &v_emlrtRTEI);
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
  emxEnsureCapacity_real_T(in1, i, &u_emlrtRTEI);
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

static void c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
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

static void d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2]{ 1, 99 };

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

static __global__ __launch_bounds__(32, 1) void ecc_detr_kernel1(creal_T *dc)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    dc->re = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel10(const
  emxArray_real_T thr, int32_T inVectorLength, emxArray_real_T b_thr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_thr.data[i] = thr.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel100(const
  int32_T ch, const emxArray_real_T w, int32_T b_w, const int32_T w_dim0,
  emxArray_boolean_T x)
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
    x.data[i] = !(w.data[i + w_dim0 * ch] != 0.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel101(const
  emxArray_int32_T olPct, int32_T inVectorLength, const int32_T olPct_dim0,
  int32_T *vlen, emxArray_real_T b_olPct)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx);
    xpageoffset = i * olPct_dim0;
    b_olPct.data[i] = olPct.data[xpageoffset];
    for (int32_T k{0}; k <= *vlen - 2; k++) {
      b_olPct.data[i] += static_cast<real_T>(olPct.data[(xpageoffset + k) + 1]);
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel102(int32_T sz,
  emxArray_real_T olPct)
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
    olPct.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel11(const
  emxArray_real_T thr, int8_T outsize_idx_1, emxArray_real_T b_thr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_thr.data[i] = thr.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel12(const
  emxArray_real_T itr, int32_T inVectorLength, emxArray_real_T b_itr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_itr.data[i] = itr.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel13(const
  emxArray_real_T itr, int32_T inVectorLength, emxArray_real_T b_itr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_itr.data[i] = itr.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel14(const
  emxArray_real_T itr, int8_T outsize_idx_1, emxArray_real_T b_itr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_itr.data[i] = itr.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel15(int32_T
  inVectorLength, const int32_T lin_dim1, real_T *d2scaled, emxArray_real_T lin)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real_T>((((k + 2) << 1) - lin_dim1) - 1) *
      *d2scaled;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detr_kernel16(const int32_T
  lin_dim1, emxArray_real_T lin)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[lin_dim1 >> 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel17(const
  int32_T na, const emxArray_real_T lin, int32_T inVectorLength, emxArray_real_T
  dv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    dv.data[k] = pow(lin.data[k], static_cast<real_T>(na) + 1.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel18(const
  emxArray_real_T dv, const int32_T na, int32_T inVectorLength, const int32_T
  regs_dim0, emxArray_real_T regs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    regs.data[i + regs_dim0 * na] = dv.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel19(const
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

static __global__ __launch_bounds__(32, 1) void ecc_detr_kernel2(const int32_T
  x_dim0, const int32_T x_dim1, int32_T *i)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *i = x_dim0 * x_dim1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel20(const
  int32_T ch, const emxArray_real_T w, int32_T b_w, const int32_T w_dim0,
  emxArray_real_T dv2)
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
    dv2.data[i] = w.data[i + w_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel21(const
  emxArray_real_T dv2, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T
  x)
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
    x.data[i] = dv1.data[i] * dv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel22(const
  emxArray_real_T dv2, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T
  x)
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
    x.data[i] = dv1.data[i] * dv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel23(const
  emxArray_real_T dv2, const emxArray_real_T regs, const int32_T b_regs, int32_T
  c_regs, const int32_T x_dim0, const int32_T regs_dim0, emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_regs) + 1UL) * (static_cast<uint64_T>
    (c_regs) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_regs) +
      1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_regs) + 1UL));
    x.data[xpageoffset + x_dim0 * i] = regs.data[xpageoffset + regs_dim0 * i] *
      dv2.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel24(const
  emxArray_real_T x, int32_T inVectorLength, const int32_T x_dim0, int32_T *vlen,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx);
    xpageoffset = i * x_dim0;
    y.data[i] = x.data[xpageoffset];
    for (int32_T k{0}; k <= *vlen - 2; k++) {
      y.data[i] += x.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel25(int32_T sz,
  emxArray_real_T y)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel26(const
  emxArray_real_T y, const emxArray_real_T regs, const int32_T b_regs, int32_T
  c_regs, const int32_T r_dim0, const int32_T regs_dim0, real_T *abnrm,
  emxArray_real_T r)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_regs) + 1UL) * (static_cast<uint64_T>
    (c_regs) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_regs) +
      1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_regs) + 1UL));
    r.data[xpageoffset + r_dim0 * i] = regs.data[xpageoffset + regs_dim0 * i] -
      y.data[i] / *abnrm;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel27(const
  emxArray_real_T dv2, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
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
      dv2.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel28(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel29(int32_T A,
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

static __global__ __launch_bounds__(32, 1) void ecc_detr_kernel3(real_T
  *d2scaled, emxArray_real_T x)
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 1) {
    x.data[0] = *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel30(const
  emxArray_real_T wimag, const emxArray_real_T wreal, int32_T inVectorLength,
  emxArray_creal_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i].re = wreal.data[i];
    W.data[i].im = wimag.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel31(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel32(const
  int32_T *i, int32_T inVectorLength, const int32_T V_dim0, emxArray_creal_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    d = V.data[xpageoffset + V_dim0 * (*i + 1)].re;
    V.data[xpageoffset + V_dim0 * *i].im = d;
    V.data[xpageoffset + V_dim0 * (*i + 1)].re = V.data[xpageoffset + V_dim0 *
      *i].re;
    V.data[xpageoffset + V_dim0 * (*i + 1)].im = -V.data[xpageoffset + V_dim0 * *
      i].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel33(const
  creal_T *dc, int32_T inVectorLength, emxArray_creal_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel34(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel35(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel36(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel37(int32_T
  inVectorLength, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel38(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel39(int32_T V,
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

static __global__ __launch_bounds__(32, 1) void ecc_detr_kernel4(const int32_T
  w_dim0, const int32_T w_dim1, int32_T *i)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *i = w_dim0 * w_dim1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel40(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel41(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel42(int32_T sz,
  emxArray_real_T U)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel43(int32_T sz,
  emxArray_real_T A)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel44(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel45(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel46(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel47(int32_T
  inVectorLength, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel48(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel49(int32_T V,
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

static __global__ __launch_bounds__(32, 1) void ecc_detr_kernel5(real_T
  *d2scaled, emxArray_real_T w)
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 1) {
    w.data[0] = *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel50(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel51(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel52(int32_T sz,
  emxArray_real_T V)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel53(int32_T sz,
  emxArray_real_T A)
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

static __global__ __launch_bounds__(32, 1) void ecc_detr_kernel54(const int32_T
  minmana, const int32_T A_dim0, emxArray_real_T A)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    A.data[(minmana + A_dim0 * minmana) + 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel55(const
  int32_T minmana, const int32_T A_dim0, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(minmana);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i + A_dim0 * (minmana + 1)] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel56(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel57(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel58(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel59(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel6(const
  emxArray_real_T ord, int32_T inVectorLength, emxArray_real_T b_ord)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_ord.data[i] = ord.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel60(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel61(const
  emxArray_creal_T D, int32_T inVectorLength, const int32_T D_dim0,
  emxArray_creal_T d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    d.data[k] = D.data[k + D_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel62(const
  emxArray_creal_T d, int32_T b_d, emxArray_real_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_d);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i] = d.data[i].re;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel63(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel64(const
  emxArray_int32_T iv7, const emxArray_real_T V, const int32_T inVectorLength,
  int32_T b_iv7, const int32_T V_dim0, const int32_T b_V_dim0, emxArray_real_T
  b_V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(inVectorLength - 1) + 1UL) *
    (static_cast<uint64_T>(b_iv7) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>
      (inVectorLength - 1) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(inVectorLength - 1) + 1UL));
    b_V.data[xpageoffset + V_dim0 * i] = V.data[xpageoffset + b_V_dim0 *
      (iv7.data[i] - 1)];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel65(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel66(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel67(int32_T
  *vlen, int32_T n, emxArray_real_T rr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*vlen * n - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    rr.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel68(const
  emxArray_real_T dv2, const real_T mn, const emxArray_real_T dv1, int32_T b_dv1,
  emxArray_real_T A)
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
    A.data[i] = (dv1.data[i] - mn) * dv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel69(int32_T rr,
  emxArray_real_T b)
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel7(const
  emxArray_real_T ord, int32_T inVectorLength, emxArray_real_T b_ord)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_ord.data[i] = ord.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel70(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel71(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel72(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel73(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel74(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel75(const
  int32_T m, int32_T na, const int32_T A_dim0, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(m - 1) + 1UL) * (static_cast<uint64_T>(na) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(m - 1) + 1UL));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) / (
      static_cast<uint64_T>(m - 1) + 1UL));
    A.data[xpageoffset * A_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel76(int32_T
  *vlen, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*vlen - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    tau.data[k] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel77(int32_T na,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel78(int32_T
  inVectorLength, emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel79(int32_T
  inVectorLength, emxArray_real_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel8(const
  emxArray_real_T ord, int8_T outsize_idx_1, emxArray_real_T b_ord)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize_idx_1 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_ord.data[i] = ord.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel80(const
  emxArray_real_T B, const emxArray_int32_T jpvt, int32_T na, emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[jpvt.data[i] - 1] = B.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel81(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel82(const
  emxArray_int32_T ipiv_t, int32_T inVectorLength, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel83(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel84(int32_T
  inVectorLength, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detr_kernel85(const int32_T
  A_dim0, uint32_T sz[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    sz[1] = static_cast<uint32_T>(A_dim0);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_detr_kernel86(const uint32_T
  sz[2], int32_T *b_sz)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *b_sz = static_cast<int32_T>(sz[1]) - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel87(int32_T *sz,
  emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*sz);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel88(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel89(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel9(const
  emxArray_real_T thr, int32_T inVectorLength, emxArray_real_T b_thr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_thr.data[i] = thr.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel90(int32_T r,
  emxArray_real_T dv8)
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
    dv8.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel91(const real_T
  mn, const emxArray_real_T dv1, const emxArray_real_T dv8, int32_T b_dv8,
  emxArray_real_T z)
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
    z.data[i] = dv8.data[i] + (dv1.data[i] - (dv1.data[i] - mn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel92(const
  emxArray_real_T dv2, const emxArray_real_T z, const emxArray_real_T dv1,
  int32_T b_dv1, emxArray_real_T d)
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
    d.data[i] = (dv1.data[i] - z.data[i]) * dv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel93(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel94(const
  emxArray_real_T d, int32_T inVectorLength, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = fabs(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel95(const
  emxArray_real_T y, int32_T b_y, real_T *d2scaled, emxArray_boolean_T bv1)
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
    bv1.data[i] = (y.data[i] > *d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel96(const
  emxArray_int32_T iv10, int32_T b_iv10, emxArray_real_T dv2)
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
    dv2.data[iv10.data[i] - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel97(const
  emxArray_real_T z, const int32_T ch, const emxArray_real_T x, int32_T b_x,
  const int32_T x_dim0, emxArray_real_T c_x)
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
    c_x.data[i] = x.data[i + x_dim0 * ch] - z.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel98(const
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

static __global__ __launch_bounds__(1024, 1) void ecc_detr_kernel99(const
  emxArray_real_T dv2, const int32_T ch, int32_T b_dv2, const int32_T w_dim0,
  emxArray_real_T w)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    w.data[i + w_dim0 * ch] = dv2.data[i];
  }
}

static void ecc_detr_once()
{
  mwMemoryManagerInit(256U, 1U, 8U, 8192U);
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

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  c_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
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

static void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real_T));
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

  emxEnsureCapacity_real_T(in1, i, &r_emlrtRTEI);
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
// function [x,w,olPct] = ecc_detr(x,w,ord,thr,itr)
void ecc_detr(emxArray_real_T *x, emxArray_real_T *w, const emxArray_real_T *ord,
              const emxArray_real_T *thr, const emxArray_real_T *itr,
              emxArray_real_T *olPct)
{
  static creal_T dc{ 0.0,              // re
    0.0                                // im
  };

  ptrdiff_t ihi_t;
  ptrdiff_t ilo_t;
  dim3 block;
  dim3 grid;
  emxArray_boolean_T d_gpu_x;
  emxArray_boolean_T gpu_bv;
  emxArray_boolean_T gpu_bv1;
  emxArray_boolean_T *b_x;
  emxArray_boolean_T *bv;
  emxArray_boolean_T *bv1;
  emxArray_creal_T gpu_D;
  emxArray_creal_T gpu_V;
  emxArray_creal_T gpu_W;
  emxArray_creal_T gpu_d;
  emxArray_creal_T *D;
  emxArray_creal_T *V;
  emxArray_creal_T *W;
  emxArray_creal_T *d;
  emxArray_int32_T gpu_ipiv;
  emxArray_int32_T gpu_ipiv_t;
  emxArray_int32_T gpu_iv10;
  emxArray_int32_T gpu_iv7;
  emxArray_int32_T gpu_jpvt;
  emxArray_int32_T gpu_olPct;
  emxArray_int32_T *b_olPct;
  emxArray_int32_T *ipiv;
  emxArray_int32_T *ipiv_t;
  emxArray_int32_T *iv10;
  emxArray_int32_T *iv7;
  emxArray_int32_T *jpvt;
  emxArray_ptrdiff_t *jpvt_t;
  emxArray_real_T b_gpu_A;
  emxArray_real_T b_gpu_B;
  emxArray_real_T b_gpu_D;
  emxArray_real_T b_gpu_V;
  emxArray_real_T b_gpu_d;
  emxArray_real_T b_gpu_itr;
  emxArray_real_T b_gpu_olPct;
  emxArray_real_T b_gpu_ord;
  emxArray_real_T b_gpu_tau;
  emxArray_real_T b_gpu_thr;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_A;
  emxArray_real_T c_gpu_V;
  emxArray_real_T c_gpu_tau;
  emxArray_real_T c_gpu_x;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_A;
  emxArray_real_T d_gpu_V;
  emxArray_real_T e_gpu_A;
  emxArray_real_T e_gpu_x;
  emxArray_real_T f_gpu_A;
  emxArray_real_T f_gpu_x;
  emxArray_real_T g_gpu_A;
  emxArray_real_T gpu_A;
  emxArray_real_T gpu_B;
  emxArray_real_T gpu_U;
  emxArray_real_T gpu_Y;
  emxArray_real_T gpu_absdiff;
  emxArray_real_T gpu_b;
  emxArray_real_T gpu_dv;
  emxArray_real_T gpu_dv1;
  emxArray_real_T gpu_dv2;
  emxArray_real_T gpu_dv8;
  emxArray_real_T gpu_itr;
  emxArray_real_T gpu_lin;
  emxArray_real_T gpu_ord;
  emxArray_real_T gpu_r;
  emxArray_real_T gpu_regs;
  emxArray_real_T gpu_rr;
  emxArray_real_T gpu_tau;
  emxArray_real_T gpu_thr;
  emxArray_real_T gpu_vright;
  emxArray_real_T gpu_w;
  emxArray_real_T gpu_wimag;
  emxArray_real_T gpu_wreal;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_z;
  emxArray_real_T *A;
  emxArray_real_T *B;
  emxArray_real_T *U;
  emxArray_real_T *Y;
  emxArray_real_T *absdiff;
  emxArray_real_T *b;
  emxArray_real_T *b_A;
  emxArray_real_T *b_B;
  emxArray_real_T *b_D;
  emxArray_real_T *b_V;
  emxArray_real_T *b_d;
  emxArray_real_T *b_itr;
  emxArray_real_T *b_ord;
  emxArray_real_T *b_tau;
  emxArray_real_T *b_thr;
  emxArray_real_T *b_wi;
  emxArray_real_T *b_wr;
  emxArray_real_T *b_y;
  emxArray_real_T *c_A;
  emxArray_real_T *c_V;
  emxArray_real_T *c_tau;
  emxArray_real_T *c_x;
  emxArray_real_T *c_y;
  emxArray_real_T *d_A;
  emxArray_real_T *d_V;
  emxArray_real_T *d_x;
  emxArray_real_T *dv;
  emxArray_real_T *dv1;
  emxArray_real_T *dv2;
  emxArray_real_T *dv8;
  emxArray_real_T *e_A;
  emxArray_real_T *e_x;
  emxArray_real_T *f_A;
  emxArray_real_T *f_x;
  emxArray_real_T *g_A;
  emxArray_real_T *lin;
  emxArray_real_T *r;
  emxArray_real_T *regs;
  emxArray_real_T *rr;
  emxArray_real_T *scale;
  emxArray_real_T *tau;
  emxArray_real_T *vright;
  emxArray_real_T *wi;
  emxArray_real_T *wimag;
  emxArray_real_T *wr;
  emxArray_real_T *wreal;
  emxArray_real_T *y;
  emxArray_real_T *z;
  creal_T *gpu_dc;
  real_T abnrm;
  real_T d2scaled;
  real_T rconde;
  real_T rcondv;
  real_T *gpu_abnrm;
  real_T *gpu_d2scaled;
  int32_T b_i;
  int32_T b_sz;
  int32_T i;
  int32_T i5;
  int32_T inVectorLength;
  int32_T m;
  int32_T n;
  int32_T nFrames;
  int32_T vlen;
  int32_T x_dim0;
  int32_T *b_gpu_sz;
  int32_T *gpu_i;
  int32_T *gpu_vlen;
  uint32_T sz[2];
  uint32_T (*gpu_sz)[2];
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
  boolean_T b_A_dirtyOnCpu;
  boolean_T b_A_dirtyOnGpu;
  boolean_T b_D_dirtyOnGpu;
  boolean_T b_V_dirtyOnCpu;
  boolean_T b_V_dirtyOnGpu;
  boolean_T b_d_dirtyOnCpu;
  boolean_T b_d_dirtyOnGpu;
  boolean_T b_dirtyOnCpu;
  boolean_T b_tau_dirtyOnCpu;
  boolean_T b_tau_dirtyOnGpu;
  boolean_T b_x_dirtyOnCpu;
  boolean_T b_x_dirtyOnGpu;
  boolean_T bv1_dirtyOnGpu;
  boolean_T bv_dirtyOnGpu;
  boolean_T c_A_dirtyOnGpu;
  boolean_T c_tau_dirtyOnGpu;
  boolean_T c_x_dirtyOnCpu;
  boolean_T c_x_dirtyOnGpu;
  boolean_T d_dirtyOnCpu;
  boolean_T d_dirtyOnGpu;
  boolean_T d_x_dirtyOnCpu;
  boolean_T d_x_dirtyOnGpu;
  boolean_T dc_dirtyOnGpu;
  boolean_T dv1_dirtyOnGpu;
  boolean_T dv2_dirtyOnGpu;
  boolean_T dv8_dirtyOnGpu;
  boolean_T e_x_dirtyOnGpu;
  boolean_T ipiv_dirtyOnCpu;
  boolean_T ipiv_dirtyOnGpu;
  boolean_T itr_dirtyOnGpu;
  boolean_T iv10_dirtyOnCpu;
  boolean_T iv7_dirtyOnCpu;
  boolean_T jpvt_dirtyOnCpu;
  boolean_T jpvt_dirtyOnGpu;
  boolean_T lin_dirtyOnCpu;
  boolean_T lin_dirtyOnGpu;
  boolean_T olPct_dirtyOnCpu;
  boolean_T olPct_dirtyOnGpu;
  boolean_T ord_dirtyOnGpu;
  boolean_T r_dirtyOnCpu;
  boolean_T r_dirtyOnGpu;
  boolean_T regs_dirtyOnGpu;
  boolean_T rr_dirtyOnCpu;
  boolean_T rr_dirtyOnGpu;
  boolean_T sz_dirtyOnCpu;
  boolean_T sz_dirtyOnGpu;
  boolean_T tau_dirtyOnCpu;
  boolean_T tau_dirtyOnGpu;
  boolean_T thr_dirtyOnGpu;
  boolean_T validLaunchParams;
  boolean_T vright_dirtyOnCpu;
  boolean_T w_dirtyOnCpu;
  boolean_T w_dirtyOnGpu;
  boolean_T wimag_dirtyOnCpu;
  boolean_T wreal_dirtyOnCpu;
  boolean_T x_dirtyOnCpu;
  boolean_T x_dirtyOnGpu;
  boolean_T y_dirtyOnGpu;
  boolean_T z_dirtyOnCpu;
  boolean_T z_dirtyOnGpu;
  gpuEmxReset_int32_T(&gpu_iv10);
  gpuEmxReset_boolean_T(&gpu_bv1);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_real_T(&gpu_absdiff);
  gpuEmxReset_real_T(&gpu_Y);
  gpuEmxReset_real_T(&b_gpu_d);
  gpuEmxReset_real_T(&c_gpu_tau);
  gpuEmxReset_real_T(&gpu_dv8);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_int32_T(&gpu_jpvt);
  gpuEmxReset_real_T(&b_gpu_B);
  gpuEmxReset_int32_T(&gpu_ipiv);
  gpuEmxReset_real_T(&gpu_B);
  gpuEmxReset_real_T(&g_gpu_A);
  gpuEmxReset_int32_T(&gpu_ipiv_t);
  mwCudaMalloc(&b_gpu_sz, 4UL);
  mwCudaMalloc(&gpu_sz, 8UL);
  gpuEmxReset_real_T(&f_gpu_A);
  gpuEmxReset_real_T(&e_gpu_A);
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_real_T(&d_gpu_A);
  gpuEmxReset_real_T(&c_gpu_A);
  gpuEmxReset_real_T(&d_gpu_V);
  gpuEmxReset_int32_T(&gpu_iv7);
  gpuEmxReset_real_T(&gpu_vright);
  gpuEmxReset_real_T(&b_gpu_tau);
  gpuEmxReset_creal_T(&gpu_W);
  gpuEmxReset_real_T(&gpu_wreal);
  gpuEmxReset_real_T(&gpu_wimag);
  gpuEmxReset_real_T(&gpu_tau);
  gpuEmxReset_boolean_T(&gpu_bv);
  gpuEmxReset_real_T(&gpu_U);
  gpuEmxReset_real_T(&c_gpu_V);
  gpuEmxReset_real_T(&b_gpu_D);
  gpuEmxReset_creal_T(&gpu_d);
  gpuEmxReset_creal_T(&gpu_D);
  gpuEmxReset_real_T(&b_gpu_V);
  gpuEmxReset_creal_T(&gpu_V);
  gpuEmxReset_real_T(&b_gpu_A);
  gpuEmxReset_real_T(&gpu_A);
  gpuEmxReset_real_T(&gpu_rr);
  gpuEmxReset_real_T(&gpu_r);
  mwCudaMalloc(&gpu_abnrm, 8UL);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&f_gpu_x);
  gpuEmxReset_real_T(&e_gpu_x);
  gpuEmxReset_boolean_T(&d_gpu_x);
  gpuEmxReset_real_T(&c_gpu_x);
  gpuEmxReset_real_T(&b_gpu_x);
  gpuEmxReset_real_T(&gpu_z);
  gpuEmxReset_real_T(&b_gpu_olPct);
  mwCudaMalloc(&gpu_vlen, 4UL);
  gpuEmxReset_int32_T(&gpu_olPct);
  gpuEmxReset_real_T(&gpu_dv2);
  gpuEmxReset_real_T(&gpu_dv1);
  gpuEmxReset_real_T(&gpu_regs);
  gpuEmxReset_real_T(&gpu_dv);
  gpuEmxReset_real_T(&gpu_lin);
  gpuEmxReset_real_T(&b_gpu_itr);
  gpuEmxReset_real_T(&gpu_itr);
  gpuEmxReset_real_T(&b_gpu_thr);
  gpuEmxReset_real_T(&gpu_thr);
  gpuEmxReset_real_T(&b_gpu_ord);
  gpuEmxReset_real_T(&gpu_ord);
  mwCudaMalloc(&gpu_d2scaled, 8UL);
  gpuEmxReset_real_T(&gpu_w);
  mwCudaMalloc(&gpu_i, 4UL);
  gpuEmxReset_real_T(&gpu_x);
  mwCudaMalloc(&gpu_dc, 16UL);
  bv1_dirtyOnGpu = false;
  Y_dirtyOnGpu = false;
  b_d_dirtyOnGpu = false;
  c_tau_dirtyOnGpu = false;
  dv8_dirtyOnGpu = false;
  jpvt_dirtyOnGpu = false;
  ipiv_dirtyOnGpu = false;
  c_A_dirtyOnGpu = false;
  sz_dirtyOnGpu = false;
  b_A_dirtyOnGpu = false;
  b_tau_dirtyOnGpu = false;
  W_dirtyOnGpu = false;
  tau_dirtyOnGpu = false;
  bv_dirtyOnGpu = false;
  U_dirtyOnGpu = false;
  b_V_dirtyOnGpu = false;
  b_D_dirtyOnGpu = false;
  d_dirtyOnGpu = false;
  D_dirtyOnGpu = false;
  V_dirtyOnGpu = false;
  A_dirtyOnGpu = false;
  rr_dirtyOnGpu = false;
  r_dirtyOnGpu = false;
  y_dirtyOnGpu = false;
  e_x_dirtyOnGpu = false;
  d_x_dirtyOnGpu = false;
  c_x_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  z_dirtyOnGpu = false;
  dv2_dirtyOnGpu = false;
  dv1_dirtyOnGpu = false;
  regs_dirtyOnGpu = false;
  lin_dirtyOnGpu = false;
  itr_dirtyOnGpu = false;
  thr_dirtyOnGpu = false;
  ord_dirtyOnGpu = false;
  iv10_dirtyOnCpu = false;
  Y_dirtyOnCpu = false;
  b_d_dirtyOnCpu = false;
  jpvt_dirtyOnCpu = false;
  ipiv_dirtyOnCpu = false;
  sz_dirtyOnCpu = false;
  b_dirtyOnCpu = false;
  b_A_dirtyOnCpu = false;
  iv7_dirtyOnCpu = false;
  vright_dirtyOnCpu = false;
  b_tau_dirtyOnCpu = false;
  wreal_dirtyOnCpu = false;
  wimag_dirtyOnCpu = false;
  tau_dirtyOnCpu = false;
  U_dirtyOnCpu = false;
  b_V_dirtyOnCpu = false;
  d_dirtyOnCpu = false;
  D_dirtyOnCpu = false;
  V_dirtyOnCpu = false;
  A_dirtyOnCpu = false;
  rr_dirtyOnCpu = false;
  r_dirtyOnCpu = false;
  d_x_dirtyOnCpu = false;
  c_x_dirtyOnCpu = false;
  b_x_dirtyOnCpu = false;
  z_dirtyOnCpu = false;
  olPct_dirtyOnCpu = false;
  lin_dirtyOnCpu = false;
  olPct_dirtyOnGpu = false;
  w_dirtyOnGpu = false;
  w_dirtyOnCpu = true;
  x_dirtyOnGpu = false;
  x_dirtyOnCpu = true;
  cudaMemcpy(gpu_dc, &dc, 16UL, cudaMemcpyHostToDevice);
  ecc_detr_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_dc);
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
  // 'ecc_detr:20' x (:,:){mustBeFloat}
  if ((x->size[0] == 1) && (x->size[1] == 1)) {
    d2scaled = x->data[0];
    x_dim0 = x->size[0];
    m = x->size[1];
    gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
    ecc_detr_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(x_dim0, m, gpu_i);
    x->size[0] = 1;
    x->size[1] = 1;
    cudaMemcpy(&i, gpu_i, 4UL, cudaMemcpyDeviceToHost);
    emxEnsureCapacity_real_T(x, i, &b_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(x, &gpu_x);
    cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
    ecc_detr_kernel3<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_d2scaled,
      gpu_x);
    x_dirtyOnCpu = false;
    x_dirtyOnGpu = true;
  }

  // 'ecc_detr:21' w (:,:){mustBeFloat}
  if ((w->size[0] == 1) && (w->size[1] == 1)) {
    d2scaled = w->data[0];
    n = w->size[0];
    m = w->size[1];
    gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, w);
    ecc_detr_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(n, m, gpu_i);
    w->size[0] = 1;
    w->size[1] = 1;
    cudaMemcpy(&i, gpu_i, 4UL, cudaMemcpyDeviceToHost);
    emxEnsureCapacity_real_T(w, i, &c_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(w, &gpu_w);
    cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
    ecc_detr_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_d2scaled,
      gpu_w);
    w_dirtyOnCpu = false;
    w_dirtyOnGpu = true;
  }

  // 'ecc_detr:22' ord (1,:){mustBeFloat}
  inVectorLength = 1;
  if (ord->size[0] != 1) {
    inVectorLength = 0;
  }

  if (ord->size[1] != 1) {
    inVectorLength = ord->size[1];
  }

  emxInit_real_T(&b_ord, 2, &gd_emlrtRTEI, true);
  if ((ord->size[0] == 1) && (ord->size[1] == 1)) {
    i = b_ord->size[0] * b_ord->size[1];
    b_ord->size[0] = 1;
    b_ord->size[1] = inVectorLength;
    emxEnsureCapacity_real_T(b_ord, i, &d_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_ord, &b_gpu_ord);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
      static_cast<int8_T>(inVectorLength) - 1) + 1L), &grid, &block, 1024U,
      65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_ord, ord);
      ecc_detr_kernel8<<<grid, block>>>(gpu_ord, static_cast<int8_T>
        (inVectorLength), b_gpu_ord);
      ord_dirtyOnGpu = true;
    }
  } else if ((ord->size[0] == 0) || (ord->size[1] == 0)) {
    i = b_ord->size[0] * b_ord->size[1];
    b_ord->size[0] = 1;
    b_ord->size[1] = inVectorLength;
    emxEnsureCapacity_real_T(b_ord, i, &d_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_ord, &b_gpu_ord);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_ord, ord);
      ecc_detr_kernel7<<<grid, block>>>(gpu_ord, inVectorLength, b_gpu_ord);
      ord_dirtyOnGpu = true;
    }
  } else {
    i = b_ord->size[0] * b_ord->size[1];
    b_ord->size[0] = 1;
    b_ord->size[1] = inVectorLength;
    emxEnsureCapacity_real_T(b_ord, i, &d_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_ord, &b_gpu_ord);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_ord, ord);
      ecc_detr_kernel6<<<grid, block>>>(gpu_ord, inVectorLength, b_gpu_ord);
      ord_dirtyOnGpu = true;
    }
  }

  // 'ecc_detr:23' thr (1,:){mustBeFloat}
  inVectorLength = 1;
  if (thr->size[0] != 1) {
    inVectorLength = 0;
  }

  if (thr->size[1] != 1) {
    inVectorLength = thr->size[1];
  }

  emxInit_real_T(&b_thr, 2, &hd_emlrtRTEI, true);
  if ((thr->size[0] == 1) && (thr->size[1] == 1)) {
    i = b_thr->size[0] * b_thr->size[1];
    b_thr->size[0] = 1;
    b_thr->size[1] = inVectorLength;
    emxEnsureCapacity_real_T(b_thr, i, &e_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_thr, &b_gpu_thr);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
      static_cast<int8_T>(inVectorLength) - 1) + 1L), &grid, &block, 1024U,
      65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_thr, thr);
      ecc_detr_kernel11<<<grid, block>>>(gpu_thr, static_cast<int8_T>
        (inVectorLength), b_gpu_thr);
      thr_dirtyOnGpu = true;
    }
  } else if ((thr->size[0] == 0) || (thr->size[1] == 0)) {
    i = b_thr->size[0] * b_thr->size[1];
    b_thr->size[0] = 1;
    b_thr->size[1] = inVectorLength;
    emxEnsureCapacity_real_T(b_thr, i, &e_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_thr, &b_gpu_thr);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_thr, thr);
      ecc_detr_kernel10<<<grid, block>>>(gpu_thr, inVectorLength, b_gpu_thr);
      thr_dirtyOnGpu = true;
    }
  } else {
    i = b_thr->size[0] * b_thr->size[1];
    b_thr->size[0] = 1;
    b_thr->size[1] = inVectorLength;
    emxEnsureCapacity_real_T(b_thr, i, &e_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_thr, &b_gpu_thr);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_thr, thr);
      ecc_detr_kernel9<<<grid, block>>>(gpu_thr, inVectorLength, b_gpu_thr);
      thr_dirtyOnGpu = true;
    }
  }

  // 'ecc_detr:24' itr (1,:){mustBeFloat}
  inVectorLength = 1;
  if (itr->size[0] != 1) {
    inVectorLength = 0;
  }

  if (itr->size[1] != 1) {
    inVectorLength = itr->size[1];
  }

  emxInit_real_T(&b_itr, 2, &id_emlrtRTEI, true);
  if ((itr->size[0] == 1) && (itr->size[1] == 1)) {
    i = b_itr->size[0] * b_itr->size[1];
    b_itr->size[0] = 1;
    b_itr->size[1] = inVectorLength;
    emxEnsureCapacity_real_T(b_itr, i, &f_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_itr, &b_gpu_itr);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
      static_cast<int8_T>(inVectorLength) - 1) + 1L), &grid, &block, 1024U,
      65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_itr, itr);
      ecc_detr_kernel14<<<grid, block>>>(gpu_itr, static_cast<int8_T>
        (inVectorLength), b_gpu_itr);
      itr_dirtyOnGpu = true;
    }
  } else if ((itr->size[0] == 0) || (itr->size[1] == 0)) {
    i = b_itr->size[0] * b_itr->size[1];
    b_itr->size[0] = 1;
    b_itr->size[1] = inVectorLength;
    emxEnsureCapacity_real_T(b_itr, i, &f_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_itr, &b_gpu_itr);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_itr, itr);
      ecc_detr_kernel13<<<grid, block>>>(gpu_itr, inVectorLength, b_gpu_itr);
      itr_dirtyOnGpu = true;
    }
  } else {
    i = b_itr->size[0] * b_itr->size[1];
    b_itr->size[0] = 1;
    b_itr->size[1] = inVectorLength;
    emxEnsureCapacity_real_T(b_itr, i, &f_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_itr, &b_gpu_itr);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_itr, itr);
      ecc_detr_kernel12<<<grid, block>>>(gpu_itr, inVectorLength, b_gpu_itr);
      itr_dirtyOnGpu = true;
    }
  }

  //  Main
  // 'ecc_detr:28' coder.gpu.kernelfun;
  //  trigger CUDA kernel generation
  // 'ecc_detr:29' nFrames = size(x,1);
  nFrames = x->size[0];

  // 'ecc_detr:30' nChs = size(x,2);
  // 'ecc_detr:31' reps = numel(ord);
  // 'ecc_detr:32' olPct = coder.nullcopy(nan(nChs,reps));
  emxInit_int32_T(&b_olPct, 2, &jd_emlrtRTEI, true);
  i = b_olPct->size[0] * b_olPct->size[1];
  b_olPct->size[0] = x->size[1];
  b_olPct->size[1] = b_ord->size[1];
  emxEnsureCapacity_int32_T(b_olPct, i, &g_emlrtRTEI);
  gpuEmxEnsureCapacity_int32_T(b_olPct, &gpu_olPct);

  //  Detrend by polynomial order
  // 'ecc_detr:35' for ii = 1:reps
  b_i = b_ord->size[1];
  emxInit_real_T(&regs, 2, &kd_emlrtRTEI, true);
  emxInit_real_T(&lin, 2, &ld_emlrtRTEI, true);
  emxInit_real_T(&dv, 2, &md_emlrtRTEI, true);
  emxInit_real_T(&dv1, 1, &md_emlrtRTEI, true);
  emxInit_real_T(&dv2, 1, &md_emlrtRTEI, true);
  emxInit_real_T(&z, 1, &nd_emlrtRTEI, true);
  emxInit_boolean_T(&b_x, 1, &q_emlrtRTEI, true);
  emxInit_real_T(&c_x, 1, &r_emlrtRTEI, true);
  emxInit_real_T(&d_x, 1, &r_emlrtRTEI, true);
  emxInit_real_T(&y, 2, &od_emlrtRTEI, true);
  emxInit_real_T(&e_x, 2, &r_emlrtRTEI, true);
  emxInit_real_T(&r, 2, &pd_emlrtRTEI, true);
  emxInit_real_T(&rr, 2, &u_emlrtRTEI, true);
  emxInit_real_T(&A, 2, &md_emlrtRTEI, true);
  emxInit_real_T(&b_A, 2, &v_emlrtRTEI, true);
  emxInit_creal_T(&V, 2, &md_emlrtRTEI, true);
  emxInit_creal_T(&D, 2, &md_emlrtRTEI, true);
  emxInit_real_T(&b_V, 2, &qd_emlrtRTEI, true);
  emxInit_creal_T(&d, 1, &rd_emlrtRTEI, true);
  emxInit_real_T(&b_D, 1, &sd_emlrtRTEI, true);
  emxInit_boolean_T(&bv, 1, &nb_emlrtRTEI, true);
  emxInit_int32_T(&iv7, 1, &nb_emlrtRTEI, true);
  emxInit_real_T(&c_V, 2, &md_emlrtRTEI, true);
  emxInit_real_T(&scale, 1, &td_emlrtRTEI, true);
  emxInit_real_T(&tau, 1, &md_emlrtRTEI, true);
  emxInit_real_T(&U, 2, &md_emlrtRTEI, true);
  emxInit_creal_T(&W, 1, &md_emlrtRTEI, true);
  emxInit_real_T(&c_A, 2, &kc_emlrtRTEI, true);
  emxInit_real_T(&wreal, 1, &ud_emlrtRTEI, true);
  emxInit_real_T(&b_tau, 1, &md_emlrtRTEI, true);
  emxInit_real_T(&wimag, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&d_A, 2, &v_emlrtRTEI, true);
  emxInit_real_T(&vright, 2, &wd_emlrtRTEI, true);
  emxInit_real_T(&wr, 2, &xd_emlrtRTEI, true);
  emxInit_real_T(&wi, 2, &yd_emlrtRTEI, true);
  emxInit_real_T(&b, 2, &oc_emlrtRTEI, true);
  emxInit_real_T(&e_A, 2, &v_emlrtRTEI, true);
  emxInit_real_T(&b_wr, 2, &xd_emlrtRTEI, true);
  emxInit_real_T(&b_wi, 2, &yd_emlrtRTEI, true);
  emxInit_real_T(&f_A, 2, &md_emlrtRTEI, true);
  emxInit_real_T(&Y, 1, &ae_emlrtRTEI, true);
  emxInit_real_T(&g_A, 2, &md_emlrtRTEI, true);
  emxInit_real_T(&B, 1, &qc_emlrtRTEI, true);
  emxInit_int32_T(&ipiv, 2, &md_emlrtRTEI, true);
  emxInit_real_T(&b_B, 1, &rc_emlrtRTEI, true);
  emxInit_int32_T(&jpvt, 2, &md_emlrtRTEI, true);
  emxInit_int32_T(&ipiv_t, 1, &be_emlrtRTEI, true);
  emxInit_real_T(&c_tau, 1, &md_emlrtRTEI, true);
  emxInit_real_T(&b_y, 1, &ce_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &vc_emlrtRTEI, true);
  emxInit_real_T(&dv8, 1, &md_emlrtRTEI, true);
  emxInit_real_T(&b_d, 1, &yc_emlrtRTEI, true);
  emxInit_real_T(&absdiff, 1, &de_emlrtRTEI, true);
  emxInit_real_T(&c_y, 1, &dd_emlrtRTEI, true);
  emxInit_boolean_T(&bv1, 1, &dd_emlrtRTEI, true);
  emxInit_int32_T(&iv10, 1, &md_emlrtRTEI, true);
  emxInit_real_T(&f_x, 1, &p_emlrtRTEI, true);
  emxInit_real_T(&d_V, 2, &xb_emlrtRTEI, true);
  for (int32_T ii{0}; ii < b_i; ii++) {
    int32_T i4;
    int32_T minmana;
    int32_T na;

    // 'ecc_detr:36' iOrd=ord(ii);
    // 'ecc_detr:36' iThr=thr(ii);
    // 'ecc_detr:36' iItr=itr(ii);
    //  copy
    // 'ecc_detr:37' regs = regsFromBasis_lfn(nFrames,iOrd);
    // %%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    //  Get regressors from polynomial function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    // 'ecc_detr:58' regs = coder.nullcopy(zeros(nFrames,iOrd,'like',iOrd));
    i = regs->size[0] * regs->size[1];
    regs->size[0] = nFrames;
    if (ord_dirtyOnGpu) {
      gpuEmxMemcpyGpuToCpu_real_T(b_ord, &b_gpu_ord);
    }

    regs->size[1] = static_cast<int32_T>(b_ord->data[ii]);
    emxEnsureCapacity_real_T(regs, i, &j_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(regs, &gpu_regs);

    // 'ecc_detr:59' lin = linspace(-1,1,nFrames);
    i = lin->size[0] * lin->size[1];
    lin->size[0] = 1;
    lin->size[1] = nFrames;
    emxEnsureCapacity_real_T(lin, i, &k_emlrtRTEI);
    if (!lin_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real_T(lin, &gpu_lin);
    }

    if (nFrames >= 1) {
      if (lin_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(lin, &gpu_lin);
      }

      lin->data[nFrames - 1] = 1.0;
      lin_dirtyOnGpu = false;
      lin_dirtyOnCpu = true;
      if (lin->size[1] >= 2) {
        lin->data[0] = -1.0;
        if (lin->size[1] >= 3) {
          d2scaled = 1.0 / (static_cast<real_T>(lin->size[1]) - 1.0);
          inVectorLength = lin->size[1] - 3;
          m = lin->size[1];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, lin);
            ecc_detr_kernel15<<<grid, block>>>(inVectorLength, m, gpu_d2scaled,
              gpu_lin);
            lin_dirtyOnCpu = false;
            lin_dirtyOnGpu = true;
          }

          if ((lin->size[1] & 1) == 1) {
            m = lin->size[1];
            if (lin_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, lin);
            }

            ecc_detr_kernel16<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(m,
              gpu_lin);
            lin_dirtyOnCpu = false;
            lin_dirtyOnGpu = true;
          }
        }
      }
    }

    // 'ecc_detr:60' for k = 1:iOrd
    ord_dirtyOnGpu = false;
    vlen = static_cast<int32_T>(b_ord->data[ii]);
    for (na = 0; na < vlen; na++) {
      // 'ecc_detr:61' regs(:,k) = lin.^k;
      i = dv->size[0] * dv->size[1];
      dv->size[0] = 1;
      dv->size[1] = lin->size[1];
      emxEnsureCapacity_real_T(dv, i, &l_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(dv, &gpu_dv);
      inVectorLength = lin->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        (inVectorLength + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (lin_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, lin);
        }

        lin_dirtyOnCpu = false;
        ecc_detr_kernel17<<<grid, block>>>(na, gpu_lin, inVectorLength, gpu_dv);
      }

      inVectorLength = regs->size[0];
      minmana = regs->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ecc_detr_kernel18<<<grid, block>>>(gpu_dv, na, inVectorLength, minmana,
          gpu_regs);
        regs_dirtyOnGpu = true;
      }
    }

    //  Get regressors from basis function
    //  Detrend per chan
    // 'ecc_detr:40' for ch = 1:nChs
    i4 = x->size[1];
    if (i4 - 1 >= 0) {
      if (itr_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(b_itr, &b_gpu_itr);
      }

      itr_dirtyOnGpu = false;
      i5 = static_cast<int32_T>(b_itr->data[ii]);
    }

    for (int32_T ch{0}; ch < i4; ch++) {
      // 'ecc_detr:41' [x(:,ch),w(:,ch)] = detrend_lfn(x(:,ch),w(:,ch),regs,iThr,iItr);
      i = dv1->size[0];
      dv1->size[0] = x->size[0];
      emxEnsureCapacity_real_T(dv1, i, &m_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(dv1, &gpu_dv1);
      m = x->size[0] - 1;
      x_dim0 = x->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
        }

        x_dirtyOnCpu = false;
        ecc_detr_kernel19<<<grid, block>>>(ch, gpu_x, m, x_dim0, gpu_dv1);
        dv1_dirtyOnGpu = true;
      }

      i = dv2->size[0];
      dv2->size[0] = w->size[0];
      emxEnsureCapacity_real_T(dv2, i, &n_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(dv2, &gpu_dv2);
      m = w->size[0] - 1;
      n = w->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (w_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, w);
        }

        w_dirtyOnCpu = false;
        ecc_detr_kernel20<<<grid, block>>>(ch, gpu_w, m, n, gpu_dv2);
        dv2_dirtyOnGpu = true;
      }

      //  Standard detrending (trend fit to entire data) %%%%%%%%%%%%%%%%%%%%%%%%%
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
      //  Detrend per polynomial order
      // 'ecc_detr:80' z = coder.nullcopy(x);
      i = z->size[0];
      z->size[0] = x->size[0];
      emxEnsureCapacity_real_T(z, i, &o_emlrtRTEI);
      if (!z_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(z, &gpu_z);
      }

      // 'ecc_detr:81' for ii = 1:iItr
      for (int32_T b_ii{0}; b_ii < i5; b_ii++) {
        real_T b_mn;
        real_T mn;
        int32_T e_V[2];
        boolean_T abnrm_dirtyOnGpu;

        //  Weighted regression
        // 'ecc_detr:83' z = regw_lfn(x,w,r);
        //  Weighted Regression %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //   b: regression matrix (apply to r to approximate x)
        //   z: regression (r*b)
        //  Discard dimensions of r with eigenvalue lower than this
        // 'ecc_detr:102' thrPCA = 1e-7;
        // zeros(1,1,class(x));
        //  Save weighted mean
        // 'ecc_detr:105' mn = x - demean_lfn(x,w);
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ecc_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (dv1->size[0] == dv2->size[0]) {
          i = c_x->size[0];
          c_x->size[0] = dv1->size[0];
          emxEnsureCapacity_real_T(c_x, i, &r_emlrtRTEI);
          if (!b_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(c_x, &c_gpu_x);
          }

          m = dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, c_x);
            }

            ecc_detr_kernel21<<<grid, block>>>(gpu_dv2, gpu_dv1, m, c_gpu_x);
            b_x_dirtyOnCpu = false;
            b_x_dirtyOnGpu = true;
          }
        } else {
          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_x, &c_gpu_x);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          times(c_x, dv1, dv2);
          b_x_dirtyOnGpu = false;
          b_x_dirtyOnCpu = true;
        }

        vlen = c_x->size[0];
        if (c_x->size[0] == 0) {
          abnrm = 0.0;
        } else {
          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_x, &c_gpu_x);
          }

          b_x_dirtyOnGpu = false;
          abnrm = c_x->data[0];
          for (minmana = 0; minmana <= vlen - 2; minmana++) {
            abnrm += c_x->data[minmana + 1];
          }
        }

        vlen = dv2->size[0];
        if (dv2->size[0] == 0) {
          d2scaled = 0.0;
        } else {
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          d2scaled = dv2->data[0];
          for (minmana = 0; minmana <= vlen - 2; minmana++) {
            d2scaled += dv2->data[minmana + 1];
          }
        }

        mn = abnrm / (d2scaled + 2.2204460492503131E-16);

        // 'ecc_detr:125' x = x - mn;
        //  Fit weighted regression
        // 'ecc_detr:108' x = demean_lfn(x,w).* w;
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ecc_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (dv1->size[0] == dv2->size[0]) {
          i = d_x->size[0];
          d_x->size[0] = dv1->size[0];
          emxEnsureCapacity_real_T(d_x, i, &r_emlrtRTEI);
          if (!c_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(d_x, &e_gpu_x);
          }

          m = dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_x, d_x);
            }

            ecc_detr_kernel22<<<grid, block>>>(gpu_dv2, gpu_dv1, m, e_gpu_x);
            c_x_dirtyOnCpu = false;
            d_x_dirtyOnGpu = true;
          }
        } else {
          if (d_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_x, &e_gpu_x);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          times(d_x, dv1, dv2);
          d_x_dirtyOnGpu = false;
          c_x_dirtyOnCpu = true;
        }

        vlen = d_x->size[0];
        if (d_x->size[0] == 0) {
          abnrm = 0.0;
        } else {
          if (d_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_x, &e_gpu_x);
          }

          d_x_dirtyOnGpu = false;
          abnrm = d_x->data[0];
          for (minmana = 0; minmana <= vlen - 2; minmana++) {
            abnrm += d_x->data[minmana + 1];
          }
        }

        vlen = dv2->size[0];
        if (dv2->size[0] == 0) {
          d2scaled = 0.0;
        } else {
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          d2scaled = dv2->data[0];
          for (minmana = 0; minmana <= vlen - 2; minmana++) {
            d2scaled += dv2->data[minmana + 1];
          }
        }

        b_mn = abnrm / (d2scaled + 2.2204460492503131E-16);

        // 'ecc_detr:125' x = x - mn;
        // 'ecc_detr:109' r = demean_lfn(r,w);
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ecc_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (regs->size[0] == dv2->size[0]) {
          i = e_x->size[0] * e_x->size[1];
          e_x->size[0] = regs->size[0];
          e_x->size[1] = regs->size[1];
          emxEnsureCapacity_real_T(e_x, i, &r_emlrtRTEI);
          if (!d_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(e_x, &f_gpu_x);
          }

          m = regs->size[1] - 1;
          n = regs->size[0] - 1;
          x_dim0 = e_x->size[0];
          minmana = regs->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((n +
            1L) * (m + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (d_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, e_x);
            }

            ecc_detr_kernel23<<<grid, block>>>(gpu_dv2, gpu_regs, n, m, x_dim0,
              minmana, f_gpu_x);
            d_x_dirtyOnCpu = false;
            e_x_dirtyOnGpu = true;
          }
        } else {
          if (e_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_x, &f_gpu_x);
          }

          if (regs_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(regs, &gpu_regs);
          }

          regs_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          binary_expand_op(e_x, regs, dv2);
          e_x_dirtyOnGpu = false;
          d_x_dirtyOnCpu = true;
        }

        vlen = e_x->size[0];
        if ((e_x->size[0] == 0) || (e_x->size[1] == 0)) {
          for (i = 0; i < 2; i++) {
            if (sz_dirtyOnGpu) {
              cudaMemcpy(sz, *gpu_sz, 8UL, cudaMemcpyDeviceToHost);
            }

            sz[i] = static_cast<uint32_T>(e_x->size[i]);
            sz_dirtyOnGpu = false;
            sz_dirtyOnCpu = true;
          }

          i = y->size[0] * y->size[1];
          y->size[0] = 1;
          if (sz_dirtyOnGpu) {
            cudaMemcpy(sz, *gpu_sz, 8UL, cudaMemcpyDeviceToHost);
          }

          y->size[1] = static_cast<int32_T>(sz[1]);
          emxEnsureCapacity_real_T(y, i, &s_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(y, &gpu_y);
          sz_dirtyOnGpu = false;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
            static_cast<int32_T>(sz[1]) - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detr_kernel25<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
              gpu_y);
            y_dirtyOnGpu = true;
          }
        } else {
          inVectorLength = e_x->size[1] - 1;
          i = y->size[0] * y->size[1];
          y->size[0] = 1;
          y->size[1] = e_x->size[1];
          emxEnsureCapacity_real_T(y, i, &h_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(y, &gpu_y);
          x_dim0 = e_x->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (d_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, e_x);
            }

            d_x_dirtyOnCpu = false;
            cudaMemcpy(gpu_vlen, &vlen, 4UL, cudaMemcpyHostToDevice);
            ecc_detr_kernel24<<<grid, block>>>(f_gpu_x, inVectorLength, x_dim0,
              gpu_vlen, gpu_y);
            y_dirtyOnGpu = true;
          }
        }

        vlen = dv2->size[0];
        if (dv2->size[0] == 0) {
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
        } else {
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          abnrm = dv2->data[0];
          abnrm_dirtyOnGpu = false;
          for (minmana = 0; minmana <= vlen - 2; minmana++) {
            abnrm += dv2->data[minmana + 1];
          }
        }

        // 'ecc_detr:125' x = x - mn;
        if (regs->size[1] == y->size[1]) {
          abnrm += 2.2204460492503131E-16;
          i = r->size[0] * r->size[1];
          r->size[0] = regs->size[0];
          r->size[1] = regs->size[1];
          emxEnsureCapacity_real_T(r, i, &t_emlrtRTEI);
          if (!r_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(r, &gpu_r);
          }

          m = regs->size[1] - 1;
          n = regs->size[0] - 1;
          x_dim0 = r->size[0];
          minmana = regs->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((n +
            1L) * (m + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_abnrm, &abnrm, 8UL, cudaMemcpyHostToDevice);
            if (r_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, r);
            }

            ecc_detr_kernel26<<<grid, block>>>(gpu_y, gpu_regs, n, m, x_dim0,
              minmana, gpu_abnrm, gpu_r);
            r_dirtyOnCpu = false;
            r_dirtyOnGpu = true;
            abnrm_dirtyOnGpu = true;
          }
        } else {
          if (r_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
          }

          if (regs_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(regs, &gpu_regs);
          }

          regs_dirtyOnGpu = false;
          if (y_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(y, &gpu_y);
          }

          y_dirtyOnGpu = false;
          b_binary_expand_op(r, regs, y, abnrm);
          r_dirtyOnGpu = false;
          r_dirtyOnCpu = true;
        }

        //  remove channel-specific-weighted mean from regressor
        // 'ecc_detr:110' rr = r.*w;
        if (r->size[0] == dv2->size[0]) {
          i = rr->size[0] * rr->size[1];
          rr->size[0] = r->size[0];
          rr->size[1] = r->size[1];
          emxEnsureCapacity_real_T(rr, i, &u_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(rr, &gpu_rr);
          }

          m = r->size[1] - 1;
          n = r->size[0] - 1;
          minmana = rr->size[0];
          x_dim0 = r->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((n +
            1L) * (m + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (r_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, r);
            }

            r_dirtyOnCpu = false;
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
            }

            ecc_detr_kernel27<<<grid, block>>>(gpu_dv2, gpu_r, n, m, minmana,
              x_dim0, gpu_rr);
            rr_dirtyOnCpu = false;
            rr_dirtyOnGpu = true;
          }
        } else {
          if (rr_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(rr, &gpu_rr);
          }

          if (r_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(r, &gpu_r);
          }

          r_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          binary_expand_op(rr, r, dv2);
          rr_dirtyOnGpu = false;
          rr_dirtyOnCpu = true;
        }

        // 'ecc_detr:111' [V,D] = eig(rr'*rr);
        i = b_A->size[0] * b_A->size[1];
        b_A->size[0] = rr->size[1];
        b_A->size[1] = rr->size[0];
        emxEnsureCapacity_real_T(b_A, i, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_A, &gpu_A);
        n = rr->size[0] - 1;
        m = rr->size[1] - 1;
        inVectorLength = b_A->size[0];
        minmana = rr->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((m + 1L)
          * (n + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          rr_dirtyOnCpu = false;
          ecc_detr_kernel28<<<grid, block>>>(gpu_rr, m, n, inVectorLength,
            minmana, gpu_A);
        }

        if ((b_A->size[0] == 0) || (b_A->size[1] == 0) || (rr->size[0] == 0) ||
            (rr->size[1] == 0)) {
          i = A->size[0] * A->size[1];
          A->size[0] = b_A->size[0];
          A->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(A, i, &x_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(A, &b_gpu_A);
          }

          x_dim0 = b_A->size[0] * rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
            }

            ecc_detr_kernel29<<<grid, block>>>(x_dim0, b_gpu_A);
            A_dirtyOnCpu = false;
            A_dirtyOnGpu = true;
          }
        } else {
          i = A->size[0] * A->size[1];
          A->size[0] = b_A->size[0];
          A->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(A, i, &w_emlrtRTEI);
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

        n = A->size[0];
        i = V->size[0] * V->size[1];
        V->size[0] = A->size[0];
        V->size[1] = A->size[0];
        emxEnsureCapacity_creal_T(V, i, &y_emlrtRTEI);
        if (!V_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
        }

        i = D->size[0] * D->size[1];
        D->size[0] = A->size[0];
        D->size[1] = A->size[0];
        emxEnsureCapacity_creal_T(D, i, &ab_emlrtRTEI);
        if (!D_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
        }

        if ((A->size[0] != 0) && (A->size[1] != 0)) {
          inVectorLength = A->size[0] * A->size[1];
          olPct_dirtyOnCpu = true;
          for (na = 0; na < inVectorLength; na++) {
            if (olPct_dirtyOnCpu) {
              if (A_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
              }

              A_dirtyOnGpu = false;
              if (std::isinf(A->data[na]) || std::isnan(A->data[na])) {
                olPct_dirtyOnCpu = false;
              }
            } else {
              olPct_dirtyOnCpu = false;
            }
          }

          if (!olPct_dirtyOnCpu) {
            for (i = 0; i < 2; i++) {
              e_V[i] = V->size[i];
            }

            i = V->size[0] * V->size[1];
            V->size[0] = e_V[0];
            V->size[1] = e_V[1];
            emxEnsureCapacity_creal_T(V, i, &cb_emlrtRTEI);
            if (!V_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
            }

            m = e_V[0] * e_V[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (V_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
              }

              ecc_detr_kernel58<<<grid, block>>>(gpu_dc, m, gpu_V);
              V_dirtyOnCpu = false;
              V_dirtyOnGpu = true;
            }

            for (i = 0; i < 2; i++) {
              e_V[i] = D->size[i];
            }

            i = D->size[0] * D->size[1];
            D->size[0] = e_V[0];
            D->size[1] = e_V[1];
            emxEnsureCapacity_creal_T(D, i, &ib_emlrtRTEI);
            if (!D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
            }

            m = e_V[0] * e_V[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
              }

              ecc_detr_kernel59<<<grid, block>>>(m, gpu_D);
              D_dirtyOnCpu = false;
              D_dirtyOnGpu = true;
            }

            for (na = 0; na < n; na++) {
              if (D_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_creal_T(D, &gpu_D);
              }

              if (dc_dirtyOnGpu) {
                cudaMemcpy(&dc, gpu_dc, 16UL, cudaMemcpyDeviceToHost);
              }

              dc_dirtyOnGpu = false;
              D->data[na + D->size[0] * na] = dc;
              D_dirtyOnGpu = false;
              D_dirtyOnCpu = true;
            }
          } else {
            int32_T exitg1;
            boolean_T exitg2;
            olPct_dirtyOnCpu = (A->size[0] == A->size[1]);
            if (olPct_dirtyOnCpu) {
              minmana = 0;
              exitg2 = false;
              while ((!exitg2) && (minmana <= A->size[1] - 1)) {
                i = 0;
                do {
                  exitg1 = 0;
                  if (i <= minmana) {
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                    }

                    A_dirtyOnGpu = false;
                    if (!(A->data[i + A->size[0] * minmana] == A->data[minmana +
                          A->size[0] * i])) {
                      olPct_dirtyOnCpu = false;
                      exitg1 = 1;
                    } else {
                      i++;
                    }
                  } else {
                    minmana++;
                    exitg1 = 2;
                  }
                } while (exitg1 == 0);

                if (exitg1 == 1) {
                  exitg2 = true;
                }
              }
            }

            if (olPct_dirtyOnCpu) {
              inVectorLength = A->size[0] * A->size[1];
              for (na = 0; na < inVectorLength; na++) {
                if (olPct_dirtyOnCpu) {
                  if (A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                  }

                  A_dirtyOnGpu = false;
                  if (std::isinf(A->data[na]) || std::isnan(A->data[na])) {
                    olPct_dirtyOnCpu = false;
                  }
                } else {
                  olPct_dirtyOnCpu = false;
                }
              }

              if (!olPct_dirtyOnCpu) {
                for (i = 0; i < 2; i++) {
                  if (sz_dirtyOnGpu) {
                    cudaMemcpy(sz, *gpu_sz, 8UL, cudaMemcpyDeviceToHost);
                  }

                  sz[i] = static_cast<uint32_T>(A->size[i]);
                  sz_dirtyOnGpu = false;
                  sz_dirtyOnCpu = true;
                }

                i = c_V->size[0] * c_V->size[1];
                if (sz_dirtyOnGpu) {
                  cudaMemcpy(sz, *gpu_sz, 8UL, cudaMemcpyDeviceToHost);
                }

                c_V->size[0] = static_cast<int32_T>(sz[0]);
                c_V->size[1] = static_cast<int32_T>(sz[1]);
                emxEnsureCapacity_real_T(c_V, i, &jb_emlrtRTEI);
                if (!b_V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(c_V, &c_gpu_V);
                }

                m = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) -
                  1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_V, c_V);
                  }

                  ecc_detr_kernel52<<<grid, block>>>(m, c_gpu_V);
                  b_V_dirtyOnCpu = false;
                  b_V_dirtyOnGpu = true;
                }

                m = static_cast<int32_T>(sz[0]) - 1;
                sz_dirtyOnGpu = false;
                if (static_cast<int32_T>(sz[0]) > 1) {
                  inVectorLength = 1;
                  if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>(sz
                       [1]) - 1) {
                    vlen = static_cast<int32_T>(sz[0]) - 1;
                  } else {
                    vlen = static_cast<int32_T>(sz[1]);
                  }

                  for (minmana = 0; minmana < vlen; minmana++) {
                    for (i = 0; i <= m - inVectorLength; i++) {
                      if (b_V_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(c_V, &c_gpu_V);
                      }

                      c_V->data[(inVectorLength + i) + c_V->size[0] * minmana] =
                        0.0;
                      b_V_dirtyOnGpu = false;
                      b_V_dirtyOnCpu = true;
                    }

                    inVectorLength++;
                  }
                }

                for (i = 0; i < 2; i++) {
                  sz[i] = static_cast<uint32_T>(A->size[i]);
                  sz_dirtyOnCpu = true;
                }

                i = A->size[0] * A->size[1];
                A->size[0] = static_cast<int32_T>(sz[0]);
                A->size[1] = static_cast<int32_T>(sz[1]);
                emxEnsureCapacity_real_T(A, i, &tb_emlrtRTEI);
                if (!A_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(A, &b_gpu_A);
                }

                m = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1]) -
                  1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (A_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                  }

                  ecc_detr_kernel53<<<grid, block>>>(m, b_gpu_A);
                  A_dirtyOnCpu = false;
                  A_dirtyOnGpu = true;
                }
              } else {
                ptrdiff_t c_info_t;
                ptrdiff_t e_info_t;
                ptrdiff_t n_t;
                n = A->size[0];
                i = tau->size[0];
                tau->size[0] = A->size[0] - 1;
                emxEnsureCapacity_real_T(tau, i, &gb_emlrtRTEI);
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
                    for (i = 0; i < 2; i++) {
                      e_V[i] = A->size[i];
                    }

                    i = A->size[0] * A->size[1];
                    A->size[0] = e_V[0];
                    A->size[1] = e_V[1];
                    emxEnsureCapacity_real_T(A, i, &pb_emlrtRTEI);
                    m = e_V[0] * e_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(m + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                      ecc_detr_kernel46<<<grid, block>>>(m, b_gpu_A);
                      A_dirtyOnCpu = false;
                      A_dirtyOnGpu = true;
                    }

                    inVectorLength = tau->size[0];
                    i = tau->size[0];
                    tau->size[0] = inVectorLength;
                    emxEnsureCapacity_real_T(tau, i, &vb_emlrtRTEI);
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>((inVectorLength - 1) + 1L), &grid,
                       &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, tau);
                      ecc_detr_kernel47<<<grid, block>>>(inVectorLength, gpu_tau);
                      tau_dirtyOnCpu = false;
                      tau_dirtyOnGpu = true;
                    }
                  }
                }

                i = c_V->size[0] * c_V->size[1];
                c_V->size[0] = A->size[0];
                c_V->size[1] = A->size[1];
                emxEnsureCapacity_real_T(c_V, i, &lb_emlrtRTEI);
                if (!b_V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(c_V, &c_gpu_V);
                }

                x_dim0 = A->size[0] * A->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (A_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                  }

                  if (b_V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_V, c_V);
                  }

                  ecc_detr_kernel48<<<grid, block>>>(b_gpu_A, x_dim0, c_gpu_V);
                  b_V_dirtyOnGpu = true;
                }

                if (b_V_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_V, &c_gpu_V);
                }

                if (tau_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(tau, &gpu_tau);
                }

                tau_dirtyOnGpu = false;
                c_info_t = LAPACKE_dorghr(102, (ptrdiff_t)n, (ptrdiff_t)1,
                  (ptrdiff_t)n, &c_V->data[0], (ptrdiff_t)n, &tau->data[0]);
                b_V_dirtyOnGpu = false;
                if ((int32_T)c_info_t != 0) {
                  for (i = 0; i < 2; i++) {
                    e_V[i] = c_V->size[i];
                  }

                  i = c_V->size[0] * c_V->size[1];
                  c_V->size[0] = e_V[0];
                  c_V->size[1] = e_V[1];
                  emxEnsureCapacity_real_T(c_V, i, &lb_emlrtRTEI);
                  m = e_V[0] * e_V[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (m + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_V, c_V);
                    ecc_detr_kernel49<<<grid, block>>>(m, c_gpu_V);
                    b_V_dirtyOnGpu = true;
                  }
                }

                n_t = (ptrdiff_t)A->size[0];
                i = wr->size[0] * wr->size[1];
                wr->size[0] = 1;
                wr->size[1] = A->size[0];
                emxEnsureCapacity_real_T(wr, i, &ub_emlrtRTEI);
                i = wi->size[0] * wi->size[1];
                wi->size[0] = 1;
                wi->size[1] = A->size[0];
                emxEnsureCapacity_real_T(wi, i, &wb_emlrtRTEI);
                if (A_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                }

                if (b_V_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_V, &c_gpu_V);
                }

                if (A->size[0] <= 1) {
                  m = 1;
                } else {
                  m = A->size[0];
                }

                e_info_t = LAPACKE_dhseqr(102, 'S', 'V', n_t, (ptrdiff_t)1,
                  (ptrdiff_t)A->size[0], &A->data[0], n_t, &wr->data[0],
                  &wi->data[0], &c_V->data[0], (ptrdiff_t)m);
                b_V_dirtyOnGpu = false;
                b_V_dirtyOnCpu = true;
                A_dirtyOnGpu = false;
                A_dirtyOnCpu = true;
                if ((int32_T)e_info_t < 0) {
                  for (i = 0; i < 2; i++) {
                    e_V[i] = A->size[i];
                  }

                  i = A->size[0] * A->size[1];
                  A->size[0] = e_V[0];
                  A->size[1] = e_V[1];
                  emxEnsureCapacity_real_T(A, i, &dc_emlrtRTEI);
                  m = e_V[0] * e_V[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (m + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                    ecc_detr_kernel50<<<grid, block>>>(m, b_gpu_A);
                    A_dirtyOnCpu = false;
                    A_dirtyOnGpu = true;
                  }

                  for (i = 0; i < 2; i++) {
                    e_V[i] = c_V->size[i];
                  }

                  i = c_V->size[0] * c_V->size[1];
                  c_V->size[0] = e_V[0];
                  c_V->size[1] = e_V[1];
                  emxEnsureCapacity_real_T(c_V, i, &ic_emlrtRTEI);
                  m = e_V[0] * e_V[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (m + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_V, c_V);
                    ecc_detr_kernel51<<<grid, block>>>(m, c_gpu_V);
                    b_V_dirtyOnCpu = false;
                    b_V_dirtyOnGpu = true;
                  }
                }
              }

              n = A->size[0];
              for (minmana = 0; minmana <= n - 2; minmana++) {
                inVectorLength = A->size[0];
                if (A_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                }

                ecc_detr_kernel54<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                  (minmana, inVectorLength, b_gpu_A);
                A_dirtyOnCpu = false;
                A_dirtyOnGpu = true;
                inVectorLength = A->size[0];
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (minmana + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  ecc_detr_kernel55<<<grid, block>>>(minmana, inVectorLength,
                    b_gpu_A);
                }
              }

              i = V->size[0] * V->size[1];
              V->size[0] = c_V->size[0];
              V->size[1] = c_V->size[1];
              emxEnsureCapacity_creal_T(V, i, &ac_emlrtRTEI);
              if (!V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
              }

              m = c_V->size[0] * c_V->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_V, c_V);
                }

                b_V_dirtyOnCpu = false;
                if (V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                }

                ecc_detr_kernel56<<<grid, block>>>(c_gpu_V, m, gpu_V);
                V_dirtyOnCpu = false;
                V_dirtyOnGpu = true;
              }

              i = D->size[0] * D->size[1];
              D->size[0] = A->size[0];
              D->size[1] = A->size[1];
              emxEnsureCapacity_creal_T(D, i, &fc_emlrtRTEI);
              if (!D_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
              }

              x_dim0 = A->size[0] * A->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (A_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                }

                A_dirtyOnCpu = false;
                if (D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
                }

                ecc_detr_kernel57<<<grid, block>>>(b_gpu_A, x_dim0, gpu_D);
                D_dirtyOnCpu = false;
                D_dirtyOnGpu = true;
              }
            } else {
              olPct_dirtyOnCpu = (A->size[0] == A->size[1]);
              if (olPct_dirtyOnCpu) {
                minmana = 0;
                exitg2 = false;
                while ((!exitg2) && (minmana <= A->size[1] - 1)) {
                  i = 0;
                  do {
                    exitg1 = 0;
                    if (i <= minmana) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (!(A->data[i + A->size[0] * minmana] == -A->
                            data[minmana + A->size[0] * i])) {
                        olPct_dirtyOnCpu = false;
                        exitg1 = 1;
                      } else {
                        i++;
                      }
                    } else {
                      minmana++;
                      exitg1 = 2;
                    }
                  } while (exitg1 == 0);

                  if (exitg1 == 1) {
                    exitg2 = true;
                  }
                }
              }

              if (olPct_dirtyOnCpu) {
                inVectorLength = A->size[0] * A->size[1];
                for (na = 0; na < inVectorLength; na++) {
                  if (olPct_dirtyOnCpu) {
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                    }

                    A_dirtyOnGpu = false;
                    if (std::isinf(A->data[na]) || std::isnan(A->data[na])) {
                      olPct_dirtyOnCpu = false;
                    }
                  } else {
                    olPct_dirtyOnCpu = false;
                  }
                }

                if (!olPct_dirtyOnCpu) {
                  for (i = 0; i < 2; i++) {
                    if (sz_dirtyOnGpu) {
                      cudaMemcpy(sz, *gpu_sz, 8UL, cudaMemcpyDeviceToHost);
                    }

                    sz[i] = static_cast<uint32_T>(A->size[i]);
                    sz_dirtyOnGpu = false;
                    sz_dirtyOnCpu = true;
                  }

                  i = U->size[0] * U->size[1];
                  if (sz_dirtyOnGpu) {
                    cudaMemcpy(sz, *gpu_sz, 8UL, cudaMemcpyDeviceToHost);
                  }

                  U->size[0] = static_cast<int32_T>(sz[0]);
                  U->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real_T(U, i, &jb_emlrtRTEI);
                  if (!U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(U, &gpu_U);
                  }

                  m = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (m + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                    }

                    ecc_detr_kernel42<<<grid, block>>>(m, gpu_U);
                    U_dirtyOnCpu = false;
                    U_dirtyOnGpu = true;
                  }

                  m = static_cast<int32_T>(sz[0]) - 1;
                  sz_dirtyOnGpu = false;
                  if (static_cast<int32_T>(sz[0]) > 1) {
                    inVectorLength = 1;
                    if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>
                        (sz[1]) - 1) {
                      vlen = static_cast<int32_T>(sz[0]) - 1;
                    } else {
                      vlen = static_cast<int32_T>(sz[1]);
                    }

                    for (minmana = 0; minmana < vlen; minmana++) {
                      for (i = 0; i <= m - inVectorLength; i++) {
                        if (U_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_real_T(U, &gpu_U);
                        }

                        U->data[(inVectorLength + i) + U->size[0] * minmana] =
                          0.0;
                        U_dirtyOnGpu = false;
                        U_dirtyOnCpu = true;
                      }

                      inVectorLength++;
                    }
                  }

                  for (i = 0; i < 2; i++) {
                    sz[i] = static_cast<uint32_T>(A->size[i]);
                    sz_dirtyOnCpu = true;
                  }

                  i = A->size[0] * A->size[1];
                  A->size[0] = static_cast<int32_T>(sz[0]);
                  A->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real_T(A, i, &tb_emlrtRTEI);
                  if (!A_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(A, &b_gpu_A);
                  }

                  m = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (m + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                    }

                    ecc_detr_kernel43<<<grid, block>>>(m, b_gpu_A);
                    A_dirtyOnCpu = false;
                    A_dirtyOnGpu = true;
                  }
                } else {
                  ptrdiff_t b_n_t;
                  ptrdiff_t d_info_t;
                  ptrdiff_t g_info_t;
                  n = A->size[0];
                  i = b_tau->size[0];
                  b_tau->size[0] = A->size[0] - 1;
                  emxEnsureCapacity_real_T(b_tau, i, &gb_emlrtRTEI);
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
                      for (i = 0; i < 2; i++) {
                        e_V[i] = A->size[i];
                      }

                      i = A->size[0] * A->size[1];
                      A->size[0] = e_V[0];
                      A->size[1] = e_V[1];
                      emxEnsureCapacity_real_T(A, i, &pb_emlrtRTEI);
                      m = e_V[0] * e_V[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(m + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                        ecc_detr_kernel36<<<grid, block>>>(m, b_gpu_A);
                        A_dirtyOnCpu = false;
                        A_dirtyOnGpu = true;
                      }

                      inVectorLength = b_tau->size[0];
                      i = b_tau->size[0];
                      b_tau->size[0] = inVectorLength;
                      emxEnsureCapacity_real_T(b_tau, i, &vb_emlrtRTEI);
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>((inVectorLength - 1) + 1L), &grid,
                         &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_tau, b_tau);
                        ecc_detr_kernel37<<<grid, block>>>(inVectorLength,
                          b_gpu_tau);
                        b_tau_dirtyOnCpu = false;
                        b_tau_dirtyOnGpu = true;
                      }
                    }
                  }

                  i = U->size[0] * U->size[1];
                  U->size[0] = A->size[0];
                  U->size[1] = A->size[1];
                  emxEnsureCapacity_real_T(U, i, &lb_emlrtRTEI);
                  if (!U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(U, &gpu_U);
                  }

                  x_dim0 = A->size[0] * A->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                    }

                    if (U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                    }

                    ecc_detr_kernel38<<<grid, block>>>(b_gpu_A, x_dim0, gpu_U);
                    U_dirtyOnGpu = true;
                  }

                  if (U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(U, &gpu_U);
                  }

                  if (b_tau_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(b_tau, &b_gpu_tau);
                  }

                  b_tau_dirtyOnGpu = false;
                  d_info_t = LAPACKE_dorghr(102, (ptrdiff_t)n, (ptrdiff_t)1,
                    (ptrdiff_t)n, &U->data[0], (ptrdiff_t)n, &b_tau->data[0]);
                  U_dirtyOnGpu = false;
                  if ((int32_T)d_info_t != 0) {
                    for (i = 0; i < 2; i++) {
                      e_V[i] = U->size[i];
                    }

                    i = U->size[0] * U->size[1];
                    U->size[0] = e_V[0];
                    U->size[1] = e_V[1];
                    emxEnsureCapacity_real_T(U, i, &lb_emlrtRTEI);
                    m = e_V[0] * e_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(m + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                      ecc_detr_kernel39<<<grid, block>>>(m, gpu_U);
                      U_dirtyOnGpu = true;
                    }
                  }

                  b_n_t = (ptrdiff_t)A->size[0];
                  i = b_wr->size[0] * b_wr->size[1];
                  b_wr->size[0] = 1;
                  b_wr->size[1] = A->size[0];
                  emxEnsureCapacity_real_T(b_wr, i, &ub_emlrtRTEI);
                  i = b_wi->size[0] * b_wi->size[1];
                  b_wi->size[0] = 1;
                  b_wi->size[1] = A->size[0];
                  emxEnsureCapacity_real_T(b_wi, i, &wb_emlrtRTEI);
                  if (A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                  }

                  if (U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(U, &gpu_U);
                  }

                  if (A->size[0] <= 1) {
                    m = 1;
                  } else {
                    m = A->size[0];
                  }

                  g_info_t = LAPACKE_dhseqr(102, 'S', 'V', b_n_t, (ptrdiff_t)1,
                    (ptrdiff_t)A->size[0], &A->data[0], b_n_t, &b_wr->data[0],
                    &b_wi->data[0], &U->data[0], (ptrdiff_t)m);
                  U_dirtyOnGpu = false;
                  U_dirtyOnCpu = true;
                  A_dirtyOnGpu = false;
                  A_dirtyOnCpu = true;
                  if ((int32_T)g_info_t < 0) {
                    for (i = 0; i < 2; i++) {
                      e_V[i] = A->size[i];
                    }

                    i = A->size[0] * A->size[1];
                    A->size[0] = e_V[0];
                    A->size[1] = e_V[1];
                    emxEnsureCapacity_real_T(A, i, &dc_emlrtRTEI);
                    m = e_V[0] * e_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(m + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, A);
                      ecc_detr_kernel40<<<grid, block>>>(m, b_gpu_A);
                      A_dirtyOnCpu = false;
                      A_dirtyOnGpu = true;
                    }

                    for (i = 0; i < 2; i++) {
                      e_V[i] = U->size[i];
                    }

                    i = U->size[0] * U->size[1];
                    U->size[0] = e_V[0];
                    U->size[1] = e_V[1];
                    emxEnsureCapacity_real_T(U, i, &ic_emlrtRTEI);
                    m = e_V[0] * e_V[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(m + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                      ecc_detr_kernel41<<<grid, block>>>(m, gpu_U);
                      U_dirtyOnCpu = false;
                      U_dirtyOnGpu = true;
                    }
                  }
                }

                n = A->size[0];
                i = D->size[0] * D->size[1];
                D->size[0] = A->size[0];
                D->size[1] = A->size[0];
                emxEnsureCapacity_creal_T(D, i, &ec_emlrtRTEI);
                if (!D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
                }

                x_dim0 = A->size[0] * A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
                  }

                  ecc_detr_kernel44<<<grid, block>>>(x_dim0, gpu_D);
                  D_dirtyOnCpu = false;
                  D_dirtyOnGpu = true;
                }

                i = 1;
                do {
                  exitg1 = 0;
                  if (i <= n) {
                    if (i != n) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (A->data[i + A->size[0] * (i - 1)] != 0.0) {
                        d2scaled = std::abs(A->data[i + A->size[0] * (i - 1)]);
                        if (D_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_creal_T(D, &gpu_D);
                        }

                        D->data[(i + D->size[0] * (i - 1)) - 1].re = 0.0;
                        D->data[(i + D->size[0] * (i - 1)) - 1].im = d2scaled;
                        D->data[i + D->size[0] * i].re = 0.0;
                        D->data[i + D->size[0] * i].im = -d2scaled;
                        D_dirtyOnGpu = false;
                        D_dirtyOnCpu = true;
                        i += 2;
                      } else {
                        i++;
                      }
                    } else {
                      i++;
                    }
                  } else {
                    exitg1 = 1;
                  }
                } while (exitg1 == 0);

                i = V->size[0] * V->size[1];
                V->size[0] = U->size[0];
                V->size[1] = U->size[1];
                emxEnsureCapacity_creal_T(V, i, &jc_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
                }

                m = U->size[0] * U->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (m + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (U_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, U);
                  }

                  U_dirtyOnCpu = false;
                  if (V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                  }

                  ecc_detr_kernel45<<<grid, block>>>(gpu_U, m, gpu_V);
                  V_dirtyOnCpu = false;
                  V_dirtyOnGpu = true;
                }

                minmana = 1;
                n = A->size[0];
                do {
                  exitg1 = 0;
                  if (minmana <= n) {
                    if (minmana != n) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(A, &b_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (A->data[minmana + A->size[0] * (minmana - 1)] != 0.0)
                      {
                        if (A->data[minmana + A->size[0] * (minmana - 1)] < 0.0)
                        {
                          inVectorLength = 1;
                        } else {
                          inVectorLength = -1;
                        }

                        for (i = 0; i < n; i++) {
                          if (V_dirtyOnGpu) {
                            gpuEmxMemcpyGpuToCpu_creal_T(V, &gpu_V);
                          }

                          d2scaled = V->data[i + V->size[0] * (minmana - 1)].re;
                          abnrm = static_cast<real_T>(inVectorLength) * V->
                            data[i + V->size[0] * minmana].re;
                          abnrm_dirtyOnGpu = false;
                          if (abnrm == 0.0) {
                            V->data[i + V->size[0] * (minmana - 1)].re =
                              d2scaled / 1.4142135623730951;
                            V->data[i + V->size[0] * (minmana - 1)].im = 0.0;
                          } else if (d2scaled == 0.0) {
                            V->data[i + V->size[0] * (minmana - 1)].re = 0.0;
                            V->data[i + V->size[0] * (minmana - 1)].im = abnrm /
                              1.4142135623730951;
                          } else {
                            V->data[i + V->size[0] * (minmana - 1)].re =
                              d2scaled / 1.4142135623730951;
                            V->data[i + V->size[0] * (minmana - 1)].im = abnrm /
                              1.4142135623730951;
                          }

                          V->data[i + V->size[0] * minmana].re = V->data[i +
                            V->size[0] * (minmana - 1)].re;
                          V->data[i + V->size[0] * minmana].im = -V->data[i +
                            V->size[0] * (minmana - 1)].im;
                          V_dirtyOnGpu = false;
                          V_dirtyOnCpu = true;
                        }

                        minmana += 2;
                      } else {
                        minmana++;
                      }
                    } else {
                      minmana++;
                    }
                  } else {
                    exitg1 = 1;
                  }
                } while (exitg1 == 0);
              } else {
                ptrdiff_t f_info_t;
                n = A->size[0];
                inVectorLength = A->size[1] - 1;
                i = scale->size[0];
                scale->size[0] = A->size[1];
                emxEnsureCapacity_real_T(scale, i, &hb_emlrtRTEI);
                i = W->size[0];
                W->size[0] = A->size[1];
                emxEnsureCapacity_creal_T(W, i, &kb_emlrtRTEI);
                gpuEmxEnsureCapacity_creal_T(W, &gpu_W);
                i = V->size[0] * V->size[1];
                V->size[0] = A->size[1];
                V->size[1] = A->size[1];
                emxEnsureCapacity_creal_T(V, i, &mb_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
                }

                i = wreal->size[0];
                wreal->size[0] = A->size[1];
                emxEnsureCapacity_real_T(wreal, i, &ob_emlrtRTEI);
                if (!wreal_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(wreal, &gpu_wreal);
                }

                i = wimag->size[0];
                wimag->size[0] = A->size[1];
                emxEnsureCapacity_real_T(wimag, i, &qb_emlrtRTEI);
                if (!wimag_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(wimag, &gpu_wimag);
                }

                i = vright->size[0] * vright->size[1];
                vright->size[0] = A->size[1];
                vright->size[1] = A->size[1];
                emxEnsureCapacity_real_T(vright, i, &rb_emlrtRTEI);
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
                  inVectorLength = A->size[1];
                  i = W->size[0];
                  W->size[0] = A->size[1];
                  emxEnsureCapacity_creal_T(W, i, &yb_emlrtRTEI);
                  gpuEmxEnsureCapacity_creal_T(W, &gpu_W);
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    ecc_detr_kernel33<<<grid, block>>>(gpu_dc, inVectorLength,
                      gpu_W);
                    W_dirtyOnGpu = true;
                  }

                  for (i = 0; i < 2; i++) {
                    e_V[i] = V->size[i];
                  }

                  i = V->size[0] * V->size[1];
                  V->size[0] = e_V[0];
                  V->size[1] = e_V[1];
                  emxEnsureCapacity_creal_T(V, i, &gc_emlrtRTEI);
                  if (!V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
                  }

                  m = e_V[0] * e_V[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (m + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                    }

                    ecc_detr_kernel34<<<grid, block>>>(gpu_dc, m, gpu_V);
                    V_dirtyOnCpu = false;
                    V_dirtyOnGpu = true;
                  }
                } else {
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_wimag, wimag);
                    wimag_dirtyOnCpu = false;
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_wreal, wreal);
                    wreal_dirtyOnCpu = false;
                    ecc_detr_kernel30<<<grid, block>>>(gpu_wimag, gpu_wreal,
                      inVectorLength, gpu_W);
                    W_dirtyOnGpu = true;
                  }

                  i = V->size[0] * V->size[1];
                  V->size[0] = vright->size[0];
                  V->size[1] = vright->size[1];
                  emxEnsureCapacity_creal_T(V, i, &cc_emlrtRTEI);
                  if (!V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(V, &gpu_V);
                  }

                  m = vright->size[0] * vright->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (m + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_vright, vright);
                    vright_dirtyOnCpu = false;
                    if (V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                    }

                    ecc_detr_kernel31<<<grid, block>>>(gpu_vright, m, gpu_V);
                    V_dirtyOnCpu = false;
                    V_dirtyOnGpu = true;
                  }

                  for (i = 0; i < inVectorLength; i++) {
                    if ((wimag->data[i] > 0.0) && (wimag->data[i + 1] < 0.0)) {
                      x_dim0 = V->size[0];
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(inVectorLength + 1L), &grid, &block,
                         1024U, 65535U);
                      if (validLaunchParams) {
                        cudaMemcpy(gpu_i, &i, 4UL, cudaMemcpyHostToDevice);
                        if (V_dirtyOnCpu) {
                          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
                        }

                        ecc_detr_kernel32<<<grid, block>>>(gpu_i, inVectorLength,
                          x_dim0, gpu_V);
                        V_dirtyOnCpu = false;
                        V_dirtyOnGpu = true;
                      }
                    }
                  }
                }

                i = D->size[0] * D->size[1];
                D->size[0] = A->size[0];
                D->size[1] = A->size[0];
                emxEnsureCapacity_creal_T(D, i, &hc_emlrtRTEI);
                if (!D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(D, &gpu_D);
                }

                x_dim0 = A->size[0] * A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (x_dim0 + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
                  }

                  ecc_detr_kernel35<<<grid, block>>>(x_dim0, gpu_D);
                  D_dirtyOnCpu = false;
                  D_dirtyOnGpu = true;
                }

                for (na = 0; na < n; na++) {
                  if (D_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal_T(D, &gpu_D);
                  }

                  if (W_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal_T(W, &gpu_W);
                  }

                  W_dirtyOnGpu = false;
                  D->data[na + D->size[0] * na] = W->data[na];
                  D_dirtyOnGpu = false;
                  D_dirtyOnCpu = true;
                }
              }
            }
          }
        }

        // 'ecc_detr:112' V = real(V);
        i = b_V->size[0] * b_V->size[1];
        b_V->size[0] = V->size[0];
        b_V->size[1] = V->size[1];
        emxEnsureCapacity_real_T(b_V, i, &bb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_V, &b_gpu_V);
        m = V->size[0] * V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (V_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, V);
          }

          V_dirtyOnCpu = false;
          ecc_detr_kernel60<<<grid, block>>>(gpu_V, m, b_gpu_V);
        }

        // 'ecc_detr:113' D = real(diag(D));
        if ((D->size[0] == 1) && (D->size[1] == 1)) {
          i = d->size[0];
          d->size[0] = 1;
          emxEnsureCapacity_creal_T(d, i, &eb_emlrtRTEI);
          if (!d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal_T(d, &gpu_d);
          }

          if (d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_creal_T(d, &gpu_d);
          }

          if (D_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_creal_T(D, &gpu_D);
          }

          D_dirtyOnGpu = false;
          d->data[0] = D->data[0];
          d_dirtyOnGpu = false;
          d_dirtyOnCpu = true;
        } else {
          n = D->size[0];
          inVectorLength = D->size[1];
          if (n <= inVectorLength) {
            inVectorLength = n;
          }

          if (D->size[1] <= 0) {
            inVectorLength = 0;
          }

          i = d->size[0];
          d->size[0] = inVectorLength;
          emxEnsureCapacity_creal_T(d, i, &db_emlrtRTEI);
          if (!d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal_T(d, &gpu_d);
          }

          m = D->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (D_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, D);
            }

            D_dirtyOnCpu = false;
            if (d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&gpu_d, d);
            }

            ecc_detr_kernel61<<<grid, block>>>(gpu_D, inVectorLength, m, gpu_d);
            d_dirtyOnCpu = false;
            d_dirtyOnGpu = true;
          }
        }

        i = b_D->size[0];
        b_D->size[0] = d->size[0];
        emxEnsureCapacity_real_T(b_D, i, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_D, &b_gpu_D);
        m = d->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal_T(&gpu_d, d);
          }

          d_dirtyOnCpu = false;
          ecc_detr_kernel62<<<grid, block>>>(gpu_d, m, b_gpu_D);
          b_D_dirtyOnGpu = true;
        }

        // 'ecc_detr:114' V = V(:,D/max(D)>thrPCA);
        vlen = b_D->size[0];
        if (b_D_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(b_D, &b_gpu_D);
        }

        b_D_dirtyOnGpu = false;
        d2scaled = b_D->data[0];
        for (i = 0; i <= vlen - 2; i++) {
          if (std::isnan(b_D->data[i + 1])) {
            olPct_dirtyOnCpu = false;
          } else if (std::isnan(d2scaled)) {
            olPct_dirtyOnCpu = true;
          } else {
            olPct_dirtyOnCpu = (d2scaled < b_D->data[i + 1]);
          }

          if (olPct_dirtyOnCpu) {
            d2scaled = b_D->data[i + 1];
          }
        }

        i = bv->size[0];
        bv->size[0] = b_D->size[0];
        emxEnsureCapacity_boolean_T(bv, i, &nb_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv, &gpu_bv);
        m = b_D->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
          ecc_detr_kernel63<<<grid, block>>>(b_gpu_D, m, gpu_d2scaled, gpu_bv);
          bv_dirtyOnGpu = true;
        }

        vlen = bv->size[0] - 1;
        inVectorLength = 0;
        for (i = 0; i <= vlen; i++) {
          if (bv_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv, &gpu_bv);
          }

          bv_dirtyOnGpu = false;
          if (bv->data[i]) {
            inVectorLength++;
          }
        }

        i = iv7->size[0];
        iv7->size[0] = inVectorLength;
        emxEnsureCapacity_int32_T(iv7, i, &sb_emlrtRTEI);
        if (!iv7_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(iv7, &gpu_iv7);
        }

        inVectorLength = 0;
        for (i = 0; i <= vlen; i++) {
          if (bv_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv, &gpu_bv);
          }

          bv_dirtyOnGpu = false;
          if (bv->data[i]) {
            iv7->data[inVectorLength] = i + 1;
            iv7_dirtyOnCpu = true;
            inVectorLength++;
          }
        }

        inVectorLength = b_V->size[0];
        i = d_V->size[0] * d_V->size[1];
        d_V->size[0] = b_V->size[0];
        d_V->size[1] = iv7->size[0];
        emxEnsureCapacity_real_T(d_V, i, &xb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_V, &d_gpu_V);
        m = iv7->size[0] - 1;
        x_dim0 = d_V->size[0];
        n = b_V->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (((inVectorLength - 1) + 1L) * (m + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv7_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv7, iv7);
          }

          iv7_dirtyOnCpu = false;
          ecc_detr_kernel64<<<grid, block>>>(gpu_iv7, b_gpu_V, inVectorLength, m,
            x_dim0, n, d_gpu_V);
        }

        i = b_V->size[0] * b_V->size[1];
        b_V->size[0] = d_V->size[0];
        b_V->size[1] = d_V->size[1];
        emxEnsureCapacity_real_T(b_V, i, &bc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_V, &b_gpu_V);
        m = d_V->size[0] * d_V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ecc_detr_kernel65<<<grid, block>>>(d_gpu_V, m, b_gpu_V);
        }

        //  discard weak dims
        // 'ecc_detr:115' rr = rr*V;
        inVectorLength = rr->size[0];
        vlen = rr->size[1];
        olPct_dirtyOnCpu = true;
        if ((rr->size[0] == 0) || (rr->size[1] == 0) || (b_V->size[0] == 0) ||
            (b_V->size[1] == 0)) {
          inVectorLength = rr->size[0];
          vlen = rr->size[0];
          n = b_V->size[1];
          i = rr->size[0] * rr->size[1];
          rr->size[0] = inVectorLength;
          rr->size[1] = b_V->size[1];
          emxEnsureCapacity_real_T(rr, i, &lc_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(rr, &gpu_rr);
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((vlen *
            n - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_vlen, &vlen, 4UL, cudaMemcpyHostToDevice);
            olPct_dirtyOnCpu = false;
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
            }

            ecc_detr_kernel67<<<grid, block>>>(gpu_vlen, n, gpu_rr);
            rr_dirtyOnCpu = false;
            rr_dirtyOnGpu = true;
          }
        } else {
          i = c_A->size[0] * c_A->size[1];
          c_A->size[0] = rr->size[0];
          c_A->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(c_A, i, &kc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_A, &c_gpu_A);
          n = rr->size[0] * rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
            }

            rr_dirtyOnCpu = false;
            ecc_detr_kernel66<<<grid, block>>>(gpu_rr, n, c_gpu_A);
          }

          i = rr->size[0] * rr->size[1];
          rr->size[0] = inVectorLength;
          rr->size[1] = b_V->size[1];
          emxEnsureCapacity_real_T(rr, i, &w_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(rr, &gpu_rr);
          }

          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      inVectorLength, b_V->size[1], vlen, (double *)&d2scaled,
                      (double *)&c_gpu_A.data[0], inVectorLength, (double *)
                      &b_gpu_V.data[0], vlen, (double *)&abnrm, (double *)
                      &gpu_rr.data[0], inVectorLength);
          rr_dirtyOnCpu = false;
          rr_dirtyOnGpu = true;
        }

        // 'ecc_detr:116' b = (x'*rr) / (rr'*rr);
        if (dv1->size[0] == dv2->size[0]) {
          i = d_A->size[0] * d_A->size[1];
          d_A->size[0] = 1;
          d_A->size[1] = dv1->size[0];
          emxEnsureCapacity_real_T(d_A, i, &v_emlrtRTEI);
          if (!b_A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(d_A, &d_gpu_A);
          }

          m = dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, d_A);
            }

            ecc_detr_kernel68<<<grid, block>>>(gpu_dv2, b_mn, gpu_dv1, m,
              d_gpu_A);
            b_A_dirtyOnCpu = false;
            b_A_dirtyOnGpu = true;
          }
        } else {
          if (b_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_A, &d_gpu_A);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          binary_expand_op(d_A, dv1, b_mn, dv2);
          b_A_dirtyOnGpu = false;
          b_A_dirtyOnCpu = true;
        }

        if ((d_A->size[1] == 0) || (rr->size[0] == 0) || (rr->size[1] == 0)) {
          i = b->size[0] * b->size[1];
          b->size[0] = 1;
          b->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(b, i, &x_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b, &gpu_b);
          }

          n = rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
            }

            ecc_detr_kernel69<<<grid, block>>>(n, gpu_b);
            b_dirtyOnCpu = false;
          }
        } else {
          i = b->size[0] * b->size[1];
          b->size[0] = 1;
          b->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(b, i, &w_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b, &gpu_b);
          }

          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          if (b_A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_A, d_A);
          }

          b_A_dirtyOnCpu = false;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          rr_dirtyOnCpu = false;
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                      rr->size[1], d_A->size[1], (double *)&d2scaled, (double *)
                      &d_gpu_A.data[0], 1, (double *)&gpu_rr.data[0], d_A->size
                      [1], (double *)&abnrm, (double *)&gpu_b.data[0], 1);
          b_dirtyOnCpu = false;
        }

        i = e_A->size[0] * e_A->size[1];
        e_A->size[0] = rr->size[1];
        e_A->size[1] = rr->size[0];
        emxEnsureCapacity_real_T(e_A, i, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_A, &e_gpu_A);
        n = rr->size[0] - 1;
        m = rr->size[1] - 1;
        inVectorLength = e_A->size[0];
        minmana = rr->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((m + 1L)
          * (n + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          rr_dirtyOnCpu = false;
          ecc_detr_kernel70<<<grid, block>>>(gpu_rr, m, n, inVectorLength,
            minmana, e_gpu_A);
        }

        if ((e_A->size[0] == 0) || (e_A->size[1] == 0) || (rr->size[0] == 0) ||
            (rr->size[1] == 0)) {
          i = f_A->size[0] * f_A->size[1];
          f_A->size[0] = e_A->size[0];
          f_A->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(f_A, i, &x_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_A, &f_gpu_A);
          x_dim0 = e_A->size[0] * rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detr_kernel71<<<grid, block>>>(x_dim0, f_gpu_A);
          }
        } else {
          i = f_A->size[0] * f_A->size[1];
          f_A->size[0] = e_A->size[0];
          f_A->size[1] = rr->size[1];
          emxEnsureCapacity_real_T(f_A, i, &w_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_A, &f_gpu_A);
          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, rr);
          }

          rr_dirtyOnCpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      e_A->size[0], rr->size[1], e_A->size[1], (double *)
                      &d2scaled, (double *)&e_gpu_A.data[0], e_A->size[0],
                      (double *)&gpu_rr.data[0], e_A->size[1], (double *)&abnrm,
                      (double *)&f_gpu_A.data[0], e_A->size[0]);
        }

        if ((b->size[1] == 0) || ((f_A->size[0] == 0) || (f_A->size[1] == 0))) {
          inVectorLength = f_A->size[0];
          if (sz_dirtyOnCpu) {
            cudaMemcpy(*gpu_sz, sz, 8UL, cudaMemcpyHostToDevice);
          }

          ecc_detr_kernel85<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (inVectorLength, *gpu_sz);
          sz_dirtyOnCpu = false;
          sz_dirtyOnGpu = true;
          i = b->size[0] * b->size[1];
          b->size[0] = 1;
          b->size[1] = f_A->size[0];
          emxEnsureCapacity_real_T(b, i, &oc_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b, &gpu_b);
          }

          ecc_detr_kernel86<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_sz,
            b_gpu_sz);
          cudaMemcpy(&b_sz, b_gpu_sz, 4UL, cudaMemcpyDeviceToHost);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_sz +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
            }

            ecc_detr_kernel87<<<grid, block>>>(b_gpu_sz, gpu_b);
            b_dirtyOnCpu = false;
          }
        } else if (f_A->size[0] == f_A->size[1]) {
          n = f_A->size[1];
          i = ipiv_t->size[0];
          ipiv_t->size[0] = f_A->size[1];
          emxEnsureCapacity_int32_T(ipiv_t, i, &mc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(ipiv_t, &gpu_ipiv_t);
          cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), f_A->size[1],
            f_A->size[1], (double *)&f_gpu_A.data[0], f_A->size[1],
            getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(8);
          cusolverInitWorkspace();
          if (olPct_dirtyOnCpu) {
            cudaMemcpy(gpu_vlen, &vlen, 4UL, cudaMemcpyHostToDevice);
          }

          cusolverDnDgetrf(getCuSolverGlobalHandle(), f_A->size[1], f_A->size[1],
                           (double *)&f_gpu_A.data[0], f_A->size[1],
                           static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                           &gpu_ipiv_t.data[0], gpu_vlen);
          i = ipiv->size[0] * ipiv->size[1];
          ipiv->size[0] = 1;
          ipiv->size[1] = ipiv_t->size[0];
          emxEnsureCapacity_int32_T(ipiv, i, &pc_emlrtRTEI);
          if (!ipiv_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(ipiv, &gpu_ipiv);
          }

          cudaMemcpy(&vlen, gpu_vlen, 4UL, cudaMemcpyDeviceToHost);
          if (vlen < 0) {
            for (i = 0; i < 2; i++) {
              e_V[i] = f_A->size[i];
            }

            i = f_A->size[0] * f_A->size[1];
            f_A->size[0] = e_V[0];
            f_A->size[1] = e_V[1];
            emxEnsureCapacity_real_T(f_A, i, &sc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(f_A, &f_gpu_A);
            m = e_V[0] * e_V[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_detr_kernel83<<<grid, block>>>(m, f_gpu_A);
            }

            inVectorLength = ipiv->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (ipiv_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_ipiv, ipiv);
              }

              ecc_detr_kernel84<<<grid, block>>>(inVectorLength, gpu_ipiv);
              ipiv_dirtyOnCpu = false;
              ipiv_dirtyOnGpu = true;
            }
          } else {
            inVectorLength = ipiv_t->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (ipiv_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_ipiv, ipiv);
              }

              ecc_detr_kernel82<<<grid, block>>>(gpu_ipiv_t, inVectorLength,
                gpu_ipiv);
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
                      1, n, (double *)&d2scaled, (double *)&f_gpu_A.data[0], n,
                      (double *)&gpu_b.data[0], 1);
          d2scaled = 1.0;
          cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                      n, (double *)&d2scaled, (double *)&f_gpu_A.data[0], n,
                      (double *)&gpu_b.data[0], 1);
          b_dirtyOnCpu = false;
          olPct_dirtyOnCpu = true;
          for (minmana = 0; minmana <= n - 2; minmana++) {
            inVectorLength = (n - minmana) - 2;
            if (ipiv_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(ipiv, &gpu_ipiv);
            }

            ipiv_dirtyOnGpu = false;
            if (ipiv->data[inVectorLength] != inVectorLength + 1) {
              if (olPct_dirtyOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b, &gpu_b);
              }

              d2scaled = b->data[inVectorLength];
              b->data[inVectorLength] = b->data[ipiv->data[inVectorLength] - 1];
              b->data[ipiv->data[inVectorLength] - 1] = d2scaled;
              ipiv_dirtyOnCpu = true;
              olPct_dirtyOnCpu = false;
              b_dirtyOnCpu = true;
            }
          }
        } else {
          ptrdiff_t h_info_t;
          boolean_T c_A_dirtyOnCpu;
          i = g_A->size[0] * g_A->size[1];
          g_A->size[0] = f_A->size[1];
          g_A->size[1] = f_A->size[0];
          emxEnsureCapacity_real_T(g_A, i, &nc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(g_A, &g_gpu_A);
          x_dim0 = f_A->size[0] - 1;
          m = f_A->size[1] - 1;
          inVectorLength = g_A->size[0];
          n = f_A->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((m +
            1L) * (x_dim0 + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detr_kernel72<<<grid, block>>>(f_gpu_A, m, x_dim0,
              inVectorLength, n, g_gpu_A);
            c_A_dirtyOnGpu = true;
          }

          i = B->size[0];
          B->size[0] = b->size[1];
          emxEnsureCapacity_real_T(B, i, &qc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(B, &gpu_B);
          m = b->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
            }

            b_dirtyOnCpu = false;
            ecc_detr_kernel73<<<grid, block>>>(gpu_b, m, gpu_B);
          }

          m = g_A->size[0];
          na = g_A->size[1] - 1;
          i = jpvt->size[0] * jpvt->size[1];
          jpvt->size[0] = 1;
          jpvt->size[1] = g_A->size[1];
          emxEnsureCapacity_int32_T(jpvt, i, &tc_emlrtRTEI);
          if (!jpvt_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(jpvt, &gpu_jpvt);
          }

          x_dim0 = g_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x_dim0
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, jpvt);
            }

            ecc_detr_kernel74<<<grid, block>>>(x_dim0, gpu_jpvt);
            jpvt_dirtyOnCpu = false;
            jpvt_dirtyOnGpu = true;
          }

          n = g_A->size[0];
          minmana = g_A->size[1];
          if (n <= minmana) {
            minmana = n;
          }

          i = c_tau->size[0];
          c_tau->size[0] = minmana;
          emxEnsureCapacity_real_T(c_tau, i, &uc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_tau, &c_gpu_tau);
          i = jpvt_t->size[0];
          jpvt_t->size[0] = g_A->size[1];
          emxEnsureCapacity_ptrdiff_t(jpvt_t, i, &vc_emlrtRTEI);
          for (i = 0; i < g_A->size[1]; i++) {
            jpvt_t->data[i] = (ptrdiff_t)0;
          }

          if (c_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(g_A, &g_gpu_A);
          }

          if (c_tau_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_tau, &c_gpu_tau);
          }

          h_info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)g_A->size[0], (ptrdiff_t)
            g_A->size[1], &g_A->data[0], (ptrdiff_t)g_A->size[0], &jpvt_t->data
            [0], &c_tau->data[0]);
          c_tau_dirtyOnGpu = false;
          olPct_dirtyOnCpu = true;
          c_A_dirtyOnGpu = false;
          c_A_dirtyOnCpu = true;
          if ((int32_T)h_info_t != 0) {
            inVectorLength = g_A->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((m
              - 1) + 1L) * (na + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_A, g_A);
              ecc_detr_kernel75<<<grid, block>>>(m, na, inVectorLength, g_gpu_A);
              c_A_dirtyOnCpu = false;
              c_A_dirtyOnGpu = true;
            }

            n = g_A->size[0];
            vlen = g_A->size[1];
            if (n <= vlen) {
              vlen = n;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((vlen - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_vlen, &vlen, 4UL, cudaMemcpyHostToDevice);
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_tau, c_tau);
              ecc_detr_kernel76<<<grid, block>>>(gpu_vlen, c_gpu_tau);
              olPct_dirtyOnCpu = false;
              c_tau_dirtyOnGpu = true;
            }

            if ((minmana - vlen) - 1 >= 0) {
              if (c_tau_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_tau, &c_gpu_tau);
              }

              std::memset(&c_tau->data[vlen], 0, static_cast<uint32_T>((minmana
                - (vlen + 1)) + 1) * sizeof(real_T));
              c_tau_dirtyOnGpu = false;
              olPct_dirtyOnCpu = true;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, jpvt);
              }

              ecc_detr_kernel77<<<grid, block>>>(na, gpu_jpvt);
              jpvt_dirtyOnCpu = false;
              jpvt_dirtyOnGpu = true;
            }
          } else {
            for (minmana = 0; minmana <= na; minmana++) {
              if (jpvt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(jpvt, &gpu_jpvt);
              }

              jpvt->data[minmana] = (int32_T)jpvt_t->data[minmana];
              jpvt_dirtyOnGpu = false;
              jpvt_dirtyOnCpu = true;
            }
          }

          na = 0;
          if (g_A->size[0] < g_A->size[1]) {
            vlen = g_A->size[0];
            inVectorLength = g_A->size[1];
          } else {
            vlen = g_A->size[1];
            inVectorLength = g_A->size[0];
          }

          if (c_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(g_A, &g_gpu_A);
          }

          c_A_dirtyOnGpu = false;
          d2scaled = std::fmin(1.4901161193847656E-8, 2.2204460492503131E-15 *
                               static_cast<real_T>(inVectorLength)) * std::abs
            (g_A->data[0]);
          while ((na < vlen) && (!(std::abs(g_A->data[na + g_A->size[0] * na]) <=
                   d2scaled))) {
            na++;
          }

          inVectorLength = g_A->size[1];
          i = Y->size[0];
          Y->size[0] = g_A->size[1];
          emxEnsureCapacity_real_T(Y, i, &ad_emlrtRTEI);
          if (!Y_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(Y, &gpu_Y);
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, Y);
            }

            ecc_detr_kernel78<<<grid, block>>>(inVectorLength, gpu_Y);
            Y_dirtyOnCpu = false;
            Y_dirtyOnGpu = true;
          }

          vlen = 0;
          n = g_A->size[0];
          inVectorLength = g_A->size[1];
          if (n <= inVectorLength) {
            inVectorLength = n;
          }

          if (c_A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_A, g_A);
          }

          if (olPct_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_tau, c_tau);
          }

          cusolverDnDormqr_bufferSize(getCuSolverGlobalHandle(),
            CUBLAS_SIDE_LEFT, CUBLAS_OP_T, B->size[0], 1, inVectorLength,
            (double *)&g_gpu_A.data[0], g_A->size[0], (double *)&c_gpu_tau.data
            [0], (double *)&gpu_B.data[0], B->size[0], getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(8);
          cusolverInitWorkspace();
          cudaMemcpy(gpu_vlen, &vlen, 4UL, cudaMemcpyHostToDevice);
          cusolverDnDormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                           CUBLAS_OP_T, B->size[0], 1, inVectorLength, (double *)
                           &g_gpu_A.data[0], g_A->size[0], (double *)
                           &c_gpu_tau.data[0], (double *)&gpu_B.data[0], B->
                           size[0], static_cast<real_T *>
                           (getCuSolverWorkspaceBuff()),
                           *getCuSolverWorkspaceReq(), gpu_vlen);
          cudaMemcpy(&vlen, gpu_vlen, 4UL, cudaMemcpyDeviceToHost);
          if (vlen < 0) {
            inVectorLength = B->size[0];
            i = B->size[0];
            B->size[0] = inVectorLength;
            emxEnsureCapacity_real_T(B, i, &ed_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(B, &gpu_B);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((inVectorLength - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ecc_detr_kernel79<<<grid, block>>>(inVectorLength, gpu_B);
            }
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((na -
            1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, jpvt);
            }

            jpvt_dirtyOnCpu = false;
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, Y);
            }

            ecc_detr_kernel80<<<grid, block>>>(gpu_B, gpu_jpvt, na, gpu_Y);
            Y_dirtyOnCpu = false;
            Y_dirtyOnGpu = true;
          }

          for (minmana = 0; minmana < na; minmana++) {
            inVectorLength = (na - minmana) - 1;
            if (Y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(Y, &gpu_Y);
            }

            if (jpvt_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(jpvt, &gpu_jpvt);
            }

            Y->data[jpvt->data[inVectorLength] - 1] /= g_A->data[inVectorLength
              + g_A->size[0] * inVectorLength];
            jpvt_dirtyOnGpu = false;
            jpvt_dirtyOnCpu = true;
            Y_dirtyOnGpu = false;
            Y_dirtyOnCpu = true;
            for (i = 0; i < inVectorLength; i++) {
              Y->data[jpvt->data[i] - 1] -= Y->data[jpvt->data[inVectorLength] -
                1] * g_A->data[i + g_A->size[0] * inVectorLength];
            }
          }

          i = b->size[0] * b->size[1];
          b->size[0] = 1;
          b->size[1] = Y->size[0];
          emxEnsureCapacity_real_T(b, i, &oc_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b, &gpu_b);
          }

          m = Y->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, Y);
            }

            Y_dirtyOnCpu = false;
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
            }

            ecc_detr_kernel81<<<grid, block>>>(gpu_Y, m, gpu_b);
            b_dirtyOnCpu = false;
          }
        }

        // 'ecc_detr:117' z = r*(V*b') + mn;
        i = b_B->size[0];
        b_B->size[0] = b->size[1];
        emxEnsureCapacity_real_T(b_B, i, &rc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_B, &b_gpu_B);
        m = b->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b);
          }

          b_dirtyOnCpu = false;
          ecc_detr_kernel88<<<grid, block>>>(gpu_b, m, b_gpu_B);
        }

        if ((b_V->size[0] == 0) || (b_V->size[1] == 0) || (b_B->size[0] == 0)) {
          i = b_y->size[0];
          b_y->size[0] = b_V->size[0];
          emxEnsureCapacity_real_T(b_y, i, &x_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_y, &b_gpu_y);
          m = b_V->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detr_kernel89<<<grid, block>>>(m, b_gpu_y);
          }
        } else {
          i = b_y->size[0];
          b_y->size[0] = b_V->size[0];
          emxEnsureCapacity_real_T(b_y, i, &w_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_y, &b_gpu_y);
          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      b_V->size[0], 1, b_V->size[1], (double *)&d2scaled,
                      (double *)&b_gpu_V.data[0], b_V->size[0], (double *)
                      &b_gpu_B.data[0], b_V->size[1], (double *)&abnrm, (double *)
                      &b_gpu_y.data[0], b_V->size[0]);
        }

        if ((r->size[0] == 0) || (r->size[1] == 0) || (b_y->size[0] == 0)) {
          i = dv8->size[0];
          dv8->size[0] = r->size[0];
          emxEnsureCapacity_real_T(dv8, i, &wc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(dv8, &gpu_dv8);
          m = r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ecc_detr_kernel90<<<grid, block>>>(m, gpu_dv8);
            dv8_dirtyOnGpu = true;
          }
        } else {
          i = dv8->size[0];
          dv8->size[0] = r->size[0];
          emxEnsureCapacity_real_T(dv8, i, &w_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(dv8, &gpu_dv8);
          d2scaled = 1.0;
          abnrm = 0.0;
          abnrm_dirtyOnGpu = false;
          if (r_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, r);
          }

          r_dirtyOnCpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, r->
                      size[0], 1, r->size[1], (double *)&d2scaled, (double *)
                      &gpu_r.data[0], r->size[0], (double *)&b_gpu_y.data[0],
                      r->size[1], (double *)&abnrm, (double *)&gpu_dv8.data[0],
                      r->size[0]);
          dv8_dirtyOnGpu = true;
        }

        if (dv8->size[0] == dv1->size[0]) {
          i = z->size[0];
          z->size[0] = dv8->size[0];
          emxEnsureCapacity_real_T(z, i, &xc_emlrtRTEI);
          if (!z_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(z, &gpu_z);
          }

          m = dv8->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, z);
            }

            ecc_detr_kernel91<<<grid, block>>>(mn, gpu_dv1, gpu_dv8, m, gpu_z);
            z_dirtyOnCpu = false;
            z_dirtyOnGpu = true;
          }
        } else {
          if (z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(z, &gpu_z);
          }

          if (dv8_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv8, &gpu_dv8);
          }

          dv8_dirtyOnGpu = false;
          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          binary_expand_op(z, dv8, dv1, mn);
          z_dirtyOnGpu = false;
          z_dirtyOnCpu = true;
        }

        //  Find outliers
        // 'ecc_detr:86' d = (x-z).*w;
        if (dv1->size[0] == 1) {
          m = z->size[0];
        } else {
          m = dv1->size[0];
        }

        if ((dv1->size[0] == z->size[0]) && (m == dv2->size[0])) {
          i = b_d->size[0];
          b_d->size[0] = dv1->size[0];
          emxEnsureCapacity_real_T(b_d, i, &yc_emlrtRTEI);
          if (!b_d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b_d, &b_gpu_d);
          }

          m = dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, z);
            }

            z_dirtyOnCpu = false;
            if (b_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, b_d);
            }

            ecc_detr_kernel92<<<grid, block>>>(gpu_dv2, gpu_z, gpu_dv1, m,
              b_gpu_d);
            b_d_dirtyOnCpu = false;
            b_d_dirtyOnGpu = true;
          }
        } else {
          if (b_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_d, &b_gpu_d);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(z, &gpu_z);
          }

          z_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          binary_expand_op(b_d, dv1, z, dv2);
          b_d_dirtyOnGpu = false;
          b_d_dirtyOnCpu = true;
        }

        // 'ecc_detr:87' thrItr = iThr*std(d);
        n = b_d->size[0] - 2;
        if (b_d->size[0] == 0) {
          abnrm = rtNaN;
        } else if (b_d->size[0] == 1) {
          if (b_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_d, &b_gpu_d);
          }

          b_d_dirtyOnGpu = false;
          if ((!std::isinf(b_d->data[0])) && (!std::isnan(b_d->data[0]))) {
            abnrm = 0.0;
          } else {
            abnrm = rtNaN;
          }
        } else {
          if (b_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_d, &b_gpu_d);
          }

          b_d_dirtyOnGpu = false;
          d2scaled = b_d->data[0];
          for (minmana = 0; minmana <= n; minmana++) {
            d2scaled += b_d->data[minmana + 1];
          }

          d2scaled /= static_cast<real_T>(b_d->size[0]);
          i = absdiff->size[0];
          absdiff->size[0] = b_d->size[0];
          emxEnsureCapacity_real_T(absdiff, i, &bd_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(absdiff, &gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((n + 1)
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, b_d);
            }

            b_d_dirtyOnCpu = false;
            cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
            ecc_detr_kernel93<<<grid, block>>>(b_gpu_d, n, gpu_d2scaled,
              gpu_absdiff);
          }

          if (abnrm_dirtyOnGpu) {
            cudaMemcpy(&abnrm, gpu_abnrm, 8UL, cudaMemcpyDeviceToHost);
          }

          cublasDnrm2(getCublasGlobalHandle(), b_d->size[0], (double *)
                      &gpu_absdiff.data[0], 1, (double *)&abnrm);
          abnrm /= std::sqrt(static_cast<real_T>(b_d->size[0]) - 1.0);
        }

        if (thr_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(b_thr, &b_gpu_thr);
        }

        thr_dirtyOnGpu = false;
        d2scaled = b_thr->data[ii] * abnrm;

        // 'ecc_detr:88' w(abs(d)>thrItr) = 0;
        inVectorLength = b_d->size[0] - 1;
        i = c_y->size[0];
        c_y->size[0] = b_d->size[0];
        emxEnsureCapacity_real_T(c_y, i, &cd_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_y, &c_gpu_y);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, b_d);
          }

          b_d_dirtyOnCpu = false;
          ecc_detr_kernel94<<<grid, block>>>(b_gpu_d, inVectorLength, c_gpu_y);
        }

        i = bv1->size[0];
        bv1->size[0] = c_y->size[0];
        emxEnsureCapacity_boolean_T(bv1, i, &dd_emlrtRTEI);
        gpuEmxEnsureCapacity_boolean_T(bv1, &gpu_bv1);
        m = c_y->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_d2scaled, &d2scaled, 8UL, cudaMemcpyHostToDevice);
          ecc_detr_kernel95<<<grid, block>>>(c_gpu_y, m, gpu_d2scaled, gpu_bv1);
          bv1_dirtyOnGpu = true;
        }

        vlen = bv1->size[0] - 1;
        inVectorLength = 0;
        for (i = 0; i <= vlen; i++) {
          if (bv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv1, &gpu_bv1);
          }

          bv1_dirtyOnGpu = false;
          if (bv1->data[i]) {
            inVectorLength++;
          }
        }

        i = iv10->size[0];
        iv10->size[0] = inVectorLength;
        emxEnsureCapacity_int32_T(iv10, i, &fd_emlrtRTEI);
        if (!iv10_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(iv10, &gpu_iv10);
        }

        inVectorLength = 0;
        for (i = 0; i <= vlen; i++) {
          if (bv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_boolean_T(bv1, &gpu_bv1);
          }

          bv1_dirtyOnGpu = false;
          if (bv1->data[i]) {
            iv10->data[inVectorLength] = i + 1;
            iv10_dirtyOnCpu = true;
            inVectorLength++;
          }
        }

        m = iv10->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv10_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv10, iv10);
          }

          iv10_dirtyOnCpu = false;
          ecc_detr_kernel96<<<grid, block>>>(gpu_iv10, m, gpu_dv2);
          dv2_dirtyOnGpu = true;
        }

        //  update weights
      }

      //  Remove trends
      // 'ecc_detr:92' x = x-z;
      i = x->size[0];
      if (i == z->size[0]) {
        inVectorLength = f_x->size[0];
        f_x->size[0] = i;
        emxEnsureCapacity_real_T(f_x, inVectorLength, &p_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_x, &b_gpu_x);
        m = x->size[0] - 1;
        x_dim0 = x->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (z_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, z);
          }

          z_dirtyOnCpu = false;
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
          }

          x_dirtyOnCpu = false;
          ecc_detr_kernel97<<<grid, block>>>(gpu_z, ch, gpu_x, m, x_dim0,
            b_gpu_x);
        }

        m = f_x->size[0] - 1;
        x_dim0 = x->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
          }

          ecc_detr_kernel98<<<grid, block>>>(b_gpu_x, ch, m, x_dim0, gpu_x);
          x_dirtyOnCpu = false;
          x_dirtyOnGpu = true;
        }
      } else {
        if (x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
        }

        if (z_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(z, &gpu_z);
        }

        z_dirtyOnGpu = false;
        binary_expand_op(x, ch, z);
        x_dirtyOnGpu = false;
        x_dirtyOnCpu = true;
      }

      m = dv2->size[0] - 1;
      n = w->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (w_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, w);
        }

        ecc_detr_kernel99<<<grid, block>>>(gpu_dv2, ch, m, n, gpu_w);
        w_dirtyOnCpu = false;
        w_dirtyOnGpu = true;
      }

      //  Detrend
      // 'ecc_detr:42' olPct(ch,ii) = sum(~w(:,ch));
      i = b_x->size[0];
      b_x->size[0] = w->size[0];
      emxEnsureCapacity_boolean_T(b_x, i, &q_emlrtRTEI);
      gpuEmxEnsureCapacity_boolean_T(b_x, &d_gpu_x);
      m = w->size[0] - 1;
      n = w->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (w_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, w);
        }

        w_dirtyOnCpu = false;
        ecc_detr_kernel100<<<grid, block>>>(ch, gpu_w, m, n, d_gpu_x);
        c_x_dirtyOnGpu = true;
      }

      vlen = b_x->size[0];
      if (b_x->size[0] == 0) {
        inVectorLength = 0;
      } else {
        if (c_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_boolean_T(b_x, &d_gpu_x);
        }

        c_x_dirtyOnGpu = false;
        inVectorLength = b_x->data[0];
        for (minmana = 0; minmana <= vlen - 2; minmana++) {
          inVectorLength += b_x->data[minmana + 1];
        }
      }

      b_olPct->data[ch + b_olPct->size[0] * ii] = inVectorLength;
      olPct_dirtyOnCpu = true;

      //  Outlier percentages
    }
  }

  emxFree_real_T(&d_V);
  emxFree_real_T(&f_x);
  emxFree_int32_T(&iv10);
  emxFree_boolean_T(&bv1);
  emxFree_real_T(&c_y);
  emxFree_real_T(&absdiff);
  emxFree_real_T(&b_d);
  emxFree_real_T(&dv8);
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_real_T(&b_y);
  emxFree_real_T(&c_tau);
  emxFree_int32_T(&ipiv_t);
  emxFree_int32_T(&jpvt);
  emxFree_real_T(&b_B);
  emxFree_int32_T(&ipiv);
  emxFree_real_T(&B);
  emxFree_real_T(&g_A);
  emxFree_real_T(&Y);
  emxFree_real_T(&f_A);
  emxFree_real_T(&b_wi);
  emxFree_real_T(&b_wr);
  emxFree_real_T(&e_A);
  emxFree_real_T(&b);
  emxFree_real_T(&wi);
  emxFree_real_T(&wr);
  emxFree_real_T(&vright);
  emxFree_real_T(&d_A);
  emxFree_real_T(&wimag);
  emxFree_real_T(&b_tau);
  emxFree_real_T(&wreal);
  emxFree_real_T(&c_A);
  emxFree_creal_T(&W);
  emxFree_real_T(&U);
  emxFree_real_T(&tau);
  emxFree_real_T(&scale);
  emxFree_real_T(&c_V);
  emxFree_int32_T(&iv7);
  emxFree_boolean_T(&bv);
  emxFree_real_T(&b_D);
  emxFree_creal_T(&d);
  emxFree_real_T(&b_V);
  emxFree_creal_T(&D);
  emxFree_creal_T(&V);
  emxFree_real_T(&b_A);
  emxFree_real_T(&A);
  emxFree_real_T(&rr);
  emxFree_real_T(&r);
  emxFree_real_T(&e_x);
  emxFree_real_T(&y);
  emxFree_real_T(&d_x);
  emxFree_real_T(&c_x);
  emxFree_boolean_T(&b_x);
  emxFree_real_T(&z);
  emxFree_real_T(&dv2);
  emxFree_real_T(&dv1);
  emxFree_real_T(&dv);
  emxFree_real_T(&lin);
  emxFree_real_T(&regs);
  emxFree_real_T(&b_itr);
  emxFree_real_T(&b_thr);
  emxFree_real_T(&b_ord);

  //  Sum outliers across chans
  // 'ecc_detr:47' olPct = sum(olPct,1,"omitnan");
  vlen = b_olPct->size[0];
  if ((b_olPct->size[0] == 0) || (b_olPct->size[1] == 0)) {
    for (i = 0; i < 2; i++) {
      if (sz_dirtyOnGpu) {
        cudaMemcpy(sz, *gpu_sz, 8UL, cudaMemcpyDeviceToHost);
      }

      sz[i] = static_cast<uint32_T>(b_olPct->size[i]);
      sz_dirtyOnGpu = false;
    }

    i = olPct->size[0] * olPct->size[1];
    olPct->size[0] = 1;
    if (sz_dirtyOnGpu) {
      cudaMemcpy(sz, *gpu_sz, 8UL, cudaMemcpyDeviceToHost);
    }

    olPct->size[1] = static_cast<int32_T>(sz[1]);
    emxEnsureCapacity_real_T(olPct, i, &i_emlrtRTEI);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
      static_cast<int32_T>(sz[1]) - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_olPct, olPct);
      ecc_detr_kernel102<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
        b_gpu_olPct);
      olPct_dirtyOnGpu = true;
    }
  } else {
    inVectorLength = b_olPct->size[1] - 1;
    i = olPct->size[0] * olPct->size[1];
    olPct->size[0] = 1;
    olPct->size[1] = b_olPct->size[1];
    emxEnsureCapacity_real_T(olPct, i, &h_emlrtRTEI);
    m = b_olPct->size[0];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (inVectorLength + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (olPct_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_olPct, b_olPct);
      }

      cudaMemcpy(gpu_vlen, &vlen, 4UL, cudaMemcpyHostToDevice);
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_olPct, olPct);
      ecc_detr_kernel101<<<grid, block>>>(gpu_olPct, inVectorLength, m, gpu_vlen,
        b_gpu_olPct);
      olPct_dirtyOnGpu = true;
    }
  }

  emxFree_int32_T(&b_olPct);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
  }

  if (w_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(w, &gpu_w);
  }

  if (olPct_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(olPct, &b_gpu_olPct);
  }

  mwCudaFree(gpu_dc);
  gpuEmxFree_real_T(&gpu_x);
  mwCudaFree(gpu_i);
  gpuEmxFree_real_T(&gpu_w);
  mwCudaFree(gpu_d2scaled);
  gpuEmxFree_real_T(&gpu_ord);
  gpuEmxFree_real_T(&b_gpu_ord);
  gpuEmxFree_real_T(&gpu_thr);
  gpuEmxFree_real_T(&b_gpu_thr);
  gpuEmxFree_real_T(&gpu_itr);
  gpuEmxFree_real_T(&b_gpu_itr);
  gpuEmxFree_real_T(&gpu_lin);
  gpuEmxFree_real_T(&gpu_dv);
  gpuEmxFree_real_T(&gpu_regs);
  gpuEmxFree_real_T(&gpu_dv1);
  gpuEmxFree_real_T(&gpu_dv2);
  gpuEmxFree_int32_T(&gpu_olPct);
  mwCudaFree(gpu_vlen);
  gpuEmxFree_real_T(&b_gpu_olPct);
  gpuEmxFree_real_T(&gpu_z);
  gpuEmxFree_real_T(&b_gpu_x);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_boolean_T(&d_gpu_x);
  gpuEmxFree_real_T(&e_gpu_x);
  gpuEmxFree_real_T(&f_gpu_x);
  gpuEmxFree_real_T(&gpu_y);
  mwCudaFree(gpu_abnrm);
  gpuEmxFree_real_T(&gpu_r);
  gpuEmxFree_real_T(&gpu_rr);
  gpuEmxFree_real_T(&gpu_A);
  gpuEmxFree_real_T(&b_gpu_A);
  gpuEmxFree_creal_T(&gpu_V);
  gpuEmxFree_real_T(&b_gpu_V);
  gpuEmxFree_creal_T(&gpu_D);
  gpuEmxFree_creal_T(&gpu_d);
  gpuEmxFree_real_T(&b_gpu_D);
  gpuEmxFree_real_T(&c_gpu_V);
  gpuEmxFree_real_T(&gpu_U);
  gpuEmxFree_boolean_T(&gpu_bv);
  gpuEmxFree_real_T(&gpu_tau);
  gpuEmxFree_real_T(&gpu_wimag);
  gpuEmxFree_real_T(&gpu_wreal);
  gpuEmxFree_creal_T(&gpu_W);
  gpuEmxFree_real_T(&b_gpu_tau);
  gpuEmxFree_real_T(&gpu_vright);
  gpuEmxFree_int32_T(&gpu_iv7);
  gpuEmxFree_real_T(&d_gpu_V);
  gpuEmxFree_real_T(&c_gpu_A);
  gpuEmxFree_real_T(&d_gpu_A);
  gpuEmxFree_real_T(&gpu_b);
  gpuEmxFree_real_T(&e_gpu_A);
  gpuEmxFree_real_T(&f_gpu_A);
  mwCudaFree(&(*gpu_sz)[0]);
  mwCudaFree(b_gpu_sz);
  gpuEmxFree_int32_T(&gpu_ipiv_t);
  gpuEmxFree_real_T(&g_gpu_A);
  gpuEmxFree_real_T(&gpu_B);
  gpuEmxFree_int32_T(&gpu_ipiv);
  gpuEmxFree_real_T(&b_gpu_B);
  gpuEmxFree_int32_T(&gpu_jpvt);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&gpu_dv8);
  gpuEmxFree_real_T(&c_gpu_tau);
  gpuEmxFree_real_T(&b_gpu_d);
  gpuEmxFree_real_T(&gpu_Y);
  gpuEmxFree_real_T(&gpu_absdiff);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_boolean_T(&gpu_bv1);
  gpuEmxFree_int32_T(&gpu_iv10);
}

void ecc_detr_api(const mxArray * const prhs[5], int32_T nlhs, const mxArray
                  *plhs[3])
{
  emxArray_real_T *itr;
  emxArray_real_T *olPct;
  emxArray_real_T *ord;
  emxArray_real_T *thr;
  emxArray_real_T *w;
  emxArray_real_T *x;
  const mxArray *prhs_copy_idx_0;
  const mxArray *prhs_copy_idx_1;
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
  emxInit_real_T(&ord, 2, &emlrtRTEI, true);
  ord->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[2]), "ord", ord);
  emxInit_real_T(&thr, 2, &emlrtRTEI, true);
  thr->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[3]), "thr", thr);
  emxInit_real_T(&itr, 2, &emlrtRTEI, true);
  itr->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[4]), "itr", itr);

  // Invoke the target function
  emxInit_real_T(&olPct, 2, &emlrtRTEI, true);
  ecc_detr(x, w, ord, thr, itr, olPct);

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
  if (nlhs > 2) {
    olPct->canFreeData = false;
    plhs[2] = emlrt_marshallOut(olPct);
  }

  emxFree_real_T(&olPct);
  emxFree_real_T(&ord);
  emxFree_real_T(&thr);
  emxFree_real_T(&itr);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ecc_detr_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  cusolverDestroyWorkspace();
  cusolverEnsureDestruction();
}

void ecc_detr_initialize()
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
    ecc_detr_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ecc_detr_terminate()
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

// End of code generation (ecc_detr.cu)
