//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ecc_filtfilt.cu
//
// Code generation for function 'ecc_filtfilt'
//

// Include files
#include "ecc_filtfilt.h"
#include "_coder_ecc_filtfilt_mex.h"
#include "ecc_filtfilt_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWMemoryManager.hpp"
#include "cs.h"
#include "makeCXSparseMatrix.h"
#include "solve_from_lu.h"
#include "solve_from_qr.h"
#include <algorithm>
#include <cmath>
#include <cstring>

// Type Definitions
struct struct_T
{
  int32_T xstart;
  int32_T xend;
  int32_T depth;
};

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
  131642U,                             // fVersionInfo
  nullptr,                             // fErrorFunction
  "ecc_filtfilt",                      // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 3615363707U, 2875872051U, 2733369800U, 3255517249U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtMCInfo emlrtMCI{ 14,       // lineNo
  25,                                  // colNo
  "warning",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/lib/+coder/+internal/warning.m"// pName
};

static emlrtMCInfo b_emlrtMCI{ 14,     // lineNo
  9,                                   // colNo
  "warning",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/lib/+coder/+internal/warning.m"// pName
};

static emlrtMCInfo c_emlrtMCI{ 53,     // lineNo
  19,                                  // colNo
  "flt2str",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/flt2str.m"// pName
};

static emlrtRTEInfo emlrtRTEI{ 1,      // lineNo
  1,                                   // colNo
  "_coder_ecc_filtfilt_api",           // fName
  ""                                   // pName
};

static emlrtRTEInfo b_emlrtRTEI{ 134,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 9,    // lineNo
  1,                                   // colNo
  "ecc_filtfilt",                      // fName
  "/home/kt/Gdrive/Git/electroCUDA/bin/mexSrc/ecc_filtfilt.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 188,  // lineNo
  25,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 200,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 269,  // lineNo
  13,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 270,  // lineNo
  13,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 108,  // lineNo
  18,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 110,  // lineNo
  13,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 28,   // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 108,  // lineNo
  13,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 152,  // lineNo
  20,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 430,  // lineNo
  5,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 30,   // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 292,  // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 829,  // lineNo
  21,                                  // colNo
  "unaryMinOrMax",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 145,  // lineNo
  8,                                   // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 152,  // lineNo
  13,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 369,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 9,    // lineNo
  5,                                   // colNo
  "ecc_filtfilt",                      // fName
  "/home/kt/Gdrive/Git/electroCUDA/bin/mexSrc/ecc_filtfilt.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 319,  // lineNo
  16,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 162,  // lineNo
  25,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 76,   // lineNo
  9,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 293,  // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 154,  // lineNo
  20,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 158, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 60,  // lineNo
  20,                                  // colNo
  "bsxfun",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/elmat/bsxfun.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 88,  // lineNo
  9,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "gpufilterImpl",                     // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/datafun/private/gpufilterImpl.p"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 294, // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 158, // lineNo
  16,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 222, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 223, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "stencil_codegen",                   // fName
  "/usr/local/MATLAB/R2023a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/stencil_codegen.p"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 434, // lineNo
  44,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 295, // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 172, // lineNo
  20,                                  // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 1653,// lineNo
  27,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 125, // lineNo
  44,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 1682,// lineNo
  5,                                   // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 13,  // lineNo
  1,                                   // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/lib/matlab/sparfun/sparse.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 193, // lineNo
  42,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 395, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 298, // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 388, // lineNo
  38,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 405, // lineNo
  46,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 399, // lineNo
  46,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 32,  // lineNo
  1,                                   // colNo
  "locTranspose",                      // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/+coder/+internal/@sparse/locTranspose.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 439, // lineNo
  57,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 372, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 442, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 437, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 373, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 440, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 403, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 1,   // lineNo
  14,                                  // colNo
  "ecc_filtfilt",                      // fName
  "/home/kt/Gdrive/Git/electroCUDA/bin/mexSrc/ecc_filtfilt.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 292, // lineNo
  36,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 144, // lineNo
  22,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 292, // lineNo
  47,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 144, // lineNo
  5,                                   // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 293, // lineNo
  42,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 428, // lineNo
  5,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 293, // lineNo
  53,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 370, // lineNo
  51,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 433, // lineNo
  29,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 433, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 319, // lineNo
  5,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 322, // lineNo
  42,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 237, // lineNo
  13,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 298, // lineNo
  22,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 119, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 120, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 125, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2023a/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 324, // lineNo
  42,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 436, // lineNo
  29,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 457, // lineNo
  63,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 394, // lineNo
  25,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 386, // lineNo
  57,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2023a/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 19,  // lineNo
  9,                                   // colNo
  "indexDivide",                       // fName
  "/usr/local/MATLAB/R2023a/toolbox/eml/eml/+coder/+internal/indexDivide.m"// pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *coef, const char_T *identifier,
  emxArray_real_T *y);
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[14]);
static const mxArray *b_feval(const mxArray *m1, const mxArray *m2, emlrtMCInfo *
  location);
static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
  emlrtMCInfo *location);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2);
static void binary_expand_op(emxArray_real_T *in1, int32_T in3, const
  emxArray_real_T *in4);
static void c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
namespace coder
{
  namespace internal
  {
    static void b_heapsort(emxArray_int32_T *x, int32_T xstart, int32_T xend,
      const emxArray_int32_T *cmp_workspace_a, const emxArray_int32_T
      *cmp_workspace_b);
    static void b_warning();
    static void c_warning();
    static void insertionsort(emxArray_int32_T *x, int32_T xstart, int32_T xend,
      const emxArray_int32_T *cmp_workspace_a, const emxArray_int32_T
      *cmp_workspace_b);
    static void introsort(emxArray_int32_T *x, int32_T xend, const
                          emxArray_int32_T *cmp_workspace_a, const
                          emxArray_int32_T *cmp_workspace_b);
    static void warning(int32_T varargin_1, const char_T varargin_2[14]);
    static void warning();
  }
}

static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static void d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static int32_T div_s32(int32_T numerator, int32_T denominator);
static
#ifdef __CUDACC__

__device__
#endif

int32_T div_s32_device(int32_T numerator, int32_T denominator);
static __global__ void ecc_filtfilt_kernel1(const emxArray_real_T coef, int32_T
  b_coef, emxArray_real_T b2, emxArray_real_T a2);
static __global__ void ecc_filtfilt_kernel10(const int32_T nfilt, int32_T x[2]);
static __global__ void ecc_filtfilt_kernel100(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel101(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel102(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel103(uint32_T zfSize[2], int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel104(uint32_T dv1[2], int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel105(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel106(const int32_T vlen, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv5);
static __global__ void ecc_filtfilt_kernel107(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv6);
static __global__ void ecc_filtfilt_kernel108(const emxArray_real_T xc1, const
  emxArray_int32_T iv6, const emxArray_int32_T iv5, const int32_T b_xc1, int32_T
  c_xc1, emxArray_real_T expanded, int32_T expanded_dim0, int32_T xc1_dim0);
static __global__ void ecc_filtfilt_kernel109(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T OH,
  int32_T c, emxArray_real_T convOut, int32_T b_dim0, int32_T expanded_dim0,
  int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel11(int32_T loop_ub, emxArray_int32_T
  cols);
static __global__ void ecc_filtfilt_kernel110(const emxArray_real_T zfIIR, const
  emxArray_real_T convOut, const int32_T i, int32_T b_convOut, emxArray_real_T
  c_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0, int32_T zfIIR_dim0);
static __global__ void ecc_filtfilt_kernel111(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, emxArray_real_T d_convOut, int32_T
  convOut_dim0, int32_T b_convOut_dim0);
static __global__ void ecc_filtfilt_kernel112(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel113(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim1, int32_T convOut_dim0,
  int32_T zfIIR_dim0);
static __global__ void ecc_filtfilt_kernel114(const emxArray_real_T a, int32_T
  ns, emxArray_real_T convOut, int32_T xc1_dim0, int32_T a_dim0, int32_T
  convOut_dim0);
static __global__ void ecc_filtfilt_kernel115(const emxArray_real_T convOut,
  const int32_T ns, const int32_T nfilt, int32_T b_convOut, emxArray_real_T
  zfIIR, int32_T zfIIR_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel116(const emxArray_real_T convOut,
  const emxArray_real_T a, const int32_T b_a, int32_T ns, emxArray_real_T zfIIR,
  int32_T a_dim0, int32_T zfIIR_dim0, int32_T xc1_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel117(const emxArray_real_T convOut,
  const int32_T xc1, int32_T b_convOut, emxArray_real_T c_convOut, int32_T
  convOut_dim0, int32_T b_convOut_dim0);
static __global__ void ecc_filtfilt_kernel118(int32_T x[2], int32_T xc1_dim0,
  int32_T xc1_dim1);
static __global__ void ecc_filtfilt_kernel119(const emxArray_real_T convOut,
  int32_T x, emxArray_real_T y);
static __global__ void ecc_filtfilt_kernel12(const emxArray_int32_T y, const
  int32_T x[2], int32_T loop_ub, emxArray_int32_T cols);
static __global__ void ecc_filtfilt_kernel120(const emxArray_real_T xc1, const
  int32_T ns, int32_T b_xc1, emxArray_real_T y, int32_T xc1_dim0);
static __global__ void ecc_filtfilt_kernel121(const emxArray_real_T xc1, const
  emxArray_real_T y, const int32_T x, const int32_T vlen, const int32_T thism,
  const int32_T idx, const int32_T nfilt, const int32_T xt, int32_T ns,
  emxArray_real_T b_xt, int32_T xt_dim0, int32_T xc1_dim0);
static __global__ void ecc_filtfilt_kernel122(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel123(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel124(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel125(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel126(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel127(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel128(const int32_T vlen, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv10);
static __global__ void ecc_filtfilt_kernel129(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv11);
static __global__ void ecc_filtfilt_kernel13(const emxArray_int32_T y, const
  int32_T x[2], int32_T loop_ub, emxArray_int32_T cols, int32_T y_dim1);
static __global__ void ecc_filtfilt_kernel130(const emxArray_real_T xt, const
  emxArray_int32_T iv11, const emxArray_int32_T iv10, const int32_T b_xt,
  int32_T c_xt, emxArray_real_T expanded, int32_T expanded_dim0, int32_T xt_dim0);
static __global__ void ecc_filtfilt_kernel131(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T OH,
  int32_T c, emxArray_real_T convOut, int32_T b_dim0, int32_T expanded_dim0,
  int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel132(const emxArray_real_T zfIIR, const
  emxArray_real_T convOut, const int32_T i, int32_T b_convOut, emxArray_real_T
  c_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0, int32_T zfIIR_dim0);
static __global__ void ecc_filtfilt_kernel133(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, emxArray_real_T d_convOut, int32_T
  convOut_dim0, int32_T b_convOut_dim0);
static __global__ void ecc_filtfilt_kernel134(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel135(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim1, int32_T convOut_dim0,
  int32_T zfIIR_dim0);
static __global__ void ecc_filtfilt_kernel136(const emxArray_real_T a, int32_T
  ns, emxArray_real_T convOut, int32_T xt_dim0, int32_T a_dim0, int32_T
  convOut_dim0);
static __global__ void ecc_filtfilt_kernel137(const emxArray_real_T convOut,
  const int32_T xt, int32_T b_convOut, emxArray_real_T c_convOut, int32_T
  convOut_dim0, int32_T b_convOut_dim0);
static __global__ void ecc_filtfilt_kernel138(int32_T x[2], int32_T xt_dim0,
  int32_T xt_dim1);
static __global__ void ecc_filtfilt_kernel139(const emxArray_real_T convOut,
  int32_T x, emxArray_real_T yc3);
static __global__ void ecc_filtfilt_kernel14(const int32_T nfilt, int32_T x[2]);
static __global__ void ecc_filtfilt_kernel140(const emxArray_real_T yc3, const
  int32_T ns, const emxArray_real_T zi, const int32_T b_zi, int32_T loop_ub,
  emxArray_real_T y, int32_T y_dim0, int32_T yc3_dim0);
static __global__ void ecc_filtfilt_kernel141(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel142(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel143(const emxArray_real_T yc3, const
  int32_T ns, const emxArray_real_T zi, const int32_T b_zi, int32_T loop_ub,
  emxArray_real_T c_zi, int32_T yc3_dim0, int32_T zi_dim0);
static __global__ void ecc_filtfilt_kernel144(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel145(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel146(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel147(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel148(const int32_T vlen, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv13);
static __global__ void ecc_filtfilt_kernel149(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv14);
static __global__ void ecc_filtfilt_kernel15(emxArray_int8_T vals);
static __global__ void ecc_filtfilt_kernel150(const emxArray_real_T yc3, const
  int32_T i52, const int32_T i51, const emxArray_int32_T iv14, const
  emxArray_int32_T iv13, const int32_T i, int32_T b_yc3, emxArray_real_T
  expanded, int32_T expanded_dim0, int32_T yc3_dim0);
static __global__ void ecc_filtfilt_kernel151(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T OH,
  int32_T c, emxArray_real_T convOut, int32_T b_dim0, int32_T expanded_dim0,
  int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel152(const emxArray_real_T zi, const
  emxArray_real_T convOut, const int32_T ns, int32_T b_convOut, emxArray_real_T
  c_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0, int32_T zi_dim0);
static __global__ void ecc_filtfilt_kernel153(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, emxArray_real_T d_convOut, int32_T
  convOut_dim0, int32_T b_convOut_dim0);
static __global__ void ecc_filtfilt_kernel154(const emxArray_real_T y, const
  int32_T zi, int32_T ns, emxArray_real_T convOut, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel155(const emxArray_real_T y, const
  int32_T zi, int32_T ns, emxArray_real_T convOut, int32_T convOut_dim0, int32_T
  y_dim0);
static __global__ void ecc_filtfilt_kernel156(const emxArray_real_T a, const
  int32_T i52, const int32_T i51, const int32_T i53, int32_T ns, emxArray_real_T
  convOut, int32_T a_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel157(const emxArray_real_T convOut,
  const int32_T ns, const int32_T nfilt, int32_T b_convOut, emxArray_real_T
  zfIIR, int32_T zfIIR_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel158(const emxArray_real_T convOut,
  const int32_T i52, const int32_T i51, const int32_T i53, const emxArray_real_T
  a, const int32_T b_a, int32_T ns, emxArray_real_T zfIIR, int32_T a_dim0,
  int32_T zfIIR_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel159(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel16(const emxArray_real_T a2, const
  int32_T ns, int32_T loop_ub, emxArray_int8_T vals);
static __global__ void ecc_filtfilt_kernel160(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel161(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel162(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel163(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel164(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel165(const int32_T vlen, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv16);
static __global__ void ecc_filtfilt_kernel166(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv17);
static __global__ void ecc_filtfilt_kernel167(const emxArray_real_T y, const
  emxArray_int32_T iv17, const emxArray_int32_T iv16, const int32_T zfSize_idx_1,
  int32_T b_y, emxArray_real_T expanded, int32_T expanded_dim0, int32_T y_dim0);
static __global__ void ecc_filtfilt_kernel168(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T OH,
  int32_T c, emxArray_real_T convOut, int32_T b_dim0, int32_T expanded_dim0,
  int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel169(const emxArray_real_T zfIIR, const
  emxArray_real_T convOut, const int32_T i, int32_T b_convOut, emxArray_real_T
  c_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0, int32_T zfIIR_dim0);
static __global__ void ecc_filtfilt_kernel17(const int32_T ns, const int32_T
  vlen, int32_T loop_ub, emxArray_int8_T vals);
static __global__ void ecc_filtfilt_kernel170(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, emxArray_real_T d_convOut, int32_T
  convOut_dim0, int32_T b_convOut_dim0);
static __global__ void ecc_filtfilt_kernel171(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel172(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim1, int32_T convOut_dim0,
  int32_T zfIIR_dim0);
static __global__ void ecc_filtfilt_kernel173(const emxArray_real_T a, const
  int32_T zfSize_idx_1, int32_T ns, emxArray_real_T convOut, int32_T a_dim0,
  int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel174(const emxArray_real_T convOut,
  const int32_T zfSize_idx_1, int32_T b_convOut, emxArray_real_T c_convOut,
  int32_T convOut_dim0, int32_T b_convOut_dim0);
static __global__ void ecc_filtfilt_kernel175(const int32_T zfSize_idx_1,
  int32_T x[2], int32_T y_dim1);
static __global__ void ecc_filtfilt_kernel176(const emxArray_real_T convOut,
  int32_T x, emxArray_real_T yc5);
static __global__ void ecc_filtfilt_kernel177(const emxArray_real_T yc5, const
  int32_T b_yc5, int32_T c_yc5, emxArray_real_T xc1, int32_T xc1_dim0, int32_T
  yc5_dim0);
static __global__ void ecc_filtfilt_kernel178(const emxArray_real_T xc1, const
  int32_T x[2], const int32_T b_x, int32_T c_x, emxArray_real_T d_x, int32_T
  x_dim0);
static __global__ void ecc_filtfilt_kernel179(const emxArray_real_T a2, real_T
  *a1, real_T *b_a1, real_T *c_a1, real_T *d_a1, real_T *e_a1);
static __global__ void ecc_filtfilt_kernel18(const int32_T x[2], const int32_T
  ns, const int32_T vlen, int32_T nfilt, emxArray_int8_T vals);
static __global__ void ecc_filtfilt_kernel180(const real_T *d, const
  emxArray_real_T x, const int32_T i, emxArray_real_T xt);
static __global__ void ecc_filtfilt_kernel181(const real_T val, const
  emxArray_real_T zi, int32_T b_zi, emxArray_real_T y);
static __global__ void ecc_filtfilt_kernel182(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel183(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel184(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel185(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel186(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel187(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel188(const emxArray_real_T xt, const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_real_T expanded);
static __global__ void ecc_filtfilt_kernel189(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T OH,
  emxArray_real_T convOut, int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel19(const emxArray_real_T a2, const
  real_T val, const emxArray_real_T b2, int32_T nfilt, emxArray_real_T rhs);
static __global__ void ecc_filtfilt_kernel190(const emxArray_real_T y, int32_T
  ns, emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel191(const emxArray_real_T y,
  emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel192(const emxArray_real_T convOut,
  const int32_T ns, int32_T nfilt, emxArray_real_T zfIIR);
static __global__ void ecc_filtfilt_kernel193(const emxArray_real_T convOut,
  const emxArray_real_T a, int32_T ns, emxArray_real_T zfIIR, int32_T a_dim0,
  int32_T xt_dim0);
static __global__ void ecc_filtfilt_kernel194(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel195(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel196(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel197(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel198(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel199(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel2(emxArray_real_T a2);
static __global__ void ecc_filtfilt_kernel20(const emxArray_int32_T rows,
  int32_T ns, emxArray_int32_T ridxInt);
static __global__ void ecc_filtfilt_kernel200(const emxArray_real_T x, const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_real_T expanded);
static __global__ void ecc_filtfilt_kernel201(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T OH,
  emxArray_real_T convOut, int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel202(const emxArray_real_T zfIIR,
  int32_T zfSize_idx_0, emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel203(const emxArray_real_T zfIIR,
  emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel204(const emxArray_real_T convOut,
  const int32_T ns, int32_T nfilt, emxArray_real_T zfIIR);
static __global__ void ecc_filtfilt_kernel205(const emxArray_real_T convOut,
  const emxArray_real_T a, int32_T ns, emxArray_real_T zfIIR, int32_T a_dim0,
  int32_T x_dim0);
static __global__ void ecc_filtfilt_kernel206(const emxArray_real_T convOut,
  int32_T x, emxArray_real_T y);
static __global__ void ecc_filtfilt_kernel207(const real_T *d, const
  emxArray_real_T x, const int32_T nfilt, const int32_T ns, int32_T idx,
  emxArray_real_T xt);
static __global__ void ecc_filtfilt_kernel208(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel209(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel21(const emxArray_int32_T cols,
  int32_T ns, emxArray_int32_T sortedIndices, emxArray_int32_T cidxInt);
static __global__ void ecc_filtfilt_kernel210(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel211(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel212(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel213(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel214(const emxArray_real_T xt, const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_real_T expanded);
static __global__ void ecc_filtfilt_kernel215(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T OH,
  emxArray_real_T convOut, int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel216(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel217(const emxArray_real_T convOut,
  int32_T xt, emxArray_real_T yc3);
static __global__ void ecc_filtfilt_kernel218(const real_T val, const
  emxArray_real_T zi, int32_T b_zi, emxArray_real_T y);
static __global__ void ecc_filtfilt_kernel219(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel22(const emxArray_int32_T cidxInt,
  int32_T b_cidxInt, emxArray_int32_T t);
static __global__ void ecc_filtfilt_kernel220(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel221(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel222(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel223(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel224(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel225(const int32_T vlen, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv15);
static __global__ void ecc_filtfilt_kernel226(const emxArray_real_T yc3, const
  int32_T zfSize_idx_1, const int32_T idx, const emxArray_int32_T iv15, int32_T
  k, emxArray_real_T expanded);
static __global__ void ecc_filtfilt_kernel227(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T OH,
  emxArray_real_T convOut, int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel228(const emxArray_real_T y, int32_T
  ns, emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel229(const emxArray_real_T y,
  emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel23(const emxArray_int32_T t, const
  emxArray_int32_T sortedIndices, int32_T ns, emxArray_int32_T cidxInt);
static __global__ void ecc_filtfilt_kernel230(const emxArray_real_T convOut,
  const int32_T ns, int32_T nfilt, emxArray_real_T zfIIR);
static __global__ void ecc_filtfilt_kernel231(const emxArray_real_T convOut,
  const int32_T zfSize_idx_1, const int32_T idx, const int32_T c, const
  emxArray_real_T a, int32_T ns, emxArray_real_T zfIIR, int32_T a_dim0);
static __global__ void ecc_filtfilt_kernel232(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel233(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel234(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel235(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel236(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel237(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel238(const int32_T vlen, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv18);
static __global__ void ecc_filtfilt_kernel239(const emxArray_real_T y, const
  emxArray_int32_T iv18, const int32_T idx, emxArray_real_T expanded);
static __global__ void ecc_filtfilt_kernel24(const emxArray_int32_T ridxInt,
  int32_T b_ridxInt, emxArray_int32_T t);
static __global__ void ecc_filtfilt_kernel240(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T OH,
  emxArray_real_T convOut, int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel241(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel242(const emxArray_real_T convOut,
  const int32_T idx, emxArray_real_T b_convOut);
static __global__ void ecc_filtfilt_kernel243(const emxArray_real_T convOut,
  const int32_T x, emxArray_real_T b_x);
static __global__ void ecc_filtfilt_kernel244(const emxArray_real_T x, int32_T
  b_x, emxArray_real_T yCol);
static __global__ void ecc_filtfilt_kernel245(const emxArray_real_T a2, real_T
  *a1, real_T *b_a1);
static __global__ void ecc_filtfilt_kernel246(const emxArray_real_T yCol, real_T
  *d);
static __global__ void ecc_filtfilt_kernel247(const emxArray_real_T yCol, const
  int32_T i, const real_T *d, int32_T loop_ub, emxArray_real_T ytemp);
static __global__ void ecc_filtfilt_kernel248(const real_T val, const
  emxArray_real_T zi, int32_T b_zi, emxArray_real_T y);
static __global__ void ecc_filtfilt_kernel249(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel25(const emxArray_int32_T t, const
  emxArray_int32_T sortedIndices, int32_T ns, emxArray_int32_T ridxInt);
static __global__ void ecc_filtfilt_kernel250(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel251(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel252(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel253(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel254(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel255(const emxArray_real_T ytemp, const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_real_T expanded);
static __global__ void ecc_filtfilt_kernel256(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T OH,
  emxArray_real_T convOut, int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel257(const emxArray_real_T y, int32_T
  ns, emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel258(const emxArray_real_T y,
  emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel259(const real_T val, const
  emxArray_real_T zi, int32_T b_zi, emxArray_real_T y);
static __global__ void ecc_filtfilt_kernel26(int32_T cols, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ecc_filtfilt_kernel260(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel261(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel262(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel263(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel264(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel265(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel266(const int32_T vlen, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv8);
static __global__ void ecc_filtfilt_kernel267(const emxArray_real_T convOut,
  const int32_T k, const emxArray_int32_T iv8, int32_T ns, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel268(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T OH,
  emxArray_real_T convOut, int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel269(const emxArray_real_T y, int32_T
  ns, emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel27(const emxArray_int8_T vals, const
  emxArray_int32_T sortedIndices, int32_T nfilt, emxArray_real_T y_d);
static __global__ void ecc_filtfilt_kernel270(const emxArray_real_T y,
  emxArray_real_T convOut);
static __global__ void ecc_filtfilt_kernel271(const emxArray_real_T convOut,
  const int32_T nfilt, const int32_T ns, int32_T idx, emxArray_real_T yCol);
static __global__ void ecc_filtfilt_kernel272(const emxArray_real_T yCol, const
  int32_T x, emxArray_real_T b_x);
static __global__ void ecc_filtfilt_kernel273(const emxArray_real_T x, int32_T
  b_x, emxArray_real_T c_x);
static __global__ void ecc_filtfilt_kernel274(const emxArray_real_T x, int32_T
  b_x, emxArray_real_T c_x);
static __global__ void ecc_filtfilt_kernel275(const emxArray_real_T x, const
  int32_T b_x, int32_T c_x, emxArray_real_T d_x, int32_T x_dim0, int32_T
  b_x_dim0);
static __global__ void ecc_filtfilt_kernel28(int32_T ns, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ecc_filtfilt_kernel29(int32_T thism, emxArray_int32_T
  y_colidx);
static __global__ void ecc_filtfilt_kernel3(int32_T nfilt, emxArray_int32_T y);
static __global__ void ecc_filtfilt_kernel30(int32_T vlen, emxArray_int32_T
  y_colidx);
static __global__ void ecc_filtfilt_kernel31(emxArray_int32_T y_colidx, int32_T
  y_colidx_dim0);
static __global__ void ecc_filtfilt_kernel32(int32_T ns, emxArray_int32_T
  y_colidx);
static __global__ void ecc_filtfilt_kernel33(int32_T thism, emxArray_int32_T
  counts);
static __global__ void ecc_filtfilt_kernel34(int32_T x[2], int32_T rhs_dim0);
static __global__ void ecc_filtfilt_kernel35(const emxArray_real_T rhs, int32_T
  x, emxArray_real_T outBuff);
static __global__ void ecc_filtfilt_kernel36(const emxArray_real_T outBuff,
  int32_T i, emxArray_real_T zi);
static __global__ void ecc_filtfilt_kernel37(int32_T ns, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ecc_filtfilt_kernel38(int32_T thism, emxArray_int32_T
  y_colidx);
static __global__ void ecc_filtfilt_kernel39(int32_T vlen, emxArray_int32_T
  y_colidx);
static __global__ void ecc_filtfilt_kernel4(int32_T nfilt, emxArray_int32_T y);
static __global__ void ecc_filtfilt_kernel40(emxArray_int32_T y_colidx, int32_T
  y_colidx_dim0);
static __global__ void ecc_filtfilt_kernel41(int32_T ns, emxArray_int32_T
  y_colidx);
static __global__ void ecc_filtfilt_kernel42(int32_T thism, emxArray_int32_T
  counts);
static __global__ void ecc_filtfilt_kernel43(const emxArray_real_T rhs, int32_T
  b_rhs, emxArray_real_T zi);
static __global__ void ecc_filtfilt_kernel44(int32_T ns, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ecc_filtfilt_kernel45(int32_T thism, emxArray_int32_T
  y_colidx);
static __global__ void ecc_filtfilt_kernel46(int32_T vlen, emxArray_int32_T
  y_colidx);
static __global__ void ecc_filtfilt_kernel47(emxArray_int32_T y_colidx, int32_T
  y_colidx_dim0);
static __global__ void ecc_filtfilt_kernel48(int32_T ns, emxArray_int32_T
  y_colidx);
static __global__ void ecc_filtfilt_kernel49(int32_T thism, emxArray_int32_T
  counts);
static __global__ void ecc_filtfilt_kernel5(int32_T nfilt, emxArray_int32_T rows);
static __global__ void ecc_filtfilt_kernel50(int32_T x[2], int32_T rhs_dim0);
static __global__ void ecc_filtfilt_kernel51(const emxArray_real_T rhs, int32_T
  x, emxArray_real_T outBuff);
static __global__ void ecc_filtfilt_kernel52(const emxArray_real_T outBuff,
  int32_T i, emxArray_real_T zi);
static __global__ void ecc_filtfilt_kernel53(const emxArray_real_T coef, int32_T
  b_coef, emxArray_real_T sosMat);
static __global__ void ecc_filtfilt_kernel54(const emxArray_real_T coef,
  emxArray_real_T sosMat);
static __global__ void ecc_filtfilt_kernel55(const emxArray_real_T sosMat,
  int32_T b_sosMat, emxArray_real_T b1);
static __global__ void ecc_filtfilt_kernel56(const emxArray_real_T sosMat,
  emxArray_real_T b1);
static __global__ void ecc_filtfilt_kernel57(const emxArray_real_T b1, int32_T
  vlen, emxArray_real_T y);
static __global__ void ecc_filtfilt_kernel58(const int32_T vlen, const
  emxArray_real_T y, const int32_T nfilt, const int32_T ns, emxArray_real_T
  maxCoefNum);
static __global__ void ecc_filtfilt_kernel59(const emxArray_real_T maxCoefNum,
  int32_T b_maxCoefNum, emxArray_boolean_T x);
static __global__ void ecc_filtfilt_kernel6(const emxArray_int32_T y, const
  int32_T nfilt, int32_T loop_ub, emxArray_int32_T rows);
static __global__ void ecc_filtfilt_kernel60(const real_T val, int32_T i,
  emxArray_real_T b1);
static __global__ void ecc_filtfilt_kernel61(const emxArray_real_T b1, int32_T
  b_b1, emxArray_boolean_T x);
static __global__ void ecc_filtfilt_kernel62(const int32_T ii_data_dim0, int32_T
  ns, uint32_T nZeroLastDen_data[1]);
static __global__ void ecc_filtfilt_kernel63(uint32_T nZeroLastDen_data[1]);
static __global__ void ecc_filtfilt_kernel64(const emxArray_real_T sosMat,
  real_T a0[3]);
static __global__ void ecc_filtfilt_kernel65(const emxArray_real_T sosMat, const
  real_T a0[3], emxArray_real_T b2, emxArray_real_T a2);
static __global__ void ecc_filtfilt_kernel66(const emxArray_real_T a2, const
  real_T val, const emxArray_real_T b2, real_T rhs[2]);
static __global__ void ecc_filtfilt_kernel67(int8_T b_I[4]);
static __global__ void ecc_filtfilt_kernel68(int8_T b_I[4]);
static __global__ void ecc_filtfilt_kernel69(const emxArray_real_T a2, const
  int8_T b_I[4], real_T A[4]);
static __global__ void ecc_filtfilt_kernel7(const emxArray_int32_T y, const
  int32_T nfilt, int32_T loop_ub, emxArray_int32_T rows, int32_T y_dim1);
static __global__ void ecc_filtfilt_kernel70(const real_T A[4], const real_T val,
  const int32_T ns, const real_T rhs[2], const int32_T vlen, real_T Y[2]);
static __global__ void ecc_filtfilt_kernel71(const real_T A[4], const real_T
  rhs[2], const int32_T ns, real_T Y[2]);
static __global__ void ecc_filtfilt_kernel72(const real_T Y[2], emxArray_real_T
  zi);
static __global__ void ecc_filtfilt_kernel73(const emxArray_real_T x, int32_T sz,
  emxArray_real_T xc1);
static __global__ void ecc_filtfilt_kernel74(const emxArray_real_T a2, real_T
  *a1, real_T *b_a1, real_T *c_a1, real_T *d_a1, real_T *e_a1);
static __global__ void ecc_filtfilt_kernel75(const emxArray_real_T xc1, int32_T
  b_xc1, emxArray_real_T y, int32_T xc1_dim0);
static __global__ void ecc_filtfilt_kernel76(const emxArray_real_T xc1, const
  emxArray_real_T y, const real_T nfact, const int32_T idx, const int32_T nfilt,
  const int32_T xt, int32_T ns, emxArray_real_T b_xt, int32_T xt_dim0, int32_T
  xc1_dim0);
static __global__ void ecc_filtfilt_kernel77(const emxArray_real_T xt, const
  emxArray_real_T zi, const int32_T b_zi, int32_T loop_ub, emxArray_real_T y,
  int32_T y_dim0, int32_T xt_dim0);
static __global__ void ecc_filtfilt_kernel78(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel79(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel8(int32_T nfilt, emxArray_int32_T y);
static __global__ void ecc_filtfilt_kernel80(const emxArray_real_T xt, const
  emxArray_real_T zi, const int32_T b_zi, int32_T loop_ub, emxArray_real_T c_zi,
  int32_T xt_dim0, int32_T zi_dim0);
static __global__ void ecc_filtfilt_kernel81(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel82(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel83(emxArray_real_T a);
static __global__ void ecc_filtfilt_kernel84(uint32_T zfSize[2], int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel85(uint32_T dv1[2], int32_T b_dim0);
static __global__ void ecc_filtfilt_kernel86(int32_T OH, emxArray_real_T
  expanded);
static __global__ void ecc_filtfilt_kernel87(const int32_T vlen, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv3);
static __global__ void ecc_filtfilt_kernel88(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv4);
static __global__ void ecc_filtfilt_kernel89(const emxArray_real_T xt, const
  emxArray_int32_T iv4, const emxArray_int32_T iv3, const int32_T b_xt, int32_T
  c_xt, emxArray_real_T expanded, int32_T expanded_dim0, int32_T xt_dim0);
static __global__ void ecc_filtfilt_kernel9(int32_T nfilt, emxArray_int32_T y);
static __global__ void ecc_filtfilt_kernel90(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T OH,
  int32_T c, emxArray_real_T convOut, int32_T b_dim0, int32_T expanded_dim0,
  int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel91(const emxArray_real_T zi, const
  emxArray_real_T convOut, const int32_T ns, int32_T b_convOut, emxArray_real_T
  c_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0, int32_T zi_dim0);
static __global__ void ecc_filtfilt_kernel92(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, emxArray_real_T d_convOut, int32_T
  convOut_dim0, int32_T b_convOut_dim0);
static __global__ void ecc_filtfilt_kernel93(const emxArray_real_T y, const
  int32_T zi, int32_T ns, emxArray_real_T convOut, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel94(const emxArray_real_T y, const
  int32_T zi, int32_T ns, emxArray_real_T convOut, int32_T convOut_dim0, int32_T
  y_dim0);
static __global__ void ecc_filtfilt_kernel95(const emxArray_real_T a, int32_T ns,
  emxArray_real_T convOut, int32_T xt_dim0, int32_T a_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel96(const emxArray_real_T convOut,
  const int32_T ns, const int32_T nfilt, int32_T b_convOut, emxArray_real_T
  zfIIR, int32_T zfIIR_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel97(const emxArray_real_T convOut,
  const emxArray_real_T a, const int32_T b_a, int32_T ns, emxArray_real_T zfIIR,
  int32_T a_dim0, int32_T zfIIR_dim0, int32_T xt_dim0, int32_T convOut_dim0);
static __global__ void ecc_filtfilt_kernel98(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ecc_filtfilt_kernel99(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static void ecc_filtfilt_once();
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_, const char_T *
  identifier, char_T y[14]);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[14]);
static void emlrt_marshallOut(const emxArray_real_T *u, const mxArray *y);
static void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int8_T(emxArray_int8_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxFree_boolean_T(emxArray_boolean_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_int8_T(emxArray_int8_T **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxInit_boolean_T(emxArray_boolean_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int8_T(emxArray_int8_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void feval(const mxArray *m, const mxArray *m1, emlrtMCInfo *location);
static const mxArray *feval(const mxArray *m1, const mxArray *m2, const mxArray *
  m3, const mxArray *m4, emlrtMCInfo *location);
static void gpuEmxEnsureCapacity_boolean_T(const emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu);
static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu);
static void gpuEmxEnsureCapacity_int8_T(const emxArray_int8_T *cpu,
  emxArray_int8_T *gpu);
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu);
static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
static void gpuEmxFree_int8_T(emxArray_int8_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
static void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu, const
  emxArray_int32_T *cpu);
static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu, const
  emxArray_real_T *cpu);
static void gpuEmxMemcpyGpuToCpu_boolean_T(emxArray_boolean_T *cpu,
  emxArray_boolean_T *gpu);
static void gpuEmxMemcpyGpuToCpu_int32_T(emxArray_int32_T *cpu, emxArray_int32_T
  *gpu);
static void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T
  *gpu);
static void gpuEmxReset_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);
static void gpuEmxReset_int8_T(emxArray_int8_T *gpu);
static void gpuEmxReset_real_T(emxArray_real_T *gpu);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *coef, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(emlrtAlias(coef), &thisId, y);
  emlrtDestroyArray(&coef);
}

static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  d_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[14])
{
  static const int32_T dims[2]{ 1, 14 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U, (
    const void *)&dims[0]);
  emlrtImportCharArrayR2015b(emlrtRootTLSGlobal, src, &ret[0], 14);
  emlrtDestroyArray(&src);
}

static const mxArray *b_feval(const mxArray *m1, const mxArray *m2, emlrtMCInfo *
  location)
{
  const mxArray *pArrays[2];
  const mxArray *m;
  pArrays[0] = m1;
  pArrays[1] = m2;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 2, &pArrays[0],
    "feval", true, location);
}

static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
  emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m;
  pArrays[0] = m1;
  pArrays[1] = m2;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 2, &pArrays[0],
    "sprintf", true, location);
}

static void binary_expand_op(emxArray_real_T *in1, int32_T in3, const
  emxArray_real_T *in4)
{
  emxArray_real_T *b_in1;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_0_1;
  int32_T stride_1_0;
  int32_T stride_1_1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 2, &db_emlrtRTEI, true);
  i = b_in1->size[0] * b_in1->size[1];
  if (in4->size[0] == 1) {
    b_in1->size[0] = in3 + 1;
  } else {
    b_in1->size[0] = in4->size[0];
  }

  if (in4->size[1] == 1) {
    b_in1->size[1] = in1->size[1];
  } else {
    b_in1->size[1] = in4->size[1];
  }

  emxEnsureCapacity_real_T(b_in1, i, &db_emlrtRTEI);
  stride_0_0 = (in3 + 1 != 1);
  stride_0_1 = (in1->size[1] != 1);
  stride_1_0 = (in4->size[0] != 1);
  stride_1_1 = (in4->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (in4->size[1] == 1) {
    b = in1->size[1];
  } else {
    b = in4->size[1];
  }

  for (i = 0; i < b; i++) {
    int32_T c;
    if (in4->size[0] == 1) {
      c = in3 + 1;
    } else {
      c = in4->size[0];
    }

    for (int32_T i1{0}; i1 < c; i1++) {
      b_in1->data[i1 + b_in1->size[0] * i] = in1->data[i1 * stride_0_0 +
        in1->size[0] * aux_0_1] + in4->data[i1 * stride_1_0 + in4->size[0] *
        aux_1_1];
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }

  for (i = 0; i < b_in1->size[1]; i++) {
    for (int32_T i1{0}; i1 < b_in1->size[0]; i1++) {
      in1->data[i1 + in1->size[0] * i] = b_in1->data[i1 + b_in1->size[0] * i];
    }
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2)
{
  emxArray_real_T *b_in1;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T in2_idx_1;
  int32_T stride_0_1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  in2_idx_1 = in2->size[1];
  i = in2->size[0];
  i1 = in2->size[1];
  emxInit_real_T(&b_in1, 2, &db_emlrtRTEI, true);
  i2 = b_in1->size[0] * b_in1->size[1];
  b_in1->size[0] = in2->size[0];
  if (in2_idx_1 == 1) {
    b_in1->size[1] = in1->size[1];
  } else {
    b_in1->size[1] = in2_idx_1;
  }

  emxEnsureCapacity_real_T(b_in1, i2, &db_emlrtRTEI);
  stride_0_1 = (in1->size[1] != 1);
  in2_idx_1 = (in2_idx_1 != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (i1 == 1) {
    i1 = in1->size[1];
  }

  for (i2 = 0; i2 < i1; i2++) {
    for (int32_T i3{0}; i3 < i; i3++) {
      b_in1->data[i3 + b_in1->size[0] * i2] = in1->data[i3 + in1->size[0] *
        aux_0_1] + in2->data[i3 + in2->size[0] * aux_1_1];
    }

    aux_1_1 += in2_idx_1;
    aux_0_1 += stride_0_1;
  }

  for (i = 0; i < b_in1->size[1]; i++) {
    for (i1 = 0; i1 < b_in1->size[0]; i1++) {
      in1->data[i1 + in1->size[0] * i] = b_in1->data[i1 + b_in1->size[0] * i];
    }
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2]{ -1, 65535 };

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

//
//
namespace coder
{
  namespace internal
  {
    static void b_heapsort(emxArray_int32_T *x, int32_T xstart, int32_T xend,
      const emxArray_int32_T *cmp_workspace_a, const emxArray_int32_T
      *cmp_workspace_b)
    {
      int32_T cmpIdx;
      int32_T extremum;
      int32_T extremumIdx;
      int32_T leftIdx;
      int32_T n;
      int32_T xcmp;
      boolean_T changed;
      boolean_T exitg1;
      boolean_T varargout_1;
      n = (xend - xstart) - 1;
      for (int32_T idx{0}; idx <= n + 1; idx++) {
        changed = true;
        extremumIdx = (n - idx) + xstart;
        leftIdx = ((((n - idx) + 2) << 1) + xstart) - 2;
        exitg1 = false;
        while ((!exitg1) && (leftIdx + 1 < xend)) {
          changed = false;
          extremum = x->data[extremumIdx];
          cmpIdx = leftIdx;
          xcmp = x->data[leftIdx];
          if (cmp_workspace_a->data[x->data[leftIdx] - 1] <
              cmp_workspace_a->data[x->data[leftIdx + 1] - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[leftIdx] - 1] ==
                     cmp_workspace_a->data[x->data[leftIdx + 1] - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[leftIdx] - 1] <
                           cmp_workspace_b->data[x->data[leftIdx + 1] - 1]);
          } else {
            varargout_1 = false;
          }

          if (varargout_1) {
            cmpIdx = leftIdx + 1;
            xcmp = x->data[leftIdx + 1];
          }

          if (cmp_workspace_a->data[x->data[extremumIdx] - 1] <
              cmp_workspace_a->data[xcmp - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[extremumIdx] - 1] ==
                     cmp_workspace_a->data[xcmp - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[extremumIdx] - 1] <
                           cmp_workspace_b->data[xcmp - 1]);
          } else {
            varargout_1 = false;
          }

          if (varargout_1) {
            x->data[extremumIdx] = xcmp;
            x->data[cmpIdx] = extremum;
            extremumIdx = cmpIdx;
            leftIdx = ((((cmpIdx - xstart) + 2) << 1) + xstart) - 2;
            changed = true;
          } else {
            exitg1 = true;
          }
        }

        if (changed && (leftIdx + 1 <= xend)) {
          extremum = x->data[extremumIdx];
          if (cmp_workspace_a->data[x->data[extremumIdx] - 1] <
              cmp_workspace_a->data[x->data[leftIdx] - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[extremumIdx] - 1] ==
                     cmp_workspace_a->data[x->data[leftIdx] - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[extremumIdx] - 1] <
                           cmp_workspace_b->data[x->data[leftIdx] - 1]);
          } else {
            varargout_1 = false;
          }

          if (varargout_1) {
            x->data[extremumIdx] = x->data[leftIdx];
            x->data[leftIdx] = extremum;
          }
        }
      }

      for (int32_T idx{0}; idx <= n; idx++) {
        extremumIdx = x->data[(xend - idx) - 1];
        x->data[(xend - idx) - 1] = x->data[xstart - 1];
        x->data[xstart - 1] = extremumIdx;
        changed = true;
        extremumIdx = xstart - 1;
        leftIdx = xstart;
        exitg1 = false;
        while ((!exitg1) && (leftIdx + 1 < (xend - idx) - 1)) {
          changed = false;
          extremum = x->data[extremumIdx];
          cmpIdx = leftIdx;
          xcmp = x->data[leftIdx];
          if (cmp_workspace_a->data[x->data[leftIdx] - 1] <
              cmp_workspace_a->data[x->data[leftIdx + 1] - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[leftIdx] - 1] ==
                     cmp_workspace_a->data[x->data[leftIdx + 1] - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[leftIdx] - 1] <
                           cmp_workspace_b->data[x->data[leftIdx + 1] - 1]);
          } else {
            varargout_1 = false;
          }

          if (varargout_1) {
            cmpIdx = leftIdx + 1;
            xcmp = x->data[leftIdx + 1];
          }

          if (cmp_workspace_a->data[x->data[extremumIdx] - 1] <
              cmp_workspace_a->data[xcmp - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[extremumIdx] - 1] ==
                     cmp_workspace_a->data[xcmp - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[extremumIdx] - 1] <
                           cmp_workspace_b->data[xcmp - 1]);
          } else {
            varargout_1 = false;
          }

          if (varargout_1) {
            x->data[extremumIdx] = xcmp;
            x->data[cmpIdx] = extremum;
            extremumIdx = cmpIdx;
            leftIdx = ((((cmpIdx - xstart) + 2) << 1) + xstart) - 2;
            changed = true;
          } else {
            exitg1 = true;
          }
        }

        if (changed && (leftIdx + 1 <= (xend - idx) - 1)) {
          extremum = x->data[extremumIdx];
          if (cmp_workspace_a->data[x->data[extremumIdx] - 1] <
              cmp_workspace_a->data[x->data[leftIdx] - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[x->data[extremumIdx] - 1] ==
                     cmp_workspace_a->data[x->data[leftIdx] - 1]) {
            varargout_1 = (cmp_workspace_b->data[x->data[extremumIdx] - 1] <
                           cmp_workspace_b->data[x->data[leftIdx] - 1]);
          } else {
            varargout_1 = false;
          }

          if (varargout_1) {
            x->data[extremumIdx] = x->data[leftIdx];
            x->data[leftIdx] = extremum;
          }
        }
      }
    }

    //
    //
    static void b_warning()
    {
      static const int32_T iv[2]{ 1, 7 };

      static const int32_T iv1[2]{ 1, 7 };

      static const int32_T iv2[2]{ 1, 22 };

      static const int32_T iv3[2]{ 1, 3 };

      static const int32_T iv4[2]{ 1, 3 };

      static const char_T msgID[22]{ 's', 'i', 'g', 'n', 'a', 'l', ':', 'f', 'i',
        'l', 't', 'f', 'i', 'l', 't', ':', 'P', 'a', 'r', 's', 'e', 'B' };

      static const char_T b_u[7]{ 'm', 'e', 's', 's', 'a', 'g', 'e' };

      static const char_T u[7]{ 'w', 'a', 'r', 'n', 'i', 'n', 'g' };

      static const char_T varargin_1[3]{ 'a', '0', '1' };

      static const char_T varargin_2[3]{ 'S', 'O', 'S' };

      const mxArray *b_y;
      const mxArray *c_y;
      const mxArray *d_y;
      const mxArray *e_y;
      const mxArray *m;
      const mxArray *m1;
      const mxArray *m2;
      const mxArray *m3;
      const mxArray *m4;
      const mxArray *y;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m1 = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m1, &b_u[0]);
      emlrtAssign(&b_y, m1);
      c_y = nullptr;
      m2 = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 22, m2, &msgID[0]);
      emlrtAssign(&c_y, m2);
      d_y = nullptr;
      m3 = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 3, m3, &varargin_1[0]);
      emlrtAssign(&d_y, m3);
      e_y = nullptr;
      m4 = emlrtCreateCharArray(2, &iv4[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 3, m4, &varargin_2[0]);
      emlrtAssign(&e_y, m4);
      feval(y, feval(b_y, c_y, d_y, e_y, &emlrtMCI), &b_emlrtMCI);
    }

    //
    //
    static void c_warning()
    {
      static const int32_T iv[2]{ 1, 7 };

      static const int32_T iv1[2]{ 1, 7 };

      static const int32_T iv2[2]{ 1, 21 };

      static const char_T msgID[21]{ 'M', 'A', 'T', 'L', 'A', 'B', ':', 's', 'i',
        'n', 'g', 'u', 'l', 'a', 'r', 'M', 'a', 't', 'r', 'i', 'x' };

      static const char_T b_u[7]{ 'm', 'e', 's', 's', 'a', 'g', 'e' };

      static const char_T u[7]{ 'w', 'a', 'r', 'n', 'i', 'n', 'g' };

      const mxArray *b_y;
      const mxArray *c_y;
      const mxArray *m;
      const mxArray *m1;
      const mxArray *m2;
      const mxArray *y;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m1 = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m1, &b_u[0]);
      emlrtAssign(&b_y, m1);
      c_y = nullptr;
      m2 = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 21, m2, &msgID[0]);
      emlrtAssign(&c_y, m2);
      feval(y, b_feval(b_y, c_y, &emlrtMCI), &b_emlrtMCI);
    }

    //
    //
    static void insertionsort(emxArray_int32_T *x, int32_T xstart, int32_T xend,
      const emxArray_int32_T *cmp_workspace_a, const emxArray_int32_T
      *cmp_workspace_b)
    {
      int64_T b;
      b = computeEndIdx(static_cast<int64_T>(xstart + 1), static_cast<int64_T>
                        (xend), 1L);
      for (int64_T k{0L}; k <= b; k++) {
        int32_T idx;
        int32_T xc;
        boolean_T exitg1;
        xc = x->data[static_cast<int32_T>((xstart + 1) + k) - 1] - 1;
        idx = static_cast<int32_T>((xstart + 1) + k) - 2;
        exitg1 = false;
        while ((!exitg1) && (idx + 1 >= xstart)) {
          boolean_T varargout_1;
          if (cmp_workspace_a->data[xc] < cmp_workspace_a->data[x->data[idx] - 1])
          {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[xc] == cmp_workspace_a->data[x->
                     data[idx] - 1]) {
            varargout_1 = (cmp_workspace_b->data[xc] < cmp_workspace_b->data
                           [x->data[idx] - 1]);
          } else {
            varargout_1 = false;
          }

          if (varargout_1) {
            x->data[idx + 1] = x->data[idx];
            idx--;
          } else {
            exitg1 = true;
          }
        }

        x->data[idx + 1] = xc + 1;
      }
    }

    //
    //
    static void introsort(emxArray_int32_T *x, int32_T xend, const
                          emxArray_int32_T *cmp_workspace_a, const
                          emxArray_int32_T *cmp_workspace_b)
    {
      struct_T st_d_data[120];
      struct_T frame;
      if (xend > 1) {
        if (xend <= 32) {
          insertionsort(x, 1, xend, cmp_workspace_a, cmp_workspace_b);
        } else {
          int32_T MAXDEPTH;
          int32_T pivot;
          int32_T pmax;
          int32_T pmin;
          int32_T pow2p;
          boolean_T exitg1;
          pmax = 31;
          pmin = 0;
          exitg1 = false;
          while ((!exitg1) && (pmax - pmin > 1)) {
            pivot = (pmin + pmax) >> 1;
            pow2p = 1 << pivot;
            if (pow2p == xend) {
              pmax = pivot;
              exitg1 = true;
            } else if (pow2p > xend) {
              pmax = pivot;
            } else {
              pmin = pivot;
            }
          }

          MAXDEPTH = (pmax - 1) << 1;
          frame.xstart = 1;
          frame.xend = xend;
          frame.depth = 0;
          pmin = MAXDEPTH << 1;
          for (pmax = 0; pmax < pmin; pmax++) {
            st_d_data[pmax] = frame;
          }

          st_d_data[0] = frame;
          pow2p = 1;
          while (pow2p > 0) {
            frame = st_d_data[pow2p - 1];
            pmax = st_d_data[pow2p - 1].xstart - 1;
            xend = st_d_data[pow2p - 1].xend;
            pow2p--;
            if ((frame.xend - frame.xstart) + 1 <= 32) {
              insertionsort(x, frame.xstart, frame.xend, cmp_workspace_a,
                            cmp_workspace_b);
            } else if (frame.depth == MAXDEPTH) {
              b_heapsort(x, frame.xstart, frame.xend, cmp_workspace_a,
                         cmp_workspace_b);
            } else {
              int32_T t;
              boolean_T varargout_1;
              pmin = (frame.xstart + (frame.xend - frame.xstart) / 2) - 1;
              if (cmp_workspace_a->data[x->data[pmin] - 1] <
                  cmp_workspace_a->data[x->data[frame.xstart - 1] - 1]) {
                varargout_1 = true;
              } else if (cmp_workspace_a->data[x->data[pmin] - 1] ==
                         cmp_workspace_a->data[x->data[frame.xstart - 1] - 1]) {
                varargout_1 = (cmp_workspace_b->data[x->data[pmin] - 1] <
                               cmp_workspace_b->data[x->data[pmax] - 1]);
              } else {
                varargout_1 = false;
              }

              if (varargout_1) {
                t = x->data[frame.xstart - 1];
                x->data[frame.xstart - 1] = x->data[pmin];
                x->data[pmin] = t;
              }

              if (cmp_workspace_a->data[x->data[frame.xend - 1] - 1] <
                  cmp_workspace_a->data[x->data[frame.xstart - 1] - 1]) {
                varargout_1 = true;
              } else if (cmp_workspace_a->data[x->data[frame.xend - 1] - 1] ==
                         cmp_workspace_a->data[x->data[frame.xstart - 1] - 1]) {
                varargout_1 = (cmp_workspace_b->data[x->data[xend - 1] - 1] <
                               cmp_workspace_b->data[x->data[pmax] - 1]);
              } else {
                varargout_1 = false;
              }

              if (varargout_1) {
                t = x->data[frame.xstart - 1];
                x->data[frame.xstart - 1] = x->data[frame.xend - 1];
                x->data[frame.xend - 1] = t;
              }

              if (cmp_workspace_a->data[x->data[frame.xend - 1] - 1] <
                  cmp_workspace_a->data[x->data[pmin] - 1]) {
                varargout_1 = true;
              } else if (cmp_workspace_a->data[x->data[frame.xend - 1] - 1] ==
                         cmp_workspace_a->data[x->data[pmin] - 1]) {
                varargout_1 = (cmp_workspace_b->data[x->data[xend - 1] - 1] <
                               cmp_workspace_b->data[x->data[pmin] - 1]);
              } else {
                varargout_1 = false;
              }

              if (varargout_1) {
                t = x->data[pmin];
                x->data[pmin] = x->data[frame.xend - 1];
                x->data[frame.xend - 1] = t;
              }

              pivot = x->data[pmin] - 1;
              x->data[pmin] = x->data[frame.xend - 2];
              x->data[frame.xend - 2] = pivot + 1;
              pmax = frame.xstart - 1;
              pmin = frame.xend - 2;
              int32_T exitg2;
              do {
                int32_T exitg3;
                exitg2 = 0;
                pmax++;
                do {
                  exitg3 = 0;
                  if (cmp_workspace_a->data[x->data[pmax] - 1] <
                      cmp_workspace_a->data[pivot]) {
                    varargout_1 = true;
                  } else if (cmp_workspace_a->data[x->data[pmax] - 1] ==
                             cmp_workspace_a->data[pivot]) {
                    varargout_1 = (cmp_workspace_b->data[x->data[pmax] - 1] <
                                   cmp_workspace_b->data[pivot]);
                  } else {
                    varargout_1 = false;
                  }

                  if (varargout_1) {
                    pmax++;
                  } else {
                    exitg3 = 1;
                  }
                } while (exitg3 == 0);

                pmin--;
                do {
                  exitg3 = 0;
                  if (cmp_workspace_a->data[pivot] < cmp_workspace_a->data
                      [x->data[pmin] - 1]) {
                    varargout_1 = true;
                  } else if (cmp_workspace_a->data[pivot] ==
                             cmp_workspace_a->data[x->data[pmin] - 1]) {
                    varargout_1 = (cmp_workspace_b->data[pivot] <
                                   cmp_workspace_b->data[x->data[pmin] - 1]);
                  } else {
                    varargout_1 = false;
                  }

                  if (varargout_1) {
                    pmin--;
                  } else {
                    exitg3 = 1;
                  }
                } while (exitg3 == 0);

                if (pmax + 1 >= pmin + 1) {
                  exitg2 = 1;
                } else {
                  t = x->data[pmax];
                  x->data[pmax] = x->data[pmin];
                  x->data[pmin] = t;
                }
              } while (exitg2 == 0);

              x->data[frame.xend - 2] = x->data[pmax];
              x->data[pmax] = pivot + 1;
              if (pmax + 2 < frame.xend) {
                st_d_data[pow2p].xstart = pmax + 2;
                st_d_data[pow2p].xend = frame.xend;
                st_d_data[pow2p].depth = frame.depth + 1;
                pow2p++;
              }

              if (frame.xstart < pmax + 1) {
                st_d_data[pow2p].xstart = frame.xstart;
                st_d_data[pow2p].xend = pmax + 1;
                st_d_data[pow2p].depth = frame.depth + 1;
                pow2p++;
              }
            }
          }
        }
      }
    }

    //
    //
    static void warning(int32_T varargin_1, const char_T varargin_2[14])
    {
      static const int32_T iv[2]{ 1, 7 };

      static const int32_T iv1[2]{ 1, 7 };

      static const int32_T iv2[2]{ 1, 32 };

      static const int32_T iv3[2]{ 1, 14 };

      static const char_T msgID[32]{ 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
        'L', 'A', 'B', ':', 'r', 'a', 'n', 'k', 'D', 'e', 'f', 'i', 'c', 'i',
        'e', 'n', 't', 'M', 'a', 't', 'r', 'i', 'x' };

      static const char_T b_u[7]{ 'm', 'e', 's', 's', 'a', 'g', 'e' };

      static const char_T u[7]{ 'w', 'a', 'r', 'n', 'i', 'n', 'g' };

      const mxArray *b_y;
      const mxArray *c_y;
      const mxArray *d_y;
      const mxArray *e_y;
      const mxArray *m;
      const mxArray *m1;
      const mxArray *m2;
      const mxArray *m3;
      const mxArray *m4;
      const mxArray *y;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m1 = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m1, &b_u[0]);
      emlrtAssign(&b_y, m1);
      c_y = nullptr;
      m2 = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 32, m2, &msgID[0]);
      emlrtAssign(&c_y, m2);
      d_y = nullptr;
      m3 = emlrtCreateNumericMatrix(1, 1, mxINT32_CLASS, mxREAL);
      *static_cast<int32_T *>(emlrtMxGetData(m3)) = varargin_1;
      emlrtAssign(&d_y, m3);
      e_y = nullptr;
      m4 = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 14, m4, &varargin_2[0]);
      emlrtAssign(&e_y, m4);
      feval(y, feval(b_y, c_y, d_y, e_y, &emlrtMCI), &b_emlrtMCI);
    }

    //
    //
    static void warning()
    {
      static const int32_T iv[2]{ 1, 7 };

      static const int32_T iv1[2]{ 1, 7 };

      static const int32_T iv2[2]{ 1, 24 };

      static const int32_T iv3[2]{ 1, 3 };

      static const char_T msgID[24]{ 's', 'i', 'g', 'n', 'a', 'l', ':', 'f', 'i',
        'l', 't', 'f', 'i', 'l', 't', ':', 'P', 'a', 'r', 's', 'e', 'S', 'O',
        'S' };

      static const char_T b_u[7]{ 'm', 'e', 's', 's', 'a', 'g', 'e' };

      static const char_T u[7]{ 'w', 'a', 'r', 'n', 'i', 'n', 'g' };

      static const char_T varargin_1[3]{ 'S', 'O', 'S' };

      const mxArray *b_y;
      const mxArray *c_y;
      const mxArray *d_y;
      const mxArray *e_y;
      const mxArray *m;
      const mxArray *m1;
      const mxArray *m2;
      const mxArray *m3;
      const mxArray *m4;
      const mxArray *y;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m1 = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m1, &b_u[0]);
      emlrtAssign(&b_y, m1);
      c_y = nullptr;
      m2 = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 24, m2, &msgID[0]);
      emlrtAssign(&c_y, m2);
      d_y = nullptr;
      m3 = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 3, m3, &varargin_1[0]);
      emlrtAssign(&d_y, m3);
      e_y = nullptr;
      m4 = emlrtCreateString1R2022a(emlrtRootTLSGlobal, 'G');
      emlrtAssign(&e_y, m4);
      feval(y, feval(b_y, c_y, d_y, e_y, &emlrtMCI), &b_emlrtMCI);
    }
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

static void d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2]{ 1, -1 };

  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{ false, true };

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

static __device__ int32_T div_s32_device(int32_T numerator, int32_T denominator)
{
  int32_T quotient;
  if (denominator == 0) {
    if (numerator >= 0) {
      quotient = MAX_int32_T;
    } else {
      quotient = MIN_int32_T;
    }
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
    if (static_cast<int32_T>(numerator < 0) != static_cast<int32_T>(denominator <
         0)) {
      quotient = -static_cast<int32_T>(tempAbsQuotient);
    } else {
      quotient = static_cast<int32_T>(tempAbsQuotient);
    }
  }

  return quotient;
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel1(const
  emxArray_real_T coef, int32_T b_coef, emxArray_real_T b2, emxArray_real_T a2)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_coef);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a2.data[k] = 0.0;
    b2.data[k] = coef.data[k];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel10(const
  int32_T nfilt, int32_T x[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    x[1] = nfilt + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel100(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel101(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel102
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel103(uint32_T
  zfSize[2], int32_T b_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    zfSize[0] = static_cast<uint32_T>(b_dim0 - 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel104(uint32_T
  dv1[2], int32_T b_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    dv1[0] = static_cast<uint32_T>(b_dim0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel105(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel106(const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    iv5.data[iv0] = k - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel107(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv6)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    iv6.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel108(const
  emxArray_real_T xc1, const emxArray_int32_T iv6, const emxArray_int32_T iv5,
  const int32_T b_xc1, int32_T c_xc1, emxArray_real_T expanded, int32_T
  expanded_dim0, int32_T xc1_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xc1) + 1UL) * (static_cast<uint64_T>(c_xc1)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xc1) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_xc1) + 1UL));
    expanded.data[iv5.data[ix] + expanded_dim0 * iv6.data[iv0]] = xc1.data[ix +
      xc1_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel109(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T OH, int32_T c, emxArray_real_T convOut, int32_T b_dim0, int32_T
  expanded_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) * static_cast<uint64_T>(c) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T orow;
    orow = static_cast<int32_T>(idx % static_cast<uint64_T>(OH));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
      static_cast<uint64_T>(OH));
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if (k > 2147483646 - orow) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[(k + expanded_dim0 * iv0) - 1] * b.data[(b_dim0 - m) -
        1];
    }

    convOut.data[orow + convOut_dim0 * iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel11(int32_T
  loop_ub, emxArray_int32_T cols)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(loop_ub) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    cols.data[iv0] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel110(const
  emxArray_real_T zfIIR, const emxArray_real_T convOut, const int32_T i, int32_T
  b_convOut, emxArray_real_T c_convOut, int32_T convOut_dim0, int32_T
  b_convOut_dim0, int32_T zfIIR_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i) * (static_cast<uint64_T>(b_convOut) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % static_cast<uint64_T>(i));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      static_cast<uint64_T>(i));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zfIIR.data[ix + zfIIR_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel111(const
  emxArray_real_T convOut, const int32_T b_convOut, int32_T c_convOut,
  emxArray_real_T d_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_convOut) + 1UL) * (static_cast<uint64_T>
    (c_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_convOut) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_convOut) + 1UL));
    d_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel112(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim0,
  int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T x[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    x[0] = zfIIR_dim0;
    for (int32_T k{0}; k < x[0]; k++) {
      convOut.data[k + convOut_dim0 * m] += zfIIR.data[k];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel113(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim1,
  int32_T convOut_dim0, int32_T zfIIR_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T x[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    x[1] = zfIIR_dim1;
    for (int32_T k{0}; k < x[1]; k++) {
      convOut.data[k + convOut_dim0 * m] += zfIIR.data[zfIIR_dim0 * k];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel114(const
  emxArray_real_T a, int32_T ns, emxArray_real_T convOut, int32_T xc1_dim0,
  int32_T a_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T ix;
    int32_T m;
    m = static_cast<int32_T>(idx);
    ix = (xc1_dim0 + a_dim0) - 1;
    for (int32_T k{0}; k < ix; k++) {
      int32_T bcoef;
      bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 1.0,
        static_cast<real_T>(a_dim0))) - 1;
      for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
        convOut.data[k + convOut_dim0 * m] -= convOut.data[((k - iv0) +
          convOut_dim0 * m) - 1] * a.data[iv0 + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel115(const
  emxArray_real_T convOut, const int32_T ns, const int32_T nfilt, int32_T
  b_convOut, emxArray_real_T zfIIR, int32_T zfIIR_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt - ns) * (static_cast<uint64_T>(b_convOut)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % static_cast<uint64_T>(nfilt - ns));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      static_cast<uint64_T>(nfilt - ns));
    zfIIR.data[ix + zfIIR_dim0 * iv0] = convOut.data[(ns + ix) + convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel116(const
  emxArray_real_T convOut, const emxArray_real_T a, const int32_T b_a, int32_T
  ns, emxArray_real_T zfIIR, int32_T a_dim0, int32_T zfIIR_dim0, int32_T
  xc1_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_a) + 1UL) * static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T k;
    int32_T m;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_a) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_a) + 1UL));
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 2.0, static_cast<
      real_T>(a_dim0))) - 1;
    for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
      zfIIR.data[(k + zfIIR_dim0 * m) + 1] += convOut.data[((xc1_dim0 + k) - iv0)
        + convOut_dim0 * m] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel117(const
  emxArray_real_T convOut, const int32_T xc1, int32_T b_convOut, emxArray_real_T
  c_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(xc1) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(xc1) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(xc1) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel118(int32_T
  x[2], int32_T xc1_dim0, int32_T xc1_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    x[0] = xc1_dim0;
    x[1] = xc1_dim1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel119(const
  emxArray_real_T convOut, int32_T x, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel12(const
  emxArray_int32_T y, const int32_T x[2], int32_T loop_ub, emxArray_int32_T cols)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(loop_ub) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    cols.data[iv0 + x[1]] = y.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel120(const
  emxArray_real_T xc1, const int32_T ns, int32_T b_xc1, emxArray_real_T y,
  int32_T xc1_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xc1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = 2.0 * xc1.data[(ns + xc1_dim0 * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel121(const
  emxArray_real_T xc1, const emxArray_real_T y, const int32_T x, const int32_T
  vlen, const int32_T thism, const int32_T idx, const int32_T nfilt, const
  int32_T xt, int32_T ns, emxArray_real_T b_xt, int32_T xt_dim0, int32_T
  xc1_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(xt) + 1UL) * (static_cast<uint64_T>(ns) + 1UL)
    - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T k;
    int32_T orow;
    orow = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(xt) + 1UL));
    k = static_cast<int32_T>((b_idx - static_cast<uint64_T>(orow)) / (
      static_cast<uint64_T>(xt) + 1UL));
    b_xt.data[orow + xt_dim0 * k] = y.data[nfilt * k] - xc1.data[((vlen + x * (
      static_cast<int32_T>(div_s32_device(thism - vlen, x) + 1 != 1) * orow)) +
      xc1_dim0 * (idx * k)) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel122(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel123(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel124(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel125(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel126
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel127(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel128(const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv10)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    iv10.data[iv0] = k - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel129(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv11)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    iv11.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel13(const
  emxArray_int32_T y, const int32_T x[2], int32_T loop_ub, emxArray_int32_T cols,
  int32_T y_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(loop_ub) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    cols.data[(iv0 + x[1]) + y_dim1] = y.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel130(const
  emxArray_real_T xt, const emxArray_int32_T iv11, const emxArray_int32_T iv10,
  const int32_T b_xt, int32_T c_xt, emxArray_real_T expanded, int32_T
  expanded_dim0, int32_T xt_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xt) + 1UL) * (static_cast<uint64_T>(c_xt) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xt) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_xt) + 1UL));
    expanded.data[iv10.data[ix] + expanded_dim0 * iv11.data[iv0]] = xt.data[ix +
      xt_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel131(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T OH, int32_T c, emxArray_real_T convOut, int32_T b_dim0, int32_T
  expanded_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) * static_cast<uint64_T>(c) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T orow;
    orow = static_cast<int32_T>(idx % static_cast<uint64_T>(OH));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
      static_cast<uint64_T>(OH));
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if (k > 2147483646 - orow) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[(k + expanded_dim0 * iv0) - 1] * b.data[(b_dim0 - m) -
        1];
    }

    convOut.data[orow + convOut_dim0 * iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel132(const
  emxArray_real_T zfIIR, const emxArray_real_T convOut, const int32_T i, int32_T
  b_convOut, emxArray_real_T c_convOut, int32_T convOut_dim0, int32_T
  b_convOut_dim0, int32_T zfIIR_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i) * (static_cast<uint64_T>(b_convOut) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % static_cast<uint64_T>(i));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      static_cast<uint64_T>(i));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zfIIR.data[ix + zfIIR_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel133(const
  emxArray_real_T convOut, const int32_T b_convOut, int32_T c_convOut,
  emxArray_real_T d_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_convOut) + 1UL) * (static_cast<uint64_T>
    (c_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_convOut) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_convOut) + 1UL));
    d_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel134(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim0,
  int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T x[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    x[0] = zfIIR_dim0;
    for (int32_T k{0}; k < x[0]; k++) {
      convOut.data[k + convOut_dim0 * m] += zfIIR.data[k];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel135(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim1,
  int32_T convOut_dim0, int32_T zfIIR_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T x[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    x[1] = zfIIR_dim1;
    for (int32_T k{0}; k < x[1]; k++) {
      convOut.data[k + convOut_dim0 * m] += zfIIR.data[zfIIR_dim0 * k];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel136(const
  emxArray_real_T a, int32_T ns, emxArray_real_T convOut, int32_T xt_dim0,
  int32_T a_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T ix;
    int32_T m;
    m = static_cast<int32_T>(idx);
    ix = (xt_dim0 + a_dim0) - 1;
    for (int32_T k{0}; k < ix; k++) {
      int32_T bcoef;
      bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 1.0,
        static_cast<real_T>(a_dim0))) - 1;
      for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
        convOut.data[k + convOut_dim0 * m] -= convOut.data[((k - iv0) +
          convOut_dim0 * m) - 1] * a.data[iv0 + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel137(const
  emxArray_real_T convOut, const int32_T xt, int32_T b_convOut, emxArray_real_T
  c_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(xt) + 1UL) * (static_cast<uint64_T>(b_convOut)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(xt) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(xt) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel138(int32_T
  x[2], int32_T xt_dim0, int32_T xt_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    x[0] = xt_dim0;
    x[1] = xt_dim1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel139(const
  emxArray_real_T convOut, int32_T x, emxArray_real_T yc3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    yc3.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel14(const
  int32_T nfilt, int32_T x[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    x[1] = nfilt;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel140(const
  emxArray_real_T yc3, const int32_T ns, const emxArray_real_T zi, const int32_T
  b_zi, int32_T loop_ub, emxArray_real_T y, int32_T y_dim0, int32_T yc3_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zi) + 1UL) * static_cast<uint64_T>(loop_ub)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_zi) + 1UL));
    y.data[ix + y_dim0 * iv0] = zi.data[ix] * yc3.data[(ns + yc3_dim0 * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel141(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel142(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel143(const
  emxArray_real_T yc3, const int32_T ns, const emxArray_real_T zi, const int32_T
  b_zi, int32_T loop_ub, emxArray_real_T c_zi, int32_T yc3_dim0, int32_T zi_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zi) + 1UL) * static_cast<uint64_T>(loop_ub)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_zi) + 1UL));
    cv = zi.data[ix] * yc3.data[(ns + yc3_dim0 * iv0) - 1];
    c_zi.data[ix + zi_dim0 * iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel144(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel145(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel146
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel147(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel148(const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv13)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    iv13.data[iv0] = k - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel149(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv14)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    iv14.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel15
  (emxArray_int8_T vals)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vals.data[0] = static_cast<int8_T>(1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel150(const
  emxArray_real_T yc3, const int32_T i52, const int32_T i51, const
  emxArray_int32_T iv14, const emxArray_int32_T iv13, const int32_T i, int32_T
  b_yc3, emxArray_real_T expanded, int32_T expanded_dim0, int32_T yc3_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(i) + 1UL) * (static_cast<uint64_T>(b_yc3) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(i) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(i) + 1UL));
    expanded.data[iv13.data[ix] + expanded_dim0 * iv14.data[iv0]] = yc3.data
      [((i51 + i52 * ix) + yc3_dim0 * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel151(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T OH, int32_T c, emxArray_real_T convOut, int32_T b_dim0, int32_T
  expanded_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) * static_cast<uint64_T>(c) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T orow;
    orow = static_cast<int32_T>(idx % static_cast<uint64_T>(OH));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
      static_cast<uint64_T>(OH));
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if ((orow + 1 < 0) && (k < MAX_int32_T - orow)) {
        k = MIN_int32_T;
      } else if ((orow + 1 > 0) && (k > 2147483646 - orow)) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[(k + expanded_dim0 * iv0) - 1] * b.data[(b_dim0 - m) -
        1];
    }

    convOut.data[orow + convOut_dim0 * iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel152(const
  emxArray_real_T zi, const emxArray_real_T convOut, const int32_T ns, int32_T
  b_convOut, emxArray_real_T c_convOut, int32_T convOut_dim0, int32_T
  b_convOut_dim0, int32_T zi_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) * (static_cast<uint64_T>(b_convOut) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % static_cast<uint64_T>(ns));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      static_cast<uint64_T>(ns));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zi.data[ix + zi_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel153(const
  emxArray_real_T convOut, const int32_T b_convOut, int32_T c_convOut,
  emxArray_real_T d_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_convOut) + 1UL) * (static_cast<uint64_T>
    (c_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_convOut) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_convOut) + 1UL));
    d_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel154(const
  emxArray_real_T y, const int32_T zi, int32_T ns, emxArray_real_T convOut,
  int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi) + 1UL) * static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    int32_T m;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(zi) + 1UL));
    convOut.data[k + convOut_dim0 * m] += y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel155(const
  emxArray_real_T y, const int32_T zi, int32_T ns, emxArray_real_T convOut,
  int32_T convOut_dim0, int32_T y_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi) + 1UL) * static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    int32_T m;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(zi) + 1UL));
    convOut.data[k + convOut_dim0 * m] += y.data[y_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel156(const
  emxArray_real_T a, const int32_T i52, const int32_T i51, const int32_T i53,
  int32_T ns, emxArray_real_T convOut, int32_T a_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T ix;
    int32_T m;
    m = static_cast<int32_T>(idx);
    ix = div_s32_device(i53 - i51, i52) + a_dim0;
    for (int32_T k{0}; k < ix; k++) {
      int32_T bcoef;
      bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 1.0,
        static_cast<real_T>(a_dim0))) - 1;
      for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
        convOut.data[k + convOut_dim0 * m] -= convOut.data[((k - iv0) +
          convOut_dim0 * m) - 1] * a.data[iv0 + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel157(const
  emxArray_real_T convOut, const int32_T ns, const int32_T nfilt, int32_T
  b_convOut, emxArray_real_T zfIIR, int32_T zfIIR_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt - ns) * (static_cast<uint64_T>(b_convOut)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % static_cast<uint64_T>(nfilt - ns));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      static_cast<uint64_T>(nfilt - ns));
    zfIIR.data[ix + zfIIR_dim0 * iv0] = convOut.data[(ns + ix) + convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel158(const
  emxArray_real_T convOut, const int32_T i52, const int32_T i51, const int32_T
  i53, const emxArray_real_T a, const int32_T b_a, int32_T ns, emxArray_real_T
  zfIIR, int32_T a_dim0, int32_T zfIIR_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_a) + 1UL) * static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T k;
    int32_T m;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_a) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_a) + 1UL));
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 2.0, static_cast<
      real_T>(a_dim0))) - 1;
    for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
      zfIIR.data[(k + zfIIR_dim0 * m) + 1] += convOut.data[(((div_s32_device(i53
        - i51, i52) + k) - iv0) + convOut_dim0 * m) + 1] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel159(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel16(const
  emxArray_real_T a2, const int32_T ns, int32_T loop_ub, emxArray_int8_T vals)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(loop_ub) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    vals.data[iv0 + 1] = static_cast<int8_T>(a2.data[(ns + iv0) + 2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel160(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel161(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel162(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel163
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel164(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel165(const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv16)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    iv16.data[iv0] = k - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel166(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv17)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    iv17.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel167(const
  emxArray_real_T y, const emxArray_int32_T iv17, const emxArray_int32_T iv16,
  const int32_T zfSize_idx_1, int32_T b_y, emxArray_real_T expanded, int32_T
  expanded_dim0, int32_T y_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zfSize_idx_1) * (static_cast<uint64_T>(b_y) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % static_cast<uint64_T>(zfSize_idx_1));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      static_cast<uint64_T>(zfSize_idx_1));
    expanded.data[iv16.data[ix] + expanded_dim0 * iv17.data[iv0]] = y.data
      [((zfSize_idx_1 - ix) + y_dim0 * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel168(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T OH, int32_T c, emxArray_real_T convOut, int32_T b_dim0, int32_T
  expanded_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) * static_cast<uint64_T>(c) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T orow;
    orow = static_cast<int32_T>(idx % static_cast<uint64_T>(OH));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
      static_cast<uint64_T>(OH));
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if (k > 2147483646 - orow) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[(k + expanded_dim0 * iv0) - 1] * b.data[(b_dim0 - m) -
        1];
    }

    convOut.data[orow + convOut_dim0 * iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel169(const
  emxArray_real_T zfIIR, const emxArray_real_T convOut, const int32_T i, int32_T
  b_convOut, emxArray_real_T c_convOut, int32_T convOut_dim0, int32_T
  b_convOut_dim0, int32_T zfIIR_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i) * (static_cast<uint64_T>(b_convOut) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % static_cast<uint64_T>(i));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      static_cast<uint64_T>(i));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zfIIR.data[ix + zfIIR_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel17(const
  int32_T ns, const int32_T vlen, int32_T loop_ub, emxArray_int8_T vals)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(loop_ub) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    vals.data[(iv0 + vlen) - ns] = static_cast<int8_T>(1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel170(const
  emxArray_real_T convOut, const int32_T b_convOut, int32_T c_convOut,
  emxArray_real_T d_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_convOut) + 1UL) * (static_cast<uint64_T>
    (c_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_convOut) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_convOut) + 1UL));
    d_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel171(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim0,
  int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T x[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    x[0] = zfIIR_dim0;
    for (int32_T k{0}; k < x[0]; k++) {
      convOut.data[k + convOut_dim0 * m] += zfIIR.data[k];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel172(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut, int32_T zfIIR_dim1,
  int32_T convOut_dim0, int32_T zfIIR_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T x[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    x[1] = zfIIR_dim1;
    for (int32_T k{0}; k < x[1]; k++) {
      convOut.data[k + convOut_dim0 * m] += zfIIR.data[zfIIR_dim0 * k];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel173(const
  emxArray_real_T a, const int32_T zfSize_idx_1, int32_T ns, emxArray_real_T
  convOut, int32_T a_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T ix;
    int32_T m;
    m = static_cast<int32_T>(idx);
    ix = (zfSize_idx_1 + a_dim0) - 1;
    for (int32_T k{0}; k < ix; k++) {
      int32_T bcoef;
      bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 1.0,
        static_cast<real_T>(a_dim0))) - 1;
      for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
        convOut.data[k + convOut_dim0 * m] -= convOut.data[((k - iv0) +
          convOut_dim0 * m) - 1] * a.data[iv0 + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel174(const
  emxArray_real_T convOut, const int32_T zfSize_idx_1, int32_T b_convOut,
  emxArray_real_T c_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zfSize_idx_1) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % static_cast<uint64_T>(zfSize_idx_1));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / static_cast<
      uint64_T>(zfSize_idx_1));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel175(const
  int32_T zfSize_idx_1, int32_T x[2], int32_T y_dim1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    x[0] = zfSize_idx_1;
    x[1] = y_dim1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel176(const
  emxArray_real_T convOut, int32_T x, emxArray_real_T yc5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    yc5.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel177(const
  emxArray_real_T yc5, const int32_T b_yc5, int32_T c_yc5, emxArray_real_T xc1,
  int32_T xc1_dim0, int32_T yc5_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_yc5) + 1UL) * (static_cast<uint64_T>(c_yc5)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_yc5) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_yc5) + 1UL));
    xc1.data[ix + xc1_dim0 * iv0] = yc5.data[((yc5_dim0 - ix) + yc5_dim0 * iv0)
      - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel178(const
  emxArray_real_T xc1, const int32_T x[2], const int32_T b_x, int32_T c_x,
  emxArray_real_T d_x, int32_T x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_x) + 1UL) * (static_cast<uint64_T>(c_x) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_x) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_x) + 1UL));
    d_x.data[ix + x_dim0 * iv0] = xc1.data[ix + x[0] * iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel179(const
  emxArray_real_T a2, real_T *a1, real_T *b_a1, real_T *c_a1, real_T *d_a1,
  real_T *e_a1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *e_a1 = a2.data[0];
    *d_a1 = a2.data[0];
    *c_a1 = a2.data[0];
    *b_a1 = a2.data[0];
    *a1 = a2.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel18(const
  int32_T x[2], const int32_T ns, const int32_T vlen, int32_T nfilt,
  emxArray_int8_T vals)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    vals.data[((iv0 + vlen) - ns) + x[1]] = static_cast<int8_T>(-1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel180(const
  real_T *d, const emxArray_real_T x, const int32_T i, emxArray_real_T xt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    xt.data[iv0] = -x.data[i - iv0] + *d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel181(const
  real_T val, const emxArray_real_T zi, int32_T b_zi, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_zi);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = zi.data[iv0] * val;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel182(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel183(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel184(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel185(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel186
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel187(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel188(const
  emxArray_real_T xt, const int32_T vlen, const emxArray_int32_T y, int32_T b_y,
  emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    expanded.data[k - 1] = xt.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel189(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T OH, emxArray_real_T convOut, int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if (k > 2147483646 - orow) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[k - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel19(const
  emxArray_real_T a2, const real_T val, const emxArray_real_T b2, int32_T nfilt,
  emxArray_real_T rhs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    rhs.data[iv0] = b2.data[iv0 + 1] - val * a2.data[iv0 + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel190(const
  emxArray_real_T y, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    convOut.data[k] += y.data[k];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel191(const
  emxArray_real_T y, emxArray_real_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += y.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel192(const
  emxArray_real_T convOut, const int32_T ns, int32_T nfilt, emxArray_real_T
  zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt - ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zfIIR.data[iv0] = convOut.data[ns + iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel193(const
  emxArray_real_T convOut, const emxArray_real_T a, int32_T ns, emxArray_real_T
  zfIIR, int32_T a_dim0, int32_T xt_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T k;
    k = static_cast<int32_T>(idx);
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 2.0, static_cast<
      real_T>(a_dim0)));
    for (int32_T iv0{0}; iv0 <= bcoef - 2; iv0++) {
      zfIIR.data[k + 1] += convOut.data[(xt_dim0 + k) - iv0] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel194(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel195(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel196(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel197(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel198
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel199(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel2
  (emxArray_real_T a2)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a2.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel20(const
  emxArray_int32_T rows, int32_T ns, emxArray_int32_T ridxInt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ridxInt.data[k] = rows.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel200(const
  emxArray_real_T x, const int32_T vlen, const emxArray_int32_T y, int32_T b_y,
  emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    expanded.data[k - 1] = x.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel201(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T OH, emxArray_real_T convOut, int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if (k > 2147483646 - orow) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[k - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel202(const
  emxArray_real_T zfIIR, int32_T zfSize_idx_0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zfSize_idx_0) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    convOut.data[k] += zfIIR.data[k];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel203(const
  emxArray_real_T zfIIR, emxArray_real_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += zfIIR.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel204(const
  emxArray_real_T convOut, const int32_T ns, int32_T nfilt, emxArray_real_T
  zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt - ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zfIIR.data[iv0] = convOut.data[ns + iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel205(const
  emxArray_real_T convOut, const emxArray_real_T a, int32_T ns, emxArray_real_T
  zfIIR, int32_T a_dim0, int32_T x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 3UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T k;
    k = static_cast<int32_T>(idx);
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 2.0, static_cast<
      real_T>(a_dim0)));
    for (int32_T iv0{0}; iv0 <= bcoef - 2; iv0++) {
      zfIIR.data[k + 1] += convOut.data[(x_dim0 + k) - iv0] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel206(const
  emxArray_real_T convOut, int32_T x, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel207(const
  real_T *d, const emxArray_real_T x, const int32_T nfilt, const int32_T ns,
  int32_T idx, emxArray_real_T xt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((idx - ns) / nfilt);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    xt.data[iv0] = -x.data[ns + nfilt * iv0] + *d;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel208(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel209(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel21(const
  emxArray_int32_T cols, int32_T ns, emxArray_int32_T sortedIndices,
  emxArray_int32_T cidxInt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    cidxInt.data[k] = cols.data[k];
    sortedIndices.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel210(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel211(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel212
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel213(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel214(const
  emxArray_real_T xt, const int32_T vlen, const emxArray_int32_T y, int32_T b_y,
  emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    expanded.data[k - 1] = xt.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel215(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T OH, emxArray_real_T convOut, int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if (k > 2147483646 - orow) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[k - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel216(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    convOut.data[k] += zfIIR.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel217(const
  emxArray_real_T convOut, int32_T xt, emxArray_real_T yc3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xt);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    yc3.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel218(const
  real_T val, const emxArray_real_T zi, int32_T b_zi, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_zi);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = zi.data[iv0] * val;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel219(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel22(const
  emxArray_int32_T cidxInt, int32_T b_cidxInt, emxArray_int32_T t)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cidxInt);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    t.data[iv0] = cidxInt.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel220(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel221(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel222(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel223
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel224(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel225(const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv15)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    iv15.data[iv0] = k - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel226(const
  emxArray_real_T yc3, const int32_T zfSize_idx_1, const int32_T idx, const
  emxArray_int32_T iv15, int32_T k, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(k);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    expanded.data[iv15.data[iv0]] = yc3.data[(idx + zfSize_idx_1 * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel227(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T OH, emxArray_real_T convOut, int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if ((orow + 1 < 0) && (k < MAX_int32_T - orow)) {
        k = MIN_int32_T;
      } else if ((orow + 1 > 0) && (k > 2147483646 - orow)) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[k - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel228(const
  emxArray_real_T y, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    convOut.data[k] += y.data[k];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel229(const
  emxArray_real_T y, emxArray_real_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += y.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel23(const
  emxArray_int32_T t, const emxArray_int32_T sortedIndices, int32_T ns,
  emxArray_int32_T cidxInt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    cidxInt.data[k] = t.data[sortedIndices.data[k] - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel230(const
  emxArray_real_T convOut, const int32_T ns, int32_T nfilt, emxArray_real_T
  zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt - ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zfIIR.data[iv0] = convOut.data[ns + iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel231(const
  emxArray_real_T convOut, const int32_T zfSize_idx_1, const int32_T idx, const
  int32_T c, const emxArray_real_T a, int32_T ns, emxArray_real_T zfIIR, int32_T
  a_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 3UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T bcoef;
    int32_T k;
    k = static_cast<int32_T>(b_idx);
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 2.0,
      static_cast<real_T>(a_dim0)));
    for (int32_T iv0{0}; iv0 <= bcoef - 2; iv0++) {
      zfIIR.data[k + 1] += convOut.data[((div_s32_device(c - idx, zfSize_idx_1)
        + k) - iv0) + 1] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel232(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel233(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel234(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel235(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel236
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel237(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel238(const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv18)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    iv18.data[iv0] = k - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel239(const
  emxArray_real_T y, const emxArray_int32_T iv18, const int32_T idx,
  emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(idx);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    expanded.data[iv18.data[iv0]] = y.data[idx - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel24(const
  emxArray_int32_T ridxInt, int32_T b_ridxInt, emxArray_int32_T t)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_ridxInt);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    t.data[iv0] = ridxInt.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel240(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T OH, emxArray_real_T convOut, int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if (k > 2147483646 - orow) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[k - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel241(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    convOut.data[k] += zfIIR.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel242(const
  emxArray_real_T convOut, const int32_T idx, emxArray_real_T b_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(idx);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    b_convOut.data[iv0] = convOut.data[idx - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel243(const
  emxArray_real_T convOut, const int32_T x, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx % (static_cast<uint64_T>(x) + 1UL));
    b_x.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel244(const
  emxArray_real_T x, int32_T b_x, emxArray_real_T yCol)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    yCol.data[iv0] = x.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel245(const
  emxArray_real_T a2, real_T *a1, real_T *b_a1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *b_a1 = a2.data[0];
    *a1 = a2.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel246(const
  emxArray_real_T yCol, real_T *d)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *d = 2.0 * yCol.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel247(const
  emxArray_real_T yCol, const int32_T i, const real_T *d, int32_T loop_ub,
  emxArray_real_T ytemp)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(loop_ub);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    ytemp.data[iv0] = *d - yCol.data[i - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel248(const
  real_T val, const emxArray_real_T zi, int32_T b_zi, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_zi);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = zi.data[iv0] * val;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel249(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel25(const
  emxArray_int32_T t, const emxArray_int32_T sortedIndices, int32_T ns,
  emxArray_int32_T ridxInt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    ridxInt.data[k] = t.data[sortedIndices.data[k] - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel250(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel251(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel252(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel253
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel254(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel255(const
  emxArray_real_T ytemp, const int32_T vlen, const emxArray_int32_T y, int32_T
  b_y, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    expanded.data[k - 1] = ytemp.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel256(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T OH, emxArray_real_T convOut, int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if (k > 2147483646 - orow) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[k - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel257(const
  emxArray_real_T y, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    convOut.data[k] += y.data[k];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel258(const
  emxArray_real_T y, emxArray_real_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += y.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel259(const
  real_T val, const emxArray_real_T zi, int32_T b_zi, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_zi);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = zi.data[iv0] * val;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel26(int32_T
  cols, emxArray_int32_T y_rowidx, emxArray_real_T y_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(cols);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_d.data[iv0] = 0.0;
    y_rowidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel260(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel261(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel262(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel263(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel264
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel265(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel266(const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv8)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    iv8.data[iv0] = k - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel267(const
  emxArray_real_T convOut, const int32_T k, const emxArray_int32_T iv8, int32_T
  ns, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv8.data[iv0]] = convOut.data[(k - iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel268(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T OH, emxArray_real_T convOut, int32_T b_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if (k > 2147483646 - orow) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[k - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[orow] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel269(const
  emxArray_real_T y, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    convOut.data[k] += y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel27(const
  emxArray_int8_T vals, const emxArray_int32_T sortedIndices, int32_T nfilt,
  emxArray_real_T y_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y_d.data[k] = static_cast<real_T>(vals.data[sortedIndices.data[k] - 1]);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel270(const
  emxArray_real_T y, emxArray_real_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += y.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel271(const
  emxArray_real_T convOut, const int32_T nfilt, const int32_T ns, int32_T idx,
  emxArray_real_T yCol)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(idx) - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    yCol.data[iv0] = convOut.data[(ns + nfilt * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel272(const
  emxArray_real_T yCol, const int32_T x, emxArray_real_T b_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx % (static_cast<uint64_T>(x) + 1UL));
    b_x.data[iv0] = yCol.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel273(const
  emxArray_real_T x, int32_T b_x, emxArray_real_T c_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    c_x.data[iv0] = x.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel274(const
  emxArray_real_T x, int32_T b_x, emxArray_real_T c_x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    c_x.data[iv0] = x.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel275(const
  emxArray_real_T x, const int32_T b_x, int32_T c_x, emxArray_real_T d_x,
  int32_T x_dim0, int32_T b_x_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_x) + 1UL) * (static_cast<uint64_T>(c_x) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_x) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_x) + 1UL));
    d_x.data[ix + x_dim0 * iv0] = x.data[ix + b_x_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel28(int32_T
  ns, emxArray_int32_T y_rowidx, emxArray_real_T y_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_d.data[iv0] = 0.0;
    y_rowidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel29(int32_T
  thism, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef + 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel3(int32_T
  nfilt, emxArray_int32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = iv0 + 2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel30(int32_T
  vlen, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef] = 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel31
  (emxArray_int32_T y_colidx, int32_T y_colidx_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y_colidx.data[y_colidx_dim0 - 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel32(int32_T
  ns, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_colidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel33(int32_T
  thism, emxArray_int32_T counts)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    counts.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel34(int32_T x
  [2], int32_T rhs_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    x[1] = rhs_dim0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel35(const
  emxArray_real_T rhs, int32_T x, emxArray_real_T outBuff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    outBuff.data[iv0] = rhs.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel36(const
  emxArray_real_T outBuff, int32_T i, emxArray_real_T zi)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zi.data[iv0] = outBuff.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel37(int32_T
  ns, emxArray_int32_T y_rowidx, emxArray_real_T y_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_d.data[iv0] = 0.0;
    y_rowidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel38(int32_T
  thism, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef + 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel39(int32_T
  vlen, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel4(int32_T
  nfilt, emxArray_int32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = iv0 + 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel40
  (emxArray_int32_T y_colidx, int32_T y_colidx_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y_colidx.data[y_colidx_dim0 - 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel41(int32_T
  ns, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_colidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel42(int32_T
  thism, emxArray_int32_T counts)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    counts.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel43(const
  emxArray_real_T rhs, int32_T b_rhs, emxArray_real_T zi)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_rhs);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zi.data[iv0] = rhs.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel44(int32_T
  ns, emxArray_int32_T y_rowidx, emxArray_real_T y_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_d.data[iv0] = 0.0;
    y_rowidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel45(int32_T
  thism, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef + 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel46(int32_T
  vlen, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef] = 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel47
  (emxArray_int32_T y_colidx, int32_T y_colidx_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y_colidx.data[y_colidx_dim0 - 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel48(int32_T
  ns, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_colidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel49(int32_T
  thism, emxArray_int32_T counts)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    counts.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel5(int32_T
  nfilt, emxArray_int32_T rows)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    rows.data[iv0] = iv0 + 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel50(int32_T x
  [2], int32_T rhs_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    x[1] = rhs_dim0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel51(const
  emxArray_real_T rhs, int32_T x, emxArray_real_T outBuff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    outBuff.data[iv0] = rhs.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel52(const
  emxArray_real_T outBuff, int32_T i, emxArray_real_T zi)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zi.data[iv0] = outBuff.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel53(const
  emxArray_real_T coef, int32_T b_coef, emxArray_real_T sosMat)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_coef);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    sosMat.data[iv0] = coef.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel54(const
  emxArray_real_T coef, emxArray_real_T sosMat)
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 3) {
    sosMat.data[iv0] = coef.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel55(const
  emxArray_real_T sosMat, int32_T b_sosMat, emxArray_real_T b1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_sosMat);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b1.data[iv0] = sosMat.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel56(const
  emxArray_real_T sosMat, emxArray_real_T b1)
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 1) {
    b1.data[0] = sosMat.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel57(const
  emxArray_real_T b1, int32_T vlen, emxArray_real_T y)
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
    y.data[k] = fabs(b1.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel58(const
  int32_T vlen, const emxArray_real_T y, const int32_T nfilt, const int32_T ns,
  emxArray_real_T maxCoefNum)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T iv0;
    bcoef = static_cast<int32_T>(idx);
    iv0 = (div_s32_device(bcoef, ns) * nfilt + bcoef) + 1;
    maxCoefNum.data[bcoef] = y.data[iv0 - 1];
    for (int32_T k{0}; k <= vlen - 2; k++) {
      int32_T ix;
      boolean_T p;
      ix = iv0 + (k + 1) * ns;
      if (isnan(y.data[ix - 1])) {
        p = false;
      } else if (isnan(maxCoefNum.data[bcoef])) {
        p = true;
      } else {
        p = (maxCoefNum.data[bcoef] < y.data[ix - 1]);
      }

      if (p) {
        maxCoefNum.data[bcoef] = y.data[ix - 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel59(const
  emxArray_real_T maxCoefNum, int32_T b_maxCoefNum, emxArray_boolean_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_maxCoefNum);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    x.data[iv0] = (maxCoefNum.data[iv0] != 0.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel6(const
  emxArray_int32_T y, const int32_T nfilt, int32_T loop_ub, emxArray_int32_T
  rows)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(loop_ub) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    rows.data[(iv0 + nfilt) + 1] = y.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel60(const
  real_T val, int32_T i, emxArray_real_T b1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b1.data[iv0] /= val;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel61(const
  emxArray_real_T b1, int32_T b_b1, emxArray_boolean_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    x.data[iv0] = (b1.data[iv0] != 0.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel62(const
  int32_T ii_data_dim0, int32_T ns, uint32_T nZeroLastDen_data[1])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    nZeroLastDen_data[0] = static_cast<uint32_T>(ii_data_dim0);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel63(uint32_T
  nZeroLastDen_data[1])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    nZeroLastDen_data[0] = 0U;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel64(const
  emxArray_real_T sosMat, real_T a0[3])
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 3) {
    a0[iv0] = sosMat.data[iv0 + 3];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel65(const
  emxArray_real_T sosMat, const real_T a0[3], emxArray_real_T b2,
  emxArray_real_T a2)
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 3) {
    a2.data[iv0] = a0[iv0] / a0[0];
    b2.data[iv0] = sosMat.data[iv0] / a0[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel66(const
  emxArray_real_T a2, const real_T val, const emxArray_real_T b2, real_T rhs[2])
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 2) {
    rhs[iv0] = b2.data[iv0 + 1] - val * a2.data[iv0 + 1];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel67(int8_T
  b_I[4])
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 4) {
    b_I[iv0] = static_cast<int8_T>(0);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel68(int8_T
  b_I[4])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    b_I[0] = static_cast<int8_T>(1);
    b_I[3] = static_cast<int8_T>(1);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel69(const
  emxArray_real_T a2, const int8_T b_I[4], real_T A[4])
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 2) {
    A[iv0] = static_cast<real_T>(b_I[iv0]) - (-a2.data[iv0 + 1]);
    A[iv0 + 2] = static_cast<real_T>((static_cast<int32_T>(b_I[iv0 + 2]) + iv0)
      - 1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel7(const
  emxArray_int32_T y, const int32_T nfilt, int32_T loop_ub, emxArray_int32_T
  rows, int32_T y_dim1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(loop_ub) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    rows.data[((iv0 + nfilt) + y_dim1) + 1] = y.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel70(const
  real_T A[4], const real_T val, const int32_T ns, const real_T rhs[2], const
  int32_T vlen, real_T Y[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    Y[1] = (rhs[vlen] - rhs[ns] * val) / (A[vlen + 2] - val * A[ns + 2]);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel71(const
  real_T A[4], const real_T rhs[2], const int32_T ns, real_T Y[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    Y[0] = (rhs[ns] - Y[1] * A[ns + 2]) / A[ns];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel72(const
  real_T Y[2], emxArray_real_T zi)
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 2) {
    zi.data[iv0] = Y[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel73(const
  emxArray_real_T x, int32_T sz, emxArray_real_T xc1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(sz);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    xc1.data[iv0] = x.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel74(const
  emxArray_real_T a2, real_T *a1, real_T *b_a1, real_T *c_a1, real_T *d_a1,
  real_T *e_a1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *e_a1 = a2.data[0];
    *d_a1 = a2.data[0];
    *c_a1 = a2.data[0];
    *b_a1 = a2.data[0];
    *a1 = a2.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel75(const
  emxArray_real_T xc1, int32_T b_xc1, emxArray_real_T y, int32_T xc1_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xc1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = 2.0 * xc1.data[xc1_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel76(const
  emxArray_real_T xc1, const emxArray_real_T y, const real_T nfact, const
  int32_T idx, const int32_T nfilt, const int32_T xt, int32_T ns,
  emxArray_real_T b_xt, int32_T xt_dim0, int32_T xc1_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(xt) + 1UL) * (static_cast<uint64_T>(ns) + 1UL)
    - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T k;
    int32_T orow;
    orow = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(xt) + 1UL));
    k = static_cast<int32_T>((b_idx - static_cast<uint64_T>(orow)) / (
      static_cast<uint64_T>(xt) + 1UL));
    b_xt.data[orow + xt_dim0 * k] = y.data[nfilt * k] - xc1.data
      [((static_cast<int32_T>(nfact + 1.0) - static_cast<int32_T>
         (static_cast<int32_T>(nfact + 1.0) - 1 != 1) * orow) + xc1_dim0 * (idx *
         k)) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel77(const
  emxArray_real_T xt, const emxArray_real_T zi, const int32_T b_zi, int32_T
  loop_ub, emxArray_real_T y, int32_T y_dim0, int32_T xt_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zi) + 1UL) * static_cast<uint64_T>(loop_ub)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_zi) + 1UL));
    y.data[ix + y_dim0 * iv0] = zi.data[ix] * xt.data[xt_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel78(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel79(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel8(int32_T
  nfilt, emxArray_int32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = iv0 + 2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel80(const
  emxArray_real_T xt, const emxArray_real_T zi, const int32_T b_zi, int32_T
  loop_ub, emxArray_real_T c_zi, int32_T xt_dim0, int32_T zi_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zi) + 1UL) * static_cast<uint64_T>(loop_ub)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_zi) + 1UL));
    cv = zi.data[ix] * xt.data[xt_dim0 * iv0];
    c_zi.data[ix + zi_dim0 * iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel81(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    b.data[k] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel82(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na) - 2UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    a.data[k + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel83
  (emxArray_real_T a)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    a.data[0] = 1.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel84(uint32_T
  zfSize[2], int32_T b_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    zfSize[0] = static_cast<uint32_T>(b_dim0 - 1);
  }
}

static __global__ __launch_bounds__(32, 1) void ecc_filtfilt_kernel85(uint32_T
  dv1[2], int32_T b_dim0)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    dv1[0] = static_cast<uint32_T>(b_dim0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel86(int32_T
  OH, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel87(const
  int32_T vlen, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T k;
    iv0 = static_cast<int32_T>(idx);
    k = y.data[iv0];
    if ((vlen < 0) && (k < MIN_int32_T - vlen)) {
      k = MIN_int32_T;
    } else if ((vlen > 0) && (k > MAX_int32_T - vlen)) {
      k = MAX_int32_T;
    } else {
      k += vlen;
    }

    iv3.data[iv0] = k - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel88(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv4)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    iv4.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel89(const
  emxArray_real_T xt, const emxArray_int32_T iv4, const emxArray_int32_T iv3,
  const int32_T b_xt, int32_T c_xt, emxArray_real_T expanded, int32_T
  expanded_dim0, int32_T xt_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xt) + 1UL) * (static_cast<uint64_T>(c_xt) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xt) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_xt) + 1UL));
    expanded.data[iv3.data[ix] + expanded_dim0 * iv4.data[iv0]] = xt.data[ix +
      xt_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel9(int32_T
  nfilt, emxArray_int32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = iv0 + 2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel90(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T OH, int32_T c, emxArray_real_T convOut, int32_T b_dim0, int32_T
  expanded_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH) * static_cast<uint64_T>(c) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T orow;
    orow = static_cast<int32_T>(idx % static_cast<uint64_T>(OH));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
      static_cast<uint64_T>(OH));
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T k;
      k = rows.data[m];
      if (k > 2147483646 - orow) {
        k = MAX_int32_T;
      } else {
        k = (orow + k) + 1;
      }

      cv += expanded.data[(k + expanded_dim0 * iv0) - 1] * b.data[(b_dim0 - m) -
        1];
    }

    convOut.data[orow + convOut_dim0 * iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel91(const
  emxArray_real_T zi, const emxArray_real_T convOut, const int32_T ns, int32_T
  b_convOut, emxArray_real_T c_convOut, int32_T convOut_dim0, int32_T
  b_convOut_dim0, int32_T zi_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) * (static_cast<uint64_T>(b_convOut) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % static_cast<uint64_T>(ns));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      static_cast<uint64_T>(ns));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zi.data[ix + zi_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel92(const
  emxArray_real_T convOut, const int32_T b_convOut, int32_T c_convOut,
  emxArray_real_T d_convOut, int32_T convOut_dim0, int32_T b_convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_convOut) + 1UL) * (static_cast<uint64_T>
    (c_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_convOut) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_convOut) + 1UL));
    d_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel93(const
  emxArray_real_T y, const int32_T zi, int32_T ns, emxArray_real_T convOut,
  int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi) + 1UL) * static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    int32_T m;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(zi) + 1UL));
    convOut.data[k + convOut_dim0 * m] += y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel94(const
  emxArray_real_T y, const int32_T zi, int32_T ns, emxArray_real_T convOut,
  int32_T convOut_dim0, int32_T y_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi) + 1UL) * static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T k;
    int32_T m;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(zi) + 1UL));
    convOut.data[k + convOut_dim0 * m] += y.data[y_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel95(const
  emxArray_real_T a, int32_T ns, emxArray_real_T convOut, int32_T xt_dim0,
  int32_T a_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T ix;
    int32_T m;
    m = static_cast<int32_T>(idx);
    ix = (xt_dim0 + a_dim0) - 1;
    for (int32_T k{0}; k < ix; k++) {
      int32_T bcoef;
      bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 1.0,
        static_cast<real_T>(a_dim0))) - 1;
      for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
        convOut.data[k + convOut_dim0 * m] -= convOut.data[((k - iv0) +
          convOut_dim0 * m) - 1] * a.data[iv0 + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel96(const
  emxArray_real_T convOut, const int32_T ns, const int32_T nfilt, int32_T
  b_convOut, emxArray_real_T zfIIR, int32_T zfIIR_dim0, int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nfilt - ns) * (static_cast<uint64_T>(b_convOut)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % static_cast<uint64_T>(nfilt - ns));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      static_cast<uint64_T>(nfilt - ns));
    zfIIR.data[ix + zfIIR_dim0 * iv0] = convOut.data[(ns + ix) + convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel97(const
  emxArray_real_T convOut, const emxArray_real_T a, const int32_T b_a, int32_T
  ns, emxArray_real_T zfIIR, int32_T a_dim0, int32_T zfIIR_dim0, int32_T xt_dim0,
  int32_T convOut_dim0)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_a) + 1UL) * static_cast<uint64_T>(ns) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T k;
    int32_T m;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_a) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
      (static_cast<uint64_T>(b_a) + 1UL));
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(k) + 2.0, static_cast<
      real_T>(a_dim0))) - 1;
    for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
      zfIIR.data[(k + zfIIR_dim0 * m) + 1] += convOut.data[((xt_dim0 + k) - iv0)
        + convOut_dim0 * m] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel98(const
  emxArray_real_T b2, int32_T b_b2, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b.data[iv0] = b2.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ecc_filtfilt_kernel99(const
  emxArray_real_T a2, int32_T b_a2, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a2);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    a.data[iv0] = a2.data[iv0];
  }
}

static void ecc_filtfilt_once()
{
  mwMemoryManagerInit(256U, 1U, 8U, 8192U);
}

static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_, const char_T *
  identifier, char_T y[14])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(a__output_of_sprintf_), &thisId, y);
  emlrtDestroyArray(&a__output_of_sprintf_);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[14])
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  c_emlrt_marshallIn(emlrtAlias(u), parentId, y);
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

static void feval(const mxArray *m, const mxArray *m1, emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  pArrays[0] = m;
  pArrays[1] = m1;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, nullptr, 2, &pArrays[0], "feval",
                        true, location);
}

static const mxArray *feval(const mxArray *m1, const mxArray *m2, const mxArray *
  m3, const mxArray *m4, emlrtMCInfo *location)
{
  const mxArray *pArrays[4];
  const mxArray *m;
  pArrays[0] = m1;
  pArrays[1] = m2;
  pArrays[2] = m3;
  pArrays[3] = m4;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 4, &pArrays[0],
    "feval", true, location);
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

static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu)
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

//
// function x = ecc_filtfilt(x,coef)
void ecc_filtfilt(emxArray_real_T *cpu_x, const emxArray_real_T *cpu_coef)
{
  static const int32_T iv7[2]{ 1, 6 };

  static const char_T rfmt[6]{ '%', '1', '4', '.', '6', 'e' };

  dim3 block;
  dim3 grid;
  emxArray_boolean_T c_gpu_x;
  emxArray_boolean_T d_gpu_x;
  emxArray_boolean_T *c_cpu_x;
  emxArray_boolean_T *d_cpu_x;
  emxArray_int32_T ab_gpu_y;
  emxArray_int32_T b_gpu_counts;
  emxArray_int32_T b_gpu_rows;
  emxArray_int32_T b_gpu_t;
  emxArray_int32_T b_gpu_y_colidx;
  emxArray_int32_T b_gpu_y_rowidx;
  emxArray_int32_T bb_gpu_y;
  emxArray_int32_T c_gpu_counts;
  emxArray_int32_T c_gpu_rows;
  emxArray_int32_T c_gpu_y;
  emxArray_int32_T c_gpu_y_colidx;
  emxArray_int32_T c_gpu_y_rowidx;
  emxArray_int32_T cb_gpu_y;
  emxArray_int32_T d_gpu_rows;
  emxArray_int32_T d_gpu_y_rowidx;
  emxArray_int32_T db_gpu_y;
  emxArray_int32_T e_gpu_rows;
  emxArray_int32_T e_gpu_y;
  emxArray_int32_T eb_gpu_y;
  emxArray_int32_T f_gpu_rows;
  emxArray_int32_T fb_gpu_y;
  emxArray_int32_T g_gpu_rows;
  emxArray_int32_T g_gpu_y;
  emxArray_int32_T gb_gpu_y;
  emxArray_int32_T gpu_cidxInt;
  emxArray_int32_T gpu_cols;
  emxArray_int32_T gpu_counts;
  emxArray_int32_T gpu_iv10;
  emxArray_int32_T gpu_iv11;
  emxArray_int32_T gpu_iv13;
  emxArray_int32_T gpu_iv14;
  emxArray_int32_T gpu_iv15;
  emxArray_int32_T gpu_iv16;
  emxArray_int32_T gpu_iv17;
  emxArray_int32_T gpu_iv18;
  emxArray_int32_T gpu_iv3;
  emxArray_int32_T gpu_iv4;
  emxArray_int32_T gpu_iv5;
  emxArray_int32_T gpu_iv6;
  emxArray_int32_T gpu_iv8;
  emxArray_int32_T gpu_ridxInt;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_sortedIndices;
  emxArray_int32_T gpu_t;
  emxArray_int32_T gpu_y_colidx;
  emxArray_int32_T gpu_y_rowidx;
  emxArray_int32_T h_gpu_rows;
  emxArray_int32_T h_gpu_y;
  emxArray_int32_T i_gpu_rows;
  emxArray_int32_T j_gpu_rows;
  emxArray_int32_T k_gpu_rows;
  emxArray_int32_T k_gpu_y;
  emxArray_int32_T l_gpu_rows;
  emxArray_int32_T l_gpu_y;
  emxArray_int32_T m_gpu_rows;
  emxArray_int32_T m_gpu_y;
  emxArray_int32_T r_gpu_y;
  emxArray_int32_T s_gpu_y;
  emxArray_int32_T u_gpu_y;
  emxArray_int32_T v_gpu_y;
  emxArray_int32_T w_gpu_y;
  emxArray_int32_T x_gpu_y;
  emxArray_int32_T y_gpu_y;
  emxArray_int32_T *b_cpu_counts;
  emxArray_int32_T *b_cpu_rows;
  emxArray_int32_T *b_cpu_t;
  emxArray_int32_T *b_cpu_y_colidx;
  emxArray_int32_T *b_cpu_y_rowidx;
  emxArray_int32_T *bb_cpu_y;
  emxArray_int32_T *c_cpu_counts;
  emxArray_int32_T *c_cpu_rows;
  emxArray_int32_T *c_cpu_y;
  emxArray_int32_T *c_cpu_y_colidx;
  emxArray_int32_T *c_cpu_y_rowidx;
  emxArray_int32_T *cb_cpu_y;
  emxArray_int32_T *cpu_cidxInt;
  emxArray_int32_T *cpu_cols;
  emxArray_int32_T *cpu_counts;
  emxArray_int32_T *cpu_iv10;
  emxArray_int32_T *cpu_iv11;
  emxArray_int32_T *cpu_iv13;
  emxArray_int32_T *cpu_iv14;
  emxArray_int32_T *cpu_iv15;
  emxArray_int32_T *cpu_iv16;
  emxArray_int32_T *cpu_iv17;
  emxArray_int32_T *cpu_iv18;
  emxArray_int32_T *cpu_iv3;
  emxArray_int32_T *cpu_iv4;
  emxArray_int32_T *cpu_iv5;
  emxArray_int32_T *cpu_iv6;
  emxArray_int32_T *cpu_iv8;
  emxArray_int32_T *cpu_ridxInt;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_sortedIndices;
  emxArray_int32_T *cpu_t;
  emxArray_int32_T *cpu_y;
  emxArray_int32_T *cpu_y_colidx;
  emxArray_int32_T *cpu_y_rowidx;
  emxArray_int32_T *d_cpu_rows;
  emxArray_int32_T *d_cpu_y;
  emxArray_int32_T *d_cpu_y_rowidx;
  emxArray_int32_T *db_cpu_y;
  emxArray_int32_T *e_cpu_rows;
  emxArray_int32_T *e_cpu_y;
  emxArray_int32_T *eb_cpu_y;
  emxArray_int32_T *f_cpu_rows;
  emxArray_int32_T *fb_cpu_y;
  emxArray_int32_T *g_cpu_rows;
  emxArray_int32_T *gb_cpu_y;
  emxArray_int32_T *h_cpu_rows;
  emxArray_int32_T *i_cpu_rows;
  emxArray_int32_T *j_cpu_rows;
  emxArray_int32_T *j_cpu_y;
  emxArray_int32_T *k_cpu_rows;
  emxArray_int32_T *k_cpu_y;
  emxArray_int32_T *l_cpu_rows;
  emxArray_int32_T *l_cpu_y;
  emxArray_int32_T *m_cpu_rows;
  emxArray_int32_T *m_cpu_y;
  emxArray_int32_T *o_cpu_y;
  emxArray_int32_T *r_cpu_y;
  emxArray_int32_T *t_cpu_y;
  emxArray_int32_T *u_cpu_y;
  emxArray_int32_T *v_cpu_y;
  emxArray_int32_T *x_cpu_y;
  emxArray_int32_T *y_colidx;
  emxArray_int32_T *y_cpu_y;
  emxArray_int8_T gpu_vals;
  emxArray_int8_T *cpu_vals;
  emxArray_real_T b_gpu_a;
  emxArray_real_T b_gpu_b;
  emxArray_real_T b_gpu_convOut;
  emxArray_real_T b_gpu_expanded;
  emxArray_real_T b_gpu_outBuff;
  emxArray_real_T b_gpu_rhs;
  emxArray_real_T b_gpu_sosMat;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_xt;
  emxArray_real_T b_gpu_y;
  emxArray_real_T b_gpu_y_d;
  emxArray_real_T b_gpu_yc3;
  emxArray_real_T b_gpu_zfIIR;
  emxArray_real_T b_gpu_zi;
  emxArray_real_T c_gpu_a;
  emxArray_real_T c_gpu_b;
  emxArray_real_T c_gpu_convOut;
  emxArray_real_T c_gpu_expanded;
  emxArray_real_T c_gpu_y_d;
  emxArray_real_T c_gpu_zfIIR;
  emxArray_real_T c_gpu_zi;
  emxArray_real_T d_gpu_a;
  emxArray_real_T d_gpu_b;
  emxArray_real_T d_gpu_convOut;
  emxArray_real_T d_gpu_expanded;
  emxArray_real_T d_gpu_y;
  emxArray_real_T d_gpu_y_d;
  emxArray_real_T d_gpu_zfIIR;
  emxArray_real_T e_gpu_a;
  emxArray_real_T e_gpu_b;
  emxArray_real_T e_gpu_convOut;
  emxArray_real_T e_gpu_expanded;
  emxArray_real_T e_gpu_zfIIR;
  emxArray_real_T f_gpu_a;
  emxArray_real_T f_gpu_b;
  emxArray_real_T f_gpu_convOut;
  emxArray_real_T f_gpu_expanded;
  emxArray_real_T f_gpu_y;
  emxArray_real_T f_gpu_zfIIR;
  emxArray_real_T g_gpu_a;
  emxArray_real_T g_gpu_b;
  emxArray_real_T g_gpu_convOut;
  emxArray_real_T g_gpu_expanded;
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_a2;
  emxArray_real_T gpu_b;
  emxArray_real_T gpu_b1;
  emxArray_real_T gpu_b2;
  emxArray_real_T gpu_coef;
  emxArray_real_T gpu_convOut;
  emxArray_real_T gpu_expanded;
  emxArray_real_T gpu_maxCoefNum;
  emxArray_real_T gpu_outBuff;
  emxArray_real_T gpu_sosMat;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xc1;
  emxArray_real_T gpu_xt;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_yCol;
  emxArray_real_T gpu_y_d;
  emxArray_real_T gpu_yc3;
  emxArray_real_T gpu_yc5;
  emxArray_real_T gpu_ytemp;
  emxArray_real_T gpu_zfIIR;
  emxArray_real_T gpu_zi;
  emxArray_real_T h_gpu_a;
  emxArray_real_T h_gpu_b;
  emxArray_real_T h_gpu_convOut;
  emxArray_real_T h_gpu_expanded;
  emxArray_real_T i_gpu_a;
  emxArray_real_T i_gpu_b;
  emxArray_real_T i_gpu_convOut;
  emxArray_real_T i_gpu_expanded;
  emxArray_real_T i_gpu_y;
  emxArray_real_T j_gpu_a;
  emxArray_real_T j_gpu_b;
  emxArray_real_T j_gpu_convOut;
  emxArray_real_T j_gpu_expanded;
  emxArray_real_T j_gpu_y;
  emxArray_real_T k_gpu_a;
  emxArray_real_T k_gpu_b;
  emxArray_real_T k_gpu_convOut;
  emxArray_real_T k_gpu_expanded;
  emxArray_real_T l_gpu_a;
  emxArray_real_T l_gpu_b;
  emxArray_real_T l_gpu_convOut;
  emxArray_real_T l_gpu_expanded;
  emxArray_real_T m_gpu_convOut;
  emxArray_real_T n_gpu_convOut;
  emxArray_real_T n_gpu_y;
  emxArray_real_T o_gpu_convOut;
  emxArray_real_T o_gpu_y;
  emxArray_real_T p_gpu_convOut;
  emxArray_real_T p_gpu_y;
  emxArray_real_T q_gpu_convOut;
  emxArray_real_T q_gpu_y;
  emxArray_real_T r_gpu_convOut;
  emxArray_real_T s_gpu_convOut;
  emxArray_real_T t_gpu_convOut;
  emxArray_real_T t_gpu_y;
  emxArray_real_T u_gpu_convOut;
  emxArray_real_T *ab_cpu_y;
  emxArray_real_T *b_cpu_a;
  emxArray_real_T *b_cpu_b;
  emxArray_real_T *b_cpu_convOut;
  emxArray_real_T *b_cpu_expanded;
  emxArray_real_T *b_cpu_outBuff;
  emxArray_real_T *b_cpu_sosMat;
  emxArray_real_T *b_cpu_x;
  emxArray_real_T *b_cpu_xt;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *b_cpu_y_d;
  emxArray_real_T *b_cpu_yc3;
  emxArray_real_T *b_cpu_zfIIR;
  emxArray_real_T *b_cpu_zi;
  emxArray_real_T *c_cpu_a;
  emxArray_real_T *c_cpu_b;
  emxArray_real_T *c_cpu_convOut;
  emxArray_real_T *c_cpu_expanded;
  emxArray_real_T *c_cpu_y_d;
  emxArray_real_T *c_cpu_zfIIR;
  emxArray_real_T *c_cpu_zi;
  emxArray_real_T *cpu_a;
  emxArray_real_T *cpu_a2;
  emxArray_real_T *cpu_b;
  emxArray_real_T *cpu_b1;
  emxArray_real_T *cpu_b2;
  emxArray_real_T *cpu_convOut;
  emxArray_real_T *cpu_expanded;
  emxArray_real_T *cpu_maxCoefNum;
  emxArray_real_T *cpu_outBuff;
  emxArray_real_T *cpu_rhs;
  emxArray_real_T *cpu_sosMat;
  emxArray_real_T *cpu_xc1;
  emxArray_real_T *cpu_xt;
  emxArray_real_T *cpu_yCol;
  emxArray_real_T *cpu_y_d;
  emxArray_real_T *cpu_yc3;
  emxArray_real_T *cpu_yc5;
  emxArray_real_T *cpu_ytemp;
  emxArray_real_T *cpu_zfIIR;
  emxArray_real_T *cpu_zi;
  emxArray_real_T *d_cpu_a;
  emxArray_real_T *d_cpu_b;
  emxArray_real_T *d_cpu_convOut;
  emxArray_real_T *d_cpu_expanded;
  emxArray_real_T *d_cpu_y_d;
  emxArray_real_T *d_cpu_zfIIR;
  emxArray_real_T *e_cpu_a;
  emxArray_real_T *e_cpu_b;
  emxArray_real_T *e_cpu_convOut;
  emxArray_real_T *e_cpu_expanded;
  emxArray_real_T *e_cpu_zfIIR;
  emxArray_real_T *f_cpu_a;
  emxArray_real_T *f_cpu_b;
  emxArray_real_T *f_cpu_convOut;
  emxArray_real_T *f_cpu_expanded;
  emxArray_real_T *f_cpu_y;
  emxArray_real_T *f_cpu_zfIIR;
  emxArray_real_T *g_cpu_a;
  emxArray_real_T *g_cpu_b;
  emxArray_real_T *g_cpu_convOut;
  emxArray_real_T *g_cpu_expanded;
  emxArray_real_T *g_cpu_y;
  emxArray_real_T *h_cpu_a;
  emxArray_real_T *h_cpu_b;
  emxArray_real_T *h_cpu_convOut;
  emxArray_real_T *h_cpu_expanded;
  emxArray_real_T *h_cpu_y;
  emxArray_real_T *i_cpu_a;
  emxArray_real_T *i_cpu_b;
  emxArray_real_T *i_cpu_convOut;
  emxArray_real_T *i_cpu_expanded;
  emxArray_real_T *i_cpu_y;
  emxArray_real_T *j_cpu_a;
  emxArray_real_T *j_cpu_b;
  emxArray_real_T *j_cpu_convOut;
  emxArray_real_T *j_cpu_expanded;
  emxArray_real_T *k_cpu_a;
  emxArray_real_T *k_cpu_b;
  emxArray_real_T *k_cpu_convOut;
  emxArray_real_T *k_cpu_expanded;
  emxArray_real_T *l_cpu_a;
  emxArray_real_T *l_cpu_b;
  emxArray_real_T *l_cpu_convOut;
  emxArray_real_T *l_cpu_expanded;
  emxArray_real_T *m_cpu_convOut;
  emxArray_real_T *n_cpu_convOut;
  emxArray_real_T *n_cpu_y;
  emxArray_real_T *o_cpu_convOut;
  emxArray_real_T *p_cpu_convOut;
  emxArray_real_T *p_cpu_y;
  emxArray_real_T *q_cpu_convOut;
  emxArray_real_T *q_cpu_y;
  emxArray_real_T *r_cpu_convOut;
  emxArray_real_T *s_cpu_convOut;
  emxArray_real_T *s_cpu_y;
  emxArray_real_T *t_cpu_convOut;
  emxArray_real_T *u_cpu_convOut;
  emxArray_real_T *w_cpu_y;
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *y;
  real_T cpu_A[4];
  real_T (*gpu_A)[4];
  real_T (*gpu_a0)[3];
  real_T (*gpu_Y)[2];
  real_T (*gpu_rhs)[2];
  real_T val;
  real_T *b_gpu_a1;
  real_T *c_gpu_a1;
  real_T *d_gpu_a1;
  real_T *e_gpu_a1;
  real_T *gpu_a1;
  real_T *gpu_d;
  int32_T e_cpu_x[2];
  int32_T (*e_gpu_x)[2];
  int32_T ii_data[1];
  int32_T i;
  int32_T iv0;
  int32_T x;
  uint32_T cpu_dv1[2];
  uint32_T cpu_zfSize[2];
  uint32_T (*gpu_dv1)[2];
  uint32_T (*gpu_zfSize)[2];
  uint32_T cpu_nZeroLastDen_data[1];
  uint32_T (*gpu_nZeroLastDen_data)[1];
  int8_T (*gpu_I)[4];
  boolean_T a_dirtyOnGpu;
  boolean_T b2_dirtyOnGpu;
  boolean_T b_a_dirtyOnGpu;
  boolean_T b_b_dirtyOnCpu;
  boolean_T b_b_dirtyOnGpu;
  boolean_T b_convOut_dirtyOnCpu;
  boolean_T b_convOut_dirtyOnGpu;
  boolean_T b_counts_dirtyOnGpu;
  boolean_T b_dirtyOnCpu;
  boolean_T b_dirtyOnGpu;
  boolean_T b_x_dirtyOnGpu;
  boolean_T b_y_d_dirtyOnGpu;
  boolean_T b_y_rowidx_dirtyOnGpu;
  boolean_T b_zfIIR_dirtyOnGpu;
  boolean_T b_zi_dirtyOnGpu;
  boolean_T c_a_dirtyOnGpu;
  boolean_T c_b_dirtyOnCpu;
  boolean_T c_b_dirtyOnGpu;
  boolean_T c_convOut_dirtyOnCpu;
  boolean_T c_convOut_dirtyOnGpu;
  boolean_T c_counts_dirtyOnGpu;
  boolean_T c_x_dirtyOnGpu;
  boolean_T c_y_d_dirtyOnGpu;
  boolean_T c_y_rowidx_dirtyOnGpu;
  boolean_T c_zfIIR_dirtyOnGpu;
  boolean_T cidxInt_dirtyOnGpu;
  boolean_T convOut_dirtyOnCpu;
  boolean_T convOut_dirtyOnGpu;
  boolean_T counts_dirtyOnGpu;
  boolean_T d_a_dirtyOnGpu;
  boolean_T d_b_dirtyOnCpu;
  boolean_T d_b_dirtyOnGpu;
  boolean_T d_convOut_dirtyOnCpu;
  boolean_T d_convOut_dirtyOnGpu;
  boolean_T d_y_d_dirtyOnGpu;
  boolean_T d_y_rowidx_dirtyOnGpu;
  boolean_T d_zfIIR_dirtyOnGpu;
  boolean_T dv1_dirtyOnCpu;
  boolean_T e_a_dirtyOnGpu;
  boolean_T e_b_dirtyOnCpu;
  boolean_T e_b_dirtyOnGpu;
  boolean_T e_convOut_dirtyOnCpu;
  boolean_T e_convOut_dirtyOnGpu;
  boolean_T e_zfIIR_dirtyOnGpu;
  boolean_T f_a_dirtyOnGpu;
  boolean_T f_b_dirtyOnCpu;
  boolean_T f_b_dirtyOnGpu;
  boolean_T f_convOut_dirtyOnCpu;
  boolean_T f_convOut_dirtyOnGpu;
  boolean_T g_a_dirtyOnGpu;
  boolean_T g_b_dirtyOnCpu;
  boolean_T g_b_dirtyOnGpu;
  boolean_T g_convOut_dirtyOnCpu;
  boolean_T g_convOut_dirtyOnGpu;
  boolean_T h_b_dirtyOnCpu;
  boolean_T h_b_dirtyOnGpu;
  boolean_T h_convOut_dirtyOnCpu;
  boolean_T h_convOut_dirtyOnGpu;
  boolean_T i_b_dirtyOnCpu;
  boolean_T i_b_dirtyOnGpu;
  boolean_T i_convOut_dirtyOnCpu;
  boolean_T i_convOut_dirtyOnGpu;
  boolean_T j_b_dirtyOnCpu;
  boolean_T j_b_dirtyOnGpu;
  boolean_T j_convOut_dirtyOnCpu;
  boolean_T j_convOut_dirtyOnGpu;
  boolean_T k_b_dirtyOnCpu;
  boolean_T k_b_dirtyOnGpu;
  boolean_T k_convOut_dirtyOnCpu;
  boolean_T k_convOut_dirtyOnGpu;
  boolean_T l_b_dirtyOnCpu;
  boolean_T l_b_dirtyOnGpu;
  boolean_T l_convOut_dirtyOnCpu;
  boolean_T l_convOut_dirtyOnGpu;
  boolean_T maxCoefNum_dirtyOnGpu;
  boolean_T nZeroLastDen_data_dirtyOnGpu;
  boolean_T ridxInt_dirtyOnGpu;
  boolean_T validLaunchParams;
  boolean_T x_dirtyOnCpu;
  boolean_T x_dirtyOnGpu;
  boolean_T yCol_dirtyOnGpu;
  boolean_T y_d_dirtyOnGpu;
  boolean_T y_dirtyOnCpu;
  boolean_T y_rowidx_dirtyOnGpu;
  boolean_T yc3_dirtyOnGpu;
  boolean_T ytemp_dirtyOnCpu;
  boolean_T ytemp_dirtyOnGpu;
  boolean_T zfIIR_dirtyOnGpu;
  boolean_T zfSize_dirtyOnCpu;
  boolean_T zi_dirtyOnCpu;
  boolean_T zi_dirtyOnGpu;
  mwCudaMalloc(&gpu_A, 32UL);
  mwCudaMalloc(&gpu_Y, 16UL);
  mwCudaMalloc(&gpu_I, 4UL);
  mwCudaMalloc(&gpu_rhs, 16UL);
  mwCudaMalloc(&gpu_a0, 24UL);
  mwCudaMalloc(&gpu_nZeroLastDen_data, 4UL);
  mwCudaMalloc(&gpu_d, 8UL);
  mwCudaMalloc(&c_gpu_a1, 8UL);
  mwCudaMalloc(&gpu_zfSize, 8UL);
  mwCudaMalloc(&d_gpu_a1, 8UL);
  mwCudaMalloc(&e_gpu_a1, 8UL);
  mwCudaMalloc(&gpu_a1, 8UL);
  mwCudaMalloc(&b_gpu_a1, 8UL);
  mwCudaMalloc(&gpu_dv1, 8UL);
  mwCudaMalloc(&e_gpu_x, 8UL);
  gpuEmxReset_real_T(&f_gpu_convOut);
  gpuEmxReset_real_T(&k_gpu_convOut);
  gpuEmxReset_real_T(&j_gpu_convOut);
  gpuEmxReset_real_T(&m_gpu_convOut);
  gpuEmxReset_real_T(&p_gpu_convOut);
  gpuEmxReset_real_T(&o_gpu_convOut);
  gpuEmxReset_real_T(&r_gpu_convOut);
  gpuEmxReset_real_T(&s_gpu_convOut);
  gpuEmxReset_real_T(&u_gpu_convOut);
  gpuEmxReset_real_T(&b_gpu_sosMat);
  gpuEmxReset_real_T(&e_gpu_convOut);
  gpuEmxReset_real_T(&i_gpu_convOut);
  gpuEmxReset_int32_T(&e_gpu_rows);
  gpuEmxReset_real_T(&c_gpu_zfIIR);
  gpuEmxReset_int32_T(&h_gpu_rows);
  gpuEmxReset_real_T(&d_gpu_zfIIR);
  gpuEmxReset_int32_T(&gpu_iv18);
  gpuEmxReset_int32_T(&gpu_iv17);
  gpuEmxReset_int32_T(&k_gpu_y);
  gpuEmxReset_real_T(&e_gpu_expanded);
  gpuEmxReset_int32_T(&s_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv16);
  gpuEmxReset_real_T(&g_gpu_convOut);
  gpuEmxReset_real_T(&l_gpu_convOut);
  gpuEmxReset_int32_T(&f_gpu_rows);
  gpuEmxReset_int32_T(&r_gpu_y);
  gpuEmxReset_int32_T(&i_gpu_rows);
  gpuEmxReset_real_T(&h_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_iv15);
  gpuEmxReset_int32_T(&gpu_iv14);
  gpuEmxReset_real_T(&g_gpu_a);
  gpuEmxReset_int32_T(&l_gpu_y);
  gpuEmxReset_real_T(&g_gpu_b);
  gpuEmxReset_real_T(&f_gpu_expanded);
  gpuEmxReset_real_T(&gpu_yc5);
  gpuEmxReset_int32_T(&v_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv13);
  gpuEmxReset_real_T(&h_gpu_convOut);
  gpuEmxReset_int32_T(&u_gpu_y);
  gpuEmxReset_real_T(&i_gpu_expanded);
  gpuEmxReset_real_T(&n_gpu_convOut);
  gpuEmxReset_int32_T(&g_gpu_rows);
  gpuEmxReset_real_T(&l_gpu_a);
  gpuEmxReset_real_T(&l_gpu_b);
  gpuEmxReset_int32_T(&j_gpu_rows);
  gpuEmxReset_real_T(&f_gpu_a);
  gpuEmxReset_real_T(&b_gpu_zfIIR);
  gpuEmxReset_real_T(&f_gpu_b);
  gpuEmxReset_int32_T(&gpu_iv11);
  gpuEmxReset_real_T(&j_gpu_y);
  gpuEmxReset_int32_T(&m_gpu_y);
  gpuEmxReset_real_T(&g_gpu_expanded);
  gpuEmxReset_int32_T(&x_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv10);
  gpuEmxReset_real_T(&gpu_yc3);
  gpuEmxReset_int32_T(&b_gpu_counts);
  gpuEmxReset_real_T(&d_gpu_convOut);
  gpuEmxReset_real_T(&e_gpu_zfIIR);
  gpuEmxReset_real_T(&b_gpu_convOut);
  gpuEmxReset_real_T(&c_gpu_zi);
  gpuEmxReset_real_T(&k_gpu_a);
  gpuEmxReset_real_T(&k_gpu_b);
  gpuEmxReset_real_T(&q_gpu_y);
  gpuEmxReset_int32_T(&w_gpu_y);
  gpuEmxReset_int32_T(&d_gpu_rows);
  gpuEmxReset_real_T(&j_gpu_expanded);
  gpuEmxReset_int32_T(&b_gpu_rows);
  gpuEmxReset_int32_T(&gpu_counts);
  gpuEmxReset_real_T(&gpu_outBuff);
  gpuEmxReset_int32_T(&c_gpu_counts);
  gpuEmxReset_real_T(&e_gpu_a);
  gpuEmxReset_real_T(&e_gpu_b);
  gpuEmxReset_int32_T(&gpu_iv8);
  gpuEmxReset_real_T(&b_gpu_outBuff);
  gpuEmxReset_real_T(&q_gpu_convOut);
  gpuEmxReset_int32_T(&c_gpu_y_rowidx);
  gpuEmxReset_real_T(&b_gpu_yc3);
  gpuEmxReset_int32_T(&b_gpu_y_colidx);
  gpuEmxReset_int32_T(&h_gpu_y);
  gpuEmxReset_real_T(&c_gpu_y_d);
  gpuEmxReset_int32_T(&e_gpu_y);
  gpuEmxReset_real_T(&d_gpu_expanded);
  gpuEmxReset_real_T(&b_gpu_expanded);
  gpuEmxReset_int32_T(&k_gpu_rows);
  gpuEmxReset_real_T(&f_gpu_zfIIR);
  gpuEmxReset_int32_T(&gpu_iv6);
  gpuEmxReset_int32_T(&b_gpu_y_rowidx);
  gpuEmxReset_int32_T(&d_gpu_y_rowidx);
  gpuEmxReset_real_T(&i_gpu_y);
  gpuEmxReset_int32_T(&gpu_y_colidx);
  gpuEmxReset_int32_T(&c_gpu_y_colidx);
  gpuEmxReset_real_T(&b_gpu_y_d);
  gpuEmxReset_real_T(&d_gpu_y_d);
  gpuEmxReset_real_T(&j_gpu_a);
  gpuEmxReset_real_T(&j_gpu_b);
  gpuEmxReset_int32_T(&ab_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv5);
  gpuEmxReset_real_T(&t_gpu_convOut);
  gpuEmxReset_real_T(&b_gpu_a);
  gpuEmxReset_real_T(&d_gpu_a);
  gpuEmxReset_real_T(&p_gpu_y);
  gpuEmxReset_real_T(&b_gpu_b);
  gpuEmxReset_real_T(&d_gpu_b);
  gpuEmxReset_int32_T(&l_gpu_rows);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_int32_T(&y_gpu_y);
  gpuEmxReset_real_T(&k_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_iv4);
  gpuEmxReset_real_T(&gpu_zfIIR);
  gpuEmxReset_real_T(&t_gpu_y);
  gpuEmxReset_int32_T(&cb_gpu_y);
  gpuEmxReset_real_T(&gpu_convOut);
  gpuEmxReset_int32_T(&gpu_iv3);
  gpuEmxReset_int32_T(&b_gpu_t);
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_real_T(&c_gpu_convOut);
  gpuEmxReset_int32_T(&bb_gpu_y);
  gpuEmxReset_real_T(&l_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_t);
  gpuEmxReset_int32_T(&c_gpu_rows);
  gpuEmxReset_real_T(&i_gpu_a);
  gpuEmxReset_real_T(&i_gpu_b);
  gpuEmxReset_int32_T(&gpu_sortedIndices);
  gpuEmxReset_int32_T(&c_gpu_y);
  gpuEmxReset_real_T(&gpu_expanded);
  gpuEmxReset_int32_T(&gpu_cidxInt);
  gpuEmxReset_int32_T(&g_gpu_y);
  gpuEmxReset_real_T(&c_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_ridxInt);
  gpuEmxReset_int32_T(&gpu_y_rowidx);
  gpuEmxReset_real_T(&gpu_y_d);
  gpuEmxReset_real_T(&b_gpu_zi);
  gpuEmxReset_real_T(&b_gpu_rhs);
  gpuEmxReset_real_T(&h_gpu_a);
  gpuEmxReset_real_T(&h_gpu_b);
  gpuEmxReset_real_T(&o_gpu_y);
  gpuEmxReset_real_T(&gpu_a);
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_int8_T(&gpu_vals);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_real_T(&gpu_ytemp);
  gpuEmxReset_real_T(&b_gpu_xt);
  gpuEmxReset_real_T(&c_gpu_a);
  gpuEmxReset_int32_T(&gpu_cols);
  gpuEmxReset_real_T(&c_gpu_b);
  gpuEmxReset_real_T(&n_gpu_y);
  gpuEmxReset_real_T(&f_gpu_y);
  gpuEmxReset_int32_T(&gb_gpu_y);
  gpuEmxReset_real_T(&gpu_xt);
  gpuEmxReset_boolean_T(&c_gpu_x);
  gpuEmxReset_real_T(&gpu_xc1);
  gpuEmxReset_int32_T(&fb_gpu_y);
  gpuEmxReset_real_T(&gpu_maxCoefNum);
  gpuEmxReset_int32_T(&m_gpu_rows);
  gpuEmxReset_real_T(&gpu_yCol);
  gpuEmxReset_int32_T(&eb_gpu_y);
  gpuEmxReset_boolean_T(&d_gpu_x);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_int32_T(&db_gpu_y);
  gpuEmxReset_real_T(&gpu_b1);
  gpuEmxReset_real_T(&gpu_a2);
  gpuEmxReset_real_T(&gpu_b2);
  gpuEmxReset_real_T(&gpu_sosMat);
  gpuEmxReset_real_T(&gpu_zi);
  gpuEmxReset_real_T(&gpu_x);
  gpuEmxReset_real_T(&gpu_coef);
  gpuEmxReset_real_T(&b_gpu_x);
  nZeroLastDen_data_dirtyOnGpu = false;
  zfSize_dirtyOnCpu = false;
  dv1_dirtyOnCpu = false;
  l_convOut_dirtyOnGpu = false;
  l_convOut_dirtyOnCpu = false;
  k_convOut_dirtyOnGpu = false;
  k_convOut_dirtyOnCpu = false;
  e_zfIIR_dirtyOnGpu = false;
  d_zfIIR_dirtyOnGpu = false;
  j_convOut_dirtyOnGpu = false;
  j_convOut_dirtyOnCpu = false;
  i_convOut_dirtyOnGpu = false;
  i_convOut_dirtyOnCpu = false;
  g_a_dirtyOnGpu = false;
  l_b_dirtyOnGpu = false;
  l_b_dirtyOnCpu = false;
  h_convOut_dirtyOnGpu = false;
  h_convOut_dirtyOnCpu = false;
  y_dirtyOnCpu = false;
  g_convOut_dirtyOnGpu = false;
  g_convOut_dirtyOnCpu = false;
  k_b_dirtyOnGpu = false;
  k_b_dirtyOnCpu = false;
  f_a_dirtyOnGpu = false;
  c_zfIIR_dirtyOnGpu = false;
  j_b_dirtyOnGpu = false;
  j_b_dirtyOnCpu = false;
  yc3_dirtyOnGpu = false;
  c_counts_dirtyOnGpu = false;
  f_convOut_dirtyOnGpu = false;
  f_convOut_dirtyOnCpu = false;
  b_zfIIR_dirtyOnGpu = false;
  e_convOut_dirtyOnGpu = false;
  e_convOut_dirtyOnCpu = false;
  b_zi_dirtyOnGpu = false;
  i_b_dirtyOnGpu = false;
  i_b_dirtyOnCpu = false;
  b_counts_dirtyOnGpu = false;
  counts_dirtyOnGpu = false;
  e_a_dirtyOnGpu = false;
  h_b_dirtyOnGpu = false;
  h_b_dirtyOnCpu = false;
  d_convOut_dirtyOnGpu = false;
  d_convOut_dirtyOnCpu = false;
  d_y_rowidx_dirtyOnGpu = false;
  d_y_d_dirtyOnGpu = false;
  zfIIR_dirtyOnGpu = false;
  c_y_rowidx_dirtyOnGpu = false;
  b_y_rowidx_dirtyOnGpu = false;
  c_y_d_dirtyOnGpu = false;
  b_y_d_dirtyOnGpu = false;
  g_b_dirtyOnGpu = false;
  g_b_dirtyOnCpu = false;
  c_convOut_dirtyOnGpu = false;
  c_convOut_dirtyOnCpu = false;
  d_a_dirtyOnGpu = false;
  c_a_dirtyOnGpu = false;
  f_b_dirtyOnGpu = false;
  f_b_dirtyOnCpu = false;
  e_b_dirtyOnGpu = false;
  e_b_dirtyOnCpu = false;
  b_convOut_dirtyOnGpu = false;
  b_convOut_dirtyOnCpu = false;
  convOut_dirtyOnGpu = false;
  convOut_dirtyOnCpu = false;
  d_b_dirtyOnGpu = false;
  d_b_dirtyOnCpu = false;
  cidxInt_dirtyOnGpu = false;
  ridxInt_dirtyOnGpu = false;
  y_rowidx_dirtyOnGpu = false;
  y_d_dirtyOnGpu = false;
  zi_dirtyOnGpu = false;
  c_b_dirtyOnGpu = false;
  c_b_dirtyOnCpu = false;
  b_a_dirtyOnGpu = false;
  b_b_dirtyOnGpu = false;
  b_b_dirtyOnCpu = false;
  ytemp_dirtyOnGpu = false;
  ytemp_dirtyOnCpu = false;
  a_dirtyOnGpu = false;
  b_dirtyOnGpu = false;
  b_dirtyOnCpu = false;
  c_x_dirtyOnGpu = false;
  maxCoefNum_dirtyOnGpu = false;
  yCol_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  b2_dirtyOnGpu = false;
  zi_dirtyOnCpu = false;
  x_dirtyOnCpu = true;
  x_dirtyOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  //  arguments
  //      x (:,:) double
  //      coef(1,:) double
  //  end
  // 'ecc_filtfilt:6' coder.gpu.kernelfun;
  //  Add kernelfun pragma to trigger kernel creation
  // nChs = width(x);
  // 'ecc_filtfilt:9' x = filtfilt(coef,1,x);
  emxInit_real_T(&b_cpu_x, 2, &c_emlrtRTEI, true);
  emxInit_real_T(&cpu_zi, 1, &fc_emlrtRTEI, true);
  emxInit_real_T(&cpu_sosMat, 2, &e_emlrtRTEI, true);
  emxInit_real_T(&cpu_b2, 1, &fc_emlrtRTEI, true);
  emxInit_real_T(&cpu_a2, 1, &fc_emlrtRTEI, true);
  emxInit_real_T(&cpu_b1, 2, &k_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &gc_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_y, 2, &hc_emlrtRTEI, true);
  emxInit_boolean_T(&c_cpu_x, 1, &v_emlrtRTEI, true);
  emxInit_int32_T(&c_cpu_y, 2, &ic_emlrtRTEI, true);
  emxInit_real_T(&cpu_yCol, 1, &r_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &o_emlrtRTEI, true);
  emxInit_real_T(&cpu_maxCoefNum, 1, &jc_emlrtRTEI, true);
  emxInit_int32_T(&d_cpu_y, 2, &kc_emlrtRTEI, true);
  emxInit_real_T(&cpu_xc1, 2, &lc_emlrtRTEI, true);
  emxInit_boolean_T(&d_cpu_x, 1, &q_emlrtRTEI, true);
  emxInit_real_T(&cpu_xt, 1, &s_emlrtRTEI, true);
  emxInit_int32_T(&e_cpu_y, 2, &mc_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_y, 1, &nc_emlrtRTEI, true);
  emxInit_real_T(&g_cpu_y, 2, &oc_emlrtRTEI, true);
  emxInit_real_T(&cpu_b, 1, &y_emlrtRTEI, true);
  emxInit_int32_T(&cpu_cols, 2, &x_emlrtRTEI, true);
  emxInit_real_T(&cpu_a, 1, &y_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_xt, 2, &pc_emlrtRTEI, true);
  emxInit_real_T(&cpu_ytemp, 1, &qc_emlrtRTEI, true);
  emxInit_real_T(&h_cpu_y, 1, &rc_emlrtRTEI, true);
  emxInit_int8_T(&cpu_vals, 2, &eb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_b, 1, &l_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_a, 1, &l_emlrtRTEI, true);
  emxInit_real_T(&i_cpu_y, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_b, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_a, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&cpu_rhs, 1, &sc_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_zi, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&cpu_y_d, 1, &tc_emlrtRTEI, true);
  emxInit_int32_T(&y_colidx, 1, &tc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y_rowidx, 1, &tc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ridxInt, 1, &uc_emlrtRTEI, true);
  emxInit_real_T(&cpu_expanded, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&j_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&cpu_cidxInt, 1, &vc_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_expanded, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&k_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&cpu_sortedIndices, 1, &wc_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_b, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_a, 1, &fb_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&cpu_t, 1, &ob_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_expanded, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&l_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&cpu_convOut, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&c_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_t, 1, &ob_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv3, 1, &ib_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_convOut, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&m_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&n_cpu_y, 2, &fc_emlrtRTEI, true);
  emxInit_real_T(&cpu_zfIIR, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv4, 1, &ib_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_expanded, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&o_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&p_cpu_y, 1, &xc_emlrtRTEI, true);
  emxInit_int32_T(&d_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_b, 1, &y_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_b, 1, &l_emlrtRTEI, true);
  emxInit_real_T(&q_cpu_y, 2, &yc_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_a, 1, &y_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_a, 1, &l_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv5, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&r_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&g_cpu_b, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&g_cpu_a, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_y_d, 1, &ad_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_y_d, 1, &ad_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y_colidx, 1, &ad_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_y_colidx, 1, &ad_emlrtRTEI, true);
  emxInit_real_T(&s_cpu_y, 1, &fc_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_y_rowidx, 1, &ad_emlrtRTEI, true);
  emxInit_int32_T(&c_cpu_y_rowidx, 1, &ad_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv6, 1, &ib_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_zfIIR, 2, &db_emlrtRTEI, true);
  emxInit_int32_T(&e_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_expanded, 1, &ib_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_expanded, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&t_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_y_d, 1, &ad_emlrtRTEI, true);
  emxInit_int32_T(&u_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&c_cpu_y_colidx, 1, &ad_emlrtRTEI, true);
  emxInit_real_T(&cpu_yc3, 2, &bc_emlrtRTEI, true);
  emxInit_int32_T(&d_cpu_y_rowidx, 1, &ad_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&cpu_outBuff, 1, &bd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv8, 1, &ib_emlrtRTEI, true);
  emxInit_real_T(&h_cpu_b, 1, &y_emlrtRTEI, true);
  emxInit_real_T(&h_cpu_a, 1, &y_emlrtRTEI, true);
  emxInit_int32_T(&cpu_counts, 1, &wb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_outBuff, 1, &bd_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_counts, 1, &wb_emlrtRTEI, true);
  emxInit_int32_T(&f_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&g_cpu_expanded, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&g_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&v_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&w_cpu_y, 2, &xb_emlrtRTEI, true);
  emxInit_real_T(&i_cpu_b, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&i_cpu_a, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_zi, 2, &xb_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_convOut, 1, &db_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_zfIIR, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_convOut, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&c_cpu_counts, 1, &wb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_yc3, 1, &cc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv10, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&x_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&h_cpu_expanded, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&y_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&ab_cpu_y, 1, &cd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv11, 1, &ib_emlrtRTEI, true);
  emxInit_real_T(&j_cpu_b, 1, &y_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_zfIIR, 1, &db_emlrtRTEI, true);
  emxInit_real_T(&j_cpu_a, 1, &y_emlrtRTEI, true);
  emxInit_int32_T(&h_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&k_cpu_b, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&k_cpu_a, 1, &fb_emlrtRTEI, true);
  emxInit_int32_T(&i_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&g_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&i_cpu_expanded, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&bb_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&h_cpu_convOut, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv13, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&cb_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&cpu_yc5, 2, &dc_emlrtRTEI, true);
  emxInit_real_T(&j_cpu_expanded, 1, &ib_emlrtRTEI, true);
  emxInit_real_T(&l_cpu_b, 1, &y_emlrtRTEI, true);
  emxInit_int32_T(&db_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&l_cpu_a, 1, &y_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv14, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv15, 1, &ib_emlrtRTEI, true);
  emxInit_real_T(&k_cpu_expanded, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&j_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&eb_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&k_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&i_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&j_cpu_convOut, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv16, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&fb_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&l_cpu_expanded, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&gb_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv17, 1, &ib_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv18, 1, &ib_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_zfIIR, 2, &db_emlrtRTEI, true);
  emxInit_int32_T(&l_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_zfIIR, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&m_cpu_rows, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&k_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&l_cpu_convOut, 1, &db_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_sosMat, 1, &h_emlrtRTEI, true);
  emxInit_real_T(&m_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&n_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&o_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&p_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&q_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&r_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&s_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&t_cpu_convOut, 2, &db_emlrtRTEI, true);
  emxInit_real_T(&u_cpu_convOut, 1, &y_emlrtRTEI, true);
  if ((cpu_coef->size[1] == 0) || ((cpu_x->size[0] == 0) || (cpu_x->size[1] == 0)))
  {
    b_cpu_x->size[0] = 0;
    b_cpu_x->size[1] = 0;
  } else {
    real_T nfact;
    int32_T c;
    int32_T csz_idx_0;
    int32_T idx;
    int32_T nfilt;
    int32_T ns;
    int32_T thism;
    int32_T vlen;
    boolean_T issos;
    boolean_T xIsRow;
    xIsRow = (cpu_x->size[0] == 1);
    if (xIsRow) {
      i = cpu_x->size[0] * cpu_x->size[1];
      cpu_x->size[0] = cpu_x->size[1];
      cpu_x->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_x, i, &b_emlrtRTEI);
    }

    if (cpu_coef->size[1] == 6) {
      if (cpu_coef->data[3] == 1.0) {
        coder::internal::warning();
      } else {
        coder::internal::b_warning();
      }
    }

    if ((cpu_coef->size[1] == 6) && (cpu_coef->data[3] == 1.0)) {
      issos = true;
    } else {
      issos = false;
    }

    i = cpu_zi->size[0];
    cpu_zi->size[0] = 2;
    emxEnsureCapacity_real_T(cpu_zi, i, &d_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(cpu_zi, &gpu_zi);
    if (issos) {
      boolean_T exitg1;
      i = cpu_sosMat->size[0] * cpu_sosMat->size[1];
      cpu_sosMat->size[0] = 1;
      cpu_sosMat->size[1] = cpu_coef->size[1];
      emxEnsureCapacity_real_T(cpu_sosMat, i, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_sosMat, &gpu_sosMat);
      iv0 = cpu_coef->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, cpu_coef);
        ecc_filtfilt_kernel53<<<grid, block>>>(gpu_coef, iv0, gpu_sosMat);
      } else {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, cpu_coef);
      }

      ecc_filtfilt_kernel54<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_coef,
        gpu_sosMat);
      if (cpu_sosMat->size[1] == 1) {
        i = b_cpu_sosMat->size[0];
        b_cpu_sosMat->size[0] = 1;
        emxEnsureCapacity_real_T(b_cpu_sosMat, i, &h_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_sosMat, &b_gpu_sosMat);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_sosMat, &gpu_sosMat);
        b_cpu_sosMat->data[0] = cpu_sosMat->data[0];
        i = cpu_b1->size[0] * cpu_b1->size[1];
        cpu_b1->size[0] = 1;
        cpu_b1->size[1] = 1;
        emxEnsureCapacity_real_T(cpu_b1, i, &k_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_b1, &gpu_b1);
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_sosMat, b_cpu_sosMat);
        ecc_filtfilt_kernel56<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (b_gpu_sosMat, gpu_b1);
      } else {
        i = cpu_b1->size[0] * cpu_b1->size[1];
        cpu_b1->size[0] = 1;
        cpu_b1->size[1] = cpu_sosMat->size[1];
        emxEnsureCapacity_real_T(cpu_b1, i, &i_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_b1, &gpu_b1);
        iv0 = cpu_sosMat->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel55<<<grid, block>>>(gpu_sosMat, iv0, gpu_b1);
        }
      }

      vlen = cpu_b1->size[1];
      for (iv0 = 0; iv0 < 2; iv0++) {
        cpu_dv1[iv0] = static_cast<uint32_T>(cpu_b1->size[iv0]);
        dv1_dirtyOnCpu = true;
      }

      i = b_cpu_y->size[0] * b_cpu_y->size[1];
      b_cpu_y->size[0] = static_cast<int32_T>(cpu_dv1[0]);
      b_cpu_y->size[1] = static_cast<int32_T>(cpu_dv1[1]);
      emxEnsureCapacity_real_T(b_cpu_y, i, &n_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_cpu_y, &gpu_y);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel57<<<grid, block>>>(gpu_b1, vlen, gpu_y);
      }

      i = cpu_maxCoefNum->size[0];
      cpu_maxCoefNum->size[0] = b_cpu_y->size[0];
      emxEnsureCapacity_real_T(cpu_maxCoefNum, i, &p_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_maxCoefNum, &gpu_maxCoefNum);
      vlen = b_cpu_y->size[1];
      ns = b_cpu_y->size[0];
      nfilt = b_cpu_y->size[0] * (b_cpu_y->size[1] - 1);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns), &grid,
        &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel58<<<grid, block>>>(vlen, gpu_y, nfilt, ns,
          gpu_maxCoefNum);
        maxCoefNum_dirtyOnGpu = true;
      }

      i = d_cpu_x->size[0];
      d_cpu_x->size[0] = cpu_maxCoefNum->size[0];
      emxEnsureCapacity_boolean_T(d_cpu_x, i, &q_emlrtRTEI);
      gpuEmxEnsureCapacity_boolean_T(d_cpu_x, &c_gpu_x);
      iv0 = cpu_maxCoefNum->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel59<<<grid, block>>>(gpu_maxCoefNum, iv0, c_gpu_x);
        c_x_dirtyOnGpu = true;
      }

      iv0 = 1;
      exitg1 = false;
      while ((!exitg1) && (iv0 <= d_cpu_x->size[0])) {
        if (c_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_boolean_T(d_cpu_x, &c_gpu_x);
        }

        c_x_dirtyOnGpu = false;
        if (!d_cpu_x->data[iv0 - 1]) {
          issos = false;
          exitg1 = true;
        } else {
          iv0++;
        }
      }

      if (issos) {
        if (maxCoefNum_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_maxCoefNum, &gpu_maxCoefNum);
        }

        val = cpu_maxCoefNum->data[0];
        i = cpu_b1->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel60<<<grid, block>>>(val, i, gpu_b1);
        }
      }

      i = c_cpu_x->size[0];
      c_cpu_x->size[0] = cpu_b1->size[1];
      emxEnsureCapacity_boolean_T(c_cpu_x, i, &v_emlrtRTEI);
      gpuEmxEnsureCapacity_boolean_T(c_cpu_x, &d_gpu_x);
      iv0 = cpu_b1->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel61<<<grid, block>>>(gpu_b1, iv0, d_gpu_x);
        b_x_dirtyOnGpu = true;
      }

      iv0 = c_cpu_x->size[0];
      idx = 0;
      ns = 1;
      exitg1 = false;
      while ((!exitg1) && (iv0 > 0)) {
        if (b_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_boolean_T(c_cpu_x, &d_gpu_x);
        }

        b_x_dirtyOnGpu = false;
        if (c_cpu_x->data[iv0 - 1]) {
          idx = 1;
          ii_data[0] = iv0;
          exitg1 = true;
        } else {
          iv0--;
        }
      }

      if (idx == 0) {
        ns = 0;
      }

      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns), &grid,
        &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel62<<<grid, block>>>(ii_data[0], ns,
          *gpu_nZeroLastDen_data);
        nZeroLastDen_data_dirtyOnGpu = true;
      }

      if (ns == 0) {
        ecc_filtfilt_kernel63<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_nZeroLastDen_data);
        nZeroLastDen_data_dirtyOnGpu = true;
      }

      ecc_filtfilt_kernel64<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_sosMat,
        *gpu_a0);
      i = cpu_a2->size[0];
      cpu_a2->size[0] = 3;
      emxEnsureCapacity_real_T(cpu_a2, i, &gb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_a2, &gpu_a2);
      i = cpu_b2->size[0];
      cpu_b2->size[0] = 3;
      emxEnsureCapacity_real_T(cpu_b2, i, &hb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_b2, &gpu_b2);
      ecc_filtfilt_kernel65<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_sosMat,
        *gpu_a0, gpu_b2, gpu_a2);
      if (nZeroLastDen_data_dirtyOnGpu) {
        cudaMemcpy(cpu_nZeroLastDen_data, *gpu_nZeroLastDen_data, 4UL,
                   cudaMemcpyDeviceToHost);
      }

      nfact = std::fmax(1.0, 3.0 * (std::fmax(1.0, static_cast<real_T>
        (cpu_nZeroLastDen_data[0])) - 1.0));
      gpuEmxMemcpyGpuToCpu_real_T(cpu_b2, &gpu_b2);
      val = cpu_b2->data[0];
      ecc_filtfilt_kernel66<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2, val,
        gpu_b2, *gpu_rhs);
      ecc_filtfilt_kernel67<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_I);
      ecc_filtfilt_kernel68<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_I);
      ecc_filtfilt_kernel69<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
        *gpu_I, *gpu_A);
      cudaMemcpy(cpu_A, *gpu_A, 32UL, cudaMemcpyDeviceToHost);
      if (std::abs(cpu_A[1]) > std::abs(cpu_A[0])) {
        ns = 1;
        vlen = 0;
      } else {
        ns = 0;
        vlen = 1;
      }

      ecc_filtfilt_kernel70<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_A,
        cpu_A[vlen] / cpu_A[ns], ns, *gpu_rhs, vlen, *gpu_Y);
      ecc_filtfilt_kernel71<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_A,
        *gpu_rhs, ns, *gpu_Y);
      ecc_filtfilt_kernel72<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_Y,
        gpu_zi);
    } else {
      nfilt = cpu_coef->size[1] - 2;
      nfact = std::fmax(1.0, 3.0 * (static_cast<real_T>(cpu_coef->size[1]) - 1.0));
      i = cpu_b2->size[0];
      cpu_b2->size[0] = cpu_coef->size[1];
      emxEnsureCapacity_real_T(cpu_b2, i, &f_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_b2, &gpu_b2);
      i = cpu_a2->size[0];
      cpu_a2->size[0] = cpu_coef->size[1];
      emxEnsureCapacity_real_T(cpu_a2, i, &g_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_a2, &gpu_a2);
      iv0 = cpu_coef->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, cpu_coef);
        ecc_filtfilt_kernel1<<<grid, block>>>(gpu_coef, iv0, gpu_b2, gpu_a2);
        b2_dirtyOnGpu = true;
      }

      ecc_filtfilt_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2);
      if (nfilt + 2 > 1) {
        if (nfilt + 1 < 2) {
          cpu_y->size[0] = 1;
          cpu_y->size[1] = 0;
        } else {
          i = cpu_y->size[0] * cpu_y->size[1];
          cpu_y->size[0] = 1;
          cpu_y->size[1] = nfilt;
          emxEnsureCapacity_int32_T(cpu_y, i, &j_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_y, &db_gpu_y);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel3<<<grid, block>>>(nfilt, db_gpu_y);
          }
        }

        if (nfilt < 1) {
          c_cpu_y->size[0] = 1;
          c_cpu_y->size[1] = 0;
        } else {
          i = c_cpu_y->size[0] * c_cpu_y->size[1];
          c_cpu_y->size[0] = 1;
          c_cpu_y->size[1] = nfilt;
          emxEnsureCapacity_int32_T(c_cpu_y, i, &j_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(c_cpu_y, &eb_gpu_y);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel4<<<grid, block>>>(nfilt, eb_gpu_y);
          }
        }

        i = cpu_rows->size[0] * cpu_rows->size[1];
        cpu_rows->size[0] = 1;
        cpu_rows->size[1] = ((nfilt + cpu_y->size[1]) + c_cpu_y->size[1]) + 1;
        emxEnsureCapacity_int32_T(cpu_rows, i, &o_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_rows, &m_gpu_rows);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt +
          1L), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel5<<<grid, block>>>(nfilt, m_gpu_rows);
        }

        csz_idx_0 = cpu_y->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (csz_idx_0), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel6<<<grid, block>>>(db_gpu_y, nfilt, csz_idx_0,
            m_gpu_rows);
        }

        csz_idx_0 = c_cpu_y->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (csz_idx_0), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel7<<<grid, block>>>(eb_gpu_y, nfilt, csz_idx_0,
            m_gpu_rows, cpu_y->size[1U]);
        }

        if (nfilt + 1 < 2) {
          d_cpu_y->size[0] = 1;
          d_cpu_y->size[1] = 0;
          e_cpu_y->size[0] = 1;
          e_cpu_y->size[1] = 0;
        } else {
          i = d_cpu_y->size[0] * d_cpu_y->size[1];
          d_cpu_y->size[0] = 1;
          d_cpu_y->size[1] = nfilt;
          emxEnsureCapacity_int32_T(d_cpu_y, i, &j_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(d_cpu_y, &fb_gpu_y);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel8<<<grid, block>>>(nfilt, fb_gpu_y);
          }

          i = e_cpu_y->size[0] * e_cpu_y->size[1];
          e_cpu_y->size[0] = 1;
          e_cpu_y->size[1] = nfilt;
          emxEnsureCapacity_int32_T(e_cpu_y, i, &j_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(e_cpu_y, &gb_gpu_y);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel9<<<grid, block>>>(nfilt, gb_gpu_y);
          }
        }

        ecc_filtfilt_kernel10<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nfilt,
          *e_gpu_x);
        i = cpu_cols->size[0] * cpu_cols->size[1];
        cpu_cols->size[0] = 1;
        cpu_cols->size[1] = ((nfilt + d_cpu_y->size[1]) + e_cpu_y->size[1]) + 1;
        emxEnsureCapacity_int32_T(cpu_cols, i, &x_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_cols, &gpu_cols);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt +
          1), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel11<<<grid, block>>>(nfilt + 1, gpu_cols);
        }

        csz_idx_0 = d_cpu_y->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (csz_idx_0), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel12<<<grid, block>>>(fb_gpu_y, *e_gpu_x, csz_idx_0,
            gpu_cols);
        }

        csz_idx_0 = e_cpu_y->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (csz_idx_0), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel13<<<grid, block>>>(gb_gpu_y, *e_gpu_x, csz_idx_0,
            gpu_cols, d_cpu_y->size[1U]);
        }

        if (nfilt + 2 < 3) {
          ns = -2;
          vlen = -1;
        } else {
          ns = 0;
          vlen = nfilt + 1;
        }

        ecc_filtfilt_kernel14<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(nfilt,
          *e_gpu_x);
        i = cpu_vals->size[0] * cpu_vals->size[1];
        cpu_vals->size[0] = 1;
        cpu_vals->size[1] = ((vlen - ns) + nfilt) + nfilt;
        emxEnsureCapacity_int8_T(cpu_vals, i, &eb_emlrtRTEI);
        gpuEmxEnsureCapacity_int8_T(cpu_vals, &gpu_vals);
        ecc_filtfilt_kernel15<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_vals);
        csz_idx_0 = vlen - ns;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (csz_idx_0 - 1L), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel16<<<grid, block>>>(gpu_a2, ns, csz_idx_0, gpu_vals);
        }

        cudaMemcpy(e_cpu_x, *e_gpu_x, 8UL, cudaMemcpyDeviceToHost);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(e_cpu_x
          [1]), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel17<<<grid, block>>>(ns, vlen, e_cpu_x[1], gpu_vals);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel18<<<grid, block>>>(*e_gpu_x, ns, vlen, nfilt,
            gpu_vals);
        }

        if (b2_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_b2, &gpu_b2);
        }

        val = cpu_b2->data[0];
        i = cpu_rhs->size[0];
        cpu_rhs->size[0] = nfilt + 1;
        emxEnsureCapacity_real_T(cpu_rhs, i, &kb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_rhs, &b_gpu_rhs);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt +
          1L), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel19<<<grid, block>>>(gpu_a2, val, gpu_b2, nfilt,
            b_gpu_rhs);
        }

        nfilt = cpu_cols->size[1];
        ns = cpu_rows->size[1];
        i = cpu_ridxInt->size[0];
        cpu_ridxInt->size[0] = cpu_rows->size[1];
        emxEnsureCapacity_int32_T(cpu_ridxInt, i, &mb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_ridxInt, &gpu_ridxInt);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel20<<<grid, block>>>(m_gpu_rows, ns, gpu_ridxInt);
          ridxInt_dirtyOnGpu = true;
        }

        ns = cpu_cols->size[1];
        i = cpu_cidxInt->size[0];
        cpu_cidxInt->size[0] = cpu_cols->size[1];
        emxEnsureCapacity_int32_T(cpu_cidxInt, i, &mb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_cidxInt, &gpu_cidxInt);
        i = cpu_sortedIndices->size[0];
        cpu_sortedIndices->size[0] = cpu_cols->size[1];
        emxEnsureCapacity_int32_T(cpu_sortedIndices, i, &nb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_sortedIndices, &gpu_sortedIndices);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel21<<<grid, block>>>(gpu_cols, ns, gpu_sortedIndices,
            gpu_cidxInt);
          cidxInt_dirtyOnGpu = true;
          gpuEmxMemcpyGpuToCpu_int32_T(cpu_sortedIndices, &gpu_sortedIndices);
        }

        if (cidxInt_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_int32_T(cpu_cidxInt, &gpu_cidxInt);
        }

        cidxInt_dirtyOnGpu = false;
        if (ridxInt_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_int32_T(cpu_ridxInt, &gpu_ridxInt);
        }

        ridxInt_dirtyOnGpu = false;
        coder::internal::introsort(cpu_sortedIndices, cpu_cidxInt->size[0],
          cpu_cidxInt, cpu_ridxInt);
        nZeroLastDen_data_dirtyOnGpu = true;
        ns = cpu_cidxInt->size[0];
        i = cpu_t->size[0];
        cpu_t->size[0] = cpu_cidxInt->size[0];
        emxEnsureCapacity_int32_T(cpu_t, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_t, &gpu_t);
        iv0 = cpu_cidxInt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel22<<<grid, block>>>(gpu_cidxInt, iv0, gpu_t);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&gpu_sortedIndices, cpu_sortedIndices);
          nZeroLastDen_data_dirtyOnGpu = false;
          ecc_filtfilt_kernel23<<<grid, block>>>(gpu_t, gpu_sortedIndices, ns,
            gpu_cidxInt);
          cidxInt_dirtyOnGpu = true;
        }

        ns = cpu_ridxInt->size[0];
        i = b_cpu_t->size[0];
        b_cpu_t->size[0] = cpu_ridxInt->size[0];
        emxEnsureCapacity_int32_T(b_cpu_t, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(b_cpu_t, &b_gpu_t);
        iv0 = cpu_ridxInt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel24<<<grid, block>>>(gpu_ridxInt, iv0, b_gpu_t);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (nZeroLastDen_data_dirtyOnGpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_sortedIndices, cpu_sortedIndices);
          }

          nZeroLastDen_data_dirtyOnGpu = false;
          ecc_filtfilt_kernel25<<<grid, block>>>(b_gpu_t, gpu_sortedIndices, ns,
            gpu_ridxInt);
          ridxInt_dirtyOnGpu = true;
        }

        vlen = cpu_ridxInt->size[0];
        if (ridxInt_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_int32_T(cpu_ridxInt, &gpu_ridxInt);
        }

        thism = cpu_ridxInt->data[0];
        for (x = 0; x <= vlen - 2; x++) {
          if (thism < cpu_ridxInt->data[x + 1]) {
            thism = cpu_ridxInt->data[x + 1];
          }
        }

        if (cidxInt_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_int32_T(cpu_cidxInt, &gpu_cidxInt);
        }

        x = cpu_cidxInt->data[cpu_cidxInt->size[0] - 1] - 1;
        i = cpu_y_d->size[0];
        cpu_y_d->size[0] = cpu_cols->size[1];
        emxEnsureCapacity_real_T(cpu_y_d, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_y_d, &gpu_y_d);
        i = y_colidx->size[0];
        y_colidx->size[0] = cpu_cidxInt->data[cpu_cidxInt->size[0] - 1] + 1;
        emxEnsureCapacity_int32_T(y_colidx, i, &qb_emlrtRTEI);
        y_colidx->data[0] = 1;
        i = cpu_y_rowidx->size[0];
        cpu_y_rowidx->size[0] = cpu_cols->size[1];
        emxEnsureCapacity_int32_T(cpu_y_rowidx, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
        iv0 = cpu_cols->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel26<<<grid, block>>>(iv0, gpu_y_rowidx, gpu_y_d);
          y_d_dirtyOnGpu = true;
          y_rowidx_dirtyOnGpu = true;
        }

        ns = 0;
        for (c = 0; c <= x; c++) {
          while ((ns + 1 <= nfilt) && (cpu_cidxInt->data[ns] == c + 1)) {
            if (y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
            }

            cpu_y_rowidx->data[ns] = cpu_ridxInt->data[ns];
            y_rowidx_dirtyOnGpu = false;
            ns++;
          }

          y_colidx->data[c + 1] = ns + 1;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (nZeroLastDen_data_dirtyOnGpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_sortedIndices, cpu_sortedIndices);
          }

          ecc_filtfilt_kernel27<<<grid, block>>>(gpu_vals, gpu_sortedIndices,
            nfilt, gpu_y_d);
          y_d_dirtyOnGpu = true;
        }

        idx = 1;
        ns = y_colidx->size[0];
        for (c = 0; c <= ns - 2; c++) {
          vlen = y_colidx->data[c];
          y_colidx->data[c] = idx;
          while (vlen < y_colidx->data[c + 1]) {
            val = 0.0;
            if (y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
            }

            y_rowidx_dirtyOnGpu = false;
            nfilt = cpu_y_rowidx->data[vlen - 1];
            while ((vlen < y_colidx->data[c + 1]) && (cpu_y_rowidx->data[vlen -
                    1] == nfilt)) {
              if (y_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_y_d, &gpu_y_d);
              }

              y_d_dirtyOnGpu = false;
              val += cpu_y_d->data[vlen - 1];
              vlen++;
            }

            if (val != 0.0) {
              if (y_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_y_d, &gpu_y_d);
              }

              cpu_y_d->data[idx - 1] = val;
              y_d_dirtyOnGpu = false;
              cpu_y_rowidx->data[idx - 1] = nfilt;
              idx++;
            }
          }
        }

        y_colidx->data[y_colidx->size[0] - 1] = idx;
        if (cpu_rhs->size[0] == cpu_cidxInt->data[cpu_cidxInt->size[0] - 1]) {
          cs_di *b_cxA;
          cs_din *b_N;
          cs_dis *b_S;
          int64_T b;
          if (thism < cpu_cidxInt->data[cpu_cidxInt->size[0] - 1]) {
            if (y_colidx->data[y_colidx->size[0] - 1] - 1 >= 1) {
              ns = y_colidx->data[y_colidx->size[0] - 1] - 2;
            } else {
              ns = 0;
            }

            i = c_cpu_y_d->size[0];
            c_cpu_y_d->size[0] = ns + 1;
            emxEnsureCapacity_real_T(c_cpu_y_d, i, &rb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(c_cpu_y_d, &b_gpu_y_d);
            i = b_cpu_y_colidx->size[0];
            b_cpu_y_colidx->size[0] = thism + 1;
            emxEnsureCapacity_int32_T(b_cpu_y_colidx, i, &qb_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_cpu_y_colidx, &gpu_y_colidx);
            i = c_cpu_y_rowidx->size[0];
            c_cpu_y_rowidx->size[0] = ns + 1;
            emxEnsureCapacity_int32_T(c_cpu_y_rowidx, i, &rb_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(c_cpu_y_rowidx, &b_gpu_y_rowidx);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel37<<<grid, block>>>(ns, b_gpu_y_rowidx,
                b_gpu_y_d);
              c_y_d_dirtyOnGpu = true;
              c_y_rowidx_dirtyOnGpu = true;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (thism), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel38<<<grid, block>>>(thism, gpu_y_colidx);
            }

            vlen = b_cpu_y_colidx->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen
              - 1L), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel39<<<grid, block>>>(vlen, gpu_y_colidx);
            }

            ecc_filtfilt_kernel40<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (gpu_y_colidx, b_cpu_y_colidx->size[0U]);
            nZeroLastDen_data_dirtyOnGpu = true;
            ns = b_cpu_y_colidx->size[0];
            i = b_cpu_y_colidx->size[0];
            b_cpu_y_colidx->size[0] = ns;
            emxEnsureCapacity_int32_T(b_cpu_y_colidx, i, &rb_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_cpu_y_colidx, &gpu_y_colidx);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel41<<<grid, block>>>(ns, gpu_y_colidx);
            }

            vlen = y_colidx->data[y_colidx->size[0] - 1];
            for (iv0 = 0; iv0 <= vlen - 2; iv0++) {
              if (nZeroLastDen_data_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_y_colidx, &gpu_y_colidx);
              }

              if (y_rowidx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
              }

              y_rowidx_dirtyOnGpu = false;
              b_cpu_y_colidx->data[cpu_y_rowidx->data[iv0]]++;
              nZeroLastDen_data_dirtyOnGpu = false;
            }

            if (nZeroLastDen_data_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_y_colidx, &gpu_y_colidx);
            }

            b_cpu_y_colidx->data[0] = 1;
            for (iv0 = 0; iv0 < thism; iv0++) {
              b_cpu_y_colidx->data[iv0 + 1] += b_cpu_y_colidx->data[iv0];
            }

            i = b_cpu_counts->size[0];
            b_cpu_counts->size[0] = thism;
            emxEnsureCapacity_int32_T(b_cpu_counts, i, &wb_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_cpu_counts, &gpu_counts);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (thism), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel42<<<grid, block>>>(thism, gpu_counts);
              b_counts_dirtyOnGpu = true;
            }

            for (c = 0; c <= x; c++) {
              ns = y_colidx->data[c];
              vlen = y_colidx->data[c + 1];
              b = computeEndIdx(static_cast<int64_T>(ns), static_cast<int64_T>
                                (vlen - 1), 1L);
              for (int64_T b_idx{0L}; b_idx <= b; b_idx++) {
                if (b_counts_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_counts, &gpu_counts);
                }

                if (y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
                }

                nfilt = (b_cpu_counts->data[cpu_y_rowidx->data
                         [static_cast<int32_T>(ns + b_idx) - 1] - 1] +
                         b_cpu_y_colidx->data[cpu_y_rowidx->data[static_cast<
                         int32_T>(ns + b_idx) - 1] - 1]) - 1;
                if (c_y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_cpu_y_d, &b_gpu_y_d);
                }

                if (y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_y_d, &gpu_y_d);
                }

                y_d_dirtyOnGpu = false;
                c_cpu_y_d->data[nfilt] = cpu_y_d->data[static_cast<int32_T>(ns +
                  b_idx) - 1];
                c_y_d_dirtyOnGpu = false;
                if (c_y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(c_cpu_y_rowidx, &b_gpu_y_rowidx);
                }

                c_cpu_y_rowidx->data[nfilt] = c + 1;
                c_y_rowidx_dirtyOnGpu = false;
                y_rowidx_dirtyOnGpu = false;
                b_cpu_counts->data[cpu_y_rowidx->data[static_cast<int32_T>(ns +
                  b_idx) - 1] - 1]++;
                b_counts_dirtyOnGpu = false;
              }
            }

            if (c_y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(c_cpu_y_rowidx, &b_gpu_y_rowidx);
            }

            if (c_y_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_cpu_y_d, &b_gpu_y_d);
            }

            b_cxA = makeCXSparseMatrix(b_cpu_y_colidx->data[b_cpu_y_colidx->
              size[0] - 1] - 1, thism, cpu_cidxInt->data[cpu_cidxInt->size[0] -
              1], &b_cpu_y_colidx->data[0], &c_cpu_y_rowidx->data[0],
              &c_cpu_y_d->data[0]);
          } else {
            if (y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
            }

            y_rowidx_dirtyOnGpu = false;
            if (y_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_y_d, &gpu_y_d);
            }

            y_d_dirtyOnGpu = false;
            b_cxA = makeCXSparseMatrix(y_colidx->data[y_colidx->size[0] - 1] - 1,
              cpu_cidxInt->data[cpu_cidxInt->size[0] - 1], thism,
              &y_colidx->data[0], &cpu_y_rowidx->data[0], &cpu_y_d->data[0]);
          }

          b_S = cs_di_sqr(2, b_cxA, 0);
          b_N = cs_di_lu(b_cxA, b_S, 1);
          cs_di_spfree(b_cxA);
          if (b_N == nullptr) {
            cs_di *c_cxA;
            cs_din *c_N;
            cs_dis *c_S;
            coder::internal::c_warning();
            cs_di_sfree(b_S);
            cs_di_nfree(b_N);
            if (thism < cpu_cidxInt->data[cpu_cidxInt->size[0] - 1]) {
              if (y_colidx->data[y_colidx->size[0] - 1] - 1 >= 1) {
                ns = y_colidx->data[y_colidx->size[0] - 1] - 2;
              } else {
                ns = 0;
              }

              i = d_cpu_y_d->size[0];
              d_cpu_y_d->size[0] = ns + 1;
              emxEnsureCapacity_real_T(d_cpu_y_d, i, &rb_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(d_cpu_y_d, &c_gpu_y_d);
              i = c_cpu_y_colidx->size[0];
              c_cpu_y_colidx->size[0] = thism + 1;
              emxEnsureCapacity_int32_T(c_cpu_y_colidx, i, &qb_emlrtRTEI);
              gpuEmxEnsureCapacity_int32_T(c_cpu_y_colidx, &b_gpu_y_colidx);
              i = d_cpu_y_rowidx->size[0];
              d_cpu_y_rowidx->size[0] = ns + 1;
              emxEnsureCapacity_int32_T(d_cpu_y_rowidx, i, &rb_emlrtRTEI);
              gpuEmxEnsureCapacity_int32_T(d_cpu_y_rowidx, &c_gpu_y_rowidx);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns
                + 1L), &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel44<<<grid, block>>>(ns, c_gpu_y_rowidx,
                  c_gpu_y_d);
                d_y_d_dirtyOnGpu = true;
                d_y_rowidx_dirtyOnGpu = true;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (thism), &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel45<<<grid, block>>>(thism, b_gpu_y_colidx);
              }

              vlen = c_cpu_y_colidx->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (vlen - 1L), &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel46<<<grid, block>>>(vlen, b_gpu_y_colidx);
              }

              ecc_filtfilt_kernel47<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (b_gpu_y_colidx, c_cpu_y_colidx->size[0U]);
              nZeroLastDen_data_dirtyOnGpu = true;
              ns = c_cpu_y_colidx->size[0];
              i = c_cpu_y_colidx->size[0];
              c_cpu_y_colidx->size[0] = ns;
              emxEnsureCapacity_int32_T(c_cpu_y_colidx, i, &rb_emlrtRTEI);
              gpuEmxEnsureCapacity_int32_T(c_cpu_y_colidx, &b_gpu_y_colidx);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
                &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel48<<<grid, block>>>(ns, b_gpu_y_colidx);
              }

              vlen = y_colidx->data[y_colidx->size[0] - 1];
              for (iv0 = 0; iv0 <= vlen - 2; iv0++) {
                if (nZeroLastDen_data_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(c_cpu_y_colidx, &b_gpu_y_colidx);
                }

                if (y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
                }

                y_rowidx_dirtyOnGpu = false;
                c_cpu_y_colidx->data[cpu_y_rowidx->data[iv0]]++;
                nZeroLastDen_data_dirtyOnGpu = false;
              }

              if (nZeroLastDen_data_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(c_cpu_y_colidx, &b_gpu_y_colidx);
              }

              c_cpu_y_colidx->data[0] = 1;
              for (iv0 = 0; iv0 < thism; iv0++) {
                c_cpu_y_colidx->data[iv0 + 1] += c_cpu_y_colidx->data[iv0];
              }

              i = c_cpu_counts->size[0];
              c_cpu_counts->size[0] = thism;
              emxEnsureCapacity_int32_T(c_cpu_counts, i, &wb_emlrtRTEI);
              gpuEmxEnsureCapacity_int32_T(c_cpu_counts, &b_gpu_counts);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                (thism), &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel49<<<grid, block>>>(thism, b_gpu_counts);
                c_counts_dirtyOnGpu = true;
              }

              for (c = 0; c <= x; c++) {
                ns = y_colidx->data[c];
                vlen = y_colidx->data[c + 1];
                b = computeEndIdx(static_cast<int64_T>(ns), static_cast<int64_T>
                                  (vlen - 1), 1L);
                for (int64_T b_idx{0L}; b_idx <= b; b_idx++) {
                  if (c_counts_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_int32_T(c_cpu_counts, &b_gpu_counts);
                  }

                  if (y_rowidx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
                  }

                  nfilt = (c_cpu_counts->data[cpu_y_rowidx->data
                           [static_cast<int32_T>(ns + b_idx) - 1] - 1] +
                           c_cpu_y_colidx->data[cpu_y_rowidx->data[static_cast<
                           int32_T>(ns + b_idx) - 1] - 1]) - 1;
                  if (d_y_d_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(d_cpu_y_d, &c_gpu_y_d);
                  }

                  if (y_d_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(cpu_y_d, &gpu_y_d);
                  }

                  y_d_dirtyOnGpu = false;
                  d_cpu_y_d->data[nfilt] = cpu_y_d->data[static_cast<int32_T>(ns
                    + b_idx) - 1];
                  d_y_d_dirtyOnGpu = false;
                  if (d_y_rowidx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_int32_T(d_cpu_y_rowidx, &c_gpu_y_rowidx);
                  }

                  d_cpu_y_rowidx->data[nfilt] = c + 1;
                  d_y_rowidx_dirtyOnGpu = false;
                  y_rowidx_dirtyOnGpu = false;
                  c_cpu_counts->data[cpu_y_rowidx->data[static_cast<int32_T>(ns
                    + b_idx) - 1] - 1]++;
                  c_counts_dirtyOnGpu = false;
                }
              }

              if (d_y_rowidx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(d_cpu_y_rowidx, &c_gpu_y_rowidx);
              }

              if (d_y_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(d_cpu_y_d, &c_gpu_y_d);
              }

              c_cxA = makeCXSparseMatrix(c_cpu_y_colidx->data
                [c_cpu_y_colidx->size[0] - 1] - 1, thism, cpu_cidxInt->
                data[cpu_cidxInt->size[0] - 1], &c_cpu_y_colidx->data[0],
                &d_cpu_y_rowidx->data[0], &d_cpu_y_d->data[0]);
            } else {
              if (y_rowidx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
              }

              if (y_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_y_d, &gpu_y_d);
              }

              c_cxA = makeCXSparseMatrix(y_colidx->data[y_colidx->size[0] - 1] -
                1, cpu_cidxInt->data[cpu_cidxInt->size[0] - 1], thism,
                &y_colidx->data[0], &cpu_y_rowidx->data[0], &cpu_y_d->data[0]);
            }

            c_S = cs_di_sqr(2, c_cxA, 1);
            c_N = cs_di_qr(c_cxA, c_S);
            cs_di_spfree(c_cxA);
            qr_rank_di(c_N, &val);
            i = cpu_zi->size[0];
            cpu_zi->size[0] = cpu_cidxInt->data[cpu_cidxInt->size[0] - 1];
            emxEnsureCapacity_real_T(cpu_zi, i, &tb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_zi, &gpu_zi);
            if (cpu_rhs->size[0] < cpu_cidxInt->data[cpu_cidxInt->size[0] - 1])
            {
              i = b_cpu_outBuff->size[0];
              b_cpu_outBuff->size[0] = cpu_cidxInt->data[cpu_cidxInt->size[0] -
                1];
              emxEnsureCapacity_real_T(b_cpu_outBuff, i, &vb_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(b_cpu_outBuff, &gpu_outBuff);
            } else {
              i = b_cpu_outBuff->size[0];
              b_cpu_outBuff->size[0] = cpu_rhs->size[0];
              emxEnsureCapacity_real_T(b_cpu_outBuff, i, &ub_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(b_cpu_outBuff, &gpu_outBuff);
            }

            ecc_filtfilt_kernel50<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (*e_gpu_x, cpu_rhs->size[0U]);
            cudaMemcpy(e_cpu_x, *e_gpu_x, 8UL, cudaMemcpyDeviceToHost);
            x = e_cpu_x[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x +
              1L), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel51<<<grid, block>>>(b_gpu_rhs, e_cpu_x[1] - 1,
                gpu_outBuff);
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_outBuff, &gpu_outBuff);
            }

            solve_from_qr_di(c_N, c_S, (double *)&b_cpu_outBuff->data[0],
                             cpu_rhs->size[0], cpu_cidxInt->data
                             [cpu_cidxInt->size[0] - 1]);
            i = cpu_cidxInt->data[cpu_cidxInt->size[0] - 1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_outBuff, b_cpu_outBuff);
              ecc_filtfilt_kernel52<<<grid, block>>>(gpu_outBuff, i, gpu_zi);
            }

            cs_di_sfree(c_S);
            cs_di_nfree(c_N);
          } else {
            i = cpu_zi->size[0];
            cpu_zi->size[0] = cpu_rhs->size[0];
            emxEnsureCapacity_real_T(cpu_zi, i, &sb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_zi, &gpu_zi);
            iv0 = cpu_rhs->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0
              + 1L), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel43<<<grid, block>>>(b_gpu_rhs, iv0, gpu_zi);
              gpuEmxMemcpyGpuToCpu_real_T(cpu_zi, &gpu_zi);
            }

            solve_from_lu_di(b_N, b_S, (double *)&cpu_zi->data[0], cpu_rhs->
                             size[0]);
            zi_dirtyOnCpu = true;
            cs_di_sfree(b_S);
            cs_di_nfree(b_N);
          }
        } else {
          cs_di *cxA;
          cs_din *N;
          cs_dis *S;
          if (thism < cpu_cidxInt->data[cpu_cidxInt->size[0] - 1]) {
            if (y_colidx->data[y_colidx->size[0] - 1] - 1 >= 1) {
              ns = y_colidx->data[y_colidx->size[0] - 1] - 2;
            } else {
              ns = 0;
            }

            i = b_cpu_y_d->size[0];
            b_cpu_y_d->size[0] = ns + 1;
            emxEnsureCapacity_real_T(b_cpu_y_d, i, &rb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_cpu_y_d, &d_gpu_y_d);
            i = cpu_y_colidx->size[0];
            cpu_y_colidx->size[0] = thism + 1;
            emxEnsureCapacity_int32_T(cpu_y_colidx, i, &qb_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(cpu_y_colidx, &c_gpu_y_colidx);
            i = b_cpu_y_rowidx->size[0];
            b_cpu_y_rowidx->size[0] = ns + 1;
            emxEnsureCapacity_int32_T(b_cpu_y_rowidx, i, &rb_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_cpu_y_rowidx, &d_gpu_y_rowidx);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel28<<<grid, block>>>(ns, d_gpu_y_rowidx,
                d_gpu_y_d);
              b_y_d_dirtyOnGpu = true;
              b_y_rowidx_dirtyOnGpu = true;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (thism), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel29<<<grid, block>>>(thism, c_gpu_y_colidx);
            }

            vlen = cpu_y_colidx->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen
              - 1L), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel30<<<grid, block>>>(vlen, c_gpu_y_colidx);
            }

            ecc_filtfilt_kernel31<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (c_gpu_y_colidx, cpu_y_colidx->size[0U]);
            nZeroLastDen_data_dirtyOnGpu = true;
            ns = cpu_y_colidx->size[0];
            i = cpu_y_colidx->size[0];
            cpu_y_colidx->size[0] = ns;
            emxEnsureCapacity_int32_T(cpu_y_colidx, i, &rb_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(cpu_y_colidx, &c_gpu_y_colidx);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel32<<<grid, block>>>(ns, c_gpu_y_colidx);
            }

            vlen = y_colidx->data[y_colidx->size[0] - 1];
            for (iv0 = 0; iv0 <= vlen - 2; iv0++) {
              if (nZeroLastDen_data_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_colidx, &c_gpu_y_colidx);
              }

              if (y_rowidx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
              }

              y_rowidx_dirtyOnGpu = false;
              cpu_y_colidx->data[cpu_y_rowidx->data[iv0]]++;
              nZeroLastDen_data_dirtyOnGpu = false;
            }

            if (nZeroLastDen_data_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_colidx, &c_gpu_y_colidx);
            }

            cpu_y_colidx->data[0] = 1;
            for (iv0 = 0; iv0 < thism; iv0++) {
              cpu_y_colidx->data[iv0 + 1] += cpu_y_colidx->data[iv0];
            }

            i = cpu_counts->size[0];
            cpu_counts->size[0] = thism;
            emxEnsureCapacity_int32_T(cpu_counts, i, &wb_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(cpu_counts, &c_gpu_counts);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (thism), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel33<<<grid, block>>>(thism, c_gpu_counts);
              counts_dirtyOnGpu = true;
            }

            for (c = 0; c <= x; c++) {
              int64_T b;
              ns = y_colidx->data[c];
              vlen = y_colidx->data[c + 1];
              b = computeEndIdx(static_cast<int64_T>(ns), static_cast<int64_T>
                                (vlen - 1), 1L);
              for (int64_T b_idx{0L}; b_idx <= b; b_idx++) {
                if (counts_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(cpu_counts, &c_gpu_counts);
                }

                if (y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
                }

                nfilt = (cpu_counts->data[cpu_y_rowidx->data[static_cast<int32_T>
                         (ns + b_idx) - 1] - 1] + cpu_y_colidx->
                         data[cpu_y_rowidx->data[static_cast<int32_T>(ns + b_idx)
                         - 1] - 1]) - 1;
                if (b_y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_cpu_y_d, &d_gpu_y_d);
                }

                if (y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(cpu_y_d, &gpu_y_d);
                }

                y_d_dirtyOnGpu = false;
                b_cpu_y_d->data[nfilt] = cpu_y_d->data[static_cast<int32_T>(ns +
                  b_idx) - 1];
                b_y_d_dirtyOnGpu = false;
                if (b_y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_y_rowidx, &d_gpu_y_rowidx);
                }

                b_cpu_y_rowidx->data[nfilt] = c + 1;
                b_y_rowidx_dirtyOnGpu = false;
                y_rowidx_dirtyOnGpu = false;
                cpu_counts->data[cpu_y_rowidx->data[static_cast<int32_T>(ns +
                  b_idx) - 1] - 1]++;
                counts_dirtyOnGpu = false;
              }
            }

            if (b_y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(b_cpu_y_rowidx, &d_gpu_y_rowidx);
            }

            if (b_y_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_y_d, &d_gpu_y_d);
            }

            cxA = makeCXSparseMatrix(cpu_y_colidx->data[cpu_y_colidx->size[0] -
              1] - 1, thism, cpu_cidxInt->data[cpu_cidxInt->size[0] - 1],
              &cpu_y_colidx->data[0], &b_cpu_y_rowidx->data[0], &b_cpu_y_d->
              data[0]);
          } else {
            if (y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(cpu_y_rowidx, &gpu_y_rowidx);
            }

            if (y_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_y_d, &gpu_y_d);
            }

            cxA = makeCXSparseMatrix(y_colidx->data[y_colidx->size[0] - 1] - 1,
              cpu_cidxInt->data[cpu_cidxInt->size[0] - 1], thism,
              &y_colidx->data[0], &cpu_y_rowidx->data[0], &cpu_y_d->data[0]);
          }

          S = cs_di_sqr(2, cxA, 1);
          N = cs_di_qr(cxA, S);
          cs_di_spfree(cxA);
          ns = qr_rank_di(N, &val);
          if (thism > cpu_cidxInt->data[cpu_cidxInt->size[0] - 1]) {
            thism = cpu_cidxInt->data[cpu_cidxInt->size[0] - 1];
          }

          if (ns < thism) {
            char_T str[14];
            y = nullptr;
            m = emlrtCreateCharArray(2, &iv7[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 6, m, &rfmt[0]);
            emlrtAssign(&y, m);
            b_y = nullptr;
            m1 = emlrtCreateDoubleScalar(val);
            emlrtAssign(&b_y, m1);
            emlrt_marshallIn(b_sprintf(y, b_y, &c_emlrtMCI),
                             "<output of sprintf>", str);
            coder::internal::warning(ns, str);
          }

          i = cpu_zi->size[0];
          cpu_zi->size[0] = cpu_cidxInt->data[cpu_cidxInt->size[0] - 1];
          emxEnsureCapacity_real_T(cpu_zi, i, &tb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_zi, &gpu_zi);
          if (cpu_rhs->size[0] < cpu_cidxInt->data[cpu_cidxInt->size[0] - 1]) {
            i = cpu_outBuff->size[0];
            cpu_outBuff->size[0] = cpu_cidxInt->data[cpu_cidxInt->size[0] - 1];
            emxEnsureCapacity_real_T(cpu_outBuff, i, &vb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_outBuff, &b_gpu_outBuff);
          } else {
            i = cpu_outBuff->size[0];
            cpu_outBuff->size[0] = cpu_rhs->size[0];
            emxEnsureCapacity_real_T(cpu_outBuff, i, &ub_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(cpu_outBuff, &b_gpu_outBuff);
          }

          ecc_filtfilt_kernel34<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (*e_gpu_x, cpu_rhs->size[0U]);
          cudaMemcpy(e_cpu_x, *e_gpu_x, 8UL, cudaMemcpyDeviceToHost);
          x = e_cpu_x[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x + 1L),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel35<<<grid, block>>>(b_gpu_rhs, e_cpu_x[1] - 1,
              b_gpu_outBuff);
            gpuEmxMemcpyGpuToCpu_real_T(cpu_outBuff, &b_gpu_outBuff);
          }

          solve_from_qr_di(N, S, (double *)&cpu_outBuff->data[0], cpu_rhs->size
                           [0], cpu_cidxInt->data[cpu_cidxInt->size[0] - 1]);
          i = cpu_cidxInt->data[cpu_cidxInt->size[0] - 1];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_outBuff, cpu_outBuff);
            ecc_filtfilt_kernel36<<<grid, block>>>(b_gpu_outBuff, i, gpu_zi);
          }

          cs_di_sfree(S);
          cs_di_nfree(N);
        }
      } else {
        cpu_zi->size[0] = 0;
      }
    }

    if (cpu_x->size[1] == 1) {
      if (cpu_x->size[0] < 10000) {
        dim3 r;
        dim3 r1;
        int32_T b_na;
        int32_T b_nb;
        int32_T na;
        int32_T nb;
        uint32_T OH;
        uint32_T u;
        i = cpu_yCol->size[0];
        cpu_yCol->size[0] = cpu_x->size[0];
        emxEnsureCapacity_real_T(cpu_yCol, i, &l_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_yCol, &gpu_yCol);
        x = cpu_x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
          x_dirtyOnCpu = false;
          ecc_filtfilt_kernel244<<<grid, block>>>(b_gpu_x, x, gpu_yCol);
          yCol_dirtyOnGpu = true;
        }

        csz_idx_0 = static_cast<int32_T>(nfact + 1.0) - 2;
        na = cpu_a2->size[0];
        nb = cpu_b2->size[0];
        b_na = cpu_a2->size[0];
        b_nb = cpu_b2->size[0];
        ecc_filtfilt_kernel245<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
          gpu_a1, b_gpu_a1);
        val = static_cast<real_T>(cpu_yCol->size[0]) - nfact;
        if (val > static_cast<real_T>(cpu_yCol->size[0]) - 1.0) {
          ns = 0;
          nfilt = 1;
          idx = -1;
        } else {
          ns = cpu_yCol->size[0] - 2;
          nfilt = -1;
          idx = static_cast<int32_T>(val) - 1;
        }

        ecc_filtfilt_kernel246<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_yCol,
          gpu_d);
        if (yCol_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_yCol, &gpu_yCol);
        }

        val = 2.0 * cpu_yCol->data[cpu_yCol->size[0] - 1];
        iv0 = cpu_ytemp->size[0];
        cpu_ytemp->size[0] = (static_cast<int32_T>(nfact + 1.0) + cpu_yCol->
                              size[0]) + div_s32(idx - ns, nfilt);
        emxEnsureCapacity_real_T(cpu_ytemp, iv0, &u_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_ytemp, &gpu_ytemp);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (csz_idx_0 + 1L), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel247<<<grid, block>>>(gpu_yCol, static_cast<int32_T>
            (nfact + 1.0) - 1, gpu_d, static_cast<int32_T>(nfact + 1.0) - 2,
            gpu_ytemp);
          ytemp_dirtyOnGpu = true;
        }

        vlen = cpu_yCol->size[0];
        for (iv0 = 0; iv0 < vlen; iv0++) {
          if (ytemp_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_ytemp, &gpu_ytemp);
          }

          cpu_ytemp->data[(iv0 + static_cast<int32_T>(nfact + 1.0)) - 1] =
            cpu_yCol->data[iv0];
          ytemp_dirtyOnCpu = true;
          ytemp_dirtyOnGpu = false;
        }

        vlen = div_s32(idx - ns, nfilt);
        for (iv0 = 0; iv0 <= vlen; iv0++) {
          if (ytemp_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_ytemp, &gpu_ytemp);
          }

          cpu_ytemp->data[((iv0 + static_cast<int32_T>(nfact + 1.0)) +
                           cpu_yCol->size[0]) - 1] = val - cpu_yCol->data[ns +
            nfilt * iv0];
          ytemp_dirtyOnCpu = true;
          ytemp_dirtyOnGpu = false;
        }

        if (ytemp_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_ytemp, &gpu_ytemp);
        }

        val = cpu_ytemp->data[0];
        iv0 = h_cpu_y->size[0];
        h_cpu_y->size[0] = cpu_zi->size[0];
        emxEnsureCapacity_real_T(h_cpu_y, iv0, &w_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_cpu_y, &b_gpu_y);
        iv0 = cpu_zi->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (zi_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, cpu_zi);
          }

          zi_dirtyOnCpu = false;
          ecc_filtfilt_kernel248<<<grid, block>>>(val, gpu_zi, iv0, b_gpu_y);
        }

        iv0 = b_cpu_b->size[0];
        b_cpu_b->size[0] = cpu_b2->size[0];
        emxEnsureCapacity_real_T(b_cpu_b, iv0, &l_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_b, &gpu_b);
        iv0 = cpu_b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel249<<<grid, block>>>(gpu_b2, iv0, gpu_b);
          b_b_dirtyOnGpu = true;
        }

        iv0 = b_cpu_a->size[0];
        b_cpu_a->size[0] = cpu_a2->size[0];
        emxEnsureCapacity_real_T(b_cpu_a, iv0, &l_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_a, &gpu_a);
        iv0 = cpu_a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel250<<<grid, block>>>(gpu_a2, iv0, gpu_a);
          b_a_dirtyOnGpu = true;
        }

        gpuEmxMemcpyGpuToCpu_real_T(cpu_a2, &gpu_a2);
        if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
            (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nb),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel251<<<grid, block>>>(b_gpu_a1, nb, gpu_b);
            b_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na -
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel252<<<grid, block>>>(b_gpu_a1, na, gpu_a);
          }

          ecc_filtfilt_kernel253<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a);
          b_a_dirtyOnGpu = true;
        }

        if (b_cpu_a->size[0] > b_cpu_b->size[0]) {
          vlen = b_cpu_a->size[0] - b_cpu_b->size[0];
          iv0 = b_cpu_b->size[0];
          ns = b_cpu_b->size[0];
          b_cpu_b->size[0] = b_cpu_a->size[0];
          emxEnsureCapacity_real_T(b_cpu_b, ns, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_b, &gpu_b);
          if (vlen - 1 >= 0) {
            if (b_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_b, &gpu_b);
            }

            std::memset(&b_cpu_b->data[iv0], 0, static_cast<uint32_T>(vlen) *
                        sizeof(real_T));
            b_b_dirtyOnCpu = true;
          }
        }

        cpu_dv1[0] = static_cast<uint32_T>(b_cpu_b->size[0]);
        OH = (static_cast<uint32_T>(cpu_ytemp->size[0]) + static_cast<uint32_T>
              (b_cpu_b->size[0])) - 1U;
        x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = b_cpu_b->size[0];
        vlen = static_cast<int32_T>(std::floor(static_cast<real_T>(b_cpu_b->
          size[0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (b_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (b_cpu_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = static_cast<int32_T>(u) + b_cpu_b->size[0];
        }

        iv0 = b_cpu_expanded->size[0];
        b_cpu_expanded->size[0] = nfilt - 1;
        emxEnsureCapacity_real_T(b_cpu_expanded, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_expanded, &gpu_expanded);
        na = (static_cast<int32_T>(u) + static_cast<int32_T>(cpu_dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel254<<<grid, block>>>(na, gpu_expanded);
        }

        ns = cpu_ytemp->size[0];
        iv0 = k_cpu_y->size[0] * k_cpu_y->size[1];
        k_cpu_y->size[0] = 1;
        k_cpu_y->size[1] = cpu_ytemp->size[0];
        emxEnsureCapacity_int32_T(k_cpu_y, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(k_cpu_y, &c_gpu_y);
        k_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= ns - 2; iv0++) {
          nfilt++;
          k_cpu_y->data[iv0 + 1] = nfilt;
        }

        iv0 = k_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (ytemp_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_ytemp, cpu_ytemp);
          }

          gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_y, k_cpu_y);
          ecc_filtfilt_kernel255<<<grid, block>>>(gpu_ytemp, vlen, c_gpu_y, iv0,
            gpu_expanded);
        }

        iv0 = c_cpu_rows->size[0] * c_cpu_rows->size[1];
        c_cpu_rows->size[0] = 1;
        c_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
        emxEnsureCapacity_int32_T(c_cpu_rows, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(c_cpu_rows, &gpu_rows);
        c_cpu_rows->data[0] = 0;
        nfilt = 0;
        for (iv0 = 0; iv0 <= thism - 2; iv0++) {
          nfilt++;
          c_cpu_rows->data[iv0 + 1] = nfilt;
        }

        iv0 = b_cpu_convOut->size[0];
        b_cpu_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(b_cpu_convOut, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_convOut, &gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(x) - 1.0)) / static_cast<real_T>(x))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(x), 1U, 1U);
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
          static_cast<int32_T>(u)), r, r1, &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, c_cpu_rows);
          if (b_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, b_cpu_b);
          }

          ecc_filtfilt_kernel256<<<grid, block>>>(gpu_expanded, gpu_rows, gpu_b,
            static_cast<int32_T>(u), gpu_convOut, b_cpu_b->size[0U]);
          b_convOut_dirtyOnGpu = true;
        }

        if (h_cpu_y->size[0] != 0) {
          if (h_cpu_y->size[0] == 1) {
            ecc_filtfilt_kernel258<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (b_gpu_y, gpu_convOut);
            b_convOut_dirtyOnGpu = true;
          } else {
            ns = h_cpu_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel257<<<grid, block>>>(b_gpu_y, ns, gpu_convOut);
              b_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = cpu_ytemp->size[0] + b_cpu_a->size[0];
        for (x = 0; x <= ns - 2; x++) {
          nfilt = static_cast<int32_T>(std::fmin(static_cast<real_T>(x) + 1.0,
            static_cast<real_T>(b_cpu_a->size[0])));
          for (vlen = 0; vlen <= nfilt - 2; vlen++) {
            if (b_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_convOut, &gpu_convOut);
            }

            if (b_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_a, &gpu_a);
            }

            b_a_dirtyOnGpu = false;
            b_cpu_convOut->data[x] -= b_cpu_convOut->data[(x - vlen) - 1] *
              b_cpu_a->data[vlen + 1];
            b_convOut_dirtyOnCpu = true;
            b_convOut_dirtyOnGpu = false;
          }
        }

        cpu_zfSize[0] = static_cast<uint32_T>(cpu_ytemp->size[0]);
        if (b_convOut_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(b_cpu_convOut, &gpu_convOut);
        }

        val = b_cpu_convOut->data[cpu_ytemp->size[0] - 1];
        iv0 = p_cpu_y->size[0];
        p_cpu_y->size[0] = cpu_zi->size[0];
        emxEnsureCapacity_real_T(p_cpu_y, iv0, &w_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(p_cpu_y, &d_gpu_y);
        iv0 = cpu_zi->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (zi_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, cpu_zi);
          }

          ecc_filtfilt_kernel259<<<grid, block>>>(val, gpu_zi, iv0, d_gpu_y);
        }

        iv0 = f_cpu_b->size[0];
        f_cpu_b->size[0] = cpu_b2->size[0];
        emxEnsureCapacity_real_T(f_cpu_b, iv0, &l_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_cpu_b, &b_gpu_b);
        iv0 = cpu_b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel260<<<grid, block>>>(gpu_b2, iv0, b_gpu_b);
          f_b_dirtyOnGpu = true;
        }

        iv0 = f_cpu_a->size[0];
        f_cpu_a->size[0] = cpu_a2->size[0];
        emxEnsureCapacity_real_T(f_cpu_a, iv0, &l_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_cpu_a, &b_gpu_a);
        iv0 = cpu_a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel261<<<grid, block>>>(gpu_a2, iv0, b_gpu_a);
          d_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
            (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_nb),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel262<<<grid, block>>>(gpu_a1, b_nb, b_gpu_b);
            f_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_na -
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel263<<<grid, block>>>(gpu_a1, b_na, b_gpu_a);
          }

          ecc_filtfilt_kernel264<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (b_gpu_a);
          d_a_dirtyOnGpu = true;
        }

        if (f_cpu_a->size[0] > f_cpu_b->size[0]) {
          vlen = f_cpu_a->size[0] - f_cpu_b->size[0];
          iv0 = f_cpu_b->size[0];
          ns = f_cpu_b->size[0];
          f_cpu_b->size[0] = f_cpu_a->size[0];
          emxEnsureCapacity_real_T(f_cpu_b, ns, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_cpu_b, &b_gpu_b);
          if (vlen - 1 >= 0) {
            if (f_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_cpu_b, &b_gpu_b);
            }

            std::memset(&f_cpu_b->data[iv0], 0, static_cast<uint32_T>(vlen) *
                        sizeof(real_T));
            f_b_dirtyOnCpu = true;
          }
        }

        cpu_dv1[0] = static_cast<uint32_T>(f_cpu_b->size[0]);
        OH = (cpu_zfSize[0] + static_cast<uint32_T>(f_cpu_b->size[0])) - 1U;
        x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = f_cpu_b->size[0];
        vlen = static_cast<int32_T>(std::floor(static_cast<real_T>(f_cpu_b->
          size[0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (f_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (f_cpu_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = static_cast<int32_T>(u) + f_cpu_b->size[0];
        }

        iv0 = e_cpu_expanded->size[0];
        e_cpu_expanded->size[0] = nfilt - 1;
        emxEnsureCapacity_real_T(e_cpu_expanded, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_cpu_expanded, &b_gpu_expanded);
        na = (static_cast<int32_T>(u) + static_cast<int32_T>(cpu_dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel265<<<grid, block>>>(na, b_gpu_expanded);
        }

        ns = static_cast<int32_T>(cpu_zfSize[0]);
        iv0 = t_cpu_y->size[0] * t_cpu_y->size[1];
        t_cpu_y->size[0] = 1;
        t_cpu_y->size[1] = static_cast<int32_T>(cpu_zfSize[0]);
        emxEnsureCapacity_int32_T(t_cpu_y, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(t_cpu_y, &e_gpu_y);
        t_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= ns - 2; iv0++) {
          nfilt++;
          t_cpu_y->data[iv0 + 1] = nfilt;
        }

        iv0 = cpu_iv8->size[0];
        cpu_iv8->size[0] = t_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv8, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv8, &gpu_iv8);
        iv0 = t_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&e_gpu_y, t_cpu_y);
          ecc_filtfilt_kernel266<<<grid, block>>>(vlen, e_gpu_y, iv0, gpu_iv8);
        }

        iv0 = static_cast<int32_T>(cpu_zfSize[0]);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
          static_cast<int32_T>(cpu_zfSize[0])), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_convOut, b_cpu_convOut);
          }

          ecc_filtfilt_kernel267<<<grid, block>>>(gpu_convOut, iv0, gpu_iv8,
            static_cast<int32_T>(cpu_zfSize[0]), b_gpu_expanded);
        }

        iv0 = f_cpu_rows->size[0] * f_cpu_rows->size[1];
        f_cpu_rows->size[0] = 1;
        f_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
        emxEnsureCapacity_int32_T(f_cpu_rows, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(f_cpu_rows, &b_gpu_rows);
        f_cpu_rows->data[0] = 0;
        nfilt = 0;
        for (iv0 = 0; iv0 <= thism - 2; iv0++) {
          nfilt++;
          f_cpu_rows->data[iv0 + 1] = nfilt;
        }

        iv0 = e_cpu_convOut->size[0];
        e_cpu_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(e_cpu_convOut, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_cpu_convOut, &b_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(x) - 1.0)) / static_cast<real_T>(x))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(x), 1U, 1U);
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
          static_cast<int32_T>(u)), r, r1, &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_rows, f_cpu_rows);
          if (f_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, f_cpu_b);
          }

          ecc_filtfilt_kernel268<<<grid, block>>>(b_gpu_expanded, b_gpu_rows,
            b_gpu_b, static_cast<int32_T>(u), b_gpu_convOut, f_cpu_b->size[0U]);
          e_convOut_dirtyOnGpu = true;
        }

        if (p_cpu_y->size[0] != 0) {
          if (p_cpu_y->size[0] == 1) {
            ecc_filtfilt_kernel270<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (d_gpu_y, b_gpu_convOut);
            e_convOut_dirtyOnGpu = true;
          } else {
            ns = p_cpu_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel269<<<grid, block>>>(d_gpu_y, ns, b_gpu_convOut);
              e_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = static_cast<int32_T>(cpu_zfSize[0]) + f_cpu_a->size[0];
        for (x = 0; x <= ns - 2; x++) {
          nfilt = static_cast<int32_T>(std::fmin(static_cast<real_T>(x) + 1.0,
            static_cast<real_T>(f_cpu_a->size[0])));
          for (vlen = 0; vlen <= nfilt - 2; vlen++) {
            if (e_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_cpu_convOut, &b_gpu_convOut);
            }

            if (d_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_cpu_a, &b_gpu_a);
            }

            d_a_dirtyOnGpu = false;
            e_cpu_convOut->data[x] -= e_cpu_convOut->data[(x - vlen) - 1] *
              f_cpu_a->data[vlen + 1];
            e_convOut_dirtyOnCpu = true;
            e_convOut_dirtyOnGpu = false;
          }
        }

        val = static_cast<real_T>(cpu_zfSize[0]) - nfact;
        if (nfact + 1.0 > val) {
          ns = 1;
          nfilt = 1;
        } else {
          ns = static_cast<int32_T>(val);
          nfilt = -1;
        }

        idx = cpu_yCol->size[0];
        iv0 = cpu_yCol->size[0];
        cpu_yCol->size[0] = idx;
        emxEnsureCapacity_real_T(cpu_yCol, iv0, &l_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_yCol, &gpu_yCol);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (e_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_convOut, e_cpu_convOut);
          }

          ecc_filtfilt_kernel271<<<grid, block>>>(b_gpu_convOut, nfilt, ns, idx,
            gpu_yCol);
        }

        e_cpu_x[0] = cpu_yCol->size[0];
        i = cpu_x->size[0] * cpu_x->size[1];
        cpu_x->size[0] = cpu_yCol->size[0];
        cpu_x->size[1] = 1;
        emxEnsureCapacity_real_T(cpu_x, i, &r_emlrtRTEI);
        if (!x_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(cpu_x, &b_gpu_x);
        }

        x = e_cpu_x[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
          }

          ecc_filtfilt_kernel272<<<grid, block>>>(gpu_yCol, e_cpu_x[0] - 1,
            b_gpu_x);
          x_dirtyOnGpu = true;
          x_dirtyOnCpu = false;
        }
      } else {
        dim3 r;
        dim3 r1;
        int32_T b_na;
        int32_T b_nb;
        int32_T c_na;
        int32_T c_nb;
        int32_T d_na;
        int32_T d_nb;
        int32_T e_na;
        int32_T e_nb;
        int32_T na;
        int32_T nb;
        int32_T zfSize_idx_0;
        uint32_T OH;
        uint32_T u;
        na = cpu_a2->size[0];
        nb = cpu_b2->size[0];
        b_na = cpu_a2->size[0];
        b_nb = cpu_b2->size[0];
        c_na = cpu_a2->size[0];
        c_nb = cpu_b2->size[0];
        d_na = cpu_a2->size[0];
        d_nb = cpu_b2->size[0];
        e_na = cpu_a2->size[0];
        e_nb = cpu_b2->size[0];
        ecc_filtfilt_kernel179<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
          c_gpu_a1, d_gpu_a1, e_gpu_a1, gpu_a1, b_gpu_a1);
        val = 2.0 * cpu_x->data[0];
        iv0 = cpu_xt->size[0];
        cpu_xt->size[0] = static_cast<int32_T>(nfact + 1.0) - 1;
        emxEnsureCapacity_real_T(cpu_xt, iv0, &s_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_xt, &gpu_xt);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
          static_cast<int32_T>(nfact + 1.0) - 1), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_d, &val, 8UL, cudaMemcpyHostToDevice);
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
          x_dirtyOnCpu = false;
          ecc_filtfilt_kernel180<<<grid, block>>>(gpu_d, b_gpu_x,
            static_cast<int32_T>(nfact + 1.0) - 1, gpu_xt);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xt, &gpu_xt);
        }

        val = cpu_xt->data[0];
        iv0 = f_cpu_y->size[0];
        f_cpu_y->size[0] = cpu_zi->size[0];
        emxEnsureCapacity_real_T(f_cpu_y, iv0, &w_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_cpu_y, &f_gpu_y);
        iv0 = cpu_zi->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (zi_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, cpu_zi);
          }

          zi_dirtyOnCpu = false;
          ecc_filtfilt_kernel181<<<grid, block>>>(val, gpu_zi, iv0, f_gpu_y);
        }

        iv0 = cpu_b->size[0];
        cpu_b->size[0] = cpu_b2->size[0];
        emxEnsureCapacity_real_T(cpu_b, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_b, &c_gpu_b);
        iv0 = cpu_b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel182<<<grid, block>>>(gpu_b2, iv0, c_gpu_b);
          b_dirtyOnGpu = true;
        }

        iv0 = cpu_a->size[0];
        cpu_a->size[0] = cpu_a2->size[0];
        emxEnsureCapacity_real_T(cpu_a, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_a, &c_gpu_a);
        iv0 = cpu_a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel183<<<grid, block>>>(gpu_a2, iv0, c_gpu_a);
          a_dirtyOnGpu = true;
        }

        gpuEmxMemcpyGpuToCpu_real_T(cpu_a2, &gpu_a2);
        if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
            (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nb),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel184<<<grid, block>>>(b_gpu_a1, nb, c_gpu_b);
            b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na -
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel185<<<grid, block>>>(b_gpu_a1, na, c_gpu_a);
          }

          ecc_filtfilt_kernel186<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (c_gpu_a);
          a_dirtyOnGpu = true;
        }

        if (cpu_a->size[0] > cpu_b->size[0]) {
          csz_idx_0 = cpu_a->size[0] - cpu_b->size[0];
          iv0 = cpu_b->size[0];
          ns = cpu_b->size[0];
          cpu_b->size[0] = cpu_a->size[0];
          emxEnsureCapacity_real_T(cpu_b, ns, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_b, &c_gpu_b);
          if (csz_idx_0 - 1 >= 0) {
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_b, &c_gpu_b);
            }

            std::memset(&cpu_b->data[iv0], 0, static_cast<uint32_T>(csz_idx_0) *
                        sizeof(real_T));
            b_dirtyOnCpu = true;
          }
        }

        zfSize_idx_0 = cpu_b->size[0] - 1;
        cpu_dv1[0] = static_cast<uint32_T>(cpu_b->size[0]);
        OH = (static_cast<uint32_T>(cpu_xt->size[0]) + static_cast<uint32_T>
              (cpu_b->size[0])) - 1U;
        x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = cpu_b->size[0];
        vlen = static_cast<int32_T>(std::floor(static_cast<real_T>(cpu_b->size[0])
          / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (cpu_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = static_cast<int32_T>(u) + cpu_b->size[0];
        }

        iv0 = cpu_expanded->size[0];
        cpu_expanded->size[0] = nfilt - 1;
        emxEnsureCapacity_real_T(cpu_expanded, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_expanded, &c_gpu_expanded);
        na = (static_cast<int32_T>(u) + static_cast<int32_T>(cpu_dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel187<<<grid, block>>>(na, c_gpu_expanded);
        }

        ns = cpu_xt->size[0];
        iv0 = j_cpu_y->size[0] * j_cpu_y->size[1];
        j_cpu_y->size[0] = 1;
        j_cpu_y->size[1] = cpu_xt->size[0];
        emxEnsureCapacity_int32_T(j_cpu_y, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(j_cpu_y, &g_gpu_y);
        j_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= ns - 2; iv0++) {
          nfilt++;
          j_cpu_y->data[iv0 + 1] = nfilt;
        }

        iv0 = j_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&g_gpu_y, j_cpu_y);
          ecc_filtfilt_kernel188<<<grid, block>>>(gpu_xt, vlen, g_gpu_y, iv0,
            c_gpu_expanded);
        }

        iv0 = b_cpu_rows->size[0] * b_cpu_rows->size[1];
        b_cpu_rows->size[0] = 1;
        b_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
        emxEnsureCapacity_int32_T(b_cpu_rows, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(b_cpu_rows, &c_gpu_rows);
        b_cpu_rows->data[0] = 0;
        nfilt = 0;
        for (iv0 = 0; iv0 <= thism - 2; iv0++) {
          nfilt++;
          b_cpu_rows->data[iv0 + 1] = nfilt;
        }

        iv0 = cpu_convOut->size[0];
        cpu_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(cpu_convOut, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_convOut, &c_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(x) - 1.0)) / static_cast<real_T>(x))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(x), 1U, 1U);
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
          static_cast<int32_T>(u)), r, r1, &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_rows, b_cpu_rows);
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, cpu_b);
          }

          ecc_filtfilt_kernel189<<<grid, block>>>(c_gpu_expanded, c_gpu_rows,
            c_gpu_b, static_cast<int32_T>(u), c_gpu_convOut, cpu_b->size[0U]);
          convOut_dirtyOnGpu = true;
        }

        if (f_cpu_y->size[0] != 0) {
          if (f_cpu_y->size[0] == 1) {
            ecc_filtfilt_kernel191<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (f_gpu_y, c_gpu_convOut);
            convOut_dirtyOnGpu = true;
          } else {
            ns = f_cpu_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel190<<<grid, block>>>(f_gpu_y, ns, c_gpu_convOut);
              convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = cpu_xt->size[0] + cpu_a->size[0];
        for (x = 0; x <= ns - 2; x++) {
          nfilt = static_cast<int32_T>(std::fmin(static_cast<real_T>(x) + 1.0,
            static_cast<real_T>(cpu_a->size[0])));
          for (vlen = 0; vlen <= nfilt - 2; vlen++) {
            if (convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_convOut, &c_gpu_convOut);
            }

            if (a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_a, &c_gpu_a);
            }

            a_dirtyOnGpu = false;
            cpu_convOut->data[x] -= cpu_convOut->data[(x - vlen) - 1] *
              cpu_a->data[vlen + 1];
            convOut_dirtyOnCpu = true;
            convOut_dirtyOnGpu = false;
          }
        }

        if (static_cast<uint32_T>(cpu_xt->size[0]) + 1U > static_cast<uint32_T>
            (cpu_convOut->size[0])) {
          ns = 0;
          nfilt = 0;
        } else {
          ns = cpu_xt->size[0];
          nfilt = cpu_convOut->size[0];
        }

        iv0 = cpu_zfIIR->size[0];
        cpu_zfIIR->size[0] = nfilt - ns;
        emxEnsureCapacity_real_T(cpu_zfIIR, iv0, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_zfIIR, &gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt -
          ns), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_convOut, cpu_convOut);
          }

          convOut_dirtyOnCpu = false;
          ecc_filtfilt_kernel192<<<grid, block>>>(c_gpu_convOut, ns, nfilt,
            gpu_zfIIR);
        }

        ns = cpu_a->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns - 2L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_convOut, cpu_convOut);
          }

          ecc_filtfilt_kernel193<<<grid, block>>>(c_gpu_convOut, c_gpu_a, ns,
            gpu_zfIIR, cpu_a->size[0U], cpu_xt->size[0U]);
        }

        iv0 = e_cpu_b->size[0];
        e_cpu_b->size[0] = cpu_b2->size[0];
        emxEnsureCapacity_real_T(e_cpu_b, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_cpu_b, &d_gpu_b);
        iv0 = cpu_b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel194<<<grid, block>>>(gpu_b2, iv0, d_gpu_b);
          e_b_dirtyOnGpu = true;
        }

        iv0 = e_cpu_a->size[0];
        e_cpu_a->size[0] = cpu_a2->size[0];
        emxEnsureCapacity_real_T(e_cpu_a, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_cpu_a, &d_gpu_a);
        iv0 = cpu_a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel195<<<grid, block>>>(gpu_a2, iv0, d_gpu_a);
          c_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
            (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_nb),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel196<<<grid, block>>>(gpu_a1, b_nb, d_gpu_b);
            e_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_na -
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel197<<<grid, block>>>(gpu_a1, b_na, d_gpu_a);
          }

          ecc_filtfilt_kernel198<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (d_gpu_a);
          c_a_dirtyOnGpu = true;
        }

        if (e_cpu_a->size[0] > e_cpu_b->size[0]) {
          csz_idx_0 = e_cpu_a->size[0] - e_cpu_b->size[0];
          iv0 = e_cpu_b->size[0];
          ns = e_cpu_b->size[0];
          e_cpu_b->size[0] = e_cpu_a->size[0];
          emxEnsureCapacity_real_T(e_cpu_b, ns, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(e_cpu_b, &d_gpu_b);
          if (csz_idx_0 - 1 >= 0) {
            if (e_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_cpu_b, &d_gpu_b);
            }

            std::memset(&e_cpu_b->data[iv0], 0, static_cast<uint32_T>(csz_idx_0)
                        * sizeof(real_T));
            e_b_dirtyOnCpu = true;
          }
        }

        csz_idx_0 = e_cpu_b->size[0] - 1;
        cpu_dv1[0] = static_cast<uint32_T>(e_cpu_b->size[0]);
        OH = (static_cast<uint32_T>(cpu_x->size[0]) + static_cast<uint32_T>
              (e_cpu_b->size[0])) - 1U;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = e_cpu_b->size[0];
        vlen = static_cast<int32_T>(std::floor(static_cast<real_T>(e_cpu_b->
          size[0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (e_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (e_cpu_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = static_cast<int32_T>(u) + e_cpu_b->size[0];
        }

        iv0 = f_cpu_expanded->size[0];
        f_cpu_expanded->size[0] = nfilt - 1;
        emxEnsureCapacity_real_T(f_cpu_expanded, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_cpu_expanded, &d_gpu_expanded);
        na = (static_cast<int32_T>(u) + static_cast<int32_T>(cpu_dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel199<<<grid, block>>>(na, d_gpu_expanded);
        }

        ns = cpu_x->size[0];
        iv0 = u_cpu_y->size[0] * u_cpu_y->size[1];
        u_cpu_y->size[0] = 1;
        u_cpu_y->size[1] = cpu_x->size[0];
        emxEnsureCapacity_int32_T(u_cpu_y, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(u_cpu_y, &h_gpu_y);
        u_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= ns - 2; iv0++) {
          nfilt++;
          u_cpu_y->data[iv0 + 1] = nfilt;
        }

        iv0 = u_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
          }

          x_dirtyOnCpu = false;
          gpuEmxMemcpyCpuToGpu_int32_T(&h_gpu_y, u_cpu_y);
          ecc_filtfilt_kernel200<<<grid, block>>>(b_gpu_x, vlen, h_gpu_y, iv0,
            d_gpu_expanded);
        }

        iv0 = g_cpu_rows->size[0] * g_cpu_rows->size[1];
        g_cpu_rows->size[0] = 1;
        g_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
        emxEnsureCapacity_int32_T(g_cpu_rows, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(g_cpu_rows, &d_gpu_rows);
        g_cpu_rows->data[0] = 0;
        nfilt = 0;
        for (iv0 = 0; iv0 <= thism - 2; iv0++) {
          nfilt++;
          g_cpu_rows->data[iv0 + 1] = nfilt;
        }

        iv0 = f_cpu_convOut->size[0];
        f_cpu_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(f_cpu_convOut, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_cpu_convOut, &d_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) +
                    31.0) / 32.0)), 1U, 1U);
        r1 = dim3(32U, 1U, 1U);
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
          static_cast<int32_T>(u)), r, r1, &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&d_gpu_rows, g_cpu_rows);
          if (e_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_b, e_cpu_b);
          }

          ecc_filtfilt_kernel201<<<grid, block>>>(d_gpu_expanded, d_gpu_rows,
            d_gpu_b, static_cast<int32_T>(u), d_gpu_convOut, e_cpu_b->size[0U]);
          f_convOut_dirtyOnGpu = true;
        }

        if (zfSize_idx_0 != 0) {
          if (zfSize_idx_0 == 1) {
            ecc_filtfilt_kernel203<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (gpu_zfIIR, d_gpu_convOut);
            f_convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              (zfSize_idx_0), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel202<<<grid, block>>>(gpu_zfIIR, zfSize_idx_0,
                d_gpu_convOut);
              f_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = cpu_x->size[0] + e_cpu_a->size[0];
        for (x = 0; x <= ns - 2; x++) {
          nfilt = static_cast<int32_T>(std::fmin(static_cast<real_T>(x) + 1.0,
            static_cast<real_T>(e_cpu_a->size[0])));
          for (vlen = 0; vlen <= nfilt - 2; vlen++) {
            if (f_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_cpu_convOut, &d_gpu_convOut);
            }

            if (c_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_cpu_a, &d_gpu_a);
            }

            c_a_dirtyOnGpu = false;
            f_cpu_convOut->data[x] -= f_cpu_convOut->data[(x - vlen) - 1] *
              e_cpu_a->data[vlen + 1];
            f_convOut_dirtyOnCpu = true;
            f_convOut_dirtyOnGpu = false;
          }
        }

        if (static_cast<uint32_T>(cpu_x->size[0]) + 1U > static_cast<uint32_T>
            (f_cpu_convOut->size[0])) {
          ns = 0;
          nfilt = 0;
        } else {
          ns = cpu_x->size[0];
          nfilt = f_cpu_convOut->size[0];
        }

        iv0 = d_cpu_zfIIR->size[0];
        d_cpu_zfIIR->size[0] = nfilt - ns;
        emxEnsureCapacity_real_T(d_cpu_zfIIR, iv0, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_cpu_zfIIR, &b_gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt -
          ns), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (f_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_convOut, f_cpu_convOut);
          }

          f_convOut_dirtyOnCpu = false;
          ecc_filtfilt_kernel204<<<grid, block>>>(d_gpu_convOut, ns, nfilt,
            b_gpu_zfIIR);
          c_zfIIR_dirtyOnGpu = true;
        }

        ns = e_cpu_a->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns - 2L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (f_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_convOut, f_cpu_convOut);
          }

          f_convOut_dirtyOnCpu = false;
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
          }

          x_dirtyOnCpu = false;
          ecc_filtfilt_kernel205<<<grid, block>>>(d_gpu_convOut, d_gpu_a, ns,
            b_gpu_zfIIR, e_cpu_a->size[0U], cpu_x->size[0U]);
          c_zfIIR_dirtyOnGpu = true;
        }

        iv0 = d_cpu_zfIIR->size[0];
        d_cpu_zfIIR->size[0] = csz_idx_0;
        emxEnsureCapacity_real_T(d_cpu_zfIIR, iv0, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_cpu_zfIIR, &b_gpu_zfIIR);
        iv0 = s_cpu_y->size[0];
        s_cpu_y->size[0] = cpu_x->size[0];
        emxEnsureCapacity_real_T(s_cpu_y, iv0, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(s_cpu_y, &i_gpu_y);
        x = cpu_x->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (f_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_convOut, f_cpu_convOut);
          }

          ecc_filtfilt_kernel206<<<grid, block>>>(d_gpu_convOut, x, i_gpu_y);
        }

        val = static_cast<real_T>(cpu_x->size[0]) - nfact;
        if (val > static_cast<real_T>(cpu_x->size[0]) - 1.0) {
          ns = 0;
          nfilt = 1;
          idx = -1;
        } else {
          ns = cpu_x->size[0] - 2;
          nfilt = -1;
          idx = static_cast<int32_T>(val) - 1;
        }

        val = 2.0 * cpu_x->data[cpu_x->size[0] - 1];
        iv0 = cpu_xt->size[0];
        cpu_xt->size[0] = div_s32(idx - ns, nfilt) + 1;
        emxEnsureCapacity_real_T(cpu_xt, iv0, &yb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_xt, &gpu_xt);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((idx -
          ns) / nfilt + 1L), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_d, &val, 8UL, cudaMemcpyHostToDevice);
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
          }

          x_dirtyOnCpu = false;
          ecc_filtfilt_kernel207<<<grid, block>>>(gpu_d, b_gpu_x, nfilt, ns, idx,
            gpu_xt);
        }

        iv0 = h_cpu_b->size[0];
        h_cpu_b->size[0] = cpu_b2->size[0];
        emxEnsureCapacity_real_T(h_cpu_b, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_cpu_b, &e_gpu_b);
        iv0 = cpu_b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel208<<<grid, block>>>(gpu_b2, iv0, e_gpu_b);
          h_b_dirtyOnGpu = true;
        }

        iv0 = h_cpu_a->size[0];
        h_cpu_a->size[0] = cpu_a2->size[0];
        emxEnsureCapacity_real_T(h_cpu_a, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_cpu_a, &e_gpu_a);
        iv0 = cpu_a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel209<<<grid, block>>>(gpu_a2, iv0, e_gpu_a);
          e_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
            (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_nb),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel210<<<grid, block>>>(e_gpu_a1, c_nb, e_gpu_b);
            h_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_na -
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel211<<<grid, block>>>(e_gpu_a1, c_na, e_gpu_a);
          }

          ecc_filtfilt_kernel212<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (e_gpu_a);
          e_a_dirtyOnGpu = true;
        }

        if (h_cpu_a->size[0] > h_cpu_b->size[0]) {
          csz_idx_0 = h_cpu_a->size[0] - h_cpu_b->size[0];
          iv0 = h_cpu_b->size[0];
          ns = h_cpu_b->size[0];
          h_cpu_b->size[0] = h_cpu_a->size[0];
          emxEnsureCapacity_real_T(h_cpu_b, ns, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(h_cpu_b, &e_gpu_b);
          if (csz_idx_0 - 1 >= 0) {
            if (h_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_cpu_b, &e_gpu_b);
            }

            std::memset(&h_cpu_b->data[iv0], 0, static_cast<uint32_T>(csz_idx_0)
                        * sizeof(real_T));
            h_b_dirtyOnCpu = true;
          }
        }

        if (cpu_xt->size[0] == 0) {
          b_cpu_yc3->size[0] = 0;
        } else {
          cpu_dv1[0] = static_cast<uint32_T>(h_cpu_b->size[0]);
          OH = (static_cast<uint32_T>(cpu_xt->size[0]) + static_cast<uint32_T>
                (h_cpu_b->size[0])) - 1U;
          x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
          u = OH;
          if (OH > 2147483647U) {
            u = 2147483647U;
          }

          thism = h_cpu_b->size[0];
          vlen = static_cast<int32_T>(std::floor(static_cast<real_T>
            (h_cpu_b->size[0]) / 2.0)) + static_cast<int32_T>(std::floor((
            static_cast<real_T>(h_cpu_b->size[0]) - 1.0) / 2.0));
          if ((static_cast<int32_T>(u) > 0) && (h_cpu_b->size[0] > MAX_int32_T -
               static_cast<int32_T>(u))) {
            nfilt = MAX_int32_T;
          } else {
            nfilt = static_cast<int32_T>(u) + h_cpu_b->size[0];
          }

          iv0 = h_cpu_expanded->size[0];
          h_cpu_expanded->size[0] = nfilt - 1;
          emxEnsureCapacity_real_T(h_cpu_expanded, iv0, &ib_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(h_cpu_expanded, &g_gpu_expanded);
          na = (static_cast<int32_T>(u) + static_cast<int32_T>(cpu_dv1[0])) - 2;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel213<<<grid, block>>>(na, g_gpu_expanded);
          }

          ns = cpu_xt->size[0];
          iv0 = y_cpu_y->size[0] * y_cpu_y->size[1];
          y_cpu_y->size[0] = 1;
          y_cpu_y->size[1] = cpu_xt->size[0];
          emxEnsureCapacity_int32_T(y_cpu_y, iv0, &lb_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(y_cpu_y, &m_gpu_y);
          y_cpu_y->data[0] = 1;
          nfilt = 1;
          for (iv0 = 0; iv0 <= ns - 2; iv0++) {
            nfilt++;
            y_cpu_y->data[iv0 + 1] = nfilt;
          }

          iv0 = y_cpu_y->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            gpuEmxMemcpyCpuToGpu_int32_T(&m_gpu_y, y_cpu_y);
            ecc_filtfilt_kernel214<<<grid, block>>>(gpu_xt, vlen, m_gpu_y, iv0,
              g_gpu_expanded);
          }

          iv0 = i_cpu_rows->size[0] * i_cpu_rows->size[1];
          i_cpu_rows->size[0] = 1;
          i_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
          emxEnsureCapacity_int32_T(i_cpu_rows, iv0, &lb_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(i_cpu_rows, &g_gpu_rows);
          i_cpu_rows->data[0] = 0;
          nfilt = 0;
          for (iv0 = 0; iv0 <= thism - 2; iv0++) {
            nfilt++;
            i_cpu_rows->data[iv0 + 1] = nfilt;
          }

          iv0 = h_cpu_convOut->size[0];
          h_cpu_convOut->size[0] = static_cast<int32_T>(u);
          emxEnsureCapacity_real_T(h_cpu_convOut, iv0, &ib_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(h_cpu_convOut, &h_gpu_convOut);
          r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
            static_cast<real_T>(x) - 1.0)) / static_cast<real_T>(x))), 1U, 1U);
          r1 = dim3(static_cast<uint32_T>(x), 1U, 1U);
          validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
            static_cast<int32_T>(u)), r, r1, &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            gpuEmxMemcpyCpuToGpu_int32_T(&g_gpu_rows, i_cpu_rows);
            if (h_b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_b, h_cpu_b);
            }

            ecc_filtfilt_kernel215<<<grid, block>>>(g_gpu_expanded, g_gpu_rows,
              e_gpu_b, static_cast<int32_T>(u), h_gpu_convOut, h_cpu_b->size[0U]);
            h_convOut_dirtyOnGpu = true;
          }

          if (d_cpu_zfIIR->size[0] != 0) {
            if (d_cpu_zfIIR->size[0] == 1) {
              if (h_convOut_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(h_cpu_convOut, &h_gpu_convOut);
              }

              if (c_zfIIR_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(d_cpu_zfIIR, &b_gpu_zfIIR);
              }

              h_cpu_convOut->data[0] += d_cpu_zfIIR->data[0];
              h_convOut_dirtyOnCpu = true;
              h_convOut_dirtyOnGpu = false;
            } else {
              ns = d_cpu_zfIIR->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
                &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel216<<<grid, block>>>(b_gpu_zfIIR, ns,
                  h_gpu_convOut);
                h_convOut_dirtyOnGpu = true;
              }
            }
          }

          ns = cpu_xt->size[0] + h_cpu_a->size[0];
          for (x = 0; x <= ns - 2; x++) {
            nfilt = static_cast<int32_T>(std::fmin(static_cast<real_T>(x) + 1.0,
              static_cast<real_T>(h_cpu_a->size[0])));
            for (vlen = 0; vlen <= nfilt - 2; vlen++) {
              if (h_convOut_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(h_cpu_convOut, &h_gpu_convOut);
              }

              if (e_a_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(h_cpu_a, &e_gpu_a);
              }

              e_a_dirtyOnGpu = false;
              h_cpu_convOut->data[x] -= h_cpu_convOut->data[(x - vlen) - 1] *
                h_cpu_a->data[vlen + 1];
              h_convOut_dirtyOnCpu = true;
              h_convOut_dirtyOnGpu = false;
            }
          }

          iv0 = b_cpu_yc3->size[0];
          b_cpu_yc3->size[0] = cpu_xt->size[0];
          emxEnsureCapacity_real_T(b_cpu_yc3, iv0, &cc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_yc3, &gpu_yc3);
          csz_idx_0 = cpu_xt->size[0] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (csz_idx_0 + 1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            if (h_convOut_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_convOut, h_cpu_convOut);
            }

            ecc_filtfilt_kernel217<<<grid, block>>>(h_gpu_convOut, csz_idx_0,
              gpu_yc3);
            yc3_dirtyOnGpu = true;
          }
        }

        if (b_cpu_yc3->size[0] < 1) {
          idx = 1;
          c_na = 1;
          c = 0;
        } else {
          idx = b_cpu_yc3->size[0];
          c_na = -1;
          c = 1;
        }

        if (yc3_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(b_cpu_yc3, &gpu_yc3);
        }

        val = b_cpu_yc3->data[b_cpu_yc3->size[0] - 1];
        iv0 = ab_cpu_y->size[0];
        ab_cpu_y->size[0] = cpu_zi->size[0];
        emxEnsureCapacity_real_T(ab_cpu_y, iv0, &w_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(ab_cpu_y, &j_gpu_y);
        iv0 = cpu_zi->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (zi_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, cpu_zi);
          }

          ecc_filtfilt_kernel218<<<grid, block>>>(val, gpu_zi, iv0, j_gpu_y);
        }

        iv0 = j_cpu_b->size[0];
        j_cpu_b->size[0] = cpu_b2->size[0];
        emxEnsureCapacity_real_T(j_cpu_b, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_cpu_b, &f_gpu_b);
        iv0 = cpu_b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel219<<<grid, block>>>(gpu_b2, iv0, f_gpu_b);
          j_b_dirtyOnGpu = true;
        }

        iv0 = j_cpu_a->size[0];
        j_cpu_a->size[0] = cpu_a2->size[0];
        emxEnsureCapacity_real_T(j_cpu_a, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_cpu_a, &f_gpu_a);
        iv0 = cpu_a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel220<<<grid, block>>>(gpu_a2, iv0, f_gpu_a);
          f_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
            (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_nb),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel221<<<grid, block>>>(d_gpu_a1, d_nb, f_gpu_b);
            j_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_na -
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel222<<<grid, block>>>(d_gpu_a1, d_na, f_gpu_a);
          }

          ecc_filtfilt_kernel223<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (f_gpu_a);
          f_a_dirtyOnGpu = true;
        }

        if (j_cpu_a->size[0] > j_cpu_b->size[0]) {
          csz_idx_0 = j_cpu_a->size[0] - j_cpu_b->size[0];
          iv0 = j_cpu_b->size[0];
          ns = j_cpu_b->size[0];
          j_cpu_b->size[0] = j_cpu_a->size[0];
          emxEnsureCapacity_real_T(j_cpu_b, ns, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(j_cpu_b, &f_gpu_b);
          if (csz_idx_0 - 1 >= 0) {
            if (j_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(j_cpu_b, &f_gpu_b);
            }

            std::memset(&j_cpu_b->data[iv0], 0, static_cast<uint32_T>(csz_idx_0)
                        * sizeof(real_T));
            j_b_dirtyOnCpu = true;
          }
        }

        csz_idx_0 = j_cpu_b->size[0] - 1;
        if (div_s32(c - idx, c_na) + 1 == 0) {
          iv0 = f_cpu_zfIIR->size[0];
          f_cpu_zfIIR->size[0] = j_cpu_b->size[0] - 1;
          emxEnsureCapacity_real_T(f_cpu_zfIIR, iv0, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_cpu_zfIIR, &c_gpu_zfIIR);
        } else {
          cpu_dv1[0] = static_cast<uint32_T>(j_cpu_b->size[0]);
          val = (static_cast<real_T>(div_s32(c - idx, c_na) + 1) +
                 static_cast<real_T>(j_cpu_b->size[0])) - 1.0;
          x = static_cast<int32_T>(std::fmin(32.0, val));
          if (val < 2.147483648E+9) {
            if (val >= -2.147483648E+9) {
              na = static_cast<int32_T>(val);
            } else {
              na = MIN_int32_T;
            }
          } else {
            na = MAX_int32_T;
          }

          thism = j_cpu_b->size[0];
          vlen = static_cast<int32_T>(std::floor(static_cast<real_T>
            (j_cpu_b->size[0]) / 2.0)) + static_cast<int32_T>(std::floor((
            static_cast<real_T>(j_cpu_b->size[0]) - 1.0) / 2.0));
          if ((na < 0) && (j_cpu_b->size[0] < MIN_int32_T - na)) {
            nfilt = MIN_int32_T;
          } else if ((na > 0) && (j_cpu_b->size[0] > MAX_int32_T - na)) {
            nfilt = MAX_int32_T;
          } else {
            nfilt = na + j_cpu_b->size[0];
          }

          iv0 = j_cpu_expanded->size[0];
          j_cpu_expanded->size[0] = nfilt - 1;
          emxEnsureCapacity_real_T(j_cpu_expanded, iv0, &ib_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(j_cpu_expanded, &f_gpu_expanded);
          iv0 = (na + static_cast<int32_T>(cpu_dv1[0])) - 2;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel224<<<grid, block>>>(iv0, f_gpu_expanded);
          }

          ns = div_s32(c - idx, c_na);
          iv0 = db_cpu_y->size[0] * db_cpu_y->size[1];
          db_cpu_y->size[0] = 1;
          db_cpu_y->size[1] = div_s32(c - idx, c_na) + 1;
          emxEnsureCapacity_int32_T(db_cpu_y, iv0, &lb_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(db_cpu_y, &l_gpu_y);
          db_cpu_y->data[0] = 1;
          nfilt = 1;
          for (iv0 = 0; iv0 < ns; iv0++) {
            nfilt++;
            db_cpu_y->data[iv0 + 1] = nfilt;
          }

          iv0 = cpu_iv15->size[0];
          cpu_iv15->size[0] = db_cpu_y->size[1];
          emxEnsureCapacity_int32_T(cpu_iv15, iv0, &ib_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(cpu_iv15, &gpu_iv15);
          iv0 = db_cpu_y->size[1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            gpuEmxMemcpyCpuToGpu_int32_T(&l_gpu_y, db_cpu_y);
            ecc_filtfilt_kernel225<<<grid, block>>>(vlen, l_gpu_y, iv0, gpu_iv15);
          }

          iv0 = div_s32(c - idx, c_na);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel226<<<grid, block>>>(gpu_yc3, c_na, idx, gpu_iv15,
              iv0, f_gpu_expanded);
          }

          iv0 = k_cpu_rows->size[0] * k_cpu_rows->size[1];
          k_cpu_rows->size[0] = 1;
          k_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
          emxEnsureCapacity_int32_T(k_cpu_rows, iv0, &lb_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(k_cpu_rows, &f_gpu_rows);
          k_cpu_rows->data[0] = 0;
          nfilt = 0;
          for (iv0 = 0; iv0 <= thism - 2; iv0++) {
            nfilt++;
            k_cpu_rows->data[iv0 + 1] = nfilt;
          }

          iv0 = j_cpu_convOut->size[0];
          j_cpu_convOut->size[0] = na;
          emxEnsureCapacity_real_T(j_cpu_convOut, iv0, &ib_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(j_cpu_convOut, &g_gpu_convOut);
          r = dim3(static_cast<uint32_T>(std::floor((val + (static_cast<real_T>
            (x) - 1.0)) / static_cast<real_T>(x))), 1U, 1U);
          r1 = dim3(static_cast<uint32_T>(x), 1U, 1U);
          validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(na), r,
            r1, &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            gpuEmxMemcpyCpuToGpu_int32_T(&f_gpu_rows, k_cpu_rows);
            if (j_b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_b, j_cpu_b);
            }

            ecc_filtfilt_kernel227<<<grid, block>>>(f_gpu_expanded, f_gpu_rows,
              f_gpu_b, na, g_gpu_convOut, j_cpu_b->size[0U]);
            j_convOut_dirtyOnGpu = true;
          }

          if (ab_cpu_y->size[0] != 0) {
            if (ab_cpu_y->size[0] == 1) {
              ecc_filtfilt_kernel229<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (j_gpu_y, g_gpu_convOut);
              j_convOut_dirtyOnGpu = true;
            } else {
              ns = ab_cpu_y->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
                &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel228<<<grid, block>>>(j_gpu_y, ns,
                  g_gpu_convOut);
                j_convOut_dirtyOnGpu = true;
              }
            }
          }

          ns = div_s32(c - idx, c_na) + j_cpu_a->size[0];
          for (x = 0; x < ns; x++) {
            nfilt = static_cast<int32_T>(std::fmin(static_cast<real_T>(x) + 1.0,
              static_cast<real_T>(j_cpu_a->size[0])));
            for (vlen = 0; vlen <= nfilt - 2; vlen++) {
              if (j_convOut_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(j_cpu_convOut, &g_gpu_convOut);
              }

              if (f_a_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(j_cpu_a, &f_gpu_a);
              }

              f_a_dirtyOnGpu = false;
              j_cpu_convOut->data[x] -= j_cpu_convOut->data[(x - vlen) - 1] *
                j_cpu_a->data[vlen + 1];
              j_convOut_dirtyOnCpu = true;
              j_convOut_dirtyOnGpu = false;
            }
          }

          if (static_cast<real_T>(div_s32(c - idx, c_na) + 1) + 1.0 >
              j_cpu_convOut->size[0]) {
            ns = 0;
            nfilt = 0;
          } else {
            ns = div_s32(c - idx, c_na) + 1;
            nfilt = j_cpu_convOut->size[0];
          }

          iv0 = f_cpu_zfIIR->size[0];
          f_cpu_zfIIR->size[0] = nfilt - ns;
          emxEnsureCapacity_real_T(f_cpu_zfIIR, iv0, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_cpu_zfIIR, &c_gpu_zfIIR);
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nfilt
            - ns), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            if (j_convOut_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_convOut, j_cpu_convOut);
            }

            j_convOut_dirtyOnCpu = false;
            ecc_filtfilt_kernel230<<<grid, block>>>(g_gpu_convOut, ns, nfilt,
              c_gpu_zfIIR);
            e_zfIIR_dirtyOnGpu = true;
          }

          ns = j_cpu_a->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns -
            2L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            if (j_convOut_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_convOut, j_cpu_convOut);
            }

            ecc_filtfilt_kernel231<<<grid, block>>>(g_gpu_convOut, c_na, idx, c,
              f_gpu_a, ns, c_gpu_zfIIR, j_cpu_a->size[0U]);
            e_zfIIR_dirtyOnGpu = true;
          }

          iv0 = f_cpu_zfIIR->size[0];
          f_cpu_zfIIR->size[0] = csz_idx_0;
          emxEnsureCapacity_real_T(f_cpu_zfIIR, iv0, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_cpu_zfIIR, &c_gpu_zfIIR);
        }

        idx = s_cpu_y->size[0] - 1;
        iv0 = l_cpu_b->size[0];
        l_cpu_b->size[0] = cpu_b2->size[0];
        emxEnsureCapacity_real_T(l_cpu_b, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_cpu_b, &g_gpu_b);
        iv0 = cpu_b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel232<<<grid, block>>>(gpu_b2, iv0, g_gpu_b);
          l_b_dirtyOnGpu = true;
        }

        iv0 = l_cpu_a->size[0];
        l_cpu_a->size[0] = cpu_a2->size[0];
        emxEnsureCapacity_real_T(l_cpu_a, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_cpu_a, &g_gpu_a);
        iv0 = cpu_a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel233<<<grid, block>>>(gpu_a2, iv0, g_gpu_a);
          g_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
            (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(e_nb),
            &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel234<<<grid, block>>>(c_gpu_a1, e_nb, g_gpu_b);
            l_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(e_na -
            1L), &grid, &block, 1024U, 3584U);
          if (validLaunchParams) {
            ecc_filtfilt_kernel235<<<grid, block>>>(c_gpu_a1, e_na, g_gpu_a);
          }

          ecc_filtfilt_kernel236<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (g_gpu_a);
          g_a_dirtyOnGpu = true;
        }

        if (l_cpu_a->size[0] > l_cpu_b->size[0]) {
          csz_idx_0 = l_cpu_a->size[0] - l_cpu_b->size[0];
          iv0 = l_cpu_b->size[0];
          ns = l_cpu_b->size[0];
          l_cpu_b->size[0] = l_cpu_a->size[0];
          emxEnsureCapacity_real_T(l_cpu_b, ns, &db_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(l_cpu_b, &g_gpu_b);
          if (csz_idx_0 - 1 >= 0) {
            if (l_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_cpu_b, &g_gpu_b);
            }

            std::memset(&l_cpu_b->data[iv0], 0, static_cast<uint32_T>(csz_idx_0)
                        * sizeof(real_T));
            l_b_dirtyOnCpu = true;
          }
        }

        cpu_dv1[0] = static_cast<uint32_T>(l_cpu_b->size[0]);
        OH = static_cast<uint32_T>(idx) + static_cast<uint32_T>(l_cpu_b->size[0]);
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = l_cpu_b->size[0];
        vlen = static_cast<int32_T>(std::floor(static_cast<real_T>(l_cpu_b->
          size[0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (l_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (l_cpu_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = static_cast<int32_T>(u) + l_cpu_b->size[0];
        }

        iv0 = l_cpu_expanded->size[0];
        l_cpu_expanded->size[0] = nfilt - 1;
        emxEnsureCapacity_real_T(l_cpu_expanded, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_cpu_expanded, &e_gpu_expanded);
        na = (static_cast<int32_T>(u) + static_cast<int32_T>(cpu_dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel237<<<grid, block>>>(na, e_gpu_expanded);
        }

        iv0 = gb_cpu_y->size[0] * gb_cpu_y->size[1];
        gb_cpu_y->size[0] = 1;
        gb_cpu_y->size[1] = idx + 1;
        emxEnsureCapacity_int32_T(gb_cpu_y, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(gb_cpu_y, &k_gpu_y);
        gb_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 < idx; iv0++) {
          nfilt++;
          gb_cpu_y->data[iv0 + 1] = nfilt;
        }

        iv0 = cpu_iv18->size[0];
        cpu_iv18->size[0] = gb_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv18, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv18, &gpu_iv18);
        iv0 = gb_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&k_gpu_y, gb_cpu_y);
          ecc_filtfilt_kernel238<<<grid, block>>>(vlen, k_gpu_y, iv0, gpu_iv18);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel239<<<grid, block>>>(i_gpu_y, gpu_iv18, idx,
            e_gpu_expanded);
        }

        iv0 = m_cpu_rows->size[0] * m_cpu_rows->size[1];
        m_cpu_rows->size[0] = 1;
        m_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
        emxEnsureCapacity_int32_T(m_cpu_rows, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(m_cpu_rows, &e_gpu_rows);
        m_cpu_rows->data[0] = 0;
        nfilt = 0;
        for (iv0 = 0; iv0 <= thism - 2; iv0++) {
          nfilt++;
          m_cpu_rows->data[iv0 + 1] = nfilt;
        }

        iv0 = l_cpu_convOut->size[0];
        l_cpu_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(l_cpu_convOut, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_cpu_convOut, &e_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) +
                    31.0) / 32.0)), 1U, 1U);
        r1 = dim3(32U, 1U, 1U);
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
          static_cast<int32_T>(u)), r, r1, &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&e_gpu_rows, m_cpu_rows);
          if (l_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_b, l_cpu_b);
          }

          ecc_filtfilt_kernel240<<<grid, block>>>(e_gpu_expanded, e_gpu_rows,
            g_gpu_b, static_cast<int32_T>(u), e_gpu_convOut, l_cpu_b->size[0U]);
          l_convOut_dirtyOnGpu = true;
        }

        if (f_cpu_zfIIR->size[0] != 0) {
          if (f_cpu_zfIIR->size[0] == 1) {
            if (l_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_cpu_convOut, &e_gpu_convOut);
            }

            if (e_zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_cpu_zfIIR, &c_gpu_zfIIR);
            }

            l_cpu_convOut->data[0] += f_cpu_zfIIR->data[0];
            l_convOut_dirtyOnCpu = true;
            l_convOut_dirtyOnGpu = false;
          } else {
            ns = f_cpu_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel241<<<grid, block>>>(c_gpu_zfIIR, ns,
                e_gpu_convOut);
              l_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = idx + l_cpu_a->size[0];
        for (x = 0; x < ns; x++) {
          nfilt = static_cast<int32_T>(std::fmin(static_cast<real_T>(x) + 1.0,
            static_cast<real_T>(l_cpu_a->size[0])));
          for (vlen = 0; vlen <= nfilt - 2; vlen++) {
            if (l_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_cpu_convOut, &e_gpu_convOut);
            }

            if (g_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_cpu_a, &g_gpu_a);
            }

            g_a_dirtyOnGpu = false;
            l_cpu_convOut->data[x] -= l_cpu_convOut->data[(x - vlen) - 1] *
              l_cpu_a->data[vlen + 1];
            l_convOut_dirtyOnCpu = true;
            l_convOut_dirtyOnGpu = false;
          }
        }

        iv0 = u_cpu_convOut->size[0];
        u_cpu_convOut->size[0] = idx + 1;
        emxEnsureCapacity_real_T(u_cpu_convOut, iv0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(u_cpu_convOut, &f_gpu_convOut);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (l_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_convOut, l_cpu_convOut);
          }

          ecc_filtfilt_kernel242<<<grid, block>>>(e_gpu_convOut, idx,
            f_gpu_convOut);
        }

        e_cpu_x[0] = idx + 1;
        iv0 = cpu_x->size[0] * cpu_x->size[1];
        cpu_x->size[0] = idx + 1;
        cpu_x->size[1] = 1;
        emxEnsureCapacity_real_T(cpu_x, iv0, &ec_emlrtRTEI);
        if (!x_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(cpu_x, &b_gpu_x);
        }

        x = e_cpu_x[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (x_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
          }

          ecc_filtfilt_kernel243<<<grid, block>>>(f_gpu_convOut, e_cpu_x[0] - 1,
            b_gpu_x);
          x_dirtyOnGpu = true;
          x_dirtyOnCpu = false;
        }
      }
    } else {
      dim3 r;
      dim3 r1;
      int32_T b_na;
      int32_T b_nb;
      int32_T c_na;
      int32_T c_nb;
      int32_T d_na;
      int32_T d_nb;
      int32_T e_na;
      int32_T e_nb;
      int32_T na;
      int32_T nb;
      int32_T zfSize_idx_0;
      uint32_T sz[2];
      uint32_T OH;
      uint32_T u;
      for (iv0 = 0; iv0 < 2; iv0++) {
        sz[iv0] = static_cast<uint32_T>(cpu_x->size[iv0]);
      }

      i = cpu_xc1->size[0] * cpu_xc1->size[1];
      cpu_xc1->size[0] = static_cast<int32_T>(sz[0]);
      emxEnsureCapacity_real_T(cpu_xc1, i, &m_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_xc1, &gpu_xc1);
      if (sz[0] == 0U) {
        emlrtDivisionByZeroErrorR2012b(&dd_emlrtRTEI, emlrtRootTLSGlobal);
      } else {
        i = static_cast<int32_T>(static_cast<uint32_T>(cpu_x->size[0] *
          cpu_x->size[1]) / sz[0]);
      }

      iv0 = cpu_xc1->size[0] * cpu_xc1->size[1];
      cpu_xc1->size[1] = i;
      emxEnsureCapacity_real_T(cpu_xc1, iv0, &m_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_xc1, &gpu_xc1);
      iv0 = static_cast<int32_T>(sz[0]) * (cpu_x->size[0] * cpu_x->size[1] /
        static_cast<int32_T>(sz[0])) - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
        x_dirtyOnCpu = false;
        ecc_filtfilt_kernel73<<<grid, block>>>(b_gpu_x, iv0, gpu_xc1);
      }

      na = cpu_a2->size[0];
      nb = cpu_b2->size[0];
      b_na = cpu_a2->size[0];
      b_nb = cpu_b2->size[0];
      c_na = cpu_a2->size[0];
      c_nb = cpu_b2->size[0];
      d_na = cpu_a2->size[0];
      d_nb = cpu_b2->size[0];
      e_na = cpu_a2->size[0];
      e_nb = cpu_b2->size[0];
      ecc_filtfilt_kernel74<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
        c_gpu_a1, d_gpu_a1, e_gpu_a1, gpu_a1, b_gpu_a1);
      i = g_cpu_y->size[0] * g_cpu_y->size[1];
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = cpu_xc1->size[1];
      emxEnsureCapacity_real_T(g_cpu_y, i, &w_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(g_cpu_y, &n_gpu_y);
      csz_idx_0 = cpu_xc1->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(csz_idx_0
        + 1L), &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel75<<<grid, block>>>(gpu_xc1, csz_idx_0, n_gpu_y,
          cpu_xc1->size[0U]);
      }

      ns = cpu_xc1->size[1];
      nfilt = g_cpu_y->size[1];
      if (ns <= nfilt) {
        nfilt = ns;
      }

      if (cpu_xc1->size[1] == 1) {
        i = g_cpu_y->size[1];
      } else if (g_cpu_y->size[1] == 1) {
        i = cpu_xc1->size[1];
      } else if (g_cpu_y->size[1] == cpu_xc1->size[1]) {
        i = g_cpu_y->size[1];
      } else {
        i = nfilt;
      }

      iv0 = b_cpu_xt->size[0] * b_cpu_xt->size[1];
      b_cpu_xt->size[0] = static_cast<int32_T>(nfact + 1.0) - 1;
      ns = cpu_xc1->size[1];
      nfilt = g_cpu_y->size[1];
      if (ns <= nfilt) {
        nfilt = ns;
      }

      if (cpu_xc1->size[1] == 1) {
        b_cpu_xt->size[1] = g_cpu_y->size[1];
      } else if (g_cpu_y->size[1] == 1) {
        b_cpu_xt->size[1] = cpu_xc1->size[1];
      } else if (g_cpu_y->size[1] == cpu_xc1->size[1]) {
        b_cpu_xt->size[1] = g_cpu_y->size[1];
      } else {
        b_cpu_xt->size[1] = nfilt;
      }

      emxEnsureCapacity_real_T(b_cpu_xt, iv0, &bb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_cpu_xt, &b_gpu_xt);
      if (i != 0) {
        nfilt = (g_cpu_y->size[1] != 1);
        idx = (cpu_xc1->size[1] != 1);
        ns = i - 1;
        csz_idx_0 = b_cpu_xt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((csz_idx_0 + 1L) * (ns + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel76<<<grid, block>>>(gpu_xc1, n_gpu_y, nfact, idx,
            nfilt, csz_idx_0, i - 1, b_gpu_xt, b_cpu_xt->size[0U], cpu_xc1->
            size[0U]);
        }
      }

      i = i_cpu_y->size[0] * i_cpu_y->size[1];
      i_cpu_y->size[0] = cpu_zi->size[0];
      i_cpu_y->size[1] = b_cpu_xt->size[1];
      emxEnsureCapacity_real_T(i_cpu_y, i, &cb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(i_cpu_y, &o_gpu_y);
      csz_idx_0 = b_cpu_xt->size[1];
      iv0 = cpu_zi->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 + 1L)
        * csz_idx_0), &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        if (zi_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, cpu_zi);
        }

        zi_dirtyOnCpu = false;
        ecc_filtfilt_kernel77<<<grid, block>>>(b_gpu_xt, gpu_zi, iv0, csz_idx_0,
          o_gpu_y, i_cpu_y->size[0U], b_cpu_xt->size[0U]);
      }

      i = c_cpu_b->size[0];
      c_cpu_b->size[0] = cpu_b2->size[0];
      emxEnsureCapacity_real_T(c_cpu_b, i, &fb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(c_cpu_b, &h_gpu_b);
      iv0 = cpu_b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel78<<<grid, block>>>(gpu_b2, iv0, h_gpu_b);
        c_b_dirtyOnGpu = true;
      }

      i = c_cpu_a->size[0];
      c_cpu_a->size[0] = cpu_a2->size[0];
      emxEnsureCapacity_real_T(c_cpu_a, i, &fb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(c_cpu_a, &h_gpu_a);
      iv0 = cpu_a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel79<<<grid, block>>>(gpu_a2, iv0, h_gpu_a);
      }

      i = b_cpu_zi->size[0] * b_cpu_zi->size[1];
      b_cpu_zi->size[0] = cpu_zi->size[0];
      b_cpu_zi->size[1] = b_cpu_xt->size[1];
      emxEnsureCapacity_real_T(b_cpu_zi, i, &jb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_cpu_zi, &b_gpu_zi);
      csz_idx_0 = b_cpu_xt->size[1];
      iv0 = cpu_zi->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 + 1L)
        * csz_idx_0), &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        if (zi_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, cpu_zi);
        }

        zi_dirtyOnCpu = false;
        ecc_filtfilt_kernel80<<<grid, block>>>(b_gpu_xt, gpu_zi, iv0, csz_idx_0,
          b_gpu_zi, b_cpu_xt->size[0U], b_cpu_zi->size[0U]);
        zi_dirtyOnGpu = true;
      }

      gpuEmxMemcpyGpuToCpu_real_T(cpu_a2, &gpu_a2);
      if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
          (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nb),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel81<<<grid, block>>>(b_gpu_a1, nb, h_gpu_b);
          c_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na - 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel82<<<grid, block>>>(b_gpu_a1, na, h_gpu_a);
        }

        ecc_filtfilt_kernel83<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(h_gpu_a);
      }

      if (c_cpu_a->size[0] > c_cpu_b->size[0]) {
        csz_idx_0 = c_cpu_a->size[0] - c_cpu_b->size[0];
        i = c_cpu_b->size[0];
        iv0 = c_cpu_b->size[0];
        c_cpu_b->size[0] = c_cpu_a->size[0];
        emxEnsureCapacity_real_T(c_cpu_b, iv0, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_cpu_b, &h_gpu_b);
        if (csz_idx_0 - 1 >= 0) {
          if (c_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(c_cpu_b, &h_gpu_b);
          }

          std::memset(&c_cpu_b->data[i], 0, static_cast<uint32_T>(csz_idx_0) *
                      sizeof(real_T));
          c_b_dirtyOnCpu = true;
        }
      }

      for (iv0 = 0; iv0 < 2; iv0++) {
        cpu_zfSize[iv0] = static_cast<uint32_T>(b_cpu_xt->size[iv0]);
        zfSize_dirtyOnCpu = true;
      }

      if (c_b_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_b, c_cpu_b);
      }

      if (zfSize_dirtyOnCpu) {
        cudaMemcpy(*gpu_zfSize, cpu_zfSize, 8UL, cudaMemcpyHostToDevice);
      }

      ecc_filtfilt_kernel84<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_zfSize,
        c_cpu_b->size[0U]);
      zfSize_dirtyOnCpu = false;
      if (b_cpu_xt->size[1] == 0) {
        i = b_cpu_zfIIR->size[0] * b_cpu_zfIIR->size[1];
        b_cpu_zfIIR->size[0] = c_cpu_b->size[0] - 1;
        cudaMemcpy(cpu_zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        b_cpu_zfIIR->size[1] = static_cast<int32_T>(cpu_zfSize[1]);
        emxEnsureCapacity_real_T(b_cpu_zfIIR, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_zfIIR, &f_gpu_zfIIR);
      } else {
        if (dv1_dirtyOnCpu) {
          cudaMemcpy(*gpu_dv1, cpu_dv1, 8UL, cudaMemcpyHostToDevice);
        }

        ecc_filtfilt_kernel85<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_dv1,
          c_cpu_b->size[0U]);
        dv1_dirtyOnCpu = false;
        OH = (static_cast<uint32_T>(b_cpu_xt->size[0]) + static_cast<uint32_T>
              (c_cpu_b->size[0])) - 1U;
        x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        idx = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (b_cpu_xt->size[1]) + 1.0) - 1.0));
        c = b_cpu_xt->size[1];
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = c_cpu_b->size[0];
        vlen = static_cast<int32_T>(std::floor(static_cast<real_T>(c_cpu_b->
          size[0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (c_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (c_cpu_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = static_cast<int32_T>(u) + c_cpu_b->size[0];
        }

        i = c_cpu_expanded->size[0] * c_cpu_expanded->size[1];
        c_cpu_expanded->size[0] = nfilt - 1;
        emxEnsureCapacity_real_T(c_cpu_expanded, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_cpu_expanded, &l_gpu_expanded);
        if (b_cpu_xt->size[1] > 2147483646) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = b_cpu_xt->size[1] + 1;
        }

        i = c_cpu_expanded->size[0] * c_cpu_expanded->size[1];
        c_cpu_expanded->size[1] = nfilt - 1;
        emxEnsureCapacity_real_T(c_cpu_expanded, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_cpu_expanded, &l_gpu_expanded);
        cudaMemcpy(cpu_dv1, *gpu_dv1, 8UL, cudaMemcpyDeviceToHost);
        na = ((static_cast<int32_T>(u) + static_cast<int32_T>(cpu_dv1[0])) - 1) *
          b_cpu_xt->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel86<<<grid, block>>>(na, l_gpu_expanded);
        }

        ns = b_cpu_xt->size[0];
        i = l_cpu_y->size[0] * l_cpu_y->size[1];
        l_cpu_y->size[0] = 1;
        l_cpu_y->size[1] = b_cpu_xt->size[0];
        emxEnsureCapacity_int32_T(l_cpu_y, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(l_cpu_y, &bb_gpu_y);
        l_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= ns - 2; iv0++) {
          nfilt++;
          l_cpu_y->data[iv0 + 1] = nfilt;
        }

        i = cpu_iv3->size[0];
        cpu_iv3->size[0] = l_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv3, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv3, &gpu_iv3);
        iv0 = l_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&bb_gpu_y, l_cpu_y);
          ecc_filtfilt_kernel87<<<grid, block>>>(vlen, bb_gpu_y, iv0, gpu_iv3);
        }

        ns = b_cpu_xt->size[1];
        i = m_cpu_y->size[0] * m_cpu_y->size[1];
        m_cpu_y->size[0] = 1;
        m_cpu_y->size[1] = b_cpu_xt->size[1];
        emxEnsureCapacity_int32_T(m_cpu_y, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(m_cpu_y, &cb_gpu_y);
        m_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= ns - 2; iv0++) {
          nfilt++;
          m_cpu_y->data[iv0 + 1] = nfilt;
        }

        i = cpu_iv4->size[0];
        cpu_iv4->size[0] = m_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv4, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv4, &gpu_iv4);
        iv0 = m_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&cb_gpu_y, m_cpu_y);
          ecc_filtfilt_kernel88<<<grid, block>>>(cb_gpu_y, iv0, gpu_iv4);
        }

        csz_idx_0 = b_cpu_xt->size[1] - 1;
        iv0 = b_cpu_xt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (csz_idx_0 + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel89<<<grid, block>>>(b_gpu_xt, gpu_iv4, gpu_iv3, iv0,
            csz_idx_0, l_gpu_expanded, c_cpu_expanded->size[0U], b_cpu_xt->size
            [0U]);
        }

        i = d_cpu_rows->size[0] * d_cpu_rows->size[1];
        d_cpu_rows->size[0] = 1;
        d_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
        emxEnsureCapacity_int32_T(d_cpu_rows, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(d_cpu_rows, &l_gpu_rows);
        d_cpu_rows->data[0] = 0;
        nfilt = 0;
        for (iv0 = 0; iv0 <= thism - 2; iv0++) {
          nfilt++;
          d_cpu_rows->data[iv0 + 1] = nfilt;
        }

        i = c_cpu_convOut->size[0] * c_cpu_convOut->size[1];
        c_cpu_convOut->size[0] = static_cast<int32_T>(u);
        c_cpu_convOut->size[1] = b_cpu_xt->size[1];
        emxEnsureCapacity_real_T(c_cpu_convOut, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_cpu_convOut, &t_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(x) - 1.0)) / static_cast<real_T>(x))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(b_cpu_xt->size[1]) + static_cast<uint32_T>(idx))
                    - 1.0) / static_cast<real_T>(idx))), 1U);
        r1 = dim3(static_cast<uint32_T>(x), static_cast<uint32_T>(idx), 1U);
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
          static_cast<int64_T>(static_cast<int32_T>(u)) * c), r, r1, &grid,
          &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&l_gpu_rows, d_cpu_rows);
          ecc_filtfilt_kernel90<<<grid, block>>>(l_gpu_expanded, l_gpu_rows,
            h_gpu_b, static_cast<int32_T>(u), c, t_gpu_convOut, c_cpu_b->size[0U],
            c_cpu_expanded->size[0U], c_cpu_convOut->size[0U]);
          c_convOut_dirtyOnGpu = true;
        }

        if ((b_cpu_zi->size[0] != 0) && (b_cpu_zi->size[1] != 0)) {
          if (b_cpu_zi->size[0] == 1) {
            ns = c_cpu_convOut->size[1];
            iv0 = b_cpu_zi->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * ns), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel94<<<grid, block>>>(o_gpu_y, iv0, ns,
                t_gpu_convOut, c_cpu_convOut->size[0U], i_cpu_y->size[0U]);
            }
          } else if (i_cpu_y->size[1] == 1) {
            ns = c_cpu_convOut->size[1];
            iv0 = b_cpu_zi->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * ns), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel93<<<grid, block>>>(o_gpu_y, iv0, ns,
                t_gpu_convOut, c_cpu_convOut->size[0U]);
            }
          } else {
            if (i_cpu_y->size[0] < 1) {
              ns = 0;
            } else {
              ns = b_cpu_zi->size[0];
            }

            if ((ns == b_cpu_zi->size[0]) && (c_cpu_convOut->size[1] ==
                 b_cpu_zi->size[1])) {
              i = m_cpu_convOut->size[0] * m_cpu_convOut->size[1];
              m_cpu_convOut->size[0] = ns;
              m_cpu_convOut->size[1] = c_cpu_convOut->size[1];
              emxEnsureCapacity_real_T(m_cpu_convOut, i, &db_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(m_cpu_convOut, &u_gpu_convOut);
              na = c_cpu_convOut->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns
                * (na + 1L)), &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel91<<<grid, block>>>(b_gpu_zi, t_gpu_convOut,
                  ns, na, u_gpu_convOut, m_cpu_convOut->size[0U],
                  c_cpu_convOut->size[0U], b_cpu_zi->size[0U]);
              }

              na = m_cpu_convOut->size[1] - 1;
              iv0 = m_cpu_convOut->size[0] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((iv0 + 1L) * (na + 1L)), &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel92<<<grid, block>>>(u_gpu_convOut, iv0, na,
                  t_gpu_convOut, c_cpu_convOut->size[0U], m_cpu_convOut->size[0U]);
              }
            } else {
              if (c_convOut_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_cpu_convOut, &t_gpu_convOut);
              }

              if (zi_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_cpu_zi, &b_gpu_zi);
              }

              binary_expand_op(c_cpu_convOut, ns - 1, b_cpu_zi);
              c_convOut_dirtyOnCpu = true;
            }
          }
        }

        ns = c_cpu_convOut->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&t_gpu_convOut, c_cpu_convOut);
          }

          ecc_filtfilt_kernel95<<<grid, block>>>(h_gpu_a, ns, t_gpu_convOut,
            b_cpu_xt->size[0U], c_cpu_a->size[0U], c_cpu_convOut->size[0U]);
          c_convOut_dirtyOnCpu = false;
        }

        if (static_cast<uint32_T>(b_cpu_xt->size[0]) + 1U > static_cast<uint32_T>
            (c_cpu_convOut->size[0])) {
          ns = 0;
          nfilt = 0;
        } else {
          ns = b_cpu_xt->size[0];
          nfilt = c_cpu_convOut->size[0];
        }

        i = b_cpu_zfIIR->size[0] * b_cpu_zfIIR->size[1];
        b_cpu_zfIIR->size[0] = nfilt - ns;
        b_cpu_zfIIR->size[1] = c_cpu_convOut->size[1];
        emxEnsureCapacity_real_T(b_cpu_zfIIR, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_zfIIR, &f_gpu_zfIIR);
        na = c_cpu_convOut->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nfilt -
          ns) * (na + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&t_gpu_convOut, c_cpu_convOut);
          }

          c_convOut_dirtyOnCpu = false;
          ecc_filtfilt_kernel96<<<grid, block>>>(t_gpu_convOut, ns, nfilt, na,
            f_gpu_zfIIR, b_cpu_zfIIR->size[0U], c_cpu_convOut->size[0U]);
          zfIIR_dirtyOnGpu = true;
        }

        ns = c_cpu_convOut->size[1];
        iv0 = c_cpu_a->size[0] - 3;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * ns), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&t_gpu_convOut, c_cpu_convOut);
          }

          ecc_filtfilt_kernel97<<<grid, block>>>(t_gpu_convOut, h_gpu_a, iv0, ns,
            f_gpu_zfIIR, c_cpu_a->size[0U], b_cpu_zfIIR->size[0U],
            b_cpu_xt->size[0U], c_cpu_convOut->size[0U]);
          zfIIR_dirtyOnGpu = true;
        }

        i = b_cpu_zfIIR->size[0] * b_cpu_zfIIR->size[1];
        cudaMemcpy(cpu_zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        b_cpu_zfIIR->size[0] = static_cast<int32_T>(cpu_zfSize[0]);
        b_cpu_zfIIR->size[1] = static_cast<int32_T>(cpu_zfSize[1]);
        emxEnsureCapacity_real_T(b_cpu_zfIIR, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_zfIIR, &f_gpu_zfIIR);
      }

      i = d_cpu_b->size[0];
      d_cpu_b->size[0] = cpu_b2->size[0];
      emxEnsureCapacity_real_T(d_cpu_b, i, &fb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(d_cpu_b, &i_gpu_b);
      iv0 = cpu_b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel98<<<grid, block>>>(gpu_b2, iv0, i_gpu_b);
        d_b_dirtyOnGpu = true;
      }

      i = d_cpu_a->size[0];
      d_cpu_a->size[0] = cpu_a2->size[0];
      emxEnsureCapacity_real_T(d_cpu_a, i, &fb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(d_cpu_a, &i_gpu_a);
      iv0 = cpu_a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel99<<<grid, block>>>(gpu_a2, iv0, i_gpu_a);
      }

      if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
          (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_nb),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel100<<<grid, block>>>(gpu_a1, b_nb, i_gpu_b);
          d_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_na -
          1L), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel101<<<grid, block>>>(gpu_a1, b_na, i_gpu_a);
        }

        ecc_filtfilt_kernel102<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i_gpu_a);
      }

      if (d_cpu_a->size[0] > d_cpu_b->size[0]) {
        csz_idx_0 = d_cpu_a->size[0] - d_cpu_b->size[0];
        i = d_cpu_b->size[0];
        iv0 = d_cpu_b->size[0];
        d_cpu_b->size[0] = d_cpu_a->size[0];
        emxEnsureCapacity_real_T(d_cpu_b, iv0, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_cpu_b, &i_gpu_b);
        if (csz_idx_0 - 1 >= 0) {
          if (d_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_cpu_b, &i_gpu_b);
          }

          std::memset(&d_cpu_b->data[i], 0, static_cast<uint32_T>(csz_idx_0) *
                      sizeof(real_T));
          d_b_dirtyOnCpu = true;
        }
      }

      for (iv0 = 0; iv0 < 2; iv0++) {
        cpu_zfSize[iv0] = static_cast<uint32_T>(cpu_xc1->size[iv0]);
        zfSize_dirtyOnCpu = true;
      }

      if (d_b_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_b, d_cpu_b);
      }

      if (zfSize_dirtyOnCpu) {
        cudaMemcpy(*gpu_zfSize, cpu_zfSize, 8UL, cudaMemcpyHostToDevice);
      }

      ecc_filtfilt_kernel103<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
        (*gpu_zfSize, d_cpu_b->size[0U]);
      if (cpu_xc1->size[1] == 0) {
        for (iv0 = 0; iv0 < 2; iv0++) {
          cpu_dv1[iv0] = static_cast<uint32_T>(cpu_xc1->size[iv0]);
        }

        n_cpu_y->size[0] = static_cast<int32_T>(cpu_dv1[0]);
        n_cpu_y->size[1] = 0;
        i = c_cpu_zfIIR->size[0] * c_cpu_zfIIR->size[1];
        cudaMemcpy(cpu_zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        c_cpu_zfIIR->size[0] = static_cast<int32_T>(cpu_zfSize[0]);
        c_cpu_zfIIR->size[1] = static_cast<int32_T>(cpu_zfSize[1]);
        emxEnsureCapacity_real_T(c_cpu_zfIIR, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_cpu_zfIIR, &e_gpu_zfIIR);
      } else {
        if (dv1_dirtyOnCpu) {
          cudaMemcpy(*gpu_dv1, cpu_dv1, 8UL, cudaMemcpyHostToDevice);
        }

        ecc_filtfilt_kernel104<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_dv1,
          d_cpu_b->size[0U]);
        OH = (static_cast<uint32_T>(cpu_xc1->size[0]) + static_cast<uint32_T>
              (d_cpu_b->size[0])) - 1U;
        x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        idx = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (cpu_xc1->size[1]) + 1.0) - 1.0));
        c = cpu_xc1->size[1];
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = d_cpu_b->size[0];
        vlen = static_cast<int32_T>(std::floor(static_cast<real_T>(d_cpu_b->
          size[0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (d_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (d_cpu_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = static_cast<int32_T>(u) + d_cpu_b->size[0];
        }

        i = d_cpu_expanded->size[0] * d_cpu_expanded->size[1];
        d_cpu_expanded->size[0] = nfilt - 1;
        emxEnsureCapacity_real_T(d_cpu_expanded, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_cpu_expanded, &k_gpu_expanded);
        if (cpu_xc1->size[1] > 2147483646) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = cpu_xc1->size[1] + 1;
        }

        i = d_cpu_expanded->size[0] * d_cpu_expanded->size[1];
        d_cpu_expanded->size[1] = nfilt - 1;
        emxEnsureCapacity_real_T(d_cpu_expanded, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_cpu_expanded, &k_gpu_expanded);
        cudaMemcpy(cpu_dv1, *gpu_dv1, 8UL, cudaMemcpyDeviceToHost);
        na = ((static_cast<int32_T>(u) + static_cast<int32_T>(cpu_dv1[0])) - 1) *
          cpu_xc1->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel105<<<grid, block>>>(na, k_gpu_expanded);
        }

        i = cpu_xc1->size[0];
        iv0 = o_cpu_y->size[0] * o_cpu_y->size[1];
        o_cpu_y->size[0] = 1;
        o_cpu_y->size[1] = cpu_xc1->size[0];
        emxEnsureCapacity_int32_T(o_cpu_y, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(o_cpu_y, &y_gpu_y);
        o_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= i - 2; iv0++) {
          nfilt++;
          o_cpu_y->data[iv0 + 1] = nfilt;
        }

        i = cpu_iv5->size[0];
        cpu_iv5->size[0] = o_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv5, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv5, &gpu_iv5);
        iv0 = o_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&y_gpu_y, o_cpu_y);
          ecc_filtfilt_kernel106<<<grid, block>>>(vlen, y_gpu_y, iv0, gpu_iv5);
        }

        i = cpu_xc1->size[1];
        iv0 = r_cpu_y->size[0] * r_cpu_y->size[1];
        r_cpu_y->size[0] = 1;
        r_cpu_y->size[1] = cpu_xc1->size[1];
        emxEnsureCapacity_int32_T(r_cpu_y, iv0, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(r_cpu_y, &ab_gpu_y);
        r_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= i - 2; iv0++) {
          nfilt++;
          r_cpu_y->data[iv0 + 1] = nfilt;
        }

        i = cpu_iv6->size[0];
        cpu_iv6->size[0] = r_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv6, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv6, &gpu_iv6);
        iv0 = r_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&ab_gpu_y, r_cpu_y);
          ecc_filtfilt_kernel107<<<grid, block>>>(ab_gpu_y, iv0, gpu_iv6);
        }

        csz_idx_0 = cpu_xc1->size[1] - 1;
        iv0 = cpu_xc1->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (csz_idx_0 + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel108<<<grid, block>>>(gpu_xc1, gpu_iv6, gpu_iv5, iv0,
            csz_idx_0, k_gpu_expanded, d_cpu_expanded->size[0U], cpu_xc1->size
            [0U]);
        }

        i = e_cpu_rows->size[0] * e_cpu_rows->size[1];
        e_cpu_rows->size[0] = 1;
        e_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
        emxEnsureCapacity_int32_T(e_cpu_rows, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(e_cpu_rows, &k_gpu_rows);
        e_cpu_rows->data[0] = 0;
        nfilt = 0;
        for (iv0 = 0; iv0 <= thism - 2; iv0++) {
          nfilt++;
          e_cpu_rows->data[iv0 + 1] = nfilt;
        }

        i = d_cpu_convOut->size[0] * d_cpu_convOut->size[1];
        d_cpu_convOut->size[0] = static_cast<int32_T>(u);
        d_cpu_convOut->size[1] = cpu_xc1->size[1];
        emxEnsureCapacity_real_T(d_cpu_convOut, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_cpu_convOut, &q_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(x) - 1.0)) / static_cast<real_T>(x))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(cpu_xc1->size[1]) + static_cast<uint32_T>(idx))
                    - 1.0) / static_cast<real_T>(idx))), 1U);
        r1 = dim3(static_cast<uint32_T>(x), static_cast<uint32_T>(idx), 1U);
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
          static_cast<int64_T>(static_cast<int32_T>(u)) * c), r, r1, &grid,
          &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&k_gpu_rows, e_cpu_rows);
          ecc_filtfilt_kernel109<<<grid, block>>>(k_gpu_expanded, k_gpu_rows,
            i_gpu_b, static_cast<int32_T>(u), c, q_gpu_convOut, d_cpu_b->size[0U],
            d_cpu_expanded->size[0U], d_cpu_convOut->size[0U]);
          d_convOut_dirtyOnGpu = true;
        }

        if ((b_cpu_zfIIR->size[0] != 0) && (b_cpu_zfIIR->size[1] != 0)) {
          if (b_cpu_zfIIR->size[0] == 1) {
            ns = d_cpu_convOut->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel113<<<grid, block>>>(f_gpu_zfIIR, ns,
                q_gpu_convOut, b_cpu_zfIIR->size[1U], d_cpu_convOut->size[0U],
                b_cpu_zfIIR->size[0U]);
            }
          } else if (b_cpu_zfIIR->size[1] == 1) {
            ns = d_cpu_convOut->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel112<<<grid, block>>>(f_gpu_zfIIR, ns,
                q_gpu_convOut, b_cpu_zfIIR->size[0U], d_cpu_convOut->size[0U]);
            }
          } else if (d_cpu_convOut->size[1] == b_cpu_zfIIR->size[1]) {
            i = b_cpu_zfIIR->size[0];
            iv0 = n_cpu_convOut->size[0] * n_cpu_convOut->size[1];
            n_cpu_convOut->size[0] = b_cpu_zfIIR->size[0];
            n_cpu_convOut->size[1] = d_cpu_convOut->size[1];
            emxEnsureCapacity_real_T(n_cpu_convOut, iv0, &db_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(n_cpu_convOut, &s_gpu_convOut);
            na = d_cpu_convOut->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i *
              (na + 1L)), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel110<<<grid, block>>>(f_gpu_zfIIR, q_gpu_convOut,
                i, na, s_gpu_convOut, n_cpu_convOut->size[0U],
                d_cpu_convOut->size[0U], b_cpu_zfIIR->size[0U]);
            }

            na = n_cpu_convOut->size[1] - 1;
            iv0 = n_cpu_convOut->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (na + 1L)), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel111<<<grid, block>>>(s_gpu_convOut, iv0, na,
                q_gpu_convOut, d_cpu_convOut->size[0U], n_cpu_convOut->size[0U]);
            }
          } else {
            if (d_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(d_cpu_convOut, &q_gpu_convOut);
            }

            if (zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_zfIIR, &f_gpu_zfIIR);
            }

            binary_expand_op(d_cpu_convOut, b_cpu_zfIIR);
            d_convOut_dirtyOnCpu = true;
          }
        }

        ns = d_cpu_convOut->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&q_gpu_convOut, d_cpu_convOut);
          }

          ecc_filtfilt_kernel114<<<grid, block>>>(i_gpu_a, ns, q_gpu_convOut,
            cpu_xc1->size[0U], d_cpu_a->size[0U], d_cpu_convOut->size[0U]);
          d_convOut_dirtyOnCpu = false;
        }

        if (static_cast<uint32_T>(cpu_xc1->size[0]) + 1U > static_cast<uint32_T>
            (d_cpu_convOut->size[0])) {
          ns = 0;
          nfilt = 0;
        } else {
          ns = cpu_xc1->size[0];
          nfilt = d_cpu_convOut->size[0];
        }

        i = c_cpu_zfIIR->size[0] * c_cpu_zfIIR->size[1];
        c_cpu_zfIIR->size[0] = nfilt - ns;
        c_cpu_zfIIR->size[1] = d_cpu_convOut->size[1];
        emxEnsureCapacity_real_T(c_cpu_zfIIR, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_cpu_zfIIR, &e_gpu_zfIIR);
        na = d_cpu_convOut->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nfilt -
          ns) * (na + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&q_gpu_convOut, d_cpu_convOut);
          }

          d_convOut_dirtyOnCpu = false;
          ecc_filtfilt_kernel115<<<grid, block>>>(q_gpu_convOut, ns, nfilt, na,
            e_gpu_zfIIR, c_cpu_zfIIR->size[0U], d_cpu_convOut->size[0U]);
          b_zfIIR_dirtyOnGpu = true;
        }

        ns = d_cpu_convOut->size[1];
        iv0 = d_cpu_a->size[0] - 3;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * ns), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&q_gpu_convOut, d_cpu_convOut);
          }

          d_convOut_dirtyOnCpu = false;
          ecc_filtfilt_kernel116<<<grid, block>>>(q_gpu_convOut, i_gpu_a, iv0,
            ns, e_gpu_zfIIR, d_cpu_a->size[0U], c_cpu_zfIIR->size[0U],
            cpu_xc1->size[0U], d_cpu_convOut->size[0U]);
          b_zfIIR_dirtyOnGpu = true;
        }

        i = c_cpu_zfIIR->size[0] * c_cpu_zfIIR->size[1];
        cudaMemcpy(cpu_zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        c_cpu_zfIIR->size[0] = static_cast<int32_T>(cpu_zfSize[0]);
        c_cpu_zfIIR->size[1] = static_cast<int32_T>(cpu_zfSize[1]);
        emxEnsureCapacity_real_T(c_cpu_zfIIR, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_cpu_zfIIR, &e_gpu_zfIIR);
        i = o_cpu_convOut->size[0] * o_cpu_convOut->size[1];
        o_cpu_convOut->size[0] = cpu_xc1->size[0];
        o_cpu_convOut->size[1] = d_cpu_convOut->size[1];
        emxEnsureCapacity_real_T(o_cpu_convOut, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(o_cpu_convOut, &r_gpu_convOut);
        na = d_cpu_convOut->size[1] - 1;
        csz_idx_0 = cpu_xc1->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((csz_idx_0 + 1L) * (na + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&q_gpu_convOut, d_cpu_convOut);
          }

          ecc_filtfilt_kernel117<<<grid, block>>>(q_gpu_convOut, csz_idx_0, na,
            r_gpu_convOut, o_cpu_convOut->size[0U], d_cpu_convOut->size[0U]);
        }

        ecc_filtfilt_kernel118<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*e_gpu_x,
          cpu_xc1->size[0U], cpu_xc1->size[1U]);
        i = n_cpu_y->size[0] * n_cpu_y->size[1];
        n_cpu_y->size[0] = cpu_xc1->size[0];
        n_cpu_y->size[1] = cpu_xc1->size[1];
        emxEnsureCapacity_real_T(n_cpu_y, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(n_cpu_y, &t_gpu_y);
        cudaMemcpy(e_cpu_x, *e_gpu_x, 8UL, cudaMemcpyDeviceToHost);
        x = e_cpu_x[0] * e_cpu_x[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel119<<<grid, block>>>(r_gpu_convOut, x, t_gpu_y);
        }
      }

      val = static_cast<real_T>(cpu_xc1->size[0]) - nfact;
      if (val > static_cast<real_T>(cpu_xc1->size[0]) - 1.0) {
        vlen = 1;
        x = 1;
        thism = 0;
      } else {
        vlen = cpu_xc1->size[0] - 1;
        x = -1;
        thism = static_cast<int32_T>(val);
      }

      ns = cpu_xc1->size[0];
      i = q_cpu_y->size[0] * q_cpu_y->size[1];
      q_cpu_y->size[0] = 1;
      q_cpu_y->size[1] = cpu_xc1->size[1];
      emxEnsureCapacity_real_T(q_cpu_y, i, &w_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(q_cpu_y, &p_gpu_y);
      csz_idx_0 = cpu_xc1->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(csz_idx_0
        + 1L), &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel120<<<grid, block>>>(gpu_xc1, ns, csz_idx_0, p_gpu_y,
          cpu_xc1->size[0U]);
      }

      ns = cpu_xc1->size[1];
      nfilt = q_cpu_y->size[1];
      if (ns <= nfilt) {
        nfilt = ns;
      }

      if (cpu_xc1->size[1] == 1) {
        i = q_cpu_y->size[1];
      } else if (q_cpu_y->size[1] == 1) {
        i = cpu_xc1->size[1];
      } else if (q_cpu_y->size[1] == cpu_xc1->size[1]) {
        i = q_cpu_y->size[1];
      } else {
        i = nfilt;
      }

      iv0 = b_cpu_xt->size[0] * b_cpu_xt->size[1];
      b_cpu_xt->size[0] = div_s32(thism - vlen, x) + 1;
      ns = cpu_xc1->size[1];
      nfilt = q_cpu_y->size[1];
      if (ns <= nfilt) {
        nfilt = ns;
      }

      if (cpu_xc1->size[1] == 1) {
        b_cpu_xt->size[1] = q_cpu_y->size[1];
      } else if (q_cpu_y->size[1] == 1) {
        b_cpu_xt->size[1] = cpu_xc1->size[1];
      } else if (q_cpu_y->size[1] == cpu_xc1->size[1]) {
        b_cpu_xt->size[1] = q_cpu_y->size[1];
      } else {
        b_cpu_xt->size[1] = nfilt;
      }

      emxEnsureCapacity_real_T(b_cpu_xt, iv0, &bb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_cpu_xt, &b_gpu_xt);
      if ((div_s32(thism - vlen, x) + 1 != 0) && (i != 0)) {
        nfilt = (q_cpu_y->size[1] != 1);
        idx = (cpu_xc1->size[1] != 1);
        ns = i - 1;
        csz_idx_0 = b_cpu_xt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((csz_idx_0 + 1L) * (ns + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel121<<<grid, block>>>(gpu_xc1, p_gpu_y, x, vlen,
            thism, idx, nfilt, csz_idx_0, i - 1, b_gpu_xt, b_cpu_xt->size[0U],
            cpu_xc1->size[0U]);
        }
      }

      i = g_cpu_b->size[0];
      g_cpu_b->size[0] = cpu_b2->size[0];
      emxEnsureCapacity_real_T(g_cpu_b, i, &fb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(g_cpu_b, &j_gpu_b);
      iv0 = cpu_b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel122<<<grid, block>>>(gpu_b2, iv0, j_gpu_b);
        g_b_dirtyOnGpu = true;
      }

      i = g_cpu_a->size[0];
      g_cpu_a->size[0] = cpu_a2->size[0];
      emxEnsureCapacity_real_T(g_cpu_a, i, &fb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(g_cpu_a, &j_gpu_a);
      iv0 = cpu_a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel123<<<grid, block>>>(gpu_a2, iv0, j_gpu_a);
      }

      if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
          (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_nb),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel124<<<grid, block>>>(e_gpu_a1, c_nb, j_gpu_b);
          g_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_na -
          1L), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel125<<<grid, block>>>(e_gpu_a1, c_na, j_gpu_a);
        }

        ecc_filtfilt_kernel126<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(j_gpu_a);
      }

      if (g_cpu_a->size[0] > g_cpu_b->size[0]) {
        csz_idx_0 = g_cpu_a->size[0] - g_cpu_b->size[0];
        i = g_cpu_b->size[0];
        iv0 = g_cpu_b->size[0];
        g_cpu_b->size[0] = g_cpu_a->size[0];
        emxEnsureCapacity_real_T(g_cpu_b, iv0, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_cpu_b, &j_gpu_b);
        if (csz_idx_0 - 1 >= 0) {
          if (g_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(g_cpu_b, &j_gpu_b);
          }

          std::memset(&g_cpu_b->data[i], 0, static_cast<uint32_T>(csz_idx_0) *
                      sizeof(real_T));
          g_b_dirtyOnCpu = true;
        }
      }

      if ((b_cpu_xt->size[0] == 0) || (b_cpu_xt->size[1] == 0)) {
        for (iv0 = 0; iv0 < 2; iv0++) {
          cpu_dv1[iv0] = static_cast<uint32_T>(b_cpu_xt->size[iv0]);
        }

        i = cpu_yc3->size[0] * cpu_yc3->size[1];
        cpu_yc3->size[0] = static_cast<int32_T>(cpu_dv1[0]);
        cpu_yc3->size[1] = static_cast<int32_T>(cpu_dv1[1]);
        emxEnsureCapacity_real_T(cpu_yc3, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_yc3, &b_gpu_yc3);
      } else {
        cpu_dv1[0] = static_cast<uint32_T>(g_cpu_b->size[0]);
        OH = (static_cast<uint32_T>(b_cpu_xt->size[0]) + static_cast<uint32_T>
              (g_cpu_b->size[0])) - 1U;
        x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        idx = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (b_cpu_xt->size[1]) + 1.0) - 1.0));
        c = b_cpu_xt->size[1];
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = g_cpu_b->size[0];
        vlen = static_cast<int32_T>(std::floor(static_cast<real_T>(g_cpu_b->
          size[0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (g_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (g_cpu_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = static_cast<int32_T>(u) + g_cpu_b->size[0];
        }

        i = g_cpu_expanded->size[0] * g_cpu_expanded->size[1];
        g_cpu_expanded->size[0] = nfilt - 1;
        emxEnsureCapacity_real_T(g_cpu_expanded, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_cpu_expanded, &j_gpu_expanded);
        if (b_cpu_xt->size[1] > 2147483646) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = b_cpu_xt->size[1] + 1;
        }

        i = g_cpu_expanded->size[0] * g_cpu_expanded->size[1];
        g_cpu_expanded->size[1] = nfilt - 1;
        emxEnsureCapacity_real_T(g_cpu_expanded, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_cpu_expanded, &j_gpu_expanded);
        na = ((static_cast<int32_T>(u) + static_cast<int32_T>(cpu_dv1[0])) - 1) *
          b_cpu_xt->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel127<<<grid, block>>>(na, j_gpu_expanded);
        }

        ns = b_cpu_xt->size[0];
        i = v_cpu_y->size[0] * v_cpu_y->size[1];
        v_cpu_y->size[0] = 1;
        v_cpu_y->size[1] = b_cpu_xt->size[0];
        emxEnsureCapacity_int32_T(v_cpu_y, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(v_cpu_y, &w_gpu_y);
        v_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= ns - 2; iv0++) {
          nfilt++;
          v_cpu_y->data[iv0 + 1] = nfilt;
        }

        i = cpu_iv10->size[0];
        cpu_iv10->size[0] = v_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv10, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv10, &gpu_iv10);
        iv0 = v_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&w_gpu_y, v_cpu_y);
          ecc_filtfilt_kernel128<<<grid, block>>>(vlen, w_gpu_y, iv0, gpu_iv10);
        }

        ns = b_cpu_xt->size[1];
        i = x_cpu_y->size[0] * x_cpu_y->size[1];
        x_cpu_y->size[0] = 1;
        x_cpu_y->size[1] = b_cpu_xt->size[1];
        emxEnsureCapacity_int32_T(x_cpu_y, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(x_cpu_y, &x_gpu_y);
        x_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= ns - 2; iv0++) {
          nfilt++;
          x_cpu_y->data[iv0 + 1] = nfilt;
        }

        i = cpu_iv11->size[0];
        cpu_iv11->size[0] = x_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv11, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv11, &gpu_iv11);
        iv0 = x_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&x_gpu_y, x_cpu_y);
          ecc_filtfilt_kernel129<<<grid, block>>>(x_gpu_y, iv0, gpu_iv11);
        }

        csz_idx_0 = b_cpu_xt->size[1] - 1;
        iv0 = b_cpu_xt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (csz_idx_0 + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel130<<<grid, block>>>(b_gpu_xt, gpu_iv11, gpu_iv10,
            iv0, csz_idx_0, j_gpu_expanded, g_cpu_expanded->size[0U],
            b_cpu_xt->size[0U]);
        }

        i = h_cpu_rows->size[0] * h_cpu_rows->size[1];
        h_cpu_rows->size[0] = 1;
        h_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
        emxEnsureCapacity_int32_T(h_cpu_rows, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(h_cpu_rows, &j_gpu_rows);
        h_cpu_rows->data[0] = 0;
        nfilt = 0;
        for (iv0 = 0; iv0 <= thism - 2; iv0++) {
          nfilt++;
          h_cpu_rows->data[iv0 + 1] = nfilt;
        }

        i = g_cpu_convOut->size[0] * g_cpu_convOut->size[1];
        g_cpu_convOut->size[0] = static_cast<int32_T>(u);
        g_cpu_convOut->size[1] = b_cpu_xt->size[1];
        emxEnsureCapacity_real_T(g_cpu_convOut, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_cpu_convOut, &n_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(x) - 1.0)) / static_cast<real_T>(x))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(b_cpu_xt->size[1]) + static_cast<uint32_T>(idx))
                    - 1.0) / static_cast<real_T>(idx))), 1U);
        r1 = dim3(static_cast<uint32_T>(x), static_cast<uint32_T>(idx), 1U);
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
          static_cast<int64_T>(static_cast<int32_T>(u)) * c), r, r1, &grid,
          &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&j_gpu_rows, h_cpu_rows);
          if (g_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_b, g_cpu_b);
          }

          ecc_filtfilt_kernel131<<<grid, block>>>(j_gpu_expanded, j_gpu_rows,
            j_gpu_b, static_cast<int32_T>(u), c, n_gpu_convOut, g_cpu_b->size[0U],
            g_cpu_expanded->size[0U], g_cpu_convOut->size[0U]);
          g_convOut_dirtyOnGpu = true;
        }

        if ((c_cpu_zfIIR->size[0] != 0) && (c_cpu_zfIIR->size[1] != 0)) {
          if (c_cpu_zfIIR->size[0] == 1) {
            ns = g_cpu_convOut->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel135<<<grid, block>>>(e_gpu_zfIIR, ns,
                n_gpu_convOut, c_cpu_zfIIR->size[1U], g_cpu_convOut->size[0U],
                c_cpu_zfIIR->size[0U]);
            }
          } else if (c_cpu_zfIIR->size[1] == 1) {
            ns = g_cpu_convOut->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel134<<<grid, block>>>(e_gpu_zfIIR, ns,
                n_gpu_convOut, c_cpu_zfIIR->size[0U], g_cpu_convOut->size[0U]);
            }
          } else if (g_cpu_convOut->size[1] == c_cpu_zfIIR->size[1]) {
            i = c_cpu_zfIIR->size[0];
            iv0 = q_cpu_convOut->size[0] * q_cpu_convOut->size[1];
            q_cpu_convOut->size[0] = c_cpu_zfIIR->size[0];
            q_cpu_convOut->size[1] = g_cpu_convOut->size[1];
            emxEnsureCapacity_real_T(q_cpu_convOut, iv0, &db_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(q_cpu_convOut, &p_gpu_convOut);
            na = g_cpu_convOut->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i *
              (na + 1L)), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel132<<<grid, block>>>(e_gpu_zfIIR, n_gpu_convOut,
                i, na, p_gpu_convOut, q_cpu_convOut->size[0U],
                g_cpu_convOut->size[0U], c_cpu_zfIIR->size[0U]);
            }

            na = q_cpu_convOut->size[1] - 1;
            iv0 = q_cpu_convOut->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (na + 1L)), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel133<<<grid, block>>>(p_gpu_convOut, iv0, na,
                n_gpu_convOut, g_cpu_convOut->size[0U], q_cpu_convOut->size[0U]);
            }
          } else {
            if (g_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_cpu_convOut, &n_gpu_convOut);
            }

            if (b_zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_cpu_zfIIR, &e_gpu_zfIIR);
            }

            binary_expand_op(g_cpu_convOut, c_cpu_zfIIR);
            g_convOut_dirtyOnCpu = true;
          }
        }

        ns = g_cpu_convOut->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (g_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_convOut, g_cpu_convOut);
          }

          ecc_filtfilt_kernel136<<<grid, block>>>(j_gpu_a, ns, n_gpu_convOut,
            b_cpu_xt->size[0U], g_cpu_a->size[0U], g_cpu_convOut->size[0U]);
          g_convOut_dirtyOnCpu = false;
        }

        i = p_cpu_convOut->size[0] * p_cpu_convOut->size[1];
        p_cpu_convOut->size[0] = b_cpu_xt->size[0];
        p_cpu_convOut->size[1] = g_cpu_convOut->size[1];
        emxEnsureCapacity_real_T(p_cpu_convOut, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(p_cpu_convOut, &o_gpu_convOut);
        na = g_cpu_convOut->size[1] - 1;
        csz_idx_0 = b_cpu_xt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((csz_idx_0 + 1L) * (na + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (g_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_convOut, g_cpu_convOut);
          }

          ecc_filtfilt_kernel137<<<grid, block>>>(n_gpu_convOut, csz_idx_0, na,
            o_gpu_convOut, p_cpu_convOut->size[0U], g_cpu_convOut->size[0U]);
        }

        ecc_filtfilt_kernel138<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*e_gpu_x,
          b_cpu_xt->size[0U], b_cpu_xt->size[1U]);
        i = cpu_yc3->size[0] * cpu_yc3->size[1];
        cpu_yc3->size[0] = b_cpu_xt->size[0];
        cpu_yc3->size[1] = b_cpu_xt->size[1];
        emxEnsureCapacity_real_T(cpu_yc3, i, &bc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_yc3, &b_gpu_yc3);
        cudaMemcpy(e_cpu_x, *e_gpu_x, 8UL, cudaMemcpyDeviceToHost);
        x = e_cpu_x[0] * e_cpu_x[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel139<<<grid, block>>>(o_gpu_convOut, x, b_gpu_yc3);
        }
      }

      if (cpu_yc3->size[0] < 1) {
        nb = 1;
        b_na = 1;
        b_nb = 0;
      } else {
        nb = cpu_yc3->size[0];
        b_na = -1;
        b_nb = 1;
      }

      ns = cpu_yc3->size[0];
      i = w_cpu_y->size[0] * w_cpu_y->size[1];
      w_cpu_y->size[0] = cpu_zi->size[0];
      w_cpu_y->size[1] = cpu_yc3->size[1];
      emxEnsureCapacity_real_T(w_cpu_y, i, &cb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(w_cpu_y, &q_gpu_y);
      csz_idx_0 = cpu_yc3->size[1];
      iv0 = cpu_zi->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 + 1L)
        * csz_idx_0), &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        if (zi_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, cpu_zi);
        }

        zi_dirtyOnCpu = false;
        ecc_filtfilt_kernel140<<<grid, block>>>(b_gpu_yc3, ns, gpu_zi, iv0,
          csz_idx_0, q_gpu_y, w_cpu_y->size[0U], cpu_yc3->size[0U]);
      }

      i = i_cpu_b->size[0];
      i_cpu_b->size[0] = cpu_b2->size[0];
      emxEnsureCapacity_real_T(i_cpu_b, i, &fb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(i_cpu_b, &k_gpu_b);
      iv0 = cpu_b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel141<<<grid, block>>>(gpu_b2, iv0, k_gpu_b);
        i_b_dirtyOnGpu = true;
      }

      i = i_cpu_a->size[0];
      i_cpu_a->size[0] = cpu_a2->size[0];
      emxEnsureCapacity_real_T(i_cpu_a, i, &fb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(i_cpu_a, &k_gpu_a);
      iv0 = cpu_a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel142<<<grid, block>>>(gpu_a2, iv0, k_gpu_a);
      }

      ns = cpu_yc3->size[0];
      i = c_cpu_zi->size[0] * c_cpu_zi->size[1];
      c_cpu_zi->size[0] = cpu_zi->size[0];
      c_cpu_zi->size[1] = cpu_yc3->size[1];
      emxEnsureCapacity_real_T(c_cpu_zi, i, &xb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(c_cpu_zi, &c_gpu_zi);
      csz_idx_0 = cpu_yc3->size[1];
      iv0 = cpu_zi->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 + 1L)
        * csz_idx_0), &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        if (zi_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, cpu_zi);
        }

        ecc_filtfilt_kernel143<<<grid, block>>>(b_gpu_yc3, ns, gpu_zi, iv0,
          csz_idx_0, c_gpu_zi, cpu_yc3->size[0U], c_cpu_zi->size[0U]);
        b_zi_dirtyOnGpu = true;
      }

      if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
          (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_nb),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel144<<<grid, block>>>(d_gpu_a1, d_nb, k_gpu_b);
          i_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_na -
          1L), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel145<<<grid, block>>>(d_gpu_a1, d_na, k_gpu_a);
        }

        ecc_filtfilt_kernel146<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(k_gpu_a);
      }

      if (i_cpu_a->size[0] > i_cpu_b->size[0]) {
        csz_idx_0 = i_cpu_a->size[0] - i_cpu_b->size[0];
        i = i_cpu_b->size[0];
        iv0 = i_cpu_b->size[0];
        i_cpu_b->size[0] = i_cpu_a->size[0];
        emxEnsureCapacity_real_T(i_cpu_b, iv0, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_cpu_b, &k_gpu_b);
        if (csz_idx_0 - 1 >= 0) {
          if (i_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(i_cpu_b, &k_gpu_b);
          }

          std::memset(&i_cpu_b->data[i], 0, static_cast<uint32_T>(csz_idx_0) *
                      sizeof(real_T));
          i_b_dirtyOnCpu = true;
        }
      }

      c_na = cpu_yc3->size[1];
      zfSize_idx_0 = i_cpu_b->size[0] - 1;
      if ((div_s32(b_nb - nb, b_na) + 1 == 0) || (cpu_yc3->size[1] == 0)) {
        i = e_cpu_zfIIR->size[0] * e_cpu_zfIIR->size[1];
        e_cpu_zfIIR->size[0] = i_cpu_b->size[0] - 1;
        e_cpu_zfIIR->size[1] = cpu_yc3->size[1];
        emxEnsureCapacity_real_T(e_cpu_zfIIR, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_cpu_zfIIR, &d_gpu_zfIIR);
      } else {
        cpu_dv1[0] = static_cast<uint32_T>(i_cpu_b->size[0]);
        val = (static_cast<real_T>(div_s32(b_nb - nb, b_na) + 1) + static_cast<
               real_T>(i_cpu_b->size[0])) - 1.0;
        x = static_cast<int32_T>(std::fmin(32.0, val));
        idx = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (cpu_yc3->size[1]) + 1.0) - 1.0));
        c = cpu_yc3->size[1];
        if (val < 2.147483648E+9) {
          if (val >= -2.147483648E+9) {
            na = static_cast<int32_T>(val);
          } else {
            na = MIN_int32_T;
          }
        } else {
          na = MAX_int32_T;
        }

        ns = div_s32(b_nb - nb, b_na) + 1;
        thism = i_cpu_b->size[0];
        vlen = static_cast<int32_T>(std::floor(static_cast<real_T>(i_cpu_b->
          size[0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (i_cpu_b->size[0]) - 1.0) / 2.0));
        if ((na < 0) && (i_cpu_b->size[0] < MIN_int32_T - na)) {
          nfilt = MIN_int32_T;
        } else if ((na > 0) && (i_cpu_b->size[0] > MAX_int32_T - na)) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = na + i_cpu_b->size[0];
        }

        i = i_cpu_expanded->size[0] * i_cpu_expanded->size[1];
        i_cpu_expanded->size[0] = nfilt - 1;
        emxEnsureCapacity_real_T(i_cpu_expanded, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_cpu_expanded, &i_gpu_expanded);
        if (cpu_yc3->size[1] > 2147483646) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = cpu_yc3->size[1] + 1;
        }

        i = i_cpu_expanded->size[0] * i_cpu_expanded->size[1];
        i_cpu_expanded->size[1] = nfilt - 1;
        emxEnsureCapacity_real_T(i_cpu_expanded, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_cpu_expanded, &i_gpu_expanded);
        iv0 = ((na + static_cast<int32_T>(cpu_dv1[0])) - 1) * cpu_yc3->size[1] -
          1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel147<<<grid, block>>>(iv0, i_gpu_expanded);
        }

        if (ns < 1) {
          ns = 0;
        }

        i = bb_cpu_y->size[0] * bb_cpu_y->size[1];
        bb_cpu_y->size[0] = 1;
        bb_cpu_y->size[1] = ns;
        emxEnsureCapacity_int32_T(bb_cpu_y, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(bb_cpu_y, &u_gpu_y);
        if (ns > 0) {
          bb_cpu_y->data[0] = 1;
          y_dirtyOnCpu = true;
          nfilt = 1;
          for (iv0 = 0; iv0 <= ns - 2; iv0++) {
            nfilt++;
            bb_cpu_y->data[iv0 + 1] = nfilt;
          }
        }

        i = cpu_iv13->size[0];
        cpu_iv13->size[0] = bb_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv13, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv13, &gpu_iv13);
        iv0 = bb_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (y_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&u_gpu_y, bb_cpu_y);
          }

          ecc_filtfilt_kernel148<<<grid, block>>>(vlen, u_gpu_y, iv0, gpu_iv13);
        }

        ns = cpu_yc3->size[1];
        i = cb_cpu_y->size[0] * cb_cpu_y->size[1];
        cb_cpu_y->size[0] = 1;
        cb_cpu_y->size[1] = cpu_yc3->size[1];
        emxEnsureCapacity_int32_T(cb_cpu_y, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cb_cpu_y, &v_gpu_y);
        cb_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= ns - 2; iv0++) {
          nfilt++;
          cb_cpu_y->data[iv0 + 1] = nfilt;
        }

        i = cpu_iv14->size[0];
        cpu_iv14->size[0] = cb_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv14, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv14, &gpu_iv14);
        iv0 = cb_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&v_gpu_y, cb_cpu_y);
          ecc_filtfilt_kernel149<<<grid, block>>>(v_gpu_y, iv0, gpu_iv14);
        }

        i = div_s32(b_nb - nb, b_na);
        iv0 = cpu_yc3->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L)
          * (iv0 + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel150<<<grid, block>>>(b_gpu_yc3, b_na, nb, gpu_iv14,
            gpu_iv13, i, iv0, i_gpu_expanded, i_cpu_expanded->size[0U],
            cpu_yc3->size[0U]);
        }

        i = j_cpu_rows->size[0] * j_cpu_rows->size[1];
        j_cpu_rows->size[0] = 1;
        j_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
        emxEnsureCapacity_int32_T(j_cpu_rows, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(j_cpu_rows, &i_gpu_rows);
        j_cpu_rows->data[0] = 0;
        nfilt = 0;
        for (iv0 = 0; iv0 <= thism - 2; iv0++) {
          nfilt++;
          j_cpu_rows->data[iv0 + 1] = nfilt;
        }

        i = i_cpu_convOut->size[0] * i_cpu_convOut->size[1];
        i_cpu_convOut->size[0] = na;
        i_cpu_convOut->size[1] = cpu_yc3->size[1];
        emxEnsureCapacity_real_T(i_cpu_convOut, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_cpu_convOut, &l_gpu_convOut);
        if (na != 0) {
          r = dim3(static_cast<uint32_T>(std::floor((val + (static_cast<real_T>
            (x) - 1.0)) / static_cast<real_T>(x))), static_cast<uint32_T>(std::
                    floor((static_cast<real_T>(static_cast<uint32_T>
            (cpu_yc3->size[1]) + static_cast<uint32_T>(idx)) - 1.0) /
                          static_cast<real_T>(idx))), 1U);
          r1 = dim3(static_cast<uint32_T>(x), static_cast<uint32_T>(idx), 1U);
          validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
            static_cast<int64_T>(na) * c), r, r1, &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            gpuEmxMemcpyCpuToGpu_int32_T(&i_gpu_rows, j_cpu_rows);
            if (i_b_dirtyOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&k_gpu_b, i_cpu_b);
            }

            ecc_filtfilt_kernel151<<<grid, block>>>(i_gpu_expanded, i_gpu_rows,
              k_gpu_b, na, c, l_gpu_convOut, i_cpu_b->size[0U],
              i_cpu_expanded->size[0U], i_cpu_convOut->size[0U]);
            i_convOut_dirtyOnGpu = true;
          }
        }

        if ((c_cpu_zi->size[0] != 0) && (c_cpu_zi->size[1] != 0)) {
          if (c_cpu_zi->size[0] == 1) {
            ns = i_cpu_convOut->size[1];
            iv0 = c_cpu_zi->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * ns), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel155<<<grid, block>>>(q_gpu_y, iv0, ns,
                l_gpu_convOut, i_cpu_convOut->size[0U], w_cpu_y->size[0U]);
            }
          } else if (w_cpu_y->size[1] == 1) {
            ns = i_cpu_convOut->size[1];
            iv0 = c_cpu_zi->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * ns), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel154<<<grid, block>>>(q_gpu_y, iv0, ns,
                l_gpu_convOut, i_cpu_convOut->size[0U]);
            }
          } else {
            if (w_cpu_y->size[0] < 1) {
              ns = 0;
            } else {
              ns = c_cpu_zi->size[0];
            }

            if ((ns == c_cpu_zi->size[0]) && (i_cpu_convOut->size[1] ==
                 c_cpu_zi->size[1])) {
              i = r_cpu_convOut->size[0] * r_cpu_convOut->size[1];
              r_cpu_convOut->size[0] = ns;
              r_cpu_convOut->size[1] = i_cpu_convOut->size[1];
              emxEnsureCapacity_real_T(r_cpu_convOut, i, &db_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(r_cpu_convOut, &m_gpu_convOut);
              na = i_cpu_convOut->size[1] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns
                * (na + 1L)), &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel152<<<grid, block>>>(c_gpu_zi, l_gpu_convOut,
                  ns, na, m_gpu_convOut, r_cpu_convOut->size[0U],
                  i_cpu_convOut->size[0U], c_cpu_zi->size[0U]);
              }

              na = r_cpu_convOut->size[1] - 1;
              iv0 = r_cpu_convOut->size[0] - 1;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((iv0 + 1L) * (na + 1L)), &grid, &block, 1024U, 3584U);
              if (validLaunchParams) {
                ecc_filtfilt_kernel153<<<grid, block>>>(m_gpu_convOut, iv0, na,
                  l_gpu_convOut, i_cpu_convOut->size[0U], r_cpu_convOut->size[0U]);
              }
            } else {
              if (i_convOut_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_cpu_convOut, &l_gpu_convOut);
              }

              if (b_zi_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_cpu_zi, &c_gpu_zi);
              }

              binary_expand_op(i_cpu_convOut, ns - 1, c_cpu_zi);
              i_convOut_dirtyOnCpu = true;
            }
          }
        }

        ns = i_cpu_convOut->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (i_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_convOut, i_cpu_convOut);
          }

          ecc_filtfilt_kernel156<<<grid, block>>>(k_gpu_a, b_na, nb, b_nb, ns,
            l_gpu_convOut, i_cpu_a->size[0U], i_cpu_convOut->size[0U]);
          i_convOut_dirtyOnCpu = false;
        }

        if (static_cast<real_T>(div_s32(b_nb - nb, b_na) + 1) + 1.0 >
            i_cpu_convOut->size[0]) {
          ns = 0;
          nfilt = 0;
        } else {
          ns = div_s32(b_nb - nb, b_na) + 1;
          nfilt = i_cpu_convOut->size[0];
        }

        i = e_cpu_zfIIR->size[0] * e_cpu_zfIIR->size[1];
        e_cpu_zfIIR->size[0] = nfilt - ns;
        e_cpu_zfIIR->size[1] = i_cpu_convOut->size[1];
        emxEnsureCapacity_real_T(e_cpu_zfIIR, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_cpu_zfIIR, &d_gpu_zfIIR);
        na = i_cpu_convOut->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nfilt -
          ns) * (na + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (i_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_convOut, i_cpu_convOut);
          }

          i_convOut_dirtyOnCpu = false;
          ecc_filtfilt_kernel157<<<grid, block>>>(l_gpu_convOut, ns, nfilt, na,
            d_gpu_zfIIR, e_cpu_zfIIR->size[0U], i_cpu_convOut->size[0U]);
          d_zfIIR_dirtyOnGpu = true;
        }

        ns = i_cpu_convOut->size[1];
        iv0 = i_cpu_a->size[0] - 3;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * ns), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (i_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_convOut, i_cpu_convOut);
          }

          ecc_filtfilt_kernel158<<<grid, block>>>(l_gpu_convOut, b_na, nb, b_nb,
            k_gpu_a, iv0, ns, d_gpu_zfIIR, i_cpu_a->size[0U], e_cpu_zfIIR->size
            [0U], i_cpu_convOut->size[0U]);
          d_zfIIR_dirtyOnGpu = true;
        }

        i = e_cpu_zfIIR->size[0] * e_cpu_zfIIR->size[1];
        e_cpu_zfIIR->size[0] = zfSize_idx_0;
        e_cpu_zfIIR->size[1] = c_na;
        emxEnsureCapacity_real_T(e_cpu_zfIIR, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_cpu_zfIIR, &d_gpu_zfIIR);
      }

      c_na = n_cpu_y->size[0];
      i = k_cpu_b->size[0];
      k_cpu_b->size[0] = cpu_b2->size[0];
      emxEnsureCapacity_real_T(k_cpu_b, i, &fb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(k_cpu_b, &l_gpu_b);
      iv0 = cpu_b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel159<<<grid, block>>>(gpu_b2, iv0, l_gpu_b);
        k_b_dirtyOnGpu = true;
      }

      i = k_cpu_a->size[0];
      k_cpu_a->size[0] = cpu_a2->size[0];
      emxEnsureCapacity_real_T(k_cpu_a, i, &fb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(k_cpu_a, &l_gpu_a);
      iv0 = cpu_a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel160<<<grid, block>>>(gpu_a2, iv0, l_gpu_a);
      }

      if ((!std::isinf(cpu_a2->data[0])) && (!std::isnan(cpu_a2->data[0])) &&
          (!(cpu_a2->data[0] == 0.0)) && (cpu_a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(e_nb),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel161<<<grid, block>>>(c_gpu_a1, e_nb, l_gpu_b);
          k_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(e_na -
          1L), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel162<<<grid, block>>>(c_gpu_a1, e_na, l_gpu_a);
        }

        ecc_filtfilt_kernel163<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(l_gpu_a);
      }

      if (k_cpu_a->size[0] > k_cpu_b->size[0]) {
        csz_idx_0 = k_cpu_a->size[0] - k_cpu_b->size[0];
        i = k_cpu_b->size[0];
        iv0 = k_cpu_b->size[0];
        k_cpu_b->size[0] = k_cpu_a->size[0];
        emxEnsureCapacity_real_T(k_cpu_b, iv0, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_cpu_b, &l_gpu_b);
        if (csz_idx_0 - 1 >= 0) {
          if (k_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(k_cpu_b, &l_gpu_b);
          }

          std::memset(&k_cpu_b->data[i], 0, static_cast<uint32_T>(csz_idx_0) *
                      sizeof(real_T));
          k_b_dirtyOnCpu = true;
        }
      }

      if (n_cpu_y->size[1] == 0) {
        cpu_yc5->size[0] = c_na;
        cpu_yc5->size[1] = 0;
      } else {
        cpu_dv1[0] = static_cast<uint32_T>(k_cpu_b->size[0]);
        OH = (static_cast<uint32_T>(c_na) + static_cast<uint32_T>(k_cpu_b->size
               [0])) - 1U;
        x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        idx = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (n_cpu_y->size[1]) + 1.0) - 1.0));
        c = n_cpu_y->size[1];
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = k_cpu_b->size[0];
        vlen = static_cast<int32_T>(std::floor(static_cast<real_T>(k_cpu_b->
          size[0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (k_cpu_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (k_cpu_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = static_cast<int32_T>(u) + k_cpu_b->size[0];
        }

        i = k_cpu_expanded->size[0] * k_cpu_expanded->size[1];
        k_cpu_expanded->size[0] = nfilt - 1;
        emxEnsureCapacity_real_T(k_cpu_expanded, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_cpu_expanded, &h_gpu_expanded);
        if (n_cpu_y->size[1] > 2147483646) {
          nfilt = MAX_int32_T;
        } else {
          nfilt = n_cpu_y->size[1] + 1;
        }

        i = k_cpu_expanded->size[0] * k_cpu_expanded->size[1];
        k_cpu_expanded->size[1] = nfilt - 1;
        emxEnsureCapacity_real_T(k_cpu_expanded, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_cpu_expanded, &h_gpu_expanded);
        na = ((static_cast<int32_T>(u) + static_cast<int32_T>(cpu_dv1[0])) - 1) *
          n_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel164<<<grid, block>>>(na, h_gpu_expanded);
        }

        i = eb_cpu_y->size[0] * eb_cpu_y->size[1];
        eb_cpu_y->size[0] = 1;
        eb_cpu_y->size[1] = c_na;
        emxEnsureCapacity_int32_T(eb_cpu_y, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(eb_cpu_y, &r_gpu_y);
        eb_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= c_na - 2; iv0++) {
          nfilt++;
          eb_cpu_y->data[iv0 + 1] = nfilt;
        }

        i = cpu_iv16->size[0];
        cpu_iv16->size[0] = eb_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv16, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv16, &gpu_iv16);
        iv0 = eb_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&r_gpu_y, eb_cpu_y);
          ecc_filtfilt_kernel165<<<grid, block>>>(vlen, r_gpu_y, iv0, gpu_iv16);
        }

        ns = n_cpu_y->size[1];
        i = fb_cpu_y->size[0] * fb_cpu_y->size[1];
        fb_cpu_y->size[0] = 1;
        fb_cpu_y->size[1] = n_cpu_y->size[1];
        emxEnsureCapacity_int32_T(fb_cpu_y, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(fb_cpu_y, &s_gpu_y);
        fb_cpu_y->data[0] = 1;
        nfilt = 1;
        for (iv0 = 0; iv0 <= ns - 2; iv0++) {
          nfilt++;
          fb_cpu_y->data[iv0 + 1] = nfilt;
        }

        i = cpu_iv17->size[0];
        cpu_iv17->size[0] = fb_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv17, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cpu_iv17, &gpu_iv17);
        iv0 = fb_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&s_gpu_y, fb_cpu_y);
          ecc_filtfilt_kernel166<<<grid, block>>>(s_gpu_y, iv0, gpu_iv17);
        }

        iv0 = n_cpu_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_na *
          (iv0 + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel167<<<grid, block>>>(t_gpu_y, gpu_iv17, gpu_iv16,
            c_na, iv0, h_gpu_expanded, k_cpu_expanded->size[0U], n_cpu_y->size
            [0U]);
        }

        i = l_cpu_rows->size[0] * l_cpu_rows->size[1];
        l_cpu_rows->size[0] = 1;
        l_cpu_rows->size[1] = static_cast<int32_T>(cpu_dv1[0]);
        emxEnsureCapacity_int32_T(l_cpu_rows, i, &lb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(l_cpu_rows, &h_gpu_rows);
        l_cpu_rows->data[0] = 0;
        nfilt = 0;
        for (iv0 = 0; iv0 <= thism - 2; iv0++) {
          nfilt++;
          l_cpu_rows->data[iv0 + 1] = nfilt;
        }

        i = k_cpu_convOut->size[0] * k_cpu_convOut->size[1];
        k_cpu_convOut->size[0] = static_cast<int32_T>(u);
        k_cpu_convOut->size[1] = n_cpu_y->size[1];
        emxEnsureCapacity_real_T(k_cpu_convOut, i, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_cpu_convOut, &i_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(x) - 1.0)) / static_cast<real_T>(x))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(n_cpu_y->size[1]) + static_cast<uint32_T>(idx))
                    - 1.0) / static_cast<real_T>(idx))), 1U);
        r1 = dim3(static_cast<uint32_T>(x), static_cast<uint32_T>(idx), 1U);
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(
          static_cast<int64_T>(static_cast<int32_T>(u)) * c), r, r1, &grid,
          &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&h_gpu_rows, l_cpu_rows);
          if (k_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_b, k_cpu_b);
          }

          ecc_filtfilt_kernel168<<<grid, block>>>(h_gpu_expanded, h_gpu_rows,
            l_gpu_b, static_cast<int32_T>(u), c, i_gpu_convOut, k_cpu_b->size[0U],
            k_cpu_expanded->size[0U], k_cpu_convOut->size[0U]);
          k_convOut_dirtyOnGpu = true;
        }

        if ((e_cpu_zfIIR->size[0] != 0) && (e_cpu_zfIIR->size[1] != 0)) {
          if (e_cpu_zfIIR->size[0] == 1) {
            ns = k_cpu_convOut->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel172<<<grid, block>>>(d_gpu_zfIIR, ns,
                i_gpu_convOut, e_cpu_zfIIR->size[1U], k_cpu_convOut->size[0U],
                e_cpu_zfIIR->size[0U]);
            }
          } else if (e_cpu_zfIIR->size[1] == 1) {
            ns = k_cpu_convOut->size[1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
              &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel171<<<grid, block>>>(d_gpu_zfIIR, ns,
                i_gpu_convOut, e_cpu_zfIIR->size[0U], k_cpu_convOut->size[0U]);
            }
          } else if (k_cpu_convOut->size[1] == e_cpu_zfIIR->size[1]) {
            i = e_cpu_zfIIR->size[0];
            iv0 = t_cpu_convOut->size[0] * t_cpu_convOut->size[1];
            t_cpu_convOut->size[0] = e_cpu_zfIIR->size[0];
            t_cpu_convOut->size[1] = k_cpu_convOut->size[1];
            emxEnsureCapacity_real_T(t_cpu_convOut, iv0, &db_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(t_cpu_convOut, &k_gpu_convOut);
            na = k_cpu_convOut->size[1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i *
              (na + 1L)), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel169<<<grid, block>>>(d_gpu_zfIIR, i_gpu_convOut,
                i, na, k_gpu_convOut, t_cpu_convOut->size[0U],
                k_cpu_convOut->size[0U], e_cpu_zfIIR->size[0U]);
            }

            na = t_cpu_convOut->size[1] - 1;
            iv0 = t_cpu_convOut->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (na + 1L)), &grid, &block, 1024U, 3584U);
            if (validLaunchParams) {
              ecc_filtfilt_kernel170<<<grid, block>>>(k_gpu_convOut, iv0, na,
                i_gpu_convOut, k_cpu_convOut->size[0U], t_cpu_convOut->size[0U]);
            }
          } else {
            if (k_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(k_cpu_convOut, &i_gpu_convOut);
            }

            if (d_zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_cpu_zfIIR, &d_gpu_zfIIR);
            }

            binary_expand_op(k_cpu_convOut, e_cpu_zfIIR);
            k_convOut_dirtyOnCpu = true;
          }
        }

        ns = k_cpu_convOut->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (k_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_convOut, k_cpu_convOut);
          }

          ecc_filtfilt_kernel173<<<grid, block>>>(l_gpu_a, c_na, ns,
            i_gpu_convOut, k_cpu_a->size[0U], k_cpu_convOut->size[0U]);
          k_convOut_dirtyOnCpu = false;
        }

        i = s_cpu_convOut->size[0] * s_cpu_convOut->size[1];
        s_cpu_convOut->size[0] = c_na;
        s_cpu_convOut->size[1] = k_cpu_convOut->size[1];
        emxEnsureCapacity_real_T(s_cpu_convOut, i, &db_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(s_cpu_convOut, &j_gpu_convOut);
        na = k_cpu_convOut->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_na *
          (na + 1L)), &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          if (k_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_convOut, k_cpu_convOut);
          }

          ecc_filtfilt_kernel174<<<grid, block>>>(i_gpu_convOut, c_na, na,
            j_gpu_convOut, s_cpu_convOut->size[0U], k_cpu_convOut->size[0U]);
        }

        ecc_filtfilt_kernel175<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(c_na,
          *e_gpu_x, n_cpu_y->size[1U]);
        i = cpu_yc5->size[0] * cpu_yc5->size[1];
        cpu_yc5->size[0] = c_na;
        cpu_yc5->size[1] = n_cpu_y->size[1];
        emxEnsureCapacity_real_T(cpu_yc5, i, &dc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(cpu_yc5, &gpu_yc5);
        cudaMemcpy(e_cpu_x, *e_gpu_x, 8UL, cudaMemcpyDeviceToHost);
        x = e_cpu_x[0] * e_cpu_x[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x + 1L),
          &grid, &block, 1024U, 3584U);
        if (validLaunchParams) {
          ecc_filtfilt_kernel176<<<grid, block>>>(j_gpu_convOut, x, gpu_yc5);
        }
      }

      i = cpu_xc1->size[0] * cpu_xc1->size[1];
      cpu_xc1->size[0] = cpu_yc5->size[0];
      cpu_xc1->size[1] = cpu_yc5->size[1];
      emxEnsureCapacity_real_T(cpu_xc1, i, &ac_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_xc1, &gpu_xc1);
      iv0 = cpu_yc5->size[1] - 1;
      csz_idx_0 = cpu_yc5->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((csz_idx_0
        + 1L) * (iv0 + 1L)), &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        ecc_filtfilt_kernel177<<<grid, block>>>(gpu_yc5, csz_idx_0, iv0, gpu_xc1,
          cpu_xc1->size[0U], cpu_yc5->size[0U]);
      }

      e_cpu_x[0] = static_cast<int32_T>(sz[0]);
      e_cpu_x[1] = static_cast<int32_T>(sz[1]);
      i = cpu_x->size[0] * cpu_x->size[1];
      cpu_x->size[0] = static_cast<int32_T>(sz[0]);
      cpu_x->size[1] = static_cast<int32_T>(sz[1]);
      emxEnsureCapacity_real_T(cpu_x, i, &ab_emlrtRTEI);
      if (!x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(cpu_x, &b_gpu_x);
      }

      x = e_cpu_x[1] - 1;
      iv0 = e_cpu_x[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 + 1L)
        * (x + 1L)), &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        cudaMemcpy(*e_gpu_x, e_cpu_x, 8UL, cudaMemcpyHostToDevice);
        if (x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
        }

        ecc_filtfilt_kernel178<<<grid, block>>>(gpu_xc1, *e_gpu_x, e_cpu_x[0] -
          1, x, b_gpu_x, cpu_x->size[0U]);
        x_dirtyOnGpu = true;
        x_dirtyOnCpu = false;
      }
    }

    if (xIsRow) {
      i = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = 1;
      b_cpu_x->size[1] = cpu_x->size[0];
      emxEnsureCapacity_real_T(b_cpu_x, i, &t_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_cpu_x, &gpu_x);
      x = cpu_x->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        if (x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
        }

        x_dirtyOnCpu = false;
        ecc_filtfilt_kernel274<<<grid, block>>>(b_gpu_x, x, gpu_x);
      }
    } else {
      i = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = cpu_x->size[0];
      b_cpu_x->size[1] = cpu_x->size[1];
      emxEnsureCapacity_real_T(b_cpu_x, i, &t_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_cpu_x, &gpu_x);
      x = cpu_x->size[0] * cpu_x->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(x + 1L),
        &grid, &block, 1024U, 3584U);
      if (validLaunchParams) {
        if (x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
        }

        x_dirtyOnCpu = false;
        ecc_filtfilt_kernel273<<<grid, block>>>(b_gpu_x, x, gpu_x);
      }
    }
  }

  emxFree_real_T(&u_cpu_convOut);
  emxFree_real_T(&t_cpu_convOut);
  emxFree_real_T(&s_cpu_convOut);
  emxFree_real_T(&r_cpu_convOut);
  emxFree_real_T(&q_cpu_convOut);
  emxFree_real_T(&p_cpu_convOut);
  emxFree_real_T(&o_cpu_convOut);
  emxFree_real_T(&n_cpu_convOut);
  emxFree_real_T(&m_cpu_convOut);
  emxFree_real_T(&b_cpu_sosMat);
  emxFree_real_T(&l_cpu_convOut);
  emxFree_real_T(&k_cpu_convOut);
  emxFree_int32_T(&m_cpu_rows);
  emxFree_real_T(&f_cpu_zfIIR);
  emxFree_int32_T(&l_cpu_rows);
  emxFree_real_T(&e_cpu_zfIIR);
  emxFree_int32_T(&cpu_iv18);
  emxFree_int32_T(&cpu_iv17);
  emxFree_int32_T(&gb_cpu_y);
  emxFree_real_T(&l_cpu_expanded);
  emxFree_int32_T(&fb_cpu_y);
  emxFree_int32_T(&cpu_iv16);
  emxFree_real_T(&j_cpu_convOut);
  emxFree_real_T(&i_cpu_convOut);
  emxFree_int32_T(&k_cpu_rows);
  emxFree_int32_T(&eb_cpu_y);
  emxFree_int32_T(&j_cpu_rows);
  emxFree_real_T(&k_cpu_expanded);
  emxFree_int32_T(&cpu_iv15);
  emxFree_int32_T(&cpu_iv14);
  emxFree_real_T(&l_cpu_a);
  emxFree_int32_T(&db_cpu_y);
  emxFree_real_T(&l_cpu_b);
  emxFree_real_T(&j_cpu_expanded);
  emxFree_real_T(&cpu_yc5);
  emxFree_int32_T(&cb_cpu_y);
  emxFree_int32_T(&cpu_iv13);
  emxFree_real_T(&h_cpu_convOut);
  emxFree_int32_T(&bb_cpu_y);
  emxFree_real_T(&i_cpu_expanded);
  emxFree_real_T(&g_cpu_convOut);
  emxFree_int32_T(&i_cpu_rows);
  emxFree_real_T(&k_cpu_a);
  emxFree_real_T(&k_cpu_b);
  emxFree_int32_T(&h_cpu_rows);
  emxFree_real_T(&j_cpu_a);
  emxFree_real_T(&d_cpu_zfIIR);
  emxFree_real_T(&j_cpu_b);
  emxFree_int32_T(&cpu_iv11);
  emxFree_real_T(&ab_cpu_y);
  emxFree_int32_T(&y_cpu_y);
  emxFree_real_T(&h_cpu_expanded);
  emxFree_int32_T(&x_cpu_y);
  emxFree_int32_T(&cpu_iv10);
  emxFree_real_T(&b_cpu_yc3);
  emxFree_int32_T(&c_cpu_counts);
  emxFree_real_T(&f_cpu_convOut);
  emxFree_real_T(&c_cpu_zfIIR);
  emxFree_real_T(&e_cpu_convOut);
  emxFree_real_T(&c_cpu_zi);
  emxFree_real_T(&i_cpu_a);
  emxFree_real_T(&i_cpu_b);
  emxFree_real_T(&w_cpu_y);
  emxFree_int32_T(&v_cpu_y);
  emxFree_int32_T(&g_cpu_rows);
  emxFree_real_T(&g_cpu_expanded);
  emxFree_int32_T(&f_cpu_rows);
  emxFree_int32_T(&b_cpu_counts);
  emxFree_real_T(&b_cpu_outBuff);
  emxFree_int32_T(&cpu_counts);
  emxFree_real_T(&h_cpu_a);
  emxFree_real_T(&h_cpu_b);
  emxFree_int32_T(&cpu_iv8);
  emxFree_real_T(&cpu_outBuff);
  emxFree_real_T(&d_cpu_convOut);
  emxFree_int32_T(&d_cpu_y_rowidx);
  emxFree_real_T(&cpu_yc3);
  emxFree_int32_T(&c_cpu_y_colidx);
  emxFree_int32_T(&u_cpu_y);
  emxFree_real_T(&d_cpu_y_d);
  emxFree_int32_T(&t_cpu_y);
  emxFree_real_T(&f_cpu_expanded);
  emxFree_real_T(&e_cpu_expanded);
  emxFree_int32_T(&e_cpu_rows);
  emxFree_real_T(&b_cpu_zfIIR);
  emxFree_int32_T(&cpu_iv6);
  emxFree_int32_T(&c_cpu_y_rowidx);
  emxFree_int32_T(&b_cpu_y_rowidx);
  emxFree_real_T(&s_cpu_y);
  emxFree_int32_T(&b_cpu_y_colidx);
  emxFree_int32_T(&cpu_y_colidx);
  emxFree_real_T(&c_cpu_y_d);
  emxFree_real_T(&b_cpu_y_d);
  emxFree_real_T(&g_cpu_a);
  emxFree_real_T(&g_cpu_b);
  emxFree_int32_T(&r_cpu_y);
  emxFree_int32_T(&cpu_iv5);
  emxFree_real_T(&c_cpu_convOut);
  emxFree_real_T(&f_cpu_a);
  emxFree_real_T(&e_cpu_a);
  emxFree_real_T(&q_cpu_y);
  emxFree_real_T(&f_cpu_b);
  emxFree_real_T(&e_cpu_b);
  emxFree_int32_T(&d_cpu_rows);
  emxFree_real_T(&p_cpu_y);
  emxFree_int32_T(&o_cpu_y);
  emxFree_real_T(&d_cpu_expanded);
  emxFree_int32_T(&cpu_iv4);
  emxFree_real_T(&cpu_zfIIR);
  emxFree_real_T(&n_cpu_y);
  emxFree_int32_T(&m_cpu_y);
  emxFree_real_T(&b_cpu_convOut);
  emxFree_int32_T(&cpu_iv3);
  emxFree_int32_T(&b_cpu_t);
  emxFree_int32_T(&c_cpu_rows);
  emxFree_real_T(&cpu_convOut);
  emxFree_int32_T(&l_cpu_y);
  emxFree_real_T(&c_cpu_expanded);
  emxFree_int32_T(&cpu_t);
  emxFree_int32_T(&b_cpu_rows);
  emxFree_real_T(&d_cpu_a);
  emxFree_real_T(&d_cpu_b);
  emxFree_int32_T(&cpu_sortedIndices);
  emxFree_int32_T(&k_cpu_y);
  emxFree_real_T(&b_cpu_expanded);
  emxFree_int32_T(&cpu_cidxInt);
  emxFree_int32_T(&j_cpu_y);
  emxFree_real_T(&cpu_expanded);
  emxFree_int32_T(&cpu_ridxInt);
  emxFree_int32_T(&cpu_y_rowidx);
  emxFree_int32_T(&y_colidx);
  emxFree_real_T(&cpu_y_d);
  emxFree_real_T(&b_cpu_zi);
  emxFree_real_T(&cpu_rhs);
  emxFree_real_T(&c_cpu_a);
  emxFree_real_T(&c_cpu_b);
  emxFree_real_T(&i_cpu_y);
  emxFree_real_T(&b_cpu_a);
  emxFree_real_T(&b_cpu_b);
  emxFree_int8_T(&cpu_vals);
  emxFree_real_T(&h_cpu_y);
  emxFree_real_T(&cpu_ytemp);
  emxFree_real_T(&b_cpu_xt);
  emxFree_real_T(&cpu_a);
  emxFree_int32_T(&cpu_cols);
  emxFree_real_T(&cpu_b);
  emxFree_real_T(&g_cpu_y);
  emxFree_real_T(&f_cpu_y);
  emxFree_int32_T(&e_cpu_y);
  emxFree_real_T(&cpu_xt);
  emxFree_boolean_T(&d_cpu_x);
  emxFree_real_T(&cpu_xc1);
  emxFree_int32_T(&d_cpu_y);
  emxFree_real_T(&cpu_maxCoefNum);
  emxFree_int32_T(&cpu_rows);
  emxFree_real_T(&cpu_yCol);
  emxFree_int32_T(&c_cpu_y);
  emxFree_boolean_T(&c_cpu_x);
  emxFree_real_T(&b_cpu_y);
  emxFree_int32_T(&cpu_y);
  emxFree_real_T(&cpu_b1);
  emxFree_real_T(&cpu_a2);
  emxFree_real_T(&cpu_b2);
  emxFree_real_T(&cpu_sosMat);
  emxFree_real_T(&cpu_zi);
  i = cpu_x->size[0] * cpu_x->size[1];
  cpu_x->size[0] = b_cpu_x->size[0];
  cpu_x->size[1] = b_cpu_x->size[1];
  emxEnsureCapacity_real_T(cpu_x, i, &c_emlrtRTEI);
  if (!x_dirtyOnCpu) {
    gpuEmxEnsureCapacity_real_T(cpu_x, &b_gpu_x);
  }

  x = b_cpu_x->size[1] - 1;
  iv0 = b_cpu_x->size[0] - 1;
  validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 + 1L) *
    (x + 1L)), &grid, &block, 1024U, 3584U);
  if (validLaunchParams) {
    if (x_dirtyOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
    }

    ecc_filtfilt_kernel275<<<grid, block>>>(gpu_x, iv0, x, b_gpu_x, cpu_x->size
      [0U], b_cpu_x->size[0U]);
    x_dirtyOnGpu = true;
  }

  emxFree_real_T(&b_cpu_x);

  //  % filtfilt
  //  coder.gpu.kernel(nChs,-1)
  //  for ch = 1:nChs
  //       x(:,ch) = filtfilt(coef,1,x(:,ch));
  //  end
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(cpu_x, &b_gpu_x);
  }

  gpuEmxFree_real_T(&b_gpu_x);
  gpuEmxFree_real_T(&gpu_coef);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_zi);
  gpuEmxFree_real_T(&gpu_sosMat);
  gpuEmxFree_real_T(&gpu_b2);
  gpuEmxFree_real_T(&gpu_a2);
  gpuEmxFree_real_T(&gpu_b1);
  gpuEmxFree_int32_T(&db_gpu_y);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_boolean_T(&d_gpu_x);
  gpuEmxFree_int32_T(&eb_gpu_y);
  gpuEmxFree_real_T(&gpu_yCol);
  gpuEmxFree_int32_T(&m_gpu_rows);
  gpuEmxFree_real_T(&gpu_maxCoefNum);
  gpuEmxFree_int32_T(&fb_gpu_y);
  gpuEmxFree_real_T(&gpu_xc1);
  gpuEmxFree_boolean_T(&c_gpu_x);
  gpuEmxFree_real_T(&gpu_xt);
  gpuEmxFree_int32_T(&gb_gpu_y);
  gpuEmxFree_real_T(&f_gpu_y);
  gpuEmxFree_real_T(&n_gpu_y);
  gpuEmxFree_real_T(&c_gpu_b);
  gpuEmxFree_int32_T(&gpu_cols);
  gpuEmxFree_real_T(&c_gpu_a);
  gpuEmxFree_real_T(&b_gpu_xt);
  gpuEmxFree_real_T(&gpu_ytemp);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_int8_T(&gpu_vals);
  gpuEmxFree_real_T(&gpu_b);
  gpuEmxFree_real_T(&gpu_a);
  gpuEmxFree_real_T(&o_gpu_y);
  gpuEmxFree_real_T(&h_gpu_b);
  gpuEmxFree_real_T(&h_gpu_a);
  gpuEmxFree_real_T(&b_gpu_rhs);
  gpuEmxFree_real_T(&b_gpu_zi);
  gpuEmxFree_real_T(&gpu_y_d);
  gpuEmxFree_int32_T(&gpu_y_rowidx);
  gpuEmxFree_int32_T(&gpu_ridxInt);
  gpuEmxFree_real_T(&c_gpu_expanded);
  gpuEmxFree_int32_T(&g_gpu_y);
  gpuEmxFree_int32_T(&gpu_cidxInt);
  gpuEmxFree_real_T(&gpu_expanded);
  gpuEmxFree_int32_T(&c_gpu_y);
  gpuEmxFree_int32_T(&gpu_sortedIndices);
  gpuEmxFree_real_T(&i_gpu_b);
  gpuEmxFree_real_T(&i_gpu_a);
  gpuEmxFree_int32_T(&c_gpu_rows);
  gpuEmxFree_int32_T(&gpu_t);
  gpuEmxFree_real_T(&l_gpu_expanded);
  gpuEmxFree_int32_T(&bb_gpu_y);
  gpuEmxFree_real_T(&c_gpu_convOut);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_int32_T(&b_gpu_t);
  gpuEmxFree_int32_T(&gpu_iv3);
  gpuEmxFree_real_T(&gpu_convOut);
  gpuEmxFree_int32_T(&cb_gpu_y);
  gpuEmxFree_real_T(&t_gpu_y);
  gpuEmxFree_real_T(&gpu_zfIIR);
  gpuEmxFree_int32_T(&gpu_iv4);
  gpuEmxFree_real_T(&k_gpu_expanded);
  gpuEmxFree_int32_T(&y_gpu_y);
  gpuEmxFree_real_T(&d_gpu_y);
  gpuEmxFree_int32_T(&l_gpu_rows);
  gpuEmxFree_real_T(&d_gpu_b);
  gpuEmxFree_real_T(&b_gpu_b);
  gpuEmxFree_real_T(&p_gpu_y);
  gpuEmxFree_real_T(&d_gpu_a);
  gpuEmxFree_real_T(&b_gpu_a);
  gpuEmxFree_real_T(&t_gpu_convOut);
  gpuEmxFree_int32_T(&gpu_iv5);
  gpuEmxFree_int32_T(&ab_gpu_y);
  gpuEmxFree_real_T(&j_gpu_b);
  gpuEmxFree_real_T(&j_gpu_a);
  gpuEmxFree_real_T(&d_gpu_y_d);
  gpuEmxFree_real_T(&b_gpu_y_d);
  gpuEmxFree_int32_T(&c_gpu_y_colidx);
  gpuEmxFree_int32_T(&gpu_y_colidx);
  gpuEmxFree_real_T(&i_gpu_y);
  gpuEmxFree_int32_T(&d_gpu_y_rowidx);
  gpuEmxFree_int32_T(&b_gpu_y_rowidx);
  gpuEmxFree_int32_T(&gpu_iv6);
  gpuEmxFree_real_T(&f_gpu_zfIIR);
  gpuEmxFree_int32_T(&k_gpu_rows);
  gpuEmxFree_real_T(&b_gpu_expanded);
  gpuEmxFree_real_T(&d_gpu_expanded);
  gpuEmxFree_int32_T(&e_gpu_y);
  gpuEmxFree_real_T(&c_gpu_y_d);
  gpuEmxFree_int32_T(&h_gpu_y);
  gpuEmxFree_int32_T(&b_gpu_y_colidx);
  gpuEmxFree_real_T(&b_gpu_yc3);
  gpuEmxFree_int32_T(&c_gpu_y_rowidx);
  gpuEmxFree_real_T(&q_gpu_convOut);
  gpuEmxFree_real_T(&b_gpu_outBuff);
  gpuEmxFree_int32_T(&gpu_iv8);
  gpuEmxFree_real_T(&e_gpu_b);
  gpuEmxFree_real_T(&e_gpu_a);
  gpuEmxFree_int32_T(&c_gpu_counts);
  gpuEmxFree_real_T(&gpu_outBuff);
  gpuEmxFree_int32_T(&gpu_counts);
  gpuEmxFree_int32_T(&b_gpu_rows);
  gpuEmxFree_real_T(&j_gpu_expanded);
  gpuEmxFree_int32_T(&d_gpu_rows);
  gpuEmxFree_int32_T(&w_gpu_y);
  gpuEmxFree_real_T(&q_gpu_y);
  gpuEmxFree_real_T(&k_gpu_b);
  gpuEmxFree_real_T(&k_gpu_a);
  gpuEmxFree_real_T(&c_gpu_zi);
  gpuEmxFree_real_T(&b_gpu_convOut);
  gpuEmxFree_real_T(&e_gpu_zfIIR);
  gpuEmxFree_real_T(&d_gpu_convOut);
  gpuEmxFree_int32_T(&b_gpu_counts);
  gpuEmxFree_real_T(&gpu_yc3);
  gpuEmxFree_int32_T(&gpu_iv10);
  gpuEmxFree_int32_T(&x_gpu_y);
  gpuEmxFree_real_T(&g_gpu_expanded);
  gpuEmxFree_int32_T(&m_gpu_y);
  gpuEmxFree_real_T(&j_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv11);
  gpuEmxFree_real_T(&f_gpu_b);
  gpuEmxFree_real_T(&b_gpu_zfIIR);
  gpuEmxFree_real_T(&f_gpu_a);
  gpuEmxFree_int32_T(&j_gpu_rows);
  gpuEmxFree_real_T(&l_gpu_b);
  gpuEmxFree_real_T(&l_gpu_a);
  gpuEmxFree_int32_T(&g_gpu_rows);
  gpuEmxFree_real_T(&n_gpu_convOut);
  gpuEmxFree_real_T(&i_gpu_expanded);
  gpuEmxFree_int32_T(&u_gpu_y);
  gpuEmxFree_real_T(&h_gpu_convOut);
  gpuEmxFree_int32_T(&gpu_iv13);
  gpuEmxFree_int32_T(&v_gpu_y);
  gpuEmxFree_real_T(&gpu_yc5);
  gpuEmxFree_real_T(&f_gpu_expanded);
  gpuEmxFree_real_T(&g_gpu_b);
  gpuEmxFree_int32_T(&l_gpu_y);
  gpuEmxFree_real_T(&g_gpu_a);
  gpuEmxFree_int32_T(&gpu_iv14);
  gpuEmxFree_int32_T(&gpu_iv15);
  gpuEmxFree_real_T(&h_gpu_expanded);
  gpuEmxFree_int32_T(&i_gpu_rows);
  gpuEmxFree_int32_T(&r_gpu_y);
  gpuEmxFree_int32_T(&f_gpu_rows);
  gpuEmxFree_real_T(&l_gpu_convOut);
  gpuEmxFree_real_T(&g_gpu_convOut);
  gpuEmxFree_int32_T(&gpu_iv16);
  gpuEmxFree_int32_T(&s_gpu_y);
  gpuEmxFree_real_T(&e_gpu_expanded);
  gpuEmxFree_int32_T(&k_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv17);
  gpuEmxFree_int32_T(&gpu_iv18);
  gpuEmxFree_real_T(&d_gpu_zfIIR);
  gpuEmxFree_int32_T(&h_gpu_rows);
  gpuEmxFree_real_T(&c_gpu_zfIIR);
  gpuEmxFree_int32_T(&e_gpu_rows);
  gpuEmxFree_real_T(&i_gpu_convOut);
  gpuEmxFree_real_T(&e_gpu_convOut);
  gpuEmxFree_real_T(&b_gpu_sosMat);
  gpuEmxFree_real_T(&u_gpu_convOut);
  gpuEmxFree_real_T(&s_gpu_convOut);
  gpuEmxFree_real_T(&r_gpu_convOut);
  gpuEmxFree_real_T(&o_gpu_convOut);
  gpuEmxFree_real_T(&p_gpu_convOut);
  gpuEmxFree_real_T(&m_gpu_convOut);
  gpuEmxFree_real_T(&j_gpu_convOut);
  gpuEmxFree_real_T(&k_gpu_convOut);
  gpuEmxFree_real_T(&f_gpu_convOut);
  mwCudaFree(*e_gpu_x);
  mwCudaFree(*gpu_dv1);
  mwCudaFree(b_gpu_a1);
  mwCudaFree(gpu_a1);
  mwCudaFree(e_gpu_a1);
  mwCudaFree(d_gpu_a1);
  mwCudaFree(*gpu_zfSize);
  mwCudaFree(c_gpu_a1);
  mwCudaFree(gpu_d);
  mwCudaFree(*gpu_nZeroLastDen_data);
  mwCudaFree(*gpu_a0);
  mwCudaFree(*gpu_rhs);
  mwCudaFree(*gpu_I);
  mwCudaFree(*gpu_Y);
  mwCudaFree(*gpu_A);
}

void ecc_filtfilt_api(const mxArray * const prhs[2], const mxArray *plhs[1])
{
  emxArray_real_T *coef;
  emxArray_real_T *x;
  const mxArray *prhs_copy_idx_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  prhs_copy_idx_0 = emlrtProtectR2012b(prhs[0], 0, true, -1);

  // Marshall function inputs
  emxInit_real_T(&x, 2, &emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs_copy_idx_0), "x", x);
  emxInit_real_T(&coef, 2, &emlrtRTEI, true);
  coef->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[1]), "coef", coef);

  // Invoke the target function
  ecc_filtfilt(x, coef);
  emxFree_real_T(&coef);

  // Marshall function outputs
  x->canFreeData = false;
  emlrt_marshallOut(x, prhs_copy_idx_0);
  emxFree_real_T(&x);
  plhs[0] = prhs_copy_idx_0;
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ecc_filtfilt_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void ecc_filtfilt_initialize()
{
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "distrib_computing_toolbox", 2);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "signal_toolbox", 2);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    ecc_filtfilt_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ecc_filtfilt_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode), (char_T *)
                       cudaGetErrorName(errCode), (char_T *)cudaGetErrorString
                       (errCode), (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }

  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  mwMemoryManagerTerminate();
}

// End of code generation (ecc_filtfilt.cu)
