//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr.cu
//
// Code generation for function 'ec_detr'
//

// Include files
#include "ec_detr.h"
#include "_coder_ec_detr_mex.h"
#include "ec_detr_types.h"
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
  131642U,                             // fVersionInfo
  nullptr,                             // fErrorFunction
  "ec_detr",                           // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 3130694236U, 2616137409U, 972914731U, 129233577U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtRTEInfo emlrtRTEI{ 1,      // lineNo
  1,                                   // colNo
  "_coder_ec_detr_api",                // fName
  ""                                   // pName
};

static emlrtRTEInfo b_emlrtRTEI{ 32,   // lineNo
  24,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 170,  // lineNo
  24,                                  // colNo
  "combineVectorElements",             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 58,   // lineNo
  23,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 49,   // lineNo
  20,                                  // colNo
  "linspace",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/linspace.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 41,   // lineNo
  41,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 41,   // lineNo
  49,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 80,   // lineNo
  20,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 92,   // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 42,   // lineNo
  28,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 124,  // lineNo
  10,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 108,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "sum",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/sum.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 109,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 110,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 44,   // lineNo
  36,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 158,  // lineNo
  24,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 94,   // lineNo
  5,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 56,   // lineNo
  24,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 60,   // lineNo
  28,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 112,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 85,   // lineNo
  9,                                   // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 109,  // lineNo
  24,                                  // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 100,  // lineNo
  5,                                   // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 47,   // lineNo
  20,                                  // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 99,  // lineNo
  24,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 89,  // lineNo
  13,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 102, // lineNo
  21,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 28,  // lineNo
  9,                                   // colNo
  "eigHermitianStandard",              // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/private/eigHermitianStandard.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 62,  // lineNo
  9,                                   // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 76,  // lineNo
  22,                                  // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 106, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 1,   // lineNo
  24,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 131, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 42,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 132, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 69,  // lineNo
  13,                                  // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 63,  // lineNo
  9,                                   // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 33,  // lineNo
  5,                                   // colNo
  "eigHermitianStandard",              // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/private/eigHermitianStandard.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 134, // lineNo
  35,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 114, // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 86,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 114, // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 46,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 111, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 87,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 160, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 112, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 168, // lineNo
  16,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 23,  // lineNo
  9,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 161, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 142, // lineNo
  41,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 129, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 27,  // lineNo
  13,                                  // colNo
  "eigStandard",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/private/eigStandard.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 115, // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 24,  // lineNo
  9,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 130, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 18,  // lineNo
  29,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 44,  // lineNo
  32,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 116, // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 50,  // lineNo
  31,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 44,  // lineNo
  35,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 44,  // lineNo
  48,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 53,  // lineNo
  13,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 61,  // lineNo
  9,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 92,  // lineNo
  22,                                  // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 105, // lineNo
  1,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 117, // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 83,  // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 86,  // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 85,  // lineNo
  1,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 126, // lineNo
  34,                                  // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 30,  // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 119, // lineNo
  5,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 1,   // lineNo
  15,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 37,  // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 59,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 80,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 108, // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo ed_emlrtRTEI{ 124, // lineNo
  6,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo fd_emlrtRTEI{ 83,  // lineNo
  22,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo gd_emlrtRTEI{ 111, // lineNo
  2,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo hd_emlrtRTEI{ 113, // lineNo
  10,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo id_emlrtRTEI{ 114, // lineNo
  9,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo jd_emlrtRTEI{ 99,  // lineNo
  1,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo kd_emlrtRTEI{ 131, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ld_emlrtRTEI{ 132, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo md_emlrtRTEI{ 134, // lineNo
  10,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo nd_emlrtRTEI{ 111, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo od_emlrtRTEI{ 44,  // lineNo
  9,                                   // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo pd_emlrtRTEI{ 112, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo qd_emlrtRTEI{ 18,  // lineNo
  5,                                   // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo rd_emlrtRTEI{ 117, // lineNo
  8,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo sd_emlrtRTEI{ 126, // lineNo
  9,                                   // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo td_emlrtRTEI{ 88,  // lineNo
  7,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

// Function Declarations
static void b_binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, real_T in4);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static real_T *b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, int32_T ret_size[2]);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, real_T in4);
static void binary_expand_op(emxArray_real_T *in1, int32_T in2, const
  emxArray_real_T *in3);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  real_T in3, const emxArray_real_T *in4);
static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static
#ifdef __CUDACC__

__device__
#endif

int64_T computeEndIdx_device(int64_T start, int64_T end, int64_T stride);
static __global__ void ec_detr_kernel1(creal_T *dc);
static __global__ void ec_detr_kernel10(const real_T itr_data[], int8_T
  outsize_idx_1, real_T out_data[99]);
static __global__ void ec_detr_kernel11(const real_T *d2scaled, int32_T npages,
  emxArray_real_T lin, int32_T lin_dim1);
static __global__ void ec_detr_kernel12(emxArray_real_T lin, int32_T lin_dim1);
static __global__ void ec_detr_kernel13(const emxArray_real_T lin, const int32_T
  k, int32_T *nx, emxArray_real_T regs, int32_T regs_dim0);
static __global__ void ec_detr_kernel14(const real_T out_data[99], const int32_T
  ii, int32_T *i5);
static __global__ void ec_detr_kernel15(const int32_T ch, const emxArray_real_T
  x, int32_T b_x, emxArray_real_T dv1, int32_T x_dim0);
static __global__ void ec_detr_kernel16(const int32_T ch, const emxArray_real_T
  w, int32_T b_w, emxArray_real_T dv2, int32_T w_dim0);
static __global__ void ec_detr_kernel17(const emxArray_real_T dv2, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T x);
static __global__ void ec_detr_kernel18(const emxArray_real_T dv2, const
  emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T x);
static __global__ void ec_detr_kernel19(const emxArray_real_T dv2, const real_T *
  d2scaled, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T dv3);
static __global__ void ec_detr_kernel2(const real_T ord_data[], int32_T
  inVectorLength, real_T out_data[99]);
static __global__ void ec_detr_kernel20(const emxArray_real_T dv2, const
  emxArray_real_T regs, const int32_T b_regs, int32_T c_regs, emxArray_real_T x,
  int32_T x_dim0, int32_T regs_dim0);
static __global__ void ec_detr_kernel21(const int32_T *nx, const emxArray_real_T
  x, int32_T npages, emxArray_real_T y, int32_T x_dim0);
static __global__ void ec_detr_kernel22(int32_T sz, emxArray_real_T y);
static __global__ void ec_detr_kernel23(const real_T *d2scaled, const
  emxArray_real_T y, const emxArray_real_T regs, const int32_T b_regs, int32_T
  c_regs, emxArray_real_T r, int32_T r_dim0, int32_T regs_dim0);
static __global__ void ec_detr_kernel24(const emxArray_real_T dv2, const
  emxArray_real_T r, const int32_T b_r, int32_T c_r, emxArray_real_T rr, int32_T
  rr_dim0, int32_T r_dim0);
static __global__ void ec_detr_kernel25(const emxArray_real_T rr, const int32_T
  b_rr, int32_T c_rr, emxArray_real_T A, int32_T A_dim0, int32_T rr_dim0);
static __global__ void ec_detr_kernel26(int32_T A, emxArray_real_T b_A);
static __global__ void ec_detr_kernel27(const emxArray_real_T wimag, const
  emxArray_real_T wreal, int32_T *nx, emxArray_creal_T W);
static __global__ void ec_detr_kernel28(const emxArray_real_T vright, int32_T
  b_vright, emxArray_creal_T V);
static __global__ void ec_detr_kernel29(const int32_T npages, int32_T *nx,
  emxArray_creal_T V, int32_T V_dim0);
static __global__ void ec_detr_kernel3(const real_T ord_data[], int32_T
  inVectorLength, real_T out_data[99]);
static __global__ void ec_detr_kernel30(const creal_T *dc, int32_T npages,
  emxArray_creal_T W);
static __global__ void ec_detr_kernel31(const creal_T *dc, int32_T dv2,
  emxArray_creal_T V);
static __global__ void ec_detr_kernel32(int32_T A, emxArray_creal_T D);
static __global__ void ec_detr_kernel33(int32_T dv2, emxArray_real_T A);
static __global__ void ec_detr_kernel34(int32_T npages, emxArray_real_T tau);
static __global__ void ec_detr_kernel35(const emxArray_real_T A, int32_T b_A,
  emxArray_real_T U);
static __global__ void ec_detr_kernel36(int32_T dv2, emxArray_real_T U);
static __global__ void ec_detr_kernel37(int32_T dv2, emxArray_real_T A);
static __global__ void ec_detr_kernel38(int32_T dv2, emxArray_real_T U);
static __global__ void ec_detr_kernel39(int32_T sz, emxArray_real_T U);
static __global__ void ec_detr_kernel4(const real_T ord_data[], int8_T
  outsize_idx_1, real_T out_data[99]);
static __global__ void ec_detr_kernel40(const int32_T n, const int32_T npages,
  int32_T m, emxArray_real_T U, int32_T U_dim0);
static __global__ void ec_detr_kernel41(int32_T sz, emxArray_real_T A);
static __global__ void ec_detr_kernel42(int32_T A, emxArray_creal_T D);
static __global__ void ec_detr_kernel43(const emxArray_real_T U, int32_T b_U,
  emxArray_creal_T V);
static __global__ void ec_detr_kernel44(int32_T npages, emxArray_real_T W);
static __global__ void ec_detr_kernel45(int32_T dv2, emxArray_real_T A);
static __global__ void ec_detr_kernel46(int32_T n, emxArray_creal_T D);
static __global__ void ec_detr_kernel47(const emxArray_real_T A, int32_T b_A,
  emxArray_creal_T V);
static __global__ void ec_detr_kernel48(const creal_T *dc, int32_T dv2,
  emxArray_creal_T V);
static __global__ void ec_detr_kernel49(int32_T dv2, emxArray_creal_T D);
static __global__ void ec_detr_kernel5(const real_T thr_data[], int32_T
  inVectorLength, real_T out_data[99]);
static __global__ void ec_detr_kernel50(const emxArray_creal_T V, int32_T b_V,
  emxArray_real_T c_V);
static __global__ void ec_detr_kernel51(const emxArray_creal_T D, int32_T npages,
  emxArray_creal_T d, int32_T D_dim0);
static __global__ void ec_detr_kernel52(const emxArray_int32_T iv, const
  emxArray_real_T V, const int32_T npages, int32_T b_iv, emxArray_real_T b_V,
  int32_T V_dim0, int32_T b_V_dim0);
static __global__ void ec_detr_kernel53(const emxArray_real_T V, int32_T b_V,
  emxArray_real_T c_V);
static __global__ void ec_detr_kernel54(const emxArray_real_T rr, int32_T b_rr,
  emxArray_real_T A);
static __global__ void ec_detr_kernel55(int32_T dv2, emxArray_real_T rr);
static __global__ void ec_detr_kernel56(const emxArray_real_T dv3, int32_T b_dv3,
  emxArray_real_T A);
static __global__ void ec_detr_kernel57(int32_T rr, emxArray_real_T b);
static __global__ void ec_detr_kernel58(const emxArray_real_T rr, const int32_T
  b_rr, int32_T c_rr, emxArray_real_T A, int32_T A_dim0, int32_T rr_dim0);
static __global__ void ec_detr_kernel59(int32_T A, emxArray_real_T b_A);
static __global__ void ec_detr_kernel6(const real_T thr_data[], int32_T
  inVectorLength, real_T out_data[99]);
static __global__ void ec_detr_kernel60(const emxArray_real_T A, const int32_T
  b_A, int32_T c_A, emxArray_real_T d_A, int32_T A_dim0, int32_T b_A_dim0);
static __global__ void ec_detr_kernel61(const emxArray_real_T b, int32_T b_b,
  emxArray_real_T B);
static __global__ void ec_detr_kernel62(int32_T A, emxArray_int32_T jpvt);
static __global__ void ec_detr_kernel63(const int32_T m, int32_T na,
  emxArray_real_T A, int32_T A_dim0);
static __global__ void ec_detr_kernel64(int32_T n, emxArray_real_T tau);
static __global__ void ec_detr_kernel65(const int32_T npages, int32_T *nx,
  emxArray_real_T tau);
static __global__ void ec_detr_kernel66(int32_T na, emxArray_int32_T jpvt);
static __global__ void ec_detr_kernel67(int32_T npages, emxArray_real_T Y);
static __global__ void ec_detr_kernel68(int32_T npages, emxArray_real_T B);
static __global__ void ec_detr_kernel69(const emxArray_real_T B, const
  emxArray_int32_T jpvt, int32_T m, emxArray_real_T Y);
static __global__ void ec_detr_kernel7(const real_T thr_data[], int8_T
  outsize_idx_1, real_T out_data[99]);
static __global__ void ec_detr_kernel70(const emxArray_real_T Y, int32_T b_Y,
  emxArray_real_T b);
static __global__ void ec_detr_kernel71(const emxArray_int32_T ipiv_t, int32_T
  npages, emxArray_int32_T ipiv);
static __global__ void ec_detr_kernel72(int32_T dv2, emxArray_real_T A);
static __global__ void ec_detr_kernel73(int32_T npages, emxArray_int32_T ipiv);
static __global__ void ec_detr_kernel74(int32_T sz, emxArray_real_T b);
static __global__ void ec_detr_kernel75(const emxArray_real_T b, int32_T b_b,
  emxArray_real_T B);
static __global__ void ec_detr_kernel76(int32_T V, emxArray_real_T y);
static __global__ void ec_detr_kernel77(int32_T r, emxArray_real_T dv7);
static __global__ void ec_detr_kernel78(const real_T mn, const emxArray_real_T
  dv1, const emxArray_real_T dv7, int32_T b_dv7, emxArray_real_T z);
static __global__ void ec_detr_kernel79(const emxArray_real_T dv2, const
  emxArray_real_T z, const emxArray_real_T dv1, int32_T b_dv1, emxArray_real_T d);
static __global__ void ec_detr_kernel8(const real_T itr_data[], int32_T
  inVectorLength, real_T out_data[99]);
static __global__ void ec_detr_kernel80(const real_T *d2scaled, const
  emxArray_real_T d, int32_T n, emxArray_real_T absdiff);
static __global__ void ec_detr_kernel81(real_T *d2scaled, int32_T d_dim0);
static __global__ void ec_detr_kernel82(const emxArray_real_T d, real_T
  *d2scaled);
static __global__ void ec_detr_kernel83(const real_T out_data[99], const int32_T
  ii, real_T *d2scaled);
static __global__ void ec_detr_kernel84(const emxArray_real_T d, int32_T *nx,
  emxArray_real_T y);
static __global__ void ec_detr_kernel85(const real_T *d2scaled, const
  emxArray_real_T y, int32_T n, emxArray_real_T dv2);
static __global__ void ec_detr_kernel86(const emxArray_real_T z, const int32_T
  ch, const emxArray_real_T x, int32_T b_x, emxArray_real_T c_x, int32_T x_dim0);
static __global__ void ec_detr_kernel87(const emxArray_real_T x, const int32_T
  ch, int32_T b_x, emxArray_real_T c_x, int32_T x_dim0);
static __global__ void ec_detr_kernel88(const emxArray_real_T dv2, const int32_T
  ch, int32_T b_dv2, emxArray_real_T w, int32_T w_dim0);
static __global__ void ec_detr_kernel89(const int32_T ch, const emxArray_real_T
  w, int32_T b_w, emxArray_boolean_T x, int32_T w_dim0);
static __global__ void ec_detr_kernel9(const real_T itr_data[], int32_T
  inVectorLength, real_T out_data[99]);
static __global__ void ec_detr_kernel90(const int32_T *nx, const
  emxArray_int32_T olPct, int32_T npages, real_T olPct_data[], int32_T
  olPct_dim0);
static __global__ void ec_detr_kernel91(int32_T sz, real_T olPct_data[]);
static void ec_detr_once();
static real_T *emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, int32_T y_size[2]);
static real_T *emlrt_marshallIn(const mxArray *ord, const char_T *identifier,
  int32_T y_size[2]);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallOut(const emxArray_real_T *u, const mxArray *y);
static const mxArray *emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[2]);
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

  emxEnsureCapacity_real_T(in1, i, &n_emlrtRTEI);
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
  static const int32_T dims[2]{ -1, 999 };

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

static real_T *b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, int32_T ret_size[2])
{
  static const int32_T dims[2]{ 1, 99 };

  real_T *ret_data;
  int32_T iv[2];
  boolean_T bv[2]{ true, true };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_data = static_cast<real_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret_data;
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
  emxEnsureCapacity_real_T(in1, i, &o_emlrtRTEI);
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

  emxEnsureCapacity_real_T(in1, i, &sc_emlrtRTEI);
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
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in4->size[0] == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in4->size[0];
  }

  emxEnsureCapacity_real_T(in1, i, &l_emlrtRTEI);
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

  emxEnsureCapacity_real_T(in1, i, &tc_emlrtRTEI);
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

static void binary_expand_op(emxArray_real_T *in1, int32_T in2, const
  emxArray_real_T *in3)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &i_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in3->size[0] == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in3->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &i_emlrtRTEI);
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

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel1(creal_T *dc)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    dc->re = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel10(const real_T
  itr_data[], int8_T outsize_idx_1, real_T out_data[99])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    out_data[i] = itr_data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel11(const real_T *
  d2scaled, int32_T npages, emxArray_real_T lin, int32_T lin_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real_T>((((k + 2) << 1) - lin_dim1) - 1) *
      *d2scaled;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel12(emxArray_real_T
  lin, int32_T lin_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[lin_dim1 >> 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel13(const
  emxArray_real_T lin, const int32_T k, int32_T *nx, emxArray_real_T regs,
  int32_T regs_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*nx) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_k;
    b_k = static_cast<int32_T>(idx);
    regs.data[b_k + regs_dim0 * k] = pow(lin.data[b_k], static_cast<real_T>(k) +
      1.0);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel14(const real_T
  out_data[99], const int32_T ii, int32_T *i5)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *i5 = static_cast<int32_T>(out_data[ii]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel15(const int32_T
  ch, const emxArray_real_T x, int32_T b_x, emxArray_real_T dv1, int32_T x_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel16(const int32_T
  ch, const emxArray_real_T w, int32_T b_w, emxArray_real_T dv2, int32_T w_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel17(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel18(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel19(const
  emxArray_real_T dv2, const real_T *d2scaled, const emxArray_real_T dv1,
  int32_T b_dv1, emxArray_real_T dv3)
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
    dv3.data[i] = (dv1.data[i] - *d2scaled) * dv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel2(const real_T
  ord_data[], int32_T inVectorLength, real_T out_data[99])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    out_data[i] = ord_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel20(const
  emxArray_real_T dv2, const emxArray_real_T regs, const int32_T b_regs, int32_T
  c_regs, emxArray_real_T x, int32_T x_dim0, int32_T regs_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel21(const int32_T
  *nx, const emxArray_real_T x, int32_T npages, emxArray_real_T y, int32_T
  x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx);
    xpageoffset = i * x_dim0;
    y.data[i] = x.data[xpageoffset];
    for (int32_T k{0}; k <= *nx - 2; k++) {
      y.data[i] += x.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel22(int32_T sz,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel23(const real_T *
  d2scaled, const emxArray_real_T y, const emxArray_real_T regs, const int32_T
  b_regs, int32_T c_regs, emxArray_real_T r, int32_T r_dim0, int32_T regs_dim0)
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
      y.data[i] / *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel24(const
  emxArray_real_T dv2, const emxArray_real_T r, const int32_T b_r, int32_T c_r,
  emxArray_real_T rr, int32_T rr_dim0, int32_T r_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel25(const
  emxArray_real_T rr, const int32_T b_rr, int32_T c_rr, emxArray_real_T A,
  int32_T A_dim0, int32_T rr_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel26(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel27(const
  emxArray_real_T wimag, const emxArray_real_T wreal, int32_T *nx,
  emxArray_creal_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i].re = wreal.data[i];
    W.data[i].im = wimag.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel28(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel29(const int32_T
  npages, int32_T *nx, emxArray_creal_T V, int32_T V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    d = V.data[xpageoffset + V_dim0 * (npages - 1)].re;
    V.data[xpageoffset + V_dim0 * (npages - 2)].im = d;
    V.data[xpageoffset + V_dim0 * (npages - 1)].re = V.data[xpageoffset + V_dim0
      * (npages - 2)].re;
    V.data[xpageoffset + V_dim0 * (npages - 1)].im = -V.data[xpageoffset +
      V_dim0 * (npages - 2)].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel3(const real_T
  ord_data[], int32_T inVectorLength, real_T out_data[99])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    out_data[i] = ord_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel30(const creal_T
  *dc, int32_T npages, emxArray_creal_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel31(const creal_T
  *dc, int32_T dv2, emxArray_creal_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel32(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel33(int32_T dv2,
  emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel34(int32_T
  npages, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel35(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel36(int32_T dv2,
  emxArray_real_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel37(int32_T dv2,
  emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel38(int32_T dv2,
  emxArray_real_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel39(int32_T sz,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel4(const real_T
  ord_data[], int8_T outsize_idx_1, real_T out_data[99])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    out_data[i] = ord_data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel40(const int32_T
  n, const int32_T npages, int32_T m, emxArray_real_T U, int32_T U_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>
    (npages), static_cast<int64_T>(m), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    U.data[(static_cast<int32_T>(static_cast<int64_T>(npages) + i) + U_dim0 * (n
             - 1)) - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel41(int32_T sz,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel42(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel43(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel44(int32_T
  npages, emxArray_real_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel45(int32_T dv2,
  emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel46(int32_T n,
  emxArray_creal_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n * n) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel47(const
  emxArray_real_T A, int32_T b_A, emxArray_creal_T V)
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
    V.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel48(const creal_T
  *dc, int32_T dv2, emxArray_creal_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i] = *dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel49(int32_T dv2,
  emxArray_creal_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel5(const real_T
  thr_data[], int32_T inVectorLength, real_T out_data[99])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    out_data[i] = thr_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel50(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel51(const
  emxArray_creal_T D, int32_T npages, emxArray_creal_T d, int32_T D_dim0)
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
    d.data[k] = D.data[k + D_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel52(const
  emxArray_int32_T iv, const emxArray_real_T V, const int32_T npages, int32_T
  b_iv, emxArray_real_T b_V, int32_T V_dim0, int32_T b_V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages) * (static_cast<uint64_T>(b_iv) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % static_cast<uint64_T>(npages));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) /
      static_cast<uint64_T>(npages));
    b_V.data[xpageoffset + V_dim0 * i] = V.data[xpageoffset + b_V_dim0 *
      iv.data[i]];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel53(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel54(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel55(int32_T dv2,
  emxArray_real_T rr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    rr.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel56(const
  emxArray_real_T dv3, int32_T b_dv3, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv3);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = dv3.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel57(int32_T rr,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel58(const
  emxArray_real_T rr, const int32_T b_rr, int32_T c_rr, emxArray_real_T A,
  int32_T A_dim0, int32_T rr_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel59(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel6(const real_T
  thr_data[], int32_T inVectorLength, real_T out_data[99])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    out_data[i] = thr_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel60(const
  emxArray_real_T A, const int32_T b_A, int32_T c_A, emxArray_real_T d_A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel61(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel62(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel63(const int32_T
  m, int32_T na, emxArray_real_T A, int32_T A_dim0)
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
    A.data[xpageoffset * A_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel64(int32_T n,
  emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    tau.data[k] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel65(const int32_T
  npages, int32_T *nx, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>
    (npages), static_cast<int64_T>(*nx), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    tau.data[static_cast<int32_T>(static_cast<int64_T>(npages) + i) - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel66(int32_T na,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel67(int32_T
  npages, emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel68(int32_T
  npages, emxArray_real_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel69(const
  emxArray_real_T B, const emxArray_int32_T jpvt, int32_T m, emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(m);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[jpvt.data[i] - 1] = B.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel7(const real_T
  thr_data[], int8_T outsize_idx_1, real_T out_data[99])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outsize_idx_1) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    out_data[i] = thr_data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel70(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel71(const
  emxArray_int32_T ipiv_t, int32_T npages, emxArray_int32_T ipiv)
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
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel72(int32_T dv2,
  emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel73(int32_T
  npages, emxArray_int32_T ipiv)
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
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel74(int32_T sz,
  emxArray_real_T b)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel75(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel76(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel77(int32_T r,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel78(const real_T
  mn, const emxArray_real_T dv1, const emxArray_real_T dv7, int32_T b_dv7,
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
    z.data[i] = dv7.data[i] + (dv1.data[i] - (dv1.data[i] - mn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel79(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel8(const real_T
  itr_data[], int32_T inVectorLength, real_T out_data[99])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    out_data[i] = itr_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel80(const real_T *
  d2scaled, const emxArray_real_T d, int32_T n, emxArray_real_T absdiff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabs(d.data[k] - *d2scaled);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel81(real_T
  *d2scaled, int32_T d_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *d2scaled /= sqrt(static_cast<real_T>(d_dim0) - 1.0);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel82(const
  emxArray_real_T d, real_T *d2scaled)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    if ((static_cast<boolean_T>(!static_cast<int32_T>(isinf(d.data[0])))) && (
         static_cast<boolean_T>(!static_cast<int32_T>(isnan(d.data[0]))))) {
      *d2scaled = 0.0;
    } else {
      *d2scaled = CUDART_NAN;
    }
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel83(const real_T
  out_data[99], const int32_T ii, real_T *d2scaled)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *d2scaled *= out_data[ii];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel84(const
  emxArray_real_T d, int32_T *nx, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*nx) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = fabs(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel85(const real_T *
  d2scaled, const emxArray_real_T y, int32_T n, emxArray_real_T dv2)
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
    if (y.data[i] > *d2scaled) {
      dv2.data[i] = 0.0;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel86(const
  emxArray_real_T z, const int32_T ch, const emxArray_real_T x, int32_T b_x,
  emxArray_real_T c_x, int32_T x_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel87(const
  emxArray_real_T x, const int32_T ch, int32_T b_x, emxArray_real_T c_x, int32_T
  x_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel88(const
  emxArray_real_T dv2, const int32_T ch, int32_T b_dv2, emxArray_real_T w,
  int32_T w_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel89(const int32_T
  ch, const emxArray_real_T w, int32_T b_w, emxArray_boolean_T x, int32_T w_dim0)
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
    x.data[i] = static_cast<boolean_T>(!static_cast<int32_T>(w.data[i + w_dim0 *
      ch] != 0.0));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel9(const real_T
  itr_data[], int32_T inVectorLength, real_T out_data[99])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(inVectorLength) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    out_data[i] = itr_data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel90(const int32_T
  *nx, const emxArray_int32_T olPct, int32_T npages, real_T olPct_data[],
  int32_T olPct_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx);
    xpageoffset = i * olPct_dim0;
    olPct_data[i] = static_cast<real_T>(olPct.data[xpageoffset]);
    for (int32_T k{0}; k <= *nx - 2; k++) {
      olPct_data[i] += static_cast<real_T>(olPct.data[(xpageoffset + k) + 1]);
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel91(int32_T sz,
  real_T olPct_data[])
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
    olPct_data[i] = 0.0;
  }
}

static void ec_detr_once()
{
  mwMemoryManagerInit(256U, 2U, 8U, 2048U);
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

static real_T *emlrt_marshallIn(const mxArray *ord, const char_T *identifier,
  int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  real_T *y_data;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y_data = emlrt_marshallIn(emlrtAlias(ord), &thisId, y_size);
  emlrtDestroyArray(&ord);
  return y_data;
}

static real_T *emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, int32_T y_size[2])
{
  real_T *y_data;
  y_data = b_emlrt_marshallIn(emlrtAlias(u), parentId, y_size);
  emlrtDestroyArray(&u);
  return y_data;
}

static const mxArray *emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[2])
{
  static const int32_T iv[2]{ 0, 0 };

  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u_data[0]);
  emlrtSetDimensions((mxArray *)m, &u_size[0], 2);
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
    mwCudaMalloc(&gpu->data, static_cast<uint32_T>(gpu->allocatedSize) * sizeof
                 (creal_T));
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
    mwCudaMalloc(&gpu->data, static_cast<uint32_T>(gpu->allocatedSize) * sizeof
                 (int32_T));
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
    mwCudaMalloc(&gpu->data, static_cast<uint32_T>(gpu->allocatedSize) * sizeof
                 (real_T));
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

  emxEnsureCapacity_real_T(in1, i, &k_emlrtRTEI);
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
// function [x,w,olPct] = ec_detr(x,w,ord,thr,itr)
void ec_detr(emxArray_real_T *cpu_x, emxArray_real_T *cpu_w, const real_T
             cpu_ord_data[], const int32_T ord_size[2], const real_T
             cpu_thr_data[], const int32_T thr_size[2], const real_T
             cpu_itr_data[], const int32_T itr_size[2], real_T cpu_olPct_data[],
             int32_T olPct_size[2])
{
  static creal_T cpu_dc{ 0.0,          // re
    0.0                                // im
  };

  ptrdiff_t ihi_t;
  ptrdiff_t ilo_t;
  dim3 block;
  dim3 grid;
  emxArray_boolean_T f_gpu_x;
  emxArray_boolean_T *b_cpu_x;
  emxArray_creal_T b_gpu_W;
  emxArray_creal_T b_gpu_d;
  emxArray_creal_T gpu_D;
  emxArray_creal_T gpu_V;
  emxArray_creal_T *b_cpu_W;
  emxArray_creal_T *cpu_D;
  emxArray_creal_T *cpu_V;
  emxArray_creal_T *cpu_d;
  emxArray_int32_T gpu_ipiv;
  emxArray_int32_T gpu_ipiv_t;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_jpvt;
  emxArray_int32_T gpu_olPct;
  emxArray_int32_T *cpu_ipiv;
  emxArray_int32_T *cpu_ipiv_t;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_jpvt;
  emxArray_int32_T *cpu_olPct;
  emxArray_ptrdiff_t *jpvt_t;
  emxArray_real_T b_gpu_A;
  emxArray_real_T b_gpu_B;
  emxArray_real_T b_gpu_V;
  emxArray_real_T b_gpu_tau;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_A;
  emxArray_real_T c_gpu_V;
  emxArray_real_T c_gpu_x;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_A;
  emxArray_real_T d_gpu_x;
  emxArray_real_T e_gpu_A;
  emxArray_real_T e_gpu_x;
  emxArray_real_T f_gpu_A;
  emxArray_real_T g_gpu_A;
  emxArray_real_T gpu_A;
  emxArray_real_T gpu_B;
  emxArray_real_T gpu_U;
  emxArray_real_T gpu_W;
  emxArray_real_T gpu_Y;
  emxArray_real_T gpu_absdiff;
  emxArray_real_T gpu_b;
  emxArray_real_T gpu_d;
  emxArray_real_T gpu_dv1;
  emxArray_real_T gpu_dv2;
  emxArray_real_T gpu_dv3;
  emxArray_real_T gpu_dv7;
  emxArray_real_T gpu_lin;
  emxArray_real_T gpu_r;
  emxArray_real_T gpu_regs;
  emxArray_real_T gpu_rr;
  emxArray_real_T gpu_tau;
  emxArray_real_T gpu_vright;
  emxArray_real_T gpu_w;
  emxArray_real_T gpu_wimag;
  emxArray_real_T gpu_wreal;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_z;
  emxArray_real_T *b_cpu_A;
  emxArray_real_T *b_cpu_B;
  emxArray_real_T *b_cpu_V;
  emxArray_real_T *b_cpu_d;
  emxArray_real_T *b_cpu_tau;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_A;
  emxArray_real_T *c_cpu_V;
  emxArray_real_T *c_cpu_x;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_A;
  emxArray_real_T *cpu_B;
  emxArray_real_T *cpu_U;
  emxArray_real_T *cpu_W;
  emxArray_real_T *cpu_Y;
  emxArray_real_T *cpu_absdiff;
  emxArray_real_T *cpu_b;
  emxArray_real_T *cpu_dv1;
  emxArray_real_T *cpu_dv2;
  emxArray_real_T *cpu_dv3;
  emxArray_real_T *cpu_dv7;
  emxArray_real_T *cpu_lin;
  emxArray_real_T *cpu_r;
  emxArray_real_T *cpu_regs;
  emxArray_real_T *cpu_rr;
  emxArray_real_T *cpu_tau;
  emxArray_real_T *cpu_vright;
  emxArray_real_T *cpu_wimag;
  emxArray_real_T *cpu_wreal;
  emxArray_real_T *cpu_y;
  emxArray_real_T *cpu_z;
  emxArray_real_T *d_cpu_A;
  emxArray_real_T *d_cpu_x;
  emxArray_real_T *e_cpu_A;
  emxArray_real_T *e_cpu_x;
  emxArray_real_T *f_cpu_A;
  emxArray_real_T *f_cpu_x;
  emxArray_real_T *g_cpu_A;
  emxArray_real_T *scale;
  emxArray_real_T *wi;
  emxArray_real_T *wr;
  creal_T *gpu_dc;
  real_T cpu_out_data[99];
  real_T (*b_gpu_out_data)[99];
  real_T (*c_gpu_out_data)[99];
  real_T (*gpu_out_data)[99];
  real_T abnrm;
  real_T cpu_d2scaled;
  real_T rconde;
  real_T rcondv;
  real_T *gpu_d2scaled;
  real_T *gpu_itr_data;
  real_T *gpu_olPct_data;
  real_T *gpu_ord_data;
  real_T *gpu_thr_data;
  int32_T dv2[2];
  int32_T b_inVectorLength;
  int32_T cpu_i5;
  int32_T cpu_info;
  int32_T cpu_nx;
  int32_T inVectorLength;
  int32_T k;
  int32_T nFrames;
  int32_T npages;
  int32_T *gpu_i5;
  int32_T *gpu_info;
  int32_T *gpu_nx;
  uint32_T b_sz[2];
  int16_T sz[2];
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
  boolean_T b_A_dirtyOnGpu;
  boolean_T b_W_dirtyOnGpu;
  boolean_T b_d_dirtyOnCpu;
  boolean_T b_d_dirtyOnGpu;
  boolean_T b_dirtyOnCpu;
  boolean_T b_tau_dirtyOnGpu;
  boolean_T b_x_dirtyOnCpu;
  boolean_T b_x_dirtyOnGpu;
  boolean_T c_x_dirtyOnCpu;
  boolean_T c_x_dirtyOnGpu;
  boolean_T d_dirtyOnCpu;
  boolean_T d_dirtyOnGpu;
  boolean_T d_x_dirtyOnCpu;
  boolean_T d_x_dirtyOnGpu;
  boolean_T dc_dirtyOnGpu;
  boolean_T dv1_dirtyOnGpu;
  boolean_T dv2_dirtyOnGpu;
  boolean_T dv3_dirtyOnCpu;
  boolean_T dv3_dirtyOnGpu;
  boolean_T dv7_dirtyOnGpu;
  boolean_T e_x_dirtyOnGpu;
  boolean_T i5_dirtyOnGpu;
  boolean_T ipiv_dirtyOnGpu;
  boolean_T iv_dirtyOnCpu;
  boolean_T jpvt_dirtyOnCpu;
  boolean_T jpvt_dirtyOnGpu;
  boolean_T lin_dirtyOnCpu;
  boolean_T lin_dirtyOnGpu;
  boolean_T olPct_data_dirtyOnGpu;
  boolean_T olPct_dirtyOnCpu;
  boolean_T out_data_dirtyOnGpu;
  boolean_T r_dirtyOnCpu;
  boolean_T r_dirtyOnGpu;
  boolean_T regs_dirtyOnGpu;
  boolean_T rr_dirtyOnCpu;
  boolean_T rr_dirtyOnGpu;
  boolean_T tau_dirtyOnCpu;
  boolean_T tau_dirtyOnGpu;
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
  mwCudaMalloc(&gpu_info, 4UL);
  mwCudaMalloc(&gpu_i5, 4UL);
  mwCudaMalloc(&gpu_nx, 4UL);
  mwCudaMalloc(&gpu_d2scaled, 8UL);
  gpuEmxReset_real_T(&c_gpu_V);
  gpuEmxReset_real_T(&e_gpu_x);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_real_T(&gpu_absdiff);
  gpuEmxReset_real_T(&gpu_d);
  gpuEmxReset_real_T(&gpu_dv7);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_real_T(&gpu_tau);
  gpuEmxReset_int32_T(&gpu_ipiv_t);
  gpuEmxReset_int32_T(&gpu_jpvt);
  gpuEmxReset_real_T(&gpu_B);
  gpuEmxReset_int32_T(&gpu_ipiv);
  gpuEmxReset_real_T(&b_gpu_B);
  gpuEmxReset_real_T(&f_gpu_A);
  gpuEmxReset_real_T(&gpu_Y);
  gpuEmxReset_real_T(&e_gpu_A);
  gpuEmxReset_real_T(&gpu_vright);
  gpuEmxReset_real_T(&gpu_wimag);
  gpuEmxReset_real_T(&d_gpu_A);
  gpuEmxReset_real_T(&b_gpu_tau);
  gpuEmxReset_real_T(&gpu_wreal);
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_creal_T(&b_gpu_W);
  gpuEmxReset_real_T(&gpu_U);
  gpuEmxReset_real_T(&c_gpu_A);
  gpuEmxReset_real_T(&g_gpu_A);
  gpuEmxReset_real_T(&gpu_W);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_creal_T(&b_gpu_d);
  gpuEmxReset_real_T(&b_gpu_V);
  gpuEmxReset_creal_T(&gpu_D);
  gpuEmxReset_creal_T(&gpu_V);
  gpuEmxReset_real_T(&gpu_A);
  gpuEmxReset_real_T(&b_gpu_A);
  gpuEmxReset_real_T(&gpu_rr);
  gpuEmxReset_real_T(&gpu_r);
  gpuEmxReset_real_T(&d_gpu_x);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_dv3);
  gpuEmxReset_real_T(&c_gpu_x);
  gpuEmxReset_real_T(&b_gpu_x);
  gpuEmxReset_boolean_T(&f_gpu_x);
  gpuEmxReset_real_T(&gpu_z);
  gpuEmxReset_real_T(&gpu_dv2);
  gpuEmxReset_real_T(&gpu_dv1);
  gpuEmxReset_real_T(&gpu_lin);
  gpuEmxReset_real_T(&gpu_regs);
  gpuEmxReset_int32_T(&gpu_olPct);
  mwCudaMalloc(&c_gpu_out_data, 792UL);
  mwCudaMalloc(&b_gpu_out_data, 792UL);
  mwCudaMalloc(&gpu_out_data, 792UL);
  mwCudaMalloc(&gpu_dc, 16UL);
  mwCudaMalloc(&gpu_olPct_data, 99U * sizeof(real_T));
  mwCudaMalloc(&gpu_itr_data, 99U * sizeof(real_T));
  mwCudaMalloc(&gpu_thr_data, 99U * sizeof(real_T));
  mwCudaMalloc(&gpu_ord_data, 99U * sizeof(real_T));
  gpuEmxReset_real_T(&gpu_w);
  gpuEmxReset_real_T(&gpu_x);
  i5_dirtyOnGpu = false;
  b_d_dirtyOnGpu = false;
  b_d_dirtyOnCpu = false;
  dv7_dirtyOnGpu = false;
  b_tau_dirtyOnGpu = false;
  jpvt_dirtyOnGpu = false;
  jpvt_dirtyOnCpu = false;
  ipiv_dirtyOnGpu = false;
  b_A_dirtyOnGpu = false;
  Y_dirtyOnGpu = false;
  Y_dirtyOnCpu = false;
  vright_dirtyOnCpu = false;
  wimag_dirtyOnCpu = false;
  tau_dirtyOnGpu = false;
  tau_dirtyOnCpu = false;
  wreal_dirtyOnCpu = false;
  b_dirtyOnCpu = false;
  b_W_dirtyOnGpu = false;
  U_dirtyOnGpu = false;
  U_dirtyOnCpu = false;
  W_dirtyOnGpu = false;
  W_dirtyOnCpu = false;
  iv_dirtyOnCpu = false;
  d_dirtyOnGpu = false;
  d_dirtyOnCpu = false;
  D_dirtyOnGpu = false;
  D_dirtyOnCpu = false;
  V_dirtyOnGpu = false;
  V_dirtyOnCpu = false;
  A_dirtyOnGpu = false;
  A_dirtyOnCpu = false;
  rr_dirtyOnGpu = false;
  rr_dirtyOnCpu = false;
  r_dirtyOnGpu = false;
  r_dirtyOnCpu = false;
  e_x_dirtyOnGpu = false;
  d_x_dirtyOnCpu = false;
  y_dirtyOnGpu = false;
  dv3_dirtyOnGpu = false;
  dv3_dirtyOnCpu = false;
  d_x_dirtyOnGpu = false;
  c_x_dirtyOnCpu = false;
  c_x_dirtyOnGpu = false;
  b_x_dirtyOnCpu = false;
  b_x_dirtyOnGpu = false;
  z_dirtyOnGpu = false;
  z_dirtyOnCpu = false;
  dv2_dirtyOnGpu = false;
  dv1_dirtyOnGpu = false;
  lin_dirtyOnGpu = false;
  lin_dirtyOnCpu = false;
  regs_dirtyOnGpu = false;
  olPct_dirtyOnCpu = false;
  out_data_dirtyOnGpu = false;
  olPct_data_dirtyOnGpu = false;
  w_dirtyOnCpu = true;
  w_dirtyOnGpu = false;
  x_dirtyOnCpu = true;
  x_dirtyOnGpu = false;
  cudaMemcpy(gpu_dc, &cpu_dc, 16UL, cudaMemcpyHostToDevice);
  ec_detr_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_dc);
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
  // 'ec_detr:20' x (:,:){mustBeFloat}
  // 'ec_detr:21' w (:,:){mustBeFloat}
  // 'ec_detr:22' ord (1,:){mustBeFloat}
  inVectorLength = 1;
  if (ord_size[0] != 1) {
    inVectorLength = 0;
  }

  if (ord_size[1] != 1) {
    inVectorLength = ord_size[1];
  }

  if ((ord_size[0] == 1) && (ord_size[1] == 1)) {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (static_cast<int8_T>(inVectorLength)), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_ord_data, cpu_ord_data, sizeof(real_T),
                 cudaMemcpyHostToDevice);
      ec_detr_kernel4<<<grid, block>>>(gpu_ord_data, static_cast<int8_T>
        (inVectorLength), *gpu_out_data);
      out_data_dirtyOnGpu = true;
    }
  } else if ((ord_size[0] == 0) || (ord_size[1] == 0)) {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_ord_data, cpu_ord_data, static_cast<uint32_T>(ord_size[0] *
                  ord_size[1]) * sizeof(real_T), cudaMemcpyHostToDevice);
      ec_detr_kernel3<<<grid, block>>>(gpu_ord_data, inVectorLength,
        *gpu_out_data);
      out_data_dirtyOnGpu = true;
    }
  } else {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_ord_data, cpu_ord_data, static_cast<uint32_T>(ord_size[0] *
                  ord_size[1]) * sizeof(real_T), cudaMemcpyHostToDevice);
      ec_detr_kernel2<<<grid, block>>>(gpu_ord_data, inVectorLength,
        *gpu_out_data);
      out_data_dirtyOnGpu = true;
    }
  }

  // 'ec_detr:23' thr (1,:){mustBeFloat}
  b_inVectorLength = 1;
  if (thr_size[0] != 1) {
    b_inVectorLength = 0;
  }

  if (thr_size[1] != 1) {
    b_inVectorLength = thr_size[1];
  }

  if ((thr_size[0] == 1) && (thr_size[1] == 1)) {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (static_cast<int8_T>(b_inVectorLength)), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_thr_data, cpu_thr_data, sizeof(real_T),
                 cudaMemcpyHostToDevice);
      ec_detr_kernel7<<<grid, block>>>(gpu_thr_data, static_cast<int8_T>
        (b_inVectorLength), *b_gpu_out_data);
    }
  } else if ((thr_size[0] == 0) || (thr_size[1] == 0)) {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (b_inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_thr_data, cpu_thr_data, static_cast<uint32_T>(thr_size[0] *
                  thr_size[1]) * sizeof(real_T), cudaMemcpyHostToDevice);
      ec_detr_kernel6<<<grid, block>>>(gpu_thr_data, b_inVectorLength,
        *b_gpu_out_data);
    }
  } else {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (b_inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_thr_data, cpu_thr_data, static_cast<uint32_T>(thr_size[0] *
                  thr_size[1]) * sizeof(real_T), cudaMemcpyHostToDevice);
      ec_detr_kernel5<<<grid, block>>>(gpu_thr_data, b_inVectorLength,
        *b_gpu_out_data);
    }
  }

  // 'ec_detr:24' itr (1,:){mustBeFloat}
  b_inVectorLength = 1;
  if (itr_size[0] != 1) {
    b_inVectorLength = 0;
  }

  if (itr_size[1] != 1) {
    b_inVectorLength = itr_size[1];
  }

  if ((itr_size[0] == 1) && (itr_size[1] == 1)) {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (static_cast<int8_T>(b_inVectorLength)), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_itr_data, cpu_itr_data, sizeof(real_T),
                 cudaMemcpyHostToDevice);
      ec_detr_kernel10<<<grid, block>>>(gpu_itr_data, static_cast<int8_T>
        (b_inVectorLength), *c_gpu_out_data);
    }
  } else if ((itr_size[0] == 0) || (itr_size[1] == 0)) {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (b_inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_itr_data, cpu_itr_data, static_cast<uint32_T>(itr_size[0] *
                  itr_size[1]) * sizeof(real_T), cudaMemcpyHostToDevice);
      ec_detr_kernel9<<<grid, block>>>(gpu_itr_data, b_inVectorLength,
        *c_gpu_out_data);
    }
  } else {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (b_inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_itr_data, cpu_itr_data, static_cast<uint32_T>(itr_size[0] *
                  itr_size[1]) * sizeof(real_T), cudaMemcpyHostToDevice);
      ec_detr_kernel8<<<grid, block>>>(gpu_itr_data, b_inVectorLength,
        *c_gpu_out_data);
    }
  }

  //  Main
  // 'ec_detr:28' coder.gpu.kernelfun;
  //  trigger CUDA kernel generation
  // 'ec_detr:29' nFrames = size(x,1);
  nFrames = cpu_x->size[0];

  // 'ec_detr:30' nChs = size(x,2);
  // 'ec_detr:31' reps = numel(ord);
  // 'ec_detr:32' olPct = coder.nullcopy(nan(nChs,reps));
  emxInit_int32_T(&cpu_olPct, 2, &yc_emlrtRTEI, true);
  k = cpu_olPct->size[0] * cpu_olPct->size[1];
  cpu_olPct->size[0] = cpu_x->size[1];
  cpu_olPct->size[1] = inVectorLength;
  emxEnsureCapacity_int32_T(cpu_olPct, k, &b_emlrtRTEI);
  gpuEmxEnsureCapacity_int32_T(cpu_olPct, &gpu_olPct);

  //  Detrend by polynomial order
  // 'ec_detr:35' for ii = 1:reps
  emxInit_real_T(&cpu_regs, 2, &ad_emlrtRTEI, true);
  emxInit_real_T(&cpu_lin, 2, &bd_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv1, 1, &hb_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv2, 1, &hb_emlrtRTEI, true);
  emxInit_real_T(&cpu_z, 1, &cd_emlrtRTEI, true);
  emxInit_boolean_T(&b_cpu_x, 1, &j_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_x, 1, &k_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_x, 1, &k_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv3, 1, &dd_emlrtRTEI, true);
  emxInit_real_T(&cpu_y, 2, &ed_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_x, 2, &k_emlrtRTEI, true);
  emxInit_real_T(&cpu_r, 2, &fd_emlrtRTEI, true);
  emxInit_real_T(&cpu_rr, 2, &o_emlrtRTEI, true);
  emxInit_real_T(&cpu_A, 2, &hb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_A, 2, &p_emlrtRTEI, true);
  emxInit_creal_T(&cpu_V, 2, &hb_emlrtRTEI, true);
  emxInit_creal_T(&cpu_D, 2, &hb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_V, 2, &gd_emlrtRTEI, true);
  emxInit_creal_T(&cpu_d, 1, &hd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &id_emlrtRTEI, true);
  emxInit_real_T(&cpu_W, 1, &hb_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_A, 2, &bc_emlrtRTEI, true);
  emxInit_real_T(&scale, 1, &jd_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_A, 2, &p_emlrtRTEI, true);
  emxInit_real_T(&cpu_U, 2, &hb_emlrtRTEI, true);
  emxInit_creal_T(&b_cpu_W, 1, &hb_emlrtRTEI, true);
  emxInit_real_T(&cpu_b, 2, &jc_emlrtRTEI, true);
  emxInit_real_T(&cpu_wreal, 1, &kd_emlrtRTEI, true);
  emxInit_real_T(&cpu_tau, 1, &hb_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_A, 2, &p_emlrtRTEI, true);
  emxInit_real_T(&cpu_wimag, 1, &ld_emlrtRTEI, true);
  emxInit_real_T(&cpu_vright, 2, &md_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_A, 2, &hb_emlrtRTEI, true);
  emxInit_real_T(&wr, 2, &nd_emlrtRTEI, true);
  emxInit_real_T(&cpu_Y, 1, &od_emlrtRTEI, true);
  emxInit_real_T(&g_cpu_A, 2, &hb_emlrtRTEI, true);
  emxInit_real_T(&wi, 2, &pd_emlrtRTEI, true);
  emxInit_real_T(&cpu_B, 1, &lc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv, 2, &hb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_B, 1, &mc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_jpvt, 2, &hb_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv_t, 1, &qd_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_tau, 1, &hb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_y, 1, &rd_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &qc_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv7, 1, &rc_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_d, 1, &tc_emlrtRTEI, true);
  emxInit_real_T(&cpu_absdiff, 1, &sd_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_y, 1, &td_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_x, 1, &i_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_V, 2, &pb_emlrtRTEI, true);
  for (int32_T ii{0}; ii < inVectorLength; ii++) {
    int32_T i4;

    // 'ec_detr:36' iOrd=ord(ii);
    // 'ec_detr:36' iThr=thr(ii);
    // 'ec_detr:36' iItr=itr(ii);
    //  copy
    // 'ec_detr:37' regs = regsFromBasis_lfn(nFrames,iOrd);
    // %%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    //  Get regressors from polynomial function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    // 'ec_detr:58' regs = coder.nullcopy(zeros(nFrames,iOrd,'like',iOrd));
    k = cpu_regs->size[0] * cpu_regs->size[1];
    cpu_regs->size[0] = nFrames;
    if (out_data_dirtyOnGpu) {
      cudaMemcpy(cpu_out_data, *gpu_out_data, 792UL, cudaMemcpyDeviceToHost);
    }

    cpu_regs->size[1] = static_cast<int32_T>(cpu_out_data[ii]);
    emxEnsureCapacity_real_T(cpu_regs, k, &d_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_regs, &gpu_regs);

    // 'ec_detr:59' lin = linspace(-1,1,nFrames);
    k = cpu_lin->size[0] * cpu_lin->size[1];
    cpu_lin->size[0] = 1;
    cpu_lin->size[1] = nFrames;
    emxEnsureCapacity_real_T(cpu_lin, k, &e_emlrtRTEI);
    if (!lin_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real_T(cpu_lin, &gpu_lin);
    }

    if (nFrames >= 1) {
      if (lin_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_lin, &gpu_lin);
      }

      cpu_lin->data[nFrames - 1] = 1.0;
      lin_dirtyOnCpu = true;
      lin_dirtyOnGpu = false;
      if (cpu_lin->size[1] >= 2) {
        cpu_lin->data[0] = -1.0;
        if (cpu_lin->size[1] >= 3) {
          cpu_d2scaled = 1.0 / (static_cast<real_T>(cpu_lin->size[1]) - 1.0);
          npages = cpu_lin->size[1];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages
            - 2L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 8UL, cudaMemcpyHostToDevice);
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, cpu_lin);
            ec_detr_kernel11<<<grid, block>>>(gpu_d2scaled, npages, gpu_lin,
              cpu_lin->size[1U]);
            lin_dirtyOnGpu = true;
            lin_dirtyOnCpu = false;
          }

          if ((cpu_lin->size[1] & 1) == 1) {
            if (lin_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, cpu_lin);
            }

            ec_detr_kernel12<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_lin,
              cpu_lin->size[1U]);
            lin_dirtyOnGpu = true;
            lin_dirtyOnCpu = false;
          }
        }
      }
    }

    // 'ec_detr:60' for k = 1:iOrd
    out_data_dirtyOnGpu = false;
    npages = static_cast<int32_T>(cpu_out_data[ii]);
    for (k = 0; k < npages; k++) {
      // 'ec_detr:61' regs(:,k) = lin.^k;
      cpu_nx = cpu_lin->size[1];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(cpu_nx),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (lin_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_lin, cpu_lin);
        }

        lin_dirtyOnCpu = false;
        cudaMemcpy(gpu_nx, &cpu_nx, 4UL, cudaMemcpyHostToDevice);
        ec_detr_kernel13<<<grid, block>>>(gpu_lin, k, gpu_nx, gpu_regs,
          cpu_regs->size[0U]);
        regs_dirtyOnGpu = true;
      }
    }

    //  Get regressors from basis function
    //  Detrend per chan
    // 'ec_detr:40' for ch = 1:nChs
    i4 = cpu_x->size[1];
    if (i4 - 1 >= 0) {
      ec_detr_kernel14<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*c_gpu_out_data,
        ii, gpu_i5);
      i5_dirtyOnGpu = true;
    }

    for (int32_T ch{0}; ch < i4; ch++) {
      // 'ec_detr:41' [x(:,ch),w(:,ch)] = detrend_lfn(x(:,ch),w(:,ch),regs,iThr,iItr);
      k = cpu_dv1->size[0];
      cpu_dv1->size[0] = cpu_x->size[0];
      emxEnsureCapacity_real_T(cpu_dv1, k, &f_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1);
      b_inVectorLength = cpu_x->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
        }

        x_dirtyOnCpu = false;
        ec_detr_kernel15<<<grid, block>>>(ch, gpu_x, b_inVectorLength, gpu_dv1,
          cpu_x->size[0U]);
        dv1_dirtyOnGpu = true;
      }

      k = cpu_dv2->size[0];
      cpu_dv2->size[0] = cpu_w->size[0];
      emxEnsureCapacity_real_T(cpu_dv2, k, &g_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_dv2, &gpu_dv2);
      b_inVectorLength = cpu_w->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (w_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, cpu_w);
        }

        w_dirtyOnCpu = false;
        ec_detr_kernel16<<<grid, block>>>(ch, gpu_w, b_inVectorLength, gpu_dv2,
          cpu_w->size[0U]);
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
      // 'ec_detr:80' z = coder.nullcopy(x);
      k = cpu_z->size[0];
      cpu_z->size[0] = cpu_x->size[0];
      emxEnsureCapacity_real_T(cpu_z, k, &h_emlrtRTEI);
      if (!z_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z);
      }

      // 'ec_detr:81' for ii = 1:iItr
      if (i5_dirtyOnGpu) {
        cudaMemcpy(&cpu_i5, gpu_i5, 4UL, cudaMemcpyDeviceToHost);
      }

      i5_dirtyOnGpu = false;
      for (int32_T b_ii{0}; b_ii < cpu_i5; b_ii++) {
        real_T mn;
        int32_T n;
        int32_T na;
        boolean_T d2scaled_dirtyOnCpu;

        //  Weighted regression
        // 'ec_detr:83' z = regw_lfn(x,w,r);
        //  Weighted Regression %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //   b: regression matrix (apply to r to approximate x)
        //   z: regression (r*b)
        //  Discard dimensions of r with eigenvalue lower than this
        // 'ec_detr:102' thrPCA = 1e-7;
        // zeros(1,1,class(x));
        //  Save weighted mean
        // 'ec_detr:105' mn = x - demean_lfn(x,w);
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ec_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_dv1->size[0] == cpu_dv2->size[0]) {
          k = c_cpu_x->size[0];
          c_cpu_x->size[0] = cpu_dv1->size[0];
          emxEnsureCapacity_real_T(c_cpu_x, k, &k_emlrtRTEI);
          if (!b_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(c_cpu_x, &b_gpu_x);
          }

          b_inVectorLength = cpu_dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, c_cpu_x);
            }

            ec_detr_kernel17<<<grid, block>>>(gpu_dv2, gpu_dv1, b_inVectorLength,
              b_gpu_x);
            c_x_dirtyOnGpu = true;
            b_x_dirtyOnCpu = false;
          }
        } else {
          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_cpu_x, &b_gpu_x);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          times(c_cpu_x, cpu_dv1, cpu_dv2);
          b_x_dirtyOnCpu = true;
          c_x_dirtyOnGpu = false;
        }

        cpu_nx = c_cpu_x->size[0];
        if (c_cpu_x->size[0] == 0) {
          cpu_d2scaled = 0.0;
        } else {
          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_cpu_x, &b_gpu_x);
          }

          c_x_dirtyOnGpu = false;
          cpu_d2scaled = c_cpu_x->data[0];
          for (k = 0; k <= cpu_nx - 2; k++) {
            cpu_d2scaled += c_cpu_x->data[k + 1];
          }
        }

        cpu_nx = cpu_dv2->size[0];
        if (cpu_dv2->size[0] == 0) {
          abnrm = 0.0;
        } else {
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          abnrm = cpu_dv2->data[0];
          for (k = 0; k <= cpu_nx - 2; k++) {
            abnrm += cpu_dv2->data[k + 1];
          }
        }

        mn = cpu_d2scaled / (abnrm + 2.2204460492503131E-16);

        // 'ec_detr:125' x = x - mn;
        //  Fit weighted regression
        // 'ec_detr:108' x = demean_lfn(x,w).* w;
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ec_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_dv1->size[0] == cpu_dv2->size[0]) {
          k = d_cpu_x->size[0];
          d_cpu_x->size[0] = cpu_dv1->size[0];
          emxEnsureCapacity_real_T(d_cpu_x, k, &k_emlrtRTEI);
          if (!c_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(d_cpu_x, &c_gpu_x);
          }

          b_inVectorLength = cpu_dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, d_cpu_x);
            }

            ec_detr_kernel18<<<grid, block>>>(gpu_dv2, gpu_dv1, b_inVectorLength,
              c_gpu_x);
            d_x_dirtyOnGpu = true;
            c_x_dirtyOnCpu = false;
          }
        } else {
          if (d_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &c_gpu_x);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          times(d_cpu_x, cpu_dv1, cpu_dv2);
          c_x_dirtyOnCpu = true;
          d_x_dirtyOnGpu = false;
        }

        cpu_nx = d_cpu_x->size[0];
        if (d_cpu_x->size[0] == 0) {
          cpu_d2scaled = 0.0;
        } else {
          if (d_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &c_gpu_x);
          }

          d_x_dirtyOnGpu = false;
          cpu_d2scaled = d_cpu_x->data[0];
          for (k = 0; k <= cpu_nx - 2; k++) {
            cpu_d2scaled += d_cpu_x->data[k + 1];
          }
        }

        cpu_nx = cpu_dv2->size[0];
        if (cpu_dv2->size[0] == 0) {
          abnrm = 0.0;
        } else {
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          abnrm = cpu_dv2->data[0];
          for (k = 0; k <= cpu_nx - 2; k++) {
            abnrm += cpu_dv2->data[k + 1];
          }
        }

        cpu_d2scaled /= abnrm + 2.2204460492503131E-16;

        // 'ec_detr:125' x = x - mn;
        if (cpu_dv1->size[0] == cpu_dv2->size[0]) {
          k = cpu_dv3->size[0];
          cpu_dv3->size[0] = cpu_dv1->size[0];
          emxEnsureCapacity_real_T(cpu_dv3, k, &l_emlrtRTEI);
          if (!dv3_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_dv3, &gpu_dv3);
          }

          b_inVectorLength = cpu_dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 8UL, cudaMemcpyHostToDevice);
            if (dv3_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv3, cpu_dv3);
            }

            ec_detr_kernel19<<<grid, block>>>(gpu_dv2, gpu_d2scaled, gpu_dv1,
              b_inVectorLength, gpu_dv3);
            dv3_dirtyOnGpu = true;
            dv3_dirtyOnCpu = false;
          }
        } else {
          if (dv3_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv3, &gpu_dv3);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          binary_expand_op(cpu_dv3, cpu_dv1, cpu_d2scaled, cpu_dv2);
          dv3_dirtyOnCpu = true;
          dv3_dirtyOnGpu = false;
        }

        // 'ec_detr:109' r = demean_lfn(r,w);
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ec_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_regs->size[0] == cpu_dv2->size[0]) {
          k = e_cpu_x->size[0] * e_cpu_x->size[1];
          e_cpu_x->size[0] = cpu_regs->size[0];
          e_cpu_x->size[1] = cpu_regs->size[1];
          emxEnsureCapacity_real_T(e_cpu_x, k, &k_emlrtRTEI);
          if (!d_x_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(e_cpu_x, &d_gpu_x);
          }

          b_inVectorLength = cpu_regs->size[1] - 1;
          k = cpu_regs->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((k +
            1L) * (b_inVectorLength + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (d_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_x, e_cpu_x);
            }

            ec_detr_kernel20<<<grid, block>>>(gpu_dv2, gpu_regs, k,
              b_inVectorLength, d_gpu_x, e_cpu_x->size[0U], cpu_regs->size[0U]);
            e_x_dirtyOnGpu = true;
            d_x_dirtyOnCpu = false;
          }
        } else {
          if (e_x_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_cpu_x, &d_gpu_x);
          }

          if (regs_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_regs, &gpu_regs);
          }

          regs_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          binary_expand_op(e_cpu_x, cpu_regs, cpu_dv2);
          d_x_dirtyOnCpu = true;
          e_x_dirtyOnGpu = false;
        }

        cpu_nx = e_cpu_x->size[0];
        if ((e_cpu_x->size[0] == 0) || (e_cpu_x->size[1] == 0)) {
          for (b_inVectorLength = 0; b_inVectorLength < 2; b_inVectorLength++) {
            b_sz[b_inVectorLength] = static_cast<uint32_T>(e_cpu_x->
              size[b_inVectorLength]);
          }

          k = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = static_cast<int32_T>(b_sz[1]);
          emxEnsureCapacity_real_T(cpu_y, k, &m_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y);
          b_inVectorLength = static_cast<int32_T>(b_sz[1]) - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detr_kernel22<<<grid, block>>>(static_cast<int32_T>(b_sz[1]) - 1,
              gpu_y);
            y_dirtyOnGpu = true;
          }
        } else {
          npages = e_cpu_x->size[1];
          k = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = e_cpu_x->size[1];
          emxEnsureCapacity_real_T(cpu_y, k, &c_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_nx, &cpu_nx, 4UL, cudaMemcpyHostToDevice);
            if (d_x_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_x, e_cpu_x);
            }

            d_x_dirtyOnCpu = false;
            ec_detr_kernel21<<<grid, block>>>(gpu_nx, d_gpu_x, npages, gpu_y,
              e_cpu_x->size[0U]);
            y_dirtyOnGpu = true;
          }
        }

        cpu_nx = cpu_dv2->size[0];
        if (cpu_dv2->size[0] == 0) {
          cpu_d2scaled = 0.0;
        } else {
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          cpu_d2scaled = cpu_dv2->data[0];
          for (k = 0; k <= cpu_nx - 2; k++) {
            cpu_d2scaled += cpu_dv2->data[k + 1];
          }
        }

        // 'ec_detr:125' x = x - mn;
        if (cpu_regs->size[1] == cpu_y->size[1]) {
          cpu_d2scaled += 2.2204460492503131E-16;
          k = cpu_r->size[0] * cpu_r->size[1];
          cpu_r->size[0] = cpu_regs->size[0];
          cpu_r->size[1] = cpu_regs->size[1];
          emxEnsureCapacity_real_T(cpu_r, k, &n_emlrtRTEI);
          if (!r_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_r, &gpu_r);
          }

          b_inVectorLength = cpu_regs->size[1] - 1;
          k = cpu_regs->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((k +
            1L) * (b_inVectorLength + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 8UL, cudaMemcpyHostToDevice);
            if (r_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, cpu_r);
            }

            ec_detr_kernel23<<<grid, block>>>(gpu_d2scaled, gpu_y, gpu_regs, k,
              b_inVectorLength, gpu_r, cpu_r->size[0U], cpu_regs->size[0U]);
            r_dirtyOnGpu = true;
            r_dirtyOnCpu = false;
          }
        } else {
          if (r_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_r, &gpu_r);
          }

          if (regs_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_regs, &gpu_regs);
          }

          regs_dirtyOnGpu = false;
          if (y_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_y, &gpu_y);
          }

          y_dirtyOnGpu = false;
          b_binary_expand_op(cpu_r, cpu_regs, cpu_y, cpu_d2scaled);
          r_dirtyOnCpu = true;
          r_dirtyOnGpu = false;
        }

        //  remove channel-specific-weighted mean from regressor
        // 'ec_detr:110' rr = r.*w;
        if (cpu_r->size[0] == cpu_dv2->size[0]) {
          k = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = cpu_r->size[0];
          cpu_rr->size[1] = cpu_r->size[1];
          emxEnsureCapacity_real_T(cpu_rr, k, &o_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_rr, &gpu_rr);
          }

          b_inVectorLength = cpu_r->size[1] - 1;
          k = cpu_r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((k +
            1L) * (b_inVectorLength + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (r_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, cpu_r);
            }

            r_dirtyOnCpu = false;
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, cpu_rr);
            }

            ec_detr_kernel24<<<grid, block>>>(gpu_dv2, gpu_r, k,
              b_inVectorLength, gpu_rr, cpu_rr->size[0U], cpu_r->size[0U]);
            rr_dirtyOnGpu = true;
            rr_dirtyOnCpu = false;
          }
        } else {
          if (rr_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_rr, &gpu_rr);
          }

          if (r_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_r, &gpu_r);
          }

          r_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          binary_expand_op(cpu_rr, cpu_r, cpu_dv2);
          rr_dirtyOnCpu = true;
          rr_dirtyOnGpu = false;
        }

        // 'ec_detr:111' [V,D] = eig(rr'*rr);
        k = b_cpu_A->size[0] * b_cpu_A->size[1];
        b_cpu_A->size[0] = cpu_rr->size[1];
        b_cpu_A->size[1] = cpu_rr->size[0];
        emxEnsureCapacity_real_T(b_cpu_A, k, &p_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_A, &gpu_A);
        k = cpu_rr->size[0] - 1;
        b_inVectorLength = cpu_rr->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((b_inVectorLength + 1L) * (k + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          ec_detr_kernel25<<<grid, block>>>(gpu_rr, b_inVectorLength, k, gpu_A,
            b_cpu_A->size[0U], cpu_rr->size[0U]);
        }

        if ((b_cpu_A->size[0] == 0) || (b_cpu_A->size[1] == 0) || (cpu_rr->size
             [0] == 0) || (cpu_rr->size[1] == 0)) {
          k = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = b_cpu_A->size[0];
          cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(cpu_A, k, &r_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_A, &b_gpu_A);
          }

          k = b_cpu_A->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, cpu_A);
            }

            ec_detr_kernel26<<<grid, block>>>(k, b_gpu_A);
            A_dirtyOnGpu = true;
            A_dirtyOnCpu = false;
          }
        } else {
          k = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = b_cpu_A->size[0];
          cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(cpu_A, k, &q_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_A, &b_gpu_A);
          }

          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          if (A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, cpu_A);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      b_cpu_A->size[0], cpu_rr->size[1], b_cpu_A->size[1],
                      (double *)&cpu_d2scaled, (double *)&gpu_A.data[0],
                      b_cpu_A->size[0], (double *)&gpu_rr.data[0], b_cpu_A->
                      size[1], (double *)&abnrm, (double *)&b_gpu_A.data[0],
                      b_cpu_A->size[0]);
          A_dirtyOnGpu = true;
          A_dirtyOnCpu = false;
        }

        n = cpu_A->size[0];
        k = cpu_V->size[0] * cpu_V->size[1];
        cpu_V->size[0] = cpu_A->size[0];
        cpu_V->size[1] = cpu_A->size[0];
        emxEnsureCapacity_creal_T(cpu_V, k, &s_emlrtRTEI);
        if (!V_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal_T(cpu_V, &gpu_V);
        }

        k = cpu_D->size[0] * cpu_D->size[1];
        cpu_D->size[0] = cpu_A->size[0];
        cpu_D->size[1] = cpu_A->size[0];
        emxEnsureCapacity_creal_T(cpu_D, k, &t_emlrtRTEI);
        if (!D_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal_T(cpu_D, &gpu_D);
        }

        if ((cpu_A->size[0] != 0) && (cpu_A->size[1] != 0)) {
          cpu_nx = cpu_A->size[0] * cpu_A->size[1];
          olPct_dirtyOnCpu = true;
          for (k = 0; k < cpu_nx; k++) {
            if (olPct_dirtyOnCpu) {
              if (A_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
              }

              A_dirtyOnGpu = false;
              if (std::isinf(cpu_A->data[k]) || std::isnan(cpu_A->data[k])) {
                olPct_dirtyOnCpu = false;
              }
            } else {
              olPct_dirtyOnCpu = false;
            }
          }

          if (!olPct_dirtyOnCpu) {
            for (b_inVectorLength = 0; b_inVectorLength < 2; b_inVectorLength++)
            {
              dv2[b_inVectorLength] = cpu_V->size[b_inVectorLength];
            }

            k = cpu_V->size[0] * cpu_V->size[1];
            cpu_V->size[0] = dv2[0];
            cpu_V->size[1] = dv2[1];
            emxEnsureCapacity_creal_T(cpu_V, k, &v_emlrtRTEI);
            if (!V_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal_T(cpu_V, &gpu_V);
            }

            b_inVectorLength = dv2[0] * dv2[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (V_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, cpu_V);
              }

              ec_detr_kernel48<<<grid, block>>>(gpu_dc, b_inVectorLength, gpu_V);
              V_dirtyOnGpu = true;
              V_dirtyOnCpu = false;
            }

            for (b_inVectorLength = 0; b_inVectorLength < 2; b_inVectorLength++)
            {
              dv2[b_inVectorLength] = cpu_D->size[b_inVectorLength];
            }

            k = cpu_D->size[0] * cpu_D->size[1];
            cpu_D->size[0] = dv2[0];
            cpu_D->size[1] = dv2[1];
            emxEnsureCapacity_creal_T(cpu_D, k, &bb_emlrtRTEI);
            if (!D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal_T(cpu_D, &gpu_D);
            }

            b_inVectorLength = dv2[0] * dv2[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, cpu_D);
              }

              ec_detr_kernel49<<<grid, block>>>(b_inVectorLength, gpu_D);
              D_dirtyOnGpu = true;
              D_dirtyOnCpu = false;
            }

            for (k = 0; k < n; k++) {
              if (D_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_creal_T(cpu_D, &gpu_D);
              }

              if (dc_dirtyOnGpu) {
                cudaMemcpy(&cpu_dc, gpu_dc, 16UL, cudaMemcpyDeviceToHost);
              }

              dc_dirtyOnGpu = false;
              cpu_D->data[k + cpu_D->size[0] * k] = cpu_dc;
              D_dirtyOnCpu = true;
              D_dirtyOnGpu = false;
            }
          } else {
            int32_T exitg1;
            boolean_T exitg2;
            olPct_dirtyOnCpu = (cpu_A->size[0] == cpu_A->size[1]);
            if (olPct_dirtyOnCpu) {
              na = 0;
              exitg2 = false;
              while ((!exitg2) && (na <= cpu_A->size[1] - 1)) {
                k = 0;
                do {
                  exitg1 = 0;
                  if (k <= na) {
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
                    }

                    A_dirtyOnGpu = false;
                    if (!(cpu_A->data[k + cpu_A->size[0] * na] == cpu_A->data[na
                          + cpu_A->size[0] * k])) {
                      olPct_dirtyOnCpu = false;
                      exitg1 = 1;
                    } else {
                      k++;
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

            if (olPct_dirtyOnCpu) {
              ptrdiff_t info_t;
              ptrdiff_t n_t;
              n = cpu_A->size[0];
              n_t = (ptrdiff_t)cpu_A->size[0];
              k = cpu_W->size[0];
              cpu_W->size[0] = cpu_A->size[0];
              emxEnsureCapacity_real_T(cpu_W, k, &y_emlrtRTEI);
              if (!W_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real_T(cpu_W, &gpu_W);
              }

              if (A_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
              }

              if (W_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_W, &gpu_W);
              }

              info_t = LAPACKE_dsyev(102, 'V', 'L', n_t, &cpu_A->data[0], n_t,
                &cpu_W->data[0]);
              W_dirtyOnCpu = true;
              W_dirtyOnGpu = false;
              A_dirtyOnCpu = true;
              A_dirtyOnGpu = false;
              if ((int32_T)info_t < 0) {
                npages = cpu_W->size[0];
                k = cpu_W->size[0];
                cpu_W->size[0] = npages;
                emxEnsureCapacity_real_T(cpu_W, k, &eb_emlrtRTEI);
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (npages), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_W, cpu_W);
                  ec_detr_kernel44<<<grid, block>>>(npages, gpu_W);
                  W_dirtyOnGpu = true;
                  W_dirtyOnCpu = false;
                }

                for (b_inVectorLength = 0; b_inVectorLength < 2;
                     b_inVectorLength++) {
                  dv2[b_inVectorLength] = cpu_A->size[b_inVectorLength];
                }

                k = cpu_A->size[0] * cpu_A->size[1];
                cpu_A->size[0] = dv2[0];
                cpu_A->size[1] = dv2[1];
                emxEnsureCapacity_real_T(cpu_A, k, &mb_emlrtRTEI);
                b_inVectorLength = dv2[0] * dv2[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, cpu_A);
                  ec_detr_kernel45<<<grid, block>>>(b_inVectorLength, b_gpu_A);
                  A_dirtyOnGpu = true;
                  A_dirtyOnCpu = false;
                }
              }

              k = cpu_D->size[0] * cpu_D->size[1];
              cpu_D->size[0] = n;
              cpu_D->size[1] = n;
              emxEnsureCapacity_creal_T(cpu_D, k, &db_emlrtRTEI);
              if (!D_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(cpu_D, &gpu_D);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n *
                n), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, cpu_D);
                }

                ec_detr_kernel46<<<grid, block>>>(n, gpu_D);
                D_dirtyOnGpu = true;
                D_dirtyOnCpu = false;
              }

              for (k = 0; k < n; k++) {
                if (D_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_creal_T(cpu_D, &gpu_D);
                }

                if (W_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_W, &gpu_W);
                }

                W_dirtyOnGpu = false;
                cpu_D->data[k + cpu_D->size[0] * k].re = cpu_W->data[k];
                cpu_D->data[k + cpu_D->size[0] * k].im = 0.0;
                D_dirtyOnCpu = true;
                D_dirtyOnGpu = false;
              }

              k = cpu_V->size[0] * cpu_V->size[1];
              cpu_V->size[0] = cpu_A->size[0];
              cpu_V->size[1] = cpu_A->size[1];
              emxEnsureCapacity_creal_T(cpu_V, k, &nb_emlrtRTEI);
              if (!V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal_T(cpu_V, &gpu_V);
              }

              k = cpu_A->size[0] * cpu_A->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (A_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, cpu_A);
                }

                A_dirtyOnCpu = false;
                if (V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, cpu_V);
                }

                ec_detr_kernel47<<<grid, block>>>(b_gpu_A, k, gpu_V);
                V_dirtyOnGpu = true;
                V_dirtyOnCpu = false;
              }
            } else {
              olPct_dirtyOnCpu = (cpu_A->size[0] == cpu_A->size[1]);
              if (olPct_dirtyOnCpu) {
                na = 0;
                exitg2 = false;
                while ((!exitg2) && (na <= cpu_A->size[1] - 1)) {
                  k = 0;
                  do {
                    exitg1 = 0;
                    if (k <= na) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (!(cpu_A->data[k + cpu_A->size[0] * na] == -cpu_A->
                            data[na + cpu_A->size[0] * k])) {
                        olPct_dirtyOnCpu = false;
                        exitg1 = 1;
                      } else {
                        k++;
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

              if (olPct_dirtyOnCpu) {
                cpu_nx = cpu_A->size[0] * cpu_A->size[1];
                for (k = 0; k < cpu_nx; k++) {
                  if (olPct_dirtyOnCpu) {
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
                    }

                    A_dirtyOnGpu = false;
                    if (std::isinf(cpu_A->data[k]) || std::isnan(cpu_A->data[k]))
                    {
                      olPct_dirtyOnCpu = false;
                    }
                  } else {
                    olPct_dirtyOnCpu = false;
                  }
                }

                if (!olPct_dirtyOnCpu) {
                  for (b_inVectorLength = 0; b_inVectorLength < 2;
                       b_inVectorLength++) {
                    b_sz[b_inVectorLength] = static_cast<uint32_T>(cpu_A->
                      size[b_inVectorLength]);
                  }

                  k = cpu_U->size[0] * cpu_U->size[1];
                  cpu_U->size[0] = static_cast<int32_T>(b_sz[0]);
                  cpu_U->size[1] = static_cast<int32_T>(b_sz[1]);
                  emxEnsureCapacity_real_T(cpu_U, k, &jb_emlrtRTEI);
                  if (!U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(cpu_U, &gpu_U);
                  }

                  b_inVectorLength = static_cast<int32_T>(b_sz[0]) *
                    static_cast<int32_T>(b_sz[1]) - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, cpu_U);
                    }

                    ec_detr_kernel39<<<grid, block>>>(b_inVectorLength, gpu_U);
                    U_dirtyOnGpu = true;
                    U_dirtyOnCpu = false;
                  }

                  b_inVectorLength = static_cast<int32_T>(b_sz[0]);
                  if (static_cast<int32_T>(b_sz[0]) > 1) {
                    npages = 2;
                    if (static_cast<int32_T>(b_sz[0]) - 2 < static_cast<int32_T>
                        (b_sz[1]) - 1) {
                      cpu_nx = static_cast<int32_T>(b_sz[0]) - 1;
                    } else {
                      cpu_nx = static_cast<int32_T>(b_sz[1]);
                    }

                    for (na = 0; na < cpu_nx; na++) {
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(computeEndIdx(static_cast<int64_T>
                           (npages), static_cast<int64_T>(b_inVectorLength), 1L)
                          + 1L), &grid, &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        if (U_dirtyOnCpu) {
                          gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, cpu_U);
                        }

                        ec_detr_kernel40<<<grid, block>>>(na + 1, npages,
                          b_inVectorLength, gpu_U, cpu_U->size[0U]);
                        U_dirtyOnGpu = true;
                        U_dirtyOnCpu = false;
                      }

                      npages++;
                    }
                  }

                  for (b_inVectorLength = 0; b_inVectorLength < 2;
                       b_inVectorLength++) {
                    b_sz[b_inVectorLength] = static_cast<uint32_T>(cpu_A->
                      size[b_inVectorLength]);
                  }

                  k = cpu_A->size[0] * cpu_A->size[1];
                  cpu_A->size[0] = static_cast<int32_T>(b_sz[0]);
                  cpu_A->size[1] = static_cast<int32_T>(b_sz[1]);
                  emxEnsureCapacity_real_T(cpu_A, k, &sb_emlrtRTEI);
                  if (!A_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(cpu_A, &b_gpu_A);
                  }

                  b_inVectorLength = static_cast<int32_T>(b_sz[0]) *
                    static_cast<int32_T>(b_sz[1]) - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, cpu_A);
                    }

                    ec_detr_kernel41<<<grid, block>>>(b_inVectorLength, b_gpu_A);
                    A_dirtyOnGpu = true;
                    A_dirtyOnCpu = false;
                  }
                } else {
                  ptrdiff_t b_n_t;
                  ptrdiff_t c_info_t;
                  ptrdiff_t e_info_t;
                  n = cpu_A->size[0];
                  k = cpu_tau->size[0];
                  cpu_tau->size[0] = cpu_A->size[0] - 1;
                  emxEnsureCapacity_real_T(cpu_tau, k, &fb_emlrtRTEI);
                  if (!tau_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(cpu_tau, &b_gpu_tau);
                  }

                  if (cpu_A->size[0] > 1) {
                    ptrdiff_t b_info_t;
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
                    }

                    b_info_t = LAPACKE_dgehrd(102, (ptrdiff_t)cpu_A->size[0],
                      (ptrdiff_t)1, (ptrdiff_t)cpu_A->size[0], &cpu_A->data[0],
                      (ptrdiff_t)cpu_A->size[0], &cpu_tau->data[0]);
                    tau_dirtyOnCpu = true;
                    A_dirtyOnCpu = true;
                    A_dirtyOnGpu = false;
                    if ((int32_T)b_info_t != 0) {
                      for (b_inVectorLength = 0; b_inVectorLength < 2;
                           b_inVectorLength++) {
                        dv2[b_inVectorLength] = cpu_A->size[b_inVectorLength];
                      }

                      k = cpu_A->size[0] * cpu_A->size[1];
                      cpu_A->size[0] = dv2[0];
                      cpu_A->size[1] = dv2[1];
                      emxEnsureCapacity_real_T(cpu_A, k, &qb_emlrtRTEI);
                      b_inVectorLength = dv2[0] * dv2[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(b_inVectorLength + 1L), &grid,
                         &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, cpu_A);
                        ec_detr_kernel33<<<grid, block>>>(b_inVectorLength,
                          b_gpu_A);
                        A_dirtyOnGpu = true;
                        A_dirtyOnCpu = false;
                      }

                      npages = cpu_tau->size[0];
                      k = cpu_tau->size[0];
                      cpu_tau->size[0] = npages;
                      emxEnsureCapacity_real_T(cpu_tau, k, &ub_emlrtRTEI);
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(npages), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_tau, cpu_tau);
                        ec_detr_kernel34<<<grid, block>>>(npages, b_gpu_tau);
                        tau_dirtyOnGpu = true;
                        tau_dirtyOnCpu = false;
                      }
                    }
                  }

                  k = cpu_U->size[0] * cpu_U->size[1];
                  cpu_U->size[0] = cpu_A->size[0];
                  cpu_U->size[1] = cpu_A->size[1];
                  emxEnsureCapacity_real_T(cpu_U, k, &lb_emlrtRTEI);
                  if (!U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real_T(cpu_U, &gpu_U);
                  }

                  k = cpu_A->size[0] * cpu_A->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (k + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, cpu_A);
                    }

                    if (U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, cpu_U);
                    }

                    ec_detr_kernel35<<<grid, block>>>(b_gpu_A, k, gpu_U);
                    U_dirtyOnGpu = true;
                  }

                  if (U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(cpu_U, &gpu_U);
                  }

                  if (tau_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(cpu_tau, &b_gpu_tau);
                  }

                  tau_dirtyOnGpu = false;
                  c_info_t = LAPACKE_dorghr(102, (ptrdiff_t)n, (ptrdiff_t)1,
                    (ptrdiff_t)n, &cpu_U->data[0], (ptrdiff_t)n, &cpu_tau->data
                    [0]);
                  U_dirtyOnGpu = false;
                  if ((int32_T)c_info_t != 0) {
                    for (b_inVectorLength = 0; b_inVectorLength < 2;
                         b_inVectorLength++) {
                      dv2[b_inVectorLength] = cpu_U->size[b_inVectorLength];
                    }

                    k = cpu_U->size[0] * cpu_U->size[1];
                    cpu_U->size[0] = dv2[0];
                    cpu_U->size[1] = dv2[1];
                    emxEnsureCapacity_real_T(cpu_U, k, &lb_emlrtRTEI);
                    b_inVectorLength = dv2[0] * dv2[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_inVectorLength + 1L), &grid, &block,
                       1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, cpu_U);
                      ec_detr_kernel36<<<grid, block>>>(b_inVectorLength, gpu_U);
                      U_dirtyOnGpu = true;
                    }
                  }

                  b_n_t = (ptrdiff_t)cpu_A->size[0];
                  k = wr->size[0] * wr->size[1];
                  wr->size[0] = 1;
                  wr->size[1] = cpu_A->size[0];
                  emxEnsureCapacity_real_T(wr, k, &tb_emlrtRTEI);
                  k = wi->size[0] * wi->size[1];
                  wi->size[0] = 1;
                  wi->size[1] = cpu_A->size[0];
                  emxEnsureCapacity_real_T(wi, k, &wb_emlrtRTEI);
                  if (A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
                  }

                  if (U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(cpu_U, &gpu_U);
                  }

                  if (cpu_A->size[0] <= 1) {
                    b_inVectorLength = 1;
                  } else {
                    b_inVectorLength = cpu_A->size[0];
                  }

                  e_info_t = LAPACKE_dhseqr(102, 'S', 'V', b_n_t, (ptrdiff_t)1,
                    (ptrdiff_t)cpu_A->size[0], &cpu_A->data[0], b_n_t, &wr->
                    data[0], &wi->data[0], &cpu_U->data[0], (ptrdiff_t)
                    b_inVectorLength);
                  U_dirtyOnCpu = true;
                  U_dirtyOnGpu = false;
                  A_dirtyOnCpu = true;
                  A_dirtyOnGpu = false;
                  if ((int32_T)e_info_t < 0) {
                    for (b_inVectorLength = 0; b_inVectorLength < 2;
                         b_inVectorLength++) {
                      dv2[b_inVectorLength] = cpu_A->size[b_inVectorLength];
                    }

                    k = cpu_A->size[0] * cpu_A->size[1];
                    cpu_A->size[0] = dv2[0];
                    cpu_A->size[1] = dv2[1];
                    emxEnsureCapacity_real_T(cpu_A, k, &cc_emlrtRTEI);
                    b_inVectorLength = dv2[0] * dv2[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_inVectorLength + 1L), &grid, &block,
                       1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, cpu_A);
                      ec_detr_kernel37<<<grid, block>>>(b_inVectorLength,
                        b_gpu_A);
                      A_dirtyOnGpu = true;
                      A_dirtyOnCpu = false;
                    }

                    for (b_inVectorLength = 0; b_inVectorLength < 2;
                         b_inVectorLength++) {
                      dv2[b_inVectorLength] = cpu_U->size[b_inVectorLength];
                    }

                    k = cpu_U->size[0] * cpu_U->size[1];
                    cpu_U->size[0] = dv2[0];
                    cpu_U->size[1] = dv2[1];
                    emxEnsureCapacity_real_T(cpu_U, k, &gc_emlrtRTEI);
                    b_inVectorLength = dv2[0] * dv2[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_inVectorLength + 1L), &grid, &block,
                       1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, cpu_U);
                      ec_detr_kernel38<<<grid, block>>>(b_inVectorLength, gpu_U);
                      U_dirtyOnGpu = true;
                      U_dirtyOnCpu = false;
                    }
                  }
                }

                n = cpu_A->size[0];
                k = cpu_D->size[0] * cpu_D->size[1];
                cpu_D->size[0] = cpu_A->size[0];
                cpu_D->size[1] = cpu_A->size[0];
                emxEnsureCapacity_creal_T(cpu_D, k, &yb_emlrtRTEI);
                if (!D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(cpu_D, &gpu_D);
                }

                k = cpu_A->size[0] * cpu_A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (k + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, cpu_D);
                  }

                  ec_detr_kernel42<<<grid, block>>>(k, gpu_D);
                  D_dirtyOnGpu = true;
                  D_dirtyOnCpu = false;
                }

                k = 1;
                do {
                  exitg1 = 0;
                  if (k <= n) {
                    if (k != n) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (cpu_A->data[k + cpu_A->size[0] * (k - 1)] != 0.0) {
                        cpu_d2scaled = std::abs(cpu_A->data[k + cpu_A->size[0] *
                          (k - 1)]);
                        if (D_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_creal_T(cpu_D, &gpu_D);
                        }

                        cpu_D->data[(k + cpu_D->size[0] * (k - 1)) - 1].re = 0.0;
                        cpu_D->data[(k + cpu_D->size[0] * (k - 1)) - 1].im =
                          cpu_d2scaled;
                        cpu_D->data[k + cpu_D->size[0] * k].re = 0.0;
                        cpu_D->data[k + cpu_D->size[0] * k].im = -cpu_d2scaled;
                        D_dirtyOnCpu = true;
                        D_dirtyOnGpu = false;
                        k += 2;
                      } else {
                        k++;
                      }
                    } else {
                      k++;
                    }
                  } else {
                    exitg1 = 1;
                  }
                } while (exitg1 == 0);

                k = cpu_V->size[0] * cpu_V->size[1];
                cpu_V->size[0] = cpu_U->size[0];
                cpu_V->size[1] = cpu_U->size[1];
                emxEnsureCapacity_creal_T(cpu_V, k, &fc_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(cpu_V, &gpu_V);
                }

                b_inVectorLength = cpu_U->size[0] * cpu_U->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (U_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, cpu_U);
                  }

                  U_dirtyOnCpu = false;
                  if (V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, cpu_V);
                  }

                  ec_detr_kernel43<<<grid, block>>>(gpu_U, b_inVectorLength,
                    gpu_V);
                  V_dirtyOnGpu = true;
                  V_dirtyOnCpu = false;
                }

                na = 1;
                n = cpu_A->size[0];
                do {
                  exitg1 = 0;
                  if (na <= n) {
                    if (na != n) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (cpu_A->data[na + cpu_A->size[0] * (na - 1)] != 0.0) {
                        if (cpu_A->data[na + cpu_A->size[0] * (na - 1)] < 0.0) {
                          npages = 1;
                        } else {
                          npages = -1;
                        }

                        for (k = 0; k < n; k++) {
                          if (V_dirtyOnGpu) {
                            gpuEmxMemcpyGpuToCpu_creal_T(cpu_V, &gpu_V);
                          }

                          cpu_d2scaled = cpu_V->data[k + cpu_V->size[0] * (na -
                            1)].re;
                          abnrm = static_cast<real_T>(npages) * cpu_V->data[k +
                            cpu_V->size[0] * na].re;
                          if (abnrm == 0.0) {
                            cpu_V->data[k + cpu_V->size[0] * (na - 1)].re =
                              cpu_d2scaled / 1.4142135623730951;
                            cpu_V->data[k + cpu_V->size[0] * (na - 1)].im = 0.0;
                            V_dirtyOnGpu = false;
                          } else if (cpu_d2scaled == 0.0) {
                            cpu_V->data[k + cpu_V->size[0] * (na - 1)].re = 0.0;
                            cpu_V->data[k + cpu_V->size[0] * (na - 1)].im =
                              abnrm / 1.4142135623730951;
                            V_dirtyOnGpu = false;
                          } else {
                            cpu_V->data[k + cpu_V->size[0] * (na - 1)].re =
                              cpu_d2scaled / 1.4142135623730951;
                            cpu_V->data[k + cpu_V->size[0] * (na - 1)].im =
                              abnrm / 1.4142135623730951;
                            V_dirtyOnGpu = false;
                          }

                          cpu_V->data[k + cpu_V->size[0] * na].re = cpu_V->
                            data[k + cpu_V->size[0] * (na - 1)].re;
                          cpu_V->data[k + cpu_V->size[0] * na].im = -cpu_V->
                            data[k + cpu_V->size[0] * (na - 1)].im;
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
                n = cpu_A->size[0];
                cpu_nx = cpu_A->size[1] - 1;
                olPct_dirtyOnCpu = true;
                k = scale->size[0];
                scale->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real_T(scale, k, &ab_emlrtRTEI);
                k = b_cpu_W->size[0];
                b_cpu_W->size[0] = cpu_A->size[1];
                emxEnsureCapacity_creal_T(b_cpu_W, k, &cb_emlrtRTEI);
                gpuEmxEnsureCapacity_creal_T(b_cpu_W, &b_gpu_W);
                k = cpu_V->size[0] * cpu_V->size[1];
                cpu_V->size[0] = cpu_A->size[1];
                cpu_V->size[1] = cpu_A->size[1];
                emxEnsureCapacity_creal_T(cpu_V, k, &gb_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(cpu_V, &gpu_V);
                }

                k = cpu_wreal->size[0];
                cpu_wreal->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real_T(cpu_wreal, k, &ib_emlrtRTEI);
                if (!wreal_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_wreal, &gpu_wreal);
                }

                k = cpu_wimag->size[0];
                cpu_wimag->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real_T(cpu_wimag, k, &kb_emlrtRTEI);
                if (!wimag_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_wimag, &gpu_wimag);
                }

                k = cpu_vright->size[0] * cpu_vright->size[1];
                cpu_vright->size[0] = cpu_A->size[1];
                cpu_vright->size[1] = cpu_A->size[1];
                emxEnsureCapacity_real_T(cpu_vright, k, &ob_emlrtRTEI);
                if (!vright_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_vright, &gpu_vright);
                }

                if (A_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
                }

                d_info_t = LAPACKE_dgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)
                  cpu_A->size[1], &cpu_A->data[0], (ptrdiff_t)cpu_A->size[0],
                  &cpu_wreal->data[0], &cpu_wimag->data[0], &cpu_d2scaled,
                  (ptrdiff_t)1, &cpu_vright->data[0], (ptrdiff_t)cpu_A->size[1],
                  &ilo_t, &ihi_t, &scale->data[0], &abnrm, &rconde, &rcondv);
                vright_dirtyOnCpu = true;
                wimag_dirtyOnCpu = true;
                wreal_dirtyOnCpu = true;
                A_dirtyOnCpu = true;
                A_dirtyOnGpu = false;
                if ((int32_T)d_info_t < 0) {
                  npages = cpu_A->size[1];
                  k = b_cpu_W->size[0];
                  b_cpu_W->size[0] = cpu_A->size[1];
                  emxEnsureCapacity_creal_T(b_cpu_W, k, &vb_emlrtRTEI);
                  gpuEmxEnsureCapacity_creal_T(b_cpu_W, &b_gpu_W);
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (npages), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    ec_detr_kernel30<<<grid, block>>>(gpu_dc, npages, b_gpu_W);
                    b_W_dirtyOnGpu = true;
                  }

                  for (b_inVectorLength = 0; b_inVectorLength < 2;
                       b_inVectorLength++) {
                    dv2[b_inVectorLength] = cpu_V->size[b_inVectorLength];
                  }

                  k = cpu_V->size[0] * cpu_V->size[1];
                  cpu_V->size[0] = dv2[0];
                  cpu_V->size[1] = dv2[1];
                  emxEnsureCapacity_creal_T(cpu_V, k, &ac_emlrtRTEI);
                  if (!V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(cpu_V, &gpu_V);
                  }

                  b_inVectorLength = dv2[0] * dv2[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, cpu_V);
                    }

                    ec_detr_kernel31<<<grid, block>>>(gpu_dc, b_inVectorLength,
                      gpu_V);
                    V_dirtyOnGpu = true;
                    V_dirtyOnCpu = false;
                  }
                } else {
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_nx + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_wimag, cpu_wimag);
                    wimag_dirtyOnCpu = false;
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_wreal, cpu_wreal);
                    wreal_dirtyOnCpu = false;
                    cudaMemcpy(gpu_nx, &cpu_nx, 4UL, cudaMemcpyHostToDevice);
                    olPct_dirtyOnCpu = false;
                    ec_detr_kernel27<<<grid, block>>>(gpu_wimag, gpu_wreal,
                      gpu_nx, b_gpu_W);
                    b_W_dirtyOnGpu = true;
                  }

                  k = cpu_V->size[0] * cpu_V->size[1];
                  cpu_V->size[0] = cpu_vright->size[0];
                  cpu_V->size[1] = cpu_vright->size[1];
                  emxEnsureCapacity_creal_T(cpu_V, k, &xb_emlrtRTEI);
                  if (!V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal_T(cpu_V, &gpu_V);
                  }

                  b_inVectorLength = cpu_vright->size[0] * cpu_vright->size[1] -
                    1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_vright, cpu_vright);
                    vright_dirtyOnCpu = false;
                    if (V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, cpu_V);
                    }

                    ec_detr_kernel28<<<grid, block>>>(gpu_vright,
                      b_inVectorLength, gpu_V);
                    V_dirtyOnGpu = true;
                    V_dirtyOnCpu = false;
                  }

                  for (k = 0; k < cpu_nx; k++) {
                    if ((cpu_wimag->data[k] > 0.0) && (cpu_wimag->data[k + 1] <
                         0.0)) {
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(cpu_nx + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        if (olPct_dirtyOnCpu) {
                          cudaMemcpy(gpu_nx, &cpu_nx, 4UL,
                                     cudaMemcpyHostToDevice);
                        }

                        olPct_dirtyOnCpu = false;
                        if (V_dirtyOnCpu) {
                          gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, cpu_V);
                        }

                        ec_detr_kernel29<<<grid, block>>>(k + 2, gpu_nx, gpu_V,
                          cpu_V->size[0U]);
                        V_dirtyOnGpu = true;
                        V_dirtyOnCpu = false;
                      }
                    }
                  }
                }

                k = cpu_D->size[0] * cpu_D->size[1];
                cpu_D->size[0] = cpu_A->size[0];
                cpu_D->size[1] = cpu_A->size[0];
                emxEnsureCapacity_creal_T(cpu_D, k, &dc_emlrtRTEI);
                if (!D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal_T(cpu_D, &gpu_D);
                }

                k = cpu_A->size[0] * cpu_A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (k + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, cpu_D);
                  }

                  ec_detr_kernel32<<<grid, block>>>(k, gpu_D);
                  D_dirtyOnGpu = true;
                  D_dirtyOnCpu = false;
                }

                for (k = 0; k < n; k++) {
                  if (D_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal_T(cpu_D, &gpu_D);
                  }

                  if (b_W_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal_T(b_cpu_W, &b_gpu_W);
                  }

                  b_W_dirtyOnGpu = false;
                  cpu_D->data[k + cpu_D->size[0] * k] = b_cpu_W->data[k];
                  D_dirtyOnCpu = true;
                  D_dirtyOnGpu = false;
                }
              }
            }
          }
        }

        // 'ec_detr:112' V = real(V);
        k = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = cpu_V->size[0];
        b_cpu_V->size[1] = cpu_V->size[1];
        emxEnsureCapacity_real_T(b_cpu_V, k, &u_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_V, &b_gpu_V);
        b_inVectorLength = cpu_V->size[0] * cpu_V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (V_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, cpu_V);
          }

          V_dirtyOnCpu = false;
          ec_detr_kernel50<<<grid, block>>>(gpu_V, b_inVectorLength, b_gpu_V);
        }

        // 'ec_detr:113' D = real(diag(D));
        if ((cpu_D->size[0] == 1) && (cpu_D->size[1] == 1)) {
          k = cpu_d->size[0];
          cpu_d->size[0] = 1;
          emxEnsureCapacity_creal_T(cpu_d, k, &x_emlrtRTEI);
          if (!d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal_T(cpu_d, &b_gpu_d);
          }

          if (D_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_creal_T(cpu_D, &gpu_D);
          }

          D_dirtyOnGpu = false;
          cpu_d->data[0] = cpu_D->data[0];
          d_dirtyOnCpu = true;
        } else {
          k = cpu_D->size[0];
          npages = cpu_D->size[1];
          if (k <= npages) {
            npages = k;
          }

          if (cpu_D->size[1] <= 0) {
            npages = 0;
          }

          k = cpu_d->size[0];
          cpu_d->size[0] = npages;
          emxEnsureCapacity_creal_T(cpu_d, k, &w_emlrtRTEI);
          if (!d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal_T(cpu_d, &b_gpu_d);
          }

          npages--;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (D_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, cpu_D);
            }

            D_dirtyOnCpu = false;
            if (d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&b_gpu_d, cpu_d);
            }

            ec_detr_kernel51<<<grid, block>>>(gpu_D, npages, b_gpu_d,
              cpu_D->size[0U]);
            d_dirtyOnGpu = true;
            d_dirtyOnCpu = false;
          }
        }

        // 'ec_detr:114' V = V(:,D/max(D)>thrPCA);
        cpu_nx = cpu_d->size[0];
        if (d_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_creal_T(cpu_d, &b_gpu_d);
        }

        d_dirtyOnGpu = false;
        cpu_d2scaled = cpu_d->data[0].re;
        d2scaled_dirtyOnCpu = true;
        for (k = 0; k <= cpu_nx - 2; k++) {
          if (std::isnan(cpu_d->data[k + 1].re)) {
            olPct_dirtyOnCpu = false;
          } else if (std::isnan(cpu_d2scaled)) {
            olPct_dirtyOnCpu = true;
          } else {
            olPct_dirtyOnCpu = (cpu_d2scaled < cpu_d->data[k + 1].re);
          }

          if (olPct_dirtyOnCpu) {
            cpu_d2scaled = cpu_d->data[k + 1].re;
          }
        }

        n = cpu_d->size[0] - 1;
        npages = 0;
        for (k = 0; k <= n; k++) {
          if (cpu_d->data[k].re / cpu_d2scaled > 1.0E-7) {
            npages++;
          }
        }

        k = cpu_iv->size[0];
        cpu_iv->size[0] = npages;
        emxEnsureCapacity_int32_T(cpu_iv, k, &hb_emlrtRTEI);
        if (!iv_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv);
        }

        npages = 0;
        for (k = 0; k <= n; k++) {
          if (cpu_d->data[k].re / cpu_d2scaled > 1.0E-7) {
            cpu_iv->data[npages] = k;
            iv_dirtyOnCpu = true;
            npages++;
          }
        }

        npages = b_cpu_V->size[0];
        k = c_cpu_V->size[0] * c_cpu_V->size[1];
        c_cpu_V->size[0] = b_cpu_V->size[0];
        c_cpu_V->size[1] = cpu_iv->size[0];
        emxEnsureCapacity_real_T(c_cpu_V, k, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_cpu_V, &c_gpu_V);
        b_inVectorLength = cpu_iv->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages *
          (b_inVectorLength + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv, cpu_iv);
          }

          iv_dirtyOnCpu = false;
          ec_detr_kernel52<<<grid, block>>>(gpu_iv, b_gpu_V, npages,
            b_inVectorLength, c_gpu_V, c_cpu_V->size[0U], b_cpu_V->size[0U]);
        }

        k = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = c_cpu_V->size[0];
        b_cpu_V->size[1] = c_cpu_V->size[1];
        emxEnsureCapacity_real_T(b_cpu_V, k, &rb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_V, &b_gpu_V);
        b_inVectorLength = c_cpu_V->size[0] * c_cpu_V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detr_kernel53<<<grid, block>>>(c_gpu_V, b_inVectorLength, b_gpu_V);
        }

        //  discard weak dims
        // 'ec_detr:115' rr = rr*V;
        npages = cpu_rr->size[0];
        cpu_nx = cpu_rr->size[1];
        if ((cpu_rr->size[0] == 0) || (cpu_rr->size[1] == 0) || (b_cpu_V->size[0]
             == 0) || (b_cpu_V->size[1] == 0)) {
          npages = cpu_rr->size[0];
          dv2[0] = cpu_rr->size[0];
          dv2[1] = b_cpu_V->size[1];
          k = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = npages;
          cpu_rr->size[1] = b_cpu_V->size[1];
          emxEnsureCapacity_real_T(cpu_rr, k, &ec_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_rr, &gpu_rr);
          }

          b_inVectorLength = dv2[0] * dv2[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, cpu_rr);
            }

            ec_detr_kernel55<<<grid, block>>>(b_inVectorLength, gpu_rr);
            rr_dirtyOnGpu = true;
            rr_dirtyOnCpu = false;
          }
        } else {
          k = c_cpu_A->size[0] * c_cpu_A->size[1];
          c_cpu_A->size[0] = cpu_rr->size[0];
          c_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(c_cpu_A, k, &bc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_cpu_A, &g_gpu_A);
          k = cpu_rr->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, cpu_rr);
            }

            rr_dirtyOnCpu = false;
            ec_detr_kernel54<<<grid, block>>>(gpu_rr, k, g_gpu_A);
          }

          k = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = npages;
          cpu_rr->size[1] = b_cpu_V->size[1];
          emxEnsureCapacity_real_T(cpu_rr, k, &q_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_rr, &gpu_rr);
          }

          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, cpu_rr);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, npages,
                      b_cpu_V->size[1], cpu_nx, (double *)&cpu_d2scaled, (double
            *)&g_gpu_A.data[0], npages, (double *)&b_gpu_V.data[0], cpu_nx,
                      (double *)&abnrm, (double *)&gpu_rr.data[0], npages);
          rr_dirtyOnGpu = true;
          rr_dirtyOnCpu = false;
        }

        // 'ec_detr:116' b = (x'*rr) / (rr'*rr);
        k = d_cpu_A->size[0] * d_cpu_A->size[1];
        d_cpu_A->size[0] = 1;
        d_cpu_A->size[1] = cpu_dv3->size[0];
        emxEnsureCapacity_real_T(d_cpu_A, k, &p_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_cpu_A, &c_gpu_A);
        b_inVectorLength = cpu_dv3->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (dv3_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv3, cpu_dv3);
          }

          dv3_dirtyOnCpu = false;
          ec_detr_kernel56<<<grid, block>>>(gpu_dv3, b_inVectorLength, c_gpu_A);
        }

        if ((cpu_dv3->size[0] == 0) || (cpu_rr->size[0] == 0) || (cpu_rr->size[1]
             == 0)) {
          k = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(cpu_b, k, &r_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b);
          }

          k = cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
            }

            ec_detr_kernel57<<<grid, block>>>(k, gpu_b);
            b_dirtyOnCpu = false;
          }
        } else {
          k = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(cpu_b, k, &q_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b);
          }

          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                      cpu_rr->size[1], cpu_dv3->size[0], (double *)&cpu_d2scaled,
                      (double *)&c_gpu_A.data[0], 1, (double *)&gpu_rr.data[0],
                      cpu_dv3->size[0], (double *)&abnrm, (double *)&gpu_b.data
                      [0], 1);
          b_dirtyOnCpu = false;
        }

        k = e_cpu_A->size[0] * e_cpu_A->size[1];
        e_cpu_A->size[0] = cpu_rr->size[1];
        e_cpu_A->size[1] = cpu_rr->size[0];
        emxEnsureCapacity_real_T(e_cpu_A, k, &p_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_cpu_A, &d_gpu_A);
        k = cpu_rr->size[0] - 1;
        b_inVectorLength = cpu_rr->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((b_inVectorLength + 1L) * (k + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          ec_detr_kernel58<<<grid, block>>>(gpu_rr, b_inVectorLength, k, d_gpu_A,
            e_cpu_A->size[0U], cpu_rr->size[0U]);
        }

        if ((e_cpu_A->size[0] == 0) || (e_cpu_A->size[1] == 0) || (cpu_rr->size
             [0] == 0) || (cpu_rr->size[1] == 0)) {
          k = f_cpu_A->size[0] * f_cpu_A->size[1];
          f_cpu_A->size[0] = e_cpu_A->size[0];
          f_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(f_cpu_A, k, &r_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_cpu_A, &e_gpu_A);
          k = e_cpu_A->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detr_kernel59<<<grid, block>>>(k, e_gpu_A);
          }
        } else {
          k = f_cpu_A->size[0] * f_cpu_A->size[1];
          f_cpu_A->size[0] = e_cpu_A->size[0];
          f_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(f_cpu_A, k, &q_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_cpu_A, &e_gpu_A);
          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      e_cpu_A->size[0], cpu_rr->size[1], e_cpu_A->size[1],
                      (double *)&cpu_d2scaled, (double *)&d_gpu_A.data[0],
                      e_cpu_A->size[0], (double *)&gpu_rr.data[0], e_cpu_A->
                      size[1], (double *)&abnrm, (double *)&e_gpu_A.data[0],
                      e_cpu_A->size[0]);
        }

        if ((cpu_b->size[1] == 0) || ((f_cpu_A->size[0] == 0) || (f_cpu_A->size
              [1] == 0))) {
          b_sz[1] = static_cast<uint32_T>(f_cpu_A->size[0]);
          k = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = f_cpu_A->size[0];
          emxEnsureCapacity_real_T(cpu_b, k, &jc_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b);
          }

          b_inVectorLength = static_cast<int32_T>(b_sz[1]) - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
            }

            ec_detr_kernel74<<<grid, block>>>(static_cast<int32_T>(b_sz[1]) - 1,
              gpu_b);
            b_dirtyOnCpu = false;
          }
        } else if (f_cpu_A->size[0] == f_cpu_A->size[1]) {
          n = f_cpu_A->size[1] - 2;
          k = cpu_ipiv_t->size[0];
          cpu_ipiv_t->size[0] = f_cpu_A->size[1];
          emxEnsureCapacity_int32_T(cpu_ipiv_t, k, &hc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_ipiv_t, &gpu_ipiv_t);
          cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), f_cpu_A->size[1],
            f_cpu_A->size[1], (double *)&e_gpu_A.data[0], f_cpu_A->size[1],
            getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(8);
          cusolverInitWorkspace();
          cusolverDnDgetrf(getCuSolverGlobalHandle(), f_cpu_A->size[1],
                           f_cpu_A->size[1], (double *)&e_gpu_A.data[0],
                           f_cpu_A->size[1], static_cast<real_T *>
                           (getCuSolverWorkspaceBuff()), &gpu_ipiv_t.data[0],
                           gpu_info);
          k = cpu_ipiv->size[0] * cpu_ipiv->size[1];
          cpu_ipiv->size[0] = 1;
          cpu_ipiv->size[1] = cpu_ipiv_t->size[0];
          emxEnsureCapacity_int32_T(cpu_ipiv, k, &kc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_ipiv, &gpu_ipiv);
          cudaMemcpy(&cpu_info, gpu_info, 4UL, cudaMemcpyDeviceToHost);
          if (cpu_info < 0) {
            for (b_inVectorLength = 0; b_inVectorLength < 2; b_inVectorLength++)
            {
              dv2[b_inVectorLength] = f_cpu_A->size[b_inVectorLength];
            }

            k = f_cpu_A->size[0] * f_cpu_A->size[1];
            f_cpu_A->size[0] = dv2[0];
            f_cpu_A->size[1] = dv2[1];
            emxEnsureCapacity_real_T(f_cpu_A, k, &nc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(f_cpu_A, &e_gpu_A);
            b_inVectorLength = dv2[0] * dv2[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detr_kernel72<<<grid, block>>>(b_inVectorLength, e_gpu_A);
            }

            npages = cpu_ipiv->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detr_kernel73<<<grid, block>>>(npages, gpu_ipiv);
              ipiv_dirtyOnGpu = true;
            }
          } else {
            npages = cpu_ipiv_t->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detr_kernel71<<<grid, block>>>(gpu_ipiv_t, npages, gpu_ipiv);
              ipiv_dirtyOnGpu = true;
            }
          }

          cpu_d2scaled = 1.0;
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
          }

          cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N, CUBLAS_DIAG_NON_UNIT,
                      1, n + 2, (double *)&cpu_d2scaled, (double *)
                      &e_gpu_A.data[0], n + 2, (double *)&gpu_b.data[0], 1);
          cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                      n + 2, (double *)&cpu_d2scaled, (double *)&e_gpu_A.data[0],
                      n + 2, (double *)&gpu_b.data[0], 1);
          olPct_dirtyOnCpu = true;
          b_dirtyOnCpu = false;
          for (na = 0; na <= n; na++) {
            if (ipiv_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_ipiv, &gpu_ipiv);
            }

            ipiv_dirtyOnGpu = false;
            if (cpu_ipiv->data[n - na] != (n - na) + 1) {
              if (olPct_dirtyOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_b, &gpu_b);
              }

              cpu_d2scaled = cpu_b->data[n - na];
              cpu_b->data[n - na] = cpu_b->data[cpu_ipiv->data[n - na] - 1];
              cpu_b->data[cpu_ipiv->data[n - na] - 1] = cpu_d2scaled;
              b_dirtyOnCpu = true;
              olPct_dirtyOnCpu = false;
            }
          }
        } else {
          ptrdiff_t f_info_t;
          boolean_T b_A_dirtyOnCpu;
          k = g_cpu_A->size[0] * g_cpu_A->size[1];
          g_cpu_A->size[0] = f_cpu_A->size[1];
          g_cpu_A->size[1] = f_cpu_A->size[0];
          emxEnsureCapacity_real_T(g_cpu_A, k, &ic_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(g_cpu_A, &f_gpu_A);
          k = f_cpu_A->size[0] - 1;
          b_inVectorLength = f_cpu_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((b_inVectorLength + 1L) * (k + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detr_kernel60<<<grid, block>>>(e_gpu_A, b_inVectorLength, k,
              f_gpu_A, g_cpu_A->size[0U], f_cpu_A->size[0U]);
            b_A_dirtyOnGpu = true;
          }

          k = cpu_B->size[0];
          cpu_B->size[0] = cpu_b->size[1];
          emxEnsureCapacity_real_T(cpu_B, k, &lc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_B, &b_gpu_B);
          b_inVectorLength = cpu_b->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
            }

            b_dirtyOnCpu = false;
            ec_detr_kernel61<<<grid, block>>>(gpu_b, b_inVectorLength, b_gpu_B);
          }

          b_inVectorLength = g_cpu_A->size[0];
          na = g_cpu_A->size[1] - 1;
          k = cpu_jpvt->size[0] * cpu_jpvt->size[1];
          cpu_jpvt->size[0] = 1;
          cpu_jpvt->size[1] = g_cpu_A->size[1];
          emxEnsureCapacity_int32_T(cpu_jpvt, k, &oc_emlrtRTEI);
          if (!jpvt_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &gpu_jpvt);
          }

          k = g_cpu_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(k + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
            }

            ec_detr_kernel62<<<grid, block>>>(k, gpu_jpvt);
            jpvt_dirtyOnGpu = true;
            jpvt_dirtyOnCpu = false;
          }

          k = g_cpu_A->size[0];
          cpu_nx = g_cpu_A->size[1];
          if (k <= cpu_nx) {
            cpu_nx = k;
          }

          k = b_cpu_tau->size[0];
          b_cpu_tau->size[0] = cpu_nx;
          emxEnsureCapacity_real_T(b_cpu_tau, k, &pc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_tau, &gpu_tau);
          k = jpvt_t->size[0];
          jpvt_t->size[0] = g_cpu_A->size[1];
          emxEnsureCapacity_ptrdiff_t(jpvt_t, k, &qc_emlrtRTEI);
          for (k = 0; k < g_cpu_A->size[1]; k++) {
            jpvt_t->data[k] = (ptrdiff_t)0;
          }

          if (b_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &f_gpu_A);
          }

          if (b_tau_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_tau, &gpu_tau);
          }

          f_info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)g_cpu_A->size[0], (ptrdiff_t)
            g_cpu_A->size[1], &g_cpu_A->data[0], (ptrdiff_t)g_cpu_A->size[0],
            &jpvt_t->data[0], &b_cpu_tau->data[0]);
          olPct_dirtyOnCpu = true;
          b_tau_dirtyOnGpu = false;
          b_A_dirtyOnCpu = true;
          b_A_dirtyOnGpu = false;
          if ((int32_T)f_info_t != 0) {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_inVectorLength * (na + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_A, g_cpu_A);
              ec_detr_kernel63<<<grid, block>>>(b_inVectorLength, na, f_gpu_A,
                g_cpu_A->size[0U]);
              b_A_dirtyOnGpu = true;
              b_A_dirtyOnCpu = false;
            }

            k = g_cpu_A->size[0];
            n = g_cpu_A->size[1];
            if (k <= n) {
              n = k;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n),
              &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, b_cpu_tau);
              ec_detr_kernel64<<<grid, block>>>(n, gpu_tau);
              b_tau_dirtyOnGpu = true;
              olPct_dirtyOnCpu = false;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (computeEndIdx(static_cast<int64_T>(n + 1), static_cast<int64_T>
                             (cpu_nx), 1L) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_nx, &cpu_nx, 4UL, cudaMemcpyHostToDevice);
              if (olPct_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, b_cpu_tau);
              }

              ec_detr_kernel65<<<grid, block>>>(n + 1, gpu_nx, gpu_tau);
              b_tau_dirtyOnGpu = true;
              olPct_dirtyOnCpu = false;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
              }

              ec_detr_kernel66<<<grid, block>>>(na, gpu_jpvt);
              jpvt_dirtyOnGpu = true;
              jpvt_dirtyOnCpu = false;
            }
          } else {
            for (k = 0; k <= na; k++) {
              if (jpvt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &gpu_jpvt);
              }

              cpu_jpvt->data[k] = (int32_T)jpvt_t->data[k];
              jpvt_dirtyOnCpu = true;
              jpvt_dirtyOnGpu = false;
            }
          }

          b_inVectorLength = -1;
          if (g_cpu_A->size[0] < g_cpu_A->size[1]) {
            n = g_cpu_A->size[0];
            npages = g_cpu_A->size[1];
          } else {
            n = g_cpu_A->size[1];
            npages = g_cpu_A->size[0];
          }

          if (b_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &f_gpu_A);
          }

          b_A_dirtyOnGpu = false;
          cpu_d2scaled = std::fmin(1.4901161193847656E-8, 2.2204460492503131E-15
            * static_cast<real_T>(npages)) * std::abs(g_cpu_A->data[0]);
          while ((b_inVectorLength + 1 < n) && (!(std::abs(g_cpu_A->data
                    [(b_inVectorLength + g_cpu_A->size[0] * (b_inVectorLength +
                      1)) + 1]) <= cpu_d2scaled))) {
            b_inVectorLength++;
          }

          npages = g_cpu_A->size[1];
          k = cpu_Y->size[0];
          cpu_Y->size[0] = g_cpu_A->size[1];
          emxEnsureCapacity_real_T(cpu_Y, k, &uc_emlrtRTEI);
          if (!Y_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_Y, &gpu_Y);
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, cpu_Y);
            }

            ec_detr_kernel67<<<grid, block>>>(npages, gpu_Y);
            Y_dirtyOnGpu = true;
            Y_dirtyOnCpu = false;
          }

          cpu_nx = 0;
          k = g_cpu_A->size[0];
          npages = g_cpu_A->size[1];
          if (k <= npages) {
            npages = k;
          }

          if (b_A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_A, g_cpu_A);
          }

          if (olPct_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, b_cpu_tau);
          }

          cusolverDnDormqr_bufferSize(getCuSolverGlobalHandle(),
            CUBLAS_SIDE_LEFT, CUBLAS_OP_T, cpu_B->size[0], 1, npages, (double *)
            &f_gpu_A.data[0], g_cpu_A->size[0], (double *)&gpu_tau.data[0],
            (double *)&b_gpu_B.data[0], cpu_B->size[0], getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(8);
          cusolverInitWorkspace();
          cudaMemcpy(gpu_nx, &cpu_nx, 4UL, cudaMemcpyHostToDevice);
          cusolverDnDormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                           CUBLAS_OP_T, cpu_B->size[0], 1, npages, (double *)
                           &f_gpu_A.data[0], g_cpu_A->size[0], (double *)
                           &gpu_tau.data[0], (double *)&b_gpu_B.data[0],
                           cpu_B->size[0], static_cast<real_T *>
                           (getCuSolverWorkspaceBuff()),
                           *getCuSolverWorkspaceReq(), gpu_nx);
          cudaMemcpy(&cpu_nx, gpu_nx, 4UL, cudaMemcpyDeviceToHost);
          if (cpu_nx < 0) {
            npages = cpu_B->size[0];
            k = cpu_B->size[0];
            cpu_B->size[0] = npages;
            emxEnsureCapacity_real_T(cpu_B, k, &xc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_B, &b_gpu_B);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detr_kernel68<<<grid, block>>>(npages, b_gpu_B);
            }
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
            }

            jpvt_dirtyOnCpu = false;
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, cpu_Y);
            }

            ec_detr_kernel69<<<grid, block>>>(b_gpu_B, gpu_jpvt,
              b_inVectorLength, gpu_Y);
            Y_dirtyOnGpu = true;
            Y_dirtyOnCpu = false;
          }

          for (na = 0; na <= b_inVectorLength; na++) {
            if (Y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_Y, &gpu_Y);
            }

            if (jpvt_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &gpu_jpvt);
            }

            jpvt_dirtyOnGpu = false;
            cpu_Y->data[cpu_jpvt->data[b_inVectorLength - na] - 1] /=
              g_cpu_A->data[(b_inVectorLength - na) + g_cpu_A->size[0] *
              (b_inVectorLength - na)];
            Y_dirtyOnCpu = true;
            Y_dirtyOnGpu = false;
            npages = b_inVectorLength - na;
            for (k = 0; k < npages; k++) {
              cpu_Y->data[cpu_jpvt->data[k] - 1] -= cpu_Y->data[cpu_jpvt->
                data[b_inVectorLength - na] - 1] * g_cpu_A->data[k +
                g_cpu_A->size[0] * (b_inVectorLength - na)];
            }
          }

          k = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_Y->size[0];
          emxEnsureCapacity_real_T(cpu_b, k, &jc_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b);
          }

          b_inVectorLength = cpu_Y->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, cpu_Y);
            }

            Y_dirtyOnCpu = false;
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
            }

            ec_detr_kernel70<<<grid, block>>>(gpu_Y, b_inVectorLength, gpu_b);
            b_dirtyOnCpu = false;
          }
        }

        // 'ec_detr:117' z = r*(V*b') + mn;
        k = b_cpu_B->size[0];
        b_cpu_B->size[0] = cpu_b->size[1];
        emxEnsureCapacity_real_T(b_cpu_B, k, &mc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_B, &gpu_B);
        b_inVectorLength = cpu_b->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
          }

          b_dirtyOnCpu = false;
          ec_detr_kernel75<<<grid, block>>>(gpu_b, b_inVectorLength, gpu_B);
        }

        if ((b_cpu_V->size[0] == 0) || (b_cpu_V->size[1] == 0) || (b_cpu_B->
             size[0] == 0)) {
          k = b_cpu_y->size[0];
          b_cpu_y->size[0] = b_cpu_V->size[0];
          emxEnsureCapacity_real_T(b_cpu_y, k, &r_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y);
          b_inVectorLength = b_cpu_V->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detr_kernel76<<<grid, block>>>(b_inVectorLength, b_gpu_y);
          }
        } else {
          k = b_cpu_y->size[0];
          b_cpu_y->size[0] = b_cpu_V->size[0];
          emxEnsureCapacity_real_T(b_cpu_y, k, &q_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y);
          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      b_cpu_V->size[0], 1, b_cpu_V->size[1], (double *)
                      &cpu_d2scaled, (double *)&b_gpu_V.data[0], b_cpu_V->size[0],
                      (double *)&gpu_B.data[0], b_cpu_V->size[1], (double *)
                      &abnrm, (double *)&b_gpu_y.data[0], b_cpu_V->size[0]);
        }

        if ((cpu_r->size[0] == 0) || (cpu_r->size[1] == 0) || (b_cpu_y->size[0] ==
             0)) {
          k = cpu_dv7->size[0];
          cpu_dv7->size[0] = cpu_r->size[0];
          emxEnsureCapacity_real_T(cpu_dv7, k, &rc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_dv7, &gpu_dv7);
          b_inVectorLength = cpu_r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detr_kernel77<<<grid, block>>>(b_inVectorLength, gpu_dv7);
            dv7_dirtyOnGpu = true;
          }
        } else {
          k = cpu_dv7->size[0];
          cpu_dv7->size[0] = cpu_r->size[0];
          emxEnsureCapacity_real_T(cpu_dv7, k, &q_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_dv7, &gpu_dv7);
          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          if (r_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, cpu_r);
          }

          r_dirtyOnCpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      cpu_r->size[0], 1, cpu_r->size[1], (double *)&cpu_d2scaled,
                      (double *)&gpu_r.data[0], cpu_r->size[0], (double *)
                      &b_gpu_y.data[0], cpu_r->size[1], (double *)&abnrm,
                      (double *)&gpu_dv7.data[0], cpu_r->size[0]);
          dv7_dirtyOnGpu = true;
        }

        if (cpu_dv7->size[0] == cpu_dv1->size[0]) {
          k = cpu_z->size[0];
          cpu_z->size[0] = cpu_dv7->size[0];
          emxEnsureCapacity_real_T(cpu_z, k, &sc_emlrtRTEI);
          if (!z_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z);
          }

          b_inVectorLength = cpu_dv7->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, cpu_z);
            }

            ec_detr_kernel78<<<grid, block>>>(mn, gpu_dv1, gpu_dv7,
              b_inVectorLength, gpu_z);
            z_dirtyOnGpu = true;
            z_dirtyOnCpu = false;
          }
        } else {
          if (z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_z, &gpu_z);
          }

          if (dv7_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv7, &gpu_dv7);
          }

          dv7_dirtyOnGpu = false;
          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          binary_expand_op(cpu_z, cpu_dv7, cpu_dv1, mn);
          z_dirtyOnCpu = true;
          z_dirtyOnGpu = false;
        }

        //  Find outliers
        // 'ec_detr:86' d = (x-z).*w;
        if (cpu_dv1->size[0] == 1) {
          b_inVectorLength = cpu_z->size[0];
        } else {
          b_inVectorLength = cpu_dv1->size[0];
        }

        if ((cpu_dv1->size[0] == cpu_z->size[0]) && (b_inVectorLength ==
             cpu_dv2->size[0])) {
          k = b_cpu_d->size[0];
          b_cpu_d->size[0] = cpu_dv1->size[0];
          emxEnsureCapacity_real_T(b_cpu_d, k, &tc_emlrtRTEI);
          if (!b_d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real_T(b_cpu_d, &gpu_d);
          }

          b_inVectorLength = cpu_dv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, cpu_z);
            }

            z_dirtyOnCpu = false;
            if (b_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, b_cpu_d);
            }

            ec_detr_kernel79<<<grid, block>>>(gpu_dv2, gpu_z, gpu_dv1,
              b_inVectorLength, gpu_d);
            b_d_dirtyOnGpu = true;
            b_d_dirtyOnCpu = false;
          }
        } else {
          if (b_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_d, &gpu_d);
          }

          if (dv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }

          dv1_dirtyOnGpu = false;
          if (z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_z, &gpu_z);
          }

          z_dirtyOnGpu = false;
          if (dv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv2, &gpu_dv2);
          }

          dv2_dirtyOnGpu = false;
          binary_expand_op(b_cpu_d, cpu_dv1, cpu_z, cpu_dv2);
          b_d_dirtyOnCpu = true;
          b_d_dirtyOnGpu = false;
        }

        // 'ec_detr:87' thrItr = iThr*std(d);
        n = b_cpu_d->size[0] - 1;
        if (b_cpu_d->size[0] == 0) {
          cpu_d2scaled = rtNaN;
        } else if (b_cpu_d->size[0] == 1) {
          if (b_d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, b_cpu_d);
          }

          b_d_dirtyOnCpu = false;
          cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 8UL, cudaMemcpyHostToDevice);
          ec_detr_kernel82<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_d,
            gpu_d2scaled);
          d2scaled_dirtyOnCpu = false;
        } else {
          if (b_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_d, &gpu_d);
          }

          b_d_dirtyOnGpu = false;
          cpu_d2scaled = b_cpu_d->data[0];
          for (k = 0; k < n; k++) {
            cpu_d2scaled += b_cpu_d->data[k + 1];
          }

          cpu_d2scaled /= static_cast<real_T>(b_cpu_d->size[0]);
          k = cpu_absdiff->size[0];
          cpu_absdiff->size[0] = b_cpu_d->size[0];
          emxEnsureCapacity_real_T(cpu_absdiff, k, &vc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_absdiff, &gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 8UL, cudaMemcpyHostToDevice);
            if (b_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, b_cpu_d);
            }

            b_d_dirtyOnCpu = false;
            ec_detr_kernel80<<<grid, block>>>(gpu_d2scaled, gpu_d, n,
              gpu_absdiff);
          }

          cublasDnrm2(getCublasGlobalHandle(), b_cpu_d->size[0], (double *)
                      &gpu_absdiff.data[0], 1, (double *)&cpu_d2scaled);
          if (b_d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, b_cpu_d);
          }

          b_d_dirtyOnCpu = false;
          cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 8UL, cudaMemcpyHostToDevice);
          ec_detr_kernel81<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_d2scaled,
            b_cpu_d->size[0U]);
          d2scaled_dirtyOnCpu = false;
        }

        if (d2scaled_dirtyOnCpu) {
          cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 8UL, cudaMemcpyHostToDevice);
        }

        ec_detr_kernel83<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*b_gpu_out_data, ii, gpu_d2scaled);

        // 'ec_detr:88' w(abs(d)>thrItr) = 0;
        cpu_nx = b_cpu_d->size[0];
        k = c_cpu_y->size[0];
        c_cpu_y->size[0] = b_cpu_d->size[0];
        emxEnsureCapacity_real_T(c_cpu_y, k, &wc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_cpu_y, &c_gpu_y);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(cpu_nx),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, b_cpu_d);
          }

          b_d_dirtyOnCpu = false;
          cudaMemcpy(gpu_nx, &cpu_nx, 4UL, cudaMemcpyHostToDevice);
          ec_detr_kernel84<<<grid, block>>>(gpu_d, gpu_nx, c_gpu_y);
        }

        n = c_cpu_y->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detr_kernel85<<<grid, block>>>(gpu_d2scaled, c_gpu_y, n, gpu_dv2);
          dv2_dirtyOnGpu = true;
        }

        //  update weights
      }

      //  Remove trends
      // 'ec_detr:92' x = x-z;
      k = cpu_x->size[0];
      if (k == cpu_z->size[0]) {
        npages = f_cpu_x->size[0];
        f_cpu_x->size[0] = k;
        emxEnsureCapacity_real_T(f_cpu_x, npages, &i_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_cpu_x, &e_gpu_x);
        b_inVectorLength = cpu_x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (z_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, cpu_z);
          }

          z_dirtyOnCpu = false;
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
          }

          x_dirtyOnCpu = false;
          ec_detr_kernel86<<<grid, block>>>(gpu_z, ch, gpu_x, b_inVectorLength,
            e_gpu_x, cpu_x->size[0U]);
        }

        b_inVectorLength = f_cpu_x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
          }

          ec_detr_kernel87<<<grid, block>>>(e_gpu_x, ch, b_inVectorLength, gpu_x,
            cpu_x->size[0U]);
          x_dirtyOnGpu = true;
          x_dirtyOnCpu = false;
        }
      } else {
        if (x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_x, &gpu_x);
        }

        if (z_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_z, &gpu_z);
        }

        z_dirtyOnGpu = false;
        binary_expand_op(cpu_x, ch, cpu_z);
        x_dirtyOnCpu = true;
        x_dirtyOnGpu = false;
      }

      b_inVectorLength = cpu_dv2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (w_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, cpu_w);
        }

        ec_detr_kernel88<<<grid, block>>>(gpu_dv2, ch, b_inVectorLength, gpu_w,
          cpu_w->size[0U]);
        w_dirtyOnGpu = true;
        w_dirtyOnCpu = false;
      }

      //  Detrend
      // 'ec_detr:42' olPct(ch,ii) = sum(~w(:,ch));
      k = b_cpu_x->size[0];
      b_cpu_x->size[0] = cpu_w->size[0];
      emxEnsureCapacity_boolean_T(b_cpu_x, k, &j_emlrtRTEI);
      gpuEmxEnsureCapacity_boolean_T(b_cpu_x, &f_gpu_x);
      b_inVectorLength = cpu_w->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (w_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, cpu_w);
        }

        w_dirtyOnCpu = false;
        ec_detr_kernel89<<<grid, block>>>(ch, gpu_w, b_inVectorLength, f_gpu_x,
          cpu_w->size[0U]);
        b_x_dirtyOnGpu = true;
      }

      cpu_nx = b_cpu_x->size[0];
      if (b_cpu_x->size[0] == 0) {
        npages = 0;
      } else {
        if (b_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_boolean_T(b_cpu_x, &f_gpu_x);
        }

        b_x_dirtyOnGpu = false;
        npages = b_cpu_x->data[0];
        for (k = 0; k <= cpu_nx - 2; k++) {
          npages += b_cpu_x->data[k + 1];
        }
      }

      cpu_olPct->data[ch + cpu_olPct->size[0] * ii] = npages;
      olPct_dirtyOnCpu = true;

      //  Outlier percentages
    }
  }

  emxFree_real_T(&c_cpu_V);
  emxFree_real_T(&f_cpu_x);
  emxFree_real_T(&c_cpu_y);
  emxFree_real_T(&cpu_absdiff);
  emxFree_real_T(&b_cpu_d);
  emxFree_real_T(&cpu_dv7);
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_real_T(&b_cpu_y);
  emxFree_real_T(&b_cpu_tau);
  emxFree_int32_T(&cpu_ipiv_t);
  emxFree_int32_T(&cpu_jpvt);
  emxFree_real_T(&b_cpu_B);
  emxFree_int32_T(&cpu_ipiv);
  emxFree_real_T(&cpu_B);
  emxFree_real_T(&wi);
  emxFree_real_T(&g_cpu_A);
  emxFree_real_T(&cpu_Y);
  emxFree_real_T(&wr);
  emxFree_real_T(&f_cpu_A);
  emxFree_real_T(&cpu_vright);
  emxFree_real_T(&cpu_wimag);
  emxFree_real_T(&e_cpu_A);
  emxFree_real_T(&cpu_tau);
  emxFree_real_T(&cpu_wreal);
  emxFree_real_T(&cpu_b);
  emxFree_creal_T(&b_cpu_W);
  emxFree_real_T(&cpu_U);
  emxFree_real_T(&d_cpu_A);
  emxFree_real_T(&scale);
  emxFree_real_T(&c_cpu_A);
  emxFree_real_T(&cpu_W);
  emxFree_int32_T(&cpu_iv);
  emxFree_creal_T(&cpu_d);
  emxFree_real_T(&b_cpu_V);
  emxFree_creal_T(&cpu_D);
  emxFree_creal_T(&cpu_V);
  emxFree_real_T(&b_cpu_A);
  emxFree_real_T(&cpu_A);
  emxFree_real_T(&cpu_rr);
  emxFree_real_T(&cpu_r);
  emxFree_real_T(&e_cpu_x);
  emxFree_real_T(&cpu_y);
  emxFree_real_T(&cpu_dv3);
  emxFree_real_T(&d_cpu_x);
  emxFree_real_T(&c_cpu_x);
  emxFree_boolean_T(&b_cpu_x);
  emxFree_real_T(&cpu_z);
  emxFree_real_T(&cpu_dv2);
  emxFree_real_T(&cpu_dv1);
  emxFree_real_T(&cpu_lin);
  emxFree_real_T(&cpu_regs);

  //  Sum outliers across chans
  // 'ec_detr:47' olPct = sum(olPct,1,"omitnan");
  cpu_nx = cpu_olPct->size[0];
  if ((cpu_olPct->size[0] == 0) || (cpu_olPct->size[1] == 0)) {
    sz[1] = static_cast<int16_T>(cpu_olPct->size[1]);
    olPct_size[0] = 1;
    olPct_size[1] = sz[1];
    b_inVectorLength = sz[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      ec_detr_kernel91<<<grid, block>>>(sz[1] - 1, gpu_olPct_data);
      olPct_data_dirtyOnGpu = true;
    }
  } else {
    npages = cpu_olPct->size[1];
    olPct_size[0] = 1;
    olPct_size[1] = cpu_olPct->size[1];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_nx, &cpu_nx, 4UL, cudaMemcpyHostToDevice);
      if (olPct_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_olPct, cpu_olPct);
      }

      ec_detr_kernel90<<<grid, block>>>(gpu_nx, gpu_olPct, npages,
        gpu_olPct_data, cpu_olPct->size[0U]);
      olPct_data_dirtyOnGpu = true;
    }
  }

  emxFree_int32_T(&cpu_olPct);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_x, &gpu_x);
  }

  if (w_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_w, &gpu_w);
  }

  if (olPct_data_dirtyOnGpu) {
    cudaMemcpy(cpu_olPct_data, gpu_olPct_data, static_cast<uint32_T>(olPct_size
                [1]) * sizeof(real_T), cudaMemcpyDeviceToHost);
  }

  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_w);
  mwCudaFree(gpu_ord_data);
  mwCudaFree(gpu_thr_data);
  mwCudaFree(gpu_itr_data);
  mwCudaFree(gpu_olPct_data);
  mwCudaFree(gpu_dc);
  mwCudaFree(*gpu_out_data);
  mwCudaFree(*b_gpu_out_data);
  mwCudaFree(*c_gpu_out_data);
  gpuEmxFree_int32_T(&gpu_olPct);
  gpuEmxFree_real_T(&gpu_regs);
  gpuEmxFree_real_T(&gpu_lin);
  gpuEmxFree_real_T(&gpu_dv1);
  gpuEmxFree_real_T(&gpu_dv2);
  gpuEmxFree_real_T(&gpu_z);
  gpuEmxFree_boolean_T(&f_gpu_x);
  gpuEmxFree_real_T(&b_gpu_x);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_real_T(&gpu_dv3);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_real_T(&d_gpu_x);
  gpuEmxFree_real_T(&gpu_r);
  gpuEmxFree_real_T(&gpu_rr);
  gpuEmxFree_real_T(&b_gpu_A);
  gpuEmxFree_real_T(&gpu_A);
  gpuEmxFree_creal_T(&gpu_V);
  gpuEmxFree_creal_T(&gpu_D);
  gpuEmxFree_real_T(&b_gpu_V);
  gpuEmxFree_creal_T(&b_gpu_d);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_real_T(&gpu_W);
  gpuEmxFree_real_T(&g_gpu_A);
  gpuEmxFree_real_T(&c_gpu_A);
  gpuEmxFree_real_T(&gpu_U);
  gpuEmxFree_creal_T(&b_gpu_W);
  gpuEmxFree_real_T(&gpu_b);
  gpuEmxFree_real_T(&gpu_wreal);
  gpuEmxFree_real_T(&b_gpu_tau);
  gpuEmxFree_real_T(&d_gpu_A);
  gpuEmxFree_real_T(&gpu_wimag);
  gpuEmxFree_real_T(&gpu_vright);
  gpuEmxFree_real_T(&e_gpu_A);
  gpuEmxFree_real_T(&gpu_Y);
  gpuEmxFree_real_T(&f_gpu_A);
  gpuEmxFree_real_T(&b_gpu_B);
  gpuEmxFree_int32_T(&gpu_ipiv);
  gpuEmxFree_real_T(&gpu_B);
  gpuEmxFree_int32_T(&gpu_jpvt);
  gpuEmxFree_int32_T(&gpu_ipiv_t);
  gpuEmxFree_real_T(&gpu_tau);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&gpu_dv7);
  gpuEmxFree_real_T(&gpu_d);
  gpuEmxFree_real_T(&gpu_absdiff);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&e_gpu_x);
  gpuEmxFree_real_T(&c_gpu_V);
  mwCudaFree(gpu_d2scaled);
  mwCudaFree(gpu_nx);
  mwCudaFree(gpu_i5);
  mwCudaFree(gpu_info);
}

void ec_detr_api(const mxArray * const prhs[5], int32_T nlhs, const mxArray
                 *plhs[3])
{
  emxArray_real_T *w;
  emxArray_real_T *x;
  const mxArray *prhs_copy_idx_0;
  const mxArray *prhs_copy_idx_1;
  real_T (*itr_data)[99];
  real_T (*olPct_data)[99];
  real_T (*ord_data)[99];
  real_T (*thr_data)[99];
  int32_T itr_size[2];
  int32_T olPct_size[2];
  int32_T ord_size[2];
  int32_T thr_size[2];
  olPct_data = (real_T (*)[99])mxMalloc(sizeof(real_T [99]));
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
  *(real_T **)&ord_data = emlrt_marshallIn(emlrtAlias(prhs[2]), "ord", ord_size);
  *(real_T **)&thr_data = emlrt_marshallIn(emlrtAlias(prhs[3]), "thr", thr_size);
  *(real_T **)&itr_data = emlrt_marshallIn(emlrtAlias(prhs[4]), "itr", itr_size);

  // Invoke the target function
  ec_detr(x, w, *ord_data, ord_size, *thr_data, thr_size, *itr_data, itr_size,
          *olPct_data, olPct_size);

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
    plhs[2] = emlrt_marshallOut(*olPct_data, olPct_size);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ec_detr_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  cusolverDestroyWorkspace();
  cusolverEnsureDestruction();
}

void ec_detr_initialize()
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
    ec_detr_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ec_detr_terminate()
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

// End of code generation (ec_detr.cu)