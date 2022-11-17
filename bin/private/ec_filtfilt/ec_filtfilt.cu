//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt.cu
//
// Code generation for function 'ec_filtfilt'
//

// Include files
#include "ec_filtfilt.h"
#include "_coder_ec_filtfilt_mex.h"
#include "ec_filtfilt_types.h"
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

struct emxArray_uint32_T
{
  uint32_T *data;
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

struct emxArray_struct_T
{
  struct_T *data;
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
  "ec_filtfilt",                       // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 3615363707U, 2875872051U, 2733369800U, 3255517249U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtMCInfo emlrtMCI{ 14,       // lineNo
  25,                                  // colNo
  "warning",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/lib/+coder/+internal/warning.m"// pName
};

static emlrtMCInfo b_emlrtMCI{ 14,     // lineNo
  9,                                   // colNo
  "warning",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/lib/+coder/+internal/warning.m"// pName
};

static emlrtMCInfo c_emlrtMCI{ 53,     // lineNo
  19,                                  // colNo
  "flt2str",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/flt2str.m"// pName
};

static emlrtRTEInfo emlrtRTEI{ 132,    // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo b_emlrtRTEI{ 130,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 138,  // lineNo
  56,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 180,  // lineNo
  25,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 239,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 108,  // lineNo
  18,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 240,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 110,  // lineNo
  13,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 108,  // lineNo
  13,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 253,  // lineNo
  13,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 30,   // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 28,   // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 397,  // lineNo
  5,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 829,  // lineNo
  21,                                  // colNo
  "unaryMinOrMax",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 266,  // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 145,  // lineNo
  8,                                   // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 291,  // lineNo
  5,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 154,  // lineNo
  13,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 162,  // lineNo
  25,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 339,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 8,    // lineNo
  1,                                   // colNo
  "ec_filtfilt",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/bin/src_mex/ec_filtfilt.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 149,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 76,   // lineNo
  9,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 422,  // lineNo
  24,                                  // colNo
  "find",                              // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/find.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 340,  // lineNo
  25,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 294, // lineNo
  20,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 60,  // lineNo
  20,                                  // colNo
  "bsxfun",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/bsxfun.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 267, // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 162, // lineNo
  5,                                   // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 340, // lineNo
  33,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 294, // lineNo
  28,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 88,  // lineNo
  9,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 170, // lineNo
  5,                                   // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 401, // lineNo
  25,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "gpufilterImpl",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/gpufilterImpl.p"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 211, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 212, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 401, // lineNo
  33,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 268, // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "stencil_codegen",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+gpucoder/+internal/stencil_codegen.p"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 172, // lineNo
  20,                                  // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 402, // lineNo
  27,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 269, // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 402, // lineNo
  35,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 1653,// lineNo
  27,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 125, // lineNo
  44,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 1682,// lineNo
  5,                                   // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 404, // lineNo
  22,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 295, // lineNo
  5,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 404, // lineNo
  30,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 341, // lineNo
  27,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 13,  // lineNo
  1,                                   // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/sparfun/sparse.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 193, // lineNo
  42,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 341, // lineNo
  35,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 296, // lineNo
  20,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 296, // lineNo
  28,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 406, // lineNo
  25,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 395, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 406, // lineNo
  33,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 270, // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 388, // lineNo
  38,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 405, // lineNo
  46,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 399, // lineNo
  46,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 407, // lineNo
  22,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 407, // lineNo
  30,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 32,  // lineNo
  1,                                   // colNo
  "locTranspose",                      // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/locTranspose.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 409, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 342, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 143, // lineNo
  13,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 343, // lineNo
  22,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 343, // lineNo
  30,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 404, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 407, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 356, // lineNo
  25,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 356, // lineNo
  33,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 357, // lineNo
  22,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 357, // lineNo
  30,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 145, // lineNo
  20,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 373, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ed_emlrtRTEI{ 1,   // lineNo
  15,                                  // colNo
  "ec_filtfilt",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/bin/src_mex/ec_filtfilt.m"// pName
};

static emlrtRTEInfo fd_emlrtRTEI{ 266, // lineNo
  36,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo gd_emlrtRTEI{ 158, // lineNo
  1,                                   // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo hd_emlrtRTEI{ 144, // lineNo
  22,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo id_emlrtRTEI{ 266, // lineNo
  47,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo jd_emlrtRTEI{ 144, // lineNo
  5,                                   // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo kd_emlrtRTEI{ 267, // lineNo
  42,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ld_emlrtRTEI{ 31,  // lineNo
  6,                                   // colNo
  "find",                              // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/find.m"// pName
};

static emlrtRTEInfo md_emlrtRTEI{ 267, // lineNo
  53,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo nd_emlrtRTEI{ 340, // lineNo
  51,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo od_emlrtRTEI{ 400, // lineNo
  29,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo pd_emlrtRTEI{ 294, // lineNo
  47,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo qd_emlrtRTEI{ 400, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo rd_emlrtRTEI{ 401, // lineNo
  44,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo sd_emlrtRTEI{ 225, // lineNo
  13,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo td_emlrtRTEI{ 270, // lineNo
  24,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ud_emlrtRTEI{ 119, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo vd_emlrtRTEI{ 120, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo wd_emlrtRTEI{ 125, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo xd_emlrtRTEI{ 403, // lineNo
  29,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo yd_emlrtRTEI{ 296, // lineNo
  47,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ae_emlrtRTEI{ 457, // lineNo
  63,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo be_emlrtRTEI{ 406, // lineNo
  57,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ce_emlrtRTEI{ 394, // lineNo
  25,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo de_emlrtRTEI{ 356, // lineNo
  59,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ee_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "_coder_ec_filtfilt_api",            // fName
  ""                                   // pName
};

static emlrtRTEInfo fe_emlrtRTEI{ 41,  // lineNo
  1,                                   // colNo
  "introsort",                         // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/lib/+coder/+internal/introsort.m"// pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[14]);
static void b_emlrt_marshallIn(const mxArray *coef, const char_T *identifier,
  emxArray_real_T *y);
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static const mxArray *b_feval(const mxArray *m1, const mxArray *m2, emlrtMCInfo *
  location);
static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
  emlrtMCInfo *location);
static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2);
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

static void d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static int32_T div_s32(int32_T numerator, int32_T denominator);
static
#ifdef __CUDACC__

__device__
#endif

int32_T div_s32_device(int32_T numerator, int32_T denominator);
static __global__ void ec_filtfilt_kernel1(const emxArray_real_T x, int32_T b_x,
  emxArray_real_T xx);
static __global__ void ec_filtfilt_kernel10(int32_T loop_ub, emxArray_int32_T
  rows);
static __global__ void ec_filtfilt_kernel100(const int32_T b_dim0, uint32_T
  zfSize[2]);
static __global__ void ec_filtfilt_kernel101(int32_T idx, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel102(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv4);
static __global__ void ec_filtfilt_kernel103(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv5);
static __global__ void ec_filtfilt_kernel104(const emxArray_real_T xx, const
  emxArray_int32_T iv5, const emxArray_int32_T iv4, const int32_T b_xx, int32_T
  c_xx, const int32_T expanded_dim0, const int32_T xx_dim0, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel105(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T idx,
  int32_T c, const int32_T b_dim0, const int32_T convOut_dim0, const int32_T
  expanded_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel106(const emxArray_real_T zfIIR, const
  emxArray_real_T convOut, const int32_T b_zfIIR, int32_T b_convOut, const
  int32_T convOut_dim0, const int32_T b_convOut_dim0, const int32_T zfIIR_dim0,
  emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel107(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T d_convOut);
static __global__ void ec_filtfilt_kernel108(const emxArray_real_T zfIIR, const
  int32_T b_zfIIR, int32_T ns, const int32_T convOut_dim0, emxArray_real_T
  convOut);
static __global__ void ec_filtfilt_kernel109(const emxArray_real_T zfIIR, const
  int32_T b_zfIIR, int32_T ns, const int32_T convOut_dim0, const int32_T
  zfIIR_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel11(const emxArray_int32_T y, int32_T
  loop_ub, const int32_T coef_dim1, emxArray_int32_T rows);
static __global__ void ec_filtfilt_kernel110(const emxArray_real_T a, int32_T ns,
  const int32_T xx_dim0, const int32_T a_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel111(const emxArray_real_T convOut,
  const int32_T ns, const int32_T outridx, int32_T b_convOut, const int32_T
  zfIIR_dim0, const int32_T convOut_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel112(const emxArray_real_T convOut,
  const emxArray_real_T a, const int32_T b_a, int32_T ns, const int32_T a_dim0,
  const int32_T zfIIR_dim0, const int32_T xx_dim0, const int32_T convOut_dim0,
  emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel113(const emxArray_real_T convOut,
  const int32_T xx, int32_T b_convOut, const int32_T convOut_dim0, const int32_T
  b_convOut_dim0, emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel114(const emxArray_real_T convOut,
  int32_T ns, int32_T outridx, emxArray_real_T yc2);
static __global__ void ec_filtfilt_kernel115(const emxArray_real_T xx, const
  int32_T outridx, int32_T b_xx, const int32_T xx_dim0, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel116(const emxArray_real_T xx, const
  emxArray_real_T y, const real_T nfact, const int32_T outridx, const int32_T ns,
  const int32_T xt, int32_T vlen, const int32_T xt_dim0, const int32_T xx_dim0,
  emxArray_real_T b_xt);
static __global__ void ec_filtfilt_kernel117(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel118(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel119(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel12(const emxArray_int32_T y, int32_T
  loop_ub, const int32_T coef_dim1, const int32_T y_dim1, emxArray_int32_T rows);
static __global__ void ec_filtfilt_kernel120(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel121(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel122(int32_T idx, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel123(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv9);
static __global__ void ec_filtfilt_kernel124(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv10);
static __global__ void ec_filtfilt_kernel125(const emxArray_real_T xt, const
  emxArray_int32_T iv10, const emxArray_int32_T iv9, const int32_T b_xt, int32_T
  c_xt, const int32_T expanded_dim0, const int32_T xt_dim0, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel126(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T idx,
  int32_T c, const int32_T b_dim0, const int32_T convOut_dim0, const int32_T
  expanded_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel127(const emxArray_real_T zfIIR, const
  emxArray_real_T convOut, const int32_T b_zfIIR, int32_T b_convOut, const
  int32_T convOut_dim0, const int32_T b_convOut_dim0, const int32_T zfIIR_dim0,
  emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel128(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T d_convOut);
static __global__ void ec_filtfilt_kernel129(const emxArray_real_T zfIIR, const
  int32_T b_zfIIR, int32_T ns, const int32_T convOut_dim0, emxArray_real_T
  convOut);
static __global__ void ec_filtfilt_kernel13(int32_T coef, emxArray_int32_T y);
static __global__ void ec_filtfilt_kernel130(const emxArray_real_T zfIIR, const
  int32_T b_zfIIR, int32_T ns, const int32_T convOut_dim0, const int32_T
  zfIIR_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel131(const emxArray_real_T a, int32_T ns,
  const int32_T xt_dim0, const int32_T a_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel132(const emxArray_real_T convOut,
  const int32_T xt, int32_T b_convOut, const int32_T convOut_dim0, const int32_T
  b_convOut_dim0, emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel133(const emxArray_real_T convOut,
  int32_T ns, int32_T outridx, emxArray_real_T yc3);
static __global__ void ec_filtfilt_kernel134(const emxArray_real_T yc3, const
  int32_T ns, const emxArray_real_T zi, const int32_T b_zi, int32_T loop_ub,
  const int32_T y_dim0, const int32_T yc3_dim0, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel135(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel136(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel137(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel138(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel139(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel14(int32_T coef, emxArray_int32_T y);
static __global__ void ec_filtfilt_kernel140(int32_T idx, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel141(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv12);
static __global__ void ec_filtfilt_kernel142(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv13);
static __global__ void ec_filtfilt_kernel143(const emxArray_real_T yc3, const
  emxArray_int32_T iv13, const emxArray_int32_T iv12, const int32_T b_yc3,
  int32_T c_yc3, const int32_T expanded_dim0, const int32_T yc3_dim0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel144(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T idx,
  int32_T c, const int32_T b_dim0, const int32_T convOut_dim0, const int32_T
  expanded_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel145(const emxArray_real_T y, const
  emxArray_real_T convOut, const int32_T b_y, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, const int32_T y_dim0,
  emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel146(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T d_convOut);
static __global__ void ec_filtfilt_kernel147(const emxArray_real_T y, const
  int32_T b_y, int32_T ns, const int32_T convOut_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel148(const emxArray_real_T y, const
  int32_T b_y, int32_T ns, const int32_T convOut_dim0, const int32_T y_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel149(const emxArray_real_T a, int32_T ns,
  const int32_T yc3_dim0, const int32_T a_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel15(int32_T loop_ub, emxArray_int32_T
  cols);
static __global__ void ec_filtfilt_kernel150(const emxArray_real_T convOut,
  const int32_T ns, const int32_T outridx, int32_T b_convOut, const int32_T
  zfIIR_dim0, const int32_T convOut_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel151(const emxArray_real_T convOut,
  const emxArray_real_T a, const int32_T b_a, int32_T ns, const int32_T a_dim0,
  const int32_T zfIIR_dim0, const int32_T yc3_dim0, const int32_T convOut_dim0,
  emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel152(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel153(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel154(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel155(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel156(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel157(int32_T idx, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel158(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv14);
static __global__ void ec_filtfilt_kernel159(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv15);
static __global__ void ec_filtfilt_kernel16(const emxArray_int32_T y, const
  int32_T iv_dim1, int32_T loop_ub, emxArray_int32_T cols);
static __global__ void ec_filtfilt_kernel160(const emxArray_real_T yc2, const
  emxArray_int32_T iv15, const emxArray_int32_T iv14, const int32_T b_yc2,
  int32_T c_yc2, const int32_T expanded_dim0, const int32_T yc2_dim0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel161(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T idx,
  int32_T c, const int32_T b_dim0, const int32_T convOut_dim0, const int32_T
  expanded_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel162(const emxArray_real_T zfIIR, const
  emxArray_real_T convOut, const int32_T b_zfIIR, int32_T b_convOut, const
  int32_T convOut_dim0, const int32_T b_convOut_dim0, const int32_T zfIIR_dim0,
  emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel163(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T d_convOut);
static __global__ void ec_filtfilt_kernel164(const emxArray_real_T zfIIR, const
  int32_T b_zfIIR, int32_T ns, const int32_T convOut_dim0, emxArray_real_T
  convOut);
static __global__ void ec_filtfilt_kernel165(const emxArray_real_T zfIIR, const
  int32_T b_zfIIR, int32_T ns, const int32_T convOut_dim0, const int32_T
  zfIIR_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel166(const emxArray_real_T a, int32_T ns,
  const int32_T yc2_dim0, const int32_T a_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel167(const emxArray_real_T convOut,
  const int32_T yc2, int32_T b_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel168(const emxArray_real_T convOut,
  int32_T ns, int32_T outridx, emxArray_real_T yc5);
static __global__ void ec_filtfilt_kernel169(const emxArray_real_T yc5, const
  int32_T b_yc5, int32_T c_yc5, const int32_T xx_dim0, const int32_T yc5_dim0,
  emxArray_real_T xx);
static __global__ void ec_filtfilt_kernel17(const emxArray_int32_T y, const
  int32_T iv_dim1, int32_T loop_ub, const int32_T y_dim1, emxArray_int32_T cols);
static __global__ void ec_filtfilt_kernel170(const emxArray_real_T a2, real_T
  *a1, real_T *b_a1, real_T *c_a1, real_T *d_a1, real_T *e_a1);
static __global__ void ec_filtfilt_kernel171(const real_T *d1, const
  emxArray_real_T xx, const int32_T *i, emxArray_real_T xt);
static __global__ void ec_filtfilt_kernel172(const real_T val, const
  emxArray_real_T zi, int32_T b_zi, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel173(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel174(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel175(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel176(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel177(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel178(int32_T idx, uint32_T window_idx_0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel179(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv);
static __global__ void ec_filtfilt_kernel18(const emxArray_real_T a2,
  emxArray_int8_T vals);
static __global__ void ec_filtfilt_kernel180(const emxArray_real_T xt, const
  emxArray_int32_T iv, int32_T b_xt, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel181(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T idx, const
  int32_T b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel182(const emxArray_real_T y, int32_T ns,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel183(const emxArray_real_T y,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel184(const emxArray_real_T convOut,
  const int32_T ns, int32_T outridx, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel185(const emxArray_real_T convOut,
  const emxArray_real_T a, int32_T ns, const int32_T a_dim0, const int32_T
  xt_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel186(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel187(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel188(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel189(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel19(const emxArray_real_T a2, const
  int32_T x, int32_T loop_ub, emxArray_int8_T vals);
static __global__ void ec_filtfilt_kernel190(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel191(int32_T idx, uint32_T window_idx_0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel192(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv7);
static __global__ void ec_filtfilt_kernel193(const emxArray_real_T xx, const
  emxArray_int32_T iv7, int32_T b_xx, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel194(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T idx, const
  int32_T b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel195(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel196(const emxArray_real_T zfIIR,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel197(const emxArray_real_T convOut,
  const int32_T ns, int32_T outridx, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel198(const emxArray_real_T convOut,
  const emxArray_real_T a, int32_T ns, const int32_T a_dim0, const int32_T
  xx_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel199(const real_T *d1, const
  emxArray_real_T xx, const int32_T outridx, real_T d, emxArray_real_T xt);
static __global__ void ec_filtfilt_kernel2(const int32_T xx_dim0, const int32_T
  xx_dim1, int32_T *i);
static __global__ void ec_filtfilt_kernel20(const int32_T x, const int32_T ns,
  int32_T loop_ub, emxArray_int8_T vals);
static __global__ void ec_filtfilt_kernel200(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel201(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel202(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel203(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel204(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel205(int32_T idx, uint32_T window_idx_0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel206(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv11);
static __global__ void ec_filtfilt_kernel207(const emxArray_real_T xt, const
  emxArray_int32_T iv11, int32_T b_xt, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel208(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T idx, const
  int32_T b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel209(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel21(const int32_T iv_dim1, const int32_T
  x, const int32_T ns, int32_T loop_ub, emxArray_int8_T vals);
static __global__ void ec_filtfilt_kernel210(const emxArray_real_T zfIIR,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel211(const real_T val, const
  emxArray_real_T zi, int32_T b_zi, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel212(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel213(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel214(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel215(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel216(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel217(int32_T idx, uint32_T window_idx_0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel218(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv16);
static __global__ void ec_filtfilt_kernel219(const emxArray_real_T convOut,
  const int32_T k, const emxArray_int32_T iv16, int32_T outridx, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel22(const emxArray_real_T a2, const
  real_T val, const emxArray_real_T b2, int32_T coef, emxArray_real_T rhs);
static __global__ void ec_filtfilt_kernel220(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T idx, const
  int32_T b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel221(const emxArray_real_T y, int32_T ns,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel222(const emxArray_real_T y,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel223(const emxArray_real_T convOut,
  const int32_T ns, int32_T outridx, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel224(const emxArray_real_T convOut,
  const emxArray_real_T a, int32_T ns, const int32_T a_dim0, const int32_T
  xt_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel225(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel226(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel227(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel228(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel229(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel23(const emxArray_int32_T rows, int32_T
  ns, emxArray_int32_T ridxInt);
static __global__ void ec_filtfilt_kernel230(int32_T idx, uint32_T window_idx_0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel231(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv17);
static __global__ void ec_filtfilt_kernel232(const emxArray_real_T convOut,
  const emxArray_int32_T iv17, int32_T xx, const int32_T xx_dim0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel233(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T idx, const
  int32_T b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel234(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel235(const emxArray_real_T zfIIR,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel236(const emxArray_real_T convOut,
  const int32_T outridx, emxArray_real_T b_convOut);
static __global__ void ec_filtfilt_kernel237(const emxArray_real_T convOut,
  int32_T ns, emxArray_real_T xx);
static __global__ void ec_filtfilt_kernel238(const emxArray_real_T a2, real_T
  *a1, real_T *b_a1);
static __global__ void ec_filtfilt_kernel239(const emxArray_real_T xx, real_T
  *d1);
static __global__ void ec_filtfilt_kernel24(const emxArray_int32_T cols, int32_T
  ns, emxArray_int32_T cidxInt);
static __global__ void ec_filtfilt_kernel240(const emxArray_real_T xx, const
  int32_T *i, const real_T *d1, int32_T loop_ub, emxArray_real_T ytemp);
static __global__ void ec_filtfilt_kernel241(const real_T val, const
  emxArray_real_T zi, int32_T b_zi, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel242(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel243(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel244(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel245(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel246(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel247(int32_T idx, uint32_T window_idx_0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel248(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv1);
static __global__ void ec_filtfilt_kernel249(const emxArray_real_T ytemp, const
  emxArray_int32_T iv1, int32_T b_ytemp, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel25(int32_T nc, emxArray_int32_T
  sortedIndices);
static __global__ void ec_filtfilt_kernel250(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T idx, const
  int32_T b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel251(const emxArray_real_T y, int32_T ns,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel252(const emxArray_real_T y,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel253(const emxArray_real_T convOut,
  int32_T ytemp, emxArray_real_T dv3);
static __global__ void ec_filtfilt_kernel254(const emxArray_real_T convOut,
  const int32_T k, emxArray_real_T ytemp);
static __global__ void ec_filtfilt_kernel255(const real_T val, const
  emxArray_real_T zi, int32_T b_zi, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel256(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel257(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel258(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel259(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel26(const emxArray_int32_T cidxInt,
  int32_T b_cidxInt, emxArray_int32_T t);
static __global__ void ec_filtfilt_kernel260(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel261(int32_T idx, uint32_T window_idx_0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel262(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv6);
static __global__ void ec_filtfilt_kernel263(const emxArray_real_T convOut,
  const int32_T k, const emxArray_int32_T iv6, int32_T outridx, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel264(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T idx, const
  int32_T b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel265(const emxArray_real_T y, int32_T ns,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel266(const emxArray_real_T y,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel267(const emxArray_real_T convOut,
  const int32_T outridx, const int32_T ns, int32_T vlen, emxArray_real_T xx);
static __global__ void ec_filtfilt_kernel268(const emxArray_real_T xx, const
  int32_T b_xx, int32_T c_xx, const int32_T xx_dim0, const int32_T b_xx_dim0,
  emxArray_real_T d_xx);
static __global__ void ec_filtfilt_kernel269(const emxArray_real_T xx, int32_T
  b_xx, emxArray_real_T c_xx);
static __global__ void ec_filtfilt_kernel27(const emxArray_int32_T t, const
  emxArray_int32_T sortedIndices, int32_T ns, emxArray_int32_T cidxInt);
static __global__ void ec_filtfilt_kernel28(const emxArray_int32_T ridxInt,
  int32_T b_ridxInt, emxArray_int32_T t);
static __global__ void ec_filtfilt_kernel29(const emxArray_int32_T t, const
  emxArray_int32_T sortedIndices, int32_T ns, emxArray_int32_T ridxInt);
static __global__ void ec_filtfilt_kernel3(const emxArray_real_T x, const
  int32_T b_x, const int32_T x_dim0, emxArray_real_T xx);
static __global__ void ec_filtfilt_kernel30(int32_T cols, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ec_filtfilt_kernel31(const emxArray_int8_T vals, const
  emxArray_int32_T sortedIndices, int32_T nc, emxArray_real_T y_d);
static __global__ void ec_filtfilt_kernel32(int32_T ns, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ec_filtfilt_kernel33(int32_T thism, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel34(int32_T nc, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel35(const int32_T y_colidx_dim0,
  emxArray_int32_T y_colidx);
static __global__ void ec_filtfilt_kernel36(int32_T ns, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel37(int32_T thism, emxArray_int32_T
  counts);
static __global__ void ec_filtfilt_kernel38(const emxArray_real_T rhs, int32_T
  nc, emxArray_real_T outBuff);
static __global__ void ec_filtfilt_kernel39(const emxArray_real_T outBuff,
  int32_T *i, emxArray_real_T zi);
static __global__ void ec_filtfilt_kernel4(const emxArray_real_T coef, int32_T
  b_coef, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel40(int32_T ns, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ec_filtfilt_kernel41(int32_T thism, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel42(int32_T nc, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel43(const int32_T y_colidx_dim0,
  emxArray_int32_T y_colidx);
static __global__ void ec_filtfilt_kernel44(int32_T ns, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel45(int32_T thism, emxArray_int32_T
  counts);
static __global__ void ec_filtfilt_kernel46(const emxArray_real_T rhs, int32_T
  b_rhs, emxArray_real_T zi);
static __global__ void ec_filtfilt_kernel47(int32_T ns, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ec_filtfilt_kernel48(int32_T thism, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel49(int32_T nc, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel5(const emxArray_real_T coef, int32_T
  b_coef, emxArray_real_T b2);
static __global__ void ec_filtfilt_kernel50(const int32_T y_colidx_dim0,
  emxArray_int32_T y_colidx);
static __global__ void ec_filtfilt_kernel51(int32_T ns, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel52(int32_T thism, emxArray_int32_T
  counts);
static __global__ void ec_filtfilt_kernel53(const emxArray_real_T rhs, int32_T
  nc, emxArray_real_T outBuff);
static __global__ void ec_filtfilt_kernel54(const emxArray_real_T outBuff,
  int32_T *i, emxArray_real_T zi);
static __global__ void ec_filtfilt_kernel55(const emxArray_real_T coef,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel56(const emxArray_real_T b, int32_T b_b,
  emxArray_real_T b1);
static __global__ void ec_filtfilt_kernel57(const emxArray_real_T b,
  emxArray_real_T b1);
static __global__ void ec_filtfilt_kernel58(const emxArray_real_T b1, int32_T nc,
  emxArray_real_T y);
static __global__ void ec_filtfilt_kernel59(const int32_T vlen, const
  emxArray_real_T y, const int32_T nc, const int32_T ns, emxArray_real_T
  maxCoefNum);
static __global__ void ec_filtfilt_kernel6(emxArray_real_T a2);
static __global__ void ec_filtfilt_kernel60(const emxArray_real_T maxCoefNum,
  int32_T b_maxCoefNum, emxArray_boolean_T x);
static __global__ void ec_filtfilt_kernel61(const real_T val, int32_T *i,
  emxArray_real_T b1);
static __global__ void ec_filtfilt_kernel62(const emxArray_real_T b1, int32_T
  b_b1, emxArray_boolean_T x);
static __global__ void ec_filtfilt_kernel63(const emxArray_int32_T ii, int32_T
  b_ii, emxArray_uint32_T nZeroLastDen);
static __global__ void ec_filtfilt_kernel64(const emxArray_real_T b, real_T a0[3]);
static __global__ void ec_filtfilt_kernel65(const emxArray_real_T b, const
  real_T a0[3], emxArray_real_T b2, emxArray_real_T a2);
static __global__ void ec_filtfilt_kernel66(const emxArray_real_T a2, const
  real_T val, const emxArray_real_T b2, real_T rhs[2]);
static __global__ void ec_filtfilt_kernel67(int8_T b_I[4]);
static __global__ void ec_filtfilt_kernel68(int8_T b_I[4]);
static __global__ void ec_filtfilt_kernel69(const emxArray_real_T a2, const
  int8_T b_I[4], real_T A[4]);
static __global__ void ec_filtfilt_kernel7(int32_T loop_ub, emxArray_real_T a2);
static __global__ void ec_filtfilt_kernel70(const real_T A[4], const real_T val,
  const int32_T ns, const real_T rhs[2], const int32_T nc, real_T Y[2]);
static __global__ void ec_filtfilt_kernel71(const real_T A[4], const real_T rhs
  [2], const int32_T ns, real_T Y[2]);
static __global__ void ec_filtfilt_kernel72(const real_T Y[2], emxArray_real_T
  zi);
static __global__ void ec_filtfilt_kernel73(const emxArray_real_T a2, real_T *a1,
  real_T *b_a1, real_T *c_a1, real_T *d_a1, real_T *e_a1);
static __global__ void ec_filtfilt_kernel74(const emxArray_real_T xx, int32_T
  b_xx, const int32_T xx_dim0, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel75(const emxArray_real_T xx, const
  emxArray_real_T y, const real_T nfact, const int32_T outridx, const int32_T ns,
  const int32_T xt, int32_T vlen, const int32_T xt_dim0, const int32_T xx_dim0,
  emxArray_real_T b_xt);
static __global__ void ec_filtfilt_kernel76(const emxArray_real_T xt, const
  emxArray_real_T zi, const int32_T b_zi, int32_T loop_ub, const int32_T y_dim0,
  const int32_T xt_dim0, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel77(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel78(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel79(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel8(int32_T coef, emxArray_int32_T y);
static __global__ void ec_filtfilt_kernel80(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel81(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel82(const int32_T b_dim0, uint32_T
  zfSize[2]);
static __global__ void ec_filtfilt_kernel83(int32_T idx, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel84(const int32_T nc, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv2);
static __global__ void ec_filtfilt_kernel85(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv3);
static __global__ void ec_filtfilt_kernel86(const emxArray_real_T xt, const
  emxArray_int32_T iv3, const emxArray_int32_T iv2, const int32_T b_xt, int32_T
  c_xt, const int32_T expanded_dim0, const int32_T xt_dim0, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel87(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T idx,
  int32_T c, const int32_T b_dim0, const int32_T convOut_dim0, const int32_T
  expanded_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel88(const emxArray_real_T y, const
  emxArray_real_T convOut, const int32_T b_y, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, const int32_T y_dim0,
  emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel89(const emxArray_real_T convOut, const
  int32_T b_convOut, int32_T c_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T d_convOut);
static __global__ void ec_filtfilt_kernel9(int32_T coef, emxArray_int32_T y);
static __global__ void ec_filtfilt_kernel90(const emxArray_real_T y, const
  int32_T b_y, int32_T ns, const int32_T convOut_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel91(const emxArray_real_T y, const
  int32_T b_y, int32_T ns, const int32_T convOut_dim0, const int32_T y_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel92(const emxArray_real_T a, int32_T ns,
  const int32_T xt_dim0, const int32_T a_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel93(const emxArray_real_T convOut, const
  int32_T ns, const int32_T outridx, int32_T b_convOut, const int32_T zfIIR_dim0,
  const int32_T convOut_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel94(const emxArray_real_T convOut, const
  emxArray_real_T a, const int32_T b_a, int32_T ns, const int32_T a_dim0, const
  int32_T zfIIR_dim0, const int32_T xt_dim0, const int32_T convOut_dim0,
  emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel95(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel96(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel97(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel98(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel99(emxArray_real_T a);
static void ec_filtfilt_once();
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_, const char_T *
  identifier, char_T y[14]);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[14]);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int8_T(emxArray_int8_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_struct_T(emxArray_struct_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_uint32_T(emxArray_uint32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxFree_boolean_T(emxArray_boolean_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_int8_T(emxArray_int8_T **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxFree_struct_T(emxArray_struct_T **pEmxArray);
static void emxFree_uint32_T(emxArray_uint32_T **pEmxArray);
static void emxInit_boolean_T(emxArray_boolean_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int8_T(emxArray_int8_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_struct_T(emxArray_struct_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_uint32_T(emxArray_uint32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
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
static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu);
static void gpuEmxFree_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
static void gpuEmxFree_int8_T(emxArray_int8_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
static void gpuEmxFree_uint32_T(emxArray_uint32_T *gpu);
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
static void gpuEmxMemcpyGpuToCpu_uint32_T(emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu);
static void gpuEmxReset_boolean_T(emxArray_boolean_T *gpu);
static void gpuEmxReset_int32_T(emxArray_int32_T *gpu);
static void gpuEmxReset_int8_T(emxArray_int8_T *gpu);
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[14])
{
  static const int32_T dims[2]{ 1, 14 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U, (
    const void *)&dims[0]);
  emlrtImportCharArrayR2015b(emlrtRootTLSGlobal, src, &ret[0], 14);
  emlrtDestroyArray(&src);
}

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

static void binary_expand_op(emxArray_real_T *in1, const emxArray_real_T *in2)
{
  emxArray_real_T *b_in1;
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 2, &jb_emlrtRTEI, true);
  i = b_in1->size[0] * b_in1->size[1];
  b_in1->size[0] = in2->size[0];
  if (in2->size[1] == 1) {
    b_in1->size[1] = in1->size[1];
  } else {
    b_in1->size[1] = in2->size[1];
  }

  emxEnsureCapacity_real_T(b_in1, i, &jb_emlrtRTEI);
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
    for (int32_T i1{0}; i1 < in2->size[0]; i1++) {
      b_in1->data[i1 + b_in1->size[0] * i] = in1->data[i1 + in1->size[0] *
        aux_0_1] + in2->data[i1 + in2->size[0] * aux_1_1];
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
      n = xend - xstart;
      for (int32_T idx{0}; idx <= n; idx++) {
        leftIdx = (n - idx) - 1;
        changed = true;
        extremumIdx = leftIdx + xstart;
        leftIdx = (((leftIdx + 2) << 1) + xstart) - 2;
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

      for (int32_T idx{0}; idx < n; idx++) {
        leftIdx = x->data[(xend - idx) - 1];
        x->data[(xend - idx) - 1] = x->data[xstart - 1];
        x->data[xstart - 1] = leftIdx;
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
      const mxArray *y;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &b_u[0]);
      emlrtAssign(&b_y, m);
      c_y = nullptr;
      m = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 22, m, &msgID[0]);
      emlrtAssign(&c_y, m);
      d_y = nullptr;
      m = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 3, m, &varargin_1[0]);
      emlrtAssign(&d_y, m);
      e_y = nullptr;
      m = emlrtCreateCharArray(2, &iv4[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 3, m, &varargin_2[0]);
      emlrtAssign(&e_y, m);
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
      const mxArray *y;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &b_u[0]);
      emlrtAssign(&b_y, m);
      c_y = nullptr;
      m = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 21, m, &msgID[0]);
      emlrtAssign(&c_y, m);
      feval(y, b_feval(b_y, c_y, &emlrtMCI), &b_emlrtMCI);
    }

    //
    //
    static void insertionsort(emxArray_int32_T *x, int32_T xstart, int32_T xend,
      const emxArray_int32_T *cmp_workspace_a, const emxArray_int32_T
      *cmp_workspace_b)
    {
      int32_T i;
      i = xstart + 1;
      for (int32_T k{0}; k <= xend - i; k++) {
        int32_T idx;
        int32_T xc;
        boolean_T exitg1;
        idx = xstart + k;
        xc = x->data[idx] - 1;
        exitg1 = false;
        while ((!exitg1) && (idx >= xstart)) {
          boolean_T varargout_1;
          if (cmp_workspace_a->data[xc] < cmp_workspace_a->data[x->data[idx - 1]
              - 1]) {
            varargout_1 = true;
          } else if (cmp_workspace_a->data[xc] == cmp_workspace_a->data[x->
                     data[idx - 1] - 1]) {
            varargout_1 = (cmp_workspace_b->data[xc] < cmp_workspace_b->data
                           [x->data[idx - 1] - 1]);
          } else {
            varargout_1 = false;
          }

          if (varargout_1) {
            x->data[idx] = x->data[idx - 1];
            idx--;
          } else {
            exitg1 = true;
          }
        }

        x->data[idx] = xc + 1;
      }
    }

    //
    //
    static void introsort(emxArray_int32_T *x, int32_T xend, const
                          emxArray_int32_T *cmp_workspace_a, const
                          emxArray_int32_T *cmp_workspace_b)
    {
      emxArray_struct_T *st_d;
      struct_T frame;
      emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
      emxInit_struct_T(&st_d, 1, &fe_emlrtRTEI, true);
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
          pmax = MAXDEPTH << 1;
          pmin = st_d->size[0];
          st_d->size[0] = pmax;
          emxEnsureCapacity_struct_T(st_d, pmin, &fe_emlrtRTEI);
          for (pmin = 0; pmin < pmax; pmin++) {
            st_d->data[pmin] = frame;
          }

          st_d->data[0] = frame;
          pow2p = 1;
          while (pow2p > 0) {
            frame = st_d->data[pow2p - 1];
            pmax = st_d->data[pow2p - 1].xstart - 1;
            xend = st_d->data[pow2p - 1].xend;
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
                st_d->data[pow2p].xstart = pmax + 2;
                st_d->data[pow2p].xend = frame.xend;
                st_d->data[pow2p].depth = frame.depth + 1;
                pow2p++;
              }

              if (frame.xstart < pmax + 1) {
                st_d->data[pow2p].xstart = frame.xstart;
                st_d->data[pow2p].xend = pmax + 1;
                st_d->data[pow2p].depth = frame.depth + 1;
                pow2p++;
              }
            }
          }
        }
      }

      emxFree_struct_T(&st_d);
      emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
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
      const mxArray *y;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &b_u[0]);
      emlrtAssign(&b_y, m);
      c_y = nullptr;
      m = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 32, m, &msgID[0]);
      emlrtAssign(&c_y, m);
      d_y = nullptr;
      m = emlrtCreateNumericMatrix(1, 1, mxINT32_CLASS, mxREAL);
      *static_cast<int32_T *>(emlrtMxGetData(m)) = varargin_1;
      emlrtAssign(&d_y, m);
      e_y = nullptr;
      m = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 14, m, &varargin_2[0]);
      emlrtAssign(&e_y, m);
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
      const mxArray *y;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &b_u[0]);
      emlrtAssign(&b_y, m);
      c_y = nullptr;
      m = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 24, m, &msgID[0]);
      emlrtAssign(&c_y, m);
      d_y = nullptr;
      m = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 3, m, &varargin_1[0]);
      emlrtAssign(&d_y, m);
      e_y = nullptr;
      m = emlrtCreateString1R2022a(emlrtRootTLSGlobal, 'G');
      emlrtAssign(&e_y, m);
      feval(y, feval(b_y, c_y, d_y, e_y, &emlrtMCI), &b_emlrtMCI);
    }
  }
}

static void d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2]{ 1, -1 };

  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2]{ false, true };

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
    if ((numerator < 0) != (denominator < 0)) {
      quotient = -static_cast<int32_T>(tempAbsQuotient);
    } else {
      quotient = static_cast<int32_T>(tempAbsQuotient);
    }
  }

  return quotient;
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel1(const
  emxArray_real_T x, int32_T b_x, emxArray_real_T xx)
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
    xx.data[iv0] = x.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel10(int32_T
  loop_ub, emxArray_int32_T rows)
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
    rows.data[iv0] = iv0 + 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel100(const
  int32_T b_dim0, uint32_T zfSize[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    zfSize[0] = static_cast<uint32_T>(b_dim0 - 1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel101(int32_T
  idx, emxArray_real_T expanded)
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
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel102(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv4)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv4.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel103(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv5)
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
    iv5.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel104(const
  emxArray_real_T xx, const emxArray_int32_T iv5, const emxArray_int32_T iv4,
  const int32_T b_xx, int32_T c_xx, const int32_T expanded_dim0, const int32_T
  xx_dim0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xx) + 1UL) * (static_cast<uint64_T>(c_xx) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xx) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_xx) + 1UL));
    expanded.data[iv4.data[ix] + expanded_dim0 * iv5.data[iv0]] = xx.data[ix +
      xx_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel105(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T idx, int32_T c, const int32_T b_dim0, const int32_T convOut_dim0,
  const int32_T expanded_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(idx - 1) + 1UL) * (static_cast<uint64_T>(c) +
    1UL) - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    iv0 = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(idx - 1) + 1UL));
    ix = static_cast<int32_T>((b_idx - static_cast<uint64_T>(iv0)) / (
      static_cast<uint64_T>(idx - 1) + 1UL));
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[(i + expanded_dim0 * ix) - 1] * b.data[(b_dim0 - m) -
        1];
    }

    convOut.data[iv0 + convOut_dim0 * ix] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel106(const
  emxArray_real_T zfIIR, const emxArray_real_T convOut, const int32_T b_zfIIR,
  int32_T b_convOut, const int32_T convOut_dim0, const int32_T b_convOut_dim0,
  const int32_T zfIIR_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zfIIR) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zfIIR) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_zfIIR) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zfIIR.data[ix + zfIIR_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel107(const
  emxArray_real_T convOut, const int32_T b_convOut, int32_T c_convOut, const
  int32_T convOut_dim0, const int32_T b_convOut_dim0, emxArray_real_T d_convOut)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel108(const
  emxArray_real_T zfIIR, const int32_T b_zfIIR, int32_T ns, const int32_T
  convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zfIIR) + 1UL) * (static_cast<uint64_T>(ns)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zfIIR) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_zfIIR) + 1UL));
    convOut.data[i + convOut_dim0 * m] += zfIIR.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel109(const
  emxArray_real_T zfIIR, const int32_T b_zfIIR, int32_T ns, const int32_T
  convOut_dim0, const int32_T zfIIR_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zfIIR) + 1UL) * (static_cast<uint64_T>(ns)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zfIIR) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_zfIIR) + 1UL));
    convOut.data[i + convOut_dim0 * m] += zfIIR.data[zfIIR_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel11(const
  emxArray_int32_T y, int32_T loop_ub, const int32_T coef_dim1, emxArray_int32_T
  rows)
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
    rows.data[(iv0 + coef_dim1) - 1] = y.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel110(const
  emxArray_real_T a, int32_T ns, const int32_T xx_dim0, const int32_T a_dim0,
  const int32_T convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T ix;
    int32_T m;
    m = static_cast<int32_T>(idx);
    ix = (xx_dim0 + a_dim0) - 1;
    for (int32_T i{0}; i < ix; i++) {
      int32_T bcoef;
      bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 1.0,
        static_cast<real_T>(a_dim0))) - 1;
      for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
        convOut.data[i + convOut_dim0 * m] -= convOut.data[((i - iv0) +
          convOut_dim0 * m) - 1] * a.data[iv0 + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel111(const
  emxArray_real_T convOut, const int32_T ns, const int32_T outridx, int32_T
  b_convOut, const int32_T zfIIR_dim0, const int32_T convOut_dim0,
  emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(outridx - ns) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(outridx - ns) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(outridx - ns) + 1UL));
    zfIIR.data[ix + zfIIR_dim0 * iv0] = convOut.data[((ns + ix) + convOut_dim0 *
      iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel112(const
  emxArray_real_T convOut, const emxArray_real_T a, const int32_T b_a, int32_T
  ns, const int32_T a_dim0, const int32_T zfIIR_dim0, const int32_T xx_dim0,
  const int32_T convOut_dim0, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_a) + 1UL) * (static_cast<uint64_T>(ns) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_a) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_a) + 1UL));
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 2.0,
      static_cast<real_T>(a_dim0))) - 1;
    for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
      zfIIR.data[(i + zfIIR_dim0 * m) + 1] += convOut.data[((xx_dim0 + i) - iv0)
        + convOut_dim0 * m] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel113(const
  emxArray_real_T convOut, const int32_T xx, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(xx) + 1UL) * (static_cast<uint64_T>(b_convOut)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(xx) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(xx) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel114(const
  emxArray_real_T convOut, int32_T ns, int32_T outridx, emxArray_real_T yc2)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns * outridx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    yc2.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel115(const
  emxArray_real_T xx, const int32_T outridx, int32_T b_xx, const int32_T xx_dim0,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = 2.0 * xx.data[outridx + xx_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel116(const
  emxArray_real_T xx, const emxArray_real_T y, const real_T nfact, const int32_T
  outridx, const int32_T ns, const int32_T xt, int32_T vlen, const int32_T
  xt_dim0, const int32_T xx_dim0, emxArray_real_T b_xt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(xt) + 1UL) * (static_cast<uint64_T>(vlen - 1)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(xt) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(xt) + 1UL));
    b_xt.data[i + xt_dim0 * m] = y.data[ns * m] - xx.data[((xx_dim0 - (
      static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1 != 1) * i) + xx_dim0 *
      (outridx * m)) - 2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel117(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel118(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel119(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel12(const
  emxArray_int32_T y, int32_T loop_ub, const int32_T coef_dim1, const int32_T
  y_dim1, emxArray_int32_T rows)
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
    rows.data[((iv0 + coef_dim1) + y_dim1) - 1] = y.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel120(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel121
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel122(int32_T
  idx, emxArray_real_T expanded)
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
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel123(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv9)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv9.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel124(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv10)
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
    iv10.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel125(const
  emxArray_real_T xt, const emxArray_int32_T iv10, const emxArray_int32_T iv9,
  const int32_T b_xt, int32_T c_xt, const int32_T expanded_dim0, const int32_T
  xt_dim0, emxArray_real_T expanded)
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
    expanded.data[iv9.data[ix] + expanded_dim0 * iv10.data[iv0]] = xt.data[ix +
      xt_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel126(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T idx, int32_T c, const int32_T b_dim0, const int32_T convOut_dim0,
  const int32_T expanded_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(idx - 1) + 1UL) * (static_cast<uint64_T>(c) +
    1UL) - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    iv0 = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(idx - 1) + 1UL));
    ix = static_cast<int32_T>((b_idx - static_cast<uint64_T>(iv0)) / (
      static_cast<uint64_T>(idx - 1) + 1UL));
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[(i + expanded_dim0 * ix) - 1] * b.data[(b_dim0 - m) -
        1];
    }

    convOut.data[iv0 + convOut_dim0 * ix] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel127(const
  emxArray_real_T zfIIR, const emxArray_real_T convOut, const int32_T b_zfIIR,
  int32_T b_convOut, const int32_T convOut_dim0, const int32_T b_convOut_dim0,
  const int32_T zfIIR_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zfIIR) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zfIIR) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_zfIIR) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zfIIR.data[ix + zfIIR_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel128(const
  emxArray_real_T convOut, const int32_T b_convOut, int32_T c_convOut, const
  int32_T convOut_dim0, const int32_T b_convOut_dim0, emxArray_real_T d_convOut)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel129(const
  emxArray_real_T zfIIR, const int32_T b_zfIIR, int32_T ns, const int32_T
  convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zfIIR) + 1UL) * (static_cast<uint64_T>(ns)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zfIIR) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_zfIIR) + 1UL));
    convOut.data[i + convOut_dim0 * m] += zfIIR.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel13(int32_T
  coef, emxArray_int32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(coef);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = iv0 + 2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel130(const
  emxArray_real_T zfIIR, const int32_T b_zfIIR, int32_T ns, const int32_T
  convOut_dim0, const int32_T zfIIR_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zfIIR) + 1UL) * (static_cast<uint64_T>(ns)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zfIIR) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_zfIIR) + 1UL));
    convOut.data[i + convOut_dim0 * m] += zfIIR.data[zfIIR_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel131(const
  emxArray_real_T a, int32_T ns, const int32_T xt_dim0, const int32_T a_dim0,
  const int32_T convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T ix;
    int32_T m;
    m = static_cast<int32_T>(idx);
    ix = (xt_dim0 + a_dim0) - 1;
    for (int32_T i{0}; i < ix; i++) {
      int32_T bcoef;
      bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 1.0,
        static_cast<real_T>(a_dim0))) - 1;
      for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
        convOut.data[i + convOut_dim0 * m] -= convOut.data[((i - iv0) +
          convOut_dim0 * m) - 1] * a.data[iv0 + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel132(const
  emxArray_real_T convOut, const int32_T xt, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, emxArray_real_T c_convOut)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel133(const
  emxArray_real_T convOut, int32_T ns, int32_T outridx, emxArray_real_T yc3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns * outridx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    yc3.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel134(const
  emxArray_real_T yc3, const int32_T ns, const emxArray_real_T zi, const int32_T
  b_zi, int32_T loop_ub, const int32_T y_dim0, const int32_T yc3_dim0,
  emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zi) + 1UL) * (static_cast<uint64_T>(loop_ub)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_zi) + 1UL));
    y.data[ix + y_dim0 * iv0] = zi.data[ix] * yc3.data[ns + yc3_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel135(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel136(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel137(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel138(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel139
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel14(int32_T
  coef, emxArray_int32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(coef);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = iv0 + 2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel140(int32_T
  idx, emxArray_real_T expanded)
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
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel141(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv12)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv12.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel142(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv13)
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
    iv13.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel143(const
  emxArray_real_T yc3, const emxArray_int32_T iv13, const emxArray_int32_T iv12,
  const int32_T b_yc3, int32_T c_yc3, const int32_T expanded_dim0, const int32_T
  yc3_dim0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_yc3) + 1UL) * (static_cast<uint64_T>(c_yc3)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_yc3) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_yc3) + 1UL));
    expanded.data[iv12.data[ix] + expanded_dim0 * iv13.data[iv0]] = yc3.data
      [((yc3_dim0 - ix) + yc3_dim0 * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel144(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T idx, int32_T c, const int32_T b_dim0, const int32_T convOut_dim0,
  const int32_T expanded_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(idx - 1) + 1UL) * (static_cast<uint64_T>(c) +
    1UL) - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    iv0 = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(idx - 1) + 1UL));
    ix = static_cast<int32_T>((b_idx - static_cast<uint64_T>(iv0)) / (
      static_cast<uint64_T>(idx - 1) + 1UL));
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[(i + expanded_dim0 * ix) - 1] * b.data[(b_dim0 - m) -
        1];
    }

    convOut.data[iv0 + convOut_dim0 * ix] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel145(const
  emxArray_real_T y, const emxArray_real_T convOut, const int32_T b_y, int32_T
  b_convOut, const int32_T convOut_dim0, const int32_T b_convOut_dim0, const
  int32_T y_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_y) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + y.data[ix + y_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel146(const
  emxArray_real_T convOut, const int32_T b_convOut, int32_T c_convOut, const
  int32_T convOut_dim0, const int32_T b_convOut_dim0, emxArray_real_T d_convOut)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel147(const
  emxArray_real_T y, const int32_T b_y, int32_T ns, const int32_T convOut_dim0,
  emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>(ns) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_y) + 1UL));
    convOut.data[i + convOut_dim0 * m] += y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel148(const
  emxArray_real_T y, const int32_T b_y, int32_T ns, const int32_T convOut_dim0,
  const int32_T y_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>(ns) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_y) + 1UL));
    convOut.data[i + convOut_dim0 * m] += y.data[y_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel149(const
  emxArray_real_T a, int32_T ns, const int32_T yc3_dim0, const int32_T a_dim0,
  const int32_T convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T ix;
    int32_T m;
    m = static_cast<int32_T>(idx);
    ix = (yc3_dim0 + a_dim0) - 1;
    for (int32_T i{0}; i < ix; i++) {
      int32_T bcoef;
      bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 1.0,
        static_cast<real_T>(a_dim0))) - 1;
      for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
        convOut.data[i + convOut_dim0 * m] -= convOut.data[((i - iv0) +
          convOut_dim0 * m) - 1] * a.data[iv0 + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel15(int32_T
  loop_ub, emxArray_int32_T cols)
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
    cols.data[iv0] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel150(const
  emxArray_real_T convOut, const int32_T ns, const int32_T outridx, int32_T
  b_convOut, const int32_T zfIIR_dim0, const int32_T convOut_dim0,
  emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(outridx - ns) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(outridx - ns) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(outridx - ns) + 1UL));
    zfIIR.data[ix + zfIIR_dim0 * iv0] = convOut.data[(ns + ix) + convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel151(const
  emxArray_real_T convOut, const emxArray_real_T a, const int32_T b_a, int32_T
  ns, const int32_T a_dim0, const int32_T zfIIR_dim0, const int32_T yc3_dim0,
  const int32_T convOut_dim0, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_a) + 1UL) * (static_cast<uint64_T>(ns) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_a) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_a) + 1UL));
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 2.0, static_cast<
      real_T>(a_dim0))) - 1;
    for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
      zfIIR.data[(i + zfIIR_dim0 * m) + 1] += convOut.data[((yc3_dim0 + i) - iv0)
        + convOut_dim0 * m] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel152(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel153(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel154(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel155(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel156
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel157(int32_T
  idx, emxArray_real_T expanded)
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
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel158(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv14)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv14.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel159(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv15)
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
    iv15.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel16(const
  emxArray_int32_T y, const int32_T iv_dim1, int32_T loop_ub, emxArray_int32_T
  cols)
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
    cols.data[iv0 + iv_dim1] = y.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel160(const
  emxArray_real_T yc2, const emxArray_int32_T iv15, const emxArray_int32_T iv14,
  const int32_T b_yc2, int32_T c_yc2, const int32_T expanded_dim0, const int32_T
  yc2_dim0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_yc2) + 1UL) * (static_cast<uint64_T>(c_yc2)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_yc2) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_yc2) + 1UL));
    expanded.data[iv14.data[ix] + expanded_dim0 * iv15.data[iv0]] = yc2.data
      [((yc2_dim0 - ix) + yc2_dim0 * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel161(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T idx, int32_T c, const int32_T b_dim0, const int32_T convOut_dim0,
  const int32_T expanded_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(idx - 1) + 1UL) * (static_cast<uint64_T>(c) +
    1UL) - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    iv0 = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(idx - 1) + 1UL));
    ix = static_cast<int32_T>((b_idx - static_cast<uint64_T>(iv0)) / (
      static_cast<uint64_T>(idx - 1) + 1UL));
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[(i + expanded_dim0 * ix) - 1] * b.data[(b_dim0 - m) -
        1];
    }

    convOut.data[iv0 + convOut_dim0 * ix] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel162(const
  emxArray_real_T zfIIR, const emxArray_real_T convOut, const int32_T b_zfIIR,
  int32_T b_convOut, const int32_T convOut_dim0, const int32_T b_convOut_dim0,
  const int32_T zfIIR_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zfIIR) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zfIIR) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_zfIIR) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zfIIR.data[ix + zfIIR_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel163(const
  emxArray_real_T convOut, const int32_T b_convOut, int32_T c_convOut, const
  int32_T convOut_dim0, const int32_T b_convOut_dim0, emxArray_real_T d_convOut)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel164(const
  emxArray_real_T zfIIR, const int32_T b_zfIIR, int32_T ns, const int32_T
  convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zfIIR) + 1UL) * (static_cast<uint64_T>(ns)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zfIIR) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_zfIIR) + 1UL));
    convOut.data[i + convOut_dim0 * m] += zfIIR.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel165(const
  emxArray_real_T zfIIR, const int32_T b_zfIIR, int32_T ns, const int32_T
  convOut_dim0, const int32_T zfIIR_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zfIIR) + 1UL) * (static_cast<uint64_T>(ns)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zfIIR) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_zfIIR) + 1UL));
    convOut.data[i + convOut_dim0 * m] += zfIIR.data[zfIIR_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel166(const
  emxArray_real_T a, int32_T ns, const int32_T yc2_dim0, const int32_T a_dim0,
  const int32_T convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T ix;
    int32_T m;
    m = static_cast<int32_T>(idx);
    ix = (yc2_dim0 + a_dim0) - 1;
    for (int32_T i{0}; i < ix; i++) {
      int32_T bcoef;
      bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 1.0,
        static_cast<real_T>(a_dim0))) - 1;
      for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
        convOut.data[i + convOut_dim0 * m] -= convOut.data[((i - iv0) +
          convOut_dim0 * m) - 1] * a.data[iv0 + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel167(const
  emxArray_real_T convOut, const int32_T yc2, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(yc2) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(yc2) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(yc2) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel168(const
  emxArray_real_T convOut, int32_T ns, int32_T outridx, emxArray_real_T yc5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns * outridx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    yc5.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel169(const
  emxArray_real_T yc5, const int32_T b_yc5, int32_T c_yc5, const int32_T xx_dim0,
  const int32_T yc5_dim0, emxArray_real_T xx)
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
    xx.data[ix + xx_dim0 * iv0] = yc5.data[((yc5_dim0 - ix) + yc5_dim0 * iv0) -
      1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel17(const
  emxArray_int32_T y, const int32_T iv_dim1, int32_T loop_ub, const int32_T
  y_dim1, emxArray_int32_T cols)
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
    cols.data[(iv0 + iv_dim1) + y_dim1] = y.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel170(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel171(const
  real_T *d1, const emxArray_real_T xx, const int32_T *i, emxArray_real_T xt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*i - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    xt.data[iv0] = -xx.data[*i - iv0] + *d1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel172(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel173(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel174(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel175(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel176(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel177
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel178(int32_T
  idx, uint32_T window_idx_0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((idx + static_cast<int32_T>(window_idx_0)) - 2);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel179(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel18(const
  emxArray_real_T a2, emxArray_int8_T vals)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    vals.data[0] = static_cast<int8_T>(static_cast<int32_T>(a2.data[1]) + 1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel180(const
  emxArray_real_T xt, const emxArray_int32_T iv, int32_T b_xt, emxArray_real_T
  expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xt);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv.data[iv0]] = xt.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel181(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T idx, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(idx - 1);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[i - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel182(const
  emxArray_real_T y, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    convOut.data[i] += y.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel183(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel184(const
  emxArray_real_T convOut, const int32_T ns, int32_T outridx, emxArray_real_T
  zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outridx - ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zfIIR.data[iv0] = convOut.data[ns + iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel185(const
  emxArray_real_T convOut, const emxArray_real_T a, int32_T ns, const int32_T
  a_dim0, const int32_T xt_dim0, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T i;
    i = static_cast<int32_T>(idx);
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 2.0, static_cast<
      real_T>(a_dim0))) - 2;
    for (int32_T iv0{0}; iv0 <= bcoef; iv0++) {
      zfIIR.data[i + 1] += convOut.data[(xt_dim0 + i) - iv0] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel186(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel187(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel188(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel189(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel19(const
  emxArray_real_T a2, const int32_T x, int32_T loop_ub, emxArray_int8_T vals)
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
    vals.data[iv0 + 1] = static_cast<int8_T>(a2.data[x + iv0]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel190
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel191(int32_T
  idx, uint32_T window_idx_0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((idx + static_cast<int32_T>(window_idx_0)) - 2);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel192(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv7)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv7.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel193(const
  emxArray_real_T xx, const emxArray_int32_T iv7, int32_T b_xx, emxArray_real_T
  expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv7.data[iv0]] = xx.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel194(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T idx, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(idx - 1);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[i - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel195(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    convOut.data[i] += zfIIR.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel196(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel197(const
  emxArray_real_T convOut, const int32_T ns, int32_T outridx, emxArray_real_T
  zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outridx - ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zfIIR.data[iv0] = convOut.data[(ns + iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel198(const
  emxArray_real_T convOut, const emxArray_real_T a, int32_T ns, const int32_T
  a_dim0, const int32_T xx_dim0, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T i;
    i = static_cast<int32_T>(idx);
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 2.0, static_cast<
      real_T>(a_dim0))) - 2;
    for (int32_T iv0{0}; iv0 <= bcoef; iv0++) {
      zfIIR.data[i + 1] += convOut.data[(xx_dim0 + i) - iv0] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel199(const
  real_T *d1, const emxArray_real_T xx, const int32_T outridx, real_T d,
  emxArray_real_T xt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(static_cast<int32_T>(-(d - -1.0)));
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    xt.data[iv0] = -xx.data[(outridx - iv0) - 1] + *d1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel2(const
  int32_T xx_dim0, const int32_T xx_dim1, int32_T *i)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *i = xx_dim0 * xx_dim1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel20(const
  int32_T x, const int32_T ns, int32_T loop_ub, emxArray_int8_T vals)
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
    vals.data[((iv0 + ns) - x) + 2] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel200(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel201(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel202(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel203(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel204
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel205(int32_T
  idx, uint32_T window_idx_0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((idx + static_cast<int32_T>(window_idx_0)) - 2);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel206(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv11)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv11.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel207(const
  emxArray_real_T xt, const emxArray_int32_T iv11, int32_T b_xt, emxArray_real_T
  expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xt);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv11.data[iv0]] = xt.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel208(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T idx, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(idx - 1);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[i - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel209(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    convOut.data[i] += zfIIR.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel21(const
  int32_T iv_dim1, const int32_T x, const int32_T ns, int32_T loop_ub,
  emxArray_int8_T vals)
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
    vals.data[(((iv0 + ns) - x) + iv_dim1) + 2] = -1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel210(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel211(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel212(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel213(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel214(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel215(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel216
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel217(int32_T
  idx, uint32_T window_idx_0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((idx + static_cast<int32_T>(window_idx_0)) - 2);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel218(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv16)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv16.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel219(const
  emxArray_real_T convOut, const int32_T k, const emxArray_int32_T iv16, int32_T
  outridx, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outridx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv16.data[iv0]] = convOut.data[k - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel22(const
  emxArray_real_T a2, const real_T val, const emxArray_real_T b2, int32_T coef,
  emxArray_real_T rhs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(coef);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    rhs.data[iv0] = b2.data[iv0 + 1] - val * a2.data[iv0 + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel220(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T idx, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(idx - 1);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[i - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel221(const
  emxArray_real_T y, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    convOut.data[i] += y.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel222(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel223(const
  emxArray_real_T convOut, const int32_T ns, int32_T outridx, emxArray_real_T
  zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outridx - ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zfIIR.data[iv0] = convOut.data[ns + iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel224(const
  emxArray_real_T convOut, const emxArray_real_T a, int32_T ns, const int32_T
  a_dim0, const int32_T xt_dim0, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T i;
    i = static_cast<int32_T>(idx);
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 2.0, static_cast<
      real_T>(a_dim0))) - 2;
    for (int32_T iv0{0}; iv0 <= bcoef; iv0++) {
      zfIIR.data[i + 1] += convOut.data[(xt_dim0 + i) - iv0] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel225(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel226(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel227(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel228(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel229
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel23(const
  emxArray_int32_T rows, int32_T ns, emxArray_int32_T ridxInt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    ridxInt.data[m] = rows.data[m];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel230(int32_T
  idx, uint32_T window_idx_0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((idx + static_cast<int32_T>(window_idx_0)) - 2);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel231(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv17)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv17.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel232(const
  emxArray_real_T convOut, const emxArray_int32_T iv17, int32_T xx, const
  int32_T xx_dim0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv17.data[iv0]] = convOut.data[(xx_dim0 - iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel233(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T idx, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(idx - 1);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[i - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel234(const
  emxArray_real_T zfIIR, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    convOut.data[i] += zfIIR.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel235(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel236(const
  emxArray_real_T convOut, const int32_T outridx, emxArray_real_T b_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outridx - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b_convOut.data[iv0] = convOut.data[(outridx - iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel237(const
  emxArray_real_T convOut, int32_T ns, emxArray_real_T xx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    xx.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel238(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel239(const
  emxArray_real_T xx, real_T *d1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *d1 = 2.0 * xx.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel24(const
  emxArray_int32_T cols, int32_T ns, emxArray_int32_T cidxInt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    cidxInt.data[m] = cols.data[m];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel240(const
  emxArray_real_T xx, const int32_T *i, const real_T *d1, int32_T loop_ub,
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
    ytemp.data[iv0] = *d1 - xx.data[*i - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel241(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel242(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel243(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel244(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel245(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel246
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel247(int32_T
  idx, uint32_T window_idx_0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((idx + static_cast<int32_T>(window_idx_0)) - 2);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel248(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv1.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel249(const
  emxArray_real_T ytemp, const emxArray_int32_T iv1, int32_T b_ytemp,
  emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_ytemp);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv1.data[iv0]] = ytemp.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel25(int32_T
  nc, emxArray_int32_T sortedIndices)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nc);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    sortedIndices.data[m] = m + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel250(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T idx, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(idx - 1);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[i - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel251(const
  emxArray_real_T y, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    convOut.data[i] += y.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel252(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel253(const
  emxArray_real_T convOut, int32_T ytemp, emxArray_real_T dv3)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ytemp);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    dv3.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel254(const
  emxArray_real_T convOut, const int32_T k, emxArray_real_T ytemp)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(k);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    ytemp.data[iv0] = convOut.data[k - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel255(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel256(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel257(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel258(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel259(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel26(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel260
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel261(int32_T
  idx, uint32_T window_idx_0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((idx + static_cast<int32_T>(window_idx_0)) - 2);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel262(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv6)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv6.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel263(const
  emxArray_real_T convOut, const int32_T k, const emxArray_int32_T iv6, int32_T
  outridx, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(outridx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv6.data[iv0]] = convOut.data[k - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel264(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T idx, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(idx - 1);
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(b_idx);
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[i - 1] * b.data[(b_dim0 - m) - 1];
    }

    convOut.data[iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel265(const
  emxArray_real_T y, int32_T ns, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    convOut.data[i] += y.data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel266(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel267(const
  emxArray_real_T convOut, const int32_T outridx, const int32_T ns, int32_T vlen,
  emxArray_real_T xx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((vlen - ns) / outridx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    xx.data[iv0] = convOut.data[(ns + outridx * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel268(const
  emxArray_real_T xx, const int32_T b_xx, int32_T c_xx, const int32_T xx_dim0,
  const int32_T b_xx_dim0, emxArray_real_T d_xx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xx) + 1UL) * (static_cast<uint64_T>(c_xx) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xx) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_xx) + 1UL));
    d_xx.data[ix + xx_dim0 * iv0] = xx.data[iv0 + b_xx_dim0 * ix];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel269(const
  emxArray_real_T xx, int32_T b_xx, emxArray_real_T c_xx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    c_xx.data[iv0] = xx.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel27(const
  emxArray_int32_T t, const emxArray_int32_T sortedIndices, int32_T ns,
  emxArray_int32_T cidxInt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    cidxInt.data[m] = t.data[sortedIndices.data[m] - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel28(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel29(const
  emxArray_int32_T t, const emxArray_int32_T sortedIndices, int32_T ns,
  emxArray_int32_T ridxInt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    ridxInt.data[m] = t.data[sortedIndices.data[m] - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel3(const
  emxArray_real_T x, const int32_T b_x, const int32_T x_dim0, emxArray_real_T xx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_x) + 1UL));
    xx.data[iv0] = x.data[x_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel30(int32_T
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel31(const
  emxArray_int8_T vals, const emxArray_int32_T sortedIndices, int32_T nc,
  emxArray_real_T y_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nc);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    y_d.data[m] = vals.data[sortedIndices.data[m] - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel32(int32_T
  ns, emxArray_int32_T y_rowidx, emxArray_real_T y_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_d.data[iv0] = 0.0;
    y_rowidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel33(int32_T
  thism, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef + 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel34(int32_T
  nc, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nc);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef] = 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel35(const
  int32_T y_colidx_dim0, emxArray_int32_T y_colidx)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y_colidx.data[y_colidx_dim0 - 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel36(int32_T
  ns, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_colidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel37(int32_T
  thism, emxArray_int32_T counts)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    counts.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel38(const
  emxArray_real_T rhs, int32_T nc, emxArray_real_T outBuff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nc - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    outBuff.data[iv0] = rhs.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel39(const
  emxArray_real_T outBuff, int32_T *i, emxArray_real_T zi)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*i);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zi.data[iv0] = outBuff.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel4(const
  emxArray_real_T coef, int32_T b_coef, emxArray_real_T b)
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
    b.data[iv0] = coef.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel40(int32_T
  ns, emxArray_int32_T y_rowidx, emxArray_real_T y_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_d.data[iv0] = 0.0;
    y_rowidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel41(int32_T
  thism, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef + 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel42(int32_T
  nc, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nc);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef] = 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel43(const
  int32_T y_colidx_dim0, emxArray_int32_T y_colidx)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y_colidx.data[y_colidx_dim0 - 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel44(int32_T
  ns, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_colidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel45(int32_T
  thism, emxArray_int32_T counts)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    counts.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel46(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel47(int32_T
  ns, emxArray_int32_T y_rowidx, emxArray_real_T y_d)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_d.data[iv0] = 0.0;
    y_rowidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel48(int32_T
  thism, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef + 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel49(int32_T
  nc, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nc);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel5(const
  emxArray_real_T coef, int32_T b_coef, emxArray_real_T b2)
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
    b2.data[iv0] = coef.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel50(const
  int32_T y_colidx_dim0, emxArray_int32_T y_colidx)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    y_colidx.data[y_colidx_dim0 - 1] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel51(int32_T
  ns, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y_colidx.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel52(int32_T
  thism, emxArray_int32_T counts)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(thism - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    counts.data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel53(const
  emxArray_real_T rhs, int32_T nc, emxArray_real_T outBuff)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nc - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    outBuff.data[iv0] = rhs.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel54(const
  emxArray_real_T outBuff, int32_T *i, emxArray_real_T zi)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*i);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zi.data[iv0] = outBuff.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel55(const
  emxArray_real_T coef, emxArray_real_T b)
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 3) {
    b.data[iv0] = coef.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel56(const
  emxArray_real_T b, int32_T b_b, emxArray_real_T b1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b1.data[iv0] = b.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel57(const
  emxArray_real_T b, emxArray_real_T b1)
{
  uint64_T threadId;
  int32_T i;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  i = static_cast<int32_T>(threadId);
  if (i < 1) {
    b1.data[0] = b.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel58(const
  emxArray_real_T b1, int32_T nc, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nc);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    y.data[m] = fabs(b1.data[m]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel59(const
  int32_T vlen, const emxArray_real_T y, const int32_T nc, const int32_T ns,
  emxArray_real_T maxCoefNum)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T iv0;
    bcoef = static_cast<int32_T>(idx);
    iv0 = (div_s32_device(bcoef, ns) * nc + bcoef) + 1;
    maxCoefNum.data[bcoef] = y.data[iv0 - 1];
    for (int32_T i{0}; i <= vlen - 2; i++) {
      int32_T ix;
      boolean_T p;
      ix = iv0 + (i + 1) * ns;
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel6
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel60(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel61(const
  real_T val, int32_T *i, emxArray_real_T b1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(*i - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b1.data[iv0] /= val;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel62(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel63(const
  emxArray_int32_T ii, int32_T b_ii, emxArray_uint32_T nZeroLastDen)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_ii);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    nZeroLastDen.data[0] = static_cast<uint32_T>(ii.data[0]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel64(const
  emxArray_real_T b, real_T a0[3])
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 3) {
    a0[iv0] = b.data[iv0 + 3];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel65(const
  emxArray_real_T b, const real_T a0[3], emxArray_real_T b2, emxArray_real_T a2)
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 3) {
    a2.data[iv0] = a0[iv0] / a0[0];
    b2.data[iv0] = b.data[iv0] / a0[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel66(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel67(int8_T b_I
  [4])
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 4) {
    b_I[iv0] = 0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel68(int8_T b_I
  [4])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    b_I[0] = 1;
    b_I[3] = 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel69(const
  emxArray_real_T a2, const int8_T b_I[4], real_T A[4])
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 2) {
    A[iv0] = static_cast<real_T>(b_I[iv0]) - (-a2.data[iv0 + 1]);
    A[iv0 + 2] = (b_I[iv0 + 2] + iv0) - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel7(int32_T
  loop_ub, emxArray_real_T a2)
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
    a2.data[iv0 + 1] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel70(const
  real_T A[4], const real_T val, const int32_T ns, const real_T rhs[2], const
  int32_T nc, real_T Y[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    Y[1] = (rhs[nc] - rhs[ns] * val) / (A[nc + 2] - val * A[ns + 2]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel71(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel72(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel73(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel74(const
  emxArray_real_T xx, int32_T b_xx, const int32_T xx_dim0, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xx);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = 2.0 * xx.data[xx_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel75(const
  emxArray_real_T xx, const emxArray_real_T y, const real_T nfact, const int32_T
  outridx, const int32_T ns, const int32_T xt, int32_T vlen, const int32_T
  xt_dim0, const int32_T xx_dim0, emxArray_real_T b_xt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(xt) + 1UL) * (static_cast<uint64_T>(vlen - 1)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(xt) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(xt) + 1UL));
    b_xt.data[i + xt_dim0 * m] = y.data[ns * m] - xx.data[((static_cast<int32_T>
      (nfact + 1.0) - (static_cast<int32_T>(nfact + 1.0) - 1 != 1) * i) +
      xx_dim0 * (outridx * m)) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel76(const
  emxArray_real_T xt, const emxArray_real_T zi, const int32_T b_zi, int32_T
  loop_ub, const int32_T y_dim0, const int32_T xt_dim0, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_zi) + 1UL) * (static_cast<uint64_T>(loop_ub)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_zi) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_zi) + 1UL));
    y.data[ix + y_dim0 * iv0] = zi.data[ix] * xt.data[xt_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel77(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel78(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel79(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel8(int32_T
  coef, emxArray_int32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(coef);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = iv0 + 2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel80(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel81
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel82(const
  int32_T b_dim0, uint32_T zfSize[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    zfSize[0] = static_cast<uint32_T>(b_dim0 - 1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel83(int32_T
  idx, emxArray_real_T expanded)
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
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel84(const
  int32_T nc, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv2)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    i = y.data[iv0];
    if ((nc < 0) && (i < MIN_int32_T - nc)) {
      i = MIN_int32_T;
    } else if ((nc > 0) && (i > MAX_int32_T - nc)) {
      i = MAX_int32_T;
    } else {
      i += nc;
    }

    iv2.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel85(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv3)
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
    iv3.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel86(const
  emxArray_real_T xt, const emxArray_int32_T iv3, const emxArray_int32_T iv2,
  const int32_T b_xt, int32_T c_xt, const int32_T expanded_dim0, const int32_T
  xt_dim0, emxArray_real_T expanded)
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
    expanded.data[iv2.data[ix] + expanded_dim0 * iv3.data[iv0]] = xt.data[ix +
      xt_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel87(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T idx, int32_T c, const int32_T b_dim0, const int32_T convOut_dim0,
  const int32_T expanded_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(idx - 1) + 1UL) * (static_cast<uint64_T>(c) +
    1UL) - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    iv0 = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(idx - 1) + 1UL));
    ix = static_cast<int32_T>((b_idx - static_cast<uint64_T>(iv0)) / (
      static_cast<uint64_T>(idx - 1) + 1UL));
    cv = 0.0;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T i;
      i = rows.data[m];
      if (i > 2147483646 - iv0) {
        i = MAX_int32_T;
      } else {
        i = (iv0 + i) + 1;
      }

      cv += expanded.data[(i + expanded_dim0 * ix) - 1] * b.data[(b_dim0 - m) -
        1];
    }

    convOut.data[iv0 + convOut_dim0 * ix] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel88(const
  emxArray_real_T y, const emxArray_real_T convOut, const int32_T b_y, int32_T
  b_convOut, const int32_T convOut_dim0, const int32_T b_convOut_dim0, const
  int32_T y_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_y) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + y.data[ix + y_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel89(const
  emxArray_real_T convOut, const int32_T b_convOut, int32_T c_convOut, const
  int32_T convOut_dim0, const int32_T b_convOut_dim0, emxArray_real_T d_convOut)
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel9(int32_T
  coef, emxArray_int32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(coef);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = iv0 + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel90(const
  emxArray_real_T y, const int32_T b_y, int32_T ns, const int32_T convOut_dim0,
  emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>(ns) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_y) + 1UL));
    convOut.data[i + convOut_dim0 * m] += y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel91(const
  emxArray_real_T y, const int32_T b_y, int32_T ns, const int32_T convOut_dim0,
  const int32_T y_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>(ns) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_y) + 1UL));
    convOut.data[i + convOut_dim0 * m] += y.data[y_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel92(const
  emxArray_real_T a, int32_T ns, const int32_T xt_dim0, const int32_T a_dim0,
  const int32_T convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T ix;
    int32_T m;
    m = static_cast<int32_T>(idx);
    ix = (xt_dim0 + a_dim0) - 1;
    for (int32_T i{0}; i < ix; i++) {
      int32_T bcoef;
      bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 1.0,
        static_cast<real_T>(a_dim0))) - 1;
      for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
        convOut.data[i + convOut_dim0 * m] -= convOut.data[((i - iv0) +
          convOut_dim0 * m) - 1] * a.data[iv0 + 1];
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel93(const
  emxArray_real_T convOut, const int32_T ns, const int32_T outridx, int32_T
  b_convOut, const int32_T zfIIR_dim0, const int32_T convOut_dim0,
  emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(outridx - ns) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(outridx - ns) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(outridx - ns) + 1UL));
    zfIIR.data[ix + zfIIR_dim0 * iv0] = convOut.data[(ns + ix) + convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel94(const
  emxArray_real_T convOut, const emxArray_real_T a, const int32_T b_a, int32_T
  ns, const int32_T a_dim0, const int32_T zfIIR_dim0, const int32_T xt_dim0,
  const int32_T convOut_dim0, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_a) + 1UL) * (static_cast<uint64_T>(ns) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_a) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b_a) + 1UL));
    bcoef = static_cast<int32_T>(fmin(static_cast<real_T>(i) + 2.0, static_cast<
      real_T>(a_dim0))) - 1;
    for (int32_T iv0{0}; iv0 < bcoef; iv0++) {
      zfIIR.data[(i + zfIIR_dim0 * m) + 1] += convOut.data[((xt_dim0 + i) - iv0)
        + convOut_dim0 * m] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel95(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel96(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel97(const
  real_T *a1, int32_T nb, emxArray_real_T b)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nb);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b.data[m] /= *a1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel98(const
  real_T *a1, int32_T na, emxArray_real_T a)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    a.data[m + 1] /= *a1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel99
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

static void ec_filtfilt_once()
{
  mwMemoryManagerInit(256U, 1U, 8U, 2048U);
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

static void emxEnsureCapacity_struct_T(emxArray_struct_T *emxArray, int32_T
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(struct_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<struct_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<struct_T *>(newData);
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

static void emxEnsureCapacity_uint32_T(emxArray_uint32_T *emxArray, int32_T
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

    newData = emlrtCallocMex(static_cast<uint32_T>(i), sizeof(uint32_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<uint32_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<uint32_T *>(newData);
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

static void emxFree_struct_T(emxArray_struct_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_struct_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<struct_T *>(nullptr)) && (*pEmxArray
        )->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_struct_T *>(nullptr);
  }
}

static void emxFree_uint32_T(emxArray_uint32_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_uint32_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<uint32_T *>(nullptr)) && (*pEmxArray
        )->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_uint32_T *>(nullptr);
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

static void emxInit_struct_T(emxArray_struct_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_struct_T *emxArray;
  *pEmxArray = static_cast<emxArray_struct_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_struct_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_struct_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<struct_T *>(nullptr);
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

static void emxInit_uint32_T(emxArray_uint32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_uint32_T *emxArray;
  *pEmxArray = static_cast<emxArray_uint32_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_uint32_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_uint32_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<uint32_T *>(nullptr);
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

static void feval(const mxArray *m, const mxArray *m1, emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  pArrays[0] = m;
  pArrays[1] = m1;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, nullptr, 2, &pArrays[0], "feval",
                        true, location);
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

static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu)
{
  uint32_T *newData;
  if (gpu->data == 0U) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(static_cast<uint32_T>
      (cpu->allocatedSize) * sizeof(uint32_T)));
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
        (cpu->allocatedSize) * sizeof(uint32_T)));
      cudaMemcpy(newData, gpu->data, static_cast<uint32_T>(actualSizeGpu) *
                 sizeof(uint32_T), cudaMemcpyDeviceToDevice);
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

static void gpuEmxFree_uint32_T(emxArray_uint32_T *gpu)
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

static void gpuEmxMemcpyGpuToCpu_uint32_T(emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>(actualSize) * sizeof
             (uint32_T), cudaMemcpyDeviceToHost);
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

static void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_uint32_T));
}

//
// function xx = ec_filtfilt(x,coef)
void ec_filtfilt(const emxArray_real_T *x, const emxArray_real_T *coef,
                 emxArray_real_T *xx)
{
  static const int32_T iv8[2]{ 1, 6 };

  static const char_T rfmt[6]{ '%', '1', '4', '.', '6', 'e' };

  dim3 block;
  dim3 grid;
  dim3 r;
  dim3 r1;
  emxArray_boolean_T b_gpu_x;
  emxArray_boolean_T c_gpu_x;
  emxArray_boolean_T *b_x;
  emxArray_boolean_T *c_x;
  emxArray_int32_T ab_gpu_y;
  emxArray_int32_T b_gpu_counts;
  emxArray_int32_T b_gpu_rows;
  emxArray_int32_T b_gpu_t;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T b_gpu_y_colidx;
  emxArray_int32_T b_gpu_y_rowidx;
  emxArray_int32_T bb_gpu_y;
  emxArray_int32_T c_gpu_counts;
  emxArray_int32_T c_gpu_rows;
  emxArray_int32_T c_gpu_y;
  emxArray_int32_T c_gpu_y_colidx;
  emxArray_int32_T c_gpu_y_rowidx;
  emxArray_int32_T d_gpu_rows;
  emxArray_int32_T d_gpu_y_rowidx;
  emxArray_int32_T db_gpu_y;
  emxArray_int32_T e_gpu_rows;
  emxArray_int32_T eb_gpu_y;
  emxArray_int32_T f_gpu_rows;
  emxArray_int32_T g_gpu_rows;
  emxArray_int32_T g_gpu_y;
  emxArray_int32_T gpu_cidxInt;
  emxArray_int32_T gpu_cols;
  emxArray_int32_T gpu_counts;
  emxArray_int32_T gpu_ii;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_iv10;
  emxArray_int32_T gpu_iv11;
  emxArray_int32_T gpu_iv12;
  emxArray_int32_T gpu_iv13;
  emxArray_int32_T gpu_iv14;
  emxArray_int32_T gpu_iv15;
  emxArray_int32_T gpu_iv16;
  emxArray_int32_T gpu_iv17;
  emxArray_int32_T gpu_iv2;
  emxArray_int32_T gpu_iv3;
  emxArray_int32_T gpu_iv4;
  emxArray_int32_T gpu_iv5;
  emxArray_int32_T gpu_iv6;
  emxArray_int32_T gpu_iv7;
  emxArray_int32_T gpu_iv9;
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
  emxArray_int32_T j_gpu_y;
  emxArray_int32_T k_gpu_rows;
  emxArray_int32_T k_gpu_y;
  emxArray_int32_T l_gpu_rows;
  emxArray_int32_T l_gpu_y;
  emxArray_int32_T m_gpu_rows;
  emxArray_int32_T o_gpu_y;
  emxArray_int32_T p_gpu_y;
  emxArray_int32_T q_gpu_y;
  emxArray_int32_T s_gpu_y;
  emxArray_int32_T t_gpu_y;
  emxArray_int32_T u_gpu_y;
  emxArray_int32_T v_gpu_y;
  emxArray_int32_T w_gpu_y;
  emxArray_int32_T x_gpu_y;
  emxArray_int32_T y_gpu_y;
  emxArray_int32_T *ab_y;
  emxArray_int32_T *b_counts;
  emxArray_int32_T *b_rows;
  emxArray_int32_T *b_t;
  emxArray_int32_T *b_y_colidx;
  emxArray_int32_T *b_y_rowidx;
  emxArray_int32_T *c_counts;
  emxArray_int32_T *c_rows;
  emxArray_int32_T *c_y;
  emxArray_int32_T *c_y_colidx;
  emxArray_int32_T *c_y_rowidx;
  emxArray_int32_T *cb_y;
  emxArray_int32_T *cidxInt;
  emxArray_int32_T *cols;
  emxArray_int32_T *counts;
  emxArray_int32_T *d_rows;
  emxArray_int32_T *d_y;
  emxArray_int32_T *d_y_colidx;
  emxArray_int32_T *d_y_rowidx;
  emxArray_int32_T *db_y;
  emxArray_int32_T *e_rows;
  emxArray_int32_T *e_y;
  emxArray_int32_T *eb_y;
  emxArray_int32_T *f_rows;
  emxArray_int32_T *g_rows;
  emxArray_int32_T *h_rows;
  emxArray_int32_T *i_rows;
  emxArray_int32_T *ii;
  emxArray_int32_T *iv;
  emxArray_int32_T *iv1;
  emxArray_int32_T *iv10;
  emxArray_int32_T *iv11;
  emxArray_int32_T *iv12;
  emxArray_int32_T *iv13;
  emxArray_int32_T *iv14;
  emxArray_int32_T *iv15;
  emxArray_int32_T *iv16;
  emxArray_int32_T *iv17;
  emxArray_int32_T *iv2;
  emxArray_int32_T *iv3;
  emxArray_int32_T *iv4;
  emxArray_int32_T *iv5;
  emxArray_int32_T *iv6;
  emxArray_int32_T *iv7;
  emxArray_int32_T *iv9;
  emxArray_int32_T *j_rows;
  emxArray_int32_T *j_y;
  emxArray_int32_T *k_rows;
  emxArray_int32_T *k_y;
  emxArray_int32_T *l_rows;
  emxArray_int32_T *l_y;
  emxArray_int32_T *m_rows;
  emxArray_int32_T *m_y;
  emxArray_int32_T *o_y;
  emxArray_int32_T *q_y;
  emxArray_int32_T *r_y;
  emxArray_int32_T *ridxInt;
  emxArray_int32_T *rows;
  emxArray_int32_T *sortedIndices;
  emxArray_int32_T *t;
  emxArray_int32_T *t_y;
  emxArray_int32_T *u_y;
  emxArray_int32_T *v_y;
  emxArray_int32_T *w_y;
  emxArray_int32_T *x_y;
  emxArray_int32_T *y;
  emxArray_int32_T *y_colidx;
  emxArray_int32_T *y_rowidx;
  emxArray_int32_T *y_y;
  emxArray_int8_T gpu_vals;
  emxArray_int8_T *vals;
  emxArray_real_T b_gpu_a;
  emxArray_real_T b_gpu_b;
  emxArray_real_T b_gpu_convOut;
  emxArray_real_T b_gpu_expanded;
  emxArray_real_T b_gpu_outBuff;
  emxArray_real_T b_gpu_rhs;
  emxArray_real_T b_gpu_xt;
  emxArray_real_T b_gpu_xx;
  emxArray_real_T b_gpu_y_d;
  emxArray_real_T b_gpu_zfIIR;
  emxArray_real_T c_gpu_a;
  emxArray_real_T c_gpu_b;
  emxArray_real_T c_gpu_convOut;
  emxArray_real_T c_gpu_expanded;
  emxArray_real_T c_gpu_y_d;
  emxArray_real_T c_gpu_zfIIR;
  emxArray_real_T cb_gpu_y;
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
  emxArray_real_T e_gpu_y;
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
  emxArray_real_T gpu_dv3;
  emxArray_real_T gpu_expanded;
  emxArray_real_T gpu_maxCoefNum;
  emxArray_real_T gpu_outBuff;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xt;
  emxArray_real_T gpu_xx;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_y_d;
  emxArray_real_T gpu_yc2;
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
  emxArray_real_T k_gpu_a;
  emxArray_real_T k_gpu_b;
  emxArray_real_T k_gpu_convOut;
  emxArray_real_T k_gpu_expanded;
  emxArray_real_T l_gpu_a;
  emxArray_real_T l_gpu_b;
  emxArray_real_T l_gpu_convOut;
  emxArray_real_T l_gpu_expanded;
  emxArray_real_T m_gpu_b;
  emxArray_real_T m_gpu_convOut;
  emxArray_real_T m_gpu_y;
  emxArray_real_T n_gpu_b;
  emxArray_real_T n_gpu_convOut;
  emxArray_real_T n_gpu_y;
  emxArray_real_T o_gpu_convOut;
  emxArray_real_T p_gpu_convOut;
  emxArray_real_T q_gpu_convOut;
  emxArray_real_T r_gpu_convOut;
  emxArray_real_T r_gpu_y;
  emxArray_real_T s_gpu_convOut;
  emxArray_real_T t_gpu_convOut;
  emxArray_real_T u_gpu_convOut;
  emxArray_real_T *a;
  emxArray_real_T *a2;
  emxArray_real_T *b;
  emxArray_real_T *b1;
  emxArray_real_T *b2;
  emxArray_real_T *b_a;
  emxArray_real_T *b_b;
  emxArray_real_T *b_convOut;
  emxArray_real_T *b_expanded;
  emxArray_real_T *b_outBuff;
  emxArray_real_T *b_xt;
  emxArray_real_T *b_xx;
  emxArray_real_T *b_y;
  emxArray_real_T *b_y_d;
  emxArray_real_T *b_zfIIR;
  emxArray_real_T *bb_y;
  emxArray_real_T *c_a;
  emxArray_real_T *c_b;
  emxArray_real_T *c_convOut;
  emxArray_real_T *c_expanded;
  emxArray_real_T *c_y_d;
  emxArray_real_T *c_zfIIR;
  emxArray_real_T *convOut;
  emxArray_real_T *d_a;
  emxArray_real_T *d_b;
  emxArray_real_T *d_convOut;
  emxArray_real_T *d_expanded;
  emxArray_real_T *d_y_d;
  emxArray_real_T *d_zfIIR;
  emxArray_real_T *dv3;
  emxArray_real_T *e_a;
  emxArray_real_T *e_b;
  emxArray_real_T *e_convOut;
  emxArray_real_T *e_expanded;
  emxArray_real_T *e_zfIIR;
  emxArray_real_T *expanded;
  emxArray_real_T *f_a;
  emxArray_real_T *f_b;
  emxArray_real_T *f_convOut;
  emxArray_real_T *f_expanded;
  emxArray_real_T *f_y;
  emxArray_real_T *f_zfIIR;
  emxArray_real_T *g_a;
  emxArray_real_T *g_b;
  emxArray_real_T *g_convOut;
  emxArray_real_T *g_expanded;
  emxArray_real_T *g_y;
  emxArray_real_T *h_a;
  emxArray_real_T *h_b;
  emxArray_real_T *h_convOut;
  emxArray_real_T *h_expanded;
  emxArray_real_T *h_y;
  emxArray_real_T *i_a;
  emxArray_real_T *i_b;
  emxArray_real_T *i_convOut;
  emxArray_real_T *i_expanded;
  emxArray_real_T *i_y;
  emxArray_real_T *j_a;
  emxArray_real_T *j_b;
  emxArray_real_T *j_convOut;
  emxArray_real_T *j_expanded;
  emxArray_real_T *k_a;
  emxArray_real_T *k_b;
  emxArray_real_T *k_convOut;
  emxArray_real_T *k_expanded;
  emxArray_real_T *l_a;
  emxArray_real_T *l_b;
  emxArray_real_T *l_convOut;
  emxArray_real_T *l_expanded;
  emxArray_real_T *m_b;
  emxArray_real_T *m_convOut;
  emxArray_real_T *maxCoefNum;
  emxArray_real_T *n_b;
  emxArray_real_T *n_convOut;
  emxArray_real_T *n_y;
  emxArray_real_T *o_convOut;
  emxArray_real_T *outBuff;
  emxArray_real_T *p_convOut;
  emxArray_real_T *p_y;
  emxArray_real_T *q_convOut;
  emxArray_real_T *r_convOut;
  emxArray_real_T *rhs;
  emxArray_real_T *s_convOut;
  emxArray_real_T *s_y;
  emxArray_real_T *t_convOut;
  emxArray_real_T *u_convOut;
  emxArray_real_T *xt;
  emxArray_real_T *y_d;
  emxArray_real_T *yc2;
  emxArray_real_T *yc3;
  emxArray_real_T *yc5;
  emxArray_real_T *ytemp;
  emxArray_real_T *zfIIR;
  emxArray_real_T *zi;
  emxArray_uint32_T gpu_nZeroLastDen;
  emxArray_uint32_T *nZeroLastDen;
  const mxArray *fb_y;
  const mxArray *gb_y;
  const mxArray *m;
  real_T A[4];
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
  real_T *gpu_d1;
  int32_T b_iv[2];
  int32_T i;
  int32_T *gpu_i;
  uint32_T dv1[2];
  uint32_T zfSize[2];
  uint32_T (*gpu_zfSize)[2];
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
  boolean_T b_y_dirtyOnGpu;
  boolean_T b_y_rowidx_dirtyOnGpu;
  boolean_T b_zfIIR_dirtyOnGpu;
  boolean_T c_a_dirtyOnGpu;
  boolean_T c_b_dirtyOnCpu;
  boolean_T c_b_dirtyOnGpu;
  boolean_T c_convOut_dirtyOnCpu;
  boolean_T c_convOut_dirtyOnGpu;
  boolean_T c_counts_dirtyOnGpu;
  boolean_T c_y_d_dirtyOnGpu;
  boolean_T c_y_rowidx_dirtyOnGpu;
  boolean_T c_zfIIR_dirtyOnGpu;
  boolean_T cidxInt_dirtyOnGpu;
  boolean_T coef_dirtyOnCpu;
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
  boolean_T dv3_dirtyOnGpu;
  boolean_T e_a_dirtyOnGpu;
  boolean_T e_b_dirtyOnCpu;
  boolean_T e_b_dirtyOnGpu;
  boolean_T e_convOut_dirtyOnCpu;
  boolean_T e_convOut_dirtyOnGpu;
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
  boolean_T ii_dirtyOnCpu;
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
  boolean_T nZeroLastDen_dirtyOnGpu;
  boolean_T ridxInt_dirtyOnGpu;
  boolean_T x_dirtyOnGpu;
  boolean_T xx_dirtyOnCpu;
  boolean_T xx_dirtyOnGpu;
  boolean_T y_d_dirtyOnGpu;
  boolean_T y_dirtyOnGpu;
  boolean_T y_rowidx_dirtyOnGpu;
  boolean_T ytemp_dirtyOnCpu;
  boolean_T ytemp_dirtyOnGpu;
  boolean_T zfIIR_dirtyOnGpu;
  boolean_T zfSize_dirtyOnCpu;
  boolean_T zi_dirtyOnCpu;
  gpuEmxReset_real_T(&u_gpu_convOut);
  gpuEmxReset_real_T(&t_gpu_convOut);
  gpuEmxReset_int32_T(&m_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv17);
  gpuEmxReset_int32_T(&eb_gpu_y);
  gpuEmxReset_real_T(&l_gpu_expanded);
  gpuEmxReset_real_T(&l_gpu_a);
  gpuEmxReset_real_T(&n_gpu_b);
  gpuEmxReset_real_T(&f_gpu_zfIIR);
  gpuEmxReset_real_T(&s_gpu_convOut);
  gpuEmxReset_int32_T(&l_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv16);
  gpuEmxReset_int32_T(&db_gpu_y);
  gpuEmxReset_real_T(&k_gpu_expanded);
  gpuEmxReset_real_T(&k_gpu_a);
  gpuEmxReset_real_T(&r_gpu_convOut);
  gpuEmxReset_real_T(&q_gpu_convOut);
  gpuEmxReset_real_T(&m_gpu_b);
  gpuEmxReset_real_T(&cb_gpu_y);
  gpuEmxReset_real_T(&e_gpu_zfIIR);
  gpuEmxReset_real_T(&p_gpu_convOut);
  gpuEmxReset_int32_T(&k_gpu_rows);
  gpuEmxReset_real_T(&o_gpu_convOut);
  gpuEmxReset_int32_T(&j_gpu_rows);
  gpuEmxReset_real_T(&n_gpu_convOut);
  gpuEmxReset_real_T(&m_gpu_convOut);
  gpuEmxReset_int32_T(&i_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv11);
  gpuEmxReset_int32_T(&bb_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv15);
  gpuEmxReset_int32_T(&ab_gpu_y);
  gpuEmxReset_real_T(&l_gpu_convOut);
  gpuEmxReset_real_T(&k_gpu_convOut);
  gpuEmxReset_real_T(&j_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_iv14);
  gpuEmxReset_int32_T(&y_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv13);
  gpuEmxReset_int32_T(&x_gpu_y);
  gpuEmxReset_real_T(&gpu_yc2);
  gpuEmxReset_real_T(&j_gpu_convOut);
  gpuEmxReset_int32_T(&h_gpu_rows);
  gpuEmxReset_real_T(&i_gpu_expanded);
  gpuEmxReset_real_T(&i_gpu_convOut);
  gpuEmxReset_real_T(&j_gpu_a);
  gpuEmxReset_int32_T(&gpu_iv12);
  gpuEmxReset_int32_T(&w_gpu_y);
  gpuEmxReset_real_T(&b_gpu_xx);
  gpuEmxReset_real_T(&l_gpu_b);
  gpuEmxReset_real_T(&gpu_yc5);
  gpuEmxReset_real_T(&h_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_iv10);
  gpuEmxReset_int32_T(&v_gpu_y);
  gpuEmxReset_real_T(&d_gpu_zfIIR);
  gpuEmxReset_int32_T(&c_gpu_counts);
  gpuEmxReset_real_T(&i_gpu_a);
  gpuEmxReset_real_T(&c_gpu_zfIIR);
  gpuEmxReset_real_T(&h_gpu_convOut);
  gpuEmxReset_real_T(&k_gpu_b);
  gpuEmxReset_int32_T(&b_gpu_counts);
  gpuEmxReset_int32_T(&gpu_counts);
  gpuEmxReset_real_T(&g_gpu_convOut);
  gpuEmxReset_int32_T(&g_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv9);
  gpuEmxReset_int32_T(&u_gpu_y);
  gpuEmxReset_real_T(&f_gpu_convOut);
  gpuEmxReset_int32_T(&f_gpu_rows);
  gpuEmxReset_real_T(&e_gpu_convOut);
  gpuEmxReset_int32_T(&e_gpu_rows);
  gpuEmxReset_real_T(&h_gpu_a);
  gpuEmxReset_int32_T(&c_gpu_y_colidx);
  gpuEmxReset_real_T(&b_gpu_outBuff);
  gpuEmxReset_real_T(&g_gpu_expanded);
  gpuEmxReset_real_T(&b_gpu_zfIIR);
  gpuEmxReset_real_T(&d_gpu_y_d);
  gpuEmxReset_int32_T(&d_gpu_y_rowidx);
  gpuEmxReset_real_T(&gpu_outBuff);
  gpuEmxReset_int32_T(&gpu_iv6);
  gpuEmxReset_int32_T(&t_gpu_y);
  gpuEmxReset_real_T(&j_gpu_b);
  gpuEmxReset_real_T(&d_gpu_convOut);
  gpuEmxReset_int32_T(&b_gpu_y_colidx);
  gpuEmxReset_int32_T(&gpu_y_colidx);
  gpuEmxReset_real_T(&c_gpu_y_d);
  gpuEmxReset_int32_T(&c_gpu_y_rowidx);
  gpuEmxReset_real_T(&b_gpu_y_d);
  gpuEmxReset_int32_T(&b_gpu_y_rowidx);
  gpuEmxReset_int32_T(&gpu_iv7);
  gpuEmxReset_int32_T(&s_gpu_y);
  gpuEmxReset_real_T(&r_gpu_y);
  gpuEmxReset_real_T(&gpu_yc3);
  gpuEmxReset_real_T(&f_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_iv5);
  gpuEmxReset_int32_T(&q_gpu_y);
  gpuEmxReset_real_T(&c_gpu_convOut);
  gpuEmxReset_int32_T(&d_gpu_rows);
  gpuEmxReset_real_T(&e_gpu_expanded);
  gpuEmxReset_real_T(&g_gpu_a);
  gpuEmxReset_int32_T(&gpu_iv4);
  gpuEmxReset_int32_T(&p_gpu_y);
  gpuEmxReset_real_T(&i_gpu_b);
  gpuEmxReset_real_T(&gpu_y_d);
  gpuEmxReset_int32_T(&gpu_y_rowidx);
  gpuEmxReset_real_T(&f_gpu_a);
  gpuEmxReset_real_T(&h_gpu_b);
  gpuEmxReset_real_T(&e_gpu_a);
  gpuEmxReset_int32_T(&gpu_iv3);
  gpuEmxReset_int32_T(&o_gpu_y);
  gpuEmxReset_real_T(&d_gpu_expanded);
  gpuEmxReset_real_T(&n_gpu_y);
  gpuEmxReset_real_T(&g_gpu_b);
  gpuEmxReset_real_T(&m_gpu_y);
  gpuEmxReset_int32_T(&b_gpu_t);
  gpuEmxReset_int32_T(&gpu_iv2);
  gpuEmxReset_int32_T(&l_gpu_y);
  gpuEmxReset_real_T(&gpu_zfIIR);
  gpuEmxReset_int32_T(&gpu_t);
  gpuEmxReset_real_T(&gpu_dv3);
  gpuEmxReset_int32_T(&gpu_sortedIndices);
  gpuEmxReset_real_T(&c_gpu_expanded);
  gpuEmxReset_real_T(&b_gpu_convOut);
  gpuEmxReset_int32_T(&c_gpu_rows);
  gpuEmxReset_real_T(&gpu_convOut);
  gpuEmxReset_int32_T(&b_gpu_rows);
  gpuEmxReset_int32_T(&gpu_cidxInt);
  gpuEmxReset_real_T(&d_gpu_a);
  gpuEmxReset_int32_T(&gpu_ridxInt);
  gpuEmxReset_real_T(&f_gpu_b);
  gpuEmxReset_real_T(&b_gpu_rhs);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_int32_T(&k_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&j_gpu_y);
  mwCudaMalloc(&gpu_zfSize, 8UL);
  mwCudaMalloc(&gpu_Y, 16UL);
  gpuEmxReset_real_T(&c_gpu_a);
  mwCudaMalloc(&gpu_A, 32UL);
  gpuEmxReset_real_T(&b_gpu_expanded);
  gpuEmxReset_real_T(&gpu_expanded);
  mwCudaMalloc(&gpu_I, 4UL);
  gpuEmxReset_int8_T(&gpu_vals);
  mwCudaMalloc(&gpu_rhs, 16UL);
  gpuEmxReset_real_T(&e_gpu_b);
  gpuEmxReset_real_T(&i_gpu_y);
  gpuEmxReset_real_T(&b_gpu_xt);
  mwCudaMalloc(&gpu_a0, 24UL);
  gpuEmxReset_uint32_T(&gpu_nZeroLastDen);
  gpuEmxReset_int32_T(&gpu_ii);
  gpuEmxReset_real_T(&b_gpu_a);
  gpuEmxReset_int32_T(&h_gpu_y);
  gpuEmxReset_real_T(&gpu_a);
  gpuEmxReset_int32_T(&gpu_cols);
  gpuEmxReset_real_T(&d_gpu_b);
  gpuEmxReset_real_T(&c_gpu_b);
  gpuEmxReset_int32_T(&g_gpu_y);
  gpuEmxReset_real_T(&f_gpu_y);
  gpuEmxReset_boolean_T(&c_gpu_x);
  gpuEmxReset_real_T(&e_gpu_y);
  gpuEmxReset_real_T(&gpu_zi);
  gpuEmxReset_real_T(&d_gpu_y);
  gpuEmxReset_real_T(&gpu_xt);
  gpuEmxReset_real_T(&gpu_ytemp);
  gpuEmxReset_boolean_T(&b_gpu_x);
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&c_gpu_y);
  gpuEmxReset_real_T(&gpu_maxCoefNum);
  gpuEmxReset_int32_T(&b_gpu_y);
  mwCudaMalloc(&gpu_d1, 8UL);
  mwCudaMalloc(&e_gpu_a1, 8UL);
  mwCudaMalloc(&d_gpu_a1, 8UL);
  mwCudaMalloc(&c_gpu_a1, 8UL);
  mwCudaMalloc(&b_gpu_a1, 8UL);
  mwCudaMalloc(&gpu_a1, 8UL);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_a2);
  gpuEmxReset_real_T(&b_gpu_b);
  gpuEmxReset_real_T(&gpu_b1);
  gpuEmxReset_real_T(&gpu_b2);
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_real_T(&gpu_coef);
  gpuEmxReset_real_T(&gpu_x);
  mwCudaMalloc(&gpu_i, 4UL);
  gpuEmxReset_real_T(&gpu_xx);
  l_convOut_dirtyOnGpu = false;
  g_a_dirtyOnGpu = false;
  l_b_dirtyOnGpu = false;
  k_convOut_dirtyOnGpu = false;
  f_a_dirtyOnGpu = false;
  k_b_dirtyOnGpu = false;
  c_zfIIR_dirtyOnGpu = false;
  j_convOut_dirtyOnGpu = false;
  i_convOut_dirtyOnGpu = false;
  h_convOut_dirtyOnGpu = false;
  g_convOut_dirtyOnGpu = false;
  e_a_dirtyOnGpu = false;
  j_b_dirtyOnGpu = false;
  b_zfIIR_dirtyOnGpu = false;
  c_counts_dirtyOnGpu = false;
  i_b_dirtyOnGpu = false;
  b_counts_dirtyOnGpu = false;
  counts_dirtyOnGpu = false;
  f_convOut_dirtyOnGpu = false;
  e_convOut_dirtyOnGpu = false;
  d_convOut_dirtyOnGpu = false;
  zfIIR_dirtyOnGpu = false;
  d_y_d_dirtyOnGpu = false;
  d_y_rowidx_dirtyOnGpu = false;
  h_b_dirtyOnGpu = false;
  c_y_d_dirtyOnGpu = false;
  c_y_rowidx_dirtyOnGpu = false;
  b_y_d_dirtyOnGpu = false;
  b_y_rowidx_dirtyOnGpu = false;
  b_y_dirtyOnGpu = false;
  c_convOut_dirtyOnGpu = false;
  g_b_dirtyOnGpu = false;
  y_d_dirtyOnGpu = false;
  y_rowidx_dirtyOnGpu = false;
  d_a_dirtyOnGpu = false;
  f_b_dirtyOnGpu = false;
  c_a_dirtyOnGpu = false;
  e_b_dirtyOnGpu = false;
  dv3_dirtyOnGpu = false;
  b_convOut_dirtyOnGpu = false;
  convOut_dirtyOnGpu = false;
  cidxInt_dirtyOnGpu = false;
  ridxInt_dirtyOnGpu = false;
  d_b_dirtyOnGpu = false;
  c_b_dirtyOnGpu = false;
  y_dirtyOnGpu = false;
  nZeroLastDen_dirtyOnGpu = false;
  b_a_dirtyOnGpu = false;
  a_dirtyOnGpu = false;
  b_b_dirtyOnGpu = false;
  b_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  ytemp_dirtyOnGpu = false;
  x_dirtyOnGpu = false;
  maxCoefNum_dirtyOnGpu = false;
  b2_dirtyOnGpu = false;
  l_convOut_dirtyOnCpu = false;
  l_b_dirtyOnCpu = false;
  k_convOut_dirtyOnCpu = false;
  k_b_dirtyOnCpu = false;
  j_convOut_dirtyOnCpu = false;
  i_convOut_dirtyOnCpu = false;
  h_convOut_dirtyOnCpu = false;
  g_convOut_dirtyOnCpu = false;
  j_b_dirtyOnCpu = false;
  i_b_dirtyOnCpu = false;
  f_convOut_dirtyOnCpu = false;
  e_convOut_dirtyOnCpu = false;
  d_convOut_dirtyOnCpu = false;
  h_b_dirtyOnCpu = false;
  c_convOut_dirtyOnCpu = false;
  g_b_dirtyOnCpu = false;
  f_b_dirtyOnCpu = false;
  e_b_dirtyOnCpu = false;
  b_convOut_dirtyOnCpu = false;
  convOut_dirtyOnCpu = false;
  d_b_dirtyOnCpu = false;
  zfSize_dirtyOnCpu = false;
  c_b_dirtyOnCpu = false;
  ii_dirtyOnCpu = false;
  b_b_dirtyOnCpu = false;
  b_dirtyOnCpu = false;
  zi_dirtyOnCpu = false;
  ytemp_dirtyOnCpu = false;
  coef_dirtyOnCpu = true;
  xx_dirtyOnGpu = false;
  xx_dirtyOnCpu = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  //  Add kernelfun pragma to trigger kernel creation
  // 'ec_filtfilt:3' coder.gpu.kernelfun;
  // nCh = size(x,2);
  // xx = coder.nullcopy(zeros(size(x)));
  //  Zero-phase filtering
  // 'ec_filtfilt:8' xx = filtfilt(coef,1,x);
  emxInit_real_T(&b, 2, &c_emlrtRTEI, true);
  emxInit_real_T(&zi, 1, &ed_emlrtRTEI, true);
  emxInit_real_T(&b2, 1, &ed_emlrtRTEI, true);
  emxInit_real_T(&a2, 1, &ed_emlrtRTEI, true);
  emxInit_real_T(&b1, 2, &i_emlrtRTEI, true);
  emxInit_int32_T(&y, 2, &fd_emlrtRTEI, true);
  emxInit_uint32_T(&nZeroLastDen, 1, &gd_emlrtRTEI, true);
  emxInit_real_T(&b_y, 2, &hd_emlrtRTEI, true);
  emxInit_boolean_T(&b_x, 1, &s_emlrtRTEI, true);
  emxInit_int32_T(&c_y, 2, &id_emlrtRTEI, true);
  emxInit_int32_T(&rows, 2, &o_emlrtRTEI, true);
  emxInit_real_T(&maxCoefNum, 1, &jd_emlrtRTEI, true);
  emxInit_int32_T(&d_y, 2, &kd_emlrtRTEI, true);
  emxInit_int32_T(&ii, 1, &ld_emlrtRTEI, true);
  emxInit_boolean_T(&c_x, 1, &p_emlrtRTEI, true);
  emxInit_real_T(&xt, 1, &t_emlrtRTEI, true);
  emxInit_int32_T(&e_y, 2, &md_emlrtRTEI, true);
  emxInit_real_T(&f_y, 1, &nd_emlrtRTEI, true);
  emxInit_real_T(&g_y, 2, &od_emlrtRTEI, true);
  emxInit_real_T(&b_b, 1, &y_emlrtRTEI, true);
  emxInit_int32_T(&cols, 2, &cb_emlrtRTEI, true);
  emxInit_real_T(&a, 1, &eb_emlrtRTEI, true);
  emxInit_real_T(&ytemp, 1, &q_emlrtRTEI, true);
  emxInit_real_T(&h_y, 1, &pd_emlrtRTEI, true);
  emxInit_real_T(&c_b, 1, &ab_emlrtRTEI, true);
  emxInit_real_T(&b_a, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&b_xt, 2, &qd_emlrtRTEI, true);
  emxInit_int8_T(&vals, 2, &nb_emlrtRTEI, true);
  emxInit_real_T(&i_y, 2, &rd_emlrtRTEI, true);
  emxInit_real_T(&d_b, 1, &ib_emlrtRTEI, true);
  emxInit_real_T(&c_a, 1, &mb_emlrtRTEI, true);
  emxInit_real_T(&rhs, 1, &sd_emlrtRTEI, true);
  emxInit_real_T(&y_d, 1, &td_emlrtRTEI, true);
  emxInit_int32_T(&y_colidx, 1, &td_emlrtRTEI, true);
  emxInit_int32_T(&y_rowidx, 1, &td_emlrtRTEI, true);
  emxInit_real_T(&expanded, 1, &ob_emlrtRTEI, true);
  emxInit_int32_T(&ridxInt, 1, &ud_emlrtRTEI, true);
  emxInit_int32_T(&j_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&b_expanded, 1, &ob_emlrtRTEI, true);
  emxInit_int32_T(&k_y, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&cidxInt, 1, &vd_emlrtRTEI, true);
  emxInit_real_T(&e_b, 1, &qb_emlrtRTEI, true);
  emxInit_int32_T(&iv, 1, &ed_emlrtRTEI, true);
  emxInit_real_T(&d_a, 1, &sb_emlrtRTEI, true);
  emxInit_int32_T(&sortedIndices, 1, &wd_emlrtRTEI, true);
  emxInit_int32_T(&iv1, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&b_rows, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&c_rows, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&c_expanded, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&t, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&l_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&convOut, 1, &jb_emlrtRTEI, true);
  emxInit_real_T(&b_convOut, 1, &jb_emlrtRTEI, true);
  emxInit_int32_T(&b_t, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&iv2, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&m_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&yc2, 2, &ed_emlrtRTEI, true);
  emxInit_real_T(&n_y, 2, &xd_emlrtRTEI, true);
  emxInit_real_T(&dv3, 1, &ed_emlrtRTEI, true);
  emxInit_real_T(&zfIIR, 1, &jb_emlrtRTEI, true);
  emxInit_int32_T(&iv3, 1, &ed_emlrtRTEI, true);
  emxInit_real_T(&d_expanded, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&o_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&p_y, 1, &yd_emlrtRTEI, true);
  emxInit_int32_T(&d_rows, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&f_b, 1, &ac_emlrtRTEI, true);
  emxInit_real_T(&g_b, 1, &ec_emlrtRTEI, true);
  emxInit_real_T(&e_a, 1, &dc_emlrtRTEI, true);
  emxInit_real_T(&f_a, 1, &fc_emlrtRTEI, true);
  emxInit_real_T(&h_b, 1, &wb_emlrtRTEI, true);
  emxInit_real_T(&c_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_int32_T(&iv4, 1, &ed_emlrtRTEI, true);
  emxInit_real_T(&g_a, 1, &yb_emlrtRTEI, true);
  emxInit_int32_T(&q_y, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&iv5, 1, &ed_emlrtRTEI, true);
  emxInit_real_T(&b_y_d, 1, &ae_emlrtRTEI, true);
  emxInit_real_T(&c_y_d, 1, &ae_emlrtRTEI, true);
  emxInit_int32_T(&b_y_colidx, 1, &ae_emlrtRTEI, true);
  emxInit_int32_T(&c_y_colidx, 1, &ae_emlrtRTEI, true);
  emxInit_int32_T(&b_y_rowidx, 1, &ae_emlrtRTEI, true);
  emxInit_int32_T(&c_y_rowidx, 1, &ae_emlrtRTEI, true);
  emxInit_real_T(&b_zfIIR, 2, &jb_emlrtRTEI, true);
  emxInit_int32_T(&e_rows, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&yc3, 2, &vc_emlrtRTEI, true);
  emxInit_real_T(&e_expanded, 1, &ob_emlrtRTEI, true);
  emxInit_int32_T(&r_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&f_expanded, 1, &ob_emlrtRTEI, true);
  emxInit_real_T(&i_b, 1, &tc_emlrtRTEI, true);
  emxInit_real_T(&s_y, 2, &be_emlrtRTEI, true);
  emxInit_int32_T(&t_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&h_a, 1, &uc_emlrtRTEI, true);
  emxInit_real_T(&d_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&j_b, 1, &gc_emlrtRTEI, true);
  emxInit_real_T(&i_a, 1, &ic_emlrtRTEI, true);
  emxInit_real_T(&d_y_d, 1, &ae_emlrtRTEI, true);
  emxInit_real_T(&g_expanded, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&iv6, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&d_y_colidx, 1, &ae_emlrtRTEI, true);
  emxInit_int32_T(&d_y_rowidx, 1, &ae_emlrtRTEI, true);
  emxInit_int32_T(&u_y, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&iv7, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&f_rows, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&outBuff, 1, &ce_emlrtRTEI, true);
  emxInit_int32_T(&g_rows, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&iv9, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&v_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&e_convOut, 1, &jb_emlrtRTEI, true);
  emxInit_real_T(&b_outBuff, 1, &ce_emlrtRTEI, true);
  emxInit_real_T(&c_zfIIR, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&f_convOut, 1, &jb_emlrtRTEI, true);
  emxInit_real_T(&h_expanded, 1, &ob_emlrtRTEI, true);
  emxInit_int32_T(&w_y, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&iv10, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&counts, 1, &pc_emlrtRTEI, true);
  emxInit_int32_T(&b_counts, 1, &pc_emlrtRTEI, true);
  emxInit_int32_T(&h_rows, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&k_b, 1, &nc_emlrtRTEI, true);
  emxInit_real_T(&i_expanded, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&j_a, 1, &oc_emlrtRTEI, true);
  emxInit_int32_T(&iv11, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&x_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&d_zfIIR, 1, &jb_emlrtRTEI, true);
  emxInit_int32_T(&i_rows, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&g_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_int32_T(&c_counts, 1, &pc_emlrtRTEI, true);
  emxInit_int32_T(&iv12, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&y_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&h_convOut, 1, &jb_emlrtRTEI, true);
  emxInit_real_T(&yc5, 2, &wc_emlrtRTEI, true);
  emxInit_int32_T(&iv13, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&j_rows, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&j_expanded, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&ab_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&bb_y, 1, &de_emlrtRTEI, true);
  emxInit_real_T(&l_b, 1, &xc_emlrtRTEI, true);
  emxInit_real_T(&k_a, 1, &yc_emlrtRTEI, true);
  emxInit_real_T(&i_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_int32_T(&iv14, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&cb_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&e_zfIIR, 2, &jb_emlrtRTEI, true);
  emxInit_int32_T(&iv15, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&k_rows, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&k_expanded, 1, &ob_emlrtRTEI, true);
  emxInit_int32_T(&db_y, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&j_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_int32_T(&iv16, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&l_rows, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&k_convOut, 1, &jb_emlrtRTEI, true);
  emxInit_real_T(&f_zfIIR, 1, &jb_emlrtRTEI, true);
  emxInit_real_T(&m_b, 1, &ad_emlrtRTEI, true);
  emxInit_real_T(&l_a, 1, &bd_emlrtRTEI, true);
  emxInit_real_T(&l_expanded, 1, &ob_emlrtRTEI, true);
  emxInit_int32_T(&eb_y, 2, &ob_emlrtRTEI, true);
  emxInit_int32_T(&iv17, 1, &ed_emlrtRTEI, true);
  emxInit_int32_T(&m_rows, 2, &ob_emlrtRTEI, true);
  emxInit_real_T(&l_convOut, 1, &jb_emlrtRTEI, true);
  emxInit_real_T(&n_b, 1, &f_emlrtRTEI, true);
  emxInit_real_T(&b_xx, 2, &r_emlrtRTEI, true);
  emxInit_real_T(&m_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&n_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&o_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&p_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&q_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&r_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&s_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&t_convOut, 2, &jb_emlrtRTEI, true);
  emxInit_real_T(&u_convOut, 1, &cd_emlrtRTEI, true);
  if ((coef->size[1] == 0) || ((x->size[0] == 0) || (x->size[1] == 0))) {
    xx->size[0] = 0;
    xx->size[1] = 0;
  } else {
    real_T nfact;
    int32_T c;
    int32_T d_x;
    int32_T idx;
    int32_T iv0;
    int32_T loop_ub;
    int32_T nc;
    int32_T ns;
    int32_T outridx;
    int32_T thism;
    int32_T vlen;
    int32_T xx_dim0;
    boolean_T issos;
    boolean_T validLaunchParams;
    if (x->size[0] == 1) {
      xx_dim0 = xx->size[0];
      iv0 = xx->size[1];
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
      xx_dirtyOnCpu = false;
      ec_filtfilt_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(xx_dim0, iv0,
        gpu_i);
      xx->size[0] = x->size[1];
      xx->size[1] = 1;
      cudaMemcpy(&i, gpu_i, 4UL, cudaMemcpyDeviceToHost);
      emxEnsureCapacity_real_T(xx, i, &b_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(xx, &gpu_xx);
      d_x = x->size[1] - 1;
      iv0 = x->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
        ec_filtfilt_kernel3<<<grid, block>>>(gpu_x, d_x, iv0, gpu_xx);
        xx_dirtyOnGpu = true;
      }
    } else {
      i = xx->size[0] * xx->size[1];
      xx->size[0] = x->size[0];
      xx->size[1] = x->size[1];
      emxEnsureCapacity_real_T(xx, i, &emlrtRTEI);
      d_x = x->size[0] * x->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
        ec_filtfilt_kernel1<<<grid, block>>>(gpu_x, d_x, gpu_xx);
        xx_dirtyOnCpu = false;
        xx_dirtyOnGpu = true;
      }
    }

    i = b->size[0] * b->size[1];
    b->size[0] = 1;
    b->size[1] = coef->size[1];
    emxEnsureCapacity_real_T(b, i, &c_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b, &gpu_b);
    iv0 = coef->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, coef);
      coef_dirtyOnCpu = false;
      ec_filtfilt_kernel4<<<grid, block>>>(gpu_coef, iv0, gpu_b);
    }

    if (coef->size[1] == 6) {
      if (coef->data[3] == 1.0) {
        coder::internal::warning();
      } else {
        coder::internal::b_warning();
      }
    }

    if ((coef->size[1] == 6) && (coef->data[3] == 1.0)) {
      issos = true;
    } else {
      issos = false;
    }

    i = zi->size[0];
    zi->size[0] = 2;
    emxEnsureCapacity_real_T(zi, i, &d_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(zi, &gpu_zi);
    if (issos) {
      boolean_T exitg1;
      if (coef_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, coef);
      }

      ec_filtfilt_kernel55<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_coef,
        gpu_b);
      if (b->size[1] == 1) {
        i = n_b->size[0];
        n_b->size[0] = 1;
        emxEnsureCapacity_real_T(n_b, i, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(n_b, &b_gpu_b);
        gpuEmxMemcpyGpuToCpu_real_T(b, &gpu_b);
        n_b->data[0] = b->data[0];
        i = b1->size[0] * b1->size[1];
        b1->size[0] = 1;
        b1->size[1] = 1;
        emxEnsureCapacity_real_T(b1, i, &i_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b1, &gpu_b1);
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, n_b);
        ec_filtfilt_kernel57<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_b,
          gpu_b1);
      } else {
        i = b1->size[0] * b1->size[1];
        b1->size[0] = 1;
        b1->size[1] = b->size[1];
        emxEnsureCapacity_real_T(b1, i, &h_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b1, &gpu_b1);
        iv0 = b->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel56<<<grid, block>>>(gpu_b, iv0, gpu_b1);
        }
      }

      nc = b1->size[1] - 1;
      for (iv0 = 0; iv0 < 2; iv0++) {
        dv1[iv0] = static_cast<uint32_T>(b1->size[iv0]);
      }

      i = b_y->size[0] * b_y->size[1];
      b_y->size[0] = static_cast<int32_T>(dv1[0]);
      b_y->size[1] = static_cast<int32_T>(dv1[1]);
      emxEnsureCapacity_real_T(b_y, i, &k_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_y, &gpu_y);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nc + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel58<<<grid, block>>>(gpu_b1, nc, gpu_y);
      }

      i = maxCoefNum->size[0];
      maxCoefNum->size[0] = b_y->size[0];
      emxEnsureCapacity_real_T(maxCoefNum, i, &n_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(maxCoefNum, &gpu_maxCoefNum);
      vlen = b_y->size[1];
      ns = b_y->size[0];
      nc = b_y->size[0] * (b_y->size[1] - 1);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns - 1) +
        1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel59<<<grid, block>>>(vlen, gpu_y, nc, ns,
          gpu_maxCoefNum);
        maxCoefNum_dirtyOnGpu = true;
      }

      i = c_x->size[0];
      c_x->size[0] = maxCoefNum->size[0];
      emxEnsureCapacity_boolean_T(c_x, i, &p_emlrtRTEI);
      gpuEmxEnsureCapacity_boolean_T(c_x, &b_gpu_x);
      iv0 = maxCoefNum->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel60<<<grid, block>>>(gpu_maxCoefNum, iv0, b_gpu_x);
        x_dirtyOnGpu = true;
      }

      xx_dim0 = 1;
      exitg1 = false;
      while ((!exitg1) && (xx_dim0 <= c_x->size[0])) {
        if (x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_boolean_T(c_x, &b_gpu_x);
        }

        x_dirtyOnGpu = false;
        if (!c_x->data[xx_dim0 - 1]) {
          issos = false;
          exitg1 = true;
        } else {
          xx_dim0++;
        }
      }

      if (issos) {
        if (maxCoefNum_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(maxCoefNum, &gpu_maxCoefNum);
        }

        val = maxCoefNum->data[0];
        i = b1->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i - 1)
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_i, &i, 4UL, cudaMemcpyHostToDevice);
          ec_filtfilt_kernel61<<<grid, block>>>(val, gpu_i, gpu_b1);
        }
      }

      i = b_x->size[0];
      b_x->size[0] = b1->size[1];
      emxEnsureCapacity_boolean_T(b_x, i, &s_emlrtRTEI);
      gpuEmxEnsureCapacity_boolean_T(b_x, &c_gpu_x);
      iv0 = b1->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel62<<<grid, block>>>(gpu_b1, iv0, c_gpu_x);
        b_x_dirtyOnGpu = true;
      }

      iv0 = b_x->size[0];
      idx = 0;
      i = ii->size[0];
      ii->size[0] = 1;
      emxEnsureCapacity_int32_T(ii, i, &x_emlrtRTEI);
      gpuEmxEnsureCapacity_int32_T(ii, &gpu_ii);
      exitg1 = false;
      while ((!exitg1) && (iv0 > 0)) {
        if (b_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_boolean_T(b_x, &c_gpu_x);
        }

        b_x_dirtyOnGpu = false;
        if (b_x->data[iv0 - 1]) {
          idx = 1;
          ii->data[0] = iv0;
          ii_dirtyOnCpu = true;
          exitg1 = true;
        } else {
          iv0--;
        }
      }

      if (idx == 0) {
        ii->size[0] = 0;
      }

      i = nZeroLastDen->size[0];
      nZeroLastDen->size[0] = ii->size[0];
      emxEnsureCapacity_uint32_T(nZeroLastDen, i, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_uint32_T(nZeroLastDen, &gpu_nZeroLastDen);
      iv0 = ii->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (ii_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_int32_T(&gpu_ii, ii);
        }

        ec_filtfilt_kernel63<<<grid, block>>>(gpu_ii, iv0, gpu_nZeroLastDen);
        nZeroLastDen_dirtyOnGpu = true;
      }

      if (nZeroLastDen->size[0] == 0) {
        i = nZeroLastDen->size[0];
        nZeroLastDen->size[0] = 1;
        emxEnsureCapacity_uint32_T(nZeroLastDen, i, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_uint32_T(nZeroLastDen, &gpu_nZeroLastDen);
        if (nZeroLastDen_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_uint32_T(nZeroLastDen, &gpu_nZeroLastDen);
        }

        nZeroLastDen->data[0] = 0U;
        nZeroLastDen_dirtyOnGpu = false;
      }

      ec_filtfilt_kernel64<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_b,
        *gpu_a0);
      i = a2->size[0];
      a2->size[0] = 3;
      emxEnsureCapacity_real_T(a2, i, &kb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(a2, &gpu_a2);
      i = b2->size[0];
      b2->size[0] = 3;
      emxEnsureCapacity_real_T(b2, i, &lb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b2, &gpu_b2);
      ec_filtfilt_kernel65<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_b,
        *gpu_a0, gpu_b2, gpu_a2);
      maxCoefNum_dirtyOnGpu = false;
      x_dirtyOnGpu = true;
      if (nZeroLastDen_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_uint32_T(nZeroLastDen, &gpu_nZeroLastDen);
      }

      nfact = std::fmax(1.0, 3.0 * (std::fmax(1.0, static_cast<real_T>
        (nZeroLastDen->data[0])) - 1.0));
      gpuEmxMemcpyGpuToCpu_real_T(b2, &gpu_b2);
      val = b2->data[0];
      ec_filtfilt_kernel66<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2, val,
        gpu_b2, *gpu_rhs);
      ec_filtfilt_kernel67<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_I);
      ec_filtfilt_kernel68<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_I);
      ec_filtfilt_kernel69<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
        *gpu_I, *gpu_A);
      cudaMemcpy(A, *gpu_A, 32UL, cudaMemcpyDeviceToHost);
      if (std::abs(A[1]) > std::abs(A[0])) {
        ns = 1;
        nc = 0;
      } else {
        ns = 0;
        nc = 1;
      }

      ec_filtfilt_kernel70<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_A, A[nc]
        / A[ns], ns, *gpu_rhs, nc, *gpu_Y);
      ec_filtfilt_kernel71<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_A,
        *gpu_rhs, ns, *gpu_Y);
      ec_filtfilt_kernel72<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_Y,
        gpu_zi);
    } else {
      i = b2->size[0];
      b2->size[0] = coef->size[1];
      emxEnsureCapacity_real_T(b2, i, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b2, &gpu_b2);
      iv0 = coef->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (coef_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, coef);
        }

        coef_dirtyOnCpu = false;
        ec_filtfilt_kernel5<<<grid, block>>>(gpu_coef, iv0, gpu_b2);
        b2_dirtyOnGpu = true;
      }

      i = a2->size[0];
      a2->size[0] = 1;
      emxEnsureCapacity_real_T(a2, i, &g_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(a2, &gpu_a2);
      a2->data[0] = 1.0;
      x_dirtyOnGpu = false;
      maxCoefNum_dirtyOnGpu = true;
      nfact = std::fmax(1.0, 3.0 * (static_cast<real_T>(coef->size[1]) - 1.0));
      if (coef->size[1] > 1) {
        i = a2->size[0];
        a2->size[0] = coef->size[1];
        emxEnsureCapacity_real_T(a2, i, &j_emlrtRTEI);
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_a2, a2);
        ec_filtfilt_kernel6<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2);
        maxCoefNum_dirtyOnGpu = false;
        x_dirtyOnGpu = true;
        loop_ub = coef->size[1] - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel7<<<grid, block>>>(loop_ub, gpu_a2);
        }

        if (coef->size[1] - 1 < 2) {
          y->size[0] = 1;
          y->size[1] = 0;
        } else {
          i = y->size[0] * y->size[1];
          y->size[0] = 1;
          y->size[1] = coef->size[1] - 2;
          emxEnsureCapacity_int32_T(y, i, &l_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(y, &b_gpu_y);
          iv0 = coef->size[1] - 3;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel8<<<grid, block>>>(iv0, b_gpu_y);
          }
        }

        if (coef->size[1] - 2 < 1) {
          c_y->size[0] = 1;
          c_y->size[1] = 0;
        } else {
          i = c_y->size[0] * c_y->size[1];
          c_y->size[0] = 1;
          c_y->size[1] = coef->size[1] - 2;
          emxEnsureCapacity_int32_T(c_y, i, &l_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(c_y, &c_gpu_y);
          iv0 = coef->size[1] - 3;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel9<<<grid, block>>>(iv0, c_gpu_y);
          }
        }

        i = rows->size[0] * rows->size[1];
        rows->size[0] = 1;
        rows->size[1] = ((coef->size[1] + y->size[1]) + c_y->size[1]) - 1;
        emxEnsureCapacity_int32_T(rows, i, &o_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(rows, &gpu_rows);
        loop_ub = coef->size[1] - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel10<<<grid, block>>>(loop_ub, gpu_rows);
        }

        loop_ub = y->size[1] - 1;
        iv0 = coef->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (coef_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, coef);
          }

          coef_dirtyOnCpu = false;
          ec_filtfilt_kernel11<<<grid, block>>>(b_gpu_y, loop_ub, iv0, gpu_rows);
        }

        loop_ub = c_y->size[1] - 1;
        iv0 = coef->size[1];
        i = y->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (coef_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, coef);
          }

          ec_filtfilt_kernel12<<<grid, block>>>(c_gpu_y, loop_ub, iv0, i,
            gpu_rows);
        }

        if (coef->size[1] - 1 < 2) {
          d_y->size[0] = 1;
          d_y->size[1] = 0;
          e_y->size[0] = 1;
          e_y->size[1] = 0;
        } else {
          i = d_y->size[0] * d_y->size[1];
          d_y->size[0] = 1;
          d_y->size[1] = coef->size[1] - 2;
          emxEnsureCapacity_int32_T(d_y, i, &l_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(d_y, &g_gpu_y);
          iv0 = coef->size[1] - 3;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel13<<<grid, block>>>(iv0, g_gpu_y);
          }

          i = e_y->size[0] * e_y->size[1];
          e_y->size[0] = 1;
          e_y->size[1] = coef->size[1] - 2;
          emxEnsureCapacity_int32_T(e_y, i, &l_emlrtRTEI);
          gpuEmxEnsureCapacity_int32_T(e_y, &h_gpu_y);
          iv0 = coef->size[1] - 3;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel14<<<grid, block>>>(iv0, h_gpu_y);
          }
        }

        b_iv[1] = coef->size[1] - 1;
        i = cols->size[0] * cols->size[1];
        cols->size[0] = 1;
        cols->size[1] = ((coef->size[1] + d_y->size[1]) + e_y->size[1]) - 1;
        emxEnsureCapacity_int32_T(cols, i, &cb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cols, &gpu_cols);
        loop_ub = coef->size[1] - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel15<<<grid, block>>>(loop_ub, gpu_cols);
        }

        loop_ub = d_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel16<<<grid, block>>>(g_gpu_y, b_iv[1], loop_ub,
            gpu_cols);
        }

        loop_ub = e_y->size[1] - 1;
        i = d_y->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel17<<<grid, block>>>(h_gpu_y, b_iv[1], loop_ub, i,
            gpu_cols);
        }

        if (coef->size[1] < 3) {
          d_x = 0;
          ns = -1;
        } else {
          d_x = 2;
          ns = coef->size[1] - 1;
        }

        b_iv[1] = coef->size[1] - 2;
        nc = coef->size[1] - 2;
        i = vals->size[0] * vals->size[1];
        vals->size[0] = 1;
        vals->size[1] = (((ns - d_x) + coef->size[1]) + coef->size[1]) - 2;
        emxEnsureCapacity_int8_T(vals, i, &nb_emlrtRTEI);
        gpuEmxEnsureCapacity_int8_T(vals, &gpu_vals);
        ec_filtfilt_kernel18<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
          gpu_vals);
        loop_ub = ns - d_x;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel19<<<grid, block>>>(gpu_a2, d_x, loop_ub, gpu_vals);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((b_iv[1]
          - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel20<<<grid, block>>>(d_x, ns, b_iv[1] - 1, gpu_vals);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nc - 1)
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel21<<<grid, block>>>(b_iv[1], d_x, ns, nc - 1,
            gpu_vals);
        }

        if (b2_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(b2, &gpu_b2);
        }

        val = b2->data[0];
        i = rhs->size[0];
        rhs->size[0] = coef->size[1] - 1;
        emxEnsureCapacity_real_T(rhs, i, &rb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(rhs, &b_gpu_rhs);
        iv0 = coef->size[1] - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel22<<<grid, block>>>(gpu_a2, val, gpu_b2, iv0,
            b_gpu_rhs);
        }

        nc = cols->size[1] - 1;
        ns = rows->size[1] - 1;
        i = ridxInt->size[0];
        ridxInt->size[0] = rows->size[1];
        emxEnsureCapacity_int32_T(ridxInt, i, &tb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(ridxInt, &gpu_ridxInt);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel23<<<grid, block>>>(gpu_rows, ns, gpu_ridxInt);
          ridxInt_dirtyOnGpu = true;
        }

        ns = cols->size[1] - 1;
        i = cidxInt->size[0];
        cidxInt->size[0] = cols->size[1];
        emxEnsureCapacity_int32_T(cidxInt, i, &tb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cidxInt, &gpu_cidxInt);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel24<<<grid, block>>>(gpu_cols, ns, gpu_cidxInt);
          cidxInt_dirtyOnGpu = true;
        }

        i = sortedIndices->size[0];
        sortedIndices->size[0] = cols->size[1];
        emxEnsureCapacity_int32_T(sortedIndices, i, &ub_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(sortedIndices, &gpu_sortedIndices);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nc + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel25<<<grid, block>>>(nc, gpu_sortedIndices);
          gpuEmxMemcpyGpuToCpu_int32_T(sortedIndices, &gpu_sortedIndices);
        }

        if (cidxInt_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_int32_T(cidxInt, &gpu_cidxInt);
        }

        cidxInt_dirtyOnGpu = false;
        if (ridxInt_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_int32_T(ridxInt, &gpu_ridxInt);
        }

        ridxInt_dirtyOnGpu = false;
        coder::internal::introsort(sortedIndices, cidxInt->size[0], cidxInt,
          ridxInt);
        b_x_dirtyOnGpu = true;
        ns = cidxInt->size[0] - 1;
        i = t->size[0];
        t->size[0] = cidxInt->size[0];
        emxEnsureCapacity_int32_T(t, i, &vb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(t, &gpu_t);
        iv0 = cidxInt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel26<<<grid, block>>>(gpu_cidxInt, iv0, gpu_t);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&gpu_sortedIndices, sortedIndices);
          b_x_dirtyOnGpu = false;
          ec_filtfilt_kernel27<<<grid, block>>>(gpu_t, gpu_sortedIndices, ns,
            gpu_cidxInt);
          cidxInt_dirtyOnGpu = true;
        }

        ns = ridxInt->size[0] - 1;
        i = b_t->size[0];
        b_t->size[0] = ridxInt->size[0];
        emxEnsureCapacity_int32_T(b_t, i, &vb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(b_t, &b_gpu_t);
        iv0 = ridxInt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel28<<<grid, block>>>(gpu_ridxInt, iv0, b_gpu_t);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_sortedIndices, sortedIndices);
          }

          b_x_dirtyOnGpu = false;
          ec_filtfilt_kernel29<<<grid, block>>>(b_gpu_t, gpu_sortedIndices, ns,
            gpu_ridxInt);
          ridxInt_dirtyOnGpu = true;
        }

        vlen = ridxInt->size[0];
        if (ridxInt_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_int32_T(ridxInt, &gpu_ridxInt);
        }

        thism = ridxInt->data[0];
        for (d_x = 0; d_x <= vlen - 2; d_x++) {
          if (thism < ridxInt->data[d_x + 1]) {
            thism = ridxInt->data[d_x + 1];
          }
        }

        if (cidxInt_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_int32_T(cidxInt, &gpu_cidxInt);
        }

        d_x = cidxInt->data[cidxInt->size[0] - 1] - 1;
        i = y_d->size[0];
        y_d->size[0] = cols->size[1];
        emxEnsureCapacity_real_T(y_d, i, &bc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(y_d, &gpu_y_d);
        i = y_colidx->size[0];
        y_colidx->size[0] = cidxInt->data[cidxInt->size[0] - 1] + 1;
        emxEnsureCapacity_int32_T(y_colidx, i, &cc_emlrtRTEI);
        y_colidx->data[0] = 1;
        i = y_rowidx->size[0];
        y_rowidx->size[0] = cols->size[1];
        emxEnsureCapacity_int32_T(y_rowidx, i, &bc_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(y_rowidx, &gpu_y_rowidx);
        i = cols->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel30<<<grid, block>>>(i, gpu_y_rowidx, gpu_y_d);
          y_d_dirtyOnGpu = true;
          y_rowidx_dirtyOnGpu = true;
        }

        ns = 0;
        for (c = 0; c <= d_x; c++) {
          while ((ns + 1 <= nc + 1) && (cidxInt->data[ns] == c + 1)) {
            if (y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
            }

            y_rowidx->data[ns] = ridxInt->data[ns];
            y_rowidx_dirtyOnGpu = false;
            ns++;
          }

          y_colidx->data[c + 1] = ns + 1;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nc + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_x_dirtyOnGpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_sortedIndices, sortedIndices);
          }

          ec_filtfilt_kernel31<<<grid, block>>>(gpu_vals, gpu_sortedIndices, nc,
            gpu_y_d);
          y_d_dirtyOnGpu = true;
        }

        idx = 1;
        ns = y_colidx->size[0];
        for (c = 0; c <= ns - 2; c++) {
          nc = y_colidx->data[c];
          y_colidx->data[c] = idx;
          while (nc < y_colidx->data[c + 1]) {
            val = 0.0;
            if (y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
            }

            y_rowidx_dirtyOnGpu = false;
            vlen = y_rowidx->data[nc - 1];
            while ((nc < y_colidx->data[c + 1]) && (y_rowidx->data[nc - 1] ==
                    vlen)) {
              if (y_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
              }

              y_d_dirtyOnGpu = false;
              val += y_d->data[nc - 1];
              nc++;
            }

            if (val != 0.0) {
              if (y_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
              }

              y_d->data[idx - 1] = val;
              y_d_dirtyOnGpu = false;
              y_rowidx->data[idx - 1] = vlen;
              idx++;
            }
          }
        }

        y_colidx->data[y_colidx->size[0] - 1] = idx;
        if (rhs->size[0] == cidxInt->data[cidxInt->size[0] - 1]) {
          cs_di *b_cxA;
          cs_din *b_N;
          cs_dis *b_S;
          if (thism < cidxInt->data[cidxInt->size[0] - 1]) {
            ns = y_colidx->data[y_colidx->size[0] - 1] - 1;
            if (ns < 1) {
              ns = 1;
            }

            i = c_y_d->size[0];
            c_y_d->size[0] = ns;
            emxEnsureCapacity_real_T(c_y_d, i, &hc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(c_y_d, &c_gpu_y_d);
            i = c_y_colidx->size[0];
            c_y_colidx->size[0] = thism + 1;
            emxEnsureCapacity_int32_T(c_y_colidx, i, &cc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(c_y_colidx, &b_gpu_y_colidx);
            i = c_y_rowidx->size[0];
            c_y_rowidx->size[0] = ns;
            emxEnsureCapacity_int32_T(c_y_rowidx, i, &hc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(c_y_rowidx, &c_gpu_y_rowidx);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns
              - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel40<<<grid, block>>>(ns, c_gpu_y_rowidx,
                c_gpu_y_d);
              c_y_d_dirtyOnGpu = true;
              c_y_rowidx_dirtyOnGpu = true;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((thism - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel41<<<grid, block>>>(thism, b_gpu_y_colidx);
            }

            nc = c_y_colidx->size[0] - 2;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nc +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel42<<<grid, block>>>(nc, b_gpu_y_colidx);
            }

            iv0 = c_y_colidx->size[0];
            ec_filtfilt_kernel43<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(iv0,
              b_gpu_y_colidx);
            b_x_dirtyOnGpu = true;
            ns = c_y_colidx->size[0];
            i = c_y_colidx->size[0];
            c_y_colidx->size[0] = ns;
            emxEnsureCapacity_int32_T(c_y_colidx, i, &hc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(c_y_colidx, &b_gpu_y_colidx);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns
              - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel44<<<grid, block>>>(ns, b_gpu_y_colidx);
            }

            nc = y_colidx->data[y_colidx->size[0] - 1];
            for (xx_dim0 = 0; xx_dim0 <= nc - 2; xx_dim0++) {
              if (b_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(c_y_colidx, &b_gpu_y_colidx);
              }

              if (y_rowidx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
              }

              c_y_colidx->data[y_rowidx->data[xx_dim0]]++;
              y_rowidx_dirtyOnGpu = false;
              b_x_dirtyOnGpu = false;
            }

            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(c_y_colidx, &b_gpu_y_colidx);
            }

            c_y_colidx->data[0] = 1;
            for (xx_dim0 = 0; xx_dim0 < thism; xx_dim0++) {
              c_y_colidx->data[xx_dim0 + 1] += c_y_colidx->data[xx_dim0];
            }

            i = b_counts->size[0];
            b_counts->size[0] = thism;
            emxEnsureCapacity_int32_T(b_counts, i, &pc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_counts, &b_gpu_counts);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((thism - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel45<<<grid, block>>>(thism, b_gpu_counts);
              b_counts_dirtyOnGpu = true;
            }

            for (c = 0; c <= d_x; c++) {
              ns = y_colidx->data[c];
              nc = y_colidx->data[c + 1];
              for (idx = 0; idx < nc - ns; idx++) {
                vlen = (ns + idx) - 1;
                if (b_counts_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(b_counts, &b_gpu_counts);
                }

                if (y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
                }

                outridx = (b_counts->data[y_rowidx->data[vlen] - 1] +
                           c_y_colidx->data[y_rowidx->data[vlen] - 1]) - 1;
                if (c_y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_y_d, &c_gpu_y_d);
                }

                if (y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
                }

                y_d_dirtyOnGpu = false;
                c_y_d->data[outridx] = y_d->data[vlen];
                c_y_d_dirtyOnGpu = false;
                if (c_y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(c_y_rowidx, &c_gpu_y_rowidx);
                }

                c_y_rowidx->data[outridx] = c + 1;
                c_y_rowidx_dirtyOnGpu = false;
                b_counts->data[y_rowidx->data[vlen] - 1]++;
                y_rowidx_dirtyOnGpu = false;
                b_counts_dirtyOnGpu = false;
              }
            }

            if (c_y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(c_y_rowidx, &c_gpu_y_rowidx);
            }

            if (c_y_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_y_d, &c_gpu_y_d);
            }

            b_cxA = makeCXSparseMatrix(c_y_colidx->data[c_y_colidx->size[0] - 1]
              - 1, thism, cidxInt->data[cidxInt->size[0] - 1], &c_y_colidx->
              data[0], &c_y_rowidx->data[0], &c_y_d->data[0]);
          } else {
            if (y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
            }

            y_rowidx_dirtyOnGpu = false;
            if (y_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
            }

            y_d_dirtyOnGpu = false;
            b_cxA = makeCXSparseMatrix(y_colidx->data[y_colidx->size[0] - 1] - 1,
              cidxInt->data[cidxInt->size[0] - 1], thism, &y_colidx->data[0],
              &y_rowidx->data[0], &y_d->data[0]);
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
            if (thism < cidxInt->data[cidxInt->size[0] - 1]) {
              ns = y_colidx->data[y_colidx->size[0] - 1] - 1;
              if (ns < 1) {
                ns = 1;
              }

              i = d_y_d->size[0];
              d_y_d->size[0] = ns;
              emxEnsureCapacity_real_T(d_y_d, i, &hc_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(d_y_d, &d_gpu_y_d);
              i = d_y_colidx->size[0];
              d_y_colidx->size[0] = thism + 1;
              emxEnsureCapacity_int32_T(d_y_colidx, i, &cc_emlrtRTEI);
              gpuEmxEnsureCapacity_int32_T(d_y_colidx, &c_gpu_y_colidx);
              i = d_y_rowidx->size[0];
              d_y_rowidx->size[0] = ns;
              emxEnsureCapacity_int32_T(d_y_rowidx, i, &hc_emlrtRTEI);
              gpuEmxEnsureCapacity_int32_T(d_y_rowidx, &d_gpu_y_rowidx);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((ns - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel47<<<grid, block>>>(ns, d_gpu_y_rowidx,
                  d_gpu_y_d);
                d_y_d_dirtyOnGpu = true;
                d_y_rowidx_dirtyOnGpu = true;
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((thism - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel48<<<grid, block>>>(thism, c_gpu_y_colidx);
              }

              nc = d_y_colidx->size[0] - 2;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nc
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel49<<<grid, block>>>(nc, c_gpu_y_colidx);
              }

              iv0 = d_y_colidx->size[0];
              ec_filtfilt_kernel50<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(iv0,
                c_gpu_y_colidx);
              b_x_dirtyOnGpu = true;
              ns = d_y_colidx->size[0];
              i = d_y_colidx->size[0];
              d_y_colidx->size[0] = ns;
              emxEnsureCapacity_int32_T(d_y_colidx, i, &hc_emlrtRTEI);
              gpuEmxEnsureCapacity_int32_T(d_y_colidx, &c_gpu_y_colidx);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((ns - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel51<<<grid, block>>>(ns, c_gpu_y_colidx);
              }

              nc = y_colidx->data[y_colidx->size[0] - 1];
              for (xx_dim0 = 0; xx_dim0 <= nc - 2; xx_dim0++) {
                if (b_x_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(d_y_colidx, &c_gpu_y_colidx);
                }

                if (y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
                }

                d_y_colidx->data[y_rowidx->data[xx_dim0]]++;
                y_rowidx_dirtyOnGpu = false;
                b_x_dirtyOnGpu = false;
              }

              if (b_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(d_y_colidx, &c_gpu_y_colidx);
              }

              d_y_colidx->data[0] = 1;
              for (xx_dim0 = 0; xx_dim0 < thism; xx_dim0++) {
                d_y_colidx->data[xx_dim0 + 1] += d_y_colidx->data[xx_dim0];
              }

              i = c_counts->size[0];
              c_counts->size[0] = thism;
              emxEnsureCapacity_int32_T(c_counts, i, &pc_emlrtRTEI);
              gpuEmxEnsureCapacity_int32_T(c_counts, &c_gpu_counts);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((thism - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel52<<<grid, block>>>(thism, c_gpu_counts);
                c_counts_dirtyOnGpu = true;
              }

              for (c = 0; c <= d_x; c++) {
                ns = y_colidx->data[c];
                nc = y_colidx->data[c + 1];
                for (idx = 0; idx < nc - ns; idx++) {
                  vlen = (ns + idx) - 1;
                  if (c_counts_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_int32_T(c_counts, &c_gpu_counts);
                  }

                  if (y_rowidx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
                  }

                  outridx = (c_counts->data[y_rowidx->data[vlen] - 1] +
                             d_y_colidx->data[y_rowidx->data[vlen] - 1]) - 1;
                  if (d_y_d_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(d_y_d, &d_gpu_y_d);
                  }

                  if (y_d_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
                  }

                  y_d_dirtyOnGpu = false;
                  d_y_d->data[outridx] = y_d->data[vlen];
                  d_y_d_dirtyOnGpu = false;
                  if (d_y_rowidx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_int32_T(d_y_rowidx, &d_gpu_y_rowidx);
                  }

                  d_y_rowidx->data[outridx] = c + 1;
                  d_y_rowidx_dirtyOnGpu = false;
                  c_counts->data[y_rowidx->data[vlen] - 1]++;
                  y_rowidx_dirtyOnGpu = false;
                  c_counts_dirtyOnGpu = false;
                }
              }

              if (d_y_rowidx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(d_y_rowidx, &d_gpu_y_rowidx);
              }

              if (d_y_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(d_y_d, &d_gpu_y_d);
              }

              c_cxA = makeCXSparseMatrix(d_y_colidx->data[d_y_colidx->size[0] -
                1] - 1, thism, cidxInt->data[cidxInt->size[0] - 1],
                &d_y_colidx->data[0], &d_y_rowidx->data[0], &d_y_d->data[0]);
            } else {
              if (y_rowidx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
              }

              if (y_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
              }

              c_cxA = makeCXSparseMatrix(y_colidx->data[y_colidx->size[0] - 1] -
                1, cidxInt->data[cidxInt->size[0] - 1], thism, &y_colidx->data[0],
                &y_rowidx->data[0], &y_d->data[0]);
            }

            c_S = cs_di_sqr(2, c_cxA, 1);
            c_N = cs_di_qr(c_cxA, c_S);
            cs_di_spfree(c_cxA);
            qr_rank_di(c_N, &val);
            i = zi->size[0];
            zi->size[0] = cidxInt->data[cidxInt->size[0] - 1];
            emxEnsureCapacity_real_T(zi, i, &kc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(zi, &gpu_zi);
            if (rhs->size[0] < cidxInt->data[cidxInt->size[0] - 1]) {
              i = b_outBuff->size[0];
              b_outBuff->size[0] = cidxInt->data[cidxInt->size[0] - 1];
              emxEnsureCapacity_real_T(b_outBuff, i, &mc_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(b_outBuff, &b_gpu_outBuff);
            } else {
              i = b_outBuff->size[0];
              b_outBuff->size[0] = rhs->size[0];
              emxEnsureCapacity_real_T(b_outBuff, i, &lc_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(b_outBuff, &b_gpu_outBuff);
            }

            nc = rhs->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nc
              - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel53<<<grid, block>>>(b_gpu_rhs, nc, b_gpu_outBuff);
              gpuEmxMemcpyGpuToCpu_real_T(b_outBuff, &b_gpu_outBuff);
            }

            solve_from_qr_di(c_N, c_S, (double *)&b_outBuff->data[0], rhs->size
                             [0], cidxInt->data[cidxInt->size[0] - 1]);
            i = cidxInt->data[cidxInt->size[0] - 1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_outBuff, b_outBuff);
              cudaMemcpy(gpu_i, &i, 4UL, cudaMemcpyHostToDevice);
              ec_filtfilt_kernel54<<<grid, block>>>(b_gpu_outBuff, gpu_i, gpu_zi);
            }

            cs_di_sfree(c_S);
            cs_di_nfree(c_N);
          } else {
            i = zi->size[0];
            zi->size[0] = rhs->size[0];
            emxEnsureCapacity_real_T(zi, i, &jc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(zi, &gpu_zi);
            iv0 = rhs->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel46<<<grid, block>>>(b_gpu_rhs, iv0, gpu_zi);
              gpuEmxMemcpyGpuToCpu_real_T(zi, &gpu_zi);
            }

            solve_from_lu_di(b_N, b_S, (double *)&zi->data[0], rhs->size[0]);
            zi_dirtyOnCpu = true;
            cs_di_sfree(b_S);
            cs_di_nfree(b_N);
          }
        } else {
          cs_di *cxA;
          cs_din *N;
          cs_dis *S;
          if (thism < cidxInt->data[cidxInt->size[0] - 1]) {
            ns = y_colidx->data[y_colidx->size[0] - 1] - 1;
            if (ns < 1) {
              ns = 1;
            }

            i = b_y_d->size[0];
            b_y_d->size[0] = ns;
            emxEnsureCapacity_real_T(b_y_d, i, &hc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_y_d, &b_gpu_y_d);
            i = b_y_colidx->size[0];
            b_y_colidx->size[0] = thism + 1;
            emxEnsureCapacity_int32_T(b_y_colidx, i, &cc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_y_colidx, &gpu_y_colidx);
            i = b_y_rowidx->size[0];
            b_y_rowidx->size[0] = ns;
            emxEnsureCapacity_int32_T(b_y_rowidx, i, &hc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_y_rowidx, &b_gpu_y_rowidx);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns
              - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel32<<<grid, block>>>(ns, b_gpu_y_rowidx,
                b_gpu_y_d);
              b_y_d_dirtyOnGpu = true;
              b_y_rowidx_dirtyOnGpu = true;
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((thism - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel33<<<grid, block>>>(thism, gpu_y_colidx);
            }

            nc = b_y_colidx->size[0] - 2;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nc +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel34<<<grid, block>>>(nc, gpu_y_colidx);
            }

            iv0 = b_y_colidx->size[0];
            ec_filtfilt_kernel35<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(iv0,
              gpu_y_colidx);
            b_x_dirtyOnGpu = true;
            ns = b_y_colidx->size[0];
            i = b_y_colidx->size[0];
            b_y_colidx->size[0] = ns;
            emxEnsureCapacity_int32_T(b_y_colidx, i, &hc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_y_colidx, &gpu_y_colidx);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns
              - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel36<<<grid, block>>>(ns, gpu_y_colidx);
            }

            nc = y_colidx->data[y_colidx->size[0] - 1];
            for (xx_dim0 = 0; xx_dim0 <= nc - 2; xx_dim0++) {
              if (b_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_y_colidx, &gpu_y_colidx);
              }

              if (y_rowidx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
              }

              b_y_colidx->data[y_rowidx->data[xx_dim0]]++;
              y_rowidx_dirtyOnGpu = false;
              b_x_dirtyOnGpu = false;
            }

            if (b_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(b_y_colidx, &gpu_y_colidx);
            }

            b_y_colidx->data[0] = 1;
            for (xx_dim0 = 0; xx_dim0 < thism; xx_dim0++) {
              b_y_colidx->data[xx_dim0 + 1] += b_y_colidx->data[xx_dim0];
            }

            i = counts->size[0];
            counts->size[0] = thism;
            emxEnsureCapacity_int32_T(counts, i, &pc_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(counts, &gpu_counts);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((thism - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel37<<<grid, block>>>(thism, gpu_counts);
              counts_dirtyOnGpu = true;
            }

            for (c = 0; c <= d_x; c++) {
              ns = y_colidx->data[c];
              nc = y_colidx->data[c + 1];
              for (idx = 0; idx < nc - ns; idx++) {
                vlen = (ns + idx) - 1;
                if (counts_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(counts, &gpu_counts);
                }

                if (y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
                }

                outridx = (counts->data[y_rowidx->data[vlen] - 1] +
                           b_y_colidx->data[y_rowidx->data[vlen] - 1]) - 1;
                if (b_y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_y_d, &b_gpu_y_d);
                }

                if (y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
                }

                y_d_dirtyOnGpu = false;
                b_y_d->data[outridx] = y_d->data[vlen];
                b_y_d_dirtyOnGpu = false;
                if (b_y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(b_y_rowidx, &b_gpu_y_rowidx);
                }

                b_y_rowidx->data[outridx] = c + 1;
                b_y_rowidx_dirtyOnGpu = false;
                counts->data[y_rowidx->data[vlen] - 1]++;
                y_rowidx_dirtyOnGpu = false;
                counts_dirtyOnGpu = false;
              }
            }

            if (b_y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(b_y_rowidx, &b_gpu_y_rowidx);
            }

            if (b_y_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_y_d, &b_gpu_y_d);
            }

            cxA = makeCXSparseMatrix(b_y_colidx->data[b_y_colidx->size[0] - 1] -
              1, thism, cidxInt->data[cidxInt->size[0] - 1], &b_y_colidx->data[0],
              &b_y_rowidx->data[0], &b_y_d->data[0]);
          } else {
            if (y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
            }

            if (y_d_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
            }

            cxA = makeCXSparseMatrix(y_colidx->data[y_colidx->size[0] - 1] - 1,
              cidxInt->data[cidxInt->size[0] - 1], thism, &y_colidx->data[0],
              &y_rowidx->data[0], &y_d->data[0]);
          }

          S = cs_di_sqr(2, cxA, 1);
          N = cs_di_qr(cxA, S);
          cs_di_spfree(cxA);
          ns = qr_rank_di(N, &val);
          if (thism > cidxInt->data[cidxInt->size[0] - 1]) {
            thism = cidxInt->data[cidxInt->size[0] - 1];
          }

          if (ns < thism) {
            char_T str[14];
            fb_y = nullptr;
            m = emlrtCreateCharArray(2, &iv8[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 6, m, &rfmt[0]);
            emlrtAssign(&fb_y, m);
            gb_y = nullptr;
            m = emlrtCreateDoubleScalar(val);
            emlrtAssign(&gb_y, m);
            emlrt_marshallIn(b_sprintf(fb_y, gb_y, &c_emlrtMCI),
                             "<output of sprintf>", str);
            coder::internal::warning(ns, str);
          }

          i = zi->size[0];
          zi->size[0] = cidxInt->data[cidxInt->size[0] - 1];
          emxEnsureCapacity_real_T(zi, i, &kc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(zi, &gpu_zi);
          if (rhs->size[0] < cidxInt->data[cidxInt->size[0] - 1]) {
            i = outBuff->size[0];
            outBuff->size[0] = cidxInt->data[cidxInt->size[0] - 1];
            emxEnsureCapacity_real_T(outBuff, i, &mc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(outBuff, &gpu_outBuff);
          } else {
            i = outBuff->size[0];
            outBuff->size[0] = rhs->size[0];
            emxEnsureCapacity_real_T(outBuff, i, &lc_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(outBuff, &gpu_outBuff);
          }

          nc = rhs->size[0];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((nc -
            1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel38<<<grid, block>>>(b_gpu_rhs, nc, gpu_outBuff);
            gpuEmxMemcpyGpuToCpu_real_T(outBuff, &gpu_outBuff);
          }

          solve_from_qr_di(N, S, (double *)&outBuff->data[0], rhs->size[0],
                           cidxInt->data[cidxInt->size[0] - 1]);
          i = cidxInt->data[cidxInt->size[0] - 1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
            &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_outBuff, outBuff);
            cudaMemcpy(gpu_i, &i, 4UL, cudaMemcpyHostToDevice);
            ec_filtfilt_kernel39<<<grid, block>>>(gpu_outBuff, gpu_i, gpu_zi);
          }

          cs_di_sfree(S);
          cs_di_nfree(N);
        }
      } else {
        zi->size[0] = 0;
      }
    }

    if (xx->size[1] == 1) {
      if (xx->size[0] < 10000) {
        int32_T b_na;
        int32_T na;
        int32_T nb;
        uint32_T OH;
        uint32_T u;
        uint32_T window_idx_0;
        i = static_cast<int32_T>(nfact + 1.0) - 1;
        c = static_cast<int32_T>(-((0.0 - nfact) - -1.0));
        na = a2->size[0] - 2;
        thism = b2->size[0] - 1;
        b_na = a2->size[0] - 2;
        nb = b2->size[0] - 1;
        if (maxCoefNum_dirtyOnGpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_a2, a2);
        }

        ec_filtfilt_kernel238<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
          gpu_a1, b_gpu_a1);
        if (xx_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
        }

        xx_dirtyOnCpu = false;
        ec_filtfilt_kernel239<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_xx,
          gpu_d1);
        if (xx_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(xx, &gpu_xx);
        }

        xx_dirtyOnGpu = false;
        val = 2.0 * xx->data[xx->size[0] - 1];
        outridx = xx->size[0];
        xx_dim0 = ytemp->size[0];
        ytemp->size[0] = (static_cast<int32_T>(nfact + 1.0) + xx->size[0]) +
          static_cast<int32_T>(-((0.0 - nfact) - -1.0));
        emxEnsureCapacity_real_T(ytemp, xx_dim0, &q_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(ytemp, &gpu_ytemp);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(nfact + 1.0) - 2) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_i, &i, 4UL, cudaMemcpyHostToDevice);
          ec_filtfilt_kernel240<<<grid, block>>>(gpu_xx, gpu_i, gpu_d1,
            static_cast<int32_T>(nfact + 1.0) - 2, gpu_ytemp);
          ytemp_dirtyOnGpu = true;
        }

        ns = xx->size[0];
        for (xx_dim0 = 0; xx_dim0 < ns; xx_dim0++) {
          if (ytemp_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(ytemp, &gpu_ytemp);
          }

          ytemp->data[(xx_dim0 + static_cast<int32_T>(nfact + 1.0)) - 1] =
            xx->data[xx_dim0];
          ytemp_dirtyOnGpu = false;
          ytemp_dirtyOnCpu = true;
        }

        for (xx_dim0 = 0; xx_dim0 <= c; xx_dim0++) {
          if (ytemp_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(ytemp, &gpu_ytemp);
          }

          ytemp->data[((xx_dim0 + static_cast<int32_T>(nfact + 1.0)) + xx->size
                       [0]) - 1] = val - xx->data[(outridx - xx_dim0) - 2];
          xx_dirtyOnCpu = true;
          ytemp_dirtyOnGpu = false;
          ytemp_dirtyOnCpu = true;
        }

        if (ytemp_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(ytemp, &gpu_ytemp);
        }

        val = ytemp->data[0];
        xx_dim0 = h_y->size[0];
        h_y->size[0] = zi->size[0];
        emxEnsureCapacity_real_T(h_y, xx_dim0, &w_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_y, &f_gpu_y);
        i = zi->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (zi_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, zi);
          }

          zi_dirtyOnCpu = false;
          ec_filtfilt_kernel241<<<grid, block>>>(val, gpu_zi, i, f_gpu_y);
        }

        xx_dim0 = c_b->size[0];
        c_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(c_b, xx_dim0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_b, &d_gpu_b);
        i = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel242<<<grid, block>>>(gpu_b2, i, d_gpu_b);
          b_b_dirtyOnGpu = true;
        }

        xx_dim0 = b_a->size[0];
        b_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(b_a, xx_dim0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_a, &b_gpu_a);
        i = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel243<<<grid, block>>>(gpu_a2, i, b_gpu_a);
          b_a_dirtyOnGpu = true;
        }

        if (x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(a2, &gpu_a2);
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(thism
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel244<<<grid, block>>>(b_gpu_a1, thism, d_gpu_b);
            b_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel245<<<grid, block>>>(b_gpu_a1, na, b_gpu_a);
          }

          ec_filtfilt_kernel246<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_a);
          b_a_dirtyOnGpu = true;
        }

        if (b_a->size[0] > c_b->size[0]) {
          ns = b_a->size[0] - c_b->size[0];
          xx_dim0 = c_b->size[0];
          outridx = c_b->size[0];
          c_b->size[0] += ns;
          emxEnsureCapacity_real_T(c_b, outridx, &jb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_b, &d_gpu_b);
          if (ns - 1 >= 0) {
            if (b_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_b, &d_gpu_b);
            }

            std::memset(&c_b->data[xx_dim0], 0, static_cast<uint32_T>(ns) *
                        sizeof(real_T));
            b_b_dirtyOnCpu = true;
          }
        }

        window_idx_0 = static_cast<uint32_T>(c_b->size[0]);
        OH = (static_cast<uint32_T>(ytemp->size[0]) + static_cast<uint32_T>
              (c_b->size[0])) - 1U;
        d_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = c_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(c_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(c_b->
          size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (c_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + c_b->size[0];
        }

        xx_dim0 = b_expanded->size[0];
        b_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(b_expanded, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_expanded, &b_gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((
          static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) - 2) +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel247<<<grid, block>>>(static_cast<int32_T>(u),
            window_idx_0, b_gpu_expanded);
        }

        ns = ytemp->size[0];
        xx_dim0 = k_y->size[0] * k_y->size[1];
        k_y->size[0] = 1;
        k_y->size[1] = ytemp->size[0];
        emxEnsureCapacity_int32_T(k_y, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(k_y, &k_gpu_y);
        k_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          k_y->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = iv1->size[0];
        iv1->size[0] = k_y->size[1];
        emxEnsureCapacity_int32_T(iv1, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv1, &gpu_iv1);
        i = k_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&k_gpu_y, k_y);
          ec_filtfilt_kernel248<<<grid, block>>>(nc, k_gpu_y, i, gpu_iv1);
        }

        i = ytemp->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (ytemp_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_ytemp, ytemp);
          }

          ytemp_dirtyOnCpu = false;
          ec_filtfilt_kernel249<<<grid, block>>>(gpu_ytemp, gpu_iv1, i,
            b_gpu_expanded);
        }

        xx_dim0 = c_rows->size[0] * c_rows->size[1];
        c_rows->size[0] = 1;
        c_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(c_rows, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(c_rows, &c_gpu_rows);
        c_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          c_rows->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = b_convOut->size[0];
        b_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(b_convOut, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_convOut, &b_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(d_x) - 1.0)) / static_cast<real_T>(d_x))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(d_x), 1U, 1U);
        i = c_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_rows, c_rows);
          if (b_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_b, c_b);
          }

          ec_filtfilt_kernel250<<<grid, block>>>(b_gpu_expanded, c_gpu_rows,
            d_gpu_b, static_cast<int32_T>(u), i, b_gpu_convOut);
          b_convOut_dirtyOnGpu = true;
        }

        if (h_y->size[0] != 0) {
          if (h_y->size[0] == 1) {
            ec_filtfilt_kernel252<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (f_gpu_y, b_gpu_convOut);
            b_convOut_dirtyOnGpu = true;
          } else {
            ns = h_y->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel251<<<grid, block>>>(f_gpu_y, ns, b_gpu_convOut);
              b_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = ytemp->size[0] + b_a->size[0];
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          outridx = static_cast<int32_T>(std::fmin(static_cast<real_T>(d_x) +
            1.0, static_cast<real_T>(b_a->size[0])));
          for (nc = 0; nc <= outridx - 2; nc++) {
            if (b_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_convOut, &b_gpu_convOut);
            }

            if (b_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_a, &b_gpu_a);
            }

            b_a_dirtyOnGpu = false;
            b_convOut->data[d_x] -= b_convOut->data[(d_x - nc) - 1] * b_a->
              data[nc + 1];
            b_convOut_dirtyOnGpu = false;
            b_convOut_dirtyOnCpu = true;
          }
        }

        xx_dim0 = dv3->size[0];
        dv3->size[0] = ytemp->size[0];
        emxEnsureCapacity_real_T(dv3, xx_dim0, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(dv3, &gpu_dv3);
        i = ytemp->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_convOut, b_convOut);
          }

          b_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel253<<<grid, block>>>(b_gpu_convOut, i, gpu_dv3);
          dv3_dirtyOnGpu = true;
        }

        zfSize[0] = static_cast<uint32_T>(ytemp->size[0]);
        xx_dim0 = ytemp->size[0] - 1;
        outridx = ytemp->size[0];
        ytemp->size[0] = static_cast<int32_T>(zfSize[0]);
        emxEnsureCapacity_real_T(ytemp, outridx, &xb_emlrtRTEI);
        if (!ytemp_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(ytemp, &gpu_ytemp);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(xx_dim0
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_convOut, b_convOut);
          }

          b_convOut_dirtyOnCpu = false;
          if (ytemp_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_ytemp, ytemp);
          }

          ec_filtfilt_kernel254<<<grid, block>>>(b_gpu_convOut, xx_dim0,
            gpu_ytemp);
        }

        if (dv3_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(dv3, &gpu_dv3);
        }

        val = dv3->data[static_cast<int32_T>(zfSize[0]) - 1];
        xx_dim0 = p_y->size[0];
        p_y->size[0] = zi->size[0];
        emxEnsureCapacity_real_T(p_y, xx_dim0, &w_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(p_y, &n_gpu_y);
        i = zi->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (zi_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, zi);
          }

          ec_filtfilt_kernel255<<<grid, block>>>(val, gpu_zi, i, n_gpu_y);
        }

        xx_dim0 = g_b->size[0];
        g_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(g_b, xx_dim0, &ec_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_b, &h_gpu_b);
        i = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel256<<<grid, block>>>(gpu_b2, i, h_gpu_b);
          f_b_dirtyOnGpu = true;
        }

        xx_dim0 = f_a->size[0];
        f_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(f_a, xx_dim0, &fc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_a, &f_gpu_a);
        i = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel257<<<grid, block>>>(gpu_a2, i, f_gpu_a);
          d_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel258<<<grid, block>>>(gpu_a1, nb, h_gpu_b);
            f_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel259<<<grid, block>>>(gpu_a1, b_na, f_gpu_a);
          }

          ec_filtfilt_kernel260<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(f_gpu_a);
          d_a_dirtyOnGpu = true;
        }

        if (f_a->size[0] > g_b->size[0]) {
          ns = f_a->size[0] - g_b->size[0];
          xx_dim0 = g_b->size[0];
          outridx = g_b->size[0];
          g_b->size[0] += ns;
          emxEnsureCapacity_real_T(g_b, outridx, &jb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(g_b, &h_gpu_b);
          if (ns - 1 >= 0) {
            if (f_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_b, &h_gpu_b);
            }

            std::memset(&g_b->data[xx_dim0], 0, static_cast<uint32_T>(ns) *
                        sizeof(real_T));
            f_b_dirtyOnCpu = true;
          }
        }

        window_idx_0 = static_cast<uint32_T>(g_b->size[0]);
        OH = (zfSize[0] + static_cast<uint32_T>(g_b->size[0])) - 1U;
        d_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = g_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(g_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(g_b->
          size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (g_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + g_b->size[0];
        }

        xx_dim0 = e_expanded->size[0];
        e_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(e_expanded, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_expanded, &f_gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((
          static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) - 2) +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel261<<<grid, block>>>(static_cast<int32_T>(u),
            window_idx_0, f_gpu_expanded);
        }

        ns = ytemp->size[0];
        xx_dim0 = r_y->size[0] * r_y->size[1];
        r_y->size[0] = 1;
        r_y->size[1] = static_cast<int32_T>(zfSize[0]);
        emxEnsureCapacity_int32_T(r_y, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(r_y, &t_gpu_y);
        r_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          r_y->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = iv6->size[0];
        iv6->size[0] = r_y->size[1];
        emxEnsureCapacity_int32_T(iv6, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv6, &gpu_iv6);
        i = r_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&t_gpu_y, r_y);
          ec_filtfilt_kernel262<<<grid, block>>>(nc, t_gpu_y, i, gpu_iv6);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(zfSize[0]) - 1) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_convOut, b_convOut);
          }

          ec_filtfilt_kernel263<<<grid, block>>>(b_gpu_convOut, static_cast<
            int32_T>(zfSize[0]) - 1, gpu_iv6, static_cast<int32_T>(zfSize[0]) -
            1, f_gpu_expanded);
        }

        xx_dim0 = f_rows->size[0] * f_rows->size[1];
        f_rows->size[0] = 1;
        f_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(f_rows, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(f_rows, &g_gpu_rows);
        f_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          f_rows->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = e_convOut->size[0];
        e_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(e_convOut, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_convOut, &g_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(d_x) - 1.0)) / static_cast<real_T>(d_x))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(d_x), 1U, 1U);
        i = g_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&g_gpu_rows, f_rows);
          if (f_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_b, g_b);
          }

          ec_filtfilt_kernel264<<<grid, block>>>(f_gpu_expanded, g_gpu_rows,
            h_gpu_b, static_cast<int32_T>(u), i, g_gpu_convOut);
          f_convOut_dirtyOnGpu = true;
        }

        if (p_y->size[0] != 0) {
          if (p_y->size[0] == 1) {
            ec_filtfilt_kernel266<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (n_gpu_y, g_gpu_convOut);
            f_convOut_dirtyOnGpu = true;
          } else {
            ns = p_y->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel265<<<grid, block>>>(n_gpu_y, ns, g_gpu_convOut);
              f_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = static_cast<int32_T>(zfSize[0]) + f_a->size[0];
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          outridx = static_cast<int32_T>(std::fmin(static_cast<real_T>(d_x) +
            1.0, static_cast<real_T>(f_a->size[0])));
          for (nc = 0; nc <= outridx - 2; nc++) {
            if (f_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_convOut, &g_gpu_convOut);
            }

            if (d_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_a, &f_gpu_a);
            }

            d_a_dirtyOnGpu = false;
            e_convOut->data[d_x] -= e_convOut->data[(d_x - nc) - 1] * f_a->
              data[nc + 1];
            f_convOut_dirtyOnGpu = false;
            f_convOut_dirtyOnCpu = true;
          }
        }

        val = static_cast<real_T>(zfSize[0]) - nfact;
        if (nfact + 1.0 > val) {
          ns = 1;
          outridx = 1;
          vlen = 0;
        } else {
          ns = static_cast<int32_T>(val);
          outridx = -1;
          vlen = static_cast<int32_T>(nfact + 1.0);
        }

        xx_dim0 = xx->size[0] * xx->size[1];
        xx->size[0] = div_s32(vlen - ns, outridx) + 1;
        xx->size[1] = 1;
        emxEnsureCapacity_real_T(xx, xx_dim0, &sc_emlrtRTEI);
        if (!xx_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(xx, &gpu_xx);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((vlen -
          ns) / outridx + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (f_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_convOut, e_convOut);
          }

          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          ec_filtfilt_kernel267<<<grid, block>>>(g_gpu_convOut, outridx, ns,
            vlen, gpu_xx);
          xx_dirtyOnCpu = false;
          xx_dirtyOnGpu = true;
        }
      } else {
        int32_T b_na;
        int32_T b_nb;
        int32_T c_na;
        int32_T c_nb;
        int32_T d_na;
        int32_T d_nb;
        int32_T e_na;
        int32_T na;
        int32_T nb;
        uint32_T OH;
        uint32_T u;
        uint32_T window_idx_0;
        i = static_cast<int32_T>(nfact + 1.0) - 1;
        na = a2->size[0] - 2;
        thism = b2->size[0] - 1;
        b_na = a2->size[0] - 2;
        nb = b2->size[0] - 1;
        c_na = a2->size[0] - 2;
        b_nb = b2->size[0] - 1;
        d_na = a2->size[0] - 2;
        c_nb = b2->size[0] - 1;
        e_na = a2->size[0] - 2;
        d_nb = b2->size[0] - 1;
        if (maxCoefNum_dirtyOnGpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_a2, a2);
        }

        ec_filtfilt_kernel170<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
          c_gpu_a1, d_gpu_a1, e_gpu_a1, gpu_a1, b_gpu_a1);
        if (xx_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(xx, &gpu_xx);
        }

        val = 2.0 * xx->data[0];
        xx_dim0 = xt->size[0];
        xt->size[0] = static_cast<int32_T>(nfact + 1.0) - 1;
        emxEnsureCapacity_real_T(xt, xx_dim0, &t_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(xt, &gpu_xt);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(nfact + 1.0) - 2) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_d1, &val, 8UL, cudaMemcpyHostToDevice);
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          cudaMemcpy(gpu_i, &i, 4UL, cudaMemcpyHostToDevice);
          ec_filtfilt_kernel171<<<grid, block>>>(gpu_d1, gpu_xx, gpu_i, gpu_xt);
          gpuEmxMemcpyGpuToCpu_real_T(xt, &gpu_xt);
        }

        val = xt->data[0];
        xx_dim0 = f_y->size[0];
        f_y->size[0] = zi->size[0];
        emxEnsureCapacity_real_T(f_y, xx_dim0, &w_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_y, &e_gpu_y);
        i = zi->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (zi_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, zi);
          }

          zi_dirtyOnCpu = false;
          ec_filtfilt_kernel172<<<grid, block>>>(val, gpu_zi, i, e_gpu_y);
        }

        xx_dim0 = b_b->size[0];
        b_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(b_b, xx_dim0, &y_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_b, &c_gpu_b);
        i = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel173<<<grid, block>>>(gpu_b2, i, c_gpu_b);
          b_dirtyOnGpu = true;
        }

        xx_dim0 = a->size[0];
        a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(a, xx_dim0, &eb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(a, &gpu_a);
        i = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel174<<<grid, block>>>(gpu_a2, i, gpu_a);
          a_dirtyOnGpu = true;
        }

        if (x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(a2, &gpu_a2);
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(thism
            + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel175<<<grid, block>>>(b_gpu_a1, thism, c_gpu_b);
            b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel176<<<grid, block>>>(b_gpu_a1, na, gpu_a);
          }

          ec_filtfilt_kernel177<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a);
          a_dirtyOnGpu = true;
        }

        if (a->size[0] > b_b->size[0]) {
          loop_ub = a->size[0] - b_b->size[0];
          xx_dim0 = b_b->size[0];
          outridx = b_b->size[0];
          b_b->size[0] += loop_ub;
          emxEnsureCapacity_real_T(b_b, outridx, &jb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_b, &c_gpu_b);
          if (loop_ub - 1 >= 0) {
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_b, &c_gpu_b);
            }

            std::memset(&b_b->data[xx_dim0], 0, static_cast<uint32_T>(loop_ub) *
                        sizeof(real_T));
            b_dirtyOnCpu = true;
          }
        }

        na = b_b->size[0] - 1;
        window_idx_0 = static_cast<uint32_T>(b_b->size[0]);
        OH = (static_cast<uint32_T>(xt->size[0]) + static_cast<uint32_T>
              (b_b->size[0])) - 1U;
        d_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = b_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(b_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(b_b->
          size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (b_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + b_b->size[0];
        }

        xx_dim0 = expanded->size[0];
        expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(expanded, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(expanded, &gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((
          static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) - 2) +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel178<<<grid, block>>>(static_cast<int32_T>(u),
            window_idx_0, gpu_expanded);
        }

        ns = xt->size[0];
        xx_dim0 = j_y->size[0] * j_y->size[1];
        j_y->size[0] = 1;
        j_y->size[1] = xt->size[0];
        emxEnsureCapacity_int32_T(j_y, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(j_y, &j_gpu_y);
        j_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          j_y->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = iv->size[0];
        iv->size[0] = j_y->size[1];
        emxEnsureCapacity_int32_T(iv, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv, &gpu_iv);
        i = j_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&j_gpu_y, j_y);
          ec_filtfilt_kernel179<<<grid, block>>>(nc, j_gpu_y, i, gpu_iv);
        }

        iv0 = xt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel180<<<grid, block>>>(gpu_xt, gpu_iv, iv0,
            gpu_expanded);
        }

        xx_dim0 = b_rows->size[0] * b_rows->size[1];
        b_rows->size[0] = 1;
        b_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(b_rows, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(b_rows, &b_gpu_rows);
        b_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          b_rows->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = convOut->size[0];
        convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(convOut, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(convOut, &gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(d_x) - 1.0)) / static_cast<real_T>(d_x))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(d_x), 1U, 1U);
        i = b_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_rows, b_rows);
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, b_b);
          }

          ec_filtfilt_kernel181<<<grid, block>>>(gpu_expanded, b_gpu_rows,
            c_gpu_b, static_cast<int32_T>(u), i, gpu_convOut);
          convOut_dirtyOnGpu = true;
        }

        if (f_y->size[0] != 0) {
          if (f_y->size[0] == 1) {
            ec_filtfilt_kernel183<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (e_gpu_y, gpu_convOut);
            convOut_dirtyOnGpu = true;
          } else {
            ns = f_y->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel182<<<grid, block>>>(e_gpu_y, ns, gpu_convOut);
              convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = xt->size[0] + a->size[0];
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          outridx = static_cast<int32_T>(std::fmin(static_cast<real_T>(d_x) +
            1.0, static_cast<real_T>(a->size[0])));
          for (nc = 0; nc <= outridx - 2; nc++) {
            if (convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(convOut, &gpu_convOut);
            }

            if (a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(a, &gpu_a);
            }

            a_dirtyOnGpu = false;
            convOut->data[d_x] -= convOut->data[(d_x - nc) - 1] * a->data[nc + 1];
            convOut_dirtyOnGpu = false;
            convOut_dirtyOnCpu = true;
          }
        }

        if (static_cast<uint32_T>(xt->size[0]) + 1U > static_cast<uint32_T>
            (convOut->size[0])) {
          ns = 0;
          outridx = -1;
        } else {
          ns = xt->size[0];
          outridx = convOut->size[0] - 1;
        }

        xx_dim0 = zfIIR->size[0];
        zfIIR->size[0] = (outridx - ns) + 1;
        emxEnsureCapacity_real_T(zfIIR, xx_dim0, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(zfIIR, &gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((outridx
          - ns) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_convOut, convOut);
          }

          convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel184<<<grid, block>>>(gpu_convOut, ns, outridx,
            gpu_zfIIR);
        }

        ns = a->size[0] - 3;
        iv0 = a->size[0];
        idx = xt->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_convOut, convOut);
          }

          ec_filtfilt_kernel185<<<grid, block>>>(gpu_convOut, gpu_a, ns, iv0,
            idx, gpu_zfIIR);
        }

        xx_dim0 = f_b->size[0];
        f_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(f_b, xx_dim0, &ac_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_b, &g_gpu_b);
        i = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel186<<<grid, block>>>(gpu_b2, i, g_gpu_b);
          e_b_dirtyOnGpu = true;
        }

        xx_dim0 = e_a->size[0];
        e_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(e_a, xx_dim0, &dc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_a, &e_gpu_a);
        i = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel187<<<grid, block>>>(gpu_a2, i, e_gpu_a);
          c_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel188<<<grid, block>>>(gpu_a1, nb, g_gpu_b);
            e_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel189<<<grid, block>>>(gpu_a1, b_na, e_gpu_a);
          }

          ec_filtfilt_kernel190<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(e_gpu_a);
          c_a_dirtyOnGpu = true;
        }

        if (e_a->size[0] > f_b->size[0]) {
          loop_ub = e_a->size[0] - f_b->size[0];
          xx_dim0 = f_b->size[0];
          outridx = f_b->size[0];
          f_b->size[0] += loop_ub;
          emxEnsureCapacity_real_T(f_b, outridx, &jb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_b, &g_gpu_b);
          if (loop_ub - 1 >= 0) {
            if (e_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_b, &g_gpu_b);
            }

            std::memset(&f_b->data[xx_dim0], 0, static_cast<uint32_T>(loop_ub) *
                        sizeof(real_T));
            e_b_dirtyOnCpu = true;
          }
        }

        idx = f_b->size[0] - 1;
        window_idx_0 = static_cast<uint32_T>(f_b->size[0]);
        OH = (static_cast<uint32_T>(xx->size[0]) + static_cast<uint32_T>
              (f_b->size[0])) - 1U;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = f_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(f_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(f_b->
          size[0]) - 1.0) / 2.0));
        if (f_b->size[0] > MAX_int32_T - static_cast<int32_T>(u)) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + f_b->size[0];
        }

        xx_dim0 = f_expanded->size[0];
        f_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(f_expanded, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_expanded, &e_gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((
          static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) - 2) +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel191<<<grid, block>>>(static_cast<int32_T>(u),
            window_idx_0, e_gpu_expanded);
        }

        ns = xx->size[0];
        xx_dim0 = t_y->size[0] * t_y->size[1];
        t_y->size[0] = 1;
        t_y->size[1] = xx->size[0];
        emxEnsureCapacity_int32_T(t_y, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(t_y, &s_gpu_y);
        t_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          t_y->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = iv7->size[0];
        iv7->size[0] = t_y->size[1];
        emxEnsureCapacity_int32_T(iv7, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv7, &gpu_iv7);
        i = t_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&s_gpu_y, t_y);
          ec_filtfilt_kernel192<<<grid, block>>>(nc, s_gpu_y, i, gpu_iv7);
        }

        loop_ub = xx->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          ec_filtfilt_kernel193<<<grid, block>>>(gpu_xx, gpu_iv7, loop_ub,
            e_gpu_expanded);
        }

        xx_dim0 = g_rows->size[0] * g_rows->size[1];
        g_rows->size[0] = 1;
        g_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(g_rows, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(g_rows, &f_gpu_rows);
        g_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          g_rows->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = f_convOut->size[0];
        f_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(f_convOut, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_convOut, &f_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) +
                    31.0) / 32.0)), 1U, 1U);
        r1 = dim3(32U, 1U, 1U);
        i = f_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&f_gpu_rows, g_rows);
          if (e_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_b, f_b);
          }

          ec_filtfilt_kernel194<<<grid, block>>>(e_gpu_expanded, f_gpu_rows,
            g_gpu_b, static_cast<int32_T>(u), i, f_gpu_convOut);
          e_convOut_dirtyOnGpu = true;
        }

        if (na != 0) {
          if (na == 1) {
            ec_filtfilt_kernel196<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (gpu_zfIIR, f_gpu_convOut);
            e_convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((na
              - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel195<<<grid, block>>>(gpu_zfIIR, na - 1,
                f_gpu_convOut);
              e_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = xx->size[0] + e_a->size[0];
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          outridx = static_cast<int32_T>(std::fmin(static_cast<real_T>(d_x) +
            1.0, static_cast<real_T>(e_a->size[0])));
          for (nc = 0; nc <= outridx - 2; nc++) {
            if (e_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_convOut, &f_gpu_convOut);
            }

            if (c_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_a, &e_gpu_a);
            }

            c_a_dirtyOnGpu = false;
            f_convOut->data[d_x] -= f_convOut->data[(d_x - nc) - 1] * e_a->
              data[nc + 1];
            e_convOut_dirtyOnGpu = false;
            e_convOut_dirtyOnCpu = true;
          }
        }

        if (static_cast<uint32_T>(xx->size[0]) + 1U > static_cast<uint32_T>
            (f_convOut->size[0])) {
          ns = 1;
          outridx = 0;
        } else {
          ns = xx->size[0] + 1;
          outridx = f_convOut->size[0];
        }

        xx_dim0 = d_zfIIR->size[0];
        d_zfIIR->size[0] = (outridx - ns) + 1;
        emxEnsureCapacity_real_T(d_zfIIR, xx_dim0, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_zfIIR, &c_gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((outridx
          - ns) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (e_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_convOut, f_convOut);
          }

          e_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel197<<<grid, block>>>(f_gpu_convOut, ns, outridx,
            c_gpu_zfIIR);
        }

        ns = e_a->size[0] - 3;
        iv0 = e_a->size[0];
        xx_dim0 = xx->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (e_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_convOut, f_convOut);
          }

          e_convOut_dirtyOnCpu = false;
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          ec_filtfilt_kernel198<<<grid, block>>>(f_gpu_convOut, e_gpu_a, ns, iv0,
            xx_dim0, c_gpu_zfIIR);
        }

        outridx = xx->size[0] - 1;
        xx_dirtyOnGpu = false;
        val = 2.0 * xx->data[xx->size[0] - 1];
        xx_dim0 = xt->size[0];
        xt->size[0] = static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1;
        emxEnsureCapacity_real_T(xt, xx_dim0, &rc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(xt, &gpu_xt);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
          static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1L), &grid, &block,
          1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_d1, &val, 8UL, cudaMemcpyHostToDevice);
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          ec_filtfilt_kernel199<<<grid, block>>>(gpu_d1, gpu_xx, outridx, 0.0 -
            nfact, gpu_xt);
        }

        xx_dim0 = i_b->size[0];
        i_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(i_b, xx_dim0, &tc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_b, &l_gpu_b);
        i = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel200<<<grid, block>>>(gpu_b2, i, l_gpu_b);
          j_b_dirtyOnGpu = true;
        }

        xx_dim0 = h_a->size[0];
        h_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(h_a, xx_dim0, &uc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_a, &j_gpu_a);
        i = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel201<<<grid, block>>>(gpu_a2, i, j_gpu_a);
          e_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel202<<<grid, block>>>(e_gpu_a1, b_nb, l_gpu_b);
            j_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel203<<<grid, block>>>(e_gpu_a1, c_na, j_gpu_a);
          }

          ec_filtfilt_kernel204<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(j_gpu_a);
          e_a_dirtyOnGpu = true;
        }

        if (h_a->size[0] > i_b->size[0]) {
          loop_ub = h_a->size[0] - i_b->size[0];
          xx_dim0 = i_b->size[0];
          outridx = i_b->size[0];
          i_b->size[0] += loop_ub;
          emxEnsureCapacity_real_T(i_b, outridx, &jb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(i_b, &l_gpu_b);
          if (loop_ub - 1 >= 0) {
            if (j_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(i_b, &l_gpu_b);
            }

            std::memset(&i_b->data[xx_dim0], 0, static_cast<uint32_T>(loop_ub) *
                        sizeof(real_T));
            j_b_dirtyOnCpu = true;
          }
        }

        window_idx_0 = static_cast<uint32_T>(i_b->size[0]);
        OH = (static_cast<uint32_T>(xt->size[0]) + static_cast<uint32_T>
              (i_b->size[0])) - 1U;
        d_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = i_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(i_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(i_b->
          size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (i_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + i_b->size[0];
        }

        xx_dim0 = h_expanded->size[0];
        h_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(h_expanded, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_expanded, &j_gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((
          static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) - 2) +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel205<<<grid, block>>>(static_cast<int32_T>(u),
            window_idx_0, j_gpu_expanded);
        }

        ns = xt->size[0];
        xx_dim0 = w_y->size[0] * w_y->size[1];
        w_y->size[0] = 1;
        w_y->size[1] = xt->size[0];
        emxEnsureCapacity_int32_T(w_y, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(w_y, &bb_gpu_y);
        w_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          w_y->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = iv11->size[0];
        iv11->size[0] = w_y->size[1];
        emxEnsureCapacity_int32_T(iv11, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv11, &gpu_iv11);
        i = w_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&bb_gpu_y, w_y);
          ec_filtfilt_kernel206<<<grid, block>>>(nc, bb_gpu_y, i, gpu_iv11);
        }

        iv0 = xt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel207<<<grid, block>>>(gpu_xt, gpu_iv11, iv0,
            j_gpu_expanded);
        }

        xx_dim0 = i_rows->size[0] * i_rows->size[1];
        i_rows->size[0] = 1;
        i_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(i_rows, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(i_rows, &j_gpu_rows);
        i_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          i_rows->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = h_convOut->size[0];
        h_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(h_convOut, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_convOut, &o_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(d_x) - 1.0)) / static_cast<real_T>(d_x))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(d_x), 1U, 1U);
        i = i_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&j_gpu_rows, i_rows);
          if (j_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_b, i_b);
          }

          ec_filtfilt_kernel208<<<grid, block>>>(j_gpu_expanded, j_gpu_rows,
            l_gpu_b, static_cast<int32_T>(u), i, o_gpu_convOut);
          i_convOut_dirtyOnGpu = true;
        }

        if (idx != 0) {
          if (idx == 1) {
            ec_filtfilt_kernel210<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (c_gpu_zfIIR, o_gpu_convOut);
            i_convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((idx
              - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel209<<<grid, block>>>(c_gpu_zfIIR, idx - 1,
                o_gpu_convOut);
              i_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = xt->size[0] + h_a->size[0];
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          outridx = static_cast<int32_T>(std::fmin(static_cast<real_T>(d_x) +
            1.0, static_cast<real_T>(h_a->size[0])));
          for (nc = 0; nc <= outridx - 2; nc++) {
            if (i_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_convOut, &o_gpu_convOut);
            }

            if (e_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_a, &j_gpu_a);
            }

            e_a_dirtyOnGpu = false;
            h_convOut->data[d_x] -= h_convOut->data[(d_x - nc) - 1] * h_a->
              data[nc + 1];
            i_convOut_dirtyOnGpu = false;
            i_convOut_dirtyOnCpu = true;
          }
        }

        dv1[0] = static_cast<uint32_T>(xt->size[0]);
        if (i_convOut_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(h_convOut, &o_gpu_convOut);
        }

        val = h_convOut->data[xt->size[0] - 1];
        xx_dim0 = bb_y->size[0];
        bb_y->size[0] = zi->size[0];
        emxEnsureCapacity_real_T(bb_y, xx_dim0, &w_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(bb_y, &cb_gpu_y);
        i = zi->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (zi_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, zi);
          }

          ec_filtfilt_kernel211<<<grid, block>>>(val, gpu_zi, i, cb_gpu_y);
        }

        xx_dim0 = l_b->size[0];
        l_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(l_b, xx_dim0, &xc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_b, &m_gpu_b);
        i = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel212<<<grid, block>>>(gpu_b2, i, m_gpu_b);
          k_b_dirtyOnGpu = true;
        }

        xx_dim0 = k_a->size[0];
        k_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(k_a, xx_dim0, &yc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_a, &k_gpu_a);
        i = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel213<<<grid, block>>>(gpu_a2, i, k_gpu_a);
          f_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel214<<<grid, block>>>(d_gpu_a1, c_nb, m_gpu_b);
            k_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel215<<<grid, block>>>(d_gpu_a1, d_na, k_gpu_a);
          }

          ec_filtfilt_kernel216<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(k_gpu_a);
          f_a_dirtyOnGpu = true;
        }

        if (k_a->size[0] > l_b->size[0]) {
          loop_ub = k_a->size[0] - l_b->size[0];
          xx_dim0 = l_b->size[0];
          outridx = l_b->size[0];
          l_b->size[0] += loop_ub;
          emxEnsureCapacity_real_T(l_b, outridx, &jb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(l_b, &m_gpu_b);
          if (loop_ub - 1 >= 0) {
            if (k_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_b, &m_gpu_b);
            }

            std::memset(&l_b->data[xx_dim0], 0, static_cast<uint32_T>(loop_ub) *
                        sizeof(real_T));
            k_b_dirtyOnCpu = true;
          }
        }

        vlen = l_b->size[0] - 1;
        window_idx_0 = static_cast<uint32_T>(l_b->size[0]);
        OH = (static_cast<uint32_T>(xt->size[0]) + static_cast<uint32_T>
              (l_b->size[0])) - 1U;
        d_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = l_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(l_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(l_b->
          size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (l_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + l_b->size[0];
        }

        xx_dim0 = k_expanded->size[0];
        k_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(k_expanded, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_expanded, &k_gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((
          static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) - 2) +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel217<<<grid, block>>>(static_cast<int32_T>(u),
            window_idx_0, k_gpu_expanded);
        }

        ns = xt->size[0];
        xx_dim0 = db_y->size[0] * db_y->size[1];
        db_y->size[0] = 1;
        db_y->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(db_y, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(db_y, &db_gpu_y);
        db_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          db_y->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = iv16->size[0];
        iv16->size[0] = db_y->size[1];
        emxEnsureCapacity_int32_T(iv16, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv16, &gpu_iv16);
        i = db_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&db_gpu_y, db_y);
          ec_filtfilt_kernel218<<<grid, block>>>(nc, db_gpu_y, i, gpu_iv16);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(dv1[0]) - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (i_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&o_gpu_convOut, h_convOut);
          }

          ec_filtfilt_kernel219<<<grid, block>>>(o_gpu_convOut,
            static_cast<int32_T>(dv1[0]) - 1, gpu_iv16, static_cast<int32_T>
            (dv1[0]) - 1, k_gpu_expanded);
        }

        xx_dim0 = l_rows->size[0] * l_rows->size[1];
        l_rows->size[0] = 1;
        l_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(l_rows, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(l_rows, &l_gpu_rows);
        l_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          l_rows->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = k_convOut->size[0];
        k_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(k_convOut, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_convOut, &s_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(d_x) - 1.0)) / static_cast<real_T>(d_x))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(d_x), 1U, 1U);
        i = l_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&l_gpu_rows, l_rows);
          if (k_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_b, l_b);
          }

          ec_filtfilt_kernel220<<<grid, block>>>(k_gpu_expanded, l_gpu_rows,
            m_gpu_b, static_cast<int32_T>(u), i, s_gpu_convOut);
          k_convOut_dirtyOnGpu = true;
        }

        if (bb_y->size[0] != 0) {
          if (bb_y->size[0] == 1) {
            ec_filtfilt_kernel222<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (cb_gpu_y, s_gpu_convOut);
            k_convOut_dirtyOnGpu = true;
          } else {
            ns = bb_y->size[0] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel221<<<grid, block>>>(cb_gpu_y, ns, s_gpu_convOut);
              k_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = static_cast<int32_T>(dv1[0]) + k_a->size[0];
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          outridx = static_cast<int32_T>(std::fmin(static_cast<real_T>(d_x) +
            1.0, static_cast<real_T>(k_a->size[0])));
          for (nc = 0; nc <= outridx - 2; nc++) {
            if (k_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(k_convOut, &s_gpu_convOut);
            }

            if (f_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(k_a, &k_gpu_a);
            }

            f_a_dirtyOnGpu = false;
            k_convOut->data[d_x] -= k_convOut->data[(d_x - nc) - 1] * k_a->
              data[nc + 1];
            k_convOut_dirtyOnGpu = false;
            k_convOut_dirtyOnCpu = true;
          }
        }

        if (static_cast<uint32_T>(xt->size[0]) + 1U > static_cast<uint32_T>
            (k_convOut->size[0])) {
          ns = 0;
          outridx = -1;
        } else {
          ns = static_cast<int32_T>(dv1[0]);
          outridx = k_convOut->size[0] - 1;
        }

        xx_dim0 = f_zfIIR->size[0];
        f_zfIIR->size[0] = (outridx - ns) + 1;
        emxEnsureCapacity_real_T(f_zfIIR, xx_dim0, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_zfIIR, &f_gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((outridx
          - ns) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (k_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&s_gpu_convOut, k_convOut);
          }

          k_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel223<<<grid, block>>>(s_gpu_convOut, ns, outridx,
            f_gpu_zfIIR);
        }

        ns = k_a->size[0] - 3;
        iv0 = k_a->size[0];
        idx = xt->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (k_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&s_gpu_convOut, k_convOut);
          }

          ec_filtfilt_kernel224<<<grid, block>>>(s_gpu_convOut, k_gpu_a, ns, iv0,
            idx, f_gpu_zfIIR);
        }

        ns = xx->size[0];
        xx_dim0 = m_b->size[0];
        m_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(m_b, xx_dim0, &ad_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(m_b, &n_gpu_b);
        i = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel225<<<grid, block>>>(gpu_b2, i, n_gpu_b);
          l_b_dirtyOnGpu = true;
        }

        xx_dim0 = l_a->size[0];
        l_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(l_a, xx_dim0, &bd_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_a, &l_gpu_a);
        i = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel226<<<grid, block>>>(gpu_a2, i, l_gpu_a);
          g_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel227<<<grid, block>>>(c_gpu_a1, d_nb, n_gpu_b);
            l_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(e_na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel228<<<grid, block>>>(c_gpu_a1, e_na, l_gpu_a);
          }

          ec_filtfilt_kernel229<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(l_gpu_a);
          g_a_dirtyOnGpu = true;
        }

        if (l_a->size[0] > m_b->size[0]) {
          loop_ub = l_a->size[0] - m_b->size[0];
          xx_dim0 = m_b->size[0];
          outridx = m_b->size[0];
          m_b->size[0] += loop_ub;
          emxEnsureCapacity_real_T(m_b, outridx, &jb_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(m_b, &n_gpu_b);
          if (loop_ub - 1 >= 0) {
            if (l_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(m_b, &n_gpu_b);
            }

            std::memset(&m_b->data[xx_dim0], 0, static_cast<uint32_T>(loop_ub) *
                        sizeof(real_T));
            l_b_dirtyOnCpu = true;
          }
        }

        window_idx_0 = static_cast<uint32_T>(m_b->size[0]);
        OH = (static_cast<uint32_T>(xx->size[0]) + static_cast<uint32_T>
              (m_b->size[0])) - 1U;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = m_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(m_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(m_b->
          size[0]) - 1.0) / 2.0));
        if (m_b->size[0] > MAX_int32_T - static_cast<int32_T>(u)) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + m_b->size[0];
        }

        xx_dim0 = l_expanded->size[0];
        l_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(l_expanded, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_expanded, &l_gpu_expanded);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((
          static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) - 2) +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel230<<<grid, block>>>(static_cast<int32_T>(u),
            window_idx_0, l_gpu_expanded);
        }

        xx_dim0 = eb_y->size[0] * eb_y->size[1];
        eb_y->size[0] = 1;
        eb_y->size[1] = xx->size[0];
        emxEnsureCapacity_int32_T(eb_y, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(eb_y, &eb_gpu_y);
        eb_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          eb_y->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = iv17->size[0];
        iv17->size[0] = eb_y->size[1];
        emxEnsureCapacity_int32_T(iv17, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv17, &gpu_iv17);
        i = eb_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&eb_gpu_y, eb_y);
          ec_filtfilt_kernel231<<<grid, block>>>(nc, eb_gpu_y, i, gpu_iv17);
        }

        loop_ub = xx->size[0] - 1;
        xx_dim0 = xx->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (e_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_convOut, f_convOut);
          }

          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          ec_filtfilt_kernel232<<<grid, block>>>(f_gpu_convOut, gpu_iv17,
            loop_ub, xx_dim0, l_gpu_expanded);
        }

        xx_dim0 = m_rows->size[0] * m_rows->size[1];
        m_rows->size[0] = 1;
        m_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(m_rows, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(m_rows, &m_gpu_rows);
        m_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          m_rows->data[xx_dim0 + 1] = outridx;
        }

        xx_dim0 = l_convOut->size[0];
        l_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(l_convOut, xx_dim0, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_convOut, &t_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) +
                    31.0) / 32.0)), 1U, 1U);
        r1 = dim3(32U, 1U, 1U);
        i = m_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&m_gpu_rows, m_rows);
          if (l_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_b, m_b);
          }

          ec_filtfilt_kernel233<<<grid, block>>>(l_gpu_expanded, m_gpu_rows,
            n_gpu_b, static_cast<int32_T>(u), i, t_gpu_convOut);
          l_convOut_dirtyOnGpu = true;
        }

        if (vlen != 0) {
          if (vlen == 1) {
            ec_filtfilt_kernel235<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (f_gpu_zfIIR, t_gpu_convOut);
            l_convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((vlen - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel234<<<grid, block>>>(f_gpu_zfIIR, vlen - 1,
                t_gpu_convOut);
              l_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = xx->size[0] + l_a->size[0];
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          outridx = static_cast<int32_T>(std::fmin(static_cast<real_T>(d_x) +
            1.0, static_cast<real_T>(l_a->size[0])));
          for (nc = 0; nc <= outridx - 2; nc++) {
            if (l_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_convOut, &t_gpu_convOut);
            }

            if (g_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_a, &l_gpu_a);
            }

            g_a_dirtyOnGpu = false;
            l_convOut->data[d_x] -= l_convOut->data[(d_x - nc) - 1] * l_a->
              data[nc + 1];
            l_convOut_dirtyOnGpu = false;
            l_convOut_dirtyOnCpu = true;
          }
        }

        outridx = xx->size[0];
        ns = xx->size[0];
        xx_dim0 = u_convOut->size[0];
        u_convOut->size[0] = xx->size[0];
        emxEnsureCapacity_real_T(u_convOut, xx_dim0, &cd_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(u_convOut, &u_gpu_convOut);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((outridx
          - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (l_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&t_gpu_convOut, l_convOut);
          }

          ec_filtfilt_kernel236<<<grid, block>>>(t_gpu_convOut, outridx,
            u_gpu_convOut);
        }

        xx_dim0 = xx->size[0] * xx->size[1];
        xx->size[0] = ns;
        xx->size[1] = 1;
        emxEnsureCapacity_real_T(xx, xx_dim0, &dd_emlrtRTEI);
        if (!xx_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(xx, &gpu_xx);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns - 1)
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          ec_filtfilt_kernel237<<<grid, block>>>(u_gpu_convOut, ns, gpu_xx);
          xx_dirtyOnCpu = false;
          xx_dirtyOnGpu = true;
        }
      }
    } else {
      int32_T b_na;
      int32_T b_nb;
      int32_T c_na;
      int32_T c_nb;
      int32_T d_na;
      int32_T d_nb;
      int32_T e_na;
      int32_T na;
      int32_T nb;
      uint32_T sz[2];
      uint32_T OH;
      uint32_T u;
      uint32_T window_idx_0;
      for (iv0 = 0; iv0 < 2; iv0++) {
        sz[iv0] = static_cast<uint32_T>(xx->size[iv0]);
      }

      outridx = xx->size[0];
      i = xx->size[0] * xx->size[1];
      xx->size[0] = static_cast<int32_T>(sz[0]);
      xx->size[1] = div_s32(outridx * xx->size[1], static_cast<int32_T>(sz[0]));
      emxEnsureCapacity_real_T(xx, i, &m_emlrtRTEI);
      if (!xx_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(xx, &gpu_xx);
      }

      na = a2->size[0] - 2;
      thism = b2->size[0] - 1;
      b_na = a2->size[0] - 2;
      nb = b2->size[0] - 1;
      c_na = a2->size[0] - 2;
      b_nb = b2->size[0] - 1;
      d_na = a2->size[0] - 2;
      c_nb = b2->size[0] - 1;
      e_na = a2->size[0] - 2;
      d_nb = b2->size[0] - 1;
      if (maxCoefNum_dirtyOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_a2, a2);
      }

      ec_filtfilt_kernel73<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
        c_gpu_a1, d_gpu_a1, e_gpu_a1, gpu_a1, b_gpu_a1);
      i = g_y->size[0] * g_y->size[1];
      g_y->size[0] = 1;
      g_y->size[1] = xx->size[1];
      emxEnsureCapacity_real_T(g_y, i, &w_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(g_y, &d_gpu_y);
      loop_ub = xx->size[1] - 1;
      xx_dim0 = xx->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub +
        1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (xx_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
        }

        xx_dirtyOnCpu = false;
        ec_filtfilt_kernel74<<<grid, block>>>(gpu_xx, loop_ub, xx_dim0, d_gpu_y);
      }

      ns = xx->size[1];
      outridx = g_y->size[1];
      if (ns <= outridx) {
        outridx = ns;
      }

      if (xx->size[1] == 1) {
        vlen = g_y->size[1];
      } else if (g_y->size[1] == 1) {
        vlen = xx->size[1];
      } else if (g_y->size[1] == xx->size[1]) {
        vlen = g_y->size[1];
      } else {
        vlen = outridx;
      }

      i = b_xt->size[0] * b_xt->size[1];
      b_xt->size[0] = static_cast<int32_T>(nfact + 1.0) - 1;
      ns = xx->size[1];
      outridx = g_y->size[1];
      if (ns <= outridx) {
        outridx = ns;
      }

      if (xx->size[1] == 1) {
        b_xt->size[1] = g_y->size[1];
      } else if (g_y->size[1] == 1) {
        b_xt->size[1] = xx->size[1];
      } else if (g_y->size[1] == xx->size[1]) {
        b_xt->size[1] = g_y->size[1];
      } else {
        b_xt->size[1] = outridx;
      }

      emxEnsureCapacity_real_T(b_xt, i, &bb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_xt, &b_gpu_xt);
      if (vlen != 0) {
        ns = (g_y->size[1] != 1);
        outridx = (xx->size[1] != 1);
        iv0 = b_xt->size[0] - 1;
        idx = b_xt->size[0];
        xx_dim0 = xx->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * ((vlen - 1) + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          ec_filtfilt_kernel75<<<grid, block>>>(gpu_xx, d_gpu_y, nfact, outridx,
            ns, iv0, vlen, idx, xx_dim0, b_gpu_xt);
        }
      }

      i = i_y->size[0] * i_y->size[1];
      i_y->size[0] = zi->size[0];
      i_y->size[1] = b_xt->size[1];
      emxEnsureCapacity_real_T(i_y, i, &gb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(i_y, &i_gpu_y);
      loop_ub = b_xt->size[1] - 1;
      i = zi->size[0] - 1;
      iv0 = i_y->size[0];
      idx = b_xt->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L) *
        (loop_ub + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (zi_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, zi);
        }

        zi_dirtyOnCpu = false;
        ec_filtfilt_kernel76<<<grid, block>>>(b_gpu_xt, gpu_zi, i, loop_ub, iv0,
          idx, i_gpu_y);
        y_dirtyOnGpu = true;
      }

      i = d_b->size[0];
      d_b->size[0] = b2->size[0];
      emxEnsureCapacity_real_T(d_b, i, &ib_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(d_b, &e_gpu_b);
      i = b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel77<<<grid, block>>>(gpu_b2, i, e_gpu_b);
        c_b_dirtyOnGpu = true;
      }

      i = c_a->size[0];
      c_a->size[0] = a2->size[0];
      emxEnsureCapacity_real_T(c_a, i, &mb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(c_a, &c_gpu_a);
      i = a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel78<<<grid, block>>>(gpu_a2, i, c_gpu_a);
      }

      if (x_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(a2, &gpu_a2);
      }

      if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
          (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(thism +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel79<<<grid, block>>>(b_gpu_a1, thism, e_gpu_b);
          c_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel80<<<grid, block>>>(b_gpu_a1, na, c_gpu_a);
        }

        ec_filtfilt_kernel81<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(c_gpu_a);
      }

      if (c_a->size[0] > d_b->size[0]) {
        loop_ub = c_a->size[0] - d_b->size[0];
        i = d_b->size[0];
        xx_dim0 = d_b->size[0];
        d_b->size[0] += loop_ub;
        emxEnsureCapacity_real_T(d_b, xx_dim0, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_b, &e_gpu_b);
        if (loop_ub - 1 >= 0) {
          if (c_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_b, &e_gpu_b);
          }

          std::memset(&d_b->data[i], 0, static_cast<uint32_T>(loop_ub) * sizeof
                      (real_T));
          c_b_dirtyOnCpu = true;
        }
      }

      for (iv0 = 0; iv0 < 2; iv0++) {
        zfSize[iv0] = static_cast<uint32_T>(b_xt->size[iv0]);
        zfSize_dirtyOnCpu = true;
      }

      i = d_b->size[0];
      if (c_b_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_b, d_b);
      }

      if (zfSize_dirtyOnCpu) {
        cudaMemcpy(*gpu_zfSize, zfSize, 8UL, cudaMemcpyHostToDevice);
      }

      ec_filtfilt_kernel82<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i,
        *gpu_zfSize);
      zfSize_dirtyOnCpu = false;
      if (b_xt->size[1] == 0) {
        i = b_zfIIR->size[0] * b_zfIIR->size[1];
        b_zfIIR->size[0] = d_b->size[0] - 1;
        cudaMemcpy(zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        b_zfIIR->size[1] = static_cast<int32_T>(zfSize[1]);
        emxEnsureCapacity_real_T(b_zfIIR, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_zfIIR, &b_gpu_zfIIR);
      } else {
        window_idx_0 = static_cast<uint32_T>(d_b->size[0]);
        OH = (static_cast<uint32_T>(b_xt->size[0]) + static_cast<uint32_T>
              (d_b->size[0])) - 1U;
        d_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        vlen = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (b_xt->size[1]) + 1.0) - 1.0));
        c = b_xt->size[1] - 1;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = d_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(d_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(d_b->
          size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (d_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + d_b->size[0];
        }

        i = c_expanded->size[0] * c_expanded->size[1];
        c_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(c_expanded, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_expanded, &c_gpu_expanded);
        if (b_xt->size[1] > 2147483646) {
          outridx = MAX_int32_T;
        } else {
          outridx = b_xt->size[1] + 1;
        }

        i = c_expanded->size[0] * c_expanded->size[1];
        c_expanded->size[1] = outridx - 1;
        emxEnsureCapacity_real_T(c_expanded, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_expanded, &c_gpu_expanded);
        idx = ((static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) -
               1) * b_xt->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel83<<<grid, block>>>(idx, c_gpu_expanded);
        }

        ns = b_xt->size[0];
        i = l_y->size[0] * l_y->size[1];
        l_y->size[0] = 1;
        l_y->size[1] = b_xt->size[0];
        emxEnsureCapacity_int32_T(l_y, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(l_y, &l_gpu_y);
        l_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          l_y->data[xx_dim0 + 1] = outridx;
        }

        i = iv2->size[0];
        iv2->size[0] = l_y->size[1];
        emxEnsureCapacity_int32_T(iv2, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv2, &gpu_iv2);
        i = l_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&l_gpu_y, l_y);
          ec_filtfilt_kernel84<<<grid, block>>>(nc, l_gpu_y, i, gpu_iv2);
        }

        ns = b_xt->size[1];
        i = m_y->size[0] * m_y->size[1];
        m_y->size[0] = 1;
        m_y->size[1] = b_xt->size[1];
        emxEnsureCapacity_int32_T(m_y, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(m_y, &o_gpu_y);
        m_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          m_y->data[xx_dim0 + 1] = outridx;
        }

        i = iv3->size[0];
        iv3->size[0] = m_y->size[1];
        emxEnsureCapacity_int32_T(iv3, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv3, &gpu_iv3);
        i = m_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&o_gpu_y, m_y);
          ec_filtfilt_kernel85<<<grid, block>>>(o_gpu_y, i, gpu_iv3);
        }

        iv0 = b_xt->size[1] - 1;
        i = b_xt->size[0] - 1;
        na = c_expanded->size[0];
        idx = b_xt->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L)
          * (iv0 + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel86<<<grid, block>>>(b_gpu_xt, gpu_iv3, gpu_iv2, i,
            iv0, na, idx, c_gpu_expanded);
        }

        i = d_rows->size[0] * d_rows->size[1];
        d_rows->size[0] = 1;
        d_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(d_rows, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(d_rows, &d_gpu_rows);
        d_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          d_rows->data[xx_dim0 + 1] = outridx;
        }

        i = c_convOut->size[0] * c_convOut->size[1];
        c_convOut->size[0] = static_cast<int32_T>(u);
        c_convOut->size[1] = b_xt->size[1];
        emxEnsureCapacity_real_T(c_convOut, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_convOut, &c_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(d_x) - 1.0)) / static_cast<real_T>(d_x))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(b_xt->size[1]) + static_cast<uint32_T>(vlen)) -
                    1.0) / static_cast<real_T>(vlen))), 1U);
        r1 = dim3(static_cast<uint32_T>(d_x), static_cast<uint32_T>(vlen), 1U);
        vlen = c_convOut->size[0];
        na = c_expanded->size[0];
        i = d_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(((
          static_cast<int32_T>(u) - 1) + 1L) * (c + 1L)), &r, &r1, &grid, &block,
          1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&d_gpu_rows, d_rows);
          ec_filtfilt_kernel87<<<grid, block>>>(c_gpu_expanded, d_gpu_rows,
            e_gpu_b, static_cast<int32_T>(u), c, i, vlen, na, c_gpu_convOut);
          c_convOut_dirtyOnGpu = true;
        }

        if ((i_y->size[0] != 0) && (i_y->size[1] != 0)) {
          if (i_y->size[0] == 1) {
            ns = c_convOut->size[1] - 1;
            i = i_y->size[1] - 1;
            vlen = c_convOut->size[0];
            iv0 = i_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel91<<<grid, block>>>(i_gpu_y, i, ns, vlen, iv0,
                c_gpu_convOut);
            }
          } else if (i_y->size[1] == 1) {
            ns = c_convOut->size[1] - 1;
            i = i_y->size[0] - 1;
            vlen = c_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel90<<<grid, block>>>(i_gpu_y, i, ns, vlen,
                c_gpu_convOut);
            }
          } else if (c_convOut->size[1] == i_y->size[1]) {
            i = m_convOut->size[0] * m_convOut->size[1];
            m_convOut->size[0] = i_y->size[0];
            m_convOut->size[1] = c_convOut->size[1];
            emxEnsureCapacity_real_T(m_convOut, i, &jb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(m_convOut, &d_gpu_convOut);
            thism = c_convOut->size[1] - 1;
            i = i_y->size[0] - 1;
            vlen = m_convOut->size[0];
            idx = c_convOut->size[0];
            iv0 = i_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel88<<<grid, block>>>(i_gpu_y, c_gpu_convOut, i,
                thism, vlen, idx, iv0, d_gpu_convOut);
            }

            thism = m_convOut->size[1] - 1;
            i = m_convOut->size[0] - 1;
            vlen = c_convOut->size[0];
            idx = m_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel89<<<grid, block>>>(d_gpu_convOut, i, thism,
                vlen, idx, c_gpu_convOut);
            }
          } else {
            if (c_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_convOut, &c_gpu_convOut);
            }

            if (y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(i_y, &i_gpu_y);
            }

            binary_expand_op(c_convOut, i_y);
            c_convOut_dirtyOnCpu = true;
          }
        }

        ns = c_convOut->size[1] - 1;
        idx = b_xt->size[0];
        iv0 = c_a->size[0];
        vlen = c_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_convOut, c_convOut);
          }

          ec_filtfilt_kernel92<<<grid, block>>>(c_gpu_a, ns, idx, iv0, vlen,
            c_gpu_convOut);
          c_convOut_dirtyOnCpu = false;
        }

        if (static_cast<uint32_T>(b_xt->size[0]) + 1U > static_cast<uint32_T>
            (c_convOut->size[0])) {
          ns = 0;
          outridx = -1;
        } else {
          ns = b_xt->size[0];
          outridx = c_convOut->size[0] - 1;
        }

        i = b_zfIIR->size[0] * b_zfIIR->size[1];
        b_zfIIR->size[0] = (outridx - ns) + 1;
        b_zfIIR->size[1] = c_convOut->size[1];
        emxEnsureCapacity_real_T(b_zfIIR, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_zfIIR, &b_gpu_zfIIR);
        thism = c_convOut->size[1] - 1;
        na = b_zfIIR->size[0];
        vlen = c_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (((outridx - ns) + 1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_convOut, c_convOut);
          }

          c_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel93<<<grid, block>>>(c_gpu_convOut, ns, outridx,
            thism, na, vlen, b_gpu_zfIIR);
          zfIIR_dirtyOnGpu = true;
        }

        ns = c_convOut->size[1] - 1;
        i = c_a->size[0] - 3;
        iv0 = c_a->size[0];
        na = b_zfIIR->size[0];
        idx = b_xt->size[0];
        vlen = c_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L)
          * (ns + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_convOut, c_convOut);
          }

          ec_filtfilt_kernel94<<<grid, block>>>(c_gpu_convOut, c_gpu_a, i, ns,
            iv0, na, idx, vlen, b_gpu_zfIIR);
          zfIIR_dirtyOnGpu = true;
        }

        i = b_zfIIR->size[0] * b_zfIIR->size[1];
        cudaMemcpy(zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        b_zfIIR->size[0] = static_cast<int32_T>(zfSize[0]);
        b_zfIIR->size[1] = static_cast<int32_T>(zfSize[1]);
        emxEnsureCapacity_real_T(b_zfIIR, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_zfIIR, &b_gpu_zfIIR);
      }

      i = e_b->size[0];
      e_b->size[0] = b2->size[0];
      emxEnsureCapacity_real_T(e_b, i, &qb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(e_b, &f_gpu_b);
      i = b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel95<<<grid, block>>>(gpu_b2, i, f_gpu_b);
        d_b_dirtyOnGpu = true;
      }

      i = d_a->size[0];
      d_a->size[0] = a2->size[0];
      emxEnsureCapacity_real_T(d_a, i, &sb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(d_a, &d_gpu_a);
      i = a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel96<<<grid, block>>>(gpu_a2, i, d_gpu_a);
      }

      if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
          (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nb + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel97<<<grid, block>>>(gpu_a1, nb, f_gpu_b);
          d_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_na +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel98<<<grid, block>>>(gpu_a1, b_na, d_gpu_a);
        }

        ec_filtfilt_kernel99<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_a);
      }

      if (d_a->size[0] > e_b->size[0]) {
        loop_ub = d_a->size[0] - e_b->size[0];
        i = e_b->size[0];
        xx_dim0 = e_b->size[0];
        e_b->size[0] += loop_ub;
        emxEnsureCapacity_real_T(e_b, xx_dim0, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_b, &f_gpu_b);
        if (loop_ub - 1 >= 0) {
          if (d_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_b, &f_gpu_b);
          }

          std::memset(&e_b->data[i], 0, static_cast<uint32_T>(loop_ub) * sizeof
                      (real_T));
          d_b_dirtyOnCpu = true;
        }
      }

      for (iv0 = 0; iv0 < 2; iv0++) {
        zfSize[iv0] = static_cast<uint32_T>(xx->size[iv0]);
        zfSize_dirtyOnCpu = true;
      }

      i = e_b->size[0];
      if (d_b_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_b, e_b);
      }

      if (zfSize_dirtyOnCpu) {
        cudaMemcpy(*gpu_zfSize, zfSize, 8UL, cudaMemcpyHostToDevice);
      }

      ec_filtfilt_kernel100<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i,
        *gpu_zfSize);
      if (xx->size[1] == 0) {
        for (iv0 = 0; iv0 < 2; iv0++) {
          dv1[iv0] = static_cast<uint32_T>(xx->size[iv0]);
        }

        yc2->size[0] = static_cast<int32_T>(dv1[0]);
        yc2->size[1] = 0;
        i = c_zfIIR->size[0] * c_zfIIR->size[1];
        cudaMemcpy(zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        c_zfIIR->size[0] = static_cast<int32_T>(zfSize[0]);
        c_zfIIR->size[1] = static_cast<int32_T>(zfSize[1]);
        emxEnsureCapacity_real_T(c_zfIIR, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_zfIIR, &d_gpu_zfIIR);
      } else {
        window_idx_0 = static_cast<uint32_T>(e_b->size[0]);
        OH = (static_cast<uint32_T>(xx->size[0]) + static_cast<uint32_T>
              (e_b->size[0])) - 1U;
        d_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        vlen = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (xx->size[1]) + 1.0) - 1.0));
        c = xx->size[1] - 1;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = e_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(e_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(e_b->
          size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (e_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + e_b->size[0];
        }

        i = d_expanded->size[0] * d_expanded->size[1];
        d_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(d_expanded, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_expanded, &d_gpu_expanded);
        if (xx->size[1] > 2147483646) {
          outridx = MAX_int32_T;
        } else {
          outridx = xx->size[1] + 1;
        }

        i = d_expanded->size[0] * d_expanded->size[1];
        d_expanded->size[1] = outridx - 1;
        emxEnsureCapacity_real_T(d_expanded, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_expanded, &d_gpu_expanded);
        idx = ((static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) -
               1) * xx->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel101<<<grid, block>>>(idx, d_gpu_expanded);
        }

        i = xx->size[0];
        xx_dim0 = o_y->size[0] * o_y->size[1];
        o_y->size[0] = 1;
        o_y->size[1] = xx->size[0];
        emxEnsureCapacity_int32_T(o_y, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(o_y, &p_gpu_y);
        o_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= i - 2; xx_dim0++) {
          outridx++;
          o_y->data[xx_dim0 + 1] = outridx;
        }

        i = iv4->size[0];
        iv4->size[0] = o_y->size[1];
        emxEnsureCapacity_int32_T(iv4, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv4, &gpu_iv4);
        i = o_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&p_gpu_y, o_y);
          ec_filtfilt_kernel102<<<grid, block>>>(nc, p_gpu_y, i, gpu_iv4);
        }

        i = xx->size[1];
        xx_dim0 = q_y->size[0] * q_y->size[1];
        q_y->size[0] = 1;
        q_y->size[1] = xx->size[1];
        emxEnsureCapacity_int32_T(q_y, xx_dim0, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(q_y, &q_gpu_y);
        q_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= i - 2; xx_dim0++) {
          outridx++;
          q_y->data[xx_dim0 + 1] = outridx;
        }

        i = iv5->size[0];
        iv5->size[0] = q_y->size[1];
        emxEnsureCapacity_int32_T(iv5, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv5, &gpu_iv5);
        i = q_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&q_gpu_y, q_y);
          ec_filtfilt_kernel103<<<grid, block>>>(q_gpu_y, i, gpu_iv5);
        }

        loop_ub = xx->size[1] - 1;
        iv0 = xx->size[0] - 1;
        na = d_expanded->size[0];
        xx_dim0 = xx->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (loop_ub + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          ec_filtfilt_kernel104<<<grid, block>>>(gpu_xx, gpu_iv5, gpu_iv4, iv0,
            loop_ub, na, xx_dim0, d_gpu_expanded);
        }

        i = e_rows->size[0] * e_rows->size[1];
        e_rows->size[0] = 1;
        e_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(e_rows, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(e_rows, &e_gpu_rows);
        e_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          e_rows->data[xx_dim0 + 1] = outridx;
        }

        i = d_convOut->size[0] * d_convOut->size[1];
        d_convOut->size[0] = static_cast<int32_T>(u);
        d_convOut->size[1] = xx->size[1];
        emxEnsureCapacity_real_T(d_convOut, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_convOut, &e_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(d_x) - 1.0)) / static_cast<real_T>(d_x))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(xx->size[1]) + static_cast<uint32_T>(vlen)) -
                    1.0) / static_cast<real_T>(vlen))), 1U);
        r1 = dim3(static_cast<uint32_T>(d_x), static_cast<uint32_T>(vlen), 1U);
        vlen = d_convOut->size[0];
        na = d_expanded->size[0];
        i = e_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(((
          static_cast<int32_T>(u) - 1) + 1L) * (c + 1L)), &r, &r1, &grid, &block,
          1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&e_gpu_rows, e_rows);
          ec_filtfilt_kernel105<<<grid, block>>>(d_gpu_expanded, e_gpu_rows,
            f_gpu_b, static_cast<int32_T>(u), c, i, vlen, na, e_gpu_convOut);
          d_convOut_dirtyOnGpu = true;
        }

        if ((b_zfIIR->size[0] != 0) && (b_zfIIR->size[1] != 0)) {
          if (b_zfIIR->size[0] == 1) {
            ns = d_convOut->size[1] - 1;
            i = b_zfIIR->size[1] - 1;
            vlen = d_convOut->size[0];
            na = b_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel109<<<grid, block>>>(b_gpu_zfIIR, i, ns, vlen,
                na, e_gpu_convOut);
            }
          } else if (b_zfIIR->size[1] == 1) {
            ns = d_convOut->size[1] - 1;
            i = b_zfIIR->size[0] - 1;
            vlen = d_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel108<<<grid, block>>>(b_gpu_zfIIR, i, ns, vlen,
                e_gpu_convOut);
            }
          } else if (d_convOut->size[1] == b_zfIIR->size[1]) {
            i = n_convOut->size[0] * n_convOut->size[1];
            n_convOut->size[0] = b_zfIIR->size[0];
            n_convOut->size[1] = d_convOut->size[1];
            emxEnsureCapacity_real_T(n_convOut, i, &jb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(n_convOut, &h_gpu_convOut);
            thism = d_convOut->size[1] - 1;
            i = b_zfIIR->size[0] - 1;
            vlen = n_convOut->size[0];
            idx = d_convOut->size[0];
            na = b_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel106<<<grid, block>>>(b_gpu_zfIIR, e_gpu_convOut,
                i, thism, vlen, idx, na, h_gpu_convOut);
            }

            thism = n_convOut->size[1] - 1;
            i = n_convOut->size[0] - 1;
            vlen = d_convOut->size[0];
            idx = n_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel107<<<grid, block>>>(h_gpu_convOut, i, thism,
                vlen, idx, e_gpu_convOut);
            }
          } else {
            if (d_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(d_convOut, &e_gpu_convOut);
            }

            if (zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_zfIIR, &b_gpu_zfIIR);
            }

            binary_expand_op(d_convOut, b_zfIIR);
            d_convOut_dirtyOnCpu = true;
          }
        }

        ns = d_convOut->size[1] - 1;
        xx_dim0 = xx->size[0];
        iv0 = d_a->size[0];
        vlen = d_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_convOut, d_convOut);
          }

          ec_filtfilt_kernel110<<<grid, block>>>(d_gpu_a, ns, xx_dim0, iv0, vlen,
            e_gpu_convOut);
          d_convOut_dirtyOnCpu = false;
        }

        if (static_cast<uint32_T>(xx->size[0]) + 1U > static_cast<uint32_T>
            (d_convOut->size[0])) {
          ns = 1;
          outridx = 0;
        } else {
          ns = xx->size[0] + 1;
          outridx = d_convOut->size[0];
        }

        i = c_zfIIR->size[0] * c_zfIIR->size[1];
        c_zfIIR->size[0] = (outridx - ns) + 1;
        c_zfIIR->size[1] = d_convOut->size[1];
        emxEnsureCapacity_real_T(c_zfIIR, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_zfIIR, &d_gpu_zfIIR);
        thism = d_convOut->size[1] - 1;
        na = c_zfIIR->size[0];
        vlen = d_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (((outridx - ns) + 1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_convOut, d_convOut);
          }

          d_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel111<<<grid, block>>>(e_gpu_convOut, ns, outridx,
            thism, na, vlen, d_gpu_zfIIR);
          b_zfIIR_dirtyOnGpu = true;
        }

        ns = d_convOut->size[1] - 1;
        i = d_a->size[0] - 3;
        iv0 = d_a->size[0];
        na = c_zfIIR->size[0];
        xx_dim0 = xx->size[0];
        vlen = d_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L)
          * (ns + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_convOut, d_convOut);
          }

          d_convOut_dirtyOnCpu = false;
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          ec_filtfilt_kernel112<<<grid, block>>>(e_gpu_convOut, d_gpu_a, i, ns,
            iv0, na, xx_dim0, vlen, d_gpu_zfIIR);
          b_zfIIR_dirtyOnGpu = true;
        }

        i = c_zfIIR->size[0] * c_zfIIR->size[1];
        cudaMemcpy(zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        c_zfIIR->size[0] = static_cast<int32_T>(zfSize[0]);
        c_zfIIR->size[1] = static_cast<int32_T>(zfSize[1]);
        emxEnsureCapacity_real_T(c_zfIIR, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_zfIIR, &d_gpu_zfIIR);
        i = o_convOut->size[0] * o_convOut->size[1];
        o_convOut->size[0] = xx->size[0];
        o_convOut->size[1] = d_convOut->size[1];
        emxEnsureCapacity_real_T(o_convOut, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(o_convOut, &i_gpu_convOut);
        thism = d_convOut->size[1] - 1;
        loop_ub = xx->size[0] - 1;
        vlen = o_convOut->size[0];
        idx = d_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((loop_ub
          + 1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_convOut, d_convOut);
          }

          ec_filtfilt_kernel113<<<grid, block>>>(e_gpu_convOut, loop_ub, thism,
            vlen, idx, i_gpu_convOut);
        }

        ns = xx->size[0];
        outridx = xx->size[1];
        i = yc2->size[0] * yc2->size[1];
        yc2->size[0] = xx->size[0];
        yc2->size[1] = xx->size[1];
        emxEnsureCapacity_real_T(yc2, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(yc2, &gpu_yc2);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns *
          outridx - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel114<<<grid, block>>>(i_gpu_convOut, ns, outridx,
            gpu_yc2);
        }
      }

      outridx = xx->size[0] - 1;
      i = n_y->size[0] * n_y->size[1];
      n_y->size[0] = 1;
      n_y->size[1] = xx->size[1];
      emxEnsureCapacity_real_T(n_y, i, &w_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(n_y, &m_gpu_y);
      loop_ub = xx->size[1] - 1;
      xx_dim0 = xx->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub +
        1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (xx_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
        }

        xx_dirtyOnCpu = false;
        ec_filtfilt_kernel115<<<grid, block>>>(gpu_xx, outridx, loop_ub, xx_dim0,
          m_gpu_y);
      }

      ns = xx->size[1];
      outridx = n_y->size[1];
      if (ns <= outridx) {
        outridx = ns;
      }

      if (xx->size[1] == 1) {
        vlen = n_y->size[1];
      } else if (n_y->size[1] == 1) {
        vlen = xx->size[1];
      } else if (n_y->size[1] == xx->size[1]) {
        vlen = n_y->size[1];
      } else {
        vlen = outridx;
      }

      i = b_xt->size[0] * b_xt->size[1];
      b_xt->size[0] = static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1;
      ns = xx->size[1];
      outridx = n_y->size[1];
      if (ns <= outridx) {
        outridx = ns;
      }

      if (xx->size[1] == 1) {
        b_xt->size[1] = n_y->size[1];
      } else if (n_y->size[1] == 1) {
        b_xt->size[1] = xx->size[1];
      } else if (n_y->size[1] == xx->size[1]) {
        b_xt->size[1] = n_y->size[1];
      } else {
        b_xt->size[1] = outridx;
      }

      emxEnsureCapacity_real_T(b_xt, i, &bb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_xt, &b_gpu_xt);
      if (vlen != 0) {
        ns = (n_y->size[1] != 1);
        outridx = (xx->size[1] != 1);
        iv0 = b_xt->size[0] - 1;
        idx = b_xt->size[0];
        xx_dim0 = xx->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * ((vlen - 1) + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (xx_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
          }

          xx_dirtyOnCpu = false;
          ec_filtfilt_kernel116<<<grid, block>>>(gpu_xx, m_gpu_y, nfact, outridx,
            ns, iv0, vlen, idx, xx_dim0, b_gpu_xt);
        }
      }

      i = h_b->size[0];
      h_b->size[0] = b2->size[0];
      emxEnsureCapacity_real_T(h_b, i, &wb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(h_b, &i_gpu_b);
      i = b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel117<<<grid, block>>>(gpu_b2, i, i_gpu_b);
        g_b_dirtyOnGpu = true;
      }

      i = g_a->size[0];
      g_a->size[0] = a2->size[0];
      emxEnsureCapacity_real_T(g_a, i, &yb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(g_a, &g_gpu_a);
      i = a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel118<<<grid, block>>>(gpu_a2, i, g_gpu_a);
      }

      if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
          (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_nb +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel119<<<grid, block>>>(e_gpu_a1, b_nb, i_gpu_b);
          g_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_na +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel120<<<grid, block>>>(e_gpu_a1, c_na, g_gpu_a);
        }

        ec_filtfilt_kernel121<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(g_gpu_a);
      }

      if (g_a->size[0] > h_b->size[0]) {
        loop_ub = g_a->size[0] - h_b->size[0];
        i = h_b->size[0];
        xx_dim0 = h_b->size[0];
        h_b->size[0] += loop_ub;
        emxEnsureCapacity_real_T(h_b, xx_dim0, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_b, &i_gpu_b);
        if (loop_ub - 1 >= 0) {
          if (g_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(h_b, &i_gpu_b);
          }

          std::memset(&h_b->data[i], 0, static_cast<uint32_T>(loop_ub) * sizeof
                      (real_T));
          g_b_dirtyOnCpu = true;
        }
      }

      if (b_xt->size[1] == 0) {
        yc3->size[0] = b_xt->size[0];
        yc3->size[1] = 0;
      } else {
        window_idx_0 = static_cast<uint32_T>(h_b->size[0]);
        OH = (static_cast<uint32_T>(b_xt->size[0]) + static_cast<uint32_T>
              (h_b->size[0])) - 1U;
        d_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        vlen = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (b_xt->size[1]) + 1.0) - 1.0));
        c = b_xt->size[1] - 1;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = h_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(h_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(h_b->
          size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (h_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + h_b->size[0];
        }

        i = g_expanded->size[0] * g_expanded->size[1];
        g_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(g_expanded, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_expanded, &g_gpu_expanded);
        if (b_xt->size[1] > 2147483646) {
          outridx = MAX_int32_T;
        } else {
          outridx = b_xt->size[1] + 1;
        }

        i = g_expanded->size[0] * g_expanded->size[1];
        g_expanded->size[1] = outridx - 1;
        emxEnsureCapacity_real_T(g_expanded, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_expanded, &g_gpu_expanded);
        idx = ((static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) -
               1) * b_xt->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel122<<<grid, block>>>(idx, g_gpu_expanded);
        }

        ns = b_xt->size[0];
        i = u_y->size[0] * u_y->size[1];
        u_y->size[0] = 1;
        u_y->size[1] = b_xt->size[0];
        emxEnsureCapacity_int32_T(u_y, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(u_y, &u_gpu_y);
        u_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          u_y->data[xx_dim0 + 1] = outridx;
        }

        i = iv9->size[0];
        iv9->size[0] = u_y->size[1];
        emxEnsureCapacity_int32_T(iv9, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv9, &gpu_iv9);
        i = u_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&u_gpu_y, u_y);
          ec_filtfilt_kernel123<<<grid, block>>>(nc, u_gpu_y, i, gpu_iv9);
        }

        ns = b_xt->size[1];
        i = v_y->size[0] * v_y->size[1];
        v_y->size[0] = 1;
        v_y->size[1] = b_xt->size[1];
        emxEnsureCapacity_int32_T(v_y, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(v_y, &v_gpu_y);
        v_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          v_y->data[xx_dim0 + 1] = outridx;
        }

        i = iv10->size[0];
        iv10->size[0] = v_y->size[1];
        emxEnsureCapacity_int32_T(iv10, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv10, &gpu_iv10);
        i = v_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&v_gpu_y, v_y);
          ec_filtfilt_kernel124<<<grid, block>>>(v_gpu_y, i, gpu_iv10);
        }

        iv0 = b_xt->size[1] - 1;
        i = b_xt->size[0] - 1;
        na = g_expanded->size[0];
        idx = b_xt->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L)
          * (iv0 + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel125<<<grid, block>>>(b_gpu_xt, gpu_iv10, gpu_iv9, i,
            iv0, na, idx, g_gpu_expanded);
        }

        i = h_rows->size[0] * h_rows->size[1];
        h_rows->size[0] = 1;
        h_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(h_rows, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(h_rows, &h_gpu_rows);
        h_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          h_rows->data[xx_dim0 + 1] = outridx;
        }

        i = g_convOut->size[0] * g_convOut->size[1];
        g_convOut->size[0] = static_cast<int32_T>(u);
        g_convOut->size[1] = b_xt->size[1];
        emxEnsureCapacity_real_T(g_convOut, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_convOut, &j_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(d_x) - 1.0)) / static_cast<real_T>(d_x))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(b_xt->size[1]) + static_cast<uint32_T>(vlen)) -
                    1.0) / static_cast<real_T>(vlen))), 1U);
        r1 = dim3(static_cast<uint32_T>(d_x), static_cast<uint32_T>(vlen), 1U);
        vlen = g_convOut->size[0];
        na = g_expanded->size[0];
        i = h_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(((
          static_cast<int32_T>(u) - 1) + 1L) * (c + 1L)), &r, &r1, &grid, &block,
          1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&h_gpu_rows, h_rows);
          if (g_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_b, h_b);
          }

          ec_filtfilt_kernel126<<<grid, block>>>(g_gpu_expanded, h_gpu_rows,
            i_gpu_b, static_cast<int32_T>(u), c, i, vlen, na, j_gpu_convOut);
          g_convOut_dirtyOnGpu = true;
        }

        if ((c_zfIIR->size[0] != 0) && (c_zfIIR->size[1] != 0)) {
          if (c_zfIIR->size[0] == 1) {
            ns = g_convOut->size[1] - 1;
            i = c_zfIIR->size[1] - 1;
            vlen = g_convOut->size[0];
            na = c_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel130<<<grid, block>>>(d_gpu_zfIIR, i, ns, vlen,
                na, j_gpu_convOut);
            }
          } else if (c_zfIIR->size[1] == 1) {
            ns = g_convOut->size[1] - 1;
            i = c_zfIIR->size[0] - 1;
            vlen = g_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel129<<<grid, block>>>(d_gpu_zfIIR, i, ns, vlen,
                j_gpu_convOut);
            }
          } else if (g_convOut->size[1] == c_zfIIR->size[1]) {
            i = q_convOut->size[0] * q_convOut->size[1];
            q_convOut->size[0] = c_zfIIR->size[0];
            q_convOut->size[1] = g_convOut->size[1];
            emxEnsureCapacity_real_T(q_convOut, i, &jb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(q_convOut, &k_gpu_convOut);
            thism = g_convOut->size[1] - 1;
            i = c_zfIIR->size[0] - 1;
            vlen = q_convOut->size[0];
            idx = g_convOut->size[0];
            na = c_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel127<<<grid, block>>>(d_gpu_zfIIR, j_gpu_convOut,
                i, thism, vlen, idx, na, k_gpu_convOut);
            }

            thism = q_convOut->size[1] - 1;
            i = q_convOut->size[0] - 1;
            vlen = g_convOut->size[0];
            idx = q_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel128<<<grid, block>>>(k_gpu_convOut, i, thism,
                vlen, idx, j_gpu_convOut);
            }
          } else {
            if (g_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_convOut, &j_gpu_convOut);
            }

            if (b_zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_zfIIR, &d_gpu_zfIIR);
            }

            binary_expand_op(g_convOut, c_zfIIR);
            g_convOut_dirtyOnCpu = true;
          }
        }

        ns = g_convOut->size[1] - 1;
        idx = b_xt->size[0];
        iv0 = g_a->size[0];
        vlen = g_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (g_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_convOut, g_convOut);
          }

          ec_filtfilt_kernel131<<<grid, block>>>(g_gpu_a, ns, idx, iv0, vlen,
            j_gpu_convOut);
          g_convOut_dirtyOnCpu = false;
        }

        i = p_convOut->size[0] * p_convOut->size[1];
        p_convOut->size[0] = b_xt->size[0];
        p_convOut->size[1] = g_convOut->size[1];
        emxEnsureCapacity_real_T(p_convOut, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(p_convOut, &l_gpu_convOut);
        thism = g_convOut->size[1] - 1;
        iv0 = b_xt->size[0] - 1;
        vlen = p_convOut->size[0];
        idx = g_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (g_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_convOut, g_convOut);
          }

          ec_filtfilt_kernel132<<<grid, block>>>(j_gpu_convOut, iv0, thism, vlen,
            idx, l_gpu_convOut);
        }

        ns = b_xt->size[0];
        outridx = b_xt->size[1];
        i = yc3->size[0] * yc3->size[1];
        yc3->size[0] = b_xt->size[0];
        yc3->size[1] = b_xt->size[1];
        emxEnsureCapacity_real_T(yc3, i, &vc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(yc3, &gpu_yc3);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns *
          outridx - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel133<<<grid, block>>>(l_gpu_convOut, ns, outridx,
            gpu_yc3);
        }
      }

      ns = yc3->size[0] - 1;
      i = s_y->size[0] * s_y->size[1];
      s_y->size[0] = zi->size[0];
      s_y->size[1] = yc3->size[1];
      emxEnsureCapacity_real_T(s_y, i, &gb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(s_y, &r_gpu_y);
      loop_ub = yc3->size[1] - 1;
      i = zi->size[0] - 1;
      iv0 = s_y->size[0];
      idx = yc3->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L) *
        (loop_ub + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (zi_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_zi, zi);
        }

        ec_filtfilt_kernel134<<<grid, block>>>(gpu_yc3, ns, gpu_zi, i, loop_ub,
          iv0, idx, r_gpu_y);
        b_y_dirtyOnGpu = true;
      }

      i = j_b->size[0];
      j_b->size[0] = b2->size[0];
      emxEnsureCapacity_real_T(j_b, i, &gc_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(j_b, &j_gpu_b);
      i = b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel135<<<grid, block>>>(gpu_b2, i, j_gpu_b);
        h_b_dirtyOnGpu = true;
      }

      i = i_a->size[0];
      i_a->size[0] = a2->size[0];
      emxEnsureCapacity_real_T(i_a, i, &ic_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(i_a, &h_gpu_a);
      i = a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel136<<<grid, block>>>(gpu_a2, i, h_gpu_a);
      }

      if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
          (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_nb +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel137<<<grid, block>>>(d_gpu_a1, c_nb, j_gpu_b);
          h_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_na +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel138<<<grid, block>>>(d_gpu_a1, d_na, h_gpu_a);
        }

        ec_filtfilt_kernel139<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(h_gpu_a);
      }

      if (i_a->size[0] > j_b->size[0]) {
        loop_ub = i_a->size[0] - j_b->size[0];
        i = j_b->size[0];
        xx_dim0 = j_b->size[0];
        j_b->size[0] += loop_ub;
        emxEnsureCapacity_real_T(j_b, xx_dim0, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_b, &j_gpu_b);
        if (loop_ub - 1 >= 0) {
          if (h_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(j_b, &j_gpu_b);
          }

          std::memset(&j_b->data[i], 0, static_cast<uint32_T>(loop_ub) * sizeof
                      (real_T));
          h_b_dirtyOnCpu = true;
        }
      }

      zfSize[1] = static_cast<uint32_T>(yc3->size[1]);
      zfSize[0] = static_cast<uint32_T>(j_b->size[0] - 1);
      if (yc3->size[1] == 0) {
        e_zfIIR->size[0] = j_b->size[0] - 1;
        e_zfIIR->size[1] = 0;
      } else {
        window_idx_0 = static_cast<uint32_T>(j_b->size[0]);
        OH = (static_cast<uint32_T>(yc3->size[0]) + static_cast<uint32_T>
              (j_b->size[0])) - 1U;
        d_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        vlen = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (yc3->size[1]) + 1.0) - 1.0));
        c = yc3->size[1] - 1;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = j_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(j_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(j_b->
          size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (j_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + j_b->size[0];
        }

        i = i_expanded->size[0] * i_expanded->size[1];
        i_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(i_expanded, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_expanded, &h_gpu_expanded);
        if (yc3->size[1] > 2147483646) {
          outridx = MAX_int32_T;
        } else {
          outridx = yc3->size[1] + 1;
        }

        i = i_expanded->size[0] * i_expanded->size[1];
        i_expanded->size[1] = outridx - 1;
        emxEnsureCapacity_real_T(i_expanded, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_expanded, &h_gpu_expanded);
        idx = ((static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) -
               1) * yc3->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel140<<<grid, block>>>(idx, h_gpu_expanded);
        }

        ns = yc3->size[0];
        i = x_y->size[0] * x_y->size[1];
        x_y->size[0] = 1;
        x_y->size[1] = yc3->size[0];
        emxEnsureCapacity_int32_T(x_y, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(x_y, &w_gpu_y);
        x_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          x_y->data[xx_dim0 + 1] = outridx;
        }

        i = iv12->size[0];
        iv12->size[0] = x_y->size[1];
        emxEnsureCapacity_int32_T(iv12, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv12, &gpu_iv12);
        i = x_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&w_gpu_y, x_y);
          ec_filtfilt_kernel141<<<grid, block>>>(nc, w_gpu_y, i, gpu_iv12);
        }

        ns = yc3->size[1];
        i = y_y->size[0] * y_y->size[1];
        y_y->size[0] = 1;
        y_y->size[1] = yc3->size[1];
        emxEnsureCapacity_int32_T(y_y, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(y_y, &x_gpu_y);
        y_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          y_y->data[xx_dim0 + 1] = outridx;
        }

        i = iv13->size[0];
        iv13->size[0] = y_y->size[1];
        emxEnsureCapacity_int32_T(iv13, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv13, &gpu_iv13);
        i = y_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&x_gpu_y, y_y);
          ec_filtfilt_kernel142<<<grid, block>>>(x_gpu_y, i, gpu_iv13);
        }

        i = yc3->size[1] - 1;
        iv0 = yc3->size[0] - 1;
        na = i_expanded->size[0];
        idx = yc3->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (i + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel143<<<grid, block>>>(gpu_yc3, gpu_iv13, gpu_iv12,
            iv0, i, na, idx, h_gpu_expanded);
        }

        i = j_rows->size[0] * j_rows->size[1];
        j_rows->size[0] = 1;
        j_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(j_rows, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(j_rows, &i_gpu_rows);
        j_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          j_rows->data[xx_dim0 + 1] = outridx;
        }

        i = i_convOut->size[0] * i_convOut->size[1];
        i_convOut->size[0] = static_cast<int32_T>(u);
        i_convOut->size[1] = yc3->size[1];
        emxEnsureCapacity_real_T(i_convOut, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_convOut, &m_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(d_x) - 1.0)) / static_cast<real_T>(d_x))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(yc3->size[1]) + static_cast<uint32_T>(vlen)) -
                    1.0) / static_cast<real_T>(vlen))), 1U);
        r1 = dim3(static_cast<uint32_T>(d_x), static_cast<uint32_T>(vlen), 1U);
        vlen = i_convOut->size[0];
        na = i_expanded->size[0];
        i = j_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(((
          static_cast<int32_T>(u) - 1) + 1L) * (c + 1L)), &r, &r1, &grid, &block,
          1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&i_gpu_rows, j_rows);
          if (h_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_b, j_b);
          }

          ec_filtfilt_kernel144<<<grid, block>>>(h_gpu_expanded, i_gpu_rows,
            j_gpu_b, static_cast<int32_T>(u), c, i, vlen, na, m_gpu_convOut);
          h_convOut_dirtyOnGpu = true;
        }

        if ((s_y->size[0] != 0) && (s_y->size[1] != 0)) {
          if (s_y->size[0] == 1) {
            ns = i_convOut->size[1] - 1;
            i = s_y->size[1] - 1;
            vlen = i_convOut->size[0];
            iv0 = s_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel148<<<grid, block>>>(r_gpu_y, i, ns, vlen, iv0,
                m_gpu_convOut);
            }
          } else if (s_y->size[1] == 1) {
            ns = i_convOut->size[1] - 1;
            i = s_y->size[0] - 1;
            vlen = i_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel147<<<grid, block>>>(r_gpu_y, i, ns, vlen,
                m_gpu_convOut);
            }
          } else if (i_convOut->size[1] == s_y->size[1]) {
            i = r_convOut->size[0] * r_convOut->size[1];
            r_convOut->size[0] = s_y->size[0];
            r_convOut->size[1] = i_convOut->size[1];
            emxEnsureCapacity_real_T(r_convOut, i, &jb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(r_convOut, &n_gpu_convOut);
            thism = i_convOut->size[1] - 1;
            i = s_y->size[0] - 1;
            vlen = r_convOut->size[0];
            idx = i_convOut->size[0];
            iv0 = s_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel145<<<grid, block>>>(r_gpu_y, m_gpu_convOut, i,
                thism, vlen, idx, iv0, n_gpu_convOut);
            }

            thism = r_convOut->size[1] - 1;
            i = r_convOut->size[0] - 1;
            vlen = i_convOut->size[0];
            idx = r_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel146<<<grid, block>>>(n_gpu_convOut, i, thism,
                vlen, idx, m_gpu_convOut);
            }
          } else {
            if (h_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(i_convOut, &m_gpu_convOut);
            }

            if (b_y_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(s_y, &r_gpu_y);
            }

            binary_expand_op(i_convOut, s_y);
            h_convOut_dirtyOnCpu = true;
          }
        }

        ns = i_convOut->size[1] - 1;
        idx = yc3->size[0];
        iv0 = i_a->size[0];
        vlen = i_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (h_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_convOut, i_convOut);
          }

          ec_filtfilt_kernel149<<<grid, block>>>(h_gpu_a, ns, idx, iv0, vlen,
            m_gpu_convOut);
          h_convOut_dirtyOnCpu = false;
        }

        if (static_cast<uint32_T>(yc3->size[0]) + 1U > static_cast<uint32_T>
            (i_convOut->size[0])) {
          ns = 0;
          outridx = -1;
        } else {
          ns = yc3->size[0];
          outridx = i_convOut->size[0] - 1;
        }

        i = e_zfIIR->size[0] * e_zfIIR->size[1];
        e_zfIIR->size[0] = (outridx - ns) + 1;
        e_zfIIR->size[1] = i_convOut->size[1];
        emxEnsureCapacity_real_T(e_zfIIR, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_zfIIR, &e_gpu_zfIIR);
        thism = i_convOut->size[1] - 1;
        na = e_zfIIR->size[0];
        vlen = i_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          (((outridx - ns) + 1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (h_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_convOut, i_convOut);
          }

          h_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel150<<<grid, block>>>(m_gpu_convOut, ns, outridx,
            thism, na, vlen, e_gpu_zfIIR);
          c_zfIIR_dirtyOnGpu = true;
        }

        ns = i_convOut->size[1] - 1;
        i = i_a->size[0] - 3;
        iv0 = i_a->size[0];
        na = e_zfIIR->size[0];
        idx = yc3->size[0];
        vlen = i_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L)
          * (ns + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (h_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_convOut, i_convOut);
          }

          ec_filtfilt_kernel151<<<grid, block>>>(m_gpu_convOut, h_gpu_a, i, ns,
            iv0, na, idx, vlen, e_gpu_zfIIR);
          c_zfIIR_dirtyOnGpu = true;
        }

        i = e_zfIIR->size[0] * e_zfIIR->size[1];
        e_zfIIR->size[0] = static_cast<int32_T>(zfSize[0]);
        e_zfIIR->size[1] = static_cast<int32_T>(zfSize[1]);
        emxEnsureCapacity_real_T(e_zfIIR, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_zfIIR, &e_gpu_zfIIR);
      }

      i = k_b->size[0];
      k_b->size[0] = b2->size[0];
      emxEnsureCapacity_real_T(k_b, i, &nc_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(k_b, &k_gpu_b);
      i = b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel152<<<grid, block>>>(gpu_b2, i, k_gpu_b);
        i_b_dirtyOnGpu = true;
      }

      i = j_a->size[0];
      j_a->size[0] = a2->size[0];
      emxEnsureCapacity_real_T(j_a, i, &oc_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(j_a, &i_gpu_a);
      i = a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel153<<<grid, block>>>(gpu_a2, i, i_gpu_a);
      }

      if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
          (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_nb +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel154<<<grid, block>>>(c_gpu_a1, d_nb, k_gpu_b);
          i_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(e_na +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel155<<<grid, block>>>(c_gpu_a1, e_na, i_gpu_a);
        }

        ec_filtfilt_kernel156<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i_gpu_a);
      }

      if (j_a->size[0] > k_b->size[0]) {
        loop_ub = j_a->size[0] - k_b->size[0];
        i = k_b->size[0];
        xx_dim0 = k_b->size[0];
        k_b->size[0] += loop_ub;
        emxEnsureCapacity_real_T(k_b, xx_dim0, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_b, &k_gpu_b);
        if (loop_ub - 1 >= 0) {
          if (i_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(k_b, &k_gpu_b);
          }

          std::memset(&k_b->data[i], 0, static_cast<uint32_T>(loop_ub) * sizeof
                      (real_T));
          i_b_dirtyOnCpu = true;
        }
      }

      if (yc2->size[1] == 0) {
        yc5->size[0] = yc2->size[0];
        yc5->size[1] = 0;
      } else {
        window_idx_0 = static_cast<uint32_T>(k_b->size[0]);
        OH = (static_cast<uint32_T>(yc2->size[0]) + static_cast<uint32_T>
              (k_b->size[0])) - 1U;
        d_x = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        vlen = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (yc2->size[1]) + 1.0) - 1.0));
        c = yc2->size[1] - 1;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = k_b->size[0];
        nc = static_cast<int32_T>(std::floor(static_cast<real_T>(k_b->size[0]) /
          2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>(k_b->
          size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (k_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          outridx = MAX_int32_T;
        } else {
          outridx = static_cast<int32_T>(u) + k_b->size[0];
        }

        i = j_expanded->size[0] * j_expanded->size[1];
        j_expanded->size[0] = outridx - 1;
        emxEnsureCapacity_real_T(j_expanded, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_expanded, &i_gpu_expanded);
        if (yc2->size[1] > 2147483646) {
          outridx = MAX_int32_T;
        } else {
          outridx = yc2->size[1] + 1;
        }

        i = j_expanded->size[0] * j_expanded->size[1];
        j_expanded->size[1] = outridx - 1;
        emxEnsureCapacity_real_T(j_expanded, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_expanded, &i_gpu_expanded);
        idx = ((static_cast<int32_T>(u) + static_cast<int32_T>(window_idx_0)) -
               1) * yc2->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel157<<<grid, block>>>(idx, i_gpu_expanded);
        }

        ns = yc2->size[0];
        i = ab_y->size[0] * ab_y->size[1];
        ab_y->size[0] = 1;
        ab_y->size[1] = yc2->size[0];
        emxEnsureCapacity_int32_T(ab_y, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(ab_y, &y_gpu_y);
        ab_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          ab_y->data[xx_dim0 + 1] = outridx;
        }

        i = iv14->size[0];
        iv14->size[0] = ab_y->size[1];
        emxEnsureCapacity_int32_T(iv14, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv14, &gpu_iv14);
        i = ab_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&y_gpu_y, ab_y);
          ec_filtfilt_kernel158<<<grid, block>>>(nc, y_gpu_y, i, gpu_iv14);
        }

        ns = yc2->size[1];
        i = cb_y->size[0] * cb_y->size[1];
        cb_y->size[0] = 1;
        cb_y->size[1] = yc2->size[1];
        emxEnsureCapacity_int32_T(cb_y, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cb_y, &ab_gpu_y);
        cb_y->data[0] = 1;
        outridx = 1;
        for (xx_dim0 = 0; xx_dim0 <= ns - 2; xx_dim0++) {
          outridx++;
          cb_y->data[xx_dim0 + 1] = outridx;
        }

        i = iv15->size[0];
        iv15->size[0] = cb_y->size[1];
        emxEnsureCapacity_int32_T(iv15, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv15, &gpu_iv15);
        i = cb_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&ab_gpu_y, cb_y);
          ec_filtfilt_kernel159<<<grid, block>>>(ab_gpu_y, i, gpu_iv15);
        }

        iv0 = yc2->size[1] - 1;
        i = yc2->size[0] - 1;
        na = j_expanded->size[0];
        idx = yc2->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i + 1L)
          * (iv0 + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel160<<<grid, block>>>(gpu_yc2, gpu_iv15, gpu_iv14, i,
            iv0, na, idx, i_gpu_expanded);
        }

        i = k_rows->size[0] * k_rows->size[1];
        k_rows->size[0] = 1;
        k_rows->size[1] = static_cast<int32_T>(window_idx_0);
        emxEnsureCapacity_int32_T(k_rows, i, &pb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(k_rows, &k_gpu_rows);
        k_rows->data[0] = 0;
        outridx = 0;
        for (xx_dim0 = 0; xx_dim0 <= thism - 2; xx_dim0++) {
          outridx++;
          k_rows->data[xx_dim0 + 1] = outridx;
        }

        i = j_convOut->size[0] * j_convOut->size[1];
        j_convOut->size[0] = static_cast<int32_T>(u);
        j_convOut->size[1] = yc2->size[1];
        emxEnsureCapacity_real_T(j_convOut, i, &ob_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_convOut, &p_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(d_x) - 1.0)) / static_cast<real_T>(d_x))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(yc2->size[1]) + static_cast<uint32_T>(vlen)) -
                    1.0) / static_cast<real_T>(vlen))), 1U);
        r1 = dim3(static_cast<uint32_T>(d_x), static_cast<uint32_T>(vlen), 1U);
        vlen = j_convOut->size[0];
        na = j_expanded->size[0];
        i = k_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(((
          static_cast<int32_T>(u) - 1) + 1L) * (c + 1L)), &r, &r1, &grid, &block,
          1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&k_gpu_rows, k_rows);
          if (i_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&k_gpu_b, k_b);
          }

          ec_filtfilt_kernel161<<<grid, block>>>(i_gpu_expanded, k_gpu_rows,
            k_gpu_b, static_cast<int32_T>(u), c, i, vlen, na, p_gpu_convOut);
          j_convOut_dirtyOnGpu = true;
        }

        if ((e_zfIIR->size[0] != 0) && (e_zfIIR->size[1] != 0)) {
          if (e_zfIIR->size[0] == 1) {
            ns = j_convOut->size[1] - 1;
            i = e_zfIIR->size[1] - 1;
            vlen = j_convOut->size[0];
            na = e_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel165<<<grid, block>>>(e_gpu_zfIIR, i, ns, vlen,
                na, p_gpu_convOut);
            }
          } else if (e_zfIIR->size[1] == 1) {
            ns = j_convOut->size[1] - 1;
            i = e_zfIIR->size[0] - 1;
            vlen = j_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel164<<<grid, block>>>(e_gpu_zfIIR, i, ns, vlen,
                p_gpu_convOut);
            }
          } else if (j_convOut->size[1] == e_zfIIR->size[1]) {
            i = t_convOut->size[0] * t_convOut->size[1];
            t_convOut->size[0] = e_zfIIR->size[0];
            t_convOut->size[1] = j_convOut->size[1];
            emxEnsureCapacity_real_T(t_convOut, i, &jb_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(t_convOut, &q_gpu_convOut);
            thism = j_convOut->size[1] - 1;
            i = e_zfIIR->size[0] - 1;
            vlen = t_convOut->size[0];
            idx = j_convOut->size[0];
            na = e_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel162<<<grid, block>>>(e_gpu_zfIIR, p_gpu_convOut,
                i, thism, vlen, idx, na, q_gpu_convOut);
            }

            thism = t_convOut->size[1] - 1;
            i = t_convOut->size[0] - 1;
            vlen = j_convOut->size[0];
            idx = t_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((i +
              1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel163<<<grid, block>>>(q_gpu_convOut, i, thism,
                vlen, idx, p_gpu_convOut);
            }
          } else {
            if (j_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(j_convOut, &p_gpu_convOut);
            }

            if (c_zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_zfIIR, &e_gpu_zfIIR);
            }

            binary_expand_op(j_convOut, e_zfIIR);
            j_convOut_dirtyOnCpu = true;
          }
        }

        ns = j_convOut->size[1] - 1;
        idx = yc2->size[0];
        iv0 = j_a->size[0];
        vlen = j_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (j_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&p_gpu_convOut, j_convOut);
          }

          ec_filtfilt_kernel166<<<grid, block>>>(i_gpu_a, ns, idx, iv0, vlen,
            p_gpu_convOut);
          j_convOut_dirtyOnCpu = false;
        }

        i = s_convOut->size[0] * s_convOut->size[1];
        s_convOut->size[0] = yc2->size[0];
        s_convOut->size[1] = j_convOut->size[1];
        emxEnsureCapacity_real_T(s_convOut, i, &jb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(s_convOut, &r_gpu_convOut);
        thism = j_convOut->size[1] - 1;
        iv0 = yc2->size[0] - 1;
        vlen = s_convOut->size[0];
        idx = j_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (thism + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (j_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&p_gpu_convOut, j_convOut);
          }

          ec_filtfilt_kernel167<<<grid, block>>>(p_gpu_convOut, iv0, thism, vlen,
            idx, r_gpu_convOut);
        }

        ns = yc2->size[0];
        outridx = yc2->size[1];
        i = yc5->size[0] * yc5->size[1];
        yc5->size[0] = yc2->size[0];
        yc5->size[1] = yc2->size[1];
        emxEnsureCapacity_real_T(yc5, i, &wc_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(yc5, &gpu_yc5);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns *
          outridx - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel168<<<grid, block>>>(r_gpu_convOut, ns, outridx,
            gpu_yc5);
        }
      }

      i = xx->size[0] * xx->size[1];
      xx->size[0] = yc5->size[0];
      xx->size[1] = yc5->size[1];
      emxEnsureCapacity_real_T(xx, i, &qc_emlrtRTEI);
      if (!xx_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(xx, &gpu_xx);
      }

      i = yc5->size[1] - 1;
      iv0 = yc5->size[0] - 1;
      xx_dim0 = xx->size[0];
      idx = yc5->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 + 1L)
        * (i + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (xx_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
        }

        ec_filtfilt_kernel169<<<grid, block>>>(gpu_yc5, iv0, i, xx_dim0, idx,
          gpu_xx);
        xx_dirtyOnCpu = false;
        xx_dirtyOnGpu = true;
      }

      i = xx->size[0] * xx->size[1];
      xx->size[0] = static_cast<int32_T>(sz[0]);
      xx->size[1] = static_cast<int32_T>(sz[1]);
      emxEnsureCapacity_real_T(xx, i, &v_emlrtRTEI);
      if (!xx_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(xx, &gpu_xx);
      }
    }

    if (x->size[0] == 1) {
      i = b_xx->size[0] * b_xx->size[1];
      b_xx->size[0] = xx->size[1];
      b_xx->size[1] = xx->size[0];
      emxEnsureCapacity_real_T(b_xx, i, &r_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_xx, &b_gpu_xx);
      loop_ub = xx->size[0] - 1;
      iv0 = xx->size[1] - 1;
      xx_dim0 = b_xx->size[0];
      i = xx->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 + 1L)
        * (loop_ub + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (xx_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
        }

        xx_dirtyOnCpu = false;
        ec_filtfilt_kernel268<<<grid, block>>>(gpu_xx, iv0, loop_ub, xx_dim0, i,
          b_gpu_xx);
      }

      i = xx->size[0] * xx->size[1];
      xx->size[0] = b_xx->size[0];
      xx->size[1] = b_xx->size[1];
      emxEnsureCapacity_real_T(xx, i, &u_emlrtRTEI);
      if (!xx_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(xx, &gpu_xx);
      }

      loop_ub = b_xx->size[0] * b_xx->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(loop_ub +
        1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (xx_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_xx, xx);
        }

        ec_filtfilt_kernel269<<<grid, block>>>(b_gpu_xx, loop_ub, gpu_xx);
        xx_dirtyOnGpu = true;
      }
    }
  }

  emxFree_real_T(&u_convOut);
  emxFree_real_T(&t_convOut);
  emxFree_real_T(&s_convOut);
  emxFree_real_T(&r_convOut);
  emxFree_real_T(&q_convOut);
  emxFree_real_T(&p_convOut);
  emxFree_real_T(&o_convOut);
  emxFree_real_T(&n_convOut);
  emxFree_real_T(&m_convOut);
  emxFree_real_T(&b_xx);
  emxFree_real_T(&n_b);
  emxFree_real_T(&l_convOut);
  emxFree_int32_T(&m_rows);
  emxFree_int32_T(&iv17);
  emxFree_int32_T(&eb_y);
  emxFree_real_T(&l_expanded);
  emxFree_real_T(&l_a);
  emxFree_real_T(&m_b);
  emxFree_real_T(&f_zfIIR);
  emxFree_real_T(&k_convOut);
  emxFree_int32_T(&l_rows);
  emxFree_int32_T(&iv16);
  emxFree_real_T(&j_convOut);
  emxFree_int32_T(&db_y);
  emxFree_real_T(&k_expanded);
  emxFree_int32_T(&k_rows);
  emxFree_int32_T(&iv15);
  emxFree_real_T(&e_zfIIR);
  emxFree_int32_T(&cb_y);
  emxFree_int32_T(&iv14);
  emxFree_real_T(&i_convOut);
  emxFree_real_T(&k_a);
  emxFree_real_T(&l_b);
  emxFree_real_T(&bb_y);
  emxFree_int32_T(&ab_y);
  emxFree_real_T(&j_expanded);
  emxFree_int32_T(&j_rows);
  emxFree_int32_T(&iv13);
  emxFree_real_T(&yc5);
  emxFree_real_T(&h_convOut);
  emxFree_int32_T(&y_y);
  emxFree_int32_T(&iv12);
  emxFree_int32_T(&c_counts);
  emxFree_real_T(&g_convOut);
  emxFree_int32_T(&i_rows);
  emxFree_real_T(&d_zfIIR);
  emxFree_int32_T(&x_y);
  emxFree_int32_T(&iv11);
  emxFree_real_T(&j_a);
  emxFree_real_T(&i_expanded);
  emxFree_real_T(&k_b);
  emxFree_int32_T(&h_rows);
  emxFree_int32_T(&b_counts);
  emxFree_int32_T(&counts);
  emxFree_int32_T(&iv10);
  emxFree_int32_T(&w_y);
  emxFree_real_T(&h_expanded);
  emxFree_real_T(&f_convOut);
  emxFree_real_T(&c_zfIIR);
  emxFree_real_T(&b_outBuff);
  emxFree_real_T(&e_convOut);
  emxFree_int32_T(&v_y);
  emxFree_int32_T(&iv9);
  emxFree_int32_T(&g_rows);
  emxFree_real_T(&outBuff);
  emxFree_int32_T(&f_rows);
  emxFree_int32_T(&iv7);
  emxFree_int32_T(&u_y);
  emxFree_int32_T(&d_y_rowidx);
  emxFree_int32_T(&d_y_colidx);
  emxFree_int32_T(&iv6);
  emxFree_real_T(&g_expanded);
  emxFree_real_T(&d_y_d);
  emxFree_real_T(&i_a);
  emxFree_real_T(&j_b);
  emxFree_real_T(&d_convOut);
  emxFree_real_T(&h_a);
  emxFree_int32_T(&t_y);
  emxFree_real_T(&s_y);
  emxFree_real_T(&i_b);
  emxFree_real_T(&f_expanded);
  emxFree_int32_T(&r_y);
  emxFree_real_T(&e_expanded);
  emxFree_real_T(&yc3);
  emxFree_int32_T(&e_rows);
  emxFree_real_T(&b_zfIIR);
  emxFree_int32_T(&c_y_rowidx);
  emxFree_int32_T(&b_y_rowidx);
  emxFree_int32_T(&c_y_colidx);
  emxFree_int32_T(&b_y_colidx);
  emxFree_real_T(&c_y_d);
  emxFree_real_T(&b_y_d);
  emxFree_int32_T(&iv5);
  emxFree_int32_T(&q_y);
  emxFree_real_T(&g_a);
  emxFree_int32_T(&iv4);
  emxFree_real_T(&c_convOut);
  emxFree_real_T(&h_b);
  emxFree_real_T(&f_a);
  emxFree_real_T(&e_a);
  emxFree_real_T(&g_b);
  emxFree_real_T(&f_b);
  emxFree_int32_T(&d_rows);
  emxFree_real_T(&p_y);
  emxFree_int32_T(&o_y);
  emxFree_real_T(&d_expanded);
  emxFree_int32_T(&iv3);
  emxFree_real_T(&zfIIR);
  emxFree_real_T(&dv3);
  emxFree_real_T(&n_y);
  emxFree_real_T(&yc2);
  emxFree_int32_T(&m_y);
  emxFree_int32_T(&iv2);
  emxFree_int32_T(&b_t);
  emxFree_real_T(&b_convOut);
  emxFree_real_T(&convOut);
  emxFree_int32_T(&l_y);
  emxFree_int32_T(&t);
  emxFree_real_T(&c_expanded);
  emxFree_int32_T(&c_rows);
  emxFree_int32_T(&b_rows);
  emxFree_int32_T(&iv1);
  emxFree_int32_T(&sortedIndices);
  emxFree_real_T(&d_a);
  emxFree_int32_T(&iv);
  emxFree_real_T(&e_b);
  emxFree_int32_T(&cidxInt);
  emxFree_int32_T(&k_y);
  emxFree_real_T(&b_expanded);
  emxFree_int32_T(&j_y);
  emxFree_int32_T(&ridxInt);
  emxFree_real_T(&expanded);
  emxFree_int32_T(&y_rowidx);
  emxFree_int32_T(&y_colidx);
  emxFree_real_T(&y_d);
  emxFree_real_T(&rhs);
  emxFree_real_T(&c_a);
  emxFree_real_T(&d_b);
  emxFree_real_T(&i_y);
  emxFree_int8_T(&vals);
  emxFree_real_T(&b_xt);
  emxFree_real_T(&b_a);
  emxFree_real_T(&c_b);
  emxFree_real_T(&h_y);
  emxFree_real_T(&ytemp);
  emxFree_real_T(&a);
  emxFree_int32_T(&cols);
  emxFree_real_T(&b_b);
  emxFree_real_T(&g_y);
  emxFree_real_T(&f_y);
  emxFree_int32_T(&e_y);
  emxFree_real_T(&xt);
  emxFree_boolean_T(&c_x);
  emxFree_int32_T(&ii);
  emxFree_int32_T(&d_y);
  emxFree_real_T(&maxCoefNum);
  emxFree_int32_T(&rows);
  emxFree_int32_T(&c_y);
  emxFree_boolean_T(&b_x);
  emxFree_real_T(&b_y);
  emxFree_uint32_T(&nZeroLastDen);
  emxFree_int32_T(&y);
  emxFree_real_T(&b1);
  emxFree_real_T(&a2);
  emxFree_real_T(&b2);
  emxFree_real_T(&zi);
  emxFree_real_T(&b);

  //  coder.gpu.kernel();
  //  for ch = 1:nCh
  //     xx(:,ch) = filtfilt(coef,1,x(:,ch));
  //  end
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (xx_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(xx, &gpu_xx);
  }

  gpuEmxFree_real_T(&gpu_xx);
  mwCudaFree(gpu_i);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_coef);
  gpuEmxFree_real_T(&gpu_b);
  gpuEmxFree_real_T(&gpu_b2);
  gpuEmxFree_real_T(&gpu_b1);
  gpuEmxFree_real_T(&b_gpu_b);
  gpuEmxFree_real_T(&gpu_a2);
  gpuEmxFree_real_T(&gpu_y);
  mwCudaFree(gpu_a1);
  mwCudaFree(b_gpu_a1);
  mwCudaFree(c_gpu_a1);
  mwCudaFree(d_gpu_a1);
  mwCudaFree(e_gpu_a1);
  mwCudaFree(gpu_d1);
  gpuEmxFree_int32_T(&b_gpu_y);
  gpuEmxFree_real_T(&gpu_maxCoefNum);
  gpuEmxFree_int32_T(&c_gpu_y);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_boolean_T(&b_gpu_x);
  gpuEmxFree_real_T(&gpu_ytemp);
  gpuEmxFree_real_T(&gpu_xt);
  gpuEmxFree_real_T(&d_gpu_y);
  gpuEmxFree_real_T(&gpu_zi);
  gpuEmxFree_real_T(&e_gpu_y);
  gpuEmxFree_boolean_T(&c_gpu_x);
  gpuEmxFree_real_T(&f_gpu_y);
  gpuEmxFree_int32_T(&g_gpu_y);
  gpuEmxFree_real_T(&c_gpu_b);
  gpuEmxFree_real_T(&d_gpu_b);
  gpuEmxFree_int32_T(&gpu_cols);
  gpuEmxFree_real_T(&gpu_a);
  gpuEmxFree_int32_T(&h_gpu_y);
  gpuEmxFree_real_T(&b_gpu_a);
  gpuEmxFree_int32_T(&gpu_ii);
  gpuEmxFree_uint32_T(&gpu_nZeroLastDen);
  mwCudaFree(&(*gpu_a0)[0]);
  gpuEmxFree_real_T(&b_gpu_xt);
  gpuEmxFree_real_T(&i_gpu_y);
  gpuEmxFree_real_T(&e_gpu_b);
  mwCudaFree(&(*gpu_rhs)[0]);
  gpuEmxFree_int8_T(&gpu_vals);
  mwCudaFree(&(*gpu_I)[0]);
  gpuEmxFree_real_T(&gpu_expanded);
  gpuEmxFree_real_T(&b_gpu_expanded);
  mwCudaFree(&(*gpu_A)[0]);
  gpuEmxFree_real_T(&c_gpu_a);
  mwCudaFree(&(*gpu_Y)[0]);
  mwCudaFree(&(*gpu_zfSize)[0]);
  gpuEmxFree_int32_T(&j_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&k_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_real_T(&b_gpu_rhs);
  gpuEmxFree_real_T(&f_gpu_b);
  gpuEmxFree_int32_T(&gpu_ridxInt);
  gpuEmxFree_real_T(&d_gpu_a);
  gpuEmxFree_int32_T(&gpu_cidxInt);
  gpuEmxFree_int32_T(&b_gpu_rows);
  gpuEmxFree_real_T(&gpu_convOut);
  gpuEmxFree_int32_T(&c_gpu_rows);
  gpuEmxFree_real_T(&b_gpu_convOut);
  gpuEmxFree_real_T(&c_gpu_expanded);
  gpuEmxFree_int32_T(&gpu_sortedIndices);
  gpuEmxFree_real_T(&gpu_dv3);
  gpuEmxFree_int32_T(&gpu_t);
  gpuEmxFree_real_T(&gpu_zfIIR);
  gpuEmxFree_int32_T(&l_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv2);
  gpuEmxFree_int32_T(&b_gpu_t);
  gpuEmxFree_real_T(&m_gpu_y);
  gpuEmxFree_real_T(&g_gpu_b);
  gpuEmxFree_real_T(&n_gpu_y);
  gpuEmxFree_real_T(&d_gpu_expanded);
  gpuEmxFree_int32_T(&o_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv3);
  gpuEmxFree_real_T(&e_gpu_a);
  gpuEmxFree_real_T(&h_gpu_b);
  gpuEmxFree_real_T(&f_gpu_a);
  gpuEmxFree_int32_T(&gpu_y_rowidx);
  gpuEmxFree_real_T(&gpu_y_d);
  gpuEmxFree_real_T(&i_gpu_b);
  gpuEmxFree_int32_T(&p_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv4);
  gpuEmxFree_real_T(&g_gpu_a);
  gpuEmxFree_real_T(&e_gpu_expanded);
  gpuEmxFree_int32_T(&d_gpu_rows);
  gpuEmxFree_real_T(&c_gpu_convOut);
  gpuEmxFree_int32_T(&q_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv5);
  gpuEmxFree_real_T(&f_gpu_expanded);
  gpuEmxFree_real_T(&gpu_yc3);
  gpuEmxFree_real_T(&r_gpu_y);
  gpuEmxFree_int32_T(&s_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv7);
  gpuEmxFree_int32_T(&b_gpu_y_rowidx);
  gpuEmxFree_real_T(&b_gpu_y_d);
  gpuEmxFree_int32_T(&c_gpu_y_rowidx);
  gpuEmxFree_real_T(&c_gpu_y_d);
  gpuEmxFree_int32_T(&gpu_y_colidx);
  gpuEmxFree_int32_T(&b_gpu_y_colidx);
  gpuEmxFree_real_T(&d_gpu_convOut);
  gpuEmxFree_real_T(&j_gpu_b);
  gpuEmxFree_int32_T(&t_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv6);
  gpuEmxFree_real_T(&gpu_outBuff);
  gpuEmxFree_int32_T(&d_gpu_y_rowidx);
  gpuEmxFree_real_T(&d_gpu_y_d);
  gpuEmxFree_real_T(&b_gpu_zfIIR);
  gpuEmxFree_real_T(&g_gpu_expanded);
  gpuEmxFree_real_T(&b_gpu_outBuff);
  gpuEmxFree_int32_T(&c_gpu_y_colidx);
  gpuEmxFree_real_T(&h_gpu_a);
  gpuEmxFree_int32_T(&e_gpu_rows);
  gpuEmxFree_real_T(&e_gpu_convOut);
  gpuEmxFree_int32_T(&f_gpu_rows);
  gpuEmxFree_real_T(&f_gpu_convOut);
  gpuEmxFree_int32_T(&u_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv9);
  gpuEmxFree_int32_T(&g_gpu_rows);
  gpuEmxFree_real_T(&g_gpu_convOut);
  gpuEmxFree_int32_T(&gpu_counts);
  gpuEmxFree_int32_T(&b_gpu_counts);
  gpuEmxFree_real_T(&k_gpu_b);
  gpuEmxFree_real_T(&h_gpu_convOut);
  gpuEmxFree_real_T(&c_gpu_zfIIR);
  gpuEmxFree_real_T(&i_gpu_a);
  gpuEmxFree_int32_T(&c_gpu_counts);
  gpuEmxFree_real_T(&d_gpu_zfIIR);
  gpuEmxFree_int32_T(&v_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv10);
  gpuEmxFree_real_T(&h_gpu_expanded);
  gpuEmxFree_real_T(&gpu_yc5);
  gpuEmxFree_real_T(&l_gpu_b);
  gpuEmxFree_real_T(&b_gpu_xx);
  gpuEmxFree_int32_T(&w_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv12);
  gpuEmxFree_real_T(&j_gpu_a);
  gpuEmxFree_real_T(&i_gpu_convOut);
  gpuEmxFree_real_T(&i_gpu_expanded);
  gpuEmxFree_int32_T(&h_gpu_rows);
  gpuEmxFree_real_T(&j_gpu_convOut);
  gpuEmxFree_real_T(&gpu_yc2);
  gpuEmxFree_int32_T(&x_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv13);
  gpuEmxFree_int32_T(&y_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv14);
  gpuEmxFree_real_T(&j_gpu_expanded);
  gpuEmxFree_real_T(&k_gpu_convOut);
  gpuEmxFree_real_T(&l_gpu_convOut);
  gpuEmxFree_int32_T(&ab_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv15);
  gpuEmxFree_int32_T(&bb_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv11);
  gpuEmxFree_int32_T(&i_gpu_rows);
  gpuEmxFree_real_T(&m_gpu_convOut);
  gpuEmxFree_real_T(&n_gpu_convOut);
  gpuEmxFree_int32_T(&j_gpu_rows);
  gpuEmxFree_real_T(&o_gpu_convOut);
  gpuEmxFree_int32_T(&k_gpu_rows);
  gpuEmxFree_real_T(&p_gpu_convOut);
  gpuEmxFree_real_T(&e_gpu_zfIIR);
  gpuEmxFree_real_T(&cb_gpu_y);
  gpuEmxFree_real_T(&m_gpu_b);
  gpuEmxFree_real_T(&q_gpu_convOut);
  gpuEmxFree_real_T(&r_gpu_convOut);
  gpuEmxFree_real_T(&k_gpu_a);
  gpuEmxFree_real_T(&k_gpu_expanded);
  gpuEmxFree_int32_T(&db_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv16);
  gpuEmxFree_int32_T(&l_gpu_rows);
  gpuEmxFree_real_T(&s_gpu_convOut);
  gpuEmxFree_real_T(&f_gpu_zfIIR);
  gpuEmxFree_real_T(&n_gpu_b);
  gpuEmxFree_real_T(&l_gpu_a);
  gpuEmxFree_real_T(&l_gpu_expanded);
  gpuEmxFree_int32_T(&eb_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv17);
  gpuEmxFree_int32_T(&m_gpu_rows);
  gpuEmxFree_real_T(&t_gpu_convOut);
  gpuEmxFree_real_T(&u_gpu_convOut);
}

void ec_filtfilt_api(const mxArray * const prhs[2], const mxArray *plhs[1])
{
  emxArray_real_T *coef;
  emxArray_real_T *x;
  emxArray_real_T *xx;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  // Marshall function inputs
  emxInit_real_T(&x, 2, &ee_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  emxInit_real_T(&coef, 2, &ee_emlrtRTEI, true);
  coef->canFreeData = false;
  b_emlrt_marshallIn(emlrtAlias(prhs[1]), "coef", coef);

  // Invoke the target function
  emxInit_real_T(&xx, 2, &ee_emlrtRTEI, true);
  ec_filtfilt(x, coef, xx);
  emxFree_real_T(&coef);
  emxFree_real_T(&x);

  // Marshall function outputs
  xx->canFreeData = false;
  plhs[0] = emlrt_marshallOut(xx);
  emxFree_real_T(&xx);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

void ec_filtfilt_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void ec_filtfilt_initialize()
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
    ec_filtfilt_once();
  }

  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void ec_filtfilt_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode), (char_T *)
                       cudaGetErrorString(errCode), (char_T *)cudaGetErrorName
                       (errCode), (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }

  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  mwMemoryManagerTerminate();
}

// End of code generation (ec_filtfilt.cu)
