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
#include "MWErrorCodeUtils.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "lapacke.h"
#include "math_constants.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdlib>
#include <cstring>

// Type Definitions
struct emxArray_real_T
{
  real_T *data;
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

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{ nullptr };

emlrtContext emlrtContextGlobal{ true, // bFirstTime
  false,                               // bInitialized
  131643U,                             // fVersionInfo
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

static emlrtRTEInfo b_emlrtRTEI{ 181,  // lineNo
  24,                                  // colNo
  "combineVectorElements",             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 58,   // lineNo
  23,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 49,   // lineNo
  20,                                  // colNo
  "linspace",                          // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/linspace.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 41,   // lineNo
  41,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 41,   // lineNo
  49,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 80,   // lineNo
  20,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 42,   // lineNo
  28,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 124,  // lineNo
  10,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 108,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "sum",                               // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/sum.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 109,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 110,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 44,   // lineNo
  36,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 158,  // lineNo
  24,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 94,   // lineNo
  5,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 56,   // lineNo
  24,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 60,   // lineNo
  28,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 112,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 85,   // lineNo
  9,                                   // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 109,  // lineNo
  24,                                  // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 47,   // lineNo
  20,                                  // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 100,  // lineNo
  5,                                   // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 99,   // lineNo
  24,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 102,  // lineNo
  21,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 28,  // lineNo
  9,                                   // colNo
  "eigHermitianStandard",              // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/private/eigHermitianStandard.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 89,  // lineNo
  13,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 76,  // lineNo
  22,                                  // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 62,  // lineNo
  9,                                   // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 106, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 42,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 1,   // lineNo
  24,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 131, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 69,  // lineNo
  13,                                  // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 132, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 33,  // lineNo
  5,                                   // colNo
  "eigHermitianStandard",              // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/private/eigHermitianStandard.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 63,  // lineNo
  9,                                   // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 86,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 134, // lineNo
  35,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 114, // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 111, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 46,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 114, // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 87,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 112, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 160, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 168, // lineNo
  16,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 23,  // lineNo
  9,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 140, // lineNo
  5,                                   // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 129, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 161, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 27,  // lineNo
  13,                                  // colNo
  "eigStandard",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/private/eigStandard.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 24,  // lineNo
  9,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 130, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 18,  // lineNo
  29,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 44,  // lineNo
  32,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 116, // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 50,  // lineNo
  31,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 44,  // lineNo
  35,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 44,  // lineNo
  48,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 53,  // lineNo
  13,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 61,  // lineNo
  9,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 92,  // lineNo
  22,                                  // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 105, // lineNo
  1,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 117, // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 83,  // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 86,  // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 85,  // lineNo
  1,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 126, // lineNo
  34,                                  // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 30,  // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 119, // lineNo
  5,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 37,  // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 59,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 80,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 108, // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 124, // lineNo
  6,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 83,  // lineNo
  22,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 111, // lineNo
  2,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 113, // lineNo
  10,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo ed_emlrtRTEI{ 114, // lineNo
  9,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo fd_emlrtRTEI{ 94,  // lineNo
  9,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo gd_emlrtRTEI{ 99,  // lineNo
  1,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo hd_emlrtRTEI{ 131, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo id_emlrtRTEI{ 132, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo jd_emlrtRTEI{ 134, // lineNo
  10,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo kd_emlrtRTEI{ 111, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ld_emlrtRTEI{ 112, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo md_emlrtRTEI{ 44,  // lineNo
  9,                                   // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo nd_emlrtRTEI{ 18,  // lineNo
  5,                                   // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo od_emlrtRTEI{ 117, // lineNo
  8,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo pd_emlrtRTEI{ 126, // lineNo
  9,                                   // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo qd_emlrtRTEI{ 88,  // lineNo
  7,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo rd_emlrtRTEI{ 41,  // lineNo
  10,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real32_T *ret);
static real32_T *b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, int32_T ret_size[2]);
static void b_raiseCudaError(int32_T errCode, const char_T *file, uint32_T
  b_line, const char_T *errorName, const char_T *errorString);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4);
static void binary_expand_op_1(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, real32_T in4);
static void binary_expand_op_2(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3);
static void binary_expand_op_4(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, real32_T in3, const emxArray_real32_T *in4);
static void binary_expand_op_5(emxArray_real32_T *in1, int32_T in2, const
  emxArray_real32_T *in3);
static void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T
  b_line);
static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static uint64_T computeNumIters(int32_T ub);
static uint64_T computeNumIters(int64_T ub);
static uint64_T computeNumIters(int32_T ub, int32_T b_ub);
static void cublasCheck(cublasStatus_t errCode, const char_T *file, uint32_T
  b_line);
static void cusolverCheck(cusolverStatus_t errCode, const char_T *file, uint32_T
  b_line);
static __global__ void ec_detr_kernel1(const int32_T nFrames, emxArray_real_T
  lin);
static __global__ void ec_detr_kernel10(const emxArray_real32_T fv2, const
  real32_T mn, const emxArray_real32_T fv1, const int32_T b_fv1,
  emxArray_real32_T fv3);
static __global__ void ec_detr_kernel11(const emxArray_real32_T fv2, const
  emxArray_real32_T regs, const int32_T b_regs, const int32_T c_regs,
  emxArray_real32_T x, int32_T x_dim0, int32_T regs_dim0);
static __global__ void ec_detr_kernel12(const int32_T sz, emxArray_real32_T y);
static __global__ void ec_detr_kernel13(const real32_T mn, const
  emxArray_real32_T y, const emxArray_real32_T regs, const int32_T b_regs, const
  int32_T c_regs, emxArray_real32_T r, int32_T r_dim0, int32_T regs_dim0);
static __global__ void ec_detr_kernel14(const emxArray_real32_T fv2, const
  emxArray_real32_T r, const int32_T b_r, const int32_T c_r, emxArray_real32_T
  rr, int32_T rr_dim0, int32_T r_dim0);
static __global__ void ec_detr_kernel15(const emxArray_real32_T rr, const
  int32_T b_rr, const int32_T c_rr, emxArray_real32_T A, int32_T A_dim0, int32_T
  rr_dim0);
static __global__ void ec_detr_kernel16(const int32_T A, emxArray_real32_T b_A);
static __global__ void ec_detr_kernel17(const creal32_T fc, const int32_T fv2,
  emxArray_creal32_T V);
static __global__ void ec_detr_kernel18(const int32_T fv2, emxArray_creal32_T D);
static __global__ void ec_detr_kernel19(const emxArray_creal32_T V, const
  int32_T b_V, emxArray_real32_T c_V);
static __global__ void ec_detr_kernel2(emxArray_real_T lin);
static __global__ void ec_detr_kernel20(const emxArray_int32_T iv, const
  emxArray_real32_T V, const int32_T b, const int32_T b_iv, emxArray_real32_T
  b_V, int32_T V_dim0, int32_T b_V_dim0);
static __global__ void ec_detr_kernel21(const emxArray_real32_T V, const int32_T
  b_V, emxArray_real32_T c_V);
static __global__ void ec_detr_kernel22(const int32_T rr, emxArray_real32_T C);
static __global__ void ec_detr_kernel23(const emxArray_real32_T fv3, const
  int32_T b_fv3, emxArray_real32_T A);
static __global__ void ec_detr_kernel24(const int32_T C, emxArray_real32_T b);
static __global__ void ec_detr_kernel25(const emxArray_real32_T C, const int32_T
  b_C, const int32_T c_C, emxArray_real32_T A, int32_T A_dim0, int32_T C_dim0);
static __global__ void ec_detr_kernel26(const int32_T A, emxArray_real32_T b_A);
static __global__ void ec_detr_kernel27(const int32_T sz, emxArray_real32_T b);
static __global__ void ec_detr_kernel28(const emxArray_real32_T b, const int32_T
  b_b, emxArray_real32_T B);
static __global__ void ec_detr_kernel29(const int32_T V, emxArray_real32_T y);
static __global__ void ec_detr_kernel3(const real_T d2scaled, const int32_T b,
  emxArray_real_T lin, int32_T lin_dim1);
static __global__ void ec_detr_kernel30(const int32_T r, emxArray_real32_T fv4);
static __global__ void ec_detr_kernel31(const real32_T mn, const
  emxArray_real32_T fv1, const emxArray_real32_T fv4, const int32_T b_fv4,
  emxArray_real32_T z);
static __global__ void ec_detr_kernel32(const emxArray_real32_T fv2, const
  emxArray_real32_T z, const emxArray_real32_T fv1, const int32_T b_fv1,
  emxArray_real32_T d);
static __global__ void ec_detr_kernel33(const emxArray_real32_T d, const int32_T
  b, emxArray_real32_T y);
static __global__ void ec_detr_kernel34(const real32_T mn, const
  emxArray_real32_T y, const int32_T n, emxArray_real32_T fv2);
static __global__ void ec_detr_kernel35(const emxArray_real32_T d, real32_T *mn);
static __global__ void ec_detr_kernel36(const real32_T mn, const
  emxArray_real32_T d, const int32_T n, emxArray_real32_T absdiff);
static __global__ void ec_detr_kernel37(const int32_T fv2, emxArray_real32_T A);
static __global__ void ec_detr_kernel38(const int32_T n, emxArray_int32_T ipiv);
static __global__ void ec_detr_kernel39(const emxArray_int32_T ipiv_t, const
  int32_T n, emxArray_int32_T ipiv);
static __global__ void ec_detr_kernel4(emxArray_real_T lin, int32_T lin_dim1);
static __global__ void ec_detr_kernel40(const emxArray_real32_T A, const int32_T
  b_A, const int32_T c_A, emxArray_real32_T d_A, int32_T A_dim0, int32_T
  b_A_dim0);
static __global__ void ec_detr_kernel41(const emxArray_real32_T b, const int32_T
  b_b, emxArray_real32_T B);
static __global__ void ec_detr_kernel42(const int32_T A, emxArray_int32_T jpvt);
static __global__ void ec_detr_kernel43(const int32_T b, const int32_T n,
  emxArray_real32_T A, int32_T A_dim0);
static __global__ void ec_detr_kernel44(const int32_T b, emxArray_real32_T tau);
static __global__ void ec_detr_kernel45(const int32_T j, const int64_T b,
  emxArray_real32_T tau);
static __global__ void ec_detr_kernel46(const int32_T n, emxArray_int32_T jpvt);
static __global__ void ec_detr_kernel47(const int32_T A, emxArray_real32_T Y);
static __global__ void ec_detr_kernel48(const int32_T b, emxArray_real32_T B);
static __global__ void ec_detr_kernel49(const emxArray_real32_T B, const
  emxArray_int32_T jpvt, const int32_T n, emxArray_real32_T Y);
static __global__ void ec_detr_kernel5(const int32_T m, const emxArray_real_T
  lin, const int32_T npages, const int32_T b, emxArray_real32_T regs, int32_T
  regs_dim0);
static __global__ void ec_detr_kernel50(const emxArray_real32_T Y, const int32_T
  b_Y, emxArray_real32_T b);
static __global__ void ec_detr_kernel51(const emxArray_creal32_T D, const
  int32_T n, emxArray_creal32_T d, int32_T D_dim0);
static __global__ void ec_detr_kernel52(const int32_T b, emxArray_real32_T W);
static __global__ void ec_detr_kernel53(const int32_T fv2, emxArray_real32_T A);
static __global__ void ec_detr_kernel54(const int32_T b, emxArray_creal32_T D);
static __global__ void ec_detr_kernel55(const emxArray_real32_T A, const int32_T
  b_A, emxArray_creal32_T V);
static __global__ void ec_detr_kernel56(const int32_T sz, emxArray_real32_T U);
static __global__ void ec_detr_kernel57(const int32_T nx, const int32_T npages,
  const int64_T b, emxArray_real32_T U, int32_T U_dim0);
static __global__ void ec_detr_kernel58(const int32_T sz, emxArray_real32_T A);
static __global__ void ec_detr_kernel59(const int32_T A, emxArray_creal32_T D);
static __global__ void ec_detr_kernel6(const int32_T ch, const emxArray_real32_T
  x, const int32_T b_x, emxArray_real32_T fv1, int32_T x_dim0);
static __global__ void ec_detr_kernel60(const emxArray_real32_T U, const int32_T
  b_U, emxArray_creal32_T V);
static __global__ void ec_detr_kernel61(const int32_T fv2, emxArray_real32_T A);
static __global__ void ec_detr_kernel62(const int32_T b, emxArray_real32_T tau);
static __global__ void ec_detr_kernel63(const emxArray_real32_T A, const int32_T
  b_A, emxArray_real32_T U);
static __global__ void ec_detr_kernel64(emxArray_real32_T U);
static __global__ void ec_detr_kernel65(const int32_T fv2, emxArray_real32_T A);
static __global__ void ec_detr_kernel66(const int32_T fv2, emxArray_real32_T U);
static __global__ void ec_detr_kernel67(const int32_T fv2, emxArray_real32_T U);
static __global__ void ec_detr_kernel68(const creal32_T fc, const int32_T A,
  emxArray_creal32_T W);
static __global__ void ec_detr_kernel69(const creal32_T fc, const int32_T fv2,
  emxArray_creal32_T V);
static __global__ void ec_detr_kernel7(const int32_T ch, const emxArray_real32_T
  w, const int32_T b_w, emxArray_real32_T fv2, int32_T w_dim0);
static __global__ void ec_detr_kernel70(const int32_T A, emxArray_creal32_T D);
static __global__ void ec_detr_kernel71(const emxArray_real32_T wimag, const
  emxArray_real32_T wreal, const int32_T n, emxArray_creal32_T W);
static __global__ void ec_detr_kernel72(const emxArray_real32_T vright, const
  int32_T b_vright, emxArray_creal32_T V);
static __global__ void ec_detr_kernel73(const int32_T npages, const int32_T n,
  emxArray_creal32_T V, int32_T V_dim0);
static __global__ void ec_detr_kernel74(const int32_T nx, const
  emxArray_real32_T x, const int32_T b, emxArray_real32_T y, int32_T x_dim0);
static __global__ void ec_detr_kernel75(const emxArray_real32_T z, const int32_T
  ch, const int32_T b, emxArray_real32_T x, int32_T x_dim0);
static __global__ void ec_detr_kernel76(const emxArray_real32_T fv2, const
  int32_T ch, const int32_T b, emxArray_real32_T w, int32_T w_dim0);
static __global__ void ec_detr_kernel77(const int32_T ch, const
  emxArray_real32_T w, const int32_T b_w, emxArray_boolean_T x, int32_T w_dim0);
static __global__ void ec_detr_kernel78(const int32_T n, const int32_T ii, const
  int32_T ch, int32_T olPct_data[6487866], int32_T olPct_size_dim0);
static __global__ void ec_detr_kernel79(const int32_T sz, real_T olPct_data[]);
static __global__ void ec_detr_kernel8(const emxArray_real32_T fv2, const
  emxArray_real32_T fv1, const int32_T b_fv1, emxArray_real32_T x);
static __global__ void ec_detr_kernel80(const int32_T nx, const int32_T
  olPct_data[6487866], const int32_T olPct_size_dim0, const int32_T b, real_T
  b_olPct_data[]);
static __global__ void ec_detr_kernel9(const emxArray_real32_T fv2, const
  emxArray_real32_T fv1, const int32_T b_fv1, emxArray_real32_T x);
static void emlrtExitTimeCleanupDtorFcn(const void *r);
static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
  emxArray_real32_T *y);
static real32_T *emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, int32_T y_size[2]);
static real32_T *emlrt_marshallIn(const mxArray *b_nullptr, const char_T
  *identifier, int32_T y_size[2]);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y);
static const mxArray *emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[2]);
static void emlrt_marshallOut(const emxArray_real32_T *u, const mxArray *y);
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
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxFree_boolean_T(emxArray_boolean_T **pEmxArray);
static void emxFree_creal32_T(emxArray_creal32_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray);
static void emxFree_real32_T(emxArray_real32_T **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
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
static void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void gpuEmxEnsureCapacity_boolean_T(const emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
  emxArray_creal32_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
  emxArray_real32_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu, boolean_T needsCopy);
static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
static void gpuEmxFree_real32_T(emxArray_real32_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu, const
  emxArray_creal32_T *cpu);
static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu, const
  emxArray_int32_T *cpu);
static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu, const
  emxArray_real32_T *cpu);
static void gpuEmxMemcpyGpuToCpu_boolean_T(emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu);
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
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
  const char_T *errorName, const char_T *errorString);
static void times(emxArray_real32_T *in1, const emxArray_real32_T *in2, const
                  emxArray_real32_T *in3);

// Function Definitions
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

static real32_T *b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, int32_T ret_size[2])
{
  static const int32_T dims[2]{ 1, 99 };

  int32_T iv[2];
  real32_T *ret_data;
  boolean_T bv[2]{ false, true };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single", false, 2U,
    (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_data = static_cast<real32_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret_data;
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
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4)
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

  emxEnsureCapacity_real32_T(in1, i, &qc_emlrtRTEI);
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

static void binary_expand_op_1(emxArray_real32_T *in1, const emxArray_real32_T
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

  emxEnsureCapacity_real32_T(in1, i, &pc_emlrtRTEI);
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

static void binary_expand_op_2(emxArray_real32_T *in1, const emxArray_real32_T
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
  emxEnsureCapacity_real32_T(in1, i, &m_emlrtRTEI);
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

static void binary_expand_op_4(emxArray_real32_T *in1, const emxArray_real32_T
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

  emxEnsureCapacity_real32_T(in1, i, &j_emlrtRTEI);
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

static void binary_expand_op_5(emxArray_real32_T *in1, int32_T in2, const
  emxArray_real32_T *in3)
{
  emxArray_real32_T *b_in1;
  int32_T i;
  int32_T in1_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  in1_idx_0 = in1->size[0];
  emxInit_real32_T(&b_in1, 1, &rd_emlrtRTEI, true);
  i = b_in1->size[0];
  b_in1->size[0] = in1_idx_0;
  emxEnsureCapacity_real32_T(b_in1, i, &rd_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  for (i = 0; i < in1_idx_0; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0 + in1->size[0] * in2] - in3->
      data[i * stride_1_0];
  }

  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i + in1->size[0] * in2] = b_in1->data[i];
  }

  emxFree_real32_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
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

static uint64_T computeNumIters(int64_T ub)
{
  uint64_T numIters;
  numIters = 0UL;
  if (ub >= 0L) {
    numIters = static_cast<uint64_T>(ub + 1L);
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

static uint64_T computeNumIters(int32_T ub)
{
  uint64_T numIters;
  numIters = 0UL;
  if (ub >= 0) {
    numIters = static_cast<uint64_T>(ub + 1);
  }

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

static void cusolverCheck(cusolverStatus_t errCode, const char_T *file, uint32_T
  b_line)
{
  const char *errName;
  const char *errString;
  if (errCode != CUSOLVER_STATUS_SUCCESS) {
    cusolverGetErrorName(errCode, &errName);
    cusolverGetErrorString(errCode, &errString);
    raiseCudaError(errCode, file, b_line, errName, errString);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel1(const int32_T
  nFrames, emxArray_real_T lin)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    lin.data[nFrames - 1] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel10(const
  emxArray_real32_T fv2, const real32_T mn, const emxArray_real32_T fv1, const
  int32_T b_fv1, emxArray_real32_T fv3)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv3.data[i] = (fv1.data[i] - mn) * fv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel11(const
  emxArray_real32_T fv2, const emxArray_real32_T regs, const int32_T b_regs,
  const int32_T c_regs, emxArray_real32_T x, int32_T x_dim0, int32_T regs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_regs) + 1UL) * (static_cast<uint64_T>
    (b_regs) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_regs) +
      1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_regs) + 1UL));
    x.data[xpageoffset + x_dim0 * i] = regs.data[xpageoffset + regs_dim0 * i] *
      fv2.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel12(const int32_T
  sz, emxArray_real32_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel13(const
  real32_T mn, const emxArray_real32_T y, const emxArray_real32_T regs, const
  int32_T b_regs, const int32_T c_regs, emxArray_real32_T r, int32_T r_dim0,
  int32_T regs_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_regs) + 1UL) * (static_cast<uint64_T>
    (b_regs) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_regs) +
      1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_regs) + 1UL));
    r.data[xpageoffset + r_dim0 * i] = regs.data[xpageoffset + regs_dim0 * i] -
      y.data[i] / mn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel14(const
  emxArray_real32_T fv2, const emxArray_real32_T r, const int32_T b_r, const
  int32_T c_r, emxArray_real32_T rr, int32_T rr_dim0, int32_T r_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_r) + 1UL) * (static_cast<uint64_T>(b_r) +
    1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_r) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_r) + 1UL));
    rr.data[xpageoffset + rr_dim0 * i] = r.data[xpageoffset + r_dim0 * i] *
      fv2.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel15(const
  emxArray_real32_T rr, const int32_T b_rr, const int32_T c_rr,
  emxArray_real32_T A, int32_T A_dim0, int32_T rr_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_rr) + 1UL) * (static_cast<uint64_T>(b_rr) +
    1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_rr) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_rr) + 1UL));
    A.data[xpageoffset + A_dim0 * i] = rr.data[i + rr_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel16(const int32_T
  A, emxArray_real32_T b_A)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_A.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel17(const
  creal32_T fc, const int32_T fv2, emxArray_creal32_T V)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i] = fc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel18(const int32_T
  fv2, emxArray_creal32_T D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel19(const
  emxArray_creal32_T V, const int32_T b_V, emxArray_real32_T c_V)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_V);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_V.data[i] = V.data[i].re;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel2(emxArray_real_T
  lin)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    lin.data[0] = -1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel20(const
  emxArray_int32_T iv, const emxArray_real32_T V, const int32_T b, const int32_T
  b_iv, emxArray_real32_T b_V, int32_T V_dim0, int32_T b_V_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_iv) + 1UL) * (static_cast<uint64_T>(b) +
    1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b) + 1UL));
    b_V.data[xpageoffset + V_dim0 * i] = V.data[xpageoffset + b_V_dim0 *
      iv.data[i]];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel21(const
  emxArray_real32_T V, const int32_T b_V, emxArray_real32_T c_V)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_V);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c_V.data[i] = V.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel22(const int32_T
  rr, emxArray_real32_T C)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(rr);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    C.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel23(const
  emxArray_real32_T fv3, const int32_T b_fv3, emxArray_real32_T A)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv3);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = fv3.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel24(const int32_T
  C, emxArray_real32_T b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(C);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel25(const
  emxArray_real32_T C, const int32_T b_C, const int32_T c_C, emxArray_real32_T A,
  int32_T A_dim0, int32_T C_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_C) + 1UL) * (static_cast<uint64_T>(b_C) +
    1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_C) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_C) + 1UL));
    A.data[xpageoffset + A_dim0 * i] = C.data[i + C_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel26(const int32_T
  A, emxArray_real32_T b_A)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_A.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel27(const int32_T
  sz, emxArray_real32_T b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel28(const
  emxArray_real32_T b, const int32_T b_b, emxArray_real32_T B)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel29(const int32_T
  V, emxArray_real32_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(V);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel3(const real_T
  d2scaled, const int32_T b, emxArray_real_T lin, int32_T lin_dim1)
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
    lin.data[k + 1] = static_cast<real_T>((((k + 2) << 1) - lin_dim1) - 1) *
      d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel30(const int32_T
  r, emxArray_real32_T fv4)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(r);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv4.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel31(const
  real32_T mn, const emxArray_real32_T fv1, const emxArray_real32_T fv4, const
  int32_T b_fv4, emxArray_real32_T z)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv4);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    z.data[i] = fv4.data[i] + (fv1.data[i] - (fv1.data[i] - mn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel32(const
  emxArray_real32_T fv2, const emxArray_real32_T z, const emxArray_real32_T fv1,
  const int32_T b_fv1, emxArray_real32_T d)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = (fv1.data[i] - z.data[i]) * fv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel33(const
  emxArray_real32_T d, const int32_T b, emxArray_real32_T y)
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
    y.data[k] = fabsf(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel34(const
  real32_T mn, const emxArray_real32_T y, const int32_T n, emxArray_real32_T fv2)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (y.data[i] > mn) {
      fv2.data[i] = 0.0F;
    }
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel35(const
  emxArray_real32_T d, real32_T *mn)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    if ((static_cast<boolean_T>(!static_cast<int32_T>(isinf(d.data[0])))) && (
         static_cast<boolean_T>(!static_cast<int32_T>(isnan(d.data[0]))))) {
      *mn = 0.0F;
    } else {
      *mn = CUDART_NAN_F;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel36(const
  real32_T mn, const emxArray_real32_T d, const int32_T n, emxArray_real32_T
  absdiff)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    absdiff.data[k] = fabsf(d.data[k] - mn);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel37(const int32_T
  fv2, emxArray_real32_T A)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel38(const int32_T
  n, emxArray_int32_T ipiv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel39(const
  emxArray_int32_T ipiv_t, const int32_T n, emxArray_int32_T ipiv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel4(emxArray_real_T
  lin, int32_T lin_dim1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    lin.data[lin_dim1 >> 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel40(const
  emxArray_real32_T A, const int32_T b_A, const int32_T c_A, emxArray_real32_T
  d_A, int32_T A_dim0, int32_T b_A_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_A) + 1UL) * (static_cast<uint64_T>(b_A) +
    1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_A) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_A) + 1UL));
    d_A.data[xpageoffset + A_dim0 * i] = A.data[i + b_A_dim0 * xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel41(const
  emxArray_real32_T b, const int32_T b_b, emxArray_real32_T B)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel42(const int32_T
  A, emxArray_int32_T jpvt)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    jpvt.data[i] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel43(const int32_T
  b, const int32_T n, emxArray_real32_T A, int32_T A_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(n) + 1UL) * (static_cast<uint64_T>(b) + 1UL)
    - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) / (
      static_cast<uint64_T>(b) + 1UL));
    A.data[xpageoffset * A_dim0 + i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel44(const int32_T
  b, emxArray_real32_T tau)
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
    tau.data[k] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel45(const int32_T
  j, const int64_T b, emxArray_real32_T tau)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    tau.data[static_cast<int32_T>(static_cast<int64_T>(j) + i) - 1] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel46(const int32_T
  n, emxArray_int32_T jpvt)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    jpvt.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel47(const int32_T
  A, emxArray_real32_T Y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel48(const int32_T
  b, emxArray_real32_T B)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel49(const
  emxArray_real32_T B, const emxArray_int32_T jpvt, const int32_T n,
  emxArray_real32_T Y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[jpvt.data[i] - 1] = B.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel5(const int32_T
  m, const emxArray_real_T lin, const int32_T npages, const int32_T b,
  emxArray_real32_T regs, int32_T regs_dim0)
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
    regs.data[k + regs_dim0 * (npages - 1)] = powf(static_cast<real32_T>
      (lin.data[k]), static_cast<real32_T>(m) + 1.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel50(const
  emxArray_real32_T Y, const int32_T b_Y, emxArray_real32_T b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_Y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = Y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel51(const
  emxArray_creal32_T D, const int32_T n, emxArray_creal32_T d, int32_T D_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    d.data[k] = D.data[k + D_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel52(const int32_T
  b, emxArray_real32_T W)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel53(const int32_T
  fv2, emxArray_real32_T A)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel54(const int32_T
  b, emxArray_creal32_T D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel55(const
  emxArray_real32_T A, const int32_T b_A, emxArray_creal32_T V)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_A);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i].re = A.data[i];
    V.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel56(const int32_T
  sz, emxArray_real32_T U)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel57(const int32_T
  nx, const int32_T npages, const int64_T b, emxArray_real32_T U, int32_T U_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    U.data[(static_cast<int32_T>(static_cast<int64_T>(npages) + i) + U_dim0 *
            (nx - 1)) - 1] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel58(const int32_T
  sz, emxArray_real32_T A)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel59(const int32_T
  A, emxArray_creal32_T D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel6(const int32_T
  ch, const emxArray_real32_T x, const int32_T b_x, emxArray_real32_T fv1,
  int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv1.data[i] = x.data[i + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel60(const
  emxArray_real32_T U, const int32_T b_U, emxArray_creal32_T V)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_U);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i].re = U.data[i];
    V.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel61(const int32_T
  fv2, emxArray_real32_T A)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel62(const int32_T
  b, emxArray_real32_T tau)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel63(const
  emxArray_real32_T A, const int32_T b_A, emxArray_real32_T U)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_A);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = A.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel64
  (emxArray_real32_T U)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    U.data[0] = 1.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel65(const int32_T
  fv2, emxArray_real32_T A)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel66(const int32_T
  fv2, emxArray_real32_T U)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel67(const int32_T
  fv2, emxArray_real32_T U)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel68(const
  creal32_T fc, const int32_T A, emxArray_creal32_T W)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = fc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel69(const
  creal32_T fc, const int32_T fv2, emxArray_creal32_T V)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i] = fc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel7(const int32_T
  ch, const emxArray_real32_T w, const int32_T b_w, emxArray_real32_T fv2,
  int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_w);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv2.data[i] = w.data[i + w_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel70(const int32_T
  A, emxArray_creal32_T D)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(A);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel71(const
  emxArray_real32_T wimag, const emxArray_real32_T wreal, const int32_T n,
  emxArray_creal32_T W)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i].re = wreal.data[i];
    W.data[i].im = wimag.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel72(const
  emxArray_real32_T vright, const int32_T b_vright, emxArray_creal32_T V)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_vright);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i].re = vright.data[i];
    V.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel73(const int32_T
  npages, const int32_T n, emxArray_creal32_T V, int32_T V_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(n);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T xpageoffset;
    real32_T f;
    xpageoffset = static_cast<int32_T>(idx);
    f = V.data[xpageoffset + V_dim0 * (npages - 1)].re;
    V.data[xpageoffset + V_dim0 * (npages - 2)].im = f;
    V.data[xpageoffset + V_dim0 * (npages - 1)].re = V.data[xpageoffset + V_dim0
      * (npages - 2)].re;
    V.data[xpageoffset + V_dim0 * (npages - 1)].im = -V.data[xpageoffset +
      V_dim0 * (npages - 2)].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel74(const int32_T
  nx, const emxArray_real32_T x, const int32_T b, emxArray_real32_T y, int32_T
  x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx);
    xpageoffset = i * x_dim0;
    y.data[i] = x.data[xpageoffset];
    for (int32_T k{0}; k <= nx - 2; k++) {
      y.data[i] += x.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel75(const
  emxArray_real32_T z, const int32_T ch, const int32_T b, emxArray_real32_T x,
  int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i + x_dim0 * ch] -= z.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel76(const
  emxArray_real32_T fv2, const int32_T ch, const int32_T b, emxArray_real32_T w,
  int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    w.data[i + w_dim0 * ch] = fv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel77(const int32_T
  ch, const emxArray_real32_T w, const int32_T b_w, emxArray_boolean_T x,
  int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_w);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = static_cast<boolean_T>(!static_cast<int32_T>(w.data[i + w_dim0 *
      ch] != 0.0F));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel78(const int32_T n,
  const int32_T ii, const int32_T ch, int32_T olPct_data[6487866], int32_T
  olPct_size_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    olPct_data[ch + olPct_size_dim0 * ii] = n;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel79(const int32_T
  sz, real_T olPct_data[])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    olPct_data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel8(const
  emxArray_real32_T fv2, const emxArray_real32_T fv1, const int32_T b_fv1,
  emxArray_real32_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = fv1.data[i] * fv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel80(const int32_T
  nx, const int32_T olPct_data[6487866], const int32_T olPct_size_dim0, const
  int32_T b, real_T b_olPct_data[])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx);
    xpageoffset = i * olPct_size_dim0;
    b_olPct_data[i] = static_cast<real_T>(olPct_data[xpageoffset]);
    for (int32_T k{0}; k <= nx - 2; k++) {
      b_olPct_data[i] += static_cast<real_T>(olPct_data[(xpageoffset + k) + 1]);
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel9(const
  emxArray_real32_T fv2, const emxArray_real32_T fv1, const int32_T b_fv1,
  emxArray_real32_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    x.data[i] = fv1.data[i] * fv2.data[i];
  }
}

static void emlrtExitTimeCleanupDtorFcn(const void *r)
{
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

static real32_T *emlrt_marshallIn(const mxArray *b_nullptr, const char_T
  *identifier, int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  real32_T *y_data;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y_data = emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId, y_size);
  emlrtDestroyArray(&b_nullptr);
  return y_data;
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
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

static real32_T *emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, int32_T y_size[2])
{
  real32_T *y_data;
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

static void emlrt_marshallOut(const emxArray_real32_T *u, const mxArray *y)
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(boolean_T));
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(ptrdiff_t));
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
  emxArray_boolean_T *gpu, boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  boolean_T *newData;
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
      (boolean_T)), __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(cudaMemcpy(newData, gpu->data, static_cast<uint32_T>
        (totalSizeGpu) * sizeof(boolean_T), cudaMemcpyDeviceToDevice), __FILE__,
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

static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }

  emlrtFreeMex(gpu->size);
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

static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu, const
  emxArray_int32_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(int32_T), cudaMemcpyHostToDevice), __FILE__, __LINE__);
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

static void gpuEmxMemcpyGpuToCpu_boolean_T(emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(boolean_T), cudaMemcpyDeviceToHost), __FILE__,
                 __LINE__);
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

static void gpuEmxMemcpyGpuToCpu_int32_T(emxArray_int32_T *cpu, emxArray_int32_T
  *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(int32_T), cudaMemcpyDeviceToHost), __FILE__, __LINE__);
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

static void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real_T));
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

  emxEnsureCapacity_real32_T(in1, i, &i_emlrtRTEI);
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
void ec_detr(emxArray_real32_T *cpu_x, emxArray_real32_T *cpu_w, const real32_T
             ord_data[], const int32_T ord_size[2], const real32_T thr_data[],
             const int32_T [2], const real32_T itr_data[], const int32_T [2],
             real_T cpu_olPct_data[], int32_T olPct_size[2])
{
  static creal32_T fc{ 0.0F,           // re
    0.0F                               // im
  };

  ptrdiff_t ihi_t;
  ptrdiff_t ilo_t;
  dim3 block;
  dim3 grid;
  emxArray_boolean_T e_gpu_x;
  emxArray_boolean_T *b_cpu_x;
  emxArray_creal32_T b_gpu_W;
  emxArray_creal32_T b_gpu_d;
  emxArray_creal32_T gpu_D;
  emxArray_creal32_T gpu_V;
  emxArray_creal32_T *b_cpu_W;
  emxArray_creal32_T *cpu_D;
  emxArray_creal32_T *cpu_V;
  emxArray_creal32_T *cpu_d;
  emxArray_int32_T gpu_ipiv;
  emxArray_int32_T gpu_ipiv_t;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_jpvt;
  emxArray_int32_T *cpu_ipiv;
  emxArray_int32_T *cpu_ipiv_t;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_jpvt;
  emxArray_ptrdiff_t *jpvt_t;
  emxArray_real32_T b_gpu_A;
  emxArray_real32_T b_gpu_B;
  emxArray_real32_T b_gpu_V;
  emxArray_real32_T b_gpu_tau;
  emxArray_real32_T b_gpu_x;
  emxArray_real32_T b_gpu_y;
  emxArray_real32_T c_gpu_A;
  emxArray_real32_T c_gpu_V;
  emxArray_real32_T c_gpu_x;
  emxArray_real32_T c_gpu_y;
  emxArray_real32_T d_gpu_A;
  emxArray_real32_T d_gpu_x;
  emxArray_real32_T e_gpu_A;
  emxArray_real32_T f_gpu_A;
  emxArray_real32_T gpu_A;
  emxArray_real32_T gpu_B;
  emxArray_real32_T gpu_C;
  emxArray_real32_T gpu_U;
  emxArray_real32_T gpu_W;
  emxArray_real32_T gpu_Y;
  emxArray_real32_T gpu_absdiff;
  emxArray_real32_T gpu_b;
  emxArray_real32_T gpu_d;
  emxArray_real32_T gpu_fv1;
  emxArray_real32_T gpu_fv2;
  emxArray_real32_T gpu_fv3;
  emxArray_real32_T gpu_fv4;
  emxArray_real32_T gpu_r;
  emxArray_real32_T gpu_regs;
  emxArray_real32_T gpu_rr;
  emxArray_real32_T gpu_tau;
  emxArray_real32_T gpu_vright;
  emxArray_real32_T gpu_w;
  emxArray_real32_T gpu_wimag;
  emxArray_real32_T gpu_wreal;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_y;
  emxArray_real32_T gpu_z;
  emxArray_real32_T *b_cpu_A;
  emxArray_real32_T *b_cpu_B;
  emxArray_real32_T *b_cpu_V;
  emxArray_real32_T *b_cpu_d;
  emxArray_real32_T *b_cpu_tau;
  emxArray_real32_T *b_cpu_y;
  emxArray_real32_T *c_cpu_A;
  emxArray_real32_T *c_cpu_V;
  emxArray_real32_T *c_cpu_x;
  emxArray_real32_T *c_cpu_y;
  emxArray_real32_T *cpu_A;
  emxArray_real32_T *cpu_B;
  emxArray_real32_T *cpu_C;
  emxArray_real32_T *cpu_U;
  emxArray_real32_T *cpu_W;
  emxArray_real32_T *cpu_Y;
  emxArray_real32_T *cpu_absdiff;
  emxArray_real32_T *cpu_b;
  emxArray_real32_T *cpu_fv1;
  emxArray_real32_T *cpu_fv2;
  emxArray_real32_T *cpu_fv3;
  emxArray_real32_T *cpu_fv4;
  emxArray_real32_T *cpu_r;
  emxArray_real32_T *cpu_regs;
  emxArray_real32_T *cpu_rr;
  emxArray_real32_T *cpu_tau;
  emxArray_real32_T *cpu_vright;
  emxArray_real32_T *cpu_wimag;
  emxArray_real32_T *cpu_wreal;
  emxArray_real32_T *cpu_y;
  emxArray_real32_T *cpu_z;
  emxArray_real32_T *d_cpu_A;
  emxArray_real32_T *d_cpu_x;
  emxArray_real32_T *e_cpu_A;
  emxArray_real32_T *e_cpu_x;
  emxArray_real32_T *f_cpu_A;
  emxArray_real32_T *scale;
  emxArray_real32_T *wi;
  emxArray_real32_T *wr;
  emxArray_real_T gpu_lin;
  emxArray_real_T *cpu_lin;
  real_T *b_gpu_olPct_data;
  int32_T (*gpu_olPct_data)[6487866];
  int32_T b_olPct_size[2];
  int32_T cpu_n;
  int32_T i;
  int32_T i5;
  int32_T nFrames;
  int32_T *gpu_n;
  real32_T abnrm;
  real32_T cpu_mn;
  real32_T rconde;
  real32_T rcondv;
  real32_T *gpu_mn;
  boolean_T b_x_outdatedOnCpu;
  boolean_T c_x_outdatedOnCpu;
  boolean_T d_outdatedOnCpu;
  boolean_T d_x_outdatedOnCpu;
  boolean_T fv3_outdatedOnCpu;
  boolean_T iv_outdatedOnGpu;
  boolean_T rr_outdatedOnCpu;
  boolean_T validLaunchParams;
  boolean_T w_needsGpuEnsureCapacity;
  boolean_T w_outdatedOnCpu;
  boolean_T w_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnCpu;
  boolean_T x_outdatedOnGpu;
  checkCudaError(mwCudaMalloc(&gpu_mn, 4UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_n, 4UL), __FILE__, __LINE__);
  gpuEmxReset_real32_T(&c_gpu_V);
  gpuEmxReset_real32_T(&c_gpu_y);
  gpuEmxReset_real32_T(&gpu_absdiff);
  gpuEmxReset_real32_T(&gpu_d);
  gpuEmxReset_real32_T(&gpu_fv4);
  gpuEmxReset_real32_T(&b_gpu_y);
  gpuEmxReset_real32_T(&gpu_tau);
  gpuEmxReset_int32_T(&gpu_ipiv_t);
  gpuEmxReset_int32_T(&gpu_jpvt);
  gpuEmxReset_real32_T(&gpu_B);
  gpuEmxReset_int32_T(&gpu_ipiv);
  gpuEmxReset_real32_T(&b_gpu_B);
  gpuEmxReset_real32_T(&f_gpu_A);
  gpuEmxReset_real32_T(&gpu_Y);
  gpuEmxReset_real32_T(&e_gpu_A);
  gpuEmxReset_real32_T(&gpu_vright);
  gpuEmxReset_real32_T(&d_gpu_A);
  gpuEmxReset_real32_T(&gpu_wimag);
  gpuEmxReset_real32_T(&b_gpu_tau);
  gpuEmxReset_real32_T(&gpu_wreal);
  gpuEmxReset_real32_T(&c_gpu_A);
  gpuEmxReset_creal32_T(&b_gpu_W);
  gpuEmxReset_real32_T(&gpu_b);
  gpuEmxReset_real32_T(&gpu_U);
  gpuEmxReset_real32_T(&gpu_C);
  gpuEmxReset_real32_T(&gpu_W);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_creal32_T(&b_gpu_d);
  gpuEmxReset_real32_T(&b_gpu_V);
  gpuEmxReset_creal32_T(&gpu_D);
  gpuEmxReset_creal32_T(&gpu_V);
  gpuEmxReset_real32_T(&gpu_A);
  gpuEmxReset_real32_T(&b_gpu_A);
  gpuEmxReset_real32_T(&gpu_rr);
  gpuEmxReset_real32_T(&gpu_r);
  gpuEmxReset_real32_T(&d_gpu_x);
  gpuEmxReset_real32_T(&gpu_y);
  gpuEmxReset_real32_T(&gpu_fv3);
  gpuEmxReset_real32_T(&c_gpu_x);
  gpuEmxReset_real32_T(&b_gpu_x);
  gpuEmxReset_boolean_T(&e_gpu_x);
  gpuEmxReset_real32_T(&gpu_z);
  gpuEmxReset_real32_T(&gpu_fv2);
  gpuEmxReset_real32_T(&gpu_fv1);
  gpuEmxReset_real_T(&gpu_lin);
  gpuEmxReset_real32_T(&gpu_regs);
  checkCudaError(mwCudaMalloc(&gpu_olPct_data, 25951464UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&b_gpu_olPct_data, 99U * sizeof(real_T)), __FILE__,
                 __LINE__);
  gpuEmxReset_real32_T(&gpu_w);
  gpuEmxReset_real32_T(&gpu_x);
  d_outdatedOnCpu = false;
  iv_outdatedOnGpu = false;
  rr_outdatedOnCpu = false;
  d_x_outdatedOnCpu = false;
  fv3_outdatedOnCpu = false;
  c_x_outdatedOnCpu = false;
  b_x_outdatedOnCpu = false;
  w_outdatedOnCpu = false;
  w_outdatedOnGpu = true;
  x_outdatedOnCpu = false;
  x_outdatedOnGpu = true;
  w_needsGpuEnsureCapacity = true;
  x_needsGpuEnsureCapacity = true;
  fc.re = rtNaNF;
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
  // 'ec_detr:23' thr (1,:){mustBeFloat}
  // 'ec_detr:24' itr (1,:){mustBeFloat}
  //  Main
  // 'ec_detr:28' coder.gpu.kernelfun;
  //  trigger CUDA kernel generation
  // 'ec_detr:29' nFrames = size(x,1);
  nFrames = cpu_x->size[0];

  // 'ec_detr:30' nChs = size(x,2);
  // 'ec_detr:31' reps = numel(ord);
  // 'ec_detr:32' olPct = coder.nullcopy(nan(nChs,reps));
  b_olPct_size[0] = cpu_x->size[1];

  //  Detrend by polynomial order
  // 'ec_detr:35' for ii = 1:reps
  i = ord_size[1];
  emxInit_real32_T(&cpu_regs, 2, &vc_emlrtRTEI, true);
  emxInit_real_T(&cpu_lin, 2, &wc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv1, 1, &gb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv2, 1, &gb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_z, 1, &xc_emlrtRTEI, true);
  emxInit_boolean_T(&b_cpu_x, 1, &h_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_x, 1, &i_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_x, 1, &i_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv3, 1, &yc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_y, 2, &ad_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_x, 2, &i_emlrtRTEI, true);
  emxInit_real32_T(&cpu_r, 2, &bd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_rr, 2, &m_emlrtRTEI, true);
  emxInit_real32_T(&cpu_A, 2, &gb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_A, 2, &n_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_V, 2, &gb_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_D, 2, &gb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_V, 2, &cd_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_d, 1, &dd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &ed_emlrtRTEI, true);
  emxInit_real32_T(&cpu_W, 1, &gb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_C, 2, &fd_emlrtRTEI, true);
  emxInit_real32_T(&scale, 1, &gd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_U, 2, &gb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_b, 2, &gc_emlrtRTEI, true);
  emxInit_creal32_T(&b_cpu_W, 1, &gb_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_A, 2, &n_emlrtRTEI, true);
  emxInit_real32_T(&cpu_wreal, 1, &hd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_tau, 1, &gb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_wimag, 1, &id_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_A, 2, &n_emlrtRTEI, true);
  emxInit_real32_T(&cpu_vright, 2, &jd_emlrtRTEI, true);
  emxInit_real32_T(&e_cpu_A, 2, &gb_emlrtRTEI, true);
  emxInit_real32_T(&wr, 2, &kd_emlrtRTEI, true);
  emxInit_real32_T(&wi, 2, &ld_emlrtRTEI, true);
  emxInit_real32_T(&cpu_Y, 1, &md_emlrtRTEI, true);
  emxInit_real32_T(&f_cpu_A, 2, &gb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_B, 1, &ic_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv, 2, &gb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_B, 1, &jc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_jpvt, 2, &gb_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv_t, 1, &nd_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_tau, 1, &gb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_y, 1, &od_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &nc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv4, 1, &oc_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_d, 1, &qc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_absdiff, 1, &pd_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_y, 1, &qd_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_V, 2, &ob_emlrtRTEI, true);
  for (int32_T ii{0}; ii < i; ii++) {
    int32_T i4;
    int32_T j;
    int32_T m;
    int32_T nx;
    boolean_T lin_needsGpuEnsureCapacity;
    boolean_T regs_needsGpuEnsureCapacity;
    boolean_T regs_outdatedOnCpu;

    // 'ec_detr:36' iOrd=ord(ii);
    // 'ec_detr:36' iThr=thr(ii);
    // 'ec_detr:36' iItr=itr(ii);
    //  copy
    // 'ec_detr:37' regs = regsFromBasis_lfn(nFrames,iOrd);
    // %%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    //  Get regressors from polynomial function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    // 'ec_detr:58' regs = coder.nullcopy(zeros(nFrames,iOrd,'like',iOrd));
    regs_outdatedOnCpu = false;
    j = cpu_regs->size[0] * cpu_regs->size[1];
    cpu_regs->size[0] = nFrames;
    cpu_regs->size[1] = static_cast<int32_T>(ord_data[ii]);
    emxEnsureCapacity_real32_T(cpu_regs, j, &c_emlrtRTEI);
    regs_needsGpuEnsureCapacity = true;

    // 'ec_detr:59' lin = linspace(-1,1,nFrames);
    j = cpu_lin->size[0] * cpu_lin->size[1];
    cpu_lin->size[0] = 1;
    cpu_lin->size[1] = nFrames;
    emxEnsureCapacity_real_T(cpu_lin, j, &d_emlrtRTEI);
    lin_needsGpuEnsureCapacity = true;
    if (nFrames >= 1) {
      gpuEmxEnsureCapacity_real_T(cpu_lin, &gpu_lin, true);
      lin_needsGpuEnsureCapacity = false;
      ec_detr_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nFrames, gpu_lin);
      if (cpu_lin->size[1] >= 2) {
        ec_detr_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_lin);
        if (cpu_lin->size[1] >= 3) {
          real_T d2scaled;
          d2scaled = 1.0 / (static_cast<real_T>(cpu_lin->size[1]) - 1.0);
          cpu_n = cpu_lin->size[1];
          mwGetLaunchParameters1D(computeNumIters(cpu_n - 3), &grid, &block,
            2147483647U);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel3<<<grid, block>>>(d2scaled, cpu_n - 3, gpu_lin,
              cpu_lin->size[1U]);
          }

          if ((cpu_lin->size[1] & 1) == 1) {
            ec_detr_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_lin,
              cpu_lin->size[1U]);
          }
        }
      }
    }

    // 'ec_detr:60' for k = 1:iOrd
    cpu_n = static_cast<int32_T>(ord_data[ii]);
    for (m = 0; m < cpu_n; m++) {
      // 'ec_detr:61' regs(:,k) = lin.^k;
      nx = cpu_lin->size[1];
      mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
        2147483647U);
      if (lin_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real_T(cpu_lin, &gpu_lin, true);
      }

      lin_needsGpuEnsureCapacity = false;
      if (regs_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_regs, &gpu_regs, true);
      }

      regs_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_detr_kernel5<<<grid, block>>>(m, gpu_lin, static_cast<int32_T>(
          static_cast<real32_T>(m) + 1.0F), nx - 1, gpu_regs, cpu_regs->size[0U]);
      }

      regs_outdatedOnCpu = true;
    }

    //  Get regressors from basis function
    //  Detrend per chan
    // 'ec_detr:40' for ch = 1:nChs
    i4 = cpu_x->size[1];
    if (i4 - 1 >= 0) {
      i5 = static_cast<int32_T>(itr_data[ii]);
    }

    for (int32_T ch{0}; ch < i4; ch++) {
      int32_T npages;
      boolean_T fv1_needsGpuEnsureCapacity;
      boolean_T fv1_outdatedOnCpu;
      boolean_T fv2_needsGpuEnsureCapacity;
      boolean_T fv2_outdatedOnCpu;
      boolean_T z_outdatedOnCpu;

      // 'ec_detr:41' [x(:,ch),w(:,ch)] = detrend_lfn(x(:,ch),w(:,ch),regs,iThr,iItr);
      j = cpu_fv1->size[0];
      cpu_fv1->size[0] = cpu_x->size[0];
      emxEnsureCapacity_real32_T(cpu_fv1, j, &e_emlrtRTEI);
      nx = cpu_x->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
      if (x_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
      }

      gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1, true);
      fv1_needsGpuEnsureCapacity = false;
      if (x_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
      }

      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_detr_kernel6<<<grid, block>>>(ch, gpu_x, nx, gpu_fv1, cpu_x->size[0U]);
      }

      fv1_outdatedOnCpu = true;
      j = cpu_fv2->size[0];
      cpu_fv2->size[0] = cpu_w->size[0];
      emxEnsureCapacity_real32_T(cpu_fv2, j, &f_emlrtRTEI);
      nx = cpu_w->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
      if (w_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real32_T(cpu_w, &gpu_w, !w_outdatedOnGpu);
      }

      gpuEmxEnsureCapacity_real32_T(cpu_fv2, &gpu_fv2, true);
      fv2_needsGpuEnsureCapacity = false;
      if (w_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_w, cpu_w);
      }

      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_detr_kernel7<<<grid, block>>>(ch, gpu_w, nx, gpu_fv2, cpu_w->size[0U]);
      }

      fv2_outdatedOnCpu = true;

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
      z_outdatedOnCpu = false;
      w_outdatedOnGpu = false;
      j = cpu_z->size[0];
      cpu_z->size[0] = cpu_x->size[0];
      emxEnsureCapacity_real32_T(cpu_z, j, &g_emlrtRTEI);
      w_needsGpuEnsureCapacity = true;

      // 'ec_detr:81' for ii = 1:iItr
      for (int32_T b_ii{0}; b_ii < i5; b_ii++) {
        int64_T b;
        int32_T fv2[2];
        int32_T n;
        real32_T mn;
        uint32_T sz[2];
        boolean_T A_outdatedOnCpu;
        boolean_T A_outdatedOnGpu;
        boolean_T D_outdatedOnGpu;
        boolean_T fv3_needsGpuEnsureCapacity;
        boolean_T fv3_outdatedOnGpu;
        boolean_T r_needsGpuEnsureCapacity;

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
        if (cpu_fv1->size[0] == cpu_fv2->size[0]) {
          j = c_cpu_x->size[0];
          c_cpu_x->size[0] = cpu_fv1->size[0];
          emxEnsureCapacity_real32_T(c_cpu_x, j, &i_emlrtRTEI);
          nx = cpu_fv1->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          if (fv1_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1, true);
          }

          fv1_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real32_T(c_cpu_x, &b_gpu_x, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel8<<<grid, block>>>(gpu_fv2, gpu_fv1, nx, b_gpu_x);
          }

          b_x_outdatedOnCpu = true;
        } else {
          if (b_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_x, &b_gpu_x);
          }

          if (fv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
          }

          fv1_outdatedOnCpu = false;
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          fv2_outdatedOnCpu = false;
          times(c_cpu_x, cpu_fv1, cpu_fv2);
          b_x_outdatedOnCpu = false;
          fv2_needsGpuEnsureCapacity = true;
          fv1_needsGpuEnsureCapacity = true;
        }

        nx = c_cpu_x->size[0];
        if (c_cpu_x->size[0] == 0) {
          cpu_mn = 0.0F;
        } else {
          if (b_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_x, &b_gpu_x);
          }

          b_x_outdatedOnCpu = false;
          cpu_mn = c_cpu_x->data[0];
          for (npages = 0; npages <= nx - 2; npages++) {
            cpu_mn += c_cpu_x->data[npages + 1];
          }
        }

        nx = cpu_fv2->size[0];
        if (cpu_fv2->size[0] == 0) {
          abnrm = 0.0F;
        } else {
          if (fv2_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_outdatedOnCpu = false;
          abnrm = cpu_fv2->data[0];
          fv2_needsGpuEnsureCapacity = true;
          for (npages = 0; npages <= nx - 2; npages++) {
            abnrm += cpu_fv2->data[npages + 1];
          }
        }

        mn = cpu_mn / (abnrm + 2.22044605E-16F);

        // 'ec_detr:125' x = x - mn;
        //  Fit weighted regression
        // 'ec_detr:108' x = demean_lfn(x,w).* w;
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ec_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_fv1->size[0] == cpu_fv2->size[0]) {
          j = d_cpu_x->size[0];
          d_cpu_x->size[0] = cpu_fv1->size[0];
          emxEnsureCapacity_real32_T(d_cpu_x, j, &i_emlrtRTEI);
          nx = cpu_fv1->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          if (fv2_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv2, &gpu_fv2, true);
          }

          fv2_needsGpuEnsureCapacity = false;
          if (fv1_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1, true);
          }

          fv1_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real32_T(d_cpu_x, &c_gpu_x, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel9<<<grid, block>>>(gpu_fv2, gpu_fv1, nx, c_gpu_x);
          }

          c_x_outdatedOnCpu = true;
        } else {
          if (c_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_x, &c_gpu_x);
          }

          if (fv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
          }

          fv1_outdatedOnCpu = false;
          if (fv2_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_outdatedOnCpu = false;
          times(d_cpu_x, cpu_fv1, cpu_fv2);
          c_x_outdatedOnCpu = false;
          fv2_needsGpuEnsureCapacity = true;
          fv1_needsGpuEnsureCapacity = true;
        }

        nx = d_cpu_x->size[0];
        if (d_cpu_x->size[0] == 0) {
          cpu_mn = 0.0F;
        } else {
          if (c_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_x, &c_gpu_x);
          }

          c_x_outdatedOnCpu = false;
          cpu_mn = d_cpu_x->data[0];
          for (npages = 0; npages <= nx - 2; npages++) {
            cpu_mn += d_cpu_x->data[npages + 1];
          }
        }

        nx = cpu_fv2->size[0];
        if (cpu_fv2->size[0] == 0) {
          abnrm = 0.0F;
        } else {
          if (fv2_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_outdatedOnCpu = false;
          abnrm = cpu_fv2->data[0];
          fv2_needsGpuEnsureCapacity = true;
          for (npages = 0; npages <= nx - 2; npages++) {
            abnrm += cpu_fv2->data[npages + 1];
          }
        }

        cpu_mn /= abnrm + 2.22044605E-16F;

        // 'ec_detr:125' x = x - mn;
        if (cpu_fv1->size[0] == cpu_fv2->size[0]) {
          j = cpu_fv3->size[0];
          cpu_fv3->size[0] = cpu_fv1->size[0];
          emxEnsureCapacity_real32_T(cpu_fv3, j, &j_emlrtRTEI);
          nx = cpu_fv1->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          if (fv2_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv2, &gpu_fv2, true);
          }

          fv2_needsGpuEnsureCapacity = false;
          if (fv1_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1, true);
          }

          fv1_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real32_T(cpu_fv3, &gpu_fv3, true);
          fv3_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel10<<<grid, block>>>(gpu_fv2, cpu_mn, gpu_fv1, nx,
              gpu_fv3);
          }

          fv3_outdatedOnGpu = false;
          fv3_outdatedOnCpu = true;
        } else {
          if (fv3_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv3, &gpu_fv3);
          }

          if (fv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
          }

          fv1_outdatedOnCpu = false;
          if (fv2_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_outdatedOnCpu = false;
          binary_expand_op_4(cpu_fv3, cpu_fv1, cpu_mn, cpu_fv2);
          fv3_outdatedOnCpu = false;
          fv3_outdatedOnGpu = true;
          fv2_needsGpuEnsureCapacity = true;
          fv1_needsGpuEnsureCapacity = true;
          fv3_needsGpuEnsureCapacity = true;
        }

        // 'ec_detr:109' r = demean_lfn(r,w);
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ec_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_regs->size[0] == cpu_fv2->size[0]) {
          j = e_cpu_x->size[0] * e_cpu_x->size[1];
          e_cpu_x->size[0] = cpu_regs->size[0];
          e_cpu_x->size[1] = cpu_regs->size[1];
          emxEnsureCapacity_real32_T(e_cpu_x, j, &i_emlrtRTEI);
          nx = cpu_regs->size[1] - 1;
          npages = cpu_regs->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx, npages), &grid, &block,
            2147483647U);
          if (fv2_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv2, &gpu_fv2, true);
          }

          fv2_needsGpuEnsureCapacity = false;
          if (regs_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_regs, &gpu_regs, true);
          }

          regs_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real32_T(e_cpu_x, &d_gpu_x, true);
          x_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel11<<<grid, block>>>(gpu_fv2, gpu_regs, npages, nx,
              d_gpu_x, e_cpu_x->size[0U], cpu_regs->size[0U]);
          }

          x_outdatedOnGpu = false;
          d_x_outdatedOnCpu = true;
        } else {
          if (d_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(e_cpu_x, &d_gpu_x);
          }

          if (regs_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_regs, &gpu_regs);
          }

          regs_outdatedOnCpu = false;
          if (fv2_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_outdatedOnCpu = false;
          binary_expand_op_2(e_cpu_x, cpu_regs, cpu_fv2);
          d_x_outdatedOnCpu = false;
          x_outdatedOnGpu = true;
          fv2_needsGpuEnsureCapacity = true;
          regs_needsGpuEnsureCapacity = true;
          x_needsGpuEnsureCapacity = true;
        }

        nx = e_cpu_x->size[0];
        if ((e_cpu_x->size[0] == 0) || (e_cpu_x->size[1] == 0)) {
          for (nx = 0; nx < 2; nx++) {
            sz[nx] = static_cast<uint32_T>(e_cpu_x->size[nx]);
          }

          j = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = static_cast<int32_T>(sz[1]);
          emxEnsureCapacity_real32_T(cpu_y, j, &k_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(sz[1]) -
            1), &grid, &block, 2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_y, &gpu_y, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel12<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
              gpu_y);
          }
        } else {
          npages = e_cpu_x->size[1];
          j = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = e_cpu_x->size[1];
          emxEnsureCapacity_real32_T(cpu_y, j, &b_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(npages - 1), &grid, &block,
            2147483647U);
          if (x_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(e_cpu_x, &d_gpu_x, !x_outdatedOnGpu);
          }

          gpuEmxEnsureCapacity_real32_T(cpu_y, &gpu_y, true);
          if (x_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&d_gpu_x, e_cpu_x);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel74<<<grid, block>>>(nx, d_gpu_x, npages - 1, gpu_y,
              e_cpu_x->size[0U]);
          }
        }

        nx = cpu_fv2->size[0];
        if (cpu_fv2->size[0] == 0) {
          cpu_mn = 0.0F;
        } else {
          if (fv2_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_outdatedOnCpu = false;
          cpu_mn = cpu_fv2->data[0];
          fv2_needsGpuEnsureCapacity = true;
          for (npages = 0; npages <= nx - 2; npages++) {
            cpu_mn += cpu_fv2->data[npages + 1];
          }
        }

        // 'ec_detr:125' x = x - mn;
        cpu_mn += 2.22044605E-16F;
        j = cpu_r->size[0] * cpu_r->size[1];
        cpu_r->size[0] = cpu_regs->size[0];
        cpu_r->size[1] = cpu_regs->size[1];
        emxEnsureCapacity_real32_T(cpu_r, j, &l_emlrtRTEI);
        nx = cpu_regs->size[1] - 1;
        npages = cpu_regs->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx, npages), &grid, &block,
          2147483647U);
        if (regs_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(cpu_regs, &gpu_regs, true);
        }

        regs_needsGpuEnsureCapacity = false;
        gpuEmxEnsureCapacity_real32_T(cpu_r, &gpu_r, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel13<<<grid, block>>>(cpu_mn, gpu_y, gpu_regs, npages, nx,
            gpu_r, cpu_r->size[0U], cpu_regs->size[0U]);
        }

        //  remove channel-specific-weighted mean from regressor
        // 'ec_detr:110' rr = r.*w;
        if (cpu_r->size[0] == cpu_fv2->size[0]) {
          j = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = cpu_r->size[0];
          cpu_rr->size[1] = cpu_r->size[1];
          emxEnsureCapacity_real32_T(cpu_rr, j, &m_emlrtRTEI);
          nx = cpu_r->size[1] - 1;
          npages = cpu_r->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx, npages), &grid, &block,
            2147483647U);
          if (fv2_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv2, &gpu_fv2, true);
          }

          fv2_needsGpuEnsureCapacity = false;
          r_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real32_T(cpu_rr, &gpu_rr, true);
          lin_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel14<<<grid, block>>>(gpu_fv2, gpu_r, npages, nx, gpu_rr,
              cpu_rr->size[0U], cpu_r->size[0U]);
          }

          w_outdatedOnCpu = false;
          rr_outdatedOnCpu = true;
        } else {
          if (rr_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_rr, &gpu_rr);
          }

          gpuEmxMemcpyGpuToCpu_real32_T(cpu_r, &gpu_r);
          if (fv2_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_outdatedOnCpu = false;
          binary_expand_op_2(cpu_rr, cpu_r, cpu_fv2);
          rr_outdatedOnCpu = false;
          w_outdatedOnCpu = true;
          fv2_needsGpuEnsureCapacity = true;
          r_needsGpuEnsureCapacity = true;
          lin_needsGpuEnsureCapacity = true;
        }

        // 'ec_detr:111' [V,D] = eig(rr'*rr);
        j = b_cpu_A->size[0] * b_cpu_A->size[1];
        b_cpu_A->size[0] = cpu_rr->size[1];
        b_cpu_A->size[1] = cpu_rr->size[0];
        emxEnsureCapacity_real32_T(b_cpu_A, j, &n_emlrtRTEI);
        nx = cpu_rr->size[0] - 1;
        npages = cpu_rr->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx, npages), &grid, &block,
          2147483647U);
        if (lin_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(cpu_rr, &gpu_rr, !w_outdatedOnCpu);
        }

        gpuEmxEnsureCapacity_real32_T(b_cpu_A, &gpu_A, true);
        if (w_outdatedOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, cpu_rr);
        }

        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel15<<<grid, block>>>(gpu_rr, npages, nx, gpu_A,
            b_cpu_A->size[0U], cpu_rr->size[0U]);
        }

        if ((b_cpu_A->size[0] == 0) || (b_cpu_A->size[1] == 0) || (cpu_rr->size
             [0] == 0) || (cpu_rr->size[1] == 0)) {
          j = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = b_cpu_A->size[0];
          cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(cpu_A, j, &p_emlrtRTEI);
          npages = b_cpu_A->size[0] * cpu_rr->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(npages), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_A, &b_gpu_A, true);
          lin_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel16<<<grid, block>>>(npages, b_gpu_A);
          }

          A_outdatedOnGpu = false;
          A_outdatedOnCpu = true;
        } else {
          j = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = b_cpu_A->size[0];
          cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(cpu_A, j, &o_emlrtRTEI);
          cpu_mn = 1.0F;
          abnrm = 0.0F;
          gpuEmxEnsureCapacity_real32_T(cpu_A, &b_gpu_A, true);
          lin_needsGpuEnsureCapacity = false;
          cublasCheck(cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N,
            CUBLAS_OP_N, b_cpu_A->size[0], cpu_rr->size[1], b_cpu_A->size[1],
            (float *)&cpu_mn, (float *)&gpu_A.data[0], b_cpu_A->size[0], (float *)
            &gpu_rr.data[0], b_cpu_A->size[1], (float *)&abnrm, (float *)
            &b_gpu_A.data[0], b_cpu_A->size[0]), __FILE__, __LINE__);
          A_outdatedOnGpu = false;
          A_outdatedOnCpu = true;
        }

        n = cpu_A->size[0];
        x_needsGpuEnsureCapacity = false;
        j = cpu_V->size[0] * cpu_V->size[1];
        cpu_V->size[0] = cpu_A->size[0];
        cpu_V->size[1] = cpu_A->size[0];
        emxEnsureCapacity_creal32_T(cpu_V, j, &q_emlrtRTEI);
        w_needsGpuEnsureCapacity = true;
        w_outdatedOnGpu = false;
        D_outdatedOnGpu = false;
        j = cpu_D->size[0] * cpu_D->size[1];
        cpu_D->size[0] = cpu_A->size[0];
        cpu_D->size[1] = cpu_A->size[0];
        emxEnsureCapacity_creal32_T(cpu_D, j, &r_emlrtRTEI);
        x_outdatedOnGpu = true;
        if ((cpu_A->size[0] != 0) && (cpu_A->size[1] != 0)) {
          nx = cpu_A->size[0] * cpu_A->size[1];
          w_outdatedOnCpu = true;
          for (m = 0; m < nx; m++) {
            if (w_outdatedOnCpu) {
              if (A_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &b_gpu_A);
              }

              A_outdatedOnCpu = false;
              if ((!std::isinf(cpu_A->data[m])) && (!std::isnan(cpu_A->data[m])))
              {
                lin_needsGpuEnsureCapacity = true;
              } else {
                lin_needsGpuEnsureCapacity = true;
                w_outdatedOnCpu = false;
              }
            } else {
              w_outdatedOnCpu = false;
            }
          }

          if (!w_outdatedOnCpu) {
            for (nx = 0; nx < 2; nx++) {
              fv2[nx] = cpu_V->size[nx];
            }

            j = cpu_V->size[0] * cpu_V->size[1];
            cpu_V->size[0] = fv2[0];
            cpu_V->size[1] = fv2[1];
            emxEnsureCapacity_creal32_T(cpu_V, j, &t_emlrtRTEI);
            nx = fv2[0] * fv2[1] - 1;
            mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V, true);
            w_needsGpuEnsureCapacity = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_detr_kernel17<<<grid, block>>>(fc, nx, gpu_V);
            }

            for (nx = 0; nx < 2; nx++) {
              fv2[nx] = cpu_D->size[nx];
            }

            j = cpu_D->size[0] * cpu_D->size[1];
            cpu_D->size[0] = fv2[0];
            cpu_D->size[1] = fv2[1];
            emxEnsureCapacity_creal32_T(cpu_D, j, &bb_emlrtRTEI);
            nx = fv2[0] * fv2[1] - 1;
            mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_creal32_T(cpu_D, &gpu_D, true);
            x_outdatedOnGpu = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_detr_kernel18<<<grid, block>>>(nx, gpu_D);
            }

            w_outdatedOnGpu = true;
            for (m = 0; m < n; m++) {
              if (w_outdatedOnGpu) {
                gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &gpu_D);
              }

              cpu_D->data[m + cpu_D->size[0] * m] = fc;
              w_outdatedOnGpu = false;
              D_outdatedOnGpu = true;
              x_outdatedOnGpu = true;
            }
          } else {
            int32_T exitg1;
            boolean_T exitg2;
            w_outdatedOnCpu = (cpu_A->size[0] == cpu_A->size[1]);
            if (w_outdatedOnCpu) {
              j = 0;
              exitg2 = false;
              while ((!exitg2) && (j <= cpu_A->size[1] - 1)) {
                m = 0;
                do {
                  exitg1 = 0;
                  if (m <= j) {
                    if (A_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &b_gpu_A);
                    }

                    A_outdatedOnCpu = false;
                    if (!(cpu_A->data[m + cpu_A->size[0] * j] == cpu_A->data[j +
                          cpu_A->size[0] * m])) {
                      lin_needsGpuEnsureCapacity = true;
                      w_outdatedOnCpu = false;
                      exitg1 = 1;
                    } else {
                      lin_needsGpuEnsureCapacity = true;
                      m++;
                    }
                  } else {
                    j++;
                    exitg1 = 2;
                  }
                } while (exitg1 == 0);

                if (exitg1 == 1) {
                  exitg2 = true;
                }
              }
            }

            if (w_outdatedOnCpu) {
              ptrdiff_t info_t;
              ptrdiff_t n_t;
              n = cpu_A->size[0];
              n_t = (ptrdiff_t)cpu_A->size[0];
              j = cpu_W->size[0];
              cpu_W->size[0] = cpu_A->size[0];
              emxEnsureCapacity_real32_T(cpu_W, j, &v_emlrtRTEI);
              if (A_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &b_gpu_A);
              }

              info_t = LAPACKE_ssyev(102, 'V', 'L', n_t, &cpu_A->data[0], n_t,
                &cpu_W->data[0]);
              w_outdatedOnCpu = false;
              A_outdatedOnGpu = true;
              lin_needsGpuEnsureCapacity = true;
              if ((int32_T)info_t < 0) {
                npages = cpu_W->size[0];
                j = cpu_W->size[0];
                cpu_W->size[0] = npages;
                emxEnsureCapacity_real32_T(cpu_W, j, &db_emlrtRTEI);
                mwGetLaunchParameters1D(computeNumIters(npages - 1), &grid,
                  &block, 2147483647U);
                gpuEmxEnsureCapacity_real32_T(cpu_W, &gpu_W, true);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_detr_kernel52<<<grid, block>>>(npages - 1, gpu_W);
                }

                w_outdatedOnCpu = true;
                for (nx = 0; nx < 2; nx++) {
                  fv2[nx] = cpu_A->size[nx];
                }

                j = cpu_A->size[0] * cpu_A->size[1];
                cpu_A->size[0] = fv2[0];
                cpu_A->size[1] = fv2[1];
                emxEnsureCapacity_real32_T(cpu_A, j, &lb_emlrtRTEI);
                nx = fv2[0] * fv2[1] - 1;
                mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                  2147483647U);
                gpuEmxEnsureCapacity_real32_T(cpu_A, &b_gpu_A, true);
                lin_needsGpuEnsureCapacity = false;
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_detr_kernel53<<<grid, block>>>(nx, b_gpu_A);
                }

                A_outdatedOnGpu = false;
              }

              j = cpu_D->size[0] * cpu_D->size[1];
              cpu_D->size[0] = n;
              cpu_D->size[1] = n;
              emxEnsureCapacity_creal32_T(cpu_D, j, &ab_emlrtRTEI);
              nx = n * n - 1;
              mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                2147483647U);
              gpuEmxEnsureCapacity_creal32_T(cpu_D, &gpu_D, true);
              x_outdatedOnGpu = false;
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_detr_kernel54<<<grid, block>>>(nx, gpu_D);
              }

              w_outdatedOnGpu = true;
              for (m = 0; m < n; m++) {
                if (w_outdatedOnGpu) {
                  gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &gpu_D);
                }

                if (w_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(cpu_W, &gpu_W);
                }

                w_outdatedOnCpu = false;
                cpu_D->data[m + cpu_D->size[0] * m].re = cpu_W->data[m];
                cpu_D->data[m + cpu_D->size[0] * m].im = 0.0F;
                w_outdatedOnGpu = false;
                D_outdatedOnGpu = true;
                x_outdatedOnGpu = true;
              }

              j = cpu_V->size[0] * cpu_V->size[1];
              cpu_V->size[0] = cpu_A->size[0];
              cpu_V->size[1] = cpu_A->size[1];
              emxEnsureCapacity_creal32_T(cpu_V, j, &kb_emlrtRTEI);
              npages = cpu_A->size[0] * cpu_A->size[1] - 1;
              mwGetLaunchParameters1D(computeNumIters(npages), &grid, &block,
                2147483647U);
              if (lin_needsGpuEnsureCapacity) {
                gpuEmxEnsureCapacity_real32_T(cpu_A, &b_gpu_A, !A_outdatedOnGpu);
              }

              gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V, true);
              w_needsGpuEnsureCapacity = false;
              if (A_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_A, cpu_A);
              }

              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_detr_kernel55<<<grid, block>>>(b_gpu_A, npages, gpu_V);
              }
            } else {
              w_outdatedOnCpu = (cpu_A->size[0] == cpu_A->size[1]);
              if (w_outdatedOnCpu) {
                j = 0;
                exitg2 = false;
                while ((!exitg2) && (j <= cpu_A->size[1] - 1)) {
                  m = 0;
                  do {
                    exitg1 = 0;
                    if (m <= j) {
                      if (A_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &b_gpu_A);
                      }

                      A_outdatedOnCpu = false;
                      if (!(cpu_A->data[m + cpu_A->size[0] * j] == -cpu_A->
                            data[j + cpu_A->size[0] * m])) {
                        lin_needsGpuEnsureCapacity = true;
                        w_outdatedOnCpu = false;
                        exitg1 = 1;
                      } else {
                        lin_needsGpuEnsureCapacity = true;
                        m++;
                      }
                    } else {
                      j++;
                      exitg1 = 2;
                    }
                  } while (exitg1 == 0);

                  if (exitg1 == 1) {
                    exitg2 = true;
                  }
                }
              }

              if (w_outdatedOnCpu) {
                nx = cpu_A->size[0] * cpu_A->size[1];
                for (m = 0; m < nx; m++) {
                  if (w_outdatedOnCpu) {
                    if (A_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &b_gpu_A);
                    }

                    A_outdatedOnCpu = false;
                    if ((!std::isinf(cpu_A->data[m])) && (!std::isnan
                         (cpu_A->data[m]))) {
                      lin_needsGpuEnsureCapacity = true;
                    } else {
                      lin_needsGpuEnsureCapacity = true;
                      w_outdatedOnCpu = false;
                    }
                  } else {
                    w_outdatedOnCpu = false;
                  }
                }

                if (!w_outdatedOnCpu) {
                  for (nx = 0; nx < 2; nx++) {
                    sz[nx] = static_cast<uint32_T>(cpu_A->size[nx]);
                  }

                  j = cpu_U->size[0] * cpu_U->size[1];
                  cpu_U->size[0] = static_cast<int32_T>(sz[0]);
                  cpu_U->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real32_T(cpu_U, j, &fb_emlrtRTEI);
                  nx = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                    2147483647U);
                  gpuEmxEnsureCapacity_real32_T(cpu_U, &gpu_U, true);
                  w_outdatedOnCpu = false;
                  validLaunchParams = mwValidateLaunchParameters(grid, block);
                  if (validLaunchParams) {
                    ec_detr_kernel56<<<grid, block>>>(nx, gpu_U);
                  }

                  lin_needsGpuEnsureCapacity = false;
                  m = static_cast<int32_T>(sz[0]);
                  if (static_cast<int32_T>(sz[0]) > 1) {
                    npages = 2;
                    if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>
                        (sz[1]) - 1) {
                      cpu_n = static_cast<int32_T>(sz[0]) - 1;
                    } else {
                      cpu_n = static_cast<int32_T>(sz[1]);
                    }

                    for (j = 0; j < cpu_n; j++) {
                      b = computeEndIdx(static_cast<int64_T>(npages),
                                        static_cast<int64_T>(m), 1L);
                      mwGetLaunchParameters1D(computeNumIters(b), &grid, &block,
                        2147483647U);
                      validLaunchParams = mwValidateLaunchParameters(grid, block);
                      if (validLaunchParams) {
                        ec_detr_kernel57<<<grid, block>>>(j + 1, npages, b,
                          gpu_U, cpu_U->size[0U]);
                      }

                      npages++;
                    }
                  }

                  for (nx = 0; nx < 2; nx++) {
                    sz[nx] = static_cast<uint32_T>(cpu_A->size[nx]);
                  }

                  j = cpu_A->size[0] * cpu_A->size[1];
                  cpu_A->size[0] = static_cast<int32_T>(sz[0]);
                  cpu_A->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real32_T(cpu_A, j, &qb_emlrtRTEI);
                  nx = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                    2147483647U);
                  gpuEmxEnsureCapacity_real32_T(cpu_A, &b_gpu_A, true);
                  validLaunchParams = mwValidateLaunchParameters(grid, block);
                  if (validLaunchParams) {
                    ec_detr_kernel58<<<grid, block>>>(nx, b_gpu_A);
                  }

                  A_outdatedOnCpu = true;
                } else {
                  ptrdiff_t b_n_t;
                  ptrdiff_t e_info_t;
                  n = cpu_A->size[0];
                  w_outdatedOnCpu = false;
                  j = cpu_tau->size[0];
                  cpu_tau->size[0] = cpu_A->size[0] - 1;
                  emxEnsureCapacity_real32_T(cpu_tau, j, &cb_emlrtRTEI);
                  if (cpu_A->size[0] > 1) {
                    ptrdiff_t b_info_t;
                    if (A_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &b_gpu_A);
                    }

                    b_info_t = LAPACKE_sgehrd(102, (ptrdiff_t)cpu_A->size[0],
                      (ptrdiff_t)1, (ptrdiff_t)cpu_A->size[0], &cpu_A->data[0],
                      (ptrdiff_t)cpu_A->size[0], &cpu_tau->data[0]);
                    A_outdatedOnCpu = false;
                    A_outdatedOnGpu = true;
                    lin_needsGpuEnsureCapacity = true;
                    if ((int32_T)b_info_t != 0) {
                      for (nx = 0; nx < 2; nx++) {
                        fv2[nx] = cpu_A->size[nx];
                      }

                      j = cpu_A->size[0] * cpu_A->size[1];
                      cpu_A->size[0] = fv2[0];
                      cpu_A->size[1] = fv2[1];
                      emxEnsureCapacity_real32_T(cpu_A, j, &mb_emlrtRTEI);
                      nx = fv2[0] * fv2[1] - 1;
                      mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                        2147483647U);
                      gpuEmxEnsureCapacity_real32_T(cpu_A, &b_gpu_A, true);
                      lin_needsGpuEnsureCapacity = false;
                      validLaunchParams = mwValidateLaunchParameters(grid, block);
                      if (validLaunchParams) {
                        ec_detr_kernel61<<<grid, block>>>(nx, b_gpu_A);
                      }

                      A_outdatedOnGpu = false;
                      A_outdatedOnCpu = true;
                      npages = cpu_tau->size[0];
                      j = cpu_tau->size[0];
                      cpu_tau->size[0] = npages;
                      emxEnsureCapacity_real32_T(cpu_tau, j, &sb_emlrtRTEI);
                      mwGetLaunchParameters1D(computeNumIters(npages - 1), &grid,
                        &block, 2147483647U);
                      gpuEmxEnsureCapacity_real32_T(cpu_tau, &b_gpu_tau, true);
                      validLaunchParams = mwValidateLaunchParameters(grid, block);
                      if (validLaunchParams) {
                        ec_detr_kernel62<<<grid, block>>>(npages - 1, b_gpu_tau);
                      }

                      w_outdatedOnCpu = true;
                    }
                  }

                  j = cpu_U->size[0] * cpu_U->size[1];
                  cpu_U->size[0] = cpu_A->size[0];
                  cpu_U->size[1] = cpu_A->size[1];
                  emxEnsureCapacity_real32_T(cpu_U, j, &ib_emlrtRTEI);
                  npages = cpu_A->size[0] * cpu_A->size[1] - 1;
                  mwGetLaunchParameters1D(computeNumIters(npages), &grid, &block,
                    2147483647U);
                  if (lin_needsGpuEnsureCapacity) {
                    gpuEmxEnsureCapacity_real32_T(cpu_A, &b_gpu_A,
                      !A_outdatedOnGpu);
                  }

                  gpuEmxEnsureCapacity_real32_T(cpu_U, &gpu_U, true);
                  if (A_outdatedOnGpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_A, cpu_A);
                  }

                  validLaunchParams = mwValidateLaunchParameters(grid, block);
                  if (validLaunchParams) {
                    ec_detr_kernel63<<<grid, block>>>(b_gpu_A, npages, gpu_U);
                  }

                  if (n == 1) {
                    ec_detr_kernel64<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (gpu_U);
                    w_outdatedOnCpu = true;
                  } else {
                    ptrdiff_t c_info_t;
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_U, &gpu_U);
                    if (w_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(cpu_tau, &b_gpu_tau);
                    }

                    c_info_t = LAPACKE_sorghr(102, (ptrdiff_t)n, (ptrdiff_t)1,
                      (ptrdiff_t)n, &cpu_U->data[0], (ptrdiff_t)n,
                      &cpu_tau->data[0]);
                    w_outdatedOnCpu = false;
                    if ((int32_T)c_info_t != 0) {
                      for (nx = 0; nx < 2; nx++) {
                        fv2[nx] = cpu_U->size[nx];
                      }

                      j = cpu_U->size[0] * cpu_U->size[1];
                      cpu_U->size[0] = fv2[0];
                      cpu_U->size[1] = fv2[1];
                      emxEnsureCapacity_real32_T(cpu_U, j, &ib_emlrtRTEI);
                      nx = fv2[0] * fv2[1] - 1;
                      mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                        2147483647U);
                      gpuEmxEnsureCapacity_real32_T(cpu_U, &gpu_U, true);
                      validLaunchParams = mwValidateLaunchParameters(grid, block);
                      if (validLaunchParams) {
                        ec_detr_kernel67<<<grid, block>>>(nx, gpu_U);
                      }

                      w_outdatedOnCpu = true;
                    }
                  }

                  b_n_t = (ptrdiff_t)cpu_A->size[0];
                  j = wr->size[0] * wr->size[1];
                  wr->size[0] = 1;
                  wr->size[1] = cpu_A->size[0];
                  emxEnsureCapacity_real32_T(wr, j, &pb_emlrtRTEI);
                  j = wi->size[0] * wi->size[1];
                  wi->size[0] = 1;
                  wi->size[1] = cpu_A->size[0];
                  emxEnsureCapacity_real32_T(wi, j, &tb_emlrtRTEI);
                  if (A_outdatedOnCpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &b_gpu_A);
                  }

                  if (w_outdatedOnCpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_U, &gpu_U);
                  }

                  if (cpu_A->size[0] <= 1) {
                    nx = 1;
                  } else {
                    nx = cpu_A->size[0];
                  }

                  e_info_t = LAPACKE_shseqr(102, 'S', 'V', b_n_t, (ptrdiff_t)1,
                    (ptrdiff_t)cpu_A->size[0], &cpu_A->data[0], b_n_t, &wr->
                    data[0], &wi->data[0], &cpu_U->data[0], (ptrdiff_t)nx);
                  lin_needsGpuEnsureCapacity = true;
                  A_outdatedOnCpu = false;
                  w_outdatedOnCpu = true;
                  if ((int32_T)e_info_t < 0) {
                    for (nx = 0; nx < 2; nx++) {
                      fv2[nx] = cpu_A->size[nx];
                    }

                    j = cpu_A->size[0] * cpu_A->size[1];
                    cpu_A->size[0] = fv2[0];
                    cpu_A->size[1] = fv2[1];
                    emxEnsureCapacity_real32_T(cpu_A, j, &yb_emlrtRTEI);
                    nx = fv2[0] * fv2[1] - 1;
                    mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                      2147483647U);
                    gpuEmxEnsureCapacity_real32_T(cpu_A, &b_gpu_A, true);
                    validLaunchParams = mwValidateLaunchParameters(grid, block);
                    if (validLaunchParams) {
                      ec_detr_kernel65<<<grid, block>>>(nx, b_gpu_A);
                    }

                    A_outdatedOnCpu = true;
                    for (nx = 0; nx < 2; nx++) {
                      fv2[nx] = cpu_U->size[nx];
                    }

                    j = cpu_U->size[0] * cpu_U->size[1];
                    cpu_U->size[0] = fv2[0];
                    cpu_U->size[1] = fv2[1];
                    emxEnsureCapacity_real32_T(cpu_U, j, &dc_emlrtRTEI);
                    nx = fv2[0] * fv2[1] - 1;
                    mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                      2147483647U);
                    gpuEmxEnsureCapacity_real32_T(cpu_U, &gpu_U, true);
                    w_outdatedOnCpu = false;
                    validLaunchParams = mwValidateLaunchParameters(grid, block);
                    if (validLaunchParams) {
                      ec_detr_kernel66<<<grid, block>>>(nx, gpu_U);
                    }

                    lin_needsGpuEnsureCapacity = false;
                  }
                }

                n = cpu_A->size[0];
                j = cpu_D->size[0] * cpu_D->size[1];
                cpu_D->size[0] = cpu_A->size[0];
                cpu_D->size[1] = cpu_A->size[0];
                emxEnsureCapacity_creal32_T(cpu_D, j, &wb_emlrtRTEI);
                npages = cpu_A->size[0] * cpu_A->size[0] - 1;
                mwGetLaunchParameters1D(computeNumIters(npages), &grid, &block,
                  2147483647U);
                gpuEmxEnsureCapacity_creal32_T(cpu_D, &gpu_D, true);
                x_outdatedOnGpu = false;
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_detr_kernel59<<<grid, block>>>(npages, gpu_D);
                }

                w_outdatedOnGpu = true;
                m = 1;
                do {
                  exitg1 = 0;
                  if (m <= n) {
                    if (m != n) {
                      if (A_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &b_gpu_A);
                      }

                      A_outdatedOnCpu = false;
                      if (cpu_A->data[m + cpu_A->size[0] * (m - 1)] != 0.0F) {
                        cpu_mn = std::abs(cpu_A->data[m + cpu_A->size[0] * (m -
                          1)]);
                        if (w_outdatedOnGpu) {
                          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &gpu_D);
                        }

                        cpu_D->data[(m + cpu_D->size[0] * (m - 1)) - 1].re =
                          0.0F;
                        cpu_D->data[(m + cpu_D->size[0] * (m - 1)) - 1].im =
                          cpu_mn;
                        cpu_D->data[m + cpu_D->size[0] * m].re = 0.0F;
                        cpu_D->data[m + cpu_D->size[0] * m].im = -cpu_mn;
                        w_outdatedOnGpu = false;
                        D_outdatedOnGpu = true;
                        x_outdatedOnGpu = true;
                        m += 2;
                      } else {
                        m++;
                      }
                    } else {
                      m++;
                    }
                  } else {
                    exitg1 = 1;
                  }
                } while (exitg1 == 0);

                j = cpu_V->size[0] * cpu_V->size[1];
                cpu_V->size[0] = cpu_U->size[0];
                cpu_V->size[1] = cpu_U->size[1];
                emxEnsureCapacity_creal32_T(cpu_V, j, &cc_emlrtRTEI);
                nx = cpu_U->size[0] * cpu_U->size[1] - 1;
                mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                  2147483647U);
                if (w_outdatedOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_U, &gpu_U,
                    !lin_needsGpuEnsureCapacity);
                }

                gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V, true);
                w_needsGpuEnsureCapacity = false;
                if (lin_needsGpuEnsureCapacity) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, cpu_U);
                }

                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_detr_kernel60<<<grid, block>>>(gpu_U, nx, gpu_V);
                }

                w_outdatedOnCpu = true;
                j = 1;
                n = cpu_A->size[0];
                do {
                  exitg1 = 0;
                  if (j <= n) {
                    if (j != n) {
                      if (A_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &b_gpu_A);
                      }

                      A_outdatedOnCpu = false;
                      if (cpu_A->data[j + cpu_A->size[0] * (j - 1)] != 0.0F) {
                        if (cpu_A->data[j + cpu_A->size[0] * (j - 1)] < 0.0F) {
                          cpu_n = 1;
                        } else {
                          cpu_n = -1;
                        }

                        for (m = 0; m < n; m++) {
                          if (w_outdatedOnCpu) {
                            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_V, &gpu_V);
                          }

                          cpu_mn = cpu_V->data[m + cpu_V->size[0] * (j - 1)].re;
                          abnrm = static_cast<real32_T>(cpu_n) * cpu_V->data[m +
                            cpu_V->size[0] * j].re;
                          if (abnrm == 0.0F) {
                            cpu_V->data[m + cpu_V->size[0] * (j - 1)].re =
                              cpu_mn / 1.41421354F;
                            cpu_V->data[m + cpu_V->size[0] * (j - 1)].im = 0.0F;
                            w_outdatedOnCpu = false;
                          } else if (cpu_mn == 0.0F) {
                            cpu_V->data[m + cpu_V->size[0] * (j - 1)].re = 0.0F;
                            cpu_V->data[m + cpu_V->size[0] * (j - 1)].im = abnrm
                              / 1.41421354F;
                            w_outdatedOnCpu = false;
                          } else {
                            cpu_V->data[m + cpu_V->size[0] * (j - 1)].re =
                              cpu_mn / 1.41421354F;
                            cpu_V->data[m + cpu_V->size[0] * (j - 1)].im = abnrm
                              / 1.41421354F;
                            w_outdatedOnCpu = false;
                          }

                          cpu_V->data[m + cpu_V->size[0] * j].re = cpu_V->data[m
                            + cpu_V->size[0] * (j - 1)].re;
                          cpu_V->data[m + cpu_V->size[0] * j].im = -cpu_V->
                            data[m + cpu_V->size[0] * (j - 1)].im;
                          x_needsGpuEnsureCapacity = true;
                          w_needsGpuEnsureCapacity = true;
                        }

                        j += 2;
                      } else {
                        j++;
                      }
                    } else {
                      j++;
                    }
                  } else {
                    exitg1 = 1;
                  }
                } while (exitg1 == 0);
              } else {
                ptrdiff_t d_info_t;
                n = cpu_A->size[0];
                cpu_n = cpu_A->size[1] - 1;
                j = scale->size[0];
                scale->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(scale, j, &x_emlrtRTEI);
                j = b_cpu_W->size[0];
                b_cpu_W->size[0] = cpu_A->size[1];
                emxEnsureCapacity_creal32_T(b_cpu_W, j, &y_emlrtRTEI);
                j = cpu_V->size[0] * cpu_V->size[1];
                cpu_V->size[0] = cpu_A->size[1];
                cpu_V->size[1] = cpu_A->size[1];
                emxEnsureCapacity_creal32_T(cpu_V, j, &eb_emlrtRTEI);
                j = cpu_wreal->size[0];
                cpu_wreal->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(cpu_wreal, j, &hb_emlrtRTEI);
                j = cpu_wimag->size[0];
                cpu_wimag->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(cpu_wimag, j, &jb_emlrtRTEI);
                j = cpu_vright->size[0] * cpu_vright->size[1];
                cpu_vright->size[0] = cpu_A->size[1];
                cpu_vright->size[1] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(cpu_vright, j, &nb_emlrtRTEI);
                if (A_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &b_gpu_A);
                }

                d_info_t = LAPACKE_sgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)
                  cpu_A->size[1], &cpu_A->data[0], (ptrdiff_t)cpu_A->size[0],
                  &cpu_wreal->data[0], &cpu_wimag->data[0], &cpu_mn, (ptrdiff_t)
                  1, &cpu_vright->data[0], (ptrdiff_t)cpu_A->size[1], &ilo_t,
                  &ihi_t, &scale->data[0], &abnrm, &rconde, &rcondv);
                if ((int32_T)d_info_t < 0) {
                  j = b_cpu_W->size[0];
                  b_cpu_W->size[0] = cpu_A->size[1];
                  emxEnsureCapacity_creal32_T(b_cpu_W, j, &ub_emlrtRTEI);
                  npages = cpu_A->size[1] - 1;
                  mwGetLaunchParameters1D(computeNumIters(npages), &grid, &block,
                    2147483647U);
                  gpuEmxEnsureCapacity_creal32_T(b_cpu_W, &b_gpu_W, true);
                  validLaunchParams = mwValidateLaunchParameters(grid, block);
                  if (validLaunchParams) {
                    ec_detr_kernel68<<<grid, block>>>(fc, npages, b_gpu_W);
                  }

                  w_outdatedOnCpu = true;
                  for (nx = 0; nx < 2; nx++) {
                    fv2[nx] = cpu_V->size[nx];
                  }

                  j = cpu_V->size[0] * cpu_V->size[1];
                  cpu_V->size[0] = fv2[0];
                  cpu_V->size[1] = fv2[1];
                  emxEnsureCapacity_creal32_T(cpu_V, j, &ac_emlrtRTEI);
                  nx = fv2[0] * fv2[1] - 1;
                  mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                    2147483647U);
                  gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V, true);
                  w_needsGpuEnsureCapacity = false;
                  validLaunchParams = mwValidateLaunchParameters(grid, block);
                  if (validLaunchParams) {
                    ec_detr_kernel69<<<grid, block>>>(fc, nx, gpu_V);
                  }
                } else {
                  mwGetLaunchParameters1D(computeNumIters(cpu_n), &grid, &block,
                    2147483647U);
                  gpuEmxEnsureCapacity_real32_T(cpu_wimag, &gpu_wimag, false);
                  gpuEmxEnsureCapacity_real32_T(cpu_wreal, &gpu_wreal, false);
                  gpuEmxEnsureCapacity_creal32_T(b_cpu_W, &b_gpu_W, true);
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_wimag, cpu_wimag);
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_wreal, cpu_wreal);
                  validLaunchParams = mwValidateLaunchParameters(grid, block);
                  if (validLaunchParams) {
                    ec_detr_kernel71<<<grid, block>>>(gpu_wimag, gpu_wreal,
                      cpu_n, b_gpu_W);
                  }

                  w_outdatedOnCpu = true;
                  j = cpu_V->size[0] * cpu_V->size[1];
                  cpu_V->size[0] = cpu_vright->size[0];
                  cpu_V->size[1] = cpu_vright->size[1];
                  emxEnsureCapacity_creal32_T(cpu_V, j, &vb_emlrtRTEI);
                  nx = cpu_vright->size[0] * cpu_vright->size[1] - 1;
                  mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                    2147483647U);
                  gpuEmxEnsureCapacity_real32_T(cpu_vright, &gpu_vright, false);
                  gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V, true);
                  w_needsGpuEnsureCapacity = false;
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_vright, cpu_vright);
                  validLaunchParams = mwValidateLaunchParameters(grid, block);
                  if (validLaunchParams) {
                    ec_detr_kernel72<<<grid, block>>>(gpu_vright, nx, gpu_V);
                  }

                  for (m = 0; m < cpu_n; m++) {
                    if ((cpu_wimag->data[m] > 0.0F) && (cpu_wimag->data[m + 1] <
                         0.0F)) {
                      mwGetLaunchParameters1D(computeNumIters(cpu_n), &grid,
                        &block, 2147483647U);
                      validLaunchParams = mwValidateLaunchParameters(grid, block);
                      if (validLaunchParams) {
                        ec_detr_kernel73<<<grid, block>>>(m + 2, cpu_n, gpu_V,
                          cpu_V->size[0U]);
                      }
                    }
                  }
                }

                j = cpu_D->size[0] * cpu_D->size[1];
                cpu_D->size[0] = cpu_A->size[0];
                cpu_D->size[1] = cpu_A->size[0];
                emxEnsureCapacity_creal32_T(cpu_D, j, &bc_emlrtRTEI);
                npages = cpu_A->size[0] * cpu_A->size[0] - 1;
                mwGetLaunchParameters1D(computeNumIters(npages), &grid, &block,
                  2147483647U);
                gpuEmxEnsureCapacity_creal32_T(cpu_D, &gpu_D, true);
                x_outdatedOnGpu = false;
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_detr_kernel70<<<grid, block>>>(npages, gpu_D);
                }

                w_outdatedOnGpu = true;
                for (m = 0; m < n; m++) {
                  if (w_outdatedOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &gpu_D);
                  }

                  if (w_outdatedOnCpu) {
                    gpuEmxMemcpyGpuToCpu_creal32_T(b_cpu_W, &b_gpu_W);
                  }

                  w_outdatedOnCpu = false;
                  cpu_D->data[m + cpu_D->size[0] * m] = b_cpu_W->data[m];
                  w_outdatedOnGpu = false;
                  D_outdatedOnGpu = true;
                  x_outdatedOnGpu = true;
                }
              }
            }
          }
        }

        // 'ec_detr:112' V = real(V);
        j = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = cpu_V->size[0];
        b_cpu_V->size[1] = cpu_V->size[1];
        emxEnsureCapacity_real32_T(b_cpu_V, j, &s_emlrtRTEI);
        nx = cpu_V->size[0] * cpu_V->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
        if (w_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V,
            !x_needsGpuEnsureCapacity);
        }

        gpuEmxEnsureCapacity_real32_T(b_cpu_V, &b_gpu_V, true);
        if (x_needsGpuEnsureCapacity) {
          gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, cpu_V);
        }

        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel19<<<grid, block>>>(gpu_V, nx, b_gpu_V);
        }

        // 'ec_detr:113' D = real(diag(D));
        if ((cpu_D->size[0] == 1) && (cpu_D->size[1] == 1)) {
          j = cpu_d->size[0];
          cpu_d->size[0] = 1;
          emxEnsureCapacity_creal32_T(cpu_d, j, &w_emlrtRTEI);
          if (w_outdatedOnGpu) {
            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &gpu_D);
          }

          cpu_d->data[0] = cpu_D->data[0];
          w_outdatedOnCpu = false;
        } else {
          nx = cpu_D->size[0];
          npages = cpu_D->size[1];
          if (nx <= npages) {
            npages = nx;
          }

          if (cpu_D->size[1] > 0) {
            cpu_n = npages;
          } else {
            cpu_n = 0;
          }

          j = cpu_d->size[0];
          cpu_d->size[0] = cpu_n;
          emxEnsureCapacity_creal32_T(cpu_d, j, &u_emlrtRTEI);
          cpu_n--;
          mwGetLaunchParameters1D(computeNumIters(cpu_n), &grid, &block,
            2147483647U);
          if (x_outdatedOnGpu) {
            gpuEmxEnsureCapacity_creal32_T(cpu_D, &gpu_D, !D_outdatedOnGpu);
          }

          gpuEmxEnsureCapacity_creal32_T(cpu_d, &b_gpu_d, true);
          if (D_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, cpu_D);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel51<<<grid, block>>>(gpu_D, cpu_n, b_gpu_d, cpu_D->
              size[0U]);
          }

          w_outdatedOnCpu = true;
        }

        // 'ec_detr:114' V = V(:,D/max(D)>thrPCA);
        nx = cpu_d->size[0];
        if (w_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_d, &b_gpu_d);
        }

        cpu_mn = cpu_d->data[0].re;
        for (m = 0; m <= nx - 2; m++) {
          if (std::isnan(cpu_d->data[m + 1].re)) {
            w_outdatedOnCpu = false;
          } else if (std::isnan(cpu_mn)) {
            w_outdatedOnCpu = true;
          } else {
            w_outdatedOnCpu = (cpu_mn < cpu_d->data[m + 1].re);
          }

          if (w_outdatedOnCpu) {
            cpu_mn = cpu_d->data[m + 1].re;
          }
        }

        cpu_n = cpu_d->size[0] - 1;
        npages = 0;
        for (m = 0; m <= cpu_n; m++) {
          if (cpu_d->data[m].re / cpu_mn > 1.0E-7) {
            npages++;
          }
        }

        j = cpu_iv->size[0];
        cpu_iv->size[0] = npages;
        emxEnsureCapacity_int32_T(cpu_iv, j, &gb_emlrtRTEI);
        npages = 0;
        for (m = 0; m <= cpu_n; m++) {
          if (cpu_d->data[m].re / cpu_mn > 1.0E-7) {
            cpu_iv->data[npages] = m;
            iv_outdatedOnGpu = true;
            npages++;
          }
        }

        npages = b_cpu_V->size[0];
        j = c_cpu_V->size[0] * c_cpu_V->size[1];
        c_cpu_V->size[0] = b_cpu_V->size[0];
        c_cpu_V->size[1] = cpu_iv->size[0];
        emxEnsureCapacity_real32_T(c_cpu_V, j, &ob_emlrtRTEI);
        nx = cpu_iv->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx, npages - 1), &grid, &block,
          2147483647U);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, !iv_outdatedOnGpu);
        gpuEmxEnsureCapacity_real32_T(c_cpu_V, &c_gpu_V, true);
        if (iv_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv, cpu_iv);
        }

        iv_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel20<<<grid, block>>>(gpu_iv, b_gpu_V, npages - 1, nx,
            c_gpu_V, c_cpu_V->size[0U], b_cpu_V->size[0U]);
        }

        j = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = c_cpu_V->size[0];
        b_cpu_V->size[1] = c_cpu_V->size[1];
        emxEnsureCapacity_real32_T(b_cpu_V, j, &rb_emlrtRTEI);
        nx = c_cpu_V->size[0] * c_cpu_V->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real32_T(b_cpu_V, &b_gpu_V, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel21<<<grid, block>>>(c_gpu_V, nx, b_gpu_V);
        }

        //  discard weak dims
        // 'ec_detr:115' rr = rr*V;
        if ((cpu_rr->size[0] == 0) || (cpu_rr->size[1] == 0) || (b_cpu_V->size[0]
             == 0) || (b_cpu_V->size[1] == 0)) {
          j = cpu_C->size[0] * cpu_C->size[1];
          cpu_C->size[0] = cpu_rr->size[0];
          cpu_C->size[1] = b_cpu_V->size[1];
          emxEnsureCapacity_real32_T(cpu_C, j, &xb_emlrtRTEI);
          nx = cpu_rr->size[0] * b_cpu_V->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_C, &gpu_C, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel22<<<grid, block>>>(nx, gpu_C);
          }
        } else {
          j = cpu_C->size[0] * cpu_C->size[1];
          cpu_C->size[0] = cpu_rr->size[0];
          cpu_C->size[1] = b_cpu_V->size[1];
          emxEnsureCapacity_real32_T(cpu_C, j, &o_emlrtRTEI);
          cpu_mn = 1.0F;
          abnrm = 0.0F;
          gpuEmxEnsureCapacity_real32_T(cpu_C, &gpu_C, true);
          cublasCheck(cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N,
            CUBLAS_OP_N, cpu_rr->size[0], b_cpu_V->size[1], cpu_rr->size[1],
            (float *)&cpu_mn, (float *)&gpu_rr.data[0], cpu_rr->size[0], (float *)
            &b_gpu_V.data[0], cpu_rr->size[1], (float *)&abnrm, (float *)
            &gpu_C.data[0], cpu_rr->size[0]), __FILE__, __LINE__);
        }

        // 'ec_detr:116' b = (x'*rr) / (rr'*rr);
        j = c_cpu_A->size[0] * c_cpu_A->size[1];
        c_cpu_A->size[0] = 1;
        c_cpu_A->size[1] = cpu_fv3->size[0];
        emxEnsureCapacity_real32_T(c_cpu_A, j, &n_emlrtRTEI);
        nx = cpu_fv3->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
        if (fv3_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(cpu_fv3, &gpu_fv3, !fv3_outdatedOnGpu);
        }

        gpuEmxEnsureCapacity_real32_T(c_cpu_A, &c_gpu_A, true);
        if (fv3_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv3, cpu_fv3);
        }

        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel23<<<grid, block>>>(gpu_fv3, nx, c_gpu_A);
        }

        if ((cpu_fv3->size[0] == 0) || (cpu_C->size[0] == 0) || (cpu_C->size[1] ==
             0)) {
          j = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_C->size[1];
          emxEnsureCapacity_real32_T(cpu_b, j, &p_emlrtRTEI);
          nx = cpu_C->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b, true);
          x_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel24<<<grid, block>>>(nx, gpu_b);
          }

          D_outdatedOnGpu = false;
        } else {
          j = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_C->size[1];
          emxEnsureCapacity_real32_T(cpu_b, j, &o_emlrtRTEI);
          cpu_mn = 1.0F;
          abnrm = 0.0F;
          gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b, true);
          x_needsGpuEnsureCapacity = false;
          cublasCheck(cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N,
            CUBLAS_OP_N, 1, cpu_C->size[1], cpu_fv3->size[0], (float *)&cpu_mn,
            (float *)&c_gpu_A.data[0], 1, (float *)&gpu_C.data[0], cpu_fv3->
            size[0], (float *)&abnrm, (float *)&gpu_b.data[0], 1), __FILE__,
                      __LINE__);
          D_outdatedOnGpu = false;
        }

        j = d_cpu_A->size[0] * d_cpu_A->size[1];
        d_cpu_A->size[0] = cpu_C->size[1];
        d_cpu_A->size[1] = cpu_C->size[0];
        emxEnsureCapacity_real32_T(d_cpu_A, j, &n_emlrtRTEI);
        nx = cpu_C->size[0] - 1;
        npages = cpu_C->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx, npages), &grid, &block,
          2147483647U);
        gpuEmxEnsureCapacity_real32_T(d_cpu_A, &d_gpu_A, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel25<<<grid, block>>>(gpu_C, npages, nx, d_gpu_A,
            d_cpu_A->size[0U], cpu_C->size[0U]);
        }

        if ((d_cpu_A->size[0] == 0) || (d_cpu_A->size[1] == 0) || (cpu_C->size[0]
             == 0) || (cpu_C->size[1] == 0)) {
          j = e_cpu_A->size[0] * e_cpu_A->size[1];
          e_cpu_A->size[0] = d_cpu_A->size[0];
          e_cpu_A->size[1] = cpu_C->size[1];
          emxEnsureCapacity_real32_T(e_cpu_A, j, &p_emlrtRTEI);
          npages = d_cpu_A->size[0] * cpu_C->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(npages), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_real32_T(e_cpu_A, &e_gpu_A, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel26<<<grid, block>>>(npages, e_gpu_A);
          }
        } else {
          j = e_cpu_A->size[0] * e_cpu_A->size[1];
          e_cpu_A->size[0] = d_cpu_A->size[0];
          e_cpu_A->size[1] = cpu_C->size[1];
          emxEnsureCapacity_real32_T(e_cpu_A, j, &o_emlrtRTEI);
          cpu_mn = 1.0F;
          abnrm = 0.0F;
          gpuEmxEnsureCapacity_real32_T(e_cpu_A, &e_gpu_A, true);
          cublasCheck(cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N,
            CUBLAS_OP_N, d_cpu_A->size[0], cpu_C->size[1], d_cpu_A->size[1],
            (float *)&cpu_mn, (float *)&d_gpu_A.data[0], d_cpu_A->size[0],
            (float *)&gpu_C.data[0], d_cpu_A->size[1], (float *)&abnrm, (float *)
            &e_gpu_A.data[0], d_cpu_A->size[0]), __FILE__, __LINE__);
        }

        if ((cpu_b->size[1] == 0) || ((e_cpu_A->size[0] == 0) || (e_cpu_A->size
              [1] == 0))) {
          sz[1] = static_cast<uint32_T>(e_cpu_A->size[0]);
          j = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = e_cpu_A->size[0];
          emxEnsureCapacity_real32_T(cpu_b, j, &gc_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(sz[1]) -
            1), &grid, &block, 2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel27<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
              gpu_b);
          }
        } else if (e_cpu_A->size[0] == e_cpu_A->size[1]) {
          n = e_cpu_A->size[1] - 2;
          j = cpu_ipiv_t->size[0];
          cpu_ipiv_t->size[0] = e_cpu_A->size[1];
          emxEnsureCapacity_int32_T(cpu_ipiv_t, j, &ec_emlrtRTEI);
          cusolverCheck(cusolverDnSgetrf_bufferSize(getCuSolverGlobalHandle(),
            e_cpu_A->size[1], e_cpu_A->size[1], (float *)&e_gpu_A.data[0],
            e_cpu_A->size[1], getCuSolverWorkspaceReq()), __FILE__, __LINE__);
          setCuSolverWorkspaceTypeSize(4);
          cusolverInitWorkspace();
          gpuEmxEnsureCapacity_int32_T(cpu_ipiv_t, &gpu_ipiv_t, true);
          cusolverCheck(cusolverDnSgetrf(getCuSolverGlobalHandle(),
            e_cpu_A->size[1], e_cpu_A->size[1], (float *)&e_gpu_A.data[0],
            e_cpu_A->size[1], static_cast<real32_T *>(getCuSolverWorkspaceBuff()),
            &gpu_ipiv_t.data[0], gpu_n), __FILE__, __LINE__);
          j = cpu_ipiv->size[0] * cpu_ipiv->size[1];
          cpu_ipiv->size[0] = 1;
          cpu_ipiv->size[1] = cpu_ipiv_t->size[0];
          emxEnsureCapacity_int32_T(cpu_ipiv, j, &hc_emlrtRTEI);
          checkCudaError(cudaMemcpy(&cpu_n, gpu_n, 4UL, cudaMemcpyDeviceToHost),
                         __FILE__, __LINE__);
          if (cpu_n < 0) {
            for (nx = 0; nx < 2; nx++) {
              fv2[nx] = e_cpu_A->size[nx];
            }

            j = e_cpu_A->size[0] * e_cpu_A->size[1];
            e_cpu_A->size[0] = fv2[0];
            e_cpu_A->size[1] = fv2[1];
            emxEnsureCapacity_real32_T(e_cpu_A, j, &kc_emlrtRTEI);
            nx = fv2[0] * fv2[1] - 1;
            mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_real32_T(e_cpu_A, &e_gpu_A, true);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_detr_kernel37<<<grid, block>>>(nx, e_gpu_A);
            }

            cpu_n = cpu_ipiv->size[1] - 1;
            mwGetLaunchParameters1D(computeNumIters(cpu_n), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_int32_T(cpu_ipiv, &gpu_ipiv, true);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_detr_kernel38<<<grid, block>>>(cpu_n, gpu_ipiv);
            }

            w_outdatedOnCpu = true;
          } else {
            cpu_n = cpu_ipiv_t->size[0] - 1;
            mwGetLaunchParameters1D(computeNumIters(cpu_n), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_int32_T(cpu_ipiv, &gpu_ipiv, true);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_detr_kernel39<<<grid, block>>>(gpu_ipiv_t, cpu_n, gpu_ipiv);
            }

            w_outdatedOnCpu = true;
          }

          cpu_mn = 1.0F;
          cublasCheck(cublasStrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
            CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N, CUBLAS_DIAG_NON_UNIT, 1, n + 2,
            (float *)&cpu_mn, (float *)&e_gpu_A.data[0], n + 2, (float *)
            &gpu_b.data[0], 1), __FILE__, __LINE__);
          cublasCheck(cublasStrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
            CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1, n + 2,
            (float *)&cpu_mn, (float *)&e_gpu_A.data[0], n + 2, (float *)
            &gpu_b.data[0], 1), __FILE__, __LINE__);
          lin_needsGpuEnsureCapacity = true;
          for (j = 0; j <= n; j++) {
            if (w_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_ipiv, &gpu_ipiv);
            }

            w_outdatedOnCpu = false;
            if (cpu_ipiv->data[n - j] != (n - j) + 1) {
              if (lin_needsGpuEnsureCapacity) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, &gpu_b);
              }

              cpu_mn = cpu_b->data[n - j];
              cpu_b->data[n - j] = cpu_b->data[cpu_ipiv->data[n - j] - 1];
              cpu_b->data[cpu_ipiv->data[n - j] - 1] = cpu_mn;
              lin_needsGpuEnsureCapacity = false;
              D_outdatedOnGpu = true;
              x_needsGpuEnsureCapacity = true;
            }
          }
        } else {
          ptrdiff_t f_info_t;
          j = f_cpu_A->size[0] * f_cpu_A->size[1];
          f_cpu_A->size[0] = e_cpu_A->size[1];
          f_cpu_A->size[1] = e_cpu_A->size[0];
          emxEnsureCapacity_real32_T(f_cpu_A, j, &fc_emlrtRTEI);
          npages = e_cpu_A->size[0] - 1;
          nx = e_cpu_A->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(npages, nx), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_real32_T(f_cpu_A, &f_gpu_A, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel40<<<grid, block>>>(e_gpu_A, nx, npages, f_gpu_A,
              f_cpu_A->size[0U], e_cpu_A->size[0U]);
          }

          j = cpu_B->size[0];
          cpu_B->size[0] = cpu_b->size[1];
          emxEnsureCapacity_real32_T(cpu_B, j, &ic_emlrtRTEI);
          nx = cpu_b->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_B, &b_gpu_B, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel41<<<grid, block>>>(gpu_b, nx, b_gpu_B);
          }

          m = f_cpu_A->size[0];
          n = f_cpu_A->size[1] - 1;
          j = cpu_jpvt->size[0] * cpu_jpvt->size[1];
          cpu_jpvt->size[0] = 1;
          cpu_jpvt->size[1] = f_cpu_A->size[1];
          emxEnsureCapacity_int32_T(cpu_jpvt, j, &lc_emlrtRTEI);
          npages = f_cpu_A->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(npages), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &gpu_jpvt, true);
          w_outdatedOnCpu = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel42<<<grid, block>>>(npages, gpu_jpvt);
          }

          w_outdatedOnGpu = false;
          x_outdatedOnGpu = true;
          nx = f_cpu_A->size[0];
          npages = f_cpu_A->size[1];
          if (nx <= npages) {
            npages = nx;
          }

          j = b_cpu_tau->size[0];
          b_cpu_tau->size[0] = npages;
          emxEnsureCapacity_real32_T(b_cpu_tau, j, &mc_emlrtRTEI);
          j = jpvt_t->size[0];
          jpvt_t->size[0] = f_cpu_A->size[1];
          emxEnsureCapacity_ptrdiff_t(jpvt_t, j, &nc_emlrtRTEI);
          for (j = 0; j < f_cpu_A->size[1]; j++) {
            jpvt_t->data[j] = (ptrdiff_t)0;
          }

          gpuEmxMemcpyGpuToCpu_real32_T(f_cpu_A, &f_gpu_A);
          f_info_t = LAPACKE_sgeqp3(102, (ptrdiff_t)f_cpu_A->size[0], (ptrdiff_t)
            f_cpu_A->size[1], &f_cpu_A->data[0], (ptrdiff_t)f_cpu_A->size[0],
            &jpvt_t->data[0], &b_cpu_tau->data[0]);
          lin_needsGpuEnsureCapacity = true;
          A_outdatedOnCpu = false;
          A_outdatedOnGpu = true;
          w_needsGpuEnsureCapacity = true;
          if ((int32_T)f_info_t != 0) {
            mwGetLaunchParameters1D(computeNumIters(n, m - 1), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_real32_T(f_cpu_A, &f_gpu_A, false);
            gpuEmxMemcpyCpuToGpu_real32_T(&f_gpu_A, f_cpu_A);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_detr_kernel43<<<grid, block>>>(m - 1, n, f_gpu_A, f_cpu_A->
                size[0U]);
            }

            A_outdatedOnGpu = false;
            A_outdatedOnCpu = true;
            nx = f_cpu_A->size[0];
            cpu_n = f_cpu_A->size[1];
            if (nx <= cpu_n) {
              cpu_n = nx;
            }

            mwGetLaunchParameters1D(computeNumIters(cpu_n - 1), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_real32_T(b_cpu_tau, &gpu_tau, false);
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_tau, b_cpu_tau);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_detr_kernel44<<<grid, block>>>(cpu_n - 1, gpu_tau);
            }

            b = computeEndIdx(static_cast<int64_T>(cpu_n + 1),
                              static_cast<int64_T>(npages), 1L);
            mwGetLaunchParameters1D(computeNumIters(b), &grid, &block,
              2147483647U);
            w_needsGpuEnsureCapacity = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_detr_kernel45<<<grid, block>>>(cpu_n + 1, b, gpu_tau);
            }

            lin_needsGpuEnsureCapacity = false;
            mwGetLaunchParameters1D(computeNumIters(n), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_detr_kernel46<<<grid, block>>>(n, gpu_jpvt);
            }
          } else {
            for (m = 0; m <= n; m++) {
              if (x_outdatedOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &gpu_jpvt);
              }

              cpu_jpvt->data[m] = (int32_T)jpvt_t->data[m];
              x_outdatedOnGpu = false;
              w_outdatedOnGpu = true;
              w_outdatedOnCpu = true;
            }
          }

          n = -1;
          if (f_cpu_A->size[0] < f_cpu_A->size[1]) {
            cpu_n = f_cpu_A->size[0];
            npages = f_cpu_A->size[1];
          } else {
            cpu_n = f_cpu_A->size[1];
            npages = f_cpu_A->size[0];
          }

          if (A_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(f_cpu_A, &f_gpu_A);
          }

          cpu_mn = std::fmin(0.000345266977F, 1.1920929E-6F *
                             static_cast<real32_T>(npages)) * std::abs
            (f_cpu_A->data[0]);
          while ((n + 1 < cpu_n) && (!(std::abs(f_cpu_A->data[(n + f_cpu_A->
                     size[0] * (n + 1)) + 1]) <= cpu_mn))) {
            n++;
          }

          j = cpu_Y->size[0];
          cpu_Y->size[0] = f_cpu_A->size[1];
          emxEnsureCapacity_real32_T(cpu_Y, j, &rc_emlrtRTEI);
          npages = f_cpu_A->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(npages), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_Y, &gpu_Y, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel47<<<grid, block>>>(npages, gpu_Y);
          }

          cpu_n = 0;
          nx = f_cpu_A->size[0];
          npages = f_cpu_A->size[1];
          if (nx <= npages) {
            npages = nx;
          }

          gpuEmxEnsureCapacity_real32_T(f_cpu_A, &f_gpu_A, !A_outdatedOnGpu);
          if (w_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_tau, &gpu_tau,
              !lin_needsGpuEnsureCapacity);
          }

          if (A_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&f_gpu_A, f_cpu_A);
          }

          if (lin_needsGpuEnsureCapacity) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_tau, b_cpu_tau);
          }

          cusolverCheck(cusolverDnSormqr_bufferSize(getCuSolverGlobalHandle(),
            CUBLAS_SIDE_LEFT, CUBLAS_OP_T, cpu_B->size[0], 1, npages, (float *)
            &f_gpu_A.data[0], f_cpu_A->size[0], (float *)&gpu_tau.data[0],
            (float *)&b_gpu_B.data[0], cpu_B->size[0], getCuSolverWorkspaceReq()),
                        __FILE__, __LINE__);
          setCuSolverWorkspaceTypeSize(4);
          cusolverInitWorkspace();
          checkCudaError(cudaMemcpy(gpu_n, &cpu_n, 4UL, cudaMemcpyHostToDevice),
                         __FILE__, __LINE__);
          cusolverCheck(cusolverDnSormqr(getCuSolverGlobalHandle(),
            CUBLAS_SIDE_LEFT, CUBLAS_OP_T, cpu_B->size[0], 1, npages, (float *)
            &f_gpu_A.data[0], f_cpu_A->size[0], (float *)&gpu_tau.data[0],
            (float *)&b_gpu_B.data[0], cpu_B->size[0], static_cast<real32_T *>
            (getCuSolverWorkspaceBuff()), *getCuSolverWorkspaceReq(), gpu_n),
                        __FILE__, __LINE__);
          checkCudaError(cudaMemcpy(&cpu_n, gpu_n, 4UL, cudaMemcpyDeviceToHost),
                         __FILE__, __LINE__);
          if (cpu_n < 0) {
            npages = cpu_B->size[0];
            j = cpu_B->size[0];
            cpu_B->size[0] = npages;
            emxEnsureCapacity_real32_T(cpu_B, j, &uc_emlrtRTEI);
            mwGetLaunchParameters1D(computeNumIters(npages - 1), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_real32_T(cpu_B, &b_gpu_B, true);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_detr_kernel48<<<grid, block>>>(npages - 1, b_gpu_B);
            }
          }

          mwGetLaunchParameters1D(computeNumIters(n), &grid, &block, 2147483647U);
          if (w_outdatedOnCpu) {
            gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &gpu_jpvt, !w_outdatedOnGpu);
          }

          w_needsGpuEnsureCapacity = false;
          if (w_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel49<<<grid, block>>>(b_gpu_B, gpu_jpvt, n, gpu_Y);
          }

          w_outdatedOnCpu = false;
          lin_needsGpuEnsureCapacity = true;
          for (j = 0; j <= n; j++) {
            if (lin_needsGpuEnsureCapacity) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_Y, &gpu_Y);
            }

            if (x_outdatedOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &gpu_jpvt);
            }

            x_outdatedOnGpu = false;
            cpu_Y->data[cpu_jpvt->data[n - j] - 1] /= f_cpu_A->data[(n - j) +
              f_cpu_A->size[0] * (n - j)];
            lin_needsGpuEnsureCapacity = false;
            w_outdatedOnCpu = true;
            w_needsGpuEnsureCapacity = true;
            npages = n - j;
            for (m = 0; m < npages; m++) {
              cpu_Y->data[cpu_jpvt->data[m] - 1] -= cpu_Y->data[cpu_jpvt->data[n
                - j] - 1] * f_cpu_A->data[m + f_cpu_A->size[0] * (n - j)];
            }
          }

          j = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_Y->size[0];
          emxEnsureCapacity_real32_T(cpu_b, j, &gc_emlrtRTEI);
          nx = cpu_Y->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          if (w_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_Y, &gpu_Y, !w_outdatedOnCpu);
          }

          gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b, true);
          if (w_outdatedOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_Y, cpu_Y);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel50<<<grid, block>>>(gpu_Y, nx, gpu_b);
          }
        }

        // 'ec_detr:117' z = r*(V*b') + mn;
        j = b_cpu_B->size[0];
        b_cpu_B->size[0] = cpu_b->size[1];
        emxEnsureCapacity_real32_T(b_cpu_B, j, &jc_emlrtRTEI);
        nx = cpu_b->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
        if (x_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b, !D_outdatedOnGpu);
        }

        gpuEmxEnsureCapacity_real32_T(b_cpu_B, &gpu_B, true);
        if (D_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
        }

        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel28<<<grid, block>>>(gpu_b, nx, gpu_B);
        }

        if ((b_cpu_V->size[0] == 0) || (b_cpu_V->size[1] == 0) || (b_cpu_B->
             size[0] == 0)) {
          j = b_cpu_y->size[0];
          b_cpu_y->size[0] = b_cpu_V->size[0];
          emxEnsureCapacity_real32_T(b_cpu_y, j, &p_emlrtRTEI);
          nx = b_cpu_V->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_real32_T(b_cpu_y, &b_gpu_y, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel29<<<grid, block>>>(nx, b_gpu_y);
          }
        } else {
          j = b_cpu_y->size[0];
          b_cpu_y->size[0] = b_cpu_V->size[0];
          emxEnsureCapacity_real32_T(b_cpu_y, j, &o_emlrtRTEI);
          cpu_mn = 1.0F;
          abnrm = 0.0F;
          gpuEmxEnsureCapacity_real32_T(b_cpu_y, &b_gpu_y, true);
          cublasCheck(cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N,
            CUBLAS_OP_N, b_cpu_V->size[0], 1, b_cpu_V->size[1], (float *)&cpu_mn,
            (float *)&b_gpu_V.data[0], b_cpu_V->size[0], (float *)&gpu_B.data[0],
            b_cpu_V->size[1], (float *)&abnrm, (float *)&b_gpu_y.data[0],
            b_cpu_V->size[0]), __FILE__, __LINE__);
        }

        if ((cpu_r->size[0] == 0) || (cpu_r->size[1] == 0) || (b_cpu_y->size[0] ==
             0)) {
          j = cpu_fv4->size[0];
          cpu_fv4->size[0] = cpu_r->size[0];
          emxEnsureCapacity_real32_T(cpu_fv4, j, &oc_emlrtRTEI);
          nx = cpu_r->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_real32_T(cpu_fv4, &gpu_fv4, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel30<<<grid, block>>>(nx, gpu_fv4);
          }
        } else {
          j = cpu_fv4->size[0];
          cpu_fv4->size[0] = cpu_r->size[0];
          emxEnsureCapacity_real32_T(cpu_fv4, j, &o_emlrtRTEI);
          cpu_mn = 1.0F;
          abnrm = 0.0F;
          if (r_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_r, &gpu_r, true);
          }

          gpuEmxEnsureCapacity_real32_T(cpu_fv4, &gpu_fv4, true);
          cublasCheck(cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N,
            CUBLAS_OP_N, cpu_r->size[0], 1, cpu_r->size[1], (float *)&cpu_mn,
            (float *)&gpu_r.data[0], cpu_r->size[0], (float *)&b_gpu_y.data[0],
            cpu_r->size[1], (float *)&abnrm, (float *)&gpu_fv4.data[0],
            cpu_r->size[0]), __FILE__, __LINE__);
        }

        if (cpu_fv4->size[0] == cpu_fv1->size[0]) {
          j = cpu_z->size[0];
          cpu_z->size[0] = cpu_fv4->size[0];
          emxEnsureCapacity_real32_T(cpu_z, j, &pc_emlrtRTEI);
          nx = cpu_fv4->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          if (fv1_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1, true);
          }

          fv1_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z, true);
          w_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel31<<<grid, block>>>(mn, gpu_fv1, gpu_fv4, nx, gpu_z);
          }

          w_outdatedOnGpu = false;
          z_outdatedOnCpu = true;
        } else {
          if (z_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_z, &gpu_z);
          }

          gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv4, &gpu_fv4);
          if (fv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
          }

          fv1_outdatedOnCpu = false;
          binary_expand_op_1(cpu_z, cpu_fv4, cpu_fv1, mn);
          z_outdatedOnCpu = false;
          w_outdatedOnGpu = true;
          fv1_needsGpuEnsureCapacity = true;
          w_needsGpuEnsureCapacity = true;
        }

        //  Find outliers
        // 'ec_detr:86' d = (x-z).*w;
        if (cpu_fv1->size[0] == 1) {
          nx = cpu_z->size[0];
        } else {
          nx = cpu_fv1->size[0];
        }

        if ((cpu_fv1->size[0] == cpu_z->size[0]) && (nx == cpu_fv2->size[0])) {
          j = b_cpu_d->size[0];
          b_cpu_d->size[0] = cpu_fv1->size[0];
          emxEnsureCapacity_real32_T(b_cpu_d, j, &qc_emlrtRTEI);
          nx = cpu_fv1->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
            2147483647U);
          if (fv2_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv2, &gpu_fv2, true);
          }

          fv2_needsGpuEnsureCapacity = false;
          if (w_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z, !w_outdatedOnGpu);
          }

          w_needsGpuEnsureCapacity = false;
          if (fv1_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1, true);
          }

          fv1_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real32_T(b_cpu_d, &gpu_d, true);
          lin_needsGpuEnsureCapacity = false;
          if (w_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
          }

          w_outdatedOnGpu = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel32<<<grid, block>>>(gpu_fv2, gpu_z, gpu_fv1, nx, gpu_d);
          }

          w_outdatedOnCpu = false;
          d_outdatedOnCpu = true;
        } else {
          if (d_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_d, &gpu_d);
          }

          if (fv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
          }

          fv1_outdatedOnCpu = false;
          if (z_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_z, &gpu_z);
          }

          z_outdatedOnCpu = false;
          if (fv2_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          binary_expand_op(b_cpu_d, cpu_fv1, cpu_z, cpu_fv2);
          d_outdatedOnCpu = false;
          w_outdatedOnCpu = true;
          fv2_needsGpuEnsureCapacity = true;
          w_needsGpuEnsureCapacity = true;
          fv1_needsGpuEnsureCapacity = true;
          lin_needsGpuEnsureCapacity = true;
        }

        // 'ec_detr:87' thrItr = iThr*std(d);
        n = b_cpu_d->size[0] - 1;
        if (b_cpu_d->size[0] == 0) {
          cpu_mn = rtNaNF;
        } else if (b_cpu_d->size[0] == 1) {
          if (lin_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_d, &gpu_d, !w_outdatedOnCpu);
          }

          lin_needsGpuEnsureCapacity = false;
          if (w_outdatedOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_d, b_cpu_d);
          }

          w_outdatedOnCpu = false;
          ec_detr_kernel35<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_d,
            gpu_mn);
          checkCudaError(cudaMemcpy(&cpu_mn, gpu_mn, 4UL, cudaMemcpyDeviceToHost),
                         __FILE__, __LINE__);
        } else {
          if (d_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_d, &gpu_d);
          }

          d_outdatedOnCpu = false;
          cpu_mn = b_cpu_d->data[0];
          for (npages = 0; npages < n; npages++) {
            cpu_mn += b_cpu_d->data[npages + 1];
          }

          cpu_mn /= static_cast<real32_T>(b_cpu_d->size[0]);
          j = cpu_absdiff->size[0];
          cpu_absdiff->size[0] = b_cpu_d->size[0];
          emxEnsureCapacity_real32_T(cpu_absdiff, j, &sc_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(n), &grid, &block, 2147483647U);
          gpuEmxEnsureCapacity_real32_T(b_cpu_d, &gpu_d, !w_outdatedOnCpu);
          lin_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_real32_T(cpu_absdiff, &gpu_absdiff, true);
          if (w_outdatedOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_d, b_cpu_d);
          }

          w_outdatedOnCpu = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_detr_kernel36<<<grid, block>>>(cpu_mn, gpu_d, n, gpu_absdiff);
          }

          cublasCheck(cublasSnrm2(getCublasGlobalHandle(), b_cpu_d->size[0],
            (float *)&gpu_absdiff.data[0], 1, (float *)&cpu_mn), __FILE__,
                      __LINE__);
          cpu_mn /= std::sqrt(static_cast<real32_T>(b_cpu_d->size[0] - 1));
        }

        cpu_mn *= thr_data[ii];

        // 'ec_detr:88' w(abs(d)>thrItr) = 0;
        nx = b_cpu_d->size[0];
        j = c_cpu_y->size[0];
        c_cpu_y->size[0] = b_cpu_d->size[0];
        emxEnsureCapacity_real32_T(c_cpu_y, j, &tc_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
          2147483647U);
        if (lin_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(b_cpu_d, &gpu_d, !w_outdatedOnCpu);
        }

        gpuEmxEnsureCapacity_real32_T(c_cpu_y, &c_gpu_y, true);
        if (w_outdatedOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_d, b_cpu_d);
        }

        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel33<<<grid, block>>>(gpu_d, nx - 1, c_gpu_y);
        }

        cpu_n = c_cpu_y->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(cpu_n), &grid, &block,
          2147483647U);
        if (fv2_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(cpu_fv2, &gpu_fv2, true);
        }

        fv2_needsGpuEnsureCapacity = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel34<<<grid, block>>>(cpu_mn, c_gpu_y, cpu_n, gpu_fv2);
        }

        fv2_outdatedOnCpu = true;

        //  update weights
      }

      //  Remove trends
      // 'ec_detr:92' x = x-z;
      npages = cpu_x->size[0];
      if (npages == cpu_z->size[0]) {
        mwGetLaunchParameters1D(computeNumIters(npages - 1), &grid, &block,
          2147483647U);
        if (w_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z, !w_outdatedOnGpu);
        }

        x_needsGpuEnsureCapacity = false;
        if (w_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
        }

        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_detr_kernel75<<<grid, block>>>(gpu_z, ch, npages - 1, gpu_x,
            cpu_x->size[0U]);
        }

        x_outdatedOnGpu = false;
        x_outdatedOnCpu = true;
      } else {
        if (x_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_x, &gpu_x);
        }

        if (z_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_z, &gpu_z);
        }

        binary_expand_op_5(cpu_x, ch, cpu_z);
        x_outdatedOnCpu = false;
        x_outdatedOnGpu = true;
        x_needsGpuEnsureCapacity = true;
      }

      npages = cpu_w->size[0];
      mwGetLaunchParameters1D(computeNumIters(npages - 1), &grid, &block,
        2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_detr_kernel76<<<grid, block>>>(gpu_fv2, ch, npages - 1, gpu_w,
          cpu_w->size[0U]);
      }

      w_outdatedOnCpu = true;

      //  Detrend
      // 'ec_detr:42' olPct(ch,ii) = sum(~w(:,ch));
      j = b_cpu_x->size[0];
      b_cpu_x->size[0] = cpu_w->size[0];
      emxEnsureCapacity_boolean_T(b_cpu_x, j, &h_emlrtRTEI);
      nx = cpu_w->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block, 2147483647U);
      w_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_boolean_T(b_cpu_x, &e_gpu_x, true);
      w_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_detr_kernel77<<<grid, block>>>(ch, gpu_w, nx, e_gpu_x, cpu_w->size[0U]);
      }

      nx = b_cpu_x->size[0];
      if (b_cpu_x->size[0] == 0) {
        cpu_n = 0;
      } else {
        gpuEmxMemcpyGpuToCpu_boolean_T(b_cpu_x, &e_gpu_x);
        cpu_n = b_cpu_x->data[0];
        for (npages = 0; npages <= nx - 2; npages++) {
          cpu_n += b_cpu_x->data[npages + 1];
        }
      }

      ec_detr_kernel78<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(cpu_n, ii, ch,
        *gpu_olPct_data, b_olPct_size[0]);

      //  Outlier percentages
    }
  }

  emxFree_real32_T(&c_cpu_V);
  emxFree_real32_T(&c_cpu_y);
  emxFree_real32_T(&cpu_absdiff);
  emxFree_real32_T(&b_cpu_d);
  emxFree_real32_T(&cpu_fv4);
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_real32_T(&b_cpu_y);
  emxFree_real32_T(&b_cpu_tau);
  emxFree_int32_T(&cpu_ipiv_t);
  emxFree_int32_T(&cpu_jpvt);
  emxFree_real32_T(&b_cpu_B);
  emxFree_int32_T(&cpu_ipiv);
  emxFree_real32_T(&cpu_B);
  emxFree_real32_T(&f_cpu_A);
  emxFree_real32_T(&cpu_Y);
  emxFree_real32_T(&wi);
  emxFree_real32_T(&wr);
  emxFree_real32_T(&e_cpu_A);
  emxFree_real32_T(&cpu_vright);
  emxFree_real32_T(&d_cpu_A);
  emxFree_real32_T(&cpu_wimag);
  emxFree_real32_T(&cpu_tau);
  emxFree_real32_T(&cpu_wreal);
  emxFree_real32_T(&c_cpu_A);
  emxFree_creal32_T(&b_cpu_W);
  emxFree_real32_T(&cpu_b);
  emxFree_real32_T(&cpu_U);
  emxFree_real32_T(&scale);
  emxFree_real32_T(&cpu_C);
  emxFree_real32_T(&cpu_W);
  emxFree_int32_T(&cpu_iv);
  emxFree_creal32_T(&cpu_d);
  emxFree_real32_T(&b_cpu_V);
  emxFree_creal32_T(&cpu_D);
  emxFree_creal32_T(&cpu_V);
  emxFree_real32_T(&b_cpu_A);
  emxFree_real32_T(&cpu_A);
  emxFree_real32_T(&cpu_rr);
  emxFree_real32_T(&cpu_r);
  emxFree_real32_T(&e_cpu_x);
  emxFree_real32_T(&cpu_y);
  emxFree_real32_T(&cpu_fv3);
  emxFree_real32_T(&d_cpu_x);
  emxFree_real32_T(&c_cpu_x);
  emxFree_boolean_T(&b_cpu_x);
  emxFree_real32_T(&cpu_z);
  emxFree_real32_T(&cpu_fv2);
  emxFree_real32_T(&cpu_fv1);
  emxFree_real_T(&cpu_lin);
  emxFree_real32_T(&cpu_regs);

  //  Sum outliers across chans
  // 'ec_detr:47' olPct = sum(olPct,1,"omitnan");
  if ((b_olPct_size[0] == 0) || (ord_size[1] == 0)) {
    olPct_size[0] = 1;
    olPct_size[1] = static_cast<uint16_T>(ord_size[1]);
    mwGetLaunchParameters1D(computeNumIters(static_cast<uint16_T>(ord_size[1]) -
      1), &grid, &block, 2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_detr_kernel79<<<grid, block>>>(static_cast<uint16_T>(ord_size[1]) - 1,
        b_gpu_olPct_data);
    }
  } else {
    olPct_size[0] = 1;
    olPct_size[1] = ord_size[1];
    mwGetLaunchParameters1D(computeNumIters(ord_size[1] - 1), &grid, &block,
      2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_detr_kernel80<<<grid, block>>>(b_olPct_size[0], *gpu_olPct_data,
        b_olPct_size[0], ord_size[1] - 1, b_gpu_olPct_data);
    }
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_outdatedOnCpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_x, &gpu_x);
  }

  if (w_outdatedOnCpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_w, &gpu_w);
  }

  checkCudaError(cudaMemcpy(cpu_olPct_data, b_gpu_olPct_data, static_cast<
    uint32_T>(olPct_size[1]) * sizeof(real_T), cudaMemcpyDeviceToHost), __FILE__,
                 __LINE__);
  gpuEmxFree_real32_T(&gpu_x);
  gpuEmxFree_real32_T(&gpu_w);
  checkCudaError(mwCudaFree(b_gpu_olPct_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_olPct_data), __FILE__, __LINE__);
  gpuEmxFree_real32_T(&gpu_regs);
  gpuEmxFree_real_T(&gpu_lin);
  gpuEmxFree_real32_T(&gpu_fv1);
  gpuEmxFree_real32_T(&gpu_fv2);
  gpuEmxFree_real32_T(&gpu_z);
  gpuEmxFree_boolean_T(&e_gpu_x);
  gpuEmxFree_real32_T(&b_gpu_x);
  gpuEmxFree_real32_T(&c_gpu_x);
  gpuEmxFree_real32_T(&gpu_fv3);
  gpuEmxFree_real32_T(&gpu_y);
  gpuEmxFree_real32_T(&d_gpu_x);
  gpuEmxFree_real32_T(&gpu_r);
  gpuEmxFree_real32_T(&gpu_rr);
  gpuEmxFree_real32_T(&b_gpu_A);
  gpuEmxFree_real32_T(&gpu_A);
  gpuEmxFree_creal32_T(&gpu_V);
  gpuEmxFree_creal32_T(&gpu_D);
  gpuEmxFree_real32_T(&b_gpu_V);
  gpuEmxFree_creal32_T(&b_gpu_d);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_real32_T(&gpu_W);
  gpuEmxFree_real32_T(&gpu_C);
  gpuEmxFree_real32_T(&gpu_U);
  gpuEmxFree_real32_T(&gpu_b);
  gpuEmxFree_creal32_T(&b_gpu_W);
  gpuEmxFree_real32_T(&c_gpu_A);
  gpuEmxFree_real32_T(&gpu_wreal);
  gpuEmxFree_real32_T(&b_gpu_tau);
  gpuEmxFree_real32_T(&gpu_wimag);
  gpuEmxFree_real32_T(&d_gpu_A);
  gpuEmxFree_real32_T(&gpu_vright);
  gpuEmxFree_real32_T(&e_gpu_A);
  gpuEmxFree_real32_T(&gpu_Y);
  gpuEmxFree_real32_T(&f_gpu_A);
  gpuEmxFree_real32_T(&b_gpu_B);
  gpuEmxFree_int32_T(&gpu_ipiv);
  gpuEmxFree_real32_T(&gpu_B);
  gpuEmxFree_int32_T(&gpu_jpvt);
  gpuEmxFree_int32_T(&gpu_ipiv_t);
  gpuEmxFree_real32_T(&gpu_tau);
  gpuEmxFree_real32_T(&b_gpu_y);
  gpuEmxFree_real32_T(&gpu_fv4);
  gpuEmxFree_real32_T(&gpu_d);
  gpuEmxFree_real32_T(&gpu_absdiff);
  gpuEmxFree_real32_T(&c_gpu_y);
  gpuEmxFree_real32_T(&c_gpu_V);
  checkCudaError(mwCudaFree(gpu_n), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(gpu_mn), __FILE__, __LINE__);
}

void ec_detr_api(const mxArray * const prhs[5], int32_T nlhs, const mxArray
                 *plhs[3])
{
  emxArray_real32_T *w;
  emxArray_real32_T *x;
  const mxArray *prhs_copy_idx_0;
  const mxArray *prhs_copy_idx_1;
  real_T (*olPct_data)[99];
  int32_T itr_size[2];
  int32_T olPct_size[2];
  int32_T ord_size[2];
  int32_T thr_size[2];
  real32_T (*itr_data)[99];
  real32_T (*ord_data)[99];
  real32_T (*thr_data)[99];
  olPct_data = (real_T (*)[99])mxMalloc(sizeof(real_T [99]));
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_0 = emlrtProtectR2012b(prhs[0], 0, true, -1);
  prhs_copy_idx_1 = emlrtProtectR2012b(prhs[1], 1, true, -1);

  // Marshall function inputs
  emxInit_real32_T(&x, 2, &emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs_copy_idx_0), "x", x);
  emxInit_real32_T(&w, 2, &emlrtRTEI, true);
  w->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs_copy_idx_1), "w", w);
  *(real32_T **)&ord_data = emlrt_marshallIn(emlrtAlias(prhs[2]), "ord",
    ord_size);
  *(real32_T **)&thr_data = emlrt_marshallIn(emlrtAlias(prhs[3]), "thr",
    thr_size);
  *(real32_T **)&itr_data = emlrt_marshallIn(emlrtAlias(prhs[4]), "itr",
    itr_size);

  // Invoke the target function
  ec_detr(x, w, *ord_data, ord_size, *thr_data, thr_size, *itr_data, itr_size,
          *olPct_data, olPct_size);

  // Marshall function outputs
  x->canFreeData = false;
  emlrt_marshallOut(x, prhs_copy_idx_0);
  emxFree_real32_T(&x);
  plhs[0] = prhs_copy_idx_0;
  if (nlhs > 1) {
    w->canFreeData = false;
    emlrt_marshallOut(w, prhs_copy_idx_1);
    plhs[1] = prhs_copy_idx_1;
  }

  emxFree_real32_T(&w);
  if (nlhs > 2) {
    plhs[2] = emlrt_marshallOut(*olPct_data, olPct_size);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ec_detr_atexit()
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

  cusolverDestroyWorkspace();
  cusolverEnsureDestruction();
}

void ec_detr_initialize()
{
  mex_InitInfAndNan();
  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "distrib_computing_toolbox", 2);
  cublasEnsureInitialization(CUBLAS_POINTER_MODE_HOST);
  cusolverEnsureInitialization();
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
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
}

// End of code generation (ec_detr.cu)
