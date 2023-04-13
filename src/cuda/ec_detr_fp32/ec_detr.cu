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

static emlrtRTEInfo d_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "sum",                               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/sum.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 58,   // lineNo
  23,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 49,   // lineNo
  20,                                  // colNo
  "linspace",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/linspace.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 41,   // lineNo
  41,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 41,   // lineNo
  49,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 80,   // lineNo
  20,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 1,    // lineNo
  1,                                   // colNo
  "dts_binary_op",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/coder/float2fixed/dtslib/dts_binary_op.p"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 42,   // lineNo
  28,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 6,    // lineNo
  5,                                   // colNo
  "singleCInternal",                   // fName
  ""                                   // pName
};

static emlrtRTEInfo n_emlrtRTEI{ 108,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 109,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 110,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 111,  // lineNo
  13,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 158,  // lineNo
  24,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
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
  5,                                   // colNo
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

static emlrtRTEInfo hc_emlrtRTEI{ 116, // lineNo
  6,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 116, // lineNo
  16,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 18,  // lineNo
  29,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 44,  // lineNo
  32,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 116, // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 50,  // lineNo
  31,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 44,  // lineNo
  35,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 117, // lineNo
  10,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 53,  // lineNo
  13,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 61,  // lineNo
  9,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 92,  // lineNo
  22,                                  // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 105, // lineNo
  1,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 83,  // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 86,  // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 85,  // lineNo
  1,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 126, // lineNo
  34,                                  // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 30,  // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 119, // lineNo
  5,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 1,   // lineNo
  15,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 37,  // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 59,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 61,  // lineNo
  5,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo ed_emlrtRTEI{ 80,  // lineNo
  1,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo fd_emlrtRTEI{ 124, // lineNo
  10,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo gd_emlrtRTEI{ 124, // lineNo
  6,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo hd_emlrtRTEI{ 111, // lineNo
  2,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo id_emlrtRTEI{ 111, // lineNo
  4,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo jd_emlrtRTEI{ 113, // lineNo
  10,                                  // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo kd_emlrtRTEI{ 114, // lineNo
  9,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo ld_emlrtRTEI{ 99,  // lineNo
  1,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo md_emlrtRTEI{ 131, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo nd_emlrtRTEI{ 132, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo od_emlrtRTEI{ 134, // lineNo
  10,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo pd_emlrtRTEI{ 111, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo qd_emlrtRTEI{ 112, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo rd_emlrtRTEI{ 44,  // lineNo
  9,                                   // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo sd_emlrtRTEI{ 117, // lineNo
  8,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

static emlrtRTEInfo td_emlrtRTEI{ 18,  // lineNo
  5,                                   // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo ud_emlrtRTEI{ 126, // lineNo
  9,                                   // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo vd_emlrtRTEI{ 88,  // lineNo
  7,                                   // colNo
  "ec_detr",                           // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detr.m"// pName
};

// Function Declarations
static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, real32_T in4);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real32_T *ret);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real32_T ret_data[], int32_T ret_size[2]);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, real32_T in3, const emxArray_real32_T *in4);
static void binary_expand_op(emxArray_real32_T *in1, int32_T in2, const
  emxArray_real32_T *in3);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, const emxArray_real32_T *in4);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3);
static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
  *in2, const emxArray_real32_T *in3, real32_T in4);
static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static
#ifdef __CUDACC__

__device__
#endif

int64_T computeEndIdx_device(int64_T start, int64_T end, int64_T stride);
static __global__ void ec_detr_kernel1(creal32_T *fc, creal32_T *fc2);
static __global__ void ec_detr_kernel10(const real32_T itr_data[], int8_T
  outsize_idx_1, real32_T out_data[99]);
static __global__ void ec_detr_kernel11(const real32_T *d2scaled, int32_T nx,
  emxArray_real32_T lin, int32_T lin_dim1);
static __global__ void ec_detr_kernel12(emxArray_real32_T lin, int32_T lin_dim1);
static __global__ void ec_detr_kernel13(const int32_T m, const emxArray_real32_T
  lin, int32_T nx, emxArray_real32_T fv);
static __global__ void ec_detr_kernel14(const emxArray_real32_T fv, const
  int32_T nx, int32_T vlen, emxArray_real32_T regs, int32_T regs_dim0);
static __global__ void ec_detr_kernel15(const real32_T out_data[99], const
  int32_T ii, int32_T *i5);
static __global__ void ec_detr_kernel16(const int32_T ch, const
  emxArray_real32_T x, int32_T b_x, emxArray_real32_T fv1, int32_T x_dim0);
static __global__ void ec_detr_kernel17(const int32_T ch, const
  emxArray_real32_T w, int32_T b_w, emxArray_real32_T fv2, int32_T w_dim0);
static __global__ void ec_detr_kernel18(const emxArray_real32_T fv2, const
  emxArray_real32_T fv1, int32_T b_fv1, emxArray_real32_T c);
static __global__ void ec_detr_kernel19(const emxArray_real32_T fv2, const
  emxArray_real32_T fv1, int32_T b_fv1, emxArray_real32_T c);
static __global__ void ec_detr_kernel2(const real32_T ord_data[], int32_T
  inVectorLength, real32_T out_data[99]);
static __global__ void ec_detr_kernel20(const emxArray_real32_T fv2, const
  real32_T *d2scaled, const emxArray_real32_T fv1, int32_T b_fv1,
  emxArray_real32_T fv3);
static __global__ void ec_detr_kernel21(const emxArray_real32_T fv2, const
  emxArray_real32_T regs, const int32_T b_regs, int32_T c_regs,
  emxArray_real32_T c, int32_T c_dim0, int32_T regs_dim0);
static __global__ void ec_detr_kernel22(const int32_T vlen, const
  emxArray_real32_T c, int32_T *npages, emxArray_real32_T y, int32_T c_dim0);
static __global__ void ec_detr_kernel23(int32_T sz, emxArray_real32_T y);
static __global__ void ec_detr_kernel24(const real32_T *d2scaled, const
  emxArray_real32_T y, const emxArray_real32_T regs, const int32_T b_regs,
  int32_T c_regs, emxArray_real32_T fv4, int32_T fv4_dim0, int32_T regs_dim0);
static __global__ void ec_detr_kernel25(const emxArray_real32_T fv2, const
  emxArray_real32_T fv4, const int32_T b_fv4, int32_T c_fv4, emxArray_real32_T
  rr, int32_T rr_dim0, int32_T fv4_dim0);
static __global__ void ec_detr_kernel26(const emxArray_real32_T rr, const
  int32_T b_rr, int32_T c_rr, emxArray_real32_T a, int32_T a_dim0, int32_T
  rr_dim0);
static __global__ void ec_detr_kernel27(int32_T a, emxArray_real32_T A);
static __global__ void ec_detr_kernel28(const emxArray_real32_T wimag, const
  emxArray_real32_T wreal, int32_T *npages, emxArray_creal32_T W);
static __global__ void ec_detr_kernel29(const emxArray_real32_T vright, int32_T
  b_vright, emxArray_creal32_T V);
static __global__ void ec_detr_kernel3(const real32_T ord_data[], int32_T
  inVectorLength, real32_T out_data[99]);
static __global__ void ec_detr_kernel30(const int32_T nx, int32_T *npages,
  emxArray_creal32_T V, int32_T V_dim0);
static __global__ void ec_detr_kernel31(const creal32_T *fc2, int32_T vlen,
  emxArray_creal32_T W);
static __global__ void ec_detr_kernel32(const creal32_T *fc2, int32_T fv2,
  emxArray_creal32_T V);
static __global__ void ec_detr_kernel33(int32_T A, emxArray_creal32_T D);
static __global__ void ec_detr_kernel34(int32_T fv2, emxArray_real32_T A);
static __global__ void ec_detr_kernel35(int32_T vlen, emxArray_real32_T tau);
static __global__ void ec_detr_kernel36(const emxArray_real32_T A, int32_T b_A,
  emxArray_real32_T U);
static __global__ void ec_detr_kernel37(int32_T fv2, emxArray_real32_T U);
static __global__ void ec_detr_kernel38(int32_T fv2, emxArray_real32_T A);
static __global__ void ec_detr_kernel39(int32_T fv2, emxArray_real32_T U);
static __global__ void ec_detr_kernel4(const real32_T ord_data[], int8_T
  outsize_idx_1, real32_T out_data[99]);
static __global__ void ec_detr_kernel40(int32_T sz, emxArray_real32_T U);
static __global__ void ec_detr_kernel41(const int32_T vlen, const int32_T nx,
  int32_T m, emxArray_real32_T U, int32_T U_dim0);
static __global__ void ec_detr_kernel42(int32_T sz, emxArray_real32_T A);
static __global__ void ec_detr_kernel43(int32_T A, emxArray_creal32_T D);
static __global__ void ec_detr_kernel44(const emxArray_real32_T U, int32_T b_U,
  emxArray_creal32_T V);
static __global__ void ec_detr_kernel45(int32_T vlen, emxArray_real32_T W);
static __global__ void ec_detr_kernel46(int32_T fv2, emxArray_real32_T A);
static __global__ void ec_detr_kernel47(int32_T n, emxArray_creal32_T D);
static __global__ void ec_detr_kernel48(const emxArray_real32_T A, int32_T b_A,
  emxArray_creal32_T V);
static __global__ void ec_detr_kernel49(const creal32_T *fc, int32_T fv2,
  emxArray_creal32_T V);
static __global__ void ec_detr_kernel5(const real32_T thr_data[], int32_T
  inVectorLength, real32_T out_data[99]);
static __global__ void ec_detr_kernel50(int32_T fv2, emxArray_creal32_T D);
static __global__ void ec_detr_kernel51(const emxArray_creal32_T V, int32_T b_V,
  emxArray_real32_T c_V);
static __global__ void ec_detr_kernel52(const emxArray_creal32_T D, int32_T nx,
  emxArray_creal32_T d, int32_T D_dim0);
static __global__ void ec_detr_kernel53(const emxArray_int32_T iv, const
  emxArray_real32_T V, const int32_T nx, int32_T b_iv, emxArray_real32_T b_V,
  int32_T V_dim0, int32_T b_V_dim0);
static __global__ void ec_detr_kernel54(const emxArray_real32_T V, int32_T b_V,
  emxArray_real32_T c_V);
static __global__ void ec_detr_kernel55(const emxArray_real32_T rr, int32_T b_rr,
  emxArray_real32_T A);
static __global__ void ec_detr_kernel56(int32_T fv2, emxArray_real32_T rr);
static __global__ void ec_detr_kernel57(const emxArray_real32_T fv3, int32_T
  b_fv3, emxArray_real32_T a);
static __global__ void ec_detr_kernel58(int32_T rr, emxArray_real32_T b);
static __global__ void ec_detr_kernel59(const emxArray_real32_T rr, const
  int32_T b_rr, int32_T c_rr, emxArray_real32_T a, int32_T a_dim0, int32_T
  rr_dim0);
static __global__ void ec_detr_kernel6(const real32_T thr_data[], int32_T
  inVectorLength, real32_T out_data[99]);
static __global__ void ec_detr_kernel60(int32_T a, emxArray_real32_T A);
static __global__ void ec_detr_kernel61(const emxArray_real32_T A, const int32_T
  b_A, int32_T c_A, emxArray_real32_T d_A, int32_T A_dim0, int32_T b_A_dim0);
static __global__ void ec_detr_kernel62(const emxArray_real32_T b, int32_T b_b,
  emxArray_real32_T B);
static __global__ void ec_detr_kernel63(int32_T A, emxArray_int32_T jpvt);
static __global__ void ec_detr_kernel64(const int32_T m, int32_T na,
  emxArray_real32_T A, int32_T A_dim0);
static __global__ void ec_detr_kernel65(int32_T vlen, emxArray_real32_T tau);
static __global__ void ec_detr_kernel66(const int32_T nx, int32_T *npages,
  emxArray_real32_T tau);
static __global__ void ec_detr_kernel67(int32_T na, emxArray_int32_T jpvt);
static __global__ void ec_detr_kernel68(int32_T nx, emxArray_real32_T Y);
static __global__ void ec_detr_kernel69(int32_T vlen, emxArray_real32_T B);
static __global__ void ec_detr_kernel7(const real32_T thr_data[], int8_T
  outsize_idx_1, real32_T out_data[99]);
static __global__ void ec_detr_kernel70(const emxArray_real32_T B, const
  emxArray_int32_T jpvt, int32_T m, emxArray_real32_T Y);
static __global__ void ec_detr_kernel71(const emxArray_real32_T Y, int32_T b_Y,
  emxArray_real32_T b);
static __global__ void ec_detr_kernel72(const emxArray_int32_T ipiv_t, int32_T
  nx, emxArray_int32_T ipiv);
static __global__ void ec_detr_kernel73(int32_T fv2, emxArray_real32_T A);
static __global__ void ec_detr_kernel74(int32_T nx, emxArray_int32_T ipiv);
static __global__ void ec_detr_kernel75(int32_T sz, emxArray_real32_T b);
static __global__ void ec_detr_kernel76(const emxArray_real32_T b, int32_T b_b,
  emxArray_real32_T c_b);
static __global__ void ec_detr_kernel77(int32_T V, emxArray_real32_T c);
static __global__ void ec_detr_kernel78(int32_T fv4, emxArray_real32_T fv5);
static __global__ void ec_detr_kernel79(const real32_T *out, const
  emxArray_real32_T fv1, const emxArray_real32_T fv5, int32_T b_fv5,
  emxArray_real32_T z);
static __global__ void ec_detr_kernel8(const real32_T itr_data[], int32_T
  inVectorLength, real32_T out_data[99]);
static __global__ void ec_detr_kernel80(const emxArray_real32_T fv2, const
  emxArray_real32_T z, const emxArray_real32_T fv1, int32_T b_fv1,
  emxArray_real32_T d);
static __global__ void ec_detr_kernel81(const real32_T *d2scaled, const
  emxArray_real32_T d, int32_T n, emxArray_real32_T absdiff);
static __global__ void ec_detr_kernel82(const real32_T *d2scaled, real32_T *out,
  int32_T d_dim0);
static __global__ void ec_detr_kernel83(const real32_T *out, const real32_T
  out_data[99], const int32_T ii, real32_T *d2scaled);
static __global__ void ec_detr_kernel84(const emxArray_real32_T d, int32_T nx,
  emxArray_real32_T y);
static __global__ void ec_detr_kernel85(const real32_T *d2scaled, const
  emxArray_real32_T y, int32_T vlen, emxArray_real32_T fv2);
static __global__ void ec_detr_kernel86(const emxArray_real32_T z, const int32_T
  ch, const emxArray_real32_T x, int32_T b_x, emxArray_real32_T c_x, int32_T
  x_dim0);
static __global__ void ec_detr_kernel87(const emxArray_real32_T x, const int32_T
  ch, int32_T b_x, emxArray_real32_T c_x, int32_T x_dim0);
static __global__ void ec_detr_kernel88(const emxArray_real32_T fv2, const
  int32_T ch, int32_T b_fv2, emxArray_real32_T w, int32_T w_dim0);
static __global__ void ec_detr_kernel89(const int32_T ch, const
  emxArray_real32_T w, int32_T b_w, emxArray_boolean_T x, int32_T w_dim0);
static __global__ void ec_detr_kernel9(const real32_T itr_data[], int32_T
  inVectorLength, real32_T out_data[99]);
static __global__ void ec_detr_kernel90(const int32_T vlen, const
  emxArray_real32_T olPct, int32_T *npages, real32_T olPct_data[], int32_T
  olPct_dim0);
static __global__ void ec_detr_kernel91(int32_T sz, real32_T olPct_data[]);
static void ec_detr_once();
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real32_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real32_T *y);
static void emlrt_marshallIn(const mxArray *ord, const char_T *identifier,
  real32_T y_data[], int32_T y_size[2]);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real32_T y_data[], int32_T y_size[2]);
static const mxArray *emlrt_marshallOut(const real32_T u_data[], const int32_T
  u_size[2]);
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
static void times(emxArray_real32_T *in1, const emxArray_real32_T *in2, const
                  emxArray_real32_T *in3);

// Function Definitions
static void b_binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
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

  emxEnsureCapacity_real32_T(in1, i, &o_emlrtRTEI);
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

static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real32_T ret_data[], int32_T ret_size[2])
{
  static const int32_T dims[2]{ 1, 99 };

  int32_T iv[2];
  boolean_T bv[2]{ true, true };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "single|double",
    false, 2U, (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, &ret_data[0], 4, false);
  emlrtDestroyArray(&src);
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
  emxEnsureCapacity_real32_T(in1, i, &p_emlrtRTEI);
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

  emxEnsureCapacity_real32_T(in1, i, &uc_emlrtRTEI);
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

  emxEnsureCapacity_real32_T(in1, i, &n_emlrtRTEI);
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

static void binary_expand_op(emxArray_real32_T *in1, int32_T in2, const
  emxArray_real32_T *in3)
{
  emxArray_real32_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real32_T(&b_in1, 1, &k_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in3->size[0] == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in3->size[0];
  }

  emxEnsureCapacity_real32_T(b_in1, i, &k_emlrtRTEI);
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

  emxFree_real32_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real32_T *in1, const emxArray_real32_T
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

  emxEnsureCapacity_real32_T(in1, i, &tc_emlrtRTEI);
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

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel1(creal32_T *fc,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel10(const
  real32_T itr_data[], int8_T outsize_idx_1, real32_T out_data[99])
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel11(const
  real32_T *d2scaled, int32_T nx, emxArray_real32_T lin, int32_T lin_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real32_T>((((k + 2) << 1) - lin_dim1) - 1) *
      *d2scaled;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel12
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel13(const int32_T
  m, const emxArray_real32_T lin, int32_T nx, emxArray_real32_T fv)
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
    fv.data[k] = powf(lin.data[k], static_cast<real32_T>(m) + 1.0F);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel14(const
  emxArray_real32_T fv, const int32_T nx, int32_T vlen, emxArray_real32_T regs,
  int32_T regs_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    regs.data[i + regs_dim0 * (nx - 1)] = fv.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel15(const real32_T
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel16(const int32_T
  ch, const emxArray_real32_T x, int32_T b_x, emxArray_real32_T fv1, int32_T
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
    fv1.data[i] = x.data[i + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel17(const int32_T
  ch, const emxArray_real32_T w, int32_T b_w, emxArray_real32_T fv2, int32_T
  w_dim0)
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
    fv2.data[i] = w.data[i + w_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel18(const
  emxArray_real32_T fv2, const emxArray_real32_T fv1, int32_T b_fv1,
  emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = fv1.data[i] * fv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel19(const
  emxArray_real32_T fv2, const emxArray_real32_T fv1, int32_T b_fv1,
  emxArray_real32_T c)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    c.data[i] = fv1.data[i] * fv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel2(const real32_T
  ord_data[], int32_T inVectorLength, real32_T out_data[99])
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
  emxArray_real32_T fv2, const real32_T *d2scaled, const emxArray_real32_T fv1,
  int32_T b_fv1, emxArray_real32_T fv3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv3.data[i] = (fv1.data[i] - *d2scaled) * fv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel21(const
  emxArray_real32_T fv2, const emxArray_real32_T regs, const int32_T b_regs,
  int32_T c_regs, emxArray_real32_T c, int32_T c_dim0, int32_T regs_dim0)
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
    c.data[xpageoffset + c_dim0 * i] = regs.data[xpageoffset + regs_dim0 * i] *
      fv2.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel22(const int32_T
  vlen, const emxArray_real32_T c, int32_T *npages, emxArray_real32_T y, int32_T
  c_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel23(int32_T sz,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel24(const
  real32_T *d2scaled, const emxArray_real32_T y, const emxArray_real32_T regs,
  const int32_T b_regs, int32_T c_regs, emxArray_real32_T fv4, int32_T fv4_dim0,
  int32_T regs_dim0)
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
    fv4.data[xpageoffset + fv4_dim0 * i] = regs.data[xpageoffset + regs_dim0 * i]
      - y.data[i] / *d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel25(const
  emxArray_real32_T fv2, const emxArray_real32_T fv4, const int32_T b_fv4,
  int32_T c_fv4, emxArray_real32_T rr, int32_T rr_dim0, int32_T fv4_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_fv4) + 1UL) * (static_cast<uint64_T>(c_fv4)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fv4) + 1UL));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) / (
      static_cast<uint64_T>(b_fv4) + 1UL));
    rr.data[xpageoffset + rr_dim0 * i] = fv4.data[xpageoffset + fv4_dim0 * i] *
      fv2.data[xpageoffset];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel26(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel27(int32_T a,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel28(const
  emxArray_real32_T wimag, const emxArray_real32_T wreal, int32_T *npages,
  emxArray_creal32_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i].re = wreal.data[i];
    W.data[i].im = wimag.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel29(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel3(const real32_T
  ord_data[], int32_T inVectorLength, real32_T out_data[99])
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel30(const int32_T
  nx, int32_T *npages, emxArray_creal32_T V, int32_T V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*npages);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T xpageoffset;
    real32_T f;
    xpageoffset = static_cast<int32_T>(idx);
    f = V.data[xpageoffset + V_dim0 * (nx - 1)].re;
    V.data[xpageoffset + V_dim0 * (nx - 2)].im = f;
    V.data[xpageoffset + V_dim0 * (nx - 1)].re = V.data[xpageoffset + V_dim0 *
      (nx - 2)].re;
    V.data[xpageoffset + V_dim0 * (nx - 1)].im = -V.data[xpageoffset + V_dim0 *
      (nx - 2)].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel31(const
  creal32_T *fc2, int32_T vlen, emxArray_creal32_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = *fc2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel32(const
  creal32_T *fc2, int32_T fv2, emxArray_creal32_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i] = *fc2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel33(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel34(int32_T fv2,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel35(int32_T vlen,
  emxArray_real32_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    tau.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel36(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel37(int32_T fv2,
  emxArray_real32_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel38(int32_T fv2,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel39(int32_T fv2,
  emxArray_real32_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel4(const real32_T
  ord_data[], int8_T outsize_idx_1, real32_T out_data[99])
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel40(int32_T sz,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel41(const int32_T
  vlen, const int32_T nx, int32_T m, emxArray_real32_T U, int32_T U_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>(nx),
    static_cast<int64_T>(m), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    U.data[(static_cast<int32_T>(static_cast<int64_T>(nx) + i) + U_dim0 * (vlen
             - 1)) - 1] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel42(int32_T sz,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel43(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel44(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel45(int32_T vlen,
  emxArray_real32_T W)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    W.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel46(int32_T fv2,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel47(int32_T n,
  emxArray_creal32_T D)
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
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel48(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel49(const
  creal32_T *fc, int32_T fv2, emxArray_creal32_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i] = *fc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel5(const real32_T
  thr_data[], int32_T inVectorLength, real32_T out_data[99])
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel50(int32_T fv2,
  emxArray_creal32_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0F;
    D.data[i].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel51(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel52(const
  emxArray_creal32_T D, int32_T nx, emxArray_creal32_T d, int32_T D_dim0)
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
    d.data[k] = D.data[k + D_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel53(const
  emxArray_int32_T iv, const emxArray_real32_T V, const int32_T nx, int32_T b_iv,
  emxArray_real32_T b_V, int32_T V_dim0, int32_T b_V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx) * (static_cast<uint64_T>(b_iv) + 1UL) -
    1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % static_cast<uint64_T>(nx));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) /
      static_cast<uint64_T>(nx));
    b_V.data[xpageoffset + V_dim0 * i] = V.data[xpageoffset + b_V_dim0 *
      iv.data[i]];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel54(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel55(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel56(int32_T fv2,
  emxArray_real32_T rr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    rr.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel57(const
  emxArray_real32_T fv3, int32_T b_fv3, emxArray_real32_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv3);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[i] = fv3.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel58(int32_T rr,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel59(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel6(const real32_T
  thr_data[], int32_T inVectorLength, real32_T out_data[99])
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel60(int32_T a,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel61(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel62(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel63(int32_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel64(const int32_T
  m, int32_T na, emxArray_real32_T A, int32_T A_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel65(int32_T vlen,
  emxArray_real32_T tau)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel66(const int32_T
  nx, int32_T *npages, emxArray_real32_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>(nx),
    static_cast<int64_T>(*npages), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    tau.data[static_cast<int32_T>(static_cast<int64_T>(nx) + i) - 1] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel67(int32_T na,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel68(int32_T nx,
  emxArray_real32_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel69(int32_T vlen,
  emxArray_real32_T B)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    B.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel7(const real32_T
  thr_data[], int8_T outsize_idx_1, real32_T out_data[99])
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
  emxArray_real32_T B, const emxArray_int32_T jpvt, int32_T m, emxArray_real32_T
  Y)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel71(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel72(const
  emxArray_int32_T ipiv_t, int32_T nx, emxArray_int32_T ipiv)
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
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel73(int32_T fv2,
  emxArray_real32_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN_F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel74(int32_T nx,
  emxArray_int32_T ipiv)
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
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel75(int32_T sz,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel76(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel77(int32_T V,
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel78(int32_T fv4,
  emxArray_real32_T fv5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(fv4);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    fv5.data[i] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel79(const
  real32_T *out, const emxArray_real32_T fv1, const emxArray_real32_T fv5,
  int32_T b_fv5, emxArray_real32_T z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv5);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    z.data[i] = fv5.data[i] + (fv1.data[i] - (fv1.data[i] - *out));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel8(const real32_T
  itr_data[], int32_T inVectorLength, real32_T out_data[99])
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel80(const
  emxArray_real32_T fv2, const emxArray_real32_T z, const emxArray_real32_T fv1,
  int32_T b_fv1, emxArray_real32_T d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fv1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = (fv1.data[i] - z.data[i]) * fv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel81(const
  real32_T *d2scaled, const emxArray_real32_T d, int32_T n, emxArray_real32_T
  absdiff)
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
    absdiff.data[k] = fabsf(d.data[k] - *d2scaled);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel82(const real32_T *
  d2scaled, real32_T *out, int32_T d_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *out = *d2scaled / sqrtf(static_cast<real32_T>(d_dim0 - 1));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detr_kernel83(const real32_T *
  out, const real32_T out_data[99], const int32_T ii, real32_T *d2scaled)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *d2scaled = out_data[ii] * *out;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel84(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel85(const
  real32_T *d2scaled, const emxArray_real32_T y, int32_T vlen, emxArray_real32_T
  fv2)
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
    if (y.data[i] > *d2scaled) {
      fv2.data[i] = 0.0F;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel86(const
  emxArray_real32_T z, const int32_T ch, const emxArray_real32_T x, int32_T b_x,
  emxArray_real32_T c_x, int32_T x_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel88(const
  emxArray_real32_T fv2, const int32_T ch, int32_T b_fv2, emxArray_real32_T w,
  int32_T w_dim0)
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
    w.data[i + w_dim0 * ch] = fv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel89(const int32_T
  ch, const emxArray_real32_T w, int32_T b_w, emxArray_boolean_T x, int32_T
  w_dim0)
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
      ch] != 0.0F));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel9(const real32_T
  itr_data[], int32_T inVectorLength, real32_T out_data[99])
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
  vlen, const emxArray_real32_T olPct, int32_T *npages, real32_T olPct_data[],
  int32_T olPct_dim0)
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
    xpageoffset = i * olPct_dim0;
    olPct_data[i] = olPct.data[xpageoffset];
    for (int32_T k{0}; k <= vlen - 2; k++) {
      olPct_data[i] += olPct.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detr_kernel91(int32_T sz,
  real32_T olPct_data[])
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
    olPct_data[i] = 0.0F;
  }
}

static void ec_detr_once()
{
  mwMemoryManagerInit(256U, 2U, 8U, 2048U);
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

static void emlrt_marshallIn(const mxArray *ord, const char_T *identifier,
  real32_T y_data[], int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(ord), &thisId, y_data, y_size);
  emlrtDestroyArray(&ord);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real32_T y_data[], int32_T y_size[2])
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
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

static const mxArray *emlrt_marshallOut(const real32_T u_data[], const int32_T
  u_size[2])
{
  const mxArray *m;
  const mxArray *y;
  int32_T iv[2];
  int32_T loopUpperBound;
  real32_T *pData;
  y = nullptr;
  iv[0] = 1;
  iv[1] = u_size[1];
  m = emlrtCreateNumericArray(2, &iv[0], mxSINGLE_CLASS, mxREAL);
  pData = static_cast<real32_T *>(emlrtMxGetData(m));
  loopUpperBound = u_size[1];
  for (int32_T i{0}; i < loopUpperBound; i++) {
    pData[i] = u_data[i];
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
// function [x,w,olPct] = ec_detr(x,w,ord,thr,itr)
void ec_detr(emxArray_real32_T *cpu_x, emxArray_real32_T *cpu_w, const real32_T
             cpu_ord_data[], const int32_T ord_size[2], const real32_T
             cpu_thr_data[], const int32_T thr_size[2], const real32_T
             cpu_itr_data[], const int32_T itr_size[2], real32_T cpu_olPct_data[],
             int32_T olPct_size[2])
{
  static creal32_T cpu_fc{ 0.0F,       // re
    0.0F                               // im
  };

  static creal32_T cpu_fc2{ 0.0F,      // re
    0.0F                               // im
  };

  ptrdiff_t ihi_t;
  ptrdiff_t ilo_t;
  dim3 block;
  dim3 grid;
  emxArray_boolean_T c_gpu_x;
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
  emxArray_real32_T b_gpu_V;
  emxArray_real32_T b_gpu_a;
  emxArray_real32_T b_gpu_b;
  emxArray_real32_T b_gpu_c;
  emxArray_real32_T b_gpu_tau;
  emxArray_real32_T b_gpu_x;
  emxArray_real32_T b_gpu_y;
  emxArray_real32_T c_gpu_A;
  emxArray_real32_T c_gpu_V;
  emxArray_real32_T c_gpu_a;
  emxArray_real32_T c_gpu_c;
  emxArray_real32_T d_gpu_A;
  emxArray_real32_T d_gpu_c;
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
  emxArray_real32_T gpu_fv;
  emxArray_real32_T gpu_fv1;
  emxArray_real32_T gpu_fv2;
  emxArray_real32_T gpu_fv3;
  emxArray_real32_T gpu_fv4;
  emxArray_real32_T gpu_fv5;
  emxArray_real32_T gpu_lin;
  emxArray_real32_T gpu_olPct;
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
  emxArray_real32_T *b_cpu_V;
  emxArray_real32_T *b_cpu_a;
  emxArray_real32_T *b_cpu_b;
  emxArray_real32_T *b_cpu_c;
  emxArray_real32_T *b_cpu_d;
  emxArray_real32_T *b_cpu_tau;
  emxArray_real32_T *b_cpu_y;
  emxArray_real32_T *c_cpu_A;
  emxArray_real32_T *c_cpu_V;
  emxArray_real32_T *c_cpu_a;
  emxArray_real32_T *c_cpu_c;
  emxArray_real32_T *c_cpu_x;
  emxArray_real32_T *cpu_A;
  emxArray_real32_T *cpu_B;
  emxArray_real32_T *cpu_U;
  emxArray_real32_T *cpu_W;
  emxArray_real32_T *cpu_Y;
  emxArray_real32_T *cpu_a;
  emxArray_real32_T *cpu_absdiff;
  emxArray_real32_T *cpu_b;
  emxArray_real32_T *cpu_c;
  emxArray_real32_T *cpu_fv;
  emxArray_real32_T *cpu_fv1;
  emxArray_real32_T *cpu_fv2;
  emxArray_real32_T *cpu_fv3;
  emxArray_real32_T *cpu_fv4;
  emxArray_real32_T *cpu_fv5;
  emxArray_real32_T *cpu_lin;
  emxArray_real32_T *cpu_olPct;
  emxArray_real32_T *cpu_regs;
  emxArray_real32_T *cpu_rr;
  emxArray_real32_T *cpu_tau;
  emxArray_real32_T *cpu_vright;
  emxArray_real32_T *cpu_wimag;
  emxArray_real32_T *cpu_wreal;
  emxArray_real32_T *cpu_y;
  emxArray_real32_T *cpu_z;
  emxArray_real32_T *d_cpu_A;
  emxArray_real32_T *d_cpu_c;
  emxArray_real32_T *scale;
  emxArray_real32_T *wi;
  emxArray_real32_T *wr;
  creal32_T *gpu_fc;
  creal32_T *gpu_fc2;
  int32_T fv2[2];
  int32_T b_inVectorLength;
  int32_T cpu_i5;
  int32_T cpu_info;
  int32_T cpu_npages;
  int32_T i;
  int32_T inVectorLength;
  int32_T *gpu_i5;
  int32_T *gpu_info;
  int32_T *gpu_npages;
  real32_T cpu_out_data[99];
  real32_T (*b_gpu_out_data)[99];
  real32_T (*c_gpu_out_data)[99];
  real32_T (*gpu_out_data)[99];
  real32_T abnrm;
  real32_T cpu_d2scaled;
  real32_T cpu_out;
  real32_T nFrames;
  real32_T rconde;
  real32_T rcondv;
  real32_T *gpu_d2scaled;
  real32_T *gpu_itr_data;
  real32_T *gpu_olPct_data;
  real32_T *gpu_ord_data;
  real32_T *gpu_out;
  real32_T *gpu_thr_data;
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
  boolean_T b_c_dirtyOnCpu;
  boolean_T b_c_dirtyOnGpu;
  boolean_T b_d_dirtyOnCpu;
  boolean_T b_d_dirtyOnGpu;
  boolean_T b_dirtyOnCpu;
  boolean_T b_tau_dirtyOnGpu;
  boolean_T b_x_dirtyOnGpu;
  boolean_T c_c_dirtyOnCpu;
  boolean_T c_c_dirtyOnGpu;
  boolean_T c_dirtyOnCpu;
  boolean_T c_dirtyOnGpu;
  boolean_T d_dirtyOnCpu;
  boolean_T d_dirtyOnGpu;
  boolean_T fc_dirtyOnGpu;
  boolean_T fv1_dirtyOnGpu;
  boolean_T fv2_dirtyOnGpu;
  boolean_T fv3_dirtyOnCpu;
  boolean_T fv3_dirtyOnGpu;
  boolean_T fv4_dirtyOnCpu;
  boolean_T fv4_dirtyOnGpu;
  boolean_T fv5_dirtyOnGpu;
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
  mwCudaMalloc(&gpu_out, 4UL);
  mwCudaMalloc(&gpu_i5, 4UL);
  mwCudaMalloc(&gpu_d2scaled, 4UL);
  mwCudaMalloc(&gpu_npages, 4UL);
  gpuEmxReset_real32_T(&c_gpu_V);
  gpuEmxReset_real32_T(&b_gpu_x);
  gpuEmxReset_real32_T(&b_gpu_y);
  gpuEmxReset_real32_T(&gpu_absdiff);
  gpuEmxReset_real32_T(&gpu_d);
  gpuEmxReset_real32_T(&gpu_fv5);
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
  gpuEmxReset_real32_T(&c_gpu_a);
  gpuEmxReset_real32_T(&b_gpu_A);
  gpuEmxReset_real32_T(&gpu_wimag);
  gpuEmxReset_real32_T(&b_gpu_tau);
  gpuEmxReset_real32_T(&gpu_wreal);
  gpuEmxReset_creal32_T(&b_gpu_W);
  gpuEmxReset_real32_T(&b_gpu_a);
  gpuEmxReset_real32_T(&gpu_U);
  gpuEmxReset_real32_T(&gpu_b);
  gpuEmxReset_real32_T(&d_gpu_A);
  gpuEmxReset_real32_T(&gpu_W);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_creal32_T(&b_gpu_d);
  gpuEmxReset_real32_T(&b_gpu_V);
  gpuEmxReset_creal32_T(&gpu_D);
  gpuEmxReset_creal32_T(&gpu_V);
  gpuEmxReset_real32_T(&gpu_a);
  gpuEmxReset_real32_T(&gpu_A);
  gpuEmxReset_real32_T(&gpu_rr);
  gpuEmxReset_real32_T(&gpu_fv4);
  gpuEmxReset_real32_T(&gpu_y);
  gpuEmxReset_real32_T(&c_gpu_c);
  gpuEmxReset_real32_T(&gpu_fv3);
  gpuEmxReset_real32_T(&b_gpu_c);
  gpuEmxReset_real32_T(&gpu_c);
  gpuEmxReset_boolean_T(&c_gpu_x);
  gpuEmxReset_real32_T(&gpu_z);
  gpuEmxReset_real32_T(&gpu_fv2);
  gpuEmxReset_real32_T(&gpu_fv1);
  gpuEmxReset_real32_T(&gpu_fv);
  gpuEmxReset_real32_T(&gpu_lin);
  gpuEmxReset_real32_T(&gpu_regs);
  gpuEmxReset_real32_T(&gpu_olPct);
  mwCudaMalloc(&c_gpu_out_data, 396UL);
  mwCudaMalloc(&b_gpu_out_data, 396UL);
  mwCudaMalloc(&gpu_out_data, 396UL);
  mwCudaMalloc(&gpu_fc, 8UL);
  mwCudaMalloc(&gpu_fc2, 8UL);
  mwCudaMalloc(&gpu_olPct_data, 99U * sizeof(real32_T));
  mwCudaMalloc(&gpu_itr_data, 99U * sizeof(real32_T));
  mwCudaMalloc(&gpu_thr_data, 99U * sizeof(real32_T));
  mwCudaMalloc(&gpu_ord_data, 99U * sizeof(real32_T));
  gpuEmxReset_real32_T(&gpu_w);
  gpuEmxReset_real32_T(&gpu_x);
  i5_dirtyOnGpu = false;
  b_d_dirtyOnGpu = false;
  b_d_dirtyOnCpu = false;
  fv5_dirtyOnGpu = false;
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
  b_W_dirtyOnGpu = false;
  U_dirtyOnGpu = false;
  U_dirtyOnCpu = false;
  b_dirtyOnCpu = false;
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
  fv4_dirtyOnGpu = false;
  fv4_dirtyOnCpu = false;
  y_dirtyOnGpu = false;
  c_c_dirtyOnGpu = false;
  c_c_dirtyOnCpu = false;
  fv3_dirtyOnGpu = false;
  fv3_dirtyOnCpu = false;
  b_c_dirtyOnGpu = false;
  b_c_dirtyOnCpu = false;
  c_dirtyOnGpu = false;
  c_dirtyOnCpu = false;
  b_x_dirtyOnGpu = false;
  z_dirtyOnGpu = false;
  z_dirtyOnCpu = false;
  fv2_dirtyOnGpu = false;
  fv1_dirtyOnGpu = false;
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
  cudaMemcpy(gpu_fc, &cpu_fc, 8UL, cudaMemcpyHostToDevice);
  cudaMemcpy(gpu_fc2, &cpu_fc2, 8UL, cudaMemcpyHostToDevice);
  ec_detr_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_fc, gpu_fc2);
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
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(static_cast<
      int8_T>(inVectorLength)), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_ord_data, cpu_ord_data, sizeof(real32_T),
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
                  ord_size[1]) * sizeof(real32_T), cudaMemcpyHostToDevice);
      ec_detr_kernel3<<<grid, block>>>(gpu_ord_data, inVectorLength,
        *gpu_out_data);
      out_data_dirtyOnGpu = true;
    }
  } else {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_ord_data, cpu_ord_data, static_cast<uint32_T>(ord_size[0] *
                  ord_size[1]) * sizeof(real32_T), cudaMemcpyHostToDevice);
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
      cudaMemcpy(gpu_thr_data, cpu_thr_data, sizeof(real32_T),
                 cudaMemcpyHostToDevice);
      ec_detr_kernel7<<<grid, block>>>(gpu_thr_data, static_cast<int8_T>
        (b_inVectorLength), *b_gpu_out_data);
    }
  } else if ((thr_size[0] == 0) || (thr_size[1] == 0)) {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (b_inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_thr_data, cpu_thr_data, static_cast<uint32_T>(thr_size[0] *
                  thr_size[1]) * sizeof(real32_T), cudaMemcpyHostToDevice);
      ec_detr_kernel6<<<grid, block>>>(gpu_thr_data, b_inVectorLength,
        *b_gpu_out_data);
    }
  } else {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (b_inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_thr_data, cpu_thr_data, static_cast<uint32_T>(thr_size[0] *
                  thr_size[1]) * sizeof(real32_T), cudaMemcpyHostToDevice);
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
      cudaMemcpy(gpu_itr_data, cpu_itr_data, sizeof(real32_T),
                 cudaMemcpyHostToDevice);
      ec_detr_kernel10<<<grid, block>>>(gpu_itr_data, static_cast<int8_T>
        (b_inVectorLength), *c_gpu_out_data);
    }
  } else if ((itr_size[0] == 0) || (itr_size[1] == 0)) {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (b_inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_itr_data, cpu_itr_data, static_cast<uint32_T>(itr_size[0] *
                  itr_size[1]) * sizeof(real32_T), cudaMemcpyHostToDevice);
      ec_detr_kernel9<<<grid, block>>>(gpu_itr_data, b_inVectorLength,
        *c_gpu_out_data);
    }
  } else {
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
      (b_inVectorLength), &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      cudaMemcpy(gpu_itr_data, cpu_itr_data, static_cast<uint32_T>(itr_size[0] *
                  itr_size[1]) * sizeof(real32_T), cudaMemcpyHostToDevice);
      ec_detr_kernel8<<<grid, block>>>(gpu_itr_data, b_inVectorLength,
        *c_gpu_out_data);
    }
  }

  //  Main
  // 'ec_detr:28' coder.gpu.kernelfun;
  //  trigger CUDA kernel generation
  // 'ec_detr:29' nFrames = size(x,1);
  nFrames = static_cast<real32_T>(cpu_x->size[0]);

  // 'ec_detr:30' nChs = size(x,2);
  // 'ec_detr:31' reps = numel(ord);
  // 'ec_detr:32' olPct = coder.nullcopy(nan(nChs,reps));
  emxInit_real32_T(&cpu_olPct, 2, &ad_emlrtRTEI, true);
  i = cpu_olPct->size[0] * cpu_olPct->size[1];
  cpu_olPct->size[0] = cpu_x->size[1];
  cpu_olPct->size[1] = inVectorLength;
  emxEnsureCapacity_real32_T(cpu_olPct, i, &b_emlrtRTEI);
  gpuEmxEnsureCapacity_real32_T(cpu_olPct, &gpu_olPct);

  //  Detrend by polynomial order
  // 'ec_detr:35' for ii = 1:reps
  emxInit_real32_T(&cpu_regs, 2, &bd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_lin, 2, &cd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv, 2, &dd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv1, 1, &k_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv2, 1, &k_emlrtRTEI, true);
  emxInit_real32_T(&cpu_z, 1, &ed_emlrtRTEI, true);
  emxInit_boolean_T(&b_cpu_x, 1, &l_emlrtRTEI, true);
  emxInit_real32_T(&cpu_c, 1, &fd_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_c, 1, &fd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv3, 1, &k_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_c, 2, &fd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_y, 2, &gd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv4, 2, &k_emlrtRTEI, true);
  emxInit_real32_T(&cpu_rr, 2, &p_emlrtRTEI, true);
  emxInit_real32_T(&cpu_A, 2, &hb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_a, 2, &q_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_V, 2, &hd_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_D, 2, &id_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_V, 2, &hd_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_d, 1, &jd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &kd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_W, 1, &hb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_A, 2, &bc_emlrtRTEI, true);
  emxInit_real32_T(&scale, 1, &ld_emlrtRTEI, true);
  emxInit_real32_T(&cpu_b, 2, &lc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_U, 2, &hb_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_a, 2, &hc_emlrtRTEI, true);
  emxInit_creal32_T(&b_cpu_W, 1, &hb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_wreal, 1, &md_emlrtRTEI, true);
  emxInit_real32_T(&cpu_tau, 1, &hb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_wimag, 1, &nd_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_A, 2, &hb_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_a, 2, &ic_emlrtRTEI, true);
  emxInit_real32_T(&cpu_vright, 2, &od_emlrtRTEI, true);
  emxInit_real32_T(&wr, 2, &pd_emlrtRTEI, true);
  emxInit_real32_T(&wi, 2, &qd_emlrtRTEI, true);
  emxInit_real32_T(&cpu_Y, 1, &rd_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_A, 2, &hb_emlrtRTEI, true);
  emxInit_real32_T(&cpu_B, 1, &nc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv, 2, &hb_emlrtRTEI, true);
  emxInit_real32_T(&d_cpu_c, 1, &sd_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_b, 1, &oc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_jpvt, 2, &hb_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv_t, 1, &td_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_tau, 1, &hb_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &sc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_fv5, 1, &k_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_d, 1, &uc_emlrtRTEI, true);
  emxInit_real32_T(&cpu_absdiff, 1, &ud_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_y, 1, &vd_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_x, 1, &k_emlrtRTEI, true);
  emxInit_real32_T(&c_cpu_V, 2, &pb_emlrtRTEI, true);
  for (int32_T ii{0}; ii < inVectorLength; ii++) {
    int32_T i4;
    int32_T m;
    int32_T nx;

    // 'ec_detr:36' iOrd=ord(ii);
    // 'ec_detr:36' iThr=thr(ii);
    // 'ec_detr:36' iItr=itr(ii);
    //  copy
    // 'ec_detr:37' regs = regsFromBasis_lfn(nFrames,iOrd);
    // %%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    //  Get regressors from polynomial function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    // 'ec_detr:58' regs = coder.nullcopy(zeros(nFrames,iOrd,'like',iOrd));
    i = cpu_regs->size[0] * cpu_regs->size[1];
    cpu_regs->size[0] = static_cast<int32_T>(nFrames);
    if (out_data_dirtyOnGpu) {
      cudaMemcpy(cpu_out_data, *gpu_out_data, 396UL, cudaMemcpyDeviceToHost);
    }

    cpu_regs->size[1] = static_cast<int32_T>(cpu_out_data[ii]);
    emxEnsureCapacity_real32_T(cpu_regs, i, &e_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(cpu_regs, &gpu_regs);

    // 'ec_detr:59' lin = linspace(-1,1,nFrames);
    i = cpu_lin->size[0] * cpu_lin->size[1];
    cpu_lin->size[0] = 1;
    cpu_lin->size[1] = static_cast<int32_T>(nFrames);
    emxEnsureCapacity_real32_T(cpu_lin, i, &f_emlrtRTEI);
    if (!lin_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real32_T(cpu_lin, &gpu_lin);
    }

    if (static_cast<int32_T>(nFrames) >= 1) {
      if (lin_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_lin, &gpu_lin);
      }

      cpu_lin->data[static_cast<int32_T>(nFrames) - 1] = 1.0F;
      lin_dirtyOnCpu = true;
      lin_dirtyOnGpu = false;
      if (cpu_lin->size[1] >= 2) {
        cpu_lin->data[0] = -1.0F;
        if (cpu_lin->size[1] >= 3) {
          cpu_d2scaled = 1.0F / static_cast<real32_T>(cpu_lin->size[1] - 1);
          nx = cpu_lin->size[1];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx -
            2L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 4UL, cudaMemcpyHostToDevice);
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_lin, cpu_lin);
            ec_detr_kernel11<<<grid, block>>>(gpu_d2scaled, nx, gpu_lin,
              cpu_lin->size[1U]);
            lin_dirtyOnGpu = true;
            lin_dirtyOnCpu = false;
          }

          if ((cpu_lin->size[1] & 1) == 1) {
            if (lin_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_lin, cpu_lin);
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
    cpu_npages = static_cast<int32_T>(cpu_out_data[ii]);
    for (m = 0; m < cpu_npages; m++) {
      // 'ec_detr:61' regs(:,k) = lin.^k;
      i = cpu_fv->size[0] * cpu_fv->size[1];
      cpu_fv->size[0] = 1;
      cpu_fv->size[1] = cpu_lin->size[1];
      emxEnsureCapacity_real32_T(cpu_fv, i, &g_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_fv, &gpu_fv);
      nx = cpu_lin->size[1];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx), &grid,
        &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (lin_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_lin, cpu_lin);
        }

        lin_dirtyOnCpu = false;
        ec_detr_kernel13<<<grid, block>>>(m, gpu_lin, nx, gpu_fv);
      }

      b_inVectorLength = cpu_regs->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        (b_inVectorLength), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_detr_kernel14<<<grid, block>>>(gpu_fv, static_cast<int32_T>(
          static_cast<real32_T>(m) + 1.0F), b_inVectorLength, gpu_regs,
          cpu_regs->size[0U]);
        regs_dirtyOnGpu = true;
      }
    }

    //  Get regressors from basis function
    //  Detrend per chan
    // 'ec_detr:40' for ch = 1:nChs
    i4 = cpu_x->size[1];
    if (i4 - 1 >= 0) {
      ec_detr_kernel15<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*c_gpu_out_data,
        ii, gpu_i5);
      i5_dirtyOnGpu = true;
    }

    for (int32_T ch{0}; ch < i4; ch++) {
      // 'ec_detr:41' [x(:,ch),w(:,ch)] = detrend_lfn(x(:,ch),w(:,ch),regs,iThr,iItr);
      i = cpu_fv1->size[0];
      cpu_fv1->size[0] = cpu_x->size[0];
      emxEnsureCapacity_real32_T(cpu_fv1, i, &h_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_fv1, &gpu_fv1);
      b_inVectorLength = cpu_x->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
        }

        x_dirtyOnCpu = false;
        ec_detr_kernel16<<<grid, block>>>(ch, gpu_x, b_inVectorLength, gpu_fv1,
          cpu_x->size[0U]);
        fv1_dirtyOnGpu = true;
      }

      i = cpu_fv2->size[0];
      cpu_fv2->size[0] = cpu_w->size[0];
      emxEnsureCapacity_real32_T(cpu_fv2, i, &i_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_fv2, &gpu_fv2);
      b_inVectorLength = cpu_w->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (w_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_w, cpu_w);
        }

        w_dirtyOnCpu = false;
        ec_detr_kernel17<<<grid, block>>>(ch, gpu_w, b_inVectorLength, gpu_fv2,
          cpu_w->size[0U]);
        fv2_dirtyOnGpu = true;
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
      i = cpu_z->size[0];
      cpu_z->size[0] = cpu_x->size[0];
      emxEnsureCapacity_real32_T(cpu_z, i, &j_emlrtRTEI);
      if (!z_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z);
      }

      // 'ec_detr:81' for ii = 1:iItr
      if (i5_dirtyOnGpu) {
        cudaMemcpy(&cpu_i5, gpu_i5, 4UL, cudaMemcpyDeviceToHost);
      }

      i5_dirtyOnGpu = false;
      for (int32_T b_ii{0}; b_ii < cpu_i5; b_ii++) {
        int32_T n;
        int32_T na;
        boolean_T d2scaled_dirtyOnCpu;
        boolean_T out_dirtyOnCpu;

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
          i = cpu_c->size[0];
          cpu_c->size[0] = cpu_fv1->size[0];
          emxEnsureCapacity_real32_T(cpu_c, i, &m_emlrtRTEI);
          if (!c_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_c, &gpu_c);
          }

          b_inVectorLength = cpu_fv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_c, cpu_c);
            }

            ec_detr_kernel18<<<grid, block>>>(gpu_fv2, gpu_fv1, b_inVectorLength,
              gpu_c);
            c_dirtyOnGpu = true;
            c_dirtyOnCpu = false;
          }
        } else {
          if (c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_c, &gpu_c);
          }

          if (fv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
          }

          fv1_dirtyOnGpu = false;
          if (fv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_dirtyOnGpu = false;
          times(cpu_c, cpu_fv1, cpu_fv2);
          c_dirtyOnCpu = true;
          c_dirtyOnGpu = false;
        }

        b_inVectorLength = cpu_c->size[0];
        if (cpu_c->size[0] == 0) {
          cpu_d2scaled = 0.0F;
        } else {
          if (c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_c, &gpu_c);
          }

          c_dirtyOnGpu = false;
          cpu_d2scaled = cpu_c->data[0];
          for (i = 0; i <= b_inVectorLength - 2; i++) {
            cpu_d2scaled += cpu_c->data[i + 1];
          }
        }

        b_inVectorLength = cpu_fv2->size[0];
        if (cpu_fv2->size[0] == 0) {
          abnrm = 0.0F;
        } else {
          if (fv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_dirtyOnGpu = false;
          abnrm = cpu_fv2->data[0];
          for (i = 0; i <= b_inVectorLength - 2; i++) {
            abnrm += cpu_fv2->data[i + 1];
          }
        }

        cpu_out = cpu_d2scaled / (abnrm + 2.22044605E-16F);
        out_dirtyOnCpu = true;

        // 'ec_detr:125' x = x - mn;
        //  Fit weighted regression
        // 'ec_detr:108' x = demean_lfn(x,w).* w;
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ec_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_fv1->size[0] == cpu_fv2->size[0]) {
          i = b_cpu_c->size[0];
          b_cpu_c->size[0] = cpu_fv1->size[0];
          emxEnsureCapacity_real32_T(b_cpu_c, i, &m_emlrtRTEI);
          if (!b_c_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_c, &b_gpu_c);
          }

          b_inVectorLength = cpu_fv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_c, b_cpu_c);
            }

            ec_detr_kernel19<<<grid, block>>>(gpu_fv2, gpu_fv1, b_inVectorLength,
              b_gpu_c);
            b_c_dirtyOnGpu = true;
            b_c_dirtyOnCpu = false;
          }
        } else {
          if (b_c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_c, &b_gpu_c);
          }

          if (fv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
          }

          fv1_dirtyOnGpu = false;
          if (fv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_dirtyOnGpu = false;
          times(b_cpu_c, cpu_fv1, cpu_fv2);
          b_c_dirtyOnCpu = true;
          b_c_dirtyOnGpu = false;
        }

        b_inVectorLength = b_cpu_c->size[0];
        if (b_cpu_c->size[0] == 0) {
          cpu_d2scaled = 0.0F;
        } else {
          if (b_c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_c, &b_gpu_c);
          }

          b_c_dirtyOnGpu = false;
          cpu_d2scaled = b_cpu_c->data[0];
          for (i = 0; i <= b_inVectorLength - 2; i++) {
            cpu_d2scaled += b_cpu_c->data[i + 1];
          }
        }

        b_inVectorLength = cpu_fv2->size[0];
        if (cpu_fv2->size[0] == 0) {
          abnrm = 0.0F;
        } else {
          if (fv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_dirtyOnGpu = false;
          abnrm = cpu_fv2->data[0];
          for (i = 0; i <= b_inVectorLength - 2; i++) {
            abnrm += cpu_fv2->data[i + 1];
          }
        }

        cpu_d2scaled /= abnrm + 2.22044605E-16F;

        // 'ec_detr:125' x = x - mn;
        if (cpu_fv1->size[0] == cpu_fv2->size[0]) {
          i = cpu_fv3->size[0];
          cpu_fv3->size[0] = cpu_fv1->size[0];
          emxEnsureCapacity_real32_T(cpu_fv3, i, &n_emlrtRTEI);
          if (!fv3_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv3, &gpu_fv3);
          }

          b_inVectorLength = cpu_fv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 4UL, cudaMemcpyHostToDevice);
            if (fv3_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv3, cpu_fv3);
            }

            ec_detr_kernel20<<<grid, block>>>(gpu_fv2, gpu_d2scaled, gpu_fv1,
              b_inVectorLength, gpu_fv3);
            fv3_dirtyOnGpu = true;
            fv3_dirtyOnCpu = false;
          }
        } else {
          if (fv3_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv3, &gpu_fv3);
          }

          if (fv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
          }

          fv1_dirtyOnGpu = false;
          if (fv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_dirtyOnGpu = false;
          binary_expand_op(cpu_fv3, cpu_fv1, cpu_d2scaled, cpu_fv2);
          fv3_dirtyOnCpu = true;
          fv3_dirtyOnGpu = false;
        }

        // 'ec_detr:109' r = demean_lfn(r,w);
        //  Demean %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // 'ec_detr:124' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_regs->size[0] == cpu_fv2->size[0]) {
          i = c_cpu_c->size[0] * c_cpu_c->size[1];
          c_cpu_c->size[0] = cpu_regs->size[0];
          c_cpu_c->size[1] = cpu_regs->size[1];
          emxEnsureCapacity_real32_T(c_cpu_c, i, &m_emlrtRTEI);
          if (!c_c_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(c_cpu_c, &c_gpu_c);
          }

          b_inVectorLength = cpu_regs->size[1] - 1;
          i = cpu_regs->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
            1L) * (b_inVectorLength + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_c, c_cpu_c);
            }

            ec_detr_kernel21<<<grid, block>>>(gpu_fv2, gpu_regs, i,
              b_inVectorLength, c_gpu_c, c_cpu_c->size[0U], cpu_regs->size[0U]);
            c_c_dirtyOnGpu = true;
            c_c_dirtyOnCpu = false;
          }
        } else {
          if (c_c_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(c_cpu_c, &c_gpu_c);
          }

          if (regs_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_regs, &gpu_regs);
          }

          regs_dirtyOnGpu = false;
          if (fv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_dirtyOnGpu = false;
          binary_expand_op(c_cpu_c, cpu_regs, cpu_fv2);
          c_c_dirtyOnCpu = true;
          c_c_dirtyOnGpu = false;
        }

        b_inVectorLength = c_cpu_c->size[0];
        if ((c_cpu_c->size[0] == 0) || (c_cpu_c->size[1] == 0)) {
          for (i = 0; i < 2; i++) {
            b_sz[i] = static_cast<uint32_T>(c_cpu_c->size[i]);
          }

          i = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = static_cast<int32_T>(b_sz[1]);
          emxEnsureCapacity_real32_T(cpu_y, i, &d_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_y, &gpu_y);
          b_inVectorLength = static_cast<int32_T>(b_sz[1]) - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detr_kernel23<<<grid, block>>>(static_cast<int32_T>(b_sz[1]) - 1,
              gpu_y);
            y_dirtyOnGpu = true;
          }
        } else {
          cpu_npages = c_cpu_c->size[1];
          i = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = c_cpu_c->size[1];
          emxEnsureCapacity_real32_T(cpu_y, i, &c_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_y, &gpu_y);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (cpu_npages), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_c_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_c, c_cpu_c);
            }

            c_c_dirtyOnCpu = false;
            cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
            ec_detr_kernel22<<<grid, block>>>(b_inVectorLength, c_gpu_c,
              gpu_npages, gpu_y, c_cpu_c->size[0U]);
            y_dirtyOnGpu = true;
          }
        }

        b_inVectorLength = cpu_fv2->size[0];
        if (cpu_fv2->size[0] == 0) {
          cpu_d2scaled = 0.0F;
        } else {
          if (fv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_dirtyOnGpu = false;
          cpu_d2scaled = cpu_fv2->data[0];
          for (i = 0; i <= b_inVectorLength - 2; i++) {
            cpu_d2scaled += cpu_fv2->data[i + 1];
          }
        }

        // 'ec_detr:125' x = x - mn;
        if (cpu_regs->size[1] == cpu_y->size[1]) {
          cpu_d2scaled += 2.22044605E-16F;
          i = cpu_fv4->size[0] * cpu_fv4->size[1];
          cpu_fv4->size[0] = cpu_regs->size[0];
          cpu_fv4->size[1] = cpu_regs->size[1];
          emxEnsureCapacity_real32_T(cpu_fv4, i, &o_emlrtRTEI);
          if (!fv4_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_fv4, &gpu_fv4);
          }

          b_inVectorLength = cpu_regs->size[1] - 1;
          i = cpu_regs->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
            1L) * (b_inVectorLength + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 4UL, cudaMemcpyHostToDevice);
            if (fv4_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv4, cpu_fv4);
            }

            ec_detr_kernel24<<<grid, block>>>(gpu_d2scaled, gpu_y, gpu_regs, i,
              b_inVectorLength, gpu_fv4, cpu_fv4->size[0U], cpu_regs->size[0U]);
            fv4_dirtyOnGpu = true;
            fv4_dirtyOnCpu = false;
          }
        } else {
          if (fv4_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv4, &gpu_fv4);
          }

          if (regs_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_regs, &gpu_regs);
          }

          regs_dirtyOnGpu = false;
          if (y_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_y, &gpu_y);
          }

          y_dirtyOnGpu = false;
          b_binary_expand_op(cpu_fv4, cpu_regs, cpu_y, cpu_d2scaled);
          fv4_dirtyOnCpu = true;
          fv4_dirtyOnGpu = false;
        }

        //  remove channel-specific-weighted mean from regressor
        // 'ec_detr:110' rr = r.*w;
        if (cpu_fv4->size[0] == cpu_fv2->size[0]) {
          i = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = cpu_fv4->size[0];
          cpu_rr->size[1] = cpu_fv4->size[1];
          emxEnsureCapacity_real32_T(cpu_rr, i, &p_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_rr, &gpu_rr);
          }

          b_inVectorLength = cpu_fv4->size[1] - 1;
          i = cpu_fv4->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
            1L) * (b_inVectorLength + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (fv4_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv4, cpu_fv4);
            }

            fv4_dirtyOnCpu = false;
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, cpu_rr);
            }

            ec_detr_kernel25<<<grid, block>>>(gpu_fv2, gpu_fv4, i,
              b_inVectorLength, gpu_rr, cpu_rr->size[0U], cpu_fv4->size[0U]);
            rr_dirtyOnGpu = true;
            rr_dirtyOnCpu = false;
          }
        } else {
          if (rr_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_rr, &gpu_rr);
          }

          if (fv4_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv4, &gpu_fv4);
          }

          fv4_dirtyOnGpu = false;
          if (fv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_dirtyOnGpu = false;
          binary_expand_op(cpu_rr, cpu_fv4, cpu_fv2);
          rr_dirtyOnCpu = true;
          rr_dirtyOnGpu = false;
        }

        // 'ec_detr:111' [V,D] = eig(rr'*rr);
        i = cpu_a->size[0] * cpu_a->size[1];
        cpu_a->size[0] = cpu_rr->size[1];
        cpu_a->size[1] = cpu_rr->size[0];
        emxEnsureCapacity_real32_T(cpu_a, i, &q_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a);
        i = cpu_rr->size[0] - 1;
        b_inVectorLength = cpu_rr->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((b_inVectorLength + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          ec_detr_kernel26<<<grid, block>>>(gpu_rr, b_inVectorLength, i, gpu_a,
            cpu_a->size[0U], cpu_rr->size[0U]);
        }

        if ((cpu_a->size[0] == 0) || (cpu_a->size[1] == 0) || (cpu_rr->size[0] ==
             0) || (cpu_rr->size[1] == 0)) {
          i = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = cpu_a->size[0];
          cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(cpu_A, i, &m_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_A, &gpu_A);
          }

          b_inVectorLength = cpu_a->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (A_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, cpu_A);
            }

            ec_detr_kernel27<<<grid, block>>>(b_inVectorLength, gpu_A);
            A_dirtyOnGpu = true;
            A_dirtyOnCpu = false;
          }
        } else {
          i = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = cpu_a->size[0];
          cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(cpu_A, i, &r_emlrtRTEI);
          if (!A_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_A, &gpu_A);
          }

          cpu_d2scaled = 1.0F;
          abnrm = 0.0F;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          if (A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, cpu_A);
          }

          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      cpu_a->size[0], cpu_rr->size[1], cpu_a->size[1], (float *)
                      &cpu_d2scaled, (float *)&gpu_a.data[0], cpu_a->size[0],
                      (float *)&gpu_rr.data[0], cpu_a->size[1], (float *)&abnrm,
                      (float *)&gpu_A.data[0], cpu_a->size[0]);
          A_dirtyOnGpu = true;
          A_dirtyOnCpu = false;
        }

        n = cpu_A->size[0];
        i = cpu_V->size[0] * cpu_V->size[1];
        cpu_V->size[0] = cpu_A->size[0];
        cpu_V->size[1] = cpu_A->size[0];
        emxEnsureCapacity_creal32_T(cpu_V, i, &s_emlrtRTEI);
        if (!V_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V);
        }

        i = cpu_D->size[0] * cpu_D->size[1];
        cpu_D->size[0] = cpu_A->size[0];
        cpu_D->size[1] = cpu_A->size[0];
        emxEnsureCapacity_creal32_T(cpu_D, i, &t_emlrtRTEI);
        if (!D_dirtyOnCpu) {
          gpuEmxEnsureCapacity_creal32_T(cpu_D, &gpu_D);
        }

        if ((cpu_A->size[0] != 0) && (cpu_A->size[1] != 0)) {
          nx = cpu_A->size[0] * cpu_A->size[1];
          olPct_dirtyOnCpu = true;
          for (m = 0; m < nx; m++) {
            if (olPct_dirtyOnCpu) {
              if (A_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &gpu_A);
              }

              A_dirtyOnGpu = false;
              if (std::isinf(cpu_A->data[m]) || std::isnan(cpu_A->data[m])) {
                olPct_dirtyOnCpu = false;
              }
            } else {
              olPct_dirtyOnCpu = false;
            }
          }

          if (!olPct_dirtyOnCpu) {
            for (i = 0; i < 2; i++) {
              fv2[i] = cpu_V->size[i];
            }

            i = cpu_V->size[0] * cpu_V->size[1];
            cpu_V->size[0] = fv2[0];
            cpu_V->size[1] = fv2[1];
            emxEnsureCapacity_creal32_T(cpu_V, i, &v_emlrtRTEI);
            if (!V_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V);
            }

            b_inVectorLength = fv2[0] * fv2[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (V_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, cpu_V);
              }

              ec_detr_kernel49<<<grid, block>>>(gpu_fc, b_inVectorLength, gpu_V);
              V_dirtyOnGpu = true;
              V_dirtyOnCpu = false;
            }

            for (i = 0; i < 2; i++) {
              fv2[i] = cpu_D->size[i];
            }

            i = cpu_D->size[0] * cpu_D->size[1];
            cpu_D->size[0] = fv2[0];
            cpu_D->size[1] = fv2[1];
            emxEnsureCapacity_creal32_T(cpu_D, i, &bb_emlrtRTEI);
            if (!D_dirtyOnCpu) {
              gpuEmxEnsureCapacity_creal32_T(cpu_D, &gpu_D);
            }

            b_inVectorLength = fv2[0] * fv2[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (D_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, cpu_D);
              }

              ec_detr_kernel50<<<grid, block>>>(b_inVectorLength, gpu_D);
              D_dirtyOnGpu = true;
              D_dirtyOnCpu = false;
            }

            for (m = 0; m < n; m++) {
              if (D_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &gpu_D);
              }

              if (fc_dirtyOnGpu) {
                cudaMemcpy(&cpu_fc, gpu_fc, 8UL, cudaMemcpyDeviceToHost);
              }

              fc_dirtyOnGpu = false;
              cpu_D->data[m + cpu_D->size[0] * m] = cpu_fc;
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
                i = 0;
                do {
                  exitg1 = 0;
                  if (i <= na) {
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &gpu_A);
                    }

                    A_dirtyOnGpu = false;
                    if (!(cpu_A->data[i + cpu_A->size[0] * na] == cpu_A->data[na
                          + cpu_A->size[0] * i])) {
                      olPct_dirtyOnCpu = false;
                      exitg1 = 1;
                    } else {
                      i++;
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
              i = cpu_W->size[0];
              cpu_W->size[0] = cpu_A->size[0];
              emxEnsureCapacity_real32_T(cpu_W, i, &y_emlrtRTEI);
              if (!W_dirtyOnCpu) {
                gpuEmxEnsureCapacity_real32_T(cpu_W, &gpu_W);
              }

              if (A_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &gpu_A);
              }

              if (W_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_W, &gpu_W);
              }

              info_t = LAPACKE_ssyev(102, 'V', 'L', n_t, &cpu_A->data[0], n_t,
                &cpu_W->data[0]);
              W_dirtyOnCpu = true;
              W_dirtyOnGpu = false;
              A_dirtyOnCpu = true;
              A_dirtyOnGpu = false;
              if ((int32_T)info_t < 0) {
                b_inVectorLength = cpu_W->size[0];
                i = cpu_W->size[0];
                cpu_W->size[0] = b_inVectorLength;
                emxEnsureCapacity_real32_T(cpu_W, i, &eb_emlrtRTEI);
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_inVectorLength), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_W, cpu_W);
                  ec_detr_kernel45<<<grid, block>>>(b_inVectorLength, gpu_W);
                  W_dirtyOnGpu = true;
                  W_dirtyOnCpu = false;
                }

                for (i = 0; i < 2; i++) {
                  fv2[i] = cpu_A->size[i];
                }

                i = cpu_A->size[0] * cpu_A->size[1];
                cpu_A->size[0] = fv2[0];
                cpu_A->size[1] = fv2[1];
                emxEnsureCapacity_real32_T(cpu_A, i, &mb_emlrtRTEI);
                b_inVectorLength = fv2[0] * fv2[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, cpu_A);
                  ec_detr_kernel46<<<grid, block>>>(b_inVectorLength, gpu_A);
                  A_dirtyOnGpu = true;
                  A_dirtyOnCpu = false;
                }
              }

              i = cpu_D->size[0] * cpu_D->size[1];
              cpu_D->size[0] = n;
              cpu_D->size[1] = n;
              emxEnsureCapacity_creal32_T(cpu_D, i, &db_emlrtRTEI);
              if (!D_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal32_T(cpu_D, &gpu_D);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n *
                n), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (D_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, cpu_D);
                }

                ec_detr_kernel47<<<grid, block>>>(n, gpu_D);
                D_dirtyOnGpu = true;
                D_dirtyOnCpu = false;
              }

              for (i = 0; i < n; i++) {
                if (D_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &gpu_D);
                }

                if (W_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(cpu_W, &gpu_W);
                }

                W_dirtyOnGpu = false;
                cpu_D->data[i + cpu_D->size[0] * i].re = cpu_W->data[i];
                cpu_D->data[i + cpu_D->size[0] * i].im = 0.0F;
                D_dirtyOnCpu = true;
                D_dirtyOnGpu = false;
              }

              i = cpu_V->size[0] * cpu_V->size[1];
              cpu_V->size[0] = cpu_A->size[0];
              cpu_V->size[1] = cpu_A->size[1];
              emxEnsureCapacity_creal32_T(cpu_V, i, &nb_emlrtRTEI);
              if (!V_dirtyOnCpu) {
                gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V);
              }

              i = cpu_A->size[0] * cpu_A->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (A_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, cpu_A);
                }

                A_dirtyOnCpu = false;
                if (V_dirtyOnCpu) {
                  gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, cpu_V);
                }

                ec_detr_kernel48<<<grid, block>>>(gpu_A, i, gpu_V);
                V_dirtyOnGpu = true;
                V_dirtyOnCpu = false;
              }
            } else {
              olPct_dirtyOnCpu = (cpu_A->size[0] == cpu_A->size[1]);
              if (olPct_dirtyOnCpu) {
                na = 0;
                exitg2 = false;
                while ((!exitg2) && (na <= cpu_A->size[1] - 1)) {
                  i = 0;
                  do {
                    exitg1 = 0;
                    if (i <= na) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (!(cpu_A->data[i + cpu_A->size[0] * na] == -cpu_A->
                            data[na + cpu_A->size[0] * i])) {
                        olPct_dirtyOnCpu = false;
                        exitg1 = 1;
                      } else {
                        i++;
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
                nx = cpu_A->size[0] * cpu_A->size[1];
                for (m = 0; m < nx; m++) {
                  if (olPct_dirtyOnCpu) {
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &gpu_A);
                    }

                    A_dirtyOnGpu = false;
                    if (std::isinf(cpu_A->data[m]) || std::isnan(cpu_A->data[m]))
                    {
                      olPct_dirtyOnCpu = false;
                    }
                  } else {
                    olPct_dirtyOnCpu = false;
                  }
                }

                if (!olPct_dirtyOnCpu) {
                  for (i = 0; i < 2; i++) {
                    b_sz[i] = static_cast<uint32_T>(cpu_A->size[i]);
                  }

                  i = cpu_U->size[0] * cpu_U->size[1];
                  cpu_U->size[0] = static_cast<int32_T>(b_sz[0]);
                  cpu_U->size[1] = static_cast<int32_T>(b_sz[1]);
                  emxEnsureCapacity_real32_T(cpu_U, i, &jb_emlrtRTEI);
                  if (!U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(cpu_U, &gpu_U);
                  }

                  b_inVectorLength = static_cast<int32_T>(b_sz[0]) *
                    static_cast<int32_T>(b_sz[1]) - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, cpu_U);
                    }

                    ec_detr_kernel40<<<grid, block>>>(b_inVectorLength, gpu_U);
                    U_dirtyOnGpu = true;
                    U_dirtyOnCpu = false;
                  }

                  m = static_cast<int32_T>(b_sz[0]);
                  if (static_cast<int32_T>(b_sz[0]) > 1) {
                    nx = 2;
                    if (static_cast<int32_T>(b_sz[0]) - 2 < static_cast<int32_T>
                        (b_sz[1]) - 1) {
                      cpu_npages = static_cast<int32_T>(b_sz[0]) - 1;
                    } else {
                      cpu_npages = static_cast<int32_T>(b_sz[1]);
                    }

                    for (na = 0; na < cpu_npages; na++) {
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(computeEndIdx(static_cast<int64_T>
                           (nx), static_cast<int64_T>(m), 1L) + 1L), &grid,
                         &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        if (U_dirtyOnCpu) {
                          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, cpu_U);
                        }

                        ec_detr_kernel41<<<grid, block>>>(na + 1, nx, m, gpu_U,
                          cpu_U->size[0U]);
                        U_dirtyOnGpu = true;
                        U_dirtyOnCpu = false;
                      }

                      nx++;
                    }
                  }

                  for (i = 0; i < 2; i++) {
                    b_sz[i] = static_cast<uint32_T>(cpu_A->size[i]);
                  }

                  i = cpu_A->size[0] * cpu_A->size[1];
                  cpu_A->size[0] = static_cast<int32_T>(b_sz[0]);
                  cpu_A->size[1] = static_cast<int32_T>(b_sz[1]);
                  emxEnsureCapacity_real32_T(cpu_A, i, &sb_emlrtRTEI);
                  if (!A_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(cpu_A, &gpu_A);
                  }

                  b_inVectorLength = static_cast<int32_T>(b_sz[0]) *
                    static_cast<int32_T>(b_sz[1]) - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, cpu_A);
                    }

                    ec_detr_kernel42<<<grid, block>>>(b_inVectorLength, gpu_A);
                    A_dirtyOnGpu = true;
                    A_dirtyOnCpu = false;
                  }
                } else {
                  ptrdiff_t b_n_t;
                  ptrdiff_t c_info_t;
                  ptrdiff_t e_info_t;
                  n = cpu_A->size[0];
                  i = cpu_tau->size[0];
                  cpu_tau->size[0] = cpu_A->size[0] - 1;
                  emxEnsureCapacity_real32_T(cpu_tau, i, &fb_emlrtRTEI);
                  if (!tau_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(cpu_tau, &b_gpu_tau);
                  }

                  if (cpu_A->size[0] > 1) {
                    ptrdiff_t b_info_t;
                    if (A_dirtyOnGpu) {
                      gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &gpu_A);
                    }

                    b_info_t = LAPACKE_sgehrd(102, (ptrdiff_t)cpu_A->size[0],
                      (ptrdiff_t)1, (ptrdiff_t)cpu_A->size[0], &cpu_A->data[0],
                      (ptrdiff_t)cpu_A->size[0], &cpu_tau->data[0]);
                    tau_dirtyOnCpu = true;
                    A_dirtyOnCpu = true;
                    A_dirtyOnGpu = false;
                    if ((int32_T)b_info_t != 0) {
                      for (i = 0; i < 2; i++) {
                        fv2[i] = cpu_A->size[i];
                      }

                      i = cpu_A->size[0] * cpu_A->size[1];
                      cpu_A->size[0] = fv2[0];
                      cpu_A->size[1] = fv2[1];
                      emxEnsureCapacity_real32_T(cpu_A, i, &qb_emlrtRTEI);
                      b_inVectorLength = fv2[0] * fv2[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(b_inVectorLength + 1L), &grid,
                         &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, cpu_A);
                        ec_detr_kernel34<<<grid, block>>>(b_inVectorLength,
                          gpu_A);
                        A_dirtyOnGpu = true;
                        A_dirtyOnCpu = false;
                      }

                      b_inVectorLength = cpu_tau->size[0];
                      i = cpu_tau->size[0];
                      cpu_tau->size[0] = b_inVectorLength;
                      emxEnsureCapacity_real32_T(cpu_tau, i, &ub_emlrtRTEI);
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(b_inVectorLength), &grid, &block,
                         1024U, 65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_tau, cpu_tau);
                        ec_detr_kernel35<<<grid, block>>>(b_inVectorLength,
                          b_gpu_tau);
                        tau_dirtyOnGpu = true;
                        tau_dirtyOnCpu = false;
                      }
                    }
                  }

                  i = cpu_U->size[0] * cpu_U->size[1];
                  cpu_U->size[0] = cpu_A->size[0];
                  cpu_U->size[1] = cpu_A->size[1];
                  emxEnsureCapacity_real32_T(cpu_U, i, &lb_emlrtRTEI);
                  if (!U_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_real32_T(cpu_U, &gpu_U);
                  }

                  i = cpu_A->size[0] * cpu_A->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, cpu_A);
                    }

                    if (U_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, cpu_U);
                    }

                    ec_detr_kernel36<<<grid, block>>>(gpu_A, i, gpu_U);
                    U_dirtyOnGpu = true;
                  }

                  if (U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_U, &gpu_U);
                  }

                  if (tau_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_tau, &b_gpu_tau);
                  }

                  tau_dirtyOnGpu = false;
                  c_info_t = LAPACKE_sorghr(102, (ptrdiff_t)n, (ptrdiff_t)1,
                    (ptrdiff_t)n, &cpu_U->data[0], (ptrdiff_t)n, &cpu_tau->data
                    [0]);
                  U_dirtyOnGpu = false;
                  if ((int32_T)c_info_t != 0) {
                    for (i = 0; i < 2; i++) {
                      fv2[i] = cpu_U->size[i];
                    }

                    i = cpu_U->size[0] * cpu_U->size[1];
                    cpu_U->size[0] = fv2[0];
                    cpu_U->size[1] = fv2[1];
                    emxEnsureCapacity_real32_T(cpu_U, i, &lb_emlrtRTEI);
                    b_inVectorLength = fv2[0] * fv2[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_inVectorLength + 1L), &grid, &block,
                       1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, cpu_U);
                      ec_detr_kernel37<<<grid, block>>>(b_inVectorLength, gpu_U);
                      U_dirtyOnGpu = true;
                    }
                  }

                  b_n_t = (ptrdiff_t)cpu_A->size[0];
                  i = wr->size[0] * wr->size[1];
                  wr->size[0] = 1;
                  wr->size[1] = cpu_A->size[0];
                  emxEnsureCapacity_real32_T(wr, i, &tb_emlrtRTEI);
                  i = wi->size[0] * wi->size[1];
                  wi->size[0] = 1;
                  wi->size[1] = cpu_A->size[0];
                  emxEnsureCapacity_real32_T(wi, i, &wb_emlrtRTEI);
                  if (A_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &gpu_A);
                  }

                  if (U_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real32_T(cpu_U, &gpu_U);
                  }

                  if (cpu_A->size[0] <= 1) {
                    b_inVectorLength = 1;
                  } else {
                    b_inVectorLength = cpu_A->size[0];
                  }

                  e_info_t = LAPACKE_shseqr(102, 'S', 'V', b_n_t, (ptrdiff_t)1,
                    (ptrdiff_t)cpu_A->size[0], &cpu_A->data[0], b_n_t, &wr->
                    data[0], &wi->data[0], &cpu_U->data[0], (ptrdiff_t)
                    b_inVectorLength);
                  U_dirtyOnCpu = true;
                  U_dirtyOnGpu = false;
                  A_dirtyOnCpu = true;
                  A_dirtyOnGpu = false;
                  if ((int32_T)e_info_t < 0) {
                    for (i = 0; i < 2; i++) {
                      fv2[i] = cpu_A->size[i];
                    }

                    i = cpu_A->size[0] * cpu_A->size[1];
                    cpu_A->size[0] = fv2[0];
                    cpu_A->size[1] = fv2[1];
                    emxEnsureCapacity_real32_T(cpu_A, i, &cc_emlrtRTEI);
                    b_inVectorLength = fv2[0] * fv2[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_inVectorLength + 1L), &grid, &block,
                       1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_A, cpu_A);
                      ec_detr_kernel38<<<grid, block>>>(b_inVectorLength, gpu_A);
                      A_dirtyOnGpu = true;
                      A_dirtyOnCpu = false;
                    }

                    for (i = 0; i < 2; i++) {
                      fv2[i] = cpu_U->size[i];
                    }

                    i = cpu_U->size[0] * cpu_U->size[1];
                    cpu_U->size[0] = fv2[0];
                    cpu_U->size[1] = fv2[1];
                    emxEnsureCapacity_real32_T(cpu_U, i, &gc_emlrtRTEI);
                    b_inVectorLength = fv2[0] * fv2[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_inVectorLength + 1L), &grid, &block,
                       1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, cpu_U);
                      ec_detr_kernel39<<<grid, block>>>(b_inVectorLength, gpu_U);
                      U_dirtyOnGpu = true;
                      U_dirtyOnCpu = false;
                    }
                  }
                }

                n = cpu_A->size[0];
                i = cpu_D->size[0] * cpu_D->size[1];
                cpu_D->size[0] = cpu_A->size[0];
                cpu_D->size[1] = cpu_A->size[0];
                emxEnsureCapacity_creal32_T(cpu_D, i, &yb_emlrtRTEI);
                if (!D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal32_T(cpu_D, &gpu_D);
                }

                i = cpu_A->size[0] * cpu_A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (i + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, cpu_D);
                  }

                  ec_detr_kernel43<<<grid, block>>>(i, gpu_D);
                  D_dirtyOnGpu = true;
                  D_dirtyOnCpu = false;
                }

                i = 1;
                do {
                  exitg1 = 0;
                  if (i <= n) {
                    if (i != n) {
                      if (A_dirtyOnGpu) {
                        gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (cpu_A->data[i + cpu_A->size[0] * (i - 1)] != 0.0F) {
                        cpu_d2scaled = std::abs(cpu_A->data[i + cpu_A->size[0] *
                          (i - 1)]);
                        if (D_dirtyOnGpu) {
                          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &gpu_D);
                        }

                        cpu_D->data[(i + cpu_D->size[0] * (i - 1)) - 1].re =
                          0.0F;
                        cpu_D->data[(i + cpu_D->size[0] * (i - 1)) - 1].im =
                          cpu_d2scaled;
                        cpu_D->data[i + cpu_D->size[0] * i].re = 0.0F;
                        cpu_D->data[i + cpu_D->size[0] * i].im = -cpu_d2scaled;
                        D_dirtyOnCpu = true;
                        D_dirtyOnGpu = false;
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

                i = cpu_V->size[0] * cpu_V->size[1];
                cpu_V->size[0] = cpu_U->size[0];
                cpu_V->size[1] = cpu_U->size[1];
                emxEnsureCapacity_creal32_T(cpu_V, i, &fc_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V);
                }

                b_inVectorLength = cpu_U->size[0] * cpu_U->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (U_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_U, cpu_U);
                  }

                  U_dirtyOnCpu = false;
                  if (V_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, cpu_V);
                  }

                  ec_detr_kernel44<<<grid, block>>>(gpu_U, b_inVectorLength,
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
                        gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &gpu_A);
                      }

                      A_dirtyOnGpu = false;
                      if (cpu_A->data[na + cpu_A->size[0] * (na - 1)] != 0.0F) {
                        if (cpu_A->data[na + cpu_A->size[0] * (na - 1)] < 0.0F)
                        {
                          nx = 1;
                        } else {
                          nx = -1;
                        }

                        for (i = 0; i < n; i++) {
                          if (V_dirtyOnGpu) {
                            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_V, &gpu_V);
                          }

                          cpu_d2scaled = cpu_V->data[i + cpu_V->size[0] * (na -
                            1)].re;
                          abnrm = static_cast<real32_T>(nx) * cpu_V->data[i +
                            cpu_V->size[0] * na].re;
                          if (abnrm == 0.0F) {
                            cpu_V->data[i + cpu_V->size[0] * (na - 1)].re =
                              cpu_d2scaled / 1.41421354F;
                            cpu_V->data[i + cpu_V->size[0] * (na - 1)].im = 0.0F;
                            V_dirtyOnGpu = false;
                          } else if (cpu_d2scaled == 0.0F) {
                            cpu_V->data[i + cpu_V->size[0] * (na - 1)].re = 0.0F;
                            cpu_V->data[i + cpu_V->size[0] * (na - 1)].im =
                              abnrm / 1.41421354F;
                            V_dirtyOnGpu = false;
                          } else {
                            cpu_V->data[i + cpu_V->size[0] * (na - 1)].re =
                              cpu_d2scaled / 1.41421354F;
                            cpu_V->data[i + cpu_V->size[0] * (na - 1)].im =
                              abnrm / 1.41421354F;
                            V_dirtyOnGpu = false;
                          }

                          cpu_V->data[i + cpu_V->size[0] * na].re = cpu_V->
                            data[i + cpu_V->size[0] * (na - 1)].re;
                          cpu_V->data[i + cpu_V->size[0] * na].im = -cpu_V->
                            data[i + cpu_V->size[0] * (na - 1)].im;
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
                cpu_npages = cpu_A->size[1] - 1;
                olPct_dirtyOnCpu = true;
                i = scale->size[0];
                scale->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(scale, i, &ab_emlrtRTEI);
                i = b_cpu_W->size[0];
                b_cpu_W->size[0] = cpu_A->size[1];
                emxEnsureCapacity_creal32_T(b_cpu_W, i, &cb_emlrtRTEI);
                gpuEmxEnsureCapacity_creal32_T(b_cpu_W, &b_gpu_W);
                i = cpu_V->size[0] * cpu_V->size[1];
                cpu_V->size[0] = cpu_A->size[1];
                cpu_V->size[1] = cpu_A->size[1];
                emxEnsureCapacity_creal32_T(cpu_V, i, &gb_emlrtRTEI);
                if (!V_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V);
                }

                i = cpu_wreal->size[0];
                cpu_wreal->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(cpu_wreal, i, &ib_emlrtRTEI);
                if (!wreal_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_wreal, &gpu_wreal);
                }

                i = cpu_wimag->size[0];
                cpu_wimag->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(cpu_wimag, i, &kb_emlrtRTEI);
                if (!wimag_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_wimag, &gpu_wimag);
                }

                i = cpu_vright->size[0] * cpu_vright->size[1];
                cpu_vright->size[0] = cpu_A->size[1];
                cpu_vright->size[1] = cpu_A->size[1];
                emxEnsureCapacity_real32_T(cpu_vright, i, &ob_emlrtRTEI);
                if (!vright_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_real32_T(cpu_vright, &gpu_vright);
                }

                if (A_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real32_T(cpu_A, &gpu_A);
                }

                d_info_t = LAPACKE_sgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)
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
                  b_inVectorLength = cpu_A->size[1];
                  i = b_cpu_W->size[0];
                  b_cpu_W->size[0] = cpu_A->size[1];
                  emxEnsureCapacity_creal32_T(b_cpu_W, i, &vb_emlrtRTEI);
                  gpuEmxEnsureCapacity_creal32_T(b_cpu_W, &b_gpu_W);
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_inVectorLength), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    ec_detr_kernel31<<<grid, block>>>(gpu_fc2, b_inVectorLength,
                      b_gpu_W);
                    b_W_dirtyOnGpu = true;
                  }

                  for (i = 0; i < 2; i++) {
                    fv2[i] = cpu_V->size[i];
                  }

                  i = cpu_V->size[0] * cpu_V->size[1];
                  cpu_V->size[0] = fv2[0];
                  cpu_V->size[1] = fv2[1];
                  emxEnsureCapacity_creal32_T(cpu_V, i, &ac_emlrtRTEI);
                  if (!V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V);
                  }

                  b_inVectorLength = fv2[0] * fv2[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, cpu_V);
                    }

                    ec_detr_kernel32<<<grid, block>>>(gpu_fc2, b_inVectorLength,
                      gpu_V);
                    V_dirtyOnGpu = true;
                    V_dirtyOnCpu = false;
                  }
                } else {
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_npages + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_wimag, cpu_wimag);
                    wimag_dirtyOnCpu = false;
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_wreal, cpu_wreal);
                    wreal_dirtyOnCpu = false;
                    cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                               cudaMemcpyHostToDevice);
                    olPct_dirtyOnCpu = false;
                    ec_detr_kernel28<<<grid, block>>>(gpu_wimag, gpu_wreal,
                      gpu_npages, b_gpu_W);
                    b_W_dirtyOnGpu = true;
                  }

                  i = cpu_V->size[0] * cpu_V->size[1];
                  cpu_V->size[0] = cpu_vright->size[0];
                  cpu_V->size[1] = cpu_vright->size[1];
                  emxEnsureCapacity_creal32_T(cpu_V, i, &xb_emlrtRTEI);
                  if (!V_dirtyOnCpu) {
                    gpuEmxEnsureCapacity_creal32_T(cpu_V, &gpu_V);
                  }

                  b_inVectorLength = cpu_vright->size[0] * cpu_vright->size[1] -
                    1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_vright, cpu_vright);
                    vright_dirtyOnCpu = false;
                    if (V_dirtyOnCpu) {
                      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, cpu_V);
                    }

                    ec_detr_kernel29<<<grid, block>>>(gpu_vright,
                      b_inVectorLength, gpu_V);
                    V_dirtyOnGpu = true;
                    V_dirtyOnCpu = false;
                  }

                  for (i = 0; i < cpu_npages; i++) {
                    if ((cpu_wimag->data[i] > 0.0F) && (cpu_wimag->data[i + 1] <
                         0.0F)) {
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(cpu_npages + 1L), &grid, &block,
                         1024U, 65535U);
                      if (validLaunchParams) {
                        if (olPct_dirtyOnCpu) {
                          cudaMemcpy(gpu_npages, &cpu_npages, 4UL,
                                     cudaMemcpyHostToDevice);
                        }

                        olPct_dirtyOnCpu = false;
                        if (V_dirtyOnCpu) {
                          gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, cpu_V);
                        }

                        ec_detr_kernel30<<<grid, block>>>(i + 2, gpu_npages,
                          gpu_V, cpu_V->size[0U]);
                        V_dirtyOnGpu = true;
                        V_dirtyOnCpu = false;
                      }
                    }
                  }
                }

                i = cpu_D->size[0] * cpu_D->size[1];
                cpu_D->size[0] = cpu_A->size[0];
                cpu_D->size[1] = cpu_A->size[0];
                emxEnsureCapacity_creal32_T(cpu_D, i, &dc_emlrtRTEI);
                if (!D_dirtyOnCpu) {
                  gpuEmxEnsureCapacity_creal32_T(cpu_D, &gpu_D);
                }

                i = cpu_A->size[0] * cpu_A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (i + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_dirtyOnCpu) {
                    gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, cpu_D);
                  }

                  ec_detr_kernel33<<<grid, block>>>(i, gpu_D);
                  D_dirtyOnGpu = true;
                  D_dirtyOnCpu = false;
                }

                for (m = 0; m < n; m++) {
                  if (D_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &gpu_D);
                  }

                  if (b_W_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_creal32_T(b_cpu_W, &b_gpu_W);
                  }

                  b_W_dirtyOnGpu = false;
                  cpu_D->data[m + cpu_D->size[0] * m] = b_cpu_W->data[m];
                  D_dirtyOnCpu = true;
                  D_dirtyOnGpu = false;
                }
              }
            }
          }
        }

        // 'ec_detr:112' V = real(V);
        i = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = cpu_V->size[0];
        b_cpu_V->size[1] = cpu_V->size[1];
        emxEnsureCapacity_real32_T(b_cpu_V, i, &u_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_V, &b_gpu_V);
        b_inVectorLength = cpu_V->size[0] * cpu_V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (V_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_V, cpu_V);
          }

          V_dirtyOnCpu = false;
          ec_detr_kernel51<<<grid, block>>>(gpu_V, b_inVectorLength, b_gpu_V);
        }

        // 'ec_detr:113' D = real(diag(D));
        if ((cpu_D->size[0] == 1) && (cpu_D->size[1] == 1)) {
          i = cpu_d->size[0];
          cpu_d->size[0] = 1;
          emxEnsureCapacity_creal32_T(cpu_d, i, &x_emlrtRTEI);
          if (!d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal32_T(cpu_d, &b_gpu_d);
          }

          if (D_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_D, &gpu_D);
          }

          D_dirtyOnGpu = false;
          cpu_d->data[0] = cpu_D->data[0];
          d_dirtyOnCpu = true;
        } else {
          n = cpu_D->size[0];
          nx = cpu_D->size[1];
          if (n <= nx) {
            nx = n;
          }

          if (cpu_D->size[1] <= 0) {
            nx = 0;
          }

          i = cpu_d->size[0];
          cpu_d->size[0] = nx;
          emxEnsureCapacity_creal32_T(cpu_d, i, &w_emlrtRTEI);
          if (!d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_creal32_T(cpu_d, &b_gpu_d);
          }

          nx--;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (D_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_D, cpu_D);
            }

            D_dirtyOnCpu = false;
            if (d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_creal32_T(&b_gpu_d, cpu_d);
            }

            ec_detr_kernel52<<<grid, block>>>(gpu_D, nx, b_gpu_d, cpu_D->size[0U]);
            d_dirtyOnGpu = true;
            d_dirtyOnCpu = false;
          }
        }

        // 'ec_detr:114' V = V(:,D/max(D)>thrPCA);
        b_inVectorLength = cpu_d->size[0];
        if (d_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_d, &b_gpu_d);
        }

        d_dirtyOnGpu = false;
        cpu_d2scaled = cpu_d->data[0].re;
        d2scaled_dirtyOnCpu = true;
        for (i = 0; i <= b_inVectorLength - 2; i++) {
          if (std::isnan(cpu_d->data[i + 1].re)) {
            olPct_dirtyOnCpu = false;
          } else if (std::isnan(cpu_d2scaled)) {
            olPct_dirtyOnCpu = true;
          } else {
            olPct_dirtyOnCpu = (cpu_d2scaled < cpu_d->data[i + 1].re);
          }

          if (olPct_dirtyOnCpu) {
            cpu_d2scaled = cpu_d->data[i + 1].re;
          }
        }

        b_inVectorLength = cpu_d->size[0] - 1;
        nx = 0;
        for (i = 0; i <= b_inVectorLength; i++) {
          if (cpu_d->data[i].re / cpu_d2scaled > 1.0E-7F) {
            nx++;
          }
        }

        i = cpu_iv->size[0];
        cpu_iv->size[0] = nx;
        emxEnsureCapacity_int32_T(cpu_iv, i, &hb_emlrtRTEI);
        if (!iv_dirtyOnCpu) {
          gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv);
        }

        nx = 0;
        for (i = 0; i <= b_inVectorLength; i++) {
          if (cpu_d->data[i].re / cpu_d2scaled > 1.0E-7F) {
            cpu_iv->data[nx] = i;
            iv_dirtyOnCpu = true;
            nx++;
          }
        }

        nx = b_cpu_V->size[0];
        i = c_cpu_V->size[0] * c_cpu_V->size[1];
        c_cpu_V->size[0] = b_cpu_V->size[0];
        c_cpu_V->size[1] = cpu_iv->size[0];
        emxEnsureCapacity_real32_T(c_cpu_V, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_cpu_V, &c_gpu_V);
        b_inVectorLength = cpu_iv->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx *
          (b_inVectorLength + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv, cpu_iv);
          }

          iv_dirtyOnCpu = false;
          ec_detr_kernel53<<<grid, block>>>(gpu_iv, b_gpu_V, nx,
            b_inVectorLength, c_gpu_V, c_cpu_V->size[0U], b_cpu_V->size[0U]);
        }

        i = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = c_cpu_V->size[0];
        b_cpu_V->size[1] = c_cpu_V->size[1];
        emxEnsureCapacity_real32_T(b_cpu_V, i, &rb_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_V, &b_gpu_V);
        b_inVectorLength = c_cpu_V->size[0] * c_cpu_V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detr_kernel54<<<grid, block>>>(c_gpu_V, b_inVectorLength, b_gpu_V);
        }

        //  discard weak dims
        // 'ec_detr:115' rr = rr*V;
        nx = cpu_rr->size[0];
        cpu_npages = cpu_rr->size[1];
        if ((cpu_rr->size[0] == 0) || (cpu_rr->size[1] == 0) || (b_cpu_V->size[0]
             == 0) || (b_cpu_V->size[1] == 0)) {
          nx = cpu_rr->size[0];
          fv2[0] = cpu_rr->size[0];
          fv2[1] = b_cpu_V->size[1];
          i = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = nx;
          cpu_rr->size[1] = b_cpu_V->size[1];
          emxEnsureCapacity_real32_T(cpu_rr, i, &ec_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_rr, &gpu_rr);
          }

          b_inVectorLength = fv2[0] * fv2[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, cpu_rr);
            }

            ec_detr_kernel56<<<grid, block>>>(b_inVectorLength, gpu_rr);
            rr_dirtyOnGpu = true;
            rr_dirtyOnCpu = false;
          }
        } else {
          i = b_cpu_A->size[0] * b_cpu_A->size[1];
          b_cpu_A->size[0] = cpu_rr->size[0];
          b_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(b_cpu_A, i, &bc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(b_cpu_A, &d_gpu_A);
          i = cpu_rr->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (rr_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, cpu_rr);
            }

            rr_dirtyOnCpu = false;
            ec_detr_kernel55<<<grid, block>>>(gpu_rr, i, d_gpu_A);
          }

          i = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = nx;
          cpu_rr->size[1] = b_cpu_V->size[1];
          emxEnsureCapacity_real32_T(cpu_rr, i, &r_emlrtRTEI);
          if (!rr_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_rr, &gpu_rr);
          }

          cpu_d2scaled = 1.0F;
          abnrm = 0.0F;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, cpu_rr);
          }

          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, nx,
                      b_cpu_V->size[1], cpu_npages, (float *)&cpu_d2scaled,
                      (float *)&d_gpu_A.data[0], nx, (float *)&b_gpu_V.data[0],
                      cpu_npages, (float *)&abnrm, (float *)&gpu_rr.data[0], nx);
          rr_dirtyOnGpu = true;
          rr_dirtyOnCpu = false;
        }

        // 'ec_detr:116' b = (x'*rr) / (rr'*rr);
        i = b_cpu_a->size[0] * b_cpu_a->size[1];
        b_cpu_a->size[0] = 1;
        b_cpu_a->size[1] = cpu_fv3->size[0];
        emxEnsureCapacity_real32_T(b_cpu_a, i, &hc_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_a, &b_gpu_a);
        b_inVectorLength = cpu_fv3->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (fv3_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv3, cpu_fv3);
          }

          fv3_dirtyOnCpu = false;
          ec_detr_kernel57<<<grid, block>>>(gpu_fv3, b_inVectorLength, b_gpu_a);
        }

        if ((cpu_fv3->size[0] == 0) || (cpu_rr->size[0] == 0) || (cpu_rr->size[1]
             == 0)) {
          i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(cpu_b, i, &m_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b);
          }

          i = cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
            }

            ec_detr_kernel58<<<grid, block>>>(i, gpu_b);
            b_dirtyOnCpu = false;
          }
        } else {
          i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(cpu_b, i, &r_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b);
          }

          cpu_d2scaled = 1.0F;
          abnrm = 0.0F;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
          }

          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                      cpu_rr->size[1], cpu_fv3->size[0], (float *)&cpu_d2scaled,
                      (float *)&b_gpu_a.data[0], 1, (float *)&gpu_rr.data[0],
                      cpu_fv3->size[0], (float *)&abnrm, (float *)&gpu_b.data[0],
                      1);
          b_dirtyOnCpu = false;
        }

        i = c_cpu_a->size[0] * c_cpu_a->size[1];
        c_cpu_a->size[0] = cpu_rr->size[1];
        c_cpu_a->size[1] = cpu_rr->size[0];
        emxEnsureCapacity_real32_T(c_cpu_a, i, &ic_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_cpu_a, &c_gpu_a);
        i = cpu_rr->size[0] - 1;
        b_inVectorLength = cpu_rr->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((b_inVectorLength + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          ec_detr_kernel59<<<grid, block>>>(gpu_rr, b_inVectorLength, i, c_gpu_a,
            c_cpu_a->size[0U], cpu_rr->size[0U]);
        }

        if ((c_cpu_a->size[0] == 0) || (c_cpu_a->size[1] == 0) || (cpu_rr->size
             [0] == 0) || (cpu_rr->size[1] == 0)) {
          i = c_cpu_A->size[0] * c_cpu_A->size[1];
          c_cpu_A->size[0] = c_cpu_a->size[0];
          c_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(c_cpu_A, i, &m_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(c_cpu_A, &b_gpu_A);
          b_inVectorLength = c_cpu_a->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detr_kernel60<<<grid, block>>>(b_inVectorLength, b_gpu_A);
          }
        } else {
          i = c_cpu_A->size[0] * c_cpu_A->size[1];
          c_cpu_A->size[0] = c_cpu_a->size[0];
          c_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real32_T(c_cpu_A, i, &r_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(c_cpu_A, &b_gpu_A);
          cpu_d2scaled = 1.0F;
          abnrm = 0.0F;
          if (rr_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_rr, cpu_rr);
          }

          rr_dirtyOnCpu = false;
          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      c_cpu_a->size[0], cpu_rr->size[1], c_cpu_a->size[1],
                      (float *)&cpu_d2scaled, (float *)&c_gpu_a.data[0],
                      c_cpu_a->size[0], (float *)&gpu_rr.data[0], c_cpu_a->size
                      [1], (float *)&abnrm, (float *)&b_gpu_A.data[0],
                      c_cpu_a->size[0]);
        }

        if ((cpu_b->size[1] == 0) || ((c_cpu_A->size[0] == 0) || (c_cpu_A->size
              [1] == 0))) {
          b_sz[1] = static_cast<uint32_T>(c_cpu_A->size[0]);
          i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = c_cpu_A->size[0];
          emxEnsureCapacity_real32_T(cpu_b, i, &lc_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b);
          }

          b_inVectorLength = static_cast<int32_T>(b_sz[1]) - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
            }

            ec_detr_kernel75<<<grid, block>>>(static_cast<int32_T>(b_sz[1]) - 1,
              gpu_b);
            b_dirtyOnCpu = false;
          }
        } else if (c_cpu_A->size[0] == c_cpu_A->size[1]) {
          n = c_cpu_A->size[1] - 2;
          i = cpu_ipiv_t->size[0];
          cpu_ipiv_t->size[0] = c_cpu_A->size[1];
          emxEnsureCapacity_int32_T(cpu_ipiv_t, i, &jc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_ipiv_t, &gpu_ipiv_t);
          cusolverDnSgetrf_bufferSize(getCuSolverGlobalHandle(), c_cpu_A->size[1],
            c_cpu_A->size[1], (float *)&b_gpu_A.data[0], c_cpu_A->size[1],
            getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(4);
          cusolverInitWorkspace();
          cusolverDnSgetrf(getCuSolverGlobalHandle(), c_cpu_A->size[1],
                           c_cpu_A->size[1], (float *)&b_gpu_A.data[0],
                           c_cpu_A->size[1], static_cast<real32_T *>
                           (getCuSolverWorkspaceBuff()), &gpu_ipiv_t.data[0],
                           gpu_info);
          i = cpu_ipiv->size[0] * cpu_ipiv->size[1];
          cpu_ipiv->size[0] = 1;
          cpu_ipiv->size[1] = cpu_ipiv_t->size[0];
          emxEnsureCapacity_int32_T(cpu_ipiv, i, &mc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_ipiv, &gpu_ipiv);
          cudaMemcpy(&cpu_info, gpu_info, 4UL, cudaMemcpyDeviceToHost);
          if (cpu_info < 0) {
            for (i = 0; i < 2; i++) {
              fv2[i] = c_cpu_A->size[i];
            }

            i = c_cpu_A->size[0] * c_cpu_A->size[1];
            c_cpu_A->size[0] = fv2[0];
            c_cpu_A->size[1] = fv2[1];
            emxEnsureCapacity_real32_T(c_cpu_A, i, &pc_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(c_cpu_A, &b_gpu_A);
            b_inVectorLength = fv2[0] * fv2[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detr_kernel73<<<grid, block>>>(b_inVectorLength, b_gpu_A);
            }

            nx = cpu_ipiv->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detr_kernel74<<<grid, block>>>(nx, gpu_ipiv);
              ipiv_dirtyOnGpu = true;
            }
          } else {
            nx = cpu_ipiv_t->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detr_kernel72<<<grid, block>>>(gpu_ipiv_t, nx, gpu_ipiv);
              ipiv_dirtyOnGpu = true;
            }
          }

          cpu_d2scaled = 1.0F;
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
          }

          cublasStrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N, CUBLAS_DIAG_NON_UNIT,
                      1, n + 2, (float *)&cpu_d2scaled, (float *)&b_gpu_A.data[0],
                      n + 2, (float *)&gpu_b.data[0], 1);
          cublasStrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                      n + 2, (float *)&cpu_d2scaled, (float *)&b_gpu_A.data[0],
                      n + 2, (float *)&gpu_b.data[0], 1);
          olPct_dirtyOnCpu = true;
          b_dirtyOnCpu = false;
          for (na = 0; na <= n; na++) {
            if (ipiv_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_ipiv, &gpu_ipiv);
            }

            ipiv_dirtyOnGpu = false;
            if (cpu_ipiv->data[n - na] != (n - na) + 1) {
              if (olPct_dirtyOnCpu) {
                gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, &gpu_b);
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
          i = d_cpu_A->size[0] * d_cpu_A->size[1];
          d_cpu_A->size[0] = c_cpu_A->size[1];
          d_cpu_A->size[1] = c_cpu_A->size[0];
          emxEnsureCapacity_real32_T(d_cpu_A, i, &kc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(d_cpu_A, &c_gpu_A);
          i = c_cpu_A->size[0] - 1;
          b_inVectorLength = c_cpu_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((b_inVectorLength + 1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detr_kernel61<<<grid, block>>>(b_gpu_A, b_inVectorLength, i,
              c_gpu_A, d_cpu_A->size[0U], c_cpu_A->size[0U]);
            b_A_dirtyOnGpu = true;
          }

          i = cpu_B->size[0];
          cpu_B->size[0] = cpu_b->size[1];
          emxEnsureCapacity_real32_T(cpu_B, i, &nc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_B, &gpu_B);
          b_inVectorLength = cpu_b->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
            }

            b_dirtyOnCpu = false;
            ec_detr_kernel62<<<grid, block>>>(gpu_b, b_inVectorLength, gpu_B);
          }

          m = d_cpu_A->size[0];
          na = d_cpu_A->size[1] - 1;
          i = cpu_jpvt->size[0] * cpu_jpvt->size[1];
          cpu_jpvt->size[0] = 1;
          cpu_jpvt->size[1] = d_cpu_A->size[1];
          emxEnsureCapacity_int32_T(cpu_jpvt, i, &qc_emlrtRTEI);
          if (!jpvt_dirtyOnCpu) {
            gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &gpu_jpvt);
          }

          i = d_cpu_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
            }

            ec_detr_kernel63<<<grid, block>>>(i, gpu_jpvt);
            jpvt_dirtyOnGpu = true;
            jpvt_dirtyOnCpu = false;
          }

          n = d_cpu_A->size[0];
          cpu_npages = d_cpu_A->size[1];
          if (n <= cpu_npages) {
            cpu_npages = n;
          }

          i = b_cpu_tau->size[0];
          b_cpu_tau->size[0] = cpu_npages;
          emxEnsureCapacity_real32_T(b_cpu_tau, i, &rc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(b_cpu_tau, &gpu_tau);
          i = jpvt_t->size[0];
          jpvt_t->size[0] = d_cpu_A->size[1];
          emxEnsureCapacity_ptrdiff_t(jpvt_t, i, &sc_emlrtRTEI);
          for (i = 0; i < d_cpu_A->size[1]; i++) {
            jpvt_t->data[i] = (ptrdiff_t)0;
          }

          if (b_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &c_gpu_A);
          }

          if (b_tau_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_tau, &gpu_tau);
          }

          f_info_t = LAPACKE_sgeqp3(102, (ptrdiff_t)d_cpu_A->size[0], (ptrdiff_t)
            d_cpu_A->size[1], &d_cpu_A->data[0], (ptrdiff_t)d_cpu_A->size[0],
            &jpvt_t->data[0], &b_cpu_tau->data[0]);
          olPct_dirtyOnCpu = true;
          b_tau_dirtyOnGpu = false;
          b_A_dirtyOnCpu = true;
          b_A_dirtyOnGpu = false;
          if ((int32_T)f_info_t != 0) {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m *
              (na + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_A, d_cpu_A);
              ec_detr_kernel64<<<grid, block>>>(m, na, c_gpu_A, d_cpu_A->size[0U]);
              b_A_dirtyOnGpu = true;
              b_A_dirtyOnCpu = false;
            }

            n = d_cpu_A->size[0];
            b_inVectorLength = d_cpu_A->size[1];
            if (n <= b_inVectorLength) {
              b_inVectorLength = n;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_inVectorLength), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_tau, b_cpu_tau);
              ec_detr_kernel65<<<grid, block>>>(b_inVectorLength, gpu_tau);
              b_tau_dirtyOnGpu = true;
              olPct_dirtyOnCpu = false;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (computeEndIdx(static_cast<int64_T>(b_inVectorLength + 1),
                             static_cast<int64_T>(cpu_npages), 1L) + 1L), &grid,
              &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
              if (olPct_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_real32_T(&gpu_tau, b_cpu_tau);
              }

              ec_detr_kernel66<<<grid, block>>>(b_inVectorLength + 1, gpu_npages,
                gpu_tau);
              b_tau_dirtyOnGpu = true;
              olPct_dirtyOnCpu = false;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (jpvt_dirtyOnCpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
              }

              ec_detr_kernel67<<<grid, block>>>(na, gpu_jpvt);
              jpvt_dirtyOnGpu = true;
              jpvt_dirtyOnCpu = false;
            }
          } else {
            for (m = 0; m <= na; m++) {
              if (jpvt_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &gpu_jpvt);
              }

              cpu_jpvt->data[m] = (int32_T)jpvt_t->data[m];
              jpvt_dirtyOnCpu = true;
              jpvt_dirtyOnGpu = false;
            }
          }

          m = -1;
          if (d_cpu_A->size[0] < d_cpu_A->size[1]) {
            b_inVectorLength = d_cpu_A->size[0];
            nx = d_cpu_A->size[1];
          } else {
            b_inVectorLength = d_cpu_A->size[1];
            nx = d_cpu_A->size[0];
          }

          if (b_A_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(d_cpu_A, &c_gpu_A);
          }

          b_A_dirtyOnGpu = false;
          cpu_d2scaled = std::fmin(0.000345266977F, 1.1920929E-6F *
            static_cast<real32_T>(nx)) * std::abs(d_cpu_A->data[0]);
          while ((m + 1 < b_inVectorLength) && (!(std::abs(d_cpu_A->data[(m +
                     d_cpu_A->size[0] * (m + 1)) + 1]) <= cpu_d2scaled))) {
            m++;
          }

          nx = d_cpu_A->size[1];
          i = cpu_Y->size[0];
          cpu_Y->size[0] = d_cpu_A->size[1];
          emxEnsureCapacity_real32_T(cpu_Y, i, &vc_emlrtRTEI);
          if (!Y_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_Y, &gpu_Y);
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_Y, cpu_Y);
            }

            ec_detr_kernel68<<<grid, block>>>(nx, gpu_Y);
            Y_dirtyOnGpu = true;
            Y_dirtyOnCpu = false;
          }

          cpu_npages = 0;
          n = d_cpu_A->size[0];
          nx = d_cpu_A->size[1];
          if (n <= nx) {
            nx = n;
          }

          if (b_A_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&c_gpu_A, d_cpu_A);
          }

          if (olPct_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_tau, b_cpu_tau);
          }

          cusolverDnSormqr_bufferSize(getCuSolverGlobalHandle(),
            CUBLAS_SIDE_LEFT, CUBLAS_OP_T, cpu_B->size[0], 1, nx, (float *)
            &c_gpu_A.data[0], d_cpu_A->size[0], (float *)&gpu_tau.data[0],
            (float *)&gpu_B.data[0], cpu_B->size[0], getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(4);
          cusolverInitWorkspace();
          cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
          cusolverDnSormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                           CUBLAS_OP_T, cpu_B->size[0], 1, nx, (float *)
                           &c_gpu_A.data[0], d_cpu_A->size[0], (float *)
                           &gpu_tau.data[0], (float *)&gpu_B.data[0],
                           cpu_B->size[0], static_cast<real32_T *>
                           (getCuSolverWorkspaceBuff()),
                           *getCuSolverWorkspaceReq(), gpu_npages);
          cudaMemcpy(&cpu_npages, gpu_npages, 4UL, cudaMemcpyDeviceToHost);
          if (cpu_npages < 0) {
            b_inVectorLength = cpu_B->size[0];
            i = cpu_B->size[0];
            cpu_B->size[0] = b_inVectorLength;
            emxEnsureCapacity_real32_T(cpu_B, i, &yc_emlrtRTEI);
            gpuEmxEnsureCapacity_real32_T(cpu_B, &gpu_B);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_inVectorLength), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detr_kernel69<<<grid, block>>>(b_inVectorLength, gpu_B);
            }
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(m + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
            }

            jpvt_dirtyOnCpu = false;
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_Y, cpu_Y);
            }

            ec_detr_kernel70<<<grid, block>>>(gpu_B, gpu_jpvt, m, gpu_Y);
            Y_dirtyOnGpu = true;
            Y_dirtyOnCpu = false;
          }

          for (na = 0; na <= m; na++) {
            if (Y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_Y, &gpu_Y);
            }

            if (jpvt_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &gpu_jpvt);
            }

            jpvt_dirtyOnGpu = false;
            cpu_Y->data[cpu_jpvt->data[m - na] - 1] /= d_cpu_A->data[(m - na) +
              d_cpu_A->size[0] * (m - na)];
            Y_dirtyOnCpu = true;
            Y_dirtyOnGpu = false;
            nx = m - na;
            for (i = 0; i < nx; i++) {
              cpu_Y->data[cpu_jpvt->data[i] - 1] -= cpu_Y->data[cpu_jpvt->data[m
                - na] - 1] * d_cpu_A->data[i + d_cpu_A->size[0] * (m - na)];
            }
          }

          i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_Y->size[0];
          emxEnsureCapacity_real32_T(cpu_b, i, &lc_emlrtRTEI);
          if (!b_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b);
          }

          b_inVectorLength = cpu_Y->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_Y, cpu_Y);
            }

            Y_dirtyOnCpu = false;
            if (b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
            }

            ec_detr_kernel71<<<grid, block>>>(gpu_Y, b_inVectorLength, gpu_b);
            b_dirtyOnCpu = false;
          }
        }

        // 'ec_detr:117' z = r*(V*b') + mn;
        i = b_cpu_b->size[0];
        b_cpu_b->size[0] = cpu_b->size[1];
        emxEnsureCapacity_real32_T(b_cpu_b, i, &oc_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_b, &b_gpu_b);
        b_inVectorLength = cpu_b->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
          }

          b_dirtyOnCpu = false;
          ec_detr_kernel76<<<grid, block>>>(gpu_b, b_inVectorLength, b_gpu_b);
        }

        if ((b_cpu_V->size[0] == 0) || (b_cpu_V->size[1] == 0) || (b_cpu_b->
             size[0] == 0)) {
          i = d_cpu_c->size[0];
          d_cpu_c->size[0] = b_cpu_V->size[0];
          emxEnsureCapacity_real32_T(d_cpu_c, i, &m_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(d_cpu_c, &d_gpu_c);
          b_inVectorLength = b_cpu_V->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detr_kernel77<<<grid, block>>>(b_inVectorLength, d_gpu_c);
          }
        } else {
          i = d_cpu_c->size[0];
          d_cpu_c->size[0] = b_cpu_V->size[0];
          emxEnsureCapacity_real32_T(d_cpu_c, i, &r_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(d_cpu_c, &d_gpu_c);
          cpu_d2scaled = 1.0F;
          abnrm = 0.0F;
          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      b_cpu_V->size[0], 1, b_cpu_V->size[1], (float *)
                      &cpu_d2scaled, (float *)&b_gpu_V.data[0], b_cpu_V->size[0],
                      (float *)&b_gpu_b.data[0], b_cpu_V->size[1], (float *)
                      &abnrm, (float *)&d_gpu_c.data[0], b_cpu_V->size[0]);
        }

        if ((cpu_fv4->size[0] == 0) || (cpu_fv4->size[1] == 0) || (d_cpu_c->
             size[0] == 0)) {
          i = cpu_fv5->size[0];
          cpu_fv5->size[0] = cpu_fv4->size[0];
          emxEnsureCapacity_real32_T(cpu_fv5, i, &m_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_fv5, &gpu_fv5);
          b_inVectorLength = cpu_fv4->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detr_kernel78<<<grid, block>>>(b_inVectorLength, gpu_fv5);
            fv5_dirtyOnGpu = true;
          }
        } else {
          i = cpu_fv5->size[0];
          cpu_fv5->size[0] = cpu_fv4->size[0];
          emxEnsureCapacity_real32_T(cpu_fv5, i, &r_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_fv5, &gpu_fv5);
          cpu_d2scaled = 1.0F;
          abnrm = 0.0F;
          if (fv4_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_fv4, cpu_fv4);
          }

          fv4_dirtyOnCpu = false;
          cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      cpu_fv4->size[0], 1, cpu_fv4->size[1], (float *)
                      &cpu_d2scaled, (float *)&gpu_fv4.data[0], cpu_fv4->size[0],
                      (float *)&d_gpu_c.data[0], cpu_fv4->size[1], (float *)
                      &abnrm, (float *)&gpu_fv5.data[0], cpu_fv4->size[0]);
          fv5_dirtyOnGpu = true;
        }

        if (cpu_fv5->size[0] == cpu_fv1->size[0]) {
          i = cpu_z->size[0];
          cpu_z->size[0] = cpu_fv5->size[0];
          emxEnsureCapacity_real32_T(cpu_z, i, &tc_emlrtRTEI);
          if (!z_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z);
          }

          b_inVectorLength = cpu_fv5->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_out, &cpu_out, 4UL, cudaMemcpyHostToDevice);
            out_dirtyOnCpu = false;
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
            }

            ec_detr_kernel79<<<grid, block>>>(gpu_out, gpu_fv1, gpu_fv5,
              b_inVectorLength, gpu_z);
            z_dirtyOnGpu = true;
            z_dirtyOnCpu = false;
          }
        } else {
          if (z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_z, &gpu_z);
          }

          if (fv5_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv5, &gpu_fv5);
          }

          fv5_dirtyOnGpu = false;
          if (fv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
          }

          fv1_dirtyOnGpu = false;
          binary_expand_op(cpu_z, cpu_fv5, cpu_fv1, cpu_out);
          z_dirtyOnCpu = true;
          z_dirtyOnGpu = false;
        }

        //  Find outliers
        // 'ec_detr:86' d = (x-z).*w;
        if (cpu_fv1->size[0] == 1) {
          b_inVectorLength = cpu_z->size[0];
        } else {
          b_inVectorLength = cpu_fv1->size[0];
        }

        if ((cpu_fv1->size[0] == cpu_z->size[0]) && (b_inVectorLength ==
             cpu_fv2->size[0])) {
          i = b_cpu_d->size[0];
          b_cpu_d->size[0] = cpu_fv1->size[0];
          emxEnsureCapacity_real32_T(b_cpu_d, i, &uc_emlrtRTEI);
          if (!b_d_dirtyOnCpu) {
            gpuEmxEnsureCapacity_real32_T(b_cpu_d, &gpu_d);
          }

          b_inVectorLength = cpu_fv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (z_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
            }

            z_dirtyOnCpu = false;
            if (b_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_d, b_cpu_d);
            }

            ec_detr_kernel80<<<grid, block>>>(gpu_fv2, gpu_z, gpu_fv1,
              b_inVectorLength, gpu_d);
            b_d_dirtyOnGpu = true;
            b_d_dirtyOnCpu = false;
          }
        } else {
          if (b_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_d, &gpu_d);
          }

          if (fv1_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv1, &gpu_fv1);
          }

          fv1_dirtyOnGpu = false;
          if (z_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_z, &gpu_z);
          }

          z_dirtyOnGpu = false;
          if (fv2_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_fv2, &gpu_fv2);
          }

          fv2_dirtyOnGpu = false;
          binary_expand_op(b_cpu_d, cpu_fv1, cpu_z, cpu_fv2);
          b_d_dirtyOnCpu = true;
          b_d_dirtyOnGpu = false;
        }

        // 'ec_detr:87' thrItr = iThr*std(d);
        n = b_cpu_d->size[0] - 1;
        if (b_cpu_d->size[0] == 0) {
          cpu_out = rtNaNF;
          cudaMemcpy(gpu_out, &cpu_out, 4UL, cudaMemcpyHostToDevice);
        } else if (b_cpu_d->size[0] == 1) {
          if (b_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_d, &gpu_d);
          }

          b_d_dirtyOnGpu = false;
          if ((!std::isinf(b_cpu_d->data[0])) && (!std::isnan(b_cpu_d->data[0])))
          {
            cpu_out = 0.0F;
          } else {
            cpu_out = rtNaNF;
          }

          cudaMemcpy(gpu_out, &cpu_out, 4UL, cudaMemcpyHostToDevice);
        } else {
          if (b_d_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_d, &gpu_d);
          }

          b_d_dirtyOnGpu = false;
          cpu_d2scaled = b_cpu_d->data[0];
          for (i = 0; i < n; i++) {
            cpu_d2scaled += b_cpu_d->data[i + 1];
          }

          cpu_d2scaled /= static_cast<real32_T>(b_cpu_d->size[0]);
          i = cpu_absdiff->size[0];
          cpu_absdiff->size[0] = b_cpu_d->size[0];
          emxEnsureCapacity_real32_T(cpu_absdiff, i, &wc_emlrtRTEI);
          gpuEmxEnsureCapacity_real32_T(cpu_absdiff, &gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(n + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 4UL, cudaMemcpyHostToDevice);
            if (b_d_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real32_T(&gpu_d, b_cpu_d);
            }

            b_d_dirtyOnCpu = false;
            ec_detr_kernel81<<<grid, block>>>(gpu_d2scaled, gpu_d, n,
              gpu_absdiff);
          }

          cublasSnrm2(getCublasGlobalHandle(), b_cpu_d->size[0], (float *)
                      &gpu_absdiff.data[0], 1, (float *)&cpu_d2scaled);
          if (b_d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_d, b_cpu_d);
          }

          b_d_dirtyOnCpu = false;
          cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 4UL, cudaMemcpyHostToDevice);
          d2scaled_dirtyOnCpu = false;
          if (out_dirtyOnCpu) {
            cudaMemcpy(gpu_out, &cpu_out, 4UL, cudaMemcpyHostToDevice);
          }

          ec_detr_kernel82<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_d2scaled,
            gpu_out, b_cpu_d->size[0U]);
        }

        if (d2scaled_dirtyOnCpu) {
          cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 4UL, cudaMemcpyHostToDevice);
        }

        ec_detr_kernel83<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_out,
          *b_gpu_out_data, ii, gpu_d2scaled);

        // 'ec_detr:88' w(abs(d)>thrItr) = 0;
        nx = b_cpu_d->size[0];
        i = b_cpu_y->size[0];
        b_cpu_y->size[0] = b_cpu_d->size[0];
        emxEnsureCapacity_real32_T(b_cpu_y, i, &xc_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_y, &b_gpu_y);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nx),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_d_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_d, b_cpu_d);
          }

          b_d_dirtyOnCpu = false;
          ec_detr_kernel84<<<grid, block>>>(gpu_d, nx, b_gpu_y);
        }

        b_inVectorLength = b_cpu_y->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detr_kernel85<<<grid, block>>>(gpu_d2scaled, b_gpu_y,
            b_inVectorLength, gpu_fv2);
          fv2_dirtyOnGpu = true;
        }

        //  update weights
      }

      //  Remove trends
      // 'ec_detr:92' x = x-z;
      i = cpu_x->size[0];
      if (i == cpu_z->size[0]) {
        nx = c_cpu_x->size[0];
        c_cpu_x->size[0] = i;
        emxEnsureCapacity_real32_T(c_cpu_x, nx, &k_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(c_cpu_x, &b_gpu_x);
        b_inVectorLength = cpu_x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (z_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
          }

          z_dirtyOnCpu = false;
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
          }

          x_dirtyOnCpu = false;
          ec_detr_kernel86<<<grid, block>>>(gpu_z, ch, gpu_x, b_inVectorLength,
            b_gpu_x, cpu_x->size[0U]);
        }

        b_inVectorLength = c_cpu_x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
          }

          ec_detr_kernel87<<<grid, block>>>(b_gpu_x, ch, b_inVectorLength, gpu_x,
            cpu_x->size[0U]);
          x_dirtyOnGpu = true;
          x_dirtyOnCpu = false;
        }
      } else {
        if (x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_x, &gpu_x);
        }

        if (z_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_z, &gpu_z);
        }

        z_dirtyOnGpu = false;
        binary_expand_op(cpu_x, ch, cpu_z);
        x_dirtyOnCpu = true;
        x_dirtyOnGpu = false;
      }

      b_inVectorLength = cpu_fv2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (w_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_w, cpu_w);
        }

        ec_detr_kernel88<<<grid, block>>>(gpu_fv2, ch, b_inVectorLength, gpu_w,
          cpu_w->size[0U]);
        w_dirtyOnGpu = true;
        w_dirtyOnCpu = false;
      }

      //  Detrend
      // 'ec_detr:42' olPct(ch,ii) = sum(~w(:,ch));
      i = b_cpu_x->size[0];
      b_cpu_x->size[0] = cpu_w->size[0];
      emxEnsureCapacity_boolean_T(b_cpu_x, i, &l_emlrtRTEI);
      gpuEmxEnsureCapacity_boolean_T(b_cpu_x, &c_gpu_x);
      b_inVectorLength = cpu_w->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
        (b_inVectorLength + 1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (w_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_w, cpu_w);
        }

        w_dirtyOnCpu = false;
        ec_detr_kernel89<<<grid, block>>>(ch, gpu_w, b_inVectorLength, c_gpu_x,
          cpu_w->size[0U]);
        b_x_dirtyOnGpu = true;
      }

      b_inVectorLength = b_cpu_x->size[0];
      if (b_cpu_x->size[0] == 0) {
        nx = 0;
      } else {
        if (b_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_boolean_T(b_cpu_x, &c_gpu_x);
        }

        b_x_dirtyOnGpu = false;
        nx = b_cpu_x->data[0];
        for (i = 0; i <= b_inVectorLength - 2; i++) {
          nx += b_cpu_x->data[i + 1];
        }
      }

      cpu_olPct->data[ch + cpu_olPct->size[0] * ii] = static_cast<real32_T>(nx);
      olPct_dirtyOnCpu = true;

      //  Outlier percentages
    }
  }

  emxFree_real32_T(&c_cpu_V);
  emxFree_real32_T(&c_cpu_x);
  emxFree_real32_T(&b_cpu_y);
  emxFree_real32_T(&cpu_absdiff);
  emxFree_real32_T(&b_cpu_d);
  emxFree_real32_T(&cpu_fv5);
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_real32_T(&b_cpu_tau);
  emxFree_int32_T(&cpu_ipiv_t);
  emxFree_int32_T(&cpu_jpvt);
  emxFree_real32_T(&b_cpu_b);
  emxFree_real32_T(&d_cpu_c);
  emxFree_int32_T(&cpu_ipiv);
  emxFree_real32_T(&cpu_B);
  emxFree_real32_T(&d_cpu_A);
  emxFree_real32_T(&cpu_Y);
  emxFree_real32_T(&wi);
  emxFree_real32_T(&wr);
  emxFree_real32_T(&cpu_vright);
  emxFree_real32_T(&c_cpu_a);
  emxFree_real32_T(&c_cpu_A);
  emxFree_real32_T(&cpu_wimag);
  emxFree_real32_T(&cpu_tau);
  emxFree_real32_T(&cpu_wreal);
  emxFree_creal32_T(&b_cpu_W);
  emxFree_real32_T(&b_cpu_a);
  emxFree_real32_T(&cpu_U);
  emxFree_real32_T(&cpu_b);
  emxFree_real32_T(&scale);
  emxFree_real32_T(&b_cpu_A);
  emxFree_real32_T(&cpu_W);
  emxFree_int32_T(&cpu_iv);
  emxFree_creal32_T(&cpu_d);
  emxFree_real32_T(&b_cpu_V);
  emxFree_creal32_T(&cpu_D);
  emxFree_creal32_T(&cpu_V);
  emxFree_real32_T(&cpu_a);
  emxFree_real32_T(&cpu_A);
  emxFree_real32_T(&cpu_rr);
  emxFree_real32_T(&cpu_fv4);
  emxFree_real32_T(&cpu_y);
  emxFree_real32_T(&c_cpu_c);
  emxFree_real32_T(&cpu_fv3);
  emxFree_real32_T(&b_cpu_c);
  emxFree_real32_T(&cpu_c);
  emxFree_boolean_T(&b_cpu_x);
  emxFree_real32_T(&cpu_z);
  emxFree_real32_T(&cpu_fv2);
  emxFree_real32_T(&cpu_fv1);
  emxFree_real32_T(&cpu_fv);
  emxFree_real32_T(&cpu_lin);
  emxFree_real32_T(&cpu_regs);

  //  Sum outliers across chans
  // 'ec_detr:47' olPct = sum(olPct,1,"omitnan");
  b_inVectorLength = cpu_olPct->size[0];
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
    cpu_npages = cpu_olPct->size[1];
    olPct_size[0] = 1;
    olPct_size[1] = cpu_olPct->size[1];
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(cpu_npages),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (olPct_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_olPct, cpu_olPct);
      }

      cudaMemcpy(gpu_npages, &cpu_npages, 4UL, cudaMemcpyHostToDevice);
      ec_detr_kernel90<<<grid, block>>>(b_inVectorLength, gpu_olPct, gpu_npages,
        gpu_olPct_data, cpu_olPct->size[0U]);
      olPct_data_dirtyOnGpu = true;
    }
  }

  emxFree_real32_T(&cpu_olPct);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_x, &gpu_x);
  }

  if (w_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(cpu_w, &gpu_w);
  }

  if (olPct_data_dirtyOnGpu) {
    cudaMemcpy(cpu_olPct_data, gpu_olPct_data, static_cast<uint32_T>(olPct_size
                [1]) * sizeof(real32_T), cudaMemcpyDeviceToHost);
  }

  gpuEmxFree_real32_T(&gpu_x);
  gpuEmxFree_real32_T(&gpu_w);
  mwCudaFree(gpu_ord_data);
  mwCudaFree(gpu_thr_data);
  mwCudaFree(gpu_itr_data);
  mwCudaFree(gpu_olPct_data);
  mwCudaFree(gpu_fc2);
  mwCudaFree(gpu_fc);
  mwCudaFree(*gpu_out_data);
  mwCudaFree(*b_gpu_out_data);
  mwCudaFree(*c_gpu_out_data);
  gpuEmxFree_real32_T(&gpu_olPct);
  gpuEmxFree_real32_T(&gpu_regs);
  gpuEmxFree_real32_T(&gpu_lin);
  gpuEmxFree_real32_T(&gpu_fv);
  gpuEmxFree_real32_T(&gpu_fv1);
  gpuEmxFree_real32_T(&gpu_fv2);
  gpuEmxFree_real32_T(&gpu_z);
  gpuEmxFree_boolean_T(&c_gpu_x);
  gpuEmxFree_real32_T(&gpu_c);
  gpuEmxFree_real32_T(&b_gpu_c);
  gpuEmxFree_real32_T(&gpu_fv3);
  gpuEmxFree_real32_T(&c_gpu_c);
  gpuEmxFree_real32_T(&gpu_y);
  gpuEmxFree_real32_T(&gpu_fv4);
  gpuEmxFree_real32_T(&gpu_rr);
  gpuEmxFree_real32_T(&gpu_A);
  gpuEmxFree_real32_T(&gpu_a);
  gpuEmxFree_creal32_T(&gpu_V);
  gpuEmxFree_creal32_T(&gpu_D);
  gpuEmxFree_real32_T(&b_gpu_V);
  gpuEmxFree_creal32_T(&b_gpu_d);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_real32_T(&gpu_W);
  gpuEmxFree_real32_T(&d_gpu_A);
  gpuEmxFree_real32_T(&gpu_b);
  gpuEmxFree_real32_T(&gpu_U);
  gpuEmxFree_real32_T(&b_gpu_a);
  gpuEmxFree_creal32_T(&b_gpu_W);
  gpuEmxFree_real32_T(&gpu_wreal);
  gpuEmxFree_real32_T(&b_gpu_tau);
  gpuEmxFree_real32_T(&gpu_wimag);
  gpuEmxFree_real32_T(&b_gpu_A);
  gpuEmxFree_real32_T(&c_gpu_a);
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
  gpuEmxFree_real32_T(&gpu_fv5);
  gpuEmxFree_real32_T(&gpu_d);
  gpuEmxFree_real32_T(&gpu_absdiff);
  gpuEmxFree_real32_T(&b_gpu_y);
  gpuEmxFree_real32_T(&b_gpu_x);
  gpuEmxFree_real32_T(&c_gpu_V);
  mwCudaFree(gpu_npages);
  mwCudaFree(gpu_d2scaled);
  mwCudaFree(gpu_i5);
  mwCudaFree(gpu_out);
  mwCudaFree(gpu_info);
}

void ec_detr_api(const mxArray * const prhs[5], int32_T nlhs, const mxArray
                 *plhs[3])
{
  emxArray_real32_T *w;
  emxArray_real32_T *x;
  int32_T itr_size[2];
  int32_T olPct_size[2];
  int32_T ord_size[2];
  int32_T thr_size[2];
  real32_T itr_data[99];
  real32_T olPct_data[99];
  real32_T ord_data[99];
  real32_T thr_data[99];
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  // Marshall function inputs
  emxInit_real32_T(&x, 2, &emlrtRTEI, true);
  emlrt_marshallIn(emlrtAliasP(prhs[0]), "x", x);
  emxInit_real32_T(&w, 2, &emlrtRTEI, true);
  emlrt_marshallIn(emlrtAliasP(prhs[1]), "w", w);
  emlrt_marshallIn(emlrtAliasP(prhs[2]), "ord", ord_data, ord_size);
  emlrt_marshallIn(emlrtAliasP(prhs[3]), "thr", thr_data, thr_size);
  emlrt_marshallIn(emlrtAliasP(prhs[4]), "itr", itr_data, itr_size);

  // Invoke the target function
  ec_detr(x, w, ord_data, ord_size, thr_data, thr_size, itr_data, itr_size,
          olPct_data, olPct_size);

  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(x);
  emxFree_real32_T(&x);
  if (nlhs > 1) {
    plhs[1] = emlrt_marshallOut(w);
  }

  emxFree_real32_T(&w);
  if (nlhs > 2) {
    plhs[2] = emlrt_marshallOut(olPct_data, olPct_size);
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
