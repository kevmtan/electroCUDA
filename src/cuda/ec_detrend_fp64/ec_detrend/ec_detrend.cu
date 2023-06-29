//
// Prerelease License - for engineering feedback and testing purposes
// only. Not for sale.
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
  131643U,                             // fVersionInfo
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

static emlrtRTEInfo b_emlrtRTEI{ 46,   // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 46,   // lineNo
  15,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
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

static emlrtRTEInfo g_emlrtRTEI{ 55,   // lineNo
  6,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 103,  // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 49,   // lineNo
  20,                                  // colNo
  "linspace",                          // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/elmat/linspace.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 104,  // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
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

static emlrtRTEInfo m_emlrtRTEI{ 187,  // lineNo
  10,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 171,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 181,  // lineNo
  24,                                  // colNo
  "combineVectorElements",             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/datafun/private/combineVectorElements.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 20,   // lineNo
  1,                                   // colNo
  "sum",                               // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/datafun/sum.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 172,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 173,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 44,   // lineNo
  36,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 158,  // lineNo
  24,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 94,   // lineNo
  5,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 56,   // lineNo
  24,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 60,   // lineNo
  28,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 175,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 85,  // lineNo
  9,                                   // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 176, // lineNo
  10,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 47,  // lineNo
  20,                                  // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 109, // lineNo
  24,                                  // colNo
  "diag",                              // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/elmat/diag.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 99,  // lineNo
  24,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 89,  // lineNo
  13,                                  // colNo
  "eig",                               // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/eig.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 176, // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 102, // lineNo
  21,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 28,  // lineNo
  9,                                   // colNo
  "eigHermitianStandard",              // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/private/eigHermitianStandard.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 62,  // lineNo
  9,                                   // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 76,  // lineNo
  22,                                  // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 106, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 131, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 42,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 132, // lineNo
  29,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 69,  // lineNo
  13,                                  // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 63,  // lineNo
  9,                                   // colNo
  "xsyheev",                           // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xsyheev.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 33,  // lineNo
  5,                                   // colNo
  "eigHermitianStandard",              // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/private/eigHermitianStandard.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 134, // lineNo
  35,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 1,   // lineNo
  18,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 86,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 177, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 46,  // lineNo
  9,                                   // colNo
  "schur",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/schur.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 111, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 87,  // lineNo
  9,                                   // colNo
  "xgehrd",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgehrd.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 160, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 188, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 112, // lineNo
  29,                                  // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 177, // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 168, // lineNo
  16,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 23,  // lineNo
  9,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 161, // lineNo
  13,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 129, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 27,  // lineNo
  13,                                  // colNo
  "eigStandard",                       // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/private/eigStandard.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 24,  // lineNo
  9,                                   // colNo
  "eigRealSkewSymmetricStandard",      // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/matfun/private/eigRealSkewSymmetricStandard.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 142, // lineNo
  41,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 130, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 178, // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 18,  // lineNo
  29,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 44,  // lineNo
  32,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 179, // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 50,  // lineNo
  31,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 44,  // lineNo
  35,                                  // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 44,  // lineNo
  48,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 53,  // lineNo
  13,                                  // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 61,  // lineNo
  9,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 92,  // lineNo
  22,                                  // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 105, // lineNo
  1,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 180, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 85,  // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 88,  // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 85,  // lineNo
  1,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 126, // lineNo
  34,                                  // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 30,  // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo ed_emlrtRTEI{ 119, // lineNo
  5,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo fd_emlrtRTEI{ 122, // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo gd_emlrtRTEI{ 126, // lineNo
  18,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo hd_emlrtRTEI{ 28,  // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo id_emlrtRTEI{ 128, // lineNo
  30,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo jd_emlrtRTEI{ 113, // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo kd_emlrtRTEI{ 126, // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ld_emlrtRTEI{ 128, // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo md_emlrtRTEI{ 130, // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo nd_emlrtRTEI{ 320, // lineNo
  20,                                  // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo od_emlrtRTEI{ 134, // lineNo
  27,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo pd_emlrtRTEI{ 135, // lineNo
  31,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo qd_emlrtRTEI{ 136, // lineNo
  27,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo rd_emlrtRTEI{ 151, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo sd_emlrtRTEI{ 75,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo td_emlrtRTEI{ 76,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ud_emlrtRTEI{ 82,  // lineNo
  1,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo vd_emlrtRTEI{ 112, // lineNo
  23,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo wd_emlrtRTEI{ 171, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo xd_emlrtRTEI{ 187, // lineNo
  6,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo yd_emlrtRTEI{ 78,  // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ae_emlrtRTEI{ 85,  // lineNo
  22,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo be_emlrtRTEI{ 174, // lineNo
  2,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ce_emlrtRTEI{ 174, // lineNo
  4,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo de_emlrtRTEI{ 177, // lineNo
  9,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ee_emlrtRTEI{ 99,  // lineNo
  1,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo fe_emlrtRTEI{ 160, // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ge_emlrtRTEI{ 131, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo he_emlrtRTEI{ 132, // lineNo
  5,                                   // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo ie_emlrtRTEI{ 134, // lineNo
  10,                                  // colNo
  "xgeev",                             // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xgeev.m"// pName
};

static emlrtRTEInfo je_emlrtRTEI{ 44,  // lineNo
  9,                                   // colNo
  "mrdivide_helper",                   // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/mrdivide_helper.m"// pName
};

static emlrtRTEInfo ke_emlrtRTEI{ 111, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo le_emlrtRTEI{ 112, // lineNo
  9,                                   // colNo
  "xhseqr",                            // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/eml/+coder/+internal/+lapack/xhseqr.m"// pName
};

static emlrtRTEInfo me_emlrtRTEI{ 18,  // lineNo
  5,                                   // colNo
  "xgetrf_gpu",                        // fName
  "/usr/local/MATLAB/R2023b/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrf_gpu.m"// pName
};

static emlrtRTEInfo ne_emlrtRTEI{ 180, // lineNo
  8,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo oe_emlrtRTEI{ 126, // lineNo
  9,                                   // colNo
  "vvarstd",                           // fName
  "/usr/local/MATLAB/R2023b/toolbox/eml/lib/matlab/datafun/private/vvarstd.m"// pName
};

static emlrtRTEInfo pe_emlrtRTEI{ 90,  // lineNo
  7,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo qe_emlrtRTEI{ 126, // lineNo
  55,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo re_emlrtRTEI{ 130, // lineNo
  18,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo se_emlrtRTEI{ 128, // lineNo
  18,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo te_emlrtRTEI{ 130, // lineNo
  30,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ue_emlrtRTEI{ 153, // lineNo
  7,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo ve_emlrtRTEI{ 147, // lineNo
  13,                                  // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

static emlrtRTEInfo we_emlrtRTEI{ 147, // lineNo
  5,                                   // colNo
  "ec_detrend",                        // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_detrend.m"// pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static real_T b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, const emxArray_real_T *in4);
static void binary_expand_op_1(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, real_T in4);
static void binary_expand_op_10(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6);
static void binary_expand_op_11(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6, int32_T in7, int32_T in8, const
  emxArray_real_T *in9, const emxArray_real_T *in10);
static void binary_expand_op_12(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6, const emxArray_real_T *in7);
static void binary_expand_op_13(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5);
static void binary_expand_op_14(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5, const emxArray_real_T
  *in6, int32_T in7, int32_T in8);
static void binary_expand_op_15(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, int32_T in4, int32_T in5, real_T in6);
static void binary_expand_op_16(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, int32_T in4, int32_T in5);
static void binary_expand_op_17(emxArray_real_T *in1, const emxArray_real_T *in2,
  real_T in3);
static void binary_expand_op_19(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, real_T in5, const emxArray_real_T *in6, int32_T in7,
  int32_T in8);
static void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_20(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, const emxArray_real_T *in5, int32_T in6, int32_T in7);
static void binary_expand_op_3(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3, real_T in4);
static void binary_expand_op_5(emxArray_real_T *in1, const emxArray_real_T *in2,
  real_T in3, const emxArray_real_T *in4);
static void binary_expand_op_6(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, const emxArray_real_T *in4);
static void binary_expand_op_8(emxArray_real_T *in1, const emxArray_real_T *in2);
static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static
#ifdef __CUDACC__

__device__
#endif

int64_T computeEndIdx_device(int64_T start, int64_T end, int64_T stride);
static __global__ void ec_detrend_kernel1(const int32_T ch, const
  emxArray_real_T x, const int32_T vlen, emxArray_real_T b_x, int32_T x_dim0);
static __global__ void ec_detrend_kernel10(const emxArray_real_T w, const
  emxArray_real_T x, const int32_T b_x, emxArray_real_T c_x);
static __global__ void ec_detrend_kernel100(const emxArray_real_T vright, const
  int32_T b_vright, emxArray_creal_T V);
static __global__ void ec_detrend_kernel101(const int32_T istart, const int32_T
  nx, emxArray_creal_T V, int32_T V_dim0);
static __global__ void ec_detrend_kernel102(const creal_T dc, const int32_T A,
  emxArray_creal_T W);
static __global__ void ec_detrend_kernel103(const creal_T dc, const int32_T i12,
  emxArray_creal_T V);
static __global__ void ec_detrend_kernel104(const int32_T A, emxArray_creal_T D);
static __global__ void ec_detrend_kernel105(const int32_T i12, emxArray_real_T A);
static __global__ void ec_detrend_kernel106(const int32_T vlen, emxArray_real_T
  tau);
static __global__ void ec_detrend_kernel107(const emxArray_real_T A, const
  int32_T b_A, emxArray_real_T U);
static __global__ void ec_detrend_kernel108(const int32_T i12, emxArray_real_T U);
static __global__ void ec_detrend_kernel109(emxArray_real_T U);
static __global__ void ec_detrend_kernel11(const emxArray_real_T w, const real_T
  d2scaled, const emxArray_real_T x, const int32_T b_x, emxArray_real_T dv1);
static __global__ void ec_detrend_kernel110(const int32_T i12, emxArray_real_T A);
static __global__ void ec_detrend_kernel111(const int32_T i12, emxArray_real_T U);
static __global__ void ec_detrend_kernel112(const int32_T sz, emxArray_real_T U);
static __global__ void ec_detrend_kernel113(const int32_T npages, const int32_T
  vlen, const int32_T istart, emxArray_real_T U, int32_T U_dim0);
static __global__ void ec_detrend_kernel114(const int32_T sz, emxArray_real_T A);
static __global__ void ec_detrend_kernel115(const int32_T A, emxArray_creal_T D);
static __global__ void ec_detrend_kernel116(const emxArray_real_T U, const
  int32_T b_U, emxArray_creal_T V);
static __global__ void ec_detrend_kernel117(const int32_T vlen, emxArray_real_T
  W);
static __global__ void ec_detrend_kernel118(const int32_T i12, emxArray_real_T A);
static __global__ void ec_detrend_kernel119(const int32_T npages,
  emxArray_creal_T D);
static __global__ void ec_detrend_kernel12(const emxArray_real_T w, const
  emxArray_real_T r, const int32_T b_r, const int32_T c_r, emxArray_real_T x,
  int32_T x_dim0, int32_T r_dim0);
static __global__ void ec_detrend_kernel120(const emxArray_real_T A, const
  int32_T b_A, emxArray_creal_T V);
static __global__ void ec_detrend_kernel121(const creal_T dc, const int32_T i12,
  emxArray_creal_T V);
static __global__ void ec_detrend_kernel122(const int32_T i12, emxArray_creal_T
  D);
static __global__ void ec_detrend_kernel123(const emxArray_creal_T V, const
  int32_T b_V, emxArray_real_T c_V);
static __global__ void ec_detrend_kernel124(const emxArray_creal_T D, const
  int32_T b_D, emxArray_real_T v);
static __global__ void ec_detrend_kernel125(const emxArray_real_T v, const
  int32_T istart, emxArray_real_T D, int32_T v_dim0);
static __global__ void ec_detrend_kernel126(const emxArray_real_T v,
  emxArray_real_T D);
static __global__ void ec_detrend_kernel127(const emxArray_int32_T iv1, const
  emxArray_real_T V, const int32_T npages, const int32_T b_iv1, emxArray_real_T
  b_V, int32_T V_dim0, int32_T b_V_dim0);
static __global__ void ec_detrend_kernel128(const emxArray_real_T V, const
  int32_T b_V, emxArray_real_T c_V);
static __global__ void ec_detrend_kernel129(const emxArray_real_T rr, const
  int32_T b_rr, emxArray_real_T A);
static __global__ void ec_detrend_kernel13(const int32_T vlen, const
  emxArray_real_T x, const int32_T npages, emxArray_real_T y, int32_T x_dim0);
static __global__ void ec_detrend_kernel130(const int32_T i12, emxArray_real_T
  rr);
static __global__ void ec_detrend_kernel131(const emxArray_real_T dv3, const
  int32_T b_dv3, emxArray_real_T A);
static __global__ void ec_detrend_kernel132(const int32_T rr, emxArray_real_T b);
static __global__ void ec_detrend_kernel133(const emxArray_real_T rr, const
  int32_T b_rr, const int32_T c_rr, emxArray_real_T A, int32_T A_dim0, int32_T
  rr_dim0);
static __global__ void ec_detrend_kernel134(const int32_T A, emxArray_real_T b_A);
static __global__ void ec_detrend_kernel135(const emxArray_real_T A, const
  int32_T b_A, const int32_T c_A, emxArray_real_T d_A, int32_T A_dim0, int32_T
  b_A_dim0);
static __global__ void ec_detrend_kernel136(const emxArray_real_T b, const
  int32_T b_b, emxArray_real_T B);
static __global__ void ec_detrend_kernel137(const int32_T A, emxArray_int32_T
  jpvt);
static __global__ void ec_detrend_kernel138(const int32_T vlen, const int32_T
  npages, emxArray_real_T A, int32_T A_dim0);
static __global__ void ec_detrend_kernel139(const int32_T vlen, emxArray_real_T
  tau);
static __global__ void ec_detrend_kernel14(const int32_T sz, emxArray_real_T y);
static __global__ void ec_detrend_kernel140(const int32_T jend, const int32_T i,
  emxArray_real_T tau);
static __global__ void ec_detrend_kernel141(const int32_T npages,
  emxArray_int32_T jpvt);
static __global__ void ec_detrend_kernel142(const int32_T A, emxArray_real_T Y);
static __global__ void ec_detrend_kernel143(const int32_T vlen, emxArray_real_T
  B);
static __global__ void ec_detrend_kernel144(const emxArray_real_T B, const
  emxArray_int32_T jpvt, const int32_T jend, emxArray_real_T Y);
static __global__ void ec_detrend_kernel145(const emxArray_real_T Y, const
  int32_T b_Y, emxArray_real_T b);
static __global__ void ec_detrend_kernel146(const emxArray_int32_T ipiv_t, const
  int32_T istart, emxArray_int32_T ipiv);
static __global__ void ec_detrend_kernel147(const int32_T i12, emxArray_real_T A);
static __global__ void ec_detrend_kernel148(const int32_T istart,
  emxArray_int32_T ipiv);
static __global__ void ec_detrend_kernel149(const int32_T sz, emxArray_real_T b);
static __global__ void ec_detrend_kernel15(const real_T d2scaled, const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, const int32_T
  c_r, emxArray_real_T d_r, int32_T r_dim0, int32_T b_r_dim0);
static __global__ void ec_detrend_kernel150(const emxArray_real_T b, const
  int32_T b_b, emxArray_real_T B);
static __global__ void ec_detrend_kernel151(const int32_T V, emxArray_real_T y);
static __global__ void ec_detrend_kernel152(const int32_T r, emxArray_real_T
  dv11);
static __global__ void ec_detrend_kernel153(const real_T mn, const
  emxArray_real_T x, const int32_T i7, const emxArray_real_T dv11, const int32_T
  b_dv11, emxArray_real_T z);
static __global__ void ec_detrend_kernel154(const emxArray_real_T w, const
  int32_T i11, const emxArray_real_T z, const emxArray_real_T x, const int32_T
  i7, const int32_T ii, emxArray_real_T d);
static __global__ void ec_detrend_kernel155(const real_T d2scaled, const
  emxArray_real_T d, const int32_T npages, emxArray_real_T absdiff);
static __global__ void ec_detrend_kernel156(const emxArray_real_T z, const
  emxArray_real_T x, const int32_T i7, const int32_T ii, emxArray_real_T yy);
static __global__ void ec_detrend_kernel157(const real_T d2scaled,
  emxArray_real_T y);
static __global__ void ec_detrend_kernel158(const real_T rconde, const real_T
  abnrm, emxArray_real_T y);
static __global__ void ec_detrend_kernel159(const real_T rconde, const int32_T
  npages, const real_T d2scaled, const int32_T istart, emxArray_real_T y);
static __global__ void ec_detrend_kernel16(const emxArray_real_T w, const
  emxArray_real_T r, const int32_T b_r, const int32_T c_r, emxArray_real_T rr,
  int32_T rr_dim0, int32_T r_dim0);
static __global__ void ec_detrend_kernel160(const real_T d2scaled, const int32_T
  istart, emxArray_real_T y);
static __global__ void ec_detrend_kernel161(const real_T rconde, const int32_T
  istart, emxArray_real_T y);
static __global__ void ec_detrend_kernel162(const real_T rconde, const real_T
  d2scaled, const int32_T istart, emxArray_real_T y);
static __global__ void ec_detrend_kernel163(const real_T d2scaled,
  emxArray_real_T y);
static __global__ void ec_detrend_kernel164(const emxArray_real_T y, const
  int32_T istart, emxArray_real_T b);
static __global__ void ec_detrend_kernel165(const real_T d2scaled,
  emxArray_real_T y);
static __global__ void ec_detrend_kernel166(const real_T wsize2, emxArray_int8_T
  a);
static __global__ void ec_detrend_kernel167(const emxArray_real_T y, const
  int32_T istart, emxArray_real_T b);
static __global__ void ec_detrend_kernel168(const real_T wsize2, emxArray_int8_T
  a);
static __global__ void ec_detrend_kernel169(const real_T rconde, const real_T
  abnrm, emxArray_real_T y);
static __global__ void ec_detrend_kernel17(const emxArray_real_T rr, const
  int32_T b_rr, const int32_T c_rr, emxArray_real_T A, int32_T A_dim0, int32_T
  rr_dim0);
static __global__ void ec_detrend_kernel170(const real_T rconde, const int32_T
  npages, const real_T d2scaled, const int32_T istart, emxArray_real_T y);
static __global__ void ec_detrend_kernel171(const real_T d2scaled, const int32_T
  istart, emxArray_real_T y);
static __global__ void ec_detrend_kernel172(const real_T rconde, const int32_T
  istart, emxArray_real_T y);
static __global__ void ec_detrend_kernel173(const real_T rconde, const real_T
  d2scaled, const int32_T istart, emxArray_real_T y);
static __global__ void ec_detrend_kernel174(const real_T d2scaled,
  emxArray_real_T y);
static __global__ void ec_detrend_kernel175(const real_T wsize2, const int32_T
  istart, emxArray_real_T b);
static __global__ void ec_detrend_kernel176(const emxArray_real_T b, const
  emxArray_real_T yy, const emxArray_real_T x, const int32_T istart, const
  int32_T jend, emxArray_real_T b_x);
static __global__ void ec_detrend_kernel177(const emxArray_real_T x, const
  int32_T npages, const int32_T b_x, emxArray_real_T c_x);
static __global__ void ec_detrend_kernel178(const emxArray_real_T b, const
  emxArray_real_T yy, const emxArray_real_T x, const int32_T vlen, const
  emxArray_real_T trend, const int32_T jend, const int32_T npages,
  emxArray_real_T b_trend);
static __global__ void ec_detrend_kernel179(const emxArray_real_T trend, const
  int32_T nx, const int32_T b_trend, emxArray_real_T c_trend);
static __global__ void ec_detrend_kernel18(const int32_T A, emxArray_real_T b_A);
static __global__ void ec_detrend_kernel180(const emxArray_real_T b, const
  emxArray_real_T a, const int32_T istart, const int32_T jend, emxArray_real_T
  b_a);
static __global__ void ec_detrend_kernel181(const emxArray_real_T a, const
  int32_T npages, const int32_T b_a, emxArray_real_T c_a);
static __global__ void ec_detrend_kernel182(emxArray_real_T a, emxArray_real_T x,
  int32_T x_dim0, int32_T a_dim0);
static __global__ void ec_detrend_kernel183(const emxArray_real_T a, const
  int32_T x, emxArray_real_T b_x);
static __global__ void ec_detrend_kernel184(const int32_T vlen, emxArray_real_T
  x);
static __global__ void ec_detrend_kernel185(const emxArray_real_T a, const
  int32_T trend, emxArray_real_T b_trend);
static __global__ void ec_detrend_kernel186(const int32_T vlen, emxArray_real_T
  trend);
static __global__ void ec_detrend_kernel187(const emxArray_real_T w, const
  emxArray_real_T trend, const emxArray_real_T x, const int32_T b_x,
  emxArray_real_T d);
static __global__ void ec_detrend_kernel188(const real_T d2scaled, const
  emxArray_real_T d, const int32_T npages, emxArray_real_T absdiff);
static __global__ void ec_detrend_kernel189(const emxArray_real_T d, real_T
  *d2scaled);
static __global__ void ec_detrend_kernel19(const emxArray_real_T wimag, const
  emxArray_real_T wreal, const int32_T nx, emxArray_creal_T W);
static __global__ void ec_detrend_kernel190(const emxArray_real_T d, const
  int32_T nx, emxArray_real_T y);
static __global__ void ec_detrend_kernel191(const real_T d2scaled, const
  emxArray_real_T y, const int32_T vlen, emxArray_real_T w);
static __global__ void ec_detrend_kernel192(const emxArray_real_T x, const
  int32_T b_x, emxArray_real_T c_x);
static __global__ void ec_detrend_kernel193(const emxArray_real_T x, const
  int32_T ch, const int32_T b_x, emxArray_real_T c_x, int32_T x_dim0);
static __global__ void ec_detrend_kernel194(const emxArray_real_T w, const
  int32_T ch, const int32_T b_w, emxArray_real_T c_w, int32_T w_dim0);
static __global__ void ec_detrend_kernel2(const int32_T ch, const
  emxArray_real_T w, const int32_T vlen, emxArray_real_T b_w, int32_T w_dim0);
static __global__ void ec_detrend_kernel20(const emxArray_real_T vright, const
  int32_T b_vright, emxArray_creal_T V);
static __global__ void ec_detrend_kernel21(const int32_T istart, const int32_T
  nx, emxArray_creal_T V, int32_T V_dim0);
static __global__ void ec_detrend_kernel22(const creal_T dc, const int32_T A,
  emxArray_creal_T W);
static __global__ void ec_detrend_kernel23(const creal_T dc, const int32_T i12,
  emxArray_creal_T V);
static __global__ void ec_detrend_kernel24(const int32_T A, emxArray_creal_T D);
static __global__ void ec_detrend_kernel25(const int32_T i12, emxArray_real_T A);
static __global__ void ec_detrend_kernel26(const int32_T vlen, emxArray_real_T
  tau);
static __global__ void ec_detrend_kernel27(const emxArray_real_T A, const
  int32_T b_A, emxArray_real_T U);
static __global__ void ec_detrend_kernel28(const int32_T i12, emxArray_real_T U);
static __global__ void ec_detrend_kernel29(emxArray_real_T U);
static __global__ void ec_detrend_kernel3(const int32_T w, emxArray_real_T b_w);
static __global__ void ec_detrend_kernel30(const int32_T i12, emxArray_real_T A);
static __global__ void ec_detrend_kernel31(const int32_T i12, emxArray_real_T U);
static __global__ void ec_detrend_kernel32(const int32_T sz, emxArray_real_T U);
static __global__ void ec_detrend_kernel33(const int32_T npages, const int32_T
  vlen, const int32_T istart, emxArray_real_T U, int32_T U_dim0);
static __global__ void ec_detrend_kernel34(const int32_T sz, emxArray_real_T A);
static __global__ void ec_detrend_kernel35(const int32_T A, emxArray_creal_T D);
static __global__ void ec_detrend_kernel36(const emxArray_real_T U, const
  int32_T b_U, emxArray_creal_T V);
static __global__ void ec_detrend_kernel37(const int32_T vlen, emxArray_real_T W);
static __global__ void ec_detrend_kernel38(const int32_T i12, emxArray_real_T A);
static __global__ void ec_detrend_kernel39(const int32_T npages,
  emxArray_creal_T D);
static __global__ void ec_detrend_kernel4(const int32_T i, emxArray_real_T lin);
static __global__ void ec_detrend_kernel40(const emxArray_real_T A, const
  int32_T b_A, emxArray_creal_T V);
static __global__ void ec_detrend_kernel41(const creal_T dc, const int32_T i12,
  emxArray_creal_T V);
static __global__ void ec_detrend_kernel42(const int32_T i12, emxArray_creal_T D);
static __global__ void ec_detrend_kernel43(const emxArray_creal_T V, const
  int32_T b_V, emxArray_real_T c_V);
static __global__ void ec_detrend_kernel44(const emxArray_creal_T D, const
  int32_T b_D, emxArray_real_T v);
static __global__ void ec_detrend_kernel45(const emxArray_real_T v, const
  int32_T istart, emxArray_real_T D, int32_T v_dim0);
static __global__ void ec_detrend_kernel46(const emxArray_real_T v,
  emxArray_real_T D);
static __global__ void ec_detrend_kernel47(const emxArray_int32_T iv, const
  emxArray_real_T V, const int32_T npages, const int32_T b_iv, emxArray_real_T
  b_V, int32_T V_dim0, int32_T b_V_dim0);
static __global__ void ec_detrend_kernel48(const emxArray_real_T V, const
  int32_T b_V, emxArray_real_T c_V);
static __global__ void ec_detrend_kernel49(const emxArray_real_T rr, const
  int32_T b_rr, emxArray_real_T A);
static __global__ void ec_detrend_kernel5(emxArray_real_T lin);
static __global__ void ec_detrend_kernel50(const int32_T i12, emxArray_real_T rr);
static __global__ void ec_detrend_kernel51(const emxArray_real_T dv1, const
  int32_T b_dv1, emxArray_real_T A);
static __global__ void ec_detrend_kernel52(const int32_T rr, emxArray_real_T b);
static __global__ void ec_detrend_kernel53(const emxArray_real_T rr, const
  int32_T b_rr, const int32_T c_rr, emxArray_real_T A, int32_T A_dim0, int32_T
  rr_dim0);
static __global__ void ec_detrend_kernel54(const int32_T A, emxArray_real_T b_A);
static __global__ void ec_detrend_kernel55(const emxArray_real_T A, const
  int32_T b_A, const int32_T c_A, emxArray_real_T d_A, int32_T A_dim0, int32_T
  b_A_dim0);
static __global__ void ec_detrend_kernel56(const emxArray_real_T b, const
  int32_T b_b, emxArray_real_T B);
static __global__ void ec_detrend_kernel57(const int32_T A, emxArray_int32_T
  jpvt);
static __global__ void ec_detrend_kernel58(const int32_T vlen, const int32_T
  npages, emxArray_real_T A, int32_T A_dim0);
static __global__ void ec_detrend_kernel59(const int32_T vlen, emxArray_real_T
  tau);
static __global__ void ec_detrend_kernel6(const real_T d2scaled, const int32_T
  istart, emxArray_real_T lin, int32_T lin_dim1);
static __global__ void ec_detrend_kernel60(const int32_T jend, const int32_T i,
  emxArray_real_T tau);
static __global__ void ec_detrend_kernel61(const int32_T npages,
  emxArray_int32_T jpvt);
static __global__ void ec_detrend_kernel62(const int32_T A, emxArray_real_T Y);
static __global__ void ec_detrend_kernel63(const int32_T vlen, emxArray_real_T B);
static __global__ void ec_detrend_kernel64(const emxArray_real_T B, const
  emxArray_int32_T jpvt, const int32_T jend, emxArray_real_T Y);
static __global__ void ec_detrend_kernel65(const emxArray_real_T Y, const
  int32_T b_Y, emxArray_real_T b);
static __global__ void ec_detrend_kernel66(const emxArray_int32_T ipiv_t, const
  int32_T istart, emxArray_int32_T ipiv);
static __global__ void ec_detrend_kernel67(const int32_T i12, emxArray_real_T A);
static __global__ void ec_detrend_kernel68(const int32_T istart,
  emxArray_int32_T ipiv);
static __global__ void ec_detrend_kernel69(const int32_T sz, emxArray_real_T b);
static __global__ void ec_detrend_kernel7(emxArray_real_T lin, int32_T lin_dim1);
static __global__ void ec_detrend_kernel70(const emxArray_real_T b, const
  int32_T b_b, emxArray_real_T B);
static __global__ void ec_detrend_kernel71(const int32_T V, emxArray_real_T y);
static __global__ void ec_detrend_kernel72(const int32_T r, emxArray_real_T dv7);
static __global__ void ec_detrend_kernel73(const real_T mn, const
  emxArray_real_T x, const emxArray_real_T dv7, const int32_T b_dv7,
  emxArray_real_T z);
static __global__ void ec_detrend_kernel74(const emxArray_real_T w, const
  emxArray_real_T z, const emxArray_real_T x, const int32_T b_x, emxArray_real_T
  d);
static __global__ void ec_detrend_kernel75(const real_T d2scaled, const
  emxArray_real_T d, const int32_T npages, emxArray_real_T absdiff);
static __global__ void ec_detrend_kernel76(const emxArray_real_T d, real_T
  *d2scaled);
static __global__ void ec_detrend_kernel77(const emxArray_real_T d, const
  int32_T nx, emxArray_real_T y);
static __global__ void ec_detrend_kernel78(const real_T d2scaled, const
  emxArray_real_T y, const int32_T vlen, emxArray_real_T w);
static __global__ void ec_detrend_kernel79(const emxArray_real_T z, const
  int32_T ch, const emxArray_real_T x, const int32_T vlen, emxArray_real_T b_x,
  int32_T x_dim0);
static __global__ void ec_detrend_kernel8(const emxArray_real_T lin, const
  int32_T jend, const int32_T nx, emxArray_real_T r, int32_T r_dim0);
static __global__ void ec_detrend_kernel80(const uint32_T dims_idx_0,
  emxArray_real_T a, emxArray_real_T trend);
static __global__ void ec_detrend_kernel81(const emxArray_real_T w, const
  int32_T jend, const int32_T nx, emxArray_real_T minval);
static __global__ void ec_detrend_kernel82(emxArray_real_T lin, int32_T lin_dim1);
static __global__ void ec_detrend_kernel83(emxArray_real_T lin);
static __global__ void ec_detrend_kernel84(const real_T d2scaled, const int32_T
  istart, emxArray_real_T lin, int32_T lin_dim1);
static __global__ void ec_detrend_kernel85(emxArray_real_T lin, int32_T lin_dim1);
static __global__ void ec_detrend_kernel86(const int32_T jend, const
  emxArray_real_T lin, const int32_T nx, emxArray_real_T dv2);
static __global__ void ec_detrend_kernel87(const emxArray_real_T dv2, const
  int32_T jend, const int32_T vlen, emxArray_real_T r, int32_T r_dim0);
static __global__ void ec_detrend_kernel88(const emxArray_real_T w, const
  int32_T i11, const emxArray_real_T x, const int32_T i7, const int32_T ii,
  emxArray_real_T b_x);
static __global__ void ec_detrend_kernel89(const emxArray_real_T w, const
  int32_T i11, const emxArray_real_T x, const int32_T i7, const int32_T ii,
  emxArray_real_T b_x);
static __global__ void ec_detrend_kernel9(const emxArray_real_T w, const
  emxArray_real_T x, const int32_T b_x, emxArray_real_T c_x);
static __global__ void ec_detrend_kernel90(const emxArray_real_T w, const
  int32_T i11, const real_T d2scaled, const emxArray_real_T x, const int32_T i7,
  const int32_T ii, emxArray_real_T dv3);
static __global__ void ec_detrend_kernel91(const emxArray_real_T w, const
  int32_T i11, const emxArray_real_T r, const int32_T b_r, const int32_T c_r,
  emxArray_real_T x, int32_T x_dim0, int32_T r_dim0);
static __global__ void ec_detrend_kernel92(const int32_T vlen, const
  emxArray_real_T x, const int32_T npages, emxArray_real_T y, int32_T x_dim0);
static __global__ void ec_detrend_kernel93(const int32_T sz, emxArray_real_T y);
static __global__ void ec_detrend_kernel94(const real_T d2scaled, const
  emxArray_real_T y, const emxArray_real_T r, const int32_T b_r, const int32_T
  c_r, emxArray_real_T d_r, int32_T r_dim0, int32_T b_r_dim0);
static __global__ void ec_detrend_kernel95(const emxArray_real_T r, const
  int32_T b_r, emxArray_real_T c_r);
static __global__ void ec_detrend_kernel96(const emxArray_real_T w, const
  int32_T i11, const emxArray_real_T r, const int32_T b_r, const int32_T c_r,
  emxArray_real_T rr, int32_T rr_dim0, int32_T r_dim0);
static __global__ void ec_detrend_kernel97(const emxArray_real_T rr, const
  int32_T b_rr, const int32_T c_rr, emxArray_real_T A, int32_T A_dim0, int32_T
  rr_dim0);
static __global__ void ec_detrend_kernel98(const int32_T A, emxArray_real_T b_A);
static __global__ void ec_detrend_kernel99(const emxArray_real_T wimag, const
  emxArray_real_T wreal, const int32_T nx, emxArray_creal_T W);
static void ec_detrend_once();
static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static real_T emlrt_marshallIn(const mxArray *b_nullptr, const char_T
  *identifier);
static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static void emlrt_marshallOut(const emxArray_real_T *u, const mxArray *y);
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
static void emxFree_creal_T(emxArray_creal_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_int8_T(emxArray_int8_T **pEmxArray);
static void emxFree_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
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
static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
  emxArray_creal_T *gpu);
static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu);
static void gpuEmxEnsureCapacity_int8_T(const emxArray_int8_T *cpu,
  emxArray_int8_T *gpu);
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu);
static void gpuEmxFree_creal_T(emxArray_creal_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
static void gpuEmxFree_int8_T(emxArray_int8_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
static void gpuEmxMemcpyCpuToGpu_creal_T(emxArray_creal_T *gpu, const
  emxArray_creal_T *cpu);
static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu, const
  emxArray_int32_T *cpu);
static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu, const
  emxArray_real_T *cpu);
static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu, emxArray_creal_T
  *gpu);
static void gpuEmxMemcpyGpuToCpu_int32_T(emxArray_int32_T *cpu, emxArray_int32_T
  *gpu);
static void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T
  *gpu);
static void gpuEmxReset_creal_T(emxArray_creal_T *gpu);
static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);
static void gpuEmxReset_int8_T(emxArray_int8_T *gpu);
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static real_T rt_remd_snf(real_T u0, real_T u1);
static void times(emxArray_real_T *in1, const emxArray_real_T *in2, const
                  emxArray_real_T *in3);

// Function Definitions
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

  emxEnsureCapacity_real_T(in1, i, &ad_emlrtRTEI);
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

static void binary_expand_op_1(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &yc_emlrtRTEI);
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

static void binary_expand_op_10(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &qd_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in6->size[0] == 1) {
    b_in1->size[0] = (in5 - in4) + 1;
  } else {
    b_in1->size[0] = in6->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &qd_emlrtRTEI);
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

static void binary_expand_op_11(emxArray_real_T *in1, int32_T in2, int32_T in4,
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
  emxInit_real_T(&b_in1, 1, &pd_emlrtRTEI, true);
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

  emxEnsureCapacity_real_T(b_in1, i, &pd_emlrtRTEI);
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

static void binary_expand_op_12(emxArray_real_T *in1, int32_T in2, int32_T in4,
  int32_T in5, const emxArray_real_T *in6, const emxArray_real_T *in7)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &od_emlrtRTEI, true);
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

  emxEnsureCapacity_real_T(b_in1, i, &od_emlrtRTEI);
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

static void binary_expand_op_13(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &fd_emlrtRTEI);
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

static void binary_expand_op_14(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &ad_emlrtRTEI);
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

static void binary_expand_op_15(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &yc_emlrtRTEI);
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

static void binary_expand_op_16(emxArray_real_T *in1, const emxArray_real_T *in2,
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
  emxEnsureCapacity_real_T(in1, i, &s_emlrtRTEI);
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

static void binary_expand_op_17(emxArray_real_T *in1, const emxArray_real_T *in2,
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
  emxInit_real_T(&b_in1, 2, &bc_emlrtRTEI, true);
  i = b_in1->size[0] * b_in1->size[1];
  b_in1->size[0] = in1->size[0];
  if (in2->size[1] == 1) {
    b_in1->size[1] = in1->size[1];
  } else {
    b_in1->size[1] = in2->size[1];
  }

  emxEnsureCapacity_real_T(b_in1, i, &bc_emlrtRTEI);
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
  emxEnsureCapacity_real_T(in1, i, &r_emlrtRTEI);
  for (i = 0; i < b_in1->size[1]; i++) {
    for (int32_T i1{0}; i1 < b_in1->size[0]; i1++) {
      in1->data[i1 + in1->size[0] * i] = b_in1->data[i1 + b_in1->size[0] * i];
    }
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op_19(emxArray_real_T *in1, const emxArray_real_T *in2,
  int32_T in3, int32_T in4, real_T in5, const emxArray_real_T *in6, int32_T in7,
  int32_T in8)
{
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  i = in1->size[0];
  if (in8 - in7 == 1) {
    in1->size[0] = (in4 - in3) + 1;
  } else {
    in1->size[0] = in8 - in7;
  }

  emxEnsureCapacity_real_T(in1, i, &o_emlrtRTEI);
  stride_0_0 = ((in4 - in3) + 1 != 1);
  stride_1_0 = (in8 - in7 != 1);
  if (in8 - in7 == 1) {
    b = (in4 - in3) + 1;
  } else {
    b = in8 - in7;
  }

  for (i = 0; i < b; i++) {
    in1->data[i] = (in2->data[in3 + i * stride_0_0] - in5) * in6->data[(in7 + i *
      stride_1_0) - 1];
  }
}

static void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2,
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
  emxEnsureCapacity_real_T(in1, i, &s_emlrtRTEI);
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

static void binary_expand_op_20(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &m_emlrtRTEI);
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

static void binary_expand_op_3(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &r_emlrtRTEI);
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

static void binary_expand_op_5(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &o_emlrtRTEI);
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

static void binary_expand_op_6(emxArray_real_T *in1, const emxArray_real_T *in2,
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

  emxEnsureCapacity_real_T(in1, i, &l_emlrtRTEI);
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

static void binary_expand_op_8(emxArray_real_T *in1, const emxArray_real_T *in2)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &ve_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in2->size[0] == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in2->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &ve_emlrtRTEI);
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
  emxEnsureCapacity_real_T(in1, i, &we_emlrtRTEI);
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel1(const
  int32_T ch, const emxArray_real_T x, const int32_T vlen, emxArray_real_T b_x,
  int32_T x_dim0)
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
    b_x.data[i] = x.data[i + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel10(const
  emxArray_real_T w, const emxArray_real_T x, const int32_T b_x, emxArray_real_T
  c_x)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel100(const
  emxArray_real_T vright, const int32_T b_vright, emxArray_creal_T V)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel101(const
  int32_T istart, const int32_T nx, emxArray_creal_T V, int32_T V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    d = V.data[xpageoffset + V_dim0 * (istart - 1)].re;
    V.data[xpageoffset + V_dim0 * (istart - 2)].im = d;
    V.data[xpageoffset + V_dim0 * (istart - 1)].re = V.data[xpageoffset + V_dim0
      * (istart - 2)].re;
    V.data[xpageoffset + V_dim0 * (istart - 1)].im = -V.data[xpageoffset +
      V_dim0 * (istart - 2)].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel102(const
  creal_T dc, const int32_T A, emxArray_creal_T W)
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
    W.data[i] = dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel103(const
  creal_T dc, const int32_T i12, emxArray_creal_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i] = dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel104(const
  int32_T A, emxArray_creal_T D)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel105(const
  int32_T i12, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel106(const
  int32_T vlen, emxArray_real_T tau)
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
    tau.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel107(const
  emxArray_real_T A, const int32_T b_A, emxArray_real_T U)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel108(const
  int32_T i12, emxArray_real_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel109
  (emxArray_real_T U)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    U.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel11(const
  emxArray_real_T w, const real_T d2scaled, const emxArray_real_T x, const
  int32_T b_x, emxArray_real_T dv1)
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
    dv1.data[i] = (x.data[i] - d2scaled) * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel110(const
  int32_T i12, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel111(const
  int32_T i12, emxArray_real_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel112(const
  int32_T sz, emxArray_real_T U)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel113(const
  int32_T npages, const int32_T vlen, const int32_T istart, emxArray_real_T U,
  int32_T U_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>
    (istart), static_cast<int64_T>(vlen), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    U.data[(static_cast<int32_T>(static_cast<int64_T>(istart) + i) + U_dim0 *
            (npages - 1)) - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel114(const
  int32_T sz, emxArray_real_T A)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel115(const
  int32_T A, emxArray_creal_T D)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel116(const
  emxArray_real_T U, const int32_T b_U, emxArray_creal_T V)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel117(const
  int32_T vlen, emxArray_real_T W)
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
    W.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel118(const
  int32_T i12, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel119(const
  int32_T npages, emxArray_creal_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages * npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel12(const
  emxArray_real_T w, const emxArray_real_T r, const int32_T b_r, const int32_T
  c_r, emxArray_real_T x, int32_T x_dim0, int32_T r_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel120(const
  emxArray_real_T A, const int32_T b_A, emxArray_creal_T V)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel121(const
  creal_T dc, const int32_T i12, emxArray_creal_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i] = dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel122(const
  int32_T i12, emxArray_creal_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel123(const
  emxArray_creal_T V, const int32_T b_V, emxArray_real_T c_V)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel124(const
  emxArray_creal_T D, const int32_T b_D, emxArray_real_T v)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel125(const
  emxArray_real_T v, const int32_T istart, emxArray_real_T D, int32_T v_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    D.data[k] = v.data[k + v_dim0 * k];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel126(const
  emxArray_real_T v, emxArray_real_T D)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    D.data[0] = v.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel127(const
  emxArray_int32_T iv1, const emxArray_real_T V, const int32_T npages, const
  int32_T b_iv1, emxArray_real_T b_V, int32_T V_dim0, int32_T b_V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages) * (static_cast<uint64_T>(b_iv1) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx % static_cast<uint64_T>(npages));
    i = static_cast<int32_T>((idx - static_cast<uint64_T>(xpageoffset)) /
      static_cast<uint64_T>(npages));
    b_V.data[xpageoffset + V_dim0 * i] = V.data[xpageoffset + b_V_dim0 *
      iv1.data[i]];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel128(const
  emxArray_real_T V, const int32_T b_V, emxArray_real_T c_V)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel129(const
  emxArray_real_T rr, const int32_T b_rr, emxArray_real_T A)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel13(const
  int32_T vlen, const emxArray_real_T x, const int32_T npages, emxArray_real_T y,
  int32_T x_dim0)
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
    for (int32_T k{0}; k <= vlen - 2; k++) {
      y.data[i] += x.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel130(const
  int32_T i12, emxArray_real_T rr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    rr.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel131(const
  emxArray_real_T dv3, const int32_T b_dv3, emxArray_real_T A)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel132(const
  int32_T rr, emxArray_real_T b)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel133(const
  emxArray_real_T rr, const int32_T b_rr, const int32_T c_rr, emxArray_real_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel134(const
  int32_T A, emxArray_real_T b_A)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel135(const
  emxArray_real_T A, const int32_T b_A, const int32_T c_A, emxArray_real_T d_A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel136(const
  emxArray_real_T b, const int32_T b_b, emxArray_real_T B)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel137(const
  int32_T A, emxArray_int32_T jpvt)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel138(const
  int32_T vlen, const int32_T npages, emxArray_real_T A, int32_T A_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) * (static_cast<uint64_T>(npages) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx % static_cast<uint64_T>(vlen));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      static_cast<uint64_T>(vlen));
    A.data[xpageoffset * A_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel139(const
  int32_T vlen, emxArray_real_T tau)
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
    tau.data[k] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel14(const
  int32_T sz, emxArray_real_T y)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel140(const
  int32_T jend, const int32_T i, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>(i),
    static_cast<int64_T>(jend), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T b_i;
    b_i = static_cast<int64_T>(idx);
    tau.data[static_cast<int32_T>(static_cast<int64_T>(i) + b_i) - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel141(const
  int32_T npages, emxArray_int32_T jpvt)
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
    jpvt.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel142(const
  int32_T A, emxArray_real_T Y)
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
    Y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel143(const
  int32_T vlen, emxArray_real_T B)
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
    B.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel144(const
  emxArray_real_T B, const emxArray_int32_T jpvt, const int32_T jend,
  emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[jpvt.data[i] - 1] = B.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel145(const
  emxArray_real_T Y, const int32_T b_Y, emxArray_real_T b)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel146(const
  emxArray_int32_T ipiv_t, const int32_T istart, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel147(const
  int32_T i12, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel148(const
  int32_T istart, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel149(const
  int32_T sz, emxArray_real_T b)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel15(const
  real_T d2scaled, const emxArray_real_T y, const emxArray_real_T r, const
  int32_T b_r, const int32_T c_r, emxArray_real_T d_r, int32_T r_dim0, int32_T
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel150(const
  emxArray_real_T b, const int32_T b_b, emxArray_real_T B)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel151(const
  int32_T V, emxArray_real_T y)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel152(const
  int32_T r, emxArray_real_T dv11)
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
    dv11.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel153(const
  real_T mn, const emxArray_real_T x, const int32_T i7, const emxArray_real_T
  dv11, const int32_T b_dv11, emxArray_real_T z)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_dv11);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    z.data[i] = dv11.data[i] + (x.data[i7 + i] - (x.data[i7 + i] - mn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel154(const
  emxArray_real_T w, const int32_T i11, const emxArray_real_T z, const
  emxArray_real_T x, const int32_T i7, const int32_T ii, emxArray_real_T d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ii - i7) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    d.data[i] = (x.data[i7 + i] - z.data[i]) * w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel155(const
  real_T d2scaled, const emxArray_real_T d, const int32_T npages,
  emxArray_real_T absdiff)
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
    absdiff.data[k] = fabs(d.data[k] - d2scaled);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel156(const
  emxArray_real_T z, const emxArray_real_T x, const int32_T i7, const int32_T ii,
  emxArray_real_T yy)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ii - i7) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    yy.data[i] = x.data[i7 + i] - z.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel157(const
  real_T d2scaled, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(d2scaled - 1.0);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = static_cast<real_T>(i) + 1.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel158(const
  real_T rconde, const real_T abnrm, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[static_cast<int32_T>(abnrm) - 1] = rconde;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel159(const
  real_T rconde, const int32_T npages, const real_T d2scaled, const int32_T
  istart, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k + 1] = d2scaled - (static_cast<real_T>(k) + 1.0);
    y.data[(npages - k) - 2] = rconde - (-(static_cast<real_T>(k) + 1.0));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel16(const
  emxArray_real_T w, const emxArray_real_T r, const int32_T b_r, const int32_T
  c_r, emxArray_real_T rr, int32_T rr_dim0, int32_T r_dim0)
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

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel160(const
  real_T d2scaled, const int32_T istart, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[istart] = d2scaled - static_cast<real_T>(istart);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel161(const
  real_T rconde, const int32_T istart, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[istart + 1] = rconde - (-static_cast<real_T>(istart));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel162(const
  real_T rconde, const real_T d2scaled, const int32_T istart, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[istart] = (d2scaled + rconde) / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel163(const
  real_T d2scaled, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(-(1.0 - d2scaled));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = d2scaled - static_cast<real_T>(i);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel164(const
  emxArray_real_T y, const int32_T istart, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel165(const
  real_T d2scaled, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(d2scaled - 1.0);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = static_cast<real_T>(i) + 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel166(const
  real_T wsize2, emxArray_int8_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(wsize2 / 2.0)) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[i] = static_cast<int8_T>(1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel167(const
  emxArray_real_T y, const int32_T istart, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel168(const
  real_T wsize2, emxArray_int8_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(wsize2 / 2.0)) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[i] = static_cast<int8_T>(1);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel169(const
  real_T rconde, const real_T abnrm, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[static_cast<int32_T>(abnrm) - 1] = rconde;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel17(const
  emxArray_real_T rr, const int32_T b_rr, const int32_T c_rr, emxArray_real_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel170(const
  real_T rconde, const int32_T npages, const real_T d2scaled, const int32_T
  istart, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k + 1] = d2scaled - (static_cast<real_T>(k) + 1.0);
    y.data[(npages - k) - 2] = rconde - (-(static_cast<real_T>(k) + 1.0));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel171(const
  real_T d2scaled, const int32_T istart, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[istart] = d2scaled - static_cast<real_T>(istart);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel172(const
  real_T rconde, const int32_T istart, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[istart + 1] = rconde - (-static_cast<real_T>(istart));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel173(const
  real_T rconde, const real_T d2scaled, const int32_T istart, emxArray_real_T y)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y.data[istart] = (d2scaled + rconde) / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel174(const
  real_T d2scaled, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(-(1.0 - d2scaled));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[i] = d2scaled - static_cast<real_T>(i);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel175(const
  real_T wsize2, const int32_T istart, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b.data[i] = wsize2 / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel176(const
  emxArray_real_T b, const emxArray_real_T yy, const emxArray_real_T x, const
  int32_T istart, const int32_T jend, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - istart) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_x.data[i] = x.data[istart + i] + yy.data[i] * b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel177(const
  emxArray_real_T x, const int32_T npages, const int32_T b_x, emxArray_real_T
  c_x)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel178(const
  emxArray_real_T b, const emxArray_real_T yy, const emxArray_real_T x, const
  int32_T vlen, const emxArray_real_T trend, const int32_T jend, const int32_T
  npages, emxArray_real_T b_trend)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages - jend) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_trend.data[i] = trend.data[jend + i] + (x.data[(vlen + i) + 1] - yy.data[i])
      * b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel179(const
  emxArray_real_T trend, const int32_T nx, const int32_T b_trend,
  emxArray_real_T c_trend)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel18(const
  int32_T A, emxArray_real_T b_A)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel180(const
  emxArray_real_T b, const emxArray_real_T a, const int32_T istart, const
  int32_T jend, emxArray_real_T b_a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend - istart) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_a.data[i] = a.data[istart + i] + b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel181(const
  emxArray_real_T a, const int32_T npages, const int32_T b_a, emxArray_real_T
  c_a)
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

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel182
  (emxArray_real_T a, emxArray_real_T x, int32_T x_dim0, int32_T a_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    //  last sample can be missed
    // 'ec_detrend:142' y(end,:) = y(end-1,:);
    x.data[x_dim0 - 1] = x.data[x_dim0 - 2];

    // 'ec_detrend:143' a(end,:) = a(end-1,:);
    a.data[a_dim0 - 1] = a.data[a_dim0 - 2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel183(const
  emxArray_real_T a, const int32_T x, emxArray_real_T b_x)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel184(const
  int32_T vlen, emxArray_real_T x)
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
    if (isnan(x.data[i])) {
      x.data[i] = 0.0;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel185(const
  emxArray_real_T a, const int32_T trend, emxArray_real_T b_trend)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel186(const
  int32_T vlen, emxArray_real_T trend)
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
    if (isnan(trend.data[i])) {
      trend.data[i] = 0.0;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel187(const
  emxArray_real_T w, const emxArray_real_T trend, const emxArray_real_T x, const
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel188(const
  real_T d2scaled, const emxArray_real_T d, const int32_T npages,
  emxArray_real_T absdiff)
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
    absdiff.data[k] = fabs(d.data[k] - d2scaled);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel189(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel19(const
  emxArray_real_T wimag, const emxArray_real_T wreal, const int32_T nx,
  emxArray_creal_T W)
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
    W.data[i].re = wreal.data[i];
    W.data[i].im = wimag.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel190(const
  emxArray_real_T d, const int32_T nx, emxArray_real_T y)
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
    y.data[k] = fabs(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel191(const
  real_T d2scaled, const emxArray_real_T y, const int32_T vlen, emxArray_real_T
  w)
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
    if (y.data[i] > d2scaled) {
      w.data[i] = 0.0;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel192(const
  emxArray_real_T x, const int32_T b_x, emxArray_real_T c_x)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel193(const
  emxArray_real_T x, const int32_T ch, const int32_T b_x, emxArray_real_T c_x,
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel194(const
  emxArray_real_T w, const int32_T ch, const int32_T b_w, emxArray_real_T c_w,
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel2(const
  int32_T ch, const emxArray_real_T w, const int32_T vlen, emxArray_real_T b_w,
  int32_T w_dim0)
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
    b_w.data[i] = w.data[i + w_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel20(const
  emxArray_real_T vright, const int32_T b_vright, emxArray_creal_T V)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel21(const
  int32_T istart, const int32_T nx, emxArray_creal_T V, int32_T V_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T xpageoffset;
    xpageoffset = static_cast<int32_T>(idx);
    d = V.data[xpageoffset + V_dim0 * (istart - 1)].re;
    V.data[xpageoffset + V_dim0 * (istart - 2)].im = d;
    V.data[xpageoffset + V_dim0 * (istart - 1)].re = V.data[xpageoffset + V_dim0
      * (istart - 2)].re;
    V.data[xpageoffset + V_dim0 * (istart - 1)].im = -V.data[xpageoffset +
      V_dim0 * (istart - 2)].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel22(const
  creal_T dc, const int32_T A, emxArray_creal_T W)
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
    W.data[i] = dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel23(const
  creal_T dc, const int32_T i12, emxArray_creal_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i] = dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel24(const
  int32_T A, emxArray_creal_T D)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel25(const
  int32_T i12, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel26(const
  int32_T vlen, emxArray_real_T tau)
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
    tau.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel27(const
  emxArray_real_T A, const int32_T b_A, emxArray_real_T U)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel28(const
  int32_T i12, emxArray_real_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel29
  (emxArray_real_T U)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    U.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel3(const
  int32_T w, emxArray_real_T b_w)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel30(const
  int32_T i12, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel31(const
  int32_T i12, emxArray_real_T U)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    U.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel32(const
  int32_T sz, emxArray_real_T U)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel33(const
  int32_T npages, const int32_T vlen, const int32_T istart, emxArray_real_T U,
  int32_T U_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>
    (istart), static_cast<int64_T>(vlen), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T i;
    i = static_cast<int64_T>(idx);
    U.data[(static_cast<int32_T>(static_cast<int64_T>(istart) + i) + U_dim0 *
            (npages - 1)) - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel34(const
  int32_T sz, emxArray_real_T A)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel35(const
  int32_T A, emxArray_creal_T D)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel36(const
  emxArray_real_T U, const int32_T b_U, emxArray_creal_T V)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel37(const
  int32_T vlen, emxArray_real_T W)
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
    W.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel38(const
  int32_T i12, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel39(const
  int32_T npages, emxArray_creal_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(npages * npages) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel4(const int32_T
  i, emxArray_real_T lin)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[i - 1] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel40(const
  emxArray_real_T A, const int32_T b_A, emxArray_creal_T V)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel41(const
  creal_T dc, const int32_T i12, emxArray_creal_T V)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    V.data[i] = dc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel42(const
  int32_T i12, emxArray_creal_T D)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    D.data[i].re = 0.0;
    D.data[i].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel43(const
  emxArray_creal_T V, const int32_T b_V, emxArray_real_T c_V)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel44(const
  emxArray_creal_T D, const int32_T b_D, emxArray_real_T v)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel45(const
  emxArray_real_T v, const int32_T istart, emxArray_real_T D, int32_T v_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    D.data[k] = v.data[k + v_dim0 * k];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel46(const
  emxArray_real_T v, emxArray_real_T D)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    D.data[0] = v.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel47(const
  emxArray_int32_T iv, const emxArray_real_T V, const int32_T npages, const
  int32_T b_iv, emxArray_real_T b_V, int32_T V_dim0, int32_T b_V_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel48(const
  emxArray_real_T V, const int32_T b_V, emxArray_real_T c_V)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel49(const
  emxArray_real_T rr, const int32_T b_rr, emxArray_real_T A)
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

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel5
  (emxArray_real_T lin)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[0] = -1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel50(const
  int32_T i12, emxArray_real_T rr)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    rr.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel51(const
  emxArray_real_T dv1, const int32_T b_dv1, emxArray_real_T A)
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
    A.data[i] = dv1.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel52(const
  int32_T rr, emxArray_real_T b)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel53(const
  emxArray_real_T rr, const int32_T b_rr, const int32_T c_rr, emxArray_real_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel54(const
  int32_T A, emxArray_real_T b_A)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel55(const
  emxArray_real_T A, const int32_T b_A, const int32_T c_A, emxArray_real_T d_A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel56(const
  emxArray_real_T b, const int32_T b_b, emxArray_real_T B)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel57(const
  int32_T A, emxArray_int32_T jpvt)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel58(const
  int32_T vlen, const int32_T npages, emxArray_real_T A, int32_T A_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) * (static_cast<uint64_T>(npages) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T xpageoffset;
    i = static_cast<int32_T>(idx % static_cast<uint64_T>(vlen));
    xpageoffset = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      static_cast<uint64_T>(vlen));
    A.data[xpageoffset * A_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel59(const
  int32_T vlen, emxArray_real_T tau)
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
    tau.data[k] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel6(const
  real_T d2scaled, const int32_T istart, emxArray_real_T lin, int32_T lin_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real_T>((((k + 2) << 1) - lin_dim1) - 1) *
      d2scaled;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel60(const
  int32_T jend, const int32_T i, emxArray_real_T tau)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(computeEndIdx_device(static_cast<int64_T>(i),
    static_cast<int64_T>(jend), 1L));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int64_T b_i;
    b_i = static_cast<int64_T>(idx);
    tau.data[static_cast<int32_T>(static_cast<int64_T>(i) + b_i) - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel61(const
  int32_T npages, emxArray_int32_T jpvt)
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
    jpvt.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel62(const
  int32_T A, emxArray_real_T Y)
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
    Y.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel63(const
  int32_T vlen, emxArray_real_T B)
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
    B.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel64(const
  emxArray_real_T B, const emxArray_int32_T jpvt, const int32_T jend,
  emxArray_real_T Y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(jend);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[jpvt.data[i] - 1] = B.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel65(const
  emxArray_real_T Y, const int32_T b_Y, emxArray_real_T b)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel66(const
  emxArray_int32_T ipiv_t, const int32_T istart, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = ipiv_t.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel67(const
  int32_T i12, emxArray_real_T A)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i12);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    A.data[i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel68(const
  int32_T istart, emxArray_int32_T ipiv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ipiv.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel69(const
  int32_T sz, emxArray_real_T b)
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

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel7
  (emxArray_real_T lin, int32_T lin_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[lin_dim1 >> 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel70(const
  emxArray_real_T b, const int32_T b_b, emxArray_real_T B)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel71(const
  int32_T V, emxArray_real_T y)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel72(const
  int32_T r, emxArray_real_T dv7)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel73(const
  real_T mn, const emxArray_real_T x, const emxArray_real_T dv7, const int32_T
  b_dv7, emxArray_real_T z)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel74(const
  emxArray_real_T w, const emxArray_real_T z, const emxArray_real_T x, const
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
    d.data[i] = (x.data[i] - z.data[i]) * w.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel75(const
  real_T d2scaled, const emxArray_real_T d, const int32_T npages,
  emxArray_real_T absdiff)
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
    absdiff.data[k] = fabs(d.data[k] - d2scaled);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel76(const
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel77(const
  emxArray_real_T d, const int32_T nx, emxArray_real_T y)
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
    y.data[k] = fabs(d.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel78(const
  real_T d2scaled, const emxArray_real_T y, const int32_T vlen, emxArray_real_T
  w)
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
    if (y.data[i] > d2scaled) {
      w.data[i] = 0.0;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel79(const
  emxArray_real_T z, const int32_T ch, const emxArray_real_T x, const int32_T
  vlen, emxArray_real_T b_x, int32_T x_dim0)
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
    b_x.data[i] = x.data[i + x_dim0 * ch] - z.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel8(const
  emxArray_real_T lin, const int32_T jend, const int32_T nx, emxArray_real_T r,
  int32_T r_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();

  // 'ec_detrend:78' r(:,k) = lin.^k;
  loopEnd = static_cast<uint64_T>(nx) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    r.data[k + r_dim0 * jend] = pow(lin.data[k], static_cast<real_T>(jend) + 1.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel80(const
  uint32_T dims_idx_0, emxArray_real_T a, emxArray_real_T trend)
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
    trend.data[i] = 0.0;
    a.data[i] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel81(const
  emxArray_real_T w, const int32_T jend, const int32_T nx, emxArray_real_T
  minval)
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

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel82
  (emxArray_real_T lin, int32_T lin_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[lin_dim1 - 1] = 1.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel83
  (emxArray_real_T lin)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[0] = -1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel84(const
  real_T d2scaled, const int32_T istart, emxArray_real_T lin, int32_T lin_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(istart) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    lin.data[k + 1] = static_cast<real_T>((((k + 2) << 1) - lin_dim1) - 1) *
      d2scaled;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_detrend_kernel85
  (emxArray_real_T lin, int32_T lin_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    lin.data[lin_dim1 >> 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel86(const
  int32_T jend, const emxArray_real_T lin, const int32_T nx, emxArray_real_T dv2)
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
    dv2.data[k] = pow(lin.data[k], static_cast<real_T>(jend) + 1.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel87(const
  emxArray_real_T dv2, const int32_T jend, const int32_T vlen, emxArray_real_T r,
  int32_T r_dim0)
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
    r.data[i + r_dim0 * jend] = dv2.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel88(const
  emxArray_real_T w, const int32_T i11, const emxArray_real_T x, const int32_T
  i7, const int32_T ii, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ii - i7) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_x.data[i] = x.data[i7 + i] * w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel89(const
  emxArray_real_T w, const int32_T i11, const emxArray_real_T x, const int32_T
  i7, const int32_T ii, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ii - i7) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    b_x.data[i] = x.data[i7 + i] * w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel9(const
  emxArray_real_T w, const emxArray_real_T x, const int32_T b_x, emxArray_real_T
  c_x)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel90(const
  emxArray_real_T w, const int32_T i11, const real_T d2scaled, const
  emxArray_real_T x, const int32_T i7, const int32_T ii, emxArray_real_T dv3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ii - i7) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    dv3.data[i] = (x.data[i7 + i] - d2scaled) * w.data[(i11 + i) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel91(const
  emxArray_real_T w, const int32_T i11, const emxArray_real_T r, const int32_T
  b_r, const int32_T c_r, emxArray_real_T x, int32_T x_dim0, int32_T r_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel92(const
  int32_T vlen, const emxArray_real_T x, const int32_T npages, emxArray_real_T y,
  int32_T x_dim0)
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
    for (int32_T k{0}; k <= vlen - 2; k++) {
      y.data[i] += x.data[(xpageoffset + k) + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel93(const
  int32_T sz, emxArray_real_T y)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel94(const
  real_T d2scaled, const emxArray_real_T y, const emxArray_real_T r, const
  int32_T b_r, const int32_T c_r, emxArray_real_T d_r, int32_T r_dim0, int32_T
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel95(const
  emxArray_real_T r, const int32_T b_r, emxArray_real_T c_r)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel96(const
  emxArray_real_T w, const int32_T i11, const emxArray_real_T r, const int32_T
  b_r, const int32_T c_r, emxArray_real_T rr, int32_T rr_dim0, int32_T r_dim0)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel97(const
  emxArray_real_T rr, const int32_T b_rr, const int32_T c_rr, emxArray_real_T A,
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel98(const
  int32_T A, emxArray_real_T b_A)
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

static __global__ __launch_bounds__(1024, 1) void ec_detrend_kernel99(const
  emxArray_real_T wimag, const emxArray_real_T wreal, const int32_T nx,
  emxArray_creal_T W)
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
    W.data[i].re = wreal.data[i];
    W.data[i].im = wimag.data[i];
  }
}

static void ec_detrend_once()
{
  mex_InitInfAndNan();
  mwMemoryManagerInit(256U, 2U, 8U, 2048U);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId, y);
  emlrtDestroyArray(&b_nullptr);
}

static real_T emlrt_marshallIn(const mxArray *b_nullptr, const char_T
  *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
  return y;
}

static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = b_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void emlrt_marshallOut(const emxArray_real_T *u, const mxArray *y)
{
  emlrtMxSetData((mxArray *)y, &u->data[0]);
  emlrtSetDimensions((mxArray *)y, &u->size[0], 2);
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(creal_T));
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(int8_T));
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

static void gpuEmxEnsureCapacity_int8_T(const emxArray_int8_T *cpu,
  emxArray_int8_T *gpu)
{
  int8_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint32_T>(cpu->allocatedSize) * sizeof
                 (int8_T));
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
                   (int8_T));
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

  emxEnsureCapacity_real_T(in1, i, &m_emlrtRTEI);
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
void ec_detrend(emxArray_real_T *cpu_x, emxArray_real_T *cpu_w, real_T order,
                real_T thr, real_T nItr, real_T winSz)
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
  emxArray_creal_T b_gpu_W;
  emxArray_creal_T c_gpu_D;
  emxArray_creal_T d_gpu_V;
  emxArray_creal_T d_gpu_W;
  emxArray_creal_T gpu_D;
  emxArray_creal_T gpu_V;
  emxArray_creal_T *b_cpu_W;
  emxArray_creal_T *c_cpu_D;
  emxArray_creal_T *c_cpu_V;
  emxArray_creal_T *cpu_D;
  emxArray_creal_T *cpu_V;
  emxArray_creal_T *d_cpu_W;
  emxArray_int32_T b_gpu_ipiv;
  emxArray_int32_T b_gpu_ipiv_t;
  emxArray_int32_T b_gpu_jpvt;
  emxArray_int32_T gpu_ipiv;
  emxArray_int32_T gpu_ipiv_t;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_jpvt;
  emxArray_int32_T *b_cpu_ipiv;
  emxArray_int32_T *b_cpu_ipiv_t;
  emxArray_int32_T *b_cpu_jpvt;
  emxArray_int32_T *cpu_ipiv;
  emxArray_int32_T *cpu_ipiv_t;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv1;
  emxArray_int32_T *cpu_jpvt;
  emxArray_int8_T b_gpu_a;
  emxArray_int8_T d_gpu_a;
  emxArray_int8_T *b_cpu_a;
  emxArray_int8_T *c_cpu_a;
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
  emxArray_real_T c_gpu_W;
  emxArray_real_T c_gpu_a;
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
  emxArray_real_T d_gpu_r;
  emxArray_real_T d_gpu_tau;
  emxArray_real_T d_gpu_x;
  emxArray_real_T d_gpu_y;
  emxArray_real_T e_gpu_A;
  emxArray_real_T e_gpu_V;
  emxArray_real_T e_gpu_x;
  emxArray_real_T e_gpu_y;
  emxArray_real_T f_gpu_A;
  emxArray_real_T f_gpu_V;
  emxArray_real_T f_gpu_x;
  emxArray_real_T f_gpu_y;
  emxArray_real_T g_gpu_A;
  emxArray_real_T g_gpu_x;
  emxArray_real_T g_gpu_y;
  emxArray_real_T gpu_A;
  emxArray_real_T gpu_B;
  emxArray_real_T gpu_U;
  emxArray_real_T gpu_W;
  emxArray_real_T gpu_Y;
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_absdiff;
  emxArray_real_T gpu_b;
  emxArray_real_T gpu_d;
  emxArray_real_T gpu_dv1;
  emxArray_real_T gpu_dv11;
  emxArray_real_T gpu_dv2;
  emxArray_real_T gpu_dv3;
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
  emxArray_real_T *b_cpu_A;
  emxArray_real_T *b_cpu_B;
  emxArray_real_T *b_cpu_D;
  emxArray_real_T *b_cpu_U;
  emxArray_real_T *b_cpu_V;
  emxArray_real_T *b_cpu_Y;
  emxArray_real_T *b_cpu_absdiff;
  emxArray_real_T *b_cpu_b;
  emxArray_real_T *b_cpu_d;
  emxArray_real_T *b_cpu_lin;
  emxArray_real_T *b_cpu_r;
  emxArray_real_T *b_cpu_rr;
  emxArray_real_T *b_cpu_tau;
  emxArray_real_T *b_cpu_trend;
  emxArray_real_T *b_cpu_v;
  emxArray_real_T *b_cpu_vright;
  emxArray_real_T *b_cpu_w;
  emxArray_real_T *b_cpu_wimag;
  emxArray_real_T *b_cpu_wreal;
  emxArray_real_T *b_cpu_x;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *b_cpu_z;
  emxArray_real_T *b_scale;
  emxArray_real_T *b_wi;
  emxArray_real_T *b_wr;
  emxArray_real_T *c_cpu_A;
  emxArray_real_T *c_cpu_B;
  emxArray_real_T *c_cpu_W;
  emxArray_real_T *c_cpu_absdiff;
  emxArray_real_T *c_cpu_b;
  emxArray_real_T *c_cpu_d;
  emxArray_real_T *c_cpu_r;
  emxArray_real_T *c_cpu_tau;
  emxArray_real_T *c_cpu_x;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_A;
  emxArray_real_T *cpu_B;
  emxArray_real_T *cpu_U;
  emxArray_real_T *cpu_W;
  emxArray_real_T *cpu_Y;
  emxArray_real_T *cpu_a;
  emxArray_real_T *cpu_absdiff;
  emxArray_real_T *cpu_b;
  emxArray_real_T *cpu_d;
  emxArray_real_T *cpu_dv1;
  emxArray_real_T *cpu_dv11;
  emxArray_real_T *cpu_dv2;
  emxArray_real_T *cpu_dv3;
  emxArray_real_T *cpu_dv7;
  emxArray_real_T *cpu_lin;
  emxArray_real_T *cpu_minval;
  emxArray_real_T *cpu_r;
  emxArray_real_T *cpu_rr;
  emxArray_real_T *cpu_tau;
  emxArray_real_T *cpu_trend;
  emxArray_real_T *cpu_v;
  emxArray_real_T *cpu_vright;
  emxArray_real_T *cpu_wimag;
  emxArray_real_T *cpu_wreal;
  emxArray_real_T *cpu_y;
  emxArray_real_T *cpu_yy;
  emxArray_real_T *cpu_z;
  emxArray_real_T *d_cpu_A;
  emxArray_real_T *d_cpu_B;
  emxArray_real_T *d_cpu_D;
  emxArray_real_T *d_cpu_V;
  emxArray_real_T *d_cpu_a;
  emxArray_real_T *d_cpu_r;
  emxArray_real_T *d_cpu_tau;
  emxArray_real_T *d_cpu_x;
  emxArray_real_T *d_cpu_y;
  emxArray_real_T *e_cpu_A;
  emxArray_real_T *e_cpu_V;
  emxArray_real_T *e_cpu_x;
  emxArray_real_T *e_cpu_y;
  emxArray_real_T *f_cpu_A;
  emxArray_real_T *f_cpu_V;
  emxArray_real_T *f_cpu_x;
  emxArray_real_T *f_cpu_y;
  emxArray_real_T *g_cpu_A;
  emxArray_real_T *g_cpu_x;
  emxArray_real_T *g_cpu_y;
  emxArray_real_T *h_cpu_A;
  emxArray_real_T *h_cpu_x;
  emxArray_real_T *h_cpu_y;
  emxArray_real_T *i_cpu_A;
  emxArray_real_T *i_cpu_x;
  emxArray_real_T *i_cpu_y;
  emxArray_real_T *j_cpu_A;
  emxArray_real_T *j_cpu_x;
  emxArray_real_T *j_cpu_y;
  emxArray_real_T *k_cpu_A;
  emxArray_real_T *l_cpu_A;
  emxArray_real_T *m_cpu_A;
  emxArray_real_T *n_cpu_A;
  emxArray_real_T *scale;
  emxArray_real_T *wi;
  emxArray_real_T *wr;
  real_T abnrm;
  real_T cpu_d2scaled;
  real_T rconde;
  real_T rcondv;
  real_T *gpu_d2scaled;
  int32_T i12[2];
  int32_T b_cpu_info;
  int32_T cpu_info;
  int32_T cpu_nx;
  int32_T i;
  int32_T *b_gpu_info;
  int32_T *gpu_info;
  int32_T *gpu_nx;
  uint32_T sz[2];
  boolean_T A_outdatedOnCpu;
  boolean_T A_outdatedOnGpu;
  boolean_T D_outdatedOnCpu;
  boolean_T D_outdatedOnGpu;
  boolean_T U_outdatedOnCpu;
  boolean_T U_outdatedOnGpu;
  boolean_T V_outdatedOnCpu;
  boolean_T V_outdatedOnGpu;
  boolean_T W_outdatedOnCpu;
  boolean_T W_outdatedOnGpu;
  boolean_T Y_outdatedOnCpu;
  boolean_T Y_outdatedOnGpu;
  boolean_T a_outdatedOnCpu;
  boolean_T a_outdatedOnGpu;
  boolean_T b_A_outdatedOnCpu;
  boolean_T b_A_outdatedOnGpu;
  boolean_T b_D_outdatedOnCpu;
  boolean_T b_D_outdatedOnGpu;
  boolean_T b_U_outdatedOnCpu;
  boolean_T b_U_outdatedOnGpu;
  boolean_T b_V_outdatedOnCpu;
  boolean_T b_V_outdatedOnGpu;
  boolean_T b_W_outdatedOnCpu;
  boolean_T b_W_outdatedOnGpu;
  boolean_T b_Y_outdatedOnCpu;
  boolean_T b_Y_outdatedOnGpu;
  boolean_T b_b_outdatedOnGpu;
  boolean_T b_d_outdatedOnCpu;
  boolean_T b_d_outdatedOnGpu;
  boolean_T b_ipiv_outdatedOnCpu;
  boolean_T b_jpvt_outdatedOnCpu;
  boolean_T b_jpvt_outdatedOnGpu;
  boolean_T b_outdatedOnCpu;
  boolean_T b_outdatedOnGpu;
  boolean_T b_r_outdatedOnCpu;
  boolean_T b_r_outdatedOnGpu;
  boolean_T b_rr_outdatedOnCpu;
  boolean_T b_rr_outdatedOnGpu;
  boolean_T b_tau_outdatedOnCpu;
  boolean_T b_vright_outdatedOnGpu;
  boolean_T b_w_outdatedOnCpu;
  boolean_T b_wimag_outdatedOnGpu;
  boolean_T b_wreal_outdatedOnGpu;
  boolean_T b_x_outdatedOnCpu;
  boolean_T b_x_outdatedOnGpu;
  boolean_T b_y_outdatedOnCpu;
  boolean_T b_y_outdatedOnGpu;
  boolean_T b_z_outdatedOnCpu;
  boolean_T b_z_outdatedOnGpu;
  boolean_T c_A_outdatedOnCpu;
  boolean_T c_D_outdatedOnCpu;
  boolean_T c_W_outdatedOnCpu;
  boolean_T c_b_outdatedOnGpu;
  boolean_T c_d_outdatedOnCpu;
  boolean_T c_d_outdatedOnGpu;
  boolean_T c_r_outdatedOnCpu;
  boolean_T c_tau_outdatedOnCpu;
  boolean_T c_tau_outdatedOnGpu;
  boolean_T c_x_outdatedOnCpu;
  boolean_T c_x_outdatedOnGpu;
  boolean_T c_y_outdatedOnCpu;
  boolean_T d_A_outdatedOnCpu;
  boolean_T d_D_outdatedOnCpu;
  boolean_T d_W_outdatedOnCpu;
  boolean_T d_outdatedOnCpu;
  boolean_T d_outdatedOnGpu;
  boolean_T d_tau_outdatedOnCpu;
  boolean_T d_x_outdatedOnCpu;
  boolean_T d_x_outdatedOnGpu;
  boolean_T d_y_outdatedOnCpu;
  boolean_T dv11_outdatedOnCpu;
  boolean_T dv1_outdatedOnCpu;
  boolean_T dv1_outdatedOnGpu;
  boolean_T dv3_outdatedOnCpu;
  boolean_T dv3_outdatedOnGpu;
  boolean_T dv7_outdatedOnCpu;
  boolean_T e_x_outdatedOnCpu;
  boolean_T e_x_outdatedOnGpu;
  boolean_T f_x_outdatedOnCpu;
  boolean_T f_x_outdatedOnGpu;
  boolean_T g_x_outdatedOnCpu;
  boolean_T g_x_outdatedOnGpu;
  boolean_T h_x_outdatedOnCpu;
  boolean_T h_x_outdatedOnGpu;
  boolean_T i_x_outdatedOnCpu;
  boolean_T i_x_outdatedOnGpu;
  boolean_T ipiv_outdatedOnCpu;
  boolean_T iv1_outdatedOnGpu;
  boolean_T iv_outdatedOnGpu;
  boolean_T jpvt_outdatedOnCpu;
  boolean_T jpvt_outdatedOnGpu;
  boolean_T minval_outdatedOnCpu;
  boolean_T r_outdatedOnCpu;
  boolean_T r_outdatedOnGpu;
  boolean_T rr_outdatedOnCpu;
  boolean_T rr_outdatedOnGpu;
  boolean_T tau_outdatedOnCpu;
  boolean_T tau_outdatedOnGpu;
  boolean_T trend_outdatedOnCpu;
  boolean_T trend_outdatedOnGpu;
  boolean_T vright_outdatedOnGpu;
  boolean_T w_outdatedOnCpu;
  boolean_T w_outdatedOnGpu;
  boolean_T wimag_outdatedOnGpu;
  boolean_T wreal_outdatedOnGpu;
  boolean_T x_outdatedOnCpu;
  boolean_T x_outdatedOnGpu;
  boolean_T y_outdatedOnCpu;
  boolean_T y_outdatedOnGpu;
  boolean_T yy_outdatedOnCpu;
  boolean_T yy_outdatedOnGpu;
  boolean_T z_outdatedOnCpu;
  boolean_T z_outdatedOnGpu;
  mwCudaMalloc(&gpu_info, 4UL);
  mwCudaMalloc(&b_gpu_info, 4UL);
  mwCudaMalloc(&gpu_d2scaled, 8UL);
  mwCudaMalloc(&gpu_nx, 4UL);
  gpuEmxReset_real_T(&c_gpu_a);
  gpuEmxReset_real_T(&b_gpu_trend);
  gpuEmxReset_real_T(&g_gpu_x);
  gpuEmxReset_real_T(&c_gpu_V);
  gpuEmxReset_real_T(&b_gpu_r);
  gpuEmxReset_real_T(&f_gpu_V);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_real_T(&b_gpu_absdiff);
  gpuEmxReset_real_T(&b_gpu_d);
  gpuEmxReset_int8_T(&d_gpu_a);
  gpuEmxReset_real_T(&g_gpu_y);
  gpuEmxReset_real_T(&b_gpu_b);
  gpuEmxReset_real_T(&e_gpu_y);
  gpuEmxReset_real_T(&f_gpu_y);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_int8_T(&b_gpu_a);
  gpuEmxReset_real_T(&gpu_yy);
  gpuEmxReset_real_T(&gpu_absdiff);
  gpuEmxReset_real_T(&gpu_d);
  gpuEmxReset_real_T(&gpu_dv11);
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
  gpuEmxReset_real_T(&b_gpu_tau);
  gpuEmxReset_real_T(&d_gpu_A);
  gpuEmxReset_real_T(&gpu_wreal);
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_creal_T(&b_gpu_W);
  gpuEmxReset_real_T(&gpu_U);
  gpuEmxReset_real_T(&c_gpu_A);
  gpuEmxReset_real_T(&g_gpu_A);
  gpuEmxReset_real_T(&j_gpu_y);
  gpuEmxReset_real_T(&c_gpu_absdiff);
  gpuEmxReset_real_T(&gpu_W);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_real_T(&c_gpu_d);
  gpuEmxReset_real_T(&b_gpu_D);
  gpuEmxReset_real_T(&gpu_v);
  gpuEmxReset_real_T(&gpu_dv7);
  gpuEmxReset_real_T(&b_gpu_V);
  gpuEmxReset_creal_T(&gpu_D);
  gpuEmxReset_real_T(&i_gpu_y);
  gpuEmxReset_real_T(&c_gpu_tau);
  gpuEmxReset_creal_T(&gpu_V);
  gpuEmxReset_int32_T(&b_gpu_ipiv_t);
  gpuEmxReset_int32_T(&b_gpu_jpvt);
  gpuEmxReset_real_T(&c_gpu_B);
  gpuEmxReset_int32_T(&b_gpu_ipiv);
  gpuEmxReset_real_T(&d_gpu_B);
  gpuEmxReset_real_T(&m_gpu_A);
  gpuEmxReset_real_T(&b_gpu_Y);
  gpuEmxReset_real_T(&gpu_A);
  gpuEmxReset_real_T(&b_gpu_A);
  gpuEmxReset_real_T(&gpu_rr);
  gpuEmxReset_real_T(&l_gpu_A);
  gpuEmxReset_real_T(&b_gpu_vright);
  gpuEmxReset_real_T(&b_gpu_wimag);
  gpuEmxReset_real_T(&d_gpu_tau);
  gpuEmxReset_real_T(&k_gpu_A);
  gpuEmxReset_real_T(&b_gpu_wreal);
  gpuEmxReset_real_T(&c_gpu_b);
  gpuEmxReset_creal_T(&d_gpu_W);
  gpuEmxReset_real_T(&b_gpu_U);
  gpuEmxReset_real_T(&j_gpu_A);
  gpuEmxReset_real_T(&e_gpu_x);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&n_gpu_A);
  gpuEmxReset_real_T(&gpu_dv3);
  gpuEmxReset_real_T(&c_gpu_W);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_real_T(&d_gpu_x);
  gpuEmxReset_real_T(&d_gpu_D);
  gpuEmxReset_real_T(&b_gpu_v);
  gpuEmxReset_real_T(&e_gpu_V);
  gpuEmxReset_creal_T(&c_gpu_D);
  gpuEmxReset_creal_T(&d_gpu_V);
  gpuEmxReset_real_T(&c_gpu_x);
  gpuEmxReset_real_T(&h_gpu_A);
  gpuEmxReset_real_T(&i_gpu_A);
  gpuEmxReset_real_T(&b_gpu_rr);
  gpuEmxReset_real_T(&d_gpu_r);
  gpuEmxReset_real_T(&gpu_dv2);
  gpuEmxReset_real_T(&gpu_z);
  gpuEmxReset_real_T(&j_gpu_x);
  gpuEmxReset_real_T(&gpu_lin);
  gpuEmxReset_real_T(&h_gpu_y);
  gpuEmxReset_real_T(&gpu_r);
  gpuEmxReset_real_T(&gpu_dv1);
  gpuEmxReset_real_T(&i_gpu_x);
  gpuEmxReset_real_T(&h_gpu_x);
  gpuEmxReset_real_T(&gpu_minval);
  gpuEmxReset_real_T(&b_gpu_z);
  gpuEmxReset_real_T(&b_gpu_lin);
  gpuEmxReset_real_T(&gpu_a);
  gpuEmxReset_real_T(&c_gpu_r);
  gpuEmxReset_real_T(&gpu_trend);
  gpuEmxReset_real_T(&f_gpu_x);
  gpuEmxReset_real_T(&b_gpu_w);
  gpuEmxReset_real_T(&b_gpu_x);
  gpuEmxReset_real_T(&gpu_w);
  gpuEmxReset_real_T(&gpu_x);
  c_d_outdatedOnCpu = false;
  c_d_outdatedOnGpu = false;
  d_y_outdatedOnCpu = false;
  b_y_outdatedOnGpu = false;
  b_outdatedOnCpu = false;
  c_b_outdatedOnGpu = false;
  c_y_outdatedOnCpu = false;
  y_outdatedOnGpu = false;
  yy_outdatedOnCpu = false;
  yy_outdatedOnGpu = false;
  b_d_outdatedOnCpu = false;
  b_d_outdatedOnGpu = false;
  dv11_outdatedOnCpu = false;
  d_tau_outdatedOnCpu = false;
  b_jpvt_outdatedOnCpu = false;
  b_jpvt_outdatedOnGpu = false;
  b_ipiv_outdatedOnCpu = false;
  d_A_outdatedOnCpu = false;
  b_Y_outdatedOnCpu = false;
  b_Y_outdatedOnGpu = false;
  b_vright_outdatedOnGpu = false;
  b_wimag_outdatedOnGpu = false;
  c_tau_outdatedOnCpu = false;
  c_tau_outdatedOnGpu = false;
  b_wreal_outdatedOnGpu = false;
  b_b_outdatedOnGpu = false;
  d_W_outdatedOnCpu = false;
  b_U_outdatedOnCpu = false;
  b_U_outdatedOnGpu = false;
  c_W_outdatedOnCpu = false;
  b_W_outdatedOnGpu = false;
  iv1_outdatedOnGpu = false;
  d_outdatedOnCpu = false;
  d_outdatedOnGpu = false;
  d_D_outdatedOnCpu = false;
  dv7_outdatedOnCpu = false;
  c_D_outdatedOnCpu = false;
  b_D_outdatedOnGpu = false;
  b_tau_outdatedOnCpu = false;
  b_V_outdatedOnCpu = false;
  b_V_outdatedOnGpu = false;
  jpvt_outdatedOnCpu = false;
  jpvt_outdatedOnGpu = false;
  ipiv_outdatedOnCpu = false;
  c_A_outdatedOnCpu = false;
  Y_outdatedOnCpu = false;
  Y_outdatedOnGpu = false;
  b_A_outdatedOnCpu = false;
  b_A_outdatedOnGpu = false;
  b_rr_outdatedOnCpu = false;
  b_rr_outdatedOnGpu = false;
  vright_outdatedOnGpu = false;
  wimag_outdatedOnGpu = false;
  tau_outdatedOnCpu = false;
  tau_outdatedOnGpu = false;
  wreal_outdatedOnGpu = false;
  b_outdatedOnGpu = false;
  b_W_outdatedOnCpu = false;
  U_outdatedOnCpu = false;
  U_outdatedOnGpu = false;
  i_x_outdatedOnCpu = false;
  i_x_outdatedOnGpu = false;
  b_y_outdatedOnCpu = false;
  dv3_outdatedOnCpu = false;
  dv3_outdatedOnGpu = false;
  W_outdatedOnCpu = false;
  W_outdatedOnGpu = false;
  iv_outdatedOnGpu = false;
  h_x_outdatedOnCpu = false;
  h_x_outdatedOnGpu = false;
  b_D_outdatedOnCpu = false;
  D_outdatedOnCpu = false;
  D_outdatedOnGpu = false;
  V_outdatedOnCpu = false;
  V_outdatedOnGpu = false;
  g_x_outdatedOnCpu = false;
  g_x_outdatedOnGpu = false;
  A_outdatedOnCpu = false;
  A_outdatedOnGpu = false;
  rr_outdatedOnCpu = false;
  rr_outdatedOnGpu = false;
  c_r_outdatedOnCpu = false;
  b_r_outdatedOnGpu = false;
  b_z_outdatedOnCpu = false;
  b_z_outdatedOnGpu = false;
  f_x_outdatedOnCpu = false;
  f_x_outdatedOnGpu = false;
  y_outdatedOnCpu = false;
  b_r_outdatedOnCpu = false;
  r_outdatedOnGpu = false;
  dv1_outdatedOnCpu = false;
  dv1_outdatedOnGpu = false;
  e_x_outdatedOnCpu = false;
  e_x_outdatedOnGpu = false;
  d_x_outdatedOnCpu = false;
  d_x_outdatedOnGpu = false;
  minval_outdatedOnCpu = false;
  z_outdatedOnCpu = false;
  z_outdatedOnGpu = false;
  a_outdatedOnCpu = false;
  a_outdatedOnGpu = false;
  r_outdatedOnCpu = false;
  trend_outdatedOnCpu = false;
  trend_outdatedOnGpu = false;
  c_x_outdatedOnCpu = false;
  c_x_outdatedOnGpu = false;
  b_w_outdatedOnCpu = false;
  b_x_outdatedOnCpu = false;
  b_x_outdatedOnGpu = false;
  w_outdatedOnCpu = false;
  w_outdatedOnGpu = true;
  x_outdatedOnCpu = false;
  x_outdatedOnGpu = true;
  dc.re = rtNaN;
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
  if (order < 1.0) {
    // 'ec_detrend:20' ;
    // 'ec_detrend:20' order=ones(1,"like",order);
    order = 1.0;
  }

  // 'ec_detrend:21' if thr<1
  if (thr < 1.0) {
    // 'ec_detrend:21' ;
    // 'ec_detrend:21' thr=ones(1,"like",thr);
    thr = 1.0;
  }

  // 'ec_detrend:22' if nItr<1
  if (nItr < 1.0) {
    // 'ec_detrend:22' ;
    // 'ec_detrend:22' nItr=ones(1,"like",nItr);
    nItr = 1.0;
  }

  //  Detrend per channel
  // 'ec_detrend:25' nChs = size(x,2);
  // 'ec_detrend:26' for ch = 1:nChs
  i = cpu_x->size[1];
  emxInit_real_T(&b_cpu_x, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_w, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_x, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&cpu_trend, 1, &h_emlrtRTEI, true);
  emxInit_real_T(&cpu_r, 2, &sd_emlrtRTEI, true);
  emxInit_real_T(&cpu_a, 1, &j_emlrtRTEI, true);
  emxInit_real_T(&cpu_lin, 2, &td_emlrtRTEI, true);
  emxInit_real_T(&cpu_z, 1, &ud_emlrtRTEI, true);
  emxInit_real_T(&cpu_minval, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_x, 1, &m_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_x, 1, &m_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv1, 1, &wd_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_r, 2, &sd_emlrtRTEI, true);
  emxInit_real_T(&cpu_y, 2, &xd_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_lin, 2, &td_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_x, 2, &m_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_z, 1, &ud_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv2, 2, &yd_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_r, 2, &ae_emlrtRTEI, true);
  emxInit_real_T(&cpu_rr, 2, &s_emlrtRTEI, true);
  emxInit_real_T(&cpu_A, 2, &tb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_A, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&g_cpu_x, 1, &m_emlrtRTEI, true);
  emxInit_creal_T(&cpu_V, 2, &tb_emlrtRTEI, true);
  emxInit_creal_T(&cpu_D, 2, &tb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_V, 2, &be_emlrtRTEI, true);
  emxInit_real_T(&cpu_v, 2, &bb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_D, 1, &ce_emlrtRTEI, true);
  emxInit_real_T(&h_cpu_x, 1, &m_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &de_emlrtRTEI, true);
  emxInit_real_T(&cpu_W, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv3, 1, &wd_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_A, 2, &kc_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_y, 2, &xd_emlrtRTEI, true);
  emxInit_real_T(&i_cpu_x, 2, &m_emlrtRTEI, true);
  emxInit_real_T(&scale, 1, &ee_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_A, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&cpu_U, 2, &tb_emlrtRTEI, true);
  emxInit_creal_T(&b_cpu_W, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&cpu_b, 2, &fe_emlrtRTEI, true);
  emxInit_real_T(&cpu_wreal, 1, &ge_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_A, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&cpu_tau, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&cpu_wimag, 1, &he_emlrtRTEI, true);
  emxInit_real_T(&cpu_vright, 2, &ie_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_A, 2, &tb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_rr, 2, &s_emlrtRTEI, true);
  emxInit_real_T(&g_cpu_A, 2, &tb_emlrtRTEI, true);
  emxInit_real_T(&h_cpu_A, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&cpu_Y, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&wr, 2, &ke_emlrtRTEI, true);
  emxInit_real_T(&i_cpu_A, 2, &tb_emlrtRTEI, true);
  emxInit_real_T(&cpu_B, 1, &rc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv, 2, &tb_emlrtRTEI, true);
  emxInit_real_T(&wi, 2, &le_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_B, 1, &sc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_jpvt, 2, &tb_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv_t, 1, &me_emlrtRTEI, true);
  emxInit_creal_T(&c_cpu_V, 2, &tb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_tau, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_y, 1, &ne_emlrtRTEI, true);
  emxInit_creal_T(&c_cpu_D, 2, &tb_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &wc_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_V, 2, &be_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv7, 1, &xc_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_v, 2, &bb_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_D, 1, &ce_emlrtRTEI, true);
  emxInit_real_T(&cpu_d, 1, &ad_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv1, 1, &de_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_W, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&cpu_absdiff, 1, &oe_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_y, 1, &pe_emlrtRTEI, true);
  emxInit_real_T(&j_cpu_A, 2, &kc_emlrtRTEI, true);
  emxInit_real_T(&b_scale, 1, &ee_emlrtRTEI, true);
  emxInit_real_T(&k_cpu_A, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_U, 2, &tb_emlrtRTEI, true);
  emxInit_creal_T(&d_cpu_W, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_b, 2, &fe_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_wreal, 1, &ge_emlrtRTEI, true);
  emxInit_real_T(&l_cpu_A, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_tau, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_wimag, 1, &he_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_vright, 2, &ie_emlrtRTEI, true);
  emxInit_real_T(&m_cpu_A, 2, &tb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_Y, 1, &je_emlrtRTEI, true);
  emxInit_real_T(&b_wr, 2, &ke_emlrtRTEI, true);
  emxInit_real_T(&n_cpu_A, 2, &tb_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_B, 1, &rc_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_ipiv, 2, &tb_emlrtRTEI, true);
  emxInit_real_T(&b_wi, 2, &le_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_B, 1, &sc_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_jpvt, 2, &tb_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_ipiv_t, 1, &me_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_tau, 1, &tb_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_y, 1, &ne_emlrtRTEI, true);
  emxInit_ptrdiff_t(&b_jpvt_t, 1, &wc_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv11, 1, &xc_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_d, 1, &ad_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_absdiff, 1, &oe_emlrtRTEI, true);
  emxInit_real_T(&cpu_yy, 1, &fd_emlrtRTEI, true);
  emxInit_int8_T(&b_cpu_a, 2, &gd_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_y, 2, &qe_emlrtRTEI, true);
  emxInit_real_T(&g_cpu_y, 2, &re_emlrtRTEI, true);
  emxInit_real_T(&h_cpu_y, 2, &se_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_b, 1, &kd_emlrtRTEI, true);
  emxInit_real_T(&i_cpu_y, 2, &te_emlrtRTEI, true);
  emxInit_int8_T(&c_cpu_a, 2, &id_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_d, 1, &rd_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_absdiff, 1, &oe_emlrtRTEI, true);
  emxInit_real_T(&j_cpu_y, 1, &ue_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_V, 2, &vb_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_r, 2, &bc_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_V, 2, &vb_emlrtRTEI, true);
  emxInit_real_T(&j_cpu_x, 1, &od_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_trend, 1, &pd_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_a, 1, &qd_emlrtRTEI, true);
  for (int32_T ch{0}; ch < i; ch++) {
    int32_T b_i;
    int32_T istart;
    int32_T jend;
    int32_T npages;
    int32_T vlen;
    boolean_T validLaunchParams;

    // 'ec_detrend:27' [x(:,ch),w(:,ch)] = detrendCh_lfn(x(:,ch),w(:,ch),order,thr,nItr,winSz);
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
    vlen = cpu_x->size[0];
    b_i = b_cpu_x->size[0];
    b_cpu_x->size[0] = vlen;
    emxEnsureCapacity_real_T(b_cpu_x, b_i, &b_emlrtRTEI);
    if (!b_x_outdatedOnGpu) {
      gpuEmxEnsureCapacity_real_T(b_cpu_x, &b_gpu_x);
    }

    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen), &grid,
      &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (x_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
      }

      x_outdatedOnGpu = false;
      if (b_x_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
      }

      ec_detrend_kernel1<<<grid, block>>>(ch, gpu_x, vlen, b_gpu_x, cpu_x->size
        [0U]);
      b_x_outdatedOnGpu = false;
      b_x_outdatedOnCpu = true;
    }

    // 'ec_detrend:46' w=squeeze(w);
    vlen = cpu_w->size[0];
    b_i = b_cpu_w->size[0];
    b_cpu_w->size[0] = vlen;
    emxEnsureCapacity_real_T(b_cpu_w, b_i, &c_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_cpu_w, &b_gpu_w);
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen), &grid,
      &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (w_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, cpu_w);
      }

      w_outdatedOnGpu = false;
      ec_detrend_kernel2<<<grid, block>>>(ch, gpu_w, vlen, b_gpu_w, cpu_w->size
        [0U]);
      b_w_outdatedOnCpu = true;
    }

    // 'ec_detrend:47' if ~nnz(w)
    npages = 0;
    istart = cpu_w->size[0];
    for (jend = 0; jend < istart; jend++) {
      if (w_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_w, &gpu_w);
      }

      w_outdatedOnCpu = false;
      if (cpu_w->data[jend + cpu_w->size[0] * ch] != 0.0) {
        npages++;
      }
    }

    if (npages == 0) {
      // 'ec_detrend:47' ;
      // 'ec_detrend:47' w(:)=1;
      b_i = b_cpu_w->size[0];
      b_cpu_w->size[0] = cpu_w->size[0];
      emxEnsureCapacity_real_T(b_cpu_w, b_i, &d_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_cpu_w, &b_gpu_w);
      b_i = cpu_w->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_detrend_kernel3<<<grid, block>>>(b_i, b_gpu_w);
        b_w_outdatedOnCpu = true;
      }
    }

    //  Run detrend
    // 'ec_detrend:50' if ~nnz(winSz)
    if (winSz != 0.0) {
      int32_T i13;
      int32_T i2;
      uint32_T dims_idx_0;

      // 'ec_detrend:53' else
      //  Overlapping window detrending
      // 'ec_detrend:55' [x,w] = detrendWin_lfn(x,w,order,thr,nItr,winSz);
      //  Detrend across overlapping time windows
      // 'ec_detrend:98' dims = size(x);
      b_i = cpu_x->size[0];
      dims_idx_0 = static_cast<uint32_T>(b_i);

      // 'ec_detrend:99' y = coder.nullcopy(zeros(size(x),'like',x));
      istart = c_cpu_x->size[0];
      c_cpu_x->size[0] = b_i;
      emxEnsureCapacity_real_T(c_cpu_x, istart, &e_emlrtRTEI);
      if (!c_x_outdatedOnGpu) {
        gpuEmxEnsureCapacity_real_T(c_cpu_x, &f_gpu_x);
      }

      //  1) divide into windows, 2) detrend each, 3) stitch together, 4) estimate w
      // 'ec_detrend:102' for iIter = 1:nItr
      i2 = static_cast<int32_T>(nItr);
      i13 = static_cast<int32_T>(order);
      for (int32_T iIter{0}; iIter < i2; iIter++) {
        real_T offset;
        real_T stop;
        int32_T r;

        // 'ec_detrend:103' trend = zeros(dims,'like',x);
        b_i = cpu_trend->size[0];
        cpu_trend->size[0] = static_cast<int32_T>(dims_idx_0);
        emxEnsureCapacity_real_T(cpu_trend, b_i, &h_emlrtRTEI);
        if (!trend_outdatedOnGpu) {
          gpuEmxEnsureCapacity_real_T(cpu_trend, &gpu_trend);
        }

        // 'ec_detrend:104' a = zeros(dims(1),1,'like',x);
        b_i = cpu_a->size[0];
        cpu_a->size[0] = static_cast<int32_T>(dims_idx_0);
        emxEnsureCapacity_real_T(cpu_a, b_i, &j_emlrtRTEI);
        if (!a_outdatedOnGpu) {
          gpuEmxEnsureCapacity_real_T(cpu_a, &gpu_a);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
          static_cast<int32_T>(dims_idx_0)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (a_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
          }

          if (trend_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, cpu_trend);
          }

          ec_detrend_kernel80<<<grid, block>>>(dims_idx_0, gpu_a, gpu_trend);
          trend_outdatedOnGpu = false;
          trend_outdatedOnCpu = true;
          a_outdatedOnGpu = false;
          a_outdatedOnCpu = true;
        }

        // 'ec_detrend:105' offset = 0;
        offset = 0.0;

        // 'ec_detrend:106' while true
        real_T start;
        do {
          real_T mn;
          real_T wsize2;
          int32_T b_i12;
          int32_T exitg1;
          int32_T i11;
          int32_T i7;
          int32_T ii;

          // 'ec_detrend:107' start = offset+1;
          start = offset + 1.0;

          // 'ec_detrend:108' stop = min(dims(1),offset+winSz);
          stop = std::fmin(static_cast<real_T>(dims_idx_0), offset + winSz);

          //  if not enough valid samples grow window:
          // 'ec_detrend:111' counter = 5;
          npages = 5;

          // 'ec_detrend:112' while any(sum(min(w(start:stop),2))) < winSz
          do {
            exitg1 = 0;
            if (start > stop) {
              jend = 1;
              istart = 0;
            } else {
              jend = static_cast<int32_T>(start);
              istart = static_cast<int32_T>(stop);
            }

            b_i = cpu_minval->size[0];
            cpu_minval->size[0] = (istart - jend) + 1;
            emxEnsureCapacity_real_T(cpu_minval, b_i, &n_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_minval, &gpu_minval);
            cpu_nx = istart - jend;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_nx + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel81<<<grid, block>>>(b_gpu_w, jend, cpu_nx,
                gpu_minval);
              minval_outdatedOnCpu = true;
            }

            vlen = cpu_minval->size[0];
            if (cpu_minval->size[0] == 0) {
              cpu_d2scaled = 0.0;
            } else {
              if (minval_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_minval, &gpu_minval);
              }

              minval_outdatedOnCpu = false;
              cpu_d2scaled = cpu_minval->data[0];
              for (b_i = 0; b_i <= vlen - 2; b_i++) {
                cpu_d2scaled += cpu_minval->data[b_i + 1];
              }
            }

            if ((cpu_d2scaled == 0.0) || std::isnan(cpu_d2scaled)) {
              validLaunchParams = true;
            } else {
              validLaunchParams = false;
            }

            if (((!validLaunchParams) < winSz) && (npages > 0)) {
              // 'ec_detrend:113' if counter <= 0
              // 'ec_detrend:114' start = max(1,start-winSz/2);
              start = std::fmax(1.0, start - winSz / 2.0);

              // 'ec_detrend:115' stop = min(dims(1),stop+winSz/2);
              stop = std::fmin(static_cast<real_T>(dims_idx_0), stop + winSz /
                               2.0);

              // 'ec_detrend:116' counter = counter-1;
              npages--;
            } else {
              exitg1 = 1;
            }
          } while (exitg1 == 0);

          // 'ec_detrend:113' ;
          // 'ec_detrend:118' if rem(stop-start+1,2)==1
          if (rt_remd_snf((stop - start) + 1.0, 2.0) == 1.0) {
            // 'ec_detrend:118' ;
            // 'ec_detrend:118' stop = stop-1;
            stop--;
          }

          // 'ec_detrend:119' wsize2 = stop-start+1;
          wsize2 = (stop - start) + 1.0;

          //  detrend this window
          // 'ec_detrend:122' yy = detrend_lfn(x(start:stop,:),w(start:stop,:),order,thr,1);
          if (start > stop) {
            i7 = 0;
            ii = 0;
            i11 = 1;
            b_i12 = 1;
          } else {
            i7 = static_cast<int32_T>(start) - 1;
            ii = static_cast<int32_T>(stop);
            i11 = static_cast<int32_T>(start);
            b_i12 = static_cast<int32_T>(stop) + 1;
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
          b_cpu_r->size[0] = ii - i7;
          b_cpu_r->size[1] = static_cast<int32_T>(order);
          emxEnsureCapacity_real_T(b_cpu_r, b_i, &f_emlrtRTEI);
          if (!r_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(b_cpu_r, &gpu_r);
          }

          // 'ec_detrend:76' lin = linspace(-1,1,nFrames);
          b_i = b_cpu_lin->size[0] * b_cpu_lin->size[1];
          b_cpu_lin->size[0] = 1;
          b_cpu_lin->size[1] = ii - i7;
          emxEnsureCapacity_real_T(b_cpu_lin, b_i, &i_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_lin, &gpu_lin);
          if (b_cpu_lin->size[1] >= 1) {
            ec_detrend_kernel82<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_lin,
              b_cpu_lin->size[1U]);
            if (b_cpu_lin->size[1] >= 2) {
              ec_detrend_kernel83<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (gpu_lin);
              if (b_cpu_lin->size[1] >= 3) {
                cpu_d2scaled = 1.0 / (static_cast<real_T>(b_cpu_lin->size[1]) -
                                      1.0);
                istart = b_cpu_lin->size[1];
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (istart - 2L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  ec_detrend_kernel84<<<grid, block>>>(cpu_d2scaled, istart,
                    gpu_lin, b_cpu_lin->size[1U]);
                }

                if ((b_cpu_lin->size[1] & 1) == 1) {
                  ec_detrend_kernel85<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (gpu_lin, b_cpu_lin->size[1U]);
                }
              }
            }
          }

          // 'ec_detrend:77' for k=1:order
          cpu_nx = b_cpu_lin->size[1];
          for (jend = 0; jend < i13; jend++) {
            // 'ec_detrend:78' r(:,k) = lin.^k;
            b_i = cpu_dv2->size[0] * cpu_dv2->size[1];
            cpu_dv2->size[0] = 1;
            cpu_dv2->size[1] = b_cpu_lin->size[1];
            emxEnsureCapacity_real_T(cpu_dv2, b_i, &n_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_dv2, &gpu_dv2);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (cpu_nx), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel86<<<grid, block>>>(jend, gpu_lin, cpu_nx,
                gpu_dv2);
            }

            vlen = b_cpu_r->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen),
              &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, b_cpu_r);
              }

              ec_detrend_kernel87<<<grid, block>>>(gpu_dv2, jend, vlen, gpu_r,
                b_cpu_r->size[0U]);
              r_outdatedOnGpu = false;
              b_r_outdatedOnCpu = true;
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
          if (ii - i7 == b_i12 - i11) {
            b_i = g_cpu_x->size[0];
            g_cpu_x->size[0] = ii - i7;
            emxEnsureCapacity_real_T(g_cpu_x, b_i, &m_emlrtRTEI);
            if (!g_x_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(g_cpu_x, &c_gpu_x);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ii -
              i7), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
              }

              b_x_outdatedOnGpu = false;
              if (g_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_x, g_cpu_x);
              }

              ec_detrend_kernel88<<<grid, block>>>(b_gpu_w, i11, b_gpu_x, i7, ii,
                c_gpu_x);
              g_x_outdatedOnGpu = false;
              g_x_outdatedOnCpu = true;
            }
          } else {
            if (g_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_cpu_x, &c_gpu_x);
            }

            if (b_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
            }

            b_x_outdatedOnCpu = false;
            if (b_w_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
            }

            b_w_outdatedOnCpu = false;
            binary_expand_op_20(g_cpu_x, b_cpu_x, i7, ii - 1, b_cpu_w, i11,
                                b_i12);
            g_x_outdatedOnCpu = false;
            g_x_outdatedOnGpu = true;
          }

          vlen = g_cpu_x->size[0];
          if (g_cpu_x->size[0] == 0) {
            cpu_d2scaled = 0.0;
          } else {
            if (g_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_cpu_x, &c_gpu_x);
            }

            g_x_outdatedOnCpu = false;
            cpu_d2scaled = g_cpu_x->data[0];
            for (b_i = 0; b_i <= vlen - 2; b_i++) {
              cpu_d2scaled += g_cpu_x->data[b_i + 1];
            }
          }

          vlen = b_i12 - i11;
          if (b_i12 - i11 == 0) {
            abnrm = 0.0;
          } else {
            if (b_w_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
            }

            b_w_outdatedOnCpu = false;
            abnrm = b_cpu_w->data[i11 - 1];
            for (b_i = 0; b_i <= vlen - 2; b_i++) {
              abnrm += b_cpu_w->data[i11 + b_i];
            }
          }

          mn = cpu_d2scaled / (abnrm + 2.2204460492503131E-16);

          // 'ec_detrend:188' x = x - mn;
          //  Fit weighted regression
          // 'ec_detrend:171' x = demean_lfn(x,w).* w;
          //  Demean
          // 'ec_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if (ii - i7 == b_i12 - i11) {
            b_i = h_cpu_x->size[0];
            h_cpu_x->size[0] = ii - i7;
            emxEnsureCapacity_real_T(h_cpu_x, b_i, &m_emlrtRTEI);
            if (!h_x_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(h_cpu_x, &d_gpu_x);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ii -
              i7), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
              }

              b_x_outdatedOnGpu = false;
              if (h_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_x, h_cpu_x);
              }

              ec_detrend_kernel89<<<grid, block>>>(b_gpu_w, i11, b_gpu_x, i7, ii,
                d_gpu_x);
              h_x_outdatedOnGpu = false;
              h_x_outdatedOnCpu = true;
            }
          } else {
            if (h_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_cpu_x, &d_gpu_x);
            }

            if (b_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
            }

            b_x_outdatedOnCpu = false;
            if (b_w_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
            }

            b_w_outdatedOnCpu = false;
            binary_expand_op_20(h_cpu_x, b_cpu_x, i7, ii - 1, b_cpu_w, i11,
                                b_i12);
            h_x_outdatedOnCpu = false;
            h_x_outdatedOnGpu = true;
          }

          vlen = h_cpu_x->size[0];
          if (h_cpu_x->size[0] == 0) {
            cpu_d2scaled = 0.0;
          } else {
            if (h_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_cpu_x, &d_gpu_x);
            }

            h_x_outdatedOnCpu = false;
            cpu_d2scaled = h_cpu_x->data[0];
            for (b_i = 0; b_i <= vlen - 2; b_i++) {
              cpu_d2scaled += h_cpu_x->data[b_i + 1];
            }
          }

          vlen = b_i12 - i11;
          if (b_i12 - i11 == 0) {
            abnrm = 0.0;
          } else {
            if (b_w_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
            }

            b_w_outdatedOnCpu = false;
            abnrm = b_cpu_w->data[i11 - 1];
            for (b_i = 0; b_i <= vlen - 2; b_i++) {
              abnrm += b_cpu_w->data[i11 + b_i];
            }
          }

          cpu_d2scaled /= abnrm + 2.2204460492503131E-16;

          // 'ec_detrend:188' x = x - mn;
          if (ii - i7 == b_i12 - i11) {
            b_i = cpu_dv3->size[0];
            cpu_dv3->size[0] = ii - i7;
            emxEnsureCapacity_real_T(cpu_dv3, b_i, &o_emlrtRTEI);
            if (!dv3_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(cpu_dv3, &gpu_dv3);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ii -
              i7), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
              }

              b_x_outdatedOnGpu = false;
              if (dv3_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv3, cpu_dv3);
              }

              ec_detrend_kernel90<<<grid, block>>>(b_gpu_w, i11, cpu_d2scaled,
                b_gpu_x, i7, ii, gpu_dv3);
              dv3_outdatedOnGpu = false;
              dv3_outdatedOnCpu = true;
            }
          } else {
            if (dv3_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_dv3, &gpu_dv3);
            }

            if (b_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
            }

            b_x_outdatedOnCpu = false;
            if (b_w_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
            }

            b_w_outdatedOnCpu = false;
            binary_expand_op_19(cpu_dv3, b_cpu_x, i7, ii - 1, cpu_d2scaled,
                                b_cpu_w, i11, b_i12);
            dv3_outdatedOnCpu = false;
            dv3_outdatedOnGpu = true;
          }

          // 'ec_detrend:172' r = demean_lfn(r,w);
          //  Demean
          // 'ec_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
          if (b_cpu_r->size[0] == b_i12 - i11) {
            b_i = i_cpu_x->size[0] * i_cpu_x->size[1];
            i_cpu_x->size[0] = b_cpu_r->size[0];
            i_cpu_x->size[1] = b_cpu_r->size[1];
            emxEnsureCapacity_real_T(i_cpu_x, b_i, &m_emlrtRTEI);
            if (!i_x_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(i_cpu_x, &e_gpu_x);
            }

            b_i = b_cpu_r->size[1] - 1;
            r = b_cpu_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((r +
              1L) * (b_i + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, b_cpu_r);
              }

              r_outdatedOnGpu = false;
              if (i_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_x, i_cpu_x);
              }

              ec_detrend_kernel91<<<grid, block>>>(b_gpu_w, i11, gpu_r, r, b_i,
                e_gpu_x, i_cpu_x->size[0U], b_cpu_r->size[0U]);
              i_x_outdatedOnGpu = false;
              i_x_outdatedOnCpu = true;
            }
          } else {
            if (i_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(i_cpu_x, &e_gpu_x);
            }

            if (b_r_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_r, &gpu_r);
            }

            b_r_outdatedOnCpu = false;
            if (b_w_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
            }

            b_w_outdatedOnCpu = false;
            binary_expand_op_16(i_cpu_x, b_cpu_r, b_cpu_w, i11, b_i12);
            i_x_outdatedOnCpu = false;
            i_x_outdatedOnGpu = true;
          }

          vlen = i_cpu_x->size[0];
          if ((i_cpu_x->size[0] == 0) || (i_cpu_x->size[1] == 0)) {
            for (b_i = 0; b_i < 2; b_i++) {
              sz[b_i] = static_cast<uint32_T>(i_cpu_x->size[b_i]);
            }

            b_i = b_cpu_y->size[0] * b_cpu_y->size[1];
            b_cpu_y->size[0] = 1;
            b_cpu_y->size[1] = static_cast<int32_T>(sz[1]);
            emxEnsureCapacity_real_T(b_cpu_y, b_i, &q_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_cpu_y, &gpu_y);
            b_i = static_cast<int32_T>(sz[1]) - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel93<<<grid, block>>>(static_cast<int32_T>(sz[1]) -
                1, gpu_y);
              b_y_outdatedOnCpu = true;
            }
          } else {
            npages = i_cpu_x->size[1];
            b_i = b_cpu_y->size[0] * b_cpu_y->size[1];
            b_cpu_y->size[0] = 1;
            b_cpu_y->size[1] = i_cpu_x->size[1];
            emxEnsureCapacity_real_T(b_cpu_y, b_i, &p_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_cpu_y, &gpu_y);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (i_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_x, i_cpu_x);
              }

              i_x_outdatedOnGpu = false;
              ec_detrend_kernel92<<<grid, block>>>(vlen, e_gpu_x, npages, gpu_y,
                i_cpu_x->size[0U]);
              b_y_outdatedOnCpu = true;
            }
          }

          vlen = b_i12 - i11;
          if (b_i12 - i11 == 0) {
            cpu_d2scaled = 0.0;
          } else {
            if (b_w_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
            }

            b_w_outdatedOnCpu = false;
            cpu_d2scaled = b_cpu_w->data[i11 - 1];
            for (b_i = 0; b_i <= vlen - 2; b_i++) {
              cpu_d2scaled += b_cpu_w->data[i11 + b_i];
            }
          }

          // 'ec_detrend:188' x = x - mn;
          if (b_cpu_r->size[1] == b_cpu_y->size[1]) {
            cpu_d2scaled += 2.2204460492503131E-16;
            b_i = d_cpu_r->size[0] * d_cpu_r->size[1];
            d_cpu_r->size[0] = b_cpu_r->size[0];
            d_cpu_r->size[1] = b_cpu_r->size[1];
            emxEnsureCapacity_real_T(d_cpu_r, b_i, &bc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_cpu_r, &b_gpu_r);
            b_i = b_cpu_r->size[1] - 1;
            r = b_cpu_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((r +
              1L) * (b_i + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, b_cpu_r);
              }

              r_outdatedOnGpu = false;
              ec_detrend_kernel94<<<grid, block>>>(cpu_d2scaled, gpu_y, gpu_r, r,
                b_i, b_gpu_r, d_cpu_r->size[0U], b_cpu_r->size[0U]);
            }

            b_i = b_cpu_r->size[0] * b_cpu_r->size[1];
            b_cpu_r->size[0] = d_cpu_r->size[0];
            b_cpu_r->size[1] = d_cpu_r->size[1];
            emxEnsureCapacity_real_T(b_cpu_r, b_i, &r_emlrtRTEI);
            if (!r_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_r, &gpu_r);
            }

            b_i = d_cpu_r->size[0] * d_cpu_r->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, b_cpu_r);
              }

              ec_detrend_kernel95<<<grid, block>>>(b_gpu_r, b_i, gpu_r);
              r_outdatedOnGpu = false;
              b_r_outdatedOnCpu = true;
            }
          } else {
            if (b_r_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_r, &gpu_r);
            }

            if (b_y_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_y, &gpu_y);
            }

            b_y_outdatedOnCpu = false;
            binary_expand_op_17(b_cpu_r, b_cpu_y, cpu_d2scaled);
            b_r_outdatedOnCpu = false;
            r_outdatedOnGpu = true;
          }

          //  remove channel-specific-weighted mean from regressor
          // 'ec_detrend:173' rr = r.*w;
          if (b_cpu_r->size[0] == b_i12 - i11) {
            b_i = b_cpu_rr->size[0] * b_cpu_rr->size[1];
            b_cpu_rr->size[0] = b_cpu_r->size[0];
            b_cpu_rr->size[1] = b_cpu_r->size[1];
            emxEnsureCapacity_real_T(b_cpu_rr, b_i, &s_emlrtRTEI);
            if (!b_rr_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_rr, &gpu_rr);
            }

            b_i = b_cpu_r->size[1] - 1;
            r = b_cpu_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((r +
              1L) * (b_i + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (r_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, b_cpu_r);
              }

              r_outdatedOnGpu = false;
              if (b_rr_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, b_cpu_rr);
              }

              ec_detrend_kernel96<<<grid, block>>>(b_gpu_w, i11, gpu_r, r, b_i,
                gpu_rr, b_cpu_rr->size[0U], b_cpu_r->size[0U]);
              b_rr_outdatedOnGpu = false;
              b_rr_outdatedOnCpu = true;
            }
          } else {
            if (b_rr_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_rr, &gpu_rr);
            }

            if (b_r_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_r, &gpu_r);
            }

            b_r_outdatedOnCpu = false;
            if (b_w_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
            }

            b_w_outdatedOnCpu = false;
            binary_expand_op_16(b_cpu_rr, b_cpu_r, b_cpu_w, i11, b_i12);
            b_rr_outdatedOnCpu = false;
            b_rr_outdatedOnGpu = true;
          }

          // 'ec_detrend:174' [V,D] = eig(rr'*rr);
          b_i = h_cpu_A->size[0] * h_cpu_A->size[1];
          h_cpu_A->size[0] = b_cpu_rr->size[1];
          h_cpu_A->size[1] = b_cpu_rr->size[0];
          emxEnsureCapacity_real_T(h_cpu_A, b_i, &t_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(h_cpu_A, &gpu_A);
          r = b_cpu_rr->size[0] - 1;
          b_i = b_cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i +
            1L) * (r + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_rr_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, b_cpu_rr);
            }

            b_rr_outdatedOnGpu = false;
            ec_detrend_kernel97<<<grid, block>>>(gpu_rr, b_i, r, gpu_A,
              h_cpu_A->size[0U], b_cpu_rr->size[0U]);
          }

          if ((h_cpu_A->size[0] == 0) || (h_cpu_A->size[1] == 0) ||
              (b_cpu_rr->size[0] == 0) || (b_cpu_rr->size[1] == 0)) {
            b_i = g_cpu_A->size[0] * g_cpu_A->size[1];
            g_cpu_A->size[0] = h_cpu_A->size[0];
            g_cpu_A->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real_T(g_cpu_A, b_i, &v_emlrtRTEI);
            if (!b_A_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(g_cpu_A, &b_gpu_A);
            }

            r = h_cpu_A->size[0] * b_cpu_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_A_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, g_cpu_A);
              }

              ec_detrend_kernel98<<<grid, block>>>(r, b_gpu_A);
              b_A_outdatedOnGpu = false;
              b_A_outdatedOnCpu = true;
            }
          } else {
            b_i = g_cpu_A->size[0] * g_cpu_A->size[1];
            g_cpu_A->size[0] = h_cpu_A->size[0];
            g_cpu_A->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real_T(g_cpu_A, b_i, &u_emlrtRTEI);
            if (!b_A_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(g_cpu_A, &b_gpu_A);
            }

            cpu_d2scaled = 1.0;
            abnrm = 0.0;
            if (b_rr_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, b_cpu_rr);
            }

            b_rr_outdatedOnGpu = false;
            if (b_A_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, g_cpu_A);
            }

            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        h_cpu_A->size[0], b_cpu_rr->size[1], h_cpu_A->size[1],
                        (double *)&cpu_d2scaled, (double *)&gpu_A.data[0],
                        h_cpu_A->size[0], (double *)&gpu_rr.data[0],
                        h_cpu_A->size[1], (double *)&abnrm, (double *)
                        &b_gpu_A.data[0], h_cpu_A->size[0]);
            b_A_outdatedOnGpu = false;
            b_A_outdatedOnCpu = true;
          }

          npages = g_cpu_A->size[0];
          b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
          c_cpu_V->size[0] = g_cpu_A->size[0];
          c_cpu_V->size[1] = g_cpu_A->size[0];
          emxEnsureCapacity_creal_T(c_cpu_V, b_i, &w_emlrtRTEI);
          if (!b_V_outdatedOnGpu) {
            gpuEmxEnsureCapacity_creal_T(c_cpu_V, &gpu_V);
          }

          b_i = c_cpu_D->size[0] * c_cpu_D->size[1];
          c_cpu_D->size[0] = g_cpu_A->size[0];
          c_cpu_D->size[1] = g_cpu_A->size[0];
          emxEnsureCapacity_creal_T(c_cpu_D, b_i, &x_emlrtRTEI);
          if (!b_D_outdatedOnGpu) {
            gpuEmxEnsureCapacity_creal_T(c_cpu_D, &gpu_D);
          }

          if ((g_cpu_A->size[0] != 0) && (g_cpu_A->size[1] != 0)) {
            cpu_nx = g_cpu_A->size[0] * g_cpu_A->size[1];
            validLaunchParams = true;
            for (jend = 0; jend < cpu_nx; jend++) {
              if (validLaunchParams) {
                if (b_A_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &b_gpu_A);
                }

                b_A_outdatedOnCpu = false;
                if (std::isinf(g_cpu_A->data[jend]) || std::isnan(g_cpu_A->
                     data[jend])) {
                  validLaunchParams = false;
                }
              } else {
                validLaunchParams = false;
              }
            }

            if (!validLaunchParams) {
              for (b_i = 0; b_i < 2; b_i++) {
                i12[b_i] = c_cpu_V->size[b_i];
              }

              b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
              c_cpu_V->size[0] = i12[0];
              c_cpu_V->size[1] = i12[1];
              emxEnsureCapacity_creal_T(c_cpu_V, b_i, &ab_emlrtRTEI);
              if (!b_V_outdatedOnGpu) {
                gpuEmxEnsureCapacity_creal_T(c_cpu_V, &gpu_V);
              }

              b_i = i12[0] * i12[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (b_i + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_V_outdatedOnGpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, c_cpu_V);
                }

                ec_detrend_kernel121<<<grid, block>>>(dc, b_i, gpu_V);
                b_V_outdatedOnGpu = false;
                b_V_outdatedOnCpu = true;
              }

              for (b_i = 0; b_i < 2; b_i++) {
                i12[b_i] = c_cpu_D->size[b_i];
              }

              b_i = c_cpu_D->size[0] * c_cpu_D->size[1];
              c_cpu_D->size[0] = i12[0];
              c_cpu_D->size[1] = i12[1];
              emxEnsureCapacity_creal_T(c_cpu_D, b_i, &fb_emlrtRTEI);
              if (!b_D_outdatedOnGpu) {
                gpuEmxEnsureCapacity_creal_T(c_cpu_D, &gpu_D);
              }

              b_i = i12[0] * i12[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (b_i + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_D_outdatedOnGpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, c_cpu_D);
                }

                ec_detrend_kernel122<<<grid, block>>>(b_i, gpu_D);
                b_D_outdatedOnGpu = false;
                c_D_outdatedOnCpu = true;
              }

              for (jend = 0; jend < npages; jend++) {
                if (c_D_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_creal_T(c_cpu_D, &gpu_D);
                }

                c_cpu_D->data[jend + c_cpu_D->size[0] * jend] = dc;
                c_D_outdatedOnCpu = false;
                b_D_outdatedOnGpu = true;
              }
            } else {
              boolean_T exitg2;
              validLaunchParams = (g_cpu_A->size[0] == g_cpu_A->size[1]);
              if (validLaunchParams) {
                cpu_nx = 0;
                exitg2 = false;
                while ((!exitg2) && (cpu_nx <= g_cpu_A->size[1] - 1)) {
                  b_i = 0;
                  do {
                    exitg1 = 0;
                    if (b_i <= cpu_nx) {
                      if (b_A_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &b_gpu_A);
                      }

                      b_A_outdatedOnCpu = false;
                      if (!(g_cpu_A->data[b_i + g_cpu_A->size[0] * cpu_nx] ==
                            g_cpu_A->data[cpu_nx + g_cpu_A->size[0] * b_i])) {
                        validLaunchParams = false;
                        exitg1 = 1;
                      } else {
                        b_i++;
                      }
                    } else {
                      cpu_nx++;
                      exitg1 = 2;
                    }
                  } while (exitg1 == 0);

                  if (exitg1 == 1) {
                    exitg2 = true;
                  }
                }
              }

              if (validLaunchParams) {
                ptrdiff_t c_n_t;
                ptrdiff_t f_info_t;
                npages = g_cpu_A->size[0];
                c_n_t = (ptrdiff_t)g_cpu_A->size[0];
                b_i = c_cpu_W->size[0];
                c_cpu_W->size[0] = g_cpu_A->size[0];
                emxEnsureCapacity_real_T(c_cpu_W, b_i, &cb_emlrtRTEI);
                if (!b_W_outdatedOnGpu) {
                  gpuEmxEnsureCapacity_real_T(c_cpu_W, &gpu_W);
                }

                if (b_A_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &b_gpu_A);
                }

                if (c_W_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_cpu_W, &gpu_W);
                }

                f_info_t = LAPACKE_dsyev(102, 'V', 'L', c_n_t, &g_cpu_A->data[0],
                  c_n_t, &c_cpu_W->data[0]);
                c_W_outdatedOnCpu = false;
                b_W_outdatedOnGpu = true;
                b_A_outdatedOnCpu = false;
                b_A_outdatedOnGpu = true;
                if ((int32_T)f_info_t < 0) {
                  vlen = c_cpu_W->size[0];
                  b_i = c_cpu_W->size[0];
                  c_cpu_W->size[0] = vlen;
                  emxEnsureCapacity_real_T(c_cpu_W, b_i, &jb_emlrtRTEI);
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (vlen), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&gpu_W, c_cpu_W);
                    ec_detrend_kernel117<<<grid, block>>>(vlen, gpu_W);
                    b_W_outdatedOnGpu = false;
                    c_W_outdatedOnCpu = true;
                  }

                  for (b_i = 0; b_i < 2; b_i++) {
                    i12[b_i] = g_cpu_A->size[b_i];
                  }

                  b_i = g_cpu_A->size[0] * g_cpu_A->size[1];
                  g_cpu_A->size[0] = i12[0];
                  g_cpu_A->size[1] = i12[1];
                  emxEnsureCapacity_real_T(g_cpu_A, b_i, &qb_emlrtRTEI);
                  b_i = i12[0] * i12[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, g_cpu_A);
                    ec_detrend_kernel118<<<grid, block>>>(b_i, b_gpu_A);
                    b_A_outdatedOnGpu = false;
                    b_A_outdatedOnCpu = true;
                  }
                }

                b_i = c_cpu_D->size[0] * c_cpu_D->size[1];
                c_cpu_D->size[0] = npages;
                c_cpu_D->size[1] = npages;
                emxEnsureCapacity_creal_T(c_cpu_D, b_i, &ib_emlrtRTEI);
                if (!b_D_outdatedOnGpu) {
                  gpuEmxEnsureCapacity_creal_T(c_cpu_D, &gpu_D);
                }

                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (npages * npages), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_D_outdatedOnGpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, c_cpu_D);
                  }

                  ec_detrend_kernel119<<<grid, block>>>(npages, gpu_D);
                  b_D_outdatedOnGpu = false;
                  c_D_outdatedOnCpu = true;
                }

                for (b_i = 0; b_i < npages; b_i++) {
                  if (c_D_outdatedOnCpu) {
                    gpuEmxMemcpyGpuToCpu_creal_T(c_cpu_D, &gpu_D);
                  }

                  if (c_W_outdatedOnCpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(c_cpu_W, &gpu_W);
                  }

                  c_W_outdatedOnCpu = false;
                  c_cpu_D->data[b_i + c_cpu_D->size[0] * b_i].re = c_cpu_W->
                    data[b_i];
                  c_cpu_D->data[b_i + c_cpu_D->size[0] * b_i].im = 0.0;
                  c_D_outdatedOnCpu = false;
                  b_D_outdatedOnGpu = true;
                }

                b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
                c_cpu_V->size[0] = g_cpu_A->size[0];
                c_cpu_V->size[1] = g_cpu_A->size[1];
                emxEnsureCapacity_creal_T(c_cpu_V, b_i, &rb_emlrtRTEI);
                if (!b_V_outdatedOnGpu) {
                  gpuEmxEnsureCapacity_creal_T(c_cpu_V, &gpu_V);
                }

                r = g_cpu_A->size[0] * g_cpu_A->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (r + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (b_A_outdatedOnGpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, g_cpu_A);
                  }

                  b_A_outdatedOnGpu = false;
                  if (b_V_outdatedOnGpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, c_cpu_V);
                  }

                  ec_detrend_kernel120<<<grid, block>>>(b_gpu_A, r, gpu_V);
                  b_V_outdatedOnGpu = false;
                  b_V_outdatedOnCpu = true;
                }
              } else {
                validLaunchParams = (g_cpu_A->size[0] == g_cpu_A->size[1]);
                if (validLaunchParams) {
                  cpu_nx = 0;
                  exitg2 = false;
                  while ((!exitg2) && (cpu_nx <= g_cpu_A->size[1] - 1)) {
                    b_i = 0;
                    do {
                      exitg1 = 0;
                      if (b_i <= cpu_nx) {
                        if (b_A_outdatedOnCpu) {
                          gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &b_gpu_A);
                        }

                        b_A_outdatedOnCpu = false;
                        if (!(g_cpu_A->data[b_i + g_cpu_A->size[0] * cpu_nx] ==
                              -g_cpu_A->data[cpu_nx + g_cpu_A->size[0] * b_i]))
                        {
                          validLaunchParams = false;
                          exitg1 = 1;
                        } else {
                          b_i++;
                        }
                      } else {
                        cpu_nx++;
                        exitg1 = 2;
                      }
                    } while (exitg1 == 0);

                    if (exitg1 == 1) {
                      exitg2 = true;
                    }
                  }
                }

                if (validLaunchParams) {
                  cpu_nx = g_cpu_A->size[0] * g_cpu_A->size[1];
                  for (jend = 0; jend < cpu_nx; jend++) {
                    if (validLaunchParams) {
                      if (b_A_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &b_gpu_A);
                      }

                      b_A_outdatedOnCpu = false;
                      if (std::isinf(g_cpu_A->data[jend]) || std::isnan
                          (g_cpu_A->data[jend])) {
                        validLaunchParams = false;
                      }
                    } else {
                      validLaunchParams = false;
                    }
                  }

                  if (!validLaunchParams) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      sz[b_i] = static_cast<uint32_T>(g_cpu_A->size[b_i]);
                    }

                    b_i = b_cpu_U->size[0] * b_cpu_U->size[1];
                    b_cpu_U->size[0] = static_cast<int32_T>(sz[0]);
                    b_cpu_U->size[1] = static_cast<int32_T>(sz[1]);
                    emxEnsureCapacity_real_T(b_cpu_U, b_i, &nb_emlrtRTEI);
                    if (!b_U_outdatedOnGpu) {
                      gpuEmxEnsureCapacity_real_T(b_cpu_U, &gpu_U);
                    }

                    b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz
                      [1]) - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      if (b_U_outdatedOnGpu) {
                        gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, b_cpu_U);
                      }

                      ec_detrend_kernel112<<<grid, block>>>(b_i, gpu_U);
                      b_U_outdatedOnGpu = false;
                      b_U_outdatedOnCpu = true;
                    }

                    vlen = static_cast<int32_T>(sz[0]);
                    if (static_cast<int32_T>(sz[0]) > 1) {
                      istart = 2;
                      if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>
                          (sz[1]) - 1) {
                        jend = static_cast<int32_T>(sz[0]) - 1;
                      } else {
                        jend = static_cast<int32_T>(sz[1]);
                      }

                      for (cpu_nx = 0; cpu_nx < jend; cpu_nx++) {
                        validLaunchParams = mwGetLaunchParameters1D
                          (static_cast<real_T>(computeEndIdx(static_cast<int64_T>
                             (istart), static_cast<int64_T>(vlen), 1L) + 1L),
                           &grid, &block, 1024U, 65535U);
                        if (validLaunchParams) {
                          if (b_U_outdatedOnGpu) {
                            gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, b_cpu_U);
                          }

                          ec_detrend_kernel113<<<grid, block>>>(cpu_nx + 1, vlen,
                            istart, gpu_U, b_cpu_U->size[0U]);
                          b_U_outdatedOnGpu = false;
                          b_U_outdatedOnCpu = true;
                        }

                        istart++;
                      }
                    }

                    for (b_i = 0; b_i < 2; b_i++) {
                      sz[b_i] = static_cast<uint32_T>(g_cpu_A->size[b_i]);
                    }

                    b_i = g_cpu_A->size[0] * g_cpu_A->size[1];
                    g_cpu_A->size[0] = static_cast<int32_T>(sz[0]);
                    g_cpu_A->size[1] = static_cast<int32_T>(sz[1]);
                    emxEnsureCapacity_real_T(g_cpu_A, b_i, &wb_emlrtRTEI);
                    if (!b_A_outdatedOnGpu) {
                      gpuEmxEnsureCapacity_real_T(g_cpu_A, &b_gpu_A);
                    }

                    b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz
                      [1]) - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      if (b_A_outdatedOnGpu) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, g_cpu_A);
                      }

                      ec_detrend_kernel114<<<grid, block>>>(b_i, b_gpu_A);
                      b_A_outdatedOnGpu = false;
                      b_A_outdatedOnCpu = true;
                    }
                  } else {
                    ptrdiff_t d_n_t;
                    ptrdiff_t j_info_t;
                    npages = g_cpu_A->size[0];
                    b_i = c_cpu_tau->size[0];
                    c_cpu_tau->size[0] = g_cpu_A->size[0] - 1;
                    emxEnsureCapacity_real_T(c_cpu_tau, b_i, &kb_emlrtRTEI);
                    if (!c_tau_outdatedOnGpu) {
                      gpuEmxEnsureCapacity_real_T(c_cpu_tau, &b_gpu_tau);
                    }

                    if (g_cpu_A->size[0] > 1) {
                      ptrdiff_t g_info_t;
                      if (b_A_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &b_gpu_A);
                      }

                      if (c_tau_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(c_cpu_tau, &b_gpu_tau);
                      }

                      g_info_t = LAPACKE_dgehrd(102, (ptrdiff_t)g_cpu_A->size[0],
                        (ptrdiff_t)1, (ptrdiff_t)g_cpu_A->size[0],
                        &g_cpu_A->data[0], (ptrdiff_t)g_cpu_A->size[0],
                        &c_cpu_tau->data[0]);
                      c_tau_outdatedOnCpu = false;
                      c_tau_outdatedOnGpu = true;
                      b_A_outdatedOnCpu = false;
                      b_A_outdatedOnGpu = true;
                      if ((int32_T)g_info_t != 0) {
                        for (b_i = 0; b_i < 2; b_i++) {
                          i12[b_i] = g_cpu_A->size[b_i];
                        }

                        b_i = g_cpu_A->size[0] * g_cpu_A->size[1];
                        g_cpu_A->size[0] = i12[0];
                        g_cpu_A->size[1] = i12[1];
                        emxEnsureCapacity_real_T(g_cpu_A, b_i, &ub_emlrtRTEI);
                        b_i = i12[0] * i12[1] - 1;
                        validLaunchParams = mwGetLaunchParameters1D(static_cast<
                          real_T>(b_i + 1L), &grid, &block, 1024U, 65535U);
                        if (validLaunchParams) {
                          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, g_cpu_A);
                          ec_detrend_kernel105<<<grid, block>>>(b_i, b_gpu_A);
                          b_A_outdatedOnGpu = false;
                          b_A_outdatedOnCpu = true;
                        }

                        vlen = c_cpu_tau->size[0];
                        b_i = c_cpu_tau->size[0];
                        c_cpu_tau->size[0] = vlen;
                        emxEnsureCapacity_real_T(c_cpu_tau, b_i, &yb_emlrtRTEI);
                        validLaunchParams = mwGetLaunchParameters1D
                          (static_cast<real_T>(vlen), &grid, &block, 1024U,
                           65535U);
                        if (validLaunchParams) {
                          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_tau, c_cpu_tau);
                          ec_detrend_kernel106<<<grid, block>>>(vlen, b_gpu_tau);
                          c_tau_outdatedOnGpu = false;
                          c_tau_outdatedOnCpu = true;
                        }
                      }
                    }

                    b_i = b_cpu_U->size[0] * b_cpu_U->size[1];
                    b_cpu_U->size[0] = g_cpu_A->size[0];
                    b_cpu_U->size[1] = g_cpu_A->size[1];
                    emxEnsureCapacity_real_T(b_cpu_U, b_i, &pb_emlrtRTEI);
                    if (!b_U_outdatedOnGpu) {
                      gpuEmxEnsureCapacity_real_T(b_cpu_U, &gpu_U);
                    }

                    r = g_cpu_A->size[0] * g_cpu_A->size[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(r + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      if (b_A_outdatedOnGpu) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, g_cpu_A);
                      }

                      if (b_U_outdatedOnGpu) {
                        gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, b_cpu_U);
                      }

                      ec_detrend_kernel107<<<grid, block>>>(b_gpu_A, r, gpu_U);
                      b_U_outdatedOnGpu = false;
                      b_U_outdatedOnCpu = true;
                    }

                    if (npages == 1) {
                      if (b_U_outdatedOnGpu) {
                        gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, b_cpu_U);
                      }

                      ec_detrend_kernel109<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                        (gpu_U);
                      b_U_outdatedOnCpu = true;
                    } else {
                      ptrdiff_t h_info_t;
                      if (b_U_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(b_cpu_U, &gpu_U);
                      }

                      if (c_tau_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(c_cpu_tau, &b_gpu_tau);
                      }

                      c_tau_outdatedOnCpu = false;
                      h_info_t = LAPACKE_dorghr(102, (ptrdiff_t)npages,
                        (ptrdiff_t)1, (ptrdiff_t)npages, &b_cpu_U->data[0],
                        (ptrdiff_t)npages, &c_cpu_tau->data[0]);
                      b_U_outdatedOnCpu = false;
                      if ((int32_T)h_info_t != 0) {
                        for (b_i = 0; b_i < 2; b_i++) {
                          i12[b_i] = b_cpu_U->size[b_i];
                        }

                        b_i = b_cpu_U->size[0] * b_cpu_U->size[1];
                        b_cpu_U->size[0] = i12[0];
                        b_cpu_U->size[1] = i12[1];
                        emxEnsureCapacity_real_T(b_cpu_U, b_i, &pb_emlrtRTEI);
                        b_i = i12[0] * i12[1] - 1;
                        validLaunchParams = mwGetLaunchParameters1D(static_cast<
                          real_T>(b_i + 1L), &grid, &block, 1024U, 65535U);
                        if (validLaunchParams) {
                          gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, b_cpu_U);
                          ec_detrend_kernel108<<<grid, block>>>(b_i, gpu_U);
                          b_U_outdatedOnCpu = true;
                        }
                      }
                    }

                    d_n_t = (ptrdiff_t)g_cpu_A->size[0];
                    b_i = b_wr->size[0] * b_wr->size[1];
                    b_wr->size[0] = 1;
                    b_wr->size[1] = g_cpu_A->size[0];
                    emxEnsureCapacity_real_T(b_wr, b_i, &xb_emlrtRTEI);
                    b_i = b_wi->size[0] * b_wi->size[1];
                    b_wi->size[0] = 1;
                    b_wi->size[1] = g_cpu_A->size[0];
                    emxEnsureCapacity_real_T(b_wi, b_i, &cc_emlrtRTEI);
                    if (b_A_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &b_gpu_A);
                    }

                    if (b_U_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(b_cpu_U, &gpu_U);
                    }

                    if (g_cpu_A->size[0] <= 1) {
                      r = 1;
                    } else {
                      r = g_cpu_A->size[0];
                    }

                    j_info_t = LAPACKE_dhseqr(102, 'S', 'V', d_n_t, (ptrdiff_t)1,
                      (ptrdiff_t)g_cpu_A->size[0], &g_cpu_A->data[0], d_n_t,
                      &b_wr->data[0], &b_wi->data[0], &b_cpu_U->data[0],
                      (ptrdiff_t)r);
                    b_U_outdatedOnCpu = false;
                    b_U_outdatedOnGpu = true;
                    b_A_outdatedOnCpu = false;
                    b_A_outdatedOnGpu = true;
                    if ((int32_T)j_info_t < 0) {
                      for (b_i = 0; b_i < 2; b_i++) {
                        i12[b_i] = g_cpu_A->size[b_i];
                      }

                      b_i = g_cpu_A->size[0] * g_cpu_A->size[1];
                      g_cpu_A->size[0] = i12[0];
                      g_cpu_A->size[1] = i12[1];
                      emxEnsureCapacity_real_T(g_cpu_A, b_i, &hc_emlrtRTEI);
                      b_i = i12[0] * i12[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, g_cpu_A);
                        ec_detrend_kernel110<<<grid, block>>>(b_i, b_gpu_A);
                        b_A_outdatedOnGpu = false;
                        b_A_outdatedOnCpu = true;
                      }

                      for (b_i = 0; b_i < 2; b_i++) {
                        i12[b_i] = b_cpu_U->size[b_i];
                      }

                      b_i = b_cpu_U->size[0] * b_cpu_U->size[1];
                      b_cpu_U->size[0] = i12[0];
                      b_cpu_U->size[1] = i12[1];
                      emxEnsureCapacity_real_T(b_cpu_U, b_i, &lc_emlrtRTEI);
                      b_i = i12[0] * i12[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D(static_cast<
                        real_T>(b_i + 1L), &grid, &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, b_cpu_U);
                        ec_detrend_kernel111<<<grid, block>>>(b_i, gpu_U);
                        b_U_outdatedOnGpu = false;
                        b_U_outdatedOnCpu = true;
                      }
                    }
                  }

                  npages = g_cpu_A->size[0];
                  b_i = c_cpu_D->size[0] * c_cpu_D->size[1];
                  c_cpu_D->size[0] = g_cpu_A->size[0];
                  c_cpu_D->size[1] = g_cpu_A->size[0];
                  emxEnsureCapacity_creal_T(c_cpu_D, b_i, &fc_emlrtRTEI);
                  if (!b_D_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_creal_T(c_cpu_D, &gpu_D);
                  }

                  r = g_cpu_A->size[0] * g_cpu_A->size[0] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (r + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (b_D_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, c_cpu_D);
                    }

                    ec_detrend_kernel115<<<grid, block>>>(r, gpu_D);
                    b_D_outdatedOnGpu = false;
                    c_D_outdatedOnCpu = true;
                  }

                  b_i = 1;
                  do {
                    exitg1 = 0;
                    if (b_i <= npages) {
                      if (b_i != npages) {
                        if (b_A_outdatedOnCpu) {
                          gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &b_gpu_A);
                        }

                        b_A_outdatedOnCpu = false;
                        if (g_cpu_A->data[b_i + g_cpu_A->size[0] * (b_i - 1)] !=
                            0.0) {
                          cpu_d2scaled = std::abs(g_cpu_A->data[b_i +
                            g_cpu_A->size[0] * (b_i - 1)]);
                          if (c_D_outdatedOnCpu) {
                            gpuEmxMemcpyGpuToCpu_creal_T(c_cpu_D, &gpu_D);
                          }

                          c_cpu_D->data[(b_i + c_cpu_D->size[0] * (b_i - 1)) - 1]
                            .re = 0.0;
                          c_cpu_D->data[(b_i + c_cpu_D->size[0] * (b_i - 1)) - 1]
                            .im = cpu_d2scaled;
                          c_cpu_D->data[b_i + c_cpu_D->size[0] * b_i].re = 0.0;
                          c_cpu_D->data[b_i + c_cpu_D->size[0] * b_i].im =
                            -cpu_d2scaled;
                          c_D_outdatedOnCpu = false;
                          b_D_outdatedOnGpu = true;
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
                  emxEnsureCapacity_creal_T(c_cpu_V, b_i, &jc_emlrtRTEI);
                  if (!b_V_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_creal_T(c_cpu_V, &gpu_V);
                  }

                  b_i = b_cpu_U->size[0] * b_cpu_U->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (b_U_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_U, b_cpu_U);
                    }

                    b_U_outdatedOnGpu = false;
                    if (b_V_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, c_cpu_V);
                    }

                    ec_detrend_kernel116<<<grid, block>>>(gpu_U, b_i, gpu_V);
                    b_V_outdatedOnGpu = false;
                    b_V_outdatedOnCpu = true;
                  }

                  cpu_nx = 1;
                  npages = g_cpu_A->size[0];
                  do {
                    exitg1 = 0;
                    if (cpu_nx <= npages) {
                      if (cpu_nx != npages) {
                        if (b_A_outdatedOnCpu) {
                          gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &b_gpu_A);
                        }

                        b_A_outdatedOnCpu = false;
                        if (g_cpu_A->data[cpu_nx + g_cpu_A->size[0] * (cpu_nx -
                             1)] != 0.0) {
                          if (g_cpu_A->data[cpu_nx + g_cpu_A->size[0] * (cpu_nx
                               - 1)] < 0.0) {
                            jend = 1;
                          } else {
                            jend = -1;
                          }

                          for (b_i = 0; b_i < npages; b_i++) {
                            if (b_V_outdatedOnCpu) {
                              gpuEmxMemcpyGpuToCpu_creal_T(c_cpu_V, &gpu_V);
                            }

                            cpu_d2scaled = c_cpu_V->data[b_i + c_cpu_V->size[0] *
                              (cpu_nx - 1)].re;
                            abnrm = static_cast<real_T>(jend) * c_cpu_V->
                              data[b_i + c_cpu_V->size[0] * cpu_nx].re;
                            if (abnrm == 0.0) {
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (cpu_nx - 1)]
                                .re = cpu_d2scaled / 1.4142135623730951;
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (cpu_nx - 1)]
                                .im = 0.0;
                              b_V_outdatedOnCpu = false;
                            } else if (cpu_d2scaled == 0.0) {
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (cpu_nx - 1)]
                                .re = 0.0;
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (cpu_nx - 1)]
                                .im = abnrm / 1.4142135623730951;
                              b_V_outdatedOnCpu = false;
                            } else {
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (cpu_nx - 1)]
                                .re = cpu_d2scaled / 1.4142135623730951;
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (cpu_nx - 1)]
                                .im = abnrm / 1.4142135623730951;
                              b_V_outdatedOnCpu = false;
                            }

                            c_cpu_V->data[b_i + c_cpu_V->size[0] * cpu_nx].re =
                              c_cpu_V->data[b_i + c_cpu_V->size[0] * (cpu_nx - 1)]
                              .re;
                            c_cpu_V->data[b_i + c_cpu_V->size[0] * cpu_nx].im =
                              -c_cpu_V->data[b_i + c_cpu_V->size[0] * (cpu_nx -
                              1)].im;
                            b_V_outdatedOnGpu = true;
                          }

                          cpu_nx += 2;
                        } else {
                          cpu_nx++;
                        }
                      } else {
                        cpu_nx++;
                      }
                    } else {
                      exitg1 = 1;
                    }
                  } while (exitg1 == 0);
                } else {
                  ptrdiff_t i_info_t;
                  npages = g_cpu_A->size[0];
                  cpu_nx = g_cpu_A->size[1] - 1;
                  b_i = b_scale->size[0];
                  b_scale->size[0] = g_cpu_A->size[1];
                  emxEnsureCapacity_real_T(b_scale, b_i, &eb_emlrtRTEI);
                  b_i = d_cpu_W->size[0];
                  d_cpu_W->size[0] = g_cpu_A->size[1];
                  emxEnsureCapacity_creal_T(d_cpu_W, b_i, &hb_emlrtRTEI);
                  gpuEmxEnsureCapacity_creal_T(d_cpu_W, &b_gpu_W);
                  b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
                  c_cpu_V->size[0] = g_cpu_A->size[1];
                  c_cpu_V->size[1] = g_cpu_A->size[1];
                  emxEnsureCapacity_creal_T(c_cpu_V, b_i, &lb_emlrtRTEI);
                  if (!b_V_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_creal_T(c_cpu_V, &gpu_V);
                  }

                  b_i = b_cpu_wreal->size[0];
                  b_cpu_wreal->size[0] = g_cpu_A->size[1];
                  emxEnsureCapacity_real_T(b_cpu_wreal, b_i, &mb_emlrtRTEI);
                  if (!b_wreal_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_real_T(b_cpu_wreal, &gpu_wreal);
                  }

                  b_i = b_cpu_wimag->size[0];
                  b_cpu_wimag->size[0] = g_cpu_A->size[1];
                  emxEnsureCapacity_real_T(b_cpu_wimag, b_i, &ob_emlrtRTEI);
                  if (!b_wimag_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_real_T(b_cpu_wimag, &gpu_wimag);
                  }

                  b_i = b_cpu_vright->size[0] * b_cpu_vright->size[1];
                  b_cpu_vright->size[0] = g_cpu_A->size[1];
                  b_cpu_vright->size[1] = g_cpu_A->size[1];
                  emxEnsureCapacity_real_T(b_cpu_vright, b_i, &sb_emlrtRTEI);
                  if (!b_vright_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_real_T(b_cpu_vright, &gpu_vright);
                  }

                  if (b_A_outdatedOnCpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(g_cpu_A, &b_gpu_A);
                  }

                  i_info_t = LAPACKE_dgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)
                    g_cpu_A->size[1], &g_cpu_A->data[0], (ptrdiff_t)
                    g_cpu_A->size[0], &b_cpu_wreal->data[0], &b_cpu_wimag->data
                    [0], &cpu_d2scaled, (ptrdiff_t)1, &b_cpu_vright->data[0],
                    (ptrdiff_t)g_cpu_A->size[1], &b_ilo_t, &b_ihi_t,
                    &b_scale->data[0], &abnrm, &rconde, &rcondv);
                  b_vright_outdatedOnGpu = true;
                  b_wimag_outdatedOnGpu = true;
                  b_wreal_outdatedOnGpu = true;
                  b_A_outdatedOnCpu = false;
                  b_A_outdatedOnGpu = true;
                  if ((int32_T)i_info_t < 0) {
                    b_i = d_cpu_W->size[0];
                    d_cpu_W->size[0] = g_cpu_A->size[1];
                    emxEnsureCapacity_creal_T(d_cpu_W, b_i, &ac_emlrtRTEI);
                    gpuEmxEnsureCapacity_creal_T(d_cpu_W, &b_gpu_W);
                    r = g_cpu_A->size[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D(static_cast<
                      real_T>(r + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      ec_detrend_kernel102<<<grid, block>>>(dc, r, b_gpu_W);
                      d_W_outdatedOnCpu = true;
                    }

                    for (b_i = 0; b_i < 2; b_i++) {
                      i12[b_i] = c_cpu_V->size[b_i];
                    }

                    b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
                    c_cpu_V->size[0] = i12[0];
                    c_cpu_V->size[1] = i12[1];
                    emxEnsureCapacity_creal_T(c_cpu_V, b_i, &gc_emlrtRTEI);
                    if (!b_V_outdatedOnGpu) {
                      gpuEmxEnsureCapacity_creal_T(c_cpu_V, &gpu_V);
                    }

                    b_i = i12[0] * i12[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D(static_cast<
                      real_T>(b_i + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      if (b_V_outdatedOnGpu) {
                        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, c_cpu_V);
                      }

                      ec_detrend_kernel103<<<grid, block>>>(dc, b_i, gpu_V);
                      b_V_outdatedOnGpu = false;
                      b_V_outdatedOnCpu = true;
                    }
                  } else {
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(cpu_nx + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_wimag, b_cpu_wimag);
                      b_wimag_outdatedOnGpu = false;
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_wreal, b_cpu_wreal);
                      b_wreal_outdatedOnGpu = false;
                      ec_detrend_kernel99<<<grid, block>>>(gpu_wimag, gpu_wreal,
                        cpu_nx, b_gpu_W);
                      d_W_outdatedOnCpu = true;
                    }

                    b_i = c_cpu_V->size[0] * c_cpu_V->size[1];
                    c_cpu_V->size[0] = b_cpu_vright->size[0];
                    c_cpu_V->size[1] = b_cpu_vright->size[1];
                    emxEnsureCapacity_creal_T(c_cpu_V, b_i, &ec_emlrtRTEI);
                    if (!b_V_outdatedOnGpu) {
                      gpuEmxEnsureCapacity_creal_T(c_cpu_V, &gpu_V);
                    }

                    b_i = b_cpu_vright->size[0] * b_cpu_vright->size[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&gpu_vright, b_cpu_vright);
                      b_vright_outdatedOnGpu = false;
                      if (b_V_outdatedOnGpu) {
                        gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, c_cpu_V);
                      }

                      ec_detrend_kernel100<<<grid, block>>>(gpu_vright, b_i,
                        gpu_V);
                      b_V_outdatedOnGpu = false;
                      b_V_outdatedOnCpu = true;
                    }

                    for (b_i = 0; b_i < cpu_nx; b_i++) {
                      if ((b_cpu_wimag->data[b_i] > 0.0) && (b_cpu_wimag->
                           data[b_i + 1] < 0.0)) {
                        validLaunchParams = mwGetLaunchParameters1D
                          (static_cast<real_T>(cpu_nx + 1L), &grid, &block,
                           1024U, 65535U);
                        if (validLaunchParams) {
                          if (b_V_outdatedOnGpu) {
                            gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, c_cpu_V);
                          }

                          ec_detrend_kernel101<<<grid, block>>>(b_i + 2, cpu_nx,
                            gpu_V, c_cpu_V->size[0U]);
                          b_V_outdatedOnGpu = false;
                          b_V_outdatedOnCpu = true;
                        }
                      }
                    }
                  }

                  b_i = c_cpu_D->size[0] * c_cpu_D->size[1];
                  c_cpu_D->size[0] = g_cpu_A->size[0];
                  c_cpu_D->size[1] = g_cpu_A->size[0];
                  emxEnsureCapacity_creal_T(c_cpu_D, b_i, &ic_emlrtRTEI);
                  if (!b_D_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_creal_T(c_cpu_D, &gpu_D);
                  }

                  r = g_cpu_A->size[0] * g_cpu_A->size[0] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (r + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (b_D_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, c_cpu_D);
                    }

                    ec_detrend_kernel104<<<grid, block>>>(r, gpu_D);
                    b_D_outdatedOnGpu = false;
                    c_D_outdatedOnCpu = true;
                  }

                  for (jend = 0; jend < npages; jend++) {
                    if (c_D_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_creal_T(c_cpu_D, &gpu_D);
                    }

                    if (d_W_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_creal_T(d_cpu_W, &b_gpu_W);
                    }

                    d_W_outdatedOnCpu = false;
                    c_cpu_D->data[jend + c_cpu_D->size[0] * jend] =
                      d_cpu_W->data[jend];
                    c_D_outdatedOnCpu = false;
                    b_D_outdatedOnGpu = true;
                  }
                }
              }
            }
          }

          // 'ec_detrend:175' V = real(V);
          b_i = d_cpu_V->size[0] * d_cpu_V->size[1];
          d_cpu_V->size[0] = c_cpu_V->size[0];
          d_cpu_V->size[1] = c_cpu_V->size[1];
          emxEnsureCapacity_real_T(d_cpu_V, b_i, &y_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(d_cpu_V, &b_gpu_V);
          b_i = c_cpu_V->size[0] * c_cpu_V->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_V_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&gpu_V, c_cpu_V);
            }

            b_V_outdatedOnGpu = false;
            ec_detrend_kernel123<<<grid, block>>>(gpu_V, b_i, b_gpu_V);
          }

          // 'ec_detrend:176' D = diag(real(D));
          b_i = b_cpu_v->size[0] * b_cpu_v->size[1];
          b_cpu_v->size[0] = c_cpu_D->size[0];
          b_cpu_v->size[1] = c_cpu_D->size[1];
          emxEnsureCapacity_real_T(b_cpu_v, b_i, &bb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_v, &gpu_v);
          b_i = c_cpu_D->size[0] * c_cpu_D->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_D_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_creal_T(&gpu_D, c_cpu_D);
            }

            b_D_outdatedOnGpu = false;
            ec_detrend_kernel124<<<grid, block>>>(gpu_D, b_i, gpu_v);
          }

          if ((b_cpu_v->size[0] == 1) && (b_cpu_v->size[1] == 1)) {
            b_i = d_cpu_D->size[0];
            d_cpu_D->size[0] = 1;
            emxEnsureCapacity_real_T(d_cpu_D, b_i, &gb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_cpu_D, &b_gpu_D);
            ec_detrend_kernel126<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_v,
              b_gpu_D);
            d_D_outdatedOnCpu = true;
          } else {
            istart = b_cpu_v->size[0];
            npages = b_cpu_v->size[1];
            if (istart <= npages) {
              npages = istart;
            }

            if (b_cpu_v->size[1] > 0) {
              istart = npages;
            } else {
              istart = 0;
            }

            b_i = d_cpu_D->size[0];
            d_cpu_D->size[0] = istart;
            emxEnsureCapacity_real_T(d_cpu_D, b_i, &db_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_cpu_D, &b_gpu_D);
            istart--;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (istart + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel125<<<grid, block>>>(gpu_v, istart, b_gpu_D,
                b_cpu_v->size[0U]);
              d_D_outdatedOnCpu = true;
            }
          }

          // 'ec_detrend:177' V = V(:,D/max(D)>thrPCA);
          vlen = d_cpu_D->size[0];
          if (d_D_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_cpu_D, &b_gpu_D);
          }

          d_D_outdatedOnCpu = false;
          cpu_d2scaled = d_cpu_D->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            if (std::isnan(d_cpu_D->data[b_i + 1])) {
              validLaunchParams = false;
            } else if (std::isnan(cpu_d2scaled)) {
              validLaunchParams = true;
            } else {
              validLaunchParams = (cpu_d2scaled < d_cpu_D->data[b_i + 1]);
            }

            if (validLaunchParams) {
              cpu_d2scaled = d_cpu_D->data[b_i + 1];
            }
          }

          vlen = d_cpu_D->size[0] - 1;
          npages = 0;
          for (b_i = 0; b_i <= vlen; b_i++) {
            if (d_cpu_D->data[b_i] / cpu_d2scaled > 1.0E-7) {
              npages++;
            }
          }

          b_i = cpu_iv1->size[0];
          cpu_iv1->size[0] = npages;
          emxEnsureCapacity_int32_T(cpu_iv1, b_i, &tb_emlrtRTEI);
          if (!iv1_outdatedOnGpu) {
            gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1);
          }

          istart = 0;
          for (b_i = 0; b_i <= vlen; b_i++) {
            if (d_cpu_D->data[b_i] / cpu_d2scaled > 1.0E-7) {
              cpu_iv1->data[istart] = b_i;
              iv1_outdatedOnGpu = true;
              istart++;
            }
          }

          npages = d_cpu_V->size[0];
          b_i = f_cpu_V->size[0] * f_cpu_V->size[1];
          f_cpu_V->size[0] = d_cpu_V->size[0];
          f_cpu_V->size[1] = cpu_iv1->size[0];
          emxEnsureCapacity_real_T(f_cpu_V, b_i, &vb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_cpu_V, &c_gpu_V);
          b_i = cpu_iv1->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages
            * (b_i + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (iv1_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv1, cpu_iv1);
            }

            iv1_outdatedOnGpu = false;
            ec_detrend_kernel127<<<grid, block>>>(gpu_iv1, b_gpu_V, npages, b_i,
              c_gpu_V, f_cpu_V->size[0U], d_cpu_V->size[0U]);
          }

          b_i = d_cpu_V->size[0] * d_cpu_V->size[1];
          d_cpu_V->size[0] = f_cpu_V->size[0];
          d_cpu_V->size[1] = f_cpu_V->size[1];
          emxEnsureCapacity_real_T(d_cpu_V, b_i, &dc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(d_cpu_V, &b_gpu_V);
          b_i = f_cpu_V->size[0] * f_cpu_V->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel128<<<grid, block>>>(c_gpu_V, b_i, b_gpu_V);
          }

          //  discard weak dims
          // 'ec_detrend:178' rr = rr*V;
          npages = b_cpu_rr->size[0];
          vlen = b_cpu_rr->size[1];
          if ((b_cpu_rr->size[0] == 0) || (b_cpu_rr->size[1] == 0) ||
              (d_cpu_V->size[0] == 0) || (d_cpu_V->size[1] == 0)) {
            istart = b_cpu_rr->size[0];
            i12[0] = b_cpu_rr->size[0];
            i12[1] = d_cpu_V->size[1];
            b_i = b_cpu_rr->size[0] * b_cpu_rr->size[1];
            b_cpu_rr->size[0] = istart;
            b_cpu_rr->size[1] = d_cpu_V->size[1];
            emxEnsureCapacity_real_T(b_cpu_rr, b_i, &mc_emlrtRTEI);
            if (!b_rr_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_rr, &gpu_rr);
            }

            b_i = i12[0] * i12[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_rr_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, b_cpu_rr);
              }

              ec_detrend_kernel130<<<grid, block>>>(b_i, gpu_rr);
              b_rr_outdatedOnGpu = false;
              b_rr_outdatedOnCpu = true;
            }
          } else {
            b_i = j_cpu_A->size[0] * j_cpu_A->size[1];
            j_cpu_A->size[0] = b_cpu_rr->size[0];
            j_cpu_A->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real_T(j_cpu_A, b_i, &kc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(j_cpu_A, &g_gpu_A);
            r = b_cpu_rr->size[0] * b_cpu_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_rr_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, b_cpu_rr);
              }

              b_rr_outdatedOnGpu = false;
              ec_detrend_kernel129<<<grid, block>>>(gpu_rr, r, g_gpu_A);
            }

            b_i = b_cpu_rr->size[0] * b_cpu_rr->size[1];
            b_cpu_rr->size[0] = npages;
            b_cpu_rr->size[1] = d_cpu_V->size[1];
            emxEnsureCapacity_real_T(b_cpu_rr, b_i, &u_emlrtRTEI);
            if (!b_rr_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_rr, &gpu_rr);
            }

            cpu_d2scaled = 1.0;
            abnrm = 0.0;
            if (b_rr_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, b_cpu_rr);
            }

            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        npages, d_cpu_V->size[1], vlen, (double *)&cpu_d2scaled,
                        (double *)&g_gpu_A.data[0], npages, (double *)
                        &b_gpu_V.data[0], vlen, (double *)&abnrm, (double *)
                        &gpu_rr.data[0], npages);
            b_rr_outdatedOnGpu = false;
            b_rr_outdatedOnCpu = true;
          }

          // 'ec_detrend:179' b = (x'*rr) / (rr'*rr);
          b_i = k_cpu_A->size[0] * k_cpu_A->size[1];
          k_cpu_A->size[0] = 1;
          k_cpu_A->size[1] = cpu_dv3->size[0];
          emxEnsureCapacity_real_T(k_cpu_A, b_i, &t_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(k_cpu_A, &c_gpu_A);
          b_i = cpu_dv3->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (dv3_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv3, cpu_dv3);
            }

            dv3_outdatedOnGpu = false;
            ec_detrend_kernel131<<<grid, block>>>(gpu_dv3, b_i, c_gpu_A);
          }

          if ((cpu_dv3->size[0] == 0) || (b_cpu_rr->size[0] == 0) ||
              (b_cpu_rr->size[1] == 0)) {
            b_i = b_cpu_b->size[0] * b_cpu_b->size[1];
            b_cpu_b->size[0] = 1;
            b_cpu_b->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real_T(b_cpu_b, b_i, &v_emlrtRTEI);
            if (!b_b_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_b, &gpu_b);
            }

            r = b_cpu_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_b_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b_cpu_b);
              }

              ec_detrend_kernel132<<<grid, block>>>(r, gpu_b);
              b_b_outdatedOnGpu = false;
            }
          } else {
            b_i = b_cpu_b->size[0] * b_cpu_b->size[1];
            b_cpu_b->size[0] = 1;
            b_cpu_b->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real_T(b_cpu_b, b_i, &u_emlrtRTEI);
            if (!b_b_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_b, &gpu_b);
            }

            cpu_d2scaled = 1.0;
            abnrm = 0.0;
            if (b_rr_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, b_cpu_rr);
            }

            b_rr_outdatedOnGpu = false;
            if (b_b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b_cpu_b);
            }

            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                        b_cpu_rr->size[1], cpu_dv3->size[0], (double *)
                        &cpu_d2scaled, (double *)&c_gpu_A.data[0], 1, (double *)
                        &gpu_rr.data[0], cpu_dv3->size[0], (double *)&abnrm,
                        (double *)&gpu_b.data[0], 1);
            b_b_outdatedOnGpu = false;
          }

          b_i = l_cpu_A->size[0] * l_cpu_A->size[1];
          l_cpu_A->size[0] = b_cpu_rr->size[1];
          l_cpu_A->size[1] = b_cpu_rr->size[0];
          emxEnsureCapacity_real_T(l_cpu_A, b_i, &t_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(l_cpu_A, &d_gpu_A);
          r = b_cpu_rr->size[0] - 1;
          b_i = b_cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i +
            1L) * (r + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_rr_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, b_cpu_rr);
            }

            b_rr_outdatedOnGpu = false;
            ec_detrend_kernel133<<<grid, block>>>(gpu_rr, b_i, r, d_gpu_A,
              l_cpu_A->size[0U], b_cpu_rr->size[0U]);
          }

          if ((l_cpu_A->size[0] == 0) || (l_cpu_A->size[1] == 0) ||
              (b_cpu_rr->size[0] == 0) || (b_cpu_rr->size[1] == 0)) {
            b_i = m_cpu_A->size[0] * m_cpu_A->size[1];
            m_cpu_A->size[0] = l_cpu_A->size[0];
            m_cpu_A->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real_T(m_cpu_A, b_i, &v_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(m_cpu_A, &e_gpu_A);
            r = l_cpu_A->size[0] * b_cpu_rr->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel134<<<grid, block>>>(r, e_gpu_A);
            }
          } else {
            b_i = m_cpu_A->size[0] * m_cpu_A->size[1];
            m_cpu_A->size[0] = l_cpu_A->size[0];
            m_cpu_A->size[1] = b_cpu_rr->size[1];
            emxEnsureCapacity_real_T(m_cpu_A, b_i, &u_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(m_cpu_A, &e_gpu_A);
            cpu_d2scaled = 1.0;
            abnrm = 0.0;
            if (b_rr_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_rr, b_cpu_rr);
            }

            b_rr_outdatedOnGpu = false;
            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        l_cpu_A->size[0], b_cpu_rr->size[1], l_cpu_A->size[1],
                        (double *)&cpu_d2scaled, (double *)&d_gpu_A.data[0],
                        l_cpu_A->size[0], (double *)&gpu_rr.data[0],
                        l_cpu_A->size[1], (double *)&abnrm, (double *)
                        &e_gpu_A.data[0], l_cpu_A->size[0]);
          }

          if ((b_cpu_b->size[1] == 0) || ((m_cpu_A->size[0] == 0) ||
               (m_cpu_A->size[1] == 0))) {
            sz[1] = static_cast<uint32_T>(m_cpu_A->size[0]);
            b_i = b_cpu_b->size[0] * b_cpu_b->size[1];
            b_cpu_b->size[0] = 1;
            b_cpu_b->size[1] = m_cpu_A->size[0];
            emxEnsureCapacity_real_T(b_cpu_b, b_i, &pc_emlrtRTEI);
            if (!b_b_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_b, &gpu_b);
            }

            b_i = static_cast<int32_T>(sz[1]) - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_b_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b_cpu_b);
              }

              ec_detrend_kernel149<<<grid, block>>>(static_cast<int32_T>(sz[1])
                - 1, gpu_b);
              b_b_outdatedOnGpu = false;
            }
          } else if (m_cpu_A->size[0] == m_cpu_A->size[1]) {
            npages = m_cpu_A->size[1] - 2;
            b_i = b_cpu_ipiv_t->size[0];
            b_cpu_ipiv_t->size[0] = m_cpu_A->size[1];
            emxEnsureCapacity_int32_T(b_cpu_ipiv_t, b_i, &nc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_cpu_ipiv_t, &gpu_ipiv_t);
            cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), m_cpu_A->
              size[1], m_cpu_A->size[1], (double *)&e_gpu_A.data[0],
              m_cpu_A->size[1], getCuSolverWorkspaceReq());
            setCuSolverWorkspaceTypeSize(8);
            cusolverInitWorkspace();
            cusolverDnDgetrf(getCuSolverGlobalHandle(), m_cpu_A->size[1],
                             m_cpu_A->size[1], (double *)&e_gpu_A.data[0],
                             m_cpu_A->size[1], static_cast<real_T *>
                             (getCuSolverWorkspaceBuff()), &gpu_ipiv_t.data[0],
                             gpu_info);
            b_i = b_cpu_ipiv->size[0] * b_cpu_ipiv->size[1];
            b_cpu_ipiv->size[0] = 1;
            b_cpu_ipiv->size[1] = b_cpu_ipiv_t->size[0];
            emxEnsureCapacity_int32_T(b_cpu_ipiv, b_i, &qc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_cpu_ipiv, &gpu_ipiv);
            cudaMemcpy(&b_cpu_info, gpu_info, 4UL, cudaMemcpyDeviceToHost);
            if (b_cpu_info < 0) {
              for (b_i = 0; b_i < 2; b_i++) {
                i12[b_i] = m_cpu_A->size[b_i];
              }

              b_i = m_cpu_A->size[0] * m_cpu_A->size[1];
              m_cpu_A->size[0] = i12[0];
              m_cpu_A->size[1] = i12[1];
              emxEnsureCapacity_real_T(m_cpu_A, b_i, &tc_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(m_cpu_A, &e_gpu_A);
              b_i = i12[0] * i12[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (b_i + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_detrend_kernel147<<<grid, block>>>(b_i, e_gpu_A);
              }

              istart = b_cpu_ipiv->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (istart + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_detrend_kernel148<<<grid, block>>>(istart, gpu_ipiv);
                b_ipiv_outdatedOnCpu = true;
              }
            } else {
              istart = b_cpu_ipiv_t->size[0] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (istart + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_detrend_kernel146<<<grid, block>>>(gpu_ipiv_t, istart,
                  gpu_ipiv);
                b_ipiv_outdatedOnCpu = true;
              }
            }

            cpu_d2scaled = 1.0;
            if (b_b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b_cpu_b);
            }

            cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                        CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N,
                        CUBLAS_DIAG_NON_UNIT, 1, npages + 2, (double *)
                        &cpu_d2scaled, (double *)&e_gpu_A.data[0], npages + 2,
                        (double *)&gpu_b.data[0], 1);
            cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                        CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                        npages + 2, (double *)&cpu_d2scaled, (double *)
                        &e_gpu_A.data[0], npages + 2, (double *)&gpu_b.data[0],
                        1);
            b_b_outdatedOnGpu = false;
            validLaunchParams = true;
            for (cpu_nx = 0; cpu_nx <= npages; cpu_nx++) {
              if (b_ipiv_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_ipiv, &gpu_ipiv);
              }

              b_ipiv_outdatedOnCpu = false;
              if (b_cpu_ipiv->data[npages - cpu_nx] != (npages - cpu_nx) + 1) {
                if (validLaunchParams) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_cpu_b, &gpu_b);
                }

                cpu_d2scaled = b_cpu_b->data[npages - cpu_nx];
                b_cpu_b->data[npages - cpu_nx] = b_cpu_b->data[b_cpu_ipiv->
                  data[npages - cpu_nx] - 1];
                b_cpu_b->data[b_cpu_ipiv->data[npages - cpu_nx] - 1] =
                  cpu_d2scaled;
                validLaunchParams = false;
                b_b_outdatedOnGpu = true;
              }
            }
          } else {
            ptrdiff_t l_info_t;
            boolean_T b_tau_outdatedOnGpu;
            boolean_T c_A_outdatedOnGpu;
            b_i = n_cpu_A->size[0] * n_cpu_A->size[1];
            n_cpu_A->size[0] = m_cpu_A->size[1];
            n_cpu_A->size[1] = m_cpu_A->size[0];
            emxEnsureCapacity_real_T(n_cpu_A, b_i, &oc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(n_cpu_A, &f_gpu_A);
            r = m_cpu_A->size[0] - 1;
            b_i = m_cpu_A->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i
              + 1L) * (r + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel135<<<grid, block>>>(e_gpu_A, b_i, r, f_gpu_A,
                n_cpu_A->size[0U], m_cpu_A->size[0U]);
              d_A_outdatedOnCpu = true;
            }

            b_i = c_cpu_B->size[0];
            c_cpu_B->size[0] = b_cpu_b->size[1];
            emxEnsureCapacity_real_T(c_cpu_B, b_i, &rc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(c_cpu_B, &b_gpu_B);
            b_i = b_cpu_b->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_b_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b_cpu_b);
              }

              b_b_outdatedOnGpu = false;
              ec_detrend_kernel136<<<grid, block>>>(gpu_b, b_i, b_gpu_B);
            }

            vlen = n_cpu_A->size[0];
            npages = n_cpu_A->size[1] - 1;
            b_i = b_cpu_jpvt->size[0] * b_cpu_jpvt->size[1];
            b_cpu_jpvt->size[0] = 1;
            b_cpu_jpvt->size[1] = n_cpu_A->size[1];
            emxEnsureCapacity_int32_T(b_cpu_jpvt, b_i, &uc_emlrtRTEI);
            if (!b_jpvt_outdatedOnGpu) {
              gpuEmxEnsureCapacity_int32_T(b_cpu_jpvt, &gpu_jpvt);
            }

            r = n_cpu_A->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_jpvt_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, b_cpu_jpvt);
              }

              ec_detrend_kernel137<<<grid, block>>>(r, gpu_jpvt);
              b_jpvt_outdatedOnGpu = false;
              b_jpvt_outdatedOnCpu = true;
            }

            istart = n_cpu_A->size[0];
            jend = n_cpu_A->size[1];
            if (istart <= jend) {
              jend = istart;
            }

            b_i = d_cpu_tau->size[0];
            d_cpu_tau->size[0] = jend;
            emxEnsureCapacity_real_T(d_cpu_tau, b_i, &vc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_cpu_tau, &gpu_tau);
            b_i = b_jpvt_t->size[0];
            b_jpvt_t->size[0] = n_cpu_A->size[1];
            emxEnsureCapacity_ptrdiff_t(b_jpvt_t, b_i, &wc_emlrtRTEI);
            for (b_i = 0; b_i < n_cpu_A->size[1]; b_i++) {
              b_jpvt_t->data[b_i] = (ptrdiff_t)0;
            }

            if (d_A_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(n_cpu_A, &f_gpu_A);
            }

            if (d_tau_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(d_cpu_tau, &gpu_tau);
            }

            l_info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)n_cpu_A->size[0],
              (ptrdiff_t)n_cpu_A->size[1], &n_cpu_A->data[0], (ptrdiff_t)
              n_cpu_A->size[0], &b_jpvt_t->data[0], &d_cpu_tau->data[0]);
            d_tau_outdatedOnCpu = false;
            b_tau_outdatedOnGpu = true;
            d_A_outdatedOnCpu = false;
            c_A_outdatedOnGpu = true;
            if ((int32_T)l_info_t != 0) {
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vlen * (npages + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_A, n_cpu_A);
                ec_detrend_kernel138<<<grid, block>>>(vlen, npages, f_gpu_A,
                  n_cpu_A->size[0U]);
                c_A_outdatedOnGpu = false;
                d_A_outdatedOnCpu = true;
              }

              istart = n_cpu_A->size[0];
              vlen = n_cpu_A->size[1];
              if (istart <= vlen) {
                vlen = istart;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vlen), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, d_cpu_tau);
                ec_detrend_kernel139<<<grid, block>>>(vlen, gpu_tau);
                b_tau_outdatedOnGpu = false;
                d_tau_outdatedOnCpu = true;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (computeEndIdx(static_cast<int64_T>(vlen + 1),
                               static_cast<int64_T>(jend), 1L) + 1L), &grid,
                &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_tau_outdatedOnGpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, d_cpu_tau);
                }

                ec_detrend_kernel140<<<grid, block>>>(jend, vlen + 1, gpu_tau);
                b_tau_outdatedOnGpu = false;
                d_tau_outdatedOnCpu = true;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (npages + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (b_jpvt_outdatedOnGpu) {
                  gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, b_cpu_jpvt);
                }

                ec_detrend_kernel141<<<grid, block>>>(npages, gpu_jpvt);
                b_jpvt_outdatedOnGpu = false;
                b_jpvt_outdatedOnCpu = true;
              }
            } else {
              for (jend = 0; jend <= npages; jend++) {
                if (b_jpvt_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_jpvt, &gpu_jpvt);
                }

                b_cpu_jpvt->data[jend] = (int32_T)b_jpvt_t->data[jend];
                b_jpvt_outdatedOnCpu = false;
                b_jpvt_outdatedOnGpu = true;
              }
            }

            jend = -1;
            if (n_cpu_A->size[0] < n_cpu_A->size[1]) {
              vlen = n_cpu_A->size[0];
              istart = n_cpu_A->size[1];
            } else {
              vlen = n_cpu_A->size[1];
              istart = n_cpu_A->size[0];
            }

            if (d_A_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(n_cpu_A, &f_gpu_A);
            }

            d_A_outdatedOnCpu = false;
            cpu_d2scaled = std::fmin(1.4901161193847656E-8,
              2.2204460492503131E-15 * static_cast<real_T>(istart)) * std::abs
              (n_cpu_A->data[0]);
            while ((jend + 1 < vlen) && (!(std::abs(n_cpu_A->data[(jend +
                       n_cpu_A->size[0] * (jend + 1)) + 1]) <= cpu_d2scaled))) {
              jend++;
            }

            b_i = b_cpu_Y->size[0];
            b_cpu_Y->size[0] = n_cpu_A->size[1];
            emxEnsureCapacity_real_T(b_cpu_Y, b_i, &bd_emlrtRTEI);
            if (!b_Y_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_Y, &gpu_Y);
            }

            r = n_cpu_A->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_Y_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, b_cpu_Y);
              }

              ec_detrend_kernel142<<<grid, block>>>(r, gpu_Y);
              b_Y_outdatedOnGpu = false;
              b_Y_outdatedOnCpu = true;
            }

            cpu_nx = 0;
            istart = n_cpu_A->size[0];
            npages = n_cpu_A->size[1];
            if (istart <= npages) {
              npages = istart;
            }

            if (c_A_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_A, n_cpu_A);
            }

            if (b_tau_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, d_cpu_tau);
            }

            cusolverDnDormqr_bufferSize(getCuSolverGlobalHandle(),
              CUBLAS_SIDE_LEFT, CUBLAS_OP_T, c_cpu_B->size[0], 1, npages,
              (double *)&f_gpu_A.data[0], n_cpu_A->size[0], (double *)
              &gpu_tau.data[0], (double *)&b_gpu_B.data[0], c_cpu_B->size[0],
              getCuSolverWorkspaceReq());
            setCuSolverWorkspaceTypeSize(8);
            cusolverInitWorkspace();
            cudaMemcpy(gpu_nx, &cpu_nx, 4UL, cudaMemcpyHostToDevice);
            cusolverDnDormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                             CUBLAS_OP_T, c_cpu_B->size[0], 1, npages, (double *)
                             &f_gpu_A.data[0], n_cpu_A->size[0], (double *)
                             &gpu_tau.data[0], (double *)&b_gpu_B.data[0],
                             c_cpu_B->size[0], static_cast<real_T *>
                             (getCuSolverWorkspaceBuff()),
                             *getCuSolverWorkspaceReq(), gpu_nx);
            cudaMemcpy(&cpu_nx, gpu_nx, 4UL, cudaMemcpyDeviceToHost);
            if (cpu_nx < 0) {
              vlen = c_cpu_B->size[0];
              b_i = c_cpu_B->size[0];
              c_cpu_B->size[0] = vlen;
              emxEnsureCapacity_real_T(c_cpu_B, b_i, &ed_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(c_cpu_B, &b_gpu_B);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vlen), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_detrend_kernel143<<<grid, block>>>(vlen, b_gpu_B);
              }
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(jend
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_jpvt_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, b_cpu_jpvt);
              }

              b_jpvt_outdatedOnGpu = false;
              if (b_Y_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, b_cpu_Y);
              }

              ec_detrend_kernel144<<<grid, block>>>(b_gpu_B, gpu_jpvt, jend,
                gpu_Y);
              b_Y_outdatedOnGpu = false;
              b_Y_outdatedOnCpu = true;
            }

            for (cpu_nx = 0; cpu_nx <= jend; cpu_nx++) {
              if (b_Y_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_cpu_Y, &gpu_Y);
              }

              if (b_jpvt_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_jpvt, &gpu_jpvt);
              }

              b_jpvt_outdatedOnCpu = false;
              b_cpu_Y->data[b_cpu_jpvt->data[jend - cpu_nx] - 1] /=
                n_cpu_A->data[(jend - cpu_nx) + n_cpu_A->size[0] * (jend -
                cpu_nx)];
              b_Y_outdatedOnCpu = false;
              b_Y_outdatedOnGpu = true;
              istart = jend - cpu_nx;
              for (b_i = 0; b_i < istart; b_i++) {
                b_cpu_Y->data[b_cpu_jpvt->data[b_i] - 1] -= b_cpu_Y->
                  data[b_cpu_jpvt->data[jend - cpu_nx] - 1] * n_cpu_A->data[b_i
                  + n_cpu_A->size[0] * (jend - cpu_nx)];
              }
            }

            b_i = b_cpu_b->size[0] * b_cpu_b->size[1];
            b_cpu_b->size[0] = 1;
            b_cpu_b->size[1] = b_cpu_Y->size[0];
            emxEnsureCapacity_real_T(b_cpu_b, b_i, &pc_emlrtRTEI);
            if (!b_b_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_b, &gpu_b);
            }

            b_i = b_cpu_Y->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_Y_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, b_cpu_Y);
              }

              b_Y_outdatedOnGpu = false;
              if (b_b_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b_cpu_b);
              }

              ec_detrend_kernel145<<<grid, block>>>(gpu_Y, b_i, gpu_b);
              b_b_outdatedOnGpu = false;
            }
          }

          // 'ec_detrend:180' z = r*(V*b') + mn;
          b_i = d_cpu_B->size[0];
          d_cpu_B->size[0] = b_cpu_b->size[1];
          emxEnsureCapacity_real_T(d_cpu_B, b_i, &sc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(d_cpu_B, &gpu_B);
          b_i = b_cpu_b->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b_cpu_b);
            }

            b_b_outdatedOnGpu = false;
            ec_detrend_kernel150<<<grid, block>>>(gpu_b, b_i, gpu_B);
          }

          if ((d_cpu_V->size[0] == 0) || (d_cpu_V->size[1] == 0) ||
              (d_cpu_B->size[0] == 0)) {
            b_i = e_cpu_y->size[0];
            e_cpu_y->size[0] = d_cpu_V->size[0];
            emxEnsureCapacity_real_T(e_cpu_y, b_i, &v_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(e_cpu_y, &b_gpu_y);
            b_i = d_cpu_V->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel151<<<grid, block>>>(b_i, b_gpu_y);
            }
          } else {
            b_i = e_cpu_y->size[0];
            e_cpu_y->size[0] = d_cpu_V->size[0];
            emxEnsureCapacity_real_T(e_cpu_y, b_i, &u_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(e_cpu_y, &b_gpu_y);
            cpu_d2scaled = 1.0;
            abnrm = 0.0;
            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        d_cpu_V->size[0], 1, d_cpu_V->size[1], (double *)
                        &cpu_d2scaled, (double *)&b_gpu_V.data[0], d_cpu_V->
                        size[0], (double *)&gpu_B.data[0], d_cpu_V->size[1],
                        (double *)&abnrm, (double *)&b_gpu_y.data[0],
                        d_cpu_V->size[0]);
          }

          if ((b_cpu_r->size[0] == 0) || (b_cpu_r->size[1] == 0) ||
              (e_cpu_y->size[0] == 0)) {
            b_i = cpu_dv11->size[0];
            cpu_dv11->size[0] = b_cpu_r->size[0];
            emxEnsureCapacity_real_T(cpu_dv11, b_i, &xc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_dv11, &gpu_dv11);
            b_i = b_cpu_r->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel152<<<grid, block>>>(b_i, gpu_dv11);
              dv11_outdatedOnCpu = true;
            }
          } else {
            b_i = cpu_dv11->size[0];
            cpu_dv11->size[0] = b_cpu_r->size[0];
            emxEnsureCapacity_real_T(cpu_dv11, b_i, &u_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_dv11, &gpu_dv11);
            cpu_d2scaled = 1.0;
            abnrm = 0.0;
            if (r_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_r, b_cpu_r);
            }

            r_outdatedOnGpu = false;
            cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                        b_cpu_r->size[0], 1, b_cpu_r->size[1], (double *)
                        &cpu_d2scaled, (double *)&gpu_r.data[0], b_cpu_r->size[0],
                        (double *)&b_gpu_y.data[0], b_cpu_r->size[1], (double *)
                        &abnrm, (double *)&gpu_dv11.data[0], b_cpu_r->size[0]);
            dv11_outdatedOnCpu = true;
          }

          if (cpu_dv11->size[0] == ii - i7) {
            b_i = b_cpu_z->size[0];
            b_cpu_z->size[0] = cpu_dv11->size[0];
            emxEnsureCapacity_real_T(b_cpu_z, b_i, &yc_emlrtRTEI);
            if (!b_z_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_z, &gpu_z);
            }

            b_i = cpu_dv11->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
              }

              b_x_outdatedOnGpu = false;
              if (b_z_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, b_cpu_z);
              }

              ec_detrend_kernel153<<<grid, block>>>(mn, b_gpu_x, i7, gpu_dv11,
                b_i, gpu_z);
              b_z_outdatedOnGpu = false;
              b_z_outdatedOnCpu = true;
            }
          } else {
            if (b_z_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_z, &gpu_z);
            }

            if (dv11_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_dv11, &gpu_dv11);
            }

            dv11_outdatedOnCpu = false;
            if (b_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
            }

            b_x_outdatedOnCpu = false;
            binary_expand_op_15(b_cpu_z, cpu_dv11, b_cpu_x, i7, ii - 1, mn);
            b_z_outdatedOnCpu = false;
            b_z_outdatedOnGpu = true;
          }

          //  Find outliers
          // 'ec_detrend:88' d = (x-z).*w;
          if (ii - i7 == 1) {
            r = b_cpu_z->size[0];
          } else {
            r = ii - i7;
          }

          if ((ii - i7 == b_cpu_z->size[0]) && (r == b_i12 - i11)) {
            b_i = b_cpu_d->size[0];
            b_cpu_d->size[0] = ii - i7;
            emxEnsureCapacity_real_T(b_cpu_d, b_i, &ad_emlrtRTEI);
            if (!b_d_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_d, &gpu_d);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ii -
              i7), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_z_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, b_cpu_z);
              }

              b_z_outdatedOnGpu = false;
              if (b_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
              }

              b_x_outdatedOnGpu = false;
              if (b_d_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, b_cpu_d);
              }

              ec_detrend_kernel154<<<grid, block>>>(b_gpu_w, i11, gpu_z, b_gpu_x,
                i7, ii, gpu_d);
              b_d_outdatedOnGpu = false;
              b_d_outdatedOnCpu = true;
            }
          } else {
            if (b_d_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_d, &gpu_d);
            }

            if (b_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
            }

            b_x_outdatedOnCpu = false;
            if (b_z_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_z, &gpu_z);
            }

            b_z_outdatedOnCpu = false;
            if (b_w_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
            }

            b_w_outdatedOnCpu = false;
            binary_expand_op_14(b_cpu_d, b_cpu_x, i7, ii - 1, b_cpu_z, b_cpu_w,
                                i11, b_i12);
            b_d_outdatedOnCpu = false;
            b_d_outdatedOnGpu = true;
          }

          // 'ec_detrend:89' thrItr = thr*std(d);
          npages = b_cpu_d->size[0] - 1;
          if ((b_cpu_d->size[0] != 0) && (b_cpu_d->size[0] != 1)) {
            if (b_d_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_d, &gpu_d);
            }

            b_d_outdatedOnCpu = false;
            cpu_d2scaled = b_cpu_d->data[0];
            for (b_i = 0; b_i < npages; b_i++) {
              cpu_d2scaled += b_cpu_d->data[b_i + 1];
            }

            cpu_d2scaled /= static_cast<real_T>(b_cpu_d->size[0]);
            b_i = b_cpu_absdiff->size[0];
            b_cpu_absdiff->size[0] = b_cpu_d->size[0];
            emxEnsureCapacity_real_T(b_cpu_absdiff, b_i, &cd_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_cpu_absdiff, &gpu_absdiff);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_d_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_d, b_cpu_d);
              }

              b_d_outdatedOnGpu = false;
              ec_detrend_kernel155<<<grid, block>>>(cpu_d2scaled, gpu_d, npages,
                gpu_absdiff);
            }

            cublasDnrm2(getCublasGlobalHandle(), b_cpu_d->size[0], (double *)
                        &gpu_absdiff.data[0], 1, (double *)&cpu_d2scaled);
          }

          // 'ec_detrend:90' w(abs(d)>thrItr) = 0;
          //  update weights
          // 'ec_detrend:92' x = x-z;
          if (ii - i7 == b_cpu_z->size[0]) {
            b_i = cpu_yy->size[0];
            cpu_yy->size[0] = ii - i7;
            emxEnsureCapacity_real_T(cpu_yy, b_i, &fd_emlrtRTEI);
            if (!yy_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(cpu_yy, &gpu_yy);
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ii -
              i7), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_z_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, b_cpu_z);
              }

              b_z_outdatedOnGpu = false;
              if (b_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
              }

              b_x_outdatedOnGpu = false;
              if (yy_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, cpu_yy);
              }

              ec_detrend_kernel156<<<grid, block>>>(gpu_z, b_gpu_x, i7, ii,
                gpu_yy);
              yy_outdatedOnGpu = false;
              yy_outdatedOnCpu = true;
            }
          } else {
            if (yy_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_yy, &gpu_yy);
            }

            if (b_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
            }

            b_x_outdatedOnCpu = false;
            if (b_z_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_z, &gpu_z);
            }

            b_z_outdatedOnCpu = false;
            binary_expand_op_13(cpu_yy, b_cpu_x, i7, ii - 1, b_cpu_z);
            yy_outdatedOnCpu = false;
            yy_outdatedOnGpu = true;
          }

          //  triangular weighting
          // 'ec_detrend:125' if start==1
          if (start == 1.0) {
            // 'ec_detrend:126' b = [ones(1,wsize2/2,'like',yy)*wsize2/2, wsize2/2:-1:1]';
            b_i = b_cpu_a->size[0] * b_cpu_a->size[1];
            b_cpu_a->size[0] = 1;
            b_cpu_a->size[1] = static_cast<int32_T>(wsize2 / 2.0);
            emxEnsureCapacity_int8_T(b_cpu_a, b_i, &gd_emlrtRTEI);
            gpuEmxEnsureCapacity_int8_T(b_cpu_a, &b_gpu_a);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
              static_cast<int32_T>(wsize2 / 2.0)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel168<<<grid, block>>>(wsize2, b_gpu_a);
            }

            cpu_d2scaled = wsize2 / 2.0;
            if (cpu_d2scaled < 1.0) {
              f_cpu_y->size[0] = 1;
              f_cpu_y->size[1] = 0;
            } else if (std::floor(cpu_d2scaled) == cpu_d2scaled) {
              b_i = f_cpu_y->size[0] * f_cpu_y->size[1];
              f_cpu_y->size[0] = 1;
              f_cpu_y->size[1] = static_cast<int32_T>(-(1.0 - cpu_d2scaled)) + 1;
              emxEnsureCapacity_real_T(f_cpu_y, b_i, &jd_emlrtRTEI);
              if (!y_outdatedOnGpu) {
                gpuEmxEnsureCapacity_real_T(f_cpu_y, &d_gpu_y);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int64_T>(-(1.0 - cpu_d2scaled)) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                if (y_outdatedOnGpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_y, f_cpu_y);
                }

                ec_detrend_kernel174<<<grid, block>>>(cpu_d2scaled, d_gpu_y);
                y_outdatedOnGpu = false;
                c_y_outdatedOnCpu = true;
              }
            } else {
              abnrm = std::floor(-(1.0 - cpu_d2scaled) + 0.5);
              rconde = cpu_d2scaled - abnrm;
              if (std::abs(1.0 - rconde) < 4.4408920985006262E-16 * cpu_d2scaled)
              {
                abnrm++;
                rconde = 1.0;
              } else if (1.0 - rconde > 0.0) {
                rconde = cpu_d2scaled - (abnrm - 1.0);
              } else {
                abnrm++;
              }

              b_i = f_cpu_y->size[0] * f_cpu_y->size[1];
              f_cpu_y->size[0] = 1;
              f_cpu_y->size[1] = static_cast<int32_T>(abnrm);
              emxEnsureCapacity_real_T(f_cpu_y, b_i, &nd_emlrtRTEI);
              if (!y_outdatedOnGpu) {
                gpuEmxEnsureCapacity_real_T(f_cpu_y, &d_gpu_y);
              }

              if (static_cast<int32_T>(abnrm) > 0) {
                if (c_y_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(f_cpu_y, &d_gpu_y);
                }

                f_cpu_y->data[0] = cpu_d2scaled;
                c_y_outdatedOnCpu = false;
                y_outdatedOnGpu = true;
                if (static_cast<int32_T>(abnrm) > 1) {
                  gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_y, f_cpu_y);
                  ec_detrend_kernel169<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (rconde, abnrm, d_gpu_y);
                  y_outdatedOnGpu = false;
                  istart = (static_cast<int32_T>(abnrm) - 1) / 2;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (istart - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    ec_detrend_kernel170<<<grid, block>>>(rconde,
                      static_cast<int32_T>(abnrm), cpu_d2scaled, istart, d_gpu_y);
                  }

                  if (istart << 1 == static_cast<int32_T>(abnrm) - 1) {
                    ec_detrend_kernel173<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, cpu_d2scaled, istart, d_gpu_y);
                    c_y_outdatedOnCpu = true;
                  } else {
                    ec_detrend_kernel171<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (cpu_d2scaled, istart, d_gpu_y);
                    ec_detrend_kernel172<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, istart, d_gpu_y);
                    c_y_outdatedOnCpu = true;
                  }
                }
              }
            }

            b_i = c_cpu_b->size[0];
            c_cpu_b->size[0] = b_cpu_a->size[1] + f_cpu_y->size[1];
            emxEnsureCapacity_real_T(c_cpu_b, b_i, &kd_emlrtRTEI);
            if (!c_b_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(c_cpu_b, &b_gpu_b);
            }

            istart = b_cpu_a->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (istart), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, c_cpu_b);
              }

              ec_detrend_kernel175<<<grid, block>>>(wsize2, istart, b_gpu_b);
              c_b_outdatedOnGpu = false;
              b_outdatedOnCpu = true;
            }

            istart = f_cpu_y->size[1];
            for (b_i = 0; b_i < istart; b_i++) {
              if (b_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_cpu_b, &b_gpu_b);
              }

              if (c_y_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(f_cpu_y, &d_gpu_y);
              }

              c_y_outdatedOnCpu = false;
              c_cpu_b->data[b_i + b_cpu_a->size[1]] = f_cpu_y->data[b_i];
              b_outdatedOnCpu = false;
              c_b_outdatedOnGpu = true;
            }
          } else if (stop == dims_idx_0) {
            // 'ec_detrend:127' elseif stop==dims(1)
            // 'ec_detrend:128' b = [1:wsize2/2, ones(1,wsize2/2,'like',yy)*wsize2/2]';
            cpu_d2scaled = wsize2 / 2.0;
            if (cpu_d2scaled < 1.0) {
              h_cpu_y->size[0] = 1;
              h_cpu_y->size[1] = 0;
            } else {
              b_i = h_cpu_y->size[0] * h_cpu_y->size[1];
              h_cpu_y->size[0] = 1;
              h_cpu_y->size[1] = static_cast<int32_T>(cpu_d2scaled - 1.0) + 1;
              emxEnsureCapacity_real_T(h_cpu_y, b_i, &hd_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(h_cpu_y, &e_gpu_y);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int64_T>(cpu_d2scaled - 1.0) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                ec_detrend_kernel165<<<grid, block>>>(cpu_d2scaled, e_gpu_y);
              }
            }

            b_i = c_cpu_a->size[0] * c_cpu_a->size[1];
            c_cpu_a->size[0] = 1;
            c_cpu_a->size[1] = static_cast<int32_T>(wsize2 / 2.0);
            emxEnsureCapacity_int8_T(c_cpu_a, b_i, &id_emlrtRTEI);
            gpuEmxEnsureCapacity_int8_T(c_cpu_a, &d_gpu_a);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
              static_cast<int32_T>(wsize2 / 2.0)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel166<<<grid, block>>>(wsize2, d_gpu_a);
            }

            b_i = c_cpu_b->size[0];
            c_cpu_b->size[0] = h_cpu_y->size[1] + c_cpu_a->size[1];
            emxEnsureCapacity_real_T(c_cpu_b, b_i, &ld_emlrtRTEI);
            if (!c_b_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(c_cpu_b, &b_gpu_b);
            }

            istart = h_cpu_y->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (istart), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, c_cpu_b);
              }

              ec_detrend_kernel167<<<grid, block>>>(e_gpu_y, istart, b_gpu_b);
              c_b_outdatedOnGpu = false;
              b_outdatedOnCpu = true;
            }

            istart = c_cpu_a->size[1];
            for (b_i = 0; b_i < istart; b_i++) {
              if (b_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_cpu_b, &b_gpu_b);
              }

              c_cpu_b->data[b_i + h_cpu_y->size[1]] = wsize2 / 2.0;
              b_outdatedOnCpu = false;
              c_b_outdatedOnGpu = true;
            }
          } else {
            // 'ec_detrend:129' else
            // 'ec_detrend:130' b = [1:wsize2/2, wsize2/2:-1:1]';
            cpu_d2scaled = wsize2 / 2.0;
            if (cpu_d2scaled < 1.0) {
              g_cpu_y->size[0] = 1;
              g_cpu_y->size[1] = 0;
            } else {
              b_i = g_cpu_y->size[0] * g_cpu_y->size[1];
              g_cpu_y->size[0] = 1;
              g_cpu_y->size[1] = static_cast<int32_T>(cpu_d2scaled - 1.0) + 1;
              emxEnsureCapacity_real_T(g_cpu_y, b_i, &hd_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(g_cpu_y, &f_gpu_y);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int64_T>(cpu_d2scaled - 1.0) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                ec_detrend_kernel157<<<grid, block>>>(cpu_d2scaled, f_gpu_y);
              }
            }

            cpu_d2scaled = wsize2 / 2.0;
            if (cpu_d2scaled < 1.0) {
              i_cpu_y->size[0] = 1;
              i_cpu_y->size[1] = 0;
            } else if (std::floor(cpu_d2scaled) == cpu_d2scaled) {
              b_i = i_cpu_y->size[0] * i_cpu_y->size[1];
              i_cpu_y->size[0] = 1;
              i_cpu_y->size[1] = static_cast<int32_T>(-(1.0 - cpu_d2scaled)) + 1;
              emxEnsureCapacity_real_T(i_cpu_y, b_i, &jd_emlrtRTEI);
              if (!b_y_outdatedOnGpu) {
                gpuEmxEnsureCapacity_real_T(i_cpu_y, &g_gpu_y);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
                static_cast<int64_T>(-(1.0 - cpu_d2scaled)) + 1L), &grid, &block,
                1024U, 65535U);
              if (validLaunchParams) {
                if (b_y_outdatedOnGpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_y, i_cpu_y);
                }

                ec_detrend_kernel163<<<grid, block>>>(cpu_d2scaled, g_gpu_y);
                b_y_outdatedOnGpu = false;
                d_y_outdatedOnCpu = true;
              }
            } else {
              abnrm = std::floor(-(1.0 - cpu_d2scaled) + 0.5);
              rconde = cpu_d2scaled - abnrm;
              if (std::abs(1.0 - rconde) < 4.4408920985006262E-16 * cpu_d2scaled)
              {
                abnrm++;
                rconde = 1.0;
              } else if (1.0 - rconde > 0.0) {
                rconde = cpu_d2scaled - (abnrm - 1.0);
              } else {
                abnrm++;
              }

              b_i = i_cpu_y->size[0] * i_cpu_y->size[1];
              i_cpu_y->size[0] = 1;
              i_cpu_y->size[1] = static_cast<int32_T>(abnrm);
              emxEnsureCapacity_real_T(i_cpu_y, b_i, &nd_emlrtRTEI);
              if (!b_y_outdatedOnGpu) {
                gpuEmxEnsureCapacity_real_T(i_cpu_y, &g_gpu_y);
              }

              if (static_cast<int32_T>(abnrm) > 0) {
                if (d_y_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(i_cpu_y, &g_gpu_y);
                }

                i_cpu_y->data[0] = cpu_d2scaled;
                d_y_outdatedOnCpu = false;
                b_y_outdatedOnGpu = true;
                if (static_cast<int32_T>(abnrm) > 1) {
                  gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_y, i_cpu_y);
                  ec_detrend_kernel158<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                    (rconde, abnrm, g_gpu_y);
                  b_y_outdatedOnGpu = false;
                  istart = (static_cast<int32_T>(abnrm) - 1) / 2;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (istart - 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    ec_detrend_kernel159<<<grid, block>>>(rconde,
                      static_cast<int32_T>(abnrm), cpu_d2scaled, istart, g_gpu_y);
                  }

                  if (istart << 1 == static_cast<int32_T>(abnrm) - 1) {
                    ec_detrend_kernel162<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, cpu_d2scaled, istart, g_gpu_y);
                    d_y_outdatedOnCpu = true;
                  } else {
                    ec_detrend_kernel160<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (cpu_d2scaled, istart, g_gpu_y);
                    ec_detrend_kernel161<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (rconde, istart, g_gpu_y);
                    d_y_outdatedOnCpu = true;
                  }
                }
              }
            }

            b_i = c_cpu_b->size[0];
            c_cpu_b->size[0] = g_cpu_y->size[1] + i_cpu_y->size[1];
            emxEnsureCapacity_real_T(c_cpu_b, b_i, &md_emlrtRTEI);
            if (!c_b_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(c_cpu_b, &b_gpu_b);
            }

            istart = g_cpu_y->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (istart), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, c_cpu_b);
              }

              ec_detrend_kernel164<<<grid, block>>>(f_gpu_y, istart, b_gpu_b);
              c_b_outdatedOnGpu = false;
              b_outdatedOnCpu = true;
            }

            istart = i_cpu_y->size[1];
            for (b_i = 0; b_i < istart; b_i++) {
              if (b_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_cpu_b, &b_gpu_b);
              }

              if (d_y_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_cpu_y, &g_gpu_y);
              }

              d_y_outdatedOnCpu = false;
              c_cpu_b->data[b_i + g_cpu_y->size[1]] = i_cpu_y->data[b_i];
              b_outdatedOnCpu = false;
              c_b_outdatedOnGpu = true;
            }
          }

          //  overlap-add to output
          // 'ec_detrend:134' y(start:stop,:) = y(start:stop,:) + (yy.*b);
          if (start > stop) {
            istart = 0;
            jend = 0;
            npages = 0;
          } else {
            istart = static_cast<int32_T>(start) - 1;
            jend = static_cast<int32_T>(stop);
            npages = static_cast<int32_T>(start) - 1;
          }

          if (cpu_yy->size[0] == 1) {
            r = c_cpu_b->size[0];
          } else {
            r = cpu_yy->size[0];
          }

          if ((cpu_yy->size[0] == c_cpu_b->size[0]) && (jend - istart == r)) {
            b_i = j_cpu_x->size[0];
            j_cpu_x->size[0] = jend - istart;
            emxEnsureCapacity_real_T(j_cpu_x, b_i, &od_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(j_cpu_x, &g_gpu_x);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(jend
              - istart), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, c_cpu_b);
              }

              c_b_outdatedOnGpu = false;
              if (yy_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, cpu_yy);
              }

              yy_outdatedOnGpu = false;
              if (c_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, c_cpu_x);
              }

              c_x_outdatedOnGpu = false;
              ec_detrend_kernel176<<<grid, block>>>(b_gpu_b, gpu_yy, f_gpu_x,
                istart, jend, g_gpu_x);
            }

            b_i = j_cpu_x->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, c_cpu_x);
              }

              ec_detrend_kernel177<<<grid, block>>>(g_gpu_x, npages, b_i,
                f_gpu_x);
              c_x_outdatedOnGpu = false;
              c_x_outdatedOnCpu = true;
            }
          } else {
            if (c_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_cpu_x, &f_gpu_x);
            }

            if (yy_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_yy, &gpu_yy);
            }

            yy_outdatedOnCpu = false;
            if (b_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_cpu_b, &b_gpu_b);
            }

            b_outdatedOnCpu = false;
            binary_expand_op_12(c_cpu_x, npages, istart, jend - 1, cpu_yy,
                                c_cpu_b);
            c_x_outdatedOnCpu = false;
            c_x_outdatedOnGpu = true;
          }

          // bsxfun(@times,yy,b);
          // 'ec_detrend:135' trend(start:stop,:) = trend(start:stop,:) + (x(start:stop,:)-yy).*b;
          if (start > stop) {
            jend = 0;
            npages = 0;
            vlen = -1;
            istart = -1;
            cpu_nx = 0;
          } else {
            jend = static_cast<int32_T>(start) - 1;
            npages = static_cast<int32_T>(stop);
            vlen = static_cast<int32_T>(start) - 2;
            istart = static_cast<int32_T>(stop) - 1;
            cpu_nx = static_cast<int32_T>(start) - 1;
          }

          if (istart - vlen == 1) {
            r = cpu_yy->size[0];
            b_i = cpu_yy->size[0];
          } else {
            r = istart - vlen;
            b_i = istart - vlen;
          }

          if (b_i == 1) {
            b_i = c_cpu_b->size[0];
          } else if (istart - vlen == 1) {
            b_i = cpu_yy->size[0];
          } else {
            b_i = istart - vlen;
          }

          if ((istart - vlen == cpu_yy->size[0]) && (r == c_cpu_b->size[0]) &&
              (npages - jend == b_i)) {
            b_i = b_cpu_trend->size[0];
            b_cpu_trend->size[0] = npages - jend;
            emxEnsureCapacity_real_T(b_cpu_trend, b_i, &pd_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_cpu_trend, &b_gpu_trend);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages - jend), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, c_cpu_b);
              }

              c_b_outdatedOnGpu = false;
              if (yy_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_yy, cpu_yy);
              }

              yy_outdatedOnGpu = false;
              if (b_x_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
              }

              b_x_outdatedOnGpu = false;
              if (trend_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, cpu_trend);
              }

              trend_outdatedOnGpu = false;
              ec_detrend_kernel178<<<grid, block>>>(b_gpu_b, gpu_yy, b_gpu_x,
                vlen, gpu_trend, jend, npages, b_gpu_trend);
            }

            b_i = b_cpu_trend->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (trend_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, cpu_trend);
              }

              ec_detrend_kernel179<<<grid, block>>>(b_gpu_trend, cpu_nx, b_i,
                gpu_trend);
              trend_outdatedOnGpu = false;
              trend_outdatedOnCpu = true;
            }
          } else {
            if (trend_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_trend, &gpu_trend);
            }

            if (b_x_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
            }

            b_x_outdatedOnCpu = false;
            if (yy_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_yy, &gpu_yy);
            }

            yy_outdatedOnCpu = false;
            if (b_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_cpu_b, &b_gpu_b);
            }

            b_outdatedOnCpu = false;
            binary_expand_op_11(cpu_trend, cpu_nx, jend, npages - 1, b_cpu_x,
                                vlen + 1, istart, cpu_yy, c_cpu_b);
            trend_outdatedOnCpu = false;
            trend_outdatedOnGpu = true;
          }

          // bsxfun(@times,x(start:stop,:)-yy,b);
          // 'ec_detrend:136' a(start:stop,1) = a(start:stop)+b;
          if (start > stop) {
            istart = 0;
            jend = 0;
            npages = 0;
          } else {
            istart = static_cast<int32_T>(start) - 1;
            jend = static_cast<int32_T>(stop);
            npages = static_cast<int32_T>(start) - 1;
          }

          if (jend - istart == c_cpu_b->size[0]) {
            b_i = d_cpu_a->size[0];
            d_cpu_a->size[0] = jend - istart;
            emxEnsureCapacity_real_T(d_cpu_a, b_i, &qd_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(d_cpu_a, &c_gpu_a);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(jend
              - istart), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (c_b_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, c_cpu_b);
              }

              c_b_outdatedOnGpu = false;
              if (a_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
              }

              a_outdatedOnGpu = false;
              ec_detrend_kernel180<<<grid, block>>>(b_gpu_b, gpu_a, istart, jend,
                c_gpu_a);
            }

            b_i = d_cpu_a->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (a_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
              }

              ec_detrend_kernel181<<<grid, block>>>(c_gpu_a, npages, b_i, gpu_a);
              a_outdatedOnGpu = false;
              a_outdatedOnCpu = true;
            }
          } else {
            if (a_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_a, &gpu_a);
            }

            if (b_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_cpu_b, &b_gpu_b);
            }

            b_outdatedOnCpu = false;
            binary_expand_op_10(cpu_a, npages, istart, jend - 1, c_cpu_b);
            a_outdatedOnCpu = false;
            a_outdatedOnGpu = true;
          }

          // 'ec_detrend:137' offset = offset+winSz/2;
          offset += winSz / 2.0;

          // 'ec_detrend:138' if offset > dims(1)-winSz/2
        } while (!(offset > static_cast<real_T>(dims_idx_0) - winSz / 2.0));

        // 'ec_detrend:138' ;
        // 'ec_detrend:141' if stop<dims(1)
        if (stop < dims_idx_0) {
          //  last sample can be missed
          // 'ec_detrend:142' y(end,:) = y(end-1,:);
          if (a_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
          }

          if (c_x_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, c_cpu_x);
          }

          ec_detrend_kernel182<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a,
            f_gpu_x, c_cpu_x->size[0U], cpu_a->size[0U]);
          c_x_outdatedOnGpu = false;
          c_x_outdatedOnCpu = true;
          a_outdatedOnGpu = false;
          a_outdatedOnCpu = true;
        }

        // 'ec_detrend:145' y = y.*(1./a);
        if (c_cpu_x->size[0] == cpu_a->size[0]) {
          b_i = c_cpu_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (a_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
            }

            a_outdatedOnGpu = false;
            if (c_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, c_cpu_x);
            }

            ec_detrend_kernel183<<<grid, block>>>(gpu_a, b_i, f_gpu_x);
            c_x_outdatedOnGpu = false;
            c_x_outdatedOnCpu = true;
          }
        } else {
          if (c_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_cpu_x, &f_gpu_x);
          }

          if (a_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_a, &gpu_a);
          }

          a_outdatedOnCpu = false;
          binary_expand_op_8(c_cpu_x, cpu_a);
          c_x_outdatedOnCpu = false;
          c_x_outdatedOnGpu = true;
        }

        // bsxfun(@times,y,1./a);
        // 'ec_detrend:146' y(isnan(y)) = 0;
        vlen = c_cpu_x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_x_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, c_cpu_x);
          }

          ec_detrend_kernel184<<<grid, block>>>(vlen, f_gpu_x);
          c_x_outdatedOnGpu = false;
          c_x_outdatedOnCpu = true;
        }

        // 'ec_detrend:147' trend = trend.*(1./a);
        if (cpu_trend->size[0] == cpu_a->size[0]) {
          b_i = cpu_trend->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (a_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
            }

            a_outdatedOnGpu = false;
            if (trend_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, cpu_trend);
            }

            ec_detrend_kernel185<<<grid, block>>>(gpu_a, b_i, gpu_trend);
            trend_outdatedOnGpu = false;
            trend_outdatedOnCpu = true;
          }
        } else {
          if (trend_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_trend, &gpu_trend);
          }

          if (a_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_a, &gpu_a);
          }

          a_outdatedOnCpu = false;
          binary_expand_op_8(cpu_trend, cpu_a);
          trend_outdatedOnCpu = false;
          trend_outdatedOnGpu = true;
        }

        // bsxfun(@times,trend,1./a);
        // 'ec_detrend:148' trend(isnan(trend)) = 0;
        vlen = cpu_trend->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (trend_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, cpu_trend);
          }

          ec_detrend_kernel186<<<grid, block>>>(vlen, gpu_trend);
          trend_outdatedOnGpu = false;
          trend_outdatedOnCpu = true;
        }

        //  Find outliers
        // 'ec_detrend:151' d = (x-trend).*w;
        if (b_cpu_x->size[0] == 1) {
          r = cpu_trend->size[0];
        } else {
          r = b_cpu_x->size[0];
        }

        if ((b_cpu_x->size[0] == cpu_trend->size[0]) && (r == b_cpu_w->size[0]))
        {
          b_i = c_cpu_d->size[0];
          c_cpu_d->size[0] = b_cpu_x->size[0];
          emxEnsureCapacity_real_T(c_cpu_d, b_i, &rd_emlrtRTEI);
          if (!c_d_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(c_cpu_d, &b_gpu_d);
          }

          b_i = b_cpu_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (trend_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_trend, cpu_trend);
            }

            trend_outdatedOnGpu = false;
            if (b_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
            }

            b_x_outdatedOnGpu = false;
            if (c_d_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, c_cpu_d);
            }

            ec_detrend_kernel187<<<grid, block>>>(b_gpu_w, gpu_trend, b_gpu_x,
              b_i, b_gpu_d);
            c_d_outdatedOnGpu = false;
            c_d_outdatedOnCpu = true;
          }
        } else {
          if (c_d_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_cpu_d, &b_gpu_d);
          }

          if (b_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
          }

          b_x_outdatedOnCpu = false;
          if (trend_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_trend, &gpu_trend);
          }

          trend_outdatedOnCpu = false;
          if (b_w_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
          }

          b_w_outdatedOnCpu = false;
          binary_expand_op(c_cpu_d, b_cpu_x, cpu_trend, b_cpu_w);
          c_d_outdatedOnCpu = false;
          c_d_outdatedOnGpu = true;
        }

        // 'ec_detrend:152' thrItr = thr*std(d);
        npages = c_cpu_d->size[0] - 1;
        if (c_cpu_d->size[0] == 0) {
          cpu_d2scaled = rtNaN;
        } else if (c_cpu_d->size[0] == 1) {
          if (c_d_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, c_cpu_d);
          }

          c_d_outdatedOnGpu = false;
          cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 8UL, cudaMemcpyHostToDevice);
          ec_detrend_kernel189<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_d,
            gpu_d2scaled);
          cudaMemcpy(&cpu_d2scaled, gpu_d2scaled, 8UL, cudaMemcpyDeviceToHost);
        } else {
          if (c_d_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_cpu_d, &b_gpu_d);
          }

          c_d_outdatedOnCpu = false;
          cpu_d2scaled = c_cpu_d->data[0];
          for (b_i = 0; b_i < npages; b_i++) {
            cpu_d2scaled += c_cpu_d->data[b_i + 1];
          }

          cpu_d2scaled /= static_cast<real_T>(c_cpu_d->size[0]);
          b_i = c_cpu_absdiff->size[0];
          c_cpu_absdiff->size[0] = c_cpu_d->size[0];
          emxEnsureCapacity_real_T(c_cpu_absdiff, b_i, &cd_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_cpu_absdiff, &b_gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (c_d_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, c_cpu_d);
            }

            c_d_outdatedOnGpu = false;
            ec_detrend_kernel188<<<grid, block>>>(cpu_d2scaled, b_gpu_d, npages,
              b_gpu_absdiff);
          }

          cublasDnrm2(getCublasGlobalHandle(), c_cpu_d->size[0], (double *)
                      &b_gpu_absdiff.data[0], 1, (double *)&cpu_d2scaled);
          cpu_d2scaled /= std::sqrt(static_cast<real_T>(c_cpu_d->size[0]) - 1.0);
        }

        cpu_d2scaled *= thr;

        // 'ec_detrend:153' w(abs(d)>thrItr) = 0;
        cpu_nx = c_cpu_d->size[0];
        b_i = j_cpu_y->size[0];
        j_cpu_y->size[0] = c_cpu_d->size[0];
        emxEnsureCapacity_real_T(j_cpu_y, b_i, &dd_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_cpu_y, &c_gpu_y);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(cpu_nx),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_d_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_d, c_cpu_d);
          }

          c_d_outdatedOnGpu = false;
          ec_detrend_kernel190<<<grid, block>>>(b_gpu_d, cpu_nx, c_gpu_y);
        }

        vlen = j_cpu_y->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detrend_kernel191<<<grid, block>>>(cpu_d2scaled, c_gpu_y, vlen,
            b_gpu_w);
          b_w_outdatedOnCpu = true;
        }

        //  update weights
      }

      b_i = b_cpu_x->size[0];
      b_cpu_x->size[0] = c_cpu_x->size[0];
      emxEnsureCapacity_real_T(b_cpu_x, b_i, &g_emlrtRTEI);
      if (!b_x_outdatedOnGpu) {
        gpuEmxEnsureCapacity_real_T(b_cpu_x, &b_gpu_x);
      }

      b_i = c_cpu_x->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (c_x_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_x, c_cpu_x);
        }

        c_x_outdatedOnGpu = false;
        if (b_x_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
        }

        ec_detrend_kernel192<<<grid, block>>>(f_gpu_x, b_i, b_gpu_x);
        b_x_outdatedOnGpu = false;
        b_x_outdatedOnCpu = true;
      }
    } else {
      int32_T i7;

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
      istart = cpu_r->size[0] * cpu_r->size[1];
      cpu_r->size[0] = b_i;
      cpu_r->size[1] = static_cast<int32_T>(order);
      emxEnsureCapacity_real_T(cpu_r, istart, &f_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_r, &c_gpu_r);

      // 'ec_detrend:76' lin = linspace(-1,1,nFrames);
      istart = cpu_lin->size[0] * cpu_lin->size[1];
      cpu_lin->size[0] = 1;
      cpu_lin->size[1] = b_i;
      emxEnsureCapacity_real_T(cpu_lin, istart, &i_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_lin, &b_gpu_lin);
      if (b_i >= 1) {
        ec_detrend_kernel4<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_i,
          b_gpu_lin);
        if (cpu_lin->size[1] >= 2) {
          ec_detrend_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_lin);
          if (cpu_lin->size[1] >= 3) {
            cpu_d2scaled = 1.0 / (static_cast<real_T>(cpu_lin->size[1]) - 1.0);
            istart = cpu_lin->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (istart - 2L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel6<<<grid, block>>>(cpu_d2scaled, istart,
                b_gpu_lin, cpu_lin->size[1U]);
            }

            if ((cpu_lin->size[1] & 1) == 1) {
              ec_detrend_kernel7<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (b_gpu_lin, cpu_lin->size[1U]);
            }
          }
        }
      }

      // 'ec_detrend:77' for k=1:order
      istart = static_cast<int32_T>(order);
      cpu_nx = cpu_lin->size[1];
      for (jend = 0; jend < istart; jend++) {
        // 'ec_detrend:78' r(:,k) = lin.^k;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(cpu_nx),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detrend_kernel8<<<grid, block>>>(b_gpu_lin, jend, cpu_nx, c_gpu_r,
            cpu_r->size[0U]);
          r_outdatedOnCpu = true;
        }
      }

      //  Remove trends
      // 'ec_detrend:82' z = coder.nullcopy(zeros(size(x),'like',x));
      b_i = cpu_z->size[0];
      cpu_z->size[0] = cpu_x->size[0];
      emxEnsureCapacity_real_T(cpu_z, b_i, &k_emlrtRTEI);
      if (!z_outdatedOnGpu) {
        gpuEmxEnsureCapacity_real_T(cpu_z, &b_gpu_z);
      }

      // 'ec_detrend:83' for ii = 1:nItr
      i7 = static_cast<int32_T>(nItr);
      for (int32_T ii{0}; ii < i7; ii++) {
        real_T mn;
        int32_T b_i12;
        int32_T r;

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
        if (b_cpu_x->size[0] == b_cpu_w->size[0]) {
          b_i = d_cpu_x->size[0];
          d_cpu_x->size[0] = b_cpu_x->size[0];
          emxEnsureCapacity_real_T(d_cpu_x, b_i, &m_emlrtRTEI);
          if (!d_x_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(d_cpu_x, &h_gpu_x);
          }

          b_i = b_cpu_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
            }

            b_x_outdatedOnGpu = false;
            if (d_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_x, d_cpu_x);
            }

            ec_detrend_kernel9<<<grid, block>>>(b_gpu_w, b_gpu_x, b_i, h_gpu_x);
            d_x_outdatedOnGpu = false;
            d_x_outdatedOnCpu = true;
          }
        } else {
          if (d_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &h_gpu_x);
          }

          if (b_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
          }

          b_x_outdatedOnCpu = false;
          if (b_w_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
          }

          b_w_outdatedOnCpu = false;
          times(d_cpu_x, b_cpu_x, b_cpu_w);
          d_x_outdatedOnCpu = false;
          d_x_outdatedOnGpu = true;
        }

        vlen = d_cpu_x->size[0];
        if (d_cpu_x->size[0] == 0) {
          cpu_d2scaled = 0.0;
        } else {
          if (d_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &h_gpu_x);
          }

          d_x_outdatedOnCpu = false;
          cpu_d2scaled = d_cpu_x->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            cpu_d2scaled += d_cpu_x->data[b_i + 1];
          }
        }

        vlen = b_cpu_w->size[0];
        if (b_cpu_w->size[0] == 0) {
          abnrm = 0.0;
        } else {
          if (b_w_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
          }

          b_w_outdatedOnCpu = false;
          abnrm = b_cpu_w->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            abnrm += b_cpu_w->data[b_i + 1];
          }
        }

        mn = cpu_d2scaled / (abnrm + 2.2204460492503131E-16);

        // 'ec_detrend:188' x = x - mn;
        //  Fit weighted regression
        // 'ec_detrend:171' x = demean_lfn(x,w).* w;
        //  Demean
        // 'ec_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (b_cpu_x->size[0] == b_cpu_w->size[0]) {
          b_i = e_cpu_x->size[0];
          e_cpu_x->size[0] = b_cpu_x->size[0];
          emxEnsureCapacity_real_T(e_cpu_x, b_i, &m_emlrtRTEI);
          if (!e_x_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(e_cpu_x, &i_gpu_x);
          }

          b_i = b_cpu_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
            }

            b_x_outdatedOnGpu = false;
            if (e_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_x, e_cpu_x);
            }

            ec_detrend_kernel10<<<grid, block>>>(b_gpu_w, b_gpu_x, b_i, i_gpu_x);
            e_x_outdatedOnGpu = false;
            e_x_outdatedOnCpu = true;
          }
        } else {
          if (e_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_cpu_x, &i_gpu_x);
          }

          if (b_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
          }

          b_x_outdatedOnCpu = false;
          if (b_w_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
          }

          b_w_outdatedOnCpu = false;
          times(e_cpu_x, b_cpu_x, b_cpu_w);
          e_x_outdatedOnCpu = false;
          e_x_outdatedOnGpu = true;
        }

        vlen = e_cpu_x->size[0];
        if (e_cpu_x->size[0] == 0) {
          cpu_d2scaled = 0.0;
        } else {
          if (e_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_cpu_x, &i_gpu_x);
          }

          e_x_outdatedOnCpu = false;
          cpu_d2scaled = e_cpu_x->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            cpu_d2scaled += e_cpu_x->data[b_i + 1];
          }
        }

        vlen = b_cpu_w->size[0];
        if (b_cpu_w->size[0] == 0) {
          abnrm = 0.0;
        } else {
          if (b_w_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
          }

          b_w_outdatedOnCpu = false;
          abnrm = b_cpu_w->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            abnrm += b_cpu_w->data[b_i + 1];
          }
        }

        cpu_d2scaled /= abnrm + 2.2204460492503131E-16;

        // 'ec_detrend:188' x = x - mn;
        if (b_cpu_x->size[0] == b_cpu_w->size[0]) {
          b_i = cpu_dv1->size[0];
          cpu_dv1->size[0] = b_cpu_x->size[0];
          emxEnsureCapacity_real_T(cpu_dv1, b_i, &o_emlrtRTEI);
          if (!dv1_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_dv1, &gpu_dv1);
          }

          b_i = b_cpu_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
            }

            b_x_outdatedOnGpu = false;
            if (dv1_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, cpu_dv1);
            }

            ec_detrend_kernel11<<<grid, block>>>(b_gpu_w, cpu_d2scaled, b_gpu_x,
              b_i, gpu_dv1);
            dv1_outdatedOnGpu = false;
            dv1_outdatedOnCpu = true;
          }
        } else {
          if (dv1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv1, &gpu_dv1);
          }

          if (b_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
          }

          b_x_outdatedOnCpu = false;
          if (b_w_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
          }

          b_w_outdatedOnCpu = false;
          binary_expand_op_5(cpu_dv1, b_cpu_x, cpu_d2scaled, b_cpu_w);
          dv1_outdatedOnCpu = false;
          dv1_outdatedOnGpu = true;
        }

        // 'ec_detrend:172' r = demean_lfn(r,w);
        //  Demean
        // 'ec_detrend:187' mn = sum(x.*w,1) ./ (sum(w,1)+eps);
        if (cpu_r->size[0] == b_cpu_w->size[0]) {
          b_i = f_cpu_x->size[0] * f_cpu_x->size[1];
          f_cpu_x->size[0] = cpu_r->size[0];
          f_cpu_x->size[1] = cpu_r->size[1];
          emxEnsureCapacity_real_T(f_cpu_x, b_i, &m_emlrtRTEI);
          if (!f_x_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(f_cpu_x, &j_gpu_x);
          }

          b_i = cpu_r->size[1] - 1;
          r = cpu_r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((r +
            1L) * (b_i + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (f_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_x, f_cpu_x);
            }

            ec_detrend_kernel12<<<grid, block>>>(b_gpu_w, c_gpu_r, r, b_i,
              j_gpu_x, f_cpu_x->size[0U], cpu_r->size[0U]);
            f_x_outdatedOnGpu = false;
            f_x_outdatedOnCpu = true;
          }
        } else {
          if (f_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(f_cpu_x, &j_gpu_x);
          }

          if (r_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_r, &c_gpu_r);
          }

          r_outdatedOnCpu = false;
          if (b_w_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
          }

          b_w_outdatedOnCpu = false;
          binary_expand_op_2(f_cpu_x, cpu_r, b_cpu_w);
          f_x_outdatedOnCpu = false;
          f_x_outdatedOnGpu = true;
        }

        vlen = f_cpu_x->size[0];
        if ((f_cpu_x->size[0] == 0) || (f_cpu_x->size[1] == 0)) {
          for (b_i = 0; b_i < 2; b_i++) {
            sz[b_i] = static_cast<uint32_T>(f_cpu_x->size[b_i]);
          }

          b_i = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = static_cast<int32_T>(sz[1]);
          emxEnsureCapacity_real_T(cpu_y, b_i, &q_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_y, &h_gpu_y);
          b_i = static_cast<int32_T>(sz[1]) - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel14<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
              h_gpu_y);
            y_outdatedOnCpu = true;
          }
        } else {
          npages = f_cpu_x->size[1];
          b_i = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = f_cpu_x->size[1];
          emxEnsureCapacity_real_T(cpu_y, b_i, &p_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_y, &h_gpu_y);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (f_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_x, f_cpu_x);
            }

            f_x_outdatedOnGpu = false;
            ec_detrend_kernel13<<<grid, block>>>(vlen, j_gpu_x, npages, h_gpu_y,
              f_cpu_x->size[0U]);
            y_outdatedOnCpu = true;
          }
        }

        vlen = b_cpu_w->size[0];
        if (b_cpu_w->size[0] == 0) {
          cpu_d2scaled = 0.0;
        } else {
          if (b_w_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
          }

          b_w_outdatedOnCpu = false;
          cpu_d2scaled = b_cpu_w->data[0];
          for (b_i = 0; b_i <= vlen - 2; b_i++) {
            cpu_d2scaled += b_cpu_w->data[b_i + 1];
          }
        }

        // 'ec_detrend:188' x = x - mn;
        if (cpu_r->size[1] == cpu_y->size[1]) {
          cpu_d2scaled += 2.2204460492503131E-16;
          b_i = c_cpu_r->size[0] * c_cpu_r->size[1];
          c_cpu_r->size[0] = cpu_r->size[0];
          c_cpu_r->size[1] = cpu_r->size[1];
          emxEnsureCapacity_real_T(c_cpu_r, b_i, &r_emlrtRTEI);
          if (!b_r_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(c_cpu_r, &d_gpu_r);
          }

          b_i = cpu_r->size[1] - 1;
          r = cpu_r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((r +
            1L) * (b_i + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_r_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_r, c_cpu_r);
            }

            ec_detrend_kernel15<<<grid, block>>>(cpu_d2scaled, h_gpu_y, c_gpu_r,
              r, b_i, d_gpu_r, c_cpu_r->size[0U], cpu_r->size[0U]);
            b_r_outdatedOnGpu = false;
            c_r_outdatedOnCpu = true;
          }
        } else {
          if (c_r_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_cpu_r, &d_gpu_r);
          }

          if (r_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_r, &c_gpu_r);
          }

          r_outdatedOnCpu = false;
          if (y_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_y, &h_gpu_y);
          }

          y_outdatedOnCpu = false;
          binary_expand_op_3(c_cpu_r, cpu_r, cpu_y, cpu_d2scaled);
          c_r_outdatedOnCpu = false;
          b_r_outdatedOnGpu = true;
        }

        //  remove channel-specific-weighted mean from regressor
        // 'ec_detrend:173' rr = r.*w;
        if (c_cpu_r->size[0] == b_cpu_w->size[0]) {
          b_i = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = c_cpu_r->size[0];
          cpu_rr->size[1] = c_cpu_r->size[1];
          emxEnsureCapacity_real_T(cpu_rr, b_i, &s_emlrtRTEI);
          if (!rr_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_rr, &b_gpu_rr);
          }

          b_i = c_cpu_r->size[1] - 1;
          r = c_cpu_r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((r +
            1L) * (b_i + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_r_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_r, c_cpu_r);
            }

            b_r_outdatedOnGpu = false;
            if (rr_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, cpu_rr);
            }

            ec_detrend_kernel16<<<grid, block>>>(b_gpu_w, d_gpu_r, r, b_i,
              b_gpu_rr, cpu_rr->size[0U], c_cpu_r->size[0U]);
            rr_outdatedOnGpu = false;
            rr_outdatedOnCpu = true;
          }
        } else {
          if (rr_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_rr, &b_gpu_rr);
          }

          if (c_r_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_cpu_r, &d_gpu_r);
          }

          c_r_outdatedOnCpu = false;
          if (b_w_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
          }

          b_w_outdatedOnCpu = false;
          binary_expand_op_2(cpu_rr, c_cpu_r, b_cpu_w);
          rr_outdatedOnCpu = false;
          rr_outdatedOnGpu = true;
        }

        // 'ec_detrend:174' [V,D] = eig(rr'*rr);
        b_i = b_cpu_A->size[0] * b_cpu_A->size[1];
        b_cpu_A->size[0] = cpu_rr->size[1];
        b_cpu_A->size[1] = cpu_rr->size[0];
        emxEnsureCapacity_real_T(b_cpu_A, b_i, &t_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_A, &h_gpu_A);
        r = cpu_rr->size[0] - 1;
        b_i = cpu_rr->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i +
          1L) * (r + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, cpu_rr);
          }

          rr_outdatedOnGpu = false;
          ec_detrend_kernel17<<<grid, block>>>(b_gpu_rr, b_i, r, h_gpu_A,
            b_cpu_A->size[0U], cpu_rr->size[0U]);
        }

        if ((b_cpu_A->size[0] == 0) || (b_cpu_A->size[1] == 0) || (cpu_rr->size
             [0] == 0) || (cpu_rr->size[1] == 0)) {
          b_i = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = b_cpu_A->size[0];
          cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(cpu_A, b_i, &v_emlrtRTEI);
          if (!A_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_A, &i_gpu_A);
          }

          r = b_cpu_A->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (A_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, cpu_A);
            }

            ec_detrend_kernel18<<<grid, block>>>(r, i_gpu_A);
            A_outdatedOnGpu = false;
            A_outdatedOnCpu = true;
          }
        } else {
          b_i = cpu_A->size[0] * cpu_A->size[1];
          cpu_A->size[0] = b_cpu_A->size[0];
          cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(cpu_A, b_i, &u_emlrtRTEI);
          if (!A_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_A, &i_gpu_A);
          }

          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          if (rr_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, cpu_rr);
          }

          rr_outdatedOnGpu = false;
          if (A_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, cpu_A);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      b_cpu_A->size[0], cpu_rr->size[1], b_cpu_A->size[1],
                      (double *)&cpu_d2scaled, (double *)&h_gpu_A.data[0],
                      b_cpu_A->size[0], (double *)&b_gpu_rr.data[0],
                      b_cpu_A->size[1], (double *)&abnrm, (double *)
                      &i_gpu_A.data[0], b_cpu_A->size[0]);
          A_outdatedOnGpu = false;
          A_outdatedOnCpu = true;
        }

        npages = cpu_A->size[0];
        b_i = cpu_V->size[0] * cpu_V->size[1];
        cpu_V->size[0] = cpu_A->size[0];
        cpu_V->size[1] = cpu_A->size[0];
        emxEnsureCapacity_creal_T(cpu_V, b_i, &w_emlrtRTEI);
        if (!V_outdatedOnGpu) {
          gpuEmxEnsureCapacity_creal_T(cpu_V, &d_gpu_V);
        }

        b_i = cpu_D->size[0] * cpu_D->size[1];
        cpu_D->size[0] = cpu_A->size[0];
        cpu_D->size[1] = cpu_A->size[0];
        emxEnsureCapacity_creal_T(cpu_D, b_i, &x_emlrtRTEI);
        if (!D_outdatedOnGpu) {
          gpuEmxEnsureCapacity_creal_T(cpu_D, &c_gpu_D);
        }

        if ((cpu_A->size[0] != 0) && (cpu_A->size[1] != 0)) {
          cpu_nx = cpu_A->size[0] * cpu_A->size[1];
          validLaunchParams = true;
          for (jend = 0; jend < cpu_nx; jend++) {
            if (validLaunchParams) {
              if (A_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &i_gpu_A);
              }

              A_outdatedOnCpu = false;
              if (std::isinf(cpu_A->data[jend]) || std::isnan(cpu_A->data[jend]))
              {
                validLaunchParams = false;
              }
            } else {
              validLaunchParams = false;
            }
          }

          if (!validLaunchParams) {
            for (b_i = 0; b_i < 2; b_i++) {
              i12[b_i] = cpu_V->size[b_i];
            }

            b_i = cpu_V->size[0] * cpu_V->size[1];
            cpu_V->size[0] = i12[0];
            cpu_V->size[1] = i12[1];
            emxEnsureCapacity_creal_T(cpu_V, b_i, &ab_emlrtRTEI);
            if (!V_outdatedOnGpu) {
              gpuEmxEnsureCapacity_creal_T(cpu_V, &d_gpu_V);
            }

            b_i12 = i12[0] * i12[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_i12 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (V_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&d_gpu_V, cpu_V);
              }

              ec_detrend_kernel41<<<grid, block>>>(dc, b_i12, d_gpu_V);
              V_outdatedOnGpu = false;
              V_outdatedOnCpu = true;
            }

            for (b_i = 0; b_i < 2; b_i++) {
              i12[b_i] = cpu_D->size[b_i];
            }

            b_i = cpu_D->size[0] * cpu_D->size[1];
            cpu_D->size[0] = i12[0];
            cpu_D->size[1] = i12[1];
            emxEnsureCapacity_creal_T(cpu_D, b_i, &fb_emlrtRTEI);
            if (!D_outdatedOnGpu) {
              gpuEmxEnsureCapacity_creal_T(cpu_D, &c_gpu_D);
            }

            b_i12 = i12[0] * i12[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_i12 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (D_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_D, cpu_D);
              }

              ec_detrend_kernel42<<<grid, block>>>(b_i12, c_gpu_D);
              D_outdatedOnGpu = false;
              D_outdatedOnCpu = true;
            }

            for (jend = 0; jend < npages; jend++) {
              if (D_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_creal_T(cpu_D, &c_gpu_D);
              }

              cpu_D->data[jend + cpu_D->size[0] * jend] = dc;
              D_outdatedOnCpu = false;
              D_outdatedOnGpu = true;
            }
          } else {
            int32_T exitg1;
            boolean_T exitg2;
            validLaunchParams = (cpu_A->size[0] == cpu_A->size[1]);
            if (validLaunchParams) {
              cpu_nx = 0;
              exitg2 = false;
              while ((!exitg2) && (cpu_nx <= cpu_A->size[1] - 1)) {
                b_i = 0;
                do {
                  exitg1 = 0;
                  if (b_i <= cpu_nx) {
                    if (A_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &i_gpu_A);
                    }

                    A_outdatedOnCpu = false;
                    if (!(cpu_A->data[b_i + cpu_A->size[0] * cpu_nx] ==
                          cpu_A->data[cpu_nx + cpu_A->size[0] * b_i])) {
                      validLaunchParams = false;
                      exitg1 = 1;
                    } else {
                      b_i++;
                    }
                  } else {
                    cpu_nx++;
                    exitg1 = 2;
                  }
                } while (exitg1 == 0);

                if (exitg1 == 1) {
                  exitg2 = true;
                }
              }
            }

            if (validLaunchParams) {
              ptrdiff_t info_t;
              ptrdiff_t n_t;
              npages = cpu_A->size[0];
              n_t = (ptrdiff_t)cpu_A->size[0];
              b_i = cpu_W->size[0];
              cpu_W->size[0] = cpu_A->size[0];
              emxEnsureCapacity_real_T(cpu_W, b_i, &cb_emlrtRTEI);
              if (!W_outdatedOnGpu) {
                gpuEmxEnsureCapacity_real_T(cpu_W, &c_gpu_W);
              }

              if (A_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &i_gpu_A);
              }

              if (W_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_W, &c_gpu_W);
              }

              info_t = LAPACKE_dsyev(102, 'V', 'L', n_t, &cpu_A->data[0], n_t,
                &cpu_W->data[0]);
              W_outdatedOnCpu = false;
              W_outdatedOnGpu = true;
              A_outdatedOnCpu = false;
              A_outdatedOnGpu = true;
              if ((int32_T)info_t < 0) {
                vlen = cpu_W->size[0];
                b_i = cpu_W->size[0];
                cpu_W->size[0] = vlen;
                emxEnsureCapacity_real_T(cpu_W, b_i, &jb_emlrtRTEI);
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (vlen), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_W, cpu_W);
                  ec_detrend_kernel37<<<grid, block>>>(vlen, c_gpu_W);
                  W_outdatedOnGpu = false;
                  W_outdatedOnCpu = true;
                }

                for (b_i = 0; b_i < 2; b_i++) {
                  i12[b_i] = cpu_A->size[b_i];
                }

                b_i = cpu_A->size[0] * cpu_A->size[1];
                cpu_A->size[0] = i12[0];
                cpu_A->size[1] = i12[1];
                emxEnsureCapacity_real_T(cpu_A, b_i, &qb_emlrtRTEI);
                b_i12 = i12[0] * i12[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_i12 + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, cpu_A);
                  ec_detrend_kernel38<<<grid, block>>>(b_i12, i_gpu_A);
                  A_outdatedOnGpu = false;
                  A_outdatedOnCpu = true;
                }
              }

              b_i = cpu_D->size[0] * cpu_D->size[1];
              cpu_D->size[0] = npages;
              cpu_D->size[1] = npages;
              emxEnsureCapacity_creal_T(cpu_D, b_i, &ib_emlrtRTEI);
              if (!D_outdatedOnGpu) {
                gpuEmxEnsureCapacity_creal_T(cpu_D, &c_gpu_D);
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (npages * npages), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (D_outdatedOnGpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_D, cpu_D);
                }

                ec_detrend_kernel39<<<grid, block>>>(npages, c_gpu_D);
                D_outdatedOnGpu = false;
                D_outdatedOnCpu = true;
              }

              for (b_i = 0; b_i < npages; b_i++) {
                if (D_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_creal_T(cpu_D, &c_gpu_D);
                }

                if (W_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_W, &c_gpu_W);
                }

                W_outdatedOnCpu = false;
                cpu_D->data[b_i + cpu_D->size[0] * b_i].re = cpu_W->data[b_i];
                cpu_D->data[b_i + cpu_D->size[0] * b_i].im = 0.0;
                D_outdatedOnCpu = false;
                D_outdatedOnGpu = true;
              }

              b_i = cpu_V->size[0] * cpu_V->size[1];
              cpu_V->size[0] = cpu_A->size[0];
              cpu_V->size[1] = cpu_A->size[1];
              emxEnsureCapacity_creal_T(cpu_V, b_i, &rb_emlrtRTEI);
              if (!V_outdatedOnGpu) {
                gpuEmxEnsureCapacity_creal_T(cpu_V, &d_gpu_V);
              }

              r = cpu_A->size[0] * cpu_A->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (A_outdatedOnGpu) {
                  gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, cpu_A);
                }

                A_outdatedOnGpu = false;
                if (V_outdatedOnGpu) {
                  gpuEmxMemcpyCpuToGpu_creal_T(&d_gpu_V, cpu_V);
                }

                ec_detrend_kernel40<<<grid, block>>>(i_gpu_A, r, d_gpu_V);
                V_outdatedOnGpu = false;
                V_outdatedOnCpu = true;
              }
            } else {
              validLaunchParams = (cpu_A->size[0] == cpu_A->size[1]);
              if (validLaunchParams) {
                cpu_nx = 0;
                exitg2 = false;
                while ((!exitg2) && (cpu_nx <= cpu_A->size[1] - 1)) {
                  b_i = 0;
                  do {
                    exitg1 = 0;
                    if (b_i <= cpu_nx) {
                      if (A_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &i_gpu_A);
                      }

                      A_outdatedOnCpu = false;
                      if (!(cpu_A->data[b_i + cpu_A->size[0] * cpu_nx] ==
                            -cpu_A->data[cpu_nx + cpu_A->size[0] * b_i])) {
                        validLaunchParams = false;
                        exitg1 = 1;
                      } else {
                        b_i++;
                      }
                    } else {
                      cpu_nx++;
                      exitg1 = 2;
                    }
                  } while (exitg1 == 0);

                  if (exitg1 == 1) {
                    exitg2 = true;
                  }
                }
              }

              if (validLaunchParams) {
                cpu_nx = cpu_A->size[0] * cpu_A->size[1];
                for (jend = 0; jend < cpu_nx; jend++) {
                  if (validLaunchParams) {
                    if (A_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &i_gpu_A);
                    }

                    A_outdatedOnCpu = false;
                    if (std::isinf(cpu_A->data[jend]) || std::isnan(cpu_A->
                         data[jend])) {
                      validLaunchParams = false;
                    }
                  } else {
                    validLaunchParams = false;
                  }
                }

                if (!validLaunchParams) {
                  for (b_i = 0; b_i < 2; b_i++) {
                    sz[b_i] = static_cast<uint32_T>(cpu_A->size[b_i]);
                  }

                  b_i = cpu_U->size[0] * cpu_U->size[1];
                  cpu_U->size[0] = static_cast<int32_T>(sz[0]);
                  cpu_U->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real_T(cpu_U, b_i, &nb_emlrtRTEI);
                  if (!U_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_real_T(cpu_U, &b_gpu_U);
                  }

                  b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (U_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, cpu_U);
                    }

                    ec_detrend_kernel32<<<grid, block>>>(b_i, b_gpu_U);
                    U_outdatedOnGpu = false;
                    U_outdatedOnCpu = true;
                  }

                  vlen = static_cast<int32_T>(sz[0]);
                  if (static_cast<int32_T>(sz[0]) > 1) {
                    istart = 2;
                    if (static_cast<int32_T>(sz[0]) - 2 < static_cast<int32_T>
                        (sz[1]) - 1) {
                      jend = static_cast<int32_T>(sz[0]) - 1;
                    } else {
                      jend = static_cast<int32_T>(sz[1]);
                    }

                    for (cpu_nx = 0; cpu_nx < jend; cpu_nx++) {
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(computeEndIdx(static_cast<int64_T>
                           (istart), static_cast<int64_T>(vlen), 1L) + 1L),
                         &grid, &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        if (U_outdatedOnGpu) {
                          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, cpu_U);
                        }

                        ec_detrend_kernel33<<<grid, block>>>(cpu_nx + 1, vlen,
                          istart, b_gpu_U, cpu_U->size[0U]);
                        U_outdatedOnGpu = false;
                        U_outdatedOnCpu = true;
                      }

                      istart++;
                    }
                  }

                  for (b_i = 0; b_i < 2; b_i++) {
                    sz[b_i] = static_cast<uint32_T>(cpu_A->size[b_i]);
                  }

                  b_i = cpu_A->size[0] * cpu_A->size[1];
                  cpu_A->size[0] = static_cast<int32_T>(sz[0]);
                  cpu_A->size[1] = static_cast<int32_T>(sz[1]);
                  emxEnsureCapacity_real_T(cpu_A, b_i, &wb_emlrtRTEI);
                  if (!A_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_real_T(cpu_A, &i_gpu_A);
                  }

                  b_i = static_cast<int32_T>(sz[0]) * static_cast<int32_T>(sz[1])
                    - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, cpu_A);
                    }

                    ec_detrend_kernel34<<<grid, block>>>(b_i, i_gpu_A);
                    A_outdatedOnGpu = false;
                    A_outdatedOnCpu = true;
                  }
                } else {
                  ptrdiff_t b_n_t;
                  ptrdiff_t e_info_t;
                  npages = cpu_A->size[0];
                  b_i = cpu_tau->size[0];
                  cpu_tau->size[0] = cpu_A->size[0] - 1;
                  emxEnsureCapacity_real_T(cpu_tau, b_i, &kb_emlrtRTEI);
                  if (!tau_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_real_T(cpu_tau, &d_gpu_tau);
                  }

                  if (cpu_A->size[0] > 1) {
                    ptrdiff_t b_info_t;
                    if (A_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &i_gpu_A);
                    }

                    if (tau_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(cpu_tau, &d_gpu_tau);
                    }

                    b_info_t = LAPACKE_dgehrd(102, (ptrdiff_t)cpu_A->size[0],
                      (ptrdiff_t)1, (ptrdiff_t)cpu_A->size[0], &cpu_A->data[0],
                      (ptrdiff_t)cpu_A->size[0], &cpu_tau->data[0]);
                    tau_outdatedOnCpu = false;
                    tau_outdatedOnGpu = true;
                    A_outdatedOnCpu = false;
                    A_outdatedOnGpu = true;
                    if ((int32_T)b_info_t != 0) {
                      for (b_i = 0; b_i < 2; b_i++) {
                        i12[b_i] = cpu_A->size[b_i];
                      }

                      b_i = cpu_A->size[0] * cpu_A->size[1];
                      cpu_A->size[0] = i12[0];
                      cpu_A->size[1] = i12[1];
                      emxEnsureCapacity_real_T(cpu_A, b_i, &ub_emlrtRTEI);
                      b_i12 = i12[0] * i12[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(b_i12 + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, cpu_A);
                        ec_detrend_kernel25<<<grid, block>>>(b_i12, i_gpu_A);
                        A_outdatedOnGpu = false;
                        A_outdatedOnCpu = true;
                      }

                      vlen = cpu_tau->size[0];
                      b_i = cpu_tau->size[0];
                      cpu_tau->size[0] = vlen;
                      emxEnsureCapacity_real_T(cpu_tau, b_i, &yb_emlrtRTEI);
                      validLaunchParams = mwGetLaunchParameters1D(static_cast<
                        real_T>(vlen), &grid, &block, 1024U, 65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_tau, cpu_tau);
                        ec_detrend_kernel26<<<grid, block>>>(vlen, d_gpu_tau);
                        tau_outdatedOnGpu = false;
                        tau_outdatedOnCpu = true;
                      }
                    }
                  }

                  b_i = cpu_U->size[0] * cpu_U->size[1];
                  cpu_U->size[0] = cpu_A->size[0];
                  cpu_U->size[1] = cpu_A->size[1];
                  emxEnsureCapacity_real_T(cpu_U, b_i, &pb_emlrtRTEI);
                  if (!U_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_real_T(cpu_U, &b_gpu_U);
                  }

                  r = cpu_A->size[0] * cpu_A->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (r + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (A_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, cpu_A);
                    }

                    if (U_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, cpu_U);
                    }

                    ec_detrend_kernel27<<<grid, block>>>(i_gpu_A, r, b_gpu_U);
                    U_outdatedOnGpu = false;
                    U_outdatedOnCpu = true;
                  }

                  if (npages == 1) {
                    if (U_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, cpu_U);
                    }

                    ec_detrend_kernel29<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                      (b_gpu_U);
                    U_outdatedOnCpu = true;
                  } else {
                    ptrdiff_t c_info_t;
                    if (U_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(cpu_U, &b_gpu_U);
                    }

                    if (tau_outdatedOnCpu) {
                      gpuEmxMemcpyGpuToCpu_real_T(cpu_tau, &d_gpu_tau);
                    }

                    tau_outdatedOnCpu = false;
                    c_info_t = LAPACKE_dorghr(102, (ptrdiff_t)npages, (ptrdiff_t)
                      1, (ptrdiff_t)npages, &cpu_U->data[0], (ptrdiff_t)npages,
                      &cpu_tau->data[0]);
                    U_outdatedOnCpu = false;
                    if ((int32_T)c_info_t != 0) {
                      for (b_i = 0; b_i < 2; b_i++) {
                        i12[b_i] = cpu_U->size[b_i];
                      }

                      b_i = cpu_U->size[0] * cpu_U->size[1];
                      cpu_U->size[0] = i12[0];
                      cpu_U->size[1] = i12[1];
                      emxEnsureCapacity_real_T(cpu_U, b_i, &pb_emlrtRTEI);
                      b_i12 = i12[0] * i12[1] - 1;
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(b_i12 + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, cpu_U);
                        ec_detrend_kernel28<<<grid, block>>>(b_i12, b_gpu_U);
                        U_outdatedOnCpu = true;
                      }
                    }
                  }

                  b_n_t = (ptrdiff_t)cpu_A->size[0];
                  b_i = wr->size[0] * wr->size[1];
                  wr->size[0] = 1;
                  wr->size[1] = cpu_A->size[0];
                  emxEnsureCapacity_real_T(wr, b_i, &xb_emlrtRTEI);
                  b_i = wi->size[0] * wi->size[1];
                  wi->size[0] = 1;
                  wi->size[1] = cpu_A->size[0];
                  emxEnsureCapacity_real_T(wi, b_i, &cc_emlrtRTEI);
                  if (A_outdatedOnCpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &i_gpu_A);
                  }

                  if (U_outdatedOnCpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(cpu_U, &b_gpu_U);
                  }

                  if (cpu_A->size[0] <= 1) {
                    r = 1;
                  } else {
                    r = cpu_A->size[0];
                  }

                  e_info_t = LAPACKE_dhseqr(102, 'S', 'V', b_n_t, (ptrdiff_t)1,
                    (ptrdiff_t)cpu_A->size[0], &cpu_A->data[0], b_n_t, &wr->
                    data[0], &wi->data[0], &cpu_U->data[0], (ptrdiff_t)r);
                  U_outdatedOnCpu = false;
                  U_outdatedOnGpu = true;
                  A_outdatedOnCpu = false;
                  A_outdatedOnGpu = true;
                  if ((int32_T)e_info_t < 0) {
                    for (b_i = 0; b_i < 2; b_i++) {
                      i12[b_i] = cpu_A->size[b_i];
                    }

                    b_i = cpu_A->size[0] * cpu_A->size[1];
                    cpu_A->size[0] = i12[0];
                    cpu_A->size[1] = i12[1];
                    emxEnsureCapacity_real_T(cpu_A, b_i, &hc_emlrtRTEI);
                    b_i12 = i12[0] * i12[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D
                      (static_cast<real_T>(b_i12 + 1L), &grid, &block, 1024U,
                       65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_A, cpu_A);
                      ec_detrend_kernel30<<<grid, block>>>(b_i12, i_gpu_A);
                      A_outdatedOnGpu = false;
                      A_outdatedOnCpu = true;
                    }

                    for (b_i = 0; b_i < 2; b_i++) {
                      i12[b_i] = cpu_U->size[b_i];
                    }

                    b_i = cpu_U->size[0] * cpu_U->size[1];
                    cpu_U->size[0] = i12[0];
                    cpu_U->size[1] = i12[1];
                    emxEnsureCapacity_real_T(cpu_U, b_i, &lc_emlrtRTEI);
                    b_i12 = i12[0] * i12[1] - 1;
                    validLaunchParams = mwGetLaunchParameters1D(static_cast<
                      real_T>(b_i12 + 1L), &grid, &block, 1024U, 65535U);
                    if (validLaunchParams) {
                      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, cpu_U);
                      ec_detrend_kernel31<<<grid, block>>>(b_i12, b_gpu_U);
                      U_outdatedOnGpu = false;
                      U_outdatedOnCpu = true;
                    }
                  }
                }

                npages = cpu_A->size[0];
                b_i = cpu_D->size[0] * cpu_D->size[1];
                cpu_D->size[0] = cpu_A->size[0];
                cpu_D->size[1] = cpu_A->size[0];
                emxEnsureCapacity_creal_T(cpu_D, b_i, &fc_emlrtRTEI);
                if (!D_outdatedOnGpu) {
                  gpuEmxEnsureCapacity_creal_T(cpu_D, &c_gpu_D);
                }

                r = cpu_A->size[0] * cpu_A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (r + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_outdatedOnGpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_D, cpu_D);
                  }

                  ec_detrend_kernel35<<<grid, block>>>(r, c_gpu_D);
                  D_outdatedOnGpu = false;
                  D_outdatedOnCpu = true;
                }

                b_i = 1;
                do {
                  exitg1 = 0;
                  if (b_i <= npages) {
                    if (b_i != npages) {
                      if (A_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &i_gpu_A);
                      }

                      A_outdatedOnCpu = false;
                      if (cpu_A->data[b_i + cpu_A->size[0] * (b_i - 1)] != 0.0)
                      {
                        cpu_d2scaled = std::abs(cpu_A->data[b_i + cpu_A->size[0]
                          * (b_i - 1)]);
                        if (D_outdatedOnCpu) {
                          gpuEmxMemcpyGpuToCpu_creal_T(cpu_D, &c_gpu_D);
                        }

                        cpu_D->data[(b_i + cpu_D->size[0] * (b_i - 1)) - 1].re =
                          0.0;
                        cpu_D->data[(b_i + cpu_D->size[0] * (b_i - 1)) - 1].im =
                          cpu_d2scaled;
                        cpu_D->data[b_i + cpu_D->size[0] * b_i].re = 0.0;
                        cpu_D->data[b_i + cpu_D->size[0] * b_i].im =
                          -cpu_d2scaled;
                        D_outdatedOnCpu = false;
                        D_outdatedOnGpu = true;
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
                emxEnsureCapacity_creal_T(cpu_V, b_i, &jc_emlrtRTEI);
                if (!V_outdatedOnGpu) {
                  gpuEmxEnsureCapacity_creal_T(cpu_V, &d_gpu_V);
                }

                b_i = cpu_U->size[0] * cpu_U->size[1] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (b_i + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (U_outdatedOnGpu) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_U, cpu_U);
                  }

                  U_outdatedOnGpu = false;
                  if (V_outdatedOnGpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&d_gpu_V, cpu_V);
                  }

                  ec_detrend_kernel36<<<grid, block>>>(b_gpu_U, b_i, d_gpu_V);
                  V_outdatedOnGpu = false;
                  V_outdatedOnCpu = true;
                }

                cpu_nx = 1;
                npages = cpu_A->size[0];
                do {
                  exitg1 = 0;
                  if (cpu_nx <= npages) {
                    if (cpu_nx != npages) {
                      if (A_outdatedOnCpu) {
                        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &i_gpu_A);
                      }

                      A_outdatedOnCpu = false;
                      if (cpu_A->data[cpu_nx + cpu_A->size[0] * (cpu_nx - 1)] !=
                          0.0) {
                        if (cpu_A->data[cpu_nx + cpu_A->size[0] * (cpu_nx - 1)] <
                            0.0) {
                          jend = 1;
                        } else {
                          jend = -1;
                        }

                        for (b_i = 0; b_i < npages; b_i++) {
                          if (V_outdatedOnCpu) {
                            gpuEmxMemcpyGpuToCpu_creal_T(cpu_V, &d_gpu_V);
                          }

                          cpu_d2scaled = cpu_V->data[b_i + cpu_V->size[0] *
                            (cpu_nx - 1)].re;
                          abnrm = static_cast<real_T>(jend) * cpu_V->data[b_i +
                            cpu_V->size[0] * cpu_nx].re;
                          if (abnrm == 0.0) {
                            cpu_V->data[b_i + cpu_V->size[0] * (cpu_nx - 1)].re =
                              cpu_d2scaled / 1.4142135623730951;
                            cpu_V->data[b_i + cpu_V->size[0] * (cpu_nx - 1)].im =
                              0.0;
                            V_outdatedOnCpu = false;
                          } else if (cpu_d2scaled == 0.0) {
                            cpu_V->data[b_i + cpu_V->size[0] * (cpu_nx - 1)].re =
                              0.0;
                            cpu_V->data[b_i + cpu_V->size[0] * (cpu_nx - 1)].im =
                              abnrm / 1.4142135623730951;
                            V_outdatedOnCpu = false;
                          } else {
                            cpu_V->data[b_i + cpu_V->size[0] * (cpu_nx - 1)].re =
                              cpu_d2scaled / 1.4142135623730951;
                            cpu_V->data[b_i + cpu_V->size[0] * (cpu_nx - 1)].im =
                              abnrm / 1.4142135623730951;
                            V_outdatedOnCpu = false;
                          }

                          cpu_V->data[b_i + cpu_V->size[0] * cpu_nx].re =
                            cpu_V->data[b_i + cpu_V->size[0] * (cpu_nx - 1)].re;
                          cpu_V->data[b_i + cpu_V->size[0] * cpu_nx].im =
                            -cpu_V->data[b_i + cpu_V->size[0] * (cpu_nx - 1)].im;
                          V_outdatedOnGpu = true;
                        }

                        cpu_nx += 2;
                      } else {
                        cpu_nx++;
                      }
                    } else {
                      cpu_nx++;
                    }
                  } else {
                    exitg1 = 1;
                  }
                } while (exitg1 == 0);
              } else {
                ptrdiff_t d_info_t;
                npages = cpu_A->size[0];
                cpu_nx = cpu_A->size[1] - 1;
                b_i = scale->size[0];
                scale->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real_T(scale, b_i, &eb_emlrtRTEI);
                b_i = b_cpu_W->size[0];
                b_cpu_W->size[0] = cpu_A->size[1];
                emxEnsureCapacity_creal_T(b_cpu_W, b_i, &hb_emlrtRTEI);
                gpuEmxEnsureCapacity_creal_T(b_cpu_W, &d_gpu_W);
                b_i = cpu_V->size[0] * cpu_V->size[1];
                cpu_V->size[0] = cpu_A->size[1];
                cpu_V->size[1] = cpu_A->size[1];
                emxEnsureCapacity_creal_T(cpu_V, b_i, &lb_emlrtRTEI);
                if (!V_outdatedOnGpu) {
                  gpuEmxEnsureCapacity_creal_T(cpu_V, &d_gpu_V);
                }

                b_i = cpu_wreal->size[0];
                cpu_wreal->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real_T(cpu_wreal, b_i, &mb_emlrtRTEI);
                if (!wreal_outdatedOnGpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_wreal, &b_gpu_wreal);
                }

                b_i = cpu_wimag->size[0];
                cpu_wimag->size[0] = cpu_A->size[1];
                emxEnsureCapacity_real_T(cpu_wimag, b_i, &ob_emlrtRTEI);
                if (!wimag_outdatedOnGpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_wimag, &b_gpu_wimag);
                }

                b_i = cpu_vright->size[0] * cpu_vright->size[1];
                cpu_vright->size[0] = cpu_A->size[1];
                cpu_vright->size[1] = cpu_A->size[1];
                emxEnsureCapacity_real_T(cpu_vright, b_i, &sb_emlrtRTEI);
                if (!vright_outdatedOnGpu) {
                  gpuEmxEnsureCapacity_real_T(cpu_vright, &b_gpu_vright);
                }

                if (A_outdatedOnCpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &i_gpu_A);
                }

                d_info_t = LAPACKE_dgeevx(102, 'B', 'N', 'V', 'N', (ptrdiff_t)
                  cpu_A->size[1], &cpu_A->data[0], (ptrdiff_t)cpu_A->size[0],
                  &cpu_wreal->data[0], &cpu_wimag->data[0], &cpu_d2scaled,
                  (ptrdiff_t)1, &cpu_vright->data[0], (ptrdiff_t)cpu_A->size[1],
                  &ilo_t, &ihi_t, &scale->data[0], &abnrm, &rconde, &rcondv);
                vright_outdatedOnGpu = true;
                wimag_outdatedOnGpu = true;
                wreal_outdatedOnGpu = true;
                A_outdatedOnCpu = false;
                A_outdatedOnGpu = true;
                if ((int32_T)d_info_t < 0) {
                  b_i = b_cpu_W->size[0];
                  b_cpu_W->size[0] = cpu_A->size[1];
                  emxEnsureCapacity_creal_T(b_cpu_W, b_i, &ac_emlrtRTEI);
                  gpuEmxEnsureCapacity_creal_T(b_cpu_W, &d_gpu_W);
                  r = cpu_A->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (r + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    ec_detrend_kernel22<<<grid, block>>>(dc, r, d_gpu_W);
                    b_W_outdatedOnCpu = true;
                  }

                  for (b_i = 0; b_i < 2; b_i++) {
                    i12[b_i] = cpu_V->size[b_i];
                  }

                  b_i = cpu_V->size[0] * cpu_V->size[1];
                  cpu_V->size[0] = i12[0];
                  cpu_V->size[1] = i12[1];
                  emxEnsureCapacity_creal_T(cpu_V, b_i, &gc_emlrtRTEI);
                  if (!V_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_creal_T(cpu_V, &d_gpu_V);
                  }

                  b_i12 = i12[0] * i12[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i12 + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    if (V_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&d_gpu_V, cpu_V);
                    }

                    ec_detrend_kernel23<<<grid, block>>>(dc, b_i12, d_gpu_V);
                    V_outdatedOnGpu = false;
                    V_outdatedOnCpu = true;
                  }
                } else {
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (cpu_nx + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_wimag, cpu_wimag);
                    wimag_outdatedOnGpu = false;
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_wreal, cpu_wreal);
                    wreal_outdatedOnGpu = false;
                    ec_detrend_kernel19<<<grid, block>>>(b_gpu_wimag,
                      b_gpu_wreal, cpu_nx, d_gpu_W);
                    b_W_outdatedOnCpu = true;
                  }

                  b_i = cpu_V->size[0] * cpu_V->size[1];
                  cpu_V->size[0] = cpu_vright->size[0];
                  cpu_V->size[1] = cpu_vright->size[1];
                  emxEnsureCapacity_creal_T(cpu_V, b_i, &ec_emlrtRTEI);
                  if (!V_outdatedOnGpu) {
                    gpuEmxEnsureCapacity_creal_T(cpu_V, &d_gpu_V);
                  }

                  b_i = cpu_vright->size[0] * cpu_vright->size[1] - 1;
                  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                    (b_i + 1L), &grid, &block, 1024U, 65535U);
                  if (validLaunchParams) {
                    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_vright, cpu_vright);
                    vright_outdatedOnGpu = false;
                    if (V_outdatedOnGpu) {
                      gpuEmxMemcpyCpuToGpu_creal_T(&d_gpu_V, cpu_V);
                    }

                    ec_detrend_kernel20<<<grid, block>>>(b_gpu_vright, b_i,
                      d_gpu_V);
                    V_outdatedOnGpu = false;
                    V_outdatedOnCpu = true;
                  }

                  for (b_i = 0; b_i < cpu_nx; b_i++) {
                    if ((cpu_wimag->data[b_i] > 0.0) && (cpu_wimag->data[b_i + 1]
                         < 0.0)) {
                      validLaunchParams = mwGetLaunchParameters1D
                        (static_cast<real_T>(cpu_nx + 1L), &grid, &block, 1024U,
                         65535U);
                      if (validLaunchParams) {
                        if (V_outdatedOnGpu) {
                          gpuEmxMemcpyCpuToGpu_creal_T(&d_gpu_V, cpu_V);
                        }

                        ec_detrend_kernel21<<<grid, block>>>(b_i + 2, cpu_nx,
                          d_gpu_V, cpu_V->size[0U]);
                        V_outdatedOnGpu = false;
                        V_outdatedOnCpu = true;
                      }
                    }
                  }
                }

                b_i = cpu_D->size[0] * cpu_D->size[1];
                cpu_D->size[0] = cpu_A->size[0];
                cpu_D->size[1] = cpu_A->size[0];
                emxEnsureCapacity_creal_T(cpu_D, b_i, &ic_emlrtRTEI);
                if (!D_outdatedOnGpu) {
                  gpuEmxEnsureCapacity_creal_T(cpu_D, &c_gpu_D);
                }

                r = cpu_A->size[0] * cpu_A->size[0] - 1;
                validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                  (r + 1L), &grid, &block, 1024U, 65535U);
                if (validLaunchParams) {
                  if (D_outdatedOnGpu) {
                    gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_D, cpu_D);
                  }

                  ec_detrend_kernel24<<<grid, block>>>(r, c_gpu_D);
                  D_outdatedOnGpu = false;
                  D_outdatedOnCpu = true;
                }

                for (jend = 0; jend < npages; jend++) {
                  if (D_outdatedOnCpu) {
                    gpuEmxMemcpyGpuToCpu_creal_T(cpu_D, &c_gpu_D);
                  }

                  if (b_W_outdatedOnCpu) {
                    gpuEmxMemcpyGpuToCpu_creal_T(b_cpu_W, &d_gpu_W);
                  }

                  b_W_outdatedOnCpu = false;
                  cpu_D->data[jend + cpu_D->size[0] * jend] = b_cpu_W->data[jend];
                  D_outdatedOnCpu = false;
                  D_outdatedOnGpu = true;
                }
              }
            }
          }
        }

        // 'ec_detrend:175' V = real(V);
        b_i = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = cpu_V->size[0];
        b_cpu_V->size[1] = cpu_V->size[1];
        emxEnsureCapacity_real_T(b_cpu_V, b_i, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_V, &e_gpu_V);
        b_i = cpu_V->size[0] * cpu_V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (V_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_creal_T(&d_gpu_V, cpu_V);
          }

          V_outdatedOnGpu = false;
          ec_detrend_kernel43<<<grid, block>>>(d_gpu_V, b_i, e_gpu_V);
        }

        // 'ec_detrend:176' D = diag(real(D));
        b_i = cpu_v->size[0] * cpu_v->size[1];
        cpu_v->size[0] = cpu_D->size[0];
        cpu_v->size[1] = cpu_D->size[1];
        emxEnsureCapacity_real_T(cpu_v, b_i, &bb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_v, &b_gpu_v);
        b_i = cpu_D->size[0] * cpu_D->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (D_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_D, cpu_D);
          }

          D_outdatedOnGpu = false;
          ec_detrend_kernel44<<<grid, block>>>(c_gpu_D, b_i, b_gpu_v);
        }

        if ((cpu_v->size[0] == 1) && (cpu_v->size[1] == 1)) {
          b_i = b_cpu_D->size[0];
          b_cpu_D->size[0] = 1;
          emxEnsureCapacity_real_T(b_cpu_D, b_i, &gb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_D, &d_gpu_D);
          ec_detrend_kernel46<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_v,
            d_gpu_D);
          b_D_outdatedOnCpu = true;
        } else {
          istart = cpu_v->size[0];
          npages = cpu_v->size[1];
          if (istart <= npages) {
            npages = istart;
          }

          if (cpu_v->size[1] > 0) {
            istart = npages;
          } else {
            istart = 0;
          }

          b_i = b_cpu_D->size[0];
          b_cpu_D->size[0] = istart;
          emxEnsureCapacity_real_T(b_cpu_D, b_i, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_D, &d_gpu_D);
          istart--;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(istart
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel45<<<grid, block>>>(b_gpu_v, istart, d_gpu_D,
              cpu_v->size[0U]);
            b_D_outdatedOnCpu = true;
          }
        }

        // 'ec_detrend:177' V = V(:,D/max(D)>thrPCA);
        vlen = b_cpu_D->size[0];
        if (b_D_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(b_cpu_D, &d_gpu_D);
        }

        b_D_outdatedOnCpu = false;
        cpu_d2scaled = b_cpu_D->data[0];
        for (b_i = 0; b_i <= vlen - 2; b_i++) {
          if (std::isnan(b_cpu_D->data[b_i + 1])) {
            validLaunchParams = false;
          } else if (std::isnan(cpu_d2scaled)) {
            validLaunchParams = true;
          } else {
            validLaunchParams = (cpu_d2scaled < b_cpu_D->data[b_i + 1]);
          }

          if (validLaunchParams) {
            cpu_d2scaled = b_cpu_D->data[b_i + 1];
          }
        }

        vlen = b_cpu_D->size[0] - 1;
        npages = 0;
        for (b_i = 0; b_i <= vlen; b_i++) {
          if (b_cpu_D->data[b_i] / cpu_d2scaled > 1.0E-7) {
            npages++;
          }
        }

        b_i = cpu_iv->size[0];
        cpu_iv->size[0] = npages;
        emxEnsureCapacity_int32_T(cpu_iv, b_i, &tb_emlrtRTEI);
        if (!iv_outdatedOnGpu) {
          gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv);
        }

        istart = 0;
        for (b_i = 0; b_i <= vlen; b_i++) {
          if (b_cpu_D->data[b_i] / cpu_d2scaled > 1.0E-7) {
            cpu_iv->data[istart] = b_i;
            iv_outdatedOnGpu = true;
            istart++;
          }
        }

        npages = b_cpu_V->size[0];
        b_i = e_cpu_V->size[0] * e_cpu_V->size[1];
        e_cpu_V->size[0] = b_cpu_V->size[0];
        e_cpu_V->size[1] = cpu_iv->size[0];
        emxEnsureCapacity_real_T(e_cpu_V, b_i, &vb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_cpu_V, &f_gpu_V);
        b_i = cpu_iv->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages *
          (b_i + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (iv_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_iv, cpu_iv);
          }

          iv_outdatedOnGpu = false;
          ec_detrend_kernel47<<<grid, block>>>(gpu_iv, e_gpu_V, npages, b_i,
            f_gpu_V, e_cpu_V->size[0U], b_cpu_V->size[0U]);
        }

        b_i = b_cpu_V->size[0] * b_cpu_V->size[1];
        b_cpu_V->size[0] = e_cpu_V->size[0];
        b_cpu_V->size[1] = e_cpu_V->size[1];
        emxEnsureCapacity_real_T(b_cpu_V, b_i, &dc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_V, &e_gpu_V);
        b_i = e_cpu_V->size[0] * e_cpu_V->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detrend_kernel48<<<grid, block>>>(f_gpu_V, b_i, e_gpu_V);
        }

        //  discard weak dims
        // 'ec_detrend:178' rr = rr*V;
        npages = cpu_rr->size[0];
        vlen = cpu_rr->size[1];
        if ((cpu_rr->size[0] == 0) || (cpu_rr->size[1] == 0) || (b_cpu_V->size[0]
             == 0) || (b_cpu_V->size[1] == 0)) {
          istart = cpu_rr->size[0];
          i12[0] = cpu_rr->size[0];
          i12[1] = b_cpu_V->size[1];
          b_i = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = istart;
          cpu_rr->size[1] = b_cpu_V->size[1];
          emxEnsureCapacity_real_T(cpu_rr, b_i, &mc_emlrtRTEI);
          if (!rr_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_rr, &b_gpu_rr);
          }

          b_i12 = i12[0] * i12[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i12
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (rr_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, cpu_rr);
            }

            ec_detrend_kernel50<<<grid, block>>>(b_i12, b_gpu_rr);
            rr_outdatedOnGpu = false;
            rr_outdatedOnCpu = true;
          }
        } else {
          b_i = c_cpu_A->size[0] * c_cpu_A->size[1];
          c_cpu_A->size[0] = cpu_rr->size[0];
          c_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(c_cpu_A, b_i, &kc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_cpu_A, &n_gpu_A);
          r = cpu_rr->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (rr_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, cpu_rr);
            }

            rr_outdatedOnGpu = false;
            ec_detrend_kernel49<<<grid, block>>>(b_gpu_rr, r, n_gpu_A);
          }

          b_i = cpu_rr->size[0] * cpu_rr->size[1];
          cpu_rr->size[0] = npages;
          cpu_rr->size[1] = b_cpu_V->size[1];
          emxEnsureCapacity_real_T(cpu_rr, b_i, &u_emlrtRTEI);
          if (!rr_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_rr, &b_gpu_rr);
          }

          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          if (rr_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, cpu_rr);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, npages,
                      b_cpu_V->size[1], vlen, (double *)&cpu_d2scaled, (double *)
                      &n_gpu_A.data[0], npages, (double *)&e_gpu_V.data[0], vlen,
                      (double *)&abnrm, (double *)&b_gpu_rr.data[0], npages);
          rr_outdatedOnGpu = false;
          rr_outdatedOnCpu = true;
        }

        // 'ec_detrend:179' b = (x'*rr) / (rr'*rr);
        b_i = d_cpu_A->size[0] * d_cpu_A->size[1];
        d_cpu_A->size[0] = 1;
        d_cpu_A->size[1] = cpu_dv1->size[0];
        emxEnsureCapacity_real_T(d_cpu_A, b_i, &t_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_cpu_A, &j_gpu_A);
        b_i = cpu_dv1->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (dv1_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv1, cpu_dv1);
          }

          dv1_outdatedOnGpu = false;
          ec_detrend_kernel51<<<grid, block>>>(gpu_dv1, b_i, j_gpu_A);
        }

        if ((cpu_dv1->size[0] == 0) || (cpu_rr->size[0] == 0) || (cpu_rr->size[1]
             == 0)) {
          b_i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(cpu_b, b_i, &v_emlrtRTEI);
          if (!b_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_b, &c_gpu_b);
          }

          r = cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, cpu_b);
            }

            ec_detrend_kernel52<<<grid, block>>>(r, c_gpu_b);
            b_outdatedOnGpu = false;
          }
        } else {
          b_i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(cpu_b, b_i, &u_emlrtRTEI);
          if (!b_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_b, &c_gpu_b);
          }

          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          if (rr_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, cpu_rr);
          }

          rr_outdatedOnGpu = false;
          if (b_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, cpu_b);
          }

          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N, 1,
                      cpu_rr->size[1], cpu_dv1->size[0], (double *)&cpu_d2scaled,
                      (double *)&j_gpu_A.data[0], 1, (double *)&b_gpu_rr.data[0],
                      cpu_dv1->size[0], (double *)&abnrm, (double *)
                      &c_gpu_b.data[0], 1);
          b_outdatedOnGpu = false;
        }

        b_i = e_cpu_A->size[0] * e_cpu_A->size[1];
        e_cpu_A->size[0] = cpu_rr->size[1];
        e_cpu_A->size[1] = cpu_rr->size[0];
        emxEnsureCapacity_real_T(e_cpu_A, b_i, &t_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_cpu_A, &k_gpu_A);
        r = cpu_rr->size[0] - 1;
        b_i = cpu_rr->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i +
          1L) * (r + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (rr_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, cpu_rr);
          }

          rr_outdatedOnGpu = false;
          ec_detrend_kernel53<<<grid, block>>>(b_gpu_rr, b_i, r, k_gpu_A,
            e_cpu_A->size[0U], cpu_rr->size[0U]);
        }

        if ((e_cpu_A->size[0] == 0) || (e_cpu_A->size[1] == 0) || (cpu_rr->size
             [0] == 0) || (cpu_rr->size[1] == 0)) {
          b_i = f_cpu_A->size[0] * f_cpu_A->size[1];
          f_cpu_A->size[0] = e_cpu_A->size[0];
          f_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(f_cpu_A, b_i, &v_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_cpu_A, &l_gpu_A);
          r = e_cpu_A->size[0] * cpu_rr->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel54<<<grid, block>>>(r, l_gpu_A);
          }
        } else {
          b_i = f_cpu_A->size[0] * f_cpu_A->size[1];
          f_cpu_A->size[0] = e_cpu_A->size[0];
          f_cpu_A->size[1] = cpu_rr->size[1];
          emxEnsureCapacity_real_T(f_cpu_A, b_i, &u_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_cpu_A, &l_gpu_A);
          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          if (rr_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_rr, cpu_rr);
          }

          rr_outdatedOnGpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      e_cpu_A->size[0], cpu_rr->size[1], e_cpu_A->size[1],
                      (double *)&cpu_d2scaled, (double *)&k_gpu_A.data[0],
                      e_cpu_A->size[0], (double *)&b_gpu_rr.data[0],
                      e_cpu_A->size[1], (double *)&abnrm, (double *)
                      &l_gpu_A.data[0], e_cpu_A->size[0]);
        }

        if ((cpu_b->size[1] == 0) || ((f_cpu_A->size[0] == 0) || (f_cpu_A->size
              [1] == 0))) {
          sz[1] = static_cast<uint32_T>(f_cpu_A->size[0]);
          b_i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = f_cpu_A->size[0];
          emxEnsureCapacity_real_T(cpu_b, b_i, &pc_emlrtRTEI);
          if (!b_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_b, &c_gpu_b);
          }

          b_i = static_cast<int32_T>(sz[1]) - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, cpu_b);
            }

            ec_detrend_kernel69<<<grid, block>>>(static_cast<int32_T>(sz[1]) - 1,
              c_gpu_b);
            b_outdatedOnGpu = false;
          }
        } else if (f_cpu_A->size[0] == f_cpu_A->size[1]) {
          npages = f_cpu_A->size[1] - 2;
          b_i = cpu_ipiv_t->size[0];
          cpu_ipiv_t->size[0] = f_cpu_A->size[1];
          emxEnsureCapacity_int32_T(cpu_ipiv_t, b_i, &nc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_ipiv_t, &b_gpu_ipiv_t);
          cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), f_cpu_A->size[1],
            f_cpu_A->size[1], (double *)&l_gpu_A.data[0], f_cpu_A->size[1],
            getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(8);
          cusolverInitWorkspace();
          cusolverDnDgetrf(getCuSolverGlobalHandle(), f_cpu_A->size[1],
                           f_cpu_A->size[1], (double *)&l_gpu_A.data[0],
                           f_cpu_A->size[1], static_cast<real_T *>
                           (getCuSolverWorkspaceBuff()), &b_gpu_ipiv_t.data[0],
                           b_gpu_info);
          b_i = cpu_ipiv->size[0] * cpu_ipiv->size[1];
          cpu_ipiv->size[0] = 1;
          cpu_ipiv->size[1] = cpu_ipiv_t->size[0];
          emxEnsureCapacity_int32_T(cpu_ipiv, b_i, &qc_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_ipiv, &b_gpu_ipiv);
          cudaMemcpy(&cpu_info, b_gpu_info, 4UL, cudaMemcpyDeviceToHost);
          if (cpu_info < 0) {
            for (b_i = 0; b_i < 2; b_i++) {
              i12[b_i] = f_cpu_A->size[b_i];
            }

            b_i = f_cpu_A->size[0] * f_cpu_A->size[1];
            f_cpu_A->size[0] = i12[0];
            f_cpu_A->size[1] = i12[1];
            emxEnsureCapacity_real_T(f_cpu_A, b_i, &tc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(f_cpu_A, &l_gpu_A);
            b_i12 = i12[0] * i12[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (b_i12 + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel67<<<grid, block>>>(b_i12, l_gpu_A);
            }

            istart = cpu_ipiv->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (istart + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel68<<<grid, block>>>(istart, b_gpu_ipiv);
              ipiv_outdatedOnCpu = true;
            }
          } else {
            istart = cpu_ipiv_t->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (istart + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel66<<<grid, block>>>(b_gpu_ipiv_t, istart,
                b_gpu_ipiv);
              ipiv_outdatedOnCpu = true;
            }
          }

          cpu_d2scaled = 1.0;
          if (b_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, cpu_b);
          }

          cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N, CUBLAS_DIAG_NON_UNIT,
                      1, npages + 2, (double *)&cpu_d2scaled, (double *)
                      &l_gpu_A.data[0], npages + 2, (double *)&c_gpu_b.data[0],
                      1);
          cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                      CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                      npages + 2, (double *)&cpu_d2scaled, (double *)
                      &l_gpu_A.data[0], npages + 2, (double *)&c_gpu_b.data[0],
                      1);
          b_outdatedOnGpu = false;
          validLaunchParams = true;
          for (cpu_nx = 0; cpu_nx <= npages; cpu_nx++) {
            if (ipiv_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_ipiv, &b_gpu_ipiv);
            }

            ipiv_outdatedOnCpu = false;
            if (cpu_ipiv->data[npages - cpu_nx] != (npages - cpu_nx) + 1) {
              if (validLaunchParams) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_b, &c_gpu_b);
              }

              cpu_d2scaled = cpu_b->data[npages - cpu_nx];
              cpu_b->data[npages - cpu_nx] = cpu_b->data[cpu_ipiv->data[npages -
                cpu_nx] - 1];
              cpu_b->data[cpu_ipiv->data[npages - cpu_nx] - 1] = cpu_d2scaled;
              validLaunchParams = false;
              b_outdatedOnGpu = true;
            }
          }
        } else {
          ptrdiff_t k_info_t;
          boolean_T b_tau_outdatedOnGpu;
          boolean_T c_A_outdatedOnGpu;
          b_i = i_cpu_A->size[0] * i_cpu_A->size[1];
          i_cpu_A->size[0] = f_cpu_A->size[1];
          i_cpu_A->size[1] = f_cpu_A->size[0];
          emxEnsureCapacity_real_T(i_cpu_A, b_i, &oc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(i_cpu_A, &m_gpu_A);
          r = f_cpu_A->size[0] - 1;
          b_i = f_cpu_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_i +
            1L) * (r + 1L)), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel55<<<grid, block>>>(l_gpu_A, b_i, r, m_gpu_A,
              i_cpu_A->size[0U], f_cpu_A->size[0U]);
            c_A_outdatedOnCpu = true;
          }

          b_i = cpu_B->size[0];
          cpu_B->size[0] = cpu_b->size[1];
          emxEnsureCapacity_real_T(cpu_B, b_i, &rc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_B, &d_gpu_B);
          b_i = cpu_b->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, cpu_b);
            }

            b_outdatedOnGpu = false;
            ec_detrend_kernel56<<<grid, block>>>(c_gpu_b, b_i, d_gpu_B);
          }

          vlen = i_cpu_A->size[0];
          npages = i_cpu_A->size[1] - 1;
          b_i = cpu_jpvt->size[0] * cpu_jpvt->size[1];
          cpu_jpvt->size[0] = 1;
          cpu_jpvt->size[1] = i_cpu_A->size[1];
          emxEnsureCapacity_int32_T(cpu_jpvt, b_i, &uc_emlrtRTEI);
          if (!jpvt_outdatedOnGpu) {
            gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &b_gpu_jpvt);
          }

          r = i_cpu_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, cpu_jpvt);
            }

            ec_detrend_kernel57<<<grid, block>>>(r, b_gpu_jpvt);
            jpvt_outdatedOnGpu = false;
            jpvt_outdatedOnCpu = true;
          }

          istart = i_cpu_A->size[0];
          jend = i_cpu_A->size[1];
          if (istart <= jend) {
            jend = istart;
          }

          b_i = b_cpu_tau->size[0];
          b_cpu_tau->size[0] = jend;
          emxEnsureCapacity_real_T(b_cpu_tau, b_i, &vc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_tau, &c_gpu_tau);
          b_i = jpvt_t->size[0];
          jpvt_t->size[0] = i_cpu_A->size[1];
          emxEnsureCapacity_ptrdiff_t(jpvt_t, b_i, &wc_emlrtRTEI);
          for (b_i = 0; b_i < i_cpu_A->size[1]; b_i++) {
            jpvt_t->data[b_i] = (ptrdiff_t)0;
          }

          if (c_A_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(i_cpu_A, &m_gpu_A);
          }

          if (b_tau_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_tau, &c_gpu_tau);
          }

          k_info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)i_cpu_A->size[0], (ptrdiff_t)
            i_cpu_A->size[1], &i_cpu_A->data[0], (ptrdiff_t)i_cpu_A->size[0],
            &jpvt_t->data[0], &b_cpu_tau->data[0]);
          b_tau_outdatedOnCpu = false;
          b_tau_outdatedOnGpu = true;
          c_A_outdatedOnCpu = false;
          c_A_outdatedOnGpu = true;
          if ((int32_T)k_info_t != 0) {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen
              * (npages + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_A, i_cpu_A);
              ec_detrend_kernel58<<<grid, block>>>(vlen, npages, m_gpu_A,
                i_cpu_A->size[0U]);
              c_A_outdatedOnGpu = false;
              c_A_outdatedOnCpu = true;
            }

            istart = i_cpu_A->size[0];
            vlen = i_cpu_A->size[1];
            if (istart <= vlen) {
              vlen = istart;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen),
              &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_tau, b_cpu_tau);
              ec_detrend_kernel59<<<grid, block>>>(vlen, c_gpu_tau);
              b_tau_outdatedOnGpu = false;
              b_tau_outdatedOnCpu = true;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (computeEndIdx(static_cast<int64_T>(vlen + 1), static_cast<int64_T>
                             (jend), 1L) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (b_tau_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_tau, b_cpu_tau);
              }

              ec_detrend_kernel60<<<grid, block>>>(jend, vlen + 1, c_gpu_tau);
              b_tau_outdatedOnGpu = false;
              b_tau_outdatedOnCpu = true;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (npages + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (jpvt_outdatedOnGpu) {
                gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, cpu_jpvt);
              }

              ec_detrend_kernel61<<<grid, block>>>(npages, b_gpu_jpvt);
              jpvt_outdatedOnGpu = false;
              jpvt_outdatedOnCpu = true;
            }
          } else {
            for (jend = 0; jend <= npages; jend++) {
              if (jpvt_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &b_gpu_jpvt);
              }

              cpu_jpvt->data[jend] = (int32_T)jpvt_t->data[jend];
              jpvt_outdatedOnCpu = false;
              jpvt_outdatedOnGpu = true;
            }
          }

          jend = -1;
          if (i_cpu_A->size[0] < i_cpu_A->size[1]) {
            vlen = i_cpu_A->size[0];
            istart = i_cpu_A->size[1];
          } else {
            vlen = i_cpu_A->size[1];
            istart = i_cpu_A->size[0];
          }

          if (c_A_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(i_cpu_A, &m_gpu_A);
          }

          c_A_outdatedOnCpu = false;
          cpu_d2scaled = std::fmin(1.4901161193847656E-8, 2.2204460492503131E-15
            * static_cast<real_T>(istart)) * std::abs(i_cpu_A->data[0]);
          while ((jend + 1 < vlen) && (!(std::abs(i_cpu_A->data[(jend +
                     i_cpu_A->size[0] * (jend + 1)) + 1]) <= cpu_d2scaled))) {
            jend++;
          }

          b_i = cpu_Y->size[0];
          cpu_Y->size[0] = i_cpu_A->size[1];
          emxEnsureCapacity_real_T(cpu_Y, b_i, &bd_emlrtRTEI);
          if (!Y_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_Y, &b_gpu_Y);
          }

          r = i_cpu_A->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(r + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_Y, cpu_Y);
            }

            ec_detrend_kernel62<<<grid, block>>>(r, b_gpu_Y);
            Y_outdatedOnGpu = false;
            Y_outdatedOnCpu = true;
          }

          cpu_nx = 0;
          istart = i_cpu_A->size[0];
          npages = i_cpu_A->size[1];
          if (istart <= npages) {
            npages = istart;
          }

          if (c_A_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_A, i_cpu_A);
          }

          if (b_tau_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_tau, b_cpu_tau);
          }

          cusolverDnDormqr_bufferSize(getCuSolverGlobalHandle(),
            CUBLAS_SIDE_LEFT, CUBLAS_OP_T, cpu_B->size[0], 1, npages, (double *)
            &m_gpu_A.data[0], i_cpu_A->size[0], (double *)&c_gpu_tau.data[0],
            (double *)&d_gpu_B.data[0], cpu_B->size[0], getCuSolverWorkspaceReq());
          setCuSolverWorkspaceTypeSize(8);
          cusolverInitWorkspace();
          cudaMemcpy(gpu_nx, &cpu_nx, 4UL, cudaMemcpyHostToDevice);
          cusolverDnDormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT,
                           CUBLAS_OP_T, cpu_B->size[0], 1, npages, (double *)
                           &m_gpu_A.data[0], i_cpu_A->size[0], (double *)
                           &c_gpu_tau.data[0], (double *)&d_gpu_B.data[0],
                           cpu_B->size[0], static_cast<real_T *>
                           (getCuSolverWorkspaceBuff()),
                           *getCuSolverWorkspaceReq(), gpu_nx);
          cudaMemcpy(&cpu_nx, gpu_nx, 4UL, cudaMemcpyDeviceToHost);
          if (cpu_nx < 0) {
            vlen = cpu_B->size[0];
            b_i = cpu_B->size[0];
            cpu_B->size[0] = vlen;
            emxEnsureCapacity_real_T(cpu_B, b_i, &ed_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_B, &d_gpu_B);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen),
              &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_detrend_kernel63<<<grid, block>>>(vlen, d_gpu_B);
            }
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(jend +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (jpvt_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_jpvt, cpu_jpvt);
            }

            jpvt_outdatedOnGpu = false;
            if (Y_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_Y, cpu_Y);
            }

            ec_detrend_kernel64<<<grid, block>>>(d_gpu_B, b_gpu_jpvt, jend,
              b_gpu_Y);
            Y_outdatedOnGpu = false;
            Y_outdatedOnCpu = true;
          }

          for (cpu_nx = 0; cpu_nx <= jend; cpu_nx++) {
            if (Y_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_Y, &b_gpu_Y);
            }

            if (jpvt_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &b_gpu_jpvt);
            }

            jpvt_outdatedOnCpu = false;
            cpu_Y->data[cpu_jpvt->data[jend - cpu_nx] - 1] /= i_cpu_A->data
              [(jend - cpu_nx) + i_cpu_A->size[0] * (jend - cpu_nx)];
            Y_outdatedOnCpu = false;
            Y_outdatedOnGpu = true;
            istart = jend - cpu_nx;
            for (b_i = 0; b_i < istart; b_i++) {
              cpu_Y->data[cpu_jpvt->data[b_i] - 1] -= cpu_Y->data[cpu_jpvt->
                data[jend - cpu_nx] - 1] * i_cpu_A->data[b_i + i_cpu_A->size[0] *
                (jend - cpu_nx)];
            }
          }

          b_i = cpu_b->size[0] * cpu_b->size[1];
          cpu_b->size[0] = 1;
          cpu_b->size[1] = cpu_Y->size[0];
          emxEnsureCapacity_real_T(cpu_b, b_i, &pc_emlrtRTEI);
          if (!b_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_b, &c_gpu_b);
          }

          b_i = cpu_Y->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (Y_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_Y, cpu_Y);
            }

            Y_outdatedOnGpu = false;
            if (b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, cpu_b);
            }

            ec_detrend_kernel65<<<grid, block>>>(b_gpu_Y, b_i, c_gpu_b);
            b_outdatedOnGpu = false;
          }
        }

        // 'ec_detrend:180' z = r*(V*b') + mn;
        b_i = b_cpu_B->size[0];
        b_cpu_B->size[0] = cpu_b->size[1];
        emxEnsureCapacity_real_T(b_cpu_B, b_i, &sc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_B, &c_gpu_B);
        b_i = cpu_b->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, cpu_b);
          }

          b_outdatedOnGpu = false;
          ec_detrend_kernel70<<<grid, block>>>(c_gpu_b, b_i, c_gpu_B);
        }

        if ((b_cpu_V->size[0] == 0) || (b_cpu_V->size[1] == 0) || (b_cpu_B->
             size[0] == 0)) {
          b_i = c_cpu_y->size[0];
          c_cpu_y->size[0] = b_cpu_V->size[0];
          emxEnsureCapacity_real_T(c_cpu_y, b_i, &v_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_cpu_y, &i_gpu_y);
          b_i = b_cpu_V->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel71<<<grid, block>>>(b_i, i_gpu_y);
          }
        } else {
          b_i = c_cpu_y->size[0];
          c_cpu_y->size[0] = b_cpu_V->size[0];
          emxEnsureCapacity_real_T(c_cpu_y, b_i, &u_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_cpu_y, &i_gpu_y);
          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      b_cpu_V->size[0], 1, b_cpu_V->size[1], (double *)
                      &cpu_d2scaled, (double *)&e_gpu_V.data[0], b_cpu_V->size[0],
                      (double *)&c_gpu_B.data[0], b_cpu_V->size[1], (double *)
                      &abnrm, (double *)&i_gpu_y.data[0], b_cpu_V->size[0]);
        }

        if ((c_cpu_r->size[0] == 0) || (c_cpu_r->size[1] == 0) || (c_cpu_y->
             size[0] == 0)) {
          b_i = cpu_dv7->size[0];
          cpu_dv7->size[0] = c_cpu_r->size[0];
          emxEnsureCapacity_real_T(cpu_dv7, b_i, &xc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_dv7, &gpu_dv7);
          b_i = c_cpu_r->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_detrend_kernel72<<<grid, block>>>(b_i, gpu_dv7);
            dv7_outdatedOnCpu = true;
          }
        } else {
          b_i = cpu_dv7->size[0];
          cpu_dv7->size[0] = c_cpu_r->size[0];
          emxEnsureCapacity_real_T(cpu_dv7, b_i, &u_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_dv7, &gpu_dv7);
          cpu_d2scaled = 1.0;
          abnrm = 0.0;
          if (b_r_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_r, c_cpu_r);
          }

          b_r_outdatedOnGpu = false;
          cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                      c_cpu_r->size[0], 1, c_cpu_r->size[1], (double *)
                      &cpu_d2scaled, (double *)&d_gpu_r.data[0], c_cpu_r->size[0],
                      (double *)&i_gpu_y.data[0], c_cpu_r->size[1], (double *)
                      &abnrm, (double *)&gpu_dv7.data[0], c_cpu_r->size[0]);
          dv7_outdatedOnCpu = true;
        }

        if (cpu_dv7->size[0] == b_cpu_x->size[0]) {
          b_i = cpu_z->size[0];
          cpu_z->size[0] = cpu_dv7->size[0];
          emxEnsureCapacity_real_T(cpu_z, b_i, &yc_emlrtRTEI);
          if (!z_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_z, &b_gpu_z);
          }

          b_i = cpu_dv7->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (b_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
            }

            b_x_outdatedOnGpu = false;
            if (z_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_z, cpu_z);
            }

            ec_detrend_kernel73<<<grid, block>>>(mn, b_gpu_x, gpu_dv7, b_i,
              b_gpu_z);
            z_outdatedOnGpu = false;
            z_outdatedOnCpu = true;
          }
        } else {
          if (z_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_z, &b_gpu_z);
          }

          if (dv7_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv7, &gpu_dv7);
          }

          dv7_outdatedOnCpu = false;
          if (b_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
          }

          b_x_outdatedOnCpu = false;
          binary_expand_op_1(cpu_z, cpu_dv7, b_cpu_x, mn);
          z_outdatedOnCpu = false;
          z_outdatedOnGpu = true;
        }

        //  Find outliers
        // 'ec_detrend:88' d = (x-z).*w;
        if (b_cpu_x->size[0] == 1) {
          r = cpu_z->size[0];
        } else {
          r = b_cpu_x->size[0];
        }

        if ((b_cpu_x->size[0] == cpu_z->size[0]) && (r == b_cpu_w->size[0])) {
          b_i = cpu_d->size[0];
          cpu_d->size[0] = b_cpu_x->size[0];
          emxEnsureCapacity_real_T(cpu_d, b_i, &ad_emlrtRTEI);
          if (!d_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(cpu_d, &c_gpu_d);
          }

          b_i = b_cpu_x->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (z_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_z, cpu_z);
            }

            z_outdatedOnGpu = false;
            if (b_x_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
            }

            b_x_outdatedOnGpu = false;
            if (d_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, cpu_d);
            }

            ec_detrend_kernel74<<<grid, block>>>(b_gpu_w, b_gpu_z, b_gpu_x, b_i,
              c_gpu_d);
            d_outdatedOnGpu = false;
            d_outdatedOnCpu = true;
          }
        } else {
          if (d_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_d, &c_gpu_d);
          }

          if (b_x_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
          }

          b_x_outdatedOnCpu = false;
          if (z_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_z, &b_gpu_z);
          }

          z_outdatedOnCpu = false;
          if (b_w_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(b_cpu_w, &b_gpu_w);
          }

          b_w_outdatedOnCpu = false;
          binary_expand_op(cpu_d, b_cpu_x, cpu_z, b_cpu_w);
          d_outdatedOnCpu = false;
          d_outdatedOnGpu = true;
        }

        // 'ec_detrend:89' thrItr = thr*std(d);
        npages = cpu_d->size[0] - 1;
        if (cpu_d->size[0] == 0) {
          cpu_d2scaled = rtNaN;
        } else if (cpu_d->size[0] == 1) {
          if (d_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, cpu_d);
          }

          d_outdatedOnGpu = false;
          cudaMemcpy(gpu_d2scaled, &cpu_d2scaled, 8UL, cudaMemcpyHostToDevice);
          ec_detrend_kernel76<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(c_gpu_d,
            gpu_d2scaled);
          cudaMemcpy(&cpu_d2scaled, gpu_d2scaled, 8UL, cudaMemcpyDeviceToHost);
        } else {
          if (d_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_d, &c_gpu_d);
          }

          d_outdatedOnCpu = false;
          cpu_d2scaled = cpu_d->data[0];
          for (b_i = 0; b_i < npages; b_i++) {
            cpu_d2scaled += cpu_d->data[b_i + 1];
          }

          cpu_d2scaled /= static_cast<real_T>(cpu_d->size[0]);
          b_i = cpu_absdiff->size[0];
          cpu_absdiff->size[0] = cpu_d->size[0];
          emxEnsureCapacity_real_T(cpu_absdiff, b_i, &cd_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_absdiff, &c_gpu_absdiff);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(npages
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            if (d_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, cpu_d);
            }

            d_outdatedOnGpu = false;
            ec_detrend_kernel75<<<grid, block>>>(cpu_d2scaled, c_gpu_d, npages,
              c_gpu_absdiff);
          }

          cublasDnrm2(getCublasGlobalHandle(), cpu_d->size[0], (double *)
                      &c_gpu_absdiff.data[0], 1, (double *)&cpu_d2scaled);
          cpu_d2scaled /= std::sqrt(static_cast<real_T>(cpu_d->size[0]) - 1.0);
        }

        cpu_d2scaled *= thr;

        // 'ec_detrend:90' w(abs(d)>thrItr) = 0;
        cpu_nx = cpu_d->size[0];
        b_i = d_cpu_y->size[0];
        d_cpu_y->size[0] = cpu_d->size[0];
        emxEnsureCapacity_real_T(d_cpu_y, b_i, &dd_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_cpu_y, &j_gpu_y);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(cpu_nx),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_d, cpu_d);
          }

          d_outdatedOnGpu = false;
          ec_detrend_kernel77<<<grid, block>>>(c_gpu_d, cpu_nx, j_gpu_y);
        }

        vlen = d_cpu_y->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_detrend_kernel78<<<grid, block>>>(cpu_d2scaled, j_gpu_y, vlen,
            b_gpu_w);
          b_w_outdatedOnCpu = true;
        }

        //  update weights
      }

      // 'ec_detrend:92' x = x-z;
      vlen = cpu_x->size[0];
      if (vlen == cpu_z->size[0]) {
        b_i = b_cpu_x->size[0];
        b_cpu_x->size[0] = vlen;
        emxEnsureCapacity_real_T(b_cpu_x, b_i, &l_emlrtRTEI);
        if (!b_x_outdatedOnGpu) {
          gpuEmxEnsureCapacity_real_T(b_cpu_x, &b_gpu_x);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (z_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_z, cpu_z);
          }

          z_outdatedOnGpu = false;
          if (x_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
          }

          x_outdatedOnGpu = false;
          if (b_x_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
          }

          ec_detrend_kernel79<<<grid, block>>>(b_gpu_z, ch, gpu_x, vlen, b_gpu_x,
            cpu_x->size[0U]);
          b_x_outdatedOnGpu = false;
          b_x_outdatedOnCpu = true;
        }
      } else {
        if (b_x_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &b_gpu_x);
        }

        if (x_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_x, &gpu_x);
        }

        x_outdatedOnCpu = false;
        if (z_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_z, &b_gpu_z);
        }

        z_outdatedOnCpu = false;
        binary_expand_op_6(b_cpu_x, cpu_x, ch, cpu_z);
        b_x_outdatedOnCpu = false;
        b_x_outdatedOnGpu = true;
      }
    }

    b_i = b_cpu_x->size[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (b_x_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, b_cpu_x);
      }

      b_x_outdatedOnGpu = false;
      if (x_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
      }

      ec_detrend_kernel193<<<grid, block>>>(b_gpu_x, ch, b_i, gpu_x, cpu_x->
        size[0U]);
      x_outdatedOnGpu = false;
      x_outdatedOnCpu = true;
    }

    b_i = b_cpu_w->size[0] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_i + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      if (w_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, cpu_w);
      }

      ec_detrend_kernel194<<<grid, block>>>(b_gpu_w, ch, b_i, gpu_w, cpu_w->
        size[0U]);
      w_outdatedOnGpu = false;
      w_outdatedOnCpu = true;
    }
  }

  emxFree_real_T(&d_cpu_a);
  emxFree_real_T(&b_cpu_trend);
  emxFree_real_T(&j_cpu_x);
  emxFree_real_T(&f_cpu_V);
  emxFree_real_T(&d_cpu_r);
  emxFree_real_T(&e_cpu_V);
  emxFree_real_T(&j_cpu_y);
  emxFree_real_T(&c_cpu_absdiff);
  emxFree_real_T(&c_cpu_d);
  emxFree_int8_T(&c_cpu_a);
  emxFree_real_T(&i_cpu_y);
  emxFree_real_T(&c_cpu_b);
  emxFree_real_T(&h_cpu_y);
  emxFree_real_T(&g_cpu_y);
  emxFree_real_T(&f_cpu_y);
  emxFree_int8_T(&b_cpu_a);
  emxFree_real_T(&cpu_yy);
  emxFree_real_T(&b_cpu_absdiff);
  emxFree_real_T(&b_cpu_d);
  emxFree_real_T(&cpu_dv11);
  emxFree_ptrdiff_t(&b_jpvt_t);
  emxFree_real_T(&e_cpu_y);
  emxFree_real_T(&d_cpu_tau);
  emxFree_int32_T(&b_cpu_ipiv_t);
  emxFree_int32_T(&b_cpu_jpvt);
  emxFree_real_T(&d_cpu_B);
  emxFree_real_T(&b_wi);
  emxFree_int32_T(&b_cpu_ipiv);
  emxFree_real_T(&c_cpu_B);
  emxFree_real_T(&n_cpu_A);
  emxFree_real_T(&b_wr);
  emxFree_real_T(&b_cpu_Y);
  emxFree_real_T(&m_cpu_A);
  emxFree_real_T(&b_cpu_vright);
  emxFree_real_T(&b_cpu_wimag);
  emxFree_real_T(&c_cpu_tau);
  emxFree_real_T(&l_cpu_A);
  emxFree_real_T(&b_cpu_wreal);
  emxFree_real_T(&b_cpu_b);
  emxFree_creal_T(&d_cpu_W);
  emxFree_real_T(&b_cpu_U);
  emxFree_real_T(&k_cpu_A);
  emxFree_real_T(&b_scale);
  emxFree_real_T(&j_cpu_A);
  emxFree_real_T(&d_cpu_y);
  emxFree_real_T(&cpu_absdiff);
  emxFree_real_T(&c_cpu_W);
  emxFree_int32_T(&cpu_iv1);
  emxFree_real_T(&cpu_d);
  emxFree_real_T(&d_cpu_D);
  emxFree_real_T(&b_cpu_v);
  emxFree_real_T(&cpu_dv7);
  emxFree_real_T(&d_cpu_V);
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_creal_T(&c_cpu_D);
  emxFree_real_T(&c_cpu_y);
  emxFree_real_T(&b_cpu_tau);
  emxFree_creal_T(&c_cpu_V);
  emxFree_int32_T(&cpu_ipiv_t);
  emxFree_int32_T(&cpu_jpvt);
  emxFree_real_T(&b_cpu_B);
  emxFree_real_T(&wi);
  emxFree_int32_T(&cpu_ipiv);
  emxFree_real_T(&cpu_B);
  emxFree_real_T(&i_cpu_A);
  emxFree_real_T(&wr);
  emxFree_real_T(&cpu_Y);
  emxFree_real_T(&h_cpu_A);
  emxFree_real_T(&g_cpu_A);
  emxFree_real_T(&b_cpu_rr);
  emxFree_real_T(&f_cpu_A);
  emxFree_real_T(&cpu_vright);
  emxFree_real_T(&cpu_wimag);
  emxFree_real_T(&cpu_tau);
  emxFree_real_T(&e_cpu_A);
  emxFree_real_T(&cpu_wreal);
  emxFree_real_T(&cpu_b);
  emxFree_creal_T(&b_cpu_W);
  emxFree_real_T(&cpu_U);
  emxFree_real_T(&d_cpu_A);
  emxFree_real_T(&scale);
  emxFree_real_T(&i_cpu_x);
  emxFree_real_T(&b_cpu_y);
  emxFree_real_T(&c_cpu_A);
  emxFree_real_T(&cpu_dv3);
  emxFree_real_T(&cpu_W);
  emxFree_int32_T(&cpu_iv);
  emxFree_real_T(&h_cpu_x);
  emxFree_real_T(&b_cpu_D);
  emxFree_real_T(&cpu_v);
  emxFree_real_T(&b_cpu_V);
  emxFree_creal_T(&cpu_D);
  emxFree_creal_T(&cpu_V);
  emxFree_real_T(&g_cpu_x);
  emxFree_real_T(&b_cpu_A);
  emxFree_real_T(&cpu_A);
  emxFree_real_T(&cpu_rr);
  emxFree_real_T(&c_cpu_r);
  emxFree_real_T(&cpu_dv2);
  emxFree_real_T(&b_cpu_z);
  emxFree_real_T(&f_cpu_x);
  emxFree_real_T(&b_cpu_lin);
  emxFree_real_T(&cpu_y);
  emxFree_real_T(&b_cpu_r);
  emxFree_real_T(&cpu_dv1);
  emxFree_real_T(&e_cpu_x);
  emxFree_real_T(&d_cpu_x);
  emxFree_real_T(&cpu_minval);
  emxFree_real_T(&cpu_z);
  emxFree_real_T(&cpu_lin);
  emxFree_real_T(&cpu_a);
  emxFree_real_T(&cpu_r);
  emxFree_real_T(&cpu_trend);
  emxFree_real_T(&c_cpu_x);
  emxFree_real_T(&b_cpu_w);
  emxFree_real_T(&b_cpu_x);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_outdatedOnCpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_x, &gpu_x);
  }

  if (w_outdatedOnCpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_w, &gpu_w);
  }

  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_w);
  gpuEmxFree_real_T(&b_gpu_x);
  gpuEmxFree_real_T(&b_gpu_w);
  gpuEmxFree_real_T(&f_gpu_x);
  gpuEmxFree_real_T(&gpu_trend);
  gpuEmxFree_real_T(&c_gpu_r);
  gpuEmxFree_real_T(&gpu_a);
  gpuEmxFree_real_T(&b_gpu_lin);
  gpuEmxFree_real_T(&b_gpu_z);
  gpuEmxFree_real_T(&gpu_minval);
  gpuEmxFree_real_T(&h_gpu_x);
  gpuEmxFree_real_T(&i_gpu_x);
  gpuEmxFree_real_T(&gpu_dv1);
  gpuEmxFree_real_T(&gpu_r);
  gpuEmxFree_real_T(&h_gpu_y);
  gpuEmxFree_real_T(&gpu_lin);
  gpuEmxFree_real_T(&j_gpu_x);
  gpuEmxFree_real_T(&gpu_z);
  gpuEmxFree_real_T(&gpu_dv2);
  gpuEmxFree_real_T(&d_gpu_r);
  gpuEmxFree_real_T(&b_gpu_rr);
  gpuEmxFree_real_T(&i_gpu_A);
  gpuEmxFree_real_T(&h_gpu_A);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_creal_T(&d_gpu_V);
  gpuEmxFree_creal_T(&c_gpu_D);
  gpuEmxFree_real_T(&e_gpu_V);
  gpuEmxFree_real_T(&b_gpu_v);
  gpuEmxFree_real_T(&d_gpu_D);
  gpuEmxFree_real_T(&d_gpu_x);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_real_T(&c_gpu_W);
  gpuEmxFree_real_T(&gpu_dv3);
  gpuEmxFree_real_T(&n_gpu_A);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_real_T(&e_gpu_x);
  gpuEmxFree_real_T(&j_gpu_A);
  gpuEmxFree_real_T(&b_gpu_U);
  gpuEmxFree_creal_T(&d_gpu_W);
  gpuEmxFree_real_T(&c_gpu_b);
  gpuEmxFree_real_T(&b_gpu_wreal);
  gpuEmxFree_real_T(&k_gpu_A);
  gpuEmxFree_real_T(&d_gpu_tau);
  gpuEmxFree_real_T(&b_gpu_wimag);
  gpuEmxFree_real_T(&b_gpu_vright);
  gpuEmxFree_real_T(&l_gpu_A);
  gpuEmxFree_real_T(&gpu_rr);
  gpuEmxFree_real_T(&b_gpu_A);
  gpuEmxFree_real_T(&gpu_A);
  gpuEmxFree_real_T(&b_gpu_Y);
  gpuEmxFree_real_T(&m_gpu_A);
  gpuEmxFree_real_T(&d_gpu_B);
  gpuEmxFree_int32_T(&b_gpu_ipiv);
  gpuEmxFree_real_T(&c_gpu_B);
  gpuEmxFree_int32_T(&b_gpu_jpvt);
  gpuEmxFree_int32_T(&b_gpu_ipiv_t);
  gpuEmxFree_creal_T(&gpu_V);
  gpuEmxFree_real_T(&c_gpu_tau);
  gpuEmxFree_real_T(&i_gpu_y);
  gpuEmxFree_creal_T(&gpu_D);
  gpuEmxFree_real_T(&b_gpu_V);
  gpuEmxFree_real_T(&gpu_dv7);
  gpuEmxFree_real_T(&gpu_v);
  gpuEmxFree_real_T(&b_gpu_D);
  gpuEmxFree_real_T(&c_gpu_d);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_real_T(&gpu_W);
  gpuEmxFree_real_T(&c_gpu_absdiff);
  gpuEmxFree_real_T(&j_gpu_y);
  gpuEmxFree_real_T(&g_gpu_A);
  gpuEmxFree_real_T(&c_gpu_A);
  gpuEmxFree_real_T(&gpu_U);
  gpuEmxFree_creal_T(&b_gpu_W);
  gpuEmxFree_real_T(&gpu_b);
  gpuEmxFree_real_T(&gpu_wreal);
  gpuEmxFree_real_T(&d_gpu_A);
  gpuEmxFree_real_T(&b_gpu_tau);
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
  gpuEmxFree_real_T(&gpu_dv11);
  gpuEmxFree_real_T(&gpu_d);
  gpuEmxFree_real_T(&gpu_absdiff);
  gpuEmxFree_real_T(&gpu_yy);
  gpuEmxFree_int8_T(&b_gpu_a);
  gpuEmxFree_real_T(&d_gpu_y);
  gpuEmxFree_real_T(&f_gpu_y);
  gpuEmxFree_real_T(&e_gpu_y);
  gpuEmxFree_real_T(&b_gpu_b);
  gpuEmxFree_real_T(&g_gpu_y);
  gpuEmxFree_int8_T(&d_gpu_a);
  gpuEmxFree_real_T(&b_gpu_d);
  gpuEmxFree_real_T(&b_gpu_absdiff);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&f_gpu_V);
  gpuEmxFree_real_T(&b_gpu_r);
  gpuEmxFree_real_T(&c_gpu_V);
  gpuEmxFree_real_T(&g_gpu_x);
  gpuEmxFree_real_T(&b_gpu_trend);
  gpuEmxFree_real_T(&c_gpu_a);
  mwCudaFree(gpu_nx);
  mwCudaFree(gpu_d2scaled);
  mwCudaFree(b_gpu_info);
  mwCudaFree(gpu_info);
}

void ec_detrend_api(const mxArray * const prhs[6], int32_T nlhs, const mxArray
                    *plhs[2])
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
  ec_detrend(x, w, order, thr, nItr, winSz);

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
